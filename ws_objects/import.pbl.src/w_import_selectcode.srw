$PBExportHeader$w_import_selectcode.srw
forward
global type w_import_selectcode from window
end type
type dw_select from u_dw within w_import_selectcode
end type
type cb_cancel from commandbutton within w_import_selectcode
end type
type dw_records from u_dw within w_import_selectcode
end type
type cb_select from commandbutton within w_import_selectcode
end type
type gb_1 from groupbox within w_import_selectcode
end type
type gb_2 from groupbox within w_import_selectcode
end type
end forward

global type w_import_selectcode from window
integer width = 2267
integer height = 1984
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
dw_select dw_select
cb_cancel cb_cancel
dw_records dw_records
cb_select cb_select
gb_1 gb_1
gb_2 gb_2
end type
global w_import_selectcode w_import_selectcode

type variables
string is_Return = "Cancel!"

// Lookup table
DataStore ids_LookUpTableDDDW[2]
end variables

forward prototypes
public function long of_retrieve ()
public function integer of_setdwnull ()
public function string of_getcoltype (string as_field)
end prototypes

public function long of_retrieve ();string ls_code_type
string ls_lookup_table

ls_code_type = dw_select.object.code_type[1]
ls_lookup_table = dw_select.object.lookup_table[1]

choose case dw_select.object.code_type[1]
	case "A" //Address		
		if dw_records.DataObject <> "d_import_selectcode_address" then
			dw_records.DataObject = "d_import_selectcode_address"
			dw_records.SetTransObject(SQLCA)
		end if
		dw_records.Retrieve(ls_lookup_table)
		
	case "C" //Code
		if dw_records.DataObject <> "d_import_selectcode_code" then
			dw_records.DataObject = "d_import_selectcode_code"
			dw_records.SetTransObject(SQLCA)
		end if
		dw_records.Retrieve(ls_lookup_table)
		
	case "F" //Facility
		if dw_records.DataObject <> "d_import_selectcode_facility" then
			dw_records.DataObject = "d_import_selectcode_facility"
			dw_records.SetTransObject(SQLCA)
		end if
		dw_records.Retrieve()
		
	case "M" //Committee
		if dw_records.DataObject <> "d_import_selectcode_committee" then
			dw_records.DataObject = "d_import_selectcode_committee"
			dw_records.SetTransObject(SQLCA)
		end if
		dw_records.Retrieve()
		
	case "I"	//Company
		if dw_records.DataObject <> "d_import_selectcode_company" then
			dw_records.DataObject = "d_import_selectcode_company"
			dw_records.SetTransObject(SQLCA)
		end if
		dw_records.Retrieve()
		
	case "S"	//Active Status (V10.1 - Import Active Status)
		if dw_records.DataObject <> "d_import_selectcode_activestatus" then
			dw_records.DataObject = "d_import_selectcode_activestatus"
			dw_records.SetTransObject(SQLCA)
		end if
		dw_records.Retrieve()

	case "Q"	//QA Metrics (V11.3 QA Import)
		if dw_records.DataObject <> "d_import_selectcode_metrics" then
			dw_records.DataObject = "d_import_selectcode_metrics"
			dw_records.SetTransObject(SQLCA)
		end if
		dw_records.Retrieve()
end choose

dw_records.SelectRow(0, false)
dw_records.SelectRow(dw_records.GetRow(), true)
dw_records.Modify("DataWindow.ReadOnly='Yes'")
		
Return 1
end function

public function integer of_setdwnull ();if dw_records.DataObject = "d_import_selectcode" then
	Return 1
end if

dw_records.SetRedraw(false)
dw_records.DataObject = "d_import_selectcode"
dw_records.object.datawindow.detail.height = 0
dw_records.SetRedraw(true)

Return 1
end function

public function string of_getcoltype (string as_field);string ls_FieldType

ls_FieldType = Upper(dw_records.Describe(as_Field + ".ColType"))

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

on w_import_selectcode.create
this.dw_select=create dw_select
this.cb_cancel=create cb_cancel
this.dw_records=create dw_records
this.cb_select=create cb_select
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.dw_select,&
this.cb_cancel,&
this.dw_records,&
this.cb_select,&
this.gb_1,&
this.gb_2}
end on

on w_import_selectcode.destroy
destroy(this.dw_select)
destroy(this.cb_cancel)
destroy(this.dw_records)
destroy(this.cb_select)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event close;Destroy ids_LookUpTableDDDW[1]
Destroy ids_LookUpTableDDDW[2]

CloseWithReturn(this, is_Return)
end event

event open;// Retrieve lookup table data
ids_LookUpTableDDDW[1] = Create DataStore
ids_LookUpTableDDDW[2] = Create DataStore

ids_LookUpTableDDDW[1].DataObject = "d_import_lu_temp1"
ids_LookUpTableDDDW[2].DataObject = "d_import_lu_temp2"
ids_LookUpTableDDDW[1].SetTransObject(SQLCA)
ids_LookUpTableDDDW[2].SetTransObject(SQLCA)

gnv_appeondb.of_startqueue()
ids_LookUpTableDDDW[1].Retrieve()
ids_LookUpTableDDDW[2].Retrieve()
gnv_appeondb.of_commitqueue()

// Locate specific code table
dw_select.SetItem(1, "code_type", "F")
dw_select.Event ItemChanged(1, dw_select.object.code_type, "F")
end event

type dw_select from u_dw within w_import_selectcode
event mousemove pbm_mousemove
string tag = "dw_imp"
integer x = 46
integer y = 76
integer width = 2149
integer height = 220
integer taborder = 30
string dragicon = "droparrow.ico"
string dataobject = "d_import_selectcode"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;//Inherit
string ls_Null
DataWindowChild ldwc_Child
DataWindowChild ldwc_FieldChild

SetNull(ls_Null)
this.AcceptText()

choose case dwo.name
	case "code_type"
		this.SetItem(Row, "lookup_table", ls_Null)		
		this.GetChild("field_name", ldwc_FieldChild)		
		choose case Data
			case "A" //Address
				this.GetChild("lookup_table_dddw", ldwc_Child)
				ldwc_Child.Reset()
				ids_LookUpTableDDDW[1].RowsCopy(1, ids_LookUpTableDDDW[1].RowCount(), Primary!, ldwc_Child, 1, Primary!)				
				ldwc_FieldChild.SetFilter("lookup_type='A' and id<>0")
				this.SetItem(Row, "field_name", "entity_name")
			case "C" //Code
				this.GetChild("lookup_table_dddw", ldwc_Child)
				ids_LookUpTableDDDW[2].RowsCopy(1, ids_LookUpTableDDDW[2].RowCount(), Primary!, ldwc_Child, 1, Primary!)
				ldwc_FieldChild.SetFilter("lookup_type='C' and id<>0")
				this.SetItem(Row, "field_name", "description")
			case "F" //Facility
				this.SetItem(Row, "lookup_table", "Facility")
				ldwc_FieldChild.SetFilter("lookup_type='F' and id<>0")
				this.SetItem(Row, "field_name", "facility_name")
			case "M" //Committee
				this.SetItem(Row, "lookup_table", "Committee")
				ldwc_FieldChild.SetFilter("lookup_type='M' and id<>0")
				this.SetItem(Row, "field_name", "committee_name")
			case "I"	//Company
				this.SetItem(Row, "lookup_table", "Company")
				ldwc_FieldChild.SetFilter("lookup_type='I' and id<>0")
				this.SetItem(Row, "field_name", "facility_name")
			case "S"	//Active Status (V10.1 - Import Active Status)
				this.SetItem(Row, "lookup_table", "Active Status")
				ldwc_FieldChild.SetFilter("lookup_type='S' and id<>0")
				this.SetItem(Row, "field_name", "active_status_name")
			case "Q"	//QA Metrics (V11.3 QA Import)
				this.SetItem(Row, "lookup_table", "QA Metrics")
				ldwc_FieldChild.SetFilter("lookup_type='Q' and id<>0")
				this.SetItem(Row, "field_name", "description")
		end choose
		ldwc_FieldChild.Filter()
		this.SetRedraw(true)
		
		if IsNull(this.object.code_type[Row]) or IsNull(this.object.lookup_table[Row]) then
			Parent.of_SetDWNull()
		else
			Parent.of_Retrieve()
		end if
		
	case "lookup_table_dddw"
		if IsNull(this.object.code_type[Row]) or IsNull(this.object.lookup_table[Row]) then
			Parent.of_SetDWNull()
		else
			Parent.of_Retrieve()
		end if
end choose
end event

type cb_cancel from commandbutton within w_import_selectcode
integer x = 1879
integer y = 1848
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type dw_records from u_dw within w_import_selectcode
event mousemove pbm_mousemove
string tag = "dw_imp"
integer x = 59
integer y = 392
integer width = 2126
integer height = 1396
integer taborder = 10
string dragicon = "droparrow.ico"
string dataobject = "d_import_selectcode_company"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;//Inherit
this.of_SetRowSelect(true)
end event

event doubleclicked;call super::doubleclicked;cb_select.Event Clicked()
end event

type cb_select from commandbutton within w_import_selectcode
integer x = 1495
integer y = 1848
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Select"
boolean default = true
end type

event clicked;string ls_Value
string ls_field_name
long ll_CurrentRow

// Prompt
if dw_records.DataObject = "d_import_selectcode" then
	MessageBox("Select", "Please select Code Type and Lookup Table, then select record.")
	if IsNull(dw_select.object.code_type[1]) then
		dw_select.SetColumn("code_type")
	else
		dw_select.SetColumn("lookup_table_dddw")
	end if
	dw_select.SetFocus()
	Return
end if

ll_CurrentRow = dw_records.GetRow()
if ll_CurrentRow <= 0 then
	MessageBox("Select", "No record was selected.")
	Return
end if

// Get value
ls_field_name = dw_select.object.field_name[1]
if of_GetColType(ls_field_name) = "N" then
	ls_Value = String(dw_records.GetItemNumber(ll_CurrentRow, ls_field_name))
else
	ls_Value = dw_records.GetItemString(ll_CurrentRow, ls_field_name)
end if

is_Return = "OK!" + ls_Value
Close(Parent)
end event

type gb_1 from groupbox within w_import_selectcode
integer x = 27
integer y = 16
integer width = 2190
integer height = 292
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select Code Table"
end type

type gb_2 from groupbox within w_import_selectcode
integer x = 27
integer y = 324
integer width = 2190
integer height = 1492
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Records"
end type

