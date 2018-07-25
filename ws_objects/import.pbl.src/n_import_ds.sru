$PBExportHeader$n_import_ds.sru
forward
global type n_import_ds from datastore
end type
end forward

global type n_import_ds from datastore
end type
global n_import_ds n_import_ds

type variables
string is_SQLErrText
DataStore ids_Sort
end variables

forward prototypes
public function long of_filter (string as_filter)
public function string of_getcoltype (string as_field)
public function long of_find (string as_findfield, string as_findvalue, boolean ab_insert)
public function boolean of_comparestring (string as_string1, string as_string2)
public function integer of_createfindcolumn (ref string as_fields[])
public function boolean of_isnullrow (long al_row, ref integer ai_keyfieldindex[], integer ai_keyfieldcount)
public function boolean of_fieldexists (string as_field)
end prototypes

public function long of_filter (string as_filter);if IsNull(as_Filter) then Return 0

this.SetFilter(as_Filter)
this.Filter()

Return this.RowCount()
end function

public function string of_getcoltype (string as_field);string ls_FieldType

ls_FieldType = Upper(this.Describe(as_Field + ".ColType"))

if PosA(ls_FieldType, "CHAR") > 0 then
	ls_FieldType = "C"
elseif PosA(ls_FieldType, "DATE") > 0 then
	ls_FieldType = "D"
elseif PosA(ls_FieldType, "LONG") > 0 or PosA(ls_FieldType, "DECIMAL") > 0 or PosA(ls_FieldType, "REAL") > 0 then
	ls_FieldType = "N"
elseif ls_FieldType = "!" then
	ls_FieldType = "!" //This column not exists
else
	ls_FieldType = "?" //This type not identify
end if

Return ls_FieldType
end function

public function long of_find (string as_findfield, string as_findvalue, boolean ab_insert);long ll_StartRow
long i, ll_RowCount
long ll_NextStartRow
string ls_FieldValue

// Get start row
ll_StartRow = this.GetRow()
if ll_StartRow <= 0 then
	if ab_Insert then
		this.InsertRow(0)
		this.SetRow(1)
		Return - 1
	else
		Return 0
	end if
end if

// Get field value of current row
ls_FieldValue = this.GetItemString(ll_StartRow, as_FindField)

// Find value with method of double link table
if as_FindValue = ls_FieldValue then
	Return ll_StartRow
elseif of_CompareString(as_FindValue, ls_FieldValue) then
	// as_FindValue > ls_FieldValue	
	// Start row is last row
	ll_RowCount = this.RowCount()
	if ll_StartRow = ll_RowCount then
		if ab_Insert then
			ll_NextStartRow = this.InsertRow(0)
			this.SetRow(ll_NextStartRow)
			Return - ll_NextStartRow
		else
			Return 0
		end if
	end if
	
	// Move point of next start row
	for i = ll_StartRow + 1 to ll_RowCount
		ls_FieldValue = this.GetItemString(i, as_FindField)
		if as_FindValue = ls_FieldValue then
			this.SetRow(i)
			Return i
		elseif not of_CompareString(as_FindValue, ls_FieldValue) then
			// as_FindValue < ls_FieldValue
			if ab_Insert then
				ll_NextStartRow = this.InsertRow(i)
				this.SetRow(ll_NextStartRow)
				Return - ll_NextStartRow
			else
				this.SetRow(i)
				Return 0
			end if
		end if
	next
	
	// There is no match 'as_FindValue < ls_FieldValue'
	if ab_Insert then
		ll_NextStartRow = this.InsertRow(0)
		this.SetRow(ll_NextStartRow)
		Return - ll_NextStartRow
	else
		this.SetRow(ll_RowCount)
		Return 0
	end if
else // as_FindValue < ls_FieldValue
	if ab_Insert then
		//---------Begin Commented by (Appeon)Stephen 05.31.2013 for  "cannot import null to rec_id" database--------
		//ll_NextStartRow = this.InsertRow(ll_StartRow)
		ll_NextStartRow = this.InsertRow(ll_StartRow +1)
		//---------End Commented ------------------------------------------------------
		this.SetRow(ll_NextStartRow) //(Appeon)Stephen 06.28.2016 - V15.1 Contracts Import
		Return - ll_NextStartRow
	else
		Return 0
	end if
end if

// Return
Return 0
end function

public function boolean of_comparestring (string as_string1, string as_string2);ids_Sort.SetItem(1, "value", as_String1)
ids_Sort.SetItem(2, "value", as_String2)
ids_Sort.Sort()

if ids_Sort.GetItemString(2, "value") = as_String1 then
	Return true  // as_string1 > as_string2
else
	Return false // as_string1 < as_string2
end if
end function

public function integer of_createfindcolumn (ref string as_fields[]);long ll_RowCount
string ls_Create
string ls_Error
string ls_Sort
string ls_Expression
integer i, li_FieldCount

// Build expression
li_FieldCount = UpperBound(as_Fields)
for i = 1 to li_FieldCount
	//---------Begin Modified by (Appeon)Stephen 2013-09-23 for bug 3670 Import to Appointment Status--------
	//if ls_Expression <> "" then ls_Expression += " + "
	if ls_Expression <> "" then ls_Expression += " + "+"'%'"+" + "
	//---------End Modfiied ------------------------------------------------------
	ls_Expression += "if (isnull(" + as_Fields[i] + "), '', lower(string(" + as_Fields[i] + ")))"
next

// Delete compute column
this.Modify("destroy find_field")

// Create compute column
ls_Create = "create compute(band=detail alignment='0' expression=~"" + ls_Expression + "~"border='0' x='3899' y='4' height='68' width='407' name=find_field)"
ls_Error = this.Modify(ls_Create)

// Sort find field
if LenA(ls_Error) > 0 then
	Return -1
else
	if AppeonGetClientType() = "PB" then
		// PB sort compute field very slowly, so that sort by sort_field.
		ll_RowCount = this.RowCount()
		if ll_RowCount > 0 then
			this.object.sort_field[1,ll_RowCount] = this.object.find_field[1,ll_RowCount]
			this.ResetUpdate()
		end if	
		ls_Sort = "sort_field A"
	else
		ls_Sort = "find_field A"
	end if
	this.SetSort(ls_Sort)
	this.Sort()
	this.SetRow(1)
end if

Return 1
end function

public function boolean of_isnullrow (long al_row, ref integer ai_keyfieldindex[], integer ai_keyfieldcount);integer i

// Return true if no data for any key fields
for i = 1 to ai_KeyFieldCount
	if IsNull(this.object.data[al_Row, ai_KeyFieldIndex[i]]) then
		Return true
	end if
next

Return false
end function

public function boolean of_fieldexists (string as_field);//////////////////////////////////////////////////////////////////////
// $<function> of_fieldexists
// $<arguments>
//			 string	as_field
// $<returns> integer
// $<description> Determine specified field if exists
//////////////////////////////////////////////////////////////////////
// $<add> Evan 04.29.2010
//////////////////////////////////////////////////////////////////////

string ls_FieldType

ls_FieldType = this.Describe(as_Field + ".ColType")

if ls_FieldType = "!" then
	Return false
else
	Return true
end if
end function

event dberror;is_SQLErrText = SQLErrText

//---------Begin Added by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
gnv_debug.of_output( True, 'Import Error: ' + SQLErrText)
gnv_debug.of_output( True, 'Import SQLSyntax: ' + SQLSyntax)
gnv_debug.of_output( True, 'Import DSSyntax: ' + This.Describe("DataWindow.Syntax") )
//---------End Added ------------------------------------------------------
end event

on n_import_ds.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_import_ds.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ids_Sort = Create DataStore
ids_Sort.DataObject = "d_import_ds_sort"
ids_Sort.SetSort("value A")
ids_Sort.InsertRow(0)
ids_Sort.InsertRow(0)
end event

event destructor;Destroy ids_Sort
end event

