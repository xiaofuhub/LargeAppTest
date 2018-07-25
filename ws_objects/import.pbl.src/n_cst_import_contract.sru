$PBExportHeader$n_cst_import_contract.sru
forward
global type n_cst_import_contract from n_cst_import
end type
end forward

global type n_cst_import_contract from n_cst_import
end type
global n_cst_import_contract n_cst_import_contract

type variables
// Field audit
n_cst_ctx_audit inv_audit
end variables

forward prototypes
public function integer of_fieldaudit ()
public function integer of_setprimarykey (string as_table_name)
public function integer of_datapopulate ()
public function integer of_dyncreateistabledw (string as_table_name)
public function integer of_postupdate ()
public function integer of_set_ctx_fee_sched_nm_key ()
public function integer of_checkmapping (boolean ab_isimport, long al_table_id, string as_table_name, ref datastore ads_import_field, ref datastore ads_mapping_field, ref string as_errortext[])
public function integer of_datapopulateproc ()
public function integer of_set_ctx_basic_info_def (ref datastore ads_data, long al_row, boolean ab_isadd)
public function integer of_set_ctx_contacts_def (ref datastore ads_data, long al_row)
public function integer of_set_ctx_contract_contacts_def (ref datastore ads_data, long al_row)
public function integer of_set_app_facility_def (ref datastore ads_data, long al_row, boolean ab_isadd)
public function integer of_setdefaultvalue (string as_table_name, ref boolean ab_isnewrow[], ref long al_setdefvaluerow[])
end prototypes

public function integer of_fieldaudit ();string ls_table_name

// Set progress bar
w_import_progressbar.of_SetImportProcessDesc("Field audit")
w_import_progressbar.of_SetMaxPosition(2)
w_import_progressbar.of_SkipNextPosition()

// Execute field audit
ls_table_name = Lower(ids_table_record.object.table_name[ids_table_record.GetRow()])
inv_audit.of_audit_fields(ids_intellisoft_table, ls_table_name)
w_import_progressbar.of_SkipNextPosition()

Return 1
end function

public function integer of_setprimarykey (string as_table_name);long ll_Row, i
long ll_ctx_id
long ll_record_id
long ll_contact_id
long ll_facility_id
long ll_contact_num_id
long ll_InsertRow

// There is no new record
if il_CurrTableAddCount = 0 then Return 1
w_import_progressbar.of_SetImportProcessDesc("Set primary key value")

// Set primary key value
choose case as_table_name
	case "ctx_basic_info"
		// Set ctx_id, record_id
		//Start Change code by Jervis 04.11.2008
		//get contract id from ids.ctx_id.
		//ll_ctx_id = gnv_app.of_get_id("PRAC_ID", il_CurrTableAddCount)
		ll_ctx_id = gnv_app.of_get_id("CTX_ID", il_CurrTableAddCount)
		//End Change code by jervis 04.11.2008
		
		ll_record_id = gnv_app.of_get_Id("RECORD_ID", il_CurrTableAddCount)
		w_import_progressbar.of_SetMaxPosition(il_CurrTableAddCount)
		for i = 1 to il_CurrTableAddCount
			ll_Row = ids_newrow.GetItemNumber(i, "new_row")
			ids_intellisoft_table.SetItem(ll_Row, "ctx_id", ll_ctx_id)
			ids_intellisoft_table.SetItem(ll_Row, "record_id", ll_record_id)
			ll_ctx_id ++
			ll_record_id ++
			w_import_progressbar.of_SkipNextPosition()
		next

	case "ctx_fee_sched_nm"
		// Set record_id, fee_sched_nm_id
		of_set_ctx_fee_sched_nm_key()
		
	case "ctx_contacts"
		// Set contact_id
		ll_record_id = gnv_app.of_get_Id("RECORD_ID", il_CurrTableAddCount)
		SELECT max(contact_id) INTO :ll_contact_id FROM ctx_contacts;
		if IsNull(ll_contact_id) then ll_contact_id = 0
		ll_contact_id ++
		w_import_progressbar.of_SetMaxPosition(il_CurrTableAddCount)
		for i = 1 to il_CurrTableAddCount
			ll_Row = ids_newrow.GetItemNumber(i, "new_row")
			ids_intellisoft_table.SetItem(ll_Row, "contact_id", ll_contact_id)
			ids_intellisoft_table.SetItem(ll_Row, "record_id", ll_record_id)
			ll_contact_id ++
			ll_record_id ++
			w_import_progressbar.of_SkipNextPosition()
		next
		
	case "app_facility"
		// Set facility_id
		SELECT max(facility_id) INTO :ll_facility_id FROM app_facility;
		if IsNull(ll_facility_id) then ll_facility_id = 0
		ll_facility_id ++
		w_import_progressbar.of_SetMaxPosition(il_CurrTableAddCount)
		for i = 1 to il_CurrTableAddCount
			ll_Row = ids_newrow.GetItemNumber(i, "new_row")
			ids_intellisoft_table.SetItem(ll_Row, "facility_id", ll_facility_id)
			ll_facility_id ++
			w_import_progressbar.of_SkipNextPosition()
		next
		
	case "ctx_contacts_numbers"
		// Set record_id, contact_num_id
		ll_record_id = gnv_app.of_get_Id("RECORD_ID", il_CurrTableAddCount)
		SELECT max(contact_num_id) INTO :ll_contact_num_id FROM ctx_contacts_numbers;
		if IsNull(ll_contact_num_id) then ll_contact_num_id = 0
		ll_contact_num_id ++
		w_import_progressbar.of_SetMaxPosition(il_CurrTableAddCount)
		for i = 1 to il_CurrTableAddCount
			ll_Row = ids_newrow.GetItemNumber(i, "new_row")
			ids_intellisoft_table.SetItem(ll_Row, "contact_num_id", ll_contact_num_id)
			ids_intellisoft_table.SetItem(ll_Row, "record_id", ll_record_id)
			ll_contact_num_id ++
			ll_record_id ++
			w_import_progressbar.of_SkipNextPosition()
		next
		
	case "ctx_products", "ctx_contract_contacts"
		// Set record_id
		ll_record_id = gnv_app.of_get_Id("RECORD_ID", il_CurrTableAddCount)
		w_import_progressbar.of_SetMaxPosition(il_CurrTableAddCount)
		for i = 1 to il_CurrTableAddCount
			ll_Row = ids_newrow.GetItemNumber(i, "new_row")
			ids_intellisoft_table.SetItem(ll_Row, "record_id", ll_record_id)
			ll_record_id ++
			w_import_progressbar.of_SkipNextPosition()
		next
	//---------Begin Added by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
	case "ctx_custom_multi_hdr"//added by gavins 20120225
		ll_record_id = gnv_app.of_get_id('multi_ID', il_CurrTableAddCount )
		w_import_progressbar.of_SetMaxPosition(il_CurrTableAddCount)
		for i = 1 to il_CurrTableAddCount
			ll_Row = ids_newrow.GetItemNumber(i, "new_row")
			ids_intellisoft_table.SetItem(ll_Row, "hdr_id", ll_record_id)
			ll_record_id ++
			w_import_progressbar.of_SkipNextPosition()
		next
	case "ctx_custom_multi_detail"//added by gavins 20120225
//		ll_record_id = gnv_app.of_get_id('multi_ID', il_CurrTableAddCount )
		select isnull(custom_id1,0) into:ll_record_id from ids;
		w_import_progressbar.of_SetMaxPosition(il_CurrTableAddCount)
		ll_record_id ++
		for i = 1 to il_CurrTableAddCount
			ll_Row = ids_newrow.GetItemNumber(i, "new_row")
			ids_intellisoft_table.SetItem(ll_Row, "detail_id", ll_record_id)
			ll_record_id ++
			w_import_progressbar.of_SkipNextPosition()
		next	
	//---------End Added ------------------------------------------------------
end choose

Return 1
end function

public function integer of_datapopulate ();//<Overwrite this function>
string ls_table_name

// if no import data
if ids_intellisoft_table_temp.RowCount() <= 0 then Return 1
ls_table_name = Lower(ids_table_record.object.table_name[ids_table_record.GetRow()])

// Cache data for populate data
w_import_progressbar.of_SetImportProcessDesc("Cache data for populate data")
w_import_progressbar.of_SetMaxPosition(2)
w_import_progressbar.of_SkipNextPosition()
ids_intellisoft_table.Retrieve()
w_import_progressbar.of_SkipNextPosition()

// Populate data according to key fields
if of_DataPopulateProc() = -1 then Return -1
ids_intellisoft_table_temp.Reset()

// Set primary key value
of_SetPrimaryKey(ls_table_name)

// Cache foreign key to ids_imp_data
choose case ls_table_name
	case "ctx_basic_info"
		of_CacheForeignKey("sys_pc_id", "ctx_id")
	case "app_facility"
		of_CacheForeignKey("sys_facility_id", "facility_id")
	case "ctx_contacts"
		of_CacheForeignKey("sys_contact_id", "contact_id")
	//---------Begin Added by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
	case "ctx_custom_multi_hdr"	
		of_CacheForeignKey("sys_hdr_id", "hdr_id")
	//---------End Added ------------------------------------------------------
end choose

Return 1
end function

public function integer of_dyncreateistabledw (string as_table_name);//<Overwrite this function>
string  ls_Error
string  ls_ErrorTemp
string  ls_Syntax
string  ls_SyntaxTemp
string  ls_comp_def
string  ls_field_name
string  ls_imp_field_name
string  ls_Fields
string  ls_FieldsTemp
string  ls_SQLSelect
string  ls_SQLSelectTemp
integer i, li_InsertRow
integer li_Pos
n_cst_dw_update_prop lnv_DwSyntax

//1.Get mapped fields of list
for i = 1 to ids_mapping_field.RowCount()
	ls_field_name = Lower(Trim(ids_mapping_field.object.field_name[i]))
	if LenA(ls_Fields) > 0 then ls_Fields += ","
	ls_Fields += ls_field_name
next

//2.Add necessary fields to select SQL(Additional field must place at last)
//For temp DW
//---------Begin Modified by (Appeon)Harry 03.19.2014 for V142 ISG-CLX--------
//ls_FieldsTemp = ls_Fields + ",0 imp_row, 0 err_value, 0 sys_pc_id, 0 sys_facility_id, 0 sys_contact_id"
ls_FieldsTemp = ls_Fields + ",0 imp_row, 0 err_value, 0 sys_pc_id, 0 sys_facility_id, 0 sys_contact_id,0 sys_hdr_id" //Added By Jay Chen 02-20-2014 Remark: add sys_hdr_id
//---------End Modfiied ------------------------------------------------------
if AppeonGetClientType() = "PB" then
	ls_SQLSelectTemp = "SELECT " + ls_FieldsTemp + ",'' sort_field FROM " + as_table_name
else
	ls_SQLSelectTemp = "SELECT " + ls_FieldsTemp + " FROM " + as_table_name
end if

//For update DW
choose case as_table_name
	case "ctx_basic_info"
		if PosA(ls_Fields, "category") <= 0 then ls_Fields += ",category"
		if PosA(ls_Fields, "app_facility") <= 0 then ls_Fields += ",app_facility"
		if PosA(ls_Fields, "contract_type") <= 0 then ls_Fields += ",contract_type"
		if PosA(ls_Fields, "dvision") <= 0 then ls_Fields += ",dvision"
		if PosA(ls_Fields, "status") <= 0 then ls_Fields += ",status"
		if ib_isg_key = false then //(Appeon)Stephen 03.20.2015 - V15.1-Import Improvements 2015
			ls_Fields += ",ctx_id,record_id,version_number,version_date,master_contract_id"
		else
			ls_Fields += ",record_id,version_number,version_date,master_contract_id"
		end if
	case "ctx_contract_contacts"
		if PosA(ls_Fields, "ic_area") <= 0 then ls_Fields += ",ic_area"
		if ib_isg_key = false then //(Appeon)Stephen 03.20.2015 - V15.1-Import Improvements 2015
			ls_Fields += ",ctx_id,contact_id,record_id"
		else
			ls_Fields += ",record_id"
		end if
	case "ctx_products"
		if ib_isg_key = false then //(Appeon)Stephen 03.20.2015 - V15.1-Import Improvements 2015
			ls_Fields += ",ctx_id,record_id"
		else
			ls_Fields += ",record_id"
		end if
	case "ctx_fee_sched_nm"
		if ib_isg_key = false then //(Appeon)Stephen 03.20.2015 - V15.1-Import Improvements 2015
			ls_Fields += ",ctx_id,fee_sched_nm_id,record_id"
		else
			ls_Fields += ",record_id"
		end if
	case "app_facility"
		if PosA(ls_Fields, "contact_type2") <= 0 then ls_Fields += ",contact_type2"
		if PosA(ls_Fields, "corp_office_flag") <= 0 then ls_Fields += ",corp_office_flag"
		if ib_isg_key = false then //(Appeon)Stephen 03.20.2015 - V15.1-Import Improvements 2015
			ls_Fields += ",facility_id"
		end if
	case "ctx_contacts"
		if ib_isg_key = false then //(Appeon)Stephen 03.20.2015 - V15.1-Import Improvements 2015
			ls_Fields += ",facility_id,contact_id,record_id"
		else
			ls_Fields += ",facility_id,record_id"
		end if
	case "ctx_contacts_numbers"
		if ib_isg_key = false then //(Appeon)Stephen 03.20.2015 - V15.1-Import Improvements 2015
			ls_Fields += ",contact_id,contact_num_id,record_id"
		else
			ls_Fields += ",record_id"
		end if
//---------Begin Added by (Appeon)Toney 06.17.2013 for V141 ISG-CLX--------
	case "ctx_custom"//add by gavins 20120207
		if ib_isg_key = false then //(Appeon)Stephen 03.20.2015 - V15.1-Import Improvements 2015
			ls_Fields += ",ctx_id"	
		end if
//---------End Added ------------------------------------------------------------------

	//---------Begin Added by (Appeon)Harry 03.19.2014 for V142 ISG-CLX--------
	case "ctx_custom_multi_hdr" //Added By Jay Chen 02-20-2014
		if ib_isg_key = false then //(Appeon)Stephen 03.20.2015 - V15.1-Import Improvements 2015
			ls_Fields += ",ctx_id,hdr_id"
		end if
	case "ctx_custom_multi_detail" 
		if ib_isg_key = false then //(Appeon)Stephen 03.20.2015 - V15.1-Import Improvements 2015
			ls_Fields += ",ctx_id,hdr_id,detail_id"
		end if
	//---------End Added ------------------------------------------------------
end choose
if AppeonGetClientType() = "PB" then
	ls_SQLSelect = "SELECT " + ls_Fields + ",'' sort_field FROM " + as_table_name
else
	ls_SQLSelect = "SELECT " + ls_Fields + " FROM " + as_table_name
end if

//3.Dynamic create IntelliSoft table datawindow
gnv_appeondb.of_StartQueue()
ls_Syntax = SQLCA.SyntaxFromSQL(ls_SQLSelect, "", ls_Error)
gnv_debug.of_output(False, "ls_SQLSelect = " + ls_SQLSelect) //(Appeon)Harry 01.23.2014 - V142 ISG-CLX
ls_SyntaxTemp = SQLCA.SyntaxFromSQL(ls_SQLSelectTemp, "", ls_ErrorTemp)
gnv_appeondb.of_CommitQueue()
if LenA(ls_Error) > 0 then
	of_Log(0, "", IL_ERRTYPE_MAPDESIGN, "Failed to dynamically create updatable DataWindow." + ls_Error)
	//---------Begin Added by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
	gnv_debug.of_output(True, "Failed to SyntaxFromSQL for updatable DataWindow." + ls_Error)
	gnv_debug.of_output(True, "SQL = " + ls_SQLSelect)
	//---------End Added ------------------------------------------------------
	if not of_IsContinue() then Return -1
	Return -2
end if
if LenA(ls_ErrorTemp) > 0 then
	of_Log(0, "", IL_ERRTYPE_MAPDESIGN, "Failed to dynamically create temporary DataWindow." + ls_ErrorTemp)
	//---------Begin Added by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
	gnv_debug.of_output(True,"Failed to SyntaxFromSQL for temporary DataWindow." + ls_ErrorTemp)
	gnv_debug.of_output(True, "SQL = " + ls_SQLSelect)
	//---------End Added ------------------------------------------------------
	if not of_IsContinue() then Return -1
	Return -2
end if

ids_intellisoft_table.Create(ls_Syntax, ls_Error)

//---------Begin Added by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
If ls_Error <> '' Then
	gnv_debug.of_output(True, "Failed to dynamically create updatable DataWindow." + ls_Error)
	gnv_debug.of_output(True, "ls_Syntax = " + ls_Syntax)
	of_Log(0, "", IL_ERRTYPE_MAPDESIGN, "Failed to dynamically create updatable DataWindow." + ls_Error)
	if not of_IsContinue() then Return -1
	Return -2
End If
//---------End Added ------------------------------------------------------

ids_intellisoft_table.SetTransObject(SQLCA)
ids_intellisoft_table_temp.Create(ls_SyntaxTemp, ls_Error)

//---------Begin Added by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
If ls_Error <> '' Then
	gnv_debug.of_output(True, "Failed to dynamically create temporary DataWindow." + ls_Error)
	gnv_debug.of_output(True, "ls_Syntax = " + ls_SyntaxTemp)
End If

gnv_debug.of_output(False, 'Before set update. ids_intellisoft_table.Describe("DataWindow.Syntax") =' + ids_intellisoft_table.Describe("DataWindow.Syntax") )
//---------End Added ------------------------------------------------------

//if of_ModifyUpdateProperty(ids_intellisoft_table, as_table_name) = -1 then // Add by Evan 04.10.2009
if lnv_DwSyntax.of_ModifyUpdateProperty(ids_intellisoft_table, as_table_name) = -1 then // Add by Evan 06.02.2009
	of_Log(0, "", IL_ERRTYPE_MAPDESIGN, "Failed to modify datawindow update properties.")
	gnv_debug.of_output(True, "Failed to modify datawindow update properties.") //(Appeon)Harry 01.23.2014 - V142 ISG-CLX
	if not of_IsContinue() then Return -1
	Return -2
end if
ids_intellisoft_table.object.datawindow.table.updatewhere = 0
ids_intellisoft_table.Modify("sort_field.update='no'")

//---------Begin Added by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
gnv_debug.of_output(False, 'after set update. ids_intellisoft_table.Describe("DataWindow.Syntax") =' + ids_intellisoft_table.Describe("DataWindow.Syntax") )
//---------End Added ------------------------------------------------------

Return 1
end function

public function integer of_postupdate ();//<Overwrite this function>

// Add audit trail data
if ids_intellisoft_table.ModifiedCount() > 0 then	
	// Add Audit trail data
	of_FieldAudit()
end if

// Reset datastore
ids_intellisoft_table.Reset()

Return 1
end function

public function integer of_set_ctx_fee_sched_nm_key ();long i, ll_Row
long ll_record_id
long ll_prac_id
long ll_RowCount
DataStore lds_sequence

w_import_progressbar.of_SetMaxPosition(il_CurrTableAddCount + 2)

lds_sequence = Create DataStore
lds_sequence.DataObject = "d_import_ds_sequence"
ll_RowCount = ids_intellisoft_table.RowCount()
lds_sequence.object.prac_id[1,ll_RowCount] = ids_intellisoft_table.object.ctx_id[1,ll_RowCount]
lds_sequence.object.seq_no[1,ll_RowCount] = ids_intellisoft_table.object.fee_sched_nm_id[1,ll_RowCount]
w_import_progressbar.of_SkipNextPosition()

// Set record_id
ll_record_id = gnv_app.of_get_Id("RECORD_ID", il_CurrTableAddCount)
for i = 1 to il_CurrTableAddCount
	ll_Row = ids_newrow.GetItemNumber(i, "new_row")
	ids_intellisoft_table.SetItem(ll_Row, "record_id", ll_record_id)
	
	lds_sequence.object.row_num[ll_Row] = ll_Row	
	ll_record_id ++
	w_import_progressbar.of_SkipNextPosition()
next

// Set fee_sched_nm_id
of_SetSequenceNo(lds_sequence, ids_intellisoft_table, il_CurrTableAddCount, "ctx_id", "fee_sched_nm_id", true)
Destroy lds_sequence
w_import_progressbar.of_SkipNextPosition()

Return 1
end function

public function integer of_checkmapping (boolean ab_isimport, long al_table_id, string as_table_name, ref datastore ads_import_field, ref datastore ads_mapping_field, ref string as_errortext[]);//<Overwrite this function>
string  ls_field_name
string  ls_field_name_allias
string  ls_imp_field_name
integer li_Return
integer li_KeyFieldCount
integer i, li_FieldCount
boolean lb_IsProductIDExists = false
boolean lb_IsProductIDKeyField = false
boolean lb_IsProductTypeExists = false
boolean lb_IsProductTypeKeyField = false
boolean lb_IsICAreaExists = false
boolean lb_IsICAreaKeyField = false
boolean lb_IsFirstNameExists = false
boolean lb_IsLastNameExists = false
boolean lb_IsContactType2Exists = false
//---------Begin Added by (Appeon)Toney 06.17.2013 for V141 ISG-CLX--------
boolean lb_IsCTXCategory = false //Added By Ken.Guo 2011-03-16.
//---------End Added ------------------------------------------------------------------


//////////////////////////////////////////////////////////////////////////////////////////////
// There is no creation mapped relationship
li_FieldCount = ads_mapping_field.RowCount()
if li_FieldCount <= 0 then
	li_Return = of_Log(ab_IsImport, "No mapping relationship was created.", as_ErrorText[])
	if ab_IsImport then Return li_Return
	Return 1 //Have one error
end if

//////////////////////////////////////////////////////////////////////////////////////////////
// Check IntelliSoft field name
for i = 1 to li_FieldCount
	// Get field name
	ls_field_name = Lower(Trim(ads_mapping_field.object.field_name[i]))
	ls_field_name_allias = ads_mapping_field.object.field_name_allias[i]
	ls_imp_field_name = Trim(ads_mapping_field.object.imp_field_name[i])

	// Set flags
	if ls_field_name = "ic_area" then
		lb_IsICAreaExists = true
		if ads_mapping_field.object.key_field[i] = 1 then lb_IsICAreaKeyField = true
	end if
	if ls_field_name = "product_id" then
		lb_IsProductIDExists = true
		if ads_mapping_field.object.key_field[i] = 1 then lb_IsProductIDKeyField = true
	end if
	if ls_field_name = "product_type" then
		lb_IsProductTypeExists = true
		if ads_mapping_field.object.key_field[i] = 1 then lb_IsProductTypeKeyField = true
	end if
	if ls_field_name = "contact_type2" then lb_IsContactType2Exists = true
	if ls_field_name = "first_name" then lb_IsFirstNameExists = true
	if ls_field_name = "last_name" then lb_IsLastNameExists = true
	//---------Begin Added by (Appeon)Toney 06.17.2013 for V141 ISG-CLX--------
	if ls_field_name = "category" then lb_IsCTXCategory = true //Added By Ken.Guo 2011-03-16.	
	//---------End Added ------------------------------------------------------------------

	
	// Increase key field count
	if ads_mapping_field.object.key_field[i] = 1 then li_KeyFieldCount ++
	
	// Check field name if null
	if IsNull(ls_field_name) or LenA(ls_field_name) <= 0 then
		li_Return = of_Log(ab_IsImport, "IntelliSoft field can not be null. (import field is '" + ls_imp_field_name + "')", as_ErrorText[])
		if ab_IsImport then Return li_Return
	end if	
	if IsNull(ls_imp_field_name) then
		if IsNull(ads_mapping_field.object.facility_id[i]) then
			li_Return = of_Log(ab_IsImport, "Import field can not be null. (IntelliSoft field is '" + ls_field_name_allias + "')", as_ErrorText[])
			if ab_IsImport then Return li_Return
		end if
	else
		if LenA(ls_imp_field_name) <= 0 then
			li_Return = of_Log(ab_IsImport, "Import field can not be null. (IntelliSoft field is '" + ls_field_name_allias + "')", as_ErrorText[])
			if ab_IsImport then Return li_Return
		end if
	end if
next
//---------Begin Added by (Appeon)Toney 06.17.2013 for V141 ISG-CLX--------
If as_table_name = 'ctx_custom' Then li_KeyFieldCount = 1//add by gavins 20120207
//---------End Added ------------------------------------------------------------------

//////////////////////////////////////////////////////////////////////////////////////////////
// Check key field
if li_KeyFieldCount = 0 then
	li_Return = of_Log(ab_IsImport, "There is no key field.", as_ErrorText[])
	if ab_IsImport then Return li_Return
end if

//////////////////////////////////////////////////////////////////////////////////////////////
// Check particular table
choose case as_table_name
	case "ctx_products"
		if not lb_IsProductIDExists then
			li_Return = of_Log(ab_IsImport, "'Product Id' field is required.", as_ErrorText[])
			if ab_IsImport then Return li_Return
		end if
		if not lb_IsProductIDKeyField then
			li_Return = of_Log(ab_IsImport, "'Product Id' field must be key field.", as_ErrorText[])
			if ab_IsImport then Return li_Return
		end if
		if not lb_IsProductTypeExists then
			li_Return = of_Log(ab_IsImport, "'Product Type' field is required.", as_ErrorText[])
			if ab_IsImport then Return li_Return
		end if
		if not lb_IsProductTypeKeyField then
			li_Return = of_Log(ab_IsImport, "'Product Type' field must be key field.", as_ErrorText[])
			if ab_IsImport then Return li_Return
		end if
		
	case "ctx_contract_contacts"
		if not lb_IsICAreaExists then
			li_Return = of_Log(ab_IsImport, "'Ic Area' field is required.", as_ErrorText[])
			if ab_IsImport then Return li_Return
		end if
		if not lb_IsICAreaKeyField then
			li_Return = of_Log(ab_IsImport, "'Ic Area' field must be key field.", as_ErrorText[])
			if ab_IsImport then Return li_Return
		end if

	case "ctx_contacts"
		if not lb_IsFirstNameExists then
			li_Return = of_Log(ab_IsImport, "'First Name' field is required.", as_ErrorText[])
			if ab_IsImport then Return li_Return
		end if
		if not lb_IsLastNameExists then
			li_Return = of_Log(ab_IsImport, "'Last Name' field is required.", as_ErrorText[])
			if ab_IsImport then Return li_Return
		end if

	case "app_facility"
		if not lb_IsContactType2Exists then
			li_Return = of_Log(ab_IsImport, "'Contact Type2' field is required.", as_ErrorText[])
			if ab_IsImport then Return li_Return
		end if
//---------Begin Added by (Appeon)Toney 06.17.2013 for V141 ISG-CLX--------
	//Added By Ken.Guo 2011-03-16.	
	case "ctx_basic_info"
		If not lb_IsCTXCategory Then
			li_Return = of_Log(ab_IsImport, "'Category' field is required.", as_ErrorText[])
			if ab_IsImport then Return li_Return			
		End If		
//---------End Added ------------------------------------------------------------------
end choose

// Return
if ab_IsImport then
	Return 1
else
	Return UpperBound(as_ErrorText)
end if
end function

public function integer of_datapopulateproc ();any  la_OldValue
any  la_NewValue
long ll_ctx_id
long ll_facility_id
long ll_contact_id
long ll_Row
long ll_FindRow
long ll_RowCount
long ll_ImportDataRow
integer li_add_protocol
integer i, li_FieldCount
integer li_KeyFieldCount
integer li_KeyFieldIndex[]
string  ls_FindValue
string  ls_table_name
string  ls_KeyField1[]
string  ls_KeyField2[]
boolean lb_IsAdd
boolean lb_IsNewRow[]
long    ll_SetDefValueRow[]
//---------Begin Added by (Appeon)Toney 06.17.2013 for V141 ISG-CLX--------
string ls_NullKey[] //add by gavins 20120207
//---------End Added ------------------------------------------------------------------


// Set progress bar
ll_RowCount = ids_intellisoft_table_temp.RowCount()
if ll_RowCount <= 0 then Return 1
w_import_progressbar.of_SetImportProcessDesc("Populate data")
w_import_progressbar.of_SetMaxPosition(ll_RowCount + 2)

li_add_protocol = ids_import_hdr.object.add_protocol[1]
ls_table_name = Lower(ids_table_record.object.table_name[ids_table_record.GetRow()])
li_FieldCount = ids_mapping_field.RowCount()
ids_newrow.Reset()

// Dynamic create find column
li_KeyFieldCount = of_GetKeyFields(li_KeyFieldIndex[], ls_KeyField1[])
//---------Begin Added by (Appeon)Toney 06.17.2013 for V141 ISG-CLX--------
If ls_Table_Name = 'ctx_custom' Then//add by gavins 20120207
	li_KeyFieldCount = 0 
	ls_KeyField1 = ls_NullKey
End If
//---------End Added ------------------------------------------------------------------
ls_KeyField2[] = ls_KeyField1[]
choose case ls_table_name
	case "ctx_basic_info", "app_facility"
	case "ctx_contacts"
		ls_KeyField1[li_KeyFieldCount + 1] = "facility_id"
		ls_KeyField2[li_KeyFieldCount + 1] = "sys_facility_id"
	case "ctx_contacts_numbers"
		ls_KeyField1[li_KeyFieldCount + 1] = "contact_id"
		ls_KeyField2[li_KeyFieldCount + 1] = "sys_contact_id"
	case "ctx_contract_contacts"
		ls_KeyField1[li_KeyFieldCount + 1] = "ctx_id"
		ls_KeyField1[li_KeyFieldCount + 2] = "contact_id"
		ls_KeyField2[li_KeyFieldCount + 1] = "sys_pc_id"
		ls_KeyField2[li_KeyFieldCount + 2] = "sys_contact_id"
	//---------Begin Added by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
	case "ctx_custom_multi_detail"
		ls_KeyField1[li_KeyFieldCount + 1] = "ctx_id"
		ls_KeyField1[li_KeyFieldCount + 2] = "hdr_id"
		ls_KeyField2[li_KeyFieldCount + 1] = "sys_pc_id"
		ls_KeyField2[li_KeyFieldCount + 2] = "sys_hdr_id"
	//---------End Added ------------------------------------------------------
	case else // Child table of ctx_basic_info
		ls_KeyField1[li_KeyFieldCount + 1] = "ctx_id"
		ls_KeyField2[li_KeyFieldCount + 1] = "sys_pc_id"
end choose
ids_intellisoft_table.of_CreateFindColumn(ls_KeyField1[])
ids_intellisoft_table_temp.of_CreateFindColumn(ls_KeyField2[])
w_import_progressbar.of_SkipNextPosition()

// Populate data according to key fields
for ll_Row = 1 to ll_RowCount
	// Ignore null row
	w_import_progressbar.of_SkipNextPosition()
	ll_ImportDataRow = ids_intellisoft_table_temp.GetItemNumber(ll_Row, "imp_row")
	if ids_intellisoft_table_temp.of_IsNullRow(ll_Row, li_KeyFieldIndex[], li_KeyFieldCount) then
		Continue
	end if
	
	// Find Key Field
	ls_FindValue = ids_intellisoft_table_temp.GetItemString(ll_Row, IS_KEY_FIELD)
	ll_FindRow = ids_intellisoft_table.of_Find(IS_KEY_FIELD, ls_FindValue, true)
	
	//---------Begin Added by (Appeon)Stephen 04.22.2015 for V15.1-Import Improvements 2015--------
	if ib_isg_key = true and ll_FindRow < 1 then
		of_Log(ll_ImportDataRow, "Key Field", IL_ERRTYPE_MAPDESIGN, "When matching with ISG key fields, it's not allowed to add new practitioner.")
		return -1
	end if
	//---------End Added ------------------------------------------------------
	
	if ll_FindRow > 0 then
		lb_IsAdd = false
		il_CurrTableModifyCount ++
	else
		lb_IsAdd = true
		ll_FindRow = Abs(ll_FindRow)
		choose case ls_table_name
			case "ctx_basic_info"				
				if li_add_protocol = 0 then
					of_Log(ll_ImportDataRow, "Key Field", IL_ERRTYPE_MAPDESIGN, "When 'No Match Setting'='Generate Error', it's not allowed to add new contract.")
					if not of_IsContinue() then Return -1
					Continue
				end if
			//---------Begin Modified by (Appeon)Toney 06.17.2013 for V141 ISG-CLX--------			
			  /*
				case "ctx_products", "ctx_contract_contacts", "ctx_fee_sched_nm"	
			  */
			case "ctx_products", "ctx_contract_contacts", "ctx_fee_sched_nm", "ctx_custom" //"ctx_custom"add by gavins 20120207
			//---------End Modfiied ------------------------------------------------------------------			
				ll_ctx_id = ids_intellisoft_table_temp.GetItemNumber(ll_Row, "sys_pc_id")
				if ll_ctx_id > 0 then
					ids_intellisoft_table.SetItem(ll_FindRow, "ctx_id", ll_ctx_id)
				else
					Continue
				end if
				if ls_table_name = "ctx_contract_contacts" then
					ll_contact_id = ids_intellisoft_table_temp.GetItemNumber(ll_Row, "sys_contact_id")
					if ll_contact_id > 0 then
						ids_intellisoft_table.SetItem(ll_FindRow, "contact_id", ll_contact_id)
					else
						Continue
					end if
				end if
			case "ctx_contacts"
				ll_facility_id = ids_intellisoft_table_temp.GetItemNumber(ll_Row, "sys_facility_id")
				if ll_facility_id > 0 then
					ids_intellisoft_table.SetItem(ll_FindRow, "facility_id", ll_facility_id)
				else
					Continue
				end if
			case "ctx_contacts_numbers"
				ll_contact_id = ids_intellisoft_table_temp.GetItemNumber(ll_Row, "sys_contact_id")
				if ll_contact_id > 0 then
					ids_intellisoft_table.SetItem(ll_FindRow, "contact_id", ll_contact_id)
				else
					Continue
				end if
			//---------Begin Added by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
			case "ctx_custom_multi_hdr"
				ll_ctx_id = ids_intellisoft_table_temp.GetItemNumber(ll_Row, "sys_pc_id")
				if ll_ctx_id > 0 then
					ids_intellisoft_table.SetItem(ll_FindRow, "ctx_id", ll_ctx_id)
				else
					Continue
				end if
			case "ctx_custom_multi_detail"
				ll_ctx_id = ids_intellisoft_table_temp.GetItemNumber(ll_Row, "sys_pc_id")
				if ll_ctx_id > 0 then
					ids_intellisoft_table.SetItem(ll_FindRow, "ctx_id", ll_ctx_id)
				else
					Continue
				end if
				ll_contact_id = ids_intellisoft_table_temp.GetItemNumber(ll_Row, "sys_hdr_id")
				if ll_contact_id > 0 then
					ids_intellisoft_table.SetItem(ll_FindRow, "hdr_id", ll_contact_id)
				else
					Continue
				end if
			//---------End Added ------------------------------------------------------
		end choose
		il_CurrTableAddCount ++
		ids_newrow.InsertRow(0)
		ids_newrow.SetItem(il_CurrTableAddCount, "new_row", ll_FindRow)
		ids_newrow.SetItem(il_CurrTableAddCount, "imp_row", ll_ImportDataRow)
	end if
	lb_IsNewRow[upperbound(lb_IsNewRow) + 1] = lb_IsAdd
	ll_SetDefValueRow[upperbound(ll_SetDefValueRow) + 1] = ll_FindRow
		
	// Replace value of ids_intellisoft_table with ids_intellisoft_table_TEMP
	for i = 1 to li_FieldCount
		la_OldValue = ids_intellisoft_table.object.data[ll_FindRow, i]
		la_NewValue = ids_intellisoft_table_temp.object.data[ll_Row, i]
		if IsNull(la_OldValue) and IsNull(la_NewValue) then Continue
		if la_OldValue = la_NewValue then
		else
			ids_intellisoft_table.SetItem(ll_FindRow, i, la_NewValue)
		end if
	next

	// Other operations
	choose case ls_table_name
		case "ctx_basic_info"
			// Record row number of sys_pc_id(ctx_id)
			ids_imp_data.SetItem(ll_ImportDataRow, "sys_pc_id", ll_FindRow)
		case "app_facility"
			// Record row number of sys_facility_id
			ids_imp_data.SetItem(ll_ImportDataRow, "sys_facility_id", ll_FindRow)
		case "ctx_contacts"
			// Record row number of sys_contact_id
			ids_imp_data.SetItem(ll_ImportDataRow, "sys_contact_id", ll_FindRow)
		//---------Begin Added by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
		case "ctx_custom_multi_hdr"	
			ids_imp_data.SetItem(ll_ImportDataRow, "sys_hdr_id", ll_FindRow)
		//---------End Added ------------------------------------------------------
	end choose
next

// Stop import data
if of_IsStopImport() then Return -1

// Set default value with project's default value
of_SetDefaultValue(ls_table_name, lb_IsNewRow[], ll_SetDefValueRow[])

Return 1
end function

public function integer of_set_ctx_basic_info_def (ref datastore ads_data, long al_row, boolean ab_isadd);// Set default value with hard code
if ab_IsAdd then
	ads_data.SetItem(al_Row, "version_number", "1.0")
	ads_data.SetItem(al_Row, "version_date", DateTime(Today(), Now()))
	ads_data.SetItem(al_Row, "master_contract_id", 0)
end if

// Set default value with Project's value
if IsNull(ads_data.object.status[al_Row]) then
	if IsNull(ids_import_hdr.object.ctx_status[1]) then
	else
		ads_data.SetItem(al_Row, "status", ids_import_hdr.object.ctx_status[1])
	end if
end if
if IsNull(ads_data.object.category[al_Row]) then
	if IsNull(ids_import_hdr.object.ctx_category[1]) then
	else
		ads_data.SetItem(al_Row, "category", ids_import_hdr.object.ctx_category[1])
	end if
end if
if IsNull(ads_data.object.app_facility[al_Row]) then
	if IsNull(ids_import_hdr.object.ctx_app_facility[1]) then
	else
		ads_data.SetItem(al_Row, "app_facility", ids_import_hdr.object.ctx_app_facility[1])
	end if
end if
if IsNull(ads_data.object.contract_type[al_Row]) then
	if IsNull(ids_import_hdr.object.ctx_contract_type[1]) then
	else
		ads_data.SetItem(al_Row, "contract_type", ids_import_hdr.object.ctx_contract_type[1])
	end if
end if
if IsNull(ads_data.object.dvision[al_Row]) then
	if IsNull(ids_import_hdr.object.ctx_dvision[1]) then
	else
		ads_data.SetItem(al_Row, "dvision", ids_import_hdr.object.ctx_dvision[1])
	end if
end if

Return 1
end function

public function integer of_set_ctx_contacts_def (ref datastore ads_data, long al_row);// Set default value with Project's value
/*
if IsNull(ads_data.object.user_d[al_Row]) then
	ads_data.SetItem(al_Row, "user_d", ids_import_hdr.object.cta_user_id[1])
end if
if IsNull(ads_data.object.first_name[al_Row]) then
	ads_data.SetItem(al_Row, "first_name", ids_import_hdr.object.cta_first_name[1])
end if
if IsNull(ads_data.object.last_name[al_Row]) then
	ads_data.SetItem(al_Row, "last_name", ids_import_hdr.object.cta_last_name[1])
end if
if IsNull(ads_data.object.contact_type[al_Row]) then
	ads_data.SetItem(al_Row, "contact_type", ids_import_hdr.object.cta_contact_type[1])
end if


if IsNull(ads_data.object.facility_id[al_Row]) then
	if IsNull(ids_import_hdr.object.cta_facility_id[1]) then
		if il_facility_id_def > 0 then
			ads_data.SetItem(al_Row, "facility_id", il_facility_id_def)
		end if
	else
		ads_data.SetItem(al_Row, "facility_id", ids_import_hdr.object.cta_facility_id[1])
	end if
end if
*/

Return 1
end function

public function integer of_set_ctx_contract_contacts_def (ref datastore ads_data, long al_row);string ls_ic_area

// Set default value
ls_ic_area = ads_data.object.ic_area[al_Row]
if (IsNull(ls_ic_area)) or not (ls_ic_area = "I" or ls_ic_area = "E") then
	if IsNull(ids_import_hdr.object.ctxcta_ic_area[1]) then
		ads_data.SetItem(al_Row, "ic_area", "I")
	else
		// Set value with Project's default value
		ads_data.SetItem(al_Row, "ic_area", ids_import_hdr.object.ctxcta_ic_area[1])
	end if
end if

Return 1
end function

public function integer of_set_app_facility_def (ref datastore ads_data, long al_row, boolean ab_isadd);string ls_contact_type2

// Set default value with hard code
if ab_IsAdd and IsNull(ads_data.object.corp_office_flag[al_Row]) then
	ads_data.SetItem(al_Row, "corp_office_flag", 0)
end if

ls_contact_type2 = ads_data.object.contact_type2[al_Row]
if (IsNull(ls_contact_type2)) or not (ls_contact_type2 = "A" or ls_contact_type2 = "B" or ls_contact_type2 = "O") then
	ads_data.SetItem(al_Row, "contact_type2", "B")
end if

Return 1
end function

public function integer of_setdefaultvalue (string as_table_name, ref boolean ab_isnewrow[], ref long al_setdefvaluerow[]);long i, ll_RowCount

ll_RowCount = UpperBound(al_SetDefValueRow)

for i = 1 to ll_RowCount
	choose case as_table_name
		case "ctx_basic_info"
			// Set default value
			of_set_ctx_basic_info_def(ids_intellisoft_table, al_SetDefValueRow[i], ab_IsNewRow[i])
		case "app_facility"
			// Set default value
			of_set_app_facility_def(ids_intellisoft_table, al_SetDefValueRow[i], ab_IsNewRow[i])
		case "ctx_contract_contacts"
			// Set default value
			of_set_ctx_contract_contacts_def(ids_intellisoft_table, al_SetDefValueRow[i])
	end choose
next

Return 1
end function

on n_cst_import_contract.create
call super::create
end on

on n_cst_import_contract.destroy
call super::destroy
end on

