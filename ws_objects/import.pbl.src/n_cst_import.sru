$PBExportHeader$n_cst_import.sru
forward
global type n_cst_import from nonvisualobject
end type
end forward

global type n_cst_import from nonvisualobject
event ue_importprocess ( long al_import_id )
event ue_main ( long al_import_id )
event ue_getimportdata ( long al_import_id,  ref boolean ab_doprocess )
event ue_createcomputefield ( )
event ue_formatdata ( )
event ue_updatelog ( )
event ue_generateerrorfile ( )
event ue_sendemail ( )
event ue_saveerrorfile ( )
event ue_complete ( )
end type
global n_cst_import n_cst_import

type variables
// Import information datastore
n_import_ds ids_import_hdr     //Recordset from import_hdr table
n_import_ds ids_table_record   //Recordset from sys_tables and import_table_records table
n_import_ds ids_import_field   //Recordset from import_file_fields table
n_import_ds ids_mapping_field  //Recordset from sys_fields and import_mapping_fields table
n_import_ds ids_lookup_mapping //Recordset from import_lu_map_fields table
n_import_ds ids_dataview_screen

// Error log datastore
n_import_ds ids_log_proc
n_import_ds ids_log_table
n_import_ds ids_log_error
long il_ErrorCount

// Import data datastore
n_import_ds ids_imp_data
n_import_ds ids_intellisoft_table
n_import_ds ids_intellisoft_table_temp
n_import_ds ids_newrow

//---------Begin Modified by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
/*
// Code lookup datastore
DataStore ids_address_lookup
DataStore ids_code_lookup
DataStore ids_facility
DataStore ids_committee
DataStore ids_company
DataStore ids_active_status
DataStore ids_qa_metrics
DataStore ids_coderownum1
DataStore ids_coderownum2

// Security datastore
DataStore ids_security_role
DataStore ids_category_right
DataStore ids_user
DataStore ids_security_user_dept
*/
// Code lookup datastore
n_import_ds ids_address_lookup
n_import_ds ids_code_lookup
n_import_ds ids_facility
n_import_ds ids_committee
n_import_ds ids_company
n_import_ds ids_active_status
n_import_ds ids_qa_metrics
n_import_ds ids_coderownum1
n_import_ds ids_coderownum2

// Security datastore
n_import_ds ids_security_role
n_import_ds ids_category_right
n_import_ds ids_user
n_import_ds ids_security_user_dept
//---------End Modfiied ------------------------------------------------------

// Control variables
long il_CurrTableAddCount
long il_CurrTableModifyCount
long il_StatusAutoAddCount
long il_user_depart_id
boolean ib_IsExecute1
boolean ib_IsDoPrompt
boolean is_OldAutoCommit
boolean ib_IsCodeLookupChanged = false
string  is_lookup_name[]

// Constant variables
constant long IL_ERRTYPE_OTHER          = 0
constant long IL_ERRTYPE_MAPDESIGN      = 1
constant long IL_ERRTYPE_VERIFYVALUE    = 2
constant long IL_ERRTYPE_DATAINTEGRITY  = 3
constant long IL_ERRTYPE_ADDVERIFY      = 4
constant long IL_ERRTYPE_UPDATE         = 5
constant long IL_MAX_ERRORCOUNT         = 100

constant string IS_ID_FIELD  = "find_field"
constant string IS_KEY_FIELD = "find_field"
constant string IS_LOG_NAME  = "Import error log.txt"

n_cst_message inv_message //scheduler - alfee 02.06.2010
Boolean ib_schedule = false //scheduler - alfee 02.25.201

//V12.3 Import Logging modifications --Stephen 12.25.2012
string is_new_prac[]
string is_prac_name[]
string is_table_name
integer ii_new, ii_modify
long   il_prac_id[]
long  il_hdr_id
datetime  idt_CurrentTime
boolean ib_import_audit 
boolean ib_pro_steps = false
n_import_ds ids_audit_log_table
n_import_ds ids_imp_audit_hdr, ids_imp_audit_item
n_import_ds ids_preprocess
datastore ids_sys_field_type, ids_imp_audit_item_temp  

//(Appeon)Stephen 03.19.2015 - V15.1-Import Improvements 2015
integer  ii_curr_isoft_module
boolean ib_isg_key
end variables

forward prototypes
public function blob of_readfile (string as_file)
public function integer of_getfrmfieldvalue (string as_record, string as_delimiter, ref string as_value[])
public function boolean of_iscontinue ()
public function integer of_formatcase (long al_row, string as_field, string as_casetype)
public function integer of_formatstrip (long al_row, string as_field, string as_striptype)
public function integer of_formatfield (long al_row, string as_field, string as_format)
public subroutine of_completetrans (boolean ab_iscommit)
public function string of_getimportdir ()
public function integer of_getimportinfo (long al_import_id, boolean ab_isimport)
public function integer of_dyncreateimportdw (ref datastore ads_data)
public function string of_getimportdata (long al_import_id, ref datastore ads_imp_data)
public function string of_verifyimportfield (ref datastore ads_import_field)
public function integer of_setdefaultvalue (ref datastore ads_imp_data)
public function integer of_execute (long al_import_id, ref datawindow adw_data)
public function integer of_retrievelookupmapping ()
public function integer of_dataprocess ()
public function integer of_retrievelookupdata (long al_lu_template, string as_lu_type, string as_lu_table)
public function integer of_disposeverifyvalue (string as_importvalue, string as_field_type, integer ai_field_len, ref string as_charvalue, ref decimal adc_decvalue, ref datetime adt_dtvalue)
public function integer of_dataupdate ()
public function integer of_datapopulate ()
public function integer of_dyncreateistabledw (string as_table_name)
public function integer of_postupdate ()
public function integer of_preupdate ()
public function integer of_setsequenceno (ref datastore ads_sequence, ref datastore ads_intellisoft_table, long al_addcount, string as_filterfield, string as_updatefield, boolean ab_flag)
public function integer of_checkmapping (boolean ab_isimport, long al_table_id, string as_table_name, ref datastore ads_import_field, ref datastore ads_mapping_field, ref string as_errortext[])
public function integer of_setautocommit (boolean ab_isauto)
public function string of_reviseexpvalue (string as_value)
public function integer of_addcontractcategoryright (long al_category)
public function integer of_disposelookupcode (long al_importdatarow, integer ai_mapfieldindex, string as_importvalue, string as_field_type, integer ai_no_match_procd, string as_lu_type, string as_lu_table, string as_lu_field_name)
public function integer of_resetcodevalue (long al_row, integer ai_column, string as_field_type, long al_lookup_code)
public function integer of_updatelookuptable (integer ai_islookupfield, integer ai_mapfieldindex, string as_field_type)
public function integer of_disposelookupcode (long al_importdatarow, integer ai_mapfieldindex, string as_importvalue, string as_field_type, integer ai_no_match_procd)
public function integer of_disposenullvalue (integer ai_null_type, long al_importdatarow, integer ai_mapfieldindex, ref string as_importvalue)
public function string of_convertfieldalias (string as_string)
public function integer of_run_project (integer ai_project, string as_from)
public function integer of_execute (long al_import_id, boolean ab_isdoprompt)
public function integer of_getkeyfields (ref integer as_keyfieldindex[], ref string as_keyfieldname[])
public function integer of_log (string as_text)
public function long of_log (long al_error_record, string as_error_field, long al_err_type, string as_err_value)
public function integer of_log (boolean ab_isimport, string as_text, ref string as_errortext[])
public function integer of_resetfieldtype ()
public function string of_checkimporttable (ref datastore ads_data)
public function string of_generateerrortitle (ref datastore ads_data, long al_row)
public function string of_generateerrordetail (ref datastore ads_data, long al_row)
public function string of_addspace (any aa_value, integer ai_len)
public function boolean of_isstopimport ()
public function integer of_cacheforeignkey (string as_imp_field, string as_table_field)
public function integer of_gettablekey (string as_table_name, ref string as_key[])
public function integer of_modifyupdateproperty (datastore ads_data, string as_table_name)
public function integer of_addsecuritydepartment (long al_department_id)
public function string of_get_sched_msg ()
public function integer of_get_sched_cnt ()
public function integer of_set_sched_flag (boolean ab_flag)
public function integer of_formatdatefield (long al_row, string as_field)
public function integer of_getkeyfields_new (ref integer as_keyfieldindex[], ref string as_keyfieldname[], ref string as_importfieldname[])
public function string of_getimport_pracname (datastore ads_imp_data, long al_row)
public function integer of_import_store_hdr (long al_import_id, long al_table_id, string as_table_name, long al_record_id)
public function integer of_import_audit_start ()
public function integer of_dyncreate_auditdw (n_import_ds ads_audit_table, string as_table_name, string as_fields)
public function string of_readfile_str (string as_file)
public function integer of_save_import_audit (long al_import_id, integer ai_type)
public function integer of_import_store_item (long al_import_id, long al_table_id, string as_table_name, long al_hdr_id, string as_table_alias, long al_table_records_id)
public function integer of_check_import_data (long al_row, integer ai_col, ref string as_field_value)
public function integer of_preprocess_msg (string as_type, string as_msg)
public function string of_reviseexpvalue (string as_value, boolean ab_lower)
public function integer of_preprocess_imp_data (long al_imp, ref datastore adw_data, datastore adw_pre, string as_from)
public function integer of_isg_key (integer ai_table_id, string as_field_name)
public function integer of_sql_autorun (long al_imp_id, string as_b_f)
public function string of_get_no_data_error (integer ai_return)
end prototypes

event ue_importprocess(long al_import_id);integer li_Return
integer li_TableIndex
string  ls_table_name
string  ls_filter_exp
string  ls_ErrorText[]
long ll_table_id
long ll_table_records_id
//---------Begin Added by (Appeon)Stephen 03.20.2015 for V15.1-Import Improvements 2015--------
integer li_key
long ll_row
long ll_sql_auto_run
string ls_field_name
//---------End Added ------------------------------------------------------

// Filter file data according to filter expression settings
//----------------------------- APPEON BEGIN ----------------------------
//$<add> Evan 07.26.2011
//$<reason> Date range settings (V11.3 QA Import)
//$<remark> The date data must be formated (see ue_formatdata)
ls_filter_exp = ids_import_hdr.object.filter_exp[ids_import_hdr.getrow()]
if Len(ls_filter_exp) > 0 then
	ids_imp_data.of_Filter(ls_filter_exp)
	ids_log_proc.object.rec_count[1] = ids_imp_data.RowCount()
end if
//----------------------------- APPEON END ------------------------------

if of_import_audit_start() = -1 then return  //add by stephen 01.31.2013 -- Dynamic create import_audit datastore --V12.3 Import Logging modifications

//---------Begin Added by (Appeon)Stephen 04.17.2015 for V15.1-Import Improvements 2015--------
ll_sql_auto_run = ids_import_hdr.object.sql_auto_run[ids_import_hdr.getrow()]
if ll_sql_auto_run = 1 then
	if of_sql_autorun(al_import_id, 'B') = -1 THEN	RETURN
end if
//---------End Added ------------------------------------------------------

// Import external data into per IntelliSoft Table
for li_TableIndex = 1 to ids_table_record.RowCount()
	// Set progress bar
	w_import_progressbar.of_ReduceRemainCount()
	w_import_progressbar.of_SetTableName(ids_table_record.object.table_name_allias[li_TableIndex])
	w_import_progressbar.of_SetImportProcessDesc("Initialization")
	w_import_progressbar.of_SetMaxPosition(4)
	
	// Initialization
	il_CurrTableAddCount = 0
	il_CurrTableModifyCount = 0
	il_StatusAutoAddCount = 0
	ids_table_record.SetRow(li_TableIndex)
	ids_log_table.SetRow(li_TableIndex)
	ll_table_id = ids_table_record.object.isoft_table_id[li_TableIndex]
	ls_table_name = Lower(ids_table_record.object.table_name[li_TableIndex])
	is_table_name = 	ls_table_name //(Appeon)Stephen 03.05.2014 - Import time-out
		
	// Pre-storage mapping fields(filter mapping fields)
	ll_table_records_id = ids_table_record.object.table_records_id[li_TableIndex]
	ids_mapping_field.of_Filter("table_records_id=" + String(ll_table_records_id))
	
	//---------Begin Added by (Appeon)Stephen 03.20.2015 for V15.1-Import Improvements 2015--------
	ib_isg_key = false
	for ll_row = 1 to ids_mapping_field.rowcount()
		li_key = ids_mapping_field.getitemnumber(ll_row, 'key_field')
		if li_key = 1 then
			ls_field_name = ids_mapping_field.getitemstring(ll_row, 'field_name')
			if of_isg_key(ll_table_id, ls_field_name) = 1 then
				ib_isg_key = true
				exit
			end if
		end if
	next
     //---------End Added ------------------------------------------------------
	  
	// Check mapped relationship
	li_Return = of_CheckMapping(true, ll_table_id, ls_table_name, ids_import_field, ids_mapping_field, ls_ErrorText[])
	if li_Return = -1 then
		Return
	elseif li_Return = -2 then
		Continue
	end if
	w_import_progressbar.of_SkipNextPosition()
	
	// Dynamic create updatable and temporary DataWindow
	li_Return = of_DynCreateIstableDW(ls_table_name)
	if li_Return = -1 then
		Return
	elseif li_Return = -2 then
		Continue
	end if
	w_import_progressbar.of_SkipNextPosition()
	
	// Reset type of field
	of_ResetFieldType()
	w_import_progressbar.of_SkipNextPosition()
	
	// Pre-storage lookup mapping records
	of_RetrieveLookupMapping()
	w_import_progressbar.of_SkipNextPosition()
	
    	//------------------- APPEON BEGIN -------------------
	//$<add> Stephen 12.28.2012
	//$<reason> V12.3 Import Logging modifications
	if ib_import_audit then
		li_Return = of_import_store_hdr(al_import_id, ll_table_id, ls_table_name, ll_table_records_id) 
		if li_Return = -1 then
			ib_import_audit = false
			return
		elseif li_Return = 1 then
			if of_save_import_audit(al_import_id, 1) = -1 then return //(Appeon)Stephen 2013-07-23 - large import file issues
			continue
		else
			ib_import_audit = false
		end if
	end if
	w_import_progressbar.of_SkipNextPosition()
	//------------------- APPEON END -------------------
		
	// Process import data
	if of_DataProcess() = -1 then Return
	
	// Populate import data
	if of_DataPopulate() = -1 then Return
	
	// Update import data
	if of_DataUpdate() = -1 then Return
next

//------------------- APPEON BEGIN -------------------
//$<add> Stephen 01.10.2013
//$<reason> V12.3 Import Logging modifications
if 	ib_import_audit then
	of_save_import_audit(al_import_id, 0)
end if
//------------------- APPEON END -------------------	
end event

event ue_main(long al_import_id);integer i
long ll_sql_auto_run
string  ls_Error
string ls_Syntax
boolean lb_DoProcess = true

////////////////////////////////[Import prepare]///////////////////////////////
// Set auto commit as false
is_OldAutoCommit = SQLCA.AutoCommit
of_SetAutoCommit(false)

// Create log records
ids_log_proc.InsertRow(0)
ids_log_proc.object.import_id[1] = al_import_id
ids_log_proc.object.pro_date[1] = DateTime(Today(), Now())
if ids_table_record.RowCount() > 0 then
	for i = 1 to ids_table_record.RowCount()
		ids_log_table.InsertRow(0)
		ids_log_table.object.table_records_id[i] = ids_table_record.object.table_records_id[i]
		ids_log_table.object.table_name_allias[i] = ids_table_record.object.table_name_allias[i]
		ids_log_table.object.error_count[i] = 0
		ids_log_table.object.error_count[i] = 0
		ids_log_table.object.mod_count[i] = 0
		ids_log_table.object.add_count[i] = 0
	next
end if

// Check import table
ls_Error = of_CheckImportTable(ids_table_record)
if LenA(ls_Error) > 0 then
	lb_DoProcess = false
	of_Log(ls_Error)
end if

////////////////////////////////[Import Process]/////////////////////////////
// 1.Get import data
this.Event ue_GetImportData(al_import_id, lb_DoProcess)
w_import_progressbar.of_SkipNextStep()

//---------Begin Added by (Appeon)Stephen 12.26.2013 for V141 Import Modifications for Facility and Group--------
//Run Preprocess Steps
if ib_schedule and ib_pro_steps then
	if ids_preprocess.rowcount() > 0 then
		if of_preprocess_imp_data(al_import_id, ids_imp_data, ids_preprocess, "Sche") <> 1 then 
			if isvalid(w_import_progressbar) then
				w_import_progressbar.cb_close.Enabled = true
				close(w_import_progressbar)
			end if
			return
		end if
	end if
end if
//---------End Added ------------------------------------------------------

// 2.Create compute fields
if lb_DoProcess then this.Event ue_CreateComputeField()
w_import_progressbar.of_SkipNextStep()

// 3.Format import data
if lb_DoProcess then this.Event ue_FormatData()
w_import_progressbar.of_SkipNextStep()

// 4.Import data into IntelliSoft table
if lb_DoProcess then this.Event ue_ImportProcess(al_import_id)
w_import_progressbar.of_SetImportProcessDesc("")
w_import_progressbar.of_SkipNextStep()

//---------Begin Added by (Appeon)Stephen 04.17.2015 for V15.1-Import Improvements 2015--------
ll_sql_auto_run = ids_import_hdr.object.sql_auto_run[ids_import_hdr.getrow()]
if ll_sql_auto_run = 1 then
	if of_sql_autorun(al_import_id, 'A') = -1 THEN 
		Rollback using sqlca;
		RETURN
	else //(Appeon)Stephen 07.22.2016 -  Import post-import script is not triggering
		Commit using sqlca;
	END IF
end if
//---------End Added ------------------------------------------------------

// 5.Generate error file
this.Event ue_GenerateErrorFile()
w_import_progressbar.of_SkipNextStep()

// 6.Send email
this.Event ue_SendEmail()
w_import_progressbar.of_SkipNextStep()

// 7.Save error file
this.Event ue_SaveErrorFile()
w_import_progressbar.of_SkipNextStep()

// 8.Update log
this.Event ue_UpdateLog()
w_import_progressbar.of_SkipNextStep()

////////////////////////////////[Import Complete]/////////////////////////////
this.Event ue_Complete()
of_SetAutoCommit(true)
end event

event ue_getimportdata(long al_import_id, ref boolean ab_doprocess);string ls_ErrorText

// Get import data
if ab_DoProcess then
	if ib_IsExecute1 then
		ls_ErrorText = of_GetImportData(al_import_id, ids_imp_data)
		if LenA(ls_ErrorText) > 0 then
			of_Log(ls_ErrorText)
			ab_DoProcess = false
		end if
	end if
end if

// Log records count
ids_log_proc.object.rec_count[1] = ids_imp_data.RowCount()

inv_message.of_set_proc_cnt(ids_log_proc.object.rec_count[1])  //Added by Nova 01.25.2010 - v10.1 Scheduler Functionality

if ids_imp_data.RowCount() <= 0 then ab_DoProcess = false
end event

event ue_createcomputefield();string  ls_Create
string  ls_Error
string  ls_comp_def
string  ls_imp_field_name
string  ls_Expression
string  ls_Char
integer li_Len
integer i, li_Pos

// Set process bar
w_import_progressbar.of_SetMaxPosition(ids_import_field.RowCount())

// Create compute field
for i = 1 to ids_import_field.RowCount()	
	ls_comp_def = Trim(ids_import_field.object.comp_def[i])	
	if LenA(ls_comp_def) > 0 then						
		// Convert expression
		ls_Expression = ""
		li_Len = LenA(ls_comp_def)
		for li_Pos = 1 to li_Len
			ls_Char = MidA(ls_comp_def, li_Pos, 1)
			if ls_Char = '"' then
				ls_Expression += '~~"'
			elseif ls_Char = '~~' then
				ls_Expression += '~~~~'
			else
				ls_Expression += ls_Char
			end if
		next
		
		// Create compute field
		ls_Expression = "String(" + ls_Expression + ")"
		ls_imp_field_name = Trim(ids_import_field.object.imp_field_name[i])
		ls_Create = 'create compute(band=detail alignment="0" expression="' + ls_Expression + '" border="0" color="0" x="100000" y="8" height="64" width="375" format="[GENERAL]" name=' + ls_imp_field_name + ' visible="1"  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="553648127")'
		ls_Error = ids_imp_data.Modify(ls_Create)
		
		//ll_xPos = Long(ids_imp_data.Describe(ls_imp_field_name + ".x"))
		//ls_Create = 'create text(band=header alignment="2" text="' + ls_imp_field_name + '" border="0" color="33554432" x="' + String(ll_xPos) + '" y="8" height="52" width="375" name=' + ls_imp_field_name + '_t visible="1"  font.face="Segoe UI" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="1" background.color="536870912" )'
		//ids_imp_data.Modify(ls_Create)
	end if
	w_import_progressbar.of_SkipNextPosition()
next
end event

event ue_formatdata();long    i, ll_Row
integer li_Column
integer li_FieldCount
long    ll_RowCount
string  ls_imp_field_name
string  ls_field_format
string  ls_case_type
string  ls_strip_type
string  ls_comp_def
string  ls_filter_exp
string  ls_NullArr[]
string  ls_Fields[]
string  ls_Records[]
string  ls_DateFields[]
integer li_DateFieldCount
integer li_Rcount, li_Fcount
n_cst_string lnv_string	
boolean lb_DoFormat1
boolean lb_DoFormat2
boolean lb_DoFormat3
boolean lb_DoFormat4

// Set process bar
ll_RowCount = ids_imp_data.RowCount()
li_FieldCount = ids_import_field.RowCount()
w_import_progressbar.of_SetMaxPosition(li_FieldCount)

// Get date fields according to filter expression settings
//----------------------------- APPEON BEGIN ----------------------------
//$<add> Evan 07.26.2011
//$<reason> Date range settings (V11.3 QA Import)
ls_filter_exp = ids_import_hdr.object.filter_exp[ids_import_hdr.getrow()]
if Len(ls_filter_exp) > 0 then
	lnv_string.of_ParseToArray(ls_filter_exp, "and", ls_Records[])
	li_Rcount = UpperBound(ls_Records)
	for i = 1 to li_Rcount
		lnv_string.of_ParseToArray(Trim(ls_Records[i]), " ", ls_Fields[])
		li_Fcount = UpperBound(ls_Fields)
		if li_Fcount > 0 then
			li_DateFieldCount ++
			ls_DateFields[li_DateFieldCount] = Trim(ls_Fields[1])
		end if
		ls_Fields[] = ls_NullArr[]
	next
end if
//----------------------------- APPEON END ------------------------------

// Format import data
for li_Column = 1 to li_FieldCount
	w_import_progressbar.of_SkipNextPosition()
	
	// Continue if field is compute field
	ls_comp_def = Trim(ids_import_field.object.comp_def[li_Column])
	if LenA(ls_comp_def) > 0 then Continue
	
	// Get format information
	ls_imp_field_name = Trim(ids_import_field.object.imp_field_name[li_Column])
	ls_field_format = Trim(ids_import_field.object.field_format[li_Column])
	ls_case_type = Trim(ids_import_field.object.case_type[li_Column])
	ls_strip_type = Trim(ids_import_field.object.strip_type[li_Column])
	
	lb_DoFormat1 = false
	lb_DoFormat2 = false
	lb_DoFormat3 = false
	lb_DoFormat4 = false
	if LenA(ls_strip_type) > 0 then lb_DoFormat1 = true
	if LenA(ls_case_type) > 0 then lb_DoFormat2 = true
	if LenA(ls_field_format) > 0 then
		lb_DoFormat3 = true
		w_import_temp.of_SetMask(ls_field_format)
	end if
	for i = 1 to li_DateFieldCount // evan 07.26.2011 (V11.3 QA Import)
		if Lower(ls_imp_field_name) = Lower(ls_DateFields[i]) then
			lb_DoFormat4 = true
			exit
		end if
	next

	// Format data
	if lb_DoFormat1 or lb_DoFormat2 or lb_DoFormat3 or lb_DoFormat4 then
		for ll_Row = 1 to ll_RowCount
			if lb_DoFormat1 then
				of_FormatStrip(ll_Row, ls_imp_field_name, ls_strip_type)
			end if
			if lb_DoFormat2 then
				of_FormatCase(ll_Row, ls_imp_field_name, ls_case_type)
			end if
			if lb_DoFormat3 then
				of_FormatField(ll_Row, ls_imp_field_name, ls_field_format)
			end if
			if lb_DoFormat4 then // evan 07.26.2011 (V11.3 QA Import)
				of_FormatDateField(ll_Row, ls_imp_field_name)
			end if
		next
	end if
	Yield() // evan 07.11.2011
next
end event

event ue_updatelog();long ll_Row
long ll_process_id
long i, ll_InsertRow

//Set process bar
w_import_progressbar.of_SetMaxPosition(2)
w_import_progressbar.of_SkipNextPosition()

//Update log
if ids_log_proc.Update() = 1 then
	yield()
	ll_process_id = ids_log_proc.object.process_id[1]
	
	//------------------- APPEON BEGIN -------------------
	//$<add> Stephen 12.28.2012
	//$<reason> V12.3 Import Logging modifications
	if not(isnull(il_hdr_id) or il_hdr_id = 0) then
		update import_audit_hdr
			  set Process_id = :ll_process_id
			where Hdr_id = :il_hdr_id;  	
	    
		for i = 1 to ids_audit_log_table.RowCount()
			ids_audit_log_table.object.process_id[i] = ll_process_id
		next	
		ids_audit_log_table.update()
		yield()
	end if
	//------------------- APPEON END -------------------
	
	for i = 1 to ids_log_table.RowCount()
		ids_log_table.object.process_id[i] = ll_process_id
		yield()
	next	
	if ids_log_table.Update() = 1 then
		yield()
		for i = 1 to ids_log_error.RowCount()
			ll_Row = ids_log_error.object.process_tables_id[i]
			ids_log_error.object.process_tables_id[i] = ids_log_table.object.process_tables_id[ll_Row]
			yield()
		next
		if ids_log_error.Update() = 1 then
			yield()
			of_CompleteTrans(true)
		else
			of_CompleteTrans(false)
		end if
	else
		of_CompleteTrans(false)
	end if
else
	of_CompleteTrans(false)
end if

w_import_progressbar.of_SkipNextPosition()
end event

event ue_generateerrorfile();long i, j
string ls_Error
string ls_FileName
string ls_ImportDirectory
integer li_FileNum

// Get error file name
ls_ImportDirectory = of_GetImportDir()
ls_FileName = ls_ImportDirectory + "\" + IS_LOG_NAME

// Open file
FileDelete(ls_FileName)
if ids_log_error.RowCount() <= 0 then Return
li_FileNum = FileOpen(ls_FileName, LineMode!, Write!, LockWrite!, Replace!)
w_import_progressbar.of_SetMaxPosition(ids_log_table.RowCount())

// Write error file
for i = 1 to ids_log_table.RowCount()
	if i > 1 then FileWrite(li_FileNum, "~r~n")
	ls_Error = of_GenerateErrorTitle(ids_log_table, i)
	FileWrite(li_FileNum, ls_Error)
	FileWrite(li_FileNum, "-------------------------------------------------------------------------------------------------------------------------------------------------")
	FileWrite(li_FileNum, "Record Number  Import Field  Eror Type     Error Message")
	ids_log_error.of_Filter("process_tables_id=" + String(i))
	yield()
	for j = 1 to ids_log_error.RowCount()
		ls_Error = of_GenerateErrorDetail(ids_log_error, j)
		FileWrite(li_FileNum, ls_Error)
		yield()
	next
	FileWrite(li_FileNum, "-------------------------------------------------------------------------------------------------------------------------------------------------")
	yield()
	w_import_progressbar.of_SkipNextPosition()
next
ids_log_error.of_Filter("")
FileClose(li_FileNum)
end event

event ue_sendemail();integer i
string  ls_SumTitle
string  ls_err_value
string  ls_FileName
string  ls_import_name
string  ls_notify_addr1
string  ls_notify_addr2
string  ls_MailTo
string  ls_MailCc
string  ls_MailBcc
string  ls_Message
string  ls_Subject
string  ls_Attachments
string  ls_Addresser
datetime ldt_pro_date
n_cst_easymail_smtp lnv_mail

//Set process bar
w_import_progressbar.of_SetMaxPosition(2)
w_import_progressbar.of_SkipNextPosition()

//Check whether send mail
if ids_import_hdr.object.err_notify[ids_import_hdr.GetRow()] = 0 then Return

//Set address
ls_notify_addr1 = Trim(ids_import_hdr.object.notify_addr1[ids_import_hdr.GetRow()])
ls_notify_addr2 = Trim(ids_import_hdr.object.notify_addr2[ids_import_hdr.GetRow()])
if LenA(ls_notify_addr1) > 0 then
	ls_MailTo = ls_notify_addr1
end if
if LenA(ls_notify_addr2) > 0 then
	if LenA(ls_MailTo) > 0 then ls_MailTo += ";"
	ls_MailTo += ls_notify_addr2
end if
if LenA(ls_MailTo) <= 0 then Return

//Set subject                                            
ls_import_name = Trim(ids_import_hdr.object.import_name[ids_import_hdr.GetRow()])
if IsNull(ls_import_name) then ls_import_name = "unknown"
ls_Subject = "Import notification for " + ls_import_name

//Set message and attachment
ldt_pro_date = ids_log_proc.object.pro_date[ids_log_proc.GetRow()]
ls_err_value = ids_log_proc.object.err_value[ids_import_hdr.GetRow()]
if LenA(ls_err_value) > 0 then
	ls_Message = "The import '" + ls_import_name + "' ran on " + String(ldt_pro_date) + ". Import process is terminated, due to the following error:~r~n"
	ls_Message += ls_err_value	
else	
	if il_ErrorCount > 0 and ids_import_hdr.object.err_file[ids_import_hdr.GetRow()] = 1 then
		ls_Attachments = of_GetImportDir() + "\" + IS_LOG_NAME
		ls_Message = "Attached is an error file for import '" + ls_import_name + "' run on " + String(ldt_pro_date) + ". The following are summaries.~r~n~r~n"
	else
		ls_Message = "The import '" + ls_import_name + "' ran on " + String(ldt_pro_date) + ". The following are summaries.~r~n~r~n"
	end if
	for i = 1 to ids_log_table.RowCount()
		ls_SumTitle = "[Record id: " + String(ids_log_table.object.table_records_id[i]) + ", "
		ls_SumTitle += "IntelliSoft Table: " + ids_log_table.object.table_name_allias[i] + "]"
		ls_Message += of_AddSpace(ls_SumTitle, 76) + "~r~n"
		ls_Message += "Runtime Error Count: " + String(ids_log_table.object.error_count[i]) + "~r~n"
		ls_Message += "Modify Record Count: " + String(ids_log_table.object.mod_count[i]) + "~r~n"
		ls_Message += "Add Record Count: " + String(ids_log_table.object.add_count[i]) + "~r~n~r~n"
	next
end if

//Send email
if lnv_mail.of_CreateObject() = 1 then
	//START---Modify by Evan 2008-03-24 (Reasion:Send email with current user account)
	/*
	select top 1 set_addresser into :ls_Addresser from icred_settings;
	if IsNull(ls_Addresser) or Trim(ls_Addresser) = "" then
		ls_Addresser = "MASTER"
	end if
	lnv_mail.of_SendText(ls_Addresser, ls_MailTo, ls_MailCc, ls_MailBcc, ls_Subject, ls_Message, ls_Attachments)
	*/
	lnv_mail.of_SendText(gs_user_id, ls_MailTo, ls_MailCc, ls_MailBcc, ls_Subject, ls_Message, ls_Attachments)
	//END---Modify by Evan 2008-03-24
	lnv_mail.of_DeleteObject()
end if
w_import_progressbar.of_SkipNextPosition()
end event

event ue_saveerrorfile();blob lblb_File
long ll_process_id
integer li_err_file
string  ls_FileName

//Set process bar
w_import_progressbar.of_SetMaxPosition(2)
w_import_progressbar.of_SkipNextPosition()

//Dispose error file according to err_file
li_err_file = ids_import_hdr.object.err_file[ids_import_hdr.GetRow()]
choose case li_err_file
	case 1 //Send with notification
	case 2 //Save file
		ll_process_id = ids_log_proc.object.process_id[ids_log_proc.GetRow()]
		ls_FileName = of_GetImportDir() + "\" + IS_LOG_NAME
		lblb_File = of_ReadFile(ls_FileName)
			
		UPDATEBLOB import_process SET process_file = :lblb_File WHERE process_id = :ll_process_id;
		if SQLCA.SQLCode = 0 then
			of_CompleteTrans(true)
		else
			of_CompleteTrans(false)
		end if
	case 3 //Delete
	case else
end choose
w_import_progressbar.of_SkipNextPosition()
end event

event ue_complete();integer i
string ls_NullArray[]

// Import information datastore reset
ids_import_hdr.Reset()
ids_table_record.Reset()
ids_import_field.Reset()
ids_mapping_field.Reset()
ids_lookup_mapping.Reset()
ids_dataview_screen.Reset()

// Error log datastore reset
ids_log_proc.Reset()
ids_log_table.Reset()
ids_log_error.Reset()

// Import data datastore reset
ids_imp_data.Reset()
ids_intellisoft_table.Reset()
ids_intellisoft_table_temp.Reset()
ids_newrow.Reset()

// Code lookup datastore reset
ids_address_lookup.Reset()
ids_code_lookup.Reset()
ids_facility.Reset()
ids_committee.Reset()
ids_company.Reset()
ids_active_status.Reset() //V10.1 - Import Active Status
ids_qa_metrics.Reset()    //V11.3 QA Import
ids_coderownum1.Reset()
ids_coderownum2.Reset()
ids_security_role.Reset()
ids_category_right.Reset()
ids_user.Reset()
ids_security_user_dept.Reset()

// Refresh global data if Code or Address lookup data have been changed
if ib_IsCodeLookupChanged then
	gnv_appeondb.of_StartQueue()
	gnv_data.of_Retrieve("code_lookup")
	gnv_data.of_Retrieve("code_lookup_2")
	gnv_appeondb.of_CommitQueue()
end if
for i = 1 to UpperBound(is_lookup_name)
	gnv_app.of_setcontraccache_code_lookup(is_lookup_name[i])
next
ib_IsCodeLookupChanged = false
is_lookup_name[] = ls_NullArray[]

// The import process complete
w_import_progressbar.of_SetComplete()
end event

public function blob of_readfile (string as_file);blob lblb_Data
blob lblb_Buf
long ll_Byte
integer li_FileNum

li_FileNum = FileOpen(as_File, StreamMode!, Read!, Shared!)
if li_FileNum = -1 then 
	SetNull(lblb_Data)
	Return lblb_Data
end if

do
	ll_Byte = FileRead(li_FileNum, lblb_Buf)
	if ll_Byte > 0 then
		lblb_Data += lblb_Buf
	else
		Exit
	end if
loop while true
FileClose(li_FileNum)

Return lblb_Data
end function

public function integer of_getfrmfieldvalue (string as_record, string as_delimiter, ref string as_value[]);long ll_Index
long ll_OldFieldPos
long ll_NewFieldPos
long ll_DelimiterLen
string ls_FieldValue
boolean lb_Exit = false

ll_OldFieldPos = 1
if Lower(as_Delimiter) = "enter" then
	as_Delimiter = "~r~n"
elseif Lower(as_Delimiter) = "tab" then
	as_Delimiter = "~t"
end if
ll_DelimiterLen = LenA(as_Delimiter)

do
	ll_NewFieldPos = PosA(as_Record, as_Delimiter, ll_OldFieldPos)
	if ll_NewFieldPos > 0 then
		ls_FieldValue = MidA(as_Record, ll_OldFieldPos, ll_NewFieldPos - ll_OldFieldPos)
		ll_OldFieldPos = ll_NewFieldPos + ll_DelimiterLen
		ll_Index ++
		as_Value[ll_Index] = ls_FieldValue
	else
		ls_FieldValue = RightA(as_Record, LenA(as_Record) - ll_OldFieldPos + 1)
		if LenA(ls_FieldValue) > 0 then
			ll_Index ++
			as_Value[ll_Index] = ls_FieldValue
		end if
		lb_Exit = true
	end if
loop until lb_Exit

Return ll_Index
end function

public function boolean of_iscontinue ();String ls_ErrorMessage

IF gb_AutoSchedule or ib_schedule THEN RETURN True //Added by Nova 01.25.2010 - v10.1 Scheduler Functionality

IF ib_IsDoPrompt = False THEN RETURN True

IF il_ErrorCount > IL_MAX_ERRORCOUNT THEN
	ib_IsDoPrompt = False
	ls_ErrorMessage = "Error count is over " + String(IL_MAX_ERRORCOUNT) + ". Do you want to continue?"
	
	//------------------- APPEON BEGIN -------------------
	//$<modify> Evan 05.03.2011
	//$<reason> Msg parent must be w_import_progressbar
	//IF MessageBox("Prompt", ls_ErrorMessage, Question!, YesNo!) = 2 THEN RETURN False	
	IF IsValid(w_import_progressbar) then
		IF w_import_progressbar.of_MessageBox("Prompt", ls_ErrorMessage, 36) = 7 THEN RETURN False
	END IF
	//------------------- APPEON END ---------------------
END IF

RETURN True

end function

public function integer of_formatcase (long al_row, string as_field, string as_casetype);string ls_Char
string ls_OldValue
string ls_NewValue
integer li_OldPos
integer li_NewPos
integer li_Len

ls_OldValue = ids_imp_data.GetItemString(al_Row, as_Field)
li_Len = LenA(ls_OldValue)

if li_Len > 0 then
	choose case as_CaseType
		case "1" //Upper
			ls_NewValue = Upper(ls_OldValue)		
		case "2" //Lower
			ls_NewValue = Lower(ls_OldValue)		
		case "3" //First Upper
			if li_Len > 0 then
				ls_Char = LeftA(ls_OldValue, 1)
				ls_NewValue = Upper(ls_Char) + RightA(ls_OldValue, li_Len - 1)
				li_OldPos = 1
				do
					li_NewPos = PosA(ls_NewValue, " ", li_OldPos + 1)
					if li_NewPos > 0 and li_NewPos + 1 <= li_Len then
						ls_Char = MidA(ls_NewValue, li_NewPos + 1, 1)
						ls_NewValue = LeftA(ls_NewValue, li_NewPos) + Lower(ls_Char) + RightA(ls_NewValue, li_Len - li_NewPos - 1)
					end if
					li_OldPos = li_NewPos
				loop while li_NewPos > 0
			end if		
		case "4" //Initial Cap		
			if li_Len > 0 then
				ls_Char = LeftA(ls_OldValue, 1)
				ls_NewValue = Upper(ls_Char) + RightA(ls_OldValue, li_Len - 1)
				li_OldPos = 1
				do
					li_NewPos = PosA(ls_NewValue, " ", li_OldPos + 1)
					if li_NewPos > 0 and li_NewPos + 1 <= li_Len then
						ls_Char = MidA(ls_NewValue, li_NewPos + 1, 1)
						ls_NewValue = LeftA(ls_NewValue, li_NewPos) + Upper(ls_Char) + RightA(ls_NewValue, li_Len - li_NewPos - 1)
					end if
					li_OldPos = li_NewPos
				loop while li_NewPos > 0
			end if
		case else
			Return -1
	end choose
	ids_imp_data.SetItem(al_Row, as_Field, ls_NewValue)
end if

Return 1
end function

public function integer of_formatstrip (long al_row, string as_field, string as_striptype);string ls_Char
string ls_OldValue
string ls_NewValue
integer i, li_Len
string ls_Numeric = "0123456789"
string ls_Alpha = "qwertyuiopasdfghjklzxcvbnm"

ls_OldValue = ids_imp_data.GetItemString(al_Row, as_Field)
li_Len = LenA(ls_OldValue)

if li_Len > 0 then
	choose case as_StripType
		case "1" //Alpha Only
			for i = 1 to li_Len
				ls_Char = MidA(ls_OldValue, i, 1)
				if PosA(ls_Alpha, Lower(ls_Char)) > 0 then
					ls_NewValue += ls_Char
				end if
			next
		case "2" //Numeric Only
			for i = 1 to li_Len
				ls_Char = MidA(ls_OldValue, i, 1)
				if PosA(ls_Numeric, ls_Char) > 0 then
					ls_NewValue += ls_Char
				end if
			next
		case "3" //strip spaces//Start Code Change ----03.11.2009 #V92 maha - added type process
			ls_NewValue = of_strip_char(" ", ls_OldValue ,"")
			if ls_NewValue = "//" then ls_NewValue = "" //Start Code Change ----03.19.2009 #V92 maha - added trap
		case else
			Return -1
	end choose
	ids_imp_data.SetItem(al_Row, as_Field, ls_NewValue)
end if

Return 1
end function

public function integer of_formatfield (long al_row, string as_field, string as_format);string ls_Char
string ls_OldValue
string ls_NewValue

ls_OldValue = ids_imp_data.GetItemString(al_Row, as_Field)

if LenA(ls_OldValue) > 0 then	
	ls_NewValue = w_import_temp.of_Format(ls_OldValue)
	ids_imp_data.SetItem(al_Row, as_Field, ls_NewValue)
end if

Return 1
end function

public subroutine of_completetrans (boolean ab_iscommit);if SQLCA.AutoCommit = true then Return

if ab_IsCommit then
	Commit;
else
	Rollback;
end if
end subroutine

public function string of_getimportdir ();string ls_OldDirectory
string ls_ImportDirectory
string ls_IntelliCredDirectory

ls_IntelliCredDirectory = gs_dir_path + gs_DefDirName
ls_ImportDirectory = ls_IntelliCredDirectory + "\Import"
ls_OldDirectory = GetCurrentDirectory()

if DirectoryExists(ls_IntelliCredDirectory) = false then	
	ChangeDirectory(gs_dir_path)
	if CreateDirectory("IntelliCred") = -1 then Return ""
end if

if DirectoryExists(ls_ImportDirectory) = false then		
	ChangeDirectory(ls_IntelliCredDirectory)
	if CreateDirectory("Import") = -1 then Return ""
end if

ChangeDirectory(ls_OldDirectory)

Return ls_ImportDirectory
end function

public function integer of_getimportinfo (long al_import_id, boolean ab_isimport);long ll_FindRow
long ll_RowCount
long i, j, ll_isoft_table_id
long ll_table_records_id[]
string ls_sql, ls_Syntax
string ls_synerr, ls_Error

if not ab_IsImport then
	gnv_appeondb.of_StartQueue()
	ids_import_hdr.Retrieve(al_import_id)
	ids_import_field.Retrieve(al_import_id)
	gnv_appeondb.of_CommitQueue()
	Return 1
end if

///////////////////////////////////////////////////////////////////////////
//Cache data
gnv_appeondb.of_StartQueue()
//Retrieve import information
ids_import_hdr.Retrieve(al_import_id)
ids_table_record.Retrieve(al_import_id)
ids_import_field.Retrieve(al_import_id)
//Retrieve data view screen information
ids_dataview_screen.Retrieve(1)
//Retrieve security role
ids_security_role.Retrieve()
//Retrieve user
ids_user.Retrieve()

//---------Begin Added by (Appeon)Stephen 12.26.2013 for V141 Import Modifications for Facility and Group--------
if ib_schedule and ib_pro_steps then
	ids_preprocess.retrieve(al_import_id)
end if
//---------End Added ------------------------------------------------------

gnv_appeondb.of_CommitQueue()

//Retrieve data of ids_mapping_field
for i = 1 to ids_table_record.RowCount()
	ll_table_records_id[i] = ids_table_record.object.table_records_id[i]
next
ids_mapping_field.Retrieve(ll_table_records_id)

Return 1
end function

public function integer of_dyncreateimportdw (ref datastore ads_data);String  ls_Error
String  ls_Syntax
String  ls_comp_def
String  ls_imp_field_name
String  ls_Fields
String  ls_Name
String  ls_Style
String  ls_SQLSelect
Long    ll_PosX
Integer i, li_FieldCount

//Build select SQL for import datawindow
li_FieldCount = ids_import_field.RowCount()
IF li_FieldCount <= 0 THEN RETURN -1

FOR i = 1 To li_FieldCount
	ls_comp_def = Trim(ids_import_field.Object.comp_def[i])
	IF LenA(ls_comp_def) > 0  THEN CONTINUE
	ls_imp_field_name = Trim(ids_import_field.Object.imp_field_name[i])
	IF LenA(ls_Fields) > 0 THEN ls_Fields += ","
	ls_Fields += 'field_1 "' + ls_imp_field_name + '"'
NEXT
IF ls_Fields = "" THEN RETURN -1
//---------Begin Modified by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
//ls_SQLSelect = "SELECT " + ls_Fields + ",0 sys_pc_id, 0 sys_facility_id, 0 sys_contact_id FROM import_table_gen"//modify gavins 20130222
ls_SQLSelect = "SELECT " + ls_Fields + ",0 sys_pc_id, 0 sys_facility_id, 0 sys_contact_id, 0 sys_hdr_id FROM import_table_gen"
//---------End Modfiied ------------------------------------------------------

//openwithparm(w_sql_msg,ls_sqlselect )

//Dynamic create import datawindow
ls_Syntax = SQLCA.SyntaxFromSQL(ls_SQLSelect, "Style(Type=Grid)", ls_Error)
IF LenA(ls_Error) > 0 THEN
		//MessageBox("Error in of_dyncreateimportdw",ls_Error) //Start Code Change ----01.23.2008 #V8 maha - added for a useful error
		inv_message.of_MessageBox("Error in of_dyncreateimportdw",ls_Error,true)//Added by Nova 01.25.2010 - v10.1 Scheduler Functionality
		RETURN -1
END IF
ads_data.Create(ls_Syntax, ls_Error)
IF LenA(ls_Error) > 0 THEN
	RETURN -1
END IF
ads_data.Modify("sys_pc_id.visible=0")
ads_data.Modify("sys_facility_id.visible=0")
ads_data.Modify("sys_contact_id.visible=0")
ads_data.Modify("sys_hdr_id.visible=0") //(Appeon)Harry 01.23.2014 - V142 ISG-CLX

RETURN 1

end function

public function string of_getimportdata (long al_import_id, ref datastore ads_imp_data);string  ls_Error
string  ls_Syntax
blob    lblb_data
long    ll_NewFieldPos
long    ll_OldFieldPos
long    ll_OldDelimiterPos
long    ll_DelimiterLen
long    i, ll_Return
long    ll_FindRow
long    ll_InsertRow
long    ll_NewDelimiterPos
string  ls_Record
string  ls_FieldValue[]
string  ls_FormattedText
string  ls_imp_format
string  ls_odbc_name
string  ls_odbc_login
string  ls_odbc_password
string  ls_import_sql
string  ls_imp_file
long    ll_ignore_header_row
string  ls_record_delimiter
string  ls_field_delimiter
string  ls_filter_exp
integer li_ColCount
integer li_FieldCount
DataStore lds_odbc_data
Transaction ltr_trans
boolean lb_Exit = false

//Set process bar
if IsValid(w_import_progressbar) then
	w_import_progressbar.of_SetMaxPosition(2)
end if

//Dynamic create import datawindow
ads_imp_data.Reset()
ls_Error = of_VerifyImportField(ids_import_field)
if LenA(ls_Error) > 0 then
	Return "Failed to get import data. " + ls_Error
else
	if of_DynCreateImportDW(ads_imp_data) = -1 then
		Return "Failed to get import data. Dynamic create datawindow error."
	end if
end if

//Check filter expression
//----------------------------- APPEON BEGIN ----------------------------
//$<add> Evan 07.27.2011
//$<reason> Date range settings (V11.3 QA Import)
ls_filter_exp = ids_import_hdr.object.filter_exp[ids_import_hdr.getrow()]
if Len(ls_filter_exp) > 0 then
	if ads_imp_data.SetFilter(ls_filter_exp) = -1 then
		Return "Failed to get import data. Date range expression is invalid."
	end if
	ads_imp_data.SetFilter("")
end if
//----------------------------- APPEON END ------------------------------

//Get reference information of external data
ll_FindRow = ids_import_hdr.Find("import_id=" + String(al_import_id), 1, ids_import_hdr.RowCount())
if ll_FindRow <= 0 then Return "Failed to get import data. Can not locate import ID."
ls_imp_format = ids_import_hdr.object.imp_format[ll_FindRow]
ls_odbc_name = ids_import_hdr.object.odbc_name[ll_FindRow]
ls_odbc_login = ids_import_hdr.object.odbc_login[ll_FindRow]
ls_odbc_password = ids_import_hdr.object.odbc_password[ll_FindRow]
ls_import_sql = ids_import_hdr.object.import_sql[ll_FindRow]
if IsNull(ls_imp_format) then ls_imp_format = ""
if IsNull(ls_odbc_name) then ls_odbc_name = ""
if IsNull(ls_odbc_login) then ls_odbc_login = ""
if IsNull(ls_odbc_password) then ls_odbc_password = ""
if IsNull(ls_import_sql) then ls_import_sql = ""

ls_imp_file = ids_import_hdr.object.imp_file[ll_FindRow]
if IsNull(ls_imp_file) then ls_imp_file = ""
ll_ignore_header_row = ids_import_hdr.object.ignore_header_row[ll_FindRow]

ls_record_delimiter = ids_import_hdr.object.record_delimiter[ll_FindRow]
if IsNull(ls_record_delimiter) then ls_record_delimiter = ""
ls_field_delimiter = ids_import_hdr.object.field_delimiter[ll_FindRow]
if IsNull(ls_field_delimiter) then ls_field_delimiter = ""

//Get import data
choose case ls_imp_format
	case "1" //Tab Delimited
		if LenA(ls_imp_file) <= 0 then Return "Failed to get import data. Import file name can not be null."
		if not FileExists(ls_imp_file) then Return "Failed to get import data. Import file not exists."
		if ll_ignore_header_row = 1 then 
			ll_Return = ads_imp_data.ImportFile(ls_imp_file, 2)
		else
			ll_Return = ads_imp_data.ImportFile(ls_imp_file, 1)
		end if
		if ll_Return = -4 then
			ads_imp_data.Reset()
			Return "Failed to get import data. Import value exceeds 1000 bytes."
		elseif ll_Return < 0 or IsNull(ll_Return) then
			ads_imp_data.Reset()
			
			//------------------- APPEON BEGIN -------------------
			//<$>added:long.zhang 10.30.2015
			//<$>reason: For Issue: Scheduler reports failure when an import points to a file with no data
			//Return "Failed to get import data."
			Return of_get_no_data_error(ll_Return)
			//------------------- APPEON END -------------------
		end if
		
	case "2" //CSV
		//if AppeonGetClientType() <> "PB" then Return "Failed to get import data. The file type of CSV is unsupported on WEB."  //Commented by (Appeon)Stephen 11.09.2016 - Import with CSV file
		if LenA(ls_imp_file) <= 0 then Return "Failed to get import data. Import file name can not be null."
		if not FileExists(ls_imp_file) then Return "Failed to get import data. Import file not exists."
		if ll_ignore_header_row = 1 then 
			ll_Return = ads_imp_data.ImportFile(CSV!, ls_imp_file, 2)
		else
			ll_Return = ads_imp_data.ImportFile(CSV!, ls_imp_file, 1)
		end if
		if ll_Return = -4 then
			ads_imp_data.Reset()
			Return "Failed to get import data. Import value exceeds 1000 bytes."
		elseif ll_Return < 0 or IsNull(ll_Return) then
			ads_imp_data.Reset()
			
			//------------------- APPEON BEGIN -------------------
			//<$>added:long.zhang 10.30.2015
			//<$>reason: For Issue: Scheduler reports failure when an import points to a file with no data
			//Return "Failed to get import data."
			Return of_get_no_data_error(ll_Return)
			//------------------- APPEON END -------------------
		end if
		
	case "3" //ODBC
		if ls_import_sql = "" then Return "Failed to get import data. Import SQL can not be null."
		if AppeonGetClientType() = "PB" then
			if ls_odbc_name = "" then Return "Failed to get import data. ODBC name can not be null."
			if ls_odbc_login = "" then Return "Failed to get import data. ODBC login can not be null."
		else
			if ls_odbc_name = "" then Return "Failed to get import data. Cache name can not be null."
		end if
		
		ltr_trans = Create Transaction
		if gs_dbtype = "ASA" then
			ltr_trans.DBMS = "ODB-ASA"
		else
			ltr_trans.DBMS = "ODB-MSS"
		end if
		ltr_trans.AutoCommit = False
		//---------Begin Modified by (Appeon)Toney 06.17.2013 for V141 ISG-CLX--------
		  /*
			ltr_trans.DBParm = "ConnectString='DSN=" + ls_odbc_name + ";UID=" + ls_odbc_login + ";PWD=" + ls_odbc_password + "',CacheName='" + ls_odbc_name + "',ConnectOption='SQL_DRIVER_CONNECT,SQL_DRIVER_NOPROMPT'"	
		  */
		ltr_trans.DBParm = "ConnectString='DSN=" + ls_odbc_name + ";UID=" + ls_odbc_login + ";PWD=" + ls_odbc_password + "',CacheName='" + ls_odbc_name + "',ConnectOption='SQL_DRIVER_CONNECT,SQL_DRIVER_NOPROMPT',DelimitIdentifier='Yes'"
		//---------End Modfiied ------------------------------------------------------------------
		Connect using ltr_trans;
		if ltr_trans.SQLCode <> 0 then
			Destroy ltr_trans
			Return "Failed to get import data. Can not connect to the database."
		end if
		
		ls_Syntax = ltr_trans.SyntaxFromSQL(ls_import_sql, "", ls_Error)
		if LenA(ls_Error) > 0 then
			Destroy ltr_trans
			Return "Failed to get import data. Import SQL syntax is incorrect."
		end if
		lds_odbc_data = Create DataStore
		lds_odbc_data.Create(ls_Syntax, ls_Error)
		lds_odbc_data.SetTransObject(ltr_trans)
		if lds_odbc_data.Retrieve() > 0 then
			//------------------- APPEON BEGIN -------------------
			//$<modify> Evan 10.09.2009
			//$<reason> The ImportString method can't process carriage return sign.
			//ll_Return = ads_imp_data.ImportString(lds_odbc_data.object.datawindow.data)
			FileDelete(of_GetImportDir() + "\data.txt")
			lds_odbc_data.SaveAs(of_GetImportDir() + "\data.txt", text!, false)
			ll_Return = ads_imp_data.ImportFile(of_GetImportDir() + "\data.txt")
			//------------------- APPEON END ---------------------
			if ll_Return = -4 then
				ads_imp_data.Reset()
				Return "Failed to get import data. Import value exceeds 1000 bytes."
			elseif ll_Return < 0 or IsNull(ll_Return) then
				ads_imp_data.Reset()
				
				//------------------- APPEON BEGIN -------------------
				//<$>added:long.zhang 10.30.2015
				//<$>reason: For Issue: Scheduler reports failure when an import points to a file with no data
				//Return "Failed to get import data."
				Return of_get_no_data_error(ll_Return)
				//------------------- APPEON END -------------------
			end if		
		end if
		
		Disconnect using ltr_trans;
		Destroy ltr_trans
		Destroy lds_odbc_data	
		
	case "4" //Formatted text
		if LenA(ls_imp_file) <= 0 then Return "Failed to get import data. Import file name can not be null."
		if not FileExists(ls_imp_file) then Return "Failed to get import data. Import file not exists."
		if LenA(ls_record_delimiter) <= 0 then Return "Failed to get import data. Record delimiter can not be null."
		if LenA(ls_field_delimiter) <= 0 then Return "Failed to get import data. Field delimiter can not be null."
		li_ColCount = Integer(ads_imp_data.object.datawindow.column.count)
		//------------------- APPEON BEGIN -------------------
		//$<modify> Stephen 03.14.2013
		//$<reason> Importing pipe-delimited file data
		/*
		lblb_data = of_ReadFile(ls_imp_file)
		ls_FormattedText = String(lblb_data)	
		*/
		ls_FormattedText = of_ReadFile_str(ls_imp_file)
		//------------------- APPEON END -------------------
		if Lower(ls_record_delimiter) = "enter" then
			ls_record_delimiter = "~r~n"
		elseif Lower(ls_record_delimiter) = "tab" then
			ls_record_delimiter = "~t"
		end if

		ll_DelimiterLen = LenA(ls_record_delimiter)
		if ll_ignore_header_row = 1 then
			ll_OldDelimiterPos = PosA(ls_FormattedText, ls_record_delimiter)
			ll_OldDelimiterPos += ll_DelimiterLen
		else
			ll_OldDelimiterPos = 1
		end if
	
		do			
			ll_NewDelimiterPos = PosA(ls_FormattedText, ls_record_delimiter, ll_OldDelimiterPos)
			if ll_NewDelimiterPos > 0 then
				ls_Record = MidA(ls_FormattedText, ll_OldDelimiterPos, ll_NewDelimiterPos - ll_OldDelimiterPos)
				ll_OldDelimiterPos = ll_NewDelimiterPos + ll_DelimiterLen
				li_FieldCount = of_GetFrmFieldValue(ls_Record, ls_field_delimiter, ls_FieldValue)
				ll_InsertRow = ads_imp_data.InsertRow(0)
			else
				ls_Record = RightA(ls_FormattedText, LenA(ls_FormattedText) - ll_OldDelimiterPos + 1)
				if LenA(ls_Record) > 0 then 
					li_FieldCount = of_GetFrmFieldValue(ls_Record, ls_field_delimiter, ls_FieldValue)
					ll_InsertRow = ads_imp_data.InsertRow(0)
				end if
				lb_Exit = true
			end if
			for i = 1 to li_ColCount
				if i <= li_FieldCount then
					ads_imp_data.object.data[ll_InsertRow, i] = ls_FieldValue[i]
				end if
			next
		loop until lb_Exit
		
	case else
		Return "Failed to get import data. Import format can not be null."
end choose
if IsValid(w_import_progressbar) then
	w_import_progressbar.of_SkipNextPosition()
end if

//Set default value of import data
of_SetDefaultValue(ads_imp_data)
if IsValid(w_import_progressbar) then
	w_import_progressbar.of_SkipNextPosition()
end if

Return ""
end function

public function string of_verifyimportfield (ref datastore ads_import_field);integer i, j, li_Len
integer li_FieldCount
integer li_CompColumnCount
integer li_last_field_order
integer li_com_order[]
string  ls_Char
string  ls_AlphaNumber = "qwertyuiopasdfghjklzxcvbnm0123456789_"
string  ls_comp_def
string  ls_imp_field_name
string  ls_last_field_name
string  ls_com_field[]

// There is no define import field
li_FieldCount = ads_import_field.RowCount()
if li_FieldCount <= 0 then Return "There is no defined import field."

// Check field name
for i = 1 to li_FieldCount
	ls_imp_field_name = Trim(ads_import_field.object.imp_field_name[i])
	choose case Lower(ls_imp_field_name)
		//---------Begin Modified by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
		//case "sys_pc_id", "sys_facility_id", "sys_contact_id"
		case "sys_pc_id", "sys_facility_id", "sys_contact_id", "sys_hdr_id"//added by gavins 20130225
		//---------End Modfiied ------------------------------------------------------	
			Return "Import field '" + ls_imp_field_name + "' is reserved field."
	end choose
	
	li_Len = LenA(ls_imp_field_name)	
	if li_Len > 0 then	
		for j = 1 to li_Len
			ls_Char = MidA(ls_imp_field_name, j, 1)
			if PosA(ls_AlphaNumber, Lower(ls_Char)) <= 0 then
				Return "Import field name '" + ls_imp_field_name + "' is invalid.~r~nIt can only contains letters (without space), numbers, and underscores."
			end if
		next
	else
		Return "Import field can not be null."
	end if
	
	ls_comp_def = Trim(ads_import_field.object.comp_def[i])
	if LenA(ls_comp_def) > 0  then
		li_CompColumnCount ++
		ls_com_field[li_CompColumnCount] = ls_imp_field_name
		li_com_order[li_CompColumnCount] = ads_import_field.object.field_order[i]		
	else
		ls_last_field_name = ls_imp_field_name
		li_last_field_order = ads_import_field.object.field_order[i]
	end if
next
if li_CompColumnCount = li_FieldCount then Return "Import fields must include at least one DB field."

// Check order of compute field
for i = 1 to li_CompColumnCount
	if li_com_order[i] < li_last_field_order then
		Return "The import field order of '" + ls_com_field[i] + "' must be more than '" + ls_last_field_name + "' field order."
	end if
next

Return ""
end function

public function integer of_setdefaultvalue (ref datastore ads_imp_data);string  ls_comp_def
string  ls_OldValue
string  ls_default_value
string  ls_imp_field_name
integer li_FieldCount
long    i, j, ll_RowCount

li_FieldCount = ids_import_field.RowCount()
if li_FieldCount <= 0 then Return -1
ll_RowCount = ads_imp_data.RowCount()
if ll_RowCount = 0 then Return 1

for i = 1 to li_FieldCount
	ls_comp_def = Trim(ids_import_field.object.comp_def[i])
	if LenA(ls_comp_def) > 0  then Continue
	
	ls_default_value = Trim(ids_import_field.object.default_value[i])
	if LenA(ls_default_value) > 0 then	
		ls_imp_field_name = Trim(ids_import_field.object.imp_field_name[i])
		for j = 1 to ll_RowCount
			ls_OldValue = ads_imp_data.GetItemString(j, ls_imp_field_name)
			if IsNull(ls_OldValue) or ls_OldValue = "" then
				ads_imp_data.SetItem(j, ls_imp_field_name, ls_default_value)
			end if
		next
	end if
next

Return 1
end function

public function integer of_execute (long al_import_id, ref datawindow adw_data);string ls_Error
string ls_Syntax

ib_IsDoPrompt = true
ib_IsExecute1 = false

//Get import information
of_GetImportInfo(al_import_id, true)

//Initialize progress bar
if IsValid(w_import_progressbar) then Close(w_import_progressbar)
Open(w_import_progressbar)
w_import_progressbar.of_ResetStep()
w_import_progressbar.of_SetImportID(al_import_id)
w_import_progressbar.of_SetTableCount(ids_table_record.RowCount())
w_import_progressbar.of_SetRemainCount(ids_table_record.RowCount())

//Get import data
w_import_progressbar.of_SetMaxPosition(2)
w_import_progressbar.of_SkipNextPosition()
if ids_table_record.RowCount() > 0 then
	ls_Syntax = adw_data.object.datawindow.syntax
	ids_imp_data.Create(ls_Syntax, ls_Error)
	adw_data.RowsCopy(1, adw_data.RowCount(), Primary!, ids_imp_data, 1, Primary!)
	w_import_progressbar.of_SetTableName(ids_table_record.object.table_name_allias[1])
end if
w_import_progressbar.of_SkipNextPosition()
 
//Execute Import data process
Open(w_import_temp)
this.Event ue_Main(al_import_id)

//Close temporary window
if IsValid(w_import_temp) then
	Close(w_import_temp)
end if

Return 1
end function

public function integer of_retrievelookupmapping ();long i, ll_ilm_id[]

ids_lookup_mapping.Reset()
for i = 1 to ids_mapping_field.RowCount()
	if not IsNull(ids_mapping_field.object.lu_template[i]) then
		ll_ilm_id[UpperBound(ll_ilm_id) + 1] = ids_mapping_field.object.lu_template[i]
	end if
next

if UpperBound(ll_ilm_id) > 0 then
	ids_lookup_mapping.Retrieve(ll_ilm_id[])
end if

Return 1
end function

public function integer of_dataprocess ();long     ll_facility_id
long     ll_lu_template
long     ll_ImportDataRow
long     ll_ImpRowCount
long     ll_MapFieldCount
integer  li_err_process
integer  li_MapFieldIndex
integer  li_no_match_procd
integer  li_field_len
integer  li_null_type
integer  li_Return
integer  li_id[]
string   ls_table_name
string   ls_imp_field_name
string   ls_lu_field_name
string   ls_lu_type
string   ls_lu_table
string   ls_field_type
string   ls_allow_null
string   ls_ImportValue
string   ls_CharValue
decimal  ldc_DecValue
datetime ldt_DTValue
boolean  lb_IsGetImpValue
boolean  lb_IsFacilityField
boolean  lb_IsLookupField
boolean	lb_IsLookupTemplate

// Set progress bar
ll_MapFieldCount = ids_mapping_field.RowCount()
w_import_progressbar.of_SetImportProcessDesc("Data process")
w_import_progressbar.of_SetMaxPosition(ll_MapFieldCount)
ll_ImpRowCount = ids_imp_data.RowCount()
if ll_ImpRowCount <= 0 then Return 1

// Get err_process and table_name
li_err_process = ids_import_hdr.object.err_process[ids_import_hdr.GetRow()]
ls_table_name = Lower(ids_table_record.object.table_name[ids_table_record.GetRow()])

// Insert null row to ids_intellisoft_table_temp
for ll_ImportDataRow = 1 to ll_ImpRowCount
	ids_intellisoft_table_temp.InsertRow(0)	
	ids_intellisoft_table_temp.SetItem(ll_ImportDataRow, "imp_row", ll_ImportDataRow)	
	// err_value 0: The row none error
	// err_value 1: The row have error, but can import value of none error field
	// err_value 2: The row have error, can not import this row
	ids_intellisoft_table_temp.SetItem(ll_ImportDataRow, "err_value", 0)
	yield()
next

// Initialize value of foreign key
choose case ls_table_name
	case "pd_basic","ctx_basic_info"
		li_id[ll_ImpRowCount] = 0
		ids_imp_data.object.sys_pc_id[1, ll_ImpRowCount] = li_id[]
	case "app_facility"
		li_id[ll_ImpRowCount] = 0
		ids_imp_data.object.sys_facility_id[1, ll_ImpRowCount] = li_id[]
	case "ctx_contacts" //Child table of app_facility
		li_id[ll_ImpRowCount] = 0
		ids_imp_data.object.sys_contact_id[1, ll_ImpRowCount] = li_id[]
		ids_intellisoft_table_temp.object.sys_facility_id[1, ll_ImpRowCount] = ids_imp_data.object.sys_facility_id[1, ll_ImpRowCount]
	case "ctx_contacts_numbers"  //Child table of ctx_contacts
		ids_intellisoft_table_temp.object.sys_contact_id[1, ll_ImpRowCount] = ids_imp_data.object.sys_contact_id[1, ll_ImpRowCount]
	case "ctx_contract_contacts" //Child table of ctx_contacts and ctx_basic_info
		ids_intellisoft_table_temp.object.sys_contact_id[1, ll_ImpRowCount] = ids_imp_data.object.sys_contact_id[1, ll_ImpRowCount]
		ids_intellisoft_table_temp.object.sys_pc_id[1, ll_ImpRowCount] = ids_imp_data.object.sys_pc_id[1, ll_ImpRowCount]
	//---------Begin Added by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
	case "ctx_custom_multi_hdr"//added by gavins 20130225
		ids_intellisoft_table_temp.object.sys_pc_id[1, ll_ImpRowCount] = ids_imp_data.object.sys_pc_id[1, ll_ImpRowCount]	
	case "ctx_custom_multi_detail"//added by gavins 20130225
		ids_intellisoft_table_temp.object.sys_hdr_id[1, ll_ImpRowCount] = ids_imp_data.object.sys_hdr_id[1, ll_ImpRowCount]
		ids_intellisoft_table_temp.object.sys_pc_id[1, ll_ImpRowCount] = ids_imp_data.object.sys_pc_id[1, ll_ImpRowCount]
	//---------End Added ------------------------------------------------------
	case else                    //Child table of pd_basic and ctx_basic_info
		ids_intellisoft_table_temp.object.sys_pc_id[1, ll_ImpRowCount] = ids_imp_data.object.sys_pc_id[1, ll_ImpRowCount]
end choose
	
// Dispose each column data of IntelliSoft table
for li_MapFieldIndex = 1 to ll_MapFieldCount
	// Get field information
	ll_facility_id = ids_mapping_field.GetItemNumber(li_MapFieldIndex, "facility_id")
	ls_imp_field_name = Trim(ids_mapping_field.GetItemString(li_MapFieldIndex, "imp_field_name"))
	ll_lu_template = ids_mapping_field.GetItemNumber(li_MapFieldIndex, "lu_template")
	li_no_match_procd = ids_mapping_field.GetItemNumber(li_MapFieldIndex, "no_match_procd")
	ls_lu_type = ids_mapping_field.GetItemString(li_MapFieldIndex, "lu_type")
	ls_lu_table = ids_mapping_field.GetItemString(li_MapFieldIndex, "lu_table")
	ls_lu_field_name = ids_mapping_field.GetItemString(li_MapFieldIndex, "lu_field_name")
	ls_field_type = ids_mapping_field.GetItemString(li_MapFieldIndex, "field_type")
	li_field_len = ids_mapping_field.GetItemNumber(li_MapFieldIndex, "field_len")
	li_null_type = ids_mapping_field.GetItemNumber(li_MapFieldIndex, "null_type")	
	ls_allow_null = ids_mapping_field.GetItemString(li_MapFieldIndex, "allow_null")
	lb_IsGetImpValue = false
	lb_IsFacilityField = false
	lb_IsLookupTemplate = false
	lb_IsLookupField = false
	if LenA(ls_imp_field_name) > 0 then lb_IsGetImpValue = true
	if not IsNull(ll_facility_id) then lb_IsFacilityField = true
	if not IsNull(ll_lu_template) then lb_IsLookupTemplate = true
	if LenA(ls_lu_field_name) > 0 then lb_IsLookupField = true
	
	// Filter lookup mapping and retrieve lookup data
	of_RetrieveLookupData(ll_lu_template, ls_lu_type, ls_lu_table)
	yield()
	// Import each import value
	ids_coderownum1.Reset()
	ids_coderownum2.Reset()
	for ll_ImportDataRow = 1 to ll_ImpRowCount
		// Get import value and dispose null value
		if ids_intellisoft_table_temp.GetItemNumber(ll_ImportDataRow, "err_value") = 2 then Continue
		if lb_IsGetImpValue then
			ls_ImportValue = ids_imp_data.GetItemString(ll_ImportDataRow, ls_imp_field_name)
			of_DisposeNullValue(li_null_type, ll_ImportDataRow, li_MapFieldIndex, ls_ImportValue)
			ls_ImportValue = Trim(ls_ImportValue)
		end if
 
		// Parse import value
		if lb_IsFacilityField then
			if ls_field_type = "I" or ls_field_type = "N" then
				ids_intellisoft_table_temp.SetItem(ll_ImportDataRow, li_MapFieldIndex, ll_facility_id)
			else
				of_Log(ll_ImportDataRow, ls_imp_field_name, IL_ERRTYPE_VERIFYVALUE, "Facility_id field must be the type of number.")
				if not of_IsContinue() then Return -1
				ids_intellisoft_table_temp.SetItem(ll_ImportDataRow, "err_value", 1)
				Continue
			end if
			
		elseif lb_IsLookupTemplate then
			// Dispose lookup code according to lu_template
			li_Return = of_DisposeLookupCode(ll_ImportDataRow, li_MapFieldIndex, ls_ImportValue, ls_field_type, li_no_match_procd)
			yield()
			if li_Return = -1 then
				of_Log(ll_ImportDataRow, ls_imp_field_name, IL_ERRTYPE_MAPDESIGN, "When 'No match Procd'='Error', it's not allowed to add new lookup code to template.")
			elseif li_Return = -2 then
				of_Log(ll_ImportDataRow, ls_imp_field_name, IL_ERRTYPE_DATAINTEGRITY, "'" + ls_ImportValue + "' matches no facility_id in template.")
			//---------Begin Modified by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
			//elseif li_Return = -3 then // V10.1 - Import Active Status
			elseif li_Return = -13 then // V10.1 - Import Active Status
			//---------End Modfiied ------------------------------------------------------
				of_Log(ll_ImportDataRow, ls_imp_field_name, IL_ERRTYPE_DATAINTEGRITY, "'" + ls_ImportValue + "' matches no active_status_id in template.")
			end if
			if li_Return < 0 then
				if not of_IsContinue() then Return -1				
				ids_intellisoft_table_temp.SetItem(ll_ImportDataRow, "err_value", 1)
				Continue
			end if
			
		elseif lb_IsLookupField then
			// Dispose lookup code according to lu_field_name
			li_Return = of_DisposeLookupCode(ll_ImportDataRow, li_MapFieldIndex, ls_ImportValue, ls_field_type, li_no_match_procd, ls_lu_type, ls_lu_table, ls_lu_field_name)
			yield()
			if li_Return = -1 then
				of_Log(ll_ImportDataRow, ls_imp_field_name, IL_ERRTYPE_MAPDESIGN, "When 'No match Procd'='Error', it's not allowed to add new lookup code to lookup table.")
			elseif li_Return = -2 then
				of_Log(ll_ImportDataRow, ls_imp_field_name, IL_ERRTYPE_DATAINTEGRITY, "'" + ls_ImportValue + "' matches no facility_id in lookup table.")
			//---------Begin Modified by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
			elseif li_Return = -3 then//added by gavins 20130524
				of_Log(ll_ImportDataRow, ls_imp_field_name, IL_ERRTYPE_DATAINTEGRITY, "'" + ls_ImportValue + "' does not match any value in company table.")
			//elseif li_Return = -3 then // V10.1 - Import Active Status
			elseif li_Return = -13 then // V10.1 - Import Active Status
			//---------End Modfiied ------------------------------------------------------
				of_Log(ll_ImportDataRow, ls_imp_field_name, IL_ERRTYPE_DATAINTEGRITY, "'" + ls_ImportValue + "' matches no active_status_id in lookup table.")
			end if
			if li_Return < 0 then
				if not of_IsContinue() then Return -1
				//---------Begin Modified by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
				//ids_intellisoft_table_temp.SetItem(ll_ImportDataRow, "err_value", 1)
				if li_Return = -3 then
					ids_intellisoft_table_temp.SetItem(ll_ImportDataRow, "err_value", 2)
				Else
					ids_intellisoft_table_temp.SetItem(ll_ImportDataRow, "err_value", 1)
				End If
				//---------End Modfiied ------------------------------------------------------
				Continue
			end if
			
		else		
			// Verify external data according to field type and field length
			li_Return = of_DisposeVerifyValue(ls_ImportValue, ls_field_type, li_field_len, ls_CharValue, ldc_DecValue, ldt_DTValue)
			yield()
			if li_Return = -1 then
				if ls_field_type = "D" then
					of_Log(ll_ImportDataRow, ls_imp_field_name, IL_ERRTYPE_VERIFYVALUE, "Can not convert '" + ls_ImportValue + "' to the type of datetime.")
				else
					of_Log(ll_ImportDataRow, ls_imp_field_name, IL_ERRTYPE_VERIFYVALUE, "Can not convert '" + ls_ImportValue + "' to the type of number.")
				end if
			elseif li_Return = -2 then
				of_Log(ll_ImportDataRow, ls_imp_field_name, IL_ERRTYPE_VERIFYVALUE, "'" + ls_ImportValue + "' exceeds the length of field.")
			end if
			
			// Move import value to ids_intellisoft_table_TEMP
			if li_Return = 1 then
				choose case ls_field_type
					case "C"
						ids_intellisoft_table_temp.SetItem(ll_ImportDataRow, li_MapFieldIndex, ls_CharValue)
					case "I", "N"
						ids_intellisoft_table_temp.SetItem(ll_ImportDataRow, li_MapFieldIndex, ldc_DecValue)
					case "D"
						ids_intellisoft_table_temp.SetItem(ll_ImportDataRow, li_MapFieldIndex, ldt_DTValue)
				end choose
			else
				if not of_IsContinue() then Return -1
				ids_intellisoft_table_temp.SetItem(ll_ImportDataRow, "err_value", 1)
			end if
		end if
		yield()
		// Check import value if null
		if ls_allow_null = "N" then
			if IsNull(ids_intellisoft_table_temp.object.data[ll_ImportDataRow, li_MapFieldIndex]) then
				if not ((lb_IsLookupTemplate or lb_IsLookupField) and li_no_match_procd = 1) then
					of_Log(ll_ImportDataRow, ls_imp_field_name, IL_ERRTYPE_DATAINTEGRITY, "Import value can not be null.")
					if not of_IsContinue() then Return -1
					ids_intellisoft_table_temp.SetItem(ll_ImportDataRow, "err_value", 2)
					Continue
				end if
			end if
		end if
		Yield() // evan 07.11.2011
	next

	// Update lookup table if have new records
	if lb_IsLookupTemplate then
		of_UpdateLookupTable(1, li_MapFieldIndex, ls_field_type)
	elseif lb_IsLookupField then
		of_UpdateLookupTable(2, li_MapFieldIndex, ls_field_type)
	end if
	w_import_progressbar.of_SkipNextPosition()
	Yield() // evan 07.11.2011
next

// Determine which data row if can be importing
if of_IsStopImport() then Return -1
if ids_log_table.object.error_count[ids_log_table.GetRow()] > 0 then
	if li_err_process = 2 then
		ids_intellisoft_table_temp.of_Filter("err_value = 0")
	else
		ids_intellisoft_table_temp.of_Filter("err_value <> 2")
	end if
	ids_intellisoft_table_temp.RowsDiscard(1, ids_intellisoft_table_temp.FilteredCount(), Filter!)
end if

Return 1
end function

public function integer of_retrievelookupdata (long al_lu_template, string as_lu_type, string as_lu_table);string ls_Filter
string ls_LookupType

// Filter lookup mapping
if not IsNull(al_lu_template) then
	ids_lookup_mapping.of_Filter("ilm_id = " + String(al_lu_template))
	ls_Filter = "lookup_name = '" + ids_lookup_mapping.object.lookup_table[1] + "'"
	ls_LookupType = ids_lookup_mapping.object.map_type[1]
elseif LenA(as_lu_table) > 0 then
	ls_Filter = "lookup_name = '" + as_lu_table + "'"
	ls_LookupType = as_lu_type
else
	Return 1
end if

// Retrieve lookup data
choose case ls_LookupType
	case "A" //Address
		if ids_address_lookup.RowCount() + ids_address_lookup.FilteredCount() <= 0 then
			ids_address_lookup.Retrieve()
		end if
		ids_address_lookup.SetFilter(ls_Filter)
		ids_address_lookup.Filter()
		
	case "C" //Code
		if ids_code_lookup.RowCount() + ids_code_lookup.FilteredCount() <= 0 then
			ids_code_lookup.Retrieve()
		end if
		ids_code_lookup.SetFilter(ls_Filter)
		ids_code_lookup.Filter()
		
	case "F" //Facility
		if ids_facility.RowCount() <= 0 then ids_facility.Retrieve()
		
	case "M" //Committee
		if ids_committee.RowCount() <= 0 then ids_committee.Retrieve()
		
	case "I" //Company
		if ids_company.RowCount() <= 0 then ids_company.Retrieve()
		
	case "S" //Active Status (V10.1 - Import Active Status)
		if ids_active_status.RowCount() <= 0 then ids_active_status.Retrieve()

	case "Q" //QA Metrics (V11.3 QA Import)
		if ids_qa_metrics.RowCount() <= 0 then ids_qa_metrics.Retrieve()
end choose

Return 1
end function

public function integer of_disposeverifyvalue (string as_importvalue, string as_field_type, integer ai_field_len, ref string as_charvalue, ref decimal adc_decvalue, ref datetime adt_dtvalue);string  ls_Date
string  ls_Time
integer li_Pos

// Set null
if IsNull(as_ImportValue) or as_ImportValue = "" then
	SetNull(as_CharValue)
	SetNull(adc_DecValue)
	SetNull(adt_DTValue)
	Return 1
end if

// Conver data type
choose case as_field_type
	case "D"
		li_Pos = PosA(as_ImportValue, " ")
		if li_Pos > 0 then
			ls_Date = LeftA(as_ImportValue, li_Pos - 1)
			ls_Time = RightA(as_ImportValue, LenA(as_ImportValue) - li_Pos)
			if IsDate(ls_Date) and IsTime(ls_Time) then
				adt_DTValue = DateTime(Date(ls_Date), Time(ls_Time))
				Return 1 // Not need to check length if type is datetime
			else
				Return -1
			end if
		else
			if IsDate(as_ImportValue) then
				adt_DTValue = DateTime(Date(as_ImportValue), 00:00:00)
				Return 1 // Not need to check length if type is datetime
			else
				Return -1
			end if
		end if
		
	case "I", "N"
		if IsNumber(as_ImportValue) then
			adc_DecValue = Dec(as_ImportValue)
			Return 1 // Not need to check length if type is number
		else
			Return -1
		end if

	case "C"
		as_CharValue = as_ImportValue
		
	case else
		Return -1
end choose

// Check field length
if LenA(as_ImportValue) > ai_field_len then Return -2

Return 1
end function

public function integer of_dataupdate ();long ll_Row
long ll_Count
integer li_Return

///////////////////////////////[1-Stop Import data]//////////////////////////////////////
if of_IsStopImport() then Return -1

///////////////////////////////[2-Prepare update]//////////////////////////////////////
li_Return = of_PreUpdate()
yield()
if li_Return = -1 then
	ids_intellisoft_table.Reset()
	Return -1
elseif li_Return = -2 then
	ids_intellisoft_table.Reset()	
	if of_IsStopImport() then Return -1
end if

///////////////////////////////[3-Update import table]/////////////////////////////////
w_import_progressbar.of_SetImportProcessDesc("Update IntelliSoft table")
w_import_progressbar.of_SetMaxPosition(2)
w_import_progressbar.of_SkipNextPosition()
ll_Row = ids_log_table.GetRow()

if ids_intellisoft_table.ModifiedCount() > 0 then	
	if ids_intellisoft_table.Update(true, false) = 1 then
		of_CompleteTrans(true)		
		yield()
		ll_Count = ids_log_table.object.add_count[ll_Row] + il_CurrTableAddCount
		ids_log_table.object.add_count[ll_Row] = ll_Count
		ll_Count = ids_log_table.object.mod_count[ll_Row] + il_CurrTableModifyCount
		ids_log_table.object.mod_count[ll_Row] = ll_Count
	else
		//---------Begin Added by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
		//Added By Ken.Guo 08/15/2013
		gnv_debug.of_output(True,'DB Update Error')
		gnv_debug.of_output(True,'Rowcount() = ' + String(ids_intellisoft_table.RowCount()))
		gnv_debug.of_output(True, 'ids_intellisoft_table.Describe("DataWindow.Syntax") =' + ids_intellisoft_table.Describe("DataWindow.Syntax") )
		//---------End Added ------------------------------------------------------
		
		of_CompleteTrans(false)
		ids_intellisoft_table.Reset()
		of_Log(0, "", IL_ERRTYPE_UPDATE, ids_intellisoft_table.is_SQLErrText)
		if not of_IsContinue() then Return -1
		Return 1
	end if
else
	ll_Count = ids_log_table.object.mod_count[ll_Row] + il_CurrTableModifyCount
	ids_log_table.object.mod_count[ll_Row] = ll_Count
end if
w_import_progressbar.of_SkipNextPosition()

///////////////////////////////[4-Post update]//////////////////////////////////////
of_PostUpdate()

Return 1
end function

public function integer of_datapopulate ();Return 1
end function

public function integer of_dyncreateistabledw (string as_table_name);Return 1
end function

public function integer of_postupdate ();Return 1
end function

public function integer of_preupdate ();Return 1
end function

public function integer of_setsequenceno (ref datastore ads_sequence, ref datastore ads_intellisoft_table, long al_addcount, string as_filterfield, string as_updatefield, boolean ab_flag);long i, j, ll_Row
long ll_max_seq_no
long ll_FilterID
string ls_Filter

//---------Begin Added by (Appeon)Stephen 03.05.2014 for Import time-out--------
w_import_progressbar.of_SetImportProcessDesc("Set Sequence No")
w_import_progressbar.of_SetMaxPosition(il_CurrTableAddCount + 2)
//---------End Added ------------------------------------------------------
for i = 1 to al_AddCount
	if ab_Flag then
		ll_Row = ids_newrow.GetItemNumber(i, "new_row")
	else
		ll_Row = ads_intellisoft_table.RowCount() - al_AddCount + i
	end if
	ll_FilterID = ads_intellisoft_table.GetItemNumber(ll_Row, as_FilterField)
	if as_FilterField = "ctx_id" then
		ls_Filter = "prac_id=" + String(ll_FilterID)
	else
		ls_Filter = as_FilterField + "=" + String(ll_FilterID)
	end if
	ads_sequence.SetFilter(ls_Filter)
	ads_sequence.Filter()
	
	if ads_sequence.RowCount() > 0 then
		ads_sequence.SetSort("seq_no A")
		ads_sequence.Sort()
		ll_max_seq_no = ads_sequence.object.seq_no[ads_sequence.RowCount()]
		if IsNull(ll_max_seq_no) then 
			ll_max_seq_no = 1
		else
			ll_max_seq_no ++
		end if
		for j = 1 to ads_sequence.RowCount()			
			ll_Row = ads_sequence.object.row_num[j]
			if ll_Row > 0 then
				ads_intellisoft_table.SetItem(ll_Row, as_UpdateField, ll_max_seq_no)				
				ll_max_seq_no ++
			end if
		next
		ads_sequence.RowsMove(1, ads_sequence.RowCount(), Primary!, ads_sequence, 1, Delete!)
	end if
	w_import_progressbar.of_SkipNextPosition()
next

Return 1
end function

public function integer of_checkmapping (boolean ab_isimport, long al_table_id, string as_table_name, ref datastore ads_import_field, ref datastore ads_mapping_field, ref string as_errortext[]);Return 1
end function

public function integer of_setautocommit (boolean ab_isauto);if ab_IsAuto = false then
	if SQLCA.AutoCommit = true then SQLCA.AutoCommit = false		
else
	if is_OldAutoCommit = true then
		if SQLCA.AutoCommit = false then SQLCA.AutoCommit = true
	end if
end if

Return 1
end function

public function string of_reviseexpvalue (string as_value);//---------Begin Modified by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
Return of_reviseexpvalue( as_value, true )

/*
integer li_Len
integer li_NewStart
integer li_OldStart = 1
string  ls_NewValue

do while true
	li_NewStart = PosA(as_Value, "'", li_OldStart)
	if li_NewStart > 0 then		
		ls_NewValue += MidA(as_Value, li_OldStart, li_NewStart - li_OldStart) + "~~'"
		li_OldStart = li_NewStart + 1
	else
		li_Len = LenA(as_Value) - li_OldStart + 1
		if li_Len > 0 then
			ls_NewValue += RightA(as_Value, li_Len)
		end if		
		Exit
	end if
loop

Return Lower(ls_NewValue)
*/
//---------End Modfiied ------------------------------------------------------
end function

public function integer of_addcontractcategoryright (long al_category);long ll_RoleId
long ll_Cycle
long ll_Count
long ll_InsertRow

for ll_Cycle = 1 to ids_security_role.RowCount()
	ll_RoleId = ids_security_role.GetItemNumber(ll_Cycle, "role_id")
	
	ll_InsertRow = ids_category_right.InsertRow(0)
	ids_category_right.SetItem(ll_InsertRow, "role_id", ll_RoleId)
	ids_category_right.SetItem(ll_InsertRow, "category", al_Category)
	ids_category_right.SetItem(ll_InsertRow, "types", 1)
	ids_category_right.SetItem(ll_InsertRow, "rights", "11")
	
	ll_InsertRow = ids_category_right.InsertRow(0)
	ids_category_right.SetItem(ll_InsertRow, "role_id", ll_RoleId)
	ids_category_right.SetItem(ll_InsertRow, "category", al_Category)
	ids_category_right.SetItem(ll_InsertRow, "types", 3)
	ids_category_right.SetItem(ll_InsertRow, "rights", "31")
	
	ll_InsertRow = ids_category_right.InsertRow(0)
	ids_category_right.SetItem(ll_InsertRow, "role_id", ll_RoleId)
	ids_category_right.SetItem(ll_InsertRow, "category", al_Category)
	ids_category_right.SetItem(ll_InsertRow, "types", 4)
	ids_category_right.SetItem(ll_InsertRow, "rights", "41")
next

Return 1
end function

public function integer of_disposelookupcode (long al_importdatarow, integer ai_mapfieldindex, string as_importvalue, string as_field_type, integer ai_no_match_procd, string as_lu_type, string as_lu_table, string as_lu_field_name);long ll_FindRow
long ll_RowCount
long ll_InsertRow
long ll_CodeTableRow
long ll_lookup_code
string ls_Find

//Check import value if null
as_ImportValue = Trim(as_ImportValue)
if IsNull(as_ImportValue) or as_ImportValue = "" then Return 1

//Lookup code from specify lookup table
choose case as_lu_type
	case "A" //Address
		if as_lu_field_name = "code" then
			ls_Find = "Lower(code) = '" + of_ReviseExpValue(as_ImportValue) + "'"
		else
			ls_Find = "Lower(entity_name) = '" + of_ReviseExpValue(as_ImportValue) + "'"	
		end if
		ll_FindRow = ids_address_lookup.Find(ls_Find, 1, ids_address_lookup.RowCount())
		yield()
		if ll_FindRow > 0 then
			ll_lookup_code = ids_address_lookup.object.lookup_code[ll_FindRow]
			of_ResetCodeValue(al_ImportDataRow, ai_MapFieldIndex, as_field_type, ll_lookup_code)
		else
			if ai_no_match_procd = 1 then
				//Insert a new record to lookup table
				ll_CodeTableRow = ids_address_lookup.InsertRow(0)
				ids_address_lookup.object.lookup_name[ll_CodeTableRow] = as_lu_table
				ids_address_lookup.object.code[ll_CodeTableRow] = LeftA(as_ImportValue, 15)
				ids_address_lookup.object.entity_name[ll_CodeTableRow] = LeftA(as_ImportValue, 100)
				
				//Record the row number
				ll_InsertRow = ids_coderownum1.InsertRow(0)
				ids_coderownum1.object.codetable_rownum[ll_InsertRow] = ll_CodeTableRow
				ids_coderownum1.object.impdata_rownum[ll_InsertRow] = al_ImportDataRow
			else
				Return -1 //User specify not allow add new lookup code
			end if
		end if
		
	case "C" //Code
		if as_lu_field_name = "code" then
			ls_Find = "Lower(code) = '" + of_ReviseExpValue(as_ImportValue) + "'"
		else
			ls_Find = "Lower(description) = '" + of_ReviseExpValue(as_ImportValue) + "'"			
		end if
		ll_FindRow = ids_code_lookup.Find(ls_Find, 1, ids_code_lookup.RowCount())
		yield()
		if ll_FindRow > 0 then
			ll_lookup_code = ids_code_lookup.object.lookup_code[ll_FindRow]
			of_ResetCodeValue(al_ImportDataRow, ai_MapFieldIndex, as_field_type, ll_lookup_code)
		else
			if ai_no_match_procd = 1 then
				//Insert a new record to lookup table
				ll_CodeTableRow = ids_code_lookup.InsertRow(0)
				ids_code_lookup.object.lookup_name[ll_CodeTableRow] = as_lu_table
				ids_code_lookup.object.code[ll_CodeTableRow] = LeftA(as_ImportValue, 30)
				ids_code_lookup.object.description[ll_CodeTableRow] = LeftA(as_ImportValue, 75)
				
				//Record the row number
				ll_InsertRow = ids_coderownum1.InsertRow(0)
				ids_coderownum1.object.codetable_rownum[ll_InsertRow] = ll_CodeTableRow
				ids_coderownum1.object.impdata_rownum[ll_InsertRow] = al_ImportDataRow
			else
				Return -1 //User specify not allow add new lookup code
			end if
		end if

	case "F" //Facility
		ls_Find = "Lower(facility_name) = '" + of_ReviseExpValue(as_ImportValue) + "'"
		ll_FindRow = ids_facility.Find(ls_Find, 1, ids_facility.RowCount())
		yield()
		if ll_FindRow > 0 then
			ll_lookup_code = ids_facility.object.facility_id[ll_FindRow]
			of_ResetCodeValue(al_ImportDataRow, ai_MapFieldIndex, as_field_type, ll_lookup_code)
			Return 1
		else
			Return -2 //There is no match Facility_id
		end if
		
	case "M" //Committee
		ls_Find = "Lower(committee_name) = '" + of_ReviseExpValue(as_ImportValue) + "'"
		ll_FindRow = ids_committee.Find(ls_Find, 1, ids_committee.RowCount())
		yield()
		if ll_FindRow > 0 then
			ll_lookup_code = ids_committee.object.committee_id[ll_FindRow]
			of_ResetCodeValue(al_ImportDataRow, ai_MapFieldIndex, as_field_type, ll_lookup_code)
		else
			if ai_no_match_procd = 1 then
				//Insert a new record to lookup table
				ll_CodeTableRow = ids_committee.InsertRow(0)
				ids_committee.object.committee_name[ll_CodeTableRow] = LeftA(as_ImportValue, 50)
				ids_committee.object.facility_id[ll_CodeTableRow] = 1
				
				//Record the row number
				ll_InsertRow = ids_coderownum1.InsertRow(0)
				ids_coderownum1.object.codetable_rownum[ll_InsertRow] = ll_CodeTableRow
				ids_coderownum1.object.impdata_rownum[ll_InsertRow] = al_ImportDataRow
			else
				Return -1 //User specify not allow add new lookup code
			end if
		end if
		
	case "I" //Company
		//---------Begin Modified by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
		/*
		ls_Find = "Lower(facility_name) = '" + of_ReviseExpValue(as_ImportValue) + "'"
		ll_FindRow = ids_company.Find(ls_Find, 1, ids_company.RowCount())
		yield()
		if ll_FindRow > 0 then
			ll_lookup_code = ids_company.object.facility_id[ll_FindRow]
			of_ResetCodeValue(al_ImportDataRow, ai_MapFieldIndex, as_field_type, ll_lookup_code)
		else
			if ai_no_match_procd = 1 then
				//Insert a new record to lookup table
				ll_CodeTableRow = ids_company.InsertRow(0)
				ids_company.object.facility_name[ll_CodeTableRow] = LeftA(as_ImportValue, 150)
				ids_company.object.contact_type2[ll_CodeTableRow] = "B"
				ids_company.object.corp_office_flag[ll_CodeTableRow] = 0
				
				//Record the row number
				ll_InsertRow = ids_coderownum1.InsertRow(0)
				ids_coderownum1.object.codetable_rownum[ll_InsertRow] = ll_CodeTableRow
				ids_coderownum1.object.impdata_rownum[ll_InsertRow] = al_ImportDataRow
			else
				Return -1 //User specify not allow add new lookup code
			end if
		end if
		*/
		Choose Case Lower(as_lu_field_name)
			Case 'facility_name'	
				ls_Find = "Lower(facility_name) = '" + of_ReviseExpValue(as_ImportValue) + "'"
				ll_FindRow = ids_company.Find(ls_Find, 1, ids_company.RowCount())
				if ll_FindRow > 0 then
					ll_lookup_code = ids_company.object.facility_id[ll_FindRow]
					of_ResetCodeValue(al_ImportDataRow, ai_MapFieldIndex, as_field_type, ll_lookup_code)
				else
					if ai_no_match_procd = 1 then
						//Insert a new record to lookup table
						ll_CodeTableRow = ids_company.InsertRow(0)
						ids_company.object.facility_name[ll_CodeTableRow] = Left(as_ImportValue, 150)
						ids_company.object.contact_type2[ll_CodeTableRow] = "B"
						ids_company.object.corp_office_flag[ll_CodeTableRow] = 0
						
						//Record the row number
						ll_InsertRow = ids_coderownum1.InsertRow(0)
						ids_coderownum1.object.codetable_rownum[ll_InsertRow] = ll_CodeTableRow
						ids_coderownum1.object.impdata_rownum[ll_InsertRow] = al_ImportDataRow
					else
						Return -1 //User specify not allow add new lookup code
					end if
				end if
			Case 'street', 'phone', 'ext', 'contact', 'web_address', 'email_address', 'fax'
				ls_Find = Lower(as_lu_field_name) + " = '" + of_ReviseExpValue(as_ImportValue, false) + "'"
				ll_FindRow = ids_company.Find(ls_Find, 1, ids_company.RowCount())
				if ll_FindRow > 0 then
					ll_lookup_code = ids_company.object.facility_id[ll_FindRow]
					of_ResetCodeValue(al_ImportDataRow, ai_MapFieldIndex, as_field_type, ll_lookup_code)
				Else
					Return -3
				End If
				
		End Choose
		//---------End Modfiied ------------------------------------------------------
		
	case "S" //Active Status (V10.1 - Import Active Status)
		ls_Find = "Lower(active_status_name) = '" + of_ReviseExpValue(as_ImportValue) + "'"
		ll_FindRow = ids_active_status.Find(ls_Find, 1, ids_active_status.RowCount())
		yield()
		if ll_FindRow > 0 then
			ll_lookup_code = ids_active_status.object.active_status_id[ll_FindRow]
			of_ResetCodeValue(al_ImportDataRow, ai_MapFieldIndex, as_field_type, ll_lookup_code)
			Return 1
		else
			//---------Begin Modified by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
			//Return -3 //There is no match active_status_id
			Return -13 //There is no match active_status_id
			//---------End Modfiied ------------------------------------------------------
		end if

	case "Q" //QA Metrics (V11.3 QA Import)
		if as_lu_field_name = "indicator" then
			ls_Find = "Lower(indicator) = '" + of_ReviseExpValue(as_ImportValue) + "'"
		else
			ls_Find = "Lower(description) = '" + of_ReviseExpValue(as_ImportValue) + "'"			
		end if
		ll_FindRow = ids_qa_metrics.Find(ls_Find, 1, ids_qa_metrics.RowCount())
		yield()
		if ll_FindRow > 0 then
			ll_lookup_code = ids_qa_metrics.object.qam_id[ll_FindRow]
			of_ResetCodeValue(al_ImportDataRow, ai_MapFieldIndex, as_field_type, ll_lookup_code)
		else
			if ai_no_match_procd = 1 then
				//Insert a new record to lookup table
				ll_CodeTableRow = ids_qa_metrics.InsertRow(0)
				ids_qa_metrics.object.indicator[ll_CodeTableRow] = LeftA(as_ImportValue, 100)
				ids_qa_metrics.object.description[ll_CodeTableRow] = LeftA(as_ImportValue, 250)
				
				//Record the row number
				ll_InsertRow = ids_coderownum1.InsertRow(0)
				ids_coderownum1.object.codetable_rownum[ll_InsertRow] = ll_CodeTableRow
				ids_coderownum1.object.impdata_rownum[ll_InsertRow] = al_ImportDataRow
			else
				Return -1 //User specify not allow add new lookup code
			end if
		end if
end choose
yield()

//Record the row number
if ll_FindRow > 0 and IsNull(ll_lookup_code) then
	ll_InsertRow = ids_coderownum2.InsertRow(0)
	ids_coderownum2.object.codetable_rownum[ll_InsertRow] = ll_FindRow
	ids_coderownum2.object.impdata_rownum[ll_InsertRow] = al_ImportDataRow
end if

Return 1
end function

public function integer of_resetcodevalue (long al_row, integer ai_column, string as_field_type, long al_lookup_code);if not IsNull(al_lookup_code) then
	if as_field_type = "N" then
		ids_intellisoft_table_temp.SetItem(al_Row, ai_Column, al_lookup_code)
	else
		ids_intellisoft_table_temp.SetItem(al_Row, ai_Column, String(al_lookup_code))
	end if
end if

Return 1
end function

public function integer of_updatelookuptable (integer ai_islookupfield, integer ai_mapfieldindex, string as_field_type);long i, ll_Row
long ll_RowCount
long ll_lookup_code
string ls_lu_type
string ls_lu_table

////////////////////////////////////////////////////////////////////////////////////////////
// Get lookup type
if ai_IsLookupField = 1 then
	ls_lu_type = ids_lookup_mapping.object.map_type[1]
	ls_lu_table = ids_lookup_mapping.object.lookup_table[1]
else
	ls_lu_type = ids_mapping_field.object.lu_type[ai_MapFieldIndex]
	ls_lu_table = ids_mapping_field.object.lu_table[ai_MapFieldIndex]
end if

////////////////////////////////////////////////////////////////////////////////////////////
// Set lookup code of lookup table,lookup template,import record according to ids_coderownum1
ll_RowCount = ids_coderownum1.RowCount()
if ll_RowCount > 0 then
	choose case ls_lu_type
		case "A" //Address
			ll_lookup_code = gnv_app.of_get_id("LOOKUP", ll_RowCount)
			for i = 1 to ll_RowCount
				ll_Row = ids_coderownum1.object.codetable_rownum[i]
				ids_address_lookup.object.lookup_code[ll_Row] = ll_lookup_code			
				ll_Row = ids_coderownum1.object.impdata_rownum[i]
				of_ResetCodeValue(ll_Row, ai_MapFieldIndex, as_field_type, ll_lookup_code)
				yield()
				if ai_IsLookupField = 1 then
					ll_Row = ids_coderownum1.object.template_rownum[i]
					ids_lookup_mapping.object.is_lu_code[ll_Row] = ll_lookup_code
				end if				
				ll_lookup_code ++			
			next
			
		case "C" //Code
			ll_lookup_code = gnv_app.of_get_id("LOOKUP", ll_RowCount)
			for i = 1 to ll_RowCount
				ll_Row = ids_coderownum1.object.codetable_rownum[i]
				ids_code_lookup.object.lookup_code[ll_Row] = ll_lookup_code						
				ll_Row = ids_coderownum1.object.impdata_rownum[i]
				of_ResetCodeValue(ll_Row, ai_MapFieldIndex, as_field_type, ll_lookup_code)
				yield()
				if ai_IsLookupField = 1 then
					ll_Row = ids_coderownum1.object.template_rownum[i]
					ids_lookup_mapping.object.is_lu_code[ll_Row] = ll_lookup_code
				end if
				if ls_lu_table = "Contract Category" then
					of_AddContractCategoryRight(ll_lookup_code)
				end if
				if gi_dept_security = 1 and ls_lu_table = "Department" then //Evan 08.28.2009
					of_AddSecurityDepartment(ll_lookup_code)
				end if
				ll_lookup_code ++
			next
			
		case "F" //Facility
			ll_lookup_code = gnv_app.of_get_id("facility_id", ll_RowCount)
			for i = 1 to ll_RowCount			
				ll_Row = ids_coderownum1.object.codetable_rownum[i]
				ids_facility.object.facility_id[ll_Row] = ll_lookup_code			
				ll_Row = ids_coderownum1.object.impdata_rownum[i]
				of_ResetCodeValue(ll_Row, ai_MapFieldIndex, as_field_type, ll_lookup_code)	
				yield()
				if ai_IsLookupField = 1 then
					ll_Row = ids_coderownum1.object.template_rownum[i]
					ids_lookup_mapping.object.is_lu_code[ll_Row] = ll_lookup_code
				end if			
				ll_lookup_code ++
			next
			
		case "M" //Committee
			ll_lookup_code = gnv_app.of_get_id("committee_id", ll_RowCount)
			for i = 1 to ll_RowCount
				ll_Row = ids_coderownum1.object.codetable_rownum[i]
				ids_committee.object.committee_id[ll_Row] = ll_lookup_code		
				ll_Row = ids_coderownum1.object.impdata_rownum[i]
				of_ResetCodeValue(ll_Row, ai_MapFieldIndex, as_field_type, ll_lookup_code)	
				yield()
				if ai_IsLookupField = 1 then
					ll_Row = ids_coderownum1.object.template_rownum[i]
					ids_lookup_mapping.object.is_lu_code[ll_Row] = ll_lookup_code
				end if
				ll_lookup_code ++
			next
			
		case "I" //Company
			SELECT max(facility_id) INTO :ll_lookup_code FROM app_facility;
			if IsNull(ll_lookup_code) then ll_lookup_code = 0			
			for i = 1 to ll_RowCount
				ll_lookup_code ++
				ll_Row = ids_coderownum1.object.codetable_rownum[i]
				ids_company.object.facility_id[ll_Row] = ll_lookup_code
				ll_Row = ids_coderownum1.object.impdata_rownum[i]
				of_ResetCodeValue(ll_Row, ai_MapFieldIndex, as_field_type, ll_lookup_code)
				yield()
				if ai_IsLookupField = 1 then
					ll_Row = ids_coderownum1.object.template_rownum[i]
					ids_lookup_mapping.object.is_lu_code[ll_Row] = ll_lookup_code
				end if
			next

		case "Q" //QA Metrics (V11.3 QA Import)
			SELECT max(qam_id) INTO :ll_lookup_code FROM qa_metrics;
			if IsNull(ll_lookup_code) then ll_lookup_code = 0
			for i = 1 to ll_RowCount
				ll_lookup_code ++
				ll_Row = ids_coderownum1.object.codetable_rownum[i]
				ids_qa_metrics.object.qam_id[ll_Row] = ll_lookup_code
				ll_Row = ids_coderownum1.object.impdata_rownum[i]
				of_ResetCodeValue(ll_Row, ai_MapFieldIndex, as_field_type, ll_lookup_code)
				yield()
				if ai_IsLookupField = 1 then
					ll_Row = ids_coderownum1.object.template_rownum[i]
					ids_lookup_mapping.object.is_lu_code[ll_Row] = ll_lookup_code
				end if
			next
	end choose
	ids_coderownum1.Reset()
end if

////////////////////////////////////////////////////////////////////////////////////////////
// Set lookup code of import record according to ids_coderownum2
ll_RowCount = ids_coderownum2.RowCount()
if ll_RowCount > 0 then
	if ai_IsLookupField = 1 then
		for i = 1 to ll_RowCount
			ll_Row = ids_coderownum2.object.template_rownum[i]
			ll_lookup_code = ids_lookup_mapping.object.is_lu_code[ll_Row]
			ll_Row = ids_coderownum2.object.impdata_rownum[i]
			of_ResetCodeValue(ll_Row, ai_MapFieldIndex, as_field_type, ll_lookup_code)
			yield()
		next
	else
		for i = 1 to ll_RowCount
			ll_Row = ids_coderownum2.object.codetable_rownum[i]
			choose case ls_lu_type
				case "A" //Address
					ll_lookup_code = ids_address_lookup.object.lookup_code[ll_Row]								
				case "C" //Code
					ll_lookup_code = ids_code_lookup.object.lookup_code[ll_Row]								
				case "F" //Facility
					ll_lookup_code = ids_facility.object.facility_id[ll_Row]
				case "M" //Committee
					ll_lookup_code = ids_committee.object.committee_id[ll_Row]
				case "I" //Company
					ll_lookup_code = ids_company.object.facility_id[ll_Row]
				case "Q" //QA Metrics (V11.3 QA Import)
					ll_lookup_code = ids_qa_metrics.object.qam_id[ll_Row]
			end choose
			ll_Row = ids_coderownum2.object.impdata_rownum[i]
			of_ResetCodeValue(ll_Row, ai_MapFieldIndex, as_field_type, ll_lookup_code)
			yield()
		next
	end if
	ids_coderownum2.Reset()
end if

////////////////////////////////////////////////////////////////////////////////////////////
// if Code or Address Lookup data have been changed
if ids_code_lookup.ModifiedCount() > 0 then
	ib_IsCodeLookupChanged = true
	is_lookup_name[upperbound(is_lookup_name) + 1] = ls_lu_table
end if
if ids_address_lookup.ModifiedCount() > 0 then
	is_lookup_name[upperbound(is_lookup_name) + 1] = ls_lu_table
end if

// Update
gnv_appeondb.of_StartQueue()
choose case ls_lu_type
	case "A" //Address
		ids_address_lookup.Update()
	case "C" //Code
		ids_code_lookup.Update()
	case "F" //Facility
		ids_facility.Update()
	case "M" //Committee
		ids_committee.Update()
	case "I" //Company
		ids_company.Update()
	case "Q" //QA Metrics (V11.3 QA Import)
		ids_qa_metrics.Update()
end choose
yield()
ids_lookup_mapping.Update()
ids_category_right.Update()
yield()
ids_security_user_dept.Update()
of_CompleteTrans(true)
gnv_appeondb.of_CommitQueue()
ids_security_user_dept.Reset() //V10.1 - Lookup Table Import
yield()
Return 1
end function

public function integer of_disposelookupcode (long al_importdatarow, integer ai_mapfieldindex, string as_importvalue, string as_field_type, integer ai_no_match_procd);long ll_RowCount
long ll_FindRow
long ll_InsertRow
long ll_CodeTableRow
long ll_TempRow
long ll_lookup_code
string ls_map_type

//Check import value if null
as_ImportValue = Trim(as_ImportValue)
if IsNull(as_ImportValue) or as_ImportValue = "" then Return 1

//Lookup code from template
ll_RowCount = ids_lookup_mapping.RowCount()
ll_FindRow = ids_lookup_mapping.Find("Lower(import_value) = '" + of_ReviseExpValue(as_ImportValue) + "'", 1, ll_RowCount)
yield()
if ll_FindRow > 0 then
	//Have match code
	ll_lookup_code = ids_lookup_mapping.object.is_lu_code[ll_FindRow]
	if IsNull(ll_lookup_code) then
		//Record the row number
		ll_InsertRow = ids_coderownum2.InsertRow(0)
		ids_coderownum2.object.template_rownum[ll_InsertRow] = ll_FindRow
		ids_coderownum2.object.impdata_rownum[ll_InsertRow] = al_ImportDataRow
	else
		//---------Begin Added by (Appeon)Stephen 12.19.2013 for Continuum Health Partners UAT testing--------
		ls_map_type = ids_lookup_mapping.object.map_type[ll_FindRow]
		 ids_mapping_field.setitem(ai_mapfieldindex, "lu_type", ls_map_type)	
		 //---------End Added ------------------------------------------------------
		 
		//Set lookup code
		of_ResetCodeValue(al_ImportDataRow, ai_MapFieldIndex, as_field_type, ll_lookup_code)
	end if
else
	//No match code
	if ai_no_match_procd = 1 then
		//Insert a new record to lookup table
		choose case ids_lookup_mapping.object.map_type[1]
			case "A" //Address
				ll_FindRow = ids_address_lookup.Find("Lower(entity_name) = '" + of_ReviseExpValue(as_ImportValue) + "'", 1, ids_address_lookup.RowCount())
				yield()
				if ll_FindRow > 0 then
					ll_lookup_code = ids_address_lookup.object.lookup_code[ll_FindRow]
				else
					ll_CodeTableRow = ids_address_lookup.InsertRow(0)			
					ids_address_lookup.object.lookup_name[ll_CodeTableRow] = ids_lookup_mapping.object.lookup_table[1]
					ids_address_lookup.object.code[ll_CodeTableRow] = LeftA(as_ImportValue, 15)
					ids_address_lookup.object.entity_name[ll_CodeTableRow] = LeftA(as_ImportValue, 100)
				end if
				
			case "C" //Code				
				ll_FindRow = ids_code_lookup.Find("Lower(description) = '" + of_ReviseExpValue(as_ImportValue) + "'", 1, ids_code_lookup.RowCount())
				yield()
				if ll_FindRow > 0 then
					ll_lookup_code = ids_code_lookup.object.lookup_code[ll_FindRow]					
				else
					ll_CodeTableRow = ids_code_lookup.InsertRow(0)
					ids_code_lookup.object.lookup_name[ll_CodeTableRow] = ids_lookup_mapping.object.lookup_table[1]
					ids_code_lookup.object.code[ll_CodeTableRow] = LeftA(as_ImportValue, 30)
					ids_code_lookup.object.description[ll_CodeTableRow] = LeftA(as_ImportValue, 75)
				end if
								
			case "F" //Facility
				ll_FindRow = ids_facility.Find("Lower(facility_name) = '" + of_ReviseExpValue(as_ImportValue) + "'", 1, ids_facility.RowCount())
				yield()
				if ll_FindRow > 0 then
					ll_lookup_code = ids_facility.object.facility_id[ll_FindRow]
				else
					Return -2 //There is no match Facility_id
				end if	
								
			case "M" //Committee
				ll_FindRow = ids_committee.Find("Lower(committee_name) = '" + of_ReviseExpValue(as_ImportValue) + "'", 1, ids_committee.RowCount())
				yield()
				if ll_FindRow > 0 then
					ll_lookup_code = ids_committee.object.committee_id[ll_FindRow]
				else
					ll_CodeTableRow = ids_committee.InsertRow(0)
					ids_committee.object.committee_name[ll_CodeTableRow] = LeftA(as_ImportValue, 50)
					ids_committee.object.facility_id[ll_CodeTableRow] = 1
				end if
				
			case "I" //Company
				ll_FindRow = ids_company.Find("Lower(facility_name) = '" + of_ReviseExpValue(as_ImportValue) + "'", 1, ids_company.RowCount())
				yield()
				if ll_FindRow > 0 then
					ll_lookup_code = ids_company.object.facility_id[ll_FindRow]
				else
					ll_CodeTableRow = ids_company.InsertRow(0)
					ids_company.object.facility_name[ll_CodeTableRow] = LeftA(as_ImportValue, 150)
					ids_company.object.contact_type2[ll_CodeTableRow] = "B"
					ids_company.object.corp_office_flag[ll_CodeTableRow] = 0
				end if
				
			case "S" //Active Status (V10.1 - Import Active Status)
				ll_FindRow = ids_active_status.Find("Lower(active_status_name) = '" + of_ReviseExpValue(as_ImportValue) + "'", 1, ids_active_status.RowCount())
				yield()
				if ll_FindRow > 0 then
					ll_lookup_code = ids_active_status.object.active_status_id[ll_FindRow]
				else
					//---------Begin Modified by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
					//Return -3 //There is no match active_status_id
					Return -13 //There is no match active_status_id
					//---------End Modfiied ------------------------------------------------------
				end if
	
			case "Q" //QA Metrics (V11.3 QA Import)
				ll_FindRow = ids_qa_metrics.Find("Lower(description) = '" + of_ReviseExpValue(as_ImportValue) + "'", 1, ids_qa_metrics.RowCount())
				yield()
				if ll_FindRow > 0 then
					ll_lookup_code = ids_qa_metrics.object.qam_id[ll_FindRow]
				else
					ll_CodeTableRow = ids_qa_metrics.InsertRow(0)
					ids_qa_metrics.object.description[ll_CodeTableRow] = LeftA(as_ImportValue, 250)
					ids_qa_metrics.object.indicator[ll_CodeTableRow] = LeftA(as_ImportValue, 100)
				end if
		end choose
		yield()	
		//Insert a new record to template
		ll_TempRow = ids_lookup_mapping.InsertRow(0)
		ids_lookup_mapping.object.ilm_id[ll_TempRow] = ids_lookup_mapping.object.ilm_id[1]
		ids_lookup_mapping.object.import_value[ll_TempRow] = as_ImportValue
		
		//Set lookup code if found it
		if ll_FindRow > 0 then
			//Set lookup code
			ids_lookup_mapping.object.is_lu_code[ll_TempRow] = ll_lookup_code
			of_ResetCodeValue(al_ImportDataRow, ai_MapFieldIndex, as_field_type, ll_lookup_code)
		else
			//Record the row number
			ll_InsertRow = ids_coderownum1.InsertRow(0)
			ids_coderownum1.object.template_rownum[ll_InsertRow] = ll_TempRow
			ids_coderownum1.object.codetable_rownum[ll_InsertRow] = ll_CodeTableRow
			ids_coderownum1.object.impdata_rownum[ll_InsertRow] = al_ImportDataRow
		end if
		yield()
	else
		Return -1 //User specify not allow add new lookup code
	end if
end if

Return 1
end function

public function integer of_disposenullvalue (integer ai_null_type, long al_importdatarow, integer ai_mapfieldindex, ref string as_importvalue);string ls_link_imp_field

//Check value of import if null
if not (IsNull(as_ImportValue) or as_ImportValue = "") then 
	Return 1
end if

//Dispose null value
choose case ai_null_type
	//case 1 //Set null
	
	case 2   //Use text default
		as_ImportValue = ids_mapping_field.object.null_value[ai_MapFieldIndex]
		
	case 3   //Use column value
		ls_link_imp_field = ids_mapping_field.object.link_imp_field[ai_MapFieldIndex]
		if LenA(ls_link_imp_field) > 0 then
			as_ImportValue = ids_imp_data.GetItemString(al_ImportDataRow, ls_link_imp_field)
		end if
end choose

Return 1
end function

public function string of_convertfieldalias (string as_string);string  ls_Char
string  ls_Return
integer i, li_Len

as_String = Lower(Trim(as_String))
li_Len = LenA(as_String)

for i = 1 to li_Len
	ls_Char = MidA(as_String, i, 1)
	if ls_Char = "_" then ls_Char = " "
	if MidA(as_String, i - 1, 1) = "_" then	ls_Char = Upper(ls_Char)
	ls_Return += ls_Char
next
ls_Return = Trim(ls_Return)
ls_Return = Upper(LeftA(ls_Return, 1)) + RightA(ls_Return, LenA(ls_Return) - 1)

Return ls_Return
end function

public function integer of_run_project (integer ai_project, string as_from);//--------------------------- APPEON BEGIN ---------------------------
//$<delete> 03.10.2008 By: Evan
//$<reason> Due to have no consider IntelliContract import, so that delete this function.
/*
//Start Code Change ----12.14.2007 #V8 maha -- created
//used to run a series of imports connected to a project
integer li_imp_cnt
integer i
integer ic
integer res
long ll_imp
datastore lds_imps

lds_imps  = create datastore

lds_imps.dataobject = "d_import_ds_project"
lds_imps.settransobject(sqlca)
ic = lds_imps.retrieve(ai_project)

if ic < 1 then return -1 //no imports

for i = 1 to ic
	ll_imp = lds_imps.getitemnumber(i,"import_id")
	//this.Event ue_ExecuteImport1(ll_imp,adw_imp) //Delete by evan on 12.17.2007
	this.of_Execute(ll_imp, false) //Add by evan on 02.18.2008
	//if res > 0 then li_imp_cnt++
next
if IsValid(w_import_progressbar) then Close(w_import_progressbar) //Add by evan on 02.18.2008

destroy lds_imps

return li_imp_cnt
*/

Return -1
//---------------------------- APPEON END ----------------------------

end function

public function integer of_execute (long al_import_id, boolean ab_isdoprompt);ib_IsDoPrompt = ab_IsDoPrompt
ib_IsExecute1 = true

//Get import information
of_GetImportInfo(al_import_id, true)

//Initialize progress bar
if IsValid(w_import_progressbar) then Close(w_import_progressbar)
Open(w_import_progressbar)
w_import_progressbar.of_ResetStep()
w_import_progressbar.of_SetImportID(al_import_id)
w_import_progressbar.of_SetTableCount(ids_table_record.RowCount())
w_import_progressbar.of_SetRemainCount(ids_table_record.RowCount())
if ids_table_record.RowCount() > 0 then
	w_import_progressbar.of_SetTableName(ids_table_record.object.table_name_allias[1])
end if

//Execute Import data process
Open(w_import_temp)
this.Event ue_Main(al_import_id)

//Close temporary window
if IsValid(w_import_temp) then 
	Close(w_import_temp)
end if

Return 1
end function

public function integer of_getkeyfields (ref integer as_keyfieldindex[], ref string as_keyfieldname[]);integer li_MapFieldIndex

// Get key fields
for li_MapFieldIndex = 1 to ids_mapping_field.RowCount()
	if ids_mapping_field.object.key_field[li_MapFieldIndex] = 1 then
		as_KeyFieldIndex[UpperBound(as_KeyFieldIndex) + 1] = li_MapFieldIndex
		as_KeyFieldName[UpperBound(as_KeyFieldName) + 1] = ids_mapping_field.object.field_name[li_MapFieldIndex]
	end if
next

Return UpperBound(as_KeyFieldIndex)
end function

public function integer of_log (string as_text);String ls_err_value

ls_err_value = ids_log_proc.Object.err_value[1]
IF LenA(ls_err_value) > 0 THEN
	ids_log_proc.Object.err_value[1] = ls_err_value + " " + as_Text
ELSE
	ids_log_proc.Object.err_value[1] = as_Text
END IF
//Added by Nova 01.25.2010 - v10.1 Scheduler Functionality
inv_message.of_MessageBox('',string(ids_log_proc.Object.err_value[1]),false)
RETURN 1

end function

public function long of_log (long al_error_record, string as_error_field, long al_err_type, string as_err_value);long ll_Row
long ll_InsertRow
long ll_error_count

//Increase error count
ll_Row = ids_log_table.GetRow()
ll_error_count = ids_log_table.object.error_count[ll_Row]
if IsNull(ll_error_count) then ll_error_count = 0
ll_error_count ++
ids_log_table.object.error_count[ll_Row] = ll_error_count
il_ErrorCount ++

//Insert error log
ll_InsertRow = ids_log_error.InsertRow(0)
ids_log_error.object.process_tables_id[ll_InsertRow] = ids_table_record.GetRow()

ids_log_error.object.error_field[ll_InsertRow] = as_error_field
ids_log_error.object.err_type[ll_InsertRow] = al_err_type
ids_log_error.object.err_value[ll_InsertRow] = LeftA(as_err_value,2000) //300) //modify by stephen 05.06.2013 --for database error is cut off in IntelliImport 
if al_error_record > 0 then
	ids_log_error.object.error_record[ll_InsertRow] = al_error_record
end if

choose case al_err_type
	case IL_ERRTYPE_OTHER
		ids_log_error.object.err_type_text[ll_InsertRow] = "Other"
	case IL_ERRTYPE_MAPDESIGN
		ids_log_error.object.err_type_text[ll_InsertRow] = "Design"
	case IL_ERRTYPE_VERIFYVALUE
		ids_log_error.object.err_type_text[ll_InsertRow] = "Verify value"
	case IL_ERRTYPE_DATAINTEGRITY
		ids_log_error.object.err_type_text[ll_InsertRow] = "Data integrity"
	case IL_ERRTYPE_ADDVERIFY
		ids_log_error.object.err_type_text[ll_InsertRow] = "Verification"
	case IL_ERRTYPE_UPDATE
		ids_log_error.object.err_type_text[ll_InsertRow] = "DB Update"
end choose
//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
//--------Begin Modified by  Nova 08.10.2010------------------------
//inv_message.of_MessageBox('',ids_log_error.object.process_tables_id[ll_InsertRow] +as_error_field+al_err_type+  Left(as_err_value, 300)+ids_log_error.object.err_type_text[ll_InsertRow],false)
inv_message.of_MessageBox('',string(ids_log_error.object.process_tables_id[ll_InsertRow]) +as_error_field+string(al_err_type)+  Left(as_err_value, 300)+string(ids_log_error.object.err_type_text[ll_InsertRow]),false)
//--------End Modified --------------------------------------------

Return ll_error_count
end function

public function integer of_log (boolean ab_isimport, string as_text, ref string as_errortext[]);integer li_ErrorCount

li_ErrorCount = UpperBound(as_ErrorText) + 1
as_ErrorText[li_ErrorCount] = as_Text

if ab_IsImport then
	of_Log(0, "", IL_ERRTYPE_MAPDESIGN, as_Text)
	if not of_IsContinue() then Return -1
	Return -2
end if

Return 1
end function

public function integer of_resetfieldtype ();string ls_field_type
integer li_MapFieldIndex

for li_MapFieldIndex = 1 to ids_mapping_field.RowCount()
	//Get field type	
	ls_field_type = ids_intellisoft_table_temp.of_GetColType("#" + String(li_MapFieldIndex))
		
	//Reset field type for ids_mapping_field
	ids_mapping_field.object.field_type[li_MapFieldIndex] = ls_field_type
next

Return 1
end function

public function string of_checkimporttable (ref datastore ads_data);integer i
string  ls_table_name
boolean lb_IsNeedBasicTable = false
boolean lb_IsBasicTableExists = false
boolean lb_IsNeedCompanyTable = false
boolean lb_IsCompanyTableExists = false
boolean lb_IsNeedContactTable = false
boolean lb_IsContactTableExists = false
//---------Begin Added by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
boolean lb_IsMultiHeader = false //added by gavins 20130222
boolean lb_IsMultiDetails = false
//---------End Added ------------------------------------------------------

if ads_data.RowCount() <= 0 then Return "There is no import table record."

for i = 1 to ads_data.RowCount()
	ls_table_name = Lower(ads_data.object.table_name[i])
	
	// if need company table
	if ls_table_name = "ctx_contacts" then lb_IsNeedCompanyTable = true
	if ls_table_name = "app_facility" then lb_IsCompanyTableExists = true
	
	// if need contact table
	if ls_table_name = "ctx_contacts_numbers" or ls_table_name = "ctx_contract_contacts" then lb_IsNeedContactTable = true
	if ls_table_name = "ctx_contacts" then lb_IsContactTableExists = true
	
	//---------Begin Added by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
	//if need multi header
	If ls_table_name = "ctx_custom_multi_hdr" Then lb_IsMultiHeader = True
	If ls_table_name = "ctx_custom_multi_detail" Then lb_IsMultiDetails = True
	//---------End Added ------------------------------------------------------
	
	// if need basic table
	choose case ls_table_name
		case "pd_basic", "ctx_basic_info", "app_facility", "ctx_contacts", "ctx_contacts_numbers", "address_lookup", "code_lookup", "qa_metrics" //V11.3 QA Import
		case "facility", "group_multi_loc", "group_practice" //(Appeon)Stephen 12.25.2013 - V141 Import Modifications for Facility and Group
	     case else
			lb_IsNeedBasicTable = true
	end choose
	if ls_table_name = "pd_basic" or ls_table_name = "ctx_basic_info" then
		lb_IsBasicTableExists = true
	end if	
next

// Do some checking
if lb_IsNeedCompanyTable and not lb_IsCompanyTableExists then Return "'Companies' table is required."
if lb_IsNeedContactTable and not lb_IsContactTableExists then Return "'Contacts' table is required."
if lb_IsNeedBasicTable and not lb_IsBasicTableExists then Return "'Basic Information' table is required."
if lb_IsMultiDetails and not lb_IsMultiHeader then Return "'Custom Multi Header' table is required." //(Appeon)Harry 01.23.2014 - V142 ISG-CLX

Return ""
end function

public function string of_generateerrortitle (ref datastore ads_data, long al_row);string ls_Return

ls_Return = "[Record id: " + String(ads_data.object.table_records_id[al_row]) + ", "
ls_Return += "IntelliSoft Table: " + ads_data.object.table_name_allias[al_row] + ", "
ls_Return += "Runtime Error Count: " + String(ads_data.object.error_count[al_row]) + ", "
ls_Return += "Modify Record Count: " + String(ads_data.object.mod_count[al_row]) + ", "
ls_Return += "Add Record Count: " + String(ads_data.object.add_count[al_row]) + "]"

Return ls_Return
end function

public function string of_generateerrordetail (ref datastore ads_data, long al_row);string ls_Return

ls_Return += of_AddSpace(ads_data.object.error_record[al_row], 15)
ls_Return += of_AddSpace(ads_data.object.error_field[al_row], 14)
ls_Return += of_AddSpace(ads_data.object.err_type_text[al_row], 14)
ls_Return += of_AddSpace(ads_data.object.err_value[al_row], 0)

Return ls_Return
end function

public function string of_addspace (any aa_value, integer ai_len);string ls_Value
string ls_Return

ls_Value = String(aa_Value)
if IsNull(ls_Value) then ls_Value = ""
ls_Return = ls_Value + Space(ai_Len - LenA(ls_Value))

Return ls_Return
end function

public function boolean of_isstopimport ();if ids_import_hdr.object.err_process[ids_import_hdr.GetRow()] = 1 then
	if il_ErrorCount > 0 then Return true
end if

Return false
end function

public function integer of_cacheforeignkey (string as_imp_field, string as_table_field);long ll_IDRow
long i, ll_RowCount
long ll_fk_id

ll_RowCount = ids_imp_data.RowCount()

// Assign foreign key to each row of ids_imp_data
for i = 1 to ll_RowCount
	ll_IDRow = ids_imp_data.GetItemNumber(i, as_imp_field)
	if ll_IDRow > 0 then
		ll_fk_id = ids_intellisoft_table.GetItemNumber(ll_IDRow, as_table_field)
		ids_imp_data.SetItem(i, as_imp_field,	ll_fk_id)
	end if
next

Return 1
end function

public function integer of_gettablekey (string as_table_name, ref string as_key[]);//////////////////////////////////////////////////////////////////////
// $<function> of_gettablekey
// $<arguments>
//			string		as_table_name
//			string		as_key[]
// $<returns> integer
// $<description> Get primary key fields
//////////////////////////////////////////////////////////////////////
// $<add> Evan 04.10.2009
//////////////////////////////////////////////////////////////////////

string ls_key
string ls_table_name
string ls_v1,ls_v2,ls_v3,ls_v4,ls_v5,ls_v6
integer li_v5

ls_table_name = Lower(as_table_name)

if gs_DBType = "ASA" then
	DECLARE cur_keys CURSOR FOR
		SELECT column_name = syscolumn.column_name
		FROM  syscolumn, systable
		WHERE syscolumn.table_id = systable.table_id AND
				systable.table_name = :ls_table_name AND
				syscolumn.pkey = 'Y';
	OPEN cur_keys;
	do while true
		FETCH cur_keys INTO :ls_key;
		if SQLCA.SQLCode = 0 then
			as_key[UpperBound(as_key[]) + 1] = ls_key
		else
			exit
		end if
	loop
	CLOSE cur_keys;
else
	DECLARE lp_pkeys PROCEDURE FOR sp_pkeys(:ls_table_name);
	EXECUTE lp_pkeys;
	do while true
		FETCH lp_pkeys INTO :ls_v1, :ls_v2, :ls_v3, :ls_key, :li_v5, :ls_v6;
		if SQLCA.SQLCode = 0 then
			as_key[UpperBound(as_key[]) + 1] = ls_key
		else
			exit
		end if
	loop
	CLOSE lp_pkeys;
end if

Return UpperBound(as_key[])
end function

public function integer of_modifyupdateproperty (datastore ads_data, string as_table_name);//////////////////////////////////////////////////////////////////////
// $<function> of_modifyupdateproperty
// $<arguments>
//			datastore	ads_data
//			string		as_table_name
// $<returns> integer
// $<description> Modify datawindow update properties
//////////////////////////////////////////////////////////////////////
// $<add> Evan 04.10.2009
//////////////////////////////////////////////////////////////////////

string ls_key[]
integer i, li_Count

if ads_data.Describe("datawindow.table.updatetable") <> "?" then Return 1
if of_GetTableKey(as_table_name, ls_key[]) <= 0 then Return -1

// Datawindow update property
ads_data.Modify("datawindow.table.updatetable= '" + as_table_name + "'")

// Columns update property
li_Count = Integer(ads_data.Describe("datawindow.column.count"))
for i = 1 to li_Count
	ads_data.Modify("#" + String(i) + ".update = yes")
next

// Key field property
li_Count = UpperBound(ls_key[])
for i = 1 to li_Count
	ads_data.Modify(ls_key[i] + ".key = yes")
next

Return 1
end function

public function integer of_addsecuritydepartment (long al_department_id);//////////////////////////////////////////////////////////////////////
// $<function> of_addsecuritydepartment
// $<arguments>
//			long	al_department_id
// $<returns> integer
// $<description> Create the security_user_department records
//////////////////////////////////////////////////////////////////////
// $<add> Evan 08.28.2009
//////////////////////////////////////////////////////////////////////

string ls_user_id
long i, ll_InsertRow

// Get max ID
if il_user_depart_id = 0 then
	SELECT max(user_depart_id) INTO :il_user_depart_id FROM security_user_department;
	if IsNull(il_user_depart_id) then il_user_depart_id = 0
end if

// Loop through all users and department and setup department security
for i = 1 to ids_user.RowCount()
	il_user_depart_id ++
	ls_user_id = ids_user.GetItemString(i, "user_id")
	ll_InsertRow = ids_security_user_dept.InsertRow(0)
	ids_security_user_dept.SetItem(ll_InsertRow, "user_depart_id", il_user_depart_id)
	ids_security_user_dept.SetItem(ll_InsertRow, "user_id", ls_user_id)
	ids_security_user_dept.SetItem(ll_InsertRow, "department_id", al_department_id)
	ids_security_user_dept.SetItem(ll_InsertRow, "access_rights", 1)
next

Return 1
end function

public function string of_get_sched_msg ();//Get messages of the schedule - alfee 02.06.2010

return inv_message.of_get_message()
end function

public function integer of_get_sched_cnt ();//Get processed count of the schedule - alfee 02.06.2010

return inv_message.of_get_proc_cnt( )
end function

public function integer of_set_sched_flag (boolean ab_flag);//Set the schedule flag - Scheduler - alfee 02.06.2010

ib_schedule = ab_flag

IF Isvalid(inv_message) THEN
	inv_message.of_set_schedule(ab_flag)		
END IF

RETURN 1
end function

public function integer of_formatdatefield (long al_row, string as_field);//====================================================================
// $<function> of_formatdatefield()
// $<arguments>
// 	value	long		al_row
// 	value	string	as_field
// $<returns> integer
// $<description> Format date value as 'yyyy-mm-dd'
// $<add> (Appeon) evan 07.27.2011
//====================================================================

string ls_OldValue
string ls_NewValue
integer li_Pos

ls_OldValue = ids_imp_data.GetItemString(al_Row, as_Field)
li_Pos = Pos(ls_OldValue, " ")
if li_Pos > 0 then
	ls_NewValue = Left(ls_OldValue, li_Pos - 1)
end if

if IsDate(ls_NewValue) then
	ls_NewValue = String(Date(ls_NewValue), "yyyy-mm-dd")
	ids_imp_data.SetItem(al_Row, as_Field, ls_NewValue)
else
	Return -1
end if
	
Return 1
end function

public function integer of_getkeyfields_new (ref integer as_keyfieldindex[], ref string as_keyfieldname[], ref string as_importfieldname[]);//////////////////////////////////////////////////////////////////////
// $<function> of_store_file
// $<arguments>
//               long al_row
// $<returns> (integer)
// $<description> V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Stephen 12.25.2012
//////////////////////////////////////////////////////////////////////

integer li_MapFieldIndex

// Get key fields
for li_MapFieldIndex = 1 to ids_mapping_field.RowCount()
	if ids_mapping_field.object.key_field[li_MapFieldIndex] = 1 then
		as_KeyFieldIndex[UpperBound(as_KeyFieldIndex) + 1] = li_MapFieldIndex
		as_KeyFieldName[UpperBound(as_KeyFieldName) + 1] = ids_mapping_field.object.field_name[li_MapFieldIndex]
		as_importfieldname[UpperBound(as_importfieldname) + 1] = ids_mapping_field.object.imp_field_name[li_MapFieldIndex]
	end if
next

Return UpperBound(as_KeyFieldIndex)
end function

public function string of_getimport_pracname (datastore ads_imp_data, long al_row);//////////////////////////////////////////////////////////////////////
// $<function> of_getimport_pracname
// $<arguments>
//               string as_prac_name
// $<returns> (integer)
// $<description> V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Stephen 01.02.2013
//////////////////////////////////////////////////////////////////////

integer li_MapFieldIndex
string   ls_prac_name, ls_imp_field
string   ls_first, ls_last

// Get key fields
ls_prac_name = ""
for li_MapFieldIndex = 1 to ids_mapping_field.RowCount()
	if ids_mapping_field.object.field_name[li_MapFieldIndex] = "last_name" then
		ls_imp_field = ids_mapping_field.object.imp_field_name[li_MapFieldIndex]
		ls_last = ads_imp_data.getitemstring(al_row, ls_imp_field) 
	end if
	if ids_mapping_field.object.field_name[li_MapFieldIndex] = "first_name" then
		ls_imp_field = ids_mapping_field.object.imp_field_name[li_MapFieldIndex]
		ls_first = ads_imp_data.getitemstring(al_row, ls_imp_field)
	end if
next

if not isnull(ls_last) then 
	ls_prac_name = ls_last + "," + ls_first
else
	ls_prac_name = ls_first
end if
Return ls_prac_name

end function

public function integer of_import_store_hdr (long al_import_id, long al_table_id, string as_table_name, long al_record_id);//////////////////////////////////////////////////////////////////////
// $<function> of_import_store_hdr
// $<arguments>
//               N/A
// $<returns> (integer)
// $<description> V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Stephen 12.28.2012
//////////////////////////////////////////////////////////////////////
long ll_hdr_id, ll_hdr_row, ll_row
integer li_module
string ls_table_allias

select isoft_module,table_name_allias into :li_module, :ls_table_allias from import_tables where table_id = :al_table_id using sqlca;
if isnull(li_module) or li_module <>1 then return 0

choose case as_table_name
	case  "app_facility", "address_lookup", "code_lookup", "qa_metrics" 
		return 0
	case else
		//import_audit_hdr
		if as_table_name = "pd_basic" then
			select max(Hdr_id) into :ll_hdr_id from import_audit_hdr using sqlca;
			if isnull(ll_hdr_id) then ll_hdr_id = 0
			
			ll_hdr_id +=1
			il_hdr_id = ll_hdr_id
			ll_hdr_row = ids_imp_audit_hdr.insertrow(0)
			ids_imp_audit_hdr.setitem(ll_hdr_row, "hdr_id", ll_hdr_id)
			ids_imp_audit_hdr.setitem(ll_hdr_row, "import_id", al_import_id)
			ids_imp_audit_hdr.setitem(ll_hdr_row, "audit_status", 'N')
			ids_imp_audit_hdr.setitem(ll_hdr_row, "create_date", idt_CurrentTime)
			ids_imp_audit_hdr.setitem(ll_hdr_row, "create_user", gs_user_id)
		end if	
		
		//save import log --import_process_tables
		ll_row = ids_audit_log_table.InsertRow(0)
		ids_audit_log_table.object.table_records_id[ll_row] = al_record_id
		ids_audit_log_table.object.table_id[ll_row] = al_table_id
		ids_audit_log_table.object.imp_type[ll_row] = 'A'
		ids_audit_log_table.object.error_count[ll_row] = 0
		ids_audit_log_table.object.error_count[ll_row] = 0
		ids_audit_log_table.object.mod_count[ll_row] = 0
		ids_audit_log_table.object.add_count[ll_row] = 0
		
		//save import data
		if of_import_store_item(al_import_id, al_table_id, as_table_name, il_hdr_id, ls_table_allias, al_record_id) = -1 then 
			return -1
		end if
		
		//import_audit_hdr
		if as_table_name = "pd_basic" and not(ll_hdr_id = 0 or isnull(ll_hdr_id)) then
			ids_imp_audit_hdr.setitem(ll_hdr_row, "Num_new", ii_new)
			ids_imp_audit_hdr.setitem(ll_hdr_row, "Num_modify", ii_modify)
		end if			
		
end choose	
//------------------- APPEON BEGIN -------------------
	
return 1
end function

public function integer of_import_audit_start ();//////////////////////////////////////////////////////////////////////
// $<function> of_import_audit_start
// $<arguments>
//               N/A
// $<returns> (integer)
// $<description> Dynamic create import_audit datastore
//                       V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Stephen 01.31.2013
//////////////////////////////////////////////////////////////////////
string ls_fields, ls_Syntax, ls_Error
integer li_return

ib_import_audit = false
if not isvalid(w_import_painter) then return 1
if w_import_painter.tab_1.tabpage_data.cbx_store_temp.checked then
	if isvalid(ids_imp_audit_hdr) then destroy ids_imp_audit_hdr
	ids_imp_audit_hdr = create n_import_ds
	ls_fields = " hdr_id, import_id, audit_status, num_new, num_modify, process_id, create_date, create_user "
	li_return = of_dyncreate_auditdw(ids_imp_audit_hdr, "import_audit_hdr", ls_fields)
	if li_return = -1 then return -1	
	
	if isvalid(ids_imp_audit_item) then destroy ids_imp_audit_item
	ids_imp_audit_item = create n_import_ds
	ls_fields = " rec_id, Hdr_id, Import_id, Audit_type, Field_name, Seq_no, Table_id, New_prac, Prac_id, facility_id, old_value, new_value, status, create_by, create_date, prac_name, Table_alias, Field_lu_type, key_field, table_records_id  " //(Appeon)Stephen 2013-10-14 - add column table_records_id --Bug 3679
	li_return = of_dyncreate_auditdw(ids_imp_audit_item, "import_audit_item", ls_fields)
	if li_return = -1 then return -1	
	
	//---------Begin Modified by (Appeon)Stephen 2013-07-23 for large import file issues--------
	ids_imp_audit_item_temp = create datastore		
	ls_Syntax = ids_imp_audit_item.object.datawindow.syntax
	ids_imp_audit_item_temp.Create(ls_Syntax, ls_Error)
	IF LenA(ls_Error) > 0 THEN
		RETURN -1
	END IF	
	ids_imp_audit_item_temp.settransobject(sqlca)
	//---------End Modfiied ------------------------------------------------------
	
	SELECT getdate() INTO :idt_CurrentTime FROM ids;
			
	ib_import_audit = true
end if

return 1
end function

public function integer of_dyncreate_auditdw (n_import_ds ads_audit_table, string as_table_name, string as_fields);//////////////////////////////////////////////////////////////////////
// $<function> of_dyncreate_auditdw
// $<arguments>
//               N/A
// $<returns> (integer)
// $<description> Dynamic create import_audit datastore
//                       V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Stephen 01.31.2013
//////////////////////////////////////////////////////////////////////

string ls_fields, ls_sqlselect
string ls_Syntax, ls_Error
n_cst_dw_update_prop lnv_DwSyntax

ls_sqlselect = "select " + as_fields +" from "+ as_table_name

//Dynamic create import_audit datastore
ls_Syntax = SQLCA.SyntaxFromSQL(ls_SQLSelect, "Style(Type=Grid)", ls_Error)
IF LenA(ls_Error) > 0 THEN
		of_Log(0, "", IL_ERRTYPE_MAPDESIGN, "Failed to dynamically create "+ as_table_name +" datawindow." + ls_Error)
		RETURN -1
END IF
ads_audit_table.Create(ls_Syntax, ls_Error)

IF LenA(ls_Error) > 0 THEN
	RETURN -1
END IF

if lnv_DwSyntax.of_ModifyUpdateProperty(ads_audit_table, as_table_name, false) = -1 then 
	of_Log(0, "", IL_ERRTYPE_MAPDESIGN, "Failed to modify datawindow update properties.")
	Return -1
end if
ads_audit_table.settransobject(sqlca)

return 1
end function

public function string of_readfile_str (string as_file);//////////////////////////////////////////////////////////////////////
// $<Function> of_readfile_str
// $<arguments>
// $<returns> string
// $<description>Importing format text file data
//////////////////////////////////////////////////////////////////////
// $<add> 03.14.2013 by Stephen
//////////////////////////////////////////////////////////////////////

string ls_Data
string ls_Buf
long ll_Byte
integer li_FileNum

li_FileNum = FileOpen(as_File, StreamMode!, Read!, Shared!)
if li_FileNum = -1 then 
	SetNull(ls_Data)
	Return ls_Data
end if

do
	ll_Byte = FileRead(li_FileNum, ls_Buf)
	if ll_Byte > 0 then
		ls_Data += ls_Buf
	else
		Exit
	end if
loop while true
FileClose(li_FileNum)

Return ls_Data
end function

public function integer of_save_import_audit (long al_import_id, integer ai_type);//////////////////////////////////////////////////////////////////////
// $<function> of_save_import_audit
// $<arguments>
//               N/A
// $<returns> (integer)
// $<description> save import data to audit table
//                       V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Stephen 01.31.2013
//////////////////////////////////////////////////////////////////////
long ll_rows, ll_next
string ls_Syntax, ls_Error
datastore lds_temp

if ai_type = 1 then
	ids_imp_audit_item.accepttext()
	if ids_imp_audit_item.update(true, false) <> 1 then
		of_CompleteTrans(false)
		ids_imp_audit_item.Reset()
		of_Log(0, "", IL_ERRTYPE_UPDATE, ids_imp_audit_item.is_SQLErrText)
		return -1
	end if
else
	ids_imp_audit_hdr.accepttext()
	if ids_imp_audit_hdr.update(true, false) <> 1 then
		of_CompleteTrans(false)
		ids_imp_audit_hdr.Reset()
		of_Log(0, "", IL_ERRTYPE_UPDATE, ids_imp_audit_hdr.is_SQLErrText)
		return -1
	end if
	//save screen link table
	//(Appeon)Stephen 2013-10-14 - add column records_id --Bug 3679
	insert into import_audit_records_tablink(import_id, Hdr_id, isoft_table_id, sort_no, address_link_set, lv_primary_office, lv_additional_office, lv_billing, lv_home_address, lv_mailing, lv_exp_letters, lv_include_in_directory, lv_match_gp, hosp_facility_link_set, lv_primary_hosp, spec_facility_link_set, lv_practicing, records_id)
		 select import_id, :il_hdr_id, isoft_table_id, sort_no, address_link_set, lv_primary_office, lv_additional_office, lv_billing, lv_home_address, lv_mailing, lv_exp_letters, lv_include_in_directory, lv_match_gp, hosp_facility_link_set, lv_primary_hosp, spec_facility_link_set, lv_practicing, table_records_id
		  from import_table_records
		  where import_id =:al_import_id;
	//-----end modified--------------------------------------------------------	 
	if sqlca.sqlcode <> 0 then
		of_CompleteTrans(false)
		return -1
	end if
end if

commit using sqlca;

return 1
end function

public function integer of_import_store_item (long al_import_id, long al_table_id, string as_table_name, long al_hdr_id, string as_table_alias, long al_table_records_id);//////////////////////////////////////////////////////////////////////
// $<function> of_import_store_item
// $<arguments>
//               N/A
// $<returns> (integer)
// $<description> store import data to audit table
//                       V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Stephen 12.28.2012
//////////////////////////////////////////////////////////////////////

string   ls_field_name, ls_imp_field
string   ls_fields, ls_sqlselect
string  ls_KeyField[], ls_import_field[]
string  ls_field_types[], ls_keydata[]
string  ls_field_value, ls_field_value_old
string   ls_FindValue, ls_find, ls_find_field
string   ls_field_type
string   ls_new, ls_audit_type, ls_sql[]
string    ls_lu_type, ls_key
string   ls_date, ls_time
integer li_KeyFieldIndex[]
integer li_KeyFieldCount, li_cnt
integer li_col, li_pos
integer  li_return, li_err_process
long     ll_ImpRowCount, ll_FindRow
long     ll_prac_id, ll_find_type, ll_seq_no
long      ll_facility_id , ll_lu_template
long      ll_find, ll_Count, ll_row_item
boolean lb_find_new
boolean lb_isnull

ll_ImpRowCount = ids_imp_data.RowCount()
w_import_progressbar.of_SetImportProcessDesc("Data process")
w_import_progressbar.of_SetMaxPosition(ll_ImpRowCount)

gnv_appeondb.of_startqueue( )
ids_sys_field_type.retrieve(al_table_id)
ids_intellisoft_table.retrieve()
gnv_appeondb.of_CommitQueue( )

li_KeyFieldCount = of_GetKeyFields_new(li_KeyFieldIndex[], ls_KeyField[], ls_import_field[])
yield()
if lower(as_table_name) = 'pd_basic' then 
	ii_new = 0
	ii_modify = 0
else
	if upperbound(is_new_prac) <>ll_ImpRowCount then return -1
	ls_KeyField[li_KeyFieldCount +1] = 'prac_id'
	ls_import_field[li_KeyFieldCount +1] = 'sys_pc_id'
end if

li_err_process = ids_import_hdr.object.err_process[ids_import_hdr.GetRow()]

ids_intellisoft_table_temp.reset()
ids_imp_audit_item_temp.reset() //(Appeon)Stephen 2013-07-23 -  large import file issues
ids_imp_audit_item.reset()          //(Appeon)Stephen 2013-07-23 -  large import file issues
for li_cnt = 1 to ll_ImpRowCount	
	ids_intellisoft_table_temp.insertrow(0)
	
	//check import data
//	if of_check_import_data(li_cnt) = -1 then return -1 //Commented by (Appeon)Stephen 11.07.2013 - Existing Import Advanced Audit issues
	yield()
	ids_imp_data.accepttext()
	ids_intellisoft_table_temp.accepttext()
	
	if li_err_process = 2 then
		if ids_intellisoft_table_temp.object.err_value[li_cnt] <>0 then continue
	else
		if  ids_intellisoft_table_temp.object.err_value[li_cnt] =2 then continue
	end if
	
	// Find Key Field
	ls_find = ''
	lb_isnull = false   //(Appeon)Stephen 08.04.2014 - IntelliImport Advanced Acceptance
	for li_col = 1 to upperbound(ls_KeyField)
		if not(ls_find = '' or isnull(ls_find)) then ls_find = ls_find + " and "
		ls_field_name = ls_KeyField[li_col] 
		ll_find_type = ids_sys_field_type.find("field_name = '" +ls_field_name +"'", 1, ids_sys_field_type.rowcount())
		if ll_find_type > 0 then
			ls_field_type = ids_sys_field_type.getitemstring(ll_find_type, "field_type")
		else
			ls_field_type = 'C'
		end if
		if  ls_import_field[li_col] = 'sys_pc_id' then
			ls_find_field = string(ids_imp_data.getitemnumber(li_cnt, ls_import_field[li_col]))
		else
			ls_find_field = ids_imp_data.getitemstring(li_cnt, ls_import_field[li_col])
		end if
		
		//---------Begin Added by (Appeon)Stephen 08.04.2014 for IntelliImport Advanced Acceptance--------
		if isnull(ls_find_field) or trim(ls_find_field) = "" then
			lb_isnull = true 
			exit
		end if
		//---------End Added ------------------------------------------------------	
		ls_keydata[li_col] = upper(ls_find_field) //add by stephen 04.30.2013 -12.3 Import testing
		ls_field_types[li_col] = ls_field_type       //add by stephen 04.30.2013 -12.3 Import testing
		yield()
	next	
	
	//---------Begin Added by (Appeon)Stephen 08.04.2014 for  IntelliImport Advanced Acceptance--------
	if lb_isnull = true then
		if lower(as_table_name) = 'pd_basic' then 
			is_new_prac[li_cnt] = ''
		end if
		continue
	end if
	if lower(as_table_name) <> 'pd_basic' then
		if is_new_prac[li_cnt] = '' or isnull(is_new_prac[li_cnt] = '') then continue
	end if
	//---------End Added ------------------------------------------------------
	
	//------------------- APPEON BEGIN -------------------
	//$<modify> Stephen 04.30.2013
	//$<reason> 12.3 Import testing -	Text data matches fail when the text contains an apostrophe
	/*
	ll_FindRow = ids_intellisoft_table.Find(ls_find, 1, ids_intellisoft_table.rowcount())
	*/
	for ll_find = 1 to ids_intellisoft_table.rowcount()
		lb_find_new = true
		for  li_col = 1 to upperbound(ls_KeyField)
			choose case ls_field_types[li_col]
				case 'C'
					ls_find_field = ids_intellisoft_table.getitemstring(ll_find, ls_KeyField[li_col])
				case 'N', 'I'
					ls_find_field = string(ids_intellisoft_table.getitemnumber(ll_find, ls_KeyField[li_col]))
				case 'D'
					ls_find_field = string(ids_intellisoft_table.getitemdatetime(ll_find, ls_KeyField[li_col]))
				case else
					ls_find_field = ids_intellisoft_table.getitemstring(ll_find, ls_KeyField[li_col])
			end choose				
			if upper(ls_find_field) = ls_keydata[li_col] then
				lb_find_new = true
			else
				lb_find_new = false
				exit
			end if
		next
		if lb_find_new then
			ll_FindRow = ll_find
			exit
		end if
		yield()
	next	
	if  not lb_find_new then ll_FindRow = 0
    //------------------- APPEON End -------------------
	
	ls_new = 'N'
	if ll_FindRow < 1 then
		ls_new = 'Y'
		ls_audit_type = 'NW'
		ll_seq_no = gnv_app.of_get_id("RECORD_ID", 1)
	else
		ll_seq_no = ids_intellisoft_table.getitemnumber(ll_FindRow, "rec_id")
		ls_audit_type = 'EW'
	end if
	
	//---------Begin Added by (Appeon)Stephen 03.24.2015 for V15.1-Import Improvements 2015--------
	if ib_isg_key = true and ll_FindRow < 1 then
		of_Log(li_cnt, "Key Field", IL_ERRTYPE_MAPDESIGN, "When matching with ISG key fields, it's not allowed to add new practitioner.")
		return -1
	end if
	//---------End Added ------------------------------------------------------
	
	if lower(as_table_name) = 'pd_basic' then	
		if ll_FindRow < 1 then			
			//new prac
			ll_prac_id =  gnv_app.of_get_id("PRAC_ID", 1)
			is_prac_name[li_cnt] =  of_getimport_pracname(ids_imp_data, li_cnt)	
		else
			ll_prac_id = ids_intellisoft_table.getitemnumber(ll_FindRow, "prac_id")
			is_prac_name[li_cnt] = ""
		end if	
		is_new_prac[li_cnt] = ls_new
		il_prac_id[li_cnt] = ll_prac_id
		ids_imp_data.setitem(li_cnt,"sys_pc_id", ll_prac_id)
	elseif is_new_prac[li_cnt] ="Y" then
		ls_audit_type = 'NW'
		ll_seq_no = gnv_app.of_get_id("RECORD_ID", 1)
	end if
	
	//save import data to template table
	for li_col = 1 to ids_mapping_field.RowCount()
		ls_imp_field = Trim(ids_mapping_field.object.imp_field_name[li_col])
		ls_field_name = Trim(ids_mapping_field.object.field_name[li_col])
		//---------Begin Modified by (Appeon)Stephen 11.07.2013 for Existing Import Advanced Audit issues--------
		//ls_field_value = ids_imp_data.GetItemString(li_cnt, ls_imp_field)	
		ls_field_value = ""
		if of_check_import_data(li_cnt, li_col, ls_field_value) = -1 then return -1
		if isnull(ls_field_value) then ls_field_value = ""
		//---------End Modfiied ------------------------------------------------------	
		
		ll_facility_id = ids_mapping_field.GetItemNumber(li_col, "facility_id")
		ls_lu_type = ids_mapping_field.GetItemString(li_col, "lu_type")
		ls_key = 'N'
		if  ids_mapping_field.object.key_field[li_col] = 1 then ls_key = 'Y'
		/////////////////////////////////////////////////////////////////////////////////////////////////////
		
		//get screen field type
		ll_find_type = ids_sys_field_type.find("field_name = '" +ls_field_name +"'", 1, ids_sys_field_type.rowcount())
		if ll_find_type > 0 then
			ls_field_type = ids_sys_field_type.getitemstring(ll_find_type, "field_type")
		else
			//---------Begin Modified by (Appeon)Stephen 04.17.2015 for V15.1-Import Improvements 2015--------
			//ls_field_type = 'C'
			if ls_field_name = 'parent_facility_id' or ls_field_name = 'verifying_facility' or ls_field_name = 'application_audit_facility' or ls_field_name = 'approval_facility' then
				ls_field_type = 'N'
			else
				ls_field_type = 'C'
			end if
			//---------End Modfiied ------------------------------------------------------			
		end if
		
		//get current value
		if ls_new ='Y' then
			ls_field_value_old = ''
		else
			choose case ls_field_type
				case 'C'
					ls_field_value_old = ids_intellisoft_table.getitemstring(ll_FindRow, ls_field_name)
				case 'N', 'I'
					ls_field_value_old = string(ids_intellisoft_table.getitemnumber(ll_FindRow, ls_field_name))
				case 'D'
					ls_field_value_old = string(ids_intellisoft_table.getitemdatetime(ll_FindRow, ls_field_name),'mm/dd/yyyy hh:mm:ss')
					
				case else
					ls_field_value_old = ids_intellisoft_table.getitemstring(ll_FindRow, ls_field_name)
			end choose			
		end if		
		
		//---------Begin Added by (Appeon)Stephen 11.06.2013 for Existing Import Advanced Audit issues--------
		if ls_field_type = 'D' then
			li_Pos = PosA(ls_field_value, " ")
			ls_Date = LeftA(ls_field_value, li_Pos - 1)
			
			ls_Time = RightA(ls_field_value, LenA(ls_field_value) - li_Pos)
			if IsDate(ls_Date) and IsTime(ls_Time) then
				ls_field_value = string(DateTime(Date(ls_Date), Time(ls_Time)),'mm/dd/yyyy hh:mm:ss')						
			else
				continue
			end if
		end if
		//---------End Added ------------------------------------------------------
		
		if isnull(ll_facility_id) then ll_facility_id = 1
		if isnull(ls_field_value_old) then ls_field_value_old = ''
		if isnull(ls_field_value) then ls_field_value = ''
		if isnull(ls_lu_type) then ls_lu_type = ''
		
		//save import data to import_audit_item
		ll_row_item = ids_imp_audit_item_temp.insertrow(0)
		ids_imp_audit_item_temp.setitem(ll_row_item, "Hdr_id", al_hdr_id)
		ids_imp_audit_item_temp.setitem(ll_row_item, "Import_id", al_import_id)
		ids_imp_audit_item_temp.setitem(ll_row_item, "Audit_type", ls_audit_type)
		ids_imp_audit_item_temp.setitem(ll_row_item, "Field_name", ls_field_name)
		ids_imp_audit_item_temp.setitem(ll_row_item, "Seq_no", ll_seq_no)
		ids_imp_audit_item_temp.setitem(ll_row_item, "Table_id", al_table_id)
		ids_imp_audit_item_temp.setitem(ll_row_item, "New_prac", is_new_prac[li_cnt])
		ids_imp_audit_item_temp.setitem(ll_row_item, "Prac_id", il_prac_id[li_cnt])
		ids_imp_audit_item_temp.setitem(ll_row_item, "facility_id", ll_facility_id)
		ids_imp_audit_item_temp.setitem(ll_row_item, "old_value", ls_field_value_old)
		ids_imp_audit_item_temp.setitem(ll_row_item, "new_value", ls_field_value)
		ids_imp_audit_item_temp.setitem(ll_row_item, "status", 0)
		ids_imp_audit_item_temp.setitem(ll_row_item, "create_by", gs_user_id)
		ids_imp_audit_item_temp.setitem(ll_row_item, "create_date", idt_CurrentTime)
		ids_imp_audit_item_temp.setitem(ll_row_item, "prac_name", is_prac_name[li_cnt])
		ids_imp_audit_item_temp.setitem(ll_row_item, "Table_alias", as_table_alias)
		ids_imp_audit_item_temp.setitem(ll_row_item, "Field_lu_type", ls_lu_type)
		ids_imp_audit_item_temp.setitem(ll_row_item, "key_field", ls_key)
		ids_imp_audit_item_temp.setitem(ll_row_item, "table_records_id", al_table_records_id) //(Appeon)Stephen 2013-10-14 -Bug 3679
		
		//---------Begin Modified by (Appeon)Stephen 2013-07-23 for large import file issues-------
		if ll_row_item > 5000 then
			ids_imp_audit_item_temp.rowscopy(1, ll_row_item, primary!, ids_imp_audit_item, ids_imp_audit_item.rowcount()+1, primary!)
			ids_imp_audit_item_temp.reset()
		end if 
		//---------End Modfiied ------------------------------------------------------

		w_import_progressbar.of_SkipNextPosition()
		yield()
	next
	
	if lower(as_table_name) = 'pd_basic' then	
		if ll_FindRow < 1 then
			ii_new +=1
		else
			ii_modify +=1
		end if
	end if
	
	//save import log
	ids_log_table.accepttext()
	//ids_table_record = ids_log_table
	ll_find = ids_table_record.find("isoft_table_id = "+string(al_table_id),1, ids_log_table.rowcount())
	if ll_find > 0 then
		if ls_audit_type = 'NW' then
			ll_Count = ids_log_table.object.add_count[ll_find] + 1
			ids_log_table.object.add_count[ll_find] = ll_Count
		else
			ll_Count = ids_log_table.object.mod_count[ll_find] + 1
			ids_log_table.object.mod_count[ll_find] = ll_Count
		end if
	end if
	
	ids_audit_log_table.accepttext()
	ll_find = ids_audit_log_table.find("table_id = "+string(al_table_id),1, ids_audit_log_table.rowcount())
	if ll_find > 0 then
		if ls_audit_type = 'NW' then
			ll_Count = ids_audit_log_table.object.add_count[ll_find] + 1
			ids_audit_log_table.object.add_count[ll_find] = ll_Count
		else
			ll_Count = ids_audit_log_table.object.mod_count[ll_find] + 1
			ids_audit_log_table.object.mod_count[ll_find] = ll_Count
		end if
	end if
	
	yield()
next

//---------Begin Modified by (Appeon)Stephen 2013-07-23 for large import file issues-------
ids_imp_audit_item_temp.rowscopy(1, ll_row_item, primary!, ids_imp_audit_item, ids_imp_audit_item.rowcount()+1, primary!)
ids_imp_audit_item_temp.reset()
//---------End Modfiied ------------------------------------------------------

return 1
end function

public function integer of_check_import_data (long al_row, integer ai_col, ref string as_field_value);//////////////////////////////////////////////////////////////////////
// $<function> of_check_import_data
// $<arguments>
//               N/A
// $<returns> (integer)
// $<description> check import data
//                       V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Stephen 01.31.2013
//////////////////////////////////////////////////////////////////////
string   ls_field_name, ls_imp_field
string  ls_field_value
string   ls_field_type
string    ls_lu_table, ls_lu_type, ls_lu_field_name, ls_allow_null
string    ls_CharValue
integer li_col, li_pos
integer li_KeyFieldCount, li_cnt
integer  li_no_match_procd, li_field_len, li_null_type
integer  li_return, li_err_process
long      ll_facility_id , ll_lu_template
decimal  ldc_DecValue
datetime ldt_DTValue
boolean lb_IsGetImpValue, lb_IsFacilityField, lb_IsLookupTemplate, lb_IsLookupField

li_cnt = al_row
li_col = ai_col //(Appeon)Stephen 11.07.2013 - Existing Import Advanced Audit issues
//convert import data to template table
//for li_col = 1 to ids_mapping_field.RowCount() //Commented by (Appeon)Stephen 11.07.2013 - Existing Import Advanced Audit issues
	ls_field_name = Trim(ids_mapping_field.object.field_name[li_col])
	ls_imp_field = Trim(ids_mapping_field.object.imp_field_name[li_col])
	
	ll_facility_id = ids_mapping_field.GetItemNumber(li_col, "facility_id")
	ll_lu_template = ids_mapping_field.GetItemNumber(li_col, "lu_template")
	li_no_match_procd = ids_mapping_field.GetItemNumber(li_col, "no_match_procd")
	ls_lu_type = ids_mapping_field.GetItemString(li_col, "lu_type")
	ls_lu_table = ids_mapping_field.GetItemString(li_col, "lu_table")
	ls_lu_field_name = ids_mapping_field.GetItemString(li_col, "lu_field_name")
	ls_field_type = ids_mapping_field.GetItemString(li_col, "field_type")
	li_field_len = ids_mapping_field.GetItemNumber(li_col, "field_len")
	li_null_type = ids_mapping_field.GetItemNumber(li_col, "null_type")	
	ls_allow_null = ids_mapping_field.GetItemString(li_col, "allow_null")
	lb_IsGetImpValue = false
	lb_IsFacilityField = false
	lb_IsLookupTemplate = false
	lb_IsLookupField = false
	if LenA(ls_imp_field) > 0 then lb_IsGetImpValue = true
	if not IsNull(ll_facility_id) then lb_IsFacilityField = true
	if not IsNull(ll_lu_template) then lb_IsLookupTemplate = true
	if LenA(ls_lu_field_name) > 0 then lb_IsLookupField = true
	
	// Filter lookup mapping and retrieve lookup data
	of_RetrieveLookupData(ll_lu_template, ls_lu_type, ls_lu_table)
	
	// Import each import value
	ids_coderownum1.Reset()
	ids_coderownum2.Reset()

	// Get import value and dispose null value
	if lb_IsGetImpValue then
		if  ids_imp_data.Describe( ls_imp_field + ".ColType") = "!" then  //Start Code Change ----10.08.2013 #V14 maha
			messagebox("of_check_import_data", "Get import value failure.  column=" + ls_imp_field )
			return -1
		end if
		ls_field_value = ids_imp_data.GetItemString(li_cnt, ls_imp_field)
		of_DisposeNullValue(li_null_type, li_cnt, li_col, ls_field_value)
		ls_field_value = Trim(ls_field_value)
		ids_intellisoft_table_temp.SetItem(li_cnt, li_col, ls_field_value)
	end if
	
	// Parse import value
	if lb_IsFacilityField then
		if ls_field_type = "I" or ls_field_type = "N" then
			//ids_intellisoft_table_temp.SetItem(ll_ImportDataRow, li_MapFieldIndex, ll_facility_id)
			ls_field_value = string(ll_facility_id)
			ids_intellisoft_table_temp.SetItem(li_cnt, li_col, ls_field_value)
		else
			of_Log(li_cnt, ls_imp_field, IL_ERRTYPE_VERIFYVALUE, "Facility_id field must be the type of number.")
			if li_err_process = 1 or (not of_IsContinue()) then Return -1
			ids_intellisoft_table_temp.SetItem(li_cnt, "err_value", 1)
			return 1
		end if
		
	elseif lb_IsLookupTemplate then
		// Dispose lookup code according to lu_template
		li_Return = of_DisposeLookupCode(li_cnt, li_col, ls_field_value, ls_field_type, li_no_match_procd)
		if li_Return = -1 then
			of_Log(li_cnt, ls_imp_field, IL_ERRTYPE_MAPDESIGN, "When 'No match Procd'='Error', it's not allowed to add new lookup code to template.")
		elseif li_Return = -2 then
			of_Log(li_cnt, ls_imp_field, IL_ERRTYPE_DATAINTEGRITY, "'" + ls_field_value + "' matches no facility_id in template.")
		//---------Begin Modified by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
		//elseif li_Return = -3 then 
		elseif li_Return = -13 then 
		//---------End Modfiied ------------------------------------------------------
			of_Log(li_cnt, ls_imp_field, IL_ERRTYPE_DATAINTEGRITY, "'" + ls_field_value + "' matches no active_status_id in template.")
		end if
		if li_Return < 0 then
			if li_err_process = 1 or (not of_IsContinue()) then Return -1	
			ids_intellisoft_table_temp.SetItem(li_cnt, "err_value", 1)
			return 1
		end if
		
	elseif lb_IsLookupField then
		// Dispose lookup code according to lu_field_name
		li_Return = of_DisposeLookupCode(li_cnt, li_col, ls_field_value, ls_field_type, li_no_match_procd, ls_lu_type, ls_lu_table, ls_lu_field_name)
		if li_Return = -1 then
			of_Log(li_cnt, ls_imp_field, IL_ERRTYPE_MAPDESIGN, "When 'No match Procd'='Error', it's not allowed to add new lookup code to lookup table.")
		elseif li_Return = -2 then
			of_Log(li_cnt, ls_imp_field, IL_ERRTYPE_DATAINTEGRITY, "'" + ls_field_value + "' matches no facility_id in lookup table.")
		//---------Begin Modified by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
		//elseif li_Return = -3 then // V10.1 - Import Active Status
		elseif li_Return = -13 then // V10.1 - Import Active Status
		//---------End Modfiied ------------------------------------------------------
			of_Log(li_cnt, ls_imp_field, IL_ERRTYPE_DATAINTEGRITY, "'" + ls_field_value + "' matches no active_status_id in lookup table.")
		end if
		if li_Return < 0 then
			if li_err_process = 1 or (not of_IsContinue()) then Return -1
			ids_intellisoft_table_temp.SetItem(li_cnt, "err_value", 1)
			return 1
		end if
		
	else			
		// Verify external data according to field type and field length
		li_Return = of_DisposeVerifyValue(ls_field_value, ls_field_type, li_field_len, ls_CharValue, ldc_DecValue, ldt_DTValue)
		if li_Return = -1 then
			if ls_field_type = "D" then
				of_Log(li_cnt, ls_imp_field, IL_ERRTYPE_VERIFYVALUE, "Can not convert '" + ls_field_value + "' to the type of datetime.")
			else
				of_Log(li_cnt, ls_imp_field, IL_ERRTYPE_VERIFYVALUE, "Can not convert '" + ls_field_value + "' to the type of number.")
			end if
		elseif li_Return = -2 then
			of_Log(li_cnt, ls_imp_field, IL_ERRTYPE_VERIFYVALUE, "'" + ls_field_value + "' exceeds the length of field.")
		end if
		
		if li_Return =1 then
			choose case ls_field_type
				case "C"
					ids_intellisoft_table_temp.SetItem(li_cnt, li_col, ls_CharValue)
				case "I", "N"
					ids_intellisoft_table_temp.SetItem(li_cnt, li_col, ldc_DecValue)
				case "D"
					ids_intellisoft_table_temp.SetItem(li_cnt, li_col, ldt_DTValue)
			end choose
		else
			if li_err_process = 1 or (not of_IsContinue()) then Return -1
			ids_intellisoft_table_temp.SetItem(li_cnt, "err_value", 1)
			return 1
		end if
	end if
	
	// Check import value if null
	if ls_allow_null = "N" then
		if IsNull(ids_intellisoft_table_temp.object.data[li_cnt, li_col]) then
			if not ((lb_IsLookupTemplate or lb_IsLookupField) and li_no_match_procd = 1) then
				of_Log(li_cnt, ls_imp_field, IL_ERRTYPE_DATAINTEGRITY, "Import value can not be null.")
				if li_err_process = 1 or (not of_IsContinue()) then Return -1
				ids_intellisoft_table_temp.SetItem(li_cnt, "err_value", 2)
				return 1
			end if
		end if
	end if
	
	// Update lookup table if have new records
	if lb_IsLookupTemplate or lb_IsLookupField then
		if lb_IsLookupTemplate then
			of_UpdateLookupTable(1, li_col, ls_field_type)
		elseif lb_IsLookupField then
			of_UpdateLookupTable(2, li_col, ls_field_type)
		end if
		if ls_field_type = "N" then
			ls_field_value = string(ids_intellisoft_table_temp.getitemnumber(li_cnt, li_col))
		else
			ls_field_value = ids_intellisoft_table_temp.getitemstring(li_cnt, li_col)
		end if
	end if
	
	//set data to ids_imp_data
	choose case ls_field_type
		case "C"
			ls_field_value = ids_intellisoft_table_temp.getitemstring(li_cnt, li_col)
		case "I", "N"
			ls_field_value = string(ids_intellisoft_table_temp.getitemnumber(li_cnt, li_col))
		case "D"
			ls_field_value = string(ids_intellisoft_table_temp.object.data[li_cnt, li_col], "YYYY-MM-DD HH:MM:SS")
	end choose
	
//---------Begin Modified by (Appeon)Stephen 11.07.2013 for Existing Import Advanced Audit issues--------
/*	ids_imp_data.setitem(li_cnt, ls_imp_field, ls_field_value)		
    next
*/
as_field_value = ls_field_value
//---------End Modfiied ------------------------------------------------------

return 1
end function

public function integer of_preprocess_msg (string as_type, string as_msg);//Start Code Change ----12.06.2013 #V14 maha - moved from w_import_painter window
if isvalid(w_preprocess_message) then w_preprocess_message.of_set_val(as_type,as_msg)

return 1
end function

public function string of_reviseexpvalue (string as_value, boolean ab_lower);// (Appeon)Harry 01.23.2014 - V142 ISG-CLX Copy from CLX12.0
integer li_Len
integer li_NewStart
integer li_OldStart = 1
string  ls_NewValue

do while true
	li_NewStart = PosA(as_Value, "'", li_OldStart)
	if li_NewStart > 0 then		
		ls_NewValue += MidA(as_Value, li_OldStart, li_NewStart - li_OldStart) + "~~'"
		li_OldStart = li_NewStart + 1
	else
		li_Len = LenA(as_Value) - li_OldStart + 1
		if li_Len > 0 then
			ls_NewValue += RightA(as_Value, li_Len)
		end if		
		Exit
	end if
loop

If ab_lower Then
	Return lower(ls_NewValue)
Else
	Return (ls_NewValue)
End If
end function

public function integer of_preprocess_imp_data (long al_imp, ref datastore adw_data, datastore adw_pre, string as_from);//Start Code Change ----07.22.2013 #V14 maha - Created to allow the pre setting of ids before the actual import process.
//Start Code Change ----12.06.2013 #V14 maha - migrated code to function in this object
boolean lb_last
boolean lb_where1
boolean lb_where2
boolean lb_where3
boolean lb_use_prac
boolean lb_mess  = false //maha 12.06.2013
integer p
integer pc
integer li_loops
integer li_cur_loop
integer w
integer res
integer li_pos
long r
long rc
long d
long dc
long ll_dc_total
long ll_cur_r = 1
long ll_cur_rc
long ll_rec
long ll_id
long ll_find
long test1
long ll_mcnt
long ll_ucnt
//---------Begin Added by (Appeon)Stephen 01.08.2014 for get column type--------
long ll_table_id 
long ll_find_type
string ls_isg_type1
string ls_isg_type2
string ls_isg_type3
string ls_getfield_type
string ls_getfield_data
//---------End Added ------------------------------------------------------
string ls_isg_1
string ls_isg_2
string ls_isg_3
string ls_imp_1
string ls_imp_2
string ls_imp_3
string ls_set_field
string ls_get_field
string ls_prac_field
string ls_get_1
string ls_get_2
string ls_get_3
string ls_get_1a[]
string ls_get_2a[]
string ls_get_3a[]
string ls_get_prac
string ls_get_prac_a[]
string ls_temp_1
string ls_temp_2
string ls_temp_3
string ls_table
string ls_sql
string ls_sql_loop
string ls_where1
string ls_where2
string ls_where3
string ls_where_prac
string ls_find
string ls_presentation_str
string ls_dwsyntax_str
string ERRORS
string ls_desc
string ls_filter
string ls_date, ls_time
string ls_find_set
string s
datastore ldw_import
datastore dw_preprocess
n_ds lds_ids

dw_preprocess = adw_pre

ldw_import = adw_data
rc = ldw_import.rowcount()

//ls_desc = ldw_import.describe("Datawindow")
//openwithparm(w_SQL_msg,ls_desc)
if as_from = "Painter" then lb_mess = true

if rc < 1 then
	if lb_mess then
		messagebox("Preprocess Data","There are no Imported data records.  Please Get Import Data")
	else
		of_Log("Preprocess Data:There are no Imported data records.  Please Get Import Data")
	end if
	return -1
end if

li_loops = integer(rc/100 ) + 1

dw_preprocess.settransobject(sqlca)
pc =dw_preprocess.retrieve(al_imp)

if pc < 1 then return -1

if lb_mess then  //Start Code Change ----12.06.2013 #V14 maha
	if not isvalid(w_preprocess_message) then open (w_preprocess_message)
	of_preprocess_msg( "Total", string (rc))
end if
	

FOR p = 1 to pc  //each process function
	if lb_mess then  //Start Code Change ----12.06.2013 #V14 maha
		of_preprocess_msg( "Process", string (p))
		of_preprocess_msg( "Processes", string (pc))
	end if
	lb_where1 = false
	lb_where2 = false
	lb_where3 = false
	ls_where1 = ""
	ls_where2 = ""
	ls_where3 = ""
	ls_where_prac = ""
	ls_sql = ""
	ll_cur_r = 1
	if rc > 100 then
		ll_cur_rc = 100
	else
		ll_cur_rc = rc
	end if
	
	ls_isg_1 =trim(dw_preprocess.getitemstring(p,"isg_field1"))
	if isnull(ls_isg_1) then ls_isg_1 = ""
	ls_isg_2 =trim(dw_preprocess.getitemstring(p,"isg_field2"))
	if isnull(ls_isg_2) then ls_isg_2 = ""
	ls_isg_3 =trim(dw_preprocess.getitemstring(p,"isg_field3"))
	if isnull(ls_isg_2) then ls_isg_2 = ""
	ls_imp_1 = trim(dw_preprocess.getitemstring(p,"imp_field1"))
	if isnull(ls_imp_1) then ls_imp_1 = ""
	ls_imp_2 = trim(dw_preprocess.getitemstring(p,"imp_field2"))
	if isnull(ls_imp_2) then ls_imp_2 = ""
	ls_imp_3 = trim(dw_preprocess.getitemstring(p,"imp_field3"))
	if isnull(ls_imp_3) then ls_imp_3 = ""
	ls_set_field = trim(dw_preprocess.getitemstring(p,"result_field"))
	ls_get_field = trim(dw_preprocess.getitemstring(p,"get_field"))
	ls_prac_field = trim(dw_preprocess.getitemstring(p,"prac_field"))
	ls_table = trim(dw_preprocess.getitemstring(p,"isg_table"))
	
	ls_filter = trim(dw_preprocess.getitemstring(p,"filter_syntax"))
	
	//---------Begin Added by (Appeon)Stephen 01.08.2014 for get column type--------
    select table_id into :ll_table_id from sys_tables where table_name = :ls_table using sqlca;
	ids_sys_field_type.retrieve(ll_table_id)
	if ls_isg_1 <>"" then
		ll_find_type = ids_sys_field_type.find("field_name = '" +ls_isg_1 +"'", 1, ids_sys_field_type.rowcount())
		if ll_find_type > 0 then
			ls_isg_type1 = ids_sys_field_type.getitemstring(ll_find_type, "field_type")
		else
			ls_isg_type1 = 'C'
		end if
	end if
	if ls_isg_2 <>"" then
		ll_find_type = ids_sys_field_type.find("field_name = '" +ls_isg_2 +"'", 1, ids_sys_field_type.rowcount())
		if ll_find_type > 0 then
			ls_isg_type2 = ids_sys_field_type.getitemstring(ll_find_type, "field_type")
		else
			ls_isg_type2 = 'C'
		end if
	end if
	if ls_isg_3 <>"" then
		ll_find_type = ids_sys_field_type.find("field_name = '" +ls_isg_3 +"'", 1, ids_sys_field_type.rowcount())
		if ll_find_type > 0 then
			ls_isg_type3 = ids_sys_field_type.getitemstring(ll_find_type, "field_type")
		else
			ls_isg_type3 = 'C'
		end if
	end if
	if not isnull(ls_get_field) or ls_get_field <>"" then
		ll_find_type = ids_sys_field_type.find("field_name = '" +ls_get_field +"'", 1, ids_sys_field_type.rowcount())
		if ll_find_type > 0 then
			ls_getfield_type = ids_sys_field_type.getitemstring(ll_find_type, "field_type")
		else
			ls_getfield_type = 'C'
		end if
	end if
	
	//---------End Added ------------------------------------------------------
		
	if isnull(ls_set_field) or ls_set_field = "" then
		if lb_mess then
			messagebox("Preprocess Data","The Set Field value is not defined.  Please check preprocess setup.")
		else
			of_Log("Preprocess Data:The Set Field value is not defined.  Please check preprocess setup.")
		end if
		return -1
	end if
	
	if isnull(ls_get_field) or ls_get_field = "" then
		if lb_mess then
			messagebox("Preprocess Data","The Get Field value is not defined.  Please check preprocess setup.")
		else
			of_Log("Preprocess Data:The Get Field value is not defined.  Please check preprocess setup.")
		end if
		return -1
	end if
	
	//use the prac field
	if isnull(ls_prac_field) or ls_prac_field = "" then
		lb_use_prac = false
	elseif ls_prac_field = ls_set_field then
		lb_use_prac = false
	else
		lb_use_prac = true
	end if	

	ls_sql = "Select " + ls_get_field + " "
	if lb_use_prac then ls_sql+= ", prac_id "  //Start Code Change ----10.24.2013 #V14 maha
	
	if len(ls_isg_1) > 0 and len(ls_imp_1) > 0 then lb_where1 = true
	if len(ls_isg_2) > 0 and len(ls_imp_2) > 0 then lb_where2 = true
	if len(ls_isg_3) > 0 and len(ls_imp_3) > 0 then lb_where3 = true
	
	//add appropriate isg fields
	if lb_where1 then ls_sql = ls_sql + " , " + ls_isg_1
	if lb_where2 then ls_sql = ls_sql + " , " + ls_isg_2
	if lb_where3 then ls_sql = ls_sql + " , " + ls_isg_3
	//---------Begin Modified by (Appeon)Stephen 03.21.2014 for Bug #3982: Import Pre-Process error: "No records found for process x" appears before the process is complete--------
	//ls_sql = ls_sql + " From " + ls_table  + " Where "
	ls_sql = ls_sql + " From " + ls_table  + " Where 1=1 "
	ll_dc_total = 0 
	//---------End Modfiied ------------------------------------------------------	
	
	ls_where1 = ls_isg_1 + " in ("
	ls_where2 = " and " + ls_isg_2 +  " in ("
	ls_where3 = " and " + ls_isg_3 +  " in ("
	ls_where_prac = " and prac_id in ("	
	
	
//@@@@@@@@@@@@@@@@@@@@@@
	//for each group of 100
	for li_cur_loop = 1 to li_loops  //each of multiple loops
		ls_sql_loop = ls_sql
		//reset for each loop
		if li_cur_loop > 1 then
			ll_cur_r = ll_cur_rc + 1
		end if
		if ll_cur_r > rc then continue
		ll_cur_rc = ll_cur_rc + 100
		if ll_cur_rc > rc then ll_cur_rc = rc
//		ll_cur_r = r + 1
		//get where values
		//---------Begin modified by (Appeon)Stephen 05.31.2013 for Bug #3982: Import Pre-Process error: "No records found for process x" appears before the process is complete--------
		//ls_where1 = ls_isg_1 + " in ("
		//ls_where2 = " and " + ls_isg_2 +  " in ("
		//ls_where3 = " and " + ls_isg_3 +  " in ("
		//ls_where_prac = " and prac_id in ("
		ls_where1 = ""
		ls_where2 = ""
		ls_where3 = ""
		ls_where_prac = ""
		//---------End Commented ------------------------------------------------------
		
//@@@@@@@@@@@@@@@@@@@@@@
//
		for r =  ll_cur_r to ll_cur_rc  //each records in import

			if lb_use_prac then //if using the prac id field get value; if blank skip record 
				ls_get_prac =  ldw_import.getitemstring(r,ls_prac_field)
				if isnull(ls_get_prac) then ls_get_prac = ""
				
				ls_get_prac_a[r] = ls_get_prac
				if ls_get_prac = '' then 
					ls_get_1a[r] = ""
					ls_get_2a[r] = ""
					ls_get_3a[r] = ""
					continue
				end if
			end if
			//messagebox(string(r), ls_imp_1)
			if lb_where1 then		
				ls_get_1 = ldw_import.getitemstring(r,ls_imp_1)
			//	ls_get_1 = ldw_import.getitemstring(r, 38)
				if isnull(ls_get_1) then ls_get_1 = ""
				if pos(ls_get_1,"'",1) > 0 then ls_get_1 = of_strip_char("'", ls_get_1, "''")  //Start Code Change ----08.22.2013 #V14 maha - replace ' with ''
				//---------Begin Added by (Appeon)Stephen 03.20.2014 for Bug #3979: Import Pre-Process "Error with find syntax"--------
				if ls_isg_type1 = 'D' then
					ls_date = string(date(ls_get_1),"yyyy-mm-dd")
					ls_time = string(time(ls_get_1),"hh:mm:ss")
					ls_get_1 = ls_date + " " + ls_time
				end if
				//---------End Added ------------------------------------------------------	
				ls_get_1a[r] = ls_get_1
			end if
			if lb_where2 then
				ls_get_2 = ldw_import.getitemstring(r,ls_imp_2)
				if isnull(ls_get_2) then ls_get_2 = ""
					if pos(ls_get_2,"'",1) > 0 then ls_get_2 = of_strip_char("'", ls_get_2, "''")  //Start Code Change ----08.22.2013 #V14 maha - replace ' with ''
				//---------Begin Added by (Appeon)Stephen 03.20.2014 for Bug #3979: Import Pre-Process "Error with find syntax"--------
				if ls_isg_type2 = 'D' then
					ls_date = string(date(ls_get_2),"yyyy-mm-dd")
					ls_time = string(time(ls_get_2),"hh:mm:ss")
					ls_get_2 = ls_date + " " + ls_time
				end if
				//---------End Added ------------------------------------------------------	
				ls_get_2a[r] = ls_get_2
			end if
			if lb_where3 then
				ls_get_3 = ldw_import.getitemstring(r,ls_imp_3)
				if isnull(ls_get_3) then ls_get_3 = ""
					if pos(ls_get_3,"'",1) > 0 then ls_get_3 = of_strip_char("'", ls_get_3, "''")  //Start Code Change ----08.22.2013 #V14 maha - replace ' with ''
				//---------Begin Added by (Appeon)Stephen 03.20.2014 for Bug #3979: Import Pre-Process "Error with find syntax"--------
				if ls_isg_type3 = 'D' then
					ls_date = string(date(ls_get_3),"yyyy-mm-dd")
					ls_time = string(time(ls_get_3),"hh:mm:ss")
					ls_get_3 = ls_date +" " + ls_time
				end if
				//---------End Added ------------------------------------------------------
				ls_get_3a[r] = ls_get_3
			end if
			
			//get prac portion
			if lb_use_prac  and len(ls_get_prac) > 0 then
				ls_where_prac = ls_where_prac + "" +  ls_get_prac + ","
			end if
			//get 
			if lb_where1 and len(ls_get_1) > 0 then
				if  ls_get_1a[r] = "" then 
					continue
				else
					ls_where1 = ls_where1 + "'" +  ls_get_1a[r] + "',"
				end if
			end if
			
			if lb_where2 and len(ls_get_2) > 0 then
				if  ls_get_2a[r] = "" then 
					continue
				else
					ls_where2 = ls_where2 + "'" +  ls_get_2a[r] + "',"
				end if
			end if
			
			if lb_where3 and len(ls_get_3) > 0 then
				if  ls_get_3a[r] = "" then 
					continue
				else
					ls_where3 = ls_where3 + "'" +  ls_get_3a[r] + "',"
				end if
			end if
			
		next
	
		//if ls_sql_loop
		//---------Begin Modified by (Appeon)Stephen 03.21.2014 for Bug #3982: Import Pre-Process error: "No records found for process x" appears before the process is complete--------
		//ls_where_prac = leftA(ls_where_prac, len(ls_where_prac) - 1) + ") "	
		//ls_where1 = leftA(ls_where1, len(ls_where1) - 1) + ") "
		//ls_where2 = leftA(ls_where2, len(ls_where2) - 1) + ") "
		//ls_where3 = leftA(ls_where3, len(ls_where3) - 1) + ") "
		if len(ls_where1) > 0 then ls_where1 = " and " + ls_isg_1 + " in (" + leftA(ls_where1, len(ls_where1) - 1) + ") "		
		if len(ls_where2) > 0 then ls_where2 = " and " + ls_isg_2 +  " in (" + leftA(ls_where2, len(ls_where2) - 1) + ") "
		if len(ls_where3) > 0 then ls_where3 = " and " + ls_isg_3 +  " in (" +  leftA(ls_where3, len(ls_where3) - 1) + ") "
		if len(ls_where_prac) > 0 then ls_where_prac = " and prac_id in (" + leftA(ls_where_prac, len(ls_where_prac) - 1) + ") "	
		//---------End Modfiied ------------------------------------------------------
		
		if lower(right(trim(ls_sql_loop), 4)) = ' and' then ls_sql_loop = left(trim(ls_sql_loop), len(trim(ls_sql_loop)) - 3) //(Appeon)Stephen 02.25.2017 - Bug #5514 – Syntax error in Import pre-process when Filter Syntax is used
		if lb_where1 then ls_sql_loop+= ls_where1
		if lower(right(trim(ls_sql_loop), 4)) = ' and' then ls_sql_loop = left(trim(ls_sql_loop), len(trim(ls_sql_loop)) - 3) //(Appeon)Stephen 02.25.2017 - Bug #5514 – Syntax error in Import pre-process when Filter Syntax is used
		if lb_where2 then
			//if righta(ls_sql, 6 ) <> "Where "  then  ls_sql+= " and "  --Bug #3982: Import Pre-Process error: "No records found for process x" appears before the process is complete
			ls_sql_loop+= ls_where2
		end if
		if lower(right(trim(ls_sql_loop), 4)) = ' and' then ls_sql_loop = left(trim(ls_sql_loop), len(trim(ls_sql_loop)) - 3) //(Appeon)Stephen 02.25.2017 - Bug #5514 – Syntax error in Import pre-process when Filter Syntax is used
		if lb_where3 then
			//if righta(ls_sql, 6 ) <> "Where "  then  ls_sql+= " and "  --Bug #3982: Import Pre-Process error: "No records found for process x" appears before the process is complete
			ls_sql_loop+= ls_where3
		end if
		
		if lower(right(trim(ls_sql_loop), 4)) = ' and' then ls_sql_loop = left(trim(ls_sql_loop), len(trim(ls_sql_loop)) - 3) //(Appeon)Stephen 02.25.2017 - Bug #5514 – Syntax error in Import pre-process when Filter Syntax is used
		if lb_use_prac then
			//if righta(ls_sql, 6 ) <> "Where "  then  ls_sql+= " and "  --Bug #3982: Import Pre-Process error: "No records found for process x" appears before the process is complete
			ls_sql_loop+= ls_where_prac
		end if
//Start Code Change ----09.20.2013 #V14 maha	
		ls_filter = trim(ls_filter)  //(Appeon)Stephen 05.16.2017 - Pre-Process bug (#5641)
		if len(ls_filter) > 3 then
			li_pos = pos (ls_filter, "and " ,1) 
			if li_pos > 0 and li_pos < 6 then
				ls_filter =  " " + ls_filter //add space before and
			else  //add and	
				ls_filter =  " and " + ls_filter
			end if
		end if

		if lower(right(trim(ls_sql_loop), 4)) = ' and' then ls_sql_loop = left(trim(ls_sql_loop), len(trim(ls_sql_loop)) - 3) //(Appeon)Stephen 02.25.2017 - Bug #5514 – Syntax error in Import pre-process when Filter Syntax is used
		if len(ls_filter) > 3 then ls_sql_loop = ls_sql_loop + ls_filter  //Start Code Change ----07.18.2016 #V152 maha - added
		ls_sql_loop = ls_sql_loop + ";"
		//openwithparm(w_sql_msg,ls_sql)
		
		//continue

		ls_presentation_str = "style(type=grid)"		
	
		ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql_loop, ls_presentation_str, ERRORS)
		IF Len(ERRORS) > 0 THEN
			if lb_mess then 
				MessageBox("Caution on import data syntax " + ls_sql_loop, &
				"SyntaxFromSQL caused these errors: " + ERRORS + "~r~r" + ls_sql_loop)
			//	MessageBox("ls_select_table",ls_select_table)
				openwithparm(w_sql_msg,ls_sql_loop)
			else
				of_Log("SyntaxFromSQL caused these errors: " + ERRORS + "~r~r" + ls_sql_loop)
			end if
			RETURN -1
		END IF
		lds_ids = CREATE n_ds
		w = lds_ids.Create( ls_dwsyntax_str, ERRORS)
		if w < 1 then
			if lb_mess then
				messagebox("error on create",errors)
			else
				of_Log("error on create"+errors)
			end if 
		end if
		
		
		lds_ids.settransobject(sqlca)
		dc = lds_ids.retrieve()
		dc = lds_ids.rowcount()
		//---------Begin Modified by (Appeon)Stephen 03.21.2014 for Bug #3982: Import Pre-Process error: "No records found for process x" appears before the process is complete--------
		//if dc = 0 then
		ll_dc_total = ll_dc_total + dc
		if ll_dc_total = 0 and ll_cur_rc >= rc  then 
		//---------End Modfiied ------------------------------------------------------
			//---------Begin Modified by (Appeon)Stephen 07.29.2015 for Request ID # 4633 - Modify the pre-process function to allow missing providers to be treated as a non-fatal error--------
			/*
			if lb_mess then
				messagebox("Retrieval"," No records found for process " + string(p) )
			else
				of_Log(" No records found for process " + string(p) )
			end if
			return 0
			*/
			continue
			//---------End Modfiied ------------------------------------------------------
		end if

	
//debugbreak()			
//@@ find @@@@@@@@@@@@@@@@@@@@@@@
//having gotten the data loop through and filter for specific row values
		test1 = upperbound( ls_get_2a[])
		for  r =  ll_cur_r to ll_cur_rc
			//create the find
			//if using the prac field, use in filter otherwise skip
			ls_find = ""
			if lb_use_prac then
				if len(ls_get_prac_a[r] ) > 0 then
					//---------Begin Modified by (Appeon)Stephen 07.18.2016 for Import Pre-Process issues--------
					//ls_find = "prac_id = " +  ls_get_prac_a[r] + " and "  //Start Code Change ----10.24.2013 #V14 maha
					ls_find = "prac_id = " +  ls_get_prac_a[r]
					//---------End Modfiied ------------------------------------------------------
					
					//ls_find = ls_prac_field + " = " +  ls_get_prac_a[r] + " and "
				else
					ll_ucnt++
					continue
				end if
			end if
				
			if lb_where1 then
			//	ls_find = ls_isg_1 + " = '" + ls_get_1a[r] + "' "  //Start Code Change ----10.24.2013 #V14 maha
			//---------Begin Modified by (Appeon)Stephen 01.08.2014 for get column type--------
			//ls_find = ls_find +  ls_isg_1 + " = '" + ls_get_1a[r] + "' "  //Start Code Change ----10.24.2013 #V14 maha
				if not(isnull(ls_get_1a[r]) or ls_get_1a[r] = '') then //(Appeon)Stephen 07.18.2016 - Import Pre-Process issues
					 if trim(ls_find)<>'' then ls_find = ls_find + " and " //(Appeon)Stephen 07.21.2016 - Import Pre-Process issues
					 if ls_isg_type1 = 'N' or ls_isg_type1='I'  or ls_isg_type1='D' then
						ls_find = ls_find +  ls_isg_1 + " = " + ls_get_1a[r] + " "
					 else
						//---------Begin Modified by (Appeon)Stephen 07.21.2016 for Import Pre-Process issues--------
						//ls_find = ls_find +  ls_isg_1 + " = "+'"' + ls_get_1a[r] + '"'  //Start Code Change ----10.24.2013 #V14 maha
						ls_find_set = ls_get_1a[r]
						if pos(ls_find_set,"''",1) > 0 then ls_find_set = of_strip_char("''", ls_find_set, "~~'") 
						ls_find = ls_find +  ls_isg_1 + " = "+"'" + ls_find_set + "'"
						//---------End Modfiied ------------------------------------------------------						
					end if
				end if
			end if
			//---------End Modfiied ------------------------------------------------------

 			if lb_where2 then
				//---------Begin Modified by (Appeon)Stephen 01.08.2014 for get column type--------
				//ls_find =  ls_find + " and "  + ls_isg_2 + " = '" + ls_get_2a[r] + "' "
				if not(isnull(ls_get_2a[r]) or ls_get_2a[r] = '') then //(Appeon)Stephen 07.18.2016 - Import Pre-Process issues
					 if trim(ls_find)<>'' then ls_find = ls_find + " and " //(Appeon)Stephen 07.21.2016 - Import Pre-Process issues
					 if ls_isg_type2 = 'N' or ls_isg_type2='I' or ls_isg_type2='D' then
						ls_find =  ls_find + ls_isg_2 + " = " + ls_get_2a[r] + " "
					 else
						//---------Begin Modified by (Appeon)Stephen 07.21.2016 for Import Pre-Process issues--------
						//ls_find =  ls_find + ls_isg_2 + " = "+'"' + ls_get_2a[r] + '"'
						ls_find_set = ls_get_2a[r]
						if pos(ls_find_set,"''",1) > 0 then ls_find_set = of_strip_char("''", ls_find_set, "~~'") 
						ls_find = ls_find +  ls_isg_2 + " = "+"'" + ls_find_set + "'"
						//---------End Modfiied ------------------------------------------------------		
					end if
				end if
				//---------End Modfiied ------------------------------------------------------
			end if
			if lb_where3 then
				//---------Begin Modified by (Appeon)Stephen 01.08.2014 for get column type--------
				//ls_find =  ls_find + " and " + ls_isg_3 + " = '" + ls_get_3a[r] + "' "
				if not(isnull(ls_get_3a[r]) or ls_get_3a[r] = '') then //(Appeon)Stephen 07.18.2016 - Import Pre-Process issues
					 if trim(ls_find)<>'' then ls_find = ls_find + " and " //(Appeon)Stephen 07.21.2016 - Import Pre-Process issues
					 if ls_isg_type3 = 'N' or ls_isg_type3='I'  or ls_isg_type3='D' then
						ls_find =  ls_find + ls_isg_3 + " = " + ls_get_3a[r] + " "
					 else
						//---------Begin Modified by (Appeon)Stephen 07.21.2016 for Import Pre-Process issues--------
						//ls_find =  ls_find + ls_isg_3 + " = "+'"' + ls_get_3a[r] + '"'
						ls_find_set = ls_get_3a[r]
						if pos(ls_find_set,"''",1) > 0 then ls_find_set = of_strip_char("''", ls_find_set, "~~'") 
						ls_find = ls_find +  ls_isg_3 + " = "+"'" + ls_find_set + "'"
						//---------End Modfiied ------------------------------------------------------	
					end if
				end if
				//---------End Modfiied ------------------------------------------------------
				
			end if
			//find
//			if r < 5 then
//				openwithparm(w_sql_msg,ls_find)
//			end if

//---------Begin Modified by (Appeon)Stephen 07.18.2016 for Import Pre-Process issues--------
			//if LeftA (ls_find, 5) = " and " then ls_find = mid(ls_find,1,len(ls_find) - 5)   //Start Code Change ----09.18.2015 #V15 maha - trap for "and" at end
			if RightA (ls_find, 5) = " and " then ls_find = mid(ls_find,1,len(ls_find) - 5)
			if isnull(ls_find) or ls_find = '' then continue
			//---------End Modfiied ------------------------------------------------------

			ll_find = lds_ids.find( ls_find, 1, dc)
			
			if 	ll_find < 0 then 
				if lb_mess then
					messagebox("Preprocess", "Error with find syntax~r~r" + ls_find)	
					clipboard(ls_find)
				else
					of_Log("Preprocess Data:Error with find syntax~r~r" + ls_find)			
				end if
				exit
			elseif ll_find = 0 then 
				ll_ucnt++
				continue
			else
				ll_mcnt++
			end if

			//messagebox("found",ll_find)
			//---------Begin Modified by (Appeon)Stephen 01.08.2014 for get column type--------
			//ll_rec = lds_ids.getitemnumber(ll_find, ls_get_field )
			//res = ldw_import.setitem(r, ls_set_field, string(ll_rec ))
			choose case ls_getfield_type
				case 'N','I'
					ls_getfield_data = string(lds_ids.getitemnumber(ll_find, ls_get_field ))
				case 'D'
					ls_getfield_data = string(lds_ids.getitemdatetime(ll_find, ls_get_field ))
				case else
					ls_getfield_data = lds_ids.getitemstring(ll_find, ls_get_field )
			end choose
			res = ldw_import.setitem(r, ls_set_field, ls_getfield_data)
			//---------End Modfiied ------------------------------------------------------
			
		next //import record
	
	if lb_mess then  //Start Code Change ----12.06.2013 #V14 maha
		of_preprocess_msg( "Completed", string (ll_cur_rc))
		of_preprocess_msg( "Matched", string (ll_mcnt))
		of_preprocess_msg( "Unmatched", string (ll_ucnt))
	end if
		
		
	next //group of 500
	ll_mcnt = 0
	ll_ucnt = 0
	li_cur_loop++
	
NEXT //process

destroy lds_ids

if not lb_mess then  //Start Code Change ----12.06.2013 #V14 maha
	if isvalid(w_preprocess_message) then close(w_preprocess_message)
end if


return 1
end function

public function integer of_isg_key (integer ai_table_id, string as_field_name);//====================================================================
//$<Function>: of_isg_key
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 03.13.2015 (V15.1-Import Improvements 2015)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
string ls_key

if ii_curr_isoft_module = 1 then 
	//IntelliCred/App module
	choose case ai_table_id
		case 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 26, 27, 28
			ls_key = "'rec_id', 'prac_id'"
		case 25
			ls_key = "'prac_id'"
		case 32, 44, 45
			//---------Begin Modified by (Appeon)Stephen 08.10.2016 for Import to Affiliation Staff Category key field bug--------
			//ls_key = "'rec_id', 'prac_id', 'facility_id', 'seq_no'"
			ls_key = "'rec_id', 'prac_id', 'seq_no'"
			//---------End Modfiied ------------------------------------------------------
		case 43, 55, 70, 71, 72, 73, 2004
			ls_key = "'rec_id'"
		case 53
			ls_key = "'address_id', 'prac_id', 'facility_id'"
		case 61
			ls_key = "'hosp_affil_id', 'prac_id', 'facility_id'"
		case 62
			ls_key = "'specialty_id', 'prac_id', 'facility_id'"	
		case 2001, 2002
			ls_key = "'lookup_code'"
		case 2003
			ls_key = "'qam_id'"
	end choose
elseif ii_curr_isoft_module = 3 then
	//facility	
    choose case ai_table_id
		case 3001
			ls_key = "'facility_id'"
		case 3002, 3003
			ls_key = "'rec_id'"
	end choose	
elseif  ii_curr_isoft_module = 2 then
	//IntelliContract module	
	choose case ai_table_id
		case 1001, 1008
			ls_key = "'ctx_id'"
		case 1002
			//---------Begin Modified by (Appeon)Stephen 07.19.2016 for Contract import of Contract Contact data--------
			//ls_key = "'ctx_id', 'product_id', 'product_type'"
			ls_key = "'ctx_id'"
			//---------End Modfiied ------------------------------------------------------
		case 1003
			ls_key = "'contact_id'"
		case 1004
			//---------Begin Modified by (Appeon)Stephen 07.19.2016 for Contract import of Contract Contact data--------
			//ls_key = "'contact_id', 'ctx_id', 'ic_area'"
			ls_key = "'contact_id', 'ctx_id'"
			//---------End Modfiied ------------------------------------------------------
		case 1005
			ls_key = "'ctx_id', 'fee_sched_nm_id'"
		case 1006
			ls_key = "'facility_id'"
		case 1007
			ls_key = "'contact_id', 'contact_num_id'"
		case 1009
			ls_key = "'ctx_id', 'hdr_id'"
		case 1010
			ls_key = "'ctx_id', 'hdr_id', 'detail_id'"
	end choose
end if

as_field_name = "'" + trim(as_field_name) + "'"
if pos(ls_key, as_field_name) > 0 then
	return 1
end if

return 0
end function

public function integer of_sql_autorun (long al_imp_id, string as_b_f);//====================================================================
//$<Function>: of_sql_autorun
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 04.14.2015 (V15.1-Import Improvements 2015)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
integer li_order
integer li_row
integer li_ret
integer li_active_status
string   ls_auto_sql
string   ls_before_after
datastore lds_auto_impsql

lds_auto_impsql = create datastore
lds_auto_impsql.dataobject = "d_auto_possql_h"
lds_auto_impsql.settransobject(sqlca)
lds_auto_impsql.retrieve(al_imp_id)
lds_auto_impsql.setsort("sort_order A")
lds_auto_impsql.sort()

li_ret = 1
for li_row = 1 to lds_auto_impsql.rowcount()
	li_active_status = lds_auto_impsql.getitemnumber(li_row, "active_status")
	if li_active_status = 0 then continue
	ls_before_after = lds_auto_impsql.getitemstring(li_row, "before_after")
	if ls_before_after <> as_b_f then continue
	ls_auto_sql = lds_auto_impsql.getitemstring(li_row, "sql_to_run")
	execute immediate :ls_auto_sql using sqlca;
	If SQLCA.sqlcode <> 0 Then
		Messagebox('Error', SQLCA.sqlerrtext )
		Rollback using sqlca;
		li_ret = -1
		exit
	End If
next

destroy lds_auto_impsql
return li_ret
end function

public function string of_get_no_data_error (integer ai_return);//====================================================================
//$<Function>: of_get_no_data_error
//$<Arguments>:
//$<Return>:  string
//$<Description>: Return special Error text when 'From Scheduler and Not rows in the file'.
//$<Author>: (Appeon) long.zhang 10.30.2015 (Issue:Scheduler reports failure when an import points to a file with no data)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

//From Scheduler and Not rows in the file. 
If ib_schedule And ai_return = -1 Then
	Return "Failed to get import data. No data in the file." //It is used in n_cst_scheduler .
Else
	Return "Failed to get import data."
End If


end function

on n_cst_import.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_import.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//////////////////////////////////////////////////////////////
//The flowing datawindow is static create
ids_import_hdr = Create n_import_ds
ids_table_record = Create n_import_ds
ids_import_field = Create n_import_ds
ids_mapping_field = Create n_import_ds
ids_lookup_mapping = Create n_import_ds
ids_dataview_screen = Create n_import_ds
ids_log_proc = Create n_import_ds
ids_log_table = Create n_import_ds
ids_log_error = Create n_import_ds
ids_newrow = Create n_import_ds

//---------Begin Modified by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
/*
ids_address_lookup = Create DataStore
ids_code_lookup = Create DataStore
ids_facility = Create DataStore
ids_committee = Create DataStore
ids_company = Create DataStore
ids_active_status = Create DataStore //V10.1 - Import Active Status
ids_qa_metrics = Create DataStore    //V11.3 QA Import
ids_coderownum1 = Create DataStore
ids_coderownum2 = Create DataStore
ids_security_role = Create DataStore
ids_category_right = Create DataStore
ids_user = Create DataStore
ids_security_user_dept = Create DataStore
*/
ids_address_lookup = Create n_import_ds
ids_code_lookup = Create n_import_ds
ids_facility = Create n_import_ds
ids_committee = Create n_import_ds
ids_company = Create n_import_ds
ids_active_status = Create n_import_ds //V10.1 - Import Active Status
ids_qa_metrics = Create n_import_ds    //V11.3 QA Import
ids_coderownum1 = Create n_import_ds
ids_coderownum2 = Create n_import_ds
ids_security_role = Create n_import_ds
ids_category_right = Create n_import_ds
ids_user = Create n_import_ds
ids_security_user_dept = Create n_import_ds
//---------End Modfiied ------------------------------------------------------

ids_import_hdr.DataObject = "d_import_ds_hdr"
ids_table_record.DataObject = "d_import_ds_table"
ids_import_field.DataObject = "d_import_ds_impfield"
ids_mapping_field.DataObject = "d_import_ds_mapfield"
ids_lookup_mapping.DataObject = "d_import_ds_lumap"
ids_dataview_screen.DataObject = "d_import_ds_dv_screen"
ids_log_proc.DataObject = "d_import_ds_logproc"
ids_log_table.DataObject = "d_import_ds_logtable"
ids_log_error.DataObject = "d_import_ds_logerror"
ids_newrow.DataObject = "d_import_ds_newrownum"

ids_address_lookup.DataObject = "d_import_ds_lu_address"
ids_code_lookup.DataObject = "d_import_ds_lu_code"
ids_facility.DataObject = "d_import_ds_lu_facility"
ids_committee.DataObject = "d_import_ds_lu_committee"
ids_company.DataObject = "d_import_ds_lu_company"
ids_active_status.DataObject = "d_import_ds_lu_activestatus"
ids_qa_metrics.DataObject = "d_import_ds_lu_metrics"
ids_coderownum1.DataObject = "d_import_ds_coderownum"
ids_coderownum2.DataObject = "d_import_ds_coderownum"
ids_security_role.DataObject = "d_dddw_security_roles"
ids_category_right.DataObject = "d_import_ds_categoryright"
ids_user.DataObject = "d_user_list"
ids_security_user_dept.DataObject = "d_import_ds_security_user_department"

ids_import_hdr.SetTransObject(SQLCA)
ids_table_record.SetTransObject(SQLCA)
ids_import_field.SetTransObject(SQLCA)
ids_mapping_field.SetTransObject(SQLCA)
ids_lookup_mapping.SetTransObject(SQLCA)
ids_dataview_screen.SetTransObject(SQLCA)
ids_log_proc.SetTransObject(SQLCA)
ids_log_table.SetTransObject(SQLCA)
ids_log_error.SetTransObject(SQLCA)

ids_address_lookup.SetTransObject(SQLCA)
ids_code_lookup.SetTransObject(SQLCA)
ids_facility.SetTransObject(SQLCA)
ids_committee.SetTransObject(SQLCA)
ids_company.SetTransObject(SQLCA)
ids_active_status.SetTransObject(SQLCA)
ids_qa_metrics.SetTransObject(SQLCA)
ids_security_role.SetTransObject(SQLCA)
ids_category_right.SetTransObject(SQLCA)
ids_user.SetTransObject(SQLCA)
ids_security_user_dept.SetTransObject(SQLCA)

//////////////////////////////////////////////////////////////
//The flowing datawindow is dynamic create
ids_imp_data = Create n_import_ds
ids_intellisoft_table = Create n_import_ds
ids_intellisoft_table_temp = Create n_import_ds

//----------------------------- APPEON BEGIN ----------------------------
//$<add> Stephen 12.25.2012    
//$<reason> V12.3 Import Logging modifications
//$<remark> get field type
ids_sys_field_type = create n_import_ds
ids_sys_field_type.dataobject = "d_imp_sys_field_type"
ids_sys_field_type.settransobject(sqlca)  

ids_audit_log_table = create n_import_ds
ids_audit_log_table.dataobject = "d_import_ds_logtable_audit"
ids_audit_log_table.settransobject(sqlca)  
//----------------------------- APPEON END ------------------------------

//---------Begin Added by (Appeon)Stephen 12.26.2013 for V141 Import Modifications for Facility and Group--------
ids_preprocess = create n_import_ds
ids_preprocess.dataobject = "d_import_pre_process_browse"
ids_preprocess.settransobject(sqlca)  
//---------End Added ------------------------------------------------------
end event

event destructor;Destroy ids_import_hdr
Destroy ids_table_record
Destroy ids_import_field
Destroy ids_mapping_field
Destroy ids_lookup_mapping
Destroy ids_dataview_screen
Destroy ids_log_proc
Destroy ids_log_table
Destroy ids_log_error
Destroy ids_newrow

Destroy ids_address_lookup
Destroy ids_code_lookup
Destroy ids_facility
Destroy ids_committee
Destroy ids_company
Destroy ids_active_status //V10.1 - Import Active Status
Destroy ids_qa_metrics    //V11.3 QA Import
Destroy ids_coderownum1
Destroy ids_coderownum2
Destroy ids_security_role
Destroy ids_category_right
Destroy ids_user
Destroy ids_security_user_dept

Destroy ids_imp_data
Destroy ids_intellisoft_table
Destroy ids_intellisoft_table_temp

 //V12.3 Import Logging modifications --Stephen 12.25.2012  
if isvalid(ids_sys_field_type) then destroy ids_sys_field_type  
if isvalid(ids_audit_log_table) then destroy ids_audit_log_table
if isvalid(ids_imp_audit_hdr) then destroy ids_imp_audit_hdr
if isvalid(ids_imp_audit_item) then destroy ids_imp_audit_item
if isvalid(ids_imp_audit_item_temp) then destroy ids_imp_audit_item_temp


end event

