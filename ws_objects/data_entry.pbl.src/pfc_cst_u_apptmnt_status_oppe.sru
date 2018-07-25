$PBExportHeader$pfc_cst_u_apptmnt_status_oppe.sru
forward
global type pfc_cst_u_apptmnt_status_oppe from userobject
end type
type st_recs from statictext within pfc_cst_u_apptmnt_status_oppe
end type
type dw_orgs_facilities from u_dw within pfc_cst_u_apptmnt_status_oppe
end type
type tab_view from tab within pfc_cst_u_apptmnt_status_oppe
end type
type tabpage_browse from userobject within tab_view
end type
type dw_browse from u_dw within tabpage_browse
end type
type tabpage_browse from userobject within tab_view
dw_browse dw_browse
end type
type tabpage_detail_1 from userobject within tab_view
end type
type st_6 from statictext within tabpage_detail_1
end type
type st_5 from statictext within tabpage_detail_1
end type
type st_4 from statictext within tabpage_detail_1
end type
type st_3 from statictext within tabpage_detail_1
end type
type st_2 from statictext within tabpage_detail_1
end type
type st_1 from statictext within tabpage_detail_1
end type
type sle_4 from singlelineedit within tabpage_detail_1
end type
type sle_3 from singlelineedit within tabpage_detail_1
end type
type sle_2 from singlelineedit within tabpage_detail_1
end type
type sle_1 from singlelineedit within tabpage_detail_1
end type
type dw_apptmnt_status from u_dw within tabpage_detail_1
end type
type gb_6 from groupbox within tabpage_detail_1
end type
type dw_comm_review from u_dw within tabpage_detail_1
end type
type gb_1 from groupbox within tabpage_detail_1
end type
type tabpage_detail_1 from userobject within tab_view
st_6 st_6
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
sle_4 sle_4
sle_3 sle_3
sle_2 sle_2
sle_1 sle_1
dw_apptmnt_status dw_apptmnt_status
gb_6 gb_6
dw_comm_review dw_comm_review
gb_1 gb_1
end type
type tabpage_detail_2 from userobject within tab_view
end type
type dw_leave from u_dw within tabpage_detail_2
end type
type dw_cvo from u_dw within tabpage_detail_2
end type
type gb_5 from groupbox within tabpage_detail_2
end type
type gb_2 from groupbox within tabpage_detail_2
end type
type gb_3 from groupbox within tabpage_detail_2
end type
type dw_staff_cat from u_dw within tabpage_detail_2
end type
type gb_4 from groupbox within tabpage_detail_2
end type
type dw_departments from u_dw within tabpage_detail_2
end type
type tabpage_detail_2 from userobject within tab_view
dw_leave dw_leave
dw_cvo dw_cvo
gb_5 gb_5
gb_2 gb_2
gb_3 gb_3
dw_staff_cat dw_staff_cat
gb_4 gb_4
dw_departments dw_departments
end type
type tabpage_quest from userobject within tab_view
end type
type dw_quest from u_dw within tabpage_quest
end type
type tabpage_quest from userobject within tab_view
dw_quest dw_quest
end type
type tab_view from tab within pfc_cst_u_apptmnt_status_oppe
tabpage_browse tabpage_browse
tabpage_detail_1 tabpage_detail_1
tabpage_detail_2 tabpage_detail_2
tabpage_quest tabpage_quest
end type
end forward

global type pfc_cst_u_apptmnt_status_oppe from userobject
integer width = 3520
integer height = 1732
boolean border = true
long backcolor = 79741120
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event pfc_cst_print_net_dev_ltr ( )
event pfc_cst_print_net_dev_report ( )
event pfc_cst_multi_app ( )
st_recs st_recs
dw_orgs_facilities dw_orgs_facilities
tab_view tab_view
end type
global pfc_cst_u_apptmnt_status_oppe pfc_cst_u_apptmnt_status_oppe

type variables
Protected Long il_prac_id
Protected Long il_rec_id
pfc_cst_nv_data_entry_functions inv_data_entry

Protected Integer ii_verifying_facility_id
Protected Integer ii_parent_facility_id
Protected Integer ii_selected_facility_id
Protected Integer ii_app_id


Protected Boolean ib_new_prac = False
Protected Boolean ib_first_retrieve = True
Protected Boolean ib_new_record = False
Protected Boolean ib_retrieved_allready = False
boolean ib_multiapp = false //maha 12.12.07

Protected Boolean ib_changed_app_audit = False
Protected Boolean ib_changed_parent_facility = False

Protected w_prac_data_1 iw_win
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<add> 02.22.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Define variables to be used in subsequent script.
boolean ib_set_dw2 , ib_retrieve_detail2,ib_select
datastore ids_fields
datastore ids_spec_link
datastore ids_all_spec
datastore ids_address_link
datastore ids_all_addresses
datastore ids_hosp_link
datastore ids_all_hosp
datastore ids_last_app_audit_seq_no
datastore idw_rqrd_data
datastore idw_audit
datastore ids_address_linked
Long	 ii_audit_rec //Changed from integer to long. Rodger Wu on Octo.20, 2006.

boolean 	ib_postupdate = false
Long il_rec_id_multi_app
//---------------------------- APPEON END ----------------------------

//Added for Work Flow. 10/30/2006 Henry
long		il_wf_new_practitioner
string	is_dept_chairperson
integer  ii_ori_status

//Added for work flow.12.19.2006 Jervis
boolean ib_workflow = false

n_cst_datetime inv_datetime //Alfee 11.06.2008

end variables

forward prototypes
protected function long of_get_prac_id ()
public function integer of_new_record (long al_prac_id)
public function integer of_setfocus ()
public function integer of_get_rowcount ()
public function boolean of_blank_record ()
public function integer of_get_this_facility_data ()
public function integer of_copy_required_data (integer ai_facility_id, string as_app_type)
public function integer of_get_next_seq_no (string as_dw)
public function boolean of_is_new_record ()
public function integer of_set_new_record (boolean ab_val)
public function integer of_get_verifying_facility_id ()
public function integer of_set_new_prac (boolean ab_val)
public function integer of_get_parent_facility_id ()
public function integer of_set_select_facility_invisible (boolean ab_val)
public function integer of_view_current_status_only ()
public function integer of_retrieve_children ()
public function integer of_set_prac_id (long al_prac_id)
public function integer of_set_comm_protected ()
public function integer of_back_from_commit_rqrd_flds ()
public function integer of_set_parent_facility_id (integer ai_facility_id)
public function integer of_is_app_audit_complete ()
public function integer of_is_de_complete ()
public function integer of_refresh_detail ()
public function integer of_retrieve_detail ()
public function integer of_retrieve (long al_prac_id)
public function integer of_add_address_link (integer ai_facility_id)
public function integer of_filter_just_active (boolean ab_active)
public function integer of_reset ()
public function boolean of_changed_app_audit ()
public function boolean of_changed_parent_facility ()
public function integer of_add_hosp_links (readonly integer ai_facil_id)
public function integer of_multi_app ()
public function integer of_set_parent_window (w_prac_data_1 aw_win)
public function integer of_add_spec_links (integer ai_facil_id)
public function integer of_setup_dw ()
public function integer of_null_dates ()
public function integer of_appoint_note ()
public function integer of_set_active (integer ai_status)
public function integer of_se ()
public function integer of_custom_labels (datawindow adw_from)
public function integer of_validate (datawindow adw_from)
public function integer of_setup_dw2 ()
public function integer of_retrieve_children2 ()
public function integer of_create_action_item_by_workflow (string as_type)
public function integer of_view_supporting_doc (long al_rec_id)
public function integer of_add_net_dev_ai (string as_app_type, integer ai_app_id, integer ai_facility)
end prototypes

event pfc_cst_print_net_dev_ltr;//tab_view.tabpage_netdev.uo_net_dev.Event pfc_cst_print_net_dev_ltr()
end event

event pfc_cst_print_net_dev_report;//tab_view.tabpage_netdev.uo_net_dev.Event pfc_cst_print_net_dev_report()
end event

event pfc_cst_multi_app;of_multi_app()
end event

protected function long of_get_prac_id ();Return il_prac_id
end function

public function integer of_new_record (long al_prac_id);Integer l
Integer li_org_id
Integer li_nr
Integer i
Integer li_rc
Integer li_num_comms
Integer c
Long ll_record_id
DataWindowChild dwchild
n_ds ldw
n_ds lds_cred_comms

li_nr = tab_view.tabpage_detail_1.dw_apptmnt_status.InsertRow(0)

IF gb_se_version = True THEN
	tab_view.tabpage_detail_1.dw_apptmnt_status.setitem(li_nr,"parent_facility_id",1)
	tab_view.tabpage_detail_1.dw_apptmnt_status.setitem(li_nr,"verifying_facility",1)
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02
//$<modify> 04.12.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Modify the script to ensure that the application hits the database only once.

//il_rec_id = gnv_app.of_get_id( "RECORD_ID" )
If il_rec_id_multi_app = 0 Then
	il_rec_id = gnv_app.of_get_id( "RECORD_ID" )
Else
	il_rec_id_multi_app ++
	il_rec_id =  il_rec_id_multi_app
End IF
//---------------------------- APPEON END ----------------------------
tab_view.tabpage_detail_1.dw_apptmnt_status.setitem(li_nr,"prov_status",0)

tab_view.tabpage_detail_2.dw_departments.Reset()
tab_view.tabpage_detail_2.dw_departments.InsertRow(0)

tab_view.tabpage_detail_2.dw_staff_cat.Reset()
tab_view.tabpage_detail_2.dw_staff_cat.InsertRow(0)

tab_view.tabpage_detail_1.dw_apptmnt_status.ScrollToRow( li_nr )
tab_view.tabpage_detail_1.dw_apptmnt_status.SetRow( li_nr )

il_prac_id = al_prac_id

tab_view.tabpage_detail_1.dw_apptmnt_status.SetFocus()

ib_new_record = True

tab_view.tabpage_detail_1.dw_comm_review.Reset()

iw_win.ib_net_retrieved = False

Return 0

end function

public function integer of_setfocus ();tab_view.tabpage_detail_1.dw_apptmnt_status.SetFocus()

Return 0
end function

public function integer of_get_rowcount ();Return tab_view.tabpage_detail_1.dw_apptmnt_status.RowCount()
end function

public function boolean of_blank_record ();IF tab_view.tabpage_detail_1.dw_apptmnt_status.GetItemStatus( 1, 0, Primary! ) = New! THEN
	Return True
ELSE
	Return False
END IF
end function

public function integer of_get_this_facility_data ();Integer li_found
Integer li_rec_no = 0

li_found = dw_orgs_facilities.Find("parent_facility_id = " + String(ii_parent_facility_id), 1, 1000 )
IF li_found > 0 THEN
	li_rec_no = li_found
ELSEIF dw_orgs_facilities.RowCount() > 0 THEN
	li_rec_no = 1
END IF

IF li_rec_no > 0 THEN
	dw_orgs_facilities.ScrollToRow( li_rec_no )
	dw_orgs_facilities.SetRow( li_rec_no )
	dw_orgs_facilities.SelectRow( 0, False )
	dw_orgs_facilities.SelectRow( li_rec_no, True )
	ii_selected_facility_id = dw_orgs_facilities.GetItemNumber( li_rec_no, "parent_facility_id" )
	of_retrieve_detail(  )	
END IF

Return 0
end function

public function integer of_copy_required_data (integer ai_facility_id, string as_app_type);n_ds ldw_app_audit_facility
n_ds lds_last_app_audit_seq_no
n_ds ldw_rqrd_data
n_ds ldw_audit
Integer li_row_cnt
Integer i
Long ll_seq_no
Long ll_seq_row_cnt
Long ll_record_id
Long ll_app_audit_id
Integer li_facility_row_cnt
Long ll_appt_stat_id
String ls_version
Long   ll_app_audit_id_old = -1

//check to see if security is installed, if it is not then give access to new view
ls_version = ProfileString(gs_IniFilePathName, "setup", "version", "None")
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-03
//$<modify> 01.17.2006 By: Cao YongWang
//$<reason> The Web application does not need to check whether there is an INI file on local machine.
//$<modification> Make an condition that when the application runs on the Web, the application does not check
//$<modification> the local INI file.

//IF NOT FileExists( gs_dir_path + "intellicred\intellicred.ini" ) THEN
//	MessageBox("ini File Error", "No intellicred.ini file found at: " + gs_dir_path + "intellicred\intellicred.ini" )
//	Return -1
//END IF
If appeongetclienttype() = 'PB' Then
	IF NOT FileExists(gs_IniFilePathName) THEN
		//MessageBox("ini File Error", "No intellicred.ini file found at: " + gs_IniFilePathName )
		MessageBox("INI File Error", "No intellicred.ini file was found at: " + gs_IniFilePathName )
		Return -1
	END IF
End If
//---------------------------- APPEON END ----------------------------

IF ls_version = "None" THEN
	MessageBox("Error", "Version number not setup.")
	RETURN -1
END IF

//app audit
IF MidA( ls_version, 11, 1) <> "4" THEN
	RETURN 0
END IF

ll_appt_stat_id = tab_view.tabpage_detail_1.dw_apptmnt_status.GetItemNumber( tab_view.tabpage_detail_1.dw_apptmnt_status.GetRow(), "rec_id" )

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-04
//$<modify> 03.22.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Write script to retrieve data from a cache instead of from the database.

/*
ldw_audit = CREATE n_ds
ldw_audit.DataObject = "d_pd_app_audit_rqrd_data"
ldw_audit.of_SetTransObject( SQLCA )

ldw_rqrd_data = CREATE n_ds
ldw_rqrd_data.DataObject = "d_app_audit_rqrd_data"
ldw_rqrd_data.of_SetTransObject( SQLCA )

li_row_cnt = ldw_rqrd_data.Retrieve( ai_facility_id, as_app_type )

lds_last_app_audit_seq_no = CREATE n_ds
lds_last_app_audit_seq_no.DataObject = "d_last_app_audit_seq_no"
lds_last_app_audit_seq_no.of_SetTransObject( SQLCA )


FOR i = 1 TO li_row_cnt
	ldw_audit.InsertRow( 0 )

	ll_record_id = gnv_app.of_get_id("RECORD_ID")
		
	ll_app_audit_id = ldw_rqrd_data.GetItemNumber( i, "app_audit_id" )
	ldw_audit.SetItem( i, "rec_id", ll_record_id )
	ldw_audit.SetItem( i, "appt_stat_id", ll_appt_stat_id )
	ldw_audit.SetItem( i, "prac_id", il_prac_id )
	ldw_audit.SetItem( i, "facility_id", tab_view.tabpage_detail_1.dw_apptmnt_status.GetItemNumber( tab_view.tabpage_detail_1.dw_apptmnt_status.GetRow(), "parent_facility_id" ) )
	ldw_audit.SetItem( i, "app_audit_id", ll_app_audit_id )

	//find out the last seq no used
	ll_seq_row_cnt = lds_last_app_audit_seq_no.Retrieve( ll_app_audit_id, il_prac_id, ai_facility_id )	
	IF ll_seq_row_cnt < 1 THEN
		ll_seq_no = 1 
	ELSE
		ll_seq_no = lds_last_app_audit_seq_no.GetItemNumber( 1, "last_seq_no" ) + 1
	END IF	
	
	ldw_audit.SetItem( i, "seq_no", ll_seq_no	) 		
	ldw_audit.SetItem( i, "active_status", 1 )
	ldw_audit.SetItem( i, "pd_app_audit_fax_message", ldw_rqrd_data.GetItemString( i, "fax_description" )	) 	
	ldw_audit.SetItem( i, "description", ldw_rqrd_data.GetItemString( i, "description" )	) 		
END FOR

IF ldw_audit.Update() = -1 THEN
	messagebox("", sqlca.sqlerrtext)
	MessageBox( "Update Error" , "Error updating application audit data.")
	Return -1
END IF

DESTROY ldw_audit
DESTROY ldw_rqrd_data
DESTROY ldw_app_audit_facility
DESTROY lds_last_app_audit_seq_no
*/
long ll_insrow
li_row_cnt = idw_rqrd_data.setfilter("facility_id="+string(ai_facility_id) + " and upper(app_type)='" + upper(as_app_type) + "'")

li_row_cnt = idw_rqrd_data.filter()

li_row_cnt = idw_rqrd_data.RowCount()

ll_record_id = ii_audit_rec

//<add> 07/24/2007 by: Andy
idw_rqrd_data.setsort( "app_audit_id A")
idw_rqrd_data.sort( )
//end of add

FOR i = 1 TO li_row_cnt
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 10.17.2006 By: Jack (Inova)
	//$<reason> Required Documents Check Box on Data Entry Screen.
	integer li_auto_generate
	li_auto_generate = idw_rqrd_data.getitemnumber(i,'auto_generate')
	if li_auto_generate = 1 then
		continue
	end if
	//---------------------------- APPEON END ----------------------------
	ll_insrow = idw_audit.InsertRow( 0 )

	ll_record_id = ll_record_id + 1
		
	ll_app_audit_id = idw_rqrd_data.GetItemNumber( i, "app_audit_id" )
	idw_audit.SetItem( ll_insrow, "rec_id", ll_record_id )
	idw_audit.SetItem( ll_insrow, "appt_stat_id", ll_appt_stat_id )
	idw_audit.SetItem( ll_insrow, "prac_id", il_prac_id )
	idw_audit.SetItem( ll_insrow, "facility_id", tab_view.tabpage_detail_1.dw_apptmnt_status.GetItemNumber( tab_view.tabpage_detail_1.dw_apptmnt_status.GetRow(), "parent_facility_id" ) )
	idw_audit.SetItem( ll_insrow, "app_audit_id", ll_app_audit_id )
	
	//<Modify> 07/24/2007 by: Andy
	if ll_app_audit_id_old <> ll_app_audit_id then
		//find out the last seq no used  
		ids_last_app_audit_seq_no.setfilter( "app_audit_id = "+string(ll_app_audit_id)	)
		ids_last_app_audit_seq_no.filter()
		ll_seq_row_cnt = ids_last_app_audit_seq_no.RowCount()
		IF ll_seq_row_cnt < 1 THEN
			ll_seq_no = 1 
		ELSE
			ll_seq_no = ids_last_app_audit_seq_no.GetItemNumber( 1, "last_seq_no" ) + 1
		END IF
		ll_app_audit_id_old = ll_app_audit_id
	else
		ll_seq_no ++
	end if
	//end of modify
	
	idw_audit.SetItem( ll_insrow, "seq_no", ll_seq_no	) 		
	idw_audit.SetItem( ll_insrow, "active_status", 1 )
	idw_audit.SetItem( ll_insrow, "pd_app_audit_fax_message", idw_rqrd_data.GetItemString( i, "fax_description" )	) 	
	idw_audit.SetItem( ll_insrow, "description", idw_rqrd_data.GetItemString( i, "description" )	) 		
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 10.17.2006 By: Jack (Inova)
	//$<reason> Required Documents Check Box on Data Entry Screen.
	idw_audit.SetItem( ll_insrow, "app_type", idw_rqrd_data.GetItemString( i, "app_type" )	)		
	//---------------------------- APPEON END ----------------------------
END FOR

//---------------------------- APPEON END ----------------------------

RETURN 0

end function

public function integer of_get_next_seq_no (string as_dw);Integer li_row_cnt
Long ll_seq_no
n_ds l_ds

l_ds = CREATE n_ds

CHOOSE CASE as_dw
	CASE "department"
		l_ds.DataObject = "d_last_affill_dept_seq_no"
	CASE "staff cat"
		l_ds.DataObject = "d_last_affill_last_cat_seq_no"		
	CASE "comm review"
		l_ds.DataObject = "d_last_affill_comm_review_seq_no"			
	CASE "leave"
		l_ds.DataObject = "d_last_affill_leave"			
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

public function boolean of_is_new_record ();Return ib_new_record
end function

public function integer of_set_new_record (boolean ab_val);ib_new_record = ab_val

Return 1
end function

public function integer of_get_verifying_facility_id ();Return ii_verifying_facility_id
end function

public function integer of_set_new_prac (boolean ab_val);ib_new_prac = ab_val

Return 0


end function

public function integer of_get_parent_facility_id ();Return ii_parent_facility_id
end function

public function integer of_set_select_facility_invisible (boolean ab_val);dw_orgs_facilities.Visible = ab_val

Return 0
end function

public function integer of_view_current_status_only ();tab_view.tabpage_detail_1.dw_apptmnt_status.SetFilter("active_status = 1")
tab_view.tabpage_detail_1.dw_apptmnt_status.Filter( )

Return 0
end function

public function integer of_retrieve_children ();Integer li_rc
Long ll_rec_id

if tab_view.tabpage_detail_1.dw_apptmnt_status.rowcount() < 1 then //trap 0301104
	return -1
else
	ii_verifying_facility_id = tab_view.tabpage_detail_1.dw_apptmnt_status.GetItemNumber(tab_view.tabpage_detail_1.dw_apptmnt_status.GetRow() , "verifying_facility" )
end if

ll_rec_id = tab_view.tabpage_detail_1.dw_apptmnt_status.GetItemNumber(tab_view.tabpage_detail_1.dw_apptmnt_status.GetRow() , "rec_id" )
IF NOT IsNull(ll_rec_id) THEN
	il_rec_id = ll_rec_id
END IF
//	tab_view.tabpage_detail_2.dw_departments.SetTransObject( SQLCA )//maha082201
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-05
//$<comment> 02.10.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Move the following script that retrieves data for tabpage_detail_2 to the of_retrieve_children2 funtion.
//$<modification> Make the condition that of_retrieve_children2 will be executed to retrieve data only when
//$<modification> tabpage_browse or tabpage_quest is selected, since data in tabpage_detail_2 is used only by 
//$<modification> tabpage_browse and tabpage_quest.

/*
li_rc = tab_view.tabpage_detail_2.dw_departments.Retrieve( il_rec_id,gs_user_id  )//gs_user_id addedmaha120301
IF li_rc = 0 THEN
	tab_view.tabpage_detail_2.dw_departments.InsertRow( 0 )
END IF
*/

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 07.3.2007 By: Jervis
//$<reason> Fixed bug in john's mail(number 5 in "Inova Issues for development" mail at 2007.6.29)
//On appointment status screen child record active_status is not always
//being saved when changing to history
/*
ib_retrieve_detail2 = true
If tab_view.SelectedTab = 3 or tab_view.SelectedTab = 4 Then of_retrieve_children2()
*/
If not ib_set_dw2 Then 
	of_setup_dw2()
	ib_set_dw2 = true
End If

of_retrieve_children2()
ib_retrieve_detail2 = false
//---------------------------- APPEON END ----------------------------
//---------------------------- APPEON END ----------------------------

tab_view.tabpage_detail_1.dw_comm_review.of_SetTransObject( SQLCA )
datawindowchild dwchild
tab_view.tabpage_detail_1.dw_comm_review.GetChild( "committee_id", dwchild )
IF dwchild.RowCount() = 0 THEN
	dwchild.SetTransObject( SQLCA )
	dwchild.InsertRow( 0 ) 		
END IF

//tab_view.tabpage_detail_1.dw_apptmnt_status.of_SetTransObject( SQLCA )
//datawindowchild dwchild
//tab_view.tabpage_detail_1.dw_apptmnt_status.GetChild( "parent_facility_id", dwchild )
//IF dwchild.RowCount() = 0 THEN
//	dwchild.SetTransObject( SQLCA )
//	dwchild.InsertRow( 0 ) 		
//END IF

//li_rc = tab_view.tabpage_detail_2.dw_cvo.Retrieve( il_rec_id,ii_verifying_facility_id,gs_user_id )
//tab_view.tabpage_detail_1.dw_comm_review.SetTransObject( SQLCA )//maha082201

li_rc = tab_view.tabpage_detail_1.dw_comm_review.Retrieve( il_rec_id,gs_user_id )
IF li_rc = 0 THEN
	tab_view.tabpage_detail_1.dw_comm_review.InsertRow( 0 )
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-06
//$<comment> 02.10.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Move the following script that retrieves data for tab page 2 to the of_retrieve_children2 funtion.
//$<modification> Refer to PT-05 for more information.

/*
//tab_view.tabpage_detail_2.dw_staff_cat.SetTransObject( SQLCA )//maha082201
li_rc = tab_view.tabpage_detail_2.dw_staff_cat.Retrieve( il_rec_id,gs_user_id )
IF li_rc = 0 THEN
	tab_view.tabpage_detail_2.dw_staff_cat.InsertRow( 0 )
END IF
//tab_view.tabpage_detail_2.dw_leave.SetTransObject( SQLCA )//maha082201
li_rc = tab_view.tabpage_detail_2.dw_leave.Retrieve( il_rec_id,gs_user_id )
IF li_rc = 0 THEN
	tab_view.tabpage_detail_2.dw_leave.InsertRow( 0 )
END IF
//tab_view.tabpage_detail_2.dw_cvo.SetTransObject( SQLCA )//maha120301

//questions maha 090205
tab_view.tabpage_quest.dw_quest.Retrieve( il_rec_id,gs_user_id )
*/
//---------------------------- APPEON END ----------------------------

tab_view.tabpage_detail_1.dw_apptmnt_status.SetFocus( )

RETURN 0
end function

public function integer of_set_prac_id (long al_prac_id);il_prac_id = al_prac_id
//tab_view.tabpage_netdev.uo_net_dev.of_Set_Prac_id( il_prac_id )
//tab_view.tabpage_netdev.uo_net_dev.of_Retrieve_Detail()


IF gb_se_version THEN
	of_se( )
END IF


Return 0
end function

public function integer of_set_comm_protected ();Integer li_rc
Integer i

li_rc = tab_view.tabpage_detail_1.dw_comm_review.RowCount()

FOR i = 1 TO li_rc
	IF tab_view.tabpage_detail_1.dw_comm_review.GetItemNumber( i, "committee_id" ) = gl_committee_id THEN
		tab_view.tabpage_detail_1.dw_comm_review.SetItem( i, "editable", 1 )
	ELSE
		tab_view.tabpage_detail_1.dw_comm_review.SetItem( i, "editable", 0 )
	END IF
END FOR

tab_view.tabpage_detail_1.dw_comm_review.SetColumn( "date_back_from_review" )

Return 0
end function

public function integer of_back_from_commit_rqrd_flds ();Integer i
Integer li_rc
Integer li_comm_row
Integer li_null_cnt

li_rc = tab_view.tabpage_detail_1.dw_comm_review.RowCount()

FOR i = 1 TO li_rc
	IF tab_view.tabpage_detail_1.dw_comm_review.GetItemNumber( i, "editable" ) = 1 THEN
		li_comm_row = i
		Exit
	END IF
END FOR

IF IsNull(tab_view.tabpage_detail_1.dw_comm_review.GetItemDateTime( li_comm_row, "date_back_from_review" ) ) THEN
	MessageBox( "Missing Data", "Date Returned field must be filled in.")
	tab_view.tabpage_detail_1.dw_comm_review.SetColumn( "date_back_from_review" )
	tab_view.tabpage_detail_1.dw_comm_review.SetFocus()
	Return -1
END IF

IF IsNull(tab_view.tabpage_detail_1.dw_comm_review.GetItemNumber( li_comm_row, "review_results" ) ) THEN
	MessageBox( "Missing Data", "Approval Code field must be filled in.")
	tab_view.tabpage_detail_1.dw_comm_review.SetColumn( "review_results" )
	tab_view.tabpage_detail_1.dw_comm_review.SetFocus()
	Return -1
END IF

li_null_cnt = 0
FOR i = 1 TO li_rc
	IF IsNull(tab_view.tabpage_detail_1.dw_comm_review.GetItemDateTime( i, "date_back_from_review" )) THEN
		li_null_cnt ++		
	END IF
END FOR

IF li_null_cnt = 0 THEN
	IF IsNull(tab_view.tabpage_detail_1.dw_apptmnt_status.GetItemDateTime( 1, "apptmnt_start_date" ) ) THEN
		MessageBox( "Missing Data", "Appointment Start Date field must be filled in.")
		tab_view.tabpage_detail_1.dw_apptmnt_status.SetColumn( "apptmnt_start_date" )
		tab_view.tabpage_detail_1.dw_apptmnt_status.SetFocus()
		Return -1
	END IF

	IF IsNull(tab_view.tabpage_detail_1.dw_apptmnt_status.GetItemDateTime( 1, "apptmnt_end_date" ) ) THEN
		MessageBox( "Missing Data", "Appointment End Date field must be filled in.")
		tab_view.tabpage_detail_1.dw_apptmnt_status.SetColumn( "apptmnt_end_date" )
		tab_view.tabpage_detail_1.dw_apptmnt_status.SetFocus()	
		Return -1
	END IF
END IF

Return 0
end function

public function integer of_set_parent_facility_id (integer ai_facility_id);
ii_parent_facility_id = ai_facility_id
ii_selected_facility_id = ai_facility_id


Return 0
end function

public function integer of_is_app_audit_complete ();//DateTime ldt_audit_complete
//
//
//SELECT pd_affil_stat.date_app_audit_completed  
//INTO :ldt_audit_complete  
//FROM pd_affil_stat  
//WHERE ( pd_affil_stat.prac_id = :il_prac_id ) AND  
//		( pd_affil_stat.parent_facility_id = :ii_parent_facility_id ) AND
//		( pd_affil_stat.active_status = 1 );
//
//IF IsNull( ldt_audit_complete ) THEN
//	m_pfe_cst_app_audit.m_file.m_applicationauditcomplete.toolbaritemname = "Custom027!"
//ELSE
//   m_pfe_cst_app_audit.m_file.m_applicationauditcomplete.toolbaritemname = "Custom026!"
//END IF
//
Return 1




end function

public function integer of_is_de_complete ();DateTime ldt_de_complete

IF IsValid( m_pfe_cst_data_entry) THEN
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-07
	//$<modify> 01.25.2006 By: Cao YongWang
	//$<reason> Performance tuning
	//$<modification> Write script to retrieve data from a cache instead of from the database.
	/*
	SELECT pd_affil_stat.date_data_entry_completed
	INTO :ldt_de_complete  
	FROM pd_affil_stat  
	WHERE ( pd_affil_stat.prac_id = :il_prac_id ) AND
			( pd_affil_stat.active_status in ( 1,4 ) ) and //maha  changed to include pending 072402
			(pd_affil_stat.parent_facility_id = :gi_parent_facility); //maha added 111300
	*/
	If isvalid(w_prac_data_1) Then
		ldt_de_complete = w_prac_data_1.idt_de_complete
	Else
		SELECT pd_affil_stat.date_data_entry_completed
		INTO :ldt_de_complete  
		FROM pd_affil_stat  
		WHERE ( pd_affil_stat.prac_id = :il_prac_id ) AND
				( pd_affil_stat.active_status in ( 1,4 ) ) and //maha  changed to include pending 072402
				(pd_affil_stat.parent_facility_id = :gi_parent_facility); //maha added 111300
	End If
	//---------------------------- APPEON END ----------------------------
	IF IsNull( ldt_DE_complete ) OR String(ldt_de_complete) = "1/1/00 00:00:00" THEN
		m_pfe_cst_data_entry.m_file.m_dataentrycomplete.toolbaritemname = "Custom027!"
		//m_pfe_cst_data_entry.m_file.m_dataentrycomplete.enabled = True
		Return 0 
	ELSE
		m_pfe_cst_data_entry.m_file.m_dataentrycomplete.toolbaritemname = "Custom026!"
		//m_pfe_cst_data_entry.m_file.m_dataentrycomplete.enabled = False
		Return 1
	END IF
ELSE
	Return -1
END IF






end function

public function integer of_refresh_detail ();dw_orgs_facilities.TriggerEvent(RowFocusChanged!)

Return 1
end function

public function integer of_retrieve_detail ();Integer li_row_cnt
Integer li_rc
DataWindowChild dwchild
// MSKINNER 17 DEC 2005 -- BEGIN
//IF tab_view.tabpage_detail_1.dw_apptmnt_status.ROWCOUNT() < 1 THEN RETURN 0
// MSKINNER 17 DEC 2005 -- END


ib_retrieved_allready = True

IF dw_orgs_facilities.RowCount() = 0 AND dw_orgs_facilities.Visible THEN
	Return -1
END IF
tab_view.tabpage_detail_1.dw_apptmnt_status.settransobject(sqlca) //maha 082201

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-08
//$<add> 01.24.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
//$<modification> Refer to PT-10 for more information.
tab_view.tabpage_detail_1.dw_comm_review.GetChild( "committee_id", dwchild )
dwchild.SetTransObject( SQLCA )
//Start queue label
gnv_appeondb.of_startqueue()
dwchild.Retrieve( ii_selected_facility_id )		
//---------------------------- APPEON END ----------------------------

li_row_cnt = tab_view.tabpage_detail_1.dw_apptmnt_status.Retrieve( il_prac_id, ii_selected_facility_id,gs_user_id )

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-09
//$<add> 01.24.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_commitqueue()
li_row_cnt = tab_view.tabpage_detail_1.dw_apptmnt_status.RowCount()
//---------------------------- APPEON END ----------------------------

//il_rec_id = tab_view.tabpage_detail_1.dw_apptmnt_status.GetItemNumber( 1, "rec_id" )	//Fixed a bug by jervis 07.06.2007 ,move to follow
//tab_view.tabpage_browse.dw_browse.SetTransObject( SQLCA )
tab_view.tabpage_detail_1.dw_apptmnt_status.ShareData( tab_view.tabpage_browse.dw_browse )
tab_view.tabpage_detail_1.dw_apptmnt_status.ShareData( tab_view.tabpage_detail_2.dw_cvo )

IF li_row_cnt > 0 THEN
	il_rec_id = tab_view.tabpage_detail_1.dw_apptmnt_status.GetItemNumber( 1, "rec_id" )	//Fixed a bug by jervis 07.06.2007
	of_retrieve_children()
	tab_view.tabpage_browse.dw_browse.SelectRow(1, True)
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-10
//$<comment> 01.24.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Move the following script to a front place. Together with other SQL statements, it can be integrated
//$<modification> into Appeon Queue labels to reduce client-server interactions. Refer to PT-08 for more information.

//tab_view.tabpage_detail_1.dw_comm_review.GetChild( "committee_id", dwchild )
//dwchild.SetTransObject( SQLCA )
//dwchild.Retrieve( ii_selected_facility_id )		
//---------------------------- APPEON END ----------------------------

//tab_view.tabpage_detail_1.dw_apptmnt_status.BringToTop = True
//tab_view.tabpage_detail_1.dw_comm_review.BringToTop = True
//tab_view.tabpage_detail_2.dw_departments.BringToTop = True
//tab_view.tabpage_detail_2.dw_staff_cat.BringToTop = True

//tab_view.tabpage_netdev.uo_net_dev.of_retrieve_detail( ii_selected_facility_id )

RETURN 0
end function

public function integer of_retrieve (long al_prac_id);DataWindowChild dwchild
Long ll_org_id

il_prac_id = al_prac_id

ib_first_retrieve = True
ib_retrieved_allready = True

dw_orgs_facilities.Reset()
dw_orgs_facilities.of_SetTransObject( SQLCA )

dw_orgs_facilities.Retrieve( al_prac_id,gs_user_id )

tab_view.tabpage_detail_1.dw_apptmnt_status.SetFocus()

of_setup_dw()//maha082201

////setup dw_orgs_facility dw
//dw_orgs_facilities.of_SetUpdateAble( False )
//dw_orgs_facilities.of_SetTransObject(SQLCA)
//
//
////setup appt status dw
//tab_view.tabpage_detail_1.dw_apptmnt_status.of_SetRowManager( TRUE )
//tab_view.tabpage_detail_1.dw_apptmnt_status.of_SetReqColumn(True)
//
//tab_view.tabpage_detail_1.dw_apptmnt_status.of_SetDropDownCalendar( TRUE )
//tab_view.tabpage_detail_1.dw_apptmnt_status.iuo_calendar.of_Register(tab_view.tabpage_detail_1.dw_apptmnt_status.iuo_calendar.DDLB)
//
//tab_view.tabpage_detail_1.dw_apptmnt_status.of_SetTransObject(SQLCA)
//
//
//tab_view.tabpage_detail_1.dw_apptmnt_status.GetChild( "cred_proccess_status", dwchild )
//dwchild.SetTransObject( SQLCA )
//dwchild.Retrieve("process status")
//dwchild.InsertRow( 1 )
//
//tab_view.tabpage_detail_1.dw_apptmnt_status.ShareData( tab_view.tabpage_detail_2.dw_cvo )
//
//tab_view.tabpage_detail_1.dw_apptmnt_status.GetChild( "affil_ended_reason", dwchild )
//dwchild.SetTransObject( SQLCA )
//dwchild.Retrieve("Affiliation Ended Reason")
//dwchild.InsertRow( 1 )
//
//String ls_version
//
////check to see if security is installed, if it is not then give access to new view
//ls_version = ProfileString("C:\intellicred\intellicred.ini", "setup", "version", "None")
//IF NOT FileExists( "C:\intellicred\intellicred.ini" ) THEN
//	MessageBox("ini File Error", "No intellicred.ini file found at: C:\intellicred\intellicred.ini" )
//	Return -1
//END IF
//
//IF ls_version = "None" THEN
//	MessageBox("Error", "Version number not setup.")
//	RETURN -1
//END IF
//
////is app audit turned off?
//IF w_mdi.of_security_access( 90 ) = 0 THEN	//changed from 460 maha081800
//	tab_view.tabpage_detail_1.dw_apptmnt_status.Modify("application_audit_facility.Visible = '0'")
//	tab_view.tabpage_detail_1.dw_apptmnt_status.Modify("application_audit_facility_t.Visible = '0'")
//	tab_view.tabpage_detail_1.dw_apptmnt_status.Modify("application_audit_facility.DDDW.Required = NO")
//elseIF w_mdi.of_security_access( 90 ) = 1 THEN	
//	tab_view.tabpage_detail_1.dw_apptmnt_status.Modify("application_audit_facility.enabled = '1'")
//END IF												
//
//
//
////setup committee dw
//
//tab_view.tabpage_detail_1.dw_comm_review.of_SetDropDownCalendar( TRUE )
//tab_view.tabpage_detail_1.dw_comm_review.iuo_calendar.of_Register( tab_view.tabpage_detail_1.dw_comm_review.iuo_calendar.DDLB)
//
//tab_view.tabpage_detail_1.dw_comm_review.of_SetTransObject(SQLCA)
//
//tab_view.tabpage_detail_1.dw_comm_review.GetChild( "review_results", dwchild )
//
//dwchild.SetTransObject( SQLCA )
//dwchild.Retrieve("approval code")
//
//
////setup staff cat dw
//Long nulllong
//
//SetNull( nulllong )
//tab_view.tabpage_detail_2.dw_staff_cat.of_SetRowManager( TRUE )
//tab_view.tabpage_detail_2.dw_staff_cat.of_SetReqColumn(TRUE)
//tab_view.tabpage_detail_2.dw_staff_cat.of_SetDropDownCalendar( TRUE )
//tab_view.tabpage_detail_2.dw_staff_cat.iuo_calendar.of_Register(tab_view.tabpage_detail_2.dw_staff_cat.iuo_calendar.DDLB)
//tab_view.tabpage_detail_2.dw_staff_cat.of_SetTransObject(SQLCA)
//
//tab_view.tabpage_detail_2.dw_staff_cat.GetChild( "staff_category", dwchild )
//dwchild.SetTransObject( SQLCA )
//dwchild.Retrieve("staff category")
//dwchild.InsertRow( 1 )
//dwchild.SetItem( 1, "lookup_code", nulllong )
//
//
//
////setup depart dw
//
//tab_view.tabpage_detail_2.dw_departments.of_SetRowManager( TRUE )
//tab_view.tabpage_detail_2.dw_departments.of_SetReqColumn(TRUE)
//tab_view.tabpage_detail_2.dw_departments.of_SetTransObject(SQLCA)
//
//tab_view.tabpage_detail_2.dw_departments.GetChild( "department", dwchild )
//dwchild.SetTransObject( SQLCA )
//dwchild.Retrieve("department")
//
//tab_view.tabpage_detail_2.dw_departments.GetChild( "section", dwchild )
//dwchild.SetTransObject( SQLCA )
//dwchild.Retrieve("section")
//
//
////setup leave_table
//
//tab_view.tabpage_detail_2.dw_leave.GetChild( "leave_of_absence_reason", dwchild )
//dwchild.SetTransObject( SQLCA )
//dwchild.Retrieve( "Reason for Leave of Absence" )
//
//tab_view.tabpage_detail_2.dw_leave.of_SetDropDownCalendar( TRUE )
//tab_view.tabpage_detail_2.dw_leave.iuo_calendar.of_Register(tab_view.tabpage_detail_2.dw_leave.iuo_calendar.DDLB)
//tab_view.tabpage_detail_2.dw_leave.of_SetTransObject(SQLCA)
//
//
////setup cvo data dw
//tab_view.tabpage_detail_2.dw_cvo.of_SetUpdateAble( False )
//
//tab_view.tabpage_detail_2.dw_cvo.of_SetDropDownCalendar( TRUE )
//tab_view.tabpage_detail_2.dw_cvo.iuo_calendar.of_Register( tab_view.tabpage_detail_2.dw_cvo.iuo_calendar.DDLB)
//
//tab_view.tabpage_detail_2.dw_cvo.of_SetTransObject(SQLCA)
//tab_view.tabpage_detail_2.dw_cvo.GetChild( "priority_user", dwchild )
//dwchild.SetTransObject( SQLCA )
//dwchild.Retrieve()

of_get_this_facility_data()

ib_first_retrieve = False
ib_retrieved_allready = False


RETURN 0
end function

public function integer of_add_address_link (integer ai_facility_id);
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-11
//$<modify> 03.22.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> 1) Copy the script from of_add_address_link of pfc_cst_nv_data_entry_functions.
//$<modification> 2) Modify the script to retrieve data from a cache instead of from the database
//$<modification> to reduce client server interactions.

/*
pfc_cst_nv_data_entry_functions lpfc_de

lpfc_de = CREATE pfc_cst_nv_data_entry_functions

lpfc_de.of_add_address_link( il_prac_id, ai_facility_id )

DESTROY lpfc_de

RETURN 1
*/
Integer li_address_cnt
Integer i
Integer li_nr
Long ll_address_id

long ll_addr_id //maha 02-26-01
integer cnt

li_address_cnt = ids_all_addresses.Rowcount()

//for each address put an entry in the address link table for the new facility being added
FOR i = 1 TO li_address_cnt
	//\/maha 02-26-01 check to see if link already exists 
	ll_addr_id = ids_all_addresses.GetItemNumber( i, "rec_id" )	
	cnt = ids_address_linked.find("address_id=" + string(ll_addr_id),1,ids_address_linked.Rowcount())
	if cnt > 0 then continue
	//\maha
	li_nr = ids_address_link.InsertRow( 0 )	
	ids_address_link.SetItem( li_nr, "prac_id", il_prac_id )
	ids_address_link.SetItem( li_nr, "address_id", ll_addr_id )
	ids_address_link.SetItem( li_nr, "facility_id", ai_facility_id )
	ids_address_link.SetItem( li_nr, "billing", 0 )//maha app100305
	ids_address_link.SetItem( li_nr, "mailing", 0 )//maha app100305
//Start Code Change ---- 01.25.2006 #221 maha
	ids_address_link.SetItem( li_nr, "home_address", 0 )
	ids_address_link.SetItem( li_nr, "primary_office", 0 )
	ids_address_link.SetItem( li_nr, "additional_office", 0 )
	ids_address_link.SetItem( li_nr, "include_in_directory", 0 )
	ids_address_link.SetItem( li_nr, "exp_letters", 0 )
//End Code Change---01.25.2006 			
			
	
END FOR

RETURN 1

//--------------------------- APPEON END ---------------------------



//Integer li_address_cnt
//Integer i
//Integer li_nr
//Long ll_address_id
//n_ds lds_address_link
//n_ds lds_all_addresses
//
//lds_address_link = CREATE n_ds
//lds_address_link.DataObject = "d_address_link"
//long ll_addr_id //maha 02-26-01
//integer cnt
//
//lds_address_link.of_SetTransObject( SQLCA )
//
//lds_all_addresses = CREATE n_ds
//lds_all_addresses.DataObject = "d_address_link_all_addresses"
//lds_all_addresses.of_SetTransObject( SQLCA )
//li_address_cnt = lds_all_addresses.Retrieve( il_prac_id )
//
////for each address put an entry in the address link table for the new facility being added
//FOR i = 1 TO li_address_cnt
//	//\/maha 02-26-01 check to see if link already exists 
//	ll_addr_id = lds_all_addresses.GetItemNumber( i, "rec_id" )	
//	select count(*)
//	into :cnt
//	from pd_address_link
//	where prac_id = :il_prac_id and facility_id = :ai_facility_id and address_id = :ll_addr_id;
//	if cnt > 0 then continue
//	//\maha
//	li_nr = lds_address_link.InsertRow( 0 )	
//	lds_address_link.SetItem( li_nr, "prac_id", il_prac_id )
//	lds_address_link.SetItem( li_nr, "address_id", ll_addr_id )
//	lds_address_link.SetItem( li_nr, "facility_id", ai_facility_id )
//END FOR
//
//IF lds_address_link.Update() <> 1 THEN
//	MessageBox( "Update Error", "Error updating address link table." )
//	DESTROY lds_address_link
//	DESTROY lds_all_addresses
//	RETURN -1
//END IF
//
//
//DESTROY lds_address_link
//DESTROY lds_all_addresses
//
//RETURN 1
//
//original code changed 02-27-01 maha
//Integer li_address_cnt
//Integer i
//Integer li_nr
//Long ll_address_id
//n_ds lds_address_link
//n_ds lds_all_addresses
//
//lds_address_link = CREATE n_ds
//lds_address_link.DataObject = "d_address_link"
//lds_address_link.of_SetTransObject( SQLCA )
//
//lds_all_addresses = CREATE n_ds
//lds_all_addresses.DataObject = "d_address_link_all_addresses"
//lds_all_addresses.of_SetTransObject( SQLCA )
//li_address_cnt = lds_all_addresses.Retrieve( il_prac_id )
//
////for each address put an entry in the address link table for the new facility being added
//FOR i = 1 TO li_address_cnt
//	li_nr = lds_address_link.InsertRow( 0 )	
//	lds_address_link.SetItem( li_nr, "prac_id", il_prac_id )
//	lds_address_link.SetItem( li_nr, "address_id", lds_all_addresses.GetItemNumber( i, "rec_id" ) )
//	lds_address_link.SetItem( li_nr, "facility_id", ai_facility_id )
//END FOR
//
//IF lds_address_link.Update() <> 1 THEN
//	MessageBox( "Update Error", "Error updating address link table." )
//	DESTROY lds_address_link
//	DESTROY lds_all_addresses
//	RETURN -1
//END IF
//
//
//DESTROY lds_address_link
//DESTROY lds_all_addresses
//
//RETURN 1
end function

public function integer of_filter_just_active (boolean ab_active);IF ab_active THEN
	tab_view.tabpage_detail_1.dw_apptmnt_status.SetFilter( "active_status in (1,4)" )
	tab_view.tabpage_detail_1.dw_apptmnt_status.Filter( )
ELSE
	tab_view.tabpage_detail_1.dw_apptmnt_status.SetFilter( "" )
	tab_view.tabpage_detail_1.dw_apptmnt_status.Filter( )
END IF

RETURN 0
end function

public function integer of_reset ();tab_view.tabpage_detail_1.dw_apptmnt_status.Reset()
tab_view.tabpage_browse.dw_browse.Reset()
tab_view.tabpage_detail_1.dw_comm_review.Reset()
tab_view.tabpage_detail_2.dw_cvo.Reset()
tab_view.tabpage_detail_2.dw_departments.Reset()
tab_view.tabpage_detail_2.dw_leave.Reset()
dw_orgs_facilities.Reset()
tab_view.tabpage_detail_2.dw_staff_cat.Reset()

Return 0
end function

public function boolean of_changed_app_audit ();Return ib_changed_app_audit
end function

public function boolean of_changed_parent_facility ();Return ib_changed_parent_facility
end function

public function integer of_add_hosp_links (readonly integer ai_facil_id);Integer li_hosp_cnt
Integer i
Integer li_nr
Integer li_found
long ll_rec //maha 121702
Long ll_hosp_id
//n_ds lds_hosp_link
//n_ds lds_all_hosp
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-12
//$<modify> 03.22.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Modify the script to retrieve data from a cache instead of from the database
//$<modification> to reduce client server interactions.
/*
lds_hosp_link = CREATE n_ds
lds_hosp_link.DataObject = "d_hf_link"
lds_hosp_link.of_SetTransObject( SQLCA )
lds_hosp_link.Retrieve( il_prac_id )

lds_all_hosp = CREATE n_ds
lds_all_hosp.DataObject = "d_hosp_affil_prac"
lds_all_hosp.of_SetTransObject( SQLCA )
li_hosp_cnt = lds_all_hosp.Retrieve( il_prac_id )

//for each hospital put an entry in the hospital link table for the new facility being added
FOR i = 1 TO li_hosp_cnt
	ll_rec = lds_all_hosp.GetItemNumber( i, "rec_id" )
	debugbreak()
	li_found = lds_hosp_link.Find( "facility_id = " + String( ai_facil_id ) + " and hosp_affil_id = " + string(ll_rec), 1, 1000 )
	IF li_found > 0 THEN
		CONTINUE
	END IF
	li_nr = lds_hosp_link.InsertRow( 0 )	
	lds_hosp_link.SetItem( li_nr, "prac_id", il_prac_id )
	lds_hosp_link.SetItem( li_nr, "hosp_affil_id", ll_rec )
	lds_hosp_link.SetItem( li_nr, "facility_id", ai_facil_id )
END FOR

IF lds_hosp_link.Update() <> 1 THEN
	MessageBox( "Update Error", "Error updating Hospital link table." )
	DESTROY lds_hosp_link
	DESTROY lds_all_hosp
	RETURN -1
END IF


DESTROY lds_hosp_link
DESTROY lds_all_hosp
*/

li_hosp_cnt = ids_all_hosp.RowCount()

//for each hospital put an entry in the hospital link table for the new facility being added
FOR i = 1 TO li_hosp_cnt
	ll_rec = ids_all_hosp.GetItemNumber( i, "rec_id" )

	li_found = ids_hosp_link.Find( "facility_id = " + String( ai_facil_id ) + " and hosp_affil_id = " + string(ll_rec), 1, 1000 )
	IF li_found > 0 THEN
		CONTINUE
	END IF
	li_nr = ids_hosp_link.InsertRow( 0 )	
	ids_hosp_link.SetItem( li_nr, "prac_id", il_prac_id )
	ids_hosp_link.SetItem( li_nr, "hosp_affil_id", ll_rec )
	ids_hosp_link.SetItem( li_nr, "facility_id", ai_facil_id )
END FOR

//---------------------------- APPEON END ----------------------------
RETURN 1


end function

public function integer of_multi_app ();//code modified maha 011003 to allow the net dev action items to be created for facilities that would be duplicated.
// net dev create function call moved to here from preupdate event
//Start Code Change ----12.10.2007 #V8 maha
// replaced with Performance Tuning code with code from version 5 because the PT code was FUBARed
n_ds lds_multi_app
Integer li_rc
Integer li_nr
Integer i
Integer li_prime
Integer li_multi_app_id
Integer li_parent_facility_id
Integer li_app_audit_facility_id
Integer li_verif_facility_id
integer li_active
String ls_apptmnt_type
gs_multi_app lstr_multi_app


Open( w_get_multi_app_template )
IF Message.StringParm = "Cancel" THEN
	Return -1
END IF

lstr_multi_app = Message.PowerObjectParm

li_multi_app_id = lstr_multi_app.i_multi_app_id

lds_multi_app = CREATE n_ds
lds_multi_app.DataObject = "d_multi_app_list"
lds_multi_app.of_SetTransObject( SQLCA )
li_rc = lds_multi_app.Retrieve( li_multi_app_id )

//Start Code Change ----12.12.2007 #V8 maha
if li_rc > 0 then //test if the record is blank and delete if so.
	if isnull(tab_view.tabpage_detail_1.dw_apptmnt_status.GetItemnumber(1,"parent_facility_id")) then
		tab_view.tabpage_detail_1.dw_apptmnt_status.deleterow(1)
	else
	end if
//messagebox("","")
else //return if no template records
	return 0
end if

ib_multiapp = true  
//End Code Change---12.12.2007

FOR i = 1 TO li_rc
	
	//get data from multi app template painter
	li_parent_facility_id = lds_multi_app.GetItemNumber( i, "parent_facility_id" )
	ls_apptmnt_type = lds_multi_app.GetItemString( i, "apptmnt_type" )
	ii_app_id = lds_multi_app.GetItemNumber( i, "app_id" )
	
	IF dw_orgs_facilities.Find( "parent_facility_id = " + String( li_parent_Facility_id ), 1, 1000 ) > 0 THEN
		//don't make appt record if facility record exists
	else
		li_app_audit_facility_id = lds_multi_app.GetItemNumber( i, "application_audit_facility" )
		li_verif_facility_id = lds_multi_app.GetItemNumber( i, "verifying_facility" )
		 	
		
		
		//add appointment status record
		of_new_record( il_prac_id )
		li_nr = tab_view.tabpage_detail_1.dw_apptmnt_status.GetRow( )
		//tab_view.tabpage_detail_1.dw_apptmnt_status.SetItem( li_nr, "parent_facility_id", li_parent_facility_id  )	
		tab_view.tabpage_detail_1.dw_apptmnt_status.SetColumn( "parent_facility_id" )
		tab_view.tabpage_detail_1.dw_apptmnt_status.SetText( String(li_parent_facility_id)  )
		tab_view.tabpage_detail_1.dw_apptmnt_status.SetColumn( "application_audit_facility" )
		//tab_view.tabpage_detail_1.dw_apptmnt_status.TriggerEvent( ItemChanged! )
		tab_view.tabpage_detail_1.dw_apptmnt_status.SetItem( li_nr, "application_audit_facility", li_app_audit_facility_id )
		tab_view.tabpage_detail_1.dw_apptmnt_status.SetItem( li_nr, "verifying_facility", li_verif_facility_id )
		tab_view.tabpage_detail_1.dw_apptmnt_status.SetItem( li_nr, "apptmnt_type", ls_apptmnt_type)	
		if ii_app_id < 1 or isnull(ii_app_id) then //maha 101901
			tab_view.tabpage_detail_1.dw_apptmnt_status.SetItem( li_nr, "affiliation_status", "M")
		else
			tab_view.tabpage_detail_1.dw_apptmnt_status.SetItem( li_nr, "affiliation_status", "I")
		end if
		
		//Start Code Change ----12.12.2007 #V8 maha
		if ls_apptmnt_type = "I" then
			li_active = 4
		else
			li_active = 1
		end if
		tab_view.tabpage_detail_1.dw_apptmnt_status.SetItem( li_nr, "active_status", li_active )
	
			
		tab_view.tabpage_detail_1.dw_apptmnt_status.SetItem( li_nr, "priority_user", "Public" )	
		
		IF Not IsNull(  lstr_multi_app.l_department )  and lstr_multi_app.l_department  > 0 THEN //add trap 12.12.07 maha
			tab_view.tabpage_detail_2.dw_departments.SetItem( 1, "department", lstr_multi_app.l_department )
			tab_view.tabpage_detail_2.dw_departments.SetItem( 1, "section", lstr_multi_app.l_section )
			li_prime = lstr_multi_app.i_primary//maha 182802
			if isnull(li_prime) then li_prime = 0//maha 182802
			tab_view.tabpage_detail_2.dw_departments.SetItem( 1, "primary_dept", li_prime )// maha 182802
			tab_view.tabpage_detail_2.dw_departments.SetItem( 1, "active_status", li_active )  //Start Code Change ----12.12.2007 #V8 maha
		END IF
	
		IF Not IsNull(  lstr_multi_app.l_staff_category )  and lstr_multi_app.l_staff_category > 0 THEN //addtrap 12.12.07 maha
				tab_view.tabpage_detail_2.dw_staff_cat.SetItem( 1, "staff_category", lstr_multi_app.l_staff_category )
				if string( lstr_multi_app.dt_from_date) <> "1/1/1900 00:00:00" then //addtrap 12.12.07 maha
					tab_view.tabpage_detail_2.dw_staff_cat.SetItem( 1, "from_date", lstr_multi_app.dt_from_date )
				end if
				if string( lstr_multi_app.dt_to_date) <> "1/1/1900 00:00:00" then //addtrap 12.12.07 maha
					tab_view.tabpage_detail_2.dw_staff_cat.SetItem( 1, "to_date", lstr_multi_app.dt_to_date )	
				end if
				tab_view.tabpage_detail_2.dw_staff_cat.SetItem( 1, "active_status", li_active )  //Start Code Change ----12.12.2007 #V8 maha
		END IF
			//End Code Change---12.12.2007
		iw_win.Event pfc_Save()
	end if
	//creation of network dev items moved here from preupdate of the appoint stat dw  //maha 011003
	of_add_net_dev_ai(ls_apptmnt_type,ii_app_id, li_parent_facility_id) //Start Code Change ----12.10.2007 #V8 maha added facility argument
END FOR

ib_multiapp = false  //Start Code Change ----12.12.2007 #V8 maha

Return 0


////code modified maha 011003 to allow the net dev action items to be created for facilities that would be duplicated.
//// net dev create function call moved to here from preupdate event
//
//n_ds lds_multi_app
//Integer li_rc
//Integer li_nr
//Integer i
//Integer li_prime
//Integer li_multi_app_id
//Integer li_parent_facility_id
//Integer li_app_audit_facility_id
//Integer li_verif_facility_id
//integer res
//String ls_apptmnt_type
//gs_multi_app lstr_multi_app
//
//
//Open( w_get_multi_app_template )
//IF Message.StringParm = "Cancel" THEN
//	Return -1
//END IF
//
//lstr_multi_app = Message.PowerObjectParm
//
//li_multi_app_id = lstr_multi_app.i_multi_app_id
//
//lds_multi_app = CREATE n_ds
//lds_multi_app.DataObject = "d_multi_app_list"
//lds_multi_app.of_SetTransObject( SQLCA )
//li_rc = lds_multi_app.Retrieve( li_multi_app_id )
//
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-13
////$<add> 04.12.2006 By: LeiWei
////$<reason> Performance tuning
////$<modification> Define a variable to 1)get the first ID; 2)Update the final ID
////$<modification> value into database.
//
//boolean lb_save
//il_rec_id_multi_app = gnv_app.of_Get_Id("RECORD_ID", li_rc*2) - 1
////---------------------------- APPEON END ----------------------------
//
//FOR i = 1 TO li_rc
//	
//	//get data from multi app template painter
//	li_parent_facility_id = lds_multi_app.GetItemNumber( i, "parent_facility_id" )
//	ls_apptmnt_type = lds_multi_app.GetItemString( i, "apptmnt_type" )
//	ii_app_id = lds_multi_app.GetItemNumber( i, "app_id" )
//	
//	IF dw_orgs_facilities.Find( "parent_facility_id = " + String( li_parent_Facility_id ), 1, 1000 ) > 0 THEN
//		//don't make appt record if facility record exists
//	else
//		li_app_audit_facility_id = lds_multi_app.GetItemNumber( i, "application_audit_facility" )
//		li_verif_facility_id = lds_multi_app.GetItemNumber( i, "verifying_facility" )
//		 	
//		
//		
//		//add appointment status record
//		of_new_record( il_prac_id )
//		li_nr = tab_view.tabpage_detail_1.dw_apptmnt_status.GetRow( )
//		//tab_view.tabpage_detail_1.dw_apptmnt_status.SetItem( li_nr, "parent_facility_id", li_parent_facility_id  )	
//		tab_view.tabpage_detail_1.dw_apptmnt_status.SetColumn( "parent_facility_id" )
//		tab_view.tabpage_detail_1.dw_apptmnt_status.SetText( String(li_parent_facility_id)  )
//		tab_view.tabpage_detail_1.dw_apptmnt_status.SetColumn( "application_audit_facility" )
//		//tab_view.tabpage_detail_1.dw_apptmnt_status.TriggerEvent( ItemChanged! )
//		tab_view.tabpage_detail_1.dw_apptmnt_status.SetItem( li_nr, "application_audit_facility", li_app_audit_facility_id )
//		tab_view.tabpage_detail_1.dw_apptmnt_status.SetItem( li_nr, "verifying_facility", li_verif_facility_id )
//		tab_view.tabpage_detail_1.dw_apptmnt_status.SetItem( li_nr, "apptmnt_type", ls_apptmnt_type)	
//		if ii_app_id < 1 or isnull(ii_app_id) then //maha 101901
//			tab_view.tabpage_detail_1.dw_apptmnt_status.SetItem( li_nr, "affiliation_status", "M")
//		else
//			tab_view.tabpage_detail_1.dw_apptmnt_status.SetItem( li_nr, "affiliation_status", "I")
//		end if
//		tab_view.tabpage_detail_1.dw_apptmnt_status.SetItem( li_nr, "active_status", 1 )	
//		tab_view.tabpage_detail_1.dw_apptmnt_status.SetItem( li_nr, "priority_user", "Public" )	
//		
//		//--------------------------- APPEON BEGIN ---------------------------
//		//$<add> 04.12.2006 By: Liang QingShi
//		//$<reason> Fix a defect in the original unmodified PowerBuilder application.
//		//$<modification> Complete the condition to make sure IntelliCred works correctly.
//		/*
//		IF Not IsNull(  lstr_multi_app.l_department ) THEN
//		*/
//		IF Not IsNull(  lstr_multi_app.l_department ) and lstr_multi_app.l_department <> 0 THEN		
//		//---------------------------- APPEON END ----------------------------
//			tab_view.tabpage_detail_2.dw_departments.SetItem( 1, "department", lstr_multi_app.l_department )
//			tab_view.tabpage_detail_2.dw_departments.SetItem( 1, "section", lstr_multi_app.l_section )
//			li_prime = lstr_multi_app.i_primary//maha 182802
//			if isnull(li_prime) then li_prime = 0//maha 182802
//			tab_view.tabpage_detail_2.dw_departments.SetItem( 1, "primary_dept", li_prime )// maha 182802
//		END IF
//	
//		IF Not IsNull(  lstr_multi_app.l_staff_category ) THEN
//			tab_view.tabpage_detail_2.dw_staff_cat.SetItem( 1, "staff_category", lstr_multi_app.l_staff_category )
//			tab_view.tabpage_detail_2.dw_staff_cat.SetItem( 1, "from_date", lstr_multi_app.dt_from_date )
//			tab_view.tabpage_detail_2.dw_staff_cat.SetItem( 1, "to_date", lstr_multi_app.dt_to_date )	
//		END IF
//		
//		//--------------------------- APPEON BEGIN ---------------------------
//		//$<ID> PT-14
//		//$<modify> 04.12.2006 By: LeiWei
//		//$<reason> Performance tuning
//		//$<modification> Move iw_win.Event pfc_Save() out of the loop to reduce client-server interactions.
//		//iw_win.Event pfc_Save()
//		lb_save = true
//		//---------------------------- APPEON END ----------------------------
//	end if
//
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<ID> PT-15
//	//$<comment> 04.12.2006 By: LeiWei
//	//$<reason> Performance tuning
//	//$<modification> Move the following script to the following SQL statements and integrate them into Appeon
//	//$<modification> Queue labels to reduce client-server interactions. Refer to PT-16 for more information.
//
//	/*
//	//creation of network dev items moved here from preupdate of the appoint stat dw  //maha 011003
//	of_add_net_dev_ai(ls_apptmnt_type,ii_app_id)
//	*/
//	//---------------------------- APPEON END ----------------------------
//END FOR
//
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-16
////$<comment> 04.12.2006 By: LeiWei
////$<reason> Performance tuning
////$<modification> 1) Add Appeon Queue labels to reduce client server interactions.
////$<modification> 2) Add the script from PT-15 into Appeon Queue labels.
//
////Start Code Change ----12.10.2007 #V8 maha
////If lb_save then iw_win.Event pfc_Save()
//If lb_save then 
//	res = iw_win.Event pfc_Save()
//	if res = -1 then
//		return -1
//	end if
//else
//	return -1
//end if
////End Code Change---12.10.2007	
//
//gnv_appeondb.of_startqueue( )
//
//FOR i = 1 TO li_rc
//	ls_apptmnt_type = lds_multi_app.GetItemString( i, "apptmnt_type" )
//	ii_app_id = lds_multi_app.GetItemNumber( i, "app_id" )
//	of_add_net_dev_ai(ls_apptmnt_type,ii_app_id)
//END FOR
//
//gnv_appeondb.of_commitqueue( )
//
//il_rec_id_multi_app = 0
////---------------------------- APPEON END ----------------------------
//
//Return 0
end function

public function integer of_set_parent_window (w_prac_data_1 aw_win);iw_win = aw_win

Return 0
end function

public function integer of_add_spec_links (integer ai_facil_id);Integer li_spec_cnt
Integer i
Integer li_nr
Integer li_found
Long ll_spec_id
long ll_rec
//n_ds lds_spec_link
//n_ds lds_all_spec
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-17
//$<add> 03.22.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Modify the script to retrieve data from a cache instead of from the database
//$<modification> to reduce client server interactions.
/*
lds_spec_link = CREATE n_ds
lds_spec_link.DataObject = "d_sf_link"
lds_spec_link.of_SetTransObject( SQLCA )
lds_spec_link.Retrieve( il_prac_id )

lds_all_spec = CREATE n_ds
lds_all_spec.DataObject = "d_spec_of_prac"
lds_all_spec.of_SetTransObject( SQLCA )
li_spec_cnt = lds_all_spec.Retrieve( il_prac_id )

//for each specialty put an entry in the specialty link table for the new facility being added
FOR i = 1 TO li_spec_cnt
	ll_rec = lds_all_spec.GetItemNumber( i, "rec_id" ) //maha 121702
	li_found = lds_spec_link.Find( "facility_id = " + String( ai_facil_id ) + " and specialty_id = " + string(ll_rec), 1, 1000 )
	IF li_found > 0 THEN
		CONTINUE
	END IF	
	li_nr = lds_spec_link.InsertRow( 0 )	
	lds_spec_link.SetItem( li_nr, "prac_id", il_prac_id )
	lds_spec_link.SetItem( li_nr, "specialty_id", ll_rec )
	lds_spec_link.SetItem( li_nr, "facility_id", ai_facil_id )
	lds_spec_link.SetItem( li_nr, "practicing", 582 )
next

IF lds_spec_link.Update() <> 1 THEN
	MessageBox( "Update Error", "Error updating specialty link table." )
	DESTROY lds_spec_link
	DESTROY lds_all_spec
	RETURN -1
END IF


DESTROY lds_spec_link
DESTROY lds_all_spec
*/

li_spec_cnt = ids_all_spec.RowCount()

//for each specialty put an entry in the specialty link table for the new facility being added
FOR i = 1 TO li_spec_cnt
	ll_rec = ids_all_spec.GetItemNumber( i, "rec_id" ) //maha 121702
	li_found = ids_spec_link.Find( "facility_id = " + String( ai_facil_id ) + " and specialty_id = " + string(ll_rec), 1, 1000 )
	IF li_found > 0 THEN
		CONTINUE
	END IF	
	li_nr = ids_spec_link.InsertRow( 0 )	
	ids_spec_link.SetItem( li_nr, "prac_id", il_prac_id )
	ids_spec_link.SetItem( li_nr, "specialty_id", ll_rec )
	ids_spec_link.SetItem( li_nr, "facility_id", ai_facil_id )
	ids_spec_link.SetItem( li_nr, "practicing", 582 )
next

//---------------------------- APPEON END ----------------------------
RETURN 1


end function

public function integer of_setup_dw ();datawindowchild dwchild
Long nulllong
//setup dw_orgs_facility dw
dw_orgs_facilities.of_SetUpdateAble( False )
//dw_orgs_facilities.of_SetTransObject(SQLCA)


//setup appt status dw
tab_view.tabpage_detail_1.dw_apptmnt_status.of_SetRowManager( TRUE )
tab_view.tabpage_detail_1.dw_apptmnt_status.of_SetReqColumn(True)

tab_view.tabpage_detail_1.dw_apptmnt_status.of_SetDropDownCalendar( TRUE )
//tab_view.tabpage_detail_1.dw_apptmnt_status.iuo_calendar.of_Register(tab_view.tabpage_detail_1.dw_apptmnt_status.iuo_calendar.DDLB)

//tab_view.tabpage_detail_1.dw_apptmnt_status.of_SetTransObject(SQLCA)

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-18
//$<modify> 01.24.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Comment out the following scripts. After analysis, cred_proccess_status column does not exist
//$<modification> in dw_apptmnt_status.
/*
tab_view.tabpage_detail_1.dw_apptmnt_status.GetChild( "cred_proccess_status", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("process status")
dwchild.InsertRow( 1 )
*/
//---------------------------- APPEON END ----------------------------

tab_view.tabpage_detail_1.dw_apptmnt_status.ShareData( tab_view.tabpage_detail_2.dw_cvo )

tab_view.tabpage_detail_1.dw_apptmnt_status.GetChild( "affil_ended_reason", dwchild )
dwchild.SetTransObject( SQLCA )
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-19
//$<modify> 01.24.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Write script to retrieve data from a cache instead of from the database.

//dwchild.Retrieve("Affiliation Ended Reason")
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper(lookup_name) = '" + upper('Affiliation Ended Reason') + "'", dwchild)
//---------------------------- APPEON END ----------------------------

dwchild.InsertRow( 1 )
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.13.2006 By: Jack (Inova)
//$<reason> Add functionality to not have to select an Audit Facility from Appointment Status Screen
long ll_find
tab_view.tabpage_detail_1.dw_apptmnt_status.GetChild( "application_audit_facility", dwchild )//maha 062303 for inova
ll_find = dwchild.find('facility_id = -1',1,dwchild.rowcount())
if ll_find < 1 then
	dwchild.InsertRow( 1 )
	dwchild.setitem(1,"facility_id", -1)
	dwchild.setitem(1,"facility_facility_name", 'N/A')
end if
//---------------------------- APPEON END ----------------------------

tab_view.tabpage_detail_1.dw_apptmnt_status.GetChild( "priority_user", dwchild )//maha 062303 for inova
dwchild.SetTransObject( SQLCA )
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-20
//$<modify> 01.24.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> 1) Move the following script to the Constructor event of pfc_cst_u_apptmnt_status.
//$<modification> 2) Integrate it with other SQL statements into Appeon Queue labels to reduce client-server interactions.

//dwchild.retrieve()
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 10.19.2006 By: Jack (Inova)
//$<reason> Fix a defect.
/*
dwchild.InsertRow( 1 )
dwchild.setitem(1,"user_id", 'PUBLIC')
*/
ll_find = dwchild.find("user_id = 'PUBLIC'",1,dwchild.rowcount())
if ll_find < 1 then
	dwchild.InsertRow( 1 )
	dwchild.setitem(1,"user_id", 'PUBLIC')
end if
//---------------------------- APPEON END ----------------------------

String ls_version

//check to see if security is installed, if it is not then give access to new view
ls_version = ProfileString(gs_IniFilePathName, "setup", "version", "None")
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-21
//$<modify> 01.17.2006 By: Cao YongWang
//$<reason> The Web application does not need to check whether there is an INI file on local machine.
//$<modification> Make an condition that when the application runs on the Web, the application does not check
//$<modification> the local INI file.

//IF NOT FileExists( gs_dir_path + "intellicred\intellicred.ini" ) THEN
//	MessageBox("ini File Error", "No intellicred.ini file found at: " + gs_dir_path + "intellicred\intellicred.ini" )
//	Return -1
//END IF
If appeongetclienttype() = 'PB' Then
	IF NOT FileExists(gs_IniFilePathName) THEN
		//MessageBox("ini File Error", "No intellicred.ini file found at: " + gs_IniFilePathName )
		MessageBox("INI File Error", "No intellicred.ini file was found at: " + gs_IniFilePathName )
		Return -1
	END IF
End If
//---------------------------- APPEON END ----------------------------

IF ls_version = "None" THEN
	MessageBox("Error", "Version number not setup.")
	RETURN -1
END IF

//is app audit turned off?
IF w_mdi.of_security_access( 90 ) = 0 THEN	//changed from 460 maha081800
	tab_view.tabpage_detail_1.dw_apptmnt_status.Modify("application_audit_facility.Visible = '0'")
	tab_view.tabpage_detail_1.dw_apptmnt_status.Modify("application_audit_facility_t.Visible = '0'")
	tab_view.tabpage_detail_1.dw_apptmnt_status.Modify("application_audit_facility.DDDW.Required = NO")
elseIF w_mdi.of_security_access( 90 ) = 1 THEN	
	tab_view.tabpage_detail_1.dw_apptmnt_status.Modify("application_audit_facility.enabled = '1'")
END IF												

IF w_mdi.of_security_access( 120 ) = 0 THEN	//changed from 460 maha081800
	tab_view.tabpage_detail_1.dw_comm_review.enabled = false
//	tab_view.tabpage_detail_1.dw_apptmnt_status.Modify("application_audit_facility_t.Visible = '0'")
//	tab_view.tabpage_detail_1.dw_apptmnt_status.Modify("application_audit_facility.DDDW.Required = NO")
//elseIF w_mdi.of_security_access( 90 ) = 1 THEN	
//	tab_view.tabpage_detail_1.dw_apptmnt_status.Modify("application_audit_facility.enabled = '1'")
END IF

//setup committee dw

tab_view.tabpage_detail_1.dw_comm_review.of_SetDropDownCalendar( TRUE )
//tab_view.tabpage_detail_1.dw_comm_review.iuo_calendar.of_Register( tab_view.tabpage_detail_1.dw_comm_review.iuo_calendar.DDLB)

//tab_view.tabpage_detail_1.dw_comm_review.of_SetTransObject(SQLCA)

tab_view.tabpage_detail_1.dw_comm_review.GetChild( "review_results", dwchild )

dwchild.SetTransObject( SQLCA )
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-22
//$<modify> 01.24.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Write script to retrieve data from a cache instead of from the database.

//dwchild.Retrieve("approval code")
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper(lookup_name) = '" + upper('approval code') + "'", dwchild)
//---------------------------- APPEON END ----------------------------

dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "lookup_code", nulllong )

//setup staff cat dw

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-23
//$<comment> 02.22.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Move the following script that retrieves data for tabpage_detail_2 to the of_setup_dw2 funtion.
//$<modification> Refer to PT-24 for more information.

//$<reason> The following script moved to of_setup_dw function.
/*
SetNull( nulllong )
tab_view.tabpage_detail_2.dw_staff_cat.of_SetRowManager( TRUE )
tab_view.tabpage_detail_2.dw_staff_cat.of_SetReqColumn(TRUE)
tab_view.tabpage_detail_2.dw_staff_cat.of_SetDropDownCalendar( TRUE )
tab_view.tabpage_detail_2.dw_staff_cat.iuo_calendar.of_Register(tab_view.tabpage_detail_2.dw_staff_cat.iuo_calendar.DDLB)
tab_view.tabpage_detail_2.dw_staff_cat.of_SetTransObject(SQLCA)

tab_view.tabpage_detail_2.dw_staff_cat.GetChild( "staff_category", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("staff category")

dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "lookup_code", nulllong )



//setup depart dw

tab_view.tabpage_detail_2.dw_departments.of_SetRowManager( TRUE )
tab_view.tabpage_detail_2.dw_departments.of_SetReqColumn(TRUE)
tab_view.tabpage_detail_2.dw_departments.of_SetTransObject(SQLCA)

tab_view.tabpage_detail_2.dw_departments.of_SetDropDownCalendar( TRUE )
tab_view.tabpage_detail_2.dw_departments.iuo_calendar.of_Register(tab_view.tabpage_detail_2.dw_departments.iuo_calendar.DDLB)
tab_view.tabpage_detail_2.dw_departments.of_SetTransObject(SQLCA)

tab_view.tabpage_detail_2.dw_departments.GetChild( "department", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("department")

dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "lookup_code", nulllong )

tab_view.tabpage_detail_2.dw_departments.GetChild( "section", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("section")

dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "lookup_code", nulllong )

tab_view.tabpage_detail_2.dw_departments.GetChild( "rank", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("division")

dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "lookup_code", nulllong )

//setup leave_table

tab_view.tabpage_detail_2.dw_leave.GetChild( "leave_of_absence_reason", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve( "Reason for Leave of Absence" )

tab_view.tabpage_detail_2.dw_leave.of_SetDropDownCalendar( TRUE )
tab_view.tabpage_detail_2.dw_leave.iuo_calendar.of_Register(tab_view.tabpage_detail_2.dw_leave.iuo_calendar.DDLB)
tab_view.tabpage_detail_2.dw_leave.of_SetTransObject(SQLCA)


//setup cvo data dw
tab_view.tabpage_detail_2.dw_cvo.of_SetUpdateAble( False )

tab_view.tabpage_detail_2.dw_cvo.of_SetDropDownCalendar( TRUE )
tab_view.tabpage_detail_2.dw_cvo.iuo_calendar.of_Register( tab_view.tabpage_detail_2.dw_cvo.iuo_calendar.DDLB)

tab_view.tabpage_detail_2.dw_cvo.of_SetTransObject(SQLCA)

tab_view.tabpage_detail_2.dw_cvo.GetChild( "priority_user", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve()

//setup questions tab
tab_view.tabpage_quest.dw_quest.of_SetTransObject(SQLCA)
tab_view.tabpage_quest.dw_quest.GetChild( "answer_code", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("question answers")
dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "lookup_code", nulllong )
*/
tab_view.tabpage_detail_2.dw_cvo.of_SetUpdateAble( False )
//---------------------------- APPEON END ----------------------------
return 1
end function

public function integer of_null_dates ();//maha 02-07-02

long prac
long rec
integer facil
Long ll_seq_no
string daparm
integer ret

rec = il_rec_id
prac = gl_prac_id
facil = ii_parent_facility_id


daparm = string(rec) + "," + string(prac) + "," + string(facil)


openwithparm(w_null_affil_dates,daparm)

ret = message.doubleparm

if ret = 1 then
	w_prac_data_1.tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_detail_1.dw_apptmnt_status.retrieve(prac,facil,gs_user_id)
end if

return 1
end function

public function integer of_appoint_note ();//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 01.09.2008 By: Evan
//$<reason> Throw exception if row number is zero.
/*
long ll_rec

ll_rec = tab_view.tabpage_detail_1.dw_apptmnt_status.getitemnumber(tab_view.tabpage_detail_1.dw_apptmnt_status.getrow(),"rec_id")

openwithparm(w_appointment_note,ll_rec)

return 1
*/
long ll_rec
long ll_Row

ll_Row = tab_view.tabpage_detail_1.dw_apptmnt_status.getrow()
if ll_Row > 0 then
	ll_rec = tab_view.tabpage_detail_1.dw_apptmnt_status.getitemnumber(ll_Row, "rec_id")
	OpenWithParm(w_appointment_note,ll_rec)
end if

Return 1
//---------------------------- APPEON END ----------------------------
end function

public function integer of_set_active (integer ai_status);Integer li_row_cnt
Integer i
integer li_central
string ls_stat
//Added for Work flow. 2/11/2006 Henry
//boolean lb_workflow
//End added for work flow.
li_row_cnt = tab_view.tabpage_detail_1.dw_comm_review.RowCount()

FOR i = 1 TO li_row_cnt
	IF tab_view.tabpage_detail_1.dw_comm_review.GetItemStatus( i, 0, Primary! ) <> New! THEN
		tab_view.tabpage_detail_1.dw_comm_review.SetItem( i, "active_status", ai_status )	
	END IF
END FOR


li_row_cnt = tab_view.tabpage_detail_2.dw_departments.RowCount()

FOR i = 1 TO li_row_cnt
	IF tab_view.tabpage_detail_2.dw_departments.GetItemStatus( i, 0, Primary! ) <> New! THEN
		tab_view.tabpage_detail_2.dw_departments.SetItem( i, "active_status", ai_status )	
	END IF
END FOR


li_row_cnt = tab_view.tabpage_detail_2.dw_staff_cat.RowCount()

FOR i = 1 TO li_row_cnt
	IF tab_view.tabpage_detail_2.dw_staff_cat.GetItemStatus( i, 0, Primary! ) <> New! THEN
		tab_view.tabpage_detail_2.dw_staff_cat.SetItem( i, "active_status", ai_status )	
	END IF
END FOR


//li_row_cnt = tab_view.tabpage_detail_2.dw_leave.RowCount() //removed 031504 maha
//
//FOR i = 1 TO li_row_cnt
//	IF tab_view.tabpage_detail_2.dw_leave.GetItemStatus( i, 0, Primary! ) <> New! THEN
//		tab_view.tabpage_detail_2.dw_leave.SetItem( i, "active_status", ai_status )	
//	END IF
//END FOR

//\/maha 051502 if facility is central set all facilities to inactive //removed 081502 //readded and modified 010903
//messagebox("facility",ii_parent_facility_id)
select central_cred into :li_central from facility where facility_id = :ii_selected_facility_id;
if li_central = 1 then
	choose case ai_status
		case 0
			ls_stat = "History"
		case 1
			ls_stat = "Active"
		case 2
			ls_stat = "Purge"
		case 3
			ls_stat = "Inactive"
		case 4
			ls_stat = "Pending"
	end choose
	i = messagebox("Status Update","You are changing the Active Status of your Central Facility to " + ls_stat + ".~r Do you wish to change all other active facilities for this practitioner to " + ls_stat ,question!,yesno!,2)
	if i = 1 then
		if ai_status = 3 then //inactive
			//--------------------------- APPEON BEGIN ---------------------------
			//$<ID> PT-26
			//$<add> 02.22.2006 By: Cao YongWang
			//$<reason> Performance tuning.
			//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

			gnv_appeondb.of_startqueue()			
			//---------------------------- APPEON END ----------------------------
			update pd_affil_stat set active_status = 3 where active_status in (1,4) and prac_id = :il_prac_id and parent_facility_id <> :ii_selected_facility_id;
			update pd_comm_review set active_status = 3 where active_status in (1,4) and prac_id = :il_prac_id and parent_facility_id <> :ii_selected_facility_id;
			update pd_affil_dept set active_status = 3 where active_status in (1,4) and prac_id = :il_prac_id and parent_facility_id <> :ii_selected_facility_id;
			update pd_affil_staff_cat set active_status = 3 where active_status in (1,4) and prac_id = :il_prac_id and parent_facility_id <> :ii_selected_facility_id;
			commit using sqlca;
			//--------------------------- APPEON BEGIN ---------------------------
			//$<ID> PT-27
			//$<add> 02.22.2006 By: Cao YongWang
			//$<reason> Performance tuning.
			//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

			gnv_appeondb.of_commitqueue()			
			//---------------------------- APPEON END ----------------------------
			//Added for Work flow. 2/11/2006 Henry
			//lb_workflow = true
			ib_workflow = true	//Modify By Jervis 12.19.2006
		elseif ai_status = 1 then //active
			//--------------------------- APPEON BEGIN ---------------------------
			//$<ID> PT-28
			//$<add> 02.22.2006 By: Cao YongWang
			//$<reason> Performance tuning.
			//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

			gnv_appeondb.of_startqueue()			
			//---------------------------- APPEON END ----------------------------
			update pd_affil_stat set active_status = 1 where active_status in (3,4) and prac_id = :il_prac_id and parent_facility_id <> :ii_selected_facility_id;
			update pd_comm_review set active_status = 1 where active_status in (3,4) and prac_id = :il_prac_id and parent_facility_id <> :ii_selected_facility_id;
			update pd_affil_dept set active_status = 1 where active_status in (3,4) and prac_id = :il_prac_id  and parent_facility_id <> :ii_selected_facility_id;
			update pd_affil_staff_cat set active_status = 1 where active_status in (3,4) and prac_id = :il_prac_id and parent_facility_id <> :ii_selected_facility_id;
			commit using sqlca;
			//--------------------------- APPEON BEGIN ---------------------------
			//$<ID> PT-29
			//$<add> 02.22.2006 By: Cao YongWang
			//$<reason> Performance tuning.
			//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

			gnv_appeondb.of_commitqueue()			
			//---------------------------- APPEON END ----------------------------
			//Added for Work flow. 2/11/2006 Henry
			//lb_workflow = true
			ib_workflow = true	//Modify By Jervis 12.19.2006
		elseif ai_status = 4 then //pending
			//--------------------------- APPEON BEGIN ---------------------------
			//$<ID> PT-30
			//$<add> 02.22.2006 By: Cao YongWang
			//$<reason> Performance tuning.
			//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

			gnv_appeondb.of_startqueue()			
			//---------------------------- APPEON END ----------------------------
		 	update pd_affil_stat set active_status = 4 where active_status in (3,1) and prac_id = :il_prac_id and parent_facility_id <> :ii_selected_facility_id;
			update pd_comm_review set active_status = 4 where active_status in (3,1) and prac_id = :il_prac_id and parent_facility_id <> :ii_selected_facility_id;
			update pd_affil_dept set active_status = 4 where active_status in (3,1) and prac_id = :il_prac_id and parent_facility_id <> :ii_selected_facility_id;
			update pd_affil_staff_cat set active_status = 4 where active_status in (3,1) and prac_id = :il_prac_id and parent_facility_id <> :ii_selected_facility_id;
			commit using sqlca;
			//--------------------------- APPEON BEGIN ---------------------------
			//$<ID> PT-31
			//$<add> 02.22.2006 By: Cao YongWang
			//$<reason> Performance tuning.
			//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

			gnv_appeondb.of_commitqueue()			
			//---------------------------- APPEON END ----------------------------
			//Added for Work flow. 2/11/2006 Henry
			//lb_workflow = true
			ib_workflow = true	//Modify By Jervis 12.19.2006
		else
			messagebox("Status Update","You cannot change facilities to " + ls_stat + " in a batch." ,question!,yesno!,2)
		 end if		
	end if
	
end if
	//\maha	

//Added for Work flow. Trigger off the related work flow for Practitioner Status changed. 2/11/2006 Henry
If ib_workflow and gb_WorkFlow and of_get_app_setting("set_9",'I') <> 1 Then //Modify by Evan 01/15/2008
	of_create_action_item_by_workflow('STATUS')
	
End If
//End added for work flow	

RETURN 1
end function

public function integer of_se ();
tab_view.x = 1
tab_view.y = 1

st_recs.x = 1200
tab_view.tabpage_detail_1.dw_apptmnt_status.Modify( "gb_cp.Visible = '0'" )
tab_view.tabpage_detail_1.dw_apptmnt_status.Modify( "verifying_facility.Visible = '0'" )
tab_view.tabpage_detail_1.dw_apptmnt_status.Modify( "t_verifying_facility.Visible = '0'" )
tab_view.tabpage_detail_1.dw_apptmnt_status.Modify( "t_verifying_facility.Visible = '0'" )
tab_view.tabpage_detail_1.dw_apptmnt_status.Modify( "cust_type_t.Visible = '0'" )
tab_view.tabpage_detail_1.dw_apptmnt_status.Modify( "parent_facility_id.Visible = '0'" )
//dw_orgs_facilities.Visible = False
dw_orgs_facilities.width = 1
dw_orgs_facilities.height = 1
dw_orgs_facilities.x = 100
dw_orgs_facilities.y = 100
dw_orgs_facilities.BringToTop = False


Return 1
end function

public function integer of_custom_labels (datawindow adw_from);//maha 071205 for custom labels for detail 2 appointment status

datastore lds_fields
integer ic
integer i
string fname
string lname
string err
string s

lds_fields  = create datastore
lds_fields.dataobject = "d_affil_stat_painter"
lds_fields.settransobject(sqlca)
ic = lds_fields.retrieve()


if ic > 0 then
	for i = 1 to ic
		fname = lds_fields.getitemstring(i,"field_name")
		lname = lds_fields.getitemstring(i,"field_name_allias")
		s = fname + "_t.text = '" + lname + "'"
		err = adw_from.modify(s)
		//messagebox(s,err)
	next
end if



destroy lds_fields

return 1
end function

public function integer of_validate (datawindow adw_from);//maha 071205 for custom field rewquired validation for detail 2 appointment status
//called from preupdate of detail 1
datastore lds_fields
integer ic
integer i
integer li_val
string ls_val
string fname
string lname
integer err
string s
long ll_prac
long ll_parent
long ll_found_prac
long ll_found_parent

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-33
//$<modify> 04.11.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Change the local variables to instance variables.  Therefore, they can be used globally.

/*
lds_fields  = create datastore
lds_fields.dataobject = "d_affil_stat_painter" //in painter library
lds_fields.settransobject(sqlca)
ic = lds_fields.retrieve()
*/

IF NOT IsValid(ids_fields) THEN
	ids_fields  = create datastore
	ids_fields.dataobject = "d_affil_stat_painter" //in painter library
	ids_fields.settransobject(sqlca)
	ids_fields.retrieve()
END IF

lds_fields = ids_fields
ic = lds_fields.Rowcount( )

//---------------------------- APPEON END ----------------------------

if ic > 0 then
	for i = 1 to ic
		li_val = lds_fields.getitemnumber(i,"use_validation")
		if li_val > 0 then
			fname = lds_fields.getitemstring(i,"field_name")
			lname = lds_fields.getitemstring(i,"field_name_allias")
			ls_val = adw_from.getitemstring(adw_from.getrow(),fname)
			ll_prac = adw_from.getitemnumber(adw_from.getrow(),"prac_id")
			ll_parent = adw_from.getitemnumber(adw_from.getrow(),"parent_facility_id")
			//choose case li_val
				//case 1 //unique required	
			if isnull(ls_val) or LenA(ls_val) < 1 then
				messagebox("Required data","Unique value required in field " + lname + " on detail 2 tab")
				destroy lds_fields
				return -1
			else
				select count(custom_1) into :err from pd_affil_stat where custom_1 = :ls_val and rec_id not in ( select rec_id from pd_affil_stat where prac_id = :ll_prac and parent_facility_id = :ll_parent);
				//messagebox("count",err)
				if err > 0 then
					select parent_facility_id,prac_id into :ll_found_parent,:ll_found_prac from pd_affil_stat where custom_1 = :ls_val and rec_id not in ( select rec_id from pd_affil_stat where prac_id = :ll_prac and parent_facility_id = :ll_parent);
					messagebox("Validation Error","Unique value required in field " + lname + " on detail 2 tab.  Practitioner " + string(ll_found_prac) + " for facility " + string(ll_found_parent) + " has this id.")
					destroy lds_fields
					return -1
				end if
			//end choose
			end if
		end if
		//messagebox(s,err)
	next
end if

destroy lds_fields

return 1

end function

public function integer of_setup_dw2 ();//////////////////////////////////////////////////////////////////////
// $<function>pfc_cst_u_apptmnt_status.of_setup_dw2()
// $<arguments>(None)
// $<returns> integer
// $<description> Performance tuning
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 02.22.2006 by Cao YongWang
//////////////////////////////////////////////////////////////////////

datawindowchild dwchild
Long nulllong

String ls_version

SetNull( nulllong )
tab_view.tabpage_detail_2.dw_staff_cat.of_SetRowManager( TRUE )
tab_view.tabpage_detail_2.dw_staff_cat.of_SetReqColumn(TRUE)
tab_view.tabpage_detail_2.dw_staff_cat.of_SetDropDownCalendar( TRUE )
tab_view.tabpage_detail_2.dw_staff_cat.iuo_calendar.of_Register(tab_view.tabpage_detail_2.dw_staff_cat.iuo_calendar.DDLB)
tab_view.tabpage_detail_2.dw_staff_cat.of_SetTransObject(SQLCA)

tab_view.tabpage_detail_2.dw_staff_cat.GetChild( "staff_category", dwchild )
dwchild.SetTransObject( SQLCA )
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-34
//$<modify> 01.24.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Write script to retrieve data from a cache instead of from the database.

//dwchild.Retrieve("staff category")
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper(lookup_name) = '" + upper('staff category') + "'", dwchild)
//---------------------------- APPEON END ----------------------------

dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "lookup_code", nulllong )



//setup depart dw

tab_view.tabpage_detail_2.dw_departments.of_SetRowManager( TRUE )
tab_view.tabpage_detail_2.dw_departments.of_SetReqColumn(TRUE)
tab_view.tabpage_detail_2.dw_departments.of_SetTransObject(SQLCA)

tab_view.tabpage_detail_2.dw_departments.of_SetDropDownCalendar( TRUE )
tab_view.tabpage_detail_2.dw_departments.iuo_calendar.of_Register(tab_view.tabpage_detail_2.dw_departments.iuo_calendar.DDLB)
tab_view.tabpage_detail_2.dw_departments.of_SetTransObject(SQLCA)

tab_view.tabpage_detail_2.dw_departments.GetChild( "department", dwchild )
dwchild.SetTransObject( SQLCA )
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-35
//$<modify> 01.24.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Write script to retrieve data from a cache instead of from the database.

//dwchild.Retrieve("department")
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper(lookup_name) = '" + upper('department') + "'", dwchild)
//---------------------------- APPEON END ----------------------------

dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "lookup_code", nulllong )

tab_view.tabpage_detail_2.dw_departments.GetChild( "section", dwchild )
dwchild.SetTransObject( SQLCA )
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-36
//$<modify> 01.24.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Write script to retrieve data from a cache instead of from the database.

//dwchild.Retrieve("section")
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper(lookup_name) = '" + upper('section') + "'", dwchild)
//---------------------------- APPEON END ----------------------------

dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "lookup_code", nulllong )

tab_view.tabpage_detail_2.dw_departments.GetChild( "rank", dwchild )
dwchild.SetTransObject( SQLCA )
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-37
//$<modify> 01.24.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Write script to retrieve data from a cache instead of from the database.

//dwchild.Retrieve("division")
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper(lookup_name) = '" + upper('division') + "'", dwchild)
//---------------------------- APPEON END ----------------------------

dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "lookup_code", nulllong )

//setup leave_table

tab_view.tabpage_detail_2.dw_leave.GetChild( "leave_of_absence_reason", dwchild )
dwchild.SetTransObject( SQLCA )
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-38
//$<modify> 01.24.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Write script to retrieve data from a cache instead of from the database.
//dwchild.Retrieve( "Reason for Leave of Absence" )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper(lookup_name) = '" + upper('Reason for Leave of Absence') + "'", dwchild)
//---------------------------- APPEON END ----------------------------

tab_view.tabpage_detail_2.dw_leave.of_SetDropDownCalendar( TRUE )
tab_view.tabpage_detail_2.dw_leave.iuo_calendar.of_Register(tab_view.tabpage_detail_2.dw_leave.iuo_calendar.DDLB)
tab_view.tabpage_detail_2.dw_leave.of_SetTransObject(SQLCA)


//setup cvo data dw
tab_view.tabpage_detail_2.dw_cvo.of_SetUpdateAble( False )

tab_view.tabpage_detail_2.dw_cvo.of_SetDropDownCalendar( TRUE )
tab_view.tabpage_detail_2.dw_cvo.iuo_calendar.of_Register( tab_view.tabpage_detail_2.dw_cvo.iuo_calendar.DDLB)

tab_view.tabpage_detail_2.dw_cvo.of_SetTransObject(SQLCA)
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-39
//$<comment> 01.24.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Comment out the following script, since the application has already retrieved data for dwchild
//$<modification> in of_setup_dw.
//tab_view.tabpage_detail_2.dw_cvo.GetChild( "priority_user", dwchild )
//dwchild.SetTransObject( SQLCA )
//dwchild.Retrieve()
//---------------------------- APPEON END ----------------------------

//setup questions tab
tab_view.tabpage_quest.dw_quest.of_SetTransObject(SQLCA)
tab_view.tabpage_quest.dw_quest.GetChild( "answer_code", dwchild )
dwchild.SetTransObject( SQLCA )
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-61
//$<modify> 01.24.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Write script to retrieve data from a cache instead of from the database.
//dwchild.Retrieve("question answers")
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper(lookup_name) = '" + upper('question answers') + "'", dwchild)
//---------------------------- APPEON END ----------------------------
dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "lookup_code", nulllong )

return 1
end function

public function integer of_retrieve_children2 ();//////////////////////////////////////////////////////////////////////
// $<function>pfc_cst_u_apptmnt_status.of_retrieve_children2()
// $<arguments>(None)
// $<returns> integer
// $<description> Retrieve data for tabpage_detail_2 from database. Refer to PT-05/06 for more information.
//////////////////////////////////////////////////////////////////////
// $<add> 02.22.2006 by Cao YongWang
//////////////////////////////////////////////////////////////////////

Integer li_rc
Long ll_rec_id


//	tab_view.tabpage_detail_2.dw_departments.SetTransObject( SQLCA )//maha082201
li_rc = tab_view.tabpage_detail_2.dw_departments.Retrieve( il_rec_id,gs_user_id  )//gs_user_id addedmaha120301
IF li_rc = 0 THEN
	tab_view.tabpage_detail_2.dw_departments.InsertRow( 0 )
END IF


//
gnv_appeondb.of_startqueue()
tab_view.tabpage_detail_2.dw_departments.Retrieve( il_rec_id,gs_user_id  )//gs_user_id addedmaha120301
//tab_view.tabpage_detail_2.dw_staff_cat.SetTransObject( SQLCA )//maha082201
tab_view.tabpage_detail_2.dw_staff_cat.Retrieve( il_rec_id,gs_user_id )
//tab_view.tabpage_detail_2.dw_leave.SetTransObject( SQLCA )//maha082201
tab_view.tabpage_detail_2.dw_leave.Retrieve( il_rec_id,gs_user_id )
//tab_view.tabpage_detail_2.dw_cvo.SetTransObject( SQLCA )//maha120301

//questions maha 090205
tab_view.tabpage_quest.dw_quest.Retrieve( il_rec_id,gs_user_id )
gnv_appeondb.of_commitqueue()


li_rc = tab_view.tabpage_detail_2.dw_departments.Rowcount()//gs_user_id addedmaha120301
IF li_rc = 0 THEN
	tab_view.tabpage_detail_2.dw_departments.InsertRow( 0 )
END IF
//

//tab_view.tabpage_detail_2.dw_staff_cat.SetTransObject( SQLCA )//maha082201
li_rc = tab_view.tabpage_detail_2.dw_staff_cat.Rowcount()
IF li_rc = 0 THEN
	tab_view.tabpage_detail_2.dw_staff_cat.InsertRow( 0 )
END IF
//tab_view.tabpage_detail_2.dw_leave.SetTransObject( SQLCA )//maha082201
li_rc = tab_view.tabpage_detail_2.dw_leave.Rowcount()
IF li_rc = 0 THEN
	tab_view.tabpage_detail_2.dw_leave.InsertRow( 0 )
END IF

RETURN 0
end function

public function integer of_create_action_item_by_workflow (string as_type);//Added for Work Flow. 10/30/2006
n_cst_workflow_triggers lnv_workflow
long ll_wf_id
str_action_item lstr_action

If not gb_workflow Then return 0
lnv_workflow = create n_cst_workflow_triggers

Choose Case upper(as_type)
	Case 'NEW'
		ll_wf_id = long(gnv_data.of_getitem("facility","facility_wf_new_practitioner","facility_id="+string(ii_parent_facility_id)))
	Case 'STATUS'
		ll_wf_id = long(gnv_data.of_getitem("facility","facility_wf_practitioner_status_change","facility_id="+string(ii_parent_facility_id)))
End Choose

//If there is no work flow is related to the facility, then return 
If isnull(ll_wf_id) or not ll_wf_id > 0 Then return 0
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.17.2006 By: Jervis
//$<reason> 
//lnv_workflow.of_workflow_create_action_items( il_prac_id, il_rec_id, 1, ii_parent_facility_id, ll_wf_id)
lstr_action.prac_id = il_prac_id
lstr_action.rec_id = il_rec_id
lstr_action.facility_id = ii_parent_facility_id
lstr_action.wf_id = ll_wf_id
lstr_action.screen_id = -10
lnv_workflow.of_workflow_create_action_items(lstr_action)
 
if isvalid(lnv_workflow) then destroy lnv_workflow
//---------------------------- APPEON END ----------------------------

return 1
end function

public function integer of_view_supporting_doc (long al_rec_id);Blob lb_all_data
int  li_ret
long  ll_data_length,ll_rec_id
string ls_Null,ls_TempFileName,ls_file_ext

ll_rec_id = al_rec_id

	SELECT top 1 datalength(file_data),file_type
	INTO :ll_data_length,:ls_file_ext
	FROM wv_question_documents
	WHERE rec_id=:ll_rec_id;
	
	IF sqlca.sqlcode < 0 THEN
		MessageBox("View Supporting Documetation"," Failed to get data from wv_question_documents due to "+sqlca.sqlerrtext)
		return -1
	ELSEIF sqlca.sqlcode=100 THEN
		MessageBox("View Supporting Documetation","Specified documetation data doesn't exist.")
		return -1
	END IF

IF gs_dbtype='asa' THEN
	SELECTBLOB file_data
	INTO :lb_all_data
	FROM wv_question_documents
	WHERE rec_id=:ll_rec_id;
		
	IF sqlca.sqlcode < 0 THEN
		MessageBox("View Supporting Documetation","Failed to get image from DB due to "+sqlca.sqlerrtext)
		return -1
	ELSEIF sqlca.sqlcode=100 THEN
		MessageBox("View Supporting Documetation","Cannot find specified documentation data from DB")
		return -1
	END IF

ELSE
	Integer li_counter
	Integer li_loops
	Blob lb_data
	Long ll_start

	// Get file data from database
	SELECT Datalength(file_data)
	INTO :ll_data_length
	FROM wv_question_documents
	WHERE rec_id=:ll_rec_id;
	
	IF sqlca.sqlcode < 0 THEN
		MessageBox("View Supporting Documetation","Failed to get documentation from DB due to "+sqlca.sqlerrtext)
		return -1
	ELSEIF sqlca.sqlcode=100 THEN
		MessageBox("View Supporting Documetation","Cannot find specified documentation data from DB")
		return -1
	END IF

	IF ll_data_length = 0 OR Isnull(ll_data_length) THEN
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
		ll_start = (li_counter - 1) * 8000 + 1
		SELECTBLOB substring(file_data,:ll_start,8000)
			INTO :lb_data
		FROM wv_question_documents
		WHERE rec_id=:ll_rec_id;
			
		IF sqlca.sqlcode < 0 THEN
			MessageBox("View Supporting Documetation","Failed to get documentation data from DB due to "+sqlca.sqlerrtext)
			return -1
		ELSEIF sqlca.sqlcode=100 THEN
			MessageBox("View Supporting Documetation","Cannot find specified documentation data from DB")
			return -1
		END IF
		
		lb_all_data += lb_data
	NEXT 
END IF

gnv_appeondll.of_parsepath(gs_dir_path + "temp")

ls_TempFileName = gs_dir_path+"temp\quest"+string(ll_rec_id)+"."+ls_file_ext


li_ret = f_saveblob(ls_TempFileName,lb_all_data)
IF li_ret < 0 THEN 
	MessageBox("View Supporting Documetation","Failed to save BLOB data to file "+ls_TempFileName)
	return -1
END IF

setnull(ls_Null)

ShellExecuteA ( Handle( This ), "open", ls_TempFileName , ls_Null, ls_Null, 4)

return 1

end function

public function integer of_add_net_dev_ai (string as_app_type, integer ai_app_id, integer ai_facility);//Start Code Change ----12.10.2007 #V8 maha - added facility argument
Long ll_rec_id
Long ll_action_type			
Long ll_action_status
Long ll_action_dept
String ls_app_type
String ls_action_notes
DateTime ldt_action_date
Integer li_facility_id


//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-32
//$<modify> 02.24.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Use Appeon Queue lables to reduce client-server interactions to improve runtime performance.

/*
			ll_rec_id = gnv_app.of_Get_Id("RECORD_ID")
//messagebox("net dev add",ai_app_id)
			//\/maha 101901
			select lookup_code into :ll_action_type from code_lookup where lookup_name = 'Action Type' and code = 'App Out To MD';
			IF SQLCA.SQLCODE = 100 THEN
				MessageBox("Error", "To automatically create an Network Development Action item for IntelliApp you will need to add 'App Out To MD' to the Action Type lookup table." )
				Return -1
			END IF
			//ll_action_type = -3
			select lookup_code into :ll_action_status from code_lookup where lookup_name = 'Action Status' and code = 'Incomplete';
			IF SQLCA.SQLCODE = 100 THEN
				MessageBox("Error", "To automatically create an Network Development Action item for IntelliApp you will need to add 'Incomplete' to the Action Status lookup table." )
				Return -1
			END IF			
			//ll_action_status = -110
			select lookup_code into :ll_action_dept from code_lookup where lookup_name = 'Action Department' and code = 'Credentialing';
			IF SQLCA.SQLCODE = 100 THEN
				MessageBox("Error", "To automatically create an Network Development Action item for IntelliApp you will need to add 'Credentailing' to the Action Department lookup table." )
				Return -1
			END IF			
			//ll_action_dept = -102
			//\maha
/*****************************pass the appt type				***/
			ls_app_type = as_app_type//tab_view.tabpage_detail_1.dw_apptmnt_status.GetItemString( ai_row, "apptmnt_type" )
			ll_rec_id = gnv_app.of_Get_Id("RECORD_ID")	
			//ll_action_type = -3
			//ll_action_status = -110
			//ll_action_dept = -102
			ls_action_notes = ""
			ldt_action_date = DateTime( Today(), Now() )
			li_facility_id = tab_view.tabpage_detail_1.dw_apptmnt_status.GetItemNumber( tab_view.tabpage_detail_1.dw_apptmnt_status.GetRow(), "parent_facility_id" )
			INSERT INTO net_dev_action_items  
    			    ( rec_id,   
	     	   	 prac_id,   
				 seq_no,
     	     	 action_type,   
			      action_date,   
	    			 action_dept,   
     	     	 action_user,   
		     	 next_action_date,   
			      notes,   
		     	 action_status,   
				 facility_id,
				 app_id,
				 app_type,
				 active_status)  
			VALUES ( :ll_rec_id,   
      			    :il_prac_id,  
				    :ll_rec_id,					
	    	     	    :ll_action_type,   
	     	    	    :ldt_action_date,   
				    :ll_action_dept,   
	     		    :gs_user_id,   
				     null,   
		     	    :ls_action_notes,   
			         :ll_action_status,   
	     		    :li_facility_id,
				    :ai_app_id,
				    :ls_app_type,
					 1)
			USING SQLCA;
			IF SQLCA.SQLCODE = -1 THEN
				MessageBox("Database Error", SQLCA.SQLERRTEXT )
				Return -1
			END IF			
			commit using sqlca;
*/

ll_action_type = Long(gnv_data.of_getitem( "code_lookup", "lookup_code", "upper(lookup_name) = upper('Action Type') and upper(code) = upper('App Out To MD')" ))
IF ll_action_type = 0 THEN
	MessageBox("Error", "To automatically create an Network Development Action item for IntelliApp you will need to add 'App Out To MD' to the Action Type lookup table." )
	Return -1
END IF

ll_action_status = Long(gnv_data.of_getitem( "code_lookup", "lookup_code", "upper(lookup_name) = upper('Action Status') and upper(code) = upper('Incomplete')" ))
IF ll_action_status = 0 THEN
	MessageBox("Error", "To automatically create an Network Development Action item for IntelliApp you will need to add 'Incomplete' to the Action Status lookup table." )
	Return -1
END IF			

ll_action_dept = Long(gnv_data.of_getitem( "code_lookup", "lookup_code", "upper(lookup_name) = upper('Action Department') and upper(code) = upper('Credentialing')" ))
IF ll_action_dept = 0 THEN
	MessageBox("Error", "To automatically create an Network Development Action item for IntelliApp you will need to add 'Credentailing' to the Action Department lookup table." )
	Return -1
END IF			

/*****************************pass the appt type				***/
			ls_app_type = as_app_type//tab_view.tabpage_detail_1.dw_apptmnt_status.GetItemString( ai_row, "apptmnt_type" )

			If il_rec_id_multi_app = 0 Then
				ll_rec_id = gnv_app.of_Get_Id("RECORD_ID")	
			Else
				il_rec_id_multi_app ++
				ll_rec_id =  il_rec_id_multi_app
			End IF

			//ll_action_type = -3
			//ll_action_status = -110
			//ll_action_dept = -102
			ls_action_notes = ""
			ldt_action_date = DateTime( Today(), Now() )
			//Start Code Change ----12.10.2007 #V8 maha  change facility id to argument
			//li_facility_id = tab_view.tabpage_detail_1.dw_apptmnt_status.GetItemNumber( tab_view.tabpage_detail_1.dw_apptmnt_status.GetRow(), "parent_facility_id" )
			li_facility_id = ai_facility
			//End Code Change---12.10.2007
gnv_appeondb.of_startqueue( )

			INSERT INTO net_dev_action_items  
    			    ( rec_id,   
	     	   	 prac_id,   
				 seq_no,
     	     	 action_type,   
			      action_date,   
	    			 action_dept,   
     	     	 action_user,   
		     	 next_action_date,   
			      notes,   
		     	 action_status,   
				 facility_id,
				 app_id,
				 app_type,
				 active_status)  
			VALUES ( :ll_rec_id,   
      			    :il_prac_id,  
				    :ll_rec_id,					
	    	     	    :ll_action_type,   
	     	    	    :ldt_action_date,   
				    :ll_action_dept,   
	     		    :gs_user_id,   
				     null,   
		     	    :ls_action_notes,   
			         :ll_action_status,   
	     		    :li_facility_id,
				    :ai_app_id,
				    :ls_app_type,
					 1)
			USING SQLCA;
			commit using sqlca;
			
gnv_appeondb.of_commitqueue( )

//---------------------------- APPEON END ----------------------------

Return 1
end function

on pfc_cst_u_apptmnt_status_oppe.create
this.st_recs=create st_recs
this.dw_orgs_facilities=create dw_orgs_facilities
this.tab_view=create tab_view
this.Control[]={this.st_recs,&
this.dw_orgs_facilities,&
this.tab_view}
end on

on pfc_cst_u_apptmnt_status_oppe.destroy
destroy(this.st_recs)
destroy(this.dw_orgs_facilities)
destroy(this.tab_view)
end on

event constructor;
inv_data_entry = CREATE pfc_cst_nv_data_entry_functions

//inv_data_entry.of_setup_cache()
//
//inv_data_entry.of_refresh_cache()
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-40
//$<add> 02.22.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Collect the SQL statements together and integrate them into Appeon Queue labels
//$<modification> to reduce client-server interactions.

integer ic , i
string  fname, lname , s, err
//
//tab_view.tabpage_detail_1.dw_apptmnt_status.of_SetDropDownCalendar( TRUE )
//tab_view.tabpage_detail_1.dw_apptmnt_status.iuo_calendar.of_Register(tab_view.tabpage_detail_1.dw_apptmnt_status.iuo_calendar.DDLB)
//
//tab_view.tabpage_detail_1.dw_comm_review.of_SetDropDownCalendar( TRUE )
//tab_view.tabpage_detail_1.dw_comm_review.iuo_calendar.of_Register(tab_view.tabpage_detail_1.dw_apptmnt_status.iuo_calendar.DDLB)

//The following script moved from the constructor event of dw_appmnt_status.
datawindowchild dwchild
gnv_appeondb.of_startqueue()
tab_view.tabpage_detail_1.dw_apptmnt_status.settransobject(sqlca) //maha 082201
tab_view.tabpage_detail_1.dw_apptmnt_status.GetChild( "parent_facility_id", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve(gs_user_id)

tab_view.tabpage_detail_1.dw_apptmnt_status.GetChild( "verifying_facility", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve(gs_user_id)
//
tab_view.tabpage_detail_1.dw_apptmnt_status.GetChild( "priority_user", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve()
//added by leiwei 03.22.2006
tab_view.tabpage_detail_1.dw_apptmnt_status.GetChild( "application_audit_facility", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve()
//added by leiwei 03.22.2006
tab_view.tabpage_detail_1.dw_apptmnt_status.GetChild( "affiliation_status", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve()
//
ids_fields  = create datastore
ids_fields.dataobject = "d_affil_stat_painter"
ids_fields.settransobject(sqlca)
ids_fields.retrieve()
//
tab_view.tabpage_browse.dw_browse.GetChild( "parent_facility_id", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve()
//
tab_view.tabpage_detail_2.dw_cvo.GetChild( "pd_affil_stat_admit_priv", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve()

gnv_appeondb.of_commitqueue()
//The following script is moved from of_custom_labels function
ic = ids_fields.rowcount()
if ic > 0 then
	for i = 1 to ic
		fname = ids_fields.getitemstring(i,"field_name")
		lname = ids_fields.getitemstring(i,"field_name_allias")
		s = fname + "_t.text = '" + lname + "'"
		//Start Code Change ----10.01.2008 #V85 maha - added for signed field
		if MidA(fname,1,4) = 'cust' then
			err = tab_view.tabpage_detail_2.dw_cvo.modify(s)
		else
			tab_view.tabpage_detail_1.dw_apptmnt_status.modify(s)
		end if
		//End Code Change---10.01.2008
	next
end if

If Upper(appeongetclienttype()) = "WEB" Then
	if tab_view.tabpage_browse.visible = false then
		if tab_view.selectedtab = 2 then
			tab_view.selectedtab = 1
		end if
	end if		
End If
//---------------------------- APPEON END ----------------------------

end event

event destructor;//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-08-08 By: Scofield
//$<Reason> Destructor the instance variable

if IsValid(ids_fields) then
	Destroy ids_fields
end if

if IsValid(ids_spec_link) then
	Destroy ids_spec_link
end if

if IsValid(ids_all_spec) then
	Destroy ids_all_spec
end if

if IsValid(ids_address_link) then
	Destroy ids_address_link
end if

if IsValid(ids_all_addresses) then
	Destroy ids_all_addresses
end if

if IsValid(ids_hosp_link) then
	Destroy ids_hosp_link
end if

if IsValid(ids_all_hosp) then
	Destroy ids_all_hosp
end if

if IsValid(ids_last_app_audit_seq_no) then
	Destroy ids_last_app_audit_seq_no
end if

if IsValid(idw_rqrd_data) then
	Destroy idw_rqrd_data
end if

if IsValid(idw_audit) then
	Destroy idw_audit
end if

if IsValid(ids_address_linked) then
	Destroy ids_address_linked
end if
//---------------------------- APPEON END ----------------------------

end event

type st_recs from statictext within pfc_cst_u_apptmnt_status_oppe
integer x = 3150
integer y = 1628
integer width = 334
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Record 1 of 1"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_orgs_facilities from u_dw within pfc_cst_u_apptmnt_status_oppe
integer width = 736
integer height = 1680
integer taborder = 10
boolean titlebar = true
string title = "Select Payor/Hospital"
string dataobject = "d_pd_affil_status_orgs_only"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event rowfocuschanged;call super::rowfocuschanged;Integer li_org_id
Integer li_facility_id

ib_retrieved_allready = False	//2007.7.3 By Jervis

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-41
//$<add> 04.11.2006 By: LeiWei
//$<reason> Performance tuning.
//$<modification> Add a condition that when the value of ib_postupdate is TRUE, the RowFocusChanged event will not be
//$<modification> executed. Refer to PT-42/43 for more information.
IF ib_postupdate THEN RETURN
//---------------------------- APPEON END ----------------------------

if currentrow < 1 then return  0

IF This.RowCount() > 0 AND NOT ib_first_retrieve  THEN
	ii_selected_facility_id = This.GetItemNumber( currentrow, "parent_facility_id")
	of_retrieve_detail( )
	tab_view.tabpage_browse.dw_browse.SelectRow( 0, False )
	tab_view.tabpage_browse.dw_browse.SelectRow(1, True)
END IF

//ib_retrieved_allready = False	//2007.7.3 By Jervis move to up



end event

event clicked;call super::clicked;Integer li_row

li_row = This.GetClickedRow( )

//DEBUGBREAK()

IF li_row = 0 THEN
	tab_view.tabpage_detail_1.dw_apptmnt_status.SetFocus( )
	Return -1
END IF

This.SelectRow( 0, False )
This.SelectRow( li_row, True )
This.ScrollToRow( li_row )
This.SetRow( li_row )
end event

event rowfocuschanging;call super::rowfocuschanging;ib_retrieved_allready = True
end event

event constructor;call super::constructor;IF gs_cust_type = "C" THEN
	This.Title = 'Select Client'
ELSEIF gs_cust_type = "I" THEN
	This.Title = 'Select Payor/Hospital'
ELSE
	This.Title = 'Select Facility'
END IF
end event

type tab_view from tab within pfc_cst_u_apptmnt_status_oppe
integer x = 759
integer y = 4
integer width = 2729
integer height = 1684
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 79741120
boolean raggedright = true
tabposition tabposition = tabsonbottom!
integer selectedtab = 2
tabpage_browse tabpage_browse
tabpage_detail_1 tabpage_detail_1
tabpage_detail_2 tabpage_detail_2
tabpage_quest tabpage_quest
end type

on tab_view.create
this.tabpage_browse=create tabpage_browse
this.tabpage_detail_1=create tabpage_detail_1
this.tabpage_detail_2=create tabpage_detail_2
this.tabpage_quest=create tabpage_quest
this.Control[]={this.tabpage_browse,&
this.tabpage_detail_1,&
this.tabpage_detail_2,&
this.tabpage_quest}
end on

on tab_view.destroy
destroy(this.tabpage_browse)
destroy(this.tabpage_detail_1)
destroy(this.tabpage_detail_2)
destroy(this.tabpage_quest)
end on

event selectionchanged;
if oldindex = -1 or newindex = -1 then return

If Upper(appeongetclienttype()) = "PB" Then
	if oldindex = 3 and newindex = 2 and ib_select = true then 
		ib_select = false
		selecttab(3)
		return
	end if
end if

//------------------- APPEON BEGIN -------------------
//$<delete> Evan 06.18.2009
//$<reason> Menu readonly security
/*
//w_mdi.ChangeMenu( m_pfe_cst_data_entry )
//w_mdi.of_menu_security( w_mdi.MenuName ) //maha 070104
// mskinner 21 March 2006 -- begin
if isvalid(m_pfe_cst_data_entry) then 
  m_pfe_cst_data_entry.m_edit.m_delete1.enabled = True
  m_pfe_cst_data_entry.m_edit.m_insert.enabled = True
end if
// mskinner 21 March 2006 -- begin
//w_prac_data_1.tab_1.tabpage_detail.uo_data_entry.of_add_delete_enable()
*/
//------------------- APPEON END ---------------------

IF newindex = 1 THEN
	tab_view.tabpage_detail_1.dw_apptmnt_status.Visible = False
	tab_view.tabpage_browse.dw_browse.Visible = True
		
ELSE
	tab_view.tabpage_browse.dw_browse.Visible = False
	tab_view.tabpage_detail_1.dw_apptmnt_status.Visible = True
END IF

IF gb_se_version THEN
	m_pfe_cst_data_entry.m_file.m_multiapp.Visible = False
	m_pfe_cst_data_entry.m_file.m_multiapp.ToolBarItemVisible = False
END IF
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-25
//$<add> 02.22.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Make the condition that of_retrieve_children2 will be executed to retrieve data only when
//$<modification> tabpage_browse or tabpage_quest is selected, since data in tabpage_detail_2 is used only by 
//$<modification> tabpage_browse and tabpage_quest. Refer to PT-24 for more information.

If newindex = 3 or newindex = 4 Then
	If not ib_set_dw2 Then 
		of_setup_dw2()
		ib_set_dw2 = true
	End If
	
	If ib_retrieve_detail2 Then 
		of_retrieve_children2()
		ib_retrieve_detail2 = false
		ib_select = True
	End If
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 2007-01-26 By: Rodger Wu (attest quest)
	//$<reason> Check the right to Attest Question tab.
	integer li_cnt, i
	
	li_cnt = UpperBound( w_mdi.ii_security_action_id )
	FOR i = 1 TO li_cnt
		IF w_mdi.ii_security_action_id[ i ] = 128 THEN
			IF w_mdi.ii_security_action_value[ i ] = 0 THEN//Readonly
				This.tabpage_quest.dw_quest.modify( "datawindow.readonly = 'Yes'" )
			ELSE//Full access.
				This.tabpage_quest.dw_quest.modify( "datawindow.readonly = 'No'" )
			END IF
			EXIT;
		END IF		
	NEXT
	//---------------------------- APPEON END ----------------------------
	
End If
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 05/14/2008 By: Ken.Guo
//$<reason> Set focus to currect tabpage
Choose Case Newindex
	Case 1
		This.tabpage_browse.dw_browse.SetFocus()
	Case 2
		This.Tabpage_detail_1.dw_apptmnt_status.SetFocus()
	Case 3
		This.tabpage_detail_2.dw_departments.SetFocus()		
	Case 4
		This.tabpage_quest.dw_quest.SetFocus()
End Choose
//---------------------------- APPEON END ----------------------------



//---------------------------- APPEON END ----------------------------

end event

type tabpage_browse from userobject within tab_view
event create ( )
event destroy ( )
integer x = 18
integer y = 16
integer width = 2693
integer height = 1556
long backcolor = 79741120
string text = "Browse"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Justify!"
long picturemaskcolor = 553648127
dw_browse dw_browse
end type

on tabpage_browse.create
this.dw_browse=create dw_browse
this.Control[]={this.dw_browse}
end on

on tabpage_browse.destroy
destroy(this.dw_browse)
end on

type dw_browse from u_dw within tabpage_browse
integer x = 23
integer y = 20
integer width = 2633
integer height = 1460
integer taborder = 11
string dataobject = "d_pd_affil_status_browse"
boolean hscrollbar = true
boolean vscrollbar = false
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;Integer li_clicked_row

li_clicked_row = This.GetClickedRow()

IF li_clicked_Row > 0 THEN
	tab_view.tabpage_detail_1.dw_apptmnt_status.SetRow( li_clicked_row )
	tab_view.tabpage_detail_1.dw_apptmnt_status.ScrollToRow( li_clicked_row )
	This.SelectRow( 0, False)
	This.SelectRow( li_clicked_row, True )
END IF
end event

event constructor;This.of_SetUpdateAble( False )

end event

event doubleclicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08.09.2006 By: LeiWei
//$<reason> Fix a defect.

IF appeongetclienttype() = 'WEB' THEN
	This.Triggerevent( clicked! )
END IF

//---------------------------- APPEON END ----------------------------

tab_view.SelectTab( 2 )
end event

event rowfocuschanged;call super::rowfocuschanged;IF currentrow = 0 THEN
	RETURN
END IF
//messagebox("rfc","browse")
st_recs.Text = "Record " + String( currentrow ) + " of " + String( This.RowCount() )
end event

event pfc_deleterow;//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 05/14/2008 By: Ken.Guo
//$<reason> Use Detail datawindow to delete row.
Return tab_view.tabpage_detail_1.dw_apptmnt_status.event pfc_deleterow()
//---------------------------- APPEON END ----------------------------


end event

event pfc_addrow;//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 05/14/2008 By: Ken.Guo
//$<reason> Use Detail datawindow to add row.
Tab_view.tabpage_detail_1.dw_apptmnt_status.Post Event pfc_addrow()
Return 1
//---------------------------- APPEON END ----------------------------


end event

event pfc_update;//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 05/14/2008 By: Ken.Guo
//$<reason> Use Detail datawindow to update.
Return Tab_view.tabpage_detail_1.dw_apptmnt_status.Event pfc_update(ab_accepttext,ab_resetflag)
//---------------------------- APPEON END ----------------------------


end event

event pfc_postupdate;//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 05/14/2008 By: Ken.Guo
//$<reason> Use Detail datawindow to postupdate.
Return Tab_view.tabpage_detail_1.dw_apptmnt_status.Event pfc_postupdate()
//---------------------------- APPEON END ----------------------------

end event

type tabpage_detail_1 from userobject within tab_view
event create ( )
event destroy ( )
integer x = 18
integer y = 16
integer width = 2693
integer height = 1556
long backcolor = 79741120
string text = "Detail 1"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "DataWindow1!"
long picturemaskcolor = 553648127
st_6 st_6
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
sle_4 sle_4
sle_3 sle_3
sle_2 sle_2
sle_1 sle_1
dw_apptmnt_status dw_apptmnt_status
gb_6 gb_6
dw_comm_review dw_comm_review
gb_1 gb_1
end type

on tabpage_detail_1.create
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.sle_4=create sle_4
this.sle_3=create sle_3
this.sle_2=create sle_2
this.sle_1=create sle_1
this.dw_apptmnt_status=create dw_apptmnt_status
this.gb_6=create gb_6
this.dw_comm_review=create dw_comm_review
this.gb_1=create gb_1
this.Control[]={this.st_6,&
this.st_5,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_1,&
this.sle_4,&
this.sle_3,&
this.sle_2,&
this.sle_1,&
this.dw_apptmnt_status,&
this.gb_6,&
this.dw_comm_review,&
this.gb_1}
end on

on tabpage_detail_1.destroy
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_4)
destroy(this.sle_3)
destroy(this.sle_2)
destroy(this.sle_1)
destroy(this.dw_apptmnt_status)
destroy(this.gb_6)
destroy(this.dw_comm_review)
destroy(this.gb_1)
end on

type st_6 from statictext within tabpage_detail_1
integer x = 1966
integer y = 1112
integer width = 96
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 67108864
string text = "To:"
boolean focusrectangle = false
end type

type st_5 from statictext within tabpage_detail_1
integer x = 1422
integer y = 1112
integer width = 123
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 67108864
string text = "From:"
boolean focusrectangle = false
end type

type st_4 from statictext within tabpage_detail_1
integer x = 786
integer y = 1112
integer width = 96
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 67108864
string text = "To:"
boolean focusrectangle = false
end type

type st_3 from statictext within tabpage_detail_1
integer x = 251
integer y = 1112
integer width = 146
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 67108864
string text = "From:"
boolean focusrectangle = false
end type

type st_2 from statictext within tabpage_detail_1
integer x = 1257
integer y = 1112
integer width = 178
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 67108864
string text = "OPPE"
boolean focusrectangle = false
end type

type st_1 from statictext within tabpage_detail_1
integer x = 82
integer y = 1112
integer width = 169
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 67108864
string text = "FPPE"
boolean focusrectangle = false
end type

type sle_4 from singlelineedit within tabpage_detail_1
integer x = 2066
integer y = 1100
integer width = 370
integer height = 76
integer taborder = 41
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
end type

type sle_3 from singlelineedit within tabpage_detail_1
integer x = 1554
integer y = 1100
integer width = 370
integer height = 76
integer taborder = 41
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
end type

type sle_2 from singlelineedit within tabpage_detail_1
integer x = 878
integer y = 1100
integer width = 370
integer height = 76
integer taborder = 41
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
end type

type sle_1 from singlelineedit within tabpage_detail_1
integer x = 393
integer y = 1100
integer width = 370
integer height = 76
integer taborder = 31
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
end type

type dw_apptmnt_status from u_dw within tabpage_detail_1
event ue_itemchanged ( integer al_application_audit_facility )
integer x = 5
integer width = 2688
integer height = 1028
integer taborder = 11
string dataobject = "d_pd_affil_status"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event ue_itemchanged(integer al_application_audit_facility);//////////////////////////////////////////////////////////////////////
// $<event>u_dwue_itemchanged()
// $<arguments>
//		value	integer	al_application_audit_facility		
// $<returns> 
// $<description> Add functionality to not have to select an Audit Facility from Appointment Status Screen
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 10.13.2006 by Jack (Inova)
//////////////////////////////////////////////////////////////////////

this.setitem(this.getrow(),'application_audit_facility',al_application_audit_facility)

end event

event itemchanged;call super::itemchanged;n_ds lds_cred_comms
DataWindowChild dwchild
Integer li_found
Integer nullval
Integer li_committee_cnt
Integer li_ver_facility
Integer li_current_com_rc
Integer li_facility_id
Integer cc
Integer li_num_comms
Integer i
integer li_days //maha
integer li_years //maha
Integer li_ans
Integer c
Integer li_nr
String ls_app_type
String nulldata
Integer li_rec_no
Long ll_rec_id
Long ll_action_type
Long ll_action_dept
Long ll_action_status
String ls_action_notes
Date ldt_action_date
date ld_apptmnt_start_date //$<add> 01.13.2006 By: Liang QingShi - Define a variable to be used in subsequent script.
//Start Code Change ----03.03.2008 #V8 maha
integer li_day
integer li_month
integer li_year
date ld_apptmnt_end_date
//End Code Change---03.03.2008

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 10.13.2006 By: Jack (Inova)
//$<reason> Add functionality to not have to select an Audit Facility from Appointment Status Screen
/*
this.accepttext()
*/
long ll_application_audit_facility_old//,ll_application_audit_facility_new //comment 08/06/2007 by: Andy

ll_application_audit_facility_old = this.getitemnumber(this.getrow(),'application_audit_facility')
//comment 08/06/2007 by: Andy //Reason:BugJ080108,BugJ080109
//It's not used behind here.
//this.accepttext()
//ll_application_audit_facility_new = this.getitemnumber(this.getrow(),'application_audit_facility')
//end of comment
//---------------------------- APPEON END ----------------------------

SetNull( nullval )
SetNull( nulldata)

IF This.GetColumnName() = "active_status" THEN
	of_set_active( Integer( data ) )
END IF

ll_rec_id = this.getitemnumber(this.getrow(),"rec_id")
//IF This.GetColumnName() = "affiliation_status" THEN
//	IF data = "C" THEN
//		This.Modify( "date_app_rcvd.Edit.Required=No" )
//		This.Modify( "date_app_signed.Edit.Required=No" )
//	ELSE
//		This.Modify( "date_app_rcvd.Edit.Required=Yes" )
//		This.Modify( "date_app_signed.Edit.Required=Yes" )
//	END IF
//END IF

//appt start date
IF This.GetColumnName() = "apptmnt_start_date" THEN
	//\/maha 012201 to allow variable appointment years.
	li_facility_id = this.getitemnumber(this.getrow(),"parent_facility_id") //maha 081003 to get when entered on a new record

	select appointment_years
	into :li_years
	from facility
	where facility_id = :li_facility_id; //maha changed 081003 from ii_selected_facility_id
	
//Start Code Change ----03.03.2008 #V8 maha - modification for set of end date working around leap year
	this.accepttext( )
	ld_apptmnt_start_date = date(this.getitemdatetime(row,'apptmnt_start_date'))
	//-------Begin Modified by Alfee 11.06.2008 ------------------------
	/*	li_day = day(ld_apptmnt_start_date)
	li_month = month(ld_apptmnt_start_date)	
	li_year = year(ld_apptmnt_start_date)	
	if li_years > 0 then
		li_year += li_years
	end if	
	ld_apptmnt_end_date = date(string(li_year) + "-" + string(li_month) + "-" + string(li_day) ) */
	//Start Code Change ----09.30.2014 #V14.2 maha
	if li_years < 0 then
		ld_apptmnt_end_date =	inv_datetime.of_exp_date_birthday( abs(li_years), ld_apptmnt_start_date, il_prac_id )
	elseif li_years > 0 then
		ld_apptmnt_end_date = inv_datetime.of_relativeyear(ld_apptmnt_start_date, li_years)
	//--------End Modified ---------------------------------------------
		ld_apptmnt_end_date = RelativeDate( ld_apptmnt_end_date, -1 )
	end if
	//End Code Change ----09.30.2014

	if li_years > 0 then // if set to 0 don't set end date.
		This.SetItem( row, "apptmnt_end_date", ld_apptmnt_end_date )
	end if
//End Code Change---03.03.2008

	if This.getItemstring( row, "apptmnt_type") = "I" then //\/maha 080102 set initial date
		if isnull(this.getitemdatetime(row, "inital_appmnt_date")) then //Start Code Change ---- 04.24.2006 #405 maha don't reset if set
			This.SetItem( row, "inital_appmnt_date",ld_apptmnt_start_date)
		end if
	end if
	//---------------------------- APPEON END ----------------------------
	
	if This.getItemnumber( row, "active_status") = 4 then //\/maha 080102 
		This.SetItem( row, "active_status",1)
		of_set_active(1) //maha app080405
	end if
END IF

IF This.GetColumnName() = "apptmnt_type" THEN  //\/maha 080102 set to pending
	this.accepttext()
	if This.getItemstring( row, "apptmnt_type") = "I" then
		This.setItem( row, "active_status",4)
		of_set_active(4) //maha app080405
	end if
END IF
//app audit
IF This.GetColumnName() = "application_audit_facility" AND +&
	( This.GetItemStatus( row, 0, Primary! ) = DataModified!  OR +&
	This.GetItemStatus( row, 0, Primary! ) = NotModified! ) THEN
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 10.13.2006 By: Jack (Inova)
	//$<reason> Add functionality to not have to select an Audit Facility from Appointment Status Screen
	/*
	MessageBox("Change Audit Template", "If you modify the application audit " +&
				"template, all the data in the current application audit screen will be lost! "+&
				"  Continue?", Question!, YesNo!, 1 )
	*/
	integer li_mes
	li_mes = MessageBox("Change Audit Template", "If you modify the application audit " +&
				"template, all the data in the current application audit screen will be lost! "+&
				"  Continue?", Question!, YesNo!, 1 )
				
	if li_mes = 2 then
		this.post event ue_itemchanged(ll_application_audit_facility_old)
	end if
	//---------------------------- APPEON END ----------------------------

END IF	
//\/****************parent facility updates**************************

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-45
//$<add> 02.23.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Ingetrate SQL statements together into Appeon Queue labels to reduce client-server interactions,
//$<modification> Refer PT-46/47/48/49 to for more information.

IF This.GetColumnName() = "parent_facility_id" THEN
	//
	Integer li_dat
	Integer li_dvf
	li_facility_id = Integer( data )
	gnv_appeondb.of_startqueue()
	
	SELECT Count( committee_id )  
	INTO :li_committee_cnt  
	FROM committee_lookup  
	WHERE committee_lookup.facility_id = :li_facility_id   ;
	//
	SELECT default_audit_temp, default_verif_facility INTO :li_dat, :li_dvf FROM facility WHERE facility_id = :li_facility_id;
	//
	
	gnv_appeondb.of_commitqueue() //09.05.2008 By Jervis, APB queue Bug
	
	lds_cred_comms = CREATE n_ds
	lds_cred_comms.DataObject = "d_dddw_credentialing_committees" 
	lds_cred_comms.of_SetTransObject( SQLCA )
	lds_cred_comms.Retrieve( li_facility_id )
	//
	tab_view.tabpage_detail_1.dw_comm_review.GetChild( "committee_id", dwchild )
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve( Integer( data ) )		
	//gnv_appeondb.of_commitqueue() 09.05.2008 By Jervis APB Bug
	
End If
//---------------------------- APPEON END ----------------------------

//parent facility	
IF This.GetColumnName() = "parent_facility_id" THEN
	li_facility_id = Integer( data )
	//messagebox("", data)
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-46
	//$<comment> 02.23.2006 By: Cao YongWang
	//$<reason> Performance tuning.
	//$<modification> Move the SQL statements to previous script and integrate it with other
	//$<modification> SQL statements into Appeon Queue labels to improve runtime performance. 
	//$<modification> Refer to PT-45 for information.
	/*
	SELECT Count( committee_id )  
	INTO :li_committee_cnt  
	FROM committee_lookup  
	WHERE committee_lookup.facility_id = :li_facility_id   ;
	*/
	//---------------------------- APPEON END ----------------------------

	IF li_committee_cnt = 0 THEN
		MessageBox("Committee", "The facility that you are selecting has no Committee setup. Go to the facility painter and click on the Committee tab to add a committee.  (System->Painters->Facility Painter)" )
		This.SetItem( row, "parent_facility_id",  nullval )		
		Return 2
	END IF

	FOR i = 1 TO dw_orgs_facilities.RowCount()
		IF dw_orgs_facilities.GetItemNumber(i,  "parent_facility_id" ) = li_facility_id THEN
			li_found++
		END IF
	END FOR
	
	IF li_found > 0 THEN
		//MessageBox("Parent Facility", "There is already a Appointment Status record assigned to the Parent Facility you have selected.  Please reselect another parent facility. ")
		MessageBox("Parent Facility", "There is already an Appointment Status record assigned to the Parent Facility you have selected.  Please select another parent facility. ")
		This.SetItem( row, "parent_facility_id", Nullval )		
		Return 2
	END IF
END IF

IF This.GetColumnName() = "parent_facility_id" AND +&
	( This.GetItemStatus( row, 0, Primary! ) = DataModified!  OR +&
	This.GetItemStatus( row, 0, Primary! ) = NotModified! ) THEN
	li_ans = MessageBox("Change Parent Facility", "Because you have changed the Parent " +&
				"Facility you will have to modify the link screens in the Address, Hospital and Board screens.  Continue?", Question!, YesNo!, 1 )
	IF li_ans = 2 THEN
		//Modify 08/06/2007 by: Andy Reason:BugJ080108
		//Return 1
		setitem(row,string(dwo.name),getitemnumber(row,string(dwo.name)))
		Return 2
		//end of modify
	END IF
	//maha added 02-03-03 to update the detail 2 tables
	//maha moved to preupdate 062303
//	update pd_affil_dept set facility_id = :li_facility_id where rec_id = :ll_rec_id;
//	update pd_affil_staff_cat set facility_id = :li_facility_id where rec_id = :ll_rec_id;
//	update pd_affil_staff_leave set facility_id = :li_facility_id where rec_id = :ll_rec_id;
//	commit using sqlca;
	
END IF	

IF This.GetColumnName() = "parent_facility_id" AND This.GetItemStatus( row, 0, Primary! ) = Newmodified!  THEN
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-47
	//$<comment> 02.23.2006 By: Cao YongWang
	//$<reason> Performance tuning.
	//$<modification> Move the SQL statements to previous script and integrate it with other
	//$<modification> SQL statements into Appeon Queue labels to improve runtime performance. 
	//$<modification> Refer to PT-45 for information.
	/*
	Integer li_dat
	Integer li_dvf
	li_facility_id = Integer( data )	
	SELECT default_audit_temp, default_verif_facility INTO :li_dat, :li_dvf FROM facility WHERE facility_id = :li_facility_id;
	*/
	//---------------------------- APPEON END ----------------------------
	This.SetItem( row, "application_audit_facility", li_dat )
	This.SetItem( row, "verifying_facility", li_dvf )
END IF	

IF This.GetColumnName() = "parent_facility_id" THEN
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-48
	//$<comment> 02.23.2006 By: Cao YongWang
	//$<reason> Performance tuning.
	//$<modification> Move the SQL statements to previous script and integrate it with other
	//$<modification> SQL statements into Appeon Queue labels to improve runtime performance. 
	//$<modification> Refer to PT-45 for information.
	/*
	lds_cred_comms = CREATE n_ds
	lds_cred_comms.DataObject = "d_dddw_credentialing_committees" 
	lds_cred_comms.of_SetTransObject( SQLCA )
	li_facility_id = Integer( data )
	li_num_comms = lds_cred_comms.Retrieve( li_facility_id )
	*/
	li_num_comms = lds_cred_comms.Rowcount()
	//---------------------------- APPEON END ----------------------------

	li_current_com_rc = tab_view.tabpage_detail_1.dw_comm_review.RowCount()
	FOR cc = 1 TO li_current_com_rc
		tab_view.tabpage_detail_1.dw_comm_review.DeleteRow( 1 )
	END FOR
long licid
	FOR c = 1 TO li_num_comms
		li_nr = tab_view.tabpage_detail_1.dw_comm_review.InsertRow( 0 )
		tab_view.tabpage_detail_1.dw_comm_review.SetItem( li_nr, "facility_id", Integer( data ) )
      licid = lds_cred_comms.GetItemNumber( c, "committee_id" )
		tab_view.tabpage_detail_1.dw_comm_review.SetItem( li_nr, "committee_id", licid )
		tab_view.tabpage_detail_1.dw_comm_review.SetItem( li_nr, "active_status", 1 )
		tab_view.tabpage_detail_1.dw_comm_review.SetItem( li_nr, "rec_id", il_rec_id )
	END FOR

	DESTROY lds_cred_comms
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-49
	//$<comment> 02.23.2006 By: Cao YongWang
	//$<reason> Performance tuning.
	//$<modification> Move the SQL statements to previous script and integrate it with other
	//$<modification> SQL statements into Appeon Queue labels to improve runtime performance. 
	//$<modification> Refer to PT-45 for information.
	/*
	tab_view.tabpage_detail_1.dw_comm_review.GetChild( "committee_id", dwchild )
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve( Integer( data ) )		
	*/
	//---------------------------- APPEON END ----------------------------
	
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2006-10-20 By: Rodger Wu (Inova)
//$<reason> Fix a defect.

/*
IF This.GetColumnName() = "parent_facility_id" THEN  //update child data records
	c = tab_view.tabpage_detail_2.dw_staff_cat.rowcount()
	for i = 1 to c
		tab_view.tabpage_detail_2.dw_staff_cat.setitem(i,"facility_id",li_facility_id)
	next
	c = tab_view.tabpage_detail_2.dw_departments.rowcount()
	for i = 1 to c
		tab_view.tabpage_detail_2.dw_departments.setitem(i,"facility_id",li_facility_id)
	next
		c = tab_view.tabpage_detail_2.dw_leave.rowcount()
	for i = 1 to c
		tab_view.tabpage_detail_2.dw_leave.setitem(i,"facility_id",li_facility_id)
	next
END IF	
*/

IF This.GetColumnName() = "parent_facility_id" THEN  //update child data records
	c = tab_view.tabpage_detail_2.dw_staff_cat.rowcount()
	for i = 1 to c
		IF tab_view.tabpage_detail_2.dw_staff_cat.getitemstatus( i, 0, Primary! ) = new! THEN continue;
		tab_view.tabpage_detail_2.dw_staff_cat.setitem(i,"facility_id",li_facility_id)
	next
	
	c = tab_view.tabpage_detail_2.dw_departments.rowcount()
	for i = 1 to c
		IF tab_view.tabpage_detail_2.dw_departments.getitemstatus( i, 0, Primary! ) = new! THEN continue;
		tab_view.tabpage_detail_2.dw_departments.setitem(i,"facility_id",li_facility_id)
	next
	
	c = tab_view.tabpage_detail_2.dw_leave.rowcount()
	for i = 1 to c
		IF tab_view.tabpage_detail_2.dw_leave.getitemstatus( i, 0, Primary! ) = new! THEN continue;
		tab_view.tabpage_detail_2.dw_leave.setitem(i,"facility_id",li_facility_id)
	next
END IF	

//---------------------------- APPEON END ----------------------------

//\***************************************************
//verifiying facility
IF This.GetColumnName() = "verifying_facility" AND +&
	( This.GetItemStatus( row, 0, Primary! ) = DataModified!  OR +&
	This.GetItemStatus( row, 0, Primary! ) = NotModified! ) THEN
	li_ans = MessageBox("Change Verifying Facility", "Are you sure you want to change the verifying facility?", Question!, YesNo!, 1 )
	IF li_ans = 2 THEN
		//Modify 08/06/2007 by: Andy Reason:BugJ080109
		//Return 1
		setitem(row,string(dwo.name),getitemnumber(row,string(dwo.name)))
		Return 2
		//end of modify
	END IF	
	li_ver_facility = Integer( data )

	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 12.07.2005 By: Luke
	//$<reason> The string function can not work in SQL Server database.

//	UPDATE verif_info  
//	SET facility_id = :li_ver_facility, doc_id = string(rec_id) + '-' + string(prac_id) + '-' + string(:li_ver_facility) + '-' + string(seq_no)
//	WHERE ( verif_info.prac_id = :il_prac_id ) AND  
//         ( verif_info.facility_id = :ii_verifying_facility_id ) AND
//			( verif_info.screen_id <> 1 ) AND
//         ( verif_info.active_status = 1 );
	UPDATE verif_info  
	SET facility_id = :li_ver_facility, doc_id = convert(varchar,rec_id) + '-' + convert(varchar,prac_id) + '-' + convert(varchar,:li_ver_facility) + '-' + convert(varchar,seq_no)
	WHERE ( verif_info.prac_id = :il_prac_id ) AND  
         ( verif_info.facility_id = :ii_verifying_facility_id ) AND
			( verif_info.screen_id <> 1 ) AND
         ( verif_info.active_status = 1 );

	//---------------------------- APPEON END ----------------------------

			
	IF SQLCA.SQLCODE = -1 THEN
		MessageBox("Database Error", SQLCA.SQLERRTEXT )
	END IF
	ii_verifying_facility_id = li_ver_facility
	w_prac_data_1.ib_verif_info_retrieved = False
	MessageBox("Save Change", "Click on the SAVE button to make changes Permanent." )	
END IF	
	

//user
IF This.GetColumnName() = "priority_user" THEN
		Integer li_cnt
		Long ll_prac_id
		li_ver_facility = This.GetItemNumber( row, "verifying_facility" )
		ll_prac_id =  This.GetItemNumber( row, "prac_id" )
		SELECT Count( prac_id )  
	   INTO :li_cnt  
      FROM verif_info  
      WHERE ( verif_info.prac_id = :ll_prac_id ) AND  
            ( verif_info.facility_id = :li_ver_facility )   ;
		IF SQLCA.SQLCODE = -1 THEN
			MessageBox( "Database Error", SQLCA.SQLERRTEXT )
			Return
		END IF			
		IF li_cnt > 0 THEN
			li_ans = MessageBox( "Change User", "You are changing the user to which the Action Items will be assigned.  Do you want existing Action Item records to reflect this change? ", Question!, YesNo!, 1 )
			IF li_ans = 1 THEN
				UPDATE verif_info  
		   	SET priority_user = :data  
			   WHERE ( verif_info.facility_id = :li_ver_facility ) AND  
   	     		   ( verif_info.prac_id = :ll_prac_id )   ;
				IF SQLCA.SQLCODE = -1 THEN
					MessageBox( "Database Error", SQLCA.SQLERRTEXT )
					Return
				END IF
				This.Update( )
			END IF
		END IF
END IF

//provisional checkbox
IF This.GetColumnName() = "prov_status" THEN
	//messagebox("itemchanged","")
		if this.getitemnumber(row,"prov_status") = 0 then
		this.setitem(row,"init_prov_period_from",this.getitemdatetime(row,"apptmnt_start_date"))
		this.setitem(row,"init_prov_period_to",this.getitemdatetime(row,"apptmnt_end_date"))
	end if
end if

end event

event retrieveend;call super::retrieveend;IF rowcount > 0 THEN
	tab_view.tabpage_browse.dw_browse.SelectRow( 0, False )
	tab_view.tabpage_browse.dw_browse.SelectRow(1, True)
	st_recs.Text = "Record 1 of " + String( rowcount )
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-50
	//$<comment> 02.22.2006 By: Cao YongWang
	//$<reason> Performance tuning. 
	//$<modification> Comment out the following script since it is already executed in of_retrieve_detail function.
	/*
	DataWindowChild dwchild
	tab_view.tabpage_detail_1.dw_comm_review.GetChild( "committee_id", dwchild )
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve( This.GetItemNumber( 1, "parent_facility_id" ) )
	*/
	//---------------------------- APPEON END ----------------------------
	//Added for Work flow. 2/11/2006 henry
	//ii_ori_status = this.Getitemnumber( this.getrow(), 'active_status') //.1.24.2008 By Jervis  move to pfc_preupdate event

ELSE
	st_recs.Text = "Record 0 of 0"
END IF


dw_apptmnt_status.BringToTop = True
tab_view.tabpage_detail_1.dw_comm_review.BringToTop = True
tab_view.tabpage_detail_2.dw_departments.BringToTop = True
tab_view.tabpage_detail_2.dw_staff_cat.BringToTop = True


end event

event rowfocuschanged;call super::rowfocuschanged;Integer ll_org_id
Integer li_nr
DataWindowChild dwchild

IF currentrow < 1 THEN
	Return -1
END IF
//messagebox("rfc","detail")
IF NOT ib_retrieved_allready THEN
	of_retrieve_children()
END IF

ib_retrieved_allready = False

st_recs.Text = "Record " + String( currentrow ) + " of " + String( This.RowCount() )

IF currentrow > 0 THEN
	//of_get_record_verif( currentrow )
	tab_view.tabpage_browse.dw_browse.SelectRow( 0, False )
	tab_view.tabpage_browse.dw_browse.SelectRow( currentrow, True )
	tab_view.tabpage_browse.dw_browse.SetRow( currentrow )
	tab_view.tabpage_browse.dw_browse.ScrollToRow( currentrow )
	
	tab_view.tabpage_detail_2.dw_cvo.SetRow( currentrow )
	tab_view.tabpage_detail_2.dw_cvo.ScrollToRow( currentrow )

//
END IF
end event

event pfc_addrow;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 05/14/2008 By: Ken.Guo
//$<reason> Sometime. UI on tabpage1, but focus stay in tabpage2
If tab_view.Selectedtab = 1 Then
	tab_view.SelectTab(2)
End If
//---------------------------- APPEON END ----------------------------

Post of_new_record( il_prac_id )

This.SetFocus( )

Return 0


end event

event pfc_postupdate;call super::pfc_postupdate;Integer li_facility_id
Integer li_found
Integer li_rec_no
Long    ll_appt_stat_id	//Evan 02.20.2009

// MSKINNER 17 DEC 2005 -- BEGIN
IF THIS.ROWCOUNT( ) < 1 THEN RETURN Failure
// MSKINNER 17 DEC 2005 -- END
li_facility_id = dw_apptmnt_status.GetItemNumber( dw_apptmnt_status.GetRow(), "parent_facility_id" )
ll_appt_stat_id = dw_apptmnt_status.GetItemNumber(dw_apptmnt_status.GetRow(), "rec_id") //Evan 02.20.2009

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-42
//$<modify> 04.11.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Set ib_postupdate to true to make sure the RowFocusChanged event of dw_orgs_facilities will 
//$<modification> not be triggered. Refer to PT-41/43 for more information.
/*
dw_orgs_facilities.Retrieve( il_prac_id )
*/
ib_postupdate = true

gnv_appeondb.of_startqueue( )

//due to comment of commit in w_prac_1.pfc_endtran
commit;
dw_orgs_facilities.Retrieve( il_prac_id )
update pd_app_audit set facility_id = :li_facility_id
	where appt_stat_id = :ll_appt_stat_id and facility_id <> :li_facility_id; //Evan 02.20.2009 --- Updates facility of App.Audit if parent facility was changed
gnv_appeondb.of_commitqueue( )
//---------------------------- APPEON END ----------------------------


li_found = dw_orgs_facilities.Find("parent_facility_id = " + String( li_facility_id ), 1, 1000 )
IF li_found > 0 THEN
	li_rec_no = li_found
ELSEIF dw_orgs_facilities.RowCount() > 0 THEN
	li_rec_no = 1
END IF


IF li_rec_no > 0 THEN
	dw_orgs_facilities.ScrollToRow( li_rec_no )
	dw_orgs_facilities.SetRow( li_rec_no )
	dw_orgs_facilities.SelectRow( 0, False )
	dw_orgs_facilities.SelectRow( li_rec_no, True )
END IF

dw_apptmnt_status.SetFocus()

ii_selected_facility_id = This.GetItemNumber( This.GetRow(), "parent_facility_id" )
//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 08.29.2007 By: Evan
//$<Reason> After update,The dw_orgs_facilities's record doesn't match the dw_apptmnt_status's record on Web
of_retrieve_detail()
tab_view.tabpage_browse.dw_browse.SelectRow(0, false)
tab_view.tabpage_browse.dw_browse.SelectRow(1, true)
//---------------------------- APPEON END ----------------------------	

if gi_parent_facility = 0 then //maha 042904 for when a practitioner is added to a new facility via the ssn search already having an appointment with another facility.
	gi_parent_facility = ii_selected_facility_id
end if
if ii_parent_facility_id = 0 then //maha 042904 for when a practitioner is added to a new facility via the ssn search already having an appointment with another facility.
	ii_parent_facility_id = ii_selected_facility_id
end if

if ib_new_prac then //maha 102102
	ii_parent_facility_id = This.GetItemNumber( This.GetRow(), "parent_facility_id" )
	
	//Added for Work flow. Trigger off the related work flow for new practitioner added in intelliCred. 10/30/2006 Henry
	If iw_win.ib_new_prac = true Then
		of_create_action_item_by_workflow('NEW')
	End If
	//End added for Work flow. 10/30/2006 Henry
	
	//Start Code Change ---- 03.30.2006 #359 maha
	iw_win.ib_new_prac = false
	iw_win.of_setup_title()
	iw_win.of_new_prac( "postupdate(appt stat)@" + string(ii_parent_facility_id ))
	//End Code Change---03.30.2006
end if

//Start Code Change ----09.30.2008 #V85 maha	 - ccvs customization; add missing verifs
if ib_new_record then
	if of_get_app_setting("set_55","I") =  1 then
		//debugbreak()
		iw_win.inv_printletters.of_find_missing_verifs(  This.GetItemNumber( This.GetRow(), "prac_id" ), This.GetItemNumber( This.GetRow(), "verifying_facility" ), -1,  This.GetItemstring( This.GetRow(), "apptmnt_type" ))
	end if
//End Code Change---09.30.2008	
end if

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-43
//$<modify> 04.11.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Reset the value of ib_postupdate to FALSE again so that the RowFocusChanged event of dw_orgs_facilities
//$<modification> can still be executed outside of pfc_postupdate event. Refer to PT-41/42 for more information.
ib_postupdate = false
//---------------------------- APPEON END ----------------------------

//Added for Work flow. Trigger off the related work flow for practitioner status changed. 10/30/2006 Henry
integer li_cur_status
//li_cur_status = this.GetItemNumber(This.GetRow() , 'active_status', Primary! , true)
li_cur_status = this.GetItemNumber(This.GetRow() , 'active_status')
If not ib_new_prac and not ib_workflow and  ii_ori_status <> li_cur_status Then
	of_create_action_item_by_workflow('STATUS')
End If
//End added for Work flow. 10/30/2006 Henry

Return 0

end event

event pfc_preupdate;call super::pfc_preupdate;Integer i
Integer l
Integer c
Integer li_first_loop = 0
Integer li_facility_id
Integer li_new_facility
Integer li_row_cnt
Integer li_nr
Integer li_found
Integer li_rec_no
integer li_status = 0
integer li_facil_check
integer ret
Long ll_rec_id
Long ll_action_type
Long ll_action_dept
Long ll_action_status
String ls_action_notes
String ls_app_type
Date ldt_action_date


Integer li_num_comms
n_ds lds_cred_comms
DataWindowChild dwchild

li_row_cnt = This.RowCount()

//maha multiple active trap 020404
//debugbreak()
if ib_multiapp = false then //Start Code Change ----12.12.2007 #V8 maha trap for this for multi app function
	if dw_orgs_facilities.rowcount() > 0 then //trap for new records
		li_facil_check = dw_orgs_facilities.getitemnumber(dw_orgs_facilities.getrow(),"parent_facility_id")
		FOR i = 1 TO li_row_cnt //maha multiple trap 020404
			if This.GetItemNumber( i, "parent_facility_id" ) > li_facil_check and This.GetItemNumber( i, "active_status" ) > 0 then li_status++
		next
		if li_status > 1 then
			messagebox("Status Notice","For this Practitioner and Parent you have multiple non-history Statuses.  This may cause reporting issues.~rThere should be only one record with the status of Active, Pending, Inactive, Or Purge.")
		end if
	end if
end if

//Start Code Change ----02.20.2008 #V8 maha - trap for no primary dept (dept security only)
if tab_view.tabpage_detail_2.dw_departments .rowcount() = 1 and tab_view.tabpage_detail_2.dw_departments.GetItemStatus( 1, 0, Primary!) = New! THEN
	if gi_dept_security = 1 then
		messagebox("Department Level Security Check","You must have a Department record set as the Primary Department. ")
		return -1
	end if
end if
//End Code Change---02.20.2008

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-51
//$<add> 03.22.2006 By: LeiWei
//$<reason> Performance tuning.
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

string ls_appt_types[]
integer	li_facilitys[] , li_audit_facilitys[] , li_audit_rows
FOR i = 1 TO li_row_cnt
	ls_appt_types[upperbound(ls_appt_types) + 1] = This.GetItemString( i, "apptmnt_type" )
	//li_facilitys[upperbound(li_facilitys) + 1] = This.GetItemNumber( i, "parent_facility_id" )
//Start Code Change ---- 03.20.2007 #V7 maha  changed because modified logic faulty address link records for all facilities were retrieved at once
//	li_facilitys[upperbound(li_facilitys) + 1] =This.GetItemNumber( i, "parent_facility_id", Primary!, False)
//	li_facilitys[upperbound(li_facilitys) + 1] =This.GetItemNumber( i, "parent_facility_id", Primary!, True)
//End Code Change---03.20.2007
	li_audit_facilitys[upperbound(li_audit_facilitys) + 1] = This.GetItemNumber( i, "application_audit_facility")
Next
gnv_appeondb.of_startqueue()
//cache data for copying required data
ids_last_app_audit_seq_no = create datastore
ids_last_app_audit_seq_no.dataobject = 'd_last_app_audit_seq_no_all_pt'
ids_last_app_audit_seq_no.settransobject(sqlca)

//<modify> 07/24/2007 by: Andy
//ids_last_app_audit_seq_no.retrieve(il_prac_id,li_audit_facilitys)
ids_last_app_audit_seq_no.retrieve(il_prac_id, ii_selected_facility_id,gs_user_id)
//end of modify

idw_rqrd_data = create datastore
idw_rqrd_data.dataobject = 'd_app_audit_rqrd_data_all_pt'
idw_rqrd_data.settransobject(sqlca)
idw_rqrd_data.retrieve(li_audit_facilitys,ls_appt_types)

idw_audit = create datastore
idw_audit.dataobject = 'd_pd_app_audit_rqrd_data'
idw_audit.settransobject(sqlca)

//Cache data for adding address links
ids_address_link = CREATE datastore
ids_address_link.DataObject = "d_address_link"
ids_address_link.settransobject( SQLCA)
//ids_address_link.retrieve( il_prac_id )

ids_all_addresses = CREATE datastore
ids_all_addresses.DataObject = "d_address_link_all_addresses"
ids_all_addresses.settransobject( SQLCA)
ids_all_addresses.retrieve( il_prac_id )

ids_address_linked = create datastore
ids_address_linked.DataObject = "d_pd_address_link_all_pt"
ids_address_linked.settransobject( SQLCA)
//ids_address_linked.retrieve(il_prac_id,li_facilitys)//maha removed 03.20.07 retrieval made later in code

//Cache data for adding hospital links
ids_hosp_link = CREATE datastore
ids_hosp_link.DataObject = "d_hf_link"
ids_hosp_link.SetTransObject( SQLCA )
ids_hosp_link.Retrieve( il_prac_id )

ids_all_hosp = CREATE datastore
ids_all_hosp.DataObject = "d_hosp_affil_prac"
ids_all_hosp.SetTransObject( SQLCA )
ids_all_hosp.Retrieve( il_prac_id )

//
ids_spec_link = CREATE datastore
ids_spec_link.DataObject = "d_sf_link"
ids_spec_link.SetTransObject( SQLCA )
ids_spec_link.Retrieve( il_prac_id )

ids_all_spec = CREATE datastore
ids_all_spec.DataObject = "d_spec_of_prac"
ids_all_spec.SetTransObject( SQLCA )
ids_all_spec.Retrieve( il_prac_id )

SELECT ids.record_id  
INTO :ii_audit_rec  
FROM ids  ;

gnv_appeondb.of_commitqueue()

li_audit_rows = idw_rqrd_data.RowCount()
//ii_audit_rec = gnv_app.of_get_id("RECORD_ID", li_audit_rows) - 1

gnv_appeondb.of_startqueue()

UPDATE ids  
SET record_id = :ii_audit_rec  + :li_audit_rows;

//---------------------------- APPEON END ----------------------------
			
FOR i = 1 TO li_row_cnt
	//*** new record *****
IF This.GetItemStatus( i, 0, Primary! ) = NewModified! THEN
		 li_new_facility = This.GetItemNumber( i, "parent_facility_id" )
		IF ib_new_prac AND i = 1 THEN
			ii_verifying_facility_id = This.GetItemNumber( i, "verifying_facility" )
			ii_parent_facility_id = li_new_facility
			gi_parent_facility = ii_parent_facility_id
		END IF
		ib_new_record = True
		This.SetItem( i, "seq_no", i )
		dw_apptmnt_status.SetItem( i, "rec_id", il_rec_id )
		dw_apptmnt_status.SetItem( i, "prac_id", il_prac_id )		

		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 10.13.2006 By: Jack (Inova)
		//$<reason> 
		/*
		IF of_copy_required_data( This.GetItemNumber( i, "application_audit_facility" ), This.GetItemString( i, "apptmnt_type" ) ) = -1 THEN
			Return -1
		END IF
		*/
		IF This.GetItemNumber( i, "application_audit_facility" ) <> - 1 then
			IF of_copy_required_data( This.GetItemNumber( i, "application_audit_facility" ), This.GetItemString( i, "apptmnt_type" ) ) = -1 THEN
				Return -1
			END IF
		END IF
		//---------------------------- APPEON END ----------------------------
		
		li_facilitys[1] = li_new_facility  //Start Code Change ---- 03.20.2007 #V7 maha corrected logic problem
		c = ids_address_linked.retrieve(il_prac_id,li_facilitys)

		IF of_add_address_link( li_new_facility) = -1 THEN
			Return -1
		END IF
		//\/maha 011601
		IF of_add_hosp_links( li_new_facility ) = -1 THEN
			Return -1
		END IF
		//\maha
		//\/maha 082101
		IF of_add_spec_links( li_new_facility ) = -1 THEN
			Return -1
		END IF
		//\maha
		
//		IF This.GetItemString( i, "affiliation_status" ) = "I" THEN  //function call added to of_multi_add
//			IF of_add_net_dev_ai( i ) = -1 THEN
//				Return -1
//			END IF
		
//		END IF
		//RETURN 1
	END IF			
		
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-52
	//$<modify> 04.22.2006 By: Cao YongWang
	//$<reason> Fix a defect in the original unmodified PowerBuilder application.
	//$<modification> Add one condition to make sure the application work correctly - the application will  
	//$<modification> not delete records from pd_app_audit either when adding a new entry without being 
	//$<modification> updated to the database.
	/*
	IF This.GetItemStatus( i, "application_audit_facility", Primary! ) = DataModified! THEN
	*/		
	IF This.GetItemStatus( i, "application_audit_facility", Primary! ) = DataModified! AND &
		This.GetItemStatus( i, 0, Primary! ) <> NewModified! THEN
	//---------------------------- APPEON END ----------------------------
			DELETE FROM pd_app_audit_attempts  
			WHERE pd_app_audit_attempts.record_id = :il_rec_id   ;
			IF SQLCA.SQLCODE = -1 THEN
				MessageBox("", SQLCA.SQLERRTEXT )
				Return -1
			END IF

			DELETE FROM pd_app_audit  
			WHERE pd_app_audit.appt_stat_id = :il_rec_id   ;
			IF SQLCA.SQLCODE = -1 THEN
				MessageBox("", SQLCA.SQLERRTEXT )
				Return -1
			END IF

			ib_changed_app_audit = True

			IF of_copy_required_data( This.GetItemNumber( i, "application_audit_facility" ), This.GetItemString( i, "apptmnt_type" ) ) = -1 THEN
				Return -1
			END IF
	END IF
	//********** change of parent ****************
	if This.GetItemStatus( i,0, Primary! ) = DataModified! THEN //maha 112204  only if not a new record
		IF This.GetItemStatus( i, "parent_facility_id", Primary! ) = DataModified! THEN	//maha v 5.0 0704
			//messagebox("preupdate","change of parent")
			ib_changed_parent_facility = True
			li_facility_id = This.GetItemNumber( i, "parent_facility_id", Primary!, True ) //org value
			li_new_facility = This.GetItemNumber( i, "parent_facility_id", Primary!, False) //org value
			ll_rec_id = This.GetItemNumber( i, "rec_id")

			DELETE FROM pd_address_link  
				WHERE pd_address_link.facility_id = :li_facility_id AND
					  pd_address_link.prac_id	= :il_prac_id;
			IF SQLCA.SQLCODE = -1 THEN
				MessageBox("", SQLCA.SQLERRTEXT )
			END IF					 
			DELETE FROM pd_hosp_facility_link  
				WHERE pd_hosp_facility_link.facility_id = :li_facility_id AND
						pd_hosp_facility_link.prac_id	= :il_prac_id;		
			IF SQLCA.SQLCODE = -1 THEN
				MessageBox("", SQLCA.SQLERRTEXT )
			END IF		
			DELETE FROM pd_spec_facility_link  
				WHERE pd_spec_facility_link.facility_id = :li_facility_id AND
						pd_spec_facility_link.prac_id	= :il_prac_id;		
			IF SQLCA.SQLCODE = -1 THEN
				MessageBox("", SQLCA.SQLERRTEXT )
			END IF		

			li_facilitys[1] = li_new_facility  //Start Code Change ---- 03.20.2007 #V7 maha corrected logic problem
			ids_address_linked.retrieve(il_prac_id,li_facilitys)

			IF of_add_address_link( li_new_facility ) = -1 THEN
				Return -1
			END IF
			//maha 011601
			IF of_add_hosp_links( li_new_facility ) = -1 THEN
				Return -1
			END IF
	
			//maha 082101
			IF of_add_spec_links( li_new_facility) = -1 THEN
				Return -1
			END IF
			//\/maha added 062303 updating verifications and facility-specific data tables; direct_parent_facility_link 022305
			
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 2005-12-07 By: Luke
			//$<reason> The SQL database has not supported function string.
			
//			UPDATE verif_info  
//			SET facility_id = :li_new_facility, 
//			direct_parent_facility_link = :li_new_facility, 
//			doc_id = string(rec_id) + '-' + string(prac_id) + '-' + string(:li_new_facility) + '-' + string(seq_no)
//			WHERE ( verif_info.prac_id = :il_prac_id ) AND  
//				( verif_info.facility_id = :ii_parent_facility_id ) AND
//				( verif_info.screen_id = 1 ) AND
//				( verif_info.active_status = 1 );
			
			UPDATE verif_info  
			SET facility_id = :li_new_facility, 
			direct_parent_facility_link = :li_new_facility, 
			doc_id = convert(varchar,rec_id) + '-' + convert(varchar,prac_id) + '-' + convert(varchar,:li_new_facility) + '-' + convert(varchar,seq_no)
			WHERE ( verif_info.prac_id = :il_prac_id ) AND  
				( verif_info.facility_id = :ii_parent_facility_id ) AND
				( verif_info.screen_id = 1 ) AND
				( verif_info.active_status = 1 );
			//---------------------------- APPEON END ----------------------------

		
				
				
			IF SQLCA.SQLCODE = -1 THEN
				MessageBox("Database Error", SQLCA.SQLERRTEXT )
			END IF
			update pd_questions set facility_id = :li_new_facility where prac_id = :il_prac_id and facility_id = :li_facility_id;
			update pd_committee set facility_id = :li_new_facility where prac_id = :il_prac_id and facility_id = :li_facility_id;
			update pd_contingency_fs set facility_id = :li_new_facility where prac_id = :il_prac_id and facility_id = :li_facility_id;
			update pd_other_data set facility_id = :li_new_facility where prac_id = :il_prac_id and facility_id = :li_facility_id;
			update pd_notes set facility_id = :li_new_facility where prac_id = :il_prac_id and facility_id = :li_facility_id;
			update pd_rank set facility_id = :li_new_facility where prac_id = :il_prac_id and facility_id = :li_facility_id;
			update pd_admin_role set facility_id = :li_new_facility where prac_id = :il_prac_id and facility_id = :li_facility_id;
			update pd_group_providers set facility_id = :li_new_facility where prac_id = :il_prac_id and facility_id = :li_facility_id;
			update net_dev_action_items set facility_id = :li_new_facility where prac_id = :il_prac_id and facility_id = :li_facility_id;
			update net_dev_ids set facility_id = :li_new_facility where prac_id = :il_prac_id and facility_id = :li_facility_id;
			//maha 021505

			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 2005-12-07 By: Luke
			//$<reason> The SQL database has not supported function string.

			//update verif_info set facility_id = :li_new_facility, doc_id = string(rec_id) + "-" + string(prac_id) + "-" + string(:li_new_facility) + "-" + string(seq_no) where prac_id = :il_prac_id and facility_id = :li_facility_id and screen_id = 1 and active_status = 1;
			update verif_info 
			set facility_id = :li_new_facility, 
			doc_id = convert(varchar,rec_id) + "-" + convert(varchar,prac_id) + "-" + convert(varchar,:li_new_facility) 
			 + "-" + convert(varchar,seq_no) 
			 where prac_id = :il_prac_id and facility_id = :li_facility_id and screen_id = 1 and active_status = 1;
			//--------------------------- APPEON END ---------------------------
			
			
			//affil_stat related data
			//comment 08/06/2007 by: Andy Reason:BugG080601
			//While d_pd_affil_leave is updated,A database error has occurred. Database error code:  -3 Database error message:Row changed between retrieve and update.
			//No chang es made to database.
			/*
			update pd_affil_dept set facility_id = :li_facility_id where rec_id = :ll_rec_id;
			update pd_affil_staff_cat set facility_id = :li_facility_id where rec_id = :ll_rec_id;
			update pd_affil_staff_leave set facility_id = :li_facility_id where rec_id = :ll_rec_id;
			*/
			//\mah	
		
		END IF
	end if
END FOR

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-53
//$<add> 03.22.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
 
ids_address_link.update( )
ids_hosp_link.update( )
ids_spec_link.update( )
idw_audit.update( )
gnv_appeondb.of_commitqueue( )
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-01-25 By: Rodger Wu (attest quest)
//$<reason> Generate attest questions from question template.
FOR i = 1 TO li_row_cnt
	IF This.GetItemStatus( i, 0, Primary! ) = NewModified! THEN
		ls_app_type = This.GetItemString( i, "apptmnt_type" )
		IF ls_app_type = 'I' THEN
			ret = inv_data_entry.of_generate_attest_questions( "initial", This.GetItemNumber( i, "parent_facility_id" ), il_prac_id, il_rec_id )
			if ret = 1 then ib_retrieve_detail2 = True
		END IF
	END IF
NEXT
//---------------------------- APPEON END ----------------------------

ret = of_validate(tab_view.tabpage_detail_2.dw_cvo) //maha 071205 validates data in custom fields on detail 2
if ret = -1 then return -1

//01.24.2008 by Jervis Move to here from retrieveend event
if this.getrow() > 0 then //Add by Evan for trap on 03.18.2008
	ii_ori_status = this.Getitemnumber( this.getrow(), 'active_status',primary!,true)
end if

inv_data_entry.of_field_audit( This )

RETURN 1
end event

event pfc_deleterow;Integer li_ans
Integer li_rc
Integer i
string ls_mes
integer li_delete = 0
long		ll_CurRow

//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 05/20/2008 By: Ken.Guo
//$<Reason> Fixed BugK051401. For NEW! or NEWModified! Row.
//$<Reason> Need not delete children data and need not add sys_audit record.
Long ll_data_cnt ,ll_data
If This.GetItemStatus(This.GetRow(),0,Primary!) = New!  or This.GetItemStatus(This.GetRow(),0,Primary!) = NewModified! Then
	This.DeleteRow(This.GetRow())		
	Return 0
End If
//---------------------------- APPEON END ----------------------------

IF dw_orgs_facilities.RowCount() <= 1 THEN
	if this.rowcount() = 1 then  //Start Code Change ---- 04.05.2006 #400 maha  
		MessageBox("Delete", "You need to have at least one record entered into the Appointment Status Screen." )
		Return 0
	end if
END IF

if this.rowcount() = 1 then
	ls_mes = "Are you sure you want to delete this Appointment record and all facility specific related data?"
	li_delete = 1
else
	ls_mes = "Are you sure you wish to delete this Appointment record?"
end if
li_ans = MessageBox( "Delete",ls_mes, Question!, YesNo!, 1 )

IF li_ans = 1 THEN
	//delete child appt records
	li_rc = tab_view.tabpage_detail_2.dw_departments.RowCount()
	FOR i = 1 TO li_rc
		tab_view.tabpage_detail_2.dw_departments.DeleteRow( i )
	END FOR

	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-54
	//$<add> 03.22.2006 By: LeiWei
	//$<reason> Performance tuning
	//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
	gnv_appeondb.of_startqueue( )
	//---------------------------- APPEON END ----------------------------

	tab_view.tabpage_detail_2.dw_departments.Update(  )
	
   li_rc = tab_view.tabpage_detail_1.dw_comm_review.RowCount()
	FOR i = 1 TO li_rc
		tab_view.tabpage_detail_1.dw_comm_review.DeleteRow( i )
	END FOR	
	tab_view.tabpage_detail_1.dw_comm_review.Update()
	
	li_rc = tab_view.tabpage_detail_2.dw_staff_cat.RowCount()
	FOR i = 1 TO li_rc
		tab_view.tabpage_detail_2.dw_staff_cat.DeleteRow( i )
	END FOR	
	tab_view.tabpage_detail_2.dw_staff_cat.Update( )	
	
	li_rc = tab_view.tabpage_detail_2.dw_leave.RowCount()
	FOR i = 1 TO li_rc
		tab_view.tabpage_detail_2.dw_leave.DeleteRow( i )
	END FOR	
	tab_view.tabpage_detail_2.dw_leave.Update( )
	if li_delete = 1 then //maha 112204  delete the following data only if the last appt record for that facility.
			//\/maha added 110600
		delete from pd_address_link
		where facility_id = :ii_selected_facility_id and prac_id = :il_prac_id;
		
		delete from pd_questions
		where facility_id = :ii_selected_facility_id and prac_id = :il_prac_id;
		
		delete from pd_group_providers
		where facility_id = :ii_selected_facility_id and prac_id = :il_prac_id;
			//\maha
		delete from pd_hosp_facility_link //011501
		where facility_id = :ii_selected_facility_id and prac_id = :il_prac_id;
		
		delete from pd_spec_facility_link //082101
		where facility_id = :ii_selected_facility_id and prac_id = :il_prac_id;
		//\/maha 112204
		delete from pd_questions where prac_id = :il_prac_id and facility_id = :ii_selected_facility_id;
		delete from pd_committee where prac_id = :il_prac_id and facility_id = :ii_selected_facility_id;
		delete from pd_contingency_fs where prac_id = :il_prac_id and facility_id = :ii_selected_facility_id;
		delete from pd_other_data where prac_id = :il_prac_id and facility_id = :ii_selected_facility_id;
		delete from pd_notes where prac_id = :il_prac_id and facility_id = :ii_selected_facility_id;
		delete from pd_rank where prac_id = :il_prac_id and facility_id = :ii_selected_facility_id;
		delete from pd_admin_role where prac_id = :il_prac_id and facility_id = :ii_selected_facility_id;
		delete from pd_group_providers where prac_id = :il_prac_id and facility_id = :ii_selected_facility_id;
		delete from net_dev_action_items where prac_id = :il_prac_id and facility_id = :ii_selected_facility_id;
		delete from net_dev_ids where prac_id = :il_prac_id and facility_id = :ii_selected_facility_id;
		delete from verif_info where prac_id = :il_prac_id and facility_id = :ii_selected_facility_id and screen_id = 1;
		//\maha
	end if
	
	Commit Using SQLCA;

	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-55
	//$<add> 03.22.2006 By: LeiWei
	//$<reason> Performance tuning
	//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
	gnv_appeondb.of_commitqueue( )
	//---------------------------- APPEON END ----------------------------

	inv_data_entry.of_field_audit_delete_last( this, This.GetRow())//maha 083104
	This.DeleteRow( This.GetRow() )

	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-56
	//$<add> 03.22.2006 By: LeiWei
	//$<reason> Performance tuning
	//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
	/*
	This.Update()
	dw_orgs_facilities.Retrieve( il_prac_id )
	*/
	gnv_appeondb.of_startqueue()
	
	This.Update()
	
	gnv_appeondb.of_commitqueue()	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<Modify> 2007-08-08 By: Scofield
	//$<Reason> Refresh the datawindow
	
	ll_CurRow = dw_orgs_facilities.GetRow()
	dw_orgs_facilities.Retrieve(il_prac_id)
	
	if ll_CurRow = 1 and dw_orgs_facilities.RowCount() > 0 then
		dw_orgs_facilities.Trigger Event RowFocusChanged(1)
	end if
	//---------------------------- APPEON END ----------------------------

	//---------------------------- APPEON END ----------------------------
	
END IF

Return -1
end event

event constructor;call super::constructor;IF gs_cust_type = "C" THEN
	dw_apptmnt_status.Modify( "cust_type_t.text = 'Client'" )
ELSEIF gs_cust_type = "I" THEN
	dw_apptmnt_status.Modify( "cust_type_t.text = 'Payor/Hospital'" )
END IF
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-57
//$<modify> 02.10.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Move the following script into the Constructor event of pfc_cst_apptmnt_status.
//$<modification> The script can be integrated with other SQL statement into Appeon Queue labels
//$<modification> to reduce client-server interactions. Refer to PT-40 for more information.
/*
DataWindowChild dwchild

This.GetChild( "parent_facility_id", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve(gs_user_id)

This.GetChild( "verifying_facility", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve(gs_user_id)
*/
//---------------------------- APPEON END ----------------------------


end event

event rbuttondown;call super::rbuttondown;integer col
integer ret
datetime dtn
string colname
STRING DT

setnull(dtn)

col = this.getclickedcolumn()
colname = this.getcolumnname() 

if this.Describe( colname + ".ColType") = "datetime" THEN
	//messagebox("dt","dt")
	ret = messagebox("Set Null?","Would you like to set this Date to null?",question!,yesno!,2 )
	if ret = 1 then
		this.setitem(row,col,dtn)
	end if
END IF


end event

event clicked;call super::clicked;//if this.getclickedcolumn() = 46 then
//	messagebox("clicked",this.getcolumnname() )
//	accepttext()
//end if
end event

event pfc_preinsertrow;call super::pfc_preinsertrow;//\/maha 021804 to trap save errors when entering multiple records

//Integer li_retval
//
//if isvalid(w_prac_data_1) then
//	li_retval = w_prac_data_1.Event pfc_Save()
//	debugbreak()
//	IF li_retval < 0 THEN
//		This.PostEvent( "pfc_cst_after_error" )
//		Return 1
//	END IF	
//end if
//	
return continue_action

//\maha
end event

event updateend;call super::updateend;//--------------------------- APPEON BEGIN ---------------------------
//$<Delete> 08.29.2007 By: Evan
//$<Reason> The following code will bring to many bugs. New modification code in pfc_postupdate event.
/*
//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-08-15 By: Scofield
//$<Reason> After update,The dw_orgs_facilities's record doesn't match the dw_apptmnt_status's record on Web
long	ll_CurRow

ll_CurRow = dw_orgs_facilities.GetRow()
if ll_CurRow > 0 and ll_CurRow <= dw_orgs_facilities.RowCount()then
	dw_orgs_facilities.Trigger Event RowFocusChanged(ll_CurRow)
end if
//---------------------------- APPEON END ----------------------------
*/
//---------------------------- APPEON END ----------------------------

end event

type gb_6 from groupbox within tabpage_detail_1
integer x = 27
integer y = 1208
integer width = 2615
integer height = 320
integer taborder = 31
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 67108864
string text = "Committee Review"
end type

type dw_comm_review from u_dw within tabpage_detail_1
integer x = 69
integer y = 1256
integer width = 2537
integer height = 264
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pd_comm_review"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event pfc_preupdate;call super::pfc_preupdate;Integer li_rc
Integer i
Integer li_facility_id
Long ll_seq_no
integer li_stat

li_rc = This.RowCount( )

li_facility_id = dw_apptmnt_status.GetItemNumber( dw_apptmnt_status.GetRow(), "parent_facility_id" )

//FOR i = 1 TO li_rc
//	IF This.GetItemStatus( i, 0, Primary!) = NewModified! THEN
//		This.SetItem( i, "seq_no", i )
//		This.SetItem( i, "facility_id", li_facility_id )		
//		This.SetItem( i, "prac_id", il_prac_id )
//		//This.SetItem( i, "rec_id", il_rec_id )
//	END IF
//END FOR

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-58
//$<modify> 04.11.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Move the following script to the subsequent location to reduce calls to server.
//$<modification> Refer to PT-59 for more information.
//ll_seq_no = of_get_next_seq_no( "comm review")
ll_seq_no = 0
//---------------------------- APPEON END ----------------------------

FOR i = 1 TO li_rc
	IF This.GetItemStatus( i, 0, Primary!) = NewModified! THEN
		//Start Code Change ---- 03.30.2006 #399 maha
		 //corrected maha 04.04.06
		if isnull(This.SetItem( i, "seq_no", ll_seq_no )) then  //corrected maha 04.04.06
			messagebox("Committee data", "You must have a committee selected for each record.")
			return -1
		else
			li_stat = tab_view.tabpage_detail_1.dw_apptmnt_status.GetItemNumber( tab_view.tabpage_detail_1.dw_apptmnt_status.GetRow(), "active_status" )//maha 060104
			//--------------------------- APPEON BEGIN ---------------------------
			//$<ID> PT-59
			//$<modify> 04.11.2006 By: LeiWei
			//$<reason> Performance tuning
			//$<modification> Add the script removed from PT-58. ll_seq_no is executed only when the status of dw_comm_review is
			//$<modification> NewModified! after modification. 
	
			IF ll_seq_no = 0 THEN ll_seq_no = of_get_next_seq_no( "comm review")
			//---------------------------- APPEON END ----------------------------
			ll_seq_no ++
			This.SetItem( i, "seq_no", ll_seq_no )
			This.SetItem( i, "facility_id", li_facility_id )		
			This.SetItem( i, "rec_id", il_rec_id )
			This.SetItem( i, "prac_id", il_prac_id )
			This.SetItem( i, "active_status", li_stat ) 
		end if
		//End Code Change---03.10.2006
	END IF
END FOR

Return 0
end event

event rbuttondown;call super::rbuttondown;integer col
integer ret
datetime dtn
string colname
STRING DT

setnull(dtn)

col = this.getclickedcolumn()
colname = this.getcolumnname() 

if this.Describe( colname + ".ColType") = "datetime" THEN
	//messagebox("dt","dt")
	ret = messagebox("Set Null?","Would you like to set this Date to null?",question!,yesno!,2 )
	if ret = 1 then
		this.setitem(row,col,dtn)
	end if
END IF
end event

event pfc_addrow;call super::pfc_addrow;This.setitem(this.rowcount(),"active_status",dw_apptmnt_status.getitemnumber(dw_apptmnt_status.getrow(),"active_status"))
This.setitem(this.rowcount(),"rec_id",dw_apptmnt_status.getitemnumber(dw_apptmnt_status.getrow(),"rec_id"))
This.setitem(this.rowcount(),"facility_id",dw_apptmnt_status.getitemnumber(dw_apptmnt_status.getrow(),"parent_facility_id"))
//dw_apptmnt_status

return 1
end event

event pfc_validation;call super::pfc_validation;Integer	li_Cycle1,li_Cycle2,li_committeeid_1,li_committeeid_2,li_RowCount

li_RowCount = This.RowCount()

for li_Cycle1 = 1 to li_RowCount - 1
	li_committeeid_1 = This.GetItemNumber(li_Cycle1,'committee_id')
	for li_Cycle2 = li_Cycle1 + 1 to li_RowCount
		li_committeeid_2 = This.GetItemNumber(li_Cycle2,'committee_id')
		if li_committeeid_1 = li_committeeid_2 then
			//MessageBox('Error','In the Committee Review DataWindow, values in the Committee column cannot duplicate. Please modify!',stopsign!)
 			MessageBox('Error','In the Committee Review DataWindow, values in the Committee column cannot be duplicate. Please modify!',stopsign!)
			This.Post SetRow(li_Cycle2)
			This.Post SetColumn('committee_id')
			return FAILURE
		end if
	next
next

return SUCCESS

end event

type gb_1 from groupbox within tabpage_detail_1
integer x = 37
integer y = 1052
integer width = 2601
integer height = 140
integer taborder = 21
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 67108864
string text = "Current FPPE/OPPE Dates"
end type

type tabpage_detail_2 from userobject within tab_view
event create ( )
event destroy ( )
integer x = 18
integer y = 16
integer width = 2693
integer height = 1556
long backcolor = 79741120
string text = "Detail 2"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "DataWindow2!"
long picturemaskcolor = 553648127
dw_leave dw_leave
dw_cvo dw_cvo
gb_5 gb_5
gb_2 gb_2
gb_3 gb_3
dw_staff_cat dw_staff_cat
gb_4 gb_4
dw_departments dw_departments
end type

on tabpage_detail_2.create
this.dw_leave=create dw_leave
this.dw_cvo=create dw_cvo
this.gb_5=create gb_5
this.gb_2=create gb_2
this.gb_3=create gb_3
this.dw_staff_cat=create dw_staff_cat
this.gb_4=create gb_4
this.dw_departments=create dw_departments
this.Control[]={this.dw_leave,&
this.dw_cvo,&
this.gb_5,&
this.gb_2,&
this.gb_3,&
this.dw_staff_cat,&
this.gb_4,&
this.dw_departments}
end on

on tabpage_detail_2.destroy
destroy(this.dw_leave)
destroy(this.dw_cvo)
destroy(this.gb_5)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.dw_staff_cat)
destroy(this.gb_4)
destroy(this.dw_departments)
end on

type dw_leave from u_dw within tabpage_detail_2
integer x = 64
integer y = 844
integer width = 2597
integer height = 256
integer taborder = 11
string dataobject = "d_pd_affil_leave"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event pfc_preupdate;call super::pfc_preupdate;Integer li_rc
Integer i
Integer li_facility_id
Long ll_seq_no

li_rc = This.RowCount( )

li_facility_id = tab_view.tabpage_detail_1.dw_apptmnt_status.GetItemNumber( tab_view.tabpage_detail_1.dw_apptmnt_status.GetRow(), "parent_facility_id" )

if isnull(li_facility_id) or li_facility_id < 1 then //maha 121802 idiot trap
	messagebox("Save Error", "The detail 1 data must be entered before the Leave data can be saved")
	return -1
end if

ll_seq_no = of_get_next_seq_no( "leave")

FOR i = 1 TO li_rc
	IF This.GetItemStatus( i, 0, Primary!) = NewModified! THEN
		ll_seq_no ++
		This.SetItem( i, "seq_no", ll_seq_no )
		This.SetItem( i, "facility_id", li_facility_id )		
		This.SetItem( i, "rec_id", il_rec_id )
		This.SetItem( i, "prac_id", il_prac_id )		
	END IF
END FOR

inv_data_entry.of_field_audit( This ) //maha 071102

Return 0
end event

event rbuttondown;call super::rbuttondown;integer col
integer ret
datetime dtn
string colname
STRING DT

setnull(dtn)

col = this.getclickedcolumn()
colname = this.getcolumnname() 

if this.Describe( colname + ".ColType") = "datetime" THEN
	//messagebox("dt","dt")
	ret = messagebox("Set Null?","Would you like to set this Date to null?",question!,yesno!,2 )
	if ret = 1 then
		this.setitem(row,col,dtn)
	end if
END IF
end event

event pfc_deleterow;//maha 083104
inv_data_entry.of_field_audit_delete_last( this, This.GetRow())
this.DeleteRow (0)

return 1
end event

type dw_cvo from u_dw within tabpage_detail_2
integer x = 55
integer y = 1200
integer width = 2587
integer height = 336
integer taborder = 11
string dataobject = "d_pd_affil_status_cvo_data"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;IF This.GetColumnName() = "priority_user" THEN
		Integer li_ans
		Integer li_cnt
		Integer li_ver_facility
		Long ll_prac_id
		li_ver_facility = This.GetItemNumber( row, "verifying_facility" )
		ll_prac_id =  This.GetItemNumber( row, "prac_id" )
		SELECT Count( prac_id )  
	   INTO :li_cnt  
      FROM verif_info  
      WHERE ( verif_info.prac_id = :ll_prac_id ) AND  
            ( verif_info.facility_id = :li_ver_facility )   ;
		IF SQLCA.SQLCODE = -1 THEN
			MessageBox( "Database Error", SQLCA.SQLERRTEXT )
			Return
		END IF			
		IF li_cnt > 0 THEN
			li_ans = MessageBox( "Change User", "You are changing the user that Action Items will be assigned to.  Do you want passed Action Item records to reflect this change? ", Question!, YesNo!, 1 )
			IF li_ans = 1 THEN
				UPDATE verif_info  
		   	SET priority_user = :data  
			   WHERE ( verif_info.facility_id = :li_ver_facility ) AND  
   	     		   ( verif_info.prac_id = :ll_prac_id )   ;
				IF SQLCA.SQLCODE = -1 THEN
					MessageBox( "Database Error", SQLCA.SQLERRTEXT )
					Return
				END IF
				This.Update( )
			END IF
		END IF
END IF
end event

event rbuttondown;call super::rbuttondown;integer col
integer ret
datetime dtn
string colname
STRING DT

setnull(dtn)

col = this.getclickedcolumn()
colname = this.getcolumnname() 

if this.Describe( colname + ".ColType") = "datetime" THEN
	//messagebox("dt","dt")
	ret = messagebox("Set Null?","Would you like to set this Date to null?",question!,yesno!,2 )
	if ret = 1 then
		this.setitem(row,col,dtn)
	end if
END IF
end event

event pfc_postupdate;call super::pfc_postupdate;inv_data_entry.of_field_audit( This )

return 1
end event

event constructor;call super::constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-60
//$<modify> 02.10.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Move the following script into the Constructor event of pfc_cst_apptmnt_status.
//$<modification> The script can be integrated with other SQL statement into Appeon Queue labels
//$<modification> to reduce client-server interactions. Refer to PT-40 for more information.
/*
of_custom_labels(this)
*/
//---------------------------- APPEON END ----------------------------

end event

event pfc_preupdate;call super::pfc_preupdate;integer ret

ret = of_validate(this)

return ret
end event

type gb_5 from groupbox within tabpage_detail_2
integer x = 27
integer y = 776
integer width = 2638
integer height = 356
integer taborder = 21
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 67108864
string text = " Leave of Absence"
end type

type gb_2 from groupbox within tabpage_detail_2
integer x = 27
integer y = 356
integer width = 2638
integer height = 404
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 67108864
string text = "Departments"
end type

type gb_3 from groupbox within tabpage_detail_2
integer x = 27
integer y = 12
integer width = 2633
integer height = 316
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 67108864
string text = "Staff Category"
end type

type dw_staff_cat from u_dw within tabpage_detail_2
integer x = 55
integer y = 68
integer width = 2565
integer height = 240
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pd_affil_staff_cat"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event pfc_preupdate;call super::pfc_preupdate;Integer li_rc
Integer i
Integer li_facility_id
Long ll_seq_no
integer c = 0
integer li_stat

li_rc = This.RowCount( )

li_facility_id = tab_view.tabpage_detail_1.dw_apptmnt_status.GetItemNumber( tab_view.tabpage_detail_1.dw_apptmnt_status.GetRow(), "parent_facility_id" )

if isnull(li_facility_id) or li_facility_id < 1 then //maha 121802 idiot trap
	messagebox("Save Error", "The detail 1 data must be entered before the Staff Category data can be saved")
	return -1
end if

ll_seq_no = of_get_next_seq_no( "staff cat")

FOR i = 1 TO li_rc
	IF This.GetItemStatus( i, 0, Primary!) = NewModified! THEN
		//debugbreak()
		li_stat = tab_view.tabpage_detail_1.dw_apptmnt_status.GetItemNumber( tab_view.tabpage_detail_1.dw_apptmnt_status.GetRow(), "active_status" )//maha 060104
		ll_seq_no ++
		This.SetItem( i, "seq_no", ll_seq_no )
		This.SetItem( i, "facility_id", li_facility_id )		
		This.SetItem( i, "rec_id", il_rec_id )
		This.SetItem( i, "prac_id", il_prac_id )
		This.SetItem( i, "active_status", li_stat ) //maha 060104
	END IF
END FOR

//code for checking multiple active requested
FOR i = 1 TO li_rc
	IF This.GetItemnumber( i, "requested") = 1 THEN 
		c++	
	END IF
	if c > 1 then
		messagebox("Multiple Active records","There is more than 1 staff category record with the status of Active.  This could potentially cause duplications in some reports.")
	end if
END FOR

inv_data_entry.of_field_audit( This ) //maha 071102

Return 0
end event

event rbuttondown;call super::rbuttondown;integer col
integer ret
datetime dtn
string colname
STRING DT

setnull(dtn)

col = this.getclickedcolumn()
colname = this.getcolumnname() 

if this.Describe( colname + ".ColType") = "datetime" THEN
	//messagebox("dt","dt")
	ret = messagebox("Set Null?","Would you like to set this Date to null?",question!,yesno!,2 )
	if ret = 1 then
		this.setitem(row,col,dtn)
	end if
END IF
end event

event itemchanged;call super::itemchanged;IF This.GetColumnName() = "to_date" THEN //maha 020304
	if isnull(this.getitemdatetime(this.getrow(),"to_date")) then //if the to_date is completed set to inactive else set to active
		this.setitem(this.getrow(),"requested",1)
	else
		this.setitem(this.getrow(),"requested",0)
	end if
END IF

IF This.GetColumnName() = "from_date" THEN //maha 020304
	if not(isnull(this.getitemdatetime(this.getrow(),"from_date"))) then // if the from_date is completed then set to active if the to_date is null 
		if isnull(this.getitemdatetime(this.getrow(),"to_date")) then
			this.setitem(this.getrow(),"requested",1)
		end if
	end if
END IF

IF This.GetColumnName() = "staff_category" THEN //maha 051704
	if isnull(this.getitemnumber(this.getrow(),"requested")) then
		this.setitem(this.getrow(),"requested",1)
	end if
end if
end event

event pfc_deleterow;//maha 083104
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 01/11/2008 By: Ken.Guo
//$<reason> Fix issue, If deleted row' status is new, needn't audit.
//inv_data_entry.of_field_audit_delete_last( this, This.GetRow())
If This.GetItemStatus(This.GetRow(),0,primary!) = NotModified!	Or This.GetItemStatus(This.GetRow(),0,primary!) = DataModified! Then
	inv_data_entry.of_field_audit_delete_last( this, This.GetRow())
End If
//---------------------------- APPEON END ----------------------------

this.DeleteRow (0)

return 1
end event

type gb_4 from groupbox within tabpage_detail_2
integer x = 27
integer y = 1156
integer width = 2638
integer height = 388
integer taborder = 21
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 128
long backcolor = 67108864
string text = "Additional Data"
end type

type dw_departments from u_dw within tabpage_detail_2
integer x = 55
integer y = 420
integer width = 2574
integer height = 320
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pd_affil_departments"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event pfc_preupdate;call super::pfc_preupdate;Integer li_rc
Integer i
Integer li_facility_id
Long ll_seq_no
integer li_prim_cnt = 0
integer li_stat

li_rc = This.RowCount( )

li_facility_id = tab_view.tabpage_detail_1.dw_apptmnt_status.GetItemNumber( tab_view.tabpage_detail_1.dw_apptmnt_status.GetRow(), "parent_facility_id" )
if isnull(li_facility_id) or li_facility_id < 1 then //maha 121802 idiot trap
	messagebox("Save Error", "The detail 1 data must be entered before the department data can be saved")
	return -1
end if

ll_seq_no = of_get_next_seq_no( "department")

FOR i = 1 TO li_rc
	IF This.GetItemStatus( i, 0, Primary!) = NewModified! THEN
		//debugbreak()
		li_stat = tab_view.tabpage_detail_1.dw_apptmnt_status.GetItemNumber( tab_view.tabpage_detail_1.dw_apptmnt_status.GetRow(), "active_status" )//maha 060104
		ll_seq_no ++
		This.SetItem( i, "seq_no", ll_seq_no )
		This.SetItem( i, "facility_id", li_facility_id )		
		This.SetItem( i, "rec_id", il_rec_id )
		This.SetItem( i, "prac_id", il_prac_id )
		This.SetItem( i, "active_status", li_stat ) //maha 060104
	END IF
END FOR

//\/maha 080602 for LIJ
FOR i = 1 TO li_rc
	if this.getitemnumber(i,"primary_dept") = 1 then
		li_prim_cnt++
	end if
next
if li_prim_cnt > 1 then
	messagebox("Data Entry Error","You can have only one Department record set as the Primary Department.  Changes not saved")
	return -1
end if
//\maha
//Start Code Change ----02.20.2008 #V8 maha - trap for no primary dept (dept security only)
if this.rowcount() = 1 and This.GetItemStatus( 1, 0, Primary!) = New! THEN li_prim_cnt = 0
if gi_dept_security = 1 then
	if li_prim_cnt = 0 then
		messagebox("Department Level Security Check","You must have a Department record set as the Primary Department.  Changes not saved.")
		return -1
	end if
end if
//End Code Change---02.20.2008
inv_data_entry.of_field_audit( This ) //maha 071102




Return 0
end event

event rbuttondown;call super::rbuttondown;integer col
integer ret
datetime dtn
string colname
STRING DT

setnull(dtn)

col = this.getclickedcolumn()
colname = this.getcolumnname() 

if this.Describe( colname + ".ColType") = "datetime" THEN
	//messagebox("dt","dt")
	ret = messagebox("Set Null?","Would you like to set this Date to null?",question!,yesno!,2 )
	if ret = 1 then
		this.setitem(row,col,dtn)
	end if
END IF
end event

event itemchanged;call super::itemchanged;IF This.GetColumnName() = "department" THEN
	if isnull(This.getItemnumber( row, "primary_dept")) then//\/maha 080102
		if this.rowcount() = 1 then
			This.SetItem( row, "primary_dept",1)
		else
			This.SetItem( row, "primary_dept",0)
		end if
	end if	
END IF

IF This.GetColumnName() = "record_status" THEN //this is not active_status
	this.accepttext()
	if This.getItemnumber( row, "record_status")  = 1 then //\/maha 121602
		This.SetItem( row, "primary_dept",1)
	else
		This.SetItem( row, "primary_dept",0)
	end if
END IF
end event

event pfc_deleterow;//maha 083104
inv_data_entry.of_field_audit_delete_last( this, This.GetRow())
this.DeleteRow (0)

return 1
end event

type tabpage_quest from userobject within tab_view
integer x = 18
integer y = 16
integer width = 2693
integer height = 1556
boolean border = true
long backcolor = 79741120
string text = "Attest Quest"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "quest.bmp"
long picturemaskcolor = 536870912
dw_quest dw_quest
end type

on tabpage_quest.create
this.dw_quest=create dw_quest
this.Control[]={this.dw_quest}
end on

on tabpage_quest.destroy
destroy(this.dw_quest)
end on

type dw_quest from u_dw within tabpage_quest
integer x = 14
integer y = 12
integer width = 2638
integer height = 1524
integer taborder = 11
string dataobject = "d_attest_quest_appt_stat"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;this.setrowfocusindicator( hand!)
end event

event pfc_addrow;//overwrite
integer i
Integer li_retval
integer cnt
long ll_appt_id
long ll_recid

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-01-26 By: Rodger Wu (attest quest)
//$<reason> Check the status.
if Upper( This.Describe("DataWindow.ReadOnly") ) = "YES" then
	messagebox("Attestation Questions","You don't have the right of full access to add questions.")
	return -1
end if
//---------------------------- APPEON END ----------------------------

this.setredraw(false)

//Start Code Change ---- 01.25.2006 #218 maha
if tab_view.tabpage_detail_1.dw_apptmnt_status.rowcount() < 1 then
	messagebox("Attestation Questions","You cannot add questions until the appointment record has been saved.")
	return -1
end if
//End Code Change---0125.2006 

ll_appt_id = tab_view.tabpage_detail_1.dw_apptmnt_status.getitemnumber(tab_view.tabpage_detail_1.dw_apptmnt_status.getrow(),"rec_id")

inv_data_entry.of_add_questions("APPT",this,ii_selected_facility_id,gl_prac_id,ll_appt_id)	//Start Code Change ----02.25.2009 #V92 maha bug correction changed to ii_selected_facility from ii_parent_facility
//--------------------------- APPEON BEGIN ---------------------------
//$<Added> 09/18/2007 By: Ken.Guo
//$<reason> For performance
If This.Deletedcount() + This.Modifiedcount() = 0 Then
	This.setredraw(true)
	Return 0
End If
//---------------------------- APPEON END ----------------------------


//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-63
//$<modify> 02.22.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Define a variable to 1)get the first ID; 2)Update the final ID
//$<modification> value into database. Refer to of_get_id for more information.
ll_recid = gnv_app.of_get_id("RECORD_ID",this.rowcount()) - 1
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 09/18/2007 By: Ken.Guo
//$<reason> For Performance
/*
for i = 1 to this.rowcount()
	if isnull(this.getitemnumber(i,"rec_id")) then
		//--------------------------- APPEON BEGIN ---------------------------
		//$<ID> PT-64
		//$<modify> 02.22.2006 By: Cao YongWang
		//$<reason> Performance tuning.
		//$<modification> Comment out the following script to reduce client-server interaction.
		//$<modification> refer to PT-63 and of_get_id for more information.
		/* 
		ll_recid = gnv_app.of_get_id("RECORD_ID")
		*/
		ll_recid ++
		//---------------------------- APPEON END ----------------------------
		this.setitem(i ,"rec_id",ll_recid)
	end if
next
*/
long ll_rowcount
long ll_recvalue[]
ll_rowcount = This.Rowcount()
For i = 1 To ll_rowcount
	ll_recid ++
	ll_recvalue[i] = ll_recid
Next
This.object.rec_id[1,ll_rowcount] = ll_recvalue[]
//---------------------------- APPEON END ----------------------------


//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-61
//$<add> 02.22.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_startqueue()
//---------------------------- APPEON END ----------------------------

this.update()

this.retrieve(ll_appt_id,gs_user_id)
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-62
//$<add> 02.22.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_commitqueue()
//---------------------------- APPEON END ----------------------------
this.setredraw(true)

return 1
end event

event clicked;call super::clicked;integer r
r = this.getclickedrow( )
this.setrow(r)
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007.09.03 By: Frank.Gui
//$<reason> View supporting documentation uploaded from WebView
IF dwo.name="p_enabled" THEN
	of_view_supporting_doc(this.getitemnumber(row,"rec_id"))
END IF
//---------------------------- APPEON END ----------------------------


end event

event pfc_deleterow;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-01-26 By: Rodger Wu (attest quest)
//$<reason> Override ancestor script and check the status.
if Upper( This.Describe("DataWindow.ReadOnly") ) = "YES" then
	messagebox("Attestation Questions","You don't have the right of full access to delete questions.")
	return -1
end if

CALL SUPER::pfc_deleterow;
return AncestorReturnValue;
//---------------------------- APPEON END ----------------------------
end event

