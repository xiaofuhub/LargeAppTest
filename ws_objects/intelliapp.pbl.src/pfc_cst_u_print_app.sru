$PBExportHeader$pfc_cst_u_print_app.sru
forward
global type pfc_cst_u_print_app from pfc_cst_u_create_app2
end type
type tab_1 from tab within pfc_cst_u_print_app
end type
type tabpage_pl from userobject within tab_1
end type
type cb_add from commandbutton within tabpage_pl
end type
type cb_4 from commandbutton within tabpage_pl
end type
type cb_9 from commandbutton within tabpage_pl
end type
type cb_10 from commandbutton within tabpage_pl
end type
type cb_batch_search from commandbutton within tabpage_pl
end type
type dw_print from u_dw within tabpage_pl
end type
type tabpage_pl from userobject within tab_1
cb_add cb_add
cb_4 cb_4
cb_9 cb_9
cb_10 cb_10
cb_batch_search cb_batch_search
dw_print dw_print
end type
type tabpage_sd from userobject within tab_1
end type
type dw_app_images from datawindow within tabpage_sd
end type
type dw_image_defaults from u_dw within tabpage_sd
end type
type st_5 from statictext within tabpage_sd
end type
type st_4 from statictext within tabpage_sd
end type
type st_3 from statictext within tabpage_sd
end type
type rb_no_print from radiobutton within tabpage_sd
end type
type rb_selected_image from radiobutton within tabpage_sd
end type
type rb_app_default from radiobutton within tabpage_sd
end type
type dw_image_list from u_dw within tabpage_sd
end type
type cb_11 from commandbutton within tabpage_sd
end type
type ole_sd from olecustomcontrol within tabpage_sd
end type
type dw_sd from u_dw within tabpage_sd
end type
type cb_15 from commandbutton within tabpage_sd
end type
type gb_1 from groupbox within tabpage_sd
end type
type tabpage_sd from userobject within tab_1
dw_app_images dw_app_images
dw_image_defaults dw_image_defaults
st_5 st_5
st_4 st_4
st_3 st_3
rb_no_print rb_no_print
rb_selected_image rb_selected_image
rb_app_default rb_app_default
dw_image_list dw_image_list
cb_11 cb_11
ole_sd ole_sd
dw_sd dw_sd
cb_15 cb_15
gb_1 gb_1
end type
type tabpage_net_dev from userobject within tab_1
end type
type dw_ai_copy from u_dw within tabpage_net_dev
end type
type dw_net_dev1 from u_dw within tabpage_net_dev
end type
type cb_7 from commandbutton within tabpage_net_dev
end type
type cb_8 from commandbutton within tabpage_net_dev
end type
type cb_12 from commandbutton within tabpage_net_dev
end type
type tabpage_net_dev from userobject within tab_1
dw_ai_copy dw_ai_copy
dw_net_dev1 dw_net_dev1
cb_7 cb_7
cb_8 cb_8
cb_12 cb_12
end type
type tabpage_gen from userobject within tab_1
end type
type cb_3 from commandbutton within tabpage_gen
end type
type gb_3 from groupbox within tabpage_gen
end type
type cb_process from commandbutton within tabpage_gen
end type
type rb_save from radiobutton within tabpage_gen
end type
type rb_fax from radiobutton within tabpage_gen
end type
type rb_email from radiobutton within tabpage_gen
end type
type rb_print from radiobutton within tabpage_gen
end type
type cbx_edit from checkbox within tabpage_gen
end type
type cbx_use_def_printer from checkbox within tabpage_gen
end type
type cb_6 from commandbutton within tabpage_gen
end type
type cbx_exceptions from checkbox within tabpage_gen
end type
type cb_13 from commandbutton within tabpage_gen
end type
type cb_14 from commandbutton within tabpage_gen
end type
type cb_16 from commandbutton within tabpage_gen
end type
type gb_2 from groupbox within tabpage_gen
end type
type rb_allow_edit from radiobutton within tabpage_gen
end type
type rb_save_locked from radiobutton within tabpage_gen
end type
type cb_5 from commandbutton within tabpage_gen
end type
type st_app from statictext within tabpage_gen
end type
type tabpage_gen from userobject within tab_1
cb_3 cb_3
gb_3 gb_3
cb_process cb_process
rb_save rb_save
rb_fax rb_fax
rb_email rb_email
rb_print rb_print
cbx_edit cbx_edit
cbx_use_def_printer cbx_use_def_printer
cb_6 cb_6
cbx_exceptions cbx_exceptions
cb_13 cb_13
cb_14 cb_14
cb_16 cb_16
gb_2 gb_2
rb_allow_edit rb_allow_edit
rb_save_locked rb_save_locked
cb_5 cb_5
st_app st_app
end type
type tab_1 from tab within pfc_cst_u_print_app
tabpage_pl tabpage_pl
tabpage_sd tabpage_sd
tabpage_net_dev tabpage_net_dev
tabpage_gen tabpage_gen
end type
type dw_process_options from u_dw within pfc_cst_u_print_app
end type
type dw_populated from u_dw within pfc_cst_u_print_app
end type
type cb_temp from commandbutton within pfc_cst_u_print_app
end type
end forward

global type pfc_cst_u_print_app from pfc_cst_u_create_app2
integer width = 4027
integer height = 2120
tab_1 tab_1
dw_process_options dw_process_options
dw_populated dw_populated
cb_temp cb_temp
end type
global pfc_cst_u_print_app pfc_cst_u_print_app

type variables
Boolean ib_connected = False
Boolean ib_open_from_prac_folder = False
Boolean ib_create_actions = True  //maha 06.25.2014

integer ii_batch_button
boolean ib_no_dialog
integer ii_open_from_dash = -1
integer ii_due_days[]

long ii_rec_id			//Added by Scofield on 2008-07-09
//long ii_loc_id			//redundant to il_loc_id in parent

string is_image_print_set = "D" //Start Code Change ----08.10.2009 #V92 maha - D = default, S = Selected, N = none
int ii_update_flag = 0 //add Michael 02.23.2012 Bug2925 generates multiple action items

pfc_cst_nv_data_entry_functions inv_data_entry//Added by Appeon long.zhang 12.26.2014

n_cst_datastore ids_net_dev_action_items //Added by Appeon long.zhang 12.26.2014
end variables

forward prototypes
public function integer of_from_prac_folder (long al_prac_id)
public function integer of_print (integer ai_from_page, integer ai_to_page, integer ai_copies, integer ai_print_exceptions)
private subroutine of_clean_up (integer ai_image_storage_type)
protected function integer of_print_email_app (string ai_print_or_email)
public function integer of_copy_ai_values (integer ai_row)
public subroutine of_saveimage ()
public subroutine of_set_default_image_types ()
public function integer of_security_filter ()
public function integer of_action_item_create (long al_prac, integer al_facility, long al_app, long al_loc_id)
public function integer of_app_print_action (u_dw adw_net_dev)
public function integer of_set_rbbutton (string as_flag)
public function integer of_burn_annotations ()
end prototypes

public function integer of_from_prac_folder (long al_prac_id);
Long ll_rec_id
Long ll_action_type
Long ll_action_status
Integer li_facility_id
long  li_app_id  //modify by Stephen 05.31.2012 -from integer to long
long ll_gpid  //maha 04.14.2014
long li_cnt  //maha 04.14.2014
long i  //maha 04.14.2014
long li_fac_state  //maha 06.10.2014
long li_loc_state  //maha 06.10.2014
long li_pass_state  //maha 06.10.2014
Integer li_nr
String ls_full_name
string ls_sql, ls_where  //maha 04.14.2014
n_ds lds_apps //maha 04.14.2014
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<add> 03.31.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

//Removed by Appeon long.zhang 08.20.2014 (v14.2 For an Web version's error of BugS081401 of IntelliCredApp V14.2 Issues of New Features)
//gnv_appeondb.of_startqueue()
//---------------------------- APPEON END ----------------------------



//maha removed 04.14.2014
//SELECT v_full_name.full_name  
//INTO :ls_full_name  
//FROM v_full_name  
//WHERE v_full_name.prac_id = :al_prac_id   ;
//IF SQLCA.SQLCODE = -1 THEN
//	MessageBox("Database Error", SQLCA.SQLCODE )
//	RETURN -1
//END IF


SELECT lookup_code INTO :ll_action_type FROM code_lookup WHERE lookup_name = 'Action Type' AND code = 'App Out To MD';		
IF SQLCA.SQLCODE = 100 THEN
	MessageBox("Error", "You need to add 'App Out To MD' to the Action Type lookup table." )
	Return -1
END IF

SELECT lookup_code INTO :ll_action_status FROM code_lookup WHERE lookup_name = 'Action Status' AND code = 'Incomplete';
IF SQLCA.SQLCODE = 100 THEN
		MessageBox("Error", "You will need to add 'Incomplete' to the Action Status lookup table." )
		Return -1
END IF
debugbreak()
//Start Code Change ----04.14.2014 #V14.2 maha
lds_apps = create n_ds
lds_apps.dataobject = "d_apps_for_printing"
lds_apps.settransobject(sqlca)

//Start Code Change ----06.12.2014 #V14.2 maha
//ls_sql = lds_apps.getsqlselect()
//
//ls_where = " and net_dev_action_items.action_type = "  + string(ll_action_type) + " and net_dev_action_items.action_status = "  + string(ll_action_status) 
//ls_where+= " and net_dev_action_items.prac_id = " + string(al_prac_id)
//
//ls_sql+= ls_where
//
//lds_apps.setsqlselect(ls_sql)
//lds_apps.settransobject(sqlca)

li_cnt = lds_apps.retrieve(al_prac_id, ll_action_type,ll_action_status)  
//End Code Change ----06.12.2014

if li_cnt < 0 then
	messagebox("Sql Statement failed",ls_sql)
end if

for i = 1 to li_cnt
	li_nr = tab_1.tabpage_pl.dw_print.insertrow(0)
	tab_1.tabpage_pl.dw_print.SetItem( li_nr, "rec_id", lds_apps.getitemnumber(i, "rec_id") )		
	tab_1.tabpage_pl.dw_print.SetItem( li_nr, "prac_name",  lds_apps.getitemstring(i, "full_name") )
	tab_1.tabpage_pl.dw_print.SetItem( li_nr, "prac_id", al_prac_id )
	tab_1.tabpage_pl.dw_print.SetItem( li_nr, "facility_id",  lds_apps.getitemnumber(i, "facility_id") )
	tab_1.tabpage_pl.dw_print.SetItem( li_nr, "app_id", lds_apps.getitemnumber(i, "app_id") )
	tab_1.tabpage_pl.dw_print.SetItem( li_nr, "loc_id_passed", lds_apps.getitemnumber(i, "gp_id"))  //Start Code Change ----04.10.2014 #V14.2 maha
	//Start Code Change ----06.10.2014 #V14.2 maha
	li_loc_state =  lds_apps.getitemnumber(i, "loc_state")
	li_fac_state = lds_apps.getitemnumber(i, "fac_state")
	if isnull(li_loc_state) or li_loc_state = 0 then
		li_pass_state = li_fac_state
	else
		li_pass_state = li_loc_state 
	end if
	tab_1.tabpage_pl.dw_print.SetItem( li_nr, "state_passed", li_pass_state)
	//End Code Change ----06.10.2014
	//tab_1.tabpage_pl.dw_print.SetItem( li_nr, "street_alias",  lds_apps.getitemstring(i, "street_alias") )
next

//End Code Change ----04.14.2014


//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02
//$<add> 03.31.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

//Removed by Appeon long.zhang 08.20.2014 (v14.2 For an Web version's error of BugS081401 of IntelliCredApp V14.2 Issues of New Features)
//gnv_appeondb.of_commitqueue()

//---------------------------- APPEON END ----------------------------

//------------------- APPEON BEGIN -------------------
//$<modify> Evan 10.31.2011
//$<reason> V12.1 Website Population
/*
DECLARE lc_apps_to_print CURSOR FOR  	 
SELECT net_dev_action_items.rec_id,   
       net_dev_action_items.facility_id,   
       net_dev_action_items.app_id  
FROM net_dev_action_items  
WHERE ( net_dev_action_items.prac_id = :al_prac_id ) AND  
      ( net_dev_action_items.action_type = :ll_action_type ) AND  
      ( net_dev_action_items.action_status = :ll_action_status )   ;
*/
//////Start Code Change ----04.14.2014 #V14.2 maha - removed  sql cursor code
//DECLARE lc_apps_to_print CURSOR FOR  	 
//SELECT net_dev_action_items.rec_id,   
//       net_dev_action_items.facility_id,   
//       net_dev_action_items.app_id ,
//		net_dev_action_items.gp_id
//FROM net_dev_action_items, app_hdr
//WHERE ( net_dev_action_items.app_id = app_hdr.app_id and app_hdr.mapping_type = 1 ) AND
//		( net_dev_action_items.prac_id = :al_prac_id ) AND  
//		( net_dev_action_items.action_type = :ll_action_type ) AND  
//		( net_dev_action_items.action_status = :ll_action_status ) ;
////------------------- APPEON END ---------------------
//
//OPEN lc_apps_to_print;
//
//IF SQLCA.SQLCODE = -1 THEN
//	MessageBox("Database Error", SQLCA.SQLCODE )
//	RETURN -1
//END IF	
// //Start Code Change ----04.14.2014 #V14.2 maha - added gpid to fetch twice
//FETCH lc_apps_to_print INTO :ll_rec_id, :li_facility_id, :li_app_id , :ll_gpid ;
//
//DO WHILE SQLCA.SQLCODE = 0
//	
//	li_nr = tab_1.tabpage_pl.dw_print.InsertRow( 0 )
//	tab_1.tabpage_pl.dw_print.SetItem( li_nr, "rec_id", ll_rec_id )		//Added by Scofield on 2008-07-09
//	tab_1.tabpage_pl.dw_print.SetItem( li_nr, "prac_name", ls_full_name )
//	tab_1.tabpage_pl.dw_print.SetItem( li_nr, "prac_id", al_prac_id )
//	tab_1.tabpage_pl.dw_print.SetItem( li_nr, "facility_id", li_facility_id )
//	tab_1.tabpage_pl.dw_print.SetItem( li_nr, "app_id", li_app_id )
//	tab_1.tabpage_pl.dw_print.SetItem( li_nr, "loc_id_passed", ll_gpid )  //Start Code Change ----04.14.2014 #V14.2 maha
//	
//	FETCH lc_apps_to_print INTO :ll_rec_id, :li_facility_id, :li_app_id :ll_gpid ;	
//	
//LOOP
//
//CLOSE lc_apps_to_print;



tab_1.tabpage_pl.dw_print.SetRow( li_nr )
tab_1.tabpage_pl.dw_print.ScrollToRow( li_nr )

tab_1.tabpage_pl.dw_print.SetFocus()

destroy lds_apps  //Start Code Change ----04.14.2014 #V14.2 maha

Return 0
end function

public function integer of_print (integer ai_from_page, integer ai_to_page, integer ai_copies, integer ai_print_exceptions);/******************************************************************************************************************
**  [PUBLIC]   : OF_PRINT( /*integer ai_from_page*/, /*integer ai_to_page*/, /*integer ai_copies*/, /*integer ai_print_exceptions */)
**==================================================================================================================
**  Purpose   	: PRINT THE IMAGE USING THE ocx PRINT DIALOG
**==================================================================================================================
**  Arguments 	: [integer] ai_from_page
**  Arguments 	: [integer] ai_to_page
**  Arguments 	: [integer] ai_copies
**  Arguments 	: [integer] ai_print_exceptions
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: ??
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
** Michael B. Skinner    28  December 2005                                    Changed printing to use 
**																										inv_image_functions.of_print function      
********************************************************************************************************************/


Integer i
Integer li_retval

ole_edit.Object.Page(1)
ole_edit.Object.Display()

IF ai_to_page = 99 or ai_to_page > ole_edit.Object.PageCount() THEN 
	ai_to_page = ole_edit.Object.PageCount()
END IF

FOR i = 1 TO ai_copies
	try
		  if ib_no_dialog then
			//--------Begin Modified by  Nova 05.05.2010------------------------
			// ole_edit.object.PrintImage()
			ole_edit.object.PrintImage(1,ole_edit.object.PageCount,3)
			//--------End Modified --------------------------------------------
		   else 
		   	ole_admin.object.image = ole_edit.object.image
         		inv_image_functions.of_print( ole_admin, ole_edit, Handle(this), '',ai_from_page, ai_to_page)
			//Start Code Change ---- 05.09.2007 #V7 maha  added so that when printing a batch of apps, you don't get the print dialog box for every one
			ib_no_dialog = true
			tab_1.tabpage_gen.cbx_use_def_printer.checked = true
			//End Code Change---05.09.2007
	     end if 
   catch (runtimeerror e)
		
   end try
NEXT

IF ai_print_exceptions = 1 THEN
	dw_exceptions.Print()
END IF

Return 0
end function

private subroutine of_clean_up (integer ai_image_storage_type);//////////////////////////////////////////////////////////////////////
// $<function>pfc_cst_u_print_app.of_clean_up()
// $<arguments> value	integer	ai_image_storage_type
// $<returns> (none)
// $<description>For replace the goto clean_up statement
//////////////////////////////////////////////////////////////////////
// $<add> 01.13.2006 by Wang Chao
//////////////////////////////////////////////////////////////////////

IF ai_image_storage_type = 1 AND IsValid( pfc_cst_nv_image_functions ) THEN
	Destroy pfc_cst_nv_image_functions
END IF

gi_burn_annos	= 0
tab_1.tabpage_sd.dw_image_list.SetFilter( "" )
tab_1.tabpage_sd.dw_image_list.Filter()

tab_1.tabpage_net_dev.dw_net_dev1.Event Constructor()

COMMIT USING SQLCA;

tab_1.tabpage_pl.dw_print.Reset()
tab_1.tabpage_sd.dw_sd.Reset()

//Start Code Change ----12.04.2012 #V12 maha - added user argument and function call
tab_1.tabpage_sd.dw_image_list.Retrieve(gs_user_id)
of_security_filter( )
//End Code Change ----12.04.2012

//ole_edit.SetRedraw( True )

tab_1.tabpage_gen.st_app.Text = "Complete"

IF ib_open_from_prac_folder THEN
	//Start Code Change ----03.09.2013 #V12 maha
	IF IsValid( gw_prac_data ) THEN
		gw_prac_data.Event pfc_cst_refresh_net_dev_ai()
	end if
		
//	IF IsValid( w_prac_data_1 ) THEN
//		w_prac_data_1.Event pfc_cst_refresh_net_dev_ai()
//	ELSEIF IsValid( w_prac_data_intelliapp ) THEN
//		w_prac_data_intelliapp.Event pfc_cst_refresh_net_dev_ai()
//	ELSEIF IsValid( w_prac_data_sk ) THEN //SK Practitioner Folder - alfee 09.28.2010
//		w_prac_data_sk.Event pfc_cst_refresh_net_dev_ai()		
//	END If
	//End Code Change ----03.09.2013
END IF

IF IsValid(w_dm_image_cp) THEN Close(w_dm_image_cp)  //Added by (APPEON) Harry 11.24.2017 (V161 Storage of Documents as PDFs)

gi_burn_annos	= 0


end subroutine

protected function integer of_print_email_app (string ai_print_or_email);Integer li_screen_id
Integer li_pagecount
Integer li_num_days_app_rcvd_prac
Integer li_image_storage_type
Integer f
Integer li_cnt
Integer li_app_rcvd_prac_cnt
integer li_add //maha 08.10.09
integer li_image_type_list[] //maha 08.10.09
Integer li_app_rcvd_prac
Integer li_num_pages
Integer li_start_page
Integer li_to_page
Integer li_image_type_count
Integer li_prac_image_cnt
Integer m
Integer z
Integer li_image_type_id
Integer li_image_count
Integer li_image_cnt //maha 021904
Integer li_nd_row_cnt
Integer a
Integer li_rc
Integer i
Integer li_from_page
Integer li_print_exceptions
Integer li_found
integer fc //maha 06.18.07
integer fcn //maha 06.18.07
integer li_email_choice//Start Code Change ----10.06.2008 #V85 maha
integer li_step  //maha 08.25.2010
integer li_copies  //maha 02.23.2012
integer li_export_id //stephen 02.24.2014
Long ll_incompleted_action_status
Long ll_pending_action_status
Long ll_rec_id 
Long ll_next_id
Long	ll_action_type
Long	ll_action_status
LONG  ll_Incomplete
Long	ll_action_dept
long ll_getaction //maha 06.1807
long ll_app_list[] //maha 08.10.09
long ll_prac_list[] //maha 08.10.09
long ll_prac_test //maha 08.10.09
long ll_app_test //maha 08.10.09
Long li_seq_no, ll_Return
long ll_image_facil //maha 04.29.2011
long ll_StAppImgInDB			//Added by Scofield on 2008-07-09
long ll_row_update,rtn //Added by Appeon long.zhang 12.26.2014 
DateTime ldt_today
DateTime	ldt_action_dt
DateTime	ldt_next_action_dt
Date ld_due_date
String ls_num_days_app_rcvd_prac
String ls_facility_name[]
String ls_attachments[]
String ls_cover_page
String ls_cover_message
String ls_subject
String ls_fax[]
String ls_app_type
String ls_emp_mail_login
String ls_action_notes
String ls_image_path
String	ls_action_user
String ls_app_image_name
String ls_name
String ls_app_nm
String ls_email_address
String ls_notetext
string ls_appnd_files[] //maha 06.18.07
string ls_Attach
string ls_parm, ls_facility_nm, ls_prac_nm //alfee 06.29.2010
String ls_errtext,ls_Rtn
string  ls_emailcc    //Stephen 05.08.2013
String ls_null[]   //stephen 02.24.2014
String ls_sql_old,ls_sql_new //Added by Appeon long.zhang 12.26.2014 
boolean ib_skip_code // skip the rest of the codemskinner  23 March 2006
boolean lb_burned = false  //maha 08.04.2016
DataWindowChild dwchild
gs_pass_ids  lg_pass_ids
datawindow ldw_defaults
long ll_CntD, ll_CntS //stephen 05.05.2011
long ll_find2, ll_image_type_sel, ll_row //stephen 05.05.2011
long ll_email_id   //Stephen 05.08.2013
pfc_cst_nv_fax nv_emailfax  //stephen 02.24.2014
boolean lb_exist_pdf = false  //Added by (APPEON) Harry 11.15.2017
String ls_filename_temp  //Added by (APPEON) Harry 11.15.2017

//Start Code Change ----08.30.2011 #V11 maha - moved from below and added trap
li_rc = tab_1.tabpage_pl.dw_print.RowCount()
if li_rc = 0 then return 1
//End Code Change ----08.30.2011

ldt_today = DateTime( Today(), Now( ))
tab_1.tabpage_pl.dw_print.AcceptText()

gnv_appeondb.of_startqueue( )

 //Start Code Change ----06.15.2015 #V15 maha - removed as these variables are not used
//select lookup_code into :ll_pending_action_status from code_lookup where lookup_name = 'Action Status' and code = 'Pending';
//select lookup_code into :ll_incompleted_action_status from code_lookup where lookup_name = 'Action Status' and code = 'Incomplete';
//End Code Change ----06.15.2015
ll_StAppImgInDB = of_get_app_setting("set_StAppImgInDB","I")

datastore lds_facility,lds_pd_address
long ll_rowcount1,ll_rowcount2,ll_find
lds_facility = create datastore
lds_pd_address = create datastore
lds_facility.dataobject = 'd_g_facility'
lds_pd_address.dataobject = 'd_pd_address_pd_address_link'
lds_facility.settransobject(sqlca)
ll_rowcount1 = lds_facility.retrieve()
lds_pd_address.settransobject(sqlca)
ll_rowcount2 = lds_pd_address.retrieve()

datastore lds_pd_affil_stat,lds_net_dev_action_items
long ll_rowcount3,ll_rowcount4,ll_action_status1
lds_pd_affil_stat = create datastore
lds_net_dev_action_items = create datastore
lds_net_dev_action_items.dataobject = 'd_net_dev_action_items_count'
lds_pd_affil_stat.dataobject = 'd_pd_affil_stat'
//tab_1.tabpage_sd.dw_sd.dataobject = 'd_pd_image_list_all'  //Start Code Change ----08.10.2009 #V92 maha - changed to below
tab_1.tabpage_sd.dw_sd.dataobject = 'd_pd_image_list_print_pracs'  //Start Code Change ----08.10.2009 #V92 maha - necessary pracs only
lds_pd_affil_stat.settransobject(sqlca)
tab_1.tabpage_sd.dw_app_images.settransobject(sqlca)  //Start Code Change ----08.10.2009 #V92 maha
ll_rowcount3 = lds_pd_affil_stat.retrieve()
lds_net_dev_action_items.settransobject(sqlca)
ll_rowcount4 = lds_net_dev_action_items.retrieve()
tab_1.tabpage_sd.dw_sd.settransobject(sqlca)
//tab_1.tabpage_sd.dw_sd.retrieve() ////Start Code Change ----08.10.2009 #V92 maha - will be retrieved further down

select custom_3 into :ls_num_days_app_rcvd_prac from code_lookup where lookup_name = 'Action Type' and code = 'App Rcvd Prac';
select lookup_code into :ll_action_type from code_lookup where lookup_name = 'Action Type' and code = 'App Out To MD';
select lookup_code into :ll_action_status1 from code_lookup where lookup_name = 'Action Status' and code = 'Complete';

gnv_appeondb.of_commitqueue( )

 //Start Code Change ----06.15.2015 #V15 maha - removed as these variables are not used
//IF isnull(ll_pending_action_status) or ll_pending_action_status = 0 THEN
//	MessageBox("Error", "You will need to add a 'Pending' code to the Action Status lookup table." )//Start Code Change ---- 12.18.2006 #V7 maha corrected message
//	of_clean_up(li_image_storage_type)
//	Return 1
//END IF
//IF isnull(ll_incompleted_action_status) or ll_incompleted_action_status = 0 THEN
//	MessageBox("Error", "You will need to add an 'Incomplete' code to the Action Status lookup table." )//Start Code Change ---- 12.18.2006 #V7 maha corrected message
//	of_clean_up(li_image_storage_type)
//	Return 1
//END IF
 //End Code Change ----06.15.2015 

//IF isnull(ls_num_days_app_rcvd_prac) or ls_num_days_app_rcvd_prac = '' THEN   //Start Code Change ---- 04.12.2007 #V7 maha removed redundant and bad message
//	MessageBox("Lookup missing", "You will need to add a 'App Rcvd Prac' code to the Action Type lookup table." )
//END IF
IF isnull(ll_action_type) or ll_action_type = 0 THEN
	MessageBox("Error", "You will need to add an 'App Out To MD' code to the Action Type lookup table." )
	of_clean_up(li_image_storage_type)
	Return 1
END IF
IF isnull(ll_action_status1) or ll_action_status1 = 0 THEN
	MessageBox("Error", "You will need to add an 'Complete' code to the Action Status lookup table." )
	of_clean_up(li_image_storage_type)
	Return 1
END IF

IF LenA( ls_num_days_app_rcvd_prac ) = 0 OR IsNull( ls_num_days_app_rcvd_prac ) THEN
	MessageBox("Next Due Date", "The NEXT due date field will be set to 30 days from today for follow up.  To set a default (and remove this message), go to your Action Type lookup table (Lookup Painter)and change the Follow Up Days field to the number of days that you want to wait until your next follow up.")
	li_num_days_app_rcvd_prac = 30
ELSE
	li_num_days_app_rcvd_prac = Integer( ls_num_days_app_rcvd_prac )
END IF

//Start Code Change ---- 06.18.2007 #V7 maha  getting due days for each action
for i = 1 to tab_1.tabpage_net_dev.dw_net_dev1.rowcount()  //get array of action_items
	ll_getaction = tab_1.tabpage_net_dev.dw_net_dev1.getitemnumber(i,"action_type")
	ii_due_days[ i ] = integer(gnv_data.of_getitem("code_lookup" , "custom_2","lookup_code = " + string(ll_getaction))) //modify by stephen 04.12.2012 from custom_3 to custom_2 -- bug id 3011  Due Date is not Auto matic
	if ii_due_days[ i ] = 0 then ii_due_days[ i ] = 30
	//messagebox("",string(ii_due_days[ i ]))
next
//End Code Change---06.18.2007

ll_rowcount1 = lds_facility.rowcount()
ll_rowcount2 = lds_pd_address.rowcount()
ll_rowcount3 = lds_pd_affil_stat.rowcount()
ll_rowcount4 = lds_net_dev_action_items.rowcount()
//---------------------------- APPEON END ----------------------------

//EMAIL CODE
IF ai_print_or_email = "E" THEN
	li_email_choice = gi_email_type  //Sttart Code Change ----10.06.2008 #V85 maha
	ls_emp_mail_login= gnv_data.of_getitem("security_users","email_id","upper(user_id) = " + "'" + upper(gs_user_id) + "'")

	IF ls_emp_mail_login = "" OR IsNull( ls_emp_mail_login ) THEN
		MessageBox("", "You must setup an email login in the Security User Painter for user: " + gs_user_id )
		gi_burn_annos	= 0
		Return -1
	END IF

	FOR i = 1 TO li_rc
		IF tab_1.tabpage_pl.dw_print.GetItemNumber( i, "selected" )	= 0 THEN
			CONTINUE
		END IF		
		st_name.Text = tab_1.tabpage_pl.dw_print.GetItemString( i, "prac_name" )	
		ii_prac_id = tab_1.tabpage_pl.dw_print.GetItemNumber( i, "prac_id" )
		ii_facility_id  = tab_1.tabpage_pl.dw_print.GetItemNumber( i, "facility_id" ) 
		il_loc_id = tab_1.tabpage_pl.dw_print.GetItemNumber( i, "loc_id_passed" )  //Start Code Change ----04.07.2014 #V14.2 maha
		il_state_passed = tab_1.tabpage_pl.dw_print.GetItemNumber( i, "state_passed" )  //Start Code Change ----06.10.2014 #V14.2 maha
		li_copies = tab_1.tabpage_pl.dw_print.GetItemNumber( i, "num_copies" ) 
		if isnull(li_copies) or li_copies = 0 then li_copies = 1
		
		ll_find = lds_facility.find("facility_id = " + string(ii_facility_id),1,ll_rowcount1)
		if ll_find > 0 then
			ls_facility_name[i] = lds_facility.getitemstring(ll_find,'facility_name')
		else
			MessageBox("Database Error", 'Facility Name not found' )
			of_clean_up(li_image_storage_type)
			Return 1
		END IF
		
		ll_find = lds_pd_address.find("pd_address_link_prac_id = " + string(ii_prac_id) + " and pd_address_link_facility_id = " + string(ii_facility_id),1,ll_rowcount2)
		if ll_find > 0 then
			ls_email_address = lds_pd_address.getitemstring(ll_find,'pd_address_e_mail_address')
			IF ls_email_address = "" OR IsNull( ls_email_address ) THEN
				MessageBox( "No Email Address", "To send an EMAIL to " + st_name.Text + " there must be an EMAIL address entered in the office address record that is marked as a MAILING address for the " + ls_facility_name[i] + " facility." )						
				Return -1
			END IF
		else
			MessageBox( "No Mailing Address", "To send an EMAIL to " + st_name.Text + " there must be a MAILING address entered in the address screen of the Practitioner Folder for the " + ls_facility_name[i] + " Facility." )
			gi_burn_annos	= 0
			Return -1
		END IF	
	END FOR

	//---------------------------- APPEON END ----------------------------
	
	OpenWithParm( w_fax_win, "Apps" + "-" + "Email")
	IF Message.StringParm = "Cancel" THEN
		gi_burn_annos	= 0		
		Return -1
	END IF
	lg_pass_ids = Message.PowerObjectParm

	//is_cover_page = lg_pass_ids.s_fax_cover
	ls_notetext = lg_pass_ids.s_fax_message 
	ls_subject = lg_pass_ids.s_fax_subject	
	select export_id into :li_export_id  from wf_email where email_id = :lg_pass_ids.email_id; //(Appeon)Stephen 02.24.2014 - Bug 3951
	//------------------- APPEON BEGIN -------------------
	//$<add> Stephen 05.08.2013
	//$<reason> V12.3 Modification estimate
	//(Appeon)Stephen 2013-07-02 - V141 Feature Request 3483
	//  get email cc
	//	ll_email_id = lg_pass_ids.email_id
	//	select cc_recip into :ls_emailcc from wf_email where email_id = :ll_email_id using sqlca;
	//	if isnull(ls_emailcc) then ls_emailcc = ''	
	ls_emailcc = lg_pass_ids.s_stringval
	//------------------- APPEON END -------------------
	
//FAX CODE
ELSEIF ai_print_or_email = "F" THEN
	
	//delete any left over faxes
	FOR f = 1 TO 10000
		li_cnt = 0
		IF FileExists( gs_temp_path + "\Fax\fax_" + String( f )+ ".doc" ) THEN
			li_cnt++
		   FileDelete( gs_temp_path + "\Fax\fax_" + String( f )+ ".doc" )
		END IF
		IF FileExists( gs_temp_path + "\Fax\fax_a_" + String( f )+ ".tif" ) THEN
			li_cnt++		
			FileDelete( gs_temp_path + "\Fax\fax_a_" + String( f )+ ".tif" )			
		END IF
		IF FileExists( gs_temp_path + "\Fax\app_" + String( f )+ ".tif" ) THEN
			li_cnt++		
			FileDelete( gs_temp_path + "\Fax\app_" + String( f )+ ".tif" )			
		END IF
		IF FileExists( gs_temp_path + "\Fax\image_" + String( f )+ ".tif" ) THEN		
			li_cnt++		
			FileDelete( gs_temp_path + "\Fax\image_" + String( f )+ ".tif" )					
		END IF
		//Added by (APPEON) Harry 11.15.2017 (V161 Storage of Documents as PDFs)
		IF FileExists( gs_temp_path + "\Fax\fax_a_" + String( f )+ ".pdf" ) THEN
			li_cnt++		
			FileDelete( gs_temp_path + "\Fax\fax_a_" + String( f )+ ".pdf" )			
		END IF
		IF FileExists( gs_temp_path + "\Fax\app_" + String( f )+ ".pdf" ) THEN
			li_cnt++		
			FileDelete( gs_temp_path + "\Fax\app_" + String( f )+ ".pdf" )			
		END IF
		IF FileExists( gs_temp_path + "\Fax\image_" + String( f )+ ".pdf" ) THEN		
			li_cnt++		
			FileDelete( gs_temp_path + "\Fax\image_" + String( f )+ ".pdf" )					
		END IF
		IF li_cnt = 0 THEN
			Exit
		END IF
	END FOR


	FOR i = 1 TO li_rc
		IF tab_1.tabpage_pl.dw_print.GetItemNumber( i, "selected" )	= 0 THEN
			CONTINUE
		END IF		
		st_name.Text = tab_1.tabpage_pl.dw_print.GetItemString( i, "prac_name" )	
		ii_prac_id = tab_1.tabpage_pl.dw_print.GetItemNumber( i, "prac_id" )
		ii_facility_id  = tab_1.tabpage_pl.dw_print.GetItemNumber( i, "facility_id" ) 
		il_loc_id = tab_1.tabpage_pl.dw_print.GetItemNumber( i, "loc_id_passed" )  //Start Code Change ----04.07.2014 #V14.2 maha

		ll_find = lds_facility.find("facility_id = " + string(ii_facility_id),1,ll_rowcount1)
		if ll_find > 0 then
			ls_facility_name[i] = lds_facility.getitemstring(ll_find,'facility_name')
		else
			MessageBox("Database Error", 'No Find facility name' )
			of_clean_up(li_image_storage_type)
			Return 1
		END IF

		ll_find = lds_pd_address.find("pd_address_link_prac_id = " + string(ii_prac_id) + " and pd_address_link_facility_id = " + string(ii_facility_id),1,ll_rowcount2)
		if ll_find > 0 then
			ls_fax[i] = lds_pd_address.getitemstring(ll_find,'pd_address_fax')
			IF IsNull( ls_fax[i] ) OR ls_fax[i] = ""  THEN
				MessageBox( "No Fax Number", "To send a FAX to " + st_name.Text + " there must be a FAX number entered in the office address record that is marked as a MAILING address for the " + ls_facility_name[i] + " facility." )			
				Return -1
			END IF	
		else
			MessageBox( "No Mailing Address", "To send a FAX to " + st_name.Text + " there must be a MAILING address entered in the address screen of the Practitioner Folder for the " + ls_facility_name[i] + " Facility." )
			gi_burn_annos	= 0
			Return -1
		END IF	
	END FOR
	//---------------------------- APPEON END ----------------------------	
		
	pfc_cst_nv_fax nv_fax
	nv_fax = CREATE pfc_cst_nv_fax;

	OpenWithParm( w_fax_win, "Apps" )
	IF Message.StringParm = "Cancel" THEN
		Return -1
	END IF

	lg_pass_ids = Message.PowerObjectParm

	ls_cover_page = lg_pass_ids.s_fax_cover
	ls_cover_message = lg_pass_ids.s_fax_message 
	ls_subject = lg_pass_ids.s_fax_subject	
	
END IF //if email or fax

IF NOT ib_connected THEN
	of_connections( "IntelliCred", "0" )
END IF

//PrintSetup()

tab_1.tabpage_pl.dw_print.AcceptText()

IF tab_1.tabpage_gen.cbx_exceptions.Checked THEN
	li_print_exceptions = 1
ELSE
	li_print_exceptions = 0
END IF

if is_image_print_set = "D" then //if D then reretrieve the defaults
	//Start Code Change ----12.04.2012 #V12 maha - added user argument and function call
	tab_1.tabpage_sd.dw_image_list.Retrieve(gs_user_id)
	of_security_filter( )
	//End Code Change ----12.04.2012
	//------------------- APPEON BEGIN -------------------
	//$<add> Stephen 05.05.2011
	//$<reason>set default images with applications
	ll_CntD = tab_1.tabpage_sd.dw_image_defaults.RowCount()
	ll_CntS= tab_1.tabpage_sd.dw_image_list.RowCount()	
//Start Code Change ----07.07.2011 #V11 maha 	- removed because the default list should not be changed
//	For ll_Row = 1 to ll_CntD
//		ll_image_type_sel = tab_1.tabpage_sd.dw_image_defaults.GetItemNumber(ll_Row,"image_type")
//		ll_Find = tab_1.tabpage_sd.dw_image_list.Find("image_type_id=" + String(ll_image_type_sel),1,ll_CntS )
//		if ll_Find > 0 then 
//			tab_1.tabpage_sd.dw_image_list.SetItem(ll_Find,"selected",1)
//		end if
//	Next
//End Code Change ----07.07.2011
	//------------------- APPEON END ---------------------
end if
tab_1.tabpage_sd.dw_image_list.SetFilter( "selected = 1" )
tab_1.tabpage_sd.dw_image_list.Filter()	
li_image_count = tab_1.tabpage_sd.dw_image_list.RowCount()

//Start Code Change ----08.10.2009 #V92 maha - get list of image types unless set to print none
if is_image_print_set = "D" or is_image_print_set = "S" then
	for i = 1 to li_image_count
		li_image_type_list[i] = tab_1.tabpage_sd.dw_image_list.GetItemNumber( i, "image_type_id" )
	next
end if
//End Code Change---08.10.2009

//Start Code Change ----05.19.2016 #V152 maha - maha removed 8-4-16 moved further down
//IF ai_print_or_email = "E" OR  ai_print_or_email = "F" OR  ai_print_or_email = "S" THEN //(V15.1 View Apps) added 'S' for - alfee 07.22.2015
//	gi_burn_annos	= 1
//END IF
//Start Code Change ----08.04.2016 #V152 maha - moved below
//IF ai_print_or_email = "E" OR  ai_print_or_email = "F" Then  
//	gi_burn_annos	= 1
//END IF
//
//If ai_print_or_email = "S" OR  ai_print_or_email = "P" THEN
//	if tab_1.tabpage_gen.rb_save_locked.checked then 
//		gi_burn_annos	= 1
//	else
//		gi_burn_annos	= 0
//	end if
//end if
////End Code Change ----05.19.2016

li_nd_row_cnt = tab_1.tabpage_net_dev.dw_net_dev1.RowCount()

gnv_appeondb.of_startqueue( )
SELECT record_id,print_id  INTO :ll_rec_id,:ll_next_id  FROM ids  ;
UPDATE ids SET print_id = print_id + :li_rc,record_id = record_id + :li_rc * :li_nd_row_cnt;
gnv_appeondb.of_commitqueue( )

IF IsNull( ll_next_id ) THEN
	ll_next_id = 0
END IF

//Start Code Change ----08.10.2009 #V92 maha - get the list of app ids and pracs for filtering
FOR i = 1 TO li_rc
	IF tab_1.tabpage_pl.dw_print.GetItemNumber( i, "selected" )	= 1 THEN
		//create app array for images
		li_add = 1
		ll_app_test = tab_1.tabpage_pl.dw_print.GetItemNumber( i, "app_id" )
		for f = 1 to upperbound(ll_app_list[])
			if ll_app_list[f] = ll_app_test then
				li_add = 0
				exit
			end if
		next
		if li_add = 1 then
			ll_app_list[upperbound(ll_app_list[]) +1] = ll_app_test
		end if

		//create prac array
		li_add = 1
		ll_prac_test = tab_1.tabpage_pl.dw_print.GetItemNumber( i, "prac_id" )
		for f = 1 to upperbound(ll_prac_list[])
			if ll_prac_list[f] = ll_prac_test then
				li_add = 0
				exit
			end if
		next
		if li_add = 1 then
			ll_prac_list[upperbound(ll_prac_list[]) +1] = ll_prac_test
		end if
	end if
next

	//get list of default image types conected to apps
if is_image_print_set = 'D' then
	tab_1.tabpage_sd.dw_app_images.retrieve(ll_app_list)
end if

	//if default or selected then get prac image data
if is_image_print_set = 'D' or is_image_print_set = 'S' then
	tab_1.tabpage_sd.dw_sd.retrieve(ll_prac_list)
end if
//End Code Change---08.10.2009

IF NOT IsValid(w_dm_image_cp) THEN Open(w_dm_image_cp)  //Added by (APPEON) Harry 11.15.2017 (V161 Storage of Documents as PDFs)

FOR i = 1 TO li_rc
	IF tab_1.tabpage_pl.dw_print.GetItemNumber( i, "selected" )	= 0 THEN //maha 042704
		tab_1.tabpage_pl.dw_print.setitemstatus(i,0,primary!,NotModified!)
	else
		debugbreak()
		li_app_rcvd_prac_cnt = 0
		tab_1.tabpage_gen.st_app.Text = "Generating application " + String( i ) + " of " + String( li_rc )
		//ole_edit.SetRedraw( True )
		ii_rec_id = tab_1.tabpage_pl.dw_print.GetItemNumber( i, "rec_id" )			//Added by Scofield on 2008-07-09
		If IsNull(ii_rec_id) Then ii_rec_id = 0 //Added by Appeon long.zhang 05.11.2015
		st_name.Text = tab_1.tabpage_pl.dw_print.GetItemString( i, "prac_name" )	
		ii_prac_id = tab_1.tabpage_pl.dw_print.GetItemNumber( i, "prac_id" )
		ii_app_id  = tab_1.tabpage_pl.dw_print.GetItemNumber( i, "app_id" ) 
		ii_facility_id  = tab_1.tabpage_pl.dw_print.GetItemNumber( i, "facility_id" ) 
		il_loc_id = tab_1.tabpage_pl.dw_print.GetItemNumber( i, "loc_id_passed" )  //Start Code Change ----04.07.2014 #V14.2 maha
		If IsNull(il_loc_id) Then il_loc_id = 0 //Added by Appeon long.zhang 05.11.2015
		il_state_passed = tab_1.tabpage_pl.dw_print.GetItemNumber( i, "state_passed" )  //Start Code Change ----06.10.2014 #V14.2 maha
		//Start Code Change ----.2012 #V12 maha
		li_copies = tab_1.tabpage_pl.dw_print.GetItemNumber( i, "num_copies" ) 
		if isnull(li_copies) or li_copies = 0 then li_copies = 1
		
		tab_1.tabpage_pl.dw_print.GetChild( "app_id", dwchild )
		li_found = dwchild.Find( "app_hdr_app_id = " + String( ii_app_id ),1, dwchild.RowCount() )
		//maha 0909054 trap added for inactive apps
		if li_found < 1 then
			messagebox("App population error" + string(li_found),"Check to see that the selected application exists and is active.")
			IF IsValid(w_dm_image_cp) THEN Close(w_dm_image_cp)  //Added by (APPEON) Harry 11.24.2017 (V161 Storage of Documents as PDFs)
			return -1
		end if
		ls_app_nm = dwchild.GetItemString( li_found, "app_hdr_application_name" )
		li_nd_row_cnt = tab_1.tabpage_net_dev.dw_net_dev1.RowCount()
	

		ls_image_path = gnv_data.of_getitem("ids","imaging_path",false)
		gs_app_image_path = gnv_data.of_getitem("ids","intelliapp_app_path",false)
		//---------------------------- APPEON END ----------------------------
	
		of_set_app_id( ii_app_id  )
		GarbageCollect ( )
		
	
		IF of_load_app( ) = -1 THEN
			of_clean_up(li_image_storage_type)
			Return 1
		END IF
		
		IF li_nd_row_cnt > 0 THEN //maha 111401
			if ib_create_actions then  //Start Code Change ----06.25.2014 #V14.2 maha
				of_action_item_create( ii_prac_id, ii_facility_id, ii_app_id, il_loc_id )  //Start Code Change ----04.15.2014 #V14.2 maha - added loc id param
			end if
		END IF
		
		li_from_page = tab_1.tabpage_pl.dw_print.GetItemNumber( i, "from_page" )
		li_to_page = 99   //dw_print.GetItemNumber( i, "to_page" )
		
		of_setup( ii_app_id, li_from_page  , li_to_page, ii_facility_id )
		
		//-------Begin Added by Alfee 06.29.2010 ---------------------
		//IF tab_1.tabpage_gen.cbx_edit.Checked THEN //Edit before printing 
		IF tab_1.tabpage_gen.cbx_edit.Checked AND ai_print_or_email <> 'S' THEN //(V15.1 View Apps) - alfee 05.19.2015
			ls_app_image_name = ole_edit.Object.Image()			
			ls_prac_nm	= st_name.Text
			ls_facility_nm = gnv_data.of_getitem( "facility", "facility_name", "facility_id = " + String(ii_facility_id))	
			ls_parm = ls_app_image_name + "||" + ls_prac_nm + "||" + ls_facility_nm +  "||" + ls_app_nm 
			ls_parm+= "||" + string(ii_prac_id) + "|| || ||" + String(ii_facility_id) + "||"   //Start Code Change ----03.08.2017 #V153 maha - added addtl parms for provider retrieval
			OpenwithParm(w_preview_app, ls_parm)
			ole_edit.Object.Refresh()		
		END IF
		//--------End Added -------------------------------------------------
		
//		//Start Code Change ----08.12.2010 #V10 maha = moved burn-in to here from of_setup()	
//		for f = 1 to ole_edit.Object.PageCount()
//			IF gi_burn_annos = 1 THEN
//				ole_edit.Object.Page( f )
//				ole_edit.Object.Display()				
//				//------------------- APPEON BEGIN -------------------
//				//$<modify> Stephen 02.17.2012
//				//$<reason> Bug Bug 2918 : pdf file preview is poor quality and prints the same way
//				/*	ole_edit.Object.BurnInAnnotations( 1, 0 )*/
//				try
//					//ole_edit.Object.BurnInAnnotations( 1, 0 )
//					ole_edit.Object.BurnInAnnotations( 1, 2 )//long.zhang 06.10.2013
//				Catch(Throwable th1) 
//					ole_edit.Object.BurnInAnnotations( 1, 2 )
//				end try
//				//------------------- APPEON END -------------------				
//				ole_edit.Object.save()
//			END IF
//		next
//		//End Code Change ----08.12.2010 #V10 maha
		
		ll_next_id++		
		tab_1.tabpage_pl.dw_print.SetItem( i, "print_id", ll_next_id )
		tab_1.tabpage_pl.dw_print.SetItem( i, "from_page", 1 )
		tab_1.tabpage_pl.dw_print.SetItem( i, "to_page", 99 )
		

		ll_action_type=long(gnv_data.of_getitem("code_lookup" , "lookup_code","upper(lookup_name)='ACTION TYPE' and upper(code)='APP OUT TO MD'"))
		ll_action_status=long(gnv_data.of_getitem("code_lookup" , "lookup_code","upper(lookup_name)='ACTION STATUS' and upper(code)='COMPLETE'"))
		ll_Incomplete=long(gnv_data.of_getitem("code_lookup" , "lookup_code","upper(lookup_name)='ACTION STATUS' and upper(code)='INCOMPLETE'")) //evan 03.29.2010
		//---------------------------- APPEON END ----------------------------
		
		//------------------- APPEON BEGIN -------------------
		//<$>added:long.zhang 12.26.2014
		//<$>reason:Bug 4379 created for Case# 00051492: Audit Trail Issue
		
//		UPDATE net_dev_action_items  
//		SET action_status = :ll_action_status,		
//		    action_date = :ldt_today,
//			 mod_date = :ldt_today, //add Michael 06.28.2011 V11.3 Action Item Dates
//			 mod_user = :gs_user_id,//add Michael 06.28.2011 V11.3 Action Item Dates
//			notes = case when notes is null then 'Application Printed' else notes end   //Start Code Change ----06.22.2011 #V11 maha - modified to not overwrite existing notes
//		WHERE ( net_dev_action_items.prac_id = :ii_prac_id ) AND  
//				( net_dev_action_items.facility_id = :ii_facility_id ) AND
//				( net_dev_action_items.action_type = :ll_action_type ) and 
//				( net_dev_action_items.app_id = :ii_app_id) and //maha 010603
//				( net_dev_action_items.active_status = 1) and	//maha 010603
//				( net_dev_action_items.action_status = :ll_Incomplete) and //evan 03.29.2010
//				(net_dev_action_items.rec_id = :ii_rec_id) ;  //(Appeon)Stephen 09.15.2014 - V14.2 Testing Bug # 4220 - Manually changing Loc ID before printing causes the application's action items to split
//				//( net_dev_action_items.gp_id = :il_loc_id) and	//Start Code Change ----04.14.2014 #V14.2 maha//Commented by (Appeon)Stephen 09.15.2014
//				
//				
//		IF SQLCA.SQLCODE = -1 THEN

		ls_sql_old = ids_net_dev_action_items.GetSqlSelect()
		ls_sql_new = ls_sql_old + ' WHERE ( net_dev_action_items.prac_id = '+ string(ii_prac_id) + ' ) AND ' + &
				'( net_dev_action_items.facility_id = '+ string(ii_facility_id) + ' ) AND ' + &
				'( net_dev_action_items.action_type = '+ string(ll_action_type) + ' ) and  ' + &
				'( net_dev_action_items.app_id = ' + string(ii_app_id) + ') and ' + &
				'( net_dev_action_items.active_status = 1) and	 ' + &
				'( net_dev_action_items.action_status = ' + string(ll_Incomplete) + ') and ' + &
				'(net_dev_action_items.rec_id = ' + string(ii_rec_id) + ') '	
		
		//------------------- APPEON BEGIN -------------------
		//<$>added:long.zhang 04.21.2015
		//<$>reason:Use 'Modify' for ASA database	 (issue:Batch Add process completing action status.)
		//rtn = ids_net_dev_action_items.SetSqlSelect(ls_sql_new)		
		ls_rtn = ids_net_dev_action_items.modify('datawindow.table.select = "' +  ls_sql_new  + '"')
		If ls_rtn = '' Then
			rtn = ids_net_dev_action_items.Retrieve()
			//rtn = ids_net_dev_action_items.SetSqlSelect(ls_sql_old)	
			ids_net_dev_action_items.modify('datawindow.table.select = "' +  ls_sql_old  + '"')
		Else
			MessageBox("Modify Error", ls_rtn )
			of_clean_up(li_image_storage_type)
			Return 1			
		End If
		//------------------- APPEON END -------------------
		
		For ll_row_update = 1 to rtn
			ids_net_dev_action_items.SetItem( ll_row_update, "action_status", ll_action_status)
			ids_net_dev_action_items.SetItem( ll_row_update, "action_date", ldt_today)
			ids_net_dev_action_items.SetItem( ll_row_update, "mod_date", ldt_today)
			ids_net_dev_action_items.SetItem( ll_row_update, "mod_user", gs_user_id)
			If IsNull(ids_net_dev_action_items.GetItemString( ll_row_update ,'notes') ) Then
				ids_net_dev_action_items.SetItem( ll_row_update, "notes", 'Application Printed')
			End if
		Next
		
		inv_data_entry.of_field_audit( ids_net_dev_action_items,ls_errtext )
		
		rtn = ids_net_dev_action_items.update()
		IF rtn <> 1 THEN
			MessageBox("Database Error", SQLCA.SQLERRTEXT )
			of_clean_up(li_image_storage_type)		
			Return 1
		ELSE  //Start Code Change ----08.25.2010 #V10 maha - complete the process step
			if ib_create_actions then  //Start Code Change ----06.25.2014 #V14.2 maha
				li_step = integer(gnv_data.of_getitem("app_steps","find step",string(ll_action_type))) //finds this step number
				of_app_tracking_update(ii_prac_id,ii_facility_id, ii_app_id, li_step, ldt_today, il_loc_id) //Start Code Change ----04.14.2014 #V14.2 maha - added loc id
			end if
		END IF

		//Start Code Change ----08.10.2009 #V92 maha - modified filtering
		//--------------------------- APPEON BEGIN ---------------------------
		//$< Add  > 2007-08-04 By: Scofield
		//$<Reason> Restore Print multi-practitioner at a time
		//tab_1.tabpage_sd.dw_sd.SetFilter()
		//tab_1.tabpage_sd.dw_sd.Filter()
		//li_prac_image_cnt = tab_1.tabpage_sd.dw_sd.Find( "pd_images_prac_id = " + String( ii_prac_id ) , 1, tab_1.tabpage_sd.dw_sd.RowCount())
		//---------------------------- APPEON END ----------------------------
		tab_1.tabpage_sd.dw_sd.SetFilter("pd_images_prac_id = " + String( ii_prac_id ))
		tab_1.tabpage_sd.dw_sd.Filter()

		li_prac_image_cnt = tab_1.tabpage_sd.dw_sd.rowcount()
		//End Code Change---08.10.2009
		
		
		ls_app_image_name = ole_edit.Object.Image()	
		
	//image printing functionality
		If is_image_print_set = 'N' then li_image_count = 0 
		
		//IF li_prac_image_cnt > 0 AND li_image_count > 0 THEN //evan 01.19.2012
		IF li_prac_image_cnt > 0 AND is_image_print_set <> 'N' THEN //evan 01.19.2012 - default image not need to judge li_image_count
			//Start Code Change ----08.10.2009 #V92 maha - trap for print no images
			If is_image_print_set = 'N' then 
				//print no images
				//li_image_type_list[] will have no values
				
			elseif is_image_print_set = 'S' then 
				//set up list of images to print
				//if is_image_print_set = 'S' then //selected
				//li_image_typ_list[] will have the values of the selected apps
				ldw_defaults = tab_1.tabpage_sd.dw_image_list
			else //D
				//li_image_typ_list[] will have the reretrieved default values
				//check to see if there are image types connected to the app and set the default dw
				tab_1.tabpage_sd.dw_app_images.setfilter("app_id = " + string(ii_app_id))
				tab_1.tabpage_sd.dw_app_images.filter()
				ll_app_test = tab_1.tabpage_sd.dw_app_images.rowcount()
				
				if ll_app_test > 0 then
					ldw_defaults = tab_1.tabpage_sd.dw_app_images
					li_image_count = ll_app_test
				else
					ldw_defaults = tab_1.tabpage_sd.dw_image_list
					li_image_count = tab_1.tabpage_sd.dw_image_list.rowcount()
				end if
			end if
			//End Code Change---08.10.2009
				
			li_image_storage_type = of_get_app_setting("image_storage_type","I")
				
				//if supporting docs stored in
			IF li_image_storage_type = 1 THEN
				inv_image_functions = CREATE pfc_cst_nv_image_functions
			ELSE
				li_image_storage_type = 0	
			END IF
						
			IF NOT FileExists( ls_image_path + String( ii_prac_id ) + ".tif"  ) AND li_image_storage_type = 0 THEN
				MessageBox( "Missing File", "There is no " + ls_image_path +  String( ii_prac_id ) + ".tif. " +&
					"The supporting documents for practitioner (" + String( ii_prac_id ) + ") can not be printed." )
			Else
				IF li_image_storage_type <> 1 THEN
					tab_1.tabpage_sd.ole_sd.Object.Image( ls_image_path + String( ii_prac_id ) + ".tif" )
					tab_1.tabpage_sd.ole_sd.Object.Page( 1 )
					tab_1.tabpage_sd.ole_sd.Object.FitTo(3)
					// mskinner  23 March 2006 - begin
					TRY 
						tab_1.tabpage_sd.ole_sd.Object.Display()
					CATCH (RunTimeError RTE)
						//Start Code Change ---- 06.05.2006 #517 maha //clarified message
						MESSAGEBOX("Image Attachment Error ", "The image " + ls_image_path + String( ii_prac_id ) + ".tif" + " could not be displayed prior to attaching to the application.  Check to see if the practitioners images can be viewed." )
					
					ib_skip_code = true
					END TRY
					if ib_skip_code then 
						of_clean_up(li_image_storage_type)
						return 1
					end if
					li_image_cnt = tab_1.tabpage_sd.ole_sd.Object.pagecount()
				END IF
					
				ole_admin.object.Image( ls_app_image_name )
				
				lb_exist_pdf = false  //Added by (APPEON) Harry 11.15.2017 (V161 Storage of Documents as PDFs)
	//@@@@@@@@@@@@@@@@@			
				FOR z = 1 TO li_image_count
					li_image_type_id = ldw_defaults.GetItemNumber( z, "image_type_id" ) //Start Code Change ----08.10.2009 #V92 maha
					//li_image_type_id = tab_1.tabpage_sd.dw_image_list.GetItemNumber( z, "image_type_id" )
					// orig line changed 022703 maha to filter out history records tab_1.tabpage_sd.dw_sd.SetFilter( "pd_images_image_type_id = " + String( li_image_type_id ) )						
					tab_1.tabpage_sd.dw_sd.SetFilter( "pd_images_image_type_id = " + String( li_image_type_id ) + " and active_status = 1 and pd_images_prac_id = " + String( ii_prac_id ) )
					tab_1.tabpage_sd.dw_sd.Filter( )
					li_image_type_count = tab_1.tabpage_sd.dw_sd.RowCount( )
					
					FOR m = 1 TO li_image_type_count
						//Start Code Change ----04.29.2011 #V11 maha - facility specific images
						ll_image_facil = tab_1.tabpage_sd.dw_sd.GetItemNumber( m, "pd_images_facility_id" )
						if ll_image_facil <> ii_facility_id and ll_image_facil <> 0 then continue  
						//End Code Change ----04.29.2011
						
						is_ext = Upper(tab_1.tabpage_sd.dw_sd.GetItemString( m, "image_ext" ))	 //Added by (APPEON) Harry 11.15.2017 (V161 Storage of Documents as PDFs)
						
						IF li_image_storage_type = 1 THEN  //if stored in db then..
							ll_rec_id = tab_1.tabpage_sd.dw_sd.GetItemNumber( m, "pd_images_rec_id" )
							//ii_prac_id = tab_1.tabpage_sd.dw_sd.GetItemNumber( m, "pd_images_prac_id" )	
							//ii_facility_id = tab_1.tabpage_sd.dw_sd.GetItemNumber( m, "pd_images_facility_id" )	
							li_screen_id = tab_1.tabpage_sd.dw_sd.GetItemNumber( m, "pd_images_screen_id" )		
							li_seq_no = tab_1.tabpage_sd.dw_sd.GetItemNumber( m, /*"images_pk"*/"pd_images_image_pk" )  //Start Code Change ----03.29.2011 #V11 maha - changed from seq no // Modify by Stephen 05.03.2011 --- Fixed a bug
							inv_image_functions.of_retrieve_image_from_db( ll_rec_id, ii_prac_id, ii_facility_id, li_screen_id, li_seq_no )
							//Start Code Change ---- 06.18.2007 #V7 maha		rewrote so that multiple images stored in database will be appended
							fc++

                               //ls_appnd_files[fc] = gs_dir_path + "\intellicred\Images\" +  String(ll_rec_id) + "_" + String(ii_prac_id) + "_"  + String(ii_facility_id) + "_" + String(li_screen_id) + "_" + String(li_seq_no) + ".tif" 
							//ls_appnd_files[fc] = gs_temp_path + "\Images\"  + String(ii_prac_id) + "_" + String(li_seq_no) + ".tif" // Bug id 2365 -  Stephen 05.03.2011
							ls_appnd_files[fc] = gs_temp_path + "\Images\"  + String(ii_prac_id) + "_" + String(li_seq_no) + "." + is_ext //Modified by (APPEON) Harry 11.15.2017 (V161 Storage of Documents as PDFs)
							
							//Start Code Change ---- 09.17.2007 #V7 maha trap added for missing file
							if not fileexists(ls_appnd_files[fc] ) then
								messagebox("Image Retrieval Error","Unable to retrieve image file id number" + ls_appnd_files[fc] + " From the database to attach to the application. "  )
								continue
							else
								//--------------------------- APPEON BEGIN ---------------------------
								//$<add> 07/09/2007 By: Ken.Guo
								//$<reason> When Image Admin Merge(Append) file, The first image file must be in TIF format, Otherwise PB will runerror.
								If ole_admin.object.pagecount() > 0 and ole_admin.object.FileType <> 1 Then
									Messagebox('Image','The first image file must be in "TIF" format.')
									Continue			
								//---------------------------- APPEON END ----------------------------
								else
									
									IF lb_exist_pdf = False AND is_ext = 'PDF' THEN //Added by (APPEON) Harry 11.15.2017 (V161 Storage of Documents as PDFs)
										lb_exist_pdf = True
										ls_app_image_name = Mid( ole_admin.object.Image , 1, LastPos( ole_admin.object.Image , '.')) + 'pdf'
										w_dm_image_cp.of_Image2PDF (ole_admin.object.Image ,ls_app_image_name)
									END IF
									IF lb_exist_pdf THEN  //Added by (APPEON) Harry 11.15.2017 (V161 Storage of Documents as PDFs)
										IF is_ext <> 'PDF' THEN
											ls_filename_temp = Mid( ls_appnd_files[fc] , 1, LastPos( ls_appnd_files[fc] , '.')) + 'pdf'
											w_dm_image_cp.of_Image2PDF (ls_appnd_files[fc] ,ls_filename_temp)
											ls_appnd_files[fc] = ls_filename_temp 
											is_ext = 'PDF'
										END IF
									ELSE
										tab_1.tabpage_sd.ole_sd.Object.Image( ls_appnd_files[fc] )
										li_pagecount = tab_1.tabpage_sd.ole_sd.Object.pagecount()
									END IF
									//--------------------------- APPEON BEGIN ---------------------------
									//$< Add  > 2008-07-15 By: Scofield
									//$<Reason> Verify if the directory has write right for the current user.										
									ls_Rtn = f_ExaWriteRight(ls_appnd_files[fc])
									if LenA(ls_Rtn) > 0 then
										MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
										Continue
									end if
									//---------------------------- APPEON END ----------------------------
									IF lb_exist_pdf THEN //Added by (APPEON) Harry 11.15.2017 (V161 Storage of Documents as PDFs)
										w_dm_image_cp.of_PDFEditMerge(ls_app_image_name, ls_appnd_files[fc])  
									ELSE
										ole_admin.object.Append( ls_appnd_files[fc] , 1 , li_pagecount  )
									END IF
								end if
							end if
							//End Code Change---09.17.2007	
						ELSE				
							li_start_page = tab_1.tabpage_sd.dw_sd.GetItemNumber( m, "start_page" ) 
							li_num_pages = tab_1.tabpage_sd.dw_sd.GetItemNumber( m, "num_pages" )
							if isnull(li_start_page) or isnull(li_num_pages) then //trap added maha 020105
								MessageBox( "Image Data mismatch", "The image data is missing either the start page or the number of pages for a selected document. " +&
								" Not all of the selected supporting documents for practitioner (" + String( ii_prac_id ) + ") can be printed." )
							elseif li_start_page + li_num_pages - 1 > li_image_cnt then //trap added maha 021904
								MessageBox( "File/Data mismatch", "The image data does not match the  " + ls_image_path +  String( ii_prac_id ) + ".tif file. " +&
								"All the supporting documents for practitioner (" + String( ii_prac_id ) + ") can not be printed." )
							else
								IF lb_exist_pdf = False AND is_ext = 'PDF' THEN //Added by (APPEON) Harry 11.15.2017 (V161 Storage of Documents as PDFs)
									lb_exist_pdf = True
									ls_app_image_name = Mid( ole_admin.object.Image , 1, LastPos( ole_admin.object.Image , '.')) + 'pdf'
									w_dm_image_cp.of_Image2PDF (ole_admin.object.Image ,ls_app_image_name)
								END IF
								//--------------------------- APPEON BEGIN ---------------------------
								//$<add> 07/09/2007 By: Ken.Guo
								//$<reason> When Image Admin Merge(Append) file, The first image file must be in TIF format, Otherwise PB will runerror.
								If ole_admin.object.pagecount() > 0 and ole_admin.object.FileType <> 1 Then
									Messagebox('Image','The first image file must be in "TIF" format.')
									IF IsValid(w_dm_image_cp) THEN Close(w_dm_image_cp)  //Added by (APPEON) Harry 11.24.2017 (V161 Storage of Documents as PDFs)
									Return -1			
								End If
								//---------------------------- APPEON END ----------------------------
								ls_Rtn = f_ExaWriteRight(ls_image_path)
								if LenA(ls_Rtn) > 0 then
									MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
									IF IsValid(w_dm_image_cp) THEN Close(w_dm_image_cp)  //Added by (APPEON) Harry 11.24.2017 (V161 Storage of Documents as PDFs)
									Return -1
								end if	
								IF lb_exist_pdf THEN  //Added by (APPEON) Harry 11.15.2017 (V161 Storage of Documents as PDFs)
									IF NOT FileExists(ls_filename_temp)  THEN
										ls_filename_temp = ls_image_path + String( ii_prac_id ) + ".pdf"
										w_dm_image_cp.of_Image2PDF ( ls_image_path + String( ii_prac_id ) + ".tif" ,ls_filename_temp)
										is_ext = 'PDF'
									END IF
									w_dm_image_cp.of_insert_page_pdf(ls_app_image_name,  ls_image_path + String( ii_prac_id ) + ".pdf", 0, li_start_page , li_num_pages )
								ELSE
									ole_admin.object.Append( ls_image_path + String( ii_prac_id ) + ".tif", li_start_page , li_num_pages  )		
								END IF
							end if
						END IF
					END FOR
				END FOR
			END IF
		END IF
		
//SEND - PRINT file
		
		//Burn annotations and save
		// if set to lock for edit set burn
		if tab_1.tabpage_gen.rb_save_locked.checked then
			gi_burn_annos	= 1
			//of_burn_annotations()
			IF NOT lb_exist_pdf THEN of_burn_annotations()   //Added by (APPEON) Harry 11.15.2017 (V161 Storage of Documents as PDFs)
			lb_burned = true
		end if
		
		//save file if set to save image save before processing 
		if ll_StAppImgInDB = 1 then of_SaveImage()
		
		// if email or fax and not set to lock then burn annos	
		IF ai_print_or_email = "E" OR  ai_print_or_email = "F" and lb_burned = false Then   
			//of_burn_annotations()
			IF NOT lb_exist_pdf THEN of_burn_annotations()   //Added by (APPEON) Harry 11.15.2017 (V161 Storage of Documents as PDFs)
		END IF
		//End Code Change ----05.19.2016

		IF lb_exist_pdf THEN  //Added by (APPEON) Harry 11.23.2017 (V161 Storage of Documents as PDFs)
			of_set_visible_pdf(TRUE)
			ole_edit_pdf.ole_edit.object.LoadMultiPage(ls_app_image_name, 1)
		END IF
	
		IF ai_print_or_email = "F" THEN
			String ls_recipient
			String ls_company
			
			ls_recipient = tab_1.tabpage_pl.dw_print.GetItemString( i, "prac_name" )
			ls_attachments[1] = ls_app_image_name
			ls_company = ""

			IF nv_fax.of_fax( ls_recipient, ls_company,  ls_fax[i], ls_subject, ls_cover_message, ls_attachments, ls_cover_page , ls_errtext)	= -1 THEN	
				IF IsValid(w_dm_image_cp) THEN Close(w_dm_image_cp)  //Added by (APPEON) Harry 11.24.2017 (V161 Storage of Documents as PDFs)
				Return -1
			END IF

//			if ll_StAppImgInDB = 1 then of_SaveImage()	//Added by Scofield on 2008-09-23 //Start Code Change ----08.04.2016 #V152 maha v- saved above
			
		ELSEIF ai_print_or_email = "E" THEN
			IF li_email_choice = 1 then
				ll_find = lds_pd_address.find("pd_address_link_prac_id = " + string(ii_prac_id) + " and pd_address_link_facility_id = " + string(ii_facility_id),1,ll_rowcount2)
				if ll_find > 0 then
					ls_email_address = lds_pd_address.getitemstring(ll_find,'pd_address_e_mail_address')
				else
					MessageBox( "Database Error", "NO find email address. ")
					of_clean_up(li_image_storage_type)				
					Return 1
				end if
				n_cst_outlook lnv_Outlook
				if lnv_Outlook.of_Logon() = -1 then
					MessageBox("Mail", "Logon failed.  Check to make sure you have an email id setup in the user painter.")
					of_clean_up(li_image_storage_type)
					Return 1
				end if
				ls_attach = ls_app_image_name
				//---------Begin Modified by (Appeon)Stephen 02.24.2014 for Bug 3951 When emailing an application, the body of the email is empty--------
				//ll_Return = lnv_Outlook.of_Send(ls_email_address, ls_emailcc, "", ls_subject, ls_notetext, ls_attach) //modify by stephen 05.08.2013 -V12.3 Modification estimate
				ls_attachments = ls_null
				ls_attachments[1] = ls_attach
				nv_emailfax = Create pfc_cst_nv_fax	
				ll_Return = nv_emailfax.of_email_new( "" , "" , ls_email_address , ls_subject, lg_pass_ids.s_fax_message, ls_attachments, lg_pass_ids.s_fax_cover, lg_pass_ids.email_id,ii_prac_id, lg_pass_ids.b_attach , lg_pass_ids.s_stringval) 
				//---------End Modified ------------------------------------------------------
									
				lnv_Outlook.of_Logoff()
				if ll_Return <> 1 then
					MessageBox("Mail Send", "Mail not sent.")
					destroy nv_emailfax
					IF IsValid(w_dm_image_cp) THEN Close(w_dm_image_cp)  //Added by (APPEON) Harry 11.24.2017 (V161 Storage of Documents as PDFs)
					Return 1
				end if
				destroy nv_emailfax
				//---------- APPEON END ------------
			ELSE
				n_cst_easymail_smtp lnv_mail
				// Get email address and attachment
				if LenA(ls_app_image_name) > 0 then ls_Attach = ls_app_image_name
				ll_Find = lds_pd_address.Find("pd_address_link_prac_id = " + string(ii_prac_id) + " and pd_address_link_facility_id = " + string(ii_facility_id),1,ll_rowcount2)
				if ll_Find > 0 then
					ls_email_address = lds_pd_address.GetItemString(ll_Find,'pd_address_e_mail_address')
				else
					MessageBox( "Database Error", "NO find email address. ")
					of_clean_up(li_image_storage_type)				
					Return 1
				end if
				
				// Create Email object
				if lnv_mail.of_CreateObject() = -1 then
					f_show_message('create Email object','','','','')
					of_clean_up(li_image_storage_type)
					Return 1
				end if
				
				//---------Begin Modified by (Appeon)Stephen 02.24.2014 for Bug 3951 When emailing an application, the body of the email is empty--------
				//ll_Return = lnv_mail.of_SendText(gs_user_id, ls_email_address, ls_emailcc, "", ls_Subject, ls_NoteText, ls_Attach)  //modify by stephen 05.08.2013 -V12.3 Modification estimate
				//if ll_Return <> 0 then
				ls_attachments = ls_null
				ls_attachments[1] = ls_attach
				nv_emailfax = Create pfc_cst_nv_fax	
				ll_Return = nv_emailfax.of_email_new( "" , "" , ls_email_address , ls_subject, lg_pass_ids.s_fax_message, ls_attachments, lg_pass_ids.s_fax_cover, lg_pass_ids.email_id,ii_prac_id, lg_pass_ids.b_attach , lg_pass_ids.s_stringval) 
				if ll_Return <> 1 then
				//---------End Modified ------------------------------------------------------	
					f_show_message('error_code_'+string(ll_Return),'%1S%',String(ll_Return),'','')
					lnv_mail.of_DeleteObject()
					of_clean_up(li_image_storage_type)
					destroy nv_emailfax
					Return 1
				end if
				lnv_mail.of_DeleteObject()
				destroy nv_emailfax
				//---------------------------- APPEON END ----------------------------
//				if ll_StAppImgInDB = 1 then of_SaveImage()	//Added by Scofield on 2008-09-23 //Start Code Change ----08.04.2016 #V152 maha v- saved above
			END IF
			//End Code Change---10.06.2008
		ELSEIF ai_print_or_email = "S" THEN //(V15.1 View Apps) - alfee 05.19.2015
			//if ll_StAppImgInDB = 1 then of_SaveImage()	//Added by Scofield on 2008-09-23 //Start Code Change ----08.04.2016 #V152 maha v- saved above				
		ELSE
			//of_print( 1, 99, 1, li_print_exceptions )
			of_print( 1, 99, li_copies, li_print_exceptions ) //Start Code Change ----02.23.2012 #V12 maha
			//if ll_StAppImgInDB = 1 then of_SaveImage()	//Added by Scofield on 2008-09-23 //Start Code Change ----08.04.2016 #V152 maha v- saved above
		END IF
	end if //selected
END FOR //app print list

IF IsValid(w_dm_image_cp) THEN Close(w_dm_image_cp)  //Added by (APPEON) Harry 11.15.2017 (V161 Storage of Documents as PDFs)

tab_1.tabpage_pl.dw_print.of_SetUpdateAble( True )
tab_1.tabpage_pl.dw_print.Update()
tab_1.tabpage_pl.dw_print.of_SetUpdateAble( False )//Added by Appeon long.zhang 07.25.2017 (Pikeville-Application Pop App error Bug_id#5727 Case#72096)

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-13
//$<add> 02.08.2006 By: Liang QingShi
//$<reason> Performance tuning
//$<modification> Destroy the datastores to release the memory.
destroy lds_facility
destroy lds_pd_address
destroy lds_pd_affil_stat
destroy lds_net_dev_action_items
//---------------------------- APPEON END ----------------------------

of_clean_up(li_image_storage_type)

of_ImagingWarning()			//Added by Scofield on 2007-09-21

//------------------- APPEON BEGIN -------------------
//$<add> Evan 01.12.2012
//$<reason> Page count display incorrect.
try
	st_page_num.Text = "Page 0"
	
	//Modified by (APPEON) Harry 11.23.2017 (V161 Storage of Documents as PDFs)
//	if ole_edit.Object.PageCount() > 0 then
//		st_page_num.Text = "Page 1 of " + String(ole_edit.Object.PageCount())
//	end if
	IF lb_exist_pdf THEN  
		li_pagecount =  ole_edit_pdf.ole_edit.Object.GetTotalPage() 
	ELSE
		li_pagecount =  ole_edit.Object.PageCount() 
	END IF
	if li_pagecount > 0 then
		st_page_num.Text = "Page 1 of " + String(li_pagecount)
	end if
catch (runtimeerror e)
end try
//------------------- APPEON END ---------------------

//------------------- APPEON BEGIN -------------------
//$<delete> Stephen 05.31.2012
//$<add> Michael 02.23.2012
//$<reason> Bug2925 generates multiple action items
/*if isvalid(w_prac_data_1) and ii_update_flag = 1 then
	w_prac_data_1.tab_1.tabpage_net.uo_net.of_refresh_data()
end if	*/
//------------------- APPEON END ---------------------

Return 1




end function

public function integer of_copy_ai_values (integer ai_row);// Code Create ---- 06.18.2007 #V7 maha to copy values from previous row during add

u_dw ldw_ai

ldw_ai = tab_1.tabpage_net_dev.dw_net_dev1
if ldw_ai.rowcount() > 1 then
	ldw_ai.setitem(ai_row,"action_user",ldw_ai.getitemstring(ai_row - 1,"action_user")  )
	ldw_ai.setitem(ai_row,"action_status",ldw_ai.getitemnumber(ai_row - 1,"action_status")  )
	ldw_ai.setitem(ai_row,"action_dept",ldw_ai.getitemnumber(ai_row - 1,"action_dept")  )
	ldw_ai.setitem(ai_row,"action_date",ldw_ai.getitemdatetime(ai_row - 1,"action_date")  )
	//---------Begin Modified by (Appeon)Stephen 11.11.2016 for V15.2 Bug # 5405 - Printing Applications -> Application Status adding another action type pops up Column type does not match--------
	//ldw_ai.setitem(ai_row,"app_type",ldw_ai.getitemdatetime(ai_row - 1,"app_type")  )  //Start Code Change ----09.16.2016 #V152 maha - added
	ldw_ai.setitem(ai_row,"app_type",ldw_ai.getitemstring(ai_row - 1,"app_type")  )  
	//---------End Modfiied ------------------------------------------------------
	//------------------- APPEON BEGIN -------------------
	//$<add> Michael 06.23.2011
	//$<reason> V11.3 Action Item Dates
	ldw_ai.setitem(ai_row,"net_dev_action_items_create_date",ldw_ai.getitemdatetime(ai_row - 1,"net_dev_action_items_create_date"))
	ldw_ai.setitem(ai_row,"net_dev_action_items_create_user",ldw_ai.getitemstring(ai_row - 1,"net_dev_action_items_create_user") )
	//------------------- APPEON END ---------------------
end if

return 1
	
end function

public subroutine of_saveimage ();//------------------------------------------------------------------------------
// Function: of_SaveImage()
//------------------------------------------------------------------------------
// Description: Save Image to Database
// Arguments:
//		None
// Return Value: 
//		None
//------------------------------------------------------------------------------
// Author:	Scofield		Date: 2008-07-09
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

String		ls_ImagePath
long			ll_Cnts,ll_FileNo,ll_ReadCnts
Blob			lblb_ImageData,lblb_Buffer
DateTime		ldt_SaveTime
n_cst_dm_utils lnv_utils
long ll_ImgType = 5

ldt_SaveTime = f_get_server_dtm()

//SELECT Count(*) INTO :ll_Cnts FROM net_dev_action_images WHERE rec_id = :ii_rec_id AND prac_id = :ii_prac_id AND app_id = :ii_app_id ;
SELECT Count(*) INTO :ll_Cnts FROM net_dev_action_images WHERE rec_id = :ii_rec_id ;  //Start Code Change ----08.11.2011 #V11 maha  - only look at  recid

if ll_Cnts <= 0 then
	INSERT INTO net_dev_action_images(rec_id,prac_id,app_id,image_type,save_date)
		  VALUES (:ii_rec_id,:ii_prac_id,:ii_app_id,:ll_ImgType,:ldt_SaveTime) ;
else
	UPDATE net_dev_action_images
	   SET save_date = :ldt_SaveTime
	 WHERE rec_id = :ii_rec_id AND prac_id = :ii_prac_id AND app_id = :ii_app_id ;
end if

if gi_citrix = 1 then
	ls_ImagePath = of_letter_paths("L")
else
	ls_ImagePath = gs_temp_path
end if

ls_ImagePath += String(ii_app_id) + "-" + String(ii_prac_id) + ".tif"

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 07.27.2015
//<$>reason:Bug id 4628 - Printed Application is Blurry
if lnv_utils.of_ReadBlob(ls_ImagePath, lblb_ImageData) = -1 then 
	Return
End If
//messagebox("Prompt", "The file is saved successfully and the path is: '"+ ls_ImagePath + "'") //(Appeon)Stephen 12.16.2015 - BugS121001  //Start Code Change ----08.04.2016 #V152 maha
//ll_FileNo = FileOpen(ls_ImagePath,StreamMode!,Read!)
//if ll_FileNo <= 0 then Return
//
//ll_ReadCnts = FileRead(ll_FileNo,lblb_Buffer)
//do while ll_ReadCnts > 0
//	lblb_ImageData += lblb_Buffer
//	ll_ReadCnts = FileRead(ll_FileNo,lblb_Buffer)
//loop
//
//FileClose(ll_FileNo)
//------------------- APPEON END -------------------

UPDATEBLOB net_dev_action_images
       SET image_data = :lblb_ImageData
		WHERE rec_id = :ii_rec_id ; 
     //WHERE rec_id = :ii_rec_id AND prac_id = :ii_prac_id AND app_id = :ii_app_id ;   //Start Code Change ----08.11.2011 #V11 maha  - only look at  recid

COMMIT USING SQLCA ;

end subroutine

public subroutine of_set_default_image_types ();//====================================================================
// Event: pfc_cst_u_print_app.of_set_default_image_types()
//--------------------------------------------------------------------
// Description:set default image types
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	Andy		Date: Jul 14,2008
//--------------------------------------------------------------------
//	
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

//$<add> 07.14.2008 by Andy
Long   ll_app_id[],ll_Row
Long   ll_Cnt,ll_Cnt2
Long   ll_Find,ll_image_type
Int i = 0

//tab_1.tabpage_pl.dw_print.RowCount() = 1 and 
if tab_1.tabpage_sd.rb_app_default.checked then
	ll_Cnt    = tab_1.tabpage_pl.dw_print.RowCount()
	FOR ll_Row = 1 to ll_Cnt
		
		//------------------- APPEON BEGIN -------------------
		//<$>added:long.zhang 11.26.2014
		//<$>reason:Bug 4321 created for Case# 00051090: Issue printing Malpractice Enrollment Forms 
		//ll_app_id[ll_Row] = tab_1.tabpage_pl.dw_print.GetItemNumber(ll_Row,"app_id")
		If tab_1.tabpage_pl.dw_print.GetItemNumber( ll_Row, "selected" ) = 1 Then
			i++
			ll_app_id[i] = tab_1.tabpage_pl.dw_print.GetItemNumber(ll_Row,"app_id")
		End if
		//------------------- APPEON END -------------------

	NEXT
	
	tab_1.tabpage_sd.dw_image_defaults.Reset()
	tab_1.tabpage_sd.dw_image_list.Reset()
	
	gnv_appeondb.of_startqueue( )
	//Start Code Change ----12.04.2012 #V12 maha - added user argument and function call
	tab_1.tabpage_sd.dw_image_list.Retrieve(gs_user_id)
	//End Code Change ----12.04.2012
	tab_1.tabpage_sd.dw_image_defaults.Retrieve(ll_app_id)
	gnv_appeondb.of_commitqueue( )
	
	of_security_filter( )
	
	ll_Cnt = tab_1.tabpage_sd.dw_image_defaults.RowCount()
	ll_Cnt2= tab_1.tabpage_sd.dw_image_list.RowCount()
	
	//Start Code Change ----08.10.2009 #V92 maha - clear the image type defaults if there are app defaults
	if ll_cnt > 0 then
		For ll_Row = 1 to ll_Cnt2
			tab_1.tabpage_sd.dw_image_list.SetItem(ll_row,"selected",0)
		next
	end if
	//End Code Change---08.10.2009
	
	For ll_Row = 1 to ll_Cnt
		ll_image_type = tab_1.tabpage_sd.dw_image_defaults.GetItemNumber(ll_Row,"image_type")
		ll_Find = tab_1.tabpage_sd.dw_image_list.Find("image_type_id=" + String(ll_image_type),1,ll_Cnt2)
		if ll_Find > 0 then 
			tab_1.tabpage_sd.dw_image_list.SetItem(ll_Find,"selected",1)
		end if
	Next
	if ll_Cnt > 0 then 
		tab_1.tabpage_sd.dw_image_list.modify("DataWindow.ReadOnly=yes")
		tab_1.tabpage_sd.cb_15.enabled = false
	else
		tab_1.tabpage_sd.dw_image_list.modify("DataWindow.ReadOnly=no")
		tab_1.tabpage_sd.cb_15.enabled = true
	end if
end if

end subroutine

public function integer of_security_filter ();
//Start Code Change ----12.04.2012 #V12 maha

if of_get_app_setting("set_69","I") = 1 then
	tab_1.tabpage_sd.dw_image_list.setfilter("view_rights = 1")
	tab_1.tabpage_sd.dw_image_list.filter()
end if

return 1

end function

public function integer of_action_item_create (long al_prac, integer al_facility, long al_app, long al_loc_id);//Created 06.18.07 maha to correct the creation of action items
//will be called for each practitioner application printed
//Start Code Change ----04.15.2014 #V14.2 maha - added al_loc_id argument

integer i
integer ic
long ll_new
long ll_prac[]
long ll_track
datetime ld_due_date
string ls_find
integer r
u_dw ldw_ai
u_dw ldw_copy

ldw_ai = tab_1.tabpage_net_dev.dw_net_dev1
ldw_copy = tab_1.tabpage_net_dev.dw_ai_copy

ll_prac[1] = al_prac
ldw_copy.retrieve(ll_prac[])

//for each action item in the list create one for the provider
ic = ldw_ai.rowcount( )

if ic = 0 then return 1

for i = 1 to ic
	//debugbreak()
	if isnull(ldw_ai.getitemnumber(i,"action_type")) then
		continue
	else
		//see if action type exists
		
		//------------------- APPEON BEGIN -------------------
		//<$>added:long.zhang 10.21.2014
		//<$>reason:add gp_id to ls_find -BugS093001 of V14.2 Issues of New Features by ISG(0924-1011)
		
		//ls_find = "facility_id = " + string(al_facility)   + " and app_id = " + string(al_app)  + " and action_type = " + string(ldw_ai.getitemnumber(i,"action_type"))
		ls_find = "facility_id = " + string(al_facility)   + " and app_id = " + string(al_app)  + " and action_type = " + string(ldw_ai.getitemnumber(i,"action_type")) &
					+ " and gp_id = " + string(al_loc_id)
		//------------------- APPEON END -------------------
		
		r = ldw_copy.find(ls_find,1,ldw_copy.rowcount() )	
		
		//copy unfound  items to the copy dw and modify for the provider
		if r = 0 then
			ldw_ai.rowscopy( i, i,primary!, ldw_copy , 10000, primary!)
			r = ldw_copy.rowcount()
			//---------Begin Added by (Appeon)Stephen 10.12.2016 for V15.2 Bug# 5363 - Printing an application does not create the next app tracking step--------
			select track_id into :ll_track from net_dev_action_items where rec_id = :ii_rec_id;
			ldw_copy.setitem(r, "net_dev_action_items_track_id", ll_track ) 
			//---------End Added ------------------------------------------------------

			ldw_copy.setitem(r, "prac_id", al_prac ) 
			ldw_copy.setitem(r, "facility_id", al_facility ) 
			ldw_copy.setitem(r, "app_id", al_app ) 
			ldw_copy.setitem(r, "rec_id", gnv_app.of_Get_Id("RECORD_ID", 1)  ) 
			ldw_copy.setitem(r, "gp_id", al_loc_id )  //Start Code Change ----04.15.2014 #V14.2 maha - added loc_id
			ld_due_date = ldw_ai.getitemdatetime(i,"action_date")
			if  not isnull(ld_due_date) then
				//set the appropriate due date if the action date is set
				ld_due_date = datetime(RelativeDate( date(ld_due_date), ii_due_days[i]  ),time("00:00:00"))
				ldw_copy.setitem(r, "due_date", ld_due_date ) 
			end if
		
			//------------------- APPEON BEGIN -------------------
			//<$>added:long.zhang 12.02.2014
             	//<$>reason:for Bug 4322 created for Case# 00050982: Item #26 Application tracking actions are Out of Order 

//			//Start Code Change ----04.15.2014 #V14.2 maha - clear the action date
//			setnull(ld_due_date)
//			ldw_copy.setitem(r, "action_date", ld_due_date )
//			//End Code Change ----04.15.2014
			
			ld_due_date = ldw_ai.getitemdatetime(i,"action_date")
			If  Not isnull(ld_due_date) Then
				ld_due_date = datetime (date(ld_due_date) ,now())
				ldw_copy.setitem(r, "action_date", ld_due_date )
			End If
              //------------------- APPEON END -------------------


			//------------------- APPEON BEGIN -------------------
			//$<add> Michael 06.23.2011
			//$<reason> V11.3 Action Item Dates
			ldw_copy.setitem(r, "net_dev_action_items_create_date",datetime(today(),now()) ) 
			ldw_copy.setitem(r,"net_dev_action_items_create_user",gs_user_id ) 
			//------------------- APPEON END ---------------------
		end if
	end if
	
next

inv_data_entry.of_field_audit( ldw_copy ) //Added by Appeon long.zhang 12.26.2014(Bug 4379 created for Case# 00051492: Audit Trail Issue)

ldw_copy.update()
ii_update_flag = 1 //add Michael 02.23.2012 Bug2925 generates multiple action items































return 1
end function

public function integer of_app_print_action (u_dw adw_net_dev);//====================================================================
//$<Function>: of_app_print_action
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 2013-08-28 (V141 Print Apps From Action Items)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
integer li_select, li_nr
long     ll_action_type_stan, ll_action_status_stan
long     ll_action_type, ll_action_status
long     ll_app_id, ll_map_type
long     ll_row

gnv_appeondb.of_startqueue()
select lookup_code into :ll_action_type_stan from code_lookup where lookup_name = 'Action Type' and code = 'App Out To MD';
select lookup_code into :ll_action_status_stan from code_lookup where lookup_name = 'Action Status' and code = 'Incomplete';
gnv_appeondb.of_commitqueue()	

for ll_row = 1 to adw_net_dev.rowcount()
	li_select = adw_net_dev.getitemnumber(ll_row, "selected")
	if li_select = 1 then
		ll_app_id = adw_net_dev.getitemnumber(ll_row, "app_id")
		ll_action_type = adw_net_dev.getitemnumber(ll_row, "action_type")
		ll_action_status = adw_net_dev.getitemnumber(ll_row, "action_status")
		
		select mapping_type into :ll_map_type from app_hdr where app_id = :ll_app_id using sqlca;	
		if ll_map_type = 1 and ll_action_type = ll_action_type_stan and  ll_action_status = ll_action_status_stan then
			li_nr = tab_1.tabpage_pl.dw_print.InsertRow( 0 )
			tab_1.tabpage_pl.dw_print.SetItem( li_nr, "prac_name",  adw_net_dev.getitemstring(ll_row, "v_full_name_full_name"))
			tab_1.tabpage_pl.dw_print.SetItem( li_nr, "prac_id", adw_net_dev.getitemnumber(ll_row, "prac_id") )
			tab_1.tabpage_pl.dw_print.SetItem( li_nr, "facility_id", adw_net_dev.getitemnumber(ll_row, "facility_id") )
			tab_1.tabpage_pl.dw_print.SetItem( li_nr, "app_id", adw_net_dev.getitemnumber(ll_row, "app_id"))
			tab_1.tabpage_pl.dw_print.SetItem( li_nr, "rec_id",  adw_net_dev.getitemnumber(ll_row, "rec_id") )		
			
			//------------------- APPEON BEGIN -------------------
			//<$>added:long.zhang 10.21.2014
			//<$>reason:add gp_id
			If adw_net_dev.Describe("gp_id.coltype") <> '!' Then 
				tab_1.tabpage_pl.dw_print.SetItem( li_nr, "loc_id_passed",  adw_net_dev.getitemnumber(ll_row, "gp_id") )
			End If
			//------------------- APPEON END -------------------
			
		end if
	end if
next

return 1
end function

public function integer of_set_rbbutton (string as_flag);//====================================================================
//$<Function>: of_set_rbbutton()
//$<Arguments>:
// 	value    string    as_flag
//$<Return>:  integer
//$<Description>: Set the visibility of radio buttons in Populate & Print
//$<Author>: (Appeon) Alfee 05.19.2015 (V15.1 View Apps)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

CHOOSE CASE Upper(as_flag)
	CASE 'P'
		tab_1.tabpage_gen.rb_print.Checked = TRUE
		tab_1.tabpage_gen.rb_email.Checked = FALSE
		tab_1.tabpage_gen.rb_fax.Checked	= FALSE
		tab_1.tabpage_gen.rb_save.Checked = FALSE
	CASE 'E'		
		tab_1.tabpage_gen.rb_print.Checked = FALSE
		tab_1.tabpage_gen.rb_email.Checked = TRUE
		tab_1.tabpage_gen.rb_fax.Checked	= FALSE
		tab_1.tabpage_gen.rb_save.Checked = FALSE
	CASE 'F'
		tab_1.tabpage_gen.rb_print.Checked = FALSE
		tab_1.tabpage_gen.rb_email.Checked = FALSE
		tab_1.tabpage_gen.rb_fax.Checked	= TRUE
		tab_1.tabpage_gen.rb_save.Checked = FALSE
	CASE 'S'
		tab_1.tabpage_gen.rb_print.Checked = FALSE
		tab_1.tabpage_gen.rb_email.Checked = FALSE
		tab_1.tabpage_gen.rb_fax.Checked	= FALSE
		tab_1.tabpage_gen.rb_save.Checked = TRUE
END CHOOSE


RETURN 1
end function

public function integer of_burn_annotations ();//Start Code Change ----08.04.2016 #V152 maha = moved burn-in to here from of_email_fax	
integer f
string s

s  = ole_edit.Object.Image()
//messagebox("of_burn_annos", s)	//Comment by Appeon long.zhang 12.13.2016
for f = 1 to ole_edit.Object.PageCount()
	IF gi_burn_annos = 1 THEN
		ole_edit.Object.Page( f )
		ole_edit.Object.Display()				
		try
			ole_edit.Object.BurnInAnnotations( 1, 2 )
		Catch(Throwable th1) 
			ole_edit.Object.BurnInAnnotations( 1, 2 )
		end try
		
		ole_edit.Object.save()
	END IF
next

return 1
end function

on pfc_cst_u_print_app.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.dw_process_options=create dw_process_options
this.dw_populated=create dw_populated
this.cb_temp=create cb_temp
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.dw_process_options
this.Control[iCurrent+3]=this.dw_populated
this.Control[iCurrent+4]=this.cb_temp
end on

on pfc_cst_u_print_app.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.dw_process_options)
destroy(this.dw_populated)
destroy(this.cb_temp)
end on

event constructor;call super::constructor;//select set_13 into :ii_batch_button from icred_settings;
string ls_this   //maha 08.05.2010
string ls_next //maha 08.05.2010
date ld_due_date //maha 08.05.2010
integer li_days //maha 08.05.2010

////if ii_batch_button = 1 then
	tab_1.tabpage_pl.cb_batch_search.Visible = true
//end if

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-14
//$<add> 02.08.2006 By: Liang QingShi
//$<reason> Performance tuning 
//$<modification> 1)Move it from tab_1.tabpage_sd.dw_image_list.constructor() and 
//$<modification> tab_1.tabpage_net_dev.dw_net_dev1.constructor() due to the usage
//$<modification> of CreateOnDemanc.
//$<modification> 2)Add the Appeon Queue labels to reduce client-server interactions. 

long ll_action_type,ll_action_status,ll_action_dept
DataWindowChild dwchild
tab_1.tabpage_pl.dw_print.settransobject(sqlca)

tab_1.tabpage_sd.dw_image_list.of_SetUpdateAble( False )
tab_1.tabpage_sd.dw_image_list.SetTransObject( SQLCA )

tab_1.tabpage_net_dev.dw_net_dev1.of_SetRowManager( TRUE )
tab_1.tabpage_net_dev.dw_net_dev1.of_SetReqColumn(TRUE)
tab_1.tabpage_net_dev.dw_net_dev1.of_SetTransObject(SQLCA)

tab_1.tabpage_net_dev.dw_net_dev1.Reset()
tab_1.tabpage_net_dev.dw_net_dev1.InsertRow( 0 )
tab_1.tabpage_net_dev.dw_net_dev1.SetFocus( )

tab_1.tabpage_net_dev.dw_net_dev1.of_SetUpdateable( False )
tab_1.tabpage_net_dev.dw_net_dev1.of_SetDropDownCalendar( TRUE )
tab_1.tabpage_net_dev.dw_net_dev1.iuo_calendar.of_Register(tab_1.tabpage_net_dev.dw_net_dev1.iuo_calendar.DDLB)

gnv_appeondb.of_startqueue( )

//Start Code Change ----12.04.2012 #V12 maha - added user argument and function call
tab_1.tabpage_sd.dw_image_list.Retrieve(gs_user_id)
of_security_filter( )
//End Code Change ----12.04.2012

tab_1.tabpage_net_dev.dw_net_dev1.GetChild( "action_type", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Action Type")

tab_1.tabpage_net_dev.dw_net_dev1.GetChild( "action_dept", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Action Department")

tab_1.tabpage_net_dev.dw_net_dev1.GetChild( "action_status", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Action Status")

tab_1.tabpage_net_dev.dw_net_dev1.GetChild( "action_user", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve( )

tab_1.tabpage_pl.dw_print.GetChild( "facility_id", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve( )
tab_1.tabpage_pl.dw_print.GetChild( "app_id", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.SetFilter("mapping_type = 1") //Added evan 10.31.2011 - V12.1 Website Population
dwchild.Retrieve( )

//Start Code Change ----08.05.2010 #V10 maha - modify to creat the next process step
select lookup_code into :ll_action_type from code_lookup where lookup_name = 'Action Type' and code = 'App Out to MD';

gnv_appeondb.of_commitqueue( ) //add Michael 02.02.2012 Bug 2900 Application tracking steps are not populating correctly

ls_this = gnv_data.of_getitem("app_steps","find step",string(ll_action_type)) //finds this step number

gnv_appeondb.of_startqueue( )//add Michael 02.02.2012 Bug 2900 Application tracking steps are not populating correctly

if long(ls_this) <> 0 then //Start Code Change ----05.13.2011 #V11 maha - changed from integer; <> from > 0
	ls_next = gnv_data.of_getitem("app_steps","next step",ls_this) //gets the next step action type
	if long(ls_next) <> 0 then //Start Code Change ----05.13.2011 #V11 maha - changed from integer; <> from > 0
		li_days = integer(gnv_data.of_getitem("app_steps","next days", "lookup_code = " + ls_next)) //gets the due days  //Start Code Change ----04.26.2011 #V11 maha - corrected for failied filter
		if li_days = 0 then li_days = 30
		ll_action_type = long(ls_next)
	else
		select lookup_code into :ll_action_type from code_lookup where lookup_name = 'Action Type' and code = 'App Rcvd Prac';	
	end if
else
	select lookup_code into :ll_action_type from code_lookup where lookup_name = 'Action Type' and code = 'App Rcvd Prac';
end if

//select lookup_code into :ll_action_type from code_lookup where lookup_name = 'Action Type' and code = 'App Rcvd Prac';
select lookup_code into :ll_action_status from code_lookup where lookup_name = 'Action Status' and code = 'Incomplete';
select lookup_code into :ll_action_dept from code_lookup where lookup_name = 'Action Department' and code = 'Credentialing';

gnv_appeondb.of_commitqueue( )

if ll_action_type = 0 then 
	messagebox("Warning", "There is no Action Type with the code of App Rcvd Prac in the Action Type lookup table. This will cause the next Action to be entered to have an action type of 0")
end if

ld_due_date = RelativeDate( Today(), li_days )
tab_1.tabpage_net_dev.dw_net_dev1.SetItem( 1, "action_status" , ll_action_status )
tab_1.tabpage_net_dev.dw_net_dev1.SetItem( 1, "action_type" , ll_action_type )

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 11.26.2014
//<$>reason:action_date was wrong is web version
//tab_1.tabpage_net_dev.dw_net_dev1.SetItem( 1, "action_date" , Today() )
//tab_1.tabpage_net_dev.dw_net_dev1.SetItem( 1, "action_date" , datetime(today(),now() ) )  //Start Code Change ----12.01.2014 #V14.2 maha - action date should not be set
//------------------- APPEON END -------------------

tab_1.tabpage_net_dev.dw_net_dev1.SetItem( 1, "action_user" , gs_user_id )
tab_1.tabpage_net_dev.dw_net_dev1.SetItem( 1, "action_dept" , ll_action_dept )
tab_1.tabpage_net_dev.dw_net_dev1.SetItem( 1, "due_date" , ld_due_date )
//------------------- APPEON BEGIN -------------------
//$<add> Michael 06.23.2011
//$<reason> V11.3 Action Item Dates
tab_1.tabpage_net_dev.dw_net_dev1.SetItem( 1, "net_dev_action_items_create_date",datetime(today(),now() ))
tab_1.tabpage_net_dev.dw_net_dev1.SetItem( 1,"net_dev_action_items_create_user",gs_user_id )
//------------------- APPEON END ---------------------
//---------------------------- APPEON END ----------------------------
if gi_print_dialog = 1 then tab_1.tabpage_gen.cbx_exceptions.checked = false  //Start Code Change ----10.03.2011 #V12 maha - modify to use print dialog setting

inv_data_entry = CREATE pfc_cst_nv_data_entry_functions //Added by Appeon long.zhang 12.26.2014(Bug 4379 created for Case# 00051492: Audit Trail Issue)

ids_net_dev_action_items = Create n_cst_datastore//Added by Appeon long.zhang 12.26.2014(Bug 4379 created for Case# 00051492: Audit Trail Issue)
ids_net_dev_action_items.DataObject = "d_appeon_net_dev_action_items_save"
ids_net_dev_action_items.SetTransObject( sqlca)

if of_get_app_setting("set_84","I") = 1 then tab_1.tabpage_gen.cbx_edit.checked = true  //Start Code Change ----10.08.2015 #V15 maha

//Start Code Change ----08.05.2016 #V152 maha - setting defaults
choose case of_get_app_setting("set_87","I")
	case 1 //print
		tab_1.tabpage_gen.rb_print.checked = true
	case 3 //fax
		tab_1.tabpage_gen.rb_fax.checked = true
	case 4 //save only
		tab_1.tabpage_gen.rb_save.checked = true
	case else
		tab_1.tabpage_gen.rb_email.checked = true
end choose

if of_get_app_setting("set_88","I") = 1 then 
	tab_1.tabpage_gen.rb_allow_edit.checked = false
	tab_1.tabpage_gen.rb_save_locked.checked = true
else
	tab_1.tabpage_gen.rb_allow_edit.checked = true
	tab_1.tabpage_gen.rb_save_locked.checked = false
end if
//End Code Change ----08.05.2016
	
	
	
end event

type ole_edit_pdf from pfc_cst_u_create_app2`ole_edit_pdf within pfc_cst_u_print_app
integer x = 27
integer y = 128
integer width = 3941
integer height = 1532
end type

type cb_repopulate from pfc_cst_u_create_app2`cb_repopulate within pfc_cst_u_print_app
integer x = 3515
integer y = 1880
integer taborder = 60
string facename = "Segoe UI"
end type

type dw_exceptions from pfc_cst_u_create_app2`dw_exceptions within pfc_cst_u_print_app
integer x = 119
integer y = 1336
end type

type ole_admin from pfc_cst_u_create_app2`ole_admin within pfc_cst_u_print_app
end type

type st_rec from pfc_cst_u_create_app2`st_rec within pfc_cst_u_print_app
integer x = 1883
integer y = 1960
end type

type st_page_num from pfc_cst_u_create_app2`st_page_num within pfc_cst_u_print_app
integer x = 2981
integer y = 1852
integer weight = 400
long backcolor = 33551856
end type

type st_name from pfc_cst_u_create_app2`st_name within pfc_cst_u_print_app
integer x = 9
integer y = 2004
integer width = 1170
long textcolor = 128
long backcolor = 33551856
alignment alignment = center!
end type

type cb_next from pfc_cst_u_create_app2`cb_next within pfc_cst_u_print_app
integer x = 2821
integer y = 1840
integer taborder = 90
integer weight = 400
string facename = "Segoe UI"
boolean enabled = false
end type

type cb_prior from pfc_cst_u_create_app2`cb_prior within pfc_cst_u_print_app
integer x = 2693
integer y = 1840
string facename = "Segoe UI"
end type

type cb_2 from pfc_cst_u_create_app2`cb_2 within pfc_cst_u_print_app
integer x = 1317
integer y = 1960
integer width = 617
integer weight = 700
string text = "Populate && Print"
end type

event cb_2::clicked;//Long ll_rec_id 
//Long ll_next_id
//Long ll_prac_id
//Long	ll_action_type
//Long	ll_action_status
//DateTime	ldt_action_dt
//DateTime	ldt_next_action_dt
//String ls_action_notes
//String	ls_action_user
//Long	ll_action_dept
//String ls_name
//Integer li_nd_row_cnt
//Integer a
//Integer li_rc
//Integer i
//Integer li_app_id
//Integer li_from_page
//Integer li_to_page
//Integer li_print_exceptions
//
//of_connections( "IntelliCred", "0" )
//
//PrintSetup()
//
//tab_1.tabpage_pl.dw_print.AcceptText()
//
//li_rc = tab_1.tabpage_pl.dw_print.RowCount()
//
//IF cbx_exceptions.Checked THEN
//	li_print_exceptions = 1
//ELSE
//	li_print_exceptions = 0
//END IF
//
//DataWindowChild dwchild
//Integer li_found
//sTRING LS_APP_NM
//
//FOR i = 1 TO li_rc
//	st_name.Text = tab_1.tabpage_pl.dw_print.GetItemString( i, "prac_name" )
//	ii_prac_id = tab_1.tabpage_pl.dw_print.GetItemNumber( i, "prac_id" )
//	ii_app_id  = tab_1.tabpage_pl.dw_print.GetItemNumber( i, "app_id" ) 
//	ii_facility_id  = tab_1.tabpage_pl.dw_print.GetItemNumber( i, "facility_id" ) 
//	tab_1.tabpage_pl.dw_print.GetChild( "app_id", dwchild )
//	li_found = dwchild.Find( "app_hdr_app_id = " + String( ii_app_id ),1, dwchild.RowCount() )
//	ls_app_nm = dwchild.GetItemString( li_found, "app_hdr_application_name" )
//	li_nd_row_cnt = tab_1.tabpage_net_dev.dw_net_dev1.RowCount()
//	FOR a = 1 TO li_nd_row_cnt
//		ll_action_type = tab_1.tabpage_net_dev.dw_net_dev1.GetItemNumber( a, "action_type" )
//		ll_action_status = tab_1.tabpage_net_dev.dw_net_dev1.GetItemNumber( a, "action_status" )
//		ldt_action_dt = tab_1.tabpage_net_dev.dw_net_dev1.GetItemDateTime( a, "action_date" )
//		ldt_next_action_dt = tab_1.tabpage_net_dev.dw_net_dev1.GetItemDateTime( a, "next_action_date" )
//		ls_action_user = tab_1.tabpage_net_dev.dw_net_dev1.GetItemString( a, "action_user" )
//		ls_action_notes = tab_1.tabpage_net_dev.dw_net_dev1.GetItemString( a, "notes" ) 
//		IF Not IsNull( ls_action_notes ) THEN
//			ls_action_notes = ls_action_notes + ls_app_nm
//		ELSE
//			ls_action_notes = ls_app_nm
//		END IF
//		ll_action_dept = tab_1.tabpage_net_dev.dw_net_dev1.GetItemNumber( a, "action_dept" )		
//		ll_rec_id = gnv_app.of_Get_Id("RECORD_ID")	
//		INSERT INTO net_dev_action_items  
//     	    ( rec_id,   
//          	 prac_id,   
//	           action_type,   
//     	      action_date,   
//          	 action_dept,   
//	           action_user,   
//     	      next_action_date,   
//	           notes,   
//     	      action_status,   
//	           facility_id )  
//		VALUES ( :ll_rec_id,   
//	           :ii_prac_id,   
//     	      :ll_action_type,   
//          	 :ldt_action_dt,   
//	           :ll_action_dept,   
//     	      :ls_action_user,   
//	           :ldt_next_action_dt,   
//     	      :ls_action_notes,   
//	           :ll_action_status,   
//     	      :ii_facility_id )
//		USING SQLCA;
//		IF SQLCA.SQLCODE = -1 THEN
//			MessageBox("Database Error", SQLCA.SQLERRTEXT )
//			Return -1
//		END IF
//	END FOR
//	of_set_app_id( ii_app_id  )
//	of_load_app( )
//	li_from_page = tab_1.tabpage_pl.dw_print.GetItemNumber( i, "from_page" )
//	li_to_page = 99   //dw_print.GetItemNumber( i, "to_page" )
//	of_setup( ii_app_id, li_from_page  , li_to_page, ii_facility_id )
//	of_print( 1, 99, 1, li_print_exceptions )
//     SELECT ids.print_id  
//     INTO :ll_next_id  
//     FROM ids  ;
//	IF IsNull( ll_next_id ) THEN
//		ll_next_id = 0
//	END IF
//	ll_next_id++
//	UPDATE ids
//	SET print_id = :ll_next_id;
//	tab_1.tabpage_pl.dw_print.SetItem( i, "print_id", ll_next_id )
//	tab_1.tabpage_pl.dw_print.SetItem( i, "from_page", 1 )
//	tab_1.tabpage_pl.dw_print.SetItem( i, "to_page", 99 )
//	//dw_print.SetItem( i, "user_id", gs_user_id )
//	//dw_print.SetItem( i, "print_date", today() ) this field needs to be created
//	UPDATE net_dev_action_items  
//     SET action_status = -111
//     WHERE ( net_dev_action_items.prac_id = :ii_prac_id ) AND  
//         ( net_dev_action_items.facility_id = :ii_facility_id ) AND
//	    ( net_dev_action_items.action_type = -3 );
//	IF SQLCA.SQLCODE = -1 THEN
//		MessageBox("Database Error", SQLCA.SQLERRTEXT )
//		Return -1
//	END IF
//END FOR
//
//tab_1.tabpage_net_dev.dw_net_dev1.Event Constructor()
////tab_1.tabpage_net_dev.dw_net_dev1.Reset()
////tab_1.tabpage_net_dev.dw_net_dev1.InsertRow( 0 )
////tab_1.tabpage_net_dev.dw_net_dev1.SetFocus( )
//
//tab_1.tabpage_pl.dw_print.Update()
////dw_print.Reset()
//COMMIT USING SQLCA;
end event

type cb_1 from pfc_cst_u_create_app2`cb_1 within pfc_cst_u_print_app
integer x = 3639
integer y = 1856
string facename = "Segoe UI"
end type

type st_1 from pfc_cst_u_create_app2`st_1 within pfc_cst_u_print_app
integer x = 1175
integer y = 2004
integer width = 1143
long textcolor = 128
long backcolor = 33551856
alignment alignment = center!
end type

type st_2 from pfc_cst_u_create_app2`st_2 within pfc_cst_u_print_app
integer x = 2313
integer y = 2004
integer width = 1147
long textcolor = 128
long backcolor = 33551856
alignment alignment = center!
end type

type ole_edit from pfc_cst_u_create_app2`ole_edit within pfc_cst_u_print_app
integer x = 27
integer y = 128
integer width = 3941
integer height = 1532
borderstyle borderstyle = stylebox!
end type

type tab_1 from tab within pfc_cst_u_print_app
event create ( )
event destroy ( )
integer width = 4000
integer height = 1960
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean fixedwidth = true
boolean raggedright = true
integer selectedtab = 1
tabpage_pl tabpage_pl
tabpage_sd tabpage_sd
tabpage_net_dev tabpage_net_dev
tabpage_gen tabpage_gen
end type

on tab_1.create
this.tabpage_pl=create tabpage_pl
this.tabpage_sd=create tabpage_sd
this.tabpage_net_dev=create tabpage_net_dev
this.tabpage_gen=create tabpage_gen
this.Control[]={this.tabpage_pl,&
this.tabpage_sd,&
this.tabpage_net_dev,&
this.tabpage_gen}
end on

on tab_1.destroy
destroy(this.tabpage_pl)
destroy(this.tabpage_sd)
destroy(this.tabpage_net_dev)
destroy(this.tabpage_gen)
end on

event selectionchanged;IF newindex = 4 THEN
	ole_edit.Visible = True
	cb_next.Visible = True
	cb_prior.Visible = True
	st_page_num.Visible = True
ELSE
	ole_edit.Visible = False
	cb_next.Visible = False
	cb_prior.Visible = False
	st_page_num.Visible = False
END IF

//$<add> 07.14.2008 by Andy
//Set default image types
if newindex = 2 then of_set_default_image_types()

end event

type tabpage_pl from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 3963
integer height = 1844
long backcolor = 33551856
string text = "Print List"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 553648127
cb_add cb_add
cb_4 cb_4
cb_9 cb_9
cb_10 cb_10
cb_batch_search cb_batch_search
dw_print dw_print
end type

on tabpage_pl.create
this.cb_add=create cb_add
this.cb_4=create cb_4
this.cb_9=create cb_9
this.cb_10=create cb_10
this.cb_batch_search=create cb_batch_search
this.dw_print=create dw_print
this.Control[]={this.cb_add,&
this.cb_4,&
this.cb_9,&
this.cb_10,&
this.cb_batch_search,&
this.dw_print}
end on

on tabpage_pl.destroy
destroy(this.cb_add)
destroy(this.cb_4)
destroy(this.cb_9)
destroy(this.cb_10)
destroy(this.cb_batch_search)
destroy(this.dw_print)
end on

type cb_add from commandbutton within tabpage_pl
integer x = 14
integer y = 1728
integer width = 389
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
end type

event clicked;Integer li_nr
Integer a
Integer li_app_cnt
Integer li_cnt
Integer i
String ls_name
Long ll_prac_id
gs_pass_ids lgs_app_ids
datastore lds_app

gs_search lstr_search

lstr_search.stran_transaction = SQLCA

IF ii_open_from_dash > -1 THEN
	lstr_search.ls_open_for = "INTELLIAPP999"  
ELSE
	lstr_search.ls_open_for = "INTELLIAPP" + String( 1 ) 
END IF

OpenWithParm( w_extended_search_new , lstr_search )

IF Message.DoubleParm = -1 THEN
	Return
END IF
li_cnt = UpperBound( gs_names )

//------------------- APPEON BEGIN -------------------
//$<add> Evan 10.31.2011
//$<reason> V12.1 Website Population
//Start Code Change ----08.11.2017 #V154 maha - Removed as unnecessary
//if li_cnt > 0 then
//	lds_app = Create datastore
//	lds_app.DataObject = "d_app_query_in"
//	lds_app.SetTransObject(SQLCA)
//	lds_app.Retrieve(gi_app_ids[])
//end if
//End Code Change ----08.11.2017
//------------------- APPEON END ---------------------

FOR i = 1 TO li_cnt
//Start Code Change ----08.11.2017 #V154 maha - Removed as unnecessary - bug_id 5755 
//	li_nr = lds_app.Find("mapping_type = 1 and app_id=" + String(gi_app_ids[i]), 1, lds_app.RowCount())
//	//if li_nr < 1 then Continue // evan 10.31.2011 - V12.1 Website Population
//   	if li_nr < 1 or isnull(li_nr) then Continue	//Modified by (Appeon)Freeze 2017-08-10 - bug_id 5755 - Application is not populating for new provider 
//End Code Change ----08.11.2017
	li_nr = dw_print.InsertRow( 0 )
	dw_print.SetItem( li_nr, "prac_name", gs_names[i] )
	dw_print.SetItem( li_nr, "prac_id", gl_prac_ids[i] )
	dw_print.SetItem( li_nr, "facility_id", gl_facility_ids[i] )
	dw_print.SetItem( li_nr, "app_id", gi_app_ids[i] )
	dw_print.SetItem( li_nr, "rec_id", gl_rec_id[i] )//add Michael 11.08.2011 Fixed Bug#2772:Problem with saving printed apps to database 
	dw_print.SetItem( li_nr, "loc_id_passed", 0 ) //default 0, Added by Appeon long.zhang 05.11.2015 (issue: Application Printing)
	if gl_locations > 0 then dw_print.SetItem( li_nr, "loc_id_passed", gl_locations )
END FOR

dw_print.SetRow( li_nr )
dw_print.ScrollToRow( li_nr )

dw_print.SetFocus()
if IsValid(lds_app) then Destroy lds_app
end event

type cb_4 from commandbutton within tabpage_pl
integer x = 823
integer y = 1728
integer width = 389
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;

dw_print.DeleteRow( dw_print.GetRow() )


end event

type cb_9 from commandbutton within tabpage_pl
integer x = 1230
integer y = 1728
integer width = 389
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Clear"
end type

event clicked;dw_print.Reset()
end event

type cb_10 from commandbutton within tabpage_pl
integer x = 3502
integer y = 1736
integer width = 389
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Next-->"
end type

event clicked;Integer i
Integer li_rc

IF dw_print.RowCount() = 0 THEN
	MessageBox( "Select Error", "You must select at least one application for printing." )
	dw_print.SetFocus()	
	Return
END IF

li_rc = dw_print.RowCount()

FOR i = 1 TO li_rc
	IF dw_print.GetItemNumber( i, "app_id" ) < 1 THEN
		MessageBox("Select Error", "You must select an application to print." )
		dw_print.SetRow( i )
		dw_print.ScrollToRow( i )
		dw_print.SetColumn( "app_id" )
		dw_print.SetFocus()
		Return
	END IF
END FOR

tab_1.SelectTab( 2 )
end event

type cb_batch_search from commandbutton within tabpage_pl
integer x = 421
integer y = 1728
integer width = 384
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Batch Select"
end type

event clicked;gs_batch_search lst_search
long i
long ic
long r
long rc
long pracids[]
string names[]
long ll_facil
integer ll_app




openwithparm(w_batch_prac_select_new,"A")


if message.stringparm = "Cancel" then return
//names[] = lst 
lst_search = message.powerobjectparm
pracids[] = lst_search.li_prac_id[]
names[] = lst_search.ls_name[]
ll_facil = lst_search.ll_facility[1]
ll_app = lst_search.ll_app[1]

ic = upperbound(pracids[])

//------------------- APPEON BEGIN -------------------
//$<add> Evan 10.31.2011
//$<reason> V12.1 Website Population
if ic > 0 then
	select count(*) into :r from app_hdr
	where mapping_type = 1 and app_id = :ll_app;
	if r < 1 then
		MessageBox("Mapping Type", "Please select application type of form.")
		Return
	end if
end if
//------------------- APPEON END ---------------------

FOR i = 1 TO ic
	r = dw_print.InsertRow( 0 )
	dw_print.SetItem( r, "prac_name", names[i] )
	dw_print.SetItem( r, "prac_id",pracids[i] )
	dw_print.SetItem( r, "facility_id", ll_facil )
	dw_print.SetItem( r, "app_id", ll_app )
	dw_print.SetItem( r, "selected", 1 )
	dw_print.SetItem( r, "loc_id_passed", 0 ) //default 0, Added by Appeon long.zhang 05.11.2015 (issue: Application Printing)
END FOR

dw_print.SetRow( r )
dw_print.ScrollToRow( r )

dw_print.SetFocus()


end event

event constructor;IF gb_sk_ver = True THEN  //Start Code Change ----11.19.2010 #V10 maha - hide for SK
	this.visible = false
end if
end event

type dw_print from u_dw within tabpage_pl
integer x = 9
integer y = 12
integer width = 3941
integer height = 1692
integer taborder = 10
boolean bringtotop = true
boolean titlebar = true
string title = "Application Print List"
string dataobject = "d_print_apps"
boolean hscrollbar = true
boolean border = false
end type

event constructor;This.of_SetUpdateAble( False )
This.of_SetTransObject( SQLCA )
end event

event itemchanged;call super::itemchanged;IF This.GetColumnName() = "app_id" THEN
	datawindowchild dwchild
	Integer li_pages
	This.GetChild( "app_id", dwchild )
	li_pages = dwchild.GetItemNumber( dwchild.GetRow(), "app_hdr_num_pages" )
	This.SetItem( row, "to_page", li_pages )
END IF
end event

event clicked;call super::clicked;long r

r = this.getclickedrow()

this.setrow(r)
end event

event buttonclicked;call super::buttonclicked;//Start Code Change ----06.10.2014 #V14.2 maha - added
integer li_val
long r
string s

if dwo.name = "b_all" then
	choose case dwo.text
		case 'Deselect All'
			li_val = 0
			s = 'Select All'
		case 'Select All'
			li_val = 1
			s = 'Deselect All'
	end choose
	
	for r = 1 to this.rowcount()
		this.setitem(r,"selected", li_val)
	next
	
	dwo.text = s
	
end if
end event

type tabpage_sd from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3963
integer height = 1844
long backcolor = 33551856
string text = "Supporting Documents"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 553648127
dw_app_images dw_app_images
dw_image_defaults dw_image_defaults
st_5 st_5
st_4 st_4
st_3 st_3
rb_no_print rb_no_print
rb_selected_image rb_selected_image
rb_app_default rb_app_default
dw_image_list dw_image_list
cb_11 cb_11
ole_sd ole_sd
dw_sd dw_sd
cb_15 cb_15
gb_1 gb_1
end type

on tabpage_sd.create
this.dw_app_images=create dw_app_images
this.dw_image_defaults=create dw_image_defaults
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.rb_no_print=create rb_no_print
this.rb_selected_image=create rb_selected_image
this.rb_app_default=create rb_app_default
this.dw_image_list=create dw_image_list
this.cb_11=create cb_11
this.ole_sd=create ole_sd
this.dw_sd=create dw_sd
this.cb_15=create cb_15
this.gb_1=create gb_1
this.Control[]={this.dw_app_images,&
this.dw_image_defaults,&
this.st_5,&
this.st_4,&
this.st_3,&
this.rb_no_print,&
this.rb_selected_image,&
this.rb_app_default,&
this.dw_image_list,&
this.cb_11,&
this.ole_sd,&
this.dw_sd,&
this.cb_15,&
this.gb_1}
end on

on tabpage_sd.destroy
destroy(this.dw_app_images)
destroy(this.dw_image_defaults)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.rb_no_print)
destroy(this.rb_selected_image)
destroy(this.rb_app_default)
destroy(this.dw_image_list)
destroy(this.cb_11)
destroy(this.ole_sd)
destroy(this.dw_sd)
destroy(this.cb_15)
destroy(this.gb_1)
end on

type dw_app_images from datawindow within tabpage_sd
boolean visible = false
integer x = 343
integer y = 380
integer width = 686
integer height = 400
integer taborder = 70
string title = "none"
string dataobject = "d_app_image_print_defaults"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_image_defaults from u_dw within tabpage_sd
boolean visible = false
integer x = 517
integer y = 1568
integer width = 1147
integer height = 164
integer taborder = 11
string dataobject = "d_app_image_defaults"
boolean vscrollbar = false
boolean livescroll = false
end type

type st_5 from statictext within tabpage_sd
integer x = 1559
integer y = 784
integer width = 1499
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Do not attach any provider images to the printed Application(s)."
boolean focusrectangle = false
end type

type st_4 from statictext within tabpage_sd
integer x = 1559
integer y = 576
integer width = 1202
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Use the Image types selected on this screen."
boolean focusrectangle = false
end type

type st_3 from statictext within tabpage_sd
integer x = 1559
integer y = 264
integer width = 1632
integer height = 152
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "If Image defaults are set up for the Application(s), they will be used for printing images; otherwise, the selected Image types on this screen will be used."
boolean focusrectangle = false
end type

type rb_no_print from radiobutton within tabpage_sd
integer x = 1472
integer y = 708
integer width = 517
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Print No Images:"
end type

event clicked;integer i
//$<add> 07.14.2008
tab_1.tabpage_sd.dw_image_list.reset( )
//Start Code Change ----12.04.2012 #V12 maha - added user argument and function call
tab_1.tabpage_sd.dw_image_list.Retrieve(gs_user_id)
of_security_filter( )
//End Code Change ----12.04.2012
//Start Code Change ----08.10.2009 #V92 maha
for i = 1 to tab_1.tabpage_sd.dw_image_list.rowcount()
	tab_1.tabpage_sd.dw_image_list.setitem(i,"selected",0)
next
//End Code Change---08.10.2009
tab_1.tabpage_sd.dw_image_list.modify("DataWindow.ReadOnly=yes")
tab_1.tabpage_sd.cb_15.enabled = false
is_image_print_set = "N" //Start Code Change ----08.10.2009 #V92 maha
end event

type rb_selected_image from radiobutton within tabpage_sd
integer x = 1472
integer y = 496
integer width = 631
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Selected image type:"
end type

event clicked;//$<add> 07.14.2008 by Andy
tab_1.tabpage_sd.dw_image_list.modify("DataWindow.ReadOnly=no")
tab_1.tabpage_sd.cb_15.enabled = true
is_image_print_set = "S" //Start Code Change ----08.10.2009 #V92 maha
end event

type rb_app_default from radiobutton within tabpage_sd
integer x = 1472
integer y = 184
integer width = 795
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Application Default Priority:"
boolean checked = true
end type

event clicked;//$<add> 07.14.2008 by Andy
of_set_default_image_types()
is_image_print_set = "D" //Start Code Change ----08.10.2009 #V92 maha

end event

type dw_image_list from u_dw within tabpage_sd
integer x = 9
integer y = 48
integer width = 1161
integer height = 1648
integer taborder = 90
boolean titlebar = true
string title = "Select Image Type"
string dataobject = "d_image_image_type_list_select"
boolean hscrollbar = true
boolean border = false
end type

event clicked;call super::clicked;IF row > 0 THEN
	This.SetRow( row )
END IF
end event

event constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-15
//$<comment> 02.08.2006 By: Liang QingShi
//$<reason> Performance tuning 
//$<modification> Move the following script to pfc_cst_u_print_app.constructor() due to the
//$<modification> usage of CreateOnDemand.

/*
This.of_SetUpdateAble( False )
This.SetTransObject( SQLCA )
This.Retrieve()
*/

//---------------------------- APPEON END ----------------------------


end event

event retrieveend;call super::retrieveend;IF rowcount > 0 THEN
	This.SelectRow( 1, True )
	This.SetFocus()
	
	Integer i
	Integer li_rc
	
	li_rc = This.RowCount( )
	FOR i = 1 TO li_rc
		IF This.GetItemNumber( i, "link_to_app_id" ) = 1 THEN
			This.SetItem( i, "selected", 1 )
		END IF
	END FOR
END IF
end event

type cb_11 from commandbutton within tabpage_sd
integer x = 3502
integer y = 1736
integer width = 389
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Next-->"
end type

event clicked;
//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 09.22.2014
//<$>reason: V14.2 Testing Bug # 4229 - In Batch add the print now option is not working

//tab_1.SelectTab( 3 )
if not tab_1.tabpage_net_dev.visible then 
	tab_1.SelectTab( 4 ) 
else
	tab_1.SelectTab( 3 )
end if
//------------------- APPEON END -------------------
end event

type ole_sd from olecustomcontrol within tabpage_sd
event keydown ( ref integer keycode,  integer shift )
event keyup ( ref integer keycode,  integer shift )
event keypress ( ref integer keyascii )
event mousedown ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mousemove ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mouseup ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event click ( )
event dblclick ( )
event ocx_error ( integer number,  ref string description,  long scode,  string source,  string helpfile,  long helpcontext,  ref boolean canceldisplay )
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
event hyperlinkgotodoc ( string link,  long page,  ref boolean handled )
event editingtextannotation ( boolean editing )
event magnifierstatus ( integer hwnd,  long status,  long magnifierzoom,  long left,  long top,  long ocx_width,  long ocx_height )
event pasteclip ( ref long mode )
event baddocumentfiletype ( long page,  ref boolean errorout,  ref boolean skippage,  ref boolean overwritepage )
event nextpage ( )
event prevpage ( )
event overlayfilenotfound ( ref string overlayfilename,  ref boolean btryagain )
event imagedraganddrop ( )
event zoomchanged ( real zoom )
event readystatechange ( long readystate )
boolean visible = false
integer x = 1307
integer y = 180
integer width = 1774
integer height = 936
integer taborder = 60
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
string binarykey = "pfc_cst_u_print_app.udo"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
end type

type dw_sd from u_dw within tabpage_sd
boolean visible = false
integer x = 3282
integer width = 370
integer height = 376
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pd_image_list"
end type

event constructor;call super::constructor;This.SetTransObject( SQLCA )
This.of_SetUpdateAble( False )
end event

type cb_15 from commandbutton within tabpage_sd
integer x = 14
integer y = 1728
integer width = 389
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select &All"
end type

event clicked;Integer 	li_rc
Integer 	i
integer	li_Value

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-08-10 By: Scofield
//$<Reason> Add the Deselect function

if This.Text = "Select &All" then
	li_Value = 1
	This.Text = "Deselect &All"
else
	li_Value = 0
	This.Text = "Select &All"
end if

li_rc = dw_image_list.RowCount( )
for I = 1 to li_rc
	dw_image_list.SetItem( i, "selected", li_Value )
next
//---------------------------- APPEON END ----------------------------

end event

type gb_1 from groupbox within tabpage_sd
integer x = 1353
integer y = 72
integer width = 1925
integer height = 936
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Image Printing Options"
end type

type tabpage_net_dev from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 3963
integer height = 1844
long backcolor = 33551856
string text = "Application Status"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 553648127
dw_ai_copy dw_ai_copy
dw_net_dev1 dw_net_dev1
cb_7 cb_7
cb_8 cb_8
cb_12 cb_12
end type

on tabpage_net_dev.create
this.dw_ai_copy=create dw_ai_copy
this.dw_net_dev1=create dw_net_dev1
this.cb_7=create cb_7
this.cb_8=create cb_8
this.cb_12=create cb_12
this.Control[]={this.dw_ai_copy,&
this.dw_net_dev1,&
this.cb_7,&
this.cb_8,&
this.cb_12}
end on

on tabpage_net_dev.destroy
destroy(this.dw_ai_copy)
destroy(this.dw_net_dev1)
destroy(this.cb_7)
destroy(this.cb_8)
destroy(this.cb_12)
end on

type dw_ai_copy from u_dw within tabpage_net_dev
boolean visible = false
integer x = 914
integer y = 1624
integer width = 165
integer height = 100
integer taborder = 11
string dataobject = "d_net_dev_action_items_printing"
boolean resizable = true
end type

event constructor;call super::constructor;this.settransobject(sqlca)
end event

type dw_net_dev1 from u_dw within tabpage_net_dev
integer x = 9
integer y = 48
integer width = 3520
integer height = 1660
integer taborder = 11
boolean bringtotop = true
boolean titlebar = true
string title = "Action Items"
string dataobject = "d_net_dev_action_items_printing"
boolean hscrollbar = true
boolean border = false
end type

event constructor;call super::constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-16
//$<comment> 01.18.2006 By: Liang QingShi
//$<reason> Performance tuning 
//$<modification> Move the following script to pfc_cst_u_print_app.constructor()
//$<modification> due to the usage of CreateOnDemand.

/*
long ll_action_type  //maha 101901
long ll_action_status//maha 101901
long ll_action_dept//maha 101901

This.of_SetUpdateable( False )
This.of_SetDropDownCalendar( TRUE )
This.iuo_calendar.of_Register(this.iuo_calendar.DDLB)

dw_net_dev1.Reset()
//dw_net_dev1.InsertRow( 0 )
dw_net_dev1.InsertRow( 0 )
dw_net_dev1.SetFocus( )

DataWindowChild dwchild

This.of_SetRowManager( TRUE )
This.of_SetReqColumn(TRUE)
This.of_SetTransObject(SQLCA)
//This.ShareData( dw_report )

This.GetChild( "action_type", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Action Type")

This.GetChild( "action_dept", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Action Department")

This.GetChild( "action_status", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Action Status")

This.GetChild( "action_user", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve( )


This.of_SetDropDownCalendar( TRUE )
This.iuo_calendar.of_Register(this.iuo_calendar.DDLB)

//This.SetItem( 1, "action_status" , -111 )
//This.SetItem( 1, "action_type" , -3 )
//This.SetItem( 1, "action_date" , Today() )
//This.SetItem( 1, "action_user" , gs_user_id )
//This.SetItem( 1, "action_dept" , -102 )
//\/maha 101901
select lookup_code into :ll_action_type from code_lookup where lookup_name = 'Action Type' and code = 'App Rcvd Prac';
if ll_action_type = 0 then //maha added 012204 other are trapped elsewhere
	messagebox("Warning", "There is no Action Type with the code of App Rcvd Prac in the Action Type lookup table. This will cause the next Action to be entered to have an action type of 0")
end if
select lookup_code into :ll_action_status from code_lookup where lookup_name = 'Action Status' and code = 'Incomplete';
select lookup_code into :ll_action_dept from code_lookup where lookup_name = 'Action Department' and code = 'Credentialing';

This.SetItem( 1, "action_status" , ll_action_status )
This.SetItem( 1, "action_type" , ll_action_type )
This.SetItem( 1, "action_date" , Today() )
This.SetItem( 1, "action_user" , gs_user_id )
This.SetItem( 1, "action_dept" , ll_action_dept )
*/

//---------------------------- APPEON END ----------------------------

//dw_net_dev1.InsertRow( 0 )

////\/maha 101901
//select lookup_code into :ll_action_type from code_lookup where lookup_name = 'Action Type' and code = 'App Out To MD';
//select lookup_code into :ll_action_status from code_lookup where lookup_name = 'Action Status' and code = 'Complete';
//select lookup_code into :ll_action_dept from code_lookup where lookup_name = 'Action Department' and code = 'Credentialing';
////\maha
//This.SetItem( 2, "action_status" , ll_action_status )
//This.SetItem( 2, "action_type" , ll_action_type )
//This.SetItem( 2, "action_date" , Today() )
//This.SetItem( 2, "action_user" , gs_user_id )
//This.SetItem( 2, "action_dept" , ll_action_dept )
//
// MSKINNER 17 DEC 2005 -- BEGIN
THIS.OBJECT.B_NOTES.Visible = FALSE
THIS.OBJECT.BCONTACT.Visible = FALSE
THIS.OBJECT.NOTES.WIDTH = 987
// MSKINNER 17 DEC 2005 -- END 

end event

event rbuttondown;call super::rbuttondown;//Start Code Change ----4.26.2011 #V11 maha 
integer col
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

event itemchanged;call super::itemchanged;//Set action_date when status is 'Complete', Add by Appeon long.zhang 03.23.2015 (00052226 / Action Dates Won't Populate After Print Apps)

Long ll_complete_action_status

IF Upper(This.GetColumnName( )) = "ACTION_STATUS" THEN
	select lookup_code into :ll_complete_action_status from code_lookup where lookup_name = 'Action Status' and code = 'Complete';
	//IF complete then make the Action Date today() if it is null otherwise make the action
	IF Long( data ) = ll_complete_action_status THEN
		if isnull(this.getitemdatetime(row,"action_date")) then this.setitem(row,"action_date",datetime(today(),now()))
	end if
END IF

end event

type cb_7 from commandbutton within tabpage_net_dev
integer x = 9
integer y = 1732
integer width = 389
integer height = 84
integer taborder = 21
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
end type

event clicked;Integer li_nr

li_nr = tab_1.tabpage_net_dev.dw_net_dev1.InsertRow( 0 )
//Start Code Change ---- 06.18.2007 #V7 maha
of_copy_ai_values(li_nr)
//End Code Change---06.18.2007
tab_1.tabpage_net_dev.dw_net_dev1.SetFocus()
tab_1.tabpage_net_dev.dw_net_dev1.ScrollToRow( li_nr )
tab_1.tabpage_net_dev.dw_net_dev1.SetRow( li_nr )
end event

type cb_8 from commandbutton within tabpage_net_dev
integer x = 430
integer y = 1732
integer width = 389
integer height = 84
integer taborder = 31
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;tab_1.tabpage_net_dev.dw_net_dev1.DeleteRow( 0 )
IF tab_1.tabpage_net_dev.dw_net_dev1.RowCount() > 0 THEN
	tab_1.tabpage_net_dev.dw_net_dev1.SetRow( 1 )
	tab_1.tabpage_net_dev.dw_net_dev1.ScrollToRow( 1 )
	tab_1.tabpage_net_dev.dw_net_dev1.SetFocus()
END IF

end event

type cb_12 from commandbutton within tabpage_net_dev
integer x = 3502
integer y = 1736
integer width = 389
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Next-->"
end type

event clicked;tab_1.SelectTab( 4 )
end event

type tabpage_gen from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 3963
integer height = 1844
long backcolor = 33551856
string text = "Process"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 553648127
cb_3 cb_3
gb_3 gb_3
cb_process cb_process
rb_save rb_save
rb_fax rb_fax
rb_email rb_email
rb_print rb_print
cbx_edit cbx_edit
cbx_use_def_printer cbx_use_def_printer
cb_6 cb_6
cbx_exceptions cbx_exceptions
cb_13 cb_13
cb_14 cb_14
cb_16 cb_16
gb_2 gb_2
rb_allow_edit rb_allow_edit
rb_save_locked rb_save_locked
cb_5 cb_5
st_app st_app
end type

on tabpage_gen.create
this.cb_3=create cb_3
this.gb_3=create gb_3
this.cb_process=create cb_process
this.rb_save=create rb_save
this.rb_fax=create rb_fax
this.rb_email=create rb_email
this.rb_print=create rb_print
this.cbx_edit=create cbx_edit
this.cbx_use_def_printer=create cbx_use_def_printer
this.cb_6=create cb_6
this.cbx_exceptions=create cbx_exceptions
this.cb_13=create cb_13
this.cb_14=create cb_14
this.cb_16=create cb_16
this.gb_2=create gb_2
this.rb_allow_edit=create rb_allow_edit
this.rb_save_locked=create rb_save_locked
this.cb_5=create cb_5
this.st_app=create st_app
this.Control[]={this.cb_3,&
this.gb_3,&
this.cb_process,&
this.rb_save,&
this.rb_fax,&
this.rb_email,&
this.rb_print,&
this.cbx_edit,&
this.cbx_use_def_printer,&
this.cb_6,&
this.cbx_exceptions,&
this.cb_13,&
this.cb_14,&
this.cb_16,&
this.gb_2,&
this.rb_allow_edit,&
this.rb_save_locked,&
this.cb_5,&
this.st_app}
end on

on tabpage_gen.destroy
destroy(this.cb_3)
destroy(this.gb_3)
destroy(this.cb_process)
destroy(this.rb_save)
destroy(this.rb_fax)
destroy(this.rb_email)
destroy(this.rb_print)
destroy(this.cbx_edit)
destroy(this.cbx_use_def_printer)
destroy(this.cb_6)
destroy(this.cbx_exceptions)
destroy(this.cb_13)
destroy(this.cb_14)
destroy(this.cb_16)
destroy(this.gb_2)
destroy(this.rb_allow_edit)
destroy(this.rb_save_locked)
destroy(this.cb_5)
destroy(this.st_app)
end on

event constructor;//Work around for Web Version, Added by Appeon long.zhang 04.18.2017 (BugL041802)
If AppeonGetClientType() = "WEB" then
	If This.Text = 'Populate & Print' Then 
		This.Text = 'Populate && Print'
	End If
End If
end event

type cb_3 from commandbutton within tabpage_gen
integer x = 919
integer y = 1600
integer width = 87
integer height = 80
integer taborder = 21
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "?"
end type

event clicked;//Start Code Change ----05.19.2016 #V152 maha
string s

s = "When using the 'Store Printed Applications in Database' application option, the file can be saved with the annotations locked (burned in) or left as annotations that can be removed.~r~r" 
s+= "Only Applications that are Printed or Saved can be saved as editable.~r~r"
s+= "If Applications will be available to your Providers via WebView, they should be set as  Locked." 


messagebox("Save Options", s)
end event

type gb_3 from groupbox within tabpage_gen
integer y = 1560
integer width = 1065
integer height = 132
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Save Options"
end type

type cb_process from commandbutton within tabpage_gen
integer x = 1906
integer y = 1728
integer width = 384
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Process"
end type

event clicked;//====================================================================
//$<Event>: clicked()
//$<Arguments>:
//$<Return>:  long
//$<Description>: Process the functionalities
//$<Author>: (Appeon) Alfee 05.19.2015 (V15.1 View Apps)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

IF rb_print.checked THEN
	of_print_email_app( "P" )
ELSEIF rb_email.checked THEN
	of_print_email_app( "E" )
ELSEIF rb_fax.checked THEN
	of_print_email_app( "F" )
ELSEIF rb_save.checked THEN
	of_print_email_app ( "S" )
ELSE
	RETURN
END IF

//for the bug3114 - creates duplicate action items when adding next step -  Stephen 05.31.2012
IF isvalid(gw_prac_data) AND ii_update_flag = 1 THEN
	gw_prac_data.tab_1.tabpage_net.uo_net.of_refresh_data()
END IF

messagebox("Application Processing",  "Processing Completed.")  //Start Code Change ----08.29.2016 #V152 maha
end event

type rb_save from radiobutton within tabpage_gen
integer x = 1554
integer y = 1740
integer width = 306
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Save only"
end type

event clicked;//====================================================================
//$<Event>: clicked()
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Alfee 05.19.2015 (V15.1 View Apps)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

//of_set_rbbutton ("S")
end event

type rb_fax from radiobutton within tabpage_gen
integer x = 1275
integer y = 1740
integer width = 251
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Fax"
end type

event clicked;//====================================================================
//$<Event>: clicked()
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Alfee 05.19.2015 (V15.1 View Apps)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

//of_set_rbbutton ("F")
end event

type rb_email from radiobutton within tabpage_gen
integer x = 978
integer y = 1740
integer width = 251
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Email"
boolean checked = true
end type

event clicked;//====================================================================
//$<Event>: clicked()
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Alfee 05.19.2015 (V15.1 View Apps)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

//of_set_rbbutton ("E")
end event

type rb_print from radiobutton within tabpage_gen
integer x = 690
integer y = 1740
integer width = 251
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Print"
end type

event clicked;//====================================================================
//$<Event>: clicked()
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Alfee 05.19.2015 (V15.1 View Apps)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

//of_set_rbbutton ("P")
end event

type cbx_edit from checkbox within tabpage_gen
integer x = 1312
integer y = 1616
integer width = 562
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Edit Before Printing"
end type

type cbx_use_def_printer from checkbox within tabpage_gen
integer x = 2688
integer y = 1616
integer width = 763
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Use Default/Previous Printer"
boolean checked = true
end type

event clicked;




if this.checked then 
	ib_no_dialog = true
else 
	
	ib_no_dialog = false
	
end if 
end event

event constructor;ib_no_dialog = true 
end event

type cb_6 from commandbutton within tabpage_gen
integer y = 1728
integer width = 645
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Generate Correspondence"
end type

event clicked;Integer li_rc

tab_1.tabpage_pl.dw_print.AcceptText()

li_rc = tab_1.tabpage_pl.dw_print.RowCount()

IF li_rc = 0 THEN
	MessageBox("Correspondence", "You have not selected any practitioners to print applicaton for!" )
	Return
END IF

Long ll_prac_id[]
Integer i
Integer li_cnt
Integer li_temp_facility_id

li_rc = tab_1.tabpage_pl.dw_print.RowCount()
FOR i = 1 TO li_rc
	IF tab_1.tabpage_pl.dw_print.GetItemNumber( i, "selected" ) = 1 THEN	
		li_cnt++
	END IF
END FOR
IF li_cnt = 0 THEN
	MessageBox("Selection Error", "Nothing selected to print." )
	Return -1
END IF	
li_cnt = 0
FOR i = 1 TO li_rc
	IF tab_1.tabpage_pl.dw_print.GetItemNumber( i, "selected" ) = 0 THEN	
		Continue
	END IF
	IF li_cnt = 0 THEN
		li_temp_facility_id = tab_1.tabpage_pl.dw_print.GetItemNumber( i, "facility_id" )
	ELSE
		IF tab_1.tabpage_pl.dw_print.GetItemNumber( i, "facility_id" ) <> li_temp_facility_id THEN
			MessageBox("Selection Error", "You can only print letters for groups of practitioners in the same facility." )
			Return -1
		END IF
	END IF
	li_cnt++
	ll_prac_id[ li_cnt ] = tab_1.tabpage_pl.dw_print.GetItemNumber( i, "prac_id" )
END FOR

Open( w_letter_generator )

ii_facility_id = li_temp_facility_id

//w_letter_generator.of_Net_Dev_Ltr( ll_prac_id[], ii_facility_id )

Return 0


end event

type cbx_exceptions from checkbox within tabpage_gen
integer x = 1920
integer y = 1616
integer width = 722
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Include Exceptions Report"
end type

type cb_13 from commandbutton within tabpage_gen
boolean visible = false
integer x = 3488
integer y = 1760
integer width = 402
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Populate && Print"
end type

event clicked;of_print_email_app( "P" )

//------------------- APPEON BEGIN -------------------
//$<add> Stephen 05.31.2012
//$<reason> creates duplicate action items when adding next step -bug3114
//Start Code Change ----03.09.2013 #V12 maha
if isvalid(gw_prac_data) and ii_update_flag = 1 then
	gw_prac_data.tab_1.tabpage_net.uo_net.of_refresh_data()
end if	
//if isvalid(w_prac_data_1) and ii_update_flag = 1 then
//	w_prac_data_1.tab_1.tabpage_net.uo_net.of_refresh_data()
//end if	
//End Code Change ----03.09.2013
//------------------- APPEON END -------------------
end event

type cb_14 from commandbutton within tabpage_gen
boolean visible = false
integer x = 3506
integer y = 1756
integer width = 402
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Populate && Email"
end type

event clicked;of_print_email_app( "E" )

//------------------- APPEON BEGIN -------------------
//$<add> Stephen 05.31.2012
//$<reason> creates duplicate action items when adding next step -bug3114
//Start Code Change ----03.09.2013 #V12 maha
if isvalid(gw_prac_data) and ii_update_flag = 1 then
	gw_prac_data.tab_1.tabpage_net.uo_net.of_refresh_data()
end if	
//if isvalid(w_prac_data_1) and ii_update_flag = 1 then
//	w_prac_data_1.tab_1.tabpage_net.uo_net.of_refresh_data()
//end if	
//End Code Change ----03.09.2013
//------------------- APPEON END -------------------


end event

type cb_16 from commandbutton within tabpage_gen
boolean visible = false
integer x = 3525
integer y = 1756
integer width = 402
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Populate && Fax"
end type

event clicked;of_print_email_app( "F" )

//------------------- APPEON BEGIN -------------------
//$<add> Stephen 05.31.2012
//$<reason> creates duplicate action items when adding next step -bug3114
//Start Code Change ----03.09.2013 #V12 maha
if isvalid(gw_prac_data) and ii_update_flag = 1 then
	gw_prac_data.tab_1.tabpage_net.uo_net.of_refresh_data()
end if	
//if isvalid(w_prac_data_1) and ii_update_flag = 1 then
//	w_prac_data_1.tab_1.tabpage_net.uo_net.of_refresh_data()
//end if	
//End Code Change ----03.09.2013

//------------------- APPEON END -------------------
end event

type gb_2 from groupbox within tabpage_gen
integer x = 654
integer y = 1684
integer width = 1239
integer height = 144
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Process Type"
end type

type rb_allow_edit from radiobutton within tabpage_gen
integer x = 448
integer y = 1616
integer width = 402
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Allow Editing"
end type

type rb_save_locked from radiobutton within tabpage_gen
integer x = 46
integer y = 1616
integer width = 402
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Lock Annos"
boolean checked = true
end type

type cb_5 from commandbutton within tabpage_gen
boolean visible = false
integer x = 5
integer y = 1644
integer width = 635
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Printer &Setup"
end type

event clicked;PrintSetup()
end event

type st_app from statictext within tabpage_gen
integer x = 1563
integer y = 1560
integer width = 1280
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
boolean focusrectangle = false
end type

type dw_process_options from u_dw within pfc_cst_u_print_app
boolean visible = false
integer x = 3634
integer y = 2364
integer width = 142
integer height = 192
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_app_process_options"
end type

event constructor;call super::constructor;this.insertrow(1)
end event

type dw_populated from u_dw within pfc_cst_u_print_app
boolean visible = false
integer x = 3813
integer y = 2428
integer width = 174
integer height = 112
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_print_apps"
end type

type cb_temp from commandbutton within pfc_cst_u_print_app
integer x = 4032
integer y = 2424
integer width = 183
integer height = 92
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "show"
end type

event clicked;integer r 

dw_process_options.visible = true
dw_populated.visible = true


tab_1.tabpage_pl.dw_print.rowscopy( 1, tab_1.tabpage_pl.dw_print.rowcount(), primary!, dw_populated, 1, primary!)

this.visible = false

	
end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
09pfc_cst_u_print_app.bin 
2B00000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe00000004fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff000000010000000000000000000000000000000000000000000000000000000056c32e8001d3674600000003000003400000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000024d00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000036d94028011ce9f116002fd838ac03e8c0000000056c3077001d3674656c32e8001d36746000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000008400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000cfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
29ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe000201066d94028011ce9f116002fd838ac03e8c00000001fb8f0821101b01640008ed8413c72e2b000000300000021d0000000f000001000000008000000101000000880000010200000090000001030000009800000104000000a000000105000000a800000106000000bc00000107000000c400000108000000cc00000109000000d40000010a000000dc0000010b000000e40000010c000000ec0000010d000000f400000000000000fc0000000300020005000000030000281a000000030000182f000000030000006000000002000000010000001e0000000945676d493274696400000000000000032ffffffe0000000b0000ffff000000020000b2f4000000020000b2f4000000030036b344000000030036b3440000000b0000ffff0000000b0000ffff0000000f000000000000000100010a0000000b0065726c0076726573003164650000010c0000000b73657262657672650b0031640b0000016c000000657365726465767201080032000b000072730000726573653164657600010d0000000b00657262007672657300326465000001090000000b7365727365767265030032640c0000015f000000636f74736f72706b040073700c000001620000006564726f797473720500656c0d000001690000006567616d746e6f63006c6f7200000101000000097478655f78746e65000102000000090078655f00746e657401070079001300006f660000666563726c656c69696b6e697831676e0001060000000f00646e75006675626f7372656600657a6900000100000000097265765f6e6f697300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000200050000281a0000182f0000006000010001000000006d490800696445670001327400000100c8000000020000420000ff0000ffff00ff000000ff00000000000000000100000000000000000100000101ff03000000fe000000002fffff00000000ee000100b39400001000b394100000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
19pfc_cst_u_print_app.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
