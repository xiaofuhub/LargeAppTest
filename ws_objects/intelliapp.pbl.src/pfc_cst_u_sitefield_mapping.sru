$PBExportHeader$pfc_cst_u_sitefield_mapping.sru
forward
global type pfc_cst_u_sitefield_mapping from userobject
end type
type pb_1 from picturebutton within pfc_cst_u_sitefield_mapping
end type
type pb_2 from picturebutton within pfc_cst_u_sitefield_mapping
end type
type sle_screen from singlelineedit within pfc_cst_u_sitefield_mapping
end type
type cb_forward from commandbutton within pfc_cst_u_sitefield_mapping
end type
type cb_back from commandbutton within pfc_cst_u_sitefield_mapping
end type
type ddlb_page from dropdownlistbox within pfc_cst_u_sitefield_mapping
end type
type st_1 from statictext within pfc_cst_u_sitefield_mapping
end type
type cb_step from commandbutton within pfc_cst_u_sitefield_mapping
end type
type dw_page_steps from datawindow within pfc_cst_u_sitefield_mapping
end type
type ole_browser from olecustomcontrol within pfc_cst_u_sitefield_mapping
end type
type dw_field from u_dw within pfc_cst_u_sitefield_mapping
end type
end forward

global type pfc_cst_u_sitefield_mapping from userobject
integer width = 3488
integer height = 1484
long backcolor = 33551856
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_init ( )
event ue_appchanged ( )
event ue_delete ( )
event ue_add ( integer ai_action )
event ue_save ( )
event ue_retrievedetail ( long al_app_field_id )
event ue_retrievedetaildddw ( )
pb_1 pb_1
pb_2 pb_2
sle_screen sle_screen
cb_forward cb_forward
cb_back cb_back
ddlb_page ddlb_page
st_1 st_1
cb_step cb_step
dw_page_steps dw_page_steps
ole_browser ole_browser
dw_field dw_field
end type
global pfc_cst_u_sitefield_mapping pfc_cst_u_sitefield_mapping

type variables
long il_Page
long il_curr_app_id
datawindow idw_fld_prop
datawindow idw_field_tv
datawindow idw_appl_detail
n_cst_app_population inv_html

w_train_app iw_parent //alfee 10.29.2013
end variables

forward prototypes
public function integer of_mapfieldfromsp ()
public function integer of_mapscreenfield ()
public function integer of_selectlookupfield (string as_lookup_type)
public function integer of_changefielddescr (string as_field_name)
public function integer of_seterrorevent (oleobject aole_object)
public function integer of_get_screen_name ()
public function integer of_next_prior_page (string as_dir)
public function integer of_change_page (integer ai_index)
public function integer of_page_notes ()
public function integer of_forward_back (string as_dir)
public function integer of_set_screen_name (string as_name)
public function integer of_page_steps ()
public function integer of_set_parent_window (w_train_app aw_win)
end prototypes

event ue_init();//====================================================================
// $<event> ue_init()
// $<arguments>
// $<returns> (None)
// $<description> V12.1 Website Population
// $<add> (Appeon) evan 10.20.2011
//====================================================================

string ls_site_url

// Retrieve fields
//---------Begin Modified by (Appeon)Alfee 10.29.2013-----------------
//ddlb_page.SelectItem(1)
//ddlb_page.Event SelectionChanged(1)
IF IsValid (iw_parent) THEN
	iw_parent.tab_1.tabpage_design.dw_buttons_webform.SetItem(1, "page", 0)
	iw_parent.tab_1.tabpage_design.dw_buttons_webform.AcceptText ()
	of_change_page (1)
END IF
//---------End Modfiied ------------------------------------------------------

// Open website form
ls_site_url = Trim(idw_appl_detail.GetItemString(idw_appl_detail.GetRow(), "site_url"))
try
	if Len(ls_site_url) > 0 then
		ole_browser.Object.Navigate(ls_site_url)
	else
		ole_browser.Object.Navigate("http://blank.htm")
	end if
catch (runtimeerror e)
	MessageBox("Error", "Failed to open the url: " + ls_site_url, StopSign!)
end try
end event

event ue_appchanged();//====================================================================
// $<event> ue_appchanged()
// $<arguments>
// $<returns> (None)
// $<description> V12.1 Website Population
// $<add> (Appeon) evan 10.20.2011
//====================================================================

long ll_new_app_id

idw_appl_detail = w_train_app.tab_1.tabpage_select.dw_appl_detail
idw_field_tv = w_train_app.tab_1.tabpage_design.dw_field_tv
idw_fld_prop = w_train_app.tab_1.tabpage_design.dw_fld_prop

ll_new_app_id = idw_appl_detail.GetItemNumber(idw_appl_detail.GetRow(), "app_id")
if ll_new_app_id <> il_curr_app_id then
	il_curr_app_id = ll_new_app_id
	this.Event ue_Init()
end if

// Re-retrieve field detail
if dw_field.GetRow() > 0 and idw_fld_prop.GetRow() < 1 then
	dw_field.Event RowFocusChanged(dw_field.GetRow())
end if
end event

event ue_delete();//====================================================================
// $<event> ue_delete()
// $<arguments>
// $<returns> (None)
// $<description> Delete current record
//						V12.1 Website Population
// $<add> (Appeon) evan 10.20.2011
//====================================================================

long ll_Row
long ll_asp_id

ll_Row = dw_field.GetRow()
if ll_Row < 1 then Return
if MessageBox("Delete", "Are you sure you want to delete the selected mapping field record?", Question!, YesNo!) = 2 then
	Return
end if

//ll_asp_id = dw_field.getitemnumber(ll_row, "app_field_id") //(Appeon)Stephen 2013-08-07 - V141 Web Population Part 3
ll_asp_id = dw_field.getitemnumber(ll_row, "app_page_steps_aps_id") //BugA102503 - alfee 10.25.2013

// Delete current record
dw_field.DeleteRow(0)
dw_field.ScrollToRow(dw_field.GetRow())
dw_field.SelectRow(0, false)
dw_field.SelectRow(dw_field.GetRow(), true)

// Update data
gnv_appeondb.of_StartQueue()
delete from app_page_steps where Aps_id = :ll_asp_id; //(Appeon)Stephen 2013-08-07 - V141 Web Population Part 3
dw_field.Update()
Commit;
gnv_appeondb.of_CommitQueue()

// Refresh field detail
if ll_Row = 1 and dw_field.GetRow() > 0 then
	dw_field.Event RowFocusChanged(dw_field.GetRow())
end if
end event

event ue_add(integer ai_action);//====================================================================
// $<event> ue_add()
// $<arguments>
//		integer	ai_action
// $<returns> (None)
// $<description> Add a record
//						V12.1 Website Population
// $<add> (Appeon) evan 10.20.2011
//====================================================================

long ll_Row
long ll_Return
long ll_app_field_id
long ll_aps_id //alfee 10.25.2013
integer li_action_type, li_step //(Appeon)Stephen 2013-08-07 - V141 Web Population Part 3
string ls_Object
string ls_Command
string ls_object_type
string ls_site_field_name
string ls_site_field_setcommand

// Get text object
ll_Return = inv_html.of_GetActiveElement(ole_browser.object.document, ls_Object, ls_object_type, ls_Command)
if ll_Return <> 1 then
	if ai_Action = 1 then
		//---------Begin Modified by (Appeon)Stephen 2013-10-15 for BugL101004--------
		//MessageBox("Add", "The double clicked control cannot be used to map field.")
		MessageBox("Add", "The selected control cannot be used to map field.")
		//---------End Modfiied ------------------------------------------------------
		
	else
		MessageBox("Add", "Please select Text/Checkbox/Radio-buttons/Dropdownlistbox controls on the web browser screen.")
	end if
	Return
end if

//---------Begin Added by (Appeon)Stephen 08.25.2017 for Usability id 5746 - Can't map ipop field SaaS 15.3 07172017--------
string ls_comm
if ai_Action = 2 and ls_object_type = "T"  then
	ls_comm = "var control = document.getElementById('"+ls_Object+"').getAttribute('onkeyup');" +&
					 "if(control != null) {eval(control);}"
	ole_browser.object.document.parentwindow.eval(ls_comm, "jscript")
end if
//---------End Added ------------------------------------------------------

// Get field id
SELECT Max(app_field_id)  
INTO :ll_app_field_id  
FROM app_field_prop;
if ll_app_field_id = 0 OR IsNull(ll_app_field_id) then
	ll_app_field_id = 1
else
	ll_app_field_id ++
end if

// Add a record
ll_Row = dw_field.InsertRow(0)
dw_field.SetItem(ll_Row, "app_field_id", ll_app_field_id)
dw_field.SetItem(ll_Row, "app_id", il_curr_app_id)
dw_field.SetItem(ll_Row, "table_id", 0)
dw_field.SetItem(ll_Row, "field_id", 0)
dw_field.SetItem(ll_Row, "object_type", ls_object_type)
dw_field.SetItem(ll_Row, "site_field_label", ls_Object)
dw_field.SetItem(ll_Row, "site_field_name", ls_Object)
dw_field.SetItem(ll_Row, "site_field_setcommand", ls_Command)
dw_field.SetItem(ll_Row, "page", il_Page)
//Start Code Change ----02.28.2012 #V12 maha
dw_field.SetItem(ll_Row, "x_pos", 1)
dw_field.SetItem(ll_Row, "y_pos", 1)
dw_field.SetItem(ll_Row, "field_description", ls_Object)
//End Code Change ----02.28.2012

// Update data
//---------Begin Added by (Appeon)Stephen 2013-08-07 for V141 Web Population Part 3--------
//get action type
choose case upper(ls_object_type)
	case 'T'  //TEXT or password or TEXTAREA
		li_action_type = 1
	case 'C' //CHECKBOX
		li_action_type = 2
	case 'R' //RADIO
		li_action_type = 3
	case 'D' //SELECT
		li_action_type = 4
	case 'S' //submit
		li_action_type = 5
	case 'B' //BUTTON - Alfee 10.28.2013
		li_action_type = 6		
end choose

//---------Begin Modified by (Appeon)Alfee 10.25.2013 for BugA102503 -----------------
//get max steps and the key no
//dw_field.SetItem(ll_Row, "app_page_steps_aps_id", ll_app_field_id)
//select max(sort_order) into :li_step from app_page_steps where app_id = :il_curr_app_id and page = :il_Page;
gnv_appeondb.of_StartQueue()
select max(sort_order) into :li_step from app_page_steps where app_id = :il_curr_app_id and page = :il_Page;
select max(aps_id) into :ll_aps_id from app_page_steps;
gnv_appeondb.of_CommitQueue()

if isnull(ll_aps_id) then ll_aps_id = 0
ll_aps_id +=1
dw_field.SetItem(ll_Row, "app_page_steps_aps_id", ll_aps_id)
dw_field.AcceptText ()
//---------End Modfiied ------------------------------------------------------------------------
if isnull(li_step) then li_step = 0
li_step +=1
//---------End Added ------------------------------------------------------

gnv_appeondb.of_StartQueue()
//insert into app_page_steps(app_id, aps_id, page, element_name, Action_type, sort_order)  	
    // values(:il_curr_app_id, :ll_app_field_id, :il_Page, :ls_Object, :li_action_type, :li_step); //(Appeon)Stephen 2013-08-07 - V141 Web Population Part 3 -add element to app_page_steps
insert into app_page_steps(app_id, aps_id, page, element_name, Action_type, sort_order, app_field_id) 	
values(:il_curr_app_id, :ll_aps_id, :il_Page, :ls_Object, :li_action_type, :li_step, :ll_app_field_id); //BugA102503 - Alfee 10.25.2013	 
dw_field.Update()
Commit;
gnv_appeondb.of_CommitQueue()

// Refresh field detail
if ll_Row = 1 then
	dw_field.Event RowFocusChanged(1)
else
	dw_field.ScrollToRow(ll_Row)
end if
end event

event ue_save();//====================================================================
// $<event> ue_save()
// $<arguments>
// $<returns> (None)
// $<description> V12.1 Website Population
// $<add> (Appeon) evan 10.25.2011
//====================================================================

// Update data
gnv_appeondb.of_StartQueue()
dw_field.Update()
Commit;
gnv_appeondb.of_CommitQueue()
end event

event ue_retrievedetail(long al_app_field_id);//====================================================================
// $<event> ue_retrievedetail()
// $<arguments>
//		long	al_app_field_id
// $<returns> (None)
// $<description> Retrieve field detail
//						V12.1 Website Population
// $<add> (Appeon) evan 10.25.2011
//====================================================================

datawindowchild ldwc_query_field
datawindowchild ldwc_query_field_addr

if al_app_field_id > 0 then
	idw_fld_prop.GetChild("query_field", ldwc_query_field)
	idw_fld_prop.GetChild("query_field_addr", ldwc_query_field_addr)
	if ldwc_query_field.RowCount() < 1 then ldwc_query_field.InsertRow(0)
	if ldwc_query_field_addr.RowCount() < 1 then ldwc_query_field_addr.InsertRow(0)
	idw_fld_prop.Retrieve(al_app_field_id)
else
	idw_fld_prop.TriggerEvent("ue_Reset")
end if
w_train_app.tab_1.tabpage_design.dw_quick_filters.Event ue_ShowWindow()
end event

event ue_retrievedetaildddw();//====================================================================
// $<event> ue_retrievedetaildddw()
// $<arguments>
// $<returns> (None)
// $<description> Retrieve field detail dddw
//						V12.1 Website Population
// $<add> (Appeon) evan 10.28.2011
//====================================================================

Long ll_nr
Long li_tbl_id
Long li_found
String ls_query_fld
String ls_lookup_code
String ls_lookup_name
String ls_fld_type 
String ls_lookup_type
datawindowchild ldw_child
DataWindowChild ldwc_query_field
datawindowchild ldwc_query_field_addr

if idw_fld_prop.GetRow() < 1 then Return

// query_field and query_field_addr dddw
li_tbl_id = idw_fld_prop.GetItemNumber( 1, "table_id" )
idw_fld_prop.GetChild( "query_field", ldwc_query_field )
idw_fld_prop.GetChild( "query_field_addr", ldwc_query_field_addr )
ldwc_query_field.SetTransObject( SQLCA )
ldwc_query_field_addr.SetTransObject( SQLCA )

gnv_appeondb.of_StartQueue()
w_train_app.tab_1.tabpage_design.dw_quick_filters.Event ue_RetrieveDddw()
ldwc_query_field.Retrieve( li_tbl_id )
ldwc_query_field_addr.Retrieve( 20 )
gnv_appeondb.of_CommitQueue()

// Query field lookup
ls_query_fld = idw_fld_prop.GetItemString( 1, "query_field" )
li_found = ldwc_query_field.Find( "field_name = '" + ls_query_fld + "'", 1, 10000 )
IF li_found > 0 THEN
	ls_lookup_code = ldwc_query_field.GetItemString( li_found, "lookup_code" )
	ls_lookup_type = ldwc_query_field.GetItemString( li_found, "lookup_type" )
	ls_fld_type = ldwc_query_field.GetItemString( li_found, "field_type" )
	w_train_app.of_set_query_lookup(ls_lookup_type,ls_query_fld,ls_lookup_code,"query_value") //maha 042205
END IF

// Address query field lookup
ls_query_fld = idw_fld_prop.GetItemString( 1, "query_field_addr" )
li_found = ldwc_query_field_addr.Find( "field_name = '" + ls_query_fld + "'", 1, 10000 )
IF li_found > 0 THEN
	ls_lookup_code = ldwc_query_field_addr.GetItemString( li_found, "lookup_code" )
	ls_lookup_type = ldwc_query_field_addr.GetItemString( li_found, "lookup_type" )
	ls_fld_type = ldwc_query_field_addr.GetItemString( li_found, "field_type" )
	w_train_app.of_set_query_lookup(ls_lookup_type,ls_query_fld,ls_lookup_code,"query_value_addr") //maha 042205
END IF
end event

public function integer of_mapfieldfromsp ();//////////////////////////////////////////////////////////////////////
// $<function> of_mapfieldfromsp
// $<arguments>
// $<returns> integer
// $<description> Mapping field from screen painter
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.27.2011
//////////////////////////////////////////////////////////////////////

long ll_Row
string ls_Find
string ls_lookup_type

ll_Row = idw_field_tv.GetRow()
if ll_Row < 1 then Return -1

// Find field_name from dw_field_tv
ls_Find = "data_view_screen_screen_id=" + String(w_app_screen.il_screen_id) + " AND lower(field_name)='" + Lower(w_app_screen.is_drag_field_name) + "'"
ll_Row = idw_field_tv.Find(ls_Find, 1, idw_field_tv.RowCount())
if ll_Row > 0 then
	idw_field_tv.SetRow(ll_Row)
	ls_lookup_type = idw_field_tv.GetItemString(ll_Row, "lookup_type")
else
	Return -1
end if

// Select lookup field
if ls_lookup_type = "A" or ls_lookup_type = "C" then
	if of_SelectLookupField(ls_lookup_type) = -1 then
		Return -1
	end if
end if

// Mapping screen field
of_MapScreenField()
w_train_app.of_SetFilterFromSP()
	
Return 1
end function

public function integer of_mapscreenfield ();//====================================================================
// $<function> of_mapscreenfield()
// $<arguments>
// $<returns> integer
// $<description> Mapping screen field
// $<add> (Appeon) evan 10.27.2011
//====================================================================

Long  ll_fld_id
Long li_page_num
Long li_screen_id
Long li_tbl_id
Long li_last_app_field_id
Long li_row
long li_app_field_id
Long li_field_len
String ls_lookup_type
String ls_lu_fld_nm
String ls_field_type
String ls_sub_lookup_type
DataWindowChild dwchild

li_row = idw_field_tv.GetRow()

// Get field information
ll_fld_id = idw_field_tv.GetItemNumber( li_row, "field_id" )
li_tbl_id = idw_field_tv.GetItemNumber( li_row, "table_id" )
ls_lookup_type = idw_field_tv.GetItemString( li_row, "lookup_type" )
ls_field_type = idw_field_tv.GetItemString( li_row, "field_type" )
li_screen_id = idw_field_tv.GetItemNumber( li_row, "data_view_screen_screen_id" )
idw_fld_prop.SetItem( 1, "field_id", ll_fld_id )
idw_fld_prop.SetItem( 1, "table_id", li_tbl_id )

// if this is a field that directly references the address lookup table
IF ls_lookup_type = 'A' THEN
	idw_fld_prop.SetItem( 1, "lookup_link_field", "entity name" )
	idw_fld_prop.SetItem( 1, "lookup_link_type", "E" )
	li_field_len = 50
ELSEIF ls_lookup_type = 'C' THEN
	idw_fld_prop.SetItem( 1, "lookup_link_field", "Code" )
	idw_fld_prop.SetItem( 1, "lookup_link_type", "C" )
	li_field_len = 50	
// if this is a sub field of the lookup table
ELSEIF ls_field_type = 'AL' OR ls_field_type = 'CL' THEN	
	ls_lu_fld_nm = idw_field_tv.GetItemString( idw_field_tv.GetRow(), "field_name_allias" )
	idw_fld_prop.SetItem( 1, "lookup_link_field", ls_lu_fld_nm )
	CHOOSE CASE Upper( ls_lu_fld_nm )
		CASE "ENTITY_NAME"
			li_field_len = 35
			ls_sub_lookup_type = "A"
		CASE "STREET1", "STREET2"
			li_field_len = 35
			ls_sub_lookup_type = "A"			
		CASE "CITY"
			li_field_len = 15
			ls_sub_lookup_type = "A"			
		CASE "STATE"
			li_field_len = 2
			ls_sub_lookup_type = "A"			
		CASE "ZIP"
			li_field_len = 12
			ls_sub_lookup_type = "A"			
		CASE "COUNTRY"
			li_field_len = 10
			ls_sub_lookup_type = "A"			
		CASE "PHONE"
			li_field_len = 13
			ls_sub_lookup_type = "A"						
		CASE "FAX"
			li_field_len = 13
			ls_sub_lookup_type = "A"						
		CASE "CODE"
			li_field_len = 15
			ls_sub_lookup_type = "C"			
		CASE "DESCRIPTION"	
			li_field_len = 25		
			ls_sub_lookup_type = "C"	
		//Start Code Change ---- 10.03.2006 #644 maha
		CASE "CAQH_CODE"	
			li_field_len = 3		
			ls_sub_lookup_type = "C"
		CASE "CONTACT_NAME"	
			li_field_len = 20	
			ls_sub_lookup_type = "A"
		//End Code Change---10.03.2006
		//Start Code Change ----08.20.2008 #V85 maha - added email field
		CASE "EMAIL_ADDRESS"
			li_field_len = 30
			ls_sub_lookup_type = "A"
		//End Code Change---08.20.2008
		CASE ELSE
	END CHOOSE	
	idw_fld_prop.SetItem( 1, "lookup_link_type", ls_sub_lookup_type )
ELSE
	ls_lu_fld_nm = idw_field_tv.GetItemString( idw_field_tv.GetRow(), "data_view_fields_field_label" )
	CHOOSE CASE Upper( ls_lu_fld_nm )
		CASE "LAST NAME"
			li_field_len = 25
		CASE "STATE"
			li_field_len = 2
		CASE "CITY"
			li_field_len = 15
	END CHOOSE
	idw_fld_prop.SetItem(1, "lookup_link_type", "")
	idw_fld_prop.SetItem(1, "lookup_link_field", "")
END IF

// if it was a personal data field selected set the appropriate flags
IF li_screen_id = 27 THEN
	idw_fld_prop.SetItem( 1, "personal_data", "Y" )
ELSE
	idw_fld_prop.SetItem( 1, "personal_data", "N" )	
END IF
if li_screen_id >= 80 and li_screen_id < 90 THEN //maha 020706
	idw_fld_prop.SetItem( 1, "record_num_addr", 1 )
end if

// if there was a query on the previous selected field copy the query values over
idw_fld_prop.SetItem( 1, "record_number", w_train_app.ii_record_number )
idw_fld_prop.SetItem( 1, "query_field", w_train_app.is_query_field )	
idw_fld_prop.SetItem( 1, "query_operator", w_train_app.is_query_operator )	
idw_fld_prop.SetItem( 1, "query_value", w_train_app.is_query_value )	
//idw_fld_prop.SetItem( 1, "x_pos", 0 )	//Start Code Change ----02.28.2012 #V12 maha - removed
//idw_fld_prop.SetItem( 1, "y_pos", 0 )
idw_fld_prop.SetItem( 1, "billing_address_flag", w_train_app.ii_billing_address_flag )	
IF w_train_app.is_query_field = "" THEN
	idw_fld_prop.SetItem( 1, "record_number", 1 )		
END IF

// Update data
li_app_field_id = idw_fld_prop.GetItemNumber( 1, "app_field_id" )
idw_fld_prop.GetChild( "query_field", dwchild )
dwchild.SetTransObject( SQLCA )
gnv_appeondb.of_StartQueue()
idw_fld_prop.Update()
dwchild.Retrieve( li_tbl_id )
idw_fld_prop.Retrieve( li_app_field_id )
gnv_appeondb.of_CommitQueue()

// Set width value
IF li_field_len = 0 OR IsNull( li_field_len ) THEN	
	li_field_len = idw_fld_prop.GetItemNumber( 1, "app_fill_field_len" )
END IF
IF li_field_len = 0 OR IsNull( li_field_len ) THEN //maha 061303 if no value picked up
	li_field_len = 25
END IF
idw_fld_prop.SetItem( 1, "width", li_field_len )
idw_fld_prop.SetColumn( "record_number" )

// Update screen field label (evan 03.30.2012)
dw_field.SetItem(dw_field.GetRow(), "screen_field_label", w_train_app.st_field_name.Text)
idw_fld_prop.SetItem(1, "screen_field_label", w_train_app.st_field_name.Text)
dw_field.ResetUpdate()
idw_fld_prop.Update()

// Retrieve quick filters
w_train_app.tab_1.tabpage_design.dw_quick_filters.Event ue_RetrieveDddw()

Return 1
end function

public function integer of_selectlookupfield (string as_lookup_type);//////////////////////////////////////////////////////////////////////
// $<function> of_selectlookupfield
// $<arguments>
//		string	as_lookup_type
// $<returns> integer
// $<description> select lookup field
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.27.2011
//////////////////////////////////////////////////////////////////////

long ll_Row
long ll_field_id
string ls_Find
string ls_field_name[]
integer i, li_FieldCount
n_cst_string lnv_string

// Select lookup field
OpenWithParm(w_app_lookup_fields_sel, as_lookup_type)
if Message.StringParm = "Cancel!" then Return -1

lnv_string.of_ParseToArray(Message.StringParm, ",", ls_field_name)
li_FieldCount = UpperBound(ls_field_name)
if li_FieldCount < 1 then
	Return -1
elseif li_FieldCount > 1 then
	MessageBox("Warning", "You can only select one lookup field at a time.", Exclamation!)
	Return -1
end if

// Find lookup field from dw_field_tv
ll_Row = idw_field_tv.GetRow()
if ll_Row < 1 then Return -1
ll_field_id = idw_field_tv.GetItemNumber(ll_Row, "field_id")
ls_Find = "data_view_screen_screen_id=" + String(w_app_screen.il_screen_id) + &
			 " AND field_id = " + String(ll_field_id) + &
			 " AND lower(field_name_allias)='" + ls_field_name[1] + "'"

ll_Row = idw_field_tv.Find(ls_Find, 1, idw_field_tv.RowCount())
if ll_Row > 0 then
	idw_field_tv.SetRow(ll_Row)
else
	Return -1
end if

Return 1
end function

public function integer of_changefielddescr (string as_field_name);//////////////////////////////////////////////////////////////////////
// $<function> of_changefielddescr
// $<arguments>
//		string	as_field_name
// $<returns> integer
// $<description> change field description
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 01.06.2012
//////////////////////////////////////////////////////////////////////

choose case as_field_name
	case "site_login"
		w_train_app.st_field_name.text = "Website Login"
	case "site_password"
		w_train_app.st_field_name.text = "Website Password"
end choose

Return 1
end function

public function integer of_seterrorevent (oleobject aole_object);//////////////////////////////////////////////////////////////////////
// $<function> of_seterrorevent
// $<arguments>
//		oleobject	aole_object
// $<returns> integer
// $<description> Set window's error event
//////////////////////////////////////////////////////////////////////
// $<add> 06.21.2012 by Evan
//////////////////////////////////////////////////////////////////////

long i, ll_Len
string ls_Script
oleobject lole_frame

ls_Script = &
"function window_onerror() {return true;} " + &
"var bErrorEvent = false; " + &
"try " + &
"{ " + &
"  var nLen = window.onerror.toString().length; " + &
"  if (nLen> 0) bErrorEvent = true; " + &
"} " + &
"catch (e) " + &
"{ " + &
"} " + &
"if (bErrorEvent == false) window.onerror = window_onerror; "

try
	//---------Begin Modified by (Appeon)Stephen 11.10.2015 for Bug id 4838 - Cannot populate Web Pop Site--------
	aole_object.document.parentWindow.execScript(ls_Script, "JScript")
	//aole_object.document.parentWindow.eval(ls_Script, "JScript")
	//---------End Modfiied ------------------------------------------------------
	ll_Len = aole_object.document.frames.length
	if ll_Len > 0 then
		for i = 0 to ll_Len - 1
			lole_frame = aole_object.document.frames[i]
			of_SetErrorEvent(lole_frame)
		next
	end if
catch (RuntimeError e)
end try

Return 1
end function

public function integer of_get_screen_name ();//====================================================================
//$<Function>: of_get_screen_name
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 2013-08-07 (V141 Web Population Part 3)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
string ls_screen_name

select Data_screen into :ls_screen_name
from app_page_data where app_id = :il_curr_app_id and page = :il_Page;

//---------Begin Modified by (Appeon)Alfee 10.29.2013-----------------
//if not isnull(ls_screen_name) then
//	sle_screen.text = ls_screen_name
//else
//	sle_screen.text = ''
//end if
IF IsValid (iw_parent) THEN
	IF NOT IsNull (ls_screen_name) THEN
		iw_parent.tab_1.tabpage_design.dw_buttons_webform.SetItem(1, "data_screen", ls_screen_name)		
	ELSE
		iw_parent.tab_1.tabpage_design.dw_buttons_webform.SetItem(1, "data_screen", '')		
	END IF
	iw_parent.tab_1.tabpage_design.dw_buttons_webform.AcceptText ()
END IF
//---------End Modfiied ------------------------------------------------------

return 1

end function

public function integer of_next_prior_page (string as_dir);//Start Code Change ----10.16.2013 #V14 maha - copied from webpop object function
debugbreak()
integer li_Index

li_Index = il_page + 1

if as_dir = "U" then
	li_Index += 1
elseif as_dir = "D" then
	li_Index -= 1
end if

//---------Begin Modified by (Appeon)Alfee 10.29.2013-----------------
//ddlb_page.SelectItem(li_Index)
IF IsValid (iw_parent) THEN
	iw_parent.tab_1.tabpage_design.dw_buttons_webform.SetItem(1, "page", li_Index - 1)
	iw_parent.tab_1.tabpage_design.dw_buttons_webform.AcceptText ()
END IF
//---------End Modfiied ------------------------------------------------------

of_change_page( li_index)
//ddlb_page.Event SelectionChanged(li_Index)


return 1
end function

public function integer of_change_page (integer ai_index);//Start Code Change ----10.17.2013 #V14 maha - added - from from ddlb_page selection changed
long ll_Row

//if ai_index = 1 then return 1

il_Page = ai_Index - 1
string ls_protect
// UI setting
if il_Page = 0 then
	dw_field.Modify("screen_field_label_t.text='Login Field Label'")
	dw_field.Modify("screen_field_label.dddw.name = 'd_dddw_app_websitelogin'")
	dw_field.Modify("screen_field_label.dddw.datacolumn = 'field_name'")			
	dw_field.Modify("screen_field_label.dddw.displaycolumn = 'field_label'")
	dw_field.Modify("screen_field_label.dddw.useasborder = 'yes'")
	dw_field.Modify("screen_field_label.protect = 0")
	w_train_app.tab_1.tabpage_design.tab_fld_prop.Event ue_showtabpage(0)
else
	dw_field.Modify("screen_field_label_t.text='Screen Field Label'")
	dw_field.Modify("screen_field_label.dddw.name = ''")
	dw_field.Modify("screen_field_label.dddw.useasborder = 'no'")
	dw_field.Modify("screen_field_label.protect = 1")
	w_train_app.tab_1.tabpage_design.tab_fld_prop.Event ue_showtabpage(1)
end if

// Retrieve mapping field records
ll_Row = dw_field.GetRow()
dw_field.Retrieve(il_curr_app_id, il_Page)
dw_field.SelectRow(0, false)
dw_field.SelectRow(dw_field.GetRow(), true)

dw_page_steps.retrieve(il_curr_app_id, il_Page)  //Start Code Change ----10.17.2013 #V14 maha

// Refresh field detail
if ll_Row = 1 then
	dw_field.Event RowFocusChanged(1)
end if

of_get_screen_name() //(Appeon)Stephen 2013-08-07 - V141 Web Population Part 3

//Set the button - alfee 10.29.2013
if IsValid (iw_parent) then
	if ai_Index = 1 then
		iw_parent.tab_1.tabpage_design.dw_buttons_webform.modify("b_prior.enabled= 'false'")
	else
		iw_parent.tab_1.tabpage_design.dw_buttons_webform.modify("b_prior.enabled= 'true'")
	end if
end if

return 1

end function

public function integer of_page_notes ();//====================================================================
//$<Function>: of_page_notes()
//$<Arguments>:
//$<Return>:  integer
//$<Description>: The notes for current page
//$<Author>: (Appeon) Alfee 10.29.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>: Copied from dw_fileld.buttonclicked ()
//====================================================================
string ls_notes, ls_screen
boolean lb_new

lb_new = false
select Notes into :ls_notes from app_page_data where app_id = :il_curr_app_id and page = :il_Page;
if sqlca.sqlcode <> 0 then lb_new = true

if isnull(ls_notes) then ls_notes = ""  //(Appeon)Harry 07.16.2014 - for the Bug 4115

OpenWithParm( w_ai_notes_new, "N#" +  ls_notes)
	
IF Message.StringParm <> "Cancel" THEN
	ls_notes = Message.StringParm
	//---------Begin Modfiied by alfee 10.29.2013----------------------------	
	//ls_screen = sle_screen.text
	IF IsValid (iw_parent) THEN 
		iw_parent.tab_1.tabpage_design.dw_buttons_webform.AcceptText ()
		ls_screen = iw_parent.tab_1.tabpage_design.dw_buttons_webform.GetItemString(1, "data_screen")		
	END IF		
	//---------End Modfiied ------------------------------------------------------	
	if lb_new then
		insert into app_page_data(App_id, page, Data_screen, Notes) values(:il_curr_app_id, :il_Page, :ls_screen, :ls_notes);
	else
		update app_page_data set Data_screen = :ls_screen, Notes = :ls_notes
		where app_id = :il_curr_app_id and page = :il_Page;
	end if
	commit using sqlca;
END IF

RETURN 1
end function

public function integer of_forward_back (string as_dir);//====================================================================
//$<Function>: of_forward_back()
//$<Arguments>:
// 	value    string    as_dir
//$<Return>:  integer
//$<Description>: Forward or Back in the Web Browser
//$<Author>: (Appeon) Alfee 10.29.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>: 
//====================================================================
String ls_cmd

CHOOSE CASE Lower(as_dir)
	CASE "forward"
		ls_cmd =  "history.go(1);"
	CASE "back"
		ls_cmd = "history.go(-1);"
	CASE ELSE
		RETURN -1
END CHOOSE
		
Try

ole_browser.Object.document.parentWindow.execscript(ls_cmd,"JScript")

Catch (Throwable th1)
	RETURN -1
End Try

RETURN 1
end function

public function integer of_set_screen_name (string as_name);//====================================================================
//$<Function>: of_set_screen_name()
//$<Arguments>:
// 	value    string    as_name
//$<Return>:  integer
//$<Description>: Set the data screen name
//$<Author>: (Appeon) Alfee 10.29.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>: Copied from cb_screen.clicked ()
//====================================================================

integer li_cnt
string   ls_screen

select count(1) into :li_cnt from app_page_data where app_id = :il_curr_app_id and page = :il_Page;

ls_screen = as_name

if li_cnt < 1 then
	insert into app_page_data(App_id, page, Data_screen, Notes) values(:il_curr_app_id, :il_Page, :ls_screen, '');
else
	update app_page_data set Data_screen = :ls_screen	where app_id = :il_curr_app_id and page = :il_Page;
end if

commit using sqlca;

return 1
end function

public function integer of_page_steps ();
//====================================================================
//$<Function>: of_page_steps()
//$<Arguments>:
//$<Return>:  integer
//$<Description>: The steps for current page
//$<Author>: (Appeon) Alfee 10.29.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>: Copied from cb_steps.clicked ()
//====================================================================

long ll_row
long ll_app_field_id, ll_app_id
integer li_page, li_action_type
integer li_find, nr  //maha 10.17.2013
long ll_apspk   //maha 10.17.2013
string ls_sql, ls_field_name
string ls_object_type
gs_pass_ids lst_ids

//---------Begin Modified by (Appeon)Alfee 10.25.2013 for BugA102503---------
//<$Reason>The dw_page_steps not refreshed for new added steps
gnv_appeondb.of_StartQueue()
dw_page_steps.retrieve(il_curr_app_id, il_Page) //
select max(aps_id) into :ll_apspk from app_page_steps;
gnv_appeondb.of_CommitQueue()
//select max(aps_id) into :ll_apspk from app_page_steps;
//---------End Modfiied ----------------------------------------------------------------

if isnull(ll_apspk) then ll_apspk = 0

for ll_row = 1 to dw_field.rowcount()
	//ll_aps_id = dw_field.getitemnumber(ll_row, "app_page_steps_aps_id")
	//if isnull(ll_aps_id) or ll_aps_id = 0 then
	ll_app_id        = dw_field.getitemnumber(ll_row, "app_id")
	ll_app_field_id        = dw_field.getitemnumber(ll_row, "app_field_id")
	li_page          = dw_field.getitemnumber(ll_row, "page")
	ls_field_name = dw_field.getitemstring(ll_row, "site_field_name")
	ls_object_type= dw_field.getitemstring(ll_row, "object_type")
	choose case upper(ls_object_type)
		case 'T'  //TEXT or password or TEXTAREA
			li_action_type = 1
		case 'C' //CHECKBOX
			li_action_type = 2
		case 'R' //RADIO
			li_action_type = 3
		case 'D' //SELECT
			li_action_type = 4
		case 'S' //submit
			li_action_type = 5
		case 'B' //BUTTON - alfee 10.28.2013
			li_action_type = 6
	end choose
	
	li_find = dw_page_steps.find( "app_field_id =" + string(ll_app_field_id ), 1, dw_page_steps.rowcount() )
	
	if li_find = 0 then
		nr = dw_page_steps.insertrow(0)
		ll_apspk++
		dw_page_steps.setitem(nr, "aps_id", ll_apspk )
		dw_page_steps.setitem(nr, "app_id", ll_app_id)
		dw_page_steps.setitem(nr, "app_field_id", ll_app_field_id )
		dw_page_steps.setitem(nr, "page", li_page)
		dw_page_steps.setitem(nr, "sort_order", nr)
		dw_page_steps.setitem(nr, "element_name", ls_field_name )
		dw_page_steps.setitem(nr, "action_type", li_action_type)
	end if
next

dw_page_steps.update()
lst_ids.l_app_id = ll_app_id
lst_ids.committee_id = li_page

openwithparm(w_app_page_steps, lst_ids )

//at return
dw_page_steps.retrieve(ll_app_id, li_page) 

return 1

//		dw_field.setitem(ll_row, "app_page_steps_aps_id", dw_field.getitemnumber(ll_row, "app_field_id"))
//		
//		ls_sql = ls_sql + "insert into app_page_steps(app_id, aps_id, page, element_name, Action_type, sort_order) values(" + &
//		            string(ll_app_id)+","+string(ll_aps_id)+","+string(li_page)+",'"+ls_field_name+"',"+string(li_action_type)+","+ string(ll_row)+");"
//	else
//		ls_sql = ls_sql + "update app_page_steps set sort_order = "+string(ll_row) +" where aps_id = " +string(ll_aps_id)+";"
//	end if
//next
//
//EXECUTE Immediate :ls_sql Using Sqlca;
//IF Sqlca.SQLCode <> 0 THEN
//	rollback using sqlca;
//else
//	commit using sqlca;
//end if





end function

public function integer of_set_parent_window (w_train_app aw_win);//====================================================================
//$<Function>: of_set_parent_window()
//$<Arguments>:
// 	value    window    aw_win
//$<Return>:  integer
//$<Description>: Set Parent Window variable
//$<Author>: (Appeon) Alfee 10.29.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

iw_parent = aw_win

RETURN 1
end function

on pfc_cst_u_sitefield_mapping.create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.sle_screen=create sle_screen
this.cb_forward=create cb_forward
this.cb_back=create cb_back
this.ddlb_page=create ddlb_page
this.st_1=create st_1
this.cb_step=create cb_step
this.dw_page_steps=create dw_page_steps
this.ole_browser=create ole_browser
this.dw_field=create dw_field
this.Control[]={this.pb_1,&
this.pb_2,&
this.sle_screen,&
this.cb_forward,&
this.cb_back,&
this.ddlb_page,&
this.st_1,&
this.cb_step,&
this.dw_page_steps,&
this.ole_browser,&
this.dw_field}
end on

on pfc_cst_u_sitefield_mapping.destroy
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.sle_screen)
destroy(this.cb_forward)
destroy(this.cb_back)
destroy(this.ddlb_page)
destroy(this.st_1)
destroy(this.cb_step)
destroy(this.dw_page_steps)
destroy(this.ole_browser)
destroy(this.dw_field)
end on

type pb_1 from picturebutton within pfc_cst_u_sitefield_mapping
boolean visible = false
integer x = 1024
integer y = 20
integer width = 91
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string picturename = "Undo!"
alignment htextalign = left!
string powertiptext = "Back"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 2013-08-02 (V141 Web Population Part 3)
//--------------------------------------------------------------------
//$<Modify History>: Alfee 10.28.2013
//====================================================================
string ls_back

Try

ls_back = "history.go(-1);"
ole_browser.Object.document.parentWindow.execscript(ls_back,"JScript")

Catch (Throwable th1)
	//
End Try

end event

type pb_2 from picturebutton within pfc_cst_u_sitefield_mapping
boolean visible = false
integer x = 1106
integer y = 20
integer width = 91
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string picturename = "Redo!"
alignment htextalign = left!
string powertiptext = "Forward"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 2013-08-02 (V141 Web Population Part 3)
//--------------------------------------------------------------------
//$<Modify History>: Alfee 10.28.2013
//====================================================================
string ls_forward

Try

ls_forward = "history.go(1);"
ole_browser.Object.document.parentWindow.execscript(ls_forward,"JScript")

Catch (Throwable th1)
	//
End Try
end event

type sle_screen from singlelineedit within pfc_cst_u_sitefield_mapping
boolean visible = false
integer x = 393
integer y = 124
integer width = 809
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
integer limit = 50
borderstyle borderstyle = stylelowered!
end type

event modified;//====================================================================
//$<Event>: modified
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 2013-08-07 (V141 Web Population Part 3)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
integer li_cnt
string   ls_screen

select count(1) into :li_cnt from app_page_data 
where app_id = :il_curr_app_id and page = :il_Page;
ls_screen = sle_screen.text

if li_cnt < 1 then
	insert into app_page_data(App_id, page, Data_screen, Notes) values(:il_curr_app_id, :il_Page, :ls_screen, '');
else
	update app_page_data set Data_screen = :ls_screen
	where app_id = :il_curr_app_id and page = :il_Page;
end if
commit using sqlca;
end event

type cb_forward from commandbutton within pfc_cst_u_sitefield_mapping
boolean visible = false
integer x = 923
integer y = 20
integer width = 91
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = ">"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 2013-08-06 (V141 Web Population Part 3)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

//Start Code Change ----10.16.2013 #V14 maha - Modifed to work loke webpop object
//long ll_row
//
//ll_row = dw_field.getrow()
//if ll_row = 0 or ll_row = dw_field.rowcount() then return
//
//dw_field.RowsMove(ll_row +1, ll_row+1, primary!, dw_field, ll_row , Primary!)
//ll_row = ll_row + 1
//dw_field.selectrow(0, false)
//dw_field.selectrow(ll_row, true)
//dw_field.scrolltorow(ll_row)
//dw_field.setrow(ll_row)
//dw_field.setitemstatus(ll_row, 0, primary!, datamodified!)

of_next_prior_page("U")
//End Code Change ----10.16.2013





end event

type cb_back from commandbutton within pfc_cst_u_sitefield_mapping
boolean visible = false
integer x = 837
integer y = 20
integer width = 91
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "<"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 2013-08-06 (V141 Web Population Part 3)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
//Start Code Change ----10.16.2013 #V14 maha - Modifed to work loke webpop object
//long ll_row
//
//ll_row = dw_field.getrow()
//
//if ll_row < 2 then return
//
//dw_field.RowsMove(ll_row, ll_row, primary!, dw_field, ll_row - 1, Primary!)
//ll_row = ll_row -1
//dw_field.selectrow(0, false)
//dw_field.selectrow(ll_row, true)
//dw_field.scrolltorow(ll_row)
//dw_field.setrow(ll_row)
//dw_field.setitemstatus(ll_row, 0, primary!, datamodified!)


of_next_prior_page("D")
//End Code Change ----10.16.2013
end event

type ddlb_page from dropdownlistbox within pfc_cst_u_sitefield_mapping
boolean visible = false
integer x = 393
integer y = 20
integer width = 434
integer height = 828
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;//====================================================================
// $<event> constructor()
// $<arguments>
// $<returns> long
// $<description> V12.1 Website Population
// $<add> (Appeon) evan 10.20.2011
//====================================================================

int i

this.AddItem("Page of Login")

for i = 1 to 200  //Start Code Change ----10.17.2013 #V14 maha - changed from 100
	this.AddItem("Page " + String(i))
next
end event

event selectionchanged;//====================================================================
// $<event> selectionchanged()
// $<arguments>
//			integer index
// $<returns> long
// $<description> V12.1 Website Population
// $<add> (Appeon) evan 10.20.2011
//====================================================================

//Start Code Change ----10.17.2013 #V14 maha - modifed to call function
//long ll_Row

of_change_page(index)

//il_Page = Index - 1
//string ls_protect
//// UI setting
//if il_Page = 0 then
//	dw_field.Modify("screen_field_label_t.text='Login Field Label'")
//	dw_field.Modify("screen_field_label.dddw.name = 'd_dddw_app_websitelogin'")
//	dw_field.Modify("screen_field_label.dddw.datacolumn = 'field_name'")			
//	dw_field.Modify("screen_field_label.dddw.displaycolumn = 'field_label'")
//	dw_field.Modify("screen_field_label.dddw.useasborder = 'yes'")
//	dw_field.Modify("screen_field_label.protect = 0")
//	w_train_app.tab_1.tabpage_design.tab_fld_prop.Event ue_showtabpage(0)
//else
//	dw_field.Modify("screen_field_label_t.text='Screen Field Label'")
//	dw_field.Modify("screen_field_label.dddw.name = ''")
//	dw_field.Modify("screen_field_label.dddw.useasborder = 'no'")
//	dw_field.Modify("screen_field_label.protect = 1")
//	w_train_app.tab_1.tabpage_design.tab_fld_prop.Event ue_showtabpage(1)
//end if
//
//// Retrieve mapping field records
//ll_Row = dw_field.GetRow()
//dw_field.Retrieve(il_curr_app_id, il_Page)
//dw_field.SelectRow(0, false)
//dw_field.SelectRow(dw_field.GetRow(), true)
//
//dw_page_steps.retrieve(il_curr_app_id, il_Page)  //Start Code Change ----10.17.2013 #V14 maha
//
//// Refresh field detail
//if ll_Row = 1 then
//	dw_field.Event RowFocusChanged(1)
//end if
//
//of_get_screen_name() //(Appeon)Stephen 2013-08-07 - V141 Web Population Part 3
//
end event

type st_1 from statictext within pfc_cst_u_sitefield_mapping
boolean visible = false
integer x = 9
integer y = 36
integer width = 393
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 32891346
string text = "Website Page:"
boolean focusrectangle = false
end type

type cb_step from commandbutton within pfc_cst_u_sitefield_mapping
boolean visible = false
integer x = 37
integer y = 124
integer width = 338
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Steps"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 2013-08-06 (V141 Web Population Part 3)
//--------------------------------------------------------------------
//$<Modify History>://Start Code Change ----10.17.2013 #V14 maha - redesigned to insert into local dw and open strp window
//$<Modify History>: Replace the ll_aps_id with ll_app_field_id - Alfee 10.25.2013
//$<Modify History>: Call the function - Alfee 10.29.2013
//====================================================================
Integer li_rtn

li_rtn = of_page_steps ()

RETURN li_rtn

//long ll_row
//long ll_app_field_id, ll_app_id
//integer li_page, li_action_type
//integer li_find, nr  //maha 10.17.2013
//long ll_apspk   //maha 10.17.2013
//string ls_sql, ls_field_name
//string ls_object_type
//gs_pass_ids lst_ids
//
////---------Begin Modified by (Appeon)Alfee 10.25.2013 for BugA102503---------
////<$Reason>The dw_page_steps not refreshed for new added steps
//gnv_appeondb.of_StartQueue()
//dw_page_steps.retrieve(il_curr_app_id, il_Page) //
//select max(aps_id) into :ll_apspk from app_page_steps;
//gnv_appeondb.of_CommitQueue()
////select max(aps_id) into :ll_apspk from app_page_steps;
////---------End Modfiied ----------------------------------------------------------------
//
//if isnull(ll_apspk) then ll_apspk = 0
//
//for ll_row = 1 to dw_field.rowcount()
//	//ll_aps_id = dw_field.getitemnumber(ll_row, "app_page_steps_aps_id")
//	//if isnull(ll_aps_id) or ll_aps_id = 0 then
//	ll_app_id        = dw_field.getitemnumber(ll_row, "app_id")
//	ll_app_field_id        = dw_field.getitemnumber(ll_row, "app_field_id")
//	li_page          = dw_field.getitemnumber(ll_row, "page")
//	ls_field_name = dw_field.getitemstring(ll_row, "site_field_name")
//	ls_object_type= dw_field.getitemstring(ll_row, "object_type")
//	choose case upper(ls_object_type)
//		case 'T'  //TEXT or password or TEXTAREA
//			li_action_type = 1
//		case 'C' //CHECKBOX
//			li_action_type = 2
//		case 'R' //RADIO
//			li_action_type = 3
//		case 'D' //SELECT
//			li_action_type = 4
//		case 'S' //submit
//			li_action_type = 5
//		case 'B' //BUTTON - alfee 10.28.2013
//			li_action_type = 6
//	end choose
//	
//	li_find = dw_page_steps.find( "app_field_id =" + string(ll_app_field_id ), 1, dw_page_steps.rowcount() )
//	
//	if li_find = 0 then
//		nr = dw_page_steps.insertrow(0)
//		ll_apspk++
//		dw_page_steps.setitem(nr, "aps_id", ll_apspk )
//		dw_page_steps.setitem(nr, "app_id", ll_app_id)
//		dw_page_steps.setitem(nr, "app_field_id", ll_app_field_id )
//		dw_page_steps.setitem(nr, "page", li_page)
//		dw_page_steps.setitem(nr, "sort_order", nr)
//		dw_page_steps.setitem(nr, "element_name", ls_field_name )
//		dw_page_steps.setitem(nr, "action_type", li_action_type)
//	end if
//next
//
//dw_page_steps.update()
//lst_ids.l_app_id = ll_app_id
//lst_ids.committee_id = li_page
//
//openwithparm(w_app_page_steps, lst_ids )
//
////at return
//dw_page_steps.retrieve(ll_app_id, li_page) 
//
//
////		dw_field.setitem(ll_row, "app_page_steps_aps_id", dw_field.getitemnumber(ll_row, "app_field_id"))
////		
////		ls_sql = ls_sql + "insert into app_page_steps(app_id, aps_id, page, element_name, Action_type, sort_order) values(" + &
////		            string(ll_app_id)+","+string(ll_aps_id)+","+string(li_page)+",'"+ls_field_name+"',"+string(li_action_type)+","+ string(ll_row)+");"
////	else
////		ls_sql = ls_sql + "update app_page_steps set sort_order = "+string(ll_row) +" where aps_id = " +string(ll_aps_id)+";"
////	end if
////next
////
////EXECUTE Immediate :ls_sql Using Sqlca;
////IF Sqlca.SQLCode <> 0 THEN
////	rollback using sqlca;
////else
////	commit using sqlca;
////end if
//




end event

type dw_page_steps from datawindow within pfc_cst_u_sitefield_mapping
integer x = 151
integer y = 132
integer width = 105
integer height = 68
integer taborder = 60
string title = "none"
string dataobject = "d_app_page_steps"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type ole_browser from olecustomcontrol within pfc_cst_u_sitefield_mapping
event statustextchange ( string text )
event progresschange ( long progress,  long progressmax )
event commandstatechange ( long command,  boolean enable )
event downloadbegin ( )
event downloadcomplete ( )
event titlechange ( string text )
event propertychange ( string szproperty )
event beforenavigate2 ( oleobject pdisp,  any url,  any flags,  any targetframename,  any postdata,  any headers,  ref boolean cancel )
event newwindow2 ( ref oleobject ppdisp,  ref boolean cancel )
event navigatecomplete2 ( oleobject pdisp,  any url )
event documentcomplete ( oleobject pdisp,  any url )
event onquit ( )
event onvisible ( boolean ocx_visible )
event ontoolbar ( boolean toolbar )
event onmenubar ( boolean menubar )
event onstatusbar ( boolean statusbar )
event onfullscreen ( boolean fullscreen )
event ontheatermode ( boolean theatermode )
event windowsetresizable ( boolean resizable )
event windowsetleft ( long left )
event windowsettop ( long top )
event windowsetwidth ( long ocx_width )
event windowsetheight ( long ocx_height )
event windowclosing ( boolean ischildwindow,  ref boolean cancel )
event clienttohostwindow ( ref long cx,  ref long cy )
event setsecurelockicon ( long securelockicon )
event filedownload ( boolean activedocument,  ref boolean cancel )
event navigateerror ( oleobject pdisp,  any url,  any frame,  any statuscode,  ref boolean cancel )
event printtemplateinstantiation ( oleobject pdisp )
event printtemplateteardown ( oleobject pdisp )
event updatepagestatus ( oleobject pdisp,  any npage,  any fdone )
event privacyimpactedstatechange ( boolean bimpacted )
event setphishingfilterstatus ( long phishingfilterstatus )
event newprocess ( long lcauseflag,  oleobject pwb2,  ref boolean cancel )
event redirectxdomainblocked ( oleobject pdisp,  any starturl,  any redirecturl,  any frame,  any statuscode )
integer x = 1221
integer y = 4
integer width = 2263
integer height = 1476
integer taborder = 20
boolean bringtotop = true
boolean border = false
boolean focusrectangle = false
string binarykey = "pfc_cst_u_sitefield_mapping.udo"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
end type

event navigatecomplete2(oleobject pdisp, any url);of_SetErrorEvent(this.object) //Added by Evan 06.21.2012
end event

event doubleclicked;Parent.Event ue_Add(1)
end event

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 2013-08-02 (V141 Web Population Part 3)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
//if Upper(this.object.document.activeElement.tagName) = 'A' then
//	Parent.Event ue_Add(1)
//	return
//end if

try
	if not isvalid(this.object.document) then return
	if Upper(this.object.document.activeElement.tagName) = 'INPUT' then
		if Upper(this.object.document.activeElement.type) = 'SUBMIT' then
			Parent.Event ue_Add(1)
			return
		end if
	end if
catch (RuntimeError e)
	return
end try
	
end event

type dw_field from u_dw within pfc_cst_u_sitefield_mapping
integer width = 1202
integer height = 1476
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_app_sitefield_mapping"
boolean hscrollbar = true
end type

event constructor;call super::constructor;this.SetTransObject(SQLCA)
end event

event rowfocuschanged;call super::rowfocuschanged;long ll_Row
long ll_table_id
long ll_app_field_id

// Reset field detail
ll_Row = this.GetRow()
if ll_Row < 1 then
	Parent.Event ue_RetrieveDetail(0)
	Return	
end if
this.SelectRow(0, false)
this.SelectRow(CurrentRow, true)

// if the row is new
ll_app_field_id = this.GetItemNumber(ll_Row, "app_field_id")
if IsNull(ll_app_field_id) then Return

// Retrieve field detail
idw_fld_prop.SetRedraw(false)
Parent.Event ue_RetrieveDetail(ll_app_field_id)
Parent.Event ue_RetrieveDetailDddw()
idw_fld_prop.SetRedraw(true)
of_ChangeFieldDescr(GetItemString(ll_Row, "screen_field_label"))

// Buttion visible property
if w_train_app.li_last_fld_prop_tab = 2 then
	ll_table_id = this.GetItemNumber(ll_Row, "table_id")
	if ll_table_id = 20 then
		idw_fld_prop.Modify("b_poq.visible = 1")
		idw_fld_prop.Modify("b_aoq.visible = 1")
		idw_fld_prop.Modify("b_haq.visible = 1")
	else
		idw_fld_prop.Modify("b_poq.visible = 0")
		idw_fld_prop.Modify("b_aoq.visible = 0")
		idw_fld_prop.Modify("b_haq.visible = 0")
	end if		
end if
end event

event clicked;call super::clicked;if Row > 0 then
	this.SetRow(Row)
	if not this.IsSelected(Row) then
		this.SelectRow(Row, true)
	end if
end if
end event

event dragwithin;call super::dragwithin;if Source.ClassName() = "dw_field_tv" or Source.ClassName() = "dw_detail" then
	// Select row
	if Row >0 then
		if not IsSelected(Row) then
			this.ScrollToRow(Row)
			this.SelectRow(0, false)
			this.SelectRow(Row, true)			
		end if		
	else
		this.SelectRow(0, false)
	end if
end if
end event

event dragdrop;call super::dragdrop;//====================================================================
// $<event> dragdrop()
// $<arguments>
// 	value	dragobject	source
// 	value	long			row
// 	value	dwobject		dwo
// $<returns> long
// $<description> Mapping screen field
// $<add> (Appeon) evan 10.26.2011
//====================================================================
string ls_object_type

if this.IsSelected(Row) then
	
	//---------Begin Added by (Appeon)Stephen 2013-08-08 for V141 Web Population Part 3--------
	//submit button
	ls_object_type = this.getitemstring(row, "object_type")
	if ls_object_type = 'S' then return
	//---------End Added ------------------------------------------------------

	if Source.ClassName() = "dw_field_tv" then
		of_MapScreenField()
	elseif Source.ClassName() = "dw_detail" then
		of_MapFieldFromSP()
	end if
end if
end event

event itemchanged;call super::itemchanged;if dwo.name = "screen_field_label" then
	of_ChangeFieldDescr(data)
end if
end event

event buttonclicked;call super::buttonclicked;//====================================================================
//$<Event>: buttonclicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 2013-08-08 (V141 Web Population Part 3)
//--------------------------------------------------------------------
//$<Modify History>: Call the function - Alfee 10.29.2013 
//====================================================================
Integer li_rtn

if dwo.name = 'b_notes' then
	li_rtn = of_page_notes ()
end if

return li_rtn

//string ls_notes, ls_screen
//boolean lb_new
//
//if dwo.name = 'b_notes' then
//	lb_new = false
//	select Notes into :ls_notes from app_page_data 
//	where app_id = :il_curr_app_id and page = :il_Page;
//	
//	if sqlca.sqlcode <> 0 then lb_new = true
//	OpenWithParm( w_ai_notes_new, "N#" +  ls_notes)
//	
//	IF Message.StringParm <> "Cancel" THEN
//		ls_notes = Message.StringParm
//		ls_screen = sle_screen.text
//		if lb_new then
//			insert into app_page_data(App_id, page, Data_screen, Notes) values(:il_curr_app_id, :il_Page, :ls_screen, :ls_notes);
//		else
//			update app_page_data set Data_screen = :ls_screen, Notes = :ls_notes
//			where app_id = :il_curr_app_id and page = :il_Page;
//		end if
//		commit using sqlca;
//	end if
//end if
end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
00pfc_cst_u_sitefield_mapping.bin 
2100000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff000000010000000000000000000000000000000000000000000000000000000038e88e6001d3545300000003000001800000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000009c00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000038856f96111d0340ac0006ba9a205d74f0000000038e88e6001d3545338e88e6001d35453000000000000000000000000004f00430054004e004e00450053005400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000030000009c000000000000000100000002fffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
20ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000004c00003329000026230000000000000000000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c0460000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004c00003329000026230000000000000000000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c0460000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
10pfc_cst_u_sitefield_mapping.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
