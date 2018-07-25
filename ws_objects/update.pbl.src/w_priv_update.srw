$PBExportHeader$w_priv_update.srw
forward
global type w_priv_update from window
end type
type cb_8 from commandbutton within w_priv_update
end type
type cb_7 from commandbutton within w_priv_update
end type
type cb_6 from commandbutton within w_priv_update
end type
type cb_5 from commandbutton within w_priv_update
end type
type cb_report from commandbutton within w_priv_update
end type
type cb_group from commandbutton within w_priv_update
end type
type st_sqlfolder from statictext within w_priv_update
end type
type cb_browse from commandbutton within w_priv_update
end type
type sle_sqlfolder from singlelineedit within w_priv_update
end type
type cb_4 from commandbutton within w_priv_update
end type
type cbx_latest from checkbox within w_priv_update
end type
type st_sql from statictext within w_priv_update
end type
type cb_reset from commandbutton within w_priv_update
end type
type st_1 from statictext within w_priv_update
end type
type cb_2 from commandbutton within w_priv_update
end type
type dw_wizard from datawindow within w_priv_update
end type
type dw_report from datawindow within w_priv_update
end type
type sle_1 from singlelineedit within w_priv_update
end type
type dw_fields from datawindow within w_priv_update
end type
type dw_hosp from datawindow within w_priv_update
end type
type cb_9 from commandbutton within w_priv_update
end type
type dw_whatever from datawindow within w_priv_update
end type
type dw_2 from datawindow within w_priv_update
end type
type cb_3 from commandbutton within w_priv_update
end type
type cb_1 from commandbutton within w_priv_update
end type
type dw_affil from datawindow within w_priv_update
end type
type dw_1 from datawindow within w_priv_update
end type
type dw_primehosp from datawindow within w_priv_update
end type
type dw_screen from datawindow within w_priv_update
end type
type dw_hlink from datawindow within w_priv_update
end type
type gb_1 from groupbox within w_priv_update
end type
type st_update from statictext within w_priv_update
end type
type cb_update from commandbutton within w_priv_update
end type
end forward

global type w_priv_update from window
integer x = 741
integer y = 776
integer width = 2601
integer height = 612
windowtype windowtype = popup!
long backcolor = 33551856
cb_8 cb_8
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_report cb_report
cb_group cb_group
st_sqlfolder st_sqlfolder
cb_browse cb_browse
sle_sqlfolder sle_sqlfolder
cb_4 cb_4
cbx_latest cbx_latest
st_sql st_sql
cb_reset cb_reset
st_1 st_1
cb_2 cb_2
dw_wizard dw_wizard
dw_report dw_report
sle_1 sle_1
dw_fields dw_fields
dw_hosp dw_hosp
cb_9 cb_9
dw_whatever dw_whatever
dw_2 dw_2
cb_3 cb_3
cb_1 cb_1
dw_affil dw_affil
dw_1 dw_1
dw_primehosp dw_primehosp
dw_screen dw_screen
dw_hlink dw_hlink
gb_1 gb_1
st_update st_update
cb_update cb_update
end type
global w_priv_update w_priv_update

type variables
datetime idt_lup
string is_path
string is_parm  //='1' alfee 01.30.2008
end variables

forward prototypes
public function integer of_billing_link_field ()
public function integer of_security ()
public function integer of_addr_det_2_insert ()
public function integer of_affil_sys_tables_fields ()
public function integer of_new_views ()
public function integer of_custom_fields ()
public function integer of_date_fields ()
public function integer of_add_dv_fields (long al_from, long al_to)
public function integer of_security_addv5 ()
public function integer of_attest_quest ()
public function integer of_group_dv_fields ()
public function integer of_question_import (integer ai_ver)
public function integer of_caqh_fields ()
public function integer of_execute (string as_sql)
public function integer of_updates_appeon1 ()
public function integer of_updates_appeon2 ()
public function integer of_new_security ()
public function integer of_old_code (integer ai_ver)
public function integer of_update_reports ()
public function integer of_crawler_mods_v7 ()
public function integer of_adjust_webview_security ()
public function integer of_reference_fax ()
public function integer of_wv_required_template_upgrade ()
public function integer of_wv_required_template_role_rights ()
public function integer of_webview_upgrade ()
public function integer of_npdb_updates_2007 ()
public function long of_download_updatefiles ()
public function long of_update_sql ()
public subroutine of_backupcode ()
public function integer of_ver40_update ()
public function integer of_ver45_update ()
public function integer of_ver50_updates ()
public function integer of_ver55_updates ()
public function integer of_ver60_updates ()
public function integer of_ver70_updates ()
public function integer of_ver80_updates ()
public function integer of_ver91_updates ()
public function integer of_ver_91_updates_bk ()
public function integer of_ver92_updates ()
public function integer of_ver101_updates ()
public function integer of_ver111_updates ()
public function integer of_ver112_updates ()
public function integer of_ver113_updates ()
public function integer of_ver121_updates ()
public function integer of_ver122_updates ()
public function integer of_ver123_updates ()
public function integer of_address_hours_sql ()
public function integer of_ver141_updates ()
public function integer of_ver142_updates ()
public function integer of_ver151_updates ()
public function integer of_ver152_updates ()
public function integer of_ver153_updates ()
public function integer of_ver154_updates ()
public function integer of_ver161_updates ()
end prototypes

public function integer of_billing_link_field ();Long ll_max_field_id
Long ll_max_data_view_obj_id
Long ll_max_data_view_fld_id
Integer li_data_view_id
long ll_cnt

SELECT field_id  
INTO :ll_cnt  
FROM sys_fields  
WHERE field_name = 'billing_address_id';

IF isnull(ll_cnt) or ll_cnt < 1 THEN
	SELECT Max( field_id )  
	INTO :ll_max_field_id  
	FROM sys_fields;
	ll_max_field_id++
	
	INSERT INTO sys_fields 
	VALUES (
	20,
	:ll_max_field_id,
	700,
	'billing_address_id',
	'l',
	5,
	'Billing Address Link',
	'',
	'',
	'',
	'',
	'',
	'N',
	NULL,
	NULL,
	NULL,
	NULL,
	'N',
	'-1',
	NULL,
	NULL,
	NULL,
	NULL,
	0,
	NULL
	);

	IF SQLCA.SQLCODE = -1 THEN
		MessageBox("Error", SQLCA.SQLERRTEXT )
	END IF

else
	return 0
	//ll_max_field_id = ll_cnt
	
END IF


EXECUTE IMMEDIATE "ALTER TABLE app_field_prop ADD billing_address_flag integer NULL";
commit using sqlca;
EXECUTE IMMEDIATE "ALTER TABLE app_sect_temp_field_prop ADD billing_address_flag integer NULL";
commit using sqlca;
EXECUTE IMMEDIATE "ALTER TABLE pd_address ADD billing_address_id numeric( 8,0) NULL";
commit using sqlca;
EXECUTE IMMEDIATE "ALTER TABLE group_practice ADD billing_address_id numeric( 8,0) NULL";
commit using sqlca;
EXECUTE IMMEDIATE "ALTER TABLE net_dev_ids ADD tax_id Char(10) NULL";
commit using sqlca;



SELECT Max( data_view_field_id )  
INTO :ll_max_data_view_fld_id
FROM data_view_fields  ;


SELECT Max( data_view_object_id )  
INTO :ll_max_data_view_obj_id
FROM data_view_screen_objects  ;
ll_max_data_view_obj_id++



DECLARE c_data_views CURSOR FOR  
SELECT data_view.data_view_id  
FROM data_view  ;

OPEN c_data_views;

FETCH c_data_views INTO :li_data_view_id;

DO WHILE SQLCA.SQLCODE = 0
	
	ll_max_data_view_fld_id++	
	
	INSERT INTO data_view_fields
	(data_view_field_id,data_view_id,screen_id,field_id,field_label,
	field_order,display_only,required,data_seperator,seperator_hdr,include_in_browse,
	browse_tab_order,browse_tab_width,field_x,field_y,field_width,field_height,justification,
	sys_table_id,sys_field_id,edit_field_type,field_label_justification,field_label_x,
	field_label_y,field_label_width,visible,font_wieght)
	VALUES (
	:ll_max_data_view_fld_id,
	:li_data_view_id,
	2,
	:ll_max_field_id,
	'Select Address',
	630,
	'N',
	'N',
	'N',
	NULL,
	'N',
	NULL,
	0,
	91,
	3076,
	2351,
	64,
	'0',
	20,
	NULL,
	'E',
	0,
	87,
	3006,
	500,
	'Y',
	NULL);
	
	IF SQLCA.SQLCODE = -1 THEN
		MessageBox("Error", SQLCA.SQLERRTEXT )
	END IF

ll_max_data_view_obj_id++
	INSERT INTO data_view_screen_objects VALUES (
	:ll_max_data_view_obj_id,
	:li_data_view_id,
	2,
	'Billing Address Link',
	2435,
	390,
	55,
	2920,
	0,
	NULL,
	NULL,
	NULL,
	NULL,
	'B',
	NULL);

	IF SQLCA.SQLCODE = -1 THEN
		MessageBox("Error", SQLCA.SQLERRTEXT )
	END IF

	FETCH c_data_views INTO :li_data_view_id;	
	
LOOP

Return 0
end function

public function integer of_security ();integer cnt


//select set_18
//into :cnt
//from icred_settings;
//
//if cnt < 1 then //maha app104005 removed 
	open(w_security_update)
	w_security_update.cb_import.triggerevent(clicked!)
	close(w_security_update)
//end if

return 1
end function

public function integer of_addr_det_2_insert ();string ls_sql
long recid
integer cnt
integer n


select count(screen_id) into :cnt from data_view_screen where screen_id = 31;
if cnt < 1 then
	ls_sql = "INSERT INTO data_view_screen VALUES (	1,	31,	31,	'pd_address_2',	'Y',	NULL,	NULL,	NULL,	NULL,	42,	NULL,	Null,	1);"
	execute immediate :ls_sql using sqlca;//031002 maha
	commit using sqlca;
end if

select count(table_id) into :cnt from sys_tables where table_id = 42;
if cnt < 1 then
ls_sql = "INSERT INTO sys_tables VALUES (	42,	'pd_address_2',	'Additional Address Info',	NULL,	0);"
execute immediate :ls_sql using sqlca;//031002 maha
commit using sqlca;
end if

select count(field_id) into :cnt from sys_fields where table_id = 42;
//messagebox("field count",cnt)
if cnt < 1 then 
	if not FileExists(gs_dir_path + "intellicred\sys_fields_for_addr_det_2.txt") = true then return -1

		//select max(field_id) into :recid from sys_fields;
		
	dw_whatever.dataobject = "d_sys_fields_import"
	dw_whatever.SetTransObject( SQLCA	)	
	dw_whatever.reset()
	cnt = dw_whatever.importfile( gs_dir_path + "intellicred\sys_fields_for_addr_det_2.txt" )
	//	messagebox("import count",cnt)
//		for n = 1 to cnt
//			recid++
//			dw_whatever.setitem(n,"field_id",recid)
//		next
	dw_whatever.update()
	commit using sqlca;
	

		//messagebox("data field count","no sys file")

end if

select count(data_view_field_id) into :cnt from data_view_fields where screen_id = 31;
//messagebox("data field count",cnt)
if cnt < 1 then 
	if not FileExists(gs_dir_path + "intellicred\data_fields_for_addr_det_2.txt") = true then return -1

	select max(data_view_field_id) into :recid from data_view_fields;
	
	dw_whatever.dataobject = "d_data_view_fields_import"
	dw_whatever.SetTransObject( SQLCA	)
	dw_whatever.reset()
	cnt = dw_whatever.importfile( gs_dir_path + "intellicred\data_fields_for_addr_det_2.txt" )
	for n = 1 to cnt
		recid++
		dw_whatever.setitem(n,"data_view_field_id",recid)
	next
	dw_whatever.update()
	commit using sqlca;
		//messagebox("data field count","no data file")
end if

ls_sql = "UPDATE data_view_screen SET table_id_2 = 31 WHERE screen_id = 2 and data_view_id = 1;"
execute immediate :ls_sql using sqlca;//031002 maha
commit using sqlca;



return 1
end function

public function integer of_affil_sys_tables_fields ();string ls_sql

ls_sql = "INSERT INTO sys_tables VALUES (	32,	'pd_affil_dept',	'Affiliation Department',	NULL,	1,null,null);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_tables VALUES (	43,	'pd_affil_stat',	'Affiliation Status',	NULL,	1,null,null);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_tables VALUES (	44,	'pd_affil_staff_cat',	'Affiliation Staff Category',	NULL,	1,null,null);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_tables VALUES (	45,	'pd_affil_staff_leave',	'Affiliation Leave',	NULL,	1,null,null);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
//fields
ls_sql = "INSERT INTO sys_fields VALUES (	32,	11223503,	10,	'rec_id',	'N',	10,	'Rec ID',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;

ls_sql = "INSERT INTO sys_fields VALUES (	32,	11223503,	10,	'rec_id',	'N',	10,	'Rec ID',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	32,	11223504,	20,	'prac_id',	'N',	10,	'Prac ID',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	32,	11223505,	30,	'facility_id',	'N',	10,	'Facility ID',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	32,	11223506,	40,	'department',	'N',	10,	'Department',	NULL,	'C',NULL,	'Department',	'Code',	'Y',	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	32,	11223507,	50,	'rank',	'N',	10,	'Division',	NULL,	'C',	'Y',	'Division',	'Code',	'Y',	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	32,	11223508,	60,	'section',	'N',	10,	'Section',	NULL,	'C',	'Y',	'Section',	'Code',	'Y',	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	43,	100000,10,	'active_status',	'N',	4,	'Active Status',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	43,	100001,	20,	'affil_ended',	'D',	8,	'Affiliation Ended',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	43,	100002,	25,	'affil_ended_reason',	'N',	6,	'Affilation Ended Reason',	NULL,	'C',	'Y',	'Reason for Affiliation Ended',	'Description ',	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	43,	100003,	30,	'application_audit_facility',	'C',	20,	'Application Audit Facility',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	43,	100004,	40,	'apptmnt_end_date',	'D',	20,	'Appointment End Date',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	43,	100005,	50,	'apptmnt_start_date',	'D',	20,	'Appointment Start Date',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	43,	100006,	60,	'apptmnt_type',	'C',	1,	'Appointment Type',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	43,	100007,	70,	'check_date',	'D',	20,	'Check Date',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	43,	100008,	80,	'custom_1',	'C',	30,	'Custom 1',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES  (	43,	100009,	90,	'custom_2',	'C',	30,	'Custom 2',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	43,	100010,	100,	'custom_3',	'C',	30,	'Custom 3',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	43,	100011,	110,	'custom_4',	'C',	30,	'Custom 4',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	43,	100012,	120,	'custom_5',	'C',	30,	'Custom 5',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	43,	100013,	130,	'date_app_audit_completed',	'D',	20,	'App Audit Comp Date',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	43,	100014,	140,	'date_app_rcvd',	'D',	20,	'App Received Date',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	43,	100015,	150,	'date_app_sent',	'D',	20,	'App Sent Date',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	43,	100016,	160,	'date_app_signed',	'D',	20,	'App Signed Date',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	43,	100017,	170,	'date_closed',	'D',	20,	'Completed Date',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	43,	100018,	180,	'date_data_entry_completed',	'D',	20,	'DE Complete Date',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	43,	100019,	190,	'date_invoiced',	'D',	20,	'Date Invoiced',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	43,	100020,	200,	'date_paid',	'D',	20,	'Date Paid',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	43,	100021,	210,'date_rls_form_exp',	'D',	20,	'Release Signed',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	43,	100022,	220,	'date_rqst_rcvd',	'D',	20,	'Request Recieved Date',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	43,	100023,	230,	'date_verif_completed',	'C',	20,	'Verif Comp Date',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	43,	100024,	240,	'fee',	'N',	8,	'Fee',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	43,	100025,	250,	'init_prov_period_from',	'D',	20,	'Prov Period From',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	43,	100026,	260,	'init_prov_period_to',	'D',	20,	'Prov Period To',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	43,	100027,	270,	'inital_appmnt_date',	'D',	20,	'Inital Appointment Date',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	43,	100028,	280,	'parent_facility_id',	'N',	4,	'Parent Facility Id',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	43,	100029,	0,	'rec_id',	'N',	10,	'rec_id',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'N',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	43,	100030,	0,	'prac_id',	'N',	8,	'Prac Id',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'N',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	43,	100031,	310,	'priority',	'C',	1,	'Priority',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	43,	100032,	320,	'priority_user',	'C',	10,	'Assigned User',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	43,	100033,	330,	'seq_no',	'N',	4,	'Seq No',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	43,	100034,	340,	'verifying_facility',	'N',	4,	'Verifying Facility Id',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	44,	100101,	10,	'facility_id',	'N',	4,	'Facility Id',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	44,	100102,	0,	'prac_id',	'N',	8,	'Prac Id',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'N',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	44,	100103,	0,	'rec_id',	'N',	8,	'Rec Id',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'N',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	44,	100104,	0,	'seq_no',	'N',	4,	'Seq No',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'N',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	44,	100105,	50,	'active_status',	'N',	4,	'Active Status',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	44,	100106,	60,	'from_date',	'D',	20,	'From Date',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	44,	100107,	70,	'staff_category',	'N',	8,	'Staff Category',	NULL,	'C',	'Y',	'C',	'B',	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	44,	100108,	80,	'to_date',	'D',	20,	'To Date',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	45,	100110,	10,	'facility_id',	'N',	4,	'Facility Id',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	45,	100111,	0,	'prac_id',	'N',	8,	'Prac Id',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'N',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	45,	100112,	0,	'rec_id',	'N',	8,	'Rec Id',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'N',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	45,	100113,	20,	'seq_no',	'N',	4,	'Seq No',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	45,	100114,	30,	'active_status',	'N',	4,	'Active Status',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	45,	100115,	40,	'from_date',	'D',	20,	'From Date',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	45,	100116,	50,	'leave_of_absence_reason',	'N',	10,	'Leave Reason',	NULL,	'C',	'Y',	'C',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	45,	100117,	60,	'to_date',	'D',	20,	'To Date',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	43,	100035,	27,	'affiliation_status',	'C',	1,	'Affiliation Status',	NULL,	'C',	'Y',	'Affiliation Status',	'Description ',NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;

//\/maha 081202 fs tables lij
ls_sql = "INSERT INTO SYS_TABLES VALUES (	47,	'pd_committee',	'Committee FS',	NULL,	1,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO SYS_TABLES VALUES (	49,	'pd_rank',	'Rank FS',	NULL,	1,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO SYS_TABLES VALUES (	46,	'pd_admin_role',	'Admin Role FS',	NULL,	1,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO SYS_TABLES VALUES (	48,	'pd_other_data',	'Other Data FS',	NULL,	1,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;

ls_sql = "INSERT INTO SYS_FIELDS VALUES (	46,	100237,	0,	'rec_id',	'N',	16,	'Rec Id',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'N',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO SYS_FIELDS VALUES (	46,	100200,	0,	'prac_id',	'N',	16,	'Prac Id',	NULL,	NULL,	NULL,	NULL,NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'N',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO SYS_FIELDS VALUES (	46,	100201,	0,	'facility_id',	'N',	6,	'Facility Id',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'N',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO SYS_FIELDS VALUES (	46,	100202,	1,	'admin_role',	'N',	16,	'Administrative Role',	NULL,	'C',	'Y',	NULL,	'B',	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO SYS_FIELDS VALUES (	46,	100203,	2,	'admin_role_date',	'D',	20,	'Admin Role Data',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO SYS_FIELDS VALUES (	46,	100204,	3,	'active_status',	'N',	5,	'Active Status',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO SYS_FIELDS VALUES (	46,	100205,	4,	'notes',	'C',	255,	'Notes',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO SYS_FIELDS VALUES (	47,	100206,	0,	'rec_id',	'N',	16,	'rec_id',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'N',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO SYS_FIELDS VALUES (	47,	100207,	0,	'prac_id',	'N',	16,	'prac id',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'N',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO SYS_FIELDS VALUES (	47,	100208,	0,	'facility_id',	'N',	5,	'facility_id',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'N',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO SYS_FIELDS VALUES (	47,	100209,	1,	'committee',	'N',	16,	'Committee',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO SYS_FIELDS VALUES (	47,	100210,	2,	'committee_date',	'D',	20,	'Committee Date',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO SYS_FIELDS VALUES (	47,	100211,	3,	'active_status',	'N',	5,	'Active Status',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO SYS_FIELDS VALUES (	48,	100212,	0,	'rec_id',	'N',	16,	'rec id',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'N',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO SYS_FIELDS VALUES (	48,	100213,	0,	'prac_id',	'N',	16,	'prac id',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'N',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO SYS_FIELDS VALUES (	48,	100214,	0,	'facility_id',	'N',	16,	'facility_id',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'N',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO SYS_FIELDS VALUES (	48,	100215,	1,	'corp_comply',	'D',	20,	'Corp Comply',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO SYS_FIELDS VALUES (	48,	100216,	2,	'bylaws_read',	'D',	20,	'Bylaws Read',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO SYS_FIELDS VALUES (	48,	100217,	3,	'orientation',	'D',	20,	'Orientation',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO SYS_FIELDS VALUES (	48,	100218,	4,	'conscience_sedation',	'D',	20,	'Conscience Sedation',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO SYS_FIELDS VALUES (	48,	100219,	5,	'ppd_date',	'D',	20,	'PPD Date',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO SYS_FIELDS VALUES (	48,	100220,	6,	'positive_ppd',	'N',	16,	'Positive PPD',	NULL,	'C',	'Y',	'Yes/No',	'B',	NULL,	NULL,NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO SYS_FIELDS VALUES (	48,	100221,	7,	'npdb',	'D',	20,	'npdb',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO SYS_FIELDS VALUES (	48,	100222,	8,	'active_status','N',	5,	'Active Status',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO SYS_FIELDS VALUES (	48,	100223,	9,	'physical',	'D',	20,	'physical',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO SYS_FIELDS VALUES (	48,	100224,	10,	'lij_beeper',	'N',	16,	'LIJ Beeper',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO SYS_FIELDS VALUES (	49,	100225,	0,	'rec_id',	'N',	16,	'rec id',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'N',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO SYS_FIELDS VALUES (	49,	100226,	0,	'prac_id',	'N',	16,	'prac id',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'N',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO SYS_FIELDS VALUES (	49,	100227,	0,	'facility_id',	'N',	5,	'facility_id',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'N',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO SYS_FIELDS VALUES (	49,	100228,	1,	'rank',	'N',	16,	'Rank',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO SYS_FIELDS VALUES (	49,	100229,	2,	'rank_date',	'D',	20,	'Rank Date',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO SYS_FIELDS VALUES (	49,	100230,	3,	'notes',	'C',	255,	'Notes',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO SYS_FIELDS VALUES (	49,	100231,	4,	'active_status',	'N',	5,	'Active Status',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO SYS_FIELDS VALUES (	49,	100232,	5,	'cust_1',	'C',	50,	'cust_1',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO SYS_FIELDS VALUES (	49,	100233,	6,	'cust_2',	'C',	50,	'cust_2',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO SYS_FIELDS VALUES (	49,	100234,	7,	'cust_3',	'C',	50,	'cust_3',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO SYS_FIELDS VALUES (	49,	100235,	8,	'cust_4',	'C',	50,	'cust_4',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO SYS_FIELDS VALUES (	49,	100236,	9,	'cust_5',	'C',	50,	'cust_5',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
//\maha


//jad 11/29/02
ls_sql = "INSERT INTO data_view_screen VALUES (	1,	33,	22,	'Staff Category',	'Y',	NULL,	NULL,	NULL,	NULL,	44,	NULL,	NULL,	NULL,	'Staff Category');"
execute immediate :ls_sql using sqlca;
commit using sqlca;

ls_sql = "INSERT INTO data_view_fields VALUES (	30000,	1,	33,	100107,	'staff_category',	10,	'N',	'N',	NULL,	NULL,	'Y',	NULL,	NULL,	10,	100,	300,	64,	'0',	NULL,	NULL,	'E',	0,	10,	10,	500,	'Y',	NULL,	0,	0,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;
commit using sqlca;

ls_sql = "update icred_settings set set_21 = 1;"
execute immediate :ls_sql using sqlca;
commit using sqlca;






return 1


end function

public function integer of_new_views ();string ls_sql
integer li_set

ls_sql = "create view v_primary_specialty as " &  
+	"SELECT pd_board_specialty.rec_id,   " &
+    "     pd_board_specialty.prac_id,   "&
+    "     pd_board_specialty.specialty specialty_id,   "&
+    "     code_lookup_a.code specialty_code,   "&
+    "     code_lookup_a.description specialty_name, "&  
+   "      address_lookup.code board_code,  "&
+   "      pd_board_specialty.board_code board_code_id,  "& 
+   "      address_lookup.entity_name board_name,   "&
+   "      pd_board_specialty.eligible_until,   "&
+   "      pd_board_specialty.initial_certification, "&  
 +  "      pd_board_specialty.last_recertification,   "&
+   "      pd_board_specialty.certification_expires,   "&
+   "      pd_board_specialty.certification_number,   "&
+   "      pd_board_specialty.required_year_completion,  "&
+   "      pd_board_specialty.cust_1, "&
+   "      pd_board_specialty.cust_2, "&
+   "      pd_board_specialty.cust_3, "&
+   "      pd_board_specialty.cust_4, "&
+   "      pd_board_specialty.cust_5,  "&
+   "      code_lookup_b.description exam_taken,  "&  
+    "     code_lookup_c.description active_process, "&   
+   "      code_lookup_d.description ever_failed,   "&
+  "       code_lookup_e.description specialty_order  "&
+ "   FROM  pd_board_specialty left outer join address_lookup on (pd_board_specialty.board_code = address_lookup.lookup_code)   " &  
+ "              left outer join  code_lookup code_lookup_b on (pd_board_specialty.exam_taken = code_lookup_b.lookup_code) "&
+"               left outer join  code_lookup code_lookup_c on (pd_board_specialty.active_cert_process = code_lookup_c.lookup_code) "&
+"               left outer join  code_lookup code_lookup_d on  (pd_board_specialty.ever_failed_cert = code_lookup_d.lookup_code) ,"&
+"	 code_lookup code_lookup_a, "&  
+	" code_lookup code_lookup_e  "&
+  " WHERE ( pd_board_specialty.specialty = code_lookup_a.lookup_code ) and "&
+	"(pd_board_specialty.specialty_order = code_lookup_e.lookup_code) and "&
+"	(code_lookup_e.code = 'Primary');"
//------------------- APPEON BEGIN -------------------
//$<Delete> Stephen 06.20.2012
//$<reason> V12.2 SQL Server 2008 Support
/*
+ "   FROM  pd_board_specialty,  "&
+"	  address_lookup,	"&
+"	 code_lookup code_lookup_a, "&  
+ "	 code_lookup code_lookup_b, "&
+ "	 code_lookup code_lookup_c,   "& 
+  "       code_lookup code_lookup_d,   "&
+	" code_lookup code_lookup_e  "&
+  " WHERE ( pd_board_specialty.specialty = code_lookup_a.lookup_code ) and "&
+	"(pd_board_specialty.board_code *= address_lookup.lookup_code) and "&
+"	(pd_board_specialty.exam_taken *= code_lookup_b.lookup_code) and "&
+	"(pd_board_specialty.active_cert_process *= code_lookup_c.lookup_code) and "&
+	"(pd_board_specialty.ever_failed_cert *= code_lookup_d.lookup_code) and "&
+	"(pd_board_specialty.specialty_order = code_lookup_e.lookup_code) and "&
+"	(code_lookup_e.code = 'Primary');"
*/
//------------------- APPEON END -------------------
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//092904 maha
commit using sqlca;


ls_sql = "create view v_affil_staff_cat_active "&
+"		as select "&
 +"	pd_affil_staff_cat.rec_id,   "&
+"		pd_affil_staff_cat.prac_id, "&  
+"		pd_affil_staff_cat.facility_id, "&  
+"		facility.facility_name,   "&
+"		pd_affil_staff_cat.seq_no,  "& 
+"		code_lookup.code staff_cat_code, "&  
+"		code_lookup.description staff_cat, "&  
+"		pd_affil_staff_cat.from_date,   "&
+"		pd_affil_staff_cat.to_date,   "&
+"		pd_affil_staff_cat.active_status,  "&
+"		pd_affil_staff_cat.requested  "&
+" FROM pd_affil_staff_cat,  "&
+"		code_lookup,      "&
+"		facility  "&
+"WHERE ( pd_affil_staff_cat.facility_id = facility.facility_id ) and  "&
+"		( pd_affil_staff_cat.staff_category = code_lookup.lookup_code) and  "&
+" 		( pd_affil_staff_cat.requested = 1) and "&
+"		( pd_affil_staff_cat.active_status in (1,4))  ; "
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//092904 maha
commit using sqlca;



return 1
end function

public function integer of_custom_fields ();//created maha app080905

//custom field modifications

string ls_sql

ls_sql = 'ALTER TABLE "pd_acedemic_appointments" MODIFY	"cust_1"        		varchar(150) NULL,MODIFY	"cust_2"        		varchar(150) NULL,MODIFY	"cust_3"        		varchar(150) NULL,MODIFY	"cust_4"        		varchar(150) NULL,MODIFY	"cust_5"        		varchar(150) NULL,ADD	"cust_6"			varchar(150) NULL,ADD	"cust_7"			varchar(150) NULL,ADD	"cust_8"			varchar(150) NULL,ADD	"cust_9"			varchar(150) NULL,ADD	"cust_10"		varchar(150) NULL,ADD	"cust_d1"		timestamp NULL,ADD	"cust_d2"		timestamp NULL;'
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;
ls_sql = 'ALTER TABLE "pd_address" MODIFY	"cust_1"        		varchar(150) NULL,MODIFY	"cust_2"        		varchar(150) NULL,MODIFY	"cust_3"        		varchar(150) NULL,MODIFY	"cust_4"        		varchar(150) NULL,MODIFY	"cust_5"        		varchar(150) NULL,MODIFY	"cust_6"			varchar(150) NULL,ADD	"cust_7"			varchar(150) NULL,ADD	"cust_8"			varchar(150) NULL,ADD	"cust_9"			varchar(150) NULL,ADD	"cust_10"		varchar(150) NULL,ADD	"cust_d1"		timestamp NULL,ADD	"cust_d2"		timestamp NULL;'
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;
ls_sql = 'ALTER TABLE "pd_basic" MODIFY	"cust_1"        		varchar(150) NULL,MODIFY	"cust_2"        		varchar(150) NULL,MODIFY	"cust_3"        		varchar(150) NULL,MODIFY	"cust_4"        		varchar(150) NULL,MODIFY	"cust_5"        		varchar(150) NULL,MODIFY	"cust_6"        		varchar(150) NULL,MODIFY	"cust_7"        		varchar(150) NULL,MODIFY	"cust_8"        		varchar(150) NULL,MODIFY	"cust_9"        		varchar(150) NULL,MODIFY	"cust_10"       		varchar(150) NULL,ADD	"cust_11"       		varchar(150) NULL,ADD	"cust_12"       		varchar(150) NULL,ADD	"cust_13"       		varchar(150) NULL,ADD	"cust_14"       		varchar(150) NULL,ADD	"cust_15"       		varchar(150) NULL,ADD	"cust_d1"		timestamp NULL,ADD	"cust_d2"		timestamp NULL;'
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;
ls_sql = 'ALTER TABLE "pd_board_specialty" MODIFY	"cust_1"        		varchar(150) NULL,MODIFY	"cust_2"        		varchar(150) NULL,MODIFY	"cust_3"        		varchar(150) NULL,MODIFY	"cust_4"        		varchar(150) NULL,MODIFY	"cust_5"        		varchar(150) NULL,ADD	"cust_6"			varchar(150) NULL,ADD	"cust_7"			varchar(150) NULL,ADD	"cust_8"			varchar(150) NULL,ADD	"cust_9"			varchar(150) NULL,ADD	"cust_10"		varchar(150) NULL,ADD	"cust_d1"		timestamp NULL,ADD	"cust_d2"		timestamp NULL;'
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;
ls_sql = 'ALTER TABLE "pd_claims" MODIFY	"cust_1"        		varchar(150) NULL,MODIFY	"cust_2"        		varchar(150) NULL,MODIFY	"cust_3"        		varchar(150) NULL,MODIFY	"cust_4"        		varchar(150) NULL,MODIFY	"cust_5"        		varchar(150) NULL,ADD	"cust_6"			varchar(150) NULL,ADD	"cust_7"			varchar(150) NULL,ADD	"cust_8"			varchar(150) NULL,ADD	"cust_9"			varchar(150) NULL,ADD	"cust_10"		varchar(150) NULL,ADD	"cust_d1"		timestamp NULL,ADD	"cust_d2"		timestamp NULL;'
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;
ls_sql = 'ALTER TABLE "pd_clinical_specialties" MODIFY	"cust_1"        		varchar(150) NULL,MODIFY	"cust_2"        		varchar(150) NULL,MODIFY	"cust_3"        		varchar(150) NULL,MODIFY	"cust_4"        		varchar(150) NULL,MODIFY	"cust_5"        		varchar(150) NULL,ADD	"cust_6"			varchar(150) NULL,ADD	"cust_7"			varchar(150) NULL,ADD	"cust_8"			varchar(150) NULL,ADD	"cust_9"			varchar(150) NULL,ADD	"cust_10"		varchar(150) NULL,ADD	"cust_d1"		timestamp NULL,ADD	"cust_d2"		timestamp NULL;'
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;
ls_sql = 'ALTER TABLE "pd_contract" MODIFY	"cust_1"        		varchar(150) NULL,MODIFY	"cust_2"        		varchar(150) NULL,MODIFY	"cust_3"        		varchar(150) NULL,MODIFY	"cust_4"        		varchar(150) NULL,MODIFY	"cust_5"        		varchar(150) NULL, ADD	"cust_6"			varchar(150) NULL,ADD	"cust_7"			varchar(150) NULL,ADD	"cust_8"			varchar(150) NULL,ADD	"cust_9"			varchar(150) NULL,ADD	"cust_10"		varchar(150) NULL,ADD	"cust_d1"		timestamp NULL,ADD	"cust_d2"		timestamp NULL;'
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;
ls_sql = 'ALTER TABLE "pd_cpr_certifiation" MODIFY	"cust_1"        		varchar(150) NULL,MODIFY	"cust_2"        		varchar(150) NULL,MODIFY	"cust_3"        		varchar(150) NULL,MODIFY	"cust_4"        		varchar(150) NULL,MODIFY	"cust_5"        		varchar(150) NULL,ADD	"cust_6"			varchar(150) NULL,ADD	"cust_7"			varchar(150) NULL,ADD	"cust_8"			varchar(150) NULL,ADD	"cust_9"			varchar(150) NULL,ADD	"cust_10"		varchar(150) NULL,ADD	"cust_d1"		timestamp NULL,ADD	"cust_d2"		timestamp NULL;'
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;
ls_sql = 'ALTER TABLE "pd_custom_1" MODIFY	"custom_1"      		varchar(150) NULL,MODIFY	"custom_2"      		varchar(150) NULL,MODIFY	"custom_3"      		varchar(150) NULL,MODIFY	"custom_4"      		varchar(150) NULL,MODIFY	"custom_5"      		varchar(150) NULL,MODIFY	"custom_6"      		varchar(150) NULL,MODIFY	"custom_7"      		varchar(150) NULL,MODIFY	"custom_8"      		varchar(150) NULL,MODIFY	"custom_9"      		timestamp NULL,MODIFY	"custom_10"     		timestamp NULL,ADD	"custom_11"     		varchar(150) NULL,ADD	"custom_12"     		varchar(150) NULL,ADD	"custom_13"     		varchar(150) NULL,ADD	"custom_14"     		varchar(150) NULL,ADD	"custom_15"     		varchar(150) NULL,ADD	"custom_d1"     		timestamp NULL,ADD	"custom_d2"     		timestamp NULL;'
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;
ls_sql = 'ALTER TABLE "pd_custom_2" MODIFY	"custom_1"      		varchar(150) NULL,MODIFY	"custom_2"      		varchar(150) NULL,MODIFY	"custom_3"      		varchar(150) NULL,MODIFY	"custom_4"      		varchar(150) NULL,MODIFY	"custom_5"      		varchar(150) NULL,MODIFY	"custom_6"      		varchar(150) NULL,MODIFY	"custom_7"      		varchar(150) NULL,MODIFY	"custom_8"      		varchar(150) NULL,MODIFY	"custom_9"      		timestamp NULL,MODIFY	"custom_10"     		timestamp NULL,ADD	"custom_11"     		varchar(150) NULL,ADD	"custom_12"     		varchar(150) NULL,ADD	"custom_13"     		varchar(150) NULL,ADD	"custom_14"     		varchar(150) NULL,ADD	"custom_15"     		varchar(150) NULL,ADD	"custom_d1"     		timestamp NULL,ADD	"custom_d2"     		timestamp NULL;'
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;
ls_sql = 'ALTER TABLE "pd_custom_3" MODIFY	"custom_1"      		varchar(150) NULL,MODIFY	"custom_2"      		varchar(150) NULL,MODIFY	"custom_3"      		varchar(150) NULL,MODIFY	"custom_4"      		varchar(150) NULL,MODIFY	"custom_5"      		varchar(150) NULL,MODIFY	"custom_6"      		varchar(150) NULL,MODIFY	"custom_7"      		varchar(150) NULL,MODIFY	"custom_8"      		varchar(150) NULL,MODIFY	"custom_9"      		timestamp NULL,MODIFY	"custom_10"     		timestamp NULL,ADD	"custom_11"     		varchar(150) NULL,ADD	"custom_12"     		varchar(150) NULL,ADD	"custom_13"     		varchar(150) NULL,ADD	"custom_14"     		varchar(150) NULL,ADD	"custom_15"     		varchar(150) NULL,ADD	"custom_d1"     		timestamp NULL,ADD	"custom_d2"     		timestamp NULL;'
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;
ls_sql = 'ALTER TABLE "pd_dea_state_csr" MODIFY	"cust_1"        		varchar(150) NULL,MODIFY	"cust_2"        		varchar(150) NULL,MODIFY	"cust_3"        		varchar(150) NULL,MODIFY	"cust_4"        		varchar(150) NULL,MODIFY	"cust_5"        		varchar(150) NULL,ADD	"cust_6"			varchar(150) NULL,ADD	"cust_7"			varchar(150) NULL,ADD	"cust_8"			varchar(150) NULL,ADD	"cust_9"			varchar(150) NULL,ADD	"cust_10"		varchar(150) NULL,ADD	"cust_d1"		timestamp NULL,ADD	"cust_d2"		timestamp NULL;'
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;
ls_sql = 'ALTER TABLE "pd_ecfmg" MODIFY	"cust_1"        		varchar(150) NULL,MODIFY	"cust_2"        		varchar(150) NULL,MODIFY	"cust_3"        		varchar(150) NULL,MODIFY	"cust_4"        		varchar(150) NULL,MODIFY	"cust_5"        		varchar(150) NULL,ADD	"cust_6"			varchar(150) NULL,ADD	"cust_7"			varchar(150) NULL,ADD	"cust_8"			varchar(150) NULL,ADD	"cust_9"			varchar(150) NULL,ADD	"cust_10"		varchar(150) NULL,ADD	"cust_d1"		timestamp NULL,ADD	"cust_d2"		timestamp NULL;'
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;
ls_sql = 'ALTER TABLE "pd_education" MODIFY	"cust_1"        		varchar(150) NULL,MODIFY	"cust_2"        		varchar(150) NULL,MODIFY	"cust_3"        		varchar(150) NULL,MODIFY	"cust_4"        		varchar(150) NULL,MODIFY	"cust_5"        		varchar(150) NULL,ADD	"cust_6"			varchar(150) NULL,ADD	"cust_7"			varchar(150) NULL,ADD	"cust_8"			varchar(150) NULL,ADD	"cust_9"			varchar(150) NULL,ADD	"cust_10"		varchar(150) NULL,ADD	"cust_d1"		timestamp NULL,ADD	"cust_d2"		timestamp NULL;'
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;
ls_sql = 'ALTER TABLE "pd_group_providers" MODIFY	"custom_1"      		varchar(150) NULL,MODIFY	"custom_2"      		varchar(150) NULL,MODIFY	"custom_3"      		varchar(150) NULL,MODIFY	"custom_4"      		varchar(150) NULL,MODIFY	"custom_5"      		varchar(150) NULL,ADD	"custom_6"		varchar(150) NULL,ADD	"custom_7"		varchar(150) NULL,ADD	"custom_8"		varchar(150) NULL,ADD	"custom_9"		varchar(150) NULL,ADD	"custom_10"		varchar(150) NULL,ADD	"custom_d1"		timestamp NULL,ADD	"custom_d2"		timestamp NULL;'
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;
ls_sql = 'ALTER TABLE "pd_hosp_affil" MODIFY	"cust_1"        		varchar(150) NULL,MODIFY	"cust_2"        		varchar(150) NULL,MODIFY	"cust_3"        		varchar(150) NULL,MODIFY	"cust_4"        		varchar(150) NULL,MODIFY	"cust_5"        		varchar(150) NULL,ADD	"cust_6"			varchar(150) NULL,ADD	"cust_7"			varchar(150) NULL,ADD	"cust_8"			varchar(150) NULL,ADD	"cust_9"			varchar(150) NULL,ADD	"cust_10"		varchar(150) NULL,ADD	"cust_d1"		timestamp NULL,ADD	"cust_d2"		timestamp NULL;'
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;
ls_sql = 'ALTER TABLE "pd_insurance" MODIFY	"cust_1"        		varchar(150) NULL,MODIFY	"cust_2"        		varchar(150) NULL,MODIFY	"cust_3"        		varchar(150) NULL,MODIFY	"cust_4"        		varchar(150) NULL,MODIFY	"cust_5"        		varchar(150) NULL,ADD	"cust_6"			varchar(150) NULL,ADD	"cust_7"			varchar(150) NULL,ADD	"cust_8"			varchar(150) NULL,ADD	"cust_9"			varchar(150) NULL,ADD	"cust_10"		varchar(150) NULL,ADD	"cust_d1"		timestamp NULL,ADD	"cust_d2"		timestamp NULL;'
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;
ls_sql = 'ALTER TABLE "pd_languages" MODIFY	"cust_1"        		varchar(150) NULL,MODIFY	"cust_2"        		varchar(150) NULL,MODIFY	"cust_3"        		varchar(150) NULL,MODIFY	"cust_4"        		varchar(150) NULL,MODIFY	"cust_5"        		varchar(150) NULL,ADD	"cust_6"			varchar(150) NULL,ADD	"cust_7"			varchar(150) NULL,ADD	"cust_8"			varchar(150) NULL,ADD	"cust_9"			varchar(150) NULL,ADD	"cust_10"		varchar(150) NULL,ADD	"cust_d1"		timestamp NULL,ADD	"cust_d2"		timestamp NULL;'
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;
ls_sql = 'ALTER TABLE "pd_license" MODIFY	"cust_1"        		varchar(150) NULL,MODIFY	"cust_2"        		varchar(150) NULL,MODIFY	"cust_3"        		varchar(150) NULL,MODIFY	"cust_4"        		varchar(150) NULL,MODIFY	"cust_5"        		varchar(150) NULL,ADD	"cust_6"			varchar(150) NULL,ADD	"cust_7"			varchar(150) NULL,ADD	"cust_8"			varchar(150) NULL,ADD	"cust_9"			varchar(150) NULL,ADD	"cust_10"		varchar(150) NULL,ADD	"cust_d1"		timestamp NULL,ADD	"cust_d2"		timestamp NULL;'
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;
ls_sql = 'ALTER TABLE "pd_other_affill" MODIFY	"cust_1"        		varchar(150) NULL,MODIFY	"cust_2"        		varchar(150) NULL,MODIFY	"cust_3"        		varchar(150) NULL,MODIFY	"cust_4"        		varchar(150) NULL,MODIFY	"cust_5"        		varchar(150) NULL,ADD	"cust_6"			varchar(150) NULL,ADD	"cust_7"			varchar(150) NULL,ADD	"cust_8"			varchar(150) NULL,ADD	"cust_9"			varchar(150) NULL,ADD	"cust_10"		varchar(150) NULL,ADD	"cust_d1"		timestamp NULL,ADD	"cust_d2"		timestamp NULL;'
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;
ls_sql = 'ALTER TABLE "pd_other_ids" MODIFY	"cust_1"        		varchar(150) NULL,MODIFY	"cust_2"        		varchar(150) NULL,MODIFY	"cust_3"        		varchar(150) NULL,MODIFY	"cust_4"        		varchar(150) NULL,MODIFY	"cust_5"        		varchar(150) NULL,ADD	"cust_6"			varchar(150) NULL,ADD	"cust_7"			varchar(150) NULL,ADD	"cust_8"			varchar(150) NULL,ADD	"cust_9"			varchar(150) NULL,ADD	"cust_10"		varchar(150) NULL,ADD	"cust_d1"		timestamp NULL,ADD	"cust_d2"		timestamp NULL;'
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;
ls_sql = 'ALTER TABLE "pd_postgrad_train" MODIFY	"cust_1"        		varchar(150) NULL,MODIFY	"cust_2"        		varchar(150) NULL,MODIFY	"cust_3"        		varchar(150) NULL,MODIFY	"cust_4"        		varchar(150) NULL,MODIFY	"cust_5"        		varchar(150) NULL,ADD	"cust_6"			varchar(150) NULL,ADD	"cust_7"			varchar(150) NULL,ADD	"cust_8"			varchar(150) NULL,ADD	"cust_9"			varchar(150) NULL,ADD	"cust_10"		varchar(150) NULL,ADD	"cust_d1"		timestamp NULL,ADD	"cust_d2"		timestamp NULL;'
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;
ls_sql = 'ALTER TABLE "pd_prof_assoc" MODIFY	"cust_1"        		varchar(150) NULL,MODIFY	"cust_2"        		varchar(150) NULL,MODIFY	"cust_3"        		varchar(150) NULL,MODIFY	"cust_4"        		varchar(150) NULL,MODIFY	"cust_5"        		varchar(150) NULL,ADD	"cust_6"			varchar(150) NULL,ADD	"cust_7"			varchar(150) NULL,ADD	"cust_8"			varchar(150) NULL,ADD	"cust_9"			varchar(150) NULL,ADD	"cust_10"		varchar(150) NULL,ADD	"cust_d1"		timestamp NULL,ADD	"cust_d2"		timestamp NULL;'
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;
ls_sql = 'ALTER TABLE "pd_prof_experience" MODIFY	"cust_1"        		varchar(150) NULL,MODIFY	"cust_2"        		varchar(150) NULL,MODIFY	"cust_3"        		varchar(150) NULL,MODIFY	"cust_4"        		varchar(150) NULL,MODIFY	"cust_5"        		varchar(150) NULL,ADD	"cust_6"			varchar(150) NULL,ADD	"cust_7"			varchar(150) NULL,ADD	"cust_8"			varchar(150) NULL,ADD	"cust_9"			varchar(150) NULL,ADD	"cust_10"		varchar(150) NULL,ADD	"cust_d1"		timestamp NULL,ADD	"cust_d2"		timestamp NULL;'
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;
ls_sql = 'ALTER TABLE "pd_references" MODIFY	"cust_1"        		varchar(150) NULL,MODIFY	"cust_2"        		varchar(150) NULL,MODIFY	"cust_3"        		varchar(150) NULL,MODIFY	"cust_4"        		varchar(150) NULL,MODIFY	"cust_5"        		varchar(150) NULL,ADD	"cust_6"			varchar(150) NULL,ADD	"cust_7"			varchar(150) NULL,ADD	"cust_8"			varchar(150) NULL,ADD	"cust_9"			varchar(150) NULL,ADD	"cust_10"		varchar(150) NULL,ADD	"cust_d1"		timestamp NULL,ADD	"cust_d2"		timestamp NULL;'
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;
ls_sql = 'ALTER TABLE "pd_sanctions" MODIFY	"cust_1"        		varchar(150) NULL,MODIFY	"cust_2"        		varchar(150) NULL,MODIFY	"cust_3"        		varchar(150) NULL,MODIFY	"cust_4"        		varchar(150) NULL,MODIFY	"cust_5"        		varchar(150) NULL,ADD	"cust_6"			varchar(150) NULL,ADD	"cust_7"			varchar(150) NULL,ADD	"cust_8"			varchar(150) NULL,ADD	"cust_9"			varchar(150) NULL,ADD	"cust_10"		varchar(150) NULL,ADD	"cust_d1"		timestamp NULL,ADD	"cust_d2"		timestamp NULL;'
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;
ls_sql = 'ALTER TABLE "pd_special_certs" MODIFY	"cust_1"        		varchar(150) NULL,MODIFY	"cust_2"        		varchar(150) NULL,MODIFY	"cust_3"        		varchar(150) NULL,MODIFY	"cust_4"        		varchar(150) NULL,MODIFY	"cust_5"        		varchar(150) NULL,ADD	"cust_6"			varchar(150) NULL,ADD	"cust_7"			varchar(150) NULL,ADD	"cust_8"			varchar(150) NULL,ADD	"cust_9"			varchar(150) NULL,ADD	"cust_10"		varchar(150) NULL,ADD	"cust_d1"		timestamp NULL,ADD	"cust_d2"		timestamp NULL;'
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;
ls_sql = 'ALTER TABLE "pd_training" MODIFY	"cust_1"        		varchar(150) NULL,MODIFY	"cust_2"        		varchar(150) NULL,MODIFY	"cust_3"        		varchar(150) NULL,MODIFY	"cust_4"        		varchar(150) NULL,MODIFY	"cust_5"        		varchar(150) NULL,ADD	"cust_6"			varchar(150) NULL,ADD	"cust_7"			varchar(150) NULL,ADD	"cust_8"			varchar(150) NULL,ADD	"cust_9"			varchar(150) NULL,ADD	"cust_10"		varchar(150) NULL,ADD	"cust_d1"		timestamp NULL,ADD	"cust_d2"		timestamp NULL;'
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;
//sysfield data


ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (1,200000,301,'mm/dd/yyyy','cust_6','Custom 6',30,'C',25) ; "
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (1,200001,311,'mm/dd/yyyy','cust_7','Custom 7',30,'C',25) ; "
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (1,200002,321,'mm/dd/yyyy','cust_8','Custom 8',30,'C',25) ; "
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (1,200003,331,'mm/dd/yyyy','cust_9','Custom 9',30,'C',25) ; "
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (1,200004,341,'mm/dd/yyyy','cust_10','Custom 10',30,'C',25) ; "
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (1,200005,351,'mm/dd/yyyy','cust_d1','Custom Date 1',10,'D',10) ; "
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (1,200006,361,'mm/dd/yyyy','cust_d2','Custom Date 2',10,'D',10) ;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
//address
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (20,200007,301,'mm/dd/yyyy','cust_6','Custom 6',30,'C',25) ; "
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (20,200008,311,'mm/dd/yyyy','cust_7','Custom 7',30,'C',25) ; "
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (20,200009,321,'mm/dd/yyyy','cust_8','Custom 8',30,'C',25) ; "
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (20,200010,331,'mm/dd/yyyy','cust_9','Custom 9',30,'C',25) ; "
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (20,200011,341,'mm/dd/yyyy','cust_10','Custom 10',30,'C',25) ; "
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (20,200012,351,'mm/dd/yyyy','cust_d1','Custom Date 1',10,'D',10) ;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (20,200013,361,'mm/dd/yyyy','cust_d2','Custom Date 2',10,'D',10) ;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
//basic
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (25,200014,301,'mm/dd/yyyy','cust_11','Custom 11',30,'C',25) ; "
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (25,200015,311,'mm/dd/yyyy','cust_12','Custom 12',30,'C',25) ; "
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (25,200016,321,'mm/dd/yyyy','cust_13','Custom 13',30,'C',25) ; "
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (25,200017,331,'mm/dd/yyyy','cust_14','Custom 14',30,'C',25) ; "
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (25,200018,341,'mm/dd/yyyy','cust_15','Custom 15',30,'C',25) ; "
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (25,200019,351,'mm/dd/yyyy','cust_d1','Custom Date 1',10,'D',10) ;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (25,200020,361,'mm/dd/yyyy','cust_d2','Custom Date 2',10,'D',10) ;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
//board/spec
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (2,200021,301,'mm/dd/yyyy','cust_6','Custom 6',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (2,200022,311,'mm/dd/yyyy','cust_7','Custom 7',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (2,200023,321,'mm/dd/yyyy','cust_8','Custom 8',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (2,200024,331,'mm/dd/yyyy','cust_9','Custom 9',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (2,200025,341,'mm/dd/yyyy','cust_10','Custom 10',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (2,200026,351,'mm/dd/yyyy','cust_d1','Custom Date 1',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (2,200027,361,'mm/dd/yyyy','cust_d2','Custom Date 2',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
//claims
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (24,200028,301,'mm/dd/yyyy','cust_6','Custom 6',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (24,200029,311,'mm/dd/yyyy','cust_7','Custom 7',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (24,200030,321,'mm/dd/yyyy','cust_8','Custom 8',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (24,200031,331,'mm/dd/yyyy','cust_9','Custom 9',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (24,200032,341,'mm/dd/yyyy','cust_10','Custom 10',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (24,200033,351,'mm/dd/yyyy','cust_d1','Custom Date 1',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (24,200034,361,'mm/dd/yyyy','cust_d2','Custom Date 2',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
//clin mod

ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (3,200035,301,'mm/dd/yyyy','cust_6','Custom 6',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (3,200036,311,'mm/dd/yyyy','cust_7','Custom 7',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (3,200037,321,'mm/dd/yyyy','cust_8','Custom 8',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (3,200038,331,'mm/dd/yyyy','cust_9','Custom 9',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (3,200038,341,'mm/dd/yyyy','cust_10','Custom 10',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (3,200040,351,'mm/dd/yyyy','cust_d1','Custom Date 1',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (3,200041,361,'mm/dd/yyyy','cust_d2','Custom Date 2',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
//cme
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (11,200042,301,'mm/dd/yyyy','cust_6','Custom 6',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (11,200043,311,'mm/dd/yyyy','cust_7','Custom 7',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (11,200044,321,'mm/dd/yyyy','cust_8','Custom 8',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (11,200045,331,'mm/dd/yyyy','cust_9','Custom 9',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (11,200046,341,'mm/dd/yyyy','cust_10','Custom 10',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (11,200047,351,'mm/dd/yyyy','cust_d1','Custom Date 1',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (11,200048,361,'mm/dd/yyyy','cust_d2','Custom Date 2',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
//contracts
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (4,200049,301,'mm/dd/yyyy','cust_6','Custom 6',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (4,200050,311,'mm/dd/yyyy','cust_7','Custom 7',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (4,200051,321,'mm/dd/yyyy','cust_8','Custom 8',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (4,200052,331,'mm/dd/yyyy','cust_9','Custom 9',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (4,200053,341,'mm/dd/yyyy','cust_10','Custom 10',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (4,200054,351,'mm/dd/yyyy','cust_d1','Custom Date 1',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (4,200055,361,'mm/dd/yyyy','cust_d2','Custom Date 2',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
//cpr
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (5,200056,301,'mm/dd/yyyy','cust_6','Custom 6',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (5,200057,311,'mm/dd/yyyy','cust_7','Custom 7',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (5,200058,321,'mm/dd/yyyy','cust_8','Custom 8',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (5,200059,331,'mm/dd/yyyy','cust_9','Custom 9',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (5,200060,341,'mm/dd/yyyy','cust_10','Custom 10',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (5,200061,351,'mm/dd/yyyy','cust_d1','Custom Date 1',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (5,200062,361,'mm/dd/yyyy','cust_d2','Custom Date 2',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
//cust 1
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (26,200063,301,'mm/dd/yyyy','custom_11','Custom 11',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (26,200064,311,'mm/dd/yyyy','custom_12','Custom 12',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (26,200065,321,'mm/dd/yyyy','custom_13','Custom 13',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (26,200066,331,'mm/dd/yyyy','custom_14','Custom 14',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (26,200067,341,'mm/dd/yyyy','custom_15','Custom 15',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (26,200068,351,'mm/dd/yyyy','custom_d1','Custom Date 1',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (26,200069,361,'mm/dd/yyyy','custom_d2','Custom Date 2',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
//cust 2
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (27,200070,301,'mm/dd/yyyy','custom_11','Custom 11',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (27,200071,311,'mm/dd/yyyy','custom_12','Custom 12',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (27,200072,321,'mm/dd/yyyy','custom_13','Custom 13',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (27,200073,331,'mm/dd/yyyy','custom_14','Custom 14',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (27,200074,341,'mm/dd/yyyy','custom_15','Custom 15',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (27,200075,351,'mm/dd/yyyy','custom_d1','Custom Date 1',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (27,200076,361,'mm/dd/yyyy','custom_d2','Custom Date 2',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
//cust 3
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (28,200077,301,'mm/dd/yyyy','custom_11','Custom 11',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (28,200078,311,'mm/dd/yyyy','custom_12','Custom 12',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (28,200079,321,'mm/dd/yyyy','custom_13','Custom 13',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (28,200080,331,'mm/dd/yyyy','custom_14','Custom 14',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (28,200081,341,'mm/dd/yyyy','custom_15','Custom 15',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (28,200082,351,'mm/dd/yyyy','custom_d1','Custom Date 1',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (28,200083,361,'mm/dd/yyyy','custom_d2','Custom Date 2',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
//dea
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (6,200084,301,'mm/dd/yyyy','cust_6','Custom 6',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (6,200085,311,'mm/dd/yyyy','cust_7','Custom 7',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (6,200086,321,'mm/dd/yyyy','cust_8','Custom 8',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (6,200087,331,'mm/dd/yyyy','cust_9','Custom 9',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (6,200088,341,'mm/dd/yyyy','cust_10','Custom 10',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (6,200089,351,'mm/dd/yyyy','cust_d1','Custom Date 1',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (6,200090,361,'mm/dd/yyyy','cust_d2','Custom Date 2',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
//ecfmg
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (7,200091,301,'mm/dd/yyyy','cust_6','Custom 6',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (7,200092,311,'mm/dd/yyyy','cust_7','Custom 7',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (7,200093,321,'mm/dd/yyyy','cust_8','Custom 8',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (7,200094,331,'mm/dd/yyyy','cust_9','Custom 9',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (7,200095,341,'mm/dd/yyyy','cust_10','Custom 10',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (7,200096,351,'mm/dd/yyyy','cust_d1','Custom Date 1',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (7,200097,361,'mm/dd/yyyy','cust_d2','Custom Date 2',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
//educate
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (8,200098,301,'mm/dd/yyyy','cust_6','Custom 6',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (8,200099,311,'mm/dd/yyyy','cust_7','Custom 7',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (8,200100,321,'mm/dd/yyyy','cust_8','Custom 8',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (8,200101,331,'mm/dd/yyyy','cust_9','Custom 9',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (8,200102,341,'mm/dd/yyyy','cust_10','Custom 10',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (8,200103,351,'mm/dd/yyyy','cust_d1','Custom Date 1',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (8,200104,361,'mm/dd/yyyy','cust_d2','Custom Date 2',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
//group/cov
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (29,200105,301,'mm/dd/yyyy','custom_6','Custom 6',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (29,200106,311,'mm/dd/yyyy','custom_7','Custom 7',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (29,200107,321,'mm/dd/yyyy','custom_8','Custom 8',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (29,200108,331,'mm/dd/yyyy','custom_9','Custom 9',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (29,200109,341,'mm/dd/yyyy','custom_10','Custom 10',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (29,200110,351,'mm/dd/yyyy','custom_d1','Custom d1',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (29,200111,361,'mm/dd/yyyy','custom_d2','Custom d2',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
//hosp
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (9,200112,301,'mm/dd/yyyy','cust_6','Custom 6',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (9,200113,311,'mm/dd/yyyy','cust_7','Custom 7',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (9,200114,321,'mm/dd/yyyy','cust_8','Custom 8',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (9,200115,331,'mm/dd/yyyy','cust_9','Custom 9',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (9,200116,341,'mm/dd/yyyy','cust_10','Custom 10',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (9,200117,351,'mm/dd/yyyy','cust_d1','Custom Date 1',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (9,200118,361,'mm/dd/yyyy','cust_d2','Custom Date 2',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
//ins
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (10,200119,301,'mm/dd/yyyy','cust_6','Custom 6',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (10,200120,311,'mm/dd/yyyy','cust_7','Custom 7',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (10,200121,321,'mm/dd/yyyy','cust_8','Custom 8',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (10,200122,331,'mm/dd/yyyy','cust_9','Custom 9',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (10,200123,341,'mm/dd/yyyy','cust_10','Custom 10',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (10,200124,351,'mm/dd/yyyy','cust_d1','Custom Date 1',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (10,200125,361,'mm/dd/yyyy','cust_d2','Custom Date 2',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
//lang
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (21,200126,301,'mm/dd/yyyy','cust_6','Custom 6',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (21,200127,311,'mm/dd/yyyy','cust_7','Custom 7',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (21,200128,321,'mm/dd/yyyy','cust_8','Custom 8',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (21,200129,331,'mm/dd/yyyy','cust_9','Custom 9',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (21,200130,341,'mm/dd/yyyy','cust_10','Custom 10',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (21,200131,351,'mm/dd/yyyy','cust_d1','Custom Date 1',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (21,200132,361,'mm/dd/yyyy','cust_d2','Custom Date 2',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
//license
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (22,200133,301,'mm/dd/yyyy','cust_6','Custom 6',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (22,200134,311,'mm/dd/yyyy','cust_7','Custom 7',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (22,200135,321,'mm/dd/yyyy','cust_8','Custom 8',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (22,200136,331,'mm/dd/yyyy','cust_9','Custom 9',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (22,200137,341,'mm/dd/yyyy','cust_10','Custom 10',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (22,200138,351,'mm/dd/yyyy','cust_d1','Custom Date 1',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (22,200139,361,'mm/dd/yyyy','cust_d2','Custom Date 2',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
//other affil
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (12,200140,301,'mm/dd/yyyy','cust_6','Custom 6',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (12,200141,311,'mm/dd/yyyy','cust_7','Custom 7',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (12,200142,321,'mm/dd/yyyy','cust_8','Custom 8',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (12,200143,331,'mm/dd/yyyy','cust_9','Custom 9',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (12,200144,341,'mm/dd/yyyy','cust_10','Custom 10',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (12,200145,351,'mm/dd/yyyy','cust_d1','Custom Date 1',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (12,200146,361,'mm/dd/yyyy','cust_d2','Custom Date 2',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
//other ids
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (13,200147,301,'mm/dd/yyyy','cust_6','Custom 6',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (13,200148,311,'mm/dd/yyyy','cust_7','Custom 7',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (13,200149,321,'mm/dd/yyyy','cust_8','Custom 8',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (13,200150,331,'mm/dd/yyyy','cust_9','Custom 9',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (13,200151,341,'mm/dd/yyyy','cust_10','Custom 10',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (13,200152,351,'mm/dd/yyyy','cust_d1','Custom Date 1',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (13,200153,361,'mm/dd/yyyy','cust_d2','Custom Date 2',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
//pro assoc
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (15,200154,301,'mm/dd/yyyy','cust_6','Custom 6',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (15,200155,311,'mm/dd/yyyy','cust_7','Custom 7',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (15,200156,321,'mm/dd/yyyy','cust_8','Custom 8',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (15,200157,331,'mm/dd/yyyy','cust_9','Custom 9',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (15,200158,341,'mm/dd/yyyy','cust_10','Custom 10',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (15,200159,351,'mm/dd/yyyy','cust_d1','Custom Date 1',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (15,200160,361,'mm/dd/yyyy','cust_d2','Custom Date 2',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
//pro exp
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (14,200161,301,'mm/dd/yyyy','cust_6','Custom 6',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (14,200162,311,'mm/dd/yyyy','cust_7','Custom 7',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (14,200163,321,'mm/dd/yyyy','cust_8','Custom 8',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (14,200164,331,'mm/dd/yyyy','cust_9','Custom 9',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (14,200165,341,'mm/dd/yyyy','cust_10','Custom 10',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (14,200166,351,'mm/dd/yyyy','cust_d1','Custom Date 1',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (14,200167,361,'mm/dd/yyyy','cust_d2','Custom Date 2',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
//references
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (23,200168,301,'mm/dd/yyyy','cust_6','Custom 6',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (23,200169,311,'mm/dd/yyyy','cust_7','Custom 7',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (23,200170,321,'mm/dd/yyyy','cust_8','Custom 8',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (23,200171,331,'mm/dd/yyyy','cust_9','Custom 9',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (23,200172,341,'mm/dd/yyyy','cust_10','Custom 10',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (23,200173,351,'mm/dd/yyyy','cust_d1','Custom Date 1',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (23,200174,361,'mm/dd/yyyy','cust_d2','Custom Date 2',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
//sanction
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (17,200175,301,'mm/dd/yyyy','cust_6','Custom 6',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (17,200176,311,'mm/dd/yyyy','cust_7','Custom 7',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (17,200177,321,'mm/dd/yyyy','cust_8','Custom 8',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (17,200178,331,'mm/dd/yyyy','cust_9','Custom 9',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (17,200179,341,'mm/dd/yyyy','cust_10','Custom 10',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (17,200180,351,'mm/dd/yyyy','cust_d1','Custom Date 1',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (17,200181,361,'mm/dd/yyyy','cust_d2','Custom Date 2',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
//sp Certs
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (18,200182,301,'mm/dd/yyyy','cust_6','Custom 6',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (18,200183,311,'mm/dd/yyyy','cust_7','Custom 7',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (18,200184,321,'mm/dd/yyyy','cust_8','Custom 8',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (18,200185,331,'mm/dd/yyyy','cust_9','Custom 9',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (18,200186,341,'mm/dd/yyyy','cust_10','Custom 10',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (18,200187,351,'mm/dd/yyyy','cust_d1','Custom Date 1',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (18,200188,361,'mm/dd/yyyy','cust_d2','Custom Date 2',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
//train
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (19,200189,301,'mm/dd/yyyy','cust_6','Custom 6',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (19,200190,311,'mm/dd/yyyy','cust_7','Custom 7',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (19,200191,321,'mm/dd/yyyy','cust_8','Custom 8',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (19,200192,331,'mm/dd/yyyy','cust_9','Custom 9',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (19,200193,341,'mm/dd/yyyy','cust_10','Custom 10',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (19,200194,351,'mm/dd/yyyy','cust_d1','Custom Date 1',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (19,200195,361,'mm/dd/yyyy','cust_d2','Custom Date 2',10,'D',10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080905 maha 
commit using sqlca;
//dataview field data

ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21000, 1,18,200000,300,'Custom 6','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21001, 1,18,200001,310,'Custom 7','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21002, 1,18,200002,320,'Custom 8','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21003, 1,18,200003,330,'Custom 9','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21004, 1,18,200004,340,'Custom 10','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21005, 1,18,200005,350,'Custom d1','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21006, 1,18,200006,360,'Custom d2','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
//address
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21007, 1,2,200007,301,'Custom 6','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21008, 1,2,200008,311,'Custom 7','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21009, 1,2,200009,321,'Custom 8','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21010, 1,2,200010,331,'Custom 9','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21011, 1,2,200011,341,'Custom 10','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21012, 1,2,200012,351,'Custom d1','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21013, 1,2,200013,361,'Custom d2','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
//basic
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21014, 1,1,200014,301,'Custom 11','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21015, 1,1,200015,311,'Custom 12','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21016, 1,1,200016,321,'Custom 13','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21017, 1,1,200017,331,'Custom 14','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21018, 1,1,200018,341,'Custom 15','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21019, 1,1,200019,351,'Custom d1','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21020, 1,1,200020,361,'Custom d2','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
//board/spec
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21021, 1,19,200021,301,'Custom 6','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21022, 1,19,200022,311,'Custom 7','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21023, 1,19,200023,321,'Custom 8','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21024, 1,19,200024,331,'Custom 9','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21025, 1,19,200025,341,'Custom 10','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21026, 1,19,200026,351,'Custom d1','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21027, 1,19,200027,361,'Custom d2','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
//claims
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21028, 1,16,200028,301,'Custom 6','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21029, 1,16,200029,311,'Custom 7','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21030, 1,16,200030,321,'Custom 8','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21031, 1,16,200031,331,'Custom 9','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21032, 1,16,200032,341,'Custom 10','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21033, 1,16,200033,351,'Custom d1','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21034, 1,16,200034,361,'Custom d2','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
//clin mod
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21035, 1,22,200035,301,'Custom 6','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21036, 1,22,200036,311,'Custom 7','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21037, 1,22,200037,321,'Custom 8','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21038, 1,22,200038,331,'Custom 9','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
//--------Begin Commented by  Nova 07.03.2009------------------------
//ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21039, 1,22,200038,341,'Custom 10','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
//--------End Commented --------------------------------------------
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21039, 1,22,200039,341,'Custom 10','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21040, 1,22,200040,351,'Custom d1','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21041, 1,22,200041,361,'Custom d2','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
//cme
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21042, 1,8,200042,301,'Custom 6','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21043, 1,8,200043,311,'Custom 7','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21044, 1,8,200044,321,'Custom 8','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21045, 1,8,200045,331,'Custom 9','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21046, 1,8,200046,341,'Custom 10','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21047, 1,8,200047,351,'Custom d1','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21048, 1,8,200048,361,'Custom d2','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
//contracts
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21049, 1,3,200049,301,'Custom 6','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21050, 1,3,200050,311,'Custom 7','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21051, 1,3,200051,321,'Custom 8','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21052, 1,3,200052,331,'Custom 9','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21053, 1,3,200053,341,'Custom 10','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21054, 1,3,200054,351,'Custom d1','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21055, 1,3,200055,361,'Custom d2','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
//cpr
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21056, 1,24,200056,301,'Custom 6','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21057, 1,24,200057,311,'Custom 7','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21058, 1,24,200058,321,'Custom 8','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21059, 1,24,200059,331,'Custom 9','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21060, 1,24,200060,341,'Custom 10','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21061, 1,24,200061,351,'Custom d1','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21062, 1,24,200062,361,'Custom d2','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
//cust 1
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21063, 1,28,200063,301,'Custom 11','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21064, 1,28,200064,311,'Custom 12','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21065, 1,28,200065,321,'Custom 13','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21066, 1,28,200066,331,'Custom 14','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21067, 1,28,200067,341,'Custom 15','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21068, 1,28,200068,351,'Custom d1','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21069, 1,28,200069,361,'Custom d2','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
//cust 2
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21070, 1,29,200070,301,'Custom 11','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21071, 1,29,200071,311,'Custom 12','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21072, 1,29,200072,321,'Custom 13','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21073, 1,29,200073,331,'Custom 14','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21074, 1,29,200074,341,'Custom 15','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21075, 1,29,200075,351,'Custom d1','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21076, 1,29,200076,361,'Custom d2','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
//cust 3
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21077, 1,30,200077,301,'Custom 11','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21078, 1,30,200078,311,'Custom 12','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21079, 1,30,200079,321,'Custom 13','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21080, 1,30,200080,331,'Custom 14','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21081, 1,30,200081,341,'Custom 15','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21082, 1,30,200082,351,'Custom d1','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21083, 1,30,200083,361,'Custom d2','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
//dea
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21084, 1,5,200084,301,'Custom 6','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21085, 1,5,200085,311,'Custom 7','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21086, 1,5,200086,321,'Custom 8','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21087, 1,5,200087,331,'Custom 9','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21088, 1,5,200088,341,'Custom 10','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21089, 1,5,200089,351,'Custom d1','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21090, 1,5,200090,361,'Custom d2','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
//ecfmg
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21091, 1,20,200091,301,'Custom 6','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21092, 1,20,200092,311,'Custom 7','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21093, 1,20,200093,321,'Custom 8','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21094, 1,20,200094,331,'Custom 9','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21095, 1,20,200095,341,'Custom 10','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21096, 1,20,200096,351,'Custom d1','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21097, 1,20,200097,361,'Custom d2','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
//educate
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21098, 1,6,200098,301,'Custom 6','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21099, 1,6,200099,311,'Custom 7','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21100, 1,6,200100,321,'Custom 8','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21101, 1,6,200101,331,'Custom 9','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21102, 1,6,200102,341,'Custom 10','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21103, 1,6,200103,351,'Custom d1','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21104, 1,6,200104,361,'Custom d2','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
//group/cov
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21105, 1,26,200105,301,'Custom 6','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21106, 1,26,200106,311,'Custom 7','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21107, 1,26,200107,321,'Custom 8','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21108, 1,26,200108,331,'Custom 9','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21109, 1,26,200109,341,'Custom 10','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21110, 1,26,200110,351,'Custom d1','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21111, 1,26,200111,361,'Custom d2','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
//hosp
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21112, 1,10,200112,301,'Custom 6','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21113, 1,10,200113,311,'Custom 7','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21114, 1,10,200114,321,'Custom 8','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21115, 1,10,200115,331,'Custom 9','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21116, 1,10,200116,341,'Custom 10','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21117, 1,10,200117,351,'Custom d1','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21118, 1,10,200118,361,'Custom d2','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
//ins
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21119, 1,15,200119,301,'Custom 6','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21120, 1,15,200120,311,'Custom 7','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21121, 1,15,200121,321,'Custom 8','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21122, 1,15,200122,331,'Custom 9','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21123, 1,15,200123,341,'Custom 10','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21124, 1,15,200124,351,'Custom d1','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21125, 1,15,200125,361,'Custom d2','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
//lang
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21126, 1,25,200126,301,'Custom 6','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21127, 1,25,200127,311,'Custom 7','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21128, 1,25,200128,321,'Custom 8','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21129, 1,25,200129,331,'Custom 9','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21130, 1,25,200130,341,'Custom 10','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21131, 1,25,200131,351,'Custom d1','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21132, 1,25,200132,361,'Custom d2','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
//license
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21133, 1,4,200133,301,'Custom 6','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21134, 1,4,200134,311,'Custom 7','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21135, 1,4,200135,321,'Custom 8','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21136, 1,4,200136,331,'Custom 9','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21137, 1,4,200137,341,'Custom 10','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21138, 1,4,200138,351,'Custom d1','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21139, 1,4,200139,361,'Custom d2','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
//other affil
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21140, 1,11,200140,301,'Custom 6','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21141, 1,11,200141,311,'Custom 7','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21142, 1,11,200142,321,'Custom 8','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21143, 1,11,200143,331,'Custom 9','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21144, 1,11,200144,341,'Custom 10','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21145, 1,11,200145,351,'Custom d1','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21146, 1,11,200146,361,'Custom d2','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
//other ids
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21147, 1,23,200147,301,'Custom 6','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21148, 1,23,200148,311,'Custom 7','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21149, 1,23,200149,321,'Custom 8','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21150, 1,23,200150,331,'Custom 9','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21151, 1,23,200151,341,'Custom 10','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21152, 1,23,200152,351,'Custom d1','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21153, 1,23,200153,361,'Custom d2','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
//pro assoc
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21154, 1,14,200154,301,'Custom 6','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21155, 1,14,200155,311,'Custom 7','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21156, 1,14,200156,321,'Custom 8','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21157, 1,14,200157,331,'Custom 9','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21158, 1,14,200158,341,'Custom 10','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21159, 1,14,200159,351,'Custom d1','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21160, 1,14,200160,361,'Custom d2','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
//pro exp
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21161, 1,12,200161,301,'Custom 6','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21162, 1,12,200162,311,'Custom 7','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21163, 1,12,200163,321,'Custom 8','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21164, 1,12,200164,331,'Custom 9','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21165, 1,12,200165,341,'Custom 10','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21166, 1,12,200166,351,'Custom d1','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21167, 1,12,200167,361,'Custom d2','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
//references
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21168, 1,13,200168,301,'Custom 6','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21169, 1,13,200169,311,'Custom 7','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21170, 1,13,200170,321,'Custom 8','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21171, 1,13,200171,331,'Custom 9','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21172, 1,13,200172,341,'Custom 10','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21173, 1,13,200173,351,'Custom d1','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21174, 1,13,200174,361,'Custom d2','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
//sanction
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21175, 1,17,200175,301,'Custom 6','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21176, 1,17,200176,311,'Custom 7','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21177, 1,17,200177,321,'Custom 8','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21178, 1,17,200178,331,'Custom 9','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21179, 1,17,200179,341,'Custom 10','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21180, 1,17,200180,351,'Custom d1','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21181, 1,17,200181,361,'Custom d2','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
//sp Certs
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21182, 1,9,200182,301,'Custom 6','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21183, 1,9,200183,311,'Custom 7','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21184, 1,9,200184,321,'Custom 8','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21185, 1,9,200185,331,'Custom 9','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21186, 1,9,200186,341,'Custom 10','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21187, 1,9,200187,351,'Custom d1','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21188, 1,9,200188,361,'Custom d2','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
//train
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21189, 1,7,200189,301,'Custom 6','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21190, 1,7,200190,311,'Custom 7','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21191, 1,7,200191,321,'Custom 8','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21192, 1,7,200192,331,'Custom 9','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21193, 1,7,200193,341,'Custom 10','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21194, 1,7,200194,351,'Custom d1','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label, display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21195, 1,7,200195,361,'Custom d2','N','N','N','N',99,1300,500,64,0,'E',99,1200,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;

//reposition fields //maha 081505

ls_sql = "Update data_view_fields set field_x = 100,field_y = 1220,field_label_x = 100,field_label_y = 1150 where field_x = 99 and field_label = 'Custom 6';"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;
ls_sql = "Update data_view_fields set field_x = 625,field_y = 1220,field_label_x = 625,field_label_y = 1150 where field_x = 99 and field_label = 'Custom 7';"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;
ls_sql = "Update data_view_fields set field_x = 1150,field_y = 1220,field_label_x = 1150,field_label_y = 1150 where field_x = 99 and field_label = 'Custom 8';"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;
ls_sql = "Update data_view_fields set field_x = 100,field_y = 1360,field_label_x = 100,field_label_y = 1300 where field_x = 99 and field_label = 'Custom 9';"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;
ls_sql = "Update data_view_fields set field_x = 624,field_y = 1360,field_label_x = 624,field_label_y = 1300 where field_x = 99 and field_label = 'Custom 10';"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;
ls_sql = "Update data_view_fields set field_x = 1150,field_y = 1360,field_label_x = 1150,field_label_y = 1300 where field_x = 99 and field_label = 'Custom d1';"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;
ls_sql = "Update data_view_fields set field_x = 1700,field_y = 1360,field_label_x = 1700,field_label_y = 1300 where field_x = 99 and field_label = 'Custom d2';"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;

ls_sql = "Update data_view_fields set field_x = 100,field_y = 1220,field_label_x = 100,field_label_y = 1150 where field_x = 99 and field_label = 'Custom 11';"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;
ls_sql = "Update data_view_fields set field_x = 624,field_y = 1220,field_label_x = 624,field_label_y = 1150 where field_x = 99 and field_label = 'Custom 12';"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;
ls_sql = "Update data_view_fields set field_x = 1150,field_y = 1220,field_label_x = 1150,field_label_y = 1150 where field_x = 99 and field_label = 'Custom 13';"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;
ls_sql = "Update data_view_fields set field_x = 1700,field_y = 1220,field_label_x = 1700,field_label_y = 1150 where field_x = 99 and field_label = 'Custom 14';"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;
ls_sql = "Update data_view_fields set field_x = 100,field_y = 1360,field_label_x = 100,field_label_y = 1300 where field_x = 99 and field_label = 'Custom 15';"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;


of_add_dv_fields(200000,200195)

return 1
end function

public function integer of_date_fields ();//created maha app080905

// new full date field modifications for NY Presby

string ls_sql

//data fields

ls_sql = 'ALTER TABLE "pd_acedemic_appointments" MODIFY	"cust_1"        		varchar(150) NULL,MODIFY	"cust_2"        		varchar(150) NULL,MODIFY	"cust_3"        		varchar(150) NULL,MODIFY	"cust_4"        		varchar(150) NULL,MODIFY	"cust_5"        		varchar(150) NULL,ADD	"cust_6"			varchar(150) NULL,ADD	"cust_7"			varchar(150) NULL,ADD	"cust_8"			varchar(150) NULL,ADD	"cust_9"			varchar(150) NULL,ADD	"cust_10"		varchar(150) NULL,ADD	"cust_d1"		timestamp NULL,ADD	"cust_d2"		timestamp NULL;'
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;

ls_sql = "ALTER TABLE pd_acedemic_appointments add start_date timestamp null, add end_date timestamp null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;
ls_sql = "ALTER TABLE pd_education add start_date timestamp null, add end_date timestamp null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;
ls_sql = "ALTER TABLE pd_hosp_affil add start_date timestamp null, add end_date timestamp null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;
ls_sql = "ALTER TABLE pd_other_affill add start_date timestamp null, add end_date timestamp null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;
ls_sql = "ALTER TABLE pd_special_certs add start_date timestamp null, add end_date timestamp null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;
ls_sql = "ALTER TABLE pd_training add start_date timestamp null, add end_date timestamp null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;
ls_sql = "ALTER TABLE pd_prof_experience add start_date timestamp null, add end_date timestamp null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;
ls_sql = "ALTER TABLE pd_board_specialty add initial_cert_date timestamp null, add last_cert_date timestamp null, add eligible_until_date timestamp null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;
ls_sql = "ALTER TABLE pd_license add issue_date timestamp null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//080805 maha 
commit using sqlca;
ls_sql = "ALTER TABLE pd_board_specialty add compl_req_date timestamp null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//091405 maha 
commit using sqlca;
ls_sql = "ALTER TABLE pd_other_ids add issue_date timestamp null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//091405 maha 
commit using sqlca;

//sys tables

ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len) values (1,200500,362,'mm/dd/yyyy','start_date', 'Start Date',10,'D' ,10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len) values (1,200501,372,'mm/dd/yyyy','end_date', 'End Date',10,'D' ,10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len) values (8,200502,362,'mm/dd/yyyy','start_date', 'Start Date',10,'D' ,10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len) values (8,200503,372,'mm/dd/yyyy','end_date', 'End Date',10,'D' ,10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len) values (9,200504,362,'mm/dd/yyyy','start_date', 'Start Date',10,'D' ,10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len) values (9,200505,372,'mm/dd/yyyy','end_date', 'End Date',10,'D' ,10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len) values (12,200506,362,'mm/dd/yyyy','start_date', 'Start Date',10,'D' ,10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len) values (12,200507,372,'mm/dd/yyyy','end_date', 'End Date',10,'D' ,10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len) values (18,200508,362,'mm/dd/yyyy','start_date', 'Start Date',10,'D' ,10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len) values (18,200509,372,'mm/dd/yyyy','end_date', 'End Date',10,'D' ,10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len) values (19,200510,362,'mm/dd/yyyy','start_date', 'Start Date',10,'D' ,10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len) values (19,200511,372,'mm/dd/yyyy','end_date', 'End Date',10,'D' ,10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len) values (14,200512,362,'mm/dd/yyyy','start_date', 'Start Date',10,'D' ,10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len) values (14,200513,372,'mm/dd/yyyy','end_date', 'End Date',10,'D' ,10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len) values (2,200514,362,'mm/dd/yyyy','initial_cert_date', 'Initial Cert Date',10,'D' ,10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len) values (2,200515,372,'mm/dd/yyyy','last_cert_date', 'Last Cert Date',10,'D' ,10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len) values (2,200516,382,'mm/dd/yyyy','eligible_until_date', 'Eligible Until Date',10,'D' ,10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (22,200517,362,'mm/dd/yyyy','issue_date', 'Issue Date',10,'D' ,10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len) values (2,200518,383,'mm/dd/yyyy','compl_req_date', 'Completion Required Date',10,'D' ,10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//091305 maha 
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len) values (13,200519,383,'mm/dd/yyyy','issue_date', 'Issue Date',10,'D' ,10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//091305 maha 
commit using sqlca;

//dv fields
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21500, 1,18,200500,301,'Start Date','N','N','N','N',100,900,500,64,0,'E',100,800,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21501, 1,18,200501,301,'End Date','N','N','N','N',100,900,500,64,0,'E',100,800,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21502, 1,6,200502,301,'Start Date','N','N','N','N',100,900,500,64,0,'E',100,800,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21503, 1,6,200503,301,'End Date','N','N','N','N',100,900,500,64,0,'E',100,180,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21504, 1,10,200504,301,'Start Date','N','N','N','N',100,900,500,64,0,'E',100,800,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21505, 1,10,200505,301,'End Date','N','N','N','N',100,900,500,64,0,'E',100,800,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21506, 1,11,200506,301,'Start Date','N','N','N','N',100,900,500,64,0,'E',100,800,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21507, 1,11,200507,301,'End Date','N','N','N','N',100,900,500,64,0,'E',100,800,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21508, 1,9,200508,301,'Start Date','N','N','N','N',100,900,500,64,0,'E',100,800,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21509, 1,9,200509,301,'End Date','N','N','N','N',100,900,500,64,0,'E',100,800,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21510, 1,7,200510,301,'Start Date','N','N','N','N',100,900,500,64,0,'E',100,800,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21511, 1,7,200511,301,'End Date','N','N','N','N',100,900,500,64,0,'E',100,800,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21512, 1,12,200512,301,'Start Date','N','N','N','N',100,900,500,64,0,'E',100,800,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21513, 1,12,200513,301,'End Date','N','N','N','N',100,900,500,64,0,'E',100,800,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21514, 1,19,200514,301,'Initial Cert Date 6','N','N','N','N',100,900,500,64,0,'E',100,800,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21515, 1,19,200515,301,'Last Cert Date','N','N','N','N',100,900,500,64,0,'E',100,800,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21516, 1,19,200516,301,'Eligible Until Date','N','N','N','N',100,900,500,64,0,'E',100,800,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21517, 1,4,200517,301,'Issue Date','N','N','N','N',100,900,500,64,0,'E',100,800,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081105 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21518, 1,19,200518,302,'Completion Required Date','N','N','N','N',100,900,500,64,0,'E',100,800,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//091405 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21519, 1,23,200519,302,'Issue Date','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//091405 maha 
commit using sqlca;

of_add_dv_fields(200500,200519)

return 1
end function

public function integer of_add_dv_fields (long al_from, long al_to);//created maha 090205 to add new fields to all views

//Start Code Change ---- 06.01.2006 #494 maha
//replaced by program function 
of_dv_field_add_to_views(al_from,al_to)
//End Code Change---06.01.2006

////integer l1
//integer fc
//integer newf
//integer vc
//integer cnt
//integer cc
//integer f
//integer v
//integer c
//datastore ds_f //list of fields retrieved by arguments
//datastore ds_v //list of all views that have the screen except default
//datastore ds_c//check/add list
//datastore ds_copy
//integer vid
//integer sid
//long fid
//long dvfid
//
//ds_f = create datastore
//ds_v = create datastore
//ds_c = create datastore
//ds_copy = create datastore
//
//ds_f.dataobject = "d_dvfadd_fields"
//ds_v.dataobject = "d_dvfadd_views"
//ds_c.dataobject = "d_dvfadd_checkfield"
//ds_copy.dataobject = "d_dvfadd_fields"
//
//ds_f.settransobject(sqlca)
//ds_v.settransobject(sqlca)
//ds_c.settransobject(sqlca)
//ds_copy.settransobject(sqlca)
//
////get list of data view_fields to be checked. arguments are range of field_ids
//fc = ds_f.retrieve(al_from,al_to)
////debugbreak()
//for f = 1 to fc
//	fid = ds_f.getitemnumber(f,"field_id")
//	sid = ds_f.getitemnumber(f,"screen_id")
//	//get views
//	vc = ds_v.retrieve(sid)
//	for v = 1 to vc
//		vid = ds_v.getitemnumber(v,"data_view_id")
//		cc = ds_c.retrieve(vid,sid,fid)
//		if cc = 0 then //field not found
//			ds_f.rowscopy( f, f, primary!, ds_copy, 10000, primary!)
//			ds_copy.setitem(ds_copy.rowcount(),"data_view_id",vid)
//			//ds_copy.setitem(ds_copy.rowcount(),"data_view_id",vid)
//		end if
//	next
//	
//next
//long qwe
//cnt = ds_copy.rowcount( )
//
//if cnt > 0 then
//	select max(data_view_field_id) into :dvfid from data_view_fields;
//	for newf = 1 to cnt
//		dvfid++
//		//qwe = 
//		//messagebox(string(ds_copy.getitemnumber(newf,"data_view_id")),dvfid)
//		ds_copy.setitem(newf,"data_view_field_id",string(dvfid))
//	next
//
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<ID> PT-01
//	//$<add> 04.03.2006 By: LeiWei
//	//$<reason> Performance tuning
//	//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
//	gnv_appeondb.of_autocommit( )
//	//---------------------------- APPEON END ----------------------------
//	ds_copy.update( )
//	commit using sqlca;
//end if
//
//destroy ds_f
//destroy ds_v
//destroy ds_c 
//destroy ds_copy

//End Code Change---06.01.2006


return 1
end function

public function integer of_security_addv5 ();string ls_sql

cb_update.text = "Ver 5.0 Security Updates"
st_update.text  = "Ver 5.0 Security Updates"
	
ls_sql = "INSERT	INTO	security_modules	(	module_id		, software_version		, module_name	) VALUES	(	33		, 4	, 'Contracts');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app100405
commit using sqlca;

ls_sql = "INSERT	INTO	security_sub_module	(	module_id		, sub_module_id		, sub_module_name	)	VALUES		(	33		, 290	, 'Main'	);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app100405
commit using sqlca;
ls_sql = "INSERT	INTO	security_sub_module	(	module_id		, sub_module_id		, sub_module_name	)	VALUES		(	33		, 300		, 'Search Tab'	);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app100405
commit using sqlca;
ls_sql = "INSERT	INTO	security_sub_module	(	module_id		, sub_module_id		, sub_module_name	)	VALUES		(	33		,310	, 'Detail Tab'	);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app100405
commit using sqlca;
ls_sql = "INSERT	INTO	security_sub_module	(	module_id		, sub_module_id		, sub_module_name	)	VALUES		(	33		, 320	, 'Requirements'	);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app100405
commit using sqlca;
ls_sql = "INSERT	INTO	security_sub_module	(	module_id		, sub_module_id		, sub_module_name	)	VALUES		(	33		, 330		, 'Contacts'	);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app100405
commit using sqlca;
ls_sql = "INSERT	INTO	security_sub_module	(	module_id		, sub_module_id		, sub_module_name	)	VALUES		(	33		, 340		, 'Locations'	);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app100405
commit using sqlca;
ls_sql = "INSERT	INTO	security_sub_module	(	module_id		, sub_module_id		, sub_module_name	)	VALUES		(	33		, 350		, 'Organizations'	);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app100405
commit using sqlca;
ls_sql = "INSERT	INTO	security_sub_module	(	module_id		, sub_module_id		, sub_module_name	)	VALUES		(	33		, 360		, 'Fee Scheduals'	);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app100405
commit using sqlca;
ls_sql = "INSERT	INTO	security_sub_module	(	module_id		, sub_module_id		, sub_module_name	)	VALUES		(	33		, 370		, 'Documents'	);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app100405
commit using sqlca;
ls_sql = "INSERT	INTO	security_sub_module	(	module_id		, sub_module_id		, sub_module_name	)	VALUES		(	33		, 380		, 'Action Items'	);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app100405
commit using sqlca;
ls_sql = "INSERT	INTO	security_sub_module	(	module_id		, sub_module_id		, sub_module_name	)	VALUES		(	33		, 390		, 'Analysis'	);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app100405
commit using sqlca;
ls_sql = "INSERT	INTO	security_sub_module	(	module_id		, sub_module_id		, sub_module_name	)	VALUES		(	33		, 400		, 'QRG tab'	);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app100405
commit using sqlca;


ls_sql = "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	33	, 290	,2070 , 'Access Rights'	, 2	);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app100405
commit using sqlca;
ls_sql = "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	33	, 300	,2080 , 'Access Rights'	, 2	);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app100405
commit using sqlca;
ls_sql = "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	33	, 310	,2090 , 'Access Rights'	, 2	);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app100405
commit using sqlca;
ls_sql = "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	33	, 320	,2100 , 'Access Rights'	, 2	);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app100405
commit using sqlca;
ls_sql = "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	33	, 330	,2110 , 'Access Rights'	, 2	);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app100405
commit using sqlca;
ls_sql = "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	33	, 340	,2120 , 'Access Rights'	, 2	);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app100405
commit using sqlca;
ls_sql = "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	33	, 350	,2130 , 'Access Rights'	, 2	);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app100405
commit using sqlca;
ls_sql = "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	33	, 360	,2140 , 'Access Rights'	, 2	);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app100405
commit using sqlca;
ls_sql = "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	33	, 370	,2150 , 'Access Rights'	, 2	);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app100405
commit using sqlca;
ls_sql = "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	33	, 380	,2160 , 'Access Rights'	, 2	);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app100405
commit using sqlca;
ls_sql = "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	33	, 390	,2170 , 'Access Rights'	, 2	);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app100405
commit using sqlca;
ls_sql = "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	33	, 400	,2180 , 'Access Rights'	, 2	);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app100405
commit using sqlca;

//Start Code Change ---- 11.03.2005 #-1 maha export run report
ls_sql = "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	10	, 29	,2190 , 'Run report'	, 1	);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app110305
commit using sqlca;

ls_sql = "INSERT	INTO	security_sub_module	(	module_id		, sub_module_id		, sub_module_name	)	VALUES		(	25		, 410		, 'Change Password'	);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app110305
commit using sqlca;

ls_sql = "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	25	, 410	,2200 , 'Access Rights'	, 1	);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app110305
commit using sqlca;
//End Code Change---11.03.2005 

//Start Code Change ---- 05.16.2006 #452 maha
ls_sql = "INSERT	INTO	security_sub_module	(	module_id		, sub_module_id		, sub_module_name	)	VALUES		(	33		, 430	, 'Fees Non-Medical'	);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 051506
commit using sqlca;

ls_sql = "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	33	, 430	,2220 , 'Access Rights'	, 2	);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 051506
commit using sqlca;
//End Code Change---05.15.2006
//of_security()

return 1
end function

public function integer of_attest_quest ();//function created maha app101205 for creation of new attestation question data

string ls_sql
integer li_test


ls_sql = "create table pd_attest_questions (rec_id numeric(10,0) not null, prac_id numeric(10,0) not null, question_id numeric(10,0) null, answer_code numeric(10,0) null, active_status integer null, appt_stat_id numeric(10,0) null, facility_id integer null, primary key (rec_id));"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081705 maha 
commit using sqlca;

ls_sql = "ALTER TABLE  pd_attest_questions ADD explain_yes long varchar null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//093005 maha
commit using sqlca;

//select count(lookup_code) into :li_test from code_lookup where lookup_name = 'Question Type';
//if li_test = 0 then
	ls_sql = "insert into code_lookup (lookup_code, lookup_name, code, description) values (-100,'Question Type','ATTEST','Attestation');"
	st_sql.text  = ls_sql
	execute immediate :ls_sql using sqlca;//093005 maha
	commit using sqlca;
	ls_sql = "insert into code_lookup (lookup_code, lookup_name, code, description) values (-101,'Question Type','SERVICES','Services');"
	st_sql.text  = ls_sql
	execute immediate :ls_sql using sqlca;//093005 maha
	commit using sqlca;
	ls_sql = "insert into code_lookup (lookup_code, lookup_name, code, description) values (-105,'Question Type','CERTS','Certifications');"
	st_sql.text  = ls_sql
	execute immediate :ls_sql using sqlca;//051006 maha
	commit using sqlca;
//end if 

//select count(lookup_code) into :li_test from code_lookup where lookup_name = 'Question Answers';
//if li_test = 0 then
	ls_sql = "insert into code_lookup (lookup_code, lookup_name, code, description) values (-102,'Question Answers','YES','Yes');"
	st_sql.text  = ls_sql
	execute immediate :ls_sql using sqlca;//093005 maha
	commit using sqlca;
	ls_sql = "insert into code_lookup (lookup_code, lookup_name, code, description) values (-103,'Question Answers','NO','No');"
	st_sql.text  = ls_sql
	execute immediate :ls_sql using sqlca;//093005 maha
	commit using sqlca;
	ls_sql = "insert into code_lookup (lookup_code, lookup_name, code, description) values (-104,'Question Answers','UNK','Unknown');"
	st_sql.text  = ls_sql
	execute immediate :ls_sql using sqlca;//093005 maha
	commit using sqlca;
//end if

ls_sql = "INSERT INTO sys_tables (table_id,table_name,table_name_allias,profile_dw_name,facility_specific,ver_ltr_sql,exp_ltr_sql,is_required) VALUES (	65,	'pd_attest_questions',	'Att Questions',	NULL,	1,	NULL,	NULL,null);"
execute immediate :ls_sql using sqlca;//021903 maha  
commit using sqlca;

ls_sql = "INSERT INTO data_view_screen VALUES (	1,	65,	27,	'Attest Questions(new)',	'Y',	NULL,	NULL,	NULL,	NULL,	65,	NULL,	NULL,	NULL,	'Attest Questions(new)',null);"
execute immediate :ls_sql using sqlca;
commit using sqlca;

ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (65,200600,0,null,'rec_id','Rec Id',30,'N',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app081805
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (65,200601,0,null,'prac_id','Prac Id',30,'N',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app081805
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (65,200602,0,null,'facility_id','Facility Id',30,'N',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app081805
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (65,200603,40,null,'question_id','Question Code',30,'N',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app081805
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (65,200604,50,null,'answer_code','Answer Code',30,'N',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app081805
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (65,200605,60,null,'active_status','Active Status',30,'N',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app081805
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (65,200606,70,null,'appt_stat_id','Appointment id',30,'N',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app081805
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (65,200607,80,null,'explain_yes','Explain Yes',30,'C',25);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app081805
commit using sqlca;

//select count(data_view_field_id) into :li_test from data_view_fields where screen_id = 65;
//if li_test = 0 then
	ls_sql = "INSERT INTO data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,seperator_hdr,include_in_browse,browse_tab_order,browse_tab_width,field_x,field_y,field_width,field_height,justification,sys_table_id,sys_field_id,edit_field_type,field_label_justification,field_label_x,field_label_y,field_label_width,visible) VALUES (21604,	1,	65,	200604,	10,  'Response',		'N',	'N',	NULL,	NULL,	'Y',	NULL,	NULL,	69,	84,	308,	64,	'0',	NULL,	NULL,	'E',	0,	41,	16,	306,	'Y');"
	st_sql.text  = ls_sql
	execute immediate :ls_sql using sqlca;//101205 appmaha 
	commit using sqlca;
	ls_sql = "INSERT INTO data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,seperator_hdr,include_in_browse,browse_tab_order,browse_tab_width,field_x,field_y,field_width,field_height,justification,sys_table_id,sys_field_id,edit_field_type,field_label_justification,field_label_x,field_label_y,field_label_width,visible) VALUES (	30232,	1,	65,	200607, 50 ,	'Explanation',	'N',	'N',	NULL,	NULL,	'N',	NULL,	NULL,	386,	166,	2140,	130,	'0',	NULL,	NULL,	'E',	0,	81,	174,	276,	'Y');"
	st_sql.text  = ls_sql
	execute immediate :ls_sql using sqlca;//101205 appmaha 
	commit using sqlca;
	ls_sql = "INSERT INTO data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,seperator_hdr,include_in_browse,browse_tab_order,browse_tab_width,field_x,field_y,field_width,field_height,justification,sys_table_id,sys_field_id,edit_field_type,field_label_justification,field_label_x,field_label_y,field_label_width,visible) VALUES (	21603,	1,	65,	200603, 20,	'Question',	'Y',	'N',	NULL,	NULL,	'Y',	NULL,	NULL,	379,	84,	2135,	64,	'0',	NULL,	NULL,	'E',	0,	383,	16,	500,	'Y');"
	st_sql.text  = ls_sql
	execute immediate :ls_sql using sqlca;//101205 appmaha 
	commit using sqlca;
	ls_sql = "INSERT INTO data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,seperator_hdr,include_in_browse,browse_tab_order,browse_tab_width,field_x,field_y,field_width,field_height,justification,sys_table_id,sys_field_id,edit_field_type,field_label_justification,field_label_x,field_label_y,field_label_width,visible) VALUES (	20606,	1,	65,	200606, 40,	'Active Status',		'Y',	'N',	NULL,	NULL,	'N',	NULL,	NULL,	2818,	70,	500,	64,	'0',	NULL,	NULL,	'E',	0,	3168,	54,	83,	'Y');"
	st_sql.text  = ls_sql
	execute immediate :ls_sql using sqlca;//101205 appmaha 
	commit using sqlca;
	ls_sql = "INSERT INTO data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,seperator_hdr,include_in_browse,browse_tab_order,browse_tab_width,field_x,field_y,field_width,field_height,justification,sys_table_id,sys_field_id,edit_field_type,field_label_justification,field_label_x,field_label_y,field_label_width,visible) VALUES (	21605,	1,	65,	200605, 30,	'Appt Id',		'Y',	'N',	NULL,	NULL,	'N',	NULL,	NULL,	2759,	52,	310,	64,	'0',	NULL,	NULL,	'E',	0,	3300,	40,	60,	'Y');"
	st_sql.text  = ls_sql
	execute immediate :ls_sql using sqlca;//101205 appmaha 
	commit using sqlca;
//end if

ls_sql = "Update sys_fields set lookup_field = 'Y',lookup_type = 'Q' where field_id = 200603;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//101205 appmaha 
commit using sqlca;

ls_sql = "Update sys_fields set lookup_field = 'Y',lookup_type = 'C',lookup_code = 'Question Answers',lookup_field_name = 'Code' where field_id = 200604;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//101205 appmaha 
commit using sqlca;

ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21519, 1,23,200519,302,'Issue Date','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//101205 appmaha 
commit using sqlca;

//Start Code Change ---- 05.24.2006 #488 maha
of_execute("update code_lookup set type = 'S' where lookup_code = -100;")
of_execute("update code_lookup set type = 'S' where lookup_code = -101;")
of_execute("update code_lookup set type = 'S' where lookup_code = -102;")
of_execute("update code_lookup set type = 'S' where lookup_code = -103;")
of_execute("update code_lookup set type = 'S' where lookup_code = -104;")
of_execute("update code_lookup set type = 'S' where lookup_code = -105;")
of_execute("insert into code_lookup (lookup_code, lookup_name, code, description,type) values (-106,'Question Type','PRACT','Practice','S');")

//End Code Change---05.24.2006

return 1
end function

public function integer of_group_dv_fields ();////Start Code Change ---- 03.09.2006 #335 maha
//function created maha 030906 called from of_ver_55_updates
string ls_sql

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02
//$<add> 04.03.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
gnv_appeondb.of_startqueue( )
//---------------------------- APPEON END ----------------------------

ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-1, 1,80,188001,1,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-1, 1,80,188001,20,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-2, 1,80,188002,30,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-3, 1,80,188003,32,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-4, 1,80,188004,40,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-5, 1,80,188005,50,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-6, 1,80,188006,60,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-7, 1,80,188007,70,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-8, 1,80,188008,80,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-9, 1,80,188009,90,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-10, 1,80,188010,100,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-11, 1,80,188011,105,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-12, 1,80,188012,106,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-13, 1,80,188013,107,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-14, 1,83,188014,1,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-15, 1,83,188015,10,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-16, 1,83,188016,20,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-17, 1,83,188017,30,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-18, 1,83,188018,40,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-19, 1,83,188019,50,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-20, 1,83,188020,60,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-21, 1,83,188021,70,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-22, 1,83,188022,80,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-23, 1,83,188023,90,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-24, 1,83,188024,100,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-25, 1,84,188025,10,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-26, 1,84,188026,20,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-27, 1,84,188027,30,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-28, 1,84,188028,40,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-29, 1,84,188029,50,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-30, 1,84,188030,60,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-31, 1,84,188031,70,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-32, 1,84,188032,80,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-33, 1,84,188033,90,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-34, 1,84,188034,100,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-35, 1,84,188035,110,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-36, 1,84,188036,120,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-27, 1,84,188037,130,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-28, 1,84,188038,140,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-39, 1,84,188039,150,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-40, 1,84,188040,160,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-41, 1,84,188041,170,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-42, 1,84,188042,180,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-43, 1,84,188043,190,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-44, 1,84,188044,200,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-45, 1,84,188045,201,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
//ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-46, 1,84,188046,220,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
//st_sql.text  = ls_sql
//execute immediate :ls_sql using sqlca;//030906 maha 
//commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-47, 1,82,188047,1,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-48, 1,82,188048,2,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-49, 1,82,188049,3,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-50, 1,82,188050,30,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-51, 1,82,188051,40,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-52, 1,82,188052,50,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-53, 1,82,188053,60,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-54, 1,82,188054,70,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-55, 1,82,188055,80,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-56, 1,82,188056,90,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-57, 1,82,188057,100,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-58, 1,82,188058,102,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-59, 1,82,188059,110,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-60, 1,82,188060,130,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-61, 1,82,18806,2132,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-62, 1,81,188062,1,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-63, 1,81,188063,150,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-64, 1,81,188064,1,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-65, 1,81,188065,10,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-66, 1,81,188066,20,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;
ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-67, 1,82,188067,302,'gp_id','N','N','N','N',1900,100,500,64,0,'E',1900,50,200,'N');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;

ls_sql = "update sys_fields sf,data_view_fields dvf set field_label = field_name where data_view_field_id < 0 and sf.field_id = dvf.field_id;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;

ls_sql = "update sys_tables set table_name = 'gp_partner_covering' where table_id = 82;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;

ls_sql = "update sys_fields set lookup_field = 'Y', lookup_type = 'Q' where field_id = 188062;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;

ls_sql = "update sys_fields set lookup_field = 'Y', lookup_type = 'C', lookup_code = 'Yes/No',lookup_field_name = 'Code' where field_id = 188063;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030906 maha 
commit using sqlca;

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-03
//$<add> 04.03.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
gnv_appeondb.of_commitqueue( )
//---------------------------- APPEON END ----------------------------

//ls_sql = "update sys_fields set field_name = '' where field_id = 188063;"
//st_sql.text  = ls_sql
//execute immediate :ls_sql using sqlca;//030906 maha 
//commit using sqlca;
//

return 1
end function

public function integer of_question_import (integer ai_ver);//Start Code Change ---- 05.09.2006 #433 maha new function

long cnt
string ls_file

select count(quest_id) into :cnt from question_lookup where quest_id > 200;

if cnt > 0 then return 1

dw_whatever.dataobject = "d_question_import"
dw_whatever.settransobject(sqlca)

ls_file = gs_dir_path + "intellicred\question_lookup_506.txt"
 if fileexists(ls_file) then
	debugbreak()
	dw_whatever.importfile( ls_file)
	dw_whatever.update()
end if


return 1
end function

public function integer of_caqh_fields ();


//license caqh status
of_execute("ALTER TABLE pd_license add caqh_lic_status numeric(10,0) null;")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (22,30100,384,'','caqh_lic_status', 'CAQH License Status',10,'N' ,10,'Y','C','CAQH License Status','Description');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-100, 1,4,30100,301,'CAQH License Status','N','N','N','N',1900,700,500,64,0,'E',1900,600,400,'N');")

//education graduate type
of_execute("ALTER TABLE pd_education add caqh_grad_type numeric(10,0) null;")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (8,30101,321,'','caqh_grad_type', 'CAQH Graduate Type',10,'N' ,10,'Y','C','Graduate Type','Description');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-101, 1,6,30101,302,'CAQH Graduate Type','N','N','N','N',1900,700,500,64,0,'E',1900,600,400,'N');")
//good to here
//CPR type, expiration date,  lookup table  set as multi record
of_execute("ALTER TABLE pd_cpr_certifiation add cert_type numeric(10,0) null;")
of_execute("ALTER TABLE pd_cpr_certifiation add expiration_date timestamp null;")
of_execute("update data_view_screen set multi_record = 'Y' where screen_id = ;")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (5,30103,384,'','cert_type', 'CPR Certification Type',10,'D' ,10,'Y','C','CPR Type','Description');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-102, 1,24,30103,301,'CPR Type','N','N','N','N',1900,700,400,64,0,'E',1900,600,500,'N');")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len) values (5,30104,383,'mm/dd/yyyy','expiration_date', 'Expiration Date',10,'D' ,10);")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-103, 1,24,30104,302,'Expiration Date','N','N','N','N',1900,1000,500,64,0,'E',1900,800,500,'N');")

of_execute("ALTER TABLE pd_cpr_certifiation add certified numeric(10,0) null;")

//Address: Corp name; send correcpondence here (y/n);  primary tax id (which);
//of_execute("ALTER TABLE pd_address add corporate_name varchar(100) null;")
//of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len) values (20,30105,383,'','corporate_name', 'Corporate Name',100,'C' ,25);")
//of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-104, 1,2,30105,500,'Corporate Name','N','N','N','N',66,3912,500,64,0,'E',66,3840,600,'N');")

//address: 27/7 coverage (y/n); type (lookup); after_hours_num (miip)

//of_execute("ALTER TABLE pd_address add after_hours_number varchar(15) null;")
//of_execute("ALTER TABLE pd_address add after_hours_type numeric(10,0) null;")
//of_execute("ALTER TABLE pd_address add after_hours_coverage numeric(10,0) null;")
//of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len) values (20,30106,393,'','after_hours_number', 'After Hours Number',15,'C' ,15);")
//of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-105, 1,2,30106,501,'After Hours Number','N','N','N','N',66,3476,500,64,0,'E',66,3400,500,'N');")
//of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (20,30107,394,'','after_hours_type', 'After Hours Type',10,'N' ,10 ,'Y','C','After Hours Type','Description');")
//of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-106, 1,2,30107,502,'After Hours Type','N','N','N','N',780,3476,500,64,0,'E',780,3400,400,'N');")
//of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (20,30108,395,'','after_hours_coverage', 'After Hours Coverage',10, 'N' ,10,'Y','C','Yes/No','Description');")
//of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-107, 1,2,30108,503,'After Hours Coverage','N','N','N','N',1740,3476,500,64,0,'E',1740,3400,400,'N');")


//dea issue date
of_execute("ALTER TABLE pd_dea_state_csr add issue_date timestamp null;")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (6,30109,395,'mm/dd/yyyy','issue_date', 'Issue Date',10, 'D' ,10,'','','','');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-108, 1,5,30109,503,'Issue Date','N','N','N','N',1900,700,400,64,0,'E',1900,600,400,'N');")

//basic info
of_execute("Alter table pd_basic add used_another_name numeric(10,0) null;" )
of_execute("Alter table pd_basic add start_another_name timestamp null;" )
of_execute("Alter table pd_basic add end_another_name timestamp null;" )
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (25,30110,391,'','used_another_name', 'Used Another Name',10, 'N' ,10,'Y','C','Yes/No','Description');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-110, 1,1,30110,503,'Used Another Name','N','N','N','N',54,2000,500,64,0,'E',54,1900,600,'N');")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (25,30111,392,'mm/dd/yyyy','start_another_name', 'Started Using Another Name',10, 'D' ,10,'','','','');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-111, 1,1,30111,504,'Started Using Another Name','N','N','N','N',730,2000,500,64,0,'E',730,1900,600,'N');")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (25,30112,393,'mm/dd/yyyy','end_another_name', 'Stopped Using Another Name',10, 'D' ,10,'','','','');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-112, 1,1,30112,505,'Stopped Using Another Name','N','N','N','N',1206,2000,500,64,0,'E',1206,1900,600,'N');")

 
 
//other id lookups

//specialty
of_execute("Alter table pd_board_specialty add not_certified_reason numeric(10,0) null;" )
of_execute("Alter table pd_board_specialty add exam_date timestamp null;" )
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (2,30114,391,'','not_certified_reason', 'Not Certified Reason',10, 'N' ,10,'Y','C','Not Cert Reason','Description');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-114, 1,19,30114,503,'Not Certified Reason','N','N','N','N',103,1144,500,64,0,'E',103,1075,500,'N');")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (2,30115,392,'mm/dd/yyyy','exam_date', 'Exam Date',10, 'D' ,10,'','','','');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-115, 1,19,30115,504,'Exam Date','N','N','N','N',863,1144,500,64,0,'E',863,1075,500,'N');")

// address contact method
//of_execute("ALTER TABLE pd_address add prefered_contact_method numeric(10,0) null;")
of_execute("ALTER TABLE pd_address add send_corresp_here numeric(10,0) null;")
//of_execute("ALTER TABLE pd_address add primary_tax_id numeric(10,0) null;")
//of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (20,30116,391,'','prefered_contact_method', 'Prefered Contact Method',10, 'N' ,10,'Y','C','Prefered Contact Method','Description');")
//of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-116, 1,2,30116,503,'Prefered Contact Method','N','N','N','N',66,3680,500,64,0,'E',66,3600,500,'N');")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (20,30117,391,'','send_corresp_here', 'Send Corresp Here',10, 'N' ,10,'Y','C','Yes/No','Description');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-117, 1,2,30117,504,'Send Corresp Here','N','N','N','N',780,3680,500,64,0,'E',780,3600,500,'N');")
//of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (20,30118,391,'','primary_tax_id', 'Primary Tax Id',10, 'N' ,10,'Y','C','Tax Id Prefered','Description');")
//of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-118, 1,2,30118,505,'Primary Tax Id','N','N','N','N',1740,3680,500,64,0,'E',1740,3600,500,'N');")

//hospital
of_execute("ALTER TABLE pd_hosp_affil add unrestricted_privs numeric(10,0) null;")
of_execute("ALTER TABLE pd_hosp_affil add pctg_admissions integer null;")
of_execute("ALTER TABLE pd_hosp_affil add dept_director varchar(50) null;")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (9,30119,391,'','unrestricted_privs', 'Unrestricted Privileges',10, 'N' ,10,'Y','C','Yes/No','Description');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-119, 1,10,30119,503,'Unrestricted Privileges','N','N','N','N',112,1128,500,64,0,'E',112,1050,500,'N');")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (9,30120,392,'','pctg_admissions', 'Pctg Admissions this Hospital',10, 'N' ,10,'','','','');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-120, 1,10,30120,504,'Pctg Admissions this Hospital','N','N','N','N',662,1128,500,64,0,'E',662,1050,500,'N');")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (9,30121,393,'','dept_director', 'Department Director',10, 'C' ,10,'','','','');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-121, 1,10,30121,505,'Department Director','N','N','N','N',1304,1128,500,64,0,'E',1304,1050,500,'N');")



//insurance
of_execute("Alter table pd_insurance add org_issue_date timestamp null;" )
of_execute("Alter table pd_insurance add self_insured numeric(10,0) null;" )
of_execute("Alter table pd_insurance add shared_individ numeric(10,0) null;" )
of_execute("Alter table pd_insurance add coverage_unlimited numeric(10,0) null;" )
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (10,30122,391,'mm/dd/yyyy','org_issue_date', 'Org Issue Date',10, 'D' ,10,'','','','');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-122, 1,15,30122,501,'Org Issue Date','N','N','N','N',104,1310,500,64,0,'E',104,1230,500,'N');")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (10,30123,392,'','self_insured', 'Self Insured',10, 'N' ,10,'Y','C','Yes/No','Description');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-123, 1,15,30123,502,'Self Insured','N','N','N','N',622,1310,500,64,0,'E',622,1230,500,'N');")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (10,30124,393,'','shared_individ', 'Shared/Indv Coverage',10, 'N' ,10,'Y','C','Insurance Share Type','Description');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-124, 1,15,30124,503,'Shared/Indv Coverage','N','N','N','N',1136,1310,500,64,0,'E',1136,1230,500,'N');")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (10,30125,394,'','coverage_unlimited', 'Coverage Unlimited',10, 'N' ,10,'Y','C','Yes/No','Description');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-125, 1,15,30125,504,'Coverage Unlimited','N','N','N','N',1653,1310,500,64,0,'E',1653,1230,500,'N');")

// work gap
of_execute("Create TABLE pd_work_gap ( rec_id numeric(10,0) not null, prac_id numeric(10,0) not null, start_date timestamp null, end_date timestamp null, reason_code numeric(10,0) null, gap_type numeric(10,0) null, gap_reason varchar(255) null,     primary key (rec_id));")
of_verif_rule_add(55,"DE",1)
of_execute("INSERT INTO sys_tables (table_id,table_name,table_name_allias,profile_dw_name,facility_specific,ver_ltr_sql,exp_ltr_sql,is_required) VALUES (	55,	'pd_work_gap',	'Work Gap',	NULL,	0,	NULL,	NULL,	NULL);")
of_execute("INSERT INTO data_view_screen VALUES (	1,	55,	55,	'Work Gap',	'Y',	20203,	NULL,	NULL,	NULL,	55,	NULL,	NULL,	NULL,	'Work Gap',null);")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (55,30201,0,'','rec_id', 'rec_id',10, 'N' ,10,'','','','');")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (55,30202,0,'','prac_id', 'prac_id',10, 'N' ,10,'','','','');")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (55,30203,10,'mm/dd/yyyy','start_date', 'Start Date',10, 'D' ,10,'','','','');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-203, 1,55,30203,10,'Start Date','N','Y','N','N',66,124,500,64,0,'E',66,52,500,'Y');")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (55,30204,20,'mm/dd/yyyy','end_date', 'End Date',10, 'D' ,10,'','','','');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-204, 1,55,30204,20,'End Date','N','N','N','N',568,124,500,64,0,'E',568,52,500,'Y');")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (55,30205,30,'','reason_code', 'Reason Code',10, 'N' ,10,'Y','C','Gap Reason','Description');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-205, 1,55,30205,30,'Reason Code','N','N','N','N',66,320,500,64,0,'E',66,248,500,'Y');")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (55,30206,40,'','gap_type', 'Gap Type',10, 'N' ,10,'Y','C','Gap Type','Description');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-206, 1,55,30206,40,'Gap Type','N','N','N','N',568,320,500,64,0,'E',568,248,500,'Y');")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (55,30207,50,'','gap_reason', 'Gap Explaination',255, 'C' ,35,'','','','');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-207, 1,55,30207,50,'Gap Explaination','N','N','N','N',66,524,2000,200,0,'E',66,452,500,'Y');")

//addr suite
of_execute("ALTER TABLE pd_address add suite_apart varchar(50) null;")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (20,30126,387,'','suite_apart', 'Suite/Apt No',100,'C' ,25,'','','','');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-126, 1,2,30126,500,'Suite/Apt No','N','N','N','N',66,4200,500,64,0,'E',66,4125,600,'N');")

//group partner
of_execute("ALTER TABLE gp_partner_covering add license_no varchar(25) null;")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len) values (82,188100,15,'','license_no', 'License No',100,'C' ,25);")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-70, 1,82,188100,500,'License Number','N','N','N','N',66,500,500,64,0,'E',66,600,600,'N');")

of_execute("ALTER TABLE gp_partner_covering add license_state numeric(10,0) null;")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len, lookup_field,lookup_type,lookup_code,lookup_field_name) values (82,188101,16,'','license_state', 'License State',100,'N' ,25,'Y','C','State','Description');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-71, 1,82,188101,500,'License State','N','N','N','N',66,500,500,64,0,'E',66,600,600,'N');")


//address hours
of_execute("alter table pd_address modify mon_from char(10);")
of_execute("alter table pd_address modify mon_to char(10);")
of_execute("alter table pd_address modify tue_from char(10);")
of_execute("alter table pd_address modify tue_to char(10);")
of_execute("alter table pd_address modify wed_from char(10);")
of_execute("alter table pd_address modify wed_to char(10);")
of_execute("alter table pd_address modify thu_from char(10);")
of_execute("alter table pd_address modify thu_to char(10);")
of_execute("alter table pd_address modify fri_from char(10);")
of_execute("alter table pd_address modify fri_to char(10);")
of_execute("alter table pd_address modify sat_from char(10);")
of_execute("alter table pd_address modify sat_to char(10);")
of_execute("alter table pd_address modify sun_from char(10);")
of_execute("alter table pd_address modify sun_to char(10);")
of_execute("alter table pd_address modify mon_from2 char(10);")
of_execute("alter table pd_address modify mon_to2 char(10);")
of_execute("alter table pd_address modify tue_from2 char(10);")
of_execute("alter table pd_address modify tue_to2 char(10);")
of_execute("alter table pd_address modify wed_from2 char(10);")
of_execute("alter table pd_address modify wed_to2 char(10);")
of_execute("alter table pd_address modify thu_from2 char(10);")
of_execute("alter table pd_address modify thu_to2 char(10);")
of_execute("alter table pd_address modify fri_from2 char(10);")
of_execute("alter table pd_address modify fri_to2 char(10);")
of_execute("alter table pd_address modify sat_from2 char(10);")
of_execute("alter table pd_address modify sat_to2 char(10);")
of_execute("alter table pd_address modify sun_from2 char(10);")
of_execute("alter table pd_address modify sun_to2 char(10);")
//group_practice_hours
of_execute("alter table group_practice modify mon_from char(10);")
of_execute("alter table group_practice modify mon_to char(10);")
of_execute("alter table group_practice modify tue_from char(10);")
of_execute("alter table group_practice modify tue_to char(10);")
of_execute("alter table group_practice modify wed_from char(10);")
of_execute("alter table group_practice modify wed_to char(10);")
of_execute("alter table group_practice modify thu_from char(10);")
of_execute("alter table group_practice modify thu_to char(10);")
of_execute("alter table group_practice modify fri_from char(10);")
of_execute("alter table group_practice modify fri_to char(10);")
of_execute("alter table group_practice modify sat_from char(10);")
of_execute("alter table group_practice modify sat_to char(10);")
of_execute("alter table group_practice modify sun_from char(10);")
of_execute("alter table group_practice modify sun_to char(10);")
of_execute("alter table group_practice modify mon_from2 char(10);")
of_execute("alter table group_practice modify mon_to2 char(10);")
of_execute("alter table group_practice modify tue_from2 char(10);")
of_execute("alter table group_practice modify tue_to2 char(10);")
of_execute("alter table group_practice modify wed_from2 char(10);")
of_execute("alter table group_practice modify wed_to2 char(10);")
of_execute("alter table group_practice modify thu_from2 char(10);")
of_execute("alter table group_practice modify thu_to2 char(10);")
of_execute("alter table group_practice modify fri_from2 char(10);")
of_execute("alter table group_practice modify fri_to2 char(10);")
of_execute("alter table group_practice modify sat_from2 char(10);")
of_execute("alter table group_practice modify sat_to2 char(10);")
of_execute("alter table group_practice modify sun_from2 char(10);")
of_execute("alter table group_practice modify sun_to2 char(10);")

of_execute("update sys_fields set field_len = 10 where field_id >= 406 and field_id <= 433;")

//tested to here
//good to here

//practice info data screen
of_execute("Create table gp_practice_info ( rec_id numeric(10,0) not null, prac_id numeric(10,0) not null, start_date timestamp null, check_payable varchar(40) null, gender_limitations numeric(10,0) null, min_age integer null, max_age integer null, billing_dept varchar(40) , other_limitations varchar(255) null, cust_1 varchar(150) null,cust_2 varchar(150) null, cust_3 varchar(150) null, cust_4 varchar(150) null, cust_5 varchar(150) null,cust_d1 timestamp null, cust_d2 timestamp null, primary key (rec_id));")



of_execute("INSERT INTO sys_tables (table_id,table_name,table_name_allias,profile_dw_name,facility_specific,ver_ltr_sql,exp_ltr_sql,is_required) VALUES (	85,	'gp_practice_info',	' Group Practice Information',	NULL,	0,	NULL,	NULL,	NULL);")
of_execute("INSERT INTO data_view_screen VALUES (	1,	85,	85,	'Group Practice Information',	'N',	null,	NULL,	NULL,	NULL,	85,	NULL,	NULL,	NULL,	'Group Practice Information',null);")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (85,30250,0,'','rec_id', 'rec_id',10, 'N' ,10,'','','','');")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (85,30251,0,'','prac_id', 'prac_id',10, 'N' ,10,'','','','');")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (85,30252,10,'mm/dd/yyyy','start_date', 'Start Date',10, 'D' ,10,'','','','');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-252, 1,85,30252,10,'Start Date','N','N','N','N',1776,144,500,56,0,'E',1776,70,500,'Y');")

of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (85,30253,10,'','check_payable', 'Check Payable to',40, 'C' ,40,'','','','');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-253, 1,85,30253,20,'Check Payable to','N','N','N','N',66,144,1000,64,0,'E',66,70,600,'Y');")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (85,30254,20,'','gender_limitations', 'Gender Limitations',10, 'N' ,10,'Y','C','Gender','Code');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-254, 1,85,30254,30,'Gender Limitations','N','N','N','N',66,300,500,64,0,'E',66,225,500,'Y');")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (85,30255,30,'','min_age', 'Minimum Age',10, 'I' ,10,'','','','');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-255, 1,85,30255,40,'Minimum Age','N','N','N','N',642,300,500,64,0,'E',642,225,500,'Y');")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (85,30256,40,'','max_age', 'Maximum Age',10, 'I' ,10,'','','','');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-256, 1,85,30256,50,'Maximum Age','N','N','N','N',1200,300,500,64,0,'E',1200,225,500,'Y');")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (85,30257,50,'','billing_dept', 'Billing Department',40, 'C' ,20,'','','','');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-257, 1,85,30257,60,'Billing Department','N','N','N','N',1200,144,500,64,0,'E',1200,70,500,'Y');")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (85,30258,60,'','other_limitations', 'Other Limitations',255, 'C' ,30,'','','','');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-258, 1,85,30258,70,'Other Limitations','N','N','N','N',66,500,2100,180,0,'E',66,425,600,'Y');")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (85,30259,70,'','cust_1', 'Custom 1',150, 'C' ,25,'','','','');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-259, 1,85,30259,80,'Custom 1','N','N','N','N',66,825,500,64,0,'E',66,750,500,'N');")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (85,30260,80,'','cust_2', 'Custom 2',150, 'C' ,25,'','','','');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-260, 1,85,30260,90,'Custom 2','N','N','N','N',950,825,500,64,0,'E',950,750,500,'N');")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (85,30261,90,'','cust_3', 'Custom 3',150, 'C' ,25,'','','','');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-261, 1,85,30261,100,'Custom 3','N','N','N','N',1753,825,500,64,0,'E',1753,750,500,'N');")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (85,30262,100,'','cust_4', 'Custom 4',150, 'C' ,25,'','','','');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-262, 1,85,30262,110,'Custom 4','N','N','N','N',66,1052,500,64,0,'E',66,980,500,'N');")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (85,30263,110,'','cust_5', 'Custom 5',150, 'C' ,25,'','','','');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-263, 1,85,30263,120,'Custom 5','N','N','N','N',950,1052,500,64,0,'E',950,980,500,'N');")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (85,30264,120,'mm/dd/yyyy','cust_d1', 'Custom Date 1',10, 'D' ,10,'','','','');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-264, 1,85,30264,130,'Custom Date 1','N','N','N','N',66,1272,500,64,0,'E',66,1200,500,'N');")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (85,30265,130,'mm/dd/yyyy','cust_d2', 'Custom Date 2',10, 'D' ,10,'','','','');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-265, 1,85,30265,140,'Custom Date 2','N','N','N','N',950,1272,500,64,0,'E',950,1200,500,'N');")

of_execute("ALTER TABLE gp_practice_info add prefered_contact_method numeric(10,0) null;")
//of_execute("ALTER TABLE gp_practice_info send_corresp_here numeric(10,0) null;")
of_execute("ALTER TABLE gp_practice_info add primary_tax_id numeric(10,0) null;")
of_execute("ALTER TABLE gp_practice_info add corporate_name varchar(100) null;")
of_execute("ALTER TABLE gp_practice_info add after_hours_number varchar(15) null;")
of_execute("ALTER TABLE gp_practice_info add after_hours_type numeric(10,0) null;")
of_execute("ALTER TABLE gp_practice_info add after_hours_coverage numeric(10,0) null;")
of_execute("ALTER TABLE gp_practice_info add gp_id numeric(10,0)  null;")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (85,30270,0,'','gp_id', 'gp_id',10, 'N' ,10,'','','','');")

of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len) values (85,30105,383,'','corporate_name', 'Corporate Name',100,'C' ,25);")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-104, 1,85,30105,500,'Corporate Name','N','N','N','N',66,3912,500,64,0,'E',66,3840,600,'N');")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len) values (85,30106,393,'','after_hours_number', 'After Hours Number',15,'C' ,15);")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-105, 1,85,30106,501,'After Hours Number','N','N','N','N',66,3476,500,64,0,'E',66,3400,500,'N');")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (85,30107,394,'','after_hours_type', 'After Hours Type',10,'N' ,10 ,'Y','C','After Hours Type','Description');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-106, 1,85,30107,502,'After Hours Type','N','N','N','N',780,3476,500,64,0,'E',780,3400,400,'N');")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (85,30108,395,'','after_hours_coverage', 'After Hours Coverage',10, 'N' ,10,'Y','C','Yes/No','Description');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-107, 1,85,30108,503,'After Hours Coverage','N','N','N','N',1740,3476,500,64,0,'E',1740,3400,400,'N');")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (85,30116,391,'','prefered_contact_method', 'Prefered Contact Method',10, 'N' ,10,'Y','C','Preferred Contact Method','Description');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-116, 1,85,30116,503,'Preferred Contact Method','N','N','N','N',66,3680,500,64,0,'E',66,3600,500,'N');")
//of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (85,30117,391,'','send_corresp_here', 'Send Corresp Here',10, 'N' ,10,'Y','C','Yes/No','Description');")
//of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-117, 1,85,30117,504,'Send Corresp Here','N','N','N','N',780,3680,500,64,0,'E',780,3600,500,'N');")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (85,30118,391,'','primary_tax_id', 'Primary Tax Id',10, 'N' ,10,'Y','C','Tax Id Preferred','Description');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-118, 1,85,30118,505,'Primary Tax Id','N','N','N','N',1740,3680,500,64,0,'E',1740,3600,500,'N');")




//practice questions
//of_execute("Create table pd_practice_quest ( rec_id numeric(10,0) not null, prac_id numeric(10,0) not null, question_id numeric(10,0) null, answer_val numeric(10,0) null, followup_1 varchar(50) , followup_2 varchar(150) null, cust_1 varchar(150) null, cust_d1 timestamp null, primary key (rec_id));")
//of_verif_rule_add(54,"DE",1)
//of_execute("INSERT INTO sys_tables (table_id,table_name,table_name_allias,profile_dw_name,facility_specific,ver_ltr_sql,exp_ltr_sql,is_required) VALUES (	54,	'pd_practice_quest',	'Practice Questions',	NULL,	0,	NULL,	NULL,	NULL);")
//of_execute("INSERT INTO data_view_screen VALUES (	1,	54,	54,	'Practice Questions',	'Y',	30273,	NULL,	NULL,	NULL,	54,	NULL,	NULL,	NULL,	'Practice Questions',null);")
//of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (54,30270,0,'','rec_id', 'rec_id',10, 'N' ,10,'','','','');")
//of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (54,30271,0,'','prac_id', 'prac_id',10, 'N' ,10,'','','','');")
//
//of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (54,30273,20,'','question_id', 'Question Id',10, 'N' ,10,'Y','Q','','');")
//of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-273, 1,54,30273,20,'Question Id','N','N','N','N',572,84,1900,64,0,'E',572,20,500,'Y');")
//
//of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (54,30274,30,'','answer_val', 'Answer',10, 'N' ,10,'Y','C','Question Answers','Description');")
//of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-274, 1,54,30274,30,'Answer','N','N','N','N',45,84,500,64,0,'E',45,20,500,'Y');")
//
//of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (54,30275,40,'','followup_1', 'Followup 1',50, 'C' ,25,'','','','');")
//of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-275, 1,54,30275,40,'Followup 1','N','N','N','N',572,238,900,64,0,'E',572,170,500,'Y');")
//
//
//of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (54,30277,60,'','cust_1', 'Custom 1',150, 'C' ,25,'','','','');")
//of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-277, 1,54,30277,60,'Custom 1','N','N','N','N',45,740,500,64,0,'E',45,640,500,'N');")
//
//of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (54,30278,120,'mm/dd/yyyy','cust_d1', 'Custom Date 1',10, 'D' ,10,'','','','');")
//of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-278, 1,54,30278,130,'Custom Date 1','N','N','N','N',384,740,500,64,0,'E',384,640,500,'N');")
//
//group questions
of_execute("ALTER TABLE gp_questions add follow_up varchar(50) null;")
of_execute("ALTER TABLE gp_questions add followup_2 varchar(50) null;")

of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len) values (81,30279,15,'','follow_up', 'Follow up',50,'C' ,25);")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-279, 1,81,30279,500,'Follow up','N','N','N','N',66,500,500,64,0,'E',66,600,600,'N');")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (81,30276,50,'','followup_2', 'Followup 2',50, 'C' ,25,'','','','');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-276, 1,81,30276,50,'Followup 2','N','N','N','N',1507,238,800,64,0,'E',1507,170,500,'Y');")


//claims
of_execute("Alter table pd_claims add carrier_lookup numeric(10,0) null;" )
of_execute("Alter table pd_claims add result_in_death numeric(10,0) null;" )
of_execute("Alter table pd_claims add case_included_npdb numeric(10,0) null;" )
of_execute("Alter table pd_claims add primary_defendant numeric(10,0) null;" )
of_execute("Alter table pd_claims add judgement_for numeric(10,0) null;" )
of_execute("Alter table pd_claims add resolution_method numeric(10,0) null;" )
of_execute("ALTER TABLE pd_claims add num_defendant integer null;")
of_execute("ALTER TABLE pd_claims add policy_num varchar(25) null;")

of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (24,30280,200,'','carrier_lookup', 'Carrier Lookup',10, 'N' ,10,'Y','A','Insurance Companies','Entity_Name');")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (24,30281,210,'','result_in_death', 'Claim Result in Death',10, 'N' ,10,'Y','C','Yes/No','Code');")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (24,30282,220,'','case_included_npdb', 'Is case with NPDB',10, 'N' ,10,'Y','C','Yes/No','Code');")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (24,30283,230,'','primary_defendant', 'Primary/Codefendant',10, 'N' ,10,'Y','C','Claim Defendant','Description');")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (24,30284,240,'','judgement_for', 'Judgement For',10, 'N' ,10,'Y','C','Claim Judgement','Description');")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (24,30285,250,'','resolution_method', 'Resolution Method',10, 'N' ,10,'Y','C','Claim Resolution Method','Description');")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (24,30286,260,'','num_defendant', 'Number of Defendants',10, 'N' ,10,'','','','');")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (24,30287,270,'','policy_num', 'Policy Number',10, 'C' ,10,'','','','');")

of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-280, 1,16,30280,300,'Carrier Lookup','N','N','N','N',70,2400,1200,64,0,'E',70,2325,600,'N');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-281, 1,16,30281,320,'Claim Result in Death','N','N','N','N',740,2600,500,64,0,'E',740,2525,600,'N');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-282, 1,16,30282,330,'Is case with NPDB','N','N','N','N',1400,2600,500,64,0,'E',1400,2525,600,'N');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-283, 1,16,30283,340,'Primary/Co-defendant','N','N','N','N',70,2800,500,64,0,'E',70,2725,600,'N');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-284, 1,16,30284,350,'Judgement For','N','N','N','N',2000,2800,500,64,0,'E',2000,2725,600,'N');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-285, 1,16,30285,360,'Resolution Method','N','N','N','N',1400,2800,500,64,0,'E',1400,2725,500,'N');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-286, 1,16,30286,370,'Number of Defendants','N','N','N','N',740,2800,500,64,0,'E',740,2725,600,'N');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-287, 1,16,30287,380,'Policy Number','N','N','N','N',70,2600,500,64,0,'E',70,2525,600,'N');")


//group pract info
of_execute("ALTER TABLE gp_practice_info add other_handi_access varchar(25)  null;")
of_execute("ALTER TABLE gp_practice_info add other_disability_service varchar(25)  null;")
of_execute("ALTER TABLE gp_practice_info add other_trans_access varchar(25)  null;")

of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (85,30290,300,'','other_handi_access', 'Other Handicap Access',10, 'C' ,8,'','','','');")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (85,30291,310,'','other_disability_service', 'Other Disability Service',10, 'C' ,8,'','','','');")
of_execute("Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len,lookup_field,lookup_type,lookup_code,lookup_field_name) values (85,30292,320,'','other_trans_access', 'Other Transportation Access',10, 'C' ,8,'','','','');")

of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-290, 1,85,30290,510,'Other Handicap Access','N','N','N','N',1740,3680,500,64,0,'E',1740,3600,500,'N');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-291, 1,85,30290,530,'Other Disability Service','N','N','N','N',1740,3680,500,64,0,'E',1740,3600,500,'N');")
of_execute("Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-292, 1,85,30292,550,'Other Transportation Access','N','N','N','N',1740,3680,500,64,0,'E',1740,3600,500,'N');")



//lookups
of_execute("insert into code_lookup (lookup_code, lookup_name, code, description,caqh_code) values (-200,'CAQH License Status','Active','Active',80);")
of_execute("insert into code_lookup (lookup_code, lookup_name, code, description,type) values (-201,'Graduate Type','US-CAND','US or Canadian','S');")
of_execute("insert into code_lookup (lookup_code, lookup_name, code, description,type) values (-202,'Graduate Type','NONUS-CAND','Non US or Canadian','S');")
of_execute("insert into code_lookup (lookup_code, lookup_name, code, description,type) values (-203,'Graduate Type','5thPath','5th Pathway','S');")
of_execute("insert into code_lookup (lookup_code, lookup_name, code, description,type) values (-204,'CPR Type','BLS','Basic Life Support','S');")
of_execute("insert into code_lookup (lookup_code, lookup_name, code, description,type) values (-205,'CPR Type','ACLS','Avanced Cardiac Life Support','S');")
of_execute("insert into code_lookup (lookup_code, lookup_name, code, description,type) values (-206,'CPR Type','NALS','Neonatal Advanced Life Support','S');")
of_execute("insert into code_lookup (lookup_code, lookup_name, code, description,type) values (-207,'CPR Type','ALSO','Advanced Life Support in OB','S');")
of_execute("insert into code_lookup (lookup_code, lookup_name, code, description,type) values (-208,'CPR Type','ATLS','Advanced Trauma Life Support','S');")
of_execute("insert into code_lookup (lookup_code, lookup_name, code, description,type) values (-209,'CPR Type','PALS','Pediatric Advanced Life Support','S');")
of_execute("insert into code_lookup (lookup_code, lookup_name, code, description,type) values (-210,'CPR Type','CPR','CPR','S');")
of_execute("insert into code_lookup (lookup_code, lookup_name, code, description) values (-211,'After Hours Type','AS','Answering Service');")
of_execute("insert into code_lookup (lookup_code, lookup_name, code, description) values (-212,'After Hours Type','VM','Voice Mail');")
of_execute("insert into code_lookup (lookup_code, lookup_name, code, description) values (-213,'After Hours Type','VMS','Voice Mail to call Service');")
of_execute("insert into code_lookup (lookup_code, lookup_name, code, description,type) values (-214,'Partner Covering','MID','Mid-level Practitioner','S');")
of_execute("insert into code_lookup (lookup_code, lookup_name, code, description,type) values (-215,'Partner Covering','OWNER','Owner','S');")
of_execute("insert into code_lookup (lookup_code, lookup_name, code, description,type) values (-216,'Other Document Type','USMIL','USMIL','S');")
of_execute("insert into code_lookup (lookup_code, lookup_name, code, description,type) values (-217,'Other Document Type','WCN','Workmans Comp Number','S');")
of_execute("insert into code_lookup (lookup_code, lookup_name, code, description,type) values (-218,'Not Cert Reason','PENDING','Exam Results Pending','S');")
of_execute("insert into code_lookup (lookup_code, lookup_name, code, description,type) values (-219,'Not Cert Reason','SITTING','Sitting for Exam','S');")
of_execute("insert into code_lookup (lookup_code, lookup_name, code, description,type) values (-220,'Not Cert Reason','NOT','Will Not Take Exam','S');")
of_execute("insert into code_lookup (lookup_code, lookup_name, code, description,type) values (-221,'Tax Id Preferred','INDV','Individual','S');")
of_execute("insert into code_lookup (lookup_code, lookup_name, code, description,type) values (-223,'Tax Id Preferred','Group','Group (Tax id other 1)','S');")
of_execute("insert into code_lookup (lookup_code, lookup_name, code, description,type) values (-224,'Preferred Contact Method','FAX','Fax','S');")
of_execute("insert into code_lookup (lookup_code, lookup_name, code, description,type) values (-225,'Preferred Contact Method','EMAIL','E-mail','S');")
of_execute("insert into code_lookup (lookup_code, lookup_name, code, description,type) values (-226,'Insurance Share Type','INDV','Individual','S');")
of_execute("insert into code_lookup (lookup_code, lookup_name, code, description,type) values (-227,'Insurance Share Type','SHARED','Shared','S');")
of_execute("insert into code_lookup (lookup_code, lookup_name, code, description,type) values (-228,'Other Document Type','FNIN','Foreign Identification Number','S');")
of_execute("insert into code_lookup (lookup_code, lookup_name, code, description,type) values (-230,'Gap Type','EDU','Education','S');")
of_execute("insert into code_lookup (lookup_code, lookup_name, code, description,type) values (-231,'Gap Type','TRA','Training','S');")
of_execute("insert into code_lookup (lookup_code, lookup_name, code, description,type) values (-232,'Gap Type','WORK','Work History','S');")
of_execute("insert into code_lookup (lookup_code, lookup_name, code, description,type) values (-233,'Gap Reason','ILL','Illness','S');")
of_execute("insert into code_lookup (lookup_code, lookup_name, code, description,type) values (-234,'Gap Reason','MAT','Maternity Leave','S');")
of_execute("insert into code_lookup (lookup_code, lookup_name, code, description,type) values (-235,'Gap Reason','SABB','Sabbatical','S');")
of_execute("update code_lookup set description = 'Covering not partner'  where lookup_code = 8002;")//maha 050506
of_execute("update code_lookup set description = 'Partner/Associate'  where lookup_code = 8000;")
of_execute("update code_lookup set code = 'OWNER' , description = 'Owner'  where lookup_code = 8001;")

of_execute("insert into code_lookup (lookup_code, lookup_name, code, description,type) values (-248,'Template Type','SERV','Services','S');")
of_execute("insert into code_lookup (lookup_code, lookup_name, code, description,type) values (-249,'Template Type','PRACT','Practice','S');")
of_execute("insert into code_lookup (lookup_code, lookup_name, code, description,type) values (-240,'Claim Defendant','PRIME','Primary','S');")
of_execute("insert into code_lookup (lookup_code, lookup_name, code, description,type) values (-241,'Claim Defendant','CO','Co-Defendant','S');")
of_execute("insert into code_lookup (lookup_code, lookup_name, code, description,type) values (-242,'Claim Judgement','PLANT','Plaintiff','S');")
of_execute("insert into code_lookup (lookup_code, lookup_name, code, description,type) values (-243,'Claim Judgement','DEF','Defendant','S');")
of_execute("insert into code_lookup (lookup_code, lookup_name, code, description,type) values (-244,'Claim Resolution Method','DIS','Dissmissed','S');")
of_execute("insert into code_lookup (lookup_code, lookup_name, code, description,type) values (-245,'Claim Resolution Method','SET','Settled','S');")
of_execute("insert into code_lookup (lookup_code, lookup_name, code, description,type) values (-246,'Claim Resolution Method','MED','Mediation','S');")
of_execute("insert into code_lookup (lookup_code, lookup_name, code, description,type) values (-247,'Claim Resolution Method','ARB','Arbitration','S');")







return 1
end function

public function integer of_execute (string as_sql);string ls_sql

ls_sql = as_sql
st_sql.text = ls_sql
//st_update.text = ls_sql  //Start Code Change ---- 02.01.2007 #V7 maha removed
execute immediate :ls_sql using sqlca;
commit using sqlca;

return 1
end function

public function integer of_updates_appeon1 ();
//////////////////////////////////////////////////////////////////////
// $<function>w_priv_update/of_updates_appeon1() called from ver_60
// $<arguments>
//		value	integer		
// $<returns> integer
// $<description> Database Modification since Web migration.
// $<description> Support both ASA and SQL Server database updates.
//////////////////////////////////////////////////////////////////////
// $<add> 2006-09-11 by Rodger Wu
//////////////////////////////////////////////////////////////////////

n_ds ds_roles, lds_rolerights
Integer li_rows, i
Long ll_roleid, ll_maxid, ll_found, ll_temp
String ls_sql, ls_new_syntax, ls_error

of_execute( "Alter table icred_settings add downloadurl varchar(255) null;" )

//Three new tables used for storing word templates and images into database.
of_execute( "create table sys_storage_area ( area_id		integer		not null, area_name	varchar(30)	null, area_doc_path	varchar(150)	null, area_desc	varchar(150)	null, primary key(Area_id) );" )
of_execute( "create table sys_storage_docs ( area_id		integer		not null, doc_name	varchar(75)	not null, doc_type	varchar(1)		null,	doc_data	image		null, last_edit_date	datetime	null, user_id		varchar(10)	null, primary key(area_id, doc_name) );" )
of_execute( "create table app_blob ( app_id		numeric (10,0)	not null, app_image	image		null, primary key(app_id) );" )

//Four new records used for the role rights of Letter Storage Area Painter.
of_execute( "insert security_modules( module_id, software_version, module_name) values( 51, 4, 'Letter Storage Area Painter' ); " )
of_execute( "insert security_sub_module( sub_module_id, module_id, sub_module_name ) values( 510, 51, 'Main' );" )
of_execute( "insert security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 5010, 51, 510, 'View Rights', 2 );" )

//Fix a defect that no rights data for Question Painter.
of_execute( "insert security_modules( module_id, software_version, module_name) values( 34, 4, 'Question Painter' ); " )
of_execute( "insert security_sub_module( sub_module_id, module_id, sub_module_name ) values( 420, 34, 'Main' );" )
of_execute( "insert security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 2210, 34, 420, 'Access Rights', 1 );" )

//Liangqingshi on Oct 24, 2006 - for Inova additional requirement;
of_execute( "insert security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 5820, 1, 1, 'Print/Export Search Results', 1 );" )

ds_roles = create n_ds
ds_roles.dataobject = "d_roles"
ds_roles.SetTransObject( SQLCA )

lds_rolerights = CREATE n_ds
ls_sql = "select security_roles_rights.role_id, security_roles_rights.action_id from security_roles_rights "
ls_new_syntax = SQLCA.SyntaxFromSQL( ls_sql, "", ls_error )
lds_rolerights.Create( ls_new_syntax, ls_error )
lds_rolerights.SetTransObject(SQLCA)

gnv_appeondb.of_startqueue()
ds_roles.Retrieve()
lds_rolerights.Retrieve()
SELECT max( rights_id ) INTO :ll_maxid FROM security_roles_rights;
SELECT top 1 rights_id INTO :ll_temp FROM ids;
gnv_appeondb.of_commitqueue()

li_rows = lds_rolerights.rowcount()
if li_rows > 0 then
	
	IF ISNULL( ll_maxid ) THEN ll_maxid = 0;
	if isnull( ll_temp ) then ll_temp = 0
	if ll_temp > ll_maxid then ll_maxid = ll_temp;

	li_rows = ds_roles.Rowcount()

	For i = 1 to li_rows
		ll_roleid = ds_roles.GetItemNumber( i, "role_id" )
		
		ll_found = lds_rolerights.Find( "role_id = " + string( ll_roleid ) + " and action_id = 5010", 1, lds_rolerights.rowcount() )
		IF ll_found < 1 THEN
			ll_maxid ++
			of_execute( "insert security_roles_rights( rights_id, role_id, action_id, value_id ) values( " + string( ll_maxid ) +  ", " + string( ll_roleid ) + ", 5010, 2);" )
		END IF
	
		ll_found = lds_rolerights.Find( "role_id = " + string( ll_roleid ) + " and action_id = 2210", 1, lds_rolerights.rowcount() )
		IF ll_found < 1 THEN
			ll_maxid ++
			of_execute( "insert security_roles_rights( rights_id, role_id, action_id, value_id ) values( " + string( ll_maxid ) +  ", " + string( ll_roleid ) + ", 2210, 1);" )
		END IF
		
		//Liangqingshi on Oct 24, 2006 - for Inova additional requirement;
		ll_found = lds_rolerights.Find( "role_id = " + string( ll_roleid ) + " and action_id = 5820", 1, lds_rolerights.rowcount() )
		IF ll_found < 1 THEN
			ll_maxid ++
			of_execute( "insert security_roles_rights( rights_id, role_id, action_id, value_id ) values( " + string( ll_maxid ) +  ", " + string( ll_roleid ) + ", 5820, 1);" )
		END IF
		
	Next
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 01.27.2007 By: Jack (Document Manager)
	//$<reason> Fix a defect.
	UPDATE ids SET rights_id = :ll_maxid;	
	//---------------------------- APPEON END ----------------------------
end if

Destroy( ds_roles );
Destroy( lds_rolerights );

//Alter table app_blob. Leiwei on Sept 12, 2006.
of_execute( "alter table app_blob add modify_date datetime null; " )
of_execute( "update app_blob set modify_date = getdate() where modify_date is null; " )

//Liuhongxing on Sept 15, 2006.
IF gs_dbtype = "SQL" THEN
	of_execute( "ALTER TABLE conv_view_where ALTER COLUMN table_field_name varchar(255) NOT NULL; " )
ELSE
	of_execute( "ALTER TABLE conv_view_where MODIFY table_field_name varchar(255) NOT NULL; " )
END IF

//Rodger Wu added for fixing a bug of IntelliReport, 11:40AM Sept 22, 2006
IF gs_dbtype = "SQL" THEN
	of_execute( "ALTER TABLE conv_view_fields ALTER COLUMN field_x numeric( 5, 0); " )
ELSE
	of_execute( "ALTER TABLE conv_view_fields MODIFY field_x numeric( 5, 0); " )
END IF

//Leiwei on Sept 20, 2006
of_execute( "Update security_modules set prod_id = 1 where module_id = 51; " )
of_execute( "Update security_sub_module set prod_id = 1 where module_id = 51; " )

//Leiwei on Sept 21, 2006
of_execute( "Update code_lookup set custom_1 = code where lookup_name = 'Contract Action Type' and ( custom_1 is null or custom_1 = '' ); " )

//Leiwei on Sept 27, 2006
of_execute( "ALTER TABLE pd_images ADD modify_date datetime null; " )
of_execute( "UPDATE pd_images SET modify_date = getdate() WHERE modify_date is null; " )

//Liuhongxing on Sept 27, 2006
IF gs_dbtype = "ASA" THEN
	of_execute( "ALTER TABLE CTX_FEE_SCHED_LOCATIONS DROP FOREIGN KEY fk_ctx_fee__reference_code_loo_location; " )
ELSE
	of_execute( "ALTER TABLE CTX_FEE_SCHED_LOCATIONS DROP CONSTRAINT FK_CTX_FEE__LOCATIONS_CODE_LOO; " )
END IF

//Leiwei on Oct 08, 2006
of_execute( "INSERT INTO sys_lookup( lookup_name ) VALUES ('Contract Fee Basis'); " )

//Leiwei on Oct 12, 2006
of_execute( "Alter table security_users add image_flag char(1) null; " )

//Liangqingshi on Oct 12, 2006 - for Inova additional requirement
of_execute( "Alter table pd_images add de_queue integer null; " )

//Liangqingshi on Oct 16, 2006 - for Inova additional requirement;
of_execute( "create table  pd_app_audit_temp ( " + &
"record_id            numeric(10)          not null, " + &
"prac_id              numeric(6)           not null, " + &
"facility_id          integer              not null, " + &
"seq_no               integer              not null, " + &
"app_audit_id         integer              not null, " + &
"completed            varchar(1)              null, " + &
"fax_message           varchar(255)         null, " + &
"active_status        integer              null, " + &
"date_completed       datetime             null, " + &
"data_status          numeric(6)           null, " + &
"notes                varchar(255)         null, " + &
"identifying_number    varchar(50)          null, " + &
"appt_stat_id         numeric(12)          null, " + &
"conv_prac_id          varchar(20)          null, " + &
"de_rec_id             numeric (10,0) null, " + &
"primary key  (record_id)); " )

//Leiwei on Oct 16, 2006
of_execute( "Update security_users set image_flag= '0' Where image_flag is null; " )

//Liangqingshi on Oct 17, 2006 - for Inova additional requirement;
of_execute( "alter table pd_app_audit add description varchar(255) null; " )
of_execute( "alter table pd_app_audit_temp add description varchar(255) null; " )
of_execute( "alter table pd_app_audit add app_type varchar(1) null; " )
of_execute( "alter table pd_app_audit_temp add app_type varchar(1) null; " )

Return 1;
end function

public function integer of_updates_appeon2 ();//Start Code Change ---- 10.31.2006 #1 maha removed: reports should not be added this way.


//////////////////////////////////////////////////////////////////////
// $<function>w_priv_update/of_updates_appeon2() called from ver_60
// $<arguments>
//		value	integer		
// $<returns> integer
// $<description> Add five contract reports for Contract module.
// $<description> Support both ASA and SQL Server database updates.
//////////////////////////////////////////////////////////////////////
// $<add> 2006-07-28 by Rodger Wu (Contract)
//////////////////////////////////////////////////////////////////////

long ll_max_rpt_id

//of_execute( "delete from sys_report_wizard where sys_report_wizard.report_id in ( select sys_reports.report_id from sys_reports where sys_reports.report_name in ( 'Contract List Report', 'Contracts Needing Reviewed Report', 'Expiring Contracts Report', 'Fee Schedule List Report', 'Contract Analysis Reporting' ) and sys_reports.category = 'Contract' and sys_reports.r_type = 'X'); " )
//of_execute( "delete from sys_reports where report_name in ( 'Contract List Report', 'Contracts Needing Reviewed Report', 'Expiring Contracts Report', 'Fee Schedule List Report', 'Contract Analysis Reporting' ) and category = 'Contract' and r_type = 'X'; " )

//select max(report_id) into :ll_max_rpt_id from sys_reports;
//if ll_max_rpt_id = 0 or isnull(ll_max_rpt_id ) then 
//	ll_max_rpt_id = 1
//else 
//	ll_max_rpt_id++
//end if

//Start Code Change ---- 10.31.2006 #1 maha reports should not be added this way
////1. Contract List Report.
//of_execute( "INSERT INTO sys_reports ( report_id,report_name, report_description,  report_dw,graph_dw, criteria_dw, category, r_type) VALUES (" + string(ll_max_rpt_id) + ", 'Contract List Report',   'A general contract listing of all reports in the system',   'd_rpt_ctx_contractlist_byowner',   '',   '', 'Contract',   'X' )" )
//of_execute( "INSERT INTO sys_report_wizard (report_id,wizard_seq_no, wizard_dw, wizard_last_step, help_text, insert_blank_row,multi_select ) VALUES (" + string(ll_max_rpt_id) + ", 1, 'd_rpt_ctx_wiz_grouping1', 'N', 'Specify Grouping Way', 'N', 'N' )" )
//of_execute( "INSERT INTO sys_report_wizard (report_id,wizard_seq_no, wizard_dw, wizard_last_step, help_text, insert_blank_row,multi_select ) VALUES (" + string(ll_max_rpt_id) + ", 2, 'd_rpt_ctx_wiz_status1', 'N', 'Select Contract Status', 'Y', 'Y' )" )
//of_execute( "INSERT INTO sys_report_wizard (report_id,wizard_seq_no, wizard_dw, wizard_last_step, help_text, insert_blank_row,multi_select ) VALUES (" + string(ll_max_rpt_id) + ", 3, 'd_rpt_ctx_wiz_owner1', 'Y', 'Select Contract Owner', 'Y', 'Y' )" )
//
////2. Contracts Needing Reviewed Report
//ll_max_rpt_id ++;
//of_execute( "INSERT INTO sys_reports ( report_id,report_name, report_description,  report_dw,graph_dw, criteria_dw, category, r_type) VALUES (" + string(ll_max_rpt_id) + ", 'Contracts Needing Reviewed Report',   'This report will allow users to determine what contracts are up for review.',   'd_rpt_ctx_needreview_byowner',   '',   '', 'Contract',   'X' )" )
//of_execute( "INSERT INTO sys_report_wizard (report_id,wizard_seq_no, wizard_dw, wizard_last_step, help_text, insert_blank_row,multi_select ) VALUES (" + string(ll_max_rpt_id) + ", 1, 'd_rpt_ctx_wiz_grouping2', 'N', 'Specify Grouping Way', 'N', 'N' )" )
//of_execute( "INSERT INTO sys_report_wizard (report_id,wizard_seq_no, wizard_dw, wizard_last_step, help_text, insert_blank_row,multi_select ) VALUES (" + string(ll_max_rpt_id) + ", 2, 'd_rpt_ctx_wiz_status1', 'N', 'Select Contract Status', 'Y', 'Y' )" )
//of_execute( "INSERT INTO sys_report_wizard (report_id,wizard_seq_no, wizard_dw, wizard_last_step, help_text, insert_blank_row,multi_select ) VALUES (" + string(ll_max_rpt_id) + ", 3, 'd_rpt_ctx_wiz_owner1', 'N', 'Select Contract Owner', 'Y', 'Y' )" )
//of_execute( "INSERT INTO sys_report_wizard (report_id,wizard_seq_no, wizard_dw, wizard_last_step, help_text, insert_blank_row,multi_select ) VALUES (" + string(ll_max_rpt_id) + ", 4, 'd_rpt_ctx_wiz_days', 'Y', 'Days Until Review', 'N', 'N' )" )
//
////3. Expiring Contracts Report
//ll_max_rpt_id ++;
//of_execute( "INSERT INTO sys_reports ( report_id,report_name, report_description,  report_dw,graph_dw, criteria_dw, category, r_type) VALUES (" + string(ll_max_rpt_id) + ", 'Expiring Contracts Report',   'This report will allow users to determine what contracts are expiring.',   'd_rpt_ctx_expiring_byowner',   '',   '', 'Contract',   'X' )" )
//of_execute( "INSERT INTO sys_report_wizard (report_id,wizard_seq_no, wizard_dw, wizard_last_step, help_text, insert_blank_row,multi_select ) VALUES (" + string(ll_max_rpt_id) + ", 1, 'd_rpt_ctx_wiz_grouping2', 'N', 'Specify Grouping Way', 'N', 'N' )" )
//of_execute( "INSERT INTO sys_report_wizard (report_id,wizard_seq_no, wizard_dw, wizard_last_step, help_text, insert_blank_row,multi_select ) VALUES (" + string(ll_max_rpt_id) + ", 2, 'd_rpt_ctx_wiz_status1', 'N', 'Select Contract Status', 'Y', 'Y' )" )
//of_execute( "INSERT INTO sys_report_wizard (report_id,wizard_seq_no, wizard_dw, wizard_last_step, help_text, insert_blank_row,multi_select ) VALUES (" + string(ll_max_rpt_id) + ", 3, 'd_rpt_ctx_wiz_owner1', 'N', 'Select Contract Owner', 'Y', 'Y' )" )
//of_execute( "INSERT INTO sys_report_wizard (report_id,wizard_seq_no, wizard_dw, wizard_last_step, help_text, insert_blank_row,multi_select ) VALUES (" + string(ll_max_rpt_id) + ", 4, 'd_rpt_ctx_wiz_days', 'Y', 'Days Until Expiration', 'N', 'N' )" )
//
////4. Fee Schedule List Report
//ll_max_rpt_id ++;
//of_execute( "INSERT INTO sys_reports ( report_id,report_name, report_description,  report_dw,graph_dw, criteria_dw, category, r_type) VALUES (" + string(ll_max_rpt_id) + ", 'Fee Schedule List Report',   'This report will be a list of fee schedules for specified items.',   'd_rpt_ctx_feeschedule',   '',   '', 'Contract',   'X' )" )
//of_execute( "INSERT INTO sys_report_wizard (report_id,wizard_seq_no, wizard_dw, wizard_last_step, help_text, insert_blank_row,multi_select ) VALUES (" + string(ll_max_rpt_id) + ", 1, 'd_crit_date_range', 'N', 'Select a Date Range', 'Y', 'N' )" )
//of_execute( "INSERT INTO sys_report_wizard (report_id,wizard_seq_no, wizard_dw, wizard_last_step, help_text, insert_blank_row,multi_select ) VALUES (" + string(ll_max_rpt_id) + ", 2, 'd_rpt_ctx_wiz_category1', 'N', 'Select Contract Category', 'Y', 'Y' )" )
//of_execute( "INSERT INTO sys_report_wizard (report_id,wizard_seq_no, wizard_dw, wizard_last_step, help_text, insert_blank_row,multi_select ) VALUES (" + string(ll_max_rpt_id) + ", 3, 'd_rpt_ctx_wiz_service1', 'N', 'Select Service Item', 'Y', 'Y' )" )
//of_execute( "INSERT INTO sys_report_wizard (report_id,wizard_seq_no, wizard_dw, wizard_last_step, help_text, insert_blank_row,multi_select ) VALUES (" + string(ll_max_rpt_id) + ", 4, 'd_rpt_ctx_wiz_status1', 'Y', 'Select Contract Status', 'Y', 'Y' )" )
//
////5. Contract Analysis Reporting
//ll_max_rpt_id ++;
//of_execute( "INSERT INTO sys_reports ( report_id,report_name, report_description,  report_dw,graph_dw, criteria_dw, category, r_type) VALUES (" + string(ll_max_rpt_id) + ", 'Contract Analysis Reporting',   'The contract analysis tab will be used to compare multiple payer contract CPT codes so that a user can determine which payers are paying the highest and lowest per CPT code.',   'd_rpt_ctx_analysis',   '',   '', 'Contract',   'X' )" )
//of_execute( "INSERT INTO sys_report_wizard (report_id,wizard_seq_no, wizard_dw, wizard_last_step, help_text, insert_blank_row,multi_select ) VALUES (" + string(ll_max_rpt_id) + ", 1, 'd_rpt_ctx_wiz_select', 'N', 'Select Contract(s)', 'N', 'Y' )" )
//of_execute( "INSERT INTO sys_report_wizard (report_id,wizard_seq_no, wizard_dw, wizard_last_step, help_text, insert_blank_row,multi_select ) VALUES (" + string(ll_max_rpt_id) + ", 2, 'd_rpt_ctx_wiz_select_cptcode', 'N', 'Select CPT Code(s)', 'N', 'Y' )" )
//of_execute( "INSERT INTO sys_report_wizard (report_id,wizard_seq_no, wizard_dw, wizard_last_step, help_text, insert_blank_row,multi_select ) VALUES (" + string(ll_max_rpt_id) + ", 3, 'd_crit_date_range', 'Y', 'Select a Date Range', 'Y', 'N' )" )
//
Return 1;
end function

public function integer of_new_security ();//Start Code Change ---- 10.04.2006 #673 maha
//new function 100406 maha
integer cnt = -2
integer set36


//select count(*) into :cnt from security_settings where exp_days < 0;
select top 1 exp_days into :set36 from security_settings;

if cnt = -1 then //if the record exists but has not been reset
	select set_36 into :set36 from icred_settings;
	of_execute("update security_settings set exp_days = " + string(set36) + ";")
elseif cnt = -2 or isnull(cnt) then  //if no value
	of_execute("create table security_settings (exp_days integer not null, new_change_pw integer null, min_len integer null, must_have_num integer null, cant_use_last integer null, login_lockout integer null, lockout_min integer null, opt_1 integer null,opt_2 integer null, opt_3 integer null,opt_4 integer null, opt_5 integer null );")
	of_execute("insert into security_settings  (exp_days, new_change_pw, min_len, must_have_num, cant_use_last)  values(-1,0,0,0,0); ")
	select set_36 into :set36 from icred_settings;
	of_execute("update security_settings set exp_days = " + string(set36) + ";")
	
end if

return 1
end function

public function integer of_old_code (integer ai_ver);st_update.text  = ""
string ls_sql
string retr = "Privilege Status"
integer onecount
Integer li_Rc
Integer i
Long ll_lookup_code
integer ic
integer vi
integer viewid
long maxfield
long rch
integer f
integer rcf
long hosp_id
integer fac_id
integer prime
long prac_id
long nr
integer res
long cnt
long cnt2
long runcnt = 0
integer rc
datetime dte
long maxid
integer set_time = 0
string rpt_path
string wiz_path
integer li_ver
datetime ld_now

li_ver = ai_ver

if li_ver > 30 then //maha 072304 version 3 & 4.1 updates
	goto V31
end if
cnt = 0

if idt_lup < datetime(2002-03-28,now()) then 
sle_1.text = "Updating"

if FileExists( gs_dir_path + "intellicred\gpid dataview.txt" ) = false then
	messagebox("Unable to update Group practice dataview. ","Check to see that file gpid dataview.txt exists in the Intellicred folder.")
end if
if FileExists( gs_dir_path + "intellicred\priv status lookup.txt" ) = false then
	messagebox("Unable to update Group practice dataview. ","Check to see that file priv status lookup.txt exists in the Intellicred folder.")
end if

//*********************************************
cb_update.text = "Privileges"
st_update.text  = "Privileges"
//privileges
ls_sql = "CREATE TABLE priv_docs (rec_id	numeric(10,0) NOT NULL, facility_id 	integer NOT NULL, clinical_area_id 	numeric(10,0) NULL, word_doc_name varchar(250) NULL,PRIMARY KEY (rec_id))"
execute immediate :ls_sql using sqlca;
commit using sqlca;

ls_sql = "CREATE TABLE priv_clinical_area(clinical_area_id      	numeric(10,0) NOT NULL,	facility_id   		integer NOT NULL,	clinical_area_code    	char(15) NULL,	clinical_area_description     varchar(100) NOT NULL,	priv_qualifications   	long varchar NULL,	req_pre_exp   		long varchar NULL,	spec_procd    		long varchar NULL,PRIMARY KEY (clinical_area_id)	)"
execute immediate :ls_sql using sqlca;
commit using sqlca;

ls_sql = "CREATE TABLE priv_clinical_area2 (clinical_area_id      	integer NULL,observations  		long varchar NULL, reappoint_req 		long varchar NULL, PRIMARY KEY (clinical_area_id) )"
execute immediate :ls_sql using sqlca;
commit using sqlca;

ls_sql = "CREATE TABLE priv_core (priv_core_id  		numeric(8,0) NOT NULL,clinical_area_id      	numeric(10,0) NULL,priv_core_description 	varchar(100) NULL,PRIMARY KEY (priv_core_id))"
execute immediate :ls_sql using sqlca;
commit using sqlca;

ls_sql = "CREATE TABLE priv_core_procd (	procd_id      		numeric(8,0) NOT NULL,	priv_core_id  		numeric(8,0) NOT NULL,core_procd_description        long varchar NULL,sort_order    		integer NULL, procd_name    		varchar(50) NULL,	PRIMARY KEY (procd_id))"
execute immediate :ls_sql using sqlca;
commit using sqlca;

ls_sql = "CREATE TABLE priv_clinical_area_3 (clinical_area_id      	integer NULL,	custom1      		long varchar NULL,custom2       		long varchar NULL,custom1_label 		varchar(30) NULL,custom2_label 		varchar(30) NULL, PRIMARY KEY (clinical_area_id))"
execute immediate :ls_sql using sqlca;
commit using sqlca;

ls_sql = "CREATE TABLE pd_priv_list (	rec_id        		numeric(10,0) NOT NULL,facility_id   		integer NOT NULL,prac_id       		numeric(8,0) NOT NULL,clinical_area_id      	numeric(10,0) NOT NULL,	priv_core_id  		numeric(8,0) NOT NULL,procd_id      		numeric(8,0) NOT NULL,		start_date   		timestamp NULL,end_date      		timestamp NULL,status_code   		numeric(8,0) NULL,notes 			long varchar NULL,active_status 		integer NULL,priv_text     		long varchar NULL,ir_code       		integer NULL,enter_date    		timestamp NULL, PRIMARY KEY (rec_id))"
execute immediate :ls_sql using sqlca;
commit using sqlca;

ls_sql = "ALTER TABLE priv_docs ADD FOREIGN KEY fk_priv_docs_facility_id (facility_id) REFERENCES facility (facility_id); ALTER TABLE priv_core ADD FOREIGN KEY fk_priv_core_clinical_area_id (clinical_area_id) REFERENCES priv_clinical_area (clinical_area_id); ALTER TABLE priv_core_procd ADD FOREIGN KEY fk_priv_core_procd_priv_core_id (priv_core_id) REFERENCES priv_core (priv_core_id);"
execute immediate :ls_sql using sqlca;
commit using sqlca;

ls_sql = "ALTER TABLE priv_docs ADD FOREIGN KEY fk_priv_docs_clinical_area_id (clinical_area_id) REFERENCES priv_clinical_area (clinical_area_id);"
execute immediate :ls_sql using sqlca;
commit using sqlca;

ls_sql = "Alter table facility add prac_acknowledgement long varchar null;"
execute immediate :ls_sql using sqlca;
commit using sqlca;



dw_1.settransobject(sqlca)
onecount = dw_1.retrieve(retr)

if onecount < 1 then



dw_2.SetTransObject( SQLCA	)

li_rc = dw_2.ImportFile( gs_dir_path + "intellicred\priv status lookup.txt" )

if li_rc > 0 then
	
SELECT ids.lookup_code_id  
INTO :ll_lookup_code  
FROM ids;

FOR i = 1 TO li_rc
	ll_lookup_code++
	dw_2.SetItem( i, "lookup_code", ll_lookup_code )
END FOR	

UPDATE ids  
SET lookup_code_id = :ll_lookup_code ;

dw_2.Update( )

commit using sqlca;

else
	messagebox("Unable to update Privilege Status lookups. ","Check to see that file priv status lookup.txt exists in the Intellicred folder.")
end if
end if
//***********************************************

//NPDB
cb_update.text = "NPDB"
st_update.text  = "NPDB"

ls_sql = "ALTER TABLE facility ADD	npdb_entity_dbid 	char(15) NULL;"
execute immediate :ls_sql using sqlca;
ls_sql = "ALTER TABLE facility ADD	npdb_pass     		char(15) NULL;"
execute immediate :ls_sql using sqlca;
ls_sql = "ALTER TABLE facility ADD	npdb_agent_dbid    	char(15) NULL;"
execute immediate :ls_sql using sqlca;
ls_sql = "ALTER TABLE facility ADD	npdb_cc_nbr   		char(16) NULL;"
execute immediate :ls_sql using sqlca;
ls_sql = "ALTER TABLE facility ADD	npdb_cc_exp   		char(6) NULL; "
execute immediate :ls_sql using sqlca;
ls_sql = "ALTER TABLE facility ADD	npdb_cert_name     	char(40) NULL;"
execute immediate :ls_sql using sqlca;
ls_sql = "ALTER TABLE facility ADD	npdb_cert_title    	char(40) NULL;"
execute immediate :ls_sql using sqlca;
ls_sql = "ALTER TABLE facility ADD	npdb_cert_phone    	char(10) NULL; "
execute immediate :ls_sql using sqlca;
ls_sql = "ALTER TABLE facility ADD	npdb_cert_ext 		char(5) NULL;"
execute immediate :ls_sql using sqlca;
ls_sql = "ALTER TABLE facility ADD	npdb_pay_type 		char(1) NULL;"
execute immediate :ls_sql using sqlca;
ls_sql = "ALTER TABLE facility ADD	npdb_cert_date     	date NULL;"
execute immediate :ls_sql using sqlca;
ls_sql = "ALTER TABLE facility ADD	npdb_query_type    	char(1) NULL;"
execute immediate :ls_sql using sqlca;
ls_sql = "ALTER TABLE facility ADD	npdb_query_type_cd 	char(1) NULL;"
execute immediate :ls_sql using sqlca;
ls_sql = "ALTER TABLE facility ADD	npdb_verify_data 	char(1) NULL;"
execute immediate :ls_sql using sqlca;
ls_sql = "ALTER TABLE facility ADD work_gap_check Char(1) NULL;"
execute immediate :ls_sql using sqlca;
commit using sqlca;
/*need to update existing npdb settings to new setup
get all basic info rules for each if method npdb then up date record in npdb section
*/
select set_20
into :cnt
from icred_settings;

if cnt <> 1 then
	open(w_convert_npdb)
	w_convert_npdb.cb_run.triggerevent(clicked!)
	close(w_convert_npdb)
end if

	ls_sql = "update verif_info set direct_parent_facility_link = null where reference_value in ('Work History Gap Check','NPDB QUERY', 'HIPDB QUERY');"
execute immediate :ls_sql using sqlca;
	commit using sqlca;

//*******************************
//Group Practice
cb_update.text = "Group Practice"
st_update.text  = "Group Practice"
ls_sql = "CREATE TABLE group_practice ( rec_id    numeric(10,0) NOT NULL, 	prac_id    	numeric(6,0) null, office_in_home   integer NULL, mailing_address       	integer NULL, practice_type 		numeric(6,0) NULL, street        		varchar(150) NULL, city  			varchar(25) NULL, state 			numeric(6,0) NULL, country       		numeric(6,0) NULL, pager_number  		char(14) NULL, phone 			char(14) NULL, ext   			char(4) NULL,  fax   			char(14) NULL, zip   			varchar(11) NULL,  county        		numeric(6,0) NULL,  contact_person        	varchar(30) NULL,  tax_id        		varchar(30) NULL,  tax_id_other_1        	varchar(30) NULL,  tax_id_other_2        	varchar(30) NULL,  business_mgr  		varchar(30) NULL,  office_mgr    		varchar(30) NULL,  e_mail_address        	varchar(75) NULL,  web_address   		varchar(75) NULL,  mon_from      		char(6) NULL,  mon_to        		char(6) NULL, tue_from      		char(6) NULL,  tue_to        		char(6) NULL,  wed_from      		char(6) NULL,  thu_from      		char(6) NULL,  thu_to        		char(6) NULL,  fri_from      		char(6) NULL,  fri_to        		char(6) NULL,  sat_from      		char(6) NULL, sat_to        		char(6) NULL,  sun_from      		char(6) NULL,  sun_to        		char(6) NULL,  mon_from2     		char(6) NULL,  mon_to2       		char(6) NULL,  tue_from2     		char(6) NULL,  tue_to2       		char(6) NULL,  wed_from2     		char(6) NULL,  wed_to2       		char(6) NULL,  thu_from2     		char(6) NULL,  thu_to2       		char(6) NULL,  fri_from2     		char(6) NULL,  fri_to2       		char(6) NULL,  sat_from2     		char(6) NULL,  sat_to2       		char(6) NULL,  sun_from2     		char(6) NULL, sun_to2       		char(6) NULL,  wed_to        		char(6) NULL,  routine_visit_appt    	varchar(20) NULL,  urgent_visit_appt     	varchar(20) NULL,  emergency_visit_appt  	varchar(20) NULL,  non_emergency_appt    	varchar(20) NULL,  young_child   		numeric(8,0) NULL,  child 			numeric(8,0) NULL,  adolescent    		numeric(8,0) NULL,  adult 			numeric(8,0) NULL,  senior_adult  		numeric(8,0) NULL,  handicapped_access    	integer NULL,  public_transportation 	integer NULL,  cust_1        		varchar(30) NULL,  cust_2        		varchar(30) NULL,  cust_3        		varchar(30) NULL,  cust_4        		varchar(30) NULL,  cust_5        		varchar(30) NULL,  street_2      		varchar(150) NULL,  active_status 		integer NULL,  accepting_new_patients        numeric(6,0) NULL,  cust_6        		varchar(30) NULL,  facility_id   		integer NULL,  gp_id 			integer NULL,  PRIMARY KEY (rec_id));"
execute immediate :ls_sql using sqlca;
commit using sqlca;
ls_sql = "CREATE TABLE group_multi_loc ( rec_id    numeric(8,0) NOT NULL,gp_name        		varchar(100) NULL,street1        		varchar(100) NULL,street2        		varchar(100) NULL, city  			varchar(25) NULL, state 			char(2) NULL,  phone 			char(14) NULL, zip   			varchar(11) NULL,contact_name        	varchar(30) NULL,info1		varchar(50) NULL,info2		varchar(50) NULL,info3		varchar(50) NULL,info4		varchar(50) NULL,info5		varchar(50) NULL,info6		varchar(50) NULL,  PRIMARY KEY (rec_id));"
execute immediate :ls_sql using sqlca;
commit using sqlca;
ls_sql = "CREATE TABLE group_loc_link ( rec_id    numeric(12,0) NOT NULL,group_id        		numeric(8,0) not NULL,loc_id       		numeric(12) not NULL,info1		varchar(50) NULL,info2		varchar(50) NULL,info3		varchar(50) NULL,info4		varchar(50) NULL,info5		varchar(50) NULL,  PRIMARY KEY (rec_id));"
execute immediate :ls_sql using sqlca;
commit using sqlca;

ls_sql = "INSERT INTO sys_fields VALUES (	20,	15000,	600,	'gp_id',	'I',	5,	'Practice',	'',	'',	'',	'',	'',	'N',	NULL,	NULL,	NULL,	NULL,	'N',	NULL,	NULL,	NULL,	NULL,	NULL,	0,	NULL);"
execute immediate :ls_sql using sqlca;
commit using sqlca;

ls_sql = "ALTER TABLE group_practice ADD FOREIGN KEY fk_group_practice_county (county) REFERENCES code_lookup (lookup_code);"
execute immediate :ls_sql using sqlca;
commit using sqlca;

ls_sql ="ALTER TABLE group_practice ADD FOREIGN KEY fk_group_practice_country (country)  REFERENCES code_lookup (lookup_code);" 
execute immediate :ls_sql using sqlca;
commit using sqlca;

ls_sql = "ALTER TABLE group_practice ADD FOREIGN KEY fk_group_practice_prac_type (practice_type) REFERENCES code_lookup (lookup_code); "
execute immediate :ls_sql using sqlca;
commit using sqlca;

ls_sql = "ALTER TABLE group_practice ADD FOREIGN KEY fk_group_practice_state (state) REFERENCES code_lookup (lookup_code); "
execute immediate :ls_sql using sqlca;
commit using sqlca;

ls_sql = "CREATE UNIQUE INDEX indx_group_practice_rec_id ON group_practice (group_id ASC); "
execute immediate :ls_sql using sqlca;
commit using sqlca;

ls_sql = "ALTER TABLE pd_address ADD	gp_id 	integer NULL;"
execute immediate :ls_sql using sqlca;
commit using sqlca;

ls_sql = "insert into sys_fields values(20,	15000	600,gp_id,I,5,Practice,	N,N,0	) ;"
execute immediate :ls_sql using sqlca;
commit using sqlca;




dw_screen.settransobject(sqlca)
ic = dw_screen.retrieve()
dw_fields.settransobject(sqlca)
vi = dw_fields.retrieve()
if vi < 1 then
	
	select max(data_view_field_id)
	into :maxfield
	from data_view_fields;
	
	for i = 1 to ic
		maxfield++
		viewid = dw_screen.getitemnumber(i,"data_view_id")
		dw_fields.ImportFile( gs_dir_path + "intellicred\gpid dataview.txt" )
		dw_fields.setitem(i,"data_view_field_id",maxfield)
		dw_fields.setitem(i,"data_view_id",viewid)
	next

end if

dw_fields.update()
commit using sqlca;

//**************************************
//Hospital Links
cb_update.text = "Hospital Links"
st_update.text  = "Hospital Links"

ls_sql = "CREATE TABLE pd_hosp_facility_link ( hosp_affil_id 	numeric(10,0) NOT NULL, prac_id 	numeric(8,0) NOT NULL,	facility_id 	integer NOT NULL,	primary_hosp  		integer NULL, PRIMARY KEY (hosp_affil_id, prac_id, facility_id))"
execute immediate :ls_sql using sqlca;
commit using sqlca;

dw_primehosp.settransobject(sqlca)
rc = dw_primehosp.retrieve(112)  //primary

//for i = 1 to rc   //hiding primary on hosp screens
//	dw_primehosp.setitem(i,"visible","N")
//	dw_primehosp.setitem(i,"required","N")
//next

dw_primehosp.update()
commit using sqlca;


select last_update into : dte from ids;

if 1 =1 then //dte < string(datetime(date("09-01-01"), now())) then
	//messagebox("in if",string(dte))

	
	dw_hosp.dataobject = "d_all_hosp_affil"
	dw_hosp.settransobject(sqlca)
	dw_hlink.dataobject = "d_hf_link_update"
	dw_hlink.settransobject(sqlca)
	rch = dw_hosp.retrieve()
	cnt = dw_hlink.retrieve()
	dw_hosp.SetRedraw(FALSE)
	dw_hlink.SetRedraw(FALSE)
if cnt > 0 then 
		sle_1.text = sle_1.text + "(1) Unable to add hosp links. " + string(cnt) + " records exist.  "
	
else
	
		for i = 1 to rch
			hosp_id = dw_hosp.getitemnumber(i,"rec_id")
			prac_id = dw_hosp.getitemnumber(i,"prac_id")
			prime = dw_hosp.getitemnumber(i,"primary_hosp")
			if isnull(prime) then prime = 582 
			dw_affil.settransobject(sqlca)
			rcf = dw_affil.retrieve(prac_id)
			for f = 1 to rcf
				fac_id = dw_affil.getitemnumber(f,"parent_facility_id")
				nr = dw_hlink.insertrow(0)
				dw_hlink.setitem(nr,"hosp_affil_id",hosp_id)
				dw_hlink.setitem(nr,"facility_id",fac_id)
				dw_hlink.setitem(nr,"primary_hosp",prime)
				dw_hlink.setitem(nr,"prac_id",prac_id)
			next
			runcnt++
			if runcnt = 1000 then
				dw_hlink.settransobject(sqlca)
				dw_hlink.update()
				commit using sqlca;
				dw_hlink.reset()
				runcnt = 0
			end if
					next
		
		dw_hosp.SetRedraw(True)
		dw_hlink.SetRedraw(True)
		
		 
			dw_hlink.settransobject(sqlca)
			dw_hlink.update()
			commit using sqlca;
  end if
end if

//*****************************************
// specialty links
cb_update.text = "Specialty Links"
st_update.text  = "Specialty Links"

ls_sql = "CREATE TABLE pd_spec_facility_link ( specialty_id 	numeric(10,0) NOT NULL, prac_id 	numeric(8,0) NOT NULL,	facility_id 	integer NOT NULL,	practicing		integer NULL, PRIMARY KEY (specialty_id, prac_id, facility_id))"
execute immediate :ls_sql using sqlca;
commit using sqlca;

if 1 = 1 then //dte < datetime("09-01-01 00:00:00") then
	dw_primehosp.settransobject(sqlca)
	rc = dw_primehosp.retrieve(14) //practicing
	
//	for i = 1 to rc  //hide field
//		dw_primehosp.setitem(i,"visible","N")
//		dw_primehosp.setitem(i,"required","N")
//	next

	dw_primehosp.update()

	commit using sqlca;
	debugbreak()
		dw_hosp.dataobject = "d_all_specialties"
		dw_hosp.settransobject(sqlca)
		dw_hlink.dataobject = "d_specfac_link"
		dw_hlink.settransobject(sqlca)
		rch = dw_hosp.retrieve()
		cnt = dw_hlink.retrieve()
		dw_hosp.SetRedraw(FALSE)
		dw_hlink.SetRedraw(FALSE)
		if cnt > 0 then 
			sle_1.text = sle_1.text + "(2) Unable to add specialty links. " + string(cnt) + " records exist.  "

		else
	
			for i = 1 to rch
				hosp_id = dw_hosp.getitemnumber(i,"rec_id")
				prac_id = dw_hosp.getitemnumber(i,"prac_id")
				prime = dw_hosp.getitemnumber(i,"practicing")
				if isnull(prime) then prime = 0 
				dw_affil.settransobject(sqlca)
				rcf = dw_affil.retrieve(prac_id)
				for f = 1 to rcf
					fac_id = dw_affil.getitemnumber(f,"parent_facility_id")
					nr = dw_hlink.insertrow(0)
					dw_hlink.setitem(nr,"specialty_id",hosp_id)
					dw_hlink.setitem(nr,"facility_id",fac_id)
					dw_hlink.setitem(nr,"practicing",prime)
					dw_hlink.setitem(nr,"prac_id",prac_id)
				next
					runcnt++
				if runcnt = 1000 then
					dw_hlink.settransobject(sqlca)
					integer tst	
					 dw_hlink.update()
					//messagebox("tst",tst)
					commit using sqlca;
					dw_hlink.reset()
					runcnt = 0
				end if
			next
			dw_hlink.settransobject(sqlca)
			dw_hlink.update()
	end if
end if


//***********************************

//Misc Database
cb_update.text = "Misc Database"
st_update.text  = "Misc  Database"


//\/maha082001
ls_sql = "update data_view_fields,data_view_screen set required = 'Y' where field_id in (select distinct reference_field_1 from data_view_screen where reference_field_1 is not null and screen_id <> 19);"
execute immediate :ls_sql using sqlca;
commit using sqlca;

ls_sql = "update data_view_fields,data_view_screen set required = 'Y' where field_id in (select distinct reference_field_2 from data_view_screen where reference_field_2 is not null);"
execute immediate :ls_sql using sqlca;
commit using sqlca;
//\maha


ls_sql = "update facility_ver_rules set exp_reminder_doc = 'N'  where exp_reminder_doc is null;"
execute immediate :ls_sql using sqlca;
commit using sqlca;

ls_sql = "update facility_ver_rules set ver_ltr_doc = 'N' where ver_ltr_doc is null;"
execute immediate :ls_sql using sqlca;
commit using sqlca;


ls_sql = "Alter table pd_affil_stat add check_date datetime null;"
execute immediate :ls_sql using sqlca;
commit using sqlca;

ls_sql = "Alter table ids add npdb_multi integer null default 0;"
execute immediate :ls_sql using sqlca;
commit using sqlca;

ls_sql = "Alter table facility_ver_rules add check_back_years integer null default 0;"
execute immediate :ls_sql using sqlca;
commit using sqlca;

ls_sql = "Alter table facility add appointment_years integer null default 2;"
execute immediate :ls_sql using sqlca;
commit using sqlca;

ls_sql = "update facility set appointment_years = 2 where appointment_years is null;"
execute immediate :ls_sql using sqlca;
commit using sqlca;

ls_sql = "Alter table facility add dupeset integer null default 0;"
execute immediate :ls_sql using sqlca;
commit using sqlca;

ls_sql = "update facility set dupeset = 0 where dupeset is null;"
execute immediate :ls_sql using sqlca;
commit using sqlca;

ls_sql = "Alter table ids add last_update datetime null;"
execute immediate :ls_sql using sqlca;
commit using sqlca;

ls_sql = "Alter table net_dev_action_items add app_id integer null;"
execute immediate :ls_sql using sqlca;
commit using sqlca;

ls_sql = "ALTER TABLE image_type ADD link_to_app_id integer NULL;"
execute immediate :ls_sql using sqlca;
commit using sqlca;//090701

ls_sql = "ALTER TABLE image_type ADD parent_facility_id integer NULL;"
execute immediate :ls_sql using sqlca;
commit using sqlca;//090701

//\/maha 061901 reference fields for contracts, claims, att quest
//removed 030802 maha readded 053002
ls_sql = "update data_view_screen set reference_field_1 = 201 where screen_id = 21 and reference_field_1 is null;"
execute immediate :ls_sql using sqlca;
commit using sqlca;
ls_sql = "update data_view_screen set reference_field_2 = 202 where screen_id = 21 and reference_field_1 is null;"
execute immediate :ls_sql using sqlca;
commit using sqlca;
ls_sql = "update data_view_screen set reference_field_1 = 358 where screen_id = 16 and reference_field_1 is null;"
execute immediate :ls_sql using sqlca;
commit using sqlca;
ls_sql = "update data_view_screen set reference_field_2 = 376 where screen_id = 16 and reference_field_2 is null;"
execute immediate :ls_sql using sqlca;
commit using sqlca;
ls_sql = "update data_view_screen set reference_field_1 = 37 where screen_id = 3 and reference_field_1 is null;"
execute immediate :ls_sql using sqlca;
commit using sqlca;
ls_sql = "update data_view_screen set reference_field_2 = 38 where screen_id = 3 and reference_field_2 is null;"
execute immediate :ls_sql using sqlca;
commit using sqlca;

ls_sql = "update facility_ver_rules set init_veif_letter_doc_nm = 'ind_other_affiliations_letter.doc',reapp_verif_letter_doc_nm = 'ind_other_affiliations_letter.doc' where screen_id = 11;"
execute immediate :ls_sql using sqlca;//071001 maha
commit using sqlca;
ls_sql = "update facility_ver_rules set init_veif_letter_doc_nm = 'ind_claims_letter.doc',reapp_verif_letter_doc_nm = 'ind_claims_letter.doc' where screen_id = 16;"
execute immediate :ls_sql using sqlca;//071901 maha
commit using sqlca;
//division lookup table
select count(lookup_code)
into :cnt
from code_lookup
where lookup_name = 'Division';

if cnt < 1 then
	select max(lookup_code) into :maxid	from code_lookup;
	maxid++
	insert into code_lookup (lookup_code,lookup_name,code,description)
	values(:maxid,'Division','div1','Division 1');
	update ids
	set lookup_code_id = :maxid;
	commit using sqlca;
end if
//\maha

//\/ maha Affiliation Status lookup  121001
dw_2.SetTransObject( SQLCA	)
dw_2.reset()
select count(lookup_code)
into :cnt
from code_lookup
where lookup_name = 'Affiliation Status';

if cnt < 1 then
	li_rc = dw_2.ImportFile( gs_dir_path + "intellicred\affil_stat_lookup.txt" )

	if li_rc > 0 then		
		SELECT ids.lookup_code_id  
		INTO :ll_lookup_code  
		FROM ids;
		
		FOR i = 1 TO li_rc
			ll_lookup_code++
			dw_2.SetItem( i, "lookup_code", ll_lookup_code )
		END FOR	
		
		UPDATE ids  
		SET lookup_code_id = :ll_lookup_code;
		
		dw_2.Update( )
		
		commit using sqlca;
	
	else
		messagebox("Unable to update Affiliation Status lookups. ","Check to see that file affil_stat_lookup.txt exists in the Intellicred folder.")
	end if
end if

//\/maha settings table 071001
st_update.text  = "Settings"

ls_sql = "CREATE TABLE icred_settings (set_1  	integer default 0,set_2  	integer default 0,set_3  	integer default 0,set_4  	integer default 0,set_5  	integer default 0,set_6  	integer default 0,set_7  	integer default 0,set_8  	integer default 0,set_9  	integer default 0,set_10  	integer default 0,set_11  	integer default 0,set_12  	integer default 0,set_13  	integer default 0,set_14  	integer default 0,set_15  	integer default 0,set_16  	integer default 0,set_17  	integer default 0,set_18  	integer default 0,set_19  	integer default 0,set_20  	integer default 0)"
execute immediate :ls_sql using sqlca;
commit using sqlca;

select count(set_1)
into :cnt
from icred_settings
where set_1 is not null;

if cnt < 1 then

	insert into icred_settings (set_1)
	values(0);
	commit using sqlca;
end if
//\maha

ls_sql = "ALTER TABLE security_users ADD email_id char( 50 ) NULL;"
execute immediate :ls_sql using sqlca;//082701 maha
commit using sqlca;

ls_sql = "ALTER TABLE facility ADD default_audit_temp integer NULL;"
execute immediate :ls_sql using sqlca;//082701 maha
commit using sqlca;

ls_sql = "ALTER TABLE facility ADD default_verif_facility integer NULL;"
execute immediate :ls_sql using sqlca;//082701 maha
commit using sqlca;
ls_sql = "update sys_fields	set field_name_allias = 'Name/Street 1' where field_id = 393;"
execute immediate :ls_sql using sqlca;
commit using sqlca;//081401 maha

ls_sql = "update data_view_screen set table_id = 29 where screen_id = 26;"
execute immediate :ls_sql using sqlca;
commit using sqlca;//081401 maha

ls_sql = "CREATE TABLE sys_multi_app (	multi_app_id float,	parent_facility_id float,	application_audit_facility float,	verifying_facility float,	app_id float,	apptmnt_type char(1));"
execute immediate :ls_sql using sqlca;//090401 maha
commit using sqlca;
ls_sql = "CREATE TABLE sys_multi_app_hdr (	multi_app_id float,	multi_app_description char(50),	notes char(255));"
execute immediate :ls_sql using sqlca;//090401 maha
commit using sqlca;
ls_sql = "ALTER TABLE ids ADD install_type char(1) NULL;"
execute immediate :ls_sql using sqlca;//090401 maha
commit using sqlca;
ls_sql = "ALTER TABLE ids ADD lookup_cache datetime NULL;"
execute immediate :ls_sql using sqlca;//090401 maha
commit using sqlca;
ls_sql = "ALTER TABLE ids ADD screen_cache datetime NULL;"
execute immediate :ls_sql using sqlca;//090401 maha
commit using sqlca;
ls_sql = "ALTER TABLE ids ADD screen_obj_cache datetime NULL;"
execute immediate :ls_sql using sqlca;//090401 maha
commit using sqlca;
ls_sql = "ALTER TABLE facility modify npdb_pass  char(15) NULL;"
execute immediate :ls_sql using sqlca;//101701 maha
commit using sqlca;
ls_sql = "update sys_fields set field_type = 'N' where field_name = 'title_duties';"
execute immediate :ls_sql using sqlca;//101701 maha
commit using sqlca;
ls_sql = "update sys_fields set field_type = 'N' where field_id = '403';"//office_in_home
execute immediate :ls_sql using sqlca;//101701 maha
commit using sqlca;

ls_sql = "Alter table pd_address add tab_address integer null;"
execute immediate :ls_sql using sqlca;//111201maha
commit using sqlca;
ls_sql = "Alter table pd_address add tab_back integer null;"
execute immediate :ls_sql using sqlca;//111201 maha
commit using sqlca;

//\/maha 110801  to populate table_id in screens
dw_affil.dataobject = "d_dv_screen_view_1"
dw_affil.settransobject(sqlca)
dw_whatever.dataobject = "d_dv_screen_all_per_view"
dw_whatever.settransobject(sqlca)

ic = dw_affil.retrieve()

for i = 1 to ic
	viewid = dw_affil.getitemnumber(i,"screen_id")
	rcf = dw_affil.getitemnumber(i,"table_id")
	rc = dw_whatever.retrieve(viewid)
	for f = 1 to rc
		
		dw_whatever.setitem(f,"table_id",rcf)
		dw_whatever.update()
		commit using sqlca;
	next
next
//\maha
ls_sql = "Alter table app_field_prop add billing_address_flag integer null;"
execute immediate :ls_sql using sqlca;//111401 maha
commit using sqlca;

ls_sql = "Alter table net_dev_ids add tax_id char(10) null;"
execute immediate :ls_sql using sqlca;//111501 maha
commit using sqlca;

ls_sql = "Alter table security_users add iverify_temp_id integer null;"
execute immediate :ls_sql using sqlca;//112101 maha
commit using sqlca;
ls_sql = "Alter table security_users add email_id char(50) null ;"
execute immediate :ls_sql using sqlca;//112101 maha
commit using sqlca;


//update data_view_screen, data_view_screen dv2
//set data_view_screen.table_id = (select table_id from dv2 where data_view_screen.screen_id = dv2.screen_id and dv2.data_view_id = 1)
//where data_view_screen.table_id is null;
st_update.text  = "Military Fields"

select set_19//\/military fields maha 112601
into :cnt
from icred_settings;

if cnt <> 1 then 

	Update sys_fields
	set lookup_type = 'C',
		 lookup_field = 'Y',
		 lookup_code = 'Yes/No',
		 lookup_field_name = 'Code'
	Where field_id = 312;
	
	Update data_view_fields
	set field_x = 50,
		 field_y = 850,
		 field_label_x = 55,
		 field_label_y = 778,
		 field_order = 500
	where field_id = 312;
	
	
	//reservist
	Update sys_fields
	set lookup_type = 'C',
		 lookup_field = 'Y',
		 lookup_code = 'Yes/No',
		 lookup_field_name = 'Code'
	Where field_id = 314;
	
	Update data_view_fields
	set field_x = 509,
		 field_y = 850,
		 field_label_x = 506,
		 field_label_y = 782,
		 field_order = 510,
		 visible = 0
	where field_id = 314;
	
	//active_military
	Update sys_fields
	set  lookup_field = 'Y',
		 lookup_code = 'Yes/No',
		 lookup_field_name = 'Code',
		 lookup_type = 'C'
	Where field_id = 313;
	
	Update data_view_fields
	set field_x = 55,
		 field_y = 1022,
		 field_label_x = 55,
		 field_label_y = 946,
		 field_order = 520,
		 visible = 0
	where field_id = 313;
	
	//service date from
	Update data_view_fields
	set field_x = 499,
		 field_y = 1022,
		 field_label_x = 494,
		 field_label_y = 946,
		 field_order = 525
	where field_id = 318;
	
	//service date to
	Update data_view_fields
	set field_x = 1074,
		 field_y = 1022,
		 field_label_x = 1074,
		 field_label_y = 946,
		 field_order = 530,
		 visible = 0
	where field_id = 319;
	
	
	
	//branch
	Update data_view_fields
	set field_x = 1637,
		 field_y = 1018,
		 field_label_x = 1625,
		 field_label_y = 946,
		 field_order = 540,
		 visible = 0
	where field_id = 315;
	
	
	
	//service_number
	Update data_view_fields
	set field_x = 55,
		 field_y = 1212,
		 field_label_x = 51,
		 field_label_y = 1134,
		 field_order = 545,
		 visible = 0
	where field_id = 317;
	
	//rank
	Update sys_fields
	set lookup_type = 'C',
		 lookup_field = 'Y',
		 lookup_code = 'Rank',
		 lookup_field_name = 'Description'
	Where field_id = 316;
	
	Update data_view_fields
	set field_x = 699,
		 field_y = 1212,
		 field_label_x = 698,
		 field_label_y = 1142,
		 field_order = 550,
		 visible = 0
	where field_id = 316;
	
	update icred_settings
	set set_19 = 1;
end if  //\end military fields maha

//ls_sql = "Alter table group_practice add billing_address_id integer;"
//execute immediate :ls_sql using sqlca;//112701 maha
//commit using sqlca;
ls_sql = "Alter table conv_view_fields add field_align integer null;"
execute immediate :ls_sql using sqlca;//121001 maha
commit using sqlca;
ls_sql = "Alter table conv_view_fields add label_align integer null;"
execute immediate :ls_sql using sqlca;//121001 maha
commit using sqlca;
ls_sql = "ALTER TABLE security_users ADD default_search_facility integer NULL;"
execute immediate :ls_sql using sqlca;//010902 maha
commit using sqlca;
ls_sql = "ALTER TABLE data_view_screen ADD table_id_2 Integer NULL;"
execute immediate :ls_sql using sqlca;//013102 maha
commit using sqlca;
ls_sql = "ALTER TABLE data_view_screen ADD detail_2 Integer NULL;"
execute immediate :ls_sql using sqlca;//013102 maha
commit using sqlca;
ls_sql = "ALTER TABLE pd_affil_stat ADD inital_appmnt_date timestamp NULL;"
execute immediate :ls_sql using sqlca;//013102 maha
commit using sqlca;
//**************************************additional misc data below\/************************

//Notes table 081701
cb_update.text = "Notes"
st_update.text  = "Notes"

ls_sql = "CREATE TABLE pd_notes (record_id numeric(10,0) not null, prac_id  	numeric(10,0) NOT NULL,facility_id  	integer NOT NULL,ent_date  	datetime NULL, user_id  	char(10) NULL,note long varchar null,PRIMARY KEY (record_id));"
execute immediate :ls_sql using sqlca;
commit using sqlca;

//*****************************



delete from profile_reports where profile_report_id in (28,29,30);
ls_sql = "Alter table profile_reports add constraint pk_prof_rpt primary key(profile_report_id) ;"
execute immediate :ls_sql using sqlca;//112701 maha
commit using sqlca;

ls_sql = "insert into profile_reports values(28,'Group/Covering Provider','','d_prf_group_covering_providers',28,'PF' );"
execute immediate :ls_sql using sqlca;//082701 maha
commit using sqlca;

ls_sql = "insert into profile_reports values(29,'Profile Signature','','d_prf_profile_signature',29,'P' );"
execute immediate :ls_sql using sqlca;//082701 maha
commit using sqlca;
ls_sql = "insert into profile_reports values(30,'Affiliations/Networks','','d_prf_affil_stat',30,'P' );"
execute immediate :ls_sql using sqlca;//112601 maha
commit using sqlca;
ls_sql = "insert into profile_reports values(31,'Specialties w/ Cust 1','','d_prf_specialties_bbbs_oki',31,'PF' );"
execute immediate :ls_sql using sqlca;//120501 maha
commit using sqlca;

ls_sql = "update profile_reports set retrieval_aruments = 'PF' where profile_report_id = 9;" //hospitals
execute immediate :ls_sql using sqlca;
commit using sqlca;

ls_sql = "update profile_reports set retrieval_aruments = 'PF',profile_report_dw = 'd_prf_specialties_new' where profile_report_id = 2;"
execute immediate :ls_sql using sqlca;
commit using sqlca;

ls_sql = "update profile_reports set retrieval_aruments = 'PF' where profile_report_id = 31;"
execute immediate :ls_sql using sqlca;
commit using sqlca;
//*************************
	//Network Development Codes
cb_update.text = "Network Development Codes"
st_update.text  = "Network Development Codes"

ls_sql = "CREATE TABLE net_dev_ids (	facility_id   		integer NOT NULL,	plan_assigned_id      	char(20) NOT NULL,	plan_type     		numeric(8,0) NOT NULL,	start_date    		datetime NULL,	end_date      		datetime NULL,	end_reason    		numeric(8,0) NULL,	fee_schedule  		numeric(8,0) NULL,	prac_id       		numeric(8,0) NULL);"
execute immediate :ls_sql using sqlca;
commit using sqlca;

ls_sql = "Alter table net_dev_ids add tax_id char(10) null;"
execute immediate :ls_sql using sqlca;//111501 maha
commit using sqlca;

ls_sql = "ALTER TABLE net_dev_ids ADD rec_id numeric(8,0) not null;"
execute immediate :ls_sql using sqlca; 
commit using sqlca;

ls_sql = "create table net_dev_action_items (rec_id   numeric(12) not null,app_stat_id   numeric(12)  not null,prac_id     numeric(6)       not null,action_type  numeric(6) null,action_date   datetime   null,action_dept  numeric(6) null,action_user          char(10)   null,action_status numeric(6)  null,next_action_date     datetime  null,notes  varchar(255) null,action_contact       varchar(50)   null,app_id    integer   null,constraint PK_NET_DEV_ACTION_ITEMS primary key  (rec_id, app_stat_id, prac_id));"
execute immediate :ls_sql using sqlca;
commit using sqlca;

V31:  //maha 072304
update icred_settings	set set_18 = 30; //version setting
commit using sqlca;
//\/MISC added after 030102***************************************************************************
cb_update.text = "Addtl. Misc data"
st_update.text  = "Addtl Misc. Data"

ls_sql = "ALTER TABLE net_dev_action_items ADD active_status integer NULL;"
execute immediate :ls_sql using sqlca;//030102 maha
commit using sqlca;
ls_sql = "ALTER TABLE net_dev_action_items ADD seq_no integer NULL;"
execute immediate :ls_sql using sqlca;//030102 maha
commit using sqlca;
ls_sql = "ALTER TABLE net_dev_action_items ADD app_type char(1) NULL;"
execute immediate :ls_sql using sqlca;//030102 maha
commit using sqlca;
ls_sql = "CREATE TABLE pd_address_2 (	rec_id        		numeric(10,0) NOT NULL,	prac_id       		numeric(6,0) NOT NULL,	all_hr_cov_flag       	numeric(6,0) NULL,	all_hr_cov_machine    	numeric(6,0) NULL,	all_hr_cov_beeper     	numeric(6,0) NULL,	all_hr_cov_service    	numeric(6,0) NULL,	all_hr_cov_rotate     	numeric(6,0) NULL,	all_hr_cov_self       	numeric(6,0) NULL,	second_opinion        	numeric(6,0) NULL,	work_comp_state       	numeric(6,0) NULL,	work_comp_num 		char(30) NULL,	surgery_flag  		numeric(6,0) NULL,	surgery_description   	varchar(255) NULL,	procedure_flag        	numeric(6,0) NULL,	procedure_desc        	varchar(255) NULL,	lab_serv_flag 		numeric(6,0) NULL,	lab_serv_desc 		varchar(255) NULL,	outside_lab_service   	varchar(100) NULL,	CLIANo        		varchar(20) NULL,	ri_service_flag       	numeric(6,0) NULL,	ri_service_desc       	varchar(255) NULL,	cust_1        		varchar(50) NULL,	cust_2        		varchar(50) NULL,	cust_3        		varchar(50) NULL,	cust_4        		varchar(50) NULL,	cust_5        		varchar(50) NULL,	cust_6        		varchar(50) NULL,	cust_7        		varchar(50) NULL,	cust_8        		varchar(50) NULL,	cust_9        		varchar(50) NULL,	cust_10       		varchar(50) NULL,	cust_11       		datetime NULL,	cust_12       		datetime NULL,	notes 			long varchar NULL);"
execute immediate :ls_sql using sqlca;//030702 maha
commit using sqlca;
ls_sql = "CREATE UNIQUE INDEX idx_pd_address_2 ON pd_address_2 (	rec_id ASC);"//030702 maha
execute immediate :ls_sql using sqlca;//030702 maha
commit using sqlca;
ls_sql = "CREATE INDEX idx_pd_address_2_prac_id ON pd_address_2 (	prac_id ASC) ;"//030702 maha
execute immediate :ls_sql using sqlca;//030702 maha
commit using sqlca;

ls_sql = "ALTER TABLE data_view_screen ADD table_id_2 Integer NULL;"
execute immediate :ls_sql using sqlca;//030702 maha
commit using sqlca;
ls_sql = "ALTER TABLE data_view_screen ADD detail_2 Integer NULL;"
execute immediate :ls_sql using sqlca;//030702 maha
commit using sqlca;
ls_sql = "ALTER TABLE data_view_fields ADD tab_address Integer NULL;"
execute immediate :ls_sql using sqlca;//030702 maha
commit using sqlca;
ls_sql = "ALTER TABLE data_view_fields ADD back_address Integer NULL;"
execute immediate :ls_sql using sqlca;//030702 maha
commit using sqlca;
ls_sql = "ALTER TABLE conv_view_fields ADD label_text char(100) NULL;"
execute immediate :ls_sql using sqlca;//031202 maha
commit using sqlca;


ls_sql = "ALTER TABLE ids ADD picture_path varchar(150) NULL;"
execute immediate :ls_sql using sqlca;//031402 maha
commit using sqlca;
ls_sql = "ALTER TABLE ids ADD print_space long varchar NULL;"
execute immediate :ls_sql using sqlca;//031402 maha
commit using sqlca;
ls_sql = "ALTER TABLE priv_core ADD sort_order integer NULL;"
execute immediate :ls_sql using sqlca;//031802 maha
commit using sqlca;
ls_sql = "ALTER TABLE facility ADD central_cred integer NULL;"
execute immediate :ls_sql using sqlca;//032202 maha
commit using sqlca;
ls_sql = "ALTER TABLE pd_board_specialty ADD expiration_date datetime NULL;"
execute immediate :ls_sql using sqlca;//032202 maha
commit using sqlca;



//***************************************




cb_update.text = "Views"
st_update.text  = "Views"

ls_sql = "CREATE VIEW v_field_audit as Select sys_audit.seq_no, sys_audit.table_id,sys_audit.prac_id, sys_audit.old_value,sys_audit.new_value, sys_audit.user_id,sys_audit.date_time_modified,sys_audit.audit_typeFROM sys_audit;" 
execute immediate :ls_sql using sqlca;//030702 maha
commit using sqlca;
ls_sql = "CREATE VIEW v_facility AS SELECT facility.facility_id, facility.facility_name,facility.street, facility.street_2,facility.city, facility.state, facility.zip,facility.country, facility.phone,facility.fax, facility.contact,facility.web_address, facility.email_address,facility.return_facility_name,facility.return_street, facility.return_street_2,facility.return_city, facility.return_zip,facility.return_phone,facility.return_fax, facility.return_state,facility.return_ext FROM facility;)"
execute immediate :ls_sql using sqlca;//030702 maha
commit using sqlca;

//\*********************************************************************************************

//adding billing id field to the address table.
cb_update.text = "Billing Link Fields"
st_update.text  = "Billing Address Links"

of_billing_link_field()

//Security  add security data maha 112601
cb_update.text = "2.5 Security Items"
st_update.text  = "2.5 Security items"

//of_security() //maha app100405 removed


end if  //from line 2
//*********************************************************************************************
//Entries after 03-28-01
if idt_lup < datetime(2002-06-28,now()) then 
	sle_1.text = "New updates"
//of_addr_det_2_insert()//031002 maha removed 062802 because of the problems it created
cb_update.text = "New updates"
st_update.text  = "New Updates"

select count(lookup_code) into :cnt from code_lookup where description = 'App Out To MD';
if cnt = 0 then  //041602
	SELECT lookup_code_id INTO :ll_lookup_code  FROM ids;
	ll_lookup_code++
	ls_sql = "insert into code_lookup values(" + string(ll_lookup_code) + ",'Action Type','App Out To MD','App Out To MD',null,null,null,null,null,null,null );"
	execute immediate :ls_sql using sqlca;
	update ids set lookup_code_id = :ll_lookup_code;
	commit using sqlca;
end if
ls_sql = "update security_rights_action set dddw_type = 1 where action_id = 1330;" //041802 intelliapp
execute immediate :ls_sql using sqlca;
commit using sqlca;
//050702
ls_sql = "create table npdb_tracker (export_id numeric (8,0) not null,c_date timestamp null,s_date timestamp  null,r_date timestamp null,user_id char(12) not null,file_name varchar(25) null,facility_id integer null,rec_cnt integer null,prac_id numeric(10,0) null,cust_1 varchar(30) null,cust_2 varchar(30) null,cust_3 varchar(30) null,doc_id varchar(20) NULL, PRIMARY KEY (export_id));"
execute immediate :ls_sql using sqlca;
commit using sqlca;

ls_sql = "ALTER TABLE npdb_tracker ADD doc_id varchar(20) NULL;"
execute immediate :ls_sql using sqlca;//0515202 maha
commit using sqlca;

ls_sql = "update facility_ver_rules set init_veif_letter_doc_nm = 'ind_special_certifications_letter.doc',reapp_verif_letter_doc_nm = 'ind_special_certifications_letter.doc',exp_cred_letter_doc_nm = 'ind_expiring_special_certifications.doc' where screen_id = 9;"
execute immediate :ls_sql using sqlca;//0515202 maha
commit using sqlca;

ls_sql = "UPDATE code_lookup SET custom_1 = code,type = 'C' WHERE lookup_name = 'Action Type' AND  custom_1 IS Null;"
execute immediate :ls_sql using sqlca;//0524202 maha
commit using sqlca;

select count(field_id) into :cnt from sys_fields where field_id = 22223508;
select count(field_id) into :cnt2 from sys_fields where table_id = 42;
if cnt < 1 then
	if cnt2 > 5 then //maha 060702 checking to see if the other fields were inserted
		ls_sql = "INSERT INTO sys_fields VALUES (	42,	22223508,	1,	'address_type',	'N',	6,	'Address Type',	'A',	'C',	'Y',	'Address Type',	'description',	'Y',	NULL,	NULL,	NULL,	NULL,	'N',	NULL,	NULL,	NULL,	150,	6,	0,	NULL);"
		execute immediate :ls_sql using sqlca;//0524202 maha
		commit using sqlca;
	end if
end if

ls_sql = "update code_lookup set custom_6 = '1' where lookup_name = 'Action Type' AND      code in ( 'App Mail Payor', 'App Mail Prac','App Out To MD', 'App Rcvd Payor', 'App Rcvd Prac' );"
execute immediate :ls_sql using sqlca;//060702 maha
commit using sqlca;

ls_sql = "alter table pd_affil_dept add primary_dept integer null default 0;"
execute immediate :ls_sql using sqlca;//060702 maha
commit using sqlca;

ls_sql = "update pd_affil_dept  set primary_dept = 1 where primary_dept is null;"
execute immediate :ls_sql using sqlca;//060702 maha
commit using sqlca;

ls_sql = "update sys_npdb  set dw_name = 'dept',dw_field_name = 'lookup_code',record_number = 1 where npdb_field_name = 'department code';"
execute immediate :ls_sql using sqlca;//061302 maha
commit using sqlca;

ls_sql = "INSERT INTO sys_letters VALUES (	1001,	'Credentialing Application Signature Follow up (Individual)',	'Use this letter to follow up with a practitioner that has not mailed back a signed credentialing app.',	'ind_credentialing_application_signed_followup.doc',	0,	0,	0,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//061302 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_letters VALUES (	1002,	'Credentialing Application Signature Follow up (ALL)',	'Use this letter to follow up with ALL practitioners that have not mailed back a signed credentialing app.',	'ind_credentialing_application_signed_followup.doc',	0,	0,	0,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//061302 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_letters VALUES (	1003,	'Payer Follow up Letter (Individual)',	'Use this letter to follow up with Payers and Hospitals to see the status of a practitioner credentialing.',	'ind_payer_follow_up_letter.doc',	0,	0,	0,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//061302 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_letters VALUES (	1004,	'Payer Follow up Letter (All)',	'Use this letter to follow up with Payers and Hospitals to see the statusof ALL practitioner credentialing.',	'ind_payer_follow_up_letter.doc',	0,	0,	0,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//061302 maha
commit using sqlca;
//ls_sql = "alter table code_lookup add export_code char(16);"
//execute immediate :ls_sql using sqlca;//061802 maha
//commit using sqlca;
//ls_sql = "alter table address_lookup add export_code char(16);"
//execute immediate :ls_sql using sqlca;//061802 maha
//commit using sqlca;
ls_sql = "alter table export_header add export_type integer null;"
execute immediate :ls_sql using sqlca;//060702 maha
commit using sqlca;

ls_sql = "alter table export_fields add export_type integer null;"
execute immediate :ls_sql using sqlca;//060702 maha
commit using sqlca;

ls_sql = "alter table export_fields add field_value varchar(100) null;"
execute immediate :ls_sql using sqlca;//060702 maha
commit using sqlca;
ls_sql = "alter table export_fields add export_code integer null default 0;"
execute immediate :ls_sql using sqlca;//061802 maha
commit using sqlca;
ls_sql = "update table export_fields set export_code = 0 where export_code is null;"
execute immediate :ls_sql using sqlca;//061802 maha
commit using sqlca;
ls_sql = "alter table export_fields add use_link integer null;"
execute immediate :ls_sql using sqlca;//061802 maha
commit using sqlca;
ls_sql = "Alter table export_fields add filter_query long varchar null;"
execute immediate :ls_sql using sqlca;//061802 maha
commit using sqlca;
ls_sql = "update export_fields set use_link = 0 where use_link is null;"
execute immediate :ls_sql using sqlca;//061802 maha
commit using sqlca;
ls_sql = "Alter table export_fields add facility_id integer null;"
execute immediate :ls_sql using sqlca;//061802 maha
commit using sqlca;
ls_sql = "alter table export_fields add lu_field_name varchar(50) null;"
execute immediate :ls_sql using sqlca;//062402 maha
commit using sqlca;

ls_sql = "create table export_equiv_code (export_code_id numeric(8) null,export_id integer null,	lookup_code numeric(8) null,lookup_table varchar(35) null,code char(15) null,equiv_code varchar(255) null ) ;"
execute immediate :ls_sql using sqlca;//062002 maha
commit using sqlca;

//\/lij facility specific stuff put on their system in April
ls_sql = "CREATE TABLE pd_committee (	rec_id decimal(16, 0)  null,	facility_id float null,	prac_id decimal(16, 0) null,	committee decimal(16, 0) null,	committee_date datetime NULL,	cust_1 char(50) NULL,	cust_2 char(50) NULL,	cust_3 char(50) NULL,	cust_4 char(50) NULL,	cust_5 char(50) NULL,   active_status integer  null);"
execute immediate :ls_sql using sqlca;//062002 maha
commit using sqlca;
ls_sql = "CREATE TABLE pd_admin_role (	rec_id decimal(16, 0) null,	facility_id float null,	prac_id decimal(16, 0) null,	admin_role decimal(16, 0) NULL,	admin_role_date datetime NULL,	notes char(255) NULL,	cust_1 char(50) NULL,	cust_2 char(50) NULL,	cust_3 char(50) NULL,	cust_4 char(50) NULL,	cust_5 char(50) NULL,   active_status integer null);"
execute immediate :ls_sql using sqlca;//062002 maha
commit using sqlca;

ls_sql = "CREATE TABLE pd_other_data (	rec_id decimal(16, 0)  null,	facility_id float null,	prac_id decimal(16, 0) null,	corp_comply datetime NULL,	bylaws_read datetime NULL,	orientation datetime NULL,	conscience_sedation datetime NULL,	ppd_date datetime NULL,	positive_ppd decimal(16, 0) NULL,	npdb datetime NULL,   physical datetime NULL,	lij_beeper decimal(12,0) NULL,	custom_1 char(100) NULL,	custom_2 char(100) NULL,	custom_3 char(100) NULL,	custom_4 char(100) NULL,	custom_5 char(100) NULL,   active_status integer null);"
execute immediate :ls_sql using sqlca;//062002 maha
commit using sqlca;

ls_sql = "CREATE TABLE pd_rank (	rec_id decimal(16, 0) null,	facility_id float null,	prac_id decimal(16, 0) null,	rank decimal(16, 0) NULL,	rank_date datetime NULL,	notes char(255) NULL,	cust_1 char(50) NULL,	cust_2 char(50) NULL,	cust_3 char(50) NULL,	cust_4 char(50) NULL,	cust_5 char(50) NULL,   active_status integer null);"
execute immediate :ls_sql using sqlca;//062002 maha
commit using sqlca;
ls_sql = "CREATE   INDEX idx_pd_admin_role_prac_id ON pd_admin_role( prac_id ASC ) WITH MAX HASH SIZE 10 IN SYSTEM;"
execute immediate :ls_sql using sqlca;//062002 maha
commit using sqlca;

ls_sql = "CREATE UNIQUE INDEX idx_pd_admin_role_rec_id ON pd_admin_role( rec_id ASC ) WITH MAX HASH SIZE 10 IN SYSTEM;"
execute immediate :ls_sql using sqlca;//062002 maha
commit using sqlca;

ls_sql = "CREATE   INDEX idx_pd_admin_role_prac_id_facility ON pd_admin_role( prac_id ASC, facility_id ASC ) WITH MAX HASH SIZE 10 IN SYSTEM;"
execute immediate :ls_sql using sqlca;//062002 maha
commit using sqlca;

ls_sql = "CREATE   INDEX idx_pd_comm_prac_id ON pd_committee( prac_id ASC ) WITH MAX HASH SIZE 10 IN SYSTEM;"
execute immediate :ls_sql using sqlca;//062002 maha
commit using sqlca;

ls_sql = "CREATE UNIQUE  INDEX idx_pd_comm_rec_id ON pd_committee( rec_id ASC ) WITH MAX HASH SIZE 10 IN SYSTEM;"
execute immediate :ls_sql using sqlca;//062002 maha
commit using sqlca;

ls_sql = "CREATE   INDEX idx_pd_comm_prac_facility ON pd_committee( prac_id ASC, facility_id ASC ) WITH MAX HASH SIZE 10 IN SYSTEM;"
execute immediate :ls_sql using sqlca;//062002 maha
commit using sqlca;

ls_sql = "CREATE UNIQUE  INDEX idx_pd_rank_rec_id ON pd_rank( rec_id ASC ) WITH MAX HASH SIZE 10 IN SYSTEM;"
execute immediate :ls_sql using sqlca;//062002 maha
commit using sqlca;

ls_sql = "CREATE   INDEX idx_pd_rank_prac_id ON pd_rank( prac_id ASC ) WITH MAX HASH SIZE 10 IN SYSTEM;"
execute immediate :ls_sql using sqlca;//062002 maha
commit using sqlca;

ls_sql = "CREATE   INDEX idx_pd_rank_facility_prac_id ON pd_rank( prac_id ASC, facility_id ASC ) WITH MAX HASH SIZE 10 IN SYSTEM;"
execute immediate :ls_sql using sqlca;//062002 maha
commit using sqlca;

ls_sql = "CREATE UNIQUE  INDEX idx_pd_other_data_rec_id ON pd_other_data( rec_id ASC ) WITH MAX HASH SIZE 10 IN SYSTEM;"
execute immediate :ls_sql using sqlca;//062002 maha
commit using sqlca;

ls_sql = "CREATE   INDEX idx_pd_other_data_prac_id ON pd_other_data( prac_id ASC ) WITH MAX HASH SIZE 10 IN SYSTEM;"
execute immediate :ls_sql using sqlca;//062002 maha
commit using sqlca;

ls_sql = "CREATE   INDEX idx_pd_other_data_facility_prac_id ON pd_other_data( facility_id ASC, prac_id ASC ) WITH MAX HASH SIZE 10 IN SYSTEM;"
execute immediate :ls_sql using sqlca;//062002 maha
commit using sqlca;
//\lij stuff

ls_sql = "create table export_auto_settings (auto_export_id integer not null ,export_id integer not null,	save_to_path varchar(150),frequency integer,run_time timestamp,interval numeric(6), active_status integer default 0, last_run timestamp,error_code integer,sql_syntax long varchar ,primary key(auto_export_id)) ;"
execute immediate :ls_sql using sqlca;//062002 maha
commit using sqlca;

ls_sql = "Alter table export_fields add use_default integer null ;"
execute immediate :ls_sql using sqlca;//070802 maha
commit using sqlca;
ls_sql = "Alter table export_fields add default_value varchar(30) null;"
execute immediate :ls_sql using sqlca;//070802 maha
commit using sqlca;
ls_sql = "Alter table sys_audit add exported integer null;"
execute immediate :ls_sql using sqlca;//070902 maha
commit using sqlca;
ls_sql = "Alter table sys_audit add export_date datetime null;"
execute immediate :ls_sql using sqlca;//070902 maha
commit using sqlca;
ls_sql = "update facility_ver_rules set exp_cred_que_letters_days = 0 where exp_cred_que_letters_days is null;"
execute immediate :ls_sql using sqlca;//070902 maha
commit using sqlca;

ls_sql = "Alter table export_header add save_path varchar(255) null;"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "Alter table export_auto_settings add reset_audit integer null;"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "Alter table export_auto_settings add use_audit integer null;"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "Alter table sys_audit add exported integer null;"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "Alter table sys_audit add export_date timestamp null;"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
//app_field_prop mod
ls_sql = "Alter table app_field_prop drop primary key;"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "Alter table app_field_prop modify app_field_id numeric(10,0) null;"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "Alter table app_field_prop add primary key (app_field_id);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;

ls_sql = "ALTER TABLE sys_tables ADD ver_ltr_sql long varchar NULL;"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "ALTER TABLE sys_tables ADD exp_ltr_sql long varchar NULL;"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "ALTER TABLE icred_settings ADD set_iapply_nav integer NULL;"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "ALTER TABLE sys_letters ADD use_export integer NULL;"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "ALTER TABLE sys_letters ADD export_id integer NULL;"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;

//sys tables and fields for affil stat tables //maha 071002
cb_update.text = "New Sys tables/fields"
st_update.text  = "New Sys Fields/tables" 
of_affil_sys_tables_fields()

ls_sql = "ALTER TABLE icred_settings ADD set_product integer NULL;"
execute immediate :ls_sql using sqlca;//080802 maha
commit using sqlca;
ls_sql = "update icred_settings set set_product = set_9 where set_product is null;"
execute immediate :ls_sql using sqlca;//080802 maha
commit using sqlca;
//\/new settings
ls_sql = "ALTER TABLE icred_settings ADD set_ireport integer NULL;"
execute immediate :ls_sql using sqlca;//080802 maha
commit using sqlca;
ls_sql = "update icred_settings set set_ireport = 0 where set_ireport is null;"
execute immediate :ls_sql using sqlca;//080802 maha
commit using sqlca;

ls_sql = "ALTER TABLE icred_settings ADD set_iauto integer NULL;"
execute immediate :ls_sql using sqlca;//080802 maha
commit using sqlca;
ls_sql = "update icred_settings set set_iauto = 0 where set_iauto is null;"
execute immediate :ls_sql using sqlca;//080802 maha
commit using sqlca;

ls_sql = "ALTER TABLE icred_settings ADD set_iapps integer NULL;"
execute immediate :ls_sql using sqlca;//080802 maha
commit using sqlca;
ls_sql = "update icred_settings set set_iapps = 1 where set_iapps is null;"
execute immediate :ls_sql using sqlca;//080802 maha
commit using sqlca;

ls_sql = "Alter table export_header add prac_sql long varchar null;"
execute immediate :ls_sql using sqlca;//082002 maha
commit using sqlca;

ls_sql = "Alter table data_view_screen_objects modify object_text long varchar null;"
execute immediate :ls_sql using sqlca;//091102 maha
commit using sqlca;

ls_sql = "update code_lookup set description = 'Practitioner Correspondence' where description = 'Practitioner Corrospondence' and lookup_name = 'Verification Method';"
execute immediate :ls_sql using sqlca;//091102 maha
commit using sqlca;


ls_sql = "INSERT INTO security_rights_action VALUES (	1380,	2,	120,	'View Rights',	2);"
execute immediate :ls_sql using sqlca;//091102 maha
commit using sqlca;

ls_sql = "Alter table data_view_screen add screen_alias varchar(50) null;"
execute immediate :ls_sql using sqlca;//092702 maha
commit using sqlca;

ls_sql = "update data_view_screen set screen_alias = screen_name where screen_alias is null;"
execute immediate :ls_sql using sqlca;//092702 maha
commit using sqlca;

ls_sql = "alter table conv_view_links modify link_type char(2) null;"
execute immediate :ls_sql using sqlca;//093002 maha to fix outer join error in intellireport 
commit using sqlca;

ls_sql = "alter table pd_affil_stat add appt_note long varchar null;"
execute immediate :ls_sql using sqlca;//100302 maha 
commit using sqlca;

ls_sql = "ALTER TABLE icred_settings ADD set_meetings integer NULL;"
execute immediate :ls_sql using sqlca;//100402 maha
commit using sqlca;

ls_sql = "update icred_settings set set_meetings = 0 where set_meetings is null;"
execute immediate :ls_sql using sqlca;//100402 maha
commit using sqlca;

ls_sql = "ALTER TABLE data_view_fields ADD label_underline char(1) NULL;"
execute immediate :ls_sql using sqlca;//101102 maha
commit using sqlca;

ls_sql = "ALTER TABLE data_view_fields ADD field_underline char(1) NULL;"
execute immediate :ls_sql using sqlca;//101102 maha
commit using sqlca;


cb_update.text = "New updates"
st_update.text  = "New Updates"

ls_sql = "ALTER TABLE data_view Add type Char(1) null;"
execute immediate :ls_sql using sqlca;//101802 maha
commit using sqlca;
st_sql.text  = ls_sql

ls_sql = "update data_view set type = 'S' where type is null;"
execute immediate :ls_sql using sqlca;//101802 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "ALTER TABLE sys_audit Add facility_id numeric(5,0) null;"
execute immediate :ls_sql using sqlca;//110402 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "update sys_audit set facility_id = 0 where facility_id is null;"
execute immediate :ls_sql using sqlca;//110402 maha
commit using sqlca;
st_sql.text  = ls_sql

end if //from line 1009
//******************************************* 
ls_sql = "ALTER TABLE sys_multi_app DELETE PRIMARY KEY;"
execute immediate :ls_sql using sqlca;//110402 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "ALTER TABLE sys_multi_app modify multi_app_id not null;"
execute immediate :ls_sql using sqlca;//110402 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "ALTER TABLE sys_multi_app modify parent_facility_id not null;"
execute immediate :ls_sql using sqlca;//110402 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql =  "ALTER TABLE sys_multi_app modify app_id not null;"
execute immediate :ls_sql using sqlca;//110402 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "ALTER TABLE sys_multi_app ADD PRIMARY KEY ( multi_app_id,parent_facility_id, app_id );"
execute immediate :ls_sql using sqlca;//110402 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "ALTER TABLE net_dev_ids ADD app_id Numeric( 6,0 ) null;"
execute immediate :ls_sql using sqlca;//110402 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "Alter table sys_audit add exported facility_id null;"
execute immediate :ls_sql using sqlca;//111502 maha
commit using sqlca;
st_sql.text  = ls_sql

cb_update.text = "Intellireport Security"
st_update.text  = "Intellireport Security"
//for intellireport security
ls_sql = "Alter table conv_view add category varchar(40) null;"
execute immediate :ls_sql using sqlca;//111502 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "Alter table conv_view add mod_user varchar(12) null;"
execute immediate :ls_sql using sqlca;//111502 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "update conv_view set mod_user = 'All' where mod_user is null;"
execute immediate :ls_sql using sqlca;//111502 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "Alter table conv_view add created_by varchar(12) null;"
execute immediate :ls_sql using sqlca;//111502 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "Alter table conv_view add create_date timestamp null;"
execute immediate :ls_sql using sqlca;//111502 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "Alter table conv_view_sort add sort_order integer null;"
execute immediate :ls_sql using sqlca;//112202 maha
commit using sqlca;
st_sql.text  = ls_sql

//set reference fields for group covering
ls_sql = "update data_view_screen set reference_field_1 = 11223352 where screen_id = 26 and reference_field_1 is null;"
execute immediate :ls_sql using sqlca;//111502 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "update data_view_screen set reference_field_2 = 11223354 where screen_id = 26 and reference_field_2 is null;"
execute immediate :ls_sql using sqlca;//111502 maha
commit using sqlca;
st_sql.text  = ls_sql

//new ssettings
cb_update.text = "new settings"
st_update.text  = "new settings"

ls_sql = "ALTER TABLE icred_settings ADD set_21 integer NULL;"
execute immediate :ls_sql using sqlca;//112202 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "update icred_settings set set_21 = 0 where set_21 is null;"
execute immediate :ls_sql using sqlca;//112202 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "ALTER TABLE icred_settings ADD set_22 integer NULL;"
execute immediate :ls_sql using sqlca;//112202 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "update icred_settings set set_22 = 0 where set_22 is null;"
execute immediate :ls_sql using sqlca;//112202 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "ALTER TABLE icred_settings ADD set_23 integer NULL;"
execute immediate :ls_sql using sqlca;//112202 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "update icred_settings set set_23 = 0 where set_23 is null;"
execute immediate :ls_sql using sqlca;//112202 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "ALTER TABLE icred_settings ADD set_24 integer NULL;"
execute immediate :ls_sql using sqlca;//112202 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "update icred_settings set set_24 = 0 where set_24 is null;"
execute immediate :ls_sql using sqlca;//112202 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "ALTER TABLE icred_settings ADD set_25 integer NULL;"
execute immediate :ls_sql using sqlca;//112202 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "update icred_settings set set_25 = 0 where set_25 is null;"
execute immediate :ls_sql using sqlca;//112202 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "ALTER TABLE icred_settings ADD set_26 integer NULL;"
execute immediate :ls_sql using sqlca;//112202 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "update icred_settings set set_26 = 0 where set_26 is null;"
execute immediate :ls_sql using sqlca;//112202 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "ALTER TABLE icred_settings ADD set_27 integer NULL;"
execute immediate :ls_sql using sqlca;//112202 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "update icred_settings set set_27 = 0 where set_27 is null;"
execute immediate :ls_sql using sqlca;//112202 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "ALTER TABLE icred_settings ADD set_28 integer NULL;"
execute immediate :ls_sql using sqlca;//112202 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "update icred_settings set set_28 = 0 where set_28 is null;"
execute immediate :ls_sql using sqlca;//112202 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "ALTER TABLE icred_settings ADD set_29 integer NULL;"
execute immediate :ls_sql using sqlca;//112202 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "update icred_settings set set_29 = 0 where set_29 is null;"
execute immediate :ls_sql using sqlca;//112202 maha
commit using sqlca;
ls_sql = "ALTER TABLE icred_settings ADD set_30 integer NULL;"
execute immediate :ls_sql using sqlca;//112202 maha
commit using sqlca;
ls_sql = "update icred_settings set set_30 = 0 where set_30 is null;"
execute immediate :ls_sql using sqlca;//112202 maha
commit using sqlca;
ls_sql = "ALTER TABLE ids ADD database_backup_path varchar(100) NULL;"
execute immediate :ls_sql using sqlca;//112202 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "ALTER TABLE facility ADD ia_reapp_app Numeric( 8,0) NULL;"
execute immediate :ls_sql using sqlca;//112202 maha
commit using sqlca;
ls_sql = "ALTER TABLE facility ADD ia_reapp_ai_process Char(15) NULL;"
execute immediate :ls_sql using sqlca;//112202 maha
commit using sqlca;

ls_sql = "update ids set picture_path = imaging_path where picture_path is null;"
execute immediate :ls_sql using sqlca;//112202 maha
commit using sqlca;
st_sql.text  = ls_sql

cb_update.text = "Additional"
st_update.text  = "Additional"
ls_sql = "CREATE TABLE app_err_log (	prac_id decimal(16, 0) null,	facility_id float null,	app_id decimal(16, 0) null,	app_fld_id decimal(16, 0) null,	page_no float null,	err_msg char(100) null,	rec_id decimal(16, 0) null);"
execute immediate :ls_sql using sqlca;
commit using sqlca;//jad 11/29/02

ls_sql = "CREATE UNIQUE INDEX indx_group_practice_rec_id ON app_err_log (rec_id ASC); "
execute immediate :ls_sql using sqlca;
commit using sqlca;//jad 11/29/02

ls_sql = "ALTER TABLE net_dev_ids ADD tier Numeric( 8,0)  NULL;"
execute immediate :ls_sql using sqlca;//121602 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "insert into code_lookup (lookup_code, lookup_name, code, description) values (3000,'Tier','Tier1','Tier 1');"
execute immediate :ls_sql using sqlca;//112202 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "alter table pd_affil_dept add from_date timestamp null;"
execute immediate :ls_sql using sqlca;//121602 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "alter table pd_affil_dept add to_date timestamp null;"
execute immediate :ls_sql using sqlca;//121602 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "alter table pd_affil_dept add record_status integer null;"
execute immediate :ls_sql using sqlca;//121602 maha
commit using sqlca;
st_sql.text  = ls_sql


ls_sql = "insert into code_lookup(lookup_code,lookup_name,code,description) values (-77,'Meeting Location','EXT CME','External CME Meeting' ) ;"
execute immediate :ls_sql using sqlca;//121602 maha
commit using sqlca;
st_sql.text  = ls_sql

ls_sql = "alter table security_users add version_build varchar(25) null;"
execute immediate :ls_sql using sqlca;//011403 maha
commit using sqlca;
st_sql.text  = ls_sql

//new security 01-03
cb_update.text = "New Security"
st_update.text  = "New Security"

ls_sql = "INSERT INTO security_sub_module VALUES (	120,	2,	'Network Development');"
execute immediate :ls_sql using sqlca;//012003 maha
commit using sqlca;
ls_sql = "INSERT INTO security_sub_module  VALUES (	130,	23,	'Site Survey');"
execute immediate :ls_sql using sqlca;//012003 maha
commit using sqlca;
ls_sql = "INSERT INTO security_sub_module  VALUES (	140,	25,	'Delete Practitioner');"
execute immediate :ls_sql using sqlca;//012003 maha
commit using sqlca;
ls_sql = "INSERT INTO security_sub_module  VALUES (	150,	25,	'Audit Trail');"
execute immediate :ls_sql using sqlca;//012003 maha
commit using sqlca;
ls_sql = "update security_sub_module  set sub_module_name = 'Meetings' where sub_module_id = 7 ;"
execute immediate :ls_sql using sqlca;//012003 maha
commit using sqlca;
ls_sql = "INSERT INTO security_sub_module  VALUES (	160,	24,	'Application Mapping');"
execute immediate :ls_sql using sqlca;//012203 maha
commit using sqlca;
ls_sql = "update security_sub_module  set sub_module_name = 'Application Printing' where sub_module_id = 70 ;"
execute immediate :ls_sql using sqlca;//012203 maha
commit using sqlca;

ls_sql = "INSERT INTO security_rights_action VALUES (	1380,	25,	80,	'Access to App Settings ',	1);"
execute immediate :ls_sql using sqlca;//012003 maha
commit using sqlca;
ls_sql = "INSERT INTO security_rights_action  VALUES (	1390,	2,	38,	'Change Page & Count ',	1);"
execute immediate :ls_sql using sqlca;//012003 maha
commit using sqlca;
ls_sql = "INSERT INTO security_rights_action  VALUES (	1400,	2,	120,	'View',	2);"
execute immediate :ls_sql using sqlca;//012003 maha
commit using sqlca;
ls_sql = "INSERT INTO security_rights_action  VALUES (	1420,	10,	29,	'Auto Export Access',	1);"
execute immediate :ls_sql using sqlca;//012003 maha
commit using sqlca;
ls_sql = "INSERT INTO security_rights_action  VALUES (	1430,	23,	130,	'View',	2);"
execute immediate :ls_sql using sqlca;//012003 maha
commit using sqlca;
ls_sql = "INSERT INTO security_rights_action  VALUES (	1440,	25,	140,	'Access',	1);"
execute immediate :ls_sql using sqlca;//012003 maha
commit using sqlca;
ls_sql = "INSERT INTO security_rights_action  VALUES (	1450,	23,	150,	'Access',	1);"
execute immediate :ls_sql using sqlca;//012003 maha
commit using sqlca;
ls_sql = "INSERT INTO security_rights_action  VALUES (	1460,	24,	160,	'Access',	1);"
execute immediate :ls_sql using sqlca;//012003 maha
commit using sqlca;

ls_sql = "update security_sub_module  set sub_module_name = 'Network Development' where sub_module_id = 120 ;"
execute immediate :ls_sql using sqlca;//012703 maha
commit using sqlca;


ls_sql = "CREATE INDEX idx_net_devp_ids ON net_dev_ids (	facility_id ASC,plan_assigned_id ASC,plan_type ASC);"
execute immediate :ls_sql using sqlca;//012203 maha
commit using sqlca;
ls_sql = "DROP INDEX idx_net_dev_ids;"
execute immediate :ls_sql using sqlca;//012203 maha
commit using sqlca;
//\

//OIG fields
cb_update.text = "OIG Fields"
st_update.text  = "OIG Fields"
ls_sql = "Alter table pd_basic Add oig_query integer null DEFAULT 0;"
execute immediate :ls_sql using sqlca;//012103 maha
commit using sqlca;

ls_sql = "INSERT INTO sys_fields VALUES (25,11223390,	310,'oig_query','N',8,'Query OIG',NULL,	'C','Y','Yes/No','Code','Y',NULL,NULL,	NULL,NULL,'Y',NULL,NULL,NULL,100,8,0,NULL);"
execute immediate :ls_sql using sqlca;//012103 maha
commit using sqlca;
ls_sql = "INSERT INTO DATA_VIEW_FIELDS VALUES (23043,	1,1,11223390,'Query OIG',120,'N','N','N',NULL,'N',NULL,	0,519,1450,354,	64,'0',	NULL,NULL,'E',0,523,660,307,'Y',NULL,0,0,null,null);"
execute immediate :ls_sql using sqlca;//012103 maha
commit using sqlca;

ls_sql = "Alter table ids Add last_oig_update date null;"
execute immediate :ls_sql using sqlca;//012203 maha
commit using sqlca;

ls_sql = "Alter table facility Add oig_verify_data char (1) null;"
execute immediate :ls_sql using sqlca;//012203 maha
commit using sqlca;
ls_sql = "Alter table facility Add oig_auto_lname integer null default 0;"
execute immediate :ls_sql using sqlca;//012203 maha
commit using sqlca;
ls_sql = "Alter table facility Add oig_auto_fname integer null default 0;"
execute immediate :ls_sql using sqlca;//012203 maha
commit using sqlca;
ls_sql = "Alter table facility Add oig_auto_dob integer null default 0;"
execute immediate :ls_sql using sqlca;//012203 maha
commit using sqlca;
ls_sql = "update facility set oig_auto_lname = 0 where oig_auto_lname is null;"
execute immediate :ls_sql using sqlca;//012203 maha
commit using sqlca;
ls_sql = "update facility set oig_auto_fname = 0 where oig_auto_fname is null;"
execute immediate :ls_sql using sqlca;//012203 maha
commit using sqlca;
ls_sql = "update facility set oig_auto_dob = 0 where oig_auto_dob is null;"
execute immediate :ls_sql using sqlca;//012203 maha
commit using sqlca;

ls_sql = "Alter table ids Add oig_url varchar(150) null;"
execute immediate :ls_sql using sqlca;//012803 maha
commit using sqlca;

ls_sql = "CREATE TABLE  (	lastname char(20) null,	firstname char(15) null,	midname char(15) null,	busname char(30) null,	general char(20) null,	specialty char(20) null,	upin char(6) null,	dob char(8) null,	address char(30) null,	city char(20) null,	state char(2) null,	zip char(5) null,	sanctype char(9) null,	sancdate char(8) null,	reindate char(8) null);"
execute immediate :ls_sql using sqlca;//012203 maha
commit using sqlca;

ls_sql = "insert into code_lookup (lookup_code, lookup_name, code, description) values (20,'Verification Method','OIG QUERY','OIG Query');"
execute immediate :ls_sql using sqlca;//112202 maha
commit using sqlca;

ls_sql = "alter table export_fields add aggre_function char(10) null;"
execute immediate :ls_sql using sqlca;//012703 maha
commit using sqlca;

ls_sql = "CREATE TABLE pd_contingency_fs  (	rec_id decimal(16, 0) null,	facility_id integer null,	prac_id decimal(16, 0) null,	contingency  decimal(16, 0) NULL,	cont_date datetime NULL,	notes char(255) NULL,	cust_1 char(50) NULL,	cust_2 char(50) NULL,	cust_3 char(50) NULL,	cust_4 char(50) NULL,	cust_5 char(50) NULL,   active_status integer  null default 1, primary key (rec_id));"
execute immediate :ls_sql using sqlca;//012803 maha  for lij
commit using sqlca;

ls_sql = "INSERT INTO sys_tables VALUES (	50,	'pd_contingency_fs',	'Contingency FS',	NULL,	1,null,null);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	50,	100250,	0,	'rec_id',	'N',	12,	'Record ID',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//012803 maha  for lij
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	50,	100252,	0,	'facility_id',	'N',	6,	'Facility ID',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//012803 maha  for lij
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	50,	100254,	20,	'cont_date',	'D',	12,	'Contingency Date',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//012803 maha  for lij
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	50,	100251,	0,	'prac_id',	'N',	12,	'Prac ID',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//012803 maha  for lij
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	50,	100253,	10,	'contingency',	'N',	12,	'Contingency',	NULL,	'C',	'Y',	'Contingency Status',	'B',	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//012803 maha  for lij
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	50,	100255,	30,	'active_status',	'N',	1,	'Active Status',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//012803 maha  for lij
commit using sqlca;





cb_update.text = "Net Dev sys Fields"
st_update.text  = "Net Dev sys Fields"

ls_sql = "INSERT INTO sys_tables VALUES (	51,	'net_dev_action_items',	'Net Dev Action Items',	NULL,	1,null,null);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;
ls_sql = "INSERT INTO sys_tables VALUES (	52,	'net_dev_ids',	'Net Dev Ids',	NULL,	1,null,null);"
execute immediate :ls_sql using sqlca;//071502 maha
commit using sqlca;

ls_sql = "INSERT INTO sys_fields VALUES (	51,	100257,	0,	'prac_id',	'N',	12,	'Prac ID',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//012903 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	51,	100256,	0,	'rec_id',	'N',	12,	'Rec ID',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//012903 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	51,	100258,	0,	'facility_id',	'N',	5,	'Facility ID',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//012903 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	51,	100259,	10,	'action_type',	'N',	12,	'Action Type',	NULL,	'C',	'Y',	'Action Type',	'B',	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//012903 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	51,	100260,	30,	'action_date',	'D',	20,	'Action Date',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,);"
execute immediate :ls_sql using sqlca;//012903 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	51,	100261,	40,	'action_dept',	'N',	12,	'Action Deptment',	NULL,	'C',	'Y',	'Action Department',	'C',	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//012903 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	51,	100262,	50,	'action_user',	'C',	10,	'Action User',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//012903 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	51,	100263,	60,	'next_action_date',	'D',	12,	'Next Action Date',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//012903 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	51,	100264,	70,	'action_contact',	'C',	50,	'Action Contact',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//012903 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	51,	100265,	20,	'action_status',	'N',	12,	'Action Status',	NULL,	'C',	'Y',	'Action Status',	'C',	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//012903 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	51,	100266,	80,	'app_id',	'N',	5,	'App ID',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//012903 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	51,100267,	90,	'active_status',	'N',	5,	'Active Status',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);I"
execute immediate :ls_sql using sqlca;//012903 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	51,	100268,	0,	'seq_no',	'N',	5,	'Sequence NO',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//012903 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	51,	100269,	100,	'app_type',	'C',	1,	'App Type',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//012903 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	52,	100270,	0,	'rec_id',	'N',	12,	'Record ID',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//012903 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	52,	100271,	0,	'prac_id',	'N',	12,	'Prac ID',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//012903 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	52,	100272,	0,	'facility_id',	'N',	5,	'Facility ID',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//012903 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	52,	100273,	10,	'plan_type',	'N',	12,	'Plan Type',	NULL,	'C',	'Y',	'Plan Type',	'B',	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//012903 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	52,	100274,	20,	'plan_assigned_id',	'C',	20,	'Plan Assigned Id',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//012903 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	52,	100275,	30,	'start_date',	'D',	20,	'Start Date',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//012903 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	52,	100276,	40,	'end_date',	'D',	20,	'End Date',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//012903 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	52,	100277,	50,	'tier',	'N',	12,	'tier',	NULL,	'C',	'Y',	'Tier',	'B',	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//012903 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	52,	100278,	60,	'tax_id',	'C',	10,	'Tax ID',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//012903 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	32,	100279,	80,	'from_date',	'D',	20,	'From Date',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//012903 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	32,	100280,	90,	'to_date',	'D',	20,	'To Date',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//012903 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	32,	100281,	100,	'record_status',	'N',	5,	'Record Status',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//012903 maha 
commit using sqlca;
ls_sql = "alter table icred_settings add app_map_style  Integer null;  "
execute immediate :ls_sql using sqlca;//012903 maha 
commit using sqlca;
ls_sql = "update icred_settings set app_map_style = 0 where app_map_style is null;  "
execute immediate :ls_sql using sqlca;//012903 maha 
commit using sqlca;


cb_update.text = "Link sys_fields"
st_update.text  = "Link sys_fields"

ls_sql = "INSERT INTO sys_tables VALUES (	61,	'pd_hosp_facility_link',	'Hospital Facility Link',	NULL,	1,NULL,	NULL);"
execute immediate :ls_sql using sqlca;//021903 maha  
commit using sqlca;

ls_sql = "INSERT INTO sys_tables VALUES (	62,	'pd_spec_facility_link',	'Specialty Facility Link',	NULL,	1,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//021903 maha  
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	61,	22225011,	1,	'hosp_affil_id',	'N',	8,	'hosp_affil_id',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//021903 maha  
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	61,	22225011,	1,	'hosp_affil_id',	'N',	8,	'hosp_affil_id',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//012903 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	61,	22225011,	1,	'hosp_affil_id',	'N',	8,	'hosp_affil_id',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//012903 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	61,	22225012,	2,	'prac_id',	'N',	8,	'prac_id',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//012903 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	61,	22225013,	3,	'facility_id',	'N',	8,	'facility_id',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//012903 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	61,	22225014,	4,	'primary_hosp',	'N',	8,	'primary_hosp',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//012903 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	61,	22225015,	5,	'conv_prac_id',	'N',	8,	'conv_prac_id',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//021903 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	62,	22225016,	1,	'specialty_id',	'N',	8,	'specialty_id',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//021903 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	62,	22225017,	2,	'prac_id',	'N',	8,	'prac_id',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//021903 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	62,	22225018,	3,	'facility_id',	'N',	8,	'facility_id',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//012903 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	62,	22225020,	5,	'conv_prac_id',	'N',	8,	'conv_prac_id',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//012903 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	62,	22225019,	4,	'practicing',	'N',	8,	'practicing',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//012903 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	60,	22225000,	1,	'address_id',	'N',	10,	'Address ID',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//012903 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	60,	22225001,	2,	'prac_id',	'N',	8,	'Prac Id',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//012903 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	60,	22225002,	3,	'facility_id',	'N',	8,	'Facility Id',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//012903 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	60,	22225003,	4,	'mailing',	'N',	8,	'Mailing',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//012903 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	60,	22225004,	5,	'billing',	'N',	8,	'Billing',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//012903 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	60,	22225006,	7,	'include_in_directory',	'N',	8,	'Include In Directory',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//012903 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	60,	22225007,	8,	'prac_correspondence',	'N',	8,	'Prac Corro',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//012903 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	60,	22225008,	9,	'exp_letters',	'N',	8,	'Exp Letters',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//021903 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	60,	22225009,	10,	'home_address',	'N',	8,	'Home Address',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//012903 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	60,	22225010,	11,	'additional_office',	'N',	8,	'Additional Office',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//012903 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_tables VALUES (	53,	'pd_address_link',	'Address Link',	NULL,	1,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//021903 maha  
commit using sqlca;
ls_sql = "CREATE TABLE conv_merge_connect (	project_id float null,	from_connection char(30) null,	to_connection char(30) null,	basic_info_key_field_1 float null,	basic_info_key_field_2 float null,	basic_info_key_field_3 float null,	basic_info_key_field_4 float null);"
execute immediate :ls_sql using sqlca;//021903 maha  
commit using sqlca;
ls_sql = "CREATE TABLE conv_merge_tables (	project_id integer null,	table_id integer null,	merge_data integer null,	notes char(32767) null,	merge_order integer null,facility_specific integer null,always_use_from_data integer NULL);"
execute immediate :ls_sql using sqlca;//021903 maha  
commit using sqlca;
ls_sql = "CREATE TABLE conv_merge_field_rules (	project_id float null,	table_id float null,	field_id numeric(8,0) null,	key_field integer null,	log_differences integer null);"
execute immediate :ls_sql using sqlca;//021903 maha  
commit using sqlca;
ls_sql = "CREATE TABLE conv_merge_log (	project_id float null,	table_id float null,	field_id float null,	prac_id decimal(16, 0) null,	rec_id decimal(16, 0) null,	seq_no decimal(16, 0) null,	log_msg char(255) null);"
execute immediate :ls_sql using sqlca;//021903 maha 
commit using sqlca;

ls_sql = "Alter table export_header Add lock_cols integer null;"
execute immediate :ls_sql using sqlca;//022003 maha 
commit using sqlca;
ls_sql = "Alter table export_fields Add sort_by varchar(250) null;"
execute immediate :ls_sql using sqlca;//022503 maha 
commit using sqlca;

ls_sql = "ALTER TABLE conv_view_fields ADD group_by_field integer NULL;"
execute immediate :ls_sql using sqlca;//031103 maha 
commit using sqlca;
ls_sql = "ALTER TABLE conv_view_fields ADD aggregate_type char(5) NULL;"
execute immediate :ls_sql using sqlca;//031103 maha 
commit using sqlca;

// professional assoc end date (lij)
ls_sql = "Alter table pd_prof_assoc Add assoc_end_date timestamp null;"
execute immediate :ls_sql using sqlca;//031703 maha
commit using sqlca;

ls_sql = "INSERT INTO sys_fields VALUES (15,16000,	310,'assoc_end_date','D',12,'Assoc End Date',NULL,	null,null,null,null,null,NULL,NULL,	NULL,NULL,'Y',NULL,NULL,NULL,100,12,0,NULL);"
execute immediate :ls_sql using sqlca;//031703 maha
commit using sqlca;

ls_sql = "INSERT INTO DATA_VIEW_FIELDS VALUES (16010,	1,14,16000,'Assoc End Date',120,'N','N','N',NULL,'Y',120,	40,500,800,354,	64,'0',	NULL,NULL,'E',0,5,700,307,'N',NULL,0,0,null,null);"
execute immediate :ls_sql using sqlca;//031703 maha
commit using sqlca;

ls_sql = "Alter table oig_data Add rec_id numeric(10,0) null;"
execute immediate :ls_sql using sqlca;//031903 maha 
commit using sqlca;

ls_sql = "insert into code_lookup (lookup_code, lookup_name, code, description,type) values (11000,'Credentials Verification Response','SAT OIG','No match found in OIG search','S');"
execute immediate :ls_sql using sqlca;//032603 maha
commit using sqlca;

ls_sql = "update ids set oig_url = 'http://www.oig.hhs.gov/fraud/exclusions/downloadables/updatedleie.exe' where oig_url = null;"
execute immediate :ls_sql using sqlca;//032803 maha
commit using sqlca;

//OIG sanction lookup
cb_update.text = "OIG Sanctions"
st_update.text  = "OIG Sanctions"
select count(lookup_code) into :cnt from code_lookup where lookup_name = 'OIG Sanctions';
if cnt < 1 then
	ls_sql = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description ) VALUES (11001, 	'OIG Sanctions',	'1128a1',	'Conviction of program-related crimes. Minimum Period: 5 years', 'S');"
	execute immediate :ls_sql using sqlca;//032803 maha 
	commit using sqlca;
	ls_sql = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description ) VALUES (	11002,	'OIG Sanctions',	'1128a2',	'Conviction relating to patient abuse or neglect', 'S');"
	execute immediate :ls_sql using sqlca;//032803 maha 
	commit using sqlca;
	ls_sql = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description ) VALUES (	11003,	'OIG Sanctions',	'1128a3',	'Felony conviction relating to health care fraud', 'S');"
	execute immediate :ls_sql using sqlca;//032803 maha 
	commit using sqlca;
	ls_sql = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description ) VALUES (	11004,	'OIG Sanctions',	'1128a4',	'Felony conviction relating to controlled substance', 'S');"
	execute immediate :ls_sql using sqlca;//032803 maha 
	commit using sqlca;
	ls_sql = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (	11005,	'OIG Sanctions',	'1128c3gi',	'Conviction of two mandatory exclusion offenses', 'S');"
	execute immediate :ls_sql using sqlca;//032803 maha 
	commit using sqlca;
	ls_sql = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (	11006,	'OIG Sanctions',	'1128c3gi',	'Conviction on 3 or more occasions of mandatory exclusion offenses', 'S');"
	execute immediate :ls_sql using sqlca;//032803 maha 
	commit using sqlca;
	ls_sql = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (	11007,	'OIG Sanctions',	'1892',	'Failure to enter an agreement to repay HEAL loan', 'S');"
	execute immediate :ls_sql using sqlca;//032803 maha 
	commit using sqlca;
	ls_sql = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (	11008,	'OIG Sanctions',	'1128b1a',	'Misdemeanor conviction relating to health care fraud', 'S');"
	execute immediate :ls_sql using sqlca;//032803 maha 
	commit using sqlca;
	ls_sql = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (	11009,	'OIG Sanctions',	'1128b1b',	'Conviction relating to fraud in non- health care programs', 'S');"
	execute immediate :ls_sql using sqlca;//032803 maha 
	commit using sqlca;
	ls_sql = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (	11010,	'OIG Sanctions',	'1128b2',	'Conviction relating to obstruction of an investigation', 'S');"
	execute immediate :ls_sql using sqlca;//032803 maha 
	commit using sqlca;
	ls_sql = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (	11010,	'OIG Sanctions',	'1128b2',	'Conviction relating to obstruction of an investigation', 'S');"
	execute immediate :ls_sql using sqlca;//032803 maha 
	commit using sqlca;
	ls_sql = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (	11010,	'OIG Sanctions',	'1128b2',	'Conviction relating to obstruction of an investigation', 'S');"
	execute immediate :ls_sql using sqlca;//032803 maha 
	commit using sqlca;
	ls_sql = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (	11011,	'OIG Sanctions',	'1128b3',	'Misdemeanor conviction relating  to controlled substance', 'S');"
	execute immediate :ls_sql using sqlca;//032803 maha 
	commit using sqlca;
	ls_sql = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (	11012,	'OIG Sanctions',	'1128b4',	'License revocation or suspension', 'S');"
	execute immediate :ls_sql using sqlca;//032803 maha 
	commit using sqlca;
	ls_sql = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (	11013,	'OIG Sanctions',	'1128b5',	'Exclusion or suspension under federal or state health care program', 'S');"
	execute immediate :ls_sql using sqlca;//032803 maha 
	commit using sqlca;
	ls_sql = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (	11014,	'OIG Sanctions',	'1128b6',	'Claims for excessive charges, unnecessary services', 'S');"
	execute immediate :ls_sql using sqlca;//032803 maha 
	commit using sqlca;
	ls_sql = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (	11015,	'OIG Sanctions',	'1128b7',	'Fraud, kickbacks, and other prohibited activities', 'S');"
	execute immediate :ls_sql using sqlca;//032803 maha 
	commit using sqlca;
	ls_sql = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (	11016,	'OIG Sanctions',	'1128b8',	'Entities controlled by a sanctioned individual', 'S');"
	execute immediate :ls_sql using sqlca;//032803 maha 
	commit using sqlca;
	ls_sql = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (	11017,	'OIG Sanctions',	'1128b8a',	'Entities controlled by a family member of an excluded individual', 'S');"
	execute immediate :ls_sql using sqlca;//032803 maha 
	commit using sqlca;
	ls_sql = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (	11018,	'OIG Sanctions',	'1128b9',	'Failure to disclose required information, supply requested information', 'S');"
	execute immediate :ls_sql using sqlca;//032803 maha 
	commit using sqlca;
	ls_sql = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (	11019,	'OIG Sanctions',	'1128b10',	'Failure to disclose required information, supply requested information', 'S');"
	execute immediate :ls_sql using sqlca;//032803 maha 
	commit using sqlca;
	ls_sql = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (	11020,	'OIG Sanctions',	'1128b11',	'Failure to disclose required information, supply requested information', 'S');"
	execute immediate :ls_sql using sqlca;//032803 maha 
	commit using sqlca;
	ls_sql = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (	11021,	'OIG Sanctions',	'1128b12',	'Failure to grant immediate access', 'S');"
	execute immediate :ls_sql using sqlca;//032803 maha 
	commit using sqlca;
	ls_sql = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (	11022,	'OIG Sanctions',	'1128b13',	'Failure to take corrective action', 'S');"
	execute immediate :ls_sql using sqlca;//032803 maha 
	commit using sqlca;
	ls_sql = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (	11023,	'OIG Sanctions',	'1128b14',	'Default on health education loan or scholarship obligations', 'S');"
	execute immediate :ls_sql using sqlca;//032803 maha 
	commit using sqlca;
	ls_sql = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (	11024,	'OIG Sanctions',	'1128b15',	'Individuals controlling a sanctioned entity', 'S');"
	execute immediate :ls_sql using sqlca;//032803 maha 
	commit using sqlca;
	ls_sql = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (	11025,	'OIG Sanctions',	'1156',	'Failure to meet statutory obligations (Peer Review Org (PRO) findings)', 'S');"
	execute immediate :ls_sql using sqlca;//032803 maha 
	commit using sqlca;
end if

ls_sql = "CREATE INDEX indx_oig_data_lastname ON oig_data (lastname ASC); "
execute immediate :ls_sql using sqlca;//040203 maha 
commit using sqlca;
ls_sql = "CREATE INDEX indx_oig_data_firstname ON oig_data (firstname ASC); "
execute immediate :ls_sql using sqlca;//040203 maha
commit using sqlca;
ls_sql = "CREATE INDEX indx_oig_data_dob ON oig_data (dob ASC); "
execute immediate :ls_sql using sqlca;//040203 maha
commit using sqlca;

ls_sql = "Alter table icred_settings add dev_title varchar(50) null;"
execute immediate :ls_sql using sqlca;//040403 maha 
commit using sqlca;

ls_sql = "create table sys_filter_list (filter_id numeric (10,0) null,filter_name varchar(40) null,created_from varchar(40) null,create_by char(15) null,mod_by char(15) null,create_date date null, last_mod date null, last_used date null, primary key (filter_id));"
execute immediate :ls_sql using sqlca;//040403 maha  
commit using sqlca;
ls_sql = "Create table sys_filter_items (filter_id numeric (10,0) null,item_id numeric (10,0) null,table_id integer null, field_id numeric(10,0) null, primary key(filter_id,item_id));"
execute immediate :ls_sql using sqlca;//040403 maha 
commit using sqlca;
ls_sql = "create table sys_batch_list (batch_id numeric (10,0) null,batch_name varchar(50) null,saved_from varchar(40) null,create_by char(15) null,mod_by char(15) null,create_date date null, last_mod date null, last_used date null, primary key (batch_id));"
execute immediate :ls_sql using sqlca;//040403 maha  
commit using sqlca;
ls_sql = "Create table sys_batch_items (batch_id numeric (10,0) null,item_id numeric (10,0) null,prac_id integer null, primary key(batch_id,item_id));"
execute immediate :ls_sql using sqlca;//040403 maha 
commit using sqlca;
//new intellireport fields
ls_sql = "ALTER TABLE conv_view_fields ADD avg_fld Integer NULL;"
execute immediate :ls_sql using sqlca;//040403 maha 
commit using sqlca;
ls_sql = "ALTER TABLE conv_view_fields ADD sum_fld Integer NULL; "
execute immediate :ls_sql using sqlca;//040403 maha 
commit using sqlca;
ls_sql = "ALTER TABLE conv_view_fields ADD count_fld Integer NULL;"
execute immediate :ls_sql using sqlca;//040403 maha 
commit using sqlca;
ls_sql = "ALTER TABLE conv_view_fields ADD label_font_style Char(5) NULL;"
execute immediate :ls_sql using sqlca;//040403 maha 
commit using sqlca;
ls_sql = "ALTER TABLE conv_view_fields ADD field_font_style Char(5) NULL;"
execute immediate :ls_sql using sqlca;//040403 maha 
commit using sqlca;


if 1 = 2 then //new indexes set not to run
	ls_sql = "CREATE  INDEX idx_app_field_prop_app_id ON app_field_prop( app_id ASC );"
	 execute immediate :ls_sql using sqlca;//051603 maha 
	commit using sqlca;
	ls_sql = "CREATE  INDEX idx_app_field_prop_table_id ON app_field_prop( table_id ASC );"
	 execute immediate :ls_sql using sqlca;//051603 maha 
	commit using sqlca;
	ls_sql = "CREATE UNIQUE INDEX idx_hosp_facility_link ON pd_hosp_facility_link( hosp_affil_id ASC, facility_id ASC );"
	 execute immediate :ls_sql using sqlca;//051603 maha 
	commit using sqlca;
	ls_sql = "CREATE  INDEX idx_pd_hosp_facility_link_prac_id ON pd_hosp_facility_link( prac_id ASC );"
	 execute immediate :ls_sql using sqlca;//051603 maha 
	commit using sqlca;
	ls_sql = "CREATE  INDEX idx_pd_address_prac_id_active_stat ON pd_address( prac_id ASC, active_status ASC );"
	 execute immediate :ls_sql using sqlca;//051603 maha 
	commit using sqlca;
	ls_sql = "CREATE  INDEX idx_pd_spec_facility_link_prac_id ON pd_spec_facility_link( prac_id ASC );"
	 execute immediate :ls_sql using sqlca;//051603 maha 
	commit using sqlca;
	ls_sql = "CREATE UNIQUE INDEX idx_pd_spec_facility_link ON pd_spec_facility_link( specialty_id ASC, facility_id ASC );"
	 execute immediate :ls_sql using sqlca;//051603 maha 
	commit using sqlca;
	ls_sql = "CREATE UNIQUE INDEX idx_pd_address_link ON pd_address_link( address_id ASC, facility_id ASC );"
	 execute immediate :ls_sql using sqlca;//051603 maha 
	commit using sqlca;
	ls_sql = "CREATE UNIQUE INDEX idx_committee_lookup_committee_id ON committee_lookup( committee_id ASC );"
	 execute immediate :ls_sql using sqlca;//051603 maha 
	commit using sqlca;
	ls_sql = "CREATE UNIQUE INDEX idx_committee_lookup ON committee_lookup( committee_id ASC, facility_id ASC );"
	 execute immediate :ls_sql using sqlca;//051603 maha 
	commit using sqlca;
	ls_sql = "CREATE  INDEX idx_pd_affil_stat_prac_id ON pd_affil_stat( prac_id ASC );"
	 execute immediate :ls_sql using sqlca;//051603 maha 
	commit using sqlca;
	ls_sql = "CREATE  INDEX idx_pd_affil_stat_prac_id_parent_facility_id ON pd_affil_stat( prac_id ASC, parent_facility_id ASC );"
	 execute immediate :ls_sql using sqlca;//051603 maha 
	commit using sqlca;
	ls_sql = "CREATE  INDEX idx_pd_affil_staff_leave_prac_id ON pd_affil_staff_leave( prac_id ASC );"
	 execute immediate :ls_sql using sqlca;//051603 maha 
	commit using sqlca;
	ls_sql = "CREATE  INDEX idx_pd_affil_staff_leave_prac_id_facility_id ON pd_affil_staff_leave( prac_id ASC, facility_id ASC );"
	 execute immediate :ls_sql using sqlca;//051603 maha 
	commit using sqlca;
	ls_sql = "CREATE  INDEX idx_pd_affil_dept_prac_id ON pd_affil_dept( prac_id ASC );"
	 execute immediate :ls_sql using sqlca;//051603 maha 
	commit using sqlca;
	ls_sql = "CREATE  INDEX idx_pd_affil_staff_cat_prac_id ON pd_affil_staff_cat( prac_id ASC );"
	 execute immediate :ls_sql using sqlca;//051603 maha 
	commit using sqlca;
	ls_sql = "CREATE UNIQUE INDEX idx_pd_app_audit_rec_id ON pd_app_audit( record_id ASC );"
	 execute immediate :ls_sql using sqlca;//051603 maha 
	commit using sqlca;
	ls_sql = "CREATE UNIQUE INDEX idx_security_user_facility_facility_id ON security_user_facilities( facility_id ASC );"
	 execute immediate :ls_sql using sqlca;//051603 maha 
	commit using sqlca;
	ls_sql = "CREATE  INDEX idx_pd_affil_stat_prac_id_ver_facility_id ON pd_affil_stat( prac_id ASC, verifying_facility ASC );"
	 execute immediate :ls_sql using sqlca;//051603 maha 
	commit using sqlca;
	ls_sql = "CREATE UNIQUE INDEX idx_facility_facility_id ON facility( facility_id ASC );"
	 execute immediate :ls_sql using sqlca;//051603 maha 
	commit using sqlca;
	ls_sql = "CREATE  INDEX idx_facility_ver_rules_facility_id ON facility_ver_rules( facility_id ASC );"
	 execute immediate :ls_sql using sqlca;//051603 maha 
	commit using sqlca;
	ls_sql = "CREATE  INDEX idx_pd_basic_last_name ON pd_basic( last_name ASC );"
	 execute immediate :ls_sql using sqlca;//051603 maha 
	commit using sqlca;
	ls_sql = "CREATE  INDEX idx_data_view_screen ON data_view_screen( table_id ASC );"
	 execute immediate :ls_sql using sqlca;//051603 maha 
	commit using sqlca;
	ls_sql = "CREATE  INDEX idx_data_view_screen_screen_id_table_id ON data_view_screen( screen_id ASC, table_id ASC );"
	 execute immediate :ls_sql using sqlca;//051603 maha 
	commit using sqlca;
	ls_sql = "CREATE  INDEX idx_data_view_screen_screen_id ON data_view_screen( screen_id ASC );"
	 execute immediate :ls_sql using sqlca;//051603 maha 
	commit using sqlca;
	ls_sql = "CREATE  INDEX data_view_screen_screen_id ON data_view_screen(screen_id ASC );"
	 execute immediate :ls_sql using sqlca;//051603 maha 
	commit using sqlca;
	ls_sql = "CREATE  INDEX idx_data_view_screen_data_view_id_screen_id ON data_view_screen( data_view_id ASC, screen_id ASC )"
	execute immediate :ls_sql using sqlca;//051603 maha 
	commit using sqlca;
	ls_sql = "CREATE  INDEX idx_verif_info_screen_id ON verif_info( screen_id ASC );"
	execute immediate :ls_sql using sqlca;//051603 maha 
	commit using sqlca;
end if

ls_sql = "ALTER TABLE app_sect_temp ADD interview_order integer default 999 null;"
execute immediate :ls_sql using sqlca;//051603 maha 
commit using sqlca;
ls_sql = "ALTER TABLE app_sect_temp ADD multi_record integer default 0 null;"
execute immediate :ls_sql using sqlca;//051603 maha 
commit using sqlca;

ls_sql ="INSERT INTO sys_fields VALUES (	43,	100036,	350,	'appt_note',	'C',	32000,	'Appt. Note',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
execute immediate :ls_sql using sqlca;//052203 maha 
commit using sqlca;

ls_sql = "CREATE TABLE sys_iverify_look_match (	iv_lookup_code varchar(150) null,ic_lookup_code numeric(16, 0) null ,PRIMARY KEY ( iv_lookup_code, ic_lookup_code ));"
execute immediate :ls_sql using sqlca;//060403 maha 
commit using sqlca; 

ls_sql = "update code_lookup set type = 'S' where lookup_code = 20;"  //protect oig query
execute immediate :ls_sql using sqlca;//062503 maha
commit using sqlca;



return 1
end function

public function integer of_update_reports ();//Alfee 07.20.2009

n_cst_update_report lnvo_report

lnvo_report = Create n_cst_update_report
lnvo_report.of_update_reports()
Destroy lnvo_report

If isvalid(w_infodisp) Then Close(w_infodisp)

Return 1

/*
//Obsolete - Alfee 01.30.2008

//Start Code Change ---- 12.01.2006 #V7 maha added new
string rpt_path
string wiz_path

st_sql.text  = ""
cb_update.text = "Reports"
st_update.text  = "Reports"

rpt_path = gs_dir_path + "intellicred\reports_v85.txt"				//Modified by Scofield on 2008-06-11
wiz_path = gs_dir_path + "intellicred\report_wiz_v85.txt"			//Modified by Scofield on 2008-06-11

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007.06.21 By: Scofield
//$<Reason> Fix a defect.
n_appeon_download lnv_download
long ll_ret

If appeongetclienttype() <> 'PB' Then
	ll_ret = lnv_download.of_downloadfile("", rpt_path)
	if ll_ret <> 0 then
		MessageBox("Download infomation","Failed to download " + rpt_path + ", Call support.")
	end if
	
	ll_ret = lnv_download.of_downloadfile("", wiz_path)
	if ll_ret <> 0 then
		MessageBox("Download infomation","Failed to download " + wiz_path + ", Call support.")
	end if
end if
//---------------------------- APPEON END ----------------------------

if FileExists(rpt_path) = true then
		if FileExists(wiz_path) = true then
			delete from sys_reports where report_id < 1000;//<1000 added 031002 for not deleting custom reports.
		
			dw_report.SetTransObject( SQLCA	)
			dw_report.reset()
			dw_report.importfile( rpt_path )
			dw_report.update()
			commit using sqlca;
			
			delete from sys_report_wizard where report_id < 1000;
			
			dw_wizard.SetTransObject( SQLCA	)
			dw_wizard.reset()
			dw_wizard.importfile(wiz_path )
			dw_wizard.update()
			commit using sqlca;	
		else
		messagebox("Problem with file. ","File  does not exist " + wiz_path + ". ~rUnable to update report list.")
	end if
else
	messagebox("Problem with file. ","File  does not exist " + rpt_path + ". ~rUnable to update report list.")
end if


*/

end function

public function integer of_crawler_mods_v7 ();//Start Code Change ---- 02.06.2007 #V7 maha  added for modifications to web crawler

//Start Code Change ---- 03.15.2007 #V7
if gs_dbtype = "ASA" then
	of_execute("alter table wc_steps modify form_handler varchar(250) null;")
	of_execute("alter table wc_steps modify object_name varchar(250) null;")
	of_execute("alter table wc_steps modify content_or_value varchar(250) null;")
else
	of_execute("alter table wc_steps alter column form_handler varchar(250) null;")
	of_execute("alter table wc_steps alter column object_name varchar(250) null;")
	of_execute("alter table wc_steps alter column content_or_value varchar(250) null;")
end if
	
of_execute("alter table wc_hdr add active_status integer null;")
of_execute("alter table wc_hdr add pw_rqd integer null;")

of_execute("alter table wc_steps add wait_val integer null;")
of_execute("alter table wc_steps add input_type varchar(25) null;")
of_execute("alter table wc_steps add form_type varchar(25) null;")
of_execute("alter table wc_steps add test_break integer null;")
of_execute("alter table wc_steps add format_type integer null;")
of_execute("alter table wc_steps add attr_type varchar(25) null;") //maha 06.05.07
//End Code Change---03.05.2007


return 1
end function

public function integer of_adjust_webview_security ();//////////////////////////////////////////////////////////////////////
// $<function>of_adjust_webview_security()
// $<returns> integer
// $<description>According to Lynne's requirement,adjust the security module and sub-modules for WebView.
//               More detail, please see document in VSS:
//                $/Develop Area/IntelliCred/MSA/New Development/WebView/Requirement"/
//                  Security Management Difference between WebView and IntelliCred.doc
//////////////////////////////////////////////////////////////////////
// $<add> 03.09.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////

//Rename IntelliCred Web to WebView
of_execute( "Update SECURITY_MODULES Set module_name='WebView' Where module_name='IntelliCred Web';")

//Rename Web Administration to Web Access
of_execute( "Update SECURITY_SUB_MODULE&
      Set sub_module_name='Web Access'&
		Where sub_module_name='Web Administration'")
		
//Delete all actions except the View Rights action
of_execute( "delete SECURITY_ROLES_RIGHTS&
		from SECURITY_ROLES_RIGHTS,SECURITY_MODULES, SECURITY_SUB_MODULE,SECURITY_RIGHTS_ACTION&
		where SECURITY_MODULES.module_id=SECURITY_SUB_MODULE.module_id&
		and SECURITY_MODULES.module_id=SECURITY_RIGHTS_ACTION.module_id&
		and SECURITY_SUB_MODULE.sub_module_id=SECURITY_RIGHTS_ACTION.sub_module_id&
		and SECURITY_RIGHTS_ACTION.Action_name<>'View Rights'&
		and SECURITY_MODULES.module_name ='WebView'&
		and SECURITY_SUB_MODULE.sub_module_name ='Web Access'&
		and SECURITY_ROLES_RIGHTS.action_id=SECURITY_RIGHTS_ACTION.action_id")
		
//Delete all sub-modules and there actions except Web Access
of_execute( "delete SECURITY_ROLES_RIGHTS&
		from SECURITY_MODULES, SECURITY_SUB_MODULE,SECURITY_RIGHTS_ACTION&
		where SECURITY_MODULES.module_id=SECURITY_SUB_MODULE.module_id&
		and SECURITY_MODULES.module_id=SECURITY_RIGHTS_ACTION.module_id&
		and SECURITY_SUB_MODULE.sub_module_id=SECURITY_RIGHTS_ACTION.sub_module_id&
		and SECURITY_MODULES.module_name ='WebView'&
		and SECURITY_SUB_MODULE.sub_module_name <>'Web Access'&
		and SECURITY_ROLES_RIGHTS.action_id=SECURITY_RIGHTS_ACTION.action_id")
of_execute( "delete SECURITY_RIGHTS_ACTION&
		from SECURITY_MODULES, SECURITY_SUB_MODULE,SECURITY_RIGHTS_ACTION&
		where SECURITY_MODULES.module_id=SECURITY_SUB_MODULE.module_id&
		and SECURITY_MODULES.module_id=SECURITY_RIGHTS_ACTION.module_id&
		and SECURITY_SUB_MODULE.sub_module_id=SECURITY_RIGHTS_ACTION.sub_module_id&
		and SECURITY_RIGHTS_ACTION.Action_name<>'View Rights'&
		and SECURITY_MODULES.module_name ='WebView'&
		and SECURITY_SUB_MODULE.sub_module_name ='Web Access'")

of_execute( "delete SECURITY_RIGHTS_ACTION&
		from SECURITY_MODULES, SECURITY_SUB_MODULE,SECURITY_RIGHTS_ACTION&
		where SECURITY_MODULES.module_id=SECURITY_SUB_MODULE.module_id&
		and SECURITY_MODULES.module_id=SECURITY_RIGHTS_ACTION.module_id&
		and SECURITY_SUB_MODULE.sub_module_id=SECURITY_RIGHTS_ACTION.sub_module_id&
		and SECURITY_MODULES.module_name ='WebView'&
		and SECURITY_SUB_MODULE.sub_module_name <>'Web Access'")

of_execute( "Delete from SECURITY_SUB_MODULE&
		Where module_id=(select module_id from security_modules where module_name='WebView')&
		And sub_module_name <>'Web Access'")
		
return 1
end function

public function integer of_reference_fax ();//Start Code Change ---- 03.26.2007 #V7 maha

of_execute( "alter table ctx_contracts alter column state numeric(6) null;")

of_execute("alter table pd_references add fax varchar(25) null;")
of_execute("alter table pd_references add e_mail_address varchar(150) null;")
of_execute( "alter table pd_references add suite_apart varchar(50) null;")

of_execute( "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (23,601,400,null,'fax','Fax',25,'C',25);")
of_execute( "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (23,602,401,null,'e_mail_address','Email',150,'C',35);")
of_execute( "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (23,603,402,null,'suite_apart','Suite/Apart',50,'C',25);")

of_execute( "INSERT INTO data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,seperator_hdr,include_in_browse,browse_tab_order,browse_tab_width,field_x,field_y,field_width,field_height,justification,sys_table_id,sys_field_id,edit_field_type,field_label_justification,field_label_x,field_label_y,field_label_width,visible) VALUES (-295,	1,	13,	601,	10,  'Fax',		'N',	'N',	NULL,	NULL,	'Y',	NULL,	NULL,	69,	1204,	308,	64,	'0',	NULL,	NULL,	'E',	0,	41,	1004,	306,	'Y');")
of_execute( "INSERT INTO data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,seperator_hdr,include_in_browse,browse_tab_order,browse_tab_width,field_x,field_y,field_width,field_height,justification,sys_table_id,sys_field_id,edit_field_type,field_label_justification,field_label_x,field_label_y,field_label_width,visible) VALUES (-296,	1,	13,	602,	10,  'Email',		'N',	'N',	NULL,	NULL,	'Y',	NULL,	NULL,	79,	1304,	308,	64,	'0',	NULL,	NULL,	'E',	0,	41,	1004,	306,	'Y');")
of_execute( "INSERT INTO data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,seperator_hdr,include_in_browse,browse_tab_order,browse_tab_width,field_x,field_y,field_width,field_height,justification,sys_table_id,sys_field_id,edit_field_type,field_label_justification,field_label_x,field_label_y,field_label_width,visible) VALUES (-297,	1,	13,	603,	10,  'Suite/Apartment',		'N',	'N',	NULL,	NULL,	'Y',	NULL,	NULL, 89,	1404,	308,	64,	'0',	NULL,	NULL,	'E',	0,	41,	1004,	306,	'Y');")

of_execute( "alter table pd_prof_experience add fax varchar(25) null;")
of_execute( "alter table pd_prof_experience add e_mail_address varchar(150) null;")
of_execute( "alter table pd_prof_experience add suite_apart varchar(50) null;")

of_execute( "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (14,604,400,null,'fax','Fax',25,'C',25);")
of_execute( "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (14,605,401,null,'e_mail_address','Email',150,'C',35);")

of_execute( "INSERT INTO data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,seperator_hdr,include_in_browse,browse_tab_order,browse_tab_width,field_x,field_y,field_width,field_height,justification,sys_table_id,sys_field_id,edit_field_type,field_label_justification,field_label_x,field_label_y,field_label_width,visible) VALUES (-298,	1,	12,	604,	400,  'Fax',		'N',	'N',	NULL,	NULL,	'Y',	NULL,	NULL,	110,	1336,	308,	64,	'0',	NULL,	NULL,	'E',	0,	68,	1336,	306,	'Y');")
of_execute( "INSERT INTO data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,seperator_hdr,include_in_browse,browse_tab_order,browse_tab_width,field_x,field_y,field_width,field_height,justification,sys_table_id,sys_field_id,edit_field_type,field_label_justification,field_label_x,field_label_y,field_label_width,visible) VALUES (-299,	1,	12,	605,	410,  'Email',		'N',	'N',	NULL,	NULL,	'Y',	NULL,	NULL,	810,	1336,	308,	64,	'0',	NULL,	NULL,	'E',	0,	760,  1336,		306,	'Y');")

//Start Code Change ---- 06.19.2007 #V7 maha
of_execute( "Update sys_fields set field_type = 'C' where field_id = 601;")
of_execute( "Update sys_fields set field_type = 'C' where field_id = 602;")
of_execute( "Update sys_fields set field_type = 'C' where field_id = 603;")
of_execute( "Update sys_fields set field_type = 'C' where field_id = 604;")
of_execute( "Update sys_fields set field_type = 'C' where field_id = 605;")
//End Code Change---06.19.2007

return 1
end function

public function integer of_wv_required_template_upgrade ();//////////////////////////////////////////////////////////////////////
// $<function>of_wv_required_template_upgrade()
// $<returns> integer
// $<description>According to Lynne's requirement:
//						Project: IntelliCred-WebView Required Documents Template Painter.
//////////////////////////////////////////////////////////////////////
// $<add> 05.09.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////

//Create table wv_required_template
of_execute( "create table wv_required_template(&
	template_id  int identity not null,&
	template_name varchar(50) not null,&
	CONSTRAINT PK_wv_required_template PRIMARY KEY (template_id))")

//Create table wv_required_template_image
of_execute( "create table wv_required_template_image(&
	template_id  int not null,&
	image_type_id int not null,&
	is_image_linked  int not null default 1,&
	CONSTRAINT PK_wv_required_template_image PRIMARY KEY (template_id,image_type_id))")
	
//Add Foreign key
of_execute( "alter table wv_required_template_image &
			add constraint FK_WV_REQ_IMAGE_ID foreign key (image_type_id) references image_type (image_type_id);")
of_execute( "alter table wv_required_template_image &
			add constraint FK_WV_REQ_TEMP_ID foreign key (template_id) references wv_required_template (template_id);")


//Add two columns to Facility
of_execute( "Alter table facility add default_wv_init_template   int null")
of_execute( "Alter table facility add default_wv_reapp_template  int null")
of_execute( "alter table facility &
			add constraint FK_FAC_WV_REQ_INIT_ID foreign key (default_wv_init_template) references wv_required_template (template_id);")
of_execute( "alter table facility &
			add constraint FK_FAC_REQ_REAPP_ID foreign key (default_wv_reapp_template) references wv_required_template (template_id);")

of_execute( "insert into security_modules(module_id,software_version,module_name,prod_id)&
		values (65,4,'WebView Required Documents Template Painter',1)")
of_execute( "INSERT INTO security_sub_module ( sub_module_id, module_id,sub_module_name,prod_id )  &
			  VALUES ( 604, 65,'Main',1 )  ;")

of_execute( "INSERT INTO security_rights_action ( action_id, module_id,sub_module_id,action_name,dddw_type )  &
			  values(6927,65,604,'View Rights',1 );")

//Add role rights
of_wv_required_template_role_rights( )

return 1
end function

public function integer of_wv_required_template_role_rights ();//////////////////////////////////////////////////////////////////////
// $<function>of_wv_required_template_role_rights()
// $<arguments>(None)
// $<returns> integer
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 05.08.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////

datastore lds_actions,lds_roles,lds_rights
string ls_filter,ls_find
long i,j,k,ll_module_id[],ll_sub_module_id[]
long ll_find,ll_module_id1,ll_sub_module_id1,ll_role_id,ll_action_id,ll_rights_id
long ll_row,ll_action_rowcount,ll_role_rowcount,ll_right_rowcount

lds_actions = CREATE datastore
lds_actions.DataObject = 'd_security_all_actions'
lds_actions.SetTransObject( SQLCA )

lds_roles = CREATE datastore
lds_roles.dataobject = 'd_security_roles'
lds_roles.settransobject(sqlca)

lds_rights = CREATE datastore
lds_rights.dataobject = 'd_security_roles_rights'
lds_rights.settransobject(sqlca)

gnv_appeondb.of_startqueue( )
lds_actions.retrieve()
lds_roles.retrieve()
lds_rights.retrieve()
Select Max( rights_id ) Into :ll_rights_id From security_roles_rights;
gnv_appeondb.of_commitqueue( )

If IsNull( ll_rights_id ) Then ll_rights_id = 0;
ll_rights_id++

of_execute( "INSERT INTO security_roles_rights ( rights_id, role_id, action_id, value_id ) &
				 values ( "+string(ll_rights_id)+", 1, 6927, 1);")

ll_role_rowcount = lds_roles.rowcount()
ll_right_rowcount = lds_rights.rowcount()

ll_module_id[1] = 65  //WebView Required Document Template
ll_sub_module_id[1] = 604	//Main

For i = 1 To upperbound(ll_module_id)
	ll_module_id1 = ll_module_id[i]
	ll_sub_module_id1 = ll_sub_module_id[i]
	ls_filter = "module_id = " + string(ll_module_id1) + " And sub_module_id = " + string(ll_sub_module_id1)
	lds_actions.setfilter(ls_filter)
	lds_actions.filter()
	ll_action_rowcount = lds_actions.rowcount()
	For j = 1 To ll_role_rowcount
		ll_role_id = lds_roles.getitemnumber(j,'role_id')				
		For k = 1 To ll_action_rowcount
			ll_action_id = lds_actions.getitemnumber(k,'action_id')
			ls_find = "role_id = " + string(ll_role_id) + " and action_id = " + string(ll_action_id)
			ll_find = lds_rights.find(ls_find,1,ll_right_rowcount)
			If ll_find < 1 Then
				ll_row = lds_rights.insertrow(0)
				ll_rights_id ++
				lds_rights.setitem(ll_row,'rights_id',ll_rights_id)
				lds_rights.setitem(ll_row,'role_id',ll_role_id)
				lds_rights.setitem(ll_row,'action_id',ll_action_id)
				lds_rights.setitem(ll_row,'value_id',1)
			End If
		Next
	Next
Next
gnv_appeondb.of_startqueue( )
lds_rights.update()
UPDATE ids SET rights_id = :ll_rights_id;	
gnv_appeondb.of_commitqueue( )

Destroy lds_actions
Destroy lds_roles
Destroy lds_rights



Return 1
end function

public function integer of_webview_upgrade ();//////////////////////////////////////////////////////////////////////
// $<function>of_webview_upgrade()
// $<arguments>(None)
// $<returns> integer
// $<description>All upgrading about WebView should be here.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 06.27.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////


//--------------------------- APPEON BEGIN ---------------------------
//$<add> 05.25.2007 By: Frank.Gui
//$<reason> Add a unique index on table security_roles_rights
of_execute("CREATE UNIQUE INDEX inx_uni_security_right ON security_roles_rights (role_id, action_id)") ;
//---------------------------- APPEON END ----------------------------
	

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 05.29.2007 By: Frank.Gui
//$<reason> This field should only be used in WebView.
of_execute("alter table icred_settings add last_db_update_wv datetime null") ;
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.08.2007 By: Frank.Gui
//$<reason> According to Lynne's requirement, adjust the module and sub-modules name for WebView.
of_adjust_webview_security()

//$<reason> According to Lynne's requirement, add a new column wv_begin_cred.
of_execute ("alter table pd_affil_stat	add wv_begin_cred numeric(1,0) null;")
//---------------------------- APPEON END ----------------------------
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 06.25.2007 By: Frank.Gui
//$<reason> This is included in WebView, but also need to be added here.
of_execute ("alter table wv_esign_log add app_status_id numeric(10,0) null;")
//---------------------------- APPEON END ----------------------------



//--------------------------- APPEON BEGIN ---------------------------
//$<add> 05.22.2007 By: Frank.Gui
//$<reason> According to Lynne's requirement, create two tables and alter table Facility
//          More detailes, please see doc:IntelliCred-WV Required Doc Template Painter.doc

//Add security items
IF upper(gs_dbtype)="ASA" THEN
	of_execute("alter table security_modules modify module_name varchar(100) null;")
ELSE
	of_execute("alter table security_modules alter column module_name varchar(100) null")
END IF
of_wv_required_template_upgrade()
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 06.27.2007 By: Frank.Gui
//$<reason> Add new column wv_ldap_user and an unique index for this column
of_execute( "alter table security_users add wv_ldap_user varchar(30) null")

//Unique index in SQL Server may cause error.
IF gs_dbtype='ASA' THEN
	//of_execute( "CREATE UNIQUE INDEX idx_unique_ldapuser ON security_users (wv_ldap_user )")
	of_execute( "DROP UNIQUE INDEX idx_unique_ldapuser")//2007-07-17, deleted by Frank.
ELSE
	of_execute( "DROP UNIQUE INDEX security_users.idx_unique_ldapuser")//2007-07-17, deleted by Frank.
END IF

//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 05.29.2007 By: Frank.Gui
//$<reason> WebView database upgraded version.
of_execute("alter table icred_settings add wv_db_version varchar(20) null") ;
//---------------------------- APPEON END ----------------------------


//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007.09.03 By: Frank.Gui
//$<reason> Create new table wv_question_documents
IF gs_dbtype="ASA" THEN
	of_execute("CREATE TABLE	wv_question_documents &
				(	rec_id				integer not null &
					,prac_id            integer not null &
					,file_type					varchar(10) not null default 'pdf' &
					,file_data					long binary  null &
					,description                varchar(255) null &
					,create_by 					varchar(10) null &
					,create_date				datetime  null &
					,last_updated_by 			varchar(10) null &
					,last_updated_date			datetime  null &
					, primary key (rec_id) &
				)			 ")
ELSE
	of_execute("CREATE TABLE	wv_question_documents &
				(	rec_id				integer not null &
					,prac_id            integer not null &
					,file_type					varchar(10) not null default 'pdf' &
					,file_data					image  null &
					,description                varchar(255) null &
					,create_by 					varchar(10) null &
					,create_date				datetime  null &
					,last_updated_by 			varchar(10) null &
					,last_updated_date			datetime  null &
					, primary key (rec_id) &
				)			 ")
	
END IF
//---------------------------- APPEON END ----------------------------

return 1

end function

public function integer of_npdb_updates_2007 ();string ls_sql_statments[]
integer i

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C00','Success, no errors');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C01','Error on NPDB-HIPDB server, reattempt transfer');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C04','Database error on NPDB-HIPDB server, reattempt transfer');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C06','Database connection error on NPDB-HIPDB server, reattempt transfer');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C08','Communication error with NPDB-HIPDB ICD server during response retrieval, reattempt transfer.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C18','Error in downloaded response files, reattempt transfer');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C19','Error in getting information from the downloaded file, reattempt transfer');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C20','Unable to open downloaded file, check if sufficient disk space is available to download file and reattempt transfer');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C21','Generic error code; used for failures not yet categorized');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C22','Usage error, check command-line parameter');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C23','Error in reading Initialization file itp.ini, check that itp.ini file is in working directory');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C24','Unable to open program log file, check that disk space is available');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C25','Error in username and password validation, check that the DBID and password are correct');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C30','Error validating parameter in itp.ini, a parameter is missing or value is invalid');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C31','Error validating UploadFile, upload file missing or a file listed in the upload file does not exist');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C32','Error validating DownloadDir, directory does not exist');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C40','Error opening connection to NPDB-HIPDB server, check internet connection and reattempt transfer');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C41','Error getting input stream to NPDB-HIPDB server, check internet connection and reattempt transfer');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C42','Error getting output stream from NPDB-HIPDB server, check internet connection and reattempt transfer');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C50','Error reading status response from NPDB-HIPDB server, reattempt transfer');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C51','Error processing web request, reattempt transfer');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C52','Error getting status code, reattempt transfer');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C53','Error sending submission files, reattempt transfer');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C54','Error downloading response files, reattempt transfer.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C55','Error moving response files to the download directory, no permission to write to the directory or the device has run out of space.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C56','Your password change request could not be successfully processed. Download the response file for further details.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C57','Your account has been locked out. Contact your entity administrator to reset the password. If you are using an administrator account, contact the NPDB-HIPDB Customer Service Center to reset the password.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C58','Your account has been locked out. The number of invalid login attempts has exceeded the allowable login limit. Contact your entity administrator to reset the password. If you are using an administrator account, contact the NPDB-HIPDB Customer Service Center to reset the password.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C59','Your account password has expired. Contact your entity administrator to reset the password. If you are using an administrator account, contact the NPDB-HIPDB Customer Service Center to reset the password.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C60','Unable to process submission files. The files are not in the appropriate format. Check to ensure that the files are not zipped or in a binary format prior to resubmission.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C61','Your password must be changed before other transactions can be submitted.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C62','The entity identified by the DBID in itp.ini does not have active status.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C63','The entity identified by the DBID in itp.ini does not match the DBID in the submission file.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C64','No more than one password change transaction can be listed in the upload file UploadFile at any time. Modify UploadFile to include only one password change transaction, reattempt transfer.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C65','Password change transaction processing was successful but an error occurred sending the other transaction files. Re-encode new password if necessary, remove password change transactions from the upload file UploadFile, and reattempt transfer of other transaction files.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C66','Password change transaction processing failed but the other transaction files were sent successfully. Modify the upload file UploadFile to include only one password change transaction, reattempt transfer.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table facility add npdb_user_id varchar(35) null;"

for i = 1 to upperbound(ls_sql_statments)
	of_execute( ls_sql_statments[i])
next

return 1
end function

public function long of_download_updatefiles ();String	ls_DownDir,ls_DndPicName,ls_targent_path,ls_DlPath
Long		ll_Rtn,ll_RetVal,ll_i
Boolean	lb_BorwseFolder

Constant	String CUSTOM_UPDATE_SQL_FILE = "update files.exe"
n_appeon_download lnv_download

IF AppeonGetClientType() = "WEB" THEN
	ls_DownDir = gs_dir_path+"intellicred\"
	ls_targent_path = ls_DownDir+CUSTOM_UPDATE_SQL_FILE
END IF

SELECT downloadurl Into :ls_DlPath From icred_settings;

IF IsNull(ls_DlPath) THEN ls_DlPath = ""
//////////////////////////////////////////////////////////////////////////////// //
OpenWithParm(w_appeon_gifofwait,CUSTOM_UPDATE_SQL_FILE + " is being downloaded...")
//w_appeon_gifofwait.p_1.PictureName = ls_DndPicName
ll_Rtn = lnv_download.of_downloadfile(ls_DlPath, ls_targent_path)
IF IsValid(w_appeon_gifofwait)  THEN
	Close(w_appeon_gifofwait)
END IF
IF ll_Rtn <> 0 THEN
	//MessageBox(gnv_app.iapp_object.DisplayName,"Failed to download " + CUSTOM_UPDATE_SQL_FILE + ". Please call support. ",Exclamation!)
	RETURN  -1
ELSE
	ll_RetVal = Run(ls_targent_path)
	OpenWithParm(w_appeon_wait, "Extracting files...")
	IF Not IsValid(w_appeon_wait)  THEN
		RETURN ll_RetVal
	END IF
	
END IF










end function

public function long of_update_sql ();//Alfee 01.30.2008
Integer li_ver
String ls_SQL

//Backup Lookup Codes
//of_backupcode()
n_cst_update_data lnv_data
lnv_data = Create n_cst_update_data
lnv_data.of_common_backupcode( )

//---------Begin Added by (Appeon)Alfee 06.18.2013 for V141 ISG-CLX--------
n_cst_update_sql_clx lnv_sql
lnv_sql = Create n_cst_update_sql_clx
//---------End Added -----------------------------------------------------------------

//Get current version
select set_18 into :li_ver from icred_settings; 
If IsNull(li_ver) Then li_ver = 0
If gs_dbType = 'SQL' and li_ver < 55 then li_ver = 55

//1.Update sql 2.update support doc 3.update contact 4.update role right
if li_ver < 41 then          //version 2,3,4 updates
	of_old_code(li_ver)
	of_ver40_update()   //sets to 41
elseif li_ver < 45 then      //41
	of_ver45_update()
elseif li_ver < 50 then      //45
	of_ver50_updates()
elseif li_ver < 55 then      //50
	of_ver55_updates()
elseif li_ver <= 70 then     //55,60,70
	of_ver60_updates()
elseif li_ver <= 71 then     //71
	of_ver70_updates()
elseif li_ver <= 80 then     //80
	of_ver80_updates()
elseif li_ver <= 91 then     //91 - changed v85 to v91; alfee 12.30.2008
	of_ver91_updates()	
elseif li_ver <= 92 then     //92 - alfee 03.03.2009
	of_ver92_updates()
elseif li_ver <= 101 then    //101 - evan 09.29.2009
	of_ver101_updates()
elseif li_ver <= 111 then    //111 - nova 06.23.2010
	of_ver111_updates()
elseif li_ver <= 112 then    //112 - evan 01.10.2011
	of_ver112_updates()
elseif li_ver <= 113 then    //113 - evan 06.13.2011
	of_ver113_updates()
elseif li_ver <= 121 then    //121 - evan 10.13.2011
	of_ver121_updates()
elseif li_ver <= 122 then    //122 - stephen 06.04.2012
	of_ver122_updates()
elseif li_ver <= 123 then    //123 - alfee 12.03.2012
	of_ver123_updates()	
elseif li_ver <= 141 then    //141 - alfee 05.21.2013
	of_ver141_updates()	
elseif li_ver <= 142 then    //142 - alfee 01.20.2014
	of_ver142_updates()			
elseif li_ver <= 151 then    //151 - alfee 02.06.2015
	of_ver151_updates()		
elseif li_ver <= 152 then    //152 - stephen 05.09.2016
	of_ver152_updates()	
elseif li_ver <= 153 then    //153 - stephen 10.19.2016
	of_ver153_updates()	
elseif li_ver <= 154 then    //154 - stephen 05.16.2017
	of_ver154_updates()	
elseif li_ver <= 161 then    //154 - stephen 10.20.2017
	of_ver161_updates()	
end if

//Update common data for all versions
lnv_data.of_common_updates()
Destroy lnv_data

//---------Begin Added by (Appeon)Alfee 06.18.2013 for V141 ISG-CLX--------
lnv_sql.of_release_fulltext( False ) //Added By Ken.Guo 2010-12-09.
Destroy lnv_sql
//---------End Added -----------------------------------------------------------------

RETURN 1
end function

public subroutine of_backupcode ();////Moved here by Alfee 01.30.2008
//String ls_key_name,ls_sql[]
//Long ll_bound,i
//ls_sql[1] = "IF EXISTS (SELECT name FROM   sysobjects WHERE  name = 'up_back_code_lookup'  AND  type = 'P')"+'~r~n'
//ls_sql[1] += "DROP PROCEDURE up_back_code_lookup"+'~r~n'
//
//ls_sql[2] = "CREATE PROCEDURE  up_back_code_lookup "+'~r~n'
//ls_sql[2] += "AS"+'~r~n'
//ls_sql[2] += "BEGIN"+'~r~n'
//ls_sql[2] += " declare @del_no float"+'~r~n'
//ls_sql[2] += " declare @max_no float"+'~r~n'
//ls_sql[2] += " declare @rowcount float"+'~r~n'
//ls_sql[2] += "if not exists (select TOP 1 1"+'~r~n'
//ls_sql[2] += "from  sysobjects"+'~r~n'
//ls_sql[2] += "where  name='code_lookup_bak'"+'~r~n'
//ls_sql[2] += "	and   type = 'U')"+'~r~n'
//ls_sql[2] += "begin"+'~r~n'
//
//ls_sql[2] += "CREATE TABLE code_lookup_bak("+'~r~n'
//ls_sql[2] += "lookup_code numeric(6, 0) NOT NULL,"+'~r~n'
//ls_sql[2] += "lookup_name varchar(35) NOT NULL,"+'~r~n'
//ls_sql[2] += "code varchar(30) NOT NULL,"+'~r~n'
//ls_sql[2] += "backupdate datetime NOT NULL default getdate(),"+'~r~n'
//ls_sql[2] += "seq_no int NOT NULL"+'~r~n'
//ls_sql[2] += ")"+'~r~n'
//
//ls_sql[2] += "INSERT INTO code_lookup_bak(lookup_code,lookup_name,code,seq_no)"+'~r~n'
//ls_sql[2] += "SELECT lookup_code,lookup_name,code,1 "+'~r~n' 
//ls_sql[2] += "from code_lookup"+'~r~n'
//ls_sql[2] += "end"+'~r~n'
//ls_sql[2] += "else"+'~r~n'
//ls_sql[2] += "begin"+'~r~n'
//
//ls_sql[2] += "select   @rowcount=count(distinct seq_no)"+'~r~n'
//ls_sql[2] += "from  code_lookup_bak"+'~r~n'
//
//
//ls_sql[2] += "if @rowcount=5 "+'~r~n'
//ls_sql[2] += "begin"+'~r~n'
//ls_sql[2] += "select  @del_no= isnull(min( seq_no),0)"+'~r~n'
//ls_sql[2] += "from  code_lookup_bak"+'~r~n'
//ls_sql[2] += " delete from  code_lookup_bak"+'~r~n'
//ls_sql[2] += "where seq_no=@del_no"+'~r~n'
//ls_sql[2] += " end"+'~r~n'
//ls_sql[2] += "select  @max_no=isnull(max(seq_no),0) +1"+'~r~n'
//ls_sql[2] += "from  code_lookup_bak"+'~r~n'
//ls_sql[2] += "INSERT INTO code_lookup_bak(lookup_code,lookup_name,code,seq_no)"+'~r~n'
//ls_sql[2] += "SELECT lookup_code,lookup_name,code,@max_no"+'~r~n'
//ls_sql[2] += "FROM code_lookup"+'~r~n'
//ls_sql[2] += "end"+'~r~n'
//ls_sql[2] += "end"+'~r~n'
//
//ls_sql[3] = "IF EXISTS (SELECT name FROM   sysobjects WHERE  name = 'up_back_code_lookup'  AND  type = 'P')"+'~r~n'
//ls_sql[3] += "Exec up_back_code_lookup"+'~r~n'
//
//ls_sql[4] = "IF EXISTS (SELECT name FROM   sysobjects WHERE  name = 'up_back_code_lookup'  AND  type = 'P')"+'~r~n'
//ls_sql[4] += "DROP PROCEDURE up_back_code_lookup"+'~r~n'
//
//ls_sql[5] = "IF EXISTS (SELECT name FROM   sysobjects WHERE  name = 'up_back_address_lookup'  AND  type = 'P')"+'~r~n'
//ls_sql[5] += "DROP PROCEDURE up_back_address_lookup"+'~r~n'
//
//ls_sql[6] = "CREATE PROCEDURE  up_back_address_lookup "+'~r~n'
//ls_sql[6] += "AS"+'~r~n'
//ls_sql[6] += "BEGIN"+'~r~n'
//ls_sql[6] += " declare @del_no float"+'~r~n'
//ls_sql[6] += " declare @max_no float"+'~r~n'
//ls_sql[6] += " declare @rowcount float"+'~r~n'
//ls_sql[6] += "if not exists (select TOP 1 1"+'~r~n'
//ls_sql[6] += "from  sysobjects"+'~r~n'
//ls_sql[6] += "where  name='address_lookup_bak'"+'~r~n'
//ls_sql[6] += "	and   type = 'U')"+'~r~n'
//
//ls_sql[6] += "BEGIN"+'~r~n'
//ls_sql[6] += "CREATE TABLE address_lookup_bak("+'~r~n'
//ls_sql[6] += "lookup_code numeric(6, 0) NOT NULL,"+'~r~n'
//ls_sql[6] += "lookup_name varchar(20) NOT NULL,"+'~r~n'
//ls_sql[6] += "code varchar(15) NOT NULL,"+'~r~n'
//
//ls_sql[6] += "backupdate datetime NOT NULL default getdate(),"+'~r~n'
//ls_sql[6] += "seq_no int NOT NULL"+'~r~n'
//ls_sql[6] += ")	"+'~r~n'
////
//ls_sql[6] += "insert  into address_lookup_bak(lookup_code,lookup_name,code,seq_no)"+'~r~n' //entity_name,street1,street2,city,state,zip,country,"+'~r~n'
//ls_sql[6] += "SELECT lookup_code,lookup_name,code,1"+'~r~n' //entity_name,street1,street2,city,state,zip,country,"+'~r~n'
//ls_sql[6] += "from address_lookup"+'~r~n'
//ls_sql[6] += "end"+'~r~n'
//ls_sql[6] += "else"+'~r~n'
//
//ls_sql[6] += "begin"+'~r~n'
//ls_sql[6] += "select   @rowcount=count(distinct seq_no)"+'~r~n'
//ls_sql[6] += "from  address_lookup_bak"+'~r~n'
//ls_sql[6] += "if @rowcount=5 "+'~r~n'
//ls_sql[6] += "begin"+'~r~n'
//ls_sql[6] += "select  @del_no=isnull(min( seq_no),0)"+'~r~n'
//ls_sql[6] += "from  address_lookup_bak"+'~r~n'
//ls_sql[6] += " delete from  address_lookup_bak"+'~r~n'
//ls_sql[6] += "where seq_no=@del_no"+'~r~n'
//ls_sql[6] += " end"+'~r~n'
//ls_sql[6] += "select  @max_no=isnull(max(seq_no),0) +1"+'~r~n'
//ls_sql[6] += "from  address_lookup_bak"+'~r~n'
//ls_sql[6] += "insert  into address_lookup_bak(lookup_code,lookup_name,code,seq_no)"+'~r~n' 
//ls_sql[6] += "SELECT lookup_code,lookup_name,code,@max_no"+'~r~n' 
//ls_sql[6] += "FROM address_lookup"+'~r~n'
//ls_sql[6] += "end"+'~r~n'
//ls_sql[6] += "end"+'~r~n'
//
//ls_sql[7] = "IF EXISTS (SELECT name FROM   sysobjects WHERE  name = 'up_back_address_lookup'  AND  type = 'P')"+'~r~n'
//ls_sql[7] += "Exec up_back_address_lookup"+'~r~n'
//
//ls_sql[8] = "IF EXISTS (SELECT name FROM   sysobjects WHERE  name = 'up_back_address_lookup'  AND  type = 'P')"+'~r~n'
//ls_sql[8] += "DROP PROCEDURE up_back_address_lookup"+'~r~n'
//
//ls_sql[9] = "IF EXISTS (SELECT name FROM   sysobjects WHERE  name = 'up_back_ctx_screen'  AND  type = 'P')"+'~r~n'
//ls_sql[9] += "DROP PROCEDURE up_back_ctx_screen"+'~r~n'
//
//ls_sql[10] = "CREATE PROCEDURE  up_back_ctx_screen "+'~r~n'
//ls_sql[10] += "AS"+'~r~n'
//ls_sql[10] += "BEGIN"+'~r~n'
//ls_sql[10] += " declare @del_no float"+'~r~n'
//ls_sql[10] += " declare @max_no float"+'~r~n'
//ls_sql[10] += " declare @rowcount float"+'~r~n'
//ls_sql[10] += "if not exists (select TOP 1 1"+'~r~n'
//ls_sql[10] += "from  sysobjects"+'~r~n'
//ls_sql[10] += "where  name='ctx_screen_bak'"+'~r~n'
//ls_sql[10] += "	and   type = 'U')"+'~r~n'
//ls_sql[10] += "begin"+'~r~n'
////
//ls_sql[10] += "CREATE TABLE ctx_screen_bak("+'~r~n'
//ls_sql[10] += "data_view_id int NOT NULL,"+'~r~n'
//ls_sql[10] += "screen_id int NOT NULL,"+'~r~n'
//ls_sql[10] += "dw_sql text  NULL,"+'~r~n'
//ls_sql[10] += "create_date datetime NULL,"+'~r~n'
//ls_sql[10] += "modify_date datetime NULL,"+'~r~n'
//ls_sql[10] += "backupdate datetime NOT NULL default getdate(),"+'~r~n'
//ls_sql[10] += "seq_no int NOT NULL"+'~r~n'
//ls_sql[10] += ")"+'~r~n'
//
//ls_sql[10] += "INSERT INTO ctx_screen_bak(data_view_id,screen_id,dw_sql,create_date,modify_date,seq_no)"+'~r~n' //,description,type,custom_1,"+'~r~n'
//ls_sql[10] += "SELECT data_view_id,screen_id,dw_sql,create_date,modify_date,1 "+'~r~n' //,description,type,custom_1,"+'~r~n'
//ls_sql[10] += "from ctx_screen"+'~r~n'
//ls_sql[10] += "end"+'~r~n'
//ls_sql[10] += "else"+'~r~n'
//ls_sql[10] += "begin"+'~r~n'
//
//ls_sql[10] += "select   @rowcount=count(distinct seq_no)"+'~r~n'
//ls_sql[10] += "from  ctx_screen_bak"+'~r~n'
//
//ls_sql[10] += "if @rowcount=5 "+'~r~n'
//ls_sql[10] += "begin"+'~r~n'
//ls_sql[10] += "select  @del_no= isnull(min( seq_no),0)"+'~r~n'
//ls_sql[10] += "from  ctx_screen_bak"+'~r~n'
//ls_sql[10] += " delete from  ctx_screen_bak"+'~r~n'
//ls_sql[10] += "where seq_no=@del_no"+'~r~n'
//ls_sql[10] += " end"+'~r~n'
//ls_sql[10] += "select  @max_no=isnull(max(seq_no),0) +1"+'~r~n'
//ls_sql[10] += "from  ctx_screen_bak"+'~r~n'
//ls_sql[10] += "INSERT INTO ctx_screen_bak(data_view_id,screen_id,dw_sql,create_date,modify_date,seq_no)"+'~r~n' //,description,type,custom_1,"+'~r~n'
//ls_sql[10] += "SELECT data_view_id,screen_id,dw_sql,create_date,modify_date,1 "+'~r~n' //,description,type,custom_1,"+'~r~n'
//ls_sql[10] += "from ctx_screen"+'~r~n'
//ls_sql[10] += "end"+'~r~n'
//ls_sql[10] += "end"+'~r~n'
//
//ls_sql[11] = "IF EXISTS (SELECT name FROM   sysobjects WHERE  name = 'up_back_ctx_screen'  AND  type = 'P')"+'~r~n'
//ls_sql[11] += "Exec up_back_ctx_screen"+'~r~n'
//
//ls_sql[12] = "IF EXISTS (SELECT name FROM   sysobjects WHERE  name = 'up_back_ctx_screen'  AND  type = 'P')"+'~r~n'
//ls_sql[12] += "DROP PROCEDURE up_back_ctx_screen"+'~r~n'
//
//ls_sql[13] = "if not exists( select TOP 1 1 from sysobjects where name = 'sys_code_lookup_audit' )"+'~r~n'
//ls_sql[13] += "create table sys_code_lookup_audit("+'~r~n'
//ls_sql[13] += "rec_id         integer identity not null,"+'~r~n'
//ls_sql[13] += "lookup_type    char(1) null,"+'~r~n'
//ls_sql[13] += "lookup_code   numeric(6,0) null,"+'~r~n'
//ls_sql[13] += "code          varchar(30) null,"+'~r~n'
//ls_sql[13] += "lookup_name  varchar(35) null,"+'~r~n'
//ls_sql[13] += "audit_type     char(1) null,"+'~r~n'
//ls_sql[13] += "modified_date  datetime null,"+'~r~n'
//ls_sql[13] += "constraint pk_sys_code_lookup_audit_id primary key (rec_id)"+'~r~n'
//ls_sql[13] += ")"+'~r~n'
//
//
////END IF
//
//FOR i = 1 To UpperBound(ls_sql)
//	EXECUTE Immediate :ls_sql[i] Using sqlca;
//	IF sqlca.SQLCode <> 0  THEN
//		IF IsValid(gnv_logservice)THEN gnv_logservice.of_log(ls_sql[i], sqlca.SQLErrText,"of_backupcode")
//		gb_upgrade_failed = TRUE		
//	ELSE
//		COMMIT;
//	END IF
//	
//NEXT
//
//
//
//
end subroutine

public function integer of_ver40_update ();string ls_sql
integer cnt
		
cb_update.text = "Ver 4 Updates"
st_update.text  = "Ver 4 Updates"

//inova added fields
ls_sql = "ALTER TABLE pd_affil_stat ADD prov_status integer default 0 null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//070803 maha inova
commit using sqlca;
ls_sql = "update pd_affil_stat set prov_status = 0 where prov_status is null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//070803 maha 
commit using sqlca;
ls_sql = "ALTER TABLE pd_affil_stat ADD prior_appt_start timestamp null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//070803 maha inova
commit using sqlca;
ls_sql = "ALTER TABLE pd_affil_stat ADD prior_appt_end timestamp null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//070803 maha inova
commit using sqlca;

ls_sql = "ALTER TABLE facility ADD reapp_doc_name varchar(100) null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//070803 maha inova
commit using sqlca;
ls_sql = "update facility set reapp_doc_name = 'ind_expiring_appointment_letter.doc' where reapp_doc_name is null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//082102 maha inova
commit using sqlca;
ls_sql = "ALTER TABLE facility ADD reapp_export integer default 0 null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//070803 maha inova
commit using sqlca;
ls_sql = "update facility set reapp_export = 0 where reapp_export is null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//070803 maha inova
commit using sqlca;
ls_sql = "ALTER TABLE facility ADD reapp_export_id integer null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//070803 maha inova
commit using sqlca;
ls_sql = "ALTER TABLE facility ADD reappah_doc_name varchar(100) null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//070803 maha inova
commit using sqlca;
ls_sql = "update facility set reappah_doc_name = 'ind_expiring_appointment_letter.doc' where reappah_doc_name is null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//082102 maha inova
commit using sqlca;

commit using sqlca;
ls_sql = "ALTER TABLE facility ADD reappah_export integer default 0 null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//070803 maha inova
commit using sqlca;
ls_sql = "update facility set reappah_export = 0 where reappah_export is null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//070803 maha inova
commit using sqlca;
ls_sql = "ALTER TABLE facility ADD reappah_export_id integer null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//070803 maha inova
commit using sqlca;
ls_sql = "ALTER TABLE facility ADD reappah_app_id numeric(6,0) null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//070803 maha inova
commit using sqlca;
ls_sql = "ALTER TABLE facility ADD prov_doc_name varchar(100) null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//070803 maha inova
commit using sqlca;
ls_sql = "update facility set prov_doc_name = 'ind_expiring_appointment_letter.doc' where prov_doc_name is null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//082102 maha inova
commit using sqlca;
ls_sql = "ALTER TABLE facility ADD prov_export integer default 0 null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//070803 maha inova
commit using sqlca;
ls_sql = "update facility set prov_export = 0 where prov_export is null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//070803 maha inova
commit using sqlca;
ls_sql = "ALTER TABLE facility ADD prov_export_id integer null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//070803 maha inova
commit using sqlca;
ls_sql = "ALTER TABLE facility ADD prov_app_id numeric(6,0) null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//070803 maha inova
commit using sqlca;

ls_sql = "ALTER TABLE icred_settings ADD set_31 integer NULL;"
execute immediate :ls_sql using sqlca;//070903 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "update icred_settings set set_31 = 0 where set_31 is null;"
execute immediate :ls_sql using sqlca;//070903 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "ALTER TABLE icred_settings ADD set_32 integer NULL;"
execute immediate :ls_sql using sqlca;//070903 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "update icred_settings set set_32 = 0 where set_32 is null;"
execute immediate :ls_sql using sqlca;//070903 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "ALTER TABLE icred_settings ADD set_33 integer NULL;"
execute immediate :ls_sql using sqlca;//070903 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "update icred_settings set set_33 = 0 where set_33 is null;"
execute immediate :ls_sql using sqlca;//070903 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "ALTER TABLE icred_settings ADD set_34 integer NULL;"
execute immediate :ls_sql using sqlca;//070903 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "update icred_settings set set_34 = 0 where set_34 is null;"
execute immediate :ls_sql using sqlca;//070903 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "ALTER TABLE icred_settings ADD set_35 integer NULL;"
execute immediate :ls_sql using sqlca;//070903 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "update icred_settings set set_35 = 0 where set_35 is null;"
execute immediate :ls_sql using sqlca;//070903 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "ALTER TABLE icred_settings ADD set_36 integer NULL;"
execute immediate :ls_sql using sqlca;//070903 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "update icred_settings set set_36 = 0 where set_36 is null;"
execute immediate :ls_sql using sqlca;//070903 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "ALTER TABLE icred_settings ADD set_37 integer NULL;"
execute immediate :ls_sql using sqlca;//070903 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "update icred_settings set set_37 = 0 where set_37 is null;"
execute immediate :ls_sql using sqlca;//070903 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "ALTER TABLE icred_settings ADD set_38 integer NULL;"
execute immediate :ls_sql using sqlca;//070903 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "update icred_settings set set_38 = 0 where set_38 is null;"
execute immediate :ls_sql using sqlca;//070903 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "ALTER TABLE icred_settings ADD set_39 integer NULL;"
execute immediate :ls_sql using sqlca;//070903 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "update icred_settings set set_39 = 0 where set_39 is null;"
execute immediate :ls_sql using sqlca;//070903 maha
commit using sqlca;
ls_sql = "ALTER TABLE icred_settings ADD set_40 integer NULL;"
execute immediate :ls_sql using sqlca;//070903 maha
commit using sqlca;
ls_sql = "update icred_settings set set_40 = 0 where set_40 is null;"
execute immediate :ls_sql using sqlca;//070903 maha
commit using sqlca;

ls_sql = "update icred_settings set set_29 = 1 where set_29 = 0;"
execute immediate :ls_sql using sqlca;//070903 maha setting default for scanning to B&W
commit using sqlca;

ls_sql = "ALTER TABLE sys_batch_list ADD create_sql long varchar NULL;"
execute immediate :ls_sql using sqlca;//072903 maha
commit using sqlca;

ls_sql = "ALTER TABLE security_users ADD default_view integer NULL;"
execute immediate :ls_sql using sqlca;//073103 maha
commit using sqlca;

ls_sql = "CREATE TABLE sys_help (help_id	numeric(10,0) NOT NULL, program_id 	varchar(50) null, category 	varchar(50) NULL, subcategory varchar(50) NULL, create_date date, mod_date date,help_file 	long varchar not NULL,PRIMARY KEY (help_id));"
execute immediate :ls_sql using sqlca;
commit using sqlca;

ls_sql = "ALTER TABLE ids ADD iverify_account_number numeric(8,0) NULL;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081303 maha 
commit using sqlca;

//update application templates john ~4-03
ls_sql = "ALTER TABLE app_sect_temp ADD	interview_order Integer NULL;"
execute immediate :ls_sql using sqlca;
ls_sql = "ALTER TABLE app_sect_temp ADD	multi_record Integer NULL;"
execute immediate :ls_sql using sqlca;

ls_sql = "ALTER TABLE pd_affil_staff_cat ADD requested Integer NULL;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081403 maha 
commit using sqlca;

ls_sql = "update pd_affil_staff_cat set requested = 1 where requested is NULL and to_date is null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081403 maha 
commit using sqlca;
ls_sql = "update pd_affil_staff_cat set requested = 0 where requested is NULL and to_date is not null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//111403 maha 
commit using sqlca;



ls_sql = "ALTER TABLE conv_view_where modify value varchar(255) NULL;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//091803 maha
commit using sqlca;

ls_sql = "ALTER TABLE sys_help add user_id	char(15) null;"
execute immediate :ls_sql using sqlca;//092303 maha
commit using sqlca;
// start code change --- 11.07.2005 MSKINNER
//ls_sql = "ALTER TABLE sys_letters add CASE_REVIEW_LETTER integer NULL;"
//st_sql.text  = ls_sql
//execute immediate :ls_sql using sqlca;//092303 maha
// start code change --- 11.07.2005 MSKINNER
commit using sqlca;
// start code change --- 11.07.2005 MSKINNER
//ls_sql = "ALTER TABLE sys_letters add QA_LETTER integer NULL;"
//st_sql.text  = ls_sql
//execute immediate :ls_sql using sqlca;//092303 maha
// END code change --- 11.07.2005 MSKINNER
commit using sqlca;
ls_sql = "ALTER TABLE sys_letters add NET_DEV_LETTER integer NULL;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//092303 maha
commit using sqlca;
// start code change --- 11.07.2005 MSKINNER
//ls_sql = "ALTER TABLE sys_letters add case_review_letter_prac_level integer NULL;"
//st_sql.text  = ls_sql
//execute immediate :ls_sql using sqlca;//092303 maha
//commit using sqlca;
// end code change --- 11.07.2005 MSKINNER
commit using sqlca;
ls_sql = "ALTER TABLE sys_letters add case_review_letter_committee_level integer NULL;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//092303 maha
commit using sqlca;
ls_sql = "ALTER TABLE sys_letters add case_review_letter_level integer NULL;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//092303 maha
commit using sqlca;

ls_sql = "update sys_fields set field_type = 'N' where field_id = 366;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//100903 maha 
commit using sqlca;

ls_sql = "ALTER TABLE pd_images ADD file_name Char( 150 ) NULL;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//101503 maha 
commit using sqlca;

ls_sql = "INSERT INTO code_lookup VALUES (	-10000,	'Case/Peer Review Action Item Status',	'Complete',	'Completed',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//101503 maha 
commit using sqlca;
ls_sql = "INSERT INTO code_lookup VALUES (	-10026,	'Case/Peer Review Status',	'Closed',	'Closed',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//101503 maha 
commit using sqlca;
ls_sql = "INSERT INTO code_lookup VALUES (	-10025,	'Case/Peer Review Status',	'Pending',	'Pending',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//101503 maha 
commit using sqlca;
ls_sql = "INSERT INTO code_lookup VALUES (	-10024,	'Case/Peer Review Status',	'Open',	'Open',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//101503 maha 
commit using sqlca;
ls_sql = "INSERT INTO code_lookup VALUES (	-10023,	'Case/Peer Review Severity Grade',	'2',	'2',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'2');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//101503 maha 
commit using sqlca;
ls_sql = "INSERT INTO code_lookup VALUES (	-10022,	'Case/Peer Review Severity Grade',	'5',	'5',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'5');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//101503 maha 
commit using sqlca;
ls_sql = "INSERT INTO code_lookup VALUES (	-10021,	'Case/Peer Review Severity Grade',	'3',	'3',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'3');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//101503 maha 
commit using sqlca;
ls_sql = "INSERT INTO code_lookup VALUES (	-10020,	'Case/Peer Review Severity Grade',	'4',	'4',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'4');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//101503 maha 
commit using sqlca;
ls_sql = "INSERT INTO code_lookup VALUES (	-10019,	'Case/Peer Review Severity Grade',	'1',	'1',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'1');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//101503 maha 
commit using sqlca;
ls_sql = "INSERT INTO code_lookup VALUES (	-10018,	'Case/Peer Review Reason',	'Sentinel Event',	'Sentinel Event',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//101503 maha 
commit using sqlca;
ls_sql = "INSERT INTO code_lookup VALUES (	-10017,	'Case/Peer Review Reason',	'Adverse Event',	'Adverse Event',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//101503 maha 
commit using sqlca;
ls_sql = "INSERT INTO code_lookup VALUES (	-10016,	'Case/Peer Review Reason',	'Risk Management',	'Risk Management',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//101503 maha 
commit using sqlca;
ls_sql = "INSERT INTO code_lookup VALUES (	-10015,	'Case/Peer Review Committee Action',	'Review/Respond',	'Review and Respond',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//101503 maha 
commit using sqlca;
ls_sql = "INSERT INTO code_lookup VALUES (	-10014,	'Case/Peer Review Committee Action',	'Write Letter',	'Write Letter',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//101503 maha 
commit using sqlca;
ls_sql = "INSERT INTO code_lookup VALUES (	-10013,	'Case/Peer Review Committee Action',	'Corrective',	'Corrective Action Recommended',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//101503 maha 
commit using sqlca;
ls_sql = "INSERT INTO code_lookup VALUES (	-10012,	'Case/Peer Review Committee Action',	'FYI',	'FYI',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//101503 maha 
commit using sqlca;
ls_sql = "INSERT INTO code_lookup VALUES (	-10011,	'Case/Peer Review Action Item Type',	'Meeting',	'Meeting',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//101503 maha 
commit using sqlca;
ls_sql = "INSERT INTO code_lookup VALUES (	-10010,	'Case/Peer Review Action Item Type',	'Email',	'Send Email',	NULL,	NULL,NULL,	NULL,	NULL,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//101503 maha 
commit using sqlca;
ls_sql = "INSERT INTO code_lookup VALUES (	-10008,	'Case/Peer Review Action Item Type',	'Letter',	'Send Letter',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//101503 maha 
commit using sqlca;
ls_sql = "INSERT INTO code_lookup VALUES (	-10007,	'Case/Peer Review Action Item To',	'Depart Chair',	'Department Chair',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//101503 maha 
commit using sqlca;
ls_sql = "INSERT INTO code_lookup VALUES (	-10006,	'Case/Peer Review Action Item To',	'Admin',	'Administrator',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//101503 maha 
commit using sqlca;
ls_sql = "INSERT INTO code_lookup VALUES (	-10005,	'Case/Peer Review Action Item To',	'Practitioner',	'Practitioner',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//101503 maha 
commit using sqlca;
ls_sql = "INSERT INTO code_lookup VALUES (	-10004,	'Case/Peer Review Action Item To',	'Committee',	'Committee',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//101503 maha 
commit using sqlca;
ls_sql = "INSERT INTO code_lookup VALUES (	-10003,	'Case/Peer Review Action Item Status',	'Waiting',	'Waiting For Response',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//101503 maha 
commit using sqlca;
ls_sql = "INSERT INTO code_lookup VALUES (	-10002,	'Case/Peer Review Action Item Status',	'Incomplete',	'Incomplete',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//101503 maha 
commit using sqlca;
ls_sql = "INSERT INTO code_lookup VALUES (	-10001,	'Case/Peer Review Action Item Status',	'Pending',	'Pending',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//101503 maha 
commit using sqlca;

ls_sql = "INSERT INTO sys_letters VALUES (-5009,	'Case/Peer Review Physician Case Open Letter',	'Inform Physician a case is open for review',	'case_review_inform_physician_case_open.doc',	0,	0,	0,	NULL,	NULL,	2,	NULL,	1,	NULL,	NULL,	NULL,	NULL,	1);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//101503 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_letters VALUES (	-5010,	'Case/Peer Review Physician Case Findings Letters',	'Letter to physician explaining case findings',	'case_review_inform_physician_case_findings.doc',	1,	0,	0,	NULL,	NULL,	2,	NULL,	1,	NULL,	NULL,	NULL,	NULL,	1);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//101503 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_letters VALUES (	-5011,	'Case/Peer Review Committee Case Findings Letters',	'Letter to committee letting them know of case findings',	'case_review_inform_committee_case_findings.doc',	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	1,	NULL,	NULL,	NULL,	NULL,	2);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//101503 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_letters VALUES (	-5013,	'Case/Peer Review Committee Case Open',	'Inform committee that case has been open',	'case_review_inform_committee_case_open.doc',	0,	0,	0,	NULL,	NULL,	NULL,	NULL,	1,	NULL,	NULL,	NULL,	NULL,	2);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//101503 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_letters VALUES (	-5020,	'Case/Peer Review Dept Chair Case Findings',	'Notify Department Chair of case findings',	'case_review_inform_dept_chair_case_findings.doc',	0,	0,	0,	NULL,	NULL,	2,	NULL,	1,	NULL,	NULL,	NULL,	NULL,	3);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//101503 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_letters VALUES (	-5021,	'Case/Peer Review Dept Chair Case Open',	'Notify department chair that case has been open',	'case_review_inform_dept_chair_case_open.doc',	0,	0,	0,	NULL,	NULL,	2,	NULL,	1,	NULL,	NULL,	NULL,	NULL,	3);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//101503 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_letters VALUES (	-5022,	'Case/Peer Review Dept Chair Request Action',	'Letter to department chair requesting action',	'case_review_dept_chair_request_action.doc',	0,	0,	0,	NULL,	NULL,	2,	NULL,	1,	NULL,	NULL,	NULL,	NULL,	3);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//101503 maha 
commit using sqlca;

ls_sql = "CREATE TABLE dept_chair (	dept_chair_id Numeric(16, 0) null,	facility_id integer null,	department_code Numeric(16, 0) null,	section_code numeric(16, 0) null,	street_1 char(50) null,	street_2 char(50) null,	city char(25) null,	state char(2) null,	zip char(12) null,	email char(50) null,	phone char(13) null,	fax char(13) null,	name char(50) null,	salutation char(50) null,primary key(dept_chair_id));"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//101603 maha 
commit using sqlca;

ls_sql = "alter table export_fields add dept_sect_link integer null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//060702 maha
commit using sqlca;

ls_sql = "CREATE TABLE sys_user_version (	user_id char(12) null,	version_id char(12) null,	mod_date timestamp null,primary key(user_id));"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//102003 maha 
commit using sqlca;

ls_sql = "alter table export_auto_settings add active_only integer null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//102303 maha 
commit using sqlca;

ls_sql = "ALTER TABLE icred_settings ADD set_priv integer NULL;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110403 maha
commit using sqlca;
ls_sql = "update icred_settings set set_priv = 1 where set_priv is null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110403 maha
commit using sqlca;

ls_sql = "ALTER TABLE icred_settings ADD set_img integer NULL;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110403 maha
commit using sqlca;
ls_sql = "update icred_settings set set_img = 1 where set_img is null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110403 maha
commit using sqlca;

ls_sql = "ALTER TABLE icred_settings ADD set_peer integer NULL;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110403 maha
commit using sqlca;
ls_sql = "update icred_settings set set_peer = 0 where set_peer is null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110403 maha
commit using sqlca;

ls_sql = "CREATE TABLE dept_char (	dept_chair_id Numeric(16, 0) null,	facility_id integer null,	department_code Numeric(16,0 ) null,	section_code numeric(16, 0) null,	street_1 char(50) null,	street_2 char(50) null,	city char(25) null,	state char(2) null,	zip char(12) null,	email char(50) null,	phone char(13) null,	fax char(13) null,	name char(50) null,	salutation char(50) null);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110403 maha
commit using sqlca;
ls_sql = "CREATE TABLE pd_peer_review (case_number numeric(10,0) NOT NULL, facility_id integer NOT NULL, date_of_review date NOT NULL, review_status numeric(10,0) NOT NULL, reviewer char(15) NULL, review_reason numeric(10,0) NULL, date_of_occurrence Date NULL, medical_record_number char(30) NULL, patient_name char(50) NULL, admission_date date NULL, admitting_diagnoses long varchar NULL, sex numeric(10,0) NULL, age integer NULL, notes long varchar NULL, finding long varchar NULL, conclusion long varchar NULL, date_completed date NULL, time_of_occurrence time NULL, cust_1 char(50) NULL, cust_2 char(50) NULL, cust_3 char(50) NULL, cust_4 char(50) NULL, cust_5 char(50) NULL, cust_6 char(50) NULL, cust_7 char(50) NULL, cust_8 char(50) NULL, cust_9 char(50) NULL, cust_10 char(50) NULL, PRIMARY KEY ( case_number ));"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110603 maha
commit using sqlca;
ls_sql = "CREATE TABLE pd_peer_review_pracs (rec_id numeric(10,0) NOT NULL, prac_id numeric(8,0) NOT NULL, case_number numeric(10,0) NOT NULL, severity_grade numeric(10,0) NULL, notes long varchar NULL, active_status integer NULL, PRIMARY KEY ( rec_id, prac_id, case_number  ));"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110603 maha
commit using sqlca;
ls_sql = "CREATE TABLE pd_peer_review_action_items (	rec_id numeric(10, 0) not null,	case_number numeric(10, 0) not null,	action_type numeric(10, 0) null,	action_date date null,	action_to numeric( 10,0 ) null,	action_user char( 15 ) null,	notes long varchar null,	action_to_name char(100) null,	id numeric(10, 0) null,	action_status numeric(10, 0) null,	date_completed date null,	active_status integer, PRIMARY KEY ( rec_id, case_number  ));"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110603 maha
commit using sqlca;


ls_sql = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) values  (	-10000,	'Case/Peer Review Action Item Status',	'Complete',	'Completed',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110603 maha
commit using sqlca;
ls_sql = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) values  (	-10001,	'Case/Peer Review Action Item Status',	'Pending',	'Pending',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110603 maha
commit using sqlca;
ls_sql = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) values  (	-10002,	'Case/Peer Review Action Item Status',	'Incomplete',	'Incomplete');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110603 maha
commit using sqlca;
ls_sql = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) values  (	-10003,	'Case/Peer Review Action Item Status',	'Waiting',	'Waiting For Response');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110603 maha
commit using sqlca;
ls_sql = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) values  (	-10004,	'Case/Peer Review Action Item To',	'Committee',	'Committee');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110603 maha
commit using sqlca;
ls_sql = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) values  (	-10005,	'Case/Peer Review Action Item To',	'Practitioner','Practitioner');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110603 maha
commit using sqlca;
ls_sql = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) values  (	-10006,	'Case/Peer Review Action Item To',	'Admin',	'Administrator');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110603 maha
commit using sqlca;
ls_sql = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) values  (	-10007,	'Case/Peer Review Action Item To',	'Depart Chair',	'Department Chair');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110603 maha
commit using sqlca;
ls_sql = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) values  (	-10008,	'Case/Peer Review Action Item Type',	'Letter',	'Send Letter');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110603 maha
commit using sqlca;
ls_sql = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) values  (	-10010,	'Case/Peer Review Action Item Type',	'Email',	'Send Email');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110603 maha
commit using sqlca;
ls_sql = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) values  (	-10011,	'Case/Peer Review Action Item Type',	'Meeting',	'Meeting');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110603 maha
commit using sqlca;
ls_sql = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) values  (	-10012,	'Case/Peer Review Committee Action',	'FYI',	'FYI');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110603 maha
commit using sqlca;
ls_sql = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) values  (	-10013,	'Case/Peer Review Committee Action',	'Corrective',	'Corrective Action Recommended');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110603 maha
commit using sqlca;
ls_sql = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) values  (	-10014,	'Case/Peer Review Committee Action',	'Write Letter',	'Write Letter');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110603 maha
commit using sqlca;
ls_sql = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) values  (	-10015,	'Case/Peer Review Committee Action',	'Review/Respond',	'Review and Respond');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110603 maha
commit using sqlca;
ls_sql = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) values  (	-10016,	'Case/Peer Review Reason',	'Risk Management',	'Risk Management');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110603 maha
commit using sqlca;
ls_sql = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) values  (	-10017,	'Case/Peer Review Reason',	'Adverse Event',	'Adverse Event');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110603 maha
commit using sqlca;
ls_sql = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) values (	-10018,	'Case/Peer Review Reason',	'Sentinel Event',	'Sentinel Event');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110603 maha
commit using sqlca;
ls_sql = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) values  (	-10019,	'Case/Peer Review Severity Grade',	'1',	'1');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110603 maha
commit using sqlca;
ls_sql = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) values  (	-10020,	'Case/Peer Review Severity Grade',	'4',	'4');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110603 maha
commit using sqlca;
ls_sql = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) values  (	-10021,	'Case/Peer Review Severity Grade',	'3',	'3');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110603 maha
commit using sqlca;
ls_sql = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) values  (	-10022,	'Case/Peer Review Severity Grade',	'5',	'5');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110603 maha
commit using sqlca;
ls_sql = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) values  (	-10023,	'Case/Peer Review Severity Grade',	'2',	'2');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110603 maha
commit using sqlca;
ls_sql = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) values  (	-10024,	'Case/Peer Review Status',	'Open',	'Open');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110603 maha
commit using sqlca;
ls_sql = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) values  (	-10025,	'Case/Peer Review Status',	'Pending',	'Pending');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110603 maha
commit using sqlca;
ls_sql = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) values  (	-10026,	'Case/Peer Review Status',	'Closed',	'Closed');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110603 maha
commit using sqlca;
select count(lookup_code) into :cnt from code_lookup where lookup_name = 'Action Type' and code = 'PAR';
if cnt = 0 then
	ls_sql = "INSERT INTO code_lookup VALUES (	-1653,	'Action Type',	'PAR',	'Participation Number Received',	'S',	'PN Received',	NULL,	NULL,	NULL,	NULL,null,'1');"
	st_sql.text  = ls_sql
	execute immediate :ls_sql using sqlca;//112103 maha
	commit using sqlca;
end if
ls_sql = "update code_lookup set code = 'PAR' where code = 'PN Received' and lookup_name = 'Action Type';"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//112103 maha
commit using sqlca;
ls_sql = "update code_lookup set type = 'S' where lookup_name = 'Action Type' and code = 'App Out To MD';"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//111203 maha
commit using sqlca;
ls_sql = "update code_lookup set type = 'S' where lookup_name = 'Action Type' and code = 'App Rcvd Payor';"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//111203 maha
commit using sqlca;
ls_sql = "update code_lookup set type = 'S' where lookup_name = 'Action Type' and code = 'App Rcvd Prac';"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//111203 maha
commit using sqlca;
ls_sql = "update sys_fields set app_fill_field_len = 5 where app_fill_field_len is null or app_fill_field_len = 0;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//111203 maha
commit using sqlca;
ls_sql = "update data_view_fields set field_order = 200 where field_id = 112;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//111203 maha
commit using sqlca;

//ls_sql = "Alter table app_hdr drop primary key;"
//execute immediate :ls_sql using sqlca;//071502 maha
//commit using sqlca;
//ls_sql = "ALTER TABLE app_hdr modify app_id numeric(10,0);"
//st_sql.text  = ls_sql
//execute immediate :ls_sql using sqlca;//111803 maha inova
//commit using sqlca;
//ls_sql = "Alter table app_hdr add primary key (app_id,facility_id);"
//execute immediate :ls_sql using sqlca;//071502 maha
//commit using sqlca;
//ls_sql = "Alter table app_field_prop modify app_id numeric(10,0);"
//execute immediate :ls_sql using sqlca;//071502 maha
//commit using sqlca;
ls_sql = "ALTER TABLE facility_ver_rules ADD priority_user Char( 10 ) null;"
execute immediate :ls_sql using sqlca;//111503 maha
commit using sqlca;
ls_sql = "ALTER TABLE facility_ver_rules ADD priority Integer null;"
execute immediate :ls_sql using sqlca;//111503 maha
commit using sqlca;
ls_sql = "ALTER TABLE facility_ver_rules ADD priority_user_exp Char( 10 ) null;"
execute immediate :ls_sql using sqlca;//111503 maha
commit using sqlca;
ls_sql = "ALTER TABLE facility_ver_rules ADD priority Integer null;"
execute immediate :ls_sql using sqlca;//111503 maha
commit using sqlca;
ls_sql = "CREATE 	TABLE	screen_help (	screen_id	integer, rec_id		integer, title			varchar(100), detail		varchar(2000), hide_on_load	integer);"
execute immediate :ls_sql using sqlca;//121203 maha
commit using sqlca;
ls_sql = "ALTER	TABLE	security_users ADD  prac_id integer null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//121203 maha 
commit using sqlca;
ls_sql = "ALTER	TABLE	security_users ADD pref_win_left integer	null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//121203 maha 
commit using sqlca;
ls_sql = "ALTER	TABLE	security_users ADD  pref_win_top integer null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//121203 maha 
commit using sqlca;	
ls_sql = "ALTER	TABLE	sys_tables	ADD  is_required  integer null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//121203 maha 
commit using sqlca;
ls_sql = "ALTER	TABLE	data_view_screen	ADD is_required integer null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//121203 maha 
commit using sqlca;		
ls_sql = "ALTER	TABLE	sys_audit	modify  audit_type char(3) null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//121203 maha 
commit using sqlca;
ls_sql = "alter table export_fields add dept_sect_field varchar(30) null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//060702 maha
commit using sqlca;
INSERT INTO security_rights_action VALUES (	1470,	28,	170,	'View Rights',	2);
ls_sql = "INSERT INTO security_modules VALUES (	28,	0,	'IntelliReport');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//010804 maha 
commit using sqlca;
ls_sql = "INSERT INTO security_sub_module  VALUES (	170,	28,	'Main');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//010804 maha 
commit using sqlca;
ls_sql = "INSERT INTO security_rights_action VALUES (	1470,	28,	170,	'View Rights',	2);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//010804 maha 
commit using sqlca;
ls_sql = "update sys_fields set audit_fld = null where field_id = 100105;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//012104 maha to correct audit trail problem with active_status 
commit using sqlca;

//web security

ls_sql = "INSERT	INTO	security_modules	(	module_id		, software_version		, module_name	) VALUES	(	29		, 4	, 'IntelliCred Web');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//020404 maha 
commit using sqlca;
ls_sql = "INSERT	INTO	security_sub_module	(	module_id		, sub_module_id		, sub_module_name	)	VALUES		(	29		, 180		, 'Web Administration'	);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//020404 maha 
commit using sqlca;
ls_sql = "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	29	, 180	,1480 , 'View Rights'	, 2	);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//020404 maha 
commit using sqlca;
ls_sql = "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name		, dddw_type)	VALUES	(	29,180 ,1490, 'D/E Audit', 1);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//020404 maha 
commit using sqlca;
ls_sql = "INSERT INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name			, dddw_type)	VALUES	(	29,	180,1500 	, 'Create Users', 1);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//020404 maha 
commit using sqlca;
ls_sql = "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name		, dddw_type)	VALUES	(	29, 180,	1510 	, 'IntelliReport', 1);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//020404 maha 
commit using sqlca;
ls_sql = "INSERT	INTO	security_sub_module (	module_id	, sub_module_id		, sub_module_name	)	VALUES	(	29	, 190	, 'Credentialing Tab');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//020404 maha 
commit using sqlca;
ls_sql = "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	) VALUES	(	29	,190	, 1520	, 'View Rights'	, 2);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//020404 maha 
commit using sqlca;
ls_sql = "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id 	, action_id	, action_name		, dddw_type)	VALUES	(29	, 190	, 1530	, 'Practitioner Search'	, 1);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//020404 maha 
commit using sqlca;
ls_sql = "INSERT	INTO	security_sub_module	(	module_id	, sub_module_id	, sub_module_name	)	VALUES	(	29	, 200, 'Dashboard Tab');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//020404 maha 
commit using sqlca;
ls_sql = "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id	, action_id	, action_name	,dddw_type)	VALUES	(	29	,200,1540	, 'View Rights'	, 2);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//020404 maha 
commit using sqlca;
ls_sql = "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id	, action_id	, action_name	, dddw_type)	VALUES	(	29	,200,1550	, 'View Missing Credentials'	, 1);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//020404 maha 
commit using sqlca;
ls_sql = "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id	, action_id	, action_name	,dddw_type)	VALUES	(	29	, 200,1560	, 'View Req Suport Docs', 1);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//020404 maha 
commit using sqlca;
ls_sql = "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id	, action_id	, action_name	,dddw_type)	VALUES	(	29	, 200,1570	, 'View Pri Source Verif', 1);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//020404 maha 
commit using sqlca;
ls_sql = "INSERT	INTO	security_sub_module	(	module_id	, sub_module_id	, sub_module_name	)	VALUES	(	2	, 210, 'Practitoner Profile');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//020404 maha 
commit using sqlca;
ls_sql = "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id	, action_id	, action_name	,dddw_type)	VALUES	(	2	, 210,1580	, 'View Rights', 1);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//020404 maha 
commit using sqlca;
ls_sql = "INSERT	INTO	security_sub_module	(	module_id	, sub_module_id	, sub_module_name	)	VALUES	(	24	, 220, 'Batch Add Applications');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//020404 maha 
commit using sqlca;
ls_sql = "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id	, action_id	, action_name	,dddw_type)	VALUES	(	24	, 220,1590	, 'Access Rights', 1);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//020404 maha 
commit using sqlca;
ls_sql = "INSERT	INTO	security_sub_module	(	module_id	, sub_module_id	, sub_module_name	)	VALUES	(	25	, 230, 'IntelliBatch Painter');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//020404 maha 
commit using sqlca;
ls_sql = "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id	, action_id	, action_name	,dddw_type)	VALUES	(	25	, 230,2000	, 'Access Rights', 1);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//020404 maha 
commit using sqlca;
//invoice tables
ls_sql = "create table pd_invoice (rec_id numeric(10,0) null, prac_id numeric(10,0) null,facility_id integer null,inv_date datetime null, due_date datetime null, tax_a numeric(10,2) null, amt_billed numeric(10,2) null, invc_amt numeric(10,2) null,amt_paid numeric(10,2) null, paid integer, note varchar(256) null, primary key(rec_id));"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//022704 maha 
commit using sqlca;
ls_sql = "create table pd_inv_rows (item_id numeric(10,0) null,rec_id numeric(10,0) null,invt_id numeric(10,0) null,billing_item varchar(100) null,quantity integer null, cost numeric(10,3) null, price numeric(10,3) null, extended numeric(10,2) null, primary key(item_id));"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//022704 maha 
commit using sqlca;
ls_sql = "create table invt_items (invt_id numeric(10,0),description varchar(100),code varchar (25), cost numeric(10,3), price numeric(10,3), primary key(invt_id));"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//022704 maha 
commit using sqlca;

update icred_settings	set set_18 = 41; //version setting
commit using sqlca;
of_ver45_update()  //Start Code Change ---- 12.18.2006 #V7 maha
//don't add more to this function 

Return 1
end function

public function integer of_ver45_update ();string ls_sql
integer li_set

cb_update.text = "Ver 4.5 Updates"
st_update.text  = "Ver 4.5 Updates"

ls_sql = "update data_view_screen set include_data_fields = 0 where screen_id = 8;"//cont education
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//031004 maha
commit using sqlca;

ls_sql = "alter table sys_multi_app delete primary key;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//031004 maha 
commit using sqlca;
ls_sql = "alter table sys_multi_app modify app_id decimal(10,0) null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//031004 maha 
commit using sqlca;
ls_sql = "ALTER TABLE sys_multi_app ADD PRIMARY KEY ( multi_app_id,parent_facility_id, app_id );"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//031004 maha 
commit using sqlca;

ls_sql = "CREATE TABLE sys_fax_template (fax_temp_id integer NOT NULL,	facility_id integer NULL, template_name char(100) NULL, cover_sheet char(250) NULL,  subject_text char(250) NULL,   cover_message text NULL, email_cc char(250) NULL, default_for_corro integer NULL,  default_for_verif integer NULL,  default_for_miss_ltr integer NULL, default_for_imaging integer NULL, default_for_apps integer NULL, default_for_exp_ltrs integer NULL,						default_for_exp_appt integer NULL, PRIMARY KEY ( fax_temp_id ) );"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//033104 maha 
commit using sqlca;

ls_sql = "create table inv_company (rec_id integer null,comp_name varchar (100) null,address varchar (150) null, phone varchar(25) null, fax varchar(25) null, term_label varchar(25) null, term_days integer null, penalty numeric (5,2) null, primary key(rec_id));"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//033104 maha 
commit using sqlca;

ls_sql = "UPDATE data_view_fields set display_only = 'N' where display_only is null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//041404 maha 
commit using sqlca;

select set_18 into :li_set from icred_settings;
if li_set < 42 then //run this only one time
	ls_sql = "UPDATE data_view_fields set display_only = 'N' ;"
	st_sql.text  = ls_sql
	execute immediate :ls_sql using sqlca;//041404 maha 
	commit using sqlca;
	update icred_settings	set set_18 = 42; //version setting
	commit using sqlca;
end if

ls_sql = "INSERT INTO sys_fields VALUES (	43,	100050,	360,	'prov_status',	'N',	1,	'Provisional status',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	1,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//041904 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	43,	100051,	370,	'prior_appt_start',	'D',	12,	'Prior Appt Start',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	12,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//041904 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	43,	100052,	380,	'prior_appt_end',	'D',	12,	'Prior Appt End',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	12,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//041904 maha 
commit using sqlca;

ls_sql = "Alter table address_lookup modify web_address varchar(255) null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//042004 maha 
commit using sqlca;

ls_sql = "ALTER TABLE facility_ver_rules ADD priority_exp Integer null;"
execute immediate :ls_sql using sqlca;//042304 maha
commit using sqlca;

ls_sql = "Alter table icred_settings add dev_title varchar(50) null;"
execute immediate :ls_sql using sqlca;//040403 maha duplicate from button code
st_sql.text  = ls_sql
commit using sqlca;

ls_sql = "CREATE TABLE inv_company (	rec_id float null,	comp_name char(100) null,	address char(150) null,	phone char(25) null,	fax char(25) null,	term_label char(25) null,	term_days float null,	penalty decimal(16, 2) null);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//050404 maha 
commit using sqlca;

ls_sql = "ALTER TABLE verif_info ADD verification_picture long binary NULL;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//042704 maha 
commit using sqlca;
ls_sql = "ALTER TABLE verif_info ADD verification_picture_flag integer NULL;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//042704 maha 
commit using sqlca;

ls_sql = "ALTER TABLE address_lookup ADD web_title varchar( 200 ) null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//050304 maha 
commit using sqlca;
ls_sql = "CREATE TABLE pd_peer_committee_review (rec_id numeric(10,0) NOT NULL, case_number numeric(10,0) NOT NULL, committee_name numeric(10,0) NOT NULL, date_reported date NULL, action_requested_taken numeric(10,0) NULL, date_completed date NULL, notes long varchar NULL, active_status integer NULL, PRIMARY KEY ( rec_id, case_number, committee_name  ));"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//050304 maha 
commit using sqlca;

string s //maha050504
s = gs_dir_path + "Intellicred\Fax"
CreateDirectoryA(s, 0)

ls_sql = "update data_view_screen set include_date_fields = null where screen_id = 8;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//050604 maha 
commit using sqlca;

ls_sql = "alter table pd_board_specialty add board_certified numeric(10,2) null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//051204 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	2,	9810,	180,	'expiration_date',	'D',	10,	'Expiration Date',	NULL,	'N',	'N',	'',	NULL,	'mm/dd/yyyy',	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	12,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//051204 maha 
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	2,	9811,	190,	'board_certified',	'N',	20,'Board Certified',	NULL,	'C',	'Y',	'Yes/No',	'C',	NULL,	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	3,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//051204 maha 
commit using sqlca;
ls_sql = "INSERT INTO data_view_fields 	(data_view_field_id,	data_view_id,	screen_id,	field_id,	field_label,field_order,	display_only,	include_in_browse,	field_x,	field_y,	field_width,	field_height,	justification,	edit_field_type,field_label_justification,field_label_x,field_label_y,field_label_width,visible	) VALUES (	4020,	1,	19,	9810,	'Expiration Date',	140,	'N',	'Y',	2053,	528,	360,	64,	'0',	'E',	0,	2053,	456,	444,	'Y');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//051204 maha 
commit using sqlca;
ls_sql = "INSERT INTO data_view_fields 	(data_view_field_id,	data_view_id,	screen_id,	field_id,	field_label,field_order,	display_only,	include_in_browse,	field_x,	field_y,	field_width,	field_height,	justification,	edit_field_type,field_label_justification,field_label_x,field_label_y,field_label_width,visible	) VALUES (	4021,	1,	19,	9811,	'Board Certified',	130,	'N',	'Y',	2053,	328,	425,	64,	'0',	'E',	0,	2053,	256,	400,	'Y');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//051204 maha 
commit using sqlca;

ls_sql = "alter table security_users add last_pass_update date null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//051704 maha 
commit using sqlca;

ls_sql = "Alter table sys_user_version modify version_id varchar(30) null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//051804 maha 
commit using sqlca;

ls_sql = "Alter table sys_reports add r_type char(1) null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//051804 maha 
commit using sqlca;

ls_sql = "ALTER TABLE net_dev_action_items MODIFY notes Long VarChar null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//052004 maha 
commit using sqlca;

ls_sql = "Alter table sys_reports add r_type char(1) null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//052004 maha 
commit using sqlca;

ls_sql = "ALTER TABLE net_dev_action_items add due_date date null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//052404 readded maha 
commit using sqlca;

ls_sql = "ALTER TABLE pd_images ADD image_data image NULL;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//061104 maha 
commit using sqlca;

ls_sql = "ALTER TABLE icred_settings ADD image_storage_type Integer NULL;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//061104 maha 
commit using sqlca;

ls_sql = "Update icred_settings set image_storage_type = 0 where image_storage_type is NULL;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//061104 maha 
commit using sqlca;

//\/j rice mods
ls_sql = "ALTER TABLE	security_users ADD prac_id integer null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//061804 maha for jrice
commit using sqlca;
ls_sql = "ALTER TABLE	security_users ADD de_status integer null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//061804 maha for jrice
commit using sqlca;
ls_sql = "ALTER TABLE	security_users ADD pref_win_left integer null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//061804 maha for jrice
commit using sqlca;
ls_sql = "ALTER TABLE	security_users ADD pref_win_top integer integer null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//061804 maha for jrice
commit using sqlca;
ls_sql = "ALTER TABLE	sys_tables ADD is_required integer null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//061804 maha for jrice
commit using sqlca;
ls_sql = "ALTER TABLE	data_view_screen ADD  is_required integer null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//061804 maha for jrice
commit using sqlca;
ls_sql = "CREATE TABLE screen_help 	(rec_id	integer not null,	screen_id	integer	null,  title	varchar(100) null, detail	long varchar null, hide_on_load	integer null, primary key(rec_id))"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//061804 maha for jrice
commit using sqlca;
ls_sql = "ALTER	TABLE	address_lookup	ADD audit_flag	varchar(3) null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//061804 maha for jrice
commit using sqlca;
ls_sql = "ALTER	TABLE	security_users	ADD  ( audit_type integer ) null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//070904 maha for jrice
commit using sqlca;
//\
ls_sql = "CREATE TABLE  oig_data (	lastname char(20) null,	firstname char(15) null,	midname char(15) null,	busname char(30) null,	general char(20) null,	specialty char(20) null,	upin char(6) null,	dob char(8) null,	address char(30) null,	city char(20) null,	state char(2) null,	zip char(5) null,	sanctype char(9) null,	sancdate char(8) null,	reindate char(8) null, recid numeric(10,0) null);"
execute immediate :ls_sql using sqlca;//012203 maha  corrected 071904
commit using sqlca;

ls_sql = "ALTER TABLE sys_fields add use_validation integer null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//072304 maha 
commit using sqlca;

ls_sql = "Alter table review_question add key_question integer null;"
execute immediate :ls_sql using sqlca;//082604 maha 
st_sql.text  = ls_sql
commit using sqlca;

ls_sql = "Update review_question set key_question = 0 where key_question is null;"
execute immediate :ls_sql using sqlca;//082604 maha 
st_sql.text  = ls_sql
commit using sqlca;

ls_sql = "Alter table net_dev_action_items add app_print_id numeric(8,0) null;"
execute immediate :ls_sql using sqlca;//082604 maha 
st_sql.text  = ls_sql
commit using sqlca;

ls_sql = "update net_dev_action_items set app_print_id  = app_id where app_print_id is null;"
execute immediate :ls_sql using sqlca;//082604 maha 
st_sql.text  = ls_sql
commit using sqlca;

ls_sql = "Alter table net_dev_action_items modify app_id numeric(8,0) null;"
execute immediate :ls_sql using sqlca;//082604 maha 
st_sql.text  = ls_sql
commit using sqlca;

ls_sql = "Alter table sys_multi_app add app_print_id numeric(8,0) null;"
execute immediate :ls_sql using sqlca;//082604 maha 
st_sql.text  = ls_sql
commit using sqlca;

ls_sql = "update sys_multi_app set app_print_id  = app_id where app_print_id is null;"
execute immediate :ls_sql using sqlca;//082604 maha 
st_sql.text  = ls_sql
commit using sqlca;

ls_sql = "Alter table pd_review_hdr add lock_for_edit integer null;"
execute immediate :ls_sql using sqlca;//082604 maha 
commit using sqlca;

ls_sql = "update pd_review_hdr set lock_for_edit = 0 where lock_for_edit is null;"
execute immediate :ls_sql using sqlca;//082604 maha 
st_sql.text  = ls_sql
commit using sqlca;

ls_sql = "CREATE TABLE security_user_department (user_depart_id integer NOT NULL, user_id varchar(10) NOT NULL, department_id numeric(10,0) NOT NULL, access_rights integer NULL, PRIMARY KEY ( user_depart_id )) IN SYSTEM;"
execute immediate :ls_sql using sqlca;//090304 maha 
st_sql.text  = ls_sql
commit using sqlca;

ls_sql = "ALTER TABLE security_user_department ADD NOT NULL FOREIGN KEY security_users (user_id) REFERENCES security_users (user_id) ON DELETE RESTRICT ON UPDATE RESTRICT WITH HASH SIZE 10;"
execute immediate :ls_sql using sqlca;//090304 maha 
st_sql.text  = ls_sql
commit using sqlca;
ls_sql = "ALTER TABLE code_lookup ADD CAQH_CODE Integer null;"
execute immediate :ls_sql using sqlca;//090304 maha 
st_sql.text  = ls_sql
commit using sqlca;
ls_sql = "ALTER TABLE code_lookup ADD ic_n numeric(10,0) null;"
execute immediate :ls_sql using sqlca;//090304 maha 
st_sql.text  = ls_sql
commit using sqlca;
ls_sql = "ALTER TABLE code_lookup ADD ic_c varchar(50) null;"
execute immediate :ls_sql using sqlca;//090304 maha 
st_sql.text  = ls_sql
commit using sqlca;
ls_sql = "ALTER TABLE address_lookup ADD CAQH_CODE Integer null;"
execute immediate :ls_sql using sqlca;//090304 maha 
st_sql.text  = ls_sql
commit using sqlca;
ls_sql = "ALTER TABLE address_lookup ADD ic_n numeric(10,0) null;"
execute immediate :ls_sql using sqlca;//090304 maha 
st_sql.text  = ls_sql
commit using sqlca;
ls_sql = "ALTER TABLE address_lookup ADD ic_c varchar(50) null;"
execute immediate :ls_sql using sqlca;//090304 maha 
st_sql.text  = ls_sql
commit using sqlca;
ls_sql = "Update code_lookup SET caqh_code = custom_6;"
execute immediate :ls_sql using sqlca;//090304 maha 
st_sql.text  = ls_sql
commit using sqlca;
ls_sql = "Update address_lookup SET caqh_code = custom_6;"
execute immediate :ls_sql using sqlca;//090304 maha 
st_sql.text  = ls_sql
commit using sqlca;

ls_sql = "create table sys_view_list (list_id numeric(10,0) null,view_name varchar(128) null,view_sql long varchar null,update_ran datetime null,ic_updated datetime null, primary key (list_id));"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//092904 maha 
commit using sqlca;

ls_sql = "Alter table review_question add key_quest integer null;"
execute immediate :ls_sql using sqlca;//090304 maha
st_sql.text  = ls_sql
commit using sqlca;

ls_sql = "update review_question key_quest = 0 where key_quest is null;"
execute immediate :ls_sql using sqlca;//090304 maha 
st_sql.text  = ls_sql
commit using sqlca;

ls_sql = "Alter table review_question add key_value numeric(5,2) null;"
execute immediate :ls_sql using sqlca;//090304 maha 
st_sql.text  = ls_sql
commit using sqlca;

ls_sql = "Alter table review_hdr add total_points numeric(5,2) null;"
execute immediate :ls_sql using sqlca;//090804 maha
st_sql.text  = ls_sql
commit using sqlca;
// start code change --- 11.07.2005 MSKINNER

//ls_sql = "update sys_letters set CASE_REVIEW_LETTER = 0 where CASE_REVIEW_LETTER is NULL;"
//st_sql.text  = ls_sql
//execute immediate :ls_sql using sqlca;//101504 maha 
//commit using sqlca;
// end code change --- 11.07.2005 MSKINNER

ls_sql = "update sys_letters set net_dev_letter = 1 where letter_id in(1001,1002,1003,1004);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//101504 maha 
commit using sqlca;

//ls_sql = ""
//st_sql.text  = ls_sql
//execute immediate :ls_sql using sqlca;//061804 maha 
//commit using sqlca;
//Start Code Change ---- 05.23.2006 #486 maha
update icred_settings	set set_18 = 46; //version setting
commit using sqlca;
//End Code Change---05.23.2006


//DO NOT UNCOMMENT FOLLOWING UNTIL DONE WITH THIS FUNCTION 
update icred_settings	set set_18 = 45; //version setting
commit using sqlca;
of_ver50_updates()  //Start Code Change ---- 12.18.2006 #V7 maha

Return 1
end function

public function integer of_ver50_updates ();string ls_sql
integer li_set
long li_test

cb_update.text = "Ver 5.0 Updates"
st_update.text  = "Ver 5.0 Updates"
	
ls_sql = "INSERT	INTO	security_modules	(	module_id		, software_version		, module_name	) VALUES	(	30		, 4	, 'Quality Assurance');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110804 maha 
commit using sqlca;
ls_sql = "INSERT	INTO	security_modules	(	module_id		, software_version		, module_name	) VALUES	(	31		, 4	, 'Peer Review');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110804 maha 
commit using sqlca;
ls_sql = "INSERT	INTO	security_modules	(	module_id		, software_version		, module_name	) VALUES	(	32		, 4	, 'Fax Template painter');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110804 maha 
commit using sqlca;

ls_sql = "INSERT	INTO	security_sub_module	(	module_id		, sub_module_id		, sub_module_name	)	VALUES		(	30		, 250		, 'QA Folder'	);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110804 maha 
commit using sqlca;
ls_sql = "INSERT	INTO	security_sub_module	(	module_id		, sub_module_id		, sub_module_name	)	VALUES		(	30		, 240	, 'QA Painter'	);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110804 maha 
commit using sqlca;
ls_sql = "INSERT	INTO	security_sub_module	(	module_id		, sub_module_id		, sub_module_name	)	VALUES		(	31		, 270	, 'Peer Review Folder'	);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca; //110804 maha 
commit using sqlca;
ls_sql = "INSERT	INTO	security_sub_module	(	module_id		, sub_module_id		, sub_module_name	)	VALUES		(	32		, 280		, 'Main'	);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110804 maha 
commit using sqlca;

ls_sql = "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	30	, 250,2020 , 'View Rights'	, 2	);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110804 maha 
commit using sqlca;
ls_sql = "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	30	, 250	,2030 , 'Action Items'	, 2	);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110804 maha 
commit using sqlca;
ls_sql = "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	30	, 240	,2010 , 'Access Rights'	, 2	);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110804 maha 
commit using sqlca;
ls_sql = "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	31	, 270	,2040, 'View Rights'	, 2	);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110804 maha 
commit using sqlca;
ls_sql = "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	31	, 270	,2060 , 'Action Items'	, 2	);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110804 maha 
commit using sqlca;
ls_sql = "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	32	, 280	,2050 , 'Access Rights'	, 2	);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110804 maha 
commit using sqlca;

///
ls_sql = "create table QA_PROFILE (    QA_PROFILE_ID integer  not null, FACILITY_ID integer, PROFILE_NAME varchar(100)          not null,    SPECIALTY_ID   numeric(8,0)          not null,    primary key (QA_PROFILE_ID));"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110804 maha 
commit using sqlca;
ls_sql = "create table QA_PROFILE_GROUP (    QA_PROFILE_GROUP_ID integer not null,    QA_PROFILE_ID integer null,  QA_PROFILE_GROUP_NAME         varchar(100)          not null,    primary key (QA_PROFILE_GROUP_ID));"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110804 maha 
commit using sqlca;
ls_sql = "create table PD_QA_HDR (    PD_QA_HDR_ID numeric(12,2)not null, QA_PROFILE_ID  integer null,    PRAC_ID numeric(10,0)         not null,    FROM_DATE timestamp null,  TO_DATE   timestamp null, ACTIVE_STATUS integer null,    FACILITY_ID  integer   null,    primary key (PD_QA_HDR_ID));"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110804 maha 
commit using sqlca;
ls_sql = "create table QA_MEASUREMENT (    PROFILE_GROUP_MEASUREMENT_ID  integer              not null,    QA_PROFILE_ID  integer not null,    QA_PROFILE_GROUP_ID  integer  not null, PD_QA_HDR_ID         numeric(12,2) null,   THRESHOLD numeric(6,2)  null,    INCLUDE_IN_PROFILE  integer null ,    DATA_FORMAT integer not null,    QA_MEASUREMENT_NAME           varchar(100)          not null,    primary key (PROFILE_GROUP_MEASUREMENT_ID, QA_PROFILE_ID,QA_PROFILE_GROUP_ID));"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110804 maha 
commit using sqlca;
ls_sql = "create table PD_QA_MEASUREMENTS (    PD_QA_MEASUREMENTS_ID         integer   not null,    PD_QA_HDR_ID    numeric(12,2) not null,  PROFILE_GROUP_MEASUREMENT_ID  integer not null,    MEASUREMENT_VALUE numeric(10,2) null,    primary key (PD_QA_MEASUREMENTS_ID));"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110804 maha 
commit using sqlca;
ls_sql = "alter table QA_PROFILE_GROUP    add foreign key FK_QA_PROFI_REF_573_QA_PROFI (QA_PROFILE_ID)       references QA_PROFILE (QA_PROFILE_ID) on update restrict on delete restrict;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110804 maha 
commit using sqlca;
ls_sql = "alter table QA_MEASUREMENT     add foreign key FK_QA_MEASU_REF_576_QA_PROFI (QA_PROFILE_GROUP_ID)       references QA_PROFILE_GROUP (QA_PROFILE_GROUP_ID) on update restrict on delete restrict;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110804 maha 
commit using sqlca;
ls_sql = "alter table QA_MEASUREMENT    add foreign key FK_QA_MEASU_REF_579_QA_PROFI (QA_PROFILE_GROUP_ID)       references QA_PROFILE_GROUP (QA_PROFILE_GROUP_ID) on update restrict on delete restrict;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110804 maha 
commit using sqlca;
ls_sql = "alter table PD_QA_MEASUREMENTS    add foreign key FK_PD_QA_ME_REF_662_PD_QA_HD (PD_QA_HDR_ID)       references PD_QA_HDR (PD_QA_HDR_ID) on update restrict on delete restrict;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110804 maha 
commit using sqlca;

ls_sql = "create table QA_PD_REVIEW_ACTION_ITEMS(    PD_PEER_REVIEW_ACTION_ITEMS_ID numeric(10)not null,    PD_QA_HDR_ID  numeric(12,2)  not null,    ACTION_TYPE  numeric(10) null,    ACTION_TO numeric(10) null,    ACTION_DATE date null,    ACTION_USER varchar(15) null,    ACTIVE_STATUS INTEGER null,    DATE_COMPLETED DATE null,    ACTION_STATUS numeric(10) null,    ID numeric(10) null,    ACTION_TO_NAME varchar(100) null,    NOTES long varchar null,    PRAC_ID numeric(10,0)  not null,    primary key (PD_PEER_REVIEW_ACTION_ITEMS_ID));"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//122004 maha 
commit using sqlca;
ls_sql = "alter table PD_QA_HDR add HDR_COMMENT varchar(255) not null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//122004 maha 
commit using sqlca;
ls_sql = "alter table PD_QA_HDR add REASON integer not null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//122004 maha 
commit using sqlca;


ls_sql = "UPDATE code_lookup SET custom_2 = 1 WHERE code = 'App Out To MD' AND custom_2 Is Null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//111204 maha 
commit using sqlca;
ls_sql = "UPDATE code_lookup SET custom_2 = 60 WHERE code = 'App Rcvd Payor' AND custom_2 Is Null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//111204 maha 
commit using sqlca;
ls_sql = "UPDATE code_lookup SET custom_2 = 15 WHERE code = 'App Rcvd Prac' AND custom_2 Is Null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//111204 maha 
commit using sqlca;

ls_sql = "ALTER TABLE icred_settings ADD set_41 integer NULL;"
execute immediate :ls_sql using sqlca;//022305 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "update icred_settings set set_41 = 0 where set_41 is null;"
execute immediate :ls_sql using sqlca;//022305 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "ALTER TABLE icred_settings ADD set_42 integer NULL;"
execute immediate :ls_sql using sqlca;//022305 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "update icred_settings set set_42 = 0 where set_42 is null;"
execute immediate :ls_sql using sqlca;//022305 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "ALTER TABLE icred_settings ADD set_43 integer NULL;"
execute immediate :ls_sql using sqlca;//022305 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "update icred_settings set set_43 = 0 where set_43 is null;"
execute immediate :ls_sql using sqlca;//022305 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "ALTER TABLE icred_settings ADD set_44 integer NULL;"
execute immediate :ls_sql using sqlca;//022305 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "update icred_settings set set_44 = 0 where set_44 is null;"
execute immediate :ls_sql using sqlca;//022305 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "ALTER TABLE icred_settings ADD set_45 integer NULL;"
execute immediate :ls_sql using sqlca;//022305 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "update icred_settings set set_45 = 0 where set_45 is null;"
execute immediate :ls_sql using sqlca;//022305 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "ALTER TABLE icred_settings ADD set_46 integer NULL;"
execute immediate :ls_sql using sqlca;//022305 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "update icred_settings set set_46 = 0 where set_46 is null;"
execute immediate :ls_sql using sqlca;//022305 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "ALTER TABLE icred_settings ADD set_47 integer NULL;"
execute immediate :ls_sql using sqlca;//022305 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "update icred_settings set set_47 = 0 where set_47 is null;"
execute immediate :ls_sql using sqlca;//022305 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "ALTER TABLE icred_settings ADD set_48 integer NULL;"
execute immediate :ls_sql using sqlca;//022305 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "update icred_settings set set_48 = 0 where set_48 is null;"
execute immediate :ls_sql using sqlca;//022305 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "ALTER TABLE icred_settings ADD set_49 integer NULL;"
execute immediate :ls_sql using sqlca;//022305 maha
commit using sqlca;
st_sql.text  = ls_sql
ls_sql = "update icred_settings set set_49 = 0 where set_49 is null;"
execute immediate :ls_sql using sqlca;//022305 maha
commit using sqlca;
ls_sql = "ALTER TABLE icred_settings ADD set_50 integer NULL;"
execute immediate :ls_sql using sqlca;//022305 maha
commit using sqlca;
ls_sql = "update icred_settings set set_50 = 0 where set_50 is null;"
execute immediate :ls_sql using sqlca; //022305 maha
commit using sqlca;


//new group practice
ls_sql = "Create table question_lookup ( quest_id numeric (10,0) not null, quest_type numeric (10,0) null, short_quest varchar(40) null, full_quest long varchar null, primary key (quest_id));"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//013105 maha 
commit using sqlca;
ls_sql = "create table quest_temp (temp_id numeric (10,0) not null, temp_type numeric (10,0) null, temp_name varchar (25) null, primary key (temp_id));"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//013105 maha 
commit using sqlca;
ls_sql = "create table quest_temp_items (qt_id numeric (10,0) not null, temp_id numeric (10,0) not null, quest_id numeric (10,0) not null, sort_order integer null, primary key (qt_id));"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//013105 maha 
commit using sqlca;
ls_sql = "CREATE TABLE gp_other_ids (	rec_id numeric (16, 0) null,	prac_id decimal(16, 0) null,	id_type decimal(16, 0) null,	id_number char(35) null,	exp_date datetime null,	cust_1 char(30) null,	cust_2 char(30) null,	cust_3 char(30) null,	cust_d4 timestamp null,	cust_d5 timestamp null, primary key(rec_id));"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//013105 maha 
commit using sqlca;
ls_sql = "CREATE TABLE gp_language (	rec_id numeric (16, 0) not null,	prac_id decimal(16, 0) not null,	foreign_language decimal(16, 0) null,	speak integer null,	reads integer null,	writes integer null,	sign integer null,	cust_1 char(30) null,	cust_2 char(30) null,	cust_3 char(30) null,	cust_d4 timestamp null,	cust_d5 timestamp null, primary key(rec_id)) ;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//013105 maha 
commit using sqlca;
ls_sql = "create table gp_questions (rec_id numeric (10,0) not null, prac_id numeric(10,0) not null, question_id numeric(10,0) null, answer_code numeric(10,0) null, primary key(rec_id));"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//013105 maha 
commit using sqlca;
// mskinner 1 march 2005 -- begin
// insert the tables and codes needed for npdb and qa profile
n_cst_npdb inv_npdb 
inv_npdb = create n_cst_npdb 
inv_npdb.of_create_database()
destroy inv_npdb
// mskinner 1 march 2005 -- end

ls_sql = "ALTER TABLE app_field_prop ADD record_num_addr integer NULL;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030905 maha 
commit using sqlca;
ls_sql = "ALTER TABLE app_field_prop ADD query_field_addr varchar(50) NULL;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030905 maha 
commit using sqlca;
ls_sql = "ALTER TABLE app_field_prop ADD query_operator_addr char(10) NULL;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030905 maha 
commit using sqlca;
ls_sql = "ALTER TABLE app_field_prop ADD query_value_addr varchar(50) NULL;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030905 maha 
commit using sqlca;
ls_sql = "ALTER TABLE app_field_prop ADD billing_link_addr integer NULL;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030905 maha 
commit using sqlca;
ls_sql = "ALTER TABLE app_field_prop ADD years_query_addr integer NULL;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030905 maha 
commit using sqlca;

ls_sql = "Alter TABLE gp_language add gp_id decimal(16, 0) null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//013105 maha 
commit using sqlca;
ls_sql = "Alter TABLE gp_other_ids add gp_id decimal(16, 0) null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//013105 maha 
commit using sqlca;
ls_sql = "Alter TABLE gp_questions add gp_id decimal(16, 0) null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//013105 maha 
commit using sqlca;

//fields for the web
ls_sql = "ALTER TABLE icred_settings ADD w1_set integer NULL;"
execute immediate :ls_sql using sqlca;//032905 maha
commit using sqlca;
ls_sql = "ALTER TABLE icred_settings ADD w2_set integer NULL;"
execute immediate :ls_sql using sqlca;//032905 maha
commit using sqlca;
ls_sql = "ALTER TABLE icred_settings ADD w3_set integer NULL;"
execute immediate :ls_sql using sqlca;//032905 maha
commit using sqlca;
ls_sql = "ALTER TABLE icred_settings ADD w4_set integer NULL;"
execute immediate :ls_sql using sqlca;//032905 maha
commit using sqlca;
ls_sql = "ALTER TABLE icred_settings ADD w5_set integer NULL;"
execute immediate :ls_sql using sqlca;//032905 maha
commit using sqlca;
ls_sql = "ALTER TABLE icred_settings ADD w6_set integer NULL;"
execute immediate :ls_sql using sqlca;//032905 maha
commit using sqlca;
ls_sql = "ALTER TABLE icred_settings ADD w7_set integer NULL;"
execute immediate :ls_sql using sqlca;//032905 maha
commit using sqlca;
ls_sql = "ALTER TABLE icred_settings ADD w8_set integer NULL;"
execute immediate :ls_sql using sqlca;//032905 maha
commit using sqlca;
ls_sql = "ALTER TABLE icred_settings ADD w9_set integer NULL;"
execute immediate :ls_sql using sqlca;//032905 maha
commit using sqlca;
ls_sql = "ALTER TABLE icred_settings ADD w10_set integer NULL;"
execute immediate :ls_sql using sqlca;//032905 maha
commit using sqlca;
ls_sql = "ALTER TABLE icred_settings ADD w11_set integer NULL;"
execute immediate :ls_sql using sqlca;//032905 maha
commit using sqlca;
ls_sql = "ALTER TABLE icred_settings ADD w12_set integer NULL;"
execute immediate :ls_sql using sqlca;//032905 maha
commit using sqlca;
ls_sql = "ALTER TABLE icred_settings ADD w13_set integer NULL;"
execute immediate :ls_sql using sqlca;//032905 maha
commit using sqlca;
ls_sql = "ALTER TABLE icred_settings ADD w14_set integer NULL;"
execute immediate :ls_sql using sqlca;//032905 maha
commit using sqlca;
ls_sql = "ALTER TABLE icred_settings ADD w15_set integer NULL;"
execute immediate :ls_sql using sqlca;//032905 maha
commit using sqlca;
ls_sql = "ALTER TABLE icred_settings ADD w16_set integer NULL;"
execute immediate :ls_sql using sqlca;//032905 maha
commit using sqlca;
ls_sql = "ALTER TABLE icred_settings ADD w17_set integer NULL;"
execute immediate :ls_sql using sqlca;//032905 maha
commit using sqlca;
ls_sql = "ALTER TABLE icred_settings ADD w18_set integer NULL;"
execute immediate :ls_sql using sqlca;//032905 maha
commit using sqlca;
ls_sql = "ALTER TABLE icred_settings ADD w19_set integer NULL;"
execute immediate :ls_sql using sqlca;//032905 maha
commit using sqlca;
ls_sql = "ALTER TABLE icred_settings ADD w20_set integer NULL;"
execute immediate :ls_sql using sqlca;//032905 maha
commit using sqlca;




ls_sql = "alter table ids add citrix_npdb_path varchar(100) null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//042705 maha 
commit using sqlca;
ls_sql = "update ids set citrix_npdb_path = '" + gs_dir_path + "IntelliCred\' where citrix_npdb_path is null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//042705 maha 
commit using sqlca;

ls_sql = "update sys_fields set field_type = 'D' where field_id = 9810;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//051105 maha data type correction
commit using sqlca;

ls_sql = "ALTER TABLE  pd_affil_stat ADD in_good_standing integer null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//051805 maha for web 
commit using sqlca;

ls_sql = "ALTER TABLE  export_fields ADD billing_link integer null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app080205
commit using sqlca;
ls_sql = "UPDATE  export_fields SET billing_link = 0 where billing_link is null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app080205
commit using sqlca;

ls_sql = "ALTER TABLE  question_lookup modify full_quest long varchar null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app081605
commit using sqlca;

ls_sql = "ALTER TABLE ids ADD contract_path varchar(255) null ;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//083005 maha
commit using sqlca;

ls_sql = "ALTER TABLE export_fields ADD active_yesno integer null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//083105 maha
commit using sqlca;

	
ls_sql = "ALTER TABLE icred_settings ADD set_qa integer NULL;"
execute immediate :ls_sql using sqlca;//maha app100405
commit using sqlca;
ls_sql = "update icred_settings set set_qa = 0 where set_qa is null;"
execute immediate :ls_sql using sqlca; //maha app100405
commit using sqlca;
ls_sql = "ALTER TABLE icred_settings ADD set_site integer NULL;"
execute immediate :ls_sql using sqlca;//maha app100405
commit using sqlca;
ls_sql = "update icred_settings set set_site = 0 where set_site is null;"
execute immediate :ls_sql using sqlca; //maha app100405
commit using sqlca;
ls_sql = "ALTER TABLE icred_settings ADD set_cont integer NULL;"
execute immediate :ls_sql using sqlca;//maha app100405
commit using sqlca;
ls_sql = "update icred_settings set set_cont = 0 where set_cont is null;"
execute immediate :ls_sql using sqlca; //maha app100405
commit using sqlca;
ls_sql = "ALTER TABLE icred_settings ADD set_web integer NULL;"
execute immediate :ls_sql using sqlca;//maha app100405
commit using sqlca;
ls_sql = "update icred_settings set set_web = 0 where set_web is null;"
execute immediate :ls_sql using sqlca; //maha app100405
commit using sqlca;

ls_sql = "insert into profile_reports values(32,'Attest Questions(New)','','d_prf_att_quest_new',32,'PF' );"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app101405
commit using sqlca;

// mskinner 02 Aug 2005 - begin
// contract mod database
//Start Code Change ---- 10.31.2006 #1 maha: only run if have contracts module or product.
integer cp,cm
select set_9,set_cont into :cp,:cm from icred_settings;  
if cp = 4 or cm = 1 then
	f_create_ctx_database()
end if
//End Code Change---10.31.2006
// mskinner 02 Aug 2005 - end

of_custom_fields() //maha 080905
of_date_fields() //maha 081105
of_add_dv_fields(200000,200517) //maha 090605
of_attest_quest()
of_security_addv5()


ls_sql = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (11026, 	'OIG Sanctions',	'None',	'No Match found', 'S');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//081305 maha 
commit using sqlca;

ls_sql = "alter table export_header add prompt_type integer null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app102705
commit using sqlca;

ls_sql = "alter table export_fields add export_type integer null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app102705
commit using sqlca;


//mods to intellireport
ls_sql = "ALTER TABLE conv_view ADD detail_height integer NULL;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app102705
commit using sqlca;
ls_sql = "ALTER TABLE conv_view ADD report_type varchar(10) NULL;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app102705
commit using sqlca;
ls_sql = "ALTER TABLE conv_view ADD profile_title varchar(100) NULL;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app102705
commit using sqlca;
ls_sql = "ALTER TABLE conv_view ADD detail_height numeric(10,0) NULL;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app102705
commit using sqlca;
ls_sql = "ALTER TABLE conv_view ADD header_height numeric(10,0) NULL;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app102705
commit using sqlca;
ls_sql = "ALTER TABLE conv_view ADD footer_height numeric(10,0) NULL;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app102705
commit using sqlca;
ls_sql = "ALTER TABLE conv_view ADD summary_height numeric(10,0) NULL;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app102705
commit using sqlca;
ls_sql = "ALTER TABLE conv_view_fields ADD field_y integer NULL;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app102705
commit using sqlca;
ls_sql = "ALTER TABLE conv_view_fields ADD label_x integer NULL;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app102705
commit using sqlca;
ls_sql = "ALTER TABLE conv_view_fields ADD label_y integer NULL;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app102705
commit using sqlca;
ls_sql = "ALTER TABLE conv_view_fields ADD label_width char(6) NULL;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app102705
commit using sqlca;
ls_sql = "ALTER TABLE conv_view_fields ADD field_height integer NULL;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app102705
commit using sqlca;
ls_sql = "ALTER TABLE conv_view_fields ADD label_height integer NULL;ALTER TABLE conv_view_table ADD table_name char(100) NULL;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app102705
commit using sqlca;
ls_sql = "ALTER TABLE conv_view_table ADD table_name varchar(100) NULL;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app102705
commit using sqlca;
ls_sql = "UPDATE conv_view_table SET table_name = (Select distinct dbo.sysobjects.name from dbo.sysobjects where dbo.sysobjects.id = conv_view_table.cust_table_name);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app102705
commit using sqlca;

//Start Code Change ---- 11.02.2005 #10 maha
//additional code should be added to the following function
//of_ver_55_updates()
update icred_settings	set set_18 = 50; //version setting
commit using sqlca;
of_ver55_updates()  //Start Code Change ---- 12.18.2006 #V7 maha
//End Code Change---11.02.2005 

Return 1
end function

public function integer of_ver55_updates ();//Start Code Change ---- 11.02.2005 #2 maha

//new function maha 11.02.2005
string ls_sql

cb_update.text = "Ver 5.1 Updates"
st_update.text  = "Ver 5.1 Updates"
// start code change --- 11.07.2005 MSKINNER

ls_sql = "ALTER TABLE sys_letters ADD qa_letter integer NULL ;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app102705
commit using sqlca;
ls_sql = "ALTER TABLE sys_letters ADD qa_letter_level   integer NULL ;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app102705
// end  code change --- 11.07.2005 MSKINNER
commit using sqlca;
ls_sql = "ALTER TABLE facility    ADD cc_cardholder     varchar(40)  NULL ;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app102705
commit using sqlca;
ls_sql = "ALTER TABLE facility    ADD cc_billing_addr1  varchar(60)  NULL ;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app102705
commit using sqlca;
ls_sql = "ALTER TABLE facility    ADD cc_billing_addr2  varchar(60)  NULL ;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app102705
commit using sqlca;
ls_sql = "ALTER TABLE facility    ADD cc_billing_city   varchar(40)  NULL ;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app102705
commit using sqlca;
ls_sql = "ALTER TABLE facility    ADD cc_billing_state  varchar(2)   NULL ;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app102705
commit using sqlca;
ls_sql = "ALTER TABLE facility    ADD cc_zip5           varchar(5)   NULL ;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app102705
commit using sqlca;

ls_sql = "alter table export_header add prompt_type1 char(1) null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app110205
commit using sqlca;
ls_sql = "alter table export_header add prompt_type2 char(1) null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app110205
commit using sqlca;
ls_sql = "alter table export_header add prompt_type3 char(1) null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app110205
commit using sqlca;


//Start Code Change ---- 11.03.2005 #20 maha
ls_sql = "alter table pd_basic add date_last_mod timestamp null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app110205
commit using sqlca;
ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len) values (25,200610,383,'mm/dd/yyyy','date_last_mod', 'Last Modified Date',10,'D' ,10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//091305 maha 
commit using sqlca;

ls_sql = "alter table pd_affil_stat add admit_priv numeric(10,0) null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app110205
commit using sqlca;

ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len) values (43,200611,51,'','admit_priv', 'Admitting Privileges',10,'N' ,10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//091305 maha 
commit using sqlca;  //this field intended to be invisible

ls_sql = "alter table pd_basic add npi_number varchar(25) null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha app110705
commit using sqlca;

ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len) values (25,200612,96,'','npi_number', 'NPI Number',25,'C' ,10);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110705 maha 
commit using sqlca;

ls_sql = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (21612, 1,1,200612,303,'NPI Number','N','N','N','N',1880,152,500,64,'L','E',1880,84,500,'Y');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//110705 maha 
commit using sqlca;
of_add_dv_fields(200612,200612)

ls_sql = "Alter table icred_settings add web_crawl integer null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//111405 maha 
commit using sqlca;

/* 10/09/2006 Modified by NA, Add by Allen.
ls_sql = "Create table security_login_tracking  ( user_id varchar(25) null, user_password varchar(25) null , log_date timestamp null , pass_fail char(10) null, primary key ( user_id, log_date) );"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//112105 maha 
commit using sqlca;
*/
of_execute ("Create table security_login_tracking  ( user_id varchar(25) null, user_password varchar(25) null , log_date timestamp null , pass_fail char(10) null, primary key ( user_id, log_date) );")

ls_sql = "Alter table security_users modify user_password char(25) null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//112105 maha 
commit using sqlca;

//End Code Change---11.03.2005

//Start Code Change ---- 12.05.2005 #159 maha
ls_sql = "ALTER TABLE app_sect_temp_field_prop ADD record_num_addr integer NULL;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//120505 maha 
commit using sqlca;
ls_sql = "ALTER TABLE app_sect_temp_field_prop ADD query_field_addr varchar(50) NULL;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//120505 maha 
commit using sqlca;
ls_sql = "ALTER TABLE app_sect_temp_field_prop ADD query_operator_addr char(10) NULL;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//120505 maha 
commit using sqlca;
ls_sql = "ALTER TABLE app_sect_temp_field_prop ADD query_value_addr varchar(50) NULL;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//120505 maha 
commit using sqlca;
ls_sql = "ALTER TABLE app_sect_temp_field_prop ADD billing_link_addr integer NULL;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//120505 maha 
commit using sqlca;
ls_sql = "ALTER TABLE app_sect_temp_field_prop ADD years_query_addr integer NULL;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//120505 maha 
commit using sqlca;

ls_sql = "Alter table export_header add strip_char char(8) null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//120705 maha 
commit using sqlca;
ls_sql = "Alter table export_header add multi_row_table integer null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//120705 maha 
commit using sqlca;
ls_sql = "Alter table export_fields add substring_start integer null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//120705 maha 
commit using sqlca;
ls_sql = "Alter table export_header add custom_save_name integer null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//121205 maha 
commit using sqlca;
//End Code Change---12.05.2005 

//ls_sql = ""
//st_sql.text  = ls_sql
//execute immediate :ls_sql using sqlca;//maha app102705
//commit using sqlca;
// start code change --- 11.01.2005 MSKINNER
f_update_sys_letters()

//web crawler
cb_update.text = "Web Crawler data"
st_update.text  = "Web Crawler data"
f_wc_create_database( )

// end code change --- 11.01.2005 MSKINNER
//Start Code Change ---- 01.09.2006 #178 maha
//web role fields
ls_sql = "Alter table security_users add audit_type int null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//010906 maha 
commit using sqlca;
ls_sql = "Alter table security_users add wv_role_id int null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//010906 maha 
commit using sqlca;
//group practice data
ls_sql = "create table gp_plans (rec_id numeric(10,0) not null, gp_id numeric(10,0) not null, plan_id numeric(10,0) null, active_status int null, start_date datetime null, end_date datetime null, prac_id numeric(10,0) null, primary key(rec_id));"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//010906 maha 
commit using sqlca;
ls_sql = "Alter table gp_questions add prac_id numeric(10,0) null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//010906 maha 
commit using sqlca;
ls_sql = "Alter table gp_partner_covering add gp_id numeric(10,0) null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//010906 maha 
commit using sqlca;
ls_sql = "Alter table gp_other_ids add prac_id numeric(10,0) null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//010906 maha 
commit using sqlca;
ls_sql = "Alter table gp_insurance add gp_id numeric(10,0) null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//010906 maha 
commit using sqlca;
ls_sql = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (8000, 	'Partner Covering',	'PARTNER',	'Partner/Associate', 'S');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//010906 maha 
commit using sqlca;
ls_sql = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (8001, 	'Partner Covering',	'ASSOC',	'Associate', 'S');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//010906 maha 
commit using sqlca;
ls_sql = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (8002, 	'Partner Covering',	'COLL',	'Covering not partner', 'S');"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//010906 maha 
commit using sqlca;
//End Code Change---01.09.2005 
//Start Code Change ---- 01.20.2006 #206 maha
ls_sql = "Alter table ids add letter_save_path varchar(150) null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//012006 maha 
commit using sqlca;

//group practice sys and dv
ls_sql = "INSERT INTO sys_tables (table_id,table_name,table_name_allias,profile_dw_name,facility_specific,ver_ltr_sql,exp_ltr_sql,is_required) VALUES (	81,	'gp_questions',	'Group Questions',	NULL,	0,	NULL,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//021706 maha  
commit using sqlca;
ls_sql = "INSERT INTO sys_tables (table_id,table_name,table_name_allias,profile_dw_name,facility_specific,ver_ltr_sql,exp_ltr_sql,is_required) VALUES (	83,	'gp_other_ids',	'Group Other IDs',	NULL,	0,	NULL,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//021706 maha   
commit using sqlca;
ls_sql = "INSERT INTO sys_tables (table_id,table_name,table_name_allias,profile_dw_name,facility_specific,ver_ltr_sql,exp_ltr_sql,is_required) VALUES (	80,	'gp_language',	'Group Languages',	NULL,	0,	NULL,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//021706 maha   
commit using sqlca;
ls_sql = "INSERT INTO sys_tables (table_id,table_name,table_name_allias,profile_dw_name,facility_specific,ver_ltr_sql,exp_ltr_sql,is_required) VALUES (	82,	'gp_partner_covering',	'Group Partners/Covering',	NULL,	0,	NULL,NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//021706 maha  
commit using sqlca;
ls_sql = "INSERT INTO sys_tables (table_id,table_name,table_name_allias,profile_dw_name,facility_specific,ver_ltr_sql,exp_ltr_sql,is_required) VALUES (	84,	'gp_insurance',	'Group Insurance',	NULL,	0,	NULL,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//021706 maha  
commit using sqlca;

ls_sql = "Alter table sys_tables add screen_type char(1) null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//022106 maha 
commit using sqlca;

ls_sql = "update sys_tables set screen_type = 'S' where table_id < 80 or table_id > 89;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//022106 maha 
commit using sqlca;
ls_sql = "update sys_tables set screen_type  = 'G' where table_id >= 80 and table_id < 90;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//022106 maha 
commit using sqlca;

ls_sql = "INSERT INTO data_view_screen VALUES (	1,	80,	1,	'Group Languages',	'Y',	NULL,	NULL,	NULL,	NULL,	80,	NULL,	NULL,	NULL,	'Group Languages',null);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca; //maha 022106
commit using sqlca;
ls_sql = "INSERT INTO data_view_screen VALUES (	1,	81,	3,	'Group Questions',	'Y',	NULL,	NULL,	NULL,	NULL,	81,	NULL,	NULL,	NULL,	'Group Questions',null);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca; //maha 022106
commit using sqlca;
ls_sql = "INSERT INTO data_view_screen VALUES (	1,	82,	5,	'Group Partners/Covering',	'Y',	NULL,	NULL,	NULL,	NULL,	82,	NULL,	NULL,	NULL,	'Group Covering/Partners',null);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca; //maha 022106
commit using sqlca;
ls_sql = "INSERT INTO data_view_screen VALUES (	1,	83,	4,	'Group IDs',	'Y',	NULL,	NULL,	NULL,	NULL,	83,	NULL,	NULL,	NULL,	'Group IDs',null);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca; //maha 022106
commit using sqlca;
ls_sql = "INSERT INTO data_view_screen VALUES (	1,	84,	2,	'Group Insurance',	'Y',	NULL,	NULL,	NULL,	NULL,	84,	NULL,	NULL,	NULL,	'Group Insurance',null);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca; //maha 022106
commit using sqlca;
//group languages
ls_sql = "INSERT INTO sys_fields VALUES (	80,	188002,	5,	'gp_id',	'N',	12,	'Group id',	NULL,	NULL,	NULL,	NULL,NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	12,	NULL,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	80,	188004,	20,	'speak',	'N',	12,	'Speak',	NULL,	'C',	'Y',	'Yes/No',	'B',	NULL,NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	12,	NULL,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	80,	188006,	40,	'writes',	'N',	12,	'Writes',	NULL,	'C',	'Y',	'Yes/No',	'B',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	12,	NULL,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	80,	188010,	80,	'cust_3',	'C',	25,	'Cust 3',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	25,	NULL,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	80,	188012,	100,	'cust_d5',	'D',	8,	'Cust D5',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	8,	NULL,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	80,	188001,	0,	'rec_id',	'N',	12,	'Rec id',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	12,	NULL,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	80,	188003,	10,	'foreign_language',	'N',	12,	'Language',	NULL,	'C',	'Y',	'Foreign Languages',	'C',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	12,	NULL,NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	80,	188005,	30,	'reads',	'N',	12,	'Reads',	NULL,	'C',	'Y',	'Yes/No',	'B',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	12,	NULL,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	80,	188007,	50,	'sign',	'N',	12,	'Sign',	NULL,	'C',	'Y',	'Yes/No',	'B',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	12,	NULL,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	80,	188009,	70,	'cust_2',	'C',	25,	'Cust 2',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	25,	NULL,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	80,	188011,	90,	'cust_d4',	'D',	8,	'Cust D4',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	8,	NULL,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	80,	188013,	0,	'prac_id',	'C',	20,	'Group id',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	20,	NULL,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
//group ids
ls_sql = "INSERT INTO sys_fields VALUES (	83,	188014,	10,	'id_type',	'N',	6,	'ID Type',	'A',	'C',	'Y',	'Other Document Type',	'Code',	'Y',	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	'Y',	300,	6,	0,	NULL,	3);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	83,	188015,	20,	'id_number',	'C',	35,	'ID Number',	'A',	NULL,	'N',	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	'Y',	100,	35,	0,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	83,	188016,	30,	'exp_date',	'D',10,	'Expiration Date',	'A',	NULL,	'N',	NULL,	NULL,	'Y',	'mm/dd/yyyy',	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	100,	10,	0,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	83,	188017,	40,	'cust_1',	'C',	30,	'Custom Field 1',	'A',	NULL,	'N',	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	100,	30,	0,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	83,	188018,	50,	'cust_2',	'C',	30,	'Custom Field 2',	'A',	NULL,	'N',	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	100,	30,	0,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	83,	188019,	60,	'cust_3',	'C',	30,	'Custom Field 3',	'A',	NULL,	'N',	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	100,	30,	0,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	83,	188020,	70,	'cust_d4',	'D',	30,	'Custom Date 4',	'A',	NULL,	'N',	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	100,	30,	0,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	83,	188021,	80,	'cust_d5',	'D',	30,	'Custom Date 5',	'A',	NULL,	'N',	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	100,	30,	0,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	83,	188022,	0,	'prac_id',	'N',	8,	'prac_id',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	8,	0,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	83,	188023,	0,	'active_status',	'N',	NULL,	'Active Status',	NULL,	NULL,	'N',NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	1,	NULL,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	83,	188024,	0,	'rec_id',	'N',	8,	'Record ID',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	8,	0,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;

ls_sql = "INSERT INTO sys_fields VALUES (	81,	188062,	10,	'question_id',	'N',	50,	'Question',	'A',	'Q',	'Y',	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	'Y',	100,	6,	0,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	81,	188063,	20,	'answer_code',	'N',	30,	'Answer',	'A',	NULL,	'N',	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	'Y',	100,	25,	0,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	81,	188064,	0,	'gp_id',	'N',	16,	'gpid',	'A',	NULL,	'N',	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	100,	16,	0,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	81,	188065,	0,	'prac_id',	'N',	8,	'prac_id',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	8,	0,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	81,	188066,	0,	'rec_id',	'N',	8,	'Record ID',NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	8,	0,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	82,	188047,	10,	'last_name',	'C',	50,	'Last Name',	'A',	'',	'N',	'',	'',	'Y',	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	'Y',	100,	6,	0,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	82,	188048,	20,	'first_name',	'C',	30,	'First Name',	'A',	NULL,	'N',	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	'Y',	100,	25,	0,	NULL,NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	82,	188049,	50,	'specialty',	'N',	10,	'Specialty',	'A',	'C',	'Y',	'Practitioner Specialties',	'Code',	'Y',	'mm/dd/yyyy',	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	100,	10,	0,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	82,	188050,	60,	'provider_type',	'N',	10,	'Provider Type',	'A',	'C',	'Y',	'Provider Types',	'description',	'Y',	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	150,	10,	0,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	82,	188051,	70,	'covering',	'N',	1,	'Tail Coverage',	'A',	'C',	'Y',	'Yes/No',	'Code',	'Y',	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	100,	1,	0,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	82,	188052,	80,	'partner',	'N',	16,	'Partner',	'A',	'C','Y',	'Partner Covering','Code',	'Y',	Null,NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	100,	16,	0,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	82,	188053,	0,	'gp_id',	'N',	16,	'gpid',	'A',	NULL,	'N',	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	100,	16,	0,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	82,	188054,	100,	'title_code',	'N',	1,	'Title',	'A',	'C',	'Y',	'Title',	'Code',	'Y',	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	100,	1,	0,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	82,	188055,	140,	'cust_1',	'C',	30,	'Custom Field 1',	'A',	NULL,	'N',	NULL,	NULL,	'N',	NULL,	NULL,	NULL,	NULL,	'N',	NULL,	NULL,	NULL,100,	30,	0,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	82,	188056,	150,	'cust_2',	'C',	30,	'Custom Field 2',	'A',	NULL,	'N',	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	100,	30,	0,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	82,	188057,	160,	'cust_3',	'C',	30,	'Custom Field 3',	'A',	NULL,	'N',	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	100,	30,	0,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	82,	188058,	170,	'cust_d4',	'D',	30,	'Custom Field d4',	'A',	NULL,	'N',	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	100,	30,	0,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	82,	188059,	180,	'cust_d5',	'D',	30,	'Custom Field d5',	'A',	NULL,	'N',	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	100,	30,	0,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	82,	188060,	0,	'prac_id',	'N',	8,	'prac_id',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	8,	0,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	82,	188061,	0,	'rec_id',	'N',	8,	'Record ID',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	8,	0,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	82,	188067,	30,	'middle_name',	'C',	25,	'Middle Name',	'A',	NULL,	'N',	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	100,	10,	0,	NULL,	81);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	84,	188025,	10,	'carrier_code',	'N',	6,	'Carrier',	'A',	'A',	'Y',	'Insurance Companies',	'Entity_Name',	'Y',	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	'Y',	100,	6,	0,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	84,	188026,	20,	'policy_number',	'C',	25,	'Policy Number',	'A',	NULL,	'N',	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	'Y',	100,	25,	0,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	84,	188027,	30,	'coverage_from',	'D',	10,	'Coverage From',	'A',	NULL,	'N',	NULL,	NULL,	'Y',	'mm/dd/yyyy',	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	100,	10,	0,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	84,	188028,	40,	'coverage_to','D',	10,	'Coverage To',	'A',	NULL,	'N',	NULL,	NULL,	'Y',	'mm/dd/yyyy',	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	100,	10,	2,	'D',	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	84,	188029,	50,	'previous_expiration_date',	'D',	10,	'Previous Expiration Date',	'A',	NULL,	'N',	NULL,	NULL,	'Y',	'mm/dd/yyyy',	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	100,	10,	0,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	84,	188030,	60,	'claims_made_occurrence',	'N',	10,	'Claims Made Occurrence',	'A',	'C',	'Y',	'Coverage Type',	'description',	'Y',	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	150,	10,	0,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	84,	188031,	70,	'tail_coverage',	'I',	1,	'Tail Coverage',	'A',	'C',	'Y',	'Yes/No',	'Code',	'Y',	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	100,	1,	0,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	84,	188032,	80,	'coverage_limit_from','N',	16,	'Coverage Limit From',	'A',	NULL,	'N',	NULL,	NULL,	'Y',	'#,##0.00',	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	100,	16,	0,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	84,	188033,	90,	'coverage_limit_to',	'N',	16,	'Coverage Limit To',	'A',	NULL,	'N',	NULL,	NULL,	'Y',	'#,##0.00',	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	100,	16,	0,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	84,	188034,	100,	'state_funded_pool',	'I',	1,	'State Funded Pool',	'A',	'C',	'Y',	'Yes/No',	'Code',	'Y',	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	100,	1,	0,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	84,	188035,	110,	'state_coverage',	'I',	1,	'State Coverage',	'A',	'C',	'Y',	'Yes/No',	'Code',	'Y',	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	100,	1,	0,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	84,	188036,	115,	'denied_explain',	'C',	255,	'Denied Explanation',	'A',	NULL,	'N',	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	100,	255,	0,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	84,	188037,	130,	'exclusions',	'C',	75,	'Exclusions',	'A',	NULL,	'N',	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	'Y',	'None',	NULL,	NULL,	100,	75,	0,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	84,	188038,	140,	'cust_1',	'C',	30,	'Custom Field 1',	'A',	NULL,	'N',	NULL,	NULL,	'N',	NULL,	NULL,	NULL,	NULL,	'N',	NULL,	NULL,	NULL,	100,	30,	0,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	84,	188039,	150,	'cust_2',	'C',	30,	'Custom Field 2',	'A',	NULL,	'N',	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	100,	30,	0,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	84,	188040,	160,	'cust_3',	'C',	30,	'Custom Field 3',	'A',	NULL,	'N',	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	100,	30,	0,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	84,	188041,	170,	'cust_d4',	'D',	30,	'Custom Field 4',	'A',	NULL,	'N',	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	100,	30,	0,	NULL, NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	84,	188042,	180,	'cust_d5',	'D',	30,	'Custom Field 5',	'A',	NULL,	'N',	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	NULL,	'Y',	NULL,	NULL,	NULL,	100,	30,	0,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	84,	188043,	0,	'prac_id',	'N',	8,	'prac_id',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	8,	0,	NULL,NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	84,	188044,	0,	'rec_id',	'N',	8,	'Record ID',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	8,	0,	NULL,	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
ls_sql = "INSERT INTO sys_fields VALUES (	84,	188045,	400,	'active_status',	'I',	6,	'Status',	NULL,	NULL,	'N',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	'1',	NULL,	NULL,	NULL,	6,	0,	'N',	NULL);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;
//ls_sql = "INSERT INTO sys_fields VALUES (	84,	188046,	410,	'explain_cov_gap',	'C',	255,	'explain gap',	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	NULL,	20,	NULL,	NULL,	NULL);"
//st_sql.text  = ls_sql
//execute immediate :ls_sql using sqlca;//maha 022106
//commit using sqlca;

ls_sql = "update data_view_screen set multi_record = 'H' where table_id > 79 and table_id < 90;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 030206
commit using sqlca;

ls_sql = "CREATE TABLE gp_insurance (	rec_id decimal(16, 0) null,	prac_id decimal(16, 0) null,	carrier_code decimal(16, 0) null,	policy_number char(25) null,	coverage_from datetime null,	coverage_to datetime null,	previous_expiration_date datetime null,	tail_coverage float null,	coverage_limit_from decimal(16, 0) null,	coverage_limit_to decimal(16, 0) null,	state_funded_pool float null,	state_coverage float null,	exclusions char(75) null,	cust_1 char(150) null,	cust_2 char(150) null,	cust_3 char(150) null,	cust_d4 datetime null,	cust_d5 datetime null,	claims_made_occurrence decimal(16, 0) null,	denied_explain char(32766) null,	active_status float null,	gp_id decimal(16, 0) null);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;

ls_sql = "CREATE TABLE gp_partner_covering (	rec_id decimal(16, 0) null,	prac_id decimal(16, 0) null,	last_name char(50) null,	first_name char(30) null,	specialty decimal(16, 0) null,	provider_type decimal(16, 0) null,	covering decimal(16, 0) null,	partner decimal(16, 0) null,	middle_name char(25) null,	title_code decimal(16, 0) null,	cust_1 char(150) null,	cust_2 char(150) null,	cust_3 char(150) null,	cust_d4 datetime null,	cust_d5 datetime null,	gp_id decimal(16, 0) null);"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 022106
commit using sqlca;

ls_sql = "create table app_hdr_audit (rec_id numeric(10,0) not null, app_id numeric(10,0) null, change_date datetime null, user_id varchar(20) null, primary key(rec_id));"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//022106 maha 
commit using sqlca;

ls_sql = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (	24490,	'Address Type',	'E',	'Exp Cred Letter', 'S');"
execute immediate :ls_sql using sqlca;//022803 maha 
commit using sqlca;

ls_sql = "INSERT INTO code_lookup (lookup_code, lookup_name, code, description, type ) VALUES (	24495,	'Template Type',	'ATTEST',	'Attestation Template', '');"
execute immediate :ls_sql using sqlca;//030306 maha 
commit using sqlca;

ls_sql = "Alter table ids add help_path varchar(255) null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030306 maha 
commit using sqlca;
ls_sql = "Update ids set help_path = 'Coming Soon' where help_path is null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//030306 maha 
commit using sqlca;

//repete from unplanned prop of table.
ls_sql = "create table npdb_tracker (export_id numeric (8,0) not null,c_date timestamp null,s_date timestamp null,r_date timestamp null,user_id char(12) not null,file_name varchar(25) null,facility_id integer null,rec_cnt integer null,prac_id numeric(10,0) null,cust_1 varchar(30) null,cust_2 varchar(30) null,cust_3 varchar(30) null,doc_id varchar(20) NULL, PRIMARY KEY (export_id));"
execute immediate :ls_sql using sqlca;
commit using sqlca;

of_group_dv_fields()

ls_sql = "Update icred_settings set set_43 = 210 where set_43 = 0;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 032806
commit using sqlca;
//Start Code Change ---- 03.29.2006 #365 maha
ls_sql = "update sys_tables set facility_specific = 1 where table_id = 43;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 032906
commit using sqlca;
ls_sql = "update sys_tables set facility_specific = 1 where table_id = 44;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 032906
commit using sqlca;
ls_sql = "update sys_tables set facility_specific = 1 where table_id = 45;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 032906
commit using sqlca;
ls_sql = "update sys_tables set facility_specific = 1 where table_id = 47;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 032906
commit using sqlca;
ls_sql = "update sys_tables set facility_specific = 1 where table_id = 49;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 032906
commit using sqlca;
ls_sql = "update sys_tables set facility_specific = 1 where table_id = 32;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 032906
commit using sqlca;
ls_sql = "update sys_tables set facility_specific = 1 where table_id = 16;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 032906
commit using sqlca;
ls_sql = "update sys_tables set facility_specific = 0 where table_id is null;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;//maha 032906
commit using sqlca;
//End Code Change---03.29.2006

of_question_import(1)//Start Code Change ---- 05.09.2006 #434 maha

//Start Code Change ---- 05.018.2006 #434 maha
ls_sql = "update sys_fields set field_type = 'C'  where field_id = 200612;"
st_sql.text  = ls_sql
execute immediate :ls_sql using sqlca;
commit using sqlca;
//End Code Change---03.29.2006

//ls_sql = "Insert into sys_fields (table_id,field_id, field_order, field_mask, field_name,  field_name_allias,field_len, field_type, app_fill_field_len ) values (65,200600,0,null,'rec_id','Rec Id',30,'N',25);"
//st_sql.text  = ls_sql
//execute immediate :ls_sql using sqlca;//maha 022106
//commit using sqlca;
//End Code Change---01.20.2005 
update icred_settings	set set_18 = 55; //version setting
commit using sqlca;
of_ver60_updates()  //Start Code Change ---- 12.18.2006 #V7 maha
//End Code Change---11.02.2005 
return 1
end function

public function integer of_ver60_updates ();//Alfee 01.30.2008
n_cst_update_asa  lnv_asa
n_cst_update_sql  lnv_sql
n_cst_update_data lnv_data
n_cst_update_role_right lnvo_role_right

lnv_data = Create n_cst_update_data
lnvo_role_right = Create n_cst_update_role_right

//1.Update SQL for 6.0
IF gs_dbtype = 'ASA' THEN
	lnv_asa = Create n_cst_update_asa
	lnv_asa.of_ver60_updates()
ELSE
	lnv_sql = Create n_cst_update_sql
	lnv_sql.of_ver60_updates()
END IF
lnv_data.of_ver60_updates()
	
//4.Update role rights for 6.0
lnvo_role_right.of_update_version_60()

Destroy lnv_asa
Destroy lnv_sql
Destroy lnv_data
Destroy lnvo_role_right

//Call update for ver 7.0
of_ver70_updates() 

Return 1

end function

public function integer of_ver70_updates ();//Alfee 01.30.2008
n_cst_update_asa  lnv_asa
n_cst_update_sql  lnv_sql
n_cst_update_data lnv_data
n_cst_update_role_right lnvo_role_right
n_cst_update_support_doc lnvo_support
n_cst_update_contact lnvo_contact

lnv_data = Create n_cst_update_data
lnvo_role_right = Create n_cst_update_role_right
lnvo_support = Create n_cst_update_support_doc
lnvo_contact = Create n_cst_update_contact

//1.Update sql for 7.0
IF gs_dbtype = 'ASA' THEN
	lnv_asa = Create n_cst_update_asa
	lnv_asa.of_ver70_updates()
ELSE
	lnv_sql = Create n_cst_update_sql
	lnv_sql.of_ver70_updates()
END IF
lnv_data.of_ver70_updates()
	
//2.Update support doc for 7.0
lnvo_support.of_update_support_doc()
	
//3.Update contact for 7.0
lnvo_contact.of_update_contact()
			
//4.Update role rights for 7.0
lnvo_role_right.of_update_version_70()

Destroy lnv_asa
Destroy lnv_sql
Destroy lnv_data
Destroy lnvo_role_right
Destroy lnvo_support
Destroy lnvo_contact

//Call update for ver 80
of_ver80_updates()

Return 1

end function

public function integer of_ver80_updates ();//Alfee 01.30.2008
n_cst_update_asa  lnv_asa
n_cst_update_sql  lnv_sql
n_cst_update_data lnv_data
n_cst_update_role_right lnvo_role_right
//n_cst_update_emailsend	lnvo_EMailSend //Jervis 11-12-2008

lnv_data = Create n_cst_update_data
lnvo_role_right = Create n_cst_update_role_right
//lnvo_EMailSend = Create n_cst_update_emailsend //Jervis 11-12-2008

//1.Update sql for 8.0
IF gs_dbtype = 'ASA' THEN
	lnv_asa = Create n_cst_update_asa
	lnv_asa.of_ver80_updates()
ELSE
	lnv_sql = Create n_cst_update_sql	
	lnv_sql.of_ver80_updates()
END IF
lnv_data.of_ver80_updates()

//4.Update role rights for 8.0
lnvo_role_right.of_update_version_80( ) 


//4.1 Update email templates for 8.0
//lnvo_EMailSend.of_upgrade_email()  //Jervis 11-12-2008

Destroy lnv_asa
Destroy lnv_sql
Destroy lnv_data
Destroy lnvo_role_right
//Destroy lnvo_EMailSend	//Jervis 11-12-2008

//Call update for ver91 - Alfee 07.18.2008
of_ver91_updates() //change from of_ver85_updates() - alfee 12.30.2008

Return 1
end function

public function integer of_ver91_updates ();//Added by Alfee on 07.11.2008
//Change of_ver85_updates() to of_ver91_updates()

n_cst_update_asa  lnv_asa
n_cst_update_sql  lnv_sql
n_cst_update_data lnv_data
n_cst_update_emailsend	lnvo_EMailSend //08.20.2008

n_cst_update_role_right lnvo_role_right //Add by Ken.Guo 2008-11-20
lnvo_role_right = Create n_cst_update_role_right

//1.Update sql for 9.1; changed v85 to v91 - alfee 12.30.2008
IF gs_dbtype = 'ASA' THEN
	lnv_asa = Create n_cst_update_asa
	lnv_asa.of_ver91_updates() 
ELSE
	lnv_sql = Create n_cst_update_sql	
	lnv_sql.of_ver91_updates() 
END IF
lnv_data = Create n_cst_update_data 
lnv_data.of_ver91_updates() 

//lnvo_role_right.of_update_version_85() //Added By Ken.Guo 2008-11-20
lnvo_role_right.of_update_version_91() //Changed v85 to v91 - alfee 12.30.2008

//4.1 Update alarm notification users for 9.1 - 08.20.2008
lnvo_EMailSend = Create n_cst_update_emailsend
lnvo_EMailSend.of_update_almusers()

Destroy lnv_asa
Destroy lnv_sql
Destroy lnv_data
Destroy lnvo_EMailSend //08.20.2008
Destroy lnvo_role_right

//Call update for ver92 - Alfee 03.03.2009
of_ver92_updates()

Return 1
end function

public function integer of_ver_91_updates_bk ();//Start Code Change ----11.06.2008 #V85 maha

n_cst_update_asa  lnv_asa
n_cst_update_sql  lnv_sql
n_cst_update_data lnv_data
n_cst_update_emailsend	lnvo_EMailSend //08.20.2008

//1.Update sql for 9.1
IF gs_dbtype = 'ASA' THEN
	lnv_asa = Create n_cst_update_asa
//	lnv_asa.of_ver91_updates()
ELSE
	lnv_sql = Create n_cst_update_sql	
//	lnv_sql.of_ver91_updates()
END IF
lnv_data = Create n_cst_update_data 
//lnv_data.of_ver91_updates()

//4.1 Update alarm notification users for 9.1 - 08.20.2008
lnvo_EMailSend = Create n_cst_update_emailsend
lnvo_EMailSend.of_update_almusers()

Destroy lnv_asa
Destroy lnv_sql
Destroy lnv_data
Destroy lnvo_EMailSend //08.20.2008

Return 1
end function

public function integer of_ver92_updates ();//Added by Alfee on 03.03.2009

n_cst_update_asa  lnv_asa
n_cst_update_sql  lnv_sql
n_cst_update_data lnv_data
n_cst_update_role_right lnvo_role_right 

//1.Update sql 
IF gs_dbtype = 'ASA' THEN
	lnv_asa = Create n_cst_update_asa
	lnv_asa.of_ver92_updates() 
ELSE
	lnv_sql = Create n_cst_update_sql	
	lnv_sql.of_ver92_updates() 
END IF
lnv_data = Create n_cst_update_data 
lnv_data.of_ver92_updates() 

//2.Update role rights
lnvo_role_right = Create n_cst_update_role_right
lnvo_role_right.of_update_version_92() 

Destroy lnv_asa
Destroy lnv_sql
Destroy lnv_data
Destroy lnvo_role_right

//Call update for ver101 - Evan 09.29.2009
of_ver101_updates()

Return 1
end function

public function integer of_ver101_updates ();//Added by Evan on 09.29.2009

n_cst_update_asa  lnv_asa
n_cst_update_sql  lnv_sql
n_cst_update_data lnv_data
n_cst_update_role_right lnvo_role_right

//1.Update sql
IF gs_dbtype = 'ASA' THEN
	lnv_asa = Create n_cst_update_asa
	lnv_asa.of_ver101_updates()
ELSE
	lnv_sql = Create n_cst_update_sql
	lnv_sql.of_ver101_updates()
END IF
lnv_data = Create n_cst_update_data
lnv_data.of_ver101_updates() 

//2.Update role rights
lnvo_role_right = Create n_cst_update_role_right
lnvo_role_right.of_update_version_101()

Destroy lnv_asa
Destroy lnv_sql
Destroy lnv_data
Destroy lnvo_role_right

//Call update for ver111 - Alfee 07.23.2010
of_ver111_updates()

Return 1
end function

public function integer of_ver111_updates ();//Added by Evan on 09.29.2009

n_cst_update_asa  lnv_asa
n_cst_update_sql  lnv_sql
n_cst_update_data lnv_data
n_cst_update_role_right lnvo_role_right

//1.Update sql
IF gs_dbtype = 'ASA' THEN
	lnv_asa = Create n_cst_update_asa
	lnv_asa.of_ver111_updates()
ELSE
	lnv_sql = Create n_cst_update_sql
	lnv_sql.of_ver111_updates()
END IF
lnv_data = Create n_cst_update_data
lnv_data.of_ver111_updates() 

//2.Update role rights
lnvo_role_right = Create n_cst_update_role_right
lnvo_role_right.of_update_version_111()

Destroy lnv_asa
Destroy lnv_sql
Destroy lnv_data
Destroy lnvo_role_right

//3. Call update for ver112 - Evan 01.10.2011
of_ver112_updates()

Return 1
end function

public function integer of_ver112_updates ();//added - evan 01.10.2011

n_cst_update_asa  lnv_asa
n_cst_update_sql  lnv_sql
n_cst_update_data lnv_data
n_cst_update_role_right lnvo_role_right

//1.Update sql
IF gs_dbtype = 'ASA' THEN
	lnv_asa = Create n_cst_update_asa
	lnv_asa.of_ver112_updates()
ELSE
	lnv_sql = Create n_cst_update_sql
	lnv_sql.of_ver112_updates()
END IF
lnv_data = Create n_cst_update_data
lnv_data.of_ver112_updates() 

//2.Update role rights
lnvo_role_right = Create n_cst_update_role_right
lnvo_role_right.of_update_version_112()

Destroy lnv_asa
Destroy lnv_sql
Destroy lnv_data
Destroy lnvo_role_right

//3.Call update for ver113 - evan 06.13.2011
of_ver113_updates()

Return 1
end function

public function integer of_ver113_updates ();// For v113 db updates - evan 06.13.2011

n_cst_update_asa  lnv_asa
n_cst_update_sql  lnv_sql
n_cst_update_data lnv_data
n_cst_update_role_right lnvo_role_right

//1.Update sql
IF gs_dbtype = 'ASA' THEN
	lnv_asa = Create n_cst_update_asa
	lnv_asa.of_ver113_updates()
ELSE
	lnv_sql = Create n_cst_update_sql
	lnv_sql.of_ver113_updates()
END IF
lnv_data = Create n_cst_update_data
lnv_data.of_ver113_updates() 

//2.Update role rights
lnvo_role_right = Create n_cst_update_role_right
lnvo_role_right.of_update_version_113()

Destroy lnv_asa
Destroy lnv_sql
Destroy lnv_data
Destroy lnvo_role_right

//3.Call update for ver121 - evan 10.13.2011
of_ver121_updates()

Return 1
end function

public function integer of_ver121_updates ();// For v121 db updates - evan 10.13.2011

n_cst_update_asa  lnv_asa
n_cst_update_sql  lnv_sql
n_cst_update_data lnv_data
n_cst_update_role_right lnvo_role_right

//1.Update sql
IF gs_dbtype = 'ASA' THEN
	lnv_asa = Create n_cst_update_asa
	lnv_asa.of_ver121_updates()
ELSE
	lnv_sql = Create n_cst_update_sql
	lnv_sql.of_ver121_updates()
END IF
lnv_data = Create n_cst_update_data
lnv_data.of_ver121_updates() 

//2.Update role rights
lnvo_role_right = Create n_cst_update_role_right
lnvo_role_right.of_update_version_121()

Destroy lnv_asa
Destroy lnv_sql
Destroy lnv_data
Destroy lnvo_role_right

//3.Call update for ver122 - long.zhang 09.20.2012

of_ver122_updates()

Return 1
end function

public function integer of_ver122_updates ();// For v122 db updates - Stephen 06.04.2012

n_cst_update_asa  lnv_asa
n_cst_update_sql  lnv_sql
n_cst_update_data lnv_data
n_cst_update_role_right lnvo_role_right

//------------------- APPEON BEGIN -------------------
//$<add> Stephen 10.10.2012
//$<reason>add code list  (v12.2 modify NPDB qrxs report)
string ls_sql
long ll_i, ll_cnt

ll_cnt = 0

select count(1) into :ll_cnt from sysobjects where name = 'npdb_qrxs_contact' and type = 'U';

if ll_cnt < 1 then
	n_cst_npdb lnv_npdb 
	lnv_npdb = create n_cst_npdb 
	lnv_npdb.of_insert_codes3()

	gnv_appeondb.of_startqueue( )
	for ll_i = 1 to upperbound(lnv_npdb.ls_sql_statments)
		ls_sql = lnv_npdb.ls_sql_statments[ll_i]
		execute immediate :ls_sql using sqlca;		
	next
	commit using sqlca;
	gnv_appeondb.of_commitqueue( )	
	destroy lnv_npdb
end if
//------------------- APPEON END -------------------

//1.Update sql
IF gs_dbtype = 'ASA' THEN
	lnv_asa = Create n_cst_update_asa
	lnv_asa.of_ver122_updates()
ELSE
	lnv_sql = Create n_cst_update_sql
	lnv_sql.of_ver122_updates()
END IF
lnv_data = Create n_cst_update_data
lnv_data.of_ver122_updates() 

//2.Update role rights
lnvo_role_right = Create n_cst_update_role_right
lnvo_role_right.of_update_version_122()

Destroy lnv_asa
Destroy lnv_sql
Destroy lnv_data
Destroy lnvo_role_right

//3.Call update for current version - alfee 12.03.2012
of_ver123_updates()

return 1
end function

public function integer of_ver123_updates ();// For v123 db updates - Alfee 12.03.2012

n_cst_update_asa  lnv_asa
n_cst_update_sql  lnv_sql
n_cst_update_data lnv_data
n_cst_update_role_right lnvo_role_right

//1.Update sql
IF gs_dbtype = 'ASA' THEN
	lnv_asa = Create n_cst_update_asa
	lnv_asa.of_ver123_updates()
ELSE
	lnv_sql = Create n_cst_update_sql
	lnv_sql.of_ver123_updates()
END IF
lnv_data = Create n_cst_update_data
lnv_data.of_ver123_updates() 

//2.Update role rights
lnvo_role_right = Create n_cst_update_role_right
lnvo_role_right.of_update_version_123()

//3.Call update for current version 
of_ver141_updates()

Destroy lnv_asa
Destroy lnv_sql
Destroy lnv_data
Destroy lnvo_role_right

return 1


end function

public function integer of_address_hours_sql ();of_execute("ALTER table pd_address alter column mon_from varchar(10);")
of_execute("ALTER table pd_address alter column mon_to varchar(10);")
of_execute("ALTER table pd_address alter column tue_from varchar(10);")
of_execute("ALTER table pd_address alter column tue_to varchar(10);")
of_execute("ALTER table pd_address alter column wed_from varchar(10);")
of_execute("ALTER table pd_address alter column wed_to varchar(10);")
of_execute("ALTER table pd_address alter column thu_from varchar(10);")
of_execute("ALTER table pd_address alter column thu_to varchar(10);")
of_execute("ALTER table pd_address alter column fri_from varchar(10);")
of_execute("ALTER table pd_address alter column fri_to varchar(10);")
of_execute("ALTER table pd_address alter column sat_from varchar(10);")
of_execute("ALTER table pd_address alter column sat_to varchar(10);")
of_execute("ALTER table pd_address alter column sun_from varchar(10);")
of_execute("ALTER table pd_address alter column sun_to varchar(10);")
of_execute("ALTER table pd_address alter column mon_from2 varchar(10);")
of_execute("ALTER table pd_address alter column mon_to2 varchar(10);")
of_execute("ALTER table pd_address alter column tue_from2 varchar(10);")
of_execute("ALTER table pd_address alter column tue_to2 varchar(10);")
of_execute("ALTER table pd_address alter column wed_from2 varchar(10);")
of_execute("ALTER table pd_address alter column wed_to2 varchar(10);")
of_execute("ALTER table pd_address alter column thu_from2 varchar(10);")
of_execute("ALTER table pd_address alter column thu_to2 varchar(10);")
of_execute("ALTER table pd_address alter column fri_from2 varchar(10);")
of_execute("ALTER table pd_address alter column fri_to2 varchar(10);")
of_execute("ALTER table pd_address alter column sat_from2 varchar(10);")
of_execute("ALTER table pd_address alter column sat_to2 varchar(10);")
of_execute("ALTER table pd_address alter column sun_from2 varchar(10);")
of_execute("ALTER table pd_address alter column sun_to2 varchar(10);")

of_execute("ALTER table group_practice alter column mon_from varchar(10);")
of_execute("ALTER table group_practice alter column mon_to varchar(10);")
of_execute("ALTER table group_practice alter column tue_from varchar(10);")
of_execute("ALTER table group_practice alter column tue_to varchar(10);")
of_execute("ALTER table group_practice alter column wed_from varchar(10);")
of_execute("ALTER table group_practice alter column wed_to varchar(10);")
of_execute("ALTER table group_practice alter column thu_from varchar(10);")
of_execute("ALTER table group_practice alter column thu_to varchar(10);")
of_execute("ALTER table group_practice alter column fri_from varchar(10);")
of_execute("ALTER table group_practice alter column fri_to varchar(10);")
of_execute("ALTER table group_practice alter column sat_from varchar(10);")
of_execute("ALTER table group_practice alter column sat_to varchar(10);")
of_execute("ALTER table group_practice alter column sun_from varchar(10);")
of_execute("ALTER table group_practice alter column sun_to varchar(10);")
of_execute("ALTER table group_practice alter column mon_from2 varchar(10);")
of_execute("ALTER table group_practice alter column mon_to2 varchar(10);")
of_execute("ALTER table group_practice alter column tue_from2 varchar(10);")
of_execute("ALTER table group_practice alter column tue_to2 varchar(10);")
of_execute("ALTER table group_practice alter column wed_from2 varchar(10);")
of_execute("ALTER table group_practice alter column wed_to2 varchar(10);")
of_execute("ALTER table group_practice alter column thu_from2 varchar(10);")
of_execute("ALTER table group_practice alter column thu_to2 varchar(10);")
of_execute("ALTER table group_practice alter column fri_from2 varchar(10);")
of_execute("ALTER table group_practice alter column fri_to2 varchar(10);")
of_execute("ALTER table group_practice alter column sat_from2 varchar(10);")
of_execute("ALTER table group_practice alter column sat_to2 varchar(10);")
of_execute("ALTER table group_practice alter column sun_from2 varchar(10);")
of_execute("ALTER table group_practice alter column sun_to2 varchar(10);")

return 1
end function

public function integer of_ver141_updates ();// For db updates - Alfee 05.21.2013

n_cst_update_asa  lnv_asa
n_cst_update_sql  lnv_sql
n_cst_update_data lnv_data
n_cst_update_role_right lnvo_role_right

//1. Update sql
IF gs_dbtype = 'ASA' THEN
	lnv_asa = Create n_cst_update_asa
	lnv_asa.of_ver141_updates()
ELSE
	lnv_sql = Create n_cst_update_sql
	lnv_sql.of_ver141_updates()
END IF

//2. Update data
lnv_data = Create n_cst_update_data
lnv_data.of_ver141_updates() 

//3. Update role rights
lnvo_role_right = Create n_cst_update_role_right
lnvo_role_right.of_update_version_141()

//4. Call update for current version 
of_ver142_updates()

Destroy lnv_asa
Destroy lnv_sql
Destroy lnv_data
Destroy lnvo_role_right

return 1


end function

public function integer of_ver142_updates ();// For db updates 

n_cst_update_asa  lnv_asa
n_cst_update_sql  lnv_sql
n_cst_update_data lnv_data
n_cst_update_role_right lnvo_role_right

//1.Update sql
IF gs_dbtype = 'ASA' THEN
	lnv_asa = Create n_cst_update_asa
	lnv_asa.of_ver142_updates()
ELSE
	lnv_sql = Create n_cst_update_sql
	lnv_sql.of_ver142_updates()
END IF

//2.  Update data
lnv_data = Create n_cst_update_data
lnv_data.of_ver142_updates() 

//3.Update role rights
lnvo_role_right = Create n_cst_update_role_right
lnvo_role_right.of_update_version_142()

//4. Call update for current version 
of_ver151_updates()

Destroy lnv_asa
Destroy lnv_sql
Destroy lnv_data
Destroy lnvo_role_right

return 1


end function

public function integer of_ver151_updates ();// For db updates 

n_cst_update_asa  lnv_asa
n_cst_update_sql  lnv_sql
n_cst_update_data lnv_data
n_cst_update_role_right lnvo_role_right

//1.Update sql
IF gs_dbtype = 'ASA' THEN
	lnv_asa = Create n_cst_update_asa
	lnv_asa.of_ver151_updates()
ELSE
	lnv_sql = Create n_cst_update_sql
	lnv_sql.of_ver151_updates()
END IF

//2.  Update data
lnv_data = Create n_cst_update_data
lnv_data.of_ver151_updates() 

//3.Update role rights
lnvo_role_right = Create n_cst_update_role_right
lnvo_role_right.of_update_version_151()

//4. Call update for current version 
of_ver152_updates()

Destroy lnv_asa
Destroy lnv_sql
Destroy lnv_data
Destroy lnvo_role_right

return 1


end function

public function integer of_ver152_updates ();// For db updates 

n_cst_update_asa  lnv_asa
n_cst_update_sql  lnv_sql
n_cst_update_data lnv_data
n_cst_update_role_right lnvo_role_right

//1.Update sql
IF gs_dbtype = 'ASA' THEN
	lnv_asa = Create n_cst_update_asa
	lnv_asa.of_ver152_updates()
ELSE
	lnv_sql = Create n_cst_update_sql
	lnv_sql.of_ver152_updates()
END IF

//2.  Update data
lnv_data = Create n_cst_update_data
lnv_data.of_ver152_updates() 

//3.Update role rights
lnvo_role_right = Create n_cst_update_role_right
lnvo_role_right.of_update_version_152()

//4. Call update for current version 
of_ver153_updates()

Destroy lnv_asa
Destroy lnv_sql
Destroy lnv_data
Destroy lnvo_role_right

return 1


end function

public function integer of_ver153_updates ();// For db updates 

n_cst_update_asa  lnv_asa
n_cst_update_sql  lnv_sql
n_cst_update_data lnv_data
n_cst_update_role_right lnvo_role_right

//1.Update sql
IF gs_dbtype = 'ASA' THEN
	lnv_asa = Create n_cst_update_asa
	lnv_asa.of_ver153_updates()
ELSE
	lnv_sql = Create n_cst_update_sql
	lnv_sql.of_ver153_updates()
END IF

//2.  Update data
lnv_data = Create n_cst_update_data
lnv_data.of_ver153_updates() 

//3.Update role rights
lnvo_role_right = Create n_cst_update_role_right
lnvo_role_right.of_update_version_153()

//4. Call update for current version 
of_ver154_updates()

Destroy lnv_asa
Destroy lnv_sql
Destroy lnv_data
Destroy lnvo_role_right

return 1


end function

public function integer of_ver154_updates ();// For db updates 

n_cst_update_asa  lnv_asa
n_cst_update_sql  lnv_sql
n_cst_update_data lnv_data
n_cst_update_role_right lnvo_role_right

//1.Update sql
IF gs_dbtype = 'ASA' THEN
	lnv_asa = Create n_cst_update_asa
	lnv_asa.of_ver154_updates()
ELSE
	lnv_sql = Create n_cst_update_sql
	lnv_sql.of_ver154_updates()
END IF

//2.  Update data
lnv_data = Create n_cst_update_data
lnv_data.of_ver154_updates() 

//3.Update role rights
lnvo_role_right = Create n_cst_update_role_right
lnvo_role_right.of_update_version_154()

//4. Call update for current version 
of_ver161_updates()

Destroy lnv_asa
Destroy lnv_sql
Destroy lnv_data
Destroy lnvo_role_right

return 1


end function

public function integer of_ver161_updates ();// For db updates 

n_cst_update_asa  lnv_asa
n_cst_update_sql  lnv_sql
n_cst_update_data lnv_data
n_cst_update_role_right lnvo_role_right

//1.Update sql
IF gs_dbtype = 'ASA' THEN
	lnv_asa = Create n_cst_update_asa
	lnv_asa.of_ver161_updates()
ELSE
	lnv_sql = Create n_cst_update_sql
	lnv_sql.of_ver161_updates()
END IF

//2.  Update data
lnv_data = Create n_cst_update_data
lnv_data.of_ver161_updates() 

//3.Update role rights
lnvo_role_right = Create n_cst_update_role_right
lnvo_role_right.of_update_version_161()

Destroy lnv_asa
Destroy lnv_sql
Destroy lnv_data
Destroy lnvo_role_right

return 1


end function

on w_priv_update.create
this.cb_8=create cb_8
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_report=create cb_report
this.cb_group=create cb_group
this.st_sqlfolder=create st_sqlfolder
this.cb_browse=create cb_browse
this.sle_sqlfolder=create sle_sqlfolder
this.cb_4=create cb_4
this.cbx_latest=create cbx_latest
this.st_sql=create st_sql
this.cb_reset=create cb_reset
this.st_1=create st_1
this.cb_2=create cb_2
this.dw_wizard=create dw_wizard
this.dw_report=create dw_report
this.sle_1=create sle_1
this.dw_fields=create dw_fields
this.dw_hosp=create dw_hosp
this.cb_9=create cb_9
this.dw_whatever=create dw_whatever
this.dw_2=create dw_2
this.cb_3=create cb_3
this.cb_1=create cb_1
this.dw_affil=create dw_affil
this.dw_1=create dw_1
this.dw_primehosp=create dw_primehosp
this.dw_screen=create dw_screen
this.dw_hlink=create dw_hlink
this.gb_1=create gb_1
this.st_update=create st_update
this.cb_update=create cb_update
this.Control[]={this.cb_8,&
this.cb_7,&
this.cb_6,&
this.cb_5,&
this.cb_report,&
this.cb_group,&
this.st_sqlfolder,&
this.cb_browse,&
this.sle_sqlfolder,&
this.cb_4,&
this.cbx_latest,&
this.st_sql,&
this.cb_reset,&
this.st_1,&
this.cb_2,&
this.dw_wizard,&
this.dw_report,&
this.sle_1,&
this.dw_fields,&
this.dw_hosp,&
this.cb_9,&
this.dw_whatever,&
this.dw_2,&
this.cb_3,&
this.cb_1,&
this.dw_affil,&
this.dw_1,&
this.dw_primehosp,&
this.dw_screen,&
this.dw_hlink,&
this.gb_1,&
this.st_update,&
this.cb_update}
end on

on w_priv_update.destroy
destroy(this.cb_8)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_report)
destroy(this.cb_group)
destroy(this.st_sqlfolder)
destroy(this.cb_browse)
destroy(this.sle_sqlfolder)
destroy(this.cb_4)
destroy(this.cbx_latest)
destroy(this.st_sql)
destroy(this.cb_reset)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.dw_wizard)
destroy(this.dw_report)
destroy(this.sle_1)
destroy(this.dw_fields)
destroy(this.dw_hosp)
destroy(this.cb_9)
destroy(this.dw_whatever)
destroy(this.dw_2)
destroy(this.cb_3)
destroy(this.cb_1)
destroy(this.dw_affil)
destroy(this.dw_1)
destroy(this.dw_primehosp)
destroy(this.dw_screen)
destroy(this.dw_hlink)
destroy(this.gb_1)
destroy(this.st_update)
destroy(this.cb_update)
end on

event open;DateTime dt

gw_popup[UpperBound(gw_popup[]) + 1] = This  //(Appeon)Alfee 01.21.2014 - V142 ISG-CLX

SELECT last_update
	INTO :idt_lup
	From ids;
	
st_1.Text = "Updates last run " + String(idt_lup)
st_update.Visible = True

is_parm = Message.StringParm //Alfee 01.30.2008

//--------Commented by Alfee 01.30.2008-----------------------------
/* The below statements should be deleted
//==============================APPEON BEGIN==========================
// $<Added>:   Date: Oct 26,2007       Author:Nova
//--------------------------------------------------------------------
// $<reason>   add dbupdate.
is_parm=Message.StringParm

gs_SubFolder[] = {"release","patch"}
IF AppeonGetClientType() <> "WEB" THEN
	st_sqlfolder.Visible = False
	sle_sqlfolder.Visible = False
	cb_browse.Visible = False
	GS_SYSRUNPATH = GetCurrentDirectory ( )
END IF
//==============================APPEON END============================
*/
end event

event close;//disCONNECT USING SQLCA;
end event

type cb_8 from commandbutton within w_priv_update
integer x = 2798
integer y = 484
integer width = 553
integer height = 76
integer taborder = 200
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "View alias update"
end type

event clicked;//n_cst_update_create_screen lnv_create_screen
//
//IF Not IsValid( w_infodisp ) THEN Open(w_infodisp)
//IF IsValid(w_infodisp) THEN w_infodisp.Title = "Update DB - lnv_create_screen.of_ver113_create_screen()"
//IF IsValid(w_infodisp) THEN w_infodisp.Center = True
//IF IsValid(w_infodisp) THEN w_infodisp.st_complete.Visible = False
//IF IsValid(w_infodisp) THEN w_infodisp.st_3.Visible = False
//IF IsValid(w_infodisp) THEN w_infodisp.st_information.Visible = False
//IF IsValid(w_infodisp) THEN w_infodisp.st_1.Text = 'lnv_create_screen.of_ver113_create_screen'
//IF IsValid(w_infodisp) THEN w_infodisp.wf_set_min_max(1, UpperBound(ll_screen_ids))
//
//lnv_create_screen.of_ver113_create_screen()
//
//IF IsValid( w_infodisp ) THEN Close(w_infodisp)
end event

type cb_7 from commandbutton within w_priv_update
integer x = 1527
integer y = 404
integer width = 462
integer height = 76
integer taborder = 190
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Login Button Data"
end type

event clicked;//Start Code Change ----06.17.2013 #V14 maha
integer res

res = messagebox("Replace Login Button data", "Are you sure you want to delete the existing Login button data and re-import it? It will not effect existing Role Assignments, or button templates. ",Question!,yesno!,2)
if res = 2 then 
	return
else
	delete from button_type;
	commit using sqlca;
end if

//---------Begin Modified by (Appeon)Alfee 07.09.2013 ---------------------------
//n_cst_update_data lnvo_data
//lnvo_data = create n_cst_update_data
//lnvo_data.of_login_buttons_data()
//lnvo_data.of_execute_sqls( "Reloading Button Type Data")
//destroy lnvo_data

n_cst_update_extra lnvo_data
lnvo_data.of_login_buttons_data()
//---------End Modfiied ----------------------------------------------------------------
if isvalid(w_infodisp) then close(w_infodisp)	

Return 1
end event

type cb_6 from commandbutton within w_priv_update
integer x = 2016
integer y = 404
integer width = 553
integer height = 76
integer taborder = 190
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Address Hours length"
end type

event clicked;
//Start Code Change ----04.17.2013 #V12 maha - to correct the length of address and group hours for the SQL server DB.
of_address_hours_sql()



end event

type cb_5 from commandbutton within w_priv_update
integer x = 553
integer y = 404
integer width = 453
integer height = 76
integer taborder = 180
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Launch Pad Data"
end type

event clicked;//maha 04.04.2011
integer res

res = messagebox("Replace Launch Pad data", "Are you sure you want to delete the existing Launch Pad data and re-import it?",Question!,yesno!,2)
if res = 2 then 
	return
else
	delete from launch_pad;
	commit using sqlca;
end if



n_cst_update_extra lnvo_extra
debugbreak()
//lnvo_extra = Create n_cst_update_extra
lnvo_extra.of_update_launch_pad()
//Destroy lnvo_extra

If isvalid(w_infodisp) Then Close(w_infodisp)

Return 1


end event

type cb_report from commandbutton within w_priv_update
integer x = 50
integer y = 404
integer width = 503
integer height = 76
integer taborder = 170
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Standard Report List"
end type

event clicked;of_update_reports( )

end event

type cb_group from commandbutton within w_priv_update
integer x = 1006
integer y = 404
integer width = 521
integer height = 76
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Group Mapping Data"
end type

event clicked; //Start Code Change ----.2011 #V11 maha - creared to correct data for group mapping in version 11

integer r
string ls_sql_statements[]

ls_sql_statements[UpperBound(ls_sql_statements) + 1] =  "update data_view_fields set field_id = 189000, screen_id = 85 where data_view_field_id = -104;"

ls_sql_statements[UpperBound(ls_sql_statements) + 1] =  "update data_view_fields set field_id = 189007, screen_id = 85 where data_view_field_id = -116;"
ls_sql_statements[UpperBound(ls_sql_statements) + 1] ="update data_view_fields set field_id = 189006, screen_id = 85 where data_view_field_id = -105;"
ls_sql_statements[UpperBound(ls_sql_statements) + 1] = "update data_view_fields set field_id = 189004, screen_id = 85 where data_view_field_id = -107;"

ls_sql_statements[UpperBound(ls_sql_statements) + 1] = "update data_view_fields set field_id = 189001, screen_id = 85 where data_view_field_id = -252;"
ls_sql_statements[UpperBound(ls_sql_statements) + 1] = "update data_view_fields set field_id = 189009, screen_id = 85 where data_view_field_id = -254;"
ls_sql_statements[UpperBound(ls_sql_statements) + 1] = "update data_view_fields set field_id = 189011, screen_id = 85 where data_view_field_id = -256;"
ls_sql_statements[UpperBound(ls_sql_statements) + 1] = "update data_view_fields set field_id = 189012, screen_id = 85 where data_view_field_id = -258;"
ls_sql_statements[UpperBound(ls_sql_statements) + 1] = "update data_view_fields set field_id = 189014, screen_id = 85 where data_view_field_id = -260;"
ls_sql_statements[UpperBound(ls_sql_statements) + 1] = "update data_view_fields set field_id = 189016, screen_id = 85 where data_view_field_id = -262;"
ls_sql_statements[UpperBound(ls_sql_statements) + 1] = "update data_view_fields set field_id = 189018, screen_id = 85 where data_view_field_id = -264;"
ls_sql_statements[UpperBound(ls_sql_statements) + 1] = "update data_view_fields set field_id = 189002, screen_id = 85 where data_view_field_id = -253;"
ls_sql_statements[UpperBound(ls_sql_statements) + 1] = "update data_view_fields set field_id = 189010, screen_id = 85 where data_view_field_id = -255;"
ls_sql_statements[UpperBound(ls_sql_statements) + 1] = "update data_view_fields set field_id = 189003, screen_id = 85 where data_view_field_id = -257;"
ls_sql_statements[UpperBound(ls_sql_statements) + 1] = "update data_view_fields set field_id = 189013, screen_id = 85 where data_view_field_id = -259;"
ls_sql_statements[UpperBound(ls_sql_statements) + 1] = "update data_view_fields set field_id = 189015, screen_id = 85 where data_view_field_id = -261;"
ls_sql_statements[UpperBound(ls_sql_statements) + 1] = "update data_view_fields set field_id = 189017, screen_id = 85 where data_view_field_id = -263;"
ls_sql_statements[UpperBound(ls_sql_statements) + 1] = "update data_view_fields set field_id = 189019, screen_id = 85 where data_view_field_id = -265;"
ls_sql_statements[UpperBound(ls_sql_statements) + 1] = "Insert into data_view_fields (data_view_field_id,data_view_id,screen_id,field_id, field_order, field_label,display_only,required,data_seperator,include_in_browse,field_x,field_y,field_width,field_height,justification,edit_field_type,field_label_x,field_label_y,field_label_width,visible) values (-266, 1,85,189008,10,'Primary Tax id','N','N','N','N',1776,144,500,56,0,'E',1776,70,500,'Y');"
ls_sql_statements[UpperBound(ls_sql_statements) + 1] = "update data_view_fields set visible = 'Y' where visible = 'N' and screen_id >= 80 and screen_id <= 85;"

ls_sql_statements[UpperBound(ls_sql_statements) + 1] = "update data_view_fields   set field_label = sys_fields.field_name_allias  FROM data_view_fields join sys_fields  on  data_view_fields.field_id = sys_fields.field_id  where data_view_fields.screen_id >= 80 AND data_view_fields.screen_id <= 85;"
for r = 1 to upperbound(ls_sql_statements )
	of_execute(ls_sql_statements[r])
next




end event

type st_sqlfolder from statictext within w_priv_update
boolean visible = false
integer y = 1240
integer width = 224
integer height = 88
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "Sql folder:"
boolean focusrectangle = false
end type

type cb_browse from commandbutton within w_priv_update
boolean visible = false
integer x = 1861
integer y = 1236
integer width = 274
integer height = 80
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Browse..."
end type

event clicked;string ls_path =GetCurrentDirectory ( ) 
integer li_result
li_result = GetFolder( "Sql file folder:", ls_path )

sle_sqlfolder.text=ls_path  
end event

type sle_sqlfolder from singlelineedit within w_priv_update
boolean visible = false
integer x = 224
integer y = 1236
integer width = 1550
integer height = 96
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_4 from commandbutton within w_priv_update
boolean visible = false
integer x = 800
integer y = 1212
integer width = 343
integer height = 92
integer taborder = 170
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "test"
end type

event clicked;//of_add_dv_fields(200000,200517)

of_caqh_fields()

end event

type cbx_latest from checkbox within w_priv_update
boolean visible = false
integer x = 1751
integer y = 1112
integer width = 375
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 32891346
string text = "Latest only"
boolean lefttext = true
end type

type st_sql from statictext within w_priv_update
integer x = 32
integer y = 1212
integer width = 1769
integer height = 332
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
boolean enabled = false
boolean focusrectangle = false
end type

type cb_reset from commandbutton within w_priv_update
integer x = 530
integer y = 1072
integer width = 315
integer height = 76
integer taborder = 160
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Reset Date"
end type

event clicked;String ls_sql

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-04
//$<add> 04.03.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
gnv_appeondb.of_startqueue( )
//---------------------------- APPEON END ----------------------------

ls_sql = "update ids set last_update = '2002-01-01 00:00:00';"
EXECUTE Immediate :ls_sql Using sqlca;
COMMIT Using sqlca;

//Restore the setting to 41 - Alfee 01.30.2008
ls_sql = "update icred_settings set set_18 = 41;" //Start Code Change ---- 08.06.2007 #V7 maha
EXECUTE Immediate :ls_sql Using sqlca;
COMMIT Using sqlca;

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-05
//$<add> 04.03.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
gnv_appeondb.of_commitqueue( )
//---------------------------- APPEON END ----------------------------

idt_lup = DateTime('2002-01-01 00:00:00')

end event

type st_1 from statictext within w_priv_update
integer x = 137
integer y = 68
integer width = 1495
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
boolean enabled = false
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_priv_update
integer x = 891
integer y = 1580
integer width = 247
integer height = 108
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

type dw_wizard from datawindow within w_priv_update
integer x = 146
integer y = 1200
integer width = 402
integer height = 108
integer taborder = 120
string dataobject = "d_report_wiz_import"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_report from datawindow within w_priv_update
integer x = 155
integer y = 1336
integer width = 384
integer height = 168
integer taborder = 100
string dataobject = "d_report_import"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type sle_1 from singlelineedit within w_priv_update
integer x = 955
integer y = 1556
integer width = 562
integer height = 92
integer taborder = 170
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type dw_fields from datawindow within w_priv_update
integer x = 1179
integer y = 1368
integer width = 69
integer height = 68
integer taborder = 140
string dataobject = "d_dv_fields"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_hosp from datawindow within w_priv_update
integer x = 1390
integer y = 1500
integer width = 137
integer height = 88
integer taborder = 70
string dataobject = "d_all_hosp_affil"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type cb_9 from commandbutton within w_priv_update
integer x = 910
integer y = 1832
integer width = 635
integer height = 112
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "7) Create links update"
end type

event clicked;//long i
//long rch
//integer f
//integer rcf
//long hosp_id
//integer fac_id
//integer prime
//long prac_id
//long nr
//integer res
//long cnt
//long runcnt = 0
//
//dw_hosp.settransobject(sqlca)
//dw_hlink.settransobject(sqlca)
//rch = dw_hosp.retrieve()
//cnt = dw_hlink.retrieve()
//dw_hosp.SetRedraw(FALSE)
//dw_hlink.SetRedraw(FALSE)
//if cnt > 0 then 
//	messagebox("Some Links have already been created","You cannot use this program to create additional ones")
//	return
//end if
//
//for i = 1 to rch
//	hosp_id = dw_hosp.getitemnumber(i,"rec_id")
//	prac_id = dw_hosp.getitemnumber(i,"prac_id")
//	prime = dw_hosp.getitemnumber(i,"primary_hosp")
//	if isnull(prime) then prime = 582 
//	dw_affil.settransobject(sqlca)
//	rcf = dw_affil.retrieve(prac_id)
//	for f = 1 to rcf
//		fac_id = dw_affil.getitemnumber(f,"parent_facility_id")
//		nr = dw_hlink.insertrow(0)
//		dw_hlink.setitem(nr,"hosp_affil_id",hosp_id)
//		dw_hlink.setitem(nr,"facility_id",fac_id)
//		dw_hlink.setitem(nr,"primary_hosp",prime)
//		dw_hlink.setitem(nr,"prac_id",prac_id)
//	next
//	runcnt++
//	if runcnt = 1000 then
//		dw_hlink.settransobject(sqlca)
//		dw_hlink.update()
//		commit using sqlca;
//		dw_hlink.reset()
//		runcnt = 0
//	end if
//	sle_1.text = string(i)
//next
//
//dw_hosp.SetRedraw(True)
//dw_hlink.SetRedraw(True)
//
// 
//	dw_hlink.settransobject(sqlca)
//	dw_hlink.update()
//	commit using sqlca;
//
//
//messagebox("Complete","hosp links")
//
//
//
//
//
//
//
//this.enabled = false
end event

type dw_whatever from datawindow within w_priv_update
integer x = 1211
integer y = 1488
integer width = 809
integer height = 256
integer taborder = 40
string dataobject = "d_fix_dob"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)

end event

type dw_2 from datawindow within w_priv_update
integer x = 1253
integer y = 1360
integer width = 681
integer height = 172
integer taborder = 30
string dataobject = "d_code_lookup_update"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type cb_3 from commandbutton within w_priv_update
integer x = 2235
integer y = 36
integer width = 315
integer height = 108
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;CLOSE(PARENT)
end event

type cb_1 from commandbutton within w_priv_update
integer x = 2235
integer y = 208
integer width = 315
integer height = 108
integer taborder = 180
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "About"
end type

event clicked;messagebox("To operate this program :","Click button to update database. Click Quit when done.")
end event

type dw_affil from datawindow within w_priv_update
integer x = 1317
integer y = 1664
integer width = 219
integer height = 80
integer taborder = 130
string dataobject = "d_affil_stat_of_prac"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type dw_1 from datawindow within w_priv_update
integer x = 1234
integer y = 1388
integer width = 87
integer height = 72
integer taborder = 20
string dataobject = "d_code_lookup_priv_check"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_primehosp from datawindow within w_priv_update
integer x = 1271
integer y = 1484
integer width = 73
integer height = 48
integer taborder = 110
string dataobject = "d_prim_hosp"
boolean hscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_screen from datawindow within w_priv_update
integer x = 1422
integer y = 1492
integer width = 82
integer height = 52
integer taborder = 90
string dataobject = "d_screen_addr"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_hlink from datawindow within w_priv_update
integer x = 1138
integer y = 1468
integer width = 581
integer height = 108
integer taborder = 150
string dataobject = "d_hf_link"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type gb_1 from groupbox within w_priv_update
integer x = 14
integer y = 344
integer width = 1989
integer height = 160
integer taborder = 180
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Refresh Data"
end type

type st_update from statictext within w_priv_update
boolean visible = false
integer x = 206
integer y = 504
integer width = 1701
integer height = 188
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_update from commandbutton within w_priv_update
integer x = 32
integer y = 32
integer width = 2130
integer height = 284
integer taborder = 50
boolean bringtotop = true
integer textsize = -18
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Click to Run Database Updates"
end type

event clicked;//Re-constructed by Alfee on 01.30.2008 

Integer li_current_version //(Appeon)Alfee 06.18.2013 - V141 ISG-CLX
Long	ll_count
String ls_sql, ls_msg, ls_logfile, ls_development,ls_if_show
String ls_current_version_patch  //(Appeon)Alfee 06.18.2013 - V141 ISG-CLX

n_cst_update_screen lnvo_screen
n_cst_update_report lnvo_report
n_cst_dwsyntax_update_screen lnvo_screen_properties
n_cst_update_data lnv_data
n_cst_update_data_clx lnv_data_clx  //(Appeon)Alfee 06.18.2013 - V141 ISG-CLX
n_cst_update_view_fields_alias lnvo_update

ls_if_show=is_parm
gb_upgrade_failed = FALSE

SetPointer(HourGlass!)

//initilize log service
IF Not IsValid(gnv_logservice) THEN gnv_logservice = Create n_logservice 

IF appeongetclienttype() = 'WEB' THEN StopIEpopupmsg() //Andy 03.24.2010

If gnv_data.of_GetItem( "icred_settings", "ie_maxscript", False ) = '1' Then
	RegistrySet( "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Styles", "MaxScriptStatements", RegULong!, 500000000) //Ken.Guo 11.24.2008 
End If

//1.update sql 2.update support doc 3.update contact 4.update role right
of_update_sql()

//4.5 Refresh data
app_filler.ids_screen_fields_cache.Retrieve()
app_filler.ids_screen_objects_cache.Retrieve()

//4.6 Initialization for Web approve 		
gnv_webapprove.of_initialization () //(Appeon)Alfee 06.18.2013 - V141 ISG-CLX

//5.update screen
lnvo_screen = Create n_cst_update_screen
//lnvo_screen.of_appeon2_changes()
lnvo_screen.of_appeon2_changes(false) //(Appeon)Alfee 06.18.2013 - V141 ISG-CLX
Destroy lnvo_screen

//5.1 Patch for the syntax of Contract screens - (Appeon)Alfee 06.18.2013 - V141 ISG-CLX
lnv_data_clx = Create n_cst_update_data_clx
lnv_data_clx.of_patch_screen ()

//6.Update Report
lnvo_report = Create n_cst_update_report
lnvo_report.of_update_reports()
Destroy lnvo_report

//6.1 Update Extra data - Alfee 07.23.2009
n_cst_update_extra lnv_extra
lnv_extra.of_update_extra()

//update screen properties
select count(*) into :ll_count from data_view_report_fields where ismodify='1';
if sqlca.sqlcode=0 and ll_count=0 then
	lnvo_screen_properties = create n_cst_dwsyntax_update_screen
	lnvo_screen_properties.of_screen_modify_field()
	lnvo_screen_properties.of_dwsyntax_update_screen()
	destroy lnvo_screen_properties
end if

Select set_18, set_patch_ver into :li_current_version,:ls_current_version_patch From icred_settings;  //(Appeon)Alfee 06.18.2013 - V141 ISG-CLX

//7. Update view fields alias & screen shots
lnv_data = Create n_cst_update_data
lnvo_update = Create n_cst_update_view_fields_alias

lnv_data.of_ver80_fix_view_alias( ) //Fix issue 5 from IntelliReport Issues 4-22-08.doc - nova 04.24.2008
//---------Begin Modified by (Appeon)Alfee 06.18.2013 for V141 ISG-CLX--------
//lnvo_update.of_update_view_fields_alias( 0, 0)
IF li_current_version < Long(gs_current_version) OR (li_current_version = Long(gs_current_version) AND ls_current_version_patch < '002') THEN
	lnvo_update.of_update_view_fields_alias (0, 0) 
END IF
//---------End Modfiied -----------------------------------------------------------------
lnv_data.of_ver80_fix_view_fields_alias( )  //Fix issue 5 from IntelliReport Issues 4-22-08.doc - nova 04.24.2008
lnvo_update.of_update_view_picture( )
lnvo_update.of_update() //Add by Evan 02.28.2011
lnvo_update.of_update_view_field_name()//V11.1 SK IntelliReport - nova 09.02.2010

//---------Begin Added by (Appeon)Alfee 06.18.2013 for V141 ISG-CLX--------
//7.1 Check Update IDs -- jervis 06.26.2009
lnv_data_clx.of_check_ids( )

//7.2 Initial clause data - Added By Mark Lee 07/11/12
lnv_data_clx.inv_clause.of_ini_data( )

Destroy lnv_data_clx
//---------End Added ------------------------------------------------------------------

Destroy lnv_data
Destroy lnvo_update

//Update version no and last update accordingly
ls_sql = "Update icred_settings set set_18 = "+ gs_current_version + ";"
EXECUTE Immediate :ls_sql Using sqlca;
IF sqlca.SQLCode <> 0 THEN
	IF IsValid(gnv_logservice) THEN gnv_logservice.of_log(ls_sql, sqlca.SQLErrText,"cb_update.clicked()")
	gb_upgrade_failed = True
END IF

//ls_sql = "Update icred_settings set set_patch_ver = "+ gs_current_version_patch + ";"
ls_sql = "Update icred_settings set set_patch_ver = '"+ gs_current_version_patch + "';" //(Appeon)Alfee 06.18.2013 - V141 ISG-CLX
EXECUTE Immediate :ls_sql Using sqlca;
IF sqlca.SQLCode <> 0 THEN
	IF IsValid(gnv_logservice) THEN gnv_logservice.of_log(ls_sql, sqlca.SQLErrText,"cb_update.clicked()")
	gb_upgrade_failed = True
END IF

IF gs_DBType = 'SQL' THEN
	ls_sql = "Update ids set last_update = getdate();"
ELSE
	ls_sql = "Update ids set last_update = now();"
END IF

EXECUTE Immediate :ls_sql Using sqlca;
IF sqlca.SQLCode <> 0 THEN
	IF IsValid(gnv_logservice) THEN gnv_logservice.of_log(ls_sql, sqlca.SQLErrText,"cb_update.clicked()")
	gb_upgrade_failed = True
END IF
COMMIT Using sqlca;

//Log the result
IF IsValid(gnv_logservice) THEN
	gnv_logservice.of_setloglevel(1)
	gnv_logservice.of_log(1, "===================================================")
	IF gb_upgrade_failed THEN
		ls_msg = "IMPORTANT: Database Upgrade failed!"
		gnv_logservice.of_setloglevel(2)
		gnv_logservice.of_log(2, ls_msg)
	ELSE
		ls_msg = "IMPORTANT: Database Upgrade succeeded!"
		gnv_logservice.of_setloglevel(1)
		gnv_logservice.of_log(1, ls_msg)
	END IF
	gnv_logservice.of_setloglevel(1)
	gnv_logservice.of_log(1, "===================================================")
END IF

If gnv_data.of_GetItem( "icred_settings", "ie_maxscript", False ) = '1' Then
	RegistrySet( "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Styles", "MaxScriptStatements", RegULong!, 5000000) //11.24.2008 By: Ken.Guo. Restore to IE Default value
End If

//---------Begin Added by (Appeon)Alfee 06.18.2013 for V141 ISG-CLX--------
//Added By Ken.Guo 2009-10-12. write to upgrade log
String ls_result,ls_old_db_version,ls_new_db_version,ls_app_version,ls_comment
If gb_upgrade_failed Then
	ls_result = "Failing"
Else
	ls_result = "Successful"
End If

ls_old_db_version = String(li_current_version) + '.' + ls_current_version_patch
ls_new_db_version = gs_current_version + '.' + gs_current_version_patch
ls_app_version = ProfileString(gs_current_path + '\IntelliCred.ini', "Setup","DeployVersion", "None")

If AppeonGetClientType()  = 'PB' Then
	ls_comment = 'Client type is C/S.'
Else
	ls_comment = 'Client type is WEB.'
	If Len(gs_CacheSet) > 0 Then
		ls_comment += ' From Cache Name: ' + gs_CacheSet + '.'
	End If
End If

Insert Into db_upgrade_log (upgrade_by,upgrade_date,old_db_version,new_db_version,app_version,from_cache_name,upgrade_result,comment_info) 
		Values (:gs_user_id,getdate(),:ls_old_db_version,:ls_new_db_version,:ls_app_version,:gs_CacheSet,:ls_result,:ls_comment);
//---------End Added ------------------------------------------------------------------

//Destroy log service and close windows
IF IsValid(gnv_logservice) THEN Destroy gnv_logservice
IF IsValid(w_infodisp) THEN Close(w_infodisp)
//Close(Parent)
IF IsValid(w_priv_update) THEN Close(Parent) //Nova 05.14.2010

//---------Begin Added by (Appeon)Alfee 06.18.2013 for V141 ISG-CLX--------
//Added By Ken.Guo 06/18/2012. Workaround SQL Server 2008 Bug
IF gs_dbtype = 'SQL' THEN
	ls_sql = "exec sp_sql2008_improve"
	EXECUTE Immediate :ls_sql Using sqlca;
	IF sqlca.SQLCode <> 0 THEN
		IF IsValid(gnv_logservice) THEN gnv_logservice.of_log(ls_sql, sqlca.SQLErrText,"cb_update.clicked()")
	END IF
END IF
//---------End Added ------------------------------------------------------------------

SetPointer(Arrow!)

//Prompt user the result
ls_development = ProfileString(gs_IniFilePathName, "setup", "development", "0")
IF ls_development = '1' THEN //develop mode
	IF gb_upgrade_failed THEN
		ls_logfile = gs_dir_path + "IntelliCred\dbupdate.log"
		ls_msg = "Database Upgrade failed! ~r~nError Log: " + ls_logfile
		ls_msg += "~r~nWould you like to read the upgrade log file now?"
		IF MessageBox("Database Upgrade",ls_msg, Question!, YesNo!,1) = 1 THEN
			IF FileExists(ls_logfile) THEN Run("notepad.exe " + ls_logfile)
		END IF
	ELSE
		IF ls_if_show <> 'M' THEN //when is_parm is 'M',don't show message for custerm
			MessageBox("Database Upgrade", "Database Upgrade succeeded!")
		END IF
	END IF
ELSE //non-develop mode
	IF ls_if_show <> 'M' THEN //when is_parm is 'M',don't show message for custerm
		MessageBox("Database Upgrade","Database Upgrade is completed!")
	END IF
END IF

IF ls_if_show <> 'M' THEN//when is_parm is 'M',don't show message for custerm
	//Start Code Change ----10.08.2008 #V85 maha
	integer i
	select set_56 into :i from icred_settings;
	if i = 1 then
		//skip for outlook
	else
		f_EmailSettingRemind(False) //Evan 04.29.2008
	end if
	//End Code Change---10.08.2008
END IF

//Start Code Change ----09.09.2009 #V92 maha - set poison pill value
datetime ldt_pp
integer li_rand
integer li_sub //maha 08.27.2010
randomize(0)
li_rand = Rand(30) //note don't set to the month of FEBRUARY
//ldt_pp = datetime(date("2011-09-09"),now()) //9.2
//ldt_pp = datetime(date("2012-05-" + string(li_rand)),now()) //10.1
//ldt_pp = datetime(date("2013-02-" + string(li_rand)),now()) //11.1
//ldt_pp = datetime(date("2013-09-" + string(li_rand)),now()) //11.3
//ldt_pp = datetime(date("2014-05-" + string(li_rand)),now()) //12.1  maha 02.13.2012
//ldt_pp = datetime(date("2015-10-" + string(li_rand)),now()) //12.3  maha 02.13.2012
//ldt_pp = datetime(date("2016-04-" + string(li_rand)),now()) //14.1  maha 05.24.2013
//ldt_pp = datetime(date("2017-04-" + string(li_rand)),now()) //14.2  maha 11.13.2014
//ldt_pp = datetime(date("2018-03-" + string(li_rand)),now()) //15.1  maha 03.07.2016
//ldt_pp = datetime(date("2019-03-" + string(li_rand)),now()) //15.3  maha 11.03.2016
ldt_pp = datetime(date("2019-10-" + string(li_rand)),now()) //15.4  maha 10.19.2017

//Start Code Change ----08.27.2010 #V10 maha - exception added to pp code for subscriptions
select pp_s into :li_sub from ids;
if li_sub > 0 then
	//do not update
else
	update ids set pp_date = :ldt_pp;
	update ids set pp_end = null;
end if

IF appeongetclienttype() = 'WEB' THEN ResumeIEpopupmsg() //Andy 03.24.2010

end event

