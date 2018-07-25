$PBExportHeader$n_cst_import_faci.sru
forward
global type n_cst_import_faci from n_cst_import
end type
end forward

global type n_cst_import_faci from n_cst_import
end type
global n_cst_import_faci n_cst_import_faci

type variables
datastore ids_gp_link
long il_modify_loc[]

end variables

forward prototypes
public function integer of_checkmapping (boolean ab_isimport, long al_table_id, string as_table_name, ref datastore ads_import_field, ref datastore ads_mapping_field, ref string as_errortext[])
public function integer of_dyncreateistabledw (string as_table_name)
public function integer of_datapopulate ()
public function integer of_setprimarykey (string as_table_name)
public function integer of_datapopulateproc ()
public function integer of_fieldaudit ()
public function integer of_addlinks (string as_table_name)
public function integer of_postupdate ()
end prototypes

public function integer of_checkmapping (boolean ab_isimport, long al_table_id, string as_table_name, ref datastore ads_import_field, ref datastore ads_mapping_field, ref string as_errortext[]);//====================================================================
//$<Function>: of_checkmapping
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 12.23.2013 (V141 Import Modifications for Facility and Group)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_FindRow
string  ls_field_name
string  ls_field_name_allias
string  ls_imp_field_name
integer li_Return
integer li_KeyFieldCount
integer i, li_FieldCount
integer li_ErrorCount
boolean lb_IsFacilityname = false

//////////////////////////////////////////////////////////////////////////////////////////////
// There is no creation mapped relationship
li_FieldCount = ads_mapping_field.RowCount()
if li_FieldCount <= 0 then
	li_Return = of_Log(ab_IsImport, "No mapping relationship was created.", as_ErrorText[])
	if ab_IsImport then Return li_Return
	Return 1 //Have one error
end if

// Check IntelliSoft field name
for i = 1 to li_FieldCount
	// Get field name
	ls_field_name = Lower(Trim(ads_mapping_field.object.field_name[i]))
	ls_field_name_allias = ads_mapping_field.object.field_name_allias[i]
	ls_imp_field_name = Trim(ads_mapping_field.object.imp_field_name[i])

	// Increase key field count
	if ads_mapping_field.object.key_field[i] = 1 then li_KeyFieldCount ++
	
	choose case as_table_name
		case "facility"
			if ls_field_name = "facility_name" then lb_IsFacilityname = true
	end choose
	
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

// Check key field
if li_KeyFieldCount = 0 then
	li_Return = of_Log(ab_IsImport, "There is no key field.", as_ErrorText[])
	if ab_IsImport then Return li_Return
end if

choose case as_table_name
		case "facility"
			if not lb_IsFacilityname then
				li_Return = of_Log(ab_IsImport, "'facility_name' field is required.", as_ErrorText[])
				if ab_IsImport then Return li_Return
			end if
end choose
	
// Return
if ab_IsImport then
	Return 1
else
	Return UpperBound(as_ErrorText)
end if
end function

public function integer of_dyncreateistabledw (string as_table_name);//====================================================================
//$<Function>: of_dyncreateistabledw
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 12.23.2013 (V141 Import Modifications for Facility and Group)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

//<Overwrite this function>
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
integer li_Return
n_cst_dw_update_prop lnv_DwSyntax

//1.Get mapped fields of list
for i = 1 to ids_mapping_field.RowCount()
	ls_field_name = Lower(Trim(ids_mapping_field.object.field_name[i]))
	if LenA(ls_Fields) > 0 then ls_Fields += ","
	ls_Fields += ls_field_name
next

//2.Add necessary fields to select SQL(Additional field must place at last)
//For temp DW
ls_FieldsTemp = ls_Fields + ",0 imp_row, 0 err_value, 0 sys_pc_id"
if AppeonGetClientType() = "PB" then
	ls_SQLSelectTemp = "SELECT " + ls_FieldsTemp + ",'' sort_field FROM " + as_table_name
else
	ls_SQLSelectTemp = "SELECT " + ls_FieldsTemp + " FROM " + as_table_name
end if

//For update DW
choose case as_table_name
	case "facility" //V10.1 - Lookup Table Import
		if ib_isg_key = false then //(Appeon)Stephen 03.20.2015 - V15.1-Import Improvements 2015
			ls_Fields += ",facility_id"
		end if
	case else
		if ib_isg_key = false then //(Appeon)Stephen 03.20.2015 - V15.1-Import Improvements 2015
			ls_Fields += ",rec_id"
		end if
end choose
if AppeonGetClientType() = "PB" then
	ls_SQLSelect = "SELECT " + ls_Fields + ",'' sort_field FROM " + as_table_name
else
	ls_SQLSelect = "SELECT " + ls_Fields + " FROM " + as_table_name
end if

//3.Dynamic create IntelliSoft table datawindow
gnv_appeondb.of_StartQueue()
ls_Syntax = SQLCA.SyntaxFromSQL(ls_SQLSelect, "", ls_Error)
ls_SyntaxTemp = SQLCA.SyntaxFromSQL(ls_SQLSelectTemp, "", ls_ErrorTemp)
gnv_appeondb.of_CommitQueue()
if LenA(ls_Error) > 0 then
	of_Log(0, "", IL_ERRTYPE_MAPDESIGN, "Failed to dynamically create updatable DataWindow." + ls_Error)
	if not of_IsContinue() then Return -1
	Return -2
end if
if LenA(ls_ErrorTemp) > 0 then
	of_Log(0, "", IL_ERRTYPE_MAPDESIGN, "Failed to dynamically create temporary DataWindow." + ls_ErrorTemp)
	if not of_IsContinue() then Return -1
	Return -2
end if

ids_intellisoft_table.Create(ls_Syntax, ls_Error)
ids_intellisoft_table.SetTransObject(SQLCA)
ids_intellisoft_table_temp.Create(ls_SyntaxTemp, ls_Error)
//if of_ModifyUpdateProperty(ids_intellisoft_table, as_table_name) = -1 then // Add by Evan 04.10.2009
//---------Begin Modified by (Appeon)Stephen 2013-07-26 for IntelliImport "DB Update" error--------
//if lnv_DwSyntax.of_ModifyUpdateProperty(ids_intellisoft_table, as_table_name) = -1 then // Add by Evan 06.02.2009
if lnv_DwSyntax.of_ModifyUpdateProperty(ids_intellisoft_table, as_table_name, false) = -1 then // Add by Evan 06.02.2009
//---------End Modfiied ------------------------------------------------------
	of_Log(0, "", IL_ERRTYPE_MAPDESIGN, "Failed to modify datawindow update properties.")
	if not of_IsContinue() then Return -1
	Return -2
end if
ids_intellisoft_table.object.datawindow.table.updatewhere = 0
ids_intellisoft_table.Modify("sort_field.update='no'")

//4.Dynamic create others datawindow
if li_Return <> 1 then Return li_Return

Return 1
end function

public function integer of_datapopulate ();//====================================================================
//$<Function>: of_datapopulate
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 12.23.2013 (V141 Import Modifications for Facility and Group)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
//<Overwrite this function>
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

//// Cache foreign key to ids_imp_data
//choose case ls_table_name
//	case "ctx_basic_info"
//		of_CacheForeignKey("sys_pc_id", "ctx_id")
//	case "app_facility"
//		of_CacheForeignKey("sys_facility_id", "facility_id")
//	case "ctx_contacts"
//		of_CacheForeignKey("sys_contact_id", "contact_id")
//end choose

Return 1
end function

public function integer of_setprimarykey (string as_table_name);//====================================================================
//$<Function>: of_setprimarykey
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 12.23.2013 (V141 Import Modifications for Facility and Group)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_Row, i
long ll_rec_id
long ll_prac_id
long ll_InsertRow
long ll_find

// There is no new record
if il_CurrTableAddCount = 0 then Return 1
w_import_progressbar.of_SetImportProcessDesc("Set primary key value")

// Set primary key value
choose case as_table_name
	case "facility" 
		// Set facility_id		
		SELECT max(facility_id) + 1 INTO :ll_rec_id FROM facility;
		if IsNull(ll_rec_id) or ll_rec_id = 0 then ll_rec_id = 1
		w_import_progressbar.of_SetMaxPosition(il_CurrTableAddCount)
		for i = 1 to il_CurrTableAddCount
			ll_Row = ids_newrow.GetItemNumber(i, "new_row")
			ids_intellisoft_table.SetItem(ll_Row, "facility_id", ll_rec_id)
			ll_rec_id ++
			w_import_progressbar.of_SkipNextPosition()
		next
	case "group_practice"
		// Set rec_id		
		SELECT max(rec_id) + 1 INTO :ll_rec_id FROM group_practice;
		if IsNull(ll_rec_id) or ll_rec_id = 0 then ll_rec_id = 1
		w_import_progressbar.of_SetMaxPosition(il_CurrTableAddCount)
		for i = 1 to il_CurrTableAddCount
			ll_Row = ids_newrow.GetItemNumber(i, "new_row")
			ids_intellisoft_table.SetItem(ll_Row, "rec_id", ll_rec_id)
			
			ll_find = ids_gp_link.find("location_row = " +string(ll_Row), 1, ids_gp_link.rowcount())
			if ll_find > 0 then
				ids_gp_link.setitem(ll_find, "location_id", ll_rec_id)
			end if
			
			ll_rec_id ++
			w_import_progressbar.of_SkipNextPosition()
		next
	case "group_multi_loc" 
		// Set rec_id 
		SELECT max(rec_id) + 1 INTO :ll_rec_id FROM group_multi_loc;
		if IsNull(ll_rec_id) or ll_rec_id = 0 then ll_rec_id = 1
		w_import_progressbar.of_SetMaxPosition(il_CurrTableAddCount)
		for i = 1 to il_CurrTableAddCount
			ll_Row = ids_newrow.GetItemNumber(i, "new_row")
			ids_intellisoft_table.SetItem(ll_Row, "rec_id", ll_rec_id)
			ll_find = ids_gp_link.find("gp_row = " +string(ll_Row), 1, ids_gp_link.rowcount())
			if ll_find > 0 then
				ids_gp_link.setitem(ll_find, "gp_id", ll_rec_id)
			end if
			ll_rec_id ++
			w_import_progressbar.of_SkipNextPosition()
		next
end choose

Return 1
end function

public function integer of_datapopulateproc ();//====================================================================
//$<Function>: of_datapopulateproc
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 12.23.2013 (V141 Import Modifications for Facility and Group)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

any  la_OldValue
any  la_NewValue
long ll_prac_id
long ll_Row
long ll_insert
long ll_FindRow
long ll_RowCount
long ll_ImportDataRow
long ll_SetDefValueRow[]
long ll_gp_id, ll_loc_id
integer li_add_protocol
integer li_match_gp
integer i, li_FieldCount
integer li_KeyFieldCount
integer li_KeyFieldIndex[]
string  ls_FindValue
string  ls_table_name
string  ls_field_name
string  ls_KeyField[]
string  ls_KeyField1[]
string  ls_KeyField2[]
boolean lb_IsAdd
boolean lb_IsCodeLookupTable = false
boolean lb_IsNewRow[]

// Set progress bar
ll_RowCount = ids_intellisoft_table_temp.RowCount()
if ll_RowCount <= 0 then Return 1
w_import_progressbar.of_SetImportProcessDesc("Populate data")
w_import_progressbar.of_SetMaxPosition(ll_RowCount + 2)

li_add_protocol = ids_import_hdr.object.add_protocol[1]
li_match_gp = ids_table_record.object.lv_match_gp[ids_table_record.GetRow()]
ls_table_name = Lower(ids_table_record.object.table_name[ids_table_record.GetRow()])
if ls_table_name = "code_lookup" then lb_IsCodeLookupTable = true
li_FieldCount = ids_mapping_field.RowCount()
ids_newrow.Reset()

// Dynamic create find column
li_KeyFieldCount = of_GetKeyFields(li_KeyFieldIndex[], ls_KeyField[])
ls_KeyField1[] = ls_KeyField[]
ls_KeyField2[] = ls_KeyField[]

ids_intellisoft_table.of_CreateFindColumn(ls_KeyField1[])
ids_intellisoft_table_temp.of_CreateFindColumn(ls_KeyField2[])
//if li_match_gp = 1 then ids_group_practice.of_CreateFindColumn(ls_KeyField[]) // V10.1 - Import Link Value
w_import_progressbar.of_SkipNextPosition()
yield()
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
	yield()
	if ll_FindRow > 0 then
		lb_IsAdd = false
		il_CurrTableModifyCount ++
	else
		lb_IsAdd = true
		ll_FindRow = Abs(ll_FindRow)
		il_CurrTableAddCount ++
		ids_newrow.InsertRow(0)
		ids_newrow.SetItem(il_CurrTableAddCount, "new_row", ll_FindRow)
		ids_newrow.SetItem(il_CurrTableAddCount, "imp_row", ll_ImportDataRow)
	end if
	choose case ls_table_name
		case "group_multi_loc"  //group
			ll_insert = ids_gp_link.insertrow(0)
			ids_gp_link.setitem(ll_insert, "imp_row", ll_ImportDataRow)
			if lb_IsAdd then
				ids_gp_link.setitem(ll_insert, "gp_row", ll_FindRow)
			else
				ll_gp_id = ids_intellisoft_table.getitemnumber(ll_FindRow, "rec_id")
				ids_gp_link.setitem(ll_insert, "gp_id", ll_gp_id)
			end if 
		case "group_practice"  //location
			ll_insert = ids_gp_link.find("imp_row = " +string(ll_ImportDataRow), 1 , ids_gp_link.rowcount())
			if ll_insert > 0 then
				if lb_IsAdd then
					ids_gp_link.setitem(ll_insert, "location_row", ll_FindRow)
				else
					ll_loc_id = ids_intellisoft_table.getitemnumber(ll_FindRow, "rec_id")
					ids_gp_link.setitem(ll_insert, "location_id", ll_loc_id)					
				end if
			end if
			
			if not lb_IsAdd then
				ll_loc_id = ids_intellisoft_table.getitemnumber(ll_FindRow, "rec_id")
				il_modify_loc[upperbound(il_modify_loc) +1] = ll_loc_id
			end if
	end choose
			
	lb_IsNewRow[upperbound(lb_IsNewRow) + 1] = lb_IsAdd
	ll_SetDefValueRow[upperbound(ll_SetDefValueRow) + 1] = ll_FindRow
	
	// Replace value of ids_intellisoft_table with ids_intellisoft_table_TEMP
	for i = 1 to li_FieldCount
		if lb_IsCodeLookupTable then // V10.1 - Lookup Table Import
			ls_field_name = Lower(Trim(ids_mapping_field.object.field_name[i]))
			if Upper(ids_intellisoft_table.object.type[ll_FindRow]) = 'S' then
				if ls_field_name = "code" or ls_field_name = "description" then Continue
			end if
			if lb_IsAdd = false then
				if ls_field_name = "ic_n" or ls_field_name = "ic_c" or ls_field_name = "type" then Continue
			end if
		end if
		la_OldValue = ids_intellisoft_table.object.data[ll_FindRow, i]
		la_NewValue = ids_intellisoft_table_temp.object.data[ll_Row, i]
		if IsNull(la_OldValue) and IsNull(la_NewValue) then Continue
		if la_OldValue = la_NewValue then
		else
			ids_intellisoft_table.SetItem(ll_FindRow, i, la_NewValue)
		end if
		yield()
	next
	
	Yield() // evan 07.11.2011
next

// Stop import data
if of_IsStopImport() then Return -1

Return 1
end function

public function integer of_fieldaudit ();////====================================================================
////$<Function>: of_fieldaudit
////$<Arguments>:
//// 	%ScriptArgs%
////$<Return>:  integer
////$<Description>: 
////$<Author>: (Appeon) Stephen 12.24.2013 (V141 Import Modifications for Facility and Group)
////--------------------------------------------------------------------
////$<Modify History>:
////====================================================================
//string ls_ErrorText
//
////Set progress bar
//w_import_progressbar.of_SetImportProcessDesc("Field audit")
//w_import_progressbar.of_SetMaxPosition(2)
//w_import_progressbar.of_SkipNextPosition()
//
////Execute field audit
//ids_address_lookup.SetFilter("")
//ids_address_lookup.Filter()
//inv_data_entry.ids_address_lookup = ids_address_lookup
//inv_data_entry.of_field_audit(ids_intellisoft_table, ls_ErrorText)
//w_import_progressbar.of_SkipNextPosition()
//
Return 1
end function

public function integer of_addlinks (string as_table_name);//====================================================================
//$<Function>: of_addlinks
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 12.24.2013 (V141 Import Modifications for Facility and Group)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

long ll_rec_id
long ll_prac_id
long ll_facility_id
long ll_copy_faci
long i, j, ll_Row
long ll_InsertRow
long ll_AddCount
long ll_committee_id
long ll_gp_id, ll_loc_id
long ll_user_faci
integer li_access
string  ls_user
n_import_ds lds_comm, lds_comm_curr
n_import_ds lds_facility_ver, lds_facility_ver_curr
n_import_ds lds_user, lds_user_faci_secur
n_import_ds lds_loc_links

//Set progress bar
w_import_progressbar.of_SetImportProcessDesc("Add link records")

//Add new records to link table
choose case as_table_name
	case "facility"
		if il_CurrTableAddCount < 1 then return 1
		w_import_progressbar.of_SetMaxPosition(il_CurrTableAddCount + 1)
		ll_copy_faci = ids_import_hdr.object.copy_facil[ids_import_hdr.getrow()]
		if isnull(ll_copy_faci) or ll_copy_faci = 0 then ll_copy_faci = 1
		
		//Create datastore of facility table
		lds_comm = Create n_import_ds
		lds_comm_curr = Create n_import_ds
		lds_facility_ver = Create n_import_ds
		lds_facility_ver_curr = Create n_import_ds
		lds_user = Create n_import_ds
		lds_user_faci_secur = Create n_import_ds
		
		lds_comm.DataObject = "d_committee_detail_f"
		lds_comm_curr.DataObject = "d_committee_detail_f"
		lds_facility_ver.DataObject = "d_verification_setup_all"
		lds_facility_ver_curr.DataObject = "d_verification_setup_all"
		lds_user.DataObject = "d_user_select_list"
		lds_user_faci_secur.DataObject = "d_user_facil_security_imp"
		
		lds_comm.SetTransObject(SQLCA)
		lds_comm_curr.SetTransObject(SQLCA)
		lds_facility_ver.SetTransObject(SQLCA)
		lds_facility_ver_curr.SetTransObject(SQLCA)
		lds_user.SetTransObject(SQLCA)
		lds_user_faci_secur.SetTransObject(SQLCA)

		gnv_appeondb.of_StartQueue()
		lds_comm.retrieve(ll_copy_faci)
		lds_facility_ver.retrieve(ll_copy_faci)
		lds_user.retrieve()
		SELECT Max( committee_id )  INTO :ll_committee_id  FROM committee_lookup  ;
		//SELECT Max( user_facility_id )  INTO :ll_user_faci  FROM security_user_facilities  ;		//comment by Appeon long.zhang 02.26.2015 (Bug 4419 created for Case# 00052190: Unable to Create User ID)		
		gnv_appeondb.of_CommitQueue()
		
		ll_committee_id++
		
		//------------------- APPEON BEGIN -------------------
		//<$>added:long.zhang 02.26.2015
		//<$>reason:get ll_user_faci by ids ,for Bug 4419 created for Case# 00052190: Unable to Create User ID
		//ll_user_faci++
		ll_user_faci = gnv_app.of_get_id( "user_facility_id" ,(il_CurrTableAddCount * lds_user.rowcount())) 
		//------------------- APPEON END -------------------
		
		for i = 1 to il_CurrTableAddCount
			ll_Row = ids_newrow.GetItemNumber(i, "new_row")
			ll_facility_id = ids_intellisoft_table.object.facility_id[ll_Row]
			
			//facility_ver_rules
			for j = 1 to lds_facility_ver.rowcount()
				lds_facility_ver.setitem(j, "facility_id", ll_facility_id)
			next
			lds_facility_ver.rowscopy(1, lds_facility_ver.rowcount(), primary!, lds_facility_ver_curr, lds_facility_ver_curr.rowcount()+1, primary!)
			
			//committee_lookup
			for j = 1 to lds_comm.rowcount()
				lds_comm.setitem(j, "committee_id", ll_committee_id)
				lds_comm.setitem(j, "facility_id", ll_facility_id)
				ll_committee_id +=1
			next
			lds_comm.rowscopy(1, lds_comm.rowcount(), primary!, lds_comm_curr, lds_comm_curr.rowcount()+1, primary!)
			
			//security_user_facilities
			for j = 1 to lds_user.rowcount()
				ll_prac_id = lds_user.object.prac_id[j]
				ls_user = lds_user.object.user_id[j]
				if isnull(ll_prac_id) or ll_prac_id = 0 then
					li_access = 1
				else
					li_access = 0
				end if
				ll_AddCount = lds_user_faci_secur.insertrow(0)
				lds_user_faci_secur.setitem(ll_AddCount, "user_facility_id", ll_user_faci)
				lds_user_faci_secur.setitem(ll_AddCount, "facility_id", ll_facility_id)
				lds_user_faci_secur.setitem(ll_AddCount, "user_id", ls_user)
				lds_user_faci_secur.setitem(ll_AddCount, "access_rights", li_access)
				
				ll_user_faci +=1
			next
			
			w_import_progressbar.of_SkipNextPosition()
		next
		
		//Update
		gnv_appeondb.of_StartQueue()
		lds_comm_curr.update()
		lds_facility_ver_curr.update()
		lds_user_faci_secur.update()
		gnv_appeondb.of_CommitQueue()
		
		if IsValid(lds_comm_curr) then Destroy lds_comm_curr
		if IsValid(lds_facility_ver_curr) then Destroy lds_facility_ver_curr
		if IsValid(lds_user_faci_secur) then Destroy lds_user_faci_secur
		if IsValid(lds_comm) then Destroy lds_comm
		if IsValid(lds_facility_ver) then Destroy lds_facility_ver
		if IsValid(lds_user) then Destroy lds_user 
	case "group_practice"
		//create group_loc_link
		w_import_progressbar.of_SetMaxPosition(ll_AddCount + 1)
		lds_loc_links = create n_import_ds
		lds_loc_links.DataObject = "d_imp_group_loc_link"
		lds_loc_links.settransobject(sqlca)
		gnv_appeondb.of_StartQueue() 
		lds_loc_links.retrieve()
		SELECT max(rec_id)	INTO :ll_rec_id From group_loc_link;	
		gnv_appeondb.of_CommitQueue()
		IF ll_rec_id < 1 Or IsNull( ll_rec_id ) THEN ll_rec_id = 0
		ll_rec_id++
	
		for i = 1 to ids_gp_link.rowcount()
			ll_gp_id = ids_gp_link.getitemnumber(i, "gp_id")
			ll_loc_id = ids_gp_link.getitemnumber(i, "location_id")
			if isnull(ll_gp_id) or ll_gp_id = 0 or isnull(ll_loc_id) or ll_loc_id = 0 then continue
			ll_row = lds_loc_links.find("group_id = "+string(ll_gp_id) +" and loc_id = " +string(ll_loc_id), 1, lds_loc_links.rowcount())
			if ll_row < 1 then
				ll_InsertRow = lds_loc_links.insertrow(0)
				lds_loc_links.setitem(ll_InsertRow, "rec_id", ll_rec_id)
				lds_loc_links.setitem(ll_InsertRow, "group_id", ll_gp_id)
				lds_loc_links.setitem(ll_InsertRow, "loc_id", ll_loc_id)
				ll_rec_id++
			end if
		next
		
		lds_loc_links.update()
		if IsValid(lds_loc_links) then Destroy lds_loc_links	
		
		//Update connected Provider records
		openwithparm(w_gp_prac_update,'imp')
		w_gp_prac_update.dynamic of_batch_update_address(il_modify_loc)
		close(w_gp_prac_update)
		
		w_import_progressbar.of_SkipNextPosition()
end choose

Return 1
end function

public function integer of_postupdate ();//====================================================================
//$<Function>: of_postupdate
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 12.24.2013 (V141 Import Modifications for Facility and Group)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
string ls_table_name

// Add link records
ls_table_name = Lower(ids_table_record.object.table_name[ids_table_record.GetRow()])
of_AddLinks(ls_table_name)

of_CompleteTrans(true)
//// Add audit trail data
//if ids_intellisoft_table.ModifiedCount() > 0 then	
//	of_FieldAudit()
//end if

// Reset datastore
ids_intellisoft_table.Reset()

Return 1
end function

on n_cst_import_faci.create
call super::create
end on

on n_cst_import_faci.destroy
call super::destroy
end on

event constructor;call super::constructor;ids_gp_link = create datastore
ids_gp_link.dataobject = 'd_import_gp_link'
ids_gp_link.SetTransObject(SQLCA)

end event

event destructor;call super::destructor;//Destroy inv_data_entry

destroy ids_gp_link

end event

