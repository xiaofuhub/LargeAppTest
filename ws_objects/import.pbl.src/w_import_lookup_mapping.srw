$PBExportHeader$w_import_lookup_mapping.srw
forward
global type w_import_lookup_mapping from window
end type
type dw_map from u_dw within w_import_lookup_mapping
end type
type dw_imp from u_dw within w_import_lookup_mapping
end type
type dw_lu_recs from u_dw within w_import_lookup_mapping
end type
type st_4 from statictext within w_import_lookup_mapping
end type
type st_3 from statictext within w_import_lookup_mapping
end type
type cb_save from commandbutton within w_import_lookup_mapping
end type
type cb_del_temp from commandbutton within w_import_lookup_mapping
end type
type cb_add_temp from commandbutton within w_import_lookup_mapping
end type
type dw_temp_detail from datawindow within w_import_lookup_mapping
end type
type dw_select from datawindow within w_import_lookup_mapping
end type
type cb_close from commandbutton within w_import_lookup_mapping
end type
type ln_1 from line within w_import_lookup_mapping
end type
type ln_2 from line within w_import_lookup_mapping
end type
type gb_1 from groupbox within w_import_lookup_mapping
end type
type gb_2 from groupbox within w_import_lookup_mapping
end type
type st_5 from statictext within w_import_lookup_mapping
end type
type st_2 from statictext within w_import_lookup_mapping
end type
end forward

global type w_import_lookup_mapping from window
integer width = 4297
integer height = 2188
boolean titlebar = true
string title = "Import Lookup Mapping"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
event ue_retrieve ( )
event ue_iv_getfrommap ( )
event ue_iv_getfromfile ( )
event ue_iv_add ( )
event ue_iv_delete ( )
event ue_iv_edit ( )
event ue_iv_saveas ( )
event ue_iv_reset ( )
dw_map dw_map
dw_imp dw_imp
dw_lu_recs dw_lu_recs
st_4 st_4
st_3 st_3
cb_save cb_save
cb_del_temp cb_del_temp
cb_add_temp cb_add_temp
dw_temp_detail dw_temp_detail
dw_select dw_select
cb_close cb_close
ln_1 ln_1
ln_2 ln_2
gb_1 gb_1
gb_2 gb_2
st_5 st_5
st_2 st_2
end type
global w_import_lookup_mapping w_import_lookup_mapping

type variables
string is_master_errinfo
string is_detail_errinfo

DataStore ids_LookUpTableDDDW[2]
DataStore ids_LookUpTableData[7] //V11.3 QA Import

boolean ib_DeletePrompt = true
string is_IsChange = "NO!"

// Control drag variables
long il_DragRow

// Selected rows
long il_DragValue[]
string is_DragValue[]
long il_SelectedCount
end variables

forward prototypes
public function integer of_set_detaildw_enabled (boolean ab_enabled)
public function integer of_savemaster ()
public function long of_retrievedddw ()
public function integer of_begindrag (datawindow adw_data)
public function integer of_savedetail ()
end prototypes

event ue_retrieve();ids_LookUpTableDDDW[1] = Create DataStore
ids_LookUpTableDDDW[2] = Create DataStore
ids_LookUpTableData[1] = Create DataStore
ids_LookUpTableData[2] = Create DataStore
ids_LookUpTableData[3] = Create DataStore
ids_LookUpTableData[4] = Create DataStore
ids_LookUpTableData[5] = Create DataStore
ids_LookUpTableData[6] = Create DataStore //V10.1 - Import Active Status
ids_LookUpTableData[7] = Create DataStore //V11.3 QA Import

ids_LookUpTableDDDW[1].DataObject = "d_import_lu_temp1"
ids_LookUpTableDDDW[2].DataObject = "d_import_lu_temp2"
ids_LookUpTableData[1].DataObject = "d_import_lu_temp3"
ids_LookUpTableData[2].DataObject = "d_import_lu_temp4"
ids_LookUpTableData[3].DataObject = "d_import_lu_temp5"
ids_LookUpTableData[4].DataObject = "d_import_lu_temp6"
ids_LookUpTableData[5].DataObject = "d_import_lu_temp7"
ids_LookUpTableData[6].DataObject = "d_import_lu_temp8"
ids_LookUpTableData[7].DataObject = "d_import_lu_temp9"

ids_LookUpTableDDDW[1].SetTransObject(SQLCA)
ids_LookUpTableDDDW[2].SetTransObject(SQLCA)
ids_LookUpTableData[1].SetTransObject(SQLCA)
ids_LookUpTableData[2].SetTransObject(SQLCA)
ids_LookUpTableData[3].SetTransObject(SQLCA)
ids_LookUpTableData[4].SetTransObject(SQLCA)
ids_LookUpTableData[5].SetTransObject(SQLCA)
ids_LookUpTableData[6].SetTransObject(SQLCA)
ids_LookUpTableData[7].SetTransObject(SQLCA)

gnv_appeondb.of_StartQueue()
ids_LookUpTableDDDW[1].Retrieve()
ids_LookUpTableDDDW[2].Retrieve()
ids_LookUpTableData[1].Retrieve()
ids_LookUpTableData[2].Retrieve()
ids_LookUpTableData[3].Retrieve()
ids_LookUpTableData[4].Retrieve()
ids_LookUpTableData[5].Retrieve()
ids_LookUpTableData[6].Retrieve()
ids_LookUpTableData[7].Retrieve()
dw_temp_detail.Retrieve()
dw_map.Retrieve()
gnv_appeondb.of_CommitQueue()
end event

event ue_iv_getfrommap();string ls_Value
long ll_InsertRow
long i, ll_FindRow
integer li_Return

// Prompt
if dw_imp.RowCount() > 0 then
	li_Return = MessageBox("Prompt", "Do you want to delete current import values?", Question!, YesNoCancel!)
	if li_Return = 3 then
		Return		
	elseif li_Return = 1 then
		dw_imp.Reset()
	end if
end if

// Add value
for i = 1 to dw_map.RowCount()
	ls_Value = dw_map.GetItemString(i, "import_value")
	if IsNull(ls_Value) or ls_Value = "" then Continue
	
	ll_FindRow = dw_imp.Find("import_value = '" + ls_Value + "'", 1, dw_imp.RowCount())
	if ll_FindRow <= 0 then
		ll_InsertRow = dw_imp.InsertRow(0)
		dw_imp.object.import_value[ll_InsertRow] = ls_Value
	end if
next

dw_imp.SetSort("import_value A")
dw_imp.Sort()
dw_imp.ScrollToRow(1)
dw_imp.SelectRow(0, false)
dw_imp.SelectRow(1, true)
end event

event ue_iv_getfromfile();string  ls_Value
string  ls_DocPath
string  ls_DocName
integer li_Return
long ll_InsertRow
long i, ll_FindRow
DataStore lds_imp_data

// Get import file name
//---------Begin Modified by (Appeon)Toney 06.17.2013 for V141 ISG-CLX--------
  /*
    li_Return = GetFileOpenName("Select File", ls_DocPath, ls_DocName, "TXT", "Text Files (*.TXT),*.TXT", gs_current_path)
	ChangeDirectory(gs_current_path) //Add by Evan 12/11/2008  
  */
gf_load_dir_path() //Added by Ken.Guo on 2009-03-10
li_Return = GetFileOpenName("Select File", ls_DocPath, ls_DocName, "TXT", "Text Files (*.TXT),*.TXT")
gf_save_dir_path(ls_DocPath) //Added by Ken.Guo on 2009-03-10 
//---------End Modfiied ------------------------------------------------------------------
if li_Return <> 1 then Return

// Get import data
lds_imp_data = Create DataStore
lds_imp_data.DataObject = "d_import_lu_value"
lds_imp_data.ImportFile(ls_DocPath)

if lds_imp_data.RowCount() <= 0 then
	Destroy lds_imp_data
	Return
end if
if dw_imp.RowCount() > 0 then
	li_Return = MessageBox("Prompt", "Do you want to delete current import values?", Question!, YesNoCancel!)
	if li_Return = 3 then
		Destroy lds_imp_data
		Return		
	elseif li_Return = 1 then
		dw_imp.Reset()
	end if
end if

// Add value
for i = 1 to lds_imp_data.RowCount()
	ls_Value = lds_imp_data.GetItemString(i, "import_value")
	if IsNull(ls_Value) or ls_Value = "" then Continue
	
	ll_FindRow = dw_imp.Find("import_value = '" + ls_Value + "'", 1, dw_imp.RowCount())
	if ll_FindRow <= 0 then
		ll_InsertRow = dw_imp.InsertRow(0)
		dw_imp.object.import_value[ll_InsertRow] = ls_Value
	end if
next
Destroy lds_imp_data

// Resort
dw_imp.SetSort("import_value A")
dw_imp.Sort()
dw_imp.ScrollToRow(1)
dw_imp.SelectRow(0, false)
dw_imp.SelectRow(1, true)
end event

event ue_iv_add();long ll_InsertRow

OpenWithParm(w_import_impvalue_edit, "ADD|NULL")
if Message.StringParm = "Cancel!" then Return

ll_InsertRow = dw_imp.InsertRow(0)
dw_imp.SetItem(ll_InsertRow, "import_value", Message.StringParm)
end event

event ue_iv_delete();if dw_imp.GetRow() > 0 then
	if MessageBox("Prompt", "Are you sure you want to delete this import value?", Question!, YesNo!) = 2 then Return
	dw_imp.DeleteRow(0)
end if
end event

event ue_iv_edit();long ll_CurrentRow
string ls_Value

ll_CurrentRow = dw_imp.GetRow()
if ll_CurrentRow <= 0 then Return
ls_Value = dw_imp.GetItemString(ll_CurrentRow, "import_value")

OpenWithParm(w_import_impvalue_edit, "EDIT|" + ls_Value)
if Message.StringParm = "Cancel!" then Return

dw_imp.SetItem(ll_CurrentRow, "import_value", Message.StringParm)
end event

event ue_iv_saveas();string ls_Path
string ls_File
integer li_Return

if dw_imp.RowCount() <= 0 then
	MessageBox("Prompt", "Please add value.")
	Return
end if
//---------Begin Modified by (Appeon)Toney 06.17.2013 for V141 ISG-CLX--------
  /*
	li_Return = GetFileSaveName ("Save As", ls_Path, ls_File, "TXT", "Text Files (*.TXT),*.TXT" , gs_current_path)
	ChangeDirectory(gs_current_path) //Add by Evan 12/11/2008      
  */
gf_load_dir_path() //Added by Ken.Guo on 2009-03-10
li_Return = GetFileSaveName ("Save As", ls_Path, ls_File, "TXT", "Text Files (*.TXT),*.TXT")
gf_save_dir_path(ls_Path) //Added by Ken.Guo on 2009-03-10 
//---------End Modfiied ------------------------------------------------------------------
if li_Return <> 1 then Return

if FileExists(ls_Path) then
	li_Return = MessageBox("Confirm File Replace", "This folder already contains a file named '" + ls_File + "'." + &
									"~r~nWould you like to replace the existing file?", Question!, YesNo!)
	if li_Return <> 1 then Return 
end if
//---------Begin Added by (Appeon)Toney 06.17.2013 for V141 ISG-CLX--------
gnv_rights.of_check_dir_right( ls_Path, true, 'Import Save')
//---------End Added ------------------------------------------------------------------

dw_imp.SaveAs(ls_Path, Text!, false)
end event

event ue_iv_reset();dw_imp.Reset()
end event

public function integer of_set_detaildw_enabled (boolean ab_enabled);if ab_Enabled then
	dw_temp_detail.object.map_type.protect = 0
	dw_temp_detail.object.template_name.protect = 0
	//dw_temp_detail.object.lookup_table.protect = 0
	
	dw_temp_detail.object.map_type.background.color = 16777215
	dw_temp_detail.object.template_name.background.color = 16777215
	//dw_temp_detail.object.lookup_table.background.color = 16777215		
else
	dw_temp_detail.object.map_type.protect = 1
	dw_temp_detail.object.template_name.protect = 1
	//dw_temp_detail.object.lookup_table.protect = 1	
	
	dw_temp_detail.object.map_type.background.color = 67108864
	dw_temp_detail.object.template_name.background.color = 67108864
	//dw_temp_detail.object.lookup_table.background.color = 67108864	
end if

Return 1
end function

public function integer of_savemaster ();dw_temp_detail.AcceptText()

if dw_temp_detail.ModifiedCount() + dw_temp_detail.DeletedCount() > 0 then
	if dw_temp_detail.Update() = 1 then
		Commit;
		of_RetrieveDDDW()
		is_IsChange = "YES!"
		Return 1
	else
		Rollback;
		MessageBox("Error", is_master_errinfo, StopSign!)
		Return -1
	end if	
end if

Return 1
end function

public function long of_retrievedddw ();long ll_Null
long ll_CurrentRow
DataWindowChild ldw_Child

dw_select.GetChild("ilm_id", ldw_Child)
ldw_Child.Reset()

ll_CurrentRow = dw_temp_detail.GetRow()
if ll_CurrentRow > 0 then
	dw_temp_detail.RowsCopy(1, dw_temp_detail.RowCount(), Primary!, ldw_Child, 1, Primary!)
	dw_select.SetItem(1, "ilm_id", dw_temp_detail.object.ilm_id[ll_CurrentRow])
else
	SetNull(ll_Null)
	dw_select.SetItem(1, "ilm_id", ll_Null)
end if
ldw_Child.SetSort("template_name A")
ldw_Child.Sort()
ldw_Child.SelectRow(0, false)

dw_select.SetRedraw(true)

Return ldw_Child.RowCount()
end function

public function integer of_begindrag (datawindow adw_data);if KeyDown(KeyLeftButton!) and il_DragRow > 0 then
	adw_data.Drag(Begin!)
end if

Return 1
end function

public function integer of_savedetail ();dw_map.AcceptText()

if dw_map.ModifiedCount() + dw_map.DeletedCount() > 0 then
	if dw_map.Update() = 1 then
		Commit;
		is_IsChange = "YES!"
		Return 1
	else
		Rollback;
		MessageBox("Error", is_detail_errinfo, StopSign!)
		Return -1
	end if
end if

Return 1
end function

on w_import_lookup_mapping.create
this.dw_map=create dw_map
this.dw_imp=create dw_imp
this.dw_lu_recs=create dw_lu_recs
this.st_4=create st_4
this.st_3=create st_3
this.cb_save=create cb_save
this.cb_del_temp=create cb_del_temp
this.cb_add_temp=create cb_add_temp
this.dw_temp_detail=create dw_temp_detail
this.dw_select=create dw_select
this.cb_close=create cb_close
this.ln_1=create ln_1
this.ln_2=create ln_2
this.gb_1=create gb_1
this.gb_2=create gb_2
this.st_5=create st_5
this.st_2=create st_2
this.Control[]={this.dw_map,&
this.dw_imp,&
this.dw_lu_recs,&
this.st_4,&
this.st_3,&
this.cb_save,&
this.cb_del_temp,&
this.cb_add_temp,&
this.dw_temp_detail,&
this.dw_select,&
this.cb_close,&
this.ln_1,&
this.ln_2,&
this.gb_1,&
this.gb_2,&
this.st_5,&
this.st_2}
end on

on w_import_lookup_mapping.destroy
destroy(this.dw_map)
destroy(this.dw_imp)
destroy(this.dw_lu_recs)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.cb_save)
destroy(this.cb_del_temp)
destroy(this.cb_add_temp)
destroy(this.dw_temp_detail)
destroy(this.dw_select)
destroy(this.cb_close)
destroy(this.ln_1)
destroy(this.ln_2)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.st_5)
destroy(this.st_2)
end on

event open;long ll_ilm_id

// Retrieve template
ll_ilm_id = Message.DoubleParm
this.Event ue_Retrieve()

// Retrieve selection DDDW data
if dw_temp_detail.RowCount() > 0 then
	of_RetrieveDDDW()
else
	dw_temp_detail.InsertRow(0)
	of_set_detaildw_enabled(false)
end if

// Locate specific template
if ll_ilm_id > 0 then
	dw_select.SetItem(1, "ilm_id", ll_ilm_id)
	dw_select.Event ItemChanged(1, dw_select.object.ilm_id, String(ll_ilm_id))
end if
end event

event closequery;//over
boolean lb_Prompt = false

dw_temp_detail.AcceptText()
dw_map.AcceptText()

if dw_temp_detail.ModifiedCount() + dw_temp_detail.DeletedCount() > 0 then
	lb_Prompt = true
end if
if dw_map.ModifiedCount() + dw_map.DeletedCount() > 0 then
	lb_Prompt = true
end if

if lb_Prompt then
	if MessageBox("Save data", "Close without saving changes?", Question!, YesNo!) = 2 then
		Return 1
	end if	
end if
end event

event close;Destroy ids_LookUpTableDDDW[1]
Destroy ids_LookUpTableDDDW[2]
Destroy ids_LookUpTableData[1]
Destroy ids_LookUpTableData[2]
Destroy ids_LookUpTableData[3]
Destroy ids_LookUpTableData[4]
Destroy ids_LookUpTableData[5]
Destroy ids_LookUpTableData[6] //V10.1 - Import Active Status
Destroy ids_LookUpTableData[7] //V11.3 QA Import

CloseWithReturn(this, is_IsChange)
end event

type dw_map from u_dw within w_import_lookup_mapping
event ue_dragdrop ( string as_dw,  long al_row )
string tag = "dw_map"
integer x = 1138
integer y = 528
integer width = 2021
integer height = 1572
integer taborder = 80
string dragicon = "droparrow.ico"
string dataobject = "d_import_lu_map_fields"
boolean hscrollbar = true
end type

event ue_dragdrop(string as_dw, long al_row);long i, ll_FindRow
long ll_InsertRow
long ll_CurrentRow
long ll_ilm_id
long ll_dv_lookup_value
string ls_dv_import_value

if not (as_DW = "dw_lu_recs" or as_DW = "dw_imp") then Return
of_SaveMaster()
ll_CurrentRow = dw_temp_detail.GetRow()
ll_ilm_id = dw_temp_detail.object.ilm_id[ll_CurrentRow]
if IsNull(ll_ilm_id) then
	MessageBox("Prompt", "Please add mapping template first.")
	Return
end if

if as_DW = "dw_lu_recs" then
	ll_dv_lookup_value = dw_lu_recs.object.lookup_code[il_DragRow]
	/*
	ll_FindRow = this.Find("is_lu_code_dddw=" + String(ll_dv_lookup_value), 1, this.RowCount())
	if ll_FindRow > 0 then
		this.ScrollToRow(ll_FindRow)
		MessageBox("Prompt", "The Lookup Code already exists.")
		Return
	end if
	*/
	
	// Insert or replace a mapped record
	if al_Row > 0 then
		this.object.is_lu_code[al_Row] = ll_dv_lookup_value
	else		
		for i = 1 to il_SelectedCount
			ll_InsertRow = this.InsertRow(0)
			this.object.is_lu_code[ll_InsertRow] = il_DragValue[i]
			this.object.ilm_id[ll_InsertRow] = ll_ilm_id
		next
		this.ScrollToRow(ll_InsertRow)
	end if
else
	// Insert or replace a mapped record
	if al_Row > 0 then
		ls_dv_import_value = dw_imp.object.import_value[il_DragRow]
		ll_FindRow = this.Find("Lower(import_value)='" + Lower(ls_dv_import_value) + "'", 1, this.RowCount())
		if ll_FindRow > 0 then
			this.ScrollToRow(ll_FindRow)
			MessageBox("Prompt", "The Import Value already exists.")
		else
			this.object.import_value[al_Row] = ls_dv_import_value
		end if
	else
		for i = 1 to il_SelectedCount
			ll_FindRow = this.Find("Lower(import_value)='" + Lower(is_DragValue[i]) + "'", 1, this.RowCount())
			if ll_FindRow <= 0 then
				ll_InsertRow = this.InsertRow(0)
				this.object.import_value[ll_InsertRow] = is_DragValue[i]
				this.object.ilm_id[ll_InsertRow] = ll_ilm_id
			end if
		next
		if ll_InsertRow > 0 then this.ScrollToRow(ll_InsertRow)		
	end if
end if

// Update mapped records
of_SaveDetail()
end event

event clicked;call super::clicked;//inherit
il_DragRow = Row

end event

event constructor;call super::constructor;//Inherit
this.SetTransObject(SQLCA)
this.of_SetRowSelect(true)
//this.DragIcon = gs_current_path + "\row.ico" //Start Code Change ----08.14.2013 #V14 maha - removed
end event

event dragdrop;call super::dragdrop;this.Event ue_DragDrop(Source.tag, Row)
end event

event dberror;//Override
is_detail_errinfo = SQLErrText

Return 1
end event

event dragwithin;call super::dragwithin;if Source.tag = "dw_lu_recs" or Source.tag = "dw_imp" then
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

event doubleclicked;call super::doubleclicked;if Row > 0 then
	if MessageBox("Prompt", "Are you sure you want to delete the record?", Question!, YesNo!) = 1 then
		il_DragRow = Row
		dw_lu_recs.Event ue_DragDrop()		
	end if
end if
end event

event mousemove;call super::mousemove;of_BeginDrag(this)
end event

type dw_imp from u_dw within w_import_lookup_mapping
string tag = "dw_imp"
integer x = 3255
integer y = 528
integer width = 1019
integer height = 1572
integer taborder = 90
string dragicon = "droparrow.ico"
string dataobject = "d_import_lu_value"
boolean hscrollbar = true
end type

event clicked;call super::clicked;//inherit
long i

il_DragRow = Row
il_SelectedCount = 0

for i = 1 to this.RowCount()
	if this.IsSelected(i) then
		il_SelectedCount ++
		is_DragValue[il_SelectedCount] = this.object.import_value[i]
	end if
next
end event

event constructor;call super::constructor;//Inherit
this.of_SetRowSelect(true)
inv_RowSelect.of_SetStyle(inv_RowSelect.EXTENDED)
//this.DragIcon = gs_current_path + "\row.ico" //Start Code Change ----08.14.2013 #V14 maha - removed
end event

event dragdrop;call super::dragdrop;long ll_DeleteRow
long ll_dv_map_id

// Delete a mapped record
if Source.tag <> "dw_map" then Return

ll_dv_map_id = dw_map.object.map_id[il_DragRow]
ll_DeleteRow = dw_map.Find("map_id=" + String(ll_dv_map_id), 1, dw_map.RowCount())
if ll_DeleteRow > 0 then	
	if dw_map.RowCount() > 1 then
		dw_map.DeleteRow(ll_DeleteRow)
	else
		MessageBox("Prompt", "Template must have mapped value.")
		Return
	end if	
else
	Return
end if

// Update mapped records
of_SaveDetail()
end event

event doubleclicked;call super::doubleclicked;if Row > 0 then
	il_DragRow = Row
	dw_map.Event ue_DragDrop(this.tag, 0)
end if
end event

event rbuttondown;//overwrite
m_import_impvalue_edit lm_edit

this.SetRow(Row)
this.SelectRow(0, false)
this.SelectRow(this.GetRow(), true)

lm_edit = Create m_import_impvalue_edit
lm_edit.iw_window = Parent
lm_edit.PopMenu(Parent.PointerX(), Parent.PointerY())
Destroy lm_edit
end event

event mousemove;call super::mousemove;of_BeginDrag(this)
end event

type dw_lu_recs from u_dw within w_import_lookup_mapping
event ue_filter ( )
event ue_dragdrop ( )
string tag = "dw_lu_recs"
integer y = 520
integer width = 1019
integer height = 1572
integer taborder = 70
string dragicon = "droparrow.ico"
string dataobject = "d_import_lu_code"
boolean hscrollbar = true
end type

event ue_filter();string ls_map_type
string ls_lookup_name
long ll_CurrentRow
DataWindowChild ldwc_Child

this.Reset()
dw_temp_detail.AcceptText()
ll_CurrentRow = dw_temp_detail.GetRow()
if ll_CurrentRow <= 0 then Return

ls_map_type = dw_temp_detail.object.map_type[ll_CurrentRow]
ls_lookup_name = dw_temp_detail.object.lookup_table[ll_CurrentRow]

choose case ls_map_type
	case "A" //Address
		ids_LookUpTableData[1].SetFilter("lookup_name = '" + ls_lookup_name + "'")
		ids_LookUpTableData[1].Filter()
		this.ImportString(ids_LookUpTableData[1].object.datawindow.data, 1, ids_LookUpTableData[1].RowCount(), 2)
	case "C" //Code			
		ids_LookUpTableData[2].SetFilter("lookup_name = '" + ls_lookup_name + "'")
		ids_LookUpTableData[2].Filter()
		this.ImportString(ids_LookUpTableData[2].object.datawindow.data, 1, ids_LookUpTableData[2].RowCount(), 2)
	case "F" //Facility
		this.ImportString(ids_LookUpTableData[3].object.datawindow.data)
	case "M" //Committee
		this.ImportString(ids_LookUpTableData[4].object.datawindow.data)
	case "I" //Company
		this.ImportString(ids_LookUpTableData[5].object.datawindow.data)
	case "S" //Active Status (V10.1 - Import Active Status)
		this.ImportString(ids_LookUpTableData[6].object.datawindow.data)
	case "Q" //QA Metrics (V11.3 QA Import)
		this.ImportString(ids_LookUpTableData[7].object.datawindow.data)
end choose
this.SetSort("lookup_display A")
this.Sort()
this.SetRow(1)
this.SelectRow(0, false)
this.SelectRow(1, true)
	
dw_map.GetChild("is_lu_code_dddw", ldwc_Child)
ldwc_Child.Reset()
this.RowsCopy(1, this.RowCount(), Primary!, ldwc_Child, 1, Primary!)
dw_map.SetRedraw(true)
end event

event ue_dragdrop();long ll_DeleteRow
long ll_dv_map_id

ll_dv_map_id = dw_map.object.map_id[il_DragRow]
ll_DeleteRow = dw_map.Find("map_id=" + String(ll_dv_map_id), 1, dw_map.RowCount())
if ll_DeleteRow > 0 then	
	if dw_map.RowCount() > 1 then
		dw_map.DeleteRow(ll_DeleteRow)
	else
		MessageBox("Prompt", "Template must have mapped value.")
		Return
	end if
else
	Return
end if

// Update mapped records
of_SaveDetail()
end event

event clicked;call super::clicked;//inherit
long i

il_DragRow = Row
il_SelectedCount = 0

for i = 1 to this.RowCount()
	if this.IsSelected(i) then
		il_SelectedCount ++
		il_DragValue[il_SelectedCount] = this.object.lookup_code[i]
	end if
next
end event

event dragdrop;call super::dragdrop;// Delete a mapped record
if Source.tag = "dw_map" then
	this.Event ue_DragDrop()
end if
	

end event

event constructor;call super::constructor;//Inherit
this.of_SetRowSelect(true)
inv_RowSelect.of_SetStyle(inv_RowSelect.EXTENDED)
//this.DragIcon = gs_current_path + "\row.ico" //Start Code Change ----08.14.2013 #V14 maha - removed
end event

event doubleclicked;call super::doubleclicked;if Row > 0 then
	il_DragRow = Row
	dw_map.Event ue_DragDrop(this.tag, 0)
end if
end event

event mousemove;call super::mousemove;of_BeginDrag(this)
end event

type st_4 from statictext within w_import_lookup_mapping
integer x = 178
integer y = 460
integer width = 416
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Lookup Records"
boolean focusrectangle = false
end type

type st_3 from statictext within w_import_lookup_mapping
integer x = 1509
integer y = 460
integer width = 398
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Mapped Values"
boolean focusrectangle = false
end type

type cb_save from commandbutton within w_import_lookup_mapping
integer x = 3552
integer y = 52
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
boolean default = true
end type

event clicked;dw_temp_detail.AcceptText()
if dw_temp_detail.ModifiedCount() + dw_temp_detail.DeletedCount() > 0 then
	if dw_map.RowCount() <= 0 then
		MessageBox("Prompt", "There is no mapped value. Data cannot be saved.")
		Return -1
	end if
end if

if of_SaveMaster() = 1 then
	of_SaveDetail()
end if
end event

type cb_del_temp from commandbutton within w_import_lookup_mapping
integer x = 1765
integer y = 64
integer width = 430
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete Template"
end type

event clicked;long ll_Null
long ll_ilm_id
long ll_CurrentRow
long ll_lu_template
long ll_RefTemplateCount
DataWindowChild ldw_Child

// Prompt
if dw_temp_detail.object.map_type.protect = '1' then
	if ib_DeletePrompt then MessageBox("Prompt", "No template can be deleted.")
	Return
end if
ll_lu_template = dw_temp_detail.object.ilm_id[dw_temp_detail.GetRow()]
if not IsNull(ll_lu_template) then
	SELECT count(*) INTO :ll_RefTemplateCount FROM import_mapping_fields WHERE lu_template = :ll_lu_template;
	if ll_RefTemplateCount > 0 then
		MessageBox("Prompt", "Can not delete the template which is connected to other tables.")
		Return
	end if
end if
if ib_DeletePrompt then
	if MessageBox("Prompt", "Are you sure you want to delete this template?", Question!, YesNo!) = 2 then Return
end if

// Delete detail
dw_map.RowsMove(1, dw_map.RowCount(), Primary!, dw_map, 1, Delete!)

// Delete master
dw_select.GetChild("ilm_id", ldw_Child)
ll_CurrentRow = dw_temp_detail.GetRow()
dw_temp_detail.DeleteRow(ll_CurrentRow)
ldw_Child.DeleteRow(ll_CurrentRow)

// Save data
if of_SaveMaster() = 1 then
	of_SaveDetail()
end if

// Refresh UI
if dw_temp_detail.RowCount() > 0 then
	ll_ilm_id = dw_temp_detail.object.ilm_id[dw_temp_detail.GetRow()]
	dw_select.SetItem(1, "ilm_id", ll_ilm_id)
else
	ldw_Child.Reset()
	SetNull(ll_Null)
	dw_select.SetItem(1, "ilm_id", ll_Null)
	dw_temp_detail.InsertRow(0)
	of_set_detaildw_enabled(false)	
end if
dw_temp_detail.Event RowFocusChanged(dw_temp_detail.GetRow())
end event

type cb_add_temp from commandbutton within w_import_lookup_mapping
integer x = 1170
integer y = 64
integer width = 585
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add Mapping Template"
end type

event clicked;long ll_Null
long ll_LastRow
long ll_InsertRow
DataWindowChild ldw_Child

dw_temp_detail.AcceptText()
if dw_temp_detail.ModifiedCount() + dw_temp_detail.DeletedCount() > 0 then
	MessageBox("Prompt", "You must be save before add mapping template.")
	Return
end if

SetNull(ll_Null)
dw_select.GetChild("ilm_id", ldw_Child)
ll_LastRow = dw_temp_detail.RowCount()

if dw_temp_detail.GetItemStatus(ll_LastRow, 0, Primary!) = New! then
	ll_InsertRow = ll_LastRow	
else
	ldw_Child.InsertRow(0)	
	ll_InsertRow = dw_temp_detail.InsertRow(0)
end if
dw_select.SetItem(1, "ilm_id", ll_Null)

of_set_detaildw_enabled(true)
dw_temp_detail.ScrollToRow(ll_InsertRow)
dw_temp_detail.SetColumn("template_name")
dw_temp_detail.SetFocus()
end event

type dw_temp_detail from datawindow within w_import_lookup_mapping
event ue_keydown pbm_dwnkey
integer x = 37
integer y = 248
integer width = 3337
integer height = 172
integer taborder = 60
string title = "none"
string dataobject = "d_import_lu_template_edit"
boolean border = false
end type

event ue_keydown;if Key = KeyDownArrow! or Key = KeyUpArrow! or Key = KeyPageUp! or Key = KeyPageDown! then 
	Return 1
else
	Return 0
end if
end event

event dberror;is_master_errinfo = SQLErrText
Return 1
end event

event itemchanged;if dwo.name = "map_type" then
	dw_lu_recs.Reset()
	choose case Data
		case "A" //Address
			this.SetItem(Row, "lookup_table", "")
			this.object.lookup_table_dddw.visible = '1'
		case "C" //Code
			this.SetItem(Row, "lookup_table", "")
			this.object.lookup_table_dddw.visible = '1'
		case "F" //Facility
			this.object.lookup_table_dddw.visible = '0'			
			this.SetItem(Row, "lookup_table", "Facility")
			dw_lu_recs.Event ue_Filter()
		case "M" //Committee
			this.object.lookup_table_dddw.visible = '0'			
			this.SetItem(Row, "lookup_table", "Committee")
			dw_lu_recs.Event ue_Filter()
		case "I" //Company
			this.object.lookup_table_dddw.visible = '0'
			this.SetItem(Row, "lookup_table", "Company")
			dw_lu_recs.Event ue_Filter()
		case "S" //Active Status (V10.1 - Import Active Status)
			this.object.lookup_table_dddw.visible = '0'
			this.SetItem(Row, "lookup_table", "Active Status")
			dw_lu_recs.Event ue_Filter()
		case "Q" //QA Metrics (V11.3 QA Import)
			this.object.lookup_table_dddw.visible = '0'
			this.SetItem(Row, "lookup_table", "QA Metrics")
			dw_lu_recs.Event ue_Filter()			
	end choose
elseif dwo.name = "lookup_table_dddw" then
	dw_lu_recs.Event ue_Filter()
end if
end event

event rowfocuschanged;long ll_ilm_id
string ls_map_type

if CurrentRow > 0 then
	ll_ilm_id = this.object.ilm_id[CurrentRow]
	ls_map_type = this.object.map_type[CurrentRow]
	
	// Set DDDW visible
	if ls_map_type = "F" or ls_map_type = "M" or ls_map_type = "I" or &
	ls_map_type = "S" or ls_map_type = "Q" or IsNull(ls_map_type) then //V11.3 QA Import
		this.object.lookup_table_dddw.visible = '0'
	else
		this.object.lookup_table_dddw.visible = '1'
	end if
	
	// Filter mapped records
	if IsNull(ll_ilm_id) then
		dw_map.SetFilter("1 <> 1")
		dw_map.Filter()
	else
		dw_map.SetFilter("ilm_id = " + String(ll_ilm_id))
		dw_map.Filter()
	end if
	dw_map.SetRow(1)
	dw_map.SelectRow(0, false)
	dw_map.SelectRow(1, true)	
else
	dw_map.SetFilter("1 <> 1")
	dw_map.Filter()
end if

dw_lu_recs.Event ue_Filter()
end event

event constructor;this.SetTransObject(SQLCA)
end event

event clicked;DataWindowChild ldw_Child

if dwo.name = "lookup_table_dddw" and Row > 0 then
	this.GetChild("lookup_table_dddw", ldw_Child)	
	ldw_Child.Reset()
	
	this.AcceptText()
	choose case this.object.map_type[Row]
		case "A" //Address			
			ids_LookUpTableDDDW[1].RowsCopy(1, ids_LookUpTableDDDW[1].RowCount(), Primary!, ldw_Child, 1, Primary!)			
		case "C" //Code			
			ids_LookUpTableDDDW[2].RowsCopy(1, ids_LookUpTableDDDW[2].RowCount(), Primary!, ldw_Child, 1, Primary!)
		case "F" //Facility
		case "M" //Committee
		case "I"	//Company
		case "S" //Active Status (V10.1 - Import Active Status)
		case "Q" //QA Metrics (V11.3 QA Import)
	end choose
end if
end event

event other;if Message.Number = 522 then
	Return 1
end if
end event

type dw_select from datawindow within w_import_lookup_mapping
integer x = 50
integer y = 68
integer width = 1097
integer height = 84
integer taborder = 10
string title = "none"
string dataobject = "d_import_lu_template_select"
boolean border = false
boolean livescroll = true
end type

event constructor;this.InsertRow(0)
end event

event itemchanged;long ll_ilm_id
long ll_FindRow

if LenA(Data) > 0 then
	ll_ilm_id = Long(Data)
	ll_FindRow = dw_temp_detail.Find("ilm_id = " + String(ll_ilm_id), 1, dw_temp_detail.RowCount())
else
	ll_FindRow = dw_temp_detail.Find("IsNull(ilm_id)", 1, dw_temp_detail.RowCount())
end if

if ll_FindRow > 0 then
	dw_temp_detail.ScrollToRow(ll_FindRow)
end if
end event

type cb_close from commandbutton within w_import_lookup_mapping
integer x = 3922
integer y = 48
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type ln_1 from line within w_import_lookup_mapping
long linecolor = 16711680
integer linethickness = 8
integer beginx = 3163
integer beginy = 1116
integer endx = 3255
integer endy = 1232
end type

type ln_2 from line within w_import_lookup_mapping
long linecolor = 16711680
integer linethickness = 8
integer beginx = 1024
integer beginy = 1224
integer endx = 1129
integer endy = 1116
end type

type gb_1 from groupbox within w_import_lookup_mapping
integer x = 18
integer y = 192
integer width = 3438
integer height = 248
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Template Detail"
end type

type gb_2 from groupbox within w_import_lookup_mapping
integer x = 18
integer y = 8
integer width = 2231
integer height = 172
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select Template"
end type

type st_5 from statictext within w_import_lookup_mapping
integer x = 3255
integer y = 460
integer width = 1006
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Import Values (                                          )"
boolean focusrectangle = false
end type

type st_2 from statictext within w_import_lookup_mapping
integer x = 3630
integer y = 464
integer width = 539
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "Click Right Menu Edit"
boolean focusrectangle = false
end type

