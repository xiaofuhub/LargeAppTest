$PBExportHeader$pfc_cst_u_apptmnt_status.sru
forward
global type pfc_cst_u_apptmnt_status from userobject
end type
type st_recs from statictext within pfc_cst_u_apptmnt_status
end type
type dw_orgs_facilities from u_dw within pfc_cst_u_apptmnt_status
end type
type tab_view from tab within pfc_cst_u_apptmnt_status
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
type dw_apptmnt_status from u_dw within tabpage_detail_1
end type
type gb_comm from groupbox within tabpage_detail_1
end type
type dw_comm_review from u_dw within tabpage_detail_1
end type
type tabpage_detail_1 from userobject within tab_view
dw_apptmnt_status dw_apptmnt_status
gb_comm gb_comm
dw_comm_review dw_comm_review
end type
type tabpage_detail_2 from userobject within tab_view
end type
type dw_leave from u_dw within tabpage_detail_2
end type
type gb_lea from groupbox within tabpage_detail_2
end type
type gb_dep from groupbox within tabpage_detail_2
end type
type gb_cat from groupbox within tabpage_detail_2
end type
type dw_staff_cat from u_dw within tabpage_detail_2
end type
type dw_departments from u_dw within tabpage_detail_2
end type
type tabpage_detail_2 from userobject within tab_view
dw_leave dw_leave
gb_lea gb_lea
gb_dep gb_dep
gb_cat gb_cat
dw_staff_cat dw_staff_cat
dw_departments dw_departments
end type
type tabpage_quest from userobject within tab_view
end type
type dw_quest from u_dw within tabpage_quest
end type
type tabpage_quest from userobject within tab_view
dw_quest dw_quest
end type
type tabpage_ofe from userobject within tab_view
end type
type uo_ofe from uo_oppe_fppe_evals_appt within tabpage_ofe
end type
type tabpage_ofe from userobject within tab_view
uo_ofe uo_ofe
end type
type tab_view from tab within pfc_cst_u_apptmnt_status
tabpage_browse tabpage_browse
tabpage_detail_1 tabpage_detail_1
tabpage_detail_2 tabpage_detail_2
tabpage_quest tabpage_quest
tabpage_ofe tabpage_ofe
end type
type p_1 from picture within pfc_cst_u_apptmnt_status
end type
type dw_facility_add from u_dw within pfc_cst_u_apptmnt_status
end type
end forward

global type pfc_cst_u_apptmnt_status from userobject
integer width = 4402
integer height = 2012
boolean border = true
long backcolor = 33551856
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event pfc_cst_print_net_dev_ltr ( )
event pfc_cst_print_net_dev_report ( )
event pfc_cst_multi_app ( )
event ue_hide_midcycle ( )
st_recs st_recs
dw_orgs_facilities dw_orgs_facilities
tab_view tab_view
p_1 p_1
dw_facility_add dw_facility_add
end type
global pfc_cst_u_apptmnt_status pfc_cst_u_apptmnt_status

type variables
          Protected Long il_prac_id
Long il_rec_id
pfc_cst_nv_data_entry_functions inv_data_entry

Protected Integer ii_verifying_facility_id
Protected Integer ii_parent_facility_id
Protected Integer ii_selected_facility_id
Protected Integer ii_app_id


Protected Boolean ib_new_prac = False
Protected Boolean ib_first_retrieve = True
Protected Boolean ib_new_record = False
Protected Boolean ib_retrieved_allready = False


Protected Boolean ib_changed_app_audit = False
Protected Boolean ib_changed_parent_facility = False

Protected w_prac_data_1 iw_win
boolean ib_multiapp = false //maha 12.12.07
boolean ib_set_dw2 , ib_retrieve_detail2,ib_select
boolean 	ib_postupdate = false
boolean ib_workflow = false  //Added for work flow.12.19.2006 Jervis
boolean ib_mid_from_comm = false //maha 10.24.2014 - midcycle
boolean ib_comm_review = false  //maha 10.31.2014 - committee review
boolean ib_Priority_User =false //(Appeon)Stephen 07.23.2015 - Audit Trail data for Priority_User is incorrect
Boolean ib_in_good_standing_changed = False //whether in_good_standing has been changed
Boolean ib_recred = False  //maha 07.26.2017
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
long	il_wf_new_practitioner
Long il_rec_id_multi_app
string	is_dept_chairperson
integer  ii_ori_status
n_cst_datetime inv_datetime //Alfee 11.06.2008
n_cst_dataflow inv_dataflow[6] //dataflow: alfee 01.07.2010
//1:appt status 2:CVO 3:dept 4:leave 5:quest 6:staff cat

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
public function integer of_retrieve_detail_old ()
public function integer of_retrieve_detail ()
public function integer of_bg_color (long al_rgb)
public function integer of_filter_lookup_facility (long al_facility, datawindowchild ad_child)
public function integer of_lookup_facility_filter (datawindowchild adwchild, long al_facil)
public function integer of_button_visible (integer ai_index)
public function integer of_returning ()
public function integer of_appl_action_create (long ai_facility_id, long ai_app_id, string as_action_type, long ai_rec_id, long al_loc, string as_apt_type)
public function integer of_multi_app_new ()
public function integer of_retrieve_detail_rec (long al_recid)
public function integer of_post_resize ()
public function integer of_security_setting ()
public function integer of_button_check ()
public subroutine of_zoom ()
end prototypes

event pfc_cst_print_net_dev_ltr;//tab_view.tabpage_netdev.uo_net_dev.Event pfc_cst_print_net_dev_ltr()
end event

event pfc_cst_print_net_dev_report;//tab_view.tabpage_netdev.uo_net_dev.Event pfc_cst_print_net_dev_report()
end event

event pfc_cst_multi_app();of_multi_app_new() //maha 07.14.2014 - new function
end event

event ue_hide_midcycle();//Start Code Change ----01.14.2016 #V15 maha
string v

if of_get_app_setting("set_14","I") = 8765 then
	v =  tab_view.tabpage_detail_1.dw_apptmnt_status.Modify("apptmnt_type.Values = 'Initial~tI/Reapp~tR/Temp~tT/NetDev~tN/'" )
	tab_view.tabpage_detail_1.dw_apptmnt_status.Modify( "active_status.values= 'Active~t1/Pending~t4/History~t0/Inactive~t3/Purge~t2/'")
end if
//'Active~tA/Part Time~tP/Terminated~tT'")
//object.apptmnt_type.ddlb.finditem("Midcycle",1)
//messagebox("",v)
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
tab_view.tabpage_quest.dw_quest.reset( )//long.zhang 03.25.2014 Bug 3988 

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
//	dw_orgs_facilities.SelectRow( 0, False )  //Start Code Change ----01.20.2016 #V15 maha - removed
//	dw_orgs_facilities.SelectRow( li_rec_no, True )
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
long ll_insrow
string ls_filter  //maha 09.20.2010

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

//Start Code Change ----09.20.2010 #V10 maha - add B type to filter
choose case as_app_type
	case "I","R"
		ls_filter = "facility_id="+string(ai_facility_id) + " and (upper(app_type)='" + upper(as_app_type) + "' or upper(app_type)= 'B')"
	case else
		//anything else should filter to no rows (this is the original filter)
		ls_filter = "facility_id="+string(ai_facility_id) + " and upper(app_type)='" + upper(as_app_type) + "'" 
end choose
li_row_cnt = idw_rqrd_data.setfilter(ls_filter)
//End Code Change ----09.20.2010

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
	idw_audit.SetItem( ll_insrow, "pd_app_audit_description", idw_rqrd_data.GetItemString( i, "description" )	) 	//Start Code Change ----09.01.2016 #V152 maha - setting checklist description
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
//	tab_view.tabpage_detail_1.dw_comm_review.InsertRow( 0 ) //Start Code Change ----12.16.2009 #V10 maha - removed
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
Long ll_found, ll_current_row //alfee 11.13.2014

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
	//---------Begin Added by (Appeon)Alfee 11.13.2014 for BugA111301 -------------------
	//<$Reason>The 1st row is not the current row for midcycle, and also the current row may be changed via scrolling the mouse key
	ll_current_row = 1
	IF ib_mid_from_comm THEN  //if midcycle find the record - il_rec_id set in open event of return from committee
		li_rc = tab_view.tabpage_detail_1.dw_apptmnt_status.rowcount ()
		ll_found = tab_view.tabpage_detail_1.dw_apptmnt_status.find( "rec_id = " + string(il_rec_id), 1, li_rc)
		IF ll_found > 0 THEN ll_current_row = ll_found
	END IF
	//---------End Added ----------------------------------------------------------------------------

	//IF IsNull(tab_view.tabpage_detail_1.dw_apptmnt_status.GetItemDateTime( 1, "apptmnt_start_date" ) ) THEN
	IF IsNull(tab_view.tabpage_detail_1.dw_apptmnt_status.GetItemDateTime( ll_current_row, "apptmnt_start_date" ) ) THEN //alfee 11.13.2014
		MessageBox( "Missing Data", "Appointment Start Date field must be filled in.")
		tab_view.tabpage_detail_1.dw_apptmnt_status.SetColumn( "apptmnt_start_date" )
		tab_view.tabpage_detail_1.dw_apptmnt_status.SetFocus()
		Return -1
	END IF

	//IF IsNull(tab_view.tabpage_detail_1.dw_apptmnt_status.GetItemDateTime( 1, "apptmnt_end_date" ) ) THEN
	IF IsNull(tab_view.tabpage_detail_1.dw_apptmnt_status.GetItemDateTime( ll_current_row, "apptmnt_end_date" ) ) THEN //alfee 11.13.2014
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
	elseif isvalid(w_prac_data_2) Then  //Start Code Change ----12.04.2012 #V12 maha
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
		//---------Begin Modified by (Appeon)Harry 01.24.2014 for V142 ISG-CLX--------
		//m_pfe_cst_data_entry.m_file.m_dataentrycomplete.toolbaritemname = "Custom027!"
		gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_file.m_dataentrycomplete,'toolbaritemname', "Custom027!")
		//---------End Modfiied ------------------------------------------------------
		//m_pfe_cst_data_entry.m_file.m_dataentrycomplete.enabled = True
		Return 0 
	ELSE
		//m_pfe_cst_data_entry.m_file.m_dataentrycomplete.toolbaritemname = "smiley.jpg"
		//---------Begin Modified by (Appeon)Harry 01.24.2014 for V142 ISG-CLX--------
		//m_pfe_cst_data_entry.m_file.m_dataentrycomplete.toolbaritemname = "Custom026!"
		gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_file.m_dataentrycomplete,'toolbaritemname', "Custom026!")
		//---------End Modfiied ------------------------------------------------------
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
	tab_view.tabpage_detail_1.dw_apptmnt_status.SetFilter( "active_status in (1,4,6 )" )  //Start Code Change ----10.30.2014 #V14.2 maha - added midcycle
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
//tab_view.tabpage_detail_2.dw_cvo.Reset()//Start Code Change ----11.03.2011 #V12 maha- removed
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
integer li_user //maha 04.03.2012
String ls_apptmnt_type
string ls_assn_user //maha 04.03.2012
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
	
	//Start Code Change ----04.03.2012 #V12 maha - modifed to use facility setting
		select reap_user into :li_user from facility where facility_id = :li_parent_facility_id;
		if isnull(li_user) then li_user = 0
		choose case li_user
			case 2 //current use	
				ls_assn_user = gs_user_id
			case else //default
				ls_assn_user = "PUBLIC"
		end choose
		
		tab_view.tabpage_detail_1.dw_apptmnt_status.SetItem( li_nr, "priority_user", ls_assn_user )
	//End Code Change ----04.03.2012	
		
		IF Not IsNull(  lstr_multi_app.l_department )  and lstr_multi_app.l_department  > 0 THEN //add trap 12.12.07 maha
			tab_view.tabpage_detail_2.dw_departments.SetItem( 1, "department", lstr_multi_app.l_department )
			tab_view.tabpage_detail_2.dw_departments.SetItem( 1, "section", lstr_multi_app.l_section )
			li_prime = lstr_multi_app.i_primary//maha 182802
			if isnull(li_prime) then li_prime = 0//maha 182802
			tab_view.tabpage_detail_2.dw_departments.SetItem( 1, "primary_dept", li_prime )// maha 182802
			tab_view.tabpage_detail_2.dw_departments.SetItem( 1, "active_status", li_active )  //Start Code Change ----12.12.2007 #V8 maha
			//----------------------Appeon Begin------------------------
			//$<add> long.zhang 02.01.2012
			//$<Reason> Fixed Bug 2899
				if string( lstr_multi_app.dep_from_date) <> "1/1/1900 00:00:00" then 
					tab_view.tabpage_detail_2.dw_departments.SetItem( 1, "from_date", lstr_multi_app.dep_from_date )
				end if
				if string( lstr_multi_app.dep_to_date) <> "1/1/1900 00:00:00" then 
					tab_view.tabpage_detail_2.dw_departments.SetItem( 1, "to_date", lstr_multi_app.dep_to_date )	
				end if
				tab_view.tabpage_detail_2.dw_departments.setitem( 1, "rank",lstr_multi_app.l_division )
			//----------------------Appeon end--------------------------
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
					tab_view.tabpage_detail_2.dw_staff_cat.setitem( 1,"requested",lstr_multi_app.l_request)	//added by long.zhang 02.01.2012
		END IF
			//End Code Change---12.12.2007
		iw_win.Event pfc_Save()
	end if
	//creation of network dev items moved here from preupdate of the appoint stat dw  //maha 011003
	of_add_net_dev_ai(ls_apptmnt_type,ii_app_id, li_parent_facility_id) //Start Code Change ----12.10.2007 #V8 maha added facility argument
END FOR

ib_multiapp = false  //Start Code Change ----12.12.2007 #V8 maha

Return 0

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
	ids_spec_link.SetItem( li_nr, "practicing",581)      // 582 ) //Start Code Change ----12.12.2013 #V14 maha - changed to match add from demographics screen.
next

//---------------------------- APPEON END ----------------------------
RETURN 1


end function

public function integer of_setup_dw ();datawindowchild dwchild
Long nulllong
//setup dw_orgs_facility dw
dw_orgs_facilities.of_SetUpdateAble( False )
//dw_orgs_facilities.of_SetTransObject(SQLCA)

setnull(nulllong)
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

//tab_view.tabpage_detail_1.dw_apptmnt_status.ShareData( tab_view.tabpage_detail_2.dw_cvo )   //Start Code Change ----11.03.2011 #V12 maha - removed

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
ll_find = dwchild.find(/*"facility_id"*/'template_id = -1',1,dwchild.rowcount()) //modify by stephen 07.28.2011 column name error
if ll_find < 1 then
	dwchild.InsertRow( 1 )
//Start Code Change ----10.28.2010 #V10 maha - change to templates	
//	dwchild.setitem(1,"facility_id", -1)
//	dwchild.setitem(1,"facility_facility_name", 'N/A')
	dwchild.setitem(1,"template_id", -1)
	dwchild.setitem(1,"template_name", 'N/A')
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

 //Start Code Change ----03.23.2017 #V153 maha
 IF w_mdi.of_security_access( 120 ) = 1 THEN
	of_security_setting( )
end if


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

//Start Code Change ----01.28.2011 #V11 maha - add blank to standing
tab_view.tabpage_detail_1.dw_apptmnt_status.GetChild( "in_good_standing", dwchild )//maha 062303 for inova
dwchild.SetTransObject( SQLCA )
dwchild.retrieve()
dwchild.InsertRow( 1 )
dwchild.setitem(1,"lu_id", nulllong)
dwchild.setitem(1,"display_value", '')
//End Code Change ----01.28.2011 #V11 maha 


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

//Start Code Change ----12.04.2013 #V14 maha
li_row_cnt = tab_view.tabpage_detail_2.dw_leave.RowCount()

FOR i = 1 TO li_row_cnt
	IF tab_view.tabpage_detail_2.dw_leave.GetItemStatus( i, 0, Primary! ) <> New! THEN
		tab_view.tabpage_detail_2.dw_leave.SetItem( i, "active_status", ai_status )	
	END IF
END FOR
//End Code Change ----12.04.2013

//Start Code Change ----11.05.2009 #V10 maha - update attest questions as well.
li_row_cnt = tab_view.tabpage_quest.dw_quest.RowCount()

FOR i = 1 TO li_row_cnt
	tab_view.tabpage_quest.dw_quest.SetItem( i, "active_status", ai_status )	
end for
//End Code Change---11.05.2009

//Start Code Change ----06.07.2011 #V11 maha - appl action
choose case ai_status
	case 3 
 //Start Code Change ----04.09.2015 #V15 maha - Modifed to be consistant with status change from Apps tab
//			update net_dev_action_items set active_status = 0 where prac_id = :il_prac_id and facility_id = :ii_selected_facility_id;
//			update pd_appl_tracking set active_status = 0 where facility_id = :ii_selected_facility_id AND	prac_id = : il_prac_id;
	case 2
//			delete from net_dev_action_items where prac_id = :il_prac_id and facility_id = :ii_selected_facility_id;
//			delete from pd_appl_tracking where facility_id = :ii_selected_facility_id AND	prac_id = : il_prac_id;
 //End Code Change ----04.09.2015
	case 1,4
		update net_dev_action_items set active_status = 1 where prac_id = :il_prac_id and facility_id = :ii_selected_facility_id;
		//not making any inactive net dev actions acaive again.
end choose
//Start Code Change ----06.07.2011	

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
			update pd_comm_review set active_status = 3 where active_status in (1,4) and prac_id = :il_prac_id and facility_id <> :ii_selected_facility_id;
			update pd_affil_dept set active_status = 3 where active_status in (1,4) and prac_id = :il_prac_id and facility_id <> :ii_selected_facility_id;
			update pd_affil_staff_cat set active_status = 3 where active_status in (1,4) and prac_id = :il_prac_id and facility_id <> :ii_selected_facility_id;
			update pd_affil_staff_leave set active_status = 3 where active_status in (1,4) and prac_id = :il_prac_id and facility_id <> :ii_selected_facility_id;  //Start Code Change ----12.04.2013 #V14 maha
 //Start Code Change ----04.09.2015 #V15 maha keep actions active - consistant with appls tab
			//	update net_dev_action_items set active_status = 0 where prac_id = :il_prac_id and facility_id <> :ii_selected_facility_id;
			//	update pd_appl_tracking set active_status = 0 where facility_id = :ii_selected_facility_id AND	prac_id = : il_prac_id;

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
			update pd_comm_review set active_status = 1 where active_status in (3,4) and prac_id = :il_prac_id and facility_id <> :ii_selected_facility_id;
			update pd_affil_dept set active_status = 1 where active_status in (3,4) and prac_id = :il_prac_id  and facility_id <> :ii_selected_facility_id;
			update pd_affil_staff_cat set active_status = 1 where active_status in (3,4) and prac_id = :il_prac_id and facility_id <> :ii_selected_facility_id; 
			update pd_affil_staff_leave set active_status = 1 where active_status in (3,4) and prac_id = :il_prac_id and facility_id <> :ii_selected_facility_id;   //Start Code Change ----12.04.2013 #V14 maha
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
			update pd_comm_review set active_status = 4 where active_status in (3,1) and prac_id = :il_prac_id and facility_id <> :ii_selected_facility_id;
			update pd_affil_dept set active_status = 4 where active_status in (3,1) and prac_id = :il_prac_id and facility_id <> :ii_selected_facility_id;
			update pd_affil_staff_cat set active_status = 4 where active_status in (3,1) and prac_id = :il_prac_id and facility_id <> :ii_selected_facility_id;
			update pd_affil_staff_leave set active_status = 4 where active_status in (3,1) and prac_id = :il_prac_id and facility_id <> :ii_selected_facility_id;  //Start Code Change ----12.04.2013 #V14 maha
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
datawindowchild dwchild
integer ic
integer i
integer res
//thjis function no longer user (2006) see object constructor event
string fname
string lname
string err
string s
string ls_lookup  //maha 09.14.2011
string ls_lu_table   //maha 09.14.2011

lds_fields  = create datastore
lds_fields.dataobject = "d_affil_stat_painter"
lds_fields.settransobject(sqlca)
ic = lds_fields.retrieve()
messagebox("","of_custom fields")

if ic > 0 then
	for i = 1 to ic
		fname = lds_fields.getitemstring(i,"field_name")
		lname = lds_fields.getitemstring(i,"field_name_allias")
		s = fname + "_t.text = '" + lname + "'"
		err = adw_from.modify(s)
		debugbreak()
		//Start Code Change ----09.14.2011 #V12 maha - use of lookup table
		ls_lookup =  lds_fields.getitemstring(i,"lookup_field")
		ls_lu_table =  lds_fields.getitemstring(i,"lookup_code")
		
		if ls_lookup = "Y" and not isnull(ls_lu_table ) then
			err = adw_from.Modify( fname + ".dddw.name = 'd_dddw_code_lookup'")
			err = adw_from.Modify( fname + ".dddw.datacolumn = 'lookup_code'")	
			err = adw_from.Modify( fname + ".dddw.displaycolumn = 'description'")	
			err = adw_from.Modify( fname + ".dddw.VscrollBar = Yes")	
			
			adw_from.getchild( fname, dwchild)
			dwchild.settransobject(sqlca)
			gnv_data.of_set_dwchild_fromcache('code_lookup',"upper(lookup_name)='"+upper(ls_lu_table)+"'",dwchild)
			//s = fname + ".dddw.name = 'd_dddw_code_lookup'"
		end if
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

string ls_type//Added by  Nova 06.02.2010
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
			//--------Begin Modified by  Nova 06.02.2010------------------------
			//ls_val = adw_from.getitemstring(adw_from.getrow(),fname)
			ls_type=lds_fields.getitemstring(i,"field_type")
			if ls_type='C' then
				ls_val = adw_from.getitemstring(adw_from.getrow(),fname)
			elseif ls_type='D' then
				ls_val = string(adw_from.GetItemDatetime(adw_from.getrow(),fname),'mm-dd-yyyy')
			end if
			//--------End Modified --------------------------------------------
			ll_prac = adw_from.getitemnumber(adw_from.getrow(),"prac_id")
			ll_parent = adw_from.getitemnumber(adw_from.getrow(),"parent_facility_id")
			//choose case li_val
				//case 1 //unique required	
			if isnull(ls_val) or LenA(ls_val) < 1 then
				messagebox("Required data","Unique value required in the " + lname + " field.")
				destroy lds_fields
				return -1
			else
				select count(custom_1) into :err from pd_affil_stat where custom_1 = :ls_val and rec_id not in ( select rec_id from pd_affil_stat where prac_id = :ll_prac and parent_facility_id = :ll_parent);
				//messagebox("count",err)
				if err > 0 then
					select parent_facility_id,prac_id into :ll_found_parent,:ll_found_prac from pd_affil_stat where custom_1 = :ls_val and rec_id not in ( select rec_id from pd_affil_stat where prac_id = :ll_prac and parent_facility_id = :ll_parent);
					messagebox("Validation Error","Unique value required in the " + lname + " field.  Practitioner " + string(ll_found_prac) + " for facility " + string(ll_found_parent) + " has this id.")
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

gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper(lookup_name) = '" + upper('department') + "'", dwchild)

dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "lookup_code", nulllong )


tab_view.tabpage_detail_2.dw_departments.GetChild( "section", dwchild )
dwchild.SetTransObject( SQLCA )

gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper(lookup_name) = '" + upper('section') + "'", dwchild)
dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "lookup_code", nulllong )

tab_view.tabpage_detail_2.dw_departments.GetChild( "rank", dwchild )
dwchild.SetTransObject( SQLCA )

gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper(lookup_name) = '" + upper('division') + "'", dwchild)
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
//tab_view.tabpage_detail_2.dw_cvo.of_SetUpdateAble( False )
//
//tab_view.tabpage_detail_2.dw_cvo.of_SetDropDownCalendar( TRUE )   //Start Code Change ----11.03.2011 #V12 maha - removed
//tab_view.tabpage_detail_2.dw_cvo.iuo_calendar.of_Register( tab_view.tabpage_detail_2.dw_cvo.iuo_calendar.DDLB)
//
//tab_view.tabpage_detail_2.dw_cvo.of_SetTransObject(SQLCA)
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
datawindowchild dwchild


//	tab_view.tabpage_detail_2.dw_departments.SetTransObject( SQLCA )//maha082201
li_rc = tab_view.tabpage_detail_2.dw_departments.Retrieve( il_rec_id,gs_user_id  )//gs_user_id addedmaha120301
IF li_rc = 0 THEN
	tab_view.tabpage_detail_2.dw_departments.InsertRow( 0 )
END IF


//
gnv_appeondb.of_startqueue()
//Start Code Change ----07.15.2011 #V11 maha - added facility specific lookup filters
tab_view.tabpage_detail_2.dw_departments.Retrieve( il_rec_id,gs_user_id  )//gs_user_id addedmaha120301
tab_view.tabpage_detail_2.dw_departments.GetChild( "department", dwchild )
of_filter_lookup_facility( ii_selected_facility_id, dwchild) 
tab_view.tabpage_detail_2.dw_departments.GetChild( "section", dwchild )
of_filter_lookup_facility( ii_selected_facility_id, dwchild) 
tab_view.tabpage_detail_2.dw_departments.GetChild( "rank", dwchild )
of_filter_lookup_facility( ii_selected_facility_id, dwchild) 
//tab_view.tabpage_detail_2.dw_staff_cat.SetTransObject( SQLCA )//maha082201
tab_view.tabpage_detail_2.dw_staff_cat.Retrieve( il_rec_id,gs_user_id )
tab_view.tabpage_detail_2.dw_staff_cat.GetChild( "staff_category", dwchild )
of_filter_lookup_facility( ii_selected_facility_id, dwchild) 
//End Code Change ----07.15.2011 #V11 maha
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

IF gs_dbtype='asa' or AppeonGetClientType() = 'WEB'  Then //Add 'web', Modified by Appeon long.zhang 01.20.2016 (For Issue: Q on WebView)
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

public function integer of_retrieve_detail_old ();Integer li_row_cnt
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
//tab_view.tabpage_detail_1.dw_apptmnt_status.ShareData( tab_view.tabpage_detail_2.dw_cvo )  //Start Code Change ----11.03.2011 #V12 maha - removed

IF li_row_cnt > 0 THEN
	il_rec_id = tab_view.tabpage_detail_1.dw_apptmnt_status.GetItemNumber( 1, "rec_id" )	//Fixed a bug by jervis 07.06.2007
	of_retrieve_children()
	tab_view.tabpage_browse.dw_browse.SelectRow(1, True)
END IF

//tab_view.tabpage_detail_1.dw_fppe.retrieve(il_prac_id,ii_selected_facility_id)  //Start Code Change ----11.03.2011 #V12 maha - removed
// tab_view.tabpage_detail_1.dw_oppe.retrieve(il_prac_id,ii_selected_facility_id)  //Start Code Change ----11.03.2011 #V12 maha - removed

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

public function integer of_retrieve_detail ();//////////////////////////////////////////////////////////////////////
// $<function> of_retrieve_detail
// $<arguments>
// $<returns> integer
// $<description> Reconstruct code for FPPE&OPPE datawindows retrieve
//////////////////////////////////////////////////////////////////////
// $<add> Evan 08.18.2009
//////////////////////////////////////////////////////////////////////

Integer li_rc
Integer li_row_cnt
integer li_status  //maha 10.15.2014
integer li_midfound
DataWindowChild dwchild

ib_retrieved_allready = True
IF dw_orgs_facilities.RowCount() = 0 AND dw_orgs_facilities.Visible THEN
	Return -1
END IF

tab_view.tabpage_detail_1.dw_comm_review.GetChild("committee_id", dwchild)
tab_view.tabpage_detail_1.dw_apptmnt_status.settransobject(sqlca)
//tab_view.tabpage_detail_1.dw_fppe.settransobject(sqlca)  //Start Code Change ----11.03.2011 #V12 maha - removed
//tab_view.tabpage_detail_1.dw_oppe.settransobject(sqlca)  //Start Code Change ----11.03.2011 #V12 maha - removed
dwchild.SetTransObject(SQLCA)

gnv_appeondb.of_startqueue()
dwchild.Retrieve(ii_selected_facility_id)
li_row_cnt = tab_view.tabpage_detail_1.dw_apptmnt_status.Retrieve(il_prac_id, ii_selected_facility_id,gs_user_id)
//tab_view.tabpage_detail_1.dw_fppe.retrieve(il_prac_id, ii_selected_facility_id)  //Start Code Change ----11.03.2011 #V12 maha - removed
//tab_view.tabpage_detail_1.dw_oppe.retrieve(il_prac_id, ii_selected_facility_id)  //Start Code Change ----11.03.2011 #V12 maha - removed
gnv_appeondb.of_commitqueue()

li_row_cnt = tab_view.tabpage_detail_1.dw_apptmnt_status.RowCount()
tab_view.tabpage_detail_1.dw_apptmnt_status.ShareData(tab_view.tabpage_browse.dw_browse)
// tab_view.tabpage_detail_1.dw_apptmnt_status.ShareData(tab_view.tabpage_detail_2.dw_cvo)  //Start Code Change ----11.03.2011 #V12 maha - removed

//Start Code Change ----10.24.2014 #V14.2 maha - ret from comm for midcycle
if li_row_cnt < 1 then return 0

if ib_mid_from_comm then  //if midcycle find the record - il_rec_id set in open event of return from committee
	li_midfound = tab_view.tabpage_detail_1.dw_apptmnt_status.find( "rec_id = " + string(il_rec_id), 1, li_row_cnt)
	tab_view.tabpage_detail_1.dw_apptmnt_status.scrolltorow(li_midfound)
	tab_view.tabpage_detail_1.dw_apptmnt_status.setrow(li_midfound)
elseif ib_comm_review then  //Start Code Change ----10.31.2014 #V14.2 maha
//		tab_view.tabpage_browse.dw_browse.SelectRow(1, True)   //Start Code Change ----01.20.2016 #V15 maha - removed
		il_rec_id = tab_view.tabpage_detail_1.dw_apptmnt_status.GetItemNumber(tab_view.tabpage_detail_1.dw_apptmnt_status.getrow(), "rec_id")
//IF li_row_cnt > 0 THEN
elseif isvalid(w_add_appointment) then
	//trap for recruitment
//		tab_view.tabpage_browse.dw_browse.SelectRow(1, True)   //Start Code Change ----01.20.2016 #V15 maha - removed
		il_rec_id = tab_view.tabpage_detail_1.dw_apptmnt_status.GetItemNumber(tab_view.tabpage_detail_1.dw_apptmnt_status.getrow(), "rec_id")
else //prac_folder
	li_status = dw_orgs_facilities.getitemnumber(dw_orgs_facilities.getrow(),"active_status")
	if li_status = 6 then
		li_midfound = tab_view.tabpage_detail_1.dw_apptmnt_status.find( "active_status = 6", 1, li_row_cnt)
		tab_view.tabpage_detail_1.dw_apptmnt_status.scrolltorow(li_midfound)
		tab_view.tabpage_detail_1.dw_apptmnt_status.setrow(li_midfound)
	else
//		tab_view.tabpage_browse.dw_browse.SelectRow(1, True)   //Start Code Change ----01.20.2016 #V15 maha - removed
		il_rec_id = tab_view.tabpage_detail_1.dw_apptmnt_status.GetItemNumber(tab_view.tabpage_detail_1.dw_apptmnt_status.getrow(), "rec_id")
	end if
END IF

of_retrieve_children()  
//Start Code Change ----10.24.2014		

//IF li_row_cnt > 0 THEN
	//il_rec_id = tab_view.tabpage_detail_1.dw_apptmnt_status.GetItemNumber(1, "rec_id")  //Start Code Change ----10.15.2014 #V14.2 maha - changed to currentrow
//	il_rec_id = tab_view.tabpage_detail_1.dw_apptmnt_status.GetItemNumber(tab_view.tabpage_detail_1.dw_apptmnt_status.getrow(), "rec_id")
//	of_retrieve_children()
	//tab_view.tabpage_browse.dw_browse.SelectRow(1, True)  //maha 10.21.2014 - moved above
//END IF


RETURN 0
end function

public function integer of_bg_color (long al_rgb);//Start Code Change ----05.25.2010 #V10 maha
this.backcolor = al_rgb
tab_view.backcolor = al_rgb
tab_view.tabpage_browse.backcolor = al_rgb
tab_view.tabpage_detail_1.backcolor = al_rgb
tab_view.tabpage_detail_2.backcolor = al_rgb
tab_view.tabpage_quest.backcolor = al_rgb
tab_view.tabpage_ofe .backcolor = al_rgb
st_recs.backcolor = al_rgb
 tab_view.tabpage_ofe.uo_ofe.of_set_bg_color(al_rgb)


return 1
end function

public function integer of_filter_lookup_facility (long al_facility, datawindowchild ad_child);//Start Code Change ----03.16.2011 #V11 maha  - created to allow facility specific values for Department, Division and Section
//code called from of_setup_dw2
//copy function required modification to cache object(d_g_code_lookup) which may require modification to other objects as well also d_dddw_code_lookup
//search on of_set_dwchild_fromcache to see what will be affected.
integer i
string ls_filter

//debugbreak()
ls_filter  = "facility_id = 0 or isnull(facility_id) or facility_id =  " + string(al_facility)

i = ad_child.setfilter(ls_filter)
if i < 0 then messagebox("of_filter_lookup_facility function filter failed", ls_filter)
ad_child.filter()

return 1

end function

public function integer of_lookup_facility_filter (datawindowchild adwchild, long al_facil);//Start Code Change ----09.13.2011 #V12 maha - added for facility specific lookups;  called from of_retrieve_children2
string ls_filter
integer res

ls_filter = "isnull( facility_id) or facility_id  =  0 or  facility_id = " + string(al_facil)

res = adwchild.setfilter(ls_filter)
adwchild.filter()



return 1
end function

public function integer of_button_visible (integer ai_index);//Start Code Change ----05.02.2012 #V12 maha

if not isvalid(iw_win) then return 1 //add Michael 06.06.2012 Null object reference at line 8 in function of_button_visible of object pfc_cst_u_apptmnt_status
IF ai_index = 5 THEN
	iw_win.cb_add.enabled = False	
	iw_win.cb_delete.enabled =  False
	iw_win.cb_save.enabled =  False
ELSE 	
	iw_win.cb_add.enabled = true	
	iw_win.cb_delete.enabled =  true
	iw_win.cb_save.enabled =  true
End if


return 1
end function

public function integer of_returning ();//Start Code Change ----07.31.2013 #V14 maha - added for a returning provider

u_dw ldw_facil
integer li_find
string ls_val



//if not iw_win.ib_verif_info_retrieved then
//	iw_win.of_retrieve_verif_info( )
//end if
iw_win.tab_1.selecttab(5) // verif tab

ldw_facil = iw_win.tab_1.tabpage_verif.uo_verif_summary.dw_orgs_facilities
ls_val = "prac_id = " + string(il_prac_id) + " and parent_facility_id = " + string(ii_selected_facility_id)
li_find = ldw_facil.find( ls_val , 1,ldw_facil.rowcount())

if li_find < 1 then
	messagebox("Function failure Find (" + string(li_find) + ")", ls_val)
	return 0
end if

ldw_facil.setrow(li_find)

iw_win.tab_1.tabpage_verif.uo_verif_summary.tab_view.selecttab(3)
iw_win.tab_1.tabpage_verif.uo_verif_summary.tab_view.tabpage_recred.enabled = true

messagebox("Returning process","Proceed with the Recredentialing process by Selecting the appropriate verifications and Clicking the Initiate Recredentialing Button.  The existing appointment record will be sent to history.  The new appointment record type should be set to INITIAL.")

return 1
end function

public function integer of_appl_action_create (long ai_facility_id, long ai_app_id, string as_action_type, long ai_rec_id, long al_loc, string as_apt_type);//Start Code Change ----05.06.2014 #V14.2 maha - created from appl tracking tab code for action creation

Long ll_action_type
Long ll_action_status
Long ll_action_dept
Long ll_rec_id
String ls_action_notes
String ls_app_type
DateTime ldt_action_date
Date ld_due_date
datetime ldt_createdate 

ldt_createdate = datetime(today(),now())

ld_due_date = Today()
ls_app_type = as_apt_type 
if isnull(al_loc) then al_loc = 0 //Start Code Change ----05.08.2014 #V14.2 maha
	
//set value for action type
if isnumber(as_action_type) then
	ll_action_type = long(as_action_type)
else
	ll_action_type=long(gnv_data.of_getitem("code_lookup","lookup_code","upper(lookup_name) = 'ACTION TYPE' and upper(code) = '"+upper(as_action_type)+"'"))
end if

//action status value
ll_action_status=long(gnv_data.of_getitem("code_lookup","lookup_code","upper(lookup_name) = 'ACTION STATUS' and upper(code) = '"+upper('Incomplete')+"'"))

ll_rec_id = ai_rec_id
SetNull( ldt_action_date )

INSERT INTO net_dev_action_items  
   		    ( rec_id,   
	    	      prac_id,   
				   seq_no,
     	     	   action_type,   
			      action_date,   
//	    			action_dept,   
     	     	   action_user,   
		     	   next_action_date,   
			      notes,   
		     	   action_status,   
				   facility_id,
				   app_id,
				   app_type,
				   active_status,
					gp_id, 
					create_date,
					create_user, 
					due_date)  
	VALUES ( :ll_rec_id,   
     	      :il_prac_id,  
				:ll_rec_id,					
	    	   :ll_action_type,   
	     	   null,   
//				:ll_action_dept,   
	     		:gs_user_id,   
				null,   
		     	'',   
			   :ll_action_status,   
	     		:ai_facility_id,
				:ai_app_id,
				:ls_app_type,
				1,
				:al_loc,
				:ldt_createdate,
				:gs_user_id,
				:ld_due_date)
 	USING SQLCA;

	IF SQLCA.SQLCODE = -1 THEN
			MessageBox("Database Error", SQLCA.SQLERRTEXT )
			Return -1
	END IF			
	
	RETURN 0

end function

public function integer of_multi_app_new ();//Start Code Change ----07.02.2014 #V14.2 maha - new function where data creation is on the Multi-App screen

openwithparm(w_multi_app_select, il_prac_id ) 

IF Message.StringParm = "Cancel" THEN
	Return 0
ELSE
	
	dw_orgs_facilities.SetRedraw(False) //alfee 11.22.2010
	dw_orgs_facilities.Retrieve( il_prac_id, gs_user_id )
	dw_orgs_facilities.SetRedraw(True) //alfee 11.22.2010
	
	IF  Isvalid(w_prac_data_1) then  
		iw_win.ib_app_audit_retrieved = False
		iw_win.ib_affil_stat_retrieved = False
		iw_win.ib_verif_info_retrieved = False
		iw_win.ib_priv_retrieved = False
	end if

END IF


Return 1


end function

public function integer of_retrieve_detail_rec (long al_recid);//Start Code Change ----12.08.2014 #V14.2 maha - added for retrieval by recid

Integer li_rc
Integer li_row_cnt
integer li_status  //maha 10.15.2014
integer li_found
DataWindowChild dwchild

ib_retrieved_allready = True
IF dw_orgs_facilities.RowCount() = 0 AND dw_orgs_facilities.Visible THEN
	Return -1
END IF

tab_view.tabpage_detail_1.dw_comm_review.GetChild("committee_id", dwchild)
tab_view.tabpage_detail_1.dw_apptmnt_status.settransobject(sqlca)
dwchild.SetTransObject(SQLCA)

gnv_appeondb.of_startqueue()
dwchild.Retrieve(ii_selected_facility_id)
//li_row_cnt = tab_view.tabpage_detail_1.dw_apptmnt_status.Retrieve(al_recid)
li_row_cnt = tab_view.tabpage_detail_1.dw_apptmnt_status.Retrieve(il_prac_id, ii_selected_facility_id,gs_user_id)
//tab_view.tabpage_detail_1.dw_fppe.retrieve(il_prac_id, ii_selected_facility_id)  //Start Code Change ----11.03.2011 #V12 maha - removed
//tab_view.tabpage_detail_1.dw_oppe.retrieve(il_prac_id, ii_selected_facility_id)  //Start Code Change ----11.03.2011 #V12 maha - removed
gnv_appeondb.of_commitqueue()

li_row_cnt = tab_view.tabpage_detail_1.dw_apptmnt_status.RowCount()
tab_view.tabpage_detail_1.dw_apptmnt_status.ShareData(tab_view.tabpage_browse.dw_browse)
// tab_view.tabpage_detail_1.dw_apptmnt_status.ShareData(tab_view.tabpage_detail_2.dw_cvo)  //Start Code Change ----11.03.2011 #V12 maha - removed

//Start Code Change ----10.24.2014 #V14.2 maha - ret from comm for midcycle
if li_row_cnt < 1 then return 0

li_found = tab_view.tabpage_detail_1.dw_apptmnt_status.find( "rec_id = " + string(al_recid), 1, li_row_cnt)
tab_view.tabpage_detail_1.dw_apptmnt_status.scrolltorow(li_found)
tab_view.tabpage_detail_1.dw_apptmnt_status.setrow(li_found)

//if ib_mid_from_comm then  //if midcycle find the record - il_rec_id set in open event of return from committee
//	li_midfound = tab_view.tabpage_detail_1.dw_apptmnt_status.find( "rec_id = " + string(il_rec_id), 1, li_row_cnt)
//	tab_view.tabpage_detail_1.dw_apptmnt_status.scrolltorow(li_midfound)
//	tab_view.tabpage_detail_1.dw_apptmnt_status.setrow(li_midfound)
//elseif ib_comm_review then  //Start Code Change ----10.31.2014 #V14.2 maha
//		tab_view.tabpage_browse.dw_browse.SelectRow(1, True)
//		il_rec_id = tab_view.tabpage_detail_1.dw_apptmnt_status.GetItemNumber(tab_view.tabpage_detail_1.dw_apptmnt_status.getrow(), "rec_id")
////IF li_row_cnt > 0 THEN
//else //prac_folder
//	li_status = dw_orgs_facilities.getitemnumber(dw_orgs_facilities.getrow(),"active_status")
//	if li_status = 6 then
//		li_midfound = tab_view.tabpage_detail_1.dw_apptmnt_status.find( "active_status = 6", 1, li_row_cnt)
//		tab_view.tabpage_detail_1.dw_apptmnt_status.scrolltorow(li_midfound)
//		tab_view.tabpage_detail_1.dw_apptmnt_status.setrow(li_midfound)
//	else
//		tab_view.tabpage_browse.dw_browse.SelectRow(1, True)
//		il_rec_id = tab_view.tabpage_detail_1.dw_apptmnt_status.GetItemNumber(tab_view.tabpage_detail_1.dw_apptmnt_status.getrow(), "rec_id")
//	end if
//END IF

of_retrieve_children()
//Start Code Change ----10.24.2014		

//IF li_row_cnt > 0 THEN
	//il_rec_id = tab_view.tabpage_detail_1.dw_apptmnt_status.GetItemNumber(1, "rec_id")  //Start Code Change ----10.15.2014 #V14.2 maha - changed to currentrow
//	il_rec_id = tab_view.tabpage_detail_1.dw_apptmnt_status.GetItemNumber(tab_view.tabpage_detail_1.dw_apptmnt_status.getrow(), "rec_id")
//	of_retrieve_children()
	//tab_view.tabpage_browse.dw_browse.SelectRow(1, True)  //maha 10.21.2014 - moved above
//END IF

RETURN 0
end function

public function integer of_post_resize ();//Start Code Change ----02.02.2016 #V15 maha - created
long wid
long hig
long thig

wid = tab_view.width - 25
hig = tab_view.height - 96

//tabpages
tab_view.tabpage_browse.width = wid
tab_view.tabpage_detail_1.width = wid
tab_view.tabpage_detail_2.width = wid
tab_view.tabpage_quest.width = wid
tab_view.tabpage_ofe.width = wid
tab_view.tabpage_browse.height = hig - 10
tab_view.tabpage_detail_1.height = hig - 10
tab_view.tabpage_detail_2.height = hig - 10
tab_view.tabpage_quest.height = hig - 10
tab_view.tabpage_ofe.height = hig - 10

thig = tab_view.tabpage_browse.height/5

//browse
tab_view.tabpage_browse.dw_browse.width = wid - 60
tab_view.tabpage_browse.dw_browse.height = hig - 25

//detail
tab_view.tabpage_detail_1.dw_apptmnt_status.width = wid - 60
tab_view.tabpage_detail_1.gb_comm.width =  wid - 60
tab_view.tabpage_detail_1.dw_comm_review.width = tab_view.tabpage_detail_1.gb_comm.width - 60
tab_view.tabpage_detail_1.dw_apptmnt_status.height = thig * 4
tab_view.tabpage_detail_1.gb_comm.y = tab_view.tabpage_detail_1.dw_apptmnt_status.height + 25
tab_view.tabpage_detail_1.gb_comm.height = thig - 50 
tab_view.tabpage_detail_1.dw_comm_review.y = tab_view.tabpage_detail_1.gb_comm.y + 60
tab_view.tabpage_detail_1.dw_comm_review.height = thig - 130 

//detail 2
thig = tab_view.tabpage_detail_2.height/3 - 10

tab_view.tabpage_detail_2.gb_cat.width = wid - 60
tab_view.tabpage_detail_2.gb_dep.width = wid - 60
tab_view.tabpage_detail_2.gb_lea.width = wid - 60

tab_view.tabpage_detail_2.dw_departments.width = tab_view.tabpage_detail_2.gb_dep.width - 60
tab_view.tabpage_detail_2.dw_staff_cat.width = tab_view.tabpage_detail_2.gb_cat.width - 60
tab_view.tabpage_detail_2.dw_leave.width = tab_view.tabpage_detail_2.gb_lea.width - 60

tab_view.tabpage_detail_2.gb_cat.y = 10
tab_view.tabpage_detail_2.gb_cat.height = thig - 10
tab_view.tabpage_detail_2.dw_staff_cat.y = tab_view.tabpage_detail_2.gb_cat.y + 60
tab_view.tabpage_detail_2.dw_staff_cat.height = tab_view.tabpage_detail_2.gb_cat.y + tab_view.tabpage_detail_2.gb_cat.height - 120

tab_view.tabpage_detail_2.gb_dep.y = tab_view.tabpage_detail_2.gb_cat.y + tab_view.tabpage_detail_2.gb_cat.height + 25
tab_view.tabpage_detail_2.gb_dep.height = thig - 25
tab_view.tabpage_detail_2.dw_departments.y = tab_view.tabpage_detail_2.gb_dep.y + 60
tab_view.tabpage_detail_2.dw_departments.height = tab_view.tabpage_detail_2.dw_staff_cat.height

tab_view.tabpage_detail_2.gb_lea.y = tab_view.tabpage_detail_2.gb_dep.y + tab_view.tabpage_detail_2.gb_dep.height + 25
tab_view.tabpage_detail_2.gb_lea.height = thig - 25
tab_view.tabpage_detail_2.dw_leave.y =  tab_view.tabpage_detail_2.gb_lea.y + 60
tab_view.tabpage_detail_2.dw_leave.height = tab_view.tabpage_detail_2.dw_staff_cat.height

//attest
tab_view.tabpage_quest.dw_quest.width = wid - 60
tab_view.tabpage_quest.dw_quest.height = hig - 25

//OPPE
tab_view.tabpage_ofe.uo_ofe.width =  wid - 60
tab_view.tabpage_ofe.uo_ofe.height = hig - 25
tab_view.tabpage_ofe.uo_ofe.of_post_resize( tab_view.tabpage_ofe.uo_ofe.height, tab_view.tabpage_ofe.uo_ofe.width )


return 1
end function

public function integer of_security_setting (); //Start Code Change ----03.23.2017 #V153 maha - added; called from of_setup_dw
// security on Appointment data
integer r
integer rc
string ls_list
string ls_list2
string ls_objects[]
n_cst_string_appeon lnv_string

//ls_list = tab_view.tabpage_detail_1.dw_apptmnt_status.Describe("DataWindow.Objects")
ls_list = tab_view.tabpage_detail_1.dw_apptmnt_status.Describe("DataWindow.visualobjects")

//messagebox("list" , ls_list)

Long i, ll_cnt, ll_found
String ls_lookup_code[]


lnv_string.of_parsetoarray(ls_list, "~t",  ls_objects)

rc = UpperBound(ls_objects)

FOR r = 1 to rc
	 tab_view.tabpage_detail_1.dw_apptmnt_status.modify( ls_objects[r] + ".protect=1")
NEXT

tab_view.tabpage_detail_1.dw_apptmnt_status.modify( "b_notes" + ".visible=false") //b_notes is a picture
tab_view.tabpage_detail_1.dw_apptmnt_status.modify( "b_clear" + ".enabled=false")

IF w_mdi.of_security_access( 7842 ) = 0 THEN   
	tab_view.tabpage_detail_1.dw_apptmnt_status.Modify("b_review.visible = '0'")
else
	tab_view.tabpage_detail_1.dw_apptmnt_status.Modify("b_review.visible = '1'")
end if


return 1
end function

public function integer of_button_check ();//Start Code Change ----06.07.2017 #V154 maha
if tab_view.selectedtab = 5 then
	of_button_visible( 5)
end if

return 1
end function

public subroutine of_zoom ();//Start Code Change ----07.13.2017 #V154 maha
dw_orgs_facilities.Modify("DataWindow.Zoom=" + string(gi_zoom))
tab_view.tabpage_detail_1.dw_apptmnt_status.Modify("DataWindow.Zoom=" + string(gi_zoom))
tab_view.tabpage_browse.dw_browse.Modify("DataWindow.Zoom=" + string(gi_zoom))
tab_view.tabpage_detail_1.dw_comm_review.Modify("DataWindow.Zoom=" + string(gi_zoom))
tab_view.tabpage_detail_2.dw_departments.Modify("DataWindow.Zoom=" + string(gi_zoom))
tab_view.tabpage_detail_2.dw_leave.Modify("DataWindow.Zoom=" + string(gi_zoom))
tab_view.tabpage_detail_2.dw_staff_cat.Modify("DataWindow.Zoom=" + string(gi_zoom))
tab_view.tabpage_quest.dw_quest.Modify("DataWindow.Zoom=" + string(gi_zoom))

tab_view.tabpage_ofe.uo_ofe.of_zoom()


end subroutine

on pfc_cst_u_apptmnt_status.create
this.st_recs=create st_recs
this.dw_orgs_facilities=create dw_orgs_facilities
this.tab_view=create tab_view
this.p_1=create p_1
this.dw_facility_add=create dw_facility_add
this.Control[]={this.st_recs,&
this.dw_orgs_facilities,&
this.tab_view,&
this.p_1,&
this.dw_facility_add}
end on

on pfc_cst_u_apptmnt_status.destroy
destroy(this.st_recs)
destroy(this.dw_orgs_facilities)
destroy(this.tab_view)
destroy(this.p_1)
destroy(this.dw_facility_add)
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
string ls_lookup //maha 09.14.2011
string ls_lu_table  //maha 09.14.2011
integer li_hide
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
//tab_view.tabpage_detail_2.dw_cvo.GetChild( "pd_affil_stat_admit_priv", dwchild )  //Start Code Change ----11.03.2011 #V12 maha - removed
dwchild.settransobject(sqlca)
dwchild.retrieve()

gnv_appeondb.of_commitqueue()
//The following script is moved from of_custom_labels function
ic = ids_fields.rowcount()
if ic > 0 then
	for i = 1 to ic  //Start Code Change ----11.03.2011 #V12 maha -  modified for move of custom data to detail 1
		fname = ids_fields.getitemstring(i,"field_name")
		lname = ids_fields.getitemstring(i,"field_name_allias")
		li_hide = ids_fields.getitemnumber(i,"hide_field")
		
		if fname = "apptmnt_start_date" and lname = "Appointment Start Date" then lname = "Begins"	 //Start Code Change ----09.30.2015 #V15 maha - exception for this field
		
		s = fname + "_t.text = '" + lname + "'"
		//Start Code Change ----10.01.2008 #V85 maha - added for signed field		
		err = tab_view.tabpage_detail_1.dw_apptmnt_status.modify(s)
		 //Start Code Change ----08.13.2015 #V15 maha
		 if li_hide = 1 then
			 s = fname + ".visible = False"
			 err = tab_view.tabpage_detail_1.dw_apptmnt_status.modify(s)
			 s = fname + "_t.visible = False"
			 err = tab_view.tabpage_detail_1.dw_apptmnt_status.modify(s)
		end if
		if MidA(fname,1,4) = 'cust' then
			//Start Code Change ----09.14.2011 #V12 maha - use of lookup table
			ls_lookup =  ids_fields.getitemstring(i,"lookup_field")
			ls_lu_table =  ids_fields.getitemstring(i,"lookup_code")
			
			if ls_lookup = "Y" and not isnull(ls_lu_table ) then
				err = tab_view.tabpage_detail_1.dw_apptmnt_status.modify( fname + ".dddw.name = 'd_dddw_code_lookup'")
				err = tab_view.tabpage_detail_1.dw_apptmnt_status.modify( fname + ".dddw.datacolumn = 'lookup_code'")	
				err = tab_view.tabpage_detail_1.dw_apptmnt_status.modify( fname + ".dddw.displaycolumn = 'description'")	
				err = tab_view.tabpage_detail_1.dw_apptmnt_status.modify( fname + ".dddw.VscrollBar = Yes")	
				err = tab_view.tabpage_detail_1.dw_apptmnt_status.modify( fname + ".dddw.useasborder = Yes")	
				
				 tab_view.tabpage_detail_1.dw_apptmnt_status.getchild( fname, dwchild)
				dwchild.settransobject(sqlca)
				gnv_data.of_set_dwchild_fromcache('code_lookup',"upper(lookup_name)='"+upper(ls_lu_table)+"'",dwchild)
				dwchild.insertrow(1)
			end if
			//End Code Change ----09.14.2011
		end if
		//End Code Change---10.01.2008
		
	next
//	for i = 1 to ic
//		fname = ids_fields.getitemstring(i,"field_name")
//		lname = ids_fields.getitemstring(i,"field_name_allias")
//		s = fname + "_t.text = '" + lname + "'"
//		//Start Code Change ----10.01.2008 #V85 maha - added for signed field
//		if MidA(fname,1,4) = 'cust' then
//			err = tab_view.tabpage_detail_2.dw_cvo.modify(s)
//			//Start Code Change ----09.14.2011 #V12 maha - use of lookup table
//			ls_lookup =  ids_fields.getitemstring(i,"lookup_field")
//			ls_lu_table =  ids_fields.getitemstring(i,"lookup_code")
//			
//			if ls_lookup = "Y" and not isnull(ls_lu_table ) then
//				err =  tab_view.tabpage_detail_2.dw_cvo.Modify( fname + ".dddw.name = 'd_dddw_code_lookup'")
//				err =  tab_view.tabpage_detail_2.dw_cvo.Modify( fname + ".dddw.datacolumn = 'lookup_code'")	
//				//err =  tab_view.tabpage_detail_2.dw_cvo.Modify( fname + ".dddw.datacolumn = 'description'")	
//				err =  tab_view.tabpage_detail_2.dw_cvo.Modify( fname + ".dddw.displaycolumn = 'description'")	
//				err =  tab_view.tabpage_detail_2.dw_cvo.Modify( fname + ".dddw.VscrollBar = Yes")	
//				err =  tab_view.tabpage_detail_2.dw_cvo.Modify( fname + ".dddw.useasborder = Yes")	
//				
//				 tab_view.tabpage_detail_2.dw_cvo.getchild( fname, dwchild)
//				dwchild.settransobject(sqlca)
//				gnv_data.of_set_dwchild_fromcache('code_lookup',"upper(lookup_name)='"+upper(ls_lu_table)+"'",dwchild)
//				dwchild.insertrow(1)
//			end if
//			//End Code Change ----09.14.2011
//		else
//			tab_view.tabpage_detail_1.dw_apptmnt_status.modify(s)
//		end if
//		//End Code Change---10.01.2008
//		
//	next
end if



If Upper(appeongetclienttype()) = "WEB" Then
	if tab_view.tabpage_browse.visible = false then
		if tab_view.selectedtab = 2 then
			tab_view.selectedtab = 1
		end if
	end if		
End If

//Start Code Change ----12.14.2016 #V15 maha - for use hiding the midcycle options
this.postevent("ue_hide_midcycle")
//End Code Change ----12.14.2016





//---------------------------- APPEON END ----------------------------

//------------------- APPEON BEGIN -------------------
//$<add> Stephen 03.10.2011
//$<reason> Odd issue with Hosted clients
If Upper(appeongetclienttype()) = "WEB" Then
//	tab_view.tabpage_detail_1.gb_1.Y = tab_view.tabpage_detail_1.dw_apptmnt_status.y + tab_view.tabpage_detail_1.dw_apptmnt_status.height + 10
//	tab_view.tabpage_detail_1.dw_fppe.y = tab_view.tabpage_detail_1.gb_1.y + 50
//	tab_view.tabpage_detail_1.dw_oppe.y = tab_view.tabpage_detail_1.dw_fppe.y
//	tab_view.tabpage_detail_1.cb_view.y = tab_view.tabpage_detail_1.dw_fppe.y
//	tab_view.tabpage_detail_1.dw_fppe.x = tab_view.tabpage_detail_1.gb_1.x + 10
//	tab_view.tabpage_detail_1.dw_oppe.x = tab_view.tabpage_detail_1.dw_fppe.x + tab_view.tabpage_detail_1.dw_fppe.width + 10
//	tab_view.tabpage_detail_1.cb_view.x = tab_view.tabpage_detail_1.dw_oppe.x + tab_view.tabpage_detail_1.dw_oppe.width + 10
//	tab_view.tabpage_detail_1.gb_6.y = tab_view.tabpage_detail_1.gb_1.y + tab_view.tabpage_detail_1.gb_1.height + 10
    tab_view.tabpage_detail_1.gb_comm.Y = tab_view.tabpage_detail_1.dw_apptmnt_status.y + tab_view.tabpage_detail_1.dw_apptmnt_status.height + 10 //add by stephen 04.07.2013 - Odd issue with Hosted clients
	tab_view.tabpage_detail_1.dw_comm_review.y = tab_view.tabpage_detail_1.gb_comm.y + 50
End If
//------------------- APPEON END ---------------------

of_zoom() //Start Code Change ----07.13.2017 #V154 maha

//Start Code Change ----08.20.2015 #V15 maha - For NYHHC - option to allow access to the active_status field
//Start Code Change ----01.14.2016 #V15 maha  - removed
//if of_get_app_setting("set_14","I") = 1234 then
//	tab_view.tabpage_detail_2.dw_departments.modify("active_status.protect = 0")
//else
//	tab_view.tabpage_detail_2.dw_departments.modify("active_status.protect = 1")
//end if
//End Code Change ----08.20.2015

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

type st_recs from statictext within pfc_cst_u_apptmnt_status
integer x = 2848
integer y = 28
integer width = 334
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Record 1 of 1"
boolean focusrectangle = false
end type

type dw_orgs_facilities from u_dw within pfc_cst_u_apptmnt_status
integer x = 5
integer y = 8
integer width = 905
integer height = 1960
integer taborder = 10
string title = "Select Payor/Hospital"
string dataobject = "d_pd_affil_status_orgs_only"
boolean hscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;Integer li_org_id
Integer li_facility_id
integer li_midfound  //maha 10.21.2014
integer li_status  //maha 10.21.2014
long ll_rec_id //maha 12.08.2014

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
	il_rec_id = This.GetItemNumber( currentrow, "rec_id")
	//Start Code Change ----12.08.2014 #V14.2 maha - rec id retrieve
	//of_retrieve_detail( )
	of_retrieve_detail_rec(il_rec_id )
	//Start Code Change ----10.15.2014 #V14.2 maha - mid-cycle set
//	IF This.RowCount() > 0 THEN
//		li_status = dw_orgs_facilities.getitemnumber(dw_orgs_facilities.getrow(),"active_status")
//		if li_status = 6 then
//			li_midfound = tab_view.tabpage_detail_1.dw_apptmnt_status.find( "active_status = 6", 1,This.RowCount() )
//			this.selectrow(0,false)  //10.21.2014
//			this.selectrow(li_midfound, true)
//		end if
//	END IF
	//End Code Change ----10.15.2014	
	//End Code Change ----12.08.2014
//	tab_view.tabpage_browse.dw_browse.SelectRow( 0, False )
//	tab_view.tabpage_browse.dw_browse.SelectRow(1, True)
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

//This.SelectRow( 0, False )  //Start Code Change ----01.20.2016 #V15 maha - removed
//This.SelectRow( li_row, True )
This.ScrollToRow( li_row )
This.SetRow( li_row )

//------------------- APPEON BEGIN -------------------
//$<add> Michael 12.28.2011
//$<reason> Bug 2838 auto populating on Appointments tab
choose case  tab_view.selectedtab 
	case 1
		tab_view.tabpage_browse.dw_browse.SetFocus( )
	case 2
		tab_view.tabpage_detail_1.dw_apptmnt_status.SetFocus( )
	case 3
		tab_view.tabpage_detail_2.dw_departments.SetFocus( )
	case 4
		tab_view.tabpage_quest.dw_quest.SetFocus( )
end choose
//------------------- APPEON END ---------------------
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

type tab_view from tab within pfc_cst_u_apptmnt_status
integer x = 919
integer y = 4
integer width = 3451
integer height = 1968
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 79741120
boolean raggedright = true
integer selectedtab = 2
tabpage_browse tabpage_browse
tabpage_detail_1 tabpage_detail_1
tabpage_detail_2 tabpage_detail_2
tabpage_quest tabpage_quest
tabpage_ofe tabpage_ofe
end type

on tab_view.create
this.tabpage_browse=create tabpage_browse
this.tabpage_detail_1=create tabpage_detail_1
this.tabpage_detail_2=create tabpage_detail_2
this.tabpage_quest=create tabpage_quest
this.tabpage_ofe=create tabpage_ofe
this.Control[]={this.tabpage_browse,&
this.tabpage_detail_1,&
this.tabpage_detail_2,&
this.tabpage_quest,&
this.tabpage_ofe}
end on

on tab_view.destroy
destroy(this.tabpage_browse)
destroy(this.tabpage_detail_1)
destroy(this.tabpage_detail_2)
destroy(this.tabpage_quest)
destroy(this.tabpage_ofe)
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
	//---------Begin Modified by (Appeon)Harry 01.24.2014 for V142 ISG-CLX--------
	//m_pfe_cst_data_entry.m_file.m_multiapp.ToolBarItemVisible = False
	gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_file.m_multiapp,'ToolBarItemVisible', False)
	//---------End Modfiied ------------------------------------------------------
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
elseif	newindex = 5 then //Start Code Change ----.2011 #V12 maha - added for oppe tab
	this.tabpage_ofe.uo_ofe.of_setup( il_prac_id ,ii_selected_facility_id )
//	this.tabpage_ofe.uo_ofe.tab_1.tabpage_1.dw_browse.setfilter("active_status = 1")
//	this.tabpage_ofe.uo_ofe.tab_1.tabpage_1.dw_browse.filter()

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
	Case 5
		This.tabpage_ofe.uo_ofe.tab_1.tabpage_1.dw_detail.SetFocus()
End Choose
//---------------------------- APPEON END ----------------------------

of_button_visible(newindex)

//---------------------------- APPEON END ----------------------------

end event

type tabpage_browse from userobject within tab_view
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 3415
integer height = 1852
long backcolor = 32891346
string text = "Browse"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
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
integer width = 3415
integer height = 1836
integer taborder = 11
string dataobject = "d_pd_affil_status_browse"
boolean hscrollbar = true
boolean vscrollbar = false
boolean border = false
end type

event clicked;call super::clicked;Integer li_clicked_row
long     ll_tab

li_clicked_row = This.GetClickedRow()

IF li_clicked_Row > 0 THEN
	//------------------- APPEON BEGIN -------------------
	//$<add> Stephen 04.13.2012
	//$<reason> Bug 3014 - Issue with double-clicking to change appointment status in IntelliCred Web
	ll_tab = long(tab_view.tabpage_detail_1.dw_apptmnt_status.describe("active_status.tabsequence"))
	tab_view.tabpage_detail_1.dw_apptmnt_status.modify("active_status.tabsequence='0'")
	tab_view.tabpage_detail_1.dw_apptmnt_status.setcolumn("fee")
	//------------------- APPEON END -------------------	
	this.setrow(li_clicked_Row)  //Start Code Change ----01.20.2016 #V15 maha - added set row. 
	tab_view.tabpage_detail_1.dw_apptmnt_status.SetRow( li_clicked_row )
	tab_view.tabpage_detail_1.dw_apptmnt_status.ScrollToRow( li_clicked_row )
	
	tab_view.tabpage_detail_1.dw_apptmnt_status.modify("active_status.tabsequence='"+string(ll_tab)+"'") //add by stephen 04.13.2012 Bug 3014
	of_retrieve_children()//Start Code Change ----01.26.2015 #V14.2 maha
	//This.SelectRow( 0, False)   //Start Code Change ----01.20.2016 #V15 maha - removed
	// This.SelectRow( li_clicked_row, True )   //Start Code Change ----01.20.2016 #V15 maha - removed
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
integer y = 100
integer width = 3415
integer height = 1852
boolean border = true
long backcolor = 33551856
string text = "Detail 1"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 553648127
dw_apptmnt_status dw_apptmnt_status
gb_comm gb_comm
dw_comm_review dw_comm_review
end type

on tabpage_detail_1.create
this.dw_apptmnt_status=create dw_apptmnt_status
this.gb_comm=create gb_comm
this.dw_comm_review=create dw_comm_review
this.Control[]={this.dw_apptmnt_status,&
this.gb_comm,&
this.dw_comm_review}
end on

on tabpage_detail_1.destroy
destroy(this.dw_apptmnt_status)
destroy(this.gb_comm)
destroy(this.dw_comm_review)
end on

type dw_apptmnt_status from u_dw within tabpage_detail_1
event ue_itemchanged ( integer al_application_audit_facility )
event ue_returning_prac ( )
event ue_undo_change ( integer ai_row,  string as_col,  any aa_val )
integer y = 12
integer width = 3387
integer height = 1444
integer taborder = 11
string dataobject = "d_pd_affil_status"
boolean hscrollbar = true
boolean border = false
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

event ue_returning_prac;of_returning()
end event

event ue_undo_change(integer ai_row, string as_col, any aa_val);//Start Code Change ----07..2013 #V14 maha
this.setitem(ai_row,as_col,aa_val)
this.accepttext()
this.setitemstatus( ai_row,as_col,primary!,notmodified!)
end event

event itemchanged;call super::itemchanged;//Start Code Change ----07.15.2011 #V11 maha - rearranged code to make easier to read.  Combined all parent facility code into a single if statement.
n_ds lds_cred_comms
DataWindowChild dwchild
boolean lb_midcycle = false
Date ldt_action_date
date ld_apptmnt_start_date // 01.13.2006 By: Liang QingShi
date ld_apptmnt_end_date
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
Integer li_rec_no
integer li_day //03.03.2008  maha
integer li_month //03.03.2008  maha
integer li_year  //03.03.2008  maha
Integer li_dat
Integer li_dvf
integer li_userdef //maha 02.16.2011
integer li_active
integer li_org_status  //maha 07.31.2013
Long ll_rec_id
Long ll_action_type
Long ll_action_dept
Long ll_action_status
long ll_application_audit_facility_old// 08/06/2007 by: Andy
String ls_app_type
String nulldata
String ls_action_notes
string ls_column //maha12.15.2009
string ls_col_stat //maha 12.15.2009
string ls_atype //maha 02.16.2011
string ls_affilstat //maha 02.16.2011
string ls_stat_resp  //maha 07.31.2013


SetNull( nullval )
SetNull( nulldata)

ls_column = this.getcolumnname( )//Start Code Change ----06.13.2016 #V152 maha  - moved from below

//@@@@@@@@@@@@@ ACTIVE STATUS @@@@@@@@@@@@@

//Start Code Change ----03.09.2010 #V10 maha - security for purge in status field
if w_mdi.of_security_access(7120) = 0 then
	if This.GetColumnName() = "active_status" and data = "2" THEN
		messagebox("Purge Security","You do not have security rights to Purge a practitioner.")
		this.setitem(row,"active_status", this.getitemnumber(row,"active_status", primary!,true))
		//this.accepttext( )
		//return 1
		return 2   //Modified by Harry 10.31.2017 
	end if
//Start Code Change ----02.12.2014 #V14 maha
else
	if This.GetColumnName() = "active_status" and data = "2" THEN
		li_ans = MessageBox("Purge Status",  "Purge is used in preparation for deletion of the practitioner.  If you are just removing the connection to the Facility/Group, INACTIVE is a better choice.  Setting to Purge will DELETE all Applications tab data for this Facility/Group. ~r~r   Are you sure you wish to Continue?", Exclamation!, YesNo!, 2 )
		IF li_ans = 2 THEN
			this.setitem(row,"active_status", this.getitemnumber(row,"active_status", primary!,true))
			//return 1
			return 2   //Modified by Harry 10.31.2017 
		end if
	end if
	//Start Code Change ----10.22.2014 #V14.2 maha - moved below by alfee 11.13.2014 (BugA101703)
	/*if This.GetColumnName() = "active_status" and this.getitemstring(row, "apptmnt_type") = 'M' then
		if data <> "6" and data <> "0" then
			messagebox("MidCycle appointment","The record status for a MidCycle appointment can only be set to Midcycle or History.")
			this.setitem(row,"active_status", 6)
			return 1
		end if
	end if */
	//End Code Change ----10.22.2014
end if
//End Code Change ----02.12.2014
//End Code Change---03.09.2010

//---------Begin Addeded by (Appeon)Alfee 11.13.2014 (BugA101703)------------
if dwo.name = "active_status" then	
	ls_app_type = This.getitemstring(row, "apptmnt_type") 
	if  ls_app_type = "M" and data <> "6" and data <> "0" then
		messagebox("MidCycle appointment","The record status for a MidCycle appointment can only be set to Midcycle or History.")
		this.setitem(row,"active_status", 6)
		//return 1
		return 2   //Modified by Harry 10.31.2017 
	elseif ls_app_type <> "M" and data = "6" then
		messagebox("MidCycle appointment","The  record status for the current appointment type cannot be set to Midcycle.")
		this.setitem(row,"active_status", this.getitemnumber(row, "active_status", Primary!, true))
		//return 1
		return 2   //Modified by Harry 10.31.2017 
	end if	
end if
//---------End Added --------------------------------------------------------------------

ll_rec_id = this.getitemnumber(this.getrow(),"rec_id")

//Start Code Change ----06.13.2016 #V152 maha -
if ls_column = "active_status" THEN
	li_org_status = this.getitemnumber( row,"active_status", primary!, true  )
	if li_org_status = 0 and (data = '1' or data = '4' or data = '3') then
		li_found = tab_view.tabpage_browse.dw_browse.find( "rec_id <> " + string(ll_rec_id) + " and active_status in (1,4,3)", 1,  tab_view.tabpage_browse.dw_browse.rowcount())   //Modified by Harry 10.31.2017 (add space Before "and active_status in (1,4,3)") for Alpha ID 5860
		choose case li_found
			case is < 0 
				messagebox("Item changed Event","Bad filter")
			case is > 0
				//Start Code Change ----07.13.2017 #V154 maha
				if of_get_app_setting("set_75","I") = 1 then //NCQA enforcement
					messagebox("Item changed Event","You are changing a Historical record to one that Active/Pending/Inactive and one already exists.")
					this.post event ue_undo_change(row, "active_status", li_org_status)
					//return 1
					return 2  //Modified by Harry 10.31.2017 apb bug(Item '...' does not pass validation test.)
				else
					li_ans = messagebox("Item changed Event","You are changing a Historical record to one that Active/Pending/Inactive and one already exists.  Are you sure you want to make this change?", question!, yesno!, 2)
					if li_ans = 2 then
						this.post event ue_undo_change(row, "active_status", li_org_status)
						//return 1
						return 2  //Modified by Harry 10.31.2017 apb bug(Item '...' does not pass validation test.)
					end if
				end if
		end choose
	end if
end if
//End Code Change ----06.13.2016

//Start Code Change ----07.31.2013 #V14 maha - modified for returning status change
IF This.GetColumnName() = "active_status" THEN
	li_org_status = this.getitemnumber( row,"active_status", primary!, true  )
	integer mit
	mit = w_mdi.of_security_access(140)
	if mit = 2 then //verif read/write
		if li_org_status = 3 and (data = '1' or data = '4') then
			openwithparm(w_status_change_message, data)
			ls_stat_resp = message.stringparm
			choose case ls_stat_resp
				case "C"  //cancel
					this.post event ue_undo_change(row, "active_status", li_org_status)
				case "O"  //OK
					of_set_active( Integer( data ) )
				case "R"
					of_set_active( Integer( data ) )
					this.post event ue_returning_prac( )
			end choose
		else
			of_set_active( Integer( data ) )
		end if //hist->active
	else
		of_set_active( Integer( data ) )
	end if //security
END IF
//Start Code Change ----07.31.2013



//@@@@@@@@@@@@@ INOVA Message @@@@@@@@@@@@@
//Start Code Change ----12.15.2009 #V10 maha - change check for Inova
//ls_column = this.getcolumnname( )  //Start Code Change ----06.13.2016 #V152 maha - moved above

if of_get_app_setting("set_13","I") = 1 then
	ls_col_stat = of_check_row_status(this,this.getrow())
	if ls_col_stat  = "mod" or ls_col_stat = "not"  then
		choose case ls_column
			case "parent_facility_id", "application_audit_facility", "verifying_facility"
				li_ans = messagebox( "Changing " + ls_column, "You are changing data that will effect several areas of the program.  Are you sure you wish to continue?", question!,yesno!,2)
				if li_ans = 2 then
					setitem(row,string(dwo.name),getitemnumber(row,string(dwo.name)))
					Return 2
				end if
						
		end choose
	end if
end if
//End Code Change---12.15.2009

//@@@@@@@@@@@@@ APPOINTMENT START DATE @@@@@@@@@@@@@
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
	debugbreak()
	//Start Code Change ----06.27.2014 #V14.2 maha
	if li_years < 0 then
		ld_apptmnt_end_date =	inv_datetime.of_exp_date_birthday( abs(li_years), ld_apptmnt_start_date, il_prac_id )
	elseif li_years > 0 then
		ld_apptmnt_end_date = inv_datetime.of_relativeyear(ld_apptmnt_start_date, li_years)
		ld_apptmnt_end_date = RelativeDate( ld_apptmnt_end_date, -1 )
	else //= 0
		//nothing
	end if
	//Start Code Change ----06.27.2014

	if li_years <> 0 then // if set to 0 don't set end date.
		This.SetItem( row, "apptmnt_end_date", ld_apptmnt_end_date )
	end if
	//End Code Change---03.03.2008

	if This.getItemstring( row, "apptmnt_type") = "I" then //\/maha 080102 set initial date
		if isnull(this.getitemdatetime(row, "inital_appmnt_date")) then //Start Code Change ---- 04.24.2006 #405 maha don't reset if set
			This.SetItem( row, "inital_appmnt_date",ld_apptmnt_start_date)
		end if
	end if
	
	if This.getItemnumber( row, "active_status") = 4 then //\/maha 080102 
		This.SetItem( row, "active_status",1)
		of_set_active(1) //maha app080405
	end if
END IF


//@@@@@@@@@@@@@ APPOINTMENT TYPE @@@@@@@@@@@@@
IF This.GetColumnName() = "apptmnt_type" THEN  //\/maha 080102 set to pending

	ls_app_type = This.getitemstring(row, "apptmnt_type") //Get Original Appt type, Added by Appeon long.zhang 01.06.2016
	
	this.accepttext()
	
	//Start Code Change ----10.22.2014 #V14.2 maha
	if  this.getitemnumber(row, "active_status") = 6 then
		if data <> "M"  then
			messagebox("MidCycle appointment","The Appointment Type for a MidCycle appointment can only be set to Midcycle.")
			this.setitem(row,"apptmnt_type", "M")
			//return 1
			return 2   //Modified by Harry 10.31.2017 
		end if
	//---------Begin Addeded by (Appeon)Alfee 11.13.2014 (BugA101703)------------
	else 
		if data = "M" then
			messagebox("MidCycle appointment","The Appointment Type for the current record status cannot be set to Midcycle.")
			//------------------- APPEON BEGIN -------------------
			//<$>added:long.zhang 01.06.2016
			//<$>reason:Set right Original Appt type.
			//this.setitem(row,"apptmnt_type", this.getitemstring(row, "apptmnt_type", Primary!, true))
			this.setitem(row,"apptmnt_type", ls_app_type)
			//------------------- APPEON END -------------------
			//return 1
			return 2   //Modified by Harry 10.31.2017 
		end if
	end if
	//---------End Added --------------------------------------------------------------------
	//End Code Change ----10.22.2014
	
	if This.getItemstring( row, "apptmnt_type") = "I" then
		This.setItem( row, "active_status",4)
		of_set_active(4) //maha app080405
	end if
END IF


//@@@@@@@@@@@@@ APP AUDIT TEMPLATE @@@@@@@@@@@@@
IF This.GetColumnName() = "application_audit_facility" AND +&
	( This.GetItemStatus( row, 0, Primary! ) = DataModified!  OR +&
	This.GetItemStatus( row, 0, Primary! ) = NotModified! ) THEN
	
	ll_application_audit_facility_old = this.getitemnumber(this.getrow(),'application_audit_facility')

	integer li_mes
	li_mes = MessageBox("Change Checklist Template", "If you modify the Checklist " +&
				"template, all the data in the current Checklist screen will be lost! "+&
				"  Continue?", Question!, YesNo!, 1 )
				
	if li_mes = 2 then
		this.post event ue_itemchanged(ll_application_audit_facility_old)
	end if
	//---------------------------- APPEON END ----------------------------

END IF

//@@@@@@@@ PARENT FACILITY UPDATES @@@@@@@@@@@@@@@@@@@@

IF This.GetColumnName() = "parent_facility_id" THEN
	li_facility_id = Integer( data )
//Start Code Change ----01.05.2016 #V15 maha - rewrote to add additional data trapping
//Protect against:
//1- Adding an additional current record for a parent
//2- Allow adding a midcycle 
//3- For existing, preventing orphaned History records
//4- Prevent changing a midcycle to another parent with no current record

	li_org_status = This.getItemnumber( row, "active_status")
	
	if li_org_status = 6 then
		lb_midcycle = true
	end if
	
//DUPLICATE CHECK - in the facility list
	FOR i = 1 TO dw_orgs_facilities.RowCount()
		IF dw_orgs_facilities.GetItemNumber(i,  "parent_facility_id" ) = li_facility_id and dw_orgs_facilities.GetItemNumber(i,  "active_status" ) > 0 THEN ////Start Code Change ----07.31.2013 #V14 maha - added active status check
			//li_found++
			IF dw_orgs_facilities.GetItemNumber(i,  "active_status" ) <> 6 THEN li_found++ //(BugA101601) alfee 11.12.2014
		END IF
	END FOR
	
	//NEW records
	IF This.GetItemStatus( row, 0, Primary! ) = New!  OR This.GetItemStatus( row, 0, Primary! ) = NewModified!  THEN
		IF li_found > 0 THEN
		//trap for existing
			li_ans = MessageBox("Parent Facility", "There is already an Appointment Status record assigned to the Parent Facility you have selected.~r~rIf this is a Midcycle Appointment, please click YES;~r~r Otherwise please click No, and select another Parent Facility.", information!,yesno!,2)
			if li_ans = 2 then
				This.SetItem( row, "parent_facility_id", Nullval )		
				Return 2
			else
				lb_midcycle = true	
			end if
		End if

	//CHANGED records
	ELSEIF This.GetItemStatus( row, 0, Primary! ) = DataModified!  OR 	This.GetItemStatus( row, 0, Primary! ) = NotModified!  THEN
		If li_found > 0 THEN   
			if lb_midcycle then
				//ok for midcycle
				This.SetItem( row, "apptmnt_type", 'M')
				This.SetItem( row, "active_status", 6 )
			Else//not midcycle changing an existing record
				MessageBox("Parent Facility", "There is already a Current Appointment Status record assigned to the Parent Facility you have selected.")
				This.SetItem( row, "parent_facility_id", This.getItemnumber( row, "parent_facility_id", primary!, true ) )
				return 2	
			end if
		ElseIF li_found = 0 THEN
			if lb_midcycle then
				//check for other active record
				MessageBox("Parent Facility", "You cannot assign a Midcycle record to a Parent Facility which does not have another current Appointment.")	
				This.SetItem( row, "parent_facility_id", This.getItemnumber( row, "parent_facility_id", primary!, true ) )
				return 2
			else //normal records
				//check for orphaned appointment records	
				if this.rowcount() > 1 then
					MessageBox("Parent Facility", "Additional Appointment Status record(s) are connected to the original Parent Facility, so the parent cannot be changed.  If you wish to connect to an additional Parent Facility, add a new record.")
					This.SetItem( row, "parent_facility_id", This.getItemnumber( row, "parent_facility_id", primary!, true ) )
					return 2
				end if
				//
				li_ans = MessageBox("Change Parent Facility", "Because you are changing the Parent " +&
					"Facility you will have to update the link screens in the Address, Hospital and Board screens.  Continue?", Question!, YesNo!, 1 )
				IF li_ans = 2 THEN
					setitem(row,string(dwo.name),getitemnumber(row,string(dwo.name)))
					Return 2
				END IF
			end if
		End If
		
	END IF
	
	IF This.GetItemStatus( row, 0, Primary! ) = Newmodified!  THEN
//End Code Change ----01.05.2016
		//Start Code Change ----02.16.2011 #V11 maha - added ADDITIONAL DEFAULTS
		SELECT default_audit_temp, default_verif_facility,default_appt_type,default_affil_status, default_user INTO :li_dat, :li_dvf, :ls_atype, :ls_affilstat,:li_userdef FROM facility WHERE facility_id = :li_facility_id;

		//Start Code Change ----10.09.2014 #V14.2 maha - if midcycle don't set the defaults
		if lb_midcycle then  
			ls_atype = "M" 
		else
			This.SetItem( row, "application_audit_facility", li_dat )
			This.SetItem( row, "verifying_facility", li_dvf )
		end if
		
		if isnull( ls_atype) or  ls_atype = "" then  ls_atype = "I"
		
		ls_atype = trim(ls_atype)          //add by stephen 10.19.2012  --BugS101804		
		ls_affilstat = trim(ls_affilstat)     //add by stephen 10.19.2012  --BugS101804	
		
		if isnull(This.getItemstring( row, "apptmnt_type" )) then 	This.SetItem( row, "apptmnt_type", ls_atype )  //Start Code Change ----10.09.2014 #V14.2 maha - midcycle
		if lb_midcycle and This.getItemstring( row, "apptmnt_type" ) <> ls_atype then	This.SetItem( row, "apptmnt_type", ls_atype )  //alfee 11.13.2014 (BugA101703 )

		This.SetItem( row, "affiliation_status", ls_affilstat )
		
		//Start Code Change ----10.09.2014 #V14.2 maha - midcycle
		if ls_atype = "I" then 
			This.SetItem( row, "active_status", 4 )  //Start Code Change ----06.21.2011 #V11 maha - corrected 08.02.2011
		elseif ls_atype = "M" then 
			This.SetItem( row, "active_status", 6 ) 
		end if
		//End Code Change ----10.09.2014 

		if li_userdef = 1 then
			This.SetItem( row, "priority_user", gs_user_id )
		else
			This.SetItem( row, "priority_user", "Public" )
		end if
		//End Code Change ----02.16.2011
	END IF
	
	//COMMITTEES
	gnv_appeondb.of_startqueue()
	
	SELECT Count( committee_id )  
	INTO :li_committee_cnt  
	FROM committee_lookup  
	WHERE committee_lookup.facility_id = :li_facility_id   ;

	gnv_appeondb.of_commitqueue() 

	lds_cred_comms = CREATE n_ds
	lds_cred_comms.DataObject = "d_dddw_credentialing_committees" 
	lds_cred_comms.of_SetTransObject( SQLCA )
	li_num_comms = lds_cred_comms.Retrieve( li_facility_id )
	
	tab_view.tabpage_detail_1.dw_comm_review.GetChild( "committee_id", dwchild )
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve( Integer( data ) )		

	
	IF li_committee_cnt = 0 THEN
		MessageBox("Committee", "The facility that you are selecting has no Committee setup. Go to the facility painter and click on the Committee tab to add a committee.  (System->Painters->Facility Painter)" )
		This.SetItem( row, "parent_facility_id",  nullval )		
		Return 2
	END IF

	li_current_com_rc = tab_view.tabpage_detail_1.dw_comm_review.RowCount()
	FOR cc = 1 TO li_current_com_rc
		tab_view.tabpage_detail_1.dw_comm_review.DeleteRow( 1 )
	END FOR
	long licid
	FOR c = 1 TO li_num_comms
		licid = lds_cred_comms.GetItemNumber( c, "committee_id" )
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> Stephen 06.22.2011
		//$<reason> V11.3 Committee Proc Upd
		li_active = lds_cred_comms.GetItemNumber( c, "active_status" )
		if li_active = 0 then continue
		//---------------------------- APPEON END ----------------------------
		
		li_nr = tab_view.tabpage_detail_1.dw_comm_review.InsertRow( 0 )
		tab_view.tabpage_detail_1.dw_comm_review.SetItem( li_nr, "facility_id", Integer( data ) )
		tab_view.tabpage_detail_1.dw_comm_review.SetItem( li_nr, "committee_id", licid )
		tab_view.tabpage_detail_1.dw_comm_review.SetItem( li_nr, "active_status", 1 )
		tab_view.tabpage_detail_1.dw_comm_review.SetItem( li_nr, "rec_id", il_rec_id )
	END FOR

	DESTROY lds_cred_comms
	
	//DETAIL 2 DATA - STAFF CAT, DEPARTMENT
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
	
	//ATTESTATION QUESTIONS
	//Start Code Change ----11.05.2009 #V10 maha - update attest questions as well.
	c = tab_view.tabpage_quest.dw_quest.RowCount()
	
	FOR i = 1 TO c
		tab_view.tabpage_quest.dw_quest.SetItem( i, "facility_id", li_facility_id )	
	end for
	//End Code Change---11.05.2009
	
	
END IF	


//@@@@@@ VERIFYING FACILITY @@@@@@@@@@@@@
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

	UPDATE verif_info  
	SET facility_id = :li_ver_facility, doc_id = convert(varchar,rec_id) + '-' + convert(varchar,prac_id) + '-' + convert(varchar,:li_ver_facility) + '-' + convert(varchar,seq_no)
	WHERE ( verif_info.prac_id = :il_prac_id ) AND  
         ( verif_info.facility_id = :ii_verifying_facility_id ) AND
			( verif_info.screen_id <> 1 ) AND
         ( verif_info.active_status = 1 );

	IF SQLCA.SQLCODE = -1 THEN
		MessageBox("Database Error", SQLCA.SQLERRTEXT )
	END IF
	ii_verifying_facility_id = li_ver_facility
	w_prac_data_1.ib_verif_info_retrieved = False
	MessageBox("Save Change", "Click on the SAVE button to make changes Permanent." )	
END IF	
	
 
//@@@@@@@@@@@@@ ASSIGNED USER @@@@@@@@@@@@@
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
			//Start Code Change ----07.26.2017 #V154 maha - added recred process message
			if ib_recred then
				li_ans = MessageBox( "Change User", "You are changing the user to which the Action Items will be assigned.  Do you want  the New Action Item records to reflect this change? ", Question!, YesNo!, 1 )
			else
				li_ans = MessageBox( "Change User", "You are changing the user to which the Action Items will be assigned.  Do you want existing Action Item records to reflect this change? ", Question!, YesNo!, 1 )
			end if
			//Start Code Change ----07.26.2017
			IF li_ans = 1 THEN
				//---------Begin Modified by (Appeon)Stephen 07.23.2015 for Audit Trail data for Priority_User is incorrect--------
				/*
				UPDATE verif_info  SET priority_user = :data  
				WHERE ( verif_info.facility_id = :li_ver_facility ) AND  ( verif_info.prac_id = :ll_prac_id ) ;
				
				IF SQLCA.SQLCODE = -1 THEN
					MessageBox( "Database Error", SQLCA.SQLERRTEXT )
					Return
				END IF
				
				This.Update( )
				*/
				 ib_Priority_User = true
				//---------End Modfiied ------------------------------------------------------				
			END IF
		END IF
END IF

//@@@@@@@@@@@@@ PROVISIONAL CHECKBOX @@@@@@@@@@@@@
IF This.GetColumnName() = "prov_status" THEN
	if this.getitemnumber(row,"prov_status") = 0 then
		this.setitem(row,"init_prov_period_from",this.getitemdatetime(row,"apptmnt_start_date"))
		//Start Code Change ----08.17.2011 #V11 maha - mod to allow length of provisional appointment
		li_facility_id = this.getitemnumber(this.getrow(),"parent_facility_id") //maha 081003 to get when entered on a new record
		select prov_years  into :li_years	from facility	where facility_id = :li_facility_id; 
		if isnull(li_years) then li_years = 0
		
		if li_years > 0 then
			ld_apptmnt_start_date = date(this.getitemdatetime(row,'apptmnt_start_date'))
			ld_apptmnt_end_date = inv_datetime.of_relativeyear(ld_apptmnt_start_date, li_years)
			ld_apptmnt_end_date = RelativeDate( ld_apptmnt_end_date, -1 )
			this.setitem(row,"init_prov_period_to",ld_apptmnt_end_date)
		else
			this.setitem(row,"init_prov_period_to",this.getitemdatetime(row,"apptmnt_end_date"))
		end if
		//End Code Change ----08.17.2011
		
	end if
end if

if This.getcolumnname( ) = "init_prov_period_from" then	//added by long.zhang 10.09.2011 bug 2650
		li_facility_id = this.getitemnumber(this.getrow(),"parent_facility_id")
		select prov_years  into :li_years	from facility	where facility_id = :li_facility_id; 
		if isnull(li_years) then li_years = 0
		
		this.accepttext( )
		if li_years > 0 then
			ld_apptmnt_start_date = date(this.GetItemDateTime(row,"init_prov_period_from"))
			ld_apptmnt_end_date = inv_datetime.of_relativeyear(ld_apptmnt_start_date, li_years)
			ld_apptmnt_end_date = RelativeDate( ld_apptmnt_end_date, -1 )
			this.setitem(row,"init_prov_period_to",ld_apptmnt_end_date)
		else
			this.setitem(row,"init_prov_period_to",this.getitemdatetime(row,"apptmnt_end_date"))
		end if
end if

//Added by Appeon long.zhang 09.19.2016 (V15.2 Testing Bug #5331: Red Flag and Standing indicators in the top left corner of the screen do not refresh when data is modified)
if dwo.name = "in_good_standing" then
	ib_in_good_standing_changed = True
End If
	


end event

event retrieveend;call super::retrieveend;IF rowcount > 0 THEN
//	tab_view.tabpage_browse.dw_browse.SelectRow( 0, False )   //Start Code Change ----01.20.2016 #V15 maha - removed
//	tab_view.tabpage_browse.dw_browse.SelectRow(1, True)
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
//	tab_view.tabpage_browse.dw_browse.SelectRow( 0, False )   //Start Code Change ----01.20.2016 #V15 maha - removed
//	tab_view.tabpage_browse.dw_browse.SelectRow( currentrow, True )
	tab_view.tabpage_browse.dw_browse.SetRow( currentrow )
	tab_view.tabpage_browse.dw_browse.ScrollToRow( currentrow )
	
//	tab_view.tabpage_detail_2.dw_cvo.SetRow( currentrow )  //Start Code Change ----11.03.2011 #V12 maha - removed
//	tab_view.tabpage_detail_2.dw_cvo.ScrollToRow( currentrow )  //Start Code Change ----11.03.2011 #V12 maha - removed

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

//------------------- APPEON BEGIN -------------------
//$<modify> Evan 07.10.2009
//$<reason> Saves data first if data is change(Corrected BugA063007)
if this.ModifiedCount() > 0 then
	MessageBox("Save", "Please save data first.")
	Return 0
end if
//------------------- APPEON END ---------------------

Post of_new_record( il_prac_id )

This.SetFocus( )

Return 0


end event

event pfc_postupdate;Integer li_facility_id
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

//
// Add by andy 01/29/2010 V10.1 - Notification Alert
//
n_cst_notification_alert_upd	lnv_na

lnv_na.of_update_alert_records( "pd_affil_stat", This)
// End of add

inv_dataflow[1].of_run_data_flow()  //Start Code Change ----12.02.2014 #V14.2 maha - moved from below to set befor retrieval

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
//	dw_orgs_facilities.SelectRow( 0, False )   //Start Code Change ----01.20.2016 #V15 maha - removed
//	dw_orgs_facilities.SelectRow( li_rec_no, True )
END IF

dw_apptmnt_status.SetFocus()

ii_selected_facility_id = This.GetItemNumber( This.GetRow(), "parent_facility_id" )
//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 08.29.2007 By: Evan
//$<Reason> After update,The dw_orgs_facilities's record doesn't match the dw_apptmnt_status's record on Web
of_retrieve_detail()
//tab_view.tabpage_browse.dw_browse.SelectRow(0, false)   //Start Code Change ----01.20.2016 #V15 maha - removed
//tab_view.tabpage_browse.dw_browse.SelectRow(1, true)
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
	//iw_win.of_setup_title() - commented by alfee 09.30.2010
	iw_win.of_new_prac( "postupdate(appt stat)@" + string(ii_parent_facility_id ))
	
	iw_win.il_affil_rec_id = ll_appt_stat_id //Added by Appeon long.zhang 06.18.2015 (Refresh issue when adding a new provider and completing Case#55391 Bug_Id 4566)
		
	iw_win.of_setup_title() //alfee 09.30.2010
	iw_win.is_prac_title =  iw_win.title  //Start Code Change ----01.25.2014 #V14 maha
	//End Code Change---03.30.2006
end if

if isvalid(iw_win) then //add if statement for bugA111301 -alfee 11.13.2014
	iw_win.uo_app_stat.of_get_status( il_prac_id, ii_parent_facility_id)  //Start Code Change ----06.26.2014 #V14.2 maha -added to change lights
	
	//Added by Appeon long.zhang 09.19.2016,for V15.2 Testing Bug #5331: Red Flag and Standing indicators in the top left corner of the screen do not refresh when data is modified
	If ib_in_good_standing_changed = True Then
		ib_in_good_standing_changed = False
		iw_win.event ue_refresh_dw_standing() 
	End If
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

//run data flow if any - dataflow: alfee 01.07.2010
//inv_dataflow[1].of_run_data_flow()

//Start Code Change ----12.18.2012 #V12 maha - psv data update
of_psv_update( il_prac_id, il_rec_id, ii_selected_facility_id , ii_verifying_facility_id )
//End Code Change ----12.18.2012

//
// Add by andy 01/29/2010 V10.1 - Notification Alert
//
// Because I must check column status in the of_update_alert_records function,
// I unextend ancestor script and call it at last.
Call Super::pfc_postupdate

if ib_new_prac then ib_new_prac = false //alfee 09.30.2010

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
integer	li_facilitys[] , li_audit_facilitys[] , li_audit_rows
Long ll_rec_id
Long ll_action_type
Long ll_action_dept
Long ll_action_status
String ls_action_notes
String ls_app_type
string ls_appt_types[]
string ls_Priority_User 
Date ldt_action_date

Integer li_num_comms
n_ds lds_cred_comms
DataWindowChild dwchild

li_row_cnt = This.RowCount()

//Start Code Change ----01.27.2012 #V12 maha - moved from end of function.
ret = of_validate(this)
if ret = -1 then return -1
//End Code Change ----01.27.2012

//initialize variables for dataflow: alfee 01.07.2010
inv_dataflow[1].of_init_data() 

//MULTIPLE ACTIVE TRAP 020404

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

//PRIMARY DEPARTMENT
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


FOR i = 1 TO li_row_cnt
	ls_appt_types[upperbound(ls_appt_types) + 1] = This.GetItemString( i, "apptmnt_type" )
	//li_facilitys[upperbound(li_facilitys) + 1] = This.GetItemNumber( i, "parent_facility_id" )
//Start Code Change ---- 03.20.2007 #V7 maha  changed because modified logic faulty address link records for all facilities were retrieved at once
//	li_facilitys[upperbound(li_facilitys) + 1] =This.GetItemNumber( i, "parent_facility_id", Primary!, False)
//	li_facilitys[upperbound(li_facilitys) + 1] =This.GetItemNumber( i, "parent_facility_id", Primary!, True)
//End Code Change---03.20.2007
	li_audit_facilitys[upperbound(li_audit_facilitys) + 1] = This.GetItemNumber( i, "application_audit_facility")
Next

ls_appt_types[upperbound(ls_appt_types) + 1] = "B"  //Start Code Change ----09.20.2010 #V10 maha - add both type

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
		ls_app_type = This.GetItemString( i, "apptmnt_type" )

		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 10.13.2006 By: Jack (Inova)
		//$<reason> 
		/*
		IF of_copy_required_data( This.GetItemNumber( i, "application_audit_facility" ), This.GetItemString( i, "apptmnt_type" ) ) = -1 THEN
			Return -1
		END IF
		*/
		IF This.GetItemNumber( i, "application_audit_facility" ) <> - 1 then
			IF of_copy_required_data( This.GetItemNumber( i, "application_audit_facility" ), ls_app_type ) = -1 THEN
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

//		//Start Code Change ----03.17.2014 #V14.2 maha - moved from below //restore to below, by Appeon long.zhang 07.02.2015 (Question on Attestation questions in V14.2)
//		IF ls_app_type = 'I' THEN
//			ret = inv_data_entry.of_generate_attest_questions( "initial", li_new_facility, il_prac_id, il_rec_id )
//			if ret = 1 then ib_retrieve_detail2 = True
//		END iF
//	    //End Code Change ----03.17.2014
	END IF	//new record		
		
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
		
		//---------Begin Added by (Appeon)Stephen 07.23.2015 for V15.1-Additional TDL type of Recruitment Task--------
		if ib_Priority_User = true then
			ls_Priority_User = This.GetItemString( i, "priority_user" ) 
			//Start Code Change ----07.26.2017 #V154 maha - only update active records and the ones just added
//			UPDATE verif_info  SET priority_user = :ls_Priority_User  
//				WHERE ( verif_info.facility_id = :ii_parent_facility_id ) AND  ( verif_info.prac_id = :il_prac_id ) ;
			UPDATE verif_info  SET priority_user = :ls_Priority_User  
				WHERE ( verif_info.facility_id = :ii_parent_facility_id ) AND  ( verif_info.prac_id = :il_prac_id ) and active_status = 1 and CONVERT(varchar,create_Date,111) = CONVERT(varchar,getDate(),111) ;
			//End Code Change ----07.26.2017	
			IF SQLCA.SQLCODE = -1 THEN
				MessageBox( "Database Error", SQLCA.SQLERRTEXT )
			END IF
		end if
		//---------End Added ------------------------------------------------------
		
		IF This.GetItemStatus( i, "parent_facility_id", Primary! ) = DataModified! THEN	//maha v 5.0 0704
			//messagebox("preupdate","change of parent")
			ib_changed_parent_facility = True
			li_facility_id = This.GetItemNumber( i, "parent_facility_id", Primary!, True ) //org value
			li_new_facility = This.GetItemNumber( i, "parent_facility_id", Primary!, False) 
			ll_rec_id = This.GetItemNumber( i, "rec_id")
			
			 //Start Code Change ----12.22.2015 #V15 maha - added trap to protect links if another record for that facility exists
			if this.rowcount() > 1 then
				li_found = this.find( "parent_facility_id = " + string(li_facility_id),1,this.rowcount())
			end if	
			
			if li_found = 0 then
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
			end if
			 //End Code Change ----12.22.2015

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

			UPDATE verif_info  
			SET facility_id = :li_new_facility, 
			direct_parent_facility_link = :li_new_facility, 
			doc_id = convert(varchar,rec_id) + '-' + convert(varchar,prac_id) + '-' + convert(varchar,:li_new_facility) + '-' + convert(varchar,seq_no)
			WHERE ( verif_info.prac_id = :il_prac_id ) AND  
				( verif_info.facility_id = :ii_parent_facility_id ) AND
				( verif_info.screen_id = 1 ) AND
				( verif_info.active_status = 1 );

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
			//\maha	
		
		END IF
		
		//Start Code Change ----08.30.2017 #V154 maha
		IF This.GetItemStatus( i, "apptmnt_start_date", Primary! ) = DataModified!  then
			if  not isnull(This.GetItemdatetime( i, "apptmnt_start_date")) then
				inv_data_entry.of_set_exp_appt_inactive(il_prac_id, ii_parent_facility_id)
			end if
		end if
		//End Code Change ----08.30.2017 	
		
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

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 07.02.2015
//<$>reason:Restore old script for web version. For issue:Question on Attestation questions in V14.2 . 

//Start Code Change ----03.17.2014 #V14.2 maha - moved into new record code above
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
//ret = of_validate(tab_view.tabpage_detail_2.dw_cvo) //maha 071205 validates data in custom fields on detail 2  //Start Code Change ----11.03.2011 #V12 maha - removed
//if ret = -1 then return -1
//End Code Change ----03.17.2014

//------------------- APPEON END -------------------

//01.24.2008 by Jervis Move to here from retrieveend event
if this.getrow() > 0 then //Add by Evan for trap on 03.18.2008
	ii_ori_status = this.Getitemnumber( this.getrow(), 'active_status',primary!,true)
end if

inv_data_entry.of_field_audit( This )

ib_Priority_User =false //(Appeon)Stephen 07.23.2015 - Audit Trail data for Priority_User is incorrect
//keep qualified df ids - dataflow: alfee 12.24.2009
long ll_table_id
ll_table_id = Long(gnv_data.of_getitem("sys_tables", "table_id", "table_name = 'pd_affil_stat'"))
inv_dataflow[1].of_set_data_flow(this, ll_table_id)

RETURN 1
end event

event pfc_deleterow;Integer li_ans
Integer li_rc
Integer i
string ls_mes
integer li_delete = 0
long		ll_CurRow

IF dw_orgs_facilities.RowCount() <= 1 THEN
	if this.rowcount() = 1 then  //Start Code Change ---- 04.05.2006 #400 maha  
		MessageBox("Delete", "You need to have at least one record entered into the Appointment Status Screen." )
		Return 0
	end if
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 12/07/2010 By: Evan
//$<Reason> Fixed BugK051401. For NEW! or NEWModified! Row.
//$<Reason> Need not delete children data and need not add sys_audit record.
Long ll_data_cnt ,ll_data
If This.GetItemStatus(This.GetRow(),0,Primary!) = New!  or This.GetItemStatus(This.GetRow(),0,Primary!) = NewModified! Then
	This.DeleteRow(This.GetRow())		
	Return 0
End If
//---------------------------- APPEON END ----------------------------

if this.rowcount() = 1 then
	ls_mes = "Are you sure you want to delete this Appointment record and all facility specific related data?"
	li_delete = 1
else
	ls_mes = "Are you sure you wish to delete this Appointment record?"
end if
li_ans = MessageBox( "Delete",ls_mes, Question!, YesNo!, 1 )

if li_ans = 2 then return 0

ls_mes = "Improperly deleting Appointment records may cause problems in the practitioner record including the inability to search the provider. ~r ARE YOU SURE YOU WISH TO CONTINUE WITH THE DELETE?"
li_ans = MessageBox( "Delete",ls_mes, Question!, YesNo!, 1 )

IF li_ans = 1 THEN
	//delete child appt records
	li_rc = tab_view.tabpage_detail_2.dw_departments.RowCount()
	FOR i = 1 TO li_rc
		tab_view.tabpage_detail_2.dw_departments.DeleteRow(0) //Modify by Evan 07.10.2009(Corrected BugE060501) --- Changes DeleteRow(i) to DeleteRow(0)
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
		tab_view.tabpage_detail_1.dw_comm_review.DeleteRow(0) //Modify by Evan 07.10.2009(Corrected BugE060501) --- Changes DeleteRow(i) to DeleteRow(0)
	END FOR	
	tab_view.tabpage_detail_1.dw_comm_review.Update()
	
	li_rc = tab_view.tabpage_detail_2.dw_staff_cat.RowCount()
	FOR i = 1 TO li_rc
		tab_view.tabpage_detail_2.dw_staff_cat.DeleteRow(0) //Modify by Evan 07.10.2009(Corrected BugE060501) --- Changes DeleteRow(i) to DeleteRow(0)
	END FOR	
	tab_view.tabpage_detail_2.dw_staff_cat.Update( )	
	
	li_rc = tab_view.tabpage_detail_2.dw_leave.RowCount()
	FOR i = 1 TO li_rc
		tab_view.tabpage_detail_2.dw_leave.DeleteRow(0) //Modify by Evan 07.10.2009(Corrected BugE060501) --- Changes DeleteRow(i) to DeleteRow(0)
	END FOR	
	tab_view.tabpage_detail_2.dw_leave.Update( )
	
	//----Begin Added by alfee 10.08.2016 for the case #00066066 --------
	li_rc = tab_view.tabpage_quest.dw_quest.RowCount()
	FOR i = 1 TO li_rc
		tab_view.tabpage_quest.dw_quest.DeleteRow(0)
	END FOR	
	tab_view.tabpage_quest.dw_quest.Update( )
	//----End Added ---------------------------------------------------------------
	
	if li_delete = 1 then //maha 112204  delete the following data only if the last appt record for that facility.
			//\/maha added 110600
		delete from pd_address_link
		where facility_id = :ii_selected_facility_id and prac_id = :il_prac_id;
		
		delete from pd_questions
		where facility_id = :ii_selected_facility_id and prac_id = :il_prac_id;
		
		//Start Code Change ----11.05.2009 #V10 maha
		delete from pd_attest_questions
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
		//Start Code Change ----10.27.2014 #V14.2 maha
		delete from pd_appl_tracking where prac_id = :il_prac_id and facility_id = :ii_selected_facility_id;
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

event clicked;call super::clicked;//Start Code Change ----02.08.2016 #V15 maha - moved from buttonclicked

string ls_notes

IF dwo.name = 'b_notes' THEN
	ls_notes = This.GetItemString( row, "appt_note" )
	if isnull(ls_notes) then ls_notes = ""
	OpenWithParm( w_ai_notes_new, ls_notes)

	IF Message.StringParm = "Cancel" THEN
		Return -1
	ELSE
		ls_notes = Message.StringParm
		This.SetItem( row, "appt_note", ls_notes )	
	END IF
End if
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

event buttonclicked;call super::buttonclicked;//Start Code Change ----06.06.2011 #V11 maha - Reactive function
integer res
string s
datetime ldt_null //maha 08.12.2014

//Start Code Change ----10.22.2012 #V12 maha - removed as not used
//res =  messagebox("Appointment Reactivation","You are selecting to Reactivate the provider.  This will bring you to the Verifications tab where you should Initiate recredentialing.  Current data will be moved to history, and new Appointment and verification records will be created.  Do you wish to continue?",question!,yesno!,2)
//
//if res = 2 then return
//
//iw_win.tab_1.selecttab(5)
//
//iw_win.tab_1.tabpage_verif.uo_verif_summary.tab_view.tabpage_recred.enabled = true
//iw_win.tab_1.tabpage_verif.uo_verif_summary.tab_view.selecttab(3)

//Start Code Change ----10.22.2012 #V12 maha
//IF dwo.name = 'b_notes' THEN  //Start Code Change ----02.08.2016 #V15 maha - moved to clicked
//
//	//---------Begin Modified by (Appeon)Harry 07.17.2014  for the Bug 4115
//	//OpenWithParm( w_ai_notes_new,   This.GetItemString( row, "appt_note" ))
//	string ls_notes
//	ls_notes = This.GetItemString( row, "appt_note" )
//	if isnull(ls_notes) then ls_notes = ""
//	OpenWithParm( w_ai_notes_new, ls_notes)
//	//---------End Modfiied ------------------------------------------------------
//
//	IF Message.StringParm = "Cancel" THEN
//		Return -1
//	ELSE
//		s = Message.StringParm
//
//		This.SetItem( row, "appt_note", s )	
//	END IF
//End if

//Start Code Change ----08.12.2014 #V14.2 maha
IF dwo.name = 'b_clear' THEN 
	setnull(ldt_null)
	this.setitem(row,"init_prov_period_from", ldt_null)
	this.setitem(row,"init_prov_period_to", ldt_null)
end if

IF dwo.name = 'b_review' THEN 
	open ( w_affil_stat_review_clist)
	 w_affil_stat_review_clist.of_set_vars(il_rec_id  ,il_prac_id , ii_parent_facility_id)
end if
end event

event getfocus;call super::getfocus;//Start Code Change ----03.13.2014 #V14.2 maha
long ll_get
long ll_lose

ll_get = 16120575 //cream
ll_lose = 16114130  //blue

//this.Object.DataWindow.Color = ll_get
//dw_comm_review.Object.DataWindow.Color = ll_lose
//
//gb_comm.backcolor =  ll_lose
end event

event mousemove;//====================================================================
//$<Event>: mousemove
//$<Arguments>:
// 	value    unsignedlong    flags
// 	value    integer         xpos
// 	value    integer         ypos
//$<Return>:  long
//$<Description>: Show Tips , for V14.2 Applause Bug #4828 - Provisional appointment help needs to be wordwrapped for Web deployments
//$<Author>: (Appeon) long.zhang 11.09.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

//Show Tips
String 	ls_object,ls_tips,ls_tip
long		ll_start,ll_end

if ib_ShowTipsHelp then 
	ls_Object = GetObjectAtPointer()
	ls_Object = left(ls_Object,Pos(ls_Object,"~t") -1)

	If is_last_object_tips  = ls_object Then Return 0

	if len(ls_Object)>0 then 
		//Only process 'Tooltip.Enabled = false' objects.
		If	Lower(this.describe(ls_Object + ".Tooltip.Enabled")) = 'true'  or Trim(this.describe(ls_Object + ".Tooltip.Tip")) = '' Then 
			is_last_object_tips  = ls_object
			Return 0
		End If
		
		ls_tip = this.describe(ls_Object + ".Tooltip.Tip")  //the tip contain in .{}
		if len(ls_tip) > 0 then 
			ll_start = Pos(ls_tip,".{")
			if ll_start > 0 then 
				ll_End = Pos(ls_tip,"}.",ll_start)
				if ll_End >0 then 
					ls_tips = mid(ls_tip,ll_start + 2,ll_end - ll_start - 2) 
					iuo_tips.settiptext(this,1,ls_tips)
				else
					iuo_tips.settiptext(this,1,"")
				end if
			else
				iuo_tips.settiptext(this,1,"")
			end if
		else
			iuo_tips.settiptext(this,1,"")
		end if 
	else
		iuo_tips.settiptext(this,1,"")
	end if 
	iuo_tips.relaymsg(this)
	is_last_object_tips  = ls_object 
end if 

end event

type gb_comm from groupbox within tabpage_detail_1
integer x = 9
integer y = 1468
integer width = 3378
integer height = 356
integer taborder = 31
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Committee Review"
end type

type dw_comm_review from u_dw within tabpage_detail_1
integer x = 32
integer y = 1524
integer width = 3328
integer height = 280
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pd_comm_review"
boolean border = false
end type

event pfc_preupdate;call super::pfc_preupdate;Integer li_rc
Integer i
Integer li_facility_id
Long ll_seq_no
integer li_stat

li_rc = This.RowCount( )
if dw_apptmnt_status.GetRow() < 1 then Return 0 //Add by Evan 12.08.2010
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

inv_data_entry.of_field_audit( This ) //Start Code Change ----01.26.2012 #V12 maha

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

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> integer
// $<description> N/A (V11.3 Committee Proc Upd)
//////////////////////////////////////////////////////////////////////
// $<add> 06.23.2011 by Stephen
//////////////////////////////////////////////////////////////////////

long ll_commid
datawindowchild ldwc_meet

if row < 1 then return
ll_commid = this.getitemnumber(row, "committee_id")
this.getchild("meet_sel", ldwc_meet)
ldwc_meet.settransobject(sqlca)
ldwc_meet.retrieve(ll_commid)

this.setrow(row)  //Start Code Change ----01.28.2016 #V15 maha

//------------------- APPEON BEGIN -------------------
//$<add> Stephen 04.06.2012
//$<reason> Committee meeting Approval data -bug id 2992
if string(dwo.name) = 'datawindow' or isnull(dwo.name) then
	this.modify("meet_sel.visible='0'")
	this.modify("meeting_id.visible='1'")  //add by Stephen 04.28.2012 -bug id 2992
else
	this.modify("meet_sel.visible='0~tif(currentrow()=getrow(),1,0)'")
	this.modify("meeting_id.visible='0~tif(currentrow()=getrow(),0,1)'")
end if
//------------------- APPEON END -------------------


end event

event rowfocuschanged;call super::rowfocuschanged;long ll_commid
datawindowchild ldwc_meet

if currentrow < 1 then return
ll_commid = this.getitemnumber(currentrow, "committee_id")
this.getchild("meet_sel", ldwc_meet)
ldwc_meet.settransobject(sqlca)
ldwc_meet.retrieve(ll_commid)
end event

event itemchanged;call super::itemchanged;//////////////////////////////////////////////////////////////////////
// $<event> itemchanged
// $<arguments>
// $<returns> integer
// $<description> N/A (V11.3 Committee Proc Upd)
//////////////////////////////////////////////////////////////////////
// $<add> 06.23.2011 by Stephen
//////////////////////////////////////////////////////////////////////

datawindowchild ldwc_meet
integer li_row, li_active
long    ll_comm_old, ll_null

if row < 1 then return
setnull(ll_null)
choose case dwo.name
	case "committee_id"
		this.getchild("committee_id", ldwc_meet)
		li_row = ldwc_meet.getrow()
		if li_row > 0 then
			li_active = ldwc_meet.getitemnumber(li_row, "active_status")
			if li_active <> 1 then
				ll_comm_old = this.getitemnumber(row , "committee_id", primary!, false)
				messagebox("Prompt", "The committee is Inactive, you cannot select it.")
				this.setitem(row, "committee_id",  ll_comm_old)
				return 2
			end if
		end if
		this.setitem(row, 'meet_sel', ll_null)
		this.setitem(row, 'meeting_id', ll_null)
	case "meet_sel"
		this.setitem(row, "meeting_id", long(data))
end choose


end event

event losefocus;call super::losefocus;//------------------- APPEON BEGIN -------------------
//$<add> Stephen 04.06.2012
//$<reason> Committee meeting Approval data -bug id 2992
this.modify("meet_sel.visible='0'")
this.modify("meeting_id.visible='1'")
//------------------- APPEON END -------------------
end event

event getfocus;call super::getfocus;//Start Code Change ----03.13.2014 #V14.2 maha
long ll_get
long ll_lose

ll_get = 16120575 //cream
ll_lose = 16114130  //blue


//this.Object.DataWindow.Color = ll_get
//dw_apptmnt_status.Object.DataWindow.Color = ll_lose
//
//gb_comm.backcolor =  ll_get
//
end event

event constructor;call super::constructor;this.setrowfocusindicator( p_1)
end event

event buttonclicked;call super::buttonclicked;//Start Code Change ----06.29.2017 #V154 maha
if dwo.name = "b_add" then
	datastore ldw_comm
	integer r
	integer rc
	integer f
	integer nr = 0
	long ll_comm
	
	ldw_comm = create datastore
	ldw_comm.dataobject = "d_committee_setup"
	ldw_comm.settransobject(sqlca)
	rc = ldw_comm.retrieve(ii_parent_facility_id)
	
	for r = 1 to rc
		if ldw_comm.getitemnumber(r, "active_status") = 0 then continue
		ll_comm = ldw_comm.getitemnumber(r, "committee_id")
		
		f = this.find( "committee_id = " + string(ll_comm) , 1, this.rowcount())
		if f = 0 then
			nr = this.insertrow(0)
			this.setitem(nr, "committee_id", ll_comm)
			this.setitem(nr, "facility_id", ii_parent_facility_id)
			this.setitem(nr, "prac_id", il_prac_id)
			this.setitem(nr, "rec_id", il_rec_id)
		end if
	next
	
	if nr = 0 then Messagebox("Missing Committees","No missing Committees found.")
	
end if
		
			
end event

type tabpage_detail_2 from userobject within tab_view
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 3415
integer height = 1852
boolean border = true
long backcolor = 16777215
string text = "Detail 2"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 553648127
dw_leave dw_leave
gb_lea gb_lea
gb_dep gb_dep
gb_cat gb_cat
dw_staff_cat dw_staff_cat
dw_departments dw_departments
end type

on tabpage_detail_2.create
this.dw_leave=create dw_leave
this.gb_lea=create gb_lea
this.gb_dep=create gb_dep
this.gb_cat=create gb_cat
this.dw_staff_cat=create dw_staff_cat
this.dw_departments=create dw_departments
this.Control[]={this.dw_leave,&
this.gb_lea,&
this.gb_dep,&
this.gb_cat,&
this.dw_staff_cat,&
this.dw_departments}
end on

on tabpage_detail_2.destroy
destroy(this.dw_leave)
destroy(this.gb_lea)
destroy(this.gb_dep)
destroy(this.gb_cat)
destroy(this.dw_staff_cat)
destroy(this.dw_departments)
end on

type dw_leave from u_dw within tabpage_detail_2
integer x = 55
integer y = 992
integer width = 3319
integer height = 256
integer taborder = 11
string dataobject = "d_pd_affil_leave"
boolean border = false
end type

event pfc_preupdate;call super::pfc_preupdate;Integer li_rc
Integer i
Integer li_facility_id
Long ll_seq_no

li_rc = This.RowCount( )

//initialize variables for dataflow: alfee 01.07.2010
inv_dataflow[4].of_init_data() 

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

//keep qualified df ids - dataflow: alfee 12.24.2009
long ll_table_id
ll_table_id = Long(gnv_data.of_getitem("sys_tables", "table_id", "table_name = 'pd_affil_staff_leave'"))
inv_dataflow[4].of_set_data_flow(this, ll_table_id)

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

event constructor;call super::constructor;this.setrowfocusindicator( p_1) //Start Code Change ----12.17.2009 #V10 maha
end event

event clicked;call super::clicked; this.getclickedrow( )//Start Code Change ----12.17.2009 #V10 maha
end event

event pfc_postupdate;call super::pfc_postupdate;//run data flow if any - dataflow: alfee 01.07.2010

inv_dataflow[4].of_run_data_flow()

return 1
end event

event getfocus;call super::getfocus;//Start Code Change ----03.13.2014 #V14.2 maha
long ll_get
long ll_lose

//ll_get = 16120575 //cream
//ll_lose = 16114130  //blue
//ll_lose = 15456200
//
//this.Object.DataWindow.Color = ll_get
//dw_departments.Object.DataWindow.Color = ll_lose
//dw_staff_cat.Object.DataWindow.Color = ll_lose
//
//gb_cat.backcolor = ll_lose
//gb_dep.backcolor = ll_lose
//gb_lea.backcolor = ll_get
end event

type gb_lea from groupbox within tabpage_detail_2
integer x = 27
integer y = 932
integer width = 3355
integer height = 356
integer taborder = 21
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 16777215
string text = " Leave of Absence"
end type

type gb_dep from groupbox within tabpage_detail_2
integer x = 27
integer y = 344
integer width = 3355
integer height = 572
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 16777215
string text = "Departments"
end type

type gb_cat from groupbox within tabpage_detail_2
integer x = 27
integer y = 12
integer width = 3355
integer height = 320
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 16777215
string text = "Staff Category"
end type

type dw_staff_cat from u_dw within tabpage_detail_2
integer x = 50
integer y = 60
integer width = 3323
integer height = 240
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pd_affil_staff_cat"
boolean border = false
end type

event pfc_preupdate;call super::pfc_preupdate;Integer li_rc
Integer i
Integer li_facility_id
Long ll_seq_no
integer c = 0
integer li_stat

li_rc = This.RowCount( )

//initialize variables for dataflow: alfee 01.07.2010
inv_dataflow[6].of_init_data() 
if  tab_view.tabpage_detail_1.dw_apptmnt_status.GetRow() < 1 then return -1 //Add by Stephen 05.10.2011 --- Fixed a bug.
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

//keep qualified df ids - dataflow: alfee 12.24.2009
long ll_table_id
ll_table_id = Long(gnv_data.of_getitem("sys_tables", "table_id", "table_name = 'pd_affil_staff_cat'"))
inv_dataflow[6].of_set_data_flow(this, ll_table_id)

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

event itemchanged;call super::itemchanged;debugbreak()
//Start Code Change ----05.10.2010 #V10 maha - added switch option (1) to bypass auto set of the requested status
if of_get_app_setting("set_48","I") = 0 then
	IF This.GetColumnName() = "to_date" THEN //maha 020304
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
end if
//End Code Change---05.10.2010
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

event constructor;call super::constructor;this.setrowfocusindicator( p_1)  //Start Code Change ----12.17.2009 #V10 maha
end event

event clicked;call super::clicked; this.getclickedrow( )//Start Code Change ----12.17.2009 #V10 maha
end event

event pfc_postupdate;call super::pfc_postupdate;//run data flow if any - dataflow: alfee 01.07.2010

inv_dataflow[6].of_run_data_flow()

return 1
end event

event getfocus;call super::getfocus;//Start Code Change ----03.13.2014 #V14.2 maha
long ll_get
long ll_lose

//ll_get = 16120575 //cream
//ll_lose = 16114130  //blue
//ll_lose = 15456200
//
//this.Object.DataWindow.Color = ll_get
//dw_departments.Object.DataWindow.Color = ll_lose
//dw_leave.Object.DataWindow.Color = ll_lose
//
//gb_cat.backcolor = ll_get
//gb_dep.backcolor = ll_lose
//gb_lea.backcolor = ll_lose
end event

type dw_departments from u_dw within tabpage_detail_2
integer x = 55
integer y = 388
integer width = 3305
integer height = 496
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pd_affil_departments"
boolean border = false
end type

event pfc_preupdate;call super::pfc_preupdate;Integer li_rc
Integer i
Integer li_facility_id
Long ll_seq_no
integer li_prim_cnt = 0
integer li_stat

li_rc = This.RowCount( )

//initialize variables for dataflow: alfee 01.07.2010
inv_dataflow[3].of_init_data() 

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
 //Start Code Change ----03.28.2017 #V153 maha
//if this.rowcount() = 1 and This.GetItemStatus( 1, 0, Primary!) = New! THEN li_prim_cnt = 0
if li_prim_cnt = 0 then
	if li_rc = 1 then
		this.setitem(1,"primary_dept", 1)
		li_prim_cnt = 1
	elseif li_rc > 1 then
		messagebox("Primary Department Reminder","You should have one Department record set as the Primary Department.")
	end if
end if
 //End Code Change ----03.28.2017 

if gi_dept_security = 1 then
	if li_prim_cnt = 0 then
		messagebox("Department Level Security Check","You must have a Department record set as the Primary Department.  Changes not saved.")
		return -1
	end if
end if
//End Code Change---02.20.2008
inv_data_entry.of_field_audit( This ) //maha 071102

//keep qualified df ids - dataflow: alfee 12.24.2009
long ll_table_id
ll_table_id = Long(gnv_data.of_getitem("sys_tables", "table_id", "table_name = 'pd_affil_dept'"))
inv_dataflow[3].of_set_data_flow(this, ll_table_id)


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

event constructor;call super::constructor;this.setrowfocusindicator( p_1)  //Start Code Change ----12.17.2009 #V10 maha
end event

event clicked;call super::clicked; this.getclickedrow( )//Start Code Change ----12.17.2009 #V10 maha
end event

event pfc_postupdate;call super::pfc_postupdate;//run data flow if any - dataflow: alfee 01.07.2010
inv_dataflow[3].of_run_data_flow()

return 1
end event

event getfocus;call super::getfocus;//Start Code Change ----03.13.2014 #V14.2 maha
long ll_get
long ll_lose

//ll_get = 16120575 //cream
//ll_lose = 16114130  //blue
//ll_lose = 15456200
//
//this.Object.DataWindow.Color = ll_get
//dw_leave.Object.DataWindow.Color = ll_lose
//dw_staff_cat.Object.DataWindow.Color = ll_lose
//
//gb_cat.backcolor = ll_lose
//gb_dep.backcolor = ll_get
//gb_lea.backcolor = ll_lose
end event

type tabpage_quest from userobject within tab_view
integer x = 18
integer y = 100
integer width = 3415
integer height = 1852
boolean border = true
long backcolor = 32897791
string text = "Attest Quest"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
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
integer height = 1840
integer taborder = 11
string dataobject = "d_attest_quest_appt_stat"
boolean hscrollbar = true
boolean border = false
end type

event constructor;call super::constructor;this.setrowfocusindicator( p_1)
//---------Begin Added by (Appeon)Stephen 08.09.2016 for Bug ID# for Case # 00065693: Extremely slow when adding or modifying the attestation questions --------
If appeongetclienttype() <> 'PB' Then
	this.dataobject = "d_attest_quest_appt_stat_web"
end if
//---------End Added ------------------------------------------------------
end event

event pfc_addrow;//overwrite
integer i
Integer li_retval
integer cnt
long ll_appt_id
long ll_recid

 //Start Code Change ----08.17.2015 #V15 maha - cleaned up old comments after modifying
 
if Upper( This.Describe("DataWindow.ReadOnly") ) = "YES" then
	messagebox("Attestation Questions","You don't have the right of full access to add questions.")
	return -1
end if


this.setredraw(false)

//Start Code Change ---- 01.25.2006 #218 maha
if tab_view.tabpage_detail_1.dw_apptmnt_status.rowcount() < 1 then
	messagebox("Attestation Questions","You cannot add questions until the appointment record has been saved.")
	return -1
end if
//End Code Change---0125.2006 

ll_appt_id = tab_view.tabpage_detail_1.dw_apptmnt_status.getitemnumber(tab_view.tabpage_detail_1.dw_apptmnt_status.getrow(),"rec_id")

inv_data_entry.of_add_questions("APPT",this,ii_selected_facility_id,gl_prac_id,ll_appt_id)	//Start Code Change ----02.25.2009 #V92 maha bug correction changed to ii_selected_facility from ii_parent_facility


If This.Deletedcount() + This.Modifiedcount() = 0 Then
	This.setredraw(true)
	Return 0
End If


 //Start Code Change ----08.17.2015 #V15 maha - corrected issue where a) rec_ids were being overwritten for existing records ands b) rec_id use was ineffeicient 
long ll_rowcount
long ll_recvalue[]
long ll_row[]
long li_row
ll_rowcount = This.Rowcount()

For i = 1 To ll_rowcount
	if isnull(this.getitemnumber(i,"rec_id")) then
		ll_row[upperbound(ll_row) + 1] = i
	end if
next

ll_rowcount = upperbound(ll_row) 

if ll_rowcount > 0 then
	ll_recid = gnv_app.of_get_id("RECORD_ID",this.rowcount()) - 1
	for i = 1 to ll_rowcount
		ll_recid ++
		li_row = ll_row[i]
		this.setitem(li_row ,"rec_id",ll_recid)
	next
end if

this.triggerevent("pfc_preupdate")
 //End Code Change ----08.17.2015 
 
gnv_appeondb.of_startqueue()

this.update()
this.retrieve(ll_appt_id,gs_user_id)

gnv_appeondb.of_commitqueue()

this.setredraw(true)

return 1
end event

event clicked;call super::clicked;integer r
String dwobjectname

r = this.getclickedrow( )
this.setrow(r)

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 01.20.2016
//<$>reason: p_enabled and p_disabled should be where they were placed prior to V14.  For Issue: Q on WebView

////--------------------------- APPEON BEGIN ---------------------------
////$<add> 2007.09.03 By: Frank.Gui
////$<reason> View supporting documentation uploaded from WebView
//IF dwo.name="p_enabled" THEN
//	of_view_supporting_doc(this.getitemnumber(row,"rec_id"))
//END IF
////---------------------------- APPEON END ----------------------------

dwobjectname = This.GetObjectAtPointer()
IF PosA(dwobjectname, "p_enabled") > 0 THEN
	SetPointer (HourGlass!)
	of_view_supporting_doc(this.getitemnumber(row,"rec_id"))
	SetPointer (Arrow!)
END IF
//------------------- APPEON END -------------------
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

event pfc_postupdate;call super::pfc_postupdate;//run data flow if any - dataflow: alfee 01.07.2010

inv_dataflow[5].of_run_data_flow()

return 1
end event

event pfc_preupdate;call super::pfc_preupdate;//initialize variables for dataflow: alfee 01.07.2010
inv_dataflow[5].of_init_data() 

//keep qualified df ids - dataflow: alfee 12.24.2009
long ll_table_id
ll_table_id = Long(gnv_data.of_getitem("sys_tables", "table_id", "table_name = 'pd_attest_questions'"))
inv_dataflow[5].of_set_data_flow(this, ll_table_id)

inv_data_entry.of_field_audit( This )   //Start Code Change ----08.17.2015 #V15 maha

return 1
end event

type tabpage_ofe from userobject within tab_view
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 3415
integer height = 1852
boolean border = true
long backcolor = 32891346
string text = "OPPE/FPPE"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
uo_ofe uo_ofe
end type

on tabpage_ofe.create
this.uo_ofe=create uo_ofe
this.Control[]={this.uo_ofe}
end on

on tabpage_ofe.destroy
destroy(this.uo_ofe)
end on

type uo_ofe from uo_oppe_fppe_evals_appt within tabpage_ofe
integer width = 3401
integer height = 1836
integer taborder = 90
end type

on uo_ofe.destroy
call uo_oppe_fppe_evals_appt::destroy
end on

type p_1 from picture within pfc_cst_u_apptmnt_status
boolean visible = false
integer x = 699
integer y = 1700
integer width = 82
integer height = 64
boolean bringtotop = true
boolean originalsize = true
string picturename = "arrowhead.png"
boolean focusrectangle = false
end type

type dw_facility_add from u_dw within pfc_cst_u_apptmnt_status
boolean visible = false
integer x = 489
integer y = 1860
integer width = 160
integer height = 116
integer taborder = 30
string dataobject = "d_pd_affil_status"
end type

