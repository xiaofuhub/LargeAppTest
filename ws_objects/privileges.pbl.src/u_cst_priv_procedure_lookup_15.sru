$PBExportHeader$u_cst_priv_procedure_lookup_15.sru
forward
global type u_cst_priv_procedure_lookup_15 from u_base
end type
type st_add from statictext within u_cst_priv_procedure_lookup_15
end type
type st_6 from statictext within u_cst_priv_procedure_lookup_15
end type
type rb_req from radiobutton within u_cst_priv_procedure_lookup_15
end type
type rb_pro from radiobutton within u_cst_priv_procedure_lookup_15
end type
type sle_find from singlelineedit within u_cst_priv_procedure_lookup_15
end type
type cb_find from commandbutton within u_cst_priv_procedure_lookup_15
end type
type st_5 from statictext within u_cst_priv_procedure_lookup_15
end type
type cbx_cca from checkbox within u_cst_priv_procedure_lookup_15
end type
type cb_sort from commandbutton within u_cst_priv_procedure_lookup_15
end type
type cb_clear from commandbutton within u_cst_priv_procedure_lookup_15
end type
type dw_status from datawindow within u_cst_priv_procedure_lookup_15
end type
type cb_save from commandbutton within u_cst_priv_procedure_lookup_15
end type
type dw_ca from datawindow within u_cst_priv_procedure_lookup_15
end type
type dw_section from datawindow within u_cst_priv_procedure_lookup_15
end type
type st_1 from statictext within u_cst_priv_procedure_lookup_15
end type
type st_2 from statictext within u_cst_priv_procedure_lookup_15
end type
type cb_addfilter from commandbutton within u_cst_priv_procedure_lookup_15
end type
type dw_facility from datawindow within u_cst_priv_procedure_lookup_15
end type
type st_3 from statictext within u_cst_priv_procedure_lookup_15
end type
type st_4 from statictext within u_cst_priv_procedure_lookup_15
end type
type dw_detail from u_dw within u_cst_priv_procedure_lookup_15
end type
type cb_delete from commandbutton within u_cst_priv_procedure_lookup_15
end type
type cb_copy from commandbutton within u_cst_priv_procedure_lookup_15
end type
type cb_add from commandbutton within u_cst_priv_procedure_lookup_15
end type
type cb_close from commandbutton within u_cst_priv_procedure_lookup_15
end type
type dw_browse from u_dw within u_cst_priv_procedure_lookup_15
end type
type cb_select from commandbutton within u_cst_priv_procedure_lookup_15
end type
type gb_1 from groupbox within u_cst_priv_procedure_lookup_15
end type
end forward

global type u_cst_priv_procedure_lookup_15 from u_base
integer width = 4489
integer height = 2100
long backcolor = 33551856
event type integer ue_closequery ( )
event type integer ue_close ( )
st_add st_add
st_6 st_6
rb_req rb_req
rb_pro rb_pro
sle_find sle_find
cb_find cb_find
st_5 st_5
cbx_cca cbx_cca
cb_sort cb_sort
cb_clear cb_clear
dw_status dw_status
cb_save cb_save
dw_ca dw_ca
dw_section dw_section
st_1 st_1
st_2 st_2
cb_addfilter cb_addfilter
dw_facility dw_facility
st_3 st_3
st_4 st_4
dw_detail dw_detail
cb_delete cb_delete
cb_copy cb_copy
cb_add cb_add
cb_close cb_close
dw_browse dw_browse
cb_select cb_select
gb_1 gb_1
end type
global u_cst_priv_procedure_lookup_15 u_cst_priv_procedure_lookup_15

type variables
window iw_Parent
integer ii_Flag = 1
string is_Return = "Cancel!"
datastore ids_proc_lookup
long il_ca
long il_sect
end variables

forward prototypes
public function integer of_retrievedddw ()
public function integer of_init (window aw_parent, integer ai_flag)
public function string of_getfilters ()
public function integer of_filter ()
public function integer of_check ()
public function integer of_updateprivtemplate ()
public function integer of_setstatusenabled (boolean ab_enabled)
end prototypes

event type integer ue_closequery();//////////////////////////////////////////////////////////////////////
// $<event> ue_closequery
// $<arguments>
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> 01.17.2011 by Evan
//////////////////////////////////////////////////////////////////////

integer li_Result

// Check data if changed
if dw_detail.AcceptText() = -1 then Return 1
if dw_browse.ModifiedCount() + dw_browse.DeletedCount() < 1 then
	Return 0
end if

// Ask you if save data
li_Result = MessageBox("Save", "The data is changed, would you like to save data?", Question!, YesNoCancel!)
if li_Result = 2 then
	Return 0
elseif li_Result = 3 then
	Return 1
end if

// Save data
if cb_save.Event Clicked() = 1 then
	Return 0
else
	Return 1
end if
end event

event type integer ue_close();//////////////////////////////////////////////////////////////////////
// $<event> ue_close
// $<arguments>
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> 01.30.2011 by Evan
//////////////////////////////////////////////////////////////////////

CloseWithReturn(iw_Parent, is_Return)

Return 1
end event

public function integer of_retrievedddw ();//////////////////////////////////////////////////////////////////////
// $<function> of_retrievedddw
// $<arguments>
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> 01.13.2011 by Evan
//////////////////////////////////////////////////////////////////////

DataWindowChild ldwc_child1[5]
DataWindowChild ldwc_child2[5]

// Retrieve datawindowchilds
dw_ca.GetChild("lookup_code", ldwc_child1[1])
dw_section.GetChild("lookup_code", ldwc_child1[2])
dw_facility.GetChild("facility_id", ldwc_child1[3])
dw_browse.GetChild("dept_id", ldwc_child1[4])
dw_browse.GetChild("specialty", ldwc_child1[5])
ldwc_child1[1].SetTransObject(SQLCA)
ldwc_child1[2].SetTransObject(SQLCA)
ldwc_child1[3].SetTransObject(SQLCA)
ldwc_child1[4].SetTransObject(SQLCA)
ldwc_child1[5].SetTransObject(SQLCA)
gnv_appeondb.of_StartQueue()
ldwc_child1[1].Retrieve("Priv Clinical Area")
ldwc_child1[2].Retrieve("Priv Section")
ldwc_child1[3].Retrieve()
ldwc_child1[4].Retrieve("Department")
ldwc_child1[5].Retrieve("Practitioner Specialties")
gnv_appeondb.of_CommitQueue()

// Copy data to other datawindowchilds
dw_browse.GetChild("clinical_area_id", ldwc_child2[1])
dw_browse.GetChild("section_id", ldwc_child2[2])
dw_browse.GetChild("facility_specific", ldwc_child2[3])
//dw_browse.GetChild("dept_id", ldwc_child2[4]) //delete by evan 05.13.2011
//dw_browse.GetChild("specialty", ldwc_child2[5]) //delete by evan 05.13.2011
ldwc_child1[1].RowsCopy(1, ldwc_child1[1].RowCount(), Primary!, ldwc_child2[1], 1, Primary!)
ldwc_child1[2].RowsCopy(1, ldwc_child1[2].RowCount(), Primary!, ldwc_child2[2], 1, Primary!)
ldwc_child1[3].RowsCopy(1, ldwc_child1[3].RowCount(), Primary!, ldwc_child2[3], 1, Primary!)
//ldwc_child1[4].RowsCopy(1, ldwc_child1[4].RowCount(), Primary!, ldwc_child2[4], 1, Primary!) //delete by evan 05.13.2011
dw_detail.GetChild("clinical_area_id", ldwc_child2[1])
dw_detail.GetChild("section_id", ldwc_child2[2])
dw_detail.GetChild("facility_specific", ldwc_child2[3])
dw_detail.GetChild("dept_id", ldwc_child2[4])
dw_detail.GetChild("specialty", ldwc_child2[5])
ldwc_child1[1].RowsCopy(1, ldwc_child1[1].RowCount(), Primary!, ldwc_child2[1], 1, Primary!)
ldwc_child1[2].RowsCopy(1, ldwc_child1[2].RowCount(), Primary!, ldwc_child2[2], 1, Primary!)
ldwc_child1[3].RowsCopy(1, ldwc_child1[3].RowCount(), Primary!, ldwc_child2[3], 1, Primary!)
ldwc_child1[4].RowsCopy(1, ldwc_child1[4].RowCount(), Primary!, ldwc_child2[4], 1, Primary!)
ldwc_child1[5].RowsCopy(1, ldwc_child1[5].RowCount(), Primary!, ldwc_child2[5], 1, Primary!)

// Initialize filter dddw data
ldwc_child1[1].InsertRow(1)
ldwc_child1[1].SetItem(1, "lookup_code", 0)
ldwc_child1[1].SetItem(1, "description", "All")
ldwc_child1[1].SelectRow(0, false)
ldwc_child1[2].InsertRow(1)
ldwc_child1[2].SetItem(1, "lookup_code", 0)
ldwc_child1[2].SetItem(1, "description", "All")
ldwc_child1[2].SelectRow(0, false)
ldwc_child1[3].InsertRow(1)
ldwc_child1[3].SetItem(1, "facility_id", 0)
ldwc_child1[3].SetItem(1, "facility_name", "All")
ldwc_child1[3].SelectRow(0, false)

ldwc_child2[3].InsertRow(1)
ldwc_child2[4].InsertRow(1)
ldwc_child2[5].InsertRow(1)

Return 1
end function

public function integer of_init (window aw_parent, integer ai_flag);//////////////////////////////////////////////////////////////////////
// $<function> of_init
// $<arguments>
//		window		aw_parent
//		integer		ai_flag
// $<returns> integer
// $<description> initialize this user object
//////////////////////////////////////////////////////////////////////
// $<add> 01.13.2011 by Evan
//////////////////////////////////////////////////////////////////////

iw_Parent = aw_Parent
ii_Flag = ai_Flag

// Initialize dddw
of_RetrieveDddw()
dw_ca.SetItem(1, "lookup_code", 0)
dw_section.SetItem(1, "lookup_code", 0)
dw_facility.SetItem(1, "facility_id", 0)

// Retrieve procedure lookups
dw_browse.Retrieve()
dw_browse.ShareData(dw_detail)

choose case ii_Flag
	case 1
		cb_select.Hide()
		st_add.Hide()
		dw_browse.Modify("selected.visible = 0")
		dw_browse.Modify("datawindow.footer.height = 0")
		of_SetStatusEnabled(true)
	case 2
		cb_select.Show()
		st_add.Show()
		dw_browse.Modify("selected.visible = 1")
		dw_browse.Modify("datawindow.footer.height = 80")
		of_SetStatusEnabled(false)
		ids_proc_lookup = Message.PowerObjectParm
		//---------Begin Modified by (Appeon)Stephen 04.22.2014 for Bug #4008, Cosmetic typo in three prompts --------
		//st_add.text = "Adding at the " + mid(ids_proc_lookup.DataObject, 7, len(ids_proc_lookup.DataObject) - 7) + " level."
		st_add.text = "Adding at the " + mid(ids_proc_lookup.DataObject, 6, len(ids_proc_lookup.DataObject) - 6) + " level."
		//---------End Modfiied ------------------------------------------------------
		iw_Parent.Title += ids_proc_lookup.DataObject
		ids_proc_lookup.DataObject = ""
		cb_close.text = "Cancel"
end choose

// Set filters
of_Filter()

Return 1
end function

public function string of_getfilters ();//////////////////////////////////////////////////////////////////////
// $<function> of_getfilters
// $<arguments>
// $<returns> string
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> 01.13.2011 by Evan
//////////////////////////////////////////////////////////////////////

string ls_Filters

dw_ca.AcceptText()
dw_section.AcceptText()
dw_facility.AcceptText()
dw_status.AcceptText()

if dw_ca.object.lookup_code[1] <> 0 then
	ls_Filters += "clinical_area_id = " + String(dw_ca.object.lookup_code[1])
end if

if dw_section.object.lookup_code[1] <> 0 then
	if ls_Filters <> "" then ls_Filters += " and "
	ls_Filters += "section_id = " + String(dw_section.object.lookup_code[1])
end if

if dw_facility.object.facility_id[1] > 0 then
	if ls_Filters <> "" then ls_Filters += " and "
	ls_Filters += "facility_specific = " + String(dw_facility.object.facility_id[1])
end if

if dw_status.object.active_status[1] = 0 or dw_status.object.active_status[1] = 1 then
	if ls_Filters <> "" then ls_Filters += " and "
	ls_Filters += "active_status = " + String(dw_status.object.active_status[1])
end if

//Start Code Change ----06.21.2011 #V11 maha 
if cbx_cca.checked then
	if ls_Filters <> "" then ls_Filters += " and "
	ls_Filters += "cross_area = 1" 
end if
//Start Code Change ----06.21.2011

Return ls_Filters
end function

public function integer of_filter ();//////////////////////////////////////////////////////////////////////
// $<function> of_filter
// $<arguments>
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> 01.13.2011 by Evan
//////////////////////////////////////////////////////////////////////

string ls_Filters
debugbreak()
ls_Filters = of_GetFilters()
dw_browse.SetFilter(ls_Filters)
dw_browse.Filter()

dw_browse.SetRow(1)
dw_browse.SelectRow(0, false)
dw_browse.SelectRow(1, true)
dw_detail.ScrollToRow(1)

Return 1
end function

public function integer of_check ();//////////////////////////////////////////////////////////////////////
// $<function> of_check
// $<arguments>
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> 01.17.2011 by Evan
//////////////////////////////////////////////////////////////////////

long ll_Row
long ll_RowCount

dw_detail.AcceptText()
ll_RowCount = dw_browse.RowCount()

for ll_Row = 1 to ll_RowCount
	if IsNull(dw_browse.object.clinical_area_id[ll_Row]) then
		dw_browse.ScrollToRow(ll_Row)
		dw_detail.SetColumn("clinical_area_id")
		dw_detail.Post SetFocus()
		MessageBox("Warning", "Clinical Area connot be null.", Exclamation!)
		Return -1
	end if
	if IsNull(dw_browse.object.section_id[ll_Row]) then
		dw_browse.ScrollToRow(ll_Row)
		dw_detail.SetColumn("section_id")
		dw_detail.Post SetFocus()
		MessageBox("Warning", "Subsection connot be null.", Exclamation!)
		Return -1
	end if
	/*
	if IsNull(dw_browse.object.dept_id[ll_Row]) then
		dw_browse.ScrollToRow(ll_Row)
		dw_detail.SetColumn("dept_id")
		dw_detail.Post SetFocus()
		MessageBox("Warning", "Department connot be null.", Exclamation!)
		Return -1
	end if
	*/
	if IsNull(dw_browse.object.procd_name[ll_Row]) or Trim(dw_browse.object.procd_name[ll_Row]) = "" then
		dw_browse.ScrollToRow(ll_Row)
		dw_detail.SetColumn("procd_name")
		dw_detail.Post SetFocus()
		MessageBox("Warning", "Procedure Name connot be null.", Exclamation!)
		Return -1
	end if
	if IsNull(dw_browse.object.procedure_description[ll_Row]) or Trim(dw_browse.object.procedure_description[ll_Row]) = "" then
		dw_browse.ScrollToRow(ll_Row)
		dw_detail.SetColumn("procedure_description")
		dw_detail.Post SetFocus()
		MessageBox("Warning", "Procedure Description connot be null.", Exclamation!)
		Return -1
	end if
next

Return 1
end function

public function integer of_updateprivtemplate ();//////////////////////////////////////////////////////////////////////
// $<function> of_updateprivtemplate
// $<arguments>
// $<returns> integer
// $<description> Update connected template records if data changing.
//////////////////////////////////////////////////////////////////////
// $<add> 01.18.2011 by Evan
//////////////////////////////////////////////////////////////////////

long i, ll_Count
long ll_Row, ll_RowCount
long ll_clin_area_id
long ll_procd_lookup_id
long ll_num_req_for_reapp
long ll_active_status
string ls_procd_code
string ls_procd_name
string ls_core_procd_description
string ls_UpdateSQL[]
string ls_procd_lookup_id
integer li_Result

// Build update sqls
ll_RowCount = dw_browse.RowCount()
for ll_Row = 1 to ll_RowCount
	if dw_browse.GetItemStatus(ll_Row, 0, Primary!) = DataModified! then
		ll_procd_lookup_id = dw_browse.GetItemNumber(ll_Row, "procedure_pk")
		ll_clin_area_id = dw_browse.GetItemNumber(ll_Row, "clinical_area_id")
		ll_num_req_for_reapp = dw_browse.GetItemNumber(ll_Row, "num_req_for_reapp")
		ll_active_status = dw_browse.GetItemNumber(ll_Row, "active_status")
		ls_procd_name = dw_browse.GetItemString(ll_Row, "procd_name")
		ls_procd_code = dw_browse.GetItemString(ll_Row, "procd_code")
		ls_core_procd_description = dw_browse.GetItemString(ll_Row, "procedure_description")
		
		if ls_procd_lookup_id <> "" then ls_procd_lookup_id += ","
		ls_procd_lookup_id += String(ll_procd_lookup_id)

		ll_Count ++
		//-------Begin Modified by Alfee 08.27.2012 -------------------------------
		ls_UpdateSQL[ll_Count] = &		
		"UPDATE priv_core_procd SET " + &
		"	 num_req_for_reapp = " + f_SqlString(ll_num_req_for_reapp, 'N') + "," + &
		"	 active_status = " + f_SqlString(ll_active_status, 'N') + "," + &
		"	 procd_name = " + f_SqlString(ls_procd_name, 'S') + ", " + &
		"	 procd_code = " + f_SqlString(ls_procd_code, 'S') + ", " + &
		"	 core_procd_description = " + f_SqlString(ls_core_procd_description, 'S') + &
		" WHERE procd_lookup_id = " + f_SqlString(ll_procd_lookup_id, 'N') 
		/*	ls_UpdateSQL[ll_Count] = &
		"UPDATE priv_core_procd SET " + &
		"	 clin_area_id = " + f_SqlString(ll_procd_lookup_id, 'N') + "," + &
		"	 num_req_for_reapp = " + f_SqlString(ll_num_req_for_reapp, 'N') + "," + &
		"	 active_status = " + f_SqlString(ll_active_status, 'N') + "," + &
		"	 procd_name = " + f_SqlString(ls_procd_name, 'S') + ", " + &
		"	 procd_code = " + f_SqlString(ls_procd_code, 'S') + ", " + &
		"	 core_procd_description = " + f_SqlString(ls_core_procd_description, 'S') + &
		" WHERE procd_lookup_id = " + f_SqlString(ll_procd_lookup_id, 'N') // Modify by Evan on 04.11.2011
		*/
		//------End Modified --------------------------------------------------------
	end if
next

// Ask user if update connected template records
if ll_Count < 1 then Return 1
SELECT count(*) INTO :ll_Count FROM priv_core_procd WHERE procd_lookup_id IN (:ls_procd_lookup_id);
if IsNull(ll_Count) or ll_Count < 1 then Return 1

li_Result = MessageBox("Update Template Records", "The data is changed, would you like to update connected " + String(ll_Count) + " template record(s)?", Question!, YesNo!)
if li_Result = 2 then Return 1

// Update template records
gnv_appeondb.of_StartQueue()
ll_Count = UpperBound(ls_UpdateSQL)
for i = 1 to ll_Count
	EXECUTE IMMEDIATE :ls_UpdateSQL[i];
next
gnv_appeondb.of_CommitQueue()

Return 1
end function

public function integer of_setstatusenabled (boolean ab_enabled);//////////////////////////////////////////////////////////////////////
// $<function> of_setstatusenabled
// $<arguments>
//		boolean	ab_enabled
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> 01.30.2011 by Evan
//////////////////////////////////////////////////////////////////////

if ab_Enabled then
	dw_status.SetItem(1, "active_status", 99999)
	dw_status.Modify("active_status.background.color = 1073741824")
	dw_status.Modify("active_status.protect = 0")
	dw_detail.Modify("active_status.protect = 0")
else
	dw_status.SetItem(1, "active_status", 1)
	dw_status.Modify("active_status.background.color = 67108864")
	dw_status.Modify("active_status.protect = 1")
	dw_detail.Modify("active_status.protect = 1")
end if

Return 1
end function

on u_cst_priv_procedure_lookup_15.create
int iCurrent
call super::create
this.st_add=create st_add
this.st_6=create st_6
this.rb_req=create rb_req
this.rb_pro=create rb_pro
this.sle_find=create sle_find
this.cb_find=create cb_find
this.st_5=create st_5
this.cbx_cca=create cbx_cca
this.cb_sort=create cb_sort
this.cb_clear=create cb_clear
this.dw_status=create dw_status
this.cb_save=create cb_save
this.dw_ca=create dw_ca
this.dw_section=create dw_section
this.st_1=create st_1
this.st_2=create st_2
this.cb_addfilter=create cb_addfilter
this.dw_facility=create dw_facility
this.st_3=create st_3
this.st_4=create st_4
this.dw_detail=create dw_detail
this.cb_delete=create cb_delete
this.cb_copy=create cb_copy
this.cb_add=create cb_add
this.cb_close=create cb_close
this.dw_browse=create dw_browse
this.cb_select=create cb_select
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_add
this.Control[iCurrent+2]=this.st_6
this.Control[iCurrent+3]=this.rb_req
this.Control[iCurrent+4]=this.rb_pro
this.Control[iCurrent+5]=this.sle_find
this.Control[iCurrent+6]=this.cb_find
this.Control[iCurrent+7]=this.st_5
this.Control[iCurrent+8]=this.cbx_cca
this.Control[iCurrent+9]=this.cb_sort
this.Control[iCurrent+10]=this.cb_clear
this.Control[iCurrent+11]=this.dw_status
this.Control[iCurrent+12]=this.cb_save
this.Control[iCurrent+13]=this.dw_ca
this.Control[iCurrent+14]=this.dw_section
this.Control[iCurrent+15]=this.st_1
this.Control[iCurrent+16]=this.st_2
this.Control[iCurrent+17]=this.cb_addfilter
this.Control[iCurrent+18]=this.dw_facility
this.Control[iCurrent+19]=this.st_3
this.Control[iCurrent+20]=this.st_4
this.Control[iCurrent+21]=this.dw_detail
this.Control[iCurrent+22]=this.cb_delete
this.Control[iCurrent+23]=this.cb_copy
this.Control[iCurrent+24]=this.cb_add
this.Control[iCurrent+25]=this.cb_close
this.Control[iCurrent+26]=this.dw_browse
this.Control[iCurrent+27]=this.cb_select
this.Control[iCurrent+28]=this.gb_1
end on

on u_cst_priv_procedure_lookup_15.destroy
call super::destroy
destroy(this.st_add)
destroy(this.st_6)
destroy(this.rb_req)
destroy(this.rb_pro)
destroy(this.sle_find)
destroy(this.cb_find)
destroy(this.st_5)
destroy(this.cbx_cca)
destroy(this.cb_sort)
destroy(this.cb_clear)
destroy(this.dw_status)
destroy(this.cb_save)
destroy(this.dw_ca)
destroy(this.dw_section)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.cb_addfilter)
destroy(this.dw_facility)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.dw_detail)
destroy(this.cb_delete)
destroy(this.cb_copy)
destroy(this.cb_add)
destroy(this.cb_close)
destroy(this.dw_browse)
destroy(this.cb_select)
destroy(this.gb_1)
end on

event constructor;call super::constructor;this.of_SetResize(true)
inv_resize.of_SetOrigSize(this.Width, this.Height)
inv_resize.of_SetMinSize(this.Width, this.Height)

inv_resize.of_Register(gb_1, inv_resize.SCALERIGHT)
inv_resize.of_Register(dw_browse, inv_resize.SCALERIGHTBOTTOM)
inv_resize.of_Register(dw_detail, inv_resize.FIXEDBOTTOM_SCALERIGHT)
end event

event resize;//==================[Not Extend Ancestor Script]==================//

pfc_u_base::Event Resize(SizeType, NewWidth, NewHeight)
end event

type st_add from statictext within u_cst_priv_procedure_lookup_15
integer x = 2194
integer y = 28
integer width = 1774
integer height = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Adding at the ... Level"
boolean focusrectangle = false
end type

type st_6 from statictext within u_cst_priv_procedure_lookup_15
integer x = 41
integer y = 308
integer width = 183
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Search:"
boolean focusrectangle = false
end type

type rb_req from radiobutton within u_cst_priv_procedure_lookup_15
integer x = 2053
integer y = 304
integer width = 471
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Requirements"
end type

type rb_pro from radiobutton within u_cst_priv_procedure_lookup_15
integer x = 1669
integer y = 304
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Procedure"
boolean checked = true
end type

type sle_find from singlelineedit within u_cst_priv_procedure_lookup_15
integer x = 238
integer y = 292
integer width = 1394
integer height = 84
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_find from commandbutton within u_cst_priv_procedure_lookup_15
integer x = 2537
integer y = 292
integer width = 283
integer height = 88
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Find"
end type

event clicked;//Start Code Change ----.2011 #V12 maha
string ls_field
string ls_val
string ls_filter
integer f

if rb_req.checked then
	ls_field = "special_requirement"
else
	ls_field = "procedure_description"
end if

ls_val = sle_find.text

if len (ls_val) < 1 then
	messagebox("Find","No Search value")
	return

end if
ls_val = upper(ls_val)
ls_filter = "upper(" + ls_field + ")  like '%" + ls_val + "%'"

f = dw_detail.setfilter(ls_filter)
if f < 1 then messagebox("Faulty filter",ls_filter)
dw_detail.filter()
end event

type st_5 from statictext within u_cst_priv_procedure_lookup_15
integer x = 2853
integer y = 148
integer width = 379
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Cross Clin. Area"
boolean focusrectangle = false
end type

type cbx_cca from checkbox within u_cst_priv_procedure_lookup_15
integer x = 2999
integer y = 204
integer width = 87
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
end type

event clicked;//Start Code Change ----06.22.2011 #V11 maha - added
if of_Check() = 1 then
	of_Filter()
else
	Return 2
end if
end event

type cb_sort from commandbutton within u_cst_priv_procedure_lookup_15
integer x = 3291
integer y = 188
integer width = 343
integer height = 92
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Sor&t"
end type

event clicked;string null_str

SetNull(null_str)

dw_browse.SetSort(null_str)

dw_browse.Sort( )
end event

type cb_clear from commandbutton within u_cst_priv_procedure_lookup_15
integer x = 3639
integer y = 188
integer width = 370
integer height = 92
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Clear &Filter"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 01.13.2011
//////////////////////////////////////////////////////////////////////

dw_ca.SetItem(1, "lookup_code", 0)
dw_section.SetItem(1, "lookup_code", 0)
dw_facility.SetItem(1, "facility_id", 0)
if dw_status.Describe("active_status.protect") = "0" then
	dw_status.SetItem(1, "active_status", 99999)
else
	dw_status.SetItem(1, "active_status", 1)
end if

dw_browse.Reset()
of_Filter()
dw_browse.Retrieve()
dw_browse.SelectRow(1, true)
end event

type dw_status from datawindow within u_cst_priv_procedure_lookup_15
integer x = 2345
integer y = 204
integer width = 471
integer height = 72
integer taborder = 100
string title = "none"
string dataobject = "d_ddlb_priv_active_status"
boolean border = false
boolean livescroll = true
end type

event itemchanged;//////////////////////////////////////////////////////////////////////
// $<event> itemchanged
// $<arguments>
//		long		row
//		dwobject	dwo
//		string	data
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> 01.13.2011 by Evan
//////////////////////////////////////////////////////////////////////

if of_Check() = 1 then
	of_Filter()
else
	Return 2
end if
end event

type cb_save from commandbutton within u_cst_priv_procedure_lookup_15
integer x = 9
integer y = 12
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 01.14.2011
//////////////////////////////////////////////////////////////////////

long ll_Row
long ll_procedure_pk

// Check data if changed
if dw_detail.AcceptText() = -1 then Return -1
if dw_browse.ModifiedCount() + dw_browse.DeletedCount() < 1 then
	Return 1
end if

// Check data if null
if of_Check() = -1 then Return -1

// Set primary keys of new record
SELECT max(procedure_pk) INTO :ll_procedure_pk FROM priv_procd_lookup;
if IsNull(ll_procedure_pk) then ll_procedure_pk = 0
for ll_Row = 1 to dw_browse.RowCount()
	if dw_browse.GetItemStatus(ll_Row, 0, Primary!) = NewModified! then
		ll_procedure_pk ++
		dw_browse.SetItem(ll_Row, "procedure_pk", ll_procedure_pk)
	end if
next
for ll_Row = 1 to dw_browse.FilteredCount()
	if dw_browse.GetItemStatus(ll_Row, 0, Filter!) = NewModified! then
		ll_procedure_pk ++
		dw_browse.object.procedure_pk.filter.current[ll_Row] = ll_procedure_pk
	end if
next

// Save data
if dw_browse.Update(true, false) = 1 then
	Commit;
else
	Rollback;
	MessageBox("Save", "Failed to save data.", StopSign!)
	Return -1
end if

// Update connected template records
of_UpdatePrivTemplate()
dw_browse.ResetUpdate()

Return 1
end event

type dw_ca from datawindow within u_cst_priv_procedure_lookup_15
integer x = 27
integer y = 204
integer width = 823
integer height = 72
integer taborder = 70
string title = "none"
string dataobject = "d_ddlb_clinical_area"
boolean border = false
boolean livescroll = true
end type

event itemchanged;//////////////////////////////////////////////////////////////////////
// $<event> itemchanged
// $<arguments>
//		long		row
//		dwobject	dwo
//		string	data
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> 01.13.2011 by Evan
//////////////////////////////////////////////////////////////////////

//Start Code Change ----06.20.2011 #V11 maha
il_ca = long(data)

if of_Check() = 1 then
	of_Filter()
else
	Return 2
end if
end event

type dw_section from datawindow within u_cst_priv_procedure_lookup_15
integer x = 873
integer y = 204
integer width = 759
integer height = 72
integer taborder = 80
string title = "none"
string dataobject = "d_ddlb_subsection"
boolean border = false
boolean livescroll = true
end type

event itemchanged;//////////////////////////////////////////////////////////////////////
// $<event> itemchanged
// $<arguments>
//		long		row
//		dwobject	dwo
//		string	data
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> 01.13.2011 by Evan
//////////////////////////////////////////////////////////////////////

//Start Code Change ----06.20.2011 #V11 maha
il_sect = long(data)

if of_Check() = 1 then
	of_Filter()
else
	Return 2
end if
end event

type st_1 from statictext within u_cst_priv_procedure_lookup_15
integer x = 41
integer y = 148
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Clinical Area"
boolean focusrectangle = false
end type

type st_2 from statictext within u_cst_priv_procedure_lookup_15
integer x = 1655
integer y = 148
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Facility Link"
boolean focusrectangle = false
end type

type cb_addfilter from commandbutton within u_cst_priv_procedure_lookup_15
integer x = 4014
integer y = 188
integer width = 421
integer height = 92
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add&itional Filter"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 01.13.2011
//////////////////////////////////////////////////////////////////////

string ls_Null

if of_Check() <> 1 then Return
	
SetNull(ls_Null)
dw_browse.SetFilter(ls_Null)
dw_browse.Filter()

dw_browse.SetRow(1)
dw_browse.SelectRow(0, false)
dw_browse.SelectRow(1, true)
dw_detail.ScrollToRow(1)
end event

type dw_facility from datawindow within u_cst_priv_procedure_lookup_15
integer x = 1655
integer y = 204
integer width = 645
integer height = 72
integer taborder = 90
string title = "none"
string dataobject = "d_ddlb_priv_facility"
boolean border = false
boolean livescroll = true
end type

event itemchanged;//////////////////////////////////////////////////////////////////////
// $<event> itemchanged
// $<arguments>
//		long		row
//		dwobject	dwo
//		string	data
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> 01.13.2011 by Evan
//////////////////////////////////////////////////////////////////////

if of_Check() = 1 then
	of_Filter()
else
	Return 2
end if
end event

type st_3 from statictext within u_cst_priv_procedure_lookup_15
integer x = 887
integer y = 148
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "SubSection"
boolean focusrectangle = false
end type

type st_4 from statictext within u_cst_priv_procedure_lookup_15
integer x = 2350
integer y = 148
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Active Status"
boolean focusrectangle = false
end type

type dw_detail from u_dw within u_cst_priv_procedure_lookup_15
integer x = 2258
integer y = 424
integer width = 2226
integer height = 1672
integer taborder = 140
string title = "Detail"
string dataobject = "d_priv_procedure_lookup"
boolean vscrollbar = false
boolean livescroll = false
end type

event other;call super::other;if Message.WordParm = 61458 then 
	Message.Processed = true
	Message.ReturnValue = 0	
end if

if Message.Number = 522 then
	Return 1
end if
end event

event constructor;call super::constructor;this.SetTransObject(SQLCA)
end event

event buttonclicked;call super::buttonclicked;//////////////////////////////////////////////////////////////////////
// $<event> buttonclicked
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Stephen 03.28.2011
//////////////////////////////////////////////////////////////////////

datawindowchild ldwc_1
gs_code_lookup   lstr_lookup
long  ll_Row

choose case dwo.name
	case "b_add_ca"
		openwithparm(w_cst_lookup_codenew,"Priv Clinical Area")
		lstr_lookup = message.powerobjectparm
		if not isvalid(lstr_lookup) then return
		dw_detail.getchild("clinical_area_id", ldwc_1)
		
		ll_Row = ldwc_1.InsertRow(0)
		ldwc_1.ScrollToRow(ll_Row)
		ldwc_1.SetItem(ll_Row, "lookup_code", lstr_lookup.lookup_code)
		ldwc_1.SetItem(ll_Row, "description", lstr_lookup.description)
		dw_detail.SetItem(row, "clinical_area_id", lstr_lookup.lookup_code)
		
		dw_browse.getchild("clinical_area_id", ldwc_1)
		
		ll_Row = ldwc_1.InsertRow(0)
		ldwc_1.ScrollToRow(ll_Row)
		ldwc_1.SetItem(ll_Row, "lookup_code", lstr_lookup.lookup_code)
		ldwc_1.SetItem(ll_Row, "description", lstr_lookup.description)
		dw_browse.SetItem(row, "clinical_area_id", lstr_lookup.lookup_code)


		dw_ca.getchild("lookup_code", ldwc_1)
		ll_Row = ldwc_1.InsertRow(0)
		ldwc_1.ScrollToRow(ll_Row)
		ldwc_1.SetItem(ll_Row, "lookup_code", lstr_lookup.lookup_code)
		ldwc_1.SetItem(ll_Row, "description", lstr_lookup.description)
		this.setcolumn("clinical_area_id")
	case "b_add_sect"
		openwithparm(w_cst_lookup_codenew,"Priv Section")
		lstr_lookup = message.powerobjectparm
		if not isvalid(lstr_lookup) then return
		dw_detail.getchild("section_id", ldwc_1)
		ll_Row = ldwc_1.InsertRow(0)
		ldwc_1.ScrollToRow(ll_Row)
		ldwc_1.SetItem(ll_Row, "lookup_code", lstr_lookup.lookup_code)
		ldwc_1.SetItem(ll_Row, "description", lstr_lookup.description)
		dw_detail.SetItem(row, "section_id", lstr_lookup.lookup_code)
		
		dw_browse.getchild("section_id", ldwc_1)
		
		ll_Row = ldwc_1.InsertRow(0)
		ldwc_1.ScrollToRow(ll_Row)
		ldwc_1.SetItem(ll_Row, "lookup_code", lstr_lookup.lookup_code)
		ldwc_1.SetItem(ll_Row, "description", lstr_lookup.description)
		dw_browse.SetItem(row, "section_id", lstr_lookup.lookup_code)
		
		dw_section.getchild("lookup_code", ldwc_1)
		ll_Row = ldwc_1.InsertRow(0)
		ldwc_1.ScrollToRow(ll_Row)
		ldwc_1.SetItem(ll_Row, "lookup_code", lstr_lookup.lookup_code)
		ldwc_1.SetItem(ll_Row, "description", lstr_lookup.description)

		this.setcolumn("section_id")
		
end choose
end event

event doubleclicked;call super::doubleclicked;//Start Code Change ----09.17.2014 #V14.2 maha - added for eapand of fields
string s

if row < 1 then return   //Start Code Change ----03.03.2015 #V15 maha - corrected; was > 1

Choose case dwo.name
	Case "procedure_description" , "fppe_req", "special_requirement"
		OpenWithParm( w_expand_text, This.GetItemString( row, string(dwo.Name) ))
		IF Message.StringParm = "Cancel" THEN
			RETURN -1
		ELSE
			s = Message.StringParm
			This.SetItem( row, dwo.Name, s )
		END IF		
end choose
end event

type cb_delete from commandbutton within u_cst_priv_procedure_lookup_15
integer x = 1065
integer y = 12
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 01.13.2011
//////////////////////////////////////////////////////////////////////
long ll_chk
long ll_id

ll_id = dw_browse.getitemnumber(dw_browse.GetRow(), "procedure_pk")
//select count(procd_id) into :ll_chk where procd_lookup_id = :ll_id;

if dw_browse.GetRow() < 1 then Return -1
if MessageBox("Delete", "Are you sure that you want to delete the selected record?", Question!, YesNo!, 2) = 2 then
	Return 0
end if



dw_browse.DeleteRow(0)
dw_browse.SelectRow(0, false)
dw_browse.SelectRow(dw_browse.GetRow(), true)
dw_detail.ScrollToRow(dw_browse.GetRow())
end event

type cb_copy from commandbutton within u_cst_priv_procedure_lookup_15
integer x = 713
integer y = 12
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Copy"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 01.13.2011
//////////////////////////////////////////////////////////////////////

long ll_CurrRow
long ll_LastRow

ll_CurrRow = dw_browse.GetRow()
if ll_CurrRow < 1 then Return -1

ll_LastRow = dw_browse.RowCount() + 1
dw_browse.object.data[ll_LastRow] = dw_browse.object.data[ll_CurrRow]
dw_browse.ScrollToRow(ll_LastRow)
end event

type cb_add from commandbutton within u_cst_priv_procedure_lookup_15
integer x = 361
integer y = 12
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 01.13.2011
//////////////////////////////////////////////////////////////////////

long ll_Row

if dw_detail.AcceptText() = -1 then Return -1

ll_Row = dw_browse.InsertRow(0)
dw_browse.ScrollToRow(ll_Row)
dw_browse.SetItem(ll_Row, "active_status", 1)

//Start Code Change ----06.20.2011 #V11 maha 
if il_ca > 0 then dw_browse.SetItem(ll_Row, "clinical_area_id", il_ca)
if il_sect > 0 then dw_browse.SetItem(ll_Row, "section_id", il_sect)
//End Code Change ----06.20.2011

dw_detail.SetColumn("clinical_area_id")
dw_detail.SetFocus()
end event

type cb_close from commandbutton within u_cst_priv_procedure_lookup_15
integer x = 4037
integer y = 20
integer width = 398
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Clos&e"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event>clicked
// $<arguments>
// $<returns> long
// $<description> Close window
//////////////////////////////////////////////////////////////////////
// $<add> 01.12.2011 by Evan
//////////////////////////////////////////////////////////////////////

Close(iw_Parent)
end event

type dw_browse from u_dw within u_cst_priv_procedure_lookup_15
integer y = 420
integer width = 2249
integer height = 1676
integer taborder = 130
string title = "Browse"
string dataobject = "d_priv_procd_lookup_browse_tv"
boolean hscrollbar = true
end type

event constructor;call super::constructor;this.SetTransObject(SQLCA)
this.Modify("DataWindow.NoUserPrompt='no'")
end event

event rowfocuschanged;call super::rowfocuschanged;this.SelectRow(0, false)
this.SelectRow(CurrentRow, true)
dw_detail.ScrollToRow(CurrentRow)
end event

event buttonclicked;call super::buttonclicked;integer i, li_Selected

if dwo.name = "b_select" then
	if this.Describe("b_select.text") = "Select All" then
		li_Selected = 1
		this.Modify("b_select.text = 'Deselect All'")
	else
		li_Selected = 0
		this.Modify("b_select.text = 'Select All'")
	end if
	
	for i = 1 to this.RowCount()
		this.SetItem(i, "selected", li_Selected)
		this.SetItemStatus(i, "selected", Primary!, NotModified!)
	next	
end if
end event

event itemchanged;call super::itemchanged;if dwo.name = "selected" then
	this.Post SetItemStatus(Row, "selected", Primary!, NotModified!)
end if
end event

event clicked;call super::clicked;if dwo.type = "column" then
	this.SetRow(Row)
	this.SelectRow(0, false)
	this.SelectRow(Row, true)
	dw_detail.ScrollToRow(Row)
end if
end event

event other;call super::other;if Message.WordParm = 61458 then 
	Message.Processed = true
	Message.ReturnValue = 0	
end if

//if Message.Number = 522 then
//	Return 1
//end if
end event

type cb_select from commandbutton within u_cst_priv_procedure_lookup_15
integer x = 1815
integer y = 16
integer width = 343
integer height = 92
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Se&lect"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 01.18.2011
//////////////////////////////////////////////////////////////////////

long ll_Row
datawindowchild ldwc_child[2]

if dw_browse.RowCount() = 0 then
	MessageBox("Select", "Please add procedure first.")
	Return -1
end if
if cb_save.Event Clicked() = -1 then Return -1

ll_Row = dw_browse.Find("selected = 1", 1, dw_browse.RowCount())
if ll_Row > 0 then
	dw_browse.SetRedraw(false)
	ids_proc_lookup.DataObject = dw_browse.DataObject
	dw_browse.SetFilter("selected = 1")
	dw_browse.Filter()
	dw_browse.RowsCopy(1, dw_browse.RowCount(), Primary!, ids_proc_lookup, 1, Primary!)
	
	dw_browse.GetChild("clinical_area_id", ldwc_child[1])
	ids_proc_lookup.GetChild("clinical_area_id", ldwc_child[2])
	ldwc_child[2].Reset()
	ldwc_child[1].RowsCopy(1, ldwc_child[1].RowCount(), Primary!, ldwc_child[2], 1, Primary!)
	
	dw_browse.GetChild("section_id", ldwc_child[1])
	ids_proc_lookup.GetChild("section_id", ldwc_child[2])
	ldwc_child[2].Reset()
	ldwc_child[1].RowsCopy(1, ldwc_child[1].RowCount(), Primary!, ldwc_child[2], 1, Primary!)
	
	is_Return = "OK!"
else
	MessageBox("Select", "Please select procedure(s) from Browse screen.")
	Return -1
end if

Close(iw_Parent)
end event

type gb_1 from groupbox within u_cst_priv_procedure_lookup_15
integer y = 104
integer width = 4485
integer height = 312
integer taborder = 150
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Filters"
end type

