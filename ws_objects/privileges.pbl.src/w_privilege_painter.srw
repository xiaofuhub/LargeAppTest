$PBExportHeader$w_privilege_painter.srw
forward
global type w_privilege_painter from w_main
end type
type cb_data_source from commandbutton within w_privilege_painter
end type
type mle_text from multilineedit within w_privilege_painter
end type
type st_temp from statictext within w_privilege_painter
end type
type cb_addtemp from commandbutton within w_privilege_painter
end type
type p_2 from picture within w_privilege_painter
end type
type cb_delete from commandbutton within w_privilege_painter
end type
type cb_add from commandbutton within w_privilege_painter
end type
type p_1 from picture within w_privilege_painter
end type
type cb_close from commandbutton within w_privilege_painter
end type
type cb_expand from commandbutton within w_privilege_painter
end type
type dw_template from datawindow within w_privilege_painter
end type
type cb_1 from commandbutton within w_privilege_painter
end type
type dw_tempprop from datawindow within w_privilege_painter
end type
type cb_save from commandbutton within w_privilege_painter
end type
type dw_audit from datawindow within w_privilege_painter
end type
type tab_1 from tab within w_privilege_painter
end type
type tabpage_comp from userobject within tab_1
end type
type st_proc from statictext within tabpage_comp
end type
type st_sect from statictext within tabpage_comp
end type
type st_area from statictext within tabpage_comp
end type
type dw_treeview from u_dw within tabpage_comp
end type
type dw_clin from u_dw within tabpage_comp
end type
type dw_procd from u_dw within tabpage_comp
end type
type dw_core from u_dw within tabpage_comp
end type
type dw_copy from datawindow within tabpage_comp
end type
type tabpage_comp from userobject within tab_1
st_proc st_proc
st_sect st_sect
st_area st_area
dw_treeview dw_treeview
dw_clin dw_clin
dw_procd dw_procd
dw_core dw_core
dw_copy dw_copy
end type
type tabpage_req from userobject within tab_1
end type
type cb_sect_req from commandbutton within tabpage_req
end type
type gb_5 from groupbox within tabpage_req
end type
type dw_clin_req2 from u_dw within tabpage_req
end type
type dw_clin_req3 from u_dw within tabpage_req
end type
type cb_reqcopy from commandbutton within tabpage_req
end type
type dw_copy1 from datawindow within tabpage_req
end type
type dw_copy3 from datawindow within tabpage_req
end type
type dw_copy2 from datawindow within tabpage_req
end type
type cb_copyclin from commandbutton within tabpage_req
end type
type dw_clin_req from u_dw within tabpage_req
end type
type gb_7 from groupbox within tabpage_req
end type
type dw_clin_select from datawindow within tabpage_req
end type
type tabpage_req from userobject within tab_1
cb_sect_req cb_sect_req
gb_5 gb_5
dw_clin_req2 dw_clin_req2
dw_clin_req3 dw_clin_req3
cb_reqcopy cb_reqcopy
dw_copy1 dw_copy1
dw_copy3 dw_copy3
dw_copy2 dw_copy2
cb_copyclin cb_copyclin
dw_clin_req dw_clin_req
gb_7 gb_7
dw_clin_select dw_clin_select
end type
type tabpage_acknow from userobject within tab_1
end type
type dw_acknow from u_dw within tabpage_acknow
end type
type st_1 from statictext within tabpage_acknow
end type
type tabpage_acknow from userobject within tab_1
dw_acknow dw_acknow
st_1 st_1
end type
type tabpage_report from userobject within tab_1
end type
type cb_8 from uo_cb_output within tabpage_report
end type
type cb_ex from commandbutton within tabpage_report
end type
type dw_print from u_dw within tabpage_report
end type
type gb_9 from groupbox within tabpage_report
end type
type gb_6 from groupbox within tabpage_report
end type
type cb_preview from commandbutton within tabpage_report
end type
type cb_print from commandbutton within tabpage_report
end type
type ddlb_report from dropdownlistbox within tabpage_report
end type
type dw_clin_select_preview from datawindow within tabpage_report
end type
type cb_2 from commandbutton within tabpage_report
end type
type tabpage_report from userobject within tab_1
cb_8 cb_8
cb_ex cb_ex
dw_print dw_print
gb_9 gb_9
gb_6 gb_6
cb_preview cb_preview
cb_print cb_print
ddlb_report ddlb_report
dw_clin_select_preview dw_clin_select_preview
cb_2 cb_2
end type
type tab_1 from tab within w_privilege_painter
tabpage_comp tabpage_comp
tabpage_req tabpage_req
tabpage_acknow tabpage_acknow
tabpage_report tabpage_report
end type
type dw_select_dept from datawindow within w_privilege_painter
end type
end forward

global type w_privilege_painter from w_main
integer x = 9
integer y = 4
integer width = 4265
integer height = 2436
string title = "Privilege Templates"
long backcolor = 33551856
event ue_newtemplate ( )
event ue_deletetemplate ( )
event ue_copyallclinicalarea ( )
event ue_copysingleclinicalarea ( )
event ue_saveprivform ( )
event ue_viewprivform ( )
event ue_viewproperties ( )
event ue_deleteprivform ( )
cb_data_source cb_data_source
mle_text mle_text
st_temp st_temp
cb_addtemp cb_addtemp
p_2 p_2
cb_delete cb_delete
cb_add cb_add
p_1 p_1
cb_close cb_close
cb_expand cb_expand
dw_template dw_template
cb_1 cb_1
dw_tempprop dw_tempprop
cb_save cb_save
dw_audit dw_audit
tab_1 tab_1
dw_select_dept dw_select_dept
end type
global w_privilege_painter w_privilege_painter

type prototypes

end prototypes

type variables
integer il_clicked_column
integer il_width
integer il_height
integer il_x
integer il_y
Integer ii_levell//long.zhang 11.28.2013

long il_facility  //this is actually the template id
long il_facility_report //maha 06.22.2011
long il_clin_area_preview

u_dw idw_current //maha 10.05.2009
long il_TvCurrentRow
long il_TvGroupLevel
string is_ViewDocPath
string is_word_ds_file //maha 02.22.2017
end variables

forward prototypes
public function integer of_copy_area (string as_from, integer ai_facility)
public function integer of_copy_area_new (string as_from, integer ai_facility, boolean ab_all_copy)
public function integer of_ccp_check (long al_clin, long al_facil)
public function string of_ccp_facility_text (long al_clin, long al_fac)
public function integer of_set_clin_dept (long ai_area, integer ai_tab)
public function integer of_get_requirements (long al_clin_id)
public function integer of_add_audit (string as_user, string as_from, long al_row, u_dw adw_cur)
public function integer of_set_dw_focus (string as_dw)
public function integer of_copyclinicalareas (long al_tempate_id, boolean ab_all_copy)
public function blob of_downloadfile (long al_clinical_area_id)
public function integer of_getlookupvalue (datastore ads_proc_lookup, long al_lookup_code, ref string as_code, ref string as_description, string as_table)
public function integer of_change_section (long al_row)
public function integer of_set_security ()
public function integer of_modify_dwprotect (datawindow adw_data)
public function long of_get_facility ()
end prototypes

event ue_newtemplate();//////////////////////////////////////////////////////////////////////
// $<event> ue_newtemplate
// $<arguments>
// $<returns> (None)
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 01.27.2011
//////////////////////////////////////////////////////////////////////

long ll_Row
long ll_template_id
string ls_template_name
datawindowchild ldw_child

// Get template name
Open(w_get_privtemp_name)
ls_template_name = Message.StringParm
if ls_template_name = "" then Return

// Create a new record
SELECT max(template_id) INTO :ll_template_id FROM priv_template;
if IsNull(ll_template_id) then ll_template_id = 0
ll_template_id ++
INSERT INTO priv_template (template_id, template_name)
		 VALUES (:ll_template_id, :ls_template_name);

// Refresh dropdown datawindow
dw_template.GetChild("template_id", ldw_child)
ll_Row = ldw_child.InsertRow(0)
ldw_child.ScrollToRow(ll_Row)
ldw_child.SetItem(ll_Row, "template_id", ll_template_id)
ldw_child.SetItem(ll_Row, "template_name", ls_template_name)
dw_template.SetItem(1, "template_id", ll_template_id)
dw_template.Event ItemChanged(1, dw_template.object.template_id, String(ll_template_id))
end event

event ue_deletetemplate();//////////////////////////////////////////////////////////////////////
// $<event> ue_deletetemplate
// $<arguments>
// $<returns> (None)
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 01.28.2011
//////////////////////////////////////////////////////////////////////

long ll_Count
long ll_template_id
datawindowchild ldw_child

// Do some checks
ll_template_id = dw_template.GetItemNumber(1, "template_id")
if IsNull(ll_template_id) then
	MessageBox("Delete", "Please select a template.")
	dw_template.SetFocus()
	Return
end if

SELECT count(*) INTO :ll_Count
FROM pd_priv_list, priv_clinical_area
WHERE pd_priv_list.clinical_area_id = priv_clinical_area.clinical_area_id AND
		priv_clinical_area.facility_id = :ll_template_id;
if ll_Count > 0 then
	MessageBox("Delete", "The selected template is being referenced in Privilege of Practitioner Folder, so it cannot be deleted.", Exclamation!)
	dw_template.SetFocus()
	Return
end if
if MessageBox("Delete", "Are you sure that you want to delete the selected template?", Question!, YesNo!, 2) = 2 then
	Return
end if

// Delete template records
gnv_appeondb.of_StartQueue()
DELETE priv_core_procd
FROM priv_template, priv_clinical_area, priv_core, priv_core_procd
WHERE priv_template.template_id = priv_clinical_area.facility_id AND
		priv_clinical_area.clinical_area_id = priv_core.clinical_area_id AND
		priv_core.priv_core_id = priv_core_procd.priv_core_id AND
		priv_template.template_id = :ll_template_id;
DELETE priv_core
FROM priv_template, priv_clinical_area, priv_core
WHERE priv_template.template_id = priv_clinical_area.facility_id AND
		priv_clinical_area.clinical_area_id = priv_core.clinical_area_id AND
		priv_template.template_id = :ll_template_id;
DELETE priv_clinical_area
FROM priv_template, priv_clinical_area
WHERE priv_template.template_id = priv_clinical_area.facility_id AND
		priv_template.template_id = :ll_template_id;
DELETE FROM priv_template WHERE priv_template.template_id = :ll_template_id;
COMMIT;
gnv_appeondb.of_CommitQueue()

// Refresh dropdown datawindow
dw_template.GetChild("template_id", ldw_child)
ldw_child.DeleteRow(0)
if ldw_child.RowCount() > 0 then
	ldw_child.SetRow(1)
	ldw_child.SelectRow(1, true)
	ll_template_id = ldw_child.GetItemNumber(1, "template_id")
	dw_template.SetItem(1, "template_id", ll_template_id)
	dw_template.Event ItemChanged(1, dw_template.object.template_id, String(ll_template_id))
else
	SetNull(ll_template_id)
	dw_template.SetItem(1, "template_id", ll_template_id)
	dw_template.Event ItemChanged(1, dw_template.object.template_id, "-1")
end if

end event

event ue_CopyAllClinicalArea();//////////////////////////////////////////////////////////////////////
// $<event> ue_CopyAllClinicalArea
// $<arguments>
// $<returns> (None)
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 01.28.2011
//////////////////////////////////////////////////////////////////////

integer li_rc
long ll_template_id

li_rc = tab_1.tabpage_comp.dw_clin.rowcount()
if li_rc = 0 then
	if IsNull(dw_template.object.template_id[1]) then
		Messagebox("Privilege Copy Function", "Please select a Template to copy privileges FROM.")
		dw_template.SetFocus()
		Return
	else
		Messagebox("Privilege Copy Function", "Selected Template appears not to have any privileges set up.")
		Return
	end if
end if	
li_rc = Messagebox("Privilege Copy Function", "This function will copy ALL privileges in ALL clinical Areas. Continue?", question!, yesno!, 2)
if li_rc = 2 then Return
li_rc = Messagebox("Privilege Copy Function", "Are you Sure?", question!, yesno!, 2)
if li_rc = 2 then Return

Open(w_select_privtemp)
ll_template_id = Message.DoubleParm
if ll_template_id = 0 then Return

of_CopyClinicalAreas(ll_template_id, true)
Messagebox("Privilege Copied", "Complete!")
end event

event ue_copysingleclinicalarea();//////////////////////////////////////////////////////////////////////
// $<event> ue_CopySingleClinicalArea
// $<arguments>
// $<returns> (None)
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 01.28.2011
//////////////////////////////////////////////////////////////////////

long ll_template_id
integer li_rc

li_rc = tab_1.tabpage_comp.dw_clin.rowcount()
if li_rc = 0 then
	if IsNull(dw_template.object.template_id[1]) then
		Messagebox("Clinical Area Copied", "Please select a Template.")
		dw_template.SetFocus()
		Return
	else
		Messagebox("Clinical Area Copied", "Selected Template appears not to have any privileges set up.")
		Return
	end if
end if	

Open(w_select_privtemp)
ll_template_id = Message.DoubleParm
if ll_template_id = 0 then Return

of_CopyClinicalAreas(ll_template_id, false)
MessageBox("Clinical Area Copied", "Complete!")
end event

event ue_saveprivform();//////////////////////////////////////////////////////////////////////
// $<event> ue_saveprivform
// $<arguments>
// $<returns> (None)
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 02.21.2011
//////////////////////////////////////////////////////////////////////

blob lblb_Data
integer li_Return
string ls_DocPath
string ls_DocName
string ls_Ext
long ll_Pos
long ll_Row
long ll_Count
long ll_priv_form_id
long ll_clinical_area_id
n_cst_dm_utils lnv_file

ll_Row = tab_1.tabpage_comp.dw_clin.GetRow()
if ll_Row < 1 then
	Messagebox("Save Privilege Form", "There is no Clinical Area record.", Exclamation!)
	Return
end if
ll_clinical_area_id = tab_1.tabpage_comp.dw_clin.GetItemNumber(ll_Row, "clinical_area_id")

// Get file name
li_Return = GetFileOpenName("Select File", ls_DocPath, ls_DocName, "doc", &
									 "Word Document (*.docx),*.docx," + &
									 "Word 97-2003 Document (*.doc),*.doc," + &
									 "Excel Workbook (*.xlsx),*.xlsx," + &
									 "Excel 97-2003 Workbook (*.xls),*.xls," + &
									 "TIFF Files (*.tif),*.tif," + &
									 "Bitmap Files (*.bmp),*.bmp," + &
									 "JPG Files (*.jpg),*.jpg," + &
									 "PDF Files (*.pdf),*.pdf," + &
									 "Text Files (*.txt),*.txt", &
									 gs_current_path)
ChangeDirectory(gs_current_path)
if li_Return <> 1 then Return

// Read file contents
if lnv_file.of_ReadBlob(ls_DocPath, lblb_Data) <> 1 then
	MessageBox("Save Privilege Form", "Failed to read file.", StopSign!)
	Return
end if

// Insert a record to database
ll_Pos = LastPos(ls_DocPath, '.')
ls_Ext = Mid(ls_DocPath, ll_Pos + 1, 255)
SELECT count(*) INTO :ll_Count FROM priv_ca_form WHERE clinical_area_id = :ll_clinical_area_id;
if ll_Count > 0 then
	UPDATE priv_ca_form SET form_type = :ls_Ext WHERE clinical_area_id = :ll_clinical_area_id;
else
	SELECT max(priv_form_id) INTO :ll_priv_form_id FROM priv_ca_form;
	if IsNull(ll_priv_form_id) then ll_priv_form_id = 0
	ll_priv_form_id ++
	INSERT INTO priv_ca_form (priv_form_id,clinical_area_id,form_type) VALUES (:ll_priv_form_id, :ll_clinical_area_id, :ls_Ext);
end if

// Upload file contents to database
UPDATEBLOB priv_ca_form SET form_data = :lblb_data WHERE clinical_area_id = :ll_clinical_area_id;
if SQLCA.SQLCode = 0 then
	COMMIT;
	tab_1.tabpage_comp.dw_clin.SetItem(ll_Row, "datalen", 1)
	tab_1.tabpage_comp.dw_clin.SetItemStatus(ll_Row, "datalen", Primary!, NotModified!)
	MessageBox("Save Privilege Form", "Save privilege form successful.")
else
	ROLLBACK;
	MessageBox("Save Privilege Form", "Failed to save privilege form.~r~n" + SQLCA.SQLErrText, StopSign!)
end if
end event

event ue_viewprivform();//////////////////////////////////////////////////////////////////////
// $<event> ue_viewprivform
// $<arguments>
// $<returns> (None)
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 02.22.2011
//////////////////////////////////////////////////////////////////////

blob lblb_Data
string ls_form_type
string ls_DocPath
string ls_DocName
string ls_datasource  //maha 01.10.2017
long ll_Row
long ll_clinical_area_id
long ll_facil  //maha 02.22.2017
n_cst_dm_utils lnv_file

ll_Row = tab_1.tabpage_comp.dw_clin.GetRow()
if ll_Row < 1 then
	Messagebox("View Privilege Form", "There is no Clinical Area record.", Exclamation!)
	Return
end if
ll_clinical_area_id = tab_1.tabpage_comp.dw_clin.GetItemNumber(ll_Row, "clinical_area_id")
SELECT form_type INTO :ls_form_type FROM priv_ca_form WHERE clinical_area_id = :ll_clinical_area_id;
if IsNull(ls_form_type) or ls_form_type = "" then
	Messagebox("View Privilege Form", "Please save privilege form first.", Exclamation!)
	Return
end if

// Download file from database
//ls_DocName = "view_document." + ls_form_type
ls_DocName = "priv_document" + string(ll_clinical_area_id) + "." + ls_form_type

ls_DocPath = is_ViewDocPath + ls_DocName
//lblb_Data = of_DownloadFile(ll_clinical_area_id)
lblb_Data = of_Download_File("PRIVFORM", "", ll_clinical_area_id)

if lnv_file.of_SaveBlob(ls_DocPath, lblb_Data) <> 1 then
	MessageBox("View Privilege Form", "Failed to write file: " + ls_DocPath, StopSign!)
	Return
end if

// Open document
choose case Upper(ls_form_type)
	case "TIF", "BMP", "JPG" //, "PDF" //Commented "pdf" by (Appeon)Stephen 2013-08-20  
		OpenWithParm(w_image_display, ls_DocPath + '|' + ls_DocName)
	 //Start Code Change ----01.10.2017 #V153 maha - code for merge document
	case "DOC", "DOCX"
		if il_facility_report > 0 then
			ll_facil = il_facility_report
		else
			ll_facil = of_get_facility( )
			if ll_facil < 1 then ll_facil = 1 //set default if no connection
		end if
		//ls_datasource = of_letter_paths("D") //merge document path
		ls_datasource = of_priv_data_source_800( ll_clinical_area_id, ll_facil, 0)
		//ls_datasource = of_priv_data_source_variable( ll_clinical_area_id, ll_facil, 0)   //Start Code Change ----05.02.2017 #V153 maha - changed function call
		//ls_datasource+= "priv_data_source.txt"
		if not FileExists(ls_datasource) then
			messagebox("Privilege Document","There is no datasource for this document.")
		end if
		//messagebox(ls_DocPath,ls_datasource)
		of_open_letter(ls_DocPath,ls_datasource,"Privileges")
	 //End Code Change ----01.10.2017
//	case "DOC", "DOCX" , "XLS", "XLSX"  //Start Code Change ----05.05.2016 #V15 maha - removed
//		OpenWithParm(w_priv_view_doc, String(ll_clinical_area_id) + "|" + ls_DocPath)
	case else
		ShellExecuteA(0, "open", ls_DocPath, "", "", 1)
end choose
end event

event ue_viewproperties();//Start Code Change ----03.14.2011 #V11 maha 
if IsNull(dw_template.object.template_id[1]) then
	MessageBox("Prompt", "Please select a Template first!")
	dw_template.SetFocus()
	Return
end if

openwithparm(w_priv_template_prop,il_facility)
//dw_tempprop.retrieve(il_facility)  //Start Code Change ----01.23.2012 #V12 maha - removed as all the properties are now on the acknowlege tab
tab_1.tabpage_acknow.dw_acknow.retrieve(il_facility)  //Start Code Change ----06.16.2011 #V11 maha 
end event

event ue_deleteprivform();//====================================================================
//$<Event>: ue_DeletePrivForm
//$<Arguments>:
//$<Return>:  (None)
//$<Description>: Allow to delete Priviledge Form.
//$<Author>: (Appeon) long.zhang 03.13.2017 (BugL022701)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================


long ll_Row
long ll_Count
long ll_clinical_area_id

ll_Row = tab_1.tabpage_comp.dw_clin.GetRow()
if ll_Row < 1 then
	Messagebox("Delete Privilege Form", "There is no Clinical Area record.", Exclamation!)
	Return
end if
ll_clinical_area_id = tab_1.tabpage_comp.dw_clin.GetItemNumber(ll_Row, "clinical_area_id")

//Delete file
Delete from priv_ca_form WHERE clinical_area_id = :ll_clinical_area_id;
if SQLCA.SQLCode = 0 then
	COMMIT;
	tab_1.tabpage_comp.dw_clin.SetItem(ll_Row, "datalen", 0)
	tab_1.tabpage_comp.dw_clin.SetItemStatus(ll_Row, "datalen", Primary!, NotModified!)
	MessageBox("Delete Privilege Form", "Delete privilege form successful.")
else
	ROLLBACK;
	MessageBox("Delete Privilege Form", "Failed to Delete privilege form.~r~n" + SQLCA.SQLErrText, StopSign!)
end if
end event

public function integer of_copy_area (string as_from, integer ai_facility);
long li_newrow //maha app101305 changed all from int 
long li_clinid
long li_coreid
long li_procdid
long li_corerow
long li_procdrow
long li_corecount
long li_procdcount
long li_facilid
long li_coreoldid
long li_error
long li_coresort
long li_procdsort
long li_clinid_org
string ls_clincode
string ls_corename
string ls_clinname
string ls_procdname
string ls_procddesc


li_facilid = ai_facility
if li_facilid = 0 then return -1

//ls_clincode = tab_1.tabpage_comp.dw_clin.getitemstring(tab_1.tabpage_comp.dw_clin.getrow(),"priv_clinical_area_clinical_area_code")
//ls_clinname = tab_1.tabpage_comp.dw_clin.getitemstring(tab_1.tabpage_comp.dw_clin.getrow(),"priv_clinical_area_clinical_area_descrip")
select max(clinical_area_id)
into: li_clinid
from priv_clinical_area;
li_clinid++

//Start Code Change ---- 07.12.2006 #1 maha changed to rowscopy rather than insert
tab_1.tabpage_comp.dw_clin.rowscopy(tab_1.tabpage_comp.dw_clin.getrow(), tab_1.tabpage_comp.dw_clin.getrow(), primary!, tab_1.tabpage_comp.dw_clin,10000, primary!)
//li_newrow = tab_1.tabpage_comp.dw_clin.insertrow(0)
li_newrow = tab_1.tabpage_comp.dw_clin.rowcount()
tab_1.tabpage_comp.dw_clin.setitem(li_newrow,"facility_id",li_facilid)
tab_1.tabpage_comp.dw_clin.setitem(li_newrow,"clinical_area_id",li_clinid)
//tab_1.tabpage_comp.dw_clin.setitem(li_newrow,"priv_clinical_area_clinical_area_code",ls_clincode)
//tab_1.tabpage_comp.dw_clin.setitem(li_newrow,"priv_clinical_area_clinical_area_descrip",ls_clinname)
li_clinid_org = tab_1.tabpage_comp.dw_clin.getitemnumber(tab_1.tabpage_comp.dw_clin.getrow(),"clinical_area_id")
if tab_1.tabpage_comp.dw_clin.getitemnumber(tab_1.tabpage_comp.dw_clin.getrow(),"common_core") = 1 then
	of_ccp_check(li_clinid_org,li_facilid) //add record if does not exist	
end if
//End Code Change---07.12.2006
li_error = tab_1.tabpage_comp.dw_clin.update()
if li_error = -1 then return -1
//	messagebox("Database Error","Selected Facility already has ~n~r Privileges for this Clinical Area.)

li_corecount = tab_1.tabpage_comp.dw_core.rowcount()
	select max(priv_core_id)
		into :li_coreid
		from priv_core;
	select max(procd_id)
		into :li_procdid
		from priv_core_procd;
for li_corerow = 1 to li_corecount
	ls_corename = tab_1.tabpage_comp.dw_core.getitemstring(li_corerow,"priv_core_description")
	li_coreoldid = tab_1.tabpage_comp.dw_core.getitemnumber(li_corerow,"priv_core_id")
	li_coresort = tab_1.tabpage_comp.dw_core.getitemnumber(li_corerow,"sort_order")


//	select max(priv_core_id)
//	into :li_coreid
//	from priv_core;
	li_coreid++
	li_newrow = tab_1.tabpage_comp.dw_core.insertrow(0)
	tab_1.tabpage_comp.dw_core.setitem(li_newrow,"priv_core_id",li_coreid)
	tab_1.tabpage_comp.dw_core.setitem(li_newrow,"clinical_area_id",li_clinid)
	tab_1.tabpage_comp.dw_core.setitem(li_newrow,"priv_core_description",ls_corename)
	tab_1.tabpage_comp.dw_core.setitem(li_newrow,"sort_order",li_coresort)
	tab_1.tabpage_comp.dw_core.update()
	
	tab_1.tabpage_comp.dw_copy.settransobject(sqlca)
	tab_1.tabpage_comp.dw_copy.retrieve(li_coreoldid)
	//messagebox("li_coreid",li_coreid)
	li_procdcount = tab_1.tabpage_comp.dw_copy.rowcount()
	//messagebox("li_procdcount",li_procdcount)
	for li_procdrow = 1 to li_procdcount
		ls_procddesc = tab_1.tabpage_comp.dw_copy.getitemstring(li_procdrow,"core_procd_description")
		ls_procdname = tab_1.tabpage_comp.dw_copy.getitemstring(li_procdrow,"priv_core_procd_procd_name")
		li_procdsort = tab_1.tabpage_comp.dw_copy.getitemnumber(li_procdrow,"sort_order")
//		select max(procd_id)
//		into :li_procdid
//		from priv_core_procd;
		li_procdid++
		li_newrow = tab_1.tabpage_comp.dw_procd.insertrow(0)
		tab_1.tabpage_comp.dw_procd.setitem(li_newrow,"procd_id",li_procdid)
		tab_1.tabpage_comp.dw_procd.setitem(li_newrow,"priv_core_id",li_coreid)
		tab_1.tabpage_comp.dw_procd.setitem(li_newrow,"core_procd_description",ls_procddesc)
		tab_1.tabpage_comp.dw_procd.setitem(li_newrow,"procd_name",ls_procdname)	
		tab_1.tabpage_comp.dw_procd.setitem(li_newrow,"sort_order",li_procdsort)
		tab_1.tabpage_comp.dw_procd.update()
	next
next

tab_1.tabpage_comp.dw_clin.settransobject(sqlca)
tab_1.tabpage_comp.dw_clin.retrieve(il_facility)

tab_1.tabpage_comp.dw_clin.triggerevent(rowfocuschanged!)

if as_from = "AREA" then
	messagebox("Clinical Area Copied","Complete")
end if

return 1
end function

public function integer of_copy_area_new (string as_from, integer ai_facility, boolean ab_all_copy);//////////////////////////////////////////////////////////////////////
// $<function>w_privilege_painterof_copy_area_new()
// $<arguments>
//		value	string 	as_FROM    		
//		value	integer	ai_facility		
//		value	boolean	ab_all_copy		
// $<RETURNs> integer
// $<description> PerFORmance tuning
// $<description> Reduce the frequency of client-server interactions TO improve runtime perFORmance.
// $<description> Use the Filter of DataSTOre take the place of the retrieve of DataWidow in loop
//////////////////////////////////////////////////////////////////////
// $<add> 02.13.2006 by LeiWei
//////////////////////////////////////////////////////////////////////

long li_clinid
long li_coreid
long li_procdid
long li_clinrow
long li_corerow
long li_procdrow
long li_clincount
long li_corecount
long li_procdcount
long li_facilid
long li_coreoldid
long li_clinoldid
Long ll_clinical_area_id[]

li_facilid = ai_facility
IF li_facilid = 0 THEN RETURN -1

DatasTOre lds_clin_copy,lds_core_copy,lds_procd_copy
IF ab_all_copy THEN
	li_clincount = tab_1.tabpage_comp.dw_clin.rowcount( )
	FOR li_clinrow = 1 TO li_clincount
		ll_clinical_area_id[li_clinrow] = tab_1.tabpage_comp.dw_clin.getitemnumber(li_clinrow,1)
	NEXT
ELSE
	ll_clinical_area_id[1] = tab_1.tabpage_comp.dw_clin.getitemnumber(tab_1.tabpage_comp.dw_clin.getrow(),1)
END IF

lds_clin_copy = Create datasTOre
lds_clin_copy.dataobject = 'd_priv_clinical_area_copy_FORpt'
lds_clin_copy.settransobject( sqlca )

lds_core_copy = Create datasTOre
lds_core_copy.dataobject = 'd_priv_core_copy_FORpt'
lds_core_copy.settransobject( sqlca )

lds_procd_copy = Create datasTOre
lds_procd_copy.dataobject = 'd_priv_core_procd_copy_FORpt'
lds_procd_copy.settransobject( sqlca )

gnv_appeondb.of_startqueue( )
	lds_clin_copy.Retrieve( ll_clinical_area_id )
	lds_core_copy.Retrieve( ll_clinical_area_id )
	lds_procd_copy.Retrieve( ll_clinical_area_id )

	SELECT max(clinical_area_id) INTO :li_clinid FROM priv_clinical_area;
	SELECT max(priv_core_id) INTO :li_coreid FROM priv_core;
	SELECT max(procd_id)	INTO :li_procdid	FROM priv_core_procd;
gnv_appeondb.of_commitqueue( )

li_clincount = lds_clin_copy.rowcount( )
FOR li_clinrow = 1 TO li_clincount
	li_clinoldid = lds_clin_copy.getitemnumber(li_clinrow,"clinical_area_id")
	
	//Start Code Change ----10.03 .2006 #662 maha
	if lds_clin_copy.getitemnumber(li_clinrow,"common_core") = 1 then
		of_ccp_check(li_clinoldid,li_facilid) //add record if does not exist	
	end if
	//End Code Change---10.03.2006
	li_clinid++
	lds_clin_copy.setitem(li_clinrow,"facility_id",li_facilid)
	lds_clin_copy.setitem(li_clinrow,"clinical_area_id",li_clinid)
	lds_clin_copy.SetItemStatus(li_clinrow, 0, Primary!, NewModIFied!)

	lds_core_copy.SetFilter("clinical_area_id = " + String(li_clinoldid))
	lds_core_copy.Filter()
	li_corecount = lds_core_copy.rowcount()
	
	FOR li_corerow = 1 TO li_corecount
		li_coreoldid = lds_core_copy.getitemnumber(li_corerow,"priv_core_id")
		
		li_coreid++
		lds_core_copy.setitem(li_corerow,"priv_core_id",li_coreid)
		lds_core_copy.setitem(li_corerow,"clinical_area_id",li_clinid)
		lds_core_copy.SetItemStatus(li_corerow, 0, Primary!, NewModIFied!)
		
		lds_procd_copy.SetFilter("priv_core_id = " + String(li_coreoldid))
		lds_procd_copy.Filter()
		li_procdcount = lds_procd_copy.rowcount()
		FOR li_procdrow = 1 TO li_procdcount
			li_procdid++
			lds_procd_copy.setitem(li_procdrow,"procd_id",li_procdid)
			lds_procd_copy.setitem(li_procdrow,"priv_core_id",li_coreid)
			lds_procd_copy.SetItemStatus(li_procdrow, 0, Primary!, NewModIFied!)
		NEXT
	NEXT
NEXT



gnv_appeondb.of_update( lds_clin_copy, lds_core_copy, lds_procd_copy)

IF il_facility = li_facilid THEN
	li_clinrow = tab_1.tabpage_comp.dw_clin.Getrow()
	tab_1.tabpage_comp.dw_clin.settransobject(sqlca)
	tab_1.tabpage_comp.dw_clin.retrieve(il_facility)
	IF li_clinrow = 1 THEN
		tab_1.tabpage_comp.dw_clin.triggerevent(rowfocuschanged!)
	END IF
END IF

IF as_from = "AREA" THEN
	messagebox("Clinical Area Copied","Complete")
END IF

RETURN 1
end function

public function integer of_ccp_check (long al_clin, long al_facil);//Start Code Change ---- 10.03.2006 #663 maha
//created 07.1206 the check for existance of facility record in ccp facilities
debugbreak()
integer i
long ccpid
select count(clin_id) into :i from priv_ccp_facility where clin_id = :al_clin and facility_id = :al_facil;


if i > 0 then
	return -1
else
	select max(ccp_id) into :ccpid from priv_ccp_facility;
	if isnull(ccpid) then ccpid = 0
	ccpid++
	insert into priv_ccp_facility values(:ccpid,:al_clin,:al_facil);
	return 1
end if
//End Code Change---10.03.2006
end function

public function string of_ccp_facility_text (long al_clin, long al_fac);//Start Code Change ---- 10.03.2006 #664 maha
//added maha 071206 to set text on report for inova
datastore lds_ccp
datawindowchild dwchild
integer i
integer ic
integer c
integer f
long ll_fac
string ls_text
string ls_facil
string ls_ret  = "NO"
debugbreak()
select common_core into :c from priv_clinical_area where clinical_area_id = :al_clin;

if c = 1 then //
	lds_ccp = create datastore
	lds_ccp.dataobject = "d_ccp_facil_add"
	lds_ccp.settransobject(sqlca)
	ic = lds_ccp.retrieve(al_clin,al_fac) 
	if ic > 0 then
		lds_ccp.getchild( "facility_id", dwchild)
		for i = 1 to ic
			ll_fac = lds_ccp.getitemnumber(i,"facility_id")
			f = dwchild.find("facility_id = " + string(ll_fac),1,10000)
			if f > 0 then
				ls_facil = dwchild.getitemstring(f,"facility_facility_name")
				if i > 1 then ls_text = ls_text + "  "
				ls_text = ls_text + "O " + ls_facil
			end if
		next
		ls_ret = ls_text
	end if
end if
//messagebox("ls_ret",ls_ret)

//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 08.23.2007 By: Evan
//$<Reason> Need to destroy object.
if IsValid(lds_ccp) then Destroy lds_ccp
//---------------------------- APPEON END ----------------------------

return ls_ret
//End Code Change---10.03.2006
end function

public function integer of_set_clin_dept (long ai_area, integer ai_tab);//Start Code Change ----10.06.2009 #V10 maha - new function to auto select the clinical area
long li_find

DataWindowChild dwchild

//debugbreak()
choose case ai_tab
	case 1
		li_find = dw_select_dept.setitem(1,"clinical_area_id",ai_area)
//		li_find = tab_1.tabpage_req.dw_clin_select.setitem(1,"clinical_area_id",ai_area)
//		li_find = tab_1.tabpage_report.dw_clin_select_preview.setitem(1,"clinical_area_id",ai_area)
//		tab_1.tabpage_req.dw_clin_select.GetChild( "clinical_area_id", dwchild )
//		li_find = dwchild.find( "clinical_area_id = " + string(ai_area), 1, dwchild.rowcount())
		of_get_requirements(ai_area )
//		if li_find > 0 then
	case 2
		of_get_requirements(ai_area )
		//li_find = tab_1.tabpage_report.dw_clin_select_preview.setitem(1,"clinical_area_id",ai_area)
	case 3
		//nothing
	case 4
		//li_find = tab_1.tabpage_req.dw_clin_select.setitem(1,"clinical_area_id",ai_area)
		of_get_requirements(ai_area )
end choose

il_clin_area_preview = ai_area


return 1
end function

public function integer of_get_requirements (long al_clin_id);long ll_row
integer r

gnv_appeondb.of_startqueue( )
//---------------------------- APPEON END ----------------------------

//messagebox("clin number",ll_clin_id)
tab_1.tabpage_req.dw_clin_req.settransobject(sqlca)
r = tab_1.tabpage_req.dw_clin_req.retrieve(al_clin_id)

//*set 2nd part of data window
tab_1.tabpage_req.dw_clin_req2.settransobject(sqlca)
r = tab_1.tabpage_req.dw_clin_req2.retrieve(al_clin_id)

//*set 3rd part of data window
tab_1.tabpage_req.dw_clin_req3.settransobject(sqlca)
r = tab_1.tabpage_req.dw_clin_req3.retrieve(al_clin_id)

//\/moved to facility select itemchanged 12-11-00 maha 
tab_1.tabpage_acknow.dw_acknow.settransobject(sqlca)
r = tab_1.tabpage_acknow.dw_acknow.retrieve(il_facility) //ll_clin_id,

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-10
//$<add> 02.13.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
 
gnv_appeondb.of_commitqueue( )
//---------------------------- APPEON END ----------------------------

if tab_1.tabpage_req.dw_clin_req2.getrow() < 1 then
	ll_row = tab_1.tabpage_req.dw_clin_req2.InsertRow(0)
	tab_1.tabpage_req.dw_clin_req2.scrolltoRow(ll_row)

	tab_1.tabpage_req.dw_clin_req2.SetItem(ll_row, "priv_clinical_area2_clinical_area_id", al_clin_id )
end if

if tab_1.tabpage_req.dw_clin_req3.getrow() < 1 then
	ll_row = tab_1.tabpage_req.dw_clin_req3.InsertRow(0)
	tab_1.tabpage_req.dw_clin_req3.scrolltoRow(ll_row)
	
	tab_1.tabpage_req.dw_clin_req3.SetItem(ll_row, "priv_clinical_area_3_clinical_area_id", al_clin_id )
	tab_1.tabpage_req.dw_clin_req3.SetItem(ll_row, "priv_clinical_area_3_custom1_label", "Custom field 1 label" )
	tab_1.tabpage_req.dw_clin_req3.SetItem(ll_row, "priv_clinical_area_3_custom2_label", "Custom field 2 label" )
end if
//\maha
//\/added 12-11-00 maha 
tab_1.tabpage_req.cb_copyclin.enabled = true
tab_1.tabpage_req.cb_reqcopy.enabled  = true
//\maha

return 1
end function

public function integer of_add_audit (string as_user, string as_from, long al_row, u_dw adw_cur);//Start Code Change ----11.04.2009 #V10 maha - added function
long ll_recid
datetime ldt_now
string ls_new
string ls_old
string ls_field
string ls_table
string ls_type
string ls_value
integer nr
long ll_row
long i
long c
long cr
integer li_col
string ls_stat
string ls_colstat
long ll_dept
long ll_sect
long ll_procd
integer li_null
integer li_add

select max(audit_id) into :ll_recid from sys_audit_priv_painter;
if isnull(ll_recid) then ll_recid = 0
ldt_now = datetime(today(),now())

setnull(li_null)
//--------Begin Commented by  Nova 05.27.2010------------------------
//Placed into the loop
//set defaults for table and field
//choose case as_from
//	case "DEPT"
//		ls_table = "Clinical Department"
//		ls_field = "priv_clinical_area_clinical_area_descrip"
//	case "SECT"
//		ls_table = "Section"	
//		ls_field = "priv_core_description"
//		
//	case "PROCD"
//		ls_table = "Procedures"	
//		ls_field = "priv_core_procd_procd_name"
//end choose
//--------End Commented --------------------------------------------


for i = 1 to adw_cur.rowcount()
	ls_stat = of_get_row_status(i,adw_cur,0)
	if ls_stat = "NOT" or ls_stat = "N" then //not  modified or new
		continue
	else //new mod or data mod
		//get appropriate values
		if as_from = "DEPT" then
			//--------Begin Added by Nova 05.27.2010------------------------
			ls_table = "Clinical Department"
      	ls_field = "priv_clinical_area_clinical_area_descrip"
			//--------End Added --------------------------------------------
			ll_dept = adw_cur.getitemnumber(i,"clinical_area_id")
			ll_sect = li_null
			ll_procd = li_null
		elseif as_from = "SECT" then
			//--------Begin Added by Nova 05.27.2010------------------------
		   ls_table = "Section"	
   		ls_field = "priv_core_description"
			//--------End Added --------------------------------------------
			ll_dept = adw_cur.getitemnumber(i,"clinical_area_id")
			ll_sect = adw_cur.getitemnumber(i,"priv_core_id")
			ll_procd = li_null
		elseif as_from = "PROCD" then
			//--------Begin Added by Nova 05.27.2010------------------------
			ls_table = "Procedures"	
         ls_field = "procd_name"
			//--------End Added --------------------------------------------
			ll_dept =  tab_1.tabpage_comp.dw_clin.getitemnumber(tab_1.tabpage_comp.dw_clin.getrow(),"clinical_area_id")
			ll_sect = adw_cur.getitemnumber(i,"priv_core_id")
			ll_procd = adw_cur.getitemnumber(i,"procd_id")
		end if 
		if ls_stat = "NM" then //new modified
			ls_type = "I"
			ls_new = adw_cur.getitemstring(i,ls_field)
			ll_recid++
			nr = dw_audit.insertrow(0)
			dw_audit.setitem(nr,"audit_id",ll_recid)
			dw_audit.setitem(nr,"facility_id",il_facility )
			dw_audit.setitem(nr,"dept_id", ll_dept)
			dw_audit.setitem(nr,"sect_id",ll_sect)
			dw_audit.setitem(nr,"procd_id",ll_procd)
			dw_audit.setitem(nr,"table_name",ls_table )
			dw_audit.setitem(nr,"field_name",ls_field )
			dw_audit.setitem(nr,"old_value", "Record Inserted")
			dw_audit.setitem(nr,"new_value",ls_new)
			dw_audit.setitem(nr,"mod_by",gs_user_id )
			dw_audit.setitem(nr,"date_time_modified",ldt_now)
			dw_audit.setitem(nr,"audit_type",ls_type)
		elseif ls_stat = "D" then //data modified //check each column
			cr = long(adw_cur.Object.DataWindow.Column.Count)
			for c = 1 to cr
				ls_colstat = of_get_row_status(i,adw_cur,c)
				if ls_colstat = "D" then
					adw_cur.setcolumn(c)
					ls_field = adw_cur.getcolumnname()
					choose case ls_field //only add for listed fields
						case "priv_clinical_area_clinical_area_code", "priv_clinical_area_clinical_area_descrip", "priv_core_description", "procd_name", "core_procd_description"
							li_add = 1
							ls_new = adw_cur.getitemstring(i, ls_field)
							ls_old = adw_cur.getitemstring(i, ls_field, primary!, true)
							if len(ls_new) > 2000 then ls_new = left(ls_new,2000)//long.zhang 12.05.2013 db error BugL112801 
							if len(ls_old) > 2000 then ls_old = left(ls_old,2000)//long.zhang 12.05.2013 db error BugL112801 
						case "sort_order"
							li_add = 1
							ls_new = string(adw_cur.getitemnumber(i, ls_field))
							ls_old = string(adw_cur.getitemnumber(i, ls_field, primary!, true))
						case else
							li_add = 0
					end choose
					if li_add = 1 then
						ll_recid++
						ls_type = "E"
						nr = dw_audit.insertrow(0)
						dw_audit.setitem(nr,"audit_id",ll_recid)
						dw_audit.setitem(nr,"facility_id",il_facility )
						dw_audit.setitem(nr,"dept_id", ll_dept)
						dw_audit.setitem(nr,"sect_id",ll_sect)
						dw_audit.setitem(nr,"procd_id",ll_procd)
						dw_audit.setitem(nr,"table_name",ls_table )
						dw_audit.setitem(nr,"field_name",ls_field )
						dw_audit.setitem(nr,"old_value", ls_old)
						dw_audit.setitem(nr,"new_value",ls_new)
						dw_audit.setitem(nr,"mod_by",gs_user_id )
						dw_audit.setitem(nr,"date_time_modified",ldt_now)
						dw_audit.setitem(nr,"audit_type",ls_type)
					end if
				end if
			next
		end if
	end if
	
next


return 1
end function

public function integer of_set_dw_focus (string as_dw);//Start Code Change ----01.26.2010 #V10 maha - created for settig dw color

long ll_get
long ll_lose

//ll_get = 16120575
//ll_get = 13158655 //green 
ll_get = gl_bg_color        //16777215 //white  //Start Code Change ----04.06.2016 #V15 maha
//ll_get = 15792880
//ll_lose = 16638439
//ll_lose = 16114130  //Start Code Change ----07.09.2010 #V10 maha - change from lavender to blue
ll_lose = 	gl_bg_color2	//16774640 //blue  //Start Code Change ----04.06.2016 #V15 maha
//ll_lose = 13158655 //red
//ll_lose = 14803455

choose case as_dw
	case "DEPT"
		tab_1.tabpage_comp.dw_clin.Object.DataWindow.Color = ll_get
		tab_1.tabpage_comp.dw_core.Object.DataWindow.Color = ll_lose
		tab_1.tabpage_comp.dw_procd.Object.DataWindow.Color = ll_lose
		tab_1.tabpage_comp.st_area.backcolor = ll_get   //Start Code Change ----10.19.2011 #V12 maha - added code for the headers
		tab_1.tabpage_comp.st_sect.backcolor = ll_lose
		tab_1.tabpage_comp.st_proc.backcolor = ll_lose
		tab_1.tabpage_comp.dw_clin.borderstyle = styleraised! 
		tab_1.tabpage_comp.dw_core.borderstyle = stylelowered! 
		tab_1.tabpage_comp.dw_procd.borderstyle = stylelowered! 
		idw_current = tab_1.tabpage_comp.dw_clin
	case "SECT"
		tab_1.tabpage_comp.dw_clin.Object.DataWindow.Color = ll_lose
		tab_1.tabpage_comp.dw_core.Object.DataWindow.Color = ll_get
		tab_1.tabpage_comp.dw_procd.Object.DataWindow.Color = ll_lose
		tab_1.tabpage_comp.st_area.backcolor = ll_lose
		tab_1.tabpage_comp.st_sect.backcolor = ll_get
		tab_1.tabpage_comp.st_proc.backcolor = ll_lose
		tab_1.tabpage_comp.dw_clin.borderstyle = stylelowered! 
		tab_1.tabpage_comp.dw_core.borderstyle = styleraised! 
		tab_1.tabpage_comp.dw_procd.borderstyle = stylelowered! 
		idw_current = tab_1.tabpage_comp.dw_core
	case "PROCD"
		tab_1.tabpage_comp.dw_clin.Object.DataWindow.Color = ll_lose
		tab_1.tabpage_comp.dw_core.Object.DataWindow.Color = ll_lose
		tab_1.tabpage_comp.dw_procd.Object.DataWindow.Color = ll_get
		tab_1.tabpage_comp.st_area.backcolor = ll_lose
		tab_1.tabpage_comp.st_sect.backcolor = ll_lose
		tab_1.tabpage_comp.st_proc.backcolor = ll_get
		tab_1.tabpage_comp.dw_clin.borderstyle = stylelowered! 
		tab_1.tabpage_comp.dw_core.borderstyle = stylelowered! 
		tab_1.tabpage_comp.dw_procd.borderstyle = styleraised! 
		idw_current = tab_1.tabpage_comp.dw_procd
end choose
		
return 1
end function

public function integer of_copyclinicalareas (long al_tempate_id, boolean ab_all_copy);//////////////////////////////////////////////////////////////////////
// $<function> of_copyclinicalareas
// $<arguments>
//		long		al_tempate_id		
//		boolean	ab_all_copy		
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 01.31.2011
//////////////////////////////////////////////////////////////////////

long li_clinid
long li_coreid
long li_procdid
long li_clinrow
long li_corerow
long li_procdrow
long li_clincount
long li_corecount
long li_procdcount
long li_coreoldid
long li_clinoldid
long ll_clinical_area_id[]
datastore lds_clin_copy,lds_core_copy,lds_procd_copy

// Get clinical area ids
IF ab_all_copy THEN
	li_clincount = tab_1.tabpage_comp.dw_clin.rowcount( )
	FOR li_clinrow = 1 TO li_clincount
		ll_clinical_area_id[li_clinrow] = tab_1.tabpage_comp.dw_clin.getitemnumber(li_clinrow,1)
	NEXT
ELSE
	ll_clinical_area_id[1] = tab_1.tabpage_comp.dw_clin.getitemnumber(tab_1.tabpage_comp.dw_clin.getrow(),1)
END IF

// Retrieve records according to clinical ids
lds_clin_copy = Create datastore
lds_core_copy = Create datastore
lds_procd_copy = Create datastore
lds_clin_copy.dataobject = 'd_priv_clinical_area_copy_forpt'
lds_core_copy.dataobject = 'd_priv_core_copy_forpt'
lds_procd_copy.dataobject = 'd_priv_core_procd_copy_forpt'
lds_clin_copy.settransobject( sqlca )
lds_core_copy.settransobject( sqlca )
lds_procd_copy.settransobject( sqlca )

gnv_appeondb.of_startqueue( )
lds_clin_copy.Retrieve( ll_clinical_area_id )
lds_core_copy.Retrieve( ll_clinical_area_id )
lds_procd_copy.Retrieve( ll_clinical_area_id )
SELECT max(clinical_area_id) INTO :li_clinid FROM priv_clinical_area;
SELECT max(priv_core_id) INTO :li_coreid FROM priv_core;
SELECT max(procd_id)	INTO :li_procdid	FROM priv_core_procd;
gnv_appeondb.of_commitqueue( )

// Copy records process
li_clincount = lds_clin_copy.rowcount( )
FOR li_clinrow = 1 TO li_clincount
	li_clinoldid = lds_clin_copy.getitemnumber(li_clinrow,"clinical_area_id")
	
	//Start Code Change ----10.03 .2006 #662 maha
	if lds_clin_copy.getitemnumber(li_clinrow,"common_core") = 1 then
		of_ccp_check(li_clinoldid,al_tempate_id) //add record if does not exist	
	end if
	//End Code Change---10.03.2006
	li_clinid++
	lds_clin_copy.setitem(li_clinrow,"facility_id",al_tempate_id)
	lds_clin_copy.setitem(li_clinrow,"clinical_area_id",li_clinid)
	lds_clin_copy.SetItemStatus(li_clinrow, 0, Primary!, NewModIFied!)

	lds_core_copy.SetFilter("clinical_area_id = " + String(li_clinoldid))
	lds_core_copy.Filter()
	li_corecount = lds_core_copy.rowcount()
	
	FOR li_corerow = 1 TO li_corecount
		li_coreoldid = lds_core_copy.getitemnumber(li_corerow,"priv_core_id")
		
		li_coreid++
		lds_core_copy.setitem(li_corerow,"priv_core_id",li_coreid)
		lds_core_copy.setitem(li_corerow,"clinical_area_id",li_clinid)
		lds_core_copy.SetItemStatus(li_corerow, 0, Primary!, NewModIFied!)
		
		lds_procd_copy.SetFilter("priv_core_id = " + String(li_coreoldid))
		lds_procd_copy.Filter()
		li_procdcount = lds_procd_copy.rowcount()
		FOR li_procdrow = 1 TO li_procdcount
			li_procdid++
			lds_procd_copy.setitem(li_procdrow,"procd_id",li_procdid)
			lds_procd_copy.setitem(li_procdrow,"priv_core_id",li_coreid)
			lds_procd_copy.SetItemStatus(li_procdrow, 0, Primary!, NewModIFied!)
		NEXT
	NEXT
NEXT

// Update records
gnv_appeondb.of_update(lds_clin_copy, lds_core_copy, lds_procd_copy)
Destroy lds_clin_copy
Destroy lds_core_copy
Destroy lds_procd_copy

// Refresh UI
if dw_template.object.template_id[1] = al_tempate_id then
	tab_1.tabpage_comp.dw_clin.reset()
	tab_1.tabpage_comp.dw_core.reset()
	tab_1.tabpage_comp.dw_procd.reset()
	tab_1.tabpage_comp.SetRedraw(false)
	tab_1.tabpage_comp.dw_clin.retrieve(al_tempate_id)
	tab_1.tabpage_comp.Tag = "treelocating..."
	tab_1.tabpage_comp.dw_treeview.retrieve(al_tempate_id)
	tab_1.tabpage_comp.Tag = ""
	tab_1.tabpage_comp.dw_treeview.Event ue_Locate()
	tab_1.tabpage_comp.SetRedraw(true)
end if

Return 1
end function

public function blob of_downloadfile (long al_clinical_area_id);//////////////////////////////////////////////////////////////////////
// $<function> of_downloadfile
// $<arguments>
//		long	al_clinical_area_id
// $<returns> blob
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 02.22.2011
//////////////////////////////////////////////////////////////////////

blob lb_data
blob lb_all_data
long ll_data_length
long ll_start
long ll_counter
long ll_loops

SetPointer(HourGlass!)

If gs_dbtype = "ASA" Or appeongetclienttype() <> 'PB' Then
	SELECTBLOB form_data INTO :lb_all_data
	FROM priv_ca_form
	WHERE clinical_area_id = :al_clinical_area_id;
Else			
	SELECT DataLength(form_data) INTO :ll_data_length
	FROM priv_ca_form
	WHERE clinical_area_id = :al_clinical_area_id;
	
	If isnull(ll_data_length) Then ll_data_length = 0
	
	If ll_data_length > 8000 Then 
		If Mod(ll_data_length,8000) = 0 Then
			ll_loops = ll_data_length / 8000 
		Else
			ll_loops = (ll_data_length / 8000) + 1
		End If 
	ElseIf ll_data_length > 0 Then 
		ll_loops = 1 
	End If 
	
	For ll_counter = 1 To ll_loops			
		ll_start = (ll_counter - 1) * 8000 + 1
		SELECTBLOB substring(form_data,:ll_start,8000) INTO :lb_data
		FROM priv_ca_form
		WHERE clinical_area_id = :al_clinical_area_id;			
		lb_all_data += lb_data
	Next
End If
If isnull(lb_all_data) Then lb_all_data = blob('',EncodingAnsi!) //Encoding – Nova 11.16.2010

SetPointer(Arrow!)

Return lb_all_data
end function

public function integer of_getlookupvalue (datastore ads_proc_lookup, long al_lookup_code, ref string as_code, ref string as_description, string as_table);//////////////////////////////////////////////////////////////////////
// $<function> of_GetLookupValue
// $<arguments>
//		datastore	ads_proc_lookup		
//		long			al_lookup_code
//		ref string	as_code
//		ref string	as_description
//		string		as_table
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 04.19.2011
//////////////////////////////////////////////////////////////////////

long ll_Row
datawindowchild ldw_child

if as_Table = "CLIN" then
	as_Code = "[ABBREVIATION]"
	as_Description = "[CLINICAL AREA]"
	ads_proc_lookup.GetChild("clinical_area_id", ldw_child)	
else
	as_Code = "[CODE]"
	as_Description = "[SECTION]"
	ads_proc_lookup.GetChild("section_id", ldw_child)
end if

ll_Row = ldw_child.Find("lookup_code = " + String(al_lookup_code), 1, ldw_child.RowCount())
if ll_Row > 0 then
	as_Code = ldw_child.GetItemString(ll_Row, "code")
	as_Description = ldw_child.GetItemString(ll_Row, "description")
	as_Code = Upper(Left(as_Code, 15))
end if

Return ll_Row
end function

public function integer of_change_section (long al_row);long ll_sect
long ll_org
long ll_procd
integer res

if al_row < 1 then return 0
if tab_1.tabpage_comp.dw_procd.rowcount() < 1 then return 0 //Start Code Change ----02.25.2013 #V12 maha

res = messagebox( "Change Section","This will change the section that the privilege is connected to. Are you sure you wish to continue?", question!,yesno!, 2)

if res = 2 then return 0

ll_sect = tab_1.tabpage_comp.dw_core.getitemnumber(al_row, "priv_core_id")
ll_org = tab_1.tabpage_comp.dw_procd.getitemnumber(tab_1.tabpage_comp.dw_procd.getrow(), "priv_core_id")
ll_procd = tab_1.tabpage_comp.dw_procd.getitemnumber(tab_1.tabpage_comp.dw_procd.getrow(), "procd_id")
debugbreak()
//messagebox("ll_sect",ll_sect)
//messagebox("ll_org",ll_org)
//messagebox("ll_procd",ll_procd)

if ll_sect = ll_org then
	messagebox( "Change Section","You have selected the same Section.  No changes made.")
	return 0
end if


tab_1.tabpage_comp.dw_procd.setitem(tab_1.tabpage_comp.dw_procd.getrow(), "priv_core_id", ll_sect)
cb_save.triggerevent(clicked!)
//tab_1.tabpage_comp.dw_procd.update()
update pd_priv_list set priv_core_id = :ll_sect where priv_core_id = :ll_org and procd_id = :ll_procd;
commit using sqlca;

tab_1.tabpage_comp.dw_core.setrow(al_row)
//tab_1.tabpage_comp.dw_procd.retrieve(ll_org)

return 1
end function

public function integer of_set_security ();//====================================================================
//$<Function>: of_set_security
//$<Arguments>:
//$<Return>:  integer
//$<Description>:  set readonly user access right BugL112101 
//$<Author>: (Appeon) long.zhang 11.28.2013 
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================



ii_levell = w_mdi.of_security_access( 1310 )

if ii_levell = 1 then	//readonly
	ib_disableclosequery = true
	cb_addtemp.visible = false
	cb_save.visible = false
	cb_add.visible = false
	cb_delete.visible = false
	of_modify_dwprotect( tab_1.tabpage_comp.dw_clin)
	of_modify_dwprotect( tab_1.tabpage_comp.dw_core)
	of_modify_dwprotect( tab_1.tabpage_comp.dw_procd)
	
	tab_1.tabpage_req.cb_copyclin.visible = false
	tab_1.tabpage_req.cb_reqcopy.visible = false
	tab_1.tabpage_req.dw_clin_req.enabled = false
	tab_1.tabpage_req.dw_clin_req2.enabled = false
	tab_1.tabpage_req.dw_clin_req3.enabled = false
	
	of_modify_dwprotect( tab_1.tabpage_acknow.dw_acknow)
end if

return 1
end function

public function integer of_modify_dwprotect (datawindow adw_data);//====================================================================
//$<Function>: of_modify_dwprotect
//$<Arguments>:
// 	value    datawindow    adw_data
//$<Return>:  integer
//$<Description>: Modifty datawindow column protect property . Called From of_set_security
//$<Author>: (Appeon) long.zhang 11.28.2013 
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_column_count
Integer i
String ls_visible

if not isValid(adw_data) then return -1

ll_column_count = long(adw_data.describe("Datawindow.Column.count"))

if ll_column_count <= 0 then return -1

For i = 1 to ll_column_count
	
	ls_visible = adw_data.describe('#'+String(i)+'.visible')	
	
	if ls_visible = "1" then
			adw_data.modify('#'+String(i)+'.protect=1')	
	end if
	
end for


return 1
end function

public function long of_get_facility (); //Start Code Change ----02.22.2017 #V153 maha - added
long li_alt
long ll_ret

select count(facility_id)  into :li_alt from facility where priv_template = :il_facility;
if li_alt = 1 then
	select facility_id into :ll_ret from facility where priv_template = :il_facility;
elseif li_alt > 1 then
	openwithparm(w_priv_facility_select,il_facility)
	if message.doubleparm = 0 then
		return -1
	else
		ll_ret = message.doubleparm
	end if
else
	messagebox("","This template is not connected to any Facility.  Will use the #1 facility")
	return -1
end if

return ll_ret
end function

on w_privilege_painter.create
int iCurrent
call super::create
this.cb_data_source=create cb_data_source
this.mle_text=create mle_text
this.st_temp=create st_temp
this.cb_addtemp=create cb_addtemp
this.p_2=create p_2
this.cb_delete=create cb_delete
this.cb_add=create cb_add
this.p_1=create p_1
this.cb_close=create cb_close
this.cb_expand=create cb_expand
this.dw_template=create dw_template
this.cb_1=create cb_1
this.dw_tempprop=create dw_tempprop
this.cb_save=create cb_save
this.dw_audit=create dw_audit
this.tab_1=create tab_1
this.dw_select_dept=create dw_select_dept
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_data_source
this.Control[iCurrent+2]=this.mle_text
this.Control[iCurrent+3]=this.st_temp
this.Control[iCurrent+4]=this.cb_addtemp
this.Control[iCurrent+5]=this.p_2
this.Control[iCurrent+6]=this.cb_delete
this.Control[iCurrent+7]=this.cb_add
this.Control[iCurrent+8]=this.p_1
this.Control[iCurrent+9]=this.cb_close
this.Control[iCurrent+10]=this.cb_expand
this.Control[iCurrent+11]=this.dw_template
this.Control[iCurrent+12]=this.cb_1
this.Control[iCurrent+13]=this.dw_tempprop
this.Control[iCurrent+14]=this.cb_save
this.Control[iCurrent+15]=this.dw_audit
this.Control[iCurrent+16]=this.tab_1
this.Control[iCurrent+17]=this.dw_select_dept
end on

on w_privilege_painter.destroy
call super::destroy
destroy(this.cb_data_source)
destroy(this.mle_text)
destroy(this.st_temp)
destroy(this.cb_addtemp)
destroy(this.p_2)
destroy(this.cb_delete)
destroy(this.cb_add)
destroy(this.p_1)
destroy(this.cb_close)
destroy(this.cb_expand)
destroy(this.dw_template)
destroy(this.cb_1)
destroy(this.dw_tempprop)
destroy(this.cb_save)
destroy(this.dw_audit)
destroy(this.tab_1)
destroy(this.dw_select_dept)
end on

event open;call super::open;cb_add.enabled = false
cb_delete.enabled =false
cb_expand.visible = false

tab_1.tabpage_comp.enabled = false
tab_1.tabpage_acknow.enabled = false
tab_1.tabpage_report.enabled = false
tab_1.tabpage_req.enabled = false

is_ViewDocPath = gs_dir_path + "intellicred\temp\priv\"
gnv_appeondll.of_ParsePath(is_ViewDocPath)

 //Start Code Change ----10.26.2015 #V15 maha - simple
 if of_get_app_setting("set_86","I") = 1 then
	cb_addtemp.visible = false
	dw_template.setitem(1,"template_id", 1)
	dw_template.visible = false
	st_temp.visible = false
end if
 //End Code Change ----10.26.2015 
 
 gb_priv_lookup_update = false  //Start Code Change ----04.27.2017 #V153 maha
end event

event pfc_preopen;call super::pfc_preopen;this.Move(0, 0)
end event

event closequery;//------------------- APPEON BEGIN -------------------
//$<add> Evan 02.14.2011
//$<reason> Saving prompt
integer li_rc
if tab_1.tabpage_comp.Event ue_IsDataChanged() then
	li_rc = MessageBox(gnv_app.iapp_object.DisplayName, &
					"Do you want to save changes?", Exclamation!, YesNoCancel!, 1)
	if li_rc = 3 then
		Return 1
	elseif li_rc = 2 then
		Return 0
	else
		cb_save.Event Clicked()
	end if
else
	Return super::Event CloseQuery()
end if

Return 0
//------------------- APPEON END ---------------------
end event

event resize;call super::resize;tab_1.Width = THIS.Width * .986 - tab_1.x
tab_1.Height = THIS.Height - 350 

tab_1.tabpage_comp.dw_treeview.Width = tab_1.Width * .3538 - tab_1.tabpage_comp.dw_treeview.x
tab_1.tabpage_comp.dw_treeview.Height = tab_1.Height - 160 

tab_1.tabpage_comp.st_area.x = tab_1.tabpage_comp.dw_treeview.Width + 20
tab_1.tabpage_comp.st_sect.x = tab_1.tabpage_comp.dw_treeview.Width + 20
tab_1.tabpage_comp.st_proc.x = tab_1.tabpage_comp.dw_treeview.Width + 20


tab_1.tabpage_comp.dw_clin.x = tab_1.tabpage_comp.dw_treeview.Width + 20
tab_1.tabpage_comp.dw_core.x = tab_1.tabpage_comp.dw_treeview.Width + 20
tab_1.tabpage_comp.dw_procd.x = tab_1.tabpage_comp.dw_treeview.Width + 20


tab_1.tabpage_comp.st_area.Width = THIS.Width - tab_1.tabpage_comp.dw_treeview.Width - 160
tab_1.tabpage_comp.st_sect.Width = THIS.Width - tab_1.tabpage_comp.dw_treeview.Width - 160
tab_1.tabpage_comp.st_proc.Width = THIS.Width - tab_1.tabpage_comp.dw_treeview.Width - 160


tab_1.tabpage_comp.dw_clin.Width = THIS.Width - tab_1.tabpage_comp.dw_treeview.Width - 160
tab_1.tabpage_comp.dw_clin.Height = THIS.Height * .149

tab_1.tabpage_comp.dw_core.Width = THIS.Width - tab_1.tabpage_comp.dw_treeview.Width - 160
tab_1.tabpage_comp.st_sect.y = tab_1.tabpage_comp.dw_clin.y + tab_1.tabpage_comp.dw_clin.Height + 20
tab_1.tabpage_comp.dw_core.y = tab_1.tabpage_comp.st_sect.y + tab_1.tabpage_comp.st_sect.Height + 10
tab_1.tabpage_comp.dw_core.Height = THIS.Height * .16 

tab_1.tabpage_comp.dw_procd.Width = THIS.Width - tab_1.tabpage_comp.dw_treeview.Width - 160
tab_1.tabpage_comp.st_proc.y = tab_1.tabpage_comp.dw_core.y + tab_1.tabpage_comp.dw_core.Height + 20
tab_1.tabpage_comp.dw_procd.y = tab_1.tabpage_comp.st_proc.y + tab_1.tabpage_comp.st_proc.Height
//tab_1.tabpage_comp.dw_procd.Height = THIS.Height * .44
tab_1.tabpage_comp.dw_procd.Height = tab_1.tabpage_comp.dw_treeview.Height - (tab_1.tabpage_comp.dw_procd.Y - tab_1.tabpage_comp.dw_treeview.Y) //BugA090501 - alfee 09.15.2011

//Start Code Change ---04.06.2016 #V15 maha
tab_1.tabpage_acknow.dw_acknow.width = tab_1.tabpage_acknow.width - 16
tab_1.tabpage_acknow.dw_acknow.height = tab_1.tabpage_acknow.height - 120 - 10
//End Code Change ---04.06.2016

tab_1.tabpage_report.dw_print.Width = tab_1.Width - tab_1.tabpage_report.dw_print.x - 80
tab_1.tabpage_report.dw_print.Height = tab_1.Height - 370
end event

event pfc_postopen;call super::pfc_postopen;of_set_security()//Added by Appeon long.zhang 11.28.2013 (BugL112101 )
end event

event pfc_save;call super::pfc_save; gb_priv_lookup_update = false   //Start Code Change ----04.27.2017 #V153 maha
 
 return 1
end event

type cb_data_source from commandbutton within w_privilege_painter
integer x = 2025
integer y = 24
integer width = 343
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Data Source"
end type

event clicked;long ll_area
 //Start Code Change ----10.01.2015 #V15 maha
integer res
long li_alt, ll_fac_id
string ls_file_name

res = messagebox("Privilege Data Source", "This will produce a data source file that can be used with a Word Merge Document.  Continue?",question!,yesno!,1)

if res = 2 then return

if tab_1.tabpage_comp.dw_clin.getrow() < 1 then 
	messagebox("Privilege Data Source","Please select a clinical area.")
	return
end if

select count(facility_id)  into :li_alt from facility where priv_template = :il_facility;
if li_alt = 1 then
	select facility_id into :il_facility_report from facility where priv_template = :il_facility;
elseif li_alt > 1 then
	openwithparm(w_priv_facility_select,il_facility)
	if message.doubleparm = 0 then
		return 
	else
		il_facility_report = message.doubleparm
	end if
else
	messagebox("","This template is not connected to any Facility.")
	return
end if

ll_fac_id = il_facility_report

ll_area = tab_1.tabpage_comp.dw_clin.getitemnumber(tab_1.tabpage_comp.dw_clin.getrow(),"clinical_area_id")

ls_file_name = of_priv_data_source_800(ll_area, ll_fac_id, 0)   //Start Code Change ----02.22.2017 #V153 maha - corrected function call
//ls_file_name = of_priv_data_source_variable (ll_area, ll_fac_id, 0)   //Start Code Change ----05.02.2017 #V153 maha - changed function call
is_word_ds_file = ls_file_name

if fileexists(ls_file_name) then
	messagebox("Privilege Data Source","The file is at: " + ls_file_name)
end if
end event

type mle_text from multilineedit within w_privilege_painter
boolean visible = false
integer x = 1271
integer y = 140
integer width = 411
integer height = 324
integer taborder = 80
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_temp from statictext within w_privilege_painter
integer x = 32
integer y = 44
integer width = 489
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select Template:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_addtemp from commandbutton within w_privilege_painter
integer x = 1504
integer y = 24
integer width = 507
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Template Options"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 01.27.2011
//////////////////////////////////////////////////////////////////////

m_priv_options lm_options

lm_options = Create m_priv_options
//lm_options.PopMenu(w_mdi.PointerX(), w_mdi.PointerY())//(Appeon)Toney 11.20.2013 - V141 ISG-CLX,Fix history BugT082901
gnv_app.of_popmenu(this,lm_options)//(Appeon)Toney 11.20.2013 - V141 ISG-CLX,Fix history BugT082901
Destroy lm_options
end event

type p_2 from picture within w_privilege_painter
boolean visible = false
integer x = 1870
integer y = 112
integer width = 73
integer height = 64
boolean originalsize = true
string picturename = "Next!"
boolean focusrectangle = false
end type

type cb_delete from commandbutton within w_privilege_painter
integer x = 3186
integer y = 24
integer width = 311
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 01.27.2011
//////////////////////////////////////////////////////////////////////

integer li_ans, li_error
long ll_cnt, ll_id
string ls_parm

if idw_Current.GetRow() < 1 then Return -1

// Delete connected pd_priv_list records
choose case idw_Current.ClassName()
	case "dw_clin"
		ll_id = idw_Current.getitemnumber(idw_Current.getrow(),"clinical_area_id")
		select count(rec_id) into :ll_cnt from pd_priv_list where clinical_area_id = :ll_id;
		if ll_cnt > 0 then
			ls_parm = "C" + string(ll_id)
			openwithparm(w_priv_delete_message,ls_parm)
			return 0
		end if
	case "dw_core"
		ll_id = tab_1.tabpage_comp.dw_core.getitemnumber(tab_1.tabpage_comp.dw_core.getrow(),"priv_core_id")
		select count(rec_id) into :ll_cnt from pd_priv_list where priv_core_id = :ll_id;
		if ll_cnt > 0 then
			ls_parm = "S" + string(ll_id)
			openwithparm(w_priv_delete_message,ls_parm)
			return 0
		end if
	case "dw_procd"
		ll_id = tab_1.tabpage_comp.dw_procd.getitemnumber(tab_1.tabpage_comp.dw_procd.getrow(),"procd_id")
		select count(rec_id) into :ll_cnt from pd_priv_list where procd_id = :ll_id;
		if ll_cnt > 0 then
			ls_parm = "P" + string(ll_id)
			openwithparm(w_priv_delete_message,ls_parm)
			return 0
		end if			
end choose

// Delete connected detail records
choose case idw_Current.ClassName()
	case "dw_clin"
		if tab_1.tabpage_comp.dw_core.rowcount() > 0 then
			li_ans = Messagebox("Delete Clinical Department","There are Sections and/or Procedures connected to this Clinical Area.  Are you sure you wish to delete all Sections and Procedures connected to this Clinical Area", Question!, YesNo!, 2)
			if li_ans = 2 then return 0
		end if
		li_ans = MessageBox("Delete", "Are you sure?", Question!, YesNo!, 2)
		if li_ans = 2 then return 0
		gnv_appeondb.of_StartQueue()
		delete priv_core_procd where priv_core_id in (select distinct priv_core_id from priv_core where clinical_area_id = :ll_id);
		delete from priv_core where clinical_area_id = :ll_id;
		delete from priv_ca_form where clinical_area_id = :ll_id;
		gnv_appeondb.of_CommitQueue()
		tab_1.tabpage_comp.dw_procd.reset()
		tab_1.tabpage_comp.dw_core.reset()
	case "dw_core"
		if tab_1.tabpage_comp.dw_procd.rowcount() > 0 then
			li_ans = Messagebox("Delete Privilege Section","There are Procedures connected to this Section.  Are you sure you wish to delete all Procedures connected to this section", Question!, YesNo!, 2)
			if li_ans = 2 then return 0
		end if
		li_ans = MessageBox("Delete", "Are you sure?", Question!, YesNo!, 2)
		if li_ans = 2 then return 0
		delete from priv_core_procd where priv_core_id = :ll_id;
		tab_1.tabpage_comp.dw_procd.reset()
	case "dw_procd"
		li_ans = Messagebox("Delete Procedure","Are you sure you wish to delete this Procedure?", Question!, YesNo!, 2) //Start Code Change ----07.15.2010 #V102 maha - corrected message
		if li_ans = 2 then return 0
		li_ans = MessageBox("Delete", "Are you positive?", Question!, YesNo!, 2)
		if li_ans = 2 then return 0
end choose

// Delete current row
tab_1.tabpage_comp.tag = "deleting..."
idw_Current.DeleteRow(idw_Current.GetRow())
idw_Current.TriggerEvent(RowFocusChanged!)
tab_1.tabpage_comp.tag = ""
tab_1.tabpage_comp.dw_procd.Event ue_OptoutVisible()

// Save data and refresh tree view
tab_1.tabpage_comp.Event ue_Save()

Return 1
end event

type cb_add from commandbutton within w_privilege_painter
integer x = 2875
integer y = 24
integer width = 311
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 04.19.2011
//////////////////////////////////////////////////////////////////////

long i, ll_Row
long ll_clin_id
long ll_core_id
datastore lds_proc_lookup

if IsNull(dw_template.object.template_id[1]) then
	MessageBox("Prompt", "Before you can add a Clinical Department, you must first select a Template.")
	dw_template.SetFocus()
	Return -1
end if
if tab_1.tabpage_comp.Event ue_Save() = -1 then Return -1

// Select procedures
lds_proc_lookup = Create datastore
//---------Begin Modified by (Appeon)Stephen 04.22.2014 for Bug #4008, Cosmetic typo in three prompts --------
//lds_proc_lookup.DataObject = " (Add " + idw_Current.Title + ")"
lds_proc_lookup.DataObject = "(Add " + idw_Current.Title + ")"
//---------End Modfiied ------------------------------------------------------
OpenWithParm(w_priv_procedure_select, lds_proc_lookup)
if Message.StringParm = "Cancel!" then
	destroy lds_proc_lookup
	Return -1
end if

// Add procedures
tab_1.tabpage_comp.tag = "adding..."
tab_1.tabpage_comp.SetRedraw(false)
choose case idw_Current.ClassName()
	case "dw_clin"		
		tab_1.tabpage_comp.dw_clin.Event ue_InsertSelectRow(lds_proc_lookup)
	case "dw_core"
		if tab_1.tabpage_comp.dw_clin.RowCount() < 1 then
			tab_1.tabpage_comp.dw_clin.Event ue_InsertSelectRow(lds_proc_lookup)
		else
			tab_1.tabpage_comp.dw_core.Event ue_InsertSelectRow(lds_proc_lookup)			
		end if
	case "dw_procd"
		if tab_1.tabpage_comp.dw_clin.RowCount() < 1 then
			tab_1.tabpage_comp.dw_clin.Event ue_InsertSelectRow(lds_proc_lookup)
		elseif tab_1.tabpage_comp.dw_core.RowCount() < 1 then
			tab_1.tabpage_comp.dw_core.Event ue_InsertSelectRow(lds_proc_lookup)
		else
			tab_1.tabpage_comp.dw_procd.Event ue_InsertSelectRow(lds_proc_lookup)
		end if
end choose
tab_1.tabpage_comp.SetRedraw(true)
tab_1.tabpage_comp.tag = ""

Destroy lds_proc_lookup
tab_1.tabpage_comp.dw_procd.Event ue_OptoutVisible()
Parent.Event pfc_Save()
commit using sqlca; //Added by (Appeon)Stephen 04.18.2014  - Bug 3999 : Missing departments when updating the privileges.--------

Return 1
end event

type p_1 from picture within w_privilege_painter
boolean visible = false
integer x = 2418
integer y = 40
integer width = 82
integer height = 64
boolean originalsize = true
string picturename = "arrowhead.png"
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_privilege_painter
integer x = 3831
integer y = 24
integer width = 311
integer height = 92
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;close(parent)
end event

type cb_expand from commandbutton within w_privilege_painter
boolean visible = false
integer x = 832
integer y = 2200
integer width = 247
integer height = 80
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Expand"
end type

event clicked;
string ls_col

if tab_1.tabpage_req.dw_clin_req2.getrow() < 1 then
	return
end if
//change button face
if this.text = "Normal" then
	this.text = "Expand"	
	return
end if

if this.text = "Expand" then
	this.text = "Normal"

	

if il_clicked_column = 2 then
//*store current settings
il_width = long(tab_1.tabpage_req.dw_clin_req.object.priv_qualifications.width) 
il_height = long(tab_1.tabpage_req.dw_clin_req.object.priv_qualifications.height)
il_x = long(tab_1.tabpage_req.dw_clin_req.object.priv_qualifications.x)
il_y = long(tab_1.tabpage_req.dw_clin_req.object.priv_qualifications.y)
//*increase column size
tab_1.tabpage_req.dw_clin_req.object.priv_qualifications.width = 4000
tab_1.tabpage_req.dw_clin_req.object.priv_qualifications.height = 2000
tab_1.tabpage_req.dw_clin_req.object.priv_qualifications.x = 18
tab_1.tabpage_req.dw_clin_req.object.priv_qualifications.y = 84
tab_1.tabpage_req.dw_clin_req.object.priv_qualifications.bringtofront = true
//*if tab1.tabpage_req.dw_clin_req has focus then
ls_col = tab_1.tabpage_req.dw_clin_req.getcolumnname()
//messagebox("",il_width)
//messagebox("",il_height)
//messagebox("",il_x )
//messagebox("",il_y)
end if
//tab_1.tabpage_req.dw_clin_req.object.ls_col.width = 540
//tab_1.tabpage_req.dw_clin_req.object.getcolumnname().height = 1884
//tab_1.tabpage_req.dw_clin_req.object.getcolumnname().x = 14
//tab_1.tabpage_req.dw_clin_req.object.getcolumnname().y = 164
	//dw_control.GetColumn ( )
	//dw_control.Object.objectname.Width
	//dw_control.GetColumnName ( )
	
	
end if	
	return
	
	

	
	
end event

type dw_template from datawindow within w_privilege_painter
integer x = 535
integer y = 32
integer width = 955
integer height = 72
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_ddlb_priv_template"
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
// Add by Appeon: Evan 01.20.2011
//////////////////////////////////////////////////////////////////////

long i, ll_currentrow
integer res
DataWindowChild dwchild1, dwchild2

il_facility = Long(data)
//Start Code Change ----01.08.2014 #V14 maha - rebuild code slightly to correct clin dept dddw issue
// Retrieve clinical area
tab_1.tabpage_comp.dw_procd.reset()
tab_1.tabpage_comp.dw_core.reset()
tab_1.tabpage_comp.dw_clin.reset()
tab_1.tabpage_comp.dw_treeview.reset()
tab_1.tabpage_req.dw_clin_req.reset()
tab_1.tabpage_req.dw_clin_req2.reset()
tab_1.tabpage_req.dw_clin_req3.reset()

tab_1.tabpage_comp.dw_treeview.Retrieve(il_facility)
tab_1.tabpage_comp.dw_clin.Retrieve(il_facility)

// Retrieve clin area select drop downs
gnv_appeondb.of_startqueue()
if tab_1.tabpage_comp.dw_clin.RowCount() > 0 then
	dw_select_dept.InsertRow(1)
	res = dw_select_dept.GetChild("clinical_area_id", dwchild1)
	dwchild1.SetTransObject(SQLCA)
	res = dwchild1.Retrieve(il_facility)
	if dwchild1.rowcount() = 0 then dwchild1.InsertRow(1)

//	tab_1.tabpage_req.dw_clin_select.InsertRow(1)
//	tab_1.tabpage_req.dw_clin_select.GetChild("clinical_area_id", dwchild2)
//	dwchild2.SetTransObject(SQLCA)
//	dwchild2.Retrieve(il_facility)
else
//	tab_1.tabpage_req.dw_clin_select.reset()
//	tab_1.tabpage_report.dw_clin_select_preview.reset()
	dw_select_dept.reset()
end if
tab_1.tabpage_acknow.dw_acknow.SetTransObject(SQLCA)
tab_1.tabpage_acknow.dw_acknow.Retrieve(il_facility)

dw_tempprop.retrieve(il_facility)
gnv_appeondb.of_commitqueue()

// Reset state of controls
if tab_1.SelectedTab = 1 then
	cb_add.enabled = true
	cb_delete.enabled = true
else
	cb_add.enabled = false
	cb_delete.enabled = false
end if
tab_1.tabpage_comp.enabled = true
tab_1.tabpage_acknow.enabled = true
tab_1.tabpage_report.enabled = true
tab_1.tabpage_req.enabled = true
tab_1.tabpage_comp.dw_clin.setfocus()
//tab_1.tabpage_req.dw_clin_req.reset()
//tab_1.tabpage_req.dw_clin_req2.reset()
//tab_1.tabpage_req.dw_clin_req3.reset()
//End Code Change ----01.08.2014
end event

event constructor;//////////////////////////////////////////////////////////////////////
// $<event> constructor
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 01.20.2011
//////////////////////////////////////////////////////////////////////

this.SetTransObject(SQLCA)
this.InsertRow(1)
end event

type cb_1 from commandbutton within w_privilege_painter
integer x = 3497
integer y = 24
integer width = 311
integer height = 92
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Help"
end type

event clicked;string ls_mes

ls_mes = "To create privileges, start by selecting the template to which they will be connected.  To create a new template, click the Template Options button~r~r"
ls_mes += "Privilege delineations are set up in three levels: first the Clinical area or Department, then Sections, and finally specific Procedures and Classifications.~r~r"
ls_mes += "Click the Add button under the appropriate section of the screen to add to that delineation.  When selecting at the Clinical area level, all three levels will be added;"
ls_mes += " when selecting from the Section level section and procedures will be added; when adding fro the procedure level, the selected procedure(s) will be added under the currently selected Section.~r~r"
ls_mes += "You can delete, but only if there are no dependent sections at a lower level.~r~r"
ls_mes += "To copy a clinical area and all its sections and procedures to another template, click the Template Options button, and select Copy Clinical Area Privilege to another Template.~r~r" //bug 2693 - alfee 09.30.2011
ls_mes += "To copy all privileges to another template, click the Template Options button, and select Copy All Privileges from one Template to Another.~r~r" //bug 2693 - alfee 09.30.2011
//ls_mes += "To copy a clinical area and all its sections and procedures to another template by clicking the Template Options button, and selecting Copy Clinical Area Privilege to another Template.~r~r"
//ls_mes += "To copy a clinical area and all its sections and procedures to another template by clicking the Template Options button, and selecting Copy All Privileges from one Template to  Another.~r~r"

messagebox("Privilege help",ls_mes)
end event

type dw_tempprop from datawindow within w_privilege_painter
boolean visible = false
integer x = 1358
integer y = 20
integer width = 128
integer height = 100
integer taborder = 80
string title = "none"
string dataobject = "d_priv_temp_prop"
boolean border = false
boolean livescroll = true
end type

event constructor;THIS.SETTRANSOBJECT(SQLCA)
end event

type cb_save from commandbutton within w_privilege_painter
integer x = 2555
integer y = 24
integer width = 311
integer height = 92
integer taborder = 70
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
// Add by Appeon: Evan 01.27.2011
//////////////////////////////////////////////////////////////////////

tab_1.tabpage_comp.Event ue_Save()
Parent.Event pfc_Save()
commit using sqlca; //Added by (Appeon)Stephen 04.18.2014  - Bug 3999 : Missing departments when updating the privileges.--------

end event

type dw_audit from datawindow within w_privilege_painter
boolean visible = false
integer x = 3922
integer y = 20
integer width = 101
integer height = 164
integer taborder = 130
string title = "none"
string dataobject = "d_priv_painter_audit"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event constructor;this.settransobject(sqlca)
end event

event updateend;this.reset()
end event

type tab_1 from tab within w_privilege_painter
event create ( )
event destroy ( )
integer y = 128
integer width = 4224
integer height = 2204
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean fixedwidth = true
boolean raggedright = true
alignment alignment = center!
integer selectedtab = 1
tabpage_comp tabpage_comp
tabpage_req tabpage_req
tabpage_acknow tabpage_acknow
tabpage_report tabpage_report
end type

on tab_1.create
this.tabpage_comp=create tabpage_comp
this.tabpage_req=create tabpage_req
this.tabpage_acknow=create tabpage_acknow
this.tabpage_report=create tabpage_report
this.Control[]={this.tabpage_comp,&
this.tabpage_req,&
this.tabpage_acknow,&
this.tabpage_report}
end on

on tab_1.destroy
destroy(this.tabpage_comp)
destroy(this.tabpage_req)
destroy(this.tabpage_acknow)
destroy(this.tabpage_report)
end on

event selectionchanged;long ll_facility_id
	
	
//cb_save.triggerevent(clicked!)
//IF oldindex = 1 THEN
//tab_1.tabpage_req.dw_clin_select.reset()
//ll_facility_id = dw_facility.getitemnumber(dw_facility.getrow(),"facility_id")
//tab_1.tabpage_req.dw_clin_select.settransobject(sqlca)
//tab_1.tabpage_req.dw_clin_select.retrieve(ll_facility_id)
//end if
//
//Start Code Change ----10.06.2009 #V10 maha
if newindex = 1 then
	cb_add.enabled = true
	cb_delete.enabled = true
else
	cb_add.enabled = false
	cb_delete.enabled = false
end if
//End Code Change---10.06.2009

choose case newindex
	case 2,4
		dw_select_dept.visible = true		
	case else
		dw_select_dept.visible = false	
end choose

end event

type tabpage_comp from userobject within tab_1
event create ( )
event destroy ( )
event type integer ue_save ( )
event type boolean ue_isdatachanged ( )
integer x = 18
integer y = 100
integer width = 4187
integer height = 2088
long backcolor = 33551856
string text = "Clinical Area/Departments"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
st_proc st_proc
st_sect st_sect
st_area st_area
dw_treeview dw_treeview
dw_clin dw_clin
dw_procd dw_procd
dw_core dw_core
dw_copy dw_copy
end type

on tabpage_comp.create
this.st_proc=create st_proc
this.st_sect=create st_sect
this.st_area=create st_area
this.dw_treeview=create dw_treeview
this.dw_clin=create dw_clin
this.dw_procd=create dw_procd
this.dw_core=create dw_core
this.dw_copy=create dw_copy
this.Control[]={this.st_proc,&
this.st_sect,&
this.st_area,&
this.dw_treeview,&
this.dw_clin,&
this.dw_procd,&
this.dw_core,&
this.dw_copy}
end on

on tabpage_comp.destroy
destroy(this.st_proc)
destroy(this.st_sect)
destroy(this.st_area)
destroy(this.dw_treeview)
destroy(this.dw_clin)
destroy(this.dw_procd)
destroy(this.dw_core)
destroy(this.dw_copy)
end on

event type integer ue_save();//////////////////////////////////////////////////////////////////////
// $<event> ue_save
// $<arguments>
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 01.26.2011
//////////////////////////////////////////////////////////////////////

if this.Event ue_IsDataChanged() = false then Return 1

// Save data
if dw_clin.Event ue_Save() = -1 then Return -1
if dw_core.Event ue_Save() = -1 then Return -1
if dw_procd.Event ue_Save() = -1 then Return -1
dw_audit.Reset()

// Refresh tree view
this.Tag = "saving..."
dw_treeview.SetRedraw(false)
dw_treeview.Retrieve(il_facility)
dw_treeview.Event ue_Locate()
dw_treeview.SetRedraw(true)
this.Tag = ""

Return 1
end event

event type boolean ue_isdatachanged();//////////////////////////////////////////////////////////////////////
// $<event> ue_isdatachanged
// $<arguments>
// $<returns> boolean
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 01.26.2011
//////////////////////////////////////////////////////////////////////

dw_clin.AcceptText()
dw_core.AcceptText()
dw_procd.AcceptText()

if dw_clin.ModifiedCount() + dw_clin.DeletedCount() > 0 then Return true
if dw_core.ModifiedCount() + dw_core.DeletedCount() > 0 then Return true
if dw_procd.ModifiedCount() + dw_procd.DeletedCount() > 0 then Return true

Return false
end event

type st_proc from statictext within tabpage_comp
integer x = 1371
integer y = 1168
integer width = 2789
integer height = 88
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = " Procedures and Designations"
boolean border = true
boolean focusrectangle = false
end type

type st_sect from statictext within tabpage_comp
integer x = 1371
integer y = 640
integer width = 2789
integer height = 88
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = " Section"
boolean border = true
boolean focusrectangle = false
end type

type st_area from statictext within tabpage_comp
integer x = 1371
integer width = 2789
integer height = 88
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = " Clinical Area / Department"
boolean border = true
boolean focusrectangle = false
end type

type dw_treeview from u_dw within tabpage_comp
event ue_rightclick ( string as_parm,  long al_row,  long al_level )
event type integer ue_locate ( )
string tag = "flag"
integer width = 1367
integer height = 2088
integer taborder = 70
string dragicon = "droparrow.ico"
boolean titlebar = true
string title = "Template Privileges"
string dataobject = "d_priv_template_treeview"
boolean hscrollbar = true
end type

event ue_rightclick(string as_parm, long al_row, long al_level);//Evan 01.24.2011

CHOOSE CASE Lower(as_parm)
	CASE 'expand'
		if al_row > 0 and al_level > 0 then this.expandallchildren(al_row, al_level)
	CASE 'expand all'
		this.expandall()
	CASE 'collapse'
		if al_row > 0 and al_level > 0 then this.collapseallchildren(al_row, al_level)
	CASE 'collapse all'
		this.collapseall()
END CHOOSE
end event

event type integer ue_locate();//////////////////////////////////////////////////////////////////////
// $<event> ue_locate
// $<arguments>
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 01.25.2011
//////////////////////////////////////////////////////////////////////

long ll_FindRow
long ll_clinical_area_id
long ll_priv_core_id
long ll_procd_id

Parent.Tag = "treelocating..."

if dw_clin.GetRow() > 0 then
	ll_clinical_area_id = dw_clin.GetItemNumber(dw_clin.GetRow(), "clinical_area_id")
	if IsNull(ll_clinical_area_id) then ll_clinical_area_id = 0
end if
if dw_core.GetRow() > 0 then
	ll_priv_core_id = dw_core.GetItemNumber(dw_core.GetRow(), "priv_core_id")
	if IsNull(ll_priv_core_id) then ll_priv_core_id = 0
end if
if dw_procd.GetRow() > 0 then
	ll_procd_id = dw_procd.GetItemNumber(dw_procd.GetRow(), "procd_id")
	if IsNull(ll_procd_id) then ll_procd_id = 0
end if

ll_FindRow = this.Find("priv_clinical_area_clinical_area_id=" + String(ll_clinical_area_id), 1 , this.RowCount())	
if ll_FindRow > 0 then
	this.Expand(ll_FindRow, 1)
	if idw_current.ClassName() = "dw_clin" then
		this.ScrollToRow(ll_FindRow)
		this.SelectTreeNode(ll_FindRow, 1, true)
		Parent.Tag = ""
		Return 1
	end if
end if

ll_FindRow = this.Find("priv_core_priv_core_id=" + String(ll_priv_core_id), 1 , this.RowCount())
if ll_FindRow > 0 then
	this.Expand(ll_FindRow, 2)
	if idw_current.ClassName() = "dw_core" then
		this.ScrollToRow(ll_FindRow)
		this.SelectTreeNode(ll_FindRow, 2, true)
		Parent.Tag = ""
		Return 2
	end if
end if

ll_FindRow = this.Find("priv_core_procd_procd_id=" + String(ll_procd_id), 1 , this.RowCount())
if ll_FindRow > 0 then
	this.Expand(ll_FindRow, 3)
	if idw_current.ClassName() = "dw_procd" then
		this.ScrollToRow(ll_FindRow)
		this.SelectTreeNode(ll_FindRow, 3, true)
		Parent.Tag = ""
		Return 3
	end if
end if

Parent.Tag = ""

Return 0
end event

event constructor;call super::constructor;this.SetTransObject(SQLCA)
end event

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
//		integer	xpos
//		integer	ypos
//		long		row
//		dwobject	dwo
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 01.24.2011
//////////////////////////////////////////////////////////////////////

string  ls_dw_band
str_dw_band lstr_band

ls_dw_band = this.GetBandAtPointer()
lstr_band = of_parse_bandinfo(ls_dw_band)

choose case lstr_band.band 
	case "tree.level.1"
		if this.IsExpanded(lstr_band.row, 1) then
			this.Collapse(lstr_band.row, 1)
		else
			this.Expand(lstr_band.row, 1)
		end if
	case "tree.level.2"
		if this.IsExpanded(lstr_band.row, 2) then
			this.Collapse(lstr_band.row, 2)
		else
			this.Expand(lstr_band.row, 2)
		end if	
	case else
		Drag(begin!)
end choose
end event

event rbuttondown;call super::rbuttondown;//////////////////////////////////////////////////////////////////////
// $<event> rbuttondown
// $<arguments>
//		integer	xpos
//		integer	ypos
//		long		row
//		dwobject	dwo
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 01.24.2011
//////////////////////////////////////////////////////////////////////

long ll_grouplevel, ll_row
string  ls_dw_band
str_dw_band lstr_band
m_popup_tv lm_tv

ls_dw_band = this.GetBandAtPointer()
lstr_band = of_parse_bandinfo (ls_dw_band)
choose case lstr_band.band
	case "tree.level.1"
		ll_grouplevel = 1
	case "tree.level.2"
		ll_grouplevel = 2
	case "detail"
		ll_grouplevel = 3
end choose
ll_row = lstr_band.row

if ll_grouplevel > 0 and ll_row > 0 then
	//locate current row
	this.setrow(ll_row)
	this.scrolltorow(ll_row)
	this.selecttreenode(ll_row, ll_grouplevel, true)

	//Popup menu	
	if ll_grouplevel = 1 or ll_grouplevel = 2 then
		lm_tv = Create m_popup_tv
		lm_tv.of_set_parent(this, ll_row, ll_grouplevel)
		if this.isexpanded(ll_row, ll_grouplevel) then
			lm_tv.m_expand.enabled = false
			lm_tv.m_collapse.enabled = true			
		else
			lm_tv.m_expand.enabled = true
			lm_tv.m_collapse.enabled = false
		end if	
		lm_tv.m_expandall.enabled = true	
		lm_tv.m_collapseall.enabled = true
		lm_tv.PopMenu(w_mdi.PointerX(), w_mdi.PointerY())
		Destroy lm_tv
	end if
end if
end event

event treenodeselected;call super::treenodeselected;//////////////////////////////////////////////////////////////////////
// $<event> treenodeselected
// $<arguments>
//		long	row
//		long	grouplevel
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 01.24.2011
//////////////////////////////////////////////////////////////////////

long ll_FindRow
long ll_clinical_area_id
long ll_priv_core_id
long ll_procd_id

if this.RowCount() > 0 then
	il_TvCurrentRow = Row
	il_TvGroupLevel = GroupLevel
else
	il_TvCurrentRow = 0
	il_TvGroupLevel = 0
	Return
end if

if Parent.Tag <> "adding..." and Parent.Tag <> "deleting..." and &
	Parent.Tag <> "saving..." and Parent.Tag <> "treelocating..." then
	// Set focus to dw
	choose case GroupLevel
		case 1
			of_set_dw_focus("DEPT")
		case 2
			of_set_dw_focus("SECT")
		case 3
			of_set_dw_focus("PROCD")
	end choose
	
	// Locate connected records of dws
	Parent.Tag = "dwlocating..."
	ll_clinical_area_id = this.GetItemNumber(Row, "priv_clinical_area_clinical_area_id")
	ll_priv_core_id = this.GetItemNumber(Row, "priv_core_priv_core_id")
	ll_procd_id = this.GetItemNumber(Row, "priv_core_procd_procd_id")
	
	//------------------- APPEON BEGIN -------------------
	//$<add> Stephen 04.06.2011
	//$<reason> fixed a web bug
	if isnull(ll_clinical_area_id)  then ll_clinical_area_id = 0
	if isnull(ll_priv_core_id)  then ll_priv_core_id = 0
	if isnull(ll_procd_id)  then ll_procd_id = 0
	//------------------- APPEON END ---------------------
	
	ll_FindRow = dw_clin.Find("clinical_area_id=" + String(ll_clinical_area_id), 1 , dw_clin.RowCount())
	if dw_clin.GetRow() <> ll_FindRow then dw_clin.ScrollToRow(ll_FindRow)
	ll_FindRow = dw_core.Find("priv_core_id=" + String(ll_priv_core_id), 1 , dw_core.RowCount())
	if dw_core.GetRow() <> ll_FindRow then dw_core.ScrollToRow(ll_FindRow)
	ll_FindRow = dw_procd.Find("procd_id=" + String(ll_procd_id), 1 , dw_procd.RowCount())
	if dw_procd.GetRow() <> ll_FindRow then dw_procd.ScrollToRow(ll_FindRow)
	Parent.Tag = ""
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

type dw_clin from u_dw within tabpage_comp
event type integer ue_save ( )
event type long ue_insertselectrow ( datastore ads_proc_lookup )
string tag = "flag"
integer x = 1371
integer y = 92
integer width = 2789
integer height = 548
integer taborder = 10
boolean bringtotop = true
string title = "Department / Clinical Area"
string dataobject = "d_priv_clinical_area"
boolean hscrollbar = true
end type

event type integer ue_save();//////////////////////////////////////////////////////////////////////
// $<event> ue_save
// $<arguments>
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 01.26.2011
//////////////////////////////////////////////////////////////////////

long ll_clin_id
long ll_RowCount

// Do some checks
this.AcceptText()
if this.ModifiedCount() + this.DeletedCount() = 0 then Return 1
if this.Event pfc_Validation() = FAILURE then Return -1

// Set primary key
ll_RowCount = this.RowCount()
if ll_RowCount > 0 then
	if this.GetItemNumber(ll_RowCount, "clinical_area_id") = 0 then
		SELECT Max(priv_clinical_area.clinical_area_id)
		INTO :ll_clin_id
		FROM priv_clinical_area;
		if IsNull(ll_clin_id) then	ll_clin_id = 0
		ll_clin_id ++
		this.SetItem(ll_RowCount, "clinical_area_id", ll_clin_id)
	end if
	of_add_audit("", "DEPT", 1, this)
end if

// Save data
gnv_appeondb.of_StartQueue()
this.Update()
dw_audit.Update()
gnv_appeondb.of_CommitQueue()

commit using sqlca; //Added by (Appeon)Stephen 04.11.2014  - Bug 3999 : Missing departments when updating the privileges.--------

Return 1
end event

event type long ue_insertselectrow(datastore ads_proc_lookup);//////////////////////////////////////////////////////////////////////
// $<event> ue_insertselectrow
// $<arguments>
//		datastore	ads_proc_lookup
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 05.03.2011
//////////////////////////////////////////////////////////////////////

long ll_dept_id
long ll_procedure_pk
long ll_priv_core_id
long ll_clinical_area_id
long ll_clin_lookup
long ll_sect_lookup
long i, j, k, ll_Row
string ls_Code
string ls_Description
datastore lds_core
datastore lds_procd

lds_core = Create datastore
lds_procd = Create datastore
lds_core.DataObject = ads_proc_lookup.DataObject
lds_procd.DataObject = ads_proc_lookup.DataObject
ads_proc_lookup.RowsCopy(1, ads_proc_lookup.RowCount(), Primary!, lds_core, 1, Primary!)
ads_proc_lookup.RowsCopy(1, ads_proc_lookup.RowCount(), Primary!, lds_procd, 1, Primary!)

for i = 1 to ads_proc_lookup.RowCount()
	ll_clin_lookup = ads_proc_lookup.GetItemNumber(i, "clinical_area_id")
	ll_dept_id = ads_proc_lookup.GetItemNumber(i, "dept_id")
	// Add clinical areas
	ll_Row = dw_clin.Find("clin_lookup=" + String(ll_clin_lookup), 1, dw_clin.RowCount())
	if ll_Row < 1 then
		debugbreak()
		of_GetLookupValue(ads_proc_lookup, ll_clin_lookup, ls_Code, ls_Description, "CLIN")
		ll_Row = dw_clin.InsertRow(0)
		dw_clin.SetItem(ll_Row, "clinical_area_id", 0)
		dw_clin.SetItem(ll_Row, "facility_id", il_facility)
		dw_clin.SetItem(ll_Row, "clin_lookup", ll_clin_lookup)
		dw_clin.SetItem(ll_Row, "dept_id", ll_dept_id)
		dw_clin.SetItem(ll_Row, "priv_clinical_area_clinical_area_code", ls_Code)
		dw_clin.SetItem(ll_Row, "priv_clinical_area_clinical_area_descrip", ls_Description)
		if Parent.Event ue_Save() = -1 then Return -1		
	end if
	dw_clin.ScrollToRow(ll_Row)
	// Add sections
	lds_core.SetFilter("clinical_area_id = " + String(ll_clin_lookup))
	lds_core.Filter()
	for j = 1 to lds_core.RowCount()
		ll_sect_lookup = lds_core.GetItemNumber(j, "section_id")
		ll_Row = dw_core.Find("sect_lookup=" + String(ll_sect_lookup), 1, dw_core.RowCount())
		if ll_Row < 1 then
			ll_clinical_area_id = dw_clin.GetItemNumber(dw_clin.GetRow(), "clinical_area_id")
			of_GetLookupValue(ads_proc_lookup, ll_sect_lookup, ls_Code, ls_Description, "SECT")
			ll_Row = dw_core.InsertRow(0)
			dw_core.SetItem(ll_Row, "clinical_area_id", ll_clinical_area_id)
			dw_core.SetItem(ll_Row, "priv_core_id", 0)
			dw_core.SetItem(ll_Row, "sect_lookup", ll_sect_lookup)
			dw_core.SetItem(ll_Row, "priv_core_description", ls_Description)
			dw_core.SetItem(ll_Row, "sort_order", j)  //Start Code Change ----04.04.2013 #V12 maha
			if Parent.Event ue_Save() = -1 then Return -1
		end if
		dw_core.ScrollToRow(ll_Row)
		// Add procedures
		lds_procd.SetFilter("clinical_area_id = " + String(ll_clin_lookup) + " and section_id = " + String(ll_sect_lookup))
		lds_procd.Filter()
		for k = 1 to lds_procd.RowCount()
			ll_procedure_pk = lds_procd.GetItemNumber(k, "procedure_pk")
			ll_Row = dw_procd.Find("procd_lookup_id=" + String(ll_procedure_pk), 1, dw_procd.RowCount())
			if ll_Row < 1 then
				ll_priv_core_id = dw_core.GetItemNumber(dw_core.GetRow(), "priv_core_id")
				ll_Row = dw_procd.InsertRow(0)
				dw_procd.SetItem(ll_Row, "priv_core_id", ll_priv_core_id)
				dw_procd.SetItem(ll_Row, "procd_id", 0)
				dw_procd.SetItem(ll_Row, "procd_name", lds_procd.object.procd_name[k])
				dw_procd.SetItem(ll_Row, "procd_code", lds_procd.object.procd_code[k])
				dw_procd.SetItem(ll_Row, "num_req_for_reapp", lds_procd.object.num_req_for_reapp[k])
				dw_procd.SetItem(ll_Row, "active_status", lds_procd.object.active_status[k])
				dw_procd.SetItem(ll_Row, "clin_area_id", lds_procd.object.clinical_area_id[k])
				dw_procd.SetItem(ll_Row, "core_procd_description", lds_procd.object.procedure_description[k])
				dw_procd.SetItem(ll_Row, "procd_lookup_id", ll_procedure_pk)
				dw_procd.SetItem(ll_Row, "sort_order", k)  //Start Code Change ----04.04.2013 #V12 maha
				if Parent.Event ue_Save() = -1 then Return -1
				dw_procd.ScrollToRow(ll_Row)
			end if
		next
		lds_procd.RowsMove(1, lds_procd.RowCount(), Primary!, lds_procd, 1, Delete!)
	next
	lds_core.RowsMove(1, lds_core.RowCount(), Primary!, lds_core, 1, Delete!)
next

Destroy lds_core
Destroy lds_procd

Return 1
end event

event constructor;this.SetTransObject(SQLCA)
This.SetRowFocusIndicator( p_1 )

idw_current = this
of_SetUpdateable(false)

datawindowchild ldw_child
this.GetChild("dept_id", ldw_child)
ldw_child.SetTransObject(SQLCA)
ldw_child.Retrieve("Department")
ldw_child.InsertRow(1)


end event

event rowfocuschanged;call super::rowfocuschanged;//////////////////////////////////////////////////////////////////////
// $<event> rowfocuschanged
// $<arguments>
//		long	currentrow
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 01.26.2011
//////////////////////////////////////////////////////////////////////

long ll_clin_id
long ll_CurrentRow

dw_core.Reset()
dw_procd.Reset()
ll_CurrentRow = this.GetRow()

if ll_CurrentRow > 0 then
	ll_clin_id = this.GetItemNumber(ll_CurrentRow, "clinical_area_id")
	dw_core.Retrieve(ll_clin_id)
	of_set_clin_dept(ll_clin_id, 1)
end if

if idw_current.ClassName() = this.ClassName() then
	if Parent.Tag <> "adding..." and Parent.Tag <> "deleting..." then
		if Parent.Tag <> "dwlocating..." then dw_treeview.Event ue_Locate()
	end if
end if
end event

event getfocus;of_set_dw_focus( "DEPT")
if Parent.Tag <> "dwlocating..." then dw_treeview.Event ue_Locate()

Return 0
end event

event pfc_validation;/******************************************************************************************************************
**  [PUBLIC]   : pfc_valication
**==================================================================================================================
**  Purpose   	: perform validation
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 21 December 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

long ll_i
string ls_message


	for ll_i = 1 to this.rowcount()
	//------------------- APPEON BEGIN -------------------
	//$<delete> Evan 04.20.2011
	//$<reason> Not need to be checked.
	/*
  if not f_validstr(this.getitemString(ll_i,'priv_clinical_area_clinical_area_code')) then 
	ls_message = ls_message + 'The abbreviation is missing on row: ' + string(ll_i) + "~r~n"
  end if
  */
  //------------------- APPEON END ---------------------
  
   if not f_validstr(this.getitemString(ll_i,'priv_clinical_area_clinical_area_descrip')) then 
	ls_message = ls_message +  'The ' +upper('Clinical Area/Department Description')+  ' is missing on row: ' + string(ll_i) + "~r~n"
  end if

next


if LenA(ls_message) > 0 then 
	messagebox('Validation', ls_message )
	this.setfocus()
	return failure
else 
	return success
end if

end event

event buttonclicked;call super::buttonclicked;//////////////////////////////////////////////////////////////////////
// $<event> buttoncliced
// $<arguments>
//		long	row
//		long	actionreturncode
//		dwobject	dwo
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 03.29.2011
//////////////////////////////////////////////////////////////////////

m_priv_options lm_options
w_master lw_parent//Added by Appeon long.zhang 03.13.2017
		
this.SetRow(Row)
choose case dwo.name
	case "b_form0", "b_form1" // evan 06.17.2011
		lm_options = Create m_priv_options		
		lm_options.m_addtemp.visible = false
		lm_options.m_deltemp.visible = false
		lm_options.m_copy1.visible = false
		lm_options.m_copy2.visible = false
		lm_options.m_l1.visible = false
		lm_options.m_l2.visible = false
		lm_options.m_properties.visible = false
		lm_options.m_saveprivilegeform.visible = true
		lm_options.m_viewprivilegeform.visible = true
		lm_options.m_deleteprivilegeform.visible = true //Added by Appeon long.zhang 03.13.2017 (BugL022701)
		if this.getitemnumber(this.getrow(),"datalen") > 0 then
			lm_options.m_viewprivilegeform.enabled = true
			lm_options.m_deleteprivilegeform.enabled = true //Added by Appeon long.zhang 03.13.2017 (BugL022701)
		else
			lm_options.m_viewprivilegeform.enabled = false
			lm_options.m_deleteprivilegeform.enabled = False //Added by Appeon long.zhang 03.13.2017 (BugL022701)
		end if
		//------------------- APPEON BEGIN -------------------
		//<$>added:long.zhang 03.13.2017
		//<$>reason:Correct menu position, For BugL022701
		
		//lm_options.PopMenu(w_mdi.PointerX(), w_mdi.PointerY())
		gnv_app.of_popmenu(this,lm_options)
//		This.of_getparentwindow( lw_parent)
//		lm_options.PopMenu (lw_parent.PointerX() + 5, lw_parent.PointerY() + 10) 
		//------------------- APPEON END -------------------
		
		Destroy lm_options

	case "b_facil"
		//Start Code Change ---- 10.03.2006 #665 maha
		openwithparm(w_ccp_facility,this.getitemnumber(this.getrow(),"clinical_area_id"))
		//End Code Change---10.03.2006
end choose
end event

event other;call super::other;if Message.WordParm = 61458 then 
	Message.Processed = true
	Message.ReturnValue = 0	
end if

//if Message.Number = 522 then
//	Return 1
//end if
end event

event rowfocuschanging;call super::rowfocuschanging;//////////////////////////////////////////////////////////////////////
// $<event> rowfocuschanging
// $<arguments>
//		long	currentrow
//		long	newrow
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 01.26.2011
//////////////////////////////////////////////////////////////////////

// Do not change row number
if Parent.Tag <> "adding..." and Parent.Tag <> "deleting..." then
	if Parent.Event ue_Save() = -1 then Return 1
end if

// Allow to change row number
Return 0
end event

type dw_procd from u_dw within tabpage_comp
event type integer ue_save ( )
event ue_optoutvisible ( )
event type long ue_insertselectrow ( datastore ads_proc_lookup )
string tag = "flag"
integer x = 1371
integer y = 1260
integer width = 2789
integer height = 828
integer taborder = 80
string dragicon = "droparrow.ico"
boolean bringtotop = true
string title = "Procedures and Designations"
string dataobject = "d_priv_core_procd"
end type

event type integer ue_save();//////////////////////////////////////////////////////////////////////
// $<event> ue_save
// $<arguments>
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 01.26.2011
//////////////////////////////////////////////////////////////////////

long ll_procd_id
long ll_Row
long ll_RowCount

this.AcceptText()
if this.ModifiedCount() + this.DeletedCount() = 0 then Return 1
if this.Event pfc_Validation() = FAILURE then Return -1

ll_RowCount = this.RowCount()
if ll_RowCount > 0 then
	for ll_Row = 1 to ll_RowCount
		if this.GetItemNumber(ll_Row, "procd_id") = 0 then
			if ll_procd_id = 0 then
				SELECT Max(priv_core_procd.procd_id)
				INTO :ll_procd_id
				FROM priv_core_procd;
				if IsNull(ll_procd_id) then ll_procd_id = 0
			end if
			ll_procd_id ++
			this.SetItem(ll_Row, "procd_id", ll_procd_id)
		end if
	next
	of_add_audit("", "PROCD", 1, this)
end if

gnv_appeondb.of_StartQueue()
this.Update()
dw_audit.Update()
gnv_appeondb.of_CommitQueue()

Return 1
end event

event ue_optoutvisible();//////////////////////////////////////////////////////////////////////
// $<event> ue_OptoutVisible
// $<arguments>
// $<returns> (None)
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 01.24.2011
//////////////////////////////////////////////////////////////////////

long ll_Row

ll_Row = dw_core.GetRow()
if ll_Row < 1 then Return

if dw_core.object.core_section[ll_Row] = 1 then
	this.Modify("opt_out.visible=1")
else
	this.Modify("opt_out.visible=0")
end if
end event

event type long ue_insertselectrow(datastore ads_proc_lookup);//////////////////////////////////////////////////////////////////////
// $<event> ue_insertselectrow
// $<arguments>
//		datastore	ads_proc_lookup
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 05.03.2011
//////////////////////////////////////////////////////////////////////

long ll_dept_id
long ll_procedure_pk
long ll_priv_core_id
long ll_clinical_area_id
long ll_clin_lookup
long ll_sect_lookup
long i, j, k, ll_Row
string ls_Code
string ls_Description
datastore lds_core
datastore lds_procd

//lds_core = Create datastore
lds_procd = Create datastore
//lds_core.DataObject = ads_proc_lookup.DataObject
lds_procd.DataObject = ads_proc_lookup.DataObject
//ads_proc_lookup.RowsCopy(1, ads_proc_lookup.RowCount(), Primary!, lds_core, 1, Primary!)
ads_proc_lookup.RowsCopy(1, ads_proc_lookup.RowCount(), Primary!, lds_procd, 1, Primary!)

// Add procedures
for k = 1 to lds_procd.RowCount()
	ll_procedure_pk = lds_procd.GetItemNumber(k, "procedure_pk")
	ll_Row = dw_procd.Find("procd_lookup_id=" + String(ll_procedure_pk), 1, dw_procd.RowCount())
	if ll_Row < 1 then
		ll_priv_core_id = dw_core.GetItemNumber(dw_core.GetRow(), "priv_core_id")
		ll_Row = dw_procd.InsertRow(0)
		dw_procd.SetItem(ll_Row, "priv_core_id", ll_priv_core_id)
		dw_procd.SetItem(ll_Row, "procd_id", 0)
		dw_procd.SetItem(ll_Row, "procd_name", lds_procd.object.procd_name[k])
		dw_procd.SetItem(ll_Row, "procd_code", lds_procd.object.procd_code[k])
		dw_procd.SetItem(ll_Row, "num_req_for_reapp", lds_procd.object.num_req_for_reapp[k])
		dw_procd.SetItem(ll_Row, "active_status", lds_procd.object.active_status[k])
		dw_procd.SetItem(ll_Row, "clin_area_id", lds_procd.object.clinical_area_id[k])
		dw_procd.SetItem(ll_Row, "core_procd_description", lds_procd.object.procedure_description[k])
		dw_procd.SetItem(ll_Row, "procd_lookup_id", ll_procedure_pk)
		if Parent.Event ue_Save() = -1 then Return -1
		dw_procd.ScrollToRow(ll_Row)
	end if
next

//Destroy lds_core
Destroy lds_procd

Return 1
end event

event constructor;this.SetTransObject(SQLCA)
of_SetUpdateable(false)
end event

event getfocus;call super::getfocus;of_set_dw_focus( "PROCD")
if Parent.Tag <> "dwlocating..." then dw_treeview.Event ue_Locate()

return 0
end event

event doubleclicked;call super::doubleclicked;String s

IF row > 0  And dwo.Name = 'core_procd_description' THEN //Added by  Nova 05.27.2010
	OpenWithParm( w_expand_text, This.GetItemString( row, "core_procd_description" ))
	IF Message.StringParm = "Cancel" THEN
		RETURN -1
	ELSE
		s = Message.StringParm
		//	if len(s) > 255 then
		//		s = mid(s,1,255)
		//		messagebox("Notes","This Notes field is limited to 255 characters.")
		//	end if
		if ii_levell <> 1 then  //added by long.zhang 11.28.2013 readonly user access BugL112101 
			This.SetItem( row, "core_procd_description", s )
		end if	
	END IF
END IF


end event

event rowfocuschanged;call super::rowfocuschanged;//////////////////////////////////////////////////////////////////////
// $<event> rowfocuschanged
// $<arguments>
//		long	currentrow
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 01.26.2011
//////////////////////////////////////////////////////////////////////

if idw_current.ClassName() = this.ClassName() then
	if Parent.Tag <> "adding..." and Parent.Tag <> "deleting..." then
		if Parent.Tag <> "dwlocating..." then dw_treeview.Event ue_Locate()
	end if
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

event clicked;call super::clicked;if this.rowcount( ) < 1 then return 0

Drag(begin!)
end event

type dw_core from u_dw within tabpage_comp
event type integer ue_save ( )
event type long ue_insertselectrow ( datastore ads_proc_lookup )
string tag = "flag"
integer x = 1371
integer y = 732
integer width = 2789
integer height = 436
integer taborder = 50
boolean bringtotop = true
string title = "Privilege Section"
string dataobject = "d_priv_core"
end type

event type integer ue_save();//////////////////////////////////////////////////////////////////////
// $<event> ue_save
// $<arguments>
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 01.26.2011
//////////////////////////////////////////////////////////////////////

long ll_core_id
long ll_RowCount

// Do some checks
this.AcceptText()
if this.ModifiedCount() + this.DeletedCount() = 0 then Return 1
if this.Event pfc_Validation() = FAILURE then Return -1

// Set primary key
ll_RowCount = this.RowCount()
if ll_RowCount > 0 then
	if this.GetItemNumber(ll_RowCount, "priv_core_id") = 0 then
		SELECT Max(priv_core.priv_core_id)
		INTO :ll_core_id
		FROM priv_core;
		if IsNull(ll_core_id) then ll_core_id = 0
		ll_core_id ++
		this.SetItem(ll_RowCount, "priv_core_id", ll_core_id)
	end if
	of_add_audit("", "SECT", 1, this)
end if

// Save data
gnv_appeondb.of_StartQueue()
this.Update()
dw_audit.Update()
gnv_appeondb.of_CommitQueue()

Return 1
end event

event type long ue_insertselectrow(datastore ads_proc_lookup);//////////////////////////////////////////////////////////////////////
// $<event> ue_insertselectrow
// $<arguments>
//		datastore	ads_proc_lookup
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 05.03.2011
//////////////////////////////////////////////////////////////////////

long ll_dept_id
long ll_procedure_pk
long ll_priv_core_id
long ll_clinical_area_id
long ll_clin_lookup
long ll_sect_lookup
long i, j, k, ll_Row
string ls_Code
string ls_Description
datastore lds_core
datastore lds_procd

lds_core = Create datastore
lds_procd = Create datastore
lds_core.DataObject = ads_proc_lookup.DataObject
lds_procd.DataObject = ads_proc_lookup.DataObject
ads_proc_lookup.RowsCopy(1, ads_proc_lookup.RowCount(), Primary!, lds_core, 1, Primary!)
ads_proc_lookup.RowsCopy(1, ads_proc_lookup.RowCount(), Primary!, lds_procd, 1, Primary!)

// Add sections
for j = 1 to lds_core.RowCount()
	ll_sect_lookup = lds_core.GetItemNumber(j, "section_id")
	ll_Row = dw_core.Find("sect_lookup=" + String(ll_sect_lookup), 1, dw_core.RowCount())
	if ll_Row < 1 then
		ll_clinical_area_id = dw_clin.GetItemNumber(dw_clin.GetRow(), "clinical_area_id")
		of_GetLookupValue(ads_proc_lookup, ll_sect_lookup, ls_Code, ls_Description, "SECT")
		ll_Row = dw_core.InsertRow(0)
		dw_core.SetItem(ll_Row, "clinical_area_id", ll_clinical_area_id)
		dw_core.SetItem(ll_Row, "priv_core_id", 0)
		dw_core.SetItem(ll_Row, "sect_lookup", ll_sect_lookup)
		dw_core.SetItem(ll_Row, "priv_core_description", ls_Description)
		dw_core.SetItem(ll_Row, "sort_order", j)  //Start Code Change ----04.04.2013 #V12 maha
		if Parent.Event ue_Save() = -1 then Return -1
	end if
	dw_core.ScrollToRow(ll_Row)
	// Add procedures
	lds_procd.SetFilter("section_id = " + String(ll_sect_lookup))
	lds_procd.Filter()
	for k = 1 to lds_procd.RowCount()
		ll_procedure_pk = lds_procd.GetItemNumber(k, "procedure_pk")
		ll_Row = dw_procd.Find("procd_lookup_id=" + String(ll_procedure_pk), 1, dw_procd.RowCount())
		if ll_Row < 1 then
			ll_priv_core_id = dw_core.GetItemNumber(dw_core.GetRow(), "priv_core_id")
			ll_Row = dw_procd.InsertRow(0)
			dw_procd.SetItem(ll_Row, "priv_core_id", ll_priv_core_id)
			dw_procd.SetItem(ll_Row, "procd_id", 0)
			dw_procd.SetItem(ll_Row, "procd_name", lds_procd.object.procd_name[k])
			dw_procd.SetItem(ll_Row, "procd_code", lds_procd.object.procd_code[k])
			dw_procd.SetItem(ll_Row, "num_req_for_reapp", lds_procd.object.num_req_for_reapp[k])
			dw_procd.SetItem(ll_Row, "active_status", lds_procd.object.active_status[k])
			dw_procd.SetItem(ll_Row, "clin_area_id", lds_procd.object.clinical_area_id[k])
			dw_procd.SetItem(ll_Row, "core_procd_description", lds_procd.object.procedure_description[k])
			dw_procd.SetItem(ll_Row, "procd_lookup_id", ll_procedure_pk)
			dw_procd.SetItem(ll_Row, "sort_order", k)  //Start Code Change ----04.04.2013 #V12 maha
			if Parent.Event ue_Save() = -1 then Return -1
			dw_procd.ScrollToRow(ll_Row)
		end if
	next
	lds_procd.RowsMove(1, lds_procd.RowCount(), Primary!, lds_procd, 1, Delete!)
next

Destroy lds_core
Destroy lds_procd

Return 1
end event

event constructor;this.SetTransObject(SQLCA)
This.SetRowFocusIndicator( p_1 )
of_SetUpdateable(false)
end event

event rowfocuschanged;call super::rowfocuschanged;//////////////////////////////////////////////////////////////////////
// $<event> rowfocuschanged
// $<arguments>
//		long	currentrow
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 01.26.2011
//////////////////////////////////////////////////////////////////////

long ll_core_id
long ll_CurrentRow

dw_procd.Reset()
ll_CurrentRow = this.GetRow()

if ll_CurrentRow > 0 then
	ll_core_id = this.GetItemNumber(ll_CurrentRow, "priv_core_id")
	dw_procd.retrieve(ll_core_id)
end if

if idw_current.ClassName() = this.ClassName() then
	if Parent.Tag <> "adding..." and Parent.Tag <> "deleting..." then
		if Parent.Tag <> "dwlocating..." then dw_treeview.Event ue_Locate()
	end if
end if

dw_procd.Event ue_OptoutVisible()
end event

event getfocus;of_set_dw_focus( "SECT")
if Parent.Tag <> "dwlocating..." then dw_treeview.Event ue_Locate()

Return 0
end event

event other;call super::other;if Message.WordParm = 61458 then 
	Message.Processed = true
	Message.ReturnValue = 0	
end if

//if Message.Number = 522 then
//	Return 1
//end if
end event

event rowfocuschanging;call super::rowfocuschanging;//////////////////////////////////////////////////////////////////////
// $<event> rowfocuschanging
// $<arguments>
//		long	currentrow
//		long	newrow
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 01.26.2011
//////////////////////////////////////////////////////////////////////

// Do not change row number
if Parent.Tag <> "adding..." and Parent.Tag <> "deleting..." then
	if Parent.Event ue_Save() = -1 then Return 1
end if

// Allow to change row number
Return 0
end event

event pfc_validation;/******************************************************************************************************************
**  [PUBLIC]   : pfc_valication
**==================================================================================================================
**  Purpose   	: perform validation
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 21 December 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

long ll_i
string ls_message

for ll_i = 1 to this.rowcount()
  if not f_validstr(this.getitemString(ll_i,'priv_core_description')) then 
	ls_message = 'The section is missing on row: ' + string(ll_i)
  end if
next

if LenA(ls_message) > 0 then 
	messagebox('Validation', ls_message )
	this.setfocus()
	return failure
else 
	return success
end if

end event

event itemchanged;call super::itemchanged;if dwo.name = "core_section" then
	dw_procd.Post Event ue_OptoutVisible()
end if
end event

event dragdrop;call super::dragdrop;string ls_text
if ii_levell = 1 then return //added by long.zhang 11.28.2013 readonly access BugL112101 
of_change_section(row)
this.selectrow( 0,false)	//added by long.zhang 04.02.2013
end event

event dragwithin;call super::dragwithin;//$<add> 04.02.2013 By:long.zhang
//$<reason>high light the selected row 
if ii_levell = 1 then return //added by long.zhang 11.28.2013 readonly access BugL112101 
if row > 0 then
	this.selectrow( 0,false)
	this.selectrow( row,true)
end if
end event

type dw_copy from datawindow within tabpage_comp
boolean visible = false
integer x = 3653
integer y = 20
integer width = 114
integer height = 56
integer taborder = 40
string dataobject = "d_priv_core_procd_copy"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type tabpage_req from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 4187
integer height = 2088
long backcolor = 33551856
string text = "Requirements"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cb_sect_req cb_sect_req
gb_5 gb_5
dw_clin_req2 dw_clin_req2
dw_clin_req3 dw_clin_req3
cb_reqcopy cb_reqcopy
dw_copy1 dw_copy1
dw_copy3 dw_copy3
dw_copy2 dw_copy2
cb_copyclin cb_copyclin
dw_clin_req dw_clin_req
gb_7 gb_7
dw_clin_select dw_clin_select
end type

on tabpage_req.create
this.cb_sect_req=create cb_sect_req
this.gb_5=create gb_5
this.dw_clin_req2=create dw_clin_req2
this.dw_clin_req3=create dw_clin_req3
this.cb_reqcopy=create cb_reqcopy
this.dw_copy1=create dw_copy1
this.dw_copy3=create dw_copy3
this.dw_copy2=create dw_copy2
this.cb_copyclin=create cb_copyclin
this.dw_clin_req=create dw_clin_req
this.gb_7=create gb_7
this.dw_clin_select=create dw_clin_select
this.Control[]={this.cb_sect_req,&
this.gb_5,&
this.dw_clin_req2,&
this.dw_clin_req3,&
this.cb_reqcopy,&
this.dw_copy1,&
this.dw_copy3,&
this.dw_copy2,&
this.cb_copyclin,&
this.dw_clin_req,&
this.gb_7,&
this.dw_clin_select}
end on

on tabpage_req.destroy
destroy(this.cb_sect_req)
destroy(this.gb_5)
destroy(this.dw_clin_req2)
destroy(this.dw_clin_req3)
destroy(this.cb_reqcopy)
destroy(this.dw_copy1)
destroy(this.dw_copy3)
destroy(this.dw_copy2)
destroy(this.cb_copyclin)
destroy(this.dw_clin_req)
destroy(this.gb_7)
destroy(this.dw_clin_select)
end on

type cb_sect_req from commandbutton within tabpage_req
integer x = 3045
integer y = 68
integer width = 613
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Section Requirements"
end type

event clicked;openwithparm(w_section_requirements, il_clin_area_preview )
end event

type gb_5 from groupbox within tabpage_req
integer x = 5
integer y = 188
integer width = 4174
integer height = 1900
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "General Requirements"
end type

type dw_clin_req2 from u_dw within tabpage_req
integer x = 14
integer y = 940
integer width = 4128
integer height = 476
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_priv_clin_req2"
boolean vscrollbar = false
boolean border = false
end type

event clicked;call super::clicked;il_clicked_column = this.getclickedcolumn() 
//il_clicked_column = this.getclickedcolumn() + 10
//messagebox("col no",il_clicked_column)
end event

event losefocus;cb_save.triggerevent(clicked!)
end event

event getfocus;call super::getfocus;Return 0
end event

event doubleclicked;call super::doubleclicked;//Start Code Change ----10.06.2009 #V10 maha - added
string s
long ll_col

ll_col = il_clicked_column

OpenWithParm( w_expand_text, This.GetItemString( row, ll_col  ))

IF Message.StringParm = "Cancel" THEN
	Return -1
ELSE
	s = Message.StringParm
//	if len(s) > 255 then
//		s = mid(s,1,255)
//		messagebox("Notes","This Notes field is limited to 255 characters.")
//	end if
	This.SetItem( row ,  ll_col , s )
END IF
end event

type dw_clin_req3 from u_dw within tabpage_req
integer x = 14
integer y = 1404
integer width = 4128
integer height = 460
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_priv_clin_req3"
boolean vscrollbar = false
boolean border = false
end type

event clicked;call super::clicked;il_clicked_column = this.getclickedcolumn() 
//il_clicked_column = this.getclickedcolumn() + 20
//messagebox("col no",il_clicked_column)
end event

event losefocus;cb_save.triggerevent(clicked!)
end event

event getfocus;call super::getfocus;Return 0
end event

event doubleclicked;call super::doubleclicked;//Start Code Change ----10.06.2009 #V10 maha - added
string s
long ll_col

ll_col = il_clicked_column

OpenWithParm( w_expand_text, This.GetItemString( row, ll_col  ))

IF Message.StringParm = "Cancel" THEN
	Return -1
ELSE
	s = Message.StringParm
//	if len(s) > 255 then
//		s = mid(s,1,255)
//		messagebox("Notes","This Notes field is limited to 255 characters.")
//	end if
	This.SetItem( row ,  ll_col , s )
END IF
end event

type cb_reqcopy from commandbutton within tabpage_req
integer x = 1929
integer y = 68
integer width = 818
integer height = 84
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Copy Req. to another Template"
end type

event clicked;string ls_clin
integer li_clin
integer li_clin_new
integer li_facil
string li_priv_qual
string li_req_pre_exp
string li_spec_pro
string li_obs
string li_re_req
string li_c1
string li_c2
integer m1

li_clin = dw_select_dept.getitemnumber(1,"clinical_area_id")
if IsNull(li_clin) or li_clin < 1 then Return

select clinical_area_description
into :ls_clin
from priv_clinical_area
where clinical_area_id = :li_clin; 
li_facil = dw_clin_req.getitemnumber(1,"facility_id")
//messagebox("ls_clin",ls_clin)

li_priv_qual = dw_clin_req.getitemstring(1,"priv_qualifications")
li_req_pre_exp = dw_clin_req.getitemstring(1,"req_pre_exp")
li_spec_pro = dw_clin_req.getitemstring(1,"spec_procd")
li_obs = dw_clin_req2.getitemstring(1,"priv_clinical_area2_observations")
li_re_req = dw_clin_req2.getitemstring(1,"priv_clinical_area2_reappoint_req")
li_c1 = dw_clin_req3.getitemstring(1,"priv_clinical_area_3_custom1")
li_c2 = dw_clin_req3.getitemstring(1,"priv_clinical_area_3_custom2")

Open(w_select_privtemp)
li_facil = Message.DoubleParm
if li_facil = 0 then Return

select clinical_area_id
into :li_clin_new
from priv_clinical_area
where clinical_area_description = :ls_clin and facility_id = :li_facil;
//messagebox("li_clin_new",li_clin_new)
if li_clin = li_clin_new then
	Messagebox("Selection Error","You have selected the same Template to copy to. ~r~n Please select a different Template.")
	return 
end if
if li_clin_new = 0 then
	messagebox("Selection Error","The Template you have selected does not have the Clinical Area " + ls_clin + " to copy into. ~r~n It must be added to the Template from the Clinical Area tab before you can copy Requirements.")
	return
end if
 
gnv_appeondb.of_startqueue( )
dw_copy1.settransobject(sqlca)
dw_copy1.retrieve(li_clin_new)
dw_copy2.settransobject(sqlca)
dw_copy2.retrieve(li_clin_new)
dw_copy3.settransobject(sqlca)
dw_copy3.retrieve(li_clin_new)
gnv_appeondb.of_commitqueue( )

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.18.2006 By: Rodger Wu
//$<reason> Fix a defect.
if dw_copy2.rowcount() < 1 then
	dw_copy2.insertrow(0)
	dw_copy2.SetItem( 1, "priv_clinical_area2_clinical_area_id", li_clin_new)
End If
if dw_copy3.rowcount() < 1 then
	dw_copy3.insertrow(0)
	dw_copy3.SetItem( 1, "priv_clinical_area_3_clinical_area_id", li_clin_new)
	dw_copy3.SetItem( 1, "priv_clinical_area_3_custom1_label", &
								dw_clin_req3.getitemstring(1,"priv_clinical_area_3_custom1_label"))
	dw_copy3.SetItem( 1, "priv_clinical_area_3_custom2_label", &
								dw_clin_req3.getitemstring(1,"priv_clinical_area_3_custom2_label"))
End If
//---------------------------- APPEON END ----------------------------

dw_copy1.setitem(1,"priv_qualifications",li_priv_qual)
dw_copy1.setitem(1,"req_pre_exp",li_req_pre_exp)
dw_copy1.setitem(1,"spec_procd",li_spec_pro)
dw_copy2.setitem(1,"priv_clinical_area2_observations",li_obs)
dw_copy2.setitem(1,"priv_clinical_area2_reappoint_req",li_re_req)
dw_copy3.setitem(1,"priv_clinical_area_3_custom1",li_c1)
dw_copy3.setitem(1,"priv_clinical_area_3_custom2",li_c2)

messagebox("Copy Complete","Click Save to save changes.")


end event

type dw_copy1 from datawindow within tabpage_req
boolean visible = false
integer x = 2286
integer y = 136
integer width = 110
integer height = 56
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_priv_clin_req"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_copy3 from datawindow within tabpage_req
boolean visible = false
integer x = 2158
integer y = 140
integer width = 64
integer height = 64
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_priv_clin_req3"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_copy2 from datawindow within tabpage_req
boolean visible = false
integer x = 2002
integer y = 132
integer width = 101
integer height = 76
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_priv_clin_req2"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_copyclin from commandbutton within tabpage_req
integer x = 1070
integer y = 68
integer width = 850
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Copy Req. to another Clinical Area"
end type

event clicked;integer li_clin
integer li_clin_new
integer li_facil
string li_priv_qual
string li_req_pre_exp
string li_spec_pro
string li_obs
string li_re_req
string li_c1
string li_c2
integer m1

li_clin = dw_select_dept.getitemnumber(1,"clinical_area_id")//Start Code Change ----10.06.2009 #V10 maha
if IsNull(li_clin) or li_clin < 1 then Return

li_facil = dw_clin_req.getitemnumber(1,"facility_id")
li_priv_qual = dw_clin_req.getitemstring(1,"priv_qualifications")
li_req_pre_exp = dw_clin_req.getitemstring(1,"req_pre_exp")
li_spec_pro = dw_clin_req.getitemstring(1,"spec_procd")
li_obs = dw_clin_req2.getitemstring(1,"priv_clinical_area2_observations")
li_re_req = dw_clin_req2.getitemstring(1,"priv_clinical_area2_reappoint_req")
li_c1 = dw_clin_req3.getitemstring(1,"priv_clinical_area_3_custom1")
li_c2 = dw_clin_req3.getitemstring(1,"priv_clinical_area_3_custom2")

openwithparm(w_select_clincopy,li_facil)
li_clin_new = message.doubleparm
if li_clin_new = 0 then return
if li_clin = li_clin_new then
	Messagebox("Selection Error","You have selected the same Clinical Area to copy to. ~r~n Please select a different Clinical Area.")
	return
end if
 
dw_copy1.reset()
dw_copy2.reset()
dw_copy3.reset()
gnv_appeondb.of_startqueue( )
dw_copy1.settransobject(sqlca)
dw_copy1.retrieve(li_clin_new)
dw_copy2.settransobject(sqlca)
dw_copy2.retrieve(li_clin_new)
dw_copy3.settransobject(sqlca)
dw_copy3.retrieve(li_clin_new)
gnv_appeondb.of_commitqueue( )

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.22.2006 By: Liang QingShi
//$<reason> Fix a defect.
if dw_copy2.rowcount() < 1 then
	dw_copy2.insertrow(0)
	dw_copy2.SetItem( 1, "priv_clinical_area2_clinical_area_id", li_clin_new)
End If
if dw_copy3.rowcount() < 1 then
	dw_copy3.insertrow(0)
	dw_copy3.SetItem( 1, "priv_clinical_area_3_clinical_area_id", li_clin_new)
	dw_copy3.SetItem( 1, "priv_clinical_area_3_custom1_label", &
								dw_clin_req3.getitemstring(1,"priv_clinical_area_3_custom1_label"))
	dw_copy3.SetItem( 1, "priv_clinical_area_3_custom2_label", &
								dw_clin_req3.getitemstring(1,"priv_clinical_area_3_custom2_label"))
End If
//---------------------------- APPEON END ----------------------------

//dw_copy1.setitem(1,"clinical_area_id",li_clin_new)
//dw_copy1.setitem(1,"facility_id",li_facil)
dw_copy1.setitem(1,"priv_qualifications",li_priv_qual)
dw_copy1.setitem(1,"req_pre_exp",li_req_pre_exp)
dw_copy1.setitem(1,"spec_procd",li_spec_pro)
dw_copy2.setitem(1,"priv_clinical_area2_observations",li_obs)
dw_copy2.setitem(1,"priv_clinical_area2_reappoint_req",li_re_req)
dw_copy3.setitem(1,"priv_clinical_area_3_custom1",li_c1)
dw_copy3.setitem(1,"priv_clinical_area_3_custom2",li_c2)

m1 = messagebox("Copy Complete","Click Save to save changes.")


end event

type dw_clin_req from u_dw within tabpage_req
integer x = 14
integer y = 252
integer width = 4128
integer height = 700
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_priv_clin_req"
boolean vscrollbar = false
boolean border = false
end type

event clicked;call super::clicked;il_clicked_column = this.getclickedcolumn() 
//messagebox("col no",il_clicked_column)
end event

event losefocus;cb_save.triggerevent(clicked!)

end event

event getfocus;Return 0
end event

event doubleclicked;call super::doubleclicked;//Start Code Change ----10.06.2009 #V10 maha - added
string s
long ll_col

ll_col = il_clicked_column

OpenWithParm( w_expand_text, This.GetItemString( row, ll_col  ))

IF Message.StringParm = "Cancel" THEN
	Return -1
ELSE
	s = Message.StringParm
//	if len(s) > 255 then
//		s = mid(s,1,255)
//		messagebox("Notes","This Notes field is limited to 255 characters.")
//	end if
	This.SetItem( row ,  ll_col , s )
END IF
end event

type gb_7 from groupbox within tabpage_req
integer x = 14
integer y = 4
integer width = 1047
integer height = 172
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select Clinical Department"
end type

type dw_clin_select from datawindow within tabpage_req
boolean visible = false
integer x = 3831
integer width = 357
integer height = 76
integer taborder = 120
boolean bringtotop = true
string dataobject = "d_dddw_clin_area"
boolean border = false
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
////dw_clin_sel.retrieve(il_facil)
//dw_clin_select.InsertRow( 0 )
//
//
//DataWindowChild dwchild
//
//This.GetChild( "clinical_area_description", dwchild )
//
//dwchild.SetTransObject( SQLCA )
//dwchild.Retrieve("il_facil")
//dwchild.InsertRow( 1 )
//dwchild.SetItem( 1, "clinical_area_description", "" )
//dwchild.SetItem( 1, "clinical_area_id", 0 )



//DataWindowChild dwchild


//This.of_SetTransObject(SQLCA)

//This.GetChild( "review_results", dwchild )

//dwchild.SetTransObject( SQLCA )
//dwchild.Retrieve("approval code")
end event

event itemchanged;long ll_clin_id
Integer ll_facility_id
long ll_row

tab_1.tabpage_req.dw_clin_select.accepttext()
ll_clin_id = integer(data)

of_set_clin_dept(ll_clin_id,2) //Start Code Change ----10.06.2009 #V92 maha - autoset dept selectors

//of_get_requirements(ll_clin_id)
//
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-11
////$<add> 02.13.2006 By: LeiWei
////$<reason> Performance tuning
////$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
//
//gnv_appeondb.of_startqueue( )
////---------------------------- APPEON END ----------------------------
//
////messagebox("clin number",ll_clin_id)
//tab_1.tabpage_req.dw_clin_req.settransobject(sqlca)
//tab_1.tabpage_req.dw_clin_req.retrieve(ll_clin_id)
//
////*set 2nd part of data window
//tab_1.tabpage_req.dw_clin_req2.settransobject(sqlca)
//tab_1.tabpage_req.dw_clin_req2.retrieve(ll_clin_id)
//
////*set 3rd part of data window
//tab_1.tabpage_req.dw_clin_req3.settransobject(sqlca)
//tab_1.tabpage_req.dw_clin_req3.retrieve(ll_clin_id)
//
////\/moved to facility select itemchanged 12-11-00 maha 
//tab_1.tabpage_acknow.dw_acknow.settransobject(sqlca)
//tab_1.tabpage_acknow.dw_acknow.retrieve(il_facility)//ll_clin_id,
//
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-10
////$<add> 02.13.2006 By: LeiWei
////$<reason> Performance tuning
////$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
// 
//gnv_appeondb.of_commitqueue( )
////---------------------------- APPEON END ----------------------------
//
//if tab_1.tabpage_req.dw_clin_req2.getrow() < 1 then
//	ll_row = tab_1.tabpage_req.dw_clin_req2.InsertRow(0)
//	tab_1.tabpage_req.dw_clin_req2.scrolltoRow(ll_row)
//
//	tab_1.tabpage_req.dw_clin_req2.SetItem(ll_row, "priv_clinical_area2_clinical_area_id", ll_clin_id )
//end if
//
//if tab_1.tabpage_req.dw_clin_req3.getrow() < 1 then
//	ll_row = tab_1.tabpage_req.dw_clin_req3.InsertRow(0)
//	tab_1.tabpage_req.dw_clin_req3.scrolltoRow(ll_row)
//	
//	tab_1.tabpage_req.dw_clin_req3.SetItem(ll_row, "priv_clinical_area_3_clinical_area_id", ll_clin_id )
//	tab_1.tabpage_req.dw_clin_req3.SetItem(ll_row, "priv_clinical_area_3_custom1_label", "Custom field 1 label" )
//	tab_1.tabpage_req.dw_clin_req3.SetItem(ll_row, "priv_clinical_area_3_custom2_label", "Custom field 2 label" )
//end if
////\maha
////\/added 12-11-00 maha 
//cb_copyclin.enabled = true
//cb_reqcopy.enabled  = true
////\maha
//
//
end event

type tabpage_acknow from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4187
integer height = 2088
long backcolor = 33551856
string text = "Template Properties"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 553648127
dw_acknow dw_acknow
st_1 st_1
end type

on tabpage_acknow.create
this.dw_acknow=create dw_acknow
this.st_1=create st_1
this.Control[]={this.dw_acknow,&
this.st_1}
end on

on tabpage_acknow.destroy
destroy(this.dw_acknow)
destroy(this.st_1)
end on

type dw_acknow from u_dw within tabpage_acknow
integer y = 120
integer width = 4183
integer height = 1968
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_priv_temp_prop"
end type

type st_1 from statictext within tabpage_acknow
integer x = 23
integer y = 20
integer width = 3438
integer height = 88
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
boolean enabled = false
string text = "The Acknowledgement and Header are Template based and should be generic enough for all Clinical areas."
boolean focusrectangle = false
end type

type tabpage_report from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 4187
integer height = 2088
long backcolor = 33551856
string text = "Preview Forms"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cb_8 cb_8
cb_ex cb_ex
dw_print dw_print
gb_9 gb_9
gb_6 gb_6
cb_preview cb_preview
cb_print cb_print
ddlb_report ddlb_report
dw_clin_select_preview dw_clin_select_preview
cb_2 cb_2
end type

on tabpage_report.create
this.cb_8=create cb_8
this.cb_ex=create cb_ex
this.dw_print=create dw_print
this.gb_9=create gb_9
this.gb_6=create gb_6
this.cb_preview=create cb_preview
this.cb_print=create cb_print
this.ddlb_report=create ddlb_report
this.dw_clin_select_preview=create dw_clin_select_preview
this.cb_2=create cb_2
this.Control[]={this.cb_8,&
this.cb_ex,&
this.dw_print,&
this.gb_9,&
this.gb_6,&
this.cb_preview,&
this.cb_print,&
this.ddlb_report,&
this.dw_clin_select_preview,&
this.cb_2}
end on

on tabpage_report.destroy
destroy(this.cb_8)
destroy(this.cb_ex)
destroy(this.dw_print)
destroy(this.gb_9)
destroy(this.gb_6)
destroy(this.cb_preview)
destroy(this.cb_print)
destroy(this.ddlb_report)
destroy(this.dw_clin_select_preview)
destroy(this.cb_2)
end on

type cb_8 from uo_cb_output within tabpage_report
integer x = 2715
integer y = 72
integer width = 434
integer height = 84
integer taborder = 80
end type

event clicked;

m_npdb_options NewMenu 
NewMenu = CREATE m_npdb_options
NewMenu.of_setparent(idw)
NewMenu.m_options.m_mailall.visible = false
NewMenu.m_options.m_printall.visible = false
NewMenu.m_options.m_printcurrent.text = 'Print'
NewMenu.m_options.m_mailcurrent.text = 'EMail'
//NewMenu.m_options.PopMenu(w_mdi.pointerx(),w_mdi.pointerY())
NewMenu.m_options.PopMenu(this.x + parent.x, this.y + parent.y + 90) //alfee 11.17.2010
//this calls events in u_dw
//the save as pdf calls ...
end event

event constructor;call super::constructor;idw = tab_1.tabpage_report.dw_print
end event

type cb_ex from commandbutton within tabpage_report
integer x = 3163
integer y = 72
integer width = 343
integer height = 84
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Expand"
end type

event clicked;gs_variable_array lgs_structure

 lgs_structure.as_string[1] =  tab_1.tabpage_report.dw_print.dataobject
 lgs_structure.as_number[1] =  il_facility_report
 lgs_structure.as_number[2] = il_clin_area_preview

openwithparm(w_priv_expand_form,lgs_structure)
end event

type dw_print from u_dw within tabpage_report
integer y = 196
integer width = 4160
integer height = 1892
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_form_priv_acknowledgement_col"
boolean hscrollbar = true
end type

type gb_9 from groupbox within tabpage_report
integer x = 1115
integer y = 8
integer width = 1193
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
string text = "Select Preview"
end type

type gb_6 from groupbox within tabpage_report
integer x = 9
integer y = 8
integer width = 1051
integer height = 172
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select Clinical Department"
end type

type cb_preview from commandbutton within tabpage_report
integer x = 2455
integer y = 72
integer width = 247
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Pre&view"
end type

event clicked;long ll_fac_id
long ll_clin_id
long ll_clin[]
integer li_form //maha 03.14.2011  //maha 04.24.2017 - changed from alt to form 
string ls_ccp //Start Code Change ---- 10.03.2006 #666 maha

ll_fac_id = il_facility
ll_clin_id = il_clin_area_preview
//	messagebox("ll_clin_id",ll_clin_id)

	
if  isnull(ll_clin_id) or ll_clin_id < 1 then
	messagebox("No data", "Please select a Clinical Area")
	return
end if

//Start Code Change ----06.22.2011 #V11 maha 
select count(facility_id)  into :li_form from facility where priv_template = :il_facility;
if li_form = 1 then
	select facility_id into :il_facility_report from facility where priv_template = :il_facility;
elseif li_form > 1 then
	openwithparm(w_priv_facility_select,il_facility)
	if message.doubleparm = 0 then
		return 
	else
		il_facility_report = message.doubleparm
	end if
else
	messagebox("","This template is not connected to any Facility.")
	return
end if

ll_fac_id = il_facility_report
//End Code Change ----06.22.2011

//Start Code Change ----03.14.2011 #V11 maha - added alternate form option
//li_form = dw_tempprop.getitemnumber(1,"alt_form")
li_form = tab_1.tabpage_acknow.dw_acknow.getitemnumber(1,"alt_form")  //Start Code Change ----01.23.2012 #V12 maha - changed from nolonger needed dw.

if ddlb_report.text = "Clinical Area Privilege List" then
	tab_1.tabpage_report.dw_print.dataobject  = "d_rpt_priv_by_clin_area_by_facil"
	tab_1.tabpage_report.dw_print.settransobject(sqlca)
	tab_1.tabpage_report.dw_print.retrieve(ll_fac_id, ll_clin_id )
elseif ddlb_report.text = "Privilege Requirements" then
	tab_1.tabpage_report.dw_print.dataobject  = "d_form_priv_clin_req"
	tab_1.tabpage_report.dw_print.settransobject(sqlca)
	tab_1.tabpage_report.dw_print.retrieve(ll_fac_id,ll_clin_id )
elseif ddlb_report.text = "Privileges Requested w/ headers" then
	choose case li_form
		case 1
			tab_1.tabpage_report.dw_print.dataobject  = "d_form_priv_by_clin_area_f2"
		case 0
			//tab_1.tabpage_report.dw_print.dataobject  = "d_form_priv_by_clin_area_h"
			tab_1.tabpage_report.dw_print.dataobject  = "d_form_priv_by_clin_area_h_1a"  //Start Code Change ----10.01.2013 #V14 maha
		case -1
			tab_1.tabpage_report.dw_print.dataobject  = "d_form_priv_by_clin_area_h_new"  //Start Code Change ----10.01.2013 #V14 maha
		case else
			messagebox( " Preview", "Privileges Requested w/ headers is not supported in this format")
			return
	end choose	
	ll_clin[1] = il_clin_area_preview
	tab_1.tabpage_report.dw_print.settransobject(sqlca)
	tab_1.tabpage_report.dw_print.retrieve(ll_fac_id,ll_clin_id )
elseif ddlb_report.text = "Privileges Requested w/ descp." then
		choose case li_form
		case 1
			tab_1.tabpage_report.dw_print.dataobject  = "d_form_priv_by_clin_area_d_f2"
		case 3
			tab_1.tabpage_report.dw_print.dataobject  = "d_form_priv_by_clin_area_d_f3"
		case 4
			tab_1.tabpage_report.dw_print.dataobject  = "d_form_priv_by_clin_area_d_f4"
		case -1 //format 1 alt
			tab_1.tabpage_report.dw_print.dataobject  = "d_form_priv_by_clin_area_d_1a"  //Start Code Change ----10.01.2013 #V14 maha
		case 6  //Start Code Change ----04.24.2017 #V153 maha - milford custom
			messagebox( " Preview", "Privileges Requested w/ desc is not supported in this format")
			return
		case else
			//tab_1.tabpage_report.dw_print.dataobject  = "d_form_priv_by_clin_area_d"  //modify by stephen 04.03.2013 -Issues with Privileging -bug 3447
			tab_1.tabpage_report.dw_print.dataobject  = "d_form_priv_by_clin_area_d_f1" //Start Code Change ----10.01.2013 #V14 maha
	end choose	
	ll_clin[1] = il_clin_area_preview
	tab_1.tabpage_report.dw_print.settransobject(sqlca)
	tab_1.tabpage_report.dw_print.retrieve(ll_fac_id,ll_clin_id)
elseif ddlb_report.text = "Privilege Recommendations" then
//	tab_1.tabpage_report.dw_print.dataobject  = "d_form_priv_acknowledgement_col"
	choose case li_form
		case 6  //Start Code Change ----04.24.2017 #V153 maha - milford custom
			messagebox( " Preview", "Privileges Recommendations is not supported in this format")
			return
		case else
			tab_1.tabpage_report.dw_print.dataobject  = "d_form_priv_acknowledgement_11"  //Start Code Change ----03.02.2011 #V11 maha  -  dynamic values object
			tab_1.tabpage_report.dw_print.settransobject(sqlca)
			tab_1.tabpage_report.dw_print.retrieve(ll_fac_id,ll_clin_id )	
	end choose
elseif ddlb_report.text = "Complete Privilege Application w/ headers" then
	choose case li_form
		case 1
			tab_1.tabpage_report.dw_print.dataobject  = "d_form_priv_request_master_f2"
		case -1 
			tab_1.tabpage_report.dw_print.dataobject  = "d_form_clin_priv_request_master_h"  //Start Code Change ----10.01.2013 #V14 maha
		case 0
			tab_1.tabpage_report.dw_print.dataobject  =  "d_form_clin_priv_request_master_h_1a"  //Start Code Change ----10.01.2013 #V14 maha
			//tab_1.tabpage_report.dw_print.dataobject  = "d_form_clin_priv_request_master_h"
		case else
			messagebox( " Preview", "Complete Privilege Application w/ headers is not supported in this format")
			return
	end choose	
	tab_1.tabpage_report.dw_print.settransobject(sqlca)
	tab_1.tabpage_report.dw_print.retrieve(ll_fac_id,ll_clin_id )
	
elseif ddlb_report.text = "Complete Privilege Application w/ descp." then
	choose case li_form
		case 1  //format 2
			tab_1.tabpage_report.dw_print.dataobject  =  "d_form_priv_request_master_f2"
			tab_1.tabpage_report.dw_print.settransobject(sqlca)
			tab_1.tabpage_report.dw_print.retrieve(ll_fac_id,ll_clin_id/*ll_clin_id, ll_fac_id*/ ) //modify Michael 04.26.2012 Bug ID 3051,Bug ID 3050 
		case 3
			tab_1.tabpage_report.dw_print.dataobject  = "d_form_priv_request_master_f3"
			tab_1.tabpage_report.dw_print.settransobject(sqlca)
			tab_1.tabpage_report.dw_print.retrieve(ll_fac_id,ll_clin_id/*ll_clin_id, ll_fac_id*/ ) //modify Michael 04.26.2012 Bug ID 3051,Bug ID 3050 )
		case 4
			tab_1.tabpage_report.dw_print.dataobject  = "d_form_priv_request_master_f4"	
			tab_1.tabpage_report.dw_print.settransobject(sqlca)
			tab_1.tabpage_report.dw_print.retrieve(ll_fac_id,ll_clin_id/*ll_clin_id, ll_fac_id*/ ) //modify Michael 04.26.2012 Bug ID 3051,Bug ID 3050 
		case -1 //format 1 alt  //Start Code Change ----10.01.2013 #V14 maha - added
			tab_1.tabpage_report.dw_print.dataobject  =  "d_form_clin_priv_request_master_d"
			tab_1.tabpage_report.dw_print.settransobject(sqlca)
			tab_1.tabpage_report.dw_print.retrieve(ll_fac_id,ll_clin_id )
		case 6   //Start Code Change ----04.24.2017 #V153 maha - milford custom
			tab_1.tabpage_report.dw_print.dataobject  =  "d_form_clin_priv_request_master_cm6"
			tab_1.tabpage_report.dw_print.settransobject(sqlca)
			tab_1.tabpage_report.dw_print.retrieve(ll_fac_id,ll_clin_id )			
		
		case else  //Start Code Change ----10.01.2013 #V14 maha - modified
			If li_form = 5 Then//Added by Appeon long.zhang 09.17.2015 (Bug # 4721 for Case #00056366 Privilege Lists)
				tab_1.tabpage_report.dw_print.dataobject  = "d_form_clin_priv_request_master_d_f5"
			Else
				tab_1.tabpage_report.dw_print.dataobject  = "d_form_clin_priv_request_master_d_1a"
			End If
	
			tab_1.tabpage_report.dw_print.settransobject(sqlca)
			tab_1.tabpage_report.dw_print.retrieve(ll_fac_id,ll_clin_id )
			 //Start Code Change ---- 10.03.2006 #666 maha
			ls_ccp = of_ccp_facility_text(ll_clin_id,ll_fac_id)
			if ls_ccp <> "NO" then
				string fails
				datawindowchild dwchild
				tab_1.tabpage_report.dw_print.getchild("dw_1",dwchild)
				dwchild.Modify("t_hospitals.Visible=1")
				dwchild.Modify("t_facility_list.Visible=1")
				fails = dwchild.Modify("t_facility_list.text='" + ls_ccp + "'")
				//messagebox("",fails)
				//.object.dw_1.object.t_hospitals.visible = true
				//tab_1.tabpage_report.dw_print.object.dw_1.object.t_facility_list.visible = true
				//tab_1.tabpage_report.dw_print.object.dw_1.object.t_facility_list.text = ls_ccp
			end if
			//End Code Change--- 10.03.2006 maha
	end choose	
else

	messagebox("Report Selection", "Please select a report or form to view.")
	return
end if

tab_1.tabpage_report.dw_print.Modify("DataWindow.Print.Preview=Yes")   //Start Code Change ----11.19.2012 #V12 maha - put in preview mode
debugbreak()
//------------------- APPEON BEGIN -------------------
//<$>Delete:Stephen 04.03.2013
//<$>Reason:Issues with Privileging -bug 3447
//$<add> Michael 05.28.2012
//$<reason>set header field height 
/*
n_cst_priv_height lu_set_height
lu_set_height = create n_cst_priv_height
lu_set_height.of_set_height(tab_1.tabpage_report.dw_print,mle_text)
destroy lu_set_height
*/
//------------------- APPEON END ---------------------

//------------------- APPEON BEGIN -------------------
//$<delete> Michael 05.28.2012
//$<reason> set header field height
/*
//------------------- APPEON BEGIN -------------------
//$<add> Stephen 08.03.2011
//$<reason> Privilege Template Headers being cut off
//add d_form_priv_by_clin_area_d_f3,d_form_priv_by_clin_area_d_f4,d_form_priv_request_master_f2,d_form_priv_request_master_f3,d_form_priv_request_master_f4 Michael 04.10.2012
string ls_text
integer li_cnt, li_height, li_width
datawindowchild ldwc_1

If Upper(appeongetclienttype()) <> "PB" Then
	if tab_1.tabpage_report.dw_print.dataobject  = "d_form_clin_priv_request_master_h" or tab_1.tabpage_report.dw_print.dataobject  = "d_form_clin_priv_request_master_d"  or  tab_1.tabpage_report.dw_print.dataobject  = "d_form_priv_request_master_f2" or  tab_1.tabpage_report.dw_print.dataobject  = "d_form_priv_request_master_f3" or  tab_1.tabpage_report.dw_print.dataobject  = "d_form_priv_request_master_f4"  then
		
		tab_1.tabpage_report.dw_print.getchild("dw_1",ldwc_1)
		li_width = integer(ldwc_1.describe("priv_template_header_text.width"))
		mle_text.width = li_width		
		if ldwc_1.rowcount() >0 then 
			ls_text = ldwc_1.getitemstring(1,"priv_template_header_text")
			mle_text.text = ls_text
			li_cnt = mle_text.linecount() - 1
			li_height = integer(ldwc_1.describe("datawindow.header.height")) + li_cnt * 68 + 10
			ldwc_1.modify("datawindow.header.height = '"+string(li_height)+"'")
		end if		
	end if
	if tab_1.tabpage_report.dw_print.dataobject  = "d_form_priv_by_clin_area_d_f2" or tab_1.tabpage_report.dw_print.dataobject  = "d_form_priv_by_clin_area_f2" or tab_1.tabpage_report.dw_print.dataobject  = "d_form_priv_by_clin_area_d" or tab_1.tabpage_report.dw_print.dataobject  = "d_form_priv_by_clin_area_h"  or  tab_1.tabpage_report.dw_print.dataobject  ="d_form_priv_by_clin_area_d_f3"  or  tab_1.tabpage_report.dw_print.dataobject  ="d_form_priv_by_clin_area_d_f4" then
		li_width = integer(tab_1.tabpage_report.dw_print.describe("priv_template_header_text.width"))
		mle_text.width = li_width		
		if  tab_1.tabpage_report.dw_print.rowcount() > 0 then
			ls_text =  tab_1.tabpage_report.dw_print.getitemstring(1,"priv_template_header_text")
			mle_text.text = ls_text
			li_cnt = mle_text.linecount() - 1
			
			li_height = integer(tab_1.tabpage_report.dw_print.describe("datawindow.header.height")) + li_cnt * 68 + 10
			tab_1.tabpage_report.dw_print.modify("datawindow.header.height = '"+string(li_height)+"'")
		end if
	end if
end if
//------------------- APPEON END -------------------

//------------------- APPEON BEGIN -------------------
//$<add> Michael 04.09.2012
//$<reason>Apha id 2988 - Exclusive Contract text doesn't preview correctly in reports
If Upper(appeongetclienttype()) <> "PB" Then
	if tab_1.tabpage_report.dw_print.dataobject  = "d_form_priv_request_master_f4" or tab_1.tabpage_report.dw_print.dataobject  = "d_form_priv_request_master_f3" or tab_1.tabpage_report.dw_print.dataobject  = "d_form_priv_request_master_f2"  or tab_1.tabpage_report.dw_print.dataobject  ="d_form_priv_request_master_f2" then		
		tab_1.tabpage_report.dw_print.getchild("dw_1",ldwc_1)
		if ldwc_1.getitemnumber(ldwc_1.getrow(),"use_exclusive") = 1 then
			li_width = integer(ldwc_1.describe("priv_template_excl_cont_text.width"))
			mle_text.width = li_width		
			if ldwc_1.rowcount() >0 then 
				ls_text = ldwc_1.getitemstring(1,"priv_template_excl_cont_text")
				mle_text.text = ls_text
				li_cnt = mle_text.linecount() - 1
				li_height = integer(ldwc_1.describe("datawindow.header.height")) + li_cnt * 68 + 10
				ldwc_1.modify("datawindow.header.height = '"+string(li_height)+"'")
			end if	
		end if
	end if
	if tab_1.tabpage_report.dw_print.dataobject  = "d_form_priv_by_clin_area_d_f4" or tab_1.tabpage_report.dw_print.dataobject  = "d_form_priv_by_clin_area_d_f3" or tab_1.tabpage_report.dw_print.dataobject  = "d_form_priv_by_clin_area_d_f2" or tab_1.tabpage_report.dw_print.dataobject  = "d_form_priv_by_clin_area_f2" 	then																				  			
		if tab_1.tabpage_report.dw_print.getitemnumber(tab_1.tabpage_report.dw_print.getrow() ,"use_exclusive") = 1  then
			li_width = integer(tab_1.tabpage_report.dw_print.describe("priv_template_excl_cont_text.width"))
			mle_text.width = li_width		
			if  tab_1.tabpage_report.dw_print.rowcount() > 0 then
				ls_text =  tab_1.tabpage_report.dw_print.getitemstring(1,"priv_template_excl_cont_text")
				mle_text.text = ls_text
				li_cnt = mle_text.linecount() - 1
				
				li_height = integer(tab_1.tabpage_report.dw_print.describe("datawindow.header.height")) + li_cnt * 68 + 10
				tab_1.tabpage_report.dw_print.modify("datawindow.header.height = '"+string(li_height)+"'")
			end if
		end if
	end if
end if
//------------------- APPEON END -------------------
*/
//------------------- APPEON END ---------------------


cb_ex.enabled = true

//End Code Change ----03.14.2011

end event

type cb_print from commandbutton within tabpage_report
boolean visible = false
integer x = 3547
integer y = 136
integer width = 247
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Print"
end type

event clicked;if  isnull(il_clin_area_preview) or il_clin_area_preview < 1 then
	messagebox("No data", "Please select a Clinical Area")
	return
end if

cb_preview.triggerevent(clicked!)


tab_1.tabpage_report.dw_print.print()
end event

type ddlb_report from dropdownlistbox within tabpage_report
integer x = 1161
integer y = 72
integer width = 1106
integer height = 616
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Clinical Area Privilege List","Privilege Requirements","Privileges Requested w/ headers","Privileges Requested w/ descp.","Privilege Recommendations","Complete Privilege Application w/ headers","Complete Privilege Application w/ descp.",""}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;tab_1.tabpage_report.cb_preview.triggerevent(clicked!)
end event

type dw_clin_select_preview from datawindow within tabpage_report
boolean visible = false
integer x = 2546
integer y = 76
integer width = 987
integer height = 76
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_dddw_clin_area"
boolean border = false
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
////dw_clin_sel.retrieve(il_facil)
//dw_clin_select.InsertRow( 0 )
//
//
//DataWindowChild dwchild
//
//This.GetChild( "clinical_area_description", dwchild )
//
//dwchild.SetTransObject( SQLCA )
//dwchild.Retrieve("il_facil")
//dwchild.InsertRow( 1 )
//dwchild.SetItem( 1, "clinical_area_description", "" )
//dwchild.SetItem( 1, "clinical_area_id", 0 )



//DataWindowChild dwchild


//This.of_SetTransObject(SQLCA)

//This.GetChild( "review_results", dwchild )

//dwchild.SetTransObject( SQLCA )
//dwchild.Retrieve("approval code")
end event

event itemchanged;


tab_1.tabpage_report.dw_clin_select_preview.accepttext()
il_clin_area_preview = integer(data)

of_set_clin_dept(il_clin_area_preview ,4) //Start Code Change ----10.06.2009 #V92 maha - autoset dept selectors







end event

type cb_2 from commandbutton within tabpage_report
boolean visible = false
integer x = 3003
integer y = 52
integer width = 247
integer height = 108
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Export"
end type

event clicked;if  isnull(il_clin_area_preview) or il_clin_area_preview < 1 then
	messagebox("No data", "Please select a Clinical Area")
	return
end if

cb_preview.triggerevent(clicked!)


gnv_dw.of_SaveAs(tab_1.tabpage_report.dw_print)//.saveas() Modify by Evan 05.11.2010
end event

type dw_select_dept from datawindow within w_privilege_painter
integer x = 59
integer y = 300
integer width = 987
integer height = 80
integer taborder = 110
boolean bringtotop = true
string dataobject = "d_clin_area_select"
boolean border = false
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
////dw_clin_sel.retrieve(il_facil)
//dw_clin_select.InsertRow( 0 )
//
//
//DataWindowChild dwchild
//
//This.GetChild( "clinical_area_description", dwchild )
//
//dwchild.SetTransObject( SQLCA )
//dwchild.Retrieve("il_facil")
//dwchild.InsertRow( 1 )
//dwchild.SetItem( 1, "clinical_area_description", "" )
//dwchild.SetItem( 1, "clinical_area_id", 0 )



//DataWindowChild dwchild


//This.of_SetTransObject(SQLCA)

//This.GetChild( "review_results", dwchild )

//dwchild.SetTransObject( SQLCA )
//dwchild.Retrieve("approval code")
end event

event itemchanged;long ll_clin_id
Integer ll_facility_id
long ll_row

tab_1.tabpage_req.dw_clin_select.accepttext()
ll_clin_id = integer(data)

of_set_clin_dept(ll_clin_id,2) //Start Code Change ----10.06.2009 #V92 maha - autoset dept selectors

//of_get_requirements(ll_clin_id)
//
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-11
////$<add> 02.13.2006 By: LeiWei
////$<reason> Performance tuning
////$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
//
//gnv_appeondb.of_startqueue( )
////---------------------------- APPEON END ----------------------------
//
////messagebox("clin number",ll_clin_id)
//tab_1.tabpage_req.dw_clin_req.settransobject(sqlca)
//tab_1.tabpage_req.dw_clin_req.retrieve(ll_clin_id)
//
////*set 2nd part of data window
//tab_1.tabpage_req.dw_clin_req2.settransobject(sqlca)
//tab_1.tabpage_req.dw_clin_req2.retrieve(ll_clin_id)
//
////*set 3rd part of data window
//tab_1.tabpage_req.dw_clin_req3.settransobject(sqlca)
//tab_1.tabpage_req.dw_clin_req3.retrieve(ll_clin_id)
//
////\/moved to facility select itemchanged 12-11-00 maha 
//tab_1.tabpage_acknow.dw_acknow.settransobject(sqlca)
//tab_1.tabpage_acknow.dw_acknow.retrieve(il_facility)//ll_clin_id,
//
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-10
////$<add> 02.13.2006 By: LeiWei
////$<reason> Performance tuning
////$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
// 
//gnv_appeondb.of_commitqueue( )
////---------------------------- APPEON END ----------------------------
//
//if tab_1.tabpage_req.dw_clin_req2.getrow() < 1 then
//	ll_row = tab_1.tabpage_req.dw_clin_req2.InsertRow(0)
//	tab_1.tabpage_req.dw_clin_req2.scrolltoRow(ll_row)
//
//	tab_1.tabpage_req.dw_clin_req2.SetItem(ll_row, "priv_clinical_area2_clinical_area_id", ll_clin_id )
//end if
//
//if tab_1.tabpage_req.dw_clin_req3.getrow() < 1 then
//	ll_row = tab_1.tabpage_req.dw_clin_req3.InsertRow(0)
//	tab_1.tabpage_req.dw_clin_req3.scrolltoRow(ll_row)
//	
//	tab_1.tabpage_req.dw_clin_req3.SetItem(ll_row, "priv_clinical_area_3_clinical_area_id", ll_clin_id )
//	tab_1.tabpage_req.dw_clin_req3.SetItem(ll_row, "priv_clinical_area_3_custom1_label", "Custom field 1 label" )
//	tab_1.tabpage_req.dw_clin_req3.SetItem(ll_row, "priv_clinical_area_3_custom2_label", "Custom field 2 label" )
//end if
////\maha
////\/added 12-11-00 maha 
//cb_copyclin.enabled = true
//cb_reqcopy.enabled  = true
////\maha
//
//
end event

