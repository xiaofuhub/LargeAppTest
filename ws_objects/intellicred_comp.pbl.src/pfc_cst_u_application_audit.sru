$PBExportHeader$pfc_cst_u_application_audit.sru
forward
global type pfc_cst_u_application_audit from u_base
end type
type gb_1 from groupbox within pfc_cst_u_application_audit
end type
type st_recs from statictext within pfc_cst_u_application_audit
end type
type dw_orgs_facilities from u_dw within pfc_cst_u_application_audit
end type
type dw_tracker from u_dw within pfc_cst_u_application_audit
end type
type st_1 from statictext within pfc_cst_u_application_audit
end type
type cb_add from commandbutton within pfc_cst_u_application_audit
end type
type cb_delete from commandbutton within pfc_cst_u_application_audit
end type
type dw_browse from u_dw within pfc_cst_u_application_audit
end type
type tab_view from tab within pfc_cst_u_application_audit
end type
type tabpage_browse from userobject within tab_view
end type
type tabpage_browse from userobject within tab_view
end type
type tabpage_detail from userobject within tab_view
end type
type gb_2 from groupbox within tabpage_detail
end type
type dw_verif from datawindow within tabpage_detail
end type
type st_11 from statictext within tabpage_detail
end type
type tabpage_detail from userobject within tab_view
gb_2 gb_2
dw_verif dw_verif
st_11 st_11
end type
type tabpage_audit from userobject within tab_view
end type
type dw_audit from u_dw within tabpage_audit
end type
type tabpage_audit from userobject within tab_view
dw_audit dw_audit
end type
type tab_view from tab within pfc_cst_u_application_audit
tabpage_browse tabpage_browse
tabpage_detail tabpage_detail
tabpage_audit tabpage_audit
end type
type dw_detail from u_dw within pfc_cst_u_application_audit
end type
type st_dw_orgs_facilities_border from u_st_border within pfc_cst_u_application_audit
end type
end forward

global type pfc_cst_u_application_audit from u_base
integer width = 4494
integer height = 2012
long picturemaskcolor = 536870912
event pfc_cst_compose_request ( )
event pfc_cst_dial_phone ( )
event pfc_cst_copy_row ( )
event pfc_cst_app_audit_complete ( )
event pfc_cst_add_missing_items ( )
event pfc_cst_add_missing_items_force ( )
event ue_setresize ( )
gb_1 gb_1
st_recs st_recs
dw_orgs_facilities dw_orgs_facilities
dw_tracker dw_tracker
st_1 st_1
cb_add cb_add
cb_delete cb_delete
dw_browse dw_browse
tab_view tab_view
dw_detail dw_detail
st_dw_orgs_facilities_border st_dw_orgs_facilities_border
end type
global pfc_cst_u_application_audit pfc_cst_u_application_audit

type variables
Protected Long il_prac_id
Protected Long il_rec_id
Protected Integer ii_parent_facility_id
Protected w_prac_data_1 iw_win //maha 091008

String is_app_type
integer ii_parent

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<add> 01.24.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Define a variable and set it to TRUE. This modification reduces 
//$<modification> calls together with the condition in PT-03.
boolean ib_first_retrieve = true
//---------------------------- APPEON END ----------------------------

end variables

forward prototypes
protected function integer of_set_prac_id (long al_prac_id)
protected function long of_get_prac_id ()
public function integer of_new_record (long al_prac_id)
public function integer of_setfocus ()
public function integer of_get_rowcount ()
public function boolean of_blank_record ()
public function integer of_get_this_facility_data ()
public function integer of_copy_required_data (long al_prac_id)
public function integer of_retrieve (long al_prac_id)
public function integer of_get_next_seq_no (string as_dw)
public function integer of_set_parent_facility_id (integer ai_parent_facility_id)
public function integer of_retrieve_detail (long ai_rec_id)
public function integer of_print_list ()
public function integer of_add_missing_item ()
public function integer of_app_audit_complete (long al_recid)
public function integer of_set_security ()
public function integer of_bg_color (long al_rgb)
public function integer of_refresh_dddw ()
public function integer of_set_window (w_prac_data_1 aw_win)
public subroutine of_zoom ()
end prototypes

event pfc_cst_compose_request();Long li_rec_ids[]
Long ll_prac_ids[]
Long li_Rec_id
Integer li_org_ids[]
Integer li_facility_ids[]

dw_detail.AcceptText()

// start code change --- 11.01.2005 MSKINNER
// DEFECT 593 - ADDED RETURN SO THAT APP WILL NOT CRASH
if dw_detail.rowcount( ) < 1 THEN RETURN
// END code change --- 11.01.2005 MSKINNER

li_rec_ids[1] = dw_detail.GetItemNumber( 1, "appt_stat_id" )
li_facility_ids[1] = dw_detail.GetItemNumber( 1, "facility_id" )

ll_prac_ids[1] = dw_detail.GetItemNumber( 1, "prac_id" )
is_app_type = dw_detail.GetItemString( 1, "app_type" )
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-04
//$<add> 02.08.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_startqueue()
//---------------------------- APPEON END ----------------------------

dw_detail.Update()
dw_detail.Retrieve( li_rec_ids[1] )

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-05
//$<add> 02.08.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
gnv_appeondb.of_commitqueue()
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-01
//$<modify> 01.13.2006 By: Wang Chao
//$<reason> It is currently unsupported to dynamically create a visual object.
//$<modification> Replace the visual object with a non-visual object.

//pfc_cst_u_generate_miss_info_rqst lnvo_letter
//
//lnvo_letter = create pfc_cst_u_generate_miss_info_rqst
pfc_cst_u_generate_miss_info_rqst_apb lnvo_letter

lnvo_letter = create pfc_cst_u_generate_miss_info_rqst_apb
//---------------------------- APPEON END ----------------------------

lnvo_letter.of_generate_miss_info_letter( li_facility_ids, ll_prac_ids, li_rec_ids, dw_tracker )

DESTROY lnvo_letter
end event

event pfc_cst_dial_phone();String ls_phone_number
Long ll_prac_id
Integer li_facility_id
String ls_local_area_code
Long ll_rec_id

ll_rec_id = dw_detail.GetItemNumber( 1, "appt_stat_id" )
ll_prac_id = dw_detail.GetItemNumber( 1, "prac_id" )
li_facility_id = dw_orgs_facilities.GetItemNumber( dw_orgs_facilities.GetRow(), "parent_facility_id" )
is_app_type = dw_detail.GetItemString( 1, "app_type" )
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-06
//$<add> 02.08.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
gnv_appeondb.of_startqueue()
//---------------------------- APPEON END ----------------------------

dw_detail.Update()
dw_detail.Retrieve( ll_rec_id )

SELECT pd_address.phone  
INTO :ls_phone_number  
FROM pd_address,   
     pd_address_link  
WHERE ( pd_address.rec_id = pd_address_link.address_id ) AND 
      ((pd_address_link.prac_id = :ll_prac_id ) AND  
      ( pd_address_link.facility_id = :li_facility_id ) AND 
		( pd_address.active_status = 1 ) AND
      ( pd_address_link.mailing = 1 ) )   ;
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-07
//$<add> 02.08.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
gnv_appeondb.of_commitqueue()
//---------------------------- APPEON END ----------------------------

ls_local_area_code = ProfileString(gs_IniFilePathName, "Setup","local_area_code", "None")

IF IsNull( ls_local_area_code ) OR ls_local_area_code = "" THEN
	MessageBox("Setup Error", "You must setup your local area code in the INTELLICRED.INI file under the [setup] section.")
	Return
END IF

IF PosA( ls_phone_number, "(" ) > 0 THEN
	IF MidA(ls_phone_number, PosA( ls_phone_number, "(" ) +1 ,3) = ls_local_area_code THEN
		ls_phone_number = MidA( ls_phone_number, PosA( ls_phone_number, ")" ) +1, 100 )
	END IF
ELSE
	IF MidA(ls_phone_number,1,3) = ls_local_area_code THEN
		ls_phone_number = MidA( ls_phone_number, 4, 100 )
	END IF	
END IF

IF ls_phone_number = "" OR IsNull( ls_phone_number ) THEN
	MessageBox("Phone Number", "You must have a phone number entered on the address screen before using this option.")
	Return 
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-02
//$<modify> 01.13.2006 By: Wang Chao
//$<reason> It is currently unsupported to dynamically create a visual object.
//$<modification> Replace the visual object with a non-visual object.
//pfc_cst_u_generate_miss_info_rqst lnvo_phone
//
//lnvo_phone = create pfc_cst_u_generate_miss_info_rqst
pfc_cst_u_generate_miss_info_rqst_apb lnvo_phone

lnvo_phone = create pfc_cst_u_generate_miss_info_rqst_apb
//---------------------------- APPEON END ----------------------------

lnvo_phone.of_dial_phone( ls_phone_number )

DESTROY lnvo_phone
end event

event pfc_cst_copy_row;Integer li_copy_row
Long ll_record_id
Long ll_null
DateTime ldt_null

SetNull( ldt_null )
SetNull( ll_null )

li_copy_row = dw_detail.GetRow()

dw_detail.RowsCopy( li_copy_row, li_copy_row, Primary!, dw_detail, li_copy_row+1, Primary! )

ll_record_id = gnv_app.of_get_id("RECORD_ID")
dw_detail.SetItem( li_copy_row+1, "rec_id", ll_record_id )
dw_detail.SetItem( li_copy_row+1, "data_status", ll_null )
dw_detail.SetItem( li_copy_row+1, "date_completed", ldt_null )
dw_detail.SetItem( li_copy_row+1, "identifying_number", "" )

dw_detail.ScrollToRow( li_copy_row +1 )
dw_detail.SetRow( li_copy_row + 1 )
end event

event pfc_cst_app_audit_complete;long r

if dw_detail.rowcount() > 1 then
	r = dw_detail.getitemnumber(1,"appt_stat_id")
	of_app_audit_complete(r)
end if
end event

event pfc_cst_add_missing_items;of_add_missing_item()
end event

event pfc_cst_add_missing_items_force();//////////////////////////////////////////////////////////////////////
// $<event>pfc_cst_u_application_auditpfc_cst_add_missing_items_force()
// $<arguments>
//		value	integer		
// $<returns> 
// $<description> Required Documents Check Box on Data Entry Screen.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 10.17.2006 by Jack (Inova)
//////////////////////////////////////////////////////////////////////
//Start Code Change ---- 10.30.2006 maha   not used
long ll_prac_id[]
long ll_rec_id[]
long li_rec_id
pfc_cst_nv_data_entry_functions lnv_data_entry
lnv_data_entry = create pfc_cst_nv_data_entry_functions
ll_prac_id[1] = il_prac_id
ll_rec_id[1] = 0
lnv_data_entry.of_create_application_audit_record('',ll_prac_id,0,ll_rec_id,'')
li_rec_id = dw_browse.GetItemNumber( 1, "rec_id" )
of_retrieve_detail( li_Rec_id )
destroy lnv_data_entry

end event

event ue_setresize();//this.of_setResize(TRUE)
//this.inv_resize.of_register(dw_detail, 0, 0, 100, 74)
//this.inv_resize.of_register(dw_tracker, 0, 25, 100, 26)
//
// st_1, cb_add, cb_delete

IF isValid(dw_detail.inv_resize) THEN return

dw_detail.of_setResize(TRUE)
dw_detail.inv_resize.of_setOrigSize(long(dw_detail.object.identifying_number.x) + long(dw_detail.object.identifying_number.width) + 91, dw_detail.height)
dw_detail.inv_resize.of_register("c_description", 0, 0, 40, 0)
dw_detail.inv_resize.of_register("c_description_t", 0, 0, 40, 0)
dw_detail.inv_resize.of_register("date_completed", 40, 0, 0, 0)
dw_detail.inv_resize.of_register("date_completed_t", 40, 0, 0, 0)
dw_detail.inv_resize.of_register("data_status", 40, 0, 0, 0)
dw_detail.inv_resize.of_register("data_status_t", 40, 0, 0, 0)
dw_detail.inv_resize.of_register("b_note", 40, 0, 00, 0)
dw_detail.inv_resize.of_register("notes", 40, 0, 60, 0)
dw_detail.inv_resize.of_register("notes_t", 40, 0, 60, 0)
dw_detail.inv_resize.of_register("identifying_number", 100, 0, 0, 0)
dw_detail.inv_resize.of_register("identifying_number_t", 100, 0, 0, 0)
dw_detail.event resize(0, dw_detail.width, dw_detail.height)

dw_tracker.of_setResize(TRUE)
dw_tracker.inv_resize.of_setOrigSize(long(dw_tracker.object.notes.x) + long(dw_tracker.object.notes.width) + 91, dw_tracker.height)
//dw_tracker.inv_resize.of_register("user_name", 0, 0, 0, 0)
//dw_tracker.inv_resize.of_register("method
//dw_tracker.inv_resize.of_register("b_note
dw_tracker.inv_resize.of_register("notes", 0, 0, 100, 0)
dw_tracker.inv_resize.of_register("notes_t", 0, 0, 100, 0)
dw_tracker.event resize(0, dw_tracker.width, dw_tracker.height)

end event

protected function integer of_set_prac_id (long al_prac_id);il_prac_id = al_prac_id

Return 0
end function

protected function long of_get_prac_id ();Return il_prac_id
end function

public function integer of_new_record (long al_prac_id);Integer l
Integer li_facility_id
Integer li_org_id
Integer li_nr
Integer i
Integer li_rc
Long ll_record_id
n_ds ldw

li_nr = dw_detail.InsertRow(0)

il_rec_id = gnv_app.of_get_id( "RECORD_ID" )


//dw_tracker.Reset()
//dw_tracker.InsertRow(0)


dw_detail.ScrollToRow( li_nr )
dw_detail.SetRow( li_nr )

il_prac_id = al_prac_id

dw_detail.SetFocus()

Return 0

end function

public function integer of_setfocus ();dw_detail.SetFocus()

Return 0
end function

public function integer of_get_rowcount ();Return dw_detail.RowCount()
end function

public function boolean of_blank_record ();IF dw_detail.GetItemStatus( 1, 0, Primary! ) = New! THEN
	Return True
ELSE
	Return False
END IF
end function

public function integer of_get_this_facility_data ();Integer li_found
Integer li_rec_no = 0
Long ll_rec_id

//li_found = dw_orgs_facilities.Find("parent_facility_id = " + String(ii_parent_facility_id), 1, 1000 )
li_found = dw_orgs_facilities.Find("parent_facility_id = " + String(ii_parent_facility_id) + " and active_status <> 6", 1, 1000 ) //(BugA101603) alfee 11.12.2014
IF li_found > 0 THEN
	li_rec_no = li_found
ELSEIF dw_orgs_facilities.RowCount() > 0 THEN
	li_rec_no = 1
END IF

IF li_rec_no > 0 THEN
	dw_orgs_facilities.ScrollToRow( li_rec_no )
	dw_orgs_facilities.SetRow( li_rec_no )
// RP	dw_orgs_facilities.SelectRow( 0, False )
// RP	dw_orgs_facilities.SelectRow( li_rec_no, True )
	dw_browse.Retrieve( il_prac_id, dw_orgs_facilities.GetItemNumber( li_rec_no, "parent_facility_id" ) )	
// RP	dw_browse.SelectRow( 0, False )
// RP	dw_browse.SelectRow(1, True)
	IF dw_browse.RowCount() > 0 THEN
		ll_rec_id = dw_browse.GetItemNumber( 1, "rec_id" )
		of_retrieve_detail( ll_Rec_id )
	END IF	
END IF


RETURN 1
end function

public function integer of_copy_required_data (long al_prac_id);//n_ds ldw_app_audit_facility
//n_ds lds_last_app_audit_seq_no
//n_ds ldw_rqrd_data
//Integer li_row_cnt
//Integer i
//Integer f
//Integer li_seq_no
//Integer li_seq_row_cnt
//Long ll_record_id
//Long ll_app_audit_id
//Integer li_facility_id
//Integer li_facility_row_cnt
//String ls_app_type
//
//
//
//ldw_rqrd_data = CREATE n_ds
//ldw_rqrd_data.DataObject = "d_app_audit_rqrd_data"
//ldw_rqrd_data.of_SetTransObject( SQLCA )
//li_row_cnt = ldw_rqrd_data.Retrieve( li_facility_id, ls_app_type )
//
//ldw_app_audit_facility = CREATE n_ds
//ldw_app_audit_facility.DataObject = "d_application_audit_facilities"
//ldw_app_audit_facility.of_SetTransObject( SQLCA )
//li_facility_row_cnt = ldw_app_audit_facility.Retrieve( al_prac_id )
//
//lds_last_app_audit_seq_no = CREATE n_ds
//lds_last_app_audit_seq_no.DataObject = "d_last_app_audit_seq_no"
//lds_last_app_audit_seq_no.of_SetTransObject( SQLCA )
//
//
//FOR f = 1 TO li_facility_row_cnt
//	FOR i = 1 TO li_row_cnt
//		dw_detail.InsertRow( 0 )
//		ll_record_id = gnv_app.of_get_id("RECORD_ID")
//		dw_detail.SetItem( i, "rec_id", ll_record_id )	
//		dw_detail.SetItem( i, "pd_app_audit_prac_id", al_prac_id )
//		li_facility_id = ldw_app_audit_facility.GetItemNumber( f, "application_audit_facility" )
//		dw_detail.SetItem( i, "pd_app_audit_facility_id", li_facility_id )
//		ll_app_audit_id = ldw_rqrd_data.GetItemNumber( i, "app_audit_id" )
//		dw_detail.SetItem( i, "pd_app_audit_app_audit_id", ll_app_audit_id )
//
//		//find out the last seq no used
//		li_seq_row_cnt = lds_last_app_audit_seq_no.Retrieve( ll_app_audit_id, al_prac_id, li_facility_id )	
//		IF li_seq_row_cnt < 1 THEN
//			li_seq_no = 1 
//		ELSE
//			li_seq_no = lds_last_app_audit_seq_no.GetItemNumber( 1, "last_seq_no" ) + 1
//		END IF	
//		dw_detail.SetItem( i, "seq_no", li_seq_no	) 			
//		dw_detail.SetItem( i, "pd_app_audit_fax_message", ldw_rqrd_data.GetItemString( i, "fax_description" )	) 	
//		dw_detail.SetItem( i, "description", ldw_rqrd_data.GetItemString( i, "description" )	) 		
//	END FOR
//END FOR
//
//DESTROY ldw_rqrd_data
//DESTROY ldw_app_audit_facility
//DESTROY lds_last_app_audit_seq_no
//
////this needs to be moved happen as new stat records are entered
//

RETURN 0
end function

public function integer of_retrieve (long al_prac_id);DataWindowChild dwchild
Long ll_org_id

il_prac_id = al_prac_id

dw_orgs_facilities.Reset()
dw_orgs_facilities.Retrieve( al_prac_id,gs_user_id )

//--------Begin Added by alfee 11.02.2010 ---------------------------
//SK Practitioner Folder
Long ll_found
if ii_parent_facility_id > 0 then 
	//ll_found = dw_orgs_facilities.Find("parent_facility_id =" + String(ii_parent_facility_id), 1, dw_orgs_facilities.rowcount())
	ll_found = dw_orgs_facilities.Find("parent_facility_id =" + String(ii_parent_facility_id) + " and active_status <> 6", 1, dw_orgs_facilities.rowcount()) //(BugA101603 ) alfee 11.12.2014
	if ll_found > 0 then 
		dw_orgs_facilities.SetRow(ll_found)
		dw_orgs_facilities.ScrolltoRow(ll_found)
	end if
end if
//--------End Added -----------------------------------------------------

dw_detail.SetFocus()
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02
//$<add> 01.24.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Set ib_first_retrieved to FALSE to recover the original status.
ib_first_retrieve = False
//---------------------------- APPEON END ----------------------------

RETURN 0
end function

public function integer of_get_next_seq_no (string as_dw);Integer li_row_cnt
Long ll_seq_no
n_ds l_ds

l_ds = CREATE n_ds

CHOOSE CASE as_dw
	CASE "tracker"
		l_ds.DataObject = "d_last_app_audit_attempts_seq_no"
END CHOOSE


l_ds.SetTransObject( SQLCA )
li_row_cnt = l_ds.Retrieve( il_rec_id )
IF li_row_cnt > 0 THEN
	ll_seq_no = l_ds.GetItemNumber( 1, "last_seq_no" )
ELSE
	ll_seq_no = 0
END IF

IF IsNull( ll_seq_no ) THEN
	ll_seq_no = 1 
END IF

DESTROY l_ds


RETURN ll_seq_no

end function

public function integer of_set_parent_facility_id (integer ai_parent_facility_id);ii_parent_facility_id = ai_parent_facility_id

//setup facility org dw
dw_orgs_facilities.of_SetUpdateAble( False )
dw_orgs_facilities.of_SetTransObject(SQLCA)


//setup dw_browse
dw_browse.of_SetUpdateAble( False )
dw_browse.of_SetTransObject( SQLCA )


//setup dw_detail
DataWindowChild dwchild

dw_detail.of_SetRowManager( TRUE )
dw_detail.of_SetReqColumn(True)

dw_detail.of_SetDropDownCalendar( TRUE )
//dw_detail.iuo_calendar.of_Register(dw_detail.iuo_calendar.DDLB)

//dw_detail.of_SetTransObject(SQLCA)

dw_detail.GetChild( "data_status", dwchild )
dwchild.SetTransObject( SQLCA )
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-08
//$<modify> 01.24.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Write script to retrieve data from a cache instead of from the database.

//dwchild.Retrieve("required data status")
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper(lookup_name) = '" + upper('required data status') + "'", dwchild)
//---------------------------- APPEON END ----------------------------

dwchild.InsertRow( 1 )



//setup dw_tracker datawindow
dw_tracker.of_SetDropDownCalendar( TRUE )
//dw_tracker.iuo_calendar.of_Register(dw_tracker.iuo_calendar.DDLB)

dw_tracker.of_SetTransObject(SQLCA)

dw_tracker.of_SetRowManager( TRUE )
dw_tracker.of_SetReqColumn(True)


















Return 1
end function

public function integer of_retrieve_detail (long ai_rec_id);Integer li_org_id
Integer li_rc
Integer li_facility_id
String ls_apptmnt_type

IF dw_orgs_facilities.RowCount() = 0 THEN
	Return -1
END IF
debugbreak()
dw_detail.Retrieve( ai_rec_id )
IF dw_detail.RowCount() > 0 THEN
	il_Rec_id = dw_Detail.GetItemNumber( 1, "appt_stat_id" )
END IF

li_rc = dw_tracker.Retrieve( il_rec_id  )
IF li_rc = 0 OR dw_detail.RowCount() = 0 THEN
	dw_tracker.Reset()
	dw_tracker.InsertRow( 0 )
END IF

 //Start Code Change ----02.07.2017 #V153 maha
tab_view.tabpage_audit.dw_audit.retrieve(ai_rec_id)
 //End Code Change ----02.07.2017
 
dw_Detail.SetFocus( )




RETURN 0
end function

public function integer of_print_list ();//Start Code Change ----08.25.2009 #V92 maha
long ll_rec_id

IF dw_detail.rowcount() > 0 THEN
	//gs_variable_array ls_array
	ll_rec_id = dw_browse.GetItemNumber( 1, "rec_id" )

	openwithparm(w_app_audit_print,ll_rec_id)
	//dw_detail.Print()	
else
	messagebox("Print","Nothing to print")
END IF
//End Code Change---08.25.2009

Return 1
end function

public function integer of_add_missing_item ();integer a
integer ac
integer c
integer cc
integer li_facid
integer li_parent
string ls_app_type
Integer li_row_cnt
Integer i
Long ll_seq_no
Long ll_seq_row_cnt
Long ll_record_id
Long ll_app_audit_id
Integer li_facility_row_cnt
Long ll_appt_stat_id
String ls_version
integer li_find
integer res //maha03.19.2008
n_ds ldw_app_audit_facility
n_ds lds_last_app_audit_seq_no
n_ds ldw_rqrd_data
pfc_cst_nv_data_entry_functions  lnv_def

dw_detail.update() //Start Code Change ----01.07.2008 #V8 maha
ac = of_get_rowcount()

if dw_browse.GetRow() <= 0 then Return 0 //Add by Evan 2008-03-18
if dw_orgs_facilities.getrow() <= 0 then Return 0 //Add by Evan 2008-03-18

lnv_def = create pfc_cst_nv_data_entry_functions  

ll_appt_stat_id = dw_browse.GetItemNumber( dw_browse.GetRow(), "rec_id" )
li_parent = dw_orgs_facilities.getitemnumber(dw_orgs_facilities.getrow(),"parent_facility_id")
if gs_cust_type = "I" then //intelliapp
	ls_app_type = "I"
	li_facid = 1
else
	ls_app_type = dw_browse.GetItemString( dw_browse.GetRow(), "apptmnt_type" ) 
//	li_facid = dw_orgs_facilities.getitemnumber(dw_orgs_facilities.getrow(),"audit_facility")
	li_facid = dw_browse.getitemnumber(dw_browse.getrow(),"application_audit_facility")   //Start Code Change ----10.21.2014 #V14.2 maha - changed reference dw
end if
//End Code Change---10.13.2006



res = lnv_def.of_app_audit_items_add( li_parent,il_prac_id, ll_appt_stat_id,li_facid,"Missing", dw_detail, ls_app_type)

//Start Code Change ----03.20.2008 #V8 maha
if res > 0 then 
	lnv_def.of_app_audit_date_reset(ll_appt_stat_id,il_prac_id)
end if
//End Code Change---03.20.2008

//---------------------------- APPEON END ----------------------------

//FOR i = 1 TO li_row_cnt
//	ll_app_audit_id = ldw_rqrd_data.GetItemNumber( i, "app_audit_id" )
//	li_find = dw_detail.Find ( "app_audit_id = " + string(ll_app_audit_id),  1, ac )
//	if li_find < 1 then
//		//--------------------------- APPEON BEGIN ---------------------------
//		//$<add> 10.17.2006 By: Jack (Inova)
//		//$<reason> Required Documents Check Box on Data Entry Screen.
//		integer li_auto_generate
//		li_auto_generate = ldw_rqrd_data.getitemnumber(i,'auto_generate')
//		if li_auto_generate = 1 then
//			continue
//		end if
//		//---------------------------- APPEON END ----------------------------
//		a = dw_detail.InsertRow( 0 )
//
//		//--------------------------- APPEON BEGIN ---------------------------
//		//$<ID> PT-12
//		//$<modify> 02.24.2006 By: LeiWei
//		//$<reason> Performance tuning
//		//$<modification> Comment out the following script to reduce client-server interaction.
//		//$<modification> refer to PT-11 and of_get_id for more information.
//		/*
//		ll_record_id = gnv_app.of_get_id("RECORD_ID")
//		ll_seq_row_cnt = lds_last_app_audit_seq_no.Retrieve( ll_app_audit_id, il_prac_id, li_facid )	
//		*/
//		ll_record_id ++
//		
//		lds_last_app_audit_seq_no.Setfilter("app_audit_id = " + String( ll_app_audit_id )	)
//		lds_last_app_audit_seq_no.Filter( )
//		ll_seq_row_cnt = lds_last_app_audit_seq_no.Rowcount( )
//		//---------------------------- APPEON END ----------------------------
//		
//		dw_detail.SetItem( a, "rec_id", ll_record_id )
//		dw_detail.SetItem( a, "appt_stat_id", ll_appt_stat_id )
//		dw_detail.SetItem( a, "prac_id", il_prac_id )
//		dw_detail.SetItem( a, "facility_id", li_parent )
//		dw_detail.SetItem( a, "app_audit_id", ll_app_audit_id )
//	
//		//find out the last seq no used
//		IF ll_seq_row_cnt < 1 THEN
//			ll_seq_no = 1 
//		ELSE
//			ll_seq_no = lds_last_app_audit_seq_no.GetItemNumber( 1, "last_seq_no" ) + 1
//		END IF	
//		
//		dw_detail.SetItem( a, "seq_no", ll_seq_no	) 		
//		dw_detail.SetItem( a, "active_status", 1 )
//		dw_detail.SetItem( a, "pd_app_audit_fax_message", ldw_rqrd_data.GetItemString( i, "fax_description" )	) 	
//		dw_detail.SetItem( a, "description", ldw_rqrd_data.GetItemString( i, "description" )	)
//		//--------------------------- APPEON BEGIN ---------------------------
//		//$<add> 10.17.2006 By: Jack (Inova)
//		//$<reason> Required Documents Check Box on Data Entry Screen.
//		dw_detail.SetItem( a, "app_type", ldw_rqrd_data.GetItemString( i, "app_type" )	)		
//		//---------------------------- APPEON END ----------------------------
//	end if
//END FOR
//
//IF dw_detail.Update() = -1 THEN
//	messagebox("", sqlca.sqlerrtext)
//	MessageBox( "Update Error" , "Error updating application audit data.")
//	Return -1
//END IF
//
DESTROY lnv_def
//DESTROY ldw_rqrd_data
//DESTROY ldw_app_audit_facility
//DESTROY lds_last_app_audit_seq_no
of_retrieve_detail( ll_appt_stat_id)
//End Code Change---10.30.2006

RETURN 0


end function

public function integer of_app_audit_complete (long al_recid);//Start Code Change ----09.10.2008 #V85 maha - this function NO LONGER USED
//replaced by one of the same name in action item functions

//Integer li_facility_id
//DateTime ldt_todaysDate
//DateTime ldt_date
//
//
//ldt_todaysdate = DateTime( Today(), Now() )
//
//li_facility_id = dw_orgs_facilities.GetItemNumber( dw_orgs_facilities.GetRow(), "audit_facility" )
////code modified maha 042304 to correct bug
//
//SELECT date_app_audit_completed  
//INTO :ldt_date
//FROM pd_affil_stat
//WHERE pd_affil_stat.rec_id = :al_recid ;
//IF IsNull( ldt_date ) OR String( ldt_date ) = "1/1/00 00:00:00" THEN
//	
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<ID> PT-09
//	//$<add> 02.24.2006 By: LeiWei
//	//$<reason> Performance tuning
//	//$<modification> Add Appeon Commit Queue label to reduce client-server interactions to improve runtime performance.
//
//	//$<reason> Add the Appeon Queue Labels. 
//	gnv_appeondb.of_autocommit( )
//	//---------------------------- APPEON END ----------------------------
//
//	UPDATE pd_affil_stat  
//	SET date_app_audit_completed = :ldt_todaysdate  
//	WHERE pd_affil_stat.rec_id = :al_recid ;
//	IF SQLCA.SQLCODE <> 0 THEN
//		MessageBox("Update Error", "Error updating pb_affil_stat / date_app_audit_completed." )
//		Return -1
//	END IF
//END IF
//
//	
//Commit Using SQLCA;


Return 0

////old code
//Integer li_facility_id
//DateTime ldt_todaysDate
//DateTime ldt_date
//
//
//ldt_todaysdate = DateTime( Today(), Now() )
//
//li_facility_id = dw_orgs_facilities.GetItemNumber( dw_orgs_facilities.GetRow(), "audit_facility" )
////this update has a bug in that if more than one facility uses the same template, all complete dates will be set. maha 031804
//SELECT date_app_audit_completed  
//INTO :ldt_date
//FROM pd_affil_stat
//WHERE ( pd_affil_stat.prac_id = :il_prac_id ) AND  
//      ( pd_affil_stat.application_audit_facility = :li_facility_id )  AND
//		( pd_affil_stat.active_status in (1,4) );  //maha  changed to include pending 072402
//IF IsNull( ldt_date ) OR String( ldt_date ) = "1/1/00 00:00:00" THEN
//	UPDATE pd_affil_stat  
//	SET date_app_audit_completed = :ldt_todaysdate  
//	WHERE ( pd_affil_stat.prac_id = :il_prac_id ) AND  
//   	   ( pd_affil_stat.application_audit_facility = :li_facility_id )  AND
//			( pd_affil_stat.active_status in ( 1,4 ) );  //maha  changed to include pending 072402
//	IF SQLCA.SQLCODE <> 0 THEN
//		MessageBox("Update Error", "Error updating pb_affil_stat / date_app_audit_completed." )
//		Return -1
//	END IF
//END IF
//
//	
//Commit Using SQLCA;
//
//
//Return 0
end function

public function integer of_set_security ();//Start Code Change ----06.16.2009 #V92 maha - added - called from w_prac_data_1. of_retrieve_app_audit

dw_detail.modify("date_completed.protect = 1")
dw_detail.modify("data_status.protect = 1")
dw_detail.modify("identifying_number.protect = 1")
dw_detail.modify("notes.protect = 1")
//dw_detail.Object.b1.Enabled = false
dw_detail.modify("b_1.enabled = 'false'")
//dw_detail.modify("b_note.enabled = false")

//Start Code Change ----10.10.2012 #V12 maha
dw_detail.Modify("date_completed.background.color= '553648127'")
dw_detail.Modify("data_status.background.color= '553648127'")
dw_detail.Modify("identifying_number.background.color= '553648127'")
dw_detail.Modify("notes.background.color= '553648127'")
//End Code Change ----10.10.2012

dw_tracker.modify("date_attempted.protect = 1")
dw_tracker.modify("user_name.protect = 1")
dw_tracker.modify("method.protect = 1")
dw_tracker.modify("notes.protect = 1")

//Start Code Change ----10.10.2012 #V12 maha
dw_tracker.Modify("date_attempted.background.color= '553648127'")
dw_tracker.Modify("user_name.background.color= '553648127'")
dw_tracker.Modify("method.background.color= '553648127'")
dw_tracker.Modify("notes.background.color= '553648127'")
//End Code Change ----10.10.2012


return 1
end function

public function integer of_bg_color (long al_rgb);//Start Code Change ----05.25.2010 #V10 maha
this.backcolor = al_rgb
tab_view.backcolor = al_rgb
tab_view.tabpage_browse.backcolor = al_rgb
tab_view.tabpage_detail.backcolor = al_rgb
st_recs.backcolor = al_rgb
st_1.backcolor = al_rgb





return 1
end function

public function integer of_refresh_dddw ();//$<add> 02.28.2013 By:long.zhang
//$<reason>refresh dddw after Modify datawindow protect property Bug  3420
//$ return type Integer

DataWindowChild dwchild

dw_detail.GetChild( "data_status", dwchild )
dwchild.SetTransObject( SQLCA )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper(lookup_name) = '" + upper('required data status') + "'", dwchild)

return 1
end function

public function integer of_set_window (w_prac_data_1 aw_win);this.iw_win = aw_win

return 1
end function

public subroutine of_zoom ();//Start Code Change ----07.13.2017 #V154 maha
dw_orgs_facilities.Modify("DataWindow.Zoom=" + string(gi_zoom))  
dw_detail.Modify("DataWindow.Zoom=" + string(gi_zoom))
dw_browse.Modify("DataWindow.Zoom=" + string(gi_zoom))
dw_tracker.Modify("DataWindow.Zoom=" + string(gi_zoom))
tab_view.tabpage_audit.dw_audit.Modify("DataWindow.Zoom=" + string(gi_zoom))
end subroutine

on pfc_cst_u_application_audit.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.st_recs=create st_recs
this.dw_orgs_facilities=create dw_orgs_facilities
this.dw_tracker=create dw_tracker
this.st_1=create st_1
this.cb_add=create cb_add
this.cb_delete=create cb_delete
this.dw_browse=create dw_browse
this.tab_view=create tab_view
this.dw_detail=create dw_detail
this.st_dw_orgs_facilities_border=create st_dw_orgs_facilities_border
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.st_recs
this.Control[iCurrent+3]=this.dw_orgs_facilities
this.Control[iCurrent+4]=this.dw_tracker
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.cb_add
this.Control[iCurrent+7]=this.cb_delete
this.Control[iCurrent+8]=this.dw_browse
this.Control[iCurrent+9]=this.tab_view
this.Control[iCurrent+10]=this.dw_detail
this.Control[iCurrent+11]=this.st_dw_orgs_facilities_border
end on

on pfc_cst_u_application_audit.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.st_recs)
destroy(this.dw_orgs_facilities)
destroy(this.dw_tracker)
destroy(this.st_1)
destroy(this.cb_add)
destroy(this.cb_delete)
destroy(this.dw_browse)
destroy(this.tab_view)
destroy(this.dw_detail)
destroy(this.st_dw_orgs_facilities_border)
end on

event constructor;//--------Begin Modified by  Nova 04.26.2010------------------------
//fixed BugN042603	(PB&WEB P3)
//IF Upper( gs_cust_type ) = "I" THEN
//	dw_orgs_facilities.Visible = False	
//	st_1.visible = False //alfee 04.01.2010
//	dw_browse.x = dw_browse.x - 762
//	dw_detail.x = dw_detail.x - 762
//	dw_tracker.x = dw_tracker.x - 762
//	gb_1.x = gb_1.x - 762
//
//	st_recs.x = st_recs.x - 762
//	tab_view.x = tab_view.x - 762
//	
//	tab_view.width = tab_view.width + 762
//	gb_1.width = gb_1.width + 762
//	tab_view.tabpage_detail.gb_2.width = tab_view.tabpage_detail.gb_2.width + 762
//	dw_browse.width = dw_browse.width + 762
//	dw_detail.width = dw_detail.width + 762	
//
//END IF

IF Upper( gs_cust_type ) = "I" THEN
	dw_orgs_facilities.Visible = False	
	st_dw_orgs_facilities_border.Visible = False //Added by Appeon long.zhang 04.24.2017 (BugL042402)
	//st_1.visible = False //alfee 04.01.2010
	dw_browse.x = dw_orgs_facilities.x +27
	dw_detail.x = dw_orgs_facilities.x +27
	dw_tracker.x = dw_orgs_facilities.x +27
	gb_1.x = dw_orgs_facilities.x +27
	//st_recs.x = st_recs.x - 762
	tab_view.x = dw_orgs_facilities.x
	
	//------Begin Modified by alfee 11.17.2010 -------
	st_1.x = dw_detail.x  + 20
	cb_add.x = dw_detail.x + 2075 - 809
	cb_delete.x = dw_detail.x + 2414 - 809
	//------End Modified ---------------------------------
	
	tab_view.width = tab_view.width + dw_orgs_facilities.width
	gb_1.width = gb_1.width + dw_orgs_facilities.width
	tab_view.tabpage_detail.gb_2.width = tab_view.tabpage_detail.gb_2.width + dw_orgs_facilities.width
	dw_browse.width = dw_browse.width + dw_orgs_facilities.width
	dw_detail.width = dw_detail.width + dw_orgs_facilities.width
	dw_tracker.width= dw_detail.width + dw_orgs_facilities.width
END IF
//--------End Modified --------------------------------------------

of_zoom()  //Start Code Change ----07.13.2017 #V154 maha

end event

type gb_1 from groupbox within pfc_cst_u_application_audit
boolean visible = false
integer x = 4375
integer y = 1312
integer width = 78
integer height = 108
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 16777215
string text = "Request For Required Data Log"
borderstyle borderstyle = stylebox!
end type

type st_recs from statictext within pfc_cst_u_application_audit
integer x = 2981
integer y = 40
integer width = 357
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
string text = "Record 1 of 1"
boolean focusrectangle = false
end type

type dw_orgs_facilities from u_dw within pfc_cst_u_application_audit
integer x = 23
integer y = 28
integer width = 905
integer height = 1940
integer taborder = 20
string title = "Select Facility"
string dataobject = "d_pd_affil_status_orgs"
boolean hscrollbar = true
boolean border = false
end type

event rowfocuschanged;call super::rowfocuschanged;Integer li_org_id
Integer li_facility_id
Long ll_rec_id
integer li_stat  //maha 11.06.2014
integer ll_find  //maha 11.06.2014
integer li_row
integer rc

//------------------------------- RP modified 1.13.2016
this.setRedraw(TRUE)

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-03
//$<modify> 01.24.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Make an condition to make the following script not to be executed 
//$<modification> when the value of ib_first_retrieved is TRUE. For more information
//$<modification> refer to PT-01. 
//IF This.RowCount() > 0 THEN
IF This.RowCount() > 0 And not ib_first_retrieve THEN
//---------------------------- APPEON END ----------------------------
//Start Code Change ----11.06.2014 #V14.2 maha - modifications for mid-cycle
	//li_stat = This.GetItemNumber( currentrow, "active_status" )
	rc = dw_browse.Retrieve( il_prac_id, This.GetItemNumber( currentrow, "parent_facility_id" ) )	
	
	
	if rc > 0 then //Add by Stephen 06.01.2011 --- A database error has occurred
		ll_rec_id = This.GetItemNumber( currentrow, "rec_id" )

		li_row = dw_browse.find("rec_id = " + string(ll_rec_id) , 1,rc )	
		dw_browse.setrow(li_row)  //Start Code Change ----12.15.2014 #V14.2 maha
		 //Start Code Change ----02.07.2017 #V153 maha
		of_retrieve_detail( ll_Rec_id )
		 //End Code Change ----02.07.2017 
	end if
END IF

end event

event clicked;call super::clicked;Integer li_row

li_row = This.GetClickedRow( )

IF li_row = 0 THEN
	dw_detail.SetFocus( )
	Return -1
END IF

// RP This.SelectRow( 0, False )
// RP This.SelectRow( li_row, True )
This.ScrollToRow( li_row )
This.SetRow( li_row )
end event

event retrieveend;call super::retrieveend;
of_get_this_facility_data()

//Integer li_org_id
//Integer li_facility_id
//Long ll_rec_id
//
//IF This.RowCount() > 0 THEN
//	dw_browse.Retrieve( il_prac_id, This.GetItemNumber( 1, "parent_facility_id" ) )	
//	dw_browse.SelectRow( 0, False )
//	dw_browse.SelectRow(1, True)
//	IF dw_browse.RowCount() > 0 THEN
//		ll_rec_id = dw_browse.GetItemNumber( 1, "rec_id" )
//		of_retrieve_detail( ll_Rec_id )
//	END IF
//END IF
end event

event constructor;call super::constructor;IF gs_cust_type = "C" THEN
	This.Title = 'Select Client'
ELSEIF gs_cust_type = "I" THEN
	This.Title = 'Select Payor/Hospital'
ELSE
	This.Title = 'Select Facility'
END IF
end event

event pfc_predeleterow;call super::pfc_predeleterow;Return PREVENT_ACTION // Add by Evan 05.14.2009 --- Corrected BugN1215004
end event

type dw_tracker from u_dw within pfc_cst_u_application_audit
integer x = 974
integer y = 1592
integer width = 3483
integer height = 356
integer taborder = 30
boolean bringtotop = true
string title = "Contact Attempts"
string dataobject = "d_pd_app_audit_tracker"
end type

event pfc_preupdate;call super::pfc_preupdate;Integer li_rc
Integer i
Integer li_facility_id
Long ll_seq_no

//Start Code Change ---- 04.18.2006 #403 maha
if dw_detail.rowcount() = 0 then
	MessageBox("Required Data", "You cannot add a Request item if there are no Required Data records." )
	return -1
end if
//End Code Change---04.18.2006
li_rc = This.RowCount( )
li_facility_id = dw_detail.GetItemNumber( dw_detail.GetRow(), "facility_id" )

ll_seq_no = of_get_next_seq_no( "tracker" )

FOR i = 1 TO li_rc
	IF This.GetItemStatus( i, 0, Primary!) = NewModified! THEN
		IF IsNull( This.GetItemString( i, "user_name" ) ) THEN
			MessageBox("Required Data", "User name is required." )
			This.SetRow( i )
			This.SetColumn( "user_name" )			
			Return -1
		END IF
		IF IsNull( This.GetItemString( i, "method" ) ) THEN
			MessageBox("Required Data", "Method is required." )
			This.SetRow( i )
			This.SetColumn( "method" )
			Return -1
		END IF		
		IF IsNull( This.GetItemDateTime( i, "date_attempted" ) ) THEN
			MessageBox("Required Data", "Date Attempted is required." )
			This.SetRow( i )
			This.SetColumn( "date_attempted" )
			Return -1
		END IF				
		ll_seq_no ++
		This.SetItem( i, "seq_no", ll_seq_no )
		This.SetItem( i, "facility_id", li_facility_id )		
		This.SetItem( i , "rec_id", il_rec_id )
		This.SetItem( i, "prac_id", il_prac_id )		
	END IF
END FOR

Return 0
end event

event getfocus;call super::getfocus;//------------------- APPEON BEGIN -------------------
//$<modify> Evan 06.17.2009
//$<reason> Menu readonly security.
/*
IF IsValid( m_pfe_cst_app_audit ) THEN
	m_pfe_cst_app_audit.m_edit.m_insert.enabled = True
	m_pfe_cst_app_audit.m_edit.m_delete1.enabled = True
END IF
*/
//Start Code Change ----07.09.2010 #V10 maha - add delete from buttons
if IsValid(m_pfe_cst_app_audit) then
	if w_mdi.of_security_access(40) < 2 or w_mdi.of_security_access(90) < 2 then
		//m_pfe_cst_app_audit.m_edit.m_insert.enabled = false
		//m_pfe_cst_app_audit.m_edit.m_delete1.enabled = false
		//------Begin Modified by alfee 11.17.2010 -------------
		//tab_view.tabpage_detail.cb_add.visible = false
		//tab_view.tabpage_detail.cb_delete.visible = false
		cb_add.visible = false
		cb_delete.visible = false
		//------End Modified ---------------------------------------
	else
		//m_pfe_cst_app_audit.m_edit.m_insert.enabled = true
		//m_pfe_cst_app_audit.m_edit.m_delete1.enabled = true
		//------Begin Modified by alfee 11.17.2010 -------------
		//tab_view.tabpage_detail.cb_add.visible = true
		//tab_view.tabpage_detail.cb_delete.visible = true
		cb_add.visible = true
		cb_delete.visible = true		
		//------End Modified ---------------------------------------		
	end if
//-------Begin Modified by alfee 11.02.2010 ---------------------
//<$Reason>It will popup a system error (BugA110201)
	//m_pfe_cst_app_audit.m_edit.m_insert.enabled = false
	//m_pfe_cst_app_audit.m_edit.m_delete1.enabled = false
	gnv_app.of_modify_menu_attr( m_pfe_cst_app_audit.m_edit.m_insert,'enabled', false)
	gnv_app.of_modify_menu_attr( m_pfe_cst_app_audit.m_edit.m_delete1,'enabled', false)
end if
//end if
//
//m_pfe_cst_app_audit.m_edit.m_insert.enabled = false
//m_pfe_cst_app_audit.m_edit.m_delete1.enabled = false
//-------End Modified -----------------------------------------------
//End Code Change ----07.09.2010 

//------------------------------------------- RP modified 1.13.2016 -------------------------------------------------------
////Start Code Change ----03.13.2014 #V14.2 maha
//long ll_get
//long ll_lose
//
//ll_get = 16777215 //cream
//ll_lose = 16774640  //blue
//st_1.backcolor = ll_get
//
//this.Object.DataWindow.Color = ll_get
//dw_detail.Object.DataWindow.Color = ll_lose


//End Code Change ----03.13.2014
end event

event buttonclicked;call super::buttonclicked;//Start Code Change ----10.24.2011 #V12 maha - added
string s

if dwo.name = "b_note" then //maha 071006
	//Start Code Change ----09.12.2012 #V12 maha - new exp. notes screen

	//---------Begin Modified by (Appeon)Harry 07.17.2014  for the Bug 4115
	//OpenWithParm( w_ai_notes_new, This.GetItemString( row, "notes" ))
	string ls_notes
	ls_notes = This.GetItemString( row, "notes" )
	if isnull(ls_notes) then ls_notes = ""
	OpenWithParm( w_ai_notes_new, ls_notes)
	//---------End Modfiied ------------------------------------------------------
	
//	IF appeongetclienttype() = 'WEB' THEN  
//		OpenWithParm( w_ai_notes_web, This.GetItemString( row, "notes" )) 
//	ELSE		
//		OpenWithParm( w_ai_notes, This.GetItemString( row, "notes" ))	
//	END IF			

	s = Message.StringParm
	IF s = "Cancel" THEN
		Return -1
	ELSE
		if len(s) > 225 then
			messagebox("Notes","The maximum length for this notes field is 255 characters and will be truncated to that length.")
			s = mid(s,1,255)
		end if
		This.SetItem( row, "notes", s )
		this.update()
	END IF
end if
end event

event constructor;call super::constructor;//this.object.datawindow.color = rgb(240, 243, 244)  //Start Code Change ----05.05.2016 #V15 maha - removed

end event

type st_1 from statictext within pfc_cst_u_application_audit
integer x = 983
integer y = 1516
integer width = 3465
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 16777215
string text = "Contact Attempts"
boolean focusrectangle = false
end type

type cb_add from commandbutton within pfc_cst_u_application_audit
integer x = 2254
integer y = 1504
integer width = 343
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add Attempt"
end type

event clicked;dw_tracker.event pfc_addrow() //alfee 11.17.2010
end event

type cb_delete from commandbutton within pfc_cst_u_application_audit
integer x = 2610
integer y = 1504
integer width = 393
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete Attempt"
end type

event clicked;dw_tracker.event pfc_deleterow() //alfee 11.17.2010
end event

type dw_browse from u_dw within pfc_cst_u_application_audit
boolean visible = false
integer x = 974
integer y = 140
integer width = 3488
integer height = 1816
integer taborder = 50
string dataobject = "d_app_audit_browse"
boolean hscrollbar = true
boolean vscrollbar = false
end type

event rowfocuschanged;call super::rowfocuschanged;Long ll_appt_stat_id

IF currentrow > 0 THEN
//	This.SelectRow( 0, False )// commented by long.zhang 10.19.2012
	//This.SelectRow( currentrow, True ) commented by long.zhang 10.19.2012
	ll_appt_stat_id = dw_browse.GetItemNumber( currentrow, "rec_id" )
	of_retrieve_detail( ll_appt_stat_id )
// RP	This.SelectRow( 0, False )	//added by long.zhang 10.19.2012
// RP	This.SelectRow( currentrow, True )	//added by long.zhang 10.19.2012 Fixed BugL091306 
END IF

// RP
this.setRedraw(TRUE)

st_recs.Text = "Record " + String( currentrow ) + " of " + String( This.RowCount() )

end event

event doubleclicked;tab_view.SelectTab( 2 )
end event

event constructor;call super::constructor;this.object.datawindow.color = rgb(240, 243, 244)

end event

type tab_view from tab within pfc_cst_u_application_audit
integer x = 951
integer y = 24
integer width = 3529
integer height = 1952
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 16777215
boolean raggedright = true
integer selectedtab = 2
tabpage_browse tabpage_browse
tabpage_detail tabpage_detail
tabpage_audit tabpage_audit
end type

on tab_view.create
this.tabpage_browse=create tabpage_browse
this.tabpage_detail=create tabpage_detail
this.tabpage_audit=create tabpage_audit
this.Control[]={this.tabpage_browse,&
this.tabpage_detail,&
this.tabpage_audit}
end on

on tab_view.destroy
destroy(this.tabpage_browse)
destroy(this.tabpage_detail)
destroy(this.tabpage_audit)
end on

event selectionchanged;
if oldindex = -1 or newindex = -1 then return

IF newindex = 1 THEN
	dw_detail.Visible = False
	dw_browse.Visible = True
	dw_tracker.Visible = False // Added by Evan on 03.24.2012
	st_1.visible = false
	cb_add.visible = false
	cb_delete.visible = false
 //Start Code Change ----02.07.2017 #V153 maha
ELSEIF  newindex = 2 THEN
	dw_browse.Visible = False
	dw_detail.Visible = True
	gb_1.BringToTop = True
	dw_tracker.Visible = True // Added by Evan on 03.24.2012
	dw_tracker.BringToTop = True
	st_1.visible = true
	cb_add.visible = true
	cb_delete.visible = true
ELSE
	dw_detail.Visible = False
	dw_browse.Visible = False
	dw_tracker.Visible = False 
	st_1.visible = false
	cb_add.visible = false
	cb_delete.visible = false
 //Start Code Change ----02.07.2017	
END IF

iw_win.of_button_settings( )   //Start Code Change ----02.07.2017 #V153 maha
end event

event selectionchanging;//Long ll_appt_stat_id
//
//IF oldindex = 1 THEN
//	ll_appt_stat_id = dw_browse.GetItemNumber( dw_browse.GetRow(), "rec_id" )
//	of_retrieve_detail( ll_appt_stat_id )
//END IF
end event

type tabpage_browse from userobject within tab_view
integer x = 18
integer y = 100
integer width = 3493
integer height = 1836
long backcolor = 16777215
string text = "Browse"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 553648127
end type

type tabpage_detail from userobject within tab_view
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 3493
integer height = 1836
long backcolor = 16777215
string text = "Detail"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 553648127
gb_2 gb_2
dw_verif dw_verif
st_11 st_11
end type

on tabpage_detail.create
this.gb_2=create gb_2
this.dw_verif=create dw_verif
this.st_11=create st_11
this.Control[]={this.gb_2,&
this.dw_verif,&
this.st_11}
end on

on tabpage_detail.destroy
destroy(this.gb_2)
destroy(this.dw_verif)
destroy(this.st_11)
end on

type gb_2 from groupbox within tabpage_detail
boolean visible = false
integer x = 18
integer y = 4
integer width = 2638
integer height = 1108
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 16777215
string text = "Required Hard Copies/Data"
end type

type dw_verif from datawindow within tabpage_detail
boolean visible = false
integer x = 2779
integer y = 1216
integer width = 206
integer height = 108
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "d_verif_linked_by_recid"
boolean border = false
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
end event

type st_11 from statictext within tabpage_detail
boolean visible = false
integer y = 1172
integer width = 82
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 16777215
string text = "Contact Attempts"
boolean focusrectangle = false
end type

type tabpage_audit from userobject within tab_view
integer x = 18
integer y = 100
integer width = 3493
integer height = 1836
long backcolor = 16777215
string text = "Review Audit"
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
dw_audit dw_audit
end type

on tabpage_audit.create
this.dw_audit=create dw_audit
this.Control[]={this.dw_audit}
end on

on tabpage_audit.destroy
destroy(this.dw_audit)
end on

type dw_audit from u_dw within tabpage_audit
integer y = 8
integer width = 3479
integer height = 1824
integer taborder = 11
string dataobject = "d_affil_stat_review_clist"
boolean hscrollbar = true
end type

event constructor;call super::constructor;this.of_settransobject( sqlca)
end event

event buttonclicked;call super::buttonclicked;string sl_notes

choose case dwo.name	
	case "b_notes"
		this.SetColumn("notes")
		//Start Code Change ----09.12.2012 #V12 maha - new exp. notes screen
		//---------Begin Modified by (Appeon)Harry 07.17.2014  for the Bug 4115
		//OpenWithParm( w_ai_notes_new, This.GetItemString( row, "notes" ))
		string ls_notes
		ls_notes = This.GetItemString( row, "notes" )
		if isnull(ls_notes) then ls_notes = ""
		OpenWithParm( w_ai_notes_new, ls_notes)
		//---------End Modfiied ------------------------------------------------------
		
		//OpenWithParm(w_ai_notes, this.GetItemString(Row, "notes"))		
		if Message.StringParm <> "Cancel" then
			this.SetItem(Row, "notes", Message.StringParm)
		end if
		
	case "b_1"  //complete button
		This.SetItem( row, "data_status", 90741 )
		This.SetItem( row, "date_reviewed", DateTime( Today(), Now() ) )
end choose
end event

type dw_detail from u_dw within pfc_cst_u_application_audit
integer x = 974
integer y = 140
integer width = 3483
integer height = 1356
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_pd_app_audit_rqrd_data"
boolean hscrollbar = true
end type

event pfc_addrow;of_new_record( il_prac_id )

This.SetFocus( )

Return 0


end event

event pfc_postupdate;//Start Code Change ----09.10.2008 #V85 maha - modified to use new of_app_audit_complete function
Integer li_facility_id
Integer li_found
Integer li_rec_no
Integer li_comp[]
Integer i
Integer li_cnt
long ll_recid[]
long ll_prac[] //maha 091008
datetime ld_null//maha 05.20.2015
datetime ld_today //maha 05.20.2015
pfc_n_cst_ai_action_items inv_action_items
pfc_cst_nv_data_entry_functions inv_de_funct

//if this.rowcount() < 1 then return 0 //added maha 011005
if this.rowcount() < 1 then //alfee 11.17.2010
	Call Super::pfc_postupdate
	return 0 
end if

This.SetFocus()

ll_recid[1]  = This.GetItemNumber( This.GetRow(), "appt_stat_id")
ll_prac[1] = il_prac_id
li_comp[1] = 1

li_cnt = 1
 
FOR i = 1 TO This.RowCount()
	This.SetRow( i )
	This.SetColumn( "date_completed" )
	IF LenA( GetText() ) = 0 THEN
		li_cnt = 0
		exit
	END IF
END FOR

 //Start Code Change ----10.19.2015 #V15 maha - change to allow clearing the date if an item is made incomplete
if li_cnt = 0 then li_comp[1] = 0
//IF li_cnt = 1 THEN //no incompletes	 //maha removed
	inv_action_items  = create  pfc_n_cst_ai_action_items 
	inv_action_items.of_app_audit_complete(ll_prac[],ll_recid[],li_comp[])
	destroy  pfc_n_cst_ai_action_items 
	
	//Start Code Change ----05.20.2015 #V15 maha - audit record
	inv_de_funct = create pfc_cst_nv_data_entry_functions
	setnull(ld_null)
	ld_today = datetime(today(),Now())
	if li_cnt = 1 then
		inv_de_funct.of_field_audit_de_compl( ll_recid[1], ll_prac[1], "checklist_comp_date", ld_null, ld_today,ii_parent_facility_id )
	else  //Start Code Change ----10.19.2015 #V15 maha - code for date cleared
		inv_de_funct.of_field_audit_de_compl( ll_recid[1], ll_prac[1], "checklist_comp_date", ld_today, ld_null, ii_parent_facility_id )
	end if

	destroy inv_de_funct
	//Start Code Change ----05.20.2015	
//END IF
 //End Code Change ----10.19.2015 

// Add by andy 01/29/2010 V10.1 - Notification Alert
//
n_cst_notification_alert_upd	lnv_na

lnv_na.of_update_alert_records( "pd_app_audit", This)

// Because I must check column status in the above function,
// I unextend ancestor script and call it at last.
Call Super::pfc_postupdate

Return 0

end event

event pfc_preupdate;call super::pfc_preupdate;//Start Code Change ---- 11.14.2006 #V7 maha  added functionality to complete connected verifications
Integer i
Integer l
integer r
Integer li_row_cnt
Integer li_ver_cnt //maha 04.08.20008
Long ll_record_id
long ll_facil
long ll_screen
long ll_res
datetime  ldt_now


li_row_cnt = This.RowCount()

FOR i = 1 TO li_row_cnt
	IF This.GetItemStatus( i, 0, Primary! ) = DataModified! THEN
		ll_record_id = this.getitemnumber(i,"de_rec_id")
		ll_facil = this.getitemnumber(i,"facility_id")
		ll_screen = this.getitemnumber(i,"screen_id")
		ll_res = this.getitemnumber(i,"default_ver_response_code")
		if isnull(ll_res) then ll_res = 0
	//Start Code Change ----04.09.2008 #V8 maha - reworked code logic
		li_ver_cnt = tab_view.tabpage_detail.dw_verif.retrieve(ll_record_id,ll_screen,ll_facil, gs_user_id)  //changed variable
		if li_ver_cnt > 0 then //if there are connected records //04.09.08 changed variable
			if ll_res = 0 then //if no default is set
				openwithparm(w_app_audit_complete_mes, "A*0") //Start Code Change ----04.09.2008 #V8 maha - changed from V to A
				if MidA(message.stringparm,1,1) = "N" then 
					continue //cancel
				else
					ll_res = long(MidA(message.stringparm,3)) //get the returned response code
				end if
			end if
			for r = 1 to li_ver_cnt // li_row_cnt //Evan 09.16.2011
				ldt_now = datetime(today(),now())
				tab_view.tabpage_detail.dw_verif.setitem(r,"response_code",ll_res)
				tab_view.tabpage_detail.dw_verif.setitem(r,"date_recieved",ldt_now)
				tab_view.tabpage_detail.dw_verif.setitem(r,"user_name",gs_user_id)
				//------------------- APPEON BEGIN -------------------
				//$<add> Evan 09.16.2011
				//$<reason> BugE082003 - New feature
				tab_view.tabpage_detail.dw_verif.setitem(r,"mod_date",ldt_now)
				tab_view.tabpage_detail.dw_verif.setitem(r,"mod_user",gs_user_id)
				//------------------- APPEON END ---------------------
			next
			tab_view.tabpage_detail.dw_verif.update()
		else
			Continue //return 1
		end if
	//End Code Change---04.08.2008
	END IF
END FOR
//End Code Change---11.14.2006

RETURN 1
end event

event retrieveend;call super::retrieveend;IF rowcount > 0 THEN
	//---------Begin Commented by Alfee 11.12.2014 for BugA101603 --------
	//dw_browse.SelectRow( 0, False )
	//dw_browse.SelectRow(1, True)
	//st_recs.Text = "Record 1 of " + String( rowcount )
	//---------End Commented ------------------------------------------------------	
ELSE
	st_recs.Text = "Record 0 of 0"
END IF





end event

event rowfocuschanged;call super::rowfocuschanged;
IF currentrow < 1 THEN
	Return -1
END IF
	
//--------------------------- RP modified 1.13.2016-------------------------------
//this.selectrow(0,false)
//this.selectrow(currentrow,true)
this.setRedraw(TRUE)

st_recs.Text = "Record " + String( currentrow ) + " of " + String( This.RowCount() )


end event

event buttonclicked;//Start Code Change ---- 10.03.2006 #636 maha added code for b_note
long ll_rec
long ll_brec //maha 111808
string ls_ret
long f
integer res //maha 07.26.2011
integer r
string ls_notes

if dwo.name = "b_1" then //complete button
	This.SetItem( row, "data_status", 662 )
	This.SetItem( row, "date_completed", DateTime( Today(), Now() ) )
elseif dwo.name = "b_note" then //maha 071006
	//------Begin Modified by Alfee 01.15.2010 ---------------
	//<$Reason> for a richtext bug in APB 6.0 
		//Start Code Change ----09.12.2012 #V12 maha - new exp. notes screen
	//OpenWithParm( w_ai_notes_new, This.GetItemString( row, "notes" ))
	
	//---------Begin Modified by (Appeon)Harry 07.17.2014  for the Bug 4115
	//OpenWithParm( w_ai_notes_new, "6000@#$"+ This.GetItemString( row, "notes" ))  //Start Code Change ----06.05.2014 #V14.2 maha - added parameter
	
	ls_notes = This.GetItemString( row, "notes" )
	if isnull(ls_notes) then ls_notes = ""
	OpenWithParm( w_ai_notes_new,  "6000@#$"+ ls_notes)
	//---------End Modfiied ------------------------------------------------------
	
//	IF appeongetclienttype() = 'WEB' THEN  
//		//OpenWithParm( w_ai_notes_web, "C" + This.GetItemString( row, "notes" )) 
//		OpenWithParm( w_ai_notes_web, This.GetItemString( row, "notes" )) // changed by long.zhang ---08.25.2011 ---removed C from front
//	ELSE		
//		//OpenWithParm( w_ai_notes, "C" + This.GetItemString( row, "notes" )) //Start Code Change ----03.03.2011 #V11 maha - added C to front
//		OpenWithParm( w_ai_notes, This.GetItemString( row, "notes" ))	// changed by long.zhang ---08.25.2011 ---removed C from front
//	END IF			
	//OpenWithParm( w_ai_notes, This.GetItemString( row, "notes" ))
	//------End Modified --------------------------------------		

	IF Message.StringParm = "Cancel" THEN
		Return -1
	ELSE
		This.SetItem( row, "notes", Message.StringParm )
	END IF
	this.update() //Start Code Change ---- 11.27.2006 #V7 maha
	
//	ll_rec = this.getitemnumber( this.getrow(), "rec_id")
//	openwithparm(w_app_audit_note,ll_rec)
//	ls_ret = message.stringparm
//	if ls_ret = "OK" then
//		ll_brec = dw_browse.GetItemNumber( dw_browse.getrow(), "rec_id" ) //note: different recid
//		of_retrieve_detail( ll_bRec )
//		//Start Code Change ----11.08.2008 #V85 maha - added to scroll to row note add to
//		f = this.find("rec_id =" + string(ll_rec),1,this.rowcount())
//		if f > 0 then
//			this.scrolltorow(f)
//			this.setrow(f)
//		end if
//		//End Code Change---11.18.2008
//	end if
elseif dwo.name = "b_comall" then //Start Code Change ----07.25.2011 #V11 maha 

//Start Code Change ----11.14.2017 #V16 maha - for V16
	openwithparm(w_checklist_batch_compl, il_rec_id)
	if message.doubleparm = 1 then  //reretrieve the data
		of_retrieve_detail( il_rec_id)
	end if


end if
//End Code Change---10.03.2006
end event

event getfocus;call super::getfocus;//------------------- APPEON BEGIN -------------------
//$<modify> Evan 06.17.2009
//$<reason> Menu readonly security.
/*
IF IsValid( m_pfe_cst_app_audit ) THEN
	m_pfe_cst_app_audit.m_edit.m_insert.enabled = False
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 2006-09-13 By: Liu HongXin
	//$<reason> Fix defect.
	/*
	m_pfe_cst_app_audit.m_edit.m_delete1.enabled = False
	*/
	m_pfe_cst_app_audit.m_edit.m_delete1.enabled = True
	//---------------------------- APPEON END ----------------------------
END IF
*/
if IsValid(m_pfe_cst_app_audit) then
	if w_mdi.of_security_access(40) < 2 or w_mdi.of_security_access(90) < 2 then
		//m_pfe_cst_app_audit.m_edit.m_insert.enabled = false
		//m_pfe_cst_app_audit.m_edit.m_delete1.enabled = false
		gnv_app.of_modify_menu_attr( m_pfe_cst_app_audit.m_edit.m_insert,'enabled', false)
		gnv_app.of_modify_menu_attr( m_pfe_cst_app_audit.m_edit.m_delete1,'enabled', false)
	else
		//m_pfe_cst_app_audit.m_edit.m_insert.enabled = false
		//m_pfe_cst_app_audit.m_edit.m_delete1.enabled = true
		gnv_app.of_modify_menu_attr( m_pfe_cst_app_audit.m_edit.m_insert,'enabled', false)
		gnv_app.of_modify_menu_attr( m_pfe_cst_app_audit.m_edit.m_delete1,'enabled', true)
	end if
end if
//------------------- APPEON END ---------------------

//------------------------------ RP modified 1.13.2016--------------------------------------------------
////Start Code Change ----03.13.2014 #V14.2 maha
//long ll_get
//long ll_lose
//
//ll_get = 16777215 //cream
//ll_lose = 16774640  //blue
//
//this.Object.DataWindow.Color = ll_get
//dw_tracker.Object.DataWindow.Color = ll_lose
//
//st_1.backcolor = ll_lose

//End Code Change ----03.13.2014
end event

event rbuttondown;call super::rbuttondown;integer col
integer ret
datetime dtn
string colname
STRING DT

setnull(dtn)

col = this.getclickedcolumn()
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.14.2006 By: Rodger Wu
//$<reason> Fix a defect.

/* colname = this.getcolumnname() */
colname = dwo.name
//---------------------------- APPEON END ----------------------------

if this.Describe( colname + ".ColType") = "datetime" THEN
	//messagebox("dt","dt")
	ret = messagebox("Set Null?","Would you like to set this Date to null?",question!,yesno!,2 )
	if ret = 1 then
		this.setitem(row,col,dtn)
	end if
END IF
end event

event pfc_predeleterow;//if this.rowcount() < 2 then
//	messagebox("Delete","You cannot delete the last app_audit item")
//	Return PREVENT_ACTION
//else
	Return CONTINUE_ACTION
//end if


end event

event clicked;call super::clicked;integer r

r = this.getclickedrow( )
this.setrow(r)
end event

event constructor;call super::constructor;//this.object.datawindow.color = rgb(240, 243, 244)  //Start Code Change ----05.05.2016 #V15 maha - removed

end event

type st_dw_orgs_facilities_border from u_st_border within pfc_cst_u_application_audit
integer x = 18
integer y = 24
integer width = 914
integer height = 1948
end type

