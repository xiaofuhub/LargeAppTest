$PBExportHeader$w_caqh_roster_setup.srw
forward
global type w_caqh_roster_setup from w_response
end type
type cb_ce from commandbutton within w_caqh_roster_setup
end type
type tab_1 from tab within w_caqh_roster_setup
end type
type tabpage_basic from userobject within tab_1
end type
type dw_basic from u_dw within tabpage_basic
end type
type tabpage_basic from userobject within tab_1
dw_basic dw_basic
end type
type tabpage_export from userobject within tab_1
end type
type cb_1 from commandbutton within tabpage_export
end type
type cb_run from commandbutton within tabpage_export
end type
type dw_export_sql from u_dw within tabpage_export
end type
type dw_export from u_dw within tabpage_export
end type
type tabpage_export from userobject within tab_1
cb_1 cb_1
cb_run cb_run
dw_export_sql dw_export_sql
dw_export dw_export
end type
type tabpage_ftp from userobject within tab_1
end type
type cb_2 from commandbutton within tabpage_ftp
end type
type dw_ftp from u_dw within tabpage_ftp
end type
type tabpage_ftp from userobject within tab_1
cb_2 cb_2
dw_ftp dw_ftp
end type
type tab_1 from tab within w_caqh_roster_setup
tabpage_basic tabpage_basic
tabpage_export tabpage_export
tabpage_ftp tabpage_ftp
end type
type cb_save from commandbutton within w_caqh_roster_setup
end type
type cb_close from commandbutton within w_caqh_roster_setup
end type
end forward

global type w_caqh_roster_setup from w_response
integer width = 2569
integer height = 1316
string title = "CAQH Roster Setup"
long backcolor = 33551856
string icon = "AppIcon!"
cb_ce cb_ce
tab_1 tab_1
cb_save cb_save
cb_close cb_close
end type
global w_caqh_roster_setup w_caqh_roster_setup

type variables
u_dw idw_basic
u_dw idw_export
u_dw idw_export_sql
u_dw idw_ftp

n_cst_encrypt in_encrypt

Boolean ib_changed = false
end variables

forward prototypes
public function integer of_run_export ()
public function integer of_get_exports ()
end prototypes

public function integer of_run_export ();//====================================================================
//$<Function>: of_run_export
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Test Export.
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

n_cst_caqh_roster lnv_caqh_roster
datastore lds_test
int i

lds_test = create datastore
lds_test.dataobject = 'd_caqh_roster_submit'

lnv_caqh_roster = create n_cst_caqh_roster
i = lnv_caqh_roster.of_add_submission_ds(lds_test)
Destroy lnv_caqh_roster

If i = 1 Then 
	Messagebox("Test Export","Successful!")
End If

return 0
end function

public function integer of_get_exports ();//====================================================================
//$<Function>: of_get_exports
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Get Exports for idw_export.
//$<Author>: (Appeon) long.zhang 01.11.2016 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
datawindowchild ldwc_child
Long ll_modules[]

idw_export.GetChild("value_1", ldwc_child)
ldwc_child.settransobject( SQLCA)
ll_modules[1] = 2
ldwc_child.retrieve( ll_modules[] ) //Provider Data
ldwc_child.insertrow( 1 )

Return 1
end function

on w_caqh_roster_setup.create
int iCurrent
call super::create
this.cb_ce=create cb_ce
this.tab_1=create tab_1
this.cb_save=create cb_save
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ce
this.Control[iCurrent+2]=this.tab_1
this.Control[iCurrent+3]=this.cb_save
this.Control[iCurrent+4]=this.cb_close
end on

on w_caqh_roster_setup.destroy
call super::destroy
destroy(this.cb_ce)
destroy(this.tab_1)
destroy(this.cb_save)
destroy(this.cb_close)
end on

event open;call super::open;//====================================================================
//$<Event>: open
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

long	 ll_modules[]

idw_basic = tab_1.tabpage_basic.dw_basic
idw_export =  tab_1.tabpage_export.dw_export
idw_export_sql =  tab_1.tabpage_export.dw_export_sql
idw_ftp =  tab_1.tabpage_ftp.dw_ftp

idw_basic.settransobject(sqlca)
idw_export.settransobject(sqlca)
idw_export_sql.settransobject(sqlca)
idw_ftp.settransobject(sqlca)

gnv_appeondb.of_startqueue( )

//Export id
of_get_exports() //Modified by Appeon long.zhang 01.11.2016

idw_basic.retrieve()
idw_export.retrieve()
idw_export_sql.retrieve()
idw_ftp.retrieve()

gnv_appeondb.of_CommitQueue( )


end event

event closequery;call super::closequery;//====================================================================
//$<Event>: closequery
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

If ib_changed and isvalid(w_caqh_roster) Then 
	w_caqh_roster.post event ue_setup_changed()
End If
end event

type cb_ce from commandbutton within w_caqh_roster_setup
boolean visible = false
integer x = 1499
integer y = 16
integer width = 407
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Create Export"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: Create a CAQH Roster Submission Export.
//$<Author>: (Appeon) long.zhang 01.11.2016 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//Start Code Change ----05.24.2016 #V152 maha - corrected the query filter values where only active_status was specified and was not including the table name
//====================================================================
String ls_sql = ''
String ls_err = ''

//1.Get New Export Id 2.Update Max Export Id 3.Insert Export Header 4.Insert Export Fields //Put comments out for Web Version bug, Added by Appeon long.zhang 05.25.2016
ls_sql = "Begin "+ &
"	Declare @export_id Int ~r~n"+ &
"	Declare @export_name Varchar(50) ~r~n"+ &
"	Declare @rec_id numeric(9) ~r~n"+ &
"	Set @export_id = (select isnull(max(export_id),0) + 1  from export_header) ~r~n"+ &
"	Set @export_name = 'CAQH Roster Submission' ~r~n"+ &
"	If exists(select 1 from export_header where export_name = @export_name) ~r~n"+ &
"		Return ~r~n"+ &
" ~r~n"+ &
"	Set @rec_id = (select isnull(max(rec_id),0) + 1  from export_fields) ~r~n"+ &
" ~r~n"+ &
"	update ids set export_id = @export_id ~r~n"+ &
" ~r~n"+ &
"	insert export_header(export_id,export_name,header1,header2,header3,header4,footer1,footer2,footer3,footer4,export_format,record_delimiter,field_delimiter,max_records_export,field_labels_as_header,export_type,save_path,lock_cols,prompt_type,prompt_type1,prompt_type2,prompt_type3,strip_char,multi_row_table,custom_save_name,multi_screen_filter,sort_fields,view_id,use_tmp_directory)  ~r~n"+ &
"	values(	@export_id,	@export_name	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	'export'	,	'R'	,	'T'	,	NULL	,	'1'	,	2	,	'C:\aatest\'	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	6	,	NULL	,	NULL	,	1001	,	NULL	) ~r~n"+ &
" ~r~n"+ &
"	insert export_fields(rec_id,export_id,export_field_name,export_field_length,export_fixed,export_format,trailing_leading_characters,export_required_field,intcred_table,intcred_field,intcred_record_number,export_order,export_type,field_value,export_code,use_link,filter_query,facility_id,lu_field_name,use_default,default_value,aggre_function,sort_by,dept_sect_link,dept_sect_field,billing_link,active_yesno,substring_start,ctx_scrn_id,ctx_scrn_dataobject,ctx_column_name,ctx_lookup_type,module_type,ctx_uselink,ctx_linkfromcolumn,ctx_linktoscrnid,ctx_linktocolumn,ctx_linktoscrndw,ctx_column_datatype,export_fields_expression,drop_column,record_level) values(@rec_id	, @export_id,	'Action_Flag'	,	1	,	'N'	,	'None'	,	'|'	,	'N'	,	0	,	0	,	0	,	1	,	2	,	'A'	,	0	,	0	,	NULL	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	1	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	'S'	,	NULL	,	NULL	,	'C'	) ~r~n"+ &
"	insert export_fields(rec_id,export_id,export_field_name,export_field_length,export_fixed,export_format,trailing_leading_characters,export_required_field,intcred_table,intcred_field,intcred_record_number,export_order,export_type,field_value,export_code,use_link,filter_query,facility_id,lu_field_name,use_default,default_value,aggre_function,sort_by,dept_sect_link,dept_sect_field,billing_link,active_yesno,substring_start,ctx_scrn_id,ctx_scrn_dataobject,ctx_column_name,ctx_lookup_type,module_type,ctx_uselink,ctx_linkfromcolumn,ctx_linktoscrnid,ctx_linktocolumn,ctx_linktoscrndw,ctx_column_datatype,export_fields_expression,drop_column,record_level) values(@rec_id + 1	, @export_id,	'Affiliation_flag'	,	15	,	'N'	,	'None'	,	'|'	,	'N'	,	0	,	0	,	0	,	33	,	2	,	'A'	,	0	,	0	,	NULL	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	2	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	'S'	,	NULL	,	0	,	'C'	) ~r~n"+ &
"	insert export_fields(rec_id,export_id,export_field_name,export_field_length,export_fixed,export_format,trailing_leading_characters,export_required_field,intcred_table,intcred_field,intcred_record_number,export_order,export_type,field_value,export_code,use_link,filter_query,facility_id,lu_field_name,use_default,default_value,aggre_function,sort_by,dept_sect_link,dept_sect_field,billing_link,active_yesno,substring_start,ctx_scrn_id,ctx_scrn_dataobject,ctx_column_name,ctx_lookup_type,module_type,ctx_uselink,ctx_linkfromcolumn,ctx_linktoscrnid,ctx_linktocolumn,ctx_linktoscrndw,ctx_column_datatype,export_fields_expression,drop_column,record_level) values(@rec_id + 2	, @export_id,	'Application_Type'	,	15	,	'N'	,	'None'	,	'|'	,	'N'	,	0	,	0	,	0	,	32	,	2	,	'1'	,	0	,	0	,	NULL	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	2	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	'S'	,	NULL	,	0	,	'C'	) ~r~n"+ &
"	insert export_fields(rec_id,export_id,export_field_name,export_field_length,export_fixed,export_format,trailing_leading_characters,export_required_field,intcred_table,intcred_field,intcred_record_number,export_order,export_type,field_value,export_code,use_link,filter_query,facility_id,lu_field_name,use_default,default_value,aggre_function,sort_by,dept_sect_link,dept_sect_field,billing_link,active_yesno,substring_start,ctx_scrn_id,ctx_scrn_dataobject,ctx_column_name,ctx_lookup_type,module_type,ctx_uselink,ctx_linkfromcolumn,ctx_linktoscrnid,ctx_linktocolumn,ctx_linktoscrndw,ctx_column_datatype,export_fields_expression,drop_column,record_level) values(@rec_id + 3	, @export_id,	'CAQH_Provider_ID'	,	11	,	'N'	,	'None'	,	'|'	,	'N'	,	0	,	0	,	0	,	27	,	2	,	NULL	,	0	,	1	,	NULL	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	'S'	,	NULL	,	0	,	'C'	) ~r~n"+ &
"	insert export_fields(rec_id,export_id,export_field_name,export_field_length,export_fixed,export_format,trailing_leading_characters,export_required_field,intcred_table,intcred_field,intcred_record_number,export_order,export_type,field_value,export_code,use_link,filter_query,facility_id,lu_field_name,use_default,default_value,aggre_function,sort_by,dept_sect_link,dept_sect_field,billing_link,active_yesno,substring_start,ctx_scrn_id,ctx_scrn_dataobject,ctx_column_name,ctx_lookup_type,module_type,ctx_uselink,ctx_linkfromcolumn,ctx_linktoscrnid,ctx_linktocolumn,ctx_linktoscrndw,ctx_column_datatype,export_fields_expression,drop_column,record_level) values(@rec_id + 4	, @export_id,	'Delegation_Flag'	,	1	,	'N'	,	'None'	,	'|'	,	'N'	,	0	,	0	,	0	,	31	,	2	,	'N'	,	0	,	0	,	NULL	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	1	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	'S'	,	NULL	,	0	,	'C'	) ~r~n"+ &
"	insert export_fields(rec_id,export_id,export_field_name,export_field_length,export_fixed,export_format,trailing_leading_characters,export_required_field,intcred_table,intcred_field,intcred_record_number,export_order,export_type,field_value,export_code,use_link,filter_query,facility_id,lu_field_name,use_default,default_value,aggre_function,sort_by,dept_sect_link,dept_sect_field,billing_link,active_yesno,substring_start,ctx_scrn_id,ctx_scrn_dataobject,ctx_column_name,ctx_lookup_type,module_type,ctx_uselink,ctx_linkfromcolumn,ctx_linktoscrnid,ctx_linktocolumn,ctx_linktoscrndw,ctx_column_datatype,export_fields_expression,drop_column,record_level) values(@rec_id + 5	, @export_id,	'Last_Recredential_Date'	,	8	,	'N'	,	'yyyymmdd'	,	'|'	,	'N'	,	43	,	100005	,	1	,	29	,	1	,	NULL	,	0	,	0	,	'pd_affil_stat.active_status = 1'	,	2	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	1	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	'D'	,	NULL	,	0	,	'C'	) ~r~n"+ &
"	insert export_fields(rec_id,export_id,export_field_name,export_field_length,export_fixed,export_format,trailing_leading_characters,export_required_field,intcred_table,intcred_field,intcred_record_number,export_order,export_type,field_value,export_code,use_link,filter_query,facility_id,lu_field_name,use_default,default_value,aggre_function,sort_by,dept_sect_link,dept_sect_field,billing_link,active_yesno,substring_start,ctx_scrn_id,ctx_scrn_dataobject,ctx_column_name,ctx_lookup_type,module_type,ctx_uselink,ctx_linkfromcolumn,ctx_linktoscrnid,ctx_linktocolumn,ctx_linktoscrndw,ctx_column_datatype,export_fields_expression,drop_column,record_level) values(@rec_id + 6	, @export_id,	'Next_Recredential_Date'	,	15	,	'N'	,	'yyyymmdd'	,	'|'	,	'N'	,	43	,	100004	,	1	,	30	,	1	,	NULL	,	0	,	0	,	'pd_affil_stat.active_status = 1'	,	2	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	1	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	'D'	,	NULL	,	0	,	'C'	) ~r~n"+ &
"	insert export_fields(rec_id,export_id,export_field_name,export_field_length,export_fixed,export_format,trailing_leading_characters,export_required_field,intcred_table,intcred_field,intcred_record_number,export_order,export_type,field_value,export_code,use_link,filter_query,facility_id,lu_field_name,use_default,default_value,aggre_function,sort_by,dept_sect_link,dept_sect_field,billing_link,active_yesno,substring_start,ctx_scrn_id,ctx_scrn_dataobject,ctx_column_name,ctx_lookup_type,module_type,ctx_uselink,ctx_linkfromcolumn,ctx_linktoscrnid,ctx_linktocolumn,ctx_linktoscrndw,ctx_column_datatype,export_fields_expression,drop_column,record_level) values(@rec_id + 7	, @export_id,	'Organization_ID'	,	15	,	'N'	,	'None'	,	'|'	,	'N'	,	0	,	0	,	0	,	34	,	2	,	'1234'	,	0	,	0	,	NULL	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	2	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	'S'	,	NULL	,	0	,	'C'	) ~r~n"+ &
"	insert export_fields(rec_id,export_id,export_field_name,export_field_length,export_fixed,export_format,trailing_leading_characters,export_required_field,intcred_table,intcred_field,intcred_record_number,export_order,export_type,field_value,export_code,use_link,filter_query,facility_id,lu_field_name,use_default,default_value,aggre_function,sort_by,dept_sect_link,dept_sect_field,billing_link,active_yesno,substring_start,ctx_scrn_id,ctx_scrn_dataobject,ctx_column_name,ctx_lookup_type,module_type,ctx_uselink,ctx_linkfromcolumn,ctx_linktoscrnid,ctx_linktocolumn,ctx_linktoscrndw,ctx_column_datatype,export_fields_expression,drop_column,record_level) values(@rec_id + 8	, @export_id,	'PO_Provider_ID'	,	15	,	'N'	,	'None'	,	'|'	,	'N'	,	25	,	95089	,	1	,	28	,	1	,	NULL	,	0	,	1	,	NULL	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	'S'	,	NULL	,	0	,	'C'	) ~r~n"+ &
"	insert export_fields(rec_id,export_id,export_field_name,export_field_length,export_fixed,export_format,trailing_leading_characters,export_required_field,intcred_table,intcred_field,intcred_record_number,export_order,export_type,field_value,export_code,use_link,filter_query,facility_id,lu_field_name,use_default,default_value,aggre_function,sort_by,dept_sect_link,dept_sect_field,billing_link,active_yesno,substring_start,ctx_scrn_id,ctx_scrn_dataobject,ctx_column_name,ctx_lookup_type,module_type,ctx_uselink,ctx_linkfromcolumn,ctx_linktoscrnid,ctx_linktocolumn,ctx_linktoscrndw,ctx_column_datatype,export_fields_expression,drop_column,record_level) values(@rec_id + 9	, @export_id,	'Provider_Address_City'	,	150	,	'N'	,	'None'	,	'|'	,	'N'	,	20	,	394	,	1	,	9	,	1	,	NULL	,	0	,	1	,	'pd_address_link.primary_office = 1'	,	2	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	'S'	,	NULL	,	NULL	,	'C'	) ~r~n"+ &
"	insert export_fields(rec_id,export_id,export_field_name,export_field_length,export_fixed,export_format,trailing_leading_characters,export_required_field,intcred_table,intcred_field,intcred_record_number,export_order,export_type,field_value,export_code,use_link,filter_query,facility_id,lu_field_name,use_default,default_value,aggre_function,sort_by,dept_sect_link,dept_sect_field,billing_link,active_yesno,substring_start,ctx_scrn_id,ctx_scrn_dataobject,ctx_column_name,ctx_lookup_type,module_type,ctx_uselink,ctx_linkfromcolumn,ctx_linktoscrnid,ctx_linktocolumn,ctx_linktoscrndw,ctx_column_datatype,export_fields_expression,drop_column,record_level) values(@rec_id + 10	, @export_id,	'Provider_Address_State'	,	2	,	'N'	,	'None'	,	'|'	,	'N'	,	20	,	395	,	1	,	10	,	1	,	NULL	,	0	,	1	,	'pd_address_link.primary_office = 1'	,	2	,	'Code'	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	'S'	,	NULL	,	NULL	,	'C'	) ~r~n"+ &
"	insert export_fields(rec_id,export_id,export_field_name,export_field_length,export_fixed,export_format,trailing_leading_characters,export_required_field,intcred_table,intcred_field,intcred_record_number,export_order,export_type,field_value,export_code,use_link,filter_query,facility_id,lu_field_name,use_default,default_value,aggre_function,sort_by,dept_sect_link,dept_sect_field,billing_link,active_yesno,substring_start,ctx_scrn_id,ctx_scrn_dataobject,ctx_column_name,ctx_lookup_type,module_type,ctx_uselink,ctx_linkfromcolumn,ctx_linktoscrnid,ctx_linktocolumn,ctx_linktoscrndw,ctx_column_datatype,export_fields_expression,drop_column,record_level) values(@rec_id + 11	, @export_id,	'Provider_Address_Zip'	,	5	,	'N'	,	'Numbers'	,	'|'	,	'N'	,	20	,	820	,	1	,	11	,	1	,	NULL	,	0	,	1	,	'pd_address_link.primary_office = 1'	,	2	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	'S'	,	NULL	,	NULL	,	'C'	) ~r~n"+ &
"	insert export_fields(rec_id,export_id,export_field_name,export_field_length,export_fixed,export_format,trailing_leading_characters,export_required_field,intcred_table,intcred_field,intcred_record_number,export_order,export_type,field_value,export_code,use_link,filter_query,facility_id,lu_field_name,use_default,default_value,aggre_function,sort_by,dept_sect_link,dept_sect_field,billing_link,active_yesno,substring_start,ctx_scrn_id,ctx_scrn_dataobject,ctx_column_name,ctx_lookup_type,module_type,ctx_uselink,ctx_linkfromcolumn,ctx_linktoscrnid,ctx_linktocolumn,ctx_linktoscrndw,ctx_column_datatype,export_fields_expression,drop_column,record_level) values(@rec_id + 12	, @export_id,	'Provider_Address_Zip_Extn'	,	1	,	'N'	,	'None'	,	'|'	,	'N'	,	0	,	0	,	0	,	12	,	2	,	NULL	,	0	,	0	,	'pd_address_link.primary_office = 1'	,	NULL	,	'Code'	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	'S'	,	NULL	,	NULL	,	'C'	) ~r~n"+ &
"	insert export_fields(rec_id,export_id,export_field_name,export_field_length,export_fixed,export_format,trailing_leading_characters,export_required_field,intcred_table,intcred_field,intcred_record_number,export_order,export_type,field_value,export_code,use_link,filter_query,facility_id,lu_field_name,use_default,default_value,aggre_function,sort_by,dept_sect_link,dept_sect_field,billing_link,active_yesno,substring_start,ctx_scrn_id,ctx_scrn_dataobject,ctx_column_name,ctx_lookup_type,module_type,ctx_uselink,ctx_linkfromcolumn,ctx_linktoscrnid,ctx_linktocolumn,ctx_linktoscrndw,ctx_column_datatype,export_fields_expression,drop_column,record_level) values(@rec_id + 13	, @export_id,	'Provider_Address1'	,	150	,	'N'	,	'None'	,	'|'	,	'N'	,	20	,	393	,	1	,	7	,	1	,	NULL	,	0	,	1	,	'pd_address_link.primary_office = 1'	,	2	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	'S'	,	NULL	,	NULL	,	'C'	) ~r~n"+ &
"	insert export_fields(rec_id,export_id,export_field_name,export_field_length,export_fixed,export_format,trailing_leading_characters,export_required_field,intcred_table,intcred_field,intcred_record_number,export_order,export_type,field_value,export_code,use_link,filter_query,facility_id,lu_field_name,use_default,default_value,aggre_function,sort_by,dept_sect_link,dept_sect_field,billing_link,active_yesno,substring_start,ctx_scrn_id,ctx_scrn_dataobject,ctx_column_name,ctx_lookup_type,module_type,ctx_uselink,ctx_linkfromcolumn,ctx_linktoscrnid,ctx_linktocolumn,ctx_linktoscrndw,ctx_column_datatype,export_fields_expression,drop_column,record_level) values(@rec_id + 14	, @export_id,	'Provider_Address2'	,	150	,	'N'	,	'None'	,	'|'	,	'N'	,	20	,	84922	,	1	,	8	,	1	,	NULL	,	0	,	1	,	'pd_address_link.primary_office = 1'	,	2	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	'S'	,	NULL	,	NULL	,	'C'	) ~r~n"+ &
"	insert export_fields(rec_id,export_id,export_field_name,export_field_length,export_fixed,export_format,trailing_leading_characters,export_required_field,intcred_table,intcred_field,intcred_record_number,export_order,export_type,field_value,export_code,use_link,filter_query,facility_id,lu_field_name,use_default,default_value,aggre_function,sort_by,dept_sect_link,dept_sect_field,billing_link,active_yesno,substring_start,ctx_scrn_id,ctx_scrn_dataobject,ctx_column_name,ctx_lookup_type,module_type,ctx_uselink,ctx_linkfromcolumn,ctx_linktoscrnid,ctx_linktocolumn,ctx_linktoscrndw,ctx_column_datatype,export_fields_expression,drop_column,record_level) values(@rec_id + 15	, @export_id,	'Provider_Birthdate'	,	15	,	'N'	,	'yyyymmdd'	,	'|'	,	'N'	,	25	,	272	,	1	,	17	,	1	,	NULL	,	0	,	0	,	NULL	,	NULL	,	'Entity_Name'	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	1	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	'D'	,	NULL	,	NULL	,	'C'	) ~r~n"+ &
"	insert export_fields(rec_id,export_id,export_field_name,export_field_length,export_fixed,export_format,trailing_leading_characters,export_required_field,intcred_table,intcred_field,intcred_record_number,export_order,export_type,field_value,export_code,use_link,filter_query,facility_id,lu_field_name,use_default,default_value,aggre_function,sort_by,dept_sect_link,dept_sect_field,billing_link,active_yesno,substring_start,ctx_scrn_id,ctx_scrn_dataobject,ctx_column_name,ctx_lookup_type,module_type,ctx_uselink,ctx_linkfromcolumn,ctx_linktoscrnid,ctx_linktocolumn,ctx_linktoscrndw,ctx_column_datatype,export_fields_expression,drop_column,record_level) values(@rec_id + 16	, @export_id,	'Provider_DEA'	,	10	,	'N'	,	'None'	,	'|'	,	'N'	,	6	,	9876	,	1	,	20	,	1	,	NULL	,	0	,	0	,	'pd_dea_state_csr.state = 90'	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	'S'	,	NULL	,	0	,	'C'	) ~r~n"+ &
"	insert export_fields(rec_id,export_id,export_field_name,export_field_length,export_fixed,export_format,trailing_leading_characters,export_required_field,intcred_table,intcred_field,intcred_record_number,export_order,export_type,field_value,export_code,use_link,filter_query,facility_id,lu_field_name,use_default,default_value,aggre_function,sort_by,dept_sect_link,dept_sect_field,billing_link,active_yesno,substring_start,ctx_scrn_id,ctx_scrn_dataobject,ctx_column_name,ctx_lookup_type,module_type,ctx_uselink,ctx_linkfromcolumn,ctx_linktoscrnid,ctx_linktocolumn,ctx_linktoscrndw,ctx_column_datatype,export_fields_expression,drop_column,record_level) values(@rec_id + 17	, @export_id,	'Provider_Email'	,	150	,	'N'	,	'None'	,	'|'	,	'N'	,	25	,	15002	,	1	,	15	,	1	,	NULL	,	0	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	'S'	,	NULL	,	NULL	,	'C'	) ~r~n"+ &
"	insert export_fields(rec_id,export_id,export_field_name,export_field_length,export_fixed,export_format,trailing_leading_characters,export_required_field,intcred_table,intcred_field,intcred_record_number,export_order,export_type,field_value,export_code,use_link,filter_query,facility_id,lu_field_name,use_default,default_value,aggre_function,sort_by,dept_sect_link,dept_sect_field,billing_link,active_yesno,substring_start,ctx_scrn_id,ctx_scrn_dataobject,ctx_column_name,ctx_lookup_type,module_type,ctx_uselink,ctx_linkfromcolumn,ctx_linktoscrnid,ctx_linktocolumn,ctx_linktoscrndw,ctx_column_datatype,export_fields_expression,drop_column,record_level) values(@rec_id + 18	, @export_id,	'Provider_Fax'	,	10	,	'N'	,	'Numbers'	,	'|'	,	'N'	,	20	,	803	,	1	,	14	,	1	,	NULL	,	0	,	1	,	'pd_address_link.primary_office = 1'	,	2	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	'S'	,	NULL	,	NULL	,	'C'	) ~r~n"+ &
"	insert export_fields(rec_id,export_id,export_field_name,export_field_length,export_fixed,export_format,trailing_leading_characters,export_required_field,intcred_table,intcred_field,intcred_record_number,export_order,export_type,field_value,export_code,use_link,filter_query,facility_id,lu_field_name,use_default,default_value,aggre_function,sort_by,dept_sect_link,dept_sect_field,billing_link,active_yesno,substring_start,ctx_scrn_id,ctx_scrn_dataobject,ctx_column_name,ctx_lookup_type,module_type,ctx_uselink,ctx_linkfromcolumn,ctx_linktoscrnid,ctx_linktocolumn,ctx_linktoscrndw,ctx_column_datatype,export_fields_expression,drop_column,record_level) values(@rec_id + 19	, @export_id,	'Provider_First_Name'	,	35	,	'N'	,	'None'	,	'|'	,	'N'	,	25	,	266	,	1	,	2	,	1	,	NULL	,	0	,	0	,	NULL	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	'S'	,	NULL	,	NULL	,	'C'	) ~r~n"+ &
"	insert export_fields(rec_id,export_id,export_field_name,export_field_length,export_fixed,export_format,trailing_leading_characters,export_required_field,intcred_table,intcred_field,intcred_record_number,export_order,export_type,field_value,export_code,use_link,filter_query,facility_id,lu_field_name,use_default,default_value,aggre_function,sort_by,dept_sect_link,dept_sect_field,billing_link,active_yesno,substring_start,ctx_scrn_id,ctx_scrn_dataobject,ctx_column_name,ctx_lookup_type,module_type,ctx_uselink,ctx_linkfromcolumn,ctx_linktoscrnid,ctx_linktocolumn,ctx_linktoscrndw,ctx_column_datatype,export_fields_expression,drop_column,record_level) values(@rec_id + 20	, @export_id,	'Provider_Gender'	,	1	,	'N'	,	'None'	,	'|'	,	'N'	,	25	,	274	,	1	,	6	,	1	,	NULL	,	0	,	0	,	NULL	,	NULL	,	'Code'	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	'S'	,	NULL	,	NULL	,	'C'	) ~r~n"+ &
"	insert export_fields(rec_id,export_id,export_field_name,export_field_length,export_fixed,export_format,trailing_leading_characters,export_required_field,intcred_table,intcred_field,intcred_record_number,export_order,export_type,field_value,export_code,use_link,filter_query,facility_id,lu_field_name,use_default,default_value,aggre_function,sort_by,dept_sect_link,dept_sect_field,billing_link,active_yesno,substring_start,ctx_scrn_id,ctx_scrn_dataobject,ctx_column_name,ctx_lookup_type,module_type,ctx_uselink,ctx_linkfromcolumn,ctx_linktoscrnid,ctx_linktocolumn,ctx_linktoscrndw,ctx_column_datatype,export_fields_expression,drop_column,record_level) values(@rec_id + 21	, @export_id,	'Provider_Last_Name'	,	100	,	'N'	,	'None'	,	'|'	,	'N'	,	25	,	267	,	1	,	4	,	1	,	NULL	,	0	,	0	,	NULL	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	'S'	,	NULL	,	0	,	'C'	) ~r~n"+ &
"	insert export_fields(rec_id,export_id,export_field_name,export_field_length,export_fixed,export_format,trailing_leading_characters,export_required_field,intcred_table,intcred_field,intcred_record_number,export_order,export_type,field_value,export_code,use_link,filter_query,facility_id,lu_field_name,use_default,default_value,aggre_function,sort_by,dept_sect_link,dept_sect_field,billing_link,active_yesno,substring_start,ctx_scrn_id,ctx_scrn_dataobject,ctx_column_name,ctx_lookup_type,module_type,ctx_uselink,ctx_linkfromcolumn,ctx_linktoscrnid,ctx_linktocolumn,ctx_linktoscrndw,ctx_column_datatype,export_fields_expression,drop_column,record_level) values(@rec_id + 22	, @export_id,	'Provider_License_Number'	,	40	,	'N'	,	'None'	,	'|'	,	'N'	,	22	,	336	,	1	,	26	,	1	,	NULL	,	0	,	1	,	'pd_license.active_status=1'	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	'S'	,	NULL	,	0	,	'C'	) ~r~n"+ &
"	insert export_fields(rec_id,export_id,export_field_name,export_field_length,export_fixed,export_format,trailing_leading_characters,export_required_field,intcred_table,intcred_field,intcred_record_number,export_order,export_type,field_value,export_code,use_link,filter_query,facility_id,lu_field_name,use_default,default_value,aggre_function,sort_by,dept_sect_link,dept_sect_field,billing_link,active_yesno,substring_start,ctx_scrn_id,ctx_scrn_dataobject,ctx_column_name,ctx_lookup_type,module_type,ctx_uselink,ctx_linkfromcolumn,ctx_linktoscrnid,ctx_linktocolumn,ctx_linktoscrndw,ctx_column_datatype,export_fields_expression,drop_column,record_level) values(@rec_id + 23	, @export_id,	'Provider_License_State'	,	2	,	'N'	,	'None'	,	'|'	,	'N'	,	22	,	330	,	1	,	25	,	1	,	NULL	,	0	,	1	,	'pd_license.active_status=1'	,	NULL	,	'Code'	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	'S'	,	NULL	,	0	,	'C'	) ~r~n"+ &
"	insert export_fields(rec_id,export_id,export_field_name,export_field_length,export_fixed,export_format,trailing_leading_characters,export_required_field,intcred_table,intcred_field,intcred_record_number,export_order,export_type,field_value,export_code,use_link,filter_query,facility_id,lu_field_name,use_default,default_value,aggre_function,sort_by,dept_sect_link,dept_sect_field,billing_link,active_yesno,substring_start,ctx_scrn_id,ctx_scrn_dataobject,ctx_column_name,ctx_lookup_type,module_type,ctx_uselink,ctx_linkfromcolumn,ctx_linktoscrnid,ctx_linktocolumn,ctx_linktoscrndw,ctx_column_datatype,export_fields_expression,drop_column,record_level) values(@rec_id + 24	, @export_id,	'Provider_Middle_Name'	,	20	,	'N'	,	'None'	,	'|'	,	'N'	,	25	,	268	,	1	,	3	,	1	,	NULL	,	0	,	0	,	NULL	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	'S'	,	NULL	,	NULL	,	'C'	) ~r~n"+ &
"	insert export_fields(rec_id,export_id,export_field_name,export_field_length,export_fixed,export_format,trailing_leading_characters,export_required_field,intcred_table,intcred_field,intcred_record_number,export_order,export_type,field_value,export_code,use_link,filter_query,facility_id,lu_field_name,use_default,default_value,aggre_function,sort_by,dept_sect_link,dept_sect_field,billing_link,active_yesno,substring_start,ctx_scrn_id,ctx_scrn_dataobject,ctx_column_name,ctx_lookup_type,module_type,ctx_uselink,ctx_linkfromcolumn,ctx_linktoscrnid,ctx_linktocolumn,ctx_linktoscrndw,ctx_column_datatype,export_fields_expression,drop_column,record_level) values(@rec_id + 25	, @export_id,	'Provider_Name_Suffix'	,	6	,	'N'	,	'None'	,	'|'	,	'N'	,	25	,	270	,	1	,	5	,	1	,	NULL	,	0	,	0	,	NULL	,	NULL	,	'Code'	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	'N'	,	NULL	,	NULL	,	'C'	) ~r~n"+ &
"	insert export_fields(rec_id,export_id,export_field_name,export_field_length,export_fixed,export_format,trailing_leading_characters,export_required_field,intcred_table,intcred_field,intcred_record_number,export_order,export_type,field_value,export_code,use_link,filter_query,facility_id,lu_field_name,use_default,default_value,aggre_function,sort_by,dept_sect_link,dept_sect_field,billing_link,active_yesno,substring_start,ctx_scrn_id,ctx_scrn_dataobject,ctx_column_name,ctx_lookup_type,module_type,ctx_uselink,ctx_linkfromcolumn,ctx_linktoscrnid,ctx_linktocolumn,ctx_linktoscrndw,ctx_column_datatype,export_fields_expression,drop_column,record_level) values(@rec_id + 26	, @export_id,	'Provider_NPI'	,	10	,	'N'	,	'None'	,	'|'	,	'N'	,	25	,	200612	,	1	,	24	,	1	,	NULL	,	0	,	1	,	NULL	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	'S'	,	NULL	,	0	,	'C'	) ~r~n"+ &
"	insert export_fields(rec_id,export_id,export_field_name,export_field_length,export_fixed,export_format,trailing_leading_characters,export_required_field,intcred_table,intcred_field,intcred_record_number,export_order,export_type,field_value,export_code,use_link,filter_query,facility_id,lu_field_name,use_default,default_value,aggre_function,sort_by,dept_sect_link,dept_sect_field,billing_link,active_yesno,substring_start,ctx_scrn_id,ctx_scrn_dataobject,ctx_column_name,ctx_lookup_type,module_type,ctx_uselink,ctx_linkfromcolumn,ctx_linktoscrnid,ctx_linktocolumn,ctx_linktoscrndw,ctx_column_datatype,export_fields_expression,drop_column,record_level) values(@rec_id + 27	, @export_id,	'Provider_Phone'	,	10	,	'N'	,	'Numbers'	,	'|'	,	'N'	,	20	,	801	,	1	,	13	,	1	,	NULL	,	0	,	1	,	'pd_address_link.primary_office = 1'	,	2	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	'S'	,	NULL	,	NULL	,	'C'	) ~r~n"+ &
"	insert export_fields(rec_id,export_id,export_field_name,export_field_length,export_fixed,export_format,trailing_leading_characters,export_required_field,intcred_table,intcred_field,intcred_record_number,export_order,export_type,field_value,export_code,use_link,filter_query,facility_id,lu_field_name,use_default,default_value,aggre_function,sort_by,dept_sect_link,dept_sect_field,billing_link,active_yesno,substring_start,ctx_scrn_id,ctx_scrn_dataobject,ctx_column_name,ctx_lookup_type,module_type,ctx_uselink,ctx_linkfromcolumn,ctx_linktoscrnid,ctx_linktocolumn,ctx_linktoscrndw,ctx_column_datatype,export_fields_expression,drop_column,record_level) values(@rec_id + 28	, @export_id,	'Provider_Practice_State'	,	2	,	'N'	,	'None'	,	'|'	,	'N'	,	22	,	330	,	1	,	16	,	1	,	NULL	,	0	,	0	,	'pd_license.active_status = 1'	,	NULL	,	'Code'	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	1	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	'S'	,	NULL	,	NULL	,	'C'	) ~r~n"+ &
"	insert export_fields(rec_id,export_id,export_field_name,export_field_length,export_fixed,export_format,trailing_leading_characters,export_required_field,intcred_table,intcred_field,intcred_record_number,export_order,export_type,field_value,export_code,use_link,filter_query,facility_id,lu_field_name,use_default,default_value,aggre_function,sort_by,dept_sect_link,dept_sect_field,billing_link,active_yesno,substring_start,ctx_scrn_id,ctx_scrn_dataobject,ctx_column_name,ctx_lookup_type,module_type,ctx_uselink,ctx_linkfromcolumn,ctx_linktoscrnid,ctx_linktocolumn,ctx_linktoscrndw,ctx_column_datatype,export_fields_expression,drop_column,record_level) values(@rec_id + 29	, @export_id,	'Provider_SSN'	,	9	,	'N'	,	'Numbers'	,	'|'	,	'N'	,	25	,	273	,	1	,	18	,	1	,	NULL	,	0	,	0	,	NULL	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	'S'	,	NULL	,	NULL	,	'C'	) ~r~n"+ &
"	insert export_fields(rec_id,export_id,export_field_name,export_field_length,export_fixed,export_format,trailing_leading_characters,export_required_field,intcred_table,intcred_field,intcred_record_number,export_order,export_type,field_value,export_code,use_link,filter_query,facility_id,lu_field_name,use_default,default_value,aggre_function,sort_by,dept_sect_link,dept_sect_field,billing_link,active_yesno,substring_start,ctx_scrn_id,ctx_scrn_dataobject,ctx_column_name,ctx_lookup_type,module_type,ctx_uselink,ctx_linkfromcolumn,ctx_linktoscrnid,ctx_linktocolumn,ctx_linktoscrndw,ctx_column_datatype,export_fields_expression,drop_column,record_level) values(@rec_id + 30	, @export_id,	'Provider_Tax_ID'	,	30	,	'N'	,	'None'	,	'|'	,	'N'	,	20	,	398	,	1	,	23	,	1	,	NULL	,	0	,	1	,	'pd_address_link.primary_office = 1'	,	2	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	'S'	,	NULL	,	0	,	'C'	) ~r~n"+ &
"	insert export_fields(rec_id,export_id,export_field_name,export_field_length,export_fixed,export_format,trailing_leading_characters,export_required_field,intcred_table,intcred_field,intcred_record_number,export_order,export_type,field_value,export_code,use_link,filter_query,facility_id,lu_field_name,use_default,default_value,aggre_function,sort_by,dept_sect_link,dept_sect_field,billing_link,active_yesno,substring_start,ctx_scrn_id,ctx_scrn_dataobject,ctx_column_name,ctx_lookup_type,module_type,ctx_uselink,ctx_linkfromcolumn,ctx_linktoscrnid,ctx_linktocolumn,ctx_linktoscrndw,ctx_column_datatype,export_fields_expression,drop_column,record_level) values(@rec_id + 31	, @export_id,	'Provider_Type'	,	30	,	'N'	,	'None'	,	'|'	,	'N'	,	25	,	271	,	1	,	22	,	1	,	NULL	,	0	,	0	,	NULL	,	NULL	,	'Code'	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	'S'	,	NULL	,	0	,	'C'	) ~r~n"+ &
"	insert export_fields(rec_id,export_id,export_field_name,export_field_length,export_fixed,export_format,trailing_leading_characters,export_required_field,intcred_table,intcred_field,intcred_record_number,export_order,export_type,field_value,export_code,use_link,filter_query,facility_id,lu_field_name,use_default,default_value,aggre_function,sort_by,dept_sect_link,dept_sect_field,billing_link,active_yesno,substring_start,ctx_scrn_id,ctx_scrn_dataobject,ctx_column_name,ctx_lookup_type,module_type,ctx_uselink,ctx_linkfromcolumn,ctx_linktoscrnid,ctx_linktocolumn,ctx_linktoscrndw,ctx_column_datatype,export_fields_expression,drop_column,record_level) values(@rec_id + 32	, @export_id,	'Provider_UPIN'	,	6	,	'N'	,	'None'	,	'|'	,	'N'	,	13	,	171	,	1	,	21	,	1	,	NULL	,	0	,	0	,	'pd_other_ids.id_type = 140778'	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	'S'	,	NULL	,	0	,	'C'	) ~r~n"+ &
"	insert export_fields(rec_id,export_id,export_field_name,export_field_length,export_fixed,export_format,trailing_leading_characters,export_required_field,intcred_table,intcred_field,intcred_record_number,export_order,export_type,field_value,export_code,use_link,filter_query,facility_id,lu_field_name,use_default,default_value,aggre_function,sort_by,dept_sect_link,dept_sect_field,billing_link,active_yesno,substring_start,ctx_scrn_id,ctx_scrn_dataobject,ctx_column_name,ctx_lookup_type,module_type,ctx_uselink,ctx_linkfromcolumn,ctx_linktoscrnid,ctx_linktocolumn,ctx_linktoscrndw,ctx_column_datatype,export_fields_expression,drop_column,record_level) values(@rec_id + 33	, @export_id,	'Region_ID'	,	15	,	'N'	,	'None'	,	'E'	,	'N'	,	0	,	0	,	0	,	35	,	2	,	NULL	,	0	,	0	,	NULL	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	2	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	'S'	,	NULL	,	0	,	'C'	) ~r~n"+ &
"	insert export_fields(rec_id,export_id,export_field_name,export_field_length,export_fixed,export_format,trailing_leading_characters,export_required_field,intcred_table,intcred_field,intcred_record_number,export_order,export_type,field_value,export_code,use_link,filter_query,facility_id,lu_field_name,use_default,default_value,aggre_function,sort_by,dept_sect_link,dept_sect_field,billing_link,active_yesno,substring_start,ctx_scrn_id,ctx_scrn_dataobject,ctx_column_name,ctx_lookup_type,module_type,ctx_uselink,ctx_linkfromcolumn,ctx_linktoscrnid,ctx_linktocolumn,ctx_linktoscrndw,ctx_column_datatype,export_fields_expression,drop_column,record_level) values(@rec_id + 34	, @export_id,	'Short_SSN'	,	2	,	'N'	,	'Numbers'	,	'|'	,	'N'	,	25	,	273	,	1	,	19	,	1	,	NULL	,	0	,	0	,	NULL	,	NULL	,	NULL	,	0	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	0	,	NULL	,	8	,	NULL	,	NULL	,	NULL	,	NULL	,	1	,	NULL	,	NULL	,	NULL	,	NULL	,	NULL	,	'S'	,	NULL	,	NULL	,	'C'	) ~r~n"+ &
"End "

Sqlca.AutoCommit = False

EXECUTE Immediate :ls_sql Using Sqlca;
IF Sqlca.SQLCode <> 0 THEN
	ls_err =  String(sqlca.sqlerrtext)
	Rollback using sqlca;
	Sqlca.AutoCommit = True
	Messagebox("Create Export","Failed. SQL Error text: " + ls_err)
	RETURN -1
Else
	COMMIT Using Sqlca;
	Sqlca.AutoCommit = True
	Messagebox("Create Export","Finished. The Export 'CAQH Roster Submission' has been added. ~r~nPlease check it in Setup - Export Setup." )
	
	//Refresh Exports dddw for idw_export.
	of_get_exports() 
END IF


RETURN 1


end event

type tab_1 from tab within w_caqh_roster_setup
integer x = 37
integer y = 104
integer width = 2473
integer height = 1100
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_basic tabpage_basic
tabpage_export tabpage_export
tabpage_ftp tabpage_ftp
end type

on tab_1.create
this.tabpage_basic=create tabpage_basic
this.tabpage_export=create tabpage_export
this.tabpage_ftp=create tabpage_ftp
this.Control[]={this.tabpage_basic,&
this.tabpage_export,&
this.tabpage_ftp}
end on

on tab_1.destroy
destroy(this.tabpage_basic)
destroy(this.tabpage_export)
destroy(this.tabpage_ftp)
end on

event selectionchanged;//====================================================================
//$<Event>: selectionchanged
//$<Arguments>:
// 	value    integer    oldindex
// 	value    integer    newindex
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 01.11.2016 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

If newindex = 2 Then //Export
	cb_ce.visible = True
Else
	cb_ce.visible = False
End If
end event

type tabpage_basic from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2437
integer height = 984
long backcolor = 33551856
string text = "Basic"
long tabtextcolor = 33554432
long tabbackcolor = 32891346
long picturemaskcolor = 536870912
dw_basic dw_basic
end type

on tabpage_basic.create
this.dw_basic=create dw_basic
this.Control[]={this.dw_basic}
end on

on tabpage_basic.destroy
destroy(this.dw_basic)
end on

type dw_basic from u_dw within tabpage_basic
integer x = 32
integer y = 24
integer width = 2391
integer height = 932
integer taborder = 40
string dataobject = "d_caqh_roster_set_basic"
end type

event itemchanged;call super::itemchanged;//====================================================================
//$<Event>: itemchanged
//$<Arguments>:
// 	value    long        row
// 	value    dwobject    dwo
// 	value    string      data
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

ib_changed = true
end event

event pfc_validation;call super::pfc_validation;//====================================================================
//$<Event>: pfc_validation
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Check basic settings.
//$<Author>: (Appeon) long.zhang 01.21.2016 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
String ls_col, ls_value
String ls_error
Int i

For i = 1 to 2
	ls_col = idw_basic.GetItemString(i, 'item_1')
	ls_value = idw_basic.GetItemString(i, 'value_1')
	
	//Required
	If ls_col = 'Organization ID' Then
		If IsNull(ls_value) or Trim(ls_value) = '' Then
			ls_error = ls_col +' is required (Format: 99999).'
			Messagebox('Basic Validation', ls_error)
			this.SetFocus()
			Return -1
		End If
	End If
	
	//Format (99999)
	If LenA(ls_value) > 0 Then
		If Not Match(ls_value,	'^[0-9][0-9][0-9][0-9][0-9]$') Then
			ls_error = ls_col +' is invalid (Format: 99999).'
			Messagebox('Basic Validation', ls_error)
			this.SetFocus()
			Return -1
		End If
	End If
Next


Return 1
end event

type tabpage_export from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2437
integer height = 984
long backcolor = 33551856
string text = "Export"
long tabtextcolor = 33554432
long tabbackcolor = 32891346
long picturemaskcolor = 536870912
cb_1 cb_1
cb_run cb_run
dw_export_sql dw_export_sql
dw_export dw_export
end type

on tabpage_export.create
this.cb_1=create cb_1
this.cb_run=create cb_run
this.dw_export_sql=create dw_export_sql
this.dw_export=create dw_export
this.Control[]={this.cb_1,&
this.cb_run,&
this.dw_export_sql,&
this.dw_export}
end on

on tabpage_export.destroy
destroy(this.cb_1)
destroy(this.cb_run)
destroy(this.dw_export_sql)
destroy(this.dw_export)
end on

type cb_1 from commandbutton within tabpage_export
integer x = 41
integer y = 828
integer width = 453
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Paste Sample SQL"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

String named
named = "Select distinct prac_id from pd_basic where prac_id in (1,2,3,4,5);"
	
idw_export_sql.setitem(1,"expression",named)
end event

type cb_run from commandbutton within tabpage_export
integer x = 512
integer y = 828
integer width = 485
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Test Export"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: Test Export.
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

integer err
integer li_export

cb_save.triggerevent(clicked!)

of_run_export()


end event

type dw_export_sql from u_dw within tabpage_export
integer x = 37
integer y = 304
integer width = 2368
integer height = 492
integer taborder = 10
string dataobject = "d_caqh_roster_set_export_sql"
end type

event itemchanged;call super::itemchanged;//====================================================================
//$<Event>: itemchanged
//$<Arguments>:
// 	value    long        row
// 	value    dwobject    dwo
// 	value    string      data
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

ib_changed = true
end event

type dw_export from u_dw within tabpage_export
integer x = 37
integer y = 20
integer width = 2368
integer height = 216
integer taborder = 20
string dataobject = "d_caqh_roster_set_export"
end type

event itemchanged;call super::itemchanged;//====================================================================
//$<Event>: itemchanged
//$<Arguments>:
// 	value    long        row
// 	value    dwobject    dwo
// 	value    string      data
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

ib_changed = true
end event

type tabpage_ftp from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2437
integer height = 984
long backcolor = 33551856
string text = "SFTP"
long tabtextcolor = 33554432
long tabbackcolor = 32891346
long picturemaskcolor = 536870912
cb_2 cb_2
dw_ftp dw_ftp
end type

on tabpage_ftp.create
this.cb_2=create cb_2
this.dw_ftp=create dw_ftp
this.Control[]={this.cb_2,&
this.dw_ftp}
end on

on tabpage_ftp.destroy
destroy(this.cb_2)
destroy(this.dw_ftp)
end on

type cb_2 from commandbutton within tabpage_ftp
integer x = 78
integer y = 828
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Test SFTP"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: Test FTP Settings.
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

str_ftp_parms lstr_parms
String ls_hostname
String ls_port
String ls_username
String ls_password

cb_save.triggerevent(clicked!)

//Check values
ls_hostname = Trim(idw_ftp.getItemString(1,'value_1'))
If IsNull(ls_hostname) or ls_hostname = '' Then
	Messagebox("SFTP","Hostname is required.")
	Return
End If

ls_port = Trim(idw_ftp.getItemString(1,'value_2'))
If IsNull(ls_port) or ls_port = '' Then
	Messagebox("SFTP","Port is required.")
	Return
End If

ls_username = Trim(idw_ftp.getItemString(1,'value_3'))
If IsNull(ls_username) or ls_username = '' Then
	Messagebox("SFTP","Username is required.")
	Return
End If

ls_password = Trim(idw_ftp.getItemString(1,'value_4'))
If IsNull(ls_password) or ls_password = '' Then
	Messagebox("SFTP","Password is required.")
	Return
End If

//Open FTP test window
lstr_parms.hostname = ls_hostname
lstr_parms.port = ls_port
lstr_parms.protocol = 1 //SFTP
lstr_parms.login = ls_username
lstr_parms.password = ls_password

OpenWithParm(w_ftp_set,lstr_parms)



end event

type dw_ftp from u_dw within tabpage_ftp
integer x = 78
integer y = 104
integer width = 1550
integer height = 648
integer taborder = 20
string dataobject = "d_caqh_roster_set_sftp"
boolean vscrollbar = false
boolean livescroll = false
end type

event retrieveend;call super::retrieveend;//====================================================================
//$<Event>: retrieveend
//$<Arguments>:
// 	value    long    rowcount
//$<Return>:  long
//$<Description>: Set the decrypt password
//$<Author>: (Appeon) long.zhang 07.08.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

String	ls_Password
long		ll_Cycle

SetPointer(HourGlass!)

 ll_Cycle = 1
ls_Password = This.GetItemString(ll_Cycle,"value_4")
if IsNull(ls_Password) then Return 0

ls_Password = in_encrypt.of_Decrypt(ls_Password)
This.SetItem(ll_Cycle,"value_4",ls_Password)
This.SetItemStatus(ll_Cycle,"value_4",Primary!,NotModified!)

SetPointer(Arrow!)

end event

event updateend;call super::updateend;//====================================================================
//$<Event>: updateend
//$<Arguments>:
// 	value    long    rowsinserted
// 	value    long    rowsupdated
// 	value    long    rowsdeleted
//$<Return>:  long
//$<Description>: Deal with sftp password.
//$<Author>: (Appeon) long.zhang 07.08.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

String	ls_InputPass,ls_DBPass
String ls_stype
long		ll_Cycle,ll_Count,ll_ID

SetPointer(HourGlass!)

ll_Cycle = 1

ls_stype = 'SFTP'

SELECT value_4 INTO :ls_DBPass FROM caqh_roster_setting WHERE stype = :ls_stype ;

ls_InputPass = This.GetItemString(ll_Cycle,"value_4")
if IsNull(ls_InputPass) then
	if Not IsNull(ls_DBPass) then
		UPDATE caqh_roster_setting SET value_4 = NULL WHERE stype = :ls_stype ;
	end if
else
	ls_InputPass = in_encrypt.of_Encrypt(ls_InputPass)
	if IsNull(ls_DBPass) or ls_InputPass <> ls_DBPass then
		UPDATE caqh_roster_setting SET value_4 = :ls_InputPass WHERE stype = :ls_stype ;
	end if
end if


if SQLCA.SQLCode = 0 then
	COMMIT USING SQLCA;
else
	MessageBox(gnv_app.iapp_object.DisplayName,SQLCA.SQLErrText,StopSign!)
	ROLLBACK USING SQLCA;
end if

SetPointer(Arrow!)
end event

event itemchanged;call super::itemchanged;//====================================================================
//$<Event>: itemchanged
//$<Arguments>:
// 	value    long        row
// 	value    dwobject    dwo
// 	value    string      data
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
ib_changed = true
end event

type cb_save from commandbutton within w_caqh_roster_setup
integer x = 1952
integer y = 16
integer width = 265
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
parent.triggerevent( "pfc_save")
end event

type cb_close from commandbutton within w_caqh_roster_setup
integer x = 2258
integer y = 16
integer width = 265
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

close(parent)
end event

