$PBExportHeader$w_export_quick_select.srw
forward
global type w_export_quick_select from window
end type
type sle_record from editmask within w_export_quick_select
end type
type dw_properties from u_dw within w_export_quick_select
end type
type dw_screen from u_dw within w_export_quick_select
end type
type mle_filter from multilineedit within w_export_quick_select
end type
type cb_view from commandbutton within w_export_quick_select
end type
type cb_1 from commandbutton within w_export_quick_select
end type
type st_2 from statictext within w_export_quick_select
end type
type st_1 from statictext within w_export_quick_select
end type
type dw_filter from datawindow within w_export_quick_select
end type
type cbx_uselink from checkbox within w_export_quick_select
end type
type dw_facility from datawindow within w_export_quick_select
end type
type cb_clear from commandbutton within w_export_quick_select
end type
type cb_save from commandbutton within w_export_quick_select
end type
type cb_close from commandbutton within w_export_quick_select
end type
type dw_detail from u_dw within w_export_quick_select
end type
type dw_rows from datawindow within w_export_quick_select
end type
type gb_1 from groupbox within w_export_quick_select
end type
type gb_2 from groupbox within w_export_quick_select
end type
type st_3 from statictext within w_export_quick_select
end type
end forward

global type w_export_quick_select from window
integer width = 2848
integer height = 2528
boolean titlebar = true
string title = "Export Quick Select"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
sle_record sle_record
dw_properties dw_properties
dw_screen dw_screen
mle_filter mle_filter
cb_view cb_view
cb_1 cb_1
st_2 st_2
st_1 st_1
dw_filter dw_filter
cbx_uselink cbx_uselink
dw_facility dw_facility
cb_clear cb_clear
cb_save cb_save
cb_close cb_close
dw_detail dw_detail
dw_rows dw_rows
gb_1 gb_1
gb_2 gb_2
st_3 st_3
end type
global w_export_quick_select w_export_quick_select

type variables
boolean ib_added = false
long il_rec_id
long il_order_id,il_export_id,il_export_type
long il_screen_id,il_data_view_id,il_facility_id,il_table_id=0
string is_object_list[],is_drag_field_name
DataWindowChild idwc_screenid,idwc_filerid,idwc_facilityid,idwc_intcred_field
pfc_cst_nv_data_entry_functions inv_data_entry

end variables

forward prototypes
public function integer of_show_invisible (boolean ab_show)
public function integer of_enabledfacilityprop (boolean ab_setnull)
public function integer of_add_field ()
public function long of_get_id ()
public function integer of_init (long al_data_view_id)
public function string of_address_query (string as_type)
public function integer of_check_data ()
public function integer of_save_data ()
public function integer of_set_uselink (long al_table_id)
public function integer of_save_data_alt ()
end prototypes

public function integer of_show_invisible (boolean ab_show);//////////////////////////////////////////////////////////////////////
// $<function> of_add_field
// $<arguments>
//			ab_show
// $<returns> integer
// $<description> 
//////////////////////////////////////////////////////////////////////
// $<add> Michael 07.03.2012 V12.2 Export Quick Select
//////////////////////////////////////////////////////////////////////
Integer li_rc
Integer i
String ls_fld

dw_properties.SetFilter("")
dw_properties.Filter( )
li_rc = dw_properties.RowCount()

FOR i = 1 TO li_rc
	IF dw_properties.GetItemString( i, "data_view_fields_visible" ) = "Y" THEN
		CONTINUE
	END IF
	ls_fld = dw_properties.GetItemString( i, "sys_fields_field_name" )
	IF NOT ab_show THEN
		dw_detail.Modify( ls_fld + ".Visible = 1")	
		dw_detail.Modify( ls_fld + "_t.Visible = 1")	
	ELSE
		dw_detail.Modify( ls_fld + ".Visible = 0")	
		dw_detail.Modify( ls_fld + "_t.Visible = 0")			
	END IF
END FOR

RETURN 1
end function

public function integer of_enabledfacilityprop (boolean ab_setnull);//////////////////////////////////////////////////////////////////////
// $<function> of_enabledfacilityprop
// $<arguments>
//			boolean	ab_setnull
// $<returns> integer
// $<description> 
//////////////////////////////////////////////////////////////////////
// $<add> Michael 06.25.2012 V12.2 Export Quick Select
//////////////////////////////////////////////////////////////////////

long ll_Null
long ll_Row

//long ll_table_id_arr[] = {16,20,29,32,44,45,46,47,48,49,50,51,52,53,61,62,65}
//long ll_table_id_arr[] = {16,20,29,32,43,44,45,46,47,48,49,50,51,52,53,61,62,65,70,71} //alfee 11.25.2009
long ll_table_id_arr[] = {2,9,16,20,29,32,43,44,45,46,47,48,49,50,51,52,53,61,62,65,70,71}  //Start Code Change ----11.04.2011 #V12 maha - added for Specialty and Hosp
integer i, li_Count
boolean lb_HaveFacilityID = false


if IsNull(il_table_id) then Return -1

// Checks facility_id field if exists
li_Count = UpperBound(ll_table_id_arr[])
for i = 1 to li_Count
	if il_table_id = ll_table_id_arr[i] then
		lb_HaveFacilityID = true
		Exit
	end if
next

// Enabled faicility_id field according to lb_HaveFacilityID value
if lb_HaveFacilityID then
	dw_facility.enabled = true
else
	if ab_SetNull then
		SetNull(ll_Null)
		il_facility_id = ll_Null
		dw_facility.setitem(dw_facility.getrow(),'facility_name','')
	end if
		dw_facility.enabled = false
end if

Return 1
end function

public function integer of_add_field ();//////////////////////////////////////////////////////////////////////
// $<function> of_add_field
// $<arguments>
// $<returns> integer
// $<description> Add selected field
//////////////////////////////////////////////////////////////////////
// $<add> Michael 07.02.2012 V12.2 Export Quick Select
// $<Modify> Alfee 09.05.2012 
// $<Modify> Maha 09.17.2012 
// $<Modify> Maha 09.18.2012
//////////////////////////////////////////////////////////////////////
Long ll_row, ll_find, ll_field_len, ll_findrow
Long ll_intcred_field
String ls_lu_field, ls_criteria 

//check duplicate  //Start Code Change ----09.18.2012 #V12 maha - readded to trap against duplicating field.
ll_findrow = dw_rows.find("export_field_name = '" + is_drag_field_name + "'",1,dw_rows.rowcount())
if ll_findrow >0 then return 0

//Find field and get the properties
ls_criteria = "sys_fields_table_id = " + String(il_table_id) + " AND upper(sys_fields_field_name) = '" + Upper(is_drag_field_name) + "'"
ll_find = dw_properties.Find(ls_criteria, 1, dw_properties.RowCount()) 
IF IsNull(ll_find) OR ll_find < 1 THEN RETURN -1

ll_intcred_field = dw_properties.GetItemNumber(ll_find,"sys_fields_field_id")
//ll_field_len = dw_properties.GetItemNumber(ll_find,"sys_fields_field_len")
ll_field_len = dw_properties.GetItemNumber(ll_find,"sys_fields_app_fill_field_len")  //Start Code Change ----09.17.2012 #V12 maha - changed from field length
IF dw_properties.GetItemString(ll_find,"sys_fields_lookup_type") = "A" or dw_properties.GetItemString(ll_find,"sys_fields_lookup_type") = "C" THEN
	ls_lu_field = dw_properties.GetItemString(ll_find,"sys_fields_lookup_field_name")
	if upper(ls_lu_field) = "ENTITY_NAME" and ll_field_len < 15 then ll_field_len = 35   //Start Code Change ----09.17.2012 #V12 maha - set default for small values
ELSE
	SetNull (ls_lu_field)
END IF

//Add field and set the properties
ll_row = dw_rows.InsertRow(0)
dw_rows.ScrollToRow(ll_row) //alfee 09.05.2012
dw_rows.SetItem(ll_row, "export_id", il_export_id )
dw_rows.SetItem(ll_row, "intcred_table",il_table_id)
dw_rows.SetItem(ll_row, "intcred_field",ll_intcred_field)
dw_rows.SetItem(ll_row, "export_code",0 )
dw_rows.SetItem(ll_row, "export_fixed","N" )
dw_rows.SetItem(ll_row, "use_link", 0 )
dw_rows.SetItem(ll_row, "use_default", 0 )
dw_rows.SetItem(ll_row, "export_type", 1 )
dw_rows.SetItem(ll_row, "intcred_record_number", 1 )
dw_rows.SetItem(ll_row, "export_fields_billing_link", 0 )
dw_rows.SetItem(ll_row, "export_field_length", ll_field_len )	
dw_rows.SetItem(ll_row, "export_field_name", is_drag_field_name)
dw_rows.SetItem(ll_row, "module_type", il_export_type )
dw_rows.SetItem(ll_row, "lu_field_name", ls_lu_field )
dw_rows.SetItem(ll_row, "drop_column", 0 )
RETURN  1


//long ll_row
//long ll_findrow = 0,ll_count = 0
//long ll_intcred_field
//long ll_find  //maha 07.23.2012
//string ls_lu_field //maha 07.23.2012
////check duplicate
//ll_findrow = dw_rows.find("export_field_name = '" + is_drag_field_name + "'",1,dw_rows.rowcount())
//if ll_findrow >0 then return 0
//gnv_appeondb.of_startqueue( )
////select count(rec_id) into :ll_count from export_fields where export_id = :il_export_id and export_field_name = :is_drag_field_name;
//select field_id into :ll_intcred_field from sys_fields where table_id = :il_table_id and field_name = :is_drag_field_name;
//gnv_appeondb.of_commitqueue( )
////if ll_count > 0 then return 0  //Start Code Change ----07.23.2012 #V12 maha - removed becaues duplicate fields are allowed.
//
////add field
//ll_row = dw_rows.insertrow(0)
//il_order_id = il_order_id + 1 
//dw_rows.SetItem(ll_row, "export_id", il_export_id )
//dw_rows.SetItem(ll_row, "export_order", il_order_id )
//dw_rows.SetItem(ll_row, "intcred_table",il_table_id)
//dw_rows.SetItem(ll_row, "intcred_field",ll_intcred_field)
//dw_rows.SetItem(ll_row, "export_code",0 )
//dw_rows.SetItem(ll_row, "export_fixed","N" )
//dw_rows.SetItem(ll_row, "use_link", 0 )
//dw_rows.SetItem(ll_row, "use_default", 0 )
//dw_rows.SetItem(ll_row, "export_field_length", 15 )
//dw_rows.SetItem(ll_row, "export_type", 1 )
//dw_rows.SetItem(ll_row, "intcred_record_number", 1 )
//dw_rows.SetItem(ll_row, "export_fields_billing_link", 0 )
//dw_rows.SetItem(ll_row, "export_field_name", is_drag_field_name)
//dw_rows.SetItem(ll_row, "module_type", il_export_type )
//debugbreak()
// //Start Code Change ----07.23.2012 #V12 maha - set the lookup field from the properties
//ll_find = dw_properties.find("sys_fields_field_id = " + string(ll_intcred_field),1, dw_properties.rowcount())
//
//if ll_find > 0 then
//	if dw_properties.getitemstring(ll_find,"sys_fields_lookup_type") = "A" or dw_properties.getitemstring(ll_find,"sys_fields_lookup_type") = "C" then
//		ls_lu_field = dw_properties.getitemstring(ll_find,"sys_fields_lookup_field_name")
//		dw_rows.SetItem(ll_row, "lu_field_name", ls_lu_field )
//	end if
//end if
////End Code Change ----07.23.2012
//ib_added = true  //Start Code Change ----08.02.2012 #V12 maha 
//
//return 1
end function

public function long of_get_id ();//////////////////////////////////////////////////////////////////////
// $<function> of_add_field
// $<arguments>
//			
// $<returns>long
// $<description> 
//////////////////////////////////////////////////////////////////////
// $<add> Michael 07.03.2012 V12.2 Export Quick Select
//////////////////////////////////////////////////////////////////////
long ll_rec

select max(rec_id) into :ll_rec from export_fields; 
if isnull(ll_rec) then ll_rec = 0  //Start Code Change ---- 06.06.2006 #515 maha  trap if no fields exist
ll_rec++

return ll_rec 
end function

public function integer of_init (long al_data_view_id);//////////////////////////////////////////////////////////////////////
// $<function> of_init
// $<arguments>
//			long al_data_view_id
// $<returns> integer
// $<description> init
//////////////////////////////////////////////////////////////////////
// $<add> Michael 07.05.2012 V12.2 Export Quick Select
//////////////////////////////////////////////////////////////////////


dw_screen.reset()
dw_screen.insertrow(0)
dw_screen.GetChild('screen_id', idwc_screenid)
idwc_screenid.settransobject(sqlca)
idwc_screenid.retrieve(al_data_view_id)
il_data_view_id = al_data_view_id

dw_filter.reset()
dw_filter.InsertRow(0)
dw_filter.GetChild("filter_id", idwc_filerid)
idwc_filerid.SetTransObject(SQLCA)
idwc_filerid.reset()

dw_facility.reset()
dw_facility.insertrow(0)
dw_facility.GetChild("facility_name", idwc_facilityid)
idwc_facilityid.SetTransObject(SQLCA)
idwc_facilityid.Retrieve(gs_user_id)

dw_detail.reset()
dw_rows.reset()
mle_filter.text = ''
return 1
end function

public function string of_address_query (string as_type);//////////////////////////////////////////////////////////////////////
// $<function> of_address_query
// $<arguments>
//               string as_type
// $<returns> (None)
// $<description> V12.2 Export quick select filters
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Stephen 08.14.2012
//////////////////////////////////////////////////////////////////////

string ls_query
long ll_rec_id
string ls_error


CHOOSE CASE (as_type )
	//primary office
	CASE "647"
		ls_query = "pd_address_link.primary_office = 1"
	//additional office
	CASE "256"
		ls_query = "pd_address_link.additional_office = 1"
	//home addrss
	CASE "648"
		ls_query = "pd_address_link.home_address =  1"
	CASE "24472"
		ls_query = "pd_address_link.billing =  1"					
	CASE "24477"
		ls_query = "pd_address_link.mailing =  1"	
	case "24490"
		ls_query = "pd_address_link.exp_letters =  1"
	CASE ELSE
		ls_query = "ERROR"			
END CHOOSE

cbx_uselink.checked = true
	
return ls_query
//End Code Change---02.01.2006
end function

public function integer of_check_data ();//////////////////////////////////////////////////////////////////////
// $<function> of_check_data
// $<arguments>
// $<RETURNs> integer
// $<description> Verify the data
//////////////////////////////////////////////////////////////////////
// $<add> Alfee 09.05.2012 V12.2 Export Quick Select 
//////////////////////////////////////////////////////////////////////
Integer li_pos, li_result
integer li_up	 //maha 09.17.2012
integer li_match	 //maha 09.17.2012
Long ll_cnt, ll_i, ll_row_cnt
String ls_export_field_name, ls_field_1
datawindow ldw_fld_list

IF IsValid( w_export_painter) THEN 
	 ldw_fld_list = w_export_painter.tab_1.tabpage_field_data.dw_fld_list
	ll_row_cnt = ldw_fld_list.RowCount()
END IF	

dw_rows.AcceptText()
ll_cnt = dw_rows.RowCount()
FOR ll_i = 1 TO ll_cnt
	li_result = 1
	li_up = 1
	li_match = 0
	ls_export_field_name = dw_rows.GetItemString(ll_i, 'export_field_name')

	IF Len(Trim(ls_export_field_name)) < 1 THEN
		Messagebox("Invalid Column Name","The Export Column Name cannot be empty.")
		li_result = -1				
		EXIT
	END IF

	li_pos = PosA(Trim(ls_export_field_name),' ')
	IF li_pos > 0 THEN
		MessageBox("Invalid Column Name","The Export Column Name cannot contain space.")
		li_result = -1				
		EXIT
	END IF
	
	IF IsNumber(MidA(ls_export_field_name,1,1)) THEN
		MessageBox("Invalid Column Name","The Export Column Name cannot start with a number")
		li_result = -1				
		EXIT
	END IF
//Start Code Change ----09.17.2012 #V12 maha - modified to create unique name rather than error
	IF ll_i <> ll_cnt AND dw_rows.Find ('upper(export_field_name) = "'  + Upper(ls_export_field_name) + '"', ll_i + 1, ll_cnt) > 0  THEN
//		MessageBox("Invalid Column Name","The Export Column Name cannot be duplicate.")
//		li_result = -1				
//		EXIT	
		ls_export_field_name = ls_export_field_name + "_1"  //Start Code Change ----09.17.2012 #V12 maha
		li_match = dw_rows.Find ('upper(export_field_name) = "'  + Upper(ls_export_field_name) + '"', ll_i + 1, ll_cnt) 
		do until li_match = 0
			li_up++
			ls_export_field_name = ls_export_field_name + "_" + string(li_up)  //Start Code Change ----09.17.2012 #V12 maha
			li_match = dw_rows.Find ('upper(export_field_name) = "'  + Upper(ls_export_field_name) + '"', ll_i + 1, ll_cnt) 
		loop
		dw_rows.SetItem(ll_i, 'export_field_name', ls_export_field_name)
	END IF
debugbreak()
	IF ll_row_cnt > 0 AND ldw_fld_list.Find ('upper(export_field_name) = "' + Upper(ls_export_field_name) + '"', 1, ll_row_cnt) > 0 THEN
//		MessageBox("Invalid Column Name","The Export Column Name cannot be duplicate.")
//		li_result = -1
//		EXIT		
		ls_export_field_name = ls_export_field_name + "_1" //Start Code Change ----09.17.2012 #V12 maha
		li_match = ldw_fld_list.Find ('upper(export_field_name) = "'  + Upper(ls_export_field_name) + '"', 1, ll_row_cnt)
		do until li_match  = 0
			li_up++
			ls_export_field_name = ls_export_field_name + "_" + string(li_up)  //Start Code Change ----09.17.2012 #V12 maha
			li_match =ldw_fld_list.Find ('upper(export_field_name) = "'  + Upper(ls_export_field_name) + '"',1, ll_row_cnt)
		loop
		dw_rows.SetItem(ll_i, 'export_field_name', ls_export_field_name)
	END IF
NEXT

IF li_result = -1 THEN
	dw_rows.setfocus()
	IF ll_i <= ll_cnt THEN dw_rows.SetRow(ll_i)
	dw_rows.SetColumn('export_field_name')
	RETURN -1
END IF	

RETURN 1
end function

public function integer of_save_data ();//////////////////////////////////////////////////////////////////////
// $<function> of_save_data
// $<arguments>
// $<RETURNs> integer
// $<description> Save data for selected fields
//////////////////////////////////////////////////////////////////////
// $<add> Alfee 09.05.2012 V12.2 Export Quick Select 
//Copied and modified from cb_save.clicked ()
//////////////////////////////////////////////////////////////////////
Long ll_i, ll_rtn
Long ll_uselink, ll_record
Long ll_order, ll_rec_id

IF dw_rows.RowCount() < 1 THEN RETURN 0

//Check data
IF of_check_data () < 0 THEN RETURN -1

//Get export_order and rec_id
SELECT Max(export_order) INTO :ll_order FROM export_fields WHERE export_id = :il_export_id;
IF IsNull(ll_order) THEN ll_order = 0
ll_record = Long(sle_record.text)
IF cbx_uselink.checked THEN ll_uselink = 1 
ll_rec_id = of_get_id()

//Set common settings
FOR ll_i = 1 TO dw_rows.RowCount()
	ll_order++
	dw_rows.SetItem(ll_i, "export_order", ll_order )
	dw_rows.SetItem(ll_i, "rec_id", ll_rec_id )
	dw_rows.setitem(ll_i, 'filter_query', mle_filter.text) 
	dw_rows.setitem(ll_i, 'facility_id', il_facility_id)
	dw_rows.setitem(ll_i, 'use_link',ll_uselink)
	dw_rows.setitem(ll_i, 'intcred_record_number',ll_record)
	dw_rows.setitem(ll_i, 'trailing_leading_characters','') 
	ll_rec_id ++
NEXT

//Update data
ll_rtn = dw_rows.Update () 
IF ll_rtn = -1 THEN
	MessageBox("Error", "Failed to save data. ~r~n " + SQLCA.SQLErrText, StopSign!)	
ELSE
	dw_rows.Reset ()
END IF 

//Refresh export fields
IF IsValid(w_export_painter) THEN
	w_export_painter.tab_1.tabpage_field_data.dw_fld_list.Retrieve(il_export_id )
END IF

RETURN ll_rtn
end function

public function integer of_set_uselink (long al_table_id);//////////////////////////////////////////////////////////////////////
// $<function> of_set_uselink
// $<arguments>
//			long	al_table_id
// $<returns> integer
// $<description> Set the use_link field based on the table id
//////////////////////////////////////////////////////////////////////
// $<add> Alfee 09.05.2012 V12.2 Export Quick Select
//////////////////////////////////////////////////////////////////////

IF al_table_id = 2 OR al_table_id = 9 OR al_table_id = 20 THEN
	cbx_uselink.visible = True
ELSE
	cbx_uselink.visible = False
END IF

RETURN 1
end function

public function integer of_save_data_alt ();
long ll_uselink,ll_record,ll_i,ll_rtn
long ll_order //maha 08.23.2012

if dw_rows.rowcount() < 1 then return -1

//Check data
IF of_check_data () < 0 THEN RETURN -1

if cbx_uselink.checked then
	ll_uselink = 1 
else
	ll_uselink = 0
end if
ll_record = long(sle_record.text)

il_rec_id = of_get_id()

//Start Code Change ----07.23.2012 #V12 maha - set order at save
select max(export_order) into :ll_order from export_fields where export_id = :il_export_id;
if isnull(ll_order) then ll_order = 0

//setting common settings
for ll_i = 1 to dw_rows.rowcount()
	ll_order++
	dw_rows.SetItem(ll_i, "export_order", ll_order )
//End Code Change ----07.23.2012	
	dw_rows.SetItem(ll_i, "rec_id", il_rec_id )
	dw_rows.setitem(ll_i,'filter_query', mle_filter.text) 
	dw_rows.setitem(ll_i,'facility_id', il_facility_id)
	dw_rows.setitem(ll_i,'use_link',ll_uselink)
	dw_rows.setitem(ll_i,'intcred_record_number',ll_record)
	dw_rows.setitem(ll_i,'trailing_leading_characters','') //add by stephen 08.14.2012 -set trailing_leading_characters //maha 08.15.2012 modified to empty string
	//---------Begin Added by (Appeon)Harry 08.05.2014 for BugS072301 in V14.2 Issues of New Feature--------
	if il_export_type = 5 or il_export_type = 6 then
		dw_rows.setitem(ll_i, 'module_type', 1)
	end if
	//---------End Added ------------------------------------------------------
	il_rec_id++
next

//save data
ll_rtn = dw_rows.update(true,false) ////Start Code Change ----07.23.2012 #V12 maha - modified to not reset the flags
if ll_rtn = 1 then
	commit;
	w_export_painter.tab_1.tabpage_field_data.dw_fld_list.Retrieve(il_export_id )
	//messagebox('Save','Saved successfully.')
else
	rollback;
	MessageBox("Error", "Failed to save data.", StopSign!)
end if

ib_added = false  //Start Code Change ----08.02.2012 #V12 maha



return 1
end function

on w_export_quick_select.create
this.sle_record=create sle_record
this.dw_properties=create dw_properties
this.dw_screen=create dw_screen
this.mle_filter=create mle_filter
this.cb_view=create cb_view
this.cb_1=create cb_1
this.st_2=create st_2
this.st_1=create st_1
this.dw_filter=create dw_filter
this.cbx_uselink=create cbx_uselink
this.dw_facility=create dw_facility
this.cb_clear=create cb_clear
this.cb_save=create cb_save
this.cb_close=create cb_close
this.dw_detail=create dw_detail
this.dw_rows=create dw_rows
this.gb_1=create gb_1
this.gb_2=create gb_2
this.st_3=create st_3
this.Control[]={this.sle_record,&
this.dw_properties,&
this.dw_screen,&
this.mle_filter,&
this.cb_view,&
this.cb_1,&
this.st_2,&
this.st_1,&
this.dw_filter,&
this.cbx_uselink,&
this.dw_facility,&
this.cb_clear,&
this.cb_save,&
this.cb_close,&
this.dw_detail,&
this.dw_rows,&
this.gb_1,&
this.gb_2,&
this.st_3}
end on

on w_export_quick_select.destroy
destroy(this.sle_record)
destroy(this.dw_properties)
destroy(this.dw_screen)
destroy(this.mle_filter)
destroy(this.cb_view)
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_filter)
destroy(this.cbx_uselink)
destroy(this.dw_facility)
destroy(this.cb_clear)
destroy(this.cb_save)
destroy(this.cb_close)
destroy(this.dw_detail)
destroy(this.dw_rows)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.st_3)
end on

event open;string ls_parm

//get parm
ls_parm = message.stringparm
il_order_id = long(left(ls_parm, pos(ls_parm,"|") - 1))
il_export_id = long(mid(ls_parm, pos(ls_parm,"|") + 1, pos(ls_parm,"!") - pos(ls_parm,"|") - 1))
il_export_type = long(mid(ls_parm, pos(ls_parm,"!") + 1, len(ls_parm) - pos(ls_parm,"!")))

//init
of_init(gl_data_view_id)

inv_data_entry = create pfc_cst_nv_data_entry_functions
inv_data_entry.of_setup_cache()
inv_data_entry.of_refresh_cache() 
end event

event closequery;//Start Code Change ----07.23.2012 #V12 maha - removed
//int li_mes
//
//If dw_rows.modifiedcount() > 0 Or dw_rows.deletedcount() > 0 Then
//	li_mes = messagebox('Save','Do you want to save changes?',Question!,YesNoCancel!)
//	if li_mes =  1 then
//		cb_save.event clicked()
//		return 0
//	elseif li_mes = 2 then
//		return 0
//	elseif li_mes = 3 then
//		return 1
//	end if
//end if
//
//return 0
end event

event close;if isvalid(inv_data_entry) then destroy inv_data_entry
 
end event

type sle_record from editmask within w_export_quick_select
integer x = 2043
integer y = 436
integer width = 165
integer height = 76
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "1"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "#####"
end type

type dw_properties from u_dw within w_export_quick_select
boolean visible = false
integer x = 2002
integer y = 2076
integer width = 457
integer height = 164
integer taborder = 0
string dataobject = "d_sys_field_properties"
end type

event constructor;call super::constructor;This.of_SetTransObject( SQLCA )
end event

type dw_screen from u_dw within w_export_quick_select
integer x = 96
integer y = 52
integer width = 937
integer height = 84
integer taborder = 10
string dataobject = "d_qk_export_screen"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;long li_col_cnt,i
int li_mes
string ls_screen_name

//Prompt the need to save
//If dw_rows.modifiedcount() > 0 Or dw_rows.deletedcount() > 0 Then
//If ib_added then	//Start Code Change ----08.02.2012 #V12 maha 
if dw_rows.rowcount() > 0 then //alfee 09.05.2012
	li_mes = messagebox('Save','Do you want to Add the selected records?',Question!,YesNo!)
	if li_mes =  1 then
		cb_save.event clicked()
	end if
else 
	//ib_added = false  - commented by alfee 09.05.2012
end if

dw_rows.reset()

parent.setredraw( false)

//retrieve filter dddw
il_screen_id = long(data)
dw_filter.reset()
dw_filter.InsertRow(0)
mle_filter.text = ""	//long.zhang 09.03.2012 BugS071702
idwc_filerid.Retrieve(il_screen_id)
il_table_id = idwc_screenid.getitemnumber( idwc_screenid.getrow(),'table_id')

//set the use_link field - alfee 09.05.2012
of_set_uselink(il_table_id)

//set facility dddw enable
of_enabledfacilityprop(true)

//create dw
inv_data_entry.of_create_dynamic_dw(0, il_data_view_id, il_screen_id, dw_detail, dw_detail, True, 0 , true)

//set field protect
li_col_cnt = Integer(dw_detail.Describe("DataWindow.Column.Count"))
FOR i = 1 TO li_col_cnt
	is_object_list[i] = dw_detail.GetColumnName()	
	dw_detail.Modify(is_object_list[i]+".Protect=1")
END FOR

//set vscrollbar
//ls_screen_name = idwc_screenid.getitemstring( row, "screen_name" )
//IF ls_screen_name = "Address" OR ls_screen_name = "Claims" THEN
//	dw_detail.vscrollbar = True
//ELSE
//	dw_detail.vscrollbar = False
//END IF
//
//set field visible property
dw_properties.Retrieve(il_data_view_id,il_screen_id)
of_show_invisible(True)
parent.setredraw( true)
end event

type mle_filter from multilineedit within w_export_quick_select
integer x = 96
integer y = 300
integer width = 2619
integer height = 132
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean autovscroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_view from commandbutton within w_export_quick_select
integer x = 1093
integer y = 64
integer width = 361
integer height = 84
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Change &View"
end type

event clicked;
Integer li_pos
String ls_msg
String ls_data_view_name

//---------Begin Added by alfee 09.05.2012 ---------------
IF dw_rows.rowcount() > 0 THEN 
	IF MessageBox('Save','Do you want to Add the selected records?',Question!,YesNo!) =  1 THEN
		IF of_save_data() < 0 THEN RETURN
	ELSE
		dw_rows.reset()
	END IF
END IF
//----------End Added ----------------------------------------

Open( w_select_view )
IF Message.StringParm = "Cancel" THEN
	Return -1
ELSE
	ls_msg = Message.StringParm
	li_pos = PosA( ls_msg, '~t' )
	il_data_view_id = Long( LeftA( ls_msg, li_pos - 1 ) ) 
	ls_data_view_name = RightA( ls_msg, LenA( ls_msg ) - li_pos )
END IF

//cb_save.event clicked() - commented by alfee 09.05.2012

of_init(il_data_view_id)


end event

type cb_1 from commandbutton within w_export_quick_select
integer x = 1106
integer y = 216
integer width = 338
integer height = 72
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Filter Wizard"
end type

event clicked;string ls_mess

if il_table_id = 0 or isnull(il_table_id)then
	return
else	
	ls_Mess = "PD_EXPORT|" + String(il_table_id) + "|NULL|NULL"
	OpenWithParm(w_query_wizard, ls_Mess)	
	ls_mess = message.stringparm
	if ls_mess = "Cancel" then
		return
	else
		mle_filter.text = ls_mess
	end if
end if


end event

type st_2 from statictext within w_export_quick_select
integer x = 91
integer y = 448
integer width = 183
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Facility:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_export_quick_select
integer x = 1742
integer y = 448
integer width = 233
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Record #"
boolean focusrectangle = false
end type

type dw_filter from datawindow within w_export_quick_select
integer x = 87
integer y = 212
integer width = 997
integer height = 80
integer taborder = 30
string title = "none"
string dataobject = "d_select_filter"
boolean border = false
boolean livescroll = true
end type

event itemchanged;string ls_screen_field,ls_operator,ls_filter_value
long   ll_screen

ls_screen_field = trim(idwc_filerid.GetItemString(idwc_filerid.GetRow(), "screen_field"))
ls_operator = trim(idwc_filerid.GetItemString(idwc_filerid.GetRow(), "operator"))
ls_filter_value = trim(idwc_filerid.GetItemString(idwc_filerid.GetRow(),"filter_value"))

//------------------- APPEON BEGIN -------------------
//$<modify> Stephen 08.14.2012
//$<reason> V12.2 Export quick select filters
/*
mle_filter.text = ls_screen_field + ls_operator + ls_filter_value
*/
ll_screen = idwc_filerid.GetItemnumber(idwc_filerid.GetRow(),"screen_id")
choose  case ll_screen
	case 2
		if ls_screen_field = 'address_type' then
	       mle_filter.text = of_address_query(ls_filter_value)
		else
			mle_filter.text = ls_screen_field + ls_operator + ls_filter_value
		end if
	case 7
		if ls_screen_field = 'training_type' then
			mle_filter.text =  'train_type' + ls_operator + ls_filter_value
		else
			mle_filter.text = ls_screen_field + ls_operator + ls_filter_value
		end if
	case else
		mle_filter.text = ls_screen_field + ls_operator + ls_filter_value
end choose
//------------------- APPEON END -------------------
end event

type cbx_uselink from checkbox within w_export_quick_select
boolean visible = false
integer x = 1376
integer y = 448
integer width = 293
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Use link"
boolean lefttext = true
end type

type dw_facility from datawindow within w_export_quick_select
integer x = 279
integer y = 440
integer width = 992
integer height = 76
integer taborder = 60
string title = "none"
string dataobject = "d_facility_select"
boolean border = false
boolean livescroll = true
end type

event itemchanged;il_facility_id = idwc_facilityid.getitemnumber( idwc_facilityid.getrow(), 'facility_id')
end event

type cb_clear from commandbutton within w_export_quick_select
integer x = 2094
integer y = 64
integer width = 343
integer height = 84
integer taborder = 140
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Clea&r"
end type

event clicked;dw_rows.reset()
end event

type cb_save from commandbutton within w_export_quick_select
integer x = 1678
integer y = 64
integer width = 416
integer height = 84
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add to Export "
end type

event clicked;//Add to Export - Modified by alfee 09.05.2012

RETURN of_save_data_alt( )

//long ll_uselink,ll_record,ll_i,ll_rtn
//long ll_order //maha 08.23.2012
//
//if dw_rows.rowcount() < 1 then return
//
//
//if cbx_uselink.checked then
//	ll_uselink = 1 
//else
//	ll_uselink = 0
//end if
//ll_record = long(sle_record.text)
//
//il_rec_id = of_get_id()
//
////Start Code Change ----07.23.2012 #V12 maha - set order at save
//select max(export_order) into :ll_order from export_fields where export_id = :il_export_id;
//if isnull(ll_order) then ll_order = 0
//
////setting common settings
//for ll_i = 1 to dw_rows.rowcount()
//	ll_order++
//	dw_rows.SetItem(ll_i, "export_order", ll_order )
////End Code Change ----07.23.2012	
//	dw_rows.SetItem(ll_i, "rec_id", il_rec_id )
//	dw_rows.setitem(ll_i,'filter_query', mle_filter.text) 
//	dw_rows.setitem(ll_i,'facility_id', il_facility_id)
//	dw_rows.setitem(ll_i,'use_link',ll_uselink)
//	dw_rows.setitem(ll_i,'intcred_record_number',ll_record)
//	dw_rows.setitem(ll_i,'trailing_leading_characters','') //add by stephen 08.14.2012 -set trailing_leading_characters //maha 08.15.2012 modified to empty string
//	il_rec_id++
//next
//
////save data
//ll_rtn = dw_rows.update(true,false) ////Start Code Change ----07.23.2012 #V12 maha - modified to not reset the flags
//if ll_rtn = 1 then
//	commit;
//	w_export_painter.tab_1.tabpage_field_data.dw_fld_list.Retrieve(il_export_id )
//	//messagebox('Save','Saved successfully.')
//else
//	rollback;
//	MessageBox("Error", "Failed to save data.", StopSign!)
//end if
//
//ib_added = false  //Start Code Change ----08.02.2012 #V12 maha
end event

type cb_close from commandbutton within w_export_quick_select
integer x = 2437
integer y = 64
integer width = 343
integer height = 84
integer taborder = 150
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

type dw_detail from u_dw within w_export_quick_select
integer x = 55
integer y = 536
integer width = 2720
integer height = 1372
integer taborder = 90
string dragicon = "droparrow.ico"
end type

event itemchanged;call super::itemchanged;return 1
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
// Add by Appeon: Michael 07.02.2012
//////////////////////////////////////////////////////////////////////

if dwo.type = "column" then
	is_drag_field_name = dwo.name
	this.Drag(Begin!)
	
else
	is_drag_field_name = ""
end if
end event

event doubleclicked;call super::doubleclicked;//////////////////////////////////////////////////////////////////////
// $<event> doubleclicked
// $<arguments>
//		integer	xpos
//		integer	ypos
//		long		row
//		dwobject	dwo
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon:  Michael 07.02.2012
//////////////////////////////////////////////////////////////////////

if dwo.type = "column" then
	is_drag_field_name = dwo.name	
	of_add_field()
else
	is_drag_field_name = ""
end if
end event

type dw_rows from datawindow within w_export_quick_select
integer x = 59
integer y = 1924
integer width = 2720
integer height = 512
integer taborder = 100
string dragicon = "droparrow.ico"
string title = "none"
string dataobject = "d_export_flds_quick_select"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject( sqlca)

end event

event doubleclicked;if row < 1 then return
deleterow(row)
end event

event dragdrop;of_add_field()
end event

type gb_1 from groupbox within w_export_quick_select
integer x = 50
integer y = 164
integer width = 2729
integer height = 360
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Filters"
end type

type gb_2 from groupbox within w_export_quick_select
integer x = 55
integer width = 1006
integer height = 152
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select Screen"
end type

type st_3 from statictext within w_export_quick_select
boolean visible = false
integer x = 2725
integer y = 2000
integer width = 101
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 15780518
long backcolor = 15780518
string text = "none"
boolean focusrectangle = false
end type

event clicked;dw_rows.retrieve()
end event

