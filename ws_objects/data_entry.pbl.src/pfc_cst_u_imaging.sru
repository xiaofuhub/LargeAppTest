$PBExportHeader$pfc_cst_u_imaging.sru
forward
global type pfc_cst_u_imaging from userobject
end type
type st_alert from statictext within pfc_cst_u_imaging
end type
type st_page from statictext within pfc_cst_u_imaging
end type
type tab_view from tab within pfc_cst_u_imaging
end type
type tabpage_browse from userobject within tab_view
end type
type ole_admin_pdf from u_image_edit_cp1 within tabpage_browse
end type
type ole_admin_count from olecustomcontrol within tabpage_browse
end type
type cb_ass_file from commandbutton within tabpage_browse
end type
type ole_thumb from olecustomcontrol within tabpage_browse
end type
type cb_find from commandbutton within tabpage_browse
end type
type sle_find_path from singlelineedit within tabpage_browse
end type
type st_path from statictext within tabpage_browse
end type
type ole_admin from olecustomcontrol within tabpage_browse
end type
type dw_browse from u_dw within tabpage_browse
end type
type lb_files from listbox within tabpage_browse
end type
type tabpage_browse from userobject within tab_view
ole_admin_pdf ole_admin_pdf
ole_admin_count ole_admin_count
cb_ass_file cb_ass_file
ole_thumb ole_thumb
cb_find cb_find
sle_find_path sle_find_path
st_path st_path
ole_admin ole_admin
dw_browse dw_browse
lb_files lb_files
end type
type tabpage_image from userobject within tab_view
end type
type ole_scanpdf_edit from u_image_edit_cp1 within tabpage_image
end type
type ole_scan_edit from olecustomcontrol within tabpage_image
end type
type cbx_1 from u_cbx within tabpage_image
end type
type tabpage_image from userobject within tab_view
ole_scanpdf_edit ole_scanpdf_edit
ole_scan_edit ole_scan_edit
cbx_1 cbx_1
end type
type tabpage_setup from userobject within tab_view
end type
type ole_admin1 from olecustomcontrol within tabpage_setup
end type
type cb_from_file from commandbutton within tabpage_setup
end type
type cb_remove from commandbutton within tabpage_setup
end type
type dw_image_list from u_dw within tabpage_setup
end type
type dw_image_data from u_dw within tabpage_setup
end type
type ole_scan from olecustomcontrol within tabpage_setup
end type
type cb_scan from commandbutton within tabpage_setup
end type
type cb_select from commandbutton within tabpage_setup
end type
type dw_data from u_dw within tabpage_setup
end type
type tabpage_setup from userobject within tab_view
ole_admin1 ole_admin1
cb_from_file cb_from_file
cb_remove cb_remove
dw_image_list dw_image_list
dw_image_data dw_image_data
ole_scan ole_scan
cb_scan cb_scan
cb_select cb_select
dw_data dw_data
end type
type tab_view from tab within pfc_cst_u_imaging
tabpage_browse tabpage_browse
tabpage_image tabpage_image
tabpage_setup tabpage_setup
end type
type ddlb_zoom from dropdownlistbox within pfc_cst_u_imaging
end type
type st_zoom from statictext within pfc_cst_u_imaging
end type
type st_format from statictext within pfc_cst_u_imaging
end type
type cbx_show from checkbox within pfc_cst_u_imaging
end type
type ddlb_format from dropdownlistbox within pfc_cst_u_imaging
end type
type st_recs from statictext within pfc_cst_u_imaging
end type
type cb_expand from commandbutton within pfc_cst_u_imaging
end type
end forward

global type pfc_cst_u_imaging from userobject
integer width = 3534
integer height = 2080
long backcolor = 16777215
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event pfc_cst_print_letters ( )
event pfc_cst_dial_phone ( )
event pfc_cst_goto_web ( )
event pfc_cst_npdb_export ( )
event pfc_cst_nextpage ( )
event pfc_cst_priorpage ( )
event pfc_cst_a_select ( )
event pfc_cst_a_highlight ( )
event pfc_cst_a_stamptext ( )
event pfc_cst_a_note ( )
event pfc_cst_a_delete ( )
event pfc_cst_save_image ( )
event pfc_cst_page_properties ( )
event pfc_cst_straighten_page ( )
event pfc_cst_rotate ( )
event ue_down_key pbm_dwnkey
event pfc_cst_undo ( )
event pfc_cst_email_documents ( )
event pfc_cst_delete_all ( )
event pfc_cst_image_utility ( )
event pfc_delete_all ( )
event pfc_cst_fax_image_documents ( )
event ue_extract_documents ( )
st_alert st_alert
st_page st_page
tab_view tab_view
ddlb_zoom ddlb_zoom
st_zoom st_zoom
st_format st_format
cbx_show cbx_show
ddlb_format ddlb_format
st_recs st_recs
cb_expand cb_expand
end type
global pfc_cst_u_imaging pfc_cst_u_imaging

type variables
Integer ii_modified = 0
Integer ii_image_utility_on = 0
Integer ii_image_storage_type = 0
integer ii_scanner_format = -1
Integer ii_fax_type
integer ii_set_59 = 0  //michael 01.30.2011 V11.2 ImagingFacility
Integer ii_num_pages
Integer ii_screen_id
Integer ii_data_view_id
Integer ii_parent_facility_id
Integer ii_verifiying_facility_id
Integer ii_start_page
Integer ii_current_page
Integer ii_facility_ids[]

Long il_exp_appt_ltr
long il_current_row, il_dispaly_row
Long il_prac_id
Long il_rec_id

Boolean ib_verify
boolean ib_new_row_added,ib_no_dialog = true
boolean ib_list_retrieved = true  //maha 07.06.2011
boolean ib_new

String is_image_path
String is_annotation_name
String is_status_filter 
String is_verif_filter 
String is_view_filter
String is_image_file_name
String is_last_file_path //alfee 05.11.2009
String is_display_doc_name

pfc_cst_nv_image_functions  inv_image_functions
pfc_n_cst_ai_action_items inv_action_items
pfc_cst_nv_data_entry_functions inv_dw
w_prac_data_1 iw_parent_window

String is_ext = 'PDF' //Added by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)

String is_scan_ext = 'PDF' //Added by (APPEON) Harry 11.13.2017 (V161 Storage of Documents as PDFs)




end variables

forward prototypes
public function integer of_set_prac_id (long al_prac_id)
public function integer of_set_parent (w_prac_data_1 aw_win)
public function integer of_set_verifying_facility_id (integer ai_verifying_facility_id)
public function integer of_display_doc (integer ai_from_page, integer ai_num_pages)
public function integer of_next_page ()
public function integer of_prior_page ()
public function integer of_enable_next_prev_buttons (string as_from_where)
public function integer of_print ()
public function integer of_batch_print ()
public function integer of_delete_image ()
public function integer of_add_annotation (string as_annotation_type)
public function integer of_page_properties ()
public function integer of_set_menu (integer ai_index)
public function integer of_undo ()
public function integer of_email_documents ()
public function integer of_delete_all_images ()
public function integer of_image_utility ()
public function integer of_fax_documents ()
public function integer of_check_for_null_start (integer ai_start)
public subroutine of_doubleclicked (u_dw adw)
public function integer of_print_image (integer al_start_page, integer al_pagecount)
public function integer of_check_page_count (integer ai_start, integer ai_image, integer ai_num_pages)
public function integer of_browse_select_row (integer ai_row, integer ai_param)
public function integer of_scanner_select ()
public function integer of_email_outlook ()
public function integer of_enable_next_prev_buttons (integer ai_index)
public function integer of_check_for_image ()
public function integer of_bg_color (long al_rgb)
public function integer of_set_alert_text (string as_text)
public function integer of_select_for_scanning ()
public function integer of_check_fac (string as_type)
public function integer of_set_historical ()
public function integer of_insert_pages (long al_row)
public function integer of_disable_buttons ()
public function integer of_button_visible (integer ai_index)
public function integer of_button_action (string as_button)
public function integer of_check_add (string as_from)
public function integer of_security_filter (datawindow adw_data)
public function integer of_user_date_stamp (string as_tempfile)
public function integer of_reset ()
public function integer of_post_resize ()
public function integer of_correct_image_connection (integer ai_row)
public subroutine of_zoom ()
public subroutine of_set_visible_pdf (boolean ab_visible)
public subroutine of_deletepages_pdf (olecustomcontrol ole_pdf, long start_page, long num_pages)
end prototypes

event pfc_cst_nextpage;IF tab_view.SelectedTab = 1 THEN
	tab_view.tabpage_browse.dw_browse.Event pfc_nextpage()
	of_enable_next_prev_buttons( "Browse" )	
ELSEIF tab_view.SelectedTab = 2 THEN
	of_next_page(  )
	of_enable_next_prev_buttons( "Image" )	
END IF

end event

event pfc_cst_priorpage;IF tab_view.SelectedTab = 1 THEN
	tab_view.tabpage_browse.dw_browse.Event pfc_previouspage()
	of_enable_next_prev_buttons( "Browse" )	
ELSEIF tab_view.SelectedTab = 2 THEN
	of_prior_page(  )
	of_enable_next_prev_buttons( "Image" )	
END IF
end event

event pfc_cst_a_select();of_add_annotation( "S" )
end event

event pfc_cst_a_highlight();of_add_annotation( "H" )
end event

event pfc_cst_a_stamptext;of_add_annotation( "T" )
end event

event pfc_cst_a_note();of_add_annotation( "N" )
end event

event pfc_cst_a_delete;of_add_annotation( "D" )
end event

event pfc_cst_save_image();Long ll_rec_id
Long ll_prac_id
Integer li_facility_id
Integer li_screen_id
Long ll_seq_no
Integer li_cr
String	ls_Rtn
String ls_filename  //Added by (APPEON) Harry 11.08.2017
//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-07-14 By: Scofield
//$<Reason> Verify if the directory has write right for the current user.

IF is_ext = 'PDF' THEN //Added by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)
	ls_filename = tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.Object.filename
	ls_Rtn = f_ExaWriteRight(ls_filename)
ELSE
	ls_Rtn = f_ExaWriteRight(tab_view.tabpage_image.ole_scan_edit.Object.Image)
END IF
if LenA(ls_Rtn) > 0 then
	MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
	SetRedraw(true)
	Return
end if

//---------------------------- APPEON END ----------------------------

// mskinner 09 March 2005 -- begin
TRY
	IF is_ext = 'PDF' THEN //Added by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)
		 tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.Object.Save(mid(ls_filename ,1,lastpos(ls_filename, '.') - 1), 'PDF' )
	ELSE
	  	 tab_view.tabpage_image.ole_scan_edit.Object.Save()
	END IF
CATCH (RunTimeError rte)
    		return 
END TRY

// mskinner 09 March 2005 -- end
	

//do this if images are saved in database
IF ii_image_storage_type = 1 THEN
	li_cr = tab_view.tabpage_browse.dw_browse.GetRow( )
	IF li_cr<1 THEN return //added by Nova 2010.05.19
	ll_rec_id = tab_view.tabpage_browse.dw_browse.GetItemNumber( li_cr, "pd_images_rec_id" )
	ll_prac_id = tab_view.tabpage_browse.dw_browse.GetItemNumber( li_cr, "pd_images_prac_id" )	
	li_facility_id = tab_view.tabpage_browse.dw_browse.GetItemNumber( li_cr, "pd_images_facility_id" )	
	li_screen_id = tab_view.tabpage_browse.dw_browse.GetItemNumber( li_cr, "pd_images_screen_id" )		
	ll_seq_no = tab_view.tabpage_browse.dw_browse.GetItemNumber( li_cr, "image_pk" )  //Start Code Change ----03.29.2011 #V11 maha - change from seq no
	inv_image_functions.of_save_image_to_db( ll_rec_id, ll_prac_id, li_facility_id, li_screen_id, ll_seq_no ,is_ext)  //Modified by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)	add is_ext		
END IF
end event

event pfc_cst_page_properties;of_page_properties()
end event

event pfc_cst_straighten_page();ii_modified = 1
pfc_cst_nv_image_functions image_functions
image_functions = CREATE pfc_cst_nv_image_functions
try 
image_functions.of_straighten_page( tab_view.tabpage_image.ole_scan_edit )
catch (runtimeerror tre)
end try

Destroy image_functions

end event

event pfc_cst_rotate();
try 
	IF is_ext = 'PDF' THEN //Added by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)
		tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.Object.Rotate(2)
	ELSE
		tab_view.tabpage_image.ole_scan_edit.Object.RotateLeft()
	END IF
catch (runtimeerror rte)
end try
ii_modified = 1
end event

event ue_down_key;
st_zoom.Text = String( key )
IF KeyDown( KeyDelete! ) THEN
	messagebox("","fdf")
	
END IF
end event

event pfc_cst_undo;of_undo()
end event

event pfc_cst_email_documents;of_email_documents( )
end event

event pfc_cst_delete_all;of_Delete_all_images()
end event

event pfc_cst_image_utility();IF ii_image_utility_on = 1 THEN
 	ii_image_utility_on = 0 
ELSE
	ii_image_utility_on = 1
END IF
of_image_utility( )
end event

event pfc_cst_fax_image_documents;of_fax_documents( )
end event

event ue_extract_documents();openwithparm(w_extract_prac_documents, il_prac_id )
end event

public function integer of_set_prac_id (long al_prac_id);integer li_success,li_set_59,i,li_rows,li_facility
integer li_r
string ls_facility,ls_filter
datastore lds_facility
datawindowchild ldw_child
//upper some define variable by APPEON michael 01-30-2011 update,V11.2 ImagingFacility 

il_prac_id = al_prac_id

of_image_utility( )

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<modify> 01.24.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Write script to retrieve data from a cache instead of from the database.
/*
SELECT ids.imaging_path  
INTO :is_image_path  
FROM ids  ;
*/
is_image_path = gnv_data.of_getitem("ids","imaging_path",false)
//---------------------------- APPEON END ----------------------------

//is_image_file_name = is_image_path + String( il_prac_id ) + ".tif"
is_image_file_name = is_image_path + String( il_prac_id ) + "." + is_ext  //Modified by (APPEON) Harry 11.14.2017 (V161 Storage of Documents as PDFs)
IF is_ext = 'PDF' THEN //Added by (APPEON) Harry 11.14.2017 (V161 Storage of Documents as PDFs)
	of_set_visible_pdf(True)
END IF

//------------------- APPEON BEGIN -------------------
//$<Add> Michael 01.30.2011
//$<reason> V11.2 ImagingFacility
li_success = tab_view.tabpage_browse.dw_browse.getchild('pd_images_facility_id',ldw_child)
IF li_success = 1 THEN
      ldw_child.settransobject(SQLCA)
	 ldw_child.retrieve(gs_user_id) 
	 ldw_child.insertrow(1)
	 ldw_child.setitem(1,'facility_id',0)
	 ldw_child.setitem(1,'facility_name','ALL')
END IF
//------------------- APPEON END ---------------------


//Start Code Change ---- 10.03.2006 #626 maha  moved retrieve outside of try/catch
tab_view.tabpage_browse.dw_browse.of_SetTransObject( SQLCA )


//Start Code Change ----12.04.2012 #V12 maha - image security
//tab_view.tabpage_browse.dw_browse.Retrieve( il_prac_id )
tab_view.tabpage_browse.dw_browse.Retrieve( il_prac_id , gs_user_id)
of_security_filter(tab_view.tabpage_browse.dw_browse )
//Start Code Change ----12.04.2012	

//Added by Appeon long.zhang 09.05.2014 (V14.2 Testing /Test ID 506 / Bug #4182)
tab_view.tabpage_browse.dw_browse.modify("b_select.text = 'Select All'")

//Start Code Change ---- 01.27.2006 #225 maha
tab_view.tabpage_setup.dw_data.reset()
ib_list_retrieved = true  //Start Code Change ----07.06.2011 #V11 maha - to avoid auto add when selecting the provider
//changing the row twice retrieves the dw_data regardless of the previous row selected
tab_view.tabpage_setup.dw_image_list.setrow(2)
ib_list_retrieved = true   //Start Code Change ----07.06.2011 #V11 maha 
tab_view.tabpage_setup.dw_image_list.setrow(1)
//End Code Change---.01.27.2006 


//------------------- APPEON BEGIN -------------------
//$<Add> Michael 01.30.2011
//$<reason> V11.2 ImagingFacility
IF ii_set_59 = 10 and ii_image_storage_type = 1 THEN
     ls_facility = '(0,'
	lds_facility = Create datastore
	lds_facility.dataobject = 'd_facility_byuserid'
	lds_facility.settransobject(SQLCA)
	lds_facility.retrieve(gs_user_id)
	li_rows = lds_facility.rowcount()
	For i = 1 to li_rows step 1
		 li_facility = lds_facility.getitemnumber(i,'facility_id')
		 ls_facility = ls_facility + string(li_facility) + ','
	NEXT
	 ls_facility = MidA(ls_facility,1,lastpos(ls_facility,',')-1)
     ls_facility = ls_facility + ')'

	//------------------- APPEON BEGIN -------------------
	//<$>Modified:long.zhang 03.30.2015
	//<$>reason:V14.1 Bug # 4465  created for Case# 00052938: Setting up image security 
	
	//ls_filter = 'pd_images_facility_id in ' + ls_facility
	ls_filter = tab_view.tabpage_browse.dw_browse.Describe("DataWindow.Table.Filter")
	If LenA(ls_filter) > 0 and ls_filter<>'?' Then
		ls_filter +=  ' and pd_images_facility_id in ' + ls_facility
	Else
		ls_filter =  'pd_images_facility_id in ' + ls_facility
	End If
	//------------------- APPEON END -------------------
	
     tab_view.tabpage_browse.dw_browse.SetFilter(ls_filter)
     tab_view.tabpage_browse.dw_browse.Filter( )
	 tab_view.tabpage_browse.dw_browse.setrow(1)
//	 tab_view.tabpage_browse.dw_browse.SelectRow(0, false)   //Start Code Change ----01.20.2016 #V15 maha - removed
//	 tab_view.tabpage_browse.dw_browse.selectrow(1,true)
				
	 IF isvalid(lds_facility) THEN
   	    destroy lds_facility
	 END IF
END IF
//------------------- APPEON END ---------------------


try 

IF is_ext = 'PDF' THEN //Added by (APPEON) Harry 11.14.2017 (V161 Storage of Documents as PDFs)
	tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.Object.FileName = ''
	tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.Object.LoadMultiPage(is_image_file_name, 1)
ELSE
	tab_view.tabpage_image.ole_scan_edit.Object.ClearDisplay(  ) //maha 061201
	tab_view.tabpage_image.ole_scan_edit.Object.Image( is_image_file_name )
	tab_view.tabpage_image.ole_scan_edit.Object.UndoLevels( 1 )
END IF

catch (runtimeerror a)
end try
//End Code Change---10.03.2006

Return 0
end function

public function integer of_set_parent (w_prac_data_1 aw_win);iw_parent_window = aw_win

Return 0
end function

public function integer of_set_verifying_facility_id (integer ai_verifying_facility_id);ii_verifiying_facility_id = ai_verifying_facility_id

//tab_view.tabpage_browse.dw_browse.of_SetUpdateAble( False )
tab_view.tabpage_browse.dw_browse.of_SetTransObject(SQLCA)

tab_view.tabpage_browse.dw_browse.of_SetSort( True )
tab_view.tabpage_browse.dw_browse.inv_sort.of_SetColumnnameSource( tab_view.tabpage_browse.dw_browse.inv_sort.HEADER )
tab_view.tabpage_browse.dw_browse.inv_sort.of_SetStyle( tab_view.tabpage_browse.dw_browse.inv_sort.DROPDOWNLISTBOX )
tab_view.tabpage_browse.dw_browse.inv_sort.of_SetColumnHeader( TRUE )

tab_view.tabpage_browse.dw_browse.of_SetRowManager( TRUE )

//tab_view.tabpage_browse.dw_browse.SelectRow( 1, True )   //Start Code Change ----01.20.2016 #V15 maha - removed

tab_view.tabpage_setup.dw_image_list.SetTransObject( SQLCA )

//Start Code Change ----12.04.2012 #V12 maha
//tab_view.tabpage_setup.dw_image_list.Retrieve()
tab_view.tabpage_setup.dw_image_list.Retrieve(gs_user_id)
of_security_filter(tab_view.tabpage_setup.dw_image_list )
//End Code Change ----12.04.2012


tab_view.tabpage_setup.dw_image_data.of_SetTransObject( SQLCA )

Return 0
end function

public function integer of_display_doc (integer ai_from_page, integer ai_num_pages);integer li_pagecount
Long ll_rec_id
Long ll_prac_id
Integer li_facility_id
Integer li_screen_id
Long ll_seq_no
Integer li_cr
integer c
boolean bt
//Start Code Change ---- 05.17.2006 #458 maha
string ls_file
string ls_ext //Added by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 09.27.2006 By: LeiWei
//$<reason> Performance tuning
//ls_file = gs_dir_path + "IntelliCred\temp.tif"
//---------------------------- APPEON END ----------------------------

//End Code Change---05.17.2006


ii_start_page = ai_from_page
ii_current_page = 1
ii_num_pages = ai_num_pages

IF is_ext = 'PDF' THEN //Added by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)
	tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.Object.FileName = ''
ELSE
	tab_view.tabpage_image.ole_scan_edit.Object.ClearDisplay(  ) //maha 061201
END IF
//The images are stored in the database
IF ii_image_storage_type = 1 THEN
	//--------------------------- APPEON BEGIN ---------------------------
	//$<comment> 09.27.2006 By: LeiWei
	//$<reason> Fix a defect.
	//bt = FileDelete( ls_file )
	//---------------------------- APPEON END ----------------------------
	
	//Start Code Change ---- 05.17.2006 #458 maha
	//Note ----03.29.2011 #V11 maha - all that is really needed now is the pk id but rather than rewrite the entire function just passing the parameter
	li_cr = tab_view.tabpage_browse.dw_browse.GetRow( )
	ll_rec_id = tab_view.tabpage_browse.dw_browse.GetItemNumber( li_cr, "pd_images_rec_id" )
	ll_prac_id = tab_view.tabpage_browse.dw_browse.GetItemNumber( li_cr, "pd_images_prac_id" )	
	li_facility_id = tab_view.tabpage_browse.dw_browse.GetItemNumber( li_cr, "pd_images_facility_id" )	
	li_screen_id = tab_view.tabpage_browse.dw_browse.GetItemNumber( li_cr, "pd_images_screen_id" )		
	ll_seq_no = tab_view.tabpage_browse.dw_browse.GetItemNumber( li_cr, "image_pk" )  //Start Code Change ----03.29.2011 #V11 maha - changed from seq no
	ls_ext = Upper(tab_view.tabpage_browse.dw_browse.GetItemString( li_cr, "image_ext" )) //Added by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)
//messagebox("","")

	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 08.12.2006 By: LeiWei
	//$<reason> Fix a defect.
	//inv_image_functions.of_retrieve_image_from_db( ll_rec_id, ll_prac_id, li_facility_id, li_screen_id, ll_seq_no )
	IF inv_image_functions.of_retrieve_image_from_db( ll_rec_id, ll_prac_id, li_facility_id, li_screen_id, ll_seq_no  ) = -1 THEN
		RETURN -1
	END IF

//Start Code Change ----03.29.2011 #V11 maha - changed file name
//	ls_file = gs_dir_path + "IntelliCred\images\" + String(ll_rec_id) + "_" + String(ll_prac_id) + "_" +&
//				String(li_facility_id) + "_" + String(li_screen_id) + "_" + String(ll_seq_no) + ".tif"
	ls_file = gs_temp_path + "images\" + String(ll_prac_id) + "_" + String(ll_seq_no) + "." + ls_ext    //Modified by (APPEON) Harry 11.08.2017  modify ".tif" into ls_ext

				
	is_display_doc_name = ls_file
	//---------------------------- APPEON END ----------------------------
	
	is_image_file_name = ls_file
	ii_start_page = 1
	is_ext = ls_ext //Added by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)
//The images are stored on the hard disk
ELSE
	is_image_file_name = is_image_path + String( il_prac_id ) + "." +  is_ext    //Modified by (APPEON) Harry 11.08.2017  modify ".tif" into is_ext
	c = of_check_for_null_start(ii_start_page) //maha 030405
	if c = -1 then return -1
END IF

IF NOT FileExists( is_image_file_name ) THEN
	IF ii_image_storage_type = 1 THEN
		MessageBox("Image File", "The image file " + ls_file + " does not exist,  Check to make sure the path exists or if the database record has an image stored in the image field." )
	ELSE
		MessageBox("Image File", "The image file " + is_image_file_name + " does not exist,  please check your image path in your Image Painter." )
	END IF
	Return -1
END IF

IF is_ext = 'TIF' THEN //Added by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)
	IF tab_view.tabpage_image.ole_scan_edit.Object.Image <> is_image_file_name OR ii_image_storage_type = 1 THEN
		tab_view.tabpage_image.ole_scan_edit.Object.ClearDisplay(  ) //maha 061201
		tab_view.tabpage_image.ole_scan_edit.Object.Image( is_image_file_name )
		tab_view.tabpage_image.ole_scan_edit.Object.UndoLevels( 1 )
	END IF
	
	li_pagecount = tab_view.tabpage_image.ole_scan_edit.Object.Pagecount()
ELSE
	IF tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.Object.filename<> is_image_file_name OR ii_image_storage_type = 1 THEN
		tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.Object.filename = ''
		tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.object.LoadMultiPage(is_image_file_name, ai_from_page)
	END IF
	li_pagecount = tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.Object.GetTotalPage()
END IF

IF ii_image_storage_type = 1 THEN
	ii_num_pages = li_pagecount
END IF
	
//IF stored on mapped drive then check this
IF ii_image_storage_type <> 1 THEN
	if ai_from_page >  li_pagecount then //maha 072202
		messagebox("Display Image error","Image page data does not match pagecount of image.  Unable to display selected image.")
		return -1
	end if
END IF

IF is_ext = 'TIF' THEN  //Modified by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)
	tab_view.tabpage_image.ole_scan_edit.Object.Page( ai_from_page )
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 2006-10-09 By: Liu Hongxin
	//$<reason> Modify according to new required and show huge.
	/*
	tab_view.tabpage_image.ole_scan_edit.Object.FitTo(1)
	*/
	tab_view.tabpage_image.ole_scan_edit.Object.FitTo(3)	//Actual Size
	//---------------------------- APPEON END ----------------------------
	//Start Code Change ---- 11.10.2005 #80 maha
	tab_view.tabpage_image.ole_scan_edit.Object.DisplayScaleAlgorithm = 4
	//End Code Change---11.10.2005 
	tab_view.tabpage_image.ole_scan_edit.Object.Display()
ELSE
	tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.object.View = 8
END IF
	
if ai_num_pages <> ii_num_pages or isnull(ai_num_pages) then ai_num_pages = ii_num_pages //(Appeon)Stephen 12.19.2016 - Bug id 5447 - Missing Page '1 of (number of pages)' when previewing from Provider Documents.
st_page.Text = "Page 1 of " + String( ai_num_pages )

of_enable_next_prev_buttons( "Image" )


Return 0
end function

public function integer of_next_page ();integer li_pagecount //maha 072202

//messagebox("num pages", ii_num_pages)
//messagebox("current page", ii_current_page)
IF of_check_for_image() = -1 THEN RETURN -1 //Nova 09.25.2009
IF ii_num_pages > ii_current_page THEN
	IF is_ext = 'PDF' THEN //Added by (APPEON) Harry 11.10.2017 (V161 Storage of Documents as PDFs)
		li_pagecount = tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.Object.GetTotalPage()
	ELSE
		li_pagecount = tab_view.tabpage_image.ole_scan_edit.Object.Pagecount()
	END IF
	if ii_start_page + ii_current_page >  li_pagecount then //maha 072202
		messagebox("Display Image error","Image page data exceeds pagecount of image.  Unable to display selected image.")
		return -1
	else
		ii_current_page ++
		IF is_ext = 'PDF' THEN //Added by (APPEON) Harry 11.10.2017 (V161 Storage of Documents as PDFs)
			tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.Object.LoadMultiPage (tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.object.filename, ii_current_page)
		ELSE
			tab_view.tabpage_image.ole_scan_edit.Object.Page( ii_start_page + ii_current_page -1 )
			tab_view.tabpage_image.ole_scan_edit.Object.Display()
		END IF
		//cb_previous.Enabled = True
//		IF ii_current_page = tab_view.tabpage_image.ole_scan_edit.Object.PageCount() THEN
//			//This.Enabled = False
//		ELSE
//			//this.enabled = True
//		END IF
		st_page.Text = "Page " + String( ii_current_page ) + " Of " + String( ii_num_pages )
	end if
END IF


Return 0
end function

public function integer of_prior_page ();IF of_check_for_image() = -1 THEN RETURN -1 //Nova 09.25.2009
IF ii_current_page > 1 THEN
	ii_current_page --
	IF is_ext = 'PDF' THEN //Added by (APPEON) Harry 11.10.2017 (V161 Storage of Documents as PDFs)
		tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.Object.LoadMultiPage (tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.object.filename, ii_current_page)
	ELSE
		tab_view.tabpage_image.ole_scan_edit.Object.Page( ii_start_page + ii_current_page -1 )
		tab_view.tabpage_image.ole_scan_edit.Object.Display()
	END IF
	//cb_previous.Enabled = True
//	IF ii_current_page = tab_view.tabpage_image.ole_scan_edit.Object.PageCount() THEN
//		//This.Enabled = False
//	ELSE
//		//this.enabled = True
//	END IF
	st_page.Text = "Page " + String( ii_current_page ) + " Of " + String( ii_num_pages )
END IF


Return 0
end function

public function integer of_enable_next_prev_buttons (string as_from_where);Integer li_current_row_page
Integer li_total_row_page

IF as_from_where = "Browse" THEN
	
	li_current_row_page = tab_view.tabpage_browse.dw_browse.GetRow()
	li_total_row_page = tab_view.tabpage_browse.dw_browse.RowCount()
	
	IF IsValid( m_pfe_cst_imaging ) THEN
		//---------Begin Modified by (Appeon)Harry 01.24.2014 for V142 ISG-CLX--------
		//m_pfe_cst_imaging.m_view.m_nextpage.enabled = False
		//m_pfe_cst_imaging.m_view.m_priorpage.enabled = False
		gnv_app.of_modify_menu_attr( m_pfe_cst_imaging.m_view.m_nextpage,'enabled', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_imaging.m_view.m_priorpage,'enabled', False)
		//---------End Modfiied ------------------------------------------------------
		
		iw_parent_window.cb_next.enabled = False  //add Michael 03.23.2012--BugM031201
		iw_parent_window.cb_prior.enabled = False  //add Michael 03.23.2012--BugM031201
		
		IF li_current_row_page < li_total_row_page THEN
			//---------Begin Modified by (Appeon)Harry 01.24.2014 for V142 ISG-CLX--------
			//m_pfe_cst_imaging.m_view.m_nextpage.enabled = True	
			gnv_app.of_modify_menu_attr( m_pfe_cst_imaging.m_view.m_nextpage,'enabled', True)	
			//---------End Modfiied ------------------------------------------------------
			iw_parent_window.cb_next.enabled = true  //add Michael 03.23.2012--BugM031201
		END IF

		IF li_current_row_page > 1 THEN
			//---------Begin Modified by (Appeon)Harry 01.24.2014 for V142 ISG-CLX--------
			//m_pfe_cst_imaging.m_view.m_priorpage.enabled = True
			gnv_app.of_modify_menu_attr( m_pfe_cst_imaging.m_view.m_priorpage,'enabled', True)
			//---------End Modfiied ------------------------------------------------------
			iw_parent_window.cb_prior.enabled = true  //add Michael 03.23.2012--BugM031201
		END IF
	END IF
ELSE

	IF IsValid( m_pfe_cst_imaging ) THEN
		//---------Begin Modified by (Appeon)Harry 01.24.2014 for V142 ISG-CLX--------
		//m_pfe_cst_imaging.m_view.m_nextpage.enabled = False
		//m_pfe_cst_imaging.m_view.m_priorpage.enabled = False
		gnv_app.of_modify_menu_attr( m_pfe_cst_imaging.m_view.m_nextpage,'enabled', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_imaging.m_view.m_priorpage,'enabled', False)
		//---------End Modfiied ------------------------------------------------------
		iw_parent_window.cb_next.enabled = False  //add Michael 03.23.2012--BugM031201
		iw_parent_window.cb_prior.enabled = False  //add Michael 03.23.2012--BugM031201

		IF ii_current_page < ii_num_pages THEN
			//---------Begin Modified by (Appeon)Harry 01.24.2014 for V142 ISG-CLX--------
			//m_pfe_cst_imaging.m_view.m_nextpage.enabled = True	
			gnv_app.of_modify_menu_attr( m_pfe_cst_imaging.m_view.m_nextpage,'enabled', True)	
			//---------End Modfiied ------------------------------------------------------
			iw_parent_window.cb_next.enabled = true  //add Michael 03.23.2012--BugM031201			
		END IF

		IF ii_current_page > 1 THEN
			//---------Begin Modified by (Appeon)Harry 01.24.2014 for V142 ISG-CLX--------
			//m_pfe_cst_imaging.m_view.m_priorpage.enabled = True		
			gnv_app.of_modify_menu_attr( m_pfe_cst_imaging.m_view.m_priorpage,'enabled', True)
			//---------End Modfiied ------------------------------------------------------
			iw_parent_window.cb_prior.enabled =true  //add Michael 03.23.2012--BugM031201
		END IF
	END IF

END IF

Return 1
end function

public function integer of_print ();//maha created 071105 for print screens
//Start Code Change ----10.03.2011 #V12 maha - modify to show print dialog box`
boolean lb_dialog = false

if gi_print_dialog = 1 then
	lb_dialog = true
end if

IF tab_view.SelectedTab = 1 THEN
	//tab_view.tabpage_browse.dw_browse.Print( True )
	tab_view.tabpage_browse.dw_browse.of_print( True,lb_dialog) //Change the "print" to "of_print" - alfee 01.05.2012
ELSEIF tab_view.SelectedTab = 2 THEN
	
END IF
//End Code Change ----10.03.2011

Return 1
end function

public function integer of_batch_print ();Integer li_current_row
Integer li_rc
Integer i
Integer li_start_page
Integer li_to_page
Integer li_pagecount
Long ll_rec_id
Long ll_prac_id
Integer li_facility_id
Integer li_screen_id
Long ll_seq_no

if not isvalid(inv_image_functions ) then
	inv_image_functions = create pfc_cst_nv_image_functions
end if 

IF tab_view.SelectedTab = 1 THEN
	li_rc = tab_view.tabpage_browse.dw_browse.RowCount()

	tab_view.tabpage_browse.dw_browse.AcceptText()

	FOR i = 1 TO li_rc
		IF tab_view.tabpage_browse.dw_browse.GetItemNumber( i, "selected" ) = 1 THEN
			IF ii_image_storage_type = 1 THEN
				//scroll to the row
				tab_view.tabpage_browse.dw_browse.SetRow( i )
				//use the display function to display image
				of_display_doc( 1,1 )
				//print it out
				
				//--------------------------- APPEON BEGIN ---------------------------
				//$<modify> 01/11/2008 By: Ken.Guo
				//$<reason> Add Try...Catch
				//li_pagecount = tab_view.tabpage_image.ole_scan_edit.Object.Pagecount()		
				Try
					IF is_ext = 'PDF' THEN //Added by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)
						li_pagecount = tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.Object.GetTotalPage()
					ELSE
						li_pagecount = tab_view.tabpage_image.ole_scan_edit.Object.Pagecount()		
					END IF
				Catch(OLERuntimeError err)
					Continue
				End Try
				//---------------------------- APPEON END ----------------------------

				//tab_view.tabpage_image.ole_scan_edit.Object.PrintImage( 1, li_pagecount, 3)
				// mskinner 17 Aug 2005 -- begin
				of_print_image(1 ,li_pagecount)
				// mskinner 17 Aug 2005 -- end
				
			ELSE
				//--------------------------- APPEON BEGIN ---------------------------
				//$<modify> 01/11/2008 By: Ken.Guo
				//$<reason> Add Try...Catch
				//li_pagecount = tab_view.tabpage_image.ole_scan_edit.Object.Pagecount()
				Try
					IF is_ext = 'PDF' THEN //Added by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)
						li_pagecount = tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.Object.GetTotalPage()
					ELSE
						li_pagecount = tab_view.tabpage_image.ole_scan_edit.Object.Pagecount()
					END IF
				Catch(OLERuntimeError err1)
					Continue
				End Try
				//---------------------------- APPEON END ----------------------------
			
				li_start_page = tab_view.tabpage_browse.dw_browse.GetItemNumber( i, "start_page" ) 
				li_to_page = li_start_page + tab_view.tabpage_browse.dw_browse.GetItemNumber( i, "num_pages" ) - 1
				if li_to_page >  li_pagecount then //maha 072202
					messagebox("Print Image error","Image page data exceeds pagecount of image.  Unable to print a selected image.")
					return -1
				else
					//tab_view.tabpage_image.ole_scan_edit.Object.PrintImage( li_start_page, li_to_page, 3)
					// mskinner 17 Aug 2005 -- begin
					of_print_image(li_start_page ,li_to_page)
					// mskinner 17 Aug 2005 -- end
				end if
			END IF
		END IF
	END FOR	

	FOR i = 1 TO li_rc
		tab_view.tabpage_browse.dw_browse.SetItem( i, "selected", 0 ) 
	END FOR
ELSE
	IF ii_image_storage_type = 1 THEN
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 01/11/2008 By: Ken.Guo
		//$<reason> Add Try...Catch
		//li_pagecount = tab_view.tabpage_image.ole_scan_edit.Object.Pagecount()		
		Try 
			IF is_ext = 'PDF' THEN //Added by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)
				li_pagecount = tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.Object.GetTotalPage()
			ELSE
				li_pagecount = tab_view.tabpage_image.ole_scan_edit.Object.Pagecount()
			END IF
		Catch(OleRuntimeError err2)
			Return -1
		End Try
		//---------------------------- APPEON END ----------------------------

		//tab_view.tabpage_image.ole_scan_edit.Object.PrintImage( 1, li_pagecount, 3)
		// mskinner 17 Aug 2005 -- begin
		of_print_image(1 ,li_pagecount)
		// mskinner 17 Aug 2005 -- end
	ELSE
		li_current_row = tab_view.tabpage_browse.dw_browse.GetRow()
		li_start_page = tab_view.tabpage_browse.dw_browse.GetItemNumber( li_current_row, "start_page" ) 
		li_to_page = li_start_page + tab_view.tabpage_browse.dw_browse.GetItemNumber( li_current_row, "num_pages" ) - 1 
		// mskinner 17 Aug 2005 -- begin
		of_print_image(li_start_page ,li_to_page)
		// mskinner 17 Aug 2005 -- end
		//tab_view.tabpage_image.ole_scan_edit.Object.PrintImage( li_start_page, li_to_page, 3)				
	END IF
END IF


Return 1
end function

public function integer of_delete_image ();Integer li_rc
Integer li_rcdel
Integer i
Integer li_cr
Integer d
Integer li_start_page
Integer li_start_check
Integer li_num_page
Integer li_ans
integer li_checkrow
integer li_pagecount  //maha 072202
integer ck1
integer ck2
integer res
Long ll_rec_id
Long ll_prac_id
Integer li_facility_id
Long ll_seq_no
Integer li_screen_id
Blob lb_null_image
String is_doc_id 
String ls_Rtn

SetNull( lb_null_image )

li_ans = MessageBox( "Delete", "Are you absolutely positive you want to delete the selected images?", Question!, YesNo!, 2 )
IF li_ans = 2 THEN
	Return -1
END IF
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02
//$<add> 2005-11-16 By: Liang QingShi
//$<reason> Fix a defect in the original unmodified PowerBuilder applciation.
//$<modification> Add a condition to ensure that when no iamge is selected, the applciation cannot perform a deletion.
if tab_view.tabpage_browse.dw_browse.getrow() <= 0 then return -1
//---------------------------- APPEON END ----------------------------

IF tab_view.SelectedTab = 2 THEN
	tab_view.tabpage_browse.dw_browse.SetItem( tab_view.tabpage_browse.dw_browse.GetRow(), "selected", 1 )
END IF

IF is_ext = 'PDF' THEN //Added by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)
	tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.Object.filename = ''
ELSE
	tab_view.tabpage_image.ole_scan_edit.Object.ClearDisplay(  )
END IF
//--------------------------- APPEON BEGIN ---------------------------
//$<reason> Image_file_name may is not exist, Need add trap - Ken.Guo 01/12/2008
/* tab_view.tabpage_browse.ole_admin.Object.Image( is_image_file_name )
li_pagecount = tab_view.tabpage_browse.ole_admin.Object.pagecount() */
If ii_image_storage_type <> 1 Then //If stored on the hard disk do this
	//-------Begin Added by Alfee 11.06.2009 -------------
	//Verify if the directory has write right for the current user.
	ls_Rtn = f_ExaWriteRight(is_image_file_name)
	if LenA(ls_Rtn) > 0 then
		MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
		Return -1
	end if
	//-------End Added ------------------------------------
	Try
		IF is_ext = 'PDF' THEN //Added by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)
			tab_view.tabpage_browse.ole_admin_pdf.ole_edit.Object.LoadMultiPage(is_image_file_name, 1) 
			li_pagecount = tab_view.tabpage_browse.ole_admin_pdf.ole_edit.Object.GetTotalPage ()
		ELSE
			tab_view.tabpage_browse.ole_admin.Object.Image( is_image_file_name )
			li_pagecount = tab_view.tabpage_browse.ole_admin.Object.pagecount()	
		END IF
	Catch(OLERuntimeError Err)
		Messagebox("Delete Image error","The image file " + is_image_file_name + " does not exist,  please check your image path in your Image Painter.")
		Return -1
	End Try
End If
//---------------------------- APPEON END ----------------------------

IF is_ext = 'PDF' THEN //Added by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)
	tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.Object.filename = ''
ELSE
	tab_view.tabpage_image.ole_scan_edit.Object.ClearDisplay(  )
END IF

li_rc = tab_view.tabpage_browse.dw_browse.RowCount()

tab_view.tabpage_browse.dw_browse.AcceptText()

tab_view.tabpage_browse.dw_browse.setsort("start_page") //maha app093005 trap if records have been sorted
tab_view.tabpage_browse.dw_browse.sort()

IF NOT IsValid(w_dm_image_cp) THEN Open(w_dm_image_cp)  //Added by (APPEON) Harry 11.10.2017 (V161 Storage of Documents as PDFs)
FOR i = li_rc TO 1 step -1 //delete image  modified maha110702
	li_checkrow = tab_view.tabpage_browse.dw_browse.GetItemNumber( i, "selected" )
	
	IF li_checkrow = 1 THEN
		//stored in database
		IF ii_image_storage_type = 1 THEN
			inv_dw.of_field_audit_delete_last(tab_view.tabpage_browse.dw_browse, i) //(Appeon)Stephen 10.31.2016 - V15.3-Image Auditing in IntelliCred
			tab_view.tabpage_browse.dw_browse.DeleteRow( i )			
		ELSE
			//if stored on the hard disk do this
			IF is_ext = 'PDF' THEN //Added by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)
				li_pagecount = tab_view.tabpage_browse.ole_admin_pdf.ole_edit.Object.GetTotalPage ()
			ELSE
				li_pagecount = tab_view.tabpage_browse.ole_admin.Object.pagecount()
			END IF
			li_start_page = tab_view.tabpage_browse.dw_browse.GetItemNumber( i, "start_page" ) 
			li_num_page = tab_view.tabpage_browse.dw_browse.GetItemNumber( i, "num_pages" )
			if li_start_page + li_num_page - 1 >  li_pagecount  then //maha 072202 to trap for image pages that do not exist
				res = messagebox("Delete Image error","Image page data does not match pagecount of image.  Unable to delete some or all pages of the selected image at row " + string(i) + ".~rDo you want to continue and delete the data record?",question!,yesno!,2)
				if res = 1 then //if delete
					inv_dw.of_field_audit_delete_last(tab_view.tabpage_browse.dw_browse, i) //(Appeon)Stephen 10.31.2016 - V15.3-Image Auditing in IntelliCred
					tab_view.tabpage_browse.dw_browse.DeleteRow( i )
					if li_start_page <=  li_pagecount then  //maha added 042103 to delete whatever image pages might exist even if all do not.
						IF is_ext = 'PDF' THEN //Added by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)
							w_dm_image_cp.of_delete_page_pdf(tab_view.tabpage_browse.ole_admin_pdf.ole_edit.object.FileName, li_start_page, li_pagecount)
						ELSE
							tab_view.tabpage_browse.ole_admin.Object.DeletePages( li_start_page, li_pagecount )
						END IF
					end if
				end if
			elseif isnull(li_start_page) or li_start_page < 1 then //trap added maha 041404 4.181
				res = messagebox("Delete Image error","There is no Start page data value to connect to the image file.~rDo you want to continue and delete the data record?",question!,yesno!,1)
				if res = 1 then //if delete
					inv_dw.of_field_audit_delete_last(tab_view.tabpage_browse.dw_browse, i) //(Appeon)Stephen 10.31.2016 - V15.3-Image Auditing in IntelliCred
					tab_view.tabpage_browse.dw_browse.DeleteRow( i )
				end if
			else 
				IF is_ext = 'PDF' THEN //Added by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)
					w_dm_image_cp.of_delete_page_pdf(tab_view.tabpage_browse.ole_admin_pdf.ole_edit.object.FileName, li_start_page, li_pagecount)
				ELSE
					tab_view.tabpage_browse.ole_admin.Object.DeletePages( li_start_page, li_num_page )
				END IF
				
				inv_dw.of_field_audit_delete_last(tab_view.tabpage_browse.dw_browse, i) //(Appeon)Stephen 10.31.2016 - V15.3-Image Auditing in IntelliCred
				tab_view.tabpage_browse.dw_browse.DeleteRow( i )
			end if
		END IF		
	END IF
END FOR
IF IsValid(w_dm_image_cp) THEN Close(w_dm_image_cp)  //Added by (APPEON) Harry 11.10.2017 (V161 Storage of Documents as PDFs)

//if the image is not stored in db then do this...
IF ii_image_storage_type <> 1 THEN
	li_rc = tab_view.tabpage_browse.dw_browse.RowCount()
	li_start_check = 1
	if li_rc > 0 then //reset startpages data modified maha110702
		FOR i = 1 to li_rc 
			tab_view.tabpage_browse.dw_browse.setItem( i, "start_page",li_start_check)	
			li_num_page = tab_view.tabpage_browse.dw_browse.GetItemNumber( i, "num_pages" )
			li_start_check = li_start_check + li_num_page	//set start for next record
		END FOR
	end if
END IF

IF li_rc > 0 THEN
	tab_view.tabpage_browse.dw_browse.ScrollToRow( 1 )
	tab_view.tabpage_browse.dw_browse.SetRow( 1 )
//	tab_view.tabpage_browse.dw_browse.SelectRow( 0, false ) // Add by Evan 05.07.2009 --- BugK091204   //Start Code Change ----01.20.2016 #V15 maha - removed
//	tab_view.tabpage_browse.dw_browse.SelectRow( 1, True )
	tab_view.tabpage_browse.dw_browse.SetFocus()
END IF
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-03
//$<add> 02.20.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
gnv_appeondb.of_autocommit()
//---------------------------- APPEON END ----------------------------

tab_view.tabpage_browse.dw_browse.Update()

COMMIT USING SQLCA;

tab_view.SelectTab( 1 )

Return 1


end function

public function integer of_add_annotation (string as_annotation_type);string ls_group

//Start Code Change ----03.28.2012 #V12 maha - modifed so that annotations are given different names; when deleting, all were deleted.
ls_group = string(time(now()))

try

//tab_view.tabpage_image.ole_scan_edit.Object.SetCurrentAnnotationGroup( "image_annotations" )
tab_view.tabpage_image.ole_scan_edit.Object.SetCurrentAnnotationGroup( ls_group )
//End Code Change ----03.28.2012

CHOOSE CASE Upper( as_annotation_type )
		//select
	CASE "S"
		tab_view.tabpage_image.ole_scan_edit.Object.Annotationtype(11)	
		//highlight
	CASE "H"
		tab_view.tabpage_image.ole_scan_edit.Object.AnnotationFillColor( 8454143 )
		tab_view.tabpage_image.ole_scan_edit.Object.Annotationtype(4)	
		//note
	CASE "N"
		tab_view.tabpage_image.ole_scan_edit.Object.Annotationtype(10)	
		//textstamp
	CASE "T"
		//tab_view.tabpage_image.ole_scan_edit.object.ShowRubberStampDialog
		tab_view.tabpage_image.ole_scan_edit.Object.AnnotationStampText( "Testing stamp text" )		
		tab_view.tabpage_image.ole_scan_edit.Object.Annotationtype(8)	
	CASE "D"
		tab_view.tabpage_image.ole_scan_edit.Object.DeleteAnnotationGroup( is_annotation_name )	
		ii_modified = 1		
	CASE "P"
		tab_view.tabpage_image.ole_scan_edit.Object.object.ShowAttribsDialog(1)
END CHOOSE

catch (runtimeerror a)
	
end try

// mskinner 09 March 2005 -- end

Return 1
end function

public function integer of_page_properties ();//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 01/11/2008 By: Ken.Guo
//$<reason> Add Trap for fix issue.
//tab_view.tabpage_image.ole_scan_edit.Object.ShowPageProperties( False )
Try
	tab_view.tabpage_image.ole_scan_edit.Object.ShowPageProperties( False )
Catch(OleRuntimeError err)
	Return -1
End Try
//---------------------------- APPEON END ----------------------------

Return 1
end function

public function integer of_set_menu (integer ai_index);IF ai_index = 1  THEN
	st_recs.Visible = True
	st_page.Visible = False
	cbx_show.Visible = False
	st_zoom.Visible = False
	ddlb_zoom.Visible = False
	cb_expand.Visible = False  //Start Code Change ----07.15.2011 #V11 maha 
	ddlb_format.visible = false  //Start Code Change ----09.03.2009 #V92 maha
	st_format.visible = false //Start Code Change ----09.03.2009 #V92 maha
	st_recs.Text = "Record " + String( tab_view.tabpage_browse.dw_browse.GetRow() ) +&
	" of " + String( tab_view.tabpage_browse.dw_browse.RowCount() )	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 2006-11-14 By: Allen
	//$<reason> Fix APB Bug: the Toolbar Icon is invalid.
	//	w_mdi.ChangeMenu( m_pfe_cst_imaging_browse ) 
	//----------Begin Modified by Alfee on 10.13.2008 ------------------	
	IF w_mdi.menuname <> 'm_pfe_cst_imaging_browse' THEN
		w_mdi.ChangeMenu( m_pfe_cst_imaging_browse )
		of_enable_next_prev_buttons(ai_index)
		w_mdi.of_menu_security('m_pfe_cst_imaging_browse')
	END IF

	//IF w_mdi.menuname <> 'm_pfe_cst_imaging_browse' Then w_mdi.ChangeMenu( m_pfe_cst_imaging_browse )
	//-----------End Modified ------------------------------------------
	//---------------------------- APPEON END ----------------------------
	//Start Code Change ----10.30.2012 #V12 maha - childrens hosp customization
	if gb_use_prac_toolbar = true then
		IF IsValid( m_pfe_cst_imaging_browse ) THEN
			m_pfe_cst_imaging.m_file.m_saveimage.visible = False		
			m_pfe_cst_imaging.m_file.m_save.visible = True
			
			m_pfe_cst_imaging.m_edit.m_annotations.m_select.enabled = False
			m_pfe_cst_imaging.m_edit.m_annotations.m_select.toolbaritemvisible= False		
			m_pfe_cst_imaging.m_edit.m_annotations.m_highlight.enabled = False
			m_pfe_cst_imaging.m_edit.m_annotations.m_highlight.toolbaritemvisible= False		
			m_pfe_cst_imaging.m_edit.m_annotations.m_note.enabled = False
			m_pfe_cst_imaging.m_edit.m_annotations.m_note.toolbaritemvisible= False		
			m_pfe_cst_imaging.m_edit.m_annotations.m_stamptext.enabled = False
			m_pfe_cst_imaging.m_edit.m_annotations.m_stamptext.toolbaritemvisible= False				
			m_pfe_cst_imaging.m_edit.m_annotations.visible = False
			m_pfe_cst_imaging.m_edit.m_annotations.toolbaritemvisible= False	
			
			m_pfe_cst_imaging.m_view.m_priorpage.toolbaritemvisible= True
			m_pfe_cst_imaging.m_view.m_nextpage.toolbaritemvisible= True
			m_pfe_cst_imaging.m_file.m_print.enabled = True
			m_pfe_cst_imaging.m_file.m_print.toolbaritemvisible = True
			m_pfe_cst_imaging.m_file.m_batchprint.enabled = True
			m_pfe_cst_imaging.m_file.m_batchprint.toolbaritemvisible = True
			m_pfe_cst_imaging.m_file.m_save.toolbaritemvisible = True
			m_pfe_cst_imaging.m_file.m_save.toolbaritemvisible = True
			m_pfe_cst_imaging.m_edit.m_delete1.toolbaritemvisible = True
			m_pfe_cst_imaging.m_file.m_batchprint.toolbaritemvisible = True		
			m_pfe_cst_imaging.m_file.m_emailimage.toolbaritemvisible = True
			m_pfe_cst_imaging_browse.m_file.m_faximage.toolbaritemvisible = True
		END IF
	end if
	//Start Code Change ----10.30.2012
	tab_view.tabpage_browse.dw_browse.SetFocus()
ELSEIF ai_index = 2 THEN
	st_recs.Visible = False
	st_page.Visible = True	
	//cbx_show.Visible = True	
	IF UPPER(is_ext) <> 'PDF' THEN cbx_show.Visible = True	//Modified by (APPEON) Harry 11.20.2017 (V161 Storage of Documents as PDFs)
	st_zoom.Visible = True
	cb_expand.Visible = True  //Start Code Change ----07.15.2011 #V11 maha 
	ddlb_zoom.Visible = True
	ddlb_format.visible = false
	st_format.visible = false
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 2006-11-14 By: Allen
	//$<reason> Fix APB Bug: the Toolbar Icon is invalid.
	//	w_mdi.ChangeMenu( m_pfe_cst_imaging_view )
	//----------Begin Modified by Alfee on 10.13.2008 ------------------	
	IF w_mdi.menuname <> 'm_pfe_cst_imaging_view' THEN
		w_mdi.ChangeMenu( m_pfe_cst_imaging_view )
		of_enable_next_prev_buttons(ai_index)
		w_mdi.of_menu_security('m_pfe_cst_imaging_view')
	END IF
	//	If w_mdi.menuname <> 'm_pfe_cst_imaging_view' Then w_mdi.ChangeMenu( m_pfe_cst_imaging_view )
	//-----------End Modified ------------------------------------------
	//---------------------------- APPEON END ----------------------------
	//Start Code Change ----10.30.2012 #V12 maha - childrens hosp customization
	if gb_use_prac_toolbar = true then
		IF IsValid( m_pfe_cst_imaging_view ) THEN
			m_pfe_cst_imaging.m_file.m_saveimage.visible = True		
		  	m_pfe_cst_imaging.m_file.m_save.visible = False		
						
			m_pfe_cst_imaging.m_file.m_print.enabled = False
			m_pfe_cst_imaging.m_file.m_print.toolbaritemvisible = False
			m_pfe_cst_imaging.m_file.m_batchprint.enabled = True
			m_pfe_cst_imaging.m_file.m_batchprint.toolbaritemvisible = True		
			m_pfe_cst_imaging.m_file.m_save.toolbaritemvisible = False
			m_pfe_cst_imaging.m_file.m_saveimage.toolbaritemvisible = True
			m_pfe_cst_imaging.m_edit.m_delete1.toolbaritemvisible = False
			m_pfe_cst_imaging.m_file.m_batchprint.toolbaritemvisible = True		
			m_pfe_cst_imaging.m_file.m_emailimage.toolbaritemvisible = False
			//m_pfe_cst_imaging_browse.m_file.m_faximage.toolbaritemvisible = False
			m_pfe_cst_imaging.m_view.m_priorpage.toolbaritemvisible= True
			m_pfe_cst_imaging.m_view.m_nextpage.toolbaritemvisible= True
			
			m_pfe_cst_imaging.m_edit.m_annotations.m_select.enabled = True
			m_pfe_cst_imaging.m_edit.m_annotations.m_select.toolbaritemvisible= True
			m_pfe_cst_imaging.m_edit.m_annotations.m_highlight.enabled = True
			m_pfe_cst_imaging.m_edit.m_annotations.m_highlight.toolbaritemvisible= True		
			m_pfe_cst_imaging.m_edit.m_annotations.m_note.enabled = True
			m_pfe_cst_imaging.m_edit.m_annotations.m_note.toolbaritemvisible= True		
			m_pfe_cst_imaging.m_edit.m_annotations.m_stamptext.enabled = True
			m_pfe_cst_imaging.m_edit.m_annotations.m_stamptext.toolbaritemvisible= True						
			m_pfe_cst_imaging.m_edit.m_annotations.visible = True				
			m_pfe_cst_imaging.m_edit.m_annotations.toolbaritemvisible= True		
		END IF
		
		
	end if
	
	IF is_ext='PDF' THEN//Added by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)
		IF IsValid( m_pfe_cst_imaging_view ) THEN
			m_pfe_cst_imaging_view.m_edit.m_annotations.m_select.enabled = False
			m_pfe_cst_imaging_view.m_edit.m_annotations.m_select.toolbaritemvisible= False
			m_pfe_cst_imaging_view.m_edit.m_annotations.m_highlight.enabled = False
			m_pfe_cst_imaging_view.m_edit.m_annotations.m_highlight.toolbaritemvisible= False		
			m_pfe_cst_imaging_view.m_edit.m_annotations.m_note.enabled = False
			m_pfe_cst_imaging_view.m_edit.m_annotations.m_note.toolbaritemvisible= False		
			m_pfe_cst_imaging_view.m_edit.m_annotations.m_stamptext.enabled = False
			m_pfe_cst_imaging_view.m_edit.m_annotations.m_stamptext.toolbaritemvisible= False						
			m_pfe_cst_imaging_view.m_edit.m_annotations.visible = False				
			m_pfe_cst_imaging_view.m_edit.m_annotations.toolbaritemvisible= False		
			m_pfe_cst_imaging_view.m_edit.m_pageproperties.visible = False	
			m_pfe_cst_imaging_view.m_edit.m_pageproperties.toolbaritemvisible= False	
			m_pfe_cst_imaging_view.m_edit.m_11.visible = False	
		END IF
	END IF
	//End Code Change ----10.30.2012
ELSEIF ai_index = 3 THEN
	st_recs.Visible = True
	st_page.Visible = False	
	cbx_show.Visible = False	
	st_zoom.Visible = False
	cb_expand.Visible = False  //Start Code Change ----07.15.2011 #V11 maha 
	ddlb_zoom.Visible = False	
	ddlb_format.visible = true
	st_format.visible = true
	st_recs.Text = "Record " + String( tab_view.tabpage_setup.dw_image_data.GetRow() ) +&
	" of " + String( tab_view.tabpage_setup.dw_image_data.RowCount() )
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 2006-11-14 By: Allen
	//$<reason> Fix APB Bug: the Toolbar Icon is invalid.
	//w_mdi.ChangeMenu( m_pfe_cst_imaging_setup )	
	//----------Begin Modified by Alfee on 10.13.2008 ------------------	
	IF w_mdi.menuname <> 'm_pfe_cst_imaging_setup' THEN
		w_mdi.ChangeMenu( m_pfe_cst_imaging_setup )
		of_enable_next_prev_buttons(ai_index)
		w_mdi.of_menu_security('m_pfe_cst_imaging_setup')		
	END IF
	//If w_mdi.menuname <> 'm_pfe_cst_imaging_setup' Then w_mdi.ChangeMenu( m_pfe_cst_imaging_setup )
	//-----------End Modified ------------------------------------------	 
	//---------------------------- APPEON END ----------------------------
	//Start Code Change ----10.30.2012 #V12 maha - childrens hosp customization
	if gb_use_prac_toolbar = true then
		IF IsValid( m_pfe_cst_imaging_setup ) THEN	
			m_pfe_cst_imaging.m_file.m_saveimage.visible = False		
			m_pfe_cst_imaging.m_file.m_save.visible = True
			m_pfe_cst_imaging.m_edit.m_annotations.toolbaritemvisible= False
			m_pfe_cst_imaging.m_edit.m_annotations.m_select.enabled = False
			m_pfe_cst_imaging.m_edit.m_annotations.m_select.toolbaritemvisible= False		
			m_pfe_cst_imaging.m_edit.m_annotations.m_highlight.enabled = False
			m_pfe_cst_imaging.m_edit.m_annotations.m_highlight.toolbaritemvisible= False		
			m_pfe_cst_imaging.m_edit.m_annotations.m_note.enabled = False
			m_pfe_cst_imaging.m_edit.m_annotations.m_note.toolbaritemvisible= False		
			m_pfe_cst_imaging.m_edit.m_annotations.m_stamptext.enabled = False
			m_pfe_cst_imaging.m_edit.m_annotations.m_stamptext.toolbaritemvisible= False			
			m_pfe_cst_imaging.m_edit.m_annotations.visible = False		
			m_pfe_cst_imaging.m_file.m_print.enabled = False
			m_pfe_cst_imaging.m_file.m_print.toolbaritemvisible = False
			m_pfe_cst_imaging.m_file.m_batchprint.enabled = False
			m_pfe_cst_imaging.m_file.m_batchprint.toolbaritemvisible = False
			m_pfe_cst_imaging.m_file.m_save.toolbaritemvisible = True		
			m_pfe_cst_imaging.m_file.m_saveimage.toolbaritemvisible = False		
		END IF
	end if
	//End Code Change ----10.30.2012
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-01
//$<add> 01.20.2006 By: Rodger Wu
//$<reason> The SetToolbarPos function is currently unsupported. 
//$<modification> Replace the SetToolBarPos function with the Appeon defined function of_settoolbarpos to provide
//$<modification> the same functionality.
long ll_handle
ll_handle = handle(w_mdi)
gnv_appeondll.of_settoolbarpos(ll_handle)
//---------------------------- APPEON END ----------------------------

Return 1
end function

public function integer of_undo ();IF  is_ext = 'PDF' THEN Return 1 //Added by (APPEON) Harry 11.14.2017 (V161 Storage of Documents as PDFs)
try 
	IF ii_modified = 1 THEN //tab_view.tabpage_image.ole_scan_edit.Object.ImageModified() = True THEN
		tab_view.tabpage_image.ole_scan_edit.Object.Undo( 0 )
		ii_modified = 0
		//tab_view.tabpage_image.ole_scan_edit.Object.Save()
	ELSE
		MessageBox("Undo", "Nothing to Undo.")
	END IF
catch (runTimeError a)
	
end try
Return 1

end function

public function integer of_email_documents ();//Start Code Change ----10.06.2008 #V85 maha
if gi_email_type = 1 then
	integer res
	res = of_email_outlook( )
	return res
end if
//End Code Change---10.06.2008

Long ll_rec_id 
Long ll_next_id
Long	ll_action_type
Long	ll_action_status
Long	ll_action_dept
DateTime	ldt_action_dt
DateTime	ldt_next_action_dt
String ls_app_type
String ls_emp_mail_login
String ls_action_notes
String ls_image_path
String ls_action_user
String ls_app_image_name
String ls_name
String ls_app_nm
String ls_email_address
String ls_subject
String ls_notetext
Integer li_pagecount
Integer li_num_pages
Integer li_start_page
Integer li_to_page
Integer li_image_type_count
Integer li_prac_image_cnt
Integer m
Integer z
Integer li_image_type_id
Integer li_image_count
Integer li_nd_row_cnt
Integer a
Integer li_rc
Integer i
Integer li_from_page
Integer li_print_exceptions
Integer li_found
Integer li_count
Integer li_sub //maha 011504
string mess //maha 011504
String	ls_Rtn
blob lblb_MailContent //add by Michael 08.02.2011
DataWindowChild dwchild
Integer li_count_pdf  //Added by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)
String ls_ext //Added by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)
String ls_filename_temp //Added by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)

tab_view.tabpage_browse.dw_browse.AcceptText()
li_rc = tab_view.tabpage_browse.dw_browse.RowCount()


//Get image paths and load up image doc
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-04
//$<modify> 02.20.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Write script to retrieve data from a cache instead of from the database.

/*
SELECT ids.imaging_path ,
       ids.intelliapp_app_path
INTO :ls_image_path,
	  :gs_app_image_path  
FROM ids;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox("Database Error", SQLCA.SQLERRTEXT )
	Return -1
END IF
*/
ls_image_path = gnv_data.of_getitem("ids" , "imaging_path" , False)
gs_app_image_path = gnv_data.of_getitem("ids" , "intelliapp_app_path" , False)
//---------------------------- APPEON END ----------------------------

FOR i = 1 TO li_rc
	IF tab_view.tabpage_browse.dw_browse.GetItemNumber( i, "selected" )	= 1 THEN
		IF Upper(tab_view.tabpage_browse.dw_browse.GetItemString( i, "image_ext" )) = 'PDF' THEN //Added by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)
			li_count_pdf ++
		END IF
		li_count++
	END IF		
END FOR

//if not stored in db then check image path
IF ii_image_storage_type <> 1 THEN
	IF li_count_pdf > 0 THEN //Added by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)
		IF Not FileExists( ls_image_path + String( il_prac_id ) + ".pdf" ) THEN
			MessageBox("Invalid File", ls_image_path + String( il_prac_id ) + ".pdf" + " is an invalid file.  Check to make sure the image and path exists." )
			Return -1
		else 
			tab_view.tabpage_browse.ole_admin_pdf.ole_edit.object.LoadMultiPage( ls_image_path + String( il_prac_id ) + ".pdf" , 1)
			li_image_count = tab_view.tabpage_browse.ole_admin_pdf.ole_edit.object.GetTotalPage()
		END IF
	ELSE
		IF Not FileExists( ls_image_path + String( il_prac_id ) + ".tif" ) THEN
			MessageBox("Invalid File", ls_image_path + String( il_prac_id ) + ".tif" + " is an invalid file.  Check to make sure the image and path exists." )
			Return -1
	//Start Code Change ---- 02.15.2006 #276 maha
		else //maha 021506 part of error checking
			tab_view.tabpage_browse.ole_admin.object.Image( ls_image_path + String( il_prac_id ) + ".tif" )
			li_image_count = tab_view.tabpage_browse.ole_admin.object.pagecount()
	//End Code Change---02.15.2006
		END IF
	END IF
END IF

IF li_count = 0 THEN
	MessageBox("Invalid Selection", "Nothing Selected" )
	Return -1
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-05
//$<modify> 02.20.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Write script to retrieve data from a cache instead of from the database.
/*
SELECT email_id INTO :ls_emp_mail_login FROM security_users WHERE user_id = :gs_user_id;	
*/
/* Delete by Evan 04.07.2010 --- The following code is incorrect
ls_emp_mail_login = gnv_data.of_getitem("security_users","email_id","upper(user_id)='" + upper(gs_user_id)+ "'")
//---------------------------- APPEON END ----------------------------

IF ls_emp_mail_login = "" OR IsNull( ls_emp_mail_login ) THEN
	MessageBox("", "You must setup an email login in the Security User Painter for user: " + gs_user_id )
	Return -1
END IF
*/

Open( w_get_email_address_message )

mess = Message.StringParm
IF Message.StringParm = "Cancel" THEN Return -1
IF IsNull(mess) OR LenA(Trim(mess)) < 1 THEN Return -1 //alfee 05.19.2010

ls_email_address = MidA( Mess, 1, PosA( Mess, "*" ) -1)
li_sub = PosA( Mess, "**" ) //maha 011504
ls_notetext = MidA( Mess, PosA( Mess, "*" ) +1, li_sub - PosA( Mess, "*" ) - 1)	
ls_subject = MidA( Mess, li_sub +2) //maha 011504

IF li_count_pdf > 0 THEN //Added by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)
	FileDelete( gs_temp_path + "email_attachment.pdf"  )
	tab_view.tabpage_browse.ole_admin_pdf.ole_edit.object.LoadMultiPage( gs_temp_path + "email_attachment.pdf" ,1)
ELSE
	FileDelete( gs_temp_path + "email_attachment.tif"  )
	tab_view.tabpage_browse.ole_admin.object.Image( gs_temp_path + "email_attachment.tif" )
END IF

IF NOT IsValid(w_dm_image_cp) THEN Open(w_dm_image_cp)  //Added by (APPEON) Harry 11.10.2017 (V161 Storage of Documents as PDFs)

FOR i = 1 TO li_rc
	IF tab_view.tabpage_browse.dw_browse.GetItemNumber( i, "selected" )	= 0 THEN
		CONTINUE
	END IF					
	IF ii_image_storage_type = 1 THEN
		//scroll to the row
		tab_view.tabpage_browse.dw_browse.SetRow( i )
		//use the display function to display image
		of_display_doc( 1,1 )
		//print it out
		Sleep(1000)
		ls_ext =Upper(tab_view.tabpage_browse.dw_browse.GetItemString( i, "image_ext" ))
		IF ls_ext = 'PDF'THEN //Added by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)
			li_pagecount = tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.Object.GetTotalPage()
		ELSE
			IF li_count_pdf > 0 THEN
				ls_filename_temp = mid(is_display_doc_name ,1, lastpos(is_display_doc_name, '.')) + 'pdf'
				w_dm_image_cp.of_Image2PDF (is_display_doc_name ,ls_filename_temp)
				tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.Object.LoadMultiPage (ls_filename_temp, 1)
				li_pagecount = tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.Object.GetTotalPage()
				is_display_doc_name = ls_filename_temp
			ELSE
				li_pagecount = tab_view.tabpage_image.ole_scan_edit.Object.Pagecount()
			END IF
		END IF
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 09.27.2006 By: LeiWei
		//$<reason> Fix a defect.
		/*
		tab_view.tabpage_browse.ole_admin.object.Append( gs_dir_path + "IntelliCred\temp.tif", 1 , li_pagecount  )
		*/
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 07/09/2007 By: Ken.Guo
		//$<reason> When Image Admin Merge file, The first image file must be in TIF format, Otherwise PB will runerror.
		IF li_count_pdf <= 0 THEN //Added by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)
			If tab_view.tabpage_browse.ole_admin.object.pagecount() > 0 and tab_view.tabpage_browse.ole_admin.object.FileType <> 1 Then
				Messagebox('Image','The first image file must be in "TIF" format.')
				IF IsValid(w_dm_image_cp) THEN Close(w_dm_image_cp)  //Added by (APPEON) Harry 11.10.2017 (V161 Storage of Documents as PDFs)
				Return -1			
			End If
		END IF
		//---------------------------- APPEON END ----------------------------

		//--------------------------- APPEON BEGIN ---------------------------
		//$< Add  > 2008-07-15 By: Scofield
		//$<Reason> Verify if the directory has write right for the current user.
		
		ls_Rtn = f_ExaWriteRight(is_display_doc_name)
		if LenA(ls_Rtn) > 0 then
			MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
			IF IsValid(w_dm_image_cp) THEN Close(w_dm_image_cp)  //Added by (APPEON) Harry 11.10.2017 (V161 Storage of Documents as PDFs)
			Return -1
		end if
		
		//---------------------------- APPEON END ----------------------------
		IF li_count_pdf > 0  THEN //Added by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)
			ls_filename_temp = tab_view.tabpage_browse.ole_admin_pdf.ole_edit.object.FileName
			w_dm_image_cp.of_PDFEditMerge(ls_filename_temp, is_display_doc_name)  
			tab_view.tabpage_browse.ole_admin_pdf.ole_edit.object.LoadMultiPage( ls_filename_temp, 1)
		ELSE
			tab_view.tabpage_browse.ole_admin.object.Append( is_display_doc_name, 1 , li_pagecount  )
		END IF
		//---------------------------- APPEON END ----------------------------
	ELSE			
		li_start_page = tab_view.tabpage_browse.dw_browse.GetItemNumber( i, "start_page" ) 
		li_num_pages = tab_view.tabpage_browse.dw_browse.GetItemNumber( i, "num_pages" ) 
	//Start Code Change ---- 02.15.2006 #276 maha
		if of_check_page_count(li_start_page,li_image_count,li_num_pages)	= -1 then return -1	
	//End Code Change---02.15.2006
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 07/09/2007 By: Ken.Guo
		//$<reason> When Image Admin Merge(Append) file, The first image file must be in TIF format, Otherwise PB will runerror.
		IF li_count_pdf <= 0 THEN //Added by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)
			If tab_view.tabpage_browse.ole_admin.object.pagecount() > 0 and tab_view.tabpage_browse.ole_admin.object.FileType <> 1 Then
				Messagebox('Image','The first image file must be in "TIF" format.')
				IF IsValid(w_dm_image_cp) THEN Close(w_dm_image_cp)  //Added by (APPEON) Harry 11.10.2017 (V161 Storage of Documents as PDFs)
				Return -1			
			End If
		END IF
		//---------------------------- APPEON END ----------------------------
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$< Add  > 2008-07-15 By: Scofield
		//$<Reason> Verify if the directory has write right for the current user.
		
		ls_Rtn = f_ExaWriteRight(ls_image_path)
		if LenA(ls_Rtn) > 0 then
			MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
			IF IsValid(w_dm_image_cp) THEN Close(w_dm_image_cp)  //Added by (APPEON) Harry 11.10.2017 (V161 Storage of Documents as PDFs)
			Return -1
		end if
		
		//---------------------------- APPEON END ----------------------------
		IF li_count_pdf > 0 THEN //Added by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)
			w_dm_image_cp.of_insert_page_pdf( tab_view.tabpage_browse.ole_admin_pdf.ole_edit.object.FileName,  ls_image_path + String( il_prac_id ) + ".pdf", tab_view.tabpage_browse.ole_admin_pdf.ole_edit.object.GetTotalPage(), li_start_page , li_num_pages )
		ELSE
			tab_view.tabpage_browse.ole_admin.object.Append( ls_image_path + String( il_prac_id ) + ".tif", li_start_page , li_num_pages  )			
		END IF
	END IF
END FOR	
IF IsValid(w_dm_image_cp) THEN Close(w_dm_image_cp)  //Added by (APPEON) Harry 11.10.2017 (V161 Storage of Documents as PDFs)
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 06/13/2007 By: Ken.Guo
//$<reason> Send Email
	
		
	/*	
	mailSession mSes
	mailReturnCode mRet
	mailMessage mMsg
	mailFileDescription nfile1
	mailFileDescription nfile2
	mailFileDescription nfile3
	String ls_attach
	
	mSes = create mailSession
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> UM-02
	//$<add> 01.25.2006 By: LeiWei
	//$<reason> mailSession is currently unsupported.
	//$<modification> Manually specify mailReturnSuccess! as the initial value to mRet. 
	mRet = mailReturnSuccess!
	//---------------------------- APPEON END ----------------------------
	mRet = mSes.mailLogon( mailNewSession!) //maha modifed 042005
	IF mRet <> mailReturnSuccess! THEN
		MessageBox("Mail", 'Logon failed.  Check to make sure you have an email id setup in the user painter.')		
		Return -1
	END IF
	ls_attach = gs_temp_path + "email_attachment.tif"
	IF Len( ls_attach ) > 0 THEN
		// Populate the attachment object
		nfile1.FileType = MailAttach!
		nfile1.FileName = "email_attachment.tif"
		nfile1.PathName = gs_temp_path + "email_attachment.tif"
		nfile1.position = 1
		mMsg.AttachmentFile[1] = nfile1	
	END IF
	
	mMsg.Subject = ls_subject
	mMsg.NoteText = ls_notetext
	mMsg.Recipient[1].name = ls_email_address
	mRet = mSes.mailSend(mMsg)
	
	IF mRet <> mailReturnSuccess! THEN
		MessageBox("Mail Send", 'Mail not sent')
		mSes.mailLogoff()
		DESTROY mSes
		Return -1
	END IF
	
	mSes.mailLogoff()
	DESTROY mSes
	
	Return -1
	*/

String ls_address_mailcc,ls_attachments,ls_attach
IF li_count_pdf > 0  THEN //Added by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)
	ls_attach = gs_temp_path + "email_attachment.pdf"
ELSE
	ls_attach = gs_temp_path + "email_attachment.tif"
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-11-21 By: Scofield
//$<Reason> Change the interface of send mail.

//IF lnv_redemption_mail.of_start_email( ls_email_address,ls_address_mailcc,ls_notetext, ls_subject, ls_attach) < 0 THEN
//	Return -1
//END IF

long		ll_Return

n_cst_easymail_smtp 	lnv_Mail

if lnv_Mail.of_CreateObject() = -1 then
	//--------Begin Modified by Nova 11.07.2008-----------
	//MessageBox("Error", "Failed to create email object!",StopSign!)
	f_show_message('create Email object','','','','')
	//--------End Modified -------------------------------
	Return -1
end if

//START---Modify by Evan 2008-03-24 (Reasion:Send email with current user account)
/*
//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-02-22 By: Scofield
//$<Reason> Get the Addresser's user id.

String	ls_Addresser

select top 1 set_addresser into :ls_Addresser from icred_settings;

if IsNull(ls_Addresser) or Trim(ls_Addresser) = "" then
	ls_Addresser = gs_User_Id
end if
//---------------------------- APPEON END ----------------------------

//Send EMail
ll_Return = lnv_Mail.of_SendText(ls_Addresser, ls_email_address, ls_address_mailcc, '',ls_subject, ls_notetext, ls_attach)
*/
//ll_Return = lnv_Mail.of_SendText(gs_user_id, ls_email_address, ls_address_mailcc, '',ls_subject, ls_notetext, ls_attach) michael 02-11-2011
//END---Modify by Evan 2008-03-24

//------------------- APPEON START ---------------------
//$<Add> Michael Huang 02.11.2011
//$<reason> V11.2-EmailModification
integer	li_smtpssl , li_pop3ssl //alfee 09.24.20131
long 		ll_Port,ll_Authmode
string 	ls_Server,ls_Account,ls_Password,ls_Email,ls_HtmlFile
u_email_edit luo_email_edit //add by Michael 08.02.2011
ls_HtmlFile = ls_notetext
//---------Begin Commented by (Appeon)Harry 05.31.2013 for V142 ISG-CLX--------
/*
// Set SMTP information from user ID
//if lnv_Mail.of_GetDefaultAccount(gs_user_id,ls_Server,ll_Port,ll_Authmode,ls_Account,ls_Password,ls_Email) = -1 then Return -1
if lnv_Mail.of_GetDefaultAccount(gs_user_id,ls_Server,ll_Port,ll_Authmode,ls_Account,ls_Password,ls_Email,li_smtpssl,li_pop3ssl) = -1 then Return -1//BugA090401 - Alfee 09.24.2013

//ll_Return = lnv_Mail.of_SetSmtpInfo(ls_Server, ll_Port, ll_Authmode)
ll_Return = lnv_Mail.of_SetSmtpInfo(ls_Server, ll_Port, ll_Authmode, li_smtpssl)//BugA090401 - Alfee 09.24.2013
if  ll_Return < 0 then return ll_Return

ll_Return = lnv_Mail.of_SetAccountAddress(ls_Account, ls_Password, ls_Email)
*/
str_email_account lstr_email_account
// Set SMTP information from user ID
if  lnv_Mail.of_GetDefaultAccount(gs_user_id,lstr_email_account) = -1 then Return -1
ll_Return =  lnv_Mail.of_SetSmtpInfo(lstr_email_account)
if  ll_Return < 0 then return ll_Return

ll_Return =  lnv_Mail.of_SetAccountAddress(lstr_email_account)
//---------End Commented ------------------------------------------------------

//------------------- APPEON BEGIN -------------------
//$<add> Michael 08.02.2011
//$<reason> Fixed a bug2540 - Easy Mail not logging
//Get mail content from word file
luo_email_edit = create u_email_edit
luo_email_edit.of_readfile(luo_email_edit.of_GetEmailDir() + "\Email.doc", lblb_MailContent)
lnv_Mail.is_user_id = gs_user_id
lnv_Mail.iblb_mailcontent = lblb_MailContent
if isvalid(luo_email_edit) then destroy luo_email_edit
//------------------- APPEON END ---------------------

ll_Return = lnv_Mail.of_SendHtml(ls_email_address, ls_address_mailcc, '',ls_subject,ls_HtmlFile, ls_attach)
//------------------- APPEON END ---------------------

if ll_Return <> 0 then
	//---------Begin Modified by (Appeon)Harry 01.24.2014 for V142 ISG-CLX--------
	/*
	//--------Begin Modified by Nova 11.07.2008-----------
	//MessageBox("Error Code: " + String(ll_Return), "Failed to send email!~r~n~r~n" + lnv_Mail.of_GetEMailError(ll_Return),Exclamation!)
	f_show_message('error_code_'+string(ll_Return),'%1S%',String(ll_Return),'','')
	//--------End Modified -------------------------------
	*/
	If lnv_Mail.is_sendprotocol = 'SMTP' Then
		f_show_message('error_code_'+string(ll_Return),'%1S%',String(ll_Return),'','')
	Else
		f_show_message('error_code_'+string(ll_Return),'ALL',lnv_Mail.of_getemailerror(ll_Return),'','')
	End If
	//---------End Modfiied ------------------------------------------------------
	lnv_Mail.of_DeleteObject()
	return -1
end if

lnv_Mail.of_DeleteObject()
//---------------------------- APPEON END ----------------------------
Return 1
//---------------------------- APPEON END ----------------------------

end function

public function integer of_delete_all_images ();integer res
string ls_path
//---------Begin Added by (Appeon)Stephen 11.03.2016 for V15.3-Image Auditing in IntelliCred--------
long ll_image_pk
integer li_facility_id, li_cnt
datastore lds_image
//---------End Added ------------------------------------------------------


res = messagebox("Delete All Images?","This function will permanently delete all of the images for this practitioner.  Do you wish to continue?",question!,yesno!,2)
if res = 2 then return 0
res = messagebox("Delete All Images?","Are you sure?",question!,yesno!,2)
if res = 2 then return 0

IF is_ext = 'PDF' THEN //Added by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)
	tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.Object.filename = ''
ELSE
	tab_view.tabpage_image.ole_scan_edit.Object.ClearDisplay(  )
END IF
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-06
//$<modify> 02.20.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Write script to retrieve data from a cache instead of from the database.
/*
select imaging_path
into :ls_path
from ids;
*/
ls_path = gnv_data.of_getitem("ids" , "imaging_path" , false)
gnv_appeondb.of_autocommit()
//---------------------------- APPEON END ----------------------------

//---------Begin Added by (Appeon)Stephen 11.03.2016 for V15.3-Image Auditing in IntelliCred--------
lds_image = create datastore
lds_image.dataobject = "d_image_scan_detail"
lds_image.settransobject(sqlca)
lds_image.retrieve(gl_prac_id)
for li_cnt = 1 to lds_image.rowcount()
	ll_image_pk = lds_image.getitemnumber(li_cnt, "image_pk")
	li_facility_id = lds_image.getitemnumber(li_cnt, "facility_id")
	inv_dw.of_sqlfield_audit(gl_prac_id, ll_image_pk, li_facility_id, 95, "1001", 'Delete', string(ll_image_pk) + '-'+ string(gl_prac_id), 'D')
next
destroy lds_image
//---------End Added ------------------------------------------------------

delete from pd_images
where prac_id = :gl_prac_id;
commit using sqlca;

//FileDelete ( ls_path + string(gl_prac_id) + ".tif" )
FileDelete ( ls_path + string(gl_prac_id) + "." + is_ext ) //Modified by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)

tab_view.tabpage_browse.dw_browse.reset()
IF is_ext = 'PDF' THEN //Added by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)
	tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.Object.filename = ''
ELSE
	tab_view.tabpage_image.ole_scan_edit.Object.ClearDisplay(  ) //maha 082801
END IF

Return 1
end function

public function integer of_image_utility ();
//Start Code Change ---- 03.22.2006 #336 maha
IF ii_image_utility_on = 1 THEN
	tab_view.tabpage_browse.ole_thumb.Visible = True
	tab_view.tabpage_browse.cb_ass_file.Visible = True	
	ddlb_zoom.Visible = False
	cbx_show.Visible = False
	tab_view.tabpage_browse.lb_files.visible = true
	tab_view.tabpage_browse.lb_files.DirList( is_image_path, 1, tab_view.tabpage_browse.st_path)
	tab_view.tabpage_browse.dw_browse.x = 1202
	tab_view.tabpage_browse.dw_browse.y = 28
	tab_view.tabpage_browse.dw_browse.Width = 2245
	This.Text = "off"
	tab_view.tabpage_browse.st_path.Visible = True
	tab_view.tabpage_browse.sle_find_path.Visible = True
	tab_view.tabpage_browse.cb_find.Visible = True
	tab_view.tabpage_browse.dw_browse.Height = 808	
ELSE
//	ddlb_zoom.Visible = True
//	cbx_show.Visible = True	
//	tab_view.tabpage_browse.st_path.Visible = False
//	tab_view.tabpage_browse.sle_find_path.Visible = False
//	tab_view.tabpage_browse.cb_find.Visible = False	
//	tab_view.tabpage_browse.ole_thumb.Visible = False
//	tab_view.tabpage_browse.cb_ass_file.Visible = False	
//	tab_view.tabpage_browse.dw_browse.x = 18
//	tab_view.tabpage_browse.dw_browse.y = 16
//	tab_view.tabpage_browse.dw_browse.Width = 3410
//	tab_view.tabpage_browse.dw_browse.Height = 1680	
END IF
//End Code Change---03.22.2006
Return 0
end function

public function integer of_fax_documents ();SetPointer( HourGlass! )
Long ll_rec_id 
Long ll_next_id
Long	ll_action_type
Long	ll_action_status
Long	ll_action_dept
DateTime	ldt_action_dt
DateTime	ldt_next_action_dt
String ls_attachments[]
String ls_company
String ls_Fax
String ls_fax_number
String ls_recipient
String ls_cover_page 
String ls_cover_message
String ls_subject 
String ls_app_type
String ls_emp_mail_login
String ls_action_notes
String ls_image_path
String ls_action_user
String ls_app_image_name
String ls_name
String ls_app_nm
String ls_email_address
String ls_notetext
Integer li_num_pages
Integer li_start_page
Integer li_to_page
Integer li_image_type_count
Integer li_prac_image_cnt
Integer li_pagecount
Integer m
Integer z
Integer li_image_type_id
Integer li_image_count
Integer li_nd_row_cnt
Integer a
Integer li_rc
Integer i
Integer li_from_page
Integer li_print_exceptions
Integer li_found
Integer li_count
Integer li_sub //maha 011504
string 	mess //maha 011504
String	ls_Rtn
Integer li_count_pdf  //Added by (APPEON) Harry 11.09.2017 (V161 Storage of Documents as PDFs)
String ls_ext //Added by (APPEON) Harry 11.09.2017 (V161 Storage of Documents as PDFs)
String ls_filename_temp //Added by (APPEON) Harry 11.09.2017 (V161 Storage of Documents as PDFs)


DataWindowChild dwchild

tab_view.tabpage_browse.dw_browse.AcceptText()
li_rc = tab_view.tabpage_browse.dw_browse.RowCount()

//Get image paths and load up image doc
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-07
//$<modify> 02.20.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Write script to retrieve data from a cache instead of from the database.
/*
SELECT ids.imaging_path ,
       ids.intelliapp_app_path
INTO :ls_image_path,
	  :gs_app_image_path  
FROM ids;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox("Database Error", SQLCA.SQLERRTEXT )
	Return -1
END IF
*/
ls_image_path = gnv_data.of_getitem("ids" , "imaging_path" , False)
gs_app_image_path = gnv_data.of_getitem("ids" , "intelliapp_app_path" , False)
//---------------------------- APPEON END ----------------------------

FOR i = 1 TO li_rc
	IF tab_view.tabpage_browse.dw_browse.GetItemNumber( i, "selected" )	= 1 THEN
		IF Upper(tab_view.tabpage_browse.dw_browse.GetItemString( i, "image_ext" )) = 'PDF' THEN //Added by (APPEON) Harry 11.09.2017 (V161 Storage of Documents as PDFs)
			li_count_pdf ++
		END IF
		li_count++
	END IF		
END FOR

IF li_count = 0 THEN
	MessageBox("Invalid Selection", "Nothing Selected" )
	Return -1
END IF

////--------------------------- APPEON BEGIN ---------------------------
////$<add> 05/29/2007 By: Ken.Guo
////$<reason> Added for MSFax Printer. Set_52(Fax_type,2:MSFax,1:WINFax)
//If gds_settings.GetItemNumber(1,'set_52') = 2 and li_count > 1 THEN
//	MessageBox("Invalid Selection", "Only one image can be selected for MSFax Printer." )
//	Return -1
//END IF
////---------------------------- APPEON END ----------------------------

IF ii_image_storage_type <> 1 THEN
	IF li_count_pdf > 0 THEN //Added by (APPEON) Harry 11.09.2017 (V161 Storage of Documents as PDFs)
		IF Not FileExists( ls_image_path + String( il_prac_id ) + ".pdf" ) THEN
			MessageBox("Invalid File", ls_image_path + String( il_prac_id ) + ".pdf" + " is an invalid file.  Check to make sure the image and path exists." )
			Return -1
		END IF
	ELSE
		IF Not FileExists( ls_image_path + String( il_prac_id ) + ".tif" ) THEN
			MessageBox("Invalid File", ls_image_path + String( il_prac_id ) + ".tif" + " is an invalid file.  Check to make sure the image and path exists." )
			Return -1
		END IF
	END IF
END IF


pfc_cst_nv_fax nv_fax
nv_fax = CREATE pfc_cst_nv_fax;
gs_pass_ids  lg_pass_ids

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 07/09/2007 By: Ken.Guo
//$<reason> If Directory is not exist, it will RunError when set image property for ImageAdmin
If Not DirectoryExists ( gs_temp_path + "Fax"  ) Then
	CreateDirectory(gs_temp_path + "Fax" )
End If
//---------------------------- APPEON END ----------------------------

IF li_count_pdf > 0 THEN //Added by (APPEON) Harry 11.09.2017 (V161 Storage of Documents as PDFs)
	FileDelete( gs_temp_path + "Fax\image_1.pdf"  )
	tab_view.tabpage_browse.ole_admin_pdf.ole_edit.object.LoadMultiPage( gs_temp_path + "Fax\image_1.pdf" , 1)
	ls_attachments[1] = gs_temp_path + "Fax\image_1.pdf"
ELSE
	FileDelete( gs_temp_path + "Fax\image_1.tif"  )
	
	tab_view.tabpage_browse.ole_admin.object.Image( gs_temp_path + "Fax\image_1.tif" )
	
	ls_attachments[1] = gs_temp_path + "Fax\image_1.tif"
END IF



//--------------------------- APPEON BEGIN ---------------------------
//$<add> 07/09/2007 By: Ken.Guo
//$<reason> When ImageAdmin Merge files, the first file's type must be TIF format. Otherwise PB will RunError.
Integer li_filetype  
//0	Unknown;	1	TIF;	2	AWD (Windows 95 and 98 only);	3	Bitmap (BMP);
//4	PCX;		5	DCX;	6	JPEG;	7	XIF;	8	GIF;	9	WIF;
//ll_times = 0
//---------------------------- APPEON END ----------------------------
IF NOT IsValid(w_dm_image_cp) THEN Open(w_dm_image_cp)  //Added by (APPEON) Harry 11.10.2017 (V161 Storage of Documents as PDFs)

FOR i = 1 TO li_rc
	IF tab_view.tabpage_browse.dw_browse.GetItemNumber( i, "selected" )	= 0 THEN
		CONTINUE
	END IF
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 07/09/2007 By: Ken.Guo
	If tab_view.tabpage_browse.ole_admin.object.pagecount() > 0 and tab_view.tabpage_browse.ole_admin.object.FileType <> 1 Then
		Messagebox('Fax Send','The first image file you selected must be in "TIF" format.')
		IF IsValid(w_dm_image_cp) THEN Close(w_dm_image_cp)  //Added by (APPEON) Harry 11.10.2017 (V161 Storage of Documents as PDFs)
		Return -1			
	End If
	//---------------------------- APPEON END ----------------------------

	IF ii_image_storage_type = 1 THEN
		//scroll to the row
		tab_view.tabpage_browse.dw_browse.SetRow( i )
		//use the display function to display image
		Sleep(1000)
		of_display_doc( 1,1 )
		ls_ext =Upper(tab_view.tabpage_browse.dw_browse.GetItemString( i, "image_ext" ))
		IF ls_ext = 'PDF'THEN //Added by (APPEON) Harry 11.09.2017 (V161 Storage of Documents as PDFs)
			li_pagecount = tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.Object.GetTotalPage()
		ELSE
			IF li_count_pdf > 0 THEN
				ls_filename_temp = mid(is_display_doc_name ,1, lastpos(is_display_doc_name, '.')) + 'pdf'
				w_dm_image_cp.of_Image2PDF (is_display_doc_name ,ls_filename_temp)
				tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.Object.LoadMultiPage (ls_filename_temp, 1)
				li_pagecount = tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.Object.GetTotalPage()
				is_display_doc_name = ls_filename_temp
			ELSE
				li_pagecount = tab_view.tabpage_image.ole_scan_edit.Object.Pagecount()
			END IF
		END IF
		
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$< Add  > 2008-07-15 By: Scofield
		//$<Reason> Verify if the directory has write right for the current user.
		
		ls_Rtn = f_ExaWriteRight(is_display_doc_name)
		if LenA(ls_Rtn) > 0 then
			MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
			IF IsValid(w_dm_image_cp) THEN Close(w_dm_image_cp)  //Added by (APPEON) Harry 11.10.2017 (V161 Storage of Documents as PDFs)
			Return -1
		end if

		//---------------------------- APPEON END ----------------------------

		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 09.27.2006 By: LeiWei
		//$<reason> Fix a defect.
		/*
		tab_view.tabpage_browse.ole_admin.object.Append( gs_dir_path + "IntelliCred\temp.tif", 1 ,li_pagecount  )
		*/
		IF li_count_pdf > 0  THEN //Added by (APPEON) Harry 11.09.2017 (V161 Storage of Documents as PDFs)
			ls_filename_temp = tab_view.tabpage_browse.ole_admin_pdf.ole_edit.object.FileName
			w_dm_image_cp.of_PDFEditMerge (ls_filename_temp, is_display_doc_name)
			tab_view.tabpage_browse.ole_admin_pdf.ole_edit.object.LoadMultiPage ( ls_filename_temp, 1)
		ELSE
			tab_view.tabpage_browse.ole_admin.object.Append( is_display_doc_name, 1 ,li_pagecount  )
		END IF
		
		//---------------------------- APPEON END ----------------------------
	ELSE
		li_start_page = tab_view.tabpage_browse.dw_browse.GetItemNumber( i, "start_page" ) 
		li_num_pages = tab_view.tabpage_browse.dw_browse.GetItemNumber( i, "num_pages" ) 
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$< Add  > 2008-07-15 By: Scofield
		//$<Reason> Verify if the directory has write right for the current user.
		ls_Rtn = f_ExaWriteRight(ls_image_path)
		if LenA(ls_Rtn) > 0 then
			MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
			IF IsValid(w_dm_image_cp) THEN Close(w_dm_image_cp)  //Added by (APPEON) Harry 11.10.2017 (V161 Storage of Documents as PDFs)
			Return -1
		end if
		
		//---------------------------- APPEON END ----------------------------
		IF li_count_pdf > 0 THEN //Added by (APPEON) Harry 11.09.2017 (V161 Storage of Documents as PDFs)
			w_dm_image_cp.of_insert_page_pdf( tab_view.tabpage_browse.ole_admin_pdf.ole_edit.object.FileName,  ls_image_path + String( il_prac_id ) + ".pdf", tab_view.tabpage_browse.ole_admin_pdf.ole_edit.object.GetTotalPage(), li_start_page , li_num_pages )
		ELSE
			tab_view.tabpage_browse.ole_admin.object.Append(ls_image_path + String( il_prac_id ) + ".tif", li_start_page , li_num_pages)
		END IF
	END IF
END FOR	
IF IsValid(w_dm_image_cp) THEN Close(w_dm_image_cp)  //Added by (APPEON) Harry 11.10.2017 (V161 Storage of Documents as PDFs)
	
OpenWithParm( w_fax_win, "Image" )
IF Message.StringParm = "Cancel" THEN
	Return -1
END IF
lg_pass_ids = Message.PowerObjectParm

ls_cover_page = lg_pass_ids.s_fax_cover
ls_cover_message = lg_pass_ids.s_fax_message 
ls_subject = lg_pass_ids.s_fax_subject	
ls_recipient = lg_pass_ids.s_fax_recipient
ls_fax = lg_pass_ids.s_fax_fax_number
ls_company = lg_pass_ids.s_fax_company
IF IsNull( ls_company ) THEN
	ls_company = ""
END IF
String ls_errtext		
IF nv_fax.of_fax( ls_recipient, ls_company, ls_fax, ls_subject, ls_cover_message, ls_attachments, ls_cover_page,ls_errtext )	= -1 THEN
	Messagebox('Fax Send',ls_errtext)
	Return -1
END IF
	
	

Return -1
end function

public function integer of_check_for_null_start (integer ai_start);//maha created 030405
	
	if isnull(ai_start) then //maha 030405
		MessageBox("Start Page", "There is no start page for image.  Unable to display/print image")
		return -1
	else
		return 1
	end if
end function

public subroutine of_doubleclicked (u_dw adw);integer li_start //maha03.20.2008
datawindow l_dw_browse
l_dw_browse = this.tab_view.tabpage_browse.dw_browse



//if ib_new_row_added then 
//	l_dw_browse.setrow( l_dw_browse.rowcount() + 1)
//	l_dw_browse.SelectRow(0, FALSE)
//   l_dw_browse.SelectRow(l_dw_browse.rowcount()  + 1, TRUE)
//end if 

il_current_row = this.tab_view.tabpage_browse.dw_browse.getrow( )
//messagebox('il_current_row',il_current_row)

// mskinner 09 March 2006 -- begin
if il_current_row < 1 then return 
// mskinner 09 March 2006 -- end

//------------------- APPEON BEGIN -------------------
//$<modify> Evan 09.01.2011
//$<reason> Fix BugE082102
//IF il_dispaly_row <> il_current_row THEN
//if il_dispaly_row <> il_current_row or tab_view.tabpage_image.ole_scan_edit.Object.Imagedisplayed = false then
if il_dispaly_row <> il_current_row or &
   (is_ext = 'TIF' and tab_view.tabpage_image.ole_scan_edit.Object.Imagedisplayed = false) or &
   (is_ext = 'PDF' and tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.Object.FileName = '' )	then  //Modified by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)
//------------------- APPEON END ---------------------
	setredraw( false)
	// mskinner 14 Dec 2005 - begin
	//ADW.setItem(il_current_row,'selected',1) //Start Code Change ---- 04.20.2006 #406 maha removed
//Start Code Change ----03.20.2008 #V8 maha - set start page to 1 if stored in db
	if ii_image_storage_type = 1 then
		li_start = 1
	else
		li_start = ADW.GetItemNumber( il_current_row, "start_page" )
	end if
	// mskinner 14 Dec 2005 - end 
	of_display_doc( li_start, ADW.GetItemNumber( il_current_row, "num_pages" ) )
//End Code Change---03.20.2008
	//tab_view.tabpage_image.ole_scan_edit.Object.Annotationtype(11)	
	IF is_ext = 'TIF' THEN tab_view.tabpage_image.ole_scan_edit.Object.Annotationtype(11)	 //Modified by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)

	il_dispaly_row = il_current_row
	setredraw(true)
ElseIf il_dispaly_row = il_current_row Then//Added by Appeon long.zhang 12.21.2015 (V14.2 Applause Cycle 2 Cosmetic Bug #4903 - Preview a document 2nd time, The Prior & Next buttons are disabled)
	of_enable_next_prev_buttons( "Image" )
END IF
end subroutine

public function integer of_print_image (integer al_start_page, integer al_pagecount);/******************************************************************************************************************
**  [PUBLIC]   : of_print_image( /*integer al_start_page*/, /*integer al_pagecount */)
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
** MSkinner               13 March 2006 														Added Argumentts to the function to 
**																											PrintImage(al_start_page,al_pagecount)
**                                                                               ALL IMAGES WERE BEING PRINTED.
********************************************************************************************************************/
// al_pagecount is the page of the image to print to
//Start Code Change ---- 05.10.2006 #443 maha trap for bad pages
integer li_numpages
integer li_format  //maha 04.20.2011
//End Code Change---05.01.2006
li_numpages = al_pagecount - al_start_page + 1

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01/11/2008 By: Ken.Guo
//$<reason> Need add Try catch to access pagecount property firstly.
Try
	IF is_ext='PDF' THEN  //Added by (APPEON) Harry 11.10.2017 (V161 Storage of Documents as PDFs)
		If tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.object.GetTotalPage() < 1 Then Return -1
	ELSE
		If tab_view.tabpage_image.ole_scan_edit.object.pagecount < 1 Then Return -1
	END IF
Catch(OleRuntimeError err)
	Return -1
End Try
//---------------------------- APPEON END ----------------------------



if of_check_page_count( al_start_page, tab_view.tabpage_image.ole_scan_edit.object.pagecount, li_numpages) = -1 then return -1

IF NOT IsValid(w_dm_image_cp) THEN Open(w_dm_image_cp)   //Added by (APPEON) Harry 11.10.2017 (V161 Storage of Documents as PDFs)
try
	if ib_no_dialog then
		//Start Code Change ----04.20.2011 #V11 maha - added format option
		 //--------Begin Modified by  Nova 04.21.2010------------------------
		 //tab_view.tabpage_image.ole_scan_edit.object.PrintImage(al_start_page,al_pagecount)
		 //tab_view.tabpage_image.ole_scan_edit.object.PrintImage(al_start_page,al_pagecount,3)
		 li_format = of_get_app_setting("set_53","I")
		if li_format = 1 then
			//intFormat = 1 
		else
			li_format = 3
		end if
		//messagebox("ofprint",intformat)
		//ole_admin.object.PrintOutputFormat = intFormat
		IF is_ext='PDF' THEN  //Added by (APPEON) Harry 11.10.2017 (V161 Storage of Documents as PDFs)
			w_dm_image_cp.of_PrintImage( tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.object.FileName,al_start_page,al_pagecount,9,false)
		ELSE
			 tab_view.tabpage_image.ole_scan_edit.object.PrintImage(al_start_page,al_pagecount,li_format)
		END IF
		 //--------End Modified --------------------------------------------
		 //End Code Change ----04.20.2011
	else
		IF is_ext='PDF' THEN  //Added by (APPEON) Harry 11.10.2017 (V161 Storage of Documents as PDFs)
			li_format = of_get_app_setting("set_53","I")
			if li_format = 1 then
				li_format = 8 
			else
				li_format = 9
			end if
			w_dm_image_cp.of_PrintImage( tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.object.FileName,al_start_page,al_pagecount,li_format,true)
		ELSE
			 tab_view.tabpage_browse.ole_admin.object.image = tab_view.tabpage_image.ole_scan_edit.object.image
			 inv_image_functions.of_print( tab_view.tabpage_browse.ole_admin,tab_view.tabpage_image.ole_scan_edit, Handle(this), '',al_start_page,al_pagecount)
		END IF
	end if 
catch(Throwable e)
	MessageBox("Imaging","There is a printer error, Please check the printer.")
end try
IF IsValid(w_dm_image_cp) THEN Close(w_dm_image_cp)  //Added by (APPEON) Harry 11.10.2017 (V161 Storage of Documents as PDFs)


return  0
end function

public function integer of_check_page_count (integer ai_start, integer ai_image, integer ai_num_pages);//Start Code Change ---- 02.15.2006 #277 maha
//Function created maha to validate the start and number of pages against the image pagecount.
integer li_cnt

li_cnt = ai_start + ai_num_pages - 1

if ai_start > ai_image then //validate the start page
	messagebox("Image Page Counts out of Sync","The start page (" + string(ai_start) + ") is greater than the number of pages in the image (" + string(ai_image) + "). Cannot continue process.")
	return -1
elseif li_cnt > ai_image then //validate the num of pages
	messagebox("Image Page Counts out of Sync","The start page and number of pages (" + string(li_cnt) + ") is greater than the number of pages in the image (" + string(ai_image) + "). Cannot continue process.")
	return -1
else
	return 1
end if

//End Code Change---02.15.2006

end function

public function integer of_browse_select_row (integer ai_row, integer ai_param);//Start Code Change ---- 04.24.2006 #407 maha
//new function created to set the proper dw_browse row either first or last
integer r
datawindow ldw_b

ldw_b = tab_view.tabpage_browse.dw_browse

//if set go to the last row
if ai_param > 0 then 
	r = ldw_b.rowcount()
else
	r = ai_row
end if
//if ai_param <> -1 then
//	messagebox("of_browse_set_row","ai_param: " + string(ai_param) + "; r: " + string(r) + "; ai_row: " +  string(ai_row))
//end if
//messagebox("of_browse_set_row",string(r))
ldw_b.SetRow( r )
//ldw_b.SelectRow( 0, False )   //Start Code Change ----01.20.2016 #V15 maha - removed
//ldw_b.SelectRow(r, True )
il_current_row = r
st_recs.Text = "Record " + String(r) + " of " + String( ldw_b.RowCount())

return 1

end function

public function integer of_scanner_select ();//Start Code Change ----02.21.2008 #V8 maha -  added
IF  is_scan_ext = 'PDF' THEN //Added by (APPEON) Harry 11.13.2017 (V161 Storage of Documents as PDFs)
	IF NOT IsValid(w_scan_cp) THEN Open(w_scan_cp)
	w_scan_cp.of_selectimagesource()
	Close(w_scan_cp)
ELSE
	inv_image_functions.of_select_scanner(   tab_view.tabpage_setup.ole_scan)
END IF

return 1
end function

public function integer of_email_outlook ();//Start Code Change ----10.06.2008 #V85 maha - original function readded
Long ll_rec_id 
Long ll_next_id
Long	ll_action_type
Long	ll_action_status
Long	ll_action_dept
DateTime	ldt_action_dt
DateTime	ldt_next_action_dt
String ls_app_type
String ls_emp_mail_login
String ls_action_notes
String ls_image_path
String ls_action_user
String ls_app_image_name
String ls_name
String ls_app_nm
String ls_email_address
String ls_subject
String ls_notetext
Integer li_pagecount
Integer li_num_pages
Integer li_start_page
Integer li_to_page
Integer li_image_type_count
Integer li_prac_image_cnt
Integer m
Integer z
Integer li_image_type_id
Integer li_image_count
Integer li_nd_row_cnt
Integer a
Integer li_rc
Integer i
Integer li_from_page
Integer li_print_exceptions
Integer li_found
Integer li_count
Integer li_sub //maha 011504
string mess //maha 011504
Integer li_count_pdf  //Added by (APPEON) Harry 11.09.2017 (V161 Storage of Documents as PDFs)
String ls_ext //Added by (APPEON) Harry 11.09.2017 (V161 Storage of Documents as PDFs)
String ls_filename_temp //Added by (APPEON) Harry 11.09.2017 (V161 Storage of Documents as PDFs)

DataWindowChild dwchild

n_cst_string lnv_string//Nova 07262010
String ls_Recipient[]//Nova 07262010

tab_view.tabpage_browse.dw_browse.AcceptText()
li_rc = tab_view.tabpage_browse.dw_browse.RowCount()


//Get image paths and load up image doc
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-04
//$<modify> 02.20.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Write script to retrieve data from a cache instead of from the database.

/*
SELECT ids.imaging_path ,
       ids.intelliapp_app_path
INTO :ls_image_path,
	  :gs_app_image_path  
FROM ids;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox("Database Error", SQLCA.SQLERRTEXT )
	Return -1
END IF
*/
ls_image_path = gnv_data.of_getitem("ids" , "imaging_path" , False)
gs_app_image_path = gnv_data.of_getitem("ids" , "intelliapp_app_path" , False)
//---------------------------- APPEON END ----------------------------

FOR i = 1 TO li_rc
	IF tab_view.tabpage_browse.dw_browse.GetItemNumber( i, "selected" )	= 1 THEN
		IF Upper(tab_view.tabpage_browse.dw_browse.GetItemString( i, "image_ext" )) = 'PDF' THEN //Added by (APPEON) Harry 11.09.2017 (V161 Storage of Documents as PDFs)
			li_count_pdf ++
		END IF
		li_count++
	END IF		
END FOR

//if not stored in db then check image path
IF ii_image_storage_type <> 1 THEN
	IF li_count_pdf > 0 THEN //Added by (APPEON) Harry 11.09.2017 (V161 Storage of Documents as PDFs)
		IF Not FileExists( ls_image_path + String( il_prac_id ) + ".pdf" ) THEN
			MessageBox("Invalid File", ls_image_path + String( il_prac_id ) + ".pdf" + " is an invalid file.  Check to make sure the image and path exists." )
			Return -1
		else 
			tab_view.tabpage_browse.ole_admin_pdf.ole_edit.object.LoadMultiPage( ls_image_path + String( il_prac_id ) + ".pdf", 1 )
			li_image_count = tab_view.tabpage_browse.ole_admin_pdf.ole_edit.object.GetTotalPage()
		END IF
	ELSE
		IF Not FileExists( ls_image_path + String( il_prac_id ) + ".tif" ) THEN
			MessageBox("Invalid File", ls_image_path + String( il_prac_id ) + ".tif" + " is an invalid file.  Check to make sure the image and path exists." )
			Return -1
	//Start Code Change ---- 02.15.2006 #276 maha
		else //maha 021506 part of error checking
			tab_view.tabpage_browse.ole_admin.object.Image( ls_image_path + String( il_prac_id ) + ".tif" )
			li_image_count = tab_view.tabpage_browse.ole_admin.object.pagecount()
	//End Code Change---02.15.2006
		END IF
	END IF
END IF

IF li_count = 0 THEN
	MessageBox("Invalid Selection", "Nothing Selected" )
	Return -1
END IF
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-05
//$<modify> 02.20.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Write script to retrieve data from a cache instead of from the database.
/*
SELECT email_id INTO :ls_emp_mail_login FROM security_users WHERE user_id = :gs_user_id;	
*/
/* Delete by Evan 04.07.2010 --- The following code is incorrect
ls_emp_mail_login = gnv_data.of_getitem("security_users","email_id","upper(user_id)='" + upper(gs_user_id)+ "'")
//---------------------------- APPEON END ----------------------------

IF ls_emp_mail_login = "" OR IsNull( ls_emp_mail_login ) THEN
	MessageBox("", "You must setup an email login in the Security User Painter for user: " + gs_user_id )
	Return -1
END IF
*/

Open( w_get_email_address_message )

mess = Message.StringParm
IF Message.StringParm = "Cancel" THEN Return -1
IF IsNull(mess) OR LenA(Trim(mess)) < 1 THEN Return -1 //alfee 05.19.2010

ls_email_address = MidA( Mess, 1, PosA( Mess, "*" ) -1)
li_sub = PosA( Mess, "**" ) //maha 011504
ls_notetext = MidA( Mess, PosA( Mess, "*" ) +1, li_sub - PosA( Mess, "*" ) - 1)	
ls_subject = MidA( Mess, li_sub +2) //maha 011504

IF li_count_pdf > 0 THEN //Added by (APPEON) Harry 11.09.2017 (V161 Storage of Documents as PDFs)
	FileDelete( gs_temp_path + "email_attachment.pdf"  )
	tab_view.tabpage_browse.ole_admin_pdf.ole_edit.object.LoadMultiPage( gs_temp_path + "email_attachment.pdf", 1)
ELSE
	FileDelete( gs_temp_path + "email_attachment.tif"  )
	tab_view.tabpage_browse.ole_admin.object.Image( gs_temp_path + "email_attachment.tif" )
END IF

IF NOT IsValid(w_dm_image_cp) THEN Open(w_dm_image_cp)  //Added by (APPEON) Harry 11.10.2017 (V161 Storage of Documents as PDFs)
FOR i = 1 TO li_rc
	IF tab_view.tabpage_browse.dw_browse.GetItemNumber( i, "selected" )	= 0 THEN
		CONTINUE
	END IF					
	IF ii_image_storage_type = 1 THEN
		//scroll to the row
		tab_view.tabpage_browse.dw_browse.SetRow( i )
		//use the display function to display image
		of_display_doc( 1,1 )
		//print it out
		Sleep(1000)
		ls_ext =Upper(tab_view.tabpage_browse.dw_browse.GetItemString( i, "image_ext" ))
		IF ls_ext = 'PDF'THEN //Added by (APPEON) Harry 11.09.2017 (V161 Storage of Documents as PDFs)
			li_pagecount = tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.Object.GetTotalPage()
		ELSE
			IF li_count_pdf > 0 THEN
				ls_filename_temp = mid(is_display_doc_name ,1, lastpos(is_display_doc_name, '.')) + 'pdf'
				//tab_view.tabpage_image.ole_scanpdf_edit.Object.Image2PDF (is_display_doc_name ,ls_filename_temp)
				w_dm_image_cp.of_Image2PDF (is_display_doc_name ,ls_filename_temp)
				tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.Object.LoadMultiPage (ls_filename_temp, 1)
				li_pagecount = tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.Object.GetTotalPage()
				is_display_doc_name = ls_filename_temp
			ELSE
				li_pagecount = tab_view.tabpage_image.ole_scan_edit.Object.Pagecount()
			END IF
		END IF
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 09.27.2006 By: LeiWei
		//$<reason> Fix a defect.
		/*
		tab_view.tabpage_browse.ole_admin.object.Append( gs_dir_path + "IntelliCred\temp.tif", 1 , li_pagecount  )
		*/
		IF li_count_pdf > 0  THEN //Added by (APPEON) Harry 11.09.2017 (V161 Storage of Documents as PDFs)
			ls_filename_temp = tab_view.tabpage_browse.ole_admin_pdf.ole_edit.object.FileName
			//tab_view.tabpage_browse.ole_admin_pdf.object.PDFEditMerge (ls_filename_temp, is_display_doc_name, ls_filename_temp)
			w_dm_image_cp.of_PDFEditMerge (ls_filename_temp, is_display_doc_name)
			tab_view.tabpage_browse.ole_admin_pdf.ole_edit.object.LoadMultiPage (ls_filename_temp, 1)
		ELSE
			tab_view.tabpage_browse.ole_admin.object.Append( is_display_doc_name, 1 , li_pagecount  )
		END IF
		
		//---------------------------- APPEON END ----------------------------
	ELSE			
		li_start_page = tab_view.tabpage_browse.dw_browse.GetItemNumber( i, "start_page" ) 
		li_num_pages = tab_view.tabpage_browse.dw_browse.GetItemNumber( i, "num_pages" ) 
	//Start Code Change ---- 02.15.2006 #276 maha
		if of_check_page_count(li_start_page,li_image_count,li_num_pages)	= -1 then return -1	
	//End Code Change---02.15.2006
		IF li_count_pdf > 0 THEN //Added by (APPEON) Harry 11.09.2017 (V161 Storage of Documents as PDFs)
			w_dm_image_cp.of_insert_page_pdf(tab_view.tabpage_browse.ole_admin_pdf.ole_edit.object.FileName,  ls_image_path + String( il_prac_id ) + ".pdf", tab_view.tabpage_browse.ole_admin_pdf.ole_edit.object.GetTotalPage(), li_start_page , li_num_pages )
		ELSE
			tab_view.tabpage_browse.ole_admin.object.Append( ls_image_path + String( il_prac_id ) + ".tif", li_start_page , li_num_pages  )	
		END IF
	END IF
END FOR	
IF IsValid(w_dm_image_cp) THEN Close(w_dm_image_cp)  //Added by (APPEON) Harry 11.10.2017 (V161 Storage of Documents as PDFs)

//---------- APPEON BEGIN ----------
//$<modify> Evan 06.11.2012
//$<reason> V12.2-Email Logging
/*
mailSession mSes
mailReturnCode mRet
mailMessage mMsg
mailFileDescription nfile1
mailFileDescription nfile2
mailFileDescription nfile3
String ls_attach

mSes = create mailSession
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-02
//$<add> 01.25.2006 By: LeiWei
//$<reason> mailSession is currently unsupported.
//$<modification> Manually specify mailReturnSuccess! as the initial value to mRet. 
mRet = mailReturnSuccess!
//---------------------------- APPEON END ----------------------------
mRet = mSes.mailLogon( mailNewSession!) //maha modifed 042005
IF mRet <> mailReturnSuccess! THEN
	MessageBox("Mail", 'Logon failed.  Check to make sure you have an email id setup in the user painter.')		
	Return -1
END IF
ls_attach = gs_temp_path + "email_attachment.tif"
IF LenA( ls_attach ) > 0 THEN
	// Populate the attachment object
	nfile1.FileType = MailAttach!
	nfile1.FileName = "email_attachment.tif"
	nfile1.PathName = gs_temp_path + "email_attachment.tif"
	nfile1.position = 1
	mMsg.AttachmentFile[1] = nfile1	
END IF

mMsg.Subject = ls_subject
mMsg.NoteText = ls_notetext
//--------Begin Modified by  Nova 07.26.2010------------------------
//mMsg.Recipient[1].name = ls_email_address
lnv_string.of_parsetoarray( ls_email_address, ';', ls_Recipient[])
FOR i = 1 To UpperBound(ls_Recipient[])
	mMsg.Recipient[i].Name = Trim(ls_Recipient[i])
NEXT
//--------End Modified --------------------------------------------

mRet = mSes.mailSend(mMsg)

IF mRet <> mailReturnSuccess! THEN
	MessageBox("Mail Send", 'Mail not sent')
	mSes.mailLogoff()
	DESTROY mSes
	Return -1
END IF

mSes.mailLogoff()
DESTROY mSes
*/
//---------Begin Modified by (Appeon)Stephen 04.28.2014 for Emailing out of Intellicred in 64 bit office 2010--------
/*
n_cst_outlook lnv_Outlook	
if lnv_Outlook.of_Logon() = -1 then
	MessageBox("Mail", "Logon failed.  Check to make sure you have an email id setup in the user painter.")
	Return -1
end if
ls_attach = gs_temp_path + "email_attachment.tif"
ll_Return = lnv_Outlook.of_Send(ls_email_address, "", "", ls_subject, ls_notetext, ls_attach)
lnv_Outlook.of_Logoff()
if ll_Return <> 1 then
	MessageBox("Mail Send", "Mail not sent.")
	Return -1
end if
*/
long ll_Return
string ls_Attach
string ls_att[]
if gb_outlook_64bit = false then
	n_cst_outlook lnv_Outlook
	
	if lnv_Outlook.of_Logon() = -1 then
		MessageBox("Mail", "Logon failed.  Check to make sure you have an email id setup in the user painter.")
		Return -1
	end if
	IF li_count_pdf > 0 THEN //Added by (APPEON) Harry 11.09.2017 (V161 Storage of Documents as PDFs)
		ls_attach = gs_temp_path + "email_attachment.pdf"
	ELSE
		ls_attach = gs_temp_path + "email_attachment.tif"
	END IF
	ll_Return = lnv_Outlook.of_Send(ls_email_address, "", "", ls_subject, ls_notetext, ls_attach)
	lnv_Outlook.of_Logoff()
	if ll_Return <> 1 then
		MessageBox("Mail Send", "Mail not sent.")
		Return -1
	end if
else
	pfc_cst_nv_fax lnv_emailfax
	lnv_emailfax = Create pfc_cst_nv_fax
	IF li_count_pdf > 0 THEN //Added by (APPEON) Harry 11.09.2017 (V161 Storage of Documents as PDFs)
		ls_att[1] = gs_temp_path + "email_attachment.pdf"
	ELSE
		ls_att[1] = gs_temp_path + "email_attachment.tif"
	END IF
	ll_Return = lnv_emailfax.of_email_outlookapp( "", "", ls_email_address,ls_subject , ls_notetext, ls_att[],  "", "" )
	destroy lnv_emailfax
	if ll_Return <> 1 then
		MessageBox("Mail Send", "Mail not sent.")
		Return -1
	end if	
end if
//---------- APPEON END ------------

//---------- APPEON END ------------

Return -1
end function

public function integer of_enable_next_prev_buttons (integer ai_index);//Added by Alfee on 10.13.2008

Integer li_current_row_page
Integer li_total_row_page

m_pfe_cst_imaging lm_image

CHOOSE CASE ai_index
	CASE 1
		lm_image = m_pfe_cst_imaging_browse
	CASE 2
		lm_image = m_pfe_cst_imaging_view
	CASE 3
		lm_image = m_pfe_cst_imaging_setup
	CASE ELSE
		lm_image = m_pfe_cst_imaging
END CHOOSE

IF NOT IsValid(lm_image) THEN RETURN -1

IF ai_index = 1 THEN	
	li_current_row_page = tab_view.tabpage_browse.dw_browse.GetRow()
	li_total_row_page = tab_view.tabpage_browse.dw_browse.RowCount()
	//lm_image.m_view.m_nextpage.enabled = False
	//lm_image.m_view.m_priorpage.enabled = False
	gnv_app.of_modify_menu_attr( lm_image.m_view.m_nextpage,'enabled', False)
	gnv_app.of_modify_menu_attr( lm_image.m_view.m_priorpage,'enabled', False)
	iw_parent_window.cb_next.enabled = False  //Start Code Change ----12.19.2011 #V12 maha
	iw_parent_window.cb_prior.enabled = False  //Start Code Change ----12.19.2011 #V12 maha

	IF li_current_row_page < li_total_row_page THEN
		//lm_image.m_view.m_nextpage.enabled = True	
		gnv_app.of_modify_menu_attr( lm_image.m_view.m_nextpage,'enabled', True)	
		iw_parent_window.cb_next.enabled = True  //Start Code Change ----12.19.2011 #V12 maha
	END IF

	IF li_current_row_page > 1 THEN
		//lm_image.m_view.m_priorpage.enabled = True
		gnv_app.of_modify_menu_attr( lm_image.m_view.m_priorpage,'enabled', True)
		iw_parent_window.cb_prior.enabled = True  //Start Code Change ----12.19.2011 #V12 maha
	END IF
	
//	iw_parent_window.of_buttons_visible( true, false, true, true,true, true, true, true, true,true, false, false)
	
ELSEIF ai_index = 2 THEN	
	//lm_image.m_view.m_nextpage.enabled = False
	//lm_image.m_view.m_priorpage.enabled = False
	gnv_app.of_modify_menu_attr( lm_image.m_view.m_nextpage,'enabled', False)
	gnv_app.of_modify_menu_attr( lm_image.m_view.m_priorpage,'enabled', False)
//	iw_parent_window.cb_next.enabled = False  //Start Code Change ----12.19.2011 #V12 maha
//	iw_parent_window.cb_prior.enabled = False  //Start Code Change ----12.19.2011 #V12 maha

	IF ii_current_page < ii_num_pages THEN
		//lm_image.m_view.m_nextpage.enabled =true
		gnv_app.of_modify_menu_attr( lm_image.m_view.m_nextpage,'enabled', True)
//		iw_parent_window.cb_next.enabled = true  //Start Code Change ----12.19.2011 #V12 maha
	END IF

	IF ii_current_page > 1 THEN
		//lm_image.m_view.m_priorpage.enabled = True
		gnv_app.of_modify_menu_attr( lm_image.m_view.m_priorpage,'enabled', True)
//		iw_parent_window.cb_prior.enabled = true  //Start Code Change ----12.19.2011 #V12 maha
	END IF
	
//	iw_parent_window.of_buttons_visible( true, false, false, true,true,false, false, false, false,false, true, false)
ELSE
	//lm_image.m_view.m_nextpage.enabled = False
	//lm_image.m_view.m_priorpage.enabled = False	
	gnv_app.of_modify_menu_attr( lm_image.m_view.m_nextpage,'enabled', False)
	gnv_app.of_modify_menu_attr( lm_image.m_view.m_priorpage,'enabled', False)	
//	iw_parent_window.cb_next.enabled = False  //Start Code Change ----12.19.2011 #V12 maha
//	iw_parent_window.cb_prior.enabled = False  //Start Code Change ----12.19.2011 #V12 maha
//	iw_parent_window.of_buttons_visible( false, false, false, false,false,false, false, false, false,false, false, false)
END IF

Return 1
end function

public function integer of_check_for_image ();//For indicating whether an image is currently being displayed.
//Added by  Nova 09.25.2009------------------------
Boolean lb_blank = false  //Added by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)

//Added by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)
IF is_ext = 'PDF' THEN
	IF tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.Object.filename = '' THEN
		lb_blank = true
	ELSE
		lb_blank = false
	END IF 
ELSE
	IF tab_view.tabpage_image.ole_scan_edit.Object.Imagedisplayed = False THEN
		lb_blank = true
	ELSE
		lb_blank = false
	END IF
END IF

//IF tab_view.tabpage_image.ole_scan_edit.Object.Imagedisplayed = False THEN
IF lb_blank THEN
	MessageBox("Information","There is no Image.")
	RETURN -1
ELSE
	RETURN 1
END IF
end function

public function integer of_bg_color (long al_rgb);long ll_rgb

ll_rgb = al_rgb

this.backcolor = ll_rgb
tab_view.backcolor = ll_rgb
tab_view.tabpage_browse.backcolor = ll_rgb
tab_view.tabpage_image.backcolor = ll_rgb
tab_view.tabpage_setup.backcolor = ll_rgb
tab_view.tabpage_image.cbx_1.backcolor = ll_rgb
//tab_view.tabpage_browse.dw_browse.Object.DataWindow.Color = ll_rgb
st_page.backcolor = ll_rgb
st_recs.backcolor = ll_rgb
st_format.backcolor = ll_rgb
//alfee 11.17.2010
st_zoom.backcolor = ll_rgb 
cbx_show.backcolor = ll_rgb

return 1
end function

public function integer of_set_alert_text (string as_text);//Start Code Change ----08.04.2010 #V10 maha
If as_text = "F" then
	st_alert.visible = false
else
	st_alert.visible = true
	st_alert.text = as_text
end if

return 1
end function

public function integer of_select_for_scanning ();//Start Code Change ----03.28.2011 #V11 maha - copied from original code modified for facility-specific functionality

try
tab_view.tabpage_image.ole_scan_edit.Object.ClearDisplay(  ) //maha 061201
tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.Object.FileName = '' //Added by (APPEON) Harry 11.13.2017 (V161 Storage of Documents as PDFs)
catch (runtimeerror rte)
end try

Boolean lb_append = False
Boolean lb_ver_doc = False
Integer li_screen_id
Integer li_ans
Integer li_rec_cnt  
Integer i
Integer d
integer li_rcdel
Integer li_delrow
Integer li_start_page
Integer li_num_page
Integer li_start_check
Integer li_new_row
Integer li_retval
Integer li_cr
long li_found  //maha 12/01/2011 - changed from integer
long li_facility_id //maha 12/01/2011 - changed from integer
integer li_success  
Integer li_image_type
integer li_lastfound  //maha 04.01.2011
integer li_currow  //maha 09.01.2011
Long ll_seq_no,ll_image_id
long li_ref_field_id 
Long ll_rec_id
Long ll_prac_id
long ll_imgid[]
long ll_id
String ls_doc_id
String ls_reference
String ls_ref_field_name
String ls_field_type
String ls_data
string ref_type 
string ls_lu_field_type 
String ls_find 
string ls_ow_type
string ls_mes //maha 09.30.2014
DataWindowChild dwchild,ldw_child
Datawindow dw_data, dw_image_list, dw_image_data, dw_browse
Blob lb_null_image
gs_variable_array ls_array
String ls_ext //Added by (APPEON) Harry 11.13.2017 (V161 Storage of Documents as PDFs)

dw_data = tab_view.tabpage_setup.dw_data
dw_image_list = tab_view.tabpage_setup.dw_image_list
dw_image_data = tab_view.tabpage_setup.dw_image_data
dw_browse = tab_view.tabpage_browse.dw_browse

if of_check_add("SELECT") = 1 then //Start Code Change ----04.02.2012 #V12 maha
	return -1 
end if

//Get image storage type
IF ii_image_storage_type = 1 THEN
	//don't need to test if image comes from database
else //trap to see if file exists
	if is_image_file_name <> "" then
		if not fileexists(is_image_file_name) and dw_browse.rowcount( ) > 0 then 
			messagebox(iw_parent_window.title, 'Image ' + is_image_file_name + ' does not exist. Please check to see if the image folder has been moved.' )
			return -1
		end  if
	end if
END IF

//Start Code Change ----08.31.2011 #V11 maha - as the sort is needed only the single file storage, only use it for that
IF ii_image_storage_type = 0 THEN
//set the sort if changed (primarily for stored on hard drive)
dw_browse.setsort("start_page")
dw_browse.sort()
end if
//End Code Change ----08.31.2011 

ls_ext = Lower(Mid(is_image_file_name,LastPos(is_image_file_name, '.' ) + 1 )) //Added by (APPEON) Harry 11.13.2017 (V161 Storage of Documents as PDFs)

SetNull( lb_null_image )

li_cr = dw_data.GetRow()
li_image_type = dw_image_list.GetItemNumber( dw_image_list.GetRow(), "image_type_id" ) 

IF li_cr = 0 then return -1

li_screen_id = dw_image_list.GetItemNumber( dw_image_list.GetRow(), "link_to_screen" )
//Verification image type?
IF dw_image_list.GetItemNumber( dw_image_list.GetRow(), "image_type_id" ) = 99 THEN
	lb_ver_doc = True
END IF
	
//Test to see if image exists
//Verification images
IF lb_ver_doc THEN	//verification
	li_screen_id = dw_data.GetItemNumber( li_cr, "screen_id" )
	ls_reference = dw_data.GetItemString( dw_data.GetRow(), "reference_value" )
	ref_type = "V"
	ls_doc_id = dw_data.GetItemString( dw_data.GetRow(), "doc_id" )
	//check for image in browse list
	ls_find =  "doc_id = '" + ls_doc_id + "'"
	
	for i = 1 to dw_browse.rowcount( )
		if dw_browse.getitemstring(i,"doc_id") = ls_doc_id and dw_browse.getitemnumber(i,"active_status") = 1 then
			ll_imgid[upperbound(ll_imgid) + 1] = dw_browse.getitemnumber(i,"image_pk")
		end if
	next
	//Basic Info Connected images
ELSEIF li_screen_id = 1 THEN 
	ls_reference = dw_image_list.GetItemString( dw_image_list.GetRow(), "image_type_description" ) 		
	ref_type = "I"
	
	ls_find =  "image_type_id = " + string(li_image_type) //maha changed search to image type from reference
	li_rec_cnt =  tab_view.tabpage_browse.dw_browse.find( ls_find, 1, 10000) 
	
	for i = 1 to dw_browse.rowcount( )
		if dw_browse.getitemnumber(i,"image_type_id") = li_image_type and dw_browse.getitemnumber(i,"active_status") = 1 then
			ll_imgid[upperbound(ll_imgid) + 1] = dw_browse.getitemnumber(i,"image_pk")
			li_lastfound = i
		end if
	next
	
	//get the recid if there are existing records else set the recid
	if upperbound(ll_imgid[]) > 0 then
		ll_rec_id = dw_browse.getitemnumber(li_lastfound, /*"rec_id"*/"pd_images_rec_id") //Modify by Stephen 04.06.2011 --- column name error
	else
		ll_rec_id = gnv_app.of_Get_Id("RECORD_ID")
	end if
		
	//Connected to data entry records
ELSE	
	ref_type = "R"
	ll_rec_id = dw_data.GetItemNumber( dw_data.GetRow(), "rec_id" ) 	
	
	for i = 1 to dw_browse.rowcount( )
		if dw_browse.getitemnumber(i,"pd_images_rec_id") = ll_rec_id and dw_browse.getitemnumber(i,"active_status") = 1 then
			ll_imgid[upperbound(ll_imgid) + 1] = dw_browse.getitemnumber(i,"image_pk")
		end if
	next

END IF

li_rec_cnt = upperbound(ll_imgid[])
	
//If records found open options window and process as selected
IF li_rec_cnt > 0 THEN
	ls_array.as_number = ll_imgid
	Openwithparm( w_overwrite_msg, ls_array )
	//handle results C, O,F,A,P

	//messagebox("",Message.StringParm)
	 ls_ow_type = mid(Message.StringParm,1,1)
	Choose case  ls_ow_type
		Case "C"  //Cancel
			Return -1
		Case "P"  //Append to existing record
			//will be coded for V11.3.  
			if dw_image_data.rowcount() > 0 then
				messagebox("Append","Append to existing Image cannot be selected when other records have been selected.")
				return -1
			end if
			// as no additional records are added this option should open a window for get from file or Scan, get additional image and step out of this function
			//the scan date and user should be updated
			//----------------APPEON BEGIN------------------------
			//$<add> long.zhang 10.13.2011
			//$<reason> append Existing image
				ll_id = long(mid(Message.StringParm,2))
				li_delrow = tab_view.tabpage_browse.dw_browse.find( "image_pk = " + string(ll_id) , 1, dw_browse.rowcount() )
				if li_delrow < 1 then return -1
				if of_insert_pages(li_delrow) = -1 then return -1	
			//----------------APPEON END--------------------------	
		Case Else //O,F,A
			ll_id = long(mid(Message.StringParm,2))
			li_delrow = tab_view.tabpage_browse.dw_browse.find( "image_pk = " + string(ll_id) , 1, dw_browse.rowcount() )
			debugbreak()
			If ls_ow_type = "A" and li_delrow > 0 then  //add send org to history
				dw_browse.setitem(li_delrow,"active_status",0)
				li_facility_id =  tab_view.tabpage_browse.dw_browse.getitemnumber(li_delrow, "pd_images_facility_id")  //Add by Stephen 05.04.2011 --- Fixed a bug.
				inv_dw.of_field_audit(dw_browse) //(Appeon)Stephen 11.01.2016 - V15.3-Image Auditing in IntelliCred
				dw_browse.update()
			Elseif ls_ow_type = "F" then  //Add additional for another facility
				//do nothing here
			ElseIF  ls_ow_type = "O" THEN  //Overwrite ***************************
				li_rcdel = dw_browse.rowcount()
				if li_delrow < 1 then 
					return -1
				end if
				li_start_page = dw_browse.GetItemNumber( li_delrow, "start_page" )
				li_num_page = dw_browse.GetItemNumber( li_delrow, "num_pages" )
				li_facility_id =  tab_view.tabpage_browse.dw_browse.getitemnumber(li_delrow, "pd_images_facility_id") //Add by Stephen 05.04.2011 --- Fixed a bug.
				inv_dw.of_field_audit_delete_last(dw_browse, li_delrow) //(Appeon)Stephen 11.01.2016 - V15.3-Image Auditing in IntelliCred
				dw_browse.DeleteRow( li_delrow )			
				IF ii_image_storage_type = 1 THEN			
					//IF stored in db then do nothing because when you delete the pd_image row you delete the image
				ELSE
					//reset page numbers for storage in hard drive
					IF ls_ext = 'pdf' THEN //Added by (APPEON) Harry 11.13.2017 (V161 Storage of Documents as PDFs)
						tab_view.tabpage_browse.ole_admin_pdf.ole_edit.Object.LoadMultiPage( is_image_file_name, 1)
						if of_check_page_count(li_start_page, tab_view.tabpage_browse.ole_admin_pdf.ole_edit.Object.GetTotalPage() ,li_num_page) = -1 then
							return -1
						end if
						if li_start_page > 0 then // trap 
							IF NOT IsValid(w_dm_image_cp) THEN Open(w_dm_image_cp)
							w_dm_image_cp.of_delete_page_pdf(tab_view.tabpage_browse.ole_admin.Object.FileName, li_start_page, li_num_page)
							Close(w_dm_image_cp)
						end if
					ELSE
						tab_view.tabpage_browse.ole_admin.Object.Image( is_image_file_name )
		
						if of_check_page_count(li_start_page, tab_view.tabpage_browse.ole_admin.Object.PageCount ,li_num_page) = -1 then
							return -1
						end if
		
						if li_start_page > 0 then // trap 
							tab_view.tabpage_browse.ole_admin.Object.DeletePages( li_start_page, li_num_page )
						end if
					END IF
					//reset page numbers
					li_start_check = 1
					for d = 1 to dw_browse.rowcount() //reset all start pages 
						tab_view.tabpage_browse.dw_browse.setItem( d, "start_page",li_start_check )
						li_start_check = li_start_check + dw_browse.GetItemNumber( d ,"num_pages")	
					next
				END IF
				
			inv_dw.of_field_audit(dw_browse) //(Appeon)Stephen 11.01.2016 - V15.3-Image Auditing in IntelliCred
			dw_browse.update()  //Start Code Change ---- 05.03.2007 #V7 maha 
			//*******************end of overwrite
		End if
	END Choose
END IF

//Get Reference value
Choose case ref_type
	case "I", "V", "P"
		//already got above or don't need
	case else //"O","A"
		//GET REFERENCE FIELD 1 DATA
		li_ref_field_id = dw_image_list.GetItemNumber( dw_image_list.GetRow(), "reference_field_1" )
		if isnull(li_ref_field_id) or li_ref_field_id = 0 then  //Start Code Change ---- 06.11.2007 #V7 maha
			ls_mes = "There is no Reference Field 1 set up for this data screen.~r"
			ls_mes+= "This can be set in the Screen View Utility from the Administrative Utilities.  Select the Data screen.  For Reference Field 1, select a field that will always be entered in the data record.~r"
			ls_mes+= "For assistance, please contact IntelliSoft Group support."
			MessageBox("Select Data error", ls_mes)
			return -1
		end if

		ls_ref_field_name = gnv_data.of_getitem( "sys_fields","field_name", "field_id = "+String(li_ref_field_id))
		ls_field_type = gnv_data.of_getitem( "sys_fields","field_type", "field_id = "+String(li_ref_field_id))
		
		if dw_data.Describe(ls_ref_field_name + ".ColType") = "!" then  //Start Code Change ---- 06.11.2007 #V7 maha trap
			//---------Begin Modified by (Appeon)Stephen 09.18.2016 for another of the same error messages --------
			//MessageBox("Select Data error", "Required field, "  + ls_ref_field_name +  ", is not a valid Field on this data screen.  Please contact IntelliSoft Group support for assistance before adding image items for this screen. ")
			MessageBox("Select Data error", "Required field, "  + ls_ref_field_name + "(field_id = "+String(li_ref_field_id) + "), is not a valid Field on this data screen.  Please contact IntelliSoft Group support for assistance before adding image items for this screen. ")
			//---------End Modfiied ------------------------------------------------------
			return -1
		end if
		
		dw_data.SetTabOrder( ls_ref_field_name, 1 )
		dw_data.SetColumn( ls_ref_field_name )
		dw_data.setrow(li_cr)//maha 071701

		li_retval = dw_data.GetChild(ls_ref_field_name, dwchild)
		debugbreak()
		ls_data =  dw_data.GetText()
		IF li_retval = -1 THEN
			ls_data =  dw_data.GetText()				
		ELSE	
			li_found = dwchild.Find( "lookup_code = " + ls_data,1,1000000 )	
			if li_found < 1 then
				messagebox("Find lookup Error","Lookup record not found for " + ls_ref_field_name + ".  Check for missing data.")
				return -1
			end if
	
			IF dw_data.Describe( ls_ref_field_name + ".dddw.displaycolumn") = "code" or  dw_data.Describe( ls_ref_field_name + ".dddw.displaycolumn") = "description" THEN //maha 071401 changed from code only
				ls_data = dw_data.GetText() //trap for null lookup data
				IF IsNull( ls_data ) THEN
					ls_data = ""
				else
					ls_data = dwchild.GetItemString( li_found, "code" )
				end if
			ELSEIF dw_data.Describe( ls_ref_field_name + ".dddw.displaycolumn") = "entity_name" THEN
				ls_data = dw_data.GetText()//trap for null lookup data
				IF IsNull( ls_data ) THEN
					ls_data = ""
				else
					if dwchild.rowcount() > 0 then  
						ls_data = dwchild.GetItemString( li_found, "entity_name_original" )
					else
						ls_data = ""
					end if
				end if
			ELSE
				ls_data = dw_data.GetText()				
			END IF
		END IF

		IF IsNull( ls_data ) THEN
			ls_reference = ""
		ELSE 
			ls_reference = ls_data
		END IF

		//GET REFERENCE FIELD 2 DATA
		li_ref_field_id = dw_image_list.GetItemNumber( dw_image_list.GetRow(), "reference_field_2" )

		ls_ref_field_name = gnv_data.of_getitem( "sys_fields","field_name", "field_id = "+String(li_ref_field_id))
		ls_field_type = gnv_data.of_getitem( "sys_fields","field_type", "field_id = "+String(li_ref_field_id))

		if dw_data.Describe(ls_ref_field_name + ".ColType") <> "!" then  // trap for bad reference 2
			dw_data.SetTabOrder( ls_ref_field_name, 1 )
			dw_data.SetColumn( ls_ref_field_name )
			dw_data.setrow(li_cr)
			li_retval = dw_data.GetChild(ls_ref_field_name, dwchild)
			ls_data = dw_data.GetText()
			
			IF IsNull( ls_data ) THEN //trap for null lookup 062805
				ls_data = ""
			else
				IF li_retval = -1 THEN
					ls_data =  dw_data.GetText()				
					ELSE
					li_found = dwchild.Find( "lookup_code = " + dw_data.GetText(), 1, 1000000 )
					if li_found < 1 then //maha 061501
						ls_data = ""
					else
						IF dw_data.Describe( ls_ref_field_name + ".dddw.displaycolumn") = "code" THEN
							ls_data = dwchild.GetItemString( li_found, "code" )
						ELSEIF dw_data.Describe( ls_ref_field_name + ".dddw.displaycolumn") = "description" THEN  //Start Code Change ----09.02.2010 #V10 maha - added description option
							ls_data = dwchild.GetItemString( li_found, "description" )
						ELSEIF dw_data.Describe( ls_ref_field_name + ".dddw.displaycolumn") = "entity_name" THEN
							ls_data = dwchild.GetItemString( li_found, "entity_name_original" )
						ELSE
							ls_data = dw_data.GetText()				
						END IF
					end if
				END IF
			end if
		else
			ls_data = ""
		end if

		IF NOT IsNull( ls_reference ) THEN
			ls_reference = ls_reference + " - " + ls_data
		END IF	
End choose
	
//trap for overlong values
ls_reference = MidA(ls_reference,1,100)
	
IF dw_image_data.GetItemStatus( 1, 0, Primary! ) = New! THEN
	dw_image_data.DeleteRow( 0 )	
END IF

li_success = dw_image_data.getchild('facility_id',ldw_child)
IF li_success = 1 THEN
	ldw_child.settransobject(SQLCA)
	ldw_child.retrieve(gs_user_id)   
	ldw_child.insertrow(1)
	ldw_child.setitem(1,'facility_id',0)
	ldw_child.setitem(1,'facility_name','ALL')
END IF
	  
If ls_ow_type = "P" then //	
	
else 
	//Start Code Change ----04.01.2011 #V11 maha - readded to set seq_no
	IF ref_type = "V" THEN //for verifs seq no based on doc id
		SELECT Max( seq_no )  
		INTO :ll_seq_no  
		FROM pd_images  
		WHERE pd_images.doc_id = :ls_doc_id ;
		IF SQLCA.SQLCODE = -1 THEN
			MessageBox("Database Error", SQLCA.SQLERRTEXT )
		END IF
	else //seq no based on recid
		SELECT Max( seq_no )  
		INTO :ll_seq_no  
		FROM pd_images  
		WHERE pd_images.rec_id = :ll_rec_id ;
		IF SQLCA.SQLCODE = -1 THEN
			MessageBox("Database Error", SQLCA.SQLERRTEXT )
		END IF
	End If
	
	IF IsNull( ll_seq_no ) THEN
		ll_seq_no = 0
	END IF
	
	ll_seq_no++
	//Start Code Change ----04.01.2011
	
	li_new_row = dw_image_data.InsertRow( 0 )
	dw_image_data.ScrollToRow( li_new_row )
	dw_image_data.SetRow( li_new_row )
	dw_image_data.SetItem( li_new_row, "image_type_id",li_image_type )
	dw_image_data.SetItem( li_new_row, "prac_id", il_prac_id )
	dw_image_data.SetItem( li_new_row, "seq_no", ll_seq_no ) //Start Code Change ----04.01.2011 maha readded set of seq (from 1)
	dw_image_data.SetItem( li_new_row, "rec_id", ll_rec_id  )
	//------------------- APPEON BEGIN -------------------
	//$<modify> Stephen 05.04.2011
	//$<reason> N/A
	/*
	dw_image_data.SetItem( li_new_row, "facility_id", 0  )
	*/
	if isnull(li_facility_id) then li_facility_id = 0
	dw_image_data.SetItem( li_new_row, "facility_id", li_facility_id) 
	//------------------- APPEON END -------------------
	
	dw_image_data.SetItem( li_new_row, "screen_id", li_screen_id )	
	dw_image_data.SetItem( li_new_row, "reference_name", ls_reference )
	dw_image_data.SetItem( li_new_row, "active_status", 1 )	
	dw_image_data.SetItem( li_new_row, "num_pages", dw_image_list.GetItemNumber( dw_image_list.GetRow(), "default_pages" ) )

	IF ref_type = "V" THEN //for verification set doc_id
		dw_image_data.SetItem( li_new_row, "doc_id", ls_doc_id )	
	END IF
END IF

dw_image_data.SetColumn( "notes" )
dw_image_data.SetFocus( )
	
dw_image_data.SetItem( li_new_row, "date_scanned", DateTime( Today(), Now()) )
dw_image_data.SetItem( li_new_row, "user_name", gnv_app.of_GetUserId() )

dw_image_data.SetItem(  li_new_row , "de_queue", 0 ) 

tab_view.tabpage_setup.cb_scan.Enabled = True
tab_view.tabpage_setup.cb_from_file.Enabled = True
tab_view.tabpage_setup.cb_remove.Enabled = True


return 1
end function

public function integer of_check_fac (string as_type);//////////////////////////////////////////////////////////////////////
// $<function> of_check_fac
// $<arguments>
//               string as_type
// $<returns> (None)
// $<description> Check Duplicate Record
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Stephen 05.03.2011
//////////////////////////////////////////////////////////////////////

long ll_fac, ll_screen, ll_imagepk, ll_recid
integer li_row , li_find, li_cnt,li_active, li_rowcount
dwitemstatus lds_1

//if tab_view.tabpage_browse.dw_browse.rowcount() < 1 then return 0  //Start Code Change ----04.02.2012 #V12 maha - removed

if as_type = 'A' then
	if tab_view.tabpage_setup.dw_image_data.getrow() < 1 then return 0
	li_rowcount = tab_view.tabpage_setup.dw_image_data.rowcount()
	li_cnt  = tab_view.tabpage_browse.dw_browse.rowcount()
	for li_row = 1 to li_rowcount
		IF tab_view.tabpage_setup.dw_image_data.getitemnumber(li_row, "image_type_id" ) = 99 THEN Continue    //Start Code Change ----05.20.2015.2015 #V15 maha - trap for verif type

		ll_screen = tab_view.tabpage_setup.dw_image_data.getitemnumber(li_row, "screen_id")
		ll_recid   = tab_view.tabpage_setup.dw_image_data.getitemnumber(li_row, "rec_id") 
		li_find =  tab_view.tabpage_browse.dw_browse.find(" active_status =1 and pd_images_rec_id = "+ string(ll_recid) +" and pd_images_facility_id =0 and pd_images_screen_id = "+ string(ll_screen),1, li_cnt)
		if li_find > 0 then return -1	
		li_find = tab_view.tabpage_setup.dw_image_data.find(" facility_id =0  and rec_id =  "+ string(ll_recid) +" and screen_id = "+ string(ll_screen) ,1, li_rowcount)
		if li_find = li_row then li_find = tab_view.tabpage_setup.dw_image_data.findnext()
		if li_find > 0 then return -1	
		
		ll_fac = tab_view.tabpage_setup.dw_image_data.getitemnumber(li_row, "facility_id")
		if ll_fac = 0 then
			li_find = tab_view.tabpage_setup.dw_image_data.find(" screen_id = "+ string(ll_screen) + "  and rec_id =  "+ string(ll_recid), 1, li_rowcount)
			if li_find = li_row then li_find = tab_view.tabpage_setup.dw_image_data.findnext()
			if li_find > 0 then return -1	
		
			li_find =  tab_view.tabpage_browse.dw_browse.find(" active_status =1 and pd_images_rec_id = "+ string(ll_recid) +" and pd_images_screen_id = "+ string(ll_screen) ,1, li_cnt)
			if li_find > 0 then return -1	
		end if
		
		li_find = tab_view.tabpage_setup.dw_image_data.find(" facility_id = "+string(ll_fac)  + "  and rec_id =  "+ string(ll_recid) +" and screen_id = "+ string(ll_screen) ,1, li_rowcount)
		if li_find = li_row then li_find = tab_view.tabpage_setup.dw_image_data.findnext()
		if li_find > 0 then return -1	
		
		li_find =  tab_view.tabpage_browse.dw_browse.find(" active_status =1   and pd_images_rec_id = "+ string(ll_recid) + " and  pd_images_facility_id = "+string(ll_fac) +" and pd_images_screen_id = "+ string(ll_screen) ,1, li_cnt)
		if li_find > 0 then return -1
	next
else
	tab_view.tabpage_browse.dw_browse.accepttext()
	li_cnt = tab_view.tabpage_browse.dw_browse.getrow()
	li_row =   tab_view.tabpage_browse.dw_browse.rowcount()
	if li_cnt  < 1 then return 0
	ll_fac = tab_view.tabpage_browse.dw_browse.getitemnumber(li_cnt, "pd_images_facility_id")
	ll_imagepk =  tab_view.tabpage_browse.dw_browse.getitemnumber(li_cnt, "image_pk")
	li_active =  tab_view.tabpage_browse.dw_browse.getitemnumber(li_cnt, "active_status")
	ll_recid   = tab_view.tabpage_browse.dw_browse.getitemnumber(li_cnt, "pd_images_rec_id") 
	if li_active <> 1 then return 0
	ll_screen = tab_view.tabpage_browse.dw_browse.getitemnumber(li_cnt, "pd_images_screen_id")
	if ll_fac =0 then
		li_find =  tab_view.tabpage_browse.dw_browse.find(" active_status =1 and pd_images_rec_id = "+ string(ll_recid) + " and image_pk <> "+ string(ll_imagepk)+" and pd_images_screen_id = "+ string(ll_screen), 1, li_row)
		if li_find > 0 then
//			tab_view.tabpage_browse.dw_browse.selectrow(0,false)	 //Start Code Change ----01.20.2016 #V15 maha - removed
//			tab_view.tabpage_browse.dw_browse.selectrow(li_cnt,true)
			tab_view.tabpage_browse.dw_browse.scrolltorow(li_cnt)	
			return -1	
		end if
	else
		li_find =  tab_view.tabpage_browse.dw_browse.find(" active_status =1 and image_pk <> "+ string(ll_imagepk)+ " and pd_images_rec_id = "+ string(ll_recid) + " and  pd_images_facility_id = 0 and pd_images_screen_id = "+ string(ll_screen), 1, li_row)
		if li_find > 0 then
//			tab_view.tabpage_browse.dw_browse.selectrow(0,false)	   //Start Code Change ----01.20.2016 #V15 maha - removed
//			tab_view.tabpage_browse.dw_browse.selectrow(li_cnt,true)
			tab_view.tabpage_browse.dw_browse.scrolltorow(li_cnt)	
			return -1	
		end if
		li_find =  tab_view.tabpage_browse.dw_browse.find(" active_status =1 and pd_images_rec_id = "+ string(ll_recid) + " and image_pk <> "+ string(ll_imagepk)+ " and  pd_images_facility_id = "+string(ll_fac) +" and pd_images_screen_id = "+ string(ll_screen),1, li_row)
			if li_find > 0 then
//			tab_view.tabpage_browse.dw_browse.selectrow(0,false)	 //Start Code Change ----01.20.2016 #V15 maha - removed
//			tab_view.tabpage_browse.dw_browse.selectrow(li_cnt,true)
			tab_view.tabpage_browse.dw_browse.scrolltorow(li_cnt)	
			return -1	
		end if

	end if		
	 if li_find > 0 then
//		tab_view.tabpage_browse.dw_browse.selectrow(0,false)	  //Start Code Change ----01.20.2016 #V15 maha - removed
//		tab_view.tabpage_browse.dw_browse.selectrow(li_cnt,true)
		tab_view.tabpage_browse.dw_browse.scrolltorow(li_cnt)	
		return -1	
	end if
end if

return 0
end function

public function integer of_set_historical ();integer res
integer r
integer cnt  //maha 05.17.2017


//Start Code Change ----05.17.2017 #V154 maha - changed logic to use the checkboxes to allow multiple changes at once
for r = 1 to tab_view.tabpage_browse.dw_browse.rowcount()
	if tab_view.tabpage_browse.dw_browse.getitemnumber(r, "selected") = 1 and tab_view.tabpage_browse.dw_browse.getitemnumber(r, "active_status") = 1 then
		cnt++
	end if
next

if cnt = 0 then
	messagebox("Set Historical","Please check the Selected checkbox for the records you wish to make Historical")
	return 0
else
	res = messagebox("Set Historical","If you set the status to historical you will not be able to reset it as Current.  Do you wish to continue?",question!,yesno!,2)

	for r = 1 to tab_view.tabpage_browse.dw_browse.rowcount()
		if tab_view.tabpage_browse.dw_browse.getitemnumber(r, "selected") = 1 and tab_view.tabpage_browse.dw_browse.getitemnumber(r, "active_status") = 1 then
			tab_view.tabpage_browse.dw_browse.setitem(r,"active_status",0)
		end if
	next
end if

//r = tab_view.tabpage_browse.dw_browse.getrow()
//
//if tab_view.tabpage_browse.dw_browse.getitemnumber(r,"active_status") = 0 then return 0
//
//res = messagebox("Set Historical","If you set this record to historical status you will not be able to reset it as Current.  Do you wish to continue?",question!,yesno!,2)
//
//if res = 1 then
//	tab_view.tabpage_browse.dw_browse.setitem(r,"active_status",0)
//end if
//End Code Change ----05.17.2017 


return 1
end function

public function integer of_insert_pages (long al_row);//==========================================
// $<Function> Append to  existing image: of_insert_page ()
// $<arguments>
// 	value    long      al_row: append image row
// $<returns> integer 1 - success; -1 - failure 
// $<description> append  existing image
// $<add> (Appeon) Long.zhang 10.13.2011
//==========================================
Integer li_i
Integer li_j
Integer li_k
Integer li_facility_id
Integer li_screen_id
Integer li_start_page

Long ll_insert_before
Long ll_page_count
Long li_goto_page
Long ll_page_num
Long ll_id
Long ll_rec_id
Long ll_prac_id
Long ll_count_before//Added by Appeon long.zhang 06.27.2016

String ls_page_count
String ls_insert_file
String ls_from_method
String ls_append_method
String ls_parm
String ls_image_path
String ls_image_name
String ls_file

Blob lb_null_image
String ls_ext //Added by (APPEON) Harry 11.09.2017 (V161 Storage of Documents as PDFs)
String ls_append_ext //Added by (APPEON) Harry 11.28.2017 (V161 Storage of Documents as PDFs)
Integer li_m //Added by (APPEON) Harry 11.28.2017 (V161 Storage of Documents as PDFs)
String ls_filename_tmp //Added by (APPEON) Harry 11.28.2017 (V161 Storage of Documents as PDFs)

n_appeon_download lnv_down
n_cst_dm_utils ln_cst_dm

ll_id = tab_view.tabpage_browse.dw_browse.getitemnumber( al_row,"image_pk")
li_start_page = tab_view.tabpage_browse.dw_browse.getitemnumber( al_row,"start_page")
ll_page_num = tab_view.tabpage_browse.dw_browse.GetItemNumber( al_row ,"num_pages")
ls_ext = tab_view.tabpage_browse.dw_browse.GetItemString( al_row ,"image_ext") //Added by (APPEON) Harry 11.09.2017 (V161 Storage of Documents as PDFs)

if ii_image_storage_type =1 then	//store in db
	ls_image_path = gs_temp_path + "images\"
	IF ls_ext = 'PDF' THEN //Added by (APPEON) Harry 11.09.2017 (V161 Storage of Documents as PDFs)
		ls_image_name = ls_image_path + String(il_prac_id) + "_" + String(ll_id) + ".pdf"  
	ELSE
		ls_image_name = ls_image_path + String(il_prac_id) + "_" + String(ll_id) + ".tif"  
	END IF
else
	Return -1
end if

if Not FileExists(ls_image_name) then	 //if not download then download image first
	ll_rec_id = tab_view.tabpage_browse.dw_browse.GetItemNumber( al_row, "pd_images_rec_id" )
	ll_prac_id = tab_view.tabpage_browse.dw_browse.GetItemNumber( al_row, "pd_images_prac_id" )	
	li_facility_id = tab_view.tabpage_browse.dw_browse.GetItemNumber( al_row, "pd_images_facility_id" )	
	li_screen_id = tab_view.tabpage_browse.dw_browse.GetItemNumber( al_row, "pd_images_screen_id" )		
	IF inv_image_functions.of_retrieve_image_from_db( ll_rec_id, ll_prac_id, li_facility_id, li_screen_id, ll_id ) = -1 THEN
		RETURN -1
	END IF
end if
if Not FileExists(ls_image_name) then
	MessageBox("Image File", "The image file " + ls_image_name + " does not exist,  Check to make sure the path exists or if the database record has an image stored in the image field." )
	return -1
end if	

IF ls_ext = 'PDF' THEN //Added by (APPEON) Harry 11.09.2017 (V161 Storage of Documents as PDFs)
	tab_view.tabpage_browse.ole_admin_pdf.ole_edit.Object.LoadMultiPage(ls_image_name, 1)
ELSE
	tab_view.tabpage_browse.ole_admin.Object.Image(ls_image_name)
END IF


OpenWithParm (w_append_pages,"*" + ls_image_path)

IF Message.StringParm = "Cancel" THEN
	RETURN -1
END IF


li_i = PosA( Message.StringParm, "-")
ls_from_method =  MidA( Message.StringParm, 1, li_i -1)
li_j = PosA( Message.StringParm, "\")
//ll_page_count = Long(MidA( Message.StringParm, li_j+1, LenA( Message.StringParm) -li_j)) //Commented by (APPEON) Harry 11.28.2017 (V161 Storage of Documents as PDFs)
ls_append_method =  MidA( Message.StringParm, li_i+1,li_j -1 -li_i )
//Added by (APPEON) Harry 11.28.2017 (V161 Storage of Documents as PDFs)
li_m = LastPos( Message.StringParm, "\")
ls_append_ext = MidA( Message.StringParm, li_m+1, LenA( Message.StringParm) -li_m)
ll_page_count = Long(MidA( Message.StringParm, li_j+1, li_m -1 - li_j))
 
li_k = PosA( ls_append_method, "0/")

IF li_k > 0 THEN
	ls_append_method = '0'
ELSE
	ll_insert_before = Long(MidA(ls_append_method,PosA(ls_append_method,"/") +1 ,LenA(ls_append_method) -PosA(ls_append_method,"/") ))
	ls_append_method = '1'
END IF

IF ls_from_method = '0' THEN
	//IF ls_ext = 'PDF' THEN //Added by (APPEON) Harry 11.09.2017 (V161 Storage of Documents as PDFs)
	IF ls_append_ext = 'PDF' THEN //Added by (APPEON) Harry 11.28.2017 (V161 Storage of Documents as PDFs)
		ls_insert_file = ls_image_path + "temp.pdf"
	ELSE
		ls_insert_file = ls_image_path + "temp.tif"
	END IF
ELSEIF ls_from_method = '1' THEN
	ls_insert_file = ls_image_path+ "scanappend.tif"
	ls_append_ext = 'TIF'  //Added by (APPEON) Harry 11.28.2017 (V161 Storage of Documents as PDFs)
ELSEIF ls_from_method = '2' THEN
	ls_insert_file = ls_image_path + "blankpage.tif"
	ls_append_ext = 'TIF'  //Added by (APPEON) Harry 11.28.2017 (V161 Storage of Documents as PDFs)
	IF Not FileExists(ls_insert_file) THEN lnv_down.of_downloadfile("" ,ls_insert_file)
END IF

IF Not FileExists(ls_insert_file) THEN RETURN -1

IF ls_ext <> 'PDF' THEN //Added by (APPEON) Harry 11.09.2017 (V161 Storage of Documents as PDFs)
	IF tab_view.tabpage_browse.ole_admin.Object.PageCount() > 0 And tab_view.tabpage_browse.ole_admin.Object.FileType <> 1 THEN
		MessageBox('Image','The current image file must be in "TIF" format.')
		RETURN -1
	END IF
END IF

if ii_image_storage_type = 1 then	//store in db
	IF ls_ext = 'PDF' THEN //Added by (APPEON) Harry 11.09.2017 (V161 Storage of Documents as PDFs)
		IF ls_append_method = '0' OR tab_view.tabpage_browse.ole_admin_pdf.ole_edit.Object.GetTotalPage () < ll_insert_before THEN
				ll_insert_before = tab_view.tabpage_browse.ole_admin_pdf.ole_edit.Object.GetTotalPage () +1
		END IF
	ELSE
		IF ls_append_method = '0' OR tab_view.tabpage_browse.ole_admin.Object.PageCount() < ll_insert_before THEN
				ll_insert_before = tab_view.tabpage_browse.ole_admin.Object.PageCount() +1
		END IF
	END IF
else
	
end if

//------------------- APPEON BEGIN -------------------
//<$>Modified:long.zhang 06.27.2016
//<$>reason: Add the error message, for Images not showing up under documents Case#64910 Bug_id# 5212

//Inserts one or more user-specified pages into the current image file
//tab_view.tabpage_browse.ole_admin.Object.Insert(ls_insert_file, 1, ll_insert_before, ll_page_count )//Comment by Appeon long.zhang 06.27.2016

IF ls_ext = 'PDF' THEN //Added by (APPEON) Harry 11.09.2017 (V161 Storage of Documents as PDFs)
	ll_count_before = tab_view.tabpage_browse.ole_admin_pdf.ole_edit.Object.GetTotalPage()
	IF NOT IsValid(w_dm_image_cp) THEN Open(w_dm_image_cp) 
	IF ls_append_ext = 'TIF' THEN   //Added by (APPEON) Harry 11.28.2017 (V161 Storage of Documents as PDFs)
		ls_filename_tmp = Mid(ls_insert_file, 1, LastPos(ls_insert_file, '.')) + 'pdf'
		w_dm_image_cp.of_image2pdf (ls_insert_file, ls_filename_tmp)
		ls_insert_file = ls_filename_tmp
	END IF
	w_dm_image_cp.of_insert_page_pdf(ls_image_name, ls_insert_file,  ll_insert_before, 1, ll_page_count)
	Close(w_dm_image_cp)  
ELSE
	ll_count_before = tab_view.tabpage_browse.ole_admin.Object.PageCount()
	IF  ls_append_ext = 'PDF' THEN   //Added by (APPEON) Harry 11.28.2017 (V161 Storage of Documents as PDFs)
		IF NOT IsValid(w_dm_image_cp) THEN Open(w_dm_image_cp) 
		ls_filename_tmp = Mid(ls_image_name, 1, LastPos(ls_image_name, '.')) + 'pdf'
		w_dm_image_cp.of_image2pdf (ls_image_name, ls_filename_tmp)
		ls_image_name = ls_filename_tmp
		w_dm_image_cp.of_insert_page_pdf(ls_image_name, ls_insert_file,  ll_insert_before, 1, ll_page_count)
		Close(w_dm_image_cp)
		ls_ext = 'PDF' 
	ELSE
		tab_view.tabpage_browse.ole_admin.Object.Insert(ls_insert_file, 1, ll_insert_before, ll_page_count )
	END IF
END IF

//tab_view.tabpage_browse.ole_admin.Object.Image(ls_image_name) //Refresh
//If  tab_view.tabpage_browse.ole_admin.Object.PageCount() <> ll_count_before + ll_page_count Then
IF ls_ext = 'PDF' THEN //Added by (APPEON) Harry 11.09.2017 (V161 Storage of Documents as PDFs)
	Long ll_pagecnt_tmp
	IF NOT IsValid(w_dm_image_cp) THEN Open(w_dm_image_cp) 
	ll_pagecnt_tmp = w_dm_image_cp.of_gettotalpage(ls_image_name)
	Close(w_dm_image_cp)
	If ll_pagecnt_tmp <> ll_count_before + ll_page_count Then
		MessageBox('Image','Insert ' +String(ll_page_count) +' new page(s) to current image file failed. Please try again.')
		FileDelete(ls_image_name) //Delete the wrong file
		IF ls_insert_file <> ls_image_path + "blankpage.pdf" THEN FileDelete(ls_insert_file)
		RETURN -1
	End If
ELSE
	tab_view.tabpage_browse.ole_admin_count.Object.Image('')  //Use another ole (ole_admin_count) to count pages, modified by Appeon long.zhang 08.24.2016 (Images not showing up under documents Case#64910 Bug_id#5212)
	tab_view.tabpage_browse.ole_admin_count.Object.Image(ls_image_name) 
	If  tab_view.tabpage_browse.ole_admin_count.Object.PageCount() <> ll_count_before + ll_page_count Then
		MessageBox('Image','Insert ' +String(ll_page_count) +' new page(s) to current image file failed. Please try again.')
		FileDelete(ls_image_name) //Delete the wrong file
		IF ls_insert_file <> ls_image_path + "blankpage.tif" THEN FileDelete(ls_insert_file)
		RETURN -1
	End If
END IF

//------------------- APPEON END -------------------

//delete temp image file 
IF ls_ext = 'PDF' THEN //Added by (APPEON) Harry 11.09.2017 (V161 Storage of Documents as PDFs)
	IF ls_insert_file <> ls_image_path + "blankpage.pdf" THEN FileDelete(ls_insert_file)
	ls_file =  gs_temp_path + "images\" + String(il_prac_id) + "_" + String(ll_id) + ".pdf"
ELSE
	IF ls_insert_file <> ls_image_path + "blankpage.tif" THEN FileDelete(ls_insert_file)
	ls_file =  gs_temp_path + "images\" + String(il_prac_id) + "_" + String(ll_id) + ".tif"
END IF

if ln_cst_dm.of_readblob(ls_file, lb_null_image) = -1 then
		MessageBox("Prompt"," Save file "+ls_file+" to  BLOB data fail")
		return -1
end if

//Update the image and field properties
ll_page_count += ll_page_num

tab_view.tabpage_browse.dw_browse.setitem( al_row,"num_pages",ll_page_count)
tab_view.tabpage_browse.dw_browse.setitem( al_row,"pd_images_date_scanned",datetime(today(),now()))
tab_view.tabpage_browse.dw_browse.setitem( al_row,"pd_images_user_name",gs_user_id)

inv_dw.of_field_audit(tab_view.tabpage_browse.dw_browse) //(Appeon)Stephen 11.01.2016 - V15.3-Image Auditing in IntelliCred
gnv_appeondb.of_startqueue( )

tab_view.tabpage_browse.dw_browse.update( )
commit;
//Added by (APPEON) Harry 11.28.2017 (V161 Storage of Documents as PDFs)
UPDATE pd_images
	SET image_ext = :ls_ext
WHERE image_pk = :ll_id;

UPDATEBLOB  pd_images
	 SET image_data = :lb_null_image
	  WHERE image_pk = :ll_id;
COMMIT;

gnv_appeondb.of_commitqueue( )
of_set_alert_text("Append Image function completed.")	//added by long.zhang 04.06.2012
RETURN 1




end function

public function integer of_disable_buttons ();//Start Code Change ----03.28.2012 #V12 maha
integer cnt

cnt = tab_view.tabpage_setup.dw_image_data.rowcount() 

if  cnt = 0 then
	tab_view.tabpage_setup.cb_from_file.enabled = false
	tab_view.tabpage_setup.cb_remove.enabled = false
	tab_view.tabpage_setup.cb_scan.enabled = false
end if

return 1
end function

public function integer of_button_visible (integer ai_index);//Start Code Change ----03.28.2012 #V12 maha
//of_buttons_visible( Save, Add , Delete, Next, Prior, Notes, Print, B3, B4, B5, B6, B7 )
//Start Code Change ----10.30.2012 #V12 maha - childrens hosp customization
Boolean lb_TIF //Added by (APPEON) Harry 11.20.2017 (V161 Storage of Documents as PDFs)
if gb_use_prac_toolbar = true then
	return 1
end if

IF ai_index = 1 THEN
	
	iw_parent_window.cb_print.text =  "Print List"	
	iw_parent_window.cb_b3.text =  "Print Image"
	iw_parent_window.cb_b4.text =  "Email Image"
	iw_parent_window.cb_b5.text =  "Fax Image"
	iw_parent_window.cb_b6.text =  "Extract"
	iw_parent_window.cb_b7.text =  "Fix Assoc"
	//cb_b6.text =  "Properties"
	if w_mdi.of_security_access(1000) = 1 then //read only
		iw_parent_window.of_buttons_visible( False,  False,   False, True,  True,  True, True,  True, False, False, False,  False)
	//Start Code Change ----07.05.2016 #V152 maha	
	else 
		if w_mdi.of_security_access( 7824 ) = 0 then
 			iw_parent_window.of_buttons_visible( True,  False,   True, True,  True,  True, True,  True,  True,  True,  True,  False)
		else
			iw_parent_window.of_buttons_visible( True,  False,   True, True,  True,  True, True,  True,  True,  True, True, True)
		end if
		//End Code Change ----07.05.2016
	end if

ELSEIF ai_index = 2 THEN	
	iw_parent_window.cb_add.text =  "Print Img"
	iw_parent_window.cb_print.text =  "Properties"
	iw_parent_window.cb_b3.text =  "Select"
	iw_parent_window.cb_b4.text =  "Highlight"
	iw_parent_window.cb_b5.text =  "Note"
	iw_parent_window.cb_b6.text =  "Straighten"
	iw_parent_window.cb_b7.text =  "Rotate"
	if w_mdi.of_security_access(1000) = 1 then //read only
		iw_parent_window.of_buttons_visible( False,  True,   False, True,  True,  True, False,  False, False, False, False,  False)
	else
		//Modified by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)
		//iw_parent_window.of_buttons_visible( True,   True,  True, True, True ,  True, True,  True,  True,  True, True, True)
		if is_ext = 'PDF' then
			lb_TIF = false
		else
			lb_TIF = true
		end if
		iw_parent_window.of_buttons_visible( True,   True,  True, True, True ,  True, lb_TIF,  lb_TIF,  lb_TIF,  lb_TIF, lb_TIF, True)
	end if	
ELSE //scan tab
	iw_parent_window.of_buttons_visible( false, false, false, false,false,false, false, false, false,false, false, false)
END IF




return 1
end function

public function integer of_button_action (string as_button);
choose case as_button
	case "ADD"
		of_print_image( 1,  tab_view.tabpage_image.ole_scan_edit.object.pagecount )  //Start Code Change ----05.18.2012 #V12 maha
		
	case "DELETE"
		choose case tab_view.selectedtab
			case 1
				tab_view.tabpage_browse.dw_browse.triggerevent("pfc_deleterow")
			case 2
				of_add_annotation( "D" )  //Delete
		end choose
	case "SAVE"
		//both
		choose case tab_view.selectedtab
			case 1
				iw_parent_window.triggerevent("pfc_save")
			case 2
				event pfc_cst_save_image( )
		end choose
	case "NOTES"
		//both same
		tab_view.tabpage_browse.dw_browse.triggerevent("pfc_cst_prac_notes")
	case "PRINT"
		choose case tab_view.selectedtab
			case 1
				iw_parent_window.triggerevent("pfc_cst_print_report")
			case 2 //properties
				of_page_properties()
		end choose
	case "PRIOR"
		event pfc_cst_priorpage()			
	case "NEXT"
		event pfc_cst_nextpage()						
	case "B3"
		choose case tab_view.selectedtab
			case 1
				//of_print()        --delete by stephen 05.16.2012 -Bug 3089: Issue with Print Images button under documents tab 
				of_batch_print()   //add by stephen 05.16.2012 -Bug 3089: Issue with Print Images button under documents tab 
			case 2
				of_add_annotation( "S" )  //Select
		end choose						
	case "B4"
		choose case tab_view.selectedtab
			case 1
				event pfc_cst_email_documents( )
			case 2
				of_add_annotation( "H" ) //highlight
		end choose								
	case "B5"
		choose case tab_view.selectedtab
			case 1
				event pfc_cst_fax_image_documents( )
			case 2
				of_add_annotation( "N" ) //note
		end choose
	case "B6"
		 //Start Code Change ----05.03.2017 #V153 maha
		choose case tab_view.selectedtab
			case 1
				event ue_extract_documents( )
			case 2
				event pfc_cst_straighten_page( )
		end choose
		 //End Code Change ----05.03.2017 	
	case "B7"
		if tab_view.selectedtab = 2 then
			event pfc_cst_rotate( )
		elseif tab_view.selectedtab = 1 then
			of_correct_image_connection(tab_view.tabpage_browse.dw_browse.getrow())			
		end if
end choose

return 1

											
											
		
end function

public function integer of_check_add (string as_from);////Start Code Change ----04.02.2012 #V12 maha - added to check if the record exists in the selected screen
//return 0 = not found add ok; 1 = duplicate
Boolean lb_ver_doc = False
Integer li_screen_id
Integer li_ans
Integer li_rec_cnt  
Integer li_cr
integer li_image_type
Long ll_rec_id
String ls_doc_id
String ls_reference
string ref_type 
String ls_find 
Datawindow dw_data, dw_image_list, dw_image_data, dw_browse


dw_data = tab_view.tabpage_setup.dw_data
dw_image_list = tab_view.tabpage_setup.dw_image_list
dw_image_data = tab_view.tabpage_setup.dw_image_data
dw_browse = tab_view.tabpage_browse.dw_browse

li_cr = dw_data.GetRow()
IF li_cr = 0 then return -1

li_image_type = dw_image_list.GetItemNumber( dw_image_list.GetRow(), "image_type_id" ) 
li_screen_id = dw_image_list.GetItemNumber( dw_image_list.GetRow(), "link_to_screen" )
//ls_reference = dw_data.GetItemString( dw_data.GetRow(), "reference_value" )
//Verification image type?
IF dw_image_list.GetItemNumber( dw_image_list.GetRow(), "image_type_id" ) = 99 THEN
	lb_ver_doc = True
END IF
	
//Test to see if image exists
//Verification images
IF lb_ver_doc THEN	//verification
	ref_type = "V"
	ls_doc_id = dw_data.GetItemString( dw_data.GetRow(), "doc_id" )
	//check for image in browse list
	ls_find =  "doc_id = '" + ls_doc_id + "'"
	li_rec_cnt = dw_image_data.find( ls_find, 1, 10000) 
		
ELSEIF li_screen_id = 1 THEN   //Basic Info Connected images
	ls_reference = dw_image_list.GetItemString( dw_image_list.GetRow(), "image_type_description" ) 		
	ref_type = "I"
	
	ls_find =  "image_type_id = " + string(li_image_type) 
	li_rec_cnt = dw_image_data.find( ls_find, 1, 10000) 
		
ELSE  //Connected to data entry records  	
	ref_type = "R"
	ll_rec_id = dw_data.GetItemNumber( dw_data.GetRow(), "rec_id" ) 	
	//ls_find =  "rec_id_id = " + string(ll_rec_id)  + " and screen_id = " + string(li_screen_id)
	ls_find =  "rec_id = " + string(ll_rec_id)  + " and screen_id = " + string(li_screen_id) //long.zhang 04.12.2012
	li_rec_cnt = dw_image_data.find( ls_find, 1, 10000)
END IF

	
//If records found open options window and process as selected
IF li_rec_cnt > 0 THEN
	if as_from = "AUTO" then
		return 1
	else // of_select_image
	//	messagebox("Selected Duplicate","The item selected has already been selected.  Do you wish to add it again for another Group/Facility? ",question!,yesno!,2)
		li_ans = messagebox("Selected Duplicate","The item selected has already been selected.  Do you wish to add it again for another Group/Facility? ",question!,yesno!,2) //long.zhang 04.12.2012
		if li_ans = 1 then
			return 0
		else
			return 1
		end if
	end if
end if
		
return 0
end function

public function integer of_security_filter (datawindow adw_data);//Start Code Change ----12.04.2012 #V12 maha

if of_get_app_setting("set_69","I") = 1 then
	adw_data.setfilter("view_rights = 1")
	adw_data.filter()
end if

return 1
end function

public function integer of_user_date_stamp (string as_tempfile);//Start Code Change ----01.16.2014 #V14 maha - for scanning only.  For import see w_get_image
string ls_group
string ls_stamp
string ls_ext  //Added by (APPEON) Harry 11.14.2017
int FontID  //Added by (APPEON) Harry 11.14.2017

ls_group = string(time(now()))
ls_stamp = string(date(today())) + " " + string(time(now())) + " - " + gs_user_id 
ls_ext = Upper(Mid(as_tempfile,LastPos(as_tempfile, '.' ) + 1 )) //Added by (APPEON) Harry 11.14.2017 (V161 Storage of Documents as PDFs)

try
IF ls_ext = 'PDF' THEN
	tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.object.PDFOutputPDFA = true
	tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.object.PDFInitAnnotation()
	FontID =tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.object.PDFAddFont("Arial", False, False)
	tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.object.PDFEmbedFont(FontID)
	tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.object.PDFSetTextColor (0, 0, 0)
	tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.object.PDFDrawText (0, 1, 10, ls_stamp, FontID, 9, 0)
ELSE
	tab_view.tabpage_image.ole_scan_edit.Object.Image(  as_tempfile )
	tab_view.tabpage_image.ole_scan_edit.Object.SetCurrentAnnotationGroup( ls_group )
	tab_view.tabpage_image.ole_scan_edit.Object.Page( 1 )
	tab_view.tabpage_image.ole_scan_edit.Object.Display()
	
	tab_view.tabpage_image.ole_scan_edit.Object.AnnotationStampText( ls_stamp )		
	tab_view.tabpage_image.ole_scan_edit.Object.Annotationtype(8)	
	tab_view.tabpage_image.ole_scan_edit.object.Draw(1, 1, 10,10)
	tab_view.tabpage_image.ole_scan_edit.Object.BurnInAnnotations( 1, 2 )
	tab_view.tabpage_image.ole_scan_edit.Object.save()
END IF
catch (runtimeerror a)
	
end try


Return 1
end function

public function integer of_reset (); //Start Code Change ----07.10.2015 #V15 maha - added called from of_reset_prac in w_prac_data_1
 tab_view.tabpage_browse.dw_browse.reset()
 
 return 1
end function

public function integer of_post_resize ();//Start Code Change ----02.03.2016 #V15 maha - added
integer li_y
integer li_bit
integer li_by

tab_view.tabpage_browse.dw_browse.width =  tab_view.width - 25
tab_view.tabpage_browse.dw_browse.height = tab_view.height - tab_view.tabpage_browse.dw_browse.y - 125

tab_view.tabpage_image.ole_scan_edit.width =  tab_view.width - 25
tab_view.tabpage_image.ole_scan_edit.height = tab_view.height - tab_view.tabpage_image.ole_scan_edit.y - 125

//Added by (APPEON) Harry 11.10.2017 (V161 Storage of Documents as PDFs)
tab_view.tabpage_image.ole_scanpdf_edit.width =  tab_view.tabpage_image.ole_scan_edit.width
tab_view.tabpage_image.ole_scanpdf_edit.height = tab_view.tabpage_image.ole_scan_edit.height
tab_view.tabpage_image.ole_scanpdf_edit.of_resize() //Added by (APPEON) Harry 11.27.2017 (V161 Storage of Documents as PDFs)

li_y = tab_view.tabpage_setup.dw_image_list.x + tab_view.tabpage_setup.dw_image_list.width + 10
tab_view.tabpage_setup.dw_image_list.height  = tab_view.height - tab_view.tabpage_setup.dw_image_list.y - 125
tab_view.tabpage_setup.dw_data.width = tab_view.width - li_y - 35
tab_view.tabpage_setup.dw_image_data.width = tab_view.width - li_y - 35

li_bit = tab_view.tabpage_setup.dw_image_list.height / 18 
tab_view.tabpage_setup.dw_data.height = li_bit * 6
tab_view.tabpage_setup.dw_image_data.height = li_bit * 11
tab_view.tabpage_setup.dw_image_data.y =  tab_view.tabpage_setup.dw_image_list.height - tab_view.tabpage_setup.dw_image_data.height + 8

//li_by = tab_view.tabpage_setup.dw_data.y + tab_view.tabpage_setup.dw_data.height + 20
li_by = tab_view.tabpage_setup.dw_image_data.y - 16 - 84
tab_view.tabpage_setup.cb_select.y = li_by
tab_view.tabpage_setup.cb_scan.y = li_by
tab_view.tabpage_setup.cb_remove.y = li_by

tab_view.tabpage_setup.dw_data.height =  li_by - 20 - tab_view.tabpage_setup.dw_data.y




return 1
end function

public function integer of_correct_image_connection (integer ai_row);//Start Code Change ----06.21.2016 #V152 maha - added for image correction

long ll_id
long ll_type
 gs_pass_ids lst_ids

if ai_row < 1 then return 0

ll_type = tab_view.tabpage_browse.dw_browse.getitemnumber(ai_row, "image_type_id")
ll_id = tab_view.tabpage_browse.dw_browse.getitemnumber(ai_row, "image_pk")
lst_ids.prac_id =  il_prac_id
lst_ids.l_app_id = ll_id
lst_ids.committee_id = ll_type
lst_ids.facility_id = ii_verifiying_facility_id

openwithparm(w_image_correct, lst_ids)
tab_view.tabpage_browse.dw_browse.retrieve(il_prac_id, gs_user_id)

return 1

end function

public subroutine of_zoom ();//Start Code Change ----07.13.2017 #V154 maha
tab_view.tabpage_browse.dw_browse.Modify("DataWindow.Zoom=" + string(gi_zoom))  
tab_view.tabpage_setup.dw_data.Modify("DataWindow.Zoom=" + string(gi_zoom))
tab_view.tabpage_setup.dw_image_data.Modify("DataWindow.Zoom=" + string(gi_zoom))
tab_view.tabpage_setup.dw_image_list.Modify("DataWindow.Zoom=" + string(gi_zoom))
end subroutine

public subroutine of_set_visible_pdf (boolean ab_visible);//Added by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)

tab_view.tabpage_image.ole_scanpdf_edit.visible = ab_visible
tab_view.tabpage_image.ole_scan_edit.visible = not ab_visible
cbx_show.visible = not ab_visible

end subroutine

public subroutine of_deletepages_pdf (olecustomcontrol ole_pdf, long start_page, long num_pages);//Added by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)
//Long i
//For i =  start_page + num_pages - 1 TO start_page STEP -1
//	 ole_pdf.Object.PDFEditDeletePage (ole_pdf.object.filename(), i)
//Next
IF NOT IsValid(w_dm_image_cp) THEN Open(w_dm_image_cp) 
w_dm_image_cp.of_delete_page_pdf( ole_pdf.object.filename, start_page, num_pages)
Close(w_dm_image_cp)
end subroutine

on pfc_cst_u_imaging.create
this.st_alert=create st_alert
this.st_page=create st_page
this.tab_view=create tab_view
this.ddlb_zoom=create ddlb_zoom
this.st_zoom=create st_zoom
this.st_format=create st_format
this.cbx_show=create cbx_show
this.ddlb_format=create ddlb_format
this.st_recs=create st_recs
this.cb_expand=create cb_expand
this.Control[]={this.st_alert,&
this.st_page,&
this.tab_view,&
this.ddlb_zoom,&
this.st_zoom,&
this.st_format,&
this.cbx_show,&
this.ddlb_format,&
this.st_recs,&
this.cb_expand}
end on

on pfc_cst_u_imaging.destroy
destroy(this.st_alert)
destroy(this.st_page)
destroy(this.tab_view)
destroy(this.ddlb_zoom)
destroy(this.st_zoom)
destroy(this.st_format)
destroy(this.cbx_show)
destroy(this.ddlb_format)
destroy(this.st_recs)
destroy(this.cb_expand)
end on

event constructor;Integer li_image_storage_type

inv_dw = CREATE pfc_cst_nv_data_entry_functions
inv_dw.of_setup_cache()
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2006-10-09 By: Liu Hongxin
//$<reason> Modify according to new required and show huge.
/*
ddlb_zoom.Text = "Fit To Width"
*/
ddlb_zoom.Text = "Actual Size"
//---------------------------- APPEON END ----------------------------

//SELECT image_storage_type 
//INTO :li_image_storage_type
//FROM icred_settings;
li_image_storage_type = of_get_app_setting("image_storage_type","I")

IF li_image_storage_type = 1 THEN
	ii_image_storage_type = 1
	inv_image_functions = CREATE pfc_cst_nv_image_functions
ELSE
	ii_image_storage_type = 0	
END IF

ii_set_59 = of_get_app_setting("set_59","I")  //Michael 01.30.2011 V11.2 ImagingFacility

//Start Code Change ----10.03.2011 #V12 maha - modify to use print dialog setting
if gi_print_dialog = 1 then
	tab_view.tabpage_image.cbx_1.checked = false
	ib_no_dialog = false  //Start Code Change ----11.03.2011 #V12 maha 
end if
//End Code Change ----10.03.2011	

of_zoom()  //Start Code Change ----07.13.2017 #V154 maha
end event

event destructor;DESTROY inv_image_functions;


end event

type st_alert from statictext within pfc_cst_u_imaging
boolean visible = false
integer x = 928
integer y = 16
integer width = 951
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 16777215
string text = "Alert text"
boolean focusrectangle = false
end type

type st_page from statictext within pfc_cst_u_imaging
integer x = 3031
integer y = 16
integer width = 453
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
boolean enabled = false
string text = "Page 1 of 1"
boolean focusrectangle = false
end type

type tab_view from tab within pfc_cst_u_imaging
integer x = 32
integer y = 4
integer width = 3474
integer height = 1980
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
tabpage_image tabpage_image
tabpage_setup tabpage_setup
end type

on tab_view.create
this.tabpage_browse=create tabpage_browse
this.tabpage_image=create tabpage_image
this.tabpage_setup=create tabpage_setup
this.Control[]={this.tabpage_browse,&
this.tabpage_image,&
this.tabpage_setup}
end on

on tab_view.destroy
destroy(this.tabpage_browse)
destroy(this.tabpage_image)
destroy(this.tabpage_setup)
end on

event selectionchanged;if oldindex = -1 or newindex = -1 then return  

SetPointer(HourGlass!) // alfee 12.12.2008
SetRedraw(False) //alfee 12.12.2008

of_set_menu( newindex )
of_button_visible( newindex)
//--------Begin Commented by Alfee on 10.13.2008------
//<$Reason>Moved into of_set_menu(...)
//IF newindex = 1 THEN
//	of_enable_next_prev_buttons( "Browse" )
//ELSE
//	of_enable_next_prev_buttons( "Other" )
//END IF 
//--------End Commented -------------------------------

IF newindex = 2 THEN //Start Code Change ---- 10.03.2006 #625 maha
	of_doubleclicked(THIS.tabpage_browse.dw_browse)
end if
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.26.2006 By: Jack (Inova)
//$<reason> 5. Queue Images for Scanning from Data Entry.
if newindex = 3 then
	long ll_image_type_id,ll_find
	if iw_parent_window.tab_1.tabpage_detail.uo_data_entry.ids_image_data.rowcount() > 0 then
		ll_image_type_id = iw_parent_window.tab_1.tabpage_detail.uo_data_entry.ids_image_data.getitemnumber(1,'image_type_id')
	end if
	ll_find = tab_view.tabpage_setup.dw_image_list.find("image_type_id = " + string(ll_image_type_id),1,100)
	if ll_find > 0 then
		tab_view.tabpage_setup.dw_image_list.ScrollToRow( ll_find )
		tab_view.tabpage_setup.dw_image_list.SetRow( ll_find )
	end if
	tab_view.tabpage_setup.dw_image_data.setfocus()
	tab_view.tabpage_setup.dw_image_data.setcolumn('notes')
end if
//---------------------------- APPEON END ----------------------------

SetRedraw(TRUE) //alfee 12.12.2008

of_set_alert_text("F") //Start Code Change ----08.04.2010 #V10 maha

end event

type tabpage_browse from userobject within tab_view
integer x = 18
integer y = 100
integer width = 3438
integer height = 1864
long backcolor = 79741120
string text = "Browse"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 12632256
ole_admin_pdf ole_admin_pdf
ole_admin_count ole_admin_count
cb_ass_file cb_ass_file
ole_thumb ole_thumb
cb_find cb_find
sle_find_path sle_find_path
st_path st_path
ole_admin ole_admin
dw_browse dw_browse
lb_files lb_files
end type

on tabpage_browse.create
this.ole_admin_pdf=create ole_admin_pdf
this.ole_admin_count=create ole_admin_count
this.cb_ass_file=create cb_ass_file
this.ole_thumb=create ole_thumb
this.cb_find=create cb_find
this.sle_find_path=create sle_find_path
this.st_path=create st_path
this.ole_admin=create ole_admin
this.dw_browse=create dw_browse
this.lb_files=create lb_files
this.Control[]={this.ole_admin_pdf,&
this.ole_admin_count,&
this.cb_ass_file,&
this.ole_thumb,&
this.cb_find,&
this.sle_find_path,&
this.st_path,&
this.ole_admin,&
this.dw_browse,&
this.lb_files}
end on

on tabpage_browse.destroy
destroy(this.ole_admin_pdf)
destroy(this.ole_admin_count)
destroy(this.cb_ass_file)
destroy(this.ole_thumb)
destroy(this.cb_find)
destroy(this.sle_find_path)
destroy(this.st_path)
destroy(this.ole_admin)
destroy(this.dw_browse)
destroy(this.lb_files)
end on

type ole_admin_pdf from u_image_edit_cp1 within tabpage_browse
event destroy ( )
boolean visible = false
integer x = 1998
integer y = 944
integer width = 914
integer height = 800
integer taborder = 31
end type

on ole_admin_pdf.destroy
call u_image_edit_cp1::destroy
end on

type ole_admin_count from olecustomcontrol within tabpage_browse
event filepropertiesclose ( )
boolean visible = false
integer x = 37
integer y = 764
integer width = 613
integer height = 436
integer taborder = 70
borderstyle borderstyle = stylelowered!
string binarykey = "pfc_cst_u_imaging.udo"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

type cb_ass_file from commandbutton within tabpage_browse
boolean visible = false
integer x = 2514
integer y = 1776
integer width = 489
integer height = 84
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Associate Image File"
end type

event clicked;
Integer li_thumb_count
Integer i
Integer li_page_cnt
Integer li_page[]

li_thumb_count = ole_thumb.Object.ThumbCount()

FOR i = 1 TO li_thumb_count
	IF ole_thumb.Object.ThumbSelected( i ) = True THEN
		li_page_cnt++
		li_page[ li_page_cnt ] = i
	END IF
END FOR



dw_browse.SetItem( dw_browse.GetRow( ), "start_page", li_page[1] )
dw_browse.SetItem( dw_browse.GetRow( ), "num_pages", li_page_cnt )
dw_browse.SetItem( dw_browse.GetRow( ), "file_name", lb_files.SelectedItem()  )
end event

type ole_thumb from olecustomcontrol within tabpage_browse
event click ( long thumbnumber )
event dblclick ( long thumbnumber )
event mousedown ( integer button,  integer shift,  long ocx_x,  long ocx_y,  long thumbnumber )
event mouseup ( integer button,  integer shift,  long ocx_x,  long ocx_y,  long thumbnumber )
event mousemove ( integer button,  integer shift,  long ocx_x,  long ocx_y,  long thumbnumber )
event thumbdrop ( long insertbefore,  long dropcount,  integer shift )
event thumbdrag ( long dragcount,  integer shift )
event ocx_error ( integer number,  ref string description,  long scode,  string source,  string helpfile,  long helpcontext,  ref boolean canceldisplay )
event keydown ( ref integer keycode,  integer shift )
event keyup ( ref integer keycode,  integer shift )
event readystatechange ( long readystate )
boolean visible = false
integer x = 1184
integer y = 844
integer width = 1317
integer height = 768
integer taborder = 21
borderstyle borderstyle = stylelowered!
string binarykey = "pfc_cst_u_imaging.udo"
integer binaryindex = 1
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

type cb_find from commandbutton within tabpage_browse
boolean visible = false
integer x = 910
integer y = 28
integer width = 251
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Find File"
end type

event clicked;Long Index
Index = lb_files.FindItem( sle_find_path.Text, 1 )

IF Index > 0 THEN
	lb_files.SelectItem( Index )
ELSE
	MessageBox("Not Found", "File not found." )
END IF
end event

type sle_find_path from singlelineedit within tabpage_browse
boolean visible = false
integer x = 27
integer y = 28
integer width = 864
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_path from statictext within tabpage_browse
boolean visible = false
integer x = 32
integer y = 1340
integer width = 1134
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
boolean border = true
boolean focusrectangle = false
end type

type ole_admin from olecustomcontrol within tabpage_browse
event filepropertiesclose ( )
boolean visible = false
integer x = 50
integer y = 1324
integer width = 1317
integer height = 768
integer taborder = 60
borderstyle borderstyle = stylelowered!
string binarykey = "pfc_cst_u_imaging.udo"
integer binaryindex = 2
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

type dw_browse from u_dw within tabpage_browse
integer y = 4
integer width = 3438
integer height = 1832
integer taborder = 20
string dataobject = "d_pd_image_list"
boolean hscrollbar = true
end type

event clicked;call super::clicked;integer r
//Start Code Change ---- 04.24.2006 #408 maha
IF This.GetClickedRow() > 0 AND row > 0 THEN
	r = This.GetClickedRow()
	of_browse_select_row( r, -1)
END IF
//End Code Change---04.24.2006

//Start Code Change ----02.03.2016 #V15 maha - moved from clicked event
if dwo.name = "b_notes" then

	//---------Begin Modified by (Appeon)Harry 07.17.2014  for the Bug 4115
	//OpenWithParm( w_ai_notes_new, This.GetItemString( row, "notes" ))
	string ls_notes
	ls_notes = This.GetItemString( row, "notes" )
	if isnull(ls_notes) then ls_notes = ""
	OpenWithParm( w_ai_notes_new, ls_notes)
	//---------End Modfiied ------------------------------------------------------
	
	IF Message.StringParm = "Cancel" THEN
		Return -1
	ELSE
		This.SetItem( row, "notes", Message.StringParm )
	END IF
	this.update() 
end if
//End Code Change ----02.03.2016

end event

event doubleclicked;//of_doubleclicked(THIS) //Start Code Change ---- 04.24.2006 #409 maha removed because redundant
tab_view.SelectTab( 2 )

end event

event retrieveend;call super::retrieveend;integer cnt //maha 12.17.08
//Start Code Change ---- 04.24.2006 #410 maha
IF rowcount > 0 THEN
	of_browse_select_row( 1, -5)
	This.SetFocus()
END IF
//End Code Change---04.24.2006

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08.12.2006 By: LeiWei
//$<reason> Fix a defect.
il_dispaly_row = 0
//---------------------------- APPEON END ----------------------------

//Start Code Change ---- 04.04.2007 #V7 maha  moved from rfc code of dw image list
	//Start Code Change ----12.17.2008 #V85 maha - enable action buttons if queued records exist


cnt = tab_view.tabpage_setup.dw_image_data.retrieve(il_prac_id)

if cnt > 0 then
	tab_view.tabpage_setup.cb_from_file.enabled = true
	tab_view.tabpage_setup.cb_scan.enabled = true
end if
	//End Code Change---12.17.2008
//End Code Change---04.04.2007

of_enable_next_prev_buttons( "Browse" )

//Start Code Change ----09.12.2012 #V12 maha - no edit functionality
if  w_mdi.of_security_access( 7360 ) = 0 then //add but no edit
	tab_view.tabpage_browse.dw_browse.Modify( "notes.protect = '1'" )
end if
//End Code Change ----09.12.2012


end event

event pfc_nextpage;Integer li_row

li_row = This.GetRow()
IF li_row < This.RowCount() THEN
	This.SetRow( li_row + 1) 
	This.ScrollToRow( li_row + 1 )
//	This.SelectRow( 0, False )   //Start Code Change ----01.20.2016 #V15 maha - removed
//	This.SelectRow( li_row + 1, True )
END IF

Return 1
end event

event pfc_previouspage;Integer li_row

li_row = This.GetRow()
IF li_row > 1 THEN
	li_row --
//	This.SelectRow( 0, False )   //Start Code Change ----01.20.2016 #V15 maha - removed
//	This.SelectRow( li_row, True )	
	This.SetRow( li_row ) 
	This.ScrollToRow( li_row )
END IF

Return li_row
end event

event rowfocuschanged;call super::rowfocuschanged;IF currentrow<= 0 THEN Return
st_recs.Text = "Record " + String(currentrow) + " of " + String( This.RowCount()) //maha removed

is_ext = Upper( This.GetItemString(currentrow,'image_ext') ) //Added by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)
IF IsNull(is_ext) THEN is_ext = 'TIF'  //Added by (APPEON) Harry 12.08.2017 

IF is_ext = 'PDF' THEN
	of_set_visible_pdf(TRUE)
ELSE
	of_set_visible_pdf(FALSE)
END IF
of_enable_next_prev_buttons( "Browse" )

// mskinner 06 feb 2006 -- begin
il_current_row = currentrow
// mskinner 06 feb 2006 -- end 


end event

event pfc_deleterow;of_delete_image()

Return 1
end event

event buttonclicked;call super::buttonclicked;integer res
string ls_path

//Start Code Change ----06.13.2014 #V14.2 maha - adjusted code and added Select button

////Start Code Change ----02.03.2016 #V15 maha - moved to clicked event
//if dwo.name = "b_notes" then
//
//	//---------Begin Modified by (Appeon)Harry 07.17.2014  for the Bug 4115
//	//OpenWithParm( w_ai_notes_new, This.GetItemString( row, "notes" ))
//	string ls_notes
//	ls_notes = This.GetItemString( row, "notes" )
//	if isnull(ls_notes) then ls_notes = ""
//	OpenWithParm( w_ai_notes_new, ls_notes)
//	//---------End Modfiied ------------------------------------------------------
//	
//	IF Message.StringParm = "Cancel" THEN
//		Return -1
//	ELSE
//		This.SetItem( row, "notes", Message.StringParm )
//	END IF
//	this.update() 
//end if
////End Code Change ----02.03.2016

if dwo.name = "b_select" then
	integer li_rc
	integer v
	integer i
	li_rc = this.RowCount()

	IF dwo.Text = "Select All" THEN
		dwo.Text = "Deselect All"
		v = 1
	ELSE
		dwo.Text = "Select All"
		v = 0
	END IF
	
	FOR i = 1 TO li_rc
			this.SetItem( i, "selected", v )
	END FOR
end if

//End Code Change --- 06.13.2014

//res = messagebox("Delete All Images?","This function will permanently delete all of the images for this practitioner.  Do you wish to continue?",question!,yesno!,2)
//if res = 2 then return 0
//res = messagebox("Delete All Images?","Are you sure?",question!,yesno!,2)
//if res = 2 then return 0
//
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-08
////$<modify> 02.20.2006 By: Cao YongWang
////$<reason> Performance tuning.
////$<modification> Write script to retrieve data from a cache instead of from the database.
///*
//select imaging_path
//into :ls_path
//from ids;
//*/
//ls_path = gnv_data.of_getitem("ids","imaging_path",false)
////---------------------------- APPEON END ----------------------------
//
//IF IsNull( gl_prac_id ) OR gl_prac_id = 0 THEN
//	MessageBox("prac_id", "The gl_prac_id variable is null or 0" )
//	Return
//END IF
//
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-09
////$<add> 01.24.2006 By: Cao YongWang
////$<reason> Performance tuning
////$<modification> Add Appeon Commit label to reduce client-server interactions to improve runtime performance.
//
//gnv_appeondb.of_autocommit()
////---------------------------- APPEON END ----------------------------
//delete from pd_images
//where prac_id = :gl_prac_id;
//commit using sqlca;
//
//FileDelete ( ls_path + string(gl_prac_id) + ".tif" )
//
//this.reset()
//tab_view.tabpage_image.ole_scan_edit.Object.ClearDisplay(  ) //maha 082801
end event

event constructor;call super::constructor;//Start Code Change ---- 12.05.2006 #V7 maha
//if using stroe in database change the column header; there is also a bitmap of the image exists in the database.
if of_get_app_setting("image_storage_type","I") = 1 then
	this.object.start_page_t.text = "In~rDB"
	this.object.start_page.color = rgb(255,255,255)
	this.Modify("start_page.y = 100") //evan 09.01.2011 - BugE082105
else
	this.Modify("p_1.y = 100 p_2.y = 100") //evan 09.02.2011 - BugE082105
end if
//End Code Change---12.05.2006



//------------------- APPEON BEGIN -------------------
//$<Add> Michael 01.30.2011
//$<reason> V11.2 ImagingFacility
// //Start Code Change ----03.23.2011 #V11 maha -  removed because want to always display facility
//IF ii_set_59 = 0 THEN
//    this.object.pd_images_facility_id.visible = false
//ELSE
//    this.object.pd_images_facility_id.visible = true
//ENd IF
// //End Code Change ----03.23.2011 
//------------------- APPEON END ---------------------
end event

event itemchanged;call super::itemchanged;//alfee 12.26.2008
long ll_facid

//------------------- APPEON BEGIN -------------------
//$<add> Stephen 05.04.2011
//$<reason>Check Duplicate Record
if row < 1 then return
if dwo.name = 'pd_images_facility_id' then
	ll_facid = this.getitemnumber(row, 'pd_images_facility_id')
	if of_check_fac('B') = -1 then
		messagebox("Duplicate Record","A current image connected to this record already exists for this Group/Facility.")
		this.setitem(row, 'pd_images_facility_id', ll_facid)
		return 2
	end if
end if
//------------------- APPEON END -------------------

IF Lower(dwo.name) = "num_pages" OR Lower(dwo.name) = "start_page" THEN 
	IF IsNull(Data) OR Long(data) < 1 THEN
		MessageBox("Verification", "The " + Lower(dwo.name) + " should be larger than 0.")
		RETURN 2
	END IF	
END IF


end event

event pfc_preupdate;//---------Begin Added by (Appeon)Stephen 11.02.2016 for V15.3-Image Auditing in IntelliCred--------
this.accepttext()
inv_dw.of_field_audit(this) 
call super::pfc_preupdate
return 1
//---------End Added ------------------------------------------------------

end event

type lb_files from listbox within tabpage_browse
boolean visible = false
integer x = 27
integer y = 132
integer width = 1134
integer height = 1196
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;String ls_file_name

ls_file_name = is_image_path + lb_files.SelectedItem( )

ole_thumb.object.Image( ls_file_name )
end event

type tabpage_image from userobject within tab_view
integer x = 18
integer y = 100
integer width = 3438
integer height = 1864
long backcolor = 16777215
string text = "Preview"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 12632256
ole_scanpdf_edit ole_scanpdf_edit
ole_scan_edit ole_scan_edit
cbx_1 cbx_1
end type

on tabpage_image.create
this.ole_scanpdf_edit=create ole_scanpdf_edit
this.ole_scan_edit=create ole_scan_edit
this.cbx_1=create cbx_1
this.Control[]={this.ole_scanpdf_edit,&
this.ole_scan_edit,&
this.cbx_1}
end on

on tabpage_image.destroy
destroy(this.ole_scanpdf_edit)
destroy(this.ole_scan_edit)
destroy(this.cbx_1)
end on

type ole_scanpdf_edit from u_image_edit_cp1 within tabpage_image
event destroy ( )
boolean visible = false
integer y = 84
integer width = 3438
integer height = 1776
integer taborder = 31
end type

on ole_scanpdf_edit.destroy
call u_image_edit_cp1::destroy
end on

type ole_scan_edit from olecustomcontrol within tabpage_image
event keydown ( integer keycode,  integer shift )
event keyup ( integer keycode,  integer shift )
event keypress ( integer keyascii )
event mousedown ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mousemove ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mouseup ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event click ( )
event dblclick ( )
event ocx_error ( integer number,  string description,  long scode,  string source,  string helpfile,  long helpcontext,  boolean canceldisplay )
event ocx_close ( )
event markend ( long left,  long top,  long ocx_width,  long ocx_height,  integer marktype,  string groupname )
event toolselected ( integer toolid )
event selectionrectdrawn ( long left,  long top,  long ocx_width,  long ocx_height )
event tooltip ( integer index )
event toolpalettehidden ( long left,  long top )
event scroll ( )
event markselect ( integer button,  integer shift,  long left,  long top,  long ocx_width,  long ocx_height,  integer marktype,  string groupname )
event pastecompleted ( )
event load ( double zoom )
event markmove ( integer marktype,  string groupname )
event pagepropertiesclose ( )
event checkcontinueprinting ( long pagesprinted,  long currentpage,  integer status )
event hyperlinkgotopage ( long page )
event errorsavingundoinformation ( long ocx_error )
event straightenpage ( )
event hyperlinkgotodoc ( string link,  long page,  boolean handled )
event editingtextannotation ( boolean editing )
event magnifierstatus ( integer hwnd,  long status,  long magnifierzoom,  long left,  long top,  long ocx_width,  long ocx_height )
event pasteclip ( long mode )
event baddocumentfiletype ( long page,  boolean errorout,  boolean skippage,  boolean overwritepage )
event nextpage ( )
event prevpage ( )
event overlayfilenotfound ( string overlayfilename,  boolean btryagain )
event imagedraganddrop ( )
event zoomchanged ( real zoom )
event beforemarkmove ( boolean bcancelmove )
event readystatechange ( long readystate )
integer y = 84
integer width = 3438
integer height = 1776
integer taborder = 40
boolean border = false
long backcolor = 67108864
boolean focusrectangle = false
string binarykey = "pfc_cst_u_imaging.udo"
integer binaryindex = 3
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

event markselect(integer button, integer shift, long left, long top, long ocx_width, long ocx_height, integer marktype, string groupname);//Start Code Change ---- 05.17.2006 #457 maha was not carried over from v4.5
is_annotation_name = groupname
//End Code Change---05.17.2006
end event

type cbx_1 from u_cbx within tabpage_image
integer x = 5
integer y = 8
integer width = 882
integer height = 76
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
long backcolor = 16777215
string text = "Use Default/Previous Printer"
boolean checked = true
end type

event clicked;call super::clicked;


if this.checked then 
	ib_no_dialog = true
else 
	
	ib_no_dialog = false
	
end if 
end event

type tabpage_setup from userobject within tab_view
integer x = 18
integer y = 100
integer width = 3438
integer height = 1864
long backcolor = 16777215
string text = "Scan/Import"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 12632256
ole_admin1 ole_admin1
cb_from_file cb_from_file
cb_remove cb_remove
dw_image_list dw_image_list
dw_image_data dw_image_data
ole_scan ole_scan
cb_scan cb_scan
cb_select cb_select
dw_data dw_data
end type

on tabpage_setup.create
this.ole_admin1=create ole_admin1
this.cb_from_file=create cb_from_file
this.cb_remove=create cb_remove
this.dw_image_list=create dw_image_list
this.dw_image_data=create dw_image_data
this.ole_scan=create ole_scan
this.cb_scan=create cb_scan
this.cb_select=create cb_select
this.dw_data=create dw_data
this.Control[]={this.ole_admin1,&
this.cb_from_file,&
this.cb_remove,&
this.dw_image_list,&
this.dw_image_data,&
this.ole_scan,&
this.cb_scan,&
this.cb_select,&
this.dw_data}
end on

on tabpage_setup.destroy
destroy(this.ole_admin1)
destroy(this.cb_from_file)
destroy(this.cb_remove)
destroy(this.dw_image_list)
destroy(this.dw_image_data)
destroy(this.ole_scan)
destroy(this.cb_scan)
destroy(this.cb_select)
destroy(this.dw_data)
end on

type ole_admin1 from olecustomcontrol within tabpage_setup
event filepropertiesclose ( )
boolean visible = false
integer x = 2139
integer y = 636
integer width = 151
integer height = 96
integer taborder = 70
borderstyle borderstyle = stylelowered!
string binarykey = "pfc_cst_u_imaging.udo"
integer binaryindex = 4
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

type cb_from_file from commandbutton within tabpage_setup
boolean visible = false
integer x = 2350
integer y = 640
integer width = 82
integer height = 84
integer taborder = 21
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "&Get From File"
end type

event clicked;//Start Code Change ---- 04.24.2006 #411 maha
if dw_image_data.rowcount() < 1 then return //maha 042406
tab_view.tabpage_image.ole_scan_edit.Object.ClearDisplay(  ) //maha 061201

if tab_view.tabpage_setup.dw_image_data.rowcount() > 1 then
	messagebox("Get from file","When using the Get from File function, you can only have one data item selected at a time.")
	return
end if

//------------------- APPEON BEGIN -------------------
//$<add> Stephen 05.03.2011
//$<reason>Check Duplicate Record
if of_check_fac("A") = -1 then
	messagebox("Duplicate Record","A current image connected to this record already exists for this Group/Facility.")
	return
end if
//------------------- APPEON END ---------------------

Open( w_get_image )
//w_get_image.uo_image_object = pfc_cst_u_imaging //maha removed 042406

//tab_view.tabpage_browse.dw_browse.Retrieve( il_prac_id )//called from dw_image_data post update
of_browse_select_row(0,3) //last row  //maha 042406
//End Code Change---04.24.2006

of_set_alert_text("Get Image function completed.") //Start Code Change ----08.04.2010 #V10 maha
end event

type cb_remove from commandbutton within tabpage_setup
integer x = 1445
integer y = 644
integer width = 635
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "&Remove from Process List"
end type

event clicked;Integer li_ans

if dw_image_data.getrow() < 1 then return //Add by Stephen 04.14.2011 --- N/A

li_ans = MessageBox("Delete", "Are you sure you want to delete item from being processed.", Question!, YesNo!, 1 )

IF li_ans = 2 THEN
	Return 0
END IF

inv_dw.of_field_audit_delete_last(dw_image_data, dw_image_data.getrow()) //(Appeon)Stephen 11.01.2016 - V15.3-Image Auditing in IntelliCred
dw_image_data.DeleteRow( 0 )
dw_image_data.SetRow( 1 )
dw_image_data.ScrollToRow( 1 )

st_recs.Text = "Record " + String( dw_image_data.GetRow() ) + " of " + String( dw_image_data.RowCount() )
end event

type dw_image_list from u_dw within tabpage_setup
integer y = 12
integer width = 873
integer height = 1808
integer taborder = 60
boolean titlebar = true
string title = "Select Image Type"
string dataobject = "d_image_image_type_list"
boolean hscrollbar = true
end type

event clicked;call super::clicked;IF row > 0 THEN
	This.SetRow( row )
END IF
end event

event retrieveend;call super::retrieveend;IF rowcount > 0 THEN
//	This.SelectRow( 1, True )  //Start Code Change ----01.20.2016 #V15 maha - removed
	This.SetFocus()
END IF
end event

event rowfocuschanged;call super::rowfocuschanged;IF currentrow > 0 THEN
//	This.SelectRow( 0, False )  //Start Code Change ----01.20.2016 #V15 maha - removed
//	This.SelectRow( currentrow, True )
	//---------Begin Added by (Appeon)Stephen 08.11.2016 for Error when uploading documents--------
	This.SelectRow( 0, False )  
	This.SelectRow( currentrow, True )
	this.setrow(currentrow)
	//---------End Added ------------------------------------------------------
	//verification image processing
	tab_view.tabpage_setup.dw_data.of_SetUpdateAble( False )
	IF This.GetItemNumber( currentrow, "image_type_id" ) = 99 THEN		
		tab_view.tabpage_setup.dw_data.DataObject = "d_image_ver_summary_record_view"
		//tab_view.tabpage_setup.dw_data.of_SetDropDownCalendar( True )
		//tab_view.tabpage_setup.dw_data.iuo_calendar.of_Register( tab_view.tabpage_setup.dw_data.iuo_calendar.DDLB)
		tab_view.tabpage_setup.dw_data.of_SetUpdateAble( True )
		tab_view.tabpage_setup.dw_data.of_SetTransObject( SQLCA )		

		Integer li_facility_id[1]
		li_facility_id[1] = ii_verifiying_facility_id
		DataWindowChild dwchild
		tab_view.tabpage_setup.dw_data.Retrieve( 1, il_prac_id, li_facility_id )
		tab_view.tabpage_setup.dw_data.GetChild( "response_code", dwchild )
		dwchild.SetTransObject( SQLCA )
		dwchild.Retrieve("credentials verification response")
		dwchild.InsertRow( 1 )
	ELSEIF This.GetItemNumber( currentrow, "link_to_screen" ) = 0 THEN
		dw_data.Visible = False
		dw_data.Reset()
	ELSE
		dw_data.Visible = True
		dw_data.reset() //(Appeon)Stephen 08.11.2016 - Error when uploading documents
		inv_dw.of_create_dynamic_dw_browse( il_prac_id , 1, This.GetItemNumber( currentrow, "link_to_screen" ), tab_view.tabpage_setup.dw_data )
		if dw_data.rowcount() = 1 then 
			if of_check_add( 'AUTO') = 0 then  //Start Code Change ----04.02.2012 #V12 maha - only if an image doesn't exist
				if ib_list_retrieved = false then  //Start Code Change ----07.06.2011 #V11 maha - to block auto add on just selected practitioner
					cb_select.triggerevent(clicked!)  //Start Code Change ----06.23.2011 #V11 maha - auto select if a single record
				end if
			end if
		end if
		ib_list_retrieved = false
	END IF
//	//Start Code Change ---- .2007 #V7 maha  removed; does not work right  moved to retrieve end event
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<add> 10.12.2006 By: Jack (Inova)
//	//$<reason> Queue Images for Scanning from Data Entry.
//	tab_view.tabpage_setup.dw_image_data.reset()
//	long ll_image_type_id,ll_rowcount
//	ll_image_type_id = This.GetItemNumber( currentrow, "image_type_id" )
//	tab_view.tabpage_setup.cb_remove.enabled = false
//	tab_view.tabpage_setup.cb_from_file.enabled = false
//	tab_view.tabpage_setup.cb_scan.enabled = false			
//	if tab_view.tabpage_setup.dw_data.rowcount() > 0 then
//		//Start Code Change ---- 02.15.2007 #V7 maha retrieval should not be image type or facility  based
//		//ll_rowcount = tab_view.tabpage_setup.dw_image_data.retrieve(il_prac_id, ii_verifiying_facility_id,1,ll_image_type_id)
//		ll_rowcount = tab_view.tabpage_setup.dw_image_data.retrieve(il_prac_id)
//		//End Code Change---02.15.2007
//		if ll_rowcount > 0 then
//			tab_view.tabpage_setup.cb_remove.enabled = true
//			tab_view.tabpage_setup.cb_from_file.enabled = true
//			tab_view.tabpage_setup.cb_scan.enabled = true
//			tab_view.tabpage_setup.dw_image_data.setfocus()
//			tab_view.tabpage_setup.dw_image_data.setcolumn('notes')
//		end if
//	end if
//	//---------------------------- APPEON END ----------------------------
	//End Code Change---04.04.2007
END IF

of_set_alert_text("F") //Start Code Change ----08.04.2010 #V10 maha
end event

event pfc_deleterow;//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 2006-08-29 By: Liu HongXin
//$<reason> It hasn't save, so not to delete.
return 1
//---------------------------- APPEON END ----------------------------
end event

type dw_image_data from u_dw within tabpage_setup
event ue_after_rfc ( )
integer x = 878
integer y = 744
integer width = 2542
integer height = 1076
integer taborder = 11
boolean titlebar = true
string title = "Image Detail"
string dataobject = "d_image_scan_detail"
end type

event ue_after_rfc();//Start Code Change ----03.28.2012 #V12 maha - added
of_disable_buttons()
end event

event rowfocuschanged;call super::rowfocuschanged;st_recs.Text = "Record " + String( This.GetRow() ) + " of " + String( This.RowCount() )

postevent("ue_after_rfc")//Start Code Change ----03.28.2012 #V12 maha
 
end event

event pfc_postupdate;call super::pfc_postupdate;
//---------Begin Added by (Appeon)Stephen 11.04.2016 for V15.3-Image Auditing in IntelliCred--------
if ib_new = true then
	long     ll_image_id
	integer li_facility_id
	ll_image_id = this.GetItemNumber( this.getrow(), "image_pk" ) 
	li_facility_id = this.GetItemNumber( this.getrow(), "facility_id" )	
		
	inv_dw.of_sqlfield_audit(il_prac_id, ll_image_id, li_facility_id, 95, '1000', string(ll_image_id) +"-"+string(il_prac_id), '', 'I')
end if
//---------End Added ------------------------------------------------------

//Start Code Change ----12.04.2012 #V12 maha
//tab_view.tabpage_browse.dw_browse.Retrieve( il_prac_id )
tab_view.tabpage_browse.dw_browse.Retrieve( il_prac_id ,gs_user_id)
//of_security_filter(tab_view.tabpage_browse.dw_browse )//comment by Appeon long.zhang 03.30.2015 (V14.1 Bug # 4465  created for Case# 00052938: Setting up image security )
//End Code Change ----12.04.2012

Return 1
end event

event pfc_validation;call super::pfc_validation;/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 19 December 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/



long ll_i
string ls_message
string NEW_LINE
integer r

//Start Code Change ---- 06.13.2007 #V7 maha  modified message allowed user to continue
for ll_i = 1 to this.rowcount()
	if isnull(this.getitemnumber(ll_i,"tif_start_page")) then
		ls_message =  'The "Scan/Get from File" has not been completed.  Do you wish to continue without getting images?'
	end if
next


if LenA(ls_message) > 0 then
   r = messagebox("Image Detail Validation", ls_message,question!,yesno!,1)
	if r = 2 then
		return failure
	else
		return success
	end if
end if 
//End Code Change---06.13.2007

return success
end event

event pfc_deleterow;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2006-08-29 By: Liu HongXin
//$<reason> Trigger User Event.
cb_remove.TriggerEvent(Clicked!)
return 1
//---------------------------- APPEON END ----------------------------
end event

event itemchanged;call super::itemchanged;//alfee 12.26.2008

IF Lower(dwo.name) = "num_pages" THEN 
	IF IsNull(Data) OR Long(data) < 1 THEN
		MessageBox("Verification", "The " + Lower(dwo.name) + " should be larger than 0.")
		RETURN 2
	END IF	
END IF
end event

event pfc_preupdate;//////////////////////////////////////////////////////////////////////
// $<event> pfc_updateprep
// $<arguments>
//            
// $<returns> (None)
// $<description> Check Duplicate Record
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Stephen 05.03.2011
//////////////////////////////////////////////////////////////////////
dwitemstatus ldws_1

if of_check_fac('A') = -1 then
	messagebox("Duplicate Record","A current image connected to this record already exists for this Group/Facility.")
	return -1
else
	//---------Begin Added by (Appeon)Stephen 11.04.2016 for V15.3-Image Auditing in IntelliCred--------
	ib_new = false
	ldws_1 = this.getitemstatus(this.getrow(),0, primary!)
	if ldws_1 = newmodified! then
		ib_new = true
	else
		inv_dw.of_field_audit(this)  
	end if
	//---------End Added ------------------------------------------------------

	return SUCCESS
end if
end event

event buttonclicked;call super::buttonclicked;//------------------- APPEON BEGIN -------------------
//$<add> Stephen 05.03.2011
//$<reason>Check Duplicate Record
if of_check_fac("A") = -1 then
	messagebox("Duplicate Record","A current image connected to this record already exists for this Group/Facility.")
	return
end if
//------------------- APPEON END ---------------------

Open( w_get_image )
//w_get_image.uo_image_object = pfc_cst_u_imaging //maha removed 042406

//Added by (APPEON) Harry 12.15.2017 (V161 Storage of Documents as PDFs)
int li_cnt
if left(message.StringParm,7) = '*retry*' and li_cnt < 5 then
	li_cnt ++
	Openwithparm( w_get_image, mid(message.StringParm, 8) )
end if

//tab_view.tabpage_browse.dw_browse.Retrieve( il_prac_id )//called from dw_image_data post update
of_browse_select_row(0,3) //last row  //maha 042406
//End Code Change---04.24.2006

of_set_alert_text("Get Image function completed.") //Start Code Change ----08.04.2010 #V10 maha
end event

type ole_scan from olecustomcontrol within tabpage_setup
event scanstarted ( )
event scandone ( )
event pagedone ( long pagenumber )
event scanuidone ( )
boolean visible = false
integer x = 2066
integer y = 636
integer width = 137
integer height = 100
integer taborder = 80
borderstyle borderstyle = stylelowered!
string binarykey = "pfc_cst_u_imaging.udo"
integer binaryindex = 5
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

type cb_scan from commandbutton within tabpage_setup
integer x = 2917
integer y = 640
integer width = 498
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "&Begin Scanning"
boolean default = true
end type

event clicked;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : EVENT CB_SCAN::CLICKED
//==================================================================================================================
//  Purpose   	:
//==================================================================================================================
//  Arguments 	: [NONE] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: ???
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
// MSKINNER 						09 March 2005
//	maha								01-27-06																scan to temp file before adding to image to allow for 'rollback'
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//notes on file names:
//for image file:
//	if file does not exist then ls_tempfile is set to is_image_file_name which is the location of the stored file
//	if the file does exist then ls_tempfile is set to a temp file in the Intellicred folder and appended to the the existing file
//for database storage, the file is created in a temp file then scanned through and split and added to the database

IF is_scan_ext = 'PDF' THEN //Added by (APPEON) Harry 11.13.2017 (V161 Storage of Documents as PDFs)
	of_set_visible_pdf(TRUE)
	tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.Object.FileName = '' 
ELSE
	tab_view.tabpage_image.ole_scan_edit.Object.ClearDisplay(  ) //maha 061201
END IF

Integer i
Integer d
Integer li_last_page
Integer li_ans
Integer li_total_pages
Integer li_num_pages
Integer li_rc
Integer li_orig_last_page
integer res
integer li_data_count
integer s20
integer li_newcount
string ls_tempfile  
string ls_time,ls_Rtn
string   ls_ext  //Added by (APPEON) Harry 11.13.2017


//Start Code Change ---- 04.14.2006 #387 maha  //changed filename to be unique
if dw_image_data.rowcount() < 1 then return
ls_time = string(minute(now())) + string(second(now()))
IF is_scan_ext = 'PDF' THEN //Added by (APPEON) Harry 11.13.2017 (V161 Storage of Documents as PDFs)
	ls_tempfile = gs_temp_path + "temp" + ls_time + ".pdf" 
ELSE
	ls_tempfile = gs_temp_path + "temp" + ls_time + ".tif"//maha 012706
END IF
//End Code Change---04.14.2006

pfc_cst_nv_image_functions image_functions
image_functions = CREATE pfc_cst_nv_image_functions


//delete any temp.tif files so there no pages added to existing temp.tif files and ole clear display

FileDelete( ls_tempfile )
IF ii_image_storage_type = 1 THEN //store in db
	IF is_scan_ext = 'PDF' THEN //Added by (APPEON) Harry 11.13.2017 (V161 Storage of Documents as PDFs)
		tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.Object.FileName = ''
	ELSE
		tab_view.tabpage_image.ole_scan_edit.Object.ClearDisplay(  ) 
	END IF
	//set the image file name to temp.tif
	is_image_file_name = ls_tempfile
END IF

dw_image_data.AcceptText()

//------------------- APPEON BEGIN -------------------
//$<add> Stephen 05.04.2011
//$<reason>Check Duplicate Record
if of_check_fac("A") = -1 then
	messagebox("Duplicate Record"," There is already an image existed for the record for this group/facility.")
	return -1
end if
//------------------- APPEON END ---------------------

if fileexists(is_image_file_name) AND ii_image_storage_type <> 1 then
	IF is_scan_ext = 'PDF' THEN //Added by (APPEON) Harry 11.13.2017 (V161 Storage of Documents as PDFs)
		li_last_page = tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.Object.GetTotalPage() 
	ELSE
		li_last_page = tab_view.tabpage_image.ole_scan_edit.Object.PageCount()
	END IF	
	li_orig_last_page = li_last_page
else //file does not exist
	li_last_page = 0
	IF ii_image_storage_type = 1 THEN
		li_orig_last_page = 1
	ELSE
		li_orig_last_page = 0
	END IF
	ls_tempfile = is_image_file_name
end if


li_last_page ++
li_rc = dw_image_data.RowCount()

FOR i = 1 TO li_rc
	li_num_pages = dw_image_data.GetItemNumber( i, "num_pages" )
	//Start Code Change ---- 04.20.2006 #412 maha
	if isnull(li_num_pages) or li_num_pages = 0 then
		MessageBox("Scan", "Item # " + string(i) + " in the scan list does not have a number of pages.  Please correct and Click scan again.")
		return -1
	end if
	//End Code Change---04.20.2006
	li_total_pages = li_total_pages + li_num_pages
END FOR

IF li_total_pages = 0 THEN
	MessageBox("Scan", "There is nothing selected to scan." )
	Return -1
END IF

//ONLY Check this when using mapped drive
IF ii_image_storage_type <> 1 THEN
	//count the number of pages the data says there should be and compare to the image page count(for existing records).
	li_data_count = 0
	for d = 1 to tab_view.tabpage_browse.dw_browse.rowcount()  
		if tab_view.tabpage_browse.dw_browse.GetItemNumber( d ,"start_page") > 0 and  not isnull(tab_view.tabpage_browse.dw_browse.GetItemNumber( d ,"num_pages")) then
			//Start Code Change ---- 05.17.2007 #V7 maha added trap for missing start page. Count only if start page is valid
			li_data_count = li_data_count + tab_view.tabpage_browse.dw_browse.GetItemNumber( d ,"num_pages")	
		end if
	next

	if li_data_count <> li_orig_last_page then
		res = MessageBox( "Page count warning", "The number of pages in the image (" + string(li_orig_last_page) + ") does not match the start page/number of pages count(" + string(li_data_count) + "). You should be sure your images match your data before adding additional image records.~rIf you continue your new images will not match you data records.~r Continue anyway? ", StopSign!, Yesno!, 2 )		
		if res = 2 then
			//Start Code Change ----08.11.2010 #V10 maha - reset to current row so the current image can be viewed
			il_current_row = il_dispaly_row
			il_dispaly_row = 0 
			//End Code Change ----08.11.2010 #V10 maha
			return -1
		end if
	end if
END IF

//li_ans = MessageBox( "Scan", "Please DOUBLE CHECK to be sure a total of " + String( li_total_pages ) + " pages is placed in the document feeder. If the number or order is not correct, the scan will be affected and you will have to delete and rescan everything.~n~r~n~rClick Ok when ready to scan.", Question!, OkCancel!, 1 )
li_ans = MessageBox( "Scan", "Please DOUBLE CHECK to be sure a total of " + String( li_total_pages ) + " page(s) is placed in the document feeder.~n~r~n~rClick Ok when ready to scan.", Information!, OkCancel!, 1 )
IF li_ans = 2 THEN
	Return -1
END IF

ls_Rtn = f_ExaWriteRight(ls_tempfile)
if LenA(ls_Rtn) > 0 then
	MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
	Return -1
end if


 image_functions.ii_scan_format = ii_scanner_format  //Start Code Change ----09.03.2009 #V92 maha - set manual format change
//Start Code Change ---- 03.16.2007 #V7 maha  slightly changed order of code
//Modified by (APPEON) Harry 11.13.2017 (V161 Storage of Documents as PDFs)
//if image_functions.of_setup_scan( ole_scan, ls_tempfile, 1) = -1 then
Boolean lb_scan_error = false
IF is_scan_ext = 'PDF' THEN

	IF NOT IsValid(w_scan_cp) THEN Open(w_scan_cp)
	IF w_scan_cp.Dynamic of_scan_saveas_pdf(ls_tempfile) = -1 THEN lb_scan_error = TRUE
	Close(w_scan_cp)
	
	//IF inv_image_func_cp.of_setup_scan( tab_view.tabpage_setup.ole_scanpdf, ls_tempfile, 'PDF') = -1 THEN lb_scan_error = TRUE
ELSE
	IF image_functions.of_setup_scan( ole_scan, ls_tempfile, 1) = -1 THEN lb_scan_error = TRUE
END IF

IF lb_scan_error THEN
//End Modified-------------------------	
	//maha 032806 rewrote message
	filedelete(ls_tempfile)
	Messagebox("Scanning","Scanning has failed to complete.  The Imaging for Windows program has reported an error while scanning.~r~rIf this error repeats, you may need to restart IntelliCred before scanning again.~rIf you still have a problem you may need to restart your computer.")
	return -1
else
	////////////////////////////////////////////////////////////////////////////////////
	// let the user cancel out 
	////////////////////////////////////////////////////////////////////////////////////
	if  is_scan_ext <> 'PDF' then  //Added by (APPEON) Harry 11.22.2017 (V161 Storage of Documents as PDFs)
		res = Messagebox("Scanning","Did the scanning complete properly?",Question!,yesno!,2)
		if res = 2 then 
			if li_orig_last_page > 0 then filedelete(ls_tempfile)
			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 2006-08-19 By: Liu Hongxin
			//$<reason> Fix defect.
			is_image_file_name = ""
			//---------------------------- APPEON END ----------------------------
			return
		end if	
	end if
end if


////////////////////////////////////////////////////////////////////////////////////
// get the page count
////////////////////////////////////////////////////////////////////////////////////


IF is_scan_ext = 'PDF' THEN  //Added by (APPEON) Harry 11.13.2017 (V161 Storage of Documents as PDFs)
//	ole_admin1_pdf.object.FileName = ''
//	ole_admin1_pdf.object.LoadMultiPage ( ls_tempfile, 1)
//	li_newcount = ole_admin1_pdf.object.GetTotalPage()
	IF is_scan_ext = 'PDF' and Not IsValid(w_dm_image_cp) THEN Open(w_dm_image_cp) 
	li_newcount = w_dm_image_cp.of_gettotalpage(ls_tempfile) //Modified by (APPEON) Harry 11.24.2017 (V161 Storage of Documents as PDFs)
	IF IsValid(w_dm_image_cp) THEN Close(w_dm_image_cp) 
ELSE
	ole_admin1.object.Image = ''
	ole_admin1.object.Image = ls_tempfile
	li_newcount = ole_admin1.object.pagecount()
END IF


//End Code Change---03.16.2007

////////////////////////////////////////////////////////////////////////////////////
//maha 012706 check the count of the new scan and check it against the expected number of pages.
////////////////////////////////////////////////////////////////////////////////////

//Start Code Change ----02.24.2011 #V11 maha - added ability to accept scanned count if scanning for 1 image
if li_newcount <> li_total_pages then 
	if li_rc = 1 then
		res = MessageBox( "Page Count Warning", "The number of pages in the new scan (" + string(li_newcount) + ") does not match the number of pages count(" + string(li_total_pages) + ") that is in the image record.  Accept?~rClick YES to set the the page count to the scan count. Click NO to check your page counts and scan again.",information!,yesno!,1)		
		if res = 1 then
			dw_image_data.setItem( 1, "num_pages", li_newcount )
		else
			if li_orig_last_page > 0 then filedelete(ls_tempfile)
			return -1
		end if
	else
		res = MessageBox( "Page Count Warning", "The number of pages in the new scan (" + string(li_newcount) + ") does not match the number of pages count(" + string(li_total_pages) + ") that are in the scan list.  Please check your page counts and scan again. ",stopsign!)		
			if li_orig_last_page > 0 then filedelete(ls_tempfile)
			return -1
		end if
end if
//End Code Change ----02.24.2011

IF is_scan_ext = 'PDF' and Not IsValid(w_dm_image_cp) THEN Open(w_dm_image_cp) //Added by (APPEON) Harry 11.13.2017 (V161 Storage of Documents as PDFs)
//IF scanning completed properly:
//Start Code Change ---- 9.11.2006 #A maha
FOR i = 1 TO li_rc
	IF ii_image_storage_type  = 1 THEN
		dw_image_data.SetItem( i, "tif_start_page", 	1  )
	else
		dw_image_data.SetItem( i, "tif_start_page", 	li_last_page  )
		li_last_page = li_last_page + dw_image_data.GetItemNumber( i, "num_pages" )
	end if
END FOR
//End Code Change---9.11.2006


//RETURN 0
//Clean up the pages 
//FOR i = li_orig_last_page TO tab_view.tabpage_image.ole_scan_edit.Object.PageCount()
//	inv_image_functions.of_Cleanup_page( tab_view.tabpage_image.ole_scan_edit, i )
//END FOR


//Store the images in the database 
IF ii_image_storage_type = 1 THEN
	Long ll_rec_id
	Long ll_prac_id
	Integer li_facility_id
	Integer li_screen_id
	Long ll_seq_no,ll_image_id
	Integer li_cr
	Integer li_start_page
	Blob lb_the_image
	dwitemstatus ldws_status

	//loop through the image table and split up images and store in db
	FOR i = 1 TO li_rc
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 10.12.2006 By: Jack (Inova)
		//$<reason> Queue Images for Scanning from Data Entry.
		dw_image_data.SetItem( i, "de_queue", 1 )
		
		//---------------------------- APPEON END ----------------------------
		
		//---------Begin Added by (Appeon)Stephen 11.04.2016 for V15.3-Image Auditing in IntelliCred--------
		ldws_status = dw_image_data.getitemstatus(i , 0, primary!)
		if ldws_status <> newmodified! then
			inv_dw.of_field_audit(dw_image_data)
		end if
		//---------End Added ------------------------------------------------------
		dw_image_data.Update( )
		ll_image_id = dw_image_data.GetItemNumber( i,/* "image_id" */ "image_pk" ) //add michael 01.30.2011 modify by stephen 03.12.2011
		ll_rec_id = dw_image_data.GetItemNumber( i, "rec_id" )
		ll_prac_id = dw_image_data.GetItemNumber( i, "prac_id" )	
		li_facility_id = dw_image_data.GetItemNumber( i, "facility_id" )	
		li_screen_id = dw_image_data.GetItemNumber( i, "screen_id" )		
		ll_seq_no = dw_image_data.GetItemNumber( i, "seq_no" )	
		ls_ext		= Lower(dw_image_data.GetItemString( li_cr, "image_ext" )) //Added by (APPEON) Harry 11.13.2017 (V161 Storage of Documents as PDFs)
		//Added by (APPEON) Harry 11.13.2017 (V161 Storage of Documents as PDFs)
		IF IsNull(ls_ext) or ls_ext = "" THEN
			IF  is_scan_ext = 'PDF' THEN
				ls_ext = 'pdf'
			ELSE
				ls_ext = 'tif'
			END IF
		END IF
		
		//---------Begin Added by (Appeon)Stephen 11.04.2016 for V15.3-Image Auditing in IntelliCred--------
		if ldws_status = newmodified! then
			inv_dw.of_sqlfield_audit(ll_prac_id, ll_image_id, li_facility_id, 95, '1000', string(ll_image_id) +"-"+string(ll_prac_id), '', 'I')
		end if
		//---------End Added ------------------------------------------------------
		
		//Modified by (APPEON) Harry 11.13.2017 (V161 Storage of Documents as PDFs)
		/*
		FileDelete( gs_temp_path + "split.tif" )
	
		tab_view.tabpage_browse.ole_admin.object.Image( gs_temp_path + "split.tif" )
		

		//Start Code Change ---- 08.09.2007 #V7 maha corrected bug where all start pages were the first page
		
		//tab_view.tabpage_browse.ole_admin.object.Append( ls_tempfile, li_start_page, li_num_pages  )
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 07/09/2007 By: Ken.Guo
		//$<reason> When Image Admin Merge file, The first image file must be in TIF format, Otherwise PB will runerror.
		If tab_view.tabpage_browse.ole_admin.object.pagecount() > 0 and tab_view.tabpage_browse.ole_admin.object.FileType <> 1 Then
			Messagebox('Image','The first image file must be in "TIF" format.')
			Return -1			
		End If 
		//---------------------------- APPEON END ----------------------------
		*/
		FileDelete( gs_temp_path + "split."  + ls_ext)
		IF ls_ext = 'pdf' THEN
			tab_view.tabpage_browse.ole_admin_pdf.ole_edit.object.LoadMultiPage ( gs_temp_path + "split.pdf" , 1)
		ELSE
			tab_view.tabpage_browse.ole_admin.object.Image( gs_temp_path + "split.tif" )
		END IF
		//End Modified-------------------
		
		if i = 1 then li_start_page = 1

		li_num_pages =  dw_image_data.GetItemNumber( i, "num_pages" ) 
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$< Add  > 2008-07-15 By: Scofield
		//$<Reason> Verify if the directory has write right for the current user.
		
		ls_Rtn = f_ExaWriteRight(ls_tempfile)
		if LenA(ls_Rtn) > 0 then
			MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
			IF IsValid(w_dm_image_cp) THEN Close(w_dm_image_cp)  
			Return -1
		end if
		
		//---------------------------- APPEON END ----------------------------
		IF ls_ext = 'pdf' AND is_scan_ext = 'PDF' THEN //Added by (APPEON) Harry 11.13.2017 (V161 Storage of Documents as PDFs)
			w_dm_image_cp.of_insert_page_pdf(tab_view.tabpage_browse.ole_admin_pdf.ole_edit.object.FileName,ls_tempfile, tab_view.tabpage_browse.ole_admin_pdf.ole_edit.object.GetTotalPage(), li_start_page, li_num_pages)
		ELSE
			tab_view.tabpage_browse.ole_admin.object.Append( ls_tempfile, li_start_page, li_num_pages  )
		END IF
			
		 //Start Code Change ----01.17.2014 #V14 maha
		if  of_get_app_setting("set_77","I") =  1 then 
			//of_user_date_stamp(gs_temp_path + "split.tif")
			of_user_date_stamp(gs_temp_path + "split." + ls_ext) //Modified by (APPEON) Harry 11.13.2017 (V161 Storage of Documents as PDFs)
		end if
		 //End Code Change ----01.16.2014
		
		li_start_page += li_num_pages  //reset the start page for the next image
		//End Code Change---08.09.2007
				
//		tab_view.tabpage_browse.ole_admin.object.Append( ls_tempfile, li_start_page, li_num_pages  )  //Start Code Change ----06.04.2008 #V81 maha - removed was redundant and causing a crash
		//lb_the_image = inv_image_functions.of_read_image_file( gs_temp_path + "split.tif" )
		lb_the_image = inv_image_functions.of_read_image_file( gs_temp_path + "split."  + ls_ext) //Modified by (APPEON) Harry 11.13.2017 (V161 Storage of Documents as PDFs)
	
	//------------------- APPEON BEGIN -------------------
    //$<modify> Michael 01.30.2011
    //$<reason> V11.2 ImagingFacility
	
//		UPDATEBLOB pd_images
//		SET image_data = :lb_the_image
//		WHERE rec_id = :ll_rec_id and
//	   	   prac_id = :ll_prac_id and
//				facility_id = :li_facility_id and
//				seq_no = :ll_seq_no and
//				screen_id = :li_screen_id			
//		USING SQLCA;

		if ldws_status = newmodified! then //Added by (APPEON) Harry 11.22.2017 (V161 Storage of Documents as PDFs)
		ls_ext = Upper(ls_ext)
			UPDATE pd_images
				SET image_ext = :ls_ext
				WHERE image_pk = :ll_image_id    
				USING SQLCA;
		end if
			
         UPDATEBLOB pd_images
            SET image_data = :lb_the_image
         WHERE image_pk = :ll_image_id        //modify by stephen 03.12.2011 image_id to image_pk
         USING SQLCA;
	//------------------- APPEON END ---------------------
	
		IF SQLCA.SQLNRows > 0 THEN
			COMMIT USING SQLCA ;
		ELSEIF SQLCA.SQLCODE = -1 THEN
			MessageBox( "SQL ERROR", SQLCA.SQLERRTEXT )
		ELSEIF SQLCA.SQLNRows = 0 THEN	
			MessageBox( "SQL Error", "No rows effected." )
		END IF
	
	END FOR
else  //maha 012706
	if li_orig_last_page = 0 then
		
	else
		ls_ext = Lower(Mid(is_image_file_name,LastPos(is_image_file_name, '.' ) + 1 )) //Added by (APPEON) Harry 11.13.2017 (V161 Storage of Documents as PDFs)
		IF ls_ext = 'pdf' THEN //Added by (APPEON) Harry 11.13.2017 (V161 Storage of Documents as PDFs)
			//ole_admin1_pdf.object.LoadMultiPage( is_image_file_name, 1)
		ELSE
			ole_admin1.object.Image = is_image_file_name
		END IF
		//--------------------------- APPEON BEGIN ---------------------------
		//$< Add  > 2008-07-15 By: Scofield
		//$<Reason> Verify if the directory has write right for the current user.		
		ls_Rtn = f_ExaWriteRight(ls_tempfile)
		if LenA(ls_Rtn) > 0 then
			MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
			IF IsValid(w_dm_image_cp) THEN Close(w_dm_image_cp)  
			Return -1
		end if
		//---------------------------- APPEON END ----------------------------
		
		IF is_scan_ext <> 'PDF' THEN  //Added by (APPEON) Harry 11.13.2017 (V161 Storage of Documents as PDFs)
			if ole_admin1.object.pagecount() > 0 and ole_admin1.object.FileType <> 1 then //alfee 11.03.2009
				Messagebox('Image','The first image file must be in "TIF" format.')
				IF IsValid(w_dm_image_cp) THEN Close(w_dm_image_cp)  
				Return -1			
			end if	
		END IF
		
		IF ls_ext = 'pdf' AND is_scan_ext = 'PDF' THEN //Added by (APPEON) Harry 11.13.2017 (V161 Storage of Documents as PDFs)
			//w_dm_image_cp.of_pdfeditmerge (ole_admin1_pdf.object.FileName, ls_tempfile) 
			w_dm_image_cp.of_pdfeditmerge (is_image_file_name, ls_tempfile)   //Modified by (APPEON) Harry 11.24.2017 (V161 Storage of Documents as PDFs)
		ELSE
			ole_admin1.Object.Append( ls_tempfile, 1, li_newcount )
		END IF
	
		filedelete(ls_tempfile)
	end if
	//Start Code Change ---- 02.08.2007 #V7 maha  jack forgot to add for scanned documents
	for i = 1 TO li_rc
		dw_image_data.SetItem( i, "de_queue", 1 )
	next
	//End Code Change---02.08.2007
END IF
IF  IsValid(w_dm_image_cp) THEN Close(w_dm_image_cp) //Added by (APPEON) Harry 11.13.2017 (V161 Storage of Documents as PDFs)
iw_parent_window.Event pfc_Save()

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2006-09-26 By: Liu Hongxin
//$<reason> Fix defect: pfc_PostUpdate is not execute because of Performance tuning, do it here.
//tab_view.tabpage_browse.dw_browse.Retrieve( il_prac_id )//called from dw_image_data post update
//Start Code Change ----12.04.2012 #V12 maha
//tab_view.tabpage_browse.dw_browse.Retrieve( il_prac_id )
tab_view.tabpage_browse.dw_browse.Retrieve( il_prac_id ,gs_user_id)
//of_security_filter(tab_view.tabpage_browse.dw_browse )//comment by Appeon long.zhang 03.30.2015 (V14.1 Bug # 4465  created for Case# 00052938: Setting up image security )
//End Code Change ----12.04.2012

//---------------------------- APPEON END ----------------------------
of_browse_select_row(0,2) //last row


dw_image_data.Reset()
dw_data.Reset()
dw_image_list.SetFocus()

of_set_alert_text("Scan function completed") //Start Code Change ----08.04.2010 #V10 maha


// used to notify of_doubleclicked the current row ha changed
ib_new_row_added = true
//Start Code Change ---- 04.14.2006 #387 maha
//filedelete(ls_tempfile)
//End Code Change---04.14.2006
end event

type cb_select from commandbutton within tabpage_setup
integer x = 905
integer y = 644
integer width = 530
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "S&elect for Processing"
boolean default = true
end type

event clicked;//Start Code Change ----03.28.2011 #V11 maha - moved code to function and cleaned up
of_select_for_scanning()

return

//@@@@@@@@@@@Old Code 03-2011@@@@@@@@@@@@@@@@@@@@@@@@@@@
//try
//tab_view.tabpage_image.ole_scan_edit.Object.ClearDisplay(  ) //maha 061201
//catch (runtimeerror rte)
//end try
//
//
//Boolean lb_append = False
//Boolean lb_ver_doc = False
//Integer li_screen_id
//Integer li_ans
//Integer li_rec_cnt  
//Integer i
//Integer d
//integer li_rcdel
//Integer li_delrow
//Integer li_start_page
//Integer li_num_page
//Integer li_start_check
//Long ll_seq_no,ll_image_id
//Integer li_new_row
//Integer li_retval
//Integer li_cr
//Integer li_found
//Integer li_facility_id,li_success
//long li_ref_field_id //changed to long 071701 maha
//Long ll_rec_id
//Long ll_prac_id
//String ls_doc_id
//String ls_reference
//String ls_ref_field_name
//String ls_field_type
//String ls_data
//string ref_type //maha 061401
//string ls_lu_field_type //maha 061401
//DataWindowChild dwchild,ldw_child
//Blob lb_null_image
//
////--------------------------- APPEON BEGIN ---------------------------
////$<modify> 2006-08-19 By: Liu Hongxin
////$<reason> Fix defect.
///*
//// mskinner 03 March 2006 -- begin
//if not fileexists(is_image_file_name) and tab_view.tabpage_browse.dw_browse.rowcount( ) > 0 then 
//	messagebox(iw_parent_window.title, 'Image ' + is_image_file_name + ' does not exist. Please check to see if the image folder has been moved.' )
//	return 
//end  if
//// mskinner 03 March 2006 -- end
//*/
////Start Code Change ---- 04.12.2007 #V7 maha
//IF ii_image_storage_type = 1 THEN //added maha 41207
//	//don't need to test if image comes from database
//else
//	//of_doubleclicked(tab_view.tabpage_browse.dw_browse)   // Add by Jack 03/29/2007 //maha removed seems pointless
//	if is_image_file_name <> "" then
//		if not fileexists(is_image_file_name) and tab_view.tabpage_browse.dw_browse.rowcount( ) > 0 then 
//			messagebox(iw_parent_window.title, 'Image ' + is_image_file_name + ' does not exist. Please check to see if the image folder has been moved.' )
//			return 
//		end  if
//	end if
//END IF
////End Code Change---04.12.2007
////---------------------------- APPEON END ----------------------------
//
////if 
//
////Start Code Change ---- 04.04.2006 #378 maha
//tab_view.tabpage_browse.dw_browse.setsort("start_page") //maha moved here from further down
//tab_view.tabpage_browse.dw_browse.sort()
////End Code Change---04.04.2006
//
//SetNull( lb_null_image )
//
//li_cr = dw_data.GetRow()
//
//IF li_cr > 0 THEN	
//	
//	li_screen_id = dw_image_list.GetItemNumber( dw_image_list.GetRow(), "link_to_screen" )
//	IF dw_image_list.GetItemNumber( dw_image_list.GetRow(), "image_type_id" ) = 99 THEN
//		lb_ver_doc = True
//	END IF
//	IF lb_ver_doc THEN	//verification
//		li_screen_id = dw_data.GetItemNumber( li_cr, "screen_id" )
//		ls_reference = dw_data.GetItemString( dw_data.GetRow(), "reference_value" )
//		ref_type = "V"
//		ls_doc_id = dw_data.GetItemString( dw_data.GetRow(), "doc_id" )
//		SELECT Count( rec_id )  
//	   INTO :li_rec_cnt  
//   	FROM pd_images  
//	   WHERE pd_images.doc_id = :ls_doc_id;
//		IF SQLCA.SQLCODE = -1 THEN
//			MessageBox("Database Error", SQLCA.SQLERRTEXT )
//		END IF		
//	ELSEIF li_screen_id = 1 THEN  //linked to basic info
//		ls_reference = dw_image_list.GetItemString( dw_image_list.GetRow(), "image_type_description" ) 		
//		ref_type = "I"
//		SELECT Count( rec_id )  
//	   INTO :li_rec_cnt  
//   	FROM pd_images  
//	   WHERE pd_images.prac_id = :il_prac_id  AND
//				pd_images.reference_name = :ls_reference ;
//		IF SQLCA.SQLCODE = -1 THEN
//			MessageBox("Database Error", SQLCA.SQLERRTEXT )
//		END IF	
//		if li_rec_cnt > 0 then //\/added 013101 maha
//			SELECT  rec_id  
//			INTO :ll_rec_id
//			FROM pd_images  
//			WHERE pd_images.prac_id = :il_prac_id  AND
//					pd_images.reference_name = :ls_reference ;
//			//\maha
//		else 
//			ll_rec_id = gnv_app.of_Get_Id("RECORD_ID") //moved to here 013101 maha
//		end if
//	ELSE	// data entry record
//		//ls_reference = dw_image_list.GetItemString( dw_image_list.GetRow(), "image_type_description" ) 		
//		ref_type = "R"
//		ll_rec_id = dw_data.GetItemNumber( dw_data.GetRow(), "rec_id" ) 	
//		IF dw_image_data.Find( "rec_id = " + String( ll_rec_id), 1, 10000 ) > 0	THEN
//			MessageBox("Image", "You have already selected this record for scanning." )
//			Return -1
//		END IF
//		
//		SELECT Count( rec_id )  
//	   INTO :li_rec_cnt  
//   	FROM pd_images  
//	   WHERE pd_images.rec_id = :ll_rec_id   ;
//		IF SQLCA.SQLCODE = -1 THEN
//			MessageBox("Database Error", SQLCA.SQLERRTEXT )
//		END IF
//	END IF
//	//**************************start of overwrite***********************
//	IF li_rec_cnt > 0 THEN
//		//tab_view.tabpage_browse.dw_browse.setsort("start_page") //maha app093005 trap if records have been sorted
//		//tab_view.tabpage_browse.dw_browse.sort()
//		//tab_view.tabpage_browse.dw_browse.Retrieve( il_prac_id )  //Start Code Change ----06.13.2007 #V7 maha removed for logic purposes
//		Open( w_overwrite_msg )
//		IF Message.StringParm = "C" THEN
//			Return -1
//		ELSEIF Message.StringParm = "O" THEN
//			li_ans = MessageBox("Overwrite", "Are you sure you want to overwrite the supporting image document.", Question!, YesNo!, 1 )
//			IF li_ans = 2 THEN
//				Return -1
//			END IF
//			//\/maha 020101
//			if ref_type = "V" or ref_type = "I"then //\/maha061401
//				li_delrow = tab_view.tabpage_browse.dw_browse.find( "reference_name = '"+ ls_reference +"'", 1, tab_view.tabpage_browse.dw_browse.rowcount() )
//			elseif ref_type = "R" then //for data related records
//				ls_reference = "pd_images_rec_id = " + String( ll_rec_id) 
//				//MessageBox("ls_reference", ls_reference )
//				li_delrow = tab_view.tabpage_browse.dw_browse.find( ls_reference, 1, tab_view.tabpage_browse.dw_browse.rowcount() )
//			else 
//				MessageBox("Reference", "Can't find this reference type" )
//				return -1
//			end if
//			
//			li_rcdel = tab_view.tabpage_browse.dw_browse.rowcount()
//				//MessageBox(string(li_delrow), "li_delrow" )
//			if li_delrow < 1 then 
//				MessageBox(ls_reference, "Can't find this reference" )
//				return -1
//			end if
//			li_start_page = tab_view.tabpage_browse.dw_browse.GetItemNumber( li_delrow, "start_page" )
//			li_num_page = tab_view.tabpage_browse.dw_browse.GetItemNumber( li_delrow, "num_pages" )
////			for d = 1 to li_rcdel //reset start page on records greater than the deleted one
////				li_start_check = tab_view.tabpage_browse.dw_browse.GetItemNumber( d, "start_page" )
////				if li_start_check > li_start_page then 
////					li_start_check = li_start_check - li_num_page
////					tab_view.tabpage_browse.dw_browse.setItem( d, "start_page",li_start_check )
////			end if
////			next
//			tab_view.tabpage_browse.dw_browse.DeleteRow( li_delrow )			
//			IF ii_image_storage_type = 1 THEN			
//				//IF stored in db then do nothing because when you delete the pd_image row you delete the image
//			ELSE
//				tab_view.tabpage_browse.ole_admin.Object.Image( is_image_file_name )
//				//MessageBox("li_start_page", li_start_page )
//				//MessageBox("li_num_page ", li_num_page  )
//				//Start Code Change ---- 05.09.2006 #442 maha
//				if of_check_page_count(li_start_page, tab_view.tabpage_browse.ole_admin.Object.PageCount ,li_num_page) = -1 then
//					return -1
//				end if
//				//End Code Change---05.09.2006
//
//				if li_start_page > 0 then //maha trap 063004 8.188
//					tab_view.tabpage_browse.ole_admin.Object.DeletePages( li_start_page, li_num_page )
//				end if
//				//reset page numbers moved here 040303 maha
//				li_start_check = 1
//				for d = 1 to tab_view.tabpage_browse.dw_browse.rowcount() //reset all start pages 
//					tab_view.tabpage_browse.dw_browse.setItem( d, "start_page",li_start_check )
//					li_start_check = li_start_check + tab_view.tabpage_browse.dw_browse.GetItemNumber( d ,"num_pages")	
//				next
//			END IF
//
//			//iw_parent_window.Event pfc_Save() //jad
//			tab_view.tabpage_browse.dw_browse.update()  //Start Code Change ---- 05.03.2007 #V7 maha 
//			//commit using sqlca;
//			//\maha
//
//
////	  		DELETE FROM pd_images  //maha removed 020101
////   		WHERE pd_images.rec_id = :ll_rec_id   ;
////			IF SQLCA.SQLCODE = -1 THEN
////				MessageBox("Database Error", SQLCA.SQLERRTEXT )
////				Return -1
////			END IF
//		ELSEIF Message.StringParm = "A" THEN
//			lb_append = True
//		END IF
//	END IF
////*******************end of overwrite
//	IF li_screen_id > 1 AND NOT lb_ver_doc THEN
//		//GET REFERENCE FIELD 1 DATA
//		li_ref_field_id = dw_image_list.GetItemNumber( dw_image_list.GetRow(), "reference_field_1" )
//		if isnull(li_ref_field_id) or li_ref_field_id = 0 then  //Start Code Change ---- 06.11.2007 #V7 maha
//			MessageBox("Select Data error", "There is no Reference Field 1 set up for this data screen.  Please contact IntelliSoft Group support for assistance before adding image items for this screen. ")
//			return -1
//		end if
//		//--------------------------- APPEON BEGIN ---------------------------
//		//$<ID> PT-10
//		//$<modify> 03.23.2006 By: LeiWei
//		//$<reason> Performance tuning
//		//$<modification> Write script to retrieve data from a cache instead of from the database.
//
//		/*
//	  SELECT sys_fields.field_name,  
//				 sys_fields.field_type
//	   INTO :ls_ref_field_name,
//			  :ls_field_type
//	   FROM sys_fields  
//   	WHERE sys_fields.field_id = :li_ref_field_id   ;
//		IF SQLCA.SQLCODE = -1 THEN
//			MessageBox("Database Error", SQLCA.SQLERRTEXT )
//			Return -1
//		END IF
//		*/
//		
//		ls_ref_field_name = gnv_data.of_getitem( "sys_fields","field_name", "field_id = "+String(li_ref_field_id))
//		ls_field_type = gnv_data.of_getitem( "sys_fields","field_type", "field_id = "+String(li_ref_field_id))
//		
//		//---------------------------- APPEON END ----------------------------
//		
//	//MessageBox("ls_ref_field_name", ls_ref_field_name )
//	//MessageBox("li_cr before", dw_data.getrow())
//		if dw_data.Describe(ls_ref_field_name + ".ColType") = "!" then  //Start Code Change ---- 06.11.2007 #V7 maha trap
//			MessageBox("Select Data error", "Required field, "  + ls_ref_field_name +  ", is not a valid Field on this data screen.  Please contact IntelliSoft Group support for assistance before adding image items for this screen. ")
//			return -1
//		end if
//		
//		dw_data.SetTabOrder( ls_ref_field_name, 1 )
//		dw_data.SetColumn( ls_ref_field_name )
//		dw_data.setrow(li_cr)//maha 071701
//	//messagebox("li_rc after",dw_data.getrow())
//		li_retval = dw_data.GetChild(ls_ref_field_name, dwchild)
//		debugbreak()
//		ls_data =  dw_data.GetText()
//		IF li_retval = -1 THEN
//			ls_data =  dw_data.GetText()				
//		ELSE
//		
//			//Start Code Change ---- 11.10.2005 #79 maha		
//			li_found = dwchild.Find( "lookup_code = " + ls_data,1,1000000 )	
//			if li_found < 1 then //return // mskinner 21 Sept 2005
//				messagebox("Find lookup Error","Lookup record not found for " + ls_ref_field_name + ".  Check for missing data.")
//				return -1
//			end if
//			//End Code Change---11.10.2005 		
//			IF dw_data.Describe( ls_ref_field_name + ".dddw.displaycolumn") = "code" or  dw_data.Describe( ls_ref_field_name + ".dddw.displaycolumn") = "description" THEN //maha 071401 changed from code only
//				ls_data = dw_data.GetText() //maha 062805 trap for null lookup data
//				IF IsNull( ls_data ) THEN
//					ls_data = ""
//				else
//					ls_data = dwchild.GetItemString( li_found, "code" )
//				end if
//			ELSEIF dw_data.Describe( ls_ref_field_name + ".dddw.displaycolumn") = "entity_name" THEN
//				ls_data = dw_data.GetText()//maha 062805 trap for null lookup data
//				IF IsNull( ls_data ) THEN
//					ls_data = ""
//				else
//					if dwchild.rowcount() > 0 then  //maha app080505
//						ls_data = dwchild.GetItemString( li_found, "entity_name_original" )
//					else
//						ls_data = ""
//					end if
//				end if
//			ELSE
//				ls_data = dw_data.GetText()				
//			END IF
//		END IF
////MessageBox("ls_data", ls_data )
//	
//		IF IsNull( ls_data ) THEN //maha 071701 changed from ls_reference to ls_data
//			ls_reference = ""
//		ELSE 
//			ls_reference = ls_data
//		END IF
//
//		//GET REFERENCE FIELD 2 DATA
//		li_ref_field_id = dw_image_list.GetItemNumber( dw_image_list.GetRow(), "reference_field_2" )
//		//--------------------------- APPEON BEGIN ---------------------------
//		//$<ID> PT-11
//		//$<modify> 03.23.2006 By: LeiWei
//		//$<reason> Performance tuning
//		//$<modification> Write script to retrieve data from a cache instead of from the database.
//		/*
//	   SELECT sys_fields.field_name,  
//				 sys_fields.field_type
//	   INTO :ls_ref_field_name,
//			  :ls_field_type
//	   FROM sys_fields  
//   	WHERE sys_fields.field_id = :li_ref_field_id   ;
//		*/
//		
//		ls_ref_field_name = gnv_data.of_getitem( "sys_fields","field_name", "field_id = "+String(li_ref_field_id))
//		ls_field_type = gnv_data.of_getitem( "sys_fields","field_type", "field_id = "+String(li_ref_field_id))
//		
//		//---------------------------- APPEON END ----------------------------
//
//	//messagebox("ls_ref_field_name",ls_ref_field_name)
//	//Start Code Change ---- 06.11.2007 #V7 maha  trap for missing ref 2
//		if dw_data.Describe(ls_ref_field_name + ".ColType") <> "!" then  //Start Code Change ---- 06.11.2007 #V7 maha trap for bad reference 2
//		
//			dw_data.SetTabOrder( ls_ref_field_name, 1 )
//			dw_data.SetColumn( ls_ref_field_name )
//			dw_data.setrow(li_cr)//maha 071701
//			li_retval = dw_data.GetChild(ls_ref_field_name, dwchild)
//			ls_data = dw_data.GetText()
//			IF IsNull( ls_data ) THEN //maha trap for null lookup 062805
//				ls_data = ""
//			else
//				IF li_retval = -1 THEN
//					ls_data =  dw_data.GetText()				
//					ELSE
//					li_found = dwchild.Find( "lookup_code = " + dw_data.GetText(), 1, 10000 )
//					if li_found < 1 then //maha 061501
//						ls_data = ""
//					else
//						IF dw_data.Describe( ls_ref_field_name + ".dddw.displaycolumn") = "code" THEN
//							ls_data = dwchild.GetItemString( li_found, "code" )
//						ELSEIF dw_data.Describe( ls_ref_field_name + ".dddw.displaycolumn") = "description" THEN  //Start Code Change ----09.02.2010 #V10 maha - added description option
//							ls_data = dwchild.GetItemString( li_found, "description" )
//						ELSEIF dw_data.Describe( ls_ref_field_name + ".dddw.displaycolumn") = "entity_name" THEN
//							ls_data = dwchild.GetItemString( li_found, "entity_name_original" )
//						ELSE
//							ls_data = dw_data.GetText()				
//						END IF
//					end if
//				END IF
//			end if
//		else
//			ls_data = ""
//		end if
//		//End Code Change---06.11.2007	
//		IF NOT IsNull( ls_reference ) THEN
//			ls_reference = ls_reference + " - " + ls_data
//		END IF	
//	//code removed 011305 maha because it caused too many crashes
////		IF dw_image_list.GetItemNumber( dw_image_list.GetRow(), "include_date_fields" ) = 1 THEN
////			ls_data = String( dw_data.GetItemNumber( li_cr, "month_from" ) )
////			IF NOT IsNull( ls_data ) THEN
////				ls_reference = ls_reference + " ( " + ls_data + "/"				
////			ELSE
////				ls_reference = ls_reference + " ( "
////			END IF
////
////			ls_data = String( dw_data.GetItemNumber( li_cr, "year_from" ) )
////			IF NOT IsNull( ls_data ) THEN		
////				ls_reference = ls_reference + ls_data + " - "						
////			END IF			
////			
////			ls_data = String( dw_data.GetItemNumber( li_cr, "month_thru" ) )
////			IF NOT IsNull( ls_data ) THEN		
////				ls_reference = ls_reference + ls_data + "/"										
////			END IF
////			
////			ls_data = String( dw_data.GetItemNumber( li_cr, "year_thru" ) )
////			IF NOT IsNull( ls_data ) THEN		
////				ls_reference = ls_reference + ls_data + " )"		
////			ELSE 
////				ls_reference = ls_reference +  " )"		
////			END IF
////		END IF	
//	END IF
//	ls_reference = MidA(ls_reference,1,100) //maha 022504 trap for overlong values
//	
//	
//	IF dw_image_data.GetItemStatus( 1, 0, Primary! ) = New! THEN
//		dw_image_data.DeleteRow( 0 )	
//	END IF
//
//		
//    //------------------- APPEON BEGIN -------------------
//    //$<Add> Michael 01.30.2011
//    //$<reason> V11.2 ImagingFacility
//	 //Start Code Change ----03.23.2011 #V11 maha -  removed because want to always display facility
////     IF ii_set_59 = 0 THEN
////  	     dw_image_data.object.facility_id_t.visible = false
////          dw_image_data.object.facility_id.visible = false
////          dw_image_data.object.notes.width=2350
////     ELSE 
////           dw_image_data.object.notes.width=1349
////           dw_image_data.object.facility_id_t.visible = true
////           dw_image_data.object.facility_id.visible = true
////	ENd IF
//	 //Start Code Change ----03.23.2011 
//
//     li_success = dw_image_data.getchild('facility_id',ldw_child)
//     IF li_success = 1 THEN
//	     ldw_child.settransobject(SQLCA)
//		 ldw_child.retrieve(gs_user_id)   
//	     ldw_child.insertrow(1)
//		 ldw_child.setitem(1,'facility_id',0)
//		 ldw_child.setitem(1,'facility_name','ALL')
//     END IF
//	  
//     SELECT Max( image_pk )    //modify by stephen 03.12.2011 image_id to image_pk
//       INTO :ll_image_id
//       FROM pd_images;  
//	IF SQLCA.SQLCODE = -1 THEN
//		MessageBox("Database Error", SQLCA.SQLERRTEXT )
//	END IF
//
//	IF IsNull( ll_image_id ) THEN
//		ll_image_id = 0
//	END IF
//	
//	ll_image_id++
//
////------------------- APPEON END ---------------------		
//		
//	li_new_row = dw_image_data.InsertRow( 0 )
//	dw_image_data.ScrollToRow( li_new_row )
//	dw_image_data.SetRow( li_new_row )
//
//	
//   SELECT Max( seq_no )  
//   INTO :ll_seq_no  
//   FROM pd_images  
//   WHERE pd_images.rec_id = :ll_rec_id ;
//	IF SQLCA.SQLCODE = -1 THEN
//		MessageBox("Database Error", SQLCA.SQLERRTEXT )
//	END IF
//	
//	IF IsNull( ll_seq_no ) THEN
//		ll_seq_no = 0
//	END IF
//	
//	ll_seq_no++
//	//messagebox("ll_rec_id",ll_rec_id)
//	//dw_image_data.SetItem( li_new_row,'image_id',ll_image_id) //add michael 01-30-2011  delete by stephen 03.12.2011
//	dw_image_data.SetItem( li_new_row, "image_type_id", dw_image_list.GetItemNumber( dw_image_list.GetRow(), "image_type_id" ) )
//	dw_image_data.SetItem( li_new_row, "prac_id", il_prac_id )
//	dw_image_data.SetItem( li_new_row, "seq_no", ll_seq_no )
//	dw_image_data.SetItem( li_new_row, "rec_id", ll_rec_id  )
//	dw_image_data.SetItem( li_new_row, "facility_id", 0) //ii_verifiying_facility_id  )	change michael 01-30-2011
//		
//	dw_image_data.SetItem( li_new_row, "screen_id", dw_image_list.GetItemNumber( dw_image_list.GetRow(), "link_to_screen" ) )	
//	dw_image_data.SetItem( li_new_row, "reference_name", ls_reference )
//	dw_image_data.SetItem( li_new_row, "active_status", 1 )	
//	dw_image_data.SetItem( li_new_row, "num_pages", dw_image_list.GetItemNumber( dw_image_list.GetRow(), "default_pages" ) )
//
//	IF lb_ver_doc THEN
//		dw_image_data.SetItem( li_new_row, "doc_id", ls_doc_id )	
//	END IF
//	
//	dw_image_data.SetColumn( "notes" )
//	dw_image_data.SetFocus( )
//	IF lb_append THEN
//		IF li_screen_id > 1 THEN
//			UPDATE pd_images
//			SET active_status = 0 
//			WHERE pd_images.rec_id = :ll_rec_id;
//			IF SQLCA.SQLCODE = -1 THEN
//				MessageBox("Database Error 1", SQLCA.SQLERRTEXT )
//			END IF		
//		ELSE
//			UPDATE pd_images
//			SET active_status = 0 
//		   WHERE pd_images.prac_id = :il_prac_id  AND
//					pd_images.reference_name = :ls_reference ;
//			IF SQLCA.SQLCODE = -1 THEN
//				MessageBox("Database Error 2", SQLCA.SQLERRTEXT )
//			END IF					
//		END IF //screen id
//	END IF //append
//END IF //record exists
//
//dw_image_data.SetItem( li_new_row, "date_scanned", DateTime( Today(), Now()) )
//dw_image_data.SetItem( li_new_row, "user_name", gnv_app.of_GetUserId() )
//
////--------------------------- APPEON BEGIN ---------------------------
////$<add> 10.12.2006 By: Jack (Inova)
////$<reason> Queue Images for Scanning from Data Entry.
////dw_image_data.SetItem( li_cr, "tif_start_page", 1 ) //Start Code Change ----06.13.2007 #V7 maha removed not necessary here
//dw_image_data.SetItem(  li_new_row , "de_queue", 0 )  //Start Code Change ----10.12.2007 #V7 maha corrected row variable.
////dw_image_data.Update( ) //Start Code Change ----06.13.2007 #V7 maha removed for logic purposes
////---------------------------- APPEON END ----------------------------
//
//cb_scan.Enabled = True
//cb_from_file.Enabled = True
//cb_remove.Enabled = True
//
//dw_image_data.SetFocus()
end event

type dw_data from u_dw within tabpage_setup
event ue_after_retrieve ( )
integer x = 878
integer y = 12
integer width = 2542
integer height = 604
integer taborder = 50
boolean titlebar = true
string title = "Select Image Record"
boolean hscrollbar = true
end type

event ue_after_retrieve();IF This.RowCount() > 0 THEN
	This.SetRow( 1 )		
	IF tab_view.tabpage_setup.dw_data.DataObject <> "d_image_ver_summary_record_view"	THEN
//		This.SelectRow( 1, True )  //Start Code Change ----01.20.2016 #V15 maha - removed
	END IF
END IF
end event

event clicked;call super::clicked;Integer li_row

li_row = GetClickedRow()

IF li_row > 0 THEN
	This.SetRow( li_row )		
	IF tab_view.tabpage_setup.dw_data.DataObject <> "d_image_ver_summary_record_view"	THEN
//		This.SelectRow( 0, False )   //Start Code Change ----01.20.2016 #V15 maha - removed
//		This.SelectRow( li_row, True )
	END IF	

END IF
end event

event retrieveend;call super::retrieveend;PostEvent( "ue_after_retrieve" )

//This.Modify( "datawindow.color = '79741120'" ) - commented by alfee 11.18.2010


end event

event doubleclicked;cb_select.TriggerEvent( Clicked! )
end event

event pfc_deleterow;//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 2006-08-29 By: Liu HongXin
//$<reason> It hasn't save, so not to delete.
return 1
//---------------------------- APPEON END ----------------------------
end event

type ddlb_zoom from dropdownlistbox within pfc_cst_u_imaging
integer x = 2030
integer y = 4
integer width = 439
integer height = 588
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean vscrollbar = true
string item[] = {"Best Fit","Fit To Width","Fit To Height","Actual Size"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;CHOOSE CASE This.Text
	CASE "Best Fit"
		IF is_ext = 'PDF' THEN //Added by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)
			tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.Object.View = 9
		ELSE
			tab_view.tabpage_image.ole_scan_edit.Object.FitTo( 0 )
		END IF
	CASE "Fit To Width"
		IF is_ext = 'PDF' THEN //Added by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)
			tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.Object.View = 10
		ELSE
			tab_view.tabpage_image.ole_scan_edit.Object.FitTo( 1 )	
		END IF
	CASE "Fit To Height"
		IF is_ext = 'PDF' THEN //Added by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)
			tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.Object.View = 11
		ELSE
			tab_view.tabpage_image.ole_scan_edit.Object.FitTo( 2 )	
		END IF
	CASE "Actual Size"	
		IF is_ext = 'PDF' THEN //Added by (APPEON) Harry 11.08.2017 (V161 Storage of Documents as PDFs)
			tab_view.tabpage_image.ole_scanpdf_edit.ole_edit.Object.View = 8
		ELSE
			tab_view.tabpage_image.ole_scan_edit.Object.FitTo( 3 )	
		END IF
END CHOOSE

end event

type st_zoom from statictext within pfc_cst_u_imaging
integer x = 1833
integer y = 16
integer width = 178
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
string text = "Zoom:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_format from statictext within pfc_cst_u_imaging
integer x = 2171
integer y = 16
integer width = 315
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
string text = "Scan Format:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cbx_show from checkbox within pfc_cst_u_imaging
integer x = 978
integer y = 8
integer width = 526
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "Show Annotations"
boolean checked = true
end type

event clicked;if tab_view.tabpage_image.ole_scan_edit.Object.Imagedisplayed = false then return //maha 031505

// mskinner 09 March 2005 -- begin

TRY
		IF This.Checked THEN
			tab_view.tabpage_image.ole_scan_edit.Object.ShowAnnotationGroup( "image_annotations" )
		ELSE
			tab_view.tabpage_image.ole_scan_edit.Object.HideAnnotationGroup( "image_annotations" )	
		END IF

CATCH (RunTimeError rte)
      
END TRY


// mskinner 09 March 2005 -- end
end event

type ddlb_format from dropdownlistbox within pfc_cst_u_imaging
integer x = 2496
integer y = 4
integer width = 480
integer height = 588
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean vscrollbar = true
string item[] = {"Default","Black & White","GrayScale(16)","GrayScale(256)","True Color"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;//Start Code Change ----09.03.2009 #V92 maha - added functionality
CHOOSE CASE This.Text
	CASE "Default"
		ii_scanner_format = -1
	CASE "Black & White"
		ii_scanner_format = 1
	CASE "GrayScale(16)"
		ii_scanner_format = 2	
		messagebox("Scan Format Warning", "Note that GrayScale(16) format will create a larger scan file, which may have some effect on load and printing performance, and the ability to email the image.")
	CASE "GrayScale(256)"	
		ii_scanner_format = 4	
		messagebox("Scan Format Warning", "Note that GrayScale(256) format will create a much larger scan file, which may effect load and printing performance, and the ability to email the image.")
	case "True Color"
		ii_scanner_format = 16
		messagebox("Scan Format Warning", "Note that True Color format will create a very much larger scan file, which will effect load and printing performance, and the ability to email the image.")
END CHOOSE

end event

type st_recs from statictext within pfc_cst_u_imaging
integer x = 3031
integer y = 16
integer width = 443
integer height = 64
boolean bringtotop = true
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

type cb_expand from commandbutton within pfc_cst_u_imaging
integer x = 2496
integer width = 343
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Expand View"
end type

event clicked;string ls_parm

ls_parm = is_display_doc_name
OpenwithParm(w_image_view_expand, ls_parm)
end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
08pfc_cst_u_imaging.bin 
2500000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff00000001000000000000000000000000000000000000000000000000000000005d94c26001d3755000000003000001c00000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000012000000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003009541a0101c3b810204f392029c0024000000005d94c26001d375505d94c26001d37550000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000050000007a0000000000000001000000020000000300000004fffffffe00000006fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
25ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe00020106009541a0101c3b810204f392029c002400000001fb8f0821101b01640008ed8413c72e2b00000030000000f000000007000001000000004000000101000000480000010200000050000001030000005800000104000000600000010500000068000000000000007000000003000300020000000300000dd90000000300000b440000000300000000000000030000000000000003000000000000000700000000000000010001050000000d00697270006e65746e6761706401030065000c0000735f00006b636f74706f727001040073000f00007270000073746e697472617465676170000101000000090078655f00746e65740102007800090000655f00006e65747800007974090000015f00000073726576006e6f6900000000000000000000000000000000000000000000000000000000000000000003000200000dd900000b4400000000000001000000000000000000000000000101000000000000000000000000000001000300000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000100000000020000030000000000030000010000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff00000001000000000000000000000000000000000000000000000000000000005d94c26001d3755000000003000001c00000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000012000000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003009541a0101c3b810204f392029c0024000000005d94c26001d375505d94c26001d37550000000000000000000000000006f00430074006e006e006500730074
2B00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000050000007a0000000000000001000000020000000300000004fffffffe00000006fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe00020106009541a0101c3b810204f392029c002400000001fb8f0821101b01640008ed8413c72e2b00000030000000f000000007000001000000004000000101000000480000010200000050000001030000005800000104000000600000010500000068000000000000007000000003000300020000000300001dc400000003000013d80000000300000000000000030000000000000003000000000000000700000000000000010001050000000d00697270006e65746e6761706401030065000c0000735f00006b636f74706f727001040073000f00007270000073746e697472617465676170000101000000090078655f00746e65740102007800090000655f00006e65747800007974090000015f00000073726576006e6f6900000000000000000000000000000000000000000000000000000000000000000003000200001dc4000013d800000000000001000000000000000000000000000101000000000000000000000000000001000300000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000100000000020000030000000000030000010000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
25ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff00000001000000000000000000000000000000000000000000000000000000005d94c26001d3755000000003000001c00000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000012000000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003009541a0101c3b810204f392029c0024000000005d94c26001d375505d94c26001d37550000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000050000007a0000000000000001000000020000000300000004fffffffe00000006fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe00020106009541a0101c3b810204f392029c002400000001fb8f0821101b01640008ed8413c72e2b00000030000000f000000007000001000000004000000101000000480000010200000050000001030000005800000104000000600000010500000068000000000000007000000003000300020000000300001dc400000003000013d80000000300000000000000030000000000000003000000000000000700000000000000010001050000000d00697270006e65746e6761706401030065000c0000735f00006b636f74706f727001040073000f00007270000073746e697472617465676170000101000000090078655f00746e65740102007800090000655f00006e65747800007974090000015f00000073726576006e6f6900000000000000000000000000000000000000000000000000000000000000000003000200001dc4000013d800000000000001000000000000000000000000000101000000000000000000000000000001000300000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000100000000020000030000000000030000010000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
22fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe00000004fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff00000001000000000000000000000000000000000000000000000000000000005d94c26001d3755000000003000003400000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000024d00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000036d94028011ce9f116002fd838ac03e8c000000005d94c26001d375505d94c26001d37550000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000008400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000cfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe000201066d94028011ce9f116002fd838ac03e8c00000001fb8f0821101b01640008ed8413c72e2b000000300000021d0000000f000001000000008000000101000000880000010200000090000001030000009800000104000000a000000105000000a800000106000000bc00000107000000c400000108000000cc00000109000000d40000010a000000dc0000010b000000e40000010c000000ec0000010d000000f400000000000000fc00000003000200050000000300004db90000000300002de4000000030000006000000002000000010000001e0000000945676d493174696400000000
22000000032ffffffe0000000b0000ffff000000020000b264000000020000b264000000030039b2b4000000030039b2b40000000b0000ffff0000000b0000ffff0000000f000000000000000100010a0000000b0065726c0076726573003164650000010c0000000b73657262657672650b0031640b0000016c000000657365726465767201080032000b000072730000726573653164657600010d0000000b00657262007672657300326465000001090000000b7365727365767265030032640c0000015f000000636f74736f72706b040073700c000001620000006564726f797473720500656c0d000001690000006567616d746e6f63006c6f7200000101000000097478655f78746e65000102000000090078655f00746e657401070079001300006f660000666563726c656c69696b6e697831676e0001060000000f00646e75006675626f7372656600657a6900000100000000097265765f6e6f6973000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002000500004db900002de40000006000010001000000006d490800696445670001317400000100c8000000020000420000ff0000ffff00ff000000ff00000000000000000100000000000000000100000101ff03000000fe000000002fffff00000000ee000100b30400001000b304100000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff00000001000000000000000000000000000000000000000000000000000000005d94c26001d3755000000003000001c00000000000500003004f0042005800430054005300450052004d004100000000000000000000000000000000000000000000000000000000
2C0000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000012000000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003009541a0101c3b810204f392029c0024000000005d94c26001d375505d94c26001d37550000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000050000007a0000000000000001000000020000000300000004fffffffe00000006fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe00020106009541a0101c3b810204f392029c002400000001fb8f0821101b01640008ed8413c72e2b00000030000000f000000007000001000000004000000101000000480000010200000050000001030000005800000104000000600000010500000068000000000000007000000003000300020000000300000369000000030000027b0000000300000000000000030000000000000003000000000000000700000000000000010001050000000d00697270006e65746e6761706401030065000c0000735f00006b636f74706f727001040073000f00007270000073746e697472617465676170000101000000090078655f00746e65740102007800090000655f00006e65747800007974090000015f00000073726576006e6f69000000000000000000000000000000000000000000000000000000000000000000030002000003690000027b00000000000001000000000000000000000000000101000000000000000000000000000001000300000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000100000000020000030000000000030000010000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
21ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff00000001000000000000000000000000000000000000000000000000000000005d94c26001d3755000000003000002000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000014900000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff0000000384926ca0101c2941600e6f817f4b1113000000005d94c26001d375505d94c26001d37550000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000600000053000000000000000100000002000000030000000400000005fffffffe00000007fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe0002010684926ca0101c2941600e6f817f4b111300000001fb8f0821101b01640008ed8413c72e2b00000030000001190000000700000100000000400000010100000048000001020000005000000103000000580000010400000060000001050000007400000000000000940000000300010000000000030000031a000000030000029500000003000000000000001e0000000945676d4931746964000000000000001e00000016442050486a6b73653420746520303236494157540000004e00000007000000000000000100010500000010006c657300657463656163736472656e6e0001030000000c0074735f00706b636f73706f72000104000000110073656400616d69746f6365676f72746e0101006c00090000655f00006e65747802007874090000015f000000657478650079746e00000100000000097265765f6e6f69730000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000031a0000029500000000676d490874696445000100310001000000007fff00000001000100000003000100000008000000000142c800205048156b7365442074656a303236344157542000004e490000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
18pfc_cst_u_imaging.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
