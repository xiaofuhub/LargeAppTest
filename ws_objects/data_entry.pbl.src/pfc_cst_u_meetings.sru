$PBExportHeader$pfc_cst_u_meetings.sru
forward
global type pfc_cst_u_meetings from userobject
end type
type tab_view from tab within pfc_cst_u_meetings
end type
type tabpage_browse from userobject within tab_view
end type
type cb_2 from commandbutton within tabpage_browse
end type
type dw_facility from u_dw within tabpage_browse
end type
type dw_filter from u_dw within tabpage_browse
end type
type cb_1 from commandbutton within tabpage_browse
end type
type dw_date_range from u_dw within tabpage_browse
end type
type dw_browse from u_dw within tabpage_browse
end type
type gb_2 from groupbox within tabpage_browse
end type
type gb_filter from groupbox within tabpage_browse
end type
type gb_3 from groupbox within tabpage_browse
end type
type dw_select_meeting_type from u_dw within tabpage_browse
end type
type gb_4 from groupbox within tabpage_browse
end type
type tabpage_browse from userobject within tab_view
cb_2 cb_2
dw_facility dw_facility
dw_filter dw_filter
cb_1 cb_1
dw_date_range dw_date_range
dw_browse dw_browse
gb_2 gb_2
gb_filter gb_filter
gb_3 gb_3
dw_select_meeting_type dw_select_meeting_type
gb_4 gb_4
end type
type tabpage_detail from userobject within tab_view
end type
type dw_attendance from u_dw within tabpage_detail
end type
type dw_detail from u_dw within tabpage_detail
end type
type tabpage_detail from userobject within tab_view
dw_attendance dw_attendance
dw_detail dw_detail
end type
type tab_view from tab within pfc_cst_u_meetings
tabpage_browse tabpage_browse
tabpage_detail tabpage_detail
end type
type gb_1 from groupbox within pfc_cst_u_meetings
end type
end forward

global type pfc_cst_u_meetings from userobject
integer width = 3584
integer height = 2080
long backcolor = 16777215
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event pfc_cst_add_cme ( )
event pfc_cst_meeting_report ( )
tab_view tab_view
gb_1 gb_1
end type
global pfc_cst_u_meetings pfc_cst_u_meetings

type variables
Integer ii_selected_facility_id
Integer ii_parent_facility_id

Boolean ib_add_cme = False


Long il_prac_id

String is_status_filter
String is_type_filter
String is_date_filter
String is_sub_filter
String is_sub_filter_field
String is_facility_filter
String is_filter

end variables

forward prototypes
public function integer of_retrieve_detail ()
public function integer of_set_prac_id (long al_prac_id)
public function integer of_retrieve (long al_prac_id)
public function integer of_set_parent_facility_id (integer ai_facility_id)
public function integer of_get_this_facility_data ()
public function integer of_setup_dddw ()
public function integer of_setup_dddw_for_detail ()
public function integer of_filter ()
public function integer of_add_cme ()
public function integer of_report ()
public function integer of_bg_color (long al_rgb)
public function integer of_scroll_oldrow ()
public function integer of_post_resize ()
public subroutine of_zoom ()
end prototypes

event pfc_cst_add_cme();ib_add_cme = True
of_add_cme()

end event

event pfc_cst_meeting_report;of_report()
end event

public function integer of_retrieve_detail ();tab_view.tabpage_browse.dw_browse.Retrieve( il_prac_id, gs_user_id ) //Modify by Evan 04.22.2010 --- add gs_user_id argument
of_setup_dddw()
of_setup_dddw_for_detail()
tab_view.tabpage_browse.dw_browse.setfocus()

Return 0
end function

public function integer of_set_prac_id (long al_prac_id);il_prac_id = al_prac_id


tab_view.tabpage_browse.dw_date_range.Reset()
tab_view.tabpage_browse.dw_date_range.of_SetTransObject( SQLCA )
tab_view.tabpage_browse.dw_date_range.of_SetDropDownCalendar( TRUE )
tab_view.tabpage_browse.dw_date_range.iuo_calendar.of_Register( tab_view.tabpage_browse.dw_date_range.iuo_calendar.DDLB )		

tab_view.tabpage_browse.dw_date_range.InsertRow( 0 )

tab_view.tabpage_browse.dw_date_range.of_SetUpdateAble( False )


Return 0
end function

public function integer of_retrieve (long al_prac_id);//DataWindowChild dwchild
//Long ll_org_id
//
//il_prac_id = al_prac_id
//
//dw_orgs_facilities.Reset()
//dw_orgs_facilities.Retrieve( al_prac_id,gs_user_id )
//tab_view.tabpage_browse.dw_browse.SetFocus()

RETURN 0


end function

public function integer of_set_parent_facility_id (integer ai_facility_id);ii_parent_facility_id = ai_facility_id
ii_selected_facility_id = ai_facility_id

Return 0
end function

public function integer of_get_this_facility_data ();//Integer li_found
//Integer li_rec_no = 0
//
//li_found = dw_orgs_facilities.Find("parent_facility_id = " + String(ii_parent_facility_id), 1, 1000 )
//IF li_found > 0 THEN
//	li_rec_no = li_found
//ELSEIF dw_orgs_facilities.RowCount() > 0 THEN
//	li_rec_no = 1
//END IF
//
//IF li_rec_no > 0 THEN
//	dw_orgs_facilities.ScrollToRow( li_rec_no )
//	dw_orgs_facilities.SetRow( li_rec_no )
//	dw_orgs_facilities.SelectRow( 0, False )
//	dw_orgs_facilities.SelectRow( li_rec_no, True )
//	ii_selected_facility_id = dw_orgs_facilities.GetItemNumber( li_rec_no, "parent_facility_id" )
	of_retrieve_detail(  )	
//END IF


Return 0
end function

public function integer of_setup_dddw ();DataWindowChild dwchild
Integer li_rc


tab_view.tabpage_browse.dw_browse.GetChild("attendence_status", dwchild)
dwchild.SetTransObject( SQLCA )
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<modify> 01.24.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Write script to retrieve data from a cache instead of from the database.

/*
li_rc = dwchild.Retrieve("attendence status")
*/
gnv_data.of_set_dwchild_fromcache('code_lookup' , "upper(lookup_name)='" + upper('attendence status') + "'" , dwchild)
//---------------------------- APPEON END ----------------------------

tab_view.tabpage_browse.dw_browse.GetChild("department", dwchild)
dwchild.SetTransObject( SQLCA )
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02
//$<modify> 01.24.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Write script to retrieve data from a cache instead of from the database.
/*
li_rc = dwchild.Retrieve("department")
*/
gnv_data.of_set_dwchild_fromcache('code_lookup' , "upper(lookup_name)='" + upper('department') + "'" , dwchild)
//---------------------------- APPEON END ----------------------------

tab_view.tabpage_browse.dw_browse.GetChild("section", dwchild)
dwchild.SetTransObject( SQLCA )
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-03
//$<modify> 01.24.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Write script to retrieve data from a cache instead of from the database.
/*
li_rc = dwchild.Retrieve("section")
*/
gnv_data.of_set_dwchild_fromcache('code_lookup' , "upper(lookup_name)='" + upper('section') + "'" , dwchild)
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-04
//$<comment> 01.24.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Move the following script the of_setup_dddw_for_detail function. It can be integrated with other SQL
//$<modification> statements into Appeon Queue labels to reduce client-server interaction. Refer to PT-05 for more information.
/*
tab_view.tabpage_browse.dw_browse.GetChild( "committee", dwchild )
dwchild.SetTransObject( SQLCA )
li_rc = dwchild.Retrieve( ii_selected_facility_id )
IF li_rc = 0 THEN
	dwchild.InsertRow( 0 )
END IF
*/
//---------------------------- APPEON END ----------------------------
//Start Code Change ----10.05.2009 #V92 maha - display code not lookup_code
tab_view.tabpage_browse.dw_browse.GetChild("meetings_cme_category", dwchild)
dwchild.SetTransObject( SQLCA )
gnv_data.of_set_dwchild_fromcache('code_lookup' , "upper(lookup_name)='" + upper('cme category') + "'" , dwchild)
//End Code Change---10.05.2009

//------------------- APPEON BEGIN -------------------
//$<add> Stephen 07.05.2011
//$<reason> add meeting type (V11.3 Meeting Upgrade)
tab_view.tabpage_browse.dw_browse.GetChild("committee_lookup", dwchild)
dwchild.SetTransObject( SQLCA )
gnv_data.of_set_dwchild_fromcache('code_lookup' , "upper(lookup_name)='" + upper('committee') + "'" , dwchild)
//------------------- APPEON END -------------------

Return 0
end function

public function integer of_setup_dddw_for_detail ();

datawindowchild dwchild
Integer li_retval

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-06
//$<add> 01.24.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_startqueue()
//---------------------------- APPEON END ----------------------------

tab_view.tabpage_detail.dw_detail.GetChild("meeting_type", dwchild)
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("meeting type")

tab_view.tabpage_detail.dw_detail.GetChild("location", dwchild)
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("meeting location")

tab_view.tabpage_detail.dw_detail.GetChild("cme_category", dwchild)
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("cme category")

//------------------- APPEON BEGIN -------------------
//$<delete> Stephen 07.05.2011
//$<reason> add fields committee_lookup (V11.3 Meeting Upgrade)
/*echo code
li_retval = tab_view.tabpage_detail.dw_detail.GetChild( "committee", dwchild )
IF li_retval = 1 and tab_view.tabpage_detail.dw_detail.RowCount() > 0 THEN  
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve( ii_selected_facility_id  )
END IF
*/
//------------------- APPEON END -------------------

//------------------- APPEON BEGIN -------------------
//$<add> Stephen 07.05.2011
//$<reason> add fields committee_lookup (V11.3 Meeting Upgrade)
li_retval = tab_view.tabpage_detail.dw_detail.GetChild( "committee_lookup", dwchild )
IF li_retval = 1  THEN
	dwchild.SetTransObject( SQLCA )
	gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper(lookup_name)='" + upper("committee") + "'" , dwchild)
END IF
//------------------- APPEON END -------------------

//------------------- APPEON BEGIN -------------------
//$<delete> Stephen 07.01.2011
//$<reason> Delete fields (V11.3 Meeting Upgrade)
/*
tab_view.tabpage_detail.dw_detail.GetChild("start_time", dwchild)
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("time")

tab_view.tabpage_detail.dw_detail.GetChild("end_time", dwchild)
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("time")

tab_view.tabpage_detail.dw_detail.GetChild("department", dwchild)
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("department")
*/
//------------------- APPEON END -------------------

tab_view.tabpage_detail.dw_detail.GetChild("section", dwchild)
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("section")

tab_view.tabpage_detail.dw_detail.GetChild("facility", dwchild)
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve(gs_user_id)
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-05
//$<add> 01.24.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Add the script from PT-05. And integrate it together with other SQL statements into
//$<modification> Appeon Queue labels to reduce client-server interactions. Refer to PT-04/10 for more information.

//init the DDDW for dw_facility
tab_view.tabpage_browse.dw_facility.GetChild( "facility_id", dwchild )
dwchild.settransobject(SQLCA)
dwchild.retrieve()
//

//init the DDDW for dw_facility
tab_view.tabpage_browse.dw_filter.GetChild( "subject", dwchild )
dwchild.settransobject(SQLCA)
dwchild.retrieve()
//

tab_view.tabpage_browse.dw_browse.GetChild( "committee", dwchild )//* Moved from the function of_setup_dddw
dwchild.SetTransObject( SQLCA ) //*
dwchild.Retrieve( ii_selected_facility_id ) //*
//Add the Appeon queue label
gnv_appeondb.of_commitqueue()

IF dwchild.RowCount() = 0 THEN //*
	dwchild.InsertRow( 0 ) //*
END IF//*

//Init DDDW for dw_facility
tab_view.tabpage_browse.dw_facility.GetChild( "facility_id", dwchild )
dwchild.settransobject(SQLCA)
dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "facility_id", 0 )
dwchild.SetItem( 1, "facility_name", "All" )
tab_view.tabpage_browse.dw_facility.SetItem( 1, "facility_id", 0 )
//---------------------------- APPEON END ----------------------------

tab_view.tabpage_detail.dw_detail.GetChild("facility", dwchild)
dwchild.SetTransObject( SQLCA )
dwchild.insertrow(1)
dwchild.setitem(1,"facility_id",0)
dwchild.setitem(1,"facility_facility_name","No Facility")

Integer li_found
String ls_data
String ls_meeting_type

li_found = tab_view.tabpage_detail.dw_detail.GetChild( "meeting_type", dwchild )

IF tab_view.tabpage_detail.dw_detail.GetColumnName( ) = "meeting_type" THEN
	ls_data = tab_view.tabpage_detail.dw_detail.GetText( )
ELSE
	IF tab_view.tabpage_browse.dw_browse.getrow( ) > 0 THEN
		ls_data = String( tab_view.tabpage_browse.dw_browse.GetItemNumber( tab_view.tabpage_browse.dw_browse.getrow( ), "meeting_type" ) )
	END IF
END IF

// mskinner 19 dec 2005 -- begin
// if ls_date is null return
 if not f_validstr(ls_data) or li_found = -1  then 
	return -1
end if 
li_found = dwchild.Find( "lookup_code = " + ls_data, 1, dwchild.rowcount() )
// mskinner 19 dec 2005 -- end

IF li_found < 1 THEN
	RETURN -1
END IF

ls_meeting_type = dwchild.GetItemString( li_found, "code" )

CHOOSE CASE Upper( ls_meeting_type )
   CASE "CRED COMMITTEE"
		tab_view.tabpage_detail.dw_detail.Object.committee.Visible = "1"			
		tab_view.tabpage_detail.dw_detail.Object.section.Visible = "0"
		tab_view.tabpage_detail.dw_detail.Object.department.Visible = "0"
		tab_view.tabpage_detail.dw_detail.Object.committee_lookup.Visible = "0" // add by Stephen 07-05-2011 add meeting type (V11.3 Meeting Upgrade)
		tab_view.tabpage_detail.dw_detail.Object.label_t.Text = "Cred Committee"
	CASE "DEPARTMENT"
		tab_view.tabpage_detail.dw_detail.Object.committee.Visible = "0"
		tab_view.tabpage_detail.dw_detail.Object.section.Visible = "0"
		tab_view.tabpage_detail.dw_detail.Object.department.Visible = "1"		
		tab_view.tabpage_detail.dw_detail.Object.committee_lookup.Visible = "0" // add by Stephen 07-05-2011 add meeting type (V11.3 Meeting Upgrade)
		tab_view.tabpage_detail.dw_detail.Object.label_t.Text = "Department"		
	CASE "SECTION"
		tab_view.tabpage_detail.dw_detail.Object.committee.Visible = "0"
		tab_view.tabpage_detail.dw_detail.Object.department.Visible = "0"		
		tab_view.tabpage_detail.dw_detail.Object.committee_lookup.Visible = "0" // add by Stephen 07-05-2011 add meeting type (V11.3 Meeting Upgrade)
		tab_view.tabpage_detail.dw_detail.Object.section.Visible = '1'
		tab_view.tabpage_detail.dw_detail.Object.label_t.Text = "Section"	
	CASE "Committee"  // add by Stephen 07-05-2011 add meeting type (V11.3 Meeting Upgrade)
		tab_view.tabpage_detail.dw_detail.Object.committee.Visible = "0"
		tab_view.tabpage_detail.dw_detail.Object.department.Visible = "0"		
		tab_view.tabpage_detail.dw_detail.Object.section.Visible = "0"
		tab_view.tabpage_detail.dw_detail.Object.committee_lookup.Visible = "1"
		tab_view.tabpage_detail.dw_detail.Object.label_t.Text = "Committee"		
  END CHOOSE


RETURN 0

end function

public function integer of_filter ();String ls_filter

IF is_type_filter = "" THEN
	SetNull( is_type_filter )
END IF

IF is_status_filter = "" THEN
	SetNull( is_status_filter )
END IF

IF is_sub_filter = "" THEN
	SetNull( is_sub_filter )
END IF

IF IsNull( is_type_filter ) AND IsNull( is_status_filter ) AND IsNull( is_date_filter ) THEN
	//Return -1 - commented by alfee 06.17.2010
END IF

IF Not IsNull( is_type_filter ) THEN
	ls_filter = is_type_filter
END IF

IF Not IsNull( is_type_filter ) AND Not IsNull( is_status_filter ) THEN
	ls_filter = ls_filter + " AND " + is_status_filter
ELSEIF Not IsNull( is_status_filter ) AND IsNull( is_type_filter ) THEN
	ls_filter = is_status_filter 
END IF

IF Not IsNull( is_date_filter ) AND is_date_filter <> '' THEN
	IF IsNull( is_type_filter ) AND IsNull( is_status_filter ) THEN
		ls_filter = ls_filter + " " + is_date_filter 
	ELSE
		ls_filter = ls_filter + " AND " + is_date_filter 		
	END IF
END IF

//sub filter
IF Not IsNull( is_sub_filter ) AND is_sub_filter <> '' THEN
	IF IsNull( is_type_filter ) AND IsNull( is_status_filter ) AND IsNull( is_date_filter) THEN
		ls_filter = ls_filter + " " + is_sub_filter
	ELSE
		ls_filter = ls_filter + " AND " + is_sub_filter
	END IF	
END IF

//facility filter
IF Not IsNull( is_facility_filter ) AND is_facility_filter <> '' THEN
	IF IsNull( is_type_filter ) AND IsNull( is_status_filter ) AND IsNull( is_date_filter) AND IsNull( is_sub_filter ) THEN
		ls_filter = ls_filter + " " + is_facility_filter
	ELSE
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 01.13.2006 By: Cao YongWang
		//$<reason> Fix a defect in the original unmodified PowerBuilder applciation.
		//ls_filter = ls_filter + " AND " + is_facility_filter
		If LenA(ls_filter) > 0 Then
			ls_filter = ls_filter + " AND " + is_facility_filter
		Else
			ls_filter = is_facility_filter
		End If
		//--------------------------- APPEON END ---------------------------
	END IF	
END IF


tab_view.tabpage_browse.dw_browse.SetFilter( ls_filter )
tab_view.tabpage_browse.dw_browse.Filter()

is_filter = ls_filter

//messagebox("", ls_filter )

Return 0
end function

public function integer of_add_cme ();Integer li_meeting_id
integer s
integer i
DataWindowChild dwchild

if tab_view.selectedtab = 1 then
	tab_view.SelectTab( 2 )
end if
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-07
//$<add> 02.23.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_startqueue()
//---------------------------- APPEON END ----------------------------

tab_view.tabpage_detail.dw_detail.update() //maha071304
tab_view.tabpage_detail.dw_attendance.SetTransObject( SQLCA )
tab_view.tabpage_detail.dw_attendance.update()
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-08
//$<add> 02.23.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
gnv_appeondb.of_commitqueue()
//---------------------------- APPEON END ----------------------------
tab_view.tabpage_detail.dw_detail.Reset()
tab_view.tabpage_detail.dw_detail.DataObject = "d_add_cme_meeting_detail"
tab_view.tabpage_detail.dw_detail.SetTransObject( SQLCA )
tab_view.tabpage_detail.dw_detail.of_SetDropDownCalendar( TRUE )
//tab_view.tabpage_detail.dw_detail.iuo_calendar.of_Register(tab_view.tabpage_detail.dw_detail.iuo_calendar.DDLB)		
//messagebox("s",s)
//messagebox("i",i)
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2005-12-05 By: Zhang Lingping
//$<reason> The dddw need retrieve again after changed the dataobject.
of_setup_dddw()
of_setup_dddw_for_detail()
//---------------------------- APPEON END ----------------------------


tab_view.tabpage_detail.dw_detail.InsertRow( 0 )
tab_view.tabpage_detail.dw_detail.SetRow( 1 )
tab_view.tabpage_detail.dw_detail.SetFocus( )
tab_view.tabpage_detail.dw_detail.SetItem( 1, "meeting_type", 608 )
tab_view.tabpage_detail.dw_detail.SetItem( 1, "location", -77 )
tab_view.tabpage_detail.dw_detail.SetItem( 1, "facility", 0 )
li_meeting_id = gnv_app.of_get_id( "MEETING" )
tab_view.tabpage_detail.dw_detail.SetItem( 1, "meeting_id", li_meeting_id)
//tab_view.tabpage_detail.dw_detail.GetChild("cme_category", dwchild)
//dwchild.SetTransObject( SQLCA )
//dwchild.Retrieve("cme category")

tab_view.tabpage_detail.dw_attendance.SetTransObject( SQLCA )
s = tab_view.tabpage_detail.dw_attendance.InsertRow( 0 )
tab_view.tabpage_detail.dw_attendance.SetItem( s, "meeting_id", li_meeting_id )
tab_view.tabpage_detail.dw_attendance.SetItem( s, "prac_id", il_prac_id )
tab_view.tabpage_detail.dw_attendance.SetItem( s, "attendence_status", 626 )

ib_add_cme = False

Return 1
end function

public function integer of_report ();String ls_retval
String ls_sql
String ls_facility_name
String ls_description
String ls_meeting_type
String ls_date_range
String ls_title
String ls_report_type
Integer li_facility_id
n_ds lds_report
boolean lb_dialog = false

if gi_print_dialog = 1 then  //Start Code Change ----10.03.2011 #V12 maha - for print dialog box
	lb_dialog = true
end if


SetPointer( HourGlass! )

lds_report = CREATE n_ds

ls_meeting_type = String( tab_view.tabpage_browse.dw_select_meeting_type.GetItemNumber( 1, "meeting_type" ) )

IF NOT IsNull( tab_view.tabpage_browse.dw_date_range.GetItemDate( 1, "from" ) ) THEN
	ls_date_range = String( tab_view.tabpage_browse.dw_date_range.GetItemDate( 1, "from" ) ) + " - " + String( tab_view.tabpage_browse.dw_date_range.GetItemDate( 1, "to" ) )
ELSE
	ls_date_range = ""
END IF

CHOOSE CASE ls_meeting_type
	//All
	CASE "0"
		ls_report_type = "Meeting List"
		tab_view.tabpage_browse.dw_browse.Print( True )
		Return 1
	//cme
	CASE "608"
		ls_report_type = "CME Meeting"		
		IF LenA( ls_date_range) > 1 THEN
			ls_description = ls_date_range
		END IF
		lds_report.DataObject = "d_rpt_meetings_cme"
		lds_report.SetTransObject( SQLCA )
		ls_retval = lds_report.Modify( "description_t.text = '" + ls_description + "'" )		
	//committee
	CASE "607"
		ls_report_type = "Committee Meeting"				
		IF LenA( ls_date_range) > 1 THEN
			ls_description = ls_date_range
		END IF
		lds_report.DataObject = "d_rpt_meetings_committee"
		lds_report.SetTransObject( SQLCA )
		ls_retval = lds_report.Modify( "description_t.text = '" + ls_description + "'" )						
	//section
	CASE "606"		
		ls_report_type = "Section Meeting"				
		IF LenA( ls_date_range) > 1 THEN
			ls_description = ls_date_range
		END IF
		lds_report.DataObject = "d_rpt_meetings_section"
		lds_report.SetTransObject( SQLCA )
		ls_retval = lds_report.Modify( "description_t.text = '" + ls_description + "'" )								
	//depart
	CASE "605"		
		ls_report_type = "Department Meeting"				
		IF LenA( ls_date_range) > 1 THEN
			ls_description = ls_date_range
		END IF
		lds_report.DataObject = "d_rpt_meetings_department"
		lds_report.SetTransObject( SQLCA )
		ls_retval = lds_report.Modify( "description_t.text = '" + ls_description + "'" )				
END CHOOSE

ls_sql = lds_report.GetSQLSelect( )

ls_sql = ls_sql + " AND attendence.prac_id = " + String( il_prac_id )

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2005-11-09 By: Cao YongWang
//$<reason> Replaced setsqlselect function with modify function
lds_report.SetSQLSelect( ls_sql )  //Modify by Stephen 05.12.2011 ---abstan double quotation marks  Bug 2402: CMEs not printing .
//---------------------------- APPEON END ----------------------------

lds_report.Retrieve( )

lds_report.SetFilter( is_filter )
lds_report.Filter( )


li_facility_id = tab_view.tabpage_browse.dw_facility.GetItemNumber( 1, "facility_id" )
SELECT facility.facility_name  
INTO :ls_facility_name  
FROM facility  
WHERE facility.facility_id = :li_facility_id   ;

lds_report.Modify( "selected_facility_t.text = '" + ls_facility_name + "'" )

//Start Code Change ----10.03.2011 #V12 maha
lds_report.of_print(true,lb_dialog) //Change the "print" to "of_print" - alfee 01.05.2012
//MessageBox("Report", ls_report_type + " Report Printed." )

DESTROY lds_report;

Return 0
end function

public function integer of_bg_color (long al_rgb);//Start Code Change ----06.09.2010 #V10 maha
this.backcolor = al_rgb
tab_view.backcolor = al_rgb
tab_view.tabpage_browse.backcolor = al_rgb
tab_view.tabpage_detail.backcolor = al_rgb
//alfee 11.18.2010
tab_view.tabpage_browse.gb_2.backcolor = al_rgb
tab_view.tabpage_browse.gb_3.backcolor = al_rgb
tab_view.tabpage_browse.gb_4.backcolor = al_rgb
tab_view.tabpage_browse.gb_filter.backcolor = al_rgb

return 1
end function

public function integer of_scroll_oldrow ();//added by long.zhang 11.13.2012 scroll to originality row of dw_browse BugL103004
	long ll_row
	long ll_meeting_id
	
	ll_row = tab_view.tabpage_detail.dw_detail.getrow( )
	
	if ll_row > 0 and tab_view.tabpage_browse.dw_browse.rowcount( ) > 1 then
		ll_meeting_id =  tab_view.tabpage_detail.dw_detail.getitemnumber( ll_row,"meeting_id")
		ll_row = tab_view.tabpage_browse.dw_browse.find( "meeting_id="+String(ll_meeting_id), 1, tab_view.tabpage_browse.dw_browse.rowcount( ) )
		if ll_row > 0 then
			tab_view.tabpage_browse.dw_browse.scrolltorow( ll_row)
			tab_view.tabpage_browse.dw_browse.selectrow( 0, false)
			tab_view.tabpage_browse.dw_browse.selectrow( ll_row,true)			
		end if
	end if
	
	return 1
end function

public function integer of_post_resize ();//Start Code Change ----02.03.2016 #V15 maha - added
integer li_y

tab_view.tabpage_browse.dw_browse.width = tab_view.width - 35
tab_view.tabpage_detail.dw_detail.width = tab_view.width - 35

li_y = tab_view.tabpage_browse.gb_4.y +  tab_view.tabpage_browse.gb_4.height + 16

tab_view.tabpage_browse.dw_browse.height = tab_view.height - li_y - 108



return 1





end function

public subroutine of_zoom ();//Start Code Change ----07.13.2017 #V154 maha - added for font increase
tab_view.tabpage_browse.dw_browse.Modify("DataWindow.Zoom=" + string(gi_zoom))  
tab_view.tabpage_detail.dw_detail.Modify("DataWindow.Zoom=" + string(gi_zoom))
end subroutine

on pfc_cst_u_meetings.create
this.tab_view=create tab_view
this.gb_1=create gb_1
this.Control[]={this.tab_view,&
this.gb_1}
end on

on pfc_cst_u_meetings.destroy
destroy(this.tab_view)
destroy(this.gb_1)
end on

event constructor;of_zoom()  //Start Code Change ----07.13.2017 #V154 maha
end event

type tab_view from tab within pfc_cst_u_meetings
event create ( )
event destroy ( )
integer x = 18
integer y = 12
integer width = 3502
integer height = 1976
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 16777215
boolean raggedright = true
integer selectedtab = 1
tabpage_browse tabpage_browse
tabpage_detail tabpage_detail
end type

on tab_view.create
this.tabpage_browse=create tabpage_browse
this.tabpage_detail=create tabpage_detail
this.Control[]={this.tabpage_browse,&
this.tabpage_detail}
end on

on tab_view.destroy
destroy(this.tabpage_browse)
destroy(this.tabpage_detail)
end on

event selectionchanging;Long ll_meeting_id
Integer li_row
Integer r

Long li_retval,i
datawindowchild dwchild
//DEBUGBREAK()
IF newindex = 2 THEN
	li_row = tab_view.tabpage_browse.dw_browse.GetRow()
	IF li_row > 0 THEN
		ll_meeting_id = tab_view.tabpage_browse.dw_browse.GetItemNumber( li_row, "meeting_id" )
		IF tab_view.tabpage_browse.dw_browse.GetItemNumber( li_row, "meetings_location" ) = -77 THEN
			tab_view.tabpage_detail.dw_detail.DataObject = "d_add_cme_meeting_detail"
		ELSE
			tab_view.tabpage_detail.dw_detail.DataObject = "d_meeting_pd_folder_detail_new"
		END IF
	ELSE
		tab_view.tabpage_detail.dw_detail.DataObject = "d_add_cme_meeting_detail"
	END IF
	tab_view.tabpage_detail.dw_detail.Reset()
	tab_view.tabpage_detail.dw_detail.of_SetDropDownCalendar( True )
	r = tab_view.tabpage_detail.dw_detail.iuo_calendar.of_Register(tab_view.tabpage_detail.dw_detail.iuo_calendar.DDLB)
	//messagebox("Calendar reg",r)
	tab_view.tabpage_detail.dw_detail.SetTransObject( SQLCA )
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-09
	//$<add> 01.24.2006 By: Cao YongWang
	//$<reason> Performance tuning
	//$<modification> It is unnecessary to retrive data for DDDWs (contained in of_setup_dddw_for_detail)
	//$<modification> and dw_detail when adding a new meeting.
	IF ib_add_cme THEN RETURN
	//--------------------------- APPEON END--- ---------------------------
	
	of_setup_dddw_for_detail()
	tab_view.tabpage_detail.dw_detail.Retrieve( ll_meeting_id )
	
	li_retval = tab_view.tabpage_detail.dw_detail.GetChild( "committee", dwchild )
	IF li_retval = 1 And tab_view.tabpage_detail.dw_detail.RowCount() > 0 THEN
		dwchild.SetTransObject( SQLCA )
		FOR i = 1 To tab_view.tabpage_detail.dw_detail.RowCount()
			dwchild.Retrieve( tab_view.tabpage_detail.dw_detail.GetItemNumber(i, "facility")  )
		NEXT
	END IF	
	
ELSEIF newindex = 1 THEN
	tab_view.tabpage_browse.dw_browse.Retrieve( il_prac_id, gs_user_id ) //Modify by Evan 04.27.2010 --- add gs_user_id argument
	li_retval = tab_view.tabpage_browse.dw_browse.GetChild( "committee", dwchild )
	IF li_retval = 1 And tab_view.tabpage_browse.dw_browse.RowCount() > 0 THEN
		dwchild.SetTransObject( SQLCA )
		FOR i = 1 To tab_view.tabpage_browse.dw_browse.RowCount()
			dwchild.Retrieve( tab_view.tabpage_browse.dw_browse.GetItemNumber(i, "meetings_facility")  )
		NEXT
	END IF
	of_scroll_oldrow()	//long.zhang 11.13.2012 BugL103004
END IF

//Start Code Change ----07.13.2017 #V154 maha - added for font increase  
tab_view.tabpage_detail.dw_detail.Modify("DataWindow.Zoom=" + string(gi_zoom))

end event

event selectionchanged;
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.01.2006 By: Liang QingShi
//$<reason> Fix a defect cuased when optimizing the performance.
//$<modification> Write script to get focus for the first record in dw_browse, so that the record can be deleted by
//$<modification> clicking the Delete button.
If newindex = 1 Then
	tab_view.tabpage_browse.dw_browse.setfocus()
	tab_view.tabpage_browse.dw_browse.setcolumn('attendence_status')
Else
	tab_view.tabpage_detail.dw_detail.setfocus()
End If
//---------------------------- APPEON END ----------------------------

end event

type tabpage_browse from userobject within tab_view
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 3465
integer height = 1860
long backcolor = 16777215
string text = "Browse"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 553648127
cb_2 cb_2
dw_facility dw_facility
dw_filter dw_filter
cb_1 cb_1
dw_date_range dw_date_range
dw_browse dw_browse
gb_2 gb_2
gb_filter gb_filter
gb_3 gb_3
dw_select_meeting_type dw_select_meeting_type
gb_4 gb_4
end type

on tabpage_browse.create
this.cb_2=create cb_2
this.dw_facility=create dw_facility
this.dw_filter=create dw_filter
this.cb_1=create cb_1
this.dw_date_range=create dw_date_range
this.dw_browse=create dw_browse
this.gb_2=create gb_2
this.gb_filter=create gb_filter
this.gb_3=create gb_3
this.dw_select_meeting_type=create dw_select_meeting_type
this.gb_4=create gb_4
this.Control[]={this.cb_2,&
this.dw_facility,&
this.dw_filter,&
this.cb_1,&
this.dw_date_range,&
this.dw_browse,&
this.gb_2,&
this.gb_filter,&
this.gb_3,&
this.dw_select_meeting_type,&
this.gb_4}
end on

on tabpage_browse.destroy
destroy(this.cb_2)
destroy(this.dw_facility)
destroy(this.dw_filter)
destroy(this.cb_1)
destroy(this.dw_date_range)
destroy(this.dw_browse)
destroy(this.gb_2)
destroy(this.gb_filter)
destroy(this.gb_3)
destroy(this.dw_select_meeting_type)
destroy(this.gb_4)
end on

type cb_2 from commandbutton within tabpage_browse
integer x = 3095
integer y = 100
integer width = 174
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Reset"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> integer
// $<description> Add reset button for dates (V11.3 Committee Proc Upd)
//////////////////////////////////////////////////////////////////////
// $<add> 07.08.2011 by Stephen
//////////////////////////////////////////////////////////////////////

dw_date_range.Reset( )
dw_date_range.InsertRow( 0 )
SetNull( is_date_filter )
SetNull( is_status_filter )
cb_1.event clicked()
end event

type dw_facility from u_dw within tabpage_browse
integer x = 741
integer y = 100
integer width = 709
integer height = 80
integer taborder = 70
string dataobject = "d_select_meeting_facility"
boolean vscrollbar = false
boolean border = false
end type

event constructor;call super::constructor;DataWindowChild dwchild

This.SetTransObject( SQLCA )
This.of_SetUpdateAble( False )
This.InsertRow( 0 )

this.object.datawindow.color = gl_bg_color //alfee 11.18.2010
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-10
//$<comment> 02.15.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Move the following script the of_setup_dddw_for_detail function. It can be integrated with other SQL
//$<modification> statements into Appeon Queue labels to reduce client-server interaction. Refer to PT-05 for more information.

/*
This.GetChild( "facility_id", dwchild )
dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "facility_id", 0 )
dwchild.SetItem( 1, "facility_name", "All" )
This.SetItem( 1, "facility_id", 0 )
*/

//---------------------------- APPEON END ----------------------------



end event

event itemchanged;call super::itemchanged;
IF data = "0" THEN
	is_facility_filter = ""
ELSE
	is_facility_filter = "meetings_facility = " + data
END IF

//of_filter()
cb_1.event clicked() //modify by stephen 08.17.2011
end event

type dw_filter from u_dw within tabpage_browse
integer x = 1513
integer y = 100
integer width = 768
integer height = 76
integer taborder = 60
string dataobject = "d_select_meeting_subject"
boolean vscrollbar = false
boolean border = false
end type

event constructor;call super::constructor;This.SetTransObject( SQLCA )
This.of_SetUpdateAble( False )
This.InsertRow( 0 )
This.Enabled = False

this.object.datawindow.color = gl_bg_color //alfee 11.18.2010

end event

event itemchanged;call super::itemchanged;IF data = "0" or data = '' or isnull(data)THEN
	is_sub_filter = ""
ELSE
	IF Upper( is_sub_filter_field ) = "SUBJECT" THEN
		is_sub_filter = is_sub_filter_field + " = '" + data + "'"
	ELSE
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 05.10.2006 By: Liang QingShi
		//$<reason> Fix a Web bug.
		/*
		is_sub_filter = is_sub_filter_field + " = " + data
		*/
		if Not isnull(trim(data)) then
			is_sub_filter = is_sub_filter_field + " = " + data
		else
			is_sub_filter = ""
		end if
		//---------------------------- APPEON END ----------------------------
	END IF
END IF

//of_filter()
cb_1.event clicked() //modify by stephen 08.17.2011
end event

type cb_1 from commandbutton within tabpage_browse
integer x = 3314
integer y = 100
integer width = 114
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Go"
end type

event clicked;String ls_from_date
String ls_to_date

dw_date_range.AcceptText()
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 01/11/2008 By: Ken.Guo
//$<reason> Sometime may set to null.
/*
IF IsNull( dw_date_range.GetItemDate( 1, "from" ) )  THEN
	MessageBox("From Date", "Invalid From date.  Please re-enter." )
	Return 0
END IF

IF IsNull( String( dw_date_range.GetItemDate( 1, "to" ) ) ) THEN
	MessageBox("To Date", "Invalid To date.  Please re-enter." )
	Return 0
END IF
ls_from_date = String( dw_date_range.GetItemDate( 1, "from" ), "mm/dd/yyyy" )
ls_to_date = String( dw_date_range.GetItemDate( 1, "to" ), "mm/dd/yyyy" )
is_date_filter = "( meetings_start_date >= Date('" + ls_from_date + "') AND meetings_start_date <= Date('" + ls_to_date + "') )"
*/
Date ld_from_date,ld_to_date
ld_from_date = dw_date_range.GetItemDate( 1, "from" )
ld_to_date = dw_date_range.GetItemDate( 1, "to" )
ls_from_date = String(ld_from_date,"yyyy-mm-dd") //Must standard format 'yyyy-mm-dd'
ls_to_date = String(ld_to_date,"yyyy-mm-dd")
If isnull(ld_from_date) and not isnull(ld_to_date) Then
	is_date_filter = " (meetings_start_date <= Date('" + ls_to_date + "') )"
ElseIf Isnull(ld_to_date) and not isnull(ld_from_date) Then
	is_date_filter = " (meetings_start_date >= Date('" + ls_from_date + "') )"
ElseIf isnull(ld_from_date) and isnull(ld_to_date) Then
	is_date_filter = ''
Else //Both not null
	is_date_filter = " ( meetings_start_date >= Date('" + ls_from_date + "') AND meetings_start_date <= Date('" + ls_to_date + "') )"
End If
//---------------------------- APPEON END ----------------------------

of_filter()
end event

type dw_date_range from u_dw within tabpage_browse
integer x = 2350
integer y = 100
integer width = 731
integer height = 76
integer taborder = 40
string dataobject = "d_meet_date_range"
boolean vscrollbar = false
boolean border = false
end type

event rbuttondown;call super::rbuttondown;integer col
integer ret
datetime dtn

setnull(dtn)

col = this.getclickedcolumn()


ret = messagebox("Set Null?","Would you like to set this Date to null?",question!,yesno!,2 )

if ret = 1 then
	this.setitem(row,col,dtn)
end if


end event

event constructor;call super::constructor;this.object.datawindow.color = gl_bg_color //alfee 11.18.2010
end event

type dw_browse from u_dw within tabpage_browse
integer x = 9
integer y = 256
integer width = 3429
integer height = 1408
integer taborder = 40
string dataobject = "d_pd_prac_folder_meetings"
boolean hscrollbar = true
end type

event retrieveend;call super::retrieveend;IF rowcount > 0 THEN
	This.SelectRow( 1, True )
END IF
end event

event rowfocuschanged;call super::rowfocuschanged;IF currentrow > 0 THEN
	This.SelectRow( 0, False )
	This.SelectRow( currentrow, True )
END IF

end event

event doubleclicked;tab_view.SelectTab( 2 )
end event

event clicked;call super::clicked;Integer li_row

li_row = This.GetClickedRow( )

IF li_row = 0 THEN
	//Return -1
	return 0 //Allow drag to resize a column, Modified by Appeon long.zhang 01.08.2016 (BugL010806)
END IF

This.SelectRow( 0, False )
This.SelectRow( li_row, True )
This.ScrollToRow( li_row )
This.SetRow( li_row )
end event

event constructor;call super::constructor;This.of_SetTransObject( SQLCA )

end event

type gb_2 from groupbox within tabpage_browse
integer x = 727
integer y = 48
integer width = 759
integer height = 156
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 16777215
string text = "Facility"
end type

type gb_filter from groupbox within tabpage_browse
integer x = 1499
integer y = 48
integer width = 805
integer height = 156
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 16777215
string text = "No Sub Filter"
end type

type gb_3 from groupbox within tabpage_browse
integer x = 2331
integer y = 48
integer width = 969
integer height = 156
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 16777215
string text = "Date Range"
end type

type dw_select_meeting_type from u_dw within tabpage_browse
integer x = 14
integer y = 48
integer width = 713
integer height = 176
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_select_meeting_type"
boolean vscrollbar = false
boolean border = false
end type

event constructor;This.of_SetTransObject( SQLCA )
This.of_SetUpdateAble( False )
This.of_SetTransObject( SQLCA )
This.InsertRow( 0 )

DataWindowChild dwchild

This.GetChild("meeting_type", dwchild)
dwchild.SetTransObject( SQLCA )
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-11
//$<comment> 02.15.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Write script to retrieve data from a cache instead of from the database.

/*
dwchild.Retrieve("meeting type")
*/
gnv_data.of_set_dwchild_fromcache("code_lookup", "upper(lookup_name)='" + upper('meeting type') + "'", dwchild)
//---------------------------- APPEON END ----------------------------
dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "lookup_code", 0 )
dwchild.SetItem( 1, "description", "All Meetings" )
dwchild.SetItem( 1, "code", "All" )

This.SetItem( 1, "meeting_type", 0 )

this.object.datawindow.color = gl_bg_color //alfee 11.18.2010
end event

event itemchanged;call super::itemchanged;DataWindowChild dwchild
		
IF data = "0" THEN
	is_type_filter = ""
ELSE
	is_type_filter = "meeting_type = " + data
END IF

SetNull( is_sub_filter )
dw_filter.Enabled = True
dw_facility.Enabled = True
dw_filter.Modify( "facility_id.background.color = '16777215' " )
dw_facility.Modify( "facility_id.background.color = '16777215' " )
//dw_orgs_facilities.SelectRow( ii_selected_facility_id,  True )
//dw_orgs_facilities.Modify( "parent_facility.color = '0'" )

CHOOSE CASE data
	//All
	CASE "0"
		dw_filter.Enabled = False		
		dw_filter.DeleteRow( 0 )
		gb_filter.Text = ""		
		SetNull( is_date_filter )
		SetNull( is_status_filter )
		SetNull( is_sub_filter )
		SetNull( is_sub_filter_field )
		SetNull( is_facility_filter )		
		SetNull( is_filter )
		gb_filter.Text = "No Sub Filter"				
		tab_view.tabpage_browse.dw_browse.SetFilter( "" )
		tab_view.tabpage_browse.dw_browse.Filter()
		dw_facility.SetItem( 1, "facility_id", 0 )
		//dw_facility.Enabled = False - commented by alfee 06.17.2010
		dw_filter.DataObject = "d_select_meeting_subject"
		dw_filter.SetTransObject( SQLCA )
		dw_filter.ReSet()
		dw_filter.InsertRow( 0 )
		dw_filter.Enabled = False
		//dw_facility.Enabled = False - commented by alfee 06.17.2010
		dw_filter.Modify( "#1.background.color = '12632256' " )		
		//dw_facility.Modify( "facility_id.background.color = '12632256' " )	 - commented by alfee 06.17.2010
	//cme
	CASE "608"
		//dw_orgs_facilities.Modify( "parent_facility.color = '8421504'" )
		//dw_orgs_facilities.SelectRow( 0, False )
		//dw_orgs_facilities.Enabled = False
		SetNull( is_facility_filter )				
		dw_facility.SetItem( 1, "facility_id", 0 )		
		is_sub_filter_field = "subject"
		dw_filter.DataObject = "d_select_meeting_subject"
		dw_filter.SetTransObject( SQLCA )
		dw_filter.ReSet()
		dw_filter.InsertRow( 0 )
		dw_filter.GetChild( "subject", dwchild )
		dwchild.InsertRow( 1 )
		gb_filter.Text = "Subject"
		//dw_facility.Enabled = False - commented by alfee 06.17.2010
		//dw_facility.Modify( "facility_id.background.color = '12632256' " )	 - commented by alfee 06.17.2010
	//committee
	CASE "607"
		is_sub_filter_field = "Committee"		
		dw_filter.DataObject = "d_select_meeting_committee"		
		dw_filter.SetTransObject( SQLCA )
		dw_filter.ReSet()
		dw_filter.InsertRow( 0 )		
		dw_filter.GetChild( "committee", dwchild )
		dwchild.SetTransObject( SQLCA )
		dwchild.Retrieve( ii_selected_facility_id )
		gb_filter.Text = "Cred Committee"		
		dwchild.InsertRow( 1 )
		dw_facility.Enabled = True		
	//section
	CASE "606"		
		is_sub_filter_field = "section"		
		dw_filter.DataObject = "d_select_meeting_section"		
		dw_filter.SetTransObject( SQLCA )
		dw_filter.ReSet()
		dw_filter.InsertRow( 0 )	
		gb_filter.Text = "Section"		
		dw_filter.GetChild( "section", dwchild )
		dwchild.InsertRow( 1 )		
		dw_facility.Enabled = True		
	//depart
	CASE "605"		
		is_sub_filter_field = "department"		
		dw_filter.DataObject = "d_select_meeting_deparment"		
		dw_filter.SetTransObject( SQLCA )
		dw_filter.ReSet()
		dw_filter.InsertRow( 0 )	
		gb_filter.Text = "Department"		
		dw_filter.GetChild( "department", dwchild )
		dwchild.InsertRow( 1 )		
		dw_facility.Enabled = True	
	//Committee meeting 
	CASE "-78"		
		is_sub_filter_field = "committee_lookup"		
		dw_filter.DataObject = "d_select_meeting_look_committee"		
		dw_filter.SetTransObject( SQLCA )
		dw_filter.ReSet()
		dw_filter.InsertRow( 0 )	
		gb_filter.Text = "COMMITTEE"		
		dw_filter.GetChild( "committee", dwchild )
		dwchild.settransobject(sqlca)
		gnv_data.of_set_dwchild_fromcache("code_lookup", "upper(lookup_name)='" + upper('committee') + "'", dwchild)
		dwchild.InsertRow( 1 )		
		dw_facility.Enabled = True		
END CHOOSE

dw_filter.object.datawindow.color = gl_bg_color //alfee 11.18.2010

//dw_filter.SetItem( 1, is_sub_filter_field, 0 )

//------------------- APPEON BEGIN -------------------
//$<delete> Stephen 07.07.2011
//$<reason> Add reset button for dates (V11.3 Meeting Upgrade)
/*
dw_date_range.Reset( )
dw_date_range.InsertRow( 0 )
SetNull( is_date_filter )
SetNull( is_status_filter )
*/
//------------------- APPEON END -------------------

//of_filter()
cb_1.event clicked() //modify by stephen 08.17.2011
end event

type gb_4 from groupbox within tabpage_browse
integer y = 4
integer width = 3461
integer height = 236
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 16777215
string text = "Filter"
borderstyle borderstyle = stylebox!
end type

type tabpage_detail from userobject within tab_view
integer x = 18
integer y = 100
integer width = 3465
integer height = 1860
long backcolor = 16777215
string text = "Detail"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 553648127
dw_attendance dw_attendance
dw_detail dw_detail
end type

on tabpage_detail.create
this.dw_attendance=create dw_attendance
this.dw_detail=create dw_detail
this.Control[]={this.dw_attendance,&
this.dw_detail}
end on

on tabpage_detail.destroy
destroy(this.dw_attendance)
destroy(this.dw_detail)
end on

type dw_attendance from u_dw within tabpage_detail
boolean visible = false
integer x = 1216
integer y = 1148
integer width = 1070
integer height = 316
integer taborder = 11
string dataobject = "d_meeting_attendence"
end type

type dw_detail from u_dw within tabpage_detail
integer y = 4
integer width = 3456
integer height = 1824
integer taborder = 30
string dataobject = "d_meeting_pd_folder_detail_new"
boolean hscrollbar = true
boolean border = false
end type

event constructor;This.of_SetTransObject( SQLCA )
this.of_SetDropDownCalendar( TRUE )
this.iuo_calendar.of_Register(this.iuo_calendar.DDLB)

end event

event pfc_postupdate;call super::pfc_postupdate;//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-12
//$<modify> 01.24.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Directly copy the following two pieces script from of_retrieve_detail
//$<modification> instead of calling of_retrieve_detail(). This modification reduces two times of 
//$<modification> client-server interactions.
/*
of_retrieve_detail( )
*/
tab_view.tabpage_browse.dw_browse.Retrieve( il_prac_id, gs_user_id ) //Modify by Evan 04.27.2010 --- add gs_user_id argument
tab_view.tabpage_browse.dw_browse.setfocus()
//--------------------------- APPEON END ---------------------------
of_filter()

Return 1
end event

type gb_1 from groupbox within pfc_cst_u_meetings
integer x = 1637
integer y = 68
integer width = 818
integer height = 160
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 12632256
string text = "Record Type"
end type

