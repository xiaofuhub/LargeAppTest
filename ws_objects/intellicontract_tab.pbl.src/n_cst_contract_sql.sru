$PBExportHeader$n_cst_contract_sql.sru
$PBExportComments$[intelliContract_tab] Used to manage the contract database updates
forward
global type n_cst_contract_sql from nonvisualobject
end type
end forward

global type n_cst_contract_sql from nonvisualobject autoinstantiate
end type

type prototypes
FUNCTION ulong SetCapture(ulong a) LIBRARY "user32.dll"
FUNCTION boolean ReleaseCapture() LIBRARY "user32.dll"
end prototypes

type variables


long il_database_version /* the current database version*/
string ls_sql_statments[]
CONSTANT STRING NEW_LINE  = '~r~n'
N_ds lds_db_control

BOOLEAN IB_SHOW_UPDATE_WINDOW /* Display the progress window*/

n_cst_string inv_string
datastore ids_temp

int ii_num = 1

//05/06/2007 by jervis
string is_update_dataobject[]
datetime idt_update_date[]

n_logservice   inv_logservice
end variables

forward prototypes
public function integer of_start_update ()
protected function integer of_add_audit ()
private function integer of_asa_0_changes ()
private function integer of_create_asa_database ()
private function integer of_set_cpt_codes ()
private function integer of_init_data ()
private function integer of_init ()
private function integer of_execute_sql ()
private function integer of_create_mss_database ()
public function integer of_drop_frn_keys ()
public function integer of_add_fgn_keys ()
public function integer of_asa_1_changes ()
public function integer of_report_sql ()
public function integer of_asa_2_changes ()
public function integer of_asa_3_changes ()
public function integer of_asa_4_changes ()
public function integer of_asa_5_changes ()
public subroutine of_asa_6_changes ()
public subroutine of_asa_7_changes ()
public function integer of_asa_9_changes ()
public function integer of_asa_10_changes ()
public subroutine of_asa_11_changes ()
public function integer of_appeon1_changes ()
public subroutine of_appeon2_changes ()
public function integer of_appeon_sqlserver_update1 ()
public subroutine of_appeon_global_search ()
public subroutine of_appeon_create_fulltext_catalog ()
public function integer of_appeon3_changes ()
public function integer of_getproperties (datastore ids_terget, ref datastore ids_properties)
public function string of_setproperties (ref datastore ads_source, ref datastore ads_properties)
public subroutine of_appeon2_changes_bak0321 ()
public function integer of_appeon4_changes ()
public function integer of_equal (string as_string1, string as_string2)
public function integer of_register_screen (string as_dataobject, date ad_date)
public subroutine of_appeon_forceupdate_screen ()
public function string of_get_view_action (string as_view_name)
public function integer of_appeon5_changes ()
public function string of_addobjects (ref datastore ads_source, datastore ads_target)
public function long of_pos (string as_source, string as_target, long al_start)
public function string of_set_view_sql (string as_viewname, string as_tag)
public function integer of_get_image_file (long al_image_id, long al_ctx_id, long al_version, long al_doc_id, decimal adc_version_new)
public function integer of_update_view_v6_1 ()
public function integer of_update_view_v6_2 ()
public function integer of_update_view_v7_1 ()
public subroutine of_update_screen ()
public function integer of_get_objectpro (datastore ids_terget, ref datastore ids_properties, string as_objname)
public function string of_update_object (datastore ads_target, datastore ads_source, datastore ads_properties)
public function string of_set_objectpro (ref datastore ads_source, ref datastore ads_properties)
public function integer of_get_objpos (string as_dwsyntax, string as_objtype, string as_objname, ref long al_spos, ref long al_epos)
public subroutine of_appeon2_changes (datastore ads_upgrade, boolean ab_upgradeall)
end prototypes

public function integer of_start_update ();/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	:  il_database_version = 0 :: inital database creation  
**==================================================================================================================
**  Created By	: Michael B. Skinner 10 February 2006  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

Long ll_i


setpointer(hourglass!)
SetCapture(Handle(this)) // keeps the hourglass solid
///////////////////////////////////////////////////////////////////////////////////////////////////////////
// is the contract module available
///////////////////////////////////////////////////////////////////////////////////////////////////////////

SELECT icred_settings.set_cont  
INTO  :ll_i  
FROM icred_settings  ;

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 2006-08-23 By: Rodger Wu (Contract)
//$<reason> Comment out following script because table structure and data 
//$<reason> related to contract must update after Contract Module
//$<reason> modification, or whole IntelliCred/App can not work correctly.

/* if ll_i = 0 or isnull(ll_i) then return 0 */

//---------------------------- APPEON END ----------------------------


of_init()

///////////////////////////////////////////////////////////////////////////////////////////////////////////
// Check to see what version of the database we are on 
///////////////////////////////////////////////////////////////////////////////////////////////////////////



if lds_db_control.rowcount() < 1 then 
	lds_db_control.insertrow(1)
	lds_db_control.SetItem(1,'db_control',1)
	
else 
	il_database_version = lds_db_control.GetItemNumber(1,'contract_database_version')
end if 

if isnull(il_database_version  ) then il_database_version = 0

///////////////////////////////////////////////////////////////////////////////////////////////////////////
// Ceate the database 
///////////////////////////////////////////////////////////////////////////////////////////////////////////

IB_SHOW_UPDATE_WINDOW = TRUE
//Start Code Change ---- 11.09.2006 #1 maha both of these need to be run
CHOOSE CASE gs_dbtype
	CASE "ASA"
		OF_CREATE_ASA_DATABASE()
	CASE "SQL"
		OF_CREATE_MSS_DATABASE()
END CHOOSE 
//End Code Change---11.09.2006
///////////////////////////////////////////////////////////////////////////////////////////////////////////
// Set up the data
///////////////////////////////////////////////////////////////////////////////////////////////////////////

choose case il_database_version
	case 0
		
	case 1
	case 2
	case 3
	case 4
	case 5
end choose 

of_execute_sql( )

ReleaseCapture()

return 0
end function

protected function integer of_add_audit ();


Choose Case gs_dbType
	Case 'ASA'
		ls_sql_statments[upperbound(ls_sql_statments) + 1] = "ALTER TABLE sys_tables  MODIFY table_name_allias  CHAR( 100) null;"
	Case 'SQL'
		ls_sql_statments[upperbound(ls_sql_statments) + 1] = "ALTER TABLE sys_tables  alter column table_name_allias  VARCHAR( 100) null;"
End Choose


ls_sql_statments[upperbound(ls_sql_statments) + 1] = "commit;"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from sys_tables where table_id between 1000 and 1060;"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from sys_fields where table_id between 1000 and 1060;"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "commit;"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_tables(table_id,table_name,table_name_allias) VALUES (1000,'d_contract_search_details','IntelliContract/Search/Search Criteria'); " 
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_tables(table_id,table_name,table_name_allias) VALUES (1001,'d_contract_search','IntelliContract/Search/Search Criteria'); " 
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1001,20000,100,'app_facility','N',873,'Company Name:'); " 
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1001,20001,100,'product_name','C',873,'Product Name:'); " 
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1001,20002,110,'effective_date','D',873,'Effective Date:'); " 
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1001,20003,110,'expriation_date','D',873,'Expriation Date:'); " 
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1001,20004,60,'status','N',873,'Status:'); " 
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1001,20005,60,'group_multi_loc_id','N',873,'Contracted Entity:'); " 
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1001,20006,70,'ctx_id','I',562,'Contract ID:'); " 
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1001,20007,70,'category','N',873,'Category:'); " 
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1001,20008,20,'facility_id','I',873,'Company Name:'); " 
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1001,20009,20,'product_type','N',873,'Product Type:'); " 
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1001,20010,90,'group_id','N',562,'Group ID'); " 
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_tables(table_id,table_name,table_name_allias) VALUES (1002,'d_contract_det_custom','IntelliContract/Detail/Custom Data'); " 
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1002,20011,10,'custom_1','C',1111,'Custom 1:'); " 
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1002,20012,10,'custom_2','C',1111,'Custom 2:'); " 
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1002,20013,20,'custom_3','C',1111,'Custom 3:'); " 
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1002,20014,20,'custom_4','C',1111,'Custom 4:'); " 
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1002,20015,30,'custom_5','C',1111,'Custom 5:'); " 
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1002,20016,30,'custom_6','C',1111,'Custom 6:'); " 
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1002,20017,40,'custom_7','C',1111,'Custom 7:'); " 
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1002,20018,40,'custom_8','C',1111,'Custom 8:'); " 
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1002,20019,50,'custom_9','C',1111,'Custom 9:'); " 
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1002,20020,50,'custom_10','C',1111,'Custom 10:'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_tables(table_id,table_name,table_name_allias) VALUES (1003,'d_contract_det_master','IntelliContract/Detail/Contract Detail'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20021,10,'category','N',727,'Category'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20022,10,'status','N',411,'Status'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20023,20,'app_facility','N',727,'Company Name'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20024,20,'contract_type','N',727,'Contract Type'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20025,70,'product_type','N',727,'Product Type'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20026,70,'product_name','C',727,'Product Name'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20027,30,'reimbursment_menth','N',512,'Reimbursment Method'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20028,30,'file_location','C',727,'File Location'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20029,80,'effective_date','D',512,'Effective Date'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20030,80,'expriation_date','D',512,'Expriation Date'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20031,40,'review_date','D',512,'Review Date'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20032,40,'review_by','C',512,'Review By'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20033,260,'term_date','D',512,'Term Date'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20034,260,'term_reason','N',512,'Term Reason'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20035,50,'other_date_1','D',512,'Other Date 1'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20036,50,'other_date_2','D',512,'Other Date 2'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20037,330,'oc_signed_by','C',512,'OC Signed By'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20038,330,'dvision','N',727,'Division'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20039,320,'custom_1','C',512,'Custom 1'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20040,320,'custom_2','C',512,'Custom 2'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20041,240,'custom_3','C',512,'Custom 3'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20042,240,'custom_4','C',512,'Custom 4'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20043,250,'custom_5','C',512,'Custom 5'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20044,250,'custom_6','C',512,'Custom 6'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20045,220,'custom_7','C',512,'Custom 7'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20046,220,'custom_8','C',512,'Custom 8'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20047,210,'custom_9','C',512,'Custom 9'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20048,210,'custom_10','C',512,'Custom 10'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20049,280,'group_multi_loc_id','N',727,'Contracted Entity'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20050,280,'revision_reason','C',512,'Revision Reason'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20051,270,'group_id','N',727,'Group ID'); " 

//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_tables(table_id,table_name,table_name_allias) VALUES (1004,'d_contract_det_master_2','IntelliContract/Detail/Contract Dates'); " 
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1004,20052,10,'effective_date','D',384,'Effective Date'); " 
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1004,20053,10,'expriation_date','D',384,'Expriation Date'); " 
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1004,20054,60,'review_date','D',384,'Review Date'); " 
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1004,20055,60,'review_by','C',384,'Review By'); " 
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1004,20056,20,'term_date','D',384,'Term Date'); " 
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1004,20057,20,'term_reason','N',384,'Term Reason'); " 
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1004,20058,70,'last_revis_date','D',384,'Last Revis Date'); " 
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1004,20059,70,'other_date_1','D',384,'Custom date'); " 
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1004,20060,90,'other_date_2','D',402,'Custom Date 2'); " 
//
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_tables(table_id,table_name,table_name_allias) VALUES (1005,'d_contract_profile_req2','IntelliContract/Requirements/Profile Detail'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1005,20061,10,'clause','C',3319,'Clause'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_tables(table_id,table_name,table_name_allias) VALUES (1006,'d_profile_header','IntelliContract/Requirements/Profile Selection '); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1006,20062,10,'rqmnt_name','C',1335,'Rqmnt Name'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_tables(table_id,table_name,table_name_allias) VALUES (1007,'d_contract_det_contact_contact','IntelliContract/Contacts/Contacts List'); " 
//IntelliContract/Contacts/Contact Details
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_tables(table_id,table_name,table_name_allias) VALUES (1008,'d_contract_det_contact_contact_det','IntelliContract/Contacts/Contact Details'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1008,20063,30,'last_name','C',658,'Last Name'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1008,20064,30,'first_name','C',690,'First Name'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1008,20065,20,'ctx_contacts_contact_type','N',997,'Contact Type'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1008,20066,20,'contact_title','C',997,'Title'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1008,20067,10,'ctx_contacts_contact_department','N',1065,'Department'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1008,20068,10,'ctx_contacts_street_1','C',1829,'Street 1'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1008,20069,120,'ctx_contacts_street_2','C',1829,'Street 2'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1008,20070,120,'ctx_contacts_street_3','C',1829,'Street 3'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1008,20071,50,'ctx_contacts_city','C',823,'Contacts City'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1008,20072,50,'ctx_contacts_state','N',274,'State'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1008,20073,60,'ctx_contacts_zip','C',297,'Zip'); " 


ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_tables(table_id,table_name,table_name_allias) VALUES (1009,'d_contract_det_contact_contact_phone','IntelliContract/Contacts/Contact Information'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1009,20074,10,'via','N',334,'Via'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1009,20075,10,'phone','C',347,'Phone'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1009,20076,20,'ext','C',274,'Ext'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1009,20077,20,'contact_email','C',1211,'Contact Email'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1009,20078,30,'record_id','N',503,'Record Id'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_tables(table_id,table_name,table_name_allias) VALUES (1010,'d_contract_det_contact_contact_notes','IntelliContract/Contacts/Notes'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1010,20079,10,'ctx_contract_contacts_notes','C',2693,'Contact Notes'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_tables(table_id,table_name,table_name_allias) VALUES (1011,'d_contract_group_practitioners','IntelliContract/Locations/Associated Physicians'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1011,20080,10,'provider_id','C',462,'Provider ID'); " 

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_tables(table_id,table_name,table_name_allias) VALUES (1012,'d_cntx_location_spec','IntelliContract/Locations/Specialties'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1012,20081,10,'prac_specialty','N',1787,'Specialty'); " 

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_tables(table_id,table_name,table_name_allias) VALUES (1013,'d_org_tabpg','IntelliContract/Organizations/Address'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1013,20082,20,'org_name','C',1833,'Org Name'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1013,20083,20,'org_type','N',375,'Org Type'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1013,20084,30,'status','N',274,'Status'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1013,20085,30,'street_1','C',1833,'Street'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1013,20086,40,'street_2','C',1833,'Street 2'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1013,20087,40,'street_3','C',1833,'Street 3'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1013,20088,50,'city','C',823,'City'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1013,20089,50,'state','N',329,'State'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1013,20090,60,'zip','C',297,'Zip'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1013,20091,60,'drections','C',2592,'Directions'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_tables(table_id,table_name,table_name_allias) VALUES (1014,'d_org_notes','IntelliContract/Organizations/Notes'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1014,20092,10,'notes','C',3950,'Notes'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_tables(table_id,table_name,table_name_allias) VALUES (1015,'d_org_contacts','IntelliContract/Organizations/Organization Contacts'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1015,20093,10,'contact_name','C',850,'Name'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1015,20094,10,'department','C',955,'Department'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1015,20095,20,'via','N',274,'Via'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1015,20096,20,'phone','C',581,'Contact Info'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_tables(table_id,table_name,table_name_allias) VALUES (1016,'d_ctx_schedule_fee_pracs','IntelliContract/Browse/Providers'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_tables(table_id,table_name,table_name_allias) VALUES (1017,'d_ctx_schedule_fee_detail','IntelliContract/Browse/Fees'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1017,20097,10,'code','N',379,'Code'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1017,20098,10,'office_fee','N',379,'Office Fee'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1017,20099,20,'facility_fee','N',379,'Facility Fee'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1017,20100,20,'custom_fee','N',379,'Custom Fee'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1017,20101,30,'precert','I',379,'Precert'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1017,20102,30,'preauth','I',379,'Preauth'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1017,20103,40,'custom_1','C',1737,'Custom 1'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1017,20104,40,'custom_2','C',1737,'Custom 2'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_tables(table_id,table_name,table_name_allias) VALUES (1018,'d_ctx_schedule_fee_locations','IntelliContract/Browse/Fee Schedule Locations'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1018,20105,30,'location','N',663,'Location'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_tables(table_id,table_name,table_name_allias) VALUES (1019,'d_ctx_schedule_fee_notes','IntelliContract/Notes/User Defined data'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1019,20106,10,'notes','C',3593,'Notes'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_tables(table_id,table_name,table_name_allias) VALUES (1020,'d_cntx_images','IntelliContract/Browse/Scanned Documents'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1020,20107,30,'page_description','C',2053,'Description'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1020,20108,30,'media_type','N',448,'Media Type'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1020,20109,10,'image_version','I',201,'Version'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1020,20110,10,'ctx_image_inserted_by_user','C',283,'Inserted By'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1020,20111,20,'ctx_image_inserted_at_date_time','D',443,'Inserted Date/Time'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1020,20112,20,'ctx_image_updated_by_user','C',311,'Updated By'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1020,20113,40,'ctx_image_updated_at_date_time','D',457,'Updated Date/Time'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_tables(table_id,table_name,table_name_allias) VALUES (1021,'d_cntx_action_items','IntelliContract/Action Items/Action Item List'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1021,20114,20,'action_type','N',667,'Action Type'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1021,20115,20,'action_date','D',475,'Action Date'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1021,20116,30,'due_date','D',453,'Due Date'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1021,20117,30,'action_user','C',475,'Action User'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1021,20118,40,'action_status','N',480,'Action Status'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1021,20119,40,'notes','C',2811,'Notes'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1021,20120,50,'alarmed','C',475,'Alarmed'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_tables(table_id,table_name,table_name_allias) VALUES (1022,'d_ctx_contract_contact_type','IntelliContract/Select Data/Contract Contact Information to Include'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1022,20121,10,'selected','I',187,'Selected'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1022,20122,10,'text','C',1737,'Description'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_tables(table_id,table_name,table_name_allias) VALUES (1023,'d_contract_organization_type','IntelliContract/Select Data/Organization Types to Include'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1023,20123,10,'selected','I',178,'Selected'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_tables(table_id,table_name,table_name_allias) VALUES (1024,'d_contract_profile_req_questions','IntelliContract/Select Data/Requirements to Include'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_tables(table_id,table_name,table_name_allias) VALUES (1025,'d_ctx_ext_basic_info','IntelliContract/Select Data/Authorizations Requirements'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_tables(table_id,table_name,table_name_allias) VALUES (1026,'d_ctx_ext_basic_info','IntelliContract/Select Data/Precertifications Requirements'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_tables(table_id,table_name,table_name_allias) VALUES (1027,'d_ctx_ext_basic_info','IntelliContract/Select Data/Basic Information to Include'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_tables(table_id,table_name,table_name_allias) VALUES (1028,'d_ctx_ext_basic_info','IntelliContract/Select Data/Fee Schedule Data to Include'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_tables(table_id,table_name,table_name_allias) VALUES (1029,'d_ctx_cmpst_rpt_1','IntelliContract/Preview/Preview'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_tables(table_id,table_name,table_name_allias) VALUES (1030,'d_notification_users','Contract Alarms/Notification Users'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1030,20124,10,'ctx_notification_users_user_id','C',878,'Ctx Notification Users User Id'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_tables(table_id,table_name,table_name_allias) VALUES (1031,'d_notification','Contract Alarms/Alarm Details'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1031,20125,10,'alm_message','C',1591,'Alarm Message'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1031,20126,10,'alm_enabled','C',64,'Alarm Enabled'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1031,20127,20,'alm_notification_days','I',498,'Alarm Notification Days'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1031,20128,20,'alm_total_tries','I',992,'Times To Send'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_tables(table_id,table_name,table_name_allias) VALUES (1032,'d_contract_contact_search','IntelliContract/Search/Search List'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_tables(table_id,table_name,table_name_allias) VALUES (1033,'d_cntx_custom','IntelliContract/Details/User Defined Data'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1033,20129,140,'custom_1','C',1737,'Custom 1'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1033,20130,140,'custom_2','C',1737,'Custom 2'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1033,20131,150,'custom_3','C',1737,'Custom 3'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1033,20132,150,'custom_4','C',1737,'Custom 4'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1033,20133,160,'custom_5','C',1737,'Custom 5'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1033,20134,160,'custom_6','C',1737,'Custom 6'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1033,20135,170,'custom_7','C',1737,'Custom 7'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1033,20136,170,'custom_8','C',1737,'Custom 8'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1033,20137,180,'custom_9','C',1737,'Custom 9'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1033,20138,180,'custom_10','C',1737,'Custom 10'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_tables(table_id,table_name,table_name_allias) VALUES (1034,'d_cntx_phone','IntelliContract/Details/Phone Numbers'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1034,20139,10,'via','N',434,'Via'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1034,20140,10,'phone','C',613,'Phone'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1034,20141,20,'ext','C',247,'Ext'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1034,20142,20,'contact_email','C',1166,'Contact Email'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_tables(table_id,table_name,table_name_allias) VALUES (1035,'d_cntx_master','IntelliContract/Details/Contact Information'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1035,20143,20,'contact_type','N',709,'Contact Type'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1035,20144,20,'first_name','C',709,'First Name'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1035,20145,30,'last_name','C',709,'Last Name'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1035,20146,30,'middle_name','C',709,'Middle Name'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1035,20147,40,'contact_title','C',709,'Contact Title'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1035,20148,40,'contact_department','N',709,'Contact Department'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1035,20149,50,'street_1','C',1166,'Street 1'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1035,20150,50,'street_2','C',1166,'Street 2'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1035,20151,60,'street_3','C',1166,'Street 3'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1035,20152,60,'city','C',823,'City'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1035,20153,70,'state','N',274,'State'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1035,20154,70,'zip','C',297,'Zip'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_tables(table_id,table_name,table_name_allias) VALUES (1036,'d_contract_location_phone','Contract Contacts/Contact Methods'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1036,20155,10,'via','N',361,'Via'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1036,20156,10,'phone','C',343,'Phone/Fax'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1036,20157,20,'ext','C',279,'Ext'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1036,20158,20,'contact_email','C',1211,'Contact Email'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_tables(table_id,table_name,table_name_allias) VALUES (1037,'d_contract_painter_elements','Profile Requirements//Requirements'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1037,20159,10,'element_name','C',1266,'Element Name'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1037,20160,10,'element_sort','I',274,' Sort'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1037,20161,20,'value_type','I',274,'Type'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1037,20162,20,'dddw_name','C',485,'Dddw Name'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_tables(table_id,table_name,table_name_allias) VALUES (1038,'d_req_profile_painter_category','Profile Requirements//Requirements Group'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1038,20163,10,'category_name','C',763,'Category Name'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_tables(table_id,table_name,table_name_allias) VALUES (1039,'d_req_profile_painter_master','Profile Requirements/Requirements Profile'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1039,20164,20,'rqmnt_name','C',645,'Name'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1039,20165,20,'rqmnt_description','C',2021,'Description'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1039,20166,30,'rqmnt_type','N',503,'Type'); " 


ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_tables(table_id,table_name,table_name_allias) VALUES (1040,'d_ctx_free_sched_hdr','IntelliContract/Browse/Fee Schedules'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1040,20167,30,'sched_type','N',558,'Schedule Type'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1040,20168,30,'carve_out_type','N',558,'Carve Out Type'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1040,20169,40,'rate','N',558,'Rate%'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1040,20170,40,'fee_bonus','N',558,'Fee Basis'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1040,20171,50,'custom_1','C',1728,'Custom 1'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1040,20172,50,'custom_2','C',1728,'Custom 2'); "


ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_tables(table_id,table_name,table_name_allias) VALUES (1041,'d_ctx_schedule_fee_pracs','IntelliContract/Browse/Providers'); " 


//Fee Schedule Locations
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_tables(table_id,table_name,table_name_allias) VALUES (1042,'d_ctx_schedule_fee_locations','IntelliContract/Browse/Fee Schedule Locations'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1042,20173,30,'location','N',558,'Location'); " 


//Contacts List
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_tables(table_id,table_name,table_name_allias) VALUES (1043,'d_contract_det_contact_contact','IntelliContract/Browse/Fee Schedule Locations'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1043,20174,30,'contact_id','N',558,'Contact ID'); " 


//IntelliContract/Detail/Our Company Contact Info
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_tables(table_id,table_name,table_name_allias) VALUES (1044,'d_contract_det_contact_internal','IntelliContract/Detail/Our Company Contact Info'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1044,20175,10,'contact_id','I',119,'Contact Id'); "

//IntelliContract/Detail/Contracted Company Contact Info
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_tables(table_id,table_name,table_name_allias) VALUES (1055,'d_contract_det_contact_external','IntelliContract/Detail/Contracted Company Contact Info'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1055,20176,10,'contact_id','I',119,'Contact Id'); " 

//IntelliContract/Locations/Contracted Entity
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_tables(table_id,table_name,table_name_allias) VALUES (1056,'d_contract_multi_group_browse','IntelliContract/Locations/Contracted Entity'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1056,20177,10,'record_id','N',512,'text'); " 

//IntelliContract/Locations/ Facilities
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_tables(table_id,table_name,table_name_allias) VALUES (1057,'d_contract_group_linked_locations','IntelliContract/Locations/ Facilities'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1057,20178,10,'tax_id','C',507,'Tax ID'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1057,20179,10,'group_number','C',507,'Group #'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1057,20180,20,'local','N',507,'Local'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1057,20181,20,'custom_1','C',507,'Custom 1'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1057,20182,30,'custom_2','C',974,'Custom 2'); " 
// table 1041
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1041,20183,30,'fee_sched_id','N',558,'Fee Schedule ID'); " 
//table 1003
// start code change --- 11.01.2005 MSKINNER
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1003,20184,280,'last_revis_date','D',384,'Last Revis Date');" 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1055,20185,10,'default_email','C',119,'Default Email'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_fields(table_id,field_id,field_order,field_name,field_type,field_len,field_name_allias) VALUES (1044,20186,10,'default_email','C',119,'Default Email'); "

// end code change --- 11.01.2005 MSKINNER

return 0
end function

private function integer of_asa_0_changes ();/******************************************************************************************************************
**  [PUBLIC]   : of_asa_0_changes( )
**==================================================================================================================
**  Purpose   	: The inital database setup
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

// get out if the database is already created -- redundant check
if il_database_version > 0 then return 0


ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_ACTI_FK_CTX_AC_CTX_CONT_') then    alter table CTX_ACTION_ITEMS       delete foreign key FK_CTX_ACTI_FK_CTX_AC_CTX_CONT_ end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_ACTI_REFERENCE_CODE_LOO_ACTION_TYPE') then    alter table CTX_ACTION_ITEMS       delete foreign key FK_CTX_ACTI_REFERENCE_CODE_LOO_ACTION_TYPE  end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_ACTI_REFERENCE_CODE_LOO_action_status') then    alter table CTX_ACTION_ITEMS       delete foreign key FK_CTX_ACTI_REFERENCE_CODE_LOO_action_status  end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_ACTI_FK_CTX_AC_CTX_BASI') then    alter table CTX_ACTION_ITEMS       delete foreign key FK_CTX_ACTI_FK_CTX_AC_CTX_BASI  end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_ACTI_FK_CTX_AC_CTX_CONT') then    alter table CTX_ACTION_ITEMS       delete foreign key FK_CTX_ACTI_FK_CTX_AC_CTX_CONT end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_BASI_FK_CTX_BA_CODE_LOO') then    alter table CTX_BASIC_INFO       delete foreign key FK_CTX_BASI_FK_CTX_BA_CODE_LOO end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_BASI_REFERENCE_CODE_LOO_DIVISION') then    alter table CTX_BASIC_INFO       delete foreign key FK_CTX_BASI_REFERENCE_CODE_LOO_DIVISION end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_BASI_REFERENCE_CODE_LOO_OC_DEPARTMENT') then    alter table CTX_BASIC_INFO       delete foreign key FK_CTX_BASI_REFERENCE_CODE_LOO_OC_DEPARTMENT end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_BASI_REFERENCE_CODE_LOO_OC_TITLE') then    alter table CTX_BASIC_INFO       delete foreign key FK_CTX_BASI_REFERENCE_CODE_LOO_OC_TITLE end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_BASI_REFERENCE_CODE_LOO_TERM_REASON') then    alter table CTX_BASIC_INFO       delete foreign key FK_CTX_BASI_REFERENCE_CODE_LOO_TERM_REASON end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_BASI_REFERENCE_CODE_LOO_contract_type') then    alter table CTX_BASIC_INFO       delete foreign key FK_CTX_BASI_REFERENCE_CODE_LOO_contract_type end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_BASI_REFERENCE_CODE_LOO_status') then    alter table CTX_BASIC_INFO       delete foreign key FK_CTX_BASI_REFERENCE_CODE_LOO_status end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_BASI_info_product_type') then    alter table CTX_BASIC_INFO       delete foreign key FK_CTX_BASI_info_product_type end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_CONT_FK_CTX_CO_CTX_CONT2') then    alter table CTX_CONTACTS_NUMBERS       delete foreign key FK_CTX_CONT_FK_CTX_CO_CTX_CONT2 end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_CONT_REFERENCE_CODE_LOO_CTX_TYPE') then    alter table CTX_CONTACTS       delete foreign key FK_CTX_CONT_REFERENCE_CODE_LOO_CTX_TYPE end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_CONT_REFERENCE_CODE_LOO_STATE') then    alter table CTX_CONTACTS       delete foreign key FK_CTX_CONT_REFERENCE_CODE_LOO_STATE end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_CONT_REFERENCE_CODE_LOO_VIA') then    alter table CTX_CONTACTS_NUMBERS       delete foreign key FK_CTX_CONT_REFERENCE_CODE_LOO_VIA end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_CONT_FK_CTX_CO_CTX_BASI') then    alter table CTX_CONTRACT_CONTACTS       delete foreign key FK_CTX_CONT_FK_CTX_CO_CTX_BASI end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_CONT_FK_CTX_CO_CTX_CONT') then    alter table CTX_CONTRACT_CONTACTS       delete foreign key FK_CTX_CONT_FK_CTX_CO_CTX_CONT end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_ELEM_FK_CTX_EL_CTX_REQ_') then    alter table CTX_ELEMENTS       delete foreign key FK_CTX_ELEM_FK_CTX_EL_CTX_REQ_ end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_FEE__FK_CTX_FE_CTX_FEE_2') then    alter table CTX_FEE_SCHED_DATA       delete foreign key FK_CTX_FEE__FK_CTX_FE_CTX_FEE_2 end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_FEE__FK_CTX_FE_CTX_FEE_LOCATIONS') then    alter table CTX_FEE_SCHED_LOCATIONS       delete foreign key FK_CTX_FEE__FK_CTX_FE_CTX_FEE_LOCATIONS end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_FEE__REFERENCE_CODE_LOO_cave_out') then    alter table CTX_FEE_SCHED_HDR       delete foreign key FK_CTX_FEE__REFERENCE_CODE_LOO_cave_out end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_FEE__REFERENCE_CODE_LOO_location') then    alter table CTX_FEE_SCHED_LOCATIONS       delete foreign key FK_CTX_FEE__REFERENCE_CODE_LOO_location end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_FEE__REFERENCE_CODE_LOO_physl_fee') then    alter table CTX_FEE_SCHED_DATA       delete foreign key FK_CTX_FEE__REFERENCE_CODE_LOO_physl_fee end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_FEE__REFERENCE_CODE_LOO_sched_type') then    alter table CTX_FEE_SCHED_HDR       delete foreign key FK_CTX_FEE__REFERENCE_CODE_LOO_sched_type end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_FEE__FK_CTX_FE_CTX_BASI') then    alter table CTX_FEE_SCHED_HDR       delete foreign key FK_CTX_FEE__FK_CTX_FE_CTX_BASI end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_FEE__FK_CTX_FE_CTX_FEE_') then    alter table CTX_FEE_SCHED_PRACS       delete foreign key FK_CTX_FEE__FK_CTX_FE_CTX_FEE_ end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_FEE__REFERENCE_PD_BASIC_prac_id') then    alter table CTX_FEE_SCHED_PRACS       delete foreign key FK_CTX_FEE__REFERENCE_PD_BASIC_prac_id end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_FILE_FK_CTX_FI_CTX_BASI') then    alter table CTX_FILE_LOCATION       delete foreign key FK_CTX_FILE_FK_CTX_FI_CTX_BASI end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_IMAG_FK_CTX_IM_CTX_BASI') then    alter table CTX_IMAGES       delete foreign key FK_CTX_IMAG_FK_CTX_IM_CTX_BASI end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_IMAG_FK_CTX_IM_CTX_IMAG') then    alter table CTX_IMAGE       delete foreign key FK_CTX_IMAG_FK_CTX_IM_CTX_IMAG end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_LOCA_REFERENCE_CODE_LOOKUP_LOOLUP_CODE') then    alter table CTX_LOCATION_SPECIALTY       delete foreign key FK_CTX_LOCA_REFERENCE_CODE_LOOKUP_LOOLUP_CODE end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_LOCA_FK_CTX_LO_CTX_CONT') then    alter table CTX_LOCATION_CONTACTS       delete foreign key FK_CTX_LOCA_FK_CTX_LO_CTX_CONT end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_LOCA_FK_CTX_LO_CTX_LOC') then    alter table CTX_LOCATION_CONTACTS       delete foreign key FK_CTX_LOCA_FK_CTX_LO_CTX_LOC end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_LOCA_REFERENCE_CTX_LOC1') then    alter table CTX_LOCATION_CONTACTS       delete foreign key FK_CTX_LOCA_REFERENCE_CTX_LOC1 end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_LOCA_REFERENCE_CTX_LOCCATION_SPEC_LOC_ID') then    alter table CTX_LOCATION_SPECIALTY       delete foreign key FK_CTX_LOCA_REFERENCE_CTX_LOCCATION_SPEC_LOC_ID end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_LOC_FK_CTX_LO_CTX_BASI') then    alter table CTX_LOC       delete foreign key FK_CTX_LOC_FK_CTX_LO_CTX_BASI end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_NOTI_FK_CTX_NO_CTX_BASI') then    alter table CTX_NOTIFICATION_USERS       delete foreign key FK_CTX_NOTI_FK_CTX_NO_CTX_BASI end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_NOTI_FK_CTX_NO_CTX_NOTI') then    alter table CTX_NOTIFICATION_USERS       delete foreign key FK_CTX_NOTI_FK_CTX_NO_CTX_NOTI end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_ORGS_REFERENCE_CODE_LOO_org_type') then    alter table CTX_ORGS       delete foreign key FK_CTX_ORGS_REFERENCE_CODE_LOO_org_type end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_ORGS_REFERENCE_CODE_LOO_state') then    alter table CTX_ORGS       delete foreign key FK_CTX_ORGS_REFERENCE_CODE_LOO_state end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_ORGS_REFERENCE_CODE_LOO_status') then    alter table CTX_ORGS       delete foreign key FK_CTX_ORGS_REFERENCE_CODE_LOO_status end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_ORGS_FK_CTX_OR_CTX_BASI') then    alter table CTX_ORGS_CONTACT       delete foreign key FK_CTX_ORGS_FK_CTX_OR_CTX_BASI end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_ORGS_FK_CTX_OR_CTX_ORGS') then    alter table CTX_ORGS_CONTACT       delete foreign key FK_CTX_ORGS_FK_CTX_OR_CTX_ORGS end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_ORG__REFERENCE_CODE_LOO_via') then    alter table CTX_ORG_CONTACT       delete foreign key FK_CTX_ORG__REFERENCE_CODE_LOO_via end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_ORG__FK_CTX_OR_CTX_ORGS') then    alter table CTX_ORG_CONTACT       delete foreign key FK_CTX_ORG__FK_CTX_OR_CTX_ORGS end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_REPO_FK_CTX_RE_CTX_REPO') then    alter table CTX_REPORT_PROFILE_DET       delete foreign key FK_CTX_REPO_FK_CTX_RE_CTX_REPO end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_REQ__FK_CTX_RE_CTX_BASI') then    alter table CTX_REQ_PROFILE_HDR       delete foreign key FK_CTX_REQ__FK_CTX_RE_CTX_BASI end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_REQ__REFERENCE_CTX_REQ') then    alter table CTX_REQ_TMPLT_ELEMENT       delete foreign key FK_CTX_REQ__REFERENCE_CTX_REQ end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_REQ__FK_CTX_RE_CTX_REQ_') then    alter table CTX_REQ_PROFILE_HDR       delete foreign key FK_CTX_REQ__FK_CTX_RE_CTX_REQ_ end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_RQMN_FK_CTX_RQ_CTX_REQ_') then    alter table CTX_RQMNT_CATEGORY       delete foreign key FK_CTX_RQMN_FK_CTX_RQ_CTX_REQ_ end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_ctx_notification_to_ctx_basic_info') then    alter table CTX_NOTIFICATION       delete foreign key FK_ctx_notification_to_ctx_basic_info end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_HIER_REFERENCE_CTX_ITEM') then    alter table CTX_HIERCHY_ACCESS       delete foreign key FK_CTX_HIER_REFERENCE_CTX_ITEM  end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_HIER_REFERENCE_CTX_ITEM') then    alter table CTX_HIERCHY_ACCESS       delete foreign key FK_CTX_HIER_REFERENCE_CTX_ITEM  end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_HIER_REFERENCE_CTX_ITEM') then    alter table CTX_HIERCHY_ACCESS       delete foreign key FK_CTX_HIER_REFERENCE_CTX_ITEM  end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_HIER_REFERENCE_CTX_ITEM') then    alter table CTX_HIERCHY_ACCESS       delete foreign key FK_CTX_HIER_REFERENCE_CTX_ITEM  end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_ITEM_REFERENCE_CTX_ITEM') then    alter table CTX_ITEM_HIERARCHY       delete foreign key FK_CTX_ITEM_REFERENCE_CTX_ITEM  end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_ITEM_REFERENCE_CTX_ITEM') then    alter table CTX_ITEM_HIERARCHY       delete foreign key FK_CTX_ITEM_REFERENCE_CTX_ITEM  end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_ITEM_REFERENCE_CTX_ITEM') then    alter table CTX_ITEM_HIERARCHY       delete foreign key FK_CTX_ITEM_REFERENCE_CTX_ITEM  end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_CPT__REFERENCE_CTX_ITEM') then    alter table CTX_CPT_CODE_ITEM       delete foreign key FK_CTX_CPT__REFERENCE_CTX_ITEM  end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_CPT__REFERENCE_CTX_CPT_') then    alter table CTX_CPT_CODE_ITEM       delete foreign key FK_CTX_CPT__REFERENCE_CTX_CPT_  end if " 

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='CTX_ACTION_ITEMS' and table_type='BASE') then    drop table CTX_ACTION_ITEMS end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='CTX_BASIC_INFO' and table_type='BASE') then    drop table CTX_BASIC_INFO end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='CTX_CONTACTS' and table_type='BASE') then    drop table CTX_CONTACTS end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='CTX_CONTACTS_NUMBERS' and table_type='BASE') then    drop table CTX_CONTACTS_NUMBERS end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='CTX_CONTRACT_CONTACTS' and table_type='BASE') then    drop table CTX_CONTRACT_CONTACTS end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='CTX_CPT_CODES' and table_type='BASE') then    drop table CTX_CPT_CODES end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='CTX_CPT_CODE_ITEM' and table_type='BASE') then    drop table CTX_CPT_CODE_ITEM end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='CTX_ELEMENTS' and table_type='BASE') then    drop table CTX_ELEMENTS end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='CTX_FEE_SCHED_DATA' and table_type='BASE') then    drop table CTX_FEE_SCHED_DATA end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='CTX_FEE_SCHED_HDR' and table_type='BASE') then    drop table CTX_FEE_SCHED_HDR end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='CTX_FEE_SCHED_LOCATIONS' and table_type='BASE') then    drop table CTX_FEE_SCHED_LOCATIONS end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='CTX_FEE_SCHED_PRACS' and table_type='BASE') then    drop table CTX_FEE_SCHED_PRACS end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='CTX_FILE_LOCATION' and table_type='BASE') then    drop table CTX_FILE_LOCATION end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='CTX_HIERCHY_ACCESS' and table_type='BASE') then    drop table CTX_HIERCHY_ACCESS end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='CTX_IMAGE' and table_type='BASE') then    drop table CTX_IMAGE end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='CTX_IMAGES' and table_type='BASE') then    drop table CTX_IMAGES end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='CTX_ITEM' and table_type='BASE') then    drop table CTX_ITEM end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='CTX_ITEM_HIERARCHY' and table_type='BASE') then    drop table CTX_ITEM_HIERARCHY end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='CTX_ITEM_LEVEL' and table_type='BASE') then    drop table CTX_ITEM_LEVEL end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='CTX_LOC' and table_type='BASE') then    drop table CTX_LOC end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='CTX_LOCATION_CONTACTS' and table_type='BASE') then    drop table CTX_LOCATION_CONTACTS end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='CTX_LOCATION_SPECIALTY' and table_type='BASE') then    drop table CTX_LOCATION_SPECIALTY end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='CTX_NOTIFICATION' and table_type='BASE') then    drop table CTX_NOTIFICATION end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='CTX_NOTIFICATION_USERS' and table_type='BASE') then    drop table CTX_NOTIFICATION_USERS end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='CTX_ORGS' and table_type='BASE') then    drop table CTX_ORGS end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='CTX_ORGS_CONTACT' and table_type='BASE') then    drop table CTX_ORGS_CONTACT end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='CTX_ORG_CONTACT' and table_type='BASE') then    drop table CTX_ORG_CONTACT end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='CTX_REPORT_PROFILE_DET' and table_type='BASE') then    drop table CTX_REPORT_PROFILE_DET end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='CTX_REQ_PROFILE' and table_type='BASE') then    drop table CTX_REQ_PROFILE end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='CTX_REQ_PROFILE_HDR' and table_type='BASE') then    drop table CTX_REQ_PROFILE_HDR end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='CTX_REQ_TMPLT_ELEMENT' and table_type='BASE') then    drop table CTX_REQ_TMPLT_ELEMENT end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='CTX_RQMNT_CATEGORY' and table_type='BASE') then    drop table CTX_RQMNT_CATEGORY end if " 
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='DB_CONTROL' and table_type='BASE') then    drop table DB_CONTROL end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='ctx_report_profile_hdr' and table_type='BASE') then    drop table ctx_report_profile_hdr end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systypes where name='Letter_destination') then   drop datatype Letter_destination end if " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systypes where name='inserted_by_user') then   drop datatype inserted_by_user end if " 
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create datatype Letter_destination integer " 
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create datatype inserted_by_user varchar(128) " 

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table CTX_ACTION_ITEMS (    ctx_action_item_id   int                            not null default autoincrement,    ctx_id               int                            not null,    action_type          numeric(6) null,    action_date          datetime null,    due_date             datetime null,    action_user          varchar(20) null,    action_status        numeric(6) null,    notes                varchar(255) null,    ALARMED              char(1) null                        default 'N',    first_attempt        datetime null,    last_attempt         datetime null,    no_attempts          int null,    assigned_to          numeric(6,0)  null,    print_flag           int null                            default 0,    inserted_by_user     varchar(128)  null,    inserted_at_date_time datetime  null,    updated_by_user      varchar(128)  null,    updated_at_date_time datetime  null,    record_id            numeric(10) null                   default NULL,    Letter_flag          char(1)                        default 'N'          check (Letter_flag is null or ( Letter_flag in ('Y','N') )),    letter_to            int  null,    letter_from          int  null,    primary key (ctx_action_item_id, ctx_id)) " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table CTX_BASIC_INFO (    ctx_id               int                            not null,    category             numeric(6)  null,    status               numeric(6)  null,    app_facility         numeric  null,    facility_id          int  null,    contract_type        numeric(6)  null,    product_type         numeric(6)  null,    product_name         varchar(150)  null,    reimbursment_menth   numeric(6)  null,    file_location        varchar(150)  null,    effective_date       datetime  null,    expriation_date      datetime  null,    review_date          datetime  null,    review_by            varchar(10)  null,    term_date            datetime  null,    term_reason          numeric(6)  null,    last_revis_date      datetime  null,    other_date_1         datetime  null,    other_date_2         datetime  null,    oc_signed_by         varchar(75)  null,    oc_title             numeric(6)  null,    oc_department        numeric(6)  null,    oc_legal_rep         varchar(75)  null,    cc_signed_by         varchar(75)  null,    cc_title             varchar(75)  null,    cc_department        varchar(75)  null,    cc_legal_rep         varchar(75)  null,    notes                varchar(2000)  null,    keyword              varchar(30)  null,    dvision              numeric(6)  null,    custom_1             varchar(255)  null,    custom_2             varchar(255)  null,    custom_3             varchar(255)  null,    custom_4             varchar(255)  null,    custom_5             varchar(255)  null,    custom_6             varchar(255)  null,    custom_7             varchar(255)  null,    custom_8             varchar(255)  null,    custom_9             varchar(255)  null,    custom_10            varchar(255)  null,    group_multi_loc_id   numeric(6)  null,    revision_reason      varchar(255)  null,    group_id             numeric(6)  null,    custom_date1         datetime  null,    custom_date2         datetime  null,    custom_date3         datetime  null,    custom_date4         datetime  null,    custom_date5         datetime  null,    inserted_by_user     varchar(128)  null,    inserted_at_date_time datetime  null,    updated_by_user      varchar(128)  null,    updated_at_date_time datetime  null,    record_id            numeric(10)                    not null default NULL,    primary key (ctx_id)) " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table CTX_CONTACTS (    contact_id           int                            not null,    contact_type         numeric(6),    first_name           varchar(30)                    not null,    last_name            varchar(30)                    not null,    middle_name          varchar(30)  null                  default 'NONE',    contact_title        varchar(50)  null,    contact_department   numeric(6)  null,    street_1             varchar(150)                   not null,    street_2             varchar(150)  null,    street_3             Varchar(150)  null,    city                 varchar(35)                    not null,    state                numeric(6)                     not null,    zip                  varchar(12)                    not null,    Contact_local        char(1)  null,    custom_1             varchar(75)  null,    custom_2             varchar(75)  null,    custom_3             varchar(75)  null,    custom_4             varchar(75)  null,    custom_5             varchar(75)  null,    custom_6             varchar(75)  null,    custom_7             varchar(75)  null,    custom_8             varchar(75)  null,    custom_9             varchar(75)  null,    custom_10            varchar(75)  null,    inserted_by_user     varchar(128)  null,    inserted_at_date_time datetime  null,    updated_by_user      varchar(128)  null,    updated_at_date_time datetime  null,    record_id            numeric(10)                    default NULL,    primary key (contact_id)) " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table CTX_CONTACTS_NUMBERS (    contact_id           int                            not null,    contact_num_id       int                            not null default autoincrement,    via                  numeric(6)  null,    phone                varchar(11)  null,    ext                  varchar(10)  null,    contact_email        varchar(50)  null,    type                 int  null,    inserted_by_user     varchar(128)  null,    inserted_at_date_time datetime  null,    updated_by_user      varchar(128)  null,    updated_at_date_time datetime  null,    record_id            numeric(10)                    not null default NULL,    primary key (contact_num_id, contact_id)) " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table CTX_CONTRACT_CONTACTS (    ctx_id               int                            not null,    contact_id           int                            not null,    ic_area              char(1)                        not null,    association          varchar(100)  null,    notes                varchar(255)  null,    default_email        char(1)                        not null default 'N',    record_id            numeric(10)    null                default NULL,    inserted_by_user     varchar(128)  null,    inserted_at_date_time datetime  null,    updated_by_user      varchar(128)  null,    updated_at_date_time datetime  null,    primary key (ctx_id, contact_id, ic_area)) " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table CTX_CPT_CODES (    cpt_code_id          int                            not null,    cpt_code             varchar(10)                    not null,    cpt_code_description varchar(2000)                  not null,    base_price           decimal  null,    primary key (cpt_code_id, cpt_code)) " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table CTX_CPT_CODE_ITEM (    ITEM_ID              int                            not null,    CPT_CODE_ID          INT                            not null,    location_price       decimal  null,    primary key (ITEM_ID, CPT_CODE_ID)) " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table CTX_ELEMENTS (    ctx_elements_id      int                            not null,    CTX_REQ_PROFILE_HDR_id int                            not null,    ctx_req_tmplt_element_id int                            not null,    char_value           char(1)  null,    integer_value        numeric(8,2)  null,    date_value           datetime  null,    field_value          varchar(50)  null,    clause               long varchar  null,    ctx_page             int  null,    ct_x                 int  null,    ct_y                 int  null,    ctx_hilgt_x          int  null,    ctx_hilgt_y          int  null,    ctx_hilgt_h          int  null,    ctc_hilgt_w          int  null,    show_in_imaging      int  null,    notes                varchar(1)  null,    inserted_by_user     varchar(128)  null,    inserted_at_date_time datetime  null,    updated_by_user      varchar(128)  null,    updated_at_date_time datetime  null,    record_id            numeric(10)                    not null default NULL,    primary key (ctx_elements_id)) " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table CTX_FEE_SCHED_DATA (    fee_sched_data_id    integer                        not null,    fee_sched_location_id int                            not null,    code                 varchar(10)                    not null,    office_fee           money  null,    facility_fee         money  null,    custom_fee           money  null,    fee                  numeric(6)  null,    precert              int  null,    preauth              int  null,    phys_fee             numeric(6)  null,    custom_1             varchar(75)  null,    custom_2             varchar(75)  null,    custom_3             varchar(75)  null,    custom_4             varchar(75)  null,    custom_5             varchar(75)  null,    inserted_by_user     varchar(128)  null,    inserted_at_date_time datetime  null,    updated_by_user      varchar(128)  null,    updated_at_date_time datetime  null,    record_id            numeric(10)                    not null default NULL,    primary key (fee_sched_data_id, fee_sched_location_id)) " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table CTX_FEE_SCHED_HDR (    fee_sched_id         int                            not null,    ctx_id               int                            not null,    sched_type           numeric(6)  null,    carve_out_type       numeric(6)  null,    rate                 numeric(8,2)  null,    fee_bonus            numeric(8,2)  null,    custom_1             varchar(75)  null,    custom_2             varchar(75)  null,    custom_3             varchar(75)  null,    custom_4             varchar(75)  null,    custom_5             varchar(75)  null,    notes                varchar(1)  null,    inserted_by_user     varchar(128)  null,    inserted_at_date_time datetime  null,    updated_by_user      varchar(128)  null,    updated_at_date_time datetime  null,    record_id            numeric(10)                    not null default NULL,    primary key (fee_sched_id)) " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table CTX_FEE_SCHED_LOCATIONS (    fee_sched_location_id int                            not null,    fee_sched_id         int                            not null,    location             numeric(6)                     not null,    inserted_by_user     varchar(128)  null,    inserted_at_date_time datetime  null,    updated_by_user      varchar(128)  null,    updated_at_date_time datetime  null,    record_id            numeric(10)                    not null default NULL,    primary key (fee_sched_location_id)) " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table CTX_FEE_SCHED_PRACS (    fee_sched_id         int                            not null,    practitioner_id      numeric(6)                     not null,    inserted_by_user     varchar(128)  null,    inserted_at_date_time datetime  null,    updated_by_user      varchar(128)  null,    updated_at_date_time datetime  null,    record_id            numeric(10)                    not null default NULL,    primary key (fee_sched_id, practitioner_id)) " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table CTX_FILE_LOCATION (    ctx_file_location_id int                            not null default autoincrement,    ctx_id               int                            not null,    ctx_file_location_path varchar(255)  null,    ctx_file_location_comment varchar(255)  null,    inserted_by_user     varchar(128)  null,    inserted_at_date_time datetime  null,    updated_by_user      varchar(128)  null,    updated_at_date_time datetime  null,    record_id            numeric(10)                    not null default NULL,    primary key (ctx_file_location_id, ctx_id)) " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table CTX_HIERCHY_ACCESS (    item_id              int                            not null,    item_level           int                            not null,    parent_id            int  null,    parent_level         int  null,    primary key (item_id, item_level)) " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table CTX_IMAGE (    image_id             int                            not null,    ctx_id               int                            not null,    image_version        int                            not null,    Locked_by            varchar(50)  null,    lock_status          char(1)  null,    image_file           image  null,    inserted_by_user     varchar(128)  null,    inserted_at_date_time datetime  null,    updated_by_user      varchar(128)  null,    updated_at_date_time datetime  null,    record_id            numeric(10)                    not null default NULL,    primary key (image_id, ctx_id, image_version)) " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table CTX_IMAGES (    image_id             int                            not null,    ctx_id               int                            not null,    media_type           numeric(6,0)                   not null,    file_name            varchar(100)  null,    page_end             int  null,    page_start           int  null,    page_description     varchar(255)  null,    inserted_by_user     varchar(128)  null,    inserted_at_date_time datetime  null,    updated_by_user      varchar(128)  null,    updated_at_date_time datetime  null,    record_id            numeric(10)                    not null default NULL,    primary key (image_id, ctx_id)) " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table CTX_ITEM (    item_id              INT                            not null,    item_name            varchar(255)                   not null,    primary key (item_id)) " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table CTX_ITEM_HIERARCHY (    item_id              int,    parent_id            int  null,    item_level           int) " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table CTX_ITEM_LEVEL (    level_num            int                            not null,    level_name           varchar(255)) " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table CTX_LOC (    ctx_id               int                            not null,    parent_comp_id       numeric(6)                     not null,    loc_id               numeric(6)                     not null,    group_number         varchar(15)  null,    local                numeric(6)  null,    end_date             datetime  null,    term_reason          numeric(6)  null,    start_date           datetime  null,    custom_1             varchar(15)  null,    custom_2             varchar(75)  null,    custom_3             varchar(75)  null,    custom_4             varchar(75)  null,    inserted_by_user     varchar(128)  null,    inserted_at_date_time datetime  null,    updated_by_user      varchar(128)  null,    updated_at_date_time datetime  null,    record_id            numeric(10)                    not null default NULL,    primary key (ctx_id, parent_comp_id, loc_id)) " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table CTX_LOCATION_CONTACTS (    loc_id               numeric(6)                     not null,    contact_id           int                            not null,    ctx_id               int  null,    parent_comp_id       numeric(6)  null,    CTX_loc_id           numeric(6)  null                   default 0,    record_id            numeric(10)                    not null default NULL,    primary key (loc_id)) " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table CTX_LOCATION_SPECIALTY (    ctx_id               int                            not null,    parent_comp_id       numeric(6)                     not null,    loc_id               numeric(6)                     not null default 0,    Prac_specialty       numeric(6)                     not null,    record_id            numeric(10)                    not null default NULL,    primary key (loc_id, Prac_specialty, parent_comp_id, ctx_id)) " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table CTX_NOTIFICATION (    ctx_id               int                            not null,    alm_message          varchar(255)  null,    alm_enabled          char(1)  null,    alm_table            varchar(40)                    not null,    alm_column           varchar(40)                    not null,    alm_notification_days int  null,    alm_last_notification_sent datetime  null,    alm_post_notification_days int  null,    alm_total_tries      int  null,    alm_action_item_posted int  null,    alm_total_tries_counter int  null,    alm_frequency        int  null,    record_id            numeric(10)                    not null default NULL,    primary key (ctx_id, alm_table, alm_column)) " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table CTX_NOTIFICATION_USERS (    ctx_id               int                            not null,    user_id              char(10)                       not null,    alm_table            varchar(40)                    not null,    alm_column           varchar(40)                    not null,    record_id            numeric(10)                    not null default NULL,    primary key (ctx_id, user_id, alm_table, alm_column)) " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table CTX_ORGS (    org_id               int                            not null,    org_name             varchar(255)                   not null,    org_type             numeric(6)                     not null,    status               numeric(6)  null,    street_1             varchar(150)  null,    street_2             varchar(150)  null,    street_3             varchar(150)  null,    city                 varchar(35)  null,    state                numeric(6)  null,    zip                  varchar(12)  null,    drections            varchar(1)  null,    notes                varchar(1)  null,    custom_1             varchar(75)  null,    custom_2             varchar(75)  null,    custom_3             varchar(75)  null,    custom_4             varchar(75)  null,    custom_5             varchar(75)  null,    custom_6             varchar(75)  null,    custom_7             varchar(75)  null,    custom_8             varchar(75)  null,    custom_9             varchar(75)  null,    custom_10            varchar(75)  null,    inserted_at_date_time datetime  null,    inserted_by_user     varchar(128)  null,    updated_at_date_time datetime  null,    updated_by_user      varchar(128)  null,    record_id            numeric(10)                    not null default NULL,    primary key (org_id)) " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table CTX_ORGS_CONTACT (    ctx_id               int                            not null,    org_id               int                            not null,    area                 char(1)                        not null,    notes                varchar(1)  null,    inserted_by_user     varchar(128)  null,    inserted_at_date_time datetime  null,    updated_by_user      varchar(128)  null,    updated_at_date_time datetime  null,    record_id            numeric(10)                    not null default NULL,    primary key (ctx_id, org_id, area)) " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table CTX_ORG_CONTACT (    org_contact_id       int                            not null default autoincrement,    org_id               int                            not null,    contact_name         varchar(75)  null,    department           varchar(75)  null,    via                  numeric(6)  null,    phone                varchar(12)  null,    org_cnt_email        varchar(255)  null,    inserted_by_user     varchar(128)  null,    inserted_at_date_time datetime  null,    updated_by_user      varchar(128)  null,    updated_at_date_time datetime  null,    record_id            numeric(10)                    not null default NULL,    primary key (org_id, org_contact_id)) " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table CTX_REPORT_PROFILE_DET (    ctx_rpt_prfl_det_id  int                            not null default autoincrement,    ctx_rpt_prfl_id      int                            not null,    lookup_code          numeric(6,0)  null,    field_id             int  null,    primary key (ctx_rpt_prfl_id, ctx_rpt_prfl_det_id)) " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table CTX_REQ_PROFILE (    ctx_req_profile_id   int                            not null,    rqmnt_name           varchar(100)  null,    rqmnt_description    varchar(255)  null,    rqmnt_type           numeric(8,0)  null,    inserted_by_user     varchar(128)  null,    inserted_at_date_time datetime  null,    updated_by_user      varchar(128)  null,    updated_at_date_time datetime  null,    record_id            numeric(10)                    not null default NULL,    primary key (ctx_req_profile_id)) " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table CTX_REQ_PROFILE_HDR (    CTX_REQ_PROFILE_HDR_id int                            not null,    ctx_req_profile_id   int                            not null,    ctx_id               int                            not null,    moduser              varchar(30)  null,    modification_date    datetime      null                 default getdate(),    inserted_by_user     varchar(128)  null,    inserted_at_date_time datetime  null,    updated_by_user      varchar(128)  null,    updated_at_date_time datetime  null,    record_id            numeric(10)                    not null default NULL,    primary key (CTX_REQ_PROFILE_HDR_id)) " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table CTX_REQ_TMPLT_ELEMENT (    ctx_req_tmplt_element_id int                            not null,    ctx_req_profile_id   int                            not null,    ctx_rqmnt_category_id int                            not null,    element_name         varchar(150)  null,    element_sort         int  null,    value_type           int  null,    dddw_name            varchar(40)  null,    inserted_by_user     varchar(128)  null,    inserted_at_date_time datetime  null,    updated_at_date_time datetime  null,    updated_by_user      varchar(128)  null,    record_id            numeric(10)                    not null default NULL,    primary key (ctx_req_tmplt_element_id, ctx_req_profile_id, ctx_rqmnt_category_id)) " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table CTX_RQMNT_CATEGORY (    ctx_rqmnt_category_id int                            not null,    ctx_req_profile_id   int                            not null,    category_name        varchar(100)  null,    sort_id              int  null,    moduser              varchar(30)  null,    modification_date    datetime  null,    inserted_by_user     varchar(128)  null,    inserted_at_date_time datetime  null,    updated_by_user      varchar(128)  null,    updated_at_date_time datetime  null,    record_id            numeric(10)                    not null default NULL,    primary key (ctx_rqmnt_category_id, ctx_req_profile_id)) " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table DB_CONTROL (    db_control_db        int                            not null,    contract_code_version int  null,    contract_database_version int  null,    module2_code_version int  null,    module2_database_version int  null,    module3_code_version int  null,    module3_database_version int  null,    module4_code_version int  null,    module4_database_version int  null,    module5_code_version int  null,    module5_database_version int  null,    primary key (db_control_db)) " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table ctx_report_profile_hdr (    ctx_rpt_prfl_id      int                            not null,    ctx_rpt_prfl_comment varchar(255)  null,    primary key (ctx_rpt_prfl_id)) " 

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_ACTION_ITEMS   add foreign key FK_CTX_ACTI_FK_CTX_AC_CTX_CONT_ (letter_from)      references CTX_CONTACTS (contact_id)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_ACTION_ITEMS   add foreign key FK_CTX_ACTI_REFERENCE_CODE_LOO_ACTION_TYPE (action_type)      references code_lookup (lookup_code)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_ACTION_ITEMS   add foreign key FK_CTX_ACTI_REFERENCE_CODE_LOO_action_status (action_status)      references code_lookup (lookup_code)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_ACTION_ITEMS   add foreign key FK_CTX_ACTI_FK_CTX_AC_CTX_BASI (ctx_id)      references CTX_BASIC_INFO (ctx_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_ACTION_ITEMS   add foreign key FK_CTX_ACTI_FK_CTX_AC_CTX_CONT (letter_to)      references CTX_CONTACTS (contact_id)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_BASIC_INFO   add foreign key FK_CTX_BASI_FK_CTX_BA_CODE_LOO (category)      references code_lookup (lookup_code)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_BASIC_INFO   add foreign key FK_CTX_BASI_REFERENCE_CODE_LOO_DIVISION (dvision)      references code_lookup (lookup_code)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_BASIC_INFO   add foreign key FK_CTX_BASI_REFERENCE_CODE_LOO_OC_DEPARTMENT (oc_department)      references code_lookup (lookup_code)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_BASIC_INFO   add foreign key FK_CTX_BASI_REFERENCE_CODE_LOO_OC_TITLE (oc_title)      references code_lookup (lookup_code)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_BASIC_INFO   add foreign key FK_CTX_BASI_REFERENCE_CODE_LOO_TERM_REASON (term_reason)      references code_lookup (lookup_code)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_BASIC_INFO   add foreign key FK_CTX_BASI_REFERENCE_CODE_LOO_contract_type (contract_type)      references code_lookup (lookup_code)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_BASIC_INFO   add foreign key FK_CTX_BASI_REFERENCE_CODE_LOO_status (status)      references code_lookup (lookup_code)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_BASIC_INFO   add foreign key FK_CTX_BASI_info_product_type (product_type)      references code_lookup (lookup_code)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_CONTACTS_NUMBERS   add foreign key FK_CTX_CONT_FK_CTX_CO_CTX_CONT2 (contact_id)      references CTX_CONTACTS (contact_id)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_CONTACTS   add foreign key FK_CTX_CONT_REFERENCE_CODE_LOO_CTX_TYPE (contact_type)      references code_lookup (lookup_code)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_CONTACTS   add foreign key FK_CTX_CONT_REFERENCE_CODE_LOO_STATE (state)      references code_lookup (lookup_code)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_CONTACTS_NUMBERS   add foreign key FK_CTX_CONT_REFERENCE_CODE_LOO_VIA (via)      references code_lookup (lookup_code)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_CONTRACT_CONTACTS   add foreign key FK_CTX_CONT_FK_CTX_CO_CTX_BASI (ctx_id)      references CTX_BASIC_INFO (ctx_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_CONTRACT_CONTACTS   add foreign key FK_CTX_CONT_FK_CTX_CO_CTX_CONT (contact_id)      references CTX_CONTACTS (contact_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_ELEMENTS   add foreign key FK_CTX_ELEM_FK_CTX_EL_CTX_REQ_ (CTX_REQ_PROFILE_HDR_id)      references CTX_REQ_PROFILE_HDR (CTX_REQ_PROFILE_HDR_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_FEE_SCHED_DATA   add foreign key FK_CTX_FEE__FK_CTX_FE_CTX_FEE_2 (fee_sched_location_id)      references CTX_FEE_SCHED_LOCATIONS (fee_sched_location_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_FEE_SCHED_LOCATIONS   add foreign key FK_CTX_FEE__FK_CTX_FE_CTX_FEE_LOCATIONS (fee_sched_id)      references CTX_FEE_SCHED_HDR (fee_sched_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_FEE_SCHED_HDR   add foreign key FK_CTX_FEE__REFERENCE_CODE_LOO_cave_out (carve_out_type)      references code_lookup (lookup_code)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_FEE_SCHED_LOCATIONS   add foreign key FK_CTX_FEE__REFERENCE_CODE_LOO_location (location)      references code_lookup (lookup_code)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_FEE_SCHED_DATA   add foreign key FK_CTX_FEE__REFERENCE_CODE_LOO_physl_fee (phys_fee)      references code_lookup (lookup_code)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_FEE_SCHED_HDR   add foreign key FK_CTX_FEE__REFERENCE_CODE_LOO_sched_type (sched_type)      references code_lookup (lookup_code)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_FEE_SCHED_HDR   add foreign key FK_CTX_FEE__FK_CTX_FE_CTX_BASI (ctx_id)      references CTX_BASIC_INFO (ctx_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_FEE_SCHED_PRACS   add foreign key FK_CTX_FEE__FK_CTX_FE_CTX_FEE_ (fee_sched_id)      references CTX_FEE_SCHED_HDR (fee_sched_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_FEE_SCHED_PRACS   add foreign key FK_CTX_FEE__REFERENCE_PD_BASIC_prac_id (practitioner_id)      references pd_basic (prac_id)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_FILE_LOCATION   add foreign key FK_CTX_FILE_FK_CTX_FI_CTX_BASI (ctx_id)      references CTX_BASIC_INFO (ctx_id)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_IMAGES   add foreign key FK_CTX_IMAG_FK_CTX_IM_CTX_BASI (ctx_id)      references CTX_BASIC_INFO (ctx_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_IMAGE   add foreign key FK_CTX_IMAG_FK_CTX_IM_CTX_IMAG (ctx_id, image_id)      references CTX_IMAGES (ctx_id, image_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_LOCATION_SPECIALTY   add foreign key FK_CTX_LOCA_REFERENCE_CODE_LOOKUP_LOOLUP_CODE (Prac_specialty)      references code_lookup (lookup_code)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_LOCATION_CONTACTS   add foreign key FK_CTX_LOCA_FK_CTX_LO_CTX_CONT (contact_id)      references CTX_CONTACTS (contact_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_LOCATION_CONTACTS   add foreign key FK_CTX_LOCA_FK_CTX_LO_CTX_LOC (ctx_id, parent_comp_id, loc_id)      references CTX_LOC (ctx_id, parent_comp_id, loc_id)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_LOCATION_CONTACTS   add foreign key FK_CTX_LOCA_REFERENCE_CTX_LOC1 (loc_id, parent_comp_id, ctx_id)      references CTX_LOC (loc_id, parent_comp_id, ctx_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_LOCATION_SPECIALTY   add foreign key FK_CTX_LOCA_REFERENCE_CTX_LOCCATION_SPEC_LOC_ID (loc_id, ctx_id, parent_comp_id)      references CTX_LOC (loc_id, ctx_id, parent_comp_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_LOC   add foreign key FK_CTX_LOC_FK_CTX_LO_CTX_BASI (ctx_id)      references CTX_BASIC_INFO (ctx_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_NOTIFICATION_USERS   add foreign key FK_CTX_NOTI_FK_CTX_NO_CTX_BASI (ctx_id)      references CTX_BASIC_INFO (ctx_id)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_NOTIFICATION_USERS   add foreign key FK_CTX_NOTI_FK_CTX_NO_CTX_NOTI (ctx_id, alm_column, alm_table)      references CTX_NOTIFICATION (ctx_id, alm_column, alm_table)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_ORGS   add foreign key FK_CTX_ORGS_REFERENCE_CODE_LOO_org_type (org_type)      references code_lookup (lookup_code)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_ORGS   add foreign key FK_CTX_ORGS_REFERENCE_CODE_LOO_state (state)      references code_lookup (lookup_code)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_ORGS   add foreign key FK_CTX_ORGS_REFERENCE_CODE_LOO_status (status)      references code_lookup (lookup_code)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_ORGS_CONTACT   add foreign key FK_CTX_ORGS_FK_CTX_OR_CTX_BASI (ctx_id)      references CTX_BASIC_INFO (ctx_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_ORGS_CONTACT   add foreign key FK_CTX_ORGS_FK_CTX_OR_CTX_ORGS (org_id)      references CTX_ORGS (org_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_ORG_CONTACT   add foreign key FK_CTX_ORG__REFERENCE_CODE_LOO_via (via)      references code_lookup (lookup_code)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_ORG_CONTACT   add foreign key FK_CTX_ORG__FK_CTX_OR_CTX_ORGS (org_id)      references CTX_ORGS (org_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_REPORT_PROFILE_DET   add foreign key FK_CTX_REPO_FK_CTX_RE_CTX_REPO (ctx_rpt_prfl_id)      references ctx_report_profile_hdr (ctx_rpt_prfl_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_REQ_PROFILE_HDR   add foreign key FK_CTX_REQ__FK_CTX_RE_CTX_BASI (ctx_id)      references CTX_BASIC_INFO (ctx_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_REQ_TMPLT_ELEMENT   add foreign key FK_CTX_REQ__REFERENCE_CTX_REQ (ctx_req_profile_id)      references CTX_REQ_PROFILE (ctx_req_profile_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_REQ_PROFILE_HDR   add foreign key FK_CTX_REQ__FK_CTX_RE_CTX_REQ_ (ctx_req_profile_id)      references CTX_REQ_PROFILE (ctx_req_profile_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_RQMNT_CATEGORY   add foreign key FK_CTX_RQMN_FK_CTX_RQ_CTX_REQ_ (ctx_req_profile_id)      references CTX_REQ_PROFILE (ctx_req_profile_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_NOTIFICATION   add foreign key FK_ctx_notification_to_ctx_basic_info (ctx_id)      references CTX_BASIC_INFO (ctx_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_HIERCHY_ACCESS   add foreign key FK_CTX_HIER_REFERENCE_CTX_ITEM (item_id)      references CTX_ITEM (item_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_HIERCHY_ACCESS   add foreign key FK_CTX_HIER_REFERENCE_CTX_ITEM (item_level)      references CTX_ITEM (item_id)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_HIERCHY_ACCESS   add foreign key FK_CTX_HIER_REFERENCE_CTX_ITEM (item_level)      references CTX_ITEM_LEVEL (level_name)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_HIERCHY_ACCESS   add foreign key FK_CTX_HIER_REFERENCE_CTX_ITEM (parent_level)      references CTX_ITEM_LEVEL (level_num)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_ITEM_HIERARCHY   add foreign key FK_CTX_ITEM_REFERENCE_CTX_ITEM (item_level)      references CTX_ITEM_LEVEL (level_num)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_ITEM_HIERARCHY   add foreign key FK_CTX_ITEM_REFERENCE_CTX_ITEM (parent_id)      references CTX_ITEM (item_id)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_ITEM_HIERARCHY   add foreign key FK_CTX_ITEM_REFERENCE_CTX_ITEM (item_id)      references CTX_ITEM (item_id)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_CPT_CODE_ITEM   add foreign key FK_CTX_CPT__REFERENCE_CTX_ITEM (ITEM_ID)      references CTX_ITEM (item_id)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_CPT_CODE_ITEM   add foreign key FK_CTX_CPT__REFERENCE_CTX_CPT_ (CPT_CODE_ID, )      references CTX_CPT_CODES (cpt_code_id, cpt_code)      on update restrict      on delete cascade " 

of_init_data()
return 0
end function

private function integer of_create_asa_database ();/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner   © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

long ll_i
long ll_start_version

///////////////////////////////////////////////////////////////////////////////////
// cycle through 
///////////////////////////////////////////////////////////////////////////////////
ll_start_version = il_database_version
boolean lb_version60 = false
for ll_i = ll_start_version to  20

	CHOOSE CASE ll_i
		case 0 // runs all versions the first time
			  of_asa_0_changes()
			  
			  of_report_sql( ) 
			  il_database_version = ll_i + 1 // this should be the max db version.
			  of_execute_sql( )
	
		case 1 // going to two
			// of_drop_frn_keys( )
			 of_asa_1_changes()
			 of_report_sql( ) 
			 il_database_version++
			// of_add_fgn_keys( )
			 il_database_version = ll_i + 1
			 of_execute_sql( )
		case 2 // going to three
			 //of_drop_frn_keys( )
			 of_asa_2_changes()
			// of_add_fgn_keys( )
			 il_database_version = ll_i + 1
			 of_execute_sql( )
			
		case 3 // going to four
			// of_drop_frn_keys( )
			 of_asa_3_changes()
			// of_add_fgn_keys( )
			 il_database_version = ll_i + 1
	  case 4 // going to five
			// of_drop_frn_keys( )
			 of_asa_4_changes()
			// of_add_fgn_keys( )
			 il_database_version = ll_i + 1
			 of_execute_sql( )
		case 5 // going to six
			// of_drop_frn_keys( )
			 of_asa_5_changes()
		//	 of_add_fgn_keys( )
			 il_database_version = ll_i + 1
			 of_execute_sql( )
		case 6 // going to seven
	//		 of_drop_frn_keys( )
			 of_asa_6_changes()
	//		 of_add_fgn_keys( )
			 il_database_version = ll_i + 1
			 of_execute_sql( )
		case 7 
			// of_drop_frn_keys( )
			 of_asa_7_changes()
			// of_add_fgn_keys( )
			 il_database_version = ll_i + 1
			 of_execute_sql( )
		case 9 
			// of_drop_frn_keys( )
			 of_asa_9_changes()
			// of_add_fgn_keys( )
			 il_database_version = ll_i + 1
			 of_execute_sql( )
		case 10 
		
			 of_asa_10_changes()
			 il_database_version = ll_i + 1
			 of_execute_sql( )
		case 11
			// of_drop_frn_keys( )
			 of_asa_11_changes()
			 of_add_fgn_keys( )
			 il_database_version = ll_i + 1
			 of_execute_sql( )
	
			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 2006-08-07 By: Rodger Wu (Contract)
			//$<reason> Database Modification for Contract Module
			of_appeon1_changes()
			of_execute_sql( )
			//$<delete> 2008-03-20 By: nova
			//$<reason> this before update screen.
			//of_appeon2_changes()
			//
			lb_version60 = true
			//---------------------------- APPEON END ----------------------------
			
	case else
			
	end choose 
	
next

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 9/28/2006 By: Rodger Wu (Contract). 
//If the il_database_version fron table db_control if more than 11, then update the DB directly.
//This is a provisional modification, The update logic should be clear defined in future.
If not lb_version60 Then
	of_drop_frn_keys( )
	of_asa_11_changes()
	of_add_fgn_keys( )
	il_database_version = ll_i + 1
	of_execute_sql( )
	
	of_appeon1_changes()
	of_execute_sql( )
	//$<delete> 2008-03-20 By: nova
	//$<reason> this before update screen.
	//of_appeon2_changes()
End if
//---------------------------- APPEON END ----------------------------

return 0

end function

private function integer of_set_cpt_codes ();/******************************************************************************************************************
**  [PUBLIC]   : of_set_cpt_codes
**==================================================================================================================
**  Purpose   	: Add the inital cpt codes
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 03 November 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

//// drop data we created, not customer data
//// craete 'table'
//
//constant string cpt_code_table = 'Contact - CPT Codes'
//
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name =" + cpt_code_table  + " and ic_c = 'Y' "
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_c) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  + ',' + cpt_code_table + ",'xxxxx','xxxxx','Y') " 
//
//
return 0
end function

private function integer of_init_data ();/******************************************************************************************************************
**  [PUBLIC]   : of_init_data( )
**==================================================================================================================
**  Purpose   	: Set the init data for contracts
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 03 November 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


if il_database_version > 0 then return 0

/*************************************************************************************************************************************************************/
/****************************************************  seed data *********************************************************************************************/
/**************************************************************************************************************************************************************/

/*************************************************** delete the current data ********************************************************************************************/

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'Contact Type';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'Contract Status';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'Contract Category';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'Contract Type';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'Contract Product Type';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'Contract Logo Responsibiility';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'Contract Credentialing Meeting';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'Contract Credentialing Meeting';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'Contract Allowable Billings';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'Contract Contact Type';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'Contract Contact VIA';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'Contract Organization Type';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'Contract Schedule Type';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'Contract Carve Out Code Type';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'Contract Fee Basis';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'Contract Local Code';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'Contract Product Name';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'Contract Term Reason';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'Contract Division';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'Contract Action Type';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'Contract Department';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'Contract Authorization Requirements';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'Contract Precert. Requirements';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'Contract Action Status';"

/********************************************* insert the data ***************************************************************************************/
// Contact Type
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Type','DIRGP','Direct Group') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contact Type','INDV','Individual') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contact Type','MSO','MSO') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contact Type','IPA','IPA') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contact Type','PHO','PHO') " 
// Contract Status
// start code change --- 11.09.2005 MSKINNER
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Status','ACTIVE','Active','S') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Status','HISTORY','History','S') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Status','EXPIRED','Expired','S') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Status','CANCELED','Canceled','S') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Status','INACTIVE','Inactive','S') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Status','PENDING','Pending','S') " 
// end code change --- 11.09.2005 MSKINNER
// Contract Category
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Category','PAYERCTX','Payer Contract') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Category','DRUGCO','Drug Company') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Category','EQUIPLEASE','Equipment Lease') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Category','PHONESERV','Phone Service') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Category','WEBCOMM.','Web Communications') " 
// Contract Type
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Type','GROUP','Group') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Type','INDIVIDUAL','Individual') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Type','MSO','MSO') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Type','IPA','IPA') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Product Type','HMO','HMO') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Product Type','PPO','PPO') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Product Type','EPPO','EPPO') " 
// Contract Logo Responsibiility
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Logo Responsibiility','PAYOR','Payor') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Logo Responsibiility','NETWORK','Network') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Logo Responsibiility','OTHER','Other') "
// Contract Credentialing Meeting
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Credentialing Meeting' ,'1STMONTH','1st of Month') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Credentialing Meeting' ,'BI-WEEKLY','Bi-Weekly') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Credentialing Meeting' ,'WEEKLY','Weekly') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Credentialing Meeting' ,'15MONTH','15 of Each Month') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Credentialing Meeting' ,'EVERYOTHRWEEK','Every Other Week') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Credentialing Meeting' ,'2NDWDMONTH','2nd Wednesday of each Month') " 
// Contract Allowable Billings
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Allowable Billings' ,'DEDUCTIBLES','Deductibles') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Allowable Billings' ,'COPAYS','Co Pays') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Allowable Billings' ,'NON-CVD-SERV','Non covered Services') " 
// Contract Contact Type
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Contact Type' ,'CTXMGR','Contract Manager') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Contact Type' ,'PRECERT','Precertifications') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Contact Type' ,'AUTHOR','Authorizations') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Contact Type' ,'CLAIMSPRO','Claims Processing') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Contact Type' ,'PROVIDERREL','Provider Relations') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Contact Type' ,'LEGAL','Legal') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Contact Type' ,'OTHER','Other') "
// Contract Contact VIA
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Contact VIA' ,'PHONE','Phone') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Contact VIA' ,'FAX','Fax') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Contact VIA' ,'EMAIL','EMail') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Contact VIA' ,'PAGER','Pager') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Contact VIA' ,'CELL','Cell') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Contact VIA' ,'WEB','WEB') " 
// Contract Organization Type
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Organization Type' ,'PARTIHOSP','Participating Hospital') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Organization Type' ,'LAB','Lab') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Organization Type' ,'WORKCOMP','WorkMan Comp.') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Organization Type' ,'PAYOR','Payor') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Organization Type' ,'OTHER','Other') " 
// Contract Schedule Type
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Schedule Type' ,'GROUP','Group') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Schedule Type' ,'CARVEOUT','Carve Out') " 
// Contract Carve Out Code Type
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Carve Out Code Type' ,'PHYSICIAN','Physican') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Carve Out Code Type' ,'SPECIALITY','Speciality') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Carve Out Code Type' ,'TEST','Test') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Carve Out Code Type' ,'N/A','NA') " 
// Contract Fee Basis
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Fee Basis' ,'04MEDICARE','2004 MEDICARE') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Fee Basis' ,'05MEDICARE','2005 MEDICARE') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Fee Basis' ,'RVRVS','RVRVS') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Fee Basis' ,'LOCALITY','LOCALITY') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Fee Basis' ,'PBC','Percentage of Billed Charges') " 
// Contract Local Code
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Local Code' ,'ALL','ALL') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Local Code' ,'03','03') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Local Code' ,'04','04') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Local Code' ,'05','05') " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Local Code' ,'06','06') " 
// product name
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Product Name' ,'Product 1','Product 1') "
// term reason
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Term Reason' ,'Term Reason 1','Term Reason 1') "
// Contract Division
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Division' ,'Division 1','Division 1') "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Division' ,'Division 2','Division 2') "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Division' ,'Division 3','Division 3') "
// Contract Action Type
// start code change --- 11.09.2005 MSKINNER
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Action Type' ,'AUTOMSG'    ,'System Generated Email','S') "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Action Type' ,'AlmTmDt'    ,'Term Date Alarm','S') "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Action Type' ,'AlmEffDt'   ,'Effective Date Alarm','S') "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Action Type' ,'AlmRevDt'   ,'Review Date Alarm','S') "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Action Type' ,'AlmCusDt'   ,'Custom Date Alarm','S') "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Action Type' ,'AlmExpDt'   ,'Expriation Date Alarm','S') "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Action Type' ,'AlmLstRvDT' ,'Last Revistion Date Alarm','S') "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Action Type' ,'AlmCus2DT'  ,'Custom Date 2 Alarm','S') "

// start code change --- 11.09.2005 MSKINNER
//Contract Department
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Department' ,'Purchasing','Purchasing') "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Department' ,'Administration','Administration') "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Department' ,'Contracting','Contracting') "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Department' ,'Legal','Legal') "
// Contract Action Type
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Action Type' ,'Expiring','Expiring') "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Action Type' ,'Renegotiate','Renegotiate') "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Action Type' ,'Follow Up','Follow Up') "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Action Type' ,'Call','Call') "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Action Type' ,'Email','Email') "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Action Type' ,'Sent Letter','Sent Letter') "
// Contract Action Type - protected fields (type = S)
// start code change --- 11.09.2005 MSKINNER
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type,custom_6) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Action Type' ,'EffDtLtr','Effective Date Letter','S','contract_EffDtLtr.doc') ;"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type,custom_6) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Action Type' ,'RevDtLtr','Review Date Letter','S', 'contract_RevDtLtr.doc') ;"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type,custom_6) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Action Type' ,'ExpDtLtr','Expiration Date Letter','S','contract_ExpDtLtr.doc') ;"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type,custom_6) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Action Type' ,'CusDtLtr','Custom Date Letter','S','contract_CusDtLtr.doc') ;"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type,custom_6) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Action Type' ,'Cus2DtLtr','Custom Date 2 Letter','S','contract_Cus2DtLtr.doc') ;"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type,custom_6) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Action Type' ,'TermDtLtr','Term Date Letter','S','contract_TermDtLtr.doc') ;"

/*Contract Action Status*/
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Action Status' ,'Complete','The action has been completed','S',) ;"

//Contract Precert. Requirements
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Precert. Requirements' ,'Tilt/Test','Tilt/Test') "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Precert. Requirements' ,'Stent','Stent') "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Precert. Requirements' ,'TEE','TEE') "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Precert. Requirements' ,'Lf Heart','Lf Heart') "
//Contract Authorization Requirements
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Authorization Requirements' ,'Echo','Echo') "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Authorization Requirements' ,'Treadmill','Treadmill') "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Authorization Requirements' ,'Ultra Sound','Ultra Sound') "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Authorization Requirements' ,'Nuclear Stress Test','Nuclear Stress Test') "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO db_control  (db_control_db	,contract_database_version,code,description) VALUES (1,0) "

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 05.09.2007 By: Jack
//$<reason> Fix a defect.	
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE CODE_LOOKUP SET CUSTOM_6 = 'PayorCTX' WHERE LOOKUP_NAME = 'Contract Category' "	
//---------------------------- APPEON END ----------------------------

of_add_audit()

of_set_cpt_codes( )




return 0
end function

private function integer of_init ();/******************************************************************************************************************
**  [PUBLIC]   : cREATE THE DB_CONTROL TABLE 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


string ls_null_array[]

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table DB_CONTROL (    db_control_db        int                            not null,    contract_code_version int,    contract_database_version int,    module2_code_version int,    module2_database_version int,    module3_code_version int,    module3_database_version int,    module4_code_version int,    module4_database_version int,    module5_code_version int,    module5_database_version int,    primary key (db_control_db)) " 
setnull(il_database_version )
of_execute_sql( )
ls_sql_statments = ls_null_array


lds_db_control =  create n_ds
lds_db_control.dataobject = 'd_db_control'
lds_db_control.of_settransobject(sqlca)
lds_db_control.retrieve( )  

return 0
end function

private function integer of_execute_sql ();/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner 10 February 2006  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
long ll_i
string ls_null[]
boolean lb_ref_cache

IF UPPERBOUND(ls_sql_statments) > 0 THEN  lb_ref_cache  = true

IF not isvalid(inv_logservice) THEN
	inv_logservice = create n_logservice
END IF


IF UPPERBOUND(ls_sql_statments) > 0 THEN 
	   ls_sql_statments[upperbound(ls_sql_statments) + 1] = "commit;"
		
//		IF IB_SHOW_UPDATE_WINDOW = TRUE THEN 
//	       open(w_infodisp)
//	   END IF

		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 2006-09-27 By: Rodger Wu
		//$<reason> Fix a defect.
		if Not isvalid( w_infodisp ) then open(w_infodisp)
		//---------------------------- APPEON END ----------------------------

		if isvalid(w_infodisp) then w_infodisp.title = 'Creating Contract Module tables and seed data, Please stand by'
		if isvalid(w_infodisp) then w_infodisp.Center = TRUE
		if isvalid(w_infodisp) then w_infodisp.st_complete.visible = false
		if isvalid(w_infodisp) then w_infodisp.st_3.visible = false
		if isvalid(w_infodisp) then w_infodisp.st_information.visible = false
		if isvalid(w_infodisp) then w_infodisp.st_1.text = 'Creating Contract Module Tabels and seed data, Please stand by for version: ' + string(il_database_version) 
		if isvalid(w_infodisp) then w_infodisp.wf_set_min_max(1,upperbound(ls_sql_statments))
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<ID> PT-02
		//$<add> 03.14.2006 By: LeiWei
		//$<reason> Performance tuning
		//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

		gnv_appeondb.of_startqueue( )
		//---------------------------- APPEON END ----------------------------

		FOR ll_i = 1 TO upperbound(ls_sql_statments)
			if isvalid(w_infodisp) then w_infodisp.st_1.text = 'Modification:' +string(ll_i) +' of '+ string(upperbound(ls_sql_statments)) +' Please stand by!'
				 EXECUTE IMMEDIATE :ls_sql_statments[LL_I] using sqlca;
				 inv_logservice.of_log_sqlca()
				 IF len(sqlca.sqlerrtext) > 0 THEN
					// Added by Davis 11.14.2006
					IF handle(getapplication()) = 0 THEN
//						messagebox(string(LL_I), string(sqlca.sqlerrtext)  + new_line + error.object + new_line +    string(ls_sql_statments[LL_I]) + new_line + "Please contact software vendor."   )
					END IF
					// Added by Davis 11.14.2006

					else
				  commit;
					
				END IF
				if isvalid(w_infodisp) then w_infodisp.wf_step_pbar(1)
		NEXT
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<ID> PT-03
		//$<add> 03.14.2006 By: LeiWei
		//$<reason> Performance tuning
		//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

		gnv_appeondb.of_commitqueue( )
		//---------------------------- APPEON END ----------------------------

		if isvalid(w_infodisp) then w_infodisp.st_1.text = 'Commiting modifications Please stand by!'
		
      if isvalid(w_infodisp) then close(w_infodisp)
     if not isnull(il_database_version) then 
		//  il_database_version = il_database_version + 1 
		  lds_db_control.SetItem(1,'contract_database_version',il_database_version)
		  
			//--------------------------- APPEON BEGIN ---------------------------
			//$<ID> PT-04
			//$<add> 03.14.2006 By: LeiWei
			//$<reason> Performance tuning
			//$<modification> Add Appeon commit label to reduce client-server interactions to improve runtime performance.

			gnv_appeondb.of_autocommit( )
			//---------------------------- APPEON END ----------------------------

		  lds_db_control.update()
		  inv_logservice.of_log_sqlca()
		  commit;
//		  IF lb_ref_cache THEN 
//			gnv_app.ib_ref_cache = true 
//			gnv_app.of_setcontraccache( )
//		end if 
		  
	  end if 
	  
END IF


if il_database_version = 2 then 
	
	long il_active_code
	select lookup_code  
	into :il_active_code
	from code_lookup
	where lookup_name = 'Contract Status' and code = 'active';
	
	UPDATE "ctx_fee_sched_data"  
   SET "status" = :il_active_code where "status" is null;
	inv_logservice.of_log_sqlca()
	commit;
	
end if 

ls_sql_statments = ls_null


return 0
end function

private function integer of_create_mss_database ();/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner   © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

long ll_i
long ll_start_version

///////////////////////////////////////////////////////////////////////////////////
// cycle through 
///////////////////////////////////////////////////////////////////////////////////
ll_start_version = il_database_version

for ll_i = ll_start_version   to 100

	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 2006-08-07 By: Rodger Wu (Contract)
	//$<reason> Database Modification for Contract Module
	
	/*
	CHOOSE CASE il_database_version
		case 0
//		  of_mss_0_changes()
	end choose 
	*/
	CHOOSE CASE ll_i
		case 0
//			of_mss_0_changes()
		case 100
			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 11.16.2006 By: Davis
			//$<reason> Old DB updates.
			
			of_appeon_sqlserver_update1()
			of_execute_sql( )

			//---------------------------- APPEON END ----------------------------

			of_appeon1_changes()
			of_execute_sql( )
			//$<delete> 2008-03-20 By: nova
			//$<reason> this before update screen.
			//of_appeon2_changes()
			//of_update_screen()	08.03.2007 By Jervis
			
	END CHOOSE
	//---------------------------- APPEON END ----------------------------
next

return 0

end function

public function integer of_drop_frn_keys ();ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_ACTI_FK_CTX_AC_CTX_CONT_') then    alter table CTX_ACTION_ITEMS       delete foreign key FK_CTX_ACTI_FK_CTX_AC_CTX_CONT_ end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_ACTI_REFERENCE_CODE_LOO_ACTION_TYPE') then    alter table CTX_ACTION_ITEMS       delete foreign key FK_CTX_ACTI_REFERENCE_CODE_LOO_ACTION_TYPE end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_ACTI_REFERENCE_CODE_LOO_action_status') then    alter table CTX_ACTION_ITEMS       delete foreign key FK_CTX_ACTI_REFERENCE_CODE_LOO_action_status end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_ACTI_FK_CTX_AC_CTX_BASI') then    alter table CTX_ACTION_ITEMS       delete foreign key FK_CTX_ACTI_FK_CTX_AC_CTX_BASI end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_ACTI_FK_CTX_AC_CTX_CONT') then    alter table CTX_ACTION_ITEMS       delete foreign key FK_CTX_ACTI_FK_CTX_AC_CTX_CONT end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_BASI_FK_CTX_BA_CODE_LOO') then    alter table CTX_BASIC_INFO       delete foreign key FK_CTX_BASI_FK_CTX_BA_CODE_LOO end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_BASI_REFERENCE_CODE_LOO_DIVISION') then    alter table CTX_BASIC_INFO       delete foreign key FK_CTX_BASI_REFERENCE_CODE_LOO_DIVISION end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_BASI_REFERENCE_CODE_LOO_OC_DEPARTMENT') then    alter table CTX_BASIC_INFO       delete foreign key FK_CTX_BASI_REFERENCE_CODE_LOO_OC_DEPARTMENT end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_BASI_REFERENCE_CODE_LOO_OC_TITLE') then    alter table CTX_BASIC_INFO       delete foreign key FK_CTX_BASI_REFERENCE_CODE_LOO_OC_TITLE end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_BASI_REFERENCE_CODE_LOO_TERM_REASON') then    alter table CTX_BASIC_INFO       delete foreign key FK_CTX_BASI_REFERENCE_CODE_LOO_TERM_REASON end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_BASI_REFERENCE_CODE_LOO_contract_type') then    alter table CTX_BASIC_INFO       delete foreign key FK_CTX_BASI_REFERENCE_CODE_LOO_contract_type end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_BASI_REFERENCE_CODE_LOO_status') then    alter table CTX_BASIC_INFO       delete foreign key FK_CTX_BASI_REFERENCE_CODE_LOO_status end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_BASI_info_product_type') then    alter table CTX_BASIC_INFO       delete foreign key FK_CTX_BASI_info_product_type end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_CONT_FK_CTX_CO_CTX_CONT2') then    alter table CTX_CONTACTS_NUMBERS       delete foreign key FK_CTX_CONT_FK_CTX_CO_CTX_CONT2 end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_CONT_REFERENCE_CODE_LOO_CTX_TYPE') then    alter table CTX_CONTACTS       delete foreign key FK_CTX_CONT_REFERENCE_CODE_LOO_CTX_TYPE end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_CONT_REFERENCE_CODE_LOO_STATE') then    alter table CTX_CONTACTS       delete foreign key FK_CTX_CONT_REFERENCE_CODE_LOO_STATE end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_CONT_REFERENCE_CODE_LOO_VIA') then    alter table CTX_CONTACTS_NUMBERS       delete foreign key FK_CTX_CONT_REFERENCE_CODE_LOO_VIA end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_CONT_FK_CTX_CO_CTX_BASI') then    alter table CTX_CONTRACT_CONTACTS       delete foreign key FK_CTX_CONT_FK_CTX_CO_CTX_BASI end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_CONT_FK_CTX_CO_CTX_CONT') then    alter table CTX_CONTRACT_CONTACTS       delete foreign key FK_CTX_CONT_FK_CTX_CO_CTX_CONT end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_CPT__FK_CTX_CP_CTX_CPT_') then    alter table CTX_CPT_CODE_ITEM       delete foreign key FK_CTX_CPT__FK_CTX_CP_CTX_CPT_ end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_CPT__FK_CTX_CP_CTX_ITEM') then    alter table CTX_CPT_CODE_ITEM       delete foreign key FK_CTX_CPT__FK_CTX_CP_CTX_ITEM end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_ELEM_FK_CTX_EL_CTX_REQ_') then    alter table CTX_ELEMENTS       delete foreign key FK_CTX_ELEM_FK_CTX_EL_CTX_REQ_ end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_FEE__FK_CTX_FE_CTX_FEE_2') then    alter table CTX_FEE_SCHED_DATA       delete foreign key FK_CTX_FEE__FK_CTX_FE_CTX_FEE_2 end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_FEE__FK_CTX_FE_CTX_FEE_LOCATIONS') then    alter table CTX_FEE_SCHED_LOCATIONS       delete foreign key FK_CTX_FEE__FK_CTX_FE_CTX_FEE_LOCATIONS end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_FEE__REFERENCE_CODE_LOO_cave_out') then    alter table CTX_FEE_SCHED_HDR       delete foreign key FK_CTX_FEE__REFERENCE_CODE_LOO_cave_out end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_FEE__REFERENCE_CODE_LOO_location') then    alter table CTX_FEE_SCHED_LOCATIONS       delete foreign key FK_CTX_FEE__REFERENCE_CODE_LOO_location end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_FEE__REFERENCE_CODE_LOO_physl_fee') then    alter table CTX_FEE_SCHED_DATA       delete foreign key FK_CTX_FEE__REFERENCE_CODE_LOO_physl_fee end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_FEE__REFERENCE_CODE_LOO_sched_type') then    alter table CTX_FEE_SCHED_HDR       delete foreign key FK_CTX_FEE__REFERENCE_CODE_LOO_sched_type end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_FEE__FK_CTX_FE_CTX_BASI') then    alter table CTX_FEE_SCHED_HDR       delete foreign key FK_CTX_FEE__FK_CTX_FE_CTX_BASI end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_FEE__FK_CTX_FE_CTX_CPT_') then    alter table CTX_FEE_SCHED_LOCATIONS       delete foreign key FK_CTX_FEE__FK_CTX_FE_CTX_CPT_ end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_FEE__FK_CTX_FE_CTX_FEE_') then    alter table CTX_FEE_SCHED_PRACS       delete foreign key FK_CTX_FEE__FK_CTX_FE_CTX_FEE_ end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_FEE__REFERENCE_PD_BASIC_prac_id') then    alter table CTX_FEE_SCHED_PRACS       delete foreign key FK_CTX_FEE__REFERENCE_PD_BASIC_prac_id end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_FILE_FK_CTX_FI_CTX_BASI') then    alter table CTX_FILE_LOCATION       delete foreign key FK_CTX_FILE_FK_CTX_FI_CTX_BASI end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_HIER_FK_CTX_HI_CTX_ITEM') then    alter table CTX_HIERCHY_ACCESS       delete foreign key FK_CTX_HIER_FK_CTX_HI_CTX_ITEM end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_HIER_REFERENCE_CTX_ITEM_item_level') then    alter table CTX_HIERCHY_ACCESS       delete foreign key FK_CTX_HIER_REFERENCE_CTX_ITEM_item_level end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_HIER_REFERENCE_CTX_ITEM_itm_lvl') then    alter table CTX_HIERCHY_ACCESS       delete foreign key FK_CTX_HIER_REFERENCE_CTX_ITEM_itm_lvl end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_HIER_REFERENCE_CTX_ITEM_prnt_lvl') then    alter table CTX_HIERCHY_ACCESS       delete foreign key FK_CTX_HIER_REFERENCE_CTX_ITEM_prnt_lvl end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_IMAG_FK_CTX_IM_CTX_BASI') then    alter table CTX_IMAGES       delete foreign key FK_CTX_IMAG_FK_CTX_IM_CTX_BASI end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_IMAG_FK_CTX_IM_CTX_IMAG') then    alter table CTX_IMAGE       delete foreign key FK_CTX_IMAG_FK_CTX_IM_CTX_IMAG end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_ITEM_REFERENCE_CTX_ITEM_item_level') then    alter table CTX_ITEM_HIERARCHY       delete foreign key FK_CTX_ITEM_REFERENCE_CTX_ITEM_item_level end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_ITEM_REFERENCE_CTX_ITEM_itm_itm') then    alter table CTX_ITEM_HIERARCHY       delete foreign key FK_CTX_ITEM_REFERENCE_CTX_ITEM_itm_itm end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_ITEM_REFERENCE_CTX_ITEM_parent_itm') then    alter table CTX_ITEM_HIERARCHY       delete foreign key FK_CTX_ITEM_REFERENCE_CTX_ITEM_parent_itm end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_LOCA_REFERENCE_CODE_LOOKUP_LOOLUP_CODE') then    alter table CTX_LOCATION_SPECIALTY       delete foreign key FK_CTX_LOCA_REFERENCE_CODE_LOOKUP_LOOLUP_CODE end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_LOCA_FK_CTX_LO_CTX_CONT') then    alter table CTX_LOCATION_CONTACTS       delete foreign key FK_CTX_LOCA_FK_CTX_LO_CTX_CONT end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_LOCA_FK_CTX_LO_CTX_LOC') then    alter table CTX_LOCATION_CONTACTS       delete foreign key FK_CTX_LOCA_FK_CTX_LO_CTX_LOC end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_LOCA_REFERENCE_CTX_LOC1') then    alter table CTX_LOCATION_CONTACTS       delete foreign key FK_CTX_LOCA_REFERENCE_CTX_LOC1 end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_LOCA_REFERENCE_CTX_LOCCATION_SPEC_LOC_ID') then    alter table CTX_LOCATION_SPECIALTY       delete foreign key FK_CTX_LOCA_REFERENCE_CTX_LOCCATION_SPEC_LOC_ID end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_LOC_FK_CTX_LO_CTX_BASI') then    alter table CTX_LOC       delete foreign key FK_CTX_LOC_FK_CTX_LO_CTX_BASI end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_NOTI_FK_CTX_NO_CTX_BASI') then    alter table CTX_NOTIFICATION_USERS       delete foreign key FK_CTX_NOTI_FK_CTX_NO_CTX_BASI end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_NOTI_FK_CTX_NO_CTX_NOTI') then    alter table CTX_NOTIFICATION_USERS       delete foreign key FK_CTX_NOTI_FK_CTX_NO_CTX_NOTI end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_ORGS_REFERENCE_CODE_LOO_org_type') then    alter table CTX_ORGS       delete foreign key FK_CTX_ORGS_REFERENCE_CODE_LOO_org_type end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_ORGS_REFERENCE_CODE_LOO_state') then    alter table CTX_ORGS       delete foreign key FK_CTX_ORGS_REFERENCE_CODE_LOO_state end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_ORGS_REFERENCE_CODE_LOO_status') then    alter table CTX_ORGS       delete foreign key FK_CTX_ORGS_REFERENCE_CODE_LOO_status end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_ORGS_FK_CTX_OR_CTX_BASI') then    alter table CTX_ORGS_CONTACT       delete foreign key FK_CTX_ORGS_FK_CTX_OR_CTX_BASI end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_ORGS_FK_CTX_OR_CTX_ORGS') then    alter table CTX_ORGS_CONTACT       delete foreign key FK_CTX_ORGS_FK_CTX_OR_CTX_ORGS end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_ORG__REFERENCE_CODE_LOO_via') then    alter table CTX_ORG_CONTACT       delete foreign key FK_CTX_ORG__REFERENCE_CODE_LOO_via end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_ORG__FK_CTX_OR_CTX_ORGS') then    alter table CTX_ORG_CONTACT       delete foreign key FK_CTX_ORG__FK_CTX_OR_CTX_ORGS end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_REPO_FK_CTX_RE_CTX_REPO') then    alter table CTX_REPORT_PROFILE_DET       delete foreign key FK_CTX_REPO_FK_CTX_RE_CTX_REPO end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_REQ__FK_CTX_RE_CTX_BASI') then    alter table CTX_REQ_PROFILE_HDR       delete foreign key FK_CTX_REQ__FK_CTX_RE_CTX_BASI end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_REQ__REFERENCE_CTX_REQ') then    alter table CTX_REQ_TMPLT_ELEMENT       delete foreign key FK_CTX_REQ__REFERENCE_CTX_REQ end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_REQ__FK_CTX_RE_CTX_REQ_') then    alter table CTX_REQ_PROFILE_HDR       delete foreign key FK_CTX_REQ__FK_CTX_RE_CTX_REQ_ end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_RQMN_FK_CTX_RQ_CTX_REQ_') then    alter table CTX_RQMNT_CATEGORY       delete foreign key FK_CTX_RQMN_FK_CTX_RQ_CTX_REQ_ end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_ctx_notification_to_ctx_basic_info') then    alter table CTX_NOTIFICATION       delete foreign key FK_ctx_notification_to_ctx_basic_info end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_LOCA_REFERENCE_CTX_LOC') then    alter table CTX_LOCATION_PRACS       delete foreign key FK_CTX_LOCA_REFERENCE_CTX_LOC end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_contacts_user')               then  alter table ctx_contacts delete foreign key FK_contacts_user end if"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_FEE__REFERENCE_CTX_BASI') then alter table CTX_FEE_SCHED_NM delete foreign key FK_CTX_FEE__REFERENCE_CTX_BASI end if;"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_LOCA_REFERENCE_GROUP_PR') then alter table CTX_LOCATION_PRACS delete foreign key FK_CTX_LOCA_REFERENCE_GROUP_PR end if;"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_PROD_REFERENCE_CTX_BASI') then alter table ctx_products delete foreign key FK_CTX_PROD_REFERENCE_CTX_BASi end if ;"

return 0
end function

public function integer of_add_fgn_keys ();
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_ACTION_ITEMS   add foreign key FK_CTX_ACTI_FK_CTX_AC_CTX_CONT_ (letter_from)      references CTX_CONTACTS (contact_id)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_ACTION_ITEMS   add foreign key FK_CTX_ACTI_REFERENCE_CODE_LOO_ACTION_TYPE (action_type)      references code_lookup (lookup_code)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_ACTION_ITEMS   add foreign key FK_CTX_ACTI_REFERENCE_CODE_LOO_action_status (action_status)      references code_lookup (lookup_code)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_ACTION_ITEMS   add foreign key FK_CTX_ACTI_FK_CTX_AC_CTX_BASI (ctx_id)      references CTX_BASIC_INFO (ctx_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_ACTION_ITEMS   add foreign key FK_CTX_ACTI_FK_CTX_AC_CTX_CONT (letter_to)      references CTX_CONTACTS (contact_id)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_BASIC_INFO   add foreign key FK_CTX_BASI_FK_CTX_BA_CODE_LOO (category)      references code_lookup (lookup_code)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_BASIC_INFO   add foreign key FK_CTX_BASI_REFERENCE_CODE_LOO_DIVISION (dvision)      references code_lookup (lookup_code)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_BASIC_INFO   add foreign key FK_CTX_BASI_REFERENCE_CODE_LOO_OC_DEPARTMENT (oc_department)      references code_lookup (lookup_code)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_BASIC_INFO   add foreign key FK_CTX_BASI_REFERENCE_CODE_LOO_OC_TITLE (oc_title)      references code_lookup (lookup_code)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_BASIC_INFO   add foreign key FK_CTX_BASI_REFERENCE_CODE_LOO_TERM_REASON (term_reason)      references code_lookup (lookup_code)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_BASIC_INFO   add foreign key FK_CTX_BASI_REFERENCE_CODE_LOO_contract_type (contract_type)      references code_lookup (lookup_code)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_BASIC_INFO   add foreign key FK_CTX_BASI_REFERENCE_CODE_LOO_status (status)      references code_lookup (lookup_code)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_BASIC_INFO   add foreign key FK_CTX_BASI_info_product_type (product_type)      references code_lookup (lookup_code)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_CONTACTS_NUMBERS   add foreign key FK_CTX_CONT_FK_CTX_CO_CTX_CONT2 (contact_id)      references CTX_CONTACTS (contact_id)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_CONTACTS   add foreign key FK_CTX_CONT_REFERENCE_CODE_LOO_CTX_TYPE (contact_type)      references code_lookup (lookup_code)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_CONTACTS   add foreign key FK_CTX_CONT_REFERENCE_CODE_LOO_STATE (state)      references code_lookup (lookup_code)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_CONTACTS_NUMBERS   add foreign key FK_CTX_CONT_REFERENCE_CODE_LOO_VIA (via)      references code_lookup (lookup_code)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_CONTRACT_CONTACTS   add foreign key FK_CTX_CONT_FK_CTX_CO_CTX_BASI (ctx_id)      references CTX_BASIC_INFO (ctx_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_CONTRACT_CONTACTS   add foreign key FK_CTX_CONT_FK_CTX_CO_CTX_CONT (contact_id)      references CTX_CONTACTS (contact_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_CPT_CODE_ITEM   add foreign key FK_CTX_CPT__FK_CTX_CP_CTX_CPT_ (CPT_CODE_ID, )      references CTX_CPT_CODES (cpt_code_id, cpt_code)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_CPT_CODE_ITEM   add foreign key FK_CTX_CPT__FK_CTX_CP_CTX_ITEM (ITEM_ID)      references CTX_ITEM (item_id)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_ELEMENTS   add foreign key FK_CTX_ELEM_FK_CTX_EL_CTX_REQ_ (CTX_REQ_PROFILE_HDR_id)      references CTX_REQ_PROFILE_HDR (CTX_REQ_PROFILE_HDR_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_FEE_SCHED_DATA   add foreign key FK_CTX_FEE__FK_CTX_FE_CTX_FEE_2 (fee_sched_location_id)      references CTX_FEE_SCHED_LOCATIONS (fee_sched_location_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_FEE_SCHED_LOCATIONS   add foreign key FK_CTX_FEE__FK_CTX_FE_CTX_FEE_LOCATIONS (fee_sched_id)      references CTX_FEE_SCHED_HDR (fee_sched_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_FEE_SCHED_HDR   add foreign key FK_CTX_FEE__REFERENCE_CODE_LOO_cave_out (carve_out_type)      references code_lookup (lookup_code)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_FEE_SCHED_LOCATIONS   add foreign key FK_CTX_FEE__REFERENCE_CODE_LOO_location (location)      references code_lookup (lookup_code)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_FEE_SCHED_DATA   add foreign key FK_CTX_FEE__REFERENCE_CODE_LOO_physl_fee (phys_fee)      references code_lookup (lookup_code)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_FEE_SCHED_HDR   add foreign key FK_CTX_FEE__REFERENCE_CODE_LOO_sched_type (sched_type)      references code_lookup (lookup_code)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_FEE_SCHED_HDR   add foreign key FK_CTX_FEE__FK_CTX_FE_CTX_BASI (ctx_id)      references CTX_BASIC_INFO (ctx_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_FEE_SCHED_LOCATIONS   add foreign key FK_CTX_FEE__FK_CTX_FE_CTX_CPT_ (fee_bonus)      references CTX_CPT_CODE_ITEM (ITEM_ID)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_FEE_SCHED_PRACS   add foreign key FK_CTX_FEE__FK_CTX_FE_CTX_FEE_ (fee_sched_id)      references CTX_FEE_SCHED_HDR (fee_sched_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_FEE_SCHED_PRACS   add foreign key FK_CTX_FEE__REFERENCE_PD_BASIC_prac_id (practitioner_id)      references pd_basic (prac_id)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_FILE_LOCATION   add foreign key FK_CTX_FILE_FK_CTX_FI_CTX_BASI (ctx_id)      references CTX_BASIC_INFO (ctx_id)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_HIERCHY_ACCESS   add foreign key FK_CTX_HIER_FK_CTX_HI_CTX_ITEM (item_id)      references CTX_ITEM (item_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_HIERCHY_ACCESS   add foreign key FK_CTX_HIER_REFERENCE_CTX_ITEM_item_level (item_level)      references CTX_ITEM_LEVEL (level_name)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_HIERCHY_ACCESS   add foreign key FK_CTX_HIER_REFERENCE_CTX_ITEM_itm_lvl (item_level)      references CTX_ITEM (item_id)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_HIERCHY_ACCESS   add foreign key FK_CTX_HIER_REFERENCE_CTX_ITEM_prnt_lvl (parent_level)      references CTX_ITEM_LEVEL (level_num)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_IMAGES   add foreign key FK_CTX_IMAG_FK_CTX_IM_CTX_BASI (ctx_id)      references CTX_BASIC_INFO (ctx_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_IMAGE   add foreign key FK_CTX_IMAG_FK_CTX_IM_CTX_IMAG (ctx_id, image_id)      references CTX_IMAGES (ctx_id, image_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_ITEM_HIERARCHY   add foreign key FK_CTX_ITEM_REFERENCE_CTX_ITEM_item_level (item_level)      references CTX_ITEM_LEVEL (level_num)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_ITEM_HIERARCHY   add foreign key FK_CTX_ITEM_REFERENCE_CTX_ITEM_itm_itm (item_id)      references CTX_ITEM (item_id)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_ITEM_HIERARCHY   add foreign key FK_CTX_ITEM_REFERENCE_CTX_ITEM_parent_itm (parent_id)      references CTX_ITEM (item_id)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_LOCATION_SPECIALTY   add foreign key FK_CTX_LOCA_REFERENCE_CODE_LOOKUP_LOOLUP_CODE (Prac_specialty)      references code_lookup (lookup_code)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_LOCATION_CONTACTS   add foreign key FK_CTX_LOCA_FK_CTX_LO_CTX_CONT (contact_id)      references CTX_CONTACTS (contact_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_LOCATION_CONTACTS   add foreign key FK_CTX_LOCA_FK_CTX_LO_CTX_LOC (ctx_id, parent_comp_id, loc_id)      references CTX_LOC (ctx_id, parent_comp_id, loc_id)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_LOCATION_CONTACTS   add foreign key FK_CTX_LOCA_REFERENCE_CTX_LOC1 (loc_id, parent_comp_id, ctx_id)      references CTX_LOC (loc_id, parent_comp_id, ctx_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_LOCATION_SPECIALTY   add foreign key FK_CTX_LOCA_REFERENCE_CTX_LOCCATION_SPEC_LOC_ID (loc_id, ctx_id, parent_comp_id)      references CTX_LOC (loc_id, ctx_id, parent_comp_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_LOC   add foreign key FK_CTX_LOC_FK_CTX_LO_CTX_BASI (ctx_id)      references CTX_BASIC_INFO (ctx_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_NOTIFICATION_USERS   add foreign key FK_CTX_NOTI_FK_CTX_NO_CTX_BASI (ctx_id)      references CTX_BASIC_INFO (ctx_id)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_NOTIFICATION_USERS   add foreign key FK_CTX_NOTI_FK_CTX_NO_CTX_NOTI (ctx_id, alm_column, alm_table)      references CTX_NOTIFICATION (ctx_id, alm_column, alm_table)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_ORGS   add foreign key FK_CTX_ORGS_REFERENCE_CODE_LOO_org_type (org_type)      references code_lookup (lookup_code)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_ORGS   add foreign key FK_CTX_ORGS_REFERENCE_CODE_LOO_state (state)      references code_lookup (lookup_code)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_ORGS   add foreign key FK_CTX_ORGS_REFERENCE_CODE_LOO_status (status)      references code_lookup (lookup_code)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_ORGS_CONTACT   add foreign key FK_CTX_ORGS_FK_CTX_OR_CTX_BASI (ctx_id)      references CTX_BASIC_INFO (ctx_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_ORGS_CONTACT   add foreign key FK_CTX_ORGS_FK_CTX_OR_CTX_ORGS (org_id)      references CTX_ORGS (org_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_ORG_CONTACT   add foreign key FK_CTX_ORG__REFERENCE_CODE_LOO_via (via)      references code_lookup (lookup_code)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_ORG_CONTACT   add foreign key FK_CTX_ORG__FK_CTX_OR_CTX_ORGS (org_id)      references CTX_ORGS (org_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_REPORT_PROFILE_DET   add foreign key FK_CTX_REPO_FK_CTX_RE_CTX_REPO (ctx_rpt_prfl_id)      references ctx_report_profile_hdr (ctx_rpt_prfl_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_REQ_TMPLT_ELEMENT   add foreign key FK_CTX_REQ__REFERENCE_CTX_REQ (ctx_req_profile_id)      references CTX_REQ_PROFILE (ctx_req_profile_id)      on update restrict      on delete cascade " 

ls_sql_statments[upperbound(ls_sql_statments) + 1] =  "if exists(select 1 from sys.systable where table_name='CTX_REQ_PROFILE_HDR' and table_type='BASE') then alter table CTX_REQ_PROFILE_HDR  add foreign key FK_CTX_REQ__FK_CTX_RE_CTX_REQ_ (ctx_req_profile_id)      references CTX_REQ_PROFILE (ctx_req_profile_id)      on update restrict      on delete cascade end if;" 
ls_sql_statments[upperbound(ls_sql_statments) + 1] =  "if exists(select 1 from sys.systable where table_name='CTX_RQMNT_CATEGORY' and table_type='BASE')  then alter table CTX_RQMNT_CATEGORY   add foreign key FK_CTX_RQMN_FK_CTX_RQ_CTX_REQ_ (ctx_req_profile_id)      references CTX_REQ_PROFILE (ctx_req_profile_id)      on update restrict      on delete cascade end if;" 
ls_sql_statments[upperbound(ls_sql_statments) + 1] =  "if exists(select 1 from sys.systable where table_name='CTX_NOTIFICATION' and table_type='BASE')    then alter table CTX_NOTIFICATION     add foreign key FK_ctx_notification_to_ctx_basic_info (ctx_id)      references CTX_BASIC_INFO (ctx_id)      on update restrict      on delete cascade end if;" 
ls_sql_statments[upperbound(ls_sql_statments) + 1] =  "if exists(select 1 from sys.systable where table_name='CTX_LOCATION_PRACS' and table_type='BASE')  then alter table CTX_LOCATION_PRACS   add foreign key FK_CTX_LOCA_REFERENCE_CTX_LOC (ctx_id, parent_comp_id, loc_id)      references CTX_LOC (ctx_id, parent_comp_id, loc_id)      on update restrict      on delete cascade end if;"
ls_sql_statments[upperbound(ls_sql_statments) + 1] =  "if exists(select 1 from sys.systable where table_name='ctx_contacts' and table_type='BASE')        then alter table ctx_contacts         add foreign key FK_contacts_user (user_d) references security_users (user_id) on update restrict  on delete restrict end if;"
ls_sql_statments[upperbound(ls_sql_statments) + 1] =  "if exists(select 1 from sys.systable where table_name='CTX_FEE_SCHED_NM' and table_type='BASE')    then alter table CTX_FEE_SCHED_NM     add foreign key FK_CTX_FEE__REFERENCE_CTX_BASI (ctx_id) references CTX_BASIC_INFO (ctx_id) on update restrict on delete cascade end if;"
ls_sql_statments[upperbound(ls_sql_statments) + 1] =  "if exists(select 1 from sys.systable where table_name='CTX_LOCATION_PRACS' and table_type='BASE')  then alter table CTX_LOCATION_PRACS   add foreign key FK_CTX_LOCA_REFERENCE_GROUP_PR (gp_rec_id) references group_practice (rec_id) on update restrict on delete restrict end if;"
ls_sql_statments[upperbound(ls_sql_statments) + 1] =  "if exists(select 1 from sys.systable where table_name='ctx_products' and table_type='BASE')        then alter table ctx_products         add foreign key FK_CTX_PROD_REFERENCE_CTX_BASI (ctx_id) references CTX_BASIC_INFO (ctx_id)  on update restrict  on delete cascade end if;"


return 0
end function

public function integer of_asa_1_changes ();

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_ACTION_ITEMS modify notes varchar(255) null;"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_FEE_SCHED_DATA   delete primary key " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_FEE_SCHED_DATA rename tmp_CTX_FEE_SCHED_DATA " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_FEE_SCHED_HDR   delete rate " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_FEE_SCHED_HDR   delete fee_bonus " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_FEE_SCHED_LOCATIONS rename tmp_CTX_FEE_SCHED_LOCATIONS " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_ITEM_HIERARCHY rename tmp_CTX_ITEM_HIERARCHY " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_ITEM_LEVEL rename tmp_CTX_ITEM_LEVEL " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table CTX_FEE_SCHED_DATA (    fee_sched_data_id    integer                        not null,    fee_sched_location_id int                            not null,    effective_date       datetime                       default today(),    expiration_date      datetime , status numeric(6) ,    code                 varchar(10)                    not null,    office_fee           money,    facility_fee         money,    custom_fee           money,    fee                  numeric(6),    precert              int,    preauth              int,    phys_fee             numeric(6),    custom_1             varchar(75),    custom_2             varchar(75),    custom_3             varchar(75),    custom_4             varchar(75),    custom_5             varchar(75),    inserted_by_user     varchar(128),    inserted_at_date_time datetime,    updated_by_user      varchar(128),    updated_at_date_time datetime,    record_id            numeric(10)                    not null default NULL,    primary key (fee_sched_data_id, fee_sched_location_id, record_id)) " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on column CTX_FEE_SCHED_DATA.effective_date is 'The start date of the code' " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on column CTX_FEE_SCHED_DATA.expiration_date is 'the end date of this code' " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on column CTX_FEE_SCHED_DATA.status is 'linked to contract status (Active, History)' " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into CTX_FEE_SCHED_DATA (fee_sched_data_id, fee_sched_location_id, code, office_fee, facility_fee, custom_fee, fee, precert, preauth, phys_fee, custom_1, custom_2, custom_3, custom_4, custom_5, inserted_by_user, inserted_at_date_time, updated_by_user, updated_at_date_time, record_id) select fee_sched_data_id, fee_sched_location_id, code, office_fee, facility_fee, custom_fee, fee, precert, preauth, phys_fee, custom_1, custom_2, custom_3, custom_4, custom_5, inserted_by_user, inserted_at_date_time, updated_by_user, updated_at_date_time, record_id from tmp_CTX_FEE_SCHED_DATA " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='tmp_CTX_FEE_SCHED_DATA' and table_type='BASE') then    drop table tmp_CTX_FEE_SCHED_DATA end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table CTX_FEE_SCHED_LOCATIONS (    fee_sched_location_id int                            not null,    fee_sched_id         int                            not null,    location             numeric(6)                     not null,    inserted_by_user     varchar(128),    inserted_at_date_time datetime,    updated_by_user      varchar(128),    updated_at_date_time datetime,    record_id            numeric(10)                    not null default NULL,    rate                 numeric(8,2),    fee_bonus            int,    primary key (fee_sched_location_id)) " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into CTX_FEE_SCHED_LOCATIONS (fee_sched_location_id, fee_sched_id, location, inserted_by_user, inserted_at_date_time, updated_by_user, updated_at_date_time, record_id) select fee_sched_location_id, fee_sched_id, location, inserted_by_user, inserted_at_date_time, updated_by_user, updated_at_date_time, record_id from tmp_CTX_FEE_SCHED_LOCATIONS " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='tmp_CTX_FEE_SCHED_LOCATIONS' and table_type='BASE') then    drop table tmp_CTX_FEE_SCHED_LOCATIONS end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table CTX_ITEM_HIERARCHY (    item_id              int                            not null,    parent_id            int                            not null,    item_level           int                            not null,    primary key (item_id, parent_id, item_level)) " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into CTX_ITEM_HIERARCHY (item_id, parent_id, item_level)select item_id, parent_id, item_levelfrom tmp_CTX_ITEM_HIERARCHY " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='tmp_CTX_ITEM_HIERARCHY' and table_type='BASE') then    drop table tmp_CTX_ITEM_HIERARCHY end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table CTX_ITEM_LEVEL (    level_num            int                            not null,    level_name           varchar(255)                   not null,    primary key (level_num, level_name)) " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into CTX_ITEM_LEVEL (level_num, level_name)select level_num, level_namefrom tmp_CTX_ITEM_LEVEL " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='tmp_CTX_ITEM_LEVEL' and table_type='BASE') then    drop table tmp_CTX_ITEM_LEVEL end if  " 

return 0
end function

public function integer of_report_sql ();
return 1  // no need to run this the report is not done yet

long ll_max_rpt_id
long ll_contract_reports[]
long ll_i
long ll_report_id

n_ds lds_ctx_reports
lds_ctx_reports = CREATE n_ds
lds_ctx_reports.dataobject ='ds_ctx_sys_reports'
lds_ctx_reports.settransobject(sqlca)

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-05
//$<add> 04.01.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

/*
select max(report_id) 
into :ll_max_rpt_id
from sys_reports;

if ll_max_rpt_id = 0 or isnull(ll_max_rpt_id ) then 
	ll_max_rpt_id = 1
else 
	ll_max_rpt_id++
end if

//////////////////////////////////////////////////////////////////////////////////////
// get all of the report ids that are asscociated with Contract
//////////////////////////////////////////////////////////////////////////////////////

lds_ctx_reports.retrieve( )
*/
gnv_appeondb.of_startqueue( )

select max(report_id) 
into :ll_max_rpt_id
from sys_reports;

lds_ctx_reports.retrieve( )

gnv_appeondb.of_commitqueue( )

if ll_max_rpt_id = 0 or isnull(ll_max_rpt_id ) then 
	ll_max_rpt_id = 1
else 
	ll_max_rpt_id++
end if

gnv_appeondb.of_startqueue( )

//---------------------------- APPEON END ----------------------------

//////////////////////////////////////////////////////////////////////////////////////
// delete all of sys_report_wizard rows for the report ids
//////////////////////////////////////////////////////////////////////////////////////
for ll_i = 1 to lds_ctx_reports.rowcount()
	ll_report_id = lds_ctx_reports.getItemnumber(ll_i,'report_id')
	DELETE FROM "sys_report_wizard" WHERE "sys_reports"."report_id" = :ll_report_id ;
	commit;
	DELETE FROM "sys_reports" WHERE "sys_reports"."report_id" = :ll_report_id;
	commit;
next

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-06
//$<add> 04.01.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_commitqueue( )
//---------------------------- APPEON END ----------------------------

//////////////////////////////////////////////////////////////////////////////////////
// insert the new stuff
//////////////////////////////////////////////////////////////////////////////////////
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_reports ( report_id,report_name, report_description,  report_dw,graph_dw, criteria_dw, category, r_type) VALUES (" + string(ll_max_rpt_id) + ", 'Contracts by Association ',   'Retrieves Contracts that are associated to a user',   'r_ctx_contracts_by_assn',   '',   '', 'Contract',   'B' )"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_report_wizard (report_id,wizard_seq_no, wizard_dw, wizard_last_step, help_text, insert_blank_row,multi_select ) VALUES (" + string(ll_max_rpt_id) + ", 1, 'd_crit_contract_det_contact', 'N', 'Select User', 'Y', 'Y' )"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_report_wizard (report_id,wizard_seq_no, wizard_dw, wizard_last_step, help_text, insert_blank_row,multi_select ) VALUES (" + string(ll_max_rpt_id) + ", 2, 'd_crit_contract_status', 'N', 'Select Contract Status', 'Y', 'Y' )"
ll_max_rpt_id++


/** New Contract Report **/
destroy lds_ctx_reports



return 0
end function

public function integer of_asa_2_changes ();integer cnt

////Contract Precert. Requirements
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'Contract Practitioner Contract Stat';"
select count(lookup_code) into : cnt from code_lookup where lookup_name = 'Contract Practitioner Contract Stat';
if cnt = 0 then ////Start Code Change ---- 11.09.2006 #1 maha
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Practitioner Contract Stat' ,'Par.','Participating in the contract')"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Practitioner Contract Stat' ,'Not Par.','Not Participating in the Contract') "
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Practitioner Contract Stat' ,'Par. Unknown.','Not Know if the practitioner will be participating in the contract.') "
end if
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "ALTER TABLE ctx_action_items modify notes  varchar(2000) NULL;"


ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_FEE_SCHED_DATA rename tmp_CTX_FEE_SCHED_DATA ;"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_LOCATION_CONTACTS delete primary key ;"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_LOCATION_CONTACTS rename tmp_CTX_LOCATION_CONTACTS ;"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_NOTIFICATION rename tmp_CTX_NOTIFICATION ;"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table CTX_FEE_SCHED_DATA (fee_sched_data_id    integer not null, fee_sched_location_id int  not null, effective_date       datetime default today(),  expiration_date      datetime,status               numeric(6),code                 varchar(10)  not null,office_fee           money,facility_fee         money,custom_fee           money, fee     money,precert int, preauth  int, base_price   money,phys_fee             numeric(6), custom_1             varchar(75),custom_2             varchar(75),custom_3             varchar(75),custom_4             varchar(75),custom_5             varchar(75), fee_basis            money,inserted_by_user     varchar(128), inserted_at_date_time datetime,updated_by_user      varchar(128),updated_at_date_time datetime, record_id numeric(10) not null default NULL, primary key (fee_sched_data_id, fee_sched_location_id, record_id) ) ;"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on column CTX_FEE_SCHED_DATA.effective_date is 'The start date of the code';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on column CTX_FEE_SCHED_DATA.expiration_date is 'the end date of this code';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on column CTX_FEE_SCHED_DATA.status is 'linked to contract status (Active, History)';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into CTX_FEE_SCHED_DATA (fee_sched_data_id, fee_sched_location_id, effective_date, expiration_date, status, code, office_fee, facility_fee, custom_fee, fee, precert, preauth, phys_fee, custom_1, custom_2, custom_3, custom_4, custom_5, inserted_by_user, inserted_at_date_time, updated_by_user, updated_at_date_time, record_id) select fee_sched_data_id, fee_sched_location_id, effective_date, expiration_date, status, code, office_fee, facility_fee, custom_fee, fee, precert, preauth, phys_fee, custom_1, custom_2, custom_3, custom_4, custom_5, inserted_by_user, inserted_at_date_time, updated_by_user, updated_at_date_time, record_id from tmp_CTX_FEE_SCHED_DATA;"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='tmp_CTX_FEE_SCHED_DATA' and table_type='BASE') then drop table tmp_CTX_FEE_SCHED_DATA end if;"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table CTX_LOCATION_CONTACTS (ctx_id int  not null, parent_comp_id       numeric(6)                     not null,loc_id               numeric(6)                     not null,contact_id           int                            not null, CTX_loc_id           numeric(6)                     default 0, record_id            numeric(10)                    not null default NULL, primary key (loc_id, contact_id, ctx_id, parent_comp_id) );"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table CTX_LOCATION_CONTACTS is 'Location Contacts';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on column CTX_LOCATION_CONTACTS.parent_comp_id is 'RF to group_multi_loc rec_id';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on column CTX_LOCATION_CONTACTS.CTX_loc_id is 'rf to the rec_id in group practice';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into CTX_LOCATION_CONTACTS (ctx_id, parent_comp_id, loc_id, contact_id, CTX_loc_id, record_id) select ctx_id, parent_comp_id, loc_id, contact_id, CTX_loc_id, record_id from tmp_CTX_LOCATION_CONTACTS;"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='tmp_CTX_LOCATION_CONTACTS' and table_type='BASE') then drop table tmp_CTX_LOCATION_CONTACTS end if;"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_LOCATION_CONTACTS modify ctx_id int not null;"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_LOCATION_CONTACTS modify parent_comp_id numeric(6) not null;"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_LOCATION_CONTACTS add primary key (loc_id, contact_id, ctx_id, parent_comp_id);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table CTX_LOCATION_PRACS (ctx_id  int not null, parent_comp_id       numeric(6)                     not null,loc_id               numeric(6)                     not null,gp_rec_id            numeric(10)                    not null, status               numeric(6), record_id            numeric(6), primary key (ctx_id, parent_comp_id, loc_id, gp_rec_id) );"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table CTX_LOCATION_PRACS is 'Practitioers that are associated with the contract. Not all in a practice are neccesarly in.';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on column CTX_LOCATION_PRACS.parent_comp_id is 'RF to group_multi_loc rec_id';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on column CTX_LOCATION_PRACS.loc_id is 'rf to the rec_id in group practice';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on column CTX_LOCATION_PRACS.status is 'Participating or not (same as application status)';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table CTX_NOTIFICATION (ctx_id               int                            not null, alm_message          varchar(255), alm_enabled          char(1),  alm_table            varchar(40)                    not null, alm_column           varchar(40)                    not null, alm_notification_days int, alm_last_notification_sent datetime,  alm_post_notification_days int, alm_total_tries      int, alm_action_item_posted int, alm_total_tries_counter int, alm_frequency        int,  create_action_item   char(1)                        default 'N',  record_id            numeric(10)                    not null default NULL,   primary key (ctx_id, alm_table, alm_column));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table CTX_NOTIFICATION is 'count for the number emails sent out to the user';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on column CTX_NOTIFICATION.ctx_id is 'Primary Key/ contract ID';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on column CTX_NOTIFICATION.alm_message is 'The message to be display to the user';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on column CTX_NOTIFICATION.alm_enabled is 'Flag that indicates if the notification is to be displayed or not';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on column CTX_NOTIFICATION.alm_post_notification_days is 'The amount of Max days the message is to be sent';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on column CTX_NOTIFICATION.alm_total_tries is 'The total amount of times the message will be sent out';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on column CTX_NOTIFICATION.alm_action_item_posted is 'Flag. 1 = action Item compleated, else not';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on column CTX_NOTIFICATION.alm_total_tries_counter is 'The total amount of times the message will be sent out';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on column CTX_NOTIFICATION.alm_frequency is 'the number of days apart to send the message';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into CTX_NOTIFICATION (ctx_id, alm_message, alm_enabled, alm_table, alm_column, alm_notification_days, alm_last_notification_sent, alm_post_notification_days, alm_total_tries, alm_action_item_posted, alm_total_tries_counter, alm_frequency, record_id) select ctx_id, alm_message, alm_enabled, alm_table, alm_column, alm_notification_days, alm_last_notification_sent, alm_post_notification_days, alm_total_tries, alm_action_item_posted, alm_total_tries_counter, alm_frequency, record_id from tmp_CTX_NOTIFICATION;"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='tmp_CTX_NOTIFICATION' and table_type='BASE') then drop table tmp_CTX_NOTIFICATION end if;"

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_orgs_contact modify notes varchar(2000) null;"

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_FEE_SCHED_HDR modify notes varchar(255) null;"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_contacts add  user_d char(10) null ;"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_contract_contacts add  owner char(1) null;"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_contract_contacts add access char(1) null;"


return 0
end function

public function integer of_asa_3_changes ();integer cnt
string ls_table_name


ls_sql_statments[upperbound(ls_sql_statments) + 1 ] = "create table CTX_FEE_SCHED_NM (ctx_id int not null,fee_sched_nm_id int not null,category numeric(6,0),service_item         numeric(6,0), description          varchar(256), fee                  money,item_status          numeric(6,0),start_date           datetime, end_date             datetime, service_name         numeric(6,0),custom_int1          int,custom_int2          int,custom_fee1          money,custom_fee2          money,custom_fee3          money, custom_text1         varchar(255), custom_text2         varchar(255), custom_text3         varchar(255),notes                varchar(2000),record_id            numeric(10),primary key (ctx_id, fee_sched_nm_id));"

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_images add  image_type numeric(6,0) null ;"

////Contract Fee Schd Cat. (NM) 
//ls_table_name = "Contract Fee Schd Cat. (NM)"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'Contract Fee Schd Cat. (NM)';"
select count(lookup_code) into : cnt from code_lookup where lookup_name = 'Contract Fee Schd Cat. (NM)';
if cnt = 0 then ////Start Code Change ---- 11.09.2006 #1 maha
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Fee Schd Cat. (NM)' ,'NETSRV','Netwwork Service')"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Fee Schd Cat. (NM)' ,'TELE-EQUIP','Telephone Equipment') "
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Fee Schd Cat. (NM)' ,'COMP-EQUIP','Computer Equipment') "
end if

////Contract Service (NM) 
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'Contract Service (NM)';"
select count(lookup_code) into : cnt from code_lookup where lookup_name = 'Contract Service (NM)';
if cnt = 0 then ////Start Code Change ---- 11.09.2006 #1 maha
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Service (NM)' ,'COMP-REP-L','Computer Repair Labour')"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Service (NM)' ,'HVAC-REP-L','HVAC Repair Labour') "
end if

////Contract Fee Sched Stat. (NM)
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'Contract Fee Sched Stat. (NM)';"
select count(lookup_code) into : cnt from code_lookup where lookup_name = 'Contract Fee Sched Stat. (NM)';
if cnt = 0 then ////Start Code Change ---- 11.09.2006 #1 maha
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Fee Sched Stat. (NM)' ,'ACTIVE','')"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Fee Sched Stat. (NM)' ,'INACTIVE','') "
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Fee Sched Stat. (NM)' ,'HISTORY','') "
end if

////Contract Supp. Doc.Type
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'Contract Supp. Doc.Type';"
select count(lookup_code) into : cnt from code_lookup where lookup_name = 'Contract Supp. Doc.Type';
if cnt = 0 then ////Start Code Change ---- 11.09.2006 #1 maha
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Supp. Doc.Type' ,'CONTRACT','The contract')"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Supp. Doc.Type' ,'ADMENDMENT','Admendment to the contract') "
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Supp. Doc.Type' ,'OTHER','Other supporting document') "
end if

return 0




end function

public function integer of_asa_4_changes ();integer cnt

//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT	INTO	security_sub_module	(	module_id		, sub_module_id		, sub_module_name	)	VALUES		(	33		, 405		, 'Fee Schedule (NM)'	);"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	33	, 405	,2210 , 'Access Rights'	, 2	);"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = ""

////Contract Billing Cycle
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'Contract Billing Cycle';"


select count(lookup_code) into : cnt from code_lookup where lookup_name = 'Contract Billing Cycle';
if cnt = 0 then ////Start Code Change ---- 11.09.2006 #1 maha
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Billing Cycle' ,'Monthly','Billed on a Monthly basis')"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Billing Cycle' ,'Weekly','Billed on a Weekly basis') "
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Billing Cycle' ,'Per Unit','Billed on a Per Unit basis') "
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Billing Cycle' ,'Custom','Custom') "
end if
// add billing cycle
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_FEE_SCHED_NM rename tmp_CTX_FEE_SCHED_NM;"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table CTX_FEE_SCHED_NM (ctx_id int not null,  fee_sched_nm_id      int not null,category numeric(6,0),service_item         numeric(6,0), description          varchar(256), fee  money,item_status          numeric(6,0), start_date           datetime,end_date             datetime, service_name         numeric(6,0), custom_int1          int,custom_int2          int,custom_fee1          money,custom_fee2          money,custom_fee3          money,custom_text1         varchar(255),custom_text2         varchar(255),custom_text3         varchar(255),billing_cycle        numeric(6,0),notes                varchar(2000), record_id            numeric(10),primary key (ctx_id, fee_sched_nm_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table CTX_FEE_SCHED_NM is 'The non Medical fee schedule '"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on column CTX_FEE_SCHED_NM.ctx_id is 'Primary Key'"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into CTX_FEE_SCHED_NM (ctx_id, fee_sched_nm_id, category, service_item, description, fee, item_status, start_date, end_date, service_name, custom_int1, custom_int2, custom_fee1, custom_fee2, custom_fee3, custom_text1, custom_text2, custom_text3, notes, record_id) select ctx_id, fee_sched_nm_id, category, service_item, description, fee, item_status, start_date, end_date, service_name, custom_int1, custom_int2, custom_fee1, custom_fee2, custom_fee3, custom_text1, custom_text2, custom_text3, notes, record_id from tmp_CTX_FEE_SCHED_NM;"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='tmp_CTX_FEE_SCHED_NM' and table_type='BASE') then drop table tmp_CTX_FEE_SCHED_NM end if;"
// ctx contacts - contacta local
ls_sql_statments[upperbound(ls_sql_statments) + 1] = 'alter table ctx_contacts add contact_type2 char(1) null;'
// ctx contacts - fee schedue nm
ls_sql_statments[upperbound(ls_sql_statments) + 1] = 'alter table CTX_FEE_SCHED_NM add billing_cycle numeric(6,0) null;'

return 0

end function

public function integer of_asa_5_changes ();

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_LOCATION_PRACS delete primary key;"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = " alter table CTX_LOCATION_PRACS rename tmp_CTX_LOCATION_PRACS;"

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table CTX_LOCATION_PRACS (    ctx_id   int  not null,    parent_comp_id  numeric(6) not null,    loc_id    numeric(6) not null,gp_rec_id numeric(10) not null,    prac_id   numeric(6)  not null,    status    numeric(6), record_id            numeric(6), primary key (ctx_id, parent_comp_id, loc_id, gp_rec_id, prac_id));"

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table CTX_LOCATION_PRACS is 'Practitioers that are associated with the contract. Not all in a practice are neccesarly in.';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on column CTX_LOCATION_PRACS.parent_comp_id is 'RF to group_multi_loc rec_id';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on column CTX_LOCATION_PRACS.loc_id is 'rf to the rec_id in group practice':"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on column CTX_LOCATION_PRACS.status is 'Participating or not (same as application status)';"

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into CTX_LOCATION_PRACS (ctx_id, parent_comp_id, loc_id, gp_rec_id,  status, record_id) select ctx_id, parent_comp_id, loc_id, gp_rec_id,status, record_id from tmp_CTX_LOCATION_PRACS;"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='tmp_CTX_LOCATION_PRACS' and table_type='BASE') then drop table tmp_CTX_LOCATION_PRACS end if;"
return 0
end function

public subroutine of_asa_6_changes ();integer cnt

////Contract Supp. Doc.Type

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_CONTACTS modify middle_name default ''; "
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'Contract Position Title';"
select count(lookup_code) into : cnt from code_lookup where lookup_name = 'Contract Position Title';
if cnt = 0 then ////Start Code Change ---- 11.09.2006 #1 maha
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Position Title' ,'CEO','Chief Executive Officer ')"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Position Title' ,'CFO','Chief Financial Officer') "
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Position Title' ,'CCO','Chief Contracting Officer') "
end if

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_CONT_REFERENCE_CODE_LOO_STATE') then    alter table CTX_CONTACTS       delete foreign key FK_CTX_CONT_REFERENCE_CODE_LOO_STATE end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = " drop PROCEDURE sp_contract_search" 
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 09.06.2006 By: Liang QingShi
//$<reason> Contract module modification
//$<reason> Fix a defect.

/*
ls_sql_statments[upperbound(ls_sql_statments) + 1] = " CREATE PROCEDURE sp_contract_search" + &
																		 " as " + &
																			 " BEGIN " + &
																				 " SELECT DISTINCT ctx_basic_info.app_facility,   " + &
																					 "	 ctx_basic_info.product_name,   " + &
																						 " ctx_basic_info.effective_date,   " + &
																						 " ctx_basic_info.expriation_date,   " + &
																						 "ctx_basic_info.status,   " + &
																						 "ctx_basic_info.group_multi_loc_id,   " + &
																						 "ctx_basic_info.ctx_id,   " + &
																						 "ctx_basic_info.category,    " + &
																						 "ctx_basic_info.facility_id,   " + &
																						 "ctx_basic_info.contract_type,   " + &
																						 "ctx_basic_info.product_type,   " + &
																						 "ctx_basic_info.reimbursment_menth,  " + & 
																						 "ctx_basic_info.file_location,   " + &
																						 "ctx_basic_info.review_date,   " + &
																						 "ctx_basic_info.review_by,   " + &
																						 "ctx_basic_info.term_date,   " + &
																						 "ctx_basic_info.term_reason,   " + &
																						 "ctx_basic_info.last_revis_date,   " + &
																						 "ctx_basic_info.other_date_1,   " + &
																						 "ctx_basic_info.other_date_2,   " + &
																						 "ctx_basic_info.oc_signed_by,   " + &
																						 "ctx_basic_info.oc_title,   " + &
																						 "ctx_basic_info.oc_department,   " + &
																						 "ctx_basic_info.oc_legal_rep,   " + &
																						 "ctx_basic_info.cc_signed_by,   " + &
																						 "ctx_basic_info.cc_title,   " + &
																						 "ctx_basic_info.cc_department,   " + &
																						 "ctx_basic_info.cc_legal_rep,   " + &
																						 "ctx_basic_info.notes,   " + &
																						 "ctx_basic_info.keyword,   " + &
																						 "ctx_basic_info.dvision,   " + &
																						 "ctx_basic_info.custom_1,   " + &
																						 "ctx_basic_info.custom_2,   " + &
																						 "ctx_basic_info.custom_3,   " + &
																						 "ctx_basic_info.custom_4,   " + &
																						 "ctx_basic_info.custom_5,   " + &
																						 "ctx_basic_info.custom_6,   " + &
																						 "ctx_basic_info.custom_7,   " + &
																						 "ctx_basic_info.custom_8,   " + &
																						 "ctx_basic_info.custom_9,   " + &
																						 "ctx_basic_info.custom_10,   " + &
																						 "ctx_basic_info.group_id,   " + &
																						 "ctx_basic_info.revision_reason, " + &  
																						 "ctx_basic_info.record_id ," + &
																						 "owner = upper((SELECT top 1 ctx_contacts.user_d " + &
																						 "				FROM ctx_contacts,ctx_contract_contacts" + &
																						 "				WHERE (ctx_contract_contacts.contact_id = ctx_contacts.contact_id ) and  " + &
																						 "						(ctx_contract_contacts.ctx_id = ctx_basic_info.ctx_id ) AND  " + &
																						 "						( ctx_contract_contacts.owner = 'Y' ) ))," + &
																					   "contracted_entity = (  SELECT top 1 group_multi_loc.rec_id  " + &
																							 "											FROM ctx_loc,   " + &
																							 "												group_multi_loc  " + &
																							 "											WHERE ( ctx_loc.parent_comp_id = group_multi_loc.rec_id ) and  " + &
																							 "													( ctx_loc.ctx_id = ctx_basic_info.ctx_id  ) AND  " + &
																							 "													ctx_loc.loc_id = 0    )" + &
																																 "FROM ctx_basic_info  " + &
																																					 " END "
*/
																				
ls_sql_statments[upperbound(ls_sql_statments) + 1] = " CREATE PROCEDURE sp_contract_search" + &
																		 " as " + &
																			 " BEGIN " + &
																				 " SELECT DISTINCT ctx_basic_info.app_facility,   " + &
																					 "	 code_lookup.code product_name,   " + &
																						 " ctx_basic_info.effective_date,   " + &
																						 " ctx_basic_info.expriation_date,   " + &
																						 "ctx_basic_info.status,   " + &
																						 "ctx_basic_info.group_multi_loc_id,   " + &
																						 "ctx_basic_info.ctx_id,   " + &
																						 "ctx_basic_info.category,    " + &
																						 "ctx_basic_info.facility_id,   " + &
																						 "ctx_basic_info.contract_type,   " + &
																						 "code_lookup1.code product_type,   " + &
																						 "ctx_basic_info.reimbursment_menth,  " + & 
																						 "ctx_basic_info.file_location,   " + &
																						 "ctx_basic_info.review_date,   " + &
																						 "ctx_basic_info.review_by,   " + &
																						 "ctx_basic_info.term_date,   " + &
																						 "ctx_basic_info.term_reason,   " + &
																						 "ctx_basic_info.last_revis_date,   " + &
																						 "ctx_basic_info.other_date_1,   " + &
																						 "ctx_basic_info.other_date_2,   " + &
																						 "ctx_basic_info.oc_signed_by,   " + &
																						 "ctx_basic_info.oc_title,   " + &
																						 "ctx_basic_info.oc_department,   " + &
																						 "ctx_basic_info.oc_legal_rep,   " + &
																						 "ctx_basic_info.cc_signed_by,   " + &
																						 "ctx_basic_info.cc_title,   " + &
																						 "ctx_basic_info.cc_department,   " + &
																						 "ctx_basic_info.cc_legal_rep,   " + &
																						 "ctx_basic_info.notes,   " + &
																						 "ctx_basic_info.keyword,   " + &
																						 "ctx_basic_info.dvision,   " + &
																						 "ctx_basic_info.custom_1,   " + &
																						 "ctx_basic_info.custom_2,   " + &
																						 "ctx_basic_info.custom_3,   " + &
																						 "ctx_basic_info.custom_4,   " + &
																						 "ctx_basic_info.custom_5,   " + &
																						 "ctx_basic_info.custom_6,   " + &
																						 "ctx_basic_info.custom_7,   " + &
																						 "ctx_basic_info.custom_8,   " + &
																						 "ctx_basic_info.custom_9,   " + &
																						 "ctx_basic_info.custom_10,   " + &
																						 "ctx_basic_info.group_id,   " + &
																						 "ctx_basic_info.revision_reason, " + &  
																						 "ctx_basic_info.record_id ," + &
																						 "owner = upper((SELECT top 1 ctx_contacts.user_d " + &
																						 "				FROM ctx_contacts,ctx_contract_contacts" + &
																						 "				WHERE (ctx_contract_contacts.contact_id = ctx_contacts.contact_id ) and  " + &
																						 "						(ctx_contract_contacts.ctx_id = ctx_basic_info.ctx_id ) AND  " + &
																						 "						( ctx_contract_contacts.owner = 'Y' ) ))," + &
																					   "contracted_entity = (  SELECT top 1 group_multi_loc.rec_id  " + &
																							 "											FROM ctx_loc,   " + &
																							 "												group_multi_loc  " + &
																							 "											WHERE ( ctx_loc.parent_comp_id = group_multi_loc.rec_id ) and  " + &
																							 "													( ctx_loc.ctx_id = ctx_basic_info.ctx_id  ) AND  " + &
																							 "													ctx_loc.loc_id = 0    )" + &
																																 " FROM ctx_basic_info, " + &
																																       "ctx_products,  " + &
																																       "code_lookup,  " + &
																																       "code_lookup code_lookup1  " + &
																																 " WHERE ctx_basic_info.ctx_id = ctx_products.ctx_id   " + &
																																 " AND ctx_products.product_id = code_lookup.lookup_code   " + &
																																 " AND ctx_products.product_type = code_lookup1.lookup_code  " + &
																																 " ORDER BY ctx_basic_info.ctx_id  " + &
																																					 " END "
//---------------------------- APPEON END ----------------------------
																																					 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = 'alter table ctx_contacts modify  zip null;'
ls_sql_statments[upperbound(ls_sql_statments) + 1] = 'alter table ctx_contacts modify  state null;'
ls_sql_statments[upperbound(ls_sql_statments) + 1] = 'alter table ctx_contacts modify street_1 null;'
ls_sql_statments[upperbound(ls_sql_statments) + 1] = 'alter table ctx_contacts modify city null;'
								                                                   
end subroutine

public subroutine of_asa_7_changes ();
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_LOCATION_PRACS rename tmp_CTX_LOCATION_PRACS"
/*==============================================================*/
/* Table : CTX_LOCATION_PRACS                                   */
/*==============================================================*/
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table CTX_LOCATION_PRACS (ctx_id int not null, parent_comp_id numeric(6) not null,loc_id numeric(6) not null, gp_rec_id numeric(10) not null, prac_id numeric(6) not null,status numeric(6),start_date datetime,end_date datetime, record_id numeric(6),primary key (ctx_id, parent_comp_id, loc_id, gp_rec_id, prac_id))"

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table CTX_LOCATION_PRACS is 'Practitioers that are associated with the contract. Not all in a practice are neccesarly in.'"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on column CTX_LOCATION_PRACS.parent_comp_id is 'RF to group_multi_loc rec_id'"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on column CTX_LOCATION_PRACS.loc_id is 'rf to the rec_id in group practice'"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on column CTX_LOCATION_PRACS.status is 'Participating or not (same as application status)'"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into CTX_LOCATION_PRACS (ctx_id, parent_comp_id, loc_id, gp_rec_id, prac_id, status, record_id) select ctx_id, parent_comp_id, loc_id, gp_rec_id, prac_id, status, record_id from tmp_CTX_LOCATION_PRACS"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='tmp_CTX_LOCATION_PRACS' and table_type='BASE') then drop table tmp_CTX_LOCATION_PRACS end if"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_LOCATION_PRACS add foreign key FK_CTX_LOCA_REFERENCE_CTX_LOC (ctx_id, parent_comp_id, loc_id) references DBA.CTX_LOC (ctx_id, parent_comp_id, loc_id) on update restrict on delete cascade"

end subroutine

public function integer of_asa_9_changes ();
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE CODE_LOOKUP SET CUSTOM_6 = 'PayorCTX' WHERE LOOKUP_NAME = 'Contract Category' "

return 1
end function

public function integer of_asa_10_changes ();

ls_sql_statments[upperbound(ls_sql_statments) + 1] = 'alter table ctx_orgs modify notes varchar(255) null'
ls_sql_statments[upperbound(ls_sql_statments) + 1] = 'alter table ctx_orgs modify drections varchar(255) null'
return 1


end function

public subroutine of_asa_11_changes ();//ls_sql_statments[upperboound(ls_sql_statments) + 1] =  "if exists(select 1 from sys.sysforeignkey where role='FK_CTX_PROD_REFERENCE_CTX_BASI') then alter table ctx_products delete foreign key FK_CTX_PROD_REFERENCE_CTX_BASi end if ;"
//ls_sql_statments[upperboound(ls_sql_statments) + 1] =  "if exists(select 1 from sys.systable where table_name='ctx_products' and table_type='BASE') then drop table ctx_products end if;"

ls_sql_statments[upperbound(ls_sql_statments) + 1] =  "create table ctx_products ( product_id            numeric(6,0) not null," +&
                                                       "ctx_id int not null," +&
																		 "product_type          numeric(6,0) not null," +&
																		 "custom_1              varchar(255)," +&
																		 "custom_2              varchar(255)," +&
																		 "custom_date1          datetime," +&
																		 "custom_date2          datetime," +&
																		 "custom_date3          datetime," +&
																		 "record_id             numeric(10) default NULL," +&
																		 "inserted_by_user      varchar(128)," +&
																		 "inserted_at_date_time datetime," +&
																		 "updated_by_user       varchar(128)," +&
																		 "updated_at_date_time  datetime," +&
																		 "primary key (product_id, ctx_id, product_type))   ; " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] =  "alter table ctx_products add foreign key FK_CTX_PROD_REFERENCE_CTX_BASI (ctx_id) references CTX_BASIC_INFO (ctx_id)  on update restrict  on delete cascade;"

end subroutine

public function integer of_appeon1_changes ();//////////////////////////////////////////////////////////////////////
// $<function> n_cst_contract_sql/of_appeon1_changes()
// $<arguments>(None)
// $<returns> integer
// $<description> Database Modification for Contract Module.
// $<description> Support both ASA and SQL Server database.
//////////////////////////////////////////////////////////////////////
// $<add> 07.20.2006 by Liang QingShi
//////////////////////////////////////////////////////////////////////

long ll_max_userviewid, ll_rows, i, ll_found
string ls_userid, ls_tag, ls_sql, ls_new_syntax, ls_error
n_ds lds_user, lds_roles, lds_currentview, lds_rolerights, lds_codelookup
Long ll_roleid, ll_maxid, ll_temp, ll_lookupcode

IF gs_dbtype = "ASA" THEN ls_tag = "; "
	
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table data_view add  type_c varchar(1) null; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "update data_view  set  type_c = 'P' where type_c is null; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Insert into data_view  values (1001,'Default System View','','C'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Create table ctx_screen (data_view_id integer  not null,screen_id integer not null,tab_name varchar(200),screen_name varchar(255),dw_name	varchar(200),dataobject varchar(200),description varchar(255),dw_sql text,create_date datetime,modify_date datetime,PRIMARY KEY (data_view_id,screen_id)); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Update code_lookup set ic_n = 1001 where lookup_name = 'Contract Category' and ic_n is null; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table security_users add  contract_default_view integer null; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE security_users SET contract_default_view = 1001 where contract_default_view is null; "

lds_user = CREATE n_ds
lds_user.DataObject = "d_dddw_users"
lds_user.SetTransObject( SQLCA )

lds_currentview = CREATE n_ds
ls_sql = "select security_user_views.user_id, security_user_views.view_id from security_user_views"
ls_new_syntax = SQLCA.SyntaxFromSQL( ls_sql, "", ls_error )
lds_currentview.Create( ls_new_syntax, ls_error )
lds_currentview.SetTransObject(SQLCA)

gnv_appeondb.of_StartQueue()
lds_user.Retrieve()
lds_currentview.Retrieve()
select max( user_view_id ) into :ll_max_userviewid from security_user_views;
select top 1 rights_id into :ll_temp from ids;
gnv_appeondb.of_CommitQueue()

ll_rows = lds_currentview.rowcount()
if ll_rows > 0 then
	ll_rows = lds_user.RowCount()
	if isnull( ll_max_userviewid ) then ll_max_userviewid = 0
	if isnull( ll_temp ) then ll_temp = 0
	if ll_temp > ll_max_userviewid then ll_max_userviewid = ll_temp;
	
	For i = 1 to ll_rows
		ls_userid = lds_user.GetItemString( i, "user_id" )
		ll_found = lds_currentview.Find( "user_id = '" + ls_userid + "' and view_id = 1001 ", 1, lds_currentview.rowcount() )
		if ll_found < 1 then
			ll_max_userviewid ++
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert security_user_views( user_view_id, user_id, view_id, access_rights) VALUES( " + string( ll_max_userviewid ) + ", '" + ls_userid + "', 1001, 1 ); "
		end if
	Next
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 01.27.2007 By: Jack (Document Manager)
	//$<reason> Fix a defect.
	//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE ids SET rights_id = :ll_max_userviewid;"	
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE ids SET rights_id = " + string( ll_max_userviewid ) + ";"	//Rodger Wu modified.
	//---------------------------- APPEON END ----------------------------	
end if

DESTROY lds_user;
DESTROY lds_currentview;

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info add  custom_11 varchar(255) null ; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info add  custom_12 varchar(255) null ; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info add  custom_13 varchar(255) null ; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info add  custom_14 varchar(255) null ; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info add  custom_15 varchar(255) null ; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info add  custom_16 varchar(255) null ; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info add  custom_17 varchar(255) null ; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info add  custom_18 varchar(255) null ; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info add  custom_19 varchar(255) null ; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info add  custom_20 varchar(255) null ; "

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info add  custom_date6 datetime  null; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info add  custom_date7 datetime  null; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info add  custom_date8 datetime  null; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info add  custom_date9 datetime  null; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info add  custom_date10 datetime  null; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info add  custom_date11 datetime  null; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info add  custom_date12 datetime  null; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info add  custom_date13 datetime  null; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info add  custom_date14 datetime  null; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info add  custom_date15 datetime  null; "

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info add  custom_n1 numeric(6,0) null; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info add  custom_n2 numeric(6,0) null; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info add  custom_n3 numeric(6,0) null; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info add  custom_n4 numeric(6,0) null; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info add  custom_n5 numeric(6,0) null; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info add  custom_n6 numeric(6,0) null; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info add  custom_n7 numeric(6,0) null; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info add  custom_n8 numeric(6,0) null; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info add  custom_n9 numeric(6,0) null; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info add  custom_n10 numeric(6,0) null; "

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info add  version_number varchar(15) null; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info add  version_date 	datetime null; "

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_fee_sched_nm add  custom_text4 varchar(255) null; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_fee_sched_nm add  custom_text5 varchar(255) null; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_fee_sched_nm add  custom_text6 varchar(255) null; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_fee_sched_nm add  custom_text7 varchar(255) null; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_fee_sched_nm add  custom_text8 varchar(255) null; "

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_fee_sched_nm add  custom_n1 numeric(10,2) null; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_fee_sched_nm add  custom_n2 numeric(10,2) null; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_fee_sched_nm add  custom_n3 numeric(10,2) null; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_fee_sched_nm add  custom_n4 numeric(10,2) null; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_fee_sched_nm add  custom_n5 numeric(10,2) null; "

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Create table ctx_version(ctx_id int not null,version_id int not null,version_number varchar(15) not null,version_date datetime,user_id varchar(20),old_value varchar(100),new_value varchar(100),PRIMARY KEY ( ctx_id,version_id )); "

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from sys_fields where table_id = 1003 and field_id = 20036; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1003,20200,0,'','version_number', 'version_number',512, 'C' ,5,'','','',''); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1003,20201,0,'','version_date', 'version_date',512, 'D' ,5,'','','',''); "

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1003,20202,0,'','custom_11', 'custom_11',512, 'C' ,5,'','','',''); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1003,20203,0,'','custom_12', 'custom_12',512, 'C' ,5,'','','',''); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1003,20204,0,'','custom_13', 'custom_13',512, 'C' ,5,'','','',''); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1003,20205,0,'','custom_14', 'custom_14',512, 'C' ,5,'','','',''); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1003,20206,0,'','custom_15', 'custom_15',512, 'C' ,5,'','','',''); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1003,20207,0,'','custom_16', 'custom_16',512, 'C' ,5,'','','',''); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1003,20208,0,'','custom_17', 'custom_17',512, 'C' ,5,'','','',''); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1003,20209,0,'','custom_18', 'custom_18',512, 'C' ,5,'','','',''); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1003,20210,0,'','custom_19', 'custom_19',512, 'C' ,5,'','','',''); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1003,20211,0,'','custom_20', 'custom_20',512, 'C' ,5,'','','',''); "

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1003,20212,0,'','custom_date1', 'custom_date1',512, 'D' ,5,'','','',''); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1003,20213,0,'','custom_date2', 'custom_date2',512, 'D' ,5,'','','',''); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1003,20214,0,'','custom_date3', 'custom_date3',512, 'D' ,5,'','','',''); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1003,20215,0,'','custom_date4', 'custom_date4',512, 'D' ,5,'','','',''); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1003,20216,0,'','custom_date5', 'custom_date5',512, 'D' ,5,'','','',''); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1003,20217,0,'','custom_date6', 'custom_date6',512, 'D' ,5,'','','',''); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1003,20218,0,'','custom_date7', 'custom_date7',512, 'D' ,5,'','','',''); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1003,20219,0,'','custom_date8', 'custom_date8',512, 'D' ,5,'','','',''); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1003,20220,0,'','custom_date9', 'custom_date9',512, 'D' ,5,'','','',''); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1003,20221,0,'','custom_date10', 'custom_date10',512, 'D' ,5,'','','',''); "

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1003,20222,0,'','custom_n1', 'custom_n1',512, 'N' ,5,'','','',''); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1003,20223,0,'','custom_n2', 'custom_n2',512, 'N' ,5,'','','',''); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1003,20224,0,'','custom_n3', 'custom_n3',512, 'N' ,5,'','','',''); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1003,20225,0,'','custom_n4', 'custom_n4',512, 'N' ,5,'','','',''); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1003,20226,0,'','custom_n5', 'custom_n5',512, 'N' ,5,'','','',''); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1003,20227,0,'','custom_n6', 'custom_n6',512, 'N' ,5,'','','',''); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1003,20228,0,'','custom_n7', 'custom_n7',512, 'N' ,5,'','','',''); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1003,20229,0,'','custom_n8', 'custom_n8',512, 'N' ,5,'','','',''); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1003,20230,0,'','custom_n9', 'custom_n9',512, 'N' ,5,'','','',''); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1003,20231,0,'','custom_n10', 'custom_n10',512, 'N' ,5,'','','',''); "

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 05.16.2007 By: Frank.Gui
//$<reason> Droping and creating view will change id of this view and will make IntelliReport failed.
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "DROP view v_ctx_basic_info; "
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007.07.03 By: Scofield
//$<Reason> Input the code to a function
//ls_sql = of_get_view_action( 'v_ctx_basic_info') +" as SELECT "
ls_sql = of_set_view_sql('v_ctx_basic_info',ls_tag)
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007.07.03 By: Scofield
//$<Reason> Input the code to function
//ls_sql = of_get_view_action( 'v_ctx_basic_info_master_link') +" as SELECT " + &
ls_sql = of_set_view_sql('v_ctx_basic_info_master_link',ls_tag)
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 05.16.2007 By: Frank.Gui
//$<reason> Droping and creating view will change id of this view and will make IntelliReport failed.
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "DROP view v_ctx_basic_info_alarms; "
//---------------------------- APPEON END ----------------------------

ls_sql = of_get_view_action( 'v_ctx_basic_info_alarms') +" as SELECT CTX_BASIC_INFO.ctx_id, " + &
	"app_facility.facility_name, " + &
	"CTX_NOTIFICATION_USERS.user_id, " + &
	"CTX_NOTIFICATION.alm_message, " + &
	"CTX_NOTIFICATION.alm_enabled, " + &
	"CTX_NOTIFICATION.alm_notification_days, " + &
	"CTX_NOTIFICATION.alm_last_notification_sent, " + &
	"CTX_NOTIFICATION.alm_post_notification_days, " + &
	"CTX_NOTIFICATION.alm_total_tries, " + &
	"CTX_NOTIFICATION.alm_action_item_posted, " + &
	"CTX_NOTIFICATION.alm_total_tries_counter, " + & 
	"CTX_NOTIFICATION.alm_frequency, " + &
	"CTX_NOTIFICATION.create_action_item " + &
"FROM ((CTX_BASIC_INFO LEFT OUTER JOIN CTX_NOTIFICATION ON CTX_BASIC_INFO.ctx_id = CTX_NOTIFICATION.ctx_id) INNER JOIN CTX_NOTIFICATION_USERS ON CTX_BASIC_INFO.ctx_id = CTX_NOTIFICATION_USERS.ctx_id) INNER JOIN app_facility ON CTX_BASIC_INFO.app_facility = app_facility.facility_id " + &
"GROUP BY CTX_BASIC_INFO.ctx_id, app_facility.facility_name, CTX_NOTIFICATION_USERS.user_id, CTX_NOTIFICATION.alm_message, CTX_NOTIFICATION.alm_enabled, CTX_NOTIFICATION.alm_notification_days, CTX_NOTIFICATION.alm_last_notification_sent, CTX_NOTIFICATION.alm_post_notification_days, CTX_NOTIFICATION.alm_total_tries, CTX_NOTIFICATION.alm_action_item_posted, CTX_NOTIFICATION.alm_total_tries_counter, CTX_NOTIFICATION.alm_frequency, CTX_NOTIFICATION.create_action_item" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql 


//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 05.16.2007 By: Frank.Gui
//$<reason> Droping and creating view will change id of this view and will make IntelliReport failed.
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "DROP view v_ctx_contacts_contacts; "
//---------------------------- APPEON END ----------------------------

ls_sql = of_get_view_action( 'v_ctx_contacts_contacts') +" as SELECT " + &
	"CTX_BASIC_INFO.ctx_id, " + &
	"app_facility.facility_name, " + &
	"CTX_CONTRACT_CONTACTS.contact_id, " + &
	"CTX_CONTRACT_CONTACTS.association, " + &
	"code_lookup.code aS contract_type_code, " + &	
	"code_lookup.description AS contract_type_description, " + &
	"CTX_CONTACTS.first_name, " + &
	"CTX_CONTACTS.last_name, " + &
	"CTX_CONTACTS.middle_name, " + &
	"code_lookup_4.description as contact_title, " + &
	"code_lookup_1.code AS contract_department_code, " + &
	"code_lookup_1.description AS contract_department_description, " + &
	"CTX_CONTACTS.street_1, " + &
	"CTX_CONTACTS.street_2, " + &
	"CTX_CONTACTS.street_3, " + &
	"CTX_CONTACTS.city, " + &
	"CTX_CONTACTS.zip, " + &
	"code_lookup_2.code AS state, " + &
	"CTX_CONTACTS.custom_1, " + &
	"CTX_CONTACTS.custom_2, " + &
	"CTX_CONTACTS.custom_3, " + &
	"CTX_CONTACTS.custom_4, " + &
	"CTX_CONTACTS.custom_5, " + &
	"CTX_CONTACTS.custom_6, " + &
	"CTX_CONTACTS.custom_7, " + &
	"CTX_CONTACTS.custom_8, " + &
	"CTX_CONTACTS.custom_9, " + &
	"CTX_CONTACTS.custom_10, " + &
	"CTX_CONTRACT_CONTACTS.owner, " + &
	"CTX_CONTRACT_CONTACTS.access, " + &
	"code_lookup_3.code AS Phone_Type_code, " + &
	"code_lookup_3.description AS Phone_type_Description, " + &
	"'(' + LEFT( CTX_CONTACTS_NUMBERS.phone,3 ) + ')' + substring( CTX_CONTACTS_NUMBERS.phone, 4, 3) + '-' + RIGHT( CTX_CONTACTS_NUMBERS.phone, 4 ) AS phone, " + &
	"CTX_CONTACTS_NUMBERS.ext, " + &
	"CTX_CONTACTS_NUMBERS.contact_email, " + &
	"CTX_CONTRACT_CONTACTS.notes " + &
"FROM ((((((((CTX_BASIC_INFO INNER JOIN CTX_CONTRACT_CONTACTS ON CTX_BASIC_INFO.ctx_id = CTX_CONTRACT_CONTACTS.ctx_id) LEFT OUTER JOIN CTX_CONTACTS ON CTX_CONTRACT_CONTACTS.contact_id = CTX_CONTACTS.contact_id) LEFT OUTER JOIN code_lookup ON CTX_CONTACTS.contact_type = code_lookup.lookup_code) LEFT OUTER JOIN code_lookup AS code_lookup_1 ON CTX_CONTACTS.contact_department = code_lookup_1.lookup_code) LEFT OUTER JOIN code_lookup AS code_lookup_2 ON CTX_CONTACTS.state = code_lookup_2.lookup_code) LEFT OUTER JOIN CTX_CONTACTS_NUMBERS ON CTX_CONTACTS.contact_id = CTX_CONTACTS_NUMBERS.contact_id) LEFT OUTER JOIN code_lookup AS code_lookup_3 ON CTX_CONTACTS_NUMBERS.via = code_lookup_3.lookup_code) LEFT OUTER JOIN code_lookup AS code_lookup_4 ON CTX_CONTACTS.contact_title = code_lookup_4.lookup_code) INNER JOIN app_facility ON CTX_BASIC_INFO.app_facility = app_facility.facility_id " + &
"GROUP BY CTX_BASIC_INFO.ctx_id, app_facility.facility_name, CTX_CONTRACT_CONTACTS.contact_id, CTX_CONTRACT_CONTACTS.association, code_lookup.code, code_lookup.description, CTX_CONTACTS.first_name, CTX_CONTACTS.last_name, CTX_CONTACTS.middle_name, CTX_CONTACTS.contact_title, code_lookup_1.code, code_lookup_1.description, CTX_CONTACTS.street_1, CTX_CONTACTS.street_2, CTX_CONTACTS.street_3, CTX_CONTACTS.city, CTX_CONTACTS.zip, code_lookup_2.code, CTX_CONTACTS.custom_1, CTX_CONTACTS.custom_2, CTX_CONTACTS.custom_3, CTX_CONTACTS.custom_4, CTX_CONTACTS.custom_5, CTX_CONTACTS.custom_6, CTX_CONTACTS.custom_7, CTX_CONTACTS.custom_8, CTX_CONTACTS.custom_9, CTX_CONTACTS.custom_10, CTX_CONTRACT_CONTACTS.owner, CTX_CONTRACT_CONTACTS.access, code_lookup_3.code, code_lookup_3.description, code_lookup_4.description, CTX_CONTACTS_NUMBERS.phone, CTX_CONTACTS_NUMBERS.ext, CTX_CONTACTS_NUMBERS.contact_email, CTX_CONTRACT_CONTACTS.notes, CTX_CONTRACT_CONTACTS.ic_area " + &
"HAVING (((CTX_CONTRACT_CONTACTS.ic_area)='c'))" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql 


//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 05.16.2007 By: Frank.Gui
//$<reason> Droping and creating view will change id of this view and will make IntelliReport failed.
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "DROP view v_ctx_contacts_external; "
//---------------------------- APPEON END ----------------------------

ls_sql = of_get_view_action( 'v_ctx_contacts_external') +" as SELECT " + &
	"CTX_BASIC_INFO.ctx_id, " + &
	"app_facility.facility_name, " + &
	"CTX_CONTRACT_CONTACTS.contact_id, " + &
	"CTX_CONTRACT_CONTACTS.association, " + &
	"code_lookup.code aS contract_type_code, " + &	
	"code_lookup.description AS contract_type_description, " + &
	"CTX_CONTACTS.first_name, " + &
	"CTX_CONTACTS.last_name, " + &
	"CTX_CONTACTS.middle_name, " + &
	"code_lookup_4.description as contact_title, " + &
	"code_lookup_1.code AS contract_department_code, " + &
	"code_lookup_1.description AS contract_department_description, " + &
	"CTX_CONTACTS.street_1, " + &
	"CTX_CONTACTS.street_2, " + &
	"CTX_CONTACTS.street_3, " + &
	"CTX_CONTACTS.city, " + &
	"CTX_CONTACTS.zip, " + &
	"code_lookup_2.code AS state, " + &
	"CTX_CONTACTS.custom_1, " + &
	"CTX_CONTACTS.custom_2, " + &
	"CTX_CONTACTS.custom_3, " + &
	"CTX_CONTACTS.custom_4, " + &
	"CTX_CONTACTS.custom_5, " + &
	"CTX_CONTACTS.custom_6, " + &
	"CTX_CONTACTS.custom_7, " + &
	"CTX_CONTACTS.custom_8, " + &
	"CTX_CONTACTS.custom_9, " + &
	"CTX_CONTACTS.custom_10, " + &
	"CTX_CONTRACT_CONTACTS.owner, " + &
	"CTX_CONTRACT_CONTACTS.access, " + &
	"code_lookup_3.code AS Phone_Type_code, " + &
	"code_lookup_3.description AS Phone_type_Description, " + &
	"'(' + LEFT( CTX_CONTACTS_NUMBERS.phone,3 ) + ')' + substring( CTX_CONTACTS_NUMBERS.phone, 4, 3) + '-' + RIGHT( CTX_CONTACTS_NUMBERS.phone, 4 ) AS phone , " + &
	"CTX_CONTACTS_NUMBERS.ext, " + &
	"CTX_CONTACTS_NUMBERS.contact_email " + &
"FROM ((((((((CTX_BASIC_INFO INNER JOIN CTX_CONTRACT_CONTACTS ON CTX_BASIC_INFO.ctx_id = CTX_CONTRACT_CONTACTS.ctx_id) LEFT OUTER JOIN CTX_CONTACTS ON CTX_CONTRACT_CONTACTS.contact_id = CTX_CONTACTS.contact_id) LEFT OUTER JOIN code_lookup ON CTX_CONTACTS.contact_type = code_lookup.lookup_code) LEFT OUTER JOIN code_lookup AS code_lookup_1 ON CTX_CONTACTS.contact_department = code_lookup_1.lookup_code) LEFT OUTER JOIN code_lookup AS code_lookup_2 ON CTX_CONTACTS.state = code_lookup_2.lookup_code) LEFT OUTER JOIN CTX_CONTACTS_NUMBERS ON CTX_CONTACTS.contact_id = CTX_CONTACTS_NUMBERS.contact_id) LEFT OUTER JOIN code_lookup AS code_lookup_3 ON CTX_CONTACTS_NUMBERS.via = code_lookup_3.lookup_code) LEFT OUTER JOIN code_lookup AS code_lookup_4 ON CTX_CONTACTS.contact_title = code_lookup_4.lookup_code) INNER JOIN app_facility ON CTX_BASIC_INFO.app_facility = app_facility.facility_id " + &
"GROUP BY CTX_BASIC_INFO.ctx_id, app_facility.facility_name, CTX_CONTRACT_CONTACTS.contact_id, CTX_CONTRACT_CONTACTS.association, code_lookup.code, code_lookup.description, CTX_CONTACTS.first_name, CTX_CONTACTS.last_name, CTX_CONTACTS.middle_name, CTX_CONTACTS.contact_title, code_lookup_1.code, code_lookup_1.description, CTX_CONTACTS.street_1, CTX_CONTACTS.street_2, CTX_CONTACTS.street_3, CTX_CONTACTS.city, CTX_CONTACTS.zip, code_lookup_2.code, CTX_CONTACTS.custom_1, CTX_CONTACTS.custom_2, CTX_CONTACTS.custom_3, CTX_CONTACTS.custom_4, CTX_CONTACTS.custom_5, CTX_CONTACTS.custom_6, CTX_CONTACTS.custom_7, CTX_CONTACTS.custom_8, CTX_CONTACTS.custom_9, CTX_CONTACTS.custom_10, CTX_CONTRACT_CONTACTS.owner, CTX_CONTRACT_CONTACTS.access, code_lookup_3.code, code_lookup_3.description, code_lookup_4.description, CTX_CONTACTS_NUMBERS.phone, CTX_CONTACTS_NUMBERS.ext, CTX_CONTACTS_NUMBERS.contact_email, CTX_CONTRACT_CONTACTS.ic_area " + &
"HAVING (((CTX_CONTRACT_CONTACTS.ic_area)='e'))" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql 

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 05.16.2007 By: Frank.Gui
//$<reason> Droping and creating view will change id of this view and will make IntelliReport failed.
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "DROP view v_ctx_contacts_internal; "
//---------------------------- APPEON END ----------------------------

ls_sql = of_get_view_action( 'v_ctx_contacts_internal') +" as SELECT " + &
	"CTX_BASIC_INFO.ctx_id, " + &
	"app_facility.facility_name, " + &
	"CTX_CONTRACT_CONTACTS.contact_id, " + &
	"CTX_CONTRACT_CONTACTS.association, " + &
	"code_lookup.code aS contract_type_code, " + &	
	"code_lookup.description AS contract_type_description, " + &
	"CTX_CONTACTS.first_name, " + &
	"CTX_CONTACTS.last_name, " + &
	"CTX_CONTACTS.middle_name, " + &
	"code_lookup_4.description as contact_title, " + &
	"code_lookup_1.code AS contract_department_code, " + &
	"code_lookup_1.description AS contract_department_description, " + &
	"CTX_CONTACTS.street_1, " + &
	"CTX_CONTACTS.street_2, " + &
	"CTX_CONTACTS.street_3, " + &
	"CTX_CONTACTS.city, " + &
	"CTX_CONTACTS.zip, " + &
	"code_lookup_2.code AS state, " + &
	"CTX_CONTACTS.custom_1, " + &
	"CTX_CONTACTS.custom_2, " + &
	"CTX_CONTACTS.custom_3, " + &
	"CTX_CONTACTS.custom_4, " + &
	"CTX_CONTACTS.custom_5, " + &
	"CTX_CONTACTS.custom_6, " + &
	"CTX_CONTACTS.custom_7, " + &
	"CTX_CONTACTS.custom_8, " + &
	"CTX_CONTACTS.custom_9, " + &
	"CTX_CONTACTS.custom_10, " + &
	"CTX_CONTRACT_CONTACTS.owner, " + &
	"CTX_CONTRACT_CONTACTS.access, " + &
	"code_lookup_3.code AS Phone_Type_code, " + &
	"code_lookup_3.description AS Phone_type_Description, " + &
	"'(' + LEFT( CTX_CONTACTS_NUMBERS.phone,3 ) + ')' + substring( CTX_CONTACTS_NUMBERS.phone, 4, 3) + '-' + RIGHT( CTX_CONTACTS_NUMBERS.phone, 4 ) AS phone , " + &
	"CTX_CONTACTS_NUMBERS.ext, " + &
	"CTX_CONTACTS_NUMBERS.contact_email " + &
"FROM ((((((((CTX_BASIC_INFO INNER JOIN CTX_CONTRACT_CONTACTS ON CTX_BASIC_INFO.ctx_id = CTX_CONTRACT_CONTACTS.ctx_id) LEFT OUTER JOIN CTX_CONTACTS ON CTX_CONTRACT_CONTACTS.contact_id = CTX_CONTACTS.contact_id) LEFT OUTER JOIN code_lookup ON CTX_CONTACTS.contact_type = code_lookup.lookup_code) LEFT OUTER JOIN code_lookup AS code_lookup_1 ON CTX_CONTACTS.contact_department = code_lookup_1.lookup_code) LEFT OUTER JOIN code_lookup AS code_lookup_2 ON CTX_CONTACTS.state = code_lookup_2.lookup_code) LEFT OUTER JOIN CTX_CONTACTS_NUMBERS ON CTX_CONTACTS.contact_id = CTX_CONTACTS_NUMBERS.contact_id) LEFT OUTER JOIN code_lookup AS code_lookup_3 ON CTX_CONTACTS_NUMBERS.via = code_lookup_3.lookup_code) LEFT OUTER JOIN code_lookup AS code_lookup_4 ON CTX_CONTACTS.contact_title = code_lookup_4.lookup_code) INNER JOIN app_facility ON CTX_BASIC_INFO.app_facility = app_facility.facility_id " + &
"GROUP BY CTX_BASIC_INFO.ctx_id, app_facility.facility_name, CTX_CONTRACT_CONTACTS.contact_id, CTX_CONTRACT_CONTACTS.association, code_lookup.code, code_lookup.description, CTX_CONTACTS.first_name, CTX_CONTACTS.last_name, CTX_CONTACTS.middle_name, CTX_CONTACTS.contact_title, code_lookup_1.code, code_lookup_1.description, CTX_CONTACTS.street_1, CTX_CONTACTS.street_2, CTX_CONTACTS.street_3, CTX_CONTACTS.city, CTX_CONTACTS.zip, code_lookup_2.code, CTX_CONTACTS.custom_1, CTX_CONTACTS.custom_2, CTX_CONTACTS.custom_3, CTX_CONTACTS.custom_4, CTX_CONTACTS.custom_5, CTX_CONTACTS.custom_6, CTX_CONTACTS.custom_7, CTX_CONTACTS.custom_8, CTX_CONTACTS.custom_9, CTX_CONTACTS.custom_10, CTX_CONTRACT_CONTACTS.owner, CTX_CONTRACT_CONTACTS.access, code_lookup_3.code, code_lookup_3.description, code_lookup_4.description, CTX_CONTACTS_NUMBERS.phone, CTX_CONTACTS_NUMBERS.ext, CTX_CONTACTS_NUMBERS.contact_email, CTX_CONTRACT_CONTACTS.ic_area " + &
"HAVING (((CTX_CONTRACT_CONTACTS.ic_area)='i'))" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql 

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 05.16.2007 By: Frank.Gui
//$<reason> Droping and creating view will change id of this view and will make IntelliReport failed.
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "DROP view v_ctx_fee_schedule; "
//---------------------------- APPEON END ----------------------------

ls_sql = of_get_view_action( 'v_ctx_fee_schedule') +" as select " + &
	"CTX_FEE_SCHED_HDR.ctx_id, " + &
	"code_lookup.description as carve_out_type, " + &
	"code_lookup_1.description as sched_type, " + &
	"CTX_FEE_SCHED_HDR.custom_1, " + &		
	"cTX_FEE_SCHED_HDR.custom_2, " + &
	"CTX_FEE_SCHED_HDR.custom_3, " + &
	"CTX_FEE_SCHED_HDR.custom_4, " + &
	"CTX_FEE_SCHED_HDR.custom_5, " + &
	"CTX_FEE_SCHED_HDR.notes " + &
"from(CTX_FEE_SCHED_HDR left outer join code_lookup on CTX_FEE_SCHED_HDR.carve_out_type = code_lookup.lookup_code) left outer join code_lookup as code_lookup_1 on CTX_FEE_SCHED_HDR.sched_type = code_lookup_1.lookup_code" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql 

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 05.16.2007 By: Frank.Gui
//$<reason> Droping and creating view will change id of this view and will make IntelliReport failed.
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "DROP view v_ctx_feee_schedule_codes; "
//---------------------------- APPEON END ----------------------------

ls_sql = of_get_view_action( 'v_ctx_feee_schedule_codes') +" as SELECT " + &
	"CTX_FEE_SCHED_HDR.ctx_id, " + &
	"CTX_FEE_SCHED_DATA.code, " + &
	"code_lookup.description AS carve_out_type_description, " + &
	"code_lookup_1.description AS sched_type_description, " + &
	"code_lookup_2.description AS location_description, " + &
	"code_lookup_2.code AS location_code, " + &
	"code_lookup_3.description AS status, " + &
	"CTX_FEE_SCHED_DATA.fee, " + &
	"CTX_FEE_SCHED_DATA.effective_date, " + &
	"CTX_FEE_SCHED_DATA.expiration_date, " + &
	"CTX_FEE_SCHED_DATA.office_fee, " + &
	"CTX_FEE_SCHED_DATA.facility_fee, " + &
	"CTX_FEE_SCHED_DATA.custom_fee, " + &
	"CTX_FEE_SCHED_DATA.precert, " + &
	"CTX_FEE_SCHED_DATA.preauth, " + &
	"CTX_FEE_SCHED_DATA.base_price, " + &
	"CTX_FEE_SCHED_DATA.phys_fee, " + &
	"CTX_FEE_SCHED_DATA.custom_1, " + &
	"CTX_FEE_SCHED_DATA.custom_2, " + &
	"CTX_FEE_SCHED_DATA.custom_3, " + &
	"CTX_FEE_SCHED_DATA.custom_4, " + &
	"CTX_FEE_SCHED_DATA.custom_5, " + &
	"CTX_FEE_SCHED_DATA.fee_basis, " + &
	"CTX_FEE_SCHED_DATA.inserted_by_user, " + &
	"CTX_FEE_SCHED_DATA.inserted_at_date_time, " + &
	"CTX_FEE_SCHED_DATA.updated_by_user, " + &
	"CTX_FEE_SCHED_DATA.updated_at_date_time " + &
"FROM (CTX_FEE_SCHED_DATA INNER JOIN ((((CTX_FEE_SCHED_HDR LEFT OUTER JOIN code_lookup ON CTX_FEE_SCHED_HDR.carve_out_type = code_lookup.lookup_code) LEFT OUTER JOIN code_lookup AS code_lookup_1 ON CTX_FEE_SCHED_HDR.sched_type = code_lookup_1.lookup_code) INNER JOIN CTX_FEE_SCHED_LOCATIONS ON CTX_FEE_SCHED_HDR.fee_sched_id = CTX_FEE_SCHED_LOCATIONS.fee_sched_id) INNER JOIN code_lookup AS code_lookup_2 ON CTX_FEE_SCHED_LOCATIONS.location = code_lookup_2.lookup_code) ON CTX_FEE_SCHED_DATA.fee_sched_location_id = CTX_FEE_SCHED_LOCATIONS.fee_sched_location_id) INNER JOIN code_lookup AS code_lookup_3 ON CTX_FEE_SCHED_DATA.status = code_lookup_3.lookup_code " + &
"GROUP BY CTX_FEE_SCHED_HDR.ctx_id, CTX_FEE_SCHED_DATA.code, code_lookup.description, code_lookup_1.description, code_lookup_2.description, code_lookup_2.code, code_lookup_3.description, CTX_FEE_SCHED_DATA.fee, CTX_FEE_SCHED_DATA.effective_date, CTX_FEE_SCHED_DATA.expiration_date, CTX_FEE_SCHED_DATA.office_fee, CTX_FEE_SCHED_DATA.facility_fee, CTX_FEE_SCHED_DATA.custom_fee, CTX_FEE_SCHED_DATA.precert, CTX_FEE_SCHED_DATA.preauth, CTX_FEE_SCHED_DATA.base_price, CTX_FEE_SCHED_DATA.phys_fee, CTX_FEE_SCHED_DATA.custom_1, CTX_FEE_SCHED_DATA.custom_2, CTX_FEE_SCHED_DATA.custom_3, CTX_FEE_SCHED_DATA.custom_4, CTX_FEE_SCHED_DATA.custom_5, CTX_FEE_SCHED_DATA.fee_basis, CTX_FEE_SCHED_DATA.inserted_by_user, CTX_FEE_SCHED_DATA.inserted_at_date_time, CTX_FEE_SCHED_DATA.updated_by_user, CTX_FEE_SCHED_DATA.updated_at_date_time " + &
"HAVING (((CTX_FEE_SCHED_DATA.fee)<>0))" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql 

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 05.16.2007 By: Frank.Gui
//$<reason> Droping and creating view will change id of this view and will make IntelliReport failed.
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "DROP view v_ctx_feee_schedule_locations; "
//---------------------------- APPEON END ----------------------------

ls_sql = of_get_view_action( 'v_ctx_feee_schedule_locations') +" as SELECT " + &
	"CTX_FEE_SCHED_HDR.ctx_id, " + &
	"code_lookup.description AS carve_out_type, " + &
	"code_lookup_1.description AS sched_type, " + &
	"code_lookup_2.description AS location_description, " + &
	"code_lookup_2.code AS location_code, " + &
	"CTX_FEE_SCHED_LOCATIONS.rate, " + &
	"CTX_FEE_SCHED_LOCATIONS.fee_bonus, " + &
	"CTX_ITEM.item_name AS fee_basis " + &
"FROM ((((CTX_FEE_SCHED_HDR LEFT OUTER JOIN code_lookup ON CTX_FEE_SCHED_HDR.carve_out_type = code_lookup.lookup_code) LEFT OUTER JOIN code_lookup AS code_lookup_1 ON CTX_FEE_SCHED_HDR.sched_type = code_lookup_1.lookup_code) INNER JOIN CTX_FEE_SCHED_LOCATIONS ON CTX_FEE_SCHED_HDR.fee_sched_id = CTX_FEE_SCHED_LOCATIONS.fee_sched_id) INNER JOIN code_lookup AS code_lookup_2 ON CTX_FEE_SCHED_LOCATIONS.location = code_lookup_2.lookup_code) LEFT OUTER JOIN CTX_ITEM ON CTX_FEE_SCHED_LOCATIONS.fee_bonus = CTX_ITEM.item_id" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql 

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 05.16.2007 By: Frank.Gui
//$<reason> Droping and creating view will change id of this view and will make IntelliReport failed.
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "DROP view v_ctx_feee_schedule_practitioners; "
//---------------------------- APPEON END ----------------------------

ls_sql = of_get_view_action( 'v_ctx_feee_schedule_practitioners') +" as SELECT " + &
	"CTX_FEE_SCHED_HDR.ctx_id, " + &
	"code_lookup.description AS carve_out_type, " + &
	"code_lookup_1.description AS sched_type, " + &
	"pd_basic.last_name, " + &
	"pd_basic.first_name, " + &
	"pd_basic.prac_id " + &
"FROM (((CTX_FEE_SCHED_HDR LEFT OUTER JOIN code_lookup ON CTX_FEE_SCHED_HDR.carve_out_type = code_lookup.lookup_code) LEFT OUTER JOIN code_lookup AS code_lookup_1 ON CTX_FEE_SCHED_HDR.sched_type = code_lookup_1.lookup_code) INNER JOIN CTX_FEE_SCHED_PRACS ON CTX_FEE_SCHED_HDR.fee_sched_id = CTX_FEE_SCHED_PRACS.fee_sched_id) INNER JOIN pd_basic ON CTX_FEE_SCHED_PRACS.practitioner_id = pd_basic.prac_id" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql 

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 05.16.2007 By: Frank.Gui
//$<reason> Droping and creating view will change id of this view and will make IntelliReport failed.
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "DROP view v_ctx_groups; "
//---------------------------- APPEON END ----------------------------

ls_sql = of_get_view_action( 'v_ctx_groups') +" as select " + &
	"CTX_LOC.ctx_id, " + &
	"app_facility.facility_name, " + &
	"group_multi_loc.gp_name, " + &
	"CTX_LOC.parent_comp_id, " + &
	"group_multi_loc.rec_id, " + &
	"group_multi_loc.street1, " + &
	"group_multi_loc.city, " + &
	"group_multi_loc.state, " + &
	"group_multi_loc.phone, " + &
	"group_multi_loc.zip, " + &
	"group_multi_loc.contact_name " + &
"from((group_multi_loc join CTX_LOC on group_multi_loc.rec_id = CTX_LOC.parent_comp_id) join CTX_BASIC_INFO on " + &
"CTX_LOC.ctx_id = CTX_BASIC_INFO.ctx_id) join app_facility on CTX_BASIC_INFO.app_facility = app_facility.facility_id " + &
"group by CTX_LOC.ctx_id,app_facility.facility_name,group_multi_loc.gp_name,CTX_LOC.parent_comp_id,group_multi_loc.rec_id,group_multi_loc.street1,group_multi_loc.city,group_multi_loc.state,group_multi_loc.phone,group_multi_loc.zip,group_multi_loc.contact_name" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql 

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 05.16.2007 By: Frank.Gui
//$<reason> Droping and creating view will change id of this view and will make IntelliReport failed.
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "DROP view v_ctx_groups_locations; "
//---------------------------- APPEON END ----------------------------

ls_sql = of_get_view_action( 'v_ctx_groups_locations') +" as SELECT " + &
	"CTX_LOC.ctx_id, " + &
	"app_facility.facility_name, " + &
	"group_multi_loc.gp_name, " + &
	"CTX_LOC.parent_comp_id AS grp_id, " + &
	"CTX_LOC.loc_id, " + &
	"group_practice.practice_type, " + &
	"group_practice.active_status, " + &
	"group_practice.street AS location_name, " + &
	"group_practice.street_2, " + &
	"group_practice.city, " + &
	"code_lookup_1.code AS state, " + &
	"code_lookup.description AS country, " + &
	"group_practice.pager_number, " + &
	"group_practice.phone, " + &
	"group_practice.ext, " + &
	"group_practice.fax, " + &
	"group_practice.zip, " + &
	"group_practice.contact_person, " + &
	"group_practice.e_mail_address, " + &
	"group_practice.web_address " + &
"FROM (((((group_multi_loc INNER JOIN CTX_LOC ON group_multi_loc.rec_id = CTX_LOC.parent_comp_id) INNER JOIN CTX_BASIC_INFO ON CTX_LOC.ctx_id = CTX_BASIC_INFO.ctx_id) INNER JOIN app_facility ON CTX_BASIC_INFO.app_facility = app_facility.facility_id) INNER JOIN group_practice ON CTX_LOC.loc_id = group_practice.rec_id) LEFT OUTER JOIN code_lookup ON group_practice.country = code_lookup.lookup_code) LEFT OUTER JOIN code_lookup AS code_lookup_1 ON group_practice.state = code_lookup_1.lookup_code " + &
"GROUP BY CTX_LOC.ctx_id, app_facility.facility_name, group_multi_loc.gp_name, CTX_LOC.parent_comp_id, CTX_LOC.loc_id, group_practice.practice_type, group_practice.active_status, group_practice.street, group_practice.street_2, group_practice.city, code_lookup_1.code, code_lookup.description, group_practice.pager_number, group_practice.phone, group_practice.ext, group_practice.fax, group_practice.zip, group_practice.contact_person, group_practice.e_mail_address, group_practice.web_address" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql 

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 05.16.2007 By: Frank.Gui
//$<reason> Droping and creating view will change id of this view and will make IntelliReport failed.
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "DROP view v_ctx_locations_pracs; "
//---------------------------- APPEON END ----------------------------

ls_sql = of_get_view_action( 'v_ctx_locations_pracs') +" as sELECT " + &
	"CTX_LOC.ctx_id, " + &
	"CTX_LOC.parent_comp_id AS grp_id, " + &
	"group_practice.street AS locatioin_name, " + &
	"CTX_LOC.loc_id, " + &
	"pd_basic.last_name, " + &
	"pd_basic.first_name, " + &
	"pd_basic.prac_id " + &
"FROM ((CTX_LOC INNER JOIN CTX_LOCATION_PRACS ON (CTX_LOC.ctx_id = CTX_LOCATION_PRACS.ctx_id) AND (CTX_LOC.parent_comp_id = CTX_LOCATION_PRACS.parent_comp_id) AND (CTX_LOC.loc_id = CTX_LOCATION_PRACS.loc_id)) INNER JOIN pd_basic ON CTX_LOCATION_PRACS.prac_id = pd_basic.prac_id) INNER JOIN group_practice ON CTX_LOCATION_PRACS.loc_id = group_practice.rec_id " + &
"GROUP BY CTX_LOC.ctx_id, CTX_LOC.parent_comp_id, group_practice.street, CTX_LOC.loc_id, pd_basic.last_name, pd_basic.first_name, pd_basic.prac_id " + &
"HAVING (((CTX_LOC.loc_id)<>0))" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql 

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 05.16.2007 By: Frank.Gui
//$<reason> Droping and creating view will change id of this view and will make IntelliReport failed.
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "DROP view v_ctx_locations_speciality; "
//---------------------------- APPEON END ----------------------------

ls_sql = of_get_view_action( 'v_ctx_locations_speciality') +" as SELECT " + &
	"CTX_LOC.ctx_id, " + &
	"CTX_LOC.parent_comp_id AS grp_id, " + &
	"group_practice.street AS location_name, " + &
	"CTX_LOC.loc_id, " + &
	"code_lookup.description AS specialty_description, " + &
	"code_lookup.code AS speciality_code " + &
"FROM ((CTX_LOC INNER JOIN CTX_LOCATION_SPECIALTY ON (CTX_LOC.loc_id = CTX_LOCATION_SPECIALTY.loc_id) AND (CTX_LOC.parent_comp_id = CTX_LOCATION_SPECIALTY.parent_comp_id) AND (CTX_LOC.ctx_id = CTX_LOCATION_SPECIALTY.ctx_id)) INNER JOIN code_lookup ON CTX_LOCATION_SPECIALTY.Prac_specialty = code_lookup.lookup_code) INNER JOIN group_practice ON CTX_LOCATION_SPECIALTY.loc_id = group_practice.rec_id " + &
"GROUP BY CTX_LOC.ctx_id, CTX_LOC.parent_comp_id, group_practice.street, CTX_LOC.loc_id, code_lookup.description, code_lookup.code " + &
"HAVING (((CTX_LOC.loc_id)<>0))" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql 

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 05.16.2007 By: Frank.Gui
//$<reason> Droping and creating view will change id of this view and will make IntelliReport failed.
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "DROP view v_ctx_organizations; "
//---------------------------- APPEON END ----------------------------

ls_sql = of_get_view_action( 'v_ctx_organizations') +" as SELECT " + &
	"CTX_ORGS_CONTACT.ctx_id, " + &
	"CTX_ORGS.org_name, " + &
	"code_lookup.code AS org_type_code, " + &
	"code_lookup.description AS org_type_description, " + &
	"CTX_ORGS.status, " + &
	"CTX_ORGS.street_1, " + &
	"CTX_ORGS.street_2, " + &
	"CTX_ORGS.street_3, " + &
	"CTX_ORGS.city, " + &
	"code_lookup_1.code AS state, " + &
	"CTX_ORGS.zip, CTX_ORGS_CONTACT.notes, " + &
	"CTX_ORGS.drections, " + &
	"CTX_ORGS.record_id, " + &
	"CTX_ORG_CONTACT.contact_name, " + &
	"CTX_ORG_CONTACT.department, " + &
	"code_lookup_2.code AS phone_type_code, " + &
	"CTX_ORG_CONTACT.phone " + &
"FROM ((((CTX_ORGS LEFT OUTER JOIN code_lookup ON CTX_ORGS.org_type = code_lookup.lookup_code) LEFT OUTER JOIN code_lookup AS code_lookup_1 ON CTX_ORGS.state = code_lookup_1.lookup_code) INNER JOIN CTX_ORGS_CONTACT ON CTX_ORGS.org_id = CTX_ORGS_CONTACT.org_id) LEFT OUTER JOIN CTX_ORG_CONTACT ON CTX_ORGS.org_id = CTX_ORG_CONTACT.org_id) LEFT OUTER JOIN code_lookup AS code_lookup_2 ON CTX_ORG_CONTACT.via = code_lookup_2.lookup_code " + &
"GROUP BY CTX_ORGS_CONTACT.ctx_id, CTX_ORGS.org_name, code_lookup.code, code_lookup.description, CTX_ORGS.status, CTX_ORGS.street_1, CTX_ORGS.street_2, CTX_ORGS.street_3, CTX_ORGS.city, code_lookup_1.code, CTX_ORGS.zip, CTX_ORGS_CONTACT.notes, CTX_ORGS.drections, CTX_ORGS.record_id, CTX_ORG_CONTACT.contact_name, CTX_ORG_CONTACT.department, code_lookup_2.code, CTX_ORG_CONTACT.phone" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql 


ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Alter table security_modules add prod_id integer null; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Alter table security_sub_module add prod_id integer null; "

//Action Items
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert security_sub_module( module_id, sub_module_id, sub_module_name ) values( 3, 520, 'Application Status'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 5200, 3, 520, 'View Rights', 2 ); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert security_sub_module( module_id, sub_module_id, sub_module_name ) values( 3, 521, 'Contracts'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 5210, 3, 521, 'View Rights', 2 ); "

//Screen Painter - Contract
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into security_modules( module_id, software_version, module_name ) values( 53, 4, 'Screen Painter - Contract'); "

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert security_sub_module( module_id, sub_module_id, sub_module_name ) values( 53, 530, 'Main'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 5300, 53, 530, 'View Rights', 2 ); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert security_sub_module( module_id, sub_module_id, sub_module_name ) values( 53, 531, 'View Manager'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 5310, 53, 531, 'View Rights', 2 ); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert security_sub_module( module_id, sub_module_id, sub_module_name ) values( 53, 532, 'Field Properties'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 5320, 53, 532, 'View Rights', 2 ); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert security_sub_module( module_id, sub_module_id, sub_module_name ) values( 53, 533, 'Screen Parameters'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 5330, 53, 533, 'View Rights', 2 ); "

//View painter
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into security_modules( module_id, software_version, module_name ) values( 54, 4, 'View Painter - Contract'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert security_sub_module( module_id, sub_module_id, sub_module_name ) values( 54, 540, 'Main'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 5400, 54, 540, 'View Rights', 2 ); "

//System
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert security_sub_module( module_id, sub_module_id, sub_module_name ) values( 25, 550, 'Scan OIG'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 5500, 25, 550, 'View Rights', 2 ); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert security_sub_module( module_id, sub_module_id, sub_module_name ) values( 25, 551, 'Import OIG'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 5510, 25, 551, 'View Rights', 2 ); "

//Contract Requirement Profile
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into security_modules( module_id, software_version, module_name ) values( 56, 4, 'Contract Requirement Profile'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert security_sub_module( module_id, sub_module_id, sub_module_name ) values( 56, 560, 'Main'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 5600, 56, 560, 'View Rights', 2 ); "

//Code Import (CPT Code)
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into security_modules( module_id, software_version, module_name ) values( 57, 4, 'Code Import (CPT Code)'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert security_sub_module( module_id, sub_module_id, sub_module_name ) values( 57, 570, 'Main'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 5700, 57, 570, 'View Rights', 2 ); "

//Update prod_id For contract
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Update security_modules Set prod_id = 1 Where module_id in(3,5,53,9,10,11,13,16,19,23,25,28,33,54,56,57,51); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Update security_sub_module Set prod_id = 1 Where sub_module_id in(521,15,530,531,532,533,28,29,30,32,35,540,37,60,80,150,170,290,300,310,320,330,340,350,360,370,380,390,400,430,560,570,510); "
//<add> 08/01/2007 by: Andy
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE security_sub_module SET SUB_MODULE_NAME = 'Fee Schedules' where SUB_MODULE_ID = 360 ; "
//end of add
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Update security_modules Set module_name = 'Screen Painter - Prac Data' Where module_id = 6; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Update security_modules Set module_name = 'View Painter - Prac Data' Where module_id = 18; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 5800, 25, 150, 'Practitioner Data', 2 ) "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 5810, 25, 150, 'Contract Data', 2 ); "
//Contract fee(nm) tab
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 2075, 33, 290, 'Add Lookup Data', 2 ); " //Leiwei on Sept 26, 2006
IF gs_dbtype = "SQL" THEN
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 2076, 33, 290, 'Global Search', 2 ); "// Added by Davis 11.06.2006
END IF
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 2078, 33, 290, 'Delete Contract', 2 ); "// Added by Davis 01.31.2007

lds_roles = create n_ds
lds_roles.dataobject = "d_roles"
lds_roles.SetTransObject( SQLCA )

lds_rolerights = CREATE n_ds
ls_sql = "select security_roles_rights.role_id, security_roles_rights.action_id from security_roles_rights "
ls_new_syntax = SQLCA.SyntaxFromSQL( ls_sql, "", ls_error )
lds_rolerights.Create( ls_new_syntax, ls_error )
lds_rolerights.SetTransObject(SQLCA)

gnv_appeondb.of_startQueue()
lds_roles.Retrieve()
lds_rolerights.Retrieve()
SELECT max( rights_id ) INTO :ll_maxid FROM security_roles_rights;
SELECT TOP 1 rights_id INTO :ll_temp FROM ids;
gnv_appeondb.of_CommitQueue()

ll_rows = lds_rolerights.rowcount()
if ll_rows > 0 then
	ll_rows = lds_roles.Rowcount()
	IF ISNULL( ll_maxid ) THEN ll_maxid = 0;
	IF isnull( ll_temp ) THEN ll_temp = 0
	IF ll_temp > ll_maxid THEN ll_maxid = ll_temp;
	
	For i = 1 to ll_rows
		ll_roleid = lds_roles.GetItemNumber( i, "role_id" )		
		ll_found = lds_rolerights.Find( "role_id = " + string( ll_roleid ) + " and action_id = 5200", 1, lds_rolerights.rowcount() )
		if ll_found < 1 then
			ll_maxid++;
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert security_roles_rights( rights_id, role_id, action_id, value_id ) values( " + string( ll_maxid ) + ", " + string( ll_roleid ) + ",5200,2 ); "
		end if		
		ll_found = lds_rolerights.Find( "role_id = " + string( ll_roleid ) + " and action_id = 5210", 1, lds_rolerights.rowcount() )
		if ll_found < 1 then
			ll_maxid++;
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert security_roles_rights( rights_id, role_id, action_id, value_id ) values( " + string( ll_maxid ) + ", " + string( ll_roleid ) + ",5210,2 ); "
		end if
		ll_found = lds_rolerights.Find( "role_id = " + string( ll_roleid ) + " and action_id = 5300", 1, lds_rolerights.rowcount() )
		if ll_found < 1 then
			ll_maxid++;
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert security_roles_rights( rights_id, role_id, action_id, value_id ) values( " + string( ll_maxid ) + ", " + string( ll_roleid ) + ",5300,2 ); "
		end if
		ll_found = lds_rolerights.Find( "role_id = " + string( ll_roleid ) + " and action_id = 5310", 1, lds_rolerights.rowcount() )
		if ll_found < 1 then
			ll_maxid++;
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert security_roles_rights( rights_id, role_id, action_id, value_id ) values( " + string( ll_maxid ) + ", " + string( ll_roleid ) + ",5310,2 ); "
		end if
		ll_found = lds_rolerights.Find( "role_id = " + string( ll_roleid ) + " and action_id = 5320", 1, lds_rolerights.rowcount() )
		if ll_found < 1 then	
			ll_maxid++;
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert security_roles_rights( rights_id, role_id, action_id, value_id ) values( " + string( ll_maxid ) + ", " + string( ll_roleid ) + ",5320,2 ); "
		end if
		ll_found = lds_rolerights.Find( "role_id = " + string( ll_roleid ) + " and action_id = 5330", 1, lds_rolerights.rowcount() )
		if ll_found < 1 then	
			ll_maxid++;
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert security_roles_rights( rights_id, role_id, action_id, value_id ) values( " + string( ll_maxid ) + ", " + string( ll_roleid ) + ",5330,2 ); "
		end if
		ll_found = lds_rolerights.Find( "role_id = " + string( ll_roleid ) + " and action_id = 5400", 1, lds_rolerights.rowcount() )
		if ll_found < 1 then	
			ll_maxid++;
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert security_roles_rights( rights_id, role_id, action_id, value_id ) values( " + string( ll_maxid ) + ", " + string( ll_roleid ) + ",5400,2 ); "
		end if
		ll_found = lds_rolerights.Find( "role_id = " + string( ll_roleid ) + " and action_id = 5500", 1, lds_rolerights.rowcount() )
		if ll_found < 1 then	
			ll_maxid++;
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert security_roles_rights( rights_id, role_id, action_id, value_id ) values( " + string( ll_maxid ) + ", " + string( ll_roleid ) + ",5500,2 ); "
		end if		
		ll_found = lds_rolerights.Find( "role_id = " + string( ll_roleid ) + " and action_id = 5510", 1, lds_rolerights.rowcount() )
		if ll_found < 1 then	
			ll_maxid++;
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert security_roles_rights( rights_id, role_id, action_id, value_id ) values( " + string( ll_maxid ) + ", " + string( ll_roleid ) + ",5510,2 ); "
		end if
		ll_found = lds_rolerights.Find( "role_id = " + string( ll_roleid ) + " and action_id = 5600", 1, lds_rolerights.rowcount() )
		if ll_found < 1 then	
			ll_maxid++;
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert security_roles_rights( rights_id, role_id, action_id, value_id ) values( " + string( ll_maxid ) + ", " + string( ll_roleid ) + ",5600,2 ); "
		end if
		ll_found = lds_rolerights.Find( "role_id = " + string( ll_roleid ) + " and action_id = 5700", 1, lds_rolerights.rowcount() )
		if ll_found < 1 then	
			ll_maxid++;
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert security_roles_rights( rights_id, role_id, action_id, value_id ) values( " + string( ll_maxid ) + ", " + string( ll_roleid ) + ",5700,2 ); "
		end if
		ll_found = lds_rolerights.Find( "role_id = " + string( ll_roleid ) + " and action_id = 5800", 1, lds_rolerights.rowcount() )
		if ll_found < 1 then	
			ll_maxid++;
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert security_roles_rights( rights_id, role_id, action_id, value_id ) values( " + string( ll_maxid ) + ", " + string( ll_roleid ) + ",5800,2 ); "
		end if
		ll_found = lds_rolerights.Find( "role_id = " + string( ll_roleid ) + " and action_id = 5810", 1, lds_rolerights.rowcount() )
		if ll_found < 1 then	
			ll_maxid++;
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert security_roles_rights( rights_id, role_id, action_id, value_id ) values( " + string( ll_maxid ) + ", " + string( ll_roleid ) + ",5810,2 ); "
		end if
		ll_found = lds_rolerights.Find( "role_id = " + string( ll_roleid ) + " and action_id = 2220", 1, lds_rolerights.rowcount() )
		if ll_found < 1 then	
			ll_maxid++;
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert security_roles_rights( rights_id, role_id, action_id, value_id ) values( " + string( ll_maxid ) + ", " + string( ll_roleid ) + ",2220,2 ); "
		end if	
		//Leiwei on Sept 26, 2006
		ll_found = lds_rolerights.Find( "role_id = " + string( ll_roleid ) + " and action_id = 2075", 1, lds_rolerights.rowcount() )
		if ll_found < 1 then	
			ll_maxid++;
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert security_roles_rights( rights_id, role_id, action_id, value_id ) values( " + string( ll_maxid ) + ", " + string( ll_roleid ) + ",2075,2 ); "
		end if
		// Added by Davis 11.06.2006
		IF gs_dbtype = "SQL" THEN
			ll_found = lds_rolerights.Find( "role_id = " + string( ll_roleid ) + " and action_id = 2076", 1, lds_rolerights.rowcount() )
			if ll_found < 1 then	
				ll_maxid++;
				ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert security_roles_rights( rights_id, role_id, action_id, value_id ) values( " + string( ll_maxid ) + ", " + string( ll_roleid ) + ",2076,2 ); "
			end if
		END IF
		// Added by Davis 01.31.2007
		ll_found = lds_rolerights.Find( "role_id = " + string( ll_roleid ) + " and action_id = 2078", 1, lds_rolerights.rowcount() )
		if ll_found < 1 then	
			ll_maxid++;
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert security_roles_rights( rights_id, role_id, action_id, value_id ) values( " + string( ll_maxid ) + ", " + string( ll_roleid ) + ",2078,2 ); "
		end if
	Next
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 01.27.2007 By: Jack (Document Manager)
	//$<reason> Fix a defect.
	//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE ids SET rights_id = :ll_maxid;"	
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE ids SET rights_id = " + string( ll_maxid ) + "; "	//Rodger Wu modified.
	//---------------------------- APPEON END ----------------------------
end if

Destroy( lds_roles );
Destroy( lds_rolerights )

//for filter code lookup
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Create Table sys_lookup (lookup_name varchar(35) NOT NULL ,PRIMARY KEY (lookup_name)); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'(NONE)'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'A&O'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Academic Departments'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Academic Titles/Duties'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Action Department'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Action Status'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Action Type'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Address Status'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Administrative Positions'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Administrative Responsibilities'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Affiliation Ended Reason'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Affiliation Status'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'After Hours Type'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Approval Code'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Attendence Status'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Board Status'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'CAQH License Status'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Case/Peer Review Action Item Status'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Case/Peer Review Action Item To'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Case/Peer Review Action Item Type'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Case/Peer Review Committee Action'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Case/Peer Review Reason'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Case/Peer Review Severity Grade'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Case/Peer Review Status'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Cert Type'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Claim Defendant'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Claim Judgement'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Claim Resolution Method'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Clinical Specialties'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'CME Category'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Committee'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Contingency Status'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Controlled Substance Categories'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Coverage Type'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'CPR Type'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Credentials Verification Response'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Department'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Department/Section Rank'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Division'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Education Degrees'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Education Type'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Faculty Ranks'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Fellowship Types'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Gap Reason'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Gap Type'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Graduate Type'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Institution Types'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Insurance Share Type'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Internship Types'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'License Types'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Measurement Reason'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Medical Record Suspension Reason'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Meeting Location'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Meeting Type'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Nature of Function'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Not Cert Reason'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'OIG Sanctions'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Partner Covering'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Percentage'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Plan Category'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Plan Type'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Practice Type'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Practitioner Category'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Practitioner Specialties'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Preferred Contact Method'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Privilege Status'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Process Status'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Professional Association'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Proof of Identity Docs'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Provider Types'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Rank'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Reason for Leave of Absence'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Reason for Temp Privilieges'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Reasons for Ending Affiliation'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Reasons for Sanctions'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Reference Type'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Required Data Status'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Sanction Status/Activity'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Sanction/Action'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Sanctions'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Section'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Special Certifications'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Specialty Order'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Staff Category'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Status of Claim'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Sub Group Plan'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Tax Id Preferred'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Tier'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Training Type'); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_lookup( lookup_name ) VALUES (	'Verification Method'); "

//Create View of v_ctx_basic_without_products. Rodger Wu on Sept 4, 2006
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 05.16.2007 By: Frank.Gui
//$<reason> Droping and creating view will change id of this view and will make IntelliReport failed.
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "DROP view v_ctx_basic_without_products; "
//---------------------------- APPEON END ----------------------------

ls_sql = of_get_view_action( 'v_ctx_basic_without_products') +" as " + &
"SELECT CTX_BASIC_INFO.ctx_id, " + &
"       app_facility.facility_name,  " + &
"       code_lookup.code AS Contract_Category_code, " + &
"       code_lookup.description AS Contract_Category_description, " + &
"       code_lookup_1.code AS Contract_Status_code, " + &
"       code_lookup_2.code AS contract_type_code, " + &
"       code_lookup_2.description AS contract_type_Description, " + &
"       CTX_BASIC_INFO.effective_date, " + &
"       CTX_BASIC_INFO.expriation_date, " + &
"       CTX_BASIC_INFO.review_date, " + &
"       CTX_BASIC_INFO.review_by, " + &
"       CTX_BASIC_INFO.term_date, " + &
"       code_lookup_3.code AS term_reason_code, " + &
"       code_lookup_3.description AS term_Reason_Desciption, " + &
"       CTX_BASIC_INFO.other_date_1, " + &
"       CTX_BASIC_INFO.other_date_2, " + &
"       CTX_BASIC_INFO.notes, " + &
"       CTX_BASIC_INFO.custom_1, " + &
"       CTX_BASIC_INFO.custom_2, " + &
"       CTX_BASIC_INFO.custom_3, " + &
"       CTX_BASIC_INFO.custom_4, " + &
"       CTX_BASIC_INFO.custom_5, " + &
"       CTX_BASIC_INFO.custom_6, " + &
"       CTX_BASIC_INFO.custom_7, " + &
"       CTX_BASIC_INFO.custom_8, " + &
"       CTX_BASIC_INFO.custom_9, " + &
"       CTX_BASIC_INFO.custom_10, " + &
"       CTX_BASIC_INFO.last_revis_date " + &
"       FROM ((((CTX_BASIC_INFO " + &
"                        LEFT OUTER JOIN code_lookup ON CTX_BASIC_INFO.category = code_lookup.lookup_code) " + &
"                        LEFT OUTER JOIN code_lookup AS code_lookup_1 ON CTX_BASIC_INFO.status = code_lookup_1.lookup_code) " + &
"                        LEFT OUTER JOIN code_lookup AS code_lookup_2 ON CTX_BASIC_INFO.contract_type = code_lookup_2.lookup_code) " + &
"                        LEFT OUTER JOIN code_lookup AS code_lookup_3 ON CTX_BASIC_INFO.term_reason = code_lookup_3.lookup_code) " + &
"                        INNER JOIN app_facility ON CTX_BASIC_INFO.app_facility = app_facility.facility_id" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql 

//Create View of ctx_basic_products. Rodger Wu on Sept 4, 2006
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 05.16.2007 By: Frank.Gui
//$<reason> Droping and creating view will change id of this view and will make IntelliReport failed.
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "DROP view v_ctx_basic_products; "
//---------------------------- APPEON END ----------------------------

ls_sql = of_get_view_action( 'v_ctx_basic_products') +" as " + &
"SELECT ctx_products.ctx_id, " + &
"       code_lookup_4.description AS product_type_desc, " + &
"       code_lookup_4.code AS product_type_code, " + &
"       code_lookup_5.code AS product_code, " + &
"       code_lookup_5.description AS product_description " + &
"FROM (ctx_products LEFT OUTER JOIN code_lookup AS code_lookup_4 ON ctx_products.product_type = code_lookup_4.lookup_code) " + &
"                   LEFT OUTER JOIN code_lookup AS code_lookup_5 ON ctx_products.product_id = code_lookup_5.lookup_code" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql 

//Add 12 fields to ctx_fee_sched_data. Rodger Wu on Sept 4, 2006
IF gs_dbtype = "ASA" THEN
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "ALTER TABLE ctx_fee_sched_data ADD drg_code CHAR(10) null; "
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "ALTER TABLE ctx_fee_sched_data ADD rev_code CHAR(10) null; "
ELSE
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "ALTER TABLE ctx_fee_sched_data ADD drg_code VARCHAR(10) null; "
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "ALTER TABLE ctx_fee_sched_data ADD rev_code VARCHAR(10) null; "
END IF
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "ALTER TABLE ctx_fee_sched_data ADD claim_type NUMERIC(8,0) null; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "ALTER TABLE ctx_fee_sched_data ADD flat_fee NUMERIC(10,2) null; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "ALTER TABLE ctx_fee_sched_data ADD cpt_code_set NUMERIC(8,0) null; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "ALTER TABLE ctx_fee_sched_data ADD reimburse_type NUMERIC(8,0) null; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "ALTER TABLE ctx_fee_sched_data ADD disc_start_perc NUMERIC(3,0) null; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "ALTER TABLE ctx_fee_sched_data ADD end_day INTEGER null; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "ALTER TABLE ctx_fee_sched_data ADD carve_out_day INTEGER null; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "ALTER TABLE ctx_fee_sched_data ADD sl_threshold NUMERIC(10,2) null; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "ALTER TABLE ctx_fee_sched_data ADD sl_reimburse_type NUMERIC(8,0) null; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "ALTER TABLE ctx_fee_sched_data ADD sl_rate NUMERIC(10,2) null; "

//-------------Begin Added by Alfee 09.11.2007-------------------------------------------------------------------
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "ALTER TABLE ctx_notification ADD alm_action_title VARCHAR(40) NULL;"
//-------------End Added ----------------------------------------------------------------------------------------
//-------------Begin Added by Alfee 07.27.2007-------------------------------------------------------------------
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "ALTER TABLE ctx_notification ADD alm_auto_increment_years INTEGER NULL;"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "ALTER TABLE ctx_action_items ADD alm_table VARCHAR(40) NULL;"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "ALTER TABLE ctx_action_items ADD alm_column VARCHAR(40) NULL;"
//-------------End Added ----------------------------------------------------------------------------------------

//-------------Begin Added by Alfee 09.27.2007-------------------------------------------------------------------
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE code_lookup SET custom_1 = 'YES' WHERE lookup_name = 'Contract Status' AND IsNull(custom_1,'') NOT IN ('YES','NO');"
//-------------End Added ----------------------------------------------------------------------------------------

lds_codelookup = CREATE n_ds
lds_codelookup.DataObject = "dd_code_lookup_forupdate"
lds_codelookup.SetTransObject( SQLCA )

gnv_appeondb.of_startqueue()
lds_codelookup.Retrieve()
SELECT Max( lookup_code ) INTO :ll_maxid FROM code_lookup; 
SELECT TOP 1 lookup_code_id INTO :ll_temp FROM ids;
gnv_appeondb.of_commitqueue()

ll_rows = lds_codelookup.rowcount()
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 05.09.2007 By: Jack
//$<reason> Fix a defect.
/*
if ll_rows >= 0 then
*/
if ll_rows > 0 then
//---------------------------- APPEON END ----------------------------
	IF isnull( ll_maxid ) THEN ll_maxid = 0
	IF isnull( ll_temp ) THEN ll_temp = 0
	IF ll_temp > ll_maxid THEN ll_maxid = ll_temp
	
	//Add a lookup called Contract Claim Type. Rodger Wu on Sept 6, 2006
	ll_found = lds_codelookup.Find( "upper(lookup_name) = upper('Contract Claim Type') and upper(code) = upper('ER')", 1, ll_rows )
	if ll_found = 0 then
		ll_maxid ++
		ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type ) VALUES ( " + string( ll_maxid ) + ", 'Contract Claim Type', 'ER', 'Emergency Room', 'C');"
	end if	
	ll_found = lds_codelookup.Find( "upper(lookup_name) = upper('Contract Claim Type') and upper(code) = upper('Amb Surg')", 1, ll_rows )
	if ll_found = 0 then
		ll_maxid ++
		ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type ) VALUES ( " + string( ll_maxid ) + ", 'Contract Claim Type', 'Amb Surg', 'Ambulatory Surgery', 'C');"
	end if	
	//Add a lookup called Contract CPT Code Set. Rodger Wu on Sept 6, 2006
	ll_found = lds_codelookup.Find( "upper(lookup_name) = upper('Contract CPT Code Set') and upper(code) = upper('ASC GRP 1')", 1, ll_rows )
	if ll_found = 0 then
		ll_maxid ++
		ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type ) VALUES ( " + string( ll_maxid ) + ", 'Contract CPT Code Set', 'ASC GRP 1',	'Group 1', 'C');"
	end if	
	ll_found = lds_codelookup.Find( "upper(lookup_name) = upper('Contract CPT Code Set') and upper(code) = upper('ASC GRP 2')", 1, ll_rows )
	if ll_found = 0 then
		ll_maxid ++
		ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type ) VALUES ( " + string( ll_maxid ) + ", 'Contract CPT Code Set', 'ASC GRP 2', 'Group 2', 'C');"
	end if
	//Add a lookup called Contract Reimburse Type. Rodger Wu on Sept 6, 2006
	ll_found = lds_codelookup.Find( "upper(lookup_name) = upper('Contract Reimburse Type') and upper(code) = upper('DRG')", 1, ll_rows )
	if ll_found = 0 then
		ll_maxid ++
		ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type ) VALUES ( " + string( ll_maxid ) + ", 'Contract Reimburse Type', 'DRG', 'DRG', 'C');"
	end if	
	ll_found = lds_codelookup.Find( "upper(lookup_name) = upper('Contract Reimburse Type') and upper(code) = upper('Case Rate')", 1, ll_rows )
	if ll_found = 0 then
		ll_maxid ++
		ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type ) VALUES ( " + string( ll_maxid ) + ", 'Contract Reimburse Type', 'Case Rate', 'Case Rate', 'C');"
	end if	
	ll_found = lds_codelookup.Find( "upper(lookup_name) = upper('Contract Reimburse Type') and upper(code) = upper('Discount')", 1, ll_rows )
	if ll_found = 0 then
		ll_maxid ++
		ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type ) VALUES ( " + string( ll_maxid ) + ", 'Contract Reimburse Type', 'Discount', 'Discount', 'C');"
	end if
	//Add a lookup called Contract Stop Loss Reimburse Type. Rodger Wu on Sept 6, 2006
	ll_found = lds_codelookup.Find( "upper(lookup_name) = upper('Contract Stop Loss Reimburse Type') and upper(code) = upper('Per Diem')", 1, ll_rows )
	if ll_found = 0 then
		ll_maxid ++
		ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type ) VALUES ( " + string( ll_maxid ) + ", 'Contract Stop Loss Reimburse Type', 'Per Diem', 'Per Diem', 'C');"
	end if	
	ll_found = lds_codelookup.Find( "upper(lookup_name) = upper('Contract Stop Loss Reimburse Type') and upper(code) = upper('Other')", 1, ll_rows )
	if ll_found = 0 then
		ll_maxid ++
		ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type ) VALUES ( " + string( ll_maxid ) + ", 'Contract Stop Loss Reimburse Type', 'Other', 'Other reimbursement type', 'C');"
	end if
	//Leiwei on Sept 21, 2006
	ll_found = lds_codelookup.Find( "upper(lookup_name) = upper('Contract Action Status') and upper(code) = upper('Incomplete')", 1, ll_rows )
	if ll_found = 0 then
		ll_maxid ++
		ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type ) VALUES ( " + string( ll_maxid ) + ", 'Contract Action Status', 'Incomplete', 'Incomplete', 'S');"
	end if	
	ll_found = lds_codelookup.Find( "upper(lookup_name) = upper('Contract Action Status') and upper(code) = upper('Complete')", 1, ll_rows )
	if ll_found = 0 then
		ll_maxid ++
		ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type) VALUES (" + string( ll_maxid ) +  ",'Contract Action Status' ,'Complete','The action has been completed','S') ;"
	end if
	//Leiwei on Oct. 17, 2006
	ll_found = lds_codelookup.Find( "upper(lookup_name) = upper('Contract Product Name') and upper(code) = upper('Prod 1')", 1, ll_rows )
	if ll_found = 0 then
		ll_maxid ++
		ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type ) VALUES ( " + string( ll_maxid ) + ", 'Contract Product Name', 'Prod 1', 'Product 1', 'S');"
	end if	
	//Add three new items for 'Contract Action Status', Rodger Wu on Jan. 19, 2007
	ll_found = lds_codelookup.Find( "upper(lookup_name) = upper('Contract Action Status') and upper(code) = upper('Approved')", 1, ll_rows )
	if ll_found = 0 then
		ll_maxid ++
		ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type ) VALUES ( " + string( ll_maxid ) + ", 'Contract Action Status', 'Approved', 'Approved', 'C');"
	end if
	ll_found = lds_codelookup.Find( "upper(lookup_name) = upper('Contract Action Status') and upper(code) = upper('Pending')", 1, ll_rows )
	if ll_found = 0 then
		ll_maxid ++
		ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type ) VALUES ( " + string( ll_maxid ) + ", 'Contract Action Status', 'Pending', 'Pending', 'C');"
	end if
	ll_found = lds_codelookup.Find( "upper(lookup_name) = upper('Contract Action Status') and upper(code) = upper('Reject')", 1, ll_rows )
	if ll_found = 0 then
		ll_maxid ++
		ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type ) VALUES ( " + string( ll_maxid ) + ", 'Contract Action Status', 'Reject', 'Reject', 'C');"
	end if
	
  //Add by Jack 21.08.2007
	ll_found = lds_codelookup.Find( "upper(lookup_name) = upper('Contract Action Status') and upper(code) = upper('Complete')", 1, ll_rows )
	if ll_found = 0 then
		ll_maxid ++
		ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type ) VALUES ( " + string( ll_maxid ) + ", 'Contract Action Status', 'Complete', 'Complete', 'C');"
	end if
  //End Add by Jack 21.08.2007
			
	//Add three new items for 'Contract Action Type', Rodger Wu on Jan. 19, 2007
	ll_found = lds_codelookup.Find( "upper(lookup_name) = upper('Contract Action Type') and upper(code) = upper('LegalApproval')", 1, ll_rows )
	if ll_found = 0 then
		ll_maxid ++
		ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type ) VALUES ( " + string( ll_maxid ) + ", 'Contract Action Type', 'LegalApproval', 'LegalApproval', 'C');"
	end if
	ll_found = lds_codelookup.Find( "upper(lookup_name) = upper('Contract Action Type') and upper(code) = upper('MGRApproval')", 1, ll_rows )
	if ll_found = 0 then
		ll_maxid ++
		ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type ) VALUES ( " + string( ll_maxid ) + ", 'Contract Action Type', 'MGRApproval', 'MGRApproval', 'C');"
	end if
	ll_found = lds_codelookup.Find( "upper(lookup_name) = upper('Contract Action Type') and upper(code) = upper('CustApproval')", 1, ll_rows )
	if ll_found = 0 then
		ll_maxid ++
		ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type ) VALUES ( " + string( ll_maxid ) + ", 'Contract Action Type', 'CustApproval', 'CustApproval', 'C');"
	end if
  //Add by Jack 21.08.2007
  	ll_found = lds_codelookup.Find( "upper(lookup_name) = upper('Contract Action Type') and upper(code) = upper('Email')", 1, ll_rows )
	if ll_found = 0 then
		ll_maxid ++
		ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type ) VALUES ( " + string( ll_maxid ) + ", 'Contract Action Type', 'Email', 'Email', 'C');"
	end if
  //End Add by Jack 21.08.2007
	
	ll_found = lds_codelookup.Find( "upper(lookup_name) = upper('Contract Document Category')", 1, ll_rows )  // Add by Jack 05/09/2007
	If ll_found > 0 Then   // Add by Jack 05/09/2007
	//Add 14 new items for 'Contract Category', Rodger Wu on Jan. 19, 2007
		ll_found = lds_codelookup.Find( "upper(lookup_name) = upper('Contract Category') and upper(code) = upper('Contract')", 1, ll_rows )
		if ll_found = 0 then
			ll_found = lds_codelookup.Find( "upper(lookup_name) = upper('Contract Document Category') and upper(code) = upper('Contract')", 1, ll_rows )
			if ll_found > 0 then
				ll_lookupcode = lds_codelookup.GetItemNumber( ll_found, "lookup_code" )
				ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE code_lookup SET lookup_name = 'Contract Category', ic_n = 1001 WHERE lookup_code = " + string( ll_lookupcode ) + " AND lookup_name = 'Contract Document Category'; "
			else
				ll_maxid ++
				ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type, ic_n ) VALUES ( " + string( ll_maxid ) + ", 'Contract Category', 'Contract', 'Contract', 'C', 1001 );"
			end if
		end if
		
		ll_found = lds_codelookup.Find( "upper(lookup_name) = upper('Contract Category') and upper(code) = upper('Addendum')", 1, ll_rows )
		if ll_found = 0 then
			ll_found = lds_codelookup.Find( "upper(lookup_name) = upper('Contract Document Category') and upper(code) = upper('Addendum')", 1, ll_rows )
			if ll_found > 0 then
				ll_lookupcode = lds_codelookup.GetItemNumber( ll_found, "lookup_code" )
				ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE code_lookup SET lookup_name = 'Contract Category', ic_n = 1001 WHERE lookup_code = " + string( ll_lookupcode ) + " AND lookup_name = 'Contract Document Category'; "
			else
				ll_maxid ++
				ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type, ic_n ) VALUES ( " + string( ll_maxid ) + ", 'Contract Category', 'Addendum', 'Addendum', 'C', 1001 );"
			end if
		end if
		
		ll_found = lds_codelookup.Find( "upper(lookup_name) = upper('Contract Category') and upper(code) = upper('Schedule')", 1, ll_rows )
		if ll_found = 0 then
			ll_found = lds_codelookup.Find( "upper(lookup_name) = upper('Contract Document Category') and upper(code) = upper('Schedule')", 1, ll_rows )
			if ll_found > 0 then
				ll_lookupcode = lds_codelookup.GetItemNumber( ll_found, "lookup_code" )
				ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE code_lookup SET lookup_name = 'Contract Category', ic_n = 1001 WHERE lookup_code = " + string( ll_lookupcode ) + " AND lookup_name = 'Contract Document Category'; "
			else
				ll_maxid ++
				ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type, ic_n ) VALUES ( " + string( ll_maxid ) + ", 'Contract Category', 'Schedule', 'Schedule', 'C', 1001 );"
			end if
		end if
		
		ll_found = lds_codelookup.Find( "upper(lookup_name) = upper('Contract Category') and upper(code) = upper('Software')", 1, ll_rows )
		if ll_found = 0 then
			ll_found = lds_codelookup.Find( "upper(lookup_name) = upper('Contract Document Category') and upper(code) = upper('Software')", 1, ll_rows )
			if ll_found > 0 then
				ll_lookupcode = lds_codelookup.GetItemNumber( ll_found, "lookup_code" )
				ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE code_lookup SET lookup_name = 'Contract Category', ic_n = 1001  WHERE lookup_code = " + string( ll_lookupcode ) + " AND lookup_name = 'Contract Document Category'; "
			else
				ll_maxid ++
				ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type, ic_n ) VALUES ( " + string( ll_maxid ) + ", 'Contract Category', 'Software', 'Software', 'C', 1001 );"
			end if
		end if
		
		ll_found = lds_codelookup.Find( "upper(lookup_name) = upper('Contract Category') and upper(code) = upper('Maintenance')", 1, ll_rows )
		if ll_found = 0 then
			ll_found = lds_codelookup.Find( "upper(lookup_name) = upper('Contract Document Category') and upper(code) = upper('Maintenance')", 1, ll_rows )
			if ll_found > 0 then
				ll_lookupcode = lds_codelookup.GetItemNumber( ll_found, "lookup_code" )
				ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE code_lookup SET lookup_name = 'Contract Category', ic_n = 1001  WHERE lookup_code = " + string( ll_lookupcode ) + " AND lookup_name = 'Contract Document Category'; "
			else
				ll_maxid ++
				ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type, ic_n ) VALUES ( " + string( ll_maxid ) + ", 'Contract Category', 'Maintenance', 'Maintenance', 'C', 1001 );"
			end if
		end if
		
		ll_found = lds_codelookup.Find( "upper(lookup_name) = upper('Contract Category') and upper(code) = upper('Payor')", 1, ll_rows )
		if ll_found = 0 then
			ll_found = lds_codelookup.Find( "upper(lookup_name) = upper('Contract Document Category') and upper(code) = upper('Payor')", 1, ll_rows )
			if ll_found > 0 then
				ll_lookupcode = lds_codelookup.GetItemNumber( ll_found, "lookup_code" )
				ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE code_lookup SET lookup_name = 'Contract Category', ic_n = 1001  WHERE lookup_code = " + string( ll_lookupcode ) + " AND lookup_name = 'Contract Document Category'; "
			else
				ll_maxid ++
				ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type, ic_n ) VALUES ( " + string( ll_maxid ) + ", 'Contract Category', 'Payor', 'Payor', 'C', 1001 );"
			end if
		end if
		
		ll_found = lds_codelookup.Find( "upper(lookup_name) = upper('Contract Category') and upper(code) = upper('IT Services')", 1, ll_rows )
		if ll_found = 0 then
			ll_found = lds_codelookup.Find( "upper(lookup_name) = upper('Contract Document Category') and upper(code) = upper('IT Services')", 1, ll_rows )
			if ll_found > 0 then
				ll_lookupcode = lds_codelookup.GetItemNumber( ll_found, "lookup_code" )
				ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE code_lookup SET lookup_name = 'Contract Category', ic_n = 1001 WHERE lookup_code = " + string( ll_lookupcode ) + " AND lookup_name = 'Contract Document Category'; "
			else
				ll_maxid ++
				ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type, ic_n ) VALUES ( " + string( ll_maxid ) + ", 'Contract Category', 'IT Services', 'IT Services', 'C', 1001 );"
			end if
		end if
		
		ll_found = lds_codelookup.Find( "upper(lookup_name) = upper('Contract Category') and upper(code) = upper('Marketing')", 1, ll_rows )
		if ll_found = 0 then
			ll_found = lds_codelookup.Find( "upper(lookup_name) = upper('Contract Document Category') and upper(code) = upper('Marketing')", 1, ll_rows )
			if ll_found > 0 then
				ll_lookupcode = lds_codelookup.GetItemNumber( ll_found, "lookup_code" )
				ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE code_lookup SET lookup_name = 'Contract Category', ic_n = 1001 WHERE lookup_code = " + string( ll_lookupcode ) + " AND lookup_name = 'Contract Document Category'; "
			else
				ll_maxid ++
				ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type, ic_n ) VALUES ( " + string( ll_maxid ) + ", 'Contract Category', 'Marketing', 'Marketing', 'C', 1001 );"
			end if
		end if
		
		ll_found = lds_codelookup.Find( "upper(lookup_name) = upper('Contract Category') and upper(code) = upper('Office Lease')", 1, ll_rows )
		if ll_found = 0 then
			ll_found = lds_codelookup.Find( "upper(lookup_name) = upper('Contract Document Category') and upper(code) = upper('Office Lease')", 1, ll_rows )
			if ll_found > 0 then
				ll_lookupcode = lds_codelookup.GetItemNumber( ll_found, "lookup_code" )
				ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE code_lookup SET lookup_name = 'Contract Category', ic_n = 1001 WHERE lookup_code = " + string( ll_lookupcode ) + " AND lookup_name = 'Contract Document Category'; "
			else
				ll_maxid ++
				ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type, ic_n ) VALUES ( " + string( ll_maxid ) + ", 'Contract Category', 'Office Lease', 'Office Lease', 'C', 1001 );"
			end if
		end if
		
		ll_found = lds_codelookup.Find( "upper(lookup_name) = upper('Contract Category') and upper(code) = upper('Equipment Lease')", 1, ll_rows )
		if ll_found = 0 then
			ll_found = lds_codelookup.Find( "upper(lookup_name) = upper('Contract Document Category') and upper(code) = upper('Equipment Lease')", 1, ll_rows )
			if ll_found > 0 then
				ll_lookupcode = lds_codelookup.GetItemNumber( ll_found, "lookup_code" )
				ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE code_lookup SET lookup_name = 'Contract Category', ic_n = 1001 WHERE lookup_code = " + string( ll_lookupcode ) + " AND lookup_name = 'Contract Document Category'; "
			else
				ll_maxid ++
				ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type, ic_n ) VALUES ( " + string( ll_maxid ) + ", 'Contract Category', 'Equipment Lease', 'Equipment Lease', 'C', 1001 );"
			end if
		end if
		
		ll_found = lds_codelookup.Find( "upper(lookup_name) = upper('Contract Category') and upper(code) = upper('Other')", 1, ll_rows )
		if ll_found = 0 then
			ll_found = lds_codelookup.Find( "upper(lookup_name) = upper('Contract Document Category') and upper(code) = upper('Other')", 1, ll_rows )
			if ll_found > 0 then
				ll_lookupcode = lds_codelookup.GetItemNumber( ll_found, "lookup_code" )
				ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE code_lookup SET lookup_name = 'Contract Category', ic_n = 1001 WHERE lookup_code = " + string( ll_lookupcode ) + " AND lookup_name = 'Contract Document Category'; "
			else
				ll_maxid ++
				ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type, ic_n ) VALUES ( " + string( ll_maxid ) + ", 'Contract Category', 'Other', 'Other', 'C', 1001 );"
			end if
		end if
	
		ll_found = lds_codelookup.Find( "upper(lookup_name) = upper('Contract Category') and upper(code) = upper('Hardware Requir')", 1, ll_rows )
		if ll_found = 0 then
			ll_found = lds_codelookup.Find( "upper(lookup_name) = upper('Contract Document Category') and upper(code) = upper('Hardware Requir')", 1, ll_rows )
			if ll_found > 0 then
				ll_lookupcode = lds_codelookup.GetItemNumber( ll_found, "lookup_code" )
				ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE code_lookup SET lookup_name = 'Contract Category', ic_n = 1001 WHERE lookup_code = " + string( ll_lookupcode ) + " AND lookup_name = 'Contract Document Category'; "
			else
				ll_maxid ++
				ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type, ic_n ) VALUES ( " + string( ll_maxid ) + ", 'Contract Category', 'Hardware Requir', 'Hardware Requirement', 'C', 1001 );"
			end if
		end if
	
		ll_found = lds_codelookup.Find( "upper(lookup_name) = upper('Contract Category') and upper(code) = upper('Business Agreem')", 1, ll_rows )
		if ll_found = 0 then
			ll_found = lds_codelookup.Find( "upper(lookup_name) = upper('Contract Document Category') and upper(code) = upper('Business Agreem')", 1, ll_rows )
			if ll_found > 0 then
				ll_lookupcode = lds_codelookup.GetItemNumber( ll_found, "lookup_code" )
				ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE code_lookup SET lookup_name = 'Contract Category', ic_n = 1001 WHERE lookup_code = " + string( ll_lookupcode ) + " AND lookup_name = 'Contract Document Category'; "
			else
				ll_maxid ++
				ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type, ic_n ) VALUES ( " + string( ll_maxid ) + ", 'Contract Category', 'Business Agreem', 'Business Agreement', 'C', 1001 );"
			end if
		end if
	
		ll_found = lds_codelookup.Find( "upper(lookup_name) = upper('Contract Category') and upper(code) = upper('Sales Agreement')", 1, ll_rows )
		if ll_found = 0 then
			ll_found = lds_codelookup.Find( "upper(lookup_name) = upper('Contract Document Category') and upper(code) = upper('Sales Agreement')", 1, ll_rows )
			if ll_found > 0 then
				ll_lookupcode = lds_codelookup.GetItemNumber( ll_found, "lookup_code" )
				ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE code_lookup SET lookup_name = 'Contract Category', ic_n = 1001 WHERE lookup_code = " + string( ll_lookupcode ) + " AND lookup_name = 'Contract Document Category'; "
			else
				ll_maxid ++
				ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type, ic_n ) VALUES ( " + string( ll_maxid ) + ", 'Contract Category', 'Sales Agreement', 'Sales Agreement', 'C', 1001 );"
			end if
		end if
	End If   // Add by Jack 05/09/2007
	
	//Update the id counter of lookup_code. Rodger Wu on Sept 6, 2006
	//ll_maxid ++
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE ids SET lookup_code_id = " + string( ll_maxid ) + "; "
end if
DESTROY lds_codelookup;

//Add the following function because of maximum script size exceeded in current function. Rodger Wu on Jan. 31, 2007
of_appeon3_changes()

return 0
end function

public subroutine of_appeon2_changes ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_contract_sqlof_asa_6_changes()
// $<arguments>(None)
// $<returns> (none)
// $<description>Contract module modification
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 08.09.2006 by Liang QingShi
//////////////////////////////////////////////////////////////////////
integer i,li_num,li_rowcount,li_row
string ls_tab_name[],ls_screen_name[],ls_dw_name[],ls_dataobject[]
string ls_sql,ls_error_create
datastore lds_sql
datastore lds_source,lds_target,lds_properties

Long ll_count , ll_find
boolean lb_update_falg 
long ll_view_id,ll_screen_id
string ls_dataobject1
datetime ldt_modify_date

lb_update_falg = true
lds_source = create datastore
lds_sql = create datastore
lds_target = create datastore
lds_properties = create datastore

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.18.2007 By: Jack
//$<reason> Fix a defect
//Delete from  ctx_screen where screen_id = 32 and dataobject <> 'd_dm_browse_filter';
update ctx_screen set screen_name = 'Other Contacts' + substring(screen_name,9,100) where screen_id in (14,15,16,17) and substring(screen_name,1,8) = 'Contacts';

lds_source.dataobject = 'd_dm_browse_filter'
lds_source.settransobject(sqlca)
ls_sql = lds_source.Describe("datawindow.syntax")
update ctx_screen set 
	  dw_sql = :ls_sql, 
	  modify_date = getdate(),
	  screen_name = 'Document Manager->Document Tab->Search Criteria',
	  dw_name = 'dw_filter',
	  dataobject = 'd_dm_browse_filter'
where screen_id = 32 and dataobject = 'd_cntx_images';
commit;
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 06/05/2007 By: Jervis
//$<reason> Force update screen 
of_register_screen('d_contract_search',2007-09-01)         //Modify by Jack 07/13/2007
of_register_screen('d_sp_contract_search',2007-09-01)      //Modify by Jack 06/01/2007
of_register_screen('d_contract_det_master',2007-06-01)     //Modify by Jack 06/01/2007
of_register_screen('d_cntx_action_items',2007-09-11) //Modified by alfee 09.11.2007
of_register_screen('d_contract_det_contact_contact_det',2007-04-22)
of_register_screen('d_ctx_schedule_fee_notes',2007-04-22)
of_register_screen('d_contract_group_linked_locations',2007-05-22) //Modify by Jack 05/22/2007
of_register_screen('d_contract_profile_req_questions',2007-04-22)
of_register_screen('d_contract_profile_req2',2007-04-30)
of_register_screen('d_contract_profile_req_existing',2007-04-30)
of_register_screen('d_ctx_schedule_fee_locations',2007-04-30)
of_register_screen('d_dm_doc_ai_detail',2007-08-25) //Add by alfee 08/25/2007
of_register_screen('d_dm_doc_ai_detail_1',2007-08-25) //Add by alfee 08/25/2007
of_appeon_forceupdate_screen()
//---------------------------- APPEON END ----------------------------

lds_properties.dataobject = "d_update_user_datawindow_objlist"
lds_sql.dataobject = 'd_contract_dw_sql_update'
lds_sql.settransobject(sqlca)
lds_sql.retrieve()


ls_tab_name[1] = 'tabpage_search'
ls_tab_name[2] = 'tabpage_search'
ls_tab_name[3] = 'tabpage_details'
ls_tab_name[4] = 'tabpage_details'
ls_tab_name[5] = 'tabpage_details'
ls_tab_name[6] = 'tabpage_details'
ls_tab_name[7] = 'tabpage_details'
ls_tab_name[8] = 'tabpage_details'
ls_tab_name[9] = 'tabpage_details'
ls_tab_name[10] = 'tabpage_details'
ls_tab_name[11] = 'tabpage_requirements'
ls_tab_name[12] = 'tabpage_requirements'
ls_tab_name[13] = 'tabpage_requirements'
ls_tab_name[14] = 'tabpage_contacts'
ls_tab_name[15] = 'tabpage_contacts'
ls_tab_name[16] = 'tabpage_contacts'
ls_tab_name[17] = 'tabpage_contacts'
ls_tab_name[18] = 'tabpage_locations'
ls_tab_name[19] = 'tabpage_locations'
ls_tab_name[20] = 'tabpage_locations'
ls_tab_name[21] = 'tabpage_locations'
ls_tab_name[22] = 'tabpage_orgabizations'
ls_tab_name[23] = 'tabpage_orgabizations'
ls_tab_name[24] = 'tabpage_orgabizations'
ls_tab_name[25] = 'tabpage_orgabizations'
ls_tab_name[26] = 'tabpage_fee_schedules'
ls_tab_name[27] = 'tabpage_fee_schedules'
ls_tab_name[28] = 'tabpage_fee_schedules'
ls_tab_name[29] = 'tabpage_fee_schedules'
ls_tab_name[30] = 'tabpage_fee_schedules'
ls_tab_name[31] = 'tabpage_fee_sched2'
ls_tab_name[32] = 'tabpage_images'
ls_tab_name[33] = 'tabpage_action_items'
ls_tab_name[34] = 'tabpage_qrg'
ls_tab_name[35] = 'tabpage_qrg'
ls_tab_name[36] = 'tabpage_qrg'
ls_tab_name[37] = 'tabpage_qrg'
ls_tab_name[38] = 'tabpage_qrg'
ls_tab_name[39] = 'tabpage_qrg'
ls_tab_name[40] = 'tabpage_qrg'
ls_tab_name[41] = 'tabpage_qrg'
ls_tab_name[42] = 'tabpage_action_items'
ls_tab_name[43] = 'tabpage_details'
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.18.2007 By: Jack
//$<reason> 
ls_tab_name[44] = 'tabpage_images'
ls_tab_name[45] = 'tabpage_images'
ls_tab_name[46] = 'tabpage_images'
ls_tab_name[47] = 'tabpage_images'
ls_tab_name[48] = 'tabpage_images'
ls_tab_name[49] = 'tabpage_images'
//---------------------------- APPEON END ----------------------------

ls_screen_name[1] = 'Search->Search Criteria'
ls_screen_name[2] = 'Search->Contract Browse'
ls_screen_name[3] = 'Details->Contract Detail'
ls_screen_name[4] = 'Details->Products'
ls_screen_name[5] = 'Details->Contract Dates'
ls_screen_name[6] = 'Details->Contracted Company Contact'
ls_screen_name[7] = 'Details->Our Company Contact'
ls_screen_name[8] = 'Details->Notes Tab->Notes'
ls_screen_name[9] = 'Details->Custom Data Tab->Custom Data'
ls_screen_name[10] = 'Details->Audit Trail Tab->Audit Trail'
ls_screen_name[11] = 'Requirements->Profile Selection'
ls_screen_name[12] = 'Requirements->Profile Detail'
ls_screen_name[13] = 'Requirements->Profile Detail'
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.18.2007 By: Jack
//$<reason> Fix a defect.
/*
ls_screen_name[14] = 'Contacts->Contacts List'
ls_screen_name[15] = 'Contacts->Contract Details'
ls_screen_name[16] = 'Contacts->Contract Information'
ls_screen_name[17] = 'Contacts->Contract Notes'
*/
ls_screen_name[14] = 'Other Contacts->Contacts List'
ls_screen_name[15] = 'Other Contacts->Contract Details'
ls_screen_name[16] = 'Other Contacts->Contract Information'
ls_screen_name[17] = 'Other Contacts->Contract Notes'
//---------------------------- APPEON END ----------------------------
ls_screen_name[18] = 'Locations->Parent Organization'
ls_screen_name[19] = 'Locations->Group/Location'
ls_screen_name[20] = 'Locations->Associated Physicians'
ls_screen_name[21] = 'Locations->Specialties'
ls_screen_name[22] = 'Organizations->Organization List'
ls_screen_name[23] = 'Organizations->Address'
ls_screen_name[24] = 'Organizations->Notes'
ls_screen_name[25] = 'Organizations->Organization Contacts'
ls_screen_name[26] = 'Fee Schedules->Browse Tab->Fee Schedules'
ls_screen_name[27] = 'Fee Schedules->Browse Tab->Fee Schedule Locations'
ls_screen_name[28] = 'Fee Schedules->Browse Tab->Fees'
ls_screen_name[29] = 'Fee Schedules->Browse Tab->Providers'
ls_screen_name[30] = 'Fee Schedules->Notes Tab->User Defined data'
ls_screen_name[31] = 'Fee Schedule (NM)->Fee Schedule (Non Healthcare)'
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.18.2007 By: Jack
//$<reason> Fix a defect.
/*
ls_screen_name[32] = 'Supporting Documents->Browse Tab->Scanned Documents'
*/
ls_screen_name[32] = 'Document Manager->Document Tab->Search Criteria'

//---------------------------- APPEON END ----------------------------
ls_screen_name[33] = 'Action Items->Action Item List'
ls_screen_name[34] = 'QRG->Select Data Tab->Report Profiles'
ls_screen_name[35] = 'QRG->Select Data Tab->Basic Information to Include'
ls_screen_name[36] = 'QRG->Select Data Tab->Contract Contact Information to Include'
ls_screen_name[37] = 'QRG->Select Data Tab->Precertifications Requirements'
ls_screen_name[38] = 'QRG->Select Data Tab->Authorizations Requirements'
ls_screen_name[39] = 'QRG->Select Data Tab->Fee Schedule Data to Include'
ls_screen_name[40] = 'QRG->Select Data Tab->Organization Types to Include'
ls_screen_name[41] = 'QRG->Select Data Tab->Requirements to Include'
ls_screen_name[42] = 'Action Items->Action Item Browse'
ls_screen_name[43] = 'Details->Linked Contracts Tab->Linked Contracts'
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.18.2007 By: Jack
//$<reason> Fix a defect.
ls_screen_name[44] = 'Document Manager->Document Tab->Document Browse'
ls_screen_name[45] = 'Document Manager->Work Flow Tab->Search Criteria'
ls_screen_name[46] = 'Document Manager->Work Flow Tab->Action Item Browse'
ls_screen_name[47] = 'Document Manager->Work Flow Tab->Action Item Detail'
ls_screen_name[48] = 'Document Manager->Audit Trail Tab->Search Criteria'
ls_screen_name[49] = 'Document Manager->Audit Trail Tab->Document Browse'

//---------------------------- APPEON END ----------------------------

ls_dw_name[1] = 'dw_search'
ls_dw_name[2] = 'dw_search_det1'
ls_dw_name[3] = 'dw_1'
ls_dw_name[4] = 'dw_products'
ls_dw_name[5] = 'dw_contract_dates'
ls_dw_name[6] = 'dw_ccc'
ls_dw_name[7] = 'dw_occ'
ls_dw_name[8] = 'dw_1'
ls_dw_name[9] = 'dw_1'
ls_dw_name[10] = 'dw_1'
ls_dw_name[11] = 'dw_2'
ls_dw_name[12] = 'dw_req_det'
ls_dw_name[13] = 'dw_req_det'
ls_dw_name[14] = 'dw_search'
ls_dw_name[15] = 'dw_detail'
ls_dw_name[16] = 'dw_phone'
ls_dw_name[17] = 'dw_notes'
ls_dw_name[18] = 'dw_main'
ls_dw_name[19] = 'dw_detail'
ls_dw_name[20] = 'dw_doctors'
ls_dw_name[21] = 'dw_spec'
ls_dw_name[22] = 'dw_search'
ls_dw_name[23] = 'dw_main'
ls_dw_name[24] = 'dw_notes'
ls_dw_name[25] = 'dw_contacts'
ls_dw_name[26] = 'dw_main'
ls_dw_name[27] = 'dw_locations'
ls_dw_name[28] = 'dw_fee_schedule'
ls_dw_name[29] = 'dw_codes'
ls_dw_name[30] = 'dw_1'
ls_dw_name[31] = 'dw_fee_nm'
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.18.2007 By: Jack
//$<reason> Fix a defect.
/*
ls_dw_name[32] = 'dw_1'
*/
ls_dw_name[32] = 'dw_filter'
//---------------------------- APPEON END ----------------------------
ls_dw_name[33] = 'dw_1'
ls_dw_name[34] = 'dw_profile'
ls_dw_name[35] = 'dw_basic_info'
ls_dw_name[36] = 'dw_contact_info'
ls_dw_name[37] = 'dw_precert'
ls_dw_name[38] = 'dw_auth'
ls_dw_name[39] = 'dw_1'
ls_dw_name[40] = 'dw_2'
ls_dw_name[41] = 'dw_requirements'
ls_dw_name[42] = 'dw_1'
ls_dw_name[43] = 'dw_1'
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.18.2007 By: Jack
//$<reason> Fix a defect.
ls_dw_name[44] = 'dw_browse'
ls_dw_name[45] = 'dw_filter'
ls_dw_name[46] = 'dw_browse'
ls_dw_name[47] = 'dw_detail'
ls_dw_name[48] = 'dw_filter'
ls_dw_name[49] = 'dw_browse'

//---------------------------- APPEON END ----------------------------

ls_dataobject[1] = 'd_contract_search'
ls_dataobject[2] = 'd_sp_contract_search'
ls_dataobject[3] = 'd_contract_det_master'
ls_dataobject[4] = 'd_ctx_products'
ls_dataobject[5] = 'd_contract_det_master_2'
ls_dataobject[6] = 'd_contract_det_contact_external'
ls_dataobject[7] = 'd_contract_det_contact_external'
ls_dataobject[8] = 'd_contract_det_notes'
ls_dataobject[9] = 'd_contract_det_custom'
ls_dataobject[10] = 'd_view_audit2_ctx'
ls_dataobject[11] = 'd_profile_header'
ls_dataobject[12] = 'd_contract_profile_req2'
ls_dataobject[13] = 'd_contract_profile_req_existing'
ls_dataobject[14] = 'd_contract_det_contact_contact'
ls_dataobject[15] = 'd_contract_det_contact_contact_det'
ls_dataobject[16] = 'd_contract_det_contact_contact_phone'
ls_dataobject[17] = 'd_contract_det_contact_contact_notes'
ls_dataobject[18] = 'd_contract_multi_group_browse'
ls_dataobject[19] = 'd_contract_group_linked_locations'
ls_dataobject[20] = 'd_contract_group_practitioners_existing'
ls_dataobject[21] = 'd_cntx_location_spec'
ls_dataobject[22] = 'd_org_search2'
ls_dataobject[23] = 'd_org_tabpg'
ls_dataobject[24] = 'd_org_notes'
ls_dataobject[25] = 'd_org_contacts'
ls_dataobject[26] = 'd_ctx_free_sched_hdr'
ls_dataobject[27] = 'd_ctx_schedule_fee_locations'
ls_dataobject[28] = 'd_ctx_schedule_fee_detail'
ls_dataobject[29] = 'd_ctx_schedule_fee_pracs'
ls_dataobject[30] = 'd_ctx_schedule_fee_notes'
ls_dataobject[31] = 'd_contract_fee_sched_nm'
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.18.2007 By: Jack
//$<reason> Fix a defect.
/*
ls_dataobject[32] = 'd_cntx_images'
*/
ls_dataobject[32] = 'd_dm_browse_filter'

//---------------------------- APPEON END ----------------------------
ls_dataobject[33] = 'd_cntx_action_items'
ls_dataobject[34] = 'd_report_hdr'
ls_dataobject[35] = 'd_qrg_sys_fields'
ls_dataobject[36] = 'd_qrg_sys_fields'
ls_dataobject[37] = 'd_profile_codes'
ls_dataobject[38] = 'd_profile_codes'
ls_dataobject[39] = 'd_qrg_sys_fields'
ls_dataobject[40] = 'd_profile_codes'
ls_dataobject[41] = 'd_contract_profile_req_questions'
ls_dataobject[42] = 'd_cntx_action_items_browse'
ls_dataobject[43] = 'd_sp_contract_search'
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.18.2007 By: Jack
//$<reason> Fix a defect.
ls_dataobject[44] = 'd_dm_doc_tree'
ls_dataobject[45] = 'd_dm_ai_filter'
ls_dataobject[46] = 'd_dm_doc_ai_browse'
ls_dataobject[47] = 'd_dm_doc_ai_detail'
ls_dataobject[48] = 'd_dm_audit_filter'
ls_dataobject[49] = 'd_dm_doc_audit_browse'
//---------------------------- APPEON END ----------------------------


li_num = UpperBound(ls_tab_name)
ll_count = lds_sql.rowcount() 
if Not isvalid( w_infodisp ) then open(w_infodisp)
if isvalid(w_infodisp) then w_infodisp.title = 'Update screen of view, Please stand by'
if isvalid(w_infodisp) then w_infodisp.Center = TRUE
if isvalid(w_infodisp) then w_infodisp.st_complete.visible = false
if isvalid(w_infodisp) then w_infodisp.st_3.visible = false
if isvalid(w_infodisp) then w_infodisp.st_information.visible = false
if isvalid(w_infodisp) then w_infodisp.st_1.text = 'Update screen of view, Please stand by!'
if isvalid(w_infodisp) then w_infodisp.wf_set_min_max(1,li_num)
for i = 1 to li_num
	
	if isvalid(w_infodisp) then 
		w_infodisp.wf_step_pbar(1)
		w_infodisp.st_1.text = 'Modification ' + string(i) + ' of ' + string(li_num)+' Please stand by!'
	end if
	
	lds_source.dataobject = ls_dataobject[i]
	lds_source.settransobject(sqlca)
				
	ll_find = lds_sql.find("dataobject = '" + ls_dataobject[i] + "'" + " and screen_name = '" + ls_screen_name[i] + "'", 1 , ll_count)	
	if ll_find > 0 then				
		if lb_update_falg then	//Update All Screen syntax
			do 
				//Update Screen syntax
				ll_view_id = lds_sql.GetItemNumber(ll_find,"data_view_id")
				ll_screen_id = lds_sql.GetItemNumber(ll_find,"screen_id")
				
				IF appeongetclienttype() = 'PB' then
					ls_sql = f_get_screen_sql(ll_view_id,ll_screen_id,false)  //add false argu - jervis 10.11.2011
				else
					ls_sql = lds_sql.GetItemString(ll_find,"dw_sql")
				end if
				
				lds_target.Create(ls_sql, ls_error_create)
				lds_target.SetTransObject(SQLCA)
				lds_properties.Reset()
				
				//--------------------------- APPEON BEGIN ---------------------------
				//$<modify> 08.04.2007 By: Jervis
				//$<reason> 
				/*
				of_getproperties(lds_target,lds_properties)
				
				ls_sql = of_setproperties(lds_source,lds_properties)
				//<add> 07/03/2007 by: Andy 
				//Add objects
				ls_sql = of_addobjects(lds_source,lds_target)
				//end of add
				*/
				ls_sql = of_update_object(lds_target,lds_source,lds_properties)
				//--------------------------- APPEON END ---------------------------
				
				lds_sql.SetItem(ll_find,"dw_sql",ls_sql)
				//lds_sql.setitem(ll_find,'modify_date',today())	APB Bug,need use datetime convert 08.04.2007
				lds_sql.setitem(ll_find,'modify_date',datetime(today(),now()))
				
				if ll_find = ll_count then exit
				ll_find = lds_sql.find("dataobject = '" + ls_dataobject[i] + "'" + " and screen_name = '" + ls_screen_name[i] + "'", ll_find + 1 , ll_count)	
			loop WHILE (ll_find > 0)
		else
			//update sql when update = 1 and version > number of current version
		end if					

		
	Else
		ls_sql = lds_source.Describe("datawindow.syntax")
		li_row = lds_sql.insertrow(0)	
		lds_sql.setitem(li_row,'data_view_id',1001)
		lds_sql.setitem(li_row,'screen_id',i)
		lds_sql.setitem(li_row,'tab_name',ls_tab_name[i])
		lds_sql.setitem(li_row,'screen_name',ls_screen_name[i])
		lds_sql.setitem(li_row,'dw_name',ls_dw_name[i])
		lds_sql.setitem(li_row,'dataobject',ls_dataobject[i])
		lds_sql.setitem(li_row,'dw_sql',ls_sql)
		lds_sql.setitem(li_row,'create_date',datetime(today(),now()))
		lds_sql.setitem(li_row,'modify_date',datetime(today(),now()))
	End if
		
next

If lds_sql.update() <> 1 Then
	ii_num++
	If ii_num < 3 Then
		of_appeon2_changes()
	End If
End If
ii_num = 1
commit;


//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.27.2007 By: Jack
//$<reason> Fix a defect.
delete from ctx_screen where screen_id = 44;
//---------------------------- APPEON END ----------------------------

//$<add> 11.08.2006 By: Davis
//$<reason> Fix a defect.
insert into ctx_screen(data_view_id,screen_id,tab_name,screen_name,dw_name,dataobject,description,dw_sql,create_date,modify_date)
select d.data_view_id,a.screen_id,a.tab_name,screen_name,dw_name,dataobject,description,dw_sql,create_date,modify_date from ctx_screen a,data_view d
where d.type_c = 'C' AND a.data_view_id = 1001 and d.data_view_id <> 1001
and exists(
select 1 from ctx_screen b
where data_view_id <> 1001
and a.tab_name = b.tab_name
and d.data_view_id = b.data_view_id
)
and not exists(
select 1 from ctx_screen c
where c.data_view_id <> 1001
and d.data_view_id = c.data_view_id
and a.screen_id = c.screen_id
and a.tab_name = c.tab_name
);

destroy lds_sql
destroy lds_source
destroy lds_target
destroy lds_properties

//$<add> 11.08.2006 By: Davis
if isvalid( w_infodisp ) then close(w_infodisp)


end subroutine

public function integer of_appeon_sqlserver_update1 ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_contract_sqlof_appeon_sqlserver_update1()
// $<arguments>(None)
// $<returns> integer
// $<description>
// $<description> Create SQL for Sql server Database updates.
//////////////////////////////////////////////////////////////////////
// $<add> 11.14.2006 by Davis
//////////////////////////////////////////////////////////////////////

// Alter table structure
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 23/03/2007 By: Jervis
//$<reason> 
/*
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_action_items alter column notes varchar(255) null"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_BASIC_INFO alter column notes varchar(255) null"
*/
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "exec sp_fulltext_column 'ctx_action_items','notes','drop'"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_action_items alter column notes varchar(2000) null"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "exec sp_fulltext_column 'ctx_action_items','notes','add'"

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "exec sp_fulltext_column 'CTX_BASIC_INFO','notes','drop'"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_BASIC_INFO alter column notes varchar(2000) null"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "exec sp_fulltext_column 'CTX_BASIC_INFO','notes','add'"

//---------------------------- APPEON END ----------------------------

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_BASIC_INFO alter column app_facility numeric(5,0) null"

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_CPT_CODE_ITEM alter column location_price decimal null"

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_CPT_CODES alter column cpt_code_description text null"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_CPT_CODES alter column base_price decimal null"

//Start Change By Jervis 03/20/2007
/*
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_ELEMENTS add clause_bk varchar(255) null"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "update CTX_ELEMENTS set clause_bk = clause"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_ELEMENTS drop column clause"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_ELEMENTS add clause varchar(255) null"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "update CTX_ELEMENTS set clause = clause_bk"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_ELEMENTS drop column clause_bk"
*/

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "exec sp_fulltext_column 'ctx_elements','clause','drop'"
//06/05/2007 By Jervis Form text to varchar(2000) SQL Server Bug
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_ELEMENTS alter column clause text null"
/*
Server: Msg 3624, Level 20, State 1, Line 1
 
Location:	 blobman.cpp:1744
Expression:	 (*(UNALIGNED ColId16*)source) == COLID_HYDRA_TEXTPTR
SPID:		 53
Process ID:	 10604

Connection Broken
*/
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_ELEMENTS alter column clause varchar(2000) null"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "exec sp_fulltext_column 'ctx_elements','clause','add'"
//End Change

//Start 05/21/2007 By Jervis:
ls_sql_statments[upperbound(ls_sql_statments)+1] = "exec sp_fulltext_table 'ctx_elements','activate'"
//End 

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_FEE_SCHED_NM alter column description varchar(255) null"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_FEE_SCHED_NM alter column notes text null"

String ls_key_name
select name into :ls_key_name from sysobjects where xtype='PK' and parent_obj=object_id('CTX_NOTIFICATION_USERS');
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_NOTIFICATION_USERS drop constraint [" + ls_key_name + "] "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_NOTIFICATION_USERS alter column user_id varchar(10) not null"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_NOTIFICATION_USERS add constraint [" + ls_key_name + "] primary key (ctx_id, user_id, alm_table, alm_column) "

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_ORGS alter column drections varchar(255) null"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_ORGS alter column notes varchar(255) null"

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_ORGS_CONTACT alter column notes varchar(255) null"

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sysobjects where id = object_id('FK_CTX_CONT_REFERENCE_CODE_LOO_STATE') and type = 'F') alter table CTX_CONTACTS drop FK_CTX_CONT_REFERENCE_CODE_LOO_STATE"

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_contacts alter column city varchar(35) null"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_contacts alter column state numeric(5,0) null"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_contacts alter column zip varchar(12) null"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_contacts alter column street_1 varchar(150) null"

String ls_default_name
select name into :ls_default_name from sysobjects where id=(select id from syscomments where id=(select cdefault from syscolumns where id=object_id('ctx_contacts') and name='middle_name'));
IF NOT f_validstr(ls_default_name) THEN ls_default_name = 'DF__CTX_CONTA__middl__6383C8BA'
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_CONTACTS drop constraint [" + ls_default_name + "] "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table CTX_CONTACTS add constraint [" + ls_default_name + "] default '' for middle_name "

select name into :ls_key_name from sysobjects where xtype='PK' and parent_obj=object_id('sys_storage_docs');
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table sys_storage_docs drop constraint [" + ls_key_name + "] "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Alter Table sys_storage_docs alter column doc_name varchar(75) not null " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Alter Table sys_storage_docs alter column doc_type varchar(1) null " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Alter Table sys_storage_docs alter column user_id  varchar(10) null " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table sys_storage_docs add constraint [" + ls_key_name + "] primary key(area_id, doc_name) "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "update sys_storage_docs set doc_name = rtrim(doc_name) "

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sysobjects where id = object_id('FK_CTX_FEE__REFERENCE_CODE_LOO_location') and type = 'F') alter table CTX_FEE_SCHED_LOCATIONS drop FK_CTX_FEE__REFERENCE_CODE_LOO_location"


// Insert DATA to code_lookup Table
// of_asa_1_changes()

// of_asa_2_changes()
integer cnt
select count(lookup_code) into : cnt from code_lookup where lookup_name = 'Contract Practitioner Contract Stat';
if cnt = 0 then
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Practitioner Contract Stat' ,'Par.','Participating in the contract')"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Practitioner Contract Stat' ,'Not Par.','Not Participating in the Contract') "
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Practitioner Contract Stat' ,'Par. Unknown.','Not Know if the practitioner will be participating in the contract.') "
end if

// of_asa_3_changes()
select count(lookup_code) into : cnt from code_lookup where lookup_name = 'Contract Fee Schd Cat. (NM)';
if cnt = 0 then ////Start Code Change ---- 11.09.2006 #1 maha
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Fee Schd Cat. (NM)' ,'NETSRV','Netwwork Service')"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Fee Schd Cat. (NM)' ,'TELE-EQUIP','Telephone Equipment') "
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Fee Schd Cat. (NM)' ,'COMP-EQUIP','Computer Equipment') "
end if

select count(lookup_code) into : cnt from code_lookup where lookup_name = 'Contract Service (NM)';
if cnt = 0 then ////Start Code Change ---- 11.09.2006 #1 maha
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Service (NM)' ,'COMP-REP-L','Computer Repair Labour')"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Service (NM)' ,'HVAC-REP-L','HVAC Repair Labour') "
end if

select count(lookup_code) into : cnt from code_lookup where lookup_name = 'Contract Fee Sched Stat. (NM)';
if cnt = 0 then ////Start Code Change ---- 11.09.2006 #1 maha
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Fee Sched Stat. (NM)' ,'ACTIVE','')"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Fee Sched Stat. (NM)' ,'INACTIVE','') "
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Fee Sched Stat. (NM)' ,'HISTORY','') "
end if

select count(lookup_code) into : cnt from code_lookup where lookup_name = 'Contract Supp. Doc.Type';
if cnt = 0 then ////Start Code Change ---- 11.09.2006 #1 maha
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Supp. Doc.Type' ,'CONTRACT','The contract')"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Supp. Doc.Type' ,'ADMENDMENT','Admendment to the contract') "
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Supp. Doc.Type' ,'OTHER','Other supporting document') "
end if

// of_asa_4_changes()
select count(lookup_code) into : cnt from code_lookup where lookup_name = 'Contract Billing Cycle';
if cnt = 0 then ////Start Code Change ---- 11.09.2006 #1 maha
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Billing Cycle' ,'Monthly','Billed on a Monthly basis')"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Billing Cycle' ,'Weekly','Billed on a Weekly basis') "
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Billing Cycle' ,'Per Unit','Billed on a Per Unit basis') "
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Billing Cycle' ,'Custom','Custom') "
end if

// of_asa_5_changes()

// of_asa_6_changes()
select count(lookup_code) into : cnt from code_lookup where lookup_name = 'Contract Position Title';
if cnt = 0 then ////Start Code Change ---- 11.09.2006 #1 maha
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Position Title' ,'CEO','Chief Executive Officer ')"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Position Title' ,'CFO','Chief Financial Officer') "
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Position Title' ,'CCO','Chief Contracting Officer') "
end if

// of_asa_7_changes()

// of_asa_9_changes()
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 05.09.2007 By: Jack
//$<reason> Fix a defect.
/*
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE CODE_LOOKUP SET CUSTOM_6 = 'PayorCTX' WHERE LOOKUP_NAME = 'Contract Category' "
*/
//---------------------------- APPEON END ----------------------------

// of_init_data
select count(lookup_code) into : cnt from code_lookup where lookup_name = 'Contract Type';
if cnt = 0 then 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Type','DIRGP','Direct Group') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contact Type','INDV','Individual') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contact Type','MSO','MSO') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contact Type','IPA','IPA') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contact Type','PHO','PHO') " 
end if

select count(lookup_code) into : cnt from code_lookup where lookup_name = 'Contract Status';
if cnt = 0 then 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Status','ACTIVE','Active','S') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Status','HISTORY','History','S') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Status','EXPIRED','Expired','S') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Status','CANCELED','Canceled','S') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Status','INACTIVE','Inactive','S') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Status','PENDING','Pending','S') " 
end if

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.11.2007 By: Jack
//$<reason> Fix a defect.
/*
select count(lookup_code) into : cnt from code_lookup where lookup_name = 'Contract Status';
*/
select count(lookup_code) into : cnt from code_lookup where lookup_name = 'Contract Category';

//---------------------------- APPEON END ----------------------------

if cnt = 0 then 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Category','PAYERCTX','Payer Contract') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Category','DRUGCO','Drug Company') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Category','EQUIPLEASE','Equipment Lease') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Category','PHONESERV','Phone Service') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Category','WEBCOMM.','Web Communications') " 
	//--------------------------- APPEON BEGIN ---------------------------
	//$<comment> 05.09.2007 By: Jack
	//$<reason> Fix a defect.	
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE CODE_LOOKUP SET CUSTOM_6 = 'PayorCTX' WHERE LOOKUP_NAME = 'Contract Category' "	
	//---------------------------- APPEON END ----------------------------
end if

select count(lookup_code) into : cnt from code_lookup where lookup_name = 'Contract Type';
if cnt = 0 then 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Type','GROUP','Group') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Type','INDIVIDUAL','Individual') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Type','MSO','MSO') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Type','IPA','IPA') " 
end if

select count(lookup_code) into : cnt from code_lookup where lookup_name = 'Contract Product Type';
if cnt = 0 then 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Product Type','HMO','HMO') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Product Type','PPO','PPO') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Product Type','EPPO','EPPO') " 
end if

select count(lookup_code) into : cnt from code_lookup where lookup_name = 'Contract Logo Responsibiility';
if cnt = 0 then 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Logo Responsibiility','PAYOR','Payor') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Logo Responsibiility','NETWORK','Network') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Logo Responsibiility','OTHER','Other') "
end if

select count(lookup_code) into : cnt from code_lookup where lookup_name = 'Contract Credentialing Meeting';
if cnt = 0 then 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Credentialing Meeting' ,'1STMONTH','1st of Month') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Credentialing Meeting' ,'BI-WEEKLY','Bi-Weekly') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Credentialing Meeting' ,'WEEKLY','Weekly') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Credentialing Meeting' ,'15MONTH','15 of Each Month') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Credentialing Meeting' ,'EVERYOTHRWEEK','Every Other Week') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Credentialing Meeting' ,'2NDWDMONTH','2nd Wednesday of each Month') " 
end if

select count(lookup_code) into : cnt from code_lookup where lookup_name = 'Contract Allowable Billings';
if cnt = 0 then 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Allowable Billings' ,'DEDUCTIBLES','Deductibles') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Allowable Billings' ,'COPAYS','Co Pays') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Allowable Billings' ,'NON-CVD-SERV','Non covered Services') " 
end if

select count(lookup_code) into : cnt from code_lookup where lookup_name = 'Contract Contact Type';
if cnt = 0 then 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Contact Type' ,'CTXMGR','Contract Manager') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Contact Type' ,'PRECERT','Precertifications') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Contact Type' ,'AUTHOR','Authorizations') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Contact Type' ,'CLAIMSPRO','Claims Processing') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Contact Type' ,'PROVIDERREL','Provider Relations') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Contact Type' ,'LEGAL','Legal') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Contact Type' ,'OTHER','Other') "
end if

select count(lookup_code) into : cnt from code_lookup where lookup_name = 'Contract Contact VIA';
if cnt = 0 then 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Contact VIA' ,'PHONE','Phone') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Contact VIA' ,'FAX','Fax') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Contact VIA' ,'EMAIL','EMail') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Contact VIA' ,'PAGER','Pager') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Contact VIA' ,'CELL','Cell') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Contact VIA' ,'WEB','WEB') " 
end if

select count(lookup_code) into : cnt from code_lookup where lookup_name = 'Contract Organization Type';
if cnt = 0 then 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Organization Type' ,'PARTIHOSP','Participating Hospital') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Organization Type' ,'LAB','Lab') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Organization Type' ,'WORKCOMP','WorkMan Comp.') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Organization Type' ,'PAYOR','Payor') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Organization Type' ,'OTHER','Other') " 
end if

select count(lookup_code) into : cnt from code_lookup where lookup_name = 'Contract Schedule Type';
if cnt = 0 then 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Schedule Type' ,'GROUP','Group') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Schedule Type' ,'CARVEOUT','Carve Out') " 
end if

select count(lookup_code) into : cnt from code_lookup where lookup_name = 'Contract Carve Out Code Type';
if cnt = 0 then 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Carve Out Code Type' ,'PHYSICIAN','Physican') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Carve Out Code Type' ,'SPECIALITY','Speciality') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Carve Out Code Type' ,'TEST','Test') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Carve Out Code Type' ,'N/A','NA') " 
end if

select count(lookup_code) into : cnt from code_lookup where lookup_name = 'Contract Fee Basis';
if cnt = 0 then 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Fee Basis' ,'04MEDICARE','2004 MEDICARE') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Fee Basis' ,'05MEDICARE','2005 MEDICARE') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Fee Basis' ,'RVRVS','RVRVS') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Fee Basis' ,'LOCALITY','LOCALITY') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Fee Basis' ,'PBC','Percentage of Billed Charges') " 
end if

select count(lookup_code) into : cnt from code_lookup where lookup_name = 'Contract Local Code';
if cnt = 0 then 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Local Code' ,'ALL','ALL') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Local Code' ,'03','03') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Local Code' ,'04','04') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Local Code' ,'05','05') " 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Local Code' ,'06','06') " 
end if

select count(lookup_code) into : cnt from code_lookup where lookup_name = 'Contract Product Name';
if cnt = 0 then 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Product Name' ,'Product 1','Product 1') "
end if

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.20.2007 By: Jack 
//$<reason> Fix a defect.
/*
select count(lookup_code) into : cnt from code_lookup where lookup_name = 'Contract Product Name';
*/

select count(lookup_code) into : cnt from code_lookup where lookup_name = 'Contract Term Reason';
//---------------------------- APPEON END ----------------------------
if cnt = 0 then 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Term Reason' ,'Term Reason 1','Term Reason 1') "
end if

select count(lookup_code) into : cnt from code_lookup where lookup_name = 'Contract Division';
if cnt = 0 then 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Division' ,'Division 1','Division 1') "
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Division' ,'Division 2','Division 2') "
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Division' ,'Division 3','Division 3') "
end if

select count(lookup_code) into : cnt from code_lookup where lookup_name = 'Contract Action Type';
if cnt = 0 then 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Action Type' ,'AUTOMSG'    ,'System Generated Email','S') "
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Action Type' ,'AlmTmDt'    ,'Term Date Alarm','S') "
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Action Type' ,'AlmEffDt'   ,'Effective Date Alarm','S') "
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Action Type' ,'AlmRevDt'   ,'Review Date Alarm','S') "
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Action Type' ,'AlmCusDt'   ,'Custom Date Alarm','S') "
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Action Type' ,'AlmExpDt'   ,'Expriation Date Alarm','S') "
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Action Type' ,'AlmLstRvDT' ,'Last Revistion Date Alarm','S') "
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Action Type' ,'AlmCus2DT'  ,'Custom Date 2 Alarm','S') "

	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Action Type' ,'Expiring','Expiring') "
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Action Type' ,'Renegotiate','Renegotiate') "
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Action Type' ,'Follow Up','Follow Up') "
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Action Type' ,'Call','Call') "
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Action Type' ,'Email','Email') "
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Action Type' ,'Sent Letter','Sent Letter') "
	
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type,custom_6) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Action Type' ,'EffDtLtr','Effective Date Letter','S','contract_EffDtLtr.doc') ;"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type,custom_6) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Action Type' ,'RevDtLtr','Review Date Letter','S', 'contract_RevDtLtr.doc') ;"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type,custom_6) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Action Type' ,'ExpDtLtr','Expiration Date Letter','S','contract_ExpDtLtr.doc') ;"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type,custom_6) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Action Type' ,'CusDtLtr','Custom Date Letter','S','contract_CusDtLtr.doc') ;"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type,custom_6) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Action Type' ,'Cus2DtLtr','Custom Date 2 Letter','S','contract_Cus2DtLtr.doc') ;"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type,custom_6) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Action Type' ,'TermDtLtr','Term Date Letter','S','contract_TermDtLtr.doc') ;"
end if

select count(lookup_code) into : cnt from code_lookup where lookup_name = 'Contract Department';
if cnt = 0 then 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Department' ,'Purchasing','Purchasing') "
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Department' ,'Administration','Administration') "
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Department' ,'Contracting','Contracting') "
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Department' ,'Legal','Legal') "
end if


select count(lookup_code) into : cnt from code_lookup where lookup_name = 'Contract Action Status' and code = 'Complete';
if cnt = 0 then 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Action Status' ,'Complete','The action has been completed','S') ;"
end if
select count(lookup_code) into : cnt from code_lookup where lookup_name = 'Contract Action Status' and code = 'Incomplete';
if cnt = 0 then 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,type) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Action Status' ,'Incomplete','Incomplete','S') ;"
end if

select count(lookup_code) into : cnt from code_lookup where lookup_name = 'Contract Precert. Requirements';
if cnt = 0 then 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Precert. Requirements' ,'Tilt/Test','Tilt/Test') "
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Precert. Requirements' ,'Stent','Stent') "
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Precert. Requirements' ,'TEE','TEE') "
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Precert. Requirements' ,'Lf Heart','Lf Heart') "
end if

select count(lookup_code) into : cnt from code_lookup where lookup_name = 'Contract Authorization Requirements';
if cnt = 0 then 
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Authorization Requirements' ,'Echo','Echo') "
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Authorization Requirements' ,'Treadmill','Treadmill') "
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Authorization Requirements' ,'Ultra Sound','Ultra Sound') "
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Contract Authorization Requirements' ,'Nuclear Stress Test','Nuclear Stress Test') "
end if

return 0
end function

public subroutine of_appeon_global_search ();
end subroutine

public subroutine of_appeon_create_fulltext_catalog ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_contract_sqlof_appeon_create_fulltext_catalog()
// $<arguments>(None)
// $<returns> (none)
// $<description>
// $<description> Create following SQL for create full-text catalog.
//////////////////////////////////////////////////////////////////////
// $<add> 11.17.2006 by Davis
//////////////////////////////////////////////////////////////////////

String ls_sql[]
Long ll_i
String ls_key_name

SetPointer(hourglass!)

IF gs_dbtype <> "SQL" THEN
	MessageBox("Create Catalog","Error, The Full-Text Catelog can be created only on SqlServer Database.")
	RETURN
END IF


/*************** Prepare for full-text catalog *******************/

/*
Not need be, comment by davis 01.29.2007

ls_sql[upperbound(ls_sql)+1] = "Alter table ctx_images add id_forcatalog int identity"
ls_sql[upperbound(ls_sql)+1] = "CREATE UNIQUE INDEX index_ctx_images_id_forcatalog ON ctx_images(id_forcatalog)"

ls_sql[upperbound(ls_sql)+1] = "Alter table ctx_image add id_forcatalog int identity"
ls_sql[upperbound(ls_sql)+1] = "CREATE UNIQUE INDEX index_ctx_image_id_forcatalog ON ctx_image(id_forcatalog)"
*/

ls_sql[upperbound(ls_sql)+1] = "Alter table ctx_req_tmplt_element add id_forcatalog int identity"
ls_sql[upperbound(ls_sql)+1] = "CREATE UNIQUE INDEX index_ctx_req_tmplt_element_id_forcatalog ON ctx_req_tmplt_element(id_forcatalog)"

ls_sql[upperbound(ls_sql)+1] = "Alter table ctx_loc add id_forcatalog int identity"
ls_sql[upperbound(ls_sql)+1] = "CREATE UNIQUE INDEX index_ctx_loc_id_forcatalog ON ctx_loc(id_forcatalog)"

ls_sql[upperbound(ls_sql)+1] = "Alter table ctx_orgs_contact add id_forcatalog int identity"
ls_sql[upperbound(ls_sql)+1] = "CREATE UNIQUE INDEX index_ctx_orgs_contact_id_forcatalog ON ctx_orgs_contact(id_forcatalog)"

ls_sql[upperbound(ls_sql)+1] = "CREATE UNIQUE INDEX index_ctx_org_contact_id_forcatalog ON ctx_org_contact(org_contact_id)"

ls_sql[upperbound(ls_sql)+1] = "Alter table ctx_fee_sched_data add id_forcatalog int identity"
ls_sql[upperbound(ls_sql)+1] = "CREATE UNIQUE INDEX index_ctx_fee_sched_data_id_forcatalog ON ctx_fee_sched_data(id_forcatalog)"

ls_sql[upperbound(ls_sql)+1] = "CREATE UNIQUE INDEX index_ctx_action_items_id_forcatalog ON ctx_action_items(ctx_action_item_id)"

ls_sql[upperbound(ls_sql)+1] = "Alter table ctx_contract_contacts add id_forcatalog int identity"
ls_sql[upperbound(ls_sql)+1] = "CREATE UNIQUE INDEX index_ctx_contract_contacts_id_forcatalog ON ctx_contract_contacts(id_forcatalog)"

ls_sql[upperbound(ls_sql)+1] = "CREATE UNIQUE INDEX index_ctx_contacts_numbers_id_forcatalog ON ctx_contacts_numbers(contact_num_id)"

/****************** end *******************************************************/


//ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_database 'enable'"
//modified by nova 2008-04-08
IF Not Isvalid(gnv_logservice) THEN gnv_logservice = Create n_logservice
	
         n_cst_update_sql lnv_sql
			lnv_sql = Create n_cst_update_sql

		   lnv_sql.of_enable_fulltext()
	      Destroy lnv_sql
			destroy gnv_logservice

/***************** Create full-text catalog for ctx_basic_info **************/
select name into :ls_key_name from sysobjects where xtype='PK' and parent_obj=object_id('ctx_basic_info');

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_catalog 'ctx_basic_info_catalog','create'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_basic_info','create','ctx_basic_info_catalog','" + ls_key_name + "'"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_basic_info','file_location','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_basic_info','notes','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_basic_info','custom_1','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_basic_info','custom_2','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_basic_info','custom_3','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_basic_info','custom_4','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_basic_info','custom_5','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_basic_info','custom_6','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_basic_info','custom_7','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_basic_info','custom_8','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_basic_info','custom_9','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_basic_info','custom_10','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_basic_info','custom_11','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_basic_info','custom_12','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_basic_info','custom_13','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_basic_info','custom_14','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_basic_info','custom_15','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_basic_info','custom_16','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_basic_info','custom_17','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_basic_info','custom_18','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_basic_info','custom_19','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_basic_info','custom_20','add'"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_basic_info','start_full'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_basic_info','start_change_tracking'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_basic_info','start_background_updateindex'"

/****************************** End *****************************************/

/*
Due to the support document is deleted, comment by davis 01.29.2007
/***************** Create full-text catalog for ctx_images **************/

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_catalog 'ctx_images_catalog','create'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_images','create','ctx_images_catalog','index_ctx_images_id_forcatalog'"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_images','page_description','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_images','file_name','add'"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_images','start_full'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_images','start_change_tracking'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_images','start_background_updateindex'"

/****************************** End *****************************************/

/***************** Create full-text catalog for ctx_image **************/

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_catalog 'ctx_image_catalog','create'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_image','create','ctx_image_catalog','index_ctx_image_id_forcatalog'"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_image','inserted_by_user','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_image','updated_by_user','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_image','pdftext','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_image','image_file','add',0,'doctype'"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_image','start_full'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_image','start_change_tracking'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_image','start_background_updateindex'"

/****************************** End *****************************************/
*/


/***************** Create full-text catalog for ctx_am_document **************/

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_catalog 'ctx_am_document_catalog','create'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_am_document','create','ctx_am_document_catalog','pk_ctx_am_document'"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_am_document','doc_name','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_am_document','file','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_am_document','create_by','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_am_document','notes','add'"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_am_document','start_full'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_am_document','start_change_tracking'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_am_document','start_background_updateindex'"

/****************************** End *****************************************/

/***************** Create full-text catalog for ctx_am_doc_audit **************/

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_catalog 'ctx_am_doc_audit_catalog','create'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_am_doc_audit','create','ctx_am_doc_audit_catalog','index_ctx_am_doc_audit_id_forcatalog'"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_am_doc_audit','action','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_am_doc_audit','filename','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_am_doc_audit','notes','add'"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_am_doc_audit','start_full'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_am_doc_audit','start_change_tracking'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_am_doc_audit','start_background_updateindex'"

/****************************** End *****************************************/

/***************** Create full-text catalog for ctx_am_document **************/

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_catalog 'ctx_am_doc_image_catalog','create'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_am_doc_image','create','ctx_am_doc_image_catalog','index_ctx_am_doc_image_id_forcatalog'"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_am_doc_image','image_file','add',0,'doc_ext'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_am_doc_image','pdftext','add'"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_am_doc_image','start_full'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_am_doc_image','start_change_tracking'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_am_doc_image','start_background_updateindex'"

/****************************** End *****************************************/



/***************** Create full-text catalog for ctx_element **************/
select name into :ls_key_name from sysobjects where xtype='PK' and parent_obj=object_id('ctx_elements');

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_catalog 'ctx_elements_catalog','create'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_elements','create','ctx_elements_catalog','" + ls_key_name + "'"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_elements','clause','add'"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_elements','start_full'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_elements','start_change_tracking'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_elements','start_background_updateindex'"

/****************************** End *****************************************/


/***************** Create full-text catalog for ctx_req_tmplt_element **************/

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_catalog 'ctx_req_tmplt_element_catalog','create'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_req_tmplt_element','create','ctx_req_tmplt_element_catalog','index_ctx_req_tmplt_element_id_forcatalog'"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_req_tmplt_element','element_name','add'"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_req_tmplt_element','start_full'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_req_tmplt_element','start_change_tracking'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_req_tmplt_element','start_background_updateindex'"

/****************************** End *****************************************/


/***************** Create full-text catalog for ctx_contacts **************/
select name into :ls_key_name from sysobjects where xtype='PK' and parent_obj=object_id('ctx_contacts');

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_catalog 'ctx_contacts_catalog','create'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_contacts','create','ctx_contacts_catalog','" + ls_key_name + "'"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_contacts','first_name','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_contacts','last_name','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_contacts','middle_name','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_contacts','street_1','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_contacts','street_2','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_contacts','street_3','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_contacts','custom_1','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_contacts','custom_2','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_contacts','custom_3','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_contacts','custom_4','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_contacts','custom_5','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_contacts','custom_6','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_contacts','custom_7','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_contacts','custom_8','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_contacts','custom_9','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_contacts','custom_10','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_contacts','city','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_contacts','zip','add'"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_contacts','start_full'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_contacts','start_change_tracking'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_contacts','start_background_updateindex'"

/****************************** End *****************************************/


/***************** Create full-text catalog for ctx_contract_contacts **************/

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_catalog 'ctx_contract_contacts_catalog','create'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_contract_contacts','create','ctx_contract_contacts_catalog','index_ctx_contract_contacts_id_forcatalog'"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_contract_contacts','notes','add'"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_contract_contacts','start_full'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_contract_contacts','start_change_tracking'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_contract_contacts','start_background_updateindex'"

/****************************** End *****************************************/


/***************** Create full-text catalog for ctx_contacts_numbers **************/

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_catalog 'ctx_contacts_numbers_catalog','create'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_contacts_numbers','create','ctx_contacts_numbers_catalog','index_ctx_contacts_numbers_id_forcatalog'"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_contacts_numbers','phone','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_contacts_numbers','ext','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_contacts_numbers','contact_email','add'"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_contacts_numbers','start_full'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_contacts_numbers','start_change_tracking'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_contacts_numbers','start_background_updateindex'"

/****************************** End *****************************************/


/***************** Create full-text catalog for group_multi_loc **************/
select name into :ls_key_name from sysobjects where xtype='PK' and parent_obj=object_id('group_multi_loc');

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_catalog 'group_multi_loc_catalog','create'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'group_multi_loc','create','group_multi_loc_catalog','" + ls_key_name + "'"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'group_multi_loc','gp_name','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'group_multi_loc','street1','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'group_multi_loc','street2','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'group_multi_loc','city','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'group_multi_loc','state','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'group_multi_loc','phone','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'group_multi_loc','zip','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'group_multi_loc','contact_name','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'group_multi_loc','info1','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'group_multi_loc','info2','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'group_multi_loc','info3','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'group_multi_loc','info4','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'group_multi_loc','info5','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'group_multi_loc','info6','add'"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'group_multi_loc','start_full'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'group_multi_loc','start_change_tracking'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'group_multi_loc','start_background_updateindex'"

/****************************** End *****************************************/


/***************** Create full-text catalog for group_practice **************/
select name into :ls_key_name from sysobjects where xtype='PK' and parent_obj=object_id('group_practice');

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_catalog 'group_practice_catalog','create'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'group_practice','create','group_practice_catalog','" + ls_key_name + "'"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'group_practice','street','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'group_practice','street_2','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'group_practice','city','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'group_practice','pager_number','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'group_practice','phone','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'group_practice','ext','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'group_practice','fax','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'group_practice','zip','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'group_practice','contact_person','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'group_practice','tax_id','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'group_practice','tax_id_other_1','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'group_practice','tax_id_other_2','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'group_practice','business_mgr','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'group_practice','office_mgr','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'group_practice','e_mail_address','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'group_practice','web_address','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'group_practice','cust_1','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'group_practice','cust_2','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'group_practice','cust_3','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'group_practice','cust_4','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'group_practice','cust_5','add'"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'group_practice','start_full'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'group_practice','start_change_tracking'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'group_practice','start_background_updateindex'"

/****************************** End *****************************************/


/***************** Create full-text catalog for ctx_loc **************/

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_catalog 'ctx_loc_catalog','create'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_loc','create','ctx_loc_catalog','index_ctx_loc_id_forcatalog'"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_loc','group_number','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_loc','custom_1','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_loc','custom_2','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_loc','custom_3','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_loc','custom_4','add'"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_loc','start_full'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_loc','start_change_tracking'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_loc','start_background_updateindex'"

/****************************** End *****************************************/


/***************** Create full-text catalog for ctx_orgs **************/
select name into :ls_key_name from sysobjects where xtype='PK' and parent_obj=object_id('ctx_orgs');

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_catalog 'ctx_orgs_catalog','create'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_orgs','create','ctx_orgs_catalog','" + ls_key_name + "'"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_orgs','org_name','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_orgs','street_1','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_orgs','street_2','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_orgs','street_3','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_orgs','city','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_orgs','zip','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_orgs','drections','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_orgs','notes','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_orgs','custom_1','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_orgs','custom_2','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_orgs','custom_3','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_orgs','custom_4','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_orgs','custom_5','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_orgs','custom_6','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_orgs','custom_7','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_orgs','custom_8','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_orgs','custom_9','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_orgs','custom_10','add'"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_orgs','start_full'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_orgs','start_change_tracking'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_orgs','start_background_updateindex'"

/****************************** End *****************************************/


/***************** Create full-text catalog for ctx_orgs_contact **************/

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_catalog 'ctx_orgs_contact_catalog','create'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_orgs_contact','create','ctx_orgs_contact_catalog','index_ctx_orgs_contact_id_forcatalog'"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_orgs_contact','notes','add'"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_orgs_contact','start_full'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_orgs_contact','start_change_tracking'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_orgs_contact','start_background_updateindex'"

/****************************** End *****************************************/


/***************** Create full-text catalog for ctx_org_contact **************/

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_catalog 'ctx_org_contact_catalog','create'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_org_contact','create','ctx_org_contact_catalog','index_ctx_org_contact_id_forcatalog'"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_org_contact','contact_name','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_org_contact','Department','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_org_contact','Phone','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_org_contact','org_cnt_email','add'"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_org_contact','start_full'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_org_contact','start_change_tracking'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_org_contact','start_background_updateindex'"

/****************************** End *****************************************/


/***************** Create full-text catalog for ctx_fee_sched_hdr **************/
select name into :ls_key_name from sysobjects where xtype='PK' and parent_obj=object_id('ctx_fee_sched_hdr');

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_catalog 'ctx_fee_sched_hdr_catalog','create'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_fee_sched_hdr','create','ctx_fee_sched_hdr_catalog','" + ls_key_name + "'"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_fee_sched_hdr','custom_1','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_fee_sched_hdr','custom_2','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_fee_sched_hdr','custom_3','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_fee_sched_hdr','custom_4','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_fee_sched_hdr','custom_5','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_fee_sched_hdr','notes','add'"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_fee_sched_hdr','start_full'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_fee_sched_hdr','start_change_tracking'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_fee_sched_hdr','start_background_updateindex'"


/****************************** End *****************************************/


/***************** Create full-text catalog for ctx_fee_sched_data **************/

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_catalog 'ctx_fee_sched_data_catalog','create'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_fee_sched_data','create','ctx_fee_sched_data_catalog','index_ctx_fee_sched_data_id_forcatalog'"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_fee_sched_data','custom_1','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_fee_sched_data','custom_2','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_fee_sched_data','custom_3','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_fee_sched_data','custom_4','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_fee_sched_data','custom_5','add'"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_fee_sched_data','start_full'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_fee_sched_data','start_change_tracking'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_fee_sched_data','start_background_updateindex'"

/****************************** End *****************************************/


/***************** Create full-text catalog for ctx_action_item **************/

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_catalog 'ctx_action_items_catalog','create'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_action_items','create','ctx_action_items_catalog','index_ctx_action_items_id_forcatalog'"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_action_items','action_user','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_action_items','notes','add'"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_action_items','start_full'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_action_items','start_change_tracking'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_action_items','start_background_updateindex'"

/****************************** End *****************************************/


/***************** Create full-text catalog for code_lookup **************/
select name into :ls_key_name from sysobjects where xtype='PK' and parent_obj=object_id('code_lookup');

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_catalog 'code_lookup_catalog','create'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'code_lookup','create','code_lookup_catalog','" + ls_key_name + "'"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'code_lookup','code','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'code_lookup','description','add'"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'code_lookup','start_full'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'code_lookup','start_change_tracking'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'code_lookup','start_background_updateindex'"

/****************************** End *****************************************/


/***************** Create full-text catalog for app_facility **************/
select name into :ls_key_name from sysobjects where xtype='PK' and parent_obj=object_id('app_facility');

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_catalog 'app_facility_catalog','create'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'app_facility','create','app_facility_catalog','" + ls_key_name + "'"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'app_facility','facility_name','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'app_facility','street','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'app_facility','street_2','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'app_facility','city','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'app_facility','state','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'app_facility','zip','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'app_facility','phone','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'app_facility','ext','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'app_facility','fax','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'app_facility','contact','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'app_facility','web_address','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'app_facility','email_address','add'"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'app_facility','start_full'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'app_facility','start_change_tracking'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'app_facility','start_background_updateindex'"

/****************************** End *****************************************/


/***************** Create full-text catalog for ctx_req_profile **************/
select name into :ls_key_name from sysobjects where xtype='PK' and parent_obj=object_id('ctx_req_profile');

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_catalog 'ctx_req_profile_catalog','create'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_req_profile','create','ctx_req_profile_catalog','" + ls_key_name + "'"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_req_profile','rqmnt_name','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_req_profile','rqmnt_description','add'"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_req_profile','start_full'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_req_profile','start_change_tracking'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_req_profile','start_background_updateindex'"

/****************************** End *****************************************/

/*******************************08.29.2007 By Jervis *********************************/
//from n_cst_agreement_sql move to here
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_catalog 'ctx_acp_clause_catalog','create'"
select name into :ls_key_name from sysobjects where xtype='PK' and parent_obj=object_id('ctx_acp_clause');	
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_acp_clause','create','ctx_acp_clause_catalog','" + ls_key_name + "'"
 
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_acp_clause','clause_name','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_acp_clause','description','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_acp_clause','information_message','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_acp_clause','approved_by','add'"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_acp_clause','image_file','add',0,'doctype'"
 
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_acp_clause','start_full'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_acp_clause','start_change_tracking'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_acp_clause','start_background_updateindex'"


ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_catalog 'ctx_acp_template_catalog','create'"
select name into :ls_key_name from sysobjects where xtype='PK' and parent_obj=object_id('ctx_acp_template');	
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_acp_template','create','ctx_acp_template_catalog','" + ls_key_name + "'"
 
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_acp_template','Template_Name','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_acp_template','Description','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_acp_template','Reviewed_By','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_acp_template','image_file','add',0,'doctype'"
 
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_acp_template','start_full'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_acp_template','start_change_tracking'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_acp_template','start_background_updateindex'"


ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_catalog 'ctx_acp_document_catalog','create'"
select name into :ls_key_name from sysobjects where xtype='PK' and parent_obj=object_id('ctx_acp_document');	
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_acp_document','create','ctx_acp_document_catalog','" + ls_key_name + "'"
 
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_acp_document','Document_Name','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_acp_document','Files','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_acp_document','Description','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_acp_document','Reviewed_By','add'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_acp_document','image_file','add',0,'Document_Type'"
 
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_acp_document','start_full'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_acp_document','start_change_tracking'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_acp_document','start_background_updateindex'"
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.16.2007 By: Jack
ls_sql[upperbound(ls_sql)+1] = "CREATE UNIQUE INDEX index_ctx_am_action_item_seq_id ON ctx_am_action_item(seq_id);"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_catalog 'ctx_am_action_item_catalog','create'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_am_action_item','create','ctx_am_action_item_catalog','index_ctx_am_action_item_seq_id'"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_column 'ctx_am_action_item','notes','add'"

ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_am_action_item','start_full'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_am_action_item','start_change_tracking'"
ls_sql[upperbound(ls_sql)+1] = "exec sp_fulltext_table 'ctx_am_action_item','start_background_updateindex'"
//---------------------------- APPEON END ----------------------------
/*******************************08.29.2007 By Jervis *********************************/
	
	
ls_sql[upperbound(ls_sql)+1] = "DROP FUNCTION fn_ctx"
ls_sql[upperbound(ls_sql)+1] = "CREATE FUNCTION fn_ctx(@ctx_id int)" +&
" RETURNS varchar(255)" +&
" AS" +&
" BEGIN" +&
" Declare @company_name varchar(255)" +&
" Declare @product_name varchar(255)" +&
" Select top 1 @company_name = facility_name" +&
" from app_facility, ctx_basic_info" +&
" where ctx_basic_info.ctx_id = @ctx_id and app_facility.facility_id = ctx_basic_info.app_facility" +&
" Select top 1 @product_name = code_lookup.code + ' ' + code_lookup1.code " +&
" from ctx_products,code_lookup,code_lookup code_lookup1" +&
" where ctx_products.ctx_id = @ctx_id" +&
" and code_lookup.lookup_code = ctx_products.product_id" +&
" and  code_lookup1.lookup_code = ctx_products.product_type" +&
" If @company_name is null Return @product_name " +&
" If @product_name is null Return @company_name" +&
" Return @company_name + ' - ' + @product_name" +&
" END"

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "commit;"

if Not isvalid( w_infodisp ) then open(w_infodisp)

if isvalid(w_infodisp) then w_infodisp.title = 'Creates full-text catalog, Please stand by...'
if isvalid(w_infodisp) then w_infodisp.Center = TRUE
if isvalid(w_infodisp) then w_infodisp.st_complete.visible = false
if isvalid(w_infodisp) then w_infodisp.st_3.visible = false
if isvalid(w_infodisp) then w_infodisp.st_information.visible = false
if isvalid(w_infodisp) then w_infodisp.progress_bar.visible = true
if isvalid(w_infodisp) then w_infodisp.wf_set_min_max(1,upperbound(ls_sql))
		
FOR ll_i = 1 TO upperbound(ls_sql)
	if isvalid(w_infodisp) then w_infodisp.st_1.text = 'Modification:' +string(ll_i) +' of '+ string(upperbound(ls_sql)) +' Please stand by!'

	EXECUTE IMMEDIATE :ls_sql[LL_I] using sqlca;
//	IF len(sqlca.sqlerrtext) > 0 THEN
//		IF handle(getapplication()) = 0 THEN
//			messagebox(string(LL_I), string(sqlca.sqlerrtext)  + new_line + error.object + new_line +    string(ls_sql[LL_I]) + new_line + "Please contact software vendor."   )
//		END IF
//	ELSE
	inv_logservice.of_log_sqlca()
		COMMIT;
//	END IF
	
	if isvalid(w_infodisp) then w_infodisp.wf_step_pbar(1)
NEXT
		
if isvalid(w_infodisp) then close(w_infodisp)


end subroutine

public function integer of_appeon3_changes ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_contract_sql / of_appeon3_changes()
// $<arguments>
//		value	integer		
// $<returns> integer
// $<description> Add this function because of maximum script size exceeded in of_appeon1_changes.
//////////////////////////////////////////////////////////////////////
// $<add> 2007-01-31 by Rodger Wu
//////////////////////////////////////////////////////////////////////

string ls_sql, ls_tag

IF gs_dbtype = "ASA" THEN ls_tag = "; "
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.12.2007 By: Jack (Contract)
//$<reason> Fix a defect.
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info add master_contract_id numeric(6,0) default 0;"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info add master_contract_name varchar(255) null;"

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-08-08 By: Scofield
//$<Reason> Extend the table ctx_basic_info's custome number column's length
If gs_dbtype = "ASA" Then
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info modify custom_n1 numeric(12,2) null;"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info modify custom_n2 numeric(12,2) null;"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info modify custom_n3 numeric(12,2) null;"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info modify custom_n4 numeric(12,2) null;"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info modify custom_n5 numeric(12,2) null;"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info modify custom_n6 numeric(12,2) null;"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info modify custom_n7 numeric(12,2) null;"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info modify custom_n8 numeric(12,2) null;"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info modify custom_n9 numeric(12,2) null;"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info modify custom_n10 numeric(12,2) null;"
else
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info alter column custom_n1 numeric(12,2) null;"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info alter column custom_n2 numeric(12,2) null;"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info alter column custom_n3 numeric(12,2) null;"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info alter column custom_n4 numeric(12,2) null;"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info alter column custom_n5 numeric(12,2) null;"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info alter column custom_n6 numeric(12,2) null;"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info alter column custom_n7 numeric(12,2) null;"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info alter column custom_n8 numeric(12,2) null;"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info alter column custom_n9 numeric(12,2) null;"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_basic_info alter column custom_n10 numeric(12,2) null;"
end if

//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-09-13 By: Scofield
//$<Reason> Extend pd_peer_review.case_number,pd_peer_review_pracs.case_number,pd_peer_review_action_items.case_number,pd_peer_committee_review.case_number length
if gs_dbtype = "ASA" then
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "ALTER TABLE pd_peer_review DELETE  PRIMARY KEY;"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "ALTER TABLE pd_peer_review modify case_number numeric(14,0) not null;"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = 'ALTER TABLE pd_peer_review ADD PRIMARY KEY ("case_number");'
	
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "ALTER TABLE pd_peer_review_pracs DELETE PRIMARY KEY;"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "ALTER TABLE pd_peer_review_pracs MODIFY case_number numeric(14,0) Not Null;"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = 'ALTER TABLE pd_peer_review_pracs ADD PRIMARY KEY ("rec_id","prac_id","case_number");'
	
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "ALTER TABLE pd_peer_review_action_items DELETE PRIMARY KEY;"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "ALTER TABLE pd_peer_review_action_items MODIFY case_number numeric(14,0) Not Null;"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = 'ALTER TABLE pd_peer_review_action_items ADD PRIMARY KEY ("rec_id","case_number");'
	
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "ALTER TABLE pd_peer_committee_review DELETE PRIMARY KEY;"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "ALTER TABLE pd_peer_committee_review MODIFY case_number numeric(14,0) Not Null;"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = 'ALTER TABLE pd_peer_committee_review ADD PRIMARY KEY ("rec_id","case_number","committee_name");'
else
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "ALTER TABLE pd_peer_review DROP CONSTRAINT PK_PD_PEER_REVIEW;"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "ALTER TABLE pd_peer_review alter column case_number numeric(14,0) not null;"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "ALTER TABLE pd_peer_review Add CONSTRAINT PK_PD_PEER_REVIEW PRIMARY KEY(case_number);"
	
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "ALTER TABLE pd_peer_review_action_items DROP CONSTRAINT PK_PD_PEER_REVIEW_ACTION_ITEMS;"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "ALTER TABLE pd_peer_review_action_items alter column case_number numeric(14,0) not null;"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "ALTER TABLE pd_peer_review_action_items Add CONSTRAINT PK_PD_PEER_REVIEW_ACTION_ITEMS PRIMARY KEY(rec_id,case_number);"
	
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "ALTER TABLE pd_peer_review_pracs DROP CONSTRAINT PK_PD_PEER_REVIEW_PRACS;"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "ALTER TABLE pd_peer_review_pracs alter column case_number numeric(14,0) not null;"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "ALTER TABLE pd_peer_review_pracs Add CONSTRAINT PK_PD_PEER_REVIEW_PRACS PRIMARY KEY(rec_id,prac_id,case_number);"
	
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "ALTER TABLE pd_peer_committee_review DROP CONSTRAINT PK_PD_PEER_COMMITTEE_REVIEW;"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "ALTER TABLE pd_peer_committee_review ALTER COLUMN case_number numeric(14,0) not null;"
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "ALTER TABLE pd_peer_committee_review ADD CONSTRAINT PK_PD_PEER_COMMITTEE_REVIEW PRIMARY KEY(rec_id,case_number,committee_name);"
end if
//---------------------------- APPEON END ----------------------------

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create index indx_master_contract_id on ctx_basic_info (master_contract_id);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "update ctx_basic_info set master_contract_id = 0 where master_contract_id is null;"
//Add by Jack 03/21/2007
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_products add constraint FK_ctx_products_product_id foreign key (product_id) references code_lookup (lookup_code);" 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table ctx_products add constraint FK_ctx_products_product_type foreign key (product_type) references  code_lookup (lookup_code);"

//Add by Jack 06/14/2007
//IF gs_dbtype = "ASA" THEN
//	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "ALTER TABLE CTX_CONTACTS DROP foreign key fk_contacts_user;"
//	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "ALTER TABLE CTX_CONTACTS DROP foreign key fk_ctx_cont_reference_code_loo_state;"
//ELSE
//	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "ALTER TABLE CTX_CONTACTS DROP fk_ctx_cont_reference_security;"
//END IF

//---------------------------- APPEON END ----------------------------

//Create Procedure, its syntax is alike with of_asa_6changes(). Rodger Wu on Sept 15, 2006
ls_sql_statments[upperbound(ls_sql_statments) + 1] = " drop PROCEDURE sp_contract_search" 
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 05.08.2007 By: Jack
//$<reason> Fix a defect.
/*
ls_sql_statments[upperbound(ls_sql_statments) + 1] = " CREATE PROCEDURE sp_contract_search" + &
																		 " as " + &
																			 " BEGIN " + &
																				 " SELECT DISTINCT ctx_basic_info.app_facility,   " + &
																					    "code_lookup.code product_name,   " + &
																						 " ctx_basic_info.effective_date,   " + &
																						 " ctx_basic_info.expriation_date,   " + &
																						 "ctx_basic_info.status,   " + &
																						 "ctx_basic_info.group_multi_loc_id,   " + &
																						 "ctx_basic_info.ctx_id,   " + &
																						 "ctx_basic_info.master_contract_id,   " + &																						 
																						 "master_cnt = (select count(ctx_basic_info1.ctx_id) from ctx_basic_info ctx_basic_info1 where ctx_basic_info.ctx_id = ctx_basic_info1.master_contract_id), " + &																						 
																						 "ctx_basic_info.category,    " + &
																						 "ctx_basic_info.facility_id,   " + &
																						 "ctx_basic_info.contract_type,   " + &
																						 "code_lookup1.code product_type,   " + &
																						 "ctx_basic_info.reimbursment_menth,  " + & 
																						 "ctx_basic_info.file_location,   " + &
																						 "ctx_basic_info.review_date,   " + &
																						 "ctx_basic_info.review_by,   " + &
																						 "ctx_basic_info.term_date,   " + &
																						 "ctx_basic_info.term_reason,   " + &
																						 "ctx_basic_info.last_revis_date,   " + &
																						 "ctx_basic_info.other_date_1,   " + &
																						 "ctx_basic_info.other_date_2,   " + &
																						 "ctx_basic_info.oc_signed_by,   " + &
																						 "ctx_basic_info.oc_title,   " + &
																						 "ctx_basic_info.oc_department,   " + &
																						 "ctx_basic_info.oc_legal_rep,   " + &
																						 "ctx_basic_info.cc_signed_by,   " + &
																						 "ctx_basic_info.cc_title,   " + &
																						 "ctx_basic_info.cc_department,   " + &
																						 "ctx_basic_info.cc_legal_rep,   " + &
																						 "ctx_basic_info.notes,   " + &
																						 "ctx_basic_info.keyword,   " + &
																						 "ctx_basic_info.dvision,   " + &
																						 "ctx_basic_info.custom_1,   " + &
																						 "ctx_basic_info.custom_2,   " + &
																						 "ctx_basic_info.custom_3,   " + &
																						 "ctx_basic_info.custom_4,   " + &
																						 "ctx_basic_info.custom_5,   " + &
																						 "ctx_basic_info.custom_6,   " + &
																						 "ctx_basic_info.custom_7,   " + &
																						 "ctx_basic_info.custom_8,   " + &
																						 "ctx_basic_info.custom_9,   " + &
																						 "ctx_basic_info.custom_10,   " + &
																						 "ctx_basic_info.group_id,   " + &
																						 "ctx_basic_info.revision_reason, " + &  
																						 "ctx_basic_info.record_id ," + &
																						 "owner = upper((SELECT top 1 ctx_contacts.user_d " + &
																						 "				FROM ctx_contacts,ctx_contract_contacts" + &
																						 "				WHERE (ctx_contract_contacts.contact_id = ctx_contacts.contact_id ) and  " + &
																						 "						(ctx_contract_contacts.ctx_id = ctx_basic_info.ctx_id ) AND  " + &
																						 "						( ctx_contract_contacts.owner = 'Y' ) ))," + &
																					   "contracted_entity = (  SELECT top 1 group_multi_loc.rec_id  " + &
																							 "											FROM ctx_loc,   " + &
																							 "												group_multi_loc  " + &
																							 "											WHERE ( ctx_loc.parent_comp_id = group_multi_loc.rec_id ) and  " + &
																							 "													( ctx_loc.ctx_id = ctx_basic_info.ctx_id  ) AND  " + &
																							 "													ctx_loc.loc_id = 0    )," + &
																					    "app_facility.facility_name facility_name   " + &
																																 " FROM ctx_basic_info, " + &
																																       "ctx_products,  " + &
																																       "code_lookup,  " + &
																																       "code_lookup code_lookup1,  " + &
																																		 "ctx_basic_info ctx_basic_info1 LEFT OUTER JOIN app_facility ON ctx_basic_info1.app_facility = app_facility.facility_id " + &
																																 " WHERE ctx_basic_info.ctx_id = ctx_products.ctx_id   " + &
																																 " AND ctx_basic_info.ctx_id = ctx_basic_info1.ctx_id   " + &
																																 " AND ctx_products.product_id = code_lookup.lookup_code   " + &
																																 " AND ctx_products.product_type = code_lookup1.lookup_code  " + &
																																 " ORDER BY ctx_basic_info.ctx_id  " + &
																																					 " END "

*/

ls_sql_statments[upperbound(ls_sql_statments) + 1] = " CREATE PROCEDURE sp_contract_search" + &
	" as " + &
	" BEGIN " + &
	"   SELECT DISTINCT ctx_basic_info.app_facility,   " + &
			"code_lookup.code product_name,   " + &
			"ctx_basic_info.effective_date,   " + &
			"ctx_basic_info.expriation_date,   " + &
			"ctx_basic_info.status,   " + &
			"ctx_basic_info.group_multi_loc_id,   " + &
			"ctx_basic_info.ctx_id,   " + &
			"ctx_basic_info.master_contract_id,   " + &																						 
			"master_cnt = (select count(ctx_basic_info1.ctx_id) from ctx_basic_info ctx_basic_info1 where ctx_basic_info.ctx_id = ctx_basic_info1.master_contract_id), " + &																						 
			"ctx_basic_info.category,    " + &
			"ctx_basic_info.facility_id,   " + &
			"ctx_basic_info.contract_type,   " + &
			"code_lookup1.code product_type,   " + &
			"ctx_basic_info.reimbursment_menth,  " + & 
			"ctx_basic_info.file_location,   " + &
			"ctx_basic_info.review_date,   " + &
			"ctx_basic_info.review_by,   " + &
			"ctx_basic_info.term_date,   " + &
			"ctx_basic_info.term_reason,   " + &
			"ctx_basic_info.last_revis_date,   " + &
			"ctx_basic_info.other_date_1,   " + &
			"ctx_basic_info.other_date_2,   " + &
			"ctx_basic_info.oc_signed_by,   " + &
			"ctx_basic_info.oc_title,   " + &
			"ctx_basic_info.oc_department,   " + &
			"ctx_basic_info.oc_legal_rep,   " + &
			"ctx_basic_info.cc_signed_by,   " + &
			"ctx_basic_info.cc_title,   " + &
			"ctx_basic_info.cc_department,   " + &
			"ctx_basic_info.cc_legal_rep,   " + &
			"ctx_basic_info.notes,   " + &
			"ctx_basic_info.keyword,   " + &
			"ctx_basic_info.dvision,   " + &
			"ctx_basic_info.custom_1,   " + &
			"ctx_basic_info.custom_2,   " + &
			"ctx_basic_info.custom_3,   " + &
			"ctx_basic_info.custom_4,   " + &
			"ctx_basic_info.custom_5,   " + &
			"ctx_basic_info.custom_6,   " + &
			"ctx_basic_info.custom_7,   " + &
			"ctx_basic_info.custom_8,   " + &
			"ctx_basic_info.custom_9,   " + &
			"ctx_basic_info.custom_10,   " + &
			"ctx_basic_info.group_id,   " + &
			"ctx_basic_info.revision_reason, " + &  
			"ctx_basic_info.record_id ," + &
			"owner = upper((SELECT top 1 ctx_contacts.user_d " + &
			"				FROM ctx_contacts,ctx_contract_contacts" + &
			"				WHERE (ctx_contract_contacts.contact_id = ctx_contacts.contact_id ) and  " + &
			"						(ctx_contract_contacts.ctx_id = ctx_basic_info.ctx_id ) AND  " + &
			"						( ctx_contract_contacts.owner = 'Y' ) ))," + &
			"contracted_entity = (SELECT top 1 group_multi_loc.rec_id  " + &
			"							   FROM ctx_loc,   " + &
			"									  group_multi_loc  " + &
			"								WHERE ( ctx_loc.parent_comp_id = group_multi_loc.rec_id) and  " + &
			"										( ctx_loc.ctx_id = ctx_basic_info.ctx_id) AND  " + &
			"										  ctx_loc.loc_id = 0)," + &
			"app_facility.facility_name facility_name   " + &
   " FROM  " + &
       	"ctx_basic_info  LEFT OUTER JOIN ctx_products ON ctx_basic_info.ctx_id = ctx_products.ctx_id  LEFT OUTER JOIN code_lookup ON ctx_products.product_id = code_lookup.lookup_code LEFT OUTER JOIN code_lookup code_lookup1 ON ctx_products.product_type = code_lookup1.lookup_code, " + &
		   "ctx_basic_info ctx_basic_info1 LEFT OUTER JOIN app_facility ON ctx_basic_info1.app_facility = app_facility.facility_id " + &
	" WHERE ctx_basic_info.ctx_id = ctx_basic_info1.ctx_id   " + &
	" ORDER BY ctx_basic_info.ctx_id  " + &
" END "


//---------------------------- APPEON END ----------------------------
//Add a new view called v_ctx_custom. Rodger Wu on Sept 18, 2006
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 05.16.2007 By: Frank.Gui
//$<reason> Droping and creating view will change id of this view and will make IntelliReport failed.
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "DROP view v_ctx_custom; "
//---------------------------- APPEON END ----------------------------

ls_sql = of_get_view_action( 'v_ctx_custom') +" AS " + &
"SELECT ctx_id, custom_1, custom_2, custom_3, custom_4, custom_5, custom_6,  " + &
"      custom_7, custom_8, custom_9, custom_10, custom_11, custom_12, custom_13,  " + &
"      custom_14, custom_15, custom_16, custom_17, custom_18, custom_19, custom_20,  " + &
"      custom_date1, custom_date2, custom_date3, custom_date4, custom_date5,  " + &
"      custom_date6, custom_date7, custom_date8, custom_date9, custom_date10,  " + &
"      custom_date11, custom_date12, custom_date13, custom_date14, custom_date15,  " + &
"      custom_n1, custom_n2, custom_n3, custom_n4, custom_n5, custom_n6, custom_n7,  " + &
"      custom_n8, custom_n9, custom_n10 " + &
"FROM CTX_BASIC_INFO " + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql 

//Add view v_ctx_requirement. Davis 11.16.2006
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 05.16.2007 By: Frank.Gui
//$<reason> Droping and creating view will change id of this view and will make IntelliReport failed.
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "DROP view v_ctx_requirement; "
//---------------------------- APPEON END ----------------------------

ls_sql = of_get_view_action('v_ctx_requirement') + "~r~n" + &
"AS SELECT CTX_REQ_PROFILE_HDR_1.ctx_id,	~r~n" + &
"CTX_RQMNT_CATEGORY.category_name,	~r~n" + &
"CTX_REQ_PROFILE.rqmnt_name,	~r~n" + &
"CTX_REQ_PROFILE.rqmnt_description,	~r~n" + &
"CTX_REQ_TMPLT_ELEMENT.element_name,	~r~n" + &
"DataValue = (case ctx_req_tmplt_element.value_type when 1 then CTX_ELEMENTS.date_value when 2 then CTX_ELEMENTS.field_value when 3 then CTX_ELEMENTS.char_value when 4 then CTX_ELEMENTS.integer_value when 5 then CTX_ELEMENTS.field_value end),~r~n" + &
"CTX_ELEMENTS.clause ~r~n" + &
"FROM (CTX_RQMNT_CATEGORY ~r~n" + &
"INNER JOIN ((CTX_REQ_PROFILE INNER JOIN CTX_REQ_PROFILE_HDR AS CTX_REQ_PROFILE_HDR_1 ON CTX_REQ_PROFILE.ctx_req_profile_id = CTX_REQ_PROFILE_HDR_1.ctx_req_profile_id) ~r~n" + &
"INNER JOIN CTX_REQ_TMPLT_ELEMENT ON  CTX_REQ_PROFILE.ctx_req_profile_id = CTX_REQ_TMPLT_ELEMENT.ctx_req_profile_id) ~r~n" + &
"ON (CTX_RQMNT_CATEGORY.ctx_req_profile_id = CTX_REQ_TMPLT_ELEMENT.ctx_req_profile_id) AND (CTX_RQMNT_CATEGORY.ctx_rqmnt_category_id = CTX_REQ_TMPLT_ELEMENT.ctx_rqmnt_category_id)) ~r~n" + &
"INNER JOIN CTX_ELEMENTS ON (CTX_ELEMENTS.ctx_req_tmplt_element_id = CTX_REQ_TMPLT_ELEMENT.ctx_req_tmplt_element_id) AND (CTX_REQ_PROFILE_HDR_1.ctx_id = CTX_ELEMENTS.CTX_REQ_PROFILE_HDR_id) ~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.12.2007 By: Jack
//$<reason> Create a new view.
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 05.16.2007 By: Frank.Gui
//$<reason> Droping and creating view will change id of this view and will make IntelliReport failed.
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "DROP view v_ctx_non_medical_fee_schedule; "
//---------------------------- APPEON END ----------------------------

ls_sql = of_get_view_action( 'v_ctx_non_medical_fee_schedule') +" as SELECT  " + &
			"ctx_fee_sched_nm.ctx_id,  " + &  
         "ctx_fee_sched_nm.fee_sched_nm_id, " + &   
         "code_lookup1.code as category, " + &   
         "code_lookup2.code as service_item, " + &   
         "ctx_fee_sched_nm.description, " + &   
         "ctx_fee_sched_nm.fee, " + &   
         "code_lookup3.code as item_status, " + &   
         "ctx_fee_sched_nm.start_date, " + &   
         "ctx_fee_sched_nm.end_date, " + &   
         "ctx_fee_sched_nm.service_name, " + &   
         "ctx_fee_sched_nm.custom_int1, " + &   
         "ctx_fee_sched_nm.custom_int2, " + &   
         "ctx_fee_sched_nm.custom_fee1, " + &   
         "ctx_fee_sched_nm.custom_fee2, " + &   
         "ctx_fee_sched_nm.custom_fee3, " + &   
         "ctx_fee_sched_nm.custom_text1, " + &   
         "ctx_fee_sched_nm.custom_text2, " + &   
         "ctx_fee_sched_nm.custom_text3, " + &   
         "ctx_fee_sched_nm.notes, " + &   
         "ctx_fee_sched_nm.record_id, " + &   
         "code_lookup4.code as billing_cycle, " + &   
         "ctx_fee_sched_nm.custom_text4, " + &   
         "ctx_fee_sched_nm.custom_text5, " + &   
         "ctx_fee_sched_nm.custom_text6, " + &   
         "ctx_fee_sched_nm.custom_text7, " + &   
         "ctx_fee_sched_nm.custom_text8, " + &   
         "ctx_fee_sched_nm.custom_n1, " + &   
         "ctx_fee_sched_nm.custom_n2,  " + &  
         "ctx_fee_sched_nm.custom_n3,  " + &  
         "ctx_fee_sched_nm.custom_n4,  " + &  
         "ctx_fee_sched_nm.custom_n5  " + & 
     "FROM ((((ctx_fee_sched_nm LEFT OUTER JOIN code_lookup AS code_lookup1 ON ctx_fee_sched_nm.category = code_lookup1.lookup_code and code_lookup1.lookup_name = 'Contract Fee Schd Cat. (NM)' ) LEFT OUTER JOIN code_lookup AS code_lookup2 ON ctx_fee_sched_nm.service_item = code_lookup2.lookup_code and code_lookup2.lookup_name = 'Contract Service (NM)') LEFT OUTER JOIN code_lookup AS code_lookup3 ON ctx_fee_sched_nm.item_status = code_lookup3.lookup_code and code_lookup3.lookup_name = 'Contract Fee Sched Stat. (NM)') LEFT OUTER JOIN code_lookup AS code_lookup4 ON ctx_fee_sched_nm.billing_cycle = code_lookup4.lookup_code and code_lookup4.lookup_name = 'Contract Billing Cycle') " + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql 
//---------------------------- APPEON END ----------------------------

// ***********FOR GLOBAL SEARCH******************************** 
// Added by Davis 11.16.2006
IF gs_dbtype = "SQL" THEN
	//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Alter table ctx_image add doctype varchar(10) null "
	//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Alter table ctx_image add pdftext text null ; "
	//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Update ctx_image set doctype = (select right(file_name,3) from ctx_images where ctx_images.image_id = ctx_image.image_id) ; "
	//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Update ctx_image set doctype = 'html' where doctype = 'tml' ; "
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Create Table ctx_globalsearch_term(" +&
	"id					smallint 		identity,"+&
	"searchtext		varchar(255)	null,"+&
	"resultsnum		integer			null,"+&
	"searchin_1		char(1)			null,"+&
	"searchin_2		char(1)			null,"+&
	"searchin_3		char(1)			null,"+&
	"searchin_4		char(1)			null,"+&
	"searchin_5		char(1)			null,"+&
	"searchin_6		char(1)			null,"+&
	"searchin_7		char(1)			null,"+&
	"searchin_8		char(1)			null,"+&
	"searchin_9		char(1)			null,"+&
	"searchin_10		char(1)			null,"+&
	"searchin_11		char(1)			null,"+&
	"searchin_12		char(1)			null,"+&
	"criteria_results	char(1)		null,"+&
	"criteria_contract	char(1)		null,"+&
	"primary key (id))"
END IF
// ***********FOR GLOBAL SEARCH******************************** 

// Added by Davis 01.24.2007	// For recored auto resize
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Alter table icred_settings add set_autoresize int null; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Update icred_settings set set_autoresize = 0 WHERE set_autoresize is null; "

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.17.2007 By: Jack
long ll_max

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Alter table ids add ctx_id numeric(6) null; "
select max(ctx_id) into :ll_max from ctx_basic_info;
If ll_max = 0 Then 
	ll_max = 1
Else
	ll_max = ll_max + 1
End If
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Update ids set ctx_id = " + string(ll_max) + " WHERE ctx_id is null; "

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Alter table ids add ctx_acp_folder_id numeric(6) null; "
select max(ctx_acp_folder_id) into :ll_max from ctx_acp_folder;
If ll_max = 0 Then 
	ll_max = 1
Else
	ll_max = ll_max + 1
End If
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Update ids set ctx_acp_folder_id = " + string(ll_max) + " WHERE ctx_acp_folder_id is null; "

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Alter table ids add ctx_acp_clause_id numeric(6) null; "
select max(ctx_acp_clause_id) into :ll_max from ctx_acp_clause;
If ll_max = 0 Then 
	ll_max = 1
Else
	ll_max = ll_max + 1
End If
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Update ids set ctx_acp_clause_id = " + string(ll_max) + " WHERE ctx_acp_clause_id is null; "

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Alter table ids add ctx_acp_template_id numeric(6) null; "
select max(ctx_acp_template_id) into :ll_max from ctx_acp_template;
If ll_max = 0 Then 
	ll_max = 1
Else
	ll_max = ll_max + 1
End If
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Update ids set ctx_acp_template_id = " + string(ll_max) + " WHERE ctx_acp_template_id is null; "

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Alter table ids add ctx_acp_document_id numeric(6) null; "
select max(ctx_acp_document_id) into :ll_max from ctx_acp_document;
If ll_max = 0 Then 
	ll_max = 1
Else
	ll_max = ll_max + 1
End If
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Update ids set ctx_acp_document_id = " + string(ll_max) + " WHERE ctx_acp_document_id is null; "

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Alter table ids add facility_id numeric(6) null; "
select max(facility_id) into :ll_max from app_facility;
If ll_max = 0 Then 
	ll_max = 1
Else
	ll_max = ll_max + 1
End If
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Update ids set facility_id = " + string(ll_max) + " WHERE facility_id is null; "

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Alter table ids add contact_id numeric(6) null; "
select max(contact_id) into :ll_max from ctx_contacts;
If ll_max = 0 Then 
	ll_max = 1
Else
	ll_max = ll_max + 1
End If
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Update ids set contact_id = " + string(ll_max) + " WHERE contact_id is null; "

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Alter table ids add email_id numeric(6) null; "
select max(email_id) into :ll_max from wf_email;
If ll_max = 0 Then 
	ll_max = 1
Else
	ll_max = ll_max + 1
End If
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Update ids set email_id = " + string(ll_max) + " WHERE email_id is null; "



//user_facility_id
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Alter table ids add user_facility_id numeric(6) null; "
select max(user_facility_id) into :ll_max from security_user_facilities;
If ll_max = 0 Then 
	ll_max = 1
Else
	ll_max = ll_max + 1
End If
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Update ids set user_facility_id = " + string(ll_max) //+ " WHERE user_facility_id is null; "

//user_view_id
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Alter table ids add user_view_id numeric(6) null; "
select max(user_view_id) into :ll_max from security_user_views;
If ll_max = 0 Then 
	ll_max = 1
Else
	ll_max = ll_max + 1
End If
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Update ids set user_view_id = " + string(ll_max) //+ " WHERE user_view_id is null; "
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 2007-06-12 By: Wu ZhiJun
//$<reason> Add two fields
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table address_lookup add  Large_Description_1 varchar(2000) null;"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table address_lookup add  Large_Description_2 varchar(2000) null;"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table code_lookup add  Large_Description_1 varchar(2000) null;"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table code_lookup add  Large_Description_2 varchar(2000) null;"
//--------------------------- APPEON END -----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 06.13.2007 By: Jack
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE sys_fields SET field_name_allias = 'Assigned To' WHERE table_id = 1021 AND field_id = 20117; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1021,20800,0,'','wf_assigned_by', 'Assigned By',512, 'C' ,5,'','','',''); "
//IntelliContract/Document Manager/ Action Items
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO sys_tables (table_id,table_name,table_name_allias,screen_type) VALUES (1064,'d_dm_doc_ai_detail','IntelliContract/Document Manager/ Action Items','S'); " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1064,20801,0,'','wf_assigned_by', 'Assigned By',512, 'C' ,5,'','','',''); "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (1064,20802,0,'','action_user', 'Assigned To',512, 'C' ,5,'','','',''); "
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.28.2007 By: Jack 
//$<reason> 
of_appeon4_changes()
//---------------------------- APPEON END ----------------------------

Return 0;
end function

public function integer of_getproperties (datastore ids_terget, ref datastore ids_properties);String ls_objects, ls_objname
String ls_objectlist[]
Integer i,li_objcount

String ls_colpro[],ls_otherpro[],ls_DwPro[]
String ls_pros,ls_proname, ls_provalue
Integer j, li_colcount,li_othercount,li_DwProCount
Integer li_insert

integer	k

ls_objects = ids_terget.Describe("DataWindow.Objects")
li_objcount = inv_string.of_parsetoarray(ls_objects,'~t',ls_objectlist)

If li_objcount  <= 0 Then
	Return -1
End If

ids_properties.Reset() //deleted all data of the ids_properties

//Init update properties
ls_colpro = {"Font.Face","Font.Italic","Font.Underline","Font.Weight","x","y","width","height","alignment","color","background.color","tabsequence","Edit.Required","dddw.PercentWidth","Case","EditMask.Mask","edit.displayonly","edit.AutoHScroll","edit.NilIsNull","dddw.VscrollBar","dddw.AutoHScroll","dddw.useasborder","dddw.NilIsNull","dddw.name","dddw.datacolumn","dddw.displaycolumn","dddw.PercentWidth","tag","dddw.displaycolumn","Initial","visible","protect","border"}
//Modify 07/04/2007 by: Andy
//ls_otherpro = {"Font.Face","Font.Italic","Font.Underline","Font.Weight","text","x","y","width","height","alignment","color","background.color","tag","visible","border","x1","y1","x2","y2"}
ls_otherpro = {"Font.Face","Font.Italic","Font.Underline","Font.Weight","text","x","y","width","height","alignment","color","background.color","tag","visible","border","x1","y1","x2","y2","format","Expression"}
//end of modify
ls_DwPro = {"Detail.Height","Table.Sort"}

li_colcount = UpperBound(ls_colpro)
li_othercount = UpperBound(ls_otherpro)
li_DwProCount = UpperBound(ls_DwPro)

For i = 1 To li_objcount
	ls_objname = ls_objectlist[i]
	
	//Add By Jervis only column and compute 03/20/2007
	ls_provalue = ids_terget.Describe(ls_objname + ".type")
	choose case ls_provalue
		case "column"
			For j = 1 To li_colcount
				ls_proname = ls_colpro[j]
				ls_provalue = ids_terget.Describe(ls_objname+"."+ls_proname)
				if isnull(ls_provalue) then ls_provalue = "!"
				Choose Case ls_provalue
					Case "!","?"
						Continue;
					Case Else
						li_insert = ids_properties.InsertRow(0)
						ids_properties.Object.obj_name[li_insert] = ls_objname
						ids_properties.Object.obj_pro[li_insert] = ls_proname
						ids_properties.Object.obj_value[li_insert] = ls_provalue
				End Choose
			Next
		case "compute","text","groupbox","line","button"
			For j = 1 To li_othercount
				ls_proname = ls_otherpro[j]
				ls_provalue = ids_terget.Describe(ls_objname+"."+ls_proname)
				if isnull(ls_provalue) then ls_provalue = "!"
				Choose Case ls_provalue
					Case "!","?"
						Continue;
					Case Else
						li_insert = ids_properties.InsertRow(0)
						ids_properties.Object.obj_name[li_insert] = ls_objname
						ids_properties.Object.obj_pro[li_insert] = ls_proname
						ids_properties.Object.obj_value[li_insert] = ls_provalue
				End Choose
			Next
	end choose
Next

for k = 1 to li_DwProCount
	ls_proname = ls_DwPro[k]
	ls_provalue = ids_terget.Describe("DataWindow." + ls_proname)
	li_insert = ids_properties.InsertRow(0)
	ids_properties.Object.obj_name[li_insert] = "DataWindow"
	ids_properties.Object.obj_pro[li_insert] = ls_proname
	ids_properties.Object.obj_value[li_insert] = ls_provalue
next

Return 1
end function

public function string of_setproperties (ref datastore ads_source, ref datastore ads_properties);Integer i, li_count
String ls_objname,ls_proname, ls_provalue, ls_exp
String ls_rtn,ls_err
n_cst_string lnv_string

li_count = ads_properties.rowcount()
if li_count <=0 then
	return ""
end if

for i = 1 to li_count
	ls_objname = ads_properties.object.obj_name[i]  
	ls_proname = ads_properties.object.obj_pro[i]  
	ls_provalue = ads_properties.object.obj_value[i]  
	
	if Match(ls_provalue,'^\".*\"$') or Match(ls_provalue,"^\'.*\'$") then	//04/27/2007 By jervis Fixed a defect for APB
		ls_exp = ls_objname + "." + ls_proname +" = " + ls_provalue
	else
		ls_exp =ls_objname + "." + ls_proname +" = '" + ls_provalue + "'"
	end if
	
	
	
	ls_rtn = ads_source.modify(ls_exp)
	if ls_rtn <> "" then
		ls_exp =ls_objname + "." + ls_proname +" = " + ls_provalue
		ls_rtn = ads_source.modify(ls_exp)
		//--------------------------- APPEON BEGIN ---------------------------
		//$<  Add > 2007-07-16 By: Scofield
		//$<Reason> After upgrade,the compute column's expression is not right.
		if ls_rtn <> "" then
			ls_exp =ls_objname + "." + ls_proname +' = "' + ls_provalue + '"'
			ls_rtn = ads_source.modify(ls_exp)
		end if
		//---------------------------- APPEON END ----------------------------
	end if
next

return ads_source.Describe("DataWindow.Syntax")
end function

public subroutine of_appeon2_changes_bak0321 ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_contract_sqlof_asa_6_changes()
// $<arguments>(None)
// $<returns> (none)
// $<description>Contract module modification
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 08.09.2006 by Liang QingShi
//////////////////////////////////////////////////////////////////////
integer i,li_num,li_rowcount,li_row
string ls_tab_name[],ls_screen_name[],ls_dw_name[],ls_dataobject[]
string ls_tab_name1,ls_screen_name1,ls_dw_name1,ls_dataobject1
string ls_sql
datastore lds_sql,lds_sql1 , lds_sql_exists
Long ll_count , ll_find

//SELECT count( screen_id ) INTO :ll_count FROM ctx_screen; //Rodger Wu added. Sept 15, 2006
//IF ll_count > 0 THEN Return

lds_sql1 = create datastore
lds_sql = create datastore
lds_sql.dataobject = 'd_contract_dw_sql'
lds_sql.settransobject(sqlca)

lds_sql_exists = create datastore
lds_sql_exists.dataobject = 'd_contract_dw_sql_update'
lds_sql_exists.settransobject(sqlca)
lds_sql_exists.retrieve()

ls_tab_name[1] = 'tabpage_search'
ls_tab_name[2] = 'tabpage_search'
ls_tab_name[3] = 'tabpage_details'
ls_tab_name[4] = 'tabpage_details'
ls_tab_name[5] = 'tabpage_details'
ls_tab_name[6] = 'tabpage_details'
ls_tab_name[7] = 'tabpage_details'
ls_tab_name[8] = 'tabpage_details'
ls_tab_name[9] = 'tabpage_details'
ls_tab_name[10] = 'tabpage_details'
ls_tab_name[11] = 'tabpage_requirements'
ls_tab_name[12] = 'tabpage_requirements'
ls_tab_name[13] = 'tabpage_requirements'
ls_tab_name[14] = 'tabpage_contacts'
ls_tab_name[15] = 'tabpage_contacts'
ls_tab_name[16] = 'tabpage_contacts'
ls_tab_name[17] = 'tabpage_contacts'
ls_tab_name[18] = 'tabpage_locations'
ls_tab_name[19] = 'tabpage_locations'
ls_tab_name[20] = 'tabpage_locations'
ls_tab_name[21] = 'tabpage_locations'
ls_tab_name[22] = 'tabpage_orgabizations'
ls_tab_name[23] = 'tabpage_orgabizations'
ls_tab_name[24] = 'tabpage_orgabizations'
ls_tab_name[25] = 'tabpage_orgabizations'
ls_tab_name[26] = 'tabpage_fee_schedules'
ls_tab_name[27] = 'tabpage_fee_schedules'
ls_tab_name[28] = 'tabpage_fee_schedules'
ls_tab_name[29] = 'tabpage_fee_schedules'
ls_tab_name[30] = 'tabpage_fee_schedules'
ls_tab_name[31] = 'tabpage_fee_sched2'
ls_tab_name[32] = 'tabpage_images'
ls_tab_name[33] = 'tabpage_action_items'
ls_tab_name[34] = 'tabpage_qrg'
ls_tab_name[35] = 'tabpage_qrg'
ls_tab_name[36] = 'tabpage_qrg'
ls_tab_name[37] = 'tabpage_qrg'
ls_tab_name[38] = 'tabpage_qrg'
ls_tab_name[39] = 'tabpage_qrg'
ls_tab_name[40] = 'tabpage_qrg'
ls_tab_name[41] = 'tabpage_qrg'
ls_tab_name[42] = 'tabpage_action_items'
ls_tab_name[43] = 'tabpage_details'

ls_screen_name[1] = 'Search->Search Criteria'
ls_screen_name[2] = 'Search->Contract Browse'
ls_screen_name[3] = 'Details->Contract Detail'
ls_screen_name[4] = 'Details->Products'
ls_screen_name[5] = 'Details->Contract Dates'
ls_screen_name[6] = 'Details->Contracted Company Contact'
ls_screen_name[7] = 'Details->Our Company Contact'
ls_screen_name[8] = 'Details->Notes Tab->Notes'
ls_screen_name[9] = 'Details->Custom Data Tab->Custom Data'
ls_screen_name[10] = 'Details->Audit Trail Tab->Audit Trail'
ls_screen_name[11] = 'Requirements->Profile Selection'
ls_screen_name[12] = 'Requirements->Profile Detail'
ls_screen_name[13] = 'Requirements->Profile Detail'
ls_screen_name[14] = 'Contacts->Contacts List'
ls_screen_name[15] = 'Contacts->Contract Details'
ls_screen_name[16] = 'Contacts->Contract Information'
ls_screen_name[17] = 'Contacts->Contract Notes'
ls_screen_name[18] = 'Locations->Parent Organization'
ls_screen_name[19] = 'Locations->Group/Location'
ls_screen_name[20] = 'Locations->Associated Physicians'
ls_screen_name[21] = 'Locations->Specialties'
ls_screen_name[22] = 'Organizations->Organization List'
ls_screen_name[23] = 'Organizations->Address'
ls_screen_name[24] = 'Organizations->Notes'
ls_screen_name[25] = 'Organizations->Organization Contacts'
ls_screen_name[26] = 'Fee Schedules->Browse Tab->Fee Schedules'
ls_screen_name[27] = 'Fee Schedules->Browse Tab->Fee Schedule Locations'
ls_screen_name[28] = 'Fee Schedules->Browse Tab->Fees'
ls_screen_name[29] = 'Fee Schedules->Browse Tab->Providers'
ls_screen_name[30] = 'Fee Schedules->Notes Tab->User Defined data'
ls_screen_name[31] = 'Fee Schedule (NM)->Fee Schedule (Non Healthcare)'
ls_screen_name[32] = 'Supporting Documents->Browse Tab->Scanned Documents'
ls_screen_name[33] = 'Action Items->Action Item List'
ls_screen_name[34] = 'QRG->Select Data Tab->Report Profiles'
ls_screen_name[35] = 'QRG->Select Data Tab->Basic Information to Include'
ls_screen_name[36] = 'QRG->Select Data Tab->Contract Contact Information to Include'
ls_screen_name[37] = 'QRG->Select Data Tab->Precertifications Requirements'
ls_screen_name[38] = 'QRG->Select Data Tab->Authorizations Requirements'
ls_screen_name[39] = 'QRG->Select Data Tab->Fee Schedule Data to Include'
ls_screen_name[40] = 'QRG->Select Data Tab->Organization Types to Include'
ls_screen_name[41] = 'QRG->Select Data Tab->Requirements to Include'
ls_screen_name[42] = 'Action Items->Action Item Browse'
ls_screen_name[43] = 'Details->Linked Contracts Tab->Linked Contracts'

ls_dw_name[1] = 'dw_search'
ls_dw_name[2] = 'dw_search_det1'
ls_dw_name[3] = 'dw_1'
ls_dw_name[4] = 'dw_products'
ls_dw_name[5] = 'dw_contract_dates'
ls_dw_name[6] = 'dw_ccc'
ls_dw_name[7] = 'dw_occ'
ls_dw_name[8] = 'dw_1'
ls_dw_name[9] = 'dw_1'
ls_dw_name[10] = 'dw_1'
ls_dw_name[11] = 'dw_2'
ls_dw_name[12] = 'dw_req_det'
ls_dw_name[13] = 'dw_req_det'
ls_dw_name[14] = 'dw_search'
ls_dw_name[15] = 'dw_detail'
ls_dw_name[16] = 'dw_phone'
ls_dw_name[17] = 'dw_notes'
ls_dw_name[18] = 'dw_main'
ls_dw_name[19] = 'dw_detail'
ls_dw_name[20] = 'dw_doctors'
ls_dw_name[21] = 'dw_spec'
ls_dw_name[22] = 'dw_search'
ls_dw_name[23] = 'dw_main'
ls_dw_name[24] = 'dw_notes'
ls_dw_name[25] = 'dw_contacts'
ls_dw_name[26] = 'dw_main'
ls_dw_name[27] = 'dw_locations'
ls_dw_name[28] = 'dw_fee_schedule'
ls_dw_name[29] = 'dw_codes'
ls_dw_name[30] = 'dw_1'
ls_dw_name[31] = 'dw_fee_nm'
ls_dw_name[32] = 'dw_1'
ls_dw_name[33] = 'dw_1'
ls_dw_name[34] = 'dw_profile'
ls_dw_name[35] = 'dw_basic_info'
ls_dw_name[36] = 'dw_contact_info'
ls_dw_name[37] = 'dw_precert'
ls_dw_name[38] = 'dw_auth'
ls_dw_name[39] = 'dw_1'
ls_dw_name[40] = 'dw_2'
ls_dw_name[41] = 'dw_requirements'
ls_dw_name[42] = 'dw_1'
ls_dw_name[43] = 'dw_1'

ls_dataobject[1] = 'd_contract_search'
ls_dataobject[2] = 'd_sp_contract_search'
ls_dataobject[3] = 'd_contract_det_master'
ls_dataobject[4] = 'd_ctx_products'
ls_dataobject[5] = 'd_contract_det_master_2'
ls_dataobject[6] = 'd_contract_det_contact_external'
ls_dataobject[7] = 'd_contract_det_contact_external'
ls_dataobject[8] = 'd_contract_det_notes'
ls_dataobject[9] = 'd_contract_det_custom'
ls_dataobject[10] = 'd_view_audit2_ctx'
ls_dataobject[11] = 'd_profile_header'
ls_dataobject[12] = 'd_contract_profile_req2'
ls_dataobject[13] = 'd_contract_profile_req_existing'
ls_dataobject[14] = 'd_contract_det_contact_contact'
ls_dataobject[15] = 'd_contract_det_contact_contact_det'
ls_dataobject[16] = 'd_contract_det_contact_contact_phone'
ls_dataobject[17] = 'd_contract_det_contact_contact_notes'
ls_dataobject[18] = 'd_contract_multi_group_browse'
ls_dataobject[19] = 'd_contract_group_linked_locations'
ls_dataobject[20] = 'd_contract_group_practitioners_existing'
ls_dataobject[21] = 'd_cntx_location_spec'
ls_dataobject[22] = 'd_org_search2'
ls_dataobject[23] = 'd_org_tabpg'
ls_dataobject[24] = 'd_org_notes'
ls_dataobject[25] = 'd_org_contacts'
ls_dataobject[26] = 'd_ctx_free_sched_hdr'
ls_dataobject[27] = 'd_ctx_schedule_fee_locations'
ls_dataobject[28] = 'd_ctx_schedule_fee_detail'
ls_dataobject[29] = 'd_ctx_schedule_fee_pracs'
ls_dataobject[30] = 'd_ctx_schedule_fee_notes'
ls_dataobject[31] = 'd_contract_fee_sched_nm'
ls_dataobject[32] = 'd_cntx_images'
ls_dataobject[33] = 'd_cntx_action_items'
ls_dataobject[34] = 'd_report_hdr'
ls_dataobject[35] = 'd_qrg_sys_fields'
ls_dataobject[36] = 'd_qrg_sys_fields'
ls_dataobject[37] = 'd_profile_codes'
ls_dataobject[38] = 'd_profile_codes'
ls_dataobject[39] = 'd_qrg_sys_fields'
ls_dataobject[40] = 'd_profile_codes'
ls_dataobject[41] = 'd_contract_profile_req_questions'
ls_dataobject[42] = 'd_cntx_action_items_browse'
ls_dataobject[43] = 'd_sp_contract_search'

li_num = UpperBound(ls_tab_name)
ll_count = lds_sql_exists.rowcount() //Add By Jervis 03/20/2007
for i = 1 to li_num
	ls_tab_name1 = ls_tab_name[i]
	ls_screen_name1 = ls_screen_name[i]
	ls_dw_name1 = ls_dw_name[i]
	ls_dataobject1 = ls_dataobject[i]
	
	lds_sql1.dataobject = ls_dataobject1
	lds_sql1.settransobject(sqlca)
	ls_sql = lds_sql1.Describe("datawindow.syntax")
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 03.14.2007 By: Jack (Contract)
	//$<reason> Fix a defect.
	/*
	ll_find = lds_sql_exists.find("dataobject = '" + ls_dataobject1 + "'" , 1 , lds_sql_exists.rowcount())
	*/
	ll_find = lds_sql_exists.find("dataobject = '" + ls_dataobject1 + "'" + " and screen_name = '" + ls_screen_name1 + "'", 1 , ll_count)	
	//---------------------------- APPEON END ----------------------------
	If ll_find > 0 Then
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 03.12.2007 By: Jack
		//$<reason> Fix a defect.
		/*
		update ctx_screen set dw_sql = :ls_sql, modify_date = getdate() where dataobject = :ls_dataobject1;
		*/
		If ls_dataobject1 = 'd_contract_search' Or ls_dataobject1 = 'd_sp_contract_search' Then
			update ctx_screen set dw_sql = :ls_sql, modify_date = getdate() where dataobject = :ls_dataobject1;
		Else	
			update ctx_screen set dw_sql = :ls_sql, modify_date = getdate() where data_view_id = 1001 and dataobject = :ls_dataobject1;
		End If
		//---------------------------- APPEON END ----------------------------
	Else
		li_row = lds_sql.insertrow(0)	
		lds_sql.setitem(li_row,'data_view_id',1001)
		lds_sql.setitem(li_row,'screen_id',i)
		lds_sql.setitem(li_row,'tab_name',ls_tab_name1)
		lds_sql.setitem(li_row,'screen_name',ls_screen_name1)
		lds_sql.setitem(li_row,'dw_name',ls_dw_name1)
		lds_sql.setitem(li_row,'dataobject',ls_dataobject1)
		lds_sql.setitem(li_row,'dw_sql',ls_sql)
		lds_sql.setitem(li_row,'create_date',today())
		lds_sql.setitem(li_row,'modify_date',today())
	End if
	//
next
lds_sql.update()
commit;
destroy lds_sql
destroy lds_sql1

//$<add> 11.08.2006 By: Davis
//$<reason> Fix a defect.
insert into ctx_screen(data_view_id,screen_id,tab_name,screen_name,dw_name,dataobject,description,dw_sql,create_date,modify_date)
select d.data_view_id,a.screen_id,a.tab_name,screen_name,dw_name,dataobject,description,dw_sql,create_date,modify_date from ctx_screen a,data_view d
where d.type_c = 'C' AND a.data_view_id = 1001 and d.data_view_id <> 1001
and exists(
select 1 from ctx_screen b
where data_view_id <> 1001
and a.tab_name = b.tab_name
and d.data_view_id = b.data_view_id
)
and not exists(
select 1 from ctx_screen c
where c.data_view_id <> 1001
and d.data_view_id = c.data_view_id
and a.screen_id = c.screen_id
and a.tab_name = c.tab_name
);
//$<add> 11.08.2006 By: Davis

//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 08.23.2007 By: Evan
//$<Reason> Need to destroy object.
if IsValid(lds_sql_exists) then Destroy lds_sql_exists
//---------------------------- APPEON END ----------------------------

end subroutine

public function integer of_appeon4_changes ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_contract_sqlof_appeon4_changes()
// $<arguments>(None)
// $<returns> integer
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 03.28.2007 by Jack 
//////////////////////////////////////////////////////////////////////
string 	ls_LogContent,ls_LogName
string 	ls_sql[]
long 		li_num,ll_i,ll_j,ll_contacts_rowcount,ll_contacts_numbers_rowcount,ll_EqualCount,li_MaxComid,ll_NeedProCount
long 		ll_contact_id,ll_facility_id,ll_company_id,ll_Phone,ll_Email,ll_find,ll_row,ll_FileNo,ll_OurCompanyID
string 	ls_contact_type2,ls_street_1,ls_street_2,ls_street_3,ls_city,ls_code,ls_zip,ls_ContactType,ls_find
string 	ls_company_contact_type2,ls_facility_name,ls_company_street_1,ls_company_street_2,ls_company_street_3,ls_company_city,ls_company_state,ls_company_zip
string 	ls_Phone,ls_Email
datastore lds_contact
datastore lds_company
datastore lds_contacts_numbers
Constant String ls_DefName = 'NONE'

ls_sql[upperbound(ls_sql) + 1] = "alter table app_facility add contact_type2 varchar(1) null; "
ls_sql[upperbound(ls_sql) + 1] = "alter table app_facility add corp_office_flag int null default 0; "
ls_sql[upperbound(ls_sql) + 1] = "alter table app_facility add corp_office_link int null; "
//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-07-31 By: Scofield
//$<Reason> Add street_3 column for the table app_facility and modify the address's length.
ls_sql[upperbound(ls_sql) + 1] = "alter table app_facility add street_3 varchar(150) null; "

If gs_dbtype = "ASA" Then
	ls_sql[upperbound(ls_sql) + 1] = "alter table app_facility modify facility_name varchar(150) null;"
	ls_sql[upperbound(ls_sql) + 1] = "alter table app_facility modify street varchar(150) null;"
	ls_sql[upperbound(ls_sql) + 1] = "alter table app_facility modify street_2 varchar(150) null;"
	ls_sql[upperbound(ls_sql) + 1] = "alter table app_facility modify street_3 varchar(150) null;"
else
	ls_sql[upperbound(ls_sql) + 1] = "alter table app_facility alter column facility_name varchar(150) null;"
	ls_sql[upperbound(ls_sql) + 1] = "alter table app_facility alter column street varchar(150) null;"
	ls_sql[upperbound(ls_sql) + 1] = "alter table app_facility alter column street_2 varchar(150) null;"
	ls_sql[upperbound(ls_sql) + 1] = "alter table app_facility alter column street_3 varchar(150) null;"
end if
//---------------------------- APPEON END ----------------------------
ls_sql[upperbound(ls_sql) + 1] = "alter table ctx_contacts add facility_id integer null; "

If gs_dbtype = "ASA" Then
	ls_sql[upperbound(ls_sql) + 1] = "alter table ctx_contacts modify state numeric(6) null; "
Else
	ls_sql[upperbound(ls_sql) + 1] = "alter table ctx_contacts alter column state numeric(6) null; "
End If	

//<add> 08/24/2007 by: Andy
If gs_dbtype = "ASA" Then
	ls_sql[upperbound(ls_sql) + 1] = "alter table export_header modify strip_char varchar(8) null;"
	ls_sql[upperbound(ls_sql) + 1] = "alter table conv_view modify view_name varchar(30) not null;"
	ls_sql[upperbound(ls_sql) + 1] = "alter table conv_view modify post_import_sql varchar(255) null;"
else
	ls_sql[upperbound(ls_sql) + 1] = "alter table export_header alter column strip_char varchar(8) null;"
	ls_sql[upperbound(ls_sql) + 1] = "alter table conv_view alter column view_name varchar(30) not null;"
	ls_sql[upperbound(ls_sql) + 1] = "alter table conv_view alter column post_import_sql varchar(255) null;"
end if
//end of add

//<add> 09/06/2007 by: Andy
If gs_dbtype = "ASA" Then
	ls_sql[upperbound(ls_sql) + 1] = "alter table ctx_fee_sched_nm modify custom_n1 numeric(10,3);"
	ls_sql[upperbound(ls_sql) + 1] = "alter table ctx_fee_sched_nm modify custom_n2 numeric(10,3);"
	ls_sql[upperbound(ls_sql) + 1] = "alter table ctx_fee_sched_nm modify custom_n3 numeric(10,3);"
	ls_sql[upperbound(ls_sql) + 1] = "alter table ctx_fee_sched_nm modify custom_n4 numeric(10,3);"
	ls_sql[upperbound(ls_sql) + 1] = "alter table ctx_fee_sched_nm modify custom_n5 numeric(10,3);"
else
	ls_sql[upperbound(ls_sql) + 1] = "alter table ctx_fee_sched_nm alter column custom_n1 numeric(10,3);"
	ls_sql[upperbound(ls_sql) + 1] = "alter table ctx_fee_sched_nm alter column custom_n2 numeric(10,3);"
	ls_sql[upperbound(ls_sql) + 1] = "alter table ctx_fee_sched_nm alter column custom_n3 numeric(10,3);"
	ls_sql[upperbound(ls_sql) + 1] = "alter table ctx_fee_sched_nm alter column custom_n4 numeric(10,3);"
	ls_sql[upperbound(ls_sql) + 1] = "alter table ctx_fee_sched_nm alter column custom_n5 numeric(10,3);"
end if
//end of add

//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 2007-10-22 By: Andy
//$<Reason> 
ls_sql[upperbound(ls_sql) + 1] = "alter table ctx_screen add force_update text null;"
//---------------------------- APPEON END ----------------------------

ls_sql[upperbound(ls_sql) + 1] = "alter table ctx_contacts add constraint FK_ctx_contacts_facility_id foreign key (facility_id) references app_facility (facility_id); "
ls_sql[upperbound(ls_sql) + 1] = "Update app_facility set corp_office_flag = 0 where corp_office_flag is null; "

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-08-09 By: Scofield
//$<Reason> Copy the data of street_0 to street_3,then drop column street_0
ls_sql[upperbound(ls_sql) + 1] = "Update app_facility Set street_3 = street_0  where street_3 is null;"
If gs_dbtype = "ASA" Then
	ls_sql[upperbound(ls_sql) + 1] = "alter table app_facility drop street_0;"
else
	ls_sql[upperbound(ls_sql) + 1] = "alter table app_facility drop COLUMN street_0;"
end if
//---------------------------- APPEON END ----------------------------

gnv_appeondb.of_startqueue( )

For ll_i = 1 TO upperbound(ls_sql)
	EXECUTE IMMEDIATE :ls_sql[ll_i] USING sqlca;
	Commit;
Next

gnv_appeondb.of_commitqueue( )

Select count(*) into :ll_NeedProCount from ctx_contacts where facility_id is null;
If ll_NeedProCount <= 0 Then Return 0

select max(facility_id) into :li_MaxComid from app_facility;
if IsNull(li_MaxComid) then li_MaxComid = 0

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-08-09 By: Scofield
//$<Reason> According to the new regular redo the process

update ctx_contacts set facility_id = t1.facility_id
  from app_facility t1,ctx_contract_contacts t3,ctx_basic_info t4
 where t1.facility_id = t4.app_facility and 
       t3.ctx_id = t4.ctx_id and
       t3.contact_id = ctx_contacts.contact_id and
       t3.ic_area = 'E' and
       ctx_contacts.contact_type2 = 'B'and 
       ctx_contacts.facility_id is null and
       (t1.contact_type2 is null or t1.contact_type2 = 'B') and
       (t1.street = ctx_contacts.street_1 or (t1.street is null and ctx_contacts.street_1 is null)) and 
       (t1.city = ctx_contacts.city or (t1.city is null and ctx_contacts.city is null));

update app_facility  set contact_type2 = t2.contact_type2
  from ctx_contacts t2
 where t2.facility_id = app_facility.facility_id and
       app_facility.contact_type2 is null and
       t2.contact_type2  =  'B';

 
update ctx_contacts set facility_id = t1.facility_id
  from app_facility t1,ctx_contract_contacts t3,ctx_basic_info t4
 where t1.facility_id = t4.app_facility and 
       t3.ctx_id = t4.ctx_id and
       t3.contact_id = ctx_contacts.contact_id and
       t3.ic_area = 'E' and
       ctx_contacts.contact_type2 = 'B'and 
       ctx_contacts.facility_id is null and
       (t1.contact_type2 is null or  t1.contact_type2 = 'B') and
       t1.contact like '%' + ctx_contacts.first_name + '%' + ctx_contacts.last_name + '%';

update app_facility  set contact_type2 = t2.contact_type2
  from ctx_contacts t2
 where t2.facility_id = app_facility.facility_id and
       app_facility.contact_type2 is null and
       t2.contact_type2  =  'B';


update ctx_contacts set facility_id = t1.facility_id
  from app_facility t1,ctx_contract_contacts t3,ctx_basic_info t4
 where t1.facility_id = t4.app_facility and 
       t3.ctx_id = t4.ctx_id and
       t3.contact_id = ctx_contacts.contact_id and
       t3.ic_area = 'E' and
       ctx_contacts.contact_type2 = 'B'and 
       ctx_contacts.facility_id is null and
       (t1.contact_type2 is null or t1.contact_type2 = 'B');

update app_facility  set contact_type2 = t2.contact_type2
  from ctx_contacts t2
 where t2.facility_id = app_facility.facility_id and
       app_facility.contact_type2 is null and
       t2.contact_type2  =  'B';


update ctx_contacts set ctx_contacts.facility_id = t2.facility_id
  from app_facility t2
 where t2.street = ctx_contacts.street_1 and
       t2.city = ctx_contacts.city and
       ctx_contacts.facility_id is null and
       (t2.contact_type2 is null or t2.contact_type2 = ctx_contacts.contact_type2);

update app_facility  set contact_type2 = t2.contact_type2
  from ctx_contacts t2
 where app_facility.street = t2.street_1 and
       app_facility.city = t2.city and
       t2.facility_id = app_facility.facility_id and
       app_facility.contact_type2 is null;


update ctx_contacts set facility_id = t1.facility_id
  from app_facility t1,ctx_contract_contacts t3,ctx_basic_info t4
 where t1.facility_id = t4.app_facility and 
       t3.ctx_id = t4.ctx_id and
       t3.contact_id = ctx_contacts.contact_id and
       t3.ic_area = 'C' and
       ctx_contacts.contact_type2 <> 'A'and 
       ctx_contacts.facility_id is null and
       (t1.contact_type2 is null or t1.contact_type2 = ctx_contacts.contact_type2);

update app_facility  set contact_type2 = t2.contact_type2
  from ctx_contacts t2
 where t2.facility_id = app_facility.facility_id and
       app_facility.contact_type2 is null and
       t2.contact_type2  <>  'A';
		 
Select Top 1 facility_id
  into :ll_OurCompanyID
  from app_facility
 where app_facility.facility_name = 'Our_Company';

if IsNull(ll_OurCompanyID) or ll_OurCompanyID = 0 then
	li_MaxComid++
	
	insert into app_facility(facility_id,facility_name,contact_type2) 
			values(:li_MaxComid,'Our_Company','A');
			
	ll_OurCompanyID = li_MaxComid
end if

Update ctx_contacts
   Set ctx_contacts.facility_id = :ll_OurCompanyID
 where (ctx_contacts.facility_id is null) and (ctx_contacts.contact_type2 = 'A') ;

Commit Using SQLCA ;
 
//---------------------------- APPEON END ----------------------------

lds_contact = Create datastore
lds_company = Create datastore
lds_contacts_numbers = Create datastore
lds_contact.dataobject = 'd_contacts_update'
lds_company.dataobject = 'd_company_update'
lds_contacts_numbers.dataobject = 'd_ctx_contacts_numbers_search'
lds_contact.settransobject(sqlca)
lds_company.settransobject(sqlca)
lds_contacts_numbers.settransobject(sqlca)
lds_contact.retrieve()
lds_company.retrieve()
lds_contacts_numbers.retrieve()

ls_LogContent = ""
ls_LogName = gs_dir_path + "\IntelliCred_Error.log"

ll_contacts_rowcount = lds_contact.rowcount()
if ll_contacts_rowcount <= 0 then return 0

ll_contacts_numbers_rowcount = lds_contacts_numbers.rowcount()

li_num = ll_contacts_rowcount
if Not isvalid( w_infodisp ) then open(w_infodisp)
if isvalid(w_infodisp) then w_infodisp.title = 'Update Contact and Company, Please stand by'
if isvalid(w_infodisp) then w_infodisp.Center = TRUE
if isvalid(w_infodisp) then w_infodisp.st_complete.visible = false
if isvalid(w_infodisp) then w_infodisp.st_3.visible = false
if isvalid(w_infodisp) then w_infodisp.st_information.visible = false
if isvalid(w_infodisp) then w_infodisp.st_1.text = 'Update Contact and Company, Please stand by!'
if isvalid(w_infodisp) then w_infodisp.wf_set_min_max(1,li_num)

For ll_i = 1 To ll_contacts_rowcount
	if isvalid(w_infodisp) then 
		w_infodisp.wf_step_pbar(1)
		w_infodisp.st_1.text = 'Modification ' + string(ll_i) + ' of ' + string(li_num) +' Please stand by!'
	end if
	ll_contact_id = lds_contact.getitemnumber(ll_i,'contact_id')
	ls_contact_type2 = lds_contact.getitemstring(ll_i,'contact_type2')
	ls_street_1 = Trim(lds_contact.getitemstring(ll_i,'street_1'))
	ls_street_2 = lds_contact.getitemstring(ll_i,'street_2')
	ls_street_3 = lds_contact.getitemstring(ll_i,'street_3')
	ls_city = lds_contact.getitemstring(ll_i,'city')
	ls_code = lds_contact.getitemstring(ll_i,'code')
	ls_zip = lds_contact.getitemstring(ll_i,'zip')
	
	if IsNull(ls_contact_type2) then ls_contact_type2 = ''
	if IsNull(ls_street_1) then ls_street_1 = ''
	if IsNull(ls_street_2) then ls_street_2 = ''
	if IsNull(ls_street_3) then ls_street_3 = ''
	if IsNull(ls_city) then ls_city = ''
	if IsNull(ls_code) then ls_code = ''
	if IsNull(ls_zip) then ls_zip = ''
	ll_EqualCount = 0
	ll_j = 1
	For ll_j = 1 To lds_company.rowcount()
		ll_facility_id = lds_company.getitemnumber(ll_j,'facility_id')
		ls_company_contact_type2 = lds_company.getitemstring(ll_j,'contact_type2')
		ls_facility_name = Trim(lds_company.getitemstring(ll_j,'facility_name'))
		ls_company_street_1 = Trim(lds_company.getitemstring(ll_j,'street'))
		ls_company_street_2 = lds_company.getitemstring(ll_j,'street_2')
		ls_company_street_3 = lds_company.getitemstring(ll_j,'street_3')
		ls_company_city = lds_company.getitemstring(ll_j,'city')
		ls_company_state = lds_company.getitemstring(ll_j,'state')
		ls_company_zip = lds_company.getitemstring(ll_j,'zip')

		if IsNull(ls_company_contact_type2) then ls_company_contact_type2 = ''
		if IsNull(ls_facility_name) then ls_facility_name = ''
		if IsNull(ls_company_street_1) then ls_company_street_1 = ''
		if IsNull(ls_company_street_2) then ls_company_street_2 = ''
		if IsNull(ls_company_street_3) then ls_company_street_3 = ''
		if IsNull(ls_company_city) then ls_company_city = ''
		if IsNull(ls_company_state) then ls_company_state = ''
		if IsNull(ls_company_zip) then ls_company_zip = ''
		
		if ((of_equal(ls_street_1,ls_company_street_1) = 1) or (ls_facility_name = ls_DefName and ls_street_1 = '')) and of_equal(ls_city,ls_company_city) = 1 then	
			ll_EqualCount++
			if ll_EqualCount = 1 then
				ll_company_id = ll_facility_id
				ls_ContactType = ls_company_contact_type2
			end if
		end if
	Next
	
	If ll_EqualCount = 0 Then
		ls_find = "contact_id = " + string(ll_contact_id) + " and not isnull(phone)"
		ll_find = lds_contacts_numbers.find(ls_find,1,ll_contacts_numbers_rowcount)
		ls_Phone = ''
		If ll_find > 0 Then
			ls_Phone = lds_contacts_numbers.getitemstring(ll_find,'phone')
		End If
		
		ls_find = "contact_id = " + string(ll_contact_id) + " and not isnull(contact_email)"
		ll_find = lds_contacts_numbers.find(ls_find,1,ll_contacts_numbers_rowcount)
		ls_Email = ''
		If ll_find > 0 Then
			ls_Email = lds_contacts_numbers.getitemstring(ll_find,'contact_email')
		End If
		
		li_MaxComid ++
		ls_code = Left(ls_code,2)
		ll_row = lds_company.insertrow(0)

		lds_company.setitem(ll_row,'facility_id',li_MaxComid)
		lds_company.setitem(ll_row,'contact_type2',ls_contact_type2)
		if ls_street_1 = '' then
			lds_company.setitem(ll_row,'facility_name',ls_DefName)
		else
			lds_company.setitem(ll_row,'facility_name',ls_street_1)
		end if
		lds_company.setitem(ll_row,'street',ls_street_1)
		lds_company.setitem(ll_row,'street_2',ls_street_2)
		lds_company.setitem(ll_row,'street_3',ls_street_3)
		lds_company.setitem(ll_row,'city',ls_city)
		lds_company.setitem(ll_row,'state',ls_code)
		lds_company.setitem(ll_row,'zip',ls_zip)
		lds_company.setitem(ll_row,'phone',ls_Phone)
		lds_company.setitem(ll_row,'email_address',ls_Email)
		
		lds_contact.setitem(ll_i,'facility_id',li_MaxComid)
	Else
		lds_contact.setitem(ll_i,'facility_id',ll_company_id)
		If IsNull(ls_ContactType) Or ls_ContactType = '' Then
			ls_find = "facility_id = " + string(ll_company_id)
			ll_find = lds_company.find(ls_find,1,lds_company.rowcount())
			If ll_find > 0 Then
				lds_company.setitem(ll_find,'contact_type2',ls_contact_type2)			
			End If
		ElseIf ls_ContactType <> ls_contact_type2 Then
			ls_LogContent += '['+string(today())+' '+string(now())+'] '+'The record that contact_id = '+string(ll_contact_id)+' in the ctx_contacts table map to the facility_id = ' + String(ll_company_id) + ' record in the app_facility table and have different contact_type2.~r~n'
		End If
		If ll_EqualCount > 1 Then
			ls_LogContent += '['+string(today())+' '+string(now())+'] '+'More than one record in the app_facility table map to the contact_id = ' + String(ll_contact_id) + ' record in the ctx_contacts table.~r~n'
		end if
	End if
Next

gnv_appeondb.of_startqueue( )
lds_company.update()
lds_contact.update()
gnv_appeondb.of_commitqueue( )

if ls_LogContent <> "" then
	ll_FileNo = FileOpen(ls_LogName,StreamMode!,Write!)
	FileWrite(ll_FileNo,ls_LogContent)
	FileClose(ll_FileNo)
	//MessageBox('Error','There had some errors occured,please pay attention to ' + ls_LogName,StopSign!)
	//Run("Notepad.exe " + ls_LogName)
end if

Destroy lds_company
Destroy lds_contact
Destroy lds_contacts_numbers

If isvalid(w_infodisp) Then Close(w_infodisp)


//int		li_Contact
//char		lc_ContactType
//String	ls_Contact_Street1,ls_Contact_Street2,ls_Contact_Street3,ls_Contact_City,ls_Contact_State,ls_Contact_Zip
//
//
//int 		li_Company,li_MaxComid
//char 		lc_FacType
//String	ls_Company_Street1,ls_Company_Street2,ls_Company_Street3,ls_Company_City,ls_Company_State,ls_Company_Zip	//facility_name,street,street_2,city,state,zip
//
//long		ll_Phone,ll_Email
//String	ls_Phone,ls_Email
//
//long		ll_EqualCount
//int		li_FileNo
//String	ls_LogContent,ls_LogName
//
//ls_LogContent = ""
//ls_LogName = "C:\Contractlogix_Error.log"
//
//if MessageBox('Question','Are you sure you want to perform this operation ?',Question!,YesNo!,2) <> 1 then
//	return
//end if
//
//DECLARE Contacts_Address CURSOR FOR
// SELECT CTX_CONTACTS.contact_id,
// 		  CTX_CONTACTS.contact_type2,
//        CTX_CONTACTS.street_1,
//        CTX_CONTACTS.street_2,
//        CTX_CONTACTS.street_3,
//        CTX_CONTACTS.city,
//        code_lookup.code,
//        CTX_CONTACTS.zip
//   FROM CTX_CONTACTS,code_lookup
//  WHERE CTX_CONTACTS.state = code_lookup.lookup_code
//  USING SQLCC;
//
//Open Contacts_Address;
//
//if(SQLCC.SQLCode <> 0) then
//	MessageBox('Error','The Cursor open failed!~r~n' + SQLCC.SQLErrText,StopSign!)
//	Close Contacts_Address;
//	Return
//end if
//
//Fetch Contacts_Address into :li_Contact,:lc_ContactType,:ls_Contact_Street1,:ls_Contact_Street2,:ls_Contact_Street3,:ls_Contact_City,:ls_Contact_State,:ls_Contact_Zip;
//
//do while(SQLCC.SQLCode = 0)
//	DECLARE Company_Address CURSOR FOR
//    SELECT app_facility.facility_id,
//	 		  app_facility.contact_type2,
//           app_facility.facility_name,
//           app_facility.street,
//           app_facility.street_2,
//           app_facility.city,
//           app_facility.state,
//           app_facility.zip
//      FROM app_facility
//	  USING SQLCM;
//
//	Open Company_Address;
//	
//	if(SQLCM.SQLCode <> 0) then
//		MessageBox('Error','The Cursor open failed!~r~n' + SQLCM.SQLErrText,StopSign!)
//		Close Company_Address;
//		Return
//	end if
//	
//	ll_EqualCount = 0
//	Fetch Company_Address into :li_Company,:lc_FacType,:ls_Company_Street1,:ls_Company_Street2,:ls_Company_Street3,:ls_Company_City,:ls_Company_State,:ls_Company_Zip;
//	do while(SQLCM.SQLCode = 0)
//		if(ls_Contact_Street1 = ls_Company_Street1 and ls_Contact_Street2 = ls_Company_Street2 and ls_Contact_Street3 = ls_Company_Street3 and ls_Contact_City = ls_Company_City and ls_Contact_State = ls_Company_State and ls_Contact_Zip = ls_Company_Zip) then
//			ll_EqualCount++
//			ii_Company = li_Company
//			ic_FacType = lc_FacType
//		end if
//		Fetch Company_Address into :li_Company,:lc_FacType,:ls_Company_Street1,:ls_Company_Street2,:ls_Company_Street3,:ls_Company_City,:ls_Company_State,:ls_Company_Zip;
//	loop
//	
//	Close Company_Address;
//	
//	if ll_EqualCount = 0 then
//		SELECT code_lookup.lookup_code
//    	  INTO :ll_Phone
//    	  FROM code_lookup
//   	 WHERE code_lookup.lookup_name = 'Contract Contact VIA' and code_lookup.code = 'PHONE'
//		 USING SQLCA;
//	
//		SELECT CTX_CONTACTS_NUMBERS.phone
//    	  INTO :ls_Phone
//    	  FROM CTX_CONTACTS_NUMBERS
//   	 WHERE (CTX_CONTACTS_NUMBERS.contact_id = :li_Contact) AND
//         	 (CTX_CONTACTS_NUMBERS.via = :ll_Phone)
//		 USING SQLCA;
//		
//		SELECT code_lookup.lookup_code
//    	  INTO :ll_Email
//    	  FROM code_lookup
//   	 WHERE code_lookup.lookup_name = 'Contract Contact VIA' and code_lookup.code = 'EMAIL'
//		 USING SQLCA;
//		 
//		SELECT CTX_CONTACTS_NUMBERS.contact_email
//    	  INTO :ls_Email
//    	  FROM CTX_CONTACTS_NUMBERS
//   	 WHERE (CTX_CONTACTS_NUMBERS.contact_id = :li_Contact) AND
//         	 (CTX_CONTACTS_NUMBERS.via = :ll_Email)
//		 USING SQLCA;
//				 
//		SELECT Max(facility_id)
//    	  INTO :li_MaxComid
//    	  FROM app_facility
//		 USING SQLCA;
//		 
//		if IsNull(li_MaxComid) then li_MaxComid = 0
//		
//		li_MaxComid += 1
//		
//		if IsNull(ls_Contact_Street1) then ls_Contact_Street1 = ""
//		ls_Contact_State = Left(ls_Contact_State,2)
//		
//		INSERT INTO app_facility(facility_id,contact_type2,facility_name,street,street_2,city,state,zip,phone,email_address)  
//  			  VALUES (:li_MaxComid,:lc_ContactType,:ls_Contact_Street1,:ls_Contact_Street2,:ls_Contact_Street3,:ls_Contact_City,:ls_Contact_State,:ls_Contact_Zip,:ls_Phone,:ls_Email)
//				USING SQLCA;
//		
//		UPDATE ctx_contacts
//			SET facility_id = :li_MaxComid
//		 WHERE ctx_contacts.contact_id = :li_Contact
//		 USING SQLCA;
//
//	elseif ll_EqualCount = 1 then
//		UPDATE ctx_contacts
//		   SET facility_id = :ii_Company
//		 WHERE ctx_contacts.contact_id = :li_Contact
//		 USING SQLCA;
//		
//		if IsNull(ic_FacType) then
//			UPDATE app_facility
//				SET contact_type2 = :lc_ContactType
//			 WHERE app_facility.facility_id = :ii_Company
//			 USING SQLCA;
//		elseif ic_FacType <> lc_ContactType then
//			ls_LogContent += 'More than one record in the ctx_contacts table map to the facility_id = ' + String(ii_Company) + ' record in the ctx_contacts table and have different contact_type2.~r~n'
//		end if
//	elseif ll_EqualCount > 1 then
//		ls_LogContent += 'More than one record in the app_facility table map to the contact_id = ' + String(li_Contact) + ' record in the ctx_contacts table.~r~n'
//	end if
//	
//	if ls_LogContent <> "" then
//		ROLLBACK USING SQLCA;
//	else
//		COMMIT USING SQLCA;
//	end if
//	
//	Fetch Contacts_Address into :li_Contact,:lc_ContactType,:ls_Contact_Street1,:ls_Contact_Street2,:ls_Contact_Street3,:ls_Contact_City,:ls_Contact_State,:ls_Contact_Zip;
//loop
//
//Close Contacts_Address;
//
//if ls_LogContent <> "" then
//	ROLLBACK USING SQLCA;
//	li_FileNo = FileOpen(ls_LogName,StreamMode!,Write!)
//	FileWrite(li_FileNo,ls_LogContent)
//	FileClose(li_FileNo)
//	MessageBox('Error','There had some errors occured,please pay attention to ' + ls_LogName,StopSign!)
//	Run("Notepad.exe " + ls_LogName)
//else
//	COMMIT USING SQLCA;
//	MessageBox('congratulation','The database have upgrade succeed!')
//end if

Return 0
end function

public function integer of_equal (string as_string1, string as_string2);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_contract_sqlof_equal()
// $<arguments>
//		value	string	as_string1		
//		value	string	as_string2		
// $<returns> integer
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 04.02.2007 by Jack
//////////////////////////////////////////////////////////////////////
string ls_string1,ls_string2
ls_string1 = trim(as_string1)
ls_string2 = trim(as_string2)
If right(ls_string1,1) = '.' Then ls_string1 = left(ls_string1,len(ls_string1) - 1)
If right(ls_string2,1) = '.' Then ls_string2 = left(ls_string2,len(ls_string2) - 1)
If upper(ls_string1) = upper(ls_string2) Then
	Return 1
Else
	Return 0
End If

Return 1

end function

public function integer of_register_screen (string as_dataobject, date ad_date);int li_count

li_count = upperbound(is_update_dataobject)
li_count ++

is_update_dataobject[li_count] = as_dataobject
idt_update_date[li_count] = datetime(ad_date)

return li_count
end function

public subroutine of_appeon_forceupdate_screen ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_appeon_forceupdate_screen
//
//	Arguments:  none
//
//	Returns:  none
//
//	Description:
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version	05/06/2007
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright ?2001-2006 Appeon, Inc. All rights reserved.
//
//////////////////////////////////////////////////////////////////////////////
datastore	lds_sql
string ls_sql
long ll_i,ll_count

//Add by Jack 07.18.2007
integer li_ver
//li_ver = of_get_app_setting('set_18', 'I')
select set_18 into:li_ver from icred_settings;
//End add

lds_sql = create datastore
ll_count = UpperBound(is_update_dataobject)
	
gnv_appeondb.of_startqueue( )
for ll_i = 1  to ll_count
	lds_sql.dataobject = is_update_dataobject[ll_i]
	lds_sql.SetTransobject(sqlca)
	ls_sql = lds_sql.Describe("datawindow.syntax")
	//Modify by Jack 07.18.2007
	//update ctx_screen set dw_sql = :ls_sql, modify_date = :idt_update_date[ll_i] where dataobject = :is_update_dataobject[ll_i] and modify_date < :idt_update_date[ll_i];
	If li_ver < 70 Then
		update ctx_screen set dw_sql = :ls_sql, modify_date = :idt_update_date[ll_i] where dataobject = :is_update_dataobject[ll_i];
	Else
		update ctx_screen set dw_sql = :ls_sql, modify_date = :idt_update_date[ll_i] where dataobject = :is_update_dataobject[ll_i] and modify_date < :idt_update_date[ll_i];
	End If
	//End modify
next
commit;
gnv_appeondb.of_commitqueue( )

destroy lds_sql
end subroutine

public function string of_get_view_action (string as_view_name);//////////////////////////////////////////////////////////////////////
// $<function>of_is_view_exists()
// $<arguments>
//		value	string	as_view_name		
// $<returns> string
// $<description>Determine whether the specified view already exists or not
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 05.16.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////
int  li_count


select count(1) into :li_count from sysobjects where name=:as_view_name;

IF li_count > 0  THEN
	return "ALTER VIEW "+as_view_name+" "
ELSE
	return "CREATE VIEW "+as_view_name+" "
END IF

end function

public function integer of_appeon5_changes ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_contract_sqlof_appeon5_changes()
// $<arguments>
//		value	integer		
// $<returns> integer
// $<description>
// $<description>Move data from supporting documents to documents Manager
//////////////////////////////////////////////////////////////////////
// $<add> 05.28.2007 by Jack
//////////////////////////////////////////////////////////////////////
long ll_category_temp, ll_cnt //Add by alfee 07.19.2007
long ll_doc_id,ll_doc_id1,ll_doc_id2,ll_audit_id
long i,j,k,ll_row
long ll_ctx_id,ll_category,ll_doc_status,ll_image_id,ll_revision
string ls_file_name,ls_doc_name,ls_doc_ext
datetime ldt_updated_at_date_time,ldt_update_date
decimal ldc_version

datastore lds_ctx_id
datastore lds_file_name
datastore lds_images
datastore lds_d_ctx_am_document
datastore lds_d_ctx_am_doc_audit
datastore lds_d_ctx_am_doc_image

Update code_lookup set custom_1 = code Where lookup_name = 'Contract Action Type' and custom_1 is null;  // Add by Jack 21/08/2007
//----Begin Added by alfee 07.19.2007--------------------------------------------
//If migrated before then return
ldt_update_date = datetime(date('2007-05-30'),time('00:00:01'))
Select top 1 updated_at_date_time into :ldt_updated_at_date_time from CTX_IMAGE;
If ldt_updated_at_date_time = ldt_update_date Then Return 0
//----End Added------------------------------------------------------------------

//Initilize the datastores
lds_ctx_id = Create datastore
lds_file_name = Create datastore
lds_images = Create datastore
lds_d_ctx_am_document = Create datastore
lds_d_ctx_am_doc_audit = Create datastore
lds_d_ctx_am_doc_image = Create datastore

lds_ctx_id.dataobject = 'd_migrate_ctx_id'
lds_file_name.dataobject = 'd_migrate_images_file_name'
lds_images.dataobject = 'd_cntx_images_migrate'
lds_d_ctx_am_document.dataobject = 'd_ctx_am_document_migrate'
lds_d_ctx_am_doc_audit.dataobject = 'd_ctx_am_doc_audit_migrate'
lds_d_ctx_am_doc_image.dataobject = 'd_ctx_am_doc_image_migrate'

lds_ctx_id.settransobject(sqlca)
lds_file_name.settransobject(sqlca)
lds_images.settransobject(sqlca)
lds_d_ctx_am_document.settransobject(sqlca)
lds_d_ctx_am_doc_audit.settransobject(sqlca)
lds_d_ctx_am_doc_image.settransobject(sqlca)

//Get supporting documents & initilize the document id
gnv_appeondb.of_startqueue( )
lds_ctx_id.retrieve()
lds_file_name.retrieve()
lds_images.retrieve()
Select doc_id into :ll_doc_id1 from ids;
Select max(doc_id) into :ll_doc_id2 from Ctx_am_document;
//-----Begin Modified by alfee 07.19.2007 ----------------------------------
Select Min(lookup_code) Into :ll_category_temp From code_lookup Where lookup_name = 'Contract Category'; //for unknown categroy
/*Select top 1 updated_at_date_time into :ldt_updated_at_date_time from CTX_IMAGE;
ldt_update_date = datetime(date('2007-05-30'),time('00:00:01'))
Delete from ctx_am_doc_image where modify_date = :ldt_update_date;
Delete from ctx_am_doc_audit where action_date = :ldt_update_date;
Delete from ctx_am_document where create_date  = :ldt_update_date;*/
//------End Modified ------------------------------------------------------
gnv_appeondb.of_commitqueue( )

//------Begin Commented by alfee 07.19.2007--------------------------------
/*ldt_update_date = datetime(date('2007-06-30'),time('00:00:01'))
If ldt_updated_at_date_time = ldt_update_date Then 	
	Destroy lds_ctx_id
	Destroy lds_file_name
	Destroy lds_images
	Destroy lds_d_ctx_am_document
	Destroy lds_d_ctx_am_doc_audit
	Destroy lds_d_ctx_am_doc_image
	Return 0
End If*/
//-------End Commented -----------------------------------------------------

If isnull(ll_doc_id1) Then ll_doc_id1 = 0
If isnull(ll_doc_id2) Then ll_doc_id2 = 0
If ll_doc_id1 >= ll_doc_id2 Then
	ll_doc_id = ll_doc_id1 + 1
Else
	ll_doc_id = ll_doc_id2 + 1
End If
gnv_data.of_retrieve('code_lookup')
ll_doc_status = Long(gnv_data.of_getitem( 'code_lookup', 'lookup_code', "upper(lookup_name) = upper('Contract Document Status') and upper(code) = 'APPROVED'"))

//Put supporting documents
For i = 1 To lds_ctx_id.rowcount()
	ll_ctx_id = lds_ctx_id.getitemnumber(i,'ctx_id')
	ll_category = lds_ctx_id.getitemnumber(i,'category')
	//--------Begin Modified by alfee 07.19.2007-----------------------------------
	//If isnull(ll_category) or ll_category = 0 Then ll_category = 115009
	If isnull(ll_category) or ll_category = 0 Then ll_category = ll_category_temp 
	//--------End Modified --------------------------------------------------------
	
	lds_file_name.setfilter("ctx_id = " + string(ll_ctx_id))
	lds_file_name.filter()
	
	For j = 1 To lds_file_name.rowcount()
		ls_file_name = lds_file_name.getitemstring(j,'file_name')
		lds_images.setfilter("ctx_id = " + string(ll_ctx_id) + " and file_name = '" + ls_file_name + "'")
		lds_images.filter()
		ls_doc_name = mid(ls_file_name,1,lastpos(ls_file_name,'.') - 1)
		ls_doc_ext = mid(ls_file_name,lastpos(ls_file_name,'.') + 1,3)
		
		ll_audit_id = 1
		ldc_version = 1.0
		For k = 1 To lds_images.rowcount()
			
			ll_row = lds_d_ctx_am_doc_audit.insertrow(0)
			lds_d_ctx_am_doc_audit.setitem(ll_row,'doc_id',ll_doc_id)
			lds_d_ctx_am_doc_audit.setitem(ll_row,'audit_id',ll_audit_id)
			//lds_d_ctx_am_doc_audit.setitem(ll_row,'revision',lds_images.getitemnumber(k,'image_version'))
			lds_d_ctx_am_doc_audit.setitem(ll_row,'revision',ldc_version)
			lds_d_ctx_am_doc_audit.setitem(ll_row,'doc_ext',ls_doc_ext)
			If k = 1 Then
				lds_d_ctx_am_doc_audit.setitem(ll_row,'action','New-Existing')
			Else
				lds_d_ctx_am_doc_audit.setitem(ll_row,'action','Modified')
			End If				
			lds_d_ctx_am_doc_audit.setitem(ll_row,'action_by',lds_images.getitemstring(k,'ctx_image_inserted_by_user'))				
			//lds_d_ctx_am_doc_audit.setitem(ll_row,'action_date',ldt_update_date)
			lds_d_ctx_am_doc_audit.setitem(ll_row,'action_date',lds_images.getitemdatetime(k,'ctx_image_updated_at_date_time'))
			lds_d_ctx_am_doc_audit.setitem(ll_row,'notes','Imported from Support Document')
			ll_audit_id++
			
			ll_row = lds_d_ctx_am_doc_image.insertrow(0)
			lds_d_ctx_am_doc_image.setitem(ll_row,'doc_id',ll_doc_id)
			//lds_d_ctx_am_doc_image.setitem(ll_row,'revision',lds_images.getitemnumber(k,'image_version'))
			lds_d_ctx_am_doc_image.setitem(ll_row,'revision',ldc_version)
			
			lds_d_ctx_am_doc_image.setitem(ll_row,'image_version',lds_images.getitemnumber(k,'image_version')) //Add by Jack 07.17.2007
			//lds_d_ctx_am_doc_image.setitem(ll_row,'modify_date',ldt_update_date)
			lds_d_ctx_am_doc_image.setitem(ll_row,'modify_date',lds_images.getitemdatetime(k,'ctx_image_updated_at_date_time'))
			lds_d_ctx_am_doc_image.setitem(ll_row,'doc_ext',ls_doc_ext)
			lds_d_ctx_am_doc_image.setitem(ll_row,'image_id',lds_images.getitemnumber(k,'image_id'))
			lds_d_ctx_am_doc_image.setitem(ll_row,'ctx_id',ll_ctx_id)
						
			If k = lds_images.rowcount() Then
				ll_row = lds_d_ctx_am_document.insertrow(0)
				lds_d_ctx_am_document.setitem(ll_row,'doc_id',ll_doc_id)
				lds_d_ctx_am_document.setitem(ll_row,'ctx_id',ll_ctx_id)
				//lds_d_ctx_am_document.setitem(ll_row,'doc_name',ls_file_name) //by alfee 08.22.2007
				lds_d_ctx_am_document.setitem(ll_row,'doc_name',ls_doc_name)
				//lds_d_ctx_am_document.setitem(ll_row,'revision',lds_images.getitemnumber(k,'image_version'))
				lds_d_ctx_am_document.setitem(ll_row,'revision',ldc_version)
				lds_d_ctx_am_document.setitem(ll_row,'doc_ext',ls_doc_ext)
				lds_d_ctx_am_document.setitem(ll_row,'doc_type',"Buy")
				lds_d_ctx_am_document.setitem(ll_row,'category',ll_category)
				lds_d_ctx_am_document.setitem(ll_row,'base_type','3')
				lds_d_ctx_am_document.setitem(ll_row,'create_by',lds_images.getitemstring(k,'ctx_image_inserted_by_user'))				
				//lds_d_ctx_am_document.setitem(ll_row,'create_date',ldt_update_date)
				lds_d_ctx_am_document.setitem(ll_row,'create_date',lds_images.getitemdatetime(k,'ctx_image_inserted_at_date_time'))
				lds_d_ctx_am_document.setitem(ll_row,'status',ll_doc_status)
				lds_d_ctx_am_document.setitem(ll_row,'status_by',lds_images.getitemstring(k,'ctx_image_inserted_by_user'))				
				//lds_d_ctx_am_document.setitem(ll_row,'status_date',ldt_update_date)
				lds_d_ctx_am_document.setitem(ll_row,'status_date',lds_images.getitemdatetime(k,'ctx_image_updated_at_date_time'))
				lds_d_ctx_am_document.setitem(ll_row,'notes',lds_images.getitemstring(k,'page_description'))
				lds_d_ctx_am_document.setitem(ll_row,'checkout_status','0')
				//lds_d_ctx_am_document.setitem(ll_row,'revision_control','0')
				lds_d_ctx_am_document.setitem(ll_row,'revision_control','1')
				ll_doc_id++
			End If
			ldc_version = ldc_version + 0.1		
		Next		
	Next		
Next
If lds_d_ctx_am_document.update() <> 1 Then 
	Destroy lds_ctx_id
	Destroy lds_file_name
	Destroy lds_images
	Destroy lds_d_ctx_am_document
	Destroy lds_d_ctx_am_doc_audit
	Destroy lds_d_ctx_am_doc_image	
	Return 0
End If
gnv_appeondb.of_startqueue( )
lds_d_ctx_am_doc_audit.update()
lds_d_ctx_am_doc_image.update()
Update ids set doc_id = :ll_doc_id;
Update CTX_IMAGE set updated_at_date_time = :ldt_update_date;
gnv_appeondb.of_commitqueue( )

//Put document images
//----------Begin Modified by alfee 07.19.2007--------------------------------
ll_cnt = lds_d_ctx_am_doc_image.rowcount()
If Not isvalid( w_infodisp ) Then Open(w_infodisp)
If isvalid(w_infodisp) Then 
	w_infodisp.title = 'Migrate supporting documents, Please stand by'
	w_infodisp.Center = TRUE
	w_infodisp.st_complete.visible = false
	w_infodisp.st_3.visible = false
	w_infodisp.st_information.visible = false
	w_infodisp.st_1.text = 'Migrate supporting documents, Please stand by!'
	w_infodisp.wf_set_min_max(1,ll_cnt)
End if

For i = 1 To ll_cnt
	If isvalid(w_infodisp) Then 
		w_infodisp.wf_step_pbar(1)
		w_infodisp.st_1.text = 'Modification ' + string(i) + ' of ' + string(ll_cnt)+' Please stand by!'
	End If
//For i = 1 To lds_d_ctx_am_doc_image.rowcount()
//---------End Modified -------------------------------------------------------	
	ll_ctx_id = lds_d_ctx_am_doc_image.getitemnumber(i,'ctx_id')
	ll_image_id = lds_d_ctx_am_doc_image.getitemnumber(i,'image_id')
	//ll_revision = lds_d_ctx_am_doc_image.getitemnumber(i,'revision')	
	//---------Begin Modified by Alfee 08.27.2007-------------------------
	//ldc_version = lds_d_ctx_am_doc_image.getitemnumber(i,'revision')//Add by Jack 07.17.2007
	ldc_version = lds_d_ctx_am_doc_image.getitemdecimal(i,'revision')
	//---------End Modified -----------------------------------------------
	ll_revision = lds_d_ctx_am_doc_image.getitemnumber(i,'image_version')//Add by Jack 07.17.2007
	ll_doc_id = lds_d_ctx_am_doc_image.getitemnumber(i,'doc_id')
	of_get_image_file(ll_image_id,ll_ctx_id,ll_revision,ll_doc_id,ldc_version)
Next	

If isvalid( w_infodisp ) Then Close(w_infodisp) //Added by alfee 07.19.2007

Destroy lds_ctx_id
Destroy lds_file_name
Destroy lds_images
Destroy lds_d_ctx_am_document
Destroy lds_d_ctx_am_doc_audit
Destroy lds_d_ctx_am_doc_image

Return 1
end function

public function string of_addobjects (ref datastore ads_source, datastore ads_target);/********************************************************************
Function  : of_addobjects(ref datastore ads_source,datastore ads_target) 
			   returns string
arguements: ref datastore ads_source
			      datastore ads_target
describe  : if the object exists in the ads_target, but it not exists in the ads_source, 
			   then add it to the ads_source.
Author    : Andy 07/03/2007
********************************************************************/
String  ls_sObjects, ls_tObjects
String  ls_sObjectlist[],ls_tObjectlist[]
String  ls_ObjName
long    ll_i,ll_j,ll_sObjcount,ll_tObjcount
boolean lb_Flag
String  ls_Type,ls_Attributes
String  ls_Err,ls_Modify
String  ls_Syntax,ls_prefix
Long    ll_Pos,ll_sPos,ll_ePos

ls_sObjects  = ads_source.Describe("DataWindow.Objects")
ll_sObjcount = inv_string.of_parsetoarray(ls_sObjects,'~t',ls_sObjectlist)

ls_tObjects  = ads_target.Describe("DataWindow.Objects")
ll_tObjcount = inv_string.of_parsetoarray(ls_tObjects,'~t',ls_tObjectlist)

for ll_i = 1 to ll_tObjcount
	ls_ObjName = ls_tObjectlist[ll_i]
	ls_Type    = ads_target.Describe(ls_ObjName + ".type")
	
	//Process compute,text only
	if ls_Type = 'compute' OR ls_Type = 'text' then 		
		lb_Flag    = False
		for ll_j = 1 to ll_sObjcount
			if lower(ls_sObjectlist[ll_j]) = lower(ls_ObjName) then 
				lb_Flag = True//exist in ads_source
				exit
			end if
		next
		//Not exist
		if Not lb_Flag then
			ls_Syntax = ads_target.Describe("DataWindow.Syntax")
			ll_Pos = pos(ls_Syntax,"name=" + ls_ObjName)
			
			ls_prefix = MID(ls_Syntax,1,ll_Pos - 1)
			if ls_Type = 'compute' then ll_sPos   = of_pos(ls_prefix,"~r~ncompute(",len(ls_prefix)) 
			if ls_Type = 'text'    then ll_sPos   = of_pos(ls_prefix,"~r~ntext(",len(ls_prefix))
			
			ll_ePos   = pos(ls_Syntax,")~r~n",ll_Pos)
			if ls_Type = 'compute' then ls_Attributes = MID(ls_Syntax,ll_sPos + 10,ll_ePos - ll_sPos - 10 )
			if ls_Type = 'text'    then ls_Attributes = MID(ls_Syntax,ll_sPos + 7,ll_ePos - ll_sPos - 7 )	

			if ls_Type = 'compute' then ls_Modify = "create compute("			
			if ls_Type = 'text'    then ls_Modify = "create text("
			
			ls_Modify = ls_Modify + ls_Attributes + ")"
			ls_Err= ads_source.Modify(ls_Modify)
		end if
		
	end if
next
	
return ads_source.Describe("DataWindow.Syntax")

end function

public function long of_pos (string as_source, string as_target, long al_start);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Pos	
//
//	Access:  		public
//
//	Arguments:
//	as_Source		The string being searched.
//	as_Target		The being searched for.
//	al_start			The starting position, 0 means start at the end.
//
//	Returns:  		Long	
//						The position of as_Target.
//						If as_Target is not found, function returns a 0.
//						If any argument's value is NULL, function returns NULL.
//
//	Description: 	Search backwards through a string to find the last occurrence 
//						of another string.
// Author     :   Andy 07/03/2007
//////////////////////////////////////////////////////////////////////////////

Long	ll_Cnt, ll_Pos

//Check for Null Parameters.
IF IsNull(as_source) or IsNull(as_target) or IsNull(al_start) Then
	SetNull(ll_Cnt)
	Return ll_Cnt
End If

//Check for an empty string
If Len(as_Source) = 0 Then
	Return 0
End If

// Check for the starting position, 0 means start at the end.
If al_start=0 Then  
	al_start=Len(as_Source)
End If

//Perform find
For ll_Cnt = al_start to 1 Step -80
	ll_Pos = Pos(as_Source, as_Target, ll_Cnt)
	If ll_Pos > 0 and ll_Pos <= al_start Then 
		//String was found
		Return ll_Pos
	End If
Next

//String was not found
Return 0

end function

public function string of_set_view_sql (string as_viewname, string as_tag);//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 2007.07.03 By: Scofield
//$<Reason> reduce the code in of_appeon1_changes function

String	ls_sql

if as_viewname = 'v_ctx_basic_info' then
	ls_sql = of_get_view_action('v_ctx_basic_info') + "~r~n" + &
	"as SELECT ~r~n" + &
	"	app_facility.facility_name AS Company_Name, ~r~n" + &
	"	app_facility.street AS Company_street_1,~r~n" + &
	"	app_facility.street_2 AS Company_street_2,~r~n" + &
	"	app_facility.city AS Company_city,~r~n" + &
	"	app_facility.state AS Company_state,~r~n" + &
	"	app_facility.zip AS Company_zip,~r~n" + &
	"	app_facility.country AS Company_country,~r~n" + &
	"	app_facility.phone AS Company_phone,~r~n" + &
	"	app_facility.fax AS Company_fax,~r~n" + &
	"	app_facility.web_address AS Company_web_address,~r~n" + &
	"	app_facility.contact_type2 AS Company_contact_type2,~r~n" + &
	"	app_facility.corp_office_flag AS Company_corp_office_flag,~r~n" + &
	"	app_facility.corp_office_link AS Company_corp_office_link,~r~n" + &
	"	code_lookup.code AS Contract_Category_code, ~r~n" + &
	"	code_lookup.description AS Contract_Category_description, ~r~n" + &
	"	code_lookup_1.code AS Contract_Status_code, ~r~n" + &
	"	code_lookup_2.code AS contract_type_code, ~r~n" + &
	"	code_lookup_2.description AS contract_type_Description, ~r~n" + &
	"	code_lookup_3.code AS term_reason_code, ~r~n" + &
	"	code_lookup_3.description AS term_Reason_Desciption, ~r~n" + &
	"	code_lookup_4.description AS product_type_desc, ~r~n" + &
	"	code_lookup_4.code AS product_type_code, ~r~n" + &
	"	code_lookup_5.code AS product_code, ~r~n" + &
	"	code_lookup_5.description AS product_description, ~r~n" + &
	"	ctx_basic_info.ctx_id,   ~r~n" + &
	"	ctx_basic_info.category,   ~r~n" + &
	"	ctx_basic_info.status,   ~r~n" + &
	"	ctx_basic_info.facility_id,   ~r~n" + &
	"	ctx_basic_info.contract_type,   ~r~n" + &
	"	ctx_basic_info.product_type,   ~r~n" + &
	"	ctx_basic_info.product_name,   ~r~n" + &
	"	ctx_basic_info.reimbursment_menth,   ~r~n" + &
	"	ctx_basic_info.file_location,   ~r~n" + &
	"	ctx_basic_info.effective_date,   ~r~n" + &
	"	ctx_basic_info.expriation_date,   ~r~n" + &
	"	ctx_basic_info.review_date,   ~r~n" + &
	"	ctx_basic_info.review_by,   ~r~n" + &
	"	ctx_basic_info.term_date,   ~r~n" + &
	"	ctx_basic_info.term_reason,   ~r~n" + &
	"	ctx_basic_info.last_revis_date,   ~r~n" + &
	"	ctx_basic_info.other_date_1,   ~r~n" + &
	"	ctx_basic_info.other_date_2,   ~r~n" + &
	"	ctx_basic_info.oc_signed_by,   ~r~n" + &
	"	ctx_basic_info.oc_title,   ~r~n" + &
	"	ctx_basic_info.oc_department,   ~r~n" + &
	"	ctx_basic_info.oc_legal_rep,   ~r~n" + &
	"	ctx_basic_info.cc_signed_by,   ~r~n" + &
	"	ctx_basic_info.cc_title,   ~r~n" + &
	"	ctx_basic_info.cc_department,   ~r~n" + &
	"	ctx_basic_info.cc_legal_rep,   ~r~n" + &
	"	ctx_basic_info.keyword,   ~r~n" + &
	"	ctx_basic_info.dvision,   ~r~n" + &
	"	ctx_basic_info.custom_1,   ~r~n" + &
	"	ctx_basic_info.custom_2,   ~r~n" + &
	"	ctx_basic_info.custom_3,   ~r~n" + &
	"	ctx_basic_info.custom_4,   ~r~n" + &
	"	ctx_basic_info.custom_5,   ~r~n" + &
	"	ctx_basic_info.custom_6,   ~r~n" + &
	"	ctx_basic_info.custom_7,   ~r~n" + &
	"	ctx_basic_info.custom_8,   ~r~n" + &
	"	ctx_basic_info.custom_9,   ~r~n" + &
	"	ctx_basic_info.custom_10,   ~r~n" + &
	"	ctx_basic_info.group_multi_loc_id,   ~r~n" + &
	"	ctx_basic_info.revision_reason,   ~r~n" + &
	"	ctx_basic_info.group_id,   ~r~n" + &
	"	ctx_basic_info.record_id,   ~r~n" + &
	"	ctx_basic_info.custom_11,   ~r~n" + &
	"	ctx_basic_info.custom_12,   ~r~n" + &
	"	ctx_basic_info.custom_13,   ~r~n" + &
	"	ctx_basic_info.custom_14,   ~r~n" + &
	"	ctx_basic_info.custom_15,   ~r~n" + &
	"	ctx_basic_info.custom_16,   ~r~n" + &
	"	ctx_basic_info.custom_17,   ~r~n" + &
	"	ctx_basic_info.custom_18,   ~r~n" + &
	"	ctx_basic_info.custom_19,   ~r~n" + &
	"	ctx_basic_info.custom_20,   ~r~n" + &
	"	ctx_basic_info.custom_date1,   ~r~n" + &
	"	ctx_basic_info.custom_date2,   ~r~n" + &
	"	ctx_basic_info.custom_date3,   ~r~n" + &
	"	ctx_basic_info.custom_date4,   ~r~n" + &
	"	ctx_basic_info.custom_date5,   ~r~n" + &
	"	ctx_basic_info.custom_date6,   ~r~n" + &
	"	ctx_basic_info.custom_date7,   ~r~n" + &
	"	ctx_basic_info.custom_date8,   ~r~n" + &
	"	ctx_basic_info.custom_date9,   ~r~n" + &
	"	ctx_basic_info.custom_date10,   ~r~n" + &
	"	ctx_basic_info.custom_n1,   ~r~n" + &
	"	ctx_basic_info.custom_n2,   ~r~n" + &
	"	ctx_basic_info.custom_n3,   ~r~n" + &
	"	ctx_basic_info.custom_n4,   ~r~n" + &
	"	ctx_basic_info.custom_n5,   ~r~n" + &
	"	ctx_basic_info.custom_n6,   ~r~n" + &
	"	ctx_basic_info.custom_n7,   ~r~n" + &
	"	ctx_basic_info.custom_n8,   ~r~n" + &
	"	ctx_basic_info.custom_n9,   ~r~n" + &
	"	ctx_basic_info.custom_n10,   ~r~n" + &
	"	ctx_basic_info.version_number,   ~r~n" + &
	"	ctx_basic_info.version_date,   ~r~n" + &
	"	ctx_basic_info.notes,   ~r~n" + &
	"	ctx_basic_info.app_facility,  ~r~n" + &
	"	ctx_basic_info.master_contract_id AS master_ctx_id, ~r~n" + &
	"	ctx_basic_info.master_contract_name,~r~n" + &
	"	code_lookup_6.code as dvision_code, ~r~n" + &
	"	code_lookup_6.description as dvision_description~r~n" + &
	"FROM (((((((ctx_basic_info ~r~n" + &
	"LEFT OUTER JOIN code_lookup ON ctx_basic_info.category = code_lookup.lookup_code) ~r~n" + &
	"LEFT OUTER JOIN code_lookup AS code_lookup_1 ON ctx_basic_info.status = code_lookup_1.lookup_code) ~r~n" + &
	"LEFT OUTER JOIN code_lookup AS code_lookup_2 ON ctx_basic_info.contract_type = code_lookup_2.lookup_code) ~r~n" + &
	"LEFT OUTER JOIN code_lookup AS code_lookup_3 ON ctx_basic_info.term_reason = code_lookup_3.lookup_code) ~r~n" + &
	"INNER JOIN app_facility ON ctx_basic_info.app_facility = app_facility.facility_id) ~r~n" + &
	"INNER JOIN ctx_products ON ctx_basic_info.ctx_id = ctx_products.ctx_id) ~r~n" + &
	"LEFT OUTER JOIN code_lookup AS code_lookup_4 ON ctx_products.product_type = code_lookup_4.lookup_code) ~r~n" + &
	"LEFT OUTER JOIN code_lookup AS code_lookup_5 ON ctx_products.product_id = code_lookup_5.lookup_code~r~n" + &
	"left outer join code_lookup as code_lookup_6 on ctx_basic_info.dvision = code_lookup_6.lookup_code~r~n" + as_tag
elseif as_viewname = 'v_ctx_basic_info_master_link' then
	ls_sql = of_get_view_action( 'v_ctx_basic_info_master_link') +" as SELECT " + &
	"CTX_BASIC_INFO.ctx_id, " + &
	"app_facility.facility_name AS Company_Name, " + &
	"app_facility.street AS Company_street_1," + &
	"app_facility.street_2 AS Company_street_2," + &
	"app_facility.city AS Company_city," + &
	"app_facility.state AS Company_state," + &
	"app_facility.zip AS Company_zip," + &
	"app_facility.country AS Company_country," + &
	"app_facility.phone AS Company_phone," + &
	"app_facility.fax AS Company_fax," + &
	"app_facility.web_address AS Company_web_address," + &
	"app_facility.contact_type2 AS Company_contact_type2," + &
	"app_facility.corp_office_flag AS Company_corp_office_flag," + &
	"app_facility.corp_office_link AS Company_corp_office_link," + &
	"code_lookup.code AS Contract_Category_code, " + &
	"code_lookup.description AS Contract_Category_description, " + &
	"code_lookup_1.code AS Contract_Status_code, " + &
	"code_lookup_2.code AS contract_type_code, " + &
	"code_lookup_2.description AS contract_type_Description, " + &
	"CTX_BASIC_INFO.effective_date, " + &
	"CTX_BASIC_INFO.expriation_date, " + &
	"CTX_BASIC_INFO.review_date, " + &
	"CTX_BASIC_INFO.review_by, " + &
	"CTX_BASIC_INFO.term_date, " + &
	"code_lookup_3.code AS term_reason_code, " + &
	"code_lookup_3.description AS term_Reason_Desciption, " + &
	"CTX_BASIC_INFO.other_date_1, " + &
	"CTX_BASIC_INFO.other_date_2, " + &
	"CTX_BASIC_INFO.notes, " + &
	"CTX_BASIC_INFO.custom_1, " + &
	"CTX_BASIC_INFO.custom_2, " + &
	"CTX_BASIC_INFO.custom_3, " + &
	"CTX_BASIC_INFO.custom_4, " + &
	"CTX_BASIC_INFO.custom_5, " + &
	"CTX_BASIC_INFO.custom_6, " + &
	"CTX_BASIC_INFO.custom_7, " + &
	"CTX_BASIC_INFO.custom_8, " + &
	"CTX_BASIC_INFO.custom_9, " + &
	"CTX_BASIC_INFO.custom_10, " + &
	"CTX_BASIC_INFO.last_revis_date, " + &
	"code_lookup_4.description AS product_type_desc, " + &
	"code_lookup_4.code AS product_type_code, " + &
	"code_lookup_5.code AS product_code, " + &
	"code_lookup_5.description AS product_description " + &
	"FROM (((((((CTX_BASIC_INFO LEFT OUTER JOIN code_lookup ON CTX_BASIC_INFO.category = code_lookup.lookup_code) " + &
	"LEFT OUTER JOIN code_lookup AS code_lookup_1 ON CTX_BASIC_INFO.status = code_lookup_1.lookup_code) " + &
	"LEFT OUTER JOIN code_lookup AS code_lookup_2 ON CTX_BASIC_INFO.contract_type = code_lookup_2.lookup_code) " + &
	"LEFT OUTER JOIN code_lookup AS code_lookup_3 ON CTX_BASIC_INFO.term_reason = code_lookup_3.lookup_code) " + &
	"INNER JOIN app_facility ON CTX_BASIC_INFO.app_facility = app_facility.facility_id) " + &
	"INNER JOIN ctx_products ON CTX_BASIC_INFO.ctx_id = ctx_products.ctx_id) " + &
	"LEFT OUTER JOIN code_lookup AS code_lookup_4 ON ctx_products.product_type = code_lookup_4.lookup_code) " + &
	"LEFT OUTER JOIN code_lookup AS code_lookup_5 ON ctx_products.product_id = code_lookup_5.lookup_code" + as_tag
end if

return ls_sql

//---------------------------- APPEON END ----------------------------

end function

public function integer of_get_image_file (long al_image_id, long al_ctx_id, long al_version, long al_doc_id, decimal adc_version_new);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_contract_sqlof_get_image_file()
// $<arguments>
//		value	long	al_image_id		
//		value	long	al_ctx_id  		
//		value	long	al_version 		
//		value	long	al_doc_id  		
// $<returns> integer
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 05.29.2007 by Jack
//////////////////////////////////////////////////////////////////////
Blob  lb_image_data,lb_data,lb_all_data
long ll_data_length,ll_start
int li_loops,li_counter

IF appeongetclienttype() = 'PB' AND gs_dbtype = 'SQL' THEN
	SELECT Datalength(image_file) INTO :ll_data_length FROM CTX_IMAGE
	  WHERE image_id = :al_image_id AND ctx_id = :al_ctx_id AND image_version = :al_version;
	
	IF ll_data_length = 0 OR Isnull(ll_data_length) THEN
		RETURN 0
	END IF
	
	IF ll_data_length > 8000 THEN 
		 IF Mod(ll_data_length,8000) = 0 THEN 
			  li_loops = ll_data_length/8000 
		 ELSE 
			  li_loops = (ll_data_length/8000) + 1 
		 END IF 
	ELSE 
		 li_loops = 1 
	END IF 
	
	FOR li_counter = 1 to li_loops
		ll_start = (li_counter - 1) * 8000 + 1
		
		SELECTBLOB substring(image_file,:ll_start,8000) INTO :lb_data
		  FROM CTX_IMAGE WHERE image_id = :al_image_id AND ctx_id = :al_ctx_id AND image_version = :al_version;
	
		lb_all_data += lb_data
	NEXT 
	
	lb_image_data = lb_all_data
ELSE
	SELECTBLOB image_file INTO :lb_image_data
	  FROM CTX_IMAGE WHERE image_id = :al_image_id AND ctx_id = :al_ctx_id AND image_version = :al_version;
END IF

IF Isnull(lb_image_data) THEN
	RETURN 0
END IF

UPDATEBLOB ctx_am_doc_image SET image_file = :lb_image_data 
  WHERE doc_id = :al_doc_id AND revision = :adc_version_new;

Return 1
end function

public function integer of_update_view_v6_1 ();//////////////////////////////////////////////////////////////////////
// $<function>		n_cst_contract_sql.of_update_view_v6_1()
// $<arguments> 	None
// $<returns> 		integer
// $<description>	Update the view's sql
// $<add> 			07.23.2007 by Scofield
//////////////////////////////////////////////////////////////////////

String	ls_sql,ls_tag,ls_Title

IF gs_dbtype = "ASA" THEN 
	ls_tag = "; "
	ls_Title = "TOP 50000000"
ELSE
	ls_Title = "top 100 percent"
END IF

ls_sql = of_get_view_action('v_acedemic_appointments') + "~r~n" + &
"as select " + ls_Title + " pd_acedemic_appointments.rec_id,~r~n" + &
"pd_acedemic_appointments.prac_id,~r~n" + &
"school_code=address_lookup.code,~r~n" + &
"school_name=address_lookup.entity_name,~r~n" + &
"pd_acedemic_appointments.month_from,~r~n" + &
"pd_acedemic_appointments.year_from,~r~n" + &
"pd_acedemic_appointments.month_thru,~r~n" + &
"pd_acedemic_appointments.year_thru,~r~n" + &
"achdmc_dept_code=code_lookup_a.code,~r~n" + &
"a_dept_description=code_lookup_a.description,~r~n" + &
"faculty_rank=code_lookup_b.code,faculty_rank_code=code_lookup_b.description ~r~n" + &
"from(((pd_acedemic_appointments left outer join address_lookup on pd_acedemic_appointments.school_code = address_lookup.lookup_code) ~r~n" + &
"left outer join code_lookup as code_lookup_a on pd_acedemic_appointments.department_code = code_lookup_a.lookup_code) ~r~n" + &
"left outer join code_lookup as code_lookup_b on pd_acedemic_appointments.faculty_rank_code = code_lookup_b.lookup_code)~r~n" + &
"order by pd_acedemic_appointments.rec_id,pd_acedemic_appointments.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_action_items') + "~r~n" + &
"as select distinct " + ls_Title + "~r~n" + &
"verif_info.prac_id,~r~n" + &
"verif_info.facility_id,~r~n" + &
"facility.facility_name,~r~n" + &
"data_view_screen.screen_name,~r~n" + &
"verif_info.reference_value,~r~n" + &
"verification_method=code_lookup_b.code,~r~n" + &
"verif_info.first_sent,~r~n" + &
"verif_info.last_sent,~r~n" + &
"verif_info.number_sent,~r~n" + &
"verif_info.date_recieved,~r~n" + &
"verif_info.user_name,~r~n" + &
"response_code=code_lookup_a.code,~r~n" + &
"verif_info.active_status,~r~n" + &
"verif_info.print_flag,~r~n" + &
"verif_info.doc_id,~r~n" + &
"verif_info.notes ~r~n" + &
"from((verif_info left outer join code_lookup as code_lookup_a on verif_info.response_code = code_lookup_a.lookup_code) ~r~n" + &
"left outer join code_lookup as code_lookup_b on verif_info.verification_method = code_lookup_b.lookup_code),facility,data_view_screen ~r~n" + &
"where(verif_info.screen_id = data_view_screen.screen_id) ~r~n" + &
"and(verif_info.facility_id = facility.facility_id) ~r~n" + &
"and((data_view_screen.data_view_id = 1))~r~n" + &
"order by verif_info.prac_id,verif_info.facility_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_address') + "~r~n" + &
"  as select " + ls_Title + " pd_address.rec_id,~r~n" + &
"    pd_address.prac_id,~r~n" + &
"    practitioner=pd_basic.first_name+pd_basic.last_name,~r~n" + &
"    office_in_home=code_lookup_b.code,~r~n" + &
"    prac_type_code=code_lookup_d.code,~r~n" + &
"    prac_type=code_lookup_d.description,~r~n" + &
"    pd_address.street,~r~n" + &
"    pd_address.city,~r~n" + &
"    state_code=code_lookup_e.code,~r~n" + &
"    state_name=code_lookup_e.description,~r~n" + &
"    country_code=code_lookup_f.code,~r~n" + &
"    country_name=code_lookup_f.description,~r~n" + &
"    pd_address.pager_number,~r~n" + &
"    pd_address.phone,~r~n" + &
"    pd_address.ext,~r~n" + &
"    pd_address.fax,~r~n" + &
"    pd_address.zip,~r~n" + &
"    county_code=code_lookup_g.code,~r~n" + &
"    county_name=code_lookup_g.description,~r~n" + &
"    pd_address.contact_person,~r~n" + &
"    pd_address.tax_id,~r~n" + &
"    pd_address.tax_id_other_1,~r~n" + &
"    pd_address.tax_id_other_2,~r~n" + &
"    pd_address.business_mgr,~r~n" + &
"    pd_address.office_mgr,~r~n" + &
"    pd_address.e_mail_address,~r~n" + &
"    pd_address.web_address,~r~n" + &
"    pd_address.mon_from,~r~n" + &
"    pd_address.mon_to,~r~n" + &
"    pd_address.tue_from,~r~n" + &
"    pd_address.tue_to,~r~n" + &
"    pd_address.wed_from,~r~n" + &
"    pd_address.thu_from,~r~n" + &
"    pd_address.thu_to,~r~n" + &
"    pd_address.fri_from,~r~n" + &
"    pd_address.fri_to,~r~n" + &
"    pd_address.sat_from,~r~n" + &
"    pd_address.sat_to,~r~n" + &
"    pd_address.sun_from,~r~n" + &
"    pd_address.sun_to,~r~n" + &
"    pd_address.mon_from2,~r~n" + &
"    pd_address.mon_to2,~r~n" + &
"    pd_address.tue_from2,~r~n" + &
"    pd_address.tue_to2,~r~n" + &
"    pd_address.wed_from2,~r~n" + &
"    pd_address.wed_to2,~r~n" + &
"    pd_address.thu_from2,~r~n" + &
"    pd_address.thu_to2,~r~n" + &
"    pd_address.fri_from2,~r~n" + &
"    pd_address.fri_to2,~r~n" + &
"    pd_address.sat_from2,~r~n" + &
"    pd_address.sat_to2,~r~n" + &
"    pd_address.sun_from2,~r~n" + &
"    pd_address.sun_to2,~r~n" + &
"    pd_address.wed_to,~r~n" + &
"    pd_address.routine_visit_appt,~r~n" + &
"    pd_address.urgent_visit_appt,~r~n" + &
"    pd_address.emergency_visit_appt,~r~n" + &
"    pd_address.non_emergency_appt,~r~n" + &
"    young_child_code=code_lookup_h.code,~r~n" + &
"    child_code=code_lookup_i.code,~r~n" + &
"    adolescent_code=code_lookup_j.code,~r~n" + &
"    adult_code=code_lookup_k.code,~r~n" + &
"    senior_code=code_lookup_l.code,~r~n" + &
"    handicap_acc=code_lookup_m.description,~r~n" + &
"    on_public_trans=code_lookup_n.description,~r~n" + &
"    pd_address.cust_1,~r~n" + &
"    pd_address.cust_2,~r~n" + &
"    pd_address.cust_3,~r~n" + &
"    pd_address.cust_4,~r~n" + &
"    pd_address.cust_5,~r~n" + &
"    pd_address.cust_6,~r~n" + &
"    pd_address.street_2,~r~n" + &
"    pd_address.suite_apart,~r~n" + &
"    pd_address.active_status,~r~n" + &
"    pd_address.accepting_new_patients,~r~n" + &
"    accepting_new_patient=code_lookup_p.description from~r~n" + &
"    pd_address left outer join code_lookup as code_lookup_b on pd_address.office_in_home = code_lookup_b.lookup_code left outer join code_lookup as code_lookup_d on pd_address.practice_type = code_lookup_d.lookup_code left outer join code_lookup as code_lookup_e on pd_address.state = code_lookup_e.lookup_code left outer join code_lookup as code_lookup_f on pd_address.country = code_lookup_f.lookup_code left outer join code_lookup as code_lookup_g on pd_address.county = code_lookup_g.lookup_code left outer join code_lookup as code_lookup_h on pd_address.young_child = code_lookup_h.lookup_code left outer join code_lookup as code_lookup_i on pd_address.child = code_lookup_i.lookup_code left outer join code_lookup as code_lookup_j on pd_address.adolescent = code_lookup_j.lookup_code left outer join code_lookup as code_lookup_k on pd_address.adult = code_lookup_k.lookup_code left outer join code_lookup as code_lookup_l on pd_address.senior_adult = code_lookup_l.lookup_code left outer join code_lookup as code_lookup_m on pd_address.handicapped_access = code_lookup_m.lookup_code left outer join code_lookup as code_lookup_n on pd_address.public_transportation = code_lookup_n.lookup_code left outer join code_lookup as code_lookup_p on pd_address.accepting_new_patients = code_lookup_p.lookup_code,~r~n" + &
"    pd_basic where~r~n" + &
"    (pd_address.prac_id = pd_basic.prac_id)~r~n" + &
"order by pd_address.rec_id,pd_address.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_address_link') + "~r~n" + &
"  as select " + ls_Title + " pd_address_link.address_id,~r~n" + &
"    pd_address_link.prac_id,~r~n" + &
"    pd_address_link.facility_id,~r~n" + &
"    pd_address_link.mailing,~r~n" + &
"    pd_address_link.billing,~r~n" + &
"    pd_address_link.contact_person,~r~n" + &
"    pd_address_link.include_in_directory,~r~n" + &
"    pd_address_link.exp_letters,~r~n" + &
"    pd_address_link.home_address,~r~n" + &
"    pd_address_link.additional_office,~r~n" + &
"    pd_address_link.primary_office from~r~n" + &
"    pd_address_link~r~n" + &
"order by pd_address_link.address_id,pd_address_link.prac_id,pd_address_link.facility_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_address_lookup') + "~r~n" + &
"  as select distinct " + ls_Title + " address_lookup.lookup_code,~r~n" + &
"    address_lookup.lookup_name,~r~n" + &
"    address_lookup.code,~r~n" + &
"    address_lookup.entity_name,~r~n" + &
"    address_lookup.street1,~r~n" + &
"    address_lookup.street2,~r~n" + &
"    address_lookup.city,~r~n" + &
"    address_lookup.state,~r~n" + &
"    address_lookup.zip,~r~n" + &
"    address_lookup.country,~r~n" + &
"    address_lookup.phone,~r~n" + &
"    address_lookup.fax,~r~n" + &
"    address_lookup.email_address,~r~n" + &
"    address_lookup.web_address,~r~n" + &
"    address_lookup.custom_1,~r~n" + &
"    address_lookup.custom_2,~r~n" + &
"    address_lookup.custom_3,~r~n" + &
"    address_lookup.custom_4,~r~n" + &
"    address_lookup.custom_5,~r~n" + &
"    address_lookup.custom_6,~r~n" + &
"    address_lookup.contact_name,~r~n" + &
"    address_lookup.contact_salutation,~r~n" + &
"    address_lookup.fee from~r~n" + &
"    address_lookup~r~n" + &
"order by address_lookup.lookup_code~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_affil_dept') + "~r~n" + &
"AS~r~n" + &
"SELECT DISTINCT " + ls_Title + "~r~n" + &
"                      pd_affil_dept.rec_id, pd_affil_dept.prac_id, pd_affil_dept.facility_id, facility.facility_name, code_lookup_a.lookup_code AS dept_id, ~r~n" + &
"                      code_lookup_a.code AS dept_code, code_lookup_a.description AS dept_name, code_lookup_b.code AS section_code, ~r~n" + &
"                      code_lookup_b.description AS section_name, code_lookup_d.code AS division_code, code_lookup_d.description AS division_name, ~r~n" + &
"                      pd_affil_dept.primary_dept, pd_affil_dept.from_date, pd_affil_dept.to_date, pd_affil_dept.active_status, ~r~n" + &
"                      CASE WHEN pd_affil_dept.primary_dept = 1 THEN 'Yes' ELSE 'No' END AS primary_dept_description, ~r~n" + &
"                      CASE WHEN pd_affil_dept.primary_dept = 1 THEN 'Y' ELSE 'N' END AS primary_dept_code~r~n" + &
"FROM         pd_affil_dept INNER JOIN~r~n" + &
"                      facility ON pd_affil_dept.facility_id = facility.facility_id INNER JOIN~r~n" + &
"                      code_lookup code_lookup_a ON pd_affil_dept.department = code_lookup_a.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_b ON pd_affil_dept.[section] = code_lookup_b.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_d ON pd_affil_dept.rank = code_lookup_d.lookup_code~r~n" + &
"ORDER BY pd_affil_dept.rec_id, pd_affil_dept.prac_id, pd_affil_dept.facility_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_affil_staff_cat') + "~r~n" + &
"  as select " + ls_Title + " pd_affil_staff_cat.rec_id,~r~n" + &
"    pd_affil_staff_cat.prac_id,~r~n" + &
"    pd_affil_staff_cat.facility_id,~r~n" + &
"    facility.facility_name,~r~n" + &
"    pd_affil_staff_cat.seq_no,~r~n" + &
"    code_lookup.code,~r~n" + &
"    code_lookup.description,~r~n" + &
"    pd_affil_staff_cat.from_date,~r~n" + &
"    pd_affil_staff_cat.to_date,~r~n" + &
"    pd_affil_staff_cat.active_status,~r~n" + &
"    pd_affil_staff_cat.requested from(~r~n" + &
"    pd_affil_staff_cat left outer join code_lookup on pd_affil_staff_cat.staff_category = code_lookup.lookup_code),~r~n" + &
"    facility where~r~n" + &
"    (pd_affil_staff_cat.facility_id = facility.facility_id)~r~n" + &
"order by pd_affil_staff_cat.rec_id,pd_affil_staff_cat.prac_id,pd_affil_staff_cat.facility_id,pd_affil_staff_cat.seq_no~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_affil_staff_cat_active') + "~r~n" + &
"as select " + ls_Title + " pd_affil_staff_cat.rec_id,~r~n" + &
"pd_affil_staff_cat.prac_id,~r~n" + &
"pd_affil_staff_cat.facility_id,~r~n" + &
"facility.facility_name,~r~n" + &
"pd_affil_staff_cat.seq_no,~r~n" + &
"code_lookup.code as staff_cat_code,~r~n" + &
"code_lookup.description as staff_cat,~r~n" + &
"pd_affil_staff_cat.from_date,~r~n" + &
"pd_affil_staff_cat.to_date,~r~n" + &
"pd_affil_staff_cat.active_status,~r~n" + &
"pd_affil_staff_cat.requested ~r~n" + &
"from pd_affil_staff_cat,~r~n" + &
"code_lookup,facility ~r~n" + &
"where(pd_affil_staff_cat.facility_id = facility.facility_id) and(pd_affil_staff_cat.staff_category = code_lookup.lookup_code) ~r~n" + &
"and(pd_affil_staff_cat.requested = 1) and(pd_affil_staff_cat.active_status in(1,4))~r~n" + &
"order by pd_affil_staff_cat.rec_id,pd_affil_staff_cat.prac_id,pd_affil_staff_cat.facility_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_affil_stat') + "~r~n" + &
"  as select " + ls_Title + " pd_affil_stat.rec_id,~r~n" + &
"    pd_affil_stat.prac_id,~r~n" + &
"    pd_affil_stat.parent_facility_id,~r~n" + &
"    pd_affil_stat.verifying_facility as verifying_facility_id,~r~n" + &
"    facility_a.facility_name as parent_facility_name,~r~n" + &
"    facility_b.facility_name as verifying_facility_name,~r~n" + &
"    facility_c.facility_name as app_audit_facility_name,~r~n" + &
"    pd_affil_stat.apptmnt_type,~r~n" + &
"    pd_affil_stat.affiliation_status,~r~n" + &
"    pd_affil_stat.apptmnt_start_date,~r~n" + &
"    pd_affil_stat.apptmnt_end_date,~r~n" + &
"    pd_affil_stat.date_rqst_rcvd,~r~n" + &
"    pd_affil_stat.date_app_sent,~r~n" + &
"    pd_affil_stat.date_app_signed,~r~n" + &
"    pd_affil_stat.date_app_rcvd,~r~n" + &
"    pd_affil_stat.date_rls_form_exp,~r~n" + &
"    pd_affil_stat.date_app_audit_completed,~r~n" + &
"    pd_affil_stat.date_data_entry_completed,~r~n" + &
"    pd_affil_stat.date_verif_completed,~r~n" + &
"    pd_affil_stat.date_comm_review_completed as date_completed,~r~n" + &
"    pd_affil_stat.affil_ended,~r~n" + &
"    code_lookup.code as affil_ended_code,~r~n" + &
"    code_lookup.description as affil_ended_desc,~r~n" + &
"    pd_affil_stat.init_prov_period_from,~r~n" + &
"    pd_affil_stat.init_prov_period_to,pd_affil_stat.staff_category,~r~n" + &
"    pd_affil_stat.active_status,pd_affil_stat.fee,~r~n" + &
"    pd_affil_stat.date_invoiced,pd_affil_stat.date_paid,~r~n" + &
"    pd_affil_stat.priority,pd_affil_stat.priority_user,~r~n" + &
"    pd_affil_stat.custom_1,~r~n" + &
"    pd_affil_stat.custom_2,~r~n" + &
"    pd_affil_stat.custom_3,~r~n" + &
"    pd_affil_stat.custom_4,~r~n" + &
"    pd_affil_stat.custom_5,~r~n" + &
"    pd_affil_stat.prov_status,~r~n" + &
"    pd_affil_stat.prior_appt_start,~r~n" + &
"    pd_affil_stat.prior_appt_end,~r~n" + &
"    pd_affil_stat.appt_note,~r~n" + &
"    pd_affil_stat.inital_appmnt_date from~r~n" + &
"    pd_affil_stat left outer join code_lookup on pd_affil_stat.affil_ended_reason = code_lookup.lookup_code,~r~n" + &
"    facility as facility_a,~r~n" + &
"    facility as facility_b,~r~n" + &
"    facility as facility_c~r~n" + &
"where~r~n" + &
"    (facility_a.facility_id = pd_affil_stat.parent_facility_id) and~r~n" + &
"    (facility_b.facility_id = pd_affil_stat.verifying_facility) and~r~n" + &
"    (facility_c.facility_id = pd_affil_stat.application_audit_facility)~r~n" + &
"order by pd_affil_stat.rec_id,pd_affil_stat.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_app_audit') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + " pd_app_audit.record_id, pd_app_audit.prac_id, pd_app_audit.facility_id, pd_app_audit.seq_no, pd_app_audit.app_audit_id, ~r~n" + &
"                      pd_app_audit.completed, pd_app_audit.date_completed, pd_app_audit.active_status, pd_app_audit.data_status, ~r~n" + &
"                      pd_app_audit.identifying_number, pd_app_audit.appt_stat_id, code_lookup.description AS status~r~n" + &
"FROM         pd_app_audit LEFT OUTER JOIN~r~n" + &
"                      code_lookup ON pd_app_audit.data_status = code_lookup.lookup_code~r~n" + &
"ORDER BY pd_app_audit.record_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_app_audit_attempts') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + " record_id, prac_id, facility_id, seq_no, date_attempted, user_name, method, notes, active_status~r~n" + &
"FROM         pd_app_audit_attempts~r~n" + &
"ORDER BY record_id, prac_id, facility_id, seq_no~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_attest_questions') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     pd_attest_questions.rec_id, pd_attest_questions.prac_id, pd_attest_questions.question_id, cl_quest_type.code AS question_type_code, ~r~n" + &
"                      cl_quest_type.description AS question_type_description, question_lookup.short_quest, question_lookup.full_quest, ~r~n" + &
"                      pd_attest_questions.answer_code AS answer_lookup_code, cl_answer.code AS answer_code, cl_answer.description AS answer_description, ~r~n" + &
"                      pd_attest_questions.active_status, CASE WHEN pd_attest_questions.active_status = 1 THEN 'Yes' ELSE 'No' END AS active_status_description, ~r~n" + &
"                      pd_attest_questions.facility_id, facility.facility_name, pd_attest_questions.explain_yes~r~n" + &
"FROM  pd_attest_questions INNER JOIN question_lookup ON pd_attest_questions.question_id = question_lookup.quest_id ~r~n" + &
"INNER JOIN   facility ON facility.facility_id = pd_attest_questions.facility_id ~r~n" + &
"INNER JOIN code_lookup cl_answer ON cl_answer.lookup_code = pd_attest_questions.answer_code ~r~n" + &
"inner join code_lookup cl_quest_type ON  cl_quest_type.lookup_code = question_lookup.quest_type~r~n" + &
"ORDER BY pd_attest_questions.rec_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_audit_trail') + "~r~n" + &
"  as(select " + ls_Title + " sys_audit.rec_id,~r~n" + &
"    sys_audit.field_id,~r~n" + &
"    sys_audit.seq_no,~r~n" + &
"    sys_audit.table_id,~r~n" + &
"    sys_audit.prac_id,~r~n" + &
"    sys_audit.old_value,~r~n" + &
"    sys_audit.new_value,~r~n" + &
"    sys_audit.user_id,~r~n" + &
"    sys_audit.date_time_modified,~r~n" + &
"    sys_fields.field_name,~r~n" + &
"    sys_fields.field_name_allias,~r~n" + &
"    sys_tables.table_name_allias,~r~n" + &
"    v_full_name.full_name,~r~n" + &
"    sys_audit.exported,~r~n" + &
"    sys_audit.export_date,~r~n" + &
"    sys_audit.facility_id,~r~n" + &
"    sys_audit.audit_type from~r~n" + &
"    sys_audit left outer join sys_fields on sys_audit.field_id = sys_fields.field_id,~r~n" + &
"    sys_tables,~r~n" + &
"    v_full_name ~r~n" + &
"where (sys_audit.prac_id = v_full_name.prac_id) and~r~n" + &
"    (sys_audit.table_id = sys_tables.table_id)~r~n" + &
"order by sys_audit.rec_id,sys_audit.field_id,sys_audit.seq_no)~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_basic') + "~r~n" + &
"  as select " + ls_Title + " pd_basic.rec_id,~r~n" + &
"    pd_basic.prac_id,~r~n" + &
"    pd_basic.first_name,~r~n" + &
"    pd_basic.last_name,~r~n" + &
"    pd_basic.middle_name,~r~n" + &
"    pd_basic.title,~r~n" + &
"    code_lookup_a.code as title_code,~r~n" + &
"    code_lookup_a.description as title_description,~r~n" + &
"    pd_basic.name_suffix,~r~n" + &
"    code_lookup_b.code as name_suffix_code,~r~n" + &
"    code_lookup_b.description as name_suffix_description,~r~n" + &
"    pd_basic.prof_suffix,~r~n" + &
"    code_lookup_c.code as prof_suffix_code,~r~n" + &
"    code_lookup_c.description as prof_suffix_description,~r~n" + &
"    pd_basic.date_of_birth,~r~n" + &
"    pd_basic.ssn,~r~n" + &
"    pd_basic.sex,~r~n" + &
"    code_lookup_d.code as sex_code,~r~n" + &
"    code_lookup_d.description as sex_description,~r~n" + &
"    pd_basic.prac_category,~r~n" + &
"    code_lookup_e.code as prac_category_code,~r~n" + &
"    code_lookup_e.description as prac_category_description,~r~n" + &
"    pd_basic.maiden_other_name,~r~n" + &
"    pd_basic.pob_city,~r~n" + &
"    pd_basic.pob_state,~r~n" + &
"    code_lookup_f.code as state_code,~r~n" + &
"    code_lookup_f.description as state_description,~r~n" + &
"    pd_basic.pob_country,~r~n" + &
"    code_lookup_g.code as pob_country_code,~r~n" + &
"    code_lookup_g.description as pob_country_description,~r~n" + &
"    pd_basic.citizenship,~r~n" + &
"    code_lookup_h.code as citizenship_code,~r~n" + &
"    pd_basic.married,~r~n" + &
"    code_lookup_i.code as married_code,~r~n" + &
"    pd_basic.spouse_name,~r~n" + &
"    pd_basic.phone,~r~n" + &
"    pd_basic.answering_service,~r~n" + &
"    pd_basic.beeper_1,~r~n" + &
"    pd_basic.beeper_2,~r~n" + &
"    pd_basic.personal_pager,~r~n" + &
"    pd_basic.hospital_pager,~r~n" + &
"    pd_basic.car_phone_1,~r~n" + &
"    pd_basic.car_phone_2,~r~n" + &
"    pd_basic.civilian_fed_employee,~r~n" + &
"    code_lookup_j.code as civilian_fed_employee_code,~r~n" + &
"    pd_basic.active_military,~r~n" + &
"    code_lookup_k.code as active_military_code,~r~n" + &
"    pd_basic.reservist,~r~n" + &
"    code_lookup_l.code as reservist_code,~r~n" + &
"    pd_basic.branch,~r~n" + &
"    pd_basic.rank,~r~n" + &
"    pd_basic.service_number,~r~n" + &
"    pd_basic.service_date_from,~r~n" + &
"    pd_basic.service_date_to,~r~n" + &
"    pd_basic.cust_1,~r~n" + &
"    pd_basic.cust_2,~r~n" + &
"    pd_basic.cust_3,~r~n" + &
"    pd_basic.cust_5,~r~n" + &
"    pd_basic.cust_6,~r~n" + &
"    pd_basic.cust_7,~r~n" + &
"    pd_basic.cust_8,~r~n" + &
"    pd_basic.cust_9,~r~n" + &
"    pd_basic.cust_10,~r~n" + &
"    pd_basic.full_name,~r~n" + &
"    pd_basic.npdb_query,~r~n" + &
"    pd_basic.provider_id,~r~n" + &
"    pd_basic.provider_type,~r~n" + &
"    code_lookup_m.code as provider_type_code,~r~n" + &
"    code_lookup_m.description as provider_type_description,~r~n" + &
"    pd_basic.cust_4,~r~n" + &
"    pd_basic.oig_query~r~n" + &
"from~r~n" + &
"    pd_basic LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_a ON pd_basic.title = code_lookup_a.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_b ON pd_basic.name_suffix = code_lookup_b.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_c ON pd_basic.prof_suffix = code_lookup_c.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_d ON pd_basic.sex = code_lookup_d.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_e ON pd_basic.prac_category = code_lookup_e.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_f ON pd_basic.pob_state = code_lookup_f.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_g ON pd_basic.pob_country = code_lookup_g.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_h ON pd_basic.citizenship = code_lookup_h.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_i ON pd_basic.married = code_lookup_i.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_j ON pd_basic.civilian_fed_employee = code_lookup_j.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_k ON pd_basic.active_military = code_lookup_k.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_l ON pd_basic.reservist = code_lookup_l.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_m ON pd_basic.provider_type = code_lookup_m.lookup_code~r~n" + &
"order by pd_basic.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_basic_info') + "~r~n" + &
"  as select " + ls_Title + " pd_basic.rec_id,~r~n" + &
"    pd_basic.prac_id,~r~n" + &
"    pd_basic.first_name,~r~n" + &
"    pd_basic.middle_name,~r~n" + &
"    pd_basic.last_name,~r~n" + &
"    code_lookup_a.code as title_code,~r~n" + &
"    code_lookup_a.description as title_description,~r~n" + &
"    code_lookup_b.code as name_suffix_code,~r~n" + &
"    code_lookup_b.description as name_suffix_description,~r~n" + &
"    code_lookup_c.code as prof_suffix_code,~r~n" + &
"    code_lookup_c.description as prof_suffix_description,~r~n" + &
"    pd_basic.date_of_birth,~r~n" + &
"    pd_basic.ssn,~r~n" + &
"    code_lookup_d.code as gender_code,~r~n" + &
"    code_lookup_d.description as gender_description,~r~n" + &
"    code_lookup_e.code as prac_category_code,~r~n" + &
"    code_lookup_e.description as prac_category_description,~r~n" + &
"    pd_basic.provider_id,~r~n" + &
"    code_lookup_f.code as provider_type_code,~r~n" + &
"    code_lookup_f.description as provider_type_description,~r~n" + &
"    pd_basic.maiden_other_name,~r~n" + &
"    pd_basic.cust_1,~r~n" + &
"    pd_basic.cust_2,~r~n" + &
"    pd_basic.cust_3,~r~n" + &
"    pd_basic.cust_4,~r~n" + &
"    pd_basic.cust_5,~r~n" + &
"    pd_basic.cust_6,~r~n" + &
"    pd_basic.cust_7,~r~n" + &
"    pd_basic.cust_8,~r~n" + &
"    pd_basic.cust_9,~r~n" + &
"    pd_basic.cust_10~r~n" + &
"from~r~n" + &
"    pd_basic LEFT OUTER JOIN ~r~n" + &
"    code_lookup as code_lookup_a ON pd_basic.title = code_lookup_a.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_b ON pd_basic.name_suffix = code_lookup_b.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_c ON pd_basic.prof_suffix = code_lookup_c.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_d ON pd_basic.sex = code_lookup_d.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_e ON pd_basic.prac_category = code_lookup_e.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_f ON pd_basic.provider_type = code_lookup_f.lookup_code~r~n" + &
"order by rec_id,prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_billing_address') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     pa.rec_id AS practice_address_id, ba.rec_id AS billing_address_id, ba.prac_id, pd_basic.first_name + ' ' + pd_basic.last_name AS practitioner, ~r~n" + &
"                      code_lookup_b.code AS office_in_home, code_lookup_d.code AS prac_type_code, code_lookup_d.description AS prac_type, ba.street, ba.street_2, ~r~n" + &
"                      ba.city, code_lookup_e.code AS state_code, code_lookup_e.description AS state_name, code_lookup_f.code AS country_code, ~r~n" + &
"                      code_lookup_f.description AS country_name, ba.pager_number, ba.phone, ba.ext, ba.fax, ba.zip, code_lookup_g.code AS county_code, ~r~n" + &
"                      code_lookup_g.description AS county_name, ba.contact_person, ba.tax_id, ba.tax_id_other_1, ba.tax_id_other_2, ba.business_mgr, ba.office_mgr, ~r~n" + &
"                      ba.e_mail_address, ba.web_address, ba.mon_from, ba.mon_to, ba.tue_from, ba.tue_to, ba.wed_from, ba.thu_from, ba.thu_to, ba.fri_from, ba.fri_to, ~r~n" + &
"                      ba.sat_from, ba.sat_to, ba.sun_from, ba.sun_to, ba.mon_from2, ba.mon_to2, ba.tue_from2, ba.tue_to2, ba.wed_from2, ba.wed_to2, ba.thu_from2, ~r~n" + &
"                      ba.thu_to2, ba.fri_from2, ba.fri_to2, ba.sat_from2, ba.sat_to2, ba.sun_from2, ba.sun_to2, ba.wed_to, ba.routine_visit_appt, ba.urgent_visit_appt, ~r~n" + &
"                      ba.emergency_visit_appt, ba.non_emergency_appt, code_lookup_h.code AS young_child_code, code_lookup_i.code AS child_code, ~r~n" + &
"                      code_lookup_j.code AS adolescent_code, code_lookup_k.code AS adult_code, code_lookup_l.code AS senior_code, ~r~n" + &
"                      code_lookup_m.description AS handicap_acc, code_lookup_n.description AS on_public_trans, ba.cust_1, ba.cust_2, ba.cust_3, ba.cust_4, ba.cust_5, ~r~n" + &
"                      ba.cust_6, ba.cust_7, ba.cust_8, ba.cust_9, ba.cust_10, ba.cust_d1, ba.cust_d2, ba.active_status, ba.accepting_new_patients, ~r~n" + &
"                      code_lookup_p.description AS accepting_new_patient, ba.gp_id, code_lookup_q.description AS send_corresp_here, ba.suite_apart~r~n" + &
"FROM         pd_address pa LEFT OUTER JOIN~r~n" + &
"                      pd_basic ON pa.prac_id = pd_basic.prac_id LEFT OUTER JOIN~r~n" + &
"                      pd_address ba ON CASE WHEN pa.billing_address_id = 0 THEN pa.rec_id ELSE pa.billing_address_id END = ba.rec_id LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_b ON ba.office_in_home = code_lookup_b.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_d ON ba.practice_type = code_lookup_d.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_e ON ba.state = code_lookup_e.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_f ON ba.country = code_lookup_f.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_g ON ba.county = code_lookup_g.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_h ON ba.young_child = code_lookup_h.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_i ON ba.child = code_lookup_i.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_j ON ba.adolescent = code_lookup_j.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_k ON ba.adult = code_lookup_k.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_l ON ba.senior_adult = code_lookup_l.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_m ON ba.handicapped_access = code_lookup_m.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_n ON ba.public_transportation = code_lookup_n.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_p ON ba.accepting_new_patients = code_lookup_p.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_q ON ba.send_corresp_here = code_lookup_q.lookup_code~r~n" + &
"WHERE     (pa.billing_address_id <> - 1)~r~n" + &
"ORDER BY pa.rec_id,pa.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_board_specialty') + "~r~n" + &
"as select " + ls_Title + " pd_board_specialty.rec_id,~r~n" + &
"    pd_board_specialty.prac_id,~r~n" + &
"    pd_board_specialty.specialty,~r~n" + &
"    code_lookup_a.code as specialty_code,~r~n" + &
"    code_lookup_a.description as specialty_description,~r~n" + &
"    address_lookup.code as board_code,~r~n" + &
"    address_lookup.entity_name as board_name,~r~n" + &
"    pd_board_specialty.eligible_until,~r~n" + &
"    pd_board_specialty.initial_certification,~r~n" + &
"    pd_board_specialty.last_recertification,~r~n" + &
"    pd_board_specialty.certification_expires,~r~n" + &
"    pd_board_specialty.certification_number,~r~n" + &
"    pd_board_specialty.required_year_completion,~r~n" + &
"    pd_board_specialty.cust_1,~r~n" + &
"    pd_board_specialty.cust_2,~r~n" + &
"    pd_board_specialty.cust_3,~r~n" + &
"    pd_board_specialty.cust_4,~r~n" + &
"    pd_board_specialty.cust_5,~r~n" + &
"    code_lookup_b.description as exam_taken,~r~n" + &
"    code_lookup_c.description as active_process,~r~n" + &
"    code_lookup_d.description as ever_failed,~r~n" + &
"    code_lookup_e.description as specialty_order from~r~n" + &
"    pd_board_specialty left outer join address_lookup on pd_board_specialty.board_code = address_lookup.lookup_code left outer join code_lookup as code_lookup_b on pd_board_specialty.exam_taken = code_lookup_b.lookup_code left outer join code_lookup as code_lookup_c on pd_board_specialty.active_cert_process = code_lookup_c.lookup_code left outer join code_lookup as code_lookup_d on pd_board_specialty.ever_failed_cert = code_lookup_d.lookup_code left outer join code_lookup as code_lookup_e on pd_board_specialty.specialty_order = code_lookup_e.lookup_code,~r~n" + &
"    code_lookup as code_lookup_a where~r~n" + &
"    (pd_board_specialty.specialty = code_lookup_a.lookup_code)~r~n" + &
"order by pd_board_specialty.rec_id,pd_board_specialty.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_claims') + "~r~n" + &
"as select " + ls_Title + " pd_claims.rec_id,pd_claims.prac_id,pd_claims.case_number,pd_claims.claimant,status_code=code_lookup.code,status_descripton=code_lookup.description,pd_claims.nature_of_claim,pd_claims.date_closed,pd_claims.date_of_incident,pd_claims.case_role,pd_claims.other_role,pd_claims.amt_attrib_you,pd_claims.adj_set_dis,pd_claims.amount_paid,pd_claims.date_last_contact,pd_claims.date_initiated,pd_claims.practice_role,pd_claims.practice_other,pd_claims.alleged_malpractice,pd_claims.alleged_harm,pd_claims.patient_illness,pd_claims.other_details,pd_claims.date_claimed_filed,pd_claims.carrier,pd_claims.cust_1,pd_claims.cust_2,pd_claims.cust_3,pd_claims.cust_4,pd_claims.cust_5 from(pd_claims left outer join code_lookup on pd_claims.status_code = code_lookup.lookup_code) order by pd_claims.rec_id,pd_claims.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_clinical_specialties') + "~r~n" + &
"as select " + ls_Title + " pd_clinical_specialties.rec_id,pd_clinical_specialties.prac_id,rank_code=code_lookup.code,rank_description=code_lookup.description,pd_clinical_specialties.specialty_expertise,pd_clinical_specialties.cust_1,pd_clinical_specialties.cust_2,pd_clinical_specialties.cust_3,pd_clinical_specialties.cust_4,pd_clinical_specialties.cust_5 from(pd_clinical_specialties left outer join code_lookup on pd_clinical_specialties.rank = code_lookup.lookup_code) order by pd_clinical_specialties.rec_id,pd_clinical_specialties.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_code_lookup') + "~r~n" + &
"  as select " + ls_Title + " lookup_code,~r~n" + &
"    lookup_name as table_name,~r~n" + &
"    code,~r~n" + &
"    description,~r~n" + &
"    custom_1,~r~n" + &
"    custom_2,~r~n" + &
"    custom_3,~r~n" + &
"    custom_4,~r~n" + &
"    custom_5,~r~n" + &
"    custom_6 from~r~n" + &
"    code_lookup~r~n" + &
"order by lookup_code~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_code_lookup_1') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     lookup_code, lookup_name AS table_name, code, description, custom_1, custom_2, custom_3, custom_4, custom_5, custom_6, caqh_code, ic_n, ~r~n" + &
"                      ic_c~r~n" + &
"FROM         code_lookup~r~n" + &
"ORDER BY lookup_code~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_code_lookup_2') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     lookup_code, lookup_name AS table_name, code, description, custom_1, custom_2, custom_3, custom_4, custom_5, custom_6, caqh_code, ic_n, ~r~n" + &
"                      ic_c~r~n" + &
"FROM         code_lookup~r~n" + &
"ORDER BY lookup_code~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_committee_lookup') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     committee_id, facility_id, committee_name~r~n" + &
"FROM         committee_lookup~r~n" + &
"ORDER BY committee_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_committee_review') + "~r~n" + &
"as select " + ls_Title + " pd_comm_review.rec_id,pd_comm_review.prac_id,pd_comm_review.facility_id,facility_name=facility.facility_name,committee_name=committee_lookup.committee_name,pd_comm_review.date_sent_for_review,pd_comm_review.date_back_from_review,review_result_code=code_lookup_a.code,review_result_name=code_lookup_a.description,pd_comm_review.active_status from(pd_comm_review left outer join code_lookup as code_lookup_a on pd_comm_review.review_results = code_lookup_a.lookup_code),committee_lookup,facility where(pd_comm_review.facility_id = facility.facility_id) and(pd_comm_review.committee_id = committee_lookup.committee_id) order by pd_comm_review.rec_id,pd_comm_review.facility_id,pd_comm_review.committee_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_continue_education') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     pd_postgrad_train.prac_id, pd_postgrad_train.subject, pd_postgrad_train.date_from, pd_postgrad_train.date_thru, ~r~n" + &
"                      pd_postgrad_train.loc_city, code_lookup_a.code AS loc_state_code, code_lookup_a.description AS loc_state_description, ~r~n" + &
"                      pd_postgrad_train.loc_zip, pd_postgrad_train.loc_country, pd_postgrad_train.hours, code_lookup_b.code AS category_code, ~r~n" + &
"                      code_lookup_b.description AS category_description, pd_postgrad_train.sponsor, pd_postgrad_train.street, pd_postgrad_train.city, ~r~n" + &
"                      code_lookup_c.code AS state_code, code_lookup_c.description AS state_description, pd_postgrad_train.zip, code_lookup_d.code AS country_code,~r~n" + &
"                       code_lookup_d.description AS country_description, pd_postgrad_train.program_director, pd_postgrad_train.cust_1, ~r~n" + &
"                      pd_postgrad_train.cust_2, pd_postgrad_train.cust_3, pd_postgrad_train.cust_4, pd_postgrad_train.cust_5, ~r~n" + &
"                      pd_postgrad_train.cust_6, pd_postgrad_train.cust_7, pd_postgrad_train.cust_8, pd_postgrad_train.cust_9, ~r~n" + &
"                      pd_postgrad_train.cust_10, pd_postgrad_train.cust_d1, pd_postgrad_train.cust_d2~r~n" + &
"FROM         pd_postgrad_train LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_d ON pd_postgrad_train.country = code_lookup_d.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_b ON pd_postgrad_train.category = code_lookup_b.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_c ON pd_postgrad_train.state = code_lookup_c.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_a ON pd_postgrad_train.loc_state = code_lookup_a.lookup_code~r~n" + &
"ORDER BY pd_postgrad_train.rec_id,pd_postgrad_train.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_contract') + "~r~n" + &
"as select " + ls_Title + " pd_contract.rec_id,pd_contract.prac_id,group_plan_code=address_lookup.code,group_plan_description=address_lookup.entity_name,sub_group_code=code_lookup_a.code,sub_group_description=code_lookup_a.description,catagory_code=code_lookup_b.code,catagory_description=code_lookup_b.description,pd_contract.start_date,pd_contract.end_date,reason_code=code_lookup_c.code,reason_description=code_lookup_c.description,pd_contract.mco_provider_id,pd_contract.cust_1,pd_contract.cust_2,pd_contract.cust_3,pd_contract.cust_4,pd_contract.cust_5 from((((pd_contract left outer join address_lookup on pd_contract.group_plan = address_lookup.lookup_code) left outer join code_lookup as code_lookup_a on pd_contract.sub_group_plan = code_lookup_a.lookup_code) left outer join code_lookup as code_lookup_b on pd_contract.category = code_lookup_b.lookup_code) left outer join code_lookup as code_lookup_c on pd_contract.reason = code_lookup_c.lookup_code) order by pd_contract.rec_id,pd_contract.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_cpr_certification') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     pd_cpr_certifiation.rec_id, pd_cpr_certifiation.prac_id, pd_cpr_certifiation.bls_expires, pd_cpr_certifiation.acls_expires, ~r~n" + &
"                      pd_cpr_certifiation.atls_expires, pd_cpr_certifiation.cust_1, pd_cpr_certifiation.cust_2, pd_cpr_certifiation.cust_3, ~r~n" + &
"                      pd_cpr_certifiation.cust_4, pd_cpr_certifiation.cust_5, pd_cpr_certifiation.cust_6, pd_cpr_certifiation.cust_7, ~r~n" + &
"                      pd_cpr_certifiation.cust_8, pd_cpr_certifiation.cust_9, pd_cpr_certifiation.cust_10, pd_cpr_certifiation.cust_d1, ~r~n" + &
"                      pd_cpr_certifiation.cust_d2, pd_cpr_certifiation.cert_type AS cert_type_lookup_code, code_lookup.code AS cert_type_code, ~r~n" + &
"                      code_lookup.description AS cert_type_description, code_lookup_1.description AS certified~r~n" + &
"FROM         pd_cpr_certifiation INNER JOIN~r~n" + &
"                      code_lookup ON pd_cpr_certifiation.cert_type = code_lookup.lookup_code INNER JOIN~r~n" + &
"                      code_lookup code_lookup_1 ON pd_cpr_certifiation.certified = code_lookup_1.lookup_code~r~n" + &
"ORDER BY pd_cpr_certifiation.rec_id, pd_cpr_certifiation.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ctx_basic_info') + "~r~n" + &
"as SELECT " + ls_Title + " ~r~n" + &
"	app_facility.facility_name AS Company_Name, ~r~n" + &
"	app_facility.street AS Company_street_1,~r~n" + &
"	app_facility.street_2 AS Company_street_2,~r~n" + &
"	app_facility.city AS Company_city,~r~n" + &
"	app_facility.state AS Company_state,~r~n" + &
"	app_facility.zip AS Company_zip,~r~n" + &
"	app_facility.country AS Company_country,~r~n" + &
"	app_facility.phone AS Company_phone,~r~n" + &
"	app_facility.fax AS Company_fax,~r~n" + &
"	app_facility.web_address AS Company_web_address,~r~n" + &
"	app_facility.contact_type2 AS Company_contact_type2,~r~n" + &
"	app_facility.corp_office_flag AS Company_corp_office_flag,~r~n" + &
"	app_facility.corp_office_link AS Company_corp_office_link,~r~n" + &
"	code_lookup.code AS Contract_Category_code, ~r~n" + &
"	code_lookup.description AS Contract_Category_description, ~r~n" + &
"	code_lookup_1.code AS Contract_Status_code, ~r~n" + &
"	code_lookup_2.code AS contract_type_code, ~r~n" + &
"	code_lookup_2.description AS contract_type_Description, ~r~n" + &
"	code_lookup_3.code AS term_reason_code, ~r~n" + &
"	code_lookup_3.description AS term_Reason_Desciption, ~r~n" + &
"	code_lookup_4.description AS product_type_desc, ~r~n" + &
"	code_lookup_4.code AS product_type_code, ~r~n" + &
"	code_lookup_5.code AS product_code, ~r~n" + &
"	code_lookup_5.description AS product_description, ~r~n" + &
"	ctx_basic_info.ctx_id,   ~r~n" + &
"	ctx_basic_info.category,   ~r~n" + &
"	ctx_basic_info.status,   ~r~n" + &
"	ctx_basic_info.facility_id,   ~r~n" + &
"	ctx_basic_info.contract_type,   ~r~n" + &
"	ctx_basic_info.product_type,   ~r~n" + &
"	ctx_basic_info.product_name,   ~r~n" + &
"	ctx_basic_info.reimbursment_menth,   ~r~n" + &
"	ctx_basic_info.file_location,   ~r~n" + &
"	ctx_basic_info.effective_date,   ~r~n" + &
"	ctx_basic_info.expriation_date,   ~r~n" + &
"	ctx_basic_info.review_date,   ~r~n" + &
"	ctx_basic_info.review_by,   ~r~n" + &
"	ctx_basic_info.term_date,   ~r~n" + &
"	ctx_basic_info.term_reason,   ~r~n" + &
"	ctx_basic_info.last_revis_date,   ~r~n" + &
"	ctx_basic_info.other_date_1,   ~r~n" + &
"	ctx_basic_info.other_date_2,   ~r~n" + &
"	ctx_basic_info.oc_signed_by,   ~r~n" + &
"	ctx_basic_info.oc_title,   ~r~n" + &
"	ctx_basic_info.oc_department,   ~r~n" + &
"	ctx_basic_info.oc_legal_rep,   ~r~n" + &
"	ctx_basic_info.cc_signed_by,   ~r~n" + &
"	ctx_basic_info.cc_title,   ~r~n" + &
"	ctx_basic_info.cc_department,   ~r~n" + &
"	ctx_basic_info.cc_legal_rep,   ~r~n" + &
"	ctx_basic_info.keyword,   ~r~n" + &
"	ctx_basic_info.dvision,   ~r~n" + &
"	ctx_basic_info.custom_1,   ~r~n" + &
"	ctx_basic_info.custom_2,   ~r~n" + &
"	ctx_basic_info.custom_3,   ~r~n" + &
"	ctx_basic_info.custom_4,   ~r~n" + &
"	ctx_basic_info.custom_5,   ~r~n" + &
"	ctx_basic_info.custom_6,   ~r~n" + &
"	ctx_basic_info.custom_7,   ~r~n" + &
"	ctx_basic_info.custom_8,   ~r~n" + &
"	ctx_basic_info.custom_9,   ~r~n" + &
"	ctx_basic_info.custom_10,   ~r~n" + &
"	ctx_basic_info.group_multi_loc_id,   ~r~n" + &
"	ctx_basic_info.revision_reason,   ~r~n" + &
"	ctx_basic_info.group_id,   ~r~n" + &
"	ctx_basic_info.record_id,   ~r~n" + &
"	ctx_basic_info.custom_11,   ~r~n" + &
"	ctx_basic_info.custom_12,   ~r~n" + &
"	ctx_basic_info.custom_13,   ~r~n" + &
"	ctx_basic_info.custom_14,   ~r~n" + &
"	ctx_basic_info.custom_15,   ~r~n" + &
"	ctx_basic_info.custom_16,   ~r~n" + &
"	ctx_basic_info.custom_17,   ~r~n" + &
"	ctx_basic_info.custom_18,   ~r~n" + &
"	ctx_basic_info.custom_19,   ~r~n" + &
"	ctx_basic_info.custom_20,   ~r~n" + &
"	ctx_basic_info.custom_date1,   ~r~n" + &
"	ctx_basic_info.custom_date2,   ~r~n" + &
"	ctx_basic_info.custom_date3,   ~r~n" + &
"	ctx_basic_info.custom_date4,   ~r~n" + &
"	ctx_basic_info.custom_date5,   ~r~n" + &
"	ctx_basic_info.custom_date6,   ~r~n" + &
"	ctx_basic_info.custom_date7,   ~r~n" + &
"	ctx_basic_info.custom_date8,   ~r~n" + &
"	ctx_basic_info.custom_date9,   ~r~n" + &
"	ctx_basic_info.custom_date10,   ~r~n" + &
"	ctx_basic_info.custom_n1,   ~r~n" + &
"	ctx_basic_info.custom_n2,   ~r~n" + &
"	ctx_basic_info.custom_n3,   ~r~n" + &
"	ctx_basic_info.custom_n4,   ~r~n" + &
"	ctx_basic_info.custom_n5,   ~r~n" + &
"	ctx_basic_info.custom_n6,   ~r~n" + &
"	ctx_basic_info.custom_n7,   ~r~n" + &
"	ctx_basic_info.custom_n8,   ~r~n" + &
"	ctx_basic_info.custom_n9,   ~r~n" + &
"	ctx_basic_info.custom_n10,   ~r~n" + &
"	ctx_basic_info.version_number,   ~r~n" + &
"	ctx_basic_info.version_date,   ~r~n" + &
"	ctx_basic_info.notes,   ~r~n" + &
"	ctx_basic_info.app_facility,  ~r~n" + &
"	ctx_basic_info.master_contract_id AS master_ctx_id, ~r~n" + &
"	ctx_basic_info.master_contract_name,~r~n" + &
"	code_lookup_6.code as dvision_code, ~r~n" + &
"	code_lookup_6.description as dvision_description~r~n" + &
"FROM (((((((ctx_basic_info ~r~n" + &
"LEFT OUTER JOIN code_lookup ON ctx_basic_info.category = code_lookup.lookup_code) ~r~n" + &
"LEFT OUTER JOIN code_lookup AS code_lookup_1 ON ctx_basic_info.status = code_lookup_1.lookup_code) ~r~n" + &
"LEFT OUTER JOIN code_lookup AS code_lookup_2 ON ctx_basic_info.contract_type = code_lookup_2.lookup_code) ~r~n" + &
"LEFT OUTER JOIN code_lookup AS code_lookup_3 ON ctx_basic_info.term_reason = code_lookup_3.lookup_code) ~r~n" + &
"INNER JOIN app_facility ON ctx_basic_info.app_facility = app_facility.facility_id) ~r~n" + &
"INNER JOIN ctx_products ON ctx_basic_info.ctx_id = ctx_products.ctx_id) ~r~n" + &
"LEFT OUTER JOIN code_lookup AS code_lookup_4 ON ctx_products.product_type = code_lookup_4.lookup_code) ~r~n" + &
"LEFT OUTER JOIN code_lookup AS code_lookup_5 ON ctx_products.product_id = code_lookup_5.lookup_code~r~n" + &
"left outer join code_lookup as code_lookup_6 on ctx_basic_info.dvision = code_lookup_6.lookup_code~r~n" + &
"order by ctx_basic_info.ctx_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ctx_basic_info_alarms') + "~r~n" + &
"as SELECT " + ls_Title + " ~r~n" + &
"	ctx_basic_info.ctx_id, ~r~n" + &
"	app_facility.facility_name, ~r~n" + &
"	ctx_notification_users.user_id, ~r~n" + &
"	ctx_notification.alm_message, ~r~n" + &
"	ctx_notification.alm_enabled, ~r~n" + &
"	ctx_notification.alm_notification_days, ~r~n" + &
"	ctx_notification.alm_last_notification_sent, ~r~n" + &
"	ctx_notification.alm_post_notification_days, ~r~n" + &
"	ctx_notification.alm_total_tries, ~r~n" + &
"	ctx_notification.alm_action_item_posted, ~r~n" + &
"	ctx_notification.alm_total_tries_counter, ~r~n" + &
"	ctx_notification.alm_frequency, ~r~n" + &
"	ctx_notification.create_action_item ~r~n" + &
"FROM ((ctx_basic_info ~r~n" + &
"LEFT OUTER JOIN ctx_notification ON ctx_basic_info.ctx_id = ctx_notification.ctx_id) ~r~n" + &
"INNER JOIN ctx_notification_users ON ctx_basic_info.ctx_id = ctx_notification_users.ctx_id) ~r~n" + &
"INNER JOIN app_facility ON ctx_basic_info.app_facility = app_facility.facility_id ~r~n" + &
"GROUP BY ctx_basic_info.ctx_id, ~r~n" + &
"	app_facility.facility_name, ~r~n" + &
"	ctx_notification_users.user_id, ~r~n" + &
"	ctx_notification.alm_message, ~r~n" + &
"	ctx_notification.alm_enabled, ~r~n" + &
"	ctx_notification.alm_notification_days, ~r~n" + &
"	ctx_notification.alm_last_notification_sent, ~r~n" + &
"	ctx_notification.alm_post_notification_days, ~r~n" + &
"	ctx_notification.alm_total_tries, ~r~n" + &
"	ctx_notification.alm_action_item_posted, ~r~n" + &
"	ctx_notification.alm_total_tries_counter, ~r~n" + &
"	ctx_notification.alm_frequency, ~r~n" + &
"	ctx_notification.create_action_item ~r~n" + &
"ORDER BY ctx_basic_info.ctx_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ctx_basic_products') + "~r~n" + &
"as SELECT " + ls_Title + " ctx_products.ctx_id,        code_lookup_4.description AS product_type_desc,        code_lookup_4.code AS product_type_code,        code_lookup_5.code AS product_code,        code_lookup_5.description AS product_description FROM (ctx_products LEFT OUTER JOIN code_lookup AS code_lookup_4 ON ctx_products.product_type = code_lookup_4.lookup_code)                    LEFT OUTER JOIN code_lookup AS code_lookup_5 ON ctx_products.product_id = code_lookup_5.lookup_code ORDER BY ctx_products.ctx_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ctx_basic_without_products') + "~r~n" + &
"as SELECT " + ls_Title + " CTX_BASIC_INFO.ctx_id,        app_facility.facility_name,         code_lookup.code AS Contract_Category_code,        code_lookup.description AS Contract_Category_description,        code_lookup_1.code AS Contract_Status_code,        code_lookup_2.code AS contract_type_code,        code_lookup_2.description AS contract_type_Description,        CTX_BASIC_INFO.effective_date,        CTX_BASIC_INFO.expriation_date,        CTX_BASIC_INFO.review_date,        CTX_BASIC_INFO.review_by,        CTX_BASIC_INFO.term_date,        code_lookup_3.code AS term_reason_code,        code_lookup_3.description AS term_Reason_Desciption,        CTX_BASIC_INFO.other_date_1,        CTX_BASIC_INFO.other_date_2,        CTX_BASIC_INFO.notes,        CTX_BASIC_INFO.custom_1,        CTX_BASIC_INFO.custom_2,        CTX_BASIC_INFO.custom_3,        CTX_BASIC_INFO.custom_4,        CTX_BASIC_INFO.custom_5,        CTX_BASIC_INFO.custom_6,        CTX_BASIC_INFO.custom_7,        CTX_BASIC_INFO.custom_8,        CTX_BASIC_INFO.custom_9,        CTX_BASIC_INFO.custom_10,        CTX_BASIC_INFO.last_revis_date        FROM ((((CTX_BASIC_INFO                         LEFT OUTER JOIN code_lookup ON CTX_BASIC_INFO.category = code_lookup.lookup_code)                         LEFT OUTER JOIN code_lookup AS code_lookup_1 ON CTX_BASIC_INFO.status = code_lookup_1.lookup_code)                         LEFT OUTER JOIN code_lookup AS code_lookup_2 ON CTX_BASIC_INFO.contract_type = code_lookup_2.lookup_code)                         LEFT OUTER JOIN code_lookup AS code_lookup_3 ON CTX_BASIC_INFO.term_reason = code_lookup_3.lookup_code)                         INNER JOIN app_facility ON CTX_BASIC_INFO.app_facility = app_facility.facility_id ORDER BY CTX_BASIC_INFO.ctx_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ctx_contacts_contacts') + "~r~n" + &
"as SELECT " + ls_Title + " CTX_BASIC_INFO.ctx_id, app_facility.facility_name, CTX_CONTRACT_CONTACTS.contact_id, CTX_CONTRACT_CONTACTS.association, code_lookup.code aS contract_type_code, code_lookup.description AS contract_type_description, CTX_CONTACTS.first_name, CTX_CONTACTS.last_name, CTX_CONTACTS.middle_name, code_lookup_4.description as contact_title, code_lookup_1.code AS contract_department_code, code_lookup_1.description AS contract_department_description, CTX_CONTACTS.street_1, CTX_CONTACTS.street_2, CTX_CONTACTS.street_3, CTX_CONTACTS.city, CTX_CONTACTS.zip, code_lookup_2.code AS state, CTX_CONTACTS.custom_1, CTX_CONTACTS.custom_2, CTX_CONTACTS.custom_3, CTX_CONTACTS.custom_4, CTX_CONTACTS.custom_5, CTX_CONTACTS.custom_6, CTX_CONTACTS.custom_7, CTX_CONTACTS.custom_8, CTX_CONTACTS.custom_9, CTX_CONTACTS.custom_10, CTX_CONTRACT_CONTACTS.owner, CTX_CONTRACT_CONTACTS.access, code_lookup_3.code AS Phone_Type_code, code_lookup_3.description AS Phone_type_Description, '(' + LEFT( CTX_CONTACTS_NUMBERS.phone,3 ) + ')' + substring( CTX_CONTACTS_NUMBERS.phone, 4, 3) + '-' + RIGHT( CTX_CONTACTS_NUMBERS.phone, 4 ) AS phone, CTX_CONTACTS_NUMBERS.ext, CTX_CONTACTS_NUMBERS.contact_email, CTX_CONTRACT_CONTACTS.notes FROM ((((((((CTX_BASIC_INFO INNER JOIN CTX_CONTRACT_CONTACTS ON CTX_BASIC_INFO.ctx_id = CTX_CONTRACT_CONTACTS.ctx_id) LEFT OUTER JOIN CTX_CONTACTS ON CTX_CONTRACT_CONTACTS.contact_id = CTX_CONTACTS.contact_id) LEFT OUTER JOIN code_lookup ON CTX_CONTACTS.contact_type = code_lookup.lookup_code) LEFT OUTER JOIN code_lookup AS code_lookup_1 ON CTX_CONTACTS.contact_department = code_lookup_1.lookup_code) LEFT OUTER JOIN code_lookup AS code_lookup_2 ON CTX_CONTACTS.state = code_lookup_2.lookup_code) LEFT OUTER JOIN CTX_CONTACTS_NUMBERS ON CTX_CONTACTS.contact_id = CTX_CONTACTS_NUMBERS.contact_id) LEFT OUTER JOIN code_lookup AS code_lookup_3 ON CTX_CONTACTS_NUMBERS.via = code_lookup_3.lookup_code) LEFT OUTER JOIN code_lookup AS code_lookup_4 ON CTX_CONTACTS.contact_title = code_lookup_4.lookup_code) INNER JOIN app_facility ON CTX_BASIC_INFO.app_facility = app_facility.facility_id GROUP BY CTX_BASIC_INFO.ctx_id, app_facility.facility_name, CTX_CONTRACT_CONTACTS.contact_id, CTX_CONTRACT_CONTACTS.association, code_lookup.code, code_lookup.description, CTX_CONTACTS.first_name, CTX_CONTACTS.last_name, CTX_CONTACTS.middle_name, CTX_CONTACTS.contact_title, code_lookup_1.code, code_lookup_1.description, CTX_CONTACTS.street_1, CTX_CONTACTS.street_2, CTX_CONTACTS.street_3, CTX_CONTACTS.city, CTX_CONTACTS.zip, code_lookup_2.code, CTX_CONTACTS.custom_1, CTX_CONTACTS.custom_2, CTX_CONTACTS.custom_3, CTX_CONTACTS.custom_4, CTX_CONTACTS.custom_5, CTX_CONTACTS.custom_6, CTX_CONTACTS.custom_7, CTX_CONTACTS.custom_8, CTX_CONTACTS.custom_9, CTX_CONTACTS.custom_10, CTX_CONTRACT_CONTACTS.owner, CTX_CONTRACT_CONTACTS.access, code_lookup_3.code, code_lookup_3.description, code_lookup_4.description, CTX_CONTACTS_NUMBERS.phone, CTX_CONTACTS_NUMBERS.ext, CTX_CONTACTS_NUMBERS.contact_email, CTX_CONTRACT_CONTACTS.notes, CTX_CONTRACT_CONTACTS.ic_area HAVING (((CTX_CONTRACT_CONTACTS.ic_area)='c')) ORDER BY CTX_BASIC_INFO.ctx_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ctx_contacts_external') + "~r~n" + &
"as SELECT " + ls_Title + " CTX_BASIC_INFO.ctx_id, app_facility.facility_name, CTX_CONTRACT_CONTACTS.contact_id, CTX_CONTRACT_CONTACTS.association, code_lookup.code aS contract_type_code, code_lookup.description AS contract_type_description, CTX_CONTACTS.first_name, CTX_CONTACTS.last_name, CTX_CONTACTS.middle_name, code_lookup_4.description as contact_title, code_lookup_1.code AS contract_department_code, code_lookup_1.description AS contract_department_description, CTX_CONTACTS.street_1, CTX_CONTACTS.street_2, CTX_CONTACTS.street_3, CTX_CONTACTS.city, CTX_CONTACTS.zip, code_lookup_2.code AS state, CTX_CONTACTS.custom_1, CTX_CONTACTS.custom_2, CTX_CONTACTS.custom_3, CTX_CONTACTS.custom_4, CTX_CONTACTS.custom_5, CTX_CONTACTS.custom_6, CTX_CONTACTS.custom_7, CTX_CONTACTS.custom_8, CTX_CONTACTS.custom_9, CTX_CONTACTS.custom_10, CTX_CONTRACT_CONTACTS.owner, CTX_CONTRACT_CONTACTS.access, code_lookup_3.code AS Phone_Type_code, code_lookup_3.description AS Phone_type_Description, '(' + LEFT( CTX_CONTACTS_NUMBERS.phone,3 ) + ')' + substring( CTX_CONTACTS_NUMBERS.phone, 4, 3) + '-' + RIGHT( CTX_CONTACTS_NUMBERS.phone, 4 ) AS phone , CTX_CONTACTS_NUMBERS.ext, CTX_CONTACTS_NUMBERS.contact_email FROM ((((((((CTX_BASIC_INFO INNER JOIN CTX_CONTRACT_CONTACTS ON CTX_BASIC_INFO.ctx_id = CTX_CONTRACT_CONTACTS.ctx_id) LEFT OUTER JOIN CTX_CONTACTS ON CTX_CONTRACT_CONTACTS.contact_id = CTX_CONTACTS.contact_id) LEFT OUTER JOIN code_lookup ON CTX_CONTACTS.contact_type = code_lookup.lookup_code) LEFT OUTER JOIN code_lookup AS code_lookup_1 ON CTX_CONTACTS.contact_department = code_lookup_1.lookup_code) LEFT OUTER JOIN code_lookup AS code_lookup_2 ON CTX_CONTACTS.state = code_lookup_2.lookup_code) LEFT OUTER JOIN CTX_CONTACTS_NUMBERS ON CTX_CONTACTS.contact_id = CTX_CONTACTS_NUMBERS.contact_id) LEFT OUTER JOIN code_lookup AS code_lookup_3 ON CTX_CONTACTS_NUMBERS.via = code_lookup_3.lookup_code) LEFT OUTER JOIN code_lookup AS code_lookup_4 ON CTX_CONTACTS.contact_title = code_lookup_4.lookup_code) INNER JOIN app_facility ON CTX_BASIC_INFO.app_facility = app_facility.facility_id GROUP BY CTX_BASIC_INFO.ctx_id, app_facility.facility_name, CTX_CONTRACT_CONTACTS.contact_id, CTX_CONTRACT_CONTACTS.association, code_lookup.code, code_lookup.description, CTX_CONTACTS.first_name, CTX_CONTACTS.last_name, CTX_CONTACTS.middle_name, CTX_CONTACTS.contact_title, code_lookup_1.code, code_lookup_1.description, CTX_CONTACTS.street_1, CTX_CONTACTS.street_2, CTX_CONTACTS.street_3, CTX_CONTACTS.city, CTX_CONTACTS.zip, code_lookup_2.code, CTX_CONTACTS.custom_1, CTX_CONTACTS.custom_2, CTX_CONTACTS.custom_3, CTX_CONTACTS.custom_4, CTX_CONTACTS.custom_5, CTX_CONTACTS.custom_6, CTX_CONTACTS.custom_7, CTX_CONTACTS.custom_8, CTX_CONTACTS.custom_9, CTX_CONTACTS.custom_10, CTX_CONTRACT_CONTACTS.owner, CTX_CONTRACT_CONTACTS.access, code_lookup_3.code, code_lookup_3.description, code_lookup_4.description, CTX_CONTACTS_NUMBERS.phone, CTX_CONTACTS_NUMBERS.ext, CTX_CONTACTS_NUMBERS.contact_email, CTX_CONTRACT_CONTACTS.ic_area HAVING (((CTX_CONTRACT_CONTACTS.ic_area)='e')) ORDER BY CTX_BASIC_INFO.ctx_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ctx_contacts_internal') + "~r~n" + &
"as SELECT " + ls_Title + " CTX_BASIC_INFO.ctx_id, app_facility.facility_name, CTX_CONTRACT_CONTACTS.contact_id, CTX_CONTRACT_CONTACTS.association, code_lookup.code aS contract_type_code, code_lookup.description AS contract_type_description, CTX_CONTACTS.first_name, CTX_CONTACTS.last_name, CTX_CONTACTS.middle_name, code_lookup_4.description as contact_title, code_lookup_1.code AS contract_department_code, code_lookup_1.description AS contract_department_description, CTX_CONTACTS.street_1, CTX_CONTACTS.street_2, CTX_CONTACTS.street_3, CTX_CONTACTS.city, CTX_CONTACTS.zip, code_lookup_2.code AS state, CTX_CONTACTS.custom_1, CTX_CONTACTS.custom_2, CTX_CONTACTS.custom_3, CTX_CONTACTS.custom_4, CTX_CONTACTS.custom_5, CTX_CONTACTS.custom_6, CTX_CONTACTS.custom_7, CTX_CONTACTS.custom_8, CTX_CONTACTS.custom_9, CTX_CONTACTS.custom_10, CTX_CONTRACT_CONTACTS.owner, CTX_CONTRACT_CONTACTS.access, code_lookup_3.code AS Phone_Type_code, code_lookup_3.description AS Phone_type_Description, '(' + LEFT( CTX_CONTACTS_NUMBERS.phone,3 ) + ')' + substring( CTX_CONTACTS_NUMBERS.phone, 4, 3) + '-' + RIGHT( CTX_CONTACTS_NUMBERS.phone, 4 ) AS phone , CTX_CONTACTS_NUMBERS.ext, CTX_CONTACTS_NUMBERS.contact_email FROM ((((((((CTX_BASIC_INFO INNER JOIN CTX_CONTRACT_CONTACTS ON CTX_BASIC_INFO.ctx_id = CTX_CONTRACT_CONTACTS.ctx_id) LEFT OUTER JOIN CTX_CONTACTS ON CTX_CONTRACT_CONTACTS.contact_id = CTX_CONTACTS.contact_id) LEFT OUTER JOIN code_lookup ON CTX_CONTACTS.contact_type = code_lookup.lookup_code) LEFT OUTER JOIN code_lookup AS code_lookup_1 ON CTX_CONTACTS.contact_department = code_lookup_1.lookup_code) LEFT OUTER JOIN code_lookup AS code_lookup_2 ON CTX_CONTACTS.state = code_lookup_2.lookup_code) LEFT OUTER JOIN CTX_CONTACTS_NUMBERS ON CTX_CONTACTS.contact_id = CTX_CONTACTS_NUMBERS.contact_id) LEFT OUTER JOIN code_lookup AS code_lookup_3 ON CTX_CONTACTS_NUMBERS.via = code_lookup_3.lookup_code) LEFT OUTER JOIN code_lookup AS code_lookup_4 ON CTX_CONTACTS.contact_title = code_lookup_4.lookup_code) INNER JOIN app_facility ON CTX_BASIC_INFO.app_facility = app_facility.facility_id GROUP BY CTX_BASIC_INFO.ctx_id, app_facility.facility_name, CTX_CONTRACT_CONTACTS.contact_id, CTX_CONTRACT_CONTACTS.association, code_lookup.code, code_lookup.description, CTX_CONTACTS.first_name, CTX_CONTACTS.last_name, CTX_CONTACTS.middle_name, CTX_CONTACTS.contact_title, code_lookup_1.code, code_lookup_1.description, CTX_CONTACTS.street_1, CTX_CONTACTS.street_2, CTX_CONTACTS.street_3, CTX_CONTACTS.city, CTX_CONTACTS.zip, code_lookup_2.code, CTX_CONTACTS.custom_1, CTX_CONTACTS.custom_2, CTX_CONTACTS.custom_3, CTX_CONTACTS.custom_4, CTX_CONTACTS.custom_5, CTX_CONTACTS.custom_6, CTX_CONTACTS.custom_7, CTX_CONTACTS.custom_8, CTX_CONTACTS.custom_9, CTX_CONTACTS.custom_10, CTX_CONTRACT_CONTACTS.owner, CTX_CONTRACT_CONTACTS.access, code_lookup_3.code, code_lookup_3.description, code_lookup_4.description, CTX_CONTACTS_NUMBERS.phone, CTX_CONTACTS_NUMBERS.ext, CTX_CONTACTS_NUMBERS.contact_email, CTX_CONTRACT_CONTACTS.ic_area HAVING (((CTX_CONTRACT_CONTACTS.ic_area)='i')) ORDER BY CTX_BASIC_INFO.ctx_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ctx_custom') + "~r~n" + &
"AS SELECT " + ls_Title + " ctx_id, custom_1, custom_2, custom_3, custom_4, custom_5, custom_6,        custom_7, custom_8, custom_9, custom_10, custom_11, custom_12, custom_13,        custom_14, custom_15, custom_16, custom_17, custom_18, custom_19, custom_20,        custom_date1, custom_date2, custom_date3, custom_date4, custom_date5,        custom_date6, custom_date7, custom_date8, custom_date9, custom_date10,        custom_date11, custom_date12, custom_date13, custom_date14, custom_date15,        custom_n1, custom_n2, custom_n3, custom_n4, custom_n5, custom_n6, custom_n7,        custom_n8, custom_n9, custom_n10 FROM CTX_BASIC_INFO ORDER BY ctx_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ctx_fee_schedule') + "~r~n" + &
"as select " + ls_Title + " ~r~n" + &
"	code_lookup.description as carve_out_type, ~r~n" + &
"	code_lookup_1.description as sched_type, ~r~n" + &
"	ctx_fee_sched_hdr.fee_sched_id, ~r~n" + &
"	ctx_fee_sched_hdr.ctx_id, ~r~n" + &
"	ctx_fee_sched_hdr.custom_1, ~r~n" + &
"	ctx_fee_sched_hdr.custom_2, ~r~n" + &
"	ctx_fee_sched_hdr.custom_3, ~r~n" + &
"	ctx_fee_sched_hdr.custom_4, ~r~n" + &
"	ctx_fee_sched_hdr.custom_5, ~r~n" + &
"	ctx_fee_sched_hdr.notes,~r~n" + &
"	ctx_fee_sched_hdr.inserted_by_user,~r~n" + &
"	ctx_fee_sched_hdr.inserted_at_date_time,~r~n" + &
"	ctx_fee_sched_hdr.updated_by_user,~r~n" + &
"	ctx_fee_sched_hdr.updated_at_date_time, ~r~n" + &
"	ctx_fee_sched_hdr.record_id~r~n" + &
"from(ctx_fee_sched_hdr ~r~n" + &
"left outer join code_lookup on ctx_fee_sched_hdr.carve_out_type = code_lookup.lookup_code) ~r~n" + &
"left outer join code_lookup as code_lookup_1 on ctx_fee_sched_hdr.sched_type = code_lookup_1.lookup_code ~r~n" + &
"order by ctx_fee_sched_hdr.ctx_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ctx_fee_schedule_nm') + "~r~n" + &
"as~r~n" + &
"SELECT " + ls_Title + " ~r~n" + &
"	ctx_fee_sched_nm.ctx_id, ~r~n" + &
"	ctx_fee_sched_nm.fee_sched_nm_id, ~r~n" + &
"	code_lookup.code AS category_code, ~r~n" + &
"	code_lookup.description AS category_description,~r~n" + &
" 	code_lookup_1.code AS system_item_code, ~r~n" + &
"	code_lookup_1.description AS system_item_Description,~r~n" + &
" 	ctx_fee_sched_nm.description, ~r~n" + &
"	ctx_fee_sched_nm.fee,~r~n" + &
"	code_lookup_2.code AS item_status_code, ~r~n" + &
"	ctx_fee_sched_nm.start_date,~r~n" + &
" 	ctx_fee_sched_nm.end_date, ~r~n" + &
"	ctx_fee_sched_nm.service_name, ~r~n" + &
"	ctx_fee_sched_nm.custom_int1,~r~n" + &
" 	ctx_fee_sched_nm.custom_int2, ~r~n" + &
"	ctx_fee_sched_nm.custom_fee1, ~r~n" + &
"	ctx_fee_sched_nm.custom_fee2,~r~n" + &
" 	ctx_fee_sched_nm.custom_fee3, ~r~n" + &
"	ctx_fee_sched_nm.custom_text1, ~r~n" + &
"	ctx_fee_sched_nm.custom_text2,~r~n" + &
" 	ctx_fee_sched_nm.custom_text3, ~r~n" + &
"	ctx_fee_sched_nm.notes, ~r~n" + &
"	ctx_fee_sched_nm.record_id,~r~n" + &
"	ctx_fee_sched_nm.custom_text4,~r~n" + &
"	ctx_fee_sched_nm.custom_text5,~r~n" + &
"	ctx_fee_sched_nm.custom_text6,~r~n" + &
"	ctx_fee_sched_nm.custom_text7,~r~n" + &
"	ctx_fee_sched_nm.custom_text8,~r~n" + &
"	ctx_fee_sched_nm.custom_n1,~r~n" + &
"	ctx_fee_sched_nm.custom_n2,~r~n" + &
"	ctx_fee_sched_nm.custom_n3,~r~n" + &
"	ctx_fee_sched_nm.custom_n4,~r~n" + &
"	ctx_fee_sched_nm.custom_n5,~r~n" + &
"	code_lookup_3.code AS billing_Cycle, ~r~n" + &
"	code_lookup_3.description AS billing_cycle_description~r~n" + &
"FROM~r~n" + &
"(((ctx_fee_sched_nm LEFT OUTER JOIN~r~n" + &
"code_lookup ON ctx_fee_sched_nm.category = code_lookup.lookup_code) LEFT OUTER JOIN~r~n" + &
"code_lookup AS code_lookup_1 ON ctx_fee_sched_nm.service_item = code_lookup_1.lookup_code) LEFT OUTER JOIN~r~n" + &
"code_lookup AS code_lookup_2 ON ctx_fee_sched_nm.item_status = code_lookup_2.lookup_code) LEFT OUTER JOIN~r~n" + &
"code_lookup AS code_lookup_3 ON ctx_fee_sched_nm.billing_cycle = code_lookup_3.lookup_code~r~n" + &
"ORDER BY ctx_fee_sched_nm.ctx_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ctx_feee_schedule_codes') + "~r~n" + &
"as SELECT " + ls_Title + " ~r~n" + &
"	ctx_fee_sched_hdr.ctx_id, ~r~n" + &
"	ctx_fee_sched_data.code, ~r~n" + &
"	code_lookup.description AS carve_out_type_description, ~r~n" + &
"	code_lookup_1.description AS sched_type_description, ~r~n" + &
"	code_lookup_2.description AS location_description, ~r~n" + &
"	code_lookup_2.code AS location_code, ~r~n" + &
"	code_lookup_3.description AS status, ~r~n" + &
"	ctx_fee_sched_data.fee, ~r~n" + &
"	ctx_fee_sched_data.effective_date, ~r~n" + &
"	ctx_fee_sched_data.expiration_date, ~r~n" + &
"	ctx_fee_sched_data.office_fee, ~r~n" + &
"	ctx_fee_sched_data.facility_fee, ~r~n" + &
"	ctx_fee_sched_data.custom_fee, ~r~n" + &
"	ctx_fee_sched_data.precert, ~r~n" + &
"	ctx_fee_sched_data.preauth, ~r~n" + &
"	ctx_fee_sched_data.base_price, ~r~n" + &
"	ctx_fee_sched_data.phys_fee, ~r~n" + &
"	ctx_fee_sched_data.custom_1, ~r~n" + &
"	ctx_fee_sched_data.custom_2, ~r~n" + &
"	ctx_fee_sched_data.custom_3, ~r~n" + &
"	ctx_fee_sched_data.custom_4, ~r~n" + &
"	ctx_fee_sched_data.custom_5, ~r~n" + &
"	ctx_fee_sched_data.fee_basis, ~r~n" + &
"	ctx_fee_sched_data.inserted_by_user, ~r~n" + &
"	ctx_fee_sched_data.inserted_at_date_time, ~r~n" + &
"	ctx_fee_sched_data.updated_by_user, ~r~n" + &
"	ctx_fee_sched_data.updated_at_date_time ~r~n" + &
"FROM (ctx_fee_sched_data ~r~n" + &
"INNER JOIN ((((ctx_fee_sched_hdr ~r~n" + &
"LEFT OUTER JOIN code_lookup ON ctx_fee_sched_hdr.carve_out_type = code_lookup.lookup_code) ~r~n" + &
"LEFT OUTER JOIN code_lookup AS code_lookup_1 ON ctx_fee_sched_hdr.sched_type = code_lookup_1.lookup_code) ~r~n" + &
"INNER JOIN ctx_fee_sched_locations ON ctx_fee_sched_hdr.fee_sched_id = ctx_fee_sched_locations.fee_sched_id) ~r~n" + &
"INNER JOIN code_lookup AS code_lookup_2 ON ctx_fee_sched_locations.location = code_lookup_2.lookup_code) ON ctx_fee_sched_data.fee_sched_location_id = ctx_fee_sched_locations.fee_sched_location_id) ~r~n" + &
"INNER JOIN code_lookup AS code_lookup_3 ON ctx_fee_sched_data.status = code_lookup_3.lookup_code ~r~n" + &
"GROUP BY ctx_fee_sched_hdr.ctx_id, ~r~n" + &
"	ctx_fee_sched_data.code, ~r~n" + &
"	code_lookup.description, ~r~n" + &
"	code_lookup_1.description, code_lookup_2.description, ~r~n" + &
"	code_lookup_2.code, ~r~n" + &
"	code_lookup_3.description, ~r~n" + &
"	ctx_fee_sched_data.fee, ~r~n" + &
"	ctx_fee_sched_data.effective_date, ~r~n" + &
"	ctx_fee_sched_data.expiration_date, ~r~n" + &
"	ctx_fee_sched_data.office_fee, ~r~n" + &
"	ctx_fee_sched_data.facility_fee, ~r~n" + &
"	ctx_fee_sched_data.custom_fee, ~r~n" + &
"	ctx_fee_sched_data.precert, ~r~n" + &
"	ctx_fee_sched_data.preauth, ~r~n" + &
"	ctx_fee_sched_data.base_price, ~r~n" + &
"	ctx_fee_sched_data.phys_fee, ~r~n" + &
"	ctx_fee_sched_data.custom_1, ~r~n" + &
"	ctx_fee_sched_data.custom_2, ~r~n" + &
"	ctx_fee_sched_data.custom_3, ~r~n" + &
"	ctx_fee_sched_data.custom_4, ~r~n" + &
"	ctx_fee_sched_data.custom_5, ~r~n" + &
"	ctx_fee_sched_data.fee_basis, ~r~n" + &
"	ctx_fee_sched_data.inserted_by_user, ~r~n" + &
"	ctx_fee_sched_data.inserted_at_date_time, ~r~n" + &
"	ctx_fee_sched_data.updated_by_user, ~r~n" + &
"	ctx_fee_sched_data.updated_at_date_time ~r~n" + &
"HAVING (((ctx_fee_sched_data.fee)<>0)) ~r~n" + &
"ORDER BY ctx_fee_sched_hdr.ctx_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ctx_feee_schedule_locations') + "~r~n" + &
"as SELECT " + ls_Title + " ~r~n" + &
"	ctx_fee_sched_hdr.fee_sched_id,~r~n" + &
"	ctx_fee_sched_hdr.ctx_id, ~r~n" + &
"	code_lookup.description AS carve_out_type, ~r~n" + &
"	code_lookup_1.description AS sched_type, ~r~n" + &
"	code_lookup_2.description AS location_description, ~r~n" + &
"	code_lookup_2.code AS location_code, ~r~n" + &
"	ctx_fee_sched_hdr.custom_1,~r~n" + &
"	ctx_fee_sched_hdr.custom_2,~r~n" + &
"	ctx_fee_sched_hdr.custom_3,~r~n" + &
"	ctx_fee_sched_hdr.custom_4,~r~n" + &
"	ctx_fee_sched_hdr.custom_5,~r~n" + &
"	ctx_fee_sched_hdr.notes,~r~n" + &
"	ctx_fee_sched_hdr.inserted_by_user,~r~n" + &
"	ctx_fee_sched_hdr.inserted_at_date_time,~r~n" + &
"	ctx_fee_sched_hdr.updated_by_user,~r~n" + &
"	ctx_fee_sched_hdr.updated_at_date_time,~r~n" + &
"	ctx_fee_sched_hdr.record_id,~r~n" + &
"	ctx_fee_sched_locations.rate, ~r~n" + &
"	ctx_fee_sched_locations.fee_bonus, ~r~n" + &
"	ctx_item.item_name AS fee_basis ~r~n" + &
"FROM ((((ctx_fee_sched_hdr ~r~n" + &
"LEFT OUTER JOIN code_lookup ON ctx_fee_sched_hdr.carve_out_type = code_lookup.lookup_code) ~r~n" + &
"LEFT OUTER JOIN code_lookup AS code_lookup_1 ON ctx_fee_sched_hdr.sched_type = code_lookup_1.lookup_code) ~r~n" + &
"INNER JOIN ctx_fee_sched_locations ON ctx_fee_sched_hdr.fee_sched_id = ctx_fee_sched_locations.fee_sched_id) ~r~n" + &
"INNER JOIN code_lookup AS code_lookup_2 ON ctx_fee_sched_locations.location = code_lookup_2.lookup_code) ~r~n" + &
"LEFT OUTER JOIN ctx_item ON ctx_fee_sched_locations.fee_bonus = ctx_item.item_id ~r~n" + &
"ORDER BY ctx_fee_sched_hdr.ctx_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ctx_feee_schedule_practitioners') + "~r~n" + &
"as SELECT " + ls_Title + " ~r~n" + &
"	ctx_fee_sched_hdr.ctx_id, ~r~n" + &
"	code_lookup.description AS carve_out_type, ~r~n" + &
"	code_lookup_1.description AS sched_type, ~r~n" + &
"	pd_basic.last_name, ~r~n" + &
"	pd_basic.first_name, ~r~n" + &
"	pd_basic.prac_id ~r~n" + &
"FROM (((ctx_fee_sched_hdr ~r~n" + &
"LEFT OUTER JOIN code_lookup ON ctx_fee_sched_hdr.carve_out_type = code_lookup.lookup_code) ~r~n" + &
"LEFT OUTER JOIN code_lookup AS code_lookup_1 ON ctx_fee_sched_hdr.sched_type = code_lookup_1.lookup_code) ~r~n" + &
"INNER JOIN ctx_fee_sched_pracs ON ctx_fee_sched_hdr.fee_sched_id = ctx_fee_sched_pracs.fee_sched_id) ~r~n" + &
"INNER JOIN pd_basic ON ctx_fee_sched_pracs.practitioner_id = pd_basic.prac_id ~r~n" + &
"ORDER BY ctx_fee_sched_hdr.fee_sched_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ctx_groups') + "~r~n" + &
"as select " + ls_Title + " ~r~n" + &
"	ctx_loc.ctx_id, ~r~n" + &
"	ctx_loc.parent_comp_id, ~r~n" + &
"	app_facility.facility_name, ~r~n" + &
"	group_multi_loc.rec_id, ~r~n" + &
"	group_multi_loc.gp_name, ~r~n" + &
"	group_multi_loc.street1, ~r~n" + &
"	group_multi_loc.city, ~r~n" + &
"	group_multi_loc.state, ~r~n" + &
"	group_multi_loc.phone, ~r~n" + &
"	group_multi_loc.zip, ~r~n" + &
"	group_multi_loc.contact_name~r~n" + &
"from((group_multi_loc join ctx_loc on group_multi_loc.rec_id = ctx_loc.parent_comp_id) ~r~n" + &
"join CTX_BASIC_INFO on ctx_loc.ctx_id = CTX_BASIC_INFO.ctx_id) ~r~n" + &
"join app_facility on CTX_BASIC_INFO.app_facility = app_facility.facility_id ~r~n" + &
"group by ctx_loc.ctx_id,~r~n" + &
"	ctx_loc.parent_comp_id,~r~n" + &
"	app_facility.facility_name,~r~n" + &
"	group_multi_loc.rec_id,~r~n" + &
"	group_multi_loc.gp_name,~r~n" + &
"	group_multi_loc.street1,~r~n" + &
"	group_multi_loc.city,~r~n" + &
"	group_multi_loc.state,~r~n" + &
"	group_multi_loc.phone,~r~n" + &
"	group_multi_loc.zip,~r~n" + &
"	group_multi_loc.contact_name ~r~n" + &
"order by ctx_loc.ctx_id,ctx_loc.parent_comp_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ctx_groups_locations') + "~r~n" + &
"as SELECT " + ls_Title + " ~r~n" + &
"	ctx_loc.ctx_id, ~r~n" + &
"	app_facility.facility_name, ~r~n" + &
"	group_multi_loc.gp_name, ~r~n" + &
"	ctx_loc.parent_comp_id AS grp_id, ~r~n" + &
"	ctx_loc.loc_id, ~r~n" + &
"	group_practice.practice_type, ~r~n" + &
"	group_practice.active_status, ~r~n" + &
"	group_practice.street AS location_name, ~r~n" + &
"	group_practice.street_2, ~r~n" + &
"	group_practice.city, ~r~n" + &
"	code_lookup_1.code AS state, ~r~n" + &
"	code_lookup.description AS country, ~r~n" + &
"	group_practice.pager_number, ~r~n" + &
"	group_practice.phone, ~r~n" + &
"	group_practice.ext, ~r~n" + &
"	group_practice.fax, ~r~n" + &
"	group_practice.zip, ~r~n" + &
"	group_practice.contact_person, ~r~n" + &
"	group_practice.e_mail_address, ~r~n" + &
"	group_practice.web_address ~r~n" + &
"FROM (((((group_multi_loc ~r~n" + &
"INNER JOIN ctx_loc ON group_multi_loc.rec_id = ctx_loc.parent_comp_id) ~r~n" + &
"INNER JOIN ctx_basic_info ON ctx_loc.ctx_id = ctx_basic_info.ctx_id) ~r~n" + &
"INNER JOIN app_facility ON ctx_basic_info.app_facility = app_facility.facility_id) ~r~n" + &
"INNER JOIN group_practice ON ctx_loc.loc_id = group_practice.rec_id) ~r~n" + &
"LEFT OUTER JOIN code_lookup ON group_practice.country = code_lookup.lookup_code) ~r~n" + &
"LEFT OUTER JOIN code_lookup AS code_lookup_1 ON group_practice.state = code_lookup_1.lookup_code ~r~n" + &
"GROUP BY ctx_loc.ctx_id, ~r~n" + &
"	app_facility.facility_name, ~r~n" + &
"	group_multi_loc.gp_name, ~r~n" + &
"	ctx_loc.parent_comp_id, ~r~n" + &
"	ctx_loc.loc_id, ~r~n" + &
"	group_practice.practice_type, ~r~n" + &
"	group_practice.active_status, ~r~n" + &
"	group_practice.street, ~r~n" + &
"	group_practice.street_2, ~r~n" + &
"	group_practice.city, ~r~n" + &
"	code_lookup_1.code, ~r~n" + &
"	code_lookup.description, ~r~n" + &
"	group_practice.pager_number, ~r~n" + &
"	group_practice.phone, ~r~n" + &
"	group_practice.ext, ~r~n" + &
"	group_practice.fax, ~r~n" + &
"	group_practice.zip, ~r~n" + &
"	group_practice.contact_person, ~r~n" + &
"	group_practice.e_mail_address, ~r~n" + &
"	group_practice.web_address ~r~n" + &
"ORDER BY ctx_loc.ctx_id,ctx_loc.parent_comp_id,ctx_loc.loc_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ctx_image') + "~r~n" + &
"AS SELECT " + ls_Title + " ~r~n" + &
"	ctx_images.ctx_id, ~r~n" + &
"	ctx_images.file_name, ~r~n" + &
"	code_lookup.description AS Image_Type, ~r~n" + &
"	code_lookup_1.description AS media_type, ~r~n" + &
"	ctx_images.page_description, ~r~n" + &
"	ctx_image.image_version, ~r~n" + &
"	ctx_image.inserted_by_user, ~r~n" + &
"	ctx_image.updated_by_user, ~r~n" + &
"	ctx_image.inserted_at_date_time, ~r~n" + &
"	ctx_image.updated_at_date_time~r~n" + &
"FROM ctx_image ~r~n" + &
"INNER JOIN ctx_images ON ctx_image.ctx_id = ctx_images.ctx_id AND ctx_image.image_id = ctx_images.image_id ~r~n" + &
"LEFT OUTER JOIN code_lookup ON ctx_images.image_type = code_lookup.lookup_code ~r~n" + &
"LEFT OUTER JOIN code_lookup code_lookup_1 ON ctx_images.media_type = code_lookup_1.lookup_code~r~n" + &
"ORDER BY ctx_images.image_id,ctx_images.ctx_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ctx_locations_pracs') + "~r~n" + &
"as SELECT " + ls_Title + " CTX_LOC.ctx_id, CTX_LOC.parent_comp_id AS grp_id, group_practice.street AS locatioin_name, CTX_LOC.loc_id, pd_basic.last_name, pd_basic.first_name, pd_basic.prac_id FROM ((CTX_LOC INNER JOIN CTX_LOCATION_PRACS ON (CTX_LOC.ctx_id = CTX_LOCATION_PRACS.ctx_id) AND (CTX_LOC.parent_comp_id = CTX_LOCATION_PRACS.parent_comp_id) AND (CTX_LOC.loc_id = CTX_LOCATION_PRACS.loc_id)) INNER JOIN pd_basic ON CTX_LOCATION_PRACS.prac_id = pd_basic.prac_id) INNER JOIN group_practice ON CTX_LOCATION_PRACS.loc_id = group_practice.rec_id GROUP BY CTX_LOC.ctx_id, CTX_LOC.parent_comp_id, group_practice.street, CTX_LOC.loc_id, pd_basic.last_name, pd_basic.first_name, pd_basic.prac_id HAVING (((CTX_LOC.loc_id)<>0)) ORDER BY CTX_LOC.ctx_id, CTX_LOC.parent_comp_id,CTX_LOC.loc_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ctx_locations_speciality') + "~r~n" + &
"as SELECT " + ls_Title + " CTX_LOC.ctx_id, CTX_LOC.parent_comp_id AS grp_id, group_practice.street AS location_name, CTX_LOC.loc_id, code_lookup.description AS specialty_description, code_lookup.code AS speciality_code FROM ((CTX_LOC INNER JOIN CTX_LOCATION_SPECIALTY ON (CTX_LOC.loc_id = CTX_LOCATION_SPECIALTY.loc_id) AND (CTX_LOC.parent_comp_id = CTX_LOCATION_SPECIALTY.parent_comp_id) AND (CTX_LOC.ctx_id = CTX_LOCATION_SPECIALTY.ctx_id)) INNER JOIN code_lookup ON CTX_LOCATION_SPECIALTY.Prac_specialty = code_lookup.lookup_code) INNER JOIN group_practice ON CTX_LOCATION_SPECIALTY.loc_id = group_practice.rec_id GROUP BY CTX_LOC.ctx_id, CTX_LOC.parent_comp_id, group_practice.street, CTX_LOC.loc_id, code_lookup.description, code_lookup.code HAVING (((CTX_LOC.loc_id)<>0)) ORDER BY CTX_LOC.ctx_id, CTX_LOC.parent_comp_id,CTX_LOC.loc_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ctx_organizations') + "~r~n" + &
"as SELECT " + ls_Title + " CTX_ORGS_CONTACT.ctx_id, CTX_ORGS.org_name, code_lookup.code AS org_type_code, code_lookup.description AS org_type_description, CTX_ORGS.status, CTX_ORGS.street_1, CTX_ORGS.street_2, CTX_ORGS.street_3, CTX_ORGS.city, code_lookup_1.code AS state, CTX_ORGS.zip, CTX_ORGS_CONTACT.notes, CTX_ORGS.drections, CTX_ORGS.record_id, CTX_ORG_CONTACT.contact_name, CTX_ORG_CONTACT.department, code_lookup_2.code AS phone_type_code, CTX_ORG_CONTACT.phone FROM ((((CTX_ORGS LEFT OUTER JOIN code_lookup ON CTX_ORGS.org_type = code_lookup.lookup_code) LEFT OUTER JOIN code_lookup AS code_lookup_1 ON CTX_ORGS.state = code_lookup_1.lookup_code) INNER JOIN CTX_ORGS_CONTACT ON CTX_ORGS.org_id = CTX_ORGS_CONTACT.org_id) LEFT OUTER JOIN CTX_ORG_CONTACT ON CTX_ORGS.org_id = CTX_ORG_CONTACT.org_id) LEFT OUTER JOIN code_lookup AS code_lookup_2 ON CTX_ORG_CONTACT.via = code_lookup_2.lookup_code GROUP BY CTX_ORGS_CONTACT.ctx_id, CTX_ORGS.org_name, code_lookup.code, code_lookup.description, CTX_ORGS.status, CTX_ORGS.street_1, CTX_ORGS.street_2, CTX_ORGS.street_3, CTX_ORGS.city, code_lookup_1.code, CTX_ORGS.zip, CTX_ORGS_CONTACT.notes, CTX_ORGS.drections, CTX_ORGS.record_id, CTX_ORG_CONTACT.contact_name, CTX_ORG_CONTACT.department, code_lookup_2.code, CTX_ORG_CONTACT.phone ORDER BY CTX_ORGS_CONTACT.ctx_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ctx_requirement') + "~r~n" + &
"AS SELECT " + ls_Title + " CTX_REQ_PROFILE_HDR_1.ctx_id,	~r~n" + &
"CTX_RQMNT_CATEGORY.category_name,	~r~n" + &
"CTX_REQ_PROFILE.rqmnt_name,	~r~n" + &
"CTX_REQ_PROFILE.rqmnt_description,	~r~n" + &
"CTX_REQ_TMPLT_ELEMENT.element_name,	~r~n" + &
"DataValue = (case ctx_req_tmplt_element.value_type when 1 then CTX_ELEMENTS.date_value when 2 then CTX_ELEMENTS.field_value when 3 then CTX_ELEMENTS.char_value when 4 then CTX_ELEMENTS.integer_value when 5 then CTX_ELEMENTS.field_value end),~r~n" + &
"CTX_ELEMENTS.clause ~r~n" + &
"FROM (CTX_RQMNT_CATEGORY ~r~n" + &
"INNER JOIN ((CTX_REQ_PROFILE INNER JOIN CTX_REQ_PROFILE_HDR AS CTX_REQ_PROFILE_HDR_1 ON CTX_REQ_PROFILE.ctx_req_profile_id = CTX_REQ_PROFILE_HDR_1.ctx_req_profile_id) ~r~n" + &
"INNER JOIN CTX_REQ_TMPLT_ELEMENT ON  CTX_REQ_PROFILE.ctx_req_profile_id = CTX_REQ_TMPLT_ELEMENT.ctx_req_profile_id) ~r~n" + &
"ON (CTX_RQMNT_CATEGORY.ctx_req_profile_id = CTX_REQ_TMPLT_ELEMENT.ctx_req_profile_id) AND (CTX_RQMNT_CATEGORY.ctx_rqmnt_category_id = CTX_REQ_TMPLT_ELEMENT.ctx_rqmnt_category_id)) ~r~n" + &
"INNER JOIN CTX_ELEMENTS ON (CTX_ELEMENTS.ctx_req_tmplt_element_id = CTX_REQ_TMPLT_ELEMENT.ctx_req_tmplt_element_id) AND (CTX_REQ_PROFILE_HDR_1.ctx_id = CTX_ELEMENTS.CTX_REQ_PROFILE_HDR_id) ~r~n" + &
"ORDER BY CTX_REQ_PROFILE_HDR_1.ctx_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_dea') + "~r~n" + &
"  as select " + ls_Title + " pd_dea_state_csr.rec_id,~r~n" + &
"    pd_dea_state_csr.prac_id,~r~n" + &
"    pd_dea_state_csr.cat_1,~r~n" + &
"    pd_dea_state_csr.cat_2,~r~n" + &
"    pd_dea_state_csr.cat_3,~r~n" + &
"    pd_dea_state_csr.cat_4,~r~n" + &
"    pd_dea_state_csr.cat_5,~r~n" + &
"    pd_dea_state_csr.cat_6,~r~n" + &
"    pd_dea_state_csr.cat_7,~r~n" + &
"    pd_dea_state_csr.cat_8,~r~n" + &
"    pd_dea_state_csr.cat_9,~r~n" + &
"    pd_dea_state_csr.cat_10,~r~n" + &
"    code_lookup.code as state_code,~r~n" + &
"    code_lookup.description as state_desc,~r~n" + &
"    pd_dea_state_csr.prev_exp_date,~r~n" + &
"    pd_dea_state_csr.expiration_date,~r~n" + &
"    pd_dea_state_csr.cust_1,~r~n" + &
"    pd_dea_state_csr.cust_2,~r~n" + &
"    pd_dea_state_csr.cust_3,~r~n" + &
"    pd_dea_state_csr.cust_4,~r~n" + &
"    pd_dea_state_csr.cust_5,~r~n" + &
"    pd_dea_state_csr.license_number,~r~n" + &
"    pd_dea_state_csr.active_status from~r~n" + &
"    pd_dea_state_csr left outer join~r~n" + &
"    code_lookup on~r~n" + &
"    pd_dea_state_csr.state = code_lookup.lookup_code~r~n" + &
"order by pd_dea_state_csr.rec_id,pd_dea_state_csr.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_dea_state_csr') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     pd_dea_state_csr.rec_id, pd_dea_state_csr.prac_id, pd_dea_state_csr.cat_1, pd_dea_state_csr.cat_2, pd_dea_state_csr.cat_3, ~r~n" + &
"                      pd_dea_state_csr.cat_4, pd_dea_state_csr.cat_5, pd_dea_state_csr.cat_6, pd_dea_state_csr.cat_7, pd_dea_state_csr.cat_8, ~r~n" + &
"                      pd_dea_state_csr.cat_9, pd_dea_state_csr.cat_10, code_lookup.code, code_lookup.description, ~r~n" + &
"                      pd_dea_state_csr.prev_exp_date, pd_dea_state_csr.expiration_date, pd_dea_state_csr.cust_1, pd_dea_state_csr.cust_2, ~r~n" + &
"                      pd_dea_state_csr.cust_3, pd_dea_state_csr.cust_4, pd_dea_state_csr.cust_5, pd_dea_state_csr.license_number, ~r~n" + &
"                      pd_dea_state_csr.active_status, pd_dea_state_csr.cust_6, pd_dea_state_csr.cust_7, pd_dea_state_csr.cust_8, ~r~n" + &
"                      pd_dea_state_csr.cust_9, pd_dea_state_csr.cust_10, pd_dea_state_csr.cust_d1, pd_dea_state_csr.cust_d2, ~r~n" + &
"                      pd_dea_state_csr.issue_date, code_lookup.code AS state_code, code_lookup.description AS state_description~r~n" + &
"FROM         pd_dea_state_csr LEFT OUTER JOIN~r~n" + &
"                      code_lookup ON pd_dea_state_csr.state = code_lookup.lookup_code~r~n" + &
"ORDER BY pd_dea_state_csr.rec_id, pd_dea_state_csr.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_dept') + "~r~n" + &
"  as select distinct " + ls_Title + " pd_affil_dept.rec_id,~r~n" + &
"    pd_affil_dept.prac_id,~r~n" + &
"    pd_affil_dept.facility_id,~r~n" + &
"    facility.facility_name as facility_name,~r~n" + &
"    code_lookup_a.code as dept_code,~r~n" + &
"    code_lookup_a.description as dept_name,~r~n" + &
"    code_lookup_b.code as section_code,~r~n" + &
"    code_lookup_b.description as section_name,~r~n" + &
"    code_lookup_d.code as division_code,~r~n" + &
"    code_lookup_d.description as division_name,~r~n" + &
"    pd_affil_dept.primary_dept,~r~n" + &
"    pd_affil_dept.from_date,~r~n" + &
"    pd_affil_dept.to_date,~r~n" + &
"    pd_affil_dept.record_status,~r~n" + &
"    pd_affil_dept.active_status ~r~n" + &
"from pd_affil_dept left outer join code_lookup as code_lookup_b on (pd_affil_dept.section = code_lookup_b.lookup_code) left outer join code_lookup as code_lookup_c on (pd_affil_dept.memberships = code_lookup_c.lookup_code) left outer join code_lookup as code_lookup_d on (pd_affil_dept.rank = code_lookup_d.lookup_code) left outer join facility on (pd_affil_dept.facility_id = facility.facility_id) left outer join code_lookup as code_lookup_a on (pd_affil_dept.department = code_lookup_a.lookup_code)~r~n" + &
"order by pd_affil_dept.rec_id,pd_affil_dept.prac_id,pd_affil_dept.facility_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ecfmg') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     prac_id, date_issued, date_expires, ecfmg_number, cust_1, cust_2, cust_4, cust_3, cust_5, cust_6, cust_7, cust_8, cust_9, cust_10, cust_d1, ~r~n" + &
"                      cust_d2~r~n" + &
"FROM         pd_ecfmg~r~n" + &
"ORDER BY rec_id,prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_education') + "~r~n" + &
"as select " + ls_Title + " pd_education.rec_id,pd_education.prac_id,ed_type_code=code_lookup_a.code,ed_type_description=code_lookup_a.description,degree_code=code_lookup_b.code,degree_description=code_lookup_b.description,pd_education.major,pd_education.month_from,pd_education.year_from,pd_education.month_thru,pd_education.year_thru,school_code=address_lookup.code,school_name=address_lookup.entity_name,pd_education.cust_1,pd_education.cust_2,pd_education.cust_3,pd_education.cust_4,pd_education.cust_5 from(((pd_education left outer join code_lookup as code_lookup_a on pd_education.education_type = code_lookup_a.lookup_code) left outer join code_lookup as code_lookup_b on pd_education.degree = code_lookup_b.lookup_code) left outer join address_lookup on pd_education.school_code = address_lookup.lookup_code) order by pd_education.rec_id,pd_education.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_full_name') + "~r~n" + &
"AS~r~n" + &
"SELECT  " + ls_Title + " title = code_lookup_1.code,~r~n" + &
"title_description = code_lookup_1.description,~r~n" + &
"first_name, middle_name, last_name,~r~n" + &
"prof_suffix = code_lookup_2.code,~r~n" + &
"prof_suffix_descp = code_lookup_2.description,~r~n" + &
"gemder = code_lookup_3.description,~r~n" + &
"SUBSTRING(ISNULL(ssn, ''), 1, 3) ~r~n" + &
"                      + '-' + SUBSTRING(ISNULL(ssn, ''), 4, 2) + '-' + SUBSTRING(ISNULL(ssn, ''), 6, 4) AS ssn, LTRIM(RTRIM(ISNULL(last_name, ''))) ~r~n" + &
"                      + ', ' + ISNULL(first_name, '') + ' ' + SUBSTRING(ISNULL(middle_name, ''), 1, 1) + CASE WHEN isnull(pd_basic.middle_name, '') ~r~n" + &
"                      = '' THEN '' ELSE '.,' END + LTRIM(RTRIM(ISNULL(code_lookup_4.code,''))) + CASE WHEN isnull~r~n" + &
"                          (code_lookup_4.code,'') = '' THEN '' ELSE ', ' END + LTRIM(RTRIM(ISNULL~r~n" + &
"                          (code_lookup_2.code,''))) AS full_name,~r~n" + &
"prac_id,~r~n" + &
"date_of_birth,~r~n" + &
"rec_id,~r~n" + &
"cust_1,~r~n" + &
"cust_2,~r~n" + &
"cust_3,~r~n" + &
"cust_4,~r~n" + &
"cust_5,~r~n" + &
"cust_11,~r~n" + &
"cust_12,~r~n" + &
"cust_13,~r~n" + &
"cust_14,~r~n" + &
"cust_15,~r~n" + &
"cust_d1,~r~n" + &
"cust_d2,~r~n" + &
"provider_id ~r~n" + &
"FROM    pd_basic ~r~n" + &
"                   left outer join code_lookup code_lookup_1 on (pd_basic.title = code_lookup_1.lookup_code)~r~n" + &
"                   left outer join code_lookup code_lookup_2 on (pd_basic.prof_suffix = code_lookup_2.lookup_code)~r~n" + &
"                   left outer join code_lookup code_lookup_3 on (pd_basic.sex = code_lookup_3.lookup_code)~r~n" + &
"                   left outer join code_lookup code_lookup_4 on (pd_basic.name_suffix = code_lookup_4.lookup_code)~r~n" + &
"order by rec_id,prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_fullbasic') + "~r~n" + &
"AS~r~n" + &
"SELECT DISTINCT " + ls_Title + "~r~n" + &
"                      pd_basic.prac_id, pd_basic.first_name, pd_basic.last_name, pd_basic.middle_name, pd_basic.date_of_birth, pd_basic.ssn, ~r~n" + &
"                      pd_basic.maiden_other_name, pd_basic.pob_city, pd_basic.spouse_name, pd_basic.phone, pd_basic.answering_service, ~r~n" + &
"                      pd_basic.beeper_1, pd_basic.beeper_2, pd_basic.personal_pager, pd_basic.hospital_pager, pd_basic.car_phone_1, ~r~n" + &
"                      pd_basic.car_phone_2, pd_basic.branch, pd_basic.rank, pd_basic.service_number, pd_basic.service_date_from, ~r~n" + &
"                      pd_basic.service_date_to, pd_basic.cust_1, pd_basic.cust_2, pd_basic.cust_3, pd_basic.cust_5, pd_basic.cust_6, ~r~n" + &
"                      pd_basic.cust_7, pd_basic.cust_8, pd_basic.cust_9, pd_basic.cust_10, pd_basic.full_name, pd_basic.provider_id, ~r~n" + &
"                      pd_basic.cust_4, pd_basic.conv_prac_id, code_lookup_a.code AS title_a_code, code_lookup_a.description AS title_a_description, ~r~n" + &
"                      code_lookup_b.code AS name_suffic_b_code, code_lookup_b.description AS name_suffic_b_description, code_lookup_e.code AS prac_cat_e_code, ~r~n" + &
"                      code_lookup_e.description AS prac_Cat_e_description, code_lookup_g.code AS county_g_code, code_lookup_g.description AS county_g_description, ~r~n" + &
"                      code_lookup_c.code AS prof_suffix_c_code, code_lookup_c.description AS prof_suffix_c_description, code_lookup_f.code AS state_f_code, ~r~n" + &
"                      code_lookup_f.description AS state_f_description, code_lookup_i.code AS married_i_code, code_lookup_h.code AS citizens_h_code, ~r~n" + &
"                      code_lookup_d.code AS sex_d_code, code_lookup_d.description AS sex_d_description, code_lookup_k.code AS military_k_code, ~r~n" + &
"                      code_lookup_l.code AS reserve_l_code, code_lookup_j.code AS fed_emp_j_code, code_lookup_m.code AS npdb_m_code, ~r~n" + &
"                      code_lookup_n.code AS prov_type_n_code, code_lookup_n.description AS prov_type_n_description, code_lookup_o.code AS oig_o_code, ~r~n" + &
"                      pd_basic.cust_11, pd_basic.cust_12, pd_basic.cust_13, pd_basic.cust_14, pd_basic.cust_15, pd_basic.cust_d1, ~r~n" + &
"                      pd_basic.cust_d2, pd_basic.npi_number, pd_basic.used_another_name, pd_basic.start_another_name, ~r~n" + &
"                      pd_basic.end_another_name~r~n" + &
"FROM         pd_basic LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_a ON pd_basic.title = code_lookup_a.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_b ON pd_basic.name_suffix = code_lookup_b.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_c ON pd_basic.prof_suffix = code_lookup_c.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_d ON pd_basic.sex = code_lookup_d.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_e ON pd_basic.prac_category = code_lookup_e.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_f ON pd_basic.pob_state = code_lookup_f.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_g ON pd_basic.pob_country = code_lookup_g.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_h ON pd_basic.citizenship = code_lookup_h.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_i ON pd_basic.married = code_lookup_i.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_j ON pd_basic.civilian_fed_employee = code_lookup_j.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_k ON pd_basic.active_military = code_lookup_k.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_l ON pd_basic.reservist = code_lookup_l.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_m ON pd_basic.npdb_query = code_lookup_m.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_n ON pd_basic.provider_type = code_lookup_n.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_o ON pd_basic.oig_query = code_lookup_o.lookup_code~r~n" + &
"ORDER BY pd_basic.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_gp_covering_partners') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     gp_partner_covering.rec_id, gp_partner_covering.gp_id, gp_partner_covering.prac_id, cl_title.code AS title_code, ~r~n" + &
"                      cl_title.description AS title_description, gp_partner_covering.last_name, gp_partner_covering.first_name, ~r~n" + &
"                      cl_provider_type.code AS provider_type_code, cl_provider_type.description AS provider_type_description, cl_specialty.code AS specialty_code, ~r~n" + &
"                      cl_specialty.description AS specialty_description, cl_covering.code AS covering_code, cl_covering.description AS covering_description, ~r~n" + &
"                      cl_partner.code AS partner_code, cl_partner.description AS partner_description, gp_partner_covering.license_no AS license_number, ~r~n" + &
"                      cl_license_state.code AS license_state_code, cl_license_state.description AS license_state_description, gp_partner_covering.cust_1, ~r~n" + &
"                      gp_partner_covering.cust_2, gp_partner_covering.cust_3, gp_partner_covering.cust_d4, gp_partner_covering.cust_d5, ~r~n" + &
"                      gp_partner_covering.specialty, gp_partner_covering.provider_type, gp_partner_covering.covering, gp_partner_covering.partner, ~r~n" + &
"                      gp_partner_covering.title_code AS Expr1, gp_partner_covering.middle_name~r~n" + &
"FROM    gp_partner_covering left outer join  code_lookup cl_covering on (cl_covering.lookup_code = gp_partner_covering.covering )~r~n" + &
"left outer join  code_lookup cl_title ON cl_title.lookup_code = gp_partner_covering.title_code ~r~n" + &
"LEFT OUTER JOIN code_lookup cl_license_state ON gp_partner_covering.license_state = cl_license_state.lookup_code~r~n" + &
"LEFT OUTER JOIN code_lookup cl_partner ON gp_partner_covering.partner = cl_partner.lookup_code ~r~n" + &
"LEFT OUTER JOIN code_lookup cl_provider_type ON gp_partner_covering.provider_type = cl_provider_type.lookup_code ~r~n" + &
"left outer join code_lookup cl_specialty ON cl_specialty.lookup_code = gp_partner_covering.specialty~r~n" + &
"ORDER BY gp_partner_covering.rec_id, gp_partner_covering.gp_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_gp_insurance') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     gp_insurance.rec_id, gp_insurance.gp_id, gp_insurance.carrier_code, address_lookup.entity_name AS carrier, ~r~n" + &
"                      gp_insurance.policy_number, gp_insurance.coverage_from, gp_insurance.coverage_to, gp_insurance.previous_expiration_date, ~r~n" + &
"                      gp_insurance.tail_coverage, cl_tail_coverage.code AS tail_coverage_code, cl_tail_coverage.description AS tail_coverage_description, ~r~n" + &
"                      gp_insurance.coverage_limit_from, gp_insurance.coverage_limit_to, gp_insurance.state_funded_pool, ~r~n" + &
"                      cl_state_funded.code AS state_funded_pool_code, cl_state_funded.description AS state_funded_pool_description, gp_insurance.state_coverage, ~r~n" + &
"                      cl_state_coverage.code AS state_coverage_code, cl_state_coverage.description AS state_coverage_description, gp_insurance.exclusions, ~r~n" + &
"                      gp_insurance.cust_1, gp_insurance.cust_2, gp_insurance.cust_3, gp_insurance.cust_d4, gp_insurance.cust_d5, ~r~n" + &
"                      gp_insurance.claims_made_occurrence, gp_insurance.denied_explain, gp_insurance.active_status, gp_insurance.prac_id~r~n" + &
"FROM         gp_insurance LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_state_coverage ON gp_insurance.state_coverage = cl_state_coverage.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_state_funded ON gp_insurance.state_funded_pool = cl_state_funded.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_tail_coverage ON gp_insurance.tail_coverage = cl_tail_coverage.lookup_code LEFT OUTER JOIN~r~n" + &
"                      address_lookup ON gp_insurance.carrier_code = address_lookup.lookup_code~r~n" + &
"ORDER BY gp_insurance.rec_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_gp_languages') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     gp_language.rec_id, gp_language.gp_id, gp_language.prac_id, cl_language.code AS language_code, ~r~n" + &
"                      cl_language.description AS language_description, cl_speak.code AS speak_code, cl_speak.description AS speak_description, ~r~n" + &
"                      cl_reads.code AS reads_code, cl_reads.description AS reads_description, cl_writes.code AS writes_code, cl_writes.description AS writes_description, ~r~n" + &
"                      cl_sign.code AS sign_code, cl_sign.description AS sign_description, gp_language.cust_1, gp_language.cust_2, gp_language.cust_3, ~r~n" + &
"                      gp_language.cust_d4, gp_language.cust_d5, gp_language.foreign_language AS [language], gp_language.speak, ~r~n" + &
"                      gp_language.reads, gp_language.writes, gp_language.sign~r~n" + &
"FROM code_lookup cl_sign INNER JOIN gp_language ON cl_sign.lookup_code = gp_language.sign~r~n" + &
"INNER JOIN code_lookup cl_speak ON cl_speak.lookup_code = gp_language.speak ~r~n" + &
"INNER JOIN code_lookup cl_language ON gp_language.foreign_language = cl_language.lookup_code ~r~n" + &
"INNER JOIN code_lookup cl_reads ON gp_language.reads = cl_reads.lookup_code ~r~n" + &
"INNER JOIN code_lookup cl_writes ON gp_language.writes = cl_writes.lookup_code ~r~n" + &
"ORDER BY gp_language.rec_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_gp_other_ids') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     gp_other_ids.rec_id, gp_other_ids.gp_id, gp_other_ids.prac_id, code_lookup.code AS id_type_code, ~r~n" + &
"                      code_lookup.description AS id_type_description, gp_other_ids.id_number, gp_other_ids.exp_date, gp_other_ids.cust_1, ~r~n" + &
"                      gp_other_ids.cust_2, gp_other_ids.cust_3, gp_other_ids.cust_d4, gp_other_ids.cust_d5, gp_other_ids.id_type~r~n" + &
"FROM         gp_other_ids INNER JOIN~r~n" + &
"                      code_lookup ON gp_other_ids.id_type = code_lookup.lookup_code~r~n" + &
"ORDER BY gp_other_ids.rec_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_gp_plans') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     rec_id, gp_id, plan_id, active_status, start_date, end_date, prac_id~r~n" + &
"FROM         gp_plans~r~n" + &
"ORDER BY rec_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_gp_practice_info') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     gp_practice_info.rec_id, gp_practice_info.gp_id, gp_practice_info.prac_id, gp_practice_info.corporate_name, ~r~n" + &
"                      gp_practice_info.start_date, gp_practice_info.check_payable, gp_practice_info.billing_dept, ~r~n" + &
"                      cl_after_hours_coverage.description AS after_hours_coverage, cl_after_hours_type.description AS after_hours_type, ~r~n" + &
"                      gp_practice_info.after_hours_number, cl_pref_contact_method.description AS preferred_contact_method, ~r~n" + &
"                      cl_primary_tax_id.description AS primary_tax_id, cl_gender_limitations.description AS gender_limitations, gp_practice_info.min_age, ~r~n" + &
"                      gp_practice_info.max_age, gp_practice_info.other_limitations, gp_practice_info.other_handi_access, ~r~n" + &
"                      gp_practice_info.other_disability_service, gp_practice_info.other_trans_access, gp_practice_info.cust_1, gp_practice_info.cust_2, ~r~n" + &
"                      gp_practice_info.cust_3, gp_practice_info.cust_4, gp_practice_info.cust_5, gp_practice_info.cust_d1, ~r~n" + &
"                      gp_practice_info.cust_d2~r~n" + &
"FROM    gp_practice_info LEFT OUTER JOIN code_lookup cl_after_hours_coverage ON cl_after_hours_coverage.lookup_code = gp_practice_info.after_hours_coverage~r~n" + &
"LEFT OUTER JOIN code_lookup cl_pref_contact_method  ON cl_pref_contact_method.lookup_code = gp_practice_info.prefered_contact_method ~r~n" + &
"LEFT OUTER JOIN code_lookup cl_gender_limitations ON gp_practice_info.gender_limitations = cl_gender_limitations.lookup_code ~r~n" + &
"LEFT OUTER JOIN code_lookup cl_primary_tax_id ON gp_practice_info.primary_tax_id = cl_primary_tax_id.lookup_code ~r~n" + &
"LEFT OUTER JOIN code_lookup cl_after_hours_type ON gp_practice_info.after_hours_type = cl_after_hours_type.lookup_code ~r~n" + &
"ORDER BY gp_practice_info.rec_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_gp_questions') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     gp_questions.rec_id, gp_questions.gp_id, gp_questions.question_id, cl_question_type.description AS quest_type, ~r~n" + &
"                      question_lookup.short_quest, question_lookup.full_quest, cl_answer.description AS answer, gp_questions.follow_up, ~r~n" + &
"                      gp_questions.followup_2~r~n" + &
"FROM         gp_questions INNER JOIN~r~n" + &
"                      question_lookup ON gp_questions.question_id = question_lookup.quest_id LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_question_type ON question_lookup.quest_type = cl_question_type.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_answer ON gp_questions.answer_code = cl_answer.lookup_code~r~n" + &
"ORDER BY gp_questions.rec_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

of_execute_sql()

return 0

end function

public function integer of_update_view_v6_2 ();//////////////////////////////////////////////////////////////////////
// $<function>		n_cst_contract_sql.of_update_view_v6_2()
// $<arguments> 	None
// $<returns> 		integer
// $<description>	Update the view's sql
// $<add> 			07.23.2007 by Scofield
//////////////////////////////////////////////////////////////////////

String	ls_sql,ls_tag,ls_Title

IF gs_dbtype = "ASA" THEN 
	ls_tag = "; "
	ls_Title = "TOP 50000000"
ELSE
	ls_Title = "top 100 percent"
END IF

ls_sql = of_get_view_action('v_group_covering') + "~r~n" + &
"AS~r~n" + &
"SELECT DISTINCT " + ls_Title + " ~r~n" + &
"                      pd_group_providers.facility_id, pd_group_providers.provider_name, code_lookup_b.description AS specialty, ~r~n" + &
"                      code_lookup_b.description AS specialty_code, code_lookup_a.code AS covering, pd_group_providers.covering_days, ~r~n" + &
"                      pd_group_providers.custom_1, pd_group_providers.custom_2, pd_group_providers.custom_3, pd_group_providers.custom_4, ~r~n" + &
"                      pd_group_providers.custom_5, facility.facility_name, pd_group_providers.prac_id, pd_group_providers.rec_id, ~r~n" + &
"                      pd_group_providers.custom_6, pd_group_providers.custom_7, pd_group_providers.custom_8, pd_group_providers.custom_9, ~r~n" + &
"                      pd_group_providers.custom_10, pd_group_providers.custom_d1, pd_group_providers.custom_d2~r~n" + &
"FROM         pd_group_providers INNER JOIN~r~n" + &
"                      facility ON pd_group_providers.facility_id = facility.facility_id LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_a ON pd_group_providers.covering = code_lookup_a.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_b ON pd_group_providers.specialty = code_lookup_b.lookup_code~r~n" + &
"ORDER BY pd_group_providers.facility_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_group_practice') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     gp.rec_id AS gp_id, cl_address_type.code AS address_type_code, cl_address_type.description AS address_type_description, gp.street, gp.street_2, ~r~n" + &
"                      gp.city, cl_state.code AS state, gp.zip, cl_county.description AS county, cl_country.description AS country, gp.phone, gp.ext, gp.fax, gp.pager_number, ~r~n" + &
"                      gp.web_address, gp.e_mail_address, gp.contact_person, gp.business_mgr, gp.office_mgr, gp.tax_id, gp.tax_id_other_1, gp.tax_id_other_2, ~r~n" + &
"                      cl_accepting_new_patients.description AS accepting_new_patients, gp.cust_1, gp.cust_2, gp.cust_3, gp.cust_4, gp.cust_5, gp.cust_6, gp.active_status, ~r~n" + &
"                      cl_practice_type.description AS practice_type, gp.routine_visit_appt, gp.urgent_visit_appt, gp.emergency_visit_appt, gp.non_emergency_appt, ~r~n" + &
"                      cl_young_child.description AS young_child, cl_child.description AS child, cl_adolescent.description AS adolescent, cl_adult.description AS adult, ~r~n" + &
"                      cl_senior_adult.description AS senior_adult, cl_handicapped_access.description AS handicapped_access, ~r~n" + &
"                      cl_public_transportation.description AS public_transportation, cl_office_in_home.description AS office_in_home, gp.mon_from, gp.mon_to, ~r~n" + &
"                      gp.mon_from2, gp.mon_to2, gp.tue_from, gp.tue_to, gp.tue_from2, gp.tue_to2, gp.wed_from, gp.wed_to2, gp.wed_from2, gp.wed_to, gp.thu_from, ~r~n" + &
"                      gp.thu_to, gp.thu_from2, gp.thu_to2, gp.fri_from, gp.fri_to, gp.fri_from2, gp.fri_to2, gp.sat_from, gp.sat_to, gp.sat_from2, gp.sat_to2, gp.sun_from, ~r~n" + &
"                      gp.sun_from2, gp.sun_to, gp.sun_to2, gp.prac_id, gp.suite_apart, gp.billing_address_id~r~n" + &
"FROM         group_practice gp LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_address_type ON gp.mailing_address = cl_address_type.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_accepting_new_patients ON gp.accepting_new_patients = cl_accepting_new_patients.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_adult ON gp.adult = cl_adult.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_adolescent ON gp.adolescent = cl_adolescent.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_child ON gp.child = cl_child.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_country ON gp.country = cl_country.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_county ON gp.county = cl_county.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_handicapped_access ON gp.handicapped_access = cl_handicapped_access.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_office_in_home ON gp.office_in_home = cl_office_in_home.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_practice_type ON gp.practice_type = cl_practice_type.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_public_transportation ON gp.public_transportation = cl_public_transportation.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_senior_adult ON gp.senior_adult = cl_senior_adult.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_state ON gp.state = cl_state.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_young_child ON gp.young_child = cl_young_child.lookup_code~r~n" + &
"ORDER BY gp.rec_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_group_practice_parent_org_link') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     group_loc_link.rec_id, group_loc_link.group_id AS parent_org_id, group_multi_loc.gp_name AS parent_org_name, ~r~n" + &
"                      group_loc_link.loc_id AS gp_id, group_practice.street AS gp_loc_name~r~n" + &
"FROM         group_loc_link INNER JOIN~r~n" + &
"                      group_multi_loc ON group_loc_link.group_id = group_multi_loc.rec_id INNER JOIN~r~n" + &
"                      group_practice ON group_loc_link.loc_id = group_practice.rec_id~r~n" + &
"ORDER BY group_loc_link.rec_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_hosp_affil') + "~r~n" + &
"as select " + ls_Title + " pd_hosp_affil.rec_id,pd_hosp_affil.prac_id,hospital_code=address_lookup.code,hospital_name=address_lookup.entity_name,pd_hosp_affil.month_from,pd_hosp_affil.year_from,pd_hosp_affil.month_thru,pd_hosp_affil.year_thru,pd_hosp_affil.primary_hosp,primary_hospital=code_lookup_g.code,staff_cat_code=code_lookup_h.code,staff_cat_description=code_lookup_h.description,admitting_priviliges=code_lookup_i.code,pd_hosp_affil.cust_1,pd_hosp_affil.cust_2,pd_hosp_affil.cust_3,pd_hosp_affil.cust_4,pd_hosp_affil.cust_5 from((((pd_hosp_affil left outer join address_lookup on pd_hosp_affil.hospital_code = address_lookup.lookup_code) left outer join code_lookup as code_lookup_g on pd_hosp_affil.primary_hosp = code_lookup_g.lookup_code) left outer join code_lookup as code_lookup_h on pd_hosp_affil.staff_category = code_lookup_h.lookup_code) left outer join code_lookup as code_lookup_i on pd_hosp_affil.admitting_priv = code_lookup_i.lookup_code) order by pd_hosp_affil.rec_id,pd_hosp_affil.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_hospital_facility_link') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     pd_hosp_facility_link.hosp_affil_id AS rec_id, pd_hosp_facility_link.prac_id, pd_hosp_facility_link.facility_id, ~r~n" + &
"                      pd_hosp_facility_link.primary_hosp, code_lookup.code AS primary_hosp_code, ~r~n" + &
"                      code_lookup.description AS primary_hosp_description~r~n" + &
"FROM         pd_hosp_facility_link INNER JOIN~r~n" + &
"                      code_lookup ON pd_hosp_facility_link.primary_hosp = code_lookup.lookup_code~r~n" + &
"ORDER BY pd_hosp_facility_link.hosp_affil_id,pd_hosp_facility_link.prac_id,pd_hosp_facility_link.facility_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_image_list') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     rec_id, prac_id, screen_id, date_scanned, user_name, date_recieved, active_status, doc_id, notes, num_pages, reference_name, tif_start_page, ~r~n" + &
"                      image_type_id, file_name, modify_date~r~n" + &
"FROM         pd_images~r~n" + &
"ORDER BY rec_id, prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_Insurance') + "~r~n" + &
"  as select " + ls_Title + " pd_insurance.rec_id,~r~n" + &
"    pd_insurance.prac_id,~r~n" + &
"    address_lookup.code as carrier_code,~r~n" + &
"    address_lookup.entity_name as carrier_name,~r~n" + &
"    pd_insurance.policy_number,~r~n" + &
"    pd_insurance.coverage_from,~r~n" + &
"    pd_insurance.coverage_to,~r~n" + &
"    pd_insurance.previous_expiration_date,~r~n" + &
"    code_lookup_b.code as tail_coverage_code,~r~n" + &
"    pd_insurance.coverage_limit_from,~r~n" + &
"    pd_insurance.coverage_limit_to,~r~n" + &
"    code_lookup_d.code as state_funded_code,~r~n" + &
"    code_lookup_c.code as state_coverage,~r~n" + &
"    pd_insurance.exclusions,~r~n" + &
"    pd_insurance.cust_1,~r~n" + &
"    pd_insurance.cust_2,~r~n" + &
"    pd_insurance.cust_3,~r~n" + &
"    pd_insurance.cust_4,~r~n" + &
"    pd_insurance.cust_5,~r~n" + &
"    code_lookup_a.code as claims_made_code,~r~n" + &
"    code_lookup_a.description as claims_made_description,~r~n" + &
"    pd_insurance.denied_explain,~r~n" + &
"    pd_insurance.active_status~r~n" + &
"from~r~n" + &
"    pd_insurance LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_a ON pd_insurance.claims_made_occurrence = code_lookup_a.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_b ON pd_insurance.tail_coverage = code_lookup_b.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_c ON pd_insurance.state_coverage = code_lookup_c.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_d ON pd_insurance.state_funded_pool = code_lookup_d.lookup_code LEFT OUTER JOIN~r~n" + &
"    address_lookup ON pd_insurance.carrier_code = address_lookup.lookup_code~r~n" + &
"order by pd_insurance.rec_id,pd_insurance.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_invoice') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     pd_invoice.rec_id AS invoice_id, pd_invoice.prac_id, LTRIM(RTRIM(ISNULL(pd_basic.last_name, ''))) ~r~n" + &
"                      + ', ' + ISNULL(pd_basic.first_name, '') + ' ' + SUBSTRING(ISNULL(pd_basic.middle_name, ''), 1, 1) ~r~n" + &
"                      + CASE WHEN isnull(pd_basic.middle_name, '') = '' THEN '' ELSE '.,' END + LTRIM(RTRIM(ISNULL~r~n" + &
"                          ((SELECT     code~r~n" + &
"                              FROM         code_lookup~r~n" + &
"                              WHERE     pd_basic.name_suffix = code_lookup.lookup_code), ''))) + CASE WHEN isnull~r~n" + &
"                          ((SELECT     code~r~n" + &
"                              FROM         code_lookup~r~n" + &
"                              WHERE     pd_basic.name_suffix = code_lookup.lookup_code), '') = '' THEN '' ELSE ', ' END + LTRIM(RTRIM(ISNULL~r~n" + &
"                          ((SELECT     code~r~n" + &
"                              FROM         code_lookup~r~n" + &
"                              WHERE     pd_basic.prof_suffix = code_lookup.lookup_code), ''))) AS prac_name, pd_invoice.facility_id, facility.facility_name, ~r~n" + &
"                      pd_invoice.inv_date AS invoice_date, pd_invoice.due_date, pd_invoice.tax_a, pd_invoice.amt_billed, pd_invoice.invc_amt, ~r~n" + &
"                      pd_invoice.amt_paid, CASE pd_invoice.paid WHEN 0 THEN 'Open' ELSE 'Paid' END AS paid, pd_invoice.note, pd_inv_rows.item_id, ~r~n" + &
"                      pd_inv_rows.invt_id AS item_inventory_id, pd_inv_rows.billing_item AS item_billing_item, pd_inv_rows.quantity AS item_quantity, ~r~n" + &
"                      pd_inv_rows.cost AS item_cost, pd_inv_rows.price AS item_price, pd_inv_rows.extended AS item_extended~r~n" + &
"FROM         pd_invoice INNER JOIN~r~n" + &
"                      pd_inv_rows ON pd_invoice.rec_id = pd_inv_rows.rec_id INNER JOIN~r~n" + &
"                      pd_basic ON pd_invoice.prac_id = pd_basic.prac_id INNER JOIN~r~n" + &
"                      facility ON pd_invoice.facility_id = facility.facility_id~r~n" + &
"ORDER BY pd_invoice.rec_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_languages') + "~r~n" + &
"as~r~n" + &
"select " + ls_Title + "~r~n" + &
"	pd_languages.rec_id,~r~n" + &
"	pd_languages.prac_id,~r~n" + &
"	lang_code=code_lookup_a.code,~r~n" + &
"	lang_description=code_lookup_a.description,~r~n" + &
"	speak=code_lookup_b.code,~r~n" + &
"	[read]=code_lookup_c.code,~r~n" + &
"	write=code_lookup_d.code,~r~n" + &
"	[sign]=code_lookup_e.code,~r~n" + &
"	pd_languages.cust_1,~r~n" + &
"	pd_languages.cust_2,~r~n" + &
"	pd_languages.cust_3,~r~n" + &
"	pd_languages.cust_4,~r~n" + &
"	pd_languages.cust_5~r~n" + &
"from~r~n" + &
"	(((((pd_languages left outer join~r~n" + &
"	code_lookup as code_lookup_a on pd_languages.foreign_language = code_lookup_a.lookup_code) left outer join~r~n" + &
"	code_lookup as code_lookup_b on pd_languages.speak = code_lookup_b.lookup_code) left outer join~r~n" + &
"	code_lookup as code_lookup_c on pd_languages.reads = code_lookup_c.lookup_code) left outer join~r~n" + &
"	code_lookup as code_lookup_d on pd_languages.writes = code_lookup_d.lookup_code) left outer join~r~n" + &
"	code_lookup as code_lookup_e on pd_languages.sign = code_lookup_e.lookup_code)~r~n" + &
"order by pd_languages.rec_id,pd_languages.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_license') + "~r~n" + &
"as SELECT " + ls_Title + " pd_license.rec_id,pd_license.prac_id,state_code=code_lookup_a.code,state_description=code_lookup_a.description,lic_type_code=code_lookup_b.code,lic_type_description=code_lookup_b.description,pd_license.license_number,pd_license.expiration_date,pd_license.year_issued,pd_license.previous_expiration_date,verif_agcy_code=address_lookup.code,verif_agcy_name=address_lookup.entity_name,pd_license.restrictions,pd_license.cust_1,pd_license.cust_2,pd_license.cust_3,pd_license.cust_4,pd_license.cust_5,pd_license.active_status from address_lookup,code_lookup as code_lookup_a,code_lookup as code_lookup_b,pd_license where(pd_license.state = code_lookup_a.lookup_code) and(pd_license.license_type_code = code_lookup_b.lookup_code) and(pd_license.verifying_agency = address_lookup.lookup_code) ORDER BY pd_license.rec_id,pd_license.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_mailing_address') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     code_lookup_c.code AS state, pd_address.rec_id, pd_address.prac_id, pd_address.street, pd_address.street_2, pd_address.city, ~r~n" + &
"                      code_lookup_b.code AS practice_type, pd_address.zip, code_lookup_d.code AS country, pd_address.phone, pd_address.fax, ~r~n" + &
"                      pd_address.contact_person, pd_address.e_mail_address, pd_address.web_address, pd_address_link.facility_id, ~r~n" + &
"                      pd_address_link.mailing, pd_address.ext, code_lookup_a.description AS county, code_lookup_d.description AS country_description, ~r~n" + &
"                      code_lookup_c.description AS state_description, code_lookup_b.description AS practice_type_description, pd_address.tax_id, ~r~n" + &
"                      pd_address.tax_id_other_1, pd_address.tax_id_other_2, pd_address.business_mgr, pd_address.office_mgr, pd_address.cust_1, ~r~n" + &
"                      pd_address.cust_2, pd_address.cust_3, pd_address.cust_4, pd_address.cust_5, pd_address.cust_6, pd_address.cust_7, ~r~n" + &
"                      pd_address.cust_8, pd_address.cust_9, pd_address.cust_10, pd_address.cust_d1, pd_address.cust_d2, pd_address.gp_id, ~r~n" + &
"                      pd_address.suite_apart, code_lookup_e.description AS send_corresp_here~r~n" + &
"FROM         pd_address INNER JOIN~r~n" + &
"                      pd_address_link ON pd_address.rec_id = pd_address_link.address_id LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_b ON pd_address.practice_type = code_lookup_b.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_c ON pd_address.state = code_lookup_c.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_d ON pd_address.country = code_lookup_d.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_a ON pd_address.county = code_lookup_a.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_e ON pd_address.send_corresp_here = code_lookup_e.lookup_code~r~n" + &
"WHERE     (pd_address_link.mailing = 1)~r~n" + &
"ORDER BY pd_address.rec_id,pd_address.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_meeting_list') + "~r~n" + &
"  as select " + ls_Title + " meetings.meeting_id,~r~n" + &
"    facility_name,~r~n" + &
"    meeting_type_code=code_lookup_a.code,~r~n" + &
"    meetings.start_date,~r~n" + &
"    start_time=code_lookup_c.code,~r~n" + &
"    meetings.end_date,~r~n" + &
"    end_time=code_lookup_d.code,~r~n" + &
"    meetings.subject,~r~n" + &
"    location=code_lookup_b.code,~r~n" + &
"    department=code_lookup_e.description,~r~n" + &
"    section=code_lookup_g.description,~r~n" + &
"    committee_lookup.committee_name,~r~n" + &
"    meetings.comments,~r~n" + &
"    meetings.cme_credits,~r~n" + &
"    cme_category=code_lookup_h.code,~r~n" + &
"    meetings.cme_presenter,~r~n" + &
"    meetings.cme_affiliation~r~n" + &
"from~r~n" + &
"    meetings INNER JOIN~r~n" + &
"    code_lookup as code_lookup_a ON meetings.meeting_type = code_lookup_a.lookup_code INNER JOIN~r~n" + &
"    code_lookup as code_lookup_b ON meetings.location = code_lookup_b.lookup_code INNER JOIN~r~n" + &
"    code_lookup as code_lookup_c ON meetings.start_time = code_lookup_c.lookup_code INNER JOIN~r~n" + &
"    code_lookup as code_lookup_d ON meetings.end_time = code_lookup_d.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_e ON meetings.department = code_lookup_e.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_g ON meetings.section = code_lookup_g.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_h ON meetings.cme_category = code_lookup_h.lookup_code LEFT OUTER JOIN~r~n" + &
"    committee_lookup ON meetings.committee = committee_lookup.committee_id LEFT OUTER JOIN~r~n" + &
"    facility ON meetings.facility = facility.facility_id~r~n" + &
"order by meetings.meeting_id    ~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_meetings') + "~r~n" + &
"  as select " + ls_Title + " meeting_type=code_lookup_a.code,~r~n" + &
"    meetings.start_date,~r~n" + &
"    meetings.start_time,~r~n" + &
"    meetings.end_date,~r~n" + &
"    meetings.end_time,~r~n" + &
"    meetings.subject,~r~n" + &
"    location=code_lookup_b.code,~r~n" + &
"    meetings.committee,~r~n" + &
"    meetings.comments,~r~n" + &
"    meetings.cme_credits,~r~n" + &
"    meetings.cme_category,~r~n" + &
"    meetings.cme_presenter,~r~n" + &
"    meetings.cme_affiliation,~r~n" + &
"    meetings.facility,~r~n" + &
"    attendence.attendence_status,~r~n" + &
"    meetings.meeting_id,~r~n" + &
"    attendence.prac_id,~r~n" + &
"    meetings.department,~r~n" + &
"    meetings.section,~r~n" + &
"    attendence.active_status from(~r~n" + &
"    meetings left outer join attendence on meetings.meeting_id = attendence.meeting_id),~r~n" + &
"    code_lookup as code_lookup_a,~r~n" + &
"    code_lookup as code_lookup_b where~r~n" + &
"    (meetings.meeting_type = code_lookup_a.lookup_code) and~r~n" + &
"    (meetings.location = code_lookup_b.lookup_code)~r~n" + &
"order by meetings.meeting_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_net_dev_actions') + "~r~n" + &
"as select " + ls_Title + " prac_id,net_dev_action_items.facility_id,facility.facility_name,action_type_code=code_lookup_a.code,action_type_description=code_lookup_a.description,department_code=code_lookup_b.code,department_description=code_lookup_b.description,action_status_code=code_lookup_c.code,action_status_description=code_lookup_c.description,net_dev_action_items.action_date,net_dev_action_items.action_user,net_dev_action_items.next_action_date,net_dev_action_items.notes,net_dev_action_items.action_contact,app_hdr.application_type,app_hdr.application_name from((((net_dev_action_items left outer join code_lookup as code_lookup_a on net_dev_action_items.action_type = code_lookup_a.lookup_code) left outer join code_lookup as code_lookup_b on net_dev_action_items.action_dept = code_lookup_b.lookup_code) left outer join code_lookup as code_lookup_c on net_dev_action_items.action_status = code_lookup_c.lookup_code) left outer join app_hdr on net_dev_action_items.app_id = app_hdr.app_id),facility where(net_dev_action_items.facility_id = facility.facility_id) order by prac_id,net_dev_action_items.facility_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_net_dev_ids') + "~r~n" + &
"as select " + ls_Title + " net_dev_ids.prac_id,net_dev_ids.facility_id,facility.facility_name,plan_type_code=code_lookup.code,plan_type_description=code_lookup.description,net_dev_ids.plan_assigned_id,net_dev_ids.start_date,net_dev_ids.end_date from code_lookup,net_dev_ids,facility where(net_dev_ids.plan_type = code_lookup.lookup_code) and(net_dev_ids.facility_id = facility.facility_id) order by net_dev_ids.prac_id,net_dev_ids.facility_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_net_dev_notes') + "~r~n" + &
"as select " + ls_Title + " net_dev_notes.prac_id,net_dev_notes.notes from net_dev_notes order by net_dev_notes.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_other_affil') + "~r~n" + &
"as select " + ls_Title + " pd_other_affill.rec_id,pd_other_affill.prac_id,institution_code=address_lookup.code,institution_name=address_lookup.entity_name,function_code=code_lookup.code,function_description=code_lookup.description,pd_other_affill.month_from,pd_other_affill.year_from,pd_other_affill.month_thru,pd_other_affill.year_thru,pd_other_affill.cust_1,pd_other_affill.cust_2,pd_other_affill.cust_3,pd_other_affill.cust_4,pd_other_affill.cust_5 from(pd_other_affill left outer join code_lookup on pd_other_affill.function_code = code_lookup.lookup_code),address_lookup where(pd_other_affill.institution_code = address_lookup.lookup_code) order by pd_other_affill.rec_id,pd_other_affill.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_other_data_fs') + "~r~n" + &
"AS~r~n" + &
"SELECT DISTINCT " + ls_Title + " ~r~n" + &
"                      pd_other_data.facility_id, facility.facility_name, pd_other_data.prac_id, pd_other_data.corp_comply, pd_other_data.bylaws_read, ~r~n" + &
"                      pd_other_data.orientation, pd_other_data.conscience_sedation, pd_other_data.ppd_date, pd_other_data.npdb, ~r~n" + &
"                      pd_other_data.physical, pd_other_data.lij_beeper, pd_other_data.active_status, code_lookup.description AS positive_ppd, ~r~n" + &
"                      pd_other_data.custom_1, pd_other_data.custom_2, pd_other_data.custom_3, pd_other_data.custom_4, ~r~n" + &
"                      pd_other_data.custom_5~r~n" + &
"FROM         pd_other_data INNER JOIN~r~n" + &
"                      facility ON pd_other_data.facility_id = facility.facility_id LEFT OUTER JOIN~r~n" + &
"                      code_lookup ON pd_other_data.positive_ppd = code_lookup.lookup_code~r~n" + &
"ORDER BY pd_other_data.facility_id,pd_other_data.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_other_ids') + "~r~n" + &
"as select " + ls_Title + " pd_other_ids.rec_id,pd_other_ids.prac_id,id_type_code=code_lookup.code,id_type_description=code_lookup.description,pd_other_ids.id_number,pd_other_ids.exp_date,pd_other_ids.cust_1,pd_other_ids.cust_2,pd_other_ids.cust_3,pd_other_ids.cust_4,pd_other_ids.cust_5 from(pd_other_ids left outer join code_lookup on pd_other_ids.id_type = code_lookup.lookup_code) order by pd_other_ids.rec_id,pd_other_ids.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

//ls_sql = of_get_view_action('v_pdc_dues') + "~r~n" + &
//"  as select " + ls_Title + " pdc_dues.rec_id,~r~n" + &
//"    pdc_dues.prac_id,~r~n" + &
//"    pdc_dues.facility_id,~r~n" + &
//"    code_lookup.description as dues_paid,~r~n" + &
//"    pdc_dues.reason_not_paid,~r~n" + &
//"    pdc_dues.dues_amount,~r~n" + &
//"    pdc_dues.date_dues_paid,~r~n" + &
//"    pdc_dues.medicare_group_code,~r~n" + &
//"    pdc_dues.medical_record_suspension,~r~n" + &
//"    pdc_dues.med_rec_suspend_data,~r~n" + &
//"    pdc_dues.misc,~r~n" + &
//"    pdc_dues.cust_1,~r~n" + &
//"    pdc_dues.cust_2,~r~n" + &
//"    pdc_dues.cust_date_1,~r~n" + &
//"    pdc_dues.cust_date_2 from~r~n" + &
//"    pdc_dues,code_lookup where~r~n" + &
//"    pdc_dues.dues_paid = code_lookup.lookup_code~r~n" + &
//"order by pdc_dues.rec_id~r~n" + ls_tag
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

//ls_sql = of_get_view_action('v_pdc_supervisor') + "~r~n" + &
//"  as SELECT " + ls_Title + " pdc_supervisor.prac_id,~r~n" + &
//"    pdc_supervisor.rec_id,~r~n" + &
//"    pdc_supervisor.facility_id,~r~n" + &
//"    primary_super_code=code_lookup_A.code,~r~n" + &
//"    primary_super_descr=code_lookup_A.description,~r~n" + &
//"    super_section_code=code_lookup_B.code,~r~n" + &
//"    super_section_descr=code_lookup_B.description,~r~n" + &
//"    super_dept_code=code_lookup_C.code,~r~n" + &
//"    super_dept_descr=code_lookup_C.description,~r~n" + &
//"    pdc_supervisor.last_name,~r~n" + &
//"    pdc_supervisor.first_name,~r~n" + &
//"    pdc_supervisor.mid_initial,~r~n" + &
//"    prof_suffix_code=code_lookup_D.code,~r~n" + &
//"    prof_suffix_descr=code_lookup_D.description,~r~n" + &
//"    pdc_supervisor.begin_date,~r~n" + &
//"    pdc_supervisor.end_date,~r~n" + &
//"    pdc_supervisor.cust_1,~r~n" + &
//"    pdc_supervisor.cust_2,~r~n" + &
//"    pdc_supervisor.cust_date1~r~n" + &
//"from~r~n" + &
//"    pdc_supervisor LEFT OUTER JOIN~r~n" + &
//"    code_lookup code_lookup_A ON pdc_supervisor.primary_super = code_lookup_A.lookup_code LEFT OUTER JOIN~r~n" + &
//"    code_lookup code_lookup_B ON pdc_supervisor.super_section = code_lookup_B.lookup_code LEFT OUTER JOIN~r~n" + &
//"    code_lookup code_lookup_C ON pdc_supervisor.super_dept = code_lookup_C.lookup_code LEFT OUTER JOIN~r~n" + &
//"    code_lookup code_lookup_D ON pdc_supervisor.prof_suffix = code_lookup_D.lookup_code~r~n" + &
//"ORDER BY pdc_supervisor.prac_id~r~n" + ls_tag
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql


ls_sql = of_get_view_action('v_peer_review') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     pd_peer_review.case_number, pd_peer_review.facility_id, facility.facility_name, pd_peer_review.date_of_review, ~r~n" + &
"                      cl_review_status.code AS review_status_code, cl_review_status.description AS review_status_description, pd_peer_review.reviewer, ~r~n" + &
"                      cl_review_reason.code AS review_reason_code, cl_review_reason.description AS review_reason_description, ~r~n" + &
"                      pd_peer_review.date_of_occurrence, pd_peer_review.medical_record_number, pd_peer_review.patient_name, ~r~n" + &
"                      pd_peer_review.admission_date, pd_peer_review.admitting_diagnoses, cl_sex.code AS gender_code, ~r~n" + &
"                      cl_sex.description AS gender_description, pd_peer_review.age, pd_peer_review.notes, pd_peer_review.finding, ~r~n" + &
"                      pd_peer_review.conclusion, pd_peer_review.date_completed, pd_peer_review.time_of_occurrence, pd_peer_review.cust_1, ~r~n" + &
"                      pd_peer_review.cust_2, pd_peer_review.cust_3, pd_peer_review.cust_4, pd_peer_review.cust_5, pd_peer_review.cust_6, ~r~n" + &
"                      pd_peer_review.cust_7, pd_peer_review.cust_8, pd_peer_review.cust_9, pd_peer_review.cust_10~r~n" + &
"FROM         pd_peer_review LEFT OUTER JOIN~r~n" + &
"                      facility ON pd_peer_review.facility_id = facility.facility_id LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_review_reason ON pd_peer_review.review_reason = cl_review_reason.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_sex ON pd_peer_review.sex = cl_sex.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_review_status ON pd_peer_review.review_status = cl_review_status.lookup_code~r~n" + &
"ORDER BY pd_peer_review.case_number~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_peer_review_action_items') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     pd_peer_review_action_items.rec_id, pd_peer_review_action_items.case_number, cl_action_type.code AS action_type_code, ~r~n" + &
"                      cl_action_type.description AS action_type_description, pd_peer_review_action_items.action_date, cl_action_to.code AS action_to_code, ~r~n" + &
"                      cl_action_to.description AS action_to_description, pd_peer_review_action_items.action_user, pd_peer_review_action_items.notes, ~r~n" + &
"                      pd_peer_review_action_items.action_to_name, cl_action_status.code AS action_status_code, ~r~n" + &
"                      cl_action_status.description AS action_status_description, pd_peer_review_action_items.date_completed~r~n" + &
"FROM         pd_peer_review_action_items LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_action_status ON pd_peer_review_action_items.action_status = cl_action_status.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_action_type ON pd_peer_review_action_items.action_type = cl_action_type.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_action_to ON pd_peer_review_action_items.action_to = cl_action_to.lookup_code~r~n" + &
"ORDER BY pd_peer_review_action_items.rec_id, pd_peer_review_action_items.case_number~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_peer_review_pracs') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     pd_peer_review_pracs.case_number, pd_peer_review_pracs.prac_id, LTRIM(RTRIM(ISNULL(pd_basic.last_name, ''))) ~r~n" + &
"                      + ', ' + ISNULL(pd_basic.first_name, '') + ' ' + SUBSTRING(ISNULL(pd_basic.middle_name, ''), 1, 1) ~r~n" + &
"                      + CASE WHEN isnull(pd_basic.middle_name, '') = '' THEN '' ELSE '.,' END + LTRIM(RTRIM(ISNULL~r~n" + &
"                          ((SELECT     code~r~n" + &
"                              FROM         code_lookup~r~n" + &
"                              WHERE     pd_basic.name_suffix = code_lookup.lookup_code), ''))) + CASE WHEN isnull~r~n" + &
"                          ((SELECT     code~r~n" + &
"                              FROM         code_lookup~r~n" + &
"                              WHERE     pd_basic.name_suffix = code_lookup.lookup_code), '') = '' THEN '' ELSE ', ' END + LTRIM(RTRIM(ISNULL~r~n" + &
"                          ((SELECT     code~r~n" + &
"                              FROM         code_lookup~r~n" + &
"                              WHERE     pd_basic.prof_suffix = code_lookup.lookup_code), ''))) AS full_name, code_lookup.code AS severity_code, ~r~n" + &
"                      code_lookup.description AS severity_code_description, pd_peer_review_pracs.notes, pd_peer_review_pracs.active_status~r~n" + &
"FROM         pd_peer_review_pracs INNER JOIN~r~n" + &
"                      pd_basic ON pd_peer_review_pracs.prac_id = pd_basic.prac_id LEFT OUTER JOIN~r~n" + &
"                      code_lookup ON pd_peer_review_pracs.severity_grade = code_lookup.lookup_code~r~n" + &
"ORDER BY pd_peer_review_pracs.case_number, pd_peer_review_pracs.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_postgrad_train') + "~r~n" + &
"as select " + ls_Title + " pd_postgrad_train.rec_id,pd_postgrad_train.prac_id,pd_postgrad_train.subject,pd_postgrad_train.date_from,pd_postgrad_train.date_thru,pd_postgrad_train.loc_city,loc_state_code=code_lookup_a.code,loc_state_description=code_lookup_a.description,pd_postgrad_train.loc_zip,loc_country_code=code_lookup_b.code,loc_country_description=code_lookup_b.description,pd_postgrad_train.hours,hours_code=code_lookup_f.code,hours_name=code_lookup_f.description,category_code=code_lookup_c.code,categ_description=code_lookup_c.description,pd_postgrad_train.sponsor,pd_postgrad_train.street,pd_postgrad_train.city,state_code=code_lookup_d.code,state_description=code_lookup_d.description,pd_postgrad_train.zip,country_code=code_lookup_e.code,country_description=code_lookup_e.description,pd_postgrad_train.program_director,pd_postgrad_train.cust_1,pd_postgrad_train.cust_2,pd_postgrad_train.cust_3,pd_postgrad_train.cust_4,pd_postgrad_train.cust_5 from((((((pd_postgrad_train left outer join code_lookup as code_lookup_a on pd_postgrad_train.loc_state = code_lookup_a.lookup_code) left outer join code_lookup as code_lookup_b on pd_postgrad_train.loc_country = code_lookup_b.lookup_code) left outer join code_lookup as code_lookup_c on pd_postgrad_train.category = code_lookup_c.lookup_code) left outer join code_lookup as code_lookup_d on pd_postgrad_train.state = code_lookup_d.lookup_code) left outer join code_lookup as code_lookup_e on pd_postgrad_train.country = code_lookup_e.lookup_code) left outer join code_lookup as code_lookup_f on pd_postgrad_train.hours = code_lookup_f.lookup_code) order by pd_postgrad_train.rec_id,pd_postgrad_train.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_prac_privs') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     facility.facility_name, pd_priv_list.rec_id, pd_priv_list.facility_id, pd_priv_list.prac_id, pd_priv_list.start_date, ~r~n" + &
"                      pd_priv_list.end_date, pd_priv_list.notes, pd_priv_list.active_status, pd_priv_list.ir_code, ~r~n" + &
"                      priv_clinical_area.clinical_area_description, priv_core_procd.core_procd_description, priv_core.priv_core_description, ~r~n" + &
"                      code_lookup.code, priv_core_procd.sort_order, priv_core_procd.procd_name, priv_clinical_area.clinical_area_code, ~r~n" + &
"                      code_lookup.description AS priv_status_description, code_lookup.code AS priv_status_code~r~n" + &
"FROM         facility INNER JOIN~r~n" + &
"                      pd_priv_list ON facility.facility_id = pd_priv_list.facility_id INNER JOIN~r~n" + &
"                      priv_clinical_area ON pd_priv_list.clinical_area_id = priv_clinical_area.clinical_area_id INNER JOIN~r~n" + &
"                      priv_core ON pd_priv_list.priv_core_id = priv_core.priv_core_id INNER JOIN~r~n" + &
"                      priv_core_procd ON pd_priv_list.procd_id = priv_core_procd.procd_id INNER JOIN~r~n" + &
"                      code_lookup ON pd_priv_list.status_code = code_lookup.lookup_code~r~n" + &
"ORDER BY pd_priv_list.rec_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_pracitioner_notes') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     pd_notes.record_id, pd_notes.prac_id, LTRIM(RTRIM(ISNULL(pd_basic.last_name, ''))) + ', ' + ISNULL(pd_basic.first_name, '') ~r~n" + &
"                      + ' ' + SUBSTRING(ISNULL(pd_basic.middle_name, ''), 1, 1) + CASE WHEN isnull(pd_basic.middle_name, '') ~r~n" + &
"                      = '' THEN '' ELSE '.,' END + LTRIM(RTRIM(ISNULL~r~n" + &
"                          ((SELECT     code~r~n" + &
"                              FROM         code_lookup~r~n" + &
"                              WHERE     pd_basic.name_suffix = code_lookup.lookup_code), ''))) + CASE WHEN isnull~r~n" + &
"                          ((SELECT     code~r~n" + &
"                              FROM         code_lookup~r~n" + &
"                              WHERE     pd_basic.name_suffix = code_lookup.lookup_code), '') = '' THEN '' ELSE ', ' END + LTRIM(RTRIM(ISNULL~r~n" + &
"                          ((SELECT     code~r~n" + &
"                              FROM         code_lookup~r~n" + &
"                              WHERE     pd_basic.prof_suffix = code_lookup.lookup_code), ''))) AS full_name, pd_notes.facility_id, ~r~n" + &
"                      CASE pd_notes.facility_id WHEN 0 THEN 'Global' ELSE facility.facility_name END AS facility_name, pd_notes.ent_date, pd_notes.user_id, ~r~n" + &
"                      pd_notes.note~r~n" + &
"FROM         pd_notes INNER JOIN~r~n" + &
"                      pd_basic ON pd_notes.prac_id = pd_basic.prac_id LEFT OUTER JOIN~r~n" + &
"                      facility ON pd_notes.facility_id = facility.facility_id~r~n" + &
"ORDER BY pd_notes.record_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_primary_specialty') + "~r~n" + &
"as~r~n" + &
"select " + ls_Title + "~r~n" + &
"pd_board_specialty.rec_id,pd_board_specialty.prac_id,pd_board_specialty.specialty as specialty_id,code_lookup_a.code as specialty_code,~r~n" + &
"code_lookup_a.description as specialty_name,address_lookup.code as board_code,pd_board_specialty.board_code as board_code_id,~r~n" + &
"address_lookup.entity_name as board_name,pd_board_specialty.eligible_until,pd_board_specialty.initial_certification,~r~n" + &
"pd_board_specialty.last_recertification,pd_board_specialty.certification_expires,pd_board_specialty.certification_number,~r~n" + &
"pd_board_specialty.required_year_completion,pd_board_specialty.cust_1,pd_board_specialty.cust_2,pd_board_specialty.cust_3,~r~n" + &
"pd_board_specialty.cust_4,pd_board_specialty.cust_5,code_lookup_b.description as exam_taken,code_lookup_c.description as active_process,~r~n" + &
"code_lookup_d.description as ever_failed,code_lookup_e.description as specialty_order ~r~n" + &
"from ~r~n" + &
"pd_board_specialty LEFT OUTER JOIN~r~n" + &
"address_lookup ON pd_board_specialty.board_code = address_lookup.lookup_code INNER JOIN~r~n" + &
"code_lookup as code_lookup_a ON pd_board_specialty.specialty = code_lookup_a.lookup_code LEFT OUTER JOIN~r~n" + &
"code_lookup as code_lookup_b ON pd_board_specialty.exam_taken = code_lookup_b.lookup_code LEFT OUTER JOIN~r~n" + &
"code_lookup as code_lookup_c ON pd_board_specialty.active_cert_process = code_lookup_c.lookup_code LEFT OUTER JOIN~r~n" + &
"code_lookup as code_lookup_d ON pd_board_specialty.ever_failed_cert = code_lookup_d.lookup_code INNER JOIN~r~n" + &
"code_lookup as code_lookup_e ON pd_board_specialty.specialty_order = code_lookup_e.lookup_code~r~n" + &
"where~r~n" + &
"(code_lookup_e.code = 'Primary')~r~n" + &
"order by pd_board_specialty.rec_id,pd_board_specialty.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_priv_list') + "~r~n" + &
"  as select " + ls_Title + " priv_clinical_area.clinical_area_code,~r~n" + &
"    priv_clinical_area.clinical_area_id,~r~n" + &
"    priv_clinical_area.clinical_area_description,~r~n" + &
"    priv_core.priv_core_description,~r~n" + &
"    priv_core.priv_core_id,~r~n" + &
"    priv_core_procd.core_procd_description,~r~n" + &
"    priv_core_procd.procd_id,~r~n" + &
"    priv_core_procd.sort_order,~r~n" + &
"    priv_core_procd.procd_name from((~r~n" + &
"    priv_clinical_area left outer join priv_core on priv_clinical_area.clinical_area_id = priv_core.clinical_area_id) left outer join priv_core_procd on priv_core.priv_core_id = priv_core_procd.priv_core_id)~r~n" + &
"order by priv_clinical_area.clinical_area_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_prof_assoc') + "~r~n" + &
"as select " + ls_Title + " pd_prof_assoc.rec_id,pd_prof_assoc.prac_id,pd_prof_assoc.prof_assoc,prof_assoc_code=address_lookup.code,prof_assoc_name=address_lookup.entity_name,pd_prof_assoc.date_assoc,pd_prof_assoc.cust_1,pd_prof_assoc.cust_2,pd_prof_assoc.cust_3,pd_prof_assoc.cust_4,pd_prof_assoc.cust_5 from pd_prof_assoc,address_lookup where(pd_prof_assoc.prof_assoc = address_lookup.lookup_code) order by pd_prof_assoc.rec_id,pd_prof_assoc.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_prof_experience') + "~r~n" + &
"as select " + ls_Title + " pd_prof_experience.rec_id,pd_prof_experience.prac_id,pd_prof_experience.date_from_month,pd_prof_experience.date_to_month,pd_prof_experience.organization,pd_prof_experience.city,state_code=code_lookup_a.code,state_description=code_lookup_a.description,pd_prof_experience.zip,country_code=code_lookup_b.code,country_description=code_lookup_b.description,pd_prof_experience.title_duties,pd_prof_experience.date_from_year,pd_prof_experience.date_to_year,pd_prof_experience.cust_1,pd_prof_experience.cust_2,pd_prof_experience.cust_3,pd_prof_experience.cust_4,pd_prof_experience.cust_5,pd_prof_experience.street_1,pd_prof_experience.street_2 from((pd_prof_experience left outer join code_lookup as code_lookup_a on pd_prof_experience.state = code_lookup_a.lookup_code) left outer join code_lookup as code_lookup_b on pd_prof_experience.country = code_lookup_b.lookup_code) order by pd_prof_experience.rec_id,pd_prof_experience.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_qa_hdr') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     PD_QA_HDR.PD_QA_HDR_ID AS pd_qa_hdr_id, PD_QA_HDR.PRAC_ID AS prac_id, LTRIM(RTRIM(ISNULL(pd_basic.last_name, ''))) ~r~n" + &
"                      + ', ' + ISNULL(pd_basic.first_name, '') + ' ' + SUBSTRING(ISNULL(pd_basic.middle_name, ''), 1, 1) ~r~n" + &
"                      + CASE WHEN isnull(pd_basic.middle_name, '') = '' THEN '' ELSE '.,' END + LTRIM(RTRIM(ISNULL~r~n" + &
"                          ((SELECT     code~r~n" + &
"                              FROM         code_lookup~r~n" + &
"                              WHERE     pd_basic.name_suffix = code_lookup.lookup_code), ''))) + CASE WHEN isnull~r~n" + &
"                          ((SELECT     code~r~n" + &
"                              FROM         code_lookup~r~n" + &
"                              WHERE     pd_basic.name_suffix = code_lookup.lookup_code), '') = '' THEN '' ELSE ', ' END + LTRIM(RTRIM(ISNULL~r~n" + &
"                          ((SELECT     code~r~n" + &
"                              FROM         code_lookup~r~n" + &
"                              WHERE     pd_basic.prof_suffix = code_lookup.lookup_code), ''))) AS practitioner_name, PD_QA_HDR.QA_PROFILE_ID AS qa_profile_id, ~r~n" + &
"                      QA_PROFILE.PROFILE_NAME AS profile_name, QA_PROFILE.SPECIALTY_ID AS profile_specialty_lookup_code, ~r~n" + &
"                      CASE QA_PROFILE.SPECIALTY_ID WHEN 999999 THEN '(All)' ELSE cl_specialty.code END AS profile_specialty_code, ~r~n" + &
"                      CASE QA_PROFILE.SPECIALTY_ID WHEN 999999 THEN '(All Specialties)' ELSE cl_specialty.description END AS profile_specialty_description, ~r~n" + &
"                      PD_QA_HDR.FROM_DATE AS from_date, PD_QA_HDR.TO_DATE AS to_date, PD_QA_HDR.ACTIVE_STATUS AS active_status, ~r~n" + &
"                      CASE PD_QA_HDR.ACTIVE_STATUS WHEN 0 THEN 'History' WHEN 1 THEN 'Active' WHEN 4 THEN 'Pending' ELSE 'Unknown' END AS active_status_description,~r~n" + &
"                       PD_QA_HDR.HDR_COMMENT AS hdr_comment, cl_reason.code AS reason_code, cl_reason.description AS reason_description, ~r~n" + &
"                      QA_PROFILE.FACILITY_ID AS facility_id, facility.facility_name~r~n" + &
"FROM         PD_QA_HDR INNER JOIN~r~n" + &
"                      pd_basic ON PD_QA_HDR.PRAC_ID = pd_basic.prac_id INNER JOIN~r~n" + &
"                      QA_PROFILE ON PD_QA_HDR.QA_PROFILE_ID = QA_PROFILE.QA_PROFILE_ID INNER JOIN~r~n" + &
"                      facility ON QA_PROFILE.FACILITY_ID = facility.facility_id LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_reason ON PD_QA_HDR.REASON = cl_reason.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_specialty ON QA_PROFILE.SPECIALTY_ID = cl_specialty.lookup_code~r~n" + &
"ORDER BY PD_QA_HDR.PD_QA_HDR_ID~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_qa_measurements') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     PD_QA_MEASUREMENTS.PD_QA_MEASUREMENTS_ID AS pd_qa_measurements_id, ~r~n" + &
"                      PD_QA_MEASUREMENTS.PD_QA_HDR_ID AS pd_qa_hdr_id, QA_MEASUREMENT.QA_PROFILE_GROUP_ID AS qa_profile_group_id, ~r~n" + &
"                      QA_PROFILE_GROUP.QA_PROFILE_GROUP_NAME AS qa_profile_group_name, QA_MEASUREMENT.THRESHOLD AS threshold, ~r~n" + &
"                      QA_MEASUREMENT.INCLUDE_IN_PROFILE AS include_in_profile, ~r~n" + &
"                      CASE QA_MEASUREMENT.INCLUDE_IN_PROFILE WHEN 1 THEN 'Yes' ELSE 'No' END AS include_in_profile_description, ~r~n" + &
"                      QA_MEASUREMENT.DATA_FORMAT AS data_format, QA_MEASUREMENT.QA_MEASUREMENT_NAME AS qa_measurement_name, ~r~n" + &
"                      PD_QA_MEASUREMENTS.MEASUREMENT_VALUE AS measurement_value~r~n" + &
"FROM         PD_QA_MEASUREMENTS INNER JOIN~r~n" + &
"                      QA_MEASUREMENT ON ~r~n" + &
"                      PD_QA_MEASUREMENTS.PROFILE_GROUP_MEASUREMENT_ID = QA_MEASUREMENT.PROFILE_GROUP_MEASUREMENT_ID INNER JOIN~r~n" + &
"                      QA_PROFILE_GROUP ON QA_MEASUREMENT.QA_PROFILE_GROUP_ID = QA_PROFILE_GROUP.QA_PROFILE_GROUP_ID~r~n" + &
"ORDER BY PD_QA_MEASUREMENTS.PD_QA_MEASUREMENTS_ID~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_question_lookup') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     question_lookup.quest_id, question_lookup.quest_type AS quest_type_lookup_code, code_lookup.code AS quest_type_code, ~r~n" + &
"                      code_lookup.description AS quest_type_description, question_lookup.short_quest, question_lookup.full_quest~r~n" + &
"FROM         question_lookup INNER JOIN~r~n" + &
"                      code_lookup ON question_lookup.quest_type = code_lookup.lookup_code~r~n" + &
"ORDER BY question_lookup.quest_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_references') + "~r~n" + &
"as select " + ls_Title + " pd_references.rec_id,pd_references.prac_id,pd_references.last_name,pd_references.first_middle_name,title_code=code_lookup_a.code,title_description=code_lookup_a.description,name_suffix_code=code_lookup_b.code,name_suffix_description=code_lookup_b.description,prof_suf_code=code_lookup_c.code,prof_suf_description=code_lookup_c.description,pd_references.street,pd_references.city,pd_references.state,state_code=code_lookup_d.code,state_description=code_lookup_d.description,pd_references.zip,pd_references.country,country_code=code_lookup_e.code,country_description=code_lookup_e.description,pd_references.cust_1,pd_references.cust_2,pd_references.cust_3,pd_references.cust_4,pd_references.cust_5 from(((((pd_references left outer join code_lookup as code_lookup_a on pd_references.title = code_lookup_a.lookup_code) left outer join code_lookup as code_lookup_b on pd_references.name_suffix = code_lookup_b.lookup_code) left outer join code_lookup as code_lookup_c on pd_references.prof_suffix = code_lookup_c.lookup_code) left outer join code_lookup as code_lookup_d on pd_references.state = code_lookup_d.lookup_code) left outer join code_lookup as code_lookup_e on pd_references.country = code_lookup_e.lookup_code) order by pd_references.rec_id,pd_references.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_sanctions') + "~r~n" + &
"AS~r~n" + &
"select " + ls_Title + " pd_sanctions.rec_id,~r~n" + &
"    pd_sanctions.prac_id,~r~n" + &
"    code_lookup_a.description as status_activity,~r~n" + &
"    code_lookup_b.description as action_sanct_name,~r~n" + &
"    pd_sanctions.taken,~r~n" + &
"    pd_sanctions.date_from,~r~n" + &
"    pd_sanctions.date_thru,~r~n" + &
"    pd_sanctions.reason_1,~r~n" + &
"    pd_sanctions.reason_2,~r~n" + &
"    pd_sanctions.reason_3,~r~n" + &
"    pd_sanctions.cust_1,~r~n" + &
"    pd_sanctions.cust_2,~r~n" + &
"    pd_sanctions.cust_3,~r~n" + &
"    pd_sanctions.cust_4,~r~n" + &
"    pd_sanctions.cust_5,~r~n" + &
"    pd_sanctions.organization_name,~r~n" + &
"    address_lookup.code as org_code,~r~n" + &
"    address_lookup.entity_name as org_name~r~n" + &
"from((~r~n" + &
"    pd_sanctions left outer join~r~n" + &
"	code_lookup as code_lookup_a on pd_sanctions.status_activity_code = code_lookup_a.lookup_code) left outer join~r~n" + &
"	code_lookup as code_lookup_b on pd_sanctions.action_sanction_code = code_lookup_b.lookup_code) INNER JOIN~r~n" + &
"	address_lookup ON pd_sanctions.organization_name = address_lookup.lookup_code INNER JOIN~r~n" + &
"	pd_basic ON pd_sanctions.prac_id = pd_basic.prac_id~r~n" + &
"order by pd_sanctions.rec_id,pd_sanctions.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_santions') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     pd_sanctions.prac_id, pd_sanctions.rec_id, code_lookup_a.code AS status_Activity_code, ~r~n" + &
"                      code_lookup_a.description AS status_activity_description, code_lookup_b.code AS action_Santion_Code, ~r~n" + &
"                      code_lookup_b.description AS action_santion_description, code_lookup_c.code AS santions_code, code_lookup_c.description AS santions_description, ~r~n" + &
"                      address_lookup_a.entity_name AS insurance_company, address_lookup_b.entity_name AS hospital, address_lookup_c.code AS org_name_code, ~r~n" + &
"                      address_lookup_c.entity_name AS org_name_description, pd_sanctions.taken, pd_sanctions.date_from, pd_sanctions.date_thru, ~r~n" + &
"                      pd_sanctions.reason_1, pd_sanctions.reason_2, pd_sanctions.reason_3, pd_sanctions.cust_4, pd_sanctions.cust_5~r~n" + &
"FROM         pd_sanctions INNER JOIN~r~n" + &
"                      pd_basic ON pd_sanctions.prac_id = pd_basic.prac_id LEFT OUTER JOIN~r~n" + &
"                      address_lookup address_lookup_a ON pd_sanctions.cust_2 = address_lookup_a.lookup_code LEFT OUTER JOIN~r~n" + &
"                      address_lookup address_lookup_b ON pd_sanctions.cust_3 = address_lookup_b.lookup_code LEFT OUTER JOIN~r~n" + &
"                      address_lookup address_lookup_c ON pd_sanctions.organization_name = address_lookup_c.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_a ON pd_sanctions.status_activity_code = code_lookup_a.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_b ON pd_sanctions.action_sanction_code = code_lookup_b.lookup_code CROSS JOIN~r~n" + &
"                      code_lookup code_lookup_c LEFT OUTER JOIN~r~n" + &
"                      pd_sanctions pd_sanctions1 ON code_lookup_c.lookup_code = pd_sanctions1.cust_1~r~n" + &
"ORDER BY pd_sanctions.prac_id, pd_sanctions.rec_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_site_survey') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     group_practice.rec_id AS gp_id, group_practice.street, review_hdr.review_description, review_hdr.maximum_score, ~r~n" + &
"                      review_hdr.minimum_passing_score, review_hdr.total_points AS review_total_score, pd_review_hdr.review_date, ~r~n" + &
"                      code_lookup.description AS review_start_time, code_lookup_1.description AS review_end_time, pd_review_hdr.contact_person, ~r~n" + &
"                      pd_review_hdr.notes_1, pd_review_hdr.notes_2, pd_review_hdr.notes_3, pd_review_hdr.total_score AS grp_total_score, ~r~n" + &
"                      code_lookup_2.description AS review_results, pd_review_hdr.active_status, pd_review_hdr.next_review_date, ~r~n" + &
"                      pd_review_hdr.lock_for_edit~r~n" + &
"FROM         pd_review_hdr INNER JOIN~r~n" + &
"                      group_practice ON pd_review_hdr.address_id = group_practice.rec_id INNER JOIN~r~n" + &
"                      review_hdr ON pd_review_hdr.review_id = review_hdr.review_id LEFT OUTER JOIN~r~n" + &
"                      code_lookup ON pd_review_hdr.review_start_time = code_lookup.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_1 ON pd_review_hdr.review_end_time = code_lookup_1.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_2 ON pd_review_hdr.review_result_code = code_lookup_2.lookup_code~r~n" + &
"ORDER BY group_practice.rec_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_site_survey_results') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     pd_review_hdr.rec_id, pd_review_hdr.address_id AS gp_id, group_practice.street, group_practice.street_2, group_practice.city, ~r~n" + &
"                      cl_state.code AS state, group_practice.zip, group_practice.phone, group_practice.ext, ~r~n" + &
"                      group_practice.contact_person AS location_contact_person, review_hdr.review_description, pd_review_hdr.review_date, ~r~n" + &
"                      cl_start_time.code AS start_time_code, cl_start_time.description AS start_time_description, cl_end_time.code AS end_time_code, ~r~n" + &
"                      cl_end_time.description AS end_time_description, review_question_groups.group_name, review_question_groups.group_order, ~r~n" + &
"                      review_question_groups_1.group_name AS subgroup_name, review_question_groups_1.group_order AS subgroup_order, ~r~n" + &
"                      pd_review_hdr.contact_person AS survey_contact_person, pd_review_hdr.reviewer_id, pd_review_hdr.notes_1 AS survey_notes_1, ~r~n" + &
"                      pd_review_hdr.notes_2 AS survey_notes_2, pd_review_hdr.notes_3 AS survey_notes_3, pd_review_hdr.total_score, ~r~n" + &
"                      pd_review_hdr.review_result_code, pd_review_hdr.active_status, pd_review_hdr.next_review_date, pd_review_hdr.lock_for_edit, ~r~n" + &
"                      CASE WHEN pd_review_hdr.lock_for_edit = 1 THEN 'Yes' ELSE 'No' END AS lock_for_edit_desc, review_question_answer.question_id, ~r~n" + &
"                      review_question.question, review_question.key_quest, ~r~n" + &
"                      CASE WHEN review_question.key_quest = 1 THEN 'Yes' ELSE 'No' END AS key_quest_desc, review_question.key_value AS key_passing_value, ~r~n" + &
"                      review_question.question_order, review_question_answer.answer_id, review_question_answer.question_answer AS answer, ~r~n" + &
"                      review_question_answer.answer_score, review_question_answer.answer_order, pd_review_answers.answer_on_off AS answer_selected, ~r~n" + &
"                      CASE WHEN pd_review_answers.answer_on_off = 1 THEN 'Yes' ELSE 'No' END AS answer_selected_desc, ~r~n" + &
"                      pd_review_answers.notes AS answer_notes~r~n" + &
"FROM group_practice ~r~n" + &
"INNER JOIN pd_review_hdr ON group_practice.rec_id = pd_review_hdr.address_id ~r~n" + &
"INNER JOIN review_hdr ON  review_hdr.review_id = pd_review_hdr.review_id ~r~n" + &
"INNER JOIN pd_review_answers ON pd_review_hdr.rec_id = pd_review_answers.rec_id ~r~n" + &
"INNER JOIN review_question_answer ON pd_review_answers.question_answer_id = review_question_answer.question_answer_id ~r~n" + &
"INNER JOIN review_question ON review_question_answer.question_id = review_question.question_id ~r~n" + &
"INNER JOIN review_question_groups review_question_groups_1 ON review_question_groups_1.review_id = review_question.review_id AND  review_question_groups_1.group_id = review_question.sub_group_id ~r~n" + &
"LEFT OUTER JOIN review_question_groups ON review_question.review_id = review_question_groups.review_id AND review_question.group_id = review_question_groups.group_id ~r~n" + &
"LEFT OUTER JOIN code_lookup cl_state ON group_practice.state = cl_state.lookup_code ~r~n" + &
"LEFT OUTER JOIN code_lookup cl_end_time ON pd_review_hdr.review_end_time = cl_end_time.lookup_code ~r~n" + &
"LEFT OUTER JOIN code_lookup cl_start_time ON pd_review_hdr.review_start_time = cl_start_time.lookup_code~r~n" + &
"ORDER BY pd_review_hdr.rec_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_sp_certs') + "~r~n" + &
"  as select " + ls_Title + " pd_special_certs.rec_id,~r~n" + &
"    pd_special_certs.prac_id,~r~n" + &
"    pd_special_certs.certified_in,~r~n" + &
"    pd_special_certs.initial_cert_month,~r~n" + &
"    pd_special_certs.initial_cert_year,~r~n" + &
"    pd_special_certs.cert_expiration_month,~r~n" + &
"    pd_special_certs.cert_expiration_year,~r~n" + &
"    pd_special_certs.certification_number,~r~n" + &
"    exam_taken_code=code_lookup.code,~r~n" + &
"    pd_special_certs.certified_by,~r~n" + &
"    pd_special_certs.cust_1,~r~n" + &
"    pd_special_certs.cust_2,~r~n" + &
"    pd_special_certs.cust_3,~r~n" + &
"    pd_special_certs.cust_4,~r~n" + &
"    pd_special_certs.cust_5~r~n" + &
"from(~r~n" + &
"    pd_special_certs left outer join code_lookup on pd_special_certs.exam_taken = code_lookup.lookup_code)~r~n" + &
"order by pd_special_certs.rec_id,pd_special_certs.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_special_certs') + "~r~n" + &
"  as select distinct " + ls_Title + " pd_special_certs.rec_id,~r~n" + &
"    pd_special_certs.prac_id,~r~n" + &
"    pd_special_certs.initial_cert_month,~r~n" + &
"    pd_special_certs.initial_cert_year,~r~n" + &
"    pd_special_certs.cert_expiration_month,~r~n" + &
"    pd_special_certs.cert_expiration_year,~r~n" + &
"    pd_special_certs.certification_number,~r~n" + &
"    pd_special_certs.certified_in,~r~n" + &
"    pd_special_certs.cust_1,~r~n" + &
"    pd_special_certs.cust_2,~r~n" + &
"    pd_special_certs.cust_3,~r~n" + &
"    pd_special_certs.cust_4,~r~n" + &
"    pd_special_certs.cust_5,~r~n" + &
"    address_lookup.code as certified_by_code,~r~n" + &
"    address_lookup.entity_name as certified_by_name,~r~n" + &
"    code_lookup_a.code as certified_in_code,~r~n" + &
"    code_lookup_a.description as certified_in_description,~r~n" + &
"    code_lookup_b.description as exam_taken from~r~n" + &
"    pd_special_certs left outer join code_lookup as code_lookup_a on pd_special_certs.certified_in = code_lookup_a.lookup_code left outer join~r~n" + &
"    address_lookup on pd_special_certs.certified_by = address_lookup.lookup_code left outer join~r~n" + &
"    code_lookup as code_lookup_b on pd_special_certs.exam_taken = code_lookup_b.lookup_code~r~n" + &
"order by pd_special_certs.rec_id,pd_special_certs.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_specialty_facility_link') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     pd_spec_facility_link.specialty_id, pd_spec_facility_link.prac_id, pd_spec_facility_link.facility_id, ~r~n" + &
"                      code_lookup.description AS practicing~r~n" + &
"FROM         pd_spec_facility_link INNER JOIN~r~n" + &
"                      code_lookup ON pd_spec_facility_link.practicing = code_lookup.lookup_code~r~n" + &
"ORDER BY pd_spec_facility_link.specialty_id, pd_spec_facility_link.prac_id, pd_spec_facility_link.facility_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_staff_cat') + "~r~n" + &
"as select distinct " + ls_Title + " pd_affil_staff_cat.rec_id,pd_affil_staff_cat.prac_id,facility_name=facility.facility_name,staff_cat_code=code_lookup_a.code,staff_cat_description=code_lookup_a.description,pd_affil_staff_cat.from_date,pd_affil_staff_cat.to_date,pd_affil_staff_cat.active_status from pd_affil_staff_cat,code_lookup as code_lookup_a,facility where(pd_affil_staff_cat.facility_id = facility.facility_id) and(pd_affil_staff_cat.staff_category = code_lookup_a.lookup_code) order by pd_affil_staff_cat.rec_id,pd_affil_staff_cat.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_staff_leave') + "~r~n" + &
"as select distinct " + ls_Title + " pd_affil_staff_leave.rec_id,pd_affil_staff_leave.prac_id,facility_name=facility.facility_name,leave_code=code_lookup_a.code,leave_description=code_lookup_a.description,pd_affil_staff_leave.from_date,pd_affil_staff_leave.to_date,pd_affil_staff_leave.active_status from pd_affil_staff_leave,code_lookup as code_lookup_b,code_lookup as code_lookup_a,facility where(pd_affil_staff_leave.facility_id = facility.facility_id) and(pd_affil_staff_leave.leave_of_absence_reason = code_lookup_b.lookup_code) order by pd_affil_staff_leave.rec_id,pd_affil_staff_leave.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_training') + "~r~n" + &
"  as select " + ls_Title + " pd_training.rec_id,~r~n" + &
"    pd_training.prac_id,~r~n" + &
"    training_type=code_lookup_a.description,~r~n" + &
"    pd_training.month_from,~r~n" + &
"    pd_training.year_from,~r~n" + &
"    pd_training.month_thru,~r~n" + &
"    pd_training.year_thru,~r~n" + &
"    pd_training.program_director,~r~n" + &
"    accred_code=code_lookup_e.code,~r~n" + &
"    specialty_name=code_lookup_b.description,~r~n" + &
"    internship_type=code_lookup_c.description,~r~n" + &
"    fellowhsip_type=code_lookup_d.description,~r~n" + &
"    pd_training.chief_res_month_from,~r~n" + &
"    pd_training.chief_res_year_from,~r~n" + &
"    pd_training.chief_res_month_thru,~r~n" + &
"    pd_training.chief_res_year_thru,~r~n" + &
"    institution_name=address_lookup.entity_name,~r~n" + &
"    pd_training.cust_1,~r~n" + &
"    pd_training.cust_2,~r~n" + &
"    pd_training.cust_3,~r~n" + &
"    pd_training.cust_4,~r~n" + &
"    pd_training.cust_5~r~n" + &
"from~r~n" + &
"    pd_training LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_a ON pd_training.train_type = code_lookup_a.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_b ON pd_training.specialty = code_lookup_b.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_c ON pd_training.internship_type_code = code_lookup_c.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_d ON pd_training.fellowship_type_code = code_lookup_d.lookup_code LEFT OUTER JOIN~r~n" + &
"    code_lookup as code_lookup_e ON pd_training.accredited = code_lookup_e.lookup_code LEFT OUTER JOIN~r~n" + &
"    address_lookup ON pd_training.institution_code = address_lookup.lookup_code~r~n" + &
"order by pd_training.rec_id,pd_training.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_verif_info') + "~r~n" + &
"AS~r~n" + &
"SELECT DISTINCT " + ls_Title + " ~r~n" + &
"                      verif_info.rec_id, verif_info.prac_id, verif_info.facility_id, facility.facility_name, verif_info.seq_no, verif_info.first_sent, ~r~n" + &
"                      verif_info.last_sent, verif_info.number_sent, verif_info.date_recieved, verif_info.user_name, code_lookup_a.code AS response_code, ~r~n" + &
"                      code_lookup_a.description AS response_descrip, code_lookup_b.code AS method_code, code_lookup_b.description AS method_descrip, ~r~n" + &
"                      data_view_screen.screen_name, data_view_screen.screen_id, verif_info.active_status, verif_info.expiration_date, ~r~n" + &
"                      verif_info.reference_value, verif_info.priority_user, verif_info.priority, verif_info.exp_credential_flag, verif_info.doc_id, ~r~n" + &
"                      verif_info.print_flag, verif_info.notes, verif_info.source, ~r~n" + &
"                      CASE verif_info.priority WHEN 1 THEN 'Low' WHEN 2 THEN 'Medium' WHEN 3 THEN 'High' ELSE 'Unknown' END AS priority_description~r~n" + &
"FROM         verif_info INNER JOIN~r~n" + &
"                      data_view_screen ON verif_info.screen_id = data_view_screen.screen_id INNER JOIN~r~n" + &
"                      code_lookup code_lookup_b ON verif_info.verification_method = code_lookup_b.lookup_code INNER JOIN~r~n" + &
"                      facility ON verif_info.facility_id = facility.facility_id LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_a ON verif_info.response_code = code_lookup_a.lookup_code~r~n" + &
"WHERE     (data_view_screen.data_view_id = 1)~r~n" + &
"ORDER BY verif_info.rec_id, verif_info.prac_id, verif_info.facility_id,verif_info.seq_no,verif_info.doc_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('view_group_practice') + "~r~n" + &
"  as select " + ls_Title + " locat_id=group_practice.rec_id,~r~n" + &
"    group_practice.prac_id,~r~n" + &
"    prac_type_code=code_lookup_d.code,~r~n" + &
"    prac_type=code_lookup_d.description,~r~n" + &
"    group_practice.street,~r~n" + &
"    group_practice.city,~r~n" + &
"    state_code=code_lookup_e.code,~r~n" + &
"    state_name=code_lookup_e.description,~r~n" + &
"    country_code=code_lookup_f.code,~r~n" + &
"    country_name=code_lookup_f.description,~r~n" + &
"    group_practice.pager_number,~r~n" + &
"    group_practice.phone,~r~n" + &
"    group_practice.ext,~r~n" + &
"    group_practice.fax,~r~n" + &
"    group_practice.zip,~r~n" + &
"    county_code=code_lookup_g.code,~r~n" + &
"    county_name=code_lookup_g.description,~r~n" + &
"    group_practice.contact_person,~r~n" + &
"    group_practice.tax_id,~r~n" + &
"    group_practice.tax_id_other_1,~r~n" + &
"    group_practice.tax_id_other_2,~r~n" + &
"    group_practice.business_mgr,~r~n" + &
"    group_practice.office_mgr,~r~n" + &
"    group_practice.e_mail_address,~r~n" + &
"    group_practice.web_address,~r~n" + &
"    group_practice.mon_from,~r~n" + &
"    group_practice.mon_to,~r~n" + &
"    group_practice.tue_from,~r~n" + &
"    group_practice.tue_to,~r~n" + &
"    group_practice.wed_from,~r~n" + &
"    group_practice.thu_from,~r~n" + &
"    group_practice.thu_to,~r~n" + &
"    group_practice.fri_from,~r~n" + &
"    group_practice.fri_to,~r~n" + &
"    group_practice.sat_from,~r~n" + &
"    group_practice.sat_to,~r~n" + &
"    group_practice.sun_from,~r~n" + &
"    group_practice.sun_to,~r~n" + &
"    group_practice.mon_from2,~r~n" + &
"    group_practice.mon_to2,~r~n" + &
"    group_practice.tue_from2,~r~n" + &
"    group_practice.tue_to2,~r~n" + &
"    group_practice.wed_from2,~r~n" + &
"    group_practice.wed_to2,~r~n" + &
"    group_practice.thu_from2,~r~n" + &
"    group_practice.thu_to2,~r~n" + &
"    group_practice.fri_from2,~r~n" + &
"    group_practice.fri_to2,~r~n" + &
"    group_practice.sat_from2,~r~n" + &
"    group_practice.sat_to2,~r~n" + &
"    group_practice.sun_from2,~r~n" + &
"    group_practice.sun_to2,~r~n" + &
"    group_practice.wed_to,~r~n" + &
"    group_practice.routine_visit_appt,~r~n" + &
"    group_practice.urgent_visit_appt,~r~n" + &
"    group_practice.emergency_visit_appt,~r~n" + &
"    group_practice.non_emergency_appt,~r~n" + &
"    young_child_code=code_lookup_h.code,~r~n" + &
"    child_code=code_lookup_i.code,~r~n" + &
"    adolescent_code=code_lookup_j.code,~r~n" + &
"    adult_code=code_lookup_k.code,~r~n" + &
"    senior_code=code_lookup_l.code,~r~n" + &
"    handicap_acc=code_lookup_m.description,~r~n" + &
"    on_public_trans=code_lookup_n.description,~r~n" + &
"    group_practice.cust_1,~r~n" + &
"    group_practice.cust_2,~r~n" + &
"    group_practice.cust_3,~r~n" + &
"    group_practice.cust_4,~r~n" + &
"    group_practice.cust_5,~r~n" + &
"    group_practice.cust_6,~r~n" + &
"    group_practice.street_2,~r~n" + &
"    group_practice.gp_id,~r~n" + &
"    accepting_new_patient=code_lookup_p.description~r~n" + &
"from((((((((((((~r~n" + &
"    group_practice left outer join code_lookup as code_lookup_d on group_practice.practice_type = code_lookup_d.lookup_code) left outer join code_lookup as code_lookup_e on group_practice.state = code_lookup_e.lookup_code) left outer join code_lookup as code_lookup_f on group_practice.country = code_lookup_f.lookup_code) left outer join code_lookup as code_lookup_g on group_practice.county = code_lookup_g.lookup_code) left outer join code_lookup as code_lookup_h on group_practice.young_child = code_lookup_h.lookup_code) left outer join code_lookup as code_lookup_i on group_practice.child = code_lookup_i.lookup_code) left outer join code_lookup as code_lookup_j on group_practice.adolescent = code_lookup_j.lookup_code) left outer join code_lookup as code_lookup_k on group_practice.adult = code_lookup_k.lookup_code) left outer join code_lookup as code_lookup_l on group_practice.senior_adult = code_lookup_l.lookup_code) left outer join code_lookup as code_lookup_m on group_practice.handicapped_access = code_lookup_m.lookup_code) left outer join code_lookup as code_lookup_n on group_practice.public_transportation = code_lookup_n.lookup_code) left outer join code_lookup as code_lookup_p on group_practice.accepting_new_patients = code_lookup_p.lookup_code)~r~n" + &
"order by group_practice.rec_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('view_pd_basic') + "~r~n" + &
"as select " + ls_Title + " pd_basic.rec_id,pd_basic.prac_id,pd_basic.first_name,pd_basic.last_name,pd_basic.middle_name,pd_basic.title,title_code=code_lookup_a.code,title_description=code_lookup_a.description,pd_basic.name_suffix,name_suffix_code=code_lookup_b.code,name_suffix_description=code_lookup_b.description,pd_basic.prof_suffix,prof_suffix_code=code_lookup_c.code,prof_suffix_description=code_lookup_c.description,pd_basic.date_of_birth,pd_basic.ssn,pd_basic.sex,gender_code=code_lookup_d.code,gender_description=code_lookup_d.description,pd_basic.prac_category,prac_category_code=code_lookup_e.code,prac_category_description=code_lookup_e.description,pd_basic.maiden_other_name,pd_basic.pob_city,pd_basic.pob_state,pd_basic.pob_country,pd_basic.citizenship,pd_basic.married,pd_basic.spouse_name,pd_basic.phone,pd_basic.answering_service,pd_basic.beeper_1,pd_basic.beeper_2,pd_basic.personal_pager,pd_basic.hospital_pager,pd_basic.car_phone_1,pd_basic.car_phone_2,pd_basic.civilian_fed_employee,pd_basic.active_military,pd_basic.reservist,pd_basic.branch,pd_basic.rank,pd_basic.service_number,pd_basic.service_date_from,pd_basic.service_date_to,pd_basic.cust_1,pd_basic.cust_2,pd_basic.cust_3,pd_basic.cust_4,pd_basic.cust_5,pd_basic.cust_6,pd_basic.cust_7,pd_basic.cust_8,pd_basic.cust_9,pd_basic.cust_10,pd_basic.full_name,pd_basic.npdb_query,pd_basic.provider_id,pd_basic.provider_type from((pd_basic left outer join code_lookup as code_lookup_b on pd_basic.name_suffix = code_lookup_b.lookup_code) left outer join code_lookup as code_lookup_d on pd_basic.sex = code_lookup_d.lookup_code),code_lookup as code_lookup_a,code_lookup as code_lookup_c,code_lookup as code_lookup_e where(pd_basic.title = code_lookup_a.lookup_code) and(pd_basic.prof_suffix = code_lookup_c.lookup_code) and(pd_basic.prac_category = code_lookup_e.lookup_code) order by pd_basic.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-08-24 By: Scofield
//$<Reason> The user need to add two view
ls_sql = of_get_view_action('v_contract_group_linked_locations') + "~r~n" + &
"as SELECT " + ls_Title + " ~r~n" + &
"        group_practice.rec_id,~r~n" + &
"        group_practice.practice_type, ~r~n" + &
"        group_practice.street,~r~n" + &
"        group_practice.street_2,~r~n" + &
"        group_practice.city,~r~n" + &
"        group_practice.state,~r~n" + &
"        group_practice.zip,~r~n" + &
"        group_practice.tax_id,~r~n" + &
"        ctx_loc.ctx_id,~r~n" + &
"        ctx_loc.parent_comp_id,~r~n" + &
"        ctx_loc.loc_id,~r~n" + &
"        ctx_loc.group_number,~r~n" + &
"        ctx_loc.local,~r~n" + &
"        ctx_loc.end_date,~r~n" + &
"        ctx_loc.term_reason,~r~n" + &
"        ctx_loc.start_date,~r~n" + &
"        ctx_loc.custom_1,~r~n" + &
"        ctx_loc.custom_2,~r~n" + &
"        ctx_loc.custom_3,~r~n" + &
"        ctx_loc.custom_4,~r~n" + &
"        ctx_loc.inserted_by_user,~r~n" + &
"        ctx_loc.inserted_at_date_time,~r~n" + &
"        ctx_loc.updated_by_user,~r~n" + &
"        ctx_loc.updated_at_date_time,~r~n" + &
"        ctx_loc.record_id~r~n" + &
"FROM 	group_practice,~r~n" + &
"        ctx_loc  ~r~n" + &
"WHERE ( ctx_loc.loc_id = group_practice.rec_id )~r~n" + &
"ORDER BY ctx_loc.ctx_id,~r~n" + &
"	 ctx_loc.parent_comp_id,~r~n" + &
"	 ctx_loc.loc_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ctx_action_items') + "~r~n" + &
"as SELECT " + ls_Title + "~r~n" + &
"	ctx_action_items.ctx_action_item_id,~r~n" + &
"	ctx_action_items.ctx_id,~r~n" + &
"	ctx_action_items.action_type,~r~n" + &
"	ctx_action_items.action_date,~r~n" + &
"	ctx_action_items.due_date,~r~n" + &
"	ctx_action_items.action_user,~r~n" + &
"	ctx_action_items.action_status,~r~n" + &
"	ctx_action_items.notes,~r~n" + &
"	ctx_action_items.ALARMED,~r~n" + &
"	ctx_action_items.first_attempt,~r~n" + &
"	ctx_action_items.last_attempt,~r~n" + &
"	ctx_action_items.no_attempts,~r~n" + &
"	ctx_action_items.assigned_to,~r~n" + &
"	ctx_action_items.print_flag,~r~n" + &
"	ctx_action_items.inserted_by_user,~r~n" + &
"	ctx_action_items.inserted_at_date_time,~r~n" + &
"	ctx_action_items.updated_by_user,~r~n" + &
"	ctx_action_items.updated_at_date_time,~r~n" + &
"	ctx_action_items.record_id,~r~n" + &
"	ctx_action_items.Letter_flag,~r~n" + &
"	ctx_action_items.letter_to,~r~n" + &
"	ctx_action_items.letter_from,~r~n" + &
"	ctx_action_items.wf_step,~r~n" + &
"	ctx_action_items.letter_id,~r~n" + &
"	ctx_action_items.wf_id,~r~n" + &
"	ctx_action_items.Wf_action_type_id,~r~n" + &
"	ctx_action_items.wf_assigned_by,~r~n" + &
"	ctx_action_items.active_status,~r~n" + &
"	ctx_action_items.wf_complete_flag,~r~n" + &
"	ctx_action_items.alm_table,~r~n" + &
"	ctx_action_items.alm_column~r~n" + &
"FROM 	ctx_action_items~r~n" + &
"ORDER BY ctx_action_items.ctx_action_item_id,~r~n" + &
"	 ctx_action_items.ctx_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

///////////////////////////////////////////////Appended start by Scofield on 2007-09-07///////////////////////////////////////////////
ls_sql = of_get_view_action('v_ctx_loc_covering_partners') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + " gp_partner_covering.rec_id, gp_partner_covering.gp_id, gp_partner_covering.prac_id, cl_title.code AS title_code, ~r~n" + &
"                      cl_title.description AS title_description, gp_partner_covering.last_name, gp_partner_covering.first_name, ~r~n" + &
"                      cl_provider_type.code AS provider_type_code, cl_provider_type.description AS provider_type_description, cl_specialty.code AS specialty_code, ~r~n" + &
"                      cl_specialty.description AS specialty_description, cl_covering.code AS covering_code, cl_covering.description AS covering_description, ~r~n" + &
"                      cl_partner.code AS partner_code, cl_partner.description AS partner_description, gp_partner_covering.license_no AS license_number, ~r~n" + &
"                      cl_license_state.code AS license_state_code, cl_license_state.description AS license_state_description, gp_partner_covering.cust_1, ~r~n" + &
"                      gp_partner_covering.cust_2, gp_partner_covering.cust_3, gp_partner_covering.cust_d4, gp_partner_covering.cust_d5, ~r~n" + &
"                      gp_partner_covering.specialty, gp_partner_covering.provider_type, gp_partner_covering.covering, gp_partner_covering.partner, ~r~n" + &
"                      gp_partner_covering.title_code AS Expr1, gp_partner_covering.middle_name~r~n" + &
"FROM         gp_partner_covering LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_covering ON cl_covering.lookup_code = gp_partner_covering.covering LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_title ON cl_title.lookup_code = gp_partner_covering.title_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_license_state ON gp_partner_covering.license_state = cl_license_state.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_partner ON gp_partner_covering.partner = cl_partner.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_provider_type ON gp_partner_covering.provider_type = cl_provider_type.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_specialty ON cl_specialty.lookup_code = gp_partner_covering.specialty~r~n" + &
"ORDER BY gp_partner_covering.rec_id, gp_partner_covering.gp_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ctx_loc_insurance') + "~r~n" + &
"AS~r~n" + &
"SELECT     gp_insurance.rec_id, gp_insurance.gp_id, gp_insurance.carrier_code, address_lookup.entity_name AS carrier, ~r~n" + &
"                      gp_insurance.policy_number, gp_insurance.coverage_from, gp_insurance.coverage_to, gp_insurance.previous_expiration_date, ~r~n" + &
"                      gp_insurance.tail_coverage, cl_tail_coverage.code AS tail_coverage_code, cl_tail_coverage.description AS tail_coverage_description, ~r~n" + &
"                      gp_insurance.coverage_limit_from, gp_insurance.coverage_limit_to, gp_insurance.state_funded_pool, ~r~n" + &
"                      cl_state_funded.code AS state_funded_pool_code, cl_state_funded.description AS state_funded_pool_description, gp_insurance.state_coverage, ~r~n" + &
"                      cl_state_coverage.code AS state_coverage_code, cl_state_coverage.description AS state_coverage_description, gp_insurance.exclusions, ~r~n" + &
"                      gp_insurance.cust_1, gp_insurance.cust_2, gp_insurance.cust_3, gp_insurance.cust_d4, gp_insurance.cust_d5, ~r~n" + &
"                      gp_insurance.claims_made_occurrence, gp_insurance.denied_explain, gp_insurance.active_status, gp_insurance.prac_id~r~n" + &
"FROM         gp_insurance LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_state_coverage ON gp_insurance.state_coverage = cl_state_coverage.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_state_funded ON gp_insurance.state_funded_pool = cl_state_funded.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_tail_coverage ON gp_insurance.tail_coverage = cl_tail_coverage.lookup_code LEFT OUTER JOIN~r~n" + &
"                      address_lookup ON gp_insurance.carrier_code = address_lookup.lookup_code~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ctx_loc_language') + "~r~n" + &
"AS~r~n" + &
"SELECT     ~r~n" + &
"      gp_language.rec_id, gp_language.gp_id, gp_language.prac_id, cl_language.code AS language_code, ~r~n" + &
"      cl_language.description AS language_description, cl_speak.code AS speak_code, cl_speak.description AS speak_description, ~r~n" + &
"      cl_reads.code AS reads_code, cl_reads.description AS reads_description, cl_writes.code AS writes_code, cl_writes.description AS writes_description, ~r~n" + &
"      cl_sign.code AS sign_code, cl_sign.description AS sign_description, gp_language.cust_1, gp_language.cust_2, gp_language.cust_3, ~r~n" + &
"      gp_language.cust_d4, gp_language.cust_d5~r~n" + &
"FROM  gp_language left OUTER JOIN code_lookup cl_sign on (cl_sign.lookup_code = gp_language.sign) ~r~n" + &
"            left  OUTER JOIN code_lookup cl_reads on (cl_reads.lookup_code = gp_language.reads )~r~n" + &
"            left  OUTER JOIN code_lookup cl_language ON gp_language.foreign_language = cl_language.lookup_code  ~r~n" + &
"            LEFT OUTER JOIN  code_lookup cl_speak ON gp_language.speak = cl_speak.lookup_code ~r~n" + &
"            LEFT OUTER JOIN  code_lookup cl_writes ON gp_language.writes = cl_writes.lookup_code~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ctx_loc_other_ids') + "~r~n" + &
"AS~r~n" + &
"SELECT     gp_other_ids.rec_id, gp_other_ids.gp_id, gp_other_ids.prac_id, code_lookup.code AS id_type_code, ~r~n" + &
"                      code_lookup.description AS id_type_description, gp_other_ids.id_number, gp_other_ids.exp_date, gp_other_ids.cust_1, ~r~n" + &
"                      gp_other_ids.cust_2, gp_other_ids.cust_3, gp_other_ids.cust_d4, gp_other_ids.cust_d5~r~n" + &
"FROM         gp_other_ids INNER JOIN~r~n" + &
"                      code_lookup ON gp_other_ids.id_type = code_lookup.lookup_code~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ctx_loc_practice_info') + "~r~n" + &
"AS~r~n" + &
"SELECT     ~r~n" + &
"      gp_practice_info.rec_id, gp_practice_info.gp_id, gp_practice_info.prac_id, gp_practice_info.corporate_name, ~r~n" + &
"      gp_practice_info.start_date, gp_practice_info.check_payable, gp_practice_info.billing_dept, ~r~n" + &
"      cl_after_hours_coverage.description AS after_hours_coverage, cl_after_hours_type.description AS after_hours_type, ~r~n" + &
"      gp_practice_info.after_hours_number, cl_pref_contact_method.description AS preferred_contact_method, ~r~n" + &
"      cl_primary_tax_id.description AS primary_tax_id, cl_gender_limitations.description AS gender_limitations, gp_practice_info.min_age, ~r~n" + &
"      gp_practice_info.max_age, gp_practice_info.other_limitations, gp_practice_info.other_handi_access, ~r~n" + &
"      gp_practice_info.other_disability_service, gp_practice_info.other_trans_access, gp_practice_info.cust_1, gp_practice_info.cust_2, ~r~n" + &
"      gp_practice_info.cust_3, gp_practice_info.cust_4, gp_practice_info.cust_5, gp_practice_info.cust_d1, ~r~n" + &
"      gp_practice_info.cust_d2~r~n" + &
"FROM gp_practice_info LEFT OUTER JOIN code_lookup cl_after_hours_coverage ON cl_after_hours_coverage.lookup_code = gp_practice_info.after_hours_coverage~r~n" + &
"                      LEFT OUTER JOIN code_lookup cl_pref_contact_method ON cl_pref_contact_method.lookup_code = gp_practice_info.prefered_contact_method~r~n" + &
"                      LEFT OUTER JOIN code_lookup cl_gender_limitations ON gp_practice_info.gender_limitations = cl_gender_limitations.lookup_code ~r~n" + &
"                      LEFT OUTER JOIN code_lookup cl_primary_tax_id ON gp_practice_info.primary_tax_id = cl_primary_tax_id.lookup_code ~r~n" + &
"                      LEFT OUTER JOIN code_lookup cl_after_hours_type ON gp_practice_info.after_hours_type = cl_after_hours_type.lookup_code~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ctx_loc_questions') + "~r~n" + &
"AS~r~n" + &
"SELECT     gp_questions.rec_id, gp_questions.gp_id, gp_questions.prac_id, gp_questions.question_id, ~r~n" + &
"                      cl_question_type.description AS quest_type, question_lookup.short_quest, question_lookup.full_quest, cl_answer.description AS answer, ~r~n" + &
"                      gp_questions.follow_up, gp_questions.followup_2~r~n" + &
"FROM         gp_questions INNER JOIN~r~n" + &
"                      question_lookup ON gp_questions.question_id = question_lookup.quest_id LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_question_type ON question_lookup.quest_type = cl_question_type.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_answer ON gp_questions.answer_code = cl_answer.lookup_code~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ctx_locations') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + " gp.rec_id AS gp_id, cl_address_type.code AS address_type_code, cl_address_type.description AS address_type_description, ~r~n" + &
"                      gp.street, gp.street_2, gp.city, cl_state.code AS state, gp.zip, cl_county.description AS county, cl_country.description AS country, gp.phone, gp.ext, ~r~n" + &
"                      gp.fax, gp.pager_number, gp.web_address, gp.e_mail_address, gp.contact_person, gp.business_mgr, gp.office_mgr, gp.tax_id, gp.tax_id_other_1, ~r~n" + &
"                      gp.tax_id_other_2, cl_accepting_new_patients.description AS accepting_new_patients, gp.cust_1, gp.cust_2, gp.cust_3, gp.cust_4, gp.cust_5, ~r~n" + &
"                      gp.cust_6, gp.active_status, cl_practice_type.description AS practice_type, gp.routine_visit_appt, gp.urgent_visit_appt, gp.emergency_visit_appt, ~r~n" + &
"                      gp.non_emergency_appt, cl_young_child.description AS young_child, cl_child.description AS child, cl_adolescent.description AS adolescent, ~r~n" + &
"                      cl_adult.description AS adult, cl_senior_adult.description AS senior_adult, cl_handicapped_access.description AS handicapped_access, ~r~n" + &
"                      cl_public_transportation.description AS public_transportation, cl_office_in_home.description AS office_in_home, gp.mon_from, gp.mon_to, ~r~n" + &
"                      gp.mon_from2, gp.mon_to2, gp.tue_from, gp.tue_to, gp.tue_from2, gp.tue_to2, gp.wed_from, gp.wed_to2, gp.wed_from2, gp.wed_to, gp.thu_from, ~r~n" + &
"                      gp.thu_to, gp.thu_from2, gp.thu_to2, gp.fri_from, gp.fri_to, gp.fri_from2, gp.fri_to2, gp.sat_from, gp.sat_to, gp.sat_from2, gp.sat_to2, gp.sun_from, ~r~n" + &
"                      gp.sun_from2, gp.sun_to, gp.sun_to2, gp.prac_id, gp.suite_apart, gp.billing_address_id~r~n" + &
"FROM         group_practice gp LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_address_type ON gp.mailing_address = cl_address_type.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_accepting_new_patients ON gp.accepting_new_patients = cl_accepting_new_patients.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_adult ON gp.adult = cl_adult.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_adolescent ON gp.adolescent = cl_adolescent.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_child ON gp.child = cl_child.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_country ON gp.country = cl_country.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_county ON gp.county = cl_county.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_handicapped_access ON gp.handicapped_access = cl_handicapped_access.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_office_in_home ON gp.office_in_home = cl_office_in_home.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_practice_type ON gp.practice_type = cl_practice_type.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_public_transportation ON gp.public_transportation = cl_public_transportation.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_senior_adult ON gp.senior_adult = cl_senior_adult.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_state ON gp.state = cl_state.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup cl_young_child ON gp.young_child = cl_young_child.lookup_code~r~n" + &
"ORDER BY gp.rec_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql
///////////////////////////////////////////////Appended start by Scofield on 2007-09-07///////////////////////////////////////////////
//---------------------------- APPEON END ----------------------------

of_execute_sql()

return 0

end function

public function integer of_update_view_v7_1 ();//////////////////////////////////////////////////////////////////////
// $<function>		n_cst_contract_sql.of_update_view_v7_1()
// $<arguments> 	None
// $<returns> 		integer
// $<description>	Update the view's sql
// $<add> 			07.23.2007 by Scofield
//////////////////////////////////////////////////////////////////////

String	ls_sql,ls_tag,ls_Title

IF gs_dbtype = "ASA" THEN 
	ls_tag = "; "
	ls_Title = "TOP 50000000"
ELSE
	ls_Title = "top 100 percent"
END IF

ls_sql = of_get_view_action('v_ctx_basic_info_master_link') + "~r~n" + &
"as SELECT " + ls_Title + " CTX_BASIC_INFO.ctx_id, app_facility.facility_name AS Company_Name, app_facility.street AS Company_street_1,app_facility.street_2 AS Company_street_2,app_facility.city AS Company_city,app_facility.state AS Company_state,app_facility.zip AS Company_zip,app_facility.country AS Company_country,app_facility.phone AS Company_phone,app_facility.fax AS Company_fax,app_facility.web_address AS Company_web_address,app_facility.contact_type2 AS Company_contact_type2,app_facility.corp_office_flag AS Company_corp_office_flag,app_facility.corp_office_link AS Company_corp_office_link,code_lookup.code AS Contract_Category_code, code_lookup.description AS Contract_Category_description, code_lookup_1.code AS Contract_Status_code, code_lookup_2.code AS contract_type_code, code_lookup_2.description AS contract_type_Description, CTX_BASIC_INFO.effective_date, CTX_BASIC_INFO.expriation_date, CTX_BASIC_INFO.review_date, CTX_BASIC_INFO.review_by, CTX_BASIC_INFO.term_date, code_lookup_3.code AS term_reason_code, code_lookup_3.description AS term_Reason_Desciption, CTX_BASIC_INFO.other_date_1, CTX_BASIC_INFO.other_date_2, CTX_BASIC_INFO.notes, CTX_BASIC_INFO.custom_1, CTX_BASIC_INFO.custom_2, CTX_BASIC_INFO.custom_3, CTX_BASIC_INFO.custom_4, CTX_BASIC_INFO.custom_5, CTX_BASIC_INFO.custom_6, CTX_BASIC_INFO.custom_7, CTX_BASIC_INFO.custom_8, CTX_BASIC_INFO.custom_9, CTX_BASIC_INFO.custom_10, CTX_BASIC_INFO.last_revis_date, code_lookup_4.description AS product_type_desc, code_lookup_4.code AS product_type_code, code_lookup_5.code AS product_code, code_lookup_5.description AS product_description FROM (((((((CTX_BASIC_INFO LEFT OUTER JOIN code_lookup ON CTX_BASIC_INFO.category = code_lookup.lookup_code) LEFT OUTER JOIN code_lookup AS code_lookup_1 ON CTX_BASIC_INFO.status = code_lookup_1.lookup_code) LEFT OUTER JOIN code_lookup AS code_lookup_2 ON CTX_BASIC_INFO.contract_type = code_lookup_2.lookup_code) LEFT OUTER JOIN code_lookup AS code_lookup_3 ON CTX_BASIC_INFO.term_reason = code_lookup_3.lookup_code) INNER JOIN app_facility ON CTX_BASIC_INFO.app_facility = app_facility.facility_id) INNER JOIN ctx_products ON CTX_BASIC_INFO.ctx_id = ctx_products.ctx_id) LEFT OUTER JOIN code_lookup AS code_lookup_4 ON ctx_products.product_type = code_lookup_4.lookup_code) LEFT OUTER JOIN code_lookup AS code_lookup_5 ON ctx_products.product_id = code_lookup_5.lookup_code ORDER BY CTX_BASIC_INFO.ctx_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_ctx_non_medical_fee_schedule') + "~r~n" + &
"as SELECT " + ls_Title + "  ctx_fee_sched_nm.ctx_id,  ctx_fee_sched_nm.fee_sched_nm_id, code_lookup1.code as category, code_lookup2.code as service_item, ctx_fee_sched_nm.description, ctx_fee_sched_nm.fee, code_lookup3.code as item_status, ctx_fee_sched_nm.start_date, ctx_fee_sched_nm.end_date, ctx_fee_sched_nm.service_name, ctx_fee_sched_nm.custom_int1, ctx_fee_sched_nm.custom_int2, ctx_fee_sched_nm.custom_fee1, ctx_fee_sched_nm.custom_fee2, ctx_fee_sched_nm.custom_fee3, ctx_fee_sched_nm.custom_text1, ctx_fee_sched_nm.custom_text2, ctx_fee_sched_nm.custom_text3, ctx_fee_sched_nm.notes, ctx_fee_sched_nm.record_id, code_lookup4.code as billing_cycle, ctx_fee_sched_nm.custom_text4, ctx_fee_sched_nm.custom_text5, ctx_fee_sched_nm.custom_text6, ctx_fee_sched_nm.custom_text7, ctx_fee_sched_nm.custom_text8, ctx_fee_sched_nm.custom_n1, ctx_fee_sched_nm.custom_n2,  ctx_fee_sched_nm.custom_n3,  ctx_fee_sched_nm.custom_n4,  ctx_fee_sched_nm.custom_n5  FROM ((((ctx_fee_sched_nm LEFT OUTER JOIN code_lookup AS code_lookup1 ON ctx_fee_sched_nm.category = code_lookup1.lookup_code and code_lookup1.lookup_name = 'Contract Fee Schd Cat. (NM)' ) LEFT OUTER JOIN code_lookup AS code_lookup2 ON ctx_fee_sched_nm.service_item = code_lookup2.lookup_code and code_lookup2.lookup_name = 'Contract Service (NM)') LEFT OUTER JOIN code_lookup AS code_lookup3 ON ctx_fee_sched_nm.item_status = code_lookup3.lookup_code and code_lookup3.lookup_name = 'Contract Fee Sched Stat. (NM)') LEFT OUTER JOIN code_lookup AS code_lookup4 ON ctx_fee_sched_nm.billing_cycle = code_lookup4.lookup_code and code_lookup4.lookup_name = 'Contract Billing Cycle') ORDER BY ctx_fee_sched_nm.ctx_id,  ctx_fee_sched_nm.fee_sched_nm_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_group_location_parent_org') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     rec_id AS parent_org_id, gp_name AS parent_org_name, street1, street2, city, state, phone, zip, contact_name, info1 AS tax_id, info2 AS custom_1, ~r~n" + &
"                      info3 AS custom_2, info4 AS custom_3, info5 AS custom_4, info6 AS custom_5~r~n" + &
"FROM         group_multi_loc~r~n" + &
"ORDER BY group_multi_loc.rec_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_invoice_inventory') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     invt_id AS inventory_id, description, code, cost, price~r~n" + &
"FROM         invt_items~r~n" + &
"ORDER BY invt_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_meeting_attendence_v6') + "~r~n" + &
"AS~r~n" + &
"SELECT " + ls_Title + "     attendence.meeting_id, attendence.prac_id, LTRIM(RTRIM(ISNULL(pd_basic.last_name, ''))) + ', ' + ISNULL(pd_basic.first_name, '') ~r~n" + &
"                      + ' ' + SUBSTRING(ISNULL(pd_basic.middle_name, ''), 1, 1) + CASE WHEN isnull(pd_basic.middle_name, '') ~r~n" + &
"                      = '' THEN '' ELSE '.,' END + LTRIM(RTRIM(ISNULL~r~n" + &
"                          ((SELECT     code~r~n" + &
"                              FROM         code_lookup~r~n" + &
"                              WHERE     pd_basic.name_suffix = code_lookup.lookup_code), ''))) + CASE WHEN isnull~r~n" + &
"                          ((SELECT     code~r~n" + &
"                              FROM         code_lookup~r~n" + &
"                              WHERE     pd_basic.name_suffix = code_lookup.lookup_code), '') = '' THEN '' ELSE ', ' END + LTRIM(RTRIM(ISNULL~r~n" + &
"                          ((SELECT     code~r~n" + &
"                              FROM         code_lookup~r~n" + &
"                              WHERE     pd_basic.prof_suffix = code_lookup.lookup_code), ''))) AS practitioner_name, attendence.active_status, ~r~n" + &
"                      CASE WHEN attendence.active_status = 1 THEN 'Active' ELSE 'Inactive' END AS active_status_description, ~r~n" + &
"                      cl_attendence_status.code AS attendence_status_code, cl_attendence_status.description AS attendence_status_description~r~n" + &
"FROM         attendence INNER JOIN~r~n" + &
"                      code_lookup cl_attendence_status ON attendence.attendence_status = cl_attendence_status.lookup_code INNER JOIN~r~n" + &
"                      pd_basic ON attendence.prac_id = pd_basic.prac_id~r~n" + &
"ORDER BY attendence.meeting_id, attendence.prac_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

ls_sql = of_get_view_action('v_affil_dept') + "~r~n" + &
"AS~r~n" + &
"SELECT DISTINCT " + ls_Title + "~r~n" + &
"                      pd_affil_dept.rec_id, pd_affil_dept.prac_id, pd_affil_dept.facility_id, facility.facility_name, code_lookup_a.lookup_code AS dept_id, ~r~n" + &
"                      code_lookup_a.code AS dept_code, code_lookup_a.description AS dept_name, code_lookup_b.code AS section_code, ~r~n" + &
"                      code_lookup_b.description AS section_name, code_lookup_d.code AS division_code, code_lookup_d.description AS division_name, ~r~n" + &
"                      pd_affil_dept.primary_dept, pd_affil_dept.from_date, pd_affil_dept.to_date, pd_affil_dept.active_status, ~r~n" + &
"                      CASE WHEN pd_affil_dept.primary_dept = 1 THEN 'Yes' ELSE 'No' END AS primary_dept_description, ~r~n" + &
"                      CASE WHEN pd_affil_dept.primary_dept = 1 THEN 'Y' ELSE 'N' END AS primary_dept_code~r~n" + &
"FROM         pd_affil_dept INNER JOIN~r~n" + &
"                      facility ON pd_affil_dept.facility_id = facility.facility_id INNER JOIN~r~n" + &
"                      code_lookup code_lookup_a ON pd_affil_dept.department = code_lookup_a.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_b ON pd_affil_dept.[section] = code_lookup_b.lookup_code LEFT OUTER JOIN~r~n" + &
"                      code_lookup code_lookup_d ON pd_affil_dept.rank = code_lookup_d.lookup_code~r~n" + &
"ORDER BY pd_affil_dept.rec_id, pd_affil_dept.prac_id, pd_affil_dept.facility_id~r~n" + ls_tag
ls_sql_statments[upperbound(ls_sql_statments) + 1] = ls_sql

of_execute_sql()

return 0

end function

public subroutine of_update_screen ();//////////////////////////////////////////////////////////////////////
// $<function>of_update_screen()
// $<arguments>(None)
// $<returns> (none)
// $<description>Update Screen Syntax,instead of of_appeon2_change function
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 08.03.2007 By Jervis
//////////////////////////////////////////////////////////////////////

integer i,li_num,li_rowcount,li_row
string ls_tab_name[],ls_screen_name[],ls_dw_name[],ls_dataobject[]
string ls_sql,ls_error_create
datastore lds_sql
datastore lds_source,lds_target,lds_properties
Long ll_count , ll_find
boolean lb_update_falg 
long ll_view_id,ll_screen_id
string ls_dataobject1
datetime ldt_modify_date

lb_update_falg = true
lds_source = create datastore
lds_sql = create datastore
lds_target = create datastore
lds_properties = create datastore

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.18.2007 By: Jack
//$<reason> Fix a defect
//Delete from  ctx_screen where screen_id = 32 and dataobject <> 'd_dm_browse_filter';
update ctx_screen set screen_name = 'Other Contacts' + substring(screen_name,9,100) where screen_id in (14,15,16,17) and substring(screen_name,1,8) = 'Contacts';

lds_source.dataobject = 'd_dm_browse_filter'
lds_source.settransobject(sqlca)
ls_sql = lds_source.Describe("datawindow.syntax")
update ctx_screen set 
	  dw_sql = :ls_sql, 
	  modify_date = getdate(),
	  screen_name = 'Document Manager->Document Tab->Search Criteria',
	  dw_name = 'dw_filter',
	  dataobject = 'd_dm_browse_filter'
where screen_id = 32 and dataobject = 'd_cntx_images';
commit;
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 06/05/2007 By: Jervis
//$<reason> Force update screen 
of_register_screen('d_contract_search',2007-07-14)         //Modify by Jack 07/13/2007
of_register_screen('d_sp_contract_search',2007-06-01)      //Modify by Jack 06/01/2007
of_register_screen('d_contract_det_master',2007-06-01)     //Modify by Jack 06/01/2007
of_register_screen('d_cntx_action_items',2007-05-09)
of_register_screen('d_contract_det_contact_contact_det',2007-04-22)
of_register_screen('d_ctx_schedule_fee_notes',2007-04-22)
of_register_screen('d_contract_group_linked_locations',2007-05-22) //Modify by Jack 05/22/2007
of_register_screen('d_contract_profile_req_questions',2007-04-22)
of_register_screen('d_contract_profile_req2',2007-04-30)
of_register_screen('d_contract_profile_req_existing',2007-04-30)
of_register_screen('d_cntx_action_items_browse',2007-08-21) //Fixed BugJ082019 by Ken 08/21/2007  
of_appeon_forceupdate_screen()
//---------------------------- APPEON END ----------------------------

lds_properties.dataobject = "d_update_user_datawindow_objlist"
lds_sql.dataobject = 'd_contract_dw_sql_update'
lds_sql.settransobject(sqlca)
lds_sql.retrieve()


ls_tab_name[1] = 'tabpage_search'
ls_tab_name[2] = 'tabpage_search'
ls_tab_name[3] = 'tabpage_details'
ls_tab_name[4] = 'tabpage_details'
ls_tab_name[5] = 'tabpage_details'
ls_tab_name[6] = 'tabpage_details'
ls_tab_name[7] = 'tabpage_details'
ls_tab_name[8] = 'tabpage_details'
ls_tab_name[9] = 'tabpage_details'
ls_tab_name[10] = 'tabpage_details'
ls_tab_name[11] = 'tabpage_requirements'
ls_tab_name[12] = 'tabpage_requirements'
ls_tab_name[13] = 'tabpage_requirements'
ls_tab_name[14] = 'tabpage_contacts'
ls_tab_name[15] = 'tabpage_contacts'
ls_tab_name[16] = 'tabpage_contacts'
ls_tab_name[17] = 'tabpage_contacts'
ls_tab_name[18] = 'tabpage_locations'
ls_tab_name[19] = 'tabpage_locations'
ls_tab_name[20] = 'tabpage_locations'
ls_tab_name[21] = 'tabpage_locations'
ls_tab_name[22] = 'tabpage_orgabizations'
ls_tab_name[23] = 'tabpage_orgabizations'
ls_tab_name[24] = 'tabpage_orgabizations'
ls_tab_name[25] = 'tabpage_orgabizations'
ls_tab_name[26] = 'tabpage_fee_schedules'
ls_tab_name[27] = 'tabpage_fee_schedules'
ls_tab_name[28] = 'tabpage_fee_schedules'
ls_tab_name[29] = 'tabpage_fee_schedules'
ls_tab_name[30] = 'tabpage_fee_schedules'
ls_tab_name[31] = 'tabpage_fee_sched2'
ls_tab_name[32] = 'tabpage_images'
ls_tab_name[33] = 'tabpage_action_items'
ls_tab_name[34] = 'tabpage_qrg'
ls_tab_name[35] = 'tabpage_qrg'
ls_tab_name[36] = 'tabpage_qrg'
ls_tab_name[37] = 'tabpage_qrg'
ls_tab_name[38] = 'tabpage_qrg'
ls_tab_name[39] = 'tabpage_qrg'
ls_tab_name[40] = 'tabpage_qrg'
ls_tab_name[41] = 'tabpage_qrg'
ls_tab_name[42] = 'tabpage_action_items'
ls_tab_name[43] = 'tabpage_details'
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.18.2007 By: Jack
//$<reason> 
ls_tab_name[44] = 'tabpage_images'
ls_tab_name[45] = 'tabpage_images'
ls_tab_name[46] = 'tabpage_images'
ls_tab_name[47] = 'tabpage_images'
ls_tab_name[48] = 'tabpage_images'
ls_tab_name[49] = 'tabpage_images'
//---------------------------- APPEON END ----------------------------

ls_screen_name[1] = 'Search->Search Criteria'
ls_screen_name[2] = 'Search->Contract Browse'
ls_screen_name[3] = 'Details->Contract Detail'
ls_screen_name[4] = 'Details->Products'
ls_screen_name[5] = 'Details->Contract Dates'
ls_screen_name[6] = 'Details->Contracted Company Contact'
ls_screen_name[7] = 'Details->Our Company Contact'
ls_screen_name[8] = 'Details->Notes Tab->Notes'
ls_screen_name[9] = 'Details->Custom Data Tab->Custom Data'
ls_screen_name[10] = 'Details->Audit Trail Tab->Audit Trail'
ls_screen_name[11] = 'Requirements->Profile Selection'
ls_screen_name[12] = 'Requirements->Profile Detail'
ls_screen_name[13] = 'Requirements->Profile Detail'
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.18.2007 By: Jack
//$<reason> Fix a defect.
/*
ls_screen_name[14] = 'Contacts->Contacts List'
ls_screen_name[15] = 'Contacts->Contract Details'
ls_screen_name[16] = 'Contacts->Contract Information'
ls_screen_name[17] = 'Contacts->Contract Notes'
*/
ls_screen_name[14] = 'Other Contacts->Contacts List'
ls_screen_name[15] = 'Other Contacts->Contract Details'
ls_screen_name[16] = 'Other Contacts->Contract Information'
ls_screen_name[17] = 'Other Contacts->Contract Notes'
//---------------------------- APPEON END ----------------------------
ls_screen_name[18] = 'Locations->Parent Organization'
ls_screen_name[19] = 'Locations->Group/Location'
ls_screen_name[20] = 'Locations->Associated Physicians'
ls_screen_name[21] = 'Locations->Specialties'
ls_screen_name[22] = 'Organizations->Organization List'
ls_screen_name[23] = 'Organizations->Address'
ls_screen_name[24] = 'Organizations->Notes'
ls_screen_name[25] = 'Organizations->Organization Contacts'
ls_screen_name[26] = 'Fee Schedules->Browse Tab->Fee Schedules'
ls_screen_name[27] = 'Fee Schedules->Browse Tab->Fee Schedule Locations'
ls_screen_name[28] = 'Fee Schedules->Browse Tab->Fees'
ls_screen_name[29] = 'Fee Schedules->Browse Tab->Providers'
ls_screen_name[30] = 'Fee Schedules->Notes Tab->User Defined data'
ls_screen_name[31] = 'Fee Schedule (NM)->Fee Schedule (Non Healthcare)'
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.18.2007 By: Jack
//$<reason> Fix a defect.
/*
ls_screen_name[32] = 'Supporting Documents->Browse Tab->Scanned Documents'
*/
ls_screen_name[32] = 'Document Manager->Document Tab->Search Criteria'

//---------------------------- APPEON END ----------------------------
ls_screen_name[33] = 'Action Items->Action Item List'
ls_screen_name[34] = 'QRG->Select Data Tab->Report Profiles'
ls_screen_name[35] = 'QRG->Select Data Tab->Basic Information to Include'
ls_screen_name[36] = 'QRG->Select Data Tab->Contract Contact Information to Include'
ls_screen_name[37] = 'QRG->Select Data Tab->Precertifications Requirements'
ls_screen_name[38] = 'QRG->Select Data Tab->Authorizations Requirements'
ls_screen_name[39] = 'QRG->Select Data Tab->Fee Schedule Data to Include'
ls_screen_name[40] = 'QRG->Select Data Tab->Organization Types to Include'
ls_screen_name[41] = 'QRG->Select Data Tab->Requirements to Include'
ls_screen_name[42] = 'Action Items->Action Item Browse'
ls_screen_name[43] = 'Details->Linked Contracts Tab->Linked Contracts'
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.18.2007 By: Jack
//$<reason> Fix a defect.
ls_screen_name[44] = 'Document Manager->Document Tab->Document Browse'
ls_screen_name[45] = 'Document Manager->Work Flow Tab->Search Criteria'
ls_screen_name[46] = 'Document Manager->Work Flow Tab->Action Item Browse'
ls_screen_name[47] = 'Document Manager->Work Flow Tab->Action Item Detail'
ls_screen_name[48] = 'Document Manager->Audit Trail Tab->Search Criteria'
ls_screen_name[49] = 'Document Manager->Audit Trail Tab->Document Browse'

//---------------------------- APPEON END ----------------------------

ls_dw_name[1] = 'dw_search'
ls_dw_name[2] = 'dw_search_det1'
ls_dw_name[3] = 'dw_1'
ls_dw_name[4] = 'dw_products'
ls_dw_name[5] = 'dw_contract_dates'
ls_dw_name[6] = 'dw_ccc'
ls_dw_name[7] = 'dw_occ'
ls_dw_name[8] = 'dw_1'
ls_dw_name[9] = 'dw_1'
ls_dw_name[10] = 'dw_1'
ls_dw_name[11] = 'dw_2'
ls_dw_name[12] = 'dw_req_det'
ls_dw_name[13] = 'dw_req_det'
ls_dw_name[14] = 'dw_search'
ls_dw_name[15] = 'dw_detail'
ls_dw_name[16] = 'dw_phone'
ls_dw_name[17] = 'dw_notes'
ls_dw_name[18] = 'dw_main'
ls_dw_name[19] = 'dw_detail'
ls_dw_name[20] = 'dw_doctors'
ls_dw_name[21] = 'dw_spec'
ls_dw_name[22] = 'dw_search'
ls_dw_name[23] = 'dw_main'
ls_dw_name[24] = 'dw_notes'
ls_dw_name[25] = 'dw_contacts'
ls_dw_name[26] = 'dw_main'
ls_dw_name[27] = 'dw_locations'
ls_dw_name[28] = 'dw_fee_schedule'
ls_dw_name[29] = 'dw_codes'
ls_dw_name[30] = 'dw_1'
ls_dw_name[31] = 'dw_fee_nm'
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.18.2007 By: Jack
//$<reason> Fix a defect.
/*
ls_dw_name[32] = 'dw_1'
*/
ls_dw_name[32] = 'dw_filter'
//---------------------------- APPEON END ----------------------------
ls_dw_name[33] = 'dw_1'
ls_dw_name[34] = 'dw_profile'
ls_dw_name[35] = 'dw_basic_info'
ls_dw_name[36] = 'dw_contact_info'
ls_dw_name[37] = 'dw_precert'
ls_dw_name[38] = 'dw_auth'
ls_dw_name[39] = 'dw_1'
ls_dw_name[40] = 'dw_2'
ls_dw_name[41] = 'dw_requirements'
ls_dw_name[42] = 'dw_1'
ls_dw_name[43] = 'dw_1'
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.18.2007 By: Jack
//$<reason> Fix a defect.
ls_dw_name[44] = 'dw_browse'
ls_dw_name[45] = 'dw_filter'
ls_dw_name[46] = 'dw_browse'
ls_dw_name[47] = 'dw_detail'
ls_dw_name[48] = 'dw_filter'
ls_dw_name[49] = 'dw_browse'

//---------------------------- APPEON END ----------------------------

ls_dataobject[1] = 'd_contract_search'
ls_dataobject[2] = 'd_sp_contract_search'
ls_dataobject[3] = 'd_contract_det_master'
ls_dataobject[4] = 'd_ctx_products'
ls_dataobject[5] = 'd_contract_det_master_2'
ls_dataobject[6] = 'd_contract_det_contact_external'
ls_dataobject[7] = 'd_contract_det_contact_external'
ls_dataobject[8] = 'd_contract_det_notes'
ls_dataobject[9] = 'd_contract_det_custom'
ls_dataobject[10] = 'd_view_audit2_ctx'
ls_dataobject[11] = 'd_profile_header'
ls_dataobject[12] = 'd_contract_profile_req2'
ls_dataobject[13] = 'd_contract_profile_req_existing'
ls_dataobject[14] = 'd_contract_det_contact_contact'
ls_dataobject[15] = 'd_contract_det_contact_contact_det'
ls_dataobject[16] = 'd_contract_det_contact_contact_phone'
ls_dataobject[17] = 'd_contract_det_contact_contact_notes'
ls_dataobject[18] = 'd_contract_multi_group_browse'
ls_dataobject[19] = 'd_contract_group_linked_locations'
ls_dataobject[20] = 'd_contract_group_practitioners_existing'
ls_dataobject[21] = 'd_cntx_location_spec'
ls_dataobject[22] = 'd_org_search2'
ls_dataobject[23] = 'd_org_tabpg'
ls_dataobject[24] = 'd_org_notes'
ls_dataobject[25] = 'd_org_contacts'
ls_dataobject[26] = 'd_ctx_free_sched_hdr'
ls_dataobject[27] = 'd_ctx_schedule_fee_locations'
ls_dataobject[28] = 'd_ctx_schedule_fee_detail'
ls_dataobject[29] = 'd_ctx_schedule_fee_pracs'
ls_dataobject[30] = 'd_ctx_schedule_fee_notes'
ls_dataobject[31] = 'd_contract_fee_sched_nm'
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.18.2007 By: Jack
//$<reason> Fix a defect.
/*
ls_dataobject[32] = 'd_cntx_images'
*/
ls_dataobject[32] = 'd_dm_browse_filter'

//---------------------------- APPEON END ----------------------------
ls_dataobject[33] = 'd_cntx_action_items'
ls_dataobject[34] = 'd_report_hdr'
ls_dataobject[35] = 'd_qrg_sys_fields'
ls_dataobject[36] = 'd_qrg_sys_fields'
ls_dataobject[37] = 'd_profile_codes'
ls_dataobject[38] = 'd_profile_codes'
ls_dataobject[39] = 'd_qrg_sys_fields'
ls_dataobject[40] = 'd_profile_codes'
ls_dataobject[41] = 'd_contract_profile_req_questions'
ls_dataobject[42] = 'd_cntx_action_items_browse'
ls_dataobject[43] = 'd_sp_contract_search'
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.18.2007 By: Jack
//$<reason> Fix a defect.
ls_dataobject[44] = 'd_dm_doc_tree'
ls_dataobject[45] = 'd_dm_ai_filter'
ls_dataobject[46] = 'd_dm_doc_ai_browse'
ls_dataobject[47] = 'd_dm_doc_ai_detail'
ls_dataobject[48] = 'd_dm_audit_filter'
ls_dataobject[49] = 'd_dm_doc_audit_browse'
//---------------------------- APPEON END ----------------------------


li_num = UpperBound(ls_tab_name)
ll_count = lds_sql.rowcount() 
if Not isvalid( w_infodisp ) then open(w_infodisp)
if isvalid(w_infodisp) then w_infodisp.title = 'Update screen of view, Please stand by'
if isvalid(w_infodisp) then w_infodisp.Center = TRUE
if isvalid(w_infodisp) then w_infodisp.st_complete.visible = false
if isvalid(w_infodisp) then w_infodisp.st_3.visible = false
if isvalid(w_infodisp) then w_infodisp.st_information.visible = false
if isvalid(w_infodisp) then w_infodisp.st_1.text = 'Update screen of view, Please stand by!'
if isvalid(w_infodisp) then w_infodisp.wf_set_min_max(1,li_num)
for i = 1 to li_num
	
	if isvalid(w_infodisp) then 
		w_infodisp.wf_step_pbar(1)
		w_infodisp.st_1.text = 'Modification ' + string(i) + ' of ' + string(li_num)+' Please stand by!'
	end if
	
	lds_source.dataobject = ls_dataobject[i]
	lds_source.settransobject(sqlca)
				
	ll_find = lds_sql.find("dataobject = '" + ls_dataobject[i] + "'" + " and screen_name = '" + ls_screen_name[i] + "'", 1 , ll_count)	
	if ll_find > 0 then				
		if lb_update_falg then	//Update All Screen syntax
			do 
				//Update Screen syntax
				ll_view_id = lds_sql.GetItemNumber(ll_find,"data_view_id")
				ll_screen_id = lds_sql.GetItemNumber(ll_find,"screen_id")
				
				IF appeongetclienttype() = 'PB' then
					ls_sql = f_get_screen_sql(ll_view_id,ll_screen_id,false)  //add false argu - jervis 10.11.2011
				else
					ls_sql = lds_sql.GetItemString(ll_find,"dw_sql")
				end if
	
				lds_target.Create(ls_sql, ls_error_create)
				lds_target.SetTransObject(SQLCA)
				
				lds_properties.Reset()
				
				ls_sql = of_update_object(lds_target,lds_source,lds_properties)
				
				lds_sql.SetItem(ll_find,"dw_sql",ls_sql)
				lds_sql.setitem(ll_find,'modify_date',today())
				
				if ll_find = ll_count then exit
				ll_find = lds_sql.find("dataobject = '" + ls_dataobject[i] + "'" + " and screen_name = '" + ls_screen_name[i] + "'", ll_find + 1 , ll_count)	
			loop WHILE (ll_find > 0)
		else
			//update sql when update = 1 and version > number of current version
		end if					

		
	Else
		ls_sql = lds_source.Describe("datawindow.syntax")
		li_row = lds_sql.insertrow(0)	
		lds_sql.setitem(li_row,'data_view_id',1001)
		lds_sql.setitem(li_row,'screen_id',i)
		lds_sql.setitem(li_row,'tab_name',ls_tab_name[i])
		lds_sql.setitem(li_row,'screen_name',ls_screen_name[i])
		lds_sql.setitem(li_row,'dw_name',ls_dw_name[i])
		lds_sql.setitem(li_row,'dataobject',ls_dataobject[i])
		lds_sql.setitem(li_row,'dw_sql',ls_sql)
		lds_sql.setitem(li_row,'create_date',today())
		lds_sql.setitem(li_row,'modify_date',today())
	End if
		
next

If lds_sql.update() <> 1 Then
	ii_num++
	If ii_num < 3 Then
		of_appeon2_changes()
	End If
End If
ii_num = 1
commit;

////--------------------------- APPEON BEGIN ---------------------------
////$<add> 05.06.2007 By: Jack
////$<reason> Fix a defect.
//
//for i = 1 to li_num
//	ll_find = lds_sql.find("dataobject = '" + ls_dataobject[i] + "'" + " and screen_name = '" + ls_screen_name[i] + "'", 1 , ll_count)	
//	if ll_find > 0 then				
//		ls_dataobject1 = ls_dataobject[i]
//		ldt_modify_date = datetime(date('2007-04-22'))
//		
//		If ls_dataobject1 = 'd_contract_search' Or ls_dataobject1 = 'd_sp_contract_search' Or ls_dataobject1 = 'd_contract_det_master' Or ls_dataobject1 = 'd_cntx_action_items' Or ls_dataobject1 = 'd_contract_det_contact_contact_det' Or ls_dataobject1 = 'd_ctx_schedule_fee_notes' Or ls_dataobject1 = 'd_contract_group_linked_locations' Or ls_dataobject1 = 'd_contract_profile_req_questions' Or ls_dataobject1 = 'd_contract_profile_req2' Then
//			lds_source.dataobject = ls_dataobject1
//			lds_source.settransobject(sqlca)
//			ls_sql = lds_source.Describe("datawindow.syntax")
//			update ctx_screen set dw_sql = :ls_sql, modify_date = :ldt_modify_date where dataobject = :ls_dataobject1 and modify_date < :ldt_modify_date;
//		End If
//		
//		ldt_modify_date = datetime(date('2007-04-31'))
//	   If ls_dataobject1 = 'd_contract_profile_req_existing' or ls_dataobject1 = 'd_contract_profile_req2' Then
//			lds_source.dataobject = ls_dataobject1
//			lds_source.settransobject(sqlca)
//			ls_sql = lds_source.Describe("datawindow.syntax")
//			update ctx_screen set dw_sql = :ls_sql, modify_date = :ldt_modify_date where dataobject = :ls_dataobject1 and modify_date < :ldt_modify_date;
//		End If
//		
//		ldt_modify_date = datetime(date('2007-05-07'))  // Add by Jack 05.05.2007
//	   If ls_dataobject1 = 'd_sp_contract_search' Then
//			lds_source.dataobject = ls_dataobject1
//			lds_source.settransobject(sqlca)
//			ls_sql = lds_source.Describe("datawindow.syntax")
//			update ctx_screen set dw_sql = :ls_sql, modify_date = :ldt_modify_date where dataobject = :ls_dataobject1 and modify_date < :ldt_modify_date;
//		End If
//	End If
//		
//Next
////---------------------------- APPEON END ----------------------------


destroy lds_sql
destroy lds_source
destroy lds_target
destroy lds_properties

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.27.2007 By: Jack
//$<reason> Fix a defect.
delete from ctx_screen where screen_id = 44;
//---------------------------- APPEON END ----------------------------

//$<add> 11.08.2006 By: Davis
//$<reason> Fix a defect.
insert into ctx_screen(data_view_id,screen_id,tab_name,screen_name,dw_name,dataobject,description,dw_sql,create_date,modify_date)
select d.data_view_id,a.screen_id,a.tab_name,screen_name,dw_name,dataobject,description,dw_sql,create_date,modify_date from ctx_screen a,data_view d
where d.type_c = 'C' AND a.data_view_id = 1001 and d.data_view_id <> 1001
and exists(
select 1 from ctx_screen b
where data_view_id <> 1001
and a.tab_name = b.tab_name
and d.data_view_id = b.data_view_id
)
and not exists(
select 1 from ctx_screen c
where c.data_view_id <> 1001
and d.data_view_id = c.data_view_id
and a.screen_id = c.screen_id
and a.tab_name = c.tab_name
);
//$<add> 11.08.2006 By: Davis
if isvalid( w_infodisp ) then close(w_infodisp)


end subroutine

public function integer of_get_objectpro (datastore ids_terget, ref datastore ids_properties, string as_objname);Integer i,li_objcount

String ls_colpro[],ls_DwPro[]
String ls_proname, ls_provalue
Integer j, li_colcount,li_DwProCount
Integer li_insert


//Init update properties
ls_colpro = {"Font.Face","Font.Italic","Font.Underline","Font.Weight","x","y","width","height","alignment","color","background.color","tabsequence","Edit.Required","dddw.PercentWidth","Edit.Case","DDLB.Case","EditMask.Mask","edit.displayonly","edit.AutoHScroll","edit.NilIsNull","dddw.VscrollBar","dddw.AutoHScroll","dddw.useasborder","dddw.NilIsNull","dddw.name","dddw.datacolumn","dddw.displaycolumn","dddw.PercentWidth","tag","dddw.displaycolumn","Initial","visible","protect","border"}


ls_DwPro = {"Detail.Height","Table.Sort"}

li_colcount = UpperBound(ls_colpro)

li_DwProCount = UpperBound(ls_DwPro)

if ids_terget.Describe(as_objname + ".type") = "column" then
	For j = 1 To li_colcount
		ls_proname = ls_colpro[j]
		ls_provalue = ids_terget.Describe(as_objname+"."+ls_proname)
		if isnull(ls_provalue) then ls_provalue = "!"
		Choose Case ls_provalue
			Case "!","?"
				Continue;
			Case Else
				li_insert = ids_properties.InsertRow(0)
				ids_properties.Object.obj_name[li_insert] = as_objname
				ids_properties.Object.obj_pro[li_insert] = ls_proname
				ids_properties.Object.obj_value[li_insert] = ls_provalue
		End Choose
	Next
end if

if lower(as_objname) = "datawindow" then
	for j = 1 to li_DwProCount
		ls_proname = ls_DwPro[j]
		ls_provalue = ids_terget.Describe("DataWindow." + ls_proname)
		li_insert = ids_properties.InsertRow(0)
		ids_properties.Object.obj_name[li_insert] = as_objname
		ids_properties.Object.obj_pro[li_insert] = ls_proname
		ids_properties.Object.obj_value[li_insert] = ls_provalue
	next
end if

Return 1
end function

public function string of_update_object (datastore ads_target, datastore ads_source, datastore ads_properties);/********************************************************************
Function  : of_update_object
			   returns string
arguements: datastore ads_target
				datastore ads_source
describe  : update the syntax of dw object
Author    : Jervis 08.03.2007
********************************************************************/

String  ls_sObjects, ls_tObjects
String  ls_sObjectlist[],ls_tObjectlist[]
String  ls_ObjName
long    ll_i,ll_j,ll_sObjcount,ll_tObjcount
String  ls_Type
String  ls_Err,ls_Modify
string ls_tSyntax,ls_sSyntax,ls_newObjSyntax
long ll_sPos_s,ll_ePos_s,ll_sPos_t,ll_ePos_t



ls_sObjects  = ads_source.Describe("DataWindow.Objects")
ll_sObjcount = inv_string.of_parsetoarray(ls_sObjects,'~t',ls_sObjectlist)
ls_sSyntax = ads_source.Describe("Datawindow.syntax")

ls_tObjects  = ads_target.Describe("DataWindow.Objects")
ll_tObjcount = inv_string.of_parsetoarray(ls_tObjects,'~t',ls_tObjectlist)
ls_tSyntax = ads_target.Describe("Datawindow.syntax")

//Reset Object Properties
ads_properties.Reset()

for ll_i = 1 to ll_tObjcount
	ls_ObjName = ls_tObjectlist[ll_i]
	//Update Object Syntax,no include column object
	ls_Type =  ads_source.Describe(ls_ObjName + ".type") 
	if ls_Type <> '!' and ls_Type <> '?' then
		if ls_type <> "column" then
			of_get_ObjPos(ls_sSyntax,ls_type,ls_ObjName,ll_sPos_s,ll_ePos_s)
			of_get_ObjPos(ls_tSyntax,ls_type,ls_ObjName,ll_sPos_t,ll_ePos_t)
			ls_newObjSyntax = Mid(ls_tSyntax,ll_sPos_t,ll_ePos_t - ll_sPos_t)
			ls_sSyntax = Replace(ls_sSyntax,ll_sPos_s,ll_ePos_s - ll_sPos_s, ls_newObjSyntax)
		else
			of_get_objectpro(ads_target,ads_properties,ls_ObjName)
		end if
	else		//Object Not Exists
		ls_Type    = ads_target.Describe(ls_ObjName + ".type")
		//Add object,Process compute,text only
		if ls_Type = 'compute' OR ls_Type = 'text' then 		
			of_get_ObjPos(ls_tSyntax,ls_type,ls_ObjName,ll_sPos_t,ll_ePos_t)
			ls_newObjSyntax = Mid(ls_tSyntax,ll_sPos_t,ll_ePos_t - ll_sPos_t)

			ls_Modify = ls_Modify + " create " + ls_newObjSyntax			
		end if
	end if
next
	
//Re-Create DataWindow
if ads_source.Create(ls_sSyntax,ls_Err) <> 1 then
	Clipboard(ls_Err)
end if
	

//Add Not Exists Object
ads_source.Modify(ls_Modify)

//Get DataWindow Properties
of_get_objectpro(ads_target,ads_properties,"datawindow")

//Set Object Properties
return of_set_ObjectPro(ads_source,ads_properties)


//Return new syntax
return ads_source.Describe("DataWindow.Syntax")
end function

public function string of_set_objectpro (ref datastore ads_source, ref datastore ads_properties);Integer i, li_count
String ls_objname,ls_proname, ls_provalue, ls_exp
String ls_rtn,ls_err
n_cst_string lnv_string 

li_count = ads_properties.rowcount()
if li_count <=0 then
	return ""
end if

for i = 1 to li_count
	ls_objname = ads_properties.object.obj_name[i]  
	ls_proname = ads_properties.object.obj_pro[i]  
	ls_provalue = ads_properties.object.obj_value[i]  
	

	if Match(ls_provalue,'^\".*\"$') or Match(ls_provalue,"^\'.*\'$") then	//04/27/2007 By jervis Fixed a defect for APB
		ls_exp = ls_objname + "." + ls_proname +" = " + ls_provalue
	else
		ls_exp =ls_objname + "." + ls_proname +" = '" + ls_provalue + "'"
	end if
	
	ls_rtn = ads_source.modify(ls_exp)
	if ls_rtn <> "" then
		ls_exp =ls_objname + "." + ls_proname +" = " + ls_provalue
		ls_rtn = ads_source.modify(ls_exp)
		//--------------------------- APPEON BEGIN ---------------------------
		//$<  Add > 2007-07-16 By: Scofield
		//$<Reason> After upgrade,the compute column's expression is not right.
		if ls_rtn <> "" then
			ls_exp =ls_objname + "." + ls_proname +' = "' + ls_provalue + '"'
			ls_rtn = ads_source.modify(ls_exp)
		end if
		//---------------------------- APPEON END ----------------------------
	end if
next

return ads_source.Describe("DataWindow.Syntax")
end function

public function integer of_get_objpos (string as_dwsyntax, string as_objtype, string as_objname, ref long al_spos, ref long al_epos);string ls_objSyntax
long ll_pos
string ls_prefix

al_sPos = 0
al_ePos = 0

if as_objtype = '!' or as_objtype = "?" then
	return 0
end if

//Replace DW Syntax
ll_Pos = pos(as_dwsyntax,"name=" + lower(as_Objname))
if ll_pos = 0 then return -1
			
ls_prefix = MID(as_dwsyntax,1,ll_Pos - 1)
al_sPos   = of_pos(ls_prefix,"~r~n" + lower(as_objtype) + "(",len(ls_prefix)) + 2 

al_ePos   = pos(as_dwsyntax,")~r~n",ll_Pos) + 1

return 1
end function

public subroutine of_appeon2_changes (datastore ads_upgrade, boolean ab_upgradeall);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_contract_sqlof_appeon2_changes(ads_upgrade,ab_upgradeall)
// $<arguments> datastore ads_upgrade   //the screen that need upgrade
// $            boolean   ab_upgradeall //true: update all /false: upgrade the screen in ads_upgrade
// $<returns> (none)
// $<description> upgrade Contract screen
// $<description> base on of_appeon2_changes()
//////////////////////////////////////////////////////////////////////
// $<add> 09/21/2007 by: Andy
//////////////////////////////////////////////////////////////////////
integer i,li_num,li_rowcount,li_row
string ls_tab_name[],ls_screen_name[],ls_dw_name[],ls_dataobject[]
string ls_sql,ls_error_create
datastore lds_sql
datastore lds_source,lds_target,lds_properties
Long ll_count , ll_find
boolean lb_update_falg 
long ll_view_id,ll_screen_id
string ls_dataobject1
datetime ldt_modify_date

//<add> 09/21/2007 by: Andy
Long ll_Row,ll_Cnt,ll_n,ll_Find2,ll_i
String ls_Object,ls_Screen

if Not isValid(ads_upgrade) then return 
if ab_upgradeall then 
	ads_upgrade.reset()
else
	if ads_upgrade.Find("ck=1",1,ads_upgrade.RowCount()) < 1 then return
end if
//end of add

lb_update_falg = true
lds_source = create datastore
lds_sql = create datastore
lds_target = create datastore
lds_properties = create datastore

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.18.2007 By: Jack
//$<reason> Fix a defect
//Delete from  ctx_screen where screen_id = 32 and dataobject <> 'd_dm_browse_filter';
update ctx_screen set screen_name = 'Other Contacts' + substring(screen_name,9,100) where screen_id in (14,15,16,17) and substring(screen_name,1,8) = 'Contacts';

lds_source.dataobject = 'd_dm_browse_filter'
lds_source.settransobject(sqlca)
ls_sql = lds_source.Describe("datawindow.syntax")
update ctx_screen set 
	  dw_sql = :ls_sql, 
	  modify_date = getdate(),
	  screen_name = 'Document Manager->Document Tab->Search Criteria',
	  dw_name = 'dw_filter',
	  dataobject = 'd_dm_browse_filter'
where screen_id = 32 and dataobject = 'd_cntx_images';
commit;
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 06/05/2007 By: Jervis
//$<reason> Force update screen 
of_register_screen('d_contract_search',2007-09-01)         //Modify by Jack 07/13/2007
of_register_screen('d_sp_contract_search',2007-09-01)      //Modify by Jack 06/01/2007
of_register_screen('d_contract_det_master',2007-06-01)     //Modify by Jack 06/01/2007
of_register_screen('d_cntx_action_items',2007-09-11) //Modified by alfee 09.11.2007
of_register_screen('d_contract_det_contact_contact_det',2007-04-22)
of_register_screen('d_ctx_schedule_fee_notes',2007-04-22)
of_register_screen('d_contract_group_linked_locations',2007-05-22) //Modify by Jack 05/22/2007
of_register_screen('d_contract_profile_req_questions',2007-04-22)
of_register_screen('d_contract_profile_req2',2007-04-30)
of_register_screen('d_contract_profile_req_existing',2007-04-30)
of_register_screen('d_ctx_schedule_fee_locations',2007-04-30)
of_register_screen('d_dm_doc_ai_detail',2007-08-25) //Add by alfee 08/25/2007
of_register_screen('d_dm_doc_ai_detail_1',2007-08-25) //Add by alfee 08/25/2007
of_appeon_forceupdate_screen()
//---------------------------- APPEON END ----------------------------

lds_properties.dataobject = "d_update_user_datawindow_objlist"
lds_sql.dataobject = 'd_contract_dw_sql_update'
lds_sql.settransobject(sqlca)
lds_sql.retrieve()

if ab_upgradeall then//<add> 09/21/2007 by: Andy 
	ls_tab_name[1] = 'tabpage_search'
	ls_tab_name[2] = 'tabpage_search'
	ls_tab_name[3] = 'tabpage_details'
	ls_tab_name[4] = 'tabpage_details'
	ls_tab_name[5] = 'tabpage_details'
	ls_tab_name[6] = 'tabpage_details'
	ls_tab_name[7] = 'tabpage_details'
	ls_tab_name[8] = 'tabpage_details'
	ls_tab_name[9] = 'tabpage_details'
	ls_tab_name[10] = 'tabpage_details'
	ls_tab_name[11] = 'tabpage_requirements'
	ls_tab_name[12] = 'tabpage_requirements'
	ls_tab_name[13] = 'tabpage_requirements'
	ls_tab_name[14] = 'tabpage_contacts'
	ls_tab_name[15] = 'tabpage_contacts'
	ls_tab_name[16] = 'tabpage_contacts'
	ls_tab_name[17] = 'tabpage_contacts'
	ls_tab_name[18] = 'tabpage_locations'
	ls_tab_name[19] = 'tabpage_locations'
	ls_tab_name[20] = 'tabpage_locations'
	ls_tab_name[21] = 'tabpage_locations'
	ls_tab_name[22] = 'tabpage_orgabizations'
	ls_tab_name[23] = 'tabpage_orgabizations'
	ls_tab_name[24] = 'tabpage_orgabizations'
	ls_tab_name[25] = 'tabpage_orgabizations'
	ls_tab_name[26] = 'tabpage_fee_schedules'
	ls_tab_name[27] = 'tabpage_fee_schedules'
	ls_tab_name[28] = 'tabpage_fee_schedules'
	ls_tab_name[29] = 'tabpage_fee_schedules'
	ls_tab_name[30] = 'tabpage_fee_schedules'
	ls_tab_name[31] = 'tabpage_fee_sched2'
	ls_tab_name[32] = 'tabpage_images'
	ls_tab_name[33] = 'tabpage_action_items'
	ls_tab_name[34] = 'tabpage_qrg'
	ls_tab_name[35] = 'tabpage_qrg'
	ls_tab_name[36] = 'tabpage_qrg'
	ls_tab_name[37] = 'tabpage_qrg'
	ls_tab_name[38] = 'tabpage_qrg'
	ls_tab_name[39] = 'tabpage_qrg'
	ls_tab_name[40] = 'tabpage_qrg'
	ls_tab_name[41] = 'tabpage_qrg'
	ls_tab_name[42] = 'tabpage_action_items'
	ls_tab_name[43] = 'tabpage_details'
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 04.18.2007 By: Jack
	//$<reason> 
	ls_tab_name[44] = 'tabpage_images'
	ls_tab_name[45] = 'tabpage_images'
	ls_tab_name[46] = 'tabpage_images'
	ls_tab_name[47] = 'tabpage_images'
	ls_tab_name[48] = 'tabpage_images'
	ls_tab_name[49] = 'tabpage_images'
	//---------------------------- APPEON END ----------------------------
	
	ls_screen_name[1] = 'Search->Search Criteria'
	ls_screen_name[2] = 'Search->Contract Browse'
	ls_screen_name[3] = 'Details->Contract Detail'
	ls_screen_name[4] = 'Details->Products'
	ls_screen_name[5] = 'Details->Contract Dates'
	ls_screen_name[6] = 'Details->Contracted Company Contact'
	ls_screen_name[7] = 'Details->Our Company Contact'
	ls_screen_name[8] = 'Details->Notes Tab->Notes'
	ls_screen_name[9] = 'Details->Custom Data Tab->Custom Data'
	ls_screen_name[10] = 'Details->Audit Trail Tab->Audit Trail'
	ls_screen_name[11] = 'Requirements->Profile Selection'
	ls_screen_name[12] = 'Requirements->Profile Detail'
	ls_screen_name[13] = 'Requirements->Profile Detail'
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 04.18.2007 By: Jack
	//$<reason> Fix a defect.
	/*
	ls_screen_name[14] = 'Contacts->Contacts List'
	ls_screen_name[15] = 'Contacts->Contract Details'
	ls_screen_name[16] = 'Contacts->Contract Information'
	ls_screen_name[17] = 'Contacts->Contract Notes'
	*/
	ls_screen_name[14] = 'Other Contacts->Contacts List'
	ls_screen_name[15] = 'Other Contacts->Contract Details'
	ls_screen_name[16] = 'Other Contacts->Contract Information'
	ls_screen_name[17] = 'Other Contacts->Contract Notes'
	//---------------------------- APPEON END ----------------------------
	ls_screen_name[18] = 'Locations->Parent Organization'
	ls_screen_name[19] = 'Locations->Group/Location'
	ls_screen_name[20] = 'Locations->Associated Physicians'
	ls_screen_name[21] = 'Locations->Specialties'
	ls_screen_name[22] = 'Organizations->Organization List'
	ls_screen_name[23] = 'Organizations->Address'
	ls_screen_name[24] = 'Organizations->Notes'
	ls_screen_name[25] = 'Organizations->Organization Contacts'
	ls_screen_name[26] = 'Fee Schedules->Browse Tab->Fee Schedules'
	ls_screen_name[27] = 'Fee Schedules->Browse Tab->Fee Schedule Locations'
	ls_screen_name[28] = 'Fee Schedules->Browse Tab->Fees'
	ls_screen_name[29] = 'Fee Schedules->Browse Tab->Providers'
	ls_screen_name[30] = 'Fee Schedules->Notes Tab->User Defined data'
	ls_screen_name[31] = 'Fee Schedule (NM)->Fee Schedule (Non Healthcare)'
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 04.18.2007 By: Jack
	//$<reason> Fix a defect.
	/*
	ls_screen_name[32] = 'Supporting Documents->Browse Tab->Scanned Documents'
	*/
	ls_screen_name[32] = 'Document Manager->Document Tab->Search Criteria'
	
	//---------------------------- APPEON END ----------------------------
	ls_screen_name[33] = 'Action Items->Action Item List'
	ls_screen_name[34] = 'QRG->Select Data Tab->Report Profiles'
	ls_screen_name[35] = 'QRG->Select Data Tab->Basic Information to Include'
	ls_screen_name[36] = 'QRG->Select Data Tab->Contract Contact Information to Include'
	ls_screen_name[37] = 'QRG->Select Data Tab->Precertifications Requirements'
	ls_screen_name[38] = 'QRG->Select Data Tab->Authorizations Requirements'
	ls_screen_name[39] = 'QRG->Select Data Tab->Fee Schedule Data to Include'
	ls_screen_name[40] = 'QRG->Select Data Tab->Organization Types to Include'
	ls_screen_name[41] = 'QRG->Select Data Tab->Requirements to Include'
	ls_screen_name[42] = 'Action Items->Action Item Browse'
	ls_screen_name[43] = 'Details->Linked Contracts Tab->Linked Contracts'
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 04.18.2007 By: Jack
	//$<reason> Fix a defect.
	ls_screen_name[44] = 'Document Manager->Document Tab->Document Browse'
	ls_screen_name[45] = 'Document Manager->Work Flow Tab->Search Criteria'
	ls_screen_name[46] = 'Document Manager->Work Flow Tab->Action Item Browse'
	ls_screen_name[47] = 'Document Manager->Work Flow Tab->Action Item Detail'
	ls_screen_name[48] = 'Document Manager->Audit Trail Tab->Search Criteria'
	ls_screen_name[49] = 'Document Manager->Audit Trail Tab->Document Browse'
	
	//---------------------------- APPEON END ----------------------------
	
	ls_dw_name[1] = 'dw_search'
	ls_dw_name[2] = 'dw_search_det1'
	ls_dw_name[3] = 'dw_1'
	ls_dw_name[4] = 'dw_products'
	ls_dw_name[5] = 'dw_contract_dates'
	ls_dw_name[6] = 'dw_ccc'
	ls_dw_name[7] = 'dw_occ'
	ls_dw_name[8] = 'dw_1'
	ls_dw_name[9] = 'dw_1'
	ls_dw_name[10] = 'dw_1'
	ls_dw_name[11] = 'dw_2'
	ls_dw_name[12] = 'dw_req_det'
	ls_dw_name[13] = 'dw_req_det'
	ls_dw_name[14] = 'dw_search'
	ls_dw_name[15] = 'dw_detail'
	ls_dw_name[16] = 'dw_phone'
	ls_dw_name[17] = 'dw_notes'
	ls_dw_name[18] = 'dw_main'
	ls_dw_name[19] = 'dw_detail'
	ls_dw_name[20] = 'dw_doctors'
	ls_dw_name[21] = 'dw_spec'
	ls_dw_name[22] = 'dw_search'
	ls_dw_name[23] = 'dw_main'
	ls_dw_name[24] = 'dw_notes'
	ls_dw_name[25] = 'dw_contacts'
	ls_dw_name[26] = 'dw_main'
	ls_dw_name[27] = 'dw_locations'
	ls_dw_name[28] = 'dw_fee_schedule'
	ls_dw_name[29] = 'dw_codes'
	ls_dw_name[30] = 'dw_1'
	ls_dw_name[31] = 'dw_fee_nm'
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 04.18.2007 By: Jack
	//$<reason> Fix a defect.
	/*
	ls_dw_name[32] = 'dw_1'
	*/
	ls_dw_name[32] = 'dw_filter'
	//---------------------------- APPEON END ----------------------------
	ls_dw_name[33] = 'dw_1'
	ls_dw_name[34] = 'dw_profile'
	ls_dw_name[35] = 'dw_basic_info'
	ls_dw_name[36] = 'dw_contact_info'
	ls_dw_name[37] = 'dw_precert'
	ls_dw_name[38] = 'dw_auth'
	ls_dw_name[39] = 'dw_1'
	ls_dw_name[40] = 'dw_2'
	ls_dw_name[41] = 'dw_requirements'
	ls_dw_name[42] = 'dw_1'
	ls_dw_name[43] = 'dw_1'
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 04.18.2007 By: Jack
	//$<reason> Fix a defect.
	ls_dw_name[44] = 'dw_browse'
	ls_dw_name[45] = 'dw_filter'
	ls_dw_name[46] = 'dw_browse'
	ls_dw_name[47] = 'dw_detail'
	ls_dw_name[48] = 'dw_filter'
	ls_dw_name[49] = 'dw_browse'
	
	//---------------------------- APPEON END ----------------------------
	
	ls_dataobject[1] = 'd_contract_search'
	ls_dataobject[2] = 'd_sp_contract_search'
	ls_dataobject[3] = 'd_contract_det_master'
	ls_dataobject[4] = 'd_ctx_products'
	ls_dataobject[5] = 'd_contract_det_master_2'
	ls_dataobject[6] = 'd_contract_det_contact_external'
	ls_dataobject[7] = 'd_contract_det_contact_external'
	ls_dataobject[8] = 'd_contract_det_notes'
	ls_dataobject[9] = 'd_contract_det_custom'
	ls_dataobject[10] = 'd_view_audit2_ctx'
	ls_dataobject[11] = 'd_profile_header'
	ls_dataobject[12] = 'd_contract_profile_req2'
	ls_dataobject[13] = 'd_contract_profile_req_existing'
	ls_dataobject[14] = 'd_contract_det_contact_contact'
	ls_dataobject[15] = 'd_contract_det_contact_contact_det'
	ls_dataobject[16] = 'd_contract_det_contact_contact_phone'
	ls_dataobject[17] = 'd_contract_det_contact_contact_notes'
	ls_dataobject[18] = 'd_contract_multi_group_browse'
	ls_dataobject[19] = 'd_contract_group_linked_locations'
	ls_dataobject[20] = 'd_contract_group_practitioners_existing'
	ls_dataobject[21] = 'd_cntx_location_spec'
	ls_dataobject[22] = 'd_org_search2'
	ls_dataobject[23] = 'd_org_tabpg'
	ls_dataobject[24] = 'd_org_notes'
	ls_dataobject[25] = 'd_org_contacts'
	ls_dataobject[26] = 'd_ctx_free_sched_hdr'
	ls_dataobject[27] = 'd_ctx_schedule_fee_locations'
	ls_dataobject[28] = 'd_ctx_schedule_fee_detail'
	ls_dataobject[29] = 'd_ctx_schedule_fee_pracs'
	ls_dataobject[30] = 'd_ctx_schedule_fee_notes'
	ls_dataobject[31] = 'd_contract_fee_sched_nm'
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 04.18.2007 By: Jack
	//$<reason> Fix a defect.
	/*
	ls_dataobject[32] = 'd_cntx_images'
	*/
	ls_dataobject[32] = 'd_dm_browse_filter'
	
	//---------------------------- APPEON END ----------------------------
	ls_dataobject[33] = 'd_cntx_action_items'
	ls_dataobject[34] = 'd_report_hdr'
	ls_dataobject[35] = 'd_qrg_sys_fields'
	ls_dataobject[36] = 'd_qrg_sys_fields'
	ls_dataobject[37] = 'd_profile_codes'
	ls_dataobject[38] = 'd_profile_codes'
	ls_dataobject[39] = 'd_qrg_sys_fields'
	ls_dataobject[40] = 'd_profile_codes'
	ls_dataobject[41] = 'd_contract_profile_req_questions'
	ls_dataobject[42] = 'd_cntx_action_items_browse'
	ls_dataobject[43] = 'd_sp_contract_search'
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 04.18.2007 By: Jack
	//$<reason> Fix a defect.
	ls_dataobject[44] = 'd_dm_doc_tree'
	ls_dataobject[45] = 'd_dm_ai_filter'
	ls_dataobject[46] = 'd_dm_doc_ai_browse'
	ls_dataobject[47] = 'd_dm_doc_ai_detail'
	ls_dataobject[48] = 'd_dm_audit_filter'
	ls_dataobject[49] = 'd_dm_doc_audit_browse'
	//---------------------------- APPEON END ----------------------------
	
	//<add> 09/21/2007 by: Andy
	ll_Cnt = UpperBound(ls_tab_name)
	FOR ll_n = 1 to ll_Cnt
		ll_Row = ads_upgrade.InsertRow(0)
		ads_upgrade.SetItem(ll_Row,"ck",1)//select
		ads_upgrade.SetItem(ll_Row,"tab_name",ls_tab_name[ll_n])
		ads_upgrade.SetItem(ll_Row,"screen_name",ls_screen_name[ll_n])
		ads_upgrade.SetItem(ll_Row,"dw_name",ls_dw_name[ll_n])
		ads_upgrade.SetItem(ll_Row,"dataobject",ls_dataobject[ll_n])
	NEXT
	
end if
//end of add

//modify 09/21/2007 by: Andy
//li_num = UpperBound(ls_tab_name)
li_num = Integer(ads_upgrade.describe("Evaluate('sum(ck)',0)"))
//end of modify

ll_count = lds_sql.rowcount() 
if Not isvalid( w_infodisp ) then open(w_infodisp)
if isvalid(w_infodisp) then w_infodisp.title = 'Update screen of view, Please stand by'
if isvalid(w_infodisp) then w_infodisp.Center = TRUE
if isvalid(w_infodisp) then w_infodisp.st_complete.visible = false
if isvalid(w_infodisp) then w_infodisp.st_3.visible = false
if isvalid(w_infodisp) then w_infodisp.st_information.visible = false
if isvalid(w_infodisp) then w_infodisp.st_1.text = 'Update screen of view, Please stand by!'
if isvalid(w_infodisp) then w_infodisp.wf_set_min_max(1,li_num)

//<modify> 09/21/2007 by: Andy
ll_Find2 = 0
ll_i = 0
ll_Cnt = ads_upgrade.RowCount()

DO WHILE (1=1)
	ll_Find2 = ads_upgrade.Find("ck=1",ll_Find2,ll_Cnt)
	if ll_Find2 < 1 then exit
	ll_i ++
	
	if isvalid(w_infodisp) then 
		w_infodisp.wf_step_pbar(1)
		w_infodisp.st_1.text = 'Modification ' + string(ll_i) + ' of ' + string(li_num)+' Please stand by!'
	end if
	
	ls_Object = ads_upgrade.GetItemString(ll_Find2,"dataobject")
	ls_Screen = ads_upgrade.GetItemString(ll_Find2,"screen_name")
	if IsNull(ls_Object) then ls_Object = ""
	if IsNull(ls_Screen) then ls_Screen = ""
	lds_source.dataobject = ls_Object//ls_dataobject[i]
	lds_source.settransobject(sqlca)

	ll_find = lds_sql.find("dataobject = '" + ls_Object + "'" + " and screen_name = '" + ls_Screen + "'", 1 , ll_count)	
	if ll_find > 0 then	
		if lb_update_falg then	//Update All Screen syntax
			do 
				//Update Screen syntax
				ll_view_id = lds_sql.GetItemNumber(ll_find,"data_view_id")
				ll_screen_id = lds_sql.GetItemNumber(ll_find,"screen_id")
				
				IF appeongetclienttype() = 'PB' then
					ls_sql = f_get_screen_sql(ll_view_id,ll_screen_id,false)  //add false argu - jervis 10.11.2011
				else
					ls_sql = lds_sql.GetItemString(ll_find,"dw_sql")
				end if
				
				lds_target.Create(ls_sql, ls_error_create)
				lds_target.SetTransObject(SQLCA)
				lds_properties.Reset()
				
				//--------------------------- APPEON BEGIN ---------------------------
				//$<modify> 08.04.2007 By: Jervis
				//$<reason> 
				/*
				of_getproperties(lds_target,lds_properties)
				
				ls_sql = of_setproperties(lds_source,lds_properties)
				//<add> 07/03/2007 by: Andy 
				//Add objects
				ls_sql = of_addobjects(lds_source,lds_target)
				//end of add
				*/
				ls_sql = of_update_object(lds_target,lds_source,lds_properties)
				//--------------------------- APPEON END ---------------------------
				
				lds_sql.SetItem(ll_find,"dw_sql",ls_sql)
				//lds_sql.setitem(ll_find,'modify_date',today())	APB Bug,need use datetime convert 08.04.2007
				lds_sql.setitem(ll_find,'modify_date',datetime(today(),now()))
				
				if ll_find = ll_count then exit
				ll_find = lds_sql.find("dataobject = '" + ls_Object + "'" + " and screen_name = '" + ls_Screen + "'", ll_find + 1 , ll_count)	
			loop WHILE (ll_find > 0)
		else
			//update sql when update = 1 and version > number of current version
		end if
		
	Else
		ls_sql = lds_source.Describe("datawindow.syntax")
		li_row = lds_sql.insertrow(0)	
		lds_sql.setitem(li_row,'data_view_id',1001)
		lds_sql.setitem(li_row,'screen_id',ll_i)//i
		lds_sql.setitem(li_row,'tab_name',ads_upgrade.GetItemString(ll_Find2,"tab_name"))//ls_tab_name[i]
		lds_sql.setitem(li_row,'screen_name',ls_Screen)//ls_screen_name[i]
		lds_sql.setitem(li_row,'dw_name',ads_upgrade.GetItemString(ll_Find2,"dw_name"))//ls_dw_name[i]
		lds_sql.setitem(li_row,'dataobject',ls_Object)//ls_dataobject[i]
		lds_sql.setitem(li_row,'dw_sql',ls_sql)
		lds_sql.setitem(li_row,'create_date',datetime(today(),now()))
		lds_sql.setitem(li_row,'modify_date',datetime(today(),now()))
	End if
	
	ll_Find2 ++
	if ll_Find2 > ll_Cnt then exit
LOOP
//end of modify

If lds_sql.update() <> 1 Then
	ii_num++
	If ii_num < 3 Then
		//modify 09/21/2007 by: Andy
		of_appeon2_changes(ads_upgrade,ab_upgradeall)
	End If
End If
ii_num = 1
commit;


//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.27.2007 By: Jack
//$<reason> Fix a defect.
delete from ctx_screen where screen_id = 44;
//---------------------------- APPEON END ----------------------------

//$<add> 11.08.2006 By: Davis
//$<reason> Fix a defect.
insert into ctx_screen(data_view_id,screen_id,tab_name,screen_name,dw_name,dataobject,description,dw_sql,create_date,modify_date)
select d.data_view_id,a.screen_id,a.tab_name,screen_name,dw_name,dataobject,description,dw_sql,create_date,modify_date from ctx_screen a,data_view d
where d.type_c = 'C' AND a.data_view_id = 1001 and d.data_view_id <> 1001
and exists(
select 1 from ctx_screen b
where data_view_id <> 1001
and a.tab_name = b.tab_name
and d.data_view_id = b.data_view_id
)
and not exists(
select 1 from ctx_screen c
where c.data_view_id <> 1001
and d.data_view_id = c.data_view_id
and a.screen_id = c.screen_id
and a.tab_name = c.tab_name
);

destroy lds_sql
destroy lds_source
destroy lds_target
destroy lds_properties

//$<add> 11.08.2006 By: Davis
if isvalid( w_infodisp ) then close(w_infodisp)


end subroutine

on n_cst_contract_sql.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_contract_sql.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ids_temp = create datastore

ids_temp.dataobject = "d_update_user_datawindow_objlist"

inv_logservice = create n_logservice
end event

event destructor;if isvalid(ids_temp) then destroy ids_temp

if isvalid(lds_db_control) then destroy lds_db_control  //07.24.2007 By Jervis

IF isvalid(inv_logservice) THEN	destroy inv_logservice


end event

