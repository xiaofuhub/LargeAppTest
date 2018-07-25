$PBExportHeader$w_meeting_detail.srw
forward
global type w_meeting_detail from w_response
end type
type cb_wv_link from commandbutton within w_meeting_detail
end type
type cb_view_meeting from commandbutton within w_meeting_detail
end type
type cb_viewdoc from commandbutton within w_meeting_detail
end type
type cb_adddoc from commandbutton within w_meeting_detail
end type
type cb_committee_mem from u_cb within w_meeting_detail
end type
type cb_1 from u_cb within w_meeting_detail
end type
type cb_del_all from u_cb within w_meeting_detail
end type
type cb_non_prac from u_cb within w_meeting_detail
end type
type dw_list from u_dw within w_meeting_detail
end type
type dw_detail from u_dw within w_meeting_detail
end type
type dw_attendees from u_dw within w_meeting_detail
end type
type st_date from statictext within w_meeting_detail
end type
type st_1 from statictext within w_meeting_detail
end type
type cb_attend from u_cb within w_meeting_detail
end type
type cb_del_attend from u_cb within w_meeting_detail
end type
type cb_delete from u_cb within w_meeting_detail
end type
type cb_add_meet from u_cb within w_meeting_detail
end type
type cb_5 from u_cb within w_meeting_detail
end type
type cb_roster from u_cb within w_meeting_detail
end type
type cb_print_meeting from u_cb within w_meeting_detail
end type
type cb_save from u_cb within w_meeting_detail
end type
type st_2 from statictext within w_meeting_detail
end type
type st_3 from statictext within w_meeting_detail
end type
type cb_documents from u_cb within w_meeting_detail
end type
type dw_roster from u_dw within w_meeting_detail
end type
type cb_batch from u_cb within w_meeting_detail
end type
type cb_copy from commandbutton within w_meeting_detail
end type
type cb_post from u_cb within w_meeting_detail
end type
end forward

global type w_meeting_detail from w_response
integer x = 37
integer y = 236
integer width = 3598
integer height = 2300
boolean controlmenu = false
long backcolor = 33551856
cb_wv_link cb_wv_link
cb_view_meeting cb_view_meeting
cb_viewdoc cb_viewdoc
cb_adddoc cb_adddoc
cb_committee_mem cb_committee_mem
cb_1 cb_1
cb_del_all cb_del_all
cb_non_prac cb_non_prac
dw_list dw_list
dw_detail dw_detail
dw_attendees dw_attendees
st_date st_date
st_1 st_1
cb_attend cb_attend
cb_del_attend cb_del_attend
cb_delete cb_delete
cb_add_meet cb_add_meet
cb_5 cb_5
cb_roster cb_roster
cb_print_meeting cb_print_meeting
cb_save cb_save
st_2 st_2
st_3 st_3
cb_documents cb_documents
dw_roster dw_roster
cb_batch cb_batch
cb_copy cb_copy
cb_post cb_post
end type
global w_meeting_detail w_meeting_detail

type variables
Integer ii_meeting_id

DateTime idt_date

Boolean ib_new = FALSE

long	 il_facility_id		//Added by Scofield on 2008-09-22

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-10-08 By: Rodger Wu (Inova)
//$<reason> Default search facility id of current user.
Long il_default_facility = 0
//---------------------------- APPEON END ----------------------------

end variables

forward prototypes
public function integer of_setup_dddw ()
public function integer of_setup_taborder ()
public function integer wf_copy_detail ()
public function integer of_batch_add ()
public function integer of_meeting_security ()
public function integer wf_get_image (string as_type, long al_facility, long al_recid)
public function integer of_meeting_view_buttons ()
public function integer of_shellexecute_file (string as_file)
end prototypes

public function integer of_setup_dddw ();datawindowchild dwchild

if dw_detail.getrow() < 1 then return -1  //Start Code Change ----01.03.2008 #V8 maha - trap for clicking between dates
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<add> 01.17.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Write script tp retrieve data from a cache instead of from database.
/*
dw_detail.GetChild("meeting_type", dwchild)
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("meeting type")

dw_list.GetChild("meeting_type", dwchild)
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("meeting type")

dw_detail.GetChild("location", dwchild)
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("meeting location")

dw_detail.GetChild("cme_category", dwchild)
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("cme category")

dw_detail.GetChild( "committee", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve( dw_detail.GetItemNumber( dw_detail.getrow(), "facility")  )

//dw_detail.GetChild("facility", dwchild)
//dwchild.SetTransObject( SQLCA )
//dwchild.Retrieve("facility")

dw_detail.GetChild("start_time", dwchild)
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("time")
dwchild.setsort( "custom_5")
dwchild.sort()

dw_detail.GetChild("end_time", dwchild)
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("time")
dwchild.setsort( "custom_5")
dwchild.sort()

dw_list.GetChild("start_time", dwchild)
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("time")

dw_list.GetChild("end_time", dwchild)
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("time")

dw_attendees.GetChild("attendence_status", dwchild)
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("attendence status")

dw_detail.GetChild("department", dwchild)
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("department")

dw_detail.GetChild("section", dwchild)
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("section")
*/
dw_detail.GetChild("meeting_type", dwchild)
dwchild.SetTransObject( SQLCA )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper(lookup_name)='" + upper("meeting type") + "'" , dwchild)

dw_list.GetChild("meeting_type", dwchild)
dwchild.SetTransObject( SQLCA )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper(lookup_name)='" + upper("meeting type") + "'" , dwchild)

dw_detail.GetChild("location", dwchild)
dwchild.SetTransObject( SQLCA )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper(lookup_name)='" + upper("meeting location") + "'" , dwchild)

dw_detail.GetChild("cme_category", dwchild)
dwchild.SetTransObject( SQLCA )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper(lookup_name)='" + upper("cme category") + "'" , dwchild)

dw_attendees.GetChild("attendence_status", dwchild)
dwchild.SetTransObject( SQLCA )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper(lookup_name)='" + upper("attendence status") + "'" , dwchild)

dw_detail.GetChild("department", dwchild)
dwchild.SetTransObject( SQLCA )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper(lookup_name)='" + upper("department") + "'" , dwchild)

dw_detail.GetChild("section", dwchild)
dwchild.SetTransObject( SQLCA )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper(lookup_name)='" + upper("section") + "'" , dwchild)

gnv_appeondb.of_startqueue()

dw_detail.GetChild( "committee", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve( dw_detail.GetItemNumber( dw_detail.getrow(), "facility")  )

//------------------- APPEON BEGIN -------------------
//$<modify> Stephen 07.01.2011
//$<reason> Add fields (V11.3 Meeting Upgrade)
/*
dw_detail.GetChild("start_time", dwchild)
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("time")
dwchild.setsort( "custom_5")
dwchild.sort()

dw_detail.GetChild("end_time", dwchild)
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("time")
dwchild.setsort( "custom_5")
dwchild.sort()

dw_list.GetChild("start_time", dwchild)
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("time")

dw_list.GetChild("end_time", dwchild)
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("time")
*/

dw_detail.GetChild("start_at", dwchild)
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("time")
dwchild.setsort( "custom_5")
dwchild.sort()

dw_detail.GetChild("end_at", dwchild)
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("time")
dwchild.setsort( "custom_5")
dwchild.sort()

dw_list.GetChild("start_at", dwchild)
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("time")

dw_list.GetChild("end_at", dwchild)
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("time")

dw_detail.GetChild("committee_lookup", dwchild)
dwchild.SetTransObject( SQLCA )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper(lookup_name)='" + upper("committee") + "'" , dwchild)
//------------------- APPEON END -------------------

gnv_appeondb.of_commitqueue()
//---------------------------- APPEON END ----------------------------

RETURN 0
end function

public function integer of_setup_taborder ();DataWindowChild dwchild
Integer 	li_found
Integer 	nullval
Integer 	row
String 	ls_data
String 	ls_meeting_type,ls_CmePresenter,ls_CmeAffiliation
decimal	ldc_CmeCredits,ldc_CmeCategory
long		ll_Committee

row = dw_detail.GetRow( )
IF row < 1 THEN
	RETURN -1
END IF

dw_detail.GetChild( "meeting_type", dwchild )
//from the meeting type get the lookup's code
IF dw_detail.GetColumnName( ) = "meeting_type" THEN
	ls_data = dw_detail.GetText( )
ELSE
	ls_data = String( dw_detail.GetItemNumber( row, "meeting_type" ) )
END IF

li_found = dwchild.Find( "lookup_code = " + ls_data, 1, 100 )
IF li_found < 1 THEN
	RETURN -1
END IF
ls_meeting_type = dwchild.GetItemString( li_found, "code" )
	
//dw_detail.Object.committee.dddw.required = 'No'	
//dw_detail.Object.department.dddw.required = 'No'
//dw_detail.Object.section.dddw.required = 'No'		
	
CHOOSE CASE Upper( ls_meeting_type )
   CASE "CME"
	   dw_detail.Object.cme_credits.Background.Color = RGB( 255, 255, 255 )
	   dw_detail.Object.cme_category.Background.Color = RGB( 255, 255, 255 )
	   dw_detail.Object.cme_presenter.Background.Color = RGB( 255, 255, 255 )
	   dw_detail.Object.cme_affiliation.Background.Color = RGB( 255, 255, 255 )
		dw_detail.Object.cme_credits.TabSequence = 110
		dw_detail.Object.cme_category.TabSequence = 120
		dw_detail.Object.cme_presenter.TabSequence = 130		
		dw_detail.Object.cme_affiliation.TabSequence = 140	
		dw_detail.Object.department.Visible = "0"
		dw_detail.Object.section.Visible = "0"
		dw_detail.Object.section.TabSequence = 0
		dw_detail.Object.committee_lookup.Visible = "0"            // add by Stephen 07-04-2011 (V11.3 Meeting Upgrade)
		dw_detail.Object.label_t.Visible = "0" //Start Code Change ----04.21.2008 #V8 maha - made invisible
		dw_detail.Object.committee.Visible = "0"  //Start Code Change ----04.21.2008 #V8 maha - made invisible
		cb_committee_mem.enabled = false
		//dw_detail.Object.section.Background.Color = RGB( 255, 255, 255 )
		dw_detail.Object.department.TabSequence = 0
		//dw_detail.Object.department.TabSequence = 0
		of_setup_dddw( )			
	CASE "CRED COMMITTEE" //,"COMMITTEE"    // delete by Stephen 07-05-2011
		dw_detail.Object.committee.Visible = "1"	
		cb_committee_mem.enabled = true
	   dw_detail.Object.committee.Background.Color = RGB( 255, 255, 255 )		
		dw_detail.Object.committee.TabSequence = 90
		dw_detail.Object.section.Visible = "0"
		dw_detail.Object.department.Visible = "0"
		dw_detail.Object.committee_lookup.Visible = 0            // add by Stephen 07-04-2011 add meeting type (V11.3 Meeting Upgrade)
		dw_detail.Object.label_t.Text = ls_meeting_type
		dw_detail.Object.label_t.Visible = "1"
	//	dw_detail.Object.committee.dddw.required = 'Yes'			
		of_setup_dddw( )
	CASE "DEPARTMENT"
		dw_detail.Object.committee.Visible = "0"
		cb_committee_mem.enabled = false
		dw_detail.Object.section.Visible = "0"
		dw_detail.Object.committee_lookup.Visible = 0            // add by Stephen 07-04-2011 add meeting type (V11.3 Meeting Upgrade)
		dw_detail.Object.department.Visible = "1"			
		dw_detail.Object.department.TabSequence = 90				
		dw_detail.Object.label_t.Text = ls_meeting_type	
		dw_detail.Object.label_t.Visible = "1"
	//	dw_detail.Object.department.dddw.required = 'Yes'		
	CASE "SECTION"
		dw_detail.Object.committee.Visible = 0
		cb_committee_mem.enabled = false
		dw_detail.Object.department.Visible = 0		
		dw_detail.Object.committee_lookup.Visible = 0            // add by Stephen 07-04-2011 add meeting type (V11.3 Meeting Upgrade)
		dw_detail.Object.section.Visible = '1'
		dw_detail.Object.section.TabSequence = 90
		dw_detail.Object.label_t.Text = ls_meeting_type	
		dw_detail.Object.label_t.Visible = "1"
	//	dw_detail.Object.section.dddw.required = 'Yes'
//Start Code Change ----04.03.2008 #V8 maha - changed to else from 'Other' for any other meeting types;  removed previous else code
    	CASE "COMMITTEE"   // add by Stephen 07-04-2011 add meeting type (V11.3 Meeting Upgrade)
		dw_detail.Object.committee.Visible = 0
		cb_committee_mem.enabled = false
		dw_detail.Object.department.Visible = 0		
		dw_detail.Object.committee_lookup.Visible = 1           
		dw_detail.Object.section.Visible = 0
		dw_detail.Object.committee_lookup.TabSequence = 90
		dw_detail.Object.label_t.Text = ls_meeting_type	
		dw_detail.Object.label_t.Visible = "1"
	CASE Else
	//CASE "OTHER"
		dw_detail.Object.committee.Visible = "0"			
	    dw_detail.Object.committee.Background.Color = RGB( 255, 255, 255 )		
		dw_detail.Object.committee.TabSequence = 90
		dw_detail.Object.section.Visible = "0"
		dw_detail.Object.department.Visible = "0"
		dw_detail.Object.committee_lookup.Visible = "0"            // add by Stephen 07-04-2011 add meeting (V11.3 Meeting Upgrade)
		dw_detail.Object.label_t.Visible = "0"
	//	dw_detail.Object.committee.dddw.required = 'Yes'			
		of_setup_dddw( )
//End Code Change---04.03.2008
		
END CHOOSE

SetNull(nullval)
IF Upper( ls_meeting_type ) <> "CME" THEN
	dw_detail.Object.cme_credits.Background.Color = RGB( 192, 192, 192 )
	dw_detail.Object.cme_credits.TabSequence = 0
	ldc_CmeCredits = dw_Detail.GetItemDecimal(row,"cme_credits")									//Added by Scofield on 2008-09-22
	if Not IsNull(ldc_CmeCredits) then dw_detail.SetItem( row, "cme_credits",  nullval)
	
	dw_detail.Object.cme_category.Background.Color = RGB( 192, 192, 192 )
	dw_detail.Object.cme_category.TabSequence = 0
	ldc_CmeCategory = dw_Detail.GetItemDecimal(row,"cme_category")									//Added by Scofield on 2008-09-22
	if Not IsNull(ldc_CmeCategory) then dw_detail.SetItem( row, "cme_category", nullval)
	
	dw_detail.Object.cme_presenter.Background.Color = RGB( 192, 192, 192 )
	dw_detail.Object.cme_presenter.TabSequence = 0
	ls_CmePresenter = dw_Detail.GetItemString(row,"cme_presenter")									//Added by Scofield on 2008-09-22
	if ls_CmePresenter <> "" then dw_detail.SetItem( row, "cme_presenter", "" )
	
	dw_detail.Object.cme_affiliation.Background.Color = RGB( 192, 192, 192 )
	dw_detail.Object.cme_affiliation.TabSequence = 0
	ls_CmeAffiliation = dw_Detail.GetItemString(row,"cme_affiliation")							//Added by Scofield on 2008-09-22
	if Not IsNull(ls_CmeAffiliation) then dw_detail.SetItem( row, "cme_affiliation", nullval )
END IF

IF Upper( ls_meeting_type ) <> "CRED COMMITTEE"  and  Upper( ls_meeting_type ) <> "COMMITTEE" THEN
	dw_detail.Object.committee.Background.Color = RGB( 192, 192, 192 )
	dw_detail.Object.committee.TabSequence = 0
	ll_Committee = dw_Detail.GetItemNumber(row,"committee")											//Added by Scofield on 2008-09-22
	if Not IsNull(ll_Committee) then dw_detail.SetItem( row, "committee", nullval )
END IF

RETURN 0

end function

public function integer wf_copy_detail ();
///his function added maha 060403

Integer li_org
Integer li_nr
Integer li_meeting_id
integer res
integer ac
integer a



if dw_list.rowcount( ) < 1 then return 1

li_org = dw_detail.getrow()

//Start Code Change ----01.03.2008 #V8 maha - removed save to copy button to allow for validation trap
//cb_save.triggerevent(clicked!)

li_meeting_id = gnv_app.of_get_id("MEETING")

li_nr = dw_detail.InsertRow( 0 )
dw_detail.ScrollToRow( li_nr )
dw_detail.SetRow( li_nr )
dw_detail.SetFocus( )

dw_list.selectrow(0,false)
dw_list.selectrow(li_nr,true)


dw_detail.SetItem( li_nr, "meeting_id"  , li_meeting_id)
dw_detail.SetItem( li_nr, "facility"    , dw_detail.getitemnumber(li_org,"facility") ) //copy values
dw_detail.SetItem( li_nr, "meeting_type", dw_detail.getitemnumber(li_org,"meeting_type") )
dw_detail.SetItem( li_nr, "location"    , dw_detail.getitemnumber(li_org,"location") )
dw_detail.SetItem( li_nr, "start_time"  , dw_detail.getitemnumber(li_org,"start_time") )
dw_detail.SetItem( li_nr, "end_time"    , dw_detail.getitemnumber(li_org,"end_time") )
dw_detail.SetItem( li_nr, "start_at"  , dw_detail.getitemstring(li_org,"start_at") )
dw_detail.SetItem( li_nr, "end_at"    , dw_detail.getitemstring(li_org,"end_at") ) //add fields by stephen 07-08-2011 V11.3 Meeting Upgrade
dw_detail.SetItem( li_nr, "subject"     , dw_detail.getitemstring(li_org,"subject") )
dw_detail.SetItem( li_nr, "cme_credits" , dw_detail.getitemnumber(li_org,"cme_credits") )
dw_detail.SetItem( li_nr, "cme_category", dw_detail.getitemnumber(li_org,"cme_category") )
dw_detail.SetItem( li_nr, "cme_presenter", dw_detail.getitemstring(li_org,"cme_presenter") )
dw_detail.SetItem( li_nr, "cme_affiliation", dw_detail.getitemstring(li_org,"cme_affiliation") )
dw_detail.SetItem( li_nr, "section"     , dw_detail.getitemdecimal(li_org,"section") )
dw_detail.SetItem( li_nr, "committee"   , dw_detail.getitemnumber(li_org,"committee") )
dw_detail.SetItem( li_nr, "department"  , dw_detail.getitemnumber(li_org,"department") )
dw_detail.SetItem( li_nr, "committee_lookup"  , dw_detail.getitemnumber(li_org,"committee_lookup") )
 of_setup_taborder(  )  //add fields by stephen 08-30-2011
dw_attendees.reset() 




return 1
end function

public function integer of_batch_add ();//Start Code Change ---- 10.03.2006 #650 maha
//function created 10.03.06 maha called from cb_batch and cb_non_prac
long i
long ic
long li_prac_id
long li_find
long li_nr
string ls_full_name
gs_batch_search ist_search

if not isvalid(message.powerobjectparm) then return 0
ist_search = message.powerobjectparm

ic = upperbound(ist_search.li_prac_id[])
for i = 1 to ic
	li_prac_id = ist_search.li_prac_id[i] 
	select full_name into :ls_full_name from v_full_name where prac_id = :li_prac_id;
	
	li_find = dw_attendees.Find( "prac_id = " + String( li_prac_id ), 1, 1000 )
	
	//Start Code Change ----09.01.2009 #V92 maha - changed to skip duplicatesd rather than error
	IF li_find > 0 THEN
		//skip
		//MessageBox("Select Error", "You have already selected this person to attend!, Please reselect." )
		//Return -1
	ELSE
		li_nr = dw_attendees.InsertRow( 0 )
		
		dw_attendees.SetItem( li_nr, "prac_id", li_prac_id )
		dw_attendees.SetItem( li_nr, "cfull_name", ls_full_name )
		dw_attendees.SetItem( li_nr, "meeting_id", dw_detail.GetItemNumber( dw_detail.GetRow( ), "meeting_id" ) )
	end if
	//End Code Change---09.01.2009
next

dw_detail.SetFocus( )

return 1
end function

public function integer of_meeting_security ();//Start Code Change ----05.26.2009 #V92 maha - added for access security

long ll_val1
long ll_val2
long ll_val3
long ll_val4 //maha 01.12.2012

ll_val1 = w_mdi.of_security_access( 350 ) //view
ll_val2 = w_mdi.of_security_access( 380 ) //invite
ll_val3 = w_mdi.of_security_access( 390 ) //post
ll_val3 = w_mdi.of_security_access( 330 ) //Start Code Change ----01.12.2012 #V12 maha

if ll_val1 = 1 then //readonly
     //------------------- APPEON BEGIN -------------------
	//$<modify> Setephen 08.18.2010
	//$<reason> allow select record
	/*
	dw_attendees.enabled = false
	dw_list.enabled = false
	*/
	dw_attendees.modify("attendence_status.tabsequence='0'")
	 //------------------- APPEON END -------------------
	dw_detail.enabled = false	
	cb_add_meet.enabled = false
	cb_attend.enabled = false
	cb_batch.enabled = false
	cb_copy.enabled = false
	cb_del_all.enabled = false
	cb_del_attend.enabled = false
	cb_delete.enabled = false
	cb_non_prac.enabled = false
	cb_post.enabled = false
	cb_save.enabled = false
	cb_adddoc.enabled = false
	cb_committee_mem.enabled = false
	cb_view_meeting.visible = false  //Start Code Change ----01.12.2012 #V12 maha
	cb_wv_link.visible = false  //Start Code Change ----03.27.2012 #V12 maha
else  //full access less exceptions
	if ll_val2 = 0 then
		cb_attend.enabled = false
		cb_batch.enabled = false
	end if
	if ll_val3 = 0 then
		dw_attendees.enabled = false
	end if
	if ll_val3 = 0 then cb_view_meeting.visible = false   //Start Code Change ----01.12.2012 #V12 maha
end if

if of_get_app_setting("set_web","I") = 0 then //Start Code Change ----03.27.2012 #V12 maha
	cb_wv_link.visible = false  
end if

if gs_cust_type = "I" then  //Start Code Change ----05.17.2012 #V12 maha - hide for intalliapp
	cb_view_meeting.visible = false 
	cb_wv_link.visible = false
end if
	
return ll_val1


end function

public function integer wf_get_image (string as_type, long al_facility, long al_recid);//////////////////////////////////////////////////////////////////////
// $<event> wf_get_image
// $<arguments>
// $<returns> long
// $<description> Viewing meeting minutes (V11.3 Committee Proc Upd)
//////////////////////////////////////////////////////////////////////
// $<add> 07.13.2011 by Stephen
//////////////////////////////////////////////////////////////////////

Integer li_start_page
Integer li_num_pages
Long li_filenum
Long ll_filelen
Long ll_start
Long ll_new_pos, ll_data_length
Integer li_loops
Integer li_counter
Integer li_retval
Blob  lb_image_data
Blob blob_temp
Blob total_blob

string ls_file

SetPointer(HourGlass!)

String ls_filename, ls_Null, ls_filetype

SELECT file_name, file_type
	INTO :ls_filename, :ls_filetype
	FROM document_storage
	WHERE 	Function_type  = :as_type
	     AND  Record_id = :al_recid
		AND   Facility_id  = :al_facility
	USING SQLCA;
	
if sqlca.sqlcode <>0 or isnull(ls_filename) then
	messagebox("Prompt","There is no meeting minutes uploaded!")
	return -1
end if	

ls_file = gs_temp_path + "images\"  
gnv_appeondll.of_parsepath(ls_file)
if pos(ls_filename,'\') > 0 then
	ls_file = ls_file + mid(ls_filename, pos(ls_filename,'\') +1)
else
	ls_file = ls_file +ls_filename
end if

IF FileExists(ls_file) THEN
	filedelete(ls_file)
END IF

openwithparm( w_appeon_gifofwait, "Downloading Image from Database..." )

IF appeongetclienttype() = 'PB' AND gs_dbtype = 'SQL' THEN
	
	SELECT Datalength(Doc_blob)
	INTO :ll_data_length
	FROM document_storage
	WHERE 	Function_type  = :as_type
	     AND  Record_id = :al_recid
		AND   Facility_id  = :al_facility
	USING SQLCA;
	
	IF ll_data_length = 0 OR Isnull(ll_data_length) THEN
		messagebox("Prompt","There is no meeting minutes uploaded!")
		RETURN 0
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
		SELECTBLOB substring(Doc_blob,:ll_start,8000)
		     INTO :blob_temp
		    FROM document_storage
	      WHERE 	Function_type  = :as_type
	          AND  Record_id = :al_recid
		     AND   Facility_id  = :al_facility
	       USING  SQLCA;
	
		total_blob += blob_temp
	NEXT 
	
	lb_image_data = total_blob

ELSE
	
	SELECTBLOB Doc_blob 
	INTO :lb_image_data
	FROM document_storage 
	WHERE 	Function_type  = :as_type
	     AND  Record_id = :al_recid
		AND   Facility_id  = :al_facility
	USING SQLCA;
	
END IF


IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)

IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "SQL ERROR", SQLCA.SQLERRTEXT )
	Return -1
END IF

ll_filelen = LenA( lb_image_data )

IF Isnull(lb_image_data) OR ll_filelen = 0 THEN
	RETURN -1
END IF

if f_open_image_from_database(ls_file,lb_image_data ) = -1 then return -1

IF Not FileExists( ls_file) THEN 
	MessageBox("File Creation Error", "No image file created.  Check to make sure the directory " + gs_dir_path + " is valid." )
END IF

setnull(ls_Null)
IF FileExists(ls_file) THEN
	//---------Begin Modified by (Appeon)Stephen 06.30.2016 for Bug ID #5218 View Meeting Minutes will not display--------
	//ShellExecuteA( Handle( This ), "open", ls_file, ls_Null, ls_Null, 1)
	of_ShellExecute_file(ls_file)
	//---------End Modfiied ------------------------------------------------------	
END IF
	
Return 1

end function

public function integer of_meeting_view_buttons ();//Start Code Change ----04.11.2012 #V12 maha
long r
boolean lb_set = false
dw_detail.accepttext()
r = dw_detail.getitemnumber(1 ,"meeting_type")

if r = 607 then lb_set = true

cb_view_meeting.enabled = lb_set
cb_wv_link.enabled = lb_set



return 1
end function

public function integer of_shellexecute_file (string as_file);//====================================================================
//$<Function>: of_ShellExecute_file
//$<Arguments>:as_file
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 06.30.2016 (Bug ID #5218 View Meeting Minutes will not display)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
integer li_ret
string    ls_Null


setnull(ls_Null) 
li_ret = integer(ShellExecuteA( Handle( This ), "open", as_file, ls_Null, ls_Null, 1))

if li_ret <= 32 then
	choose case li_ret
			Case 2
			messageBox("Prompt", "ERROR ID =" + string(li_ret)+", File not found", StopSign!, OK!, 1)
			Case 3
			messageBox("Prompt", "ERROR ID =" + string(li_ret)+", Path not found", StopSign!, OK!, 1)	
			Case 4
			messageBox("Prompt", "ERROR ID =" + string(li_ret)+", Access denied", StopSign!, OK!, 1)	
			Case 8
			messageBox("Prompt", "ERROR ID =" + string(li_ret)+", Out of memory", StopSign!, OK!, 1)	
			Case 11	
			messageBox("Prompt", "ERROR ID =" + string(li_ret)+", Invalid EXE file or error in EXE image", StopSign!, OK!, 1)	
			Case 26
			messageBox("Prompt", "ERROR ID =" + string(li_ret)+", Sharing violation occurred", StopSign!, OK!, 1)	
			Case 27
			messageBox("Prompt", "ERROR ID =" + string(li_ret)+", Incomplete or invalid file association", StopSign!, OK!, 1)
			Case 28	
			messageBox("Prompt", "ERROR ID =" + string(li_ret)+", DDE Time out", StopSign!, OK!, 1)	
			Case 29	
			messageBox("Prompt", "ERROR ID =" + string(li_ret)+", DDE Transaction failed", StopSign!, OK!, 1)	
			Case 30	
			messageBox("Prompt", "ERROR ID =" + string(li_ret)+", DDE busy", StopSign!, OK!, 1)	
			Case 31	
			messageBox("Prompt", "ERROR ID =" + string(li_ret)+", No association for file extension", StopSign!, OK!, 1)	
			Case 32
			messageBox("Prompt", "ERROR ID =" + string(li_ret)+", DLL not found", StopSign!, OK!, 1)	
			Case Else
			messageBox("Prompt", "ERROR ID =" + string(li_ret)+", Unknown error", StopSign!, OK!, 1)	
	End Choose
end if

return 1
end function

on w_meeting_detail.create
int iCurrent
call super::create
this.cb_wv_link=create cb_wv_link
this.cb_view_meeting=create cb_view_meeting
this.cb_viewdoc=create cb_viewdoc
this.cb_adddoc=create cb_adddoc
this.cb_committee_mem=create cb_committee_mem
this.cb_1=create cb_1
this.cb_del_all=create cb_del_all
this.cb_non_prac=create cb_non_prac
this.dw_list=create dw_list
this.dw_detail=create dw_detail
this.dw_attendees=create dw_attendees
this.st_date=create st_date
this.st_1=create st_1
this.cb_attend=create cb_attend
this.cb_del_attend=create cb_del_attend
this.cb_delete=create cb_delete
this.cb_add_meet=create cb_add_meet
this.cb_5=create cb_5
this.cb_roster=create cb_roster
this.cb_print_meeting=create cb_print_meeting
this.cb_save=create cb_save
this.st_2=create st_2
this.st_3=create st_3
this.cb_documents=create cb_documents
this.dw_roster=create dw_roster
this.cb_batch=create cb_batch
this.cb_copy=create cb_copy
this.cb_post=create cb_post
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_wv_link
this.Control[iCurrent+2]=this.cb_view_meeting
this.Control[iCurrent+3]=this.cb_viewdoc
this.Control[iCurrent+4]=this.cb_adddoc
this.Control[iCurrent+5]=this.cb_committee_mem
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.cb_del_all
this.Control[iCurrent+8]=this.cb_non_prac
this.Control[iCurrent+9]=this.dw_list
this.Control[iCurrent+10]=this.dw_detail
this.Control[iCurrent+11]=this.dw_attendees
this.Control[iCurrent+12]=this.st_date
this.Control[iCurrent+13]=this.st_1
this.Control[iCurrent+14]=this.cb_attend
this.Control[iCurrent+15]=this.cb_del_attend
this.Control[iCurrent+16]=this.cb_delete
this.Control[iCurrent+17]=this.cb_add_meet
this.Control[iCurrent+18]=this.cb_5
this.Control[iCurrent+19]=this.cb_roster
this.Control[iCurrent+20]=this.cb_print_meeting
this.Control[iCurrent+21]=this.cb_save
this.Control[iCurrent+22]=this.st_2
this.Control[iCurrent+23]=this.st_3
this.Control[iCurrent+24]=this.cb_documents
this.Control[iCurrent+25]=this.dw_roster
this.Control[iCurrent+26]=this.cb_batch
this.Control[iCurrent+27]=this.cb_copy
this.Control[iCurrent+28]=this.cb_post
end on

on w_meeting_detail.destroy
call super::destroy
destroy(this.cb_wv_link)
destroy(this.cb_view_meeting)
destroy(this.cb_viewdoc)
destroy(this.cb_adddoc)
destroy(this.cb_committee_mem)
destroy(this.cb_1)
destroy(this.cb_del_all)
destroy(this.cb_non_prac)
destroy(this.dw_list)
destroy(this.dw_detail)
destroy(this.dw_attendees)
destroy(this.st_date)
destroy(this.st_1)
destroy(this.cb_attend)
destroy(this.cb_del_attend)
destroy(this.cb_delete)
destroy(this.cb_add_meet)
destroy(this.cb_5)
destroy(this.cb_roster)
destroy(this.cb_print_meeting)
destroy(this.cb_save)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.cb_documents)
destroy(this.dw_roster)
destroy(this.cb_batch)
destroy(this.cb_copy)
destroy(this.cb_post)
end on

event open;call super::open;String ls_date_part
Date ld_date
integer li_access
DataWindowChild dwchild

IF PosA(Message.StringParm, "New" ) > 0 THEN
	ib_new = True
	ls_date_part = MidA(Message.StringParm, PosA(Message.StringParm, "-") +1, 100 )
	ld_date = Date( ls_date_part )
	idt_date =  DateTime( ld_date )
ELSE
	ib_new = False	
	idt_date =  DateTime( Date( Message.StringParm ) )
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-03
//$<add> 01.17.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
/*
dw_attendees.of_SetTransObject( SQLCA )
dw_attendees.GetChild("attendence_status", dwchild)
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Attendence Status")
dw_detail.of_SetTransObject( SQLCA )
dw_detail.getchild("facility",dwchild)
dwchild.settransobject(sqlca)
dwchild.retrieve(gs_user_id)
dw_detail.GetChild("start_time", dwchild)
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("time")
dwchild.setsort("custom_5")
dwchild.sort()
dw_detail.GetChild("end_time", dwchild)
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("time")
dwchild.setsort("custom_5")
dwchild.sort()
*/
//gnv_appeondb.of_startqueue( )
dw_attendees.of_SetTransObject( SQLCA )

dw_detail.of_SetTransObject( SQLCA )
dw_detail.getchild("facility",dwchild)
dwchild.settransobject(sqlca)
dwchild.retrieve(gs_user_id)

//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2006-10-08 By: Rodger Wu (Inova)
//$<reason> Make facility filter sync with w_meetings window.
/*
IF ib_new THEN
	cb_add_meet.Event Clicked()
	//dw_detail.getchild("facility",dwchild)
	//dw_child.retrieve(gs_user_id)
ELSE
	dw_detail.Retrieve( idt_date ,gs_user_id)
END IF
*/
Boolean lb_all

IF Isvalid( w_meetings ) THEN
	il_facility_id = w_meetings.il_facility_id
	
	//IF w_meetings.dw_facility_select.GetItemNumber( 1, "facility_id" ) <> 0 THEN //0 means ALL facilities.		//Commented by Scofield on 2008-09-22
	IF il_facility_id <> 0 THEN 
		dwchild.SetFilter( "facility_id = " + string( il_facility_id ) )
		dwchild.Filter()
	ELSE
		lb_all = True
	END IF
ELSE
	SELECT security_users.default_search_facility 
	 INTO :il_facility_id  
	 FROM security_users
	WHERE security_users.user_id = :gs_user_id;
	
	if IsNull(il_facility_id) then			//Added by Scofield on 2008-09-10
		lb_all = True
	else
		dwchild.SetFilter( "facility_id = " + string( il_facility_id ) )
		dwchild.Filter()
	end if
END IF
//debugbreak()
//Start Code Change ----05.26.2009 #V92 maha
li_access = of_meeting_security( ) 


IF ib_new THEN
	if li_access = 2 then  //Start Code Change ----05.26.2009 #V92 maha - only if full access
		cb_add_meet.Event Clicked()
	end if
ELSE
	IF dw_detail.Retrieve( idt_date ,gs_user_id) > 1 THEN
		IF Not lb_all THEN
			dw_detail.SetFilter( "facility = " + string( il_facility_id ) )
			dw_detail.Filter()
		END IF
	END IF
END IF
//---------------------------- APPEON END ----------------------------

//COMMIT USING SQLCA;

//retrieve dddw's

of_setup_dddw( )
of_setup_taborder(  )


dw_detail.ShareData( dw_list )

dw_list.of_Setupdateable( False )

String months[12]

months[1] = "January"
months[2] = "February"
months[3] = "March"
months[4] = "April"
months[5] = "May"
months[6] = "June"
months[7] = "July"
months[8] = "August"
months[9] = "September"
months[10] = "October"
months[11] = "November"
months[12] = "December"

st_date.Text = String( DayName( Date( idt_date ) ) ) +&
				   " - " + months[ Month( Date( idt_date ) ) ] +&
               " " + String( Day( Date( idt_date ) ) ) +&
					", " + String( Year( Date( idt_date ) ) )

dw_list.of_SetDropDownCalendar( TRUE )
dw_list.iuo_calendar.of_Register(dw_list.iuo_calendar.DDLB)		

dw_detail.of_SetDropDownCalendar( TRUE )
dw_detail.iuo_calendar.of_Register(dw_detail.iuo_calendar.DDLB)		

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-10-08 By: Rodger Wu (Inova)
//$<reason> Fix a defect.
Integer li_current

li_current = dw_detail.GetRow()
IF li_current > 0 THEN
	dw_detail.SetItemStatus( li_current, 0, Primary!, NotModified! )
END IF
//---------------------------- APPEON END ----------------------------

end event

event closequery;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  closequery
//
//	Description:
//	Search for unsaved datawindows prompting the user if any
//	pending updates are found.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
// 6.0	Enhanced control on what objects are to be updated.
// 6.0.01 Make sure the window is not minimized and behind other windows.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Constant Integer	ALLOW_CLOSE = 0
Constant Integer	PREVENT_CLOSE = 1

Integer	li_msg
Integer	li_rc
String	ls_msgparms[]
Powerobject lpo_updatearray[]

// Check if the CloseQuery process has been disabled
If ib_disableclosequery Then
	Return ALLOW_CLOSE
End If

// Call event to perform any pre-CloseQuery processing
If This.Event pfc_preclose ( ) <> 1 Then
	// Prevent the window from closing
	Return PREVENT_CLOSE 
End If

// Prevent validation error messages from appearing while the window is closing
// and allow others to check if the  CloseQuery process is in progress
ib_closestatus = True

// Determine the objects for which an update will be attempted.
// For the CloseQuery, the order sequence is as follows: 
//		1) Specified permananent sequence (thru of_SetUpdateObjects(...)).
//		2) None was specified, so use default window control array.
If UpperBound(ipo_updateobjects) > 0 Then
	lpo_updatearray = ipo_updateobjects
Else
	lpo_updatearray = This.Control		
End If

// Check for any pending updates
li_rc = of_UpdateChecks(lpo_updatearray)
If li_rc = 0 Then
	// Updates are NOT pending, allow the window to be closed.
	ib_closestatus = False
	Return ALLOW_CLOSE
ElseIf li_rc < 0 Then
	// Make sure the window is not minimized and behind other windows.
	If this.WindowState = Minimized! Then
		this.WindowState = Normal!
	End If
	this.BringToTop = True

	// There are Updates pending, but at least one data entry error was found.
	// Give the user an opportunity to close the window without saving changes
	If IsValid(gnv_app.inv_error) Then
		li_msg = gnv_app.inv_error.of_Message('pfc_closequery_failsvalidation', &
					 ls_msgparms, gnv_app.iapp_object.DisplayName)
	Else
		li_msg = of_MessageBox ("pfc_master_closequery_failsvalidation", &
					gnv_app.iapp_object.DisplayName, &
					"The information entered does not pass validation and "  + &
					"must be corrected before changes can be saved.~r~n~r~n" + &
					"Close without saving changes?", &
					exclamation!, YesNo!, 2)
	End If
	If li_msg = 1 Then
		ib_closestatus = False
		Return ALLOW_CLOSE
	End If
Else
	// Make sure the window is not minimized and behind other windows.
	If this.WindowState = Minimized! Then
		this.WindowState = Normal!
	End If	
	this.BringToTop = True
	
	// Changes are pending, prompt the user to determine if they should be saved
	If IsValid(gnv_app.inv_error) Then
		li_msg = gnv_app.inv_error.of_Message('pfc_closequery_savechanges',  &
					ls_msgparms, gnv_app.iapp_object.DisplayName)		
	Else
		li_msg = of_MessageBox ("pfc_master_closequery_savechanges", &
					gnv_app.iapp_object.DisplayName, &
					"Do you want to save changes?", exclamation!, YesNoCancel!, 1)
	End If
	Choose Case li_msg
		Case 1
			// YES - Update
			// If the update fails, prevent the window from closing
			If cb_save.Event clicked() >= 1 Then
				// Successful update, allow the window to be closed
				ib_closestatus = False
				Return ALLOW_CLOSE
			End If
		Case 2
			// NO - Allow the window to be closed without saving changes
			ib_closestatus = False
			Return ALLOW_CLOSE
		Case 3
			// CANCEL -  Prevent the window from closing
	End Choose
End If

// Prevent the window from closing
ib_closestatus = False
Return PREVENT_CLOSE
end event

type cb_wv_link from commandbutton within w_meeting_detail
integer x = 558
integer y = 956
integer width = 466
integer height = 88
integer taborder = 150
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "WV Meeting Link"
end type

event clicked;//Start Code Change ----03.27.2012 #V12 maha - added
string ls_wv_link
string ls_meeting_link


//Build the WV email link 
ls_wv_link = gnv_data.of_getitem('ids','wv_meeting_link',false)
if right(ls_wv_link,1) = '/' then
	ls_meeting_link = ls_wv_link +'meeting/index.cfm?meeting_id='+string(ii_meeting_id)
else
	ls_meeting_link = ls_wv_link +'/meeting/index.cfm?meeting_id='+string(ii_meeting_id)
end if

openwithparm(w_wv_link,ls_meeting_link)


end event

type cb_view_meeting from commandbutton within w_meeting_detail
integer x = 1042
integer y = 956
integer width = 393
integer height = 88
integer taborder = 160
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "View Meeting"
end type

event clicked;long ll_id
debugbreak()
ll_id =  ii_meeting_id  //dw_detail.getitemnumber(dw_detail.getrow(),"meeting_id")

openwithparm(w_cred_comm_meeting_approve, ll_id)
end event

type cb_viewdoc from commandbutton within w_meeting_detail
integer x = 1952
integer y = 956
integer width = 393
integer height = 88
integer taborder = 150
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&View Minutes"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> integer
// $<description>Add button for uploading/viewing meeting minutes (V11.3 Meeting Upgrade)
//////////////////////////////////////////////////////////////////////
// $<add> 07.12.2011 by Stephen
//////////////////////////////////////////////////////////////////////

integer li_row
long     ll_meet_id, ll_facility
dwitemstatus ldws_new
string ls_filename

li_row = dw_detail.getrow()
if li_row < 1 then return

ll_meet_id = dw_detail.getitemnumber(li_row,'meeting_id')
ll_facility   = dw_detail.getitemnumber(li_row,'facility')

if isnull(ll_facility) then
	messagebox("Prompt","There is no meeting minutes uploaded!")
	return -1
end if

ldws_new = dw_detail.getitemstatus(li_row,0,primary!)
if ldws_new = new! or ldws_new = newmodified! then
	messagebox("Prompt","There is no meeting minutes uploaded!")
	return -1
end if

wf_get_image( 'meetings', ll_facility, ll_meet_id)




end event

type cb_adddoc from commandbutton within w_meeting_detail
integer x = 1509
integer y = 956
integer width = 439
integer height = 88
integer taborder = 150
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Upload Minutes"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> integer
// $<description>Add button for uploading/viewing meeting minutes (V11.3 Meeting Upgrade)
//////////////////////////////////////////////////////////////////////
// $<add> 07.11.2011 by Stephen
//////////////////////////////////////////////////////////////////////

integer li_row
long     ll_meet_id, ll_facility
dwitemstatus ldws_new
str_folder lstr_doc

li_row = dw_detail.getrow()
if li_row < 1 then return

ll_meet_id = dw_detail.getitemnumber(li_row,'meeting_id')
ll_facility   = dw_detail.getitemnumber(li_row,'facility')

if isnull(ll_facility) then
	messagebox("Prompt","Please select meeting Facility before Uploading Meeting ")
	return -1
end if

ldws_new = dw_detail.getitemstatus(li_row,0,primary!)
if ldws_new = new! or ldws_new = newmodified! then
	messagebox("Prompt","Please save the record before Uploading Meeting ")
	return -1
end if

lstr_doc.as_type = 'meetings'
lstr_doc.al_folder_id = ll_facility
lstr_doc.al_category = ll_meet_id

openwithparm(w_meet_minu_upload, lstr_doc)

parent.setredraw(false)
dw_detail.Retrieve( idt_date ,gs_user_id) 

if not (isnull(il_facility_id) or il_facility_id = 0 ) then
	dw_detail.SetFilter( "facility = " + string( il_facility_id ) )
	dw_detail.Filter()	
end if
	
li_row = dw_detail.find("meeting_id = "+ string(ll_meet_id), 1, dw_detail.rowcount() )
if li_row > 0 then
	dw_list.scrolltorow(li_row)
	dw_list.selectrow(0,false)
	dw_list.selectrow(li_row,true)
end if
parent.setredraw(true)





end event

type cb_committee_mem from u_cb within w_meeting_detail
integer x = 2949
integer y = 1900
integer width = 622
integer height = 84
integer taborder = 130
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
boolean enabled = false
string text = "Add Committee members"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> integer
// $<description>Add Committee members (V11.3 Meeting Upgrade)
//////////////////////////////////////////////////////////////////////
// $<add> 07.08.2011 by Stephen
//////////////////////////////////////////////////////////////////////

long ll_facility, ll_committee
str_folder  lstr_1
integer li_row

li_row = dw_list.getrow()

if li_row < 1 then 
	return 0
end if 

ll_facility = dw_detail.getitemnumber(li_row,"facility")
ll_committee = dw_detail.getitemnumber(li_row,"committee")

if isnull(ll_facility) then
	messagebox("Reminder","Please select meeting Facility before adding attendees")
	return -1
end if

if isnull(ll_committee) then
	messagebox("Reminder","Please select Cred Committee before adding attendees")
	return -1
end if

lstr_1.al_category = ll_committee
openwithparm(w_committee_member_sele, lstr_1)

IF Message.DoubleParm = -1 THEN
	Return -1
else
	of_batch_add( )
END IF


end event

type cb_1 from u_cb within w_meeting_detail
boolean visible = false
integer x = 1463
integer y = 1056
integer width = 416
integer height = 76
integer taborder = 170
boolean bringtotop = true
string text = "Documents"
end type

type cb_del_all from u_cb within w_meeting_detail
integer x = 2949
integer y = 2100
integer width = 622
integer height = 84
integer taborder = 120
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Delete All Attendees"
end type

event clicked;//Start Code Change ----04.25.2008 #V8 maha -  added this button
Integer 	li_ans
long 		ll_Cycle,ll_RowCnt

//Start Code Change ----08.22.2011 #V11 maha - added trap
if dw_attendees.rowcount() <1 then 
	return 0
end if 
//End Code Change ----08.22.2011 

li_ans = MessageBox("Delete", "Are you sure you want to delete All of the attendees?", Question!, YesNo!, 1 )
IF li_ans = 1 THEN
	//--------------------------- APPEON BEGIN ---------------------------
	//$<Modify> 2008-04-29 By: Scofield
	//$<Reason> Delete all rows .

	//	for ll_Cycle = 1 to dw_attendees.rowcount()
	//		dw_attendees.DeleteRow( 1 )
	//	next
	
	ll_RowCnt = dw_Attendees.RowCount()
	
	for ll_Cycle = 1 to ll_RowCnt
		dw_attendees.DeleteRow(1)
	next
	//---------------------------- APPEON END ----------------------------
END IF

dw_detail.SetFocus( )

end event

type cb_non_prac from u_cb within w_meeting_detail
integer x = 2377
integer y = 2100
integer width = 562
integer height = 84
integer taborder = 120
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Add Non-Practitioners"
end type

event clicked;//Start Code Change ---- 10.04.2006 #649 maha cb_non_prac button added

if dw_list.rowcount() < 1 then //see that the meeting has been entered
	return 0
end if 

if isnull(dw_detail.getitemnumber(1,"facility")) then //maha 010604
	messagebox("Reminder","Please select meeting Facility before adding attendees")
	return -1
end if

openwithparm(w_non_prac_painter,"S")

IF Message.DoubleParm = -1 THEN
	Return -1
else
	of_batch_add( )
END IF


end event

type dw_list from u_dw within w_meeting_detail
integer x = 23
integer y = 284
integer width = 2331
integer height = 664
integer taborder = 140
boolean bringtotop = true
string dataobject = "d_meetings_list"
boolean hscrollbar = true
boolean ib_isupdateable = false
end type

event rowfocuschanged;call super::rowfocuschanged;Integer li_rc,li_ret
Integer i
Integer li_found
integer li_facil
integer li_meeting
DataWindowChild dwchild
dw_detail.setredraw(false)
IF currentrow > 0 THEN

	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 01.13.2006 By: LeiWei
	//$<reason> Fix a defect.
	//li_found = dw_detail.Find( "meeting_id = " + String( +&
  	// 	        This.GetItemNumber( currentrow, "meeting_id" ) ), 1, 10000 )
	//li_meeting = This.GetItemNumber( currentrow, "meeting_id" )		  
	li_meeting = This.GetItemNumber( currentrow, "meeting_id" )
	ii_meeting_id = li_meeting  //Start Code Change ----11.17.2011 #V12 maha
	If Isnull(li_meeting) Then li_meeting = 0
	li_found = dw_detail.Find( "meeting_id = " + String( +&
 	 	        li_meeting ), 1, 10000 )
	//---------------------------- APPEON END ----------------------------
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-07
	//$<add> 01.17.2006 By: LeiWei
	//$<reason> Performance tuning
	//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
	gnv_appeondb.of_startqueue( )
	//---------------------------- APPEON END ----------------------------

	IF li_found > 0 THEN
		dw_detail.ScrollToRow( li_found )
		dw_detail.SetRow( li_found )
		//\/maha 082900
		li_facil = This.GetItemNumber( currentrow, "facility" )
		dw_detail.GetChild( "committee", dwchild )
		dwchild.SetTransObject( SQLCA )
		dwchild.Retrieve( li_facil )
		//\maha
		
	END IF
	This.SelectRow( 0, False)
	This.SelectRow( currentrow, True )
END IF
//\/moved from dw_detail RFC event maha 101100
IF currentrow > 0 THEN	
	dw_attendees.Retrieve( This.GetItemNumber( currentrow, "meeting_id" ) )
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-08
	//$<add> 01.17.2006 By: LeiWei
	//$<reason> Performance tuning
	//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
	gnv_appeondb.of_commitqueue( )
	//---------------------------- APPEON END ----------------------------

	li_rc = dw_attendees.RowCount( )
//	FOR i = 1 TO li_rc
//		dw_attendees.SetItem( i, "cfull_name", dw_attendees.GetItemString( i, "full_name" ) )
//	END FOR
	of_setup_taborder(  )

end if
dw_detail.setredraw(true)
//\maha
of_meeting_view_buttons( )  //Start Code Change ----0412.2012 #V12 maha
end event

event rowfocuschanging;call super::rowfocuschanging;//--------Begin Added by Nova 12.12.2008------------------------
Integer li_ret
IF dw_attendees.ModifiedCount( ) +dw_attendees.DeletedCount( ) > 0 THEN
	li_ret = MessageBox("Question","Data has been changged,do you want to save?",Question!,yesno!,2)
	IF li_ret = 1 THEN
		cb_save.Event clicked( )
	END IF
END IF
//--------End Added --------------------------------------------


end event

type dw_detail from u_dw within w_meeting_detail
integer x = 18
integer y = 1052
integer width = 2331
integer height = 1128
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_meeting_detail"
boolean vscrollbar = false
end type

event rowfocuschanged;call super::rowfocuschanged;//moved to dw_list rfc event 101100 maha
//Integer li_rc
//Integer i
//
IF currentrow > 0 THEN
//	dw_attendees.Retrieve( This.GetItemNumber( currentrow, "meeting_id" ) )
//	li_rc = dw_attendees.RowCount( )
//	FOR i = 1 TO li_rc
//		dw_attendees.SetItem( i, "cfull_name", dw_attendees.GetItemString( i, "full_name" ) )
//	END FOR
	of_setup_taborder(  )
END IF
end event

event itemchanged;call super::itemchanged;DataWindowChild dwchild
Integer nullint, li_row, li_active
long ll_comm_old
	
IF This.GetColumnName( ) = "meeting_type" THEN
	of_setup_taborder(  )
	of_meeting_view_buttons( )  //Start Code Change ----0412.2012 #V12 maha
END IF

IF This.GetColumnName() = "facility" THEN
	
	SetNull( nullint)
	This.GetChild( "committee", dwchild )
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve( Integer( data ) )
	This.SetItem( row, "committee", nullint )
END IF

IF This.GetColumnName( ) = "start_date" THEN
	this.accepttext()
	this.setitem(this.getrow(),"end_date",this.getitemdatetime(this.getrow(),"start_date"))
END IF

//------------------- APPEON BEGIN -------------------
//$<add> Stephen 07.13.2011
//$<reason>Inactive committee (V11.3 Committee Proc Upd)
if dwo.name = 'committee' then
	this.getchild("committee", dwchild)
		li_row = dwchild.getrow()
		if li_row > 0 then
			li_active = dwchild.getitemnumber(li_row, "active_status")
			if li_active <> 1 then
				ll_comm_old = this.getitemnumber(row , "committee", primary!, false)
				messagebox("Prompt", "The committee is Inactive, you cannot select it.")
				this.setitem(row, "committee",  ll_comm_old)
				return 2
			end if
		end if
end if
//------------------- APPEON BEGIN -------------------
end event

event constructor;This.of_SetReqColumn(TRUE)


end event

event retrieveend;call super::retrieveend;IF this.getrow() > 0 THEN
//messagebox("","retv_end")
	of_setup_taborder(  )
END IF

end event

event pfc_postupdate;//
// Add by andy 03/03/2010 V10.1 - Notification Alert
//
n_cst_notification_alert_upd	lnv_na

lnv_na.of_update_alert_records( "meetings", This)

// Because I must check column status in the above function,
// I unextend ancestor script and call it at last.
Call Super::pfc_postupdate

return 1
end event

event other;call super::other;//////////////////////////////////////////////////////////////////////
// $<event> other
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Stephen 08.18.2011  (V11.3 Meeting Upgrade)
//////////////////////////////////////////////////////////////////////

if Message.WordParm = 61458 then 
	Message.Processed = true
	Message.ReturnValue = 0	
end if

if Message.Number = 522 then
	Return 1
end if
end event

type dw_attendees from u_dw within w_meeting_detail
integer x = 2368
integer y = 284
integer width = 1193
integer height = 1588
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_meeting_attendence"
end type

event pfc_preupdate;call super::pfc_preupdate;//maha 010604 v4
long i
long prac
long z
string pname

for i = 1 to this.rowcount() - 1
	prac = this.getitemnumber(i,"prac_id")
	for z = 1 to this.rowcount()
		if i = z then continue
		if prac = this.getitemnumber(z,"prac_id") then
			select full_name into :pname from v_full_name where prac_id = :prac;
			Messagebox("Duplicate Attendee","Practitioner " + pname + " is duplicated.  Please remove the extra record.")
			return -1
		end if
	next
next

return 1
end event

event buttonclicked;call super::buttonclicked;
This.SetItem( row, "attendence_status", 626 )
end event

event clicked;call super::clicked;integer r

r = this.getclickedrow()
this.setrow(r)
end event

type st_date from statictext within w_meeting_detail
integer x = 27
integer y = 128
integer width = 2107
integer height = 96
boolean bringtotop = true
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
boolean enabled = false
string text = "September 25 2998"
boolean focusrectangle = false
end type

type st_1 from statictext within w_meeting_detail
integer x = 2409
integer y = 228
integer width = 293
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
boolean enabled = false
string text = "Attendees"
boolean focusrectangle = false
end type

type cb_attend from u_cb within w_meeting_detail
integer x = 2377
integer y = 1900
integer width = 562
integer height = 84
integer taborder = 90
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Add Single Attendee"
end type

event clicked;Integer li_nr
Integer li_find
long li_prac_id
String ls_full_name
integer i
integer ic
gs_batch_search ist_search

// mskinner 20 Dec 2005 -- begin
if dw_list.rowcount() <1 then 
	return 0
end if 
// mskinner 20 Dec 2005 -- end

if isnull(dw_detail.getitemnumber(1,"facility")) then //maha 010604
	messagebox("Reminder","Please select meeting Facility before adding attendees")
	return -1
end if
//\/maha added 110901
gs_search lstr_search

lstr_search.stran_transaction = SQLCA
lstr_search.ls_open_for = "REPORTS" + String(dw_detail.GetItemNumber( dw_Detail.GetRow(), "facility"))//maha 052302 changed from MEETINGS
debugbreak()
OpenWithParm( w_extended_search_new , lstr_search )
//\ maha
//OpenWithParm( w_extended_search_new, "REPORTS" + String(dw_detail.GetItemNumber( dw_Detail.GetRow(), "facility")) )

IF Message.DoubleParm = -1 THEN
	Return -1
END IF

ist_search = message.powerobjectparm
//maha 091605 allowing for multi selection

// mskinner 21 dec 2005 -- begin
if not isvalid(message.powerobjectparm) then return 0
// mskinner 21 dec 2005 -- end

ic = upperbound(ist_search.li_prac_id[])
for i = 1 to ic
	li_prac_id = ist_search.li_prac_id[i] //maha 091605
	select full_name into :ls_full_name from v_full_name where prac_id = :li_prac_id;
	//ls_full_name = ist_search.ls_name[i] //maha 091605


	li_find = dw_attendees.Find( "prac_id = " + String( li_prac_id ), 1, 1000 )
	
	IF li_find > 0 THEN
		MessageBox("Select Error", "You have already selected "  + ls_full_name +  " to attend.  Please reselect." )
		Return -1
	END IF
	
	li_nr = dw_attendees.InsertRow( 0 )
	
	dw_attendees.SetItem( li_nr, "prac_id", li_prac_id )
	//messagebox("", li_prac_id )
	dw_attendees.SetItem( li_nr, "cfull_name", ls_full_name )
	dw_attendees.SetItem( li_nr, "meeting_id", dw_detail.GetItemNumber( dw_detail.GetRow( ), "meeting_id" ) )
next
//li_prac_id = Integer( Mid( Message.StringParm, 1, Pos( Message.StringParm, "-" ) -1 ) )
//ls_full_name = Mid( Message.StringParm, Pos( Message.StringParm, "-" ) +1, 100 )
//
//li_find = dw_attendees.Find( "prac_id = " + String( li_prac_id ), 1, 1000 )
//
//IF li_find > 0 THEN
//	MessageBox("Select Error", "You have already selected this person to attend!, Please reselect." )
//	Return -1
//END IF
//


//li_nr = dw_attendees.InsertRow( 0 )

//dw_attendees.SetItem( li_nr, "meeting_id", +&
//             dw_detail.GetItemNumber( dw_detail.GetRow( ), "meeting_id" ) )

//dw_attendees.SetItem( li_nr, "prac_id", li_prac_id )
//dw_attendees.SetItem( li_nr, "cfull_name", ls_full_name )

dw_detail.SetFocus( )


end event

type cb_del_attend from u_cb within w_meeting_detail
integer x = 2949
integer y = 2000
integer width = 622
integer height = 84
integer taborder = 100
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Delete Attendee"
end type

event clicked;Integer li_ans

//Start Code Change ----08.22.2011 #V11 maha - added trap
if dw_attendees.rowcount() <1 then 
	return 0
end if 
//End Code Change ----08.22.2011 

li_ans = MessageBox("Delete", "Are you sure you want to delete attendee?", Question!, YesNo!, 1 )
IF li_ans = 1 THEN
	dw_attendees.DeleteRow( 0 )
END IF


end event

type cb_delete from u_cb within w_meeting_detail
integer x = 1161
integer y = 24
integer width = 398
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Delete Meeting"
end type

event clicked;Integer li_ans
long     ll_RowCnt, ll_Cycle, ll_row

ll_row = dw_detail.getrow()
if ll_row < 1 then return

li_ans = MessageBox("Delete Row", "Are you sure you want to delete selected row?", Question!, YesNo!, 1 )

IF li_ans = 1 THEN
	
	//------------------- APPEON BEGIN -------------------
	//$<add> Stephen 08.19.2011
	//$<reason> N/A (V11.3 Meeting Upgrade)
	ll_RowCnt = dw_Attendees.RowCount()
	
	for ll_Cycle = 1 to ll_RowCnt
		dw_attendees.DeleteRow(1)
	next

	//------------------- APPEON END -------------------
	dw_detail.DeleteRow( 0 )
END IF

dw_detail.SetFocus( )
end event

type cb_add_meet from u_cb within w_meeting_detail
integer x = 416
integer y = 24
integer width = 366
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Add Meeting"
end type

event clicked;Integer li_nr
Integer li_meeting_id

cb_save.triggerevent(clicked!)

li_meeting_id = gnv_app.of_get_id("MEETING")

li_nr = dw_detail.InsertRow( 0 )
dw_detail.SetItem( li_nr, "meeting_id", li_meeting_id)
dw_detail.SetItem( li_nr, "start_date", idt_date )
dw_detail.SetItem( li_nr, "end_date", idt_date )

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-10-08 By: Rodger Wu (Inova)
//$<reason> Set default facility.


if il_facility_id<>0 then  dw_detail.SetItem( li_nr, "facility", il_facility_id)  // fixed BugN092701 Modified by Scofield on 2008-09-22

//---------------------------- APPEON END ----------------------------

dw_detail.ScrollToRow( li_nr )
dw_detail.SetRow( li_nr )
dw_detail.SetFocus( )
dw_list.selectrow(0,false)
dw_list.selectrow(li_nr,true)

dw_attendees.reset()


end event

type cb_5 from u_cb within w_meeting_detail
integer x = 3186
integer y = 32
integer width = 366
integer taborder = 70
boolean bringtotop = true
string text = "&Close"
boolean cancel = true
end type

event clicked;Close( Parent )
end event

type cb_roster from u_cb within w_meeting_detail
integer x = 2030
integer y = 24
integer width = 384
integer taborder = 130
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Print &Roster"
end type

event clicked;integer i
integer s //Start Code Change ---- 10.03.2006 #648 maha
str_report_cur  lstr_report

i = Parent.Event pfc_save( )

if i < 0 then
	//save failed
else
	//Start Code Change ----11.17.2011 #V12 maha - changes to different window
	openwithparm(w_roster_report,ii_meeting_id )
	
	
end if


//	//Start Code Change ---- 10.03.2006 #648 maha
//	s = of_get_app_setting("set_46", "I")
//	if s = 1 then
//		dw_roster.dataobject = "d_rpt_meeting_roster_inova"
//		dw_roster.settransobject( sqlca)
//	end if
//	//End Code Change---10.03.2006
//	if dw_detail.GetRow() < 1 then return //add by stephen 08.19.2011 
//	dw_roster.Retrieve( dw_detail.GetItemNumber( dw_detail.GetRow(), "meeting_id" ))
//	
//	//------------------- APPEON BEGIN -------------------
//	//$<modify> Stephen 07.07.2011
//	//$<reason> open report window  (V11.3 Meeting Upgrade)
//	/*
//    dw_roster.Print()
//	 */
//	lstr_report.s_name =  dw_roster.dataobject
//	lstr_report.s_type = 'datawindow'
//	lstr_report.dw_rep = dw_roster
//	
//	openwithparm(w_print_report_cur,lstr_report)
//	//------------------- APPEON END -------------------
//	
//	dw_detail.SetFocus( )
//end if
end event

type cb_print_meeting from u_cb within w_meeting_detail
integer x = 1563
integer y = 24
integer width = 462
integer taborder = 50
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Print Meeting &List"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> integer
// $<description> N/A (V11.3 Meeting Upgrade)
//////////////////////////////////////////////////////////////////////
// $<add> 07.07.2011 by Stephen
//////////////////////////////////////////////////////////////////////
str_report_cur  lstr_report
datastore lds_meet_list
datawindowchild dwchild

lds_meet_list = create datastore
lds_meet_list.dataobject = 'd_rpt_meeting_list'
lds_meet_list.settransobject(sqlca)
lds_meet_list.retrieve( idt_date ,gs_user_id)
if not (isnull(il_facility_id) or il_facility_id = 0 ) then
	lds_meet_list.SetFilter( "facility = " + string( il_facility_id ) )
	lds_meet_list.Filter()	
end if

lds_meet_list.GetChild("meeting_type", dwchild)
dwchild.SetTransObject( SQLCA )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper(lookup_name)='" + upper("meeting type") + "'" , dwchild)

lstr_report.s_name =  'd_rpt_meeting_list'
lstr_report.s_type = 'datastore'
lstr_report.ds_rep = lds_meet_list

openwithparm(w_print_report_cur,lstr_report)
//dw_list.print()

dw_detail.SetFocus( )
end event

type cb_save from u_cb within w_meeting_detail
integer x = 32
integer y = 24
integer width = 366
integer taborder = 60
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;integer li_row, li_rowcount
long ll_meet_id, ll_facility
dwitemstatus lds_modify

//------------------- APPEON BEGIN -------------------
//$<add> Stephen 08.19.2011
//$<reason> N/A (V11.3 Meeting Upgrade)
li_rowcount = dw_detail.rowcount()
sqlca.autocommit = false;
connect using sqlca;
for li_row = 1 to li_rowcount
	lds_modify = dw_detail.getitemstatus(li_row, 'facility', primary!)
	if lds_modify = datamodified! then
		ll_facility = dw_detail.getitemnumber(li_row, 'facility')
		ll_meet_id = dw_detail.getitemnumber(li_row,'meeting_id')
		
		update document_storage
		set       Facility_id = :ll_facility
		WHERE 	Function_type  = 'meetings'
			  AND  Record_id = :ll_meet_id	USING SQLCA;
	end if
next

li_rowcount = dw_detail.deletedcount()
for li_row = 1 to li_rowcount
	ll_meet_id = dw_detail.getitemnumber(li_row,'meeting_id', delete!, false)
	delete document_storage
	WHERE 	Function_type  = 'meetings'
	   AND  Record_id = :ll_meet_id	USING SQLCA;
next		
if Parent.Event pfc_save( ) <> 1 then
	rollback using sqlca;
	sqlca.autocommit = true;
	connect using sqlca;
	return 0
end if
commit using sqlca;
sqlca.autocommit = true;
connect using sqlca;
return 1
//------------------- APPEON END -------------------

dw_detail.SetFocus( )
end event

type st_2 from statictext within w_meeting_detail
integer x = 27
integer y = 228
integer width = 590
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
boolean enabled = false
string text = "Select Meeting"
boolean focusrectangle = false
end type

type st_3 from statictext within w_meeting_detail
integer x = 27
integer y = 968
integer width = 507
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
boolean enabled = false
string text = "Meeting Detail"
boolean focusrectangle = false
end type

type cb_documents from u_cb within w_meeting_detail
boolean visible = false
integer x = 1883
integer y = 1056
integer width = 466
integer height = 76
integer taborder = 160
boolean bringtotop = true
string text = "Send Notifications"
end type

type dw_roster from u_dw within w_meeting_detail
boolean visible = false
integer x = 2203
integer y = 2192
integer width = 146
integer height = 76
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_rpt_meeting_roster"
boolean vscrollbar = false
end type

event constructor;This.of_SetTransObject( SQLCA )

end event

type cb_batch from u_cb within w_meeting_detail
integer x = 2377
integer y = 2000
integer width = 562
integer height = 84
integer taborder = 110
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Batch Add Attendee"
end type

event clicked;//Start Code Change ---- 10.03.2006 #647 maha changed to use function

//Start Code Change ----08.22.2011 #V11 maha - added trap
if dw_list.rowcount() <1 then 
	return 0
end if 
//End Code Change ----08.22.2011 

openwithparm(w_batch_prac_select_new,"R")

if message.stringparm = "Cancel" then 
	return
else
	of_batch_add( )
end if
//End Code Change---10.03.2006

end event

type cb_copy from commandbutton within w_meeting_detail
integer x = 791
integer y = 24
integer width = 366
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "C&opy to New"
end type

event clicked;//this function added maha 060403
boolean lb_attend = false //maha010308
Integer li_org
Integer li_nr
Integer li_meeting_id
integer res
integer ac
integer a
string ls_full_name[]
LONG LL_PRAC_ID[]
STRING LS_cfull_name[]
long r
long ll_meet_id
		
if dw_list.rowcount( ) < 1 then 
	return -1
end if

PARENT.setredraw(false)
ac = dw_attendees.rowcount()
//Start Code Change ----01.03.2008 #V8 maha - modified code so that it could correctly trap for validation errors
if Parent.Event pfc_save( ) < 0 then 
	PARENT.setredraw(true) //Added By Ken.Guo 04.21.2008
	Return -1
End If

if ac > 0 then
	IF messagebox("Copy","Do you wish to copy the Attendees also?",question!,yesno!,1) = 1 THEN	
		lb_attend = true
		for a = 1 to dw_attendees.rowcount()
			LL_PRAC_ID[upperbound(LL_PRAC_ID) + 1] = dw_attendees.getitemnumber(a,"prac_id")
			LS_cfull_name[upperbound(LS_cfull_name) + 1]       = dw_attendees.getitemstring(a,"cfull_name")
			ls_full_name[upperbound(ls_full_name) + 1]                   = dw_attendees.getitemstring(a,"v_full_name_full_name")
		next
	END IF
end if

if wf_copy_detail() < 1 then 
	PARENT.setredraw(true) //Added By Ken.Guo 04.21.2008
	return -1
end if

if lb_attend =  true then
	ll_meet_id = dw_detail.GetItemNumber( dw_detail.GetRow( ), "meeting_id" ) 
			
	for r = 1 to upperbound(LL_PRAC_ID)
		dw_attendees.InsertRow( r )
		dw_attendees.SetItem( r, "meeting_id", ll_meet_id )
		dw_attendees.SetItem( r, "prac_id", LL_PRAC_ID[r] )
		dw_attendees.SetItem( r, "cfull_name", LS_cfull_name[R] )
		dw_attendees.SetItem( r, "v_full_name_full_name", ls_full_name[r] )
	next
end if

//wf_copy_detail()  //Start Code Change ---- 10.11.2007 #V7 maha moved from above
//End Code Change---01.03.2008

PARENT.setredraw(true)
		
end event

type cb_post from u_cb within w_meeting_detail
boolean visible = false
integer x = 1778
integer y = 2160
integer width = 261
integer height = 84
integer taborder = 150
string text = "Post CME Records"
end type

event clicked;call super::clicked;Integer li_rc
Integer i

//dw_attendees
end event

