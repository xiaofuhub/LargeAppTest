$PBExportHeader$pfc_cst_u_data_entry.sru
forward
global type pfc_cst_u_data_entry from userobject
end type
type cb_decheck from commandbutton within pfc_cst_u_data_entry
end type
type st_dw_select_section_border from u_st_border within pfc_cst_u_data_entry
end type
type cb_view_relation from commandbutton within pfc_cst_u_data_entry
end type
type st_select from statictext within pfc_cst_u_data_entry
end type
type dw_addresses from u_dw within pfc_cst_u_data_entry
end type
type st_recs from statictext within pfc_cst_u_data_entry
end type
type dw_ver_data from u_dw within pfc_cst_u_data_entry
end type
type dw_select_section from u_dw within pfc_cst_u_data_entry
end type
type dw_loc_defaults from u_dw within pfc_cst_u_data_entry
end type
type r_1 from rectangle within pfc_cst_u_data_entry
end type
type dw_link_list from u_dw within pfc_cst_u_data_entry
end type
type dw_detail from u_dw within pfc_cst_u_data_entry
end type
type dw_browse from u_dw within pfc_cst_u_data_entry
end type
type tab_view from tab within pfc_cst_u_data_entry
end type
type tabpage_browse from userobject within tab_view
end type
type tabpage_browse from userobject within tab_view
end type
type tabpage_details from userobject within tab_view
end type
type tabpage_details from userobject within tab_view
end type
type tabpage_image from userobject within tab_view
end type
type dw_detail_2 from u_dw within tabpage_image
end type
type tabpage_image from userobject within tab_view
dw_detail_2 dw_detail_2
end type
type tabpage_linked_data from userobject within tab_view
end type
type uo_linked_data from pfc_cst_u_address_linked_data within tabpage_linked_data
end type
type uo_cert_period from pfc_cst_u_cert_periods within tabpage_linked_data
end type
type tabpage_linked_data from userobject within tab_view
uo_linked_data uo_linked_data
uo_cert_period uo_cert_period
end type
type tab_view from tab within pfc_cst_u_data_entry
tabpage_browse tabpage_browse
tabpage_details tabpage_details
tabpage_image tabpage_image
tabpage_linked_data tabpage_linked_data
end type
end forward

global type pfc_cst_u_data_entry from userobject
integer width = 3762
integer height = 2020
boolean border = true
long backcolor = 79741120
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event pfc_cst_preupdate ( )
event pfc_cst_field_defaults ( )
event pfc_cst_update_dddw ( )
event type integer ue_after_itemchanged ( )
event pfc_cst_nextrecord ( )
event pfc_cst_import_photo ( )
event pfc_cst_priorrecord ( )
cb_decheck cb_decheck
st_dw_select_section_border st_dw_select_section_border
cb_view_relation cb_view_relation
st_select st_select
dw_addresses dw_addresses
st_recs st_recs
dw_ver_data dw_ver_data
dw_select_section dw_select_section
dw_loc_defaults dw_loc_defaults
r_1 r_1
dw_link_list dw_link_list
dw_detail dw_detail
dw_browse dw_browse
tab_view tab_view
end type
global pfc_cst_u_data_entry pfc_cst_u_data_entry

type variables

pfc_cst_nv_data_entry_functions inv_data_entry
pfc_cst_u_verification_info inv_verification_info
w_prac_data_1 parent_window
//w_prac_data_design parent_window_design //Delete by Evan 12.14.2010

w_prac_profile_design parent_window_profile_design

Integer ii_screen_id
Integer ii_column_cnt
Integer ii_address_lnk_cnt
Integer il_last_de_row

Long il_prac_id 
Long il_rec_id
Long il_data_view = 1
Integer ii_org_id = 1
long ii_parent_facility_id 
long ii_org_parent  //maha 07.15.2015 
long il_affil_recid  //maha 07.15.2015 
long ii_verifying_facility_id
Long il_addr_id
long il_hosp_id
long il_gp_id //maha 06.30.2014

Boolean ib_screen_painter = False
Boolean ib_new_prac = False
Boolean ib_setup_dddw = True
Boolean ib_refresh_screen_list = False
Boolean ib_app_audit_complete = False
Boolean ib_win_just_opened = True
Boolean ib_deleting = False
Boolean ib_ezflow = False
Boolean is_rec_status
Boolean ib_addaddress = false 
Boolean ib_add = True  //maha 01.15.2012
Boolean ib_test_save = true //02.27.2014
Boolean ib_facil_links
boolean ib_cert_period = false
n_ds ids_parent_facilities

String is_first_column_detail_1
String is_first_column_detail_2
String is_sql_syntax
String is_rec_id_col_nm
String is_column_names[]
String is_view_type = "D"
String is_lookup_search_column= "None"
String is_lookup_search_column_table = ""
String is_lookup_search_column_field= "None"  //maha 01.05.2014
String is_designer_type = "S"
string is_dropvalue  //09.24.2015 #V15 maha

Integer il_last_row = 1
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<add> 03.03.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Define a variable and set it to TRUE. It will be used by subsequent script.
boolean ib_just_open = true
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.12.2006 By: Jack (Inova)
//$<reason> Queue Images for Scanning from Data Entry.
datastore ids_image_data
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 25/08/2008 By: Alan
Boolean	ib_report = False
//w_prac_report_design parent_window_design_report //Delete by Evan 12.14.2010
//---------------------------- APPEON END ----------------------------

n_cst_dataflow inv_dataflow //dataflow: alfee 12.22.2009
datastore    ids_tablename  //03.23.2011 By: stephen


end variables

forward prototypes
public function integer of_get_record_verif (integer rownum)
public function integer of_set_parent_window (w_prac_data_1 awin)
public function integer of_setup (boolean ab_new_prac)
public function integer of_set_prac_id (long al_prac_id)
public function integer of_set_verification_info (pfc_cst_u_verification_info aobject)
public function integer of_set_verifying_facility (integer ai_verifying_facility)
public function integer of_get_row ()
public function integer of_setfocus_detail ()
public function integer of_setfocus_browse ()
public function integer of_get_selected_view_tab ()
public function integer of_detail_btt ()
public function integer of_btt_browse ()
public function integer of_btt_detail ()
public function integer of_get_row_selector ()
public function boolean of_is_prac_id_null ()
public function integer of_get_row_count_detail ()
public function integer of_set_ib_screen_painter (boolean ab_val)
public function boolean of_get_ib_screen_painter ()
public function integer of_set_data_view_id (long al_data_view_id)
public function integer of_set_parent_facility_id (integer ai_parent_facility_id)
public function integer of_set_data_entry_complete ()
public function integer of_get_parent_facility_id ()
public function integer of_btt_address_link_button ()
public function integer of_delete_record (u_dw adw)
public function integer of_select_de_screen (string as_direction)
public function integer of_npdb_query ()
public function integer of_add_ver_entry ()
public function integer of_add_address_link (long al_address_id)
public function integer of_add_delete_enable ()
public function integer of_set_de_complete_date_null ()
public function integer of_add_hosp_link (readonly long ai_hosp_id)
public function integer of_add_spec_link (long ai_rec_id)
public function integer of_address_link_check ()
public function integer of_designer_type (string as_type)
public function integer of_oig_query ()
public function integer of_validate (integer ai_table, integer ai_row)
public function integer of_lookup_search_dddw (string as_type)
public function integer of_screen_color ()
public function integer of_dwchild_retrieve (string as_lu_table, string as_type, u_dw adw_dw, string as_from, long al_value, string as_column_nm)
public function integer of_lookup_search (string as_type)
public function integer of_add_questions (string as_from)
public function integer of_add_npdb (long al_prac_id, long al_rec_id, long al_screen_id, string as_reference, datetime adt_exp_date, string as_screen_name, long al_address_lookup_code, string as_add_type, integer ai_parent_facility_id)
public function integer of_add_oig (long al_prac_id, long al_rec_id, integer ai_parent_facility)
public function integer of_error_message (string as_field, integer ai_row, string as_title, string as_mess)
public function integer of_detail_scrollbar (integer ai_screen_id)
public function integer of_validate_image ()
public subroutine of_refresh_page_menu ()
public function long of_download_photo (long al_pracid, string as_downdir)
public function integer of_links_security (integer ai_screen)
public function integer of_delete_photo ()
public function integer of_bg_color (long al_rgb)
public function integer of_filter_links (string as_filter)
public function string of_get_reference ()
public function integer of_validate_dea (string as_data, string as_name)
public function integer of_modify_dw_access (long al_prac_id, u_dw adw_detail)
public function integer of_reset ()
public function integer of_set_affil_recid (long al_recid)
public function integer of_find_address ()
public subroutine of_refresh_screen ()
public function integer of_post_resize ()
public function integer of_address_link_clear (long al_id)
public function integer of_appl_action_inactive (long al_gp_id, ref long al_prac)
public function integer of_entity_update (long al_id)
public function integer of_addr_check_link_to_loc (integer ai_row, long al_loc)
public subroutine of_zoom ()
public function integer of_add_cert_period (integer ai_screen, long al_recid, integer al_row, boolean ab_mess)
public function integer of_filter_cert_period (long al_screen, long al_recid)
end prototypes

event pfc_cst_preupdate;dw_detail.TriggerEvent( "pfc_cst_preupdate" )

end event

event pfc_cst_field_defaults;inv_data_entry.of_set_defaults( dw_detail, dw_detail.GetRow() )
end event

event pfc_cst_update_dddw();inv_data_entry.of_update_dddw( dw_detail, dw_browse )
IF IsValid( m_pfe_cst_data_entry ) THEN
	//m_pfe_cst_data_entry.m_edit.m_lookupsearch.Enabled = True
	gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_edit.m_lookupsearch,'Enabled', True)
END IF	

end event

event type integer ue_after_itemchanged();string s
//debugbreak()

s = String(Message.LongParm, "address")
//messagebox("s",s)
of_lookup_search(s)

return 1
end event

event pfc_cst_nextrecord();integer i
i = dw_browse.getrow()
if i < dw_browse.rowcount() then
	dw_browse.setrow(i+1)
//	dw_browse.selectrow(0,false)   //Start Code Change ----01.20.2016 #V15 maha - removed
//	dw_browse.selectrow(i+1,true)
	dw_browse.scrolltorow(i+1)
	dw_browse.setredraw(true)   //Start Code Change ----08.09.2017 #V154 maha
end if

If tab_view.selectedtab =2 Then dw_detail.setfocus() //Added by Appeon long.zhang 10.10.2016 ( Alpha id 5352 - Records not highlighting when clicking Next and Prior)
end event

event pfc_cst_import_photo();//------------------------------------------------------------------------------
// Event: pfc_cst_import_photo()
//------------------------------------------------------------------------------
// Description: Import Photo
// Arguments:
//		None
// Return Value: 
//		None
//------------------------------------------------------------------------------
// Author:	Scofield		Date: 2008-07-10
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

String	ls_PicPath,ls_FullName,ls_PicName,ls_Postfix,ls_CurDirectory
string ls_userid
long		ll_Rtn,ll_FileNo,ll_ReadCnts,ll_Cnts
Blob		lblb_ImageData,lblb_Buffer
datetime ldt_today

//------------------- APPEON BEGIN -------------------
//$<modify> Evan 05.14.2009
//$<reason> Corrected BugA090201
if Parent_Window.tab_1.tabpage_detail.p_face.Visible then
	if MessageBox("Import Photo", "Reimporting photo will replace the existing photo, do you want to continue?", Question!, YesNo!) = 2 then
		Return
	end if
end if
//------------------- APPEON END ---------------------

ls_CurDirectory = GetCurrentDirectory()

ll_Rtn = GetFileOpenName("Open",ls_FullName,ls_PicName,"bmp","Bitmap Files (*.bmp),*.bmp,JPG Files (*.jpg),*.jpg,GIF Files (*.GIF),*.gif")
if ll_Rtn <> 1 then Return

ChangeDirectory(ls_CurDirectory)

ls_Postfix = Mid(ls_PicName,LastPos(ls_PicName,".") + 1)

ll_FileNo = FileOpen(ls_FullName,StreamMode!,Read!,LockReadWrite!)
if ll_FileNo <= 0 then Return

ll_ReadCnts = FileRead(ll_FileNo,lblb_Buffer)
do while ll_ReadCnts > 0
	lblb_ImageData += lblb_Buffer
	ll_ReadCnts = FileRead(ll_FileNo,lblb_Buffer)
loop

FileClose(ll_FileNo)

if Len(lblb_ImageData) <= 0 then Return

SELECT COUNT(*) INTO :ll_Cnts FROM pd_photo WHERE pd_photo.prac_id = :il_prac_id ;
if ll_Cnts <= 0 then
	//---------Begin Modifieded by (Appeon)Stephen 11.10.2014 for add an upload date and time to pd_photo--------
	//INSERT INTO pd_photo(prac_id) VALUES(:il_prac_id) ;
	ldt_today = datetime(today(),now())
	ls_userid = gs_user_id	
	INSERT INTO pd_photo(prac_id, create_date, create_user) VALUES(:il_prac_id, :ldt_today, :ls_userid) ;
	//--------End Modified
end if

//---------Begin Modifieded by (Appeon)Stephen 11.10.2014 for add an upload date and time to pd_photo--------
//UPDATE pd_photo SET image_type = :ls_Postfix WHERE pd_photo.prac_id = :il_prac_id ;
if isnull(ls_userid) or ls_userid = '' then
	ldt_today = datetime(today(),now())
	UPDATE pd_photo SET image_type = :ls_Postfix, mod_date = :ldt_today, mod_user = :gs_user_id WHERE pd_photo.prac_id = :il_prac_id ;
else
	UPDATE pd_photo SET image_type = :ls_Postfix WHERE pd_photo.prac_id = :il_prac_id ;
end if
//--------End Modified
UPDATEBLOB pd_photo SET image_data = :lblb_ImageData WHERE pd_photo.prac_id = :il_prac_id ;

ls_PicPath = TRIM(gnv_data.of_getitem("ids","picture_path",false))
if Right(ls_PicPath,1) <> "\" then ls_PicPath += "\"

ll_Rtn = of_Download_Photo(il_prac_id,ls_PicPath)

if ll_Rtn = 1 then
	Parent_Window.tab_1.tabpage_detail.p_face.PictureName = ""
	Parent_Window.tab_1.tabpage_detail.p_face.PictureName = ls_PicPath + String(il_prac_id) + "." + ls_Postfix
end if

if ii_screen_id = 1 then
	Parent_Window.tab_1.tabpage_detail.p_face.Visible = true
	Parent_Window.tab_1.tabpage_detail.p_face.BringToTop = true
else
	Parent_Window.tab_1.tabpage_detail.p_face.Visible = false
end if

end event

event pfc_cst_priorrecord();//Start Code Change ----03.27.2012 #V12 maha
integer i
i = dw_browse.getrow()
if i > 1 then
	dw_browse.setrow(i - 1)
//	dw_browse.selectrow(0,false)   //Start Code Change ----01.20.2016 #V15 maha - removed
//	dw_browse.selectrow(i - 1,true)
	dw_browse.scrolltorow(i - 1)
	dw_browse.setredraw(true)   //Start Code Change ----08.09.2017 #V154 maha
end if

If tab_view.selectedtab =2 Then dw_detail.setfocus() //Added by Appeon long.zhang 10.10.2016 ( Alpha id 5352 - Records not highlighting when clicking Next and Prior)
end event

public function integer of_get_record_verif (integer rownum);//Long li_rec_id
//Integer li_cr
//
//
//IF rownum < 1 THEN
//	Return -1
//END IF
//	
//li_rec_id = dw_detail.GetItemNumber( rownum, "rec_id" )
//
//IF Not IsNull( li_rec_id ) THEN
//	dw_ver_data.SetFilter( "rec_id = " + String( li_rec_id ) + " AND facility_id = " + String( ii_verifying_facility_id ) )
//	dw_ver_data.Filter( )
//	//messagebox("", ii_verifying_facility_id )
//END IF
	



Return 0
end function

public function integer of_set_parent_window (w_prac_data_1 awin);parent_window = awin

Return 0
end function

public function integer of_setup (boolean ab_new_prac);dw_detail.of_SetDropDownCalendar( TRUE )
tab_view.tabpage_image.dw_detail_2.of_SetDropDownCalendar( TRUE )
//dw_ver_data.of_SetDropDownCalendar( TRUE )
ib_just_open = true
dw_select_section.Reset()
dw_select_section.of_SetTransObject(SQLCA)

if ib_report=false then
	dw_select_section.Retrieve( il_data_view )
	
// RP	dw_select_section.SelectRow( 1, True )
	
	IF ab_new_prac THEN
		st_recs.Text = "Record 1 of 1"
	ELSE
		if dw_detail.rowcount() > 0 then
			il_rec_id = dw_detail.GetItemNumber( 1, "rec_id" )
		end if
	END IF
else
	dw_select_section.Retrieve( il_data_view,999 ) //default 999
// RP	dw_select_section.SelectRow( 1, True )
end if


Return 1
end function

public function integer of_set_prac_id (long al_prac_id);il_prac_id = al_prac_id



Return 1
end function

public function integer of_set_verification_info (pfc_cst_u_verification_info aobject);
Return 0
end function

public function integer of_set_verifying_facility (integer ai_verifying_facility);ii_verifying_facility_id = ai_verifying_facility


Return 1
end function

public function integer of_get_row ();Return dw_detail.GetRow()
end function

public function integer of_setfocus_detail ();dw_detail.SetFocus()

Return 1
end function

public function integer of_setfocus_browse ();dw_browse.SetFocus()

Return 1
end function

public function integer of_get_selected_view_tab ();Return tab_view.SelectedTab

end function

public function integer of_detail_btt ();dw_detail.BringToTop = True

//if is_screen_name = "Hospital Affiliation" or is_screen_name = "Address" or is_screen_name = "Board/Specialty"then
//if is_screen_name = "Hospital Affiliation" or is_screen_name = "Address" then
if ii_screen_id = 10 or ii_screen_id = 2 or ii_screen_id = 19 then
	dw_link_list.bringtotop = True
end if

Return 1
end function

public function integer of_btt_browse ();dw_browse.BringToTop = True

//if is_screen_name = "Hospital Affiliation" or is_screen_name = "Address" or is_screen_name = "Board/Specialty"then
//if is_screen_name = "Hospital Affiliation" or is_screen_name = "Address" then
if ii_screen_id = 10 OR ii_screen_id = 2 OR ii_screen_id = 19 THEN
	dw_link_list.bringtotop = True
end if

Return 1
end function

public function integer of_btt_detail ();dw_detail.BringToTop = True

//if is_screen_name = "Hospital Affiliation" or is_screen_name = "Address" or is_screen_name = "Board/Specialty"then
//if is_screen_name = "Hospital Affiliation" or is_screen_name = "Address" then
if ii_screen_id = 10 OR ii_screen_id = 2 OR ii_screen_id = 19 THEN
	dw_link_list.bringtotop = True
end if

Return 1
end function

public function integer of_get_row_selector ();Return dw_select_section.GetRow()
end function

public function boolean of_is_prac_id_null ();IF IsNull( dw_detail.GetItemNumber(1, "prac_id" ) ) THEN
	Return True
ELSE
	Return False
END IF
end function

public function integer of_get_row_count_detail ();Return dw_detail.RowCount()
end function

public function integer of_set_ib_screen_painter (boolean ab_val);ib_screen_painter = ab_val

Return 1
end function

public function boolean of_get_ib_screen_painter ();Return ib_screen_painter 
end function

public function integer of_set_data_view_id (long al_data_view_id);il_data_view = al_data_view_id

Return 0
end function

public function integer of_set_parent_facility_id (integer ai_parent_facility_id);ii_parent_facility_id = ai_parent_facility_id
ii_org_parent = ai_parent_facility_id   //Start Code Change ----07.15.2015 #V15 maha - for use with facility specific screens

Return 0
end function

public function integer of_set_data_entry_complete ();Integer li_org_id,li_flag
DateTime todaysdate 
datetime ld_null  //maha 05.20.2015
boolean lb_de_comp_flag   //12.13.2006 By Jervis
boolean lb_fail  = false //05.26.2016
boolean lb_pass = true //06.02.2016
boolean lb_addresscheck = false // stephen 07.25.2016
Integer li_address_cnt1, li_address_cnt2, li_address_cnt3 
long ll_appt_id // maha 05.20.2015
integer res //maha 05.11.2016
integer res_doc //maha 06.02.2016
string ls_mess

gnv_appeondb.of_startqueue( )

//check for required data
SELECT Count(*)  
INTO :li_address_cnt1  
FROM pd_address,   
     pd_address_link  
WHERE ( pd_address.rec_id = pd_address_link.address_id ) and  
      ( pd_address.prac_id = pd_address_link.prac_id ) and  
      ( ( pd_address.prac_id = :il_prac_id ) AND  
      ( pd_address_link.exp_letters = 1 ) )   ;

//check for mailing data
SELECT Count(*)  
INTO :li_address_cnt2  
FROM pd_address,   
     pd_address_link  
WHERE ( pd_address.rec_id = pd_address_link.address_id ) and  
      ( pd_address.prac_id = pd_address_link.prac_id ) and  
      ( ( pd_address.prac_id = :il_prac_id ) AND  
      ( pd_address_link.mailing = 1 ) )   ;


//check for specialty
SELECT Count(*)  
INTO :li_address_cnt3 
FROM pd_board_specialty,   
     code_lookup  
WHERE ( pd_board_specialty.specialty_order = code_lookup.lookup_code ) and  
      ( pd_board_specialty.prac_id = :il_prac_id ) AND  
      ( code_lookup.code = 'Primary' )  ;

COMMIT USING SQLCA;

//$<reason> Add the Appeon Queue Labels. 
gnv_appeondb.of_commitqueue( )

IF li_address_cnt1 = 0 THEN
	MessageBox("Incomplete", "You must have at least one address setup as an address for expiring credential letters.  Check the Address screen Address Links for this.", Information! )
	//RETURN -1
	//---------Begin Modified by (Appeon)Stephen 07.25.2016 for BugS062201--------
	//lb_fail = true
	lb_addresscheck = true
	//---------End Modfiied ------------------------------------------------------	
END IF

IF li_address_cnt2 = 0 THEN
	MessageBox("Incomplete", "You must have at least one address setup as a mailing address.  Check the Address screen Address Links for this.", Information! )
	//RETURN -1
	//---------Begin Modified by (Appeon)Stephen 07.25.2016 for BugS062201--------
	//lb_fail = true  
	lb_addresscheck = true
	//---------End Modfiied ------------------------------------------------------	
END IF

IF li_address_cnt3 = 0 THEN
	MessageBox("Important data", "IntelliCred/App expects each practitoner to have a Primary Specialty.~rWithout this, certain letters and reports will not run for that practitioner.~r~rGo to the Board Specialty screen to enter this data.", Information! )
END IF
debugbreak()
//Start Code Change ----06.02.2016 #V152 maha - modified to allow function completion with failure
//Start Code Change ----05.11.2016 #V15 maha - DE requirement check
res = inv_data_entry.of_check_required_data( il_data_view, il_prac_id, ii_parent_facility_id)
if res < 0 then
	lb_fail = true
	if res = -1 then lb_pass = false  //-2 = pass
elseif res = 0 then  //no requirements
	ls_mess = ""
else //req - no errors
	ls_mess = "Data Requirements Validation"
end if
//End Code Change ----05.11.2016

//Start Code Change ----07.18.2016 #V152 maha
//Start Code Change ----05.25.2016 #V15 maha -Image requirement check
res_doc = inv_data_entry.of_check_required_documents( il_data_view, il_prac_id, ii_parent_facility_id)
if res_doc < 0 and lb_pass = true then 
	if res_doc < 0 then
		lb_fail = true
		//lb_pass = false
		if res = -1 then lb_pass = false  //-2 = pass  //Start Code Change ----08.31.2017 #V154 maha
	elseif res = 0 then  //no requirements
		if ls_mess = "" then
			ls_mess = "NONE"
		else
			//ls_mes from data req
		end if
	else  //req- no error
		if ls_mess = "" then
			ls_mess = "Document Requirements Validation"
		else
			ls_mess = "Data and Document Requirements Validation"
		end if
	end if
end if
//End Code Change ----07.18.2016 - improved messaging

//Start Code Change ----06.02.2016 #V152 maha - if allowed to pass with errors open error window
if lb_fail then 
	openwithparm(w_req_data_error_list, il_prac_id)
elseif lb_addresscheck = false then //(Appeon)Stephen 07.25.2016 - BugS062201 
	//messagebox(ls_mess,"No errors found") - commented by alfee 10.10.2016 for Alpha id 5353
end if

if lb_pass = false then 
	return -1
end if
//End Code Change ----05.25.2016
//End Code Change ----06.02.2016

Date ld_today
Time lt_today
ld_today = Date(today())
lt_today = Time(now())
todaysdate = Datetime(ld_today,lt_today)

lb_de_comp_flag = true

 //Start Code Change ----05.20.2015 #V15 maha - modified to work correctly with mid-cycle
if parent_window.tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_detail_1.dw_apptmnt_status.GetRow() > 0 then //(Appeon)Stephen 09.02.2016 - V15.1 Bug #5315 - DE compl button is not working on Demographics tab
	parent_window.il_affil_rec_id = parent_window.tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_detail_1.dw_apptmnt_status.GetItemNumber(parent_window.tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_detail_1.dw_apptmnt_status.GetRow(), 'rec_id')//(Appeon)Stephen 08.19.2016 - Bug #5295: DE Complete button malfunction
end if
ll_appt_id = parent_window.il_affil_rec_id
 
select 1 into :li_flag from pd_affil_stat 
WHERE ( pd_affil_stat.rec_id = :ll_appt_id ) AND  ( pd_affil_stat.date_data_entry_completed is null );
//WHERE ( pd_affil_stat.prac_id = :il_prac_id ) AND 
//			( pd_affil_stat.parent_facility_id = :ii_parent_facility_id ) and 
//         ( pd_affil_stat.active_status in (1,4) ) and //maha  changed to include pending 072402
//			//( pd_affil_stat.verifying_facility_id = ii_verifying_facility_id ) and // maha added 020501 to update only for the current verifying facility
//			 ( pd_affil_stat.date_data_entry_completed is null ); // maha added 111300 to stop reset of previously set dates

if sqlca.sqlcode = 100 then
	lb_de_comp_flag = false
else
	gnv_appeondb.of_autocommit( )
	UPDATE pd_affil_stat  
	SET date_data_entry_completed = :todaysdate  
	WHERE ( pd_affil_stat.rec_id = :ll_appt_id ) AND  ( pd_affil_stat.date_data_entry_completed is null );
//	WHERE ( pd_affil_stat.prac_id = :il_prac_id ) AND 
//				( pd_affil_stat.parent_facility_id = :ii_parent_facility_id ) and 
//				( pd_affil_stat.active_status in (1,4) ) and //maha  changed to include pending 072402
//				//( pd_affil_stat.verifying_facility_id = ii_verifying_facility_id ) and // maha added 020501 to update only for the current verifying facility
//				 ( pd_affil_stat.date_data_entry_completed is null ); // maha added 111300 to stop reset of previously set dates
	
	Commit Using SQLCA;
end if

// maha - //Add audit record - 
setnull(ld_null)
inv_data_entry.of_field_audit_de_compl(ll_appt_id,il_prac_id, "de_comp_date", ld_null ,todaysdate, ii_parent_facility_id)
//End Code Change ----05.20.2015

//m_pfe_cst_data_entry.m_file.m_dataentrycomplete.toolbaritemname = "Custom026!"
gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_file.m_dataentrycomplete,'toolbaritemname', "Custom026!")

//NPDB/OIG creation
IF of_npdb_query() = -1 THEN
	ROLLBACK USING SQLCA;
	RETURN -1
END IF

IF of_oig_query() = -1 THEN
	ROLLBACK USING SQLCA;
	RETURN -1
END IF

//---------------------------- APPEON END ----------------------------

//Added for Work Flow. Trigger off the related work flow. 1/11/2006 Henry
long	ll_wf_id
long	ll_screens[]
string ls_module
//If gb_workflow Then
if gb_workflow and lb_de_comp_flag then		//12.13.2006 By Jervis
	n_cst_workflow_triggers lnv_trigger
	lnv_trigger = create n_cst_workflow_triggers
	
	//Trigger all data value comparision work flow
	If of_Get_app_setting("set_9" , "I") = 1 Then
		ls_module = '02'
	Else
		ls_module = '01'
	End if
	ll_screens = dw_select_section.object.screen_id[1,dw_select_section.Rowcount()]
	//lnv_trigger.of_compare( ll_screens, il_prac_id, ii_parent_facility_id, ls_module, 'C')
	lnv_trigger.of_data_value_comparision( ll_screens, il_prac_id, ii_parent_facility_id, ls_module, 'C')
	
	ll_wf_id = long(gnv_data.of_getitem("facility","facility_wf_data_entry_complete","facility_id="+string(ii_parent_facility_id)))
	If isnull(ll_wf_id) or not ll_wf_id > 0 Then return 0
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 11.17.2006 By: Jervis
	//$<reason> 
	//lnv_trigger.of_workflow_create_action_items( il_prac_id, il_rec_id, 1, ii_parent_facility_id, ll_wf_id)
	str_action_item lstr_action
	lstr_action.prac_id = il_prac_id
	lstr_action.rec_id = il_rec_id
	lstr_action.facility_id = ii_parent_facility_id
	lstr_action.screen_id = -10
	lstr_action.wf_id = ll_wf_id
	lnv_trigger.of_workflow_create_action_items(lstr_action)
	//---------------------------- APPEON END ----------------------------
	destroy lnv_trigger
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 12.20.2006 By: Jervis
	//$<reason> refresh data for IntelliApp
	parent_window.of_retrieve_net()
	//---------------------------- APPEON END ----------------------------

	
	//---------------------------- APPEON END ----------------------------

End If
//End added for Work Flow. 1/11/2006 Henry



Return 0
end function

public function integer of_get_parent_facility_id ();Return ii_parent_facility_id

end function

public function integer of_btt_address_link_button ();

IF dw_select_section.GetRow() > 0 THEN
	IF UPPER(dw_select_section.GetItemString( dw_select_section.GetRow(), "screen_name" )) = "ADDRESS" AND tab_view.SelectedTab = 2 THEN
		ii_address_lnk_cnt++
		IF ii_address_lnk_cnt > 1 THEN
			dw_detail.vscrollbar = True
		END IF	
	END IF
END IF

Return 1
end function

public function integer of_delete_record (u_dw adw);Long ll_rec_id
long ll_gp  //maha 04.14.2015
Integer li_cnt
Integer li_cnt1

Integer li_ans

IF adw.GetItemStatus( adw.GetRow(), 0 , Primary! ) = New! OR +&
	adw.GetItemStatus( adw.GetRow(), 0 , Primary! ) = NewModified! THEN
	adw.DeleteRow( 0 )
	//IF adw.RowCount() = 0 THEN
	//	adw.InsertRow( 0 )	
	//	tab_view.SelectTab( 1 )
	//	dw_detail.BringToTop = True	
	//END IF	
//	adw.SetRow( 1 )
//	adw.ScrollToRow( 1 )
//	dw_browse.SelectRow( 0, False )
//	dw_browse.SelectRow( 1, True )
//
//	adw.SetColumn( inv_data_entry.of_get_first_column() )
//	adw.SetFocus()
ELSE
	if ii_screen_id = 1 then //maha trap added 091304
		MessageBox( "Delete Error", "You cannot delete the practitioner basic information record.")
		return -1
	end if
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 2005-11-16 By: Liang QingShi
	//$<reason> Fix a defect.

	  if dw_detail.GetRow() <= 0 then return -1
	//---------------------------- APPEON END ----------------------------

   ll_rec_id = dw_detail.GetItemNumber( dw_detail.GetRow(), "rec_id" )
	 //Start Code Change ----04.14.2015 #V15 maha
	if dw_detail.Describe("gp_id.ColType") <> "!" then
		ll_gp = dw_detail.GetItemNumber( dw_detail.GetRow(), "gp_id" )
	end if
	//Start Code Change ----04.14.2015


	gnv_appeondb.of_startqueue( )
//Start Code Change ----01.26.2015 #V14.2 maha - added screen to querys
	//select count(rec_id) into :li_cnt1 from pd_images where rec_id = :ll_rec_id;
	select count(rec_id) into :li_cnt1 from pd_images where rec_id = :ll_rec_id and screen_id = :ii_screen_id ;
	
// 	SELECT Count( rec_id )  
//	INTO :li_cnt  
//     FROM verif_info  
//     WHERE verif_info.rec_id = :ll_rec_id   ;
	  
	SELECT Count( rec_id )  
	INTO :li_cnt  
     FROM verif_info  
     WHERE verif_info.rec_id = :ll_rec_id  and screen_id = :ii_screen_id ;
//End Code Change ----01.26.2015	
	
	
	gnv_appeondb.of_commitqueue( )

	if li_cnt1 > 0 then
		li_ans = MessageBox("Delete", "There is an image record associated with this data record.  It must be deleted from the image tab before deleting the data record or the tif file will be out of sync with the imade data." )
		return -1
	end if

	IF SQLCA.SQLCODE = -1 THEN
		MessageBox( "Database Error", "Error in record count.")
		Return -1
	END IF
	//---------------------------- APPEON END ----------------------------

	IF li_cnt > 0 THEN
		li_ans = MessageBox("Delete", "There are verification records associated with this record.  Are you sure you want to delete?", Question!, YesNo!, 2 )
		IF li_ans = 1 THEN
			DELETE FROM verif_info
			WHERE rec_id = :ll_rec_id
			and screen_id = :ii_screen_id ;   //Start Code Change ----01.26.2015 #V14.2 maha - added screen_id to SQL
			IF SQLCA.SQLCODE = -1 THEN
				MessageBox( "Database Error", SQLCA.SQLERRTEXT )
				Return -1
			END IF			
		ELSE
			Return -1
		END IF
	else //maha added 083104
		li_ans = MessageBox("Delete", "Are you sure you want to delete this record?", Question!, YesNo!, 2 )
		IF li_ans = 2 THEN
			return -1
		end if
	END IF
	inv_data_entry.of_field_audit_delete_last( dw_detail, dw_detail.GetRow())
	delete pd_app_audit where de_rec_id = :ll_rec_id; //Start Code Change ---- 10.25.2006 #1 maha
	dw_detail.DeleteRow( dw_detail.GetRow() )

	//delete any data in dw_detail_2
	IF tab_view.tabpage_image.Visible THEN
		tab_view.tabpage_image.dw_detail_2.SetFilter( "rec_id = " + String( ll_rec_id ) )
		tab_view.tabpage_image.dw_detail_2.Filter( )
		IF tab_view.tabpage_image.dw_detail_2.RowCount( ) > 0 THEN
			tab_view.tabpage_image.dw_detail_2.DeleteRow( 0 )
		END IF
	END IF
	
	ib_deleting = True
	parent_window.Event pfc_Save()
	ib_deleting = False	
END IF
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.17.2006 By: Jack (Inova)
//$<reason> Required Documents Check Box on Data Entry Screen.
gnv_appeondb.of_startqueue( )
delete from pd_app_audit_temp where de_rec_id = :ll_rec_id;
delete from pd_app_audit where de_rec_id = :ll_rec_id;

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 03.16.2015
//<$>reason:Requesting new V14.2 Web Package
//update net_dev_ids set address_id = null where address_id = :ll_rec_id;  //Start Code Change ----08.09.2013 #V14 maha - added
//Start Code Change ----04.14.2015 #V15 maha - change update to loc link value
if ll_gp > 0 then
	 //Start Code Change ----05.03.2017 #V153 maha - added error trapping (Columbia)
	//if of_addr_check_link_to_loc( dw_detail.getrow(), ll_gp) = 0 then
	if of_addr_check_link_to_loc( 0, ll_gp) = 0 then//should not use getrow() because this row was deleted above, modified by Appeon long.zhang 05.04.2017 (Bug IDs #5627 & #5628: Net Dev issues with multiple Address records linked to the same Practice Location ID)
		update net_dev_ids set address_id = 0 where prac_id = :il_prac_id and address_id = :ll_gp;   //maha added pracid to the update
	end if
	 //End Code Change ----05.03.2017
end if
//update net_dev_ids set address_id = 0 where address_id = :ll_rec_id;
//End Code Change ----04.14.2015 
//------------------- APPEON END -------------------
	
gnv_appeondb.of_commitqueue( )
//Start Code Change ----03.19.2013 #V12 maha = changed to variable
//if isvalid(w_prac_data_1) then
//	w_prac_data_1.ib_app_audit_retrieved = False
//end if
gw_prac_data.ib_app_audit_retrieved = False
gw_prac_data.ib_net_retrieved = False   //Start Code Change ----08.09.2013 #V14 maha - added
//End Code Change ----03.19.2013
//---------------------------- APPEON END ----------------------------

//\/maha 012201
//if is_screen_name = "Hospital Affiliation" then
if ii_screen_id = 10 then
	delete from pd_hosp_facility_link
	where hosp_affil_id = :ll_rec_id;
	IF SQLCA.SQLCODE = -1 THEN
		MessageBox( "Database Error", "Error deleting hospital links.")
		Return -1
	end if
END IF				

//if is_screen_name = "Address" then
if ii_screen_id = 2 then
	delete from pd_address_link
	where address_id = :ll_rec_id;
	IF SQLCA.SQLCODE = -1 THEN
		MessageBox( "Database Error", SQLCA.SQLERRTEXT )
		Return -1
	end if
END IF

//maha 082001
//if is_screen_name = "Board/Specialty" then
if ii_screen_id = 19 then
	delete from pd_spec_facility_link
	where specialty_id = :ll_rec_id;
	IF SQLCA.SQLCODE = -1 THEN
		MessageBox( "Database Error", "Error deleting specialty links.")
		Return -1
	end if
END IF
//\maha

IF dw_browse.RowCount() = 0 THEN
	dw_browse.Event pfc_AddRow()
END IF

of_refresh_page_menu() //Added By Ken.Guo 06.10.2008

RETURN 1	

end function

public function integer of_select_de_screen (string as_direction);Integer li_cr
Integer li_row_cnt

li_cr =	dw_select_section.GetRow()
li_row_cnt = dw_select_section.RowCount()

IF as_direction = "N" THEN
	IF li_cr = li_row_cnt THEN
		Beep(2)
		Return -1
	ELSE
		li_cr++
		dw_select_section.SetRow( li_cr )
		dw_select_section.ScrollToRow( li_cr )
	END IF
ELSE
	IF li_cr = 1 THEN
		Beep(2)
		Return -1
	ELSE
		li_cr --
		dw_select_section.SetRow( li_cr )
		dw_select_section.ScrollToRow( li_cr )
	END IF		
END IF

RETURN 0
end function

public function integer of_npdb_query ();Integer li_cnt,li_cnt2,li_cnt3
Long ll_rec_id
Long ll_npdb_query
String ls_val
String ls_npdb_verify_data
String ls_appt_type
String ls_work_gap_check
String ls_npdb_query_type
DateTime ldt_exp_date
integer li_one_facil //maha 020901

//select npdb_multi//maha 020901
//into :li_one_facil
//from ids;

if isnull(li_one_facil) then li_one_facil = 0

SetNull( ldt_exp_date )


gnv_appeondb.of_startqueue( )

// find out if prac is in initial or reappointment
SELECT pd_affil_stat.apptmnt_type  
INTO :ls_appt_type  
FROM pd_affil_stat  
WHERE ( pd_affil_stat.prac_id = :il_prac_id ) AND  
      ( pd_affil_stat.parent_facility_id = :ii_parent_facility_id ) and 
		(pd_affil_stat.active_status in (1,4)); //maha added 080901  //maha  changed to include pending 072402

//check the rules in the facility painter for the parent facility to see if the
//npdb and or hipdb queryies verification entries should be generated.
SELECT facility.npdb_query_type,
	  facility.npdb_verify_data
INTO :ls_npdb_query_type,
	:ls_npdb_verify_data
FROM facility  
WHERE facility.facility_id = :ii_parent_facility_id   ;

SELECT pd_basic.npdb_query  
INTO :ll_npdb_query
FROM pd_basic  
WHERE pd_basic.prac_id = :il_prac_id   ;

SELECT Count(*)  
INTO :li_cnt  
FROM verif_info  
WHERE ( verif_info.facility_id = :ii_parent_facility_id ) AND  
		( verif_info.prac_id = :il_prac_id ) AND  
		( verif_info.active_status = 1 ) AND  
		( verif_info.reference_value = 'NPDB QUERY' )   ;

SELECT Count(*)  
INTO :li_cnt2
FROM verif_info  
WHERE ( verif_info.facility_id = :ii_parent_facility_id ) AND  
		( verif_info.prac_id = :il_prac_id ) AND  
		( verif_info.active_status = 1 ) AND  
		( verif_info.reference_value = 'HIPDB QUERY' )   ;

SELECT Count(*)  
INTO :li_cnt3  
FROM verif_info  
WHERE ( verif_info.facility_id = :ii_parent_facility_id) AND  
      ( verif_info.prac_id = :il_prac_id ) AND  
      ( verif_info.active_status = 1 ) AND  
      ( verif_info.reference_value = 'Work History Gap Check' )   ;

SELECT facility.work_gap_check
INTO :ls_work_gap_check
FROM facility  
WHERE facility.facility_id = :ii_parent_facility_id;

gnv_appeondb.of_commitqueue( )

	//if o then do not query npdb or hipdb
	IF ls_npdb_query_type <> "O" THEN
		//also check at the prac level to see if the individual prac will need npdb query.
		IF ( ls_appt_type = "I" AND ( ls_npdb_verify_data = "B" OR ls_npdb_verify_data = "I" ) )  OR  +&
		   ( ls_appt_type = "R" AND ls_npdb_verify_data = "B" )  THEN
	   
			ls_val = gnv_data.of_getitem( "code_lookup", "code", "lookup_code = " + String(ll_npdb_query) )

			IF Upper( ls_val ) = 'YES' THEN
				//if its a npdb or both that needs to be performed then add a NPDB query
				IF ls_npdb_query_type = "N" OR ls_npdb_query_type = "B" THEN
					IF li_cnt = 0 THEN			
						ll_rec_id = gnv_app.of_get_id( "RECORD_ID" )	
						//if li_one_facil = 1 then// create for this facility only
							//IF parent_window.tab_1.tabpage_verif.uo_verif_summary.of_add_npdb( il_prac_id, ll_rec_id, 1, "NPDB QUERY",  ldt_exp_date, "NPDB Results", 0, "A", ii_parent_facility_id) = -1 THEN
							IF of_add_npdb( il_prac_id, ll_rec_id, 1, "NPDB QUERY",  ldt_exp_date, "NPDB Results", 0, "A", ii_parent_facility_id) = -1 THEN
								Return -1	
							end if				
					END IF
				END IF
				//if its a hipdb or both that needs to be performed then add a hipdb query
				IF ls_npdb_query_type = "H" OR ls_npdb_query_type = "B" THEN
					IF li_cnt2 = 0 THEN								
						ll_rec_id = gnv_app.of_get_id( "RECORD_ID" )
						//IF parent_window.tab_1.tabpage_verif.uo_verif_summary.of_add_npdb( il_prac_id, ll_rec_id, 1, "HIPDB QUERY",  ldt_exp_date, "HIPDB Results", 0, "A", ii_parent_facility_id) = -1 THEN
						IF of_add_npdb( il_prac_id, ll_rec_id, 1, "HIPDB QUERY",  ldt_exp_date, "HIPDB Results", 0, "A", ii_parent_facility_id) = -1 THEN
							Return -1														//of_add_record
						END IF				
					END IF
				END IF		
			END IF
		END IF
	END IF


IF li_cnt3 = 0 THEN
	//CHECK TO SEE IF A WORK GAP HISTORY CHECK NEEDS TO BE PERFORMED
	//Go to the verifying facility to see if this query is to be performed
	//Create a work history gap check verification entry
	IF ( ls_work_gap_check = "B" AND ls_appt_type = "R" ) OR +&
	   ( ( ls_work_gap_check = "I" or ls_work_gap_check = "B" ) AND ls_appt_type = "I" ) THEN
		ll_rec_id = gnv_app.of_get_id( "RECORD_ID" )
		//IF parent_window.tab_1.tabpage_verif.uo_verif_summary.of_add_npdb( il_prac_id, ll_rec_id, 1, "Work History Gap Check",  ldt_exp_date, "Work Gap", 0, "A", ii_parent_facility_id ) = -1 THEN
		IF of_add_npdb( il_prac_id, ll_rec_id, 1, "Work History Gap Check",  ldt_exp_date, "Work Gap", 0, "A", ii_parent_facility_id ) = -1 THEN
			Return -1														//of_add_record
		END IF				
	END IF
END IF



RETURN 1
end function

public function integer of_add_ver_entry ();//this function for adding a single verification for 1 facility

//debugbreak()

String ls_ref_1
String ls_val
String ls_ref_2
String ls_ref_3
String ls_exp_field
String ls_reference
String ls_rec_status
String ls_screen_name
DateTime ldt_exp_date
DateTime ldt_null_date
Long ll_rec_id
Long ll_address_code
long ll_method = -1 //maha 08.31.2011
Integer li_screen_id
Integer li_current_row
Integer li_cnt
Integer li_rec_count
Integer li_found
Integer li_data_cr
Integer li_verif_rc
Integer li_retval
integer li_exist //maha 032901
integer li_vfac //maha 032901
integer res //maha 032901
integer li_status = 1 //maha 080108 initialized to active
string ls_refdata2 //maha 061801
DataWindowChild dwchild

SetNull( ldt_null_date )

dw_detail.AcceptText()
li_data_cr = dw_detail.GetRow()

//------------------- APPEON BEGIN -------------------
//$<delete> Michael 05.14.2012
//$<reason> removed below:Invalid DataWindow row/column specified
/*
//Start Code Change ----12.24.2010 #V11 maha 
if dw_detail.Describe("active_status.ColType") <> "!" then
	li_status = dw_detail.getitemnumber(li_data_cr,"active_status")
	if li_status < 1 then
		messagebox("Create Verification","Verifications can only be created for Active or Historical Records.")	
		return -1
	end if
end if
//End Code Change ----12.24.2010
*/
//------------------- APPEON END ---------------------

//get reference cols
ls_ref_1 = dw_select_section.GetItemString( il_last_row, "ref_field_1")
ls_ref_2 = dw_select_section.GetItemString( il_last_row, "ref_field_2")
ls_ref_3 = dw_select_section.GetItemString( il_last_row, "ref_field_3")
//get exp date
ls_exp_field = dw_select_section.GetItemString( il_last_row, "exp_field")
//get screen id & name
li_screen_id = dw_select_section.GetItemNumber( il_last_row, "screen_id")
ls_screen_name = dw_select_section.GetItemString( il_last_row, "screen_name")

li_rec_count = dw_detail.RowCount()

IF li_rec_count < 1 THEN
	RETURN -1
END IF


//Start Code Change ----12.24.2010 #V11 maha 
if dw_detail.Describe("active_status.ColType") <> "!" then
	li_status = dw_detail.getitemnumber(li_data_cr,"active_status")
	if li_status < 1 then
		messagebox("Create Verification","Verifications can only be created for Active or Historical Records.")	
		return -1
	end if
end if
//End Code Change ----12.24.2010

SetNull( ll_address_code )


IF IsNull( dw_detail.GetItemNumber(li_data_cr, "rec_id")) OR +&
	dw_detail.GetItemNumber(li_data_cr, "rec_id") = 0 THEN
	return 1 //maha 052104 removed of_get_id code as could cause potential unmatched verifications
//	ls_rec_status = "New"
//	il_rec_id = gnv_app.of_Get_Id("RECORD_ID")
//	dw_detail.SetItem( li_data_cr, "rec_id", il_rec_id )
//	dw_detail.SetItem( li_data_cr, "prac_id", il_prac_id)
END IF
	
ll_rec_id = dw_detail.GetItemNumber( li_data_cr, "rec_id" )
//test if verif exists for this facility

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-05
//$<add> 01.17.2006 By: LeiWei
//$<reason> Performance tuning
//$<reason> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

//gnv_appeondb.of_startqueue( )  //Start Code Change ---- 04.04.2007 #V7 maha removed as was effecting the messagebox
//---------------------------- APPEON END ----------------------------

select verifying_facility
into :li_vfac
from pd_affil_stat
where prac_id = :il_prac_id and active_status in (1,4) and parent_facility_id = :gi_parent_facility;

select count(rec_id)
into :li_exist
from verif_info
where rec_id = :ll_rec_id and prac_id = :il_prac_id  and facility_id = :li_vfac and active_status = 1;

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-06
//$<add> 01.17.2006 By: LeiWei
//$<reason> Performance tuning
//$<reason> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance. 
//gnv_appeondb.of_commitqueue( )  //Start Code Change ---- 04.04.2007 #V7 maha removed as was effecting the messagebox
//---------------------------- APPEON END ----------------------------

if li_exist > 0 then
	res = messagebox("Are you sure?","An active verification item already exists for this data entry record. Do you wish to create another?",question!,yesno!,2)
	if res = 2 then return -1
end if
//board test
IF li_screen_id = 19 THEN
	IF IsNull( dw_detail.GetItemNumber( li_data_cr, "board_code" ) ) THEN
		MessageBox("Error", "No board entered." )
		Return -1
	END IF
END IF

//Start Code Change ----08.31.2011 #V11 maha 
IF ls_screen_name = "Other Verifications" THEN  //other verifications
	if dw_detail.Describe("verif_method.ColType") = "!" then 
		//leave as default -1
	else
		ll_method = dw_detail.GetItemNumber( li_data_cr, "verif_method" )
		if isnull( ll_method) then ll_method = -1
	end if
end if
//End Code Change ----08.31.2011

IF NOT IsNull( ls_ref_1 ) AND ls_ref_1 <> "" THEN

	//move expiration date to verif info table if there is one
	IF Len(ls_exp_field) > 0 THEN
		IF ls_exp_field = "certification_expires" THEN				
			ldt_exp_date = DateTime(Date( "1-1-" + String( dw_detail.GetItemNumber( li_data_cr, ls_exp_field ) ) ),Now())
		ELSE
			//------------------- APPEON BEGIN -------------------
			//$<add> Evan 09.15.2009
			//$<reason> Invalid DataWindow column.
			if IsNull(ls_exp_field) then ls_exp_field = ""
			if dw_detail.Describe(ls_exp_field + ".ColType") = "!" then
				MessageBox("Expiration Date", "The '" + ls_exp_field + "' column does not exists.")
				Return -1
			end if
			//------------------- APPEON END ---------------------
			ldt_exp_date = dw_detail.GetItemDateTime( li_data_cr, ls_exp_field )
		END IF
	ELSE
		ldt_exp_date = ldt_null_date
	END IF
	//\/maha 072005 ******************************
	//get reference 1 data
	
	//Start Code Change ----04.16.2008 #V8 maha - added trap for setcolumn failure.
	res = dw_detail.SetColumn( ls_ref_1 )
	if res = -1 then 
		SetRedraw( True )
		messagebox("of_add_ver_entry function","Unable to set column " + ls_ref_1+ ".  Check that the field is visible on the view. "  )
		Return -1
	end if
	//End Code Change---04.16.2008
	
	IF IsNull( dw_detail.GetText() ) OR dw_detail.GetText() = "" THEN
		SetRedraw( True )
		Return -1
	END IF
	li_retval = dw_detail.GetChild(ls_ref_1, dwchild)
	IF li_retval = -1 THEN
		ls_reference =  dw_detail.GetText()				
	ELSE
		//dw_detail.SetColumn( ls_ref_1 )  //Start Code Change ----04.16.2008 #V8 maha - removed,  redundant from above
		
		li_found = dwchild.Find( "lookup_code = " + dw_detail.GetText(), 1, 100000 )  //Start Code Change ----03.25.2009 #V92 maha - changed to 100,000 from 10,000
//Start Code Change ---- 10.29.2007 #V7 maha	correction for boards
		IF ii_screen_id = 4 THEN					
			if dw_detail.Describe("verifying_agency.ColType") = "!" then //trap for invisible field maha 040403 
				of_error_message("VERIFYING_AGENCY",li_data_cr,"Screen Setup Error"," The verifying_agency field is a required field, and must be visible to enter Licence data.  Please set up in the screen painter.")
				//messagebox("Screen Setup Error"," The verifying_agency field is a required field, and must be visible to enter Licence data.  Please set up in the screen painter")
				return -1
			else
				ll_address_code = dw_detail.GetItemNumber( li_data_cr, "verifying_agency" )
			end if
		ELSEIF li_screen_id = 19 THEN  //Start Code Change ---- 10.26.2007 #V7 maha
			IF IsNull( dw_detail.GetItemNumber( li_data_cr, "board_code" ) ) THEN
				messagebox("Verification Creation","There is no Board Name selected.  Without the Board Name the verification can not be created")
				return -1
		  
			ELSE
				ll_address_code = dw_detail.GetItemNumber( li_data_cr, "board_code" ) 
			end if
		ELSE
			//Start Code Change ----10.12.2009 #V10 maha
			choose case upper(mid(dw_detail.Describe( ls_ref_1 + ".coltype"),1,1)) //maha 072005  will overwrite the address_id _code if the correct reference field is 2
				case "D", "I", "N"
					ll_address_code = dw_detail.GetItemNumber( li_data_cr, ls_ref_1 )
				case "C", "V"
					ll_address_code = long(dw_detail.GetItemstring( li_data_cr, ls_ref_1 ))
			end choose	
		//End Code Change---10.12.2009	
//End Code Change---10.29.2007	
		END IF
		IF dw_detail.Describe( ls_ref_1 + ".dddw.displaycolumn") = "code" and li_found > 0 THEN
			ls_reference = dwchild.GetItemString( li_found, "code" )
		ELSEIF dw_detail.Describe( ls_ref_1 + ".dddw.displaycolumn") = "description" and li_found > 0 THEN
			ls_reference = dwchild.GetItemString( li_found, "description" )
		ELSEIF dw_detail.Describe( ls_ref_1 + ".dddw.displaycolumn") = "entity_name_original" and li_found > 0 THEN
			ls_reference = dwchild.GetItemString( li_found, "entity_name_original" )
		ELSEIF dw_detail.Describe( ls_ref_1 + ".dddw.displaycolumn") = "entity_name" and li_found > 0 THEN //Start Code Change ---- 04.04.2007 #V7 maha
			ls_reference = dwchild.GetItemString( li_found, "entity_name_original" )
		ELSE
			ls_reference = dw_detail.GetText()				
		END IF
	END IF
	
	//get reference 2 data
	IF NOT IsNull( ls_ref_2 ) AND ls_ref_2 <> "" THEN //Add "IF...END IF" by alfee 09.07.2011
		dw_detail.SetColumn( ls_ref_2 )
		IF IsNull( dw_detail.GetText() ) OR dw_detail.GetText() = "" THEN
				ls_reference = ls_reference + " - "
		else
			ls_refdata2 = dw_detail.GetText()
	
			li_retval = dw_detail.GetChild(ls_ref_2, dwchild)
			IF li_retval = -1 THEN
				ls_reference = ls_reference + " - " + ls_refdata2//dw_detail.GetText()				
			ELSE
				dw_detail.SetColumn( ls_ref_2 )
				li_found = dwchild.Find( "lookup_code = " + dw_detail.GetText(), 1, 100000 )  //Start Code Change ----03.25.2009 #V92 maha - changed to 100,000 from 10,000
	
				IF dw_detail.Describe( ls_ref_2 + ".dddw.displaycolumn") = "code" and li_found > 0 THEN
					ls_reference = ls_reference + " - " + dwchild.GetItemString( li_found, "code" )
				ELSEIF dw_detail.Describe( ls_ref_2 + ".dddw.displaycolumn") = "description" and li_found > 0 THEN
					ls_reference = ls_reference + " - " + dwchild.GetItemString( li_found, "description" )
				ELSEIF (dw_detail.Describe( ls_ref_2 + ".dddw.displaycolumn") = "entity_name" or dw_detail.Describe( ls_ref_2 + ".dddw.displaycolumn") = "entity_name_original") and li_found > 0 THEN //Start Code Change ---- 04.04.2007 #V7 maha
					if dw_detail.Describe( ls_ref_2 + ".dddw.displaycolumn") = "entity_name_original" then
						ls_reference = ls_reference + " - " + dwchild.GetItemString( li_found, "entity_name_original" )
					else
						ls_reference = ls_reference + " - " + dwchild.GetItemString( li_found, "entity_name_original" )
					end if
					//Start Code Change ----10.12.2009 #V10 maha - code reflected reference 1; changed to reference 2
					choose case upper(mid(dw_detail.Describe( ls_ref_2 + ".coltype"),1,1)) //maha 072005  will overwrite the address_id _code if the correct reference field is 2
						case "D", "I", "N"
							ll_address_code = dw_detail.GetItemNumber( li_data_cr, ls_ref_2 )
						case "C", "V"
							ll_address_code = long(dw_detail.GetItemstring( li_data_cr, ls_ref_2 ))
					end choose	
					//End Code Change---10.12.2009			
				ELSE
					ls_reference = ls_reference + " - " + ls_refdata2//dw_detail.GetText()
				END IF 
			END IF
			ls_reference = mid(ls_reference,1,100) //maha 022704
		end if
	END IF
	
	//\maha 072005 ******************************
	//Start Code Change ----08.01.2008 #V85 maha - get active status to pass to function //Start Code Change ----01.24.2011 #V11 maha - moved to top of function
//	if dw_detail.Describe("active_status.ColType") <> "!" then
//		li_status = dw_detail.getitemnumber(li_data_cr,"active_status")
//	end if
	//End Code Change---08.01.2008
	IF parent_window.Tab_1.tabpage_verif.uo_verif_summary.of_add_single_verif( il_prac_id, ll_rec_id, li_screen_id, ls_reference,  ldt_exp_date, ls_screen_name, ll_address_code,"M",li_status, ll_method) = -1 THEN
		Return -1
	END IF
else
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> UM-01
	//$<add> 01.13.2006 By: LeiWei
	//$<reason> Appeon deals with NULL value differently from that in PowerBuilder.
	//$<modification> Convert variable 'ls_ref_1' to ' ' when it is null
	If Isnull(ls_ref_1) Then ls_ref_1 = ' '
	//---------------------------- APPEON END ----------------------------
	messagebox("Data Error", "There is no data for the required field" + ls_ref_1)
	return -1
END IF

dw_detail.SetFocus()

RETURN 1


end function

public function integer of_add_address_link (long al_address_id);n_ds lds_address_link

Integer li_row_cnt
Integer i
Integer li_nr

//dw_link_list = CREATE n_ds
//dw_link_list.DataObject = "d_address_link"
dw_link_list.SetTransObject( SQLCA )

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-07
//$<comment> 2006-04-11 By: owen chen
//$<reason> Performance tuning modification
//$<reason> Reduce the frequency of client-server interactions to improve runtime performance 
/*
n_ds lds_parent_facilities
lds_parent_facilities = CREATE n_ds
lds_parent_facilities.DataObject = "d_address_link_parent_facility_id"
lds_parent_facilities.of_SetTransObject( SQLCA )
li_row_cnt = lds_parent_facilities.Retrieve( il_prac_id )
*/

li_row_cnt = ids_parent_facilities.rowcount( )

//---------------------------- APPEON END ----------------------------

FOR i = 1 TO li_row_cnt
	li_nr = dw_link_list.InsertRow( 0 )
	dw_link_list.SetItem( li_nr, "prac_id", il_prac_id )
	dw_link_list.SetItem( li_nr, "address_id", al_address_id )
	dw_link_list.SetItem( li_nr, "facility_id", ids_parent_facilities.GetItemNumber( i, "parent_facility_id" ) )
	dw_link_list.SetItem( li_nr, "mailing", 0 )
	dw_link_list.SetItem( li_nr, "billing", 0 )
	dw_link_list.SetItem( li_nr, "home_address", 0 )
	dw_link_list.SetItem( li_nr, "primary_office", 0 )
	dw_link_list.SetItem( li_nr, "additional_office", 0 )
	dw_link_list.SetItem( li_nr, "include_in_directory", 0 )
	dw_link_list.SetItem( li_nr, "exp_letters", 0 )
END FOR


//dw_detail.Update() //maha removed 020805

//OpenWithParm( w_address_link, String( il_prac_id ) + "-" + String( al_address_id) )

//DESTROY dw_link_list
//DESTROY lds_parent_facilities

//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 2007.07.10 By: Scofield
//$<Reason> Update dw_link_list
dw_link_list.Update()
//---------------------------- APPEON END ----------------------------

Return 1
end function

public function integer of_add_delete_enable ();Long ll_screen_id
integer i


IF dw_select_section.GetRow() = 0 THEN
	Return -1
END IF

ll_screen_id = dw_select_section.GetItemNumber(dw_select_section.GetRow(), "screen_id" )

IF IsValid( m_pfe_cst_data_entry ) THEN
	If (w_mdi.of_security_access( 40 ) < 2) or (w_mdi.of_security_access( 50 ) < 2) then //maha 082503//Modified by Nova.zhang on 12.18.2008
//		m_pfe_cst_data_entry.m_edit.m_addverificationentry.enabled = false 
//		m_pfe_cst_data_entry.m_edit.m_delete1.enabled = False
//		m_pfe_cst_data_entry.m_edit.m_insert.enabled = False
//		m_pfe_cst_data_entry.m_file.m_save.enabled = False
		gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_edit.m_addverificationentry,'enabled', false) 
		gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_edit.m_delete1,'enabled', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_edit.m_insert,'enabled', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_file.m_save,'enabled', False)
		parent_window.cb_add.enabled = False  //Start Code Change ----03.06.2012 #V12 maha - added button disables
		parent_window.cb_delete.enabled = False
		parent_window.cb_save.enabled = False
		parent_window.cb_b7.enabled = False
		
	else
		//m_pfe_cst_data_entry.m_edit.m_addverificationentry.enabled = true
		gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_edit.m_addverificationentry,'enabled', true)
		IF ll_screen_id = 1 or ll_screen_id = 27 THEN  //Start Code Change ----01.08.2010 #V10 maha - added personal screen trap
//			m_pfe_cst_data_entry.m_edit.m_delete1.enabled = False
//			m_pfe_cst_data_entry.m_edit.m_insert.enabled = False
			gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_edit.m_delete1,'enabled', False)
			gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_edit.m_insert,'enabled', False)
			parent_window.cb_add.enabled = False
			parent_window.cb_delete.enabled = False
			parent_window.cb_prior.enabled = False   //Start Code Change ----04.27.2012 #V12 maha
		parent_window.cb_next.enabled = False   //Start Code Change ----04.27.2012 #V12 maha
		ELSE	
//			m_pfe_cst_data_entry.m_edit.m_delete1.enabled = True
//			m_pfe_cst_data_entry.m_edit.m_insert.enabled = True
			gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_edit.m_delete1,'enabled', True)
			gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_edit.m_insert,'enabled', True)
			parent_window.cb_add.enabled = True
			parent_window.cb_delete.enabled = True
		END IF
	end if
	//--------------------------- APPEON BEGIN ---------------------------
	//$< Add  > 2008-09-23 By: Scofield
	//$<Reason> Enabled or disabled the import photo button.

	if ii_screen_id = 1 then
//		m_pfe_cst_data_entry.m_file.m_importphoto.Enabled = true
//		m_pfe_cst_data_entry.m_file.m_clearphoto.Enabled = true
		gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_file.m_importphoto,'Enabled', true)
		gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_file.m_clearphoto,'Enabled', true)
	else
//		m_pfe_cst_data_entry.m_file.m_importphoto.Enabled = false
//		m_pfe_cst_data_entry.m_file.m_clearphoto.Enabled = false
		gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_file.m_importphoto,'Enabled', false)
		gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_file.m_clearphoto,'Enabled', false)
	end if
	//---------------------------- APPEON END ----------------------------
END IF

Return 0

end function

public function integer of_set_de_complete_date_null ();//maha 111300
update pd_affli_stat
set date_data_entry_completed = null
where (prac_id = :gl_prac_id) and 
      (parent_facility_id = :ii_parent_facility_id) and
		(active_status = 1) ;
		
return 1
		
end function

public function integer of_add_hosp_link (readonly long ai_hosp_id);n_ds lds_hosp_link
n_ds lds_parent_facilities
Integer li_row_cnt
Integer i
Integer li_nr

lds_hosp_link = CREATE n_ds
lds_hosp_link.DataObject = "d_hf_link"
lds_hosp_link.of_SetTransObject( SQLCA )
//dw_link_list.SetTransObject( SQLCA )

lds_parent_facilities = CREATE n_ds
lds_parent_facilities.DataObject = "d_address_link_parent_facility_id"
lds_parent_facilities.of_SetTransObject( SQLCA )
li_row_cnt = lds_parent_facilities.Retrieve( il_prac_id )
//messagebox("facilities",li_row_cnt)
FOR i = 1 TO li_row_cnt
	li_nr = lds_hosp_link.InsertRow( 0 )	
	lds_hosp_link.SetItem( li_nr, "prac_id", il_prac_id )
	lds_hosp_link.SetItem( li_nr, "hosp_affil_id", ai_hosp_id )
	lds_hosp_link.SetItem( li_nr, "primary_hosp", 582)	
	lds_hosp_link.SetItem( li_nr, "facility_id", lds_parent_facilities.GetItemNumber( i, "parent_facility_id" ) )
END FOR

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-08
//$<add> 01.17.2006 By: LeiWei
//$<reason> Performance tuning
//$<reason> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

/*
lds_hosp_link.Update()
dw_link_list.retrieve(ai_hosp_id)
*/

IF li_row_cnt > 0 THEN
	gnv_appeondb.of_startqueue( )
	
	lds_hosp_link.Update()
	dw_link_list.retrieve(ai_hosp_id)
	
	gnv_appeondb.of_commitqueue( )
END IF

//---------------------------- APPEON END ----------------------------

//dw_detail.Update() //maha removed 020905
//openwithparm(w_hosp_links,ai_hosp_id)

dw_link_list.bringtotop = true

DESTROY lds_hosp_link
DESTROY lds_parent_facilities


Return 1

end function

public function integer of_add_spec_link (long ai_rec_id);n_ds lds_spec_link
n_ds lds_parent_facilities
Integer li_row_cnt
Integer i
Integer li_nr

lds_spec_link = CREATE n_ds
lds_spec_link.DataObject = "d_sf_link"
lds_spec_link.of_SetTransObject( SQLCA )
//dw_link_list.SetTransObject( SQLCA ) //changed 121702 maha

lds_parent_facilities = CREATE n_ds
lds_parent_facilities.DataObject = "d_address_link_parent_facility_id"
lds_parent_facilities.of_SetTransObject( SQLCA )
li_row_cnt = lds_parent_facilities.Retrieve( il_prac_id )
//messagebox("facilities",li_row_cnt)
//messagebox("spec id",ai_rec_id)
FOR i = 1 TO li_row_cnt
	li_nr = lds_spec_link.InsertRow( 0 )	
	lds_spec_link.SetItem( li_nr, "prac_id", il_prac_id )
	lds_spec_link.SetItem( li_nr, "specialty_id", ai_rec_id )
	lds_spec_link.SetItem( li_nr, "practicing", 581)	 //Start Code Change ----02.04.2010 #V10 maha changed to yes from no
	lds_spec_link.SetItem( li_nr, "facility_id", lds_parent_facilities.GetItemNumber( i, "parent_facility_id" ) )
END FOR
//messagebox("speccs",lds_spec_link.rowcount())

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-09
//$<modify> 03.01.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Commit label to reduce client-server interactions to improve runtime performance.
/*
lds_spec_link.Update()
commit using sqlca;
*/
IF li_row_cnt > 0 THEN
	gnv_appeondb.of_autocommit( )
	lds_spec_link.Update()
	commit using sqlca;
END IF
//---------------------------- APPEON END ----------------------------

//dw_detail.Update()//maha removed 020905
//openwithparm(w_spec_links,ai_rec_id)

dw_link_list.bringtotop = true

DESTROY lds_spec_link
DESTROY lds_parent_facilities

dw_link_list.retrieve(ai_rec_id)

Return 1
end function

public function integer of_address_link_check ();Integer li_facility_id
Integer li_row_cnt
Integer li_primary
Integer li_additional
Integer i
Integer li_mailing
Integer li_billing
Integer li_exp_mail
integer li_validate
Long ll_prac_id
Long ll_address_id
String ls_facility_nm
n_ds lds_dup_mail_search
n_ds lds_dup_exp_mail_search
n_ds lds_dup_primary_search

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-10
//$<modify> 03.02.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Move the following SQL statements to PT-11, and integrate
//$<modification> them with other SQL statements into Appeon Queue labels to
//$<modification> reduce client-server interactions.
/*
lds_dup_mail_search = CREATE n_ds
lds_dup_mail_search.DataObject = "d_address_link_duplicate_mail_check"
lds_dup_mail_search.of_SetTransObject( SQLCA )

lds_dup_exp_mail_search = CREATE n_ds
lds_dup_exp_mail_search.DataObject = "d_address_link_duplicate_exp_mail_check"
lds_dup_exp_mail_search.of_SetTransObject( SQLCA )

lds_dup_primary_search = CREATE n_ds
lds_dup_primary_search.DataObject = "d_address_link_duplicate_primary_check"
lds_dup_primary_search.of_SetTransObject( SQLCA )
*/
//---------------------------- APPEON END ----------------------------

//Start Code Change ----07.25.2013 #V14 maha - validation bypass - HP request
li_validate = of_get_app_setting("set_54","I")    //0=on; 10= skip mailing; 20= off
if li_validate = 20 then return 1
//End code change ----07.25.2013

dw_link_list.AcceptText()

li_row_cnt = dw_link_list.RowCount()

IF li_row_cnt = 0 THEN
	Return 1
END IF

ll_prac_id = dw_link_list.GetItemNumber( 1, "prac_id" )

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-11
//$<add> 03.02.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> 1)Add the SQLs from PT-10.
//$<modification> 2)Add Appeon Queue labels to reduce client-server interaction.
//$<modification> 3)Use datastores to retrieve data from database instead of using
//$<modification> SQL in PT-12/13/14.
Long li_facility_id_arr[]

FOR i = 1 TO li_row_cnt
	li_facility_id = dw_link_list.GetItemNumber( i, "facility_id" )
	li_primary = dw_link_list.GetItemNumber( i, "primary_office" )
	li_additional = dw_link_list.GetItemNumber( i, "additional_office" )

	li_facility_id_arr[i] = li_facility_id
	
	IF li_primary = 1 AND li_additional = 1 THEN
		MessageBox("Invalid Selection", "An address can be setup as either a Primary office or Additional office, not both. Please correct.")
		dw_link_list.SetItem( i, "primary_office", 0  )
		dw_link_list.SetItem( i, "additional_office", 0  )
		dw_link_list.SetFocus()		
		Return -1
	END IF
END FOR

lds_dup_mail_search = CREATE n_ds
lds_dup_mail_search.DataObject = "d_address_link_duplicate_mail_check_pt"
lds_dup_mail_search.of_SetTransObject( SQLCA )

lds_dup_exp_mail_search = CREATE n_ds
lds_dup_exp_mail_search.DataObject = "d_address_link_duplicate_exp_mail_che_pt"
lds_dup_exp_mail_search.of_SetTransObject( SQLCA )

lds_dup_primary_search = CREATE n_ds
lds_dup_primary_search.DataObject = "d_address_link_duplicate_primary_che_pt"
lds_dup_primary_search.of_SetTransObject( SQLCA )

gnv_appeondb.of_startqueue( )

lds_dup_primary_search.Retrieve( li_facility_id_arr[], ll_prac_id  )
lds_dup_exp_mail_search.Retrieve( li_facility_id_arr[], ll_prac_id )
lds_dup_mail_search.Retrieve( li_facility_id_arr[], ll_prac_id ) 

gnv_appeondb.of_commitqueue( )

//---------------------------- APPEON END ----------------------------

FOR i = 1 TO li_row_cnt
	//setup variables for retrieving data
	li_facility_id = dw_link_list.GetItemNumber( i, "facility_id" )
	ls_facility_nm = dw_link_list.GetItemString( i, "facility_facility_name" )
	ll_address_id = dw_link_list.GetItemNumber( i, "address_id" )
	li_mailing = dw_link_list.GetItemNumber( i, "mailing" )
	li_exp_mail	= dw_link_list.GetItemNumber( i, "exp_letters" )
	li_billing = dw_link_list.GetItemNumber( i, "billing" )
	li_primary = dw_link_list.GetItemNumber( i, "primary_office" )
	li_additional = dw_link_list.GetItemNumber( i, "additional_office" )

	IF li_primary = 1 AND li_additional = 1 THEN
		MessageBox("Invalid Selection", "An address can be setup as either a Primary office or Additional office, not both. Please correct.")
		dw_link_list.SetItem( i, "primary_office", 0  )
		dw_link_list.SetItem( i, "additional_office", 0  )
		DESTROY lds_dup_exp_mail_search
		DESTROY lds_dup_mail_search
		DESTROY lds_dup_primary_search				
		dw_link_list.SetFocus()		
		Return -1
	END IF
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-12
	//$<modify> 03.02.2006 By: LeiWei
	//$<reason> Performance tuning
	//$<modification> Write script to retrieve data from a cache in PT-11 instead of from the database.
	/*
	//check if there is any other prmary addresses setup
	lds_dup_primary_search.Retrieve( li_facility_id, ll_address_id, ll_prac_id  )
	*/
	lds_dup_primary_search.SetFilter( "facility_id_pt = " + String(li_facility_id) + " and address_id_pt <> " + String(ll_address_id))
	lds_dup_primary_search.Filter( )
	//--------------------------- APPEON END -----------------------------

	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 03.14.2006 By: Liang QingShi
	//$<reason> Fix a defect.
	
	/*
	IF lds_dup_primary_search.GetItemNumber( 1, "dup_count" ) > 0 AND li_primary > 0 THEN
	*/
	integer li_rowcount
	li_rowcount = lds_dup_primary_search.rowcount()
	if li_rowcount > 0 then
		IF lds_dup_primary_search.GetItemNumber( 1, "dup_count" ) > 0 AND li_primary > 0 THEN
	//---------------------------- APPEON END ----------------------------
			MessageBox("Primary Address", "You already have a primary address setup for " + ls_facility_nm)
			dw_link_list.SetColumn( "primary_office" )
			dw_link_list.SetItem( i, "primary_office", 0  )
			dw_link_list.SetRow( i )
			dw_link_list.ScrollToRow( i )
			dw_link_list.SetFocus()		
			DESTROY lds_dup_exp_mail_search
			DESTROY lds_dup_mail_search
			DESTROY lds_dup_primary_search
			RETURN -1
		END IF
	END IF	
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-13
	//$<modify> 03.02.2006 By: LeiWei
	//$<modification> Write script to retrieve data from a cache in PT-11 instead of from the database.
	/*
	//check if there is any other exp_mail setup
	lds_dup_exp_mail_search.Retrieve( li_facility_id, ll_prac_id )
	*/
	lds_dup_exp_mail_search.SetFilter( "facility_id_pt = " + String(li_facility_id))
	lds_dup_exp_mail_search.Filter( )
	//--------------------------- APPEON END -----------------------------

	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 03.14.2006 By: Liang QingShi
	//$<reason> Fix a defect.
	/*
	IF lds_dup_exp_mail_search.GetItemNumber( 1, "dup_count" ) > 1 AND li_exp_mail > 0 THEN
	*/
	li_rowcount = lds_dup_exp_mail_search.rowcount()
	if li_rowcount > 0 then
		IF lds_dup_exp_mail_search.GetItemNumber( 1, "dup_count" ) > 1 AND li_exp_mail > 0 THEN
	//---------------------------- APPEON END ----------------------------
			MessageBox("Expiring Credentials Mail Address", "You already have an expiring credentials mailing address setup for this practitioner.")
			dw_link_list.SetColumn( "exp_letters" )
			dw_link_list.SetItem( i, "exp_letters", 0  )		
			dw_link_list.SetRow( i )
			dw_link_list.ScrollToRow( i )
			dw_link_list.SetFocus()		
			DESTROY lds_dup_exp_mail_search
			DESTROY lds_dup_mail_search
			DESTROY lds_dup_primary_search		
			RETURN -1
		END IF
	END IF

	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-14
	//$<modify> 03.02.2006 By: LeiWei
	//$<modification> Write script to retrieve data from a cache in PT-11 instead of from the database.
	/*
	//check if there is already a mailing address for dw_link_list facility
	lds_dup_mail_search.Retrieve( li_facility_id, ll_address_id, ll_prac_id ) 
	*/
	lds_dup_mail_search.SetFilter( "facility_id_pt = " + String(li_facility_id) + " and address_id_pt <> " + String(ll_address_id))
	lds_dup_mail_search.Filter( )
	//--------------------------- APPEON END -----------------------------

	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 03.14.2006 By: Liang QingShi
	//$<reason> Fix a defect.
	/*
	IF lds_dup_mail_search.GetItemNumber( 1, "dup_count" ) > 0 AND li_mailing > 0 THEN
	*/
	
//Start Code Change ----07.25.2013 #V14 maha - validation bypass
	If li_validate = 10 then
		//skip 
	Else
		//Mailing address
		li_rowcount = lds_dup_mail_search.rowcount()
		IF li_rowcount > 0 then
			IF lds_dup_mail_search.GetItemNumber( 1, "dup_count" ) > 0 AND li_mailing > 0 THEN
		//--------------------------- APPEON END -----------------------------
				MessageBox("Mailing Address", "You already have a mailing address setup for " + ls_facility_nm)
				dw_link_list.SetColumn( "mailing" )
				dw_link_list.SetItem( i, "mailing", 0  )		
				dw_link_list.SetRow( i )
				dw_link_list.ScrollToRow( i )
				dw_link_list.SetFocus()
				DESTROY lds_dup_exp_mail_search
				DESTROY lds_dup_mail_search
				RETURN -1
			END IF //dup
		END IF //rc
	End If //validate
//End Code Change ----07.25.2013


		//\/maha app100305	- don't leave null
	if isnull(dw_link_list.GetItemNumber( i, "mailing" )) then dw_link_list.setItem( i, "mailing",0 )
	if isnull(dw_link_list.GetItemNumber( i, "billing" )) then dw_link_list.setItem( i, "billing",0 )
	if isnull(dw_link_list.GetItemNumber( i, "primary_office" )) then dw_link_list.setItem( i, "primary_office",0 )
	if isnull(dw_link_list.GetItemNumber( i, "additional_office" )) then dw_link_list.setItem( i, "additional_office",0 )
	if isnull(dw_link_list.GetItemNumber( i, "exp_letters" )) then dw_link_list.setItem( i, "exp_letters",0 )

END FOR

DESTROY lds_dup_exp_mail_search
DESTROY lds_dup_mail_search
DESTROY lds_dup_primary_search
		
RETURN 1
end function

public function integer of_designer_type (string as_type);
is_designer_type = as_type

Return 1
end function

public function integer of_oig_query ();Integer li_cnt
integer res
Long ll_rec_id
Long ll_oig_query
String ls_val
String ls_oig_verify_data
String ls_appt_type
String ls_work_gap_check
String ls_npdb_query_type
DateTime ldt_exp_date
integer li_one_facil //maha 020901


if isnull(li_one_facil) then li_one_facil = 0

SetNull( ldt_exp_date )

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-15
//$<modify> 02.24.2006 By: LeiWei
//$<reason> Performance tuning
//$<reason> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

/*
// find out if prac is in initial or reappointment
SELECT pd_affil_stat.apptmnt_type  
INTO :ls_appt_type  
FROM pd_affil_stat  
WHERE ( pd_affil_stat.prac_id = :il_prac_id ) AND  
      ( pd_affil_stat.parent_facility_id = :ii_parent_facility_id ) and 
		(pd_affil_stat.active_status in (1,4)); //maha added 080901  //maha  changed to include pending 072402


	//check the rules in the facility painter for the parent facility to see if the
	//npdb and or hipdb queryies verification entries should be generated.
	SELECT facility.oig_verify_data
	INTO :ls_oig_verify_data
	FROM facility  
	WHERE facility.facility_id = :ii_parent_facility_id   ;
	//if o then do not query npdb or hipdb
	IF ls_oig_verify_data <> "O" THEN
		//also check at the prac level to see if the individual prac will need npdb query.
		SELECT pd_basic.oig_query  
		INTO :ll_oig_query
		FROM pd_basic  
		WHERE pd_basic.prac_id = :il_prac_id   ;
		IF SQLCA.SQLCODE = -1 THEN
			MessageBox( "Select Error", SQLCA.SQLERRTEXT )
			Return -1
		END IF

		IF ( ls_appt_type = "I" AND ( ls_oig_verify_data = "B" OR ls_oig_verify_data = "I" ) )  OR  +&
		   ( ls_appt_type = "R" AND ls_oig_verify_data = "B" OR ls_oig_verify_data = "R" )  THEN
	   
			SELECT code_lookup.code  
			INTO :ls_val
			FROM code_lookup  
			WHERE code_lookup.lookup_code = :ll_oig_query;
			IF SQLCA.SQLCODE = -1 THEN
				MessageBox( "Select Error", SQLCA.SQLERRTEXT )
				Return -1
			END IF
			//MessageBox("ls_val",ls_val)
			IF Upper( ls_val ) = 'YES' THEN
			
					SELECT Count(*)  
					INTO :li_cnt  
					FROM verif_info  
					WHERE ( verif_info.facility_id = :ii_parent_facility_id ) AND  
					      ( verif_info.prac_id = :il_prac_id ) AND  
					      ( verif_info.active_status = 1) AND  
					      ( verif_info.reference_value = 'OIG QUERY' );
							
					IF SQLCA.SQLCODE = -1 THEN
						MessageBox("SQL ERROR", SQLCA.SQLERRTEXT)
						RETURN -1
					END IF
					IF li_cnt = 0 THEN			
						ll_rec_id = gnv_app.of_get_id( "RECORD_ID" )	
						//if li_one_facil = 1 then// create for this facility only
							res = parent_window.tab_1.tabpage_verif.uo_verif_summary.of_add_oig( il_prac_id, ll_rec_id, ii_parent_facility_id) 
							//MessageBox("oig",res)
							if res = -1 THEN
								Return -1	
							end if				
					END IF
		
			END IF
		END IF
	END IF

*/
gnv_appeondb.of_startqueue( )

// find out if prac is in initial or reappointment
SELECT pd_affil_stat.apptmnt_type  
INTO :ls_appt_type  
FROM pd_affil_stat  
WHERE ( pd_affil_stat.prac_id = :il_prac_id ) AND  
      ( pd_affil_stat.parent_facility_id = :ii_parent_facility_id ) and 
		(pd_affil_stat.active_status in (1,4)); //maha added 080901  //maha  changed to include pending 072402


//check the rules in the facility painter for the parent facility to see if the
//npdb and or hipdb queryies verification entries should be generated.
SELECT facility.oig_verify_data
INTO :ls_oig_verify_data
FROM facility  
WHERE facility.facility_id = :ii_parent_facility_id   ;

SELECT pd_basic.oig_query  
INTO :ll_oig_query
FROM pd_basic  
WHERE pd_basic.prac_id = :il_prac_id   ;

SELECT Count(*)  
INTO :li_cnt  
FROM verif_info  
WHERE ( verif_info.facility_id = :ii_parent_facility_id ) AND  
		( verif_info.prac_id = :il_prac_id ) AND  
		( verif_info.active_status = 1) AND  
		( verif_info.reference_value = 'OIG QUERY' );

gnv_appeondb.of_commitqueue( )

	//if o then do not query npdb or hipdb
	IF ls_oig_verify_data <> "O" THEN
		//also check at the prac level to see if the individual prac will need npdb query.
		IF ( ls_appt_type = "I" AND ( ls_oig_verify_data = "B" OR ls_oig_verify_data = "I" ) )  OR  +&
		   ( ls_appt_type = "R" AND ls_oig_verify_data = "B" OR ls_oig_verify_data = "R" )  THEN
	   
			ls_val = gnv_data.of_getitem( "code_lookup", "code", "lookup_code = " + String(ll_oig_query) )
			//MessageBox("ls_val",ls_val)
			IF Upper( ls_val ) = 'YES' THEN
					IF li_cnt = 0 THEN			
						ll_rec_id = gnv_app.of_get_id( "RECORD_ID" )	
						//if li_one_facil = 1 then// create for this facility only
							//res = parent_window.tab_1.tabpage_verif.uo_verif_summary.of_add_oig( il_prac_id, ll_rec_id, ii_parent_facility_id) 
							res = of_add_oig( il_prac_id, ll_rec_id, ii_parent_facility_id) //
							//MessageBox("oig",res)
							if res = -1 THEN
								Return -1	
							end if				
					END IF
		
			END IF
		END IF
	END IF

//---------------------------- APPEON END ----------------------------

RETURN 1
end function

public function integer of_validate (integer ai_table, integer ai_row);//new function maha 080803  called from dw_detail pfc_preupdate
//function redesigned 072304 to allow validation on any credentialing data field - maha
long ll_data
string ls_data
integer i
integer ic
integer chk = 0
integer res
integer fc
integer f
integer v
integer c
integer ck
integer cc
long li_year1 //maha 04.14.2016
long li_year2 //maha 04.14.2016
boolean lb_run_syntax = false //maha 05.02.2013
long ll_recid
string ls_des
string ls_fname
string ls_tname
string ls_type
string ls_value
string ls_org_value   //maha 05.02.2013
string ls_sql
string ls_presentation_str
string ls_dwsyntax_str
string ERRORS
//Start Code Change ---- 10.02.2006 #635 maha  redesigned as well as corrected bug for more than 1 existing matching record
string ls_mess
string ls_npi //maha6.15.07
string ls_dea //maha 2.25.2014
string ls_date //maha 2.25.2014
string ls_label  //maha 03.14.3016
date ld_date //maha 2.25.2014
date ld_test1  //maha 04.14.2016
date ld_test2  //maha 04.14.2016

n_ds lds_fields
n_ds lds_count

lds_fields = CREATE n_ds
lds_count = CREATE n_ds

lds_fields.dataobject = "d_validation_fields"
lds_fields.settransobject(sqlca)
fc = lds_fields.retrieve(ai_table)
ll_recid = dw_detail.getitemnumber(ai_row,"rec_id")

if fc = 0 then return 1

for f = 1 to fc
	 lb_run_syntax = false
	ck = 0
	ls_fname = lds_fields.getitemstring(f,"field_name")
	ls_tname = lds_fields.getitemstring(f,"table_name")
	v = lds_fields.getitemnumber(f,"use_validation")
	ls_type = upper(lds_fields.getitemstring(f,"field_type"))
	ls_label =  lds_fields.getitemstring(f,"field_name_allias")
//	if ai_table = 25 then  //basic info/personal data field trap maha 120604  //Start Code Change ----05.25.2011 #V11 maha - redundant to describe below
//		ck = 0
//		cc = integer(dw_detail.Object.DataWindow.column.count)
//		for c = 1 to cc  //if the column exists in the datawindow continue, else drop out of function
//			ls_des = dw_detail.describe("#" + string(c) + ".name" )
//			if ls_des = ls_fname then
//				ck = 1
//				exit
//			end if
//		next
//		if ck = 0 then return 1		
//	end if

//	if dw_detail.Describe( ls_fname + ".ColType") = "!" then return 1 //Start Code Change ---- 08.17.2007 #V7 maha  trap for none existant field on screen
	if dw_detail.Describe( ls_fname + ".ColType") = "!" then continue //Start Code Change ----05.25.2011 #V11 maha - changed to continue
//Start Code Change ----04.14.2016 #V15 maha	- added additional validation types and changed 'Select *' to 'Select rec_id'
	choose case ls_type
		case "N", "I","L"
			ls_value = string(dw_detail.getitemnumber(ai_row,ls_fname))
		case "C"
			ls_value = "'" + dw_detail.getitemstring(ai_row,ls_fname) + "'"
		case "D", "T" //not really going to work for the timestamps

			ls_value = "'" + string(dw_detail.getitemdatetime(ai_row,ls_fname)) + "'"
			if dw_detail.getitemdatetime(ai_row,ls_fname) < datetime(date("1900-01-01"), time('00:00:00')) then
				messagebox("Date validation", "Field " + ls_fname + " has a date less than 1900.  Please check your data" )
				return 1
			end if
			
		case else 
			messagebox("of_validation function error","Data type " + ls_type + " not coded for.  Data not validated.")
			return 1
	end choose
	
	ls_org_value = ls_value  //Start Code Change ----05.02.2013 #V12 maha
	
//Start Code Change ----06.16.2008 #V81 maha
	if v <> 5 then
		if isnull(ls_value) then continue
	end if
//End Code Change---.2008

	choose case v
		case 1 //unique warning
			ls_sql = "select rec_id from " + ls_tname + " where " + ls_fname + " = " + ls_value + ";"
			ls_mess = "Field " + upper(ls_fname) + " is not unique in the database on row " + string(ai_row) + ".  Do you wish to add/update the record with the duplicated value?"
			 lb_run_syntax = true //Start Code Change ----05.02.2013 #V12 maha
		case 2 //unique
			ls_sql = "select rec_id from " + ls_tname + " where " + ls_fname + " = " + ls_value + ";"
			ls_mess = "Field " + upper(ls_fname) + " is not unique in the database on row " + string(ai_row) + ".  You must correct to save the record."
			 lb_run_syntax = true  //Start Code Change ----05.02.2013 #V12 maha
		case 3 //dupe warning
			ls_sql = "select rec_id from " + ls_tname + " where " + ls_fname + " = " + ls_value + " and prac_id = " + string(il_prac_id) + ";"
			ls_mess = "Field " + upper(ls_fname) + " is duplicated on row " + string(ai_row) + ".  Do you wish to add/update the record with the duplicated value?"
		 lb_run_syntax = true  //Start Code Change ----05.02.2013 #V12 maha
		case 4 // no dupes 
			ls_sql = "select rec_id from " + ls_tname + " where " + ls_fname + " = " + ls_value + " and prac_id = " + string(il_prac_id) + ";"
			ls_mess = "Field " + upper(ls_fname) + " is duplicated on row " + string(ai_row) + ".  You must correct to save the record."
			 lb_run_syntax = true //Start Code Change ----05.02.2013 #V12 maha				
		case 5  // special 
			
			choose case ls_fname
				case "special coded field"
					//specify the field name as the case and create code specific for that case. Test for table_id in the code.
				case "npi_number"  //Start Code Change ---- 06.15.2007 #V7 maha --will check for valid NPI format as well as unique value in the system.
					ls_npi = dw_detail.getitemstring(ai_row,ls_fname)
					// if len(ls_npi) = 0 then return 1 //Commented by Ken.Guo 2008-07-22
					If ls_npi = '' or isnull(ls_npi) Then Continue //Added by Ken.Guo 2008-07-22  //Start Code Change ----02.25.2014 #V14 maha - changed from return
					res = of_npi_validation(ls_npi ,"DE")  //Start Code Change ----04.23.2008 #V8 maha - this is an application function 
					if res < 0 then
						choose case res
							case -1
								ls_mess = "Invalid.  NPI number must be 10 Characters."
							case -2
								ls_mess = "Invalid.  NPI number can contain Numbers only."
							case -3
								ls_mess = "Invalid.  Not a valid NPI number"
						end choose
						messagebox("NPI Validation",ls_mess)
						return -1
						continue
					else //now set to check to see if it is unique
						ls_sql = "select rec_id from " + ls_tname + " where npi_number = " + ls_value + ";"
						ls_mess = "Field NPI number is not unique in the database on row " + string(ai_row) + ".  You must correct to save the record."
						 lb_run_syntax = true  //Start Code Change ----05.02.2013 #V12 maha
						v = 2 //reset so the message will run
					end if
				case "ssn"  //Start Code Change ----05.02.2013 #V123 maha --will check for valid SSN format as well as unique value in the system.
					ls_npi = dw_detail.getitemstring(ai_row,ls_fname)
					// if len(ls_npi) = 0 then return 1 //Commented by Ken.Guo 2008-07-22
					If ls_npi = '' or isnull(ls_npi) Then Continue //Added by Ken.Guo 2008-07-22   //Start Code Change ----02.25.2014 #V14 maha - changed from return
					res = of_npi_validation(ls_npi ,"SSN")  //Start Code Change ----04.23.2008 #V8 maha - this is an application function 
					if res < 0 then
						choose case res
							case -1
								ls_mess = "Invalid.  SSN number must be 9 Characters."
							case -2
								ls_mess = "Invalid.  SSN can contain Numbers only."
						end choose
						messagebox("SSN Validation",ls_mess)
						return -1
						continue
					else //now set to check to see if it is unique
						ls_sql = "select rec_id from " + ls_tname + " where ssn = " + ls_value + ";"
						ls_mess = "Field SSN is not unique in the database for  " + string(ai_row) + " " + ls_npi + " .  You must correct to save the record."
						v = 2 //reset so the message will run
					end if
				case "provider_id"  //Start Code Change ----10.26.2011 #V12 maha - added for mass gen - has not been tested as of this date
					if ai_table <> 25 then continue
					if not isnull(dw_detail.getitemstring(ai_row,ls_fname)) then continue
					select max(provider_id)  into :ls_data from pd_basic;
					If isnumber(ls_data) then 
						ll_data = long(ls_data)
						ll_data++
						dw_detail.setitem(ai_row,ls_fname,ll_data)
					end if
				
				case "end_date"
					res = inv_data_entry.of_record_validation( dw_detail)
					if res = -1 then return -1
				case "year_thru"
					res = inv_data_entry.of_record_validation( dw_detail)
					if res = -1 then return -1
				case else
					return 1
			end choose
		case 6 //unique and numeric //Start Code Change ----08.11.2009 #V92 maha - for inova
			ls_sql = "select rec_id from " + ls_tname + " where " + ls_fname + " = " + ls_value + ";"
			ls_mess = "Field " + upper(ls_fname) + " is not unique in the database on record " + string(ai_row) + ".  Data must also be numeric. You must correct to save the record."
			ls_value = of_strip_char(	"'", ls_value,"") //strip the quotes so isnumber test will work
			 lb_run_syntax = true  //Start Code Change ----05.02.2013 #V12 maha
		case 7 //email validation//Start Code Change ----08.15.2012 #V12 maha
			ls_value = of_email_validation(ls_value)
			if ls_value = "-1" then
				return -1
			else
				dw_detail.setitem(ai_row,ls_fname,ls_value)
				return 1
			end if
		case 8 //TIN number and length 9   //Start Code Change ----05.02.2013 #V12 maha
			ls_value = trim(ls_value)
			ls_value = of_strip_char(	"-", ls_value,"") 
			ls_value = of_strip_char(	"'", ls_value,"") 

			if len(ls_value) <> 9 then
				messagebox("TIN Validation",ls_org_value  + " is Not a valid TIN (record " + string (f) + " ).  Must be 9 characters and all numbers")
				return -1
			end if
			if not isnumber(ls_value) then
				messagebox("TIN Validation", ls_org_value  + " is Not a valid TIN (record " + string (f) + " ).  Must be 9 characters and all numbers")
				return -1
			end if
		case 9 //date valid  //Start Code Change ----02.25.2014 #V14.2 maha - added 
			ls_date = of_strip_char(	"'", ls_value,"")  //remove the quotes added above
			ld_date = date(ls_date)
//			if ld_date = "1900-01-01" then
			li_year1 = year(today())
			li_year2 = year(ld_date)
			if li_year2 > li_year1 + 50 or li_year2 < li_year1 - 100 then //Start Code Change ----04.14.2016 #V15 maha - corrected
			//if ld_date > RelativeDate(ld_date, 50) or ld_date < RelativeDate(ld_date, -100) then
				messagebox("Date Validation", "Invalid date for " + ls_fname + " for record " + string (f) + ".  Must be with in the last 100 years or the next 50 years.")
				return -1
			end if
		case 10, 18 //DEA //total of 9: first 2 char the rest number   //Start Code Change ----02.25.2014 #V14.2 maha - added //Start Code Change ----04.14.2016 #V15 maha - added 18
			if dw_detail.getitemnumber(ai_row, "state") <> 90 then continue
		//	debugbreak()
			ls_dea = of_strip_char(	"'", ls_value,"")  //remove the quotes added above
			res = of_validate_dea(ls_dea, "" )
			if res < 0 then
				choose case res
					case -1, -2 , -3 
						ls_mess = "Invalid DEA number ( " + ls_dea + " ) for record " + string (f) + ".  DEA number must be 9 Characters .  The first 2 characters, the rest numbers."
					case -4 
						ls_mess = "Invalid DEA number  ( " + ls_dea + " ) for record " + string (f) + ".  Second character must match the first letter of the last name of the provider."
					case -5
						ls_mess = "Invalid DEA number ( " + ls_dea + " ) for record " + string (f) + ".  Checksum error.  Please check data entry."
					case -6
						ls_mess = "Invalid DEA number  ( " + ls_dea + " ) for record " + string (f) + ". First character is not valid.  Valid first letters are A,B,F,G,M,P,R"	
				end choose
				messagebox("DEA Validation",ls_mess)
				return -1
				continue
				if v = 10 then //now set to check to see if it is unique
					ls_sql = "select rec_id from " + ls_tname + " where license_number = " + ls_value + ";"
					ls_mess = "Field DEA number is not unique in the database for record " + string(ai_row) + " (" + ls_dea + " ).  You must correct to save the record."
					 lb_run_syntax = true  
					v = 2 //reset so the message will run
				end if
			end if
		case 11, 15 // NPI  //Start Code Change ----04.14.2016 #V15 maha - added separate from special
			ls_npi = dw_detail.getitemstring(ai_row,ls_fname)
			// if len(ls_npi) = 0 then return 1 //Commented by Ken.Guo 2008-07-22
			If ls_npi = '' or isnull(ls_npi) Then Continue //Added by Ken.Guo 2008-07-22  //Start Code Change ----02.25.2014 #V14 maha - changed from return
			res = of_npi_validation(ls_npi ,"DE")  //Start Code Change ----04.23.2008 #V8 maha - this is an application function 
			if res < 0 then
				choose case res
					case -1
						ls_mess = "Invalid.  NPI number must be 10 Characters."
					case -2
						ls_mess = "Invalid.  NPI number can contain Numbers only."
					case -3
						ls_mess = "Invalid.  Not a valid NPI number"
				end choose
				messagebox("NPI Validation",ls_mess)
				return -1
				continue
				if v = 15 then //also check for unique
					ls_sql = "select rec_id from " + ls_tname + " where npi_number = " + ls_value + ";"
					ls_mess = "Field NPI number is not unique in the database on row " + string(ai_row) + ".  You must correct to save the record."
					 lb_run_syntax = true  //Start Code Change ----05.02.2013 #V12 maha
					v = 2 //reset so the message will run
				end if
			end if
	
		case 12  //Start Code Change ----03.14.2016 #V15 maha - phone number validation application level function does not prevent save
			of_validate_phone(ls_value, ls_label)
			return 1
		
		case 13,14  //SSN  //Start Code Change ----04.14.2016 #V15 maha - added separate from special
			ls_npi = dw_detail.getitemstring(ai_row,ls_fname)
			If ls_npi = '' or isnull(ls_npi) Then Continue //Added by Ken.Guo 2008-07-22   //Start Code Change ----02.25.2014 #V14 maha - changed from return
			res = of_npi_validation(ls_npi ,"SSN")  //Start Code Change ----04.23.2008 #V8 maha - this is an application function 
			if res < 0 then
				choose case res
					case -1
						ls_mess = "Invalid.  SSN number must be 9 Characters."
					case -2
						ls_mess = "Invalid.  SSN can contain Numbers only."
				end choose
				messagebox("SSN Validation",ls_mess)
				return -1
				continue
				if v = 14 then //now set to check to see if it is unique
					ls_sql = "select rec_id from " + ls_tname + " where ssn = " + ls_value + ";"
					ls_mess = "Field SSN is not unique in the database for  " + string(ai_row) + " " + ls_npi + " .  You must correct to save the record."
					v = 2 //reset so the message will run
				end if
			end if
			
		case 17 //DOB  //Start Code Change ----04.14.2016 #V15 maha 
			ls_date = of_strip_char(	"'", ls_value,"")  //remove the quotes added above
			ld_date = date(ls_date)

			li_year1 = year(today())
			li_year2 = year(ld_date)
			if li_year2 > li_year1 - 18 or li_year2 < li_year1 - 90 then
				messagebox("Date Validation", "Invalid date for " + ls_fname + " for record " + string (f) + ".  Must be with in the last 90 years and more than 18 years ago.")
				return 1
			end if
		
		case else
			return 1
//End Code Change ----04.14.2016
	end choose

	if  lb_run_syntax = true then 
		ls_presentation_str = "style(type=grid)" 
		ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql, ls_presentation_str, ERRORS)
		lds_count.Create( ls_dwsyntax_str, ERRORS)
		lds_count.settransobject(sqlca)
		ck = lds_count.retrieve()
		if ck > 0 then
			if ck = 1 and ll_recid = lds_count.getitemnumber(1,"rec_id") then
				//it is ok
				if v = 6 then  //Start Code Change ----08.11.2009 #V92 maha - for inova
					if not isnumber(ls_value) then
						messagebox("Data Entry Validation Numeric Warning", "Field " + upper(ls_fname) + " must have numeric data only, and have a unique value.  You must correct to save the record.")
						return -1
					end if
				end if
						
			else
				choose case v //warning only
					case 1,3
						res = messagebox("Data Entry Validation Warning", ls_mess,question!,yesno!,2)
						if res = 2 then 
							return -1
						end if
					case 2,4
						res = messagebox("Data Entry Validation Warning", ls_mess) 
						return -1
					case 6  //Start Code Change ----08.11.2009 #V92 maha - for inova
						 res = messagebox("Data Entry Validation Warning", ls_mess) 
						return -1
				end choose
			end if
		else
			if v = 6 then  //Start Code Change ----08.11.2009 #V92 maha - for inova
					if not isnumber(ls_value) then
						messagebox("Data Entry Validation  Numeric Warning", "Field " + upper(ls_fname) + " must have numeric data only, and have a unique value.  You must correct to save the record.")
						return -1
					end if
				end if
		end if
	end if
	
next
//End Code Change---10.02.2006
destroy lds_count			
destroy lds_fields
return 1
end function

public function integer of_lookup_search_dddw (string as_type);///******************************************************************************************************************
//**  [PUBLIC]   : of_lookup_search_dddw( /*string as_type */)
//**==================================================================================================================
//**  Purpose   	: Set the vales from the search window or back to the original value
//**==================================================================================================================
//**  Arguments 	: [string] as_type 
//**==================================================================================================================
//**  Returns   	: [none]   
//**==================================================================================================================
//**  Notes     	: 	   
//**==================================================================================================================
//**  Created By	: ??
//**==================================================================================================================
//**  Modification Log
//**   Changed By             Change Date                                               Reason
//** ------------------------------------------------------------------------------------------------------------------
//**  MSkinner 						 19 December 2005                           I was getin a GPF on line 24 of the original code
//**  mskinner 						 23 March    2006                           Modoified code so that -777 or -888 will not be saved
//********************************************************************************************************************/

//Start Code Change ----07.25.2013 #V14 maha - moved to other function
 inv_data_entry.of_lookup_search_dddw(as_type, dw_detail, is_lookup_search_column_table )
return 0

//DataWindowChild dwchild
//any l_any
//long li_row_cnt
//long ll_val
//long ll_find
//String ls_column_nm
//String ls_retval
//String ls_search_type
//String ls_value
//any ll_null
//setnull(ll_null)
//
//n_cst_dwsrv lnv_dwsrv
//lnv_dwsrv = create n_cst_dwsrv
//lnv_dwsrv.of_setrequestor( dw_detail)
//
//ls_column_nm = dw_detail.GetColumnName()
//
//ls_retval = dw_detail.Describe( ls_column_nm + ".DDDW.DisplayColumn" )
//
//dw_detail.getchild( ls_column_nm, dwchild)
////--------------------------- APPEON BEGIN ---------------------------
////$<add> 04.14.2006 By: Liang QingShi
////$<reason> Fix a defect.
//
//If appeongetclienttype() <> 'PB' Then
//   dw_detail.triggerevent('itemfocuschanged')
//end if
////---------------------------- APPEON END ----------------------------
//OpenWithParm( w_lookup_search_dddw,as_type + "@" + is_lookup_search_column_table )
//
//IF Message.StringParm = "Cancel" THEN
//	
//	ls_value = lnv_dwsrv.of_getitem( dw_detail.GetRow(), ls_column_nm , primary!,true)
//	if string(ls_value) = "-777" OR string(ls_value) = "-888" or not f_validstr(ls_value) then
//		setnull(ls_value)
//	end if
//
//	lnv_dwsrv.of_setitem( dw_detail.GetRow(), ls_column_nm, ls_value)
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<Add> 08.23.2007 By: Evan
//	//$<Reason> Need to destroy object.
//	if IsValid(lnv_dwsrv) then Destroy lnv_dwsrv
//	//---------------------------- APPEON END ----------------------------	
//	RETURN -1
//else
//	l_any = Message.DoubleParm
//	
//	lnv_dwsrv.of_setitem( dw_detail.GetRow(), ls_column_nm, string(l_any))
//	
//	dw_detail.accepttext()
//	inv_data_entry.of_dwchild_retrieve(is_lookup_search_column_table,as_type,dw_detail,"RET",l_any,ls_column_nm)
//end if
//
//IF IsValid( m_pfe_cst_data_entry ) THEN
//	m_pfe_cst_data_entry.m_edit.m_lookupsearch.Enabled = True
//END IF
//
////--------------------------- APPEON BEGIN ---------------------------
////$<Add> 08.23.2007 By: Evan
////$<Reason> Need to destroy object.
//if IsValid(lnv_dwsrv) then Destroy lnv_dwsrv
////---------------------------- APPEON END ----------------------------
//
//Return 0
end function

public function integer of_screen_color ();//for setting screen names green includes of_rec_count and code in the dw_detail pfc_postupdate event
//called from retrieveend of dw_select_section  the select section dw object has a modification field (selected) that changes the color

integer i
integer ic
integer sid
integer cnt
string tname
string ls_losttable
integer li_find
//messagebox("of_screen","")

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-16
//$<modify> 03.06.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Use cursor to retrieve data instead of using SQL statements.
//$<modification> this modification reduces client-server interactions.

/*
for i = 1 to dw_select_section.rowcount()
	sid = dw_select_section.getitemnumber(i,"table_id")
	if sid <> 0 then
		//cnt = inv_data_entry.of_rec_count(sid,ii_parent_facility_id)
		cnt = inv_data_entry.of_rec_count(sid,0)
		//if i < 0 then 
		//messagebox("cnt",cnt)
		dw_select_section.setitem(i,"selected",cnt)
	end if
next
*/

String ls_sql
for i = 1 to dw_select_section.rowcount()
	sid = dw_select_section.getitemnumber(i,"table_id")

	if sid <> 0 then
		tname = gnv_data.of_getitem("sys_tables","table_name","table_id = " + string(sid))
         
		//Start Code Change ----03.28.2011 #V11 maha - account for dba. leaders on old databases
		if pos(upper(tname),"DBA.",1) > 0 then
			debugbreak()
			tname = mid(tname,5)
		end if
		//End Code Change ----03.28.2011
		
		//------------------- APPEON BEGIN -------------------
		//$<add> Stephen 03.23.2011
		//$<reason> No Green Check marks 
		if isnull(tname) or trim(tname) = ''  then 
			ls_losttable = ls_losttable + '~r~n' + string(sid)
			continue
		end if
		
		li_find = ids_tablename.find("table_name = '"+tname+"'", 1, ids_tablename.rowcount())
		if li_find < 1 then
			ls_losttable = ls_losttable + '~r~n' + string(sid)
			continue
		end if
		//------------------- APPEON END -------------------
		
		If Len(ls_sql) > 0 Then 	ls_sql += "~r~n union ~r~n"
		//ls_sql += "select " + String(sid) + ", count(rec_id) cnt from " + tname + " where prac_id = " + string(gl_prac_id) 
		ls_sql += "select " + String(sid) + ", cnt=1 where exists( select 1 from " + tname + " where prac_id = " + string(gl_prac_id) + ")" 
	end if
next

DECLARE rec_cursor DYNAMIC CURSOR FOR SQLSA ;

PREPARE SQLSA FROM :ls_sql ;

OPEN DYNAMIC rec_cursor;

FETCH rec_cursor INTO :sid, :cnt ;

DO WHILE sqlca.sqlcode = 0
	
	If cnt = 1 Then
		for i = 1 to dw_select_section.rowcount()
			If sid = dw_select_section.getitemnumber(i, "table_id") Then
				dw_select_section.setitem(i, "selected", 1)
			end if
		next
	End If
	
	FETCH rec_cursor INTO :sid, :cnt ;
LOOP

CLOSE rec_cursor ;
//---------------------------- APPEON END ----------------------------

//------------------- APPEON BEGIN -------------------
//$<add> Stephen 03.23.2011
//$<reason> No Green Check marks 
if trim(ls_losttable) <> '' and not isnull(ls_losttable) then
	messagebox("Caution", "Failed to find table name for table_id : ~r~n" + ls_losttable)
end if
//---------------------------- APPEON END ----------------------------

return 1
end function

public function integer of_dwchild_retrieve (string as_lu_table, string as_type, u_dw adw_dw, string as_from, long al_value, string as_column_nm);//created maha 060805 to add search item in each lookup.  Called from of_create_dynamic_dw and the date entry user object of_lookup_function

long ll_val
datawindowchild dwchild
long ll_find
	
adw_dw.GetChild( as_column_nm, dwchild )
dwchild.retrieve(as_lu_table)
	
IF as_type = "C" THEN
	choose case as_lu_table
		case "Address Type"
			//exceptions
		case "Yes/No"
			//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.Lines= 15")
			//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.Lines= 20")
		case else
			dwchild.InsertRow(1)
			dwchild.setitem(1,"code",'-SEARCH/Add-')
			dwchild.setitem(1,"lookup_code",-777)
			dwchild.setitem(1,"description","-Search/Add for " + as_lu_table +" -")
	end choose
end if

IF as_type = "A" THEN
	dwchild.InsertRow(1)
	if dwchild.Describe("entity_name_original.ColType") <> "!" then
		//messagebox("","en")
		//long ert			
		dwchild.setitem(1,"code",'-SEARCH/ADD-')
		dwchild.setitem(1,"lookup_code",-888)
		dwchild.setitem(1,"entity_name_original","-Search/Add for " + as_lu_table +" -")
		//ert = dwchild.getitemnumber(1,"lookup_code")
		//messagebox("",ert)
	end if
end if
		
dwchild.InsertRow(1) //blank row

if as_from = "RET" then
	ll_val = al_value
	adw_dw.SetItem( adw_dw.GetRow(), as_column_nm, ll_val )
	adw_dw.accepttext()
	ll_find = dwchild.find("lookup_code = " + string(ll_val),1,dwchild.rowcount())
	if ll_find > 0 then
		dwchild.scrolltorow(ll_find)
	end if
end if


return 1
end function

public function integer of_lookup_search (string as_type);String ls_column_nm
String ls_retval
String ls_search_type
String ls_value
DataWindowChild dwchild
Integer li_row_cnt

ls_column_nm = dw_detail.GetColumnName()

ls_retval = dw_detail.Describe( ls_column_nm + ".DDDW.DisplayColumn" )
IF ls_retval <> "entity_name" THEN
	MessageBox("Lookup Search", "This is not an address lookup table" )
	RETURN -1
END IF

OpenWithParm( w_lookup_search, is_lookup_search_column_table )
IF Message.StringParm = "Cancel" THEN
	IF IsValid( m_pfe_cst_data_entry ) THEN
		//m_pfe_cst_data_entry.m_edit.m_lookupsearch.Enabled = True
		gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_edit.m_lookupsearch,'Enabled', True)
	END IF	
	RETURN -1
END IF


dw_detail.SetItem( dw_detail.GetRow(), ls_column_nm, Message.DoubleParm )

IF IsValid( m_pfe_cst_data_entry ) THEN
	//m_pfe_cst_data_entry.m_edit.m_lookupsearch.Enabled = True
	gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_edit.m_lookupsearch,'Enabled', True)
END IF	



Return 0


//debugbreak()
//ls_value = Upper( Mid( Message.StringParm, 1, POS( Message.StringParm, "-" ) -1 ) )
//ls_search_type = Mid( Message.StringParm, POS( Message.StringParm, "-" )+1, 1000 )
//dw_detail.GetChild( ls_column_nm, dwchild )
//IF ls_search_type = "city" THEN
//	dwchild.SetFilter( "Upper(city) = '" + ls_value + "'" )
//ELSEIF ls_search_type = "state" THEN
//	dwchild.SetFilter( "Upper(state) = '" + ls_value + "'" )
//ELSEIF ls_search_type = "country" THEN
//	dwchild.SetFilter( "Upper(country) = '" + ls_value + "'" )
//ELSE
//	//dw_detail.Modify( ls_column_nm + ".DDDW.Name = 'd_dddw_address_lookup'" )
//	//dw_detail.Modify( ls_column_nm + ".DDDW.DisplayColumn = 'entity_name'" )
//	//dw_detail.Modify( ls_column_nm + ".DDDW.DataColumn = 'lookup_code'" )
//	//dw_detail.Modify( ls_column_nm + ".DDDW.VScrollbar" )
//	//dw_detail.Modify( ls_column_nm + ".dddw.Lines= 15")	
//	//dw_detail.GetChild( ls_column_nm, dwchild )	
//	//dwchild.SetTransObject( SQLCA )
//	//li_row_cnt =dwchild.Retrieve( is_lookup_search_column_table )
//	dwchild.SetFilter("")
//	dw_select_section.SetFocus()
//	dw_detail.SetFocus()
//	is_lookup_search_column = "None"
//END IF
//
//dw_detail.Modify( ls_column_nm + ".dddw.Lines= 15")	
//dwchild.Filter()
//dw_select_section.SetFocus()
//dw_detail.SetFocus()
//	
//IF IsValid( m_pfe_cst_data_entry ) THEN
//	m_pfe_cst_data_entry.m_edit.m_lookupsearch.Enabled = True
//END IF
//
//is_lookup_search_column = ls_column_nm
//
//RETURN 1
end function

public function integer of_add_questions (string as_from);//function created maha app081705 for adding attest questions in a batch.  Called from dw_detail pfc_addrow
//Argument currently not used; for possible future development
//moved the de functions object can be deleted after all tested ok

//integer i
//integer r
//integer c
//integer cr
//integer ck = 0
//long ls_exist_id
//long ls_new_id
//long ll_as_id
//gs_variable_array ls_array
//long il_id[]
//integer cnt
//
//cr = dw_detail.rowcount()
//
//select count(rec_id) into :cnt from pd_affil_stat where prac_id = :gl_prac_id and parent_facility_id = :ii_parent_facility_id and active_status > 0;
//if cnt < 1 then
//	messagebox("Appointment record error","There are multiple non-history records (Active,Inactive,Pending,Purge) for this practitioner and facility.  This should be corrected on the Appointment Status tab before adding Attestation Questions.")
//	return - 1 
//else
//	select rec_id into :ll_as_id from pd_affil_stat where prac_id = :gl_prac_id and parent_facility_id = :ii_parent_facility_id and active_status > 0;
//end if	
//
//open (w_question_select)
//if message.stringparm = "Cancel" then
//	return 0
//else
//	ls_array = message.powerobjectparm
//	il_id = ls_array.as_number
//	for i = 1 to upperbound(il_id)
//		ls_new_id = il_id[i]
//		ck = 0
//		for c = 1 to cr  //check existing records to avoid duplicates
//			ls_exist_id = dw_detail.getitemnumber(c,"question_id")
//			if ls_new_id = ls_exist_id then ck = 1
//		next
//		if ck = 1 then  //if exists skip
//			continue
//		else
//			r = dw_detail.insertrow(0)
//			//dw_detail.setitem(r,"facility_id",ii_parent_facility_id)
//			//dw_detail.setitem(r,"prac_id",il_id[i])
//			dw_detail.setitem(r,"active_status",1)
//			dw_detail.setitem(r,"question_id",il_id[i])
//			dw_detail.setitem(r,"appt_stat_id",ll_as_id)
//		end if
//	next
	return 1
//end if


end function

public function integer of_add_npdb (long al_prac_id, long al_rec_id, long al_screen_id, string as_reference, datetime adt_exp_date, string as_screen_name, long al_address_lookup_code, string as_add_type, integer ai_parent_facility_id);//////////////////////////////////////////////////////////////////////
// $<function>pfc_cst_u_verification_info.of_add_npdb()
// $<arguments>
//		long    	al_prac_id            		
//		long    	al_rec_id             		
//		long    	al_screen_id          		
//		string  	as_reference          		
//		datetime	adt_exp_date          		
//		string  	as_screen_name        		
//		long    	al_address_lookup_code		
//		string  	as_add_type           		
//		integer 	ai_parent_facility_id 		
// $<returns> integer
// $<description> This function is copied from pfc_cst_u_verification_info object. The tab control used
// $<description> the CreateOnDemand property in the parent window. So, The data can not be added if the verif
// $<description> tabpage has not been selected when setting data entry complete.
//////////////////////////////////////////////////////////////////////
// $<add> 02.20.2006 by Cao YongWang
//////////////////////////////////////////////////////////////////////

//created 020901 to allow only one npdb to be created when clicking data entry complete
Integer li_nr
Integer li_row_cnt
Integer li_rc
Integer i
Integer ll_hc_code
Long ll_seq_no
Integer li_rsp_rc
//Integer li_facility_id
Long ll_default_verif_method
String ls_identifying_number
String ls_doc_id
String ls_priority_user
Integer li_priority
datastore lds_ver_orgs_facilities
datastore lds_last_verif_seq_no
datastore lds_dfl_rsp_code

datastore ds_detail

IF al_address_lookup_code = 0 THEN
	SetNull( al_address_lookup_code )
END IF

ls_identifying_number = Mid( as_reference, POS( as_reference, "-") + 2, 100 )

lds_dfl_rsp_code = CREATE datastore
lds_dfl_rsp_code.DataObject = "d_app_audit_get_hc_dflt_ver_resp_code"
lds_dfl_rsp_code.SetTransObject( SQLCA )

ds_detail = CREATE datastore
ds_detail.dataobject = 'd_ver_summary_record_view'
ds_detail.settransobject(SQLCA)

gnv_appeondb.of_startqueue()

li_rsp_rc = lds_dfl_rsp_code.Retrieve( al_prac_id, al_screen_id, ls_identifying_number )

lds_ver_orgs_facilities = CREATE datastore
lds_ver_orgs_facilities.DataObject = "d_verifying_orgs_facilities_p"
lds_ver_orgs_facilities.SetTransObject( SQLCA )
li_rc = lds_ver_orgs_facilities.Retrieve( ai_parent_facility_id, al_prac_id, al_screen_id ) //maha changed to ai_parent_facility_id from ii_facility_id 021004

gnv_appeondb.of_commitqueue()
li_rsp_rc = lds_dfl_rsp_code.rowcount()
li_rc = lds_ver_orgs_facilities.Rowcount()

IF li_rc = 0 THEN
	MessageBox("Error in of_add_npdb of pfc_cst_u_verification", "No affiliation status records found." )//+ "  facility =" + string(ii_facility_id) + "  prac =" + string(al_prac_id) + "  Screen =" + string(al_screen_id))
	//MessageBox("Error", "This practitioner is not in the verification process, therefore no verification records can be added." )
	//--------------------------- APPEON BEGIN ---------------------------
	//$<Modify> 08.23.2007 By: Evan
	//$<Reason> Need to destroy object.
	if IsValid(lds_ver_orgs_facilities) then Destroy lds_ver_orgs_facilities
	if IsValid(lds_last_verif_seq_no) then Destroy lds_last_verif_seq_no
	if IsValid(lds_dfl_rsp_code) then Destroy lds_dfl_rsp_code
	if IsValid(ds_detail) then Destroy ds_detail
	//---------------------------- APPEON END ----------------------------	
	Return -1
END IF

lds_last_verif_seq_no = CREATE datastore
lds_last_verif_seq_no.DataObject = "d_last_verif_seq_no"
lds_last_verif_seq_no.SetTransObject( SQLCA )

FOR i = 1 TO li_rc
	CHOOSE CASE as_screen_name
			CASE "NPDB Results"
				//npdb query
				ll_default_verif_method = 17				
			CASE "HIPDB Results"
				//hipdb query
				ll_default_verif_method = 14
			CASE "Work Gap"
				//hard copy
				ll_default_verif_method = 644
		END CHOOSE

	li_nr = ds_detail.InsertRow( 0 ) //maha changes made 112101
	//li_facility_id = lds_ver_orgs_facilities.GetItemNumber( i, "verifying_facility" )	
	ls_priority_user = lds_ver_orgs_facilities.GetItemString( i, "priority_user" )	
	li_priority = lds_ver_orgs_facilities.GetItemNumber( i, "priority" )	
	ds_detail.SetItem( li_nr, "prac_id", al_prac_id )
	//ds_detail.SetItem( li_nr, "direct_parent_facility_link", ai_parent_facility_id )	
	ds_detail.SetItem( li_nr, "rec_id", al_rec_id )
	//ds_detail.SetItem( li_nr, "facility_id", ai_parent_facility_id) //li_facility_id )
	ds_detail.SetItem( li_nr, "verif_info_facility_id", ai_parent_facility_id) //li_facility_id )
	ds_detail.SetItem( li_nr, "priority_user", ls_priority_user )
	ds_detail.SetItem( li_nr, "priority", li_priority )
	ds_detail.SetItem( li_nr, "number_sent", 0 )
	ds_detail.SetItem( li_nr, "exp_credential_flag", 0)
	ds_detail.SetItem( li_nr, "print_flag", 1)
	IF li_rsp_rc = 1 THEN
		ds_detail.SetItem( li_nr, "response_code", lds_dfl_rsp_code.GetItemNumber( 1, "default_ver_response" ))
		ds_detail.SetItem( li_nr, "user_name", ls_priority_user )
		ds_detail.SetItem( li_nr, "date_recieved", Today() )
		
		/*
		SELECT code_lookup.lookup_code  
      INTO :ll_hc_code  
      FROM code_lookup  
      WHERE code_lookup.code = 'Hard Copy'   ;
		*/
		ll_hc_code = long(gnv_data.of_getitem("code_lookup","lookup_code","upper(code)='" + upper('Hard Copy') + "'"))
		
  	   ds_detail.SetItem( li_nr, "verification_method", ll_hc_code )				
	ELSE
		ds_detail.SetItem( li_nr, "verification_method", ll_default_verif_method )		
	END IF

	//<add> 06/28/2007 by: Andy 
	//Reason:It will generate the same ll_seq_no,when li_rc more than 1.
	if i = 1 then
	//end of add
		//find out the last seq no used
		li_row_cnt = lds_last_verif_seq_no.Retrieve( al_rec_id, al_prac_id, ai_parent_facility_id )	//maha modified parent variable 031004
		IF li_row_cnt < 1 THEN
			ll_seq_no = 1 
		ELSE
			ll_seq_no = lds_last_verif_seq_no.GetItemNumber( 1, "last_seq_no" ) + 1
		END IF
		if isnull(ll_seq_no) then 	ll_seq_no = 1	//maha 091900
	//<add> 06/28/2007 by: Andy	
	else
		ll_seq_no ++
	end if
	//end of add		
	ds_detail.SetItem( li_nr, "seq_no", ll_seq_no )
	ds_detail.SetItem( li_nr, "screen_id", al_screen_id )
	ds_detail.SetItem( li_nr, "reference_value", as_reference )
	ds_detail.SetItem( li_nr, "expiration_date", adt_exp_date )
	ds_detail.SetItem( li_nr, "screen_name", as_screen_name )
	ds_detail.SetItem( li_nr, "address_lookup_code", al_address_lookup_code )
	ls_doc_id = String( al_rec_id ) + "-" + String( al_prac_id ) + "-" + String(ai_parent_facility_id ) +  "-" + String( ll_seq_no ) //maha modified parent variable 031004
	ds_detail.SetItem( li_nr, "doc_id", ls_doc_id )
	//Start Code Change ----11.07.2017 #V154 maha
	ds_detail.SetItem(li_nr, 'create_date', datetime(today(),now()))
	ds_detail.SetItem(li_nr, 'create_user', gs_user_id + "-DEC") 
	//End Code Change ----11.07.2017
END FOR

//ds_detail.SetFocus()
//ds_detail.ScrollToRow( li_nr )
//ds_detail.SetRow( li_nr )

DESTROY lds_ver_orgs_facilities
DESTROY lds_last_verif_seq_no
DESTROY lds_dfl_rsp_code

ds_detail.Update()

//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 08.23.2007 By: Evan
//$<Reason> Need to destroy object.
if IsValid(ds_detail) then Destroy ds_detail
//---------------------------- APPEON END ----------------------------

RETURN 1


end function

public function integer of_add_oig (long al_prac_id, long al_rec_id, integer ai_parent_facility);//////////////////////////////////////////////////////////////////////
// $<function>pfc_cst_u_verification_infoof_add_oig()
// $<arguments>
//		long   	al_prac_id        		
//		long   	al_rec_id         		
//		integer	ai_parent_facility		
// $<returns> integer
// $<description> This function is copied from pfc_cst_u_verification_info object. The tab control used
// $<description> the CreateOnDemand property in the parent window. So, The data can not be added if the verif
// $<description> tabpage has not been selected when setting data entry complete.
//////////////////////////////////////////////////////////////////////
// $<add> 02.20.2006 by Cao YongWang
//////////////////////////////////////////////////////////////////////
//created 032703 for oig vers
Integer li_nr
Integer li_row_cnt
Integer li_rc
Integer i
Integer ll_hc_code
Long ll_seq_no
integer res
Integer li_facility_id
Long ll_default_verif_method
String ls_identifying_number
String ls_doc_id
String ls_priority_user
Integer li_priority
datastore lds_ver_orgs_facilities
datastore lds_last_verif_seq_no
datastore lds_dfl_rsp_code
datastore ds_detail

//MessageBox("oig","of_add in veri iinfo")
//IF al_address_lookup_code = 0 THEN
//	SetNull( al_address_lookup_code )
//END IF

//ls_identifying_number = Mid( as_reference, POS( as_reference, "-") + 2, 100 )
//
//lds_dfl_rsp_code = CREATE n_ds
//lds_dfl_rsp_code.DataObject = "d_app_audit_get_hc_dflt_ver_resp_code"
//lds_dfl_rsp_code.of_SetTransObject( SQLCA )
//li_rsp_rc = lds_dfl_rsp_code.Retrieve( al_prac_id, al_screen_id, ls_identifying_number )

ds_detail = CREATE datastore
ds_detail.dataobject = 'd_ver_summary_record_view'
ds_detail.settransobject(SQLCA)

lds_ver_orgs_facilities = CREATE datastore
lds_ver_orgs_facilities.DataObject = "d_verifying_orgs_facilities_p"
lds_ver_orgs_facilities.SetTransObject( SQLCA )
li_rc = lds_ver_orgs_facilities.Retrieve( ii_parent_facility_id, al_prac_id, 1 )
IF li_rc = 0 THEN
	MessageBox("Error in of_add_npdb of pfc_cst_u_verification", "No affiliation status records found." )//+ "  facility =" + string(ii_facility_id) + "  prac =" + string(al_prac_id) + "  Screen =" + string(al_screen_id))
	//MessageBox("Error", "This practitioner is not in the verification process, therefore no verification records can be added." )
	//--------------------------- APPEON BEGIN ---------------------------
	//$<Modify> 08.23.2007 By: Evan
	//$<Reason> Need to destroy object.
	if IsValid(lds_ver_orgs_facilities) then Destroy lds_ver_orgs_facilities
	if IsValid(lds_last_verif_seq_no) then Destroy lds_last_verif_seq_no
	if IsValid(lds_dfl_rsp_code) then Destroy lds_dfl_rsp_code
	if IsValid(ds_detail) then Destroy ds_detail
	//---------------------------- APPEON END ----------------------------	
	Return -1
END IF

lds_last_verif_seq_no = CREATE datastore
lds_last_verif_seq_no.DataObject = "d_last_verif_seq_no"
lds_last_verif_seq_no.SetTransObject( SQLCA )



//ll_default_verif_method = 20
//\/changed maha 062804
/*
select lookup_code into :ll_default_verif_method from code_lookup where code = 'OIG QUERY';
*/
ll_default_verif_method=long(gnv_data.of_getitem("code_lookup","lookup_code","upper(code)='OIG QUERY'"))

if ll_default_verif_method < 1 or isnull(ll_default_verif_method) then
	MessageBox("Error in of_add_oig of pfc_cst_u_verification", "There is no lookup with the code of 'OIG QUERY' in the Verification Method lookup table.  Unable to create OIG verification" )
	return 1
end if
//\maha

li_nr = ds_detail.InsertRow( 0 ) 

ls_priority_user = lds_ver_orgs_facilities.GetItemString( li_rc, "priority_user" )	
li_priority = lds_ver_orgs_facilities.GetItemNumber( li_rc, "priority" )	
ds_detail.SetItem( li_nr, "prac_id", al_prac_id )
ds_detail.SetItem( li_nr, "rec_id", al_rec_id )
ds_detail.SetItem( li_nr, "verif_info_facility_id", ai_parent_facility) //li_facility_id )
ds_detail.SetItem( li_nr, "verification_method", ll_default_verif_method )
ds_detail.SetItem( li_nr, "priority_user", ls_priority_user )
ds_detail.SetItem( li_nr, "priority", li_priority )
ds_detail.SetItem( li_nr, "number_sent", 0 )
ds_detail.SetItem( li_nr, "exp_credential_flag", 0)
ds_detail.SetItem( li_nr, "print_flag", 1)
ds_detail.SetItem( li_nr, "seq_no",1 )
ds_detail.SetItem( li_nr, "screen_id", 1 )
ds_detail.SetItem( li_nr, "reference_value", "OIG QUERY" )
//ds_detail.SetItem( li_nr, "expiration_date", adt_exp_date )
ds_detail.SetItem( li_nr, "screen_name", "Basic Information" )
//ds_detail.SetItem( li_nr, "address_lookup_code", al_address_lookup_code )
ls_doc_id = String( al_rec_id ) + "-" + String( al_prac_id ) + "-" + String( ai_parent_facility ) +  "-" + "1"
ds_detail.SetItem( li_nr, "doc_id", ls_doc_id )
//Start Code Change ----11.07.2017 #V154 maha
ds_detail.SetItem(li_nr, 'create_date', datetime(today(),now()))
ds_detail.SetItem(li_nr, 'create_user', gs_user_id + "-DEC") 
//End Code Change ----11.07.2017

//dw_detail.SetFocus()
//dw_detail.ScrollToRow( li_nr )
//dw_detail.SetRow( li_nr )

DESTROY lds_ver_orgs_facilities
DESTROY lds_last_verif_seq_no
DESTROY lds_dfl_rsp_code

res = ds_detail.Update()

//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 08.23.2007 By: Evan
//$<Reason> Need to destroy object.
if IsValid(ds_detail) then Destroy ds_detail
//---------------------------- APPEON END ----------------------------

if res < 1 then
	messagebox("OIG Verification Creation","Update failed.  Record not enetered")
end if


RETURN 1

end function

public function integer of_error_message (string as_field, integer ai_row, string as_title, string as_mess);//Start Code Change ---- 03.24.2006 #340 maha

integer res
string ls_plus

ls_plus = "~r~rData will not be saved for row " + string(ai_row) + "."

res = messagebox(as_title,as_mess + ls_plus,question!,ok!)
//if res = 1 then 
dw_detail.setitemstatus( ai_row, 0, primary!,notmodified!)
				
return 1

//End Code Change---03.24.2006
end function

public function integer of_detail_scrollbar (integer ai_screen_id);//messagebox("", "of detail scrollbar")
//Start Code Change ---- 06.15.2006 #544 maha -- created to slimpify mods
//maha added 06.15.06; called from dw_selection.rfc and pfc_after_select as well as tab_view.selection changed
//Start Code Change ----12.13.2007 #V8 maha -- added detail 2 modifications
choose case ai_screen_id
	case 10,2,19  , 32,65,70,71,26 //address, hospital, specialty //Start Code Change ----05.09.2014 #V14.2 maha - added facility specific screens
		dw_browse.vscrollbar = True
		dw_detail.vscrollbar = True
//		dw_detail.height = 1140
//		dw_browse.height = 1140
//Start Code Change ----03.16.2016 #V15 maha - modified based on setting
		if ib_facil_links then
			dw_link_list.visible = True
			dw_link_list.bringtotop = True
			//tab_view.tabpage_image.dw_detail_2.height = 1140
			//Add By Jervis 04.02.2008
			tab_view.tabpage_image.dw_detail_2.height = r_1.height - dw_link_list.height - 15
			dw_detail.height = tab_view.tabpage_image.dw_detail_2.height
			dw_browse.height = tab_view.tabpage_image.dw_detail_2.height
		else
			dw_link_list.visible = False
			dw_detail.height = r_1.height
			dw_browse.height = r_1.height
			tab_view.tabpage_image.dw_detail_2.height = r_1.height
		end if	
		//dw_link_list.bringtotop = True
//End Code Change ----03.16.2016
	
		if tab_view.selectedtab = 3 then //detail 2 screen used for address only rarely
			dw_link_list.visible = True
			dw_link_list.bringtotop = True
		end if

		//End By Jervis 04.02.2008
	case 16 //, 65 //claims, attest quest
		dw_detail.vscrollbar = True
		//Start Change By Jervis 04.02.2008
		//dw_detail.height = 1484	
		//tab_view.tabpage_image.dw_detail_2.height = 1484
		dw_detail.height = r_1.height
		tab_view.tabpage_image.dw_detail_2.height = r_1.height
		//End Change By Jervis 04.02.2008
//	case 55 //Work Gap //Add by Evan 05.13.2009 --- Corrected BugA120402 //Start Code Change ----01.19.2011 #V11 maha - no long required
//		dw_detail.VScrollbar = True
	case ELSE
		dw_detail.vscrollbar = true //Start Code Change ----01.19.2011 #V11 maha - changed from false
		//Start Change By Jervis 04.02.2008
		//dw_detail.height = 1484
		//dw_browse.height = 1484
		//tab_view.tabpage_image.dw_detail_2.height = 1484
		dw_detail.height = r_1.height
		dw_browse.height = r_1.height
		tab_view.tabpage_image.dw_detail_2.height = r_1.height
		//End Change By Jervis 04.02.2008
END choose
//End Code Change---12.13.2007
IF ii_screen_id > 100 THEN //custom screen
	dw_detail.vscrollbar = True
END IF

//Start Code Change ----07.01.2014 #V14.2 maha
if tab_view.selectedtab = 4 then
	dw_link_list.visible = false
end if
//End Code Change ----07.01.2014

return 1
end function

public function integer of_validate_image ();//////////////////////////////////////////////////////////////////////
// $<function>pfc_cst_u_data_entryof_validate_image()
// $<arguments>
//		value	integer		
// $<returns> integer
// $<description>Queue Images for Scanning from Data Entry.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 10.12.2006 by Jack (Inova)
//////////////////////////////////////////////////////////////////////
if isvalid(ids_image_data) then
	ids_image_data.reset()
	
	if ids_image_data.retrieve(il_prac_id) > 0 then
		return -1
	else
		return 1
	end if
end if
return 1


end function

public subroutine of_refresh_page_menu ();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 06/10/2008 By: Ken.Guo
//$<reason> synchronization menu
if isvalid(m_pfe_cst_data_entry) then 
	if dw_detail.rowcount() > 1 then 
//		 m_pfe_cst_data_entry.m_view.m_priorpage.enabled = true
//		 m_pfe_cst_data_entry.m_view.m_nextpage.enabled = true
		 gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_view.m_priorpage,'enabled', true)
	 	 gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_view.m_nextpage,'enabled', true)
		 if isvalid(parent_window) then  //add by stephen 07.03.2012  --Null object reference 
		 	If parent_window.tab_1.selectedtab = 2 Then //Add if condition for not changing other tabs's button, Added by Appeon long.zhang 01.08.2016 (BugL010802)
			parent_window.cb_next.enabled = true 
			parent_window.cb_prior.enabled = true 
			End If
		 end if
	 
	else 
//		 m_pfe_cst_data_entry.m_view.m_priorpage.enabled = false
//		 m_pfe_cst_data_entry.m_view.m_nextpage.enabled = false
		 gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_view.m_priorpage,'enabled', false)
		 gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_view.m_nextpage,'enabled', false)
		 if isvalid(parent_window) then  //add by stephen 07.03.2012  --Null object reference  
		 	 If parent_window.tab_1.selectedtab = 2 Then //Add if condition for not changing other tabs's button, Added by Appeon long.zhang 01.08.2016 (BugL010802)
			 parent_window.cb_next.enabled = false 
			 parent_window.cb_prior.enabled = false
			End If
		end if
	end if 
end if
//---------------------------- APPEON END ----------------------------

end subroutine

public function long of_download_photo (long al_pracid, string as_downdir);//------------------------------------------------------------------------------
// Function: of_Download_Photo()
//------------------------------------------------------------------------------
// Description: Download Photo from database
// Arguments:
//		1 -- Prac_id
//		2 -- Down Directory
// Return Value: 
//	  -1 -- Failed
//		1 -- Sucess
//------------------------------------------------------------------------------
// Author:	Scofield		Date: 2008-07-10
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

String	ls_PicName,ls_Postfix
long		ll_FileNo,ll_Cycle,ll_DataLen,ll_Count,ll_Start,ll_FileLen
Blob		lblb_Buffer
String	ls_Rtn

long 		READ_ONE_COUNT = 8000

SELECT image_type INTO :ls_Postfix from pd_photo WHERE pd_photo.prac_id = :al_PracID ;
if IsNull(ls_Postfix) or Trim(ls_Postfix) = "" then Return -1

gnv_appeondll.of_parsepath(as_DownDir) //alfee 09.04.2014 - Bug #4176

ls_Rtn = f_ExaWriteRight(as_DownDir)
if Len(ls_Rtn) > 0 then
	MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
	Return -1
end if

ls_PicName = as_DownDir + String(al_PracID) + "." + ls_Postfix
if FileExists(ls_PicName) then ll_FileLen = FileLength(ls_PicName)

SELECT Datalength(pd_photo.image_data)
  INTO :ll_DataLen
  FROM pd_photo
 WHERE pd_photo.prac_id = :al_PracID ;

if IsNull(ll_DataLen) or ll_DataLen <= 0 then Return -1
if ll_DataLen = ll_FileLen then Return 1

ll_FileNo = FileOpen(ls_PicName,StreamMode!,Write!,LockReadWrite!,Replace!)
if ll_FileNo <= 0 then Return -1

ll_Count = Ceiling(ll_DataLen/READ_ONE_COUNT)

if AppeonGetClientType() = 'PB' and gs_dbtype = 'SQL' and ll_DataLen > READ_ONE_COUNT then
	for ll_Cycle = 1 To ll_Count
		ll_Start = (ll_Cycle - 1) * READ_ONE_COUNT + 1
		SELECTBLOB SubString(image_data,:ll_Start,:READ_ONE_COUNT)
		      INTO :lblb_Buffer
		      FROM pd_photo
		     WHERE pd_photo.prac_id = :al_PracID ;
		
		FileWrite(ll_FileNo,lblb_Buffer)
	next
else
	SELECTBLOB image_data
	      INTO :lblb_Buffer
	      FROM pd_photo
 		  WHERE pd_photo.prac_id = :al_PracID ;
			
	for ll_Cycle = 1 To ll_Count
		FileWrite(ll_FileNo,BlobMid(lblb_Buffer,(ll_Cycle - 1) * READ_ONE_COUNT + 1,READ_ONE_COUNT))
	next
end if

FileClose(ll_FileNo)

Return 1

end function

public function integer of_links_security (integer ai_screen);//Start Code Change ----05.26.2009 #V92 maha - added for links security

if w_mdi.of_security_access( 50 ) = 1 then
	choose case ai_screen
		case 2 //address
			dw_link_list.Modify("primary_office.protect = '1'" ) 
			dw_link_list.Modify("additional_office.protect = '1'" ) 
			dw_link_list.Modify("mailing.protect = '1'" ) 
			dw_link_list.Modify("home_address.protect = '1'" ) 
			dw_link_list.Modify("exp_letters.protect = '1'" ) 
			dw_link_list.Modify("billing.protect = '1'" ) 
			dw_link_list.Modify("include_in_directory.protect = '1'" ) 
			//Start Code Change ----08.05.2009 #V92 maha - hide arrow buttons
			dw_link_list.Modify("p.visible = false" ) 
			dw_link_list.Modify("a.visible = false" ) 
			dw_link_list.Modify("b.visible = false" ) 
			dw_link_list.Modify("h.visible = false" ) 
			dw_link_list.Modify("m.visible = false" ) 
			dw_link_list.Modify("e.visible = false" ) 
			dw_link_list.Modify("d.visible = false" ) 
			//End Code Change---08.05.2009
		case 10 //hospital
			dw_link_list.Modify("pd_hosp_facility_link_primary_hosp.protect = '1'" ) 
			dw_link_list.Modify("hospital.enabled = False" ) 
		case 19  //specialty
			dw_link_list.Modify("pd_spec_facility_link_practicing.protect = '1'" ) 		
			dw_link_list.Modify("specialty.enabled = False" ) 	
	end choose
end if

return 1
end function

public function integer of_delete_photo ();//Start Code Change ----07.22.2009 #V92 maha - function added to clear photo
integer res

res = messagebox("Delete Provide Photo", "Are you sure you wish to delete the photo record from the database?",Question!,yesno!,2)

if res = 1 then
	Delete FROM pd_photo WHERE pd_photo.prac_id = :il_prac_id ;
	Parent_Window.tab_1.tabpage_detail.p_face.Visible = false  //Start Code Change ----03.22.2010 #V10 maha - moved inside if statement 
	Parent_Window.p_prac_photo.PictureName = "nophoto2.jpg"	//alfee 10.08.2010
end if



return 1
end function

public function integer of_bg_color (long al_rgb);
//Start Code Change ----05.25.2010 #V10 maha

this.backcolor = al_rgb
tab_view.backcolor = al_rgb
tab_view.tabpage_browse.backcolor = al_rgb
tab_view.tabpage_details.backcolor = al_rgb
tab_view.tabpage_image.backcolor = al_rgb
st_recs.backcolor = al_rgb



return 1
end function

public function integer of_filter_links (string as_filter);//Start Code Change ----10.20.2010 #V10 maha - function added to filter to single record or show all

choose case ii_screen_id     //Start Code Change ----05.09.2014 #V14.2 maha - facility specific screens
	case 32,70,71,65,72, 26
		return 1
end choose

If as_filter = "One" then //reverse of button text called from retrieve end
	if dw_link_list.object.b_filter.text = "Show All" then
		dw_link_list.setfilter("facility_id = " + string( ii_parent_facility_id) )
		dw_link_list.filter()
	else
		dw_link_list.setfilter("" )
		dw_link_list.filter()
		if as_filter = "Click" then
			dw_link_list.object.b_filter.text = "Show All"
		end if
	end if
else //Click called from buttonclicked
	if dw_link_list.object.b_filter.text = "Show All" then
		dw_link_list.setfilter("")
		dw_link_list.filter()
		if as_filter = "Click" then
			dw_link_list.object.b_filter.text = "Show Current Facility"
		end if
	else
		dw_link_list.setfilter("facility_id = " + string( ii_parent_facility_id) )
		dw_link_list.filter()
		if as_filter = "Click" then
			dw_link_list.object.b_filter.text = "Show All"
		end if
	end if
end if

return 1



end function

public function string of_get_reference ();//==========================================
// $<Function> of_get_reference ()
// $<arguments> none
// $<returns> string "reference value" - success; "" - failure 
// $<description> red flag data: get the reference value of  current record 
// $<add> (Appeon) Long 07.12.2011
//copied and modified from intellicred_comp.pbl@pfc_cst_u_data_entry.dw_detail.pfc_preupdate()
//==========================================

string ls_ref_1,ls_ref_2,ls_ref_3
string ls_type1,ls_type2,ls_type3
string ls_reference
Integer li_retval,li_found,li_screen_id
long ll_address_code,ll_current_row
DataWindowChild dwchild

ll_current_row = dw_detail.getrow( )
IF ll_current_row < 1 Then Return ""
ls_ref_1 = dw_select_section.GetItemString( il_last_row, "ref_field_1")
ls_ref_2 = dw_select_section.GetItemString( il_last_row, "ref_field_2")
ls_ref_3 = dw_select_section.GetItemString( il_last_row, "ref_field_3")
ls_type1 = dw_select_section.GetItemString( il_last_row, "ref_1_type")
ls_type2 = dw_select_section.GetItemString( il_last_row, "ref_2_type")
ls_type3 = dw_select_section.GetItemString( il_last_row, "ref_3_type")

li_screen_id = dw_select_section.GetItemNumber( il_last_row, "screen_id")
if dw_detail.Describe(ls_ref_1 + ".ColType") = "!"  or ls_ref_1 = "" then //trap for invisible field maha 012104 
		return ""
end if
li_retval = dw_detail.setcolumn( ls_ref_1)
IF li_retval = 1 THEN
			IF IsNull( dw_detail.GetText() ) OR dw_detail.GetText() = "" THEN
				dw_detail.SetRedraw( True )
				Return ""
			END IF
			li_retval = dw_detail.GetChild(ls_ref_1, dwchild)
			IF li_retval = -1 THEN
				ls_reference =  dw_detail.GetText()				
			ELSE
				dw_detail.SetColumn( ls_ref_1 )
				li_found = dwchild.Find( "lookup_code = " + dw_detail.GetText(), 1, 100000 )
				IF li_found < 1 THEN // Add by Evan 05.04.2010 --- trap for row number
					ls_reference = dw_detail.GetText()
				ELSEIF dw_detail.Describe( ls_ref_1 + ".dddw.displaycolumn") = "code" THEN
					ls_reference = dwchild.GetItemString( li_found, "code" )
					IF ii_screen_id = 4 THEN					
						if dw_detail.Describe("verifying_agency.ColType") = "!" then //trap for invisible field maha 040403 
						//	of_error_message("VERIFYING_AGENCY",i,"Screen Setup Error"," The verifying_agency field is a required field, and must be visible to enter Licence data.  Please set up in the screen painter.")
							return ""
						else
							ll_address_code = dw_detail.GetItemNumber( ll_current_row, "verifying_agency" )
						end if
					ELSEIF li_screen_id = 19 THEN  //Start Code Change ---- 10.26.2007 #V7 maha
						//do nothing, got the address code further up
					ELSE
						if ls_type1 = "C" then //maha 050802 
							ll_address_code = long(dw_detail.GetItemstring( ll_current_row, ls_ref_1 ))//maha 072501
						elseif ls_type1 = "N" then //maha 050802
							ll_address_code = dw_detail.GetItemNumber( ll_current_row, ls_ref_1 )
						end if
					END IF
				ELSEIF dw_detail.Describe( ls_ref_1 + ".dddw.displaycolumn") = "entity_name" or dw_detail.Describe( ls_ref_1 + ".dddw.displaycolumn") = "entity_name_original" THEN
					if dw_detail.Describe( ls_ref_1 + ".dddw.displaycolumn") = "entity_name_original" THEN
						ls_reference = dwchild.GetItemString( li_found, "entity_name_original" )  //Start Code Change ----03.04.2009 #V92 maha -  changed dw_detail to aloways use the entity name originalf the of containg the code as well, 
					else
						ls_reference = dwchild.GetItemString( li_found, "entity_name_original" )
					end if
					if ls_type1 = "C" then //maha 102501 took out specific exceptions and tested field type
						ll_address_code = long(dw_detail.GetItemstring( ll_current_row, ls_ref_1 ))//maha 072501
					elseif ls_type1 = "N" then //maha 102501
						ll_address_code = dw_detail.GetItemNumber( ll_current_row, ls_ref_1 )
					end if
				ELSEIF dw_detail.Describe( ls_ref_1 + ".dddw.displaycolumn") = "description" THEN //maha 110801
					ls_reference = dwchild.GetItemString( li_found, "description" )
					//Start Code Change ---- 10.10.2007 #V7 maha added same exception for verif ying agency as above
					IF ii_screen_id = 4 THEN					
						if dw_detail.Describe("verifying_agency.ColType") = "!" then //trap for invisible field maha 040403 
							//of_error_message("VERIFYING_AGENCY",i,"Screen Setup Error"," The verifying_agency field is a required field, and must be visible to enter Licence data.  Please set up in the screen painter.")
							return ""
						else
							ll_address_code = dw_detail.GetItemNumber( ll_current_row, "verifying_agency" )
						end if
					ELSEIF li_screen_id = 19 THEN  //Start Code Change ---- 10.26.2007 #V7 maha
						//do nothing, got the address code further up
					ELSE
						if ls_type1 = "C" then //maha 050802 
							ll_address_code = long(dw_detail.GetItemstring( ll_current_row, ls_ref_1 ))//maha 072501
						elseif ls_type1 = "N" then //maha 050802
							ll_address_code = dw_detail.GetItemNumber( ll_current_row, ls_ref_1 )
						end if
					END IF
					//End Code Change---10.10.2007
				ELSE
					ls_reference = dw_detail.GetText()			
				END IF
			END IF
		ELSE
			ls_reference = ""
		END IF
		
		If NOT Isnull(ls_ref_2) THEN
			//get reference 2 data
			if dw_detail.Describe(ls_ref_2 + ".ColType") = "!" or ls_ref_2 = "" then //trap for invisible field maha 012104 
				//messagebox("Problem getting reference 2 value for verification","Required Field " + ls_ref_2 + " is invisible.  The verification will not be created/updated.  Contact Customer support for assistance.")
				return ""
			end if
			li_retval = dw_detail.SetColumn( ls_ref_2 )
			IF li_retval = 1 THEN
				IF IsNull( dw_detail.GetText() ) OR dw_detail.GetText() = "" THEN
					dw_detail.SetRedraw( True )
					//of_error_message(ls_ref_2,i,"Required", "The data field " + ls_ref_2 + " is required.")
					Return ""
				END IF		
				li_retval = dw_detail.GetChild(ls_ref_2, dwchild)
				IF li_retval = -1 THEN
					ls_reference = ls_reference + " - " + dw_detail.GetText()				
				ELSE
					dw_detail.SetColumn( ls_ref_2 )
					li_found = dwchild.Find( "lookup_code = " + dw_detail.GetText(), 1, 100000 )
					if li_found > 0 then //trap added maha 021704
						IF dw_detail.Describe( ls_ref_2 + ".dddw.displaycolumn") = "code" THEN
							ls_reference = ls_reference + " - " + dwchild.GetItemString( li_found, "code" )
						ELSEIF dw_detail.Describe( ls_ref_2 + ".dddw.displaycolumn") = "description" THEN
							ls_reference = ls_reference + " - " + dwchild.GetItemString( li_found, "description" )					
						ELSEIF dw_detail.Describe( ls_ref_2 + ".dddw.displaycolumn") = "entity_name" or dw_detail.Describe( ls_ref_2 + ".dddw.displaycolumn") = "entity_name_original" THEN
							if dw_detail.Describe( ls_ref_2 + ".dddw.displaycolumn") = "entity_name_original" THEN
								ls_reference = ls_reference + " - " + dwchild.GetItemString( li_found, "entity_name_original" )
							else
								ls_reference = ls_reference + " - " + dwchild.GetItemString( li_found, "entity_name" )
							end if
						ELSE
							ls_reference = ls_reference + " - " + dw_detail.GetText()
						END IF
					else
						ls_reference = ls_reference + " - " + ""
					end if
				END IF
			ELSE
				ls_reference = ls_reference + " - " + ""
			END IF
			
			ls_reference = mid(ls_reference,1,100) //maha 022704 4.1.1
		END IF
		return ls_reference

end function

public function integer of_validate_dea (string as_data, string as_name);
//Start Code Change ----02.25.2014 #V14 maha - funtion created for NYH
integer c
integer cl
string s
integer li_sum ,n1 ,n2
integer li_n

cl = len(as_data)

if cl <> 9 then return -1

for c = 1 to cl
	s = mid(as_data, c,1)
	choose case c
		case 1
			if isnumber(s) then return -2
			choose case upper(s)
				case 'A','B','F','G','M','P', 'R'
					//ok
				case else
					return -6
			end choose
		case 2
			if isnumber(s) then return -2
			//if lower(mid(as_name, 1,1)) <> lower(s) then return -4
		case 3,4,5,6,7,8,9
			if not isnumber(s) then return -3
	end choose
next

//checksum
for c = 3 to cl
	li_n = integer(mid(as_data, c,1))
	choose case c
		case 3
			n1 = li_n
		case 4
			n2 = li_n
		case 5
			n1+= li_n
		case 6
			n2+= li_n
		case 7
			n1+= li_n
		case 8
			n2+= li_n
	end choose
next

n2 = 2 * n2

li_sum = n1 + n2

s = right(string(li_sum), 1)

if mid(as_data, 9,1) <> s then return -5

return 1
	

end function

public function integer of_modify_dw_access (long al_prac_id, u_dw adw_detail);//====================================================================
//$<Function>: of_modify_dw_access
//$<Arguments>:
// 	value    long    al_prac_id
// 	value    u_dw    adw_detail
//$<Return>:  integer
//$<Description>: Move the script about access from pfc_cst_nv_data_entry_functions.of_create_dynamic_dw 
//$<Author>: (Appeon) long.zhang 11.17.2014 (00050905 / User With Read Only Permission Can Edit Demographics)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Int li_access,i,res,li_cnt
String ls_dw_field_names,ls_table_name,ls_retval
Datawindowchild dwchild

li_access = w_mdi.of_security_access( 50 ) 
ls_table_name = adw_detail.Object.DataWindow.Table.UpdateTable

//Readonly
If Not ib_screen_painter and li_access = 1 Then
	for li_cnt = 1 to integer(adw_detail.object.datawindow.column.count)
			adw_detail.Modify("#" +string(li_cnt) + ".TabSequence = '0'" )
			adw_detail.Modify("#" +string(li_cnt) + ".border = '2'" )
	next
//Start Code Change ----11.14.2017 #V16 maha
	parent_window.cb_b6.visible = false
else //full access
	if ib_cert_period then
		parent_window.cb_b6.visible = true
	else
		parent_window.cb_b6.visible = false
	end if
//End Code Change ----11.14.2017
End if

//comment by Appeon long.zhang 02.02.2015 (address screen error)
////Start Code Change ---- 01.18.2006 #203 maha
////---------Begin Modified by (Appeon)Stephen 11.19.2013 for  Bug 3755: Billing Address Link field displays a number when set as read-only--------
////IF (ls_table_name = "pd_address" or ls_table_name = "dba.pd_address") and li_access = 2 THEN //alfee 06.01.2009
//boolean lb_bo =false
//for i = 1 to integer(adw_detail.object.datawindow.column.count)
//	ls_dw_field_names = adw_detail.Describe("#"+string(i)+".name")
//	if ls_dw_field_names = "billing_address_id" then
//		lb_bo = true
//		exit
//	end if
//next
//
//IF (ls_table_name = "pd_address" or ls_table_name = "dba.pd_address") and (li_access = 2 or li_access = 1) and lb_bo THEN //alfee 06.01.2009
////---------End Modfiied ------------------------------------------------------
////IF ls_table_name = "pd_address" or ls_table_name = "dba.pd_address" and li_access = 2 THEN //maha 011806   //Start Code Change ----05.26.2009 #V92 maha - access added
//	//adw_detail.Modify("create button(band=detail text='Address Links...' filename=''action='0' border='1' color='128' x='1822' y='110' height='104' width='500' vtextalign='0' htextalign='0'  font.face='Segoe UI' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = linkbutton)")
//	
//	//address drop down
//	//Start Code Change ----02.08.2013 #V12 maha - moved to selection changed event
////	adw_detail.Modify("create button(band=detail text='Find' filename=''action='0' border='1' color='128' x='1822' y='285' height='85' width='200' vtextalign='0' htextalign='0'  font.face='Segoe UI' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = findbutton)")
//	
////	integer set1
////	select set_1
////	into :set1
////	from icred_settings;
////	set1 = of_get_app_setting("set_1","I")
//////Start Code Change ----02.08.2013 #V12 maha - removed support for legacy populate button
////	if set1 = 1 then //maha 072301 create populate button only if using addresses for find
////		adw_detail.Modify("create button(band=detail text='Populate' filename=''action='0' border='1' color='128' x='2010' y='285' height='85' width='280' vtextalign='0' htextalign='0'  font.face='Segoe UI' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = populatebutton)")		
////		adw_detail.Modify( "street.dddw.VscrollBar = Yes")			
////		adw_detail.Modify( "street.dddw.useasborder = Yes")			
////		adw_detail.Modify( "street.dddw.AllowEdit = Yes")			
////		adw_detail.Modify( "street.dddw.NilIsNull= Yes")
////		//adw_detail.Modify( "street.dddw.Lines= 15")
////		adw_detail.Modify( "street.dddw.PercentWidth = '200'")	
////		adw_detail.Modify( "street.dddw.name = 'd_dddw_addresses'")
////		adw_detail.Modify( "street.dddw.datacolumn = 'rec_id'")			
////		adw_detail.Modify( "street.dddw.displaycolumn = 'street'")	
////	end if
//	
//	//add drop down for billing address
//	ls_retval = adw_detail.Modify( "billing_address_id.dddw.VscrollBar = Yes")			
//	adw_detail.Modify( "billing_address_id.dddw.useasborder = Yes")			
//	adw_detail.Modify( "billing_address_id.dddw.NilIsNull= Yes")
//	//adw_detail.Modify( "billing_address_id.dddw.Lines= 15")
//	adw_detail.Modify( "billing_address_id_t.font.underline = '1'")
//	adw_detail.Modify( "billing_address_id.dddw.Required = No")
//	adw_detail.Modify( "billing_address_id.dddw.name = 'd_dddw_billing_addresses'")
//	adw_detail.Modify( "billing_address_id.dddw.datacolumn = 'pd_address_rec_id'")			
//	adw_detail.Modify( "billing_address_id.dddw.displaycolumn = 'address'")								
//	res  = adw_detail.GetChild( "billing_address_id", dwchild )
//	if res = 1 then
//		IF LenA( ls_retval ) = 0 THEN
//			dwchild.SetTransObject( SQLCA )
//			dwchild.Retrieve( al_prac_id )
//		END IF
////		des = dwchild.Describe("DataWindow.Objects")
////			openwithparm(w_sql_msg,des)
//		dwchild.InsertRow( 1 )
//		dwchild.SetItem( 1, "pd_address_street", "N/A" )	
//		dwchild.SetItem( 1, "pd_address_city", "" )
//		dwchild.SetItem( 1, "code_lookup_code", "" )
//		dwchild.SetItem( 1, "pd_address_rec_id", -1 )	
//		dwchild.InsertRow( 1 )
//		dwchild.SetItem( 1, "pd_address_street", "Same" )	
//		dwchild.SetItem( 1, "pd_address_city", "" )
//		dwchild.SetItem( 1, "code_lookup_code", "" )
//		dwchild.SetItem( 1, "pd_address_rec_id", 0 )
//		dwchild.InsertRow( 1 )
//		dwchild.SetItem( 1, "pd_address_street", "" )	
//		dwchild.SetItem( 1, "pd_address_city", "" )
//		dwchild.SetItem( 1, "code_lookup_code", "" )
//	end if
//END IF

Return 0
end function

public function integer of_reset ();//Start Code Change ----07.10.2015 #V15 maha - added called from of_reset_prac in w_prac_data_1
dw_detail.reset()

return 1
end function

public function integer of_set_affil_recid (long al_recid); //Start Code Change ----07.15.2015 #V15 maha - added
il_affil_recid = al_recid
gl_prac_de_appt_id  = al_recid

Return 1
end function

public function integer of_find_address (); //Start Code Change ----07.23.2015 #V15 maha - migrated from dw_detail. buttonclicked from which it is called
 // also added for updates - to set fields based on the location update default settings.
	
long ll_addr[ ]
Integer li_cr
Integer a
Integer li_address_cnt
int li_retval
integer res  //maha 06.21.2017
integer li_check //maha 06.21.2017
string ls_phone
gs_pass_ids ids
datawindowchild dwchild
	
		
Open(w_practice_to_addr_find_new) 
		
ids = Message.PowerObjectParm
			
IF ids.l_ids[1] = 0 THEN
	Return 0
END IF
			
ll_addr[] = ids.l_ids[]
			
li_address_cnt = UpperBound( ids.l_ids[] )
			
			
dw_addresses.dataobject = "d_group_data_entry_for_pt"
dw_addresses.SetTransObject( SQLCA )
		
if upperbound(ll_addr)>0 then
	dw_addresses.Retrieve( ll_addr )
end if

if gi_temp_switch = 1 then //set if update or add
	ib_addaddress = false
else
	ib_addaddress = True
end if

//get the location defaults
if dw_loc_defaults.rowcount() = 0 then dw_loc_defaults.retrieve()
	
//For each location			
FOR a = 1 TO li_address_cnt
	 //Start Code Change ----05.03.2017 #V153 maha - error trapping for ColumbiaDocs - prevent adding location already existing
	 if ib_addaddress then
		//Start Code Change ----06.21.2017 #V154 maha - added message option
		debugbreak()
		li_check = of_get_app_setting("set_92","I")
		//messagebox("check",li_check)
		if li_check = 2 then
			//skip message
		else
			if of_addr_check_link_to_loc( 0, ll_addr[a]) > 0 then
				choose case li_check
					case 0
						messagebox("DE Error", "One of the Practice Locations selected already has an address record connected to it.  It will not be added.")
						res = 2
					case 1
						res = messagebox("Duplicate Practice", "One of the Practice Locations selected already has an address record connected to it.  Do you want to add the Duplicate?", question!, yesno!, 2)
				end choose
				if res = 2 then continue
			end if
			//End Code Change ----06.21.2017
		end if
	end if
	//End Code Change ----05.03.2017
	
	dw_addresses.setfilter('rec_id = '+ string ( ll_addr[a] ))
	dw_addresses.filter( )

	if gi_temp_switch = 0 then //maha 083004 for adds
		IF a = 1 AND dw_detail.GetItemStatus( dw_detail.GetRow(), 0, Primary! ) = NewModifIed! OR dw_detail.GetItemStatus( dw_detail.GetRow(), 0, Primary! ) = New! THEN
			dw_detail.DeleteRow( dw_detail.GetRow( ) )
		END IF
		dw_detail.triggerevent("pfc_addrow")  //readd row
		li_cr = dw_detail.rowcount()
	else //maha 083004 to allow updating a record again
		li_cr = dw_detail.getRow()
	end if

//set address values
	if ib_addaddress or dw_loc_defaults.getitemnumber(1,"addr_contacts") = 1 then
		if dw_detail.Describe("gp_id.ColType") <> "!" then
			dw_detail.setitem( li_cr,"gp_id", ll_addr[a] )
		end if
		if dw_detail.Describe("street.ColType") <> "!" then
			dw_detail.setitem( li_cr,"street",dw_addresses.getitemstring( 1,"street"))
		end if
	
		if dw_detail.Describe("street_2.ColType") <> "!" then			
			dw_detail.setitem( li_cr,"street_2",dw_addresses.getitemstring( 1,"street_2"))
		end if
				
		if dw_detail.Describe("alias_name.ColType") <> "!" then  //Start Code Change ----04.25.2014 #V14.2 maha
			dw_detail.setitem( li_cr,"alias_name",dw_addresses.getitemstring( 1,"alias_name"))  //Start Code Change ----10.19.2016 #V152 maha - corrected from street
		end if
				
		if dw_detail.Describe("city.ColType") <> "!" then
			dw_detail.setitem( li_cr,"city",dw_addresses.getitemstring( 1,"city"))
		end if
		if dw_detail.Describe("state.ColType") <> "!" then
			dw_detail.setitem( li_cr,"state",dw_addresses.getitemnumber( 1,"state") )
		end if
		if dw_detail.Describe("zip.ColType") <> "!" then
			dw_detail.setitem( li_cr,"zip",dw_addresses.getitemstring( 1,"zip"))
		end if
		if dw_detail.Describe("county.ColType") <> "!" then
			dw_detail.setitem( li_cr,"county",dw_addresses.getitemnumber( 1,"county"))
		end if
		if dw_detail.Describe("country.ColType") <> "!" then
			dw_detail.setitem( li_cr,"country",dw_addresses.getitemnumber( 1,"country"))
		end if
		if dw_detail.Describe("suite_apart.ColType") <> "!" then
			dw_detail.setitem( li_cr,"suite_apart",dw_addresses.getitemstring( 1,"suite_apart"))
		end if
		
		if dw_detail.Describe("web_address.ColType") <> "!" then
			dw_detail.setitem( li_cr,"web_address",dw_addresses.getitemstring( 1,"web_address"))
		end if
		
		if dw_detail.Describe("tax_id.ColType") <> "!" then
			dw_detail.setitem( li_cr,"tax_id",dw_addresses.getitemstring( 1,"tax_id"))
		end if
	end if
	
	//Active status 
	 //Start Code Change ----07.23.2015 #V15 maha - added setting this field
	if ib_addaddress or dw_loc_defaults.getitemnumber(1,"active_status") = 1 then
		if dw_detail.Describe("active_status.ColType") <> "!" then
			//------------------- APPEON BEGIN -------------------
			//<$>added:long.zhang 12.28.2015
			//<$>reason:datatype doen't match and raise error in web version. BugL122802.
			//dw_detail.setitem( li_cr,"active_status",dw_addresses.getitemstring( 1,"active_status"))
			dw_detail.SetItem( li_cr,"active_status",dw_addresses.GetItemNumber( 1,"active_status"))
			//------------------- APPEON END -------------------
		end if
	end if
	
	//phone and extension
	if ib_addaddress or dw_loc_defaults.getitemnumber(1,"o_phone") = 1 then
		if dw_detail.Describe("phone.ColType") <> "!" then			
			ls_phone = dw_addresses.getitemstring( 1,"phone") 
			if dw_detail.Describe("phone.EditMask.Mask") = "(###)###-####" then //Start Code Change ----02.02.2009 #V92 maha - added if statement
				ls_phone =  of_strip_char("", ls_phone, "@NUM@")  //Start Code Change ----06.10.2008 #V81 maha - strip format characters
			end if
			dw_detail.setitem( li_cr,"phone",ls_phone)
		end if
	
		if dw_detail.Describe("ext.ColType") <> "!" then  //Start Code Change ----08.12.2011 #V11 maha -  added extension field
			dw_detail.setitem( li_cr,"ext",dw_addresses.getitemstring( 1,"ext"))
		end if
	end if
	
	//fax
	if ib_addaddress or dw_loc_defaults.getitemnumber(1,"o_fax") = 1 then
		if dw_detail.Describe("fax.ColType") <> "!" then
			//Start Code Change ----02.02.2009 #V92 maha - added trap for formatted field
			ls_phone = dw_addresses.getitemstring( 1,"fax") 
			if dw_detail.Describe("fax.EditMask.Mask") = "(###)###-####" then
				ls_phone =  of_strip_char("", ls_phone, "@NUM@")
			end if
			dw_detail.setitem( li_cr,"fax",ls_phone)
		end if
	end if
	
	//email
	if ib_addaddress or dw_loc_defaults.getitemnumber(1,"o_email") = 1 then
		if dw_detail.Describe("e_mail_address.ColType") <> "!" then
			dw_detail.setitem( li_cr,"e_mail_address",dw_addresses.getitemstring( 1,"e_mail_address"))
		end if
	end if
	
	//contact person
	if  ib_addaddress or dw_loc_defaults.getitemnumber(1,"o_contact") = 1 then
		if dw_detail.Describe("contact_person.ColType") <> "!" then
			dw_detail.setitem( li_cr,"contact_person",dw_addresses.getitemstring( 1,"contact_person"))
		end if
	end if
	
	//business mamager
	if  ib_addaddress or dw_loc_defaults.getitemnumber(1,"o_bus_man") = 1 then
		if dw_detail.Describe("business_mgr.ColType") <> "!" then
			dw_detail.setitem( li_cr,"business_mgr",dw_addresses.getitemstring( 1,"business_mgr"))
		end if
	end if
	
	//office manager
	if  ib_addaddress or dw_loc_defaults.getitemnumber(1,"o_off_man") = 1 then
		if dw_detail.Describe("office_mgr.ColType") <> "!" then
			dw_detail.setitem( li_cr,"office_mgr",dw_addresses.getitemstring( 1,"office_mgr"))
		end if
	end if
	
	// other tax ids	
	if  ib_addaddress or dw_loc_defaults.getitemnumber(1,"o_ids") = 1 then
		if dw_detail.Describe("tax_id_other_1.ColType") <> "!" then
			dw_detail.setitem( li_cr,"tax_id_other_1",dw_addresses.getitemstring( 1,"tax_id_other_1"))
		end if
		if dw_detail.Describe("tax_id_other_2.ColType") <> "!" then
			dw_detail.setitem( li_cr,"tax_id_other_2",dw_addresses.getitemstring( 1,"tax_id_other_2"))
		end if
	end if
	
	//wait times
	if  ib_addaddress or dw_loc_defaults.getitemnumber(1,"wait_times") = 1 then
		if dw_detail.Describe("routine_visit_appt.ColType") <> "!" then
			dw_detail.setitem( li_cr,"routine_visit_appt",dw_addresses.getitemstring( 1,"routine_visit_appt"))
		end if
		if dw_detail.Describe("urgent_visit_appt.ColType") <> "!" then
			dw_detail.setitem( li_cr,"urgent_visit_appt",dw_addresses.getitemstring( 1,"urgent_visit_appt"))
		end if
		if dw_detail.Describe("emergency_visit_appt.ColType") <> "!" then
			dw_detail.setitem( li_cr,"emergency_visit_appt",dw_addresses.getitemstring( 1,"emergency_visit_appt"))
		end if
	end if
	
	//access data
	if  ib_addaddress or dw_loc_defaults.getitemnumber(1,"access_info") = 1 then	
		if dw_detail.Describe("handicapped_access.ColType") <> "!" then
			dw_detail.setitem( li_cr,"handicapped_access",dw_addresses.getitemnumber( 1,"handicapped_access"))
		end if
			if dw_detail.Describe("public_transportation.ColType") <> "!" then
			dw_detail.setitem( li_cr,"public_transportation",dw_addresses.getitemnumber( 1,"public_transportation"))
		end if
		if dw_detail.Describe("non_emergency_appt.ColType") <> "!" then
			dw_detail.setitem( li_cr,"non_emergency_appt",dw_addresses.getitemstring( 1,"non_emergency_appt"))
		end if
	end if
	
	//hours
	if  ib_addaddress or dw_loc_defaults.getitemnumber(1,"pract_hours") = 1 then
		if dw_detail.Describe("mon_from.ColType") <> "!" then
			dw_detail.setitem( li_cr,"mon_from",dw_addresses.getitemstring( 1,"mon_from"))
		end if
		if dw_detail.Describe("mon_to.ColType") <> "!" then
			dw_detail.setitem( li_cr,"mon_to",dw_addresses.getitemstring( 1,"mon_to"))
		end if
		if dw_detail.Describe("tue_from.ColType") <> "!" then
			dw_detail.setitem( li_cr,"tue_from",dw_addresses.getitemstring( 1,"tue_from"))
		end if
		if dw_detail.Describe("tue_to.ColType") <> "!" then
			dw_detail.setitem( li_cr,"tue_to",dw_addresses.getitemstring( 1,"tue_to"))
		end if
		if dw_detail.Describe("wed_from.ColType") <> "!" then
			dw_detail.setitem( li_cr,"wed_from",dw_addresses.getitemstring( 1,"wed_from"))
		end if
		if dw_detail.Describe("wed_to.ColType") <> "!" then
			dw_detail.setitem( li_cr,"wed_to",dw_addresses.getitemstring( 1,"wed_to"))
		end if
		if dw_detail.Describe("thu_from.ColType") <> "!" then
		dw_detail.setitem( li_cr,"thu_from",dw_addresses.getitemstring( 1,"thu_from"))
			end if
		if dw_detail.Describe("thu_to.ColType") <> "!" then
			dw_detail.setitem( li_cr,"thu_to",dw_addresses.getitemstring( 1,"thu_to"))
		end if
		if dw_detail.Describe("fri_from.ColType") <> "!" then
			dw_detail.setitem( li_cr,"fri_from",dw_addresses.getitemstring( 1,"fri_from"))
		end if
		if dw_detail.Describe("fri_to.ColType") <> "!" then
			dw_detail.setitem( li_cr,"fri_to",dw_addresses.getitemstring( 1,"fri_to"))
		end if
		if dw_detail.Describe("sat_from.ColType") <> "!" then
			dw_detail.setitem( li_cr,"sat_from",dw_addresses.getitemstring( 1,"sat_from"))
		end if
		if dw_detail.Describe("sat_to.ColType") <> "!" then
			dw_detail.setitem( li_cr,"sat_to",dw_addresses.getitemstring( 1,"sat_to"))
		end if
		if dw_detail.Describe("sun_from.ColType") <> "!" then
			dw_detail.setitem( li_cr,"sun_from",dw_addresses.getitemstring( 1,"sun_from"))
		end if
		if dw_detail.Describe("sun_to.ColType") <> "!" then
			dw_detail.setitem( li_cr,"sun_to",dw_addresses.getitemstring( 1,"sun_to"))
		end if
		if dw_detail.Describe("mon_from2.ColType") <> "!" then
			dw_detail.setitem( li_cr,"mon_from2",dw_addresses.getitemstring( 1,"mon_from2"))
		end if
		if dw_detail.Describe("mon_to2.ColType") <> "!" then
			dw_detail.setitem( li_cr,"mon_to2",dw_addresses.getitemstring( 1,"mon_to2"))
		end if
		if dw_detail.Describe("tue_from2.ColType") <> "!" then
			dw_detail.setitem( li_cr,"tue_from2",dw_addresses.getitemstring( 1,"tue_from2"))
		end if
		if dw_detail.Describe("tue_to2.ColType") <> "!" then
			dw_detail.setitem( li_cr,"tue_to2",dw_addresses.getitemstring( 1,"tue_to2"))
		end if
		if dw_detail.Describe("wed_from2.ColType") <> "!" then
			dw_detail.setitem( li_cr,"wed_from2",dw_addresses.getitemstring( 1,"wed_from2"))
		end if
		if dw_detail.Describe("wed_to2.ColType") <> "!" then
			dw_detail.setitem( li_cr,"wed_to2",dw_addresses.getitemstring( 1,"wed_to2"))
		end if
		if dw_detail.Describe("thu_from2.ColType") <> "!" then
			dw_detail.setitem( li_cr,"thu_from2",dw_addresses.getitemstring( 1,"thu_from2"))
		end if
		if dw_detail.Describe("thu_to2.ColType") <> "!" then
			dw_detail.setitem( li_cr,"thu_to2",dw_addresses.getitemstring( 1,"thu_to2"))
		end if
		if dw_detail.Describe("fri_from2.ColType") <> "!" then
			dw_detail.setitem( li_cr,"fri_from2",dw_addresses.getitemstring( 1,"fri_from2"))
		end if
		if dw_detail.Describe("fri_to2.ColType") <> "!" then
			dw_detail.setitem( li_cr,"fri_to2",dw_addresses.getitemstring( 1,"fri_to2"))
		end if
		if dw_detail.Describe("sat_from2.ColType") <> "!" then
			dw_detail.setitem( li_cr,"sat_from2",dw_addresses.getitemstring( 1,"sat_from2"))
		end if
		if dw_detail.Describe("sat_to2.ColType") <> "!" then
			dw_detail.setitem( li_cr,"sat_to2",dw_addresses.getitemstring( 1,"sat_to2"))
		end if
		if dw_detail.Describe("sun_from2.ColType") <> "!" then
			dw_detail.setitem( li_cr,"sun_from2",dw_addresses.getitemstring( 1,"sun_from2"))
		end if
		if dw_detail.Describe("sun_to2.ColType") <> "!" then
			dw_detail.setitem( li_cr,"sun_to2",dw_addresses.getitemstring( 1,"sun_to2"))
		end if
	end if  //hours
		
	//custom block 1	
	if  ib_addaddress or dw_loc_defaults.getitemnumber(1,"cust_g1") = 1 then
		if dw_detail.Describe("cust_1.ColType") <> "!" then
			dw_detail.setitem( li_cr,"cust_1",dw_addresses.getitemstring( 1,"cust_1"))
		end if
		if dw_detail.Describe("cust_2.ColType") <> "!" then
			dw_detail.setitem( li_cr,"cust_2",dw_addresses.getitemstring( 1,"cust_2"))
		end if
		if dw_detail.Describe("cust_3.ColType") <> "!" then
			dw_detail.setitem( li_cr,"cust_3",dw_addresses.getitemstring( 1,"cust_3"))
		end if
		if dw_detail.Describe("cust_4.ColType") <> "!" then
			dw_detail.setitem( li_cr,"cust_4",dw_addresses.getitemstring( 1,"cust_4"))
		end if
		if dw_detail.Describe("cust_5.ColType") <> "!" then
			dw_detail.setitem( li_cr,"cust_5",dw_addresses.getitemstring( 1,"cust_5"))
		end if
	end if
	
	//custom block 2
	if  ib_addaddress or dw_loc_defaults.getitemnumber(1,"cust_g2") = 1 then
		if dw_detail.Describe("cust_6.ColType") <> "!" then
			dw_detail.setitem( li_cr,"cust_6",dw_addresses.getitemstring( 1,"cust_6"))
		end if		
		if dw_detail.Describe("cust_7.ColType") <> "!" then
			dw_detail.setitem( li_cr,"cust_7",dw_addresses.getitemstring( 1,"cust_7"))
		end if
		if dw_detail.Describe("cust_8.ColType") <> "!" then
			dw_detail.setitem( li_cr,"cust_8",dw_addresses.getitemstring( 1,"cust_8"))
		end if
		if dw_detail.Describe("cust_9.ColType") <> "!" then
			dw_detail.setitem( li_cr,"cust_9",dw_addresses.getitemstring( 1,"cust_9"))
		end if
		if dw_detail.Describe("cust_10.ColType") <> "!" then
			dw_detail.setitem( li_cr,"cust_10",dw_addresses.getitemstring( 1,"cust_10"))
		end if
	end if
	
	//cust dates
	if  ib_addaddress or dw_loc_defaults.getitemnumber(1,"cust_dates") = 1 then
		if dw_detail.Describe("cust_d1.ColType") <> "!" then
			dw_detail.setitem( li_cr,"cust_d1",dw_addresses.getItemDatetime( 1,"cust_d1"))
		end if
		if dw_detail.Describe("cust_d2.ColType") <> "!" then
			dw_detail.setitem( li_cr,"cust_d2",dw_addresses.getItemDatetime( 1,"cust_d2"))
		end if
	end if
	
	//set screen defaults
	inv_data_entry.of_set_defaults( dw_detail, dw_detail.RowCount() )//Start Code Change ----07.13.2012 #V12 maha - removed; overwriting needed values //Start Code Change ----09.11.2012 #V12 maha - readded after modification the the default set function.
			
END FOR	


ib_addaddress = false
		
dw_link_list.retrieve(il_addr_id)
		

li_retval = parent_window.Event Pfc_Save( )
IF li_retval < 0 THEN
	dw_detail.PostEvent( "pfc_cst_after_error" )
END IF
		
if gi_temp_switch = 0 then //maha 083004 when adding	
	IF li_address_cnt > 0 THEN
		dw_browse.scrolltorow(dw_browse.rowcount()) //maha 012704
		dw_browse.setrow(dw_browse.rowcount())
//		dw_browse.selectrow(0,false)  //Start Code Change ----01.20.2016 #V15 maha - removed
//		dw_browse.selectrow(dw_browse.rowcount(),true)
		if li_address_cnt > 1 THEN
			MessageBox("Reminder", "Go to each Address record and set up the Address Link data." )
		end if
	END IF
						
	dw_link_list.Retrieve( dw_detail.GetItemNumber( dw_detail.GetRow( ), "rec_id")  )
else //when updating
	gi_temp_switch = 0
		
end if


 
 
 return 1
end function

public subroutine of_refresh_screen ();//====================================================================
//$<Function>: of_refresh_screen
//$<Arguments>:
//$<Return>:  (None)
//$<Description>: Refresh last screen.
//$<Author>: (Appeon) long.zhang 11.23.2015 (Bug id #4853 -Show Save Approval on Demographics tab Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

//Only take effect when changing selectedtab.
If parent_window.tab_1.selectedtab <> 2 Then
	dw_select_section.event rowfocuschanged(il_last_row)
End If

Return	
end subroutine

public function integer of_post_resize ();//Start Code Change ----02.18.2016 #V15 maha - added
long ll_w

dw_browse.width = tab_view.width - 24
dw_detail.width = tab_view.width - 24
dw_link_list.width = tab_view.width - 24

r_1.height = dw_select_section.height - 100
dw_link_list.y =  tab_view.height - tab_view.y - dw_link_list.height + 10

if dw_link_list.visible then
	dw_detail.height =  r_1.height - dw_link_list.height - 28
	dw_browse.height =  r_1.height - dw_link_list.height - 28
else 
	dw_detail.height =  r_1.height - 16
	dw_browse.height =  r_1.height - 16
end if

//linked data tab
tab_view.tabpage_linked_data.uo_linked_data.width = tab_view.width - 24
tab_view.tabpage_linked_data.uo_linked_data.height =  tab_view.height - 24

//Start Code Change ----07.20.2017 #V154 maha
tab_view.tabpage_linked_data.uo_linked_data.width = tab_view.width - 24
tab_view.tabpage_linked_data.uo_linked_data.height =  tab_view.height - 24
//Start Code Change ----07.20.2

ll_w =  tab_view.tabpage_linked_data.uo_linked_data.width - 48
tab_view.tabpage_linked_data.uo_linked_data.dw_addr_head.width = ll_w
tab_view.tabpage_linked_data.uo_linked_data.dw_privs.width = ll_w
tab_view.tabpage_linked_data.uo_linked_data.st_privs.width = ll_w
tab_view.tabpage_linked_data.uo_linked_data.dw_specs.width = ll_w/6 * 2 - 8
tab_view.tabpage_linked_data.uo_linked_data.dw_ids.width = ll_w/6 * 4
tab_view.tabpage_linked_data.uo_linked_data.st_specs.width =  ll_w/6 * 2 - 8
tab_view.tabpage_linked_data.uo_linked_data.st_ids.width = ll_w/6 * 4

tab_view.tabpage_linked_data.uo_linked_data.dw_ids.x = tab_view.tabpage_linked_data.uo_linked_data.dw_specs.width + 8
tab_view.tabpage_linked_data.uo_linked_data.st_ids.x = tab_view.tabpage_linked_data.uo_linked_data.dw_ids.x

tab_view.tabpage_linked_data.uo_linked_data.dw_privs.height = tab_view.tabpage_linked_data.uo_linked_data.height - tab_view.tabpage_linked_data.uo_linked_data.dw_privs.y - 24



return 1
end function

public function integer of_address_link_clear (long al_id);//Start Code Change ----08.08.2016 #V152 maha - added to clear link components when set to inactive
integer r

//dw_link_list.setredraw( false)
//dw_link_list.setfilter("")
//dw_link_list.filter()

update pd_address_link set mailing = 0, exp_letters = 0, include_in_directory = 0 where address_id = :al_id;
//dw_link_list.setredraw( true)

return 1
end function

public function integer of_appl_action_inactive (long al_gp_id, ref long al_prac);integer li_set
integer res

li_set = of_get_app_setting("set_89","I")  //0 = do not process; 1 = ask message; 2 = process no message
if isnull(li_set) or li_set = 0 then return 1

if li_set = 1 then
	res = messagebox("Inactive address","The address being made inactive has Application Tracking Actions connected to it.  Do you wish to make these Tracking Actions Inactive as well?", question!, yesno!, 2)
	if res = 2 then return 1
	of_appl_action_inactive( al_gp_id, al_prac)
end if


//
////Start Code Change ----10.17.2016 #V152 maha
//datastore lds_track
//datastore lds_actions
//integer rc
//integer r
//integer li_set
//integer res
//string ls_mes
//
//l
//
//if isnull(li_set) or li_set = 0 then
//	return 1
//else
//	lds_track = create datastore
//	lds_track.dataobject = "d_pd_appl_tracking_4_audit"
//	lds_track.settransobject(sqlca)
//	lds_actions = create datastore
//	lds_actions.dataobject = "d_net_dev_action_items_4_audit"
//	lds_actions.settransobject(sqlca)
//	
//	rc = lds_actions.retrieve( al_gp_id, al_prac)
//	lds_track.retrieve(al_gp_id, al_prac)
//	if rc = 0 then return 1
//	
//	if li_set = 1 then
//		res = messagebox("Inactive address","The address being made inactive has " + string(rc) + " Application Tracking Actions connected to it.  Do you wish to make these Tracking Actions Inactive as well?", question!, yesno!, 2)
//	else //set to 2
//		res = 1
//	end if
//	
//	if res = 1 then
//		for r = 1 to rc
//			lds_actions.setitem(r, "active_status", 0)
//		next
//		for r = 1 to lds_track.rowcount()
//			lds_track.setitem(r, "active_status", 0)
//		next
//		
//		inv_data_entry.of_field_audit( lds_actions , ls_mes)
//		inv_data_entry.of_field_audit( lds_track , ls_mes)
//		
//		lds_actions.update()
//		lds_track.update()
//	end if
//	
//end if

return 1
end function

public function integer of_entity_update (long al_id);//Start Code Change ----11.28.2016 #V153 maha - added for entity update
integer ll_cnt
nv_entity_functions lnv_ent

choose case  ii_screen_id
	case 1
		select count(entity_id) into :ll_cnt from entity_lookup where prac_id = :al_id;
	case 2
		select count(entity_id) into :ll_cnt from entity_lookup where addr_id = :al_id;
end choose

if ll_cnt > 0 then
	lnv_ent = create nv_entity_functions
	choose case  ii_screen_id
		case 1
			lnv_ent.of_update_entity_links(dw_detail,"P",al_id)
		case 2
			lnv_ent.of_update_entity_links(dw_detail,"A",al_id)
	end choose
	
	destroy lnv_ent
end if

return 1
end function

public function integer of_addr_check_link_to_loc (integer ai_row, long al_loc);//Start Code Change ----5.03.2017 #V153 maha - user error trap 
//checking to see if there are more than 1 address records connected to the location
integer r
integer  cnt = 0
 
 for r = 1 to dw_browse.rowcount()
	if r <> ai_row then
		//if dw_browse.getitemnumber(r, "gp_id")  = al_loc and dw_browse.getitemnumber(r, "active_status") <> 1 then cnt++
		if dw_browse.getitemnumber(r, "gp_id")  = al_loc and dw_browse.getitemnumber(r, "active_status") = 1 then cnt++ //modifed by Appeon long.zhang 05.04.2017 (Bug IDs #5627 & #5628: Net Dev issues with multiple Address records linked to the same Practice Location ID)
	end if
next

return cnt

end function

public subroutine of_zoom ();//Start Code Change ----07.13.2017 #V154 maha
//---------Begin Modified by (Appeon)Gavin 10.30.2017 for V15 ISG-CLX--------RE: Alpha Testing Bug # 5851 - Data Zoom-> Provider: Data screens are not zoomed
long	ll_Zoom

if gi_zoom = 0 Then gi_zoom = 100  

ll_Zoom = long( dw_browse.Describe("Datawindow.zoom") )
If ll_Zoom <> gi_zoom Then dw_browse.Modify("DataWindow.Zoom=" + string(gi_zoom))  
ll_Zoom = long( dw_detail.Describe("Datawindow.zoom") )
If ll_Zoom <> gi_zoom Then dw_detail.Modify("DataWindow.Zoom=" + string(gi_zoom))
ll_Zoom = long( dw_select_section.Describe("Datawindow.zoom") )
If ll_Zoom <> gi_zoom Then dw_select_section.Modify("DataWindow.Zoom=" + string(gi_zoom))
ll_Zoom = long( dw_link_list.Describe("Datawindow.zoom") )
If ll_Zoom <> gi_zoom Then dw_link_list.Modify("DataWindow.Zoom=" + string(gi_zoom))
ll_Zoom = long( tab_view.tabpage_linked_data.uo_linked_data.dw_addr_head.Describe("Datawindow.zoom") )
If ll_Zoom <> gi_zoom Then tab_view.tabpage_linked_data.uo_linked_data.dw_addr_head.Modify("DataWindow.Zoom=" + string(gi_zoom))
ll_Zoom = long( tab_view.tabpage_linked_data.uo_linked_data.dw_ids.Describe("Datawindow.zoom") )
If ll_Zoom <> gi_zoom Then tab_view.tabpage_linked_data.uo_linked_data.dw_ids.Modify("DataWindow.Zoom=" + string(gi_zoom))
ll_Zoom = long( tab_view.tabpage_linked_data.uo_linked_data.dw_privs.Describe("Datawindow.zoom") )
If ll_Zoom <> gi_zoom Then tab_view.tabpage_linked_data.uo_linked_data.dw_privs.Modify("DataWindow.Zoom=" + string(gi_zoom))
ll_Zoom = long( tab_view.tabpage_linked_data.uo_linked_data.dw_specs.Describe("Datawindow.zoom") )
If ll_Zoom <> gi_zoom Then tab_view.tabpage_linked_data.uo_linked_data.dw_specs.Modify("DataWindow.Zoom=" + string(gi_zoom))
//---------End Modfiied ------------------------------------------------------
end subroutine

public function integer of_add_cert_period (integer ai_screen, long al_recid, integer al_row, boolean ab_mess);//Start Code Change ----11.01.2017 #V16 maha - created for Certification Period creation
//of_add_cert_period(ii_screen_id, il_rec_id, r, s)  

long li_entity
long li_rec
long ll_de_recid
integer r
integer rc
integer nr
integer li_mdays
integer li_row
string v
string ls_name
string ls_reference
string ls_set_field
datetime ld_set
n_ds dw_detail2
//for the record get the entity lookup code
//define field
debugbreak()
choose case ai_screen
	case 4, 5, 19, 15, 19
		if ai_screen = 5 then
			ls_set_field = "dea_entity"
		elseif ai_screen = 4 then
			ls_set_field = "verifying_agency"
		elseif ai_screen = 10 then
			ls_set_field = "hospital_code"
		elseif ai_screen = 15 then
			ls_set_field = "carrier_code"
		elseif ai_screen = 19 then
			ls_set_field = "board_code"
		end if
	case else
		messagebox("Create Certification Period","This data screen currently support Certification Periods.")
		return 0
end choose

li_row = dw_detail.getrow()

if dw_detail.Describe( ls_set_field + ".ColType") <> "!" then
	li_entity = dw_detail.getitemnumber( li_row, ls_set_field)
else
	messagebox( "Cert Period Add","The data screen does not have the " + ls_set_field +  " visible. " )
end if

//get cert data from lookup
v = gnv_data.of_getitem("address_lookup" ,'period_track', "lookup_code = " + string(li_entity))
ls_name = gnv_data.of_getitem("address_lookup" ,'entity_name', "lookup_code = " + string(li_entity))
li_mdays = integer(gnv_data.of_getitem("address_lookup" ,'monitor_days', "lookup_code = " + string(li_entity)))

li_mdays = 0 - li_mdays


//get reference_value if exists
if dw_detail.Describe("reference_value.ColType") <> "!" then
	ls_reference = dw_detail.getitemstring(li_row,"reference_value")
else
	ls_reference = of_get_reference( )
end if

ll_de_recid = dw_detail.getitemnumber(li_row ,"rec_id")

//trap for inactive records
  
//check if cert tracking on for this entity  
if v = "Y" then
	//continue with code
else
	if ab_mess then messagebox("Add certification period","Certification is not Set for Entity:" + ls_name )
	return -1
end if

dw_detail2 = create n_ds
dw_detail2.dataobject = "d_pd_cert_periods_for_add"
dw_detail2.settransobject(sqlca)



nr = dw_detail2.insertrow(0)
dw_detail2.setitem(nr, "data_rec_id", ll_de_recid)
dw_detail2.setitem(nr, "prac_id", il_prac_id )
dw_detail2.setitem(nr, "screen_id", ii_screen_id)
dw_detail2.setitem(nr, "reference_value", ls_reference)
dw_detail2.setitem(nr, "active_status", 1)

//start date
choose case ai_screen
	case 19  //board
		ls_set_field = "last_cert_date"
	case 5 //dea
		ls_set_field = "prev_exp_date"
	case 4 //license
		ls_set_field = "previous_expiration_date"
	case 10 //hospital
		ls_set_field = "start_date"
	case 15   //insurance
		ls_set_field = "coverage_from"
end choose

if dw_detail.Describe( ls_set_field + ".ColType") <> "!" then
	ld_set = dw_detail.getitemdatetime(al_row, ls_set_field )
	dw_detail2.setitem(nr, "start_date", ld_set)
end if
	

//end date
choose case ai_screen
	case 19 //board
		ls_set_field = "expiration_date"
	case 5 //dea
		ls_set_field = "expiration_date"
	case 4 //license
		ls_set_field = "expiration_date"
	case 10 //hospital
		ls_set_field = "end_date"
	case 15   //insurance
		ls_set_field = "coverage_to"
end choose

if dw_detail.Describe( ls_set_field + ".ColType") <> "!" then
	ld_set = dw_detail.getitemdatetime(li_row, ls_set_field)
	dw_detail2.setitem(nr, "end_date", ld_set)
end if

// monitor date
ld_set = datetime(relativedate(date(ld_set), li_mdays), time("00:00:00"))
dw_detail2.setitem(nr, "monitor_date", ld_set)


//CMES

li_rec = gnv_app.of_get_id("RECORD_ID")
dw_detail2.setitem(nr, "rec_id", li_rec )

dw_detail2.update()

 //verifications
 
// audit



destroy dw_detail2

tab_view.tabpage_image.dw_detail_2.retrieve()



return 1
end function

public function integer of_filter_cert_period (long al_screen, long al_recid);//Start Code Change ----11.13.2017 #V16 maha - added; called from selected changed
string s
integer r

//s = "screen_id = " + string(al_screen) + " and data_rec_id = " + string(al_recid
s = "data_rec_id = " + string(al_recid)
//messagebox("Filter Certification failed", "data_rec_id = " + string(al_recid))

r = tab_view.tabpage_image.dw_detail_2.setfilter(s)
if r < 0 then messagebox("Filter Certification failed",s)

tab_view.tabpage_image.dw_detail_2.filter()

return 1
end function

on pfc_cst_u_data_entry.create
this.cb_decheck=create cb_decheck
this.st_dw_select_section_border=create st_dw_select_section_border
this.cb_view_relation=create cb_view_relation
this.st_select=create st_select
this.dw_addresses=create dw_addresses
this.st_recs=create st_recs
this.dw_ver_data=create dw_ver_data
this.dw_select_section=create dw_select_section
this.dw_loc_defaults=create dw_loc_defaults
this.r_1=create r_1
this.dw_link_list=create dw_link_list
this.dw_detail=create dw_detail
this.dw_browse=create dw_browse
this.tab_view=create tab_view
this.Control[]={this.cb_decheck,&
this.st_dw_select_section_border,&
this.cb_view_relation,&
this.st_select,&
this.dw_addresses,&
this.st_recs,&
this.dw_ver_data,&
this.dw_select_section,&
this.dw_loc_defaults,&
this.r_1,&
this.dw_link_list,&
this.dw_detail,&
this.dw_browse,&
this.tab_view}
end on

on pfc_cst_u_data_entry.destroy
destroy(this.cb_decheck)
destroy(this.st_dw_select_section_border)
destroy(this.cb_view_relation)
destroy(this.st_select)
destroy(this.dw_addresses)
destroy(this.st_recs)
destroy(this.dw_ver_data)
destroy(this.dw_select_section)
destroy(this.dw_loc_defaults)
destroy(this.r_1)
destroy(this.dw_link_list)
destroy(this.dw_detail)
destroy(this.dw_browse)
destroy(this.tab_view)
end on

event constructor;
if parent.classname() = "w_prac_report_design" then ib_report = True

inv_data_entry = CREATE pfc_cst_nv_data_entry_functions
inv_data_entry.ib_report = ib_report
inv_data_entry.of_setup_cache()

inv_data_entry.of_refresh_cache()

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.12.2006 By: Jack (Inova)
//$<reason> Queue Images for Scanning from Data Entry.
ids_image_data = create datastore
ids_image_data.dataobject = 'd_image_scan_detail_inova'
ids_image_data.settransobject(sqlca)
//---------------------------- APPEON END ----------------------------

//------------------- APPEON BEGIN -------------------
//$<add> Stephen 03.23.2011
//$<reason> No Green Check marks 
ids_tablename = create datastore
IF gs_DBType = 'SQL' THEN
	ids_tablename.dataobject = 'd_sql_tablename'	
ELSE
	ids_tablename.dataobject = 'd_asa_tablename'	
END IF

ids_tablename.settransobject(sqlca)
ids_tablename.retrieve()
//------------------- APPEON END ---------------------

of_zoom() //Start Code Change ----07.13.2017 #V154 maha

end event

event destructor;//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 08.23.2007 By: Evan
//$<Reason> Need to destroy object.
//DESTROY pfc_cst_nv_data_entry_functions
if IsValid(inv_data_entry) then Destroy inv_data_entry
if IsValid(ids_image_data) then Destroy ids_image_data
//---------------------------- APPEON END ----------------------------

end event

type cb_decheck from commandbutton within pfc_cst_u_data_entry
boolean visible = false
integer x = 2075
integer y = 4
integer width = 402
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "DE check"
end type

event clicked;messagebox("",tab_view.tabpage_image.dw_detail_2.rowcount()  )
end event

type st_dw_select_section_border from u_st_border within pfc_cst_u_data_entry
integer x = 5
integer y = 8
integer width = 914
integer height = 1972
long backcolor = 16777215
end type

type cb_view_relation from commandbutton within pfc_cst_u_data_entry
boolean visible = false
integer x = 3739
integer y = 20
integer width = 471
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Entity Relationships"
end type

event clicked; //Start Code Change ----05.15.2015 #V15 maha - added
gs_report_variables lst_val

lst_val.as_report_object = "d_rpt_entity_relations_tv"
//lst_val.as_report_object = "d_tv_smokey"
lst_val.as_value[1] = string(il_prac_id)
lst_val.ai_num_variables = 1
lst_val.as_var_type[1] = "N"
lst_val.ab_treeview = True
lst_val.as_single = "S"
 
 openwithparm(w_report_view,lst_val)
end event

type st_select from statictext within pfc_cst_u_data_entry
boolean visible = false
integer x = 361
integer y = 24
integer width = 69
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type dw_addresses from u_dw within pfc_cst_u_data_entry
boolean visible = false
integer x = 1870
integer y = 1424
integer width = 279
integer height = 100
integer taborder = 70
string dataobject = "d_group_data_entry_for_pt"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event buttonclicked;call super::buttonclicked;//--------------------------- APPEON BEGIN ---------------------------
//$<  Add > 2008-08-01 By: Scofield
//$<Reason> Popup a dialog to input the phone

String	ls_Phone,ls_fax,ls_RetParm

if row > 0 and row <= This.RowCount() then
	if dwo.name = 'b_phone' then
		ls_Phone = This.GetItemString(row,'phone')
		OpenWithParm(w_phonedetail,ls_Phone)
		
		ls_RetParm = Message.StringParm
		
		if ls_RetParm <> 'Cancel' then
			This.SetItem(row,'phone',ls_RetParm)
		end if
		This.SetColumn('phone')
	elseif dwo.name = 'b_fax' then
		ls_fax = This.GetItemString(row,'fax')
		if IsNull(ls_fax) then ls_fax = ""
		OpenWithParm(w_phonedetail,"Fax:" + ls_fax)
		
		ls_RetParm = Message.StringParm
		
		if ls_RetParm <> 'Cancel' then
			This.SetItem(row,'fax',ls_RetParm)
		end if
		This.SetColumn('fax')
	end if
end if
//---------------------------- APPEON END ----------------------------

end event

type st_recs from statictext within pfc_cst_u_data_entry
integer x = 2926
integer y = 20
integer width = 430
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 67108864
boolean enabled = false
string text = "Record 1 of 1"
boolean focusrectangle = false
end type

event constructor;this.TextColor = rgb(96, 96, 96)
end event

type dw_ver_data from u_dw within pfc_cst_u_data_entry
boolean visible = false
integer x = 965
integer y = 1228
integer width = 2601
integer height = 36
integer taborder = 60
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-20
//$<comment> 02.08.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Comment the following script since dw_ver_data is not used at all.
/*

This.of_SetUpdateAble(False)

DataWindowChild dwchild

This.GetChild("response_code", dwchild)

dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Credentials Verification Response")


This.GetChild("verification_method", dwchild)

dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("verification method")
*/
//---------------------------- APPEON END ----------------------------


end event

event itemchanged;call super::itemchanged;IF This.GetColumnName() = "response_code" THEN
	IF IsNull(This.GetItemString( row, "user_name" ) ) THEN
		This.SetItem( row, "user_name", gnv_app.of_getuserid() )
		This.SetItem( row, "source", "P" )
		This.SetItem( row, "date_recieved", Today() )
	END IF
END IF
end event

type dw_select_section from u_dw within pfc_cst_u_data_entry
event pfc_after_select ( )
event ue_goto_status ( )
event pfc_cst_after_error ( )
integer x = 9
integer y = 12
integer width = 905
integer height = 1964
integer taborder = 10
boolean bringtotop = true
string title = "Select Data Screen"
string dataobject = "d_data_view_screens_list"
boolean hscrollbar = true
boolean border = false
end type

event pfc_after_select();String	ls_PicPath,ls_PicName,ls_Postfix
long li_find, rc  //maha 07.15.2015

IF dw_browse.RowCount() > 1 THEN
//	dw_browse.SelectRow( 1, True )   //Start Code Change ----01.20.2016 #V15 maha - removed
	dw_browse.ScrollToRow( 1 )
	dw_browse.SetRow( 1 )
	tab_view.tabpage_details.Enabled = True
	tab_view.tabpage_browse.Enabled = True
	dw_browse.SetFocus()	
ELSE
	dw_browse.Visible = False
	dw_detail.Visible = True
	dw_detail.SetFocus( )
	dw_detail.ScrollToRow( 1 )
	dw_detail.SetRow( 1 )
	dw_detail.PostEvent("pfc_after_select")	
END IF

// maha 080200
//if is_screen_name = "Address" then
if dw_browse.rowcount() > 0 then //add by stephen 03.18.2013 -Invalid DataWindow row/column specified
	Choose case ii_screen_id
		case 2 
			il_addr_id = dw_browse.getitemnumber(1,"rec_id")
			dw_link_list.dataobject = "d_addr_link_check_boxes"
			dw_link_list.settransobject(sqlca)
			dw_link_list.retrieve(il_addr_id)
		case 10 
			il_hosp_id = dw_browse.getitemnumber(1,"rec_id")
			dw_link_list.dataobject = "d_hosp_facil_link_de"
			dw_link_list.settransobject(sqlca)
			dw_link_list.retrieve(il_hosp_id)
		case 19 
			il_hosp_id = dw_browse.getitemnumber(1,"rec_id")
			dw_link_list.dataobject = "d_spec_facil_link_de"
			dw_link_list.settransobject(sqlca)
			dw_link_list.retrieve(il_hosp_id)
 //Start Code Change ----07.15.2015 #V15 maha - moved below as it is not dependent upon data record retrieval		
//		case 32,65,70,71,26  //Start Code Change ----05.09.2014 #V14.2 maha - added for facility specific screens
//			dw_link_list.dataobject = "d_facility_linked_data_facilities"
//			dw_link_list.settransobject(sqlca)
//			rc = dw_link_list.retrieve(il_prac_id, gs_user_id) //add gs_user_id by Appeon long.zhang 04.02.2015 (V14.2 Bug # 4471 - DataWindow error when selecting facility specific data screens )
//End Code Change  ----07.15.2015
end choose
end if


 //Start Code Change ----07.15.2015 #V15 maha
Choose case ii_screen_id
				
	case 32,65,70,71,26  //Start Code Change ----05.09.2014 #V14.2 maha - added for facility specific screens
		 //Start Code Change ----07.16.2015 #V15 maha
		if  ii_screen_id = 65 then
			dw_link_list.dataobject = "d_facility_linked_data_facilities_attest"
		else
			dw_link_list.dataobject = "d_facility_linked_data_facilities"
		end if
		//End Code Change ----07.16.2015
		dw_link_list.settransobject(sqlca)
		rc = dw_link_list.retrieve(il_prac_id, gs_user_id) //add gs_user_id by Appeon long.zhang 04.02.2015 (V14.2 Bug # 4471 - DataWindow error when selecting facility specific data screens )

		if rc > 0 then
			//Start Code Change ----07.16.2015 #V15 maha
			if  ii_screen_id = 65 then
				li_find = dw_link_list.find("pd_affil_stat_rec_id  = " + string(il_affil_recid) , 1, rc)
			else
				li_find = dw_link_list.find("facility_id = " + string( ii_parent_facility_id), 1, rc)
			end if
			//End Code Change ----07.16.2015
			if li_find > 0 then
//				dw_link_list.selectrow(li_find,true)  //Start Code Change ----03.16.2016 #V15 maha - removed
				dw_link_list.scrolltorow(li_find)
			end if
		end if
End choose
//End Code Change  ----07.15.2015


//\ maha
//\/maha 072301 prac picture
//if is_screen_name = "Basic Information" then
if ii_screen_id = 1 then

	if IsValid(m_pfe_cst_data_entry) then
		if w_mdi.of_security_access( 40 ) < 2 or w_mdi.of_security_access( 50 ) < 2 then
//			m_pfe_cst_data_entry.m_file.m_importphoto.enabled = false
//			m_pfe_cst_data_entry.m_file.m_clearphoto.Enabled = false  //maha072209
			gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_file.m_importphoto,'enabled', false)
			gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_file.m_clearphoto,'enabled', false)
		else
//			m_pfe_cst_data_entry.m_file.m_importphoto.enabled = true
//			m_pfe_cst_data_entry.m_file.m_clearphoto.Enabled = true //maha072209
			gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_file.m_importphoto,'enabled', true)
			gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_file.m_clearphoto,'enabled', true)
		end if
	end if
	//------------------- APPEON END ---------------------
	
	SELECT image_type INTO :ls_Postfix from pd_photo WHERE pd_photo.prac_id = :gl_prac_id ;
	
	if IsNull(ls_Postfix) or Trim(ls_Postfix) = "" then
		Parent_Window.tab_1.tabpage_detail.p_face.Visible = false
		//Parent_Window.tab_1.tabpage_detail.p_face.PictureName = "nophoto.bmp"
	else
		ls_PicPath = TRIM(gnv_data.of_getitem("ids","picture_path",false))
		if Right(ls_PicPath,1) <> "\" then ls_PicPath += "\"
		
		ls_PicName = ls_PicPath + String(gl_prac_id) + "." + ls_Postfix
		
		of_Download_Photo(gl_prac_id,ls_PicPath)
		
		if FileExists(ls_PicName) then
			Parent_Window.tab_1.tabpage_detail.p_face.Visible = false
			//Parent_Window.tab_1.tabpage_detail.p_face.Visible = true
			Parent_Window.tab_1.tabpage_detail.p_face.BringToTop = true
			Parent_Window.tab_1.tabpage_detail.p_face.PictureName = ""
			Parent_Window.tab_1.tabpage_detail.p_face.PictureName = ls_PicPath + String(gl_prac_id) + "." + ls_Postfix
		else
			Parent_Window.tab_1.tabpage_detail.p_face.Visible = false
		end if
	end if
//---------------------------- APPEON END ----------------------------
	
	
//Start Code Change ----04.23.2008 #V8 maha	- modification to set ssn /npi from search
	if mid(gs_ssnnpi,1,1 ) = "S" then
		if dw_detail.Describe("ssn.ColType") <> "!" then
			if isnull(dw_detail.getitemstring(1,"ssn")) then dw_detail.setitem(1,"ssn", mid(gs_ssnnpi,3)) //Start Code Change ----11.17.2009 #V92 maha - changed to not overwrite
		end if
		gs_ssnnpi = ""
	elseif mid(gs_ssnnpi,1,1 ) = "N" then
		if dw_detail.Describe("npi_number.ColType") <> "!" then
			if isnull(dw_detail.getitemstring(1,"npi_number")) then dw_detail.setitem(1,"npi_number", mid(gs_ssnnpi,3))  //Start Code Change ----11.17.2009 #V92 maha - changed to not overwrite
		end if
		gs_ssnnpi = ""
	end if
//End Code Change---04.23.2008
else
	if IsValid(m_pfe_cst_data_entry) then 
//		m_pfe_cst_data_entry.m_file.m_importphoto.Enabled = false		//Added by Scofield on 2008-09-23
//		m_pfe_cst_data_entry.m_file.m_clearphoto.Enabled = false	//maha 072209
		gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_file.m_importphoto,'enabled', false)
		gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_file.m_clearphoto,'enabled', false)
	end if
	parent_window.tab_1.tabpage_detail.p_face.visible = false
end if
//End Code Change---04.23.2008

//Start Code Change ----05.16.2016 #V15 maha
dw_browse.Modify ("DataWindow.Detail.color='536870912~tif( getrow() = currentrow(), rgb(168, 205, 241), rgb(255, 255, 255) )'")
//messagebox("",err)
//End Code Change ----05.16.2016

//Start Code Change ---- 06.15.2006 #545 maha removed existing code
of_detail_scrollbar(ii_screen_id)
//End Code Change---06.15.2006

of_links_security(ii_screen_id)   //Start Code Change ----05.26.2009 #V92 maha 

of_refresh_page_menu( ) //Start Code Change ----03.27.2012 #V12 maha

//if this is a custom screen then put a scroll bar on it
IF ii_screen_id > 100 THEN
	dw_detail.vscrollbar = True
END IF
of_zoom()//Added by (Appeon)10.23.2017 #V161 Gavin Alpha Testing Bug # 5851
SetRedraw(True)


end event

event ue_goto_status;				Parent_window.tab_1.SelectTab( 3 )
				Parent_window.tab_1.tabpage_apptmnt_status.uo_affill_status.of_new_record( il_prac_id )
				Parent_window.tab_1.tabpage_apptmnt_status.uo_affill_status.of_set_new_prac( True )

end event

event pfc_cst_after_error;dw_detail.SetFocus()
end event

event constructor;This.of_Setupdateable(False)

end event

event rowfocuschanged;call super::rowfocuschanged;//----------------------------- RP added 1.12.2016------------------------
this.setRedraw(TRUE)

IF currentrow = 0 THEN
	Return
END IF

if ib_report = true then return

Long ll_height
Long ll_data_view_id
Long ll_detail_2_screen_id
String ls_screen_name
string err
Integer li_retval
Integer li_last_fld_y


ii_address_lnk_cnt=0

IF ib_refresh_screen_list = True THEN
// RP	This.SelectRow( 0, False )
// RP	This.SelectRow( il_last_row, True )
	This.SetRow( il_last_row )
	Return -1
END IF

IF ib_refresh_screen_list = True THEN
	Return
END IF

ls_screen_name = This.GetItemString( currentrow, "screen_name" )
//messagebox('',ls_screen_name)

//Start Code Change ----01.15.2013 #V12 maha
if this.getitemnumber(currentrow, "batch_add_field" ) > 0 then ib_add = false

//debugbreak()

//SetRedraw(False)
//Start Code Change ---08.19.2008 #V85 maha - moved the detail 2 screen creation before the detail screen so that setting defaults will work
ll_data_view_id = This.GetItemNumber( currentrow, "data_view_id" )
ii_screen_id = This.GetItemNumber( currentrow, "screen_id" )

//Start Code Change ----03.16.2016 #V15 maha - modified to get facility specific field for facility links dw
if this.getitemnumber(currentrow, "facility_specific" ) > 0 then 
	ib_facil_links = true
else
	ib_facil_links = false
end if

//set the addr,specialty and hosp
choose case ii_screen_id
	case 2,10,19
		ib_facil_links = true
end choose
//End Code Change ----03.16.2016

//Start Code Change ----11.08.2017 #V16 maha
if  This.GetItemstring( currentrow, "cert_period" ) = "Y" then 
	ib_cert_period = true
else
	ib_cert_period = false
end if
//End Code Change ----11.08.2017

IF This.GetItemNumber( currentrow, "table_id_2" ) > 0 THEN
	ll_detail_2_screen_id = This.GetItemNumber( currentrow, "table_id_2" ) 
	is_sql_syntax = inv_data_entry.of_create_dynamic_dw( il_prac_id, ll_data_view_id, ll_detail_2_screen_id, tab_view.tabpage_image.dw_detail_2, tab_view.tabpage_image.dw_detail_2, ib_screen_painter, ii_parent_facility_id, true )	
	is_first_column_detail_2 = inv_data_entry.of_get_first_column()	
	of_modify_dw_access(il_prac_id ,  tab_view.tabpage_image.dw_detail_2) //Added by Appeon long.zhang 11.17.2014
	tab_view.tabpage_image.Visible = True
//Start Code Change ----11.08.2017 #V16 maha
ELSEIF  ib_cert_period then
	//retrieve the  cert period data
	is_sql_syntax = inv_data_entry.of_create_dynamic_dw( il_prac_id, ll_data_view_id, 74, tab_view.tabpage_image.dw_detail_2, tab_view.tabpage_image.dw_detail_2, ib_screen_painter, ii_parent_facility_id, False )	
	is_first_column_detail_2 = inv_data_entry.of_get_first_column()	
	of_modify_dw_access(il_prac_id ,  tab_view.tabpage_image.dw_detail_2) 
	tab_view.tabpage_image.Visible = True
	//messagebox("",  tab_view.tabpage_image.dw_detail_2.rowcount())
//End Code Change ----11.08.2017
else
	tab_view.tabpage_image.Visible = False
END IF

//Start Code Change ----03.10.2014 #V14.2 maha
if ii_screen_id = 2 then
	tab_view.tabpage_linked_data.Visible = true
else
	tab_view.tabpage_linked_data.Visible = False
	//tab_view.tabpage_linked_data.of_hide_links()
end if
//End Code Change ----03.10.2014




is_sql_syntax = inv_data_entry.of_create_dynamic_dw( il_prac_id, ll_data_view_id, ii_screen_id, dw_detail, dw_browse, ib_screen_painter, ii_parent_facility_id, ib_add )
is_first_column_detail_1 = inv_data_entry.of_get_first_column()
of_modify_dw_access(il_prac_id , dw_detail) //Added by Appeon long.zhang 11.17.2014

//---------Begin Added by (Appeon)Stephen 07.16.2015 for Bug id 4601 - Allegheny Webview Data Audit Case# 55838, 55847--------
if ii_screen_id = 65 then	 
	if gl_prac_de_appt_id > 0 then
		dw_browse.setfilter("appt_stat_id = " + string(gl_prac_de_appt_id ))
		dw_detail.setfilter("appt_stat_id = " + string(gl_prac_de_appt_id ))
	else
		dw_browse.setfilter("active_status in ( 1,4)")
		dw_detail.setfilter("active_status in ( 1,4)")
	end if
	dw_browse.filter()
	dw_detail.filter()
	dw_browse.modify("active_status_1.tabsequence='0'")
	dw_browse.modify("appt_stat_id_1.tabsequence='0'")
end if
dw_browse.setredraw(true)
dw_detail.setredraw(true)
dw_browse.setfilter("")
dw_detail.setfilter("")
//---------End Added ------------------------------------------------------

//------------Begin Added by alfee 09.10.2010 -------------------------------------
//Add a button to access image(s) to the screen - SK Practitioner Folder
//if gb_sk_ver and not of_get_ib_screen_painter () then 
if not of_get_ib_screen_painter () then 	//alfee 11.22.2010
	long ll_cnt
	select count(*) into :ll_cnt from pd_images, image_type 
	 where pd_images.image_type_id = image_type.image_type_id 
	   and pd_images.prac_id = :il_prac_id and image_type.link_to_screen = :ii_screen_id ;
//Start Code Change ----01.25.2016 #V15 maha - changed font and color
	if ll_cnt > 0 then 
		if of_get_app_setting("set_img","I") = 1 and w_mdi.of_security_access(1000) > 0 then //Start Code Change ----05.11.2011 #V11 maha - security trap
			dw_detail.Modify ("DataWindow.Header.Height= '110'" )
			dw_detail.Modify("create button(band=header text='Access Image(s)' filename=''action='0' border='1' color='8388608' x='10' y='16' height='85' width='635' vtextalign='0' htextalign='0'  font.face='Segoe UI' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = imgbutton)")
		end if
	end if		
end if	
//------------End Added ---------------------------------------------------------------
//Start Code Change ----12.02.2010 #V10 maha - work gap calculation  //Start Code Change ----09.27.2012 #V12 maha - added education and training
choose case ii_screen_id
	case 12, 6, 7, 10, 55 //work gap button
		dw_detail.Modify ("DataWindow.Header.Height= '110'" )
		dw_detail.Modify("create button(band=header text='Calculate Work Gap' filename=''action='0' border='1' color='8388608' x='1096' y='16' height='85' width='635' vtextalign='0' htextalign='0'  font.face='Segoe UI' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = gapbutton)")
	case 13		// references //Start Code Change ----02.08.2013 #V12 maha - moved from dynamic dw creation
		IF of_get_app_setting("set_5","I") = 0 THEN//(Appeon)Toney 11.07.2013 - V141 ISG-CLX,Fix BugT110603, Create Button by system parameter
			dw_detail.Modify ("DataWindow.Header.Height= '110'" )
			dw_detail.Modify("create button(band=header text='Select Peer' filename=''action='0' border='1' color='8388608' x='1100' y='16' height='85' width='635' vtextalign='0' htextalign='0'  font.face='Segoe UI' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = peerbutton)")
		END IF
	case 2 //address screen
		dw_detail.Modify ("DataWindow.Header.Height= '110'" )
		dw_detail.Modify("create button(band=header text='Find Addresses' filename=''action='0' border='1' color='8388608' x='1100' y='16' height='85' width='635' vtextalign='0' htextalign='0'  font.face='Segoe UI' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = findbutton)")
		//Start Code Change ----05.07.2013 #V12 maha		
		dw_detail.Modify("create button(band=header text='Add/View Pending Changes' filename=''action='0' border='1' color='8388608' x='1750' y='16' height='85' width='800' vtextalign='0' htextalign='0'  font.face='Segoe UI' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256'  visible='1~tif( isNull(rec_id),0,1)' name = pendingbutton)")//uncommented by long.zhang v14.1 group location effective date ;added visibile property by long.zhang 11.13.2013 
		//Start Code Change ----11.19.2013 #V14 maha
		//Start Code Change ----10.06.2014 #V14.2 maha - removed, shown on Linked data tab
//		if of_get_app_setting("set_iapps","I") = 1 and of_get_app_setting("set_74","I") = 1 then
//			dw_detail.Modify("create button(band=header text='Linked Ids' filename=''action='0' border='1' color='128' x='660' y='16' height='85' width='425' vtextalign='0' htextalign='0'  font.face='Segoe UI' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = id_link)")
//		End if
		//End Code Change ----10.06.2014
end choose	
//End Code Change ----12.02.2010


//Start Code Change ----01.05.2015 #V14.2 maha - view entity
choose case ii_screen_id
	case 5, 6, 7, 10, 15, 19, 72, 18      ,8, 3, 11, 14,12, 9   //view entity button  //maha 11.18.2016 - added additional screens
		dw_detail.Modify ("DataWindow.Header.Height= '110'" )
		dw_detail.Modify("create button(band=header text='View Entity' filename=''action='0' border='1' color='8388608' x='1750' y='16' height='85' width='635' vtextalign='0' htextalign='0'  font.face='Segoe UI' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = viewentity)") 
end choose	
//End Code Change ----01.05.2015
//End Code Change ----01.25.2016

//ll_data_view_id = This.GetItemNumber( currentrow, "data_view_id" )
//ii_screen_id = This.GetItemNumber( currentrow, "screen_id" )
//is_sql_syntax = inv_data_entry.of_create_dynamic_dw( il_prac_id, ll_data_view_id, ii_screen_id, dw_detail, dw_browse, ib_screen_painter, ii_parent_facility_id )
//is_first_column_detail_1 = inv_data_entry.of_get_first_column()
//tab_view.tabpage_image.Visible = False
//IF This.GetItemNumber( currentrow, "table_id_2" ) > 0 THEN
//	ll_detail_2_screen_id = This.GetItemNumber( currentrow, "table_id_2" ) 
//	is_sql_syntax = inv_data_entry.of_create_dynamic_dw( il_prac_id, ll_data_view_id, ll_detail_2_screen_id, tab_view.tabpage_image.dw_detail_2, tab_view.tabpage_image.dw_detail_2, ib_screen_painter, ii_parent_facility_id )	
//	is_first_column_detail_2 = inv_data_entry.of_get_first_column()	
//	tab_view.tabpage_image.Visible = True
//END IF
//End Code Change---08.19.2008

// RP This.SelectRow(0, False)
// RP This.SelectRow( currentrow, True)

IF This.GetItemString( currentrow, "multi_record" ) = "Y" THEN
	tab_view.tabpage_browse.Enabled = True
ELSE
	tab_view.tabpage_browse.Enabled = False
END IF

ll_height = Long( dw_detail.Describe("DataWindow.Detail.Height") )


//Start Code Change ---- 06.15.2006 #546 maha
of_detail_scrollbar(ii_screen_id)
//End Code Change---06.15.2006



IF This.GetItemString( currentrow, "multi_record" ) = "Y" AND NOT ib_screen_painter AND dw_browse.RowCount() > 1 THEN
	tab_view.SelectTab( 1 )	
	dw_detail.Visible = False		
	dw_browse.Visible = True	
	dw_browse.SetFocus()	
ELSE
	tab_view.SelectTab( 2 )
	dw_detail.SetFocus()
	dw_detail.BringToTop = True	

	dw_detail.PostEvent("pfc_after_select")	
END IF


dw_link_list.visible = false

of_add_delete_enable()

//dw_browse.SelectRow( 0, False)   //Start Code Change ----01.20.2016 #V15 maha - removed

//---------Begin Modified by (Appeon)Harry 06.29.2013 for V141 ISG-CLX--------
//Start Code Change ----10.07.2009 #V10 maha - for Lehigh
//if of_get_app_setting("set_58","I") = 1 then
if of_get_app_setting("set_91","I") = 1 then
//---------End Modfiied ------------------------------------------------------
	parent_window.title = parent_window.is_prac_title + " - " + ls_screen_name 
	//parent_window.title = parent_window.is_full_name  + " - " + String( parent_window.il_prac_id ) + "  (" + parent_window.is_facility_name + ")" + " - " + ls_screen_name 
end if
//End Code Change---10.07.2009

This.PostEvent("pfc_after_select")

il_last_row = currentrow
end event

event pfc_deleterow;Return 1
end event

event pfc_addrow;Return 1
end event

event pfc_firstpage;RETURN 0
end event

event pfc_lastpage;RETURN 0
end event

event pfc_nextpage;RETURN 0
end event

event pfc_previouspage;RETURN 0
end event

event rowfocuschanging;call super::rowfocuschanging;Integer li_retval
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-19
//$<add> 03.03.2006 By: Cao YongWang
//$<reason> Performance tuning. 
//$<modification> Write script to make sure that when pfc_cst_u_data_entry
//$<modification> is just opened, RowFocusChanging is not executed immediately.
If ib_just_open Then
	ib_just_open = False
	return
End If
If currentrow < 1 Then return
//---------------------------- APPEON END ----------------------------

IF ib_screen_painter THEN
	IF is_designer_type = "S" THEN
		IF ib_report = False then
			//BEGIN-Modify by Evan 12.14.2010
			//IF Parent_window_design.Event pfc_Save() < 0 THEN
			IF w_prac_data_design.Event pfc_Save() < 0 THEN
			//END-Modify by Evan 12.14.2010
				This.PostEvent( "pfc_cst_after_error" )
				Return 1
			END IF
		ELSE
			//BEGIN-Modify by Evan 12.14.2010
			//IF Parent_window_design_report.Event pfc_Save() < 0 THEN
			IF w_prac_report_design.Event pfc_Save() < 0 THEN
			//END-Modify by Evan 12.14.2010
				This.PostEvent( "pfc_cst_after_error" )
				Return 1
			END IF
		END IF
	ELSE
		IF Parent_window_profile_design.Event pfc_Save() < 0 THEN
			This.PostEvent( "pfc_cst_after_error" )
			Return 1
		END IF		
	END IF
ELSE
	li_retval = Parent_window.Event pfc_Save()

	IF li_retval < 0 THEN
		This.PostEvent( "pfc_cst_after_error" )
		Return 1
	END IF	
END IF

 ii_parent_facility_id = ii_org_parent   //Start Code Change ----07.15.2015 #V15 maha - for facility specifc screens
end event

event clicked;call super::clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08.03.2006 By: LeiWei
//$<reason> Fix a defect.

IF row > 0 THEN
	This.Setrow( row )
END IF

//---------------------------- APPEON END ----------------------------

Integer li_row

li_row = This.GetClickedRow()

IF li_row = 0 THEN
	dw_detail.SetFocus()
END IF
end event

event retrieveend;call super::retrieveend;//used to change the icon for screens where the practitioner has data. 
if  not ib_screen_painter then
	of_screen_color()
end if


end event

type dw_loc_defaults from u_dw within pfc_cst_u_data_entry
boolean visible = false
integer x = 3195
integer y = 1692
integer width = 549
integer height = 300
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_group_update_defaults"
end type

event constructor;call super::constructor;this.of_setupdateable( false)
this.of_settransobject( sqlca)
end event

type r_1 from rectangle within pfc_cst_u_data_entry
boolean visible = false
integer linethickness = 4
long fillcolor = 12639424
integer x = 942
integer y = 108
integer width = 2775
integer height = 1852
end type

event constructor;this.fillcolor = rgb(0,125,0)
end event

type dw_link_list from u_dw within pfc_cst_u_data_entry
integer x = 946
integer y = 1500
integer width = 2779
integer height = 476
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_addr_link_check_boxes"
end type

event pfc_preupdate;call super::pfc_preupdate;//jad 8/21/01
Integer li_rc
Integer i

li_rc = This.RowCount()

//if is_screen_name = "Address"  then //maha 082301
if ii_screen_id = 2 then

	FOR i = 1 TO li_rc
		IF This.GetItemStatus( i, 0, Primary!)  = DataModified! THEN
			IF of_address_link_check() = -1 THEN
				//debugbreak()
				Return Failure
			END IF
		END IF
	END FOR
end if

Return Success
end event

event constructor;call super::constructor;This.of_SetTransObject( sqlca )
end event

event pfc_addrow;Return 1
end event

event itemchanged;call super::itemchanged;long ll_specialty_id,ll_practicing
dw_detail.SetFocus()

IF This.GetColumnName() = "primary_office" AND data = "1" THEN
	This.SetItem( row, "additional_office", 0 )
ELSEIF This.GetColumnName() = "additional_office" AND data = "1" THEN
	This.SetItem( row, "primary_office", 0 )
END IF

end event

event buttonclicked;call super::buttonclicked;String ls_field
Integer li_rc
Integer i
String ls_type
string s //maha 03.22.2011

if dwo.Name =  "b_filter" then
	of_filter_links("Click")
	return 1
end if

if dwo.Name =  "b_addr_help" then
	s = "Primary Address is used in report and Application mapping filtering.~r~r"
	s+= "Additional Address is used in report and application mapping filtering.~r~r"
	s+= "Billing Address is used in report and mapping filtering, and also determines which addresses appear in the Billing Address link dropdown.~r~r"
	s+= "Home Address is used in report and Application mapping filtering.~r~r"
	s+= "Mailing Address is used when sending Correspondence or Expiring Appointment Letters.~r~r"
	s+= "The Expiring Credential Address is used when mailing Expiring credential letters.~r~r"
	s+= "Directory is used to define which Addresses are included in Standard Directory reports.~r~r"
	s+= "The arrow buttons will copy the value in the first row to the other rows (when all rows are showing)"
	messagebox("About Links",s)
	return 1
end if


CHOOSE CASE dwo.Name
	CASE "p"
		ls_field = "primary_office"
		ls_type = "1"
	CASE "a"		
		ls_field = "additional_office"		
		ls_type = "1"		
	CASE "b"
		ls_field = "billing"				
		ls_type = "1"		
	CASE "h"
		ls_field = "home_address"				
		ls_type = "1"		
	CASE "m"
		ls_field = "mailing"				
		ls_type = "1"		
	CASE "e"
		ls_field = "exp_letters"		
		ls_type = "1"		
	CASE "d"
		ls_field = "include_in_directory"				
		ls_type = "1"		
	CASE "hospital"
		ls_field = "pd_hosp_facility_link_primary_hosp"
		ls_type = "2"		
	CASE "specialty"
		ls_field = "pd_spec_facility_link_practicing"
		ls_type = "2"	
END CHOOSE


li_rc = This.RowCount()
FOR i = 1 TO li_rc
	IF ls_type = "1" THEN	
		IF This.GetItemNumber( 1, ls_field ) = 1 THEN
			This.SetItem( i, ls_field, 1 )
		ELSE
			This.SetItem( i, ls_field, 0 )			
		END IF
	ELSE
		IF This.GetItemNumber( 1, ls_field ) = 581 THEN
			This.SetItem( i, ls_field, 581 )
		ELSE
			This.SetItem( i, ls_field, 582 )			
		END IF
	END IF
END FOR

//Start Code Change ----08.05.2009 #V92 maha - reset focus so add works
dw_detail.setfocus()
//End Code Change---08.05.2009

end event

event retrieveend;call super::retrieveend;of_filter_links("One") //Start Code Change ----10.21.2010 #V10 maha - filter to one facility record
dw_link_list.Modify("DataWindow.Zoom=" + string(gi_zoom))  //Start Code Change ----07.13.2017 #V154 
end event

event clicked;call super::clicked;  //Start Code Change ----05.09.2014 #V14.2 maha - facility specific screens
integer ll_cnt
 long ll_appt_id //maha 07.15.2015


choose case ii_screen_id   
	case 32,70,71,65,72, 26
		integer r
		long fid
		long ll_data_view_id
		
		r = this.getclickedrow( )
		if r = 0 then return
		if this.rowcount() > 0 then
//			this.selectrow(0,false)   //Start Code Change ----01.20.2016 #V15 maha - removed
//			this.selectrow(r,true)
			this.setrow(r)

			fid = this.getitemnumber(r,"facility_id")
			ii_parent_facility_id = fid   //Start Code Change ----03.31.2015 #V15 maha
			//messagebox("Facility",fid)
			
			 //Start Code Change ----07.15.2015 #V15 maha - for attest quest
			 //when changing between facilities - if the original selected facility use the affil id, otherwise use the filtering by the active status
			if  ii_screen_id = 65 then //attest
				if fid = ii_org_parent then
					gl_prac_de_appt_id =  il_affil_recid
				else
					gl_prac_de_appt_id = 0
				end if
			end if
			 //End Code Change ----07.15.2015			
			
			ll_data_view_id = dw_select_section.GetItemNumber( dw_select_section.getrow(), "data_view_id" )
			is_sql_syntax = inv_data_entry.of_create_dynamic_dw( il_prac_id, ll_data_view_id, ii_screen_id, dw_detail, dw_browse, ib_screen_painter, fid, ib_add )
			choose case tab_view.selectedtab
				case 1
					tab_view.selecttab(1)
				case 2
					tab_view.selecttab(2)
			end choose
			
			//---------Begin Added by (Appeon)Stephen 07.16.2015 for Bug id 4601 - Allegheny Webview Data Audit Case# 55838, 55847--------
			if ii_screen_id = 65 then	 
				ll_appt_id = this.getitemnumber(r, "pd_affil_stat_rec_id")
				if ll_appt_id > 0 then
					dw_browse.setfilter("appt_stat_id = " + string(ll_appt_id ))
					dw_detail.setfilter("appt_stat_id = " + string(ll_appt_id ))
				else
					dw_browse.setfilter("active_status in ( 1,4)")
					dw_detail.setfilter("active_status in ( 1,4)")
				end if
				dw_browse.modify("appt_stat_id.tabsequence='0'")
				dw_browse.modify("active_status.tabsequence='0'")
				dw_browse.filter()
				dw_detail.filter()
				dw_browse.modify("active_status_1.tabsequence='0'")
				dw_browse.modify("appt_stat_id_1.tabsequence='0'")
			end if
			dw_browse.setredraw(true)
			dw_detail.setredraw(true)
			this.setredraw(true) //Start Code Change ----03.16.2016 #V15 maha
			dw_browse.setfilter("")
			dw_detail.setfilter("")
			//---------End Added ------------------------------------------------------
			
			//Start Code Change ----03.16.2015 #V15 maha - redraw the images button
			select count(*) into :ll_cnt from pd_images, image_type 
			 where pd_images.image_type_id = image_type.image_type_id 
				and pd_images.prac_id = :il_prac_id and image_type.link_to_screen = :ii_screen_id ;
			if ll_cnt > 0 then 
				if of_get_app_setting("set_img","I") = 1 and w_mdi.of_security_access(1000) > 0 then //Start Code Change ----05.11.2011 #V11 maha - security trap
					dw_detail.Modify ("DataWindow.Header.Height= '110'" )
					dw_detail.Modify("create button(band=header text='Access Image(s)' filename=''action='0' border='1' color='128' x='10' y='16' height='85' width='635' vtextalign='0' htextalign='0'  font.face='Segoe UI' font.height='-8' font.weight='700'  font.family='2' font.pitch='2' font.charset='0' background.mode='2' background.color='12632256' name = imgbutton)")
				end if
			end if	
			//End Code Change ----03.16.2015
		end if
		

end choose




end event

type dw_detail from u_dw within pfc_cst_u_data_entry
event ue_showlist pbm_custom01
event pfc_cst_preupdate pbm_custom02
event pfc_after_select ( )
event type integer ue_after_itemchanged ( string as_type )
integer x = 951
integer y = 108
integer width = 2775
integer height = 1868
integer taborder = 30
boolean vscrollbar = false
boolean livescroll = false
end type

event pfc_after_select();Int i

This.SetFocus()

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 09.24.2015
//<$>reason:Walk around for web version (Date and Time stamp showing on the hospital affiliation screen case#57363 Bug_id#4741)

//This.SetColumn( is_first_column_detail_1 )
i = This.GetColumn ( )
If i > 0 Then
	If Lower(This.Describe("#"+String(i) +'.Name' )) <> Lower(is_first_column_detail_1) Then This.SetColumn( is_first_column_detail_1 )
Else
	This.SetColumn( is_first_column_detail_1 )
End If
//------------------- APPEON END -------------------






end event

event type integer ue_after_itemchanged(string as_type);//maha 8-2005

string s

s = String(Message.LongParm, "address")
//messagebox("s",s)
of_lookup_search_dddw(s)

return 1
end event

event constructor;This.of_SetRowManager( TRUE )
//This.inv_rowmanager.of_SetRestoreRow( TRUE )
//This.inv_rowmanager.of_SetConfirmOnDelete ( TRUE )
This.of_SetReqColumn(TRUE)



end event

event rowfocuschanged;call super::rowfocuschanged;st_recs.Text = "Record " + String(This.GetRow()) + " of " + String(This.RowCount())

IF currentrow > 0 THEN
	of_get_record_verif( currentrow )
//	dw_browse.SelectRow( 0, False )  //Start Code Change ----01.20.2016 #V15 maha - removed
//	dw_browse.SelectRow( currentrow, True )
	dw_browse.SetRow( currentrow )
	dw_browse.ScrollToRow( currentrow )
	if ib_report=false then
		if this.rowcount() > 0 then
			il_rec_id = This.GetItemNumber( currentrow, "rec_id" )
		end if
	end if
END IF
end event

event pfc_addrow;call super::pfc_addrow;Integer li_retval
integer cnt
long ll_appt_id
long ll_batch_add_field  //maha 12.06.2012
integer r   //maha 12.06.2012
integer nr   //maha 12.06.2012
integer li_dup = 0  //maha 06.20.2017 
string ls_field   //maha 12.06.2012
string ls_ftype  //maha 04.18.2017
long ll_table  //maha 12.06.2012
long ll_find  //maha 12.06.2012

tab_view.tabpage_image.Enabled = False

//Start Code Change ----07.01.2014 #V14.2 maha
if tab_view.SelectedTab = 1 then
	tab_view.SelectTab( 2 )
end if
//Start Code Change ----07.01.2014

ll_batch_add_field = dw_select_section.getitemnumber(dw_select_section.getrow(), "batch_add_field")  //Start Code Change ----11.28.2012.2012 #V12 maha
ll_table = dw_select_section.getitemnumber(dw_select_section.getrow(), "table_id")  //Start Code Change ----12.06.2012.2012 #V12 maha

if ii_screen_id = 65 or ii_screen_id = 54 then //maha app081705 questions//Start Code Change ---- 06.08.2006 #529 maha
	this.deleterow( this.rowcount()) //delete the just added row
	//Start Code Change ----06.17.2009 #V92 maha - changed to hit db once
//	select count(rec_id) into :cnt from pd_affil_stat where prac_id = :gl_prac_id and parent_facility_id = :ii_parent_facility_id and active_status > 0;
//	if cnt < 1 then
//		messagebox("Appointment record error","There are no non-history records (Active,Inactive,Pending,Purge) for this practitioner and facility.  This should be corrected on the Appointment Status tab before adding Attestation Questions.")
//		return - 1 
//	else
		select top 1 rec_id into :ll_appt_id from pd_affil_stat where prac_id = :gl_prac_id and parent_facility_id = :ii_parent_facility_id and active_status > 0;  
//	end if	

	If isnull(ll_appt_id) or ll_appt_id = 0 then
		messagebox("Appointment record error","There are no active records for this practitioner and facility. As questions are directly connected to the Appointment record, unable to add Questions.")
		return - 1 
	end if
	//End Code Change---06.17.2009
	//Start Code Change ---- 06.08.2006 #529 maha
	if ii_screen_id = 65 then
		inv_data_entry.of_add_questions("PRAC",dw_detail,ii_parent_facility_id,gl_prac_id,ll_appt_id)
	elseif  ii_screen_id = 54  then //practice questions
		inv_data_entry.of_add_questions("PQ",dw_detail,ii_parent_facility_id,gl_prac_id,ll_appt_id)
	end if
	//End Code Change---06.08.2006
//Start Code Change ----12.06.2012 #V12 maha - for 12.3
elseif  ii_screen_id = 72 then
	
	gs_pass_ids lst_ids   //maha 12.06.2012
	if This.Describe("verif_type.ColType") <> "!" then
		If This.Describe("verif_type.dddw.displaycolumn") = "entity_name" then
			open(w_other_verification_select)
			if message.stringparm = 'Cancel' then
				return 0
			else
				this.deleterow( this.rowcount())  //the row just added
				lst_ids = message.powerobjectparm
				if this.getitemstatus( 1,0, primary!) = new! then //if a blank record added for no rows
					//messagebox("","New")
					this.deleterow( 1 ) //delete the just added row 
				end if

				for r = 1 to upperbound(lst_ids.sl_action_type)			
					nr = this.insertrow(0)
					this.setitem(nr, "verif_type", lst_ids.sl_action_type[r] )
					if This.Describe("verif_method.ColType") <> "!" then
						this.setitem(nr, "verif_method", lst_ids.l_ids[r] )
					end if
					inv_data_entry.of_set_defaults( This, This.RowCount() )
				next
			end if
		End if //entity column
	end if
end if //(Appeon)Stephen 06.19.2017 - Bug id 5700 - Trouble adding with Screen Batch Setting SaaS V15.3 05272017 and 06142017 and C/S 15.309 Build Date 5/11/2017


if ll_batch_add_field > 0 then //(Appeon)Stephen 06.19.2017 -modify "elseif" to 'if' --Bug id 5700 - Trouble adding with Screen Batch Setting SaaS V15.3 05272017 and 06142017 and C/S 15.309 Build Date 5/11/2017 
	openwithparm(w_batch_record_add, string(ll_table) + "@" + string(ll_batch_add_field ))

	if message.stringparm = 'Cancel' then
		return 0
	else
		gs_variable_array lst_types   //maha 12.06.2012
		ls_field = gnv_data.of_getitem("sys_fields", "field_name", "field_id = " + string( ll_batch_add_field ))
		ls_ftype = gnv_data.of_getitem("sys_fields", "field_type", "field_id = " + string( ll_batch_add_field ))   //Start Code Change ----04.18.2017 #V153 maha - changed for any field that is a character
		this.deleterow( this.rowcount()) //delete the just added row
		lst_types = message.powerobjectparm
		for r = 1 to upperbound(lst_types.as_number )
			//---------Begin Modified by (Appeon)Stephen 11.23.2015 for Bug id 4852 - Screen Batch Setting Utility--------
			//ll_find = this.find( ls_field + " = " + string(lst_types.as_number[r]), 1, this.rowcount())
			if ls_ftype = "C" then   //Start Code Change ----04.18.2017 #V153 maha - changed for any field that is a character
			//if ii_screen_id = 28 then
				ll_find = this.find( ls_field + " = '" + string(lst_types.as_number[r])+ "'", 1, this.rowcount())
			else
				ll_find = this.find( ls_field + " = " + string(lst_types.as_number[r]), 1, this.rowcount())
			end if
			//---------End Modfiied ------------------------------------------------------
			//Start Code Change ----06.20.2017 #V154 maha - allow duplicates; only ask the dupe message once
			if ll_find > 0  and li_dup = 0 then
				li_dup = messagebox("Duplicate found","An existing record of the same type as selected currently exists.  Do you want to add duplicates?", question!, yesno!, 2)
			end if
			//if ll_find = 0 then
			if li_dup < 2 then
				nr = this.insertrow(0)
				if This.Describe(ls_field + ".ColType") <> "!" then
					//Start Code Change ----04.18.2017 #V153 maha - changed for any field that is a character
					if  ls_ftype = "C" then
						this.setitem(nr, ls_field , string(lst_types.as_number[r] ))
					else
						this.setitem(nr, ls_field , lst_types.as_number[r] )
					end if
					//End Code Change ----04.18.2017
				end if
				inv_data_entry.of_set_defaults( This, This.RowCount() )
			end if
		next			
	end if
//End Code Change ----12.06.2012

else
	inv_data_entry.of_set_defaults( This, This.RowCount() )
	This.SetItemStatus( This.RowCount(), 0, Primary!, NotModified! )
end if

if  ii_screen_id = 2 then //Start Code Change ----09.30.2014 #V14.2 maha
	tab_view.tabpage_linked_data.enabled = false
end if

this.scrolltorow(This.RowCount()) //maha app100305
This.SetColumn( is_first_column_detail_1 )
This.SetFocus()

if IsValid(m_pfe_cst_data_entry) then //Added By Evan 01.11.2012
	//m_pfe_cst_data_entry.m_edit.m_addverificationentry.Enabled = False
	gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_edit.m_addverificationentry,'Enabled', False)
end if
of_refresh_page_menu() //Added By Ken.Guo 06.10.2008

RETURN 0
end event

event pfc_retrieve;call super::pfc_retrieve;

Return This.Retrieve( )
end event

event buttonclicked;DataWindowChild dwchild
string s
string ls_phone
long v
gs_pass_ids lst_ids

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08.03.2006 By: LeiWei
//$<reason> Fix a defect.
IF ib_screen_painter THEN RETURN
//---------------------------- APPEON END ----------------------------

IF dwo.Name = "linkbutton" THEN
	IF This.GetItemStatus( row, 0, Primary! ) = New! or This.GetItemStatus( row, 0, Primary! ) = NewModified! THEN
		MessageBox("Save", "You need to first save the address record before applying address links." )
		Return
	ELSE
		OpenWithParm( w_address_link, String( il_prac_id ) + "-" + String( dw_detail.GetItemNumber( dw_detail.GetRow(), "rec_id")) )	
		//\/maha 080300
		dw_link_list.retrieve( dw_detail.GetItemNumber( dw_detail.GetRow(), "rec_id")) 
		//\maha
	END IF
ELSEIF dwo.Name = "findbutton" THEN
	 //Start Code Change ----07.23.2015 #V15 maha - changed to function
	of_find_address( )

//\/maha 062801  peer lookup select
elseif dwo.Name = "peerbutton" THEN

	OpenWithParm(w_peer_reference_select, this)
	//------------------- APPEON END ---------------------
ELSEIF dwo.Name = "imgbutton" THEN //SK Practitioner Folder - alfee 09.10.2010
	if of_get_app_setting("image_storage_type","I") = 0 then//Start Code Change ----05.11.2011 #V11 maha - trap for images on hard drive
		messagebox("View Images","This functionality is only available if your images are stored in the database.  Please view your images from the Documents tab.~r~rContact ISG support for assistance in migrating your images to the database.")
		return
	end if
	IF il_prac_id > 0 and ii_screen_id > 0 THEN
		//-------------------------------APPEON BEGIN--------------------
		//$<Modified> long.zhang 11.04.2011
		//$<Reason> view image
		//OpenwithParm(w_image_preview, string(il_prac_id) + '||' + string(ii_screen_id))
		IF IsValid(w_image_preview) then
			w_image_preview.of_get_image(string(il_prac_id) + '||' + string(ii_screen_id),il_rec_id)
		else
//			OpenwithParm(w_image_preview, string(il_prac_id) + '||' + string(ii_screen_id))
			OpenwithParm(w_image_preview, string(il_prac_id) + '||' + string(ii_screen_id)+ '||' +string(il_rec_id)) //long.zhang 03.28.2012
		end if
		//----------------------------APPEON END-------------------------
	END IF		
ELSEIF dwo.Name = "gapbutton" THEN  //Start Code Change ----12.02.2010 #V10 maha - Work Gap Calculate
	 //Start Code Change ----05.23.2017 #V154 maha - change to structure
	lst_ids.prac_id = il_prac_id
	lst_ids.facility_id = ii_parent_facility_id
	//openwithparm( w_work_gap_add_records, il_prac_id)
	openwithparm( w_work_gap_add_records, lst_ids)
	//End Code Change ----05.23.2017
	
	if ii_screen_id = 55 then
		dw_detail.retrieve( il_prac_id )
	end if
	//of_calc_work_gap(il_prac_id)
elseif dwo.name = "pendingbutton" then //Added by Appeon long.zhang 07.31.2013 (V14.1 Group Location Effective Dates)
		openWithParm(w_pending_changes_address,parent)
elseif dwo.name = "id_link" then   //Start Code Change ----11.19.2013 #V14 maha
	openWithParm(w_address_ids_view, this.getitemnumber(row,"rec_id"))
//Start Code Change ----01.05.2015 #V14.2 maha
Elseif dwo.name = "viewentity" then
	//function to view the lookup detail
	if is_lookup_search_column_field = "None" then
		messagebox("Entity Search", "Please select the Entity field first" )
	else
		v = this.getitemnumber(this.getrow(), is_lookup_search_column_field )
		if isnull(v) or v < 0 then 
			//return
		else
			//Start Code Change ----09.24.2015 #V15 maha - changed to structure
			
			lst_ids.s_ids[2] = string(v)
			lst_ids.s_ids[1] = "V"
			lst_ids.dw = this
			//openwithparm(w_lookup_add, "V#" + string(v))
			openwithparm(w_lookup_add_child, lst_ids)
			 //End Code Change ----09.24.2015
		end if
	end if
	//End Code Change ----01.05.2015	
END IF


end event

event itemchanged;call super::itemchanged;String ls_type
string ls_value  //maha 11.13.2014
string ls_city, ls_state, ls_county , ls_country //maha 11.13.2014
long ll_code  //maha 11.13.2014
Integer li_screen
Integer li_ans
Integer li_stat
Long ll_rec_id


IF inv_data_entry.of_itemchanged( This, Data ) = 1 THEN //this function buts a dot on the basic info middle name if only 1 character
	RETURN 2
END IF

//Start Code Change ----08.01.2008 #V85 maha - modified active status to use function call rewrote to test only on existing records
IF This.GetColumnName() = "active_status" And This.GetItemStatus( row, 0, primary!) <> newmodified! THEN //Start Code Change ----08.01.2008 #V85 maha - change to run only if not  a new record - changed to <> newmodified 02.02.2008
	li_stat = Integer(Data)
	if ii_screen_id <> 2 then //Start Code Change ----02.02.2009 #V92 maha - trap for address screen	
		IF li_stat = 0 THEN //if inactive display message
			li_ans = MessageBox( "Active Status", "If you change this active status to INACTIVE, all verification entries for this record will be Permanently changed to inactive.  Continue?", Question!, YesNo!, 1 )
			IF li_ans = 1 THEN
				li_ans = MessageBox("Active Status", "Are you sure?", Question!, YesNo!, 1	)
				IF li_ans = 2 THEN //if no set active
					This.SetItem(row,This.GetColumn( ),1 )
					RETURN
				END IF
			END IF
		END IF
		
		ll_rec_id = This.GetItemNumber( row, "rec_id" )
		parent_window.inv_action_items.of_update_verif_status(  ll_rec_id, ii_screen_id , li_stat  )
	end if
	//	IF data = "0" THEN
	//		Integer li_ans
	//		Long ll_rec_id
	//		li_ans = MessageBox( "Active Status", "If you change this active status to INACTIVE, all verification entries for this record will be Permanently changed to inactive.  Continue?", StopSign!, YesNo!, 1 )
	//		IF li_ans = 1 THEN
	//			li_ans = MessageBox("Active Status", "Are you sure?", StopSign!, YesNo!, 1 )
	//			IF li_ans = 1 THEN
	//				ll_rec_id = This.GetItemNumber( row, "rec_id" )
	//				UPDATE verif_info  
	//			     SET active_status = 0 
	//				WHERE rec_id = :ll_rec_id;
	//				IF SQLCA.SQLCODE = -1 THEN
	//					MessageBox("Database Error", SQLCA.SQLERRTEXT )
	//				END IF
	//			END IF
	//		END IF
	//	END IF
	
END IF
//End Code Change---08.01.2008

tab_view.tabpage_image.Enabled = True

////@@@@ZIP CODE AUTO FILL @@@@@@@@
 //Start Code Change ----04.07.2015 #V15 maha - zip autofill
IF This.GetColumnName() = "zip" then
	this.accepttext( )
	ls_value = this.getitemstring(this.getrow(),"zip")  //Start Code Change ----09.28.2015 #V15 maha - corrected for wrong row
	of_zip_fill(ls_value, "DE", this)
end if
////End Code Change ----04.07.2015


//maha 061605 for lookup search

IF Long(Data) = -777 THEN
	ls_type = "C"
	AcceptText( )
	This.PostEvent( "ue_after_itemchanged",0,ls_type)
ELSEIF Long(Data) = -888 THEN
	ls_type = "A"
	AcceptText( )
	This.PostEvent( "ue_after_itemchanged",0,ls_type )
	inv_data_entry.of_refresh_cache( ) //maha 122205
END IF


end event

event pfc_deleterow;Return of_delete_record( This )


end event

event pfc_validation;call super::pfc_validation;Integer li_retval
integer li_table_id

//Start Code Change ----06.18.2008 #V81 maha - removed. now called from of_validate in dw_detail
//if this.rowcount() < 1 then return 1 modify Michael 11.01.2011 Invalid DataWindow row/column 
if this.rowcount() < 1 or dw_select_section.GetRow() < 0 then return 1
li_table_id = dw_select_section.GetItemNumber( dw_select_section.GetRow(), "table_id" )
li_retval = of_validate( li_table_id, this.getrow())
//li_retval = inv_data_entry.of_record_validation( This )
IF li_retval = -1 THEN
	Return -1
END IF
//End Code Change---06.16.2008

Return AncestorReturnValue

end event

event itemfocuschanged;call super::itemfocuschanged;

//IF This.Describe(This.GetColumnName() + ".DDDW.DisplayColumn") = "entity_name"  THEN
DataWindowChild dwchild
String ls_column_name
integer res	
	
ls_column_name =This.GetColumnName()
res = This.GetChild( ls_column_name, dwchild )
//Start Code Change ----01.05.2015 #V14.2 maha
if This.Describe("viewentity.text") <> "!" then this.modify( "viewentity.enabled = false")
is_lookup_search_column_field = "None" 
//End Code Change ----01.05.2015

if res > 0 then
	IF dw_select_section.GetRow()>0 Then//Added by  Nova 06.17.2010
		if dw_select_section.getitemnumber(dw_select_section.getrow(),"screen_id") = 65 or dw_select_section.getitemnumber(dw_select_section.getrow(),"screen_id") = 54 or ls_column_name = "billing_address_id" then //maha app081705 trap for question dddw
			//nothing
		else
			IF dwchild.RowCount() > 2 THEN //maha changed from 1 for lookup search 061605
				//--------------------------- APPEON BEGIN ---------------------------
				//$<add> 04.19.2006 By: LeiWei
				//$<reason> Fix a defect.
				/*
				is_lookup_search_column_table = dwchild.GetItemString( 3, "lookup_name" )//maha changed from 2 for lookup search 061605 //Start Code Change ---- 06.08.2006 #528 maha
				*/
//				IF ls_column_name <> "street" THEN
				IF ls_column_name <> "street" and ls_column_name <> "active_status" THEN  //Start Code Change ----07.23.2008 #V85 maha - added active_status exception
					is_lookup_search_column_table = dwchild.GetItemString( 3, "lookup_name" )//maha changed from 2 for lookup search 061605
				END IF
				
				 //Start Code Change ----01.05.2015 #V14.2 maha
				if this.describe( ls_column_name + ".dddw.name")  = 'd_dddw_address_lookup' then 
					is_lookup_search_column_field = ls_column_name
					this.modify( "viewentity.enabled = true")
				end if
				 //end Code Change ----01.05.2015
				//---------------------------- APPEON END ----------------------------
			END IF
		end if
	END IF	
	
end if
IF IsValid( m_pfe_cst_data_entry ) THEN
	//m_pfe_cst_data_entry.m_edit.m_lookupsearch.Enabled = True
	gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_edit.m_lookupsearch,'Enabled', True)
END IF

//ELSE
//	IF IsValid( m_pfe_cst_data_entry ) THEN
//		m_pfe_cst_data_entry.m_edit.m_lookupsearch.enabled = False
//	END IF
//END IF

IF This.GetColumnName() = "billing_address_id" THEN
	//If This.Describe( "billing_address_id.dddw.name") = 'd_dddw_billing_addresses' Then//'IF' Added by Appeon long.zhang 02.02.2015 (address screen error)
		This.GetChild( "billing_address_id", dwchild )
		dwchild.SetTransObject( SQLCA )
		dwchild.Retrieve( il_prac_id )
		
		dwchild.InsertRow( 1 )
		dwchild.SetItem( 1, "pd_address_street", "N/A" )	
		dwchild.SetItem( 1, "pd_address_city", "" )
		dwchild.SetItem( 1, "code_lookup_code", "" )
		dwchild.SetItem( 1, "pd_address_rec_id", -1 )	
		dwchild.InsertRow( 1 )
		dwchild.SetItem( 1, "pd_address_street", "Same" )	
		dwchild.SetItem( 1, "pd_address_city", "" )
		dwchild.SetItem( 1, "code_lookup_code", "" )
		dwchild.SetItem( 1, "pd_address_rec_id", 0 )
		dwchild.InsertRow( 1 )
		dwchild.SetItem( 1, "pd_address_street", "" )	
		dwchild.SetItem( 1, "pd_address_city", "" )
		dwchild.SetItem( 1, "code_lookup_code", "" )	
	//End If
END IF


end event

event pfc_preupdate;call super::pfc_preupdate;//this is the preupdate being used

DateTime ldt_exp_date
DateTime ldt_null_date
DateTime ldt_exp_date_original
Long ll_rec_id
Long ll_address_code
long ll_appt_stat_recid  //#1 maha 101606
long ll_templ_id[ ]  //#1 maha 101606
long ll_verif_response  //#1 maha 101606  completion response code for verif; if 0 will not be completed.
long li_seq_no
long li_found
Long ll_new_cnt //Added By Ken.Guo 03.31.2008
Long ll_rec_id_new //Added By Ken.Guo 05.29.2008. Replace il_rec_id
Long ll_rec_id_changed[]
long ll_ver_method = -1  //maha 08.31.2011
long ll_gp //maha 04.14.2015
long ll_gp_org //maha 04.14.2015
Integer li_table_id
Integer li_facility_specific
Integer li_screen_id
Integer li_current_row
Integer i
Integer li_cnt
Integer li_rec_count
Integer li_data_cr
Integer li_verif_rc
Integer li_retval
integer li_year //maha031601
integer li_month//maha031601
integer li_validate//maha080803
integer li_res //maha 032406
integer li_complete[ ] //#1 maha 101606
integer li_auto_gen[ ] //#1 maha 101606
integer li_app_audit_facil //#1 maha 101606
integer li_appt_stat //#1 maha 101606
integer li_temp_cnt //#1 maha 101606
integer li_status = 1 //maha 080108
integer t  //#1 maha 101606
integer li_set_mess //maha 05.05.2009
integer li_len //maha 02.10.2014
boolean lb_save_mess = false //maha 02.26.2014

string ls_use_as_ver //#1 maha 101606
String ls_screen_name
String ls_ref_1
String ls_val
String ls_ref_2
String ls_ref_3
String ls_exp_field
String ls_reference
String ls_rec_status
string ls_app_type //#1 maha 101606
string ls_mess //#1 maha 101706
string ls_type1//maha102501
string ls_type2//maha102501
string ls_type3//maha102501
DataWindowChild dwchild
n_ds lds_aa_template //#1 maha 101606

SetNull( ldt_null_date )
This.AcceptText()


//Start Code Change ----02.27.2014 #V14 maha - modifed and moved to top
if this.modifiedcount( ) > 0 and ib_test_save then
	li_set_mess = of_get_app_setting("set_90","I")
	li_screen_id = dw_select_section.GetItemNumber( il_last_row, "screen_id")//Added by Appeon long.zhang 11.23.2015 (Bug id #4853 -Show Save Approval on Demographics tab Functionality)
	if li_set_mess = 1 and li_screen_id = 1  then 
		lb_save_mess = true
	elseif  li_set_mess = 2 then
		lb_save_mess = true
	else
		lb_save_mess = false
	end if
		
	if lb_save_mess then
		li_res = messagebox("Data Modified","The data on this screen has been modified.  Do you wish to save changes?",question!, yesno!,1)
		if li_res = 2 then		
			Post of_refresh_screen() //Added by Appeon long.zhang 11.23.2015 (Bug id #4853 -Show Save Approval on Demographics tab Functionality)
			
			SetRedraw( True ) 
			return 100
		end if
	end if
end if

ib_test_save = true
//End Code Change ----02.27.2014


//initialize variables for dataflow: alfee 01.07.2010
inv_dataflow.of_init_data() 

li_rec_count = This.RowCount()
IF li_rec_count < 1 THEN
	IF ib_deleting THEN
		RETURN 1
	ELSE
		RETURN -1
	END IF
END IF

SetRedraw( False )

il_last_de_row = This.GetRow()
li_data_cr = This.GetRow()

ls_ref_1 = dw_select_section.GetItemString( il_last_row, "ref_field_1")
ls_ref_2 = dw_select_section.GetItemString( il_last_row, "ref_field_2")
ls_ref_3 = dw_select_section.GetItemString( il_last_row, "ref_field_3")
ls_type1 = dw_select_section.GetItemString( il_last_row, "ref_1_type")//maha102501
ls_type2 = dw_select_section.GetItemString( il_last_row, "ref_2_type")//maha102501
ls_type3 = dw_select_section.GetItemString( il_last_row, "ref_3_type")//maha102501

ls_exp_field = dw_select_section.GetItemString( il_last_row, "exp_field")
li_screen_id = dw_select_section.GetItemNumber( il_last_row, "screen_id")
ls_screen_name = dw_select_section.GetItemString( il_last_row, "screen_name")
li_table_id = dw_select_section.GetItemNumber( dw_select_section.GetRow(), "table_id" )
//---------Begin Modified by (Appeon)Harry 06.29.2013 for V141 ISG-CLX--------
//li_set_mess = of_get_app_setting("set_57","I")  //Start Code Change ----05.04.2009 #V92 maha
//li_set_mess = of_get_app_setting("set_90","I")  //Start Code Change ----02.27.2014 #V14 maha - moved up
//---------End Modfiied ------------------------------------------------------
li_validate  = Long(gnv_data.of_getitem( "sys_fields", "field_id", "table_id = "+String(li_table_id)+" and use_validation > 0"))

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-30
//$<add> 03.16.2006 By: Liang QingShi
//$<reason> Performance tuning
//$<modification> Define a variable to 1)get the first ID; 2)Update the final ID
//$<modification> value into database.
ll_new_cnt = 0
FOR i = 1 TO li_rec_count
	IF This.GetItemStatus( i, 0, Primary!)  = NewModified! THEN
		ll_new_cnt++
	//Start Code Change ----05.04.2009 #V92 maha - inova mod; if basic data has changed, ask before saving
	//Start Code Change ----02.27.2014 #V14 maha - moved up
//	elseif This.GetItemStatus( i, 0, Primary!)  = DataModified! THEN
//		//Start Code Change ----02.26.2014 #V14.2 maha - added option to present message for all screens
//		if li_set_mess = 1 and li_screen_id = 1  then 
//			lb_save_mess = true
//		elseif  li_set_mess = 2 then
//			lb_save_mess = true
//		else
//			lb_save_mess = false
//		end if
//		
//		if lb_save_mess then
//			li_res = messagebox("Data Modified","The data on this screen has been modified.  Do you wish to save changes?",question!, yesno!,1)
//			if li_res = 2 then
//				SetRedraw( True ) 
//				return 100
//			end if
//		end if
//		//End Code Change ----02.26.2014
		//End Code Change---05.04.2009
	End IF
END FOR
If ll_new_cnt > 0 Then
	ll_rec_id_new = gnv_app.of_Get_Id("RECORD_ID" , ll_new_cnt) - 1
	If ll_rec_id_new < 0 Then //Added By Ken.Guo 04.24.2008.
		Messagebox('Error','Failed to get Record_ID value, Please call support.')
		SetRedraw( True ) 
		Return -1
	End If
End If
//---------------------------- APPEON END ----------------------------
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-25
//$<add> 2006-04-11 By: owen chen
//$<reason> Performance tuning modification
//$<modification> Use ids_parent_facilities to retrive all data
//$<modification> to be used by pfc_cst_u_data_entry. 
ids_parent_facilities = CREATE n_ds
ids_parent_facilities.DataObject = "d_address_link_parent_facility_id"
ids_parent_facilities.of_SetTransObject( SQLCA )
ids_parent_facilities.Retrieve( il_prac_id )
//---------------------------- APPEON END ----------------------------
//@@@@@@@@
//Start Code Change ---- 10.25.2006 #1 maha  getting values for checklist creation
ids_parent_facilities.setfilter("parent_facility_id = " + string(ii_parent_facility_id) + " and active_status in (1,4)")
ids_parent_facilities.filter()
li_app_audit_facil =  ids_parent_facilities.rowcount()
//select count(rec_id) into :li_app_audit_facil from pd_affil_stat where prac_id = :il_prac_id and parent_facility_id = :ii_parent_facility_id and active_status in (1,4);
if li_app_audit_facil > 1 then
	li_app_audit_facil = -1 //trap if there is improper data
elseif li_app_audit_facil = 1 then //normally should be one
	//get the template items for the screen
	lds_aa_template = CREATE n_ds
	lds_aa_template.DataObject = "d_app_audit_by_facility_screen"
	lds_aa_template.of_SetTransObject( SQLCA )
	ls_app_type = ids_parent_facilities.getitemstring(1,"apptmnt_type")
	li_app_audit_facil = ids_parent_facilities.getitemnumber(1,"application_audit_facility")
	ll_appt_stat_recid = ids_parent_facilities.getitemnumber(1,"rec_id")
	li_temp_cnt = lds_aa_template.Retrieve(li_app_audit_facil ,ii_screen_id,ls_app_type)
	debugbreak()
	if li_temp_cnt < 1 then
		li_auto_gen[i] = 0
		li_complete[i] = 0
		ls_use_as_ver = "N"
		ll_verif_response = 0
	else //WHAT ABOUT MULTIPLES?
		for i = 1 to li_temp_cnt  //get each auto gen item
			ll_templ_id[i] = lds_aa_template.getitemnumber(i,"app_audit_id")
			li_auto_gen[i] = lds_aa_template.getitemnumber(i,"auto_generate")
			if isnull(li_auto_gen[i]) then li_auto_gen[i] = 0
			li_complete[i] = lds_aa_template.getitemnumber(i,"receive_from_de")
			if isnull(li_complete[i]) then li_complete[i] = 0
			if ls_use_as_ver <> "Y" then //if not already set to use as verification
				ls_use_as_ver = lds_aa_template.getitemstring(i,"use_as_verification")
				if isnull(ls_use_as_ver) then ls_use_as_ver = "N"
			end if
			if ll_verif_response = 0 or isnull(ll_verif_response) then //get response code if not set
				ll_verif_response = lds_aa_template.getitemnumber(i,"default_ver_response_code")
				if isnull(ll_verif_response) then ll_verif_response = 0
			end if
		next
		if ls_use_as_ver = "Y" then
			ls_mess = "Y"
		else
			ls_mess = "N"
		end if
		ls_mess = ls_mess +  "*" +string(ll_verif_response )
	end if
end if
//w_app_audit_complete_mes
ids_parent_facilities.setfilter("") //reset the filter
ids_parent_facilities.filter()
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//End Code Change---10.25.2006

FOR i = 1 TO li_rec_count
	//debugbreak()			
	SetNull( ll_address_code )
	IF This.GetItemStatus( i, 0, Primary!) <> NewModified! AND +&
		This.GetItemStatus( i, 0, Primary!) <> DataModified! THEN
		CONTINUE
	ELSEIF This.GetItemStatus( i, 0, Primary!)  = NewModified! THEN
		ls_rec_status = "New"
		ll_rec_id_new ++
		This.SetItem( i, "prac_id", il_prac_id)
		IF li_screen_id = 61 or li_screen_id = 32 or li_screen_id = 33 THEN		
			SELECT pd_affil_stat.rec_id  
    		INTO :ll_rec_id_new  
    		FROM pd_affil_stat  
   		WHERE ( pd_affil_stat.prac_id = :il_prac_id ) AND  
         		( pd_affil_stat.parent_facility_id = :ii_parent_facility_id ) AND  
         		( pd_affil_stat.active_status in (1,4) )   ;  //maha  changed to include pending 072402
			IF SQLCA.SQLCODE = -1 THEN
				MessageBox("SQL Error 1", SQLCA.SQLERRTEXT )
				Return -1
			END IF
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 05/05/2008 By: Ken.Guo
			//$<reason> Fix BugK050504.Duplicate PK when save staff category data.
			//li_seq_no = inv_data_entry.of_get_next_seq_no( "department", il_rec_id )
			Choose Case li_screen_id
				Case	32 //Depart/Div/Section
					li_seq_no = inv_data_entry.of_get_next_seq_no( "department", ll_rec_id_new )
				Case	33 //Staff Category
					li_seq_no = inv_data_entry.of_get_next_seq_no( "staff cat", ll_rec_id_new )
				Case	61 //No this screen id in DB???
					li_seq_no = inv_data_entry.of_get_next_seq_no( "department", ll_rec_id_new )
			End Choose
			//---------------------------- APPEON END ----------------------------
			li_seq_no++
			This.SetItem( i, "seq_no", li_seq_no )				
			This.SetItem( i, "rec_id", ll_rec_id_new )			
		ELSE
			This.SetItem( i, "rec_id", ll_rec_id_new )			
		END IF
		IF li_screen_id = 2 then //Upper(ls_screen_name) = "ADDRESS" THEN
			of_add_address_link( ll_rec_id_new )
		elseIF ii_screen_id = 10 THEN		// "HOSPITAL AFFILIATION"
			of_add_hosp_link( ll_rec_id_new )
		elseIF ii_screen_id = 19 THEN			//"BOARD/SPECIALTY"
			of_add_spec_link( ll_rec_id_new )
		END IF
		
	ELSE
		ls_rec_status = "Modified"
		//Start Code Change ----08.08.2016 #V152 maha
		//Start Code Change ----08.11.2016 #V152 maha - corrected for non-existing field
		IF li_screen_id = 2 then
			if This.Describe("active_status.ColType") <> "!" then
				if this.getitemstatus(i, "active_status", primary!) = datamodified! then
					if this.getitemnumber(i, "active_status") <> 1 then
						ll_rec_id = This.GetItemNumber( i, "rec_id" )
						ll_gp = this.getitemnumber( i, "gp_id")  //Start Code Change ----10.17.2016 #V152 maha
						of_address_link_clear(ll_rec_id)
						//Start Code Change ----05.03.2017 #V153 maha - added error trapping 
						if of_addr_check_link_to_loc(i, ll_gp) > 0 then  
							//messagebox("", "You have multiple active addresses connected to the same location record")
						else
							of_appl_action_inactive(ll_gp, il_prac_id )   //Start Code Change ----10.17.2016 #V152 maha
						end if
						//End Code Change ----05.03.2017 
					end if
				end if
			end if
		end if
		//Start Code Change ----08.11.2016 
		//Start Code Change ----08.08.2016 
		//Start Code Change ----11.28.2016 #V153 maha - entity
		Choose case li_screen_id
			Case 1
				of_entity_update(il_prac_id )
			Case 2
				ll_rec_id = This.GetItemNumber( i, "rec_id" )
				of_entity_update(ll_rec_id )
		End choose
	END IF
	
	ll_rec_id = This.GetItemNumber( i, "rec_id" )
	
	//Start Code Change ----07.14.2010 #V10 maha - removed the screen qualification so any other screens with active status will work
//	IF ii_screen_id = 4 OR ii_screen_id = 15 OR ii_screen_id = 5 THEN
		IF This.Describe( "active_status.dddw.name" ) = 'd_code_lookup_active_inactive' THEN
			//IF This.GetItemNumber( i, "active_status" ) = 0 THEN
			IF This.GetItemNumber( i, "active_status" ) < 1 THEN  //Start Code Change ----01.24.2011 #V11 maha - changd from = 0
				if ls_rec_status = "New" then
					CONTINUE
				else				//\/maha 031601  //Start Code Change ----01.24.2011 #V11 maha - modified update query to include prac_id
					update verif_info
					set active_status = 0
					where rec_id = :ll_rec_id and prac_id = :il_prac_id and active_status = 1;
					continue		 //\maha
				end if
			END IF
		END IF
//	END IF	
	//End Code Change ----07.14.2010
	
	//\/maha 031601 get month and year end for check back date passed in verification add
	IF li_screen_id  = 7 or li_screen_id = 10 THEN  // training & hosp affil
		if This.Describe("year_thru.ColType") <> "!" then
			li_year = this.getitemnumber(i,"year_thru")
			if This.Describe("month_thru.ColType") <> "!" then
				li_month = this.getitemnumber(i,"month_thru")
			end if
			//maha added to using full end date field
		//--------Begin Modified by  Nova 07.15.2010------------------------
		//elseif This.Describe("end _date.ColType") <> "!" then    
		elseif This.Describe("end_date.ColType") <> "!" then    
		//--------End Modified --------------------------------------------	
			li_year = year(date(this.getitemdatetime(i,"end_date")))
			li_month = month(date(this.getitemdatetime(i,"end_date")))
		end if
	end if
	//\maha
		
	li_facility_specific = Long(gnv_data.of_getitem( "sys_tables", "facility_specific", "table_id = "+String(li_table_id) ))
	
	IF li_screen_id = 19 THEN //specialty
		if This.Describe("board_code.ColType") = "!" then continue //Start Code Change----06.01.2010 #V10 maha - added trap for hidden board code
		
		IF IsNull( This.GetItemNumber( i, "board_code" ) ) THEN
			CONTINUE
		  //Start Code Change ---- 10.26.2007 #V7 maha	
		ELSE
			ll_address_code = This.GetItemNumber( i, "board_code" ) 
			IF ls_rec_status = "Modified" THEN
		//ELSEIF ls_rec_status = "Modified" THEN
				SELECT count(*)  
				INTO :li_cnt  
						FROM verif_info  
						WHERE ( verif_info.rec_id = :ll_rec_id ) AND  
							( verif_info.active_status = 1 )   ;
				IF IsNull( li_cnt ) OR li_cnt = 0 THEN
					ls_rec_status = "New"
				END IF
			end if //modified
			//End Code Change---10.26.2007
		END IF
	//jad 05/30/01 added to make any screen facility specific
	ELSEIF li_facility_specific = 1 THEN //attest quest or group cov	
		if This.Describe("facility_id.ColType") <> "!" then  //Start Code Change ---- 01.25.07.2007 #V7 maha
			This.SetItem( i, "facility_id", ii_parent_facility_id )	
		end if	
	END IF
	
	//Start Code Change ----08.31.2011 #V11 maha 
	IF li_table_id = 72 THEN  //other verifications
		if This.Describe("verif_method.ColType") = "!" then 
			//leave as default -1
		else
			ll_ver_method = this.GetItemNumber( i, "verif_method" )
			if isnull( ll_ver_method) then ll_ver_method = -1
		end if
	end if
	//End Code Change ----08.31.2011

	//Start Code Change ----02.10.2014 #V14 maha - added to strip space from last name
	IF li_screen_id = 1 THEN
		if This.Describe("last_name.ColType") <> "!" then 
			ls_val = this.GetItemString( i, "last_name" ) 
			li_len = len(ls_val)
			ls_val = of_strip_char("",ls_val, "@LASTNAME@")
			if len(ls_val) <> li_len then
				this.setitem(i,"last_name", ls_val)
			end if
		end if
	end if		
	//End Code Change ----02.10.2014
	
	 //Start Code Change ----04.14.2015 #V15 maha
	IF li_screen_id = 2 THEN
		if This.Describe("gp_id.ColType") <> "!" then 
			if this.getitemstatus( i, "gp_id", primary!) = datamodified! then
				ll_gp = this.getitemnumber( i, "gp_id")
				ll_gp_org = this.getitemnumber( i, "gp_id", primary!, true)		
				//update net_dev_ids set address_id  = :ll_gp where address_id = ll_gp_org and prac_id = :il_prac_id; //(Appeon) Modified by Harry 09.27.2016
				update net_dev_ids set address_id  = :ll_gp where address_id = :ll_gp_org and prac_id = :il_prac_id;
			end if
		end if
	end if
	 //Start Code Change ----04.14.2015			
	
	
	IF NOT IsNull( ls_ref_1 ) AND ls_ref_1 <> "" THEN
		This.ScrollToRow( i )
		This.SetRow( i )

		//move expiration date to verif info table if there is one
		IF Len(ls_exp_field) > 0 THEN
			IF ls_exp_field = "certification_expires" THEN	
				ldt_exp_date = DateTime(Date( String( This.GetItemNumber( i, ls_exp_field ) ) + "-12-30"),Now())
				ldt_exp_date_original = DateTime(Date( String( This.GetItemNumber( i, ls_exp_field, Primary!, True ) ) + "-12-30"),Now())				
			ELSEIF ls_exp_field = "cert_expiration_year" THEN
				li_month = this.GetItemNumber( i, "cert_expiration_month" )
				if isnull(li_month) then
					ldt_exp_date = DateTime(Date( String( This.GetItemNumber( i, ls_exp_field ) ) + "-12-30"),Now())
					ldt_exp_date_original = DateTime(Date( String( This.GetItemNumber( i, ls_exp_field, Primary!, True ) ) + "-12-30"),Now())				
				else
					ldt_exp_date = DateTime(Date(String( This.GetItemNumber( i, ls_exp_field ) ) + "-" + String(li_month) + "-28"),Now())
					ldt_exp_date_original = DateTime(Date(String( This.GetItemNumber( i, ls_exp_field, Primary!, True ) ) + "-" + String(li_month) + "-28"),Now())
				end if
			ELSE
				if This.Describe(ls_exp_field + ".ColType") <> "!" then
					ldt_exp_date = This.GetItemDateTime( i, ls_exp_field )
					ldt_exp_date_original = This.GetItemDateTime( i, ls_exp_field, Primary!, True )
				else
					of_error_message( ls_exp_field, i,"Unable to update data","The " + upper(ls_exp_field) + " field is required by your system settings.~r~rYou will not be able to save data on this screen~runtil the field is made visible in the Screen Painter for the view you are using.")
					return -1
				end if
			END IF
		ELSE
			ldt_exp_date = ldt_null_date
			SetNull( ldt_exp_date_original )
		END IF
	
		//get reference 1 data 		
		if This.Describe(ls_ref_1 + ".ColType") = "!"  or ls_ref_1 = "" then //trap for invisible field maha 012104 
			messagebox("Problem getting reference 1 value for verification","Required Field " + ls_ref_1 + " is invisible.  The verification will not be created/updated.  Contact Customer support for assistance.")
			return 1
		end if
		li_retval = This.SetColumn( ls_ref_1 )
		IF li_retval = 1 THEN
			IF IsNull( GetText() ) OR GetText() = "" THEN
				SetRedraw( True )
				of_error_message(ls_ref_1,i,"Required", "The data field " + ls_ref_1 + " is required.")
				Return -1
			END IF
			li_retval = This.GetChild(ls_ref_1, dwchild)
			IF li_retval = -1 THEN
				ls_reference =  This.GetText()				
			ELSE
				This.SetColumn( ls_ref_1 )
				li_found = dwchild.Find( "lookup_code = " + This.GetText(), 1, 100000 )
				IF li_found < 1 THEN // Add by Evan 05.04.2010 --- trap for row number
					ls_reference = This.GetText()
				ELSEIF This.Describe( ls_ref_1 + ".dddw.displaycolumn") = "code" THEN
					ls_reference = dwchild.GetItemString( li_found, "code" )
					IF ii_screen_id = 4 THEN					
						if This.Describe("verifying_agency.ColType") = "!" then //trap for invisible field maha 040403 
							of_error_message("VERIFYING_AGENCY",i,"Screen Setup Error"," The verifying_agency field is a required field, and must be visible to enter Licence data.  Please set up in the screen painter.")
							return -1
						else
							ll_address_code = This.GetItemNumber( i, "verifying_agency" )
						end if
					ELSEIF li_screen_id = 19 THEN  //Start Code Change ---- 10.26.2007 #V7 maha
						//do nothing, got the address code further up
					ELSE
						if ls_type1 = "C" then //maha 050802 
							ll_address_code = long(This.GetItemstring( i, ls_ref_1 ))//maha 072501
						elseif ls_type1 = "N" then //maha 050802
							ll_address_code = This.GetItemNumber( i, ls_ref_1 )
						end if
					END IF
				ELSEIF This.Describe( ls_ref_1 + ".dddw.displaycolumn") = "entity_name" or This.Describe( ls_ref_1 + ".dddw.displaycolumn") = "entity_name_original" THEN
					if This.Describe( ls_ref_1 + ".dddw.displaycolumn") = "entity_name_original" THEN
						ls_reference = dwchild.GetItemString( li_found, "entity_name_original" )  //Start Code Change ----03.04.2009 #V92 maha -  changed this to aloways use the entity name originalf the of containg the code as well, 
					else
						ls_reference = dwchild.GetItemString( li_found, "entity_name_original" )
					end if
					if ls_type1 = "C" then //maha 102501 took out specific exceptions and tested field type
						ll_address_code = long(This.GetItemstring( i, ls_ref_1 ))//maha 072501
					elseif ls_type1 = "N" then //maha 102501
						ll_address_code = This.GetItemNumber( i, ls_ref_1 )
					end if
				ELSEIF This.Describe( ls_ref_1 + ".dddw.displaycolumn") = "description" THEN //maha 110801
					ls_reference = dwchild.GetItemString( li_found, "description" )
					//Start Code Change ---- 10.10.2007 #V7 maha added same exception for verif ying agency as above
					IF ii_screen_id = 4 THEN					
						if This.Describe("verifying_agency.ColType") = "!" then //trap for invisible field maha 040403 
							of_error_message("VERIFYING_AGENCY",i,"Screen Setup Error"," The verifying_agency field is a required field, and must be visible to enter Licence data.  Please set up in the screen painter.")
							return -1
						else
							ll_address_code = This.GetItemNumber( i, "verifying_agency" )
						end if
					ELSEIF li_screen_id = 19 THEN  //Start Code Change ---- 10.26.2007 #V7 maha
						//do nothing, got the address code further up
					ELSE
						if ls_type1 = "C" then //maha 050802 
							ll_address_code = long(This.GetItemstring( i, ls_ref_1 ))//maha 072501
						elseif ls_type1 = "N" then //maha 050802
							ll_address_code = This.GetItemNumber( i, ls_ref_1 )
						end if
					END IF
					//End Code Change---10.10.2007
				ELSE
					ls_reference = This.GetText()			
				END IF
			END IF
		ELSE
			ls_reference = ""
		END IF

	   If NOT Isnull(ls_ref_2) THEN
			//get reference 2 data
			if This.Describe(ls_ref_2 + ".ColType") = "!" or ls_ref_2 = "" then //trap for invisible field maha 012104 
				messagebox("Problem getting reference 2 value for verification","Required Field " + ls_ref_2 + " is invisible.  The verification will not be created/updated.  Contact Customer support for assistance.")
				return 1
			end if
			li_retval = This.SetColumn( ls_ref_2 )
			IF li_retval = 1 THEN
				IF IsNull( GetText() ) OR GetText() = "" THEN
					SetRedraw( True )
					of_error_message(ls_ref_2,i,"Required", "The data field " + ls_ref_2 + " is required.")
					Return -1
				END IF		
				li_retval = This.GetChild(ls_ref_2, dwchild)
				IF li_retval = -1 THEN
					ls_reference = ls_reference + " - " + This.GetText()				
				ELSE
					This.SetColumn( ls_ref_2 )
					li_found = dwchild.Find( "lookup_code = " + This.GetText(), 1, 100000 )
					if li_found > 0 then //trap added maha 021704
						IF This.Describe( ls_ref_2 + ".dddw.displaycolumn") = "code" THEN
							ls_reference = ls_reference + " - " + dwchild.GetItemString( li_found, "code" )
						ELSEIF dw_detail.Describe( ls_ref_2 + ".dddw.displaycolumn") = "description" THEN
							ls_reference = ls_reference + " - " + dwchild.GetItemString( li_found, "description" )					
						ELSEIF This.Describe( ls_ref_2 + ".dddw.displaycolumn") = "entity_name" or This.Describe( ls_ref_2 + ".dddw.displaycolumn") = "entity_name_original" THEN
							if This.Describe( ls_ref_2 + ".dddw.displaycolumn") = "entity_name_original" THEN
								ls_reference = ls_reference + " - " + dwchild.GetItemString( li_found, "entity_name_original" )
							else
								ls_reference = ls_reference + " - " + dwchild.GetItemString( li_found, "entity_name" )
							end if
						ELSE
							ls_reference = ls_reference + " - " + This.GetText()
						END IF
					else
						ls_reference = ls_reference + " - " + ""
					end if
				END IF
			ELSE
				ls_reference = ls_reference + " - " + ""
			END IF
			
			ls_reference = mid(ls_reference,1,100) //maha 022704 4.1.1
		END IF
//@@@@@

		//Start Code Change ----08.01.2008 #V85 maha - get active status to pass to function
		if this.Describe("active_status.ColType") <> "!" then
			li_status = this.getitemnumber(i,"active_status") //Start Code Change ----04.19.2010 V10 maha - changed from li_data_cr
		end if
		//End Code Change---08.01.2008
		//Start Code Change ---- 10.26.2006 #1 maha
		IF ls_rec_status = "Modified" THEN
			parent_window.Tab_1.tabpage_verif.uo_verif_summary.of_update_reference( ls_reference,  ll_rec_id, ll_address_code,  ldt_exp_date , li_screen_id,li_status, ll_ver_method) //Start Code Change ----08.31.2011 #V11  maha  - added method argument  //Start Code Change ----04.22.2008 #V8 maha - added screen id argument ; 08.01.2008 added li_status argument
			inv_data_entry.of_app_audit_update_ref( il_prac_id , ll_rec_id , mid(ls_screen_name,1,5) + "-" + ls_reference )

			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 2006-10-11 By: Rodger Wu (Inova)
			//$<reason> 
			//----------appeon begin-----------------
		//<$>Modified:long.zhang 11.02.2012
		//<$>reason:For an issue of Apb Bug BugL103001
	//			IF ( Isnull( ldt_exp_date_original ) and Not Isnull( ldt_exp_date ) ) or &
	//				( Isnull( ldt_exp_date ) and Not Isnull( ldt_exp_date_original ) ) or &
	//				( DaysAfter( date( ldt_exp_date_original ), date( ldt_exp_date ))) <> 0 THEN
	//				ll_rec_id_changed[ Upperbound( ll_rec_id_changed ) + 1 ] = ll_rec_id
	//			END IF
			IF not Isnull( ldt_exp_date_original ) or Not Isnull( ldt_exp_date )  then
				IF ( Isnull( ldt_exp_date_original ) and Not Isnull( ldt_exp_date ) ) or &
					( Isnull( ldt_exp_date ) and Not Isnull( ldt_exp_date_original ) ) or &
					( DaysAfter( date( ldt_exp_date_original ), date( ldt_exp_date ))) <> 0 THEN
					ll_rec_id_changed[ Upperbound( ll_rec_id_changed ) + 1 ] = ll_rec_id
				END IF
			end if	
			//----------appeon end-------------------
			//---------------------------- APPEON END ----------------------------
		ELSE  //new
			for t = 1 to li_temp_cnt //check to see if completion is desired
				if li_complete[t] = 1 then 
					openwithparm(w_app_audit_complete_mes,  ls_mess) //asks user to complete and gets response code 
					ls_mess = message.stringparm
					if mid(ls_mess,1,1) = "N" then 
						li_complete[t] = 0
						ll_verif_response = 0
					else //yes
						ll_verif_response = long(mid(ls_mess,3))
					end if	
				else //Start Code Change ---- 05.09.2007 #V7 maha trap so verif does not get completed
					li_complete[t] = 0
					ll_verif_response = 0
				end if
				if li_auto_gen[t] = 1 then  //Start Code Change ---- 05.09.2007 #V7 maha only create if set to auto gen
					inv_data_entry.of_app_audit_item_create( li_app_audit_facil ,il_prac_id ,ll_templ_id[t] ,ll_appt_stat_recid , ll_rec_id , "DE" , li_complete[t] , mid(ls_screen_name,1,5) + "-" + ls_reference )   //Start Code Change ----12.05.2016 #V153 maha )
				end if
			next
			IF Upper( gs_cust_type ) = 'I' THEN ll_verif_response = 326 //if intelliapp, always set to complete the verification
			debugbreak()
			IF parent_window.Tab_1.tabpage_verif.uo_verif_summary.of_add_record( il_prac_id, ll_rec_id, li_screen_id, ls_reference,  ldt_exp_date, ls_screen_name, ll_address_code, "A",li_month,li_year,ll_verif_response, li_status, ll_ver_method) = -1 THEN  //Start Code Change ----08.31.2011 #V11  maha  - added method argument //Start Code Change ----.2008 #V85 maha - added li_status argument
					//Return 1   //Start Code Change ----01.25.2017 #V153 maha - removed return to allow the data record to be saved
					//messagebox("Error","Error adding verification")   //Start Code Change ----01.25.2017 #V153 maha - redundant; removed
			End if
		END IF
			parent_window.ib_app_audit_retrieved = false //Start Code Change ---- 10.30.2006 #1 maha
		//End Code Change---10.26.2006
//@@@@@
	END IF
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 10.12.2006 By: Jack (Inova)
	//$<reason> Queue Images for Scanning from Data Entry.
	long ll_row,ll_seq_no,ll_image_type_id,ll_default_pages,ll_de_queue
	if ls_rec_status = "New" then
		ll_de_queue = long(gnv_data.of_getitem('image_type','de_queue','link_to_screen = ' + string(li_screen_id)))
		//ll_de_queue = 0 //maha changed because it was not working properly
		if ll_de_queue = 1 then
			ll_image_type_id = long(gnv_data.of_getitem('image_type','image_type_id','link_to_screen = ' + string(li_screen_id)))
			ll_default_pages = long(gnv_data.of_getitem('image_type','default_pages','link_to_screen = ' + string(li_screen_id)))

			ll_row = ids_image_data.insertrow(0)
			
			SELECT Max( seq_no )  
			INTO :ll_seq_no  
			FROM pd_images  
			WHERE pd_images.rec_id = :ll_rec_id ;
			
			IF IsNull( ll_seq_no ) THEN
				ll_seq_no = 0
			END IF
			ll_seq_no++
			ids_image_data.SetItem( ll_row, "image_type_id", ll_image_type_id )
			ids_image_data.SetItem( ll_row, "prac_id", il_prac_id )
			ids_image_data.SetItem( ll_row, "seq_no", ll_seq_no )
			ids_image_data.SetItem( ll_row, "rec_id", ll_rec_id  )
			ids_image_data.SetItem( ll_row, "facility_id", ii_parent_facility_id  )	
			ids_image_data.SetItem( ll_row, "screen_id", li_screen_id )	
			ids_image_data.SetItem( ll_row, "reference_name", ls_reference )
			ids_image_data.SetItem( ll_row, "active_status", 1 )	
			ids_image_data.SetItem( ll_row, "num_pages", ll_default_pages )
			ids_image_data.SetItem( ll_row, "tif_start_page", 1 )
			ids_image_data.SetItem( ll_row, "de_queue", 0 )
		end if
	end if
	//---------------------------- APPEON END ----------------------------
END FOR

This.ScrollToRow( li_data_cr )
This.SetRow( li_data_cr )

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 06/03/2008 By: Ken.Guo
//$<reason> Fix issue. After save address data, address link data disappear.
if li_data_cr > 0 then
	il_rec_id = This.GetItemNumber( li_data_cr, "rec_id" )
end if
//---------------------------- APPEON END ----------------------------

dw_detail.BringToTop = True
of_get_record_verif( li_data_cr )

//IF is_screen_name = "Hospital Affiliation" or is_screen_name = "Address"  then //\/maha 082101 
//if is_screen_name = "Hospital Affiliation" or is_screen_name = "Address" or is_screen_name = "Board/Specialty"then
IF ii_screen_id = 10 or ii_screen_id = 2 or ii_screen_id = 19  then
	dw_link_list.bringtotop = True
end if

This.SetRedraw( True )

dw_detail.SetColumn( is_first_column_detail_1 )
dw_detail.SetFocus()

inv_data_entry.of_field_audit( This )

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-26
//$<modify> 2006-04-11 By: owen chen
//$<reason> Performance tuning modification
//$<modification> 1)Modify the script in the pfc_Save from PT-28.
//$<modification> 2)Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
gnv_appeondb.of_startqueue( )
IF ids_parent_facilities.rowcount( ) > 0 THEN
	//Start Code Change ----10.15.2014 #V14.2 maha - added exception code for link screens to correct issue with faciliy specific screens.
	IF ii_screen_id = 10 or ii_screen_id = 2 or ii_screen_id = 19  then
		dw_link_list.Update()
		dw_link_list.Retrieve( il_rec_id )
	end if
	//End Code Change ----10.15.2014 
END IF
ids_image_data.update() //Queue Images for Scanning from Data Entry - Jack 10.12.2006 
gnv_appeondb.of_commitqueue( )

DESTROY ids_parent_facilities
//---------------------------- APPEON END ----------------------------

//keep qualified df ids - dataflow: alfee 12.24.2009
inv_dataflow.of_set_data_flow(this, li_table_id)

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-10-11 By: Rodger Wu (Inova)
//$<reason> Automatically poping up Verification Update window once
//$<reason> value in exp_field changed.
String ls_sql_where, ls_rec_id_str, ls_sql_original
n_ds lds_verify
gs_verif_update lstr_verif

li_cnt = UpperBound( w_mdi.ii_security_action_id )
FOR i = 1 TO li_cnt
	IF w_mdi.ii_security_action_id[ i ] = 160 THEN
		IF w_mdi.ii_security_action_value[ i ] = 0 THEN
			Return 1; //No rights	
		END IF
	END IF		
NEXT

li_cnt = UpperBound( ll_rec_id_changed )
IF li_cnt > 0 THEN
	FOR i = 1 TO li_cnt
		ls_rec_id_str += string( ll_rec_id_changed[i] ) + ", "
	NEXt
	lds_verify = Create n_ds
	lds_verify.DataObject = "d_verification_facility_de_update_maha"
	lds_verify.SetTransObject( SQLCA )
	lstr_verif.sql_syntax = ""//ls_sql_original
	lstr_verif.al_prac_id = il_prac_id
	lstr_verif.al_screen_id = li_screen_id
	lstr_verif.al_rec_id = ll_rec_id_changed
	
	OpenwithParm( w_verification_de_update, lstr_verif )
END IF
//---------------------------- APPEON END ----------------------------

RETURN 1

end event

event pfc_preinsertrow;//\/maha 050701 to trap save errors when entering multiple records

Integer li_retval

// mskinner 17 dec 2005 -- begin
// do not allow for the addition os rows in the PERSIONL DATA screen

STRING LS_SCREEN_NAME
LS_SCREEN_NAME = UPPER(dw_select_section.object.screen_name[dw_select_section.getRow()])
if upper(TRIM(LS_SCREEN_NAME)) = 'PERSONAL DATA' THEN 
	RETURN Failure
END IF 

// mskinner 17 dec 2005 -- end


//if is_screen_name = "Hospital Affiliation" or is_screen_name = "Address" then
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-28
//$<comment> 2006-04-10 By: owen chen
//$<reason> Performance tuning modification
//$<modification> Move the script to PT-26. It is integrated into Appeon Queue labels
//$<modification> to reduce client-server interactions.
/*
li_retval = Parent_window.Event pfc_Save()
	//debugbreak()
	IF li_retval < 0 THEN
		This.PostEvent( "pfc_cst_after_error" )
		Return 1
	END IF
*/

//---------------------------- APPEON END ----------------------------

		
//end if
	
return continue_action

//\maha
end event

event rowfocuschanging;call super::rowfocuschanging;//IF is_screen_name = "Address" AND dw_link_list.GetItemStatus( dw_link_list.GetRow(), 0, Primary!)  = DataModified! THEN 
IF ii_screen_id = 2 AND dw_link_list.GetItemStatus( dw_link_list.GetRow(), 0, Primary!)  = DataModified! THEN 
	IF of_address_link_check() = -1 THEN
		Return 1
	ELSE
		dw_link_list.Update()
	END IF
END IF
end event

event pfc_postupdate;
//Start Code Change ----08.06.2009 #V92 maha - readded with security
if w_mdi.of_security_access(40) = 2 or w_mdi.of_security_access(50) = 2 then
	//m_pfe_cst_data_entry.m_edit.m_addverificationentry.Enabled = True //maha removed 082503
	gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_edit.m_addverificationentry,'enabled', true)
end if
//End Code Change---08.06.2009

This.ScrollToRow( il_last_de_row )
This.SetRow( il_last_de_row )

//setting green checkmark screen icon
integer r

dwItemStatus l_Status
l_Status = this.getitemstatus(1,0,primary!)

r = this.rowcount()
if r > 1 then
	dw_select_section.setitem(dw_select_section.getrow(),"selected",r)
//Start Code Change ----09.22.2010 #V10 maha - modified to make work
elseif l_Status = new! or IsNull(l_Status)  then
	dw_select_section.setitem(dw_select_section.getrow(),"selected",0)
else
	dw_select_section.setitem(dw_select_section.getrow(),"selected",1)
end if
//Start Code Change ----09.22.2010
//---------------------------- APPEON END ----------------------------

//Added for Work Flow trigger. 11.21.2006 Henry
string ls_module
long ll_screen_id[]  //12.13.2006 By Jervis

If of_Get_app_setting("set_9" , "I") = 1 Then
	ls_module = '02'
Else
	ls_module = '01'
End if
If gb_workflow Then
	n_cst_workflow_triggers lnv_workflow
	lnv_workflow = create n_cst_workflow_triggers
	
	If parent_window.ib_new_prac Then ii_parent_facility_id = 1
	//12.13.2006 By Jervis
	ll_screen_id[1] = ii_screen_id
	//lnv_workflow.of_data_value_comparision( ii_screen_id, il_prac_id, ii_parent_facility_id, ls_module, 'I')
	lnv_workflow.of_data_value_comparision( ll_screen_id, il_prac_id, ii_parent_facility_id, ls_module, 'I')
	//12.13.2006 End

	Destroy lnv_workflow
	
	//Refresh Action Item Data
	if ls_module = "02" then
		parent_window.of_retrieve_net( )
	end if
End If
//End added 11.21.2006

//run data flow if any - dataflow: alfee 12.24.2009
inv_dataflow.of_run_data_flow()

//
// Add by andy 01/29/2010 V10.1 - Notification Alert
//
String	ls_table_name
n_cst_notification_alert_upd	lnv_na

ls_table_name = This.Object.DataWindow.Table.UpdateTable
lnv_na.of_update_alert_records(ls_table_name, This)

if  ii_screen_id = 2 then //Start Code Change ----09.30.2014 #V14.2 maha
	tab_view.tabpage_linked_data.enabled = true
end if


// Because I must check column status in the above function,
// I unextend ancestor script and call it at last.
Call Super::pfc_postupdate

Return 1

end event

event rbuttondown;call super::rbuttondown;integer col
integer ret
datetime dtn
string colname
STRING DT

setnull(dtn)

col = this.getclickedcolumn()
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.21.2006 By: Leiwei
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

event retrieveend;call super::retrieveend;if This.Describe("prac_id.ColType") <> "!" then //maha 051503 for lehigh
	this.Modify("prac_id.background.color = '12632256'")
	//this.Modify( "prac_id.TabSequence = 0" )
	//this.Modify( "prac_id.protect = 1" )
	//this.Modify( "prac_id.x = '2100'" )
	//this.Modify( "prac_id.y = '100'" )
end if

if This.Describe("rec_id.ColType") <> "!" then //maha 051503 
	this.Modify("rec_id.background.color = '12632256'")
	//this.Modify( "rec_id.TabSequence = 0" )
	//this.Modify( "rec_id.protect = 1" )
	//this.Modify( "prac_id.x = '2100'" )
	//this.Modify( "prac_id.y = '100'" )
end if

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 06/10/2008 By: Ken.Guo
//$<reason> Move script to function of_set_page_menu()
/*
// mskinner 13 Dec 2005 -- begin
if isvalid(m_pfe_cst_data_entry) then 
if this.rowcount() > 1 then 
 m_pfe_cst_data_entry.m_view.m_priorpage.enabled = true
 m_pfe_cst_data_entry.m_view.m_nextpage.enabled = true
else 
 m_pfe_cst_data_entry.m_view.m_priorpage.enabled = false
 m_pfe_cst_data_entry.m_view.m_nextpage.enabled = false
end if 
end if
// mskinner 13 Dec 2005 -- end
*/
of_refresh_page_menu() //Added By Ken.Guo 06.10.2008
//---------------------------- APPEON END ----------------------------

end event

event pfc_nextpage;return this.ScrollNextRow() //Added By Ken.Guo 06.06.2008
end event

event pfc_previouspage;return this.ScrollPriorRow() //Added By Ken.Guo 06.06.2008
end event

event doubleclicked;call super::doubleclicked;//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-08-12 By: Scofield
//$<Reason> Popup a dialog to input the phone.

String	ls_Name,ls_Mask,ls_Phone,ls_RetParm
long		ll_FieldID

if row > 0 and row <= This.RowCount() then
	ls_Name = dwo.name
	ll_FieldID = long(This.Describe(ls_Name + ".Tag"))
	
	SELECT field_mask INTO :ls_Mask FROM sys_fields WHERE field_id = :ll_FieldID and field_name = :ls_Name ;
	
	//if Trim(ls_Mask) = "(###)###-####" then
	if Trim(ls_Mask) = "INTPHONE" then  //Start Code Change ----02.02.2009 #V92 maha
	
		if gi_user_readonly = 1 then return  //alfee 12.30.2009
		
		If Long(This.Describe(ls_Name + ".TabSequence")) = 0 Then Return //Added by Appeon long.zhang 03.31.2016 (bug id 5075 phone format issue)
		
		ls_Phone = This.GetItemString(row,ls_Name)
		OpenWithParm(w_phonedetail,ls_Phone)
		
		ls_RetParm = Message.StringParm
		
		if ls_RetParm <> 'Cancel' then
			This.SetItem(row,ls_Name,ls_RetParm)
		end if
		This.SetColumn(ls_Name)
	end if
end if
//---------------------------- APPEON END ----------------------------

end event

event scrollvertical;call super::scrollvertical;Long ll_numrow
String ls_firstrow, ls_lastrow

  //Start Code Change ----05.09.2014 #V14.2 maha - facility specific screens

choose case ii_screen_id  
	case 2, 10, 19
		ls_lastrow = This.Object.Datawindow.LastRowOnPage
		ll_numrow = dw_browse.GetItemNumber(Long(ls_lastrow),"rec_id")
		dw_link_list.Retrieve(ll_numrow) 
	
end choose

	RETURN 0

end event

event resize;call super::resize;//alfee 05.12.2010

if of_get_ib_screen_painter() then return 0 //BugS081908 - alfee 08.26.2011

choose case ii_screen_id
	case 10,2,19 //address, hospital, specialty
		post of_detail_scrollbar(ii_screen_id) //resize the detail dw
	case else
		//
end choose
end event

event getfocus;call super::getfocus;//Start Code Change ----01.05.2015 #V14.2 maha
this.triggerevent("itemfocuschanged")
end event

event dragdrop;call super::dragdrop;//messagebox("dragdrop", "") //Comment by Appeon long.zhang 12.28.2015 (BugL122801)
//fails as the lookup window is responst type.
this.setitem(row, dwo.name, is_typedown_value)  //Start Code Change ----09.24.2015 #V15 maha
end event

type dw_browse from u_dw within pfc_cst_u_data_entry
event pfc_after_select ( )
integer x = 946
integer y = 104
integer width = 2775
integer height = 1868
integer taborder = 40
boolean hscrollbar = true
end type

event constructor;This.of_SetUpdateable(False)



end event

event doubleclicked;IF dw_detail.RowCount() > 0 THEN
	dw_detail.Visible = True
	dw_browse.Visible = False
	tab_view.SelectTab( 2 )
	dw_detail.PostEvent( "pfc_after_select" )
END IF



end event

event rowfocuschanged;call super::rowfocuschanged;boolean lb_getlinkdata
integer r

This.SelectRow( 0, False )   //Start Code Change ----01.20.2016 #V15 maha - removed
This.SelectRow( This.GetRow(), True )

st_recs.Text = "Record " + String(This.GetRow()) + " of " + String(This.RowCount())

IF dw_detail.GetRow() <> currentrow THEN
	dw_detail.ScrollToRow( currentrow )
	dw_detail.SetRow( currentrow )
END IF

IF currentrow > 0 THEN
	of_get_record_verif( currentrow )
END IF

IF currentrow > 0 THEN //maha 092701
	il_addr_id = dw_browse.getitemnumber(currentrow,"rec_id")
	//Start Code Change ----06.30.2014 #V14.2 maha
	if This.Describe("gp_id.ColType") <> "!" then
		il_gp_id = dw_browse.getitemnumber(currentrow,"gp_id")
	else
		il_gp_id = 0
	end if
	//Start Code Change ----01.12.2015 #V14.2 maha - retrieve only if office
	 //Start Code Change ----07.15.2014 #V14.2 maha
	if ii_screen_id = 2 and tab_view.selectedtab = 4 then 
		tab_view.tabpage_linked_data.uo_linked_data.il_prac_id = il_prac_id
		for r = 1 to dw_link_list.rowcount( )
			if dw_link_list.getitemnumber(r,"primary_office") = 1 then lb_getlinkdata = true
			if dw_link_list.getitemnumber(r,"additional_office") = 1 then lb_getlinkdata = true
		next
		if lb_getlinkdata then
			tab_view.tabpage_linked_data.uo_linked_data.of_get_data(il_addr_id, il_gp_id, ii_parent_facility_id) 
		else
			tab_view.tabpage_linked_data.uo_linked_data.dw_addr_head.reset()
			tab_view.tabpage_linked_data.uo_linked_data.dw_addr_head.insertrow(1)
			tab_view.tabpage_linked_data.uo_linked_data.dw_addr_head.setitem(1,"alias_name", "Link data is only added/displayed for Primary or Additional Office records")
			tab_view.tabpage_linked_data.uo_linked_data.dw_ids.reset()
			tab_view.tabpage_linked_data.uo_linked_data.dw_privs.reset()
			tab_view.tabpage_linked_data.uo_linked_data.dw_specs.reset()
		end if	
	end if
	 //End Code Change ----07.15.2014
	 //End Code Change ----01.12.2015
	 
	//End Code Change ----06.30.2014
end if
//\/maha 080200
//if is_screen_name = "Address" then

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-29
//$<modify> 2006-04-10 By: owen chen
//$<reason> Performance tuning modification
//$<modification> Add one more condition to reduces client-server interactions. 
/*
if ii_screen_id = 2 then
	dw_link_list.retrieve(il_addr_id)
end if
*/
if (ii_screen_id = 2) and (ib_addaddress = false) then
	If dw_link_list.dataobject = "d_addr_link_check_boxes" Then //this event may be triggered by sharedata function in inv_data_entry.of_create_dynamic_dw, and dw_link_list.dataobject is not right then, by Appeon long.zhang 04.16.2015 (V14.2 Bug # 4471 - DataWindow error when selecting facility specific data screens )
		dw_link_list.retrieve(il_addr_id)
	End If
end if
//---------------------------- APPEON END ----------------------------


//\maha
//\/maha 011601
//if is_screen_name = "Hospital Affiliation" then
if ii_screen_id = 10 then
	If dw_link_list.dataobject = "d_hosp_facil_link_de" Then //this event may be triggered by sharedata function in inv_data_entry.of_create_dynamic_dw, and dw_link_list.dataobject is not right then, by Appeon long.zhang 04.16.2015 (V14.2 Bug # 4471 - DataWindow error when selecting facility specific data screens )
		dw_link_list.retrieve(il_addr_id)
	End If
end if
//\maha
//\/maha 082001
//if is_screen_name = "Board/Specialty" then
if ii_screen_id = 19 then
	If dw_link_list.dataobject = "d_spec_facil_link_de" Then //this event may be triggered by sharedata function in inv_data_entry.of_create_dynamic_dw, and dw_link_list.dataobject is not right then, by Appeon long.zhang 04.16.2015 (V14.2 Bug # 4471 - DataWindow error when selecting facility specific data screens )
		dw_link_list.retrieve(il_addr_id)
	End If
end if
//\maha
end event

event pfc_addrow;dw_detail.ScrolltoRow(dw_detail.RowCount())
dw_detail.SetRow(dw_detail.RowCount())
dw_browse.Visible = False
dw_detail.Visible = True
tab_view.SelectTab( 2 )
dw_detail.Event pfc_addrow()
dw_detail.BringToTop = True

//IF is_screen_name = "Hospital Affiliation" or is_screen_name = "Address" or is_screen_name = "Board/Specialty" then //\/maha 082101 
IF ii_screen_id = 10 or ii_screen_id = 2 or ii_screen_id = 19 THEN
//if is_screen_name = "Hospital Affiliation" or is_screen_name = "Address" then
	dw_link_list.bringtotop = True
end if

Return 0
end event

event pfc_deleterow;Return of_delete_record( This )
end event

event pfc_nextpage;return this.ScrollNextRow() //Added By Ken.Guo 06.06.2008
end event

event pfc_previouspage;return this.ScrollPriorRow() //Added By Ken.Guo 06.06.2008
end event

event pfc_rowchanged;//Commented super code by (Appeon)Stephen 06.29.2017 - Bug ID #5715 for Case #00071338 Issue With IC
end event

event rowfocuschanging;//Commented super code by (Appeon)Stephen 06.29.2017 - Bug ID #5715 for Case #00071338 Issue With IC
end event

type tab_view from tab within pfc_cst_u_data_entry
event pfc_cst_after_select ( )
integer x = 937
integer y = 8
integer width = 2802
integer height = 1976
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
tabpage_details tabpage_details
tabpage_image tabpage_image
tabpage_linked_data tabpage_linked_data
end type

event pfc_cst_after_select;of_btt_address_link_button()

end event

event selectionchanging;//IF newindex = 3  THEN 
IF newindex = 3 or newindex = 4 THEN  //Start Code Change ----06.30.2014 #V14.2 maha
	IF dw_detail.GetItemStatus( dw_detail.GetRow(), 0, Primary!) = NewModified! OR +&
		dw_detail.GetItemStatus( dw_detail.GetRow(), 0, Primary!) = DataModified! THEN
		IF is_designer_type = "S" THEN
			IF parent_window.Event pfc_Save() < 0 THEN
				Return 1
			END IF
		ELSE
			IF parent_window_profile_design.Event pfc_Save() < 0 THEN
				Return 1
			END IF			
		END IF
	END IF
END IF

IF dw_detail.AcceptText() = -1 THEN
	Return 1
END IF
end event

event selectionchanged;Integer li_nr
integer r  // maha 01.12.2015
boolean lb_getlinkdata  // maha 01.12.2015

IF newindex = 1 THEN
	dw_detail.Visible = False
	dw_browse.Visible = True
	is_view_type = "B"
ELSEIF newindex = 2 THEN
	dw_browse.Visible = False
	dw_detail.Visible = True
	dw_detail.setfocus() //maha 102300
	is_view_type = "D"	
	This.PostEvent( "pfc_cst_after_select" )
	//dw_link_list.visible = false//maha 080200
ELSEIF newindex = 3 THEN
	dw_detail.Visible = False
	dw_browse.Visible = False
	dw_link_list.visible = False
	debugbreak()
	il_rec_id = dw_detail.GetItemNumber( dw_detail.GetRow(), "rec_id" )

	IF NOT IsNull( il_rec_id ) THEN  //filter for rec_id
		if ib_cert_period then  //Start Code Change ----11.14.2017 #V16 maha - code for certification period
			of_filter_cert_period(ii_screen_id, il_rec_id)
		else
			tab_view.tabpage_image.dw_detail_2.SetFilter( "rec_id = " + String( il_rec_id ) )
			tab_view.tabpage_image.dw_detail_2.Filter( )	
		end if
	ELSE
		if ib_cert_period then  //Start Code Change ----10.01.2017 #V16 maha - code for certification period
			//skip
		else
			li_nr = tab_view.tabpage_image.dw_detail_2.InsertRow( 0 )
			tab_view.tabpage_image.dw_detail_2.SetRow( li_nr )
			tab_view.tabpage_image.dw_detail_2.ScrollToRow( li_nr )
		end if
		//End Code Change ----10.01.2017
	END IF
	IF tab_view.tabpage_image.dw_detail_2.RowCount( ) = 0 THEN
		//Start Code Change ----11.08.2017 #V16 maha
		if ib_cert_period then
			//skip
		else
			tab_view.tabpage_image.dw_detail_2.InsertRow( 0 )
			tab_view.tabpage_image.dw_detail_2.SetItem( 1, "rec_id", il_rec_id )
			tab_view.tabpage_image.dw_detail_2.SetItem( 1, "prac_id", il_prac_id )
		end if
		//End Code Change ----11.08.2017
	END IF
	is_view_type = "D"	
	//Start Code Change ----10.01.2014 #V14.2 maha	
	parent_window.cb_delete.enabled = false  
	parent_window.cb_add.enabled = false 
	//End Code Change ----10.01.2014
ELSEIF newindex = 4 THEN  //Start Code Change ----03.10.2014 #V14.2 maha
	dw_detail.Visible = False
	dw_browse.Visible = False
	//dw_link_list.visible = False - handled in of_detail_scrollbar
	if ii_screen_id = 2 then  //Start Code Change ----07.20.2017 #V154 maha
		il_rec_id = dw_detail.GetItemNumber( dw_detail.GetRow(), "rec_id" )
		//Start Code Change ----01.12.2015 #V14.2 maha - set variable only for practices
		for r = 1 to dw_link_list.rowcount( )
			if dw_link_list.getitemnumber(r,"primary_office") = 1 then lb_getlinkdata = true
			if dw_link_list.getitemnumber(r,"additional_office") = 1 then lb_getlinkdata = true
		next
		//End Code Change ----01.12.2015
		//Start Code Change ----07.15.2014 #V14.2 maha
		tab_view.tabpage_linked_data.uo_linked_data.il_prac_id = il_prac_id
		 //Start Code Change ----01.12.2015 #V14.2 maha - retrieve only if office
		if lb_getlinkdata then
			tab_view.tabpage_linked_data.uo_linked_data.of_get_data(il_rec_id,il_gp_id,  ii_parent_facility_id) 
		else
			tab_view.tabpage_linked_data.uo_linked_data.dw_addr_head.reset()
			tab_view.tabpage_linked_data.uo_linked_data.dw_addr_head.insertrow(1)
			tab_view.tabpage_linked_data.uo_linked_data.dw_addr_head.setitem(1,"alias_name", "Link data is only added/displayed for Primary or Additional Office records")
			tab_view.tabpage_linked_data.uo_linked_data.dw_ids.reset()
			tab_view.tabpage_linked_data.uo_linked_data.dw_privs.reset()
			tab_view.tabpage_linked_data.uo_linked_data.dw_specs.reset()
		end if	
	else
		
	end if
	//End Code Change ----07.15.2014
	//Start Code Change ----10.01.2014 #V14.2 maha	
	parent_window.cb_delete.enabled = false  
	parent_window.cb_add.enabled = false 
	//End Code Change ----10.01.2014
END IF

//Start Code Change ----10.01.2014 #V14.2 maha
if ii_screen_id = 2 then
	choose case newindex
		case 1,2
			parent_window.cb_delete.enabled = true 
			parent_window.cb_add.enabled = true
	end choose
end if
//End Code Change ----10.01.2014

of_detail_scrollbar(ii_screen_id)

	

end event

on tab_view.create
this.tabpage_browse=create tabpage_browse
this.tabpage_details=create tabpage_details
this.tabpage_image=create tabpage_image
this.tabpage_linked_data=create tabpage_linked_data
this.Control[]={this.tabpage_browse,&
this.tabpage_details,&
this.tabpage_image,&
this.tabpage_linked_data}
end on

on tab_view.destroy
destroy(this.tabpage_browse)
destroy(this.tabpage_details)
destroy(this.tabpage_image)
destroy(this.tabpage_linked_data)
end on

type tabpage_browse from userobject within tab_view
integer x = 18
integer y = 100
integer width = 2766
integer height = 1860
long backcolor = 79741120
string text = "Browse"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 553648127
end type

type tabpage_details from userobject within tab_view
integer x = 18
integer y = 100
integer width = 2766
integer height = 1860
long backcolor = 79741120
string text = "Detail"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 553648127
end type

type tabpage_image from userobject within tab_view
integer x = 18
integer y = 100
integer width = 2766
integer height = 1860
long backcolor = 79741120
string text = "Detail 2"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 553648127
dw_detail_2 dw_detail_2
end type

on tabpage_image.create
this.dw_detail_2=create dw_detail_2
this.Control[]={this.dw_detail_2}
end on

on tabpage_image.destroy
destroy(this.dw_detail_2)
end on

type dw_detail_2 from u_dw within tabpage_image
integer width = 2766
integer height = 1836
integer taborder = 30
boolean bringtotop = true
end type

event constructor;call super::constructor;This.of_SetRowManager( TRUE )
This.of_SetReqColumn(TRUE)



end event

event pfc_preupdate;call super::pfc_preupdate;IF This.RowCount() > 0 THEN
	IF IsNull( This.GetItemNumber( 1, "rec_id" ) ) THEN
		This.SetItem( 1, "rec_id", il_rec_id )
		This.SetItem( 1, "prac_id", il_prac_id )	
	END IF
END IF

Return Success
end event

type tabpage_linked_data from userobject within tab_view
integer x = 18
integer y = 100
integer width = 2766
integer height = 1860
boolean border = true
long backcolor = 79741120
string text = "Linked Data"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
uo_linked_data uo_linked_data
uo_cert_period uo_cert_period
end type

on tabpage_linked_data.create
this.uo_linked_data=create uo_linked_data
this.uo_cert_period=create uo_cert_period
this.Control[]={this.uo_linked_data,&
this.uo_cert_period}
end on

on tabpage_linked_data.destroy
destroy(this.uo_linked_data)
destroy(this.uo_cert_period)
end on

type uo_linked_data from pfc_cst_u_address_linked_data within tabpage_linked_data
integer height = 1864
integer taborder = 20
end type

on uo_linked_data.destroy
call pfc_cst_u_address_linked_data::destroy
end on

type uo_cert_period from pfc_cst_u_cert_periods within tabpage_linked_data
boolean visible = false
integer x = 9
integer y = 4
integer taborder = 30
long backcolor = 32633316
end type

on uo_cert_period.destroy
call pfc_cst_u_cert_periods::destroy
end on

