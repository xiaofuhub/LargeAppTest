$PBExportHeader$n_cst_code_lookup_audit.sru
forward
global type n_cst_code_lookup_audit from nonvisualobject
end type
end forward

global type n_cst_code_lookup_audit from nonvisualobject autoinstantiate
end type

type variables
DataStore ids_data
DataStore ids_audit
end variables

forward prototypes
public function integer of_fieldaudit (datawindow adw_data, string as_lookup_type)
public function integer of_fieldaudit (datastore ads_data, string as_lookup_type)
public function boolean of_fieldexists (datastore ads_data, string as_field)
public function integer of_addaudit (string as_lookup_type, datastore ads_data, long al_row, string as_audit_type)
public function integer of_save ()
end prototypes

public function integer of_fieldaudit (datawindow adw_data, string as_lookup_type);string ls_Syntax
string ls_ErrorText

// Dynamic create datawindow
if not IsValid(ids_data) then
	ids_data = Create DataStore
end if
if LenA(adw_data.DataObject) > 0 then
	ids_data.DataObject = adw_data.DataObject
else
	ls_Syntax = adw_data.object.datawindow.syntax
	ids_data.Create(ls_Syntax, ls_ErrorText)
	if LenA(ls_ErrorText) > 0 then Return -1
end if
if adw_data.ShareData(ids_data) = -1 then Return -1
	
// Execute field audit
Return of_FieldAudit(ids_data, as_lookup_type)
end function

public function integer of_fieldaudit (datastore ads_data, string as_lookup_type);long ll_Row
long ll_RowCount
DWItemStatus ldis_Status

if not of_FieldExists(ads_data, "code") then Return -1
if not of_FieldExists(ads_data, "lookup_name") then Return -1

// Audit data for Modification
ll_RowCount = ads_data.RowCount()
for ll_Row = 1 to ll_RowCount
	ldis_Status = ads_data.GetItemStatus(ll_Row, 0, Primary!)
	if ldis_Status = NotModified! or ldis_Status = New! or ldis_Status = NewModified! then Continue
	if ads_data.GetItemStatus(ll_Row, "code", Primary!) = DataModified! or &
	ads_data.GetItemStatus(ll_Row, "lookup_name", Primary!) = DataModified! &
	then
		of_AddAudit(as_lookup_type, ads_data, ll_Row, "E")
	end if
next

// Audit data for deletion
ll_RowCount = ads_data.DeletedCount()
for ll_Row = 1 to ll_RowCount
	of_AddAudit(as_lookup_type, ads_data, ll_Row, "D")
next

Return 1
end function

public function boolean of_fieldexists (datastore ads_data, string as_field);string ls_Type

ls_Type = ads_data.Describe(as_Field + ".ColType")
if ls_Type = "!" or ls_Type = "?" then	
	Return false
else
	Return true
end if
end function

public function integer of_addaudit (string as_lookup_type, datastore ads_data, long al_row, string as_audit_type);long ll_Row
long ll_InsertRow

// Add audit data according to DS buffer
ll_InsertRow = ids_audit.InsertRow(0)
choose case as_audit_type
	case "E" //Edit
		ids_audit.object.code[ll_InsertRow] = ads_data.GetItemString(al_Row, "code", Primary!, true)
		ids_audit.object.lookup_name[ll_InsertRow] = ads_data.GetItemString(al_Row, "lookup_name", Primary!, true)
		if of_FieldExists(ads_data, "lookup_code") then
			ids_audit.object.lookup_code[ll_InsertRow] = ads_data.GetItemNumber(al_Row, "lookup_code", Primary!, true)
		end if
		
	case "D" //Delete
		ids_audit.object.code[ll_InsertRow] = ads_data.GetItemString(al_Row, "code", Delete!, true)
		ids_audit.object.lookup_name[ll_InsertRow] = ads_data.GetItemString(al_Row, "lookup_name", Delete!, true)
		if of_FieldExists(ads_data, "lookup_code") then
			ids_audit.object.lookup_code[ll_InsertRow] = ads_data.GetItemNumber(al_Row, "lookup_code", Delete!, true)
		end if
		
	case "I" //Insert		
end choose

ids_audit.object.audit_type[ll_InsertRow] = as_audit_type
ids_audit.object.lookup_type[ll_InsertRow] = as_lookup_type
ids_audit.object.modified_date[ll_InsertRow] = DateTime(Today(), Now())
	
Return 1
end function

public function integer of_save ();// Save audit data
if ids_audit.ModifiedCount() <= 0 then Return 1

if ids_audit.Update() = 1 then
	Commit;
	ids_audit.Reset()
	Return 1
else
	Rollback;
	ids_audit.Reset()
	Return -1
end if
end function

on n_cst_code_lookup_audit.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_code_lookup_audit.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;if IsValid(ids_data) then Destroy ids_data
if IsValid(ids_audit) then Destroy ids_audit
end event

event constructor;ids_audit = Create DataStore
ids_audit.DataObject = "d_code_lookup_audit"
ids_audit.SetTransObject(SQLCA)
end event

