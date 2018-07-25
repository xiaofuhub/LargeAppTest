$PBExportHeader$w_import_painter.srw
forward
global type w_import_painter from w_response
end type
type tab_1 from tab within w_import_painter
end type
type tabpage_hdr from userobject within tab_1
end type
type dw_browse from u_dw within tabpage_hdr
end type
type dw_imp_sql from u_dw within tabpage_hdr
end type
type dw_imp_hdr from u_dw within tabpage_hdr
end type
type tabpage_hdr from userobject within tab_1
dw_browse dw_browse
dw_imp_sql dw_imp_sql
dw_imp_hdr dw_imp_hdr
end type
type tabpage_field_data from userobject within tab_1
end type
type cb_create_value_list from commandbutton within tabpage_field_data
end type
type cb_com_wizard from commandbutton within tabpage_field_data
end type
type cb_edit_map from commandbutton within tabpage_field_data
end type
type dw_detail from u_dw within tabpage_field_data
end type
type dw_map_fields from u_dw within tabpage_field_data
end type
type dw_records from u_dw within tabpage_field_data
end type
type dw_fields from u_dw within tabpage_field_data
end type
type dw_tables from u_dw within tabpage_field_data
end type
type ln_1 from line within tabpage_field_data
end type
type ln_2 from line within tabpage_field_data
end type
type ln_4 from line within tabpage_field_data
end type
type ln_5 from line within tabpage_field_data
end type
type ln_3 from line within tabpage_field_data
end type
type dw_imp_field_detail from u_dw within tabpage_field_data
end type
type dw_field_list from u_dw within tabpage_field_data
end type
type dw_compute_verify from datawindow within tabpage_field_data
end type
type dw_prac_cont_id from u_dw within tabpage_field_data
end type
type tabpage_field_data from userobject within tab_1
cb_create_value_list cb_create_value_list
cb_com_wizard cb_com_wizard
cb_edit_map cb_edit_map
dw_detail dw_detail
dw_map_fields dw_map_fields
dw_records dw_records
dw_fields dw_fields
dw_tables dw_tables
ln_1 ln_1
ln_2 ln_2
ln_4 ln_4
ln_5 ln_5
ln_3 ln_3
dw_imp_field_detail dw_imp_field_detail
dw_field_list dw_field_list
dw_compute_verify dw_compute_verify
dw_prac_cont_id dw_prac_cont_id
end type
type tabpage_data from userobject within tab_1
end type
type dw_preprocess from u_dw within tabpage_data
end type
type gb_operation from groupbox within tabpage_data
end type
type cb_filter from commandbutton within tabpage_data
end type
type cb_sort from commandbutton within tabpage_data
end type
type cb_get_saved from commandbutton within tabpage_data
end type
type cb_savedata from commandbutton within tabpage_data
end type
type cbx_store_temp from checkbox within tabpage_data
end type
type cb_imp_pro from commandbutton within tabpage_data
end type
type cb_imp_data from commandbutton within tabpage_data
end type
type cb_pp_run from commandbutton within tabpage_data
end type
type dw_imp_data from u_dw within tabpage_data
end type
type tabpage_data from userobject within tab_1
dw_preprocess dw_preprocess
gb_operation gb_operation
cb_filter cb_filter
cb_sort cb_sort
cb_get_saved cb_get_saved
cb_savedata cb_savedata
cbx_store_temp cbx_store_temp
cb_imp_pro cb_imp_pro
cb_imp_data cb_imp_data
cb_pp_run cb_pp_run
dw_imp_data dw_imp_data
end type
type tabpage_log from userobject within tab_1
end type
type dw_imp_table from u_dw within tabpage_log
end type
type dw_imp_proc from u_dw within tabpage_log
end type
type dw_imp_err from u_dw within tabpage_log
end type
type tabpage_log from userobject within tab_1
dw_imp_table dw_imp_table
dw_imp_proc dw_imp_proc
dw_imp_err dw_imp_err
end type
type tab_1 from tab within w_import_painter
tabpage_hdr tabpage_hdr
tabpage_field_data tabpage_field_data
tabpage_data tabpage_data
tabpage_log tabpage_log
end type
type cb_pp_set from commandbutton within w_import_painter
end type
type cb_report from commandbutton within w_import_painter
end type
end forward

global type w_import_painter from w_response
integer x = 5
integer y = 4
integer width = 4114
integer height = 2324
string title = "Import Setup"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = main!
long backcolor = 33551856
boolean center = false
event pfc_cst_edit_projects ( )
event pfc_cst_add ( )
event pfc_cst_delete ( )
event pfc_cst_copy ( )
event pfc_cst_lookup_mapping ( )
event pfc_cst_run_import ( )
event pfc_cst_check_mapping ( )
event pfc_cst_createimportfields ( )
event pfc_cst_auto_import ( )
event pfc_cst_copymap ( )
event ue_run_only ( )
tab_1 tab_1
cb_pp_set cb_pp_set
cb_report cb_report
end type
global w_import_painter w_import_painter

type prototypes

end prototypes

type variables
// Error information variables
string is_hdr_errinfo
string is_mapfield_errinfo

// Control drag variables
long il_DragRow
boolean ib_LockFile

// Import ID variables
long il_curr_import_id
long il_page2_import_id
long il_page3_import_id
long il_page4_import_id

// Import Type
integer ii_curr_isoft_module
integer ii_preprocess

// Import table
string is_curr_table_name

// Lookup table
DataStore ids_LookUpTableDDDW[2]

// Current mapped DW
integer ii_CurrMappedDW = 2

// Selected rows
long il_DragValue[]
long il_SelectedCount

// Control variables
boolean ib_PromptCreateImportField = true
boolean ib_IsIntelliCredApp = true
boolean ib_IsIntelliContract = true

//Store data for an individual import
integer ii_set73, ii_process_id

//---------Begin Added by (Appeon)Toney 06.18.2013 for V141 ISG-CLX--------
boolean ib_isCopy = false
long il_pre_import_id
//---------End Added ------------------------------------------------------------------

str_parm istr_ocr  //(Appeon)Stephen 06.11.2014 - Using image OCR to import data into IntelliCred 14.2

//---------Begin Added by (Appeon)Stephen 03.17.2015 for V15.1-Import Improvements 2015--------
datastore ids_sysimp_fields
//---------End Added ------------------------------------------------------

end variables

forward prototypes
public function blob of_readfile (string as_file)
public subroutine of_createimportfield ()
public function integer of_getfieldfromtxt (string as_file, ref string as_fields[])
public function integer of_getfieldfromcsv (string as_file, ref string as_fields[])
public function integer of_getfieldfromformattxt (string as_file, string as_record_delimiter, string as_field_delimiter, ref string as_fields[])
public function integer of_getfieldfromodbc (string as_file, string as_odbc_name, string as_odbc_login, string as_odbc_password, string as_import_sql, ref string as_fields[])
public function integer of_begindrag (datawindow adw_data)
public subroutine of_completetrans (boolean ab_iscommit)
public function integer of_checkimportfieldname (long al_fieldcount, string as_importfields[])
public function integer of_getimportfields (ref string as_fields[])
public function integer of_setmenu (integer ai_index)
public function integer of_setmappeddwtitle (integer al_current)
public function string of_replaceblank (string as_string, string as_new)
public function string of_getcontractfieldfilter (datawindow adw_tables)
public function integer of_selectvalue (ref string as_value)
public function long of_getinsertrow (datawindow adw_table, long al_parent_table_id)
public function long of_getinsertrow (long al_table_id)
public function integer of_preprocess_data (integer li_process, string as_file_from, string as_file_to)
public function string of_correcttablename (string as_name)
public function integer of_store_file (long al_process_id)
public function string of_readfile_str (string as_file)
public subroutine of_copy_field_data (long al_ori_import_id, long al_new_import_id)
public function integer of_preprocess_import (long al_imp)
public function integer of_preprocess_msg (string as_type, string as_msg)
public function integer of_verify_field_name (u_dw adw_1, string as_field)
public function integer of_isg_key (integer ai_table_id, long al_field_id)
public function integer of_check_isgkey (datawindow adw_table_list, datawindow adw_isg_field, datawindow adw_field_list)
public function integer of_security (integer ai_security)
public function integer of_run_only_set ()
public function integer of_presql_status (integer al_row)
end prototypes

event pfc_cst_edit_projects();long ll_project_id
long ll_CurrentRow
DataWindowChild ldwc_Child1
DataWindowChild ldwc_Child2

ll_CurrentRow = tab_1.tabpage_hdr.dw_browse.GetRow()
if ll_CurrentRow > 0 then
	ll_project_id = tab_1.tabpage_hdr.dw_browse.object.project_id[ll_CurrentRow]
else
	ll_project_id = 0
end if
OpenWithParm(w_import_project, ll_project_id)

if Message.StringParm <> "nochanged!" then
	tab_1.tabpage_hdr.dw_browse.GetChild("project_id", ldwc_Child1)
	tab_1.tabpage_hdr.dw_imp_hdr.GetChild("project_id", ldwc_Child2)
	ldwc_Child1.SetTransObject(SQLCA)
	ldwc_Child2.SetTransObject(SQLCA)
	gnv_appeondb.of_StartQueue()
	ldwc_Child1.Retrieve()
	ldwc_Child2.Retrieve()
	gnv_appeondb.of_CommitQueue()	
	tab_1.tabpage_hdr.dw_browse.SetRedraw(true)
	tab_1.tabpage_hdr.dw_imp_hdr.SetRedraw(true)
end if
end event

event pfc_cst_add();choose case tab_1.SelectedTab
	case 1
		tab_1.tabpage_hdr.Event ue_add()
	case 2
		tab_1.tabpage_field_data.Event ue_addimportfield()
end choose
end event

event pfc_cst_delete();choose case tab_1.SelectedTab
	case 1
		tab_1.tabpage_hdr.Event ue_delete()
	case 2
		tab_1.tabpage_field_data.Event ue_deleteimportfield()
end choose
end event

event pfc_cst_copy();//---------Begin Modified by (Appeon)Toney 06.18.2013 for V141 ISG-CLX--------
  /*
    tab_1.tabpage_hdr.Event ue_copyadd()  
  */
//Modify By Jervis 12.18.2009
//tab_1.tabpage_hdr.Event ue_copyadd()
if this.event pfc_save() < 0 then return
this.ib_iscopy = true
tab_1.tabpage_hdr.Event ue_copyadd()
this.event pfc_save()
this.ib_iscopy = false
//---------End Modfiied ------------------------------------------------------------------
end event

event pfc_cst_lookup_mapping();string ls_IsChange
DataWindowChild ldwc_Child

Open(w_import_lookup_mapping)
ls_IsChange = Message.StringParm

if ls_IsChange = "YES!" then
	tab_1.tabpage_field_data.dw_detail.GetChild("lu_template", ldwc_Child)
	ldwc_Child.SetTransObject(SQLCA)
	ldwc_Child.Retrieve()
	ldwc_Child.InsertRow(1)
end if
end event

event pfc_cst_run_import();long ll_LastRow
n_cst_import_credapp lnv_import_credapp
n_cst_import_contract lnv_import_contract
n_cst_import_faci       lnv_import_faci
str_flag  lstr_audit   //add by stephen 01.03.2013 --V12.3 Import Logging modifications

if MessageBox("Run Import", "Are you sure you want to run the selected import?", Question!, YesNo!) = 2 then Return
SetPointer(HourGlass!)

// Import data
if ii_curr_isoft_module = 1 then
	lnv_import_credapp = Create n_cst_import_credapp
	lnv_import_credapp.of_Execute(il_curr_import_id, true)
	//------------------- APPEON BEGIN -------------------
	//$<add> Stephen 01.02.2013
	//$<reason> V12.3 Import Logging modifications
	if lnv_import_credapp.ib_import_audit then
		lstr_audit.l_oriid = lnv_import_credapp.il_hdr_id
		lstr_audit.l_mapid = il_curr_import_id
		if isvalid(w_mdi) then
			opensheetwithparm(w_import_audit,  lstr_audit, w_mdi, 4, Original!)
		else
			openwithparm(w_import_audit,  lstr_audit)
		end if
	end if
	//------------------- APPEON END -------------------	
	Destroy lnv_import_credapp
//---------Begin Added by (Appeon)Stephen 12.23.2013 for V141 Email/Fax Applications to Payors--------
elseif ii_curr_isoft_module = 3 then
	lnv_import_faci = Create n_cst_import_faci
	lnv_import_faci.of_Execute(il_curr_import_id, true)
	Destroy lnv_import_faci
//---------End Added ------------------------------------------------------
else
	lnv_import_contract = Create n_cst_import_contract
	lnv_import_contract.of_Execute(il_curr_import_id, true)
	Destroy lnv_import_contract
end if

// Display log
il_page4_import_id = -1
tab_1.SelectTab(4)
ll_LastRow = tab_1.tabpage_log.dw_imp_proc.RowCount()
tab_1.tabpage_log.dw_imp_proc.ScrollToRow(ll_LastRow)

SetPointer(Arrow!)
end event

event pfc_cst_check_mapping();tab_1.tabpage_field_data.Event ue_CheckMapping()
end event

event pfc_cst_createimportfields();ib_PromptCreateImportField = false
of_CreateImportField()
ib_PromptCreateImportField = true
end event

event pfc_cst_auto_import();Open(w_auto_import)
end event

event pfc_cst_copymap();tab_1.tabpage_field_data.Event ue_copymap()
end event

event ue_run_only();of_run_only_set( )
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

public subroutine of_createimportfield ();long i, j
long ll_FieldCount
long ll_CurrentRow
long ll_InsertRow
long ll_ImportID
long ll_Null
string ls_imp_file
string ls_imp_format
string ls_odbc_name
string ls_odbc_login
string ls_odbc_password
string ls_import_sql
string ls_record_delimiter
string ls_field_delimiter
string ls_ImportFields[]
integer li_Return
DataWindow ldw_Field
DataWindow ldw_mapping
gs_variable_array lst_fields //maha 121807

// Save import records
ll_FieldCount = tab_1.tabpage_hdr.Event ue_save()
if ll_FieldCount = -1 then
	MessageBox("Error", is_hdr_errinfo, StopSign!)
	Return
end if

// Get import information
ll_CurrentRow = tab_1.tabpage_hdr.dw_imp_hdr.GetRow()
if ll_CurrentRow <= 0 then Return
if tab_1.tabpage_hdr.dw_imp_hdr.object.lock_file[ll_CurrentRow] = 1 then
	MessageBox("Prompt", "Create field function is disabled when the import is Locked.")
	Return
end if
ls_imp_file = tab_1.tabpage_hdr.dw_imp_hdr.object.imp_file[ll_CurrentRow]
ls_imp_format = tab_1.tabpage_hdr.dw_imp_hdr.object.imp_format[ll_CurrentRow]
ls_odbc_name = tab_1.tabpage_hdr.dw_imp_hdr.object.odbc_name[ll_CurrentRow]
ls_odbc_login = tab_1.tabpage_hdr.dw_imp_hdr.object.odbc_login[ll_CurrentRow]
ls_odbc_password = tab_1.tabpage_hdr.dw_imp_hdr.object.odbc_password[ll_CurrentRow]
ls_import_sql = tab_1.tabpage_hdr.dw_imp_hdr.object.import_sql[ll_CurrentRow]
ls_record_delimiter = tab_1.tabpage_hdr.dw_imp_hdr.object.record_delimiter[ll_CurrentRow]
ls_field_delimiter = tab_1.tabpage_hdr.dw_imp_hdr.object.field_delimiter[ll_CurrentRow]

if IsNull(ls_imp_format) then ls_imp_format = ""
if IsNull(ls_odbc_name) then ls_odbc_name = ""
if IsNull(ls_odbc_login) then ls_odbc_login = ""
if IsNull(ls_odbc_password) then ls_odbc_password = ""
if IsNull(ls_import_sql) then ls_import_sql = ""
if IsNull(ls_record_delimiter) then ls_record_delimiter = ""
if IsNull(ls_field_delimiter) then ls_field_delimiter = ""

// Get import field list
choose case ls_imp_format
	case "1" //Tab Delimited
		ll_FieldCount = of_GetFieldFromTxt(ls_imp_file, ls_ImportFields)
	case "2" //CSV
		ll_FieldCount = of_GetFieldFromCSV(ls_imp_file, ls_ImportFields)
	case "3" //ODBC		
		ll_FieldCount = of_GetFieldFromODBC(ls_imp_file, ls_odbc_name, ls_odbc_login, ls_odbc_password, ls_import_sql, ls_ImportFields)
	case "4"	//Formatted text	
		ll_FieldCount = of_GetFieldFromFormatTxt(ls_imp_file, ls_record_delimiter, ls_field_delimiter, ls_ImportFields)
end choose
if ll_FieldCount = -1 then Return

//Start Code Change ----12.18.2007 #V8 maha
//changed code to open w_database_field_verify which will allow the user to modify and verify field names
//if of_CheckImportFieldName(ll_FieldCount, ls_ImportFields[]) = -1 then Return
lst_fields.as_string[] = ls_ImportFields[]
openwithparm(w_database_field_verify,lst_fields) //pass the field list
if message.doubleparm = -1 then return
lst_fields = message.powerobjectparm
 ls_ImportFields[] = lst_fields.as_string[] //set the modified field list
//End Code Change---12.18.2007

// Select field setup page
ldw_Field = tab_1.tabpage_field_data.dw_imp_field_detail
ldw_Field.AcceptText()
ll_ImportID = tab_1.tabpage_hdr.dw_browse.object.import_id[ll_CurrentRow]
tab_1.tabpage_hdr.dw_browse.Event RowFocusChanged(ll_CurrentRow)
if tab_1.SelectedTab <> 2 then tab_1.SelectTab(2)

// Delete import fields
if ldw_Field.RowCount() > 0 then
	ldw_Field.SetSort("field_order A")
	ldw_Field.Sort()
	li_Return = MessageBox("Prompt", "Import fields have already been defined. Do you want to replace them?", Question!, YesNoCancel!)
	if li_Return = 1 then
		// Delete corresponding import ID in mapping relationship
		SetNull(ll_Null)
		for i = 1 to tab_1.tabpage_field_data.dw_records.RowCount()
			tab_1.tabpage_field_data.dw_records.ScrollToRow(i)
			ldw_mapping = tab_1.tabpage_field_data.dw_map_fields
			for j = 1 to ldw_mapping.RowCount()
				ldw_mapping.object.import_field_id[j] = ll_Null
			next	
			ldw_mapping = tab_1.tabpage_field_data.dw_prac_cont_id
			for j = 1 to ldw_mapping.RowCount()
				ldw_mapping.object.import_field_id[j] = ll_Null
			next
		next
		// Delete import fields
		ldw_Field.RowsMove(1, ldw_Field.RowCount(), Primary!, ldw_Field, 1, Delete!)		
	elseif li_Return = 3 then
		Return
	end if
end if

// Insert import field into dw_field_list
for i = 1 to ll_FieldCount
	ll_InsertRow = ldw_Field.InsertRow(0)
	ldw_Field.object.import_id[ll_InsertRow] = ll_ImportID
	if ll_InsertRow = 1 then
		ldw_Field.object.field_order[ll_InsertRow] = 10
	else
		ldw_Field.object.field_order[ll_InsertRow] = ldw_Field.object.field_order[ll_InsertRow - 1] + 10
	end if
	ldw_Field.object.imp_field_name[ll_InsertRow] = ls_ImportFields[i]	
	ldw_Field.object.field_length[ll_InsertRow] = 100		
next
ldw_Field.ScrollToRow(1)
ldw_Field.SetColumn("imp_field_name")
ldw_Field.SetFocus()

// Save data
Event pfc_save()
end subroutine

public function integer of_getfieldfromtxt (string as_file, ref string as_fields[]);integer li_FileNum
integer i, li_Pos
string ls_HeaderRow

// Check import file name if null
if IsNull(as_File) or LenA(as_File) <= 0 then
	MessageBox("Create import Fields", "Failed to get import field. Import file name can not be null.")
	Return -1
end if
if not FileExists(as_File) then
	MessageBox("Create import Fields", "Failed to find import file ," + as_file + ".")
	Return -1
end if

// Open file
li_FileNum = FileOpen(as_File, LineMode!, Read!, Shared!)
if li_FileNum = -1 then
	MessageBox("Create import Fields", "Failed to get import file ," + as_file + ". The import file cannot be opened.")
	Return -1
end if
FileRead(li_FileNum, ls_HeaderRow)
FileClose(li_FileNum)

// Get import field name
do
	li_Pos = PosA(ls_HeaderRow, "~t")
	if li_Pos > 0 then		
		i ++
		as_Fields[i] = Trim(LeftA(ls_HeaderRow, li_Pos - 1))
		ls_HeaderRow = RightA(ls_HeaderRow, LenA(ls_HeaderRow) - li_Pos)
	else
		Exit
	end if
loop while true
if LenA(ls_HeaderRow) > 0 then
	i ++
	as_Fields[i] = Trim(ls_HeaderRow)
end if
if i = 0 then
	MessageBox("Prompt", "Failed to get import field. Please check content of import file.")
	Return -1
end if

// Return count of import field
Return UpperBound(as_Fields)
end function

public function integer of_getfieldfromcsv (string as_file, ref string as_fields[]);integer li_FileNum
integer i, li_Pos
string ls_HeaderRow

// Check import file name if null
if IsNull(as_File) or LenA(as_File) <= 0 then
	MessageBox("Prompt", "Failed to get import field. Import file name can not be null.")
	Return -1
end if
if not FileExists(as_File) then
	MessageBox("Prompt", "Failed to get import field. Import file (" + as_file + ") does not exists.") //Start Code Change ----02.07.2008 #V8 maha - modified message
	Return -1
end if

// Open file
li_FileNum = FileOpen(as_File, LineMode!, Read!, Shared!)
if li_FileNum = -1 then	
	MessageBox("Prompt", "Failed to get import field. Unable to open the  import file (" + as_file + ").") //Start Code Change ----02.07.2008 #V8 maha - modified message
	Return -1
end if
FileRead (li_FileNum, ls_HeaderRow)
FileClose(li_FileNum)

// Get import field name
do
	li_Pos = PosA(ls_HeaderRow, ",")
	if li_Pos > 0 then		
		i ++
		as_Fields[i] = Trim(LeftA(ls_HeaderRow, li_Pos - 1))
		ls_HeaderRow = RightA(ls_HeaderRow, LenA(ls_HeaderRow) - li_Pos)		
	else
		Exit
	end if
loop while true
if LenA(ls_HeaderRow) > 0 then
	i ++
	as_Fields[i] = Trim(ls_HeaderRow)
end if
if i = 0 then
	MessageBox("Prompt", "Failed to get import field. Please check content of import file.")
	Return -1
end if

// Return count of import field
Return UpperBound(as_Fields)
end function

public function integer of_getfieldfromformattxt (string as_file, string as_record_delimiter, string as_field_delimiter, ref string as_fields[]);integer i, li_Pos
integer li_DelimiterLen
string  ls_HeaderRow
string  ls_Data
blob    lblb_Data
long ll_len
integer li_test

// Check import file name if null
if IsNull(as_File) or LenA(as_File) <= 0 then
	MessageBox("Create Fields Error", "Failed to get import field. Import file name can not be null.")
	Return -1
end if
if not FileExists(as_File) then
	MessageBox("Create Fields Error", "Failed to get import field. Import file does not exist.")
	Return -1
end if

// Get header row content
//------------------- APPEON BEGIN -------------------
//$<modify> Stephen 03.14.2013
//$<reason> Importing pipe-delimited file data
/*
lblb_Data = of_ReadFile(as_File)
ls_Data = String(lblb_Data)
*/
ls_Data = of_readfile_str(as_File)
//------------------- APPEON END -------------------

if Lower(as_record_delimiter) = "enter" then
	as_record_delimiter = "~r~n"
elseif Lower(as_record_delimiter) = "tab" then
	as_record_delimiter = "~t"
end if


if as_record_delimiter = "" then as_record_delimiter = "~r"  //Start Code Change ----12.17.2007 #V8 maha -- set default if no value selected
li_Pos = PosA(ls_Data, as_record_delimiter)
if li_Pos > 0 then
	ls_HeaderRow = LeftA(ls_Data, li_Pos - 1)
	//MessageBox("ls_HeaderRow ",ls_HeaderRow )
else
//maha test code 121707
//	for i = 1 to len(ls_data)
//		li_test  = asc(mid(ls_data,i,1))
//		if li_test = 13 then
//			messagebox("","found it")
//			messagebox("",char(13))
//			return -1
//		end if
//	next
		
	//Start Code Change ----12.17.2007 #V8 maha -- added trap for missing/invalid record delimiter
	MessageBox("Create Fields Error", "Failed to find record delimiter (" + as_record_delimiter + ") in file. Please check import setup data.")
	return -1
	//End Code Change---12.17.2007
	ls_HeaderRow = ls_Data
end if

if Lower(as_field_delimiter) = "enter" then
	as_field_delimiter = "~r~n"
elseif Lower(as_field_delimiter) = "tab" then
	as_field_delimiter = "~t"
end if
li_DelimiterLen = LenA(as_field_delimiter)

//Start Code Change ----12.17.2007 #V8 maha -- added trap for missing/invalid field delimiter
li_Pos = PosA(ls_HeaderRow, as_field_delimiter)
if li_Pos = 0 then 
	MessageBox("Create Fields Error", "Failed to find field delimiter (" + as_field_delimiter + ") in file. Please check import setup data.")
end if
//End Code Change---12.17.2007

// Get import field name
do
	li_Pos = PosA(ls_HeaderRow, as_field_delimiter)
	if li_Pos > 0 then		
		i ++
		as_Fields[i] = Trim(LeftA(ls_HeaderRow, li_Pos - 1))
		if as_Fields[i] = "" or IsNull(as_Fields[i]) then
			as_Fields[i] = "field" + String(i)
		end if
		ls_HeaderRow = RightA(ls_HeaderRow, LenA(ls_HeaderRow) - li_Pos - li_DelimiterLen + 1)
	else
		Exit
	end if
loop while true
if i = 0 then
	MessageBox("Create Fields Error", "Failed to get import field. Please check content of import file.")
	Return -1
end if

if LenA(ls_HeaderRow) > 0 then
	i ++
	as_Fields[i] = Trim(ls_HeaderRow)
	if as_Fields[i] = "" or IsNull(as_Fields[i]) then
		as_Fields[i] = "field" + String(i)
	end if
end if

// Return import field count
Return UpperBound(as_Fields)
end function

public function integer of_getfieldfromodbc (string as_file, string as_odbc_name, string as_odbc_login, string as_odbc_password, string as_import_sql, ref string as_fields[]);string ls_Error
string ls_Syntax
integer i, li_ColCount
DataStore lds_data
Transaction ltr_trans

// Check information if null
if IsNull(as_import_sql) or as_import_sql = "" then
	MessageBox("Prompt", "Failed to get import field. Import SQL can not be null.")
	Return -1
end if
if AppeonGetClientType() = "PB" then
	if IsNull(as_odbc_name) or as_odbc_name = "" then
		MessageBox("Prompt", "Failed to get import field. ODBC name can not be null.")
		Return -1
	end if
	if IsNull(as_odbc_login) or as_odbc_login = "" then
		MessageBox("Prompt", "Failed to get import field. ODBC login can not be null.")
		Return -1
	end if
else
	if IsNull(as_odbc_name) or as_odbc_name = "" then
		MessageBox("Prompt", "Failed to get import field. Cache name can not be null.")
		Return -1
	end if
end if

// Connect to DB
ltr_trans = Create Transaction
if gs_dbtype = "ASA" then
	ltr_trans.DBMS = "ODB-ASA"
else
	ltr_trans.DBMS = "ODB-MSS"
end if
ltr_trans.AutoCommit = False
//---------Begin Modified by (Appeon)Toney 06.18.2013 for V141 ISG-CLX--------
  /*
    ltr_trans.DBParm = "ConnectString='DSN=" + as_odbc_name + ";UID=" + as_odbc_login + ";PWD=" + as_odbc_password + "',CacheName='" + as_odbc_name + "',ConnectOption='SQL_DRIVER_CONNECT,SQL_DRIVER_NOPROMPT'"  
  */
ltr_trans.DBParm = "ConnectString='DSN=" + as_odbc_name + ";UID=" + as_odbc_login + ";PWD=" + as_odbc_password + "',CacheName='" + as_odbc_name + "',ConnectOption='SQL_DRIVER_CONNECT,SQL_DRIVER_NOPROMPT',DelimitIdentifier='Yes'" 
//---------End Modfiied ------------------------------------------------------------------
Connect using ltr_trans;
if ltr_trans.SQLCode <> 0 then
	Destroy ltr_trans
	MessageBox("Prompt", "Failed to get import fields. Unable to connect to the database vis ODBC " + as_odbc_name + " .  Check your settings.") //Start Code Change ----02.07.2008 #V8 maha - modified message
	Return -1
end if

// Dynamic create DW
ls_Syntax = ltr_trans.SyntaxFromSQL(as_import_sql, "", ls_Error)
if LenA(ls_Error) > 0 then
	Destroy ltr_trans
	MessageBox("Prompt", "Failed to get import field. Import SQL syntax is invalid. ~r~r" + ls_error)	 //Start Code Change ----02.07.2008 #V8 maha - modified message
	Return -1
end if
lds_data = Create DataStore
lds_data.Create(ls_Syntax, ls_Error)

// Get import field name
li_ColCount = Long(lds_data.object.datawindow.column.count)
for i =  1 to li_ColCount
	as_Fields[i] = lds_data.Describe("#" + String(i) + ".name")
next
Destroy ltr_trans
Destroy lds_data
if li_ColCount = 0 then
	MessageBox("Prompt", "Failed to get import field.")
	Return -1
end if

// Return count of import field
Return li_ColCount
end function

public function integer of_begindrag (datawindow adw_data);if KeyDown(KeyLeftButton!) and il_DragRow > 0 and not ib_LockFile then
	adw_data.Drag(Begin!)
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

public function integer of_checkimportfieldname (long al_fieldcount, string as_importfields[]);long i, j

for i = 1 to al_FieldCount
	for j = 1 to al_FieldCount
		if i <> j then
			if Trim(Lower(as_ImportFields[i])) = Trim(Lower(as_ImportFields[j])) then
				MessageBox("Prompt", "Import field name '" + as_ImportFields[i] + "' is a duplicated name.")  //Start Code Change ----02.07.2008 #V8 maha - modified message
				Return -1
			end if
		end if
	next
next

Return 1
end function

public function integer of_getimportfields (ref string as_fields[]);long   i, ll_FieldCount
long   ll_CurrentRow
string ls_imp_file
string ls_imp_format
string ls_odbc_name
string ls_odbc_login
string ls_odbc_password
string ls_import_sql
string ls_record_delimiter
string ls_field_delimiter

// Get import information
ll_CurrentRow = tab_1.tabpage_hdr.dw_imp_hdr.GetRow()
ls_imp_file = tab_1.tabpage_hdr.dw_imp_hdr.object.imp_file[ll_CurrentRow]
ls_imp_format = tab_1.tabpage_hdr.dw_imp_hdr.object.imp_format[ll_CurrentRow]
ls_odbc_name = tab_1.tabpage_hdr.dw_imp_hdr.object.odbc_name[ll_CurrentRow]
ls_odbc_login = tab_1.tabpage_hdr.dw_imp_hdr.object.odbc_login[ll_CurrentRow]
ls_odbc_password = tab_1.tabpage_hdr.dw_imp_hdr.object.odbc_password[ll_CurrentRow]
ls_import_sql = tab_1.tabpage_hdr.dw_imp_hdr.object.import_sql[ll_CurrentRow]
ls_record_delimiter = tab_1.tabpage_hdr.dw_imp_hdr.object.record_delimiter[ll_CurrentRow]
ls_field_delimiter = tab_1.tabpage_hdr.dw_imp_hdr.object.field_delimiter[ll_CurrentRow]

if IsNull(ls_imp_format) then ls_imp_format = ""
if IsNull(ls_odbc_name) then ls_odbc_name = ""
if IsNull(ls_odbc_login) then ls_odbc_login = ""
if IsNull(ls_odbc_password) then ls_odbc_password = ""
if IsNull(ls_import_sql) then ls_import_sql = ""
if IsNull(ls_record_delimiter) then ls_record_delimiter = ""
if IsNull(ls_field_delimiter) then ls_field_delimiter = ""

// Get import field list
choose case ls_imp_format
	case "1" //Tab Delimited
		ll_FieldCount = of_GetFieldFromTxt(ls_imp_file, as_Fields[])
	case "2" //CSV
		ll_FieldCount = of_GetFieldFromCSV(ls_imp_file, as_Fields[])
	case "3" //ODBC		
		ll_FieldCount = of_GetFieldFromODBC(ls_imp_file, ls_odbc_name, ls_odbc_login, ls_odbc_password, ls_import_sql, as_Fields[])
	case "4"	//Formatted text	
		ll_FieldCount = of_GetFieldFromFormatTxt(ls_imp_file, ls_record_delimiter, ls_field_delimiter, as_Fields[])
	case else
end choose

Return ll_FieldCount
end function

public function integer of_setmenu (integer ai_index);if not isvalid(m_pfe_cst_import_painter) then return 1  //Start Code Change ----07.22.2013 #V14 maha
if w_mdi.of_security_access( 6928 ) = 1 then return 1 //(Appeon)Stephen 08.11.2015 - Import/Export Security

if ai_Index <> 1 then
	// Default menu item
	m_pfe_cst_import_painter.m_edit.visible = false
	m_pfe_cst_import_painter.m_file.m_save.visible = false
	
	// Default button
	//---------Begin Modified by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
	/*
	m_pfe_cst_import_painter.m_edit.m_insert.toolbaritemvisible = false
	m_pfe_cst_import_painter.m_edit.m_delete1.toolbaritemvisible = false
	m_pfe_cst_import_painter.m_edit.m_copy.toolbaritemvisible = false
	
	m_pfe_cst_import_painter.m_file.m_save.toolbaritemvisible = false
	m_pfe_cst_import_painter.m_file.m_createimportfields.toolbaritemvisible = false
	*/
	gnv_app.of_modify_menu_attr( m_pfe_cst_import_painter.m_edit.m_insert,'toolbaritemvisible', false)
	gnv_app.of_modify_menu_attr( m_pfe_cst_import_painter.m_edit.m_delete1,'toolbaritemvisible', false)
	gnv_app.of_modify_menu_attr( m_pfe_cst_import_painter.m_edit.m_copy,'toolbaritemvisible', false)
	
	gnv_app.of_modify_menu_attr( m_pfe_cst_import_painter.m_file.m_save,'toolbaritemvisible', false)
	gnv_app.of_modify_menu_attr( m_pfe_cst_import_painter.m_file.m_createimportfields,'toolbaritemvisible', false)
	//---------End Modfiied ------------------------------------------------------
end if

//---------Begin Modified by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
/*
m_pfe_cst_import_painter.m_file.m_copymap.toolbaritemvisible = false
//m_pfe_cst_import_painter.m_file.m_editprojects.toolbaritemvisible = false
//m_pfe_cst_import_painter.m_file.m_lookupmapping.toolbaritemvisible = false
m_pfe_cst_import_painter.m_file.m_checkmapping.toolbaritemvisible = false
//m_pfe_cst_import_painter.m_file.m_runimport.toolbaritemvisible = false
*/
gnv_app.of_modify_menu_attr( m_pfe_cst_import_painter.m_file.m_copymap,'toolbaritemvisible', false)
gnv_app.of_modify_menu_attr( m_pfe_cst_import_painter.m_file.m_checkmapping,'toolbaritemvisible', false)
//---------End Modfiied ------------------------------------------------------
// Reset
choose case ai_Index
	case 1 //Imports
		m_pfe_cst_import_painter.m_edit.visible = true		
		m_pfe_cst_import_painter.m_file.m_save.visible = true		
		
		//---------Begin Modified by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
		/*
		m_pfe_cst_import_painter.m_edit.m_insert.toolbaritemvisible = true
		m_pfe_cst_import_painter.m_edit.m_delete1.toolbaritemvisible = true
		m_pfe_cst_import_painter.m_edit.m_copy.toolbaritemvisible = true
				
		m_pfe_cst_import_painter.m_file.m_save.toolbaritemvisible = true
		m_pfe_cst_import_painter.m_file.m_createimportfields.toolbaritemvisible = true
		*/
		gnv_app.of_modify_menu_attr( m_pfe_cst_import_painter.m_edit.m_insert,'toolbaritemvisible', true)
		gnv_app.of_modify_menu_attr( m_pfe_cst_import_painter.m_edit.m_delete1,'toolbaritemvisible', true)
		gnv_app.of_modify_menu_attr( m_pfe_cst_import_painter.m_edit.m_copy,'toolbaritemvisible', true)
				
		gnv_app.of_modify_menu_attr( m_pfe_cst_import_painter.m_file.m_save,'toolbaritemvisible', true)
		gnv_app.of_modify_menu_attr( m_pfe_cst_import_painter.m_file.m_createimportfields,'toolbaritemvisible', true)
		//---------End Modfiied ------------------------------------------------------
	case 2 //Field Setup
		m_pfe_cst_import_painter.m_file.m_save.visible = true
		//---------Begin Modified by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
		/*
		m_pfe_cst_import_painter.m_file.m_copymap.toolbaritemvisible = true		
		m_pfe_cst_import_painter.m_file.m_save.toolbaritemvisible = true
		m_pfe_cst_import_painter.m_file.m_checkmapping.toolbaritemvisible = true
		*/
		gnv_app.of_modify_menu_attr( m_pfe_cst_import_painter.m_file.m_copymap,'toolbaritemvisible', true)		
		gnv_app.of_modify_menu_attr( m_pfe_cst_import_painter.m_file.m_save,'toolbaritemvisible', true)
		gnv_app.of_modify_menu_attr( m_pfe_cst_import_painter.m_file.m_checkmapping,'toolbaritemvisible', true)
		//---------End Modfiied ------------------------------------------------------
		
	case 3 //Data
		
	case 4 //Error Logs
		
	case else
end choose

Return 1
end function

public function integer of_setmappeddwtitle (integer al_current);ii_CurrMappedDW = al_Current

if ii_CurrMappedDW = 1 then
	if ii_curr_isoft_module = 1 then
		//---------Begin Modified by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
		//tab_1.tabpage_field_data.dw_prac_cont_id.Title = ">>> Provider Identification Fields (must be mapped from Basic Information table) <<<"
		tab_1.tabpage_field_data.dw_prac_cont_id.Title = gs_left_title_sign +"Provider Identification Fields (must be mapped from Basic Information table)"+gs_right_title_sign
		//---------End Modfiied ------------------------------------------------------
	elseif ii_curr_isoft_module = 2 then //(Appeon)Stephen 12.23.2013 - V141 Import Modifications for Facility and Group
		//---------Begin Modified by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
		//tab_1.tabpage_field_data.dw_prac_cont_id.Title = ">>> Contract Identification Fields (must be mapped from Basic Information table) <<<"
		tab_1.tabpage_field_data.dw_prac_cont_id.Title = gs_left_title_sign+"Contract Identification Fields (must be mapped from Basic Information table)"+gs_right_title_sign
		//---------End Modfiied ------------------------------------------------------
	end if
	tab_1.tabpage_field_data.dw_map_fields.Title = "Mapped Record Fields"
else
	if ii_curr_isoft_module = 1 then
		tab_1.tabpage_field_data.dw_prac_cont_id.Title = "Provider Identification Fields (must be mapped from Basic Information table)"
	elseif ii_curr_isoft_module = 2 then //(Appeon)Stephen 12.23.2013 - V141 Import Modifications for Facility and Group
		tab_1.tabpage_field_data.dw_prac_cont_id.Title = "Contract Identification Fields (must be mapped from Basic Information table)"
	end if	
	//---------Begin Modified by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
	//tab_1.tabpage_field_data.dw_map_fields.Title = ">>> Mapped Record Fields <<<"
	tab_1.tabpage_field_data.dw_map_fields.Title = gs_left_title_sign+"Mapped Record Fields"+gs_right_title_sign
	//---------End Modfiied ------------------------------------------------------
end if

Return 1
end function

public function string of_replaceblank (string as_string, string as_new);integer li_NewPos
integer li_StartPos
integer li_BlankLen
string ls_Return

li_BlankLen = 1
li_StartPos = 1
as_String = Trim(as_String)
li_NewPos = PosA(as_String, " ")

do		
	if li_NewPos > 0 then
		ls_Return += MidA(as_String, li_StartPos, li_NewPos - li_StartPos) + as_New
		li_StartPos = li_NewPos + li_BlankLen
	else
		ls_Return += RightA(as_String, LenA(as_String) - li_StartPos + 1)
		Exit
	end if
	
	li_BlankLen = 1
	li_NewPos = PosA(as_String, " ", li_StartPos)	
	do
		if MidA(as_String, li_NewPos + li_BlankLen, 1) = " " then
			li_BlankLen ++
		else
			Exit
		end if
	loop while true
loop while true

Return ls_Return
end function

public function string of_getcontractfieldfilter (datawindow adw_tables);long ll_Row
string ls_Filter
string ls_NotInList
string ls_table_name

// Set common filter
ll_Row = adw_tables.GetRow()
ls_Filter = "table_id = " + String(adw_tables.object.table_id[ll_Row])
 
// Set particular filter
ls_table_name = Lower(adw_tables.object.table_name[ll_Row])
ls_NotInList = '' //(Appeon)Stephen 03.13.2015 - V15.1-Import Improvements 2015
choose case ls_table_name
	case "ctx_basic_info"
		//---------Begin Modified by (Appeon)Stephen 03.13.2015 for V15.1-Import Improvements 2015--------
		//ls_NotInList = "'ctx_id','record_id','version_number','version_date','master_contract_id'"
		ls_NotInList = "'record_id','version_number','version_date','master_contract_id'"
		//---------End Modfiied ------------------------------------------------------		
	case "ctx_products"
		//ls_NotInList = "'ctx_id','record_id'" //Commented by (Appeon)Stephen 03.13.2015 - V15.1-Import Improvements 2015
	case "ctx_contract_contacts"
		//---------Begin Modified by (Appeon)Stephen 03.13.2015 for V15.1-Import Improvements 2015--------
		//ls_NotInList = "'ctx_id','contact_id','record_id','id_forcatalog'"
		ls_NotInList = "'record_id','id_forcatalog'"
		//---------End Modfiied ------------------------------------------------------	
	case "ctx_fee_sched_nm"
		//---------Begin Modified by (Appeon)Stephen 03.13.2015 for V15.1-Import Improvements 2015--------
		//ls_NotInList = "'ctx_id','fee_sched_nm_id','record_id'"
		ls_NotInList = "'record_id'"
		//---------End Modfiied ------------------------------------------------------		
	case "ctx_contacts"
		//---------Begin Modified by (Appeon)Stephen 03.13.2015 for V15.1-Import Improvements 2015--------
		//ls_NotInList = "'contact_id','facility_id','record_id','user_d'"
		ls_NotInList = "'facility_id','record_id','user_d'"
		//---------End Modfiied ------------------------------------------------------		
	case "app_facility"
		//ls_NotInList = "'facility_id'" //Commented by (Appeon)Stephen 03.13.2015 - V15.1-Import Improvements 2015
	case "ctx_contacts_numbers"
		//---------Begin Modified by (Appeon)Stephen 03.13.2015 for V15.1-Import Improvements 2015--------
		//ls_NotInList = "'contact_id','record_id','contact_num_id'"
		ls_NotInList = "'record_id'"
		//---------End Modfiied ------------------------------------------------------		
	//---------Begin Added by (Appeon)Toney 06.18.2013 for V141 ISG-CLX--------
	case "ctx_custom"
		//ls_NotInList = "'ctx_id'"	 //Commented by (Appeon)Stephen 03.13.2015 - V15.1-Import Improvements 2015
	//---------End Added ------------------------------------------------------------------
	//---------Begin Added by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
	case 'ctx_custom_multi_hdr' //added by gavins 20130222
		//---------Begin Modified by (Appeon)Stephen 03.13.2015 for V15.1-Import Improvements 2015--------
		//ls_NotInList = "'ctx_id', 'hdr_id', 'id_forcatalog'"
		ls_NotInList = "'id_forcatalog'"
		//---------End Modfiied ------------------------------------------------------
		
	case 'ctx_custom_multi_detail' //added by gavins 20130222
		//---------Begin Modified by (Appeon)Stephen 03.13.2015 for V15.1-Import Improvements 2015--------
		//ls_NotInList = "'ctx_id', 'hdr_id','detail_id', 'id_forcatalog'"	
		ls_NotInList = "'id_forcatalog'"	
		//---------End Modfiied ------------------------------------------------------
		
	//---------End Added ------------------------------------------------------
	case else
		Return ""
end choose
if not(isnull(ls_NotInList) or len(trim(ls_NotInList)) < 1) then  //(Appeon)Stephen 04.22.2015 - V15.1-Import Improvements 2015
	ls_Filter = ls_Filter + " AND Lower(field_name) not in (" + ls_NotInList + ")"
end if

Return ls_Filter
end function

public function integer of_selectvalue (ref string as_value);string ls_Return

Open(w_import_selectcode)
ls_Return = LeftA(Message.StringParm, 3)
if ls_Return = "OK!" then
	as_Value = RightA(Message.StringParm, LenA(Message.StringParm) - 3)
	Return 1
end if

Return -1
end function

public function long of_getinsertrow (datawindow adw_table, long al_parent_table_id);long ll_FindRow
long ll_InsertRow
long ll_RowCount

ll_FindRow = 1
ll_RowCount = adw_table.RowCount()

do
	ll_FindRow = adw_table.Find("isoft_table_id=" + String(al_parent_table_id), ll_FindRow, ll_RowCount)
	if ll_FindRow > 0 then
		ll_InsertRow = ll_FindRow + 1
		ll_FindRow ++
		if ll_FindRow > ll_RowCount then Exit
	else
		Exit
	end if
loop until false
if ll_InsertRow = 0 then ll_InsertRow = 1

Return ll_InsertRow
end function

public function long of_getinsertrow (long al_table_id);long ll_InsertRow
datawindow ldw_table

ldw_table = tab_1.tabpage_field_data.dw_records

if ii_curr_isoft_module = 1 then
	choose case al_table_id					
		case 2002 //code_lookup (V10.1 - Lookup Table Import)
			ll_InsertRow = 1
		case 2001 //address_lookup
			ll_InsertRow = of_GetInsertRow(ldw_table, 2002)
		case 2003 //qa_metrics (V11.3 QA Import)
			ll_InsertRow = of_GetInsertRow(ldw_table, 2001)
			if ll_InsertRow = 1 then ll_InsertRow = of_GetInsertRow(ldw_table, 2002)
		case 25   //pd_basic (V11.3 QA Import)
			ll_InsertRow = of_GetInsertRow(ldw_table, 2003)
			if ll_InsertRow = 1 then ll_InsertRow = of_GetInsertRow(ldw_table, 2001)
			if ll_InsertRow = 1 then ll_InsertRow = of_GetInsertRow(ldw_table, 2002)
		case else
			ll_InsertRow = 0
	end choose
//---------Begin Added by (Appeon)Stephen 12.23.2013 for V141 Import Modifications for Facility and Group--------
elseif ii_curr_isoft_module = 3 then
	choose case al_table_id	
		case 3001
			ll_InsertRow = 1
		case 3002  //group
			ll_InsertRow = of_GetInsertRow(ldw_table, 3001)
		case else
			ll_InsertRow = 0
	end choose
//---------End Added ------------------------------------------------------
else
	choose case al_table_id
		case 1006 //app_facility
			ll_InsertRow = 1
		case 1003 //ctx_contacts
			ll_InsertRow = of_GetInsertRow(ldw_table, 1006)
		case 1001 //ctx_basic_info
			ll_InsertRow = of_GetInsertRow(ldw_table, 1003)
			if ll_InsertRow = 1 then ll_InsertRow = of_GetInsertRow(ldw_table, 1006)
		//---------Begin Modified by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
		Case 1009//ctx_custom_multi_detail  //added  by gavins 20130222
			ll_InsertRow = of_GetInsertRow(ldw_table, 1010)
			ll_insertRow = ll_insertrow - 1
		Case 1010//ctx_custom_multi_detail  //added  by gavins 20130222
			ll_InsertRow = of_GetInsertRow(ldw_table, 1009)
			if ll_InsertRow = 1 then ll_InsertRow = 0
		//---------End Modfiied ------------------------------------------------------
		case else
			ll_InsertRow = 0
	end choose
end if

Return ll_InsertRow
end function

public function integer of_preprocess_data (integer li_process, string as_file_from, string as_file_to);//Start Code Change ----06.27.2008 #V81 maha -function added for preprocessing a file before importing

CHOOSE CASE li_process
	case 1 //Indy PIC
		string sfile
		string ls_val
		string skipval
		string docpath, docname
		string ls_transdate
		integer ck
		string rtype
		string ls_trans_type //maha 073108
		integer skip = 0
		integer li_t_skip = 0 //maha 073108
		long r
		long rc
		long datarow = 0
		datastore ds_file
		datastore ds_data
		
		ds_file = create datastore
		ds_data = create datastore
		
		ds_file.dataobject = "d_indy_pre_process"
		ds_data.dataobject = "d_indy_pre_process"
		
		ds_file.settransobject(sqlca)
		ds_data.settransobject(sqlca)
		
//		if isnull(as_file_from) or as_file_from = "" then
//			GetFileOpenName("Select File",    docpath, docname,  "All Files (*.*), *.*",    gs_dir_path +"intellicred\", 18)
		
		if  not fileexists(as_file_from) then 
			messagebox("Preprocess file error","File does not exist: " + as_file_from )
			return -1
		end if
		
		sfile = as_file_from
		
		rc = ds_file.importfile(csv!,sfile)
		if  rc < 1  then 
			messagebox("Preprocess import error","Error importing file for preprocess: " + as_file_from  + " Error:" + string(rc))
			return -1
		end if
		//messagebox("",rc)
		
		ck = 0
		debugbreak()
		for r = 2 to rc  //skip lines 1 
			//on row 3 the value should be 2 then 3 then 2 then 3 ect.
			//rtype = integer(ds_file.getitemstring(r,1))
			rtype = ds_file.getitemstring(r,1)
			
			//if the transaction type is not purchase skip over all the records until you find that trans type
			if integer(rtype) > 1 and li_t_skip = 1 then continue //Start Code Change ----07.31.2008 #V85 maha - change to bypass some transactions
			
			choose case rtype
				case '1' //trans date
					if ck = 2 then //a 1 should not follow a 2
						messagebox("Process error","Check value failed at line " + string(r))
						return -1 
					end if
					//Start Code Change ----07.31.2008 #V85 maha - change to bypass some transactions
					ls_trans_type = ds_file.getitemstring(r,2)
					if ls_trans_type <> "PURCH" then
						li_t_skip = 1
						continue
					end if
					li_t_skip = 0 //Start Code Change ----10.06.2009 #V10 maha
					//End Code Change---07.31.2008
					ls_transdate = ds_file.getitemstring(r,3)
					ck = 1
				case '2'
					if ck = 2 then //a 2 should not follow a 2
						messagebox("Process error","Check value failed at line " + string(r))
						return -1 
					end if
					ck = 2
					ls_val = trim(ds_file.getitemstring(r,2))
					skipval = trim(MidA(ls_val, LenA(ls_val) - 4))
					
					if skipval = "2001" or skipval = "2999" then //skip this row and the next
						skip = 1
						continue
					else
						datarow = ds_data.insertrow(0)
						ds_data.setitem(datarow,1,ls_val)
					end if
				case '3'
					if ck <> 2 then //a 3 should always follow a 2
						messagebox("Process error","Check value failed at line " + string(r))
						return -1 
					end if
					ck = 3
					if skip = 1 then
						skip = 0
						continue
					end if
					
					ls_val = ds_file.getitemstring(r,2)
					ds_data.setitem(datarow,2,trim(ds_file.getitemstring(r,2)))
					ds_data.setitem(datarow,3,trim(ds_file.getitemstring(r,3)))
					ds_data.setitem(datarow,4,trim(ds_file.getitemstring(r,4)))
					ds_data.setitem(datarow,5,trim(ds_file.getitemstring(r,5)))
					ds_data.setitem(datarow,6,trim(ds_file.getitemstring(r,6)))
					ds_data.setitem(datarow,10,ls_transdate)
				case else
					messagebox("Unexpected data in file",rtype)
			end choose
					
					
					
//					
//			if ck = 3 then 
//				ck = 2
//			elseif ck = 2 then
//				ck = 3
//			end if
//			if ck <> integer(ds_file.getitemstring(r,1))  then
//				messagebox("Process error","Check value failed at line " + string(r))
//				return -1 
//			end if
//			//debugbreak()	
//			if ck = 2 then 
//				ls_val = trim(ds_file.getitemstring(r,2))
//				skipval = trim(mid(ls_val, len(ls_val) - 4))
//				if skipval = "2001" or skipval = "2999" then //skip this row and the next
//					r++
//					ck = 3
//					continue
//				else
//					datarow = ds_data.insertrow(0)
//					ds_data.setitem(datarow,1,ls_val)
//				end if
//			else //3
//				ls_val = ds_file.getitemstring(r,2)
//				ds_data.setitem(datarow,2,trim(ds_file.getitemstring(r,2)))
//				ds_data.setitem(datarow,3,trim(ds_file.getitemstring(r,3)))
//				ds_data.setitem(datarow,4,trim(ds_file.getitemstring(r,4)))
//				ds_data.setitem(datarow,5,trim(ds_file.getitemstring(r,5)))
//				ds_data.setitem(datarow,6,trim(ds_file.getitemstring(r,6)))
//			end if
		next		
		//---------Begin Added by (Appeon)Toney 06.18.2013 for V141 ISG-CLX--------
		gnv_rights.of_check_dir_right( as_file_to, true, 'Import Save')		
		//---------End Added ------------------------------------------------------------------

		ds_data.saveas( as_file_to , text!, true)
		
		destroy ds_data
		destroy ds_file
		
		
		
end choose

return 1
end function

public function string of_correcttablename (string as_name);integer i, li_Len
string  ls_Char
string  ls_TableName
string  ls_AlphaNumeric = "qwertyuiopasdfghjklzxcvbnm0123456789"

li_Len = LenA(as_Name)
for i = 1 to li_Len
	ls_Char = Lower(MidA(as_Name, i, 1))
	if ls_Char = " " then
		ls_TableName += "_"
	else
		if PosA(ls_AlphaNumeric, ls_Char) > 0 then
			ls_TableName += ls_Char
		end if
	end if
next
ls_TableName = "impt_" + ls_TableName

Return ls_TableName
end function

public function integer of_store_file (long al_process_id);//////////////////////////////////////////////////////////////////////
// $<function> of_store_file
// $<arguments>
//               long al_row
// $<returns> (integer)
// $<description> V12.3 Import Logging modifications
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Stephen 12.14.2012
//////////////////////////////////////////////////////////////////////

long   ll_import_id, ll_rec_id
string ls_import_name
datetime ldt_CurrentTime
string ls_file
blob lb_file
long ll_CurrentRow

ll_CurrentRow = tab_1.tabpage_hdr.dw_imp_hdr.GetRow()
if ll_CurrentRow <= 0 then Return -1

if ii_set73 <> 1 then
	delete from import_file_store where import_id = :il_curr_import_id using sqlca;
	if sqlca.sqlcode <> 0 then
		rollback using sqlca;
		return -1
	else
		commit using sqlca;
	end if
end if
	
gnv_appeondb.of_startqueue( )
SELECT getdate() INTO :ldt_CurrentTime FROM ids;
select max(rec_id) into :ll_rec_id from import_file_store using sqlca;
gnv_appeondb.of_commitqueue( )	

ll_import_id = tab_1.tabpage_hdr.dw_imp_hdr.object.import_id[ll_CurrentRow] 
ls_import_name = tab_1.tabpage_hdr.dw_imp_hdr.object.import_name[ll_CurrentRow] 
ls_file = tab_1.tabpage_hdr.dw_imp_hdr.object.imp_file[ll_CurrentRow] 
if isnull(ll_rec_id) then ll_rec_id = 0
ll_rec_id +=1

insert into import_file_store(rec_id, Import_id, Import_name, process_id, Create_date, Create_user)
     values(:ll_rec_id, :ll_import_id, :ls_import_name, :al_process_id, :ldt_CurrentTime, :gs_user_id) using sqlca;
if sqlca.sqlcode <> 0 then
	rollback using sqlca;
	return -1
else
	commit using sqlca;
end if

lb_file = of_readfile(ls_file)

updateblob import_file_store set Import_file = :lb_file where rec_id = :ll_rec_id using sqlca;
if sqlca.sqlcode <> 0 then
	rollback using sqlca;
else
	commit using sqlca;
end if
			
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

public subroutine of_copy_field_data (long al_ori_import_id, long al_new_import_id);//====================================================================
//$<Function>: of_copy_field_data
//$<Arguments>:
// 	value    long    al_ori_import_id
// 	value    long    al_new_import_id
//$<Return>:  (None)
//$<Description>: 
//$<Author>: (Appeon) Toney 06.18.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
//Add by jervis 12.18.2009
//Copy Field mapping data
string ls_CopySql

if al_ori_import_id <=0 or al_new_import_id <=0 then return 

//Copy Import_file_fields
ls_CopySql = 	"insert into Import_file_fields(import_id,field_order,imp_field_name,field_length,field_format,case_type,strip_type,comp_def,default_value) " + &
					"select " + string(al_new_import_id)+ ",field_order,imp_field_name,field_length,field_format,case_type,strip_type,comp_def,default_value " + &
					"from Import_file_fields where import_id = " + string(al_ori_import_id) + "; ~r~n "
EXECUTE IMMEDIATE :ls_CopySql;
//Copy Import_table_records
ls_CopySQl = 	"insert into Import_table_records(import_id,isoft_table_id,sort_no) " + &
					"select " + string(al_new_import_id)+ ",isoft_table_id,sort_no " + &
					"from Import_table_records where import_id = " + string(al_ori_import_id)+ "; ~r~n"
EXECUTE IMMEDIATE :ls_CopySql;
//Copy import_mapping_fields
ls_CopySql = 	"insert into import_mapping_fields(table_records_id,import_field_id,case_type,strip_type,field_format,isoft_field_id,key_field,id_field,null_type,null_value,link_value,facility_id,no_match_procd,lu_template,lu_type,lu_table,lu_field_name,sort_no) " + &
					"select t_new_Import_table_records.new_table_records_id,t_new_import_file_fields.new_rec_id,import_mapping_fields.case_type,import_mapping_fields.strip_type,import_mapping_fields.field_format,import_mapping_fields.isoft_field_id,import_mapping_fields.key_field,import_mapping_fields.id_field,import_mapping_fields.null_type,import_mapping_fields.null_value,import_mapping_fields.link_value,import_mapping_fields.facility_id,import_mapping_fields.no_match_procd,import_mapping_fields.lu_template,import_mapping_fields.lu_type,import_mapping_fields.lu_table,import_mapping_fields.lu_field_name,import_mapping_fields.sort_no " + &
					"from import_mapping_fields, " + &
							"(	select t_new.table_records_id new_table_records_id,t_old.* " + &
								"from Import_table_records t_old,Import_table_records t_new " + &
								"where t_old.import_id = " + string(al_ori_import_id) + " and t_new.import_id = " + string(al_new_import_id)+ " and t_old.isoft_table_id = t_new.isoft_table_id and t_old.sort_no = t_new.sort_no) t_new_Import_table_records," + &
							"(select t_new.rec_id new_rec_id,t_old.* " + &
								"from Import_file_fields t_old,Import_file_fields t_new " + &
								"where t_old.import_id = " + string(al_ori_import_id) + " and t_new.import_id = " + string(al_new_import_id)+ " and t_old.imp_field_name = t_new.imp_field_name and t_old.field_order = t_new.field_order) t_new_Import_file_fields " + &
					"where import_mapping_fields.table_records_id = t_new_Import_table_records.table_records_id and import_mapping_fields.import_field_id = t_new_import_file_fields.rec_id"

EXECUTE IMMEDIATE :ls_CopySql;
commit;
ib_IsCopy = false

//Refresh data
tab_1.tabpage_field_data.event ue_init( )


	
end subroutine

public function integer of_preprocess_import (long al_imp);//Start Code Change ----07.22.2013 #V14 maha - Created to allow the pre setting of ids before the actual import process.
//Start Code Change ----12.06.2013 #V14 maha - migrated to nv function call in n_cst_import
n_cst_import lnv_imp_fun
lnv_imp_fun = create n_cst_import

//---------Begin Modified by (Appeon)Stephen 12.26.2013 for V141 Import Modifications for Facility and Group--------
//lnv_imp_fun.of_preprocess_imp_data( il_curr_import_id ,tab_1.tabpage_data.dw_imp_data , tab_1.tabpage_data.dw_preprocess , "Painter" )
string ls_Syntax, ls_Error
n_import_ds lds_imp_data, lds_preprocess

lds_imp_data = create n_import_ds
lds_preprocess = create n_import_ds
ls_Syntax = tab_1.tabpage_data.dw_imp_data.object.datawindow.syntax
lds_imp_data.Create(ls_Syntax, ls_Error)
tab_1.tabpage_data.dw_imp_data.RowsCopy(1, tab_1.tabpage_data.dw_imp_data.RowCount(), Primary!, lds_imp_data, 1, Primary!)
lds_preprocess.dataobject =  tab_1.tabpage_data.dw_preprocess.dataobject
tab_1.tabpage_data.dw_preprocess.retrieve(il_curr_import_id)
tab_1.tabpage_data.dw_preprocess.RowsCopy(1,  tab_1.tabpage_data.dw_preprocess.RowCount(), Primary!, lds_preprocess, 1, Primary!)
 
lnv_imp_fun.of_preprocess_imp_data( il_curr_import_id ,lds_imp_data , lds_preprocess , "Painter" )

 //---------Begin Added by (Appeon)Stephen 03.20.2014 for Bug #3984: IntelliImport Pre-Process is not populating the data grid--------
tab_1.tabpage_data.dw_imp_data.setredraw(false)
tab_1.tabpage_data.dw_imp_data.reset()
lds_imp_data.rowscopy(1, lds_imp_data.rowcount(), primary!, tab_1.tabpage_data.dw_imp_data, 1, primary!)
tab_1.tabpage_data.dw_imp_data.setredraw(true)
//---------End Added ------------------------------------------------------
//---------End Modfiied ------------------------------------------------------


destroy lnv_imp_fun
destroy lds_imp_data
destroy lds_preprocess
return 1

//boolean lb_last
//boolean lb_where1
//boolean lb_where2
//boolean lb_where3
//boolean lb_use_prac
//integer p
//integer pc
//integer li_loops
//integer li_cur_loop
//integer w
//integer res
//integer li_pos
//long r
//long rc
//long d
//long dc
//long ll_cur_r = 1
//long ll_cur_rc
//long ll_rec
//long ll_id
//long ll_find
//long test1
//long ll_mcnt
//long ll_ucnt
//string ls_isg_1
//string ls_isg_2
//string ls_isg_3
//string ls_imp_1
//string ls_imp_2
//string ls_imp_3
//string ls_set_field
//string ls_get_field
//string ls_prac_field
//string ls_get_1
//string ls_get_2
//string ls_get_3
//string ls_get_1a[]
//string ls_get_2a[]
//string ls_get_3a[]
//string ls_get_prac
//string ls_get_prac_a[]
//string ls_temp_1
//string ls_temp_2
//string ls_temp_3
//string ls_table
//string ls_sql
//string ls_sql_loop
//string ls_where1
//string ls_where2
//string ls_where3
//string ls_where_prac
//string ls_find
//string ls_presentation_str
//string ls_dwsyntax_str
//string ERRORS
//string ls_desc
//string ls_filter
//u_dw ldw_import
//u_dw dw_preprocess
//n_ds lds_ids
//
//dw_preprocess = tab_1.tabpage_data.dw_preprocess
//
//ldw_import = tab_1.tabpage_data.dw_imp_data
//rc = ldw_import.rowcount()
//
////ls_desc = ldw_import.describe("Datawindow")
////openwithparm(w_SQL_msg,ls_desc)
//
//if rc < 1 then
//	messagebox("Preprocess Data","There are no Imported data records.  Please Get Import Data")
//	return -1
//end if
//
//li_loops = integer(rc/100 ) + 1
//
//dw_preprocess.settransobject(sqlca)
//pc =dw_preprocess.retrieve(al_imp)
//
//if pc < 1 then return -1
//
//if not isvalid(w_preprocess_message) then open (w_preprocess_message)
//of_preprocess_msg( "Total", string (rc))
//
//FOR p = 1 to pc  //each process function
//	of_preprocess_msg( "Process", string (p))
//	of_preprocess_msg( "Processes", string (pc))
//	lb_where1 = false
//	lb_where2 = false
//	lb_where3 = false
//	ls_where1 = ""
//	ls_where2 = ""
//	ls_where3 = ""
//	ls_where_prac = ""
//	ls_sql = ""
//	ll_cur_r = 1
//	if rc > 100 then
//		ll_cur_rc = 100
//	else
//		ll_cur_rc = rc
//	end if
//	
//	ls_isg_1 =trim(dw_preprocess.getitemstring(p,"isg_field1"))
//	if isnull(ls_isg_1) then ls_isg_1 = ""
//	ls_isg_2 =trim(dw_preprocess.getitemstring(p,"isg_field2"))
//	if isnull(ls_isg_2) then ls_isg_2 = ""
//	ls_isg_3 =trim(dw_preprocess.getitemstring(p,"isg_field3"))
//	if isnull(ls_isg_2) then ls_isg_2 = ""
//	ls_imp_1 = trim(dw_preprocess.getitemstring(p,"imp_field1"))
//	if isnull(ls_imp_1) then ls_imp_1 = ""
//	ls_imp_2 = trim(dw_preprocess.getitemstring(p,"imp_field2"))
//	if isnull(ls_imp_2) then ls_imp_2 = ""
//	ls_imp_3 = trim(dw_preprocess.getitemstring(p,"imp_field3"))
//	if isnull(ls_imp_3) then ls_imp_3 = ""
//	ls_set_field = trim(dw_preprocess.getitemstring(p,"result_field"))
//	ls_get_field = trim(dw_preprocess.getitemstring(p,"get_field"))
//	ls_prac_field = trim(dw_preprocess.getitemstring(p,"prac_field"))
//	ls_table = trim(dw_preprocess.getitemstring(p,"isg_table"))
//	
//	ls_filter = trim(dw_preprocess.getitemstring(p,"filter_syntax"))
//
//	
//	if isnull(ls_set_field) or ls_set_field = "" then
//		messagebox("Preprocess Data","The Set Field value is not defined.  Please check preprocess setup.")
//		return -1
//	end if
//	
//	if isnull(ls_get_field) or ls_get_field = "" then
//		messagebox("Preprocess Data","The Get Field value is not defined.  Please check preprocess setup.")
//		return -1
//	end if
//debugbreak()	
//	//use the prac field
//	if isnull(ls_prac_field) or ls_prac_field = "" then
//		lb_use_prac = false
//	elseif ls_prac_field = ls_set_field then
//		lb_use_prac = false
//	else
//		lb_use_prac = true
//	end if
//	
//
//	ls_sql = "Select " + ls_get_field + " "
//	if lb_use_prac then ls_sql+= ", prac_id "  //Start Code Change ----10.24.2013 #V14 maha
//	
//	if len(ls_isg_1) > 0 and len(ls_imp_1) > 0 then lb_where1 = true
//	if len(ls_isg_2) > 0 and len(ls_imp_2) > 0 then lb_where2 = true
//	if len(ls_isg_3) > 0 and len(ls_imp_3) > 0 then lb_where3 = true
//	
//	//add appropriate isg fields
//	if lb_where1 then ls_sql = ls_sql + " , " + ls_isg_1
//	if lb_where2 then ls_sql = ls_sql + " , " + ls_isg_2
//	if lb_where3 then ls_sql = ls_sql + " , " + ls_isg_3
//	
//	ls_sql = ls_sql + " From " + ls_table  + " Where "
//	
//	ls_where1 = ls_isg_1 + " in ("
//	ls_where2 = " and " + ls_isg_2 +  " in ("
//	ls_where3 = " and " + ls_isg_3 +  " in ("
//	ls_where_prac = " and prac_id in ("	
//	
//	
////@@@@@@@@@@@@@@@@@@@@@@
//	//for each group of 100
//	for li_cur_loop = 1 to li_loops  //each of multiple loops
//		ls_sql_loop = ls_sql
//		//reset for each loop
//		if li_cur_loop > 1 then
//			ll_cur_r = ll_cur_rc + 1
//		end if
//		if ll_cur_r > rc then continue
//		ll_cur_rc = ll_cur_rc + 100
//		if ll_cur_rc > rc then ll_cur_rc = rc
////		ll_cur_r = r + 1
//		//get where values
//		ls_where1 = ls_isg_1 + " in ("
//		ls_where2 = " and " + ls_isg_2 +  " in ("
//		ls_where3 = " and " + ls_isg_3 +  " in ("
//		ls_where_prac = " and prac_id in ("
//		
////@@@@@@@@@@@@@@@@@@@@@@
////
//		for r =  ll_cur_r to ll_cur_rc  //each records in import
//
//			if lb_use_prac then //if using the prac id field get value; if blank skip record 
//				ls_get_prac =  ldw_import.getitemstring(r,ls_prac_field)
//				if isnull(ls_get_prac) then ls_get_prac = ""
//				
//				ls_get_prac_a[r] = ls_get_prac
//				if ls_get_prac = '' then 
//					ls_get_1a[r] = ""
//					ls_get_2a[r] = ""
//					ls_get_3a[r] = ""
//					continue
//				end if
//			end if
//			//messagebox(string(r), ls_imp_1)
//			if lb_where1 then		
//				ls_get_1 = ldw_import.getitemstring(r,ls_imp_1)
//			//	ls_get_1 = ldw_import.getitemstring(r, 38)
//				if isnull(ls_get_1) then ls_get_1 = ""
//				if pos(ls_get_1,"'",1) > 0 then ls_get_1 = of_strip_char("'", ls_get_1, "''")  //Start Code Change ----08.22.2013 #V14 maha - replace ' with ''
//				ls_get_1a[r] = ls_get_1
//			end if
//			if lb_where2 then
//				ls_get_2 = ldw_import.getitemstring(r,ls_imp_2)
//				if isnull(ls_get_2) then ls_get_2 = ""
//					if pos(ls_get_2,"'",1) > 0 then ls_get_2 = of_strip_char("'", ls_get_2, "''")  //Start Code Change ----08.22.2013 #V14 maha - replace ' with ''
//				ls_get_2a[r] = ls_get_2
//			end if
//			if lb_where3 then
//				ls_get_3 = ldw_import.getitemstring(r,ls_imp_3)
//				if isnull(ls_get_3) then ls_get_3 = ""
//					if pos(ls_get_3,"'",1) > 0 then ls_get_3 = of_strip_char("'", ls_get_3, "''")  //Start Code Change ----08.22.2013 #V14 maha - replace ' with ''
//				ls_get_3a[r] = ls_get_3
//			end if
//			
//			//get prac portion
//			if lb_use_prac  and len(ls_get_prac) > 0 then
//				ls_where_prac = ls_where_prac + "" +  ls_get_prac + ","
//			end if
//			//get 
//			if lb_where1 and len(ls_get_1) > 0 then
//				if  ls_get_1a[r] = "" then 
//					continue
//				else
//					ls_where1 = ls_where1 + "'" +  ls_get_1a[r] + "',"
//				end if
//			end if
//			
//			if lb_where2 and len(ls_get_2) > 0 then
//				if  ls_get_2a[r] = "" then 
//					continue
//				else
//					ls_where2 = ls_where2 + "'" +  ls_get_2a[r] + "',"
//				end if
//			end if
//			
//			if lb_where3 and len(ls_get_3) > 0 then
//				if  ls_get_3a[r] = "" then 
//					continue
//				else
//					ls_where3 = ls_where3 + "'" +  ls_get_3a[r] + "',"
//				end if
//			end if
//			
//		next
//	
//		//if ls_sql_loop
//		ls_where_prac = leftA(ls_where_prac, len(ls_where_prac) - 1) + ") "	
//		ls_where1 = leftA(ls_where1, len(ls_where1) - 1) + ") "
//		ls_where2 = leftA(ls_where2, len(ls_where2) - 1) + ") "
//		ls_where3 = leftA(ls_where3, len(ls_where3) - 1) + ") "		
//		
//		
//		if lb_where1 then ls_sql_loop+= ls_where1
//		if lb_where2 then
//			if righta(ls_sql, 6 ) <> "Where "  then  ls_sql+= " and "
//			ls_sql_loop+= ls_where2
//		end if
//		if lb_where3 then
//			if righta(ls_sql, 6 ) <> "Where "  then  ls_sql+= " and "
//			ls_sql_loop+= ls_where3
//		end if
//		
//		if lb_use_prac then
//			if righta(ls_sql, 6 ) <> "Where "  then  ls_sql+= " and "
//			ls_sql_loop+= ls_where_prac
//		end if
////Start Code Change ----09.20.2013 #V14 maha		
//		if len(ls_filter) > 3 then
//			li_pos = pos (ls_filter, "and " ,1) 
//			if li_pos > 0 and li_pos < 6 then
//				ls_filter =  " " + ls_filter //add space before and
//			else  //ann and	
//				ls_filter =  " and " + ls_filter
//			end if
//		end if
//			
//			
//	
//		ls_sql_loop = ls_sql_loop + ";"
//		//openwithparm(w_sql_msg,ls_sql)
//		
//		//continue
//
//		ls_presentation_str = "style(type=grid)"		
//debugbreak()	
//		ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql_loop, ls_presentation_str, ERRORS)
//		IF Len(ERRORS) > 0 THEN
//			MessageBox("Caution on import data syntax " + ls_sql_loop, &
//			"SyntaxFromSQL caused these errors: " + ERRORS + "~r~r" + ls_sql_loop)
//		//	MessageBox("ls_select_table",ls_select_table)
//			openwithparm(w_sql_msg,ls_sql_loop)
//			RETURN -1
//		END IF
//		lds_ids = CREATE n_ds
//		w = lds_ids.Create( ls_dwsyntax_str, ERRORS)
//		if w < 1 then
//			
//			messagebox("error on create",errors)
//		end if
//		
//		
//		lds_ids.settransobject(sqlca)
//		dc = lds_ids.retrieve()
//		dc = lds_ids.rowcount()
//		if dc = 0 then 
//			messagebox("Retrieval"," No records found for process " + string(p) )
//			return 0
//		end if
//
//	
////debugbreak()			
////@@ find @@@@@@@@@@@@@@@@@@@@@@@
////having gotten the data loop through and filter for specific row values
//		test1 = upperbound( ls_get_2a[])
//		for  r =  ll_cur_r to ll_cur_rc
//			//create the find
//			//if using the prac field, use in filter otherwise skip
//			ls_find = ""
//			if lb_use_prac then
//				if len(ls_get_prac_a[r] ) > 0 then
//					ls_find = "prac_id = " +  ls_get_prac_a[r] + " and "  //Start Code Change ----10.24.2013 #V14 maha
//					//ls_find = ls_prac_field + " = " +  ls_get_prac_a[r] + " and "
//				else
//					ll_ucnt++
//					continue
//				end if
//			end if
//				
//			if lb_where1 then
//			//	ls_find = ls_isg_1 + " = '" + ls_get_1a[r] + "' "  //Start Code Change ----10.24.2013 #V14 maha
//				ls_find = ls_find +  ls_isg_1 + " = '" + ls_get_1a[r] + "' "  //Start Code Change ----10.24.2013 #V14 maha
//				
//			end if
// 			if lb_where2 then
//				ls_find =  ls_find + " and "  + ls_isg_2 + " = '" + ls_get_2a[r] + "' "
//			end if
//			if lb_where3 then
//				ls_find =  ls_find + " and " + ls_isg_3 + " = '" + ls_get_3a[r] + "' "
//			end if
//			//find
////			if r < 5 then
////				openwithparm(w_sql_msg,ls_find)
////			end if
//			ll_find = lds_ids.find( ls_find, 1, dc)
//			
//			if 	ll_find < 0 then 
//				messagebox("Preprocess", "Error with find syntax~r~r" + ls_find)
//				exit
//			elseif ll_find = 0 then 
//				ll_ucnt++
//				continue
//			else
//				ll_mcnt++
//			end if
//
//			//messagebox("found",ll_find)
//			ll_rec = lds_ids.getitemnumber(ll_find, ls_get_field )
//			res = ldw_import.setitem(r, ls_set_field, string(ll_rec ))
//			
//		next //import record
//			
//		of_preprocess_msg( "Completed", string (ll_cur_rc))
//		of_preprocess_msg( "Matched", string (ll_mcnt))
//		of_preprocess_msg( "Unmatched", string (ll_ucnt))
//		
//		
//	next //group of 500
//	ll_mcnt = 0
//	ll_ucnt = 0
//	li_cur_loop++
//	
//NEXT //process
//
//destroy lds_ids
//
////if isvalid(w_preprocess_message) then close(w_preprocess_message)
//
//
//return 1
end function

public function integer of_preprocess_msg (string as_type, string as_msg);//if isvalid(w_preprocess_message) then w_preprocess_message.of_set_val(as_type,as_msg)
//
return 1
end function

public function integer of_verify_field_name (u_dw adw_1, string as_field);//====================================================================
//$<Function>: of_verify_field_name
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 03.03.2014 (add a check when an added field )
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
integer li_row
string ls_field_name
string ls_mess1
dwitemstatus lds_status

if adw_1.rowcount() < 1 then return 1
for li_row = 1 to adw_1.rowcount()
	lds_status = adw_1.getitemstatus(li_row, 0, primary!)
	if lds_status <> notmodified! then
		ls_field_name = adw_1.getitemstring(li_row, as_field)
		if LenA(ls_field_name) < 3 or LenA(ls_field_name) > 40 then
			adw_1.scrolltorow(li_row)
			messagebox("Prompt", "Field ( " + ls_field_name + " )  has an invalid length.  Must be between 3 an 40 characters")
			return -1
		end if
		ls_mess1 = of_strip_char ("",ls_field_name,"@DBFIELD@") //trap errors only
		
		if ls_mess1 = "FAILS" then
			adw_1.scrolltorow(li_row)
			messagebox("Prompt", "Field ( " + ls_field_name + " )  is an invalid field name.  It must contain only letters, numbers or underscores, and cannot start with a number.")
			return -1
		elseif ls_mess1 = "" then
			adw_1.scrolltorow(li_row)
			messagebox("Prompt", "Field ( " + ls_field_name + " )  came back blank.")
			return -1		
		end if
		
		//Start Code Change ----08.14.2013 #V14 maha - test for key words
		choose case lower(ls_field_name)
			case 'select', 'from', 'to', 'where', 'group', 'having', 'by', 'create', 'drop',  'table', 'field', 'key', 'primary', 'first', 'before', 'current_date', 'procedure','begin', 'end'
				adw_1.scrolltorow(li_row)
				messagebox("Prompt", "Field ( " + ls_field_name + " )  is a protected database word.  ")
				return -1
			case else
				//ok
		end choose
	end if
next

return 1
end function

public function integer of_isg_key (integer ai_table_id, long al_field_id);//====================================================================
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
string ls_field_name
long   ll_find

if not isvalid(ids_sysimp_fields) then
	ids_sysimp_fields = create datastore
	ids_sysimp_fields.dataobject = 'd_import_intellisoftfields'
	ids_sysimp_fields.settransobject(sqlca)
	ids_sysimp_fields.retrieve()
end if

ll_find = 	ids_sysimp_fields.find("table_id = "+string(ai_table_id) +" and field_id = "+ string(al_field_id), 1, ids_sysimp_fields.rowcount())
if ll_find < 1 then return 0
ls_field_name = ids_sysimp_fields.getitemstring(ll_find, "field_name")

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

ls_field_name = "'" + trim(ls_field_name) + "'"
if pos(ls_key, ls_field_name) > 0 then
	return 1
end if

return 0
end function

public function integer of_check_isgkey (datawindow adw_table_list, datawindow adw_isg_field, datawindow adw_field_list);//====================================================================
//$<Function>: of_check_isgkey
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 03.18.2015 (V15.1-Import Improvements 2015)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_row, ll_field_id, ll_table_id
long ll_record_id, ll_find
integer li_key, li_yes
string ls_field_alias
boolean lb_key
dwitemstatus lds_status
datastore lds_isg_fields

if adw_field_list.rowcount() < 1 then return 1
ll_record_id = adw_field_list.getitemnumber(1, "table_records_id")
ll_find = adw_table_list.find("table_records_id = " +string(ll_record_id), 1, adw_table_list.rowcount())
if ll_find > 0 then
	ll_table_id = adw_table_list.getitemnumber(ll_find, "isoft_table_id")
else
	return 1
end if

for ll_row = 1 to adw_field_list.rowcount()
	lds_status = adw_field_list.getitemstatus(ll_row, 0,primary!)
	if lds_status= newmodified! or lds_status = datamodified! then
		ll_field_id = adw_field_list.getitemnumber(ll_row, "isoft_field_id")
		if of_isg_key(ll_table_id, ll_field_id) = 1 then
			li_key = adw_field_list.getitemnumber(ll_row, "key_field")
			if li_key <> 1 then
				ls_field_alias = adw_field_list.describe("evaluate('lookupdisplay(isoft_field_id)'," + string(ll_row) +")")
				messagebox("Prompt", "The field '" + ls_field_alias + "' is an ISG key field. You must set it as a key field for import.")
				return -1
			end if
		end if
	end if
next

adw_isg_field.setfilter("table_id = " + string(ll_table_id))
adw_isg_field.filter()
lb_key = false
ls_field_alias = ''
li_yes = 0
for ll_row = 1 to adw_isg_field.rowcount()
	ll_field_id = adw_isg_field.getitemnumber(ll_row, "field_id")
	if of_isg_key(ll_table_id, ll_field_id) = 1 then
		ll_find = adw_field_list.find("isoft_field_id = " +string(ll_field_id), 1, adw_field_list.rowcount())
		if ll_find < 1 then
			ls_field_alias = ls_field_alias + ",'" + adw_isg_field.getitemstring(ll_row, "field_name_allias") +"'"
			lb_key = true
		else
			li_yes = li_yes + 1
		end if
	end if
next

if lb_key and li_yes > 0 then
	ls_field_alias = mid(ls_field_alias, 2)
	messagebox("Prompt", "Please select field '" + ls_field_alias + "' and set it as a key field.")
	return -1
end if

return 1



end function

public function integer of_security (integer ai_security);//====================================================================
//$<Function>: of_SECURITY
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 08.11.2015 (Import/Export Security)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
boolean lb_security

if ai_security = 1 then
	lb_security = true
else
	lb_security = false
end if

m_pfe_cst_import_painter.m_file.m_copymap.enabled = lb_security
m_pfe_cst_import_painter.m_file.m_editprojects.enabled = lb_security
m_pfe_cst_import_painter.m_file.m_lookupmapping.enabled = lb_security
m_pfe_cst_import_painter.m_file.m_checkmapping.enabled = lb_security
m_pfe_cst_import_painter.m_file.m_runimport.enabled = lb_security
m_pfe_cst_import_painter.m_file.m_save.enabled = lb_security	
m_pfe_cst_import_painter.m_file.m_createimportfields.enabled = lb_security	
m_pfe_cst_import_painter.m_file.m_autoimport.enabled = lb_security
m_pfe_cst_import_painter.m_file.m_runimport.enabled = lb_security
m_pfe_cst_import_painter.m_edit.m_insert.enabled = lb_security
m_pfe_cst_import_painter.m_edit.m_delete1.enabled = lb_security
m_pfe_cst_import_painter.m_edit.m_copy.enabled = lb_security
cb_pp_set.enabled = lb_security
tab_1.tabpage_hdr.dw_imp_hdr.enabled = lb_security	
tab_1.tabpage_hdr.dw_imp_sql.enabled = lb_security	
tab_1.tabpage_field_data.dw_tables.enabled = lb_security
tab_1.tabpage_field_data.dw_fields.enabled = lb_security
tab_1.tabpage_field_data.dw_records.enabled = lb_security
tab_1.tabpage_field_data.dw_map_fields.enabled = lb_security
tab_1.tabpage_field_data.dw_detail.enabled = lb_security
tab_1.tabpage_field_data.dw_field_list.enabled = lb_security
tab_1.tabpage_field_data.dw_imp_field_detail.enabled = lb_security
tab_1.tabpage_field_data.cb_com_wizard.enabled = lb_security
tab_1.tabpage_field_data.cb_create_value_list.visible = lb_security
tab_1.tabpage_data.cb_imp_data.enabled = lb_security
tab_1.tabpage_data.cb_pp_run.enabled = lb_security
tab_1.tabpage_data.cb_imp_pro.enabled = lb_security
tab_1.tabpage_data.cb_savedata.enabled = lb_security
tab_1.tabpage_data.cb_get_saved.enabled = lb_security
tab_1.tabpage_data.cb_sort.enabled = lb_security
tab_1.tabpage_data.cb_filter.enabled = lb_security
tab_1.tabpage_data.cbx_store_temp.enabled = lb_security

return 1
end function

public function integer of_run_only_set (); //Start Code Change ----08.21.2015 #V15 maha - added for run only access

tab_1.tabpage_hdr.dw_imp_hdr.enabled = false
tab_1.tabpage_hdr.dw_imp_hdr.Object.DataWindow.Color = 15987699
tab_1.tabpage_hdr.dw_imp_sql.Object.DataWindow.Color = 15987699
tab_1.tabpage_hdr.dw_imp_sql.enabled = false
tab_1.tabpage_field_data.visible = false
cb_pp_set.visible = false


// tab_1.tabpage_field_data.dw_map_fields.enabled = false
// tab_1.tabpage_field_data.dw_detail.enabled = false
// tab_1.tabpage_field_data.dw_tables.enabled = false
// tab_1.tabpage_field_data.dw_records.enabled = false
// tab_1.tabpage_field_data.dw_imp_field_detail.enabled = false
 //tab_1.tabpage_field_data.dw_map_fields.Object.DataWindow.Color = 15987699
// tab_1.tabpage_field_data.dw_detail.Object.DataWindow.Color = 15987699
 
 
 return 1
 
 
 
 
 
 
 
end function

public function integer of_presql_status (integer al_row);//$<Function>: of_presql_status
//$<Arguments>:al_row
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 10.17.2015 (Import Improvements 2015)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long     ll_imp_id
integer li_cnt

if al_row < 1 then return 1
ll_imp_id = tab_1.tabpage_hdr.dw_browse.getitemnumber(al_row, "import_id")
select count(1)
   into :li_cnt
  from Import_post_SQL
 where import_id = :ll_imp_id using sqlca;

if li_cnt > 0 then
	 tab_1.tabpage_hdr.dw_imp_hdr.modify("p_sql_post.filename='sectiongreen.bmp'")
else
	tab_1.tabpage_hdr.dw_imp_hdr.modify("p_sql_post.filename='section.bmp'")
end if
return 1
end function

on w_import_painter.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.cb_pp_set=create cb_pp_set
this.cb_report=create cb_report
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.cb_pp_set
this.Control[iCurrent+3]=this.cb_report
end on

on w_import_painter.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.cb_pp_set)
destroy(this.cb_report)
end on

event closequery;//override
boolean lb_Prompt = false

tab_1.tabpage_hdr.dw_imp_hdr.AcceptText()
tab_1.tabpage_hdr.dw_imp_sql.AcceptText()
if tab_1.tabpage_hdr.dw_browse.ModifiedCount() + tab_1.tabpage_hdr.dw_browse.DeletedCount() > 0 then
	lb_Prompt = true
end if

tab_1.tabpage_field_data.dw_imp_field_detail.AcceptText()
if tab_1.tabpage_field_data.dw_field_list.ModifiedCount() + tab_1.tabpage_field_data.dw_field_list.DeletedCount() > 0 then
	lb_Prompt = true
end if

tab_1.tabpage_field_data.dw_detail.AcceptText()
if tab_1.tabpage_field_data.dw_map_fields.ModifiedCount() + tab_1.tabpage_field_data.dw_map_fields.DeletedCount() > 0 then
	lb_Prompt = true
end if

if lb_Prompt then
	if MessageBox("Save data", "Close without saving changes?", Question!, YesNo!) = 2 then
		Return 1
	end if	
end if
end event

event close;call super::close;//inherit
w_mdi.ChangeMenu(m_pfe_cst_mdi_menu)
w_mdi.of_menu_security(w_mdi.MenuName)

if IsValid(ids_LookUpTableDDDW[1]) then Destroy ids_LookUpTableDDDW[1]
if IsValid(ids_LookUpTableDDDW[2]) then Destroy ids_LookUpTableDDDW[2]
if isvalid(ids_sysimp_fields) then destroy ids_sysimp_fields //(Appeon)Stephen 03.17.2015 - V15.1-Import Improvements 2015

//Close progress bar (evan 07.26.2011)
if IsValid(w_import_progressbar) then Close(w_import_progressbar)

end event

event pfc_preopen;call super::pfc_preopen;//inherit
this.Move(1, 1)
//this.Resize(4055,2100)

//Register controls
this.of_SetResize(True)
inv_resize.of_SetMinSize(This.WorkSpaceWidth(),This.WorkSpaceHeight())
inv_resize.of_SetOrigSize(This.WorkSpaceWidth(),This.WorkSpaceHeight())
inv_resize.of_Register(tab_1, "Scale")

//Resize tabpage_hdr
inv_resize.of_Register(tab_1.tabpage_hdr.dw_browse, 0, 0, 100, 100)
inv_resize.of_Register(tab_1.tabpage_hdr.dw_imp_hdr, 0, 100, 100, 0)
inv_resize.of_Register(tab_1.tabpage_hdr.dw_imp_sql, 0, 100, 100, 0)

/*
//Resize tabpage_field_data
inv_resize.of_Register(tab_1.tabpage_field_data.dw_fields, 0, 0, 0, 100)

inv_resize.of_Register(tab_1.tabpage_field_data.dw_field_list, 100, 0, 0, 100)
inv_resize.of_Register(tab_1.tabpage_field_data.dw_imp_field_detail, 100, 100, 0, 0)
inv_resize.of_Register(tab_1.tabpage_field_data.cb_com_wizard, 100, 100, 0, 0)
inv_resize.of_Register(tab_1.tabpage_field_data.cb_create_value_list, 100, 100, 0, 0)

inv_resize.of_Register(tab_1.tabpage_field_data.dw_records, 50, 0, 0, 0)
inv_resize.of_Register(tab_1.tabpage_field_data.dw_prac_cont_id, 50, 0, 0, 0)
inv_resize.of_Register(tab_1.tabpage_field_data.dw_map_fields, 50, 0, 0, 100)
inv_resize.of_Register(tab_1.tabpage_field_data.dw_detail, 50, 100, 0, 0)

//Resize tabpage_data
inv_resize.of_Register(tab_1.tabpage_data.dw_imp_data, 0, 0, 100, 100)

//Resize tabpage_log
inv_resize.of_Register(tab_1.tabpage_log.dw_log_master, 0, 0, 100, 100)
inv_resize.of_Register(tab_1.tabpage_log.dw_log_detail, 0, 100, 100, 100)
*/
end event

event activate;call super::activate;//Inherit
long ll_Handle

if w_mdi.menuname <> 'm_pfe_cst_import_painter' then
	//yield()    //(Appeon)Stephen 07.21.2014 - Clicking from another window into IntelliImport registers as a double-click
	ll_Handle = handle(w_mdi)
	w_mdi.ChangeMenu(m_pfe_cst_import_painter)
	w_mdi.SetToolbarPos(2, 1, 200, false)	
	w_mdi.of_menu_security(w_mdi.MenuName)
	gnv_appeondll.of_settoolbarpos(ll_Handle)
	yield()
	sleep(10)//(Appeon)Stephen 2013-07-22 - large import file issues
	of_SetMenu(tab_1.SelectedTab)
	
	//---------Begin Added by (Appeon)Stephen 08.11.2015 for Import/Export Security--------
	if w_mdi.of_security_access( 6928 ) = 1 then
		of_security(0)
	end if	
	//---------End Added ------------------------------------------------------
end if
end event

event pfc_save;//override
tab_1.tabpage_hdr.Event ue_save()
tab_1.tabpage_field_data.Event ue_save()

Return 1
end event

event resize;call super::resize;//inherit
tab_1.tabpage_field_data.Event ue_Resize()
tab_1.tabpage_data.Event ue_Resize()
tab_1.tabpage_log.Event ue_Resize()
end event

event open;call super::open;//Start Code Change ----07.03.2008 #V81 maha
integer i

//Start Code Change ----11.18.2013 #V14 maha - removed
//i = of_get_app_setting("set_54","I") 
//ii_preprocess = i  //Start Code Change ----07.31.2008 #V81 maha
//if  i > 0 then 
//	cb_preprocess.visible = true	
//else //Start Code Change ----09.18.2008 #V85 maha
//	cb_preprocess.visible = false
//end if
//End Code Changee ----11.18.2013

//BEGIN---Add by Evan 09/18/2008
if of_get_app_setting("set_9", "I") = 4 then ib_IsIntelliCredApp = false
if of_get_app_setting("set_cont", "I") = 0 then ib_IsIntelliContract = false
//END---Add by Evan 09/18/2008

//add by stephen 12.19.2012 --V12.3 Import Logging modifications
ii_set73 = gds_settings.GetItemNumber(1,'set_73')  
IF w_mdi.of_security_access( 7380 ) = 0 THEN  tab_1.tabpage_data.cbx_store_temp.visible = false

istr_ocr = message.powerobjectparm //(Appeon)Stephen 06.11.2014 - Using image OCR to import data into IntelliCred 14.2


 //Start Code Change ----08.21.2015 #V15 maha
if of_get_app_setting("set_import", "I") = 2 then
	if upper(gs_user_id ) = "MASTER" then
		//allow write access
	else
		postevent("ue_run_only")
	end if
end if
end event

type tab_1 from tab within w_import_painter
event create ( )
event destroy ( )
integer x = 5
integer y = 4
integer width = 4055
integer height = 2156
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean raggedright = true
boolean boldselectedtext = true
boolean createondemand = true
integer selectedtab = 1
tabpage_hdr tabpage_hdr
tabpage_field_data tabpage_field_data
tabpage_data tabpage_data
tabpage_log tabpage_log
end type

on tab_1.create
this.tabpage_hdr=create tabpage_hdr
this.tabpage_field_data=create tabpage_field_data
this.tabpage_data=create tabpage_data
this.tabpage_log=create tabpage_log
this.Control[]={this.tabpage_hdr,&
this.tabpage_field_data,&
this.tabpage_data,&
this.tabpage_log}
end on

on tab_1.destroy
destroy(this.tabpage_hdr)
destroy(this.tabpage_field_data)
destroy(this.tabpage_data)
destroy(this.tabpage_log)
end on

event selectionchanged;long ll_Row
long ll_LockFile

of_SetMenu(NewIndex)

choose case NewIndex
	case 1 // Imports (tabpage_hdr)
		
	case 2 // Field Setup (tabpage_field_data)
		// Display records of each DW
		tab_1.tabpage_field_data.Event ue_DisplayData()
		
		// Change the title of dw_prac_cont_id
		//tab_1.tabpage_field_data.dw_prac_cont_id.Event GetFocus()
		
		// Lock DataWindow
		ll_Row = tab_1.tabpage_hdr.dw_browse.GetRow()
		if ll_Row > 0 then
			ll_LockFile = tab_1.tabpage_hdr.dw_browse.object.lock_file[ll_Row]
			if ll_LockFile = 1 then
				tab_1.tabpage_field_data.Event ue_LockDW(false)
			else
				tab_1.tabpage_field_data.Event ue_LockDW(true)
			end if
		else
			tab_1.tabpage_field_data.Event ue_LockDW(true)
		end if
		if IsNull(ll_LockFile) then ll_LockFile = 0
		
		// Create import fields if no import field in Import Fields DW
		if ib_PromptCreateImportField and ll_LockFile = 0 and tabpage_field_data.dw_field_list.RowCount() = 0 then
			MessageBox("Prompt", "Before you can do the Field Setup for the Import you need to create your Import Fields.")
			of_CreateImportField()
		end if
		
	case 3 // Data (tabpage_data)
		if il_curr_import_id <> il_page3_import_id then
			il_page3_import_id = il_curr_import_id
			tab_1.tabpage_data.dw_imp_data.DataObject = ""
			tab_1.tabpage_data.dw_imp_data.Event ue_SetTitle(0)
		end if

	case 4 // Error Logs (tabpage_log)
		tab_1.tabpage_log.Event ue_Retrieve()
end choose
end event

event selectionchanging;integer li_Return

choose case OldIndex
	case 1 // Update import record		
		li_Return = tab_1.tabpage_hdr.Event ue_save()
		if li_Return = -1 then Return 1
		
	case 2 // Update mapped field		
		li_Return = tab_1.tabpage_field_data.Event ue_save()
		if li_Return = -1 then Return 1				
end choose

Return 0
end event

type tabpage_hdr from userobject within tab_1
event ue_init ( )
event ue_add ( )
event type integer ue_save ( )
event ue_delete ( )
event ue_copyadd ( )
integer x = 18
integer y = 100
integer width = 4018
integer height = 2040
long backcolor = 33551856
string text = "Imports"
long tabbackcolor = 79680469
long picturemaskcolor = 12632256
dw_browse dw_browse
dw_imp_sql dw_imp_sql
dw_imp_hdr dw_imp_hdr
end type

event ue_init();string ls_Expression
long   ll_find

//BEGIN---Add by Evan 09/18/2008
if ib_IsIntelliCredApp and ib_IsIntelliContract then
elseif ib_IsIntelliCredApp then
	//---------Begin Modified by (Appeon)Stephen 12.23.2013 for V141 Import Modifications for Facility and Group--------
	//dw_browse.SetFilter("isoft_module = 1")
	//dw_imp_hdr.SetTabOrder("isoft_module", 0)
	dw_browse.SetFilter("isoft_module = 1 or isoft_module = 3")
	//---------End Modfiied ------------------------------------------------------	
	
	dw_imp_hdr.object.isoft_module.background.color = 67108864
else
	dw_browse.SetFilter("isoft_module = 2")
	dw_imp_hdr.SetTabOrder("isoft_module", 0)
	dw_imp_hdr.object.isoft_module.background.color = 67108864
end if
//END---Add by Evan 09/18/2008

dw_browse.SetTransObject(SQLCA)
dw_browse.Retrieve()
dw_browse.Modify("DataWindow.ReadOnly='yes'")

dw_browse.ShareData(dw_imp_hdr)
dw_browse.ShareData(dw_imp_sql)
//---------Begin Added by (Appeon)Stephen 06.11.2014 for Using image OCR to import data into IntelliCred 14.2--------
if  isvalid(istr_ocr) then
	if lower(istr_ocr.s_type)= "ocr_image" then
		//---------Begin Modified by (Appeon)Stephen 10.17.2014 for BugA101003--------
		/*
		dw_browse.setfilter("1<>1")
		dw_browse.filter()
		dw_browse.setfilter("import_id = " + string(istr_ocr.l_view_id))
		dw_browse.filter()
		if dw_browse.rowcount() > 0 then
			dw_browse.setrow(1)			
		end if
		*/
		parent.bringtotop = true
		if not(isnull(istr_ocr.l_view_id) or istr_ocr.l_view_id = 0) then
			ll_find = dw_browse.find("import_id = " + string(istr_ocr.l_view_id), 1, dw_browse.rowcount())
			if ll_find > 0 then
				dw_browse.selectrow(0, false)
				dw_browse.selectrow(ll_find, true)
				dw_browse.ScrollToRow(ll_find)	
				dw_imp_hdr.ScrollToRow(ll_find)
				dw_imp_sql.ScrollToRow(ll_find)
			end if
		end if
		//---------End Modfiied ------------------------------------------------------		
	end if
end if
//---------End Added ------------------------------------------------------
dw_imp_hdr.Event ue_SetEnabled(dw_browse.GetRow())

if AppeonGetClientType() = 'PB' Then
	ls_Expression = "sectiongreen.bmp~tif(isnull(doc_name), '" + gs_current_path + "\section.bmp', '" + gs_current_path + "\sectiongreen.bmp')"
	dw_imp_sql.object.b_view.filename = ls_Expression
end if
end event

event ue_add();long ll_InsertRow

dw_imp_hdr.AcceptText()
dw_imp_sql.AcceptText()

ll_InsertRow = dw_browse.InsertRow(0)
dw_browse.ScrollToRow(ll_InsertRow)
dw_imp_hdr.ScrollToRow(ll_InsertRow)
dw_imp_sql.ScrollToRow(ll_InsertRow)

dw_imp_hdr.SetColumn("import_name")
dw_imp_hdr.SetFocus()

//BEGIN---Add by Evan 09/18/2008
if ib_IsIntelliCredApp then
	dw_browse.SetItem(ll_InsertRow, "isoft_module", 1)
else
	dw_browse.SetItem(ll_InsertRow, "isoft_module", 2)
end if
//END---Add by Evan 09/18/2008
end event

event type integer ue_save();long ll_CurrentRow
long ll_DeleteRowCount
string ls_ImportID
string ls_DeleteSQL
string ls_DropTable
string ls_import_name
string ls_TableName
boolean lb_OldAutoCommit
DWItemStatus ldis_Status

dw_imp_hdr.AcceptText()
dw_imp_sql.AcceptText()

ll_DeleteRowCount = dw_browse.DeletedCount()
if dw_browse.ModifiedCount() + ll_DeleteRowCount <= 0 then Return 1

//Delete records of reference table
if ll_DeleteRowCount > 0 then
	for ll_CurrentRow = 1 to ll_DeleteRowCount
		if LenA(ls_ImportID) > 0 then ls_ImportID += ","
		ls_ImportID += String(dw_browse.object.import_id.delete[ll_CurrentRow])

		ls_import_name = Trim(dw_browse.object.import_name.delete[ll_CurrentRow])
		if IsNull(ls_import_name) or ls_import_name = "" then Continue
		if LenA(ls_DropTable) > 0 then ls_DropTable += ";~r~n"
		//BEGIN---Modify by Evan 09/18/2008
		//ls_DropTable += "DROP TABLE impt_" + ls_import_name
		ls_TableName = of_CorrectTableName(ls_import_name)
		ls_DropTable += "DROP TABLE " + ls_TableName
		//END---Modify by Evan 09/18/2008
	next
	
	//import_file_fields
	ls_DeleteSQL = "DELETE FROM import_file_fields WHERE import_id IN (" + ls_ImportID + ");~r~n"
	
	//import_mapping_fields
	ls_DeleteSQL += "DELETE FROM import_mapping_fields WHERE table_records_id IN (select table_records_id from import_table_records where import_id in (" + ls_ImportID + "));~r~n"	
	//import_table_records
	ls_DeleteSQL += "DELETE FROM import_table_records WHERE import_id IN (" + ls_ImportID + ");~r~n"
	
	//import_process_errors
	ls_DeleteSQL += "DELETE FROM import_process_errors WHERE process_tables_id IN (select process_tables_id from import_process_tables where process_id IN (select process_id from import_process where import_id IN (" + ls_ImportID + ")));~r~n"
	//import_process_tables
	ls_DeleteSQL += "DELETE FROM import_process_tables WHERE process_id IN (select process_id from import_process where import_id IN (" + ls_ImportID + "));~r~n"
	//import_process
	ls_DeleteSQL += "DELETE FROM import_process WHERE import_id IN (" + ls_ImportID + "); ~r~n"
	
	//---------Begin Added by (Appeon)Stephen 08.07.2014 for BugH072403--------
	//clear ocr table
	ls_DeleteSQL += "	update ocr_appl set import_id = null where import_id IN (" + ls_ImportID + ") "
	//---------End Added ------------------------------------------------------
	
	EXECUTE IMMEDIATE :ls_DeleteSQL;
	if SQLCA.SQLCode <> 0 then
		is_hdr_errinfo = SQLCA.SQLErrText
		of_CompleteTrans(false)
		MessageBox("Error", is_hdr_errinfo, StopSign!)		
		Return -1
	end if
	lb_OldAutoCommit = SQLCA.AutoCommit
	if lb_OldAutoCommit = false then SQLCA.AutoCommit = true		
	EXECUTE IMMEDIATE :ls_DropTable;
	if SQLCA.AutoCommit <> lb_OldAutoCommit then SQLCA.AutoCommit = lb_OldAutoCommit
end if

//Set date and modify user
//---------Begin Added by (Appeon)Stephen 12.23.2013 for Import Modifications for Facility and Group--------
long ll_sort_order
select max(sort_order) into :ll_sort_order from import_hdr using sqlca;
if isnull(ll_sort_order) then ll_sort_order = 0
//---------End Added ------------------------------------------------------
for ll_CurrentRow = 1 to dw_browse.RowCount()
	ldis_Status = dw_browse.GetItemStatus(ll_CurrentRow, 0, Primary!)
	if ldis_Status = NewModified! then
		dw_browse.object.create_date[ll_CurrentRow] = DateTime(Today(), Now())
		dw_browse.object.mod_user[ll_CurrentRow] = gs_user_id
		//---------Begin Added by (Appeon)Stephen 12.23.2013 for Import Modifications for Facility and Group--------
		ll_sort_order +=1
		dw_browse.object.sort_order[ll_CurrentRow] = ll_sort_order
		//---------End Added ------------------------------------------------------
	elseif ldis_Status = DataModified! then
		dw_browse.object.mod_date[ll_CurrentRow] = DateTime(Today(), Now())
		dw_browse.object.mod_user[ll_CurrentRow] = gs_user_id
	end if	
next

//Update import record
if dw_browse.Update() = 1 then
	of_CompleteTrans(true)
	//Get current import ID
	if dw_browse.GetRow() > 0 then
		il_curr_import_id = dw_browse.object.import_id[dw_browse.GetRow()]
		//---------Begin Added by (Appeon)Toney 06.18.2013 for V141 ISG-CLX--------
		//Copy field mapping data - jervis 12.18.2009
		IF ii_curr_isoft_module = 2 THEN
			if ib_IsCopy then	of_copy_field_data(il_pre_import_id,il_curr_import_id)	
		END IF
		//---------End Added ------------------------------------------------------------------		
	else
		il_curr_import_id = -1
	end if
	dw_browse.Event RowFocusChanged(dw_browse.GetRow())
	Return 1
else
	of_CompleteTrans(false)
	MessageBox("Error", is_hdr_errinfo, StopSign!)
	Return -1
end if
end event

event ue_delete();long ll_CurrentRow
long ll_import_id
DWItemStatus ldws_Status

ll_CurrentRow = dw_browse.GetRow()
if ll_CurrentRow <= 0 then Return

ldws_Status = dw_browse.GetItemStatus(ll_CurrentRow, 0, Primary!)
if ldws_Status = DataModified! or ldws_Status = NotModified! then	
	//---------Begin Modified by (Appeon)Toney 06.18.2013 for V141 ISG-CLX--------
	//$Reason:
	  /*
	if MessageBox("Delete", "Are you sure you want to delete the selected import file?", &
		Question!, YesNo!,2) = 2 then
		Return
	end if			
	  */
	//---------End Modfiied ------------------------------------------------------------------

	
	if MessageBox("Delete", "Are you sure you want to delete the selected import file, " + &
		"and all setup fields?", Question!, YesNo!, 2) = 2 then
		Return
	end if
	
end if


dw_browse.DeleteRow(ll_CurrentRow)
ll_CurrentRow = dw_browse.GetRow()
dw_browse.Event RowFocusChanged(ll_CurrentRow)
dw_imp_hdr.ScrollToRow(ll_CurrentRow)
dw_imp_sql.ScrollToRow(ll_CurrentRow)
	
//Get current import ID
if dw_browse.GetRow() > 0 then
	il_curr_import_id = dw_browse.object.import_id[ll_CurrentRow]
else
	il_curr_import_id = -1
	w_import_painter.Title = "Import Painter"
end if
end event

event ue_copyadd();long ll_Null
long ll_CopyRow
long ll_InsertRow
string ls_Null

SetNull(ll_Null)
SetNull(ls_Null)

dw_imp_hdr.AcceptText()
dw_imp_sql.AcceptText()

ll_CopyRow = dw_browse.GetRow()
if ll_CopyRow > 0 then
	//---------Begin Added by (Appeon)Toney 06.18.2013 for V141 ISG-CLX--------
	il_pre_import_id = dw_browse.GetItemNumber( ll_copyRow,"import_id")	//Jervis 12.18.2009	
	//---------End Added ------------------------------------------------------------------
	ll_InsertRow = dw_browse.RowCount() + 1
	dw_browse.object.data[ll_InsertRow] = dw_browse.object.data[ll_CopyRow]
	dw_browse.SetItem(ll_InsertRow, "import_id", ll_Null)
	dw_browse.SetItem(ll_InsertRow, "doc_name", ls_Null)
	dw_browse.ScrollToRow(ll_InsertRow)
	dw_imp_hdr.ScrollToRow(ll_InsertRow)
	dw_imp_sql.ScrollToRow(ll_InsertRow)
	dw_imp_hdr.SetColumn("import_name")
	dw_imp_hdr.SetFocus()
end if



end event

on tabpage_hdr.create
this.dw_browse=create dw_browse
this.dw_imp_sql=create dw_imp_sql
this.dw_imp_hdr=create dw_imp_hdr
this.Control[]={this.dw_browse,&
this.dw_imp_sql,&
this.dw_imp_hdr}
end on

on tabpage_hdr.destroy
destroy(this.dw_browse)
destroy(this.dw_imp_sql)
destroy(this.dw_imp_hdr)
end on

event constructor;this.Event ue_init()
end event

type dw_browse from u_dw within tabpage_hdr
integer x = 5
integer y = 12
integer width = 4014
integer height = 676
integer taborder = 21
boolean bringtotop = true
boolean titlebar = true
string title = "Imports List"
string dataobject = "d_import_browse"
boolean hscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;//inherit
string ls_import_name
DWItemStatus ldwi_Status

this.SelectRow(0, false)
this.SelectRow(CurrentRow, true)

dw_imp_hdr.ScrollToRow(CurrentRow)
dw_imp_sql.ScrollToRow(CurrentRow)
of_presql_status(CurrentRow)  //(Appeon)Stephen 10.17.2015 - V15.1-Import Improvements 2015

if CurrentRow > 0 then ldwi_Status = GetItemStatus(CurrentRow, 0, Primary!)
if CurrentRow = 0 or ldwi_Status = New! or ldwi_Status = NewModified! then
	//---------Begin Modified by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
	//if isvalid(m_pfe_cst_import_painter) then m_pfe_cst_import_painter.m_file.m_runimport.enabled = false   //Start Code Change ----07.22.2013 #V14 maha - added isvalid check
	if isvalid(m_pfe_cst_import_painter) then gnv_app.of_modify_menu_attr( m_pfe_cst_import_painter.m_file.m_runimport,'enabled', false)
	//---------End Modfiied ------------------------------------------------------
	tab_1.tabpage_field_data.enabled = false
	tab_1.tabpage_data.enabled = false
	tab_1.tabpage_log.enabled = false	
else
	//---------Begin Modified by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
	//if isvalid(m_pfe_cst_import_painter) then m_pfe_cst_import_painter.m_file.m_runimport.enabled = true    //Start Code Change ----07.22.2013 #V14 maha - added isvalid check
	if isvalid(m_pfe_cst_import_painter) then gnv_app.of_modify_menu_attr( m_pfe_cst_import_painter.m_file.m_runimport,'enabled', true)
	//---------End Modfiied ------------------------------------------------------
	tab_1.tabpage_field_data.enabled = true
	tab_1.tabpage_data.enabled = true
	tab_1.tabpage_log.enabled = true	
	
	// Get current import ID
	il_curr_import_id = this.object.import_id[CurrentRow]
	tab_1.tabpage_data.cbx_store_temp.checked = false //add by stephen 12.29.2012 -V12.3 Import Logging modifications
end if

// Get current isoft_module and import name
if CurrentRow > 0 then
	ii_curr_isoft_module = this.object.isoft_module[CurrentRow]
	ls_import_name = this.object.import_name[CurrentRow]
else
	ls_import_name = "" 
end if

// Set title text of window
if IsNull(ls_import_name) or LenA(ls_import_name) <= 0 then
	ls_import_name = "Unknown"
end if
if ii_curr_isoft_module = 1 or ii_curr_isoft_module = 3 then //(Appeon)Stephen 12.23.2013 - V141 Import Modifications for Facility and Group
	w_import_painter.Title = "Import Setup : " + ls_import_name + " of IntelliCred/App"
else
	w_import_painter.Title = "Import Setup : " + ls_import_name + " of IntelliContract"
end if
end event

event dberror;//override
is_hdr_errinfo = SQLErrText

Return 1
end event

event doubleclicked;call super::doubleclicked;if tab_1.tabpage_field_data.enabled then
	tab_1.SelectTab(2)
end if
end event

event other;call super::other;if Message.WordParm = 61458 then 
	Message.Processed = true
	Message.ReturnValue = 0 
end if
end event

event clicked;call super::clicked;this.SetRow(Row)
dw_imp_hdr.ScrollToRow(Row)
dw_imp_sql.ScrollToRow(Row)
of_presql_status(row)  //(Appeon)Stephen 10.17.2015 - V15.1-Import Improvements 2015
end event

type dw_imp_sql from u_dw within tabpage_hdr
event ue_keydown pbm_dwnkey
integer y = 1672
integer width = 4014
integer height = 348
integer taborder = 21
boolean bringtotop = true
string title = "Import Notes"
string dataobject = "d_import_docs"
boolean hscrollbar = true
boolean vscrollbar = false
boolean livescroll = false
end type

event ue_keydown;if Key = KeyDownArrow! or Key = KeyUpArrow! or Key = KeyPageUp! or Key = KeyPageDown! then 
	Return 1
else
	Return 0
end if
end event

event buttonclicked;call super::buttonclicked;integer li_Return
string  ls_DocPath
string  ls_DocName
long    ll_ImportID
blob    lblb_Data
string  ls_Parm

choose case dwo.name
	case "b_view"
		ls_DocName = dw_imp_hdr.object.doc_name[Row]
		if ls_DocName="" or IsNull(ls_DocName) then
			MessageBox("Prompt", "There is no document.") //Start Code Change ----02.07.2008 #V8 maha - modified message
		else
			ll_ImportID = dw_imp_hdr.object.import_id[Row]
			ls_Parm = String(ll_ImportID) + "|" + ls_DocName
			OpenWithParm(w_import_viewdoc, ls_Parm)
		end if
		
	case "b_update"
		/*li_Return = GetFileOpenName("Select File", ls_DocPath, ls_DocName, "DOC", &
											 "Word Files (*.DOC),*.DOC,Excel Files (*.XLS),*.XLS,Text Files (*.TXT),*.TXT", &
											 gs_current_path) */
		//---------Begin Modified by (Appeon)Toney 06.18.2013 for V141 ISG-CLX--------		
		  /*
			li_Return = GetFileOpenName("Select File", ls_DocPath, ls_DocName, "DOC", &
												 "Word Files (*.DOC;*.DOCX),*.DOC;*.DOCX,Excel Files (*.XLS),*.XLS,Text Files (*.TXT),*.TXT", &
												 gs_current_path)	  //V12.2 usage of docx - alfee 07.05.2012										 											 
			ChangeDirectory(gs_current_path)				
		  */
		gf_load_dir_path() //Added by Ken.Guo on 2009-03-10
		li_Return = GetFileOpenName("Select File", ls_DocPath, ls_DocName, "DOC", &
												 "Word Files (*.DOC;*.DOCX),*.DOC;*.DOCX,Excel Files (*.XLS),*.XLS,Text Files (*.TXT),*.TXT")	  //V12.2 usage of docx - alfee 07.05.2012	
	    gf_save_dir_path(ls_DocPath) //Added by Ken.Guo on 2009-03-10
		//---------End Modfiied ------------------------------------------------------------------
		if li_Return <> 1 then Return
		
		dw_imp_hdr.object.doc_name[Row] = ls_DocName
		dw_imp_hdr.object.doc_updated[Row] = DateTime(Today(), Now())
		li_Return = tab_1.tabpage_hdr.Event ue_save()
		if li_Return = -1 then Return

		ll_ImportID = dw_imp_hdr.object.import_id[Row]
		lblb_Data = of_ReadFile(ls_DocPath)
		UPDATEBLOB import_hdr SET import_doc = :lblb_Data WHERE import_id = :ll_ImportID;		
		if SQLCA.SQLCode = 0 then
			of_CompleteTrans(true)
		else
			is_hdr_errinfo = SQLCA.SQLErrText
			of_CompleteTrans(false)
			MessageBox("Error", is_hdr_errinfo, StopSign!)
		end if
		
	case else		
end choose
end event

event other;call super::other;if Message.WordParm = 61458 then 
	Message.Processed = true
	Message.ReturnValue = 0	
end if

if Message.Number = 522 then
	Return 1
end if
end event

event losefocus;call super::losefocus;//Inherit
this.AcceptText()
end event

type dw_imp_hdr from u_dw within tabpage_hdr
event ue_setenabled ( long al_row )
event ue_keydown pbm_dwnkey
event ue_sort ( )
integer y = 684
integer width = 4014
integer taborder = 11
boolean titlebar = true
string title = "Import Detail"
string dataobject = "d_import_hdr"
boolean hscrollbar = true
boolean vscrollbar = false
boolean livescroll = false
end type

event ue_setenabled(long al_row);long ll_lock_file
string ls_imp_format

if not al_Row > 0 then Return

this.AcceptText()
ll_lock_file = this.object.lock_file[al_Row]

//Start Code Change ----02.07.2008 #V8 maha - added lock protection
if ll_lock_file = 1 then //lock everything
	this.object.odbc_name.protect = 1
	this.object.odbc_login.protect = 1	
	this.object.odbc_password.protect = 1	
	this.object.record_delimiter.protect = 1
	this.object.field_delimiter.protect = 1
	this.object.ignore_header_row.protect = 1
	this.object.update_verifications.protect = 1
	this.object.cb_browse.enabled = "no"
	
	this.object.import_name.protect = 1
	this.object.project_id.protect = 1
	this.object.isoft_module.protect = 1
	this.object.err_process.protect = 1
	this.object.add_protocol.protect = 1
	this.object.update_verifications.protect = 1
	this.object.err_notify.protect = 1
	this.object.err_file.protect = 1
	this.object.notify_addr1.protect = 1
	this.object.notify_addr2.protect = 1
	this.object.imp_format.protect = 1
	this.object.flat_multi.protect = 1
	this.object.imp_file.protect = 1
	this.object.field_audit.protect = 1 //Add by Evan on 12.04.2009
	
else
	ls_imp_format = this.object.imp_format[al_Row]
	
	//unprotect
	this.object.import_name.protect = 0
	this.object.project_id.protect = 0
	this.object.isoft_module.protect = 0
	this.object.err_process.protect = 0
	this.object.add_protocol.protect = 0
	this.object.update_verifications.protect = 0
	this.object.err_notify.protect = 0
	this.object.err_file.protect = 0
	this.object.notify_addr1.protect = 0
	this.object.notify_addr2.protect = 0
	this.object.imp_format.protect = 0
	this.object.flat_multi.protect = 0
	this.object.imp_file.protect = 0
	this.object.field_audit.protect = 0 //Add by Evan on 12.04.2009
	
	//protect in prep for case statement
	this.object.odbc_name.protect = 1
	this.object.odbc_name.background.color = 67108864
	this.object.odbc_login.protect = 1
	this.object.odbc_login.background.color = 67108864
	this.object.odbc_password.protect = 1
	this.object.odbc_password.background.color = 67108864
	this.object.record_delimiter.protect = 1
	this.object.record_delimiter.background.color = 67108864	
	this.object.field_delimiter.protect = 1
	this.object.field_delimiter.background.color = 67108864
	this.object.ignore_header_row.protect = 1
	this.object.update_verifications.protect = 1
	this.object.update_verifications.background.color = 67108864
	this.object.cb_browse.enabled = "no"
	
	if this.object.isoft_module[al_Row] = 1 then
		this.object.update_verifications.protect = 0
		this.object.update_verifications.background.color = 16777215	
	end if
	
	choose case ls_imp_format
		case "1", "2" //Tab Delimited, CSV
			this.object.ignore_header_row.protect = 0
			this.object.cb_browse.enabled = "yes"
		case "3"      //ODBC
			this.object.ignore_header_row.protect = 1
			this.object.odbc_name.protect = 0
			this.object.odbc_name.background.color = 16777215
			this.object.odbc_login.protect = 0
			this.object.odbc_login.background.color = 16777215
			this.object.odbc_password.protect = 0
			this.object.odbc_password.background.color = 16777215
		case "4"      //Formatted text
			this.object.ignore_header_row.protect = 0
			this.object.record_delimiter.protect = 0
			this.object.record_delimiter.background.color = 16777215	
			this.object.field_delimiter.protect = 0
			this.object.field_delimiter.background.color = 16777215
			this.object.cb_browse.enabled = "yes"
	end choose
end if
//End Code Change---02.07.2008
end event

event ue_keydown;if Key = KeyDownArrow! or Key = KeyUpArrow! or Key = KeyPageUp! or Key = KeyPageDown! then 
	Return 1
else
	Return 0
end if
end event

event ue_sort();//Start Code Change ----06.25.2014 #V14.2 maha - added
tab_1.tabpage_hdr.dw_imp_hdr.sort()
end event

event buttonclicked;call super::buttonclicked;string ls_DocPath
string ls_DocName
string ls_imp_format
string ls_filter_exp
integer li_Return
long   ll_imp_id

choose case dwo.name	
	case "cb_browse"		
		//---------Begin Modified by (Appeon)Toney 06.18.2013 for V141 ISG-CLX--------		
		  /*
		    ls_imp_format = this.object.imp_format[row]
			if ls_imp_format = "1" then
				li_Return = GetFileOpenName("Select File", ls_DocPath, ls_DocName, "TXT", &
													 "Text Files (*.TXT),*.TXT", gs_current_path)
			elseif ls_imp_format = "2" then
				li_Return = GetFileOpenName("Select File", ls_DocPath, ls_DocName, "CSV", &
													 "CSV Files (*.CSV),*.CSV", gs_current_path)
			else
				li_Return = GetFileOpenName("Select File", ls_DocPath, ls_DocName, "TXT", &
													 "All Files (*.*),*.*", gs_current_path)			
			end if				
		  */
		gf_load_dir_path() //Added by Ken.Guo on 2009-03-10
		ls_imp_format = this.object.imp_format[row]
		if ls_imp_format = "1" then
			li_Return = GetFileOpenName("Select File", ls_DocPath, ls_DocName, "TXT", &
												 "Text Files (*.TXT),*.TXT")
		elseif ls_imp_format = "2" then
			li_Return = GetFileOpenName("Select File", ls_DocPath, ls_DocName, "CSV", &
												 "CSV Files (*.CSV),*.CSV")
		else
			li_Return = GetFileOpenName("Select File", ls_DocPath, ls_DocName, "TXT", &
												 "All Files (*.*),*.*")			
		end if		  
		//---------End Modfiied ------------------------------------------------------------------	
		if li_Return = 1 then
			dw_browse.SetItem(Row, "imp_file", ls_DocPath)
		end if

	case "cb_filter_exp" //Add by Evan 07.19.2011 (V11.3 QA Import)
		Open(w_import_filter_exp)
	case "b_run_sql" //(Appeon)Stephen 04.01.2015 - V15.1-Import Improvements 2015
		if row < 1 then return 
		ll_imp_id = this.object.import_id[row]
		openwithparm(w_autorun_impsql, ll_imp_id) 
		of_presql_status(row)  //(Appeon)Stephen 11.17.2015 - BugL091402
	case else
end choose
//---------Begin Modified by (Appeon)Toney 06.18.2013 for V141 ISG-CLX--------
  /*
    ChangeDirectory(gs_current_path) //Add by Evan 12/11/2008  
  */
 gf_save_dir_path(ls_DocPath) //Added by Ken.Guo on 2009-03-10
//---------End Modfiied ------------------------------------------------------------------

end event

event itemchanged;call super::itemchanged;//inherit
long ll_Null
long ll_Count
long ll_import_id
string ls_Null
DataWindow ldw_records

SetNull(ls_Null)
SetNull(ll_Null)

choose case dwo.name
	case "imp_format"
		this.Event ue_SetEnabled(Row)
		this.SetItem(Row, "odbc_name", ls_Null)
		this.SetItem(Row, "odbc_login", ls_Null)
		this.SetItem(Row, "odbc_password", ls_Null)
		this.SetItem(Row, "imp_file", ls_Null)
		this.SetItem(Row, "record_delimiter", ls_Null)
		this.SetItem(Row, "field_delimiter", ls_Null)
		this.SetItem(Row, "import_sql", ls_Null)	
		choose case Data
			case "1", "2"
				this.SetItem(Row, "ignore_header_row", 1)
				this.SetColumn("imp_file")
				this.Post SetFocus()
			case "3"
				this.SetItem(Row, "ignore_header_row", 0)
				this.SetColumn("odbc_name")
				this.Post SetFocus()
			case "4"
				this.SetItem(Row, "ignore_header_row", 0)
				this.SetColumn("record_delimiter")
				this.Post SetFocus()
		end choose

	case "record_delimiter"
		if Data = this.object.field_delimiter[Row] then
			this.Post SetItem(Row, "record_delimiter", ls_Null)
		end if
		
	case "field_delimiter"
		if Data = this.object.record_delimiter[Row] then
			this.Post SetItem(Row, "field_delimiter", ls_Null)
		end if
		
	case "isoft_module"
		il_page2_import_id = -1
		ii_curr_isoft_module = Integer(Data)
		ll_import_id = this.object.import_id[Row]
		// Clear field setup
		SELECT count(*) INTO :ll_Count FROM import_table_records WHERE import_id = :ll_import_id;
		if ll_Count > 0 then
			if MessageBox("Delete", "Modify import type will delete all setup fields, are you sure you want to continue?", Question!, YesNo!) = 1 then				
				gnv_appeondb.of_StartQueue()
				DELETE FROM import_mapping_fields WHERE table_records_id IN (select table_records_id from import_table_records where import_id = :il_curr_import_id);
				DELETE FROM import_table_records WHERE import_id = :il_curr_import_id;
				COMMIT;
				gnv_appeondb.of_CommitQueue()
				ldw_records = tab_1.tabpage_field_data.dw_records
				ldw_records.SetFilter("import_id = "  + String(il_curr_import_id))
				ldw_records.Filter()
				ldw_records.RowsMove(1, ldw_records.RowCount(), Primary!, ldw_records, 1, Delete!)
				ldw_records.RowsDiscard(1, ldw_records.DeletedCount(), Delete!)
			else
				//BEGIN---Modify by Evan 08/18/2008
				//ii_curr_isoft_module = this.GetItemNumber(Row, "isoft_module")
				ii_curr_isoft_module = this.object.isoft_module.original[Row]
				//END---Modify by Evan 08/18/2008
				this.Post SetItem(Row, "isoft_module", ii_curr_isoft_module)
			end if
		end if
		// Set others
		if ii_curr_isoft_module = 1 then
			this.object.update_verifications[row] = 1
			this.object.update_verifications.protect = 0
			this.object.update_verifications.background.color = 16777215			
		else
			this.object.update_verifications[row] = ll_Null
			this.object.update_verifications.protect = 1
			this.object.update_verifications.background.color = 67108864			
		end if
		dw_browse.Post Event RowFocusChanged(Row)
	case "lock_file" //Start Code Change ----02.07.2008 #V8 maha
		this.Post Event ue_setenabled( row)
	case "sort_order"
		//Start Code Change ----06.25.2014 #V14.2 maha - added
		this.Post Event ue_sort( )
end choose
end event

event rowfocuschanged;call super::rowfocuschanged;//inherit
if CurrentRow > 0 then
	this.Event ue_SetEnabled(CurrentRow)
end if
end event

event other;call super::other;if Message.WordParm = 61458 then 
	Message.Processed = true
	Message.ReturnValue = 0	
end if

if Message.Number = 522 then
	Return 1
end if
end event

event losefocus;call super::losefocus;//Inherit
this.AcceptText()
end event

type tabpage_field_data from userobject within tab_1
event create ( )
event destroy ( )
event ue_lockdw ( boolean ab_flag )
event ue_init ( )
event ue_displaydata ( )
event type integer ue_save ( )
event ue_checkmapping ( )
event ue_deleteimportfield ( )
event ue_addimportfield ( )
event ue_resize ( )
event ue_copymap ( )
integer x = 18
integer y = 100
integer width = 4018
integer height = 2040
boolean enabled = false
long backcolor = 33551856
string text = "Field Setup"
long tabtextcolor = 33554432
long tabbackcolor = 79680469
long picturemaskcolor = 12632256
cb_create_value_list cb_create_value_list
cb_com_wizard cb_com_wizard
cb_edit_map cb_edit_map
dw_detail dw_detail
dw_map_fields dw_map_fields
dw_records dw_records
dw_fields dw_fields
dw_tables dw_tables
ln_1 ln_1
ln_2 ln_2
ln_4 ln_4
ln_5 ln_5
ln_3 ln_3
dw_imp_field_detail dw_imp_field_detail
dw_field_list dw_field_list
dw_compute_verify dw_compute_verify
dw_prac_cont_id dw_prac_cont_id
end type

on tabpage_field_data.create
this.cb_create_value_list=create cb_create_value_list
this.cb_com_wizard=create cb_com_wizard
this.cb_edit_map=create cb_edit_map
this.dw_detail=create dw_detail
this.dw_map_fields=create dw_map_fields
this.dw_records=create dw_records
this.dw_fields=create dw_fields
this.dw_tables=create dw_tables
this.ln_1=create ln_1
this.ln_2=create ln_2
this.ln_4=create ln_4
this.ln_5=create ln_5
this.ln_3=create ln_3
this.dw_imp_field_detail=create dw_imp_field_detail
this.dw_field_list=create dw_field_list
this.dw_compute_verify=create dw_compute_verify
this.dw_prac_cont_id=create dw_prac_cont_id
this.Control[]={this.cb_create_value_list,&
this.cb_com_wizard,&
this.cb_edit_map,&
this.dw_detail,&
this.dw_map_fields,&
this.dw_records,&
this.dw_fields,&
this.dw_tables,&
this.ln_1,&
this.ln_2,&
this.ln_4,&
this.ln_5,&
this.ln_3,&
this.dw_imp_field_detail,&
this.dw_field_list,&
this.dw_compute_verify,&
this.dw_prac_cont_id}
end on

on tabpage_field_data.destroy
destroy(this.cb_create_value_list)
destroy(this.cb_com_wizard)
destroy(this.cb_edit_map)
destroy(this.dw_detail)
destroy(this.dw_map_fields)
destroy(this.dw_records)
destroy(this.dw_fields)
destroy(this.dw_tables)
destroy(this.ln_1)
destroy(this.ln_2)
destroy(this.ln_4)
destroy(this.ln_5)
destroy(this.ln_3)
destroy(this.dw_imp_field_detail)
destroy(this.dw_field_list)
destroy(this.dw_compute_verify)
destroy(this.dw_prac_cont_id)
end on

event ue_lockdw(boolean ab_flag);if w_mdi.of_security_access( 6928 ) = 1 then return  //(Appeon)Stephen 08.11.2015 - Import/Export Security

dw_detail.Enabled = ab_flag
dw_imp_field_detail.Enabled = ab_flag
ib_LockFile = not ab_Flag

cb_edit_map.Enabled = ab_flag
cb_com_wizard.Enabled = ab_flag
cb_create_value_list.Enabled = ab_flag

if ib_LockFile then
	dw_detail.object.b_viewlookups.enabled = "no"
	dw_field_list.object.b_add.enabled = "no"
	dw_field_list.object.b_delete.enabled = "no"
	//dw_field_list.object.b_compare.enabled = "no"	
else
	dw_detail.object.b_viewlookups.enabled = "yes"
	dw_field_list.object.b_add.enabled = "yes"
	dw_field_list.object.b_delete.enabled = "yes"
	//dw_field_list.object.b_compare.enabled = "yes"	
end if
end event

event ue_init();DataWindowChild ldwc_Child1
DataWindowChild ldwc_Child2
DataWindowChild ldwc_Child3

// Retrieve data
ids_LookUpTableDDDW[1] = Create DataStore
ids_LookUpTableDDDW[2] = Create DataStore

dw_tables.SetTransObject(SQLCA)
dw_fields.SetTransObject(SQLCA)
dw_records.SetTransObject(SQLCA)
dw_map_fields.SetTransObject(SQLCA)
dw_field_list.SetTransObject(SQLCA)
ids_LookUpTableDDDW[1].DataObject = "d_import_lu_temp1"
ids_LookUpTableDDDW[2].DataObject = "d_import_lu_temp2"
ids_LookUpTableDDDW[1].SetTransObject(SQLCA)
ids_LookUpTableDDDW[2].SetTransObject(SQLCA)

gnv_appeondb.of_startqueue()
dw_tables.Retrieve()
dw_fields.Retrieve()
dw_records.Retrieve()
ids_LookUpTableDDDW[1].Retrieve()
ids_LookUpTableDDDW[2].Retrieve()
gnv_appeondb.of_commitqueue()

// Share data
dw_map_fields.ShareData(dw_detail)
dw_field_list.ShareData(dw_imp_field_detail)

// null_value, lu_template and facility_id DDDW of dw_detail pre-retrieve
dw_detail.GetChild("null_value", ldwc_Child1)
dw_detail.GetChild("lu_template", ldwc_Child2)
dw_detail.GetChild("facility_id", ldwc_Child3)
ldwc_Child1.SetTransObject(SQLCA)
ldwc_Child2.SetTransObject(SQLCA)
ldwc_Child3.SetTransObject(SQLCA)

gnv_appeondb.of_startqueue()
ldwc_Child1.Retrieve()
ldwc_Child2.Retrieve()
ldwc_Child3.Retrieve()
gnv_appeondb.of_commitqueue()

ldwc_Child1.InsertRow(1)
ldwc_Child1.InsertRow(1)
ldwc_Child1.SetItem(1, "lookup_name", "* NULL *")
ldwc_Child1.SetItem(2, "lookup_name", "* Select Value *")
ldwc_Child1.SetItem(2, "description", "* Select Value *")

ldwc_Child2.InsertRow(1)
end event

event ue_displaydata();DataWindowChild ldwc_Temp
DataWindowChild ldwc_Child
long i, ll_table_records_id[]

if il_curr_import_id = il_page2_import_id then Return
il_page2_import_id = il_curr_import_id
this.SetRedraw(false)

///////////////////////////[1.Filter]////////////////////////////////////////
// Filter records of dw_tables
dw_tables.SetFilter("isoft_module = " + String(ii_curr_isoft_module))
dw_tables.Filter()
dw_tables.Event RowFocusChanged(dw_tables.GetRow())

// Filter records of dw_records
dw_records.SetFilter("import_id = " + String(il_curr_import_id))
dw_records.Filter()

///////////////////////////[2.Retrieve]//////////////////////////////////////
// Retrieve records of dw_map_fields and dw_field_list
if dw_records.RowCount() > 0 then
	for i = 1 to dw_records.RowCount()
		ll_table_records_id[i] = dw_records.object.table_records_id[i]
	next
	
	gnv_appeondb.of_StartQueue()
	dw_map_fields.Retrieve(ll_table_records_id)	
	dw_field_list.Retrieve(il_curr_import_id)	
	gnv_appeondb.of_CommitQueue()
		
	dw_records.Event RowFocusChanged(dw_records.GetRow())
else
	dw_map_fields.Reset()
	dw_prac_cont_id.Reset()
	dw_field_list.Retrieve(il_curr_import_id)
end if
dw_field_list.SelectRow(1, true)

///////////////////////////[3.Initialize DDDW]////////////////////////////////
// import_field_id DDDW
if dw_field_list.RowCount() > 0 then
	// DDDW of dw_map_fields
	dw_map_fields.GetChild("import_field_id", ldwc_Child)
	ldwc_Child.Reset()
	dw_field_list.RowsCopy(1, dw_field_list.RowCount(), Primary!, ldwc_Child, 1, Primary!)
	dw_map_fields.SetRedraw(true)
	
	// DDDW of dw_detail
	dw_detail.GetChild("import_field_id", ldwc_Child)
	ldwc_Child.Reset()
	dw_field_list.RowsCopy(1, dw_field_list.RowCount(), Primary!, ldwc_Child, 1, Primary!)
	dw_detail.SetRedraw(true)	

	// DDDW of dw_prac_cont_id
	//dw_prac_cont_id.GetChild("import_field_id", ldwc_Child)
	//ldwc_Child.Reset()
	//dw_field_list.RowsCopy(1, dw_field_list.RowCount(), Primary!, ldwc_Child, 1, Primary!)	
end if
//dw_map_fields.GetChild("isoft_field_id", ldwc_Temp)
//dw_prac_cont_id.GetChild("isoft_field_id", ldwc_Child)
//ldwc_Child.Reset()
//ldwc_Temp.RowsCopy(1, ldwc_Temp.RowCount(), Primary!, ldwc_Child, 1, Primary!)
//dw_prac_cont_id.SetRedraw(true)

///////////////////////////[4.Others]////////////////////////////////////////
dw_detail.object.t_import_id.text = String(il_curr_import_id)
this.SetRedraw(true)
end event

event type integer ue_save();integer i, ll_SelectRow
boolean lb_DoCommit = false
DataWindowChild ldw_Child

/////////////////////////////////////////////////////////////////////////////////////////
// Update import field
if dw_imp_field_detail.AcceptText() = -1 then Return -1
if dw_field_list.ModifiedCount() + dw_field_list.DeletedCount() > 0 then
	lb_DoCommit = true
	
	if of_verify_field_name(dw_field_list, "imp_field_name") = -1 then return -1 //(Appeon)Stephen 03.03.2014 - add a check when an added field -bug 3598
	// Reset field order
	dw_field_list.SetSort("field_order A")
	dw_field_list.Sort()
	for i = 1 to dw_field_list.RowCount()
		dw_field_list.SetItem(i, "field_order", i * 10)
	next
	ll_SelectRow = dw_field_list.GetSelectedRow(0)
	if ll_SelectRow <= 0 then ll_SelectRow = 1		
	dw_field_list.ScrollToRow(ll_SelectRow)
	dw_imp_field_detail.ScrollToRow(ll_SelectRow)
		
	// Update import field
	if dw_field_list.Update() <> 1 then
		of_CompleteTrans(false)
		MessageBox("Error", is_mapfield_errinfo, StopSign!)
		Return -1
	end if

	// initialize DDDW
	//dw_prac_cont_id.GetChild("import_field_id", ldw_Child)
	//ldw_Child.Reset()
	//dw_field_list.RowsCopy(1, dw_field_list.RowCount(), Primary!, ldw_Child, 1, Primary!)
		
	dw_map_fields.GetChild("import_field_id", ldw_Child)
	ldw_Child.Reset()
	dw_field_list.RowsCopy(1, dw_field_list.RowCount(), Primary!, ldw_Child, 1, Primary!)
		
	dw_detail.GetChild("import_field_id", ldw_Child)
	ldw_Child.Reset()
	dw_field_list.RowsCopy(1, dw_field_list.RowCount(), Primary!, ldw_Child, 1, Primary!)
	
	//dw_prac_cont_id.SetRedraw(true)
	dw_map_fields.SetRedraw(true)
	dw_detail.SetRedraw(true) 
end if

/////////////////////////////////////////////////////////////////////////////////////////
// Update mapped field
dw_detail.AcceptText()
if of_check_isgkey(dw_records, dw_fields, dw_map_fields) <> 1 then return -1  //(Appeon)Stephen 03.18.2015 - V15.1-Import Improvements 2015
if dw_map_fields.ModifiedCount() + dw_map_fields.DeletedCount() > 0 then
	lb_DoCommit = true
	
	if dw_map_fields.Update() <> 1 then
		of_CompleteTrans(false)
		MessageBox("Error", is_mapfield_errinfo, StopSign!)
		Return -1
	end if
end if

if lb_DoCommit then of_CompleteTrans(true)

Return 1
end event

event ue_checkmapping();string ls_LogList
string ls_Error
string ls_Null[]
string ls_ErrorText[]
string ls_table_name
string ls_table_name_allias
integer i, j, li_ErrorCount
long ll_FindRow
long ll_InsertRow
long ll_table_id
long ll_table_records_id[]
n_cst_import lnv_import
DataStore lds_table_record
DataStore lds_import_field
DataStore lds_mapping_field

lnv_import = Create n_cst_import
lds_table_record = Create DataStore
lds_import_field = Create DataStore
lds_mapping_field = Create DataStore

////////////////////////////////////////[1-Check Import Table]//////////////////////////////////////
lds_table_record.DataObject = "d_import_ds_table"
for i = 1 to dw_records.RowCount()
	ll_table_id = dw_records.object.isoft_table_id[i]
	ll_table_records_id[i] = dw_records.object.table_records_id[i]
	ll_FindRow = dw_tables.Find("table_id=" + String(ll_table_id), 1, dw_tables.RowCount())
	if ll_FindRow > 0 then
		ll_InsertRow = lds_table_record.InsertRow(0)
		lds_table_record.object.isoft_table_id[ll_InsertRow] = ll_table_id
		lds_table_record.object.table_name[ll_InsertRow] = dw_tables.object.table_name[ll_FindRow]
		lds_table_record.object.table_name_allias[ll_InsertRow] = dw_tables.object.table_name_allias[ll_FindRow]
	end if
next
ls_Error = lnv_import.of_CheckImportTable(lds_table_record)
if LenA(ls_Error) > 0 then	
	Destroy lnv_import
	Destroy lds_table_record
	Destroy lds_import_field
	Destroy lds_mapping_field
	MessageBox("Prompt", ls_Error)
	Return	
end if
	
////////////////////////////////////////[2-Check Import File Fields]////////////////////////////////
lds_import_field.DataObject = dw_field_list.DataObject
dw_imp_field_detail.AcceptText()
dw_field_list.RowsCopy(1, dw_field_list.RowCount(), Primary!, lds_import_field, 1, Primary!)
ls_Error = lnv_import.of_VerifyImportField(lds_import_field)
if LenA(ls_Error) > 0 then
	Destroy lnv_import
	Destroy lds_table_record
	Destroy lds_import_field
	Destroy lds_mapping_field
	MessageBox("Prompt", ls_Error)
	Return
end if

////////////////////////////////////////[3-Check Mapping]//////////////////////////////////////////
// Get imformation
Destroy lnv_import
if ii_curr_isoft_module = 1 then
	lnv_import = Create n_cst_import_credapp	
//---------Begin Added by (Appeon)Stephen 12.23.2013 for V141 Import Modifications for Facility and Group--------
elseif ii_curr_isoft_module = 3 then
	lnv_import = Create n_cst_import_faci
//---------End Added ------------------------------------------------------	
else
	lnv_import = Create n_cst_import_contract
end if
lds_mapping_field.DataObject = "d_import_ds_mapfield"
lds_mapping_field.SetTransObject(SQLCA)
gnv_appeondb.of_StartQueue()
Event pfc_save()
lnv_import.ids_dataview_screen.Retrieve(1)
lds_mapping_field.Retrieve(ll_table_records_id[])
gnv_appeondb.of_CommitQueue()

// Check mapping
for i = 1 to lds_table_record.RowCount()
	ls_ErrorText [] = ls_Null[]
	ll_table_id = lds_table_record.object.isoft_table_id[i]
	ls_table_name = Lower(lds_table_record.object.table_name[i])
	lds_mapping_field.SetFilter("table_records_id=" + String(ll_table_records_id[i]))
	lds_mapping_field.Filter()
	li_ErrorCount = lnv_import.of_CheckMapping(false, ll_table_id, ls_table_name, lds_import_field, lds_mapping_field, ls_ErrorText[])
	if li_ErrorCount > 0 then
		ls_table_name_allias = lds_table_record.object.table_name_allias[i]
		ls_LogList += "[" + ls_table_name_allias + "]~r~n"
		for j = 1 to li_ErrorCount
			ls_LogList += String(j) + "." + ls_ErrorText[j] + "~r~n"
		next
		ls_LogList += "~r~n"
	end if	
next
Destroy lnv_import
Destroy lds_table_record
Destroy lds_import_field
Destroy lds_mapping_field

////////////////////////////////////////[4-Show check mapping result]//////////////////////////////
// Show result
if LenA(ls_LogList) > 0 then
	OpenWithParm(w_import_loglist, "MAP#" + ls_LogList)
else
	MessageBox("Prompt", "Mapping design is OK.")
end if
end event

event ue_deleteimportfield();long ll_Null
long ll_CurrentRow
long ll_import_field_id

SetNull(ll_Null)
ll_CurrentRow = dw_field_list.GetRow()
if ll_CurrentRow <= 0 then Return

if MessageBox("Delete", "Are you sure you want to delete the selected import field?", &
	Question!, YesNo!,2) = 2 then
	Return
end if

ll_import_field_id = dw_field_list.object.rec_id[ll_CurrentRow]
dw_field_list.DeleteRow(0)
dw_imp_field_detail.ScrollToRow(dw_field_list.GetRow())

//for ll_CurrentRow = 1 to dw_prac_cont_id.RowCount()
//	if dw_prac_cont_id.object.import_field_id[ll_CurrentRow] = ll_import_field_id then
//		dw_prac_cont_id.object.import_field_id[ll_CurrentRow] = ll_Null
//	end if
//next

for ll_CurrentRow = 1 to dw_map_fields.RowCount()
	if dw_map_fields.object.import_field_id[ll_CurrentRow] = ll_import_field_id then
		dw_map_fields.object.import_field_id[ll_CurrentRow] = ll_Null
	end if
next
end event

event ue_addimportfield();long ll_InsertRow
long ll_CurrentRow
long ll_ImportID

dw_imp_field_detail.AcceptText()

ll_CurrentRow = tab_1.tabpage_hdr.dw_browse.GetRow()
if ll_CurrentRow <= 0 then Return	
ll_ImportID = tab_1.tabpage_hdr.dw_browse.object.import_id[ll_CurrentRow]

dw_field_list.SetSort("field_order A")
dw_field_list.Sort()
dw_imp_field_detail.ScrollToRow(1)

ll_InsertRow = dw_field_list.InsertRow(0)
dw_imp_field_detail.object.import_id[ll_InsertRow] = ll_ImportID
if ll_InsertRow = 1 then
	dw_imp_field_detail.object.field_order[ll_InsertRow] = 10
else
	dw_imp_field_detail.object.field_order[ll_InsertRow] = dw_imp_field_detail.object.field_order[ll_InsertRow - 1] + 10
end if
dw_imp_field_detail.object.field_length[ll_InsertRow] = 100
dw_field_list.ScrollToRow(ll_InsertRow)

dw_imp_field_detail.SetColumn("imp_field_name")
dw_imp_field_detail.SetFocus()
end event

event ue_resize();/////////////////////////////////////////////////////////////////
//Resize right DW
dw_field_list.X = this.Width - dw_field_list.Width - 10
dw_imp_field_detail.X = dw_field_list.X
cb_com_wizard.X = dw_field_list.X
cb_create_value_list.X = cb_com_wizard.X + cb_com_wizard.Width + 14 //40->14, modified by Appeon long.zhang 04.12.2016 (BugL041201)

dw_field_list.Height = this.Height - dw_imp_field_detail.Height - 110
dw_imp_field_detail.Y = dw_field_list.Y + dw_field_list.Height
cb_com_wizard.Y = dw_imp_field_detail.Y + dw_imp_field_detail.Height + 10
cb_create_value_list.Y = cb_com_wizard.Y

//Resize middle DW
dw_records.X = (dw_field_list.X - dw_tables.Width - dw_records.Width) / 2 + dw_tables.Width + 5
//dw_prac_cont_id.X = dw_records.X
dw_map_fields.X = dw_records.X
dw_detail.X = dw_records.X

dw_detail.Y = this.Height - dw_detail.Height - 5
dw_map_fields.Height = dw_detail.Y - dw_map_fields.Y

//Resize left DW
dw_fields.Height = this.Height - dw_tables.Height - 12

/////////////////////////////////////////////////////////////////
//Resize line
ln_1.EndX = dw_records.X + 50

//ln_2.EndX = dw_prac_cont_id.X + 50
//ln_2.EndY = dw_prac_cont_id.Y + 100

ln_3.EndX = dw_records.X + 50 //ln_2.EndX
ln_3.EndY = dw_map_fields.Y + 350

//ln_4.BeginX = dw_prac_cont_id.X + dw_prac_cont_id.Width - 10
//ln_4.EndX = dw_field_list.X + 50
//ln_4.EndY = dw_field_list.Y + 150

ln_5.BeginX = dw_map_fields.X + dw_map_fields.Width - 10
ln_5.EndX = dw_field_list.X + 50
ln_5.EndY = dw_field_list.Y + 550
end event

event ue_copymap();long ll_Null
long ll_CopyRow
long ll_InsertRow
long i, ll_RowCount
long ll_table_id
long ll_table_records_id

SetNull(ll_Null)
if dw_detail.Enabled = false then Return
ll_CopyRow = dw_records.GetRow()
if ll_CopyRow <= 0 then
	MessageBox("Prompt", "There is no Import to be copied.") //Start Code Change ----02.07.2008 #V8 maha - modified message
	Return
end if

// Copy import table record
ll_table_id = dw_records.object.isoft_table_id[ll_CopyRow]
ll_InsertRow = of_GetInsertRow(ll_table_id)
ll_InsertRow = dw_records.InsertRow(ll_InsertRow)
dw_records.SetItem(ll_InsertRow, "isoft_table_id", ll_table_id)
dw_records.SetItem(ll_InsertRow, "import_id", il_curr_import_id)
for i = 1 to dw_records.RowCount()
	dw_records.SetItem(i, "sort_no", i)
next

if dw_records.Update() <> 1 then
	of_CompleteTrans(false)
	MessageBox("Error", is_mapfield_errinfo, StopSign!)
	Return
else
	of_CompleteTrans(true)	
end if
ll_table_records_id = dw_records.object.table_records_id[ll_InsertRow]

// Copy mapped records
ll_RowCount = dw_map_fields.RowCount()
if ll_RowCount <= 0 then
	dw_records.SelectRow(0, false)
	dw_records.SelectRow(ll_InsertRow, true)
	dw_records.ScrollToRow(ll_InsertRow)
	Return
end if

dw_map_fields.SetRedraw(false)
dw_map_fields.RowsCopy(1, ll_RowCount, Primary!, dw_map_fields, 1, Primary!)
for i = 1 to ll_RowCount
	dw_map_fields.SetItem(i, "rec_id", ll_Null)
	dw_map_fields.SetItem(i, "table_records_id", ll_table_records_id)
next
if dw_map_fields.Update() <> 1 then
	of_CompleteTrans(false)
	dw_map_fields.SetRedraw(true)
	MessageBox("Error", is_mapfield_errinfo, StopSign!)
	Return
else
	of_CompleteTrans(true)
end if

// Refresh dw_map_fields
dw_records.ScrollToRow(ll_InsertRow)
dw_records.Event RowFocusChanged(ll_InsertRow)
dw_map_fields.SetRedraw(true)
end event

event constructor;this.Event ue_init()
end event

type cb_create_value_list from commandbutton within tabpage_field_data
integer x = 3534
integer y = 1892
integer width = 462
integer height = 84
integer taborder = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Create &Value List..."
end type

event clicked;long ll_CurrentRow
string ls_import_name
string ls_imp_field_name
string ls_Parm
integer li_Return

dw_imp_field_detail.AcceptText()
if dw_field_list.RowCount() <= 0 then
	MessageBox("Prompt", "Please add import field.")
	Return
end if
li_Return = tab_1.tabpage_field_data.Event ue_save()
if li_Return = -1 then Return

ll_CurrentRow = tab_1.tabpage_hdr.dw_browse.GetRow()
ls_import_name = tab_1.tabpage_hdr.dw_browse.object.import_name[ll_CurrentRow]

ll_CurrentRow = dw_field_list.GetRow()
ls_imp_field_name = dw_field_list.object.imp_field_name[ll_CurrentRow]
if IsNull(ls_imp_field_name) then ls_imp_field_name = ""

ls_Parm = String(il_curr_import_id) + "|" + ls_import_name + "|" + ls_imp_field_name
OpenWithParm(w_import_valuelist, ls_Parm)
end event

type cb_com_wizard from commandbutton within tabpage_field_data
integer x = 3054
integer y = 1892
integer width = 466
integer height = 84
integer taborder = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Compute &Wizard..."
end type

event clicked;string ls_Error
string ls_Syntax
string ls_SQLSelect
string ls_imp_field_name
long  ll_InsertRow
long  ll_CurrentRow
long  i, ll_RowCount

dw_imp_field_detail.AcceptText()
ll_RowCount = dw_field_list.RowCount()
if ll_RowCount <= 0 then
	MessageBox("Prompt", "Please add import field.")
	Return
end if
	
for i = 1 to ll_RowCount
	ls_imp_field_name = dw_field_list.object.imp_field_name[i]
	if IsNull(ls_imp_field_name) or ls_imp_field_name = "" then Continue
	if LenA(ls_SQLSelect) > 0 then ls_SQLSelect += ","
	ls_SQLSelect += "field_" + String(i) + " " + ls_imp_field_name
next

ls_SQLSelect = "SELECT " + ls_SQLSelect + " FROM import_table_gen"
ls_Syntax = SQLCA.SyntaxFromSQL(ls_SQLSelect, "", ls_Error)
dw_compute_verify.DataObject = ""
dw_compute_verify.Create(ls_Syntax, ls_Error)
dw_compute_verify.tag = dw_imp_field_detail.object.comp_def[dw_imp_field_detail.GetRow()]

OpenWithParm(w_compute_wizard, dw_compute_verify)
if Message.StringParm <> "cancel!" then	
	ll_CurrentRow = dw_imp_field_detail.GetRow()
	dw_imp_field_detail.object.comp_def[ll_CurrentRow] = Message.StringParm
	if LenA(Message.StringParm) > 0 then
		dw_imp_field_detail.object.field_format[ll_CurrentRow] = ""
		dw_imp_field_detail.object.case_type[ll_CurrentRow] = ""
		dw_imp_field_detail.object.strip_type[ll_CurrentRow] = ""
		dw_imp_field_detail.object.default_value[ll_CurrentRow] = ""		
		cb_create_value_list.Enabled = false
	else
		cb_create_value_list.Enabled = true
	end if	
	/*
	if dw_imp_field_detail.RowCount() = 1 or &
	ll_CurrentRow = dw_imp_field_detail.RowCount() or &		
	Len(String(dw_imp_field_detail.object.comp_def[ll_CurrentRow])) > 0 then
		dw_imp_field_detail.object.comp_def[ll_CurrentRow] = Message.StringParm
		dw_imp_field_detail.object.field_format[ll_CurrentRow] = ""
		dw_imp_field_detail.object.case_type[ll_CurrentRow] = ""
		dw_imp_field_detail.object.strip_type[ll_CurrentRow] = ""
		dw_imp_field_detail.object.default_value[ll_CurrentRow] = ""
	else				
		ll_InsertRow = dw_imp_field_detail.InsertRow(0)	
		dw_imp_field_detail.object.import_id[ll_InsertRow] = il_curr_import_id
		dw_imp_field_detail.object.comp_def[ll_InsertRow] = Message.StringParm
		dw_imp_field_detail.object.imp_field_name[ll_InsertRow] = dw_imp_field_detail.object.imp_field_name[ll_CurrentRow]
		dw_imp_field_detail.object.field_length[ll_InsertRow] = 100
		
		if ll_InsertRow = 1 then
			dw_imp_field_detail.object.field_order[ll_InsertRow] = 10
		else
			dw_imp_field_detail.object.field_order[ll_InsertRow] = dw_imp_field_detail.object.field_order[ll_InsertRow - 1] + 10
		end if
		
		dw_field_list.ScrollToRow(ll_InsertRow)
		dw_imp_field_detail.DeleteRow(ll_CurrentRow)
	end if
	*/
end if
end event

type cb_edit_map from commandbutton within tabpage_field_data
boolean visible = false
integer x = 2734
integer y = 20
integer width = 402
integer height = 84
integer taborder = 31
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Edit Mappings"
end type

event clicked;//openwithparm(w_import_mapping_edit,il_import_id)
end event

type dw_detail from u_dw within tabpage_field_data
event ue_keydown pbm_dwnkey
integer x = 800
integer y = 1240
integer width = 2203
integer height = 740
integer taborder = 90
boolean titlebar = true
string title = "Mapped Field Detail"
string dataobject = "d_import_map_detail"
boolean vscrollbar = false
end type

event ue_keydown;if Key = KeyDownArrow! or Key = KeyUpArrow! or Key = KeyPageUp! or Key = KeyPageDown! then 
	Return 1
else
	Return 0
end if
end event

event itemchanged;call super::itemchanged;//inherit
long ll_rec_id
long ll_FindRow
long ll_InsertRow
long ll_Null
string ls_Null
string ls_Value
string ls_FiledName
DataWindowChild ldwc_Child
DataWindowChild ldwc_FieldChild

SetNull(ls_Null)
SetNull(ll_Null)
this.AcceptText()

/////////////////////////////////////////////////////////////////////////////////////////////////
// Key field and ID field synchronization
/*
if (Lower(is_curr_table_name) = "pd_basic" or Lower(is_curr_table_name) = "ctx_basic_info") and (dwo.name = "key_field") then
	ll_FindRow = dw_prac_cont_id.Find("rec_id=" + String(this.object.rec_id[Row]), 1, dw_prac_cont_id.RowCount())
	if Data = "1" then
		if ll_FindRow <= 0 then
			ll_InsertRow = dw_prac_cont_id.InsertRow(0)
			dw_prac_cont_id.object.rec_id[ll_InsertRow] = this.object.rec_id[Row]
			dw_prac_cont_id.object.table_records_id[ll_InsertRow] = this.object.table_records_id[Row]
			dw_prac_cont_id.object.isoft_field_id[ll_InsertRow] = this.object.isoft_field_id[Row]
			dw_prac_cont_id.object.import_field_id[ll_InsertRow] = this.object.import_field_id[Row]
			dw_prac_cont_id.object.id_field[ll_InsertRow] = 1
			ll_FindRow = ll_InsertRow
		end if
		dw_prac_cont_id.ScrollToRow(ll_FindRow)
		this.Post SetItem(Row, "id_field", 1)
	else
		if ll_FindRow > 0 then dw_prac_cont_id.DeleteRow(ll_FindRow)
		this.Post SetItem(Row, "id_field", 0)
	end if
	Return 0
end if
*/

////////////////////////////////////////////////////////////////////////////////////////////////
// Specify item change
choose case dwo.name
	case "null_type"
		if Data = "2" then //Use text default
			this.Post SetColumn("null_value")
		else
			this.SetItem(Row, "null_value", ls_Null)
		end if
		if Data = "3" then //Use column value
			this.Post SetColumn("link_value")
		else
			this.SetItem(Row, "link_value", ll_Null)
		end if
		
	case "null_value"	
		if Lower(Trim(Data)) = "* select value *" then
			if of_SelectValue(ls_Value) = 1 then
				this.Post SetItem(Row, "null_value", ls_Value)
			else
				ls_Value = this.GetItemString(Row, "null_value", Primary!, true)
				this.Post SetItem(Row, "null_value", ls_Value)
			end if
		end if
		
	case "lu_template"
		if LenA(Data) > 0 then
			this.SetItem(Row, "lu_type", ls_Null)
			this.SetItem(Row, "lu_table", ls_Null)
			this.SetItem(Row, "lu_field_name", ls_Null)
		else			
			this.Post SetItem(Row, "lu_template", ll_Null)
			this.SetColumn("lu_type")
			this.Post SetFocus()
		end if
		
	case "lu_type"
		this.SetItem(Row, "lu_table", ls_Null)
		this.SetItem(Row, "lu_field_name", ls_Null)
		this.GetChild("lu_field_name", ldwc_FieldChild)
		choose case Data
			case "A" //Address
				this.GetChild("lu_table_dddw", ldwc_Child)
				ldwc_Child.Reset()
				ids_LookUpTableDDDW[1].RowsCopy(1, ids_LookUpTableDDDW[1].RowCount(), Primary!, ldwc_Child, 1, Primary!)
				ldwc_Child.InsertRow(1)
				ldwc_FieldChild.SetFilter("(lookup_type='A' and id<>1) or id=0")
			case "C" //Code
				this.GetChild("lu_table_dddw", ldwc_Child)
				ldwc_Child.Reset()
				ids_LookUpTableDDDW[2].RowsCopy(1, ids_LookUpTableDDDW[2].RowCount(), Primary!, ldwc_Child, 1, Primary!)
				ldwc_Child.InsertRow(1)
				ldwc_FieldChild.SetFilter("(lookup_type='C' and id<>1) or id=0")
			case "F" //Facility
				this.SetItem(Row, "lu_table", "Facility")
				ldwc_FieldChild.SetFilter("(lookup_type='F' and id<>1) or id=0")
			case "M" //Committee
				this.SetItem(Row, "lu_table", "Committee")
				ldwc_FieldChild.SetFilter("(lookup_type='M' and id<>1) or id=0")
			case "I"	//Company
				this.SetItem(Row, "lu_table", "Company")
				ldwc_FieldChild.SetFilter("(lookup_type='I' and id<>1) or id=0")
			case "S" //Active Status (V10.1 - Import Active Status)
				this.SetItem(Row, "lu_table", "Active Status")
				ldwc_FieldChild.SetFilter("(lookup_type='S' and id<>1) or id=0")
			case "Q" //QA Metrics (V11.3 QA Import)
				this.SetItem(Row, "lu_table", "QA Metrics")
				ldwc_FieldChild.SetFilter("(lookup_type='Q' and id<>1) or id=0")
		end choose
		ldwc_FieldChild.Filter()
		
	case "lu_table_dddw"
		this.SetItem(Row, "lu_field_name", ls_Null)
		
	case "facility_id"
		this.object.import_field_id[Row]	= ll_Null
		//ll_rec_id = this.object.rec_id[Row]
		//ll_FindRow = dw_prac_cont_id.Find("rec_id=" + String(ll_rec_id), 1, dw_prac_cont_id.RowCount())
		//if ll_FindRow > 0 then
		//	dw_prac_cont_id.object.import_field_id[ll_FindRow]	= ll_Null
		//end if
		
	//case "key_field"
		//if this.object.id_field[Row] = 1 and (is_curr_table_name <> "pd_basic" or is_curr_table_name <> "ctx_basic_info") then
		//	ls_FiledName = this.Describe("Evaluate('LookUpDisplay(isoft_field_id)', " + String(Row) + ")")
		//	MessageBox("Id Field", "The '" + ls_FiledName + "' field was not set as an Identification field, because it must belong to Basic Information table.")  //Start Code Change ----02.07.2008 #V8 maha - changed message
			
		//	this.Post SetItem(Row, "key_field", 0)
		//end if
	//---------Begin Added by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
	Case 'lu_field_name'
		If 	this.GetItemString(Row, "lu_table" ) =  "Company" Then
			If Data <> 'facility_name' Then
				MessageBox( 'Tips', 'When the value for Lu Type is “company” and the Lu field value is not “company name”, 	the system will ignore “no match procd” option.~r~n' + &
				'If the imported value does not match any value in company lookup, it will be written to the error log.' )
				
			End If			
		End If
	//---------End Added ------------------------------------------------------
end choose
end event

event clicked;call super::clicked;//inherit
DataWindowChild ldwc_Child

choose case dwo.name 
	case "link_value"
		this.GetChild("link_value", ldwc_Child)
		ldwc_Child.Reset()
		dw_field_list.RowsCopy(1, dw_field_list.RowCount(), Primary!, ldwc_Child, 1, Primary!)		
		
	case "lu_table_dddw"		
		this.GetChild("lu_table_dddw", ldwc_Child)	
		ldwc_Child.Reset()
		if this.object.lu_type[Row] = 'A' then		
			ids_LookUpTableDDDW[1].RowsCopy(1, ids_LookUpTableDDDW[1].RowCount(), Primary!, ldwc_Child, 1, Primary!)
		else
			ids_LookUpTableDDDW[2].RowsCopy(1, ids_LookUpTableDDDW[2].RowCount(), Primary!, ldwc_Child, 1, Primary!)
		end if
		ldwc_Child.InsertRow(1)				
end choose
end event

event rowfocuschanged;call super::rowfocuschanged;//Inherit
DataWindowChild ldwc_Child

if CurrentRow > 0 then
	this.GetChild("lu_field_name", ldwc_Child)
	choose case this.object.lu_type[CurrentRow]
		case "A" //Address
			ldwc_Child.SetFilter("(lookup_type='A' and id<>1) or id=0")
		case "C" //Code
			ldwc_Child.SetFilter("(lookup_type='C' and id<>1) or id=0")
		case "F" //Facility
			ldwc_Child.SetFilter("(lookup_type='F' and id<>1) or id=0")
		case "M" //Committee
			ldwc_Child.SetFilter("(lookup_type='M' and id<>1) or id=0")
		case "I"	//Company
			ldwc_Child.SetFilter("(lookup_type='I' and id<>1) or id=0")
		case "S" //Active Status (V10.1 - Import Active Status)
			ldwc_Child.SetFilter("(lookup_type='S' and id<>1) or id=0")
		case "Q" //QA Metrics (V11.3 QA Import)
			ldwc_Child.SetFilter("(lookup_type='Q' and id<>1) or id=0")
	end choose
	ldwc_Child.Filter()
	this.SetRedraw(true)
end if
end event

event constructor;call super::constructor;//inherit
DataWindowChild ldwc_Child

this.GetChild("lu_type", ldwc_Child)
ldwc_Child.InsertRow(1)
end event

event other;call super::other;if Message.WordParm = 61458 then 
	Message.Processed = true
	Message.ReturnValue = 0 
end if

if Message.Number = 522 then
	Return 1
end if
end event

event buttonclicked;call super::buttonclicked;long ll_lu_template

ll_lu_template = this.object.lu_template[Row]
if dwo.name = "b_viewlookups" then
	OpenWithParm(w_import_lookup_mapping, ll_lu_template)
end if
end event

type dw_map_fields from u_dw within tabpage_field_data
event ue_sysfield_dragdrop ( long al_row )
event ue_impfield_dragdrop ( long al_row )
string tag = "dw_map_fields"
integer x = 800
integer y = 488
integer width = 2203
integer height = 752
integer taborder = 80
string dragicon = "droparrow.ico"
boolean titlebar = true
string title = "Mapped Record Fields"
string dataobject = "d_import_mapping_fields"
boolean livescroll = false
end type

event ue_sysfield_dragdrop(long al_row);long ll_InsertRow
long ll_CurrentRow
long i, ll_FindRow
long ll_table_id
long ll_isoft_table_id
long ll_mapped_field_id
long ll_table_records_id
long ll_dv_field_id
string ls_field_name

// Get field ID and table ID
ll_table_id = dw_tables.object.table_id[dw_tables.GetRow()]
if dw_records.GetRow() > 0 then
	ll_isoft_table_id = dw_records.object.isoft_table_id[dw_records.GetRow()]
else
	ll_isoft_table_id = -1
end if

// Check field of drag whether already exists
if ll_table_id = ll_isoft_table_id then
	for i = 1 to il_SelectedCount
		ll_FindRow = dw_map_fields.Find("isoft_field_id=" + String(il_DragValue[i]), 1, dw_map_fields.RowCount())
		if ll_FindRow > 0 then
			dw_map_fields.ScrollToRow(ll_FindRow)
			dw_map_fields.SelectRow(0, false)
			dw_map_fields.SelectRow(ll_FindRow, true)
			MessageBox("Prompt", "The Intellisoft Field already exists.")
			Return
		end if
	next
end if

if ll_table_id = ll_isoft_table_id and al_Row > 0 then
	// Replace a mapped field record
	ll_dv_field_id = dw_fields.object.field_id[il_DragRow]	
	ll_mapped_field_id = dw_map_fields.object.rec_id[al_Row]
	ll_FindRow = dw_prac_cont_id.Find("rec_id=" + String(ll_mapped_field_id), 1, dw_prac_cont_id.RowCount())
	if ll_FindRow > 0 then 
		dw_prac_cont_id.object.isoft_field_id[ll_FindRow] = ll_dv_field_id
		dw_prac_cont_id.ScrollToRow(ll_FindRow)	
	end if
	
	//---------Begin Added by (Appeon)Stephen 03.16.2015 for V15.1-Import Improvements 2015--------
	if of_isg_key(ll_table_id, ll_dv_field_id) = 1 then
		dw_map_fields.object.key_field[al_row] = 1
	end if	
	//---------End Added ------------------------------------------------------
	
	dw_map_fields.object.isoft_field_id[al_Row] = ll_dv_field_id	
	if dw_map_fields.Update() = 1 then
		of_CompleteTrans(true)
	else
		of_CompleteTrans(false)
		MessageBox("Error", is_mapfield_errinfo, StopSign!)
	end if
else
	// Insert a import table record
	if ll_table_id <> ll_isoft_table_id then
		//---------Begin Modified by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
		//ll_InsertRow = dw_records.InsertRow(0)
		ll_InsertRow = of_GetInsertRow(ll_table_id)//added by gavins 20130222
		ll_InsertRow = dw_records.InsertRow(ll_InsertRow)//modify by gavins 0->ll_InsertRow
		//---------End Modfiied ------------------------------------------------------
		ll_CurrentRow = tab_1.tabpage_hdr.dw_browse.GetRow()
		dw_records.object.import_id[ll_InsertRow] = tab_1.tabpage_hdr.dw_browse.object.import_id[ll_CurrentRow]
		dw_records.object.isoft_table_id[ll_InsertRow] = ll_table_id
		dw_records.ScrollToRow(ll_InsertRow)
		dw_prac_cont_id.Reset()
		
		// Set sort number (25:pd_basic, 1001:ctx_basic_info)
		if ll_table_id = 25 or ll_table_id = 1001 then
			for i = 1 to dw_records.RowCount()
				dw_records.SetItem(i, "sort_no", i)
			next
			dw_records.SetItem(dw_records.GetRow(), "sort_no", 0)
			dw_records.Sort()
			dw_records.ScrollToRow(1)
		elseif ll_InsertRow > 1 then
			dw_records.SetItem(ll_InsertRow, "sort_no", dw_records.object.sort_no[ll_InsertRow - 1] + 1)
			//---------Begin Added by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
			for i = 1 to dw_records.RowCount()//modify by gavins 20130222
				dw_records.SetItem(i, "sort_no", i)
			next
			dw_records.Sort()
			dw_records.ScrollToRow(ll_InsertRow)
			//---------End Added ------------------------------------------------------
		else
			dw_records.SetItem(ll_InsertRow, "sort_no", 1)
		end if		
		
		// Update import table records
		if dw_records.Update() <> 1 then
			of_CompleteTrans(false)
			MessageBox("Error", is_mapfield_errinfo, StopSign!)
			Return
		end if
	end if
	ll_table_records_id = dw_records.object.table_records_id[dw_records.GetRow()]
	
	// Insert mapped field records
	for i = 1 to il_SelectedCount
		ll_InsertRow = dw_map_fields.InsertRow(0)
		dw_map_fields.object.table_records_id[ll_InsertRow] = ll_table_records_id
		dw_map_fields.object.isoft_field_id[ll_InsertRow] = il_DragValue[i]
		//---------Begin Added by (Appeon)Stephen 03.16.2015 for V15.1-Import Improvements 2015--------
		if of_isg_key(ll_table_id, il_DragValue[i]) = 1 then
			dw_map_fields.object.key_field[ll_InsertRow] = 1
		end if	
		//---------End Added ------------------------------------------------------
		dw_map_fields.object.id_field[ll_InsertRow] = 0		
	next 
	dw_map_fields.ScrollToRow(ll_InsertRow)
	 
	// Update mapped field records
	if dw_map_fields.Update() = 1 then
		of_CompleteTrans(true)
		dw_detail.SetRedraw(true)
	else
		of_CompleteTrans(false)
		MessageBox("Error", is_mapfield_errinfo, StopSign!)
	end if
end if
end event

event ue_impfield_dragdrop(long al_row);long ll_InsertRow
long ll_CurrentRow
long ll_FindRow
long ll_table_id
long ll_isoft_table_id
long ll_mapped_field_id
long ll_table_records_id
long ll_dv_import_field_id
long i, ll_Null

SetNull(ll_Null)
if dw_records.GetRow() <= 0 then
	MessageBox("Prompt", "There is no import table record.")
	Return	
end if

// Insert or replace a mapped field record
if al_Row > 0 then
	// Replace a mapped field record	
	ll_dv_import_field_id = dw_field_list.object.rec_id[il_DragRow]	
	ll_mapped_field_id = dw_map_fields.object.rec_id[al_Row]	
	ll_FindRow = dw_prac_cont_id.Find("rec_id=" + String(ll_mapped_field_id), 1, dw_prac_cont_id.RowCount())
	if ll_FindRow > 0 then
		dw_prac_cont_id.object.import_field_id[ll_FindRow] = ll_dv_import_field_id
		dw_prac_cont_id.ScrollToRow(ll_FindRow)
	end if
	dw_map_fields.object.import_field_id[al_Row] = ll_dv_import_field_id
	dw_map_fields.object.facility_id[al_Row] = ll_Null
	if dw_map_fields.Update() = 1 then
		of_CompleteTrans(true)
	else
		of_CompleteTrans(false)
		MessageBox("Error", is_mapfield_errinfo, StopSign!)
	end if
else
	// Insert a mapped field record
	for i = 1 to il_SelectedCount
		ll_InsertRow = dw_map_fields.InsertRow(0)
		ll_table_records_id = dw_records.object.table_records_id[dw_records.GetRow()]
		dw_map_fields.object.table_records_id[ll_InsertRow] = ll_table_records_id
		dw_map_fields.object.import_field_id[ll_InsertRow] = il_DragValue[i]
		dw_map_fields.object.id_field[ll_InsertRow] = 0		
	next
	dw_map_fields.ScrollToRow(ll_InsertRow)

	if dw_map_fields.Update() = 1 then
		of_CompleteTrans(true)
		dw_detail.SetRedraw(true)
	else
		of_CompleteTrans(false)
		MessageBox("Error", is_mapfield_errinfo, StopSign!)
	end if
end if
end event

event dberror;//override
is_mapfield_errinfo = SQLErrText

Return 1
end event

event rowfocuschanged;call super::rowfocuschanged;//inherit
dw_detail.ScrollToRow(CurrentRow)

end event

event dragwithin;call super::dragwithin;if Source.tag = "dw_fields" or Source.tag = "dw_field_list" then
	// Select row	
	if Row >0 then
		if not IsSelected(Row) then
			this.SelectRow(0, false)
			this.SelectRow(Row, true)
			this.ScrollToRow(Row)
		end if		
	else
		this.SelectRow(0, false)
	end if
end if
end event

event dragdrop;call super::dragdrop;if Source.tag = "dw_fields" then
	this.Event ue_sysfield_dragdrop(Row)
elseif Source.tag = "dw_field_list" then
	this.Event ue_impfield_dragdrop(Row)
end if
end event

event clicked;call super::clicked;//inherit
il_DragRow = Row
this.ScrollToRow(Row)
end event

event other;call super::other;if Message.WordParm = 61458 then 
	Message.Processed = true
	Message.ReturnValue = 0 
end if
end event

event getfocus;call super::getfocus;//inherit
//of_SetMappedDWTitle(2)
end event

event doubleclicked;call super::doubleclicked;if not ib_LockFile and Row > 0 then
	if MessageBox("Prompt", "Are you sure you want to delete the record?", Question!, YesNo!) = 1 then
		il_DragRow = Row
		dw_fields.Event ue_DragDrop(this.tag)
	end if
end if
end event

event constructor;call super::constructor;//Inherit
this.of_SetRowSelect(true)
//this.DragIcon = gs_current_path + "\row.ico"   //Start Code Change ----08.14.2013 #V14 maha
end event

event mousemove;call super::mousemove;of_BeginDrag(this)
end event

type dw_records from u_dw within tabpage_field_data
event ue_dragdrop ( long al_row )
string tag = "dw_records"
integer x = 800
integer y = 8
integer width = 2203
integer height = 480
integer taborder = 80
string dragicon = "droparrow.ico"
boolean titlebar = true
string title = "Import Table Records"
string dataobject = "d_import_table_list"
boolean resizable = true
end type

event ue_dragdrop(long al_row);long ll_InsertRow
long i, ll_RowCount
long ll_dv_table_id

ll_dv_table_id = dw_tables.object.table_id[il_DragRow]

//---------Begin Commented by (Appeon)Stephen 05.31.2013 for Bug 4060: Issue with an Import--------
/*
//---------Begin Added by (Appeon)Harry 03.26.2014 for V142 ISG-CLX--------
Long ll_findrow
ll_findrow = this.find("isoft_table_id="+string(ll_dv_table_id), 1, this.rowcount())
if ll_findrow > 0 then
	this.setrow(ll_findrow)
	this.scrolltorow(ll_findrow)
	return
end if
//---------End Added ------------------------------------------------------
*/
//---------End Commented ------------------------------------------------------

Parent.SetRedraw(false)

// Insert a import table record
ll_InsertRow = of_GetInsertRow(ll_dv_table_id)
ll_InsertRow = this.InsertRow(ll_InsertRow)
this.object.isoft_table_id[ll_InsertRow] = ll_dv_table_id
this.object.import_id[ll_InsertRow] = il_curr_import_id
this.ScrollToRow(ll_InsertRow)

// Set sort number
for i = 1 to this.RowCount()
	this.SetItem(i, "sort_no", i)
next

// Update import table records
if this.Update() <> 1 then
	of_CompleteTrans(false)
	Parent.SetRedraw(true)
	MessageBox("Error", is_mapfield_errinfo, StopSign!)
	Return
end if
this.Event RowFocusChanged(this.GetRow())

// Update mapped record fields
if dw_map_fields.Update() = 1 then
	of_CompleteTrans(true)
else
	of_CompleteTrans(false)
	Parent.SetRedraw(true)
	MessageBox("Error", is_mapfield_errinfo, StopSign!)
end if

Parent.SetRedraw(true)
end event

event rowfocuschanged;call super::rowfocuschanged;//inherit
long ll_FindRow
long ll_isoft_table_id
long ll_table_records_id
string ls_table_name_allias
DataWindowChild ldwc_Child

if CurrentRow >0 then
	this.SelectRow(0, false)
	this.SelectRow(CurrentRow, true)
	
	// Filter Mapped record fields
	ll_table_records_id = this.object.table_records_id[CurrentRow]
	if IsNull(ll_table_records_id) then
		dw_map_fields.SetFilter("1 <> 1")
	else
		dw_map_fields.SetFilter("table_records_id = " + String(ll_table_records_id))
	end if
	dw_map_fields.Filter()
	dw_map_fields.ScrollToRow(1)
	dw_map_fields.Event RowFocusChanged(1)
	
	// Filter Provider Identification Field(s)
	/*
	dw_prac_cont_id.SetRedraw(false)
	dw_prac_cont_id.Reset()
	dw_map_fields.RowsCopy(1, dw_map_fields.RowCount(), Primary!, dw_prac_cont_id, 1, Primary!)	
	dw_prac_cont_id.SetFilter("id_field = 1")
	dw_prac_cont_id.Filter()
	dw_prac_cont_id.SetRedraw(true)
	*/
	
	// Set IntelliSoft Table display name in dw_detail
	ll_isoft_table_id = this.object.isoft_table_id[CurrentRow]
	if not IsNull(ll_isoft_table_id) then
		ll_FindRow = dw_tables.Find("table_id=" + String(ll_isoft_table_id), 1, dw_tables.RowCount())
		if ll_FindRow > 0 then
			ls_table_name_allias = dw_tables.object.table_name_allias[ll_FindRow]
			dw_detail.object.t_intellisoft_table.text = ls_table_name_allias			
			is_curr_table_name = Lower(dw_tables.object.table_name[ll_FindRow]) // Get current table_name
			dw_tables.ScrollToRow(ll_FindRow)
		end if
	end if
	if ll_FindRow <= 0 then
		dw_detail.object.t_intellisoft_table.text = ""
		is_curr_table_name = ""
	end if
	
	//	Set null_value list of dw_detail
	dw_detail.GetChild("null_value", ldwc_Child)
	choose case is_curr_table_name
		case "pd_address", "pd_hosp_affil", "pd_board_specialty"
			if is_curr_table_name = "pd_address" then
				ldwc_Child.SetFilter("lookup_name in ('* Select Value *', '* NULL *', 'Address Type')")
			else
				ldwc_Child.SetFilter("lookup_name in ('* Select Value *', '* NULL *', 'Yes/No')")
			end if
		case else
			ldwc_Child.SetFilter("lookup_name in ('* Select Value *', '* NULL *')")
	end choose
	ldwc_Child.Filter()
	
	// Set facility_id of dw_detail enabled
	choose case is_curr_table_name
		case "pd_affil_stat", "pd_address", "pd_hosp_affil", "pd_board_specialty"
			dw_detail.object.facility_id.protect = 0
			dw_detail.object.facility_id.background.color = 16777215
		case else
			dw_detail.object.facility_id.protect = 1
			dw_detail.object.facility_id.background.color = 67108864
	end choose
else
	dw_map_fields.SetFilter("1 <> 1")
	dw_map_fields.Filter()
	//dw_prac_cont_id.Reset()
end if
end event

event dragdrop;call super::dragdrop;if Source.tag = "dw_tables" then
	this.Event ue_DragDrop(Row)
end if
end event

event dragwithin;call super::dragwithin;/*
if Source.tag = "dw_tables" then
	// Select row	
	if Row >0 then
		if not IsSelected(Row) then
			this.SelectRow(0, false)
			this.SelectRow(Row, true)
		end if		
	else
		this.SelectRow(0, false)
	end if
end if
*/
end event

event dberror;//override
is_mapfield_errinfo = SQLErrText

Return 1
end event

event clicked;call super::clicked;//inherit
long ll_table_id

il_DragRow = Row
if dwo.name = "p_1" or dwo.name = "p_2" then //V10.1 - Import Link Value
	ll_table_id = this.object.isoft_table_id[Row]
	if ll_table_id = 2 or ll_table_id = 9 or ll_table_id = 20 then
		this.SetRow(Row)
		OpenWithParm(w_import_linkvalue_setting, this)
	end if
end if
end event

event other;call super::other;if Message.WordParm = 61458 then 
	Message.Processed = true
	Message.ReturnValue = 0 
end if
end event

event doubleclicked;call super::doubleclicked;if not ib_LockFile and Row > 0 then
	if MessageBox("Prompt", "Are you sure you want to delete the record?", Question!, YesNo!) = 1 then
		il_DragRow = Row
		dw_tables.Event ue_DragDrop()
	end if
elseif row = 0 then //Start Code Change ----02.04.2008 #V8 maha
	if this.height < 400 then
		this.height = 768
	else
		this.height = 396
	end if
end if
end event

event constructor;call super::constructor;//Inherit
//this.DragIcon = gs_current_path + "\row.ico"   //Start Code Change ----08.14.2013 #V14 maha
end event

event mousemove;call super::mousemove;of_BeginDrag(this)
end event

type dw_fields from u_dw within tabpage_field_data
event ue_dragdrop ( string as_dw )
string tag = "dw_fields"
integer x = 5
integer y = 628
integer width = 736
integer height = 1352
integer taborder = 80
string dragicon = "droparrow.ico"
boolean titlebar = true
string title = "IntelliSoft Fields"
string dataobject = "d_import_intellisoftfields"
end type

event ue_dragdrop(string as_dw);long ll_DeleteRow
long ll_dv_mapped_field_id

if as_dw = "dw_prac_cont_id" then
	ll_dv_mapped_field_id = dw_prac_cont_id.object.rec_id[il_DragRow]
elseif as_dw = "dw_map_fields" then
	ll_dv_mapped_field_id = dw_map_fields.object.rec_id[il_DragRow]
else
	Return
end if

ll_DeleteRow = dw_prac_cont_id.Find("rec_id=" + String(ll_dv_mapped_field_id), 1, dw_prac_cont_id.RowCount())
if ll_DeleteRow > 0 then dw_prac_cont_id.DeleteRow(ll_DeleteRow)

ll_DeleteRow = dw_map_fields.Find("rec_id=" + String(ll_dv_mapped_field_id), 1, dw_map_fields.RowCount())
if ll_DeleteRow > 0 then dw_map_fields.DeleteRow(ll_DeleteRow)
dw_detail.ScrollToRow(dw_map_fields.GetRow())

if dw_map_fields.Update() = 1 then
	of_CompleteTrans(true)
else
	of_CompleteTrans(false)
	MessageBox("Error", is_mapfield_errinfo, StopSign!)
end if
end event

event dragdrop;call super::dragdrop;this.Event ue_DragDrop(Source.tag)
end event

event clicked;call super::clicked;//inherit
long i

il_DragRow = Row
il_SelectedCount = 0

for i = 1 to this.RowCount()
	if this.IsSelected(i) then
		il_SelectedCount ++
		il_DragValue[il_SelectedCount] = this.object.field_id[i]
	end if
next
end event

event other;call super::other;if Message.WordParm = 61458 then 
	Message.Processed = true
	Message.ReturnValue = 0 
end if
end event

event constructor;call super::constructor;//Inherit
this.of_SetRowSelect(true)
inv_RowSelect.of_SetStyle(inv_RowSelect.EXTENDED)
//this.DragIcon = gs_current_path + "\row.ico"   //Start Code Change ----08.14.2013 #V14 maha
end event

event doubleclicked;call super::doubleclicked;if not ib_LockFile and Row > 0 then
	il_DragRow = Row
	if ii_CurrMappedDW = 1 then
		dw_prac_cont_id.Event ue_sysfield_dragdrop(0)
	else
		dw_map_fields.Event ue_sysfield_dragdrop(0)
	end if
end if
end event

event mousemove;call super::mousemove;of_BeginDrag(this)
end event

type dw_tables from u_dw within tabpage_field_data
event ue_dragdrop ( )
string tag = "dw_tables"
integer x = 5
integer y = 8
integer width = 736
integer height = 620
integer taborder = 70
string dragicon = "droparrow.ico"
boolean titlebar = true
string title = "IntelliSoft Tables"
string dataobject = "d_import_intellisofttables"
end type

event ue_dragdrop();long ll_DeleteRow
long ll_CurrentRow
long ll_dv_table_records_id

// Delete import table records and mapped record fields
ll_dv_table_records_id = dw_records.object.table_records_id[il_DragRow]

ll_DeleteRow = dw_records.Find("table_records_id=" + String(ll_dv_table_records_id), 1, dw_records.RowCount())
if ll_DeleteRow <= 0 then Return

dw_map_fields.SetFilter("table_records_id = " + String(ll_dv_table_records_id))
dw_map_fields.Filter()
dw_map_fields.RowsMove(1, dw_map_fields.RowCount(), Primary!, dw_map_fields, 1, Delete!)

dw_records.DeleteRow(ll_DeleteRow)
if dw_records.GetSelectedRow(1) <= 0 then
	dw_records.SelectRow(dw_records.GetRow(), true)
end if

// Update all
if dw_records.Update() <> 1 then
	of_CompleteTrans(false)
	MessageBox("Error", is_mapfield_errinfo, StopSign!)
	Return
end if

if dw_map_fields.Update() = 1 then
	of_CompleteTrans(true)
else
	of_CompleteTrans(false)
	MessageBox("Error", is_mapfield_errinfo, StopSign!)
end if

// Filter dw_prac_cont_id and mapped fields
dw_records.Event RowFocusChanged(dw_records.GetRow())
end event

event rowfocuschanged;call super::rowfocuschanged;//inherit
string ls_Filter

//if Current row less than 1
if CurrentRow <= 0 then
	dw_fields.SetFilter("1 <> 1")
	dw_fields.Filter()
	Return
end if
this.SelectRow(0, false)
this.SelectRow(CurrentRow, true)

//Filter data of dw_fields
if ii_curr_isoft_module = 1 then
	//IntelliCred/App module
	ls_Filter = "table_id = " + String(this.object.table_id[CurrentRow])
	//ls_Filter += " AND Lower(field_name) not in ('rec_id','prac_id','seq_no', 'lookup_code', 'gp_id', 'qam_id')" //V11.3 QA Import//Commented by (Appeon)Stephen 03.13.2015 - V15.1-Import Improvements 2015
	
//---------Begin Added by (Appeon)Stephen 12.23.2013 for V141 Import Modifications for Facility and Group--------
elseif ii_curr_isoft_module = 3 then
	ls_Filter = "table_id = " + String(this.object.table_id[CurrentRow])
	//ls_Filter += " AND Lower(field_name) not in ('facility_id', 'rec_id')" //Commented by (Appeon)Stephen 03.13.2015 - V15.1-Import Improvements 2015
//---------End Added ------------------------------------------------------
elseif  ii_curr_isoft_module = 2 then
	//IntelliContract module
	ls_Filter = of_GetContractFieldFilter(this)
end if
dw_fields.SetFilter(ls_Filter)
dw_fields.Filter()

dw_fields.SetRow(1)
dw_fields.SelectRow(0, false)
dw_fields.SelectRow(1, true)
end event

event dragdrop;call super::dragdrop;if Source.tag = "dw_records" then 
	this.Event ue_DragDrop()
end if
end event

event clicked;call super::clicked;//inherit
il_DragRow = Row
end event

event other;call super::other;if Message.WordParm = 61458 then 
	Message.Processed = true
	Message.ReturnValue = 0 
end if
end event

event doubleclicked;call super::doubleclicked;if not ib_LockFile and Row > 0 then
	il_DragRow = Row
	dw_records.Event ue_DragDrop(0)
end if
end event

event constructor;call super::constructor;//Inherit
//this.DragIcon = gs_current_path + "\row.ico"   //Start Code Change ----08.14.2013 #V14 maha
end event

event mousemove;call super::mousemove;of_BeginDrag(this)
end event

type ln_1 from line within tabpage_field_data
long linecolor = 16711680
integer linethickness = 8
integer beginx = 736
integer beginy = 244
integer endx = 795
integer endy = 244
end type

type ln_2 from line within tabpage_field_data
boolean visible = false
long linecolor = 16711680
integer linethickness = 8
integer beginx = 741
integer beginy = 748
integer endx = 800
integer endy = 696
end type

type ln_4 from line within tabpage_field_data
boolean visible = false
long linecolor = 16711680
integer linethickness = 8
integer beginx = 2994
integer beginy = 524
integer endx = 3054
integer endy = 464
end type

type ln_5 from line within tabpage_field_data
long linecolor = 16711680
integer linethickness = 8
integer beginx = 3003
integer beginy = 892
integer endx = 3054
integer endy = 840
end type

type ln_3 from line within tabpage_field_data
long linecolor = 16711680
integer linethickness = 8
integer beginx = 741
integer beginy = 1144
integer endx = 800
integer endy = 1092
end type

type dw_imp_field_detail from u_dw within tabpage_field_data
event ue_keydown pbm_dwnkey
integer x = 3054
integer y = 1092
integer width = 946
integer height = 788
integer taborder = 90
boolean bringtotop = true
boolean titlebar = true
string title = "Import Field Detail"
string dataobject = "d_import_field_detail"
boolean vscrollbar = false
end type

event ue_keydown;if Key = KeyDownArrow! or Key = KeyUpArrow! or Key = KeyPageUp! or Key = KeyPageDown! then 
	Return 1
else
	Return 0
end if
end event

event itemchanged;call super::itemchanged;//inherit
long ll_FindRow
string ls_Null
string ls_Value
string ls_FindCriteria

SetNull(ls_Null)

choose case dwo.name
	case "imp_field_name"
		ls_FindCriteria = "Lower(imp_field_name)='" + Lower(Data) + "'"
		ll_FindRow = this.Find(ls_FindCriteria, 1, Row - 1)
		if ll_FindRow <= 0 then
			ll_FindRow = this.Find(ls_FindCriteria, Row + 1, RowCount())
		end if
		if ll_FindRow > 0 then
			this.Post SetItem(Row, "imp_field_name", "")
			this.Post SetColumn("imp_field_name")
			this.Post SetFocus()
		end if
		
	case "default_value"	
		if Lower(Trim(Data)) = "* select value *" then
			if of_SelectValue(ls_Value) = 1 then
				this.Post SetItem(Row, "default_value", ls_Value)
			else
				ls_Value = this.GetItemString(Row, "default_value", Primary!, true)
				this.Post SetItem(Row, "default_value", ls_Value)
			end if
		elseif Lower(Trim(Data)) = "* null *" then
			this.Post SetItem(Row, "default_value", ls_Null)
		end if
end choose
end event

event other;call super::other;if Message.WordParm = 61458 then 
	Message.Processed = true
	Message.ReturnValue = 0 
end if
end event

type dw_field_list from u_dw within tabpage_field_data
string tag = "dw_field_list"
integer x = 3054
integer y = 4
integer width = 946
integer height = 1084
integer taborder = 80
string dragicon = "droparrow.ico"
boolean bringtotop = true
boolean titlebar = true
string title = "Import Fields"
string dataobject = "d_import_fields"
end type

event rowfocuschanged;call super::rowfocuschanged;//inherit
string ls_comp_def

if CurrentRow > 0 then
	dw_imp_field_detail.ScrollToRow(CurrentRow)
	
	ls_comp_def = Trim(this.object.comp_def[CurrentRow])
	if IsNull(ls_comp_def) then ls_comp_def = ""
	if ib_LockFile or LenA(ls_comp_def) > 0 then
		cb_create_value_list.Enabled = false
	else
		cb_create_value_list.Enabled = true
	end if
end if
end event

event dragenter;call super::dragenter;tab_1.tabpage_field_data.Event ue_save()
end event

event dberror;//override
is_mapfield_errinfo = SQLErrText

Return 1
end event

event dragdrop;call super::dragdrop;long ll_DeleteRow
long ll_dv_mapped_field_id

if Source.tag = "dw_prac_cont_id" then
	ll_dv_mapped_field_id = dw_prac_cont_id.object.rec_id[il_DragRow]
elseif Source.tag = "dw_map_fields" then
	ll_dv_mapped_field_id = dw_map_fields.object.rec_id[il_DragRow]
else
	Return
end if

ll_DeleteRow = dw_prac_cont_id.Find("rec_id=" + String(ll_dv_mapped_field_id), 1, dw_prac_cont_id.RowCount())
if ll_DeleteRow > 0 then dw_prac_cont_id.DeleteRow(ll_DeleteRow)

ll_DeleteRow = dw_map_fields.Find("rec_id=" + String(ll_dv_mapped_field_id), 1, dw_map_fields.RowCount())
if ll_DeleteRow > 0 then dw_map_fields.DeleteRow(ll_DeleteRow)
dw_detail.ScrollToRow(dw_map_fields.GetRow())

if dw_map_fields.Update() = 1 then
	of_CompleteTrans(true)
else
	of_CompleteTrans(false)
	MessageBox("Error", is_mapfield_errinfo, StopSign!)
end if
end event

event clicked;call super::clicked;//inherit
long i

il_DragRow = Row
il_SelectedCount = 0

for i = 1 to this.RowCount()
	if this.IsSelected(i) then
		il_SelectedCount ++
		il_DragValue[il_SelectedCount] = this.object.rec_id[i]
	end if
next
end event

event buttonclicked;call super::buttonclicked;integer li_Return

choose case dwo.name
	case "b_add"
		Event pfc_cst_add()
	case "b_delete"
		Event pfc_cst_delete()
	case "b_compare"
		li_Return = tab_1.tabpage_field_data.Event ue_save()
		if li_Return = 1 then
			Open(w_import_comparefield)
		end if
end choose
end event

event other;call super::other;if Message.WordParm = 61458 then 
	Message.Processed = true
	Message.ReturnValue = 0 
end if
end event

event constructor;call super::constructor;//inherit
this.of_SetRowSelect(true)
inv_RowSelect.of_SetStyle(inv_RowSelect.EXTENDED)
//this.DragIcon = gs_current_path + "\row.ico"   //Start Code Change ----08.14.2013 #V14 maha
end event

event doubleclicked;call super::doubleclicked;if not ib_LockFile and Row > 0 then
	il_DragRow = Row
	if ii_CurrMappedDW = 1 then
		dw_prac_cont_id.Event ue_impfield_dragdrop(0)
	else
		dw_map_fields.Event ue_impfield_dragdrop(0)
	end if
end if
end event

event mousemove;call super::mousemove;of_BeginDrag(this)
end event

type dw_compute_verify from datawindow within tabpage_field_data
boolean visible = false
integer x = 4343
integer y = 2460
integer width = 169
integer height = 88
integer taborder = 100
boolean bringtotop = true
string title = "none"
string dataobject = "d_import_compute_syntax"
boolean hscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_prac_cont_id from u_dw within tabpage_field_data
event ue_sysfield_dragdrop ( long al_row )
event ue_impfield_dragdrop ( long al_row )
string tag = "dw_prac_cont_id"
boolean visible = false
integer x = 800
integer y = 404
integer width = 2203
integer height = 372
integer taborder = 90
string dragicon = "droparrow.ico"
boolean bringtotop = true
boolean titlebar = true
string title = "Provider Identification Fields (must be from Basic Information table)"
string dataobject = "d_import_mapping_prac_cont"
end type

event ue_sysfield_dragdrop(long al_row);long ll_InsertRow
long ll_CurrentRow
long ll_FindRow
long ll_table_id
long ll_isoft_table_id
long ll_mapped_field_id
long ll_table_records_id
long ll_dv_field_id
string ls_table_name

if dw_records.RowCount() <= 0 then
	MessageBox("Prompt", "There is no import table record.")
	Return	
end if

// Verify table name
ls_table_name = Lower(dw_tables.object.table_name[dw_tables.GetRow()])
if dw_records.RowCount() > 0 and is_curr_table_name <> "pd_basic" and is_curr_table_name <> "ctx_basic_info" then
	MessageBox("ID field", "ID field is not required for selected import table.")
	Return
end if
if ls_table_name <> "pd_basic" and ls_table_name <> "ctx_basic_info" then
	MessageBox("ID field", "ID fields must be from the Basic Information table.") //Start Code Change ----02.07.2008 #V8 maha - modified message
	Return	
end if

ll_dv_field_id = dw_fields.object.field_id[il_DragRow]
ll_FindRow = dw_prac_cont_id.Find("isoft_field_id=" + String(ll_dv_field_id), 1, dw_prac_cont_id.RowCount())
if ll_FindRow > 0 then
	dw_prac_cont_id.ScrollToRow(ll_FindRow)
	MessageBox("Prompt", "The Intellisoft Field already exists.")
	Return
end if

// Get table ID
ll_table_id = dw_tables.object.table_id[dw_tables.GetRow()]
if dw_records.GetRow() > 0 then
	ll_isoft_table_id = dw_records.object.isoft_table_id[dw_records.GetRow()]
else
	ll_isoft_table_id = -1
end if

// Insert or replace a mapped field record
if al_Row > 0 then
	// Replace a mapped field record
	dw_prac_cont_id.object.isoft_field_id[al_Row] = ll_dv_field_id
	ll_mapped_field_id = dw_prac_cont_id.object.rec_id[al_Row]	
	ll_FindRow = dw_map_fields.Find("rec_id=" + String(ll_mapped_field_id), 1, dw_map_fields.RowCount())
	if ll_FindRow > 0 then
		dw_map_fields.object.isoft_field_id[ll_FindRow] = ll_dv_field_id
		if Lower(is_curr_table_name) = "pd_basic" or Lower(is_curr_table_name) = "ctx_basic_info" then
			dw_map_fields.object.key_field[ll_FindRow] = 1
		end if
		dw_map_fields.ScrollToRow(ll_FindRow)
		if dw_map_fields.Update() = 1 then
			of_CompleteTrans(true)
		else
			of_CompleteTrans(false)
			MessageBox("Error", is_mapfield_errinfo, StopSign!)
		end if
	end if
else
	// Insert a import table record
	if dw_records.GetRow() <= 0 then
		ll_InsertRow = dw_records.InsertRow(0)
		ll_CurrentRow = tab_1.tabpage_hdr.dw_browse.GetRow()
		dw_records.object.import_id[ll_InsertRow] = tab_1.tabpage_hdr.dw_browse.object.import_id[ll_CurrentRow]
		dw_records.object.isoft_table_id[ll_InsertRow] = ll_table_id
		dw_records.ScrollToRow(ll_InsertRow)
		if dw_records.Update() <> 1 then
			of_CompleteTrans(false)
			MessageBox("Error", is_mapfield_errinfo, StopSign!)
			Return
		end if
		dw_records.Event RowFocusChanged(ll_InsertRow)
	end if
		
	// Insert a mapped field record
	ll_InsertRow = dw_prac_cont_id.InsertRow(0)
	ll_table_records_id = dw_records.object.table_records_id[dw_records.GetRow()]
	dw_prac_cont_id.object.table_records_id[ll_InsertRow] = ll_table_records_id
	dw_prac_cont_id.object.isoft_field_id[ll_InsertRow] = ll_dv_field_id
	dw_prac_cont_id.object.id_field[ll_InsertRow] = 1
	dw_prac_cont_id.ScrollToRow(ll_InsertRow)
	
	ll_FindRow = dw_map_fields.Find("isoft_field_id=" + String(ll_dv_field_id), 1, dw_map_fields.RowCount())
	if ll_FindRow > 0 then
		dw_map_fields.object.id_field[ll_FindRow] = 1
		dw_prac_cont_id.object.import_field_id[ll_InsertRow] = dw_map_fields.object.import_field_id[ll_FindRow]
		dw_map_fields.ScrollToRow(ll_FindRow)
		ll_InsertRow = ll_FindRow
	else
		ll_InsertRow = dw_map_fields.InsertRow(0)
		dw_map_fields.object.table_records_id[ll_InsertRow] = ll_table_records_id
		dw_map_fields.object.isoft_field_id[ll_InsertRow] = ll_dv_field_id
		dw_map_fields.object.id_field[ll_InsertRow] = 1
		dw_map_fields.ScrollToRow(ll_InsertRow)
	end if
	if is_curr_table_name = "pd_basic" or is_curr_table_name = "ctx_basic_info" then
		dw_map_fields.object.key_field[ll_InsertRow] = 1
	end if
		
	if dw_map_fields.Update() = 1 then
		of_CompleteTrans(true)
		dw_prac_cont_id.object.rec_id[dw_prac_cont_id.GetRow()] = dw_map_fields.object.rec_id[dw_map_fields.GetRow()]
		dw_detail.SetRedraw(true)
	else
		of_CompleteTrans(false)		
		MessageBox("Error", is_mapfield_errinfo, StopSign!)
	end if	
end if
end event

event ue_impfield_dragdrop(long al_row);long ll_InsertRow
long ll_CurrentRow
long ll_FindRow
long ll_table_id
long ll_isoft_table_id
long ll_mapped_field_id
long ll_table_records_id
long ll_dv_import_field_id
string ls_table_name

if dw_records.RowCount() <= 0 then
	MessageBox("Prompt", "There is no import table record.")
	Return	
end if

// Verify table name
ll_dv_import_field_id = dw_field_list.object.rec_id[il_DragRow]
ls_table_name = Lower(dw_tables.object.table_name[dw_tables.GetRow()])
if is_curr_table_name <> "pd_basic" and is_curr_table_name <> "ctx_basic_info" then
	MessageBox("ID field", "ID field is not required for selected import table.")
	Return
end if

// Insert or replace a mapped field record
if al_Row > 0 then
	// Replace a mapped field record
	dw_prac_cont_id.object.import_field_id[al_Row] = ll_dv_import_field_id
	ll_mapped_field_id = dw_prac_cont_id.object.rec_id[al_Row]	
	ll_FindRow = dw_map_fields.Find("rec_id=" + String(ll_mapped_field_id), 1, dw_map_fields.RowCount())
	if ll_FindRow > 0 then
		dw_map_fields.object.import_field_id[ll_FindRow] = ll_dv_import_field_id
		dw_map_fields.ScrollToRow(ll_FindRow)
		if dw_map_fields.Update() = 1 then
			of_CompleteTrans(true)
		else
			of_CompleteTrans(false)
			MessageBox("Error", is_mapfield_errinfo, StopSign!)
		end if
	end if
else	
	// Insert a mapped field record	
	ll_InsertRow = dw_prac_cont_id.InsertRow(0)
	ll_table_records_id = dw_records.object.table_records_id[dw_records.GetRow()]
	dw_prac_cont_id.object.table_records_id[ll_InsertRow] = ll_table_records_id
	dw_prac_cont_id.object.import_field_id[ll_InsertRow] = ll_dv_import_field_id
	dw_prac_cont_id.object.id_field[ll_InsertRow] = 1
	dw_prac_cont_id.ScrollToRow(ll_InsertRow)
	
	ll_InsertRow = dw_map_fields.InsertRow(0)
	dw_map_fields.object.table_records_id[ll_InsertRow] = ll_table_records_id
	dw_map_fields.object.import_field_id[ll_InsertRow] = ll_dv_import_field_id
	dw_map_fields.object.id_field[ll_InsertRow] = 1
	dw_map_fields.ScrollToRow(ll_InsertRow)
	if is_curr_table_name = "pd_basic" or is_curr_table_name = "ctx_basic_info" then
		dw_map_fields.object.key_field[ll_InsertRow] = 1
	end if
	
	if dw_map_fields.Update() = 1 then
		of_CompleteTrans(true)
		dw_prac_cont_id.object.rec_id[dw_prac_cont_id.GetRow()] = dw_map_fields.object.rec_id[dw_map_fields.GetRow()]
		dw_detail.SetRedraw(true)
	else
		of_CompleteTrans(false)		
		MessageBox("Error", is_mapfield_errinfo, StopSign!)
	end if	
end if
end event

event dragwithin;call super::dragwithin;if Source.tag = "dw_fields" then	
	dw_fields.SelectRow(0, false)
	dw_fields.SelectRow(il_DragRow, true)
elseif Source.tag = "dw_field_list" then
	dw_field_list.SelectRow(0, false)
	dw_field_list.SelectRow(il_DragRow, true)	
end if

// Select row
if Source.tag = "dw_fields" or Source.tag = "dw_field_list" then		
	if Row >0 then
		if not IsSelected(Row) then
			this.SelectRow(0, false)
			this.SelectRow(Row, true)
		end if		
	else
		this.SelectRow(0, false)
	end if
end if
end event

event dragdrop;call super::dragdrop;if Source.tag = "dw_fields" then
	this.Event ue_sysfield_dragdrop(Row)
elseif Source.tag = "dw_field_list" then
	this.Event ue_impfield_dragdrop(Row)
end if
end event

event clicked;call super::clicked;//inherit
il_DragRow = Row
end event

event other;call super::other;if Message.WordParm = 61458 then 
	Message.Processed = true
	Message.ReturnValue = 0 
end if
end event

event getfocus;call super::getfocus;//inherit
//of_SetMappedDWTitle(1)
end event

event constructor;call super::constructor;//Inherit
this.of_SetRowSelect(true)

end event

event doubleclicked;call super::doubleclicked;if not ib_LockFile and Row > 0 then
	if MessageBox("Prompt", "Are you sure you want to delete the record?", Question!, YesNo!) = 1 then
		il_DragRow = Row
		dw_fields.Event ue_DragDrop(this.tag)
	end if
end if
end event

event mousemove;call super::mousemove;of_BeginDrag(this)
end event

type tabpage_data from userobject within tab_1
event ue_init ( )
event ue_resize ( )
integer x = 18
integer y = 100
integer width = 4018
integer height = 2040
boolean enabled = false
long backcolor = 33551856
string text = "Data"
long tabtextcolor = 33554432
long tabbackcolor = 79680469
long picturemaskcolor = 12632256
dw_preprocess dw_preprocess
gb_operation gb_operation
cb_filter cb_filter
cb_sort cb_sort
cb_get_saved cb_get_saved
cb_savedata cb_savedata
cbx_store_temp cbx_store_temp
cb_imp_pro cb_imp_pro
cb_imp_data cb_imp_data
cb_pp_run cb_pp_run
dw_imp_data dw_imp_data
end type

event ue_resize();dw_imp_data.Width = this.Width - 10
dw_imp_data.Height = this.Height - dw_imp_data.Y - 10
gb_operation.Width = dw_imp_data.Width - 5
end event

on tabpage_data.create
this.dw_preprocess=create dw_preprocess
this.gb_operation=create gb_operation
this.cb_filter=create cb_filter
this.cb_sort=create cb_sort
this.cb_get_saved=create cb_get_saved
this.cb_savedata=create cb_savedata
this.cbx_store_temp=create cbx_store_temp
this.cb_imp_pro=create cb_imp_pro
this.cb_imp_data=create cb_imp_data
this.cb_pp_run=create cb_pp_run
this.dw_imp_data=create dw_imp_data
this.Control[]={this.dw_preprocess,&
this.gb_operation,&
this.cb_filter,&
this.cb_sort,&
this.cb_get_saved,&
this.cb_savedata,&
this.cbx_store_temp,&
this.cb_imp_pro,&
this.cb_imp_data,&
this.cb_pp_run,&
this.dw_imp_data}
end on

on tabpage_data.destroy
destroy(this.dw_preprocess)
destroy(this.gb_operation)
destroy(this.cb_filter)
destroy(this.cb_sort)
destroy(this.cb_get_saved)
destroy(this.cb_savedata)
destroy(this.cbx_store_temp)
destroy(this.cb_imp_pro)
destroy(this.cb_imp_data)
destroy(this.cb_pp_run)
destroy(this.dw_imp_data)
end on

type dw_preprocess from u_dw within tabpage_data
event ue_modifystyle ( )
event ue_settitle ( long al_rowcount )
boolean visible = false
integer x = 174
integer y = 248
integer width = 553
integer height = 332
integer taborder = 120
string dataobject = "d_import_pre_process_browse"
boolean vscrollbar = false
boolean livescroll = false
end type

event ue_modifystyle();string ls_Name
string ls_Style
integer ll_PosX
integer i, li_FieldCount

w_import_painter.SetRedraw(false)

li_FieldCount = Integer(this.object.datawindow.column.count)
for i = 1 to li_FieldCount
	ls_Name = this.Describe("#" + String(i) + ".name")
	ls_Style = ls_Name + ".width=400"
	ls_Style += " " + ls_Name + "_t.width=400"
	if i = 1 then
		ls_Style += " " + ls_Name + "_t.X=0"
	else
		ls_Style += " " + ls_Name + "_t.X=" + String(ll_PosX)
	end if
	ls_Style += " " + ls_Name + "_t.border=6"
	ls_Style += " " + ls_Name + "_t.background.mode=2"
	ls_Style += " " + ls_Name + "_t.background.color=67108864"
	
	this.Modify(ls_Style)	
	ll_PosX = Long(this.Describe(ls_Name + ".X")) + 400
next
this.Modify("sys_pc_id.visible=0")
this.Modify("sys_facility_id.visible=0")
this.Modify("sys_contact_id.visible=0")

w_import_painter.SetRedraw(true)
end event

event ue_settitle(long al_rowcount);if al_RowCount > 1 then
	this.Title = "Imported Data Rows: " + String(al_RowCount)
elseif al_RowCount = 1 then
	this.Title = "Imported Data Rows: 1"
else
	this.Title = "Imported Data Rows: 0"
end if
end event

event constructor;call super::constructor;//Inherit
this.of_SetRowSelect(true)
end event

event other;call super::other;if Message.WordParm = 61458 then 
	Message.Processed = true
	Message.ReturnValue = 0 
end if
end event

type gb_operation from groupbox within tabpage_data
integer y = 8
integer width = 3977
integer height = 176
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Data Operation"
end type

type cb_filter from commandbutton within tabpage_data
integer x = 3675
integer y = 76
integer width = 283
integer height = 84
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Filter..."
end type

event clicked;string ls_Null

if dw_imp_data.RowCount() + dw_imp_data.FilteredCount() <= 0 then
	MessageBox("Prompt", "There is no import data to filter.") //Start Code Change ----02.07.2008 #V8 maha - modified message
	Return
end if

SetNull(ls_Null)
dw_imp_data.SetFilter(ls_Null)
dw_imp_data.Filter()
end event

type cb_sort from commandbutton within tabpage_data
integer x = 3392
integer y = 76
integer width = 279
integer height = 84
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Sor&t..."
end type

event clicked;string ls_Null

if dw_imp_data.RowCount() <= 0 then
	MessageBox("Prompt", "There is no import data to be sorted.") //Start Code Change ----02.07.2008 #V8 maha - modified message
	Return
end if

SetNull(ls_Null)
dw_imp_data.SetSort(ls_Null)
dw_imp_data.Sort()
end event

type cb_get_saved from commandbutton within tabpage_data
integer x = 2912
integer y = 76
integer width = 480
integer height = 84
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Get Saved Data"
end type

event clicked;long ll_PosX
long i, ll_CurrentRow
string ls_TableName
string ls_PrimaryKey
string ls_DWSyntax
string ls_Error
string ls_Name
string ls_comp_def
string ls_imp_field_name
string ls_import_name
string ls_SQLSelect
integer li_FieldCount
DataStore lds_Data
long ll_process_id
str_parm lstr_store
integer li_col

//Get table name
ll_CurrentRow = tab_1.tabpage_hdr.dw_imp_hdr.GetRow()
if ll_CurrentRow <= 0 then Return
ls_import_name = Trim(tab_1.tabpage_hdr.dw_imp_hdr.object.import_name[ll_CurrentRow])
if IsNull(ls_import_name) then ls_import_name = ""
ls_TableName = of_CorrectTableName(ls_import_name) //"impt_" + of_ReplaceBlank(ls_import_name, "_") ; //Modify by Evan 09/18/2008

//Build select sql
lds_Data = Create DataStore
lds_Data.DataObject = "d_import_ds_impfield_save"
lds_Data.SetTransObject(SQLCA)
lds_Data.Retrieve(il_curr_import_id)
for i = 1 to lds_Data.RowCount()
	ls_comp_def = Trim(lds_Data.object.comp_def[i])
	if LenA(ls_comp_def) > 0 then Continue
	
	ls_imp_field_name = Trim(lds_Data.object.imp_field_name[i])
	if IsNull(ls_imp_field_name) or ls_imp_field_name = "" then Continue

	if LenA(ls_SQLSelect) > 0 then ls_SQLSelect += ","
	ls_SQLSelect += ls_imp_field_name
next
if ls_SQLSelect = "" then
	MessageBox("Prompt", "Failed to get import fields.")
	Return
end if

//------------------- APPEON BEGIN -------------------
//$<modify> Stephen 12.19.2012
//$<reason> V12.3 Import Logging modifications
/*
ls_SQLSelect = "SELECT " + ls_SQLSelect + ",0 sys_pc_id, 0 sys_facility_id, 0 sys_contact_id FROM " + ls_TableName
*/
if ii_set73 = 1 then
	
	IF gs_DBType = 'SQL' THEN
		select COUNT(1) into :li_col from syscolumns c, sysobjects t where c.id=t.id and t.name= :ls_TableName and t.type = 'U' using sqlca;
	else
		select COUNT(1) into :li_col  from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and t.table_name= :ls_TableName using sqlca;
	end if
	if  li_col <>  lds_Data.RowCount() +4 then
		MessageBox("Prompt", "The structure of the Import table has been changed.~r~nPlease save imported data first.") 
		Return 
	end if		
	
	lstr_store.s_module = ls_TableName
	lstr_store.l_wf_id = il_curr_import_id
	ii_process_id = 0
	openwithparm(w_import_data_store_view, lstr_store)
	
	if isnull(ii_process_id) then ii_process_id = 0
	ls_SQLSelect = "SELECT " + ls_SQLSelect + ",0 sys_pc_id, 0 sys_facility_id, 0 sys_contact_id FROM " + ls_TableName + "  where process_id = " + string(ii_process_id) 
else
	ls_SQLSelect = "SELECT " + ls_SQLSelect + ",0 sys_pc_id, 0 sys_facility_id, 0 sys_contact_id FROM " + ls_TableName + "  where process_id is null " 
end if
//------------------- APPEON END -------------------

//Dynamic create DW
ls_DWSyntax = SQLCA.SyntaxFromSQL(ls_SQLSelect, "Style(Type=Grid)", ls_Error)
if LenA(ls_Error) > 0 then
	MessageBox("Prompt", "Please save imported data first.")
	Return
end if
dw_imp_data.Create(ls_DWSyntax, ls_Error)
dw_imp_data.SetTransObject(SQLCA)
dw_imp_data.Event ue_ModifyStyle()

//Retrieve data from import table
if dw_imp_data.Retrieve() = -1 then
	dw_imp_data.Event ue_SetTitle(dw_imp_data.RowCount())
	MessageBox("Prompt", "Failed to retrieve data from " + ls_TableName + ".")
else
	dw_imp_data.Event ue_SetTitle(dw_imp_data.RowCount())
end if
end event

type cb_savedata from commandbutton within tabpage_data
integer x = 2395
integer y = 76
integer width = 507
integer height = 84
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save Imported Data"
end type

event clicked;long ll_CurrentRow
integer li_Count
integer li_field_length
integer i, li_FieldCount
string  ls_TableName
string  ls_import_name
string  ls_imp_field_name
string  ls_comp_def
string  ls_SQLSelect
string  ls_TableSyntax
string  ls_DWSyntax
string  ls_Error
string  ls_PrimaryKey
boolean lb_OldAutoCommit
n_import_ds lds_Data

//------------------- APPEON BEGIN -------------------
//$<add> Stephen 12.14.2012
//$<reason> V12.3 Import Logging modifications
integer li_col
boolean lb_new
integer li_process_id
datetime ldt_CurrentTime  
string  ls_import_format
//------------------- APPEON END -------------------

if dw_imp_data.RowCount() <= 0 then
	MessageBox("Prompt", "There is no Import data to be saved.")  //Start Code Change ----02.07.2008 #V8 maha - modified message
	Return
end if
ll_CurrentRow = tab_1.tabpage_hdr.dw_imp_hdr.GetRow()
if ll_CurrentRow <= 0 then Return

//Check table if exists
ls_import_name = Trim(tab_1.tabpage_hdr.dw_imp_hdr.object.import_name[ll_CurrentRow])
if IsNull(ls_import_name) or LenA(ls_import_name) <= 0 then
	MessageBox("Prompt", "Import name can not be null.")
	Return
end if
ls_TableName = of_CorrectTableName(ls_import_name) //"impt_" + of_ReplaceBlank(ls_import_name, "_") ; //Modify by Evan 09/18/2008
SELECT count(*) INTO :li_Count FROM sysobjects WHERE name = :ls_TableName and type = 'U';

//Build sql of select and create table 
lds_Data = Create n_import_ds
lds_Data.DataObject = "d_import_ds_impfield_save"
lds_Data.SetTransObject(SQLCA)
lds_Data.Retrieve(il_curr_import_id)

//------------------- APPEON BEGIN -------------------
//$<modify>Stephen 12.14.2012
//$<reason> V12.3 Import Logging modifications
/*
if li_Count > 0 then
	if MessageBox("Prompt", "The Import table already exists.~r~nWould you like to replace it?", Question!, YesNo!)=2 then
		Return 
	end if
end if
*/
lb_new = false
if li_Count > 0 then	
	if ii_set73 = 1 then
		IF gs_DBType = 'SQL' THEN
			select COUNT(1) into :li_col from syscolumns c, sysobjects t where c.id=t.id and t.name= :ls_TableName and t.type = 'U' using sqlca;
		else
			select COUNT(1) into :li_col  from sys.syscolumn c, sys.systable t where c.table_id=t.table_id and t.table_name= :ls_TableName using sqlca;
		end if
		if  li_col <>  lds_Data.RowCount() +4 then
			if MessageBox("Prompt", "The structure of the Import table has been changed.~r~nWould you like to replace it?", Question!, YesNo!)=2 then
				Return 
			end if
			lb_new = true
		end if
	else
		if MessageBox("Prompt", "The Import table already exists.~r~nWould you like to replace it?", Question!, YesNo!)=2 then
			Return 
		end if
		lb_new = true
	end if
else
	lb_new = true
end if
//------------------- APPEON END -------------------

for i = 1 to lds_Data.RowCount()
	ls_comp_def = Trim(lds_Data.object.comp_def[i])
	if LenA(ls_comp_def) > 0 then Continue
	
	ls_imp_field_name = Trim(lds_Data.object.imp_field_name[i])
	if IsNull(ls_imp_field_name) or ls_imp_field_name = "" then Continue
		
	li_field_length = lds_Data.object.field_length[i]
	if LenA(ls_SQLSelect) > 0 then ls_SQLSelect += ","
	ls_SQLSelect += ls_imp_field_name
	if LenA(ls_TableSyntax) > 0 then ls_TableSyntax += ","
	ls_TableSyntax += ls_imp_field_name + " varchar(" + String(li_field_length) + ") null"
next
ls_PrimaryKey = ls_TableName + "_id"

//------------------- APPEON BEGIN -------------------
//$<Add> Stephen 12.14.2012
//$<reason> V12.3 Import Logging modifications
ls_TableSyntax = ls_TableSyntax + ", process_id integer null, created_date datetime null, created_by varchar(25) null "
ls_SQLSelect = ls_SQLSelect + ",0 sys_pc_id, 0 sys_facility_id, 0 sys_contact_id, process_id, created_date, created_by "
//------------------- APPEON END -------------------

ls_TableSyntax = "create table " + ls_TableName + " (" + ls_TableSyntax + "," + ls_PrimaryKey + " int identity not null, primary key (" + ls_PrimaryKey + "))"
if li_Count > 0 then	ls_TableSyntax = "drop table " + ls_TableName + "; " + ls_TableSyntax
ls_SQLSelect = "SELECT " + ls_SQLSelect + ", " + ls_PrimaryKey + " FROM " + ls_TableName

if lb_new then //add by stephen 12.14.2012 -- V12.3 Import Logging modifications
	//Create a table structure in database
	lb_OldAutoCommit = SQLCA.AutoCommit
	if lb_OldAutoCommit = false then SQLCA.AutoCommit = true		
	EXECUTE IMMEDIATE :ls_TableSyntax;
	if SQLCA.SQLCode <> 0 then
		Destroy lds_Data
		if SQLCA.AutoCommit <> lb_OldAutoCommit then SQLCA.AutoCommit = lb_OldAutoCommit
		MessageBox("Prompt", "Failed to create table structure.~r~n" + ls_TableSyntax)
		Return
	end if
	if SQLCA.AutoCommit <> lb_OldAutoCommit then SQLCA.AutoCommit = lb_OldAutoCommit
end if

//Dynamic create DW
ls_DWSyntax = SQLCA.SyntaxFromSQL(ls_SQLSelect, "", ls_Error)
if LenA(ls_Error) > 0 then
	Destroy lds_Data
	MessageBox("Prompt", "Failed to dynamically create DataWindow.~r~n" + ls_Error)
	Return	
end if
lds_Data.Create(ls_DWSyntax, ls_Error)
lds_Data.SetTransObject(SQLCA)

//---------Begin Added by (Appeon)Alfee 12.18.2013 for V141 ISG-CLX--------
//<$Reason>: For BugT112802 
n_cst_dw_update_prop  ln_dwprop
ln_dwprop.of_modifyupdateproperty(lds_Data, ls_TableName)
//---------End Added ------------------------------------------------------------------

//------------------- APPEON BEGIN -------------------
//$<Add> Stephen 12.28.2012
//$<reason> V12.3 Import Logging modifications
lds_Data.modify("sys_pc_id.update='No'")
lds_Data.modify("sys_facility_id.update='No'")
lds_Data.modify("sys_contact_id.update='No'")
//------------------- APPEON BEGIN -------------------

//Save data
if lds_Data.ImportString(dw_imp_data.object.datawindow.data) < 0 then
	Destroy lds_Data
	MessageBox("Prompt", "Saving Import data to DataStore failed.") //Start Code Change ----02.07.2008 #V8 maha - modified message
	Return
end if

//------------------- APPEON BEGIN -------------------
//$<Add> Stephen 12.14.2012
//$<reason> V12.3 Import Logging modifications
if ii_set73 = 1 then
	ls_SQLSelect = "select max(process_id)  from " + ls_TableName + ";"	
	DECLARE c_1 DYNAMIC CURSOR FOR SQLSA ;
	PREPARE SQLSA FROM :ls_SQLSelect ;
	OPEN DYNAMIC c_1;
	
	if sqlca.sqlcode = 0 then 
		fetch c_1 into :li_process_id;
	end if
	close c_1;
	if isnull(li_process_id) then li_process_id = 0
	li_process_id += 1
else
	setnull(li_process_id)
end if
SELECT getdate() INTO :ldt_CurrentTime FROM ids;

for i = 1 to lds_Data.rowcount()
	lds_Data.setitem(i, "process_id", li_process_id)
	lds_Data.setitem(i, "created_date", ldt_CurrentTime)
	lds_Data.setitem(i, "created_by", gs_user_id)
next
//------------------- APPEON END -------------------

if lds_Data.Update() = 1 then
	of_CompleteTrans(true)
	
	//------------------- APPEON BEGIN -------------------
	//$<Add> Stephen 12.18.2012
	//$<reason> V12.3 Import Logging modifications	
	ls_import_format = tab_1.tabpage_hdr.dw_imp_hdr.object.imp_format[ll_CurrentRow] 
	if ls_import_format <>'3' then
		of_store_file(li_process_id)
	end if	
	MessageBox("Prompt", "Save imported data successful!" )
	//------------------- APPEON END -------------------
else
	of_CompleteTrans(false)
	MessageBox("Prompt", "Save imported data failed.~r~n" + lds_Data.is_SQLErrText)
end if

Destroy lds_Data
end event

type cbx_store_temp from checkbox within tabpage_data
integer x = 1536
integer y = 88
integer width = 695
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Use Advanced Acceptance"
end type

type cb_imp_pro from commandbutton within tabpage_data
integer x = 987
integer y = 76
integer width = 512
integer height = 84
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Process Import Data"
end type

event clicked;long ll_LastRow
n_cst_import_credapp lnv_import_credapp
n_cst_import_contract lnv_import_contract
n_cst_import_faci       lnv_import_faci
str_flag  lstr_audit   //add by stephen 01.03.2013 --V12.3 Import Logging modifications

if dw_imp_data.RowCount() <= 0 then
	//MessageBox("Prompt", "There is no Import data to be imported.") //Start Code Change ----02.07.2008 #V8 maha - modified message
	MessageBox("Prompt", "You need to Click the Get Import Data button first to retrieve the import data into the system before clicking the Process Import Data.") //Add by Evan 02.19.2008
	Return
end if

// Import data
SetPointer(HourGlass!)
if ii_curr_isoft_module = 1 then
	lnv_import_credapp = Create n_cst_import_credapp
	lnv_import_credapp.ii_curr_isoft_module = ii_curr_isoft_module   //(Appeon)Stephen 03.20.2015 - V15.1-Import Improvements 2015
	lnv_import_credapp.of_Execute(il_curr_import_id, dw_imp_data)
	
	//------------------- APPEON BEGIN -------------------
	//$<add> Stephen 01.02.2013
	//$<reason> V12.3 Import Logging modifications
	if lnv_import_credapp.ib_import_audit then
		lstr_audit.l_oriid = lnv_import_credapp.il_hdr_id
		lstr_audit.l_mapid = il_curr_import_id
		if isvalid(w_mdi) then
			opensheetwithparm(w_import_audit,  lstr_audit, w_mdi, 4, Original!)
		else
			openwithparm(w_import_audit,  lstr_audit)
		end if
	end if
	//------------------- APPEON END -------------------
	
	Destroy lnv_import_credapp
//---------Begin Added by (Appeon)Stephen 12.23.2013 for V141 Import Modifications for Facility and Group--------
elseif ii_curr_isoft_module = 3 then
	lnv_import_faci = Create n_cst_import_faci
	lnv_import_faci.ii_curr_isoft_module = ii_curr_isoft_module   //(Appeon)Stephen 03.20.2015 - V15.1-Import Improvements 2015
	lnv_import_faci.of_Execute(il_curr_import_id, dw_imp_data)
	Destroy lnv_import_faci
//---------End Added ------------------------------------------------------
else
	lnv_import_contract = Create n_cst_import_contract
	lnv_import_contract.ii_curr_isoft_module = ii_curr_isoft_module   //(Appeon)Stephen 03.20.2015 - V15.1-Import Improvements 2015
	lnv_import_contract.of_Execute(il_curr_import_id, dw_imp_data)
	Destroy lnv_import_contract
end if

// Display log
il_page4_import_id = -1
tab_1.SelectTab(4)
//---------Begin Modified by (Appeon)Stephen 10.17.2015 for BugL091401--------
//ll_LastRow = tab_1.tabpage_log.dw_imp_proc.RowCount()
//tab_1.tabpage_log.dw_imp_proc.ScrollToRow(ll_LastRow)
if  tab_1.tabpage_log.dw_imp_proc.RowCount() > 0 then
	tab_1.tabpage_log.dw_imp_proc.ScrollToRow(1)
end if
//---------End Modfiied ------------------------------------------------------
SetPointer(Arrow!)
end event

type cb_imp_data from commandbutton within tabpage_data
integer x = 46
integer y = 76
integer width = 480
integer height = 84
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Get &Import Data"
end type

event clicked; string ls_Error
string ls_Syntax
string ls_Name
DataStore lds_imp_data
n_cst_import lnv_import

SetPointer(HourGlass!)

//Get import basic information
lnv_import = Create n_cst_import
lnv_import.of_GetImportInfo(il_curr_import_id, false)

//Get import data
dw_imp_data.Reset()
lds_imp_data = Create DataStore
//debugbreak()
ls_Error = lnv_import.of_GetImportData(il_curr_import_id, lds_imp_data)
if LenA(ls_Error) > 0 then
	Destroy lds_imp_data
	Destroy lnv_import
	SetPointer(Arrow!)
	dw_imp_data.Event ue_SetTitle(0) //evan 07.27.2011
	MessageBox("Prompt", ls_Error)
	Return
end if

//Display import data
ls_Syntax = lds_imp_data.object.datawindow.syntax
dw_imp_data.Create(ls_Syntax, ls_Error)
dw_imp_data.Event ue_ModifyStyle()
if lds_imp_data.RowCount() > 0 then
	lds_imp_data.RowsMove(1, lds_imp_data.RowCount(), Primary!, dw_imp_data, 1, Primary!)
end if
dw_imp_data.Modify("DataWindow.ReadOnly = 'yes'")
dw_imp_data.Event ue_SetTitle(dw_imp_data.RowCount())

Destroy lds_imp_data
Destroy lnv_import

SetPointer(Arrow!)
end event

type cb_pp_run from commandbutton within tabpage_data
integer x = 539
integer y = 76
integer width = 434
integer height = 84
integer taborder = 41
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Pre-Process"
end type

event clicked;of_preprocess_import( il_curr_import_id )
end event

type dw_imp_data from u_dw within tabpage_data
event ue_modifystyle ( )
event ue_settitle ( long al_rowcount )
integer y = 204
integer width = 4014
integer height = 1784
integer taborder = 100
boolean bringtotop = true
boolean titlebar = true
string title = "Imported Data: 0 row"
boolean hscrollbar = true
end type

event ue_modifystyle();string ls_Name
string ls_Style
integer ll_PosX
integer i, li_FieldCount

w_import_painter.SetRedraw(false)

li_FieldCount = Integer(this.object.datawindow.column.count)
for i = 1 to li_FieldCount
	ls_Name = this.Describe("#" + String(i) + ".name")
	ls_Style = ls_Name + ".width=400"
	ls_Style += " " + ls_Name + "_t.width=400"
	if i = 1 then
		ls_Style += " " + ls_Name + "_t.X=0"
	else
		ls_Style += " " + ls_Name + "_t.X=" + String(ll_PosX)
	end if
	ls_Style += " " + ls_Name + "_t.border=6"
	ls_Style += " " + ls_Name + "_t.background.mode=2"
	ls_Style += " " + ls_Name + "_t.background.color=67108864"
	
	this.Modify(ls_Style)	
	ll_PosX = Long(this.Describe(ls_Name + ".X")) + 400
next
this.Modify("sys_pc_id.visible=0")
this.Modify("sys_facility_id.visible=0")
this.Modify("sys_contact_id.visible=0")

w_import_painter.SetRedraw(true)
end event

event ue_settitle(long al_rowcount);if al_RowCount > 1 then
	this.Title = "Imported Data Rows: " + String(al_RowCount)
elseif al_RowCount = 1 then
	this.Title = "Imported Data Rows: 1"
else
	this.Title = "Imported Data Rows: 0"
end if
end event

event other;call super::other;if Message.WordParm = 61458 then 
	Message.Processed = true
	Message.ReturnValue = 0 
end if
end event

event constructor;call super::constructor;//Inherit
this.of_SetRowSelect(true)
end event

type tabpage_log from userobject within tab_1
event ue_retrieve ( )
event ue_resize ( )
integer x = 18
integer y = 100
integer width = 4018
integer height = 2040
boolean enabled = false
long backcolor = 33551856
string text = "Error logs"
long tabtextcolor = 33554432
long tabbackcolor = 79680469
long picturemaskcolor = 12632256
dw_imp_table dw_imp_table
dw_imp_proc dw_imp_proc
dw_imp_err dw_imp_err
end type

event ue_retrieve();if il_curr_import_id = il_page4_import_id then Return
il_page4_import_id = il_curr_import_id

if dw_imp_proc.Retrieve(il_curr_import_id) > 0 then
	dw_imp_proc.SelectRow(0, false)
	dw_imp_proc.SelectRow(1, true)
	dw_imp_proc.Event RowFocusChanged(1)
else
	dw_imp_table.Reset()
	dw_imp_err.Reset()	
end if
end event

event ue_resize();dw_imp_proc.Width = this.Width - 10
dw_imp_table.Width = dw_imp_proc.Width
dw_imp_err.Width = dw_imp_proc.Width

dw_imp_err.Y = dw_imp_table.Y + dw_imp_table.Height
dw_imp_err.Height = this.Height - dw_imp_err.Y - 10

end event

on tabpage_log.create
this.dw_imp_table=create dw_imp_table
this.dw_imp_proc=create dw_imp_proc
this.dw_imp_err=create dw_imp_err
this.Control[]={this.dw_imp_table,&
this.dw_imp_proc,&
this.dw_imp_err}
end on

on tabpage_log.destroy
destroy(this.dw_imp_table)
destroy(this.dw_imp_proc)
destroy(this.dw_imp_err)
end on

type dw_imp_table from u_dw within tabpage_log
integer y = 688
integer width = 4014
integer height = 516
integer taborder = 120
boolean titlebar = true
string title = "Import Table Details"
string dataobject = "d_import_process_tables"
boolean hscrollbar = true
end type

event constructor;call super::constructor;//inherit
this.Modify("DataWindow.ReadOnly = 'yes'")
end event

event other;call super::other;if Message.WordParm = 61458 then 
	Message.Processed = true
	Message.ReturnValue = 0 
end if
end event

event rowfocuschanged;call super::rowfocuschanged;//inherit
long ll_process_tables_id

this.SelectRow(0, false)
this.SelectRow(CurrentRow, true)

if CurrentRow > 0 then
	ll_process_tables_id = this.object.process_tables_id[CurrentRow]
	if dw_imp_err.Retrieve(ll_process_tables_id) > 0 then
		dw_imp_err.SelectRow(0, false)
		dw_imp_err.SelectRow(1, true)
	end if
else
	dw_imp_err.Reset()
end if
end event

type dw_imp_proc from u_dw within tabpage_log
integer width = 4014
integer height = 684
integer taborder = 120
boolean titlebar = true
string title = "Import Process"
string dataobject = "d_import_process"
boolean hscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;//inhert
long ll_process_id

this.SelectRow(0, false)

if CurrentRow > 0 then
	this.SelectRow(CurrentRow, true)
	ll_process_id = this.object.process_id[CurrentRow]
	dw_imp_table.Retrieve(ll_process_id)
	if dw_imp_table.RowCount() > 0 then
		dw_imp_table.Event RowFocusChanged(1)
	else
		dw_imp_err.Reset()
	end if
else
	dw_imp_table.Reset()
	dw_imp_err.Reset()
end if
end event

event constructor;call super::constructor;//inherit
this.Modify("DataWindow.ReadOnly = 'yes'")
end event

event other;call super::other;if Message.WordParm = 61458 then 
	Message.Processed = true
	Message.ReturnValue = 0 
end if
end event

event doubleclicked;call super::doubleclicked;string ls_err_value

if row > 0 and dwo.name = "err_value" then
	ls_err_value = this.object.err_value[row]
	if LenA(ls_err_value) > 0 then
		OpenWithParm(w_import_loglist, "LOG#" + ls_err_value)
	end if
end if
end event

type dw_imp_err from u_dw within tabpage_log
integer y = 1208
integer width = 4014
integer height = 772
integer taborder = 110
boolean titlebar = true
string title = "Import Process Error Details"
string dataobject = "d_import_process_errors"
boolean hscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;//inherit
this.SelectRow(0, false)
this.SelectRow(CurrentRow, true)
end event

event constructor;call super::constructor;//inherit
this.Modify("DataWindow.ReadOnly = 'yes'")
end event

event other;call super::other;if Message.WordParm = 61458 then 
	Message.Processed = true
	Message.ReturnValue = 0 
end if
end event

event doubleclicked;call super::doubleclicked;string ls_err_value

if row > 0 and dwo.name = "err_value" then
	ls_err_value = this.object.err_value[row]
	if LenA(ls_err_value) > 0 then
		OpenWithParm(w_import_loglist, "LOG#" + ls_err_value)
	end if
end if
end event

type cb_pp_set from commandbutton within w_import_painter
integer x = 2117
integer y = 4
integer width = 466
integer height = 92
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Pre-Process Setup"
end type

event clicked;openwithparm(w_import_pre_process_setup, il_curr_import_id )
end event

type cb_report from commandbutton within w_import_painter
integer x = 3438
integer width = 581
integer height = 92
integer taborder = 61
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Mapping Data Report"
end type

event clicked;gs_report_variables lst_val

lst_val.as_report_object = "d_import_mapping_report"
lst_val.ai_num_variables = 1
lst_val.as_var_type[1] = "N"
lst_val.as_value[1] = string(il_curr_import_id)
lst_val.as_single = 'S'
if isvalid(w_report_view) then close(w_report_view)

openwithparm(w_report_view,lst_val)
end event

