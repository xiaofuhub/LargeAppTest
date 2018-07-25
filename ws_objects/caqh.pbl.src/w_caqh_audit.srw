$PBExportHeader$w_caqh_audit.srw
forward
global type w_caqh_audit from w_popup
end type
type dw_change_filter from datawindow within w_caqh_audit
end type
type cb_2 from commandbutton within w_caqh_audit
end type
type ddlb_table_names from dropdownlistbox within w_caqh_audit
end type
type st_3 from statictext within w_caqh_audit
end type
type cb_1 from commandbutton within w_caqh_audit
end type
type dw_prac_finished from datawindow within w_caqh_audit
end type
type cb_reset from commandbutton within w_caqh_audit
end type
type dw_date_range from u_dw within w_caqh_audit
end type
type cb_filter from commandbutton within w_caqh_audit
end type
type cb_close from commandbutton within w_caqh_audit
end type
type rb_rejected from radiobutton within w_caqh_audit
end type
type rb_previous from radiobutton within w_caqh_audit
end type
type rb_accept from radiobutton within w_caqh_audit
end type
type rb_all from radiobutton within w_caqh_audit
end type
type cb_reject from commandbutton within w_caqh_audit
end type
type cb_accept from commandbutton within w_caqh_audit
end type
type dw_detail from u_dw within w_caqh_audit
end type
type dw_prac from u_dw within w_caqh_audit
end type
type gb_1 from groupbox within w_caqh_audit
end type
type gb_2 from groupbox within w_caqh_audit
end type
type ole_browser from olecustomcontrol within w_caqh_audit
end type
type gb_3 from groupbox within w_caqh_audit
end type
type gb_4 from groupbox within w_caqh_audit
end type
type st_1 from statictext within w_caqh_audit
end type
end forward

global type w_caqh_audit from w_popup
integer x = 214
integer y = 221
integer width = 4320
integer height = 2356
string title = "CAQH Import Audit"
long backcolor = 33551856
dw_change_filter dw_change_filter
cb_2 cb_2
ddlb_table_names ddlb_table_names
st_3 st_3
cb_1 cb_1
dw_prac_finished dw_prac_finished
cb_reset cb_reset
dw_date_range dw_date_range
cb_filter cb_filter
cb_close cb_close
rb_rejected rb_rejected
rb_previous rb_previous
rb_accept rb_accept
rb_all rb_all
cb_reject cb_reject
cb_accept cb_accept
dw_detail dw_detail
dw_prac dw_prac
gb_1 gb_1
gb_2 gb_2
ole_browser ole_browser
gb_3 gb_3
gb_4 gb_4
st_1 st_1
end type
global w_caqh_audit w_caqh_audit

type variables
string is_original_sql
string is_change_condition = ''
string is_date_condition = ''
string is_data_filter = ''
string is_id_condition = ''

integer il_status = 9 //all
integer ii_screen
integer il_value_changed = 1
datetime idt_CurrentTime

datastore ids_address_lookup, ids_code_lookup, ids_facility, ids_active_status, ids_question
datastore ids_committee
datastore ids_caqh_log_items
datastore ids_caqh_data_curr
str_caqh_audit_data istr_audit_data[]
str_caqh_audit_data istr_audit_data_empty[]

long il_log_id = 0 //dw_prac's current log_id
long il_xml_log_id //ole_browser's current log_id
boolean ib_view_xml = false
boolean ib_retrieving = false

n_cst_caqh_import in_caqh



end variables

forward prototypes
public function integer of_dddw_field (datawindow adw_detail)
public function string of_get_dddw_field (string as_lookuptype, string as_code, string as_sel_col)
public subroutine of_button_enabled (boolean ab_flag)
public function integer of_filter_detail ()
public function boolean of_retrieve_check ()
public function integer of_set_table_names ()
public function integer of_create_dw ()
public function integer of_open_xml ()
public function integer of_select_all (boolean ab_select)
public subroutine of_reset_detail_filter ()
public subroutine of_change_button ()
public function integer of_retrieve_log ()
public function integer of_reject (long al_log_id, long al_row)
public function integer of_accept (long al_log_id, integer ai_num, long al_row)
public function long of_get_curr_row ()
public function integer of_retrieve_detail (long al_log_id)
end prototypes

public function integer of_dddw_field (datawindow adw_detail);//====================================================================
//$<Function>: of_dddw_field
//$<Arguments>:
// 	value    datawindow    adw_detail
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 03.30.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>: copy n_cst_import.of_dddw_field and modify it.  (Appeon) long.zhang 03.30.2015
//====================================================================

string ls_field_type, ls_lookup_name
long ll_row, ll_rec, ll_j, ll_cnt
string ls_lookup_code, ls_lookup_code_old
string ls_field, ls_type, ls_value
string ls_sql, ls_field_name, ls_table_name
string  ls_syntax, ls_error_create, ls_error_syntax

ll_j = 1
ll_cnt =  adw_detail.rowcount()
for ll_row = 1 to ll_cnt
	If isvalid(w_appeon_gifofwait) and (mod(ll_row, 50) = 0 or ll_row = ll_cnt) Then w_appeon_gifofwait.of_setposition(10 + ll_row*90/ll_cnt)
	ls_field_name = adw_detail.getitemstring(ll_row, 'caqh_audit_item_field_name') 
	if ls_field_name = 'active_status' then
		ls_lookup_code = adw_detail.getitemstring(ll_row, 'caqh_audit_item_new_value')
		ls_table_name = adw_detail.getitemstring(ll_row, 'sys_tables_table_name')
		ls_value = of_active_status_value(ls_lookup_code ,ls_table_name )
		adw_detail.setitem(ll_row, 'new_value', ls_value) 
		
		ls_lookup_code = adw_detail.getitemstring(ll_row, 'caqh_audit_item_old_value')
		ls_value = of_active_status_value(ls_lookup_code ,ls_table_name )
		adw_detail.setitem(ll_row, 'old_value', ls_value) 
		continue
	end if
	
	//import data dddw
	ls_type = adw_detail.getitemstring(ll_row, 'sys_fields_lookup_type') 
	if isnull(ls_type) or ls_type = '' or ls_type = 'N' then 
		adw_detail.setitem(ll_row, 'new_value',  adw_detail.getitemstring(ll_row, 'caqh_audit_item_new_value'))
	end if
	ls_lookup_name = ''
	
	ls_lookup_name = adw_detail.getitemstring(ll_row, 'sys_fields_lookup_field_name') 
	
	choose case ls_type
		case "A"
			if ls_lookup_name<>'code' then ls_lookup_name = 'Entity_Name'
		case "C"
			ls_lookup_name = 'description'
		case "F","I"
			ls_lookup_name = 'facility_name'
		case "Q" //Question
			ls_lookup_name = 'full_quest'
		case "M" 
			ls_lookup_name = 'committee_name'
		case "S" 
			ls_lookup_name = 'active_status_name'
	end choose
	ls_lookup_code = adw_detail.getitemstring(ll_row, 'caqh_audit_item_new_value')
	
	if isnull(ls_lookup_code) or ls_lookup_code = '' then 
		ls_value = ls_lookup_code
	else
		if not(isnull(ls_type) or ls_type = ''  or ls_type = 'N' ) then
			//get lookup value
			ls_value = of_get_dddw_field(ls_type, ls_lookup_code, ls_lookup_name)
		else
			ls_value = ls_lookup_code
		end if
	end if
	adw_detail.setitem(ll_row, 'new_value', ls_value)
	
	//current data dddw
	ls_field_type = adw_detail.getitemstring(ll_row, 'sys_fields_lookup_field')
	if isnull(ls_field_type) or ls_field_type <> 'Y' then 
		adw_detail.setitem(ll_row, 'old_value',  adw_detail.getitemstring(ll_row, 'caqh_audit_item_old_value'))
		continue
	end if
	ls_type = adw_detail.getitemstring(ll_row, 'sys_fields_lookup_type') 
	if ls_type = 'A' then
		if ls_lookup_name<>'code' then ls_lookup_name = 'Entity_Name'
	elseif ls_type = 'Q' then
		ls_lookup_name = 'full_quest'
	else
		ls_lookup_name = 'description'
	end if	
	ls_lookup_code = adw_detail.getitemstring(ll_row, 'caqh_audit_item_old_value')
	if isnull(ls_lookup_code) or ls_lookup_code = '' then continue
	ls_value = of_get_dddw_field(ls_type, ls_lookup_code, ls_lookup_name)
	adw_detail.setitem(ll_row, 'old_value', ls_value)
next

adw_detail.accepttext()
return 1
end function

public function string of_get_dddw_field (string as_lookuptype, string as_code, string as_sel_col);//////////////////////////////////////////////////////////////////////
// $<function> of_get_dddw_field
// $<arguments>
// $<returns> string
// $<description> Appeon long.zhang 03.30.2015 (v15.1 CAQH Import Data Approval)
//////////////////////////////////////////////////////////////////////
//--------------------------------------------------------------------
//$<Modify History>: copied from n_cst_import.of_get_dddw_field, Appeon long.zhang 03.30.2015
//====================================================================

string ls_display
long   ll_find

// Retrieve lookup data
choose case as_lookuptype
	case "A" //Address
		if ids_address_lookup.RowCount()  <= 0 then
			ids_address_lookup.Retrieve()
		end if
		ll_find = ids_address_lookup.find("lookup_code = " +as_code,1, ids_address_lookup.rowcount())
		if ll_find > 0 then
			ls_display = ids_address_lookup.getitemstring(ll_find, as_sel_col)
			return ls_display
		else			
			return as_code
		end if		
	case "C" //Code
		if ids_code_lookup.RowCount()  <= 0 then
			ids_code_lookup.Retrieve()
		end if
		ll_find = ids_code_lookup.find("lookup_code = " +as_code,1, ids_code_lookup.rowcount())
		if ll_find > 0 then
			ls_display = ids_code_lookup.getitemstring(ll_find, as_sel_col)
			return ls_display
		else			
			return as_code
		end if				
	case "F" ,"I" //Facility
		if ids_facility.RowCount() <= 0 then ids_facility.Retrieve()
		ll_find = ids_facility.find("facility_id = " +as_code,1, ids_facility.rowcount())
		if ll_find > 0 then
			ls_display = ids_facility.getitemstring(ll_find, as_sel_col)
			return ls_display
		else			
			return as_code
		end if			
	case "S" //Active Status 
		if ids_active_status.RowCount() <= 0 then ids_active_status.Retrieve()
		ll_find = ids_active_status.find("active_status_id = " +as_code,1, ids_active_status.rowcount())
		if ll_find > 0 then
			ls_display = ids_active_status.getitemstring(ll_find, as_sel_col)
			return ls_display
		else			
			return as_code
		end if			
	case "Q" //QUESTION
		if ids_question.RowCount() <= 0 then ids_question.Retrieve()
		ll_find = ids_question.find("quest_id = " +as_code,1, ids_question.rowcount())
		if ll_find > 0 then
			ls_display = ids_question.getitemstring(ll_find, as_sel_col)
			return ls_display
		else			
			return as_code
		end if		
//	case "N_Q"  //QA Metrics
//		if ids_qa_metrics.RowCount() <= 0 then ids_qa_metrics.Retrieve()
//		ll_find = ids_qa_metrics.find("qam_id = " +as_code,1, ids_qa_metrics.rowcount())
//		if ll_find > 0 then
//			ls_display = ids_qa_metrics.getitemstring(ll_find, as_sel_col)
//			return ls_display
//		else			
//			return as_code
//		end if		
	case "M"  //Committee
		if ids_committee.RowCount() <= 0 then ids_committee.Retrieve()
		ll_find = ids_committee.find("committee_id = " +as_code,1, ids_committee.rowcount())
		if ll_find > 0 then
			ls_display = ids_committee.getitemstring(ll_find, as_sel_col)
			return ls_display
		else			
			return as_code
		end if		
end choose

Return ls_display
end function

public subroutine of_button_enabled (boolean ab_flag);//====================================================================
//$<Function>: of_button_enabled
//$<Arguments>:
// 	value    boolean    ab_flag
//$<Return>:  (NONE)
//$<Description>: 
//$<Author>: (Appeon) long.zhang 03.30.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

cb_accept.enabled = ab_flag
cb_reject.enabled = ab_flag
end subroutine

public function integer of_filter_detail ();//====================================================================
//$<Function>: of_filter_detail
//$<Arguments>:
// 	value    long    al_row
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 03.30.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

string ls_filter = ''

//Status
If il_status <> 9 Then
	ls_filter =  "caqh_audit_item_status = " + string(il_status)
End If

//table_names
If ddlb_table_names.text <>'' Then
	If LenA(ls_filter) > 0 Then
		ls_filter += ' and sys_tables_table_name_allias ="' + ddlb_table_names.text + '"'
	Else
		ls_filter = 'sys_tables_table_name_allias ="' + ddlb_table_names.text + '"'
	End If
End If

//changes filter
If il_value_changed <> 2 Then
	If LenA(ls_filter) > 0 Then
		ls_filter +=  " and caqh_audit_item_value_changed = " + string(il_value_changed)
	Else
		ls_filter =  "caqh_audit_item_value_changed = " + string(il_value_changed)
	End If
End If

dw_detail.setredraw(false)
dw_detail.setfilter(ls_filter)
dw_detail.filter()
dw_detail.setredraw(true)

return 1
end function

public function boolean of_retrieve_check ();//====================================================================
//$<Function>: of_retrieve_check
//$<Arguments>:
//$<Return>:  blob
//$<Description>:whether need to save it first
//$<Author>: (Appeon) long.zhang 03.30.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

If dw_prac.rowcount() > 0 Then
	If dw_prac.find("opt_type = '1'",1,dw_prac.rowcount()) >0 Then
		If messagebox("Prompt","Do you want to continue without auditing the Data?",Question!,YesNo!, 2) = 2 Then
			return false
		End If
	End If
End If		

return true
end function

public function integer of_set_table_names ();//====================================================================
//$<Function>: of_set_table_names
//$<Arguments>:
//$<Return>:  integer
//$<Description>: set ddlb_table_names
//$<Author>: (Appeon) long.zhang 04.03.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

int i = 0
string ls_tables = ','
string ls_table

ddlb_table_names.reset( )

If dw_detail.rowcount() <0 Then return -1

ddlb_table_names.AddItem('')

For i = 1 to dw_detail.rowcount()
	ls_table = dw_detail.getitemstring(i, 'sys_tables_table_name_allias')
	
	If PosA(ls_tables, ','+ls_table +',') = 0 Then
		ls_tables += ','+ls_table +','
		ddlb_table_names.AddItem(ls_table)
	End If
Next

return 0
end function

public function integer of_create_dw ();//====================================================================
//$<Function>: of_create_dw
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 03.31.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
ids_address_lookup = create datastore
ids_code_lookup = create datastore
ids_facility = create datastore
ids_active_status = create datastore
ids_question = create datastore
ids_committee = create datastore
ids_caqh_log_items = create datastore

ids_address_lookup.DataObject = "d_import_ds_lu_address"
ids_code_lookup.DataObject = "d_import_ds_lu_code"
ids_facility.DataObject = "d_import_ds_lu_facility"
ids_active_status.DataObject = "d_import_ds_lu_activestatus"
ids_question.dataobject = "d_g_quest_lookup"
ids_committee.DataObject = "d_import_ds_lu_committee"
ids_caqh_log_items.dataobject = "d_caqh_log_items"

ids_address_lookup.settransobject(sqlca)
ids_code_lookup.settransobject(sqlca)
ids_facility.settransobject(sqlca)
ids_active_status.settransobject(sqlca)
ids_question.settransobject(sqlca)
ids_committee.settransobject(sqlca)
ids_caqh_log_items.settransobject(sqlca)

return 1
end function

public function integer of_open_xml ();//====================================================================
//$<Function>: of_open_xml
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Open xml by MS Browser OLE
//$<Author>: (Appeon) long.zhang 04.02.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

string ls_file_name,ls_write_path
long res
Long ll_data_length
Integer li_loops
Integer li_counter
Int li_cur_row
Long ll_start
Blob lb_data
Blob lb_all_data
Long ll_filelen	
Blob  lb_xml_data
	
if il_log_id = 0 then return -1

If il_xml_log_id = il_log_id Then
	return 0
Else
	il_xml_log_id = il_log_id
End If


//Get file name
li_cur_row = of_get_curr_row()
ls_file_name = dw_prac.getitemstring(li_cur_row,'file_name')
ls_file_name = trim(RightA( ls_file_name, posA(Reverse(ls_file_name),'\') - 1))

//Find it in caqh folder
ls_write_path = gs_temp_path + "caqh"
if DirectoryExists ( ls_write_path ) = false then
	res = CreateDirectory ( ls_write_path )
	if res = -1 then
		MessageBox("Open XML","Unable to create file directory:" + ls_write_path)
		return -1
	end if
end if

ls_file_name = ls_write_path +  "\" + ls_file_name

//Download it if not find in caqh folder
If Not FileExists ( ls_file_name ) Then	
	SetPointer(HourGlass!)
	
	// Open processs window
	openwithparm( w_appeon_gifofwait, "Downloading Image from Database..." )
	
	IF appeongetclienttype() = 'PB' AND gs_dbtype = 'SQL' THEN		
		// Get file data from database
		SELECT Datalength(import_file)
		INTO :ll_data_length
		FROM caqh_log
		WHERE log_id = :il_log_id
		USING SQLCA;
		
		IF ll_data_length = 0 OR Isnull(ll_data_length) THEN
			// Close process window
			IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)
			MessageBox("File Creation Error", "No XML file in database. ")
			RETURN -1
		END IF
		
		IF ll_data_length > 8000 THEN 
			 IF Mod(ll_data_length,8000) = 0 THEN 
				  li_loops = ll_data_length/8000 
			 ELSE 
				  li_loops = (ll_data_length/8000) + 1 
			 END IF 
		ELSE 
			 li_loops = 1 
		END IF 
		
		FOR li_counter = 1 to li_loops
			Yield()
			SetPointer(HourGlass!)
			
			ll_start = (li_counter - 1) * 8000 + 1
			SELECTBLOB substring(import_file,:ll_start,8000)
			INTO :lb_data
			FROM caqh_log
			WHERE log_id = :il_log_id
			USING SQLCA;
		
			lb_all_data += lb_data
		NEXT 
		
		lb_xml_data = lb_all_data
	ELSE	//WEB
		SELECTBLOB import_file
		INTO :lb_xml_data
		FROM caqh_log
		WHERE 	log_id = :il_log_id
		USING SQLCA;
	END IF
	
	// Close process window
	IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)
	
	IF SQLCA.SQLCODE = -1 THEN
		MessageBox( "SQL ERROR", SQLCA.SQLERRTEXT )
		Return -1
	END IF
	
	ll_filelen = LenA( lb_xml_data )
	IF Isnull(lb_xml_data) OR ll_filelen = 0 THEN
		RETURN -1
	END IF
	
	//create xml file
	if f_open_image_from_database(ls_file_name,lb_xml_data ) = -1 then return -1	
	IF Not FileExists( ls_file_name) THEN
		MessageBox("File Creation Error", "No XML file created.  Check to make sure the directory " + ls_write_path + " is valid." )
		Return -1
	END IF
End If

//open it using ole_browser
ole_browser.Object.Navigate(ls_file_name)

end function

public function integer of_select_all (boolean ab_select);//====================================================================
//$<Function>: of_select_all
//$<Arguments>:
// 	value    boolean    ab_select
//$<Return>:  integer
//$<Description>: select all dw_detail 
//$<Author>: (Appeon) long.zhang 04.03.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

If dw_detail.rowcount() < 1 Then return 0

long ll_row

for ll_row = 1 to dw_detail.rowcount()
	If dw_detail.getitemnumber(ll_row, 'caqh_audit_item_status') = 0 Then
		If ab_select Then
			dw_detail.setitem(ll_row, "opt_type", "1")
		Else
			dw_detail.setitem(ll_row, "opt_type", "0")
		End If
	End If
next

return 0

end function

public subroutine of_reset_detail_filter ();//====================================================================
//$<Function>: of_reset_detail_filter
//$<Arguments>:
//$<Return>:  integer
//$<Description>: reset filter of dw_detail and filter
//$<Author>: (Appeon) long.zhang 04.07.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

//reset tables filter
of_set_table_names()

ddlb_table_names.text = ''

//rb_accept.event clicked()

of_filter_detail()

end subroutine

public subroutine of_change_button ();//====================================================================
//$<Function>: of_change_button
//$<Arguments>:
//$<Return>:  (None)
//$<Description>: 
//$<Author>: (Appeon) long.zhang 04.08.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

if dw_prac.rowcount() <1 Then return

If dw_prac.find("opt_type = '1'",1,dw_prac.rowcount()) > 0 Then
	of_button_enabled(true)
Else
	of_button_enabled(false)
End If

end subroutine

public function integer of_retrieve_log ();//====================================================================
//$<Function>: of_retrieve_log
//$<Arguments>:
//$<Return>:  integer
//$<Description>: retrieve dw_prac(caqh_log) with sql conditions.
//$<Author>: (Appeon) long.zhang 03.27.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
int i
string ls_from_date, ls_to_date
string ls_filter, ls_user
long   ll_import
string ls_sql
string ls_change

//reset all audit data
if upperbound(istr_audit_data[]) > 0 Then
	For i = 1 to upperbound(istr_audit_data[])
		If isvalid(istr_audit_data[i].ds_data) then destroy istr_audit_data[i].ds_data	
	Next
End If
istr_audit_data[] =  istr_audit_data_empty[]

//date condition
if dw_date_range.accepttext() = -1 then return -1
ls_from_date = String(dw_date_range.GetItemDate( 1, "from_date" ), 'yyyy-mm-dd' ) 
ls_to_date =  String( dw_date_range.GetItemDate( 1, "to_date" ), 'yyyy-mm-dd' ) 

ls_filter = ''
if ls_from_date <>'' and not isnull(ls_from_date) then
	ls_from_date = ls_from_date + " 00:00:00"
	ls_filter =  "convert(varchar,log_date,120) >='"+ls_from_date +"'"
	if ls_to_date <>'' and not isnull(ls_to_date) then
		ls_to_date = ls_to_date + " 23:59:59"
		ls_filter = ls_filter +" and convert(varchar,log_date,120) <= '"+ls_to_date +"'"
	end if
	
elseif  ls_to_date <>'' and not isnull(ls_to_date) then
	ls_to_date = ls_to_date + " 23:59:59"
	ls_filter = " convert(varchar,log_date,120) <= '"+ ls_to_date+"'"
else
	ls_filter = " 1 = 1 "
end if
is_date_condition = ls_filter

//change condition
dw_prac_finished.accepttext()
if dw_prac_finished.getrow() < 1 then return 1
ls_change = dw_prac_finished.getitemstring(1,"s_type")

if ls_change = '1' then
	is_change_condition = 'caqh_log.audit_finished = 0'
elseif ls_change = '2' then
	is_change_condition = 'caqh_log.audit_finished = 1'
else
	is_change_condition = " 1 = 1 "
end if

//setsql
dw_prac.reset()
il_log_id = 0
dw_prac.setsqlselect (is_original_sql + ' and ' + is_change_condition + ' and ' +  is_date_condition + ' and ' +  is_id_condition)

//retrieve
dw_prac.setredraw(false)
ib_retrieving = true
i = dw_prac.retrieve()
ib_retrieving = false
dw_prac.setredraw(true)

of_button_enabled(false)

return i

end function

public function integer of_reject (long al_log_id, long al_row);//====================================================================
//$<Function>: of_reject
//$<Arguments>:
// 	value    long    al_log_id
// 	value    long    al_row
//$<Return>:  integer (1 success/0 skipped/-1 fail)
//$<Description>: 
//$<Author>: (Appeon) long.zhang 04.09.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

long ll_row,ll_upper
int li_curr_row
long ll_find, ll_table_id,ll_seq_no,ll_detail_cnt,ll_start
integer li_status
string ls_opt_type, ls_audit_type,ls_field_name, ls_find
string ls_error,ls_errtitle
datetime ldt_CurrentTime
boolean lb_find = false

ls_errtitle = "Log Id:" + string(al_log_id) +' Error'

//find audit_data
ll_upper = upperbound(istr_audit_data[])
If ll_upper > 0 Then
	For li_curr_row = 1 to ll_upper
		If istr_audit_data[li_curr_row].log_id = al_log_id Then
			lb_find = true
			If isvalid(ids_caqh_data_curr) Then ids_caqh_data_curr.sharedataoff()
			ids_caqh_data_curr =  istr_audit_data[li_curr_row].ds_data
			exit
		End If
	Next	
End If

If not lb_find or ll_upper = 0 Then
	MessageBox( ls_errtitle, "No ids_caqh_data_curr." )
	return -1
End If

//filter
ids_caqh_data_curr.setfilter("1=1")
ids_caqh_data_curr.filter()

//Detail Count
ll_detail_cnt = ids_caqh_data_curr.rowcount()
If ll_detail_cnt < 1 Then 
	MessageBox( ls_errtitle, "ids_caqh_data_curr has no record." )
	return -1
End If
If ids_caqh_data_curr.find("opt_type = '1'", 1, ll_detail_cnt) = 0 Then 
	MessageBox( ls_errtitle, "No selected Data.")
	return	 0
End If

//Reset
ids_caqh_log_items.reset()

//Retrieve
ids_caqh_log_items.retrieve(al_log_id)

If ids_caqh_log_items.rowcount() < 1 Then 
	MessageBox( ls_errtitle, "ids_caqh_log_items has no record." )
	return -1
End If

ldt_CurrentTime = datetime(today(),now())

//Set item
for ll_row = 1 to ids_caqh_data_curr.rowcount()
	li_status = ids_caqh_data_curr.getitemnumber(ll_row, "caqh_audit_item_status")
	ls_opt_type = ids_caqh_data_curr.getitemstring(ll_row, "opt_type")
	if li_status = 0 and  ls_opt_type = '1'  then
		ll_table_id = ids_caqh_data_curr.getitemnumber(ll_row, "caqh_audit_item_table_id")
		ll_seq_no = ids_caqh_data_curr.getitemnumber(ll_row, "caqh_audit_item_seq_no")
		ls_audit_type = ids_caqh_data_curr.getitemstring(ll_row, "caqh_audit_item_audit_type")
		ls_field_name =  ids_caqh_data_curr.getitemstring(ll_row, "caqh_audit_item_field_name")
	
		ls_find = 'table_id = ' + string(ll_table_id) + ' and audit_type = "' +  ls_audit_type + '" and seq_no = ' + string(ll_seq_no) +&
		' and field_name = "' + ls_field_name +'"'
	
		ll_find = ids_caqh_log_items.find(ls_find , 1, ids_caqh_log_items.rowcount())
		if ll_find > 0 then
			ids_caqh_log_items.setitem(ll_find, "status", -1)
			ids_caqh_log_items.setitem(ll_find, "audit_by", gs_user_id)
			ids_caqh_log_items.setitem(ll_find, "audit_date", ldt_CurrentTime)
		end if
	end if
next


//Hard code for pd_address.mailing_address. (Users can never select mailing_address in the screen.)
ll_table_id =  long(gnv_data.of_getitem('sys_tables','table_id',"upper(table_name)='PD_ADDRESS'" ))
ll_seq_no = 0
ll_start = 1
do while (ll_start > 0 and ll_start <= ll_detail_cnt)
	ls_find = 'caqh_audit_item_table_id = ' + string(ll_table_id) +" and caqh_audit_item_audit_type = 'NW' and opt_type = '1'" 
	ll_find = ids_caqh_data_curr.find(ls_find ,ll_start, ll_detail_cnt) 
		
	//If at least one pd_address column is selected.
	If  ll_find >0 Then
		ll_start = ll_find + 1 //Set ll_start for next loop
		
		//Do not need to find it for the same seq_no
		If  ids_caqh_data_curr.getitemnumber(ll_find, "caqh_audit_item_seq_no") = ll_seq_no Then continue
		
		ll_seq_no = ids_caqh_data_curr.getitemnumber(ll_find, "caqh_audit_item_seq_no")
		
		//have any 'to be accept' items in the same PD_ADDRESS record?
		ls_find =  'caqh_audit_item_table_id = ' + string(ll_table_id) +" and caqh_audit_item_audit_type = 'NW' and caqh_audit_item_seq_no = " + string(ll_seq_no) +&
			" and opt_type <> '1' and caqh_audit_item_status = 0"
		ll_find = ids_caqh_data_curr.find(ls_find, 1, ll_detail_cnt)
		
		//It doesn't have any 'to be accept' items.
		If ll_find = 0 Then 
			ls_find = 'table_id = ' + string(ll_table_id) + ' and audit_type = "NW" and seq_no = ' + string(ll_seq_no) +' and lower(field_name) = "mailing_address"'
			ll_find = ids_caqh_log_items.find(ls_find , 1, ids_caqh_log_items.rowcount())
			if ll_find > 0 then //find mailing_address in ids_caqh_log_items
				ids_caqh_log_items.setitem(ll_find, "status", -1)
				ids_caqh_log_items.setitem(ll_find, "audit_by", gs_user_id)
				ids_caqh_log_items.setitem(ll_find, "audit_date", ldt_CurrentTime)
			end if
		End If
	Else
		ll_start = 0 //Stop loop
	End If	
Loop

sqlca.autocommit = false
//update
ids_caqh_log_items.accepttext()
if ids_caqh_log_items.update() = 1 then
	//check audit finished
	If ids_caqh_log_items.find('status = 0', 1, ids_caqh_log_items.rowcount()) = 0 Then 
		Update caqh_log set audit_finished = 1 where log_id = :al_log_id;
		
		//reset dw_prac.opt_type and dw_prac.audit_finished, do not retrieve.
		dw_prac.object.opt_type[al_row] = '0'
		dw_prac.object.audit_finished[al_row] = 1
	End If
	commit using sqlca;
	sqlca.autocommit = true
	//successful
else
	rollback using sqlca;
	sqlca.autocommit = true
	MessageBox(ls_errtitle + " SQL ERROR", SQLCA.SQLERRTEXT )
	return -1
end if

//If successful, change the log_id so the Cache(istr_audit_data[li_curr_row]) will not be found again,
//and it will retrieve from database when using of_retrieve_detail
istr_audit_data[li_curr_row].log_id =  - istr_audit_data[li_curr_row].log_id
of_retrieve_detail( al_log_id )

return 1
end function

public function integer of_accept (long al_log_id, integer ai_num, long al_row);//====================================================================
//$<Function>: of_accept
//$<Arguments>:
// 	value    long       al_log_id
// 	value    integer    ai_num 
// 	value    integer    al_row 
//$<Return>:  integer (1 ,success/ -1, fail/ 0, skip)
//$<Description>: 
//$<Author>: (Appeon) long.zhang 04.09.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_row ,res
long ll_find, ll_table_id,ll_seq_no ,ll_detail_cnt,ll_upper
long ll_prac_id ,ll_start
int li_curr_row
integer li_status
int li_cnt = 0
string   ls_opt_type, ls_audit_type,ls_field_name, ls_find
string ls_errtitle
boolean lb_update = false
boolean lb_find = false

 ls_errtitle = "Log Id:" + string(al_log_id) +' Error'
 
//find audit_data
ll_upper = upperbound(istr_audit_data[])
If ll_upper > 0 Then
	For li_curr_row = 1 to ll_upper
		If istr_audit_data[li_curr_row].log_id = al_log_id Then
			lb_find = true
			If isvalid(ids_caqh_data_curr) Then ids_caqh_data_curr.sharedataoff()
			ids_caqh_data_curr =  istr_audit_data[li_curr_row].ds_data
			exit
		End If
	Next	
End If

If not lb_find or ll_upper = 0 Then	
	MessageBox( ls_errtitle, "No Cache Data." )
	return -1
End If

ids_caqh_data_curr.setfilter("1=1")
ids_caqh_data_curr.filter()

//ids_caqh_data_curr count
ll_detail_cnt = ids_caqh_data_curr.rowcount()
If ll_detail_cnt < 1 Then 
	MessageBox( ls_errtitle, "No selected Data." )
	return -1
End If

If ids_caqh_data_curr.find("opt_type = '1'", 1, ll_detail_cnt) = 0 Then 
	// No selected Data.
	return	 0
End If

//Retrieve
ids_caqh_log_items.reset()
ids_caqh_log_items.retrieve(al_log_id)

If ids_caqh_log_items.rowcount() < 1 Then
	MessageBox( ls_errtitle, "No caqh_log_items." )
	return -1
End If

//Set item status for ids_caqh_log_items
for ll_row = 1 to ll_detail_cnt
	li_status = ids_caqh_data_curr.getitemnumber(ll_row, "caqh_audit_item_status")
	ls_opt_type = ids_caqh_data_curr.getitemstring(ll_row, "opt_type")
	if li_status = 0 and  ls_opt_type = '1'  then
		ll_table_id = ids_caqh_data_curr.getitemnumber(ll_row, "caqh_audit_item_table_id")
		ll_seq_no = ids_caqh_data_curr.getitemnumber(ll_row, "caqh_audit_item_seq_no")
		ls_audit_type = ids_caqh_data_curr.getitemstring(ll_row, "caqh_audit_item_audit_type")
		ls_field_name =  ids_caqh_data_curr.getitemstring(ll_row, "caqh_audit_item_field_name")
	
		ls_find = 'table_id = ' + string(ll_table_id) + ' and audit_type = "' +  ls_audit_type + '" and seq_no = ' + string(ll_seq_no) +&
		' and field_name = "' + ls_field_name +'"'
	
		ll_find = ids_caqh_log_items.find(ls_find , 1, ids_caqh_log_items.rowcount())
		if ll_find > 0 then
			ids_caqh_log_items.setitem(ll_find, "status", -2) //only use status = -2 as a temporary flag. Do not save it.
		end if
	end if
next

//Hard code for pd_address.mailing_address. (Users can never select mailing_address in the screen.)
ll_table_id =  long(gnv_data.of_getitem('sys_tables','table_id',"upper(table_name)='PD_ADDRESS'" ))
ll_seq_no = 0
ll_start = 1
do while (ll_start > 0 and ll_start <= ll_detail_cnt)
	ls_find = 'caqh_audit_item_table_id = ' + string(ll_table_id) +" and caqh_audit_item_audit_type = 'NW' and opt_type = '1'" 
	ll_find = ids_caqh_data_curr.find(ls_find ,ll_start, ll_detail_cnt) 
		
	//If at least one pd_address column is selected.
	If  ll_find >0 Then
		ll_start = ll_find + 1 //Set ll_start for next loop
		
		//Do not need to find it for the same seq_no
		If  ids_caqh_data_curr.getitemnumber(ll_find, "caqh_audit_item_seq_no") = ll_seq_no Then continue
		
		ll_seq_no = ids_caqh_data_curr.getitemnumber(ll_find, "caqh_audit_item_seq_no")
		ls_find = 'table_id = ' + string(ll_table_id) + ' and audit_type = "NW" and seq_no = ' + string(ll_seq_no) +' and lower(field_name) = "mailing_address" and status <> -2'
		ll_find = ids_caqh_log_items.find(ls_find , 1, ids_caqh_log_items.rowcount())
		if ll_find > 0 then //Find mailing_address in ids_caqh_log_items
			ids_caqh_log_items.setitem(ll_find, "status", -2)
		end if
	Else
		ll_start = 0 //Stop loop
	End If	
Loop

//Whether prac_id exists in pd_basic. if not,  last name column must have been selected.
ll_prac_id = dw_prac.getitemnumber( al_row, 'prac_id')
select count(1) into :li_cnt from pd_basic where prac_id = :ll_prac_id;
If sqlca.sqlcode < 0 Then
	MessageBox( ls_errtitle, sqlca.sqlerrtext )
	return -1
ElseIf li_cnt = 0 Then
	lb_update = false //new prac
	ll_table_id = integer(gnv_data.of_getitem('sys_tables','table_id',"upper(table_name)='" + upper('pd_basic') + "'"))
	li_cnt = ids_caqh_log_items.find("table_id = " + string(ll_table_id) + " and field_name = 'last_name' and status = -2 ",1, ids_caqh_log_items.rowcount())
	If li_cnt = 0 Then
		messagebox(ls_errtitle, "Last Name must be selected for creating a new Basic Information Record.")
		return -1
	End If
Else //li_cnt >0
	lb_update = true 
End If

//Set old variables to in_caqh
in_caqh.of_set_defaults_vars( dw_prac.getitemstring(al_row, 'defaults') )

//Set in_caqh.ib_update and in_caqh.il_prac
in_caqh.of_set_prac_id(ll_prac_id)
in_caqh.of_set_ib_update( lb_update )

//Set in_caqh.il_prov_id
in_caqh.of_set_prov_id(Long(dw_prac.GetItemString( al_row, 'caqh_id'))) //Added by Appeon long.zhang 11.17.2016 (Bug id 5414 - Provider ID being set to '0' from CAQH XML import)

//Import Data
res = in_caqh.of_import_audit_data(ids_caqh_log_items, ai_num)

//successful
if res = 1 Then 
	// change the log_id so the Cache(istr_audit_data[li_curr_row]) will not be found again,
	//and it will retrieve from database when using of_retrieve_detail. 
	 istr_audit_data[li_curr_row].log_id =  - istr_audit_data[li_curr_row].log_id
	 of_retrieve_detail( al_log_id )
	 
	 //reset dw_prac.opt_type and dw_prac.audit_finished, do not retrieve dw_prac.
	 If ids_caqh_log_items.find('status = 0', 1, ids_caqh_log_items.rowcount()) = 0 Then 
		dw_prac.object.opt_type[al_row] = '0'
		dw_prac.object.audit_finished[al_row] = 1
	End If
End If

return res
end function

public function long of_get_curr_row ();//====================================================================
//$<Function>: of_get_curr_row
//$<Arguments>:
//$<Return>:  long
//$<Description>: Get current row of dw_prac
//$<Author>: (Appeon) long.zhang 04.30.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Long ll_cur_row = 0

ll_cur_row = dw_prac.find("log_id = " + string(il_log_id), 1, dw_prac.rowcount())

Return ll_cur_row
end function

public function integer of_retrieve_detail (long al_log_id);//====================================================================
//$<Function>: of_retrieve_detail
//$<Arguments>:Long al_log_id
//$<Return>:  integer
//$<Description>: Retrieve Data for dw_detail ,only use dw_detail to show data. It store data in istr_audit_data[i].ds_data.
//$<Author>: (Appeon) long.zhang 03.31.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

long ll_row,ll_upper ,i 
boolean lb_find = false

dw_detail.accepttext( )
dw_detail.sharedataoff()
dw_detail.setredraw(false)
SetPointer(HourGlass!)

//1.find existing log_ids
ll_upper = upperbound(istr_audit_data[])
If ll_upper > 0 Then
	For i = 1 to ll_upper
		If istr_audit_data[i].log_id = al_log_id Then
			lb_find = true
			If isvalid(ids_caqh_data_curr) Then ids_caqh_data_curr.sharedataoff()
			ids_caqh_data_curr =  istr_audit_data[i].ds_data
			
			ids_caqh_data_curr.sharedata(dw_detail)
			exit
		End If
	Next	
End If

//2.can't find existing log_ids
If not lb_find Then
	// Open processs window
	openwithparm( w_appeon_gifofwait, 'Refreshing Audit Items Data for Log Id ' + String(al_log_id) + "..." )
	
	istr_audit_data[ll_upper + 1].log_id = al_log_id
	
	If isvalid(ids_caqh_data_curr) Then ids_caqh_data_curr.sharedataoff()
	istr_audit_data[ll_upper + 1].ds_data  = create datastore
	
	ids_caqh_data_curr = istr_audit_data[ll_upper + 1].ds_data
	ids_caqh_data_curr.dataobject = dw_detail.dataobject
	ids_caqh_data_curr.settransobject(sqlca)
	ids_caqh_data_curr.sharedata(dw_detail)
	ids_caqh_data_curr.retrieve(al_log_id)
	
	//reset old value,new value
	of_dddw_field(dw_detail)
	
	//Close process window
	IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)
End If

//reset ids_caqh_data_curr's filter
ids_caqh_data_curr.setfilter("1 = 1")
ids_caqh_data_curr.filter()

////select all items by default 
//If not lb_find Then of_select_all(true) //Comment by Appeon long.zhang 09.29.2015 (BugS082702)

//filter
of_reset_detail_filter() //reset to default filter condition and filter
	
dw_detail.setredraw(true)
SetPointer(Arrow!)

return 1
end function

on w_caqh_audit.create
int iCurrent
call super::create
this.dw_change_filter=create dw_change_filter
this.cb_2=create cb_2
this.ddlb_table_names=create ddlb_table_names
this.st_3=create st_3
this.cb_1=create cb_1
this.dw_prac_finished=create dw_prac_finished
this.cb_reset=create cb_reset
this.dw_date_range=create dw_date_range
this.cb_filter=create cb_filter
this.cb_close=create cb_close
this.rb_rejected=create rb_rejected
this.rb_previous=create rb_previous
this.rb_accept=create rb_accept
this.rb_all=create rb_all
this.cb_reject=create cb_reject
this.cb_accept=create cb_accept
this.dw_detail=create dw_detail
this.dw_prac=create dw_prac
this.gb_1=create gb_1
this.gb_2=create gb_2
this.ole_browser=create ole_browser
this.gb_3=create gb_3
this.gb_4=create gb_4
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_change_filter
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.ddlb_table_names
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.dw_prac_finished
this.Control[iCurrent+7]=this.cb_reset
this.Control[iCurrent+8]=this.dw_date_range
this.Control[iCurrent+9]=this.cb_filter
this.Control[iCurrent+10]=this.cb_close
this.Control[iCurrent+11]=this.rb_rejected
this.Control[iCurrent+12]=this.rb_previous
this.Control[iCurrent+13]=this.rb_accept
this.Control[iCurrent+14]=this.rb_all
this.Control[iCurrent+15]=this.cb_reject
this.Control[iCurrent+16]=this.cb_accept
this.Control[iCurrent+17]=this.dw_detail
this.Control[iCurrent+18]=this.dw_prac
this.Control[iCurrent+19]=this.gb_1
this.Control[iCurrent+20]=this.gb_2
this.Control[iCurrent+21]=this.ole_browser
this.Control[iCurrent+22]=this.gb_3
this.Control[iCurrent+23]=this.gb_4
this.Control[iCurrent+24]=this.st_1
end on

on w_caqh_audit.destroy
call super::destroy
destroy(this.dw_change_filter)
destroy(this.cb_2)
destroy(this.ddlb_table_names)
destroy(this.st_3)
destroy(this.cb_1)
destroy(this.dw_prac_finished)
destroy(this.cb_reset)
destroy(this.dw_date_range)
destroy(this.cb_filter)
destroy(this.cb_close)
destroy(this.rb_rejected)
destroy(this.rb_previous)
destroy(this.rb_accept)
destroy(this.rb_all)
destroy(this.cb_reject)
destroy(this.cb_accept)
destroy(this.dw_detail)
destroy(this.dw_prac)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.ole_browser)
destroy(this.gb_3)
destroy(this.gb_4)
destroy(this.st_1)
end on

event open;call super::open;string  ls_parm

long ll_import_id, ll_hdr_id
datawindowchild ldwc_1
boolean lb_parm

// Set resize
this.setredraw(false)
this.of_SetResize(true)
inv_resize.of_setorigsize( this.workspacewidth(), this.workspaceheight())
inv_resize.of_setminsize( this.workspacewidth(),this.workspaceheight())
 //Start Code Change ----03.06.2017 #V153 maha - modified for browser resize
inv_resize.of_Register(dw_detail, inv_resize.SCALEBOTTOM)
//inv_resize.of_Register(dw_prac, inv_resize.SCALERIGHT)
inv_resize.of_Register(ole_browser, inv_resize.SCALEBOTTOM)
 //Start Code Change ----03.06.2017 #V153 maha

of_create_dw()

is_original_sql = dw_prac.getsqlselect()

//log_id
ls_parm = Message.StringParm
If LenA(ls_parm) > 0 Then
	dw_date_range.enabled = false
	cb_reset.enabled = false
	cb_filter.enabled = false
	
	//initial status:both
	dw_prac_finished.setitem(1,"s_type",'0')
	//initial changes filter:both
	dw_change_filter.setitem(1,"s_type",'2')
	il_value_changed = 2

	
	is_id_condition = 'caqh_log.log_id in ('+ ls_parm + ')'
ELse
	//initial status:to be audited
	dw_prac_finished.setitem(1,"s_type",'1')
	//initial changes filter:changed
	dw_change_filter.setitem(1,"s_type",'1')
	il_value_changed = 1

	is_id_condition = '1 = 1'
End if

//retrieve
of_retrieve_log()

this.setredraw(true)


end event

event pfc_postopen;call super::pfc_postopen;dw_date_range.of_SetUpdateAble( False )
dw_date_range.of_SetTransObject( SQLCA )
dw_date_range.InsertRow( 0 )

dw_date_range.of_SetDropDownCalendar( TRUE )
dw_date_range.iuo_calendar.of_Register(dw_date_range.iuo_calendar.DDLB)
dw_date_range.of_setupdateable(false) 
end event

event closequery;call super::closequery;long ll_cnt

if isvalid(ids_address_lookup) then destroy ids_address_lookup
if isvalid(ids_facility) then destroy ids_facility
if isvalid(ids_active_status) then destroy ids_active_status
if isvalid(ids_question) then destroy ids_question
if isvalid(ids_code_lookup) then destroy ids_code_lookup
if isvalid(ids_committee) then destroy ids_committee

if isvalid(ids_caqh_log_items) then destroy(ids_caqh_log_items)

if upperbound(istr_audit_data[]) > 0 Then
	For ll_cnt = 1 to upperbound(istr_audit_data[])
		If isvalid(istr_audit_data[ll_cnt].ds_data) then destroy istr_audit_data[ll_cnt].ds_data	
	Next
End If
end event

event resize;call super::resize; //Start Code Change ----03.06.2017 #V153 maha - added
 long ll_w
 long ll_h
 long ll_split
 
 ll_w = this.WorkSpaceWidth()
 ll_h = this.WorkspaceHeight()
 ll_split =  ll_w /2 -10
 
 if ole_browser.visible = true then
	 ole_browser.width = ll_split
	 dw_detail.width = ll_split
	 dw_prac.width =  dw_detail.width
	 ole_browser.x = dw_detail.width + 10 
else
	dw_detail.width = ll_w -10
	 dw_prac.width =  dw_detail.width
end if
 
end event

type dw_change_filter from datawindow within w_caqh_audit
integer x = 955
integer y = 784
integer width = 453
integer height = 76
integer taborder = 40
string title = "none"
string dataobject = "d_dddw_caqh_import_change"
boolean border = false
boolean livescroll = true
end type

event itemchanged;//====================================================================
//$<Event>: itemchanged
//$<Arguments>:
// 	value    long        row
// 	value    dwobject    dwo
// 	value    string      data
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 04.30.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

If dwo.name = 's_type' Then
	il_value_changed = integer(data)
	of_filter_detail()
End If
end event

type cb_2 from commandbutton within w_caqh_audit
integer x = 3506
integer y = 36
integer width = 329
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "R&un Report"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: Audit Report
//$<Author>: (Appeon) long.zhang 04.30.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

open(w_caqh_audit_report)
end event

type ddlb_table_names from dropdownlistbox within w_caqh_audit
integer x = 37
integer y = 780
integer width = 818
integer height = 1164
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;//====================================================================
//$<Event>: selectionchanged
//$<Arguments>:
// 	value    integer    index
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 04.30.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

 of_filter_detail()
end event

type st_3 from statictext within w_caqh_audit
integer x = 37
integer y = 732
integer width = 366
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Screen Filter"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_caqh_audit
integer x = 3109
integer y = 36
integer width = 379
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "View XML File"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 04.30.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

long ll_row
string ls_url

//check
If il_log_id = 0 and this.text = 'View XML File' Then 
	Messagebox("Prompt","Please select a Log Id.")
	return
End If

//show xml file
If this.text = 'View XML File' Then
	ole_browser.visible = true
	this.text = 'Hide XML File'
	ib_view_xml = true
Else
	ole_browser.visible = false
	this.text = 'View XML File'
	ib_view_xml = false
	return
End If
	
//show xml
if ib_view_xml = true then of_open_xml()

parent.triggerevent("resize")   //Start Code Change ----03.06.2017 #V153 maha

Return 0
end event

type dw_prac_finished from datawindow within w_caqh_audit
integer x = 55
integer y = 52
integer width = 453
integer height = 76
integer taborder = 30
string title = "none"
string dataobject = "d_dddw_caqh_import_finished"
boolean border = false
boolean livescroll = true
end type

event itemchanged;//====================================================================
//$<Event>: itemchanged
//$<Arguments>:
// 	value    long        row
// 	value    dwobject    dwo
// 	value    string      data
//$<Return>:  long
//$<Description>: Filter dw_prac and refresh dw_detail.
//$<Author>: (Appeon) long.zhang 03.26.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

//check
If not of_retrieve_check() Then
	return -1
End If

post of_retrieve_log()
end event

type cb_reset from commandbutton within w_caqh_audit
integer x = 1723
integer y = 44
integer width = 183
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Re&set"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 04.30.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

dw_date_range.Reset( )
dw_date_range.InsertRow( 0 )
end event

type dw_date_range from u_dw within w_caqh_audit
integer x = 590
integer y = 56
integer width = 1166
integer height = 80
integer taborder = 50
string dataobject = "d_faxlog_date_range"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;//====================================================================
//$<Event>: constructor
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

this.settransobject(sqlca)
this.insertrow(1)
this.setitem(1,'from_date', RelativeDate ( today(), -1 ))
this.setitem(1,'to_date', today())

end event

type cb_filter from commandbutton within w_caqh_audit
integer x = 1961
integer y = 36
integer width = 352
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Run"
boolean default = true
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 04.30.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

//check
If not of_retrieve_check() Then
	return -1
End If

//retrieve
of_retrieve_log()
end event

type cb_close from commandbutton within w_caqh_audit
integer x = 3849
integer y = 36
integer width = 293
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
close(parent)
end event

type rb_rejected from radiobutton within w_caqh_audit
integer x = 2592
integer y = 792
integer width = 535
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Previously Rejected"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 04.30.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

il_status = -1
of_filter_detail()
end event

type rb_previous from radiobutton within w_caqh_audit
integer x = 2030
integer y = 792
integer width = 549
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Previously Accepted"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 04.30.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

 il_status = 1
 of_filter_detail()
end event

type rb_accept from radiobutton within w_caqh_audit
integer x = 1550
integer y = 792
integer width = 457
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "To be Accepted"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 04.30.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

il_status = 0
of_filter_detail()
end event

type rb_all from radiobutton within w_caqh_audit
integer x = 3168
integer y = 792
integer width = 160
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "All"
boolean checked = true
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 04.30.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

il_status = 9
of_filter_detail()
end event

type cb_reject from commandbutton within w_caqh_audit
integer x = 2729
integer y = 36
integer width = 352
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "&Reject"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 04.30.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

long ll_row,ll_log_id
int res = 0, ok = 0, ex =0, no = 0

if dw_prac.rowcount() <1 Then return

If dw_prac.find("opt_type = '1'",1,dw_prac.rowcount()) = 0 Then return

For ll_row = 1 to dw_prac.rowcount()
	If dw_prac.getitemstring(ll_row,'opt_type') = '1' Then
		ll_log_id = dw_prac.getitemnumber(ll_row,'log_id')
		res = of_reject(ll_log_id, ll_row ) //reject
		if res = 1 then  //processed
			ok++
		elseif res = 0 then  //skipped
			ex++
		else  //-1 failed
			no++
		end if
	End If
Next

messagebox("CAQH Audit Import","Process Complete: " + string(ok) + " logs done; " + string(no) + " logs failed;" + string(ex) + " logs skipped.")

//refresh dw_detail for current selected row
of_retrieve_detail( il_log_id )
end event

type cb_accept from commandbutton within w_caqh_audit
integer x = 2345
integer y = 36
integer width = 352
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "&Accept "
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 04.30.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

long ll_row,ll_log_id
int li_num = 1,res = 0, ok = 0, ex =0, no = 0

if dw_prac.rowcount() <1 Then return

If dw_prac.find("opt_type = '1'",1,dw_prac.rowcount()) = 0 Then return

//Create in_caqh
if not isvalid(in_caqh) then in_caqh = create n_cst_caqh_import

//Set a flag: n_cst_caqh_import.ib_from_audit
in_caqh.of_set_from_audit( true )

For ll_row = 1 to 	dw_prac.rowcount()
	Yield()
	If dw_prac.getitemstring(ll_row,'opt_type') = '1' Then	
		ll_log_id = dw_prac.getitemnumber(ll_row,'log_id')
		res = of_accept(ll_log_id, li_num, ll_row) //accept
		li_num++
		if res = 1 then  //processed
			ok++
			//refresh dw_detail
		elseif res = 0 then  //skipped
			ex++
		else  //-1 failed
			no++
		end if
	End If
Next

//Destroy
destroy in_caqh

messagebox("CAQH Audit Import","Process Complete: " + string(ok) + " logs imported; " + string(no) + " logs failed; " + string(ex) + " logs skipped.")

//refresh current dw_detail
of_retrieve_detail( il_log_id )
end event

type dw_detail from u_dw within w_caqh_audit
integer y = 880
integer width = 4279
integer height = 1364
integer taborder = 30
string title = "Data"
string dataobject = "d_caqh_audit_detail"
boolean hscrollbar = true
end type

event constructor;call super::constructor;//====================================================================
//$<Event>: constructor
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

this.of_setupdateable(false) 
end event

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	value    integer     xpos
// 	value    integer     ypos
// 	value    long        row
// 	value    dwobject    dwo
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 03.30.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
int i

//button
If dwo.name ='b_select_all' or dwo.name ='b_deselect_all' Then
	i = of_select_all((dwo.name ='b_select_all'))
End If

if row < 1 then return

//select row
this.selectrow(0, false)
this.selectrow(row, true)

end event

event rowfocuschanged;call super::rowfocuschanged;//====================================================================
//$<Event>: rowfocuschanged
//$<Arguments>:
// 	value    long    currentrow
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 04.30.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

if currentrow < 1 then return
this.selectrow(0, false)
this.selectrow(currentrow, true)
end event

type dw_prac from u_dw within w_caqh_audit
integer y = 152
integer width = 4279
integer height = 576
integer taborder = 20
string title = "Practitioner"
string dataobject = "d_caqh_log_audit"
boolean hscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;//====================================================================
//$<Event>: rowfocuschanged
//$<Arguments>:
// 	value    long    currentrow
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 04.08.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

long  ll_prac_id
string ls_filter

If ib_retrieving Then return

if currentrow < 1 then
	if this.rowcount() < 1 then
		dw_detail.reset()
	end if
	return
end if

this.selectrow(0, false)
this.selectrow(currentrow, true)

If this.getitemnumber( currentrow, 'log_id') <> il_log_id Then
	il_log_id = this.getitemnumber( currentrow, 'log_id')
	
	//Retrieve detail
	Post of_retrieve_detail( il_log_id )
	
	//show xml
	if ib_view_xml = true then of_open_xml()
End If
end event

event clicked;call super::clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	value    integer     xpos
// 	value    integer     ypos
// 	value    long        row
// 	value    dwobject    dwo
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 04.30.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

if row < 1 then return

//make button enabled
If dwo.name = 'opt_type' Then post of_change_button()

//retrieve data detail
this.event rowfocuschanged(row)

end event

event constructor;call super::constructor;//====================================================================
//$<Event>: constructor
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Import Data Approval)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

//Sort
This.of_SetSort(True)
This.inv_sort.of_SetStyle(3)
This.inv_sort.of_SetColumnHeader(True)

//Updateable
This.of_setupdateable(false) 
end event

type gb_1 from groupbox within w_caqh_audit
integer x = 1495
integer y = 732
integer width = 1915
integer height = 140
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Data Filter"
end type

type gb_2 from groupbox within w_caqh_audit
integer x = 576
integer width = 1362
integer height = 144
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Date Range"
end type

type ole_browser from olecustomcontrol within w_caqh_audit
event statustextchange ( string text )
event progresschange ( long progress,  long progressmax )
event commandstatechange ( long command,  boolean enable )
event downloadbegin ( )
event downloadcomplete ( )
event titlechange ( string text )
event propertychange ( string szproperty )
event beforenavigate2 ( oleobject pdisp,  any url,  any flags,  any targetframename,  any postdata,  any headers,  ref boolean ab_cancel )
event newwindow2 ( ref oleobject ppdisp,  ref boolean ab_cancel )
event navigatecomplete2 ( oleobject pdisp,  any url )
event documentcomplete ( oleobject pdisp,  any url )
event onquit ( )
event onvisible ( boolean ocx_visible )
event ontoolbar ( boolean toolbar )
event onmenubar ( boolean menubar )
event onstatusbar ( boolean statusbar )
event onfullscreen ( boolean fullscreen )
event ontheatermode ( boolean theatermode )
event windowsetresizable ( boolean ab_resizable )
event windowsetleft ( long left )
event windowsettop ( long top )
event windowsetwidth ( long ocx_width )
event windowsetheight ( long ocx_height )
event windowclosing ( boolean ischildwindow,  ref boolean ab_cancel )
event clienttohostwindow ( ref long cx,  ref long cy )
event setsecurelockicon ( long securelockicon )
event filedownload ( ref boolean ab_cancel )
event navigateerror ( oleobject pdisp,  any url,  any frame,  any statuscode,  ref boolean ab_cancel )
event printtemplateinstantiation ( oleobject pdisp )
event printtemplateteardown ( oleobject pdisp )
event updatepagestatus ( oleobject pdisp,  any npage,  any fdone )
event privacyimpactedstatechange ( boolean bimpacted )
boolean visible = false
integer x = 2062
integer y = 156
integer width = 2217
integer height = 2092
integer taborder = 40
boolean bringtotop = true
boolean focusrectangle = false
string binarykey = "w_caqh_audit.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

event commandstatechange(long command, boolean enable);CHOOSE CASE command
CASE 1 //CSC_NAVIGATEFORWARD
//	cb_forward.enabled = enable
CASE 2 //CSC_NAVIGATEBACK
//	cb_back.enabled = enable
END CHOOSE
end event

event navigatecomplete2(oleobject pdisp, any url);//code to enable back button

end event

type gb_3 from groupbox within w_caqh_audit
integer x = 27
integer width = 507
integer height = 144
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Status Option"
end type

type gb_4 from groupbox within w_caqh_audit
integer x = 928
integer y = 732
integer width = 507
integer height = 144
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Changes Filter"
end type

type st_1 from statictext within w_caqh_audit
boolean visible = false
integer x = 69
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Import Name"
boolean focusrectangle = false
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
00w_caqh_audit.bin 
2A00000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000193f518001d296b600000003000001800000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000009c00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000038856f96111d0340ac0006ba9a205d74f00000000193f518001d296b6193f518001d296b6000000000000000000000000004f00430054004e004e00450053005400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000030000009c000000000000000100000002fffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
24ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000004c000032200000360e0000000000000000000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c0460000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004c000032200000360e0000000000000000000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c0460000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
10w_caqh_audit.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
