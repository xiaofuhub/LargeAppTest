$PBExportHeader$pfc_cst_u_verification_info.sru
forward
global type pfc_cst_u_verification_info from userobject
end type
type cb_batch_ver from commandbutton within pfc_cst_u_verification_info
end type
type p_1 from picture within pfc_cst_u_verification_info
end type
type rb_stat_hist from radiobutton within pfc_cst_u_verification_info
end type
type st_recs from statictext within pfc_cst_u_verification_info
end type
type gb_type from groupbox within pfc_cst_u_verification_info
end type
type gb_response_stat from groupbox within pfc_cst_u_verification_info
end type
type rb_ver_stat_both from radiobutton within pfc_cst_u_verification_info
end type
type rb_ver_impcompl from radiobutton within pfc_cst_u_verification_info
end type
type rb_ver_compl from radiobutton within pfc_cst_u_verification_info
end type
type rb_stat_both from radiobutton within pfc_cst_u_verification_info
end type
type rb_stat_active from radiobutton within pfc_cst_u_verification_info
end type
type dw_orgs_facilities from u_dw within pfc_cst_u_verification_info
end type
type dw_select_screen from u_dw within pfc_cst_u_verification_info
end type
type tab_view from tab within pfc_cst_u_verification_info
end type
type tabpage_browse from userobject within tab_view
end type
type tabpage_browse from userobject within tab_view
end type
type tabpage_detail from userobject within tab_view
end type
type tabpage_detail from userobject within tab_view
end type
type tabpage_recred from userobject within tab_view
end type
type cbx_preserve from checkbox within tabpage_recred
end type
type cbx_check_miss from checkbox within tabpage_recred
end type
type cbx_privs from checkbox within tabpage_recred
end type
type cb_crednoverif from commandbutton within tabpage_recred
end type
type cb_init_recred from u_cb within tabpage_recred
end type
type dw_recred_info from u_dw within tabpage_recred
end type
type tabpage_recred from userobject within tab_view
cbx_preserve cbx_preserve
cbx_check_miss cbx_check_miss
cbx_privs cbx_privs
cb_crednoverif cb_crednoverif
cb_init_recred cb_init_recred
dw_recred_info dw_recred_info
end type
type tab_view from tab within pfc_cst_u_verification_info
tabpage_browse tabpage_browse
tabpage_detail tabpage_detail
tabpage_recred tabpage_recred
end type
type dw_detail from u_dw within pfc_cst_u_verification_info
end type
type dw_browse from u_dw within pfc_cst_u_verification_info
end type
end forward

global type pfc_cst_u_verification_info from userobject
integer width = 4306
integer height = 2048
long backcolor = 79741120
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event pfc_cst_print_letters ( )
event pfc_cst_dial_phone ( )
event pfc_cst_goto_web ( )
event pfc_cst_npdb_export ( )
event pfc_cst_clear_print ( )
event pfc_cst_iverify ( )
event pfc_cst_scan_oig ( )
event pfc_cst_screen_capture ( )
event pfc_cst_manual_workflow ( )
cb_batch_ver cb_batch_ver
p_1 p_1
rb_stat_hist rb_stat_hist
st_recs st_recs
gb_type gb_type
gb_response_stat gb_response_stat
rb_ver_stat_both rb_ver_stat_both
rb_ver_impcompl rb_ver_impcompl
rb_ver_compl rb_ver_compl
rb_stat_both rb_stat_both
rb_stat_active rb_stat_active
dw_orgs_facilities dw_orgs_facilities
dw_select_screen dw_select_screen
tab_view tab_view
dw_detail dw_detail
dw_browse dw_browse
end type
global pfc_cst_u_verification_info pfc_cst_u_verification_info

type variables
pfc_n_cst_ai_action_items inv_action_items
pfc_n_cst_ai_printletters inv_printletters //maha 071708

Protected Long il_prac_id
Protected Long il_rec_id

Boolean ib_verify
boolean ib_i_r_filter  //Start Code Change ----09.30.2008 #V85 maha - for ccvs customization

String is_status_filter 
String is_verif_filter 
String is_view_filter
String is_i_r_filter  //Start Code Change ----09.30.2008 #V85 maha - for ccvs customization
string is_combined_filter  //Start Code Change ----08.24.2011 #V11 maha - for combined letter refilter set in of_ver_filter

Integer ii_screen_id
Integer ii_data_view_id
Integer ii_facility_id
integer ii_ver_id
Integer ii_screen_ids[]
Integer ii_facility_ids[]
Long il_exp_appt_ltr
long il_rgb  //Start Code Change ----09.28.2012 #V12 maha

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<add> 01.24.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Define variables to be used in subsequent script.
boolean ib_first_retrieved = true //Define a variable and set it to TRUE. This modification reduces calls together with the condition in PT-08.
boolean ib_object_created = false
boolean ib_select = false,ib_select1 = false
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.02.2006 By: Jervis
//$<reason> 
str_action_item istr_action[]
//---------------------------- APPEON END ----------------------------


//12.5.2006 by Jervis
string is_prior
end variables

forward prototypes
protected function long of_get_prac_id ()
public function integer of_new_record (long al_prac_id)
public function integer of_setfocus ()
public function integer of_get_rowcount ()
public function boolean of_blank_record ()
public function integer of_retrieve_detail (integer currentrow)
public function integer of_clear_filter_vars ()
public function integer of_ver_filter ()
public function integer of_set_screen (integer ai_screen_id, string as_screen_name)
public function integer of_delete_row (long al_rec_id)
public function datawindow of_get_dw ()
public function integer of_set_inv_action_items (pfc_n_cst_ai_action_items ainv_object)
public function integer of_set_view_id (integer al_data_view_id)
public function integer of_set_verify (boolean ab_verify)
public function integer of_update ()
public function integer of_set_prac_id (long al_prac_id)
public function integer of_get_this_facility_data ()
public function integer of_after_save ()
public function integer of_retrieve (long al_prac_id)
public function integer of_set_facility_id (integer ai_facility_id)
public function integer of_reverify_verif_data ()
public function integer of_copy_verifications ()
public function boolean of_post_update ()
public function integer of_delete_verification ()
public function integer of_scan_ver_doc ()
public function integer of_clear_print ()
public function integer of_reset ()
public function integer of_iverify ()
public function integer of_add_npdb (long al_prac_id, long al_rec_id, long al_screen_id, string as_reference, datetime adt_exp_date, string as_screen_name, long al_address_lookup_code, string as_add_type, integer ai_parent_facility_id)
public function integer of_add_oig (long al_prac_id, long al_rec_id, integer ai_parent_facility)
public function integer of_se ()
public function integer of_print_report ()
public function integer of_web_crawl ()
public function integer of_select_error (integer ai_i)
public function integer of_send_verif_to_history ()
public function integer of_find_missing_verif ()
public function integer of_retrieve_recreds (datawindow adw_recred_info)
public function integer of_update_inactive_verifs (long al_rec_id, integer ai_screen, integer ai_data_status)
public function integer of_create_inv_action_items ()
public function integer of_bg_color (long al_rgb)
public function integer of_add_record (long al_prac_id, long al_rec_id, long al_screen_id, string as_reference, datetime adt_exp_date, string as_screen_name, long al_address_lookup_code, string as_add_type, integer as_end_month, integer as_end_year, long al_complete_response, integer ai_data_status, long al_method)
public function integer of_update_reference (string as_reference, long al_rec_id, long al_address_lookup_code, datetime adt_exp_dt, integer ai_screen, integer ai_data_status, long al_method)
public function integer of_add_single_verif (long al_prac_id, long al_rec_id, long al_screen_id, string as_reference, datetime adt_exp_date, string as_screen_name, long al_address_lookup_code, string as_add_type, integer ai_data_status, long al_method)
public function integer of_set_button_enabled ()
public function integer of_post_resize ()
public function integer of_security ()
public function integer of_batch_verif_view ()
public function integer of_filter_defaults (boolean ab_run_filter)
public function integer of_ama_api ()
public function integer of_get_ama_verifs (long al_facil)
public subroutine of_zoom ()
end prototypes

event pfc_cst_print_letters();gs_pass_ids lstr_ids
Integer li_rc
Integer i
Integer li_print_cnt,li_corro_cnt
Long ll_ver_method_ver_ltr1
Long ll_ver_method_ver_ltr2
Long ll_ver_method_ver_ltr3
Long ll_ver_method_ver_ltr4
long ll_wf_id  //12.5.2006 By Jervis

ll_ver_method_ver_ltr1 = Long(gnv_data.of_getitem("code_lookup" , "lookup_code" , "upper(lookup_name)='" + Upper('verification method') + "' and upper(code)='" + Upper('verif ltr') + "'"))
ll_ver_method_ver_ltr2 = Long(gnv_data.of_getitem("code_lookup" , "lookup_code" , "upper(lookup_name)='" + Upper('verification method') + "' and upper(code)='" + Upper('exp cred ltr') + "'"))
ll_ver_method_ver_ltr3 = Long(gnv_data.of_getitem("code_lookup" , "lookup_code" , "upper(lookup_name)='" + Upper('verification method') + "' and upper(code)='" + Upper('exp appt ltr') + "'"))
ll_ver_method_ver_ltr4 = Long(gnv_data.of_getitem("code_lookup" , "lookup_code" , "upper(lookup_name)='" + Upper('verification method') + "' and upper(code)='" + Upper('fax') + "'"))
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-10-17 By: Rodger Wu (Inova)
//$<reason> Miss Info 90 letter newly added should be print now.
Long ll_ver_method_ver_ltr5, ll_verif_method
ll_ver_method_ver_ltr5 = Long(gnv_data.of_getitem("code_lookup" , "lookup_code" , "upper(lookup_name)='" + Upper('verification method') + "' and upper(code)='" + Upper('MISS ITEM 90') + "'"))
//---------------------------- APPEON END ----------------------------

lstr_ids.s_stringval = "All Letters To Be Printed"
lstr_ids.dw = dw_detail
lstr_ids.ls_from_window = "PV"  //Start Code Change ----08.24.2011 #V11 maha - added argument
lstr_ids.facility_id = ii_facility_id //Start Code Change ----03.07.2012 #V12 maha

li_rc = dw_detail.RowCount()
For i = 1 To li_rc

	ll_verif_method = dw_detail.GetItemNumber( i, "verification_method" )
	ll_wf_id = dw_detail.GetItemNumber(i,"verif_info_wf_id")	//12.5.2006 By Jervis

	If dw_detail.GetItemNumber( i, "print_flag" ) = 1 Then
		if ( ll_verif_method = ll_ver_method_ver_ltr1 Or +&
			ll_verif_method = ll_ver_method_ver_ltr2 Or +&
			ll_verif_method = ll_ver_method_ver_ltr3  Or +&
			ll_verif_method = ll_ver_method_ver_ltr4  Or +&
			ll_verif_method = ll_ver_method_ver_ltr5 ) and +&
			isnull(ll_wf_id)  Then		//12.5.2006 By Jervis
			
			li_print_cnt++
			lstr_ids.s_ids[i] = dw_detail.GetItemString( i, "doc_id" )
		end if
		if dw_detail.GetItemNumber(i,"verif_info_letter_id") > 0 then
			li_corro_cnt++
			lstr_ids.s_doc_ids[li_corro_cnt] = dw_detail.GetItemString( i, "doc_id" )
		end if
			
	End If
	//---------------------------- APPEON END ----------------------------
End For
	
	
	
If li_print_cnt +  li_corro_cnt > 0 Then
	OpenWithParm( w_ai_print_letters, lstr_ids )
Else
	MessageBox("Print", "All entries on this view have previously been printed." )
	Return
End If
	

end event

event pfc_cst_dial_phone();//Start Code Change ----07.17.2008 #V81 maha - modified to use instance object
//pfc_n_cst_ai_printletters lnv_printletters
//lnv_printletters = CREATE pfc_n_cst_ai_printletters
inv_printletters.of_dialphone( dw_detail.GetItemString( dw_detail.GetRow(), "phone") )
//DESTROY lnv_printletters
end event

event pfc_cst_goto_web();Integer li_cr
String ls_web_address
String ls_web_title
Long ll_verification_id
long ll_method

//Start Code Change ---- 03.12.2007 #V7 maha
//if of_get_app_setting("web_crawl","I") = 1 then

	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-38
	//$<modify> 01.24.2006 By: Cao YongWang
	//$<reason> Performance tuning
	//$<modification> Write script to retrieve data from a cache instead of from the database.
	/*
		SELECT code_lookup.lookup_code  
		INTO :ll_method
		FROM code_lookup  
		WHERE (code_lookup.lookup_name = 'Verification Method' ) AND  
				(code_lookup.code = 'WEB'  );
				
		IF SQLCA.SQLCODE = -1 THEN 
			MessageBox("SQL ERROR (pfc_cst_u_variification_info :: pfc_cst_npdb_export)", SQLCA.SQLERRTEXT) 
			RETURN 
		END IF				
	*/
	ll_method = long(gnv_data.of_getitem("code_lookup","lookup_code","upper(lookup_name) = upper('Verification Method') AND upper(code) = 'WEB'" ))
	//---------------------------- APPEON END ----------------------------

	dw_detail.SetFilter( "verification_method = " + String( ll_method) + " and active_status = 1")
	dw_detail.Filter( )
	
	of_web_crawl( )
//	return
//end if

//ll_verification_id = dw_detail.GetItemNumber( dw_detail.GetRow(), "address_lookup_code")
//
//ls_web_address = dw_detail.GetItemString( dw_detail.GetRow(), "web_address")
//
////Start Code Change ---- 0303.2006 #313 maha
//IF len(ls_web_address ) < 1 THEN
//	MessageBox("Invalid WEB Address", "There is no web address setup in the lookup table for the selected entity." )
//	Return
//END IF
////End Code Change---03.03.2006
//	
//li_cr = dw_detail.GetRow( )
//ls_pass_ids.ls_doc_id = dw_detail.GetItemString( li_cr, "doc_id" )
//ls_pass_ids.ls_ref_value = dw_detail.GetItemString( li_cr, "reference_value" )
//ls_pass_ids.ls_from_window = "Prac_Folder"
//ls_pass_ids.ll_verification_id = ll_verification_id
//IF dw_detail.GetItemNumber( li_cr, "verification_picture_flag" ) = 1 THEN
//	ls_pass_ids.ls_image_available = True
//ELSE
//	ls_pass_ids.ls_image_available = False
//END IF
//
////maha app102105  //allows capture screen and message to be turned off.
//if of_get_app_setting("set_13","I") = 1 then
//	IF Not IsValid( w_capture ) THEN
//		OpenWithParm( w_capture,  ls_pass_ids )
//	ELSE
//		w_capture.of_setup( ls_pass_ids )
//	END IF
//end if
//
//pfc_n_cst_ai_printletters lnv_printletters
//
//lnv_printletters = CREATE pfc_n_cst_ai_printletters
//
//lnv_printletters.of_connecttoweb( ls_web_address )
//
//DESTROY lnv_printletters
//End Code Change---03.12.2007
end event

event pfc_cst_npdb_export();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : pfc_cst_npdb_export
//==================================================================================================================
//  Purpose   	: CONTROL FUNCTION TO SEND FOR THE NPDB MENTHOD (IPT OR QPRAC)
//==================================================================================================================
//  Arguments 	: [NONE] 
//==================================================================================================================
//  Returns   	: [NONE]     
//==================================================================================================================
//  Notes     	: changes here must be made to w_action_items :: pfc_cst_npdb_export as well   
//==================================================================================================================
//  Created By	: ???
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                   Reason
// ------------------------------------------------------------------------------------------------------------------
//  MSKINNER 					07 Feb 2005                    Added modification for NPDB IPT interface
//																			 added case statement
//																			 Added calls to of_start_npdb
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CONSTANT LONG ITP_INTERFACE = 1 // USED FOR READ-ABILITY
CONSTANT LONG QRXS_INTERFACE = 2 // Evan 11.18.2009 (V10.1 - NPDB QRXS)

INTEGER li_8
integer i 
integer chk
integer li_send
integer res  //maha  01.26.2016
Long    ll_npdb_query
String ls_url = "https://www.npdb-hipdb.hrsa.gov/"  //maha 01.26.2016

inet iinet_base

li_8 = of_get_app_setting("set_8","I")

//Start Code Change ----05.05.2008 #V8 maha - moved trap out of web type 
SELECT code_lookup.lookup_code  
INTO :ll_npdb_query
FROM code_lookup  
WHERE (code_lookup.lookup_name = 'Verification Method' ) AND  
		   (code_lookup.code = 'NPDB Query'  );
				
IF SQLCA.SQLCODE = -1 THEN 
	MessageBox("SQL ERROR (pfc_cst_u_variification_info :: pfc_cst_npdb_export)", SQLCA.SQLERRTEXT) 
	RETURN 
END IF

//------------------- APPEON BEGIN -------------------
//$<modify> Evan 12.14.2009
//$<reason> Fixed bug (V10.1 - NPDB QRXS)
//dw_detail.SetFilter( "verification_method = " + String( ll_npdb_query) + " and active_status = 1")
dw_detail.SetFilter("verification_method = " + String(ll_npdb_query) + " and active_status = 1 and isnull(response_code)")
//------------------- APPEON END ---------------------		
dw_detail.Filter( )
		
IF dw_detail.RowCount() = 0 THEN
	  MessageBox("Invalid Option", "No NPDB data to export." )
	  Return 
END IF
		

if dw_detail.GetItemNumber( 1, "print_flag" ) = 0 then //receive
	li_send = 1
elseif dw_detail.GetItemNumber( 1, "print_flag" ) = 1 and dw_detail.GetItemNumber( 1, "number_sent" ) > 0 then
	li_send = 2
elseif dw_detail.GetItemNumber( 1, "print_flag" ) = 1 then //send
	li_send = 0
end if
	
//for i = 1 to  dw_detail.RowCount()
//	if dw_detail.GetItemNumber( i, "print_flag" ) = 1 Then
//		cnt ++
//	end if
//next
//		
//if cnt = 0 then
//	
//	MessageBox("NPDB", "The NPDB query has previously been sent." )
//	Return
//end if
//End Code Change---05.05.2008



CHOOSE CASE li_8
	CASE ITP_INTERFACE, QRXS_INTERFACE //Evan 11.18.2009 -- add QRXS_INTERFACE (V10.1 - NPDB QRXS)
//debugbreak()
		n_cst_npdb_control lnvo
		lnvo = CREATE n_cst_npdb_control
		lnvo.ib_do_not_open = true
		
		if li_send = 0  then
			message.doubleparm = 2  //SEND
		elseif li_send = 1  then
			message.doubleparm = 1 //RECIEVE
		elseif li_send = 2 then  //sent but received with an error
		//Start Code Change ---09.010.2012 #V12 maha - -modified to use a message window to allow send
			open(w_npdb_verif_message)
			chk = message.doubleparm
			//chk = MessageBox("NPDB", "The NPDB query has previously been sent, but is set to resend.  Do you wish to resend the file to the NPDB?  If you previously sent this file and received errors that have not been corrected, you should click NO.",question!,yesno!,2 )
			if chk = 2 then //send
				//SEND
			elseif chk = 1 then //rcv
				 //recv
				dw_detail.SetItem( 1, "print_flag", 0 ) 
			else //No
				Return
			end if
		//End Code Change ---09.010.2012
		end if
		
		lnvo.of_run_npdb(dw_browse)
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<Add> 08.23.2007 By: Evan
		//$<Reason> Need to destroy object.
		if IsValid(lnvo) then Destroy lnvo
		//---------------------------- APPEON END ----------------------------		
	CASE ELSE //IQRS

		if li_send > 0 then
			MessageBox("NPDB", "The NPDB query has previously been sent." )
			Return
		end if
		
		// CREATE THE EXPORT FILE
		inv_action_items.of_npdb_export_old( dw_detail ,ii_facility_id,"P")
		String ls_null
		setnull(ls_null)
		
		// OPEN THE WEB PAGE
		if gi_citrix = 1 then
			//of_open_web("http://www.npdb-hipdb.hrsa.gov")//Start Code Change ---- 10.03.2006 #624 maha
			//Start Code Change ----01.26.2016 #V15 maha - modified to try CHROME first
			if of_get_app_setting("set_41","I") = 400 then //Start Code Change ----07.25.2017 #V154 maha  - changed to 400 - THIS IS NOT IMPLEMENTED AS USERS DO NOT HAVE THE ABILITY TO  CHANGES THE SETTING
				res = ShellExecuteA (Handle( This ), "open", "CHROME", ls_url, ls_Null, 4)
				if res < 33 then
					messagebox("NPDB","The NPDB website prefers the CHROME browser.  As this is not installed, opening in another browser.")
					ShellExecuteA (Handle( This ), "open", of_getbrowserversion( ), ls_url, ls_Null, 4)
				end if
			else
				of_open_web(ls_url) //Add by Evan 08.25.2011
			end if
			//End Code Change ----01.26.2016		
			
			//of_open_web("http://www.npdb-hipdb.com")
		else
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 06.23.2006 By: Liang QingShi
			//$<reason>  GetContextService is currently unsupported. 
			//$<modification> Replace GetContextService with ShellExecuteA to provide the
			//$<modification> same functionality.
			/*
			GetContextService("Internet", iinet_base)
			iinet_base.HyperlinkToURL("http://www.npdb-hipdb.com")
			*/
				
				//---------Begin Modified by (Appeon)Harry 04.27.2015 for Keep Everything under One Browser--------
				//ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', ls_url , ls_Null, 4)
			//Start Code Change ----01.26.2016 #V15 maha - modified to try CHROME first
				//---------Begin Modified by (Appeon)Stephen 03.03.2016 for Bug id 5019 - NPDB QPRAC Not opening NPDB Website, SAAS only. Build 02052016 and 03022016--------
				//if AppeonGetClientType() = "PB" then
				if of_get_app_setting("set_41","I") = 2 then
				//---------End Modfiied ------------------------------------------------------
					res = ShellExecuteA (Handle( This ), "open", "CHROME", ls_url, ls_Null, 4)
					if res < 33 then
						messagebox("NPDB","The NPDB website prefers the CHROME browser.  As this is not installed, opening in another browser.")
						ShellExecuteA (Handle( This ), "open", of_getbrowserversion( ), ls_url, ls_Null, 4)
					end if
				else
					of_open_web(ls_url) //(Appeon)Stephen 03.03.2016 - Bug id 5019 - NPDB QPRAC Not opening NPDB Website, SAAS only. Build 02052016 and 03022016
				end if
				//---------Begin Modified by (Appeon)Harry 04.27.2015 for Keep Everything under One Browser--------
				//ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', ls_url , ls_Null, 4)
			//	ShellExecuteA (Handle( This ), "open", of_getbrowserversion( ), ls_url, ls_Null, 4)
			//End Code Change ----01.26.2016
		end if
		
END CHOOSE

of_retrieve_detail( dw_orgs_facilities.getrow() ) //Start Code Change ----05.05.2008 #V8 maha
of_ver_filter()



//if li_8 = 1 then
//	
// inv_action_items.of_npdb_export_type( "P" )
//else //currently being used
//	SELECT code_lookup.lookup_code  
//	INTO :ll_npdb_query
//	FROM code_lookup  
//	WHERE ( code_lookup.lookup_name = 'verification method' ) AND  
//			( code_lookup.code = 'NPDB Query'  )   ;
//	IF SQLCA.SQLCODE = -1 THEN
//		MessageBox("SQL ERROR", SQLCA.SQLERRTEXT)
//		RETURN 
//	END IF
//	
//	dw_detail.SetFilter( "verification_method = " + String( ll_npdb_query) + "and active_status = 1")
//	dw_detail.Filter( )
//	IF dw_detail.RowCount() = 0 THEN
//		MessageBox("Invalid Option", "No NPDB data to export." )
//		Return 
//	END IF
//	
//	//inv_action_items.of_npdb_export_type( "P" )
//	inv_action_items.of_npdb_export_old( dw_detail ,ii_facility_id,"P")
//
//	
//	 
//	GetContextService("Internet", iinet_base)
//	iinet_base.HyperlinkToURL("http://www.npdb-hipdb.com")
//end if
//
//if li_8 = 1 then
//	
// inv_action_items.of_npdb_export_type( "P" )
//else //currently being used
//	SELECT code_lookup.lookup_code  
//	INTO :ll_npdb_query
//	FROM code_lookup  
//	WHERE ( code_lookup.lookup_name = 'verification method' ) AND  
//			( code_lookup.code = 'NPDB Query'  )   ;
//	IF SQLCA.SQLCODE = -1 THEN
//		MessageBox("SQL ERROR", SQLCA.SQLERRTEXT)
//		RETURN 
//	END IF
//	
//	dw_detail.SetFilter( "verification_method = " + String( ll_npdb_query) + "and active_status = 1")
//	dw_detail.Filter( )
//	IF dw_detail.RowCount() = 0 THEN
//		MessageBox("Invalid Option", "No NPDB data to export." )
//		Return 
//	END IF
//	
//	//inv_action_items.of_npdb_export_type( "P" )
//	inv_action_items.of_npdb_export_old( dw_detail ,ii_facility_id,"P")
//
//	
//	 
//	GetContextService("Internet", iinet_base)
//	iinet_base.HyperlinkToURL("http://www.npdb-hipdb.com")
//end if
//
end event

event pfc_cst_clear_print;of_clear_print()
end event

event pfc_cst_iverify;of_iverify()
end event

event pfc_cst_scan_oig();long ll_oig
long pracids[]
string docids[]
integer i
integer ic
string ls_filter
string ls_parm
string ls_type

	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-03
	//$<modify> 01.24.2006 By: Cao YongWang
	//$<reason> Performance tuning
	//$<modification> Write script to retrieve data from a cache instead of from the database.

	/*
	SELECT code_lookup.lookup_code  
	INTO :ll_oig
	FROM code_lookup  
	WHERE ( code_lookup.lookup_name = 'Verification Method' ) AND  
			( code_lookup.code = 'OIG QUERY'  )   ;
	IF SQLCA.SQLCODE = -1 THEN
		MessageBox("SQL ERROR", SQLCA.SQLERRTEXT)
		RETURN 
	END IF
	*/
	ll_oig = long(gnv_data.of_getitem("code_lookup","lookup_code","upper(lookup_name)='" + upper('Verification Method') &
	       + "' and upper(code) = '" + 'OIG QUERY' + "'"))
	//---------------------------- APPEON END ----------------------------

	
	ls_filter = " verification_method = " + String( ll_oig) + " and active_status = 1"
	//messagebox("",ls_filter)
	dw_detail.SetFilter( ls_filter)
	dw_detail.Filter( )
	IF dw_detail.RowCount() = 0 THEN
		MessageBox("Invalid Option", "No OIG data to export." )
		Return 
	END IF

for i = 1 to dw_detail.rowcount()
	pracids[i] = dw_detail.getitemnumber(i,"prac_id")
	docids[i] = dw_detail.getitemstring(i,"doc_id")
next

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 11.17.2014
//<$>reason:When running OIG Queries from the practitioner Verification Tab, it will select the Manual Button

//open(w_oig_type)
openwithparm(w_oig_type,"PRAC")
//------------------- APPEON END -------------------

ls_type = message.stringparm

if ls_type = "A" then
	ls_parm = 'VAP'
elseif ls_type = "M" then
	ls_parm = 'VMP'
else
	return
end if

openwithparm(w_oig_on_demand,ls_parm)

if isvalid(w_oig_on_demand) then//maha 033005 trap if user updates oig
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-04
	//$<add> 02.15.2006 By: Cao YongWang
	//$<reason> Performance tunging.
	//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

	gnv_appeondb.of_startqueue()
	//---------------------------- APPEON END ----------------------------

	w_oig_on_demand.dw_prac_list.retrieve(pracids[])
	w_oig_on_demand.dw_verifs.retrieve(docids[])
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-05
	//$<add> 02.15.2006 By: Cao YongWang
	//$<reason> Performance tunging.
	//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
	gnv_appeondb.of_commitqueue()
	//---------------------------- APPEON END ----------------------------

end if

//of_retrieve_detail(dw_orgs_facilities.getrow())
//of_ver_filter()



end event

event pfc_cst_screen_capture();if dw_detail.rowcount() = 0 then return //maha 012505

gs_pass_ids ls_pass_ids
Integer li_cr	
	
li_cr = dw_detail.GetRow( )
ls_pass_ids.ls_doc_id = dw_detail.GetItemString( li_cr, "doc_id" )
ls_pass_ids.ls_ref_value = dw_detail.GetItemString( li_cr, "reference_value" )
ls_pass_ids.ll_verification_id = dw_detail.GetItemNumber( li_cr, "address_lookup_code")
ls_pass_ids.ls_from_window = "Prac_Folder"
IF dw_detail.GetItemNumber( li_cr, "verification_picture_flag" ) = 1 THEN
	ls_pass_ids.ls_image_available = True
ELSE
	ls_pass_ids.ls_image_available = False
END IF

IF Not IsValid( w_capture ) THEN
	OpenWithParm( w_capture,  ls_pass_ids )
ELSE
	w_capture.of_setup( ls_pass_ids )
END IF
end event

event pfc_cst_manual_workflow();//Added for work flow trigger. 14/11/2006 Henry
string	ls_rtn

str_manual_wf lstr_workflow

lstr_workflow.is_module = '01'
lstr_workflow.il_prac_id =  il_prac_id
lstr_workflow.il_facility_id =  ii_facility_id

OpenWithParm(w_manual_workflow_list , lstr_workflow)

ls_rtn = Message.stringparm

If ls_rtn = 'OK' Then of_retrieve(il_prac_id)
end event

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

public function integer of_retrieve_detail (integer currentrow);Integer li_org_id
Integer li_rc
Integer li_facility_id[2]
Integer li_row_cnt
integer li_found
long ll_exp_appt_ltr
integer cnt
string ls_appt_type  //maha 093008
string sss

IF dw_orgs_facilities.RowCount() = 0 THEN
	Return -1
END IF

li_facility_id[1] = dw_orgs_facilities.GetItemNumber( currentrow, "verifying_facility" )
li_facility_id[2] = dw_orgs_facilities.GetItemNumber( currentrow, "parent_facility_id" )
ii_facility_id = li_facility_id[2]
ii_ver_id = li_facility_id[1]
dw_detail.shareDataOff() //09.15.2007 By Jervis PB Bug,when not sharedataoff,the program throws an exception and crashes

li_row_cnt = dw_detail.Retrieve(1, il_prac_id, li_facility_id[]  )
//li_row_cnt = dw_detail.Retrieve(1, il_prac_id, ii_facility_id ,  ii_ver_id  )  //Start Code Change ----02.29.2016 #V15 maha - potential change would use d_ver_summary_record_view_prac

//dw_detail.Object.DataWindow.Color = il_rgb  //Start Code Change ----09.28.2012 #V12 maha //removed 07.31.2013 maha v14
if li_row_cnt < 0 then messagebox("Verif Info of_retrieve_detail","Retrieval Failed.  Contact ISG Support.")
//dw_browse.SetTransObject( SQLCA ) 09.15.2007 By Jervis
dw_detail.ShareData( dw_browse )
//debugbreak()
//Start Code Change ----09.30.2008 #V85 maha - for ccvs customization
if ib_i_r_filter then
	ls_appt_type = dw_orgs_facilities.GetItemString( currentrow, "pd_affil_stat_apptmnt_type" )
	is_i_r_filter =  inv_printletters.of_set_i_r_filter(ls_appt_type,li_facility_id[1])
	of_ver_filter( )
end if
//End Code Change---09.30.2008

IF dw_detail.RowCount() > 0 THEN
	il_rec_id = dw_detail.GetItemNumber( 1, "rec_id" )
END IF

//Start Code Change ----10.05.2015 #V15 maha - security added
if w_mdi.of_security_access(7798) = 0 then   
	tab_view.tabpage_recred.visible = false
else  //enable if exp verif exists
	//Start Code Change ----06.20.2008 #V81 maha - moved from dw detail rfc event
	ll_exp_appt_ltr = long(gnv_data.of_getitem("code_lookup","lookup_code","upper(code)='" + upper('Exp Appt Ltr') + "'"))
	
	select count(rec_id) into :li_found from verif_info where prac_id = :il_prac_id and facility_id = :li_facility_id[2] and active_status = 1 and verification_method = :ll_exp_appt_ltr;
	IF li_found > 0 then
		if dw_orgs_facilities.GetItemNumber( currentrow, "active_status" ) = 3 then
			tab_view.tabpage_recred.Enabled = False
		else
			tab_view.tabpage_recred.Enabled = True
		end if
	ELSE
		tab_view.tabpage_recred.Enabled = False
	END IF
	//End Code Change---06.20.2008
end if
//End Code Change ----10.05.2015 

of_set_button_enabled( )  //Start Code Change ----03.28.2012 #V12 maha


RETURN 0
end function

public function integer of_clear_filter_vars ();is_status_filter = ""
is_verif_filter = ""
is_view_filter = ""

RETURN 0
end function

public function integer of_ver_filter ();String ls_filter = ""
Integer li_retval

ls_filter = is_view_filter 
IF ls_filter = "" AND LenA(is_status_filter) > 0 THEN
	ls_filter = is_status_filter
ELSEIF ls_filter <> "" AND LenA(is_status_filter) > 0 THEN
	ls_filter = ls_filter + " AND " + is_status_filter
END IF


IF ls_filter = "" AND LenA(is_verif_filter) > 0 THEN
	ls_filter = is_verif_filter
ELSEIF ls_filter <> "" AND LenA(is_verif_filter) > 0 THEN
	ls_filter = ls_filter + " AND " + is_verif_filter
END IF

IF IsNull( ls_filter ) THEN
	Return -1
END IF

if ib_i_r_filter THEN
	ls_filter += is_i_r_filter 
end if

//messagebox("", ls_filter)
LI_RETVAL = dw_detail.SetFilter( ls_filter )
IF li_retval = 1 THEN
	dw_detail.Filter( )
	is_combined_filter = ls_filter  //Start Code Change ----08.24.2011 #V11 maha 
else
	messagebox("of_ver_filter","is_i_r_filter  failed")
END IF

IF dw_browse.RowCount() > 0 THEN
//	dw_browse.SelectRow( 0, False )   //Start Code Change ----01.20.2016 #V15 maha - removed
//	dw_browse.SelectRow( 1, True )
	dw_browse.SetRow( 1 )
	dw_browse.ScrollToRow( 1 )
	st_recs.Text = "Record " + String( 1 ) + " of " + String( dw_browse.RowCount() )

	Long ll_exp_appt_ltr	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-06
	//$<modify> 01.24.2006 By: Cao YongWang
	//$<reason> Performance tuning
	//$<modification> Write script to retrieve data from a cache instead of from the database.

	/*
	SELECT code_lookup.lookup_code  
	INTO :ll_exp_appt_ltr  
	FROM code_lookup  
	WHERE code_lookup.code = 'Exp Appt Ltr'   ;
	*/
	ll_exp_appt_ltr = long(gnv_data.of_getitem("code_lookup","lookup_code","upper(code)='" + upper('Exp Appt Ltr') + "'"))
	//---------------------------- APPEON END ----------------------------

	
//	IF dw_browse.GetItemNumber( 1, "verification_method" ) = ll_exp_appt_ltr  AND +&
//		dw_browse.GetItemNumber( 1, "active_status" ) = 1 THEN
//		tab_view.tabpage_recred.Enabled = True
//	ELSE
//		tab_view.tabpage_recred.Enabled = False
//	END IF	
ELSE
	st_recs.Text = "No Records"
END IF

of_set_button_enabled( )  //Start Code Change ----03.28.2012 #V12 maha


RETURN 0
end function

public function integer of_set_screen (integer ai_screen_id, string as_screen_name);//IF ai_screen_id = 1 THEN
	ai_screen_id = 0 
	is_view_filter = ""
//ELSE
//	is_view_filter = "screen_id = " + String( ai_screen_id )
//END IF

ii_screen_id = ai_screen_id

//Begin changes-16/11/2006 Henry
//is_verif_filter = "(response_code = 0 OR IsNull(response_code)) " 
is_verif_filter = "((isnull(verif_info_wf_id) and response_code = 0 or IsNull(response_code)) or (verif_info_wf_complete_flag = 'N'))" 
rb_ver_impcompl.checked = true  //Make sure the Incomplete status is selected
//End changes-16/11/2006 Henry

is_status_filter = "active_status = 1" 

dw_select_screen.SetItem( 1, "screen_id", ai_screen_id )
of_ver_filter()

RETURN 0
end function

public function integer of_delete_row (long al_rec_id);Integer li_row

li_row = dw_detail.Find("rec_id = " + String( al_rec_id ), 1, 1000 )

IF li_row > 0 THEN
	dw_detail.DeleteRow( li_row )
END IF

RETURN 0
end function

public function datawindow of_get_dw ();Return dw_detail
end function

public function integer of_set_inv_action_items (pfc_n_cst_ai_action_items ainv_object);inv_action_items = ainv_object

Return 1
end function

public function integer of_set_view_id (integer al_data_view_id);ii_data_view_id = al_data_view_id

RETURN 0
end function

public function integer of_set_verify (boolean ab_verify);ib_verify = ab_verify

RETURN 0
end function

public function integer of_update ();IF dw_detail.Update() = -1 THEN
	RETURN -1
ELSE
	RETURN 0
END IF
end function

public function integer of_set_prac_id (long al_prac_id);il_prac_id = al_prac_id

IF gb_se_version THEN
	of_se()
END IF

Return 0
end function

public function integer of_get_this_facility_data ();Integer li_found
//*mike 01-11-00 changed variable in following line from ii_facility_id to gi_parent_facility.
li_found = dw_orgs_facilities.Find("parent_facility_id = " + String( gi_parent_facility ), 1, 1000 )

IF li_found > 0 THEN
	dw_orgs_facilities.ScrollToRow( li_found )
	dw_orgs_facilities.SetRow( li_found )
//	dw_orgs_facilities.SelectRow( 0, False )   //Start Code Change ----01.20.2016 #V15 maha - removed
//	dw_orgs_facilities.SelectRow( li_found, True )
	of_retrieve_detail( li_found )	
END IF

Return 0
end function

public function integer of_after_save ();//dw_orgs_facilities.TriggerEvent(RowFocusChanged!)
//of_get_this_facility_data( )
//of_ver_filter()

Return 1

end function

public function integer of_retrieve (long al_prac_id);DataWindowChild dwchild
Long ll_org_id

il_prac_id = al_prac_id

dw_orgs_facilities.Reset()
dw_orgs_facilities.Retrieve( al_prac_id,gs_user_id )

dw_detail.SetFocus()
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-07
//$<add> 01.24.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Set ib_first_retrieved to FALSE to recover the original status.
 
ib_first_retrieved = false
//---------------------------- APPEON END ----------------------------

RETURN 0
end function

public function integer of_set_facility_id (integer ai_facility_id);ii_facility_id = ai_facility_id

//setup facility org dw
dw_orgs_facilities.of_SetUpdateAble( False )
dw_orgs_facilities.of_SetTransObject(SQLCA)

//Setup detail dw
DataWindowChild dwchild1,dwchild2,dwchild3,dwchild4,dwchild5,dwchild6,dwchild7

dw_detail.of_SetRowManager( TRUE )
dw_detail.of_SetReqColumn( False )

dw_detail.of_SetSort( True )
dw_detail.inv_sort.of_SetColumnnameSource( dw_detail.inv_sort.HEADER )
dw_detail.inv_sort.of_SetStyle( dw_detail.inv_sort.DROPDOWNLISTBOX )
dw_detail.inv_sort.of_SetColumnHeader( TRUE )

dw_detail.of_SetTransObject(SQLCA)

dw_detail.GetChild( "response_code", dwchild1 )
dwchild1.SetTransObject( SQLCA )

dw_detail.GetChild( "verification_method", dwchild2 )
dwchild2.SetTransObject( SQLCA )

dw_detail.SetRowFocusIndicator( p_1)

//setup select screen dw
dw_select_screen.of_SetUpdateAble( False )
dw_select_screen.of_SetTransObject( SQLCA )
dw_select_screen.InsertRow( 0 )
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-10
//$<comment> 02.15.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Due to restrictions for using Appeon labels, the following script 
//$<modification> should be removed to the end of Appeon Commit Queue label. Refer
//$<modification> to PT-11 for more information.

/*
dw_select_screen.GetChild( "screen_id", dwchild )

dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "screen_name", "Correspondence" )
dwchild.SetItem( 1, "screen_id", 1 )

dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "screen_name", "All" )
dwchild.SetItem( 1, "screen_id", 0 )
*/
//---------------------------- APPEON END ----------------------------

//setup browse dw
dw_browse.of_SetReqColumn( False )
dw_browse.of_SetUpdateAble( False )
dw_browse.of_SetTransObject(SQLCA)

dw_browse.GetChild( "response_code", dwchild3 )
dwchild3.SetTransObject( SQLCA )

dw_browse.GetChild( "verification_method", dwchild4 )
dwchild4.SetTransObject( SQLCA )

dw_detail.GetChild( "priority_user", dwchild5 )
dwchild5.SetTransObject( SQLCA )

dw_browse.GetChild( "priority_user", dwchild6 )
dwchild6.SetTransObject( SQLCA )


dw_select_screen.GetChild( "screen_id", dwchild7 )
dwchild7.SetTransObject( SQLCA )

gnv_appeondb.of_startqueue()
	dwchild1.Retrieve("credentials verification response")
	dwchild2.Retrieve("verification method")
	//--------Begin Modified by Nova 01.08.2009-----------
	//dwchild3.Retrieve("credentialsxx verification response")
	dwchild3.Retrieve("credentials verification response")
	//--------End Modified -------------------------------
	dwchild4.Retrieve("verification method")
	dwchild5.Retrieve()
	dwchild6.Retrieve()
	dwchild7.Retrieve()
gnv_appeondb.of_commitqueue()

dwchild1.InsertRow( 1 )  //Start Code Change ----06.24.2008 #V81 maha

//Start Code Change ----05.30.2013 #V14 maha - added web ans all letters and reorganized
dwchild7.InsertRow( 1 )
dwchild7.SetItem( 1, "screen_name", "Basic Information" )
dwchild7.SetItem( 1, "screen_id", 1 )

 //Start Code Change ----03.02.2015 #V15 maha - added workflow
 if gb_workflow = true then
	dwchild7.InsertRow( 1 ) 
	dwchild7.SetItem( 1, "screen_name", "Work Flow Actions" )
	dwchild7.SetItem( 1, "screen_id", -10 )
end if
 //end Code Change ----03.02.2015

dwchild7.InsertRow( 1 )//05.30.2013
dwchild7.SetItem( 1, "screen_name", "Web Verifications" )
dwchild7.SetItem( 1, "screen_id", -6 )

//Start Code Change ----11.14.2012 #V12 maha - added filter for Exp cred letters
dwchild7.InsertRow( 1 )  
dwchild7.SetItem( 1, "screen_name", "Expiring Credential Letters" )
dwchild7.SetItem( 1, "screen_id", -5 )
//End Code Change ----11.14.2012
dwchild7.InsertRow( 1 )  //05.30.2013
dwchild7.SetItem( 1, "screen_name", "All Letters" )
dwchild7.SetItem( 1, "screen_id", -7 )
//End Code Change ----05.30.2013
dwchild7.InsertRow( 1 )
dwchild7.SetItem( 1, "screen_name", "All" )
dwchild7.SetItem( 1, "screen_id", 0 )

//---------------------------- APPEON END ----------------------------

dw_browse.of_SetSort( True )
dw_browse.inv_sort.of_SetColumnnameSource( dw_browse.inv_sort.HEADER )
dw_browse.inv_sort.of_SetStyle( dw_browse.inv_sort.DROPDOWNLISTBOX )
dw_browse.inv_sort.of_SetColumnHeader( TRUE )

//setup recred dw
tab_view.tabpage_recred.dw_recred_info.of_SetTransObject( SQLCA )
tab_view.tabpage_recred.dw_recred_info.of_setupdateable(false)


Return 0
end function

public function integer of_reverify_verif_data ();Integer i
Integer t
Integer li_row_cnt
Long ll_seq_no
Integer li_last_row
Integer li_ans
Long ll_prac_id
Date nulldate
String ls_doc_id
Integer nullint
String nullstring
integer res
integer eap
long ll_rec_id
string ls_ref
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-12
//$<add> 04.14.2006 By: Rodger Wu
//$<reason> Original code bug fixing 
//$<modification> Define a local variable.
Integer li_selected_count = 0
//---------------------------- APPEON END ----------------------------

li_ans = MessageBox("Reverify Data", "Are you sure you want to reverify the selected credentials.", Question!, YesNo!, 1 )
IF li_ans = 2 THEN
	Return -1
END IF

SetNull( nullint )
SetNull( nulldate )
SetNull( nullstring )

li_row_cnt = dw_browse.RowCount()

FOR i = 1 TO li_row_cnt
	eap = 0
	IF dw_browse.GetItemNumber( i, "selected" ) = 1 THEN
		IF IsNull( dw_browse.GetItemNumber( i, "response_code" )) THEN
			MessageBox("Selection Error", "You can not select a credential that has not already been verified!" )
			//--------------------------- APPEON BEGIN ---------------------------
			//$<ID> UM-01
			//$<modify> 01.13.2006 By: Wang Chao
			//$<reason> The GOTo statement is currently unsupported.
			//$<modification> Define a new function to encapsulates the scripts associated with the label. Call the
			//$<modification> new function instead of using GOTO label.
			//GOTO select_error		
			Return of_select_error(i)
			//---------------------------- APPEON END ----------------------------		
		END IF
		IF dw_browse.GetItemNumber( i, "exp_credential_flag" ) = 1 THEN
			eap = 1
			res = MessageBox("Selection Error", "You have selected an expiring appointment entry. To continue will reset the record as new.  Continue?",Question!,yesno!,2 )
			if res = 2 then
				//--------------------------- APPEON BEGIN ---------------------------
				//$<ID> UM-02
				//$<modify> 01.13.2006 By: Wang Chao
				//$<reason> The GOTo statement is currently unsupported.
				//$<modification> Define a new function to encapsulates the scripts associated with the label. Call the
				//$<modification> new function instead of using GOTO label.
				//GOTO select_error
						
				Return of_select_error(i)
				//---------------------------- APPEON END ----------------------------
			end if
		END IF
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 04.14.2006 By: Rodger Wu
		//$<reason> Fix a defect in the original unmodified PowerBuilder application. 
		li_selected_count ++
		//---------------------------- APPEON END ----------------------------
	END IF
END FOR

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.14.2006 By: Rodger Wu
//$<reason> Fix a defect in the original unmodified PowerBuilder application.  
If li_selected_count < 1 Then
	messagebox("User Select Error","You have not selected a verification not verified within Browse tab!" )
	Return -1;
End If
//---------------------------- APPEON END ----------------------------

FOR i = 1 TO li_row_cnt - 1 //trap for duplicated selected records maha 111803
	IF dw_browse.GetItemNumber( i, "selected" ) = 1 THEN
		ll_rec_id = dw_browse.GetItemNumber( i, "rec_id" )
		FOR t = i + 1 TO li_row_cnt
			IF dw_browse.GetItemNumber( t, "selected" ) = 1 THEN
				if ll_rec_id = dw_browse.GetItemNumber( t, "rec_id" ) then
					ls_ref = dw_browse.GetItemstring( t, "reference_value" )
					messagebox("User Select Error","You have selected multiple verifications for the " + ls_ref + " record (one may be an expiring record).~rPlease unselect the duplicate records and rerun function." )
					//--------------------------- APPEON BEGIN ---------------------------
					//$<ID> UM-03
					//$<modify> 01.13.2006 By: Wang Chao
					//$<reason> The GOTo statement is currently unsupported.
					//$<modification> Define a new function to encapsulates the scripts associated with the label. Call the
					//$<modification> new function instead of using GOTO label.
					//GOTO select_error		
					Return of_select_error(i)
					//---------------------------- APPEON END ----------------------------
				end if
			end if
		next
	end if
next
				

FOR i = 1 TO li_row_cnt
	IF dw_browse.GetItemNumber( i, "selected" ) = 1 THEN
		dw_browse.SetItem( i, "selected", 0 )
		dw_browse.RowsCopy( i, i, Primary!, dw_browse, 100000, Primary!)	
		li_last_row = dw_browse.RowCount()
		//make selected record a history record
		dw_browse.SetItem( i, "active_status", 0 )
		ll_prac_id = dw_browse.GetItemNumber( li_last_row, "prac_id" )
		ll_rec_id = dw_browse.GetItemNumber( li_last_row, "rec_id" )
		select max(seq_no) into :ll_seq_no from verif_info where prac_id = :ll_prac_id and rec_id = :ll_rec_id; //maha 060603 because exp letters may cause a problem here
		//ll_seq_no = dw_browse.GetItemNumber( i, "seq_no" )
		ll_seq_no++
		//set new records data
		dw_browse.SetItem( li_last_row, "active_status", 1 )
		dw_browse.SetItem( li_last_row, "seq_no", ll_seq_no )
		dw_browse.SetItem( li_last_row, "user_name", nullstring )		
		dw_browse.SetItem( li_last_row, "first_sent", nulldate )
		dw_browse.SetItem( li_last_row, "last_sent", nulldate )
		dw_browse.SetItem( li_last_row, "number_sent", 0 )
		dw_browse.SetItem( li_last_row, "date_recieved", nulldate )
		dw_browse.SetItem( li_last_row, "response_code", nullint )	
		dw_browse.SetItem( li_last_row, "verification_picture_flag",0)   //Start Code Change ---- 02.28.2007 #V7 maha
		//assign a doc_id
		ls_doc_id = string(ll_rec_id)
		ls_doc_id = ls_doc_id + "-" + String( ll_prac_id )//hyphens added 092800 maha
		ls_doc_id = ls_doc_id + "-" + String( dw_browse.GetItemNumber( li_last_row, "facility_id" ) )
		ls_doc_id = ls_doc_id + "-" + String( dw_browse.GetItemNumber( li_last_row, "seq_no" ) )
		dw_browse.SetItem( li_last_row, "doc_id", ls_doc_id )
		if dw_browse.getItemstring( li_last_row, "reference_value" ) = "Expiring Appointment Letter" then
			dw_browse.SetItem( li_last_row, "exp_credential_flag", 1 )
		end if
		//set the print flag to 1 so this gets processed
		dw_browse.SetItem( li_last_row, "print_flag", 1 )	
		if eap = 1 then dw_browse.SetItem( li_last_row, "exp_credential_flag", 1 )
		//Start Code Change ----08.03.2011 #V11 maha - set prior mod values 
		dw_browse.SetItem(  li_last_row, "mod_user", gs_user_id )
		dw_browse.SetItem(  li_last_row, "mod_date", datetime(today(),now()) )
		//End Code Change ----08.03.2011
		//Start Code Change ----03.22.2013 #V12 maha //Start Code Change ----01.07.2014 #V14 maha - corrected from mod user and date
		dw_browse.SetItem(  li_last_row, "create_user", gs_user_id + "-MR" )
		dw_browse.SetItem(  li_last_row, "create_date", datetime(today(),now()) )
		//End Code Change ----03.22.2013 #V12 maha
	END IF
END FOR

IF dw_detail.Update() = -1 THEN
	MessageBox("Update Failed", "Update to verif_info table failed!" )
	RETURN -1
END IF

//COMMIT USING SQLCA;

of_ver_filter()

RETURN 0

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-04
//$<comment> 01.13.2006 By: Wang Chao
//$<reason> The label select_error is replaced by the function of_select_error
//$<modification> Comment out the following script and have them encapsulated 
//$<modification> into of_select_error.
//select_error:
//dw_browse.SelectRow( 0, False)
//dw_browse.SelectRow( i, True )
//dw_browse.SetRow( i )
//dw_browse.ScrollToRow( i )
//dw_select_screen.BringToTop = True
//Return -1
//---------------------------- APPEON END ----------------------------

end function

public function integer of_copy_verifications ();
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-10-08 By: Rodger Wu (Inova)
//$<reason> New window designed for simplifying Verification Copy function.

Integer li_currentrow
OpenWithParm( w_verification_batchcopy, string( il_prac_id ) + '~t' + string( ii_facility_id ) )
IF Message.StringParm = "modified" THEN
	li_currentrow = dw_orgs_facilities.GetRow( )
	IF li_currentrow < 1 THEN li_currentrow = 1
	dw_orgs_facilities.Trigger Event RowFocusChanged( li_currentrow )
END IF
Return 0;

//---------------------------- APPEON END ----------------------------
//old code
//Integer li_find_row
//Integer i
//Integer li_count
//Integer li_row_cnt
//Long ll_seq_no
//Integer li_last_row
//Integer li_ans
//Long ll_prac_id
//long ll_recid
//Date nulldate
//String ls_doc_id
//String nullstring
//Integer nullint
//Integer li_facility_id
//Integer li_ver_facility
//Integer li_ver_facility_2
//integer li_copy_data
//integer t = 0
//integer trows
//long ll_test1 
//long ll_test2 
//debugbreak()
//SetNull( nullint )
//SetNull( nullstring )
//
//
//IF dw_browse.RowCount() = 0 THEN
//	Return -1
//END IF
//
//li_row_cnt = dw_browse.RowCount()
//trows = li_row_cnt
//
//FOR i = 1 TO li_row_cnt 
//	IF dw_browse.GetItemNumber( i, "selected" ) = 1 THEN t++
//next
//
//if t = 0 then
//	messagebox("Copy Error","There are no records selected for copying")
//	return 0
//end if
//
//FOR i = 1 TO li_row_cnt //test for duplicate verifications  maha 042805
//	IF dw_browse.GetItemNumber( i, "selected" ) = 1 THEN
//		ll_test1 = dw_browse.GetItemNumber( i, "rec_id" )
//		for t = 1 to trows
//			IF dw_browse.GetItemNumber( t, "selected" ) = 1 THEN
//				ll_test2 = dw_browse.GetItemNumber( t, "rec_id" )
//				if  i <> t and ll_test1 = ll_test2 then
//					messagebox("Copy Error","There are duplicate records selected for copying.~n~rPlease deselect duplicates")
//					//--------------------------- APPEON BEGIN ---------------------------
//					//$<ID> UM-05
//					//$<modify> 01.13.2006 By: Wang Chao
//					//$<reason> The GOTo statement is currently unsupported.
//					//$<modification> Define a new function to encapsulates the scripts associated with the label. Call the
//					//$<modification> new function instead of using GOTO label.
//					//	GOTO select_error	
//					Return of_select_error(i)
//					//---------------------------- APPEON END ----------------------------	
//				end if
//			end if
//		next
//	end if
//next
//
//FOR i = 1 TO li_row_cnt
//	IF dw_browse.GetItemNumber( i, "selected" ) = 1 THEN
//		IF dw_browse.GetItemNumber( i, "exp_credential_flag" ) = 1 THEN			
//			MessageBox("Selection Error", "You can only select credential verification entries. You have selected an expiring credential entry." )			
//			//--------------------------- APPEON BEGIN ---------------------------
//			//$<ID> UM-06
//			//$<modify> 01.13.2006 By: Wang Chao
//			//$<reason> The GOTo statement is currently unsupported.
//			//$<modification> Define a new function to encapsulates the scripts associated with the label. Call the
//			//$<modification> new function instead of using GOTO label.
//			//	GOTO select_error	
//			Return of_select_error(i)
//			//---------------------------- APPEON END ----------------------------			
//		END IF
//	END IF
//END FOR
//
//li_copy_data = messagebox("Copy Verifications","Do you wish to copy with completion information?",Question!,yesno!,2)
//ll_prac_id = dw_browse.GetItemNumber( 1, "prac_id" )
//
//Open( w_get_facility )
//IF Message.StringParm = "Cancel" THEN
//	Return -1
//END IF
//
//li_facility_id = Integer( Message.StringParm ) //copy to parent facility
//
//SetNull( li_ver_facility )
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-09
////$<modify> 02.20.2006 By: Cao YongWang
////$<reason> Performance tuning.
////$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
//
///*
//SELECT pd_affil_stat.verifying_facility  //get verifiying facility for that parent
//INTO :li_ver_facility  
//FROM pd_affil_stat  
//WHERE ( pd_affil_stat.prac_id = :ll_prac_id ) AND  
//      ( pd_affil_stat.parent_facility_id = :li_facility_id ) AND  
//      ( pd_affil_stat.active_status in ( 1,4 ) )   ; //maha  changed to include pending 072402
//IF IsNull( li_ver_facility ) THEN
//	MessageBox("Invalid Facility", "The selected Parent Facility was not setup in the Appointment Status screen.")
//	RETURN -1
//END IF
//
//SELECT pd_affil_stat.verifying_facility
//INTO :li_ver_facility_2
//FROM pd_affil_stat  
//WHERE ( pd_affil_stat.prac_id = :ll_prac_id ) AND  
//      ( pd_affil_stat.parent_facility_id = :ii_facility_id ) AND  
//      ( pd_affil_stat.active_status in ( 1,4 ) )   ; //maha  changed to include pending 072402
//IF SQLCA.SQLCODE = -1 THEN
//	RETURN -1
//END IF
//*/
//gnv_appeondb.of_startqueue()
//SELECT pd_affil_stat.verifying_facility  //get verifiying facility for that parent
//INTO :li_ver_facility  
//FROM pd_affil_stat  
//WHERE ( pd_affil_stat.prac_id = :ll_prac_id ) AND  
//      ( pd_affil_stat.parent_facility_id = :li_facility_id ) AND  
//      ( pd_affil_stat.active_status in ( 1,4 ) )   ; //maha  changed to include pending 072402
//
//SELECT pd_affil_stat.verifying_facility
//INTO :li_ver_facility_2
//FROM pd_affil_stat  
//WHERE ( pd_affil_stat.prac_id = :ll_prac_id ) AND  
//      ( pd_affil_stat.parent_facility_id = :ii_facility_id ) AND  
//      ( pd_affil_stat.active_status in ( 1,4 ) )   ; //maha  changed to include pending 072402
//
//gnv_appeondb.of_commitqueue()
//IF IsNull( li_ver_facility ) THEN
//	MessageBox("Invalid Facility", "The selected Parent Facility was not setup in the Appointment Status screen.")
//	RETURN -1
//END IF
//IF SQLCA.SQLCODE = -1 THEN
//	RETURN -1
//END IF
////---------------------------- APPEON END ----------------------------
//
//IF li_ver_facility_2 = li_ver_facility THEN
//	MessageBox("Invalid", "Both Parent facilities are using the same Verifying Facility, therefore use the Reverify option instead of the Copy Verification Process." )
//	Return -1
//END IF
//
//
//li_ans = MessageBox("Copy Verifications", "Are you sure you want to copy the selected credentials.", Question!, YesNo!, 1 )
//IF li_ans = 2 THEN
//	Return -1
//END IF
//
//SetNull( nulldate )
//
//li_row_cnt = dw_browse.RowCount()
//
//
//
//FOR i = 1 TO li_row_cnt
//	IF dw_browse.GetItemNumber( i, "selected" ) = 1 THEN
//		dw_browse.SetItem( i, "selected", 0 )
//		dw_browse.RowsCopy( i, i, Primary!, dw_browse, 100000, Primary!)	
//		li_last_row = dw_browse.RowCount()
//		ll_prac_id = dw_browse.GetItemNumber( li_last_row, "prac_id" )
//		ll_recid = dw_browse.GetItemNumber( li_last_row, "rec_id" )
//		//seq no get rebuilt 040705
//		select max(seq_no) into :ll_seq_no from verif_info where rec_id = :ll_recid and prac_id = :ll_prac_id and facility_id = :li_ver_facility;
//		if isnull(ll_seq_no) then ll_seq_no = 0
//		ll_seq_no ++
//		
//		//make selected record a history record
//		dw_browse.SetItem( li_last_row, "facility_id", li_ver_facility )
//		dw_browse.SetItem( li_last_row, "active_status", 1 )
//		dw_browse.SetItem( li_last_row, "seq_no", ll_seq_no )
//		//set new records data
//		if li_copy_data = 2 then //no   maha 070902 keep org data if requested
//			dw_browse.SetItem( li_last_row, "first_sent", nulldate )
//			dw_browse.SetItem( li_last_row, "last_sent", nulldate )
//			dw_browse.SetItem( li_last_row, "number_sent", 0 )
//			dw_browse.SetItem( li_last_row, "date_recieved", nulldate )
//			dw_browse.SetItem( li_last_row, "user_name", nullString )		
//			dw_browse.SetItem( li_last_row, "response_code", nullint )
//			dw_browse.SetItem( li_last_row, "print_flag", 1 )//modified maha 031004
//		else //yes to copy
//			dw_browse.SetItem( li_last_row, "print_flag", 0 )//modified maha 031004
//		end if
//		//assign a doc_id
//		ls_doc_id = String( ll_recid) + "-" + string(ll_prac_id) + "-" + string(li_ver_facility) + "-" + string(ll_seq_no) 
//		//maha modified 020303 (dashes were not placed properly)
//		//ls_doc_id = ls_doc_id + "-" +String( ll_prac_id ) + "-"
//		//ls_doc_id = ls_doc_id + String( dw_browse.GetItemNumber( li_last_row, "facility_id" ) ) + "-"
//		//ls_doc_id = ls_doc_id + String( dw_browse.GetItemNumber( li_last_row, "seq_no" ) ) + 
//		dw_browse.SetItem( li_last_row, "doc_id", ls_doc_id )
//	END IF
//END FOR
//
//IF dw_detail.Update() = -1 THEN
//	MessageBox("Update Failed", "Update to verif_info table failed!" )
//	RETURN -1
//END IF
//
//COMMIT USING SQLCA;
//
//li_find_row = dw_orgs_facilities.Find( "parent_facility_id = " + String( li_facility_id ), 1, 1000 )
//dw_orgs_facilities.SetRow( li_find_row )
//dw_orgs_facilities.ScrollToRow( li_find_row )
//dw_orgs_facilities.SelectRow( 0, False )
//dw_orgs_facilities.SelectRow( li_find_row, True )
//
//of_ver_filter()
//
//RETURN 0
//
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> UM-07
////$<comment> 01.13.2006 By: Wang Chao
////$<reason> The label select_error is replaced by the function of_select_error
////$<modification> Comment out the following script and have them encapsulated 
////$<modification> into of_select_error.
////select_error:
////dw_browse.SelectRow( 0, False)
////dw_browse.SelectRow( i, True )
////dw_browse.SetRow( i )
////dw_browse.ScrollToRow( i )
////dw_select_screen.BringToTop = True
////Return -1
////---------------------------- APPEON END ----------------------------
//
end function

public function boolean of_post_update ();Integer li_num_facilities
Integer i
Integer li[]
Boolean lb_verif_complete = False

li_num_facilities = UpperBound( ii_facility_ids )
if li_num_facilities < 1 then
	lb_verif_complete = false
else
//messagebox("count",li_num_facilities)
//FOR i = 1 TO li_num_facilities
	IF inv_action_items.of_is_last_verif( ii_facility_ids[ 1 ], il_prac_id,ii_screen_ids[1] ) = 1 THEN
		lb_verif_complete = True	
	END IF
//END FOR
end if
ii_facility_ids = li

Return lb_verif_complete

end function

public function integer of_delete_verification ();Integer li_ans
Integer li_row

/* R.Avital v11.3 
	Save row to verif_info_delete table 
	before deleting from verif_info table
	Begin Changes
*/
Decimal ldc_recid
Decimal ldc_pracid
Long ll_facid
Long ll_seqno
String ls_docid
DateTime ldt_deldate
String ls_deluser
// R.Avital v11.3 END changes

li_row = dw_detail.GetRow()

IF li_row < 1 THEN
	Return -1
END IF

IF NOT IsNull( dw_detail.GetItemNumber( li_row, "response_code" )) AND +&
		dw_detail.GetItemNumber( li_row, "response_code" ) <> 0 THEN
	MessageBox("Invalid Option", "You can't delete a verification entry that has been completed" )
	Return -1
END IF

li_ans = MessageBox( "Delete", "Are you sure you want to delete the selected verification entry?",StopSign!, YesNo!, 2 )
IF li_ans = 2 THEN
	Return -1
END IF

li_ans = MessageBox( "Delete", "Are you really sure?",StopSign!, YesNo!, 1 )
IF li_ans = 2 THEN
	Return -1
END IF

/* R.Avital v11.3 
	Save row to verif_info_delete table 
	before deleting from verif_info table
	Begin Changes
*/

ldc_recid = dw_detail.GetItemDecimal(li_row, 'rec_id')
ldc_pracid = dw_detail.GetItemDecimal(li_row, 'prac_id')
ll_facid = dw_detail.GetItemNumber(li_row, 'verif_info_facility_id')
ll_seqno = dw_detail.GetItemNumber(li_row, 'seq_no')
ls_docid = dw_detail.GetItemString(li_row, 'doc_id')
ls_deluser = Trim(gs_user_id)
ldt_deldate = DateTime(Today(), Now())

INSERT INTO verif_info_delete
		(rec_id, prac_id, facility_id, seq_no, screen_id, first_sent, 
 		last_sent, number_sent, date_recieved, user_name, source, response_code, 
		active_status, verification_method, expiration_date, verification_id, reference_value, 
 		address_lookup_code, verifying_facility, priority_user, priority, exp_credential_flag, 
 		doc_id, print_flag, direct_parent_facility_link, notes, verification_picture_flag, wf_step, 
 		due_date, letter_id, wf_id, wf_action_type_id, wf_complete_flag, data_status, 
 		create_date, create_user)
SELECT rec_id, prac_id, facility_id, seq_no, screen_id, first_sent, 
		 last_sent, number_sent, date_recieved, user_name, source, response_code, 
		 active_status, verification_method, expiration_date, verification_id, reference_value, 
		 address_lookup_code, verifying_facility, priority_user, priority, exp_credential_flag, 
		 doc_id, print_flag, direct_parent_facility_link, notes, verification_picture_flag, wf_step, 
		 due_date, letter_id, wf_id, wf_action_type_id, wf_complete_flag, data_status, 
		 create_date, create_user
 FROM verif_info
 WHERE rec_id = :ldc_recid 
 		 AND prac_id = :ldc_pracid 
		 AND facility_id = :ll_facid 
		 AND seq_no = :ll_seqno 
		 AND doc_id = :ls_docid
 USING SQLCA;

UPDATE verif_info_delete
	SET del_date = :ldt_deldate,
		 del_user = :ls_deluser
 WHERE rec_id = :ldc_recid 
 		 AND prac_id = :ldc_pracid 
		 AND facility_id = :ll_facid 
		 AND seq_no = :ll_seqno 
		 AND doc_id = :ls_docid
 USING SQLCA;
 
 // R.Avital v11.3 END changes
 
dw_detail.DeleteRow( li_row )

//---------Begin Added by (Appeon)Stephen 11.30.2017 for V15.4 Bug # 5895 - Sending to history or deleting last verification prevents green checkmark and verif completed date--------
IF dw_detail.Update() = -1 THEN
	MessageBox("Update Failed", "Update to verif_info table failed!" )
	RETURN -1
END IF
ii_facility_ids[ 1 ] = ii_facility_id
ii_screen_ids[1] = ii_screen_id
of_post_update() 
if isvalid(w_prac_data_1) then
	w_prac_data_1.uo_app_stat.of_get_status( il_prac_id, ii_facility_id)  
	w_prac_data_1.uo_app_stat.dw_1.retrieve(w_prac_data_1.il_affil_rec_id)
end if
//---------End Added ------------------------------------------------------

Return 0
end function

public function integer of_scan_ver_doc ();//n_ds lds_scan
//Long ll_rec_id
//Integer li_row
//Integer li_num_pages
//
//li_row = dw_detail.GetRow()
//
//IF li_row = 0 THEN
//	Return -1
//END IF
//
//pfc_cst_nv_image_functions image_functions
//image_functions = CREATE pfc_cst_nv_image_functions
//
//ll_rec_id = dw_detail.GetItemNumber( dw_detail.GetRow(), "rec_id" )
//
//lds_scan =  CREATE n_ds
//
//n_ds.DataObject = "lds_scan"
//n_ds.of_SetTransObject( SQLCA )
//
//n_ds.InsertRow( 0 )
//
//lds_scan.SetItem( 1, "image_type_id", 25 )
//lds_scan.SetItem( 1, "prac_id", il_prac_id )
////lds_scan.SetItem( 1, "seq_no", li_seq_no )
//lds_scan.SetItem( 1, "rec_id", ll_rec_id  )
//lds_scan.SetItem( 1, "facility_id", 0  )	
//lds_scan.SetItem( 1, "screen_id", dw_detail.GetItemNumber( li_row, "screen_id" ) )	
//lds_scan.SetItem( 1, "reference_name", dw_detail.GetItemString( li_row, "reference_name" ) )
//lds_scan.SetItem( 1, "active_status", 1 )	
//lds_scan.SetItem( 1, "num_pages", li_num_pages )
////lds_scan.SetColumn( "notes" )
////
//
//
//DESTROY image_functions;
//
RETURN 1
end function

public function integer of_clear_print ();Integer i
Integer li_ans
Integer li_rc
//DateTime ldt_dt//cut 061301maha
String ls_null_string
long   ll_verif_info_wf_id, ll_response_code
string ls_wf_complete_flag

SetNull( ls_null_string )
li_rc = dw_browse.RowCount()

dw_browse.AcceptText()

//SetNull( ldt_dt )//cut 061301maha

FOR i = 1 TO li_rc
	
	IF dw_browse.GetItemNumber( i, "selected" ) = 0 THEN
		CONTINUE
	END IF
	
//	IF dw_detail.GetItemNumber( i, "number_sent" ) = 0 THEN //cut 061301maha
//		MessageBox("Invalid Option", "No verification attempts have been made yet." )
//		Return -1
//	END IF
     
	//---------Begin Added by (Appeon)Stephen 11.24.2014 for BugS092602--------
	/*
	IF NOT IsNull( dw_detail.GetItemNumber( i, "response_code" )) AND +&
		dw_detail.GetItemNumber( i, "response_code" ) <> 0 THEN
		*/
	ll_verif_info_wf_id = dw_detail.GetItemNumber( i, "verif_info_wf_id" )
	ll_response_code =  dw_detail.GetItemNumber( i, "response_code" )
	ls_wf_complete_flag = dw_detail.GetItemstring( i, "verif_info_wf_complete_flag" )
	if not ((isnull(ll_verif_info_wf_id) and ll_response_code = 0 or IsNull(ll_response_code)) or (ls_wf_complete_flag = 'N')) then
	//---------End Added ------------------------------------------------------  
		MessageBox("Invalid Option", "You can't clear a Print Flag on a verification that has been completed" )
		Return -1
	END IF

//	IF	dw_detail.GetItemNumber( i, "number_sent" ) = 1 THEN //cut 061301maha
//		dw_detail.SetItem( i, "first_sent", ldt_dt )
//		dw_detail.SetItem( i, "last_sent", ldt_dt )
//	END IF

	//SetNull( ldt_dt )
	//dw_detail.SetItem( i, "user_name", ls_null_string )//cut 061301maha
	//dw_detail.SetItem( i, "date_recieved", ldt_dt )//cut 061301maha
	//dw_detail.SetItem( i, "number_sent", dw_detail.GetItemNumber( i, "number_sent" )-1 )//cut 061301maha
	dw_detail.SetItem( i, "print_flag", 1 )
	//Start Code Change ----08.03.2011 #V11 maha - set created values
	dw_detail.SetItem( i, 'mod_date', datetime(today(),now()))
	dw_detail.SetItem( i, 'mod_user', gs_user_id)
	//End Code Change ----08.03.2011 
	
END FOR

FOR i = 1 TO li_rc
	dw_browse.SetItem( i, "selected", 0 )
END FOR

Return 0
end function

public function integer of_reset ();tab_view.tabpage_recred.dw_recred_info.Reset()
tab_view.SelectTab( 2 )
dw_detail.reset()   //Start Code Change ----07.10.2015 #V15 maha 

Return 0
end function

public function integer of_iverify ();//gs_pass_ids gs_passed_parms
//
//
//gs_passed_parms.prac_id = il_prac_id
//gs_passed_parms.s_ids[1] = "Old"
//gs_passed_parms.s_stringval = "Prac_Folder"
//gs_passed_parms.i_facility_ids[1] = dw_orgs_facilities.GetItemNumber( dw_orgs_facilities.GetRow(), "parent_facility_id" )
//gs_passed_parms.i_facility_ids[2] = dw_orgs_facilities.GetItemNumber( dw_orgs_facilities.GetRow(), "verifying_facility" )
//
//OpenWithParm( w_iverify_summary, gs_passed_parms )
//
//of_retrieve_detail( dw_orgs_facilities.GetRow() )
//
Return 0
end function

public function integer of_add_npdb (long al_prac_id, long al_rec_id, long al_screen_id, string as_reference, datetime adt_exp_date, string as_screen_name, long al_address_lookup_code, string as_add_type, integer ai_parent_facility_id);//created 020901 to allow only one npdb to be created when clicking data entry complete
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
n_ds lds_ver_orgs_facilities
n_ds lds_last_verif_seq_no
n_ds lds_dfl_rsp_code


IF al_address_lookup_code = 0 THEN
	SetNull( al_address_lookup_code )
END IF

ls_identifying_number = MidA( as_reference, PosA( as_reference, "-") + 2, 100 )

lds_dfl_rsp_code = CREATE n_ds
lds_dfl_rsp_code.DataObject = "d_app_audit_get_hc_dflt_ver_resp_code"
lds_dfl_rsp_code.of_SetTransObject( SQLCA )
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-29
//$<add> 02.20.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
gnv_appeondb.of_startqueue()
//---------------------------- APPEON END ----------------------------

li_rsp_rc = lds_dfl_rsp_code.Retrieve( al_prac_id, al_screen_id, ls_identifying_number )

lds_ver_orgs_facilities = CREATE n_ds
lds_ver_orgs_facilities.DataObject = "d_verifying_orgs_facilities_p"
lds_ver_orgs_facilities.of_SetTransObject( SQLCA )
li_rc = lds_ver_orgs_facilities.Retrieve( ai_parent_facility_id, al_prac_id, al_screen_id ) //maha changed to ai_parent_facility_id from ii_facility_id 021004
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-30
//$<add> 02.20.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_commitqueue()
li_rsp_rc = lds_dfl_rsp_code.rowcount()
li_rc = lds_ver_orgs_facilities.Rowcount()
//---------------------------- APPEON END ----------------------------

IF li_rc = 0 THEN
	MessageBox("Error in of_add_npdb of pfc_cst_u_verification", "No affiliation status records found." )//+ "  facility =" + string(ii_facility_id) + "  prac =" + string(al_prac_id) + "  Screen =" + string(al_screen_id))
	//MessageBox("Error", "This practitioner is not in the verification process, therefore no verification records can be added." )
	Return -1
END IF

lds_last_verif_seq_no = CREATE n_ds
lds_last_verif_seq_no.DataObject = "d_last_verif_seq_no"
lds_last_verif_seq_no.of_SetTransObject( SQLCA )

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

	li_nr = dw_detail.InsertRow( 0 ) //maha changes made 112101
	//li_facility_id = lds_ver_orgs_facilities.GetItemNumber( i, "verifying_facility" )	
	ls_priority_user = lds_ver_orgs_facilities.GetItemString( i, "priority_user" )	
	li_priority = lds_ver_orgs_facilities.GetItemNumber( i, "priority" )	
	dw_detail.SetItem( li_nr, "prac_id", al_prac_id )
	//dw_detail.SetItem( li_nr, "direct_parent_facility_link", ai_parent_facility_id )	
	dw_detail.SetItem( li_nr, "rec_id", al_rec_id )
	//dw_detail.SetItem( li_nr, "facility_id", ai_parent_facility_id) //li_facility_id )
	dw_detail.SetItem( li_nr, "verif_info_facility_id", ai_parent_facility_id) //li_facility_id )
	dw_detail.SetItem( li_nr, "priority_user", ls_priority_user )
	dw_detail.SetItem( li_nr, "priority", li_priority )
	dw_detail.SetItem( li_nr, "number_sent", 0 )
	dw_detail.SetItem( li_nr, "exp_credential_flag", 0)
	dw_detail.SetItem( li_nr, "print_flag", 1)
	IF li_rsp_rc = 1 THEN
		dw_detail.SetItem( li_nr, "response_code", lds_dfl_rsp_code.GetItemNumber( 1, "default_ver_response" ))
		dw_detail.SetItem( li_nr, "user_name", ls_priority_user )
		dw_detail.SetItem( li_nr, "date_recieved", Today() )
		//--------------------------- APPEON BEGIN ---------------------------
		//$<ID> PT-31
		//$<modify> 01.24.2006 By: Cao YongWang
		//$<reason> Performance tuning
		//$<modification> Write script to retrieve data from a cache instead of from the database.

		/*
		SELECT code_lookup.lookup_code  
      INTO :ll_hc_code  
      FROM code_lookup  
      WHERE code_lookup.code = 'Hard Copy'   ;
		*/
		ll_hc_code = long(gnv_data.of_getitem("code_lookup","lookup_code","upper(code)='" + upper('Hard Copy') + "'"))
		//---------------------------- APPEON END ----------------------------

  	   dw_detail.SetItem( li_nr, "verification_method", ll_hc_code )				
	ELSE
		dw_detail.SetItem( li_nr, "verification_method", ll_default_verif_method )		
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
	dw_detail.SetItem( li_nr, "seq_no", ll_seq_no )
	dw_detail.SetItem( li_nr, "screen_id", al_screen_id )
	dw_detail.SetItem( li_nr, "reference_value", as_reference )
	dw_detail.SetItem( li_nr, "expiration_date", adt_exp_date )
	dw_detail.SetItem( li_nr, "screen_name", as_screen_name )
	dw_detail.SetItem( li_nr, "address_lookup_code", al_address_lookup_code )
	ls_doc_id = String( al_rec_id ) + "-" + String( al_prac_id ) + "-" + String(ai_parent_facility_id ) +  "-" + String( ll_seq_no ) //maha modified parent variable 031004
	dw_detail.SetItem( li_nr, "doc_id", ls_doc_id )
	
	//Start Code Change ----08.03.2011 #V11 maha - set created values
	dw_detail.SetItem(li_nr, 'create_date', datetime(today(),now()))
	dw_detail.SetItem(li_nr, 'create_user', gs_user_id + "-D")
	//End Code Change ----08.03.2011 
	
END FOR

dw_detail.SetFocus()
dw_detail.ScrollToRow( li_nr )
dw_detail.SetRow( li_nr )

DESTROY lds_ver_orgs_facilities
DESTROY lds_last_verif_seq_no
DESTROY lds_dfl_rsp_code

dw_detail.Update()

RETURN 1


end function

public function integer of_add_oig (long al_prac_id, long al_rec_id, integer ai_parent_facility);//created 032703 for oig vers
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
n_ds lds_ver_orgs_facilities
n_ds lds_last_verif_seq_no
n_ds lds_dfl_rsp_code

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

lds_ver_orgs_facilities = CREATE n_ds
lds_ver_orgs_facilities.DataObject = "d_verifying_orgs_facilities_p"
lds_ver_orgs_facilities.of_SetTransObject( SQLCA )
li_rc = lds_ver_orgs_facilities.Retrieve( ii_facility_id, al_prac_id, 1 )
IF li_rc = 0 THEN
	MessageBox("Error in of_add_npdb of pfc_cst_u_verification", "No affiliation status records found." )//+ "  facility =" + string(ii_facility_id) + "  prac =" + string(al_prac_id) + "  Screen =" + string(al_screen_id))
	//MessageBox("Error", "This practitioner is not in the verification process, therefore no verification records can be added." )
	Return -1
END IF

lds_last_verif_seq_no = CREATE n_ds
lds_last_verif_seq_no.DataObject = "d_last_verif_seq_no"
lds_last_verif_seq_no.of_SetTransObject( SQLCA )



//ll_default_verif_method = 20
//\/changed maha 062804
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-32
//$<modify> 02.20.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Write script to retrieve data from a cache instead of from the database.

/*
select lookup_code into :ll_default_verif_method from code_lookup where code = 'OIG QUERY';
*/
ll_default_verif_method=long(gnv_data.of_getitem("code_lookup","lookup_code","upper(code)='OIG QUERY'"))
//---------------------------- APPEON END ----------------------------

if ll_default_verif_method < 1 or isnull(ll_default_verif_method) then
	MessageBox("Error in of_add_oig of pfc_cst_u_verification", "There is no lookup with the code of 'OIG QUERY' in the Verification Method lookup table.  Unable to create OIG verification" )
	return 1
end if
//\maha

	li_nr = dw_detail.InsertRow( 0 ) 

	ls_priority_user = lds_ver_orgs_facilities.GetItemString( li_rc, "priority_user" )	
	li_priority = lds_ver_orgs_facilities.GetItemNumber( li_rc, "priority" )	
	dw_detail.SetItem( li_nr, "prac_id", al_prac_id )
	dw_detail.SetItem( li_nr, "rec_id", al_rec_id )
	dw_detail.SetItem( li_nr, "verif_info_facility_id", ai_parent_facility) //li_facility_id )
	dw_detail.SetItem( li_nr, "verification_method", ll_default_verif_method )
	dw_detail.SetItem( li_nr, "priority_user", ls_priority_user )
	dw_detail.SetItem( li_nr, "priority", li_priority )
	dw_detail.SetItem( li_nr, "number_sent", 0 )
	dw_detail.SetItem( li_nr, "exp_credential_flag", 0)
	dw_detail.SetItem( li_nr, "print_flag", 1)
	dw_detail.SetItem( li_nr, "seq_no",1 )
	dw_detail.SetItem( li_nr, "screen_id", 1 )
	dw_detail.SetItem( li_nr, "reference_value", "OIG QUERY" )
	//dw_detail.SetItem( li_nr, "expiration_date", adt_exp_date )
	dw_detail.SetItem( li_nr, "screen_name", "Basic Information" )
	//dw_detail.SetItem( li_nr, "address_lookup_code", al_address_lookup_code )
	ls_doc_id = String( al_rec_id ) + "-" + String( al_prac_id ) + "-" + String( ai_parent_facility ) +  "-" + "1"
	dw_detail.SetItem( li_nr, "doc_id", ls_doc_id )
	//Start Code Change ----08.03.2011 #V11 maha - set created values
	dw_detail.SetItem(li_nr, 'create_date', datetime(today(),now()))
	dw_detail.SetItem(li_nr, 'create_user', gs_user_id + "-D")
	//End Code Change ----08.03.2011 


dw_detail.SetFocus()
dw_detail.ScrollToRow( li_nr )
dw_detail.SetRow( li_nr )

DESTROY lds_ver_orgs_facilities
DESTROY lds_last_verif_seq_no
DESTROY lds_dfl_rsp_code

res = dw_detail.Update()

if res < 1 then
	messagebox("OIG Verification Creation","Update failed.  Record not enetered")
end if


RETURN 1

end function

public function integer of_se ();dw_orgs_facilities.Visible = False
tab_view.x = 1

tab_view.width = tab_view.width + 20


dw_browse.x = dw_browse.x - 785

dw_detail.Modify( "priority.visible = '0'" )
dw_detail.Modify( "priority_user.visible = '0'" )
dw_detail.Modify( "t_priority.visible = '0'" )
dw_detail.Modify( "t_priority_user.visible = '0'" )
dw_detail.Modify( "priority.visible = '0'" )
dw_detail.Modify( "t_box.width = '2359'" )
dw_detail.Modify( "address_lookup_fee.x = '2300'" )


dw_detail.x = dw_detail.x - 785
dw_select_screen.x = dw_select_screen.x - 785
rb_stat_active.x = rb_stat_active.x - 785
rb_stat_both.x = rb_stat_both.x - 785
rb_stat_hist.x = rb_stat_hist.x - 785

rb_ver_compl.x = rb_ver_compl.x - 785
rb_ver_impcompl.x = rb_ver_impcompl.x - 785
rb_ver_stat_both.x = rb_ver_stat_both.x -785

gb_response_stat.x = gb_response_stat.x - 785
gb_type.x = gb_type.x - 785

st_recs.x = 1200

//r_filter.x = r_filter.x - 785
//r_filter1.x = r_filter1.x - 785




Return 1
end function

public function integer of_print_report ();//maha created 071105 for print screens
//Start Code Change ----09.30.2011 #V12 maha - modify to show print dialog box`
boolean lb_dialog = false


if gi_print_dialog = 1 then
	lb_dialog = true
end if

//Change the "print" to "of_print" - alfee 01.05.2012
if tab_view.selectedtab = 1 then //browse
	dw_browse.of_print(true,lb_dialog) 
elseif tab_view.selectedtab = 2 then //detail
	dw_detail.of_print(true,lb_dialog) 
elseif tab_view.selectedtab = 3 then //recred
	tab_view.tabpage_recred.dw_recred_info.of_print(true,lb_dialog) 
end if
//End Code Change ----09.30.2011

return 1
end function

public function integer of_web_crawl ();//Start Code Change ---- 05.03.2006 #444 maha  modified to retrieve via doc id
str_web_crawler lstr_web_crawler
integer cnt
integer i
string ls_docs[]
Long ll_recid //Added by Appeon long.zhang 12.23.2016
w_prac_data_1 lw_parent //Added by Appeon long.zhang 12.23.2016

		//EXAMPLE CODE FOR PRAC FOLDER
		//if you are in the practitioner folder then just pass the current
		//pracitioner id and facility id
//lstr_web_crawler.sl_prac_ids[1] = il_prac_id
//lstr_web_crawler.si_facility_ids[1] = ii_facility_id

for cnt = 1 to dw_detail.rowcount()
	lstr_web_crawler.ss_docid[cnt] = dw_detail.getitemstring(cnt,"doc_id")
next

		//open up Web Crawler window and pass structure with doc ids
OpenWithParm(w_web_crawler_verifications, lstr_web_crawler )
		//THIS IS A RESPONSE WINDOW SO DO A RE-RETRIEVE WHEN IT COMES BACK TO
		//UPDATE DATA WINDOW BECAUSE IN MY WEBVIEW WINDOW USERS CAN
		//COMPLETE ACTION ITEMS
of_Retrieve_Detail( dw_orgs_facilities.GetRow() )
of_ver_filter()
//End Code Change---05.03.2006

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 12.23.2016
//<$>reason:Refresh lights, Issue id 5443 - Verification Date on Appointment Screen doesn't populate SaaS 15.2 Build date 11172016
dw_detail.of_getparentwindow(lw_parent )
if lw_parent.classname() = 'w_prac_data_1' then 
	ll_recid = lw_parent.il_affil_rec_id
	lw_parent.uo_app_stat.of_get_status_rec( ll_recid )	
	IF lw_parent.tab_1.SelectedTab <> 4 THEN lw_parent.ib_page4_refresh = true
end if 
//------------------- APPEON END -------------------

return 1
end function

public function integer of_select_error (integer ai_i);//////////////////////////////////////////////////////////////////////
// $<function>pfc_cst_u_verification_infoof_select_error()
// $<arguments> value	integer	ai_i	
// $<returns> integer
// $<description>Contain the Label select_error scripts in of_reverify_verif_data function
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.13.2006 by Wang Chao
//////////////////////////////////////////////////////////////////////
//dw_browse.SelectRow( 0, False)   //Start Code Change ----01.20.2016 #V15 maha - removed
//dw_browse.SelectRow( ai_i, True )
dw_browse.SetRow( ai_i )
dw_browse.ScrollToRow( ai_i )
dw_select_screen.BringToTop = True
Return -1



end function

public function integer of_send_verif_to_history ();Integer i
Integer t
Integer li_row_cnt
Long ll_seq_no
Integer li_last_row
Integer li_ans
Long ll_prac_id
Date nulldate
String ls_doc_id
Integer nullint
String nullstring
integer res
integer eap
long ll_rec_id
string ls_ref
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-12
//$<add> 04.14.2006 By: Rodger Wu
//$<reason> Original code bug fixing 
//$<modification> Define a local variable.
Integer li_selected_count = 0
//---------------------------- APPEON END ----------------------------

li_ans = MessageBox("Send to history", "Are you sure you want to send the selected credentials to history?", Question!, YesNo!, 1 )
IF li_ans = 2 THEN
	Return -1
END IF

SetNull( nullint )
SetNull( nulldate )
SetNull( nullstring )

li_row_cnt = dw_browse.RowCount()

FOR i = 1 TO li_row_cnt
	eap = 0
	IF dw_browse.GetItemNumber( i, "selected" ) = 1 THEN
		li_selected_count ++
	END IF
END FOR

If li_selected_count < 1 Then
	messagebox("User Select Error","You have not selected a verification not verified within Browse tab!" )
	Return -1;
End If

				
FOR i = 1 TO li_row_cnt
	IF dw_browse.GetItemNumber( i, "selected" ) = 1 THEN
		//make selected record a history record
		dw_browse.SetItem( i, "active_status", 0 )
		//Start Code Change ----08.03.2011 #V11 maha - set prior mod values 
		dw_browse.SetItem(  i, "mod_user", gs_user_id )
		dw_browse.SetItem(  i, "mod_date", datetime(today(),now()) )
		//End Code Change ----08.03.2011
		
	END IF
END FOR

IF dw_detail.Update() = -1 THEN
	MessageBox("Update Failed", "Update to verif_info table failed!" )
	RETURN -1
END IF

//COMMIT USING SQLCA;

of_ver_filter()

//---------Begin Added by (Appeon)Stephen 11.30.2017 for V15.4 Bug # 5895 - Sending to history or deleting last verification prevents green checkmark and verif completed date--------
ii_facility_ids[ 1 ] = ii_facility_id
ii_screen_ids[1] = ii_screen_id
of_post_update() 
if isvalid(w_prac_data_1) then
	w_prac_data_1.uo_app_stat.of_get_status( il_prac_id, ii_facility_id) 
	w_prac_data_1.uo_app_stat.dw_1.retrieve(w_prac_data_1.il_affil_rec_id)
end if
//---------End Added ------------------------------------------------------

RETURN 0

end function

public function integer of_find_missing_verif ();//Start Code Change ----07.15.2008 #V81 maha - added
long ll_prac
long ll_vfacil
string ls_type
integer ll_row
datastore lds_data

Choose case dw_orgs_facilities.getitemnumber(dw_orgs_facilities.getrow(), "active_status")
	case 1,4, 6   // maha 11.06.2014 added midcycle
		ll_row = dw_orgs_facilities.getrow()
		ll_prac = dw_orgs_facilities.getitemnumber(ll_row, "prac_id")
		ll_vfacil = dw_orgs_facilities.getitemnumber(ll_row, "verifying_facility")
		ls_type = dw_orgs_facilities.getitemstring(ll_row, "pd_affil_stat_apptmnt_type")

		
		inv_printletters.of_find_missing_verifs( ll_prac, ll_vfacil, 0, ls_type)
		If message.stringparm = "Cancel" then
			return 1
		else
			choose case tab_view.selectedtab
				case 1,2
					of_retrieve_detail( ll_row )
					of_ver_filter()
				case 3
					inv_printletters.of_retrieve_recred(tab_view.tabpage_recred.dw_recred_info,ll_prac ,ll_vfacil )
			end choose 
			
		end if
		
		

	case else
		messagebox("Add Missing function","This function can not be run on Appointments that are not Active or Pending.")
		return -1
end  choose

return 1
end function

public function integer of_retrieve_recreds (datawindow adw_recred_info);//Start Code Change ----07.17.2008 #V81 maha - added
//calls function in printletters containing original code

inv_printletters.of_retrieve_recred(adw_recred_info, il_prac_id, ii_ver_id)

return 1
end function

public function integer of_update_inactive_verifs (long al_rec_id, integer ai_screen, integer ai_data_status);//Start Code Change ----08.01.2008 #V85 maha -  replaced by pfc_n_cst_ai_action_items.of_update_verif_status
inv_action_items.of_update_verif_status( al_rec_id, ai_screen, ai_data_status )

//maha 021500  sends to history verifs for dea, lic, and ins that become inactive
//update verif_info
//set active_status = 0
//where rec_id = :al_rec_id and active_status = 1;
//IF SQLCA.SQLCODE <> 0 THEN
//	MessageBox("Update Error", "Error updating active_status on verif_info table.")
//	Return -1
//END IF

//End Code Change---08.01.2008

return 1
end function

public function integer of_create_inv_action_items (); //Start Code Change ----10.22.2008 #V85 maha - function added
if not isvalid(inv_action_items) then 
	inv_action_items = create pfc_n_cst_ai_action_items
end if

return 1
end function

public function integer of_bg_color (long al_rgb);//Start Code Change ----06.08.2010 #V10 maha
this.backcolor = al_rgb
tab_view.backcolor = al_rgb
tab_view.tabpage_browse.backcolor = al_rgb
tab_view.tabpage_detail.backcolor = al_rgb
//tab_view.tabpage_detail.st_filter1.backcolor = al_rgb
st_recs.backcolor = al_rgb
//dw_select_screen.object.modify("datawindow.color =" + string(al_rgb))
gb_type.backcolor = al_rgb
gb_response_stat.backcolor = al_rgb
rb_stat_active.backcolor = al_rgb
rb_stat_both.backcolor = al_rgb
rb_stat_hist.backcolor = al_rgb
rb_ver_compl.backcolor = al_rgb
rb_ver_impcompl.backcolor = al_rgb
rb_ver_stat_both.backcolor = al_rgb
tab_view.tabpage_recred.backcolor = al_rgb
tab_view.tabpage_recred.cbx_check_miss.backcolor = al_rgb
tab_view.tabpage_recred.cbx_privs.backcolor = al_rgb
tab_view.tabpage_recred.cbx_preserve.backcolor = al_rgb   //Start Code Change ----07.22.2015 #V15 maha
//dw_select_screen.object.background.color = al_rgb  //set in constructor of dw_select_screen
il_rgb = al_rgb


return 1
end function

public function integer of_add_record (long al_prac_id, long al_rec_id, long al_screen_id, string as_reference, datetime adt_exp_date, string as_screen_name, long al_address_lookup_code, string as_add_type, integer as_end_month, integer as_end_year, long al_complete_response, integer ai_data_status, long al_method);//Start Code Change ----08.01.2008 #V85 maha - added as_data_status argument
/*There is an issue with verifications created for facility specific data screens.
If the verifying facility is common across parents, multiple verifs could be connected to the same
verifying facility.  
*///04-2002
Integer li_nr
Integer li_nr2 //maha 010401
Integer li_row_cnt
Integer li_rc
Integer i
Integer r
Integer ll_hc_code
Integer li_rsp_rc
Integer li_facility_id
Integer li_priority
Integer li_ver_priority
integer li_dupe_check //maha 010401
integer resp //maha 010901
integer li_parent_id //maha 020901
integer li_date_check //maha 010901
integer li_fac_ids//maha 011001
integer pc//maha 011001
integer pi//maha 011001
integer li_end_year//maha 012301
integer li_end_month//maha 012301
integer li_end_day// maha 031201
integer li_check_back_years
integer li_prime_check//maha 012201
integer li_isprime //maha 010901
integer li_complete //maha 031210
Long ll_seq_no
Long ll_default_verif_method
Long ll_lookup_verif_method  //maha 02.21.2013
long ll_comp_method //maha 031210
double ll_fee
String ls_identifying_number
string ls_facility_name//maha 011001
String ls_doc_id
String ls_priority_user
String ls_ver_priority_user
string ls_primary_check //maha 010901
string ls_screen_name //maha 010401
string ls_appt_type = "R" //maha 012401
string ls_verif_data //maha 012401
datetime ld_verifdate //maha 010901
datetime ld_dr //jad 06/03/02
date ld_hosp_check_date//maha 012201
date ld_data_check_date//maha 031501
n_ds lds_ver_orgs_facilities
n_ds lds_last_verif_seq_no
n_ds lds_dfl_rsp_code
n_ds lds_parent_facilities//maha 011201
n_ds lds_verif_facilities//maha 011201



IF al_address_lookup_code = 0 THEN
	SetNull( al_address_lookup_code )
END IF

//Start Code Change ----12.19.2012 #V12 maha
if not(isnull(al_address_lookup_code)) then
	select fee, verif_method into :ll_fee, :ll_lookup_verif_method from address_lookup where lookup_code = : al_address_lookup_code;
	if isnull(ll_lookup_verif_method) then ll_lookup_verif_method = 0 //Start Code Change ----02.21.2013 #V12 maha = added method
	//ll_fee = double(gnv_data.of_getitem("address_lookup","fee","lookup_code = " + string(al_address_lookup_code ) ) )
end if

if ll_fee = 0 then
	setnull( ll_fee )
end if
//End Code Change ----12.19.2012

ls_identifying_number = MidA( as_reference, PosA( as_reference, "-") + 2, 100 )

//Start Code Change ----12.12.2007 #V8 maha
//any verifications for screen 1 (npdb, exp appointment,ect) are created by other functions
if al_screen_id = 1 then
	return 1
end if
//End Code Change---12.12.2007

//get list of verifying facilities //maha 012001
lds_verif_facilities = CREATE n_ds
lds_verif_facilities.DataObject = "d_verifying_orgs_facilities_of_pract"
lds_verif_facilities.of_SetTransObject( SQLCA )

li_rc = lds_verif_facilities.Retrieve( al_prac_id,al_screen_id )
//<add> 06/28/2007 by: Andy set sort first
lds_verif_facilities.setsort("verifying_facility A")
lds_verif_facilities.sort()
//end of add

//create verification for each verifying facility //maha 012001
IF li_rc = 0 THEN			//maha message changed 072202 to be more meaningful.    //Start Code Change ----01.25.2017 #V153 maha - changed again
	MessageBox("Error in of_add_record of pfc_cst_u_verifcation_info", "No active Appointment records found.  No verification record will be created for this data record." )//+ "  facility =" + string(ii_facility_id) + "  prac =" + string(al_prac_id) + "  Screen =" + string(al_screen_id))
	Return -1
END IF


i = lds_verif_facilities.Find("upper(verify_data) <> 'N' OR Isnull(verify_data)" ,1 ,li_rc)
If	Isnull(i) Or i <= 0 Then Return 1

n_ds lds_detail
lds_detail = CREATE n_ds
lds_detail.DataObject = dw_detail.DataObject
lds_detail.of_SetTransObject( SQLCA )
//BEGIN-Delete by Evan 01.07.2011
//IF ib_object_created THEN
//	dw_detail.Sharedata(lds_detail )
//END IF
//END-Delete


lds_dfl_rsp_code = CREATE n_ds
lds_dfl_rsp_code.DataObject = "d_app_audit_get_hc_dflt_ver_resp_code"
lds_dfl_rsp_code.of_SetTransObject( SQLCA )

lds_ver_orgs_facilities = CREATE n_ds
lds_ver_orgs_facilities.DataObject = "d_verifying_orgs_facilities_forpt"
lds_ver_orgs_facilities.of_SetTransObject( SQLCA )

lds_parent_facilities = CREATE n_ds
lds_parent_facilities.DataObject = "d_verifying_parents_of_vers_forpt"
lds_parent_facilities.of_SetTransObject( SQLCA )

lds_last_verif_seq_no = CREATE n_ds
//<Modify> 07/24/2007 by: Andy
//lds_last_verif_seq_no.DataObject = "d_last_verif_seq_no_forpt"
lds_last_verif_seq_no.DataObject = "d_last_verif_seq_no_forpt_pract"
//end of modify
lds_last_verif_seq_no.of_SetTransObject( SQLCA )



Long li_facility_id_arr[],al_prac_id_arr[],al_rec_id_arr[]
FOR i = 1 TO li_rc//li_ver_fac_cnt
	li_facility_id = lds_verif_facilities.GetItemNumber( i, "verifying_facility" )
	li_facility_id_arr[i] = li_facility_id
END FOR

al_prac_id_arr[1] = al_prac_id
al_rec_id_arr[1] = al_rec_id

gnv_appeondb.of_startqueue( )

lds_dfl_rsp_code.Retrieve( al_prac_id, al_screen_id, ls_identifying_number )
lds_parent_facilities.retrieve(li_facility_id_arr[],al_prac_id_arr[])
//<Modify> 07/24/2007 by: Andy
//lds_last_verif_seq_no.Retrieve( al_rec_id_arr[], al_prac_id_arr[], li_facility_id_arr[] )
lds_last_verif_seq_no.Retrieve( al_rec_id, al_prac_id, al_screen_id )
//end of modify
lds_ver_orgs_facilities.Retrieve( li_facility_id_arr[], al_prac_id, al_screen_id )

if as_add_type <> "A" then 
	if al_screen_id = 10 then 
		Select year_thru,month_thru
		into :li_end_year,:li_end_month
		from pd_hosp_affil
		where rec_id = :al_rec_id;
	end if
	if al_screen_id = 7 or al_screen_id = 6 then 
		Select year_thru,month_thru
		into :li_end_year,:li_end_month
		from pd_training
		where rec_id = :al_rec_id;
	end if
end if

Long ll_i
If al_screen_id = 10 Then
	Datastore lds_facility_ver_rules
	lds_facility_ver_rules = create datastore
	lds_facility_ver_rules.dataobject = "d_facility_ver_rules_forpt"
	lds_facility_ver_rules.Settransobject( SQLCA )
	lds_facility_ver_rules.Retrieve( li_facility_id_arr[] )
End If

datastore lds_facility
lds_facility = create datastore
lds_facility.dataobject = "d_facility_forpt"
lds_facility.Settransobject( SQLCA )
lds_facility.Retrieve( li_facility_id_arr[] )

gnv_appeondb.of_commitqueue( )

li_rsp_rc = lds_dfl_rsp_code.Rowcount( )

If al_screen_id = 10 then
	Long li_parent_id_arr[]
	pc = lds_parent_facilities.Rowcount( )
	for pi = 1 to pc
		li_parent_id =  lds_parent_facilities.GetItemnumber( pi, "parent_facility_id" )
		li_parent_id_arr[pi] = li_parent_id
	next
	
	Datastore lds_pd_hosp_facility_link
	lds_pd_hosp_facility_link = create datastore
	lds_pd_hosp_facility_link.dataobject = "d_pd_hosp_facility_link_forpt"
	lds_pd_hosp_facility_link.Settransobject( SQLCA )
	lds_pd_hosp_facility_link.Retrieve( al_rec_id , li_parent_id_arr[] )
End If
//---------------------------- APPEON END ----------------------------

//<add> 06/28/2007 by: Andy
Integer li_facility_id_first = -1
//end of add

FOR i = 1 TO li_rc//li_ver_fac_cnt
	li_date_check = 0
	li_facility_id = lds_verif_facilities.GetItemNumber( i, "verifying_facility" )
	ls_facility_name = lds_verif_facilities.GetItemstring( i, "facility_name" )
	ls_verif_data = lds_verif_facilities.GetItemstring( i, "verify_data" )
	//Start Code Change ----03.12.2010 #V10 maha - method for completing as created
	li_complete = lds_verif_facilities.GetItemNumber( i, "compl_at_create" )
	ll_comp_method = lds_verif_facilities.GetItemNumber( i, "compl_default" )
	if isnull(ll_comp_method) then ll_comp_method = 0
	if li_complete = 1 and ll_comp_method > 0 then
		al_complete_response = ll_comp_method
	end if
	//End Code Change---03.12.2010
	if ls_verif_data = "N" then continue
	if isnull(ls_verif_data) then continue//Start Code Change ---- 04.10.2006 #388 maha

	lds_parent_facilities.SetFilter("verifying_facility = "+string(li_facility_id) )	//BugA063008 - alfee 07.13.2009
	lds_parent_facilities.Filter( )
	pc = lds_parent_facilities.Rowcount( )


	if pc < 1 then messagebox("Error","No retrieval on parents of verif facility")
	//checking all parents appttype to see if verif should be created maha 012401
			ls_appt_type = "R"
	for pi = 1 to pc
		if ls_appt_type = "R" and lds_parent_facilities.GetItemstring( pi, "apptmnt_type" )  = "I" then
			ls_appt_type = "I"
		end if
		//checking verifs completed date for all parents	
		ld_verifdate = lds_parent_facilities.GetItemdatetime( pi, "date_verif_completed" )
		if not(isnull(ld_verifdate)) then
			li_date_check = 1
		end if
	next
	//if ALL parents are recred and data item is Inital only, don't create.
	if ls_verif_data = "I" and ls_appt_type = "R" then continue
	
	if li_date_check = 1 then
			resp = messagebox("Verifications Completed" ,"The verification process has been completed for all Appointments for the verifying facility " + ls_facility_name + ". Do you want to add the verification item.",question!,yesno!,2)
		if resp = 2 then continue
	end if

	lds_ver_orgs_facilities.SetFilter("verifying_facility = " + String(li_facility_id) ) //BugA063008 - alfee 07.13.2009
	lds_ver_orgs_facilities.Filter()
	r = lds_ver_orgs_facilities.Rowcount( )


	if r < 1 then continue
	IF lds_ver_orgs_facilities.GetItemString( r, "verify_data" ) = "N" AND as_add_type = "A" THEN
			CONTINUE
		END IF
	//check check_back_years field  for reappointments maha 012301
	if al_screen_id = 10 or al_screen_id = 7 or al_screen_id = 6 then //hosp & training & educat
		//MESSAGEBOX("","check1")
		li_check_back_years = lds_ver_orgs_facilities.GetItemNumber(r,"check_back_years")
		if lds_ver_orgs_facilities.GetItemstring(r,"apptmnt_type") = "R" and li_check_back_years  > 0 then
			if as_add_type = "A" then //coming from dataentry preupdate
				li_end_year = as_end_year
				li_end_month = as_end_month
			else //forcing verification from menu 

			end if
			if not(isnull(li_end_year)) or li_end_year = 0  then  //Start Code Change ----10.26.2009 #V10 maha - added trap for Zero value
				if not(isnull(lds_ver_orgs_facilities.GetItemdatetime(r,"check_date"))) then
					if isnull(li_end_month) or li_end_month  = 0 then li_end_month = 12 //set to end of year if null   //Start Code Change ----10.26.2009 #V10 maha - added trap for Zero value
					choose case li_end_month
					case 2
						li_end_day = 28
					case 4,6,9,11
						li_end_day = 30
					case else
						li_end_day = 31
					end choose
					ld_hosp_check_date = date(li_end_year,li_end_month, li_end_day)
					ld_data_check_date = date(lds_ver_orgs_facilities.GetItemdatetime(r,"check_date"))
					//messagebox("ld_hosp_check_date",string(ld_hosp_check_date))
					//messagebox("ld_data_check_date",string(ld_data_check_date))
					if relativedate(ld_hosp_check_date,li_check_back_years * 365) < ld_data_check_date then continue	
				end if
			end if
		end if
	end if
	//maha 01-19-01 check for primary hospital only
	if al_screen_id = 10 then

		ls_primary_check = ""
		ll_i = lds_facility_ver_rules.Find( "facility_id = " + String(li_facility_id) ,1 , lds_facility_ver_rules.Rowcount())
		If ll_i > 0 Then ls_primary_check = lds_facility_ver_rules.GetItemString(ll_i,"exp_reminder_doc")
	

		//messagebox("",ls_primary_check)
		if ls_primary_check = "Y" then
			li_isprime = 0
			for pi = 1 to pc  //check each parent for primary hosp maha 020801
				li_parent_id =  lds_parent_facilities.GetItemnumber( pi, "parent_facility_id" )

				li_prime_check = 0
				ll_i = lds_pd_hosp_facility_link.Find("facility_id = " + String(li_parent_id), 1 , lds_pd_hosp_facility_link.Rowcount() )
				If ll_i > 0 Then li_prime_check = lds_pd_hosp_facility_link.Getitemnumber(ll_i , "primary_hosp")
		

				if li_prime_check = 581 then 	li_isprime = 1 //yes
			next
			if li_isprime = 0 then continue//cancel if not yes
		end if
	end if

	//Start Code Change ----08.31.2011 #V11 maha - for other verification screen preserve method
	if al_method = -1 then
		ll_default_verif_method = lds_ver_orgs_facilities.GetItemNumbeR( r, "default_verif_means" )
		//Start Code Change ----02.21.2013 #V12 maha  -set value from lookup record
		if ll_lookup_verif_method > 0 then //0 = no method in lookup record
			ll_default_verif_method = ll_lookup_verif_method
		end if
		//Start Code Change ----02.21.2013
	else
		ll_default_verif_method = al_method
	end if
	//Start Code Change ----08.31.2011 #V11


	li_nr = lds_detail.InsertRow( 0 )
	ls_priority_user = lds_ver_orgs_facilities.GetItemString( r, "priority_user" )	//from appointment

	//Start Code Change ----09.03.2009 #V92 maha - modify to set to assigned and priority properly
	if isnull(ls_priority_user ) or LenA(ls_priority_user ) < 1 then ls_priority_user = "PUBLIC" 
	li_priority = lds_ver_orgs_facilities.GetItemNumber( r, "priority" ) //from appointment
	li_ver_priority = lds_ver_orgs_facilities.GetItemNumber( r, "facility_ver_rules_priority" ) //from rules
	ls_ver_priority_user = lds_ver_orgs_facilities.GetItemString( r, "facility_ver_rules_priority_user") //from rules
	//set Assigned a) from verif rules; b) from appointment; c) PUBLIC
	if isnull(ls_ver_priority_user ) or LenA(ls_ver_priority_user ) < 1 then
		//use the user from the appointment
	else
		ls_priority_user = ls_ver_priority_user
	end if
	//set priority
	if isnull(li_ver_priority) or li_ver_priority  < 1 then
		//use the user from the appointment
	else
		li_priority = li_ver_priority
	end if
	//End Code Change---09.03.2009
	
	lds_detail.SetItem( li_nr, "prac_id", al_prac_id )
	lds_detail.SetItem( li_nr, "rec_id", al_rec_id )
	//lds_detail.SetItem( li_nr, "facility_id", li_facility_id )
	lds_detail.SetItem( li_nr, "verif_info_facility_id", li_facility_id )
	lds_detail.SetItem( li_nr, "priority_user", ls_priority_user )
	lds_detail.SetItem( li_nr, "priority", li_priority )
	lds_detail.SetItem( li_nr, "number_sent", 0 )
	lds_detail.SetItem( li_nr, "exp_credential_flag", 0)
	lds_detail.SetItem( li_nr, "verification_method", ll_default_verif_method )	 //Start Code Change ---- 11.02.2006 #1 maha
	lds_detail.SetItem( li_nr, "verif_info_data_status", ai_data_status )  //Start Code Change ----08.01.2008 #V85 maha - set data_status
	//06/03/02
	//added in for IntelliApp only users,  need this entry auto verified so intellicred can gen exp letters when due
	//Start Code Change ---- 10.26.2006 #1 maha
	//modified to use the al_complete_response argument from the dw_detail preupdate event
	IF al_complete_response > 0 THEN //complete with the response code
			  lds_detail.SetItem( li_nr, "response_code", al_complete_response )		
			  ld_dr = DateTime( Today(), Now() )
			  lds_detail.SetItem( li_nr, "date_recieved", ld_dr )					  
			  lds_detail.SetItem( li_nr, "user_name", gs_user_id )
			  //Start Code Change ----08.01.2008 #V85 maha - if data_status  = historical set verification so exp cred not created
			  if ai_data_status = 2 then lds_detail.SetItem( li_nr, "exp_credential_flag", 2) 
			  //End Code Change---08.01.2008
	END IF	
	

	if li_facility_id_first = li_facility_id then 
		ll_seq_no++
	else
	//end of add
		lds_last_verif_seq_no.SetFilter("facility_id = "+string(li_facility_id) )
		lds_last_verif_seq_no.Filter( )
		li_row_cnt = lds_last_verif_seq_no.Rowcount( )
		//---------------------------- APPEON END ----------------------------
	
		IF li_row_cnt < 1 THEN
			ll_seq_no = 1 
		ELSE
			ll_seq_no = lds_last_verif_seq_no.GetItemNumber( 1, "last_seq_no" ) + 1
		END IF
		if isnull(ll_seq_no) then 	ll_seq_no = 1	//maha 091900
		//<add> 06/28/2007 by: Andy.
		li_facility_id_first = li_facility_id
	end if
	//end of add
	lds_detail.SetItem( li_nr, "seq_no", ll_seq_no )
		
	lds_detail.SetItem( li_nr, "screen_id", al_screen_id )
	lds_detail.SetItem( li_nr, "reference_value",MidA(as_reference,1,100)) //maha added mid 022504 as trap for overlong values.as_reference )
	lds_detail.SetItem( li_nr, "expiration_date", adt_exp_date )
	lds_detail.SetItem( li_nr, "screen_name", as_screen_name )
	lds_detail.SetItem( li_nr, "address_lookup_code", al_address_lookup_code )
	ls_doc_id = String( al_rec_id ) + "-" + String( al_prac_id ) + "-" + String( li_facility_id ) +  "-" + String( ll_seq_no )
	lds_detail.SetItem( li_nr, "doc_id", ls_doc_id )
	//Start Code Change ----08.03.2011 #V11 maha - set created values
	lds_detail.SetItem(li_nr, 'create_date', datetime(today(),now()))
	lds_detail.SetItem(li_nr, 'create_user', gs_user_id + "-N")
	//End Code Change ----08.03.2011 
	//Start Code Change ----12.19.2012
	if not isnull( ll_fee ) then
		lds_detail.SetItem( li_nr, "verif_info_fee", ll_fee )
	end if
	//End Code Change ----12.19.2012
//debugbreak()
	//\/maha added for pix last updated 041801
	//check to see if letter should be duplicated
	li_dupe_check = 0
	ll_i = lds_facility.Find( "facility_id = " + String(li_facility_id) ,1 , lds_facility.Rowcount())
	If ll_i > 0 Then li_dupe_check = lds_facility.GetItemNumber(ll_i,"dupeset")
	//---------------------------- APPEON END ----------------------------
	//if so, create second letter
	if li_dupe_check = 1 then
		if al_screen_id = 7 or al_screen_id = 10 then
			ls_appt_type = lds_ver_orgs_facilities.GetItemString( 1, "apptmnt_type" )
			if ls_appt_type = "I"   then
				li_nr2 = lds_detail.InsertRow( 0 )
				lds_detail.SetItem( li_nr2, "prac_id", al_prac_id )
				lds_detail.SetItem( li_nr2, "rec_id", al_rec_id )
				lds_detail.SetItem( li_nr2, "verif_info_facility_id", li_facility_id )
				lds_detail.SetItem( li_nr2, "priority_user", ls_priority_user )
				lds_detail.SetItem( li_nr2, "priority", li_priority )
				lds_detail.SetItem( li_nr2, "number_sent", 0 )
				lds_detail.SetItem( li_nr2, "exp_credential_flag", 0)
				IF li_rsp_rc = 1 THEN
					lds_detail.SetItem( li_nr2, "response_code", lds_dfl_rsp_code.GetItemNumber( 1, "default_ver_response" ))
					lds_detail.SetItem( li_nr2, "user_name", ls_priority_user )
					lds_detail.SetItem( li_nr2, "date_recieved", Today() )
					lds_detail.SetItem( li_nr2, "verification_method", ll_hc_code )				
				ELSE
					lds_detail.SetItem( li_nr2, "verification_method", ll_default_verif_method )		
				END IF
	
				ll_seq_no++	
				lds_detail.SetItem( li_nr2, "seq_no", ll_seq_no )
				lds_detail.SetItem( li_nr2, "screen_id", al_screen_id )
				lds_detail.SetItem( li_nr2, "reference_value", as_reference )
				lds_detail.SetItem( li_nr2, "expiration_date", adt_exp_date )
				ls_screen_name = as_screen_name + "_CC" 
				lds_detail.SetItem( li_nr2, "screen_name", ls_screen_name )
				lds_detail.SetItem( li_nr2, "verification_id", 2 )
				lds_detail.SetItem( li_nr2, "address_lookup_code", al_address_lookup_code )
				ls_doc_id = String( al_rec_id ) + "-" + String( al_prac_id ) + "-" + String( li_facility_id ) +  "-" + String( ll_seq_no )
				lds_detail.SetItem( li_nr2, "doc_id", ls_doc_id )
				//Start Code Change ----01.07.2014 #V14 maha - set created values
				lds_detail.SetItem(li_nr2, 'create_date', datetime(today(),now()))
				lds_detail.SetItem(li_nr2, 'create_user', gs_user_id + "-N")
				//End Code Change ----01.07.2014
			end if
		end if
	end if		
	//\maha
END FOR

IF ib_object_created THEN
	dw_detail.SetFocus()
	dw_detail.ScrollToRow( li_nr )
	dw_detail.SetRow( li_nr )
END IF

DESTROY lds_ver_orgs_facilities
DESTROY lds_parent_facilities
DESTROY lds_verif_facilities
DESTROY lds_last_verif_seq_no
DESTROY lds_dfl_rsp_code
//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 08.23.2007 By: Evan
//$<Reason> Need to destroy object.
if IsValid(lds_pd_hosp_facility_link) then Destroy lds_pd_hosp_facility_link
//---------------------------- APPEON END ----------------------------

If lds_detail.ModifiedCount( ) > 0 Then
	resp = lds_detail.Update()
	if resp < 1 then  //Start Code Change ----08.31.2011 #V11 maha - trap added
		messagebox("Update failure in of_add_record (verification object)", "Verification not created.")
	end if
End If
Destroy lds_detail //Add by Evan 01.07.2010


RETURN 1

//---------------------------- APPEON END ----------------------------

end function

public function integer of_update_reference (string as_reference, long al_rec_id, long al_address_lookup_code, datetime adt_exp_dt, integer ai_screen, integer ai_data_status, long al_method);//Start Code Change ----08.01.2008 #V85 maha - changed to call new function in pfc_n_cst_ai_action_items
of_create_inv_action_items( )//Start Code Change ----10.22.2008 #V85 maha - added function call
inv_action_items.of_update_reference(  as_reference, al_rec_id, al_address_lookup_code, adt_exp_dt, ai_screen, ai_data_status, al_method)

//Integer li_row
//string ls_ref
//
//ls_ref = mid(as_reference,1,100) //maha added 022504 as trap for overlong values.
//
//UPDATE verif_info  
//SET reference_value = :ls_ref,
//	 address_lookup_code = :al_address_lookup_code,
//	 expiration_date = :adt_exp_dt
//WHERE verif_info.rec_id = :al_rec_id  AND
//		verif_info.screen_id = :ai_screen and //Start Code Change ----04.22.2008 #V8 maha - added so if there is a duplicate the value will not be overwritten
//		verif_info.active_status = 1;
//IF SQLCA.SQLCODE <> 0 THEN
//	MessageBox("Update Error", "Error updating reference value on verif_info table.")
//	Return -1
//END IF
//End Code Change---08.01.2008

of_retrieve_detail( dw_orgs_facilities.GetRow())

RETURN 0
end function

public function integer of_add_single_verif (long al_prac_id, long al_rec_id, long al_screen_id, string as_reference, datetime adt_exp_date, string as_screen_name, long al_address_lookup_code, string as_add_type, integer ai_data_status, long al_method);//Start Code Change ----08.01.2008 #V85 maha - added as_data_status argument
// this function created to allow verifications to be created after dataentry separated from of_add_record function 03-01 maha
Integer li_nr
Integer li_row_cnt
Integer li_rc
Integer i
Integer r
Integer ll_hc_code
Integer li_priority
Integer li_ver_priority //maha 090309
Integer li_dupe_check
Integer li_nr2
Integer li_date_check
Integer resp
Integer li_rsp_rc
Integer li_facility_id
Integer li_parent_id //maha 020901
Integer li_fac_ids//maha 011001
Integer pc//maha 011001
Integer Pi//maha 011001
Integer li_end_year//maha 012301
Integer li_end_month//maha 012301
Integer li_end_day// maha 031201
Integer li_check_back_years
Integer li_isprime //maha 010901
Integer li_prime_check//maha 012201
Integer li_complete //maha 031210
long ll_verif_response
Long ll_default_verif_method
Long ll_seq_no
Long ll_lookup_verif_method  //maha 02.21.2013

//long ll_compl_method //031210
String ls_identifying_number
String ls_doc_id
String ls_priority_user
String ls_ver_priority_user //maha 090309
String ls_screen_name //maha 010401
String ls_appt_type = "R" //maha 012401
String ls_primary_check //maha 010901
DateTime ld_verifdate
Date ld_hosp_check_date //maha 012201
Date ld_data_check_date//maha 031501
double ll_fee
n_ds lds_ver_orgs_facilities
n_ds lds_last_verif_seq_no
n_ds lds_dfl_rsp_code
n_ds lds_detail //Add By Jervis 2008-11-05 


If al_address_lookup_code = 0 Then
	SetNull( al_address_lookup_code )
End If

//Start Code Change ----12.19.2012 #V12 maha
if not(isnull(al_address_lookup_code)) then
	select fee, verif_method into :ll_fee, :ll_lookup_verif_method from address_lookup where lookup_code = : al_address_lookup_code;
	if isnull(ll_lookup_verif_method) then ll_lookup_verif_method = 0 //Start Code Change ----02.21.2013 #V12 maha = added method
	//ll_fee = double(gnv_data.of_getitem("address_lookup","fee","lookup_code = " + string(al_address_lookup_code ) ) )
end if

if ll_fee = 0 then
	setnull( ll_fee )
end if
//End Code Change ----12.19.2012

ls_identifying_number = MidA( as_reference, PosA( as_reference, "-") + 2, 100 )

//Start code By Jervis 11-05-2008
//For IntelliApp Module,The object is not instantiation
lds_detail = Create n_ds
lds_detail.DataObject = dw_detail.DataObject
lds_detail.of_SetTransObject( SQLCA )
If ib_object_created Then
	dw_detail.ShareData(lds_detail )
End If
//End code By Jervis 11-05-2008

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-24
//$<add> 02.20.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
gnv_appeondb.of_startqueue()
//---------------------------- APPEON END ----------------------------

lds_dfl_rsp_code = Create n_ds
lds_dfl_rsp_code.DataObject = "d_app_audit_get_hc_dflt_ver_resp_code"
lds_dfl_rsp_code.of_SetTransObject( SQLCA )
li_rsp_rc = lds_dfl_rsp_code.Retrieve( al_prac_id, al_screen_id, ls_identifying_number )

lds_ver_orgs_facilities = Create n_ds
lds_ver_orgs_facilities.DataObject = "d_verifying_orgs_facilities_p"
lds_ver_orgs_facilities.of_SetTransObject( SQLCA )
li_rc = lds_ver_orgs_facilities.Retrieve( ii_facility_id, al_prac_id, al_screen_id )
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-25 
//$<add> 02.20.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
gnv_appeondb.of_commitqueue()
li_rsp_rc = lds_dfl_rsp_code.RowCount()
li_rc = lds_ver_orgs_facilities.RowCount()
//---------------------------- APPEON END ----------------------------

If li_rc = 0 Then
	MessageBox("Retrieve Error in of_add_single_verif of pfc_cst_u_verification_info", "No affiliation status records found, or Facility verification rule is missing." ) //+ "  facility =" + string(ii_facility_id) + "  prac =" + string(al_prac_id) + "  Screen =" + string(al_screen_id))
	//MessageBox("Error", "This practitioner is not in the verification process, therefore no verification records can be added." )
	Return -1
End If
If li_rc > 1 Then
	MessageBox("Retrieve Error in of_add_single_verif of pfc_cst_u_verification_info", "You have more than 1 Active or Pending Appointment record for this Practitioner and Facility.  Correct before continuing." ) //+ "  facility =" + string(ii_facility_id) + "  prac =" + string(al_prac_id) + "  Screen =" + string(al_screen_id))
	//MessageBox("Error", "This practitioner is not in the verification process, therefore no verification records can be added." )
	Return -1
End If
li_facility_id = lds_ver_orgs_facilities.GetItemNumber( 1, "verifying_facility" )
//find out the last seq no used
lds_last_verif_seq_no = Create n_ds
lds_last_verif_seq_no.DataObject = "d_last_verif_seq_no"
lds_last_verif_seq_no.of_SetTransObject( SQLCA )
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-26 
//$<add> 02.20.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
gnv_appeondb.of_startqueue()
//---------------------------- APPEON END ----------------------------
li_row_cnt = lds_last_verif_seq_no.Retrieve( al_rec_id, al_prac_id, li_facility_id )	//moved out of loop maha 011703

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-27 
//$<add> 02.20.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
//check to see if letter should be duplicated
Select dupeset
	Into :li_dupe_check
	From facility
	Where facility_id = :li_facility_id;
gnv_appeondb.of_commitqueue()
li_row_cnt = lds_last_verif_seq_no.RowCount()
//---------------------------- APPEON END ----------------------------

If li_row_cnt < 1 Then
	ll_seq_no = 0
Else
	ll_seq_no = lds_last_verif_seq_no.GetItemNumber( 1, "last_seq_no" )
	If IsNull(ll_seq_no) Then 	ll_seq_no = 0
End If

//Start Code Change ----08.31.2011 #V11 maha - modifed for other verification
If as_screen_name = "NPDB Results" Then
	ll_default_verif_method = 17
Else
	If lds_ver_orgs_facilities.GetItemString( 1, "verify_data" ) = "N" And as_add_type = "A" Then
		Return -1 //CONTINUE
	End If
	if al_method = -1 then
		ll_default_verif_method = lds_ver_orgs_facilities.GetItemNumber( 1, "default_verif_means" )
		//Start Code Change ----02.21.2013 #V12 maha  -set value from lookup record
		if ll_lookup_verif_method > 0 then //0 = no method in lookup record
			ll_default_verif_method = ll_lookup_verif_method
		end if
		//Start Code Change ----02.21.2013		
	else
		ll_default_verif_method = al_method
	end if
End If
//Start Code Change ----08.31.2011

li_nr = lds_detail.InsertRow( 0 )

ls_priority_user = lds_ver_orgs_facilities.GetItemString( 1, "priority_user" )
//Start Code Change ----09.03.2009 #V92 maha - modify to set to assigned and priority properly
if isnull(ls_priority_user ) or LenA(ls_priority_user ) < 1 then ls_priority_user = "PUBLIC" 

//------------------- APPEON BEGIN -------------------
//$<modify> Evan 09.22.2009
//$<reason> Invalid DataWindow row.
/*
li_priority = lds_ver_orgs_facilities.GetItemNumber( r, "priority" ) //from appointment
li_ver_priority = lds_ver_orgs_facilities.GetItemNumber( r, "facility_ver_rules_priority" ) //from rules
ls_ver_priority_user = lds_ver_orgs_facilities.GetItemString( r, "facility_ver_rules_priority_user") //from rules
*/
li_priority = lds_ver_orgs_facilities.GetItemNumber(1, "priority" ) //from appointment
li_ver_priority = lds_ver_orgs_facilities.GetItemNumber(1, "facility_ver_rules_priority" ) //from rules
ls_ver_priority_user = lds_ver_orgs_facilities.GetItemString(1, "facility_ver_rules_priority_user") //from rules
//------------------- APPEON END ---------------------

//Start Code Change ----03.12.2010 #V10 maha - get settings for auto complete
li_complete = lds_ver_orgs_facilities.GetItemNumber(1, "compl_at_create" ) //from rules
ll_verif_response = lds_ver_orgs_facilities.GetItemNumber(1, "compl_default" ) //from rules
//if isnull(ll_verif_response) then li_complete = 0 //if no respomse code don't complete
if isnull(ll_verif_response) or ll_verif_response = 0 then li_complete = 0 // long.zhang 07.03.2012 conflicted with the FOREIGN KEY constraint "FK_verif_info1"
if li_complete = 1 then //for this function ask if verification should be completed
	resp = messagebox("Complete Verification","Your Verification rule setting for complete as created is turned on.~r~rDo you wish to complete this verification?",Question!,yesno!,1)
	if resp = 2 then  li_complete = 0
end if
//End Code Change---03.12.2010

//set Assigned a) from verif rules; b) from appointment; c) PUBLIC
if isnull(ls_ver_priority_user ) or LenA(ls_ver_priority_user ) < 1 then
	//use the user from the appointment
else
	ls_priority_user = ls_ver_priority_user
end if
//set priority
if isnull(li_ver_priority) or li_ver_priority  < 1 then
	//use the user from the appointment
else
	li_priority = li_ver_priority
end if
//End Code Change---09.03.2009

lds_detail.SetItem( li_nr, "prac_id", al_prac_id )
lds_detail.SetItem( li_nr, "rec_id", al_rec_id )
//lds_detail.SetItem( li_nr, "facility_id", li_facility_id )
lds_detail.SetItem( li_nr, "verif_info_facility_id", li_facility_id )
lds_detail.SetItem( li_nr, "priority_user", ls_priority_user )
lds_detail.SetItem( li_nr, "priority", li_priority )
lds_detail.SetItem( li_nr, "number_sent", 0 )
lds_detail.SetItem( li_nr, "exp_credential_flag", 0)
lds_detail.SetItem( li_nr, "verification_method", ll_default_verif_method )
//Start By Jervis 11-25-2008
//By Robert:In an IntelliApp-only system, users never see the verifications except for Exp Cred 
//Ltr items, so when the verification record is created using Verify Cred, they need to have the 
//response_code field set for them
IF Upper( gs_cust_type ) = 'I' THEN 
	li_complete = 1  //Start Code Change ----03.12.2010 #V10 maha change to variable (from setting the value) setting below
	ll_verif_response = 326 //if intelliapp, always set to complete the verification
end if
//End By Jervis 11-25-2008

ll_seq_no++
lds_detail.SetItem( li_nr, "seq_no", ll_seq_no )
lds_detail.SetItem( li_nr, "screen_id", al_screen_id )
lds_detail.SetItem( li_nr, "reference_value", MidA(as_reference,1,100)) //maha added 022504 as trap for overlong values.
lds_detail.SetItem( li_nr, "expiration_date", adt_exp_date )
lds_detail.SetItem( li_nr, "screen_name", as_screen_name )
lds_detail.SetItem( li_nr, "address_lookup_code", al_address_lookup_code )
lds_detail.SetItem( li_nr, "verif_info_data_status", ai_data_status ) //Start Code Change ----08.01.2008 #V85 maha - set data_status
ls_doc_id = String( al_rec_id ) + "-" + String( al_prac_id ) + "-" + String( li_facility_id ) +  "-" + String( ll_seq_no )
//messagebox("docid",ls_doc_id)
lds_detail.SetItem( li_nr, "doc_id", ls_doc_id )

//Start Code Change ----08.03.2011 #V11 maha - set create values 
resp = lds_detail.SetItem(  li_nr, "create_user", gs_user_id + "-M" )
resp = lds_detail.SetItem(  li_nr, "create_date", datetime(today(),now()) )
//End Code Change ----08.03.2011

//Start Code Change ----08.01.2008 #V85 maha - complete verification if intelliapp
//If gs_cust_type = "I" Then
If li_complete = 1 Then  //Start Code Change ----03.12.2010 #V10 maha
	lds_detail.SetItem( li_nr, "response_code", ll_verif_response )
	ld_verifdate = DateTime( Today(), Now() )
	lds_detail.SetItem( li_nr, "date_recieved", ld_verifdate )
	lds_detail.SetItem( li_nr, "user_name", gs_user_id )
	If ai_data_status = 2 Then lds_detail.SetItem( li_nr, "exp_credential_flag", 2)
End If
//End Code Change---08.01.2008

//Start Code Change ----12.19.2012 - set the default value of the fee
if not isnull( ll_fee ) then
	lds_detail.SetItem( li_nr, "verif_info_fee", ll_fee )
end if
//End Code Change ----12.19.2012

//check to see if letter should be duplicated
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-28 
//$<comment> 02.20.2006 By: Cao YongWang
//$<reason> Performance tuning. 
//$<modification> Move the following script move to PT-27. It is integrated
//$<modification> into Appeon Queue labels with other SQL statements to recuce
//$<modification> client-server interactions.
	/*
	select dupeset
	into :li_dupe_check
	from facility
	where facility_id = :li_facility_id;
*/
//---------------------------- APPEON END ----------------------------
//if so, create second letter
If li_dupe_check = 1 Then
	If al_screen_id = 7 Or al_screen_id = 10 Then
		ls_appt_type = lds_ver_orgs_facilities.GetItemString( 1, "apptmnt_type" )
		If ls_appt_type = "I" Then
			//resp = messagebox("Adding Verification","Do you wish to add the Second letter Verification Item for this record.",Question!,yesno!,2)
			//if resp = 1 then
			li_nr2 = lds_detail.InsertRow( 0 )
			lds_detail.SetItem( li_nr2, "prac_id", al_prac_id )
			lds_detail.SetItem( li_nr2, "rec_id", al_rec_id )
			lds_detail.SetItem( li_nr2, "verif_info_facility_id", li_facility_id )
			lds_detail.SetItem( li_nr2, "priority_user", ls_priority_user )
			lds_detail.SetItem( li_nr2, "priority", li_priority )
			lds_detail.SetItem( li_nr2, "number_sent", 0 )
			lds_detail.SetItem( li_nr2, "exp_credential_flag", 0)
			If li_rsp_rc = 1 Then
				lds_detail.SetItem( li_nr2, "response_code", lds_dfl_rsp_code.GetItemNumber( 1, "default_ver_response" ))
				lds_detail.SetItem( li_nr2, "user_name", ls_priority_user )
				lds_detail.SetItem( li_nr2, "date_recieved", Today() )
				lds_detail.SetItem( li_nr2, "verification_method", ll_hc_code )
			Else
				lds_detail.SetItem( li_nr2, "verification_method", ll_default_verif_method )
			End If
			
			ll_seq_no++
			lds_detail.SetItem( li_nr2, "seq_no", ll_seq_no )
			lds_detail.SetItem( li_nr2, "screen_id", al_screen_id )
			lds_detail.SetItem( li_nr2, "reference_value", as_reference )
			lds_detail.SetItem( li_nr2, "expiration_date", adt_exp_date )
			ls_screen_name = as_screen_name + "_CC" //was _aa 020802
			lds_detail.SetItem( li_nr2, "screen_name", ls_screen_name )
			lds_detail.SetItem( li_nr2, "verification_id", 2 )
			lds_detail.SetItem( li_nr2, "address_lookup_code", al_address_lookup_code )
			ls_doc_id = String( al_rec_id ) + "-" + String( al_prac_id ) + "-" + String( li_facility_id ) +  "-" + String( ll_seq_no )
			lds_detail.SetItem( li_nr2, "doc_id", ls_doc_id )
			//Start Code Change ----08.05.2011 #V11 maha - set create values 
			lds_detail.SetItem(  li_nr2, "create_user", gs_user_id + "-M" )
			lds_detail.SetItem(  li_nr2, "create_date", datetime(today(),now()) )
			//End Code Change ----08.05.2011
		End If
		//end if
	End If
End If
//next	

If ib_object_created Then
	dw_detail.SetFocus()
	dw_detail.ScrollToRow( li_nr )
	dw_detail.SetRow( li_nr )
End If

lds_detail.Update()

Destroy lds_ver_orgs_facilities
Destroy lds_last_verif_seq_no
Destroy lds_dfl_rsp_code
Destroy lds_detail


Return 1








end function

public function integer of_set_button_enabled ();//Start Code Change ----03.28.2012 #V12 maha - added for button control
Integer li_rc
Integer i
Integer li_print_cnt,li_corro_cnt
integer li_letter = 0
integer li_web = 0
integer li_npdb = 0
integer li_oig = 0
Long ll_ver_method_ver_ltr1
Long ll_ver_method_ver_ltr2
Long ll_ver_method_ver_ltr3
Long ll_ver_method_ver_ltr4
Long ll_ver_method_ver_ltr5
Long ll_ver_method_ver_ltr6 //maha 05.30.2013
long ll_web_method
long ll_npdb_method
long ll_oig_method
long ll_verif_method_rec
integer li_flag //maha 09.10.2012


long ll_wf_id  //12.5.2006 By Jervis

ll_ver_method_ver_ltr1 = Long(gnv_data.of_getitem("code_lookup" , "lookup_code" , "upper(lookup_name)='" + Upper('verification method') + "' and upper(code)='" + Upper('verif ltr') + "'"))
ll_ver_method_ver_ltr2 = Long(gnv_data.of_getitem("code_lookup" , "lookup_code" , "upper(lookup_name)='" + Upper('verification method') + "' and upper(code)='" + Upper('exp cred ltr') + "'"))
ll_ver_method_ver_ltr3 = Long(gnv_data.of_getitem("code_lookup" , "lookup_code" , "upper(lookup_name)='" + Upper('verification method') + "' and upper(code)='" + Upper('exp appt ltr') + "'"))
ll_ver_method_ver_ltr4 = Long(gnv_data.of_getitem("code_lookup" , "lookup_code" , "upper(lookup_name)='" + Upper('verification method') + "' and upper(code)='" + Upper('fax') + "'"))
ll_ver_method_ver_ltr5 = Long(gnv_data.of_getitem("code_lookup" , "lookup_code" , "upper(lookup_name)='" + Upper('verification method') + "' and upper(code)='" + Upper('MISS ITEM 90') + "'"))
ll_ver_method_ver_ltr6 = Long(gnv_data.of_getitem("code_lookup" , "lookup_code" , "upper(lookup_name)='" + Upper('verification method') + "' and upper(code)='" + Upper('Prac Corre') + "'"))  //Start Code Change ----05.30.2013 #V14 maha
ll_oig_method = long(gnv_data.of_getitem("code_lookup","lookup_code","upper(lookup_name)='" + upper('Verification Method')   + "' and upper(code) = '" + 'OIG QUERY' + "'"))
ll_web_method = long(gnv_data.of_getitem("code_lookup","lookup_code","upper(lookup_name) = upper('Verification Method') AND upper(code) = 'WEB'" ))
//ll_npdb_method = long(gnv_data.of_getitem("code_lookup","lookup_code","upper(lookup_name) = upper('Verification Method') AND upper(code) = 'NPDB Query'" ))
ll_npdb_method = long(gnv_data.of_getitem("code_lookup","lookup_code","upper(lookup_name) = upper('Verification Method') AND upper(code) = 'NPDB QUERY'" ))	//long.zhang 06.21.2012

li_rc = dw_detail.RowCount()
//debugbreak()
IF w_mdi.of_security_access( 150 ) = 0 or w_mdi.of_security_access(40) < 2 or w_mdi.of_security_access(140) < 2 then
	li_letter = 0
	li_npdb = 0
	li_web = 0
	li_oig = 0
//Start Code Change ----09.10.2012 #V12 maha  - modified code for npdb to stay enabled - and to look at response code
ELSE
	For i = 1 To li_rc
		If isnull(dw_detail.GetItemNumber( i, "response_code" ))  Then
			ll_verif_method_rec = dw_detail.GetItemNumber( i, "verification_method" )
			li_flag = dw_detail.GetItemNumber( i, "print_flag" )
			if ll_verif_method_rec = ll_ver_method_ver_ltr1 and li_flag = 1 then
				li_letter++
			elseif ll_verif_method_rec = ll_ver_method_ver_ltr2 and  li_flag = 1 then
				li_letter++
			elseif ll_verif_method_rec = ll_ver_method_ver_ltr3 and  li_flag = 1 then
				li_letter++
			elseif ll_verif_method_rec = ll_ver_method_ver_ltr4 and  li_flag = 1 then
				li_letter++
			elseif ll_verif_method_rec = ll_ver_method_ver_ltr5 and  li_flag = 1 then
				li_letter++
			//Start Code Change ----05.30.2013 #V14 maha
			elseif ll_verif_method_rec = ll_ver_method_ver_ltr6 and  li_flag = 1 then
				li_letter++	
			//End Code Change ----05.30.2013	
			elseif ll_verif_method_rec = ll_oig_method and  li_flag = 1 then
				li_oig++
			elseif ll_verif_method_rec = ll_npdb_method then
				li_npdb++
			elseif ll_verif_method_rec = ll_web_method and  li_flag = 1 then
				li_web++
			end if
		end if
	Next
END if
//End Code Change ----09.10.2012

if not isvalid(w_prac_data_1) then w_prac_data_1 =w_mdi.getActiveSheet() //add Michael 05.07.2012 System Error:Null object reference
if li_letter > 0 then
	w_prac_data_1.cb_b4.enabled = true
else
	w_prac_data_1.cb_b4.enabled = false
end if

if li_web > 0 then
	w_prac_data_1.cb_b5.enabled = true
else
	w_prac_data_1.cb_b5.enabled = false
end if

if li_npdb > 0 then
	w_prac_data_1.cb_b6.enabled = true
else
	w_prac_data_1.cb_b6.enabled = false
end if

if li_oig > 0 then
	w_prac_data_1.cb_b7.enabled = true
else
	w_prac_data_1.cb_b7.enabled = false
end if


return 1
end function

public function integer of_post_resize ();//Start Code Change ----08.10.2012 #V12 maha - created

//filter group boxes
dw_select_screen.x =  dw_orgs_facilities.width + 70
gb_type.x = dw_select_screen.x + 840
gb_response_stat.x =  dw_select_screen.x + 1717
rb_stat_both.x = dw_select_screen.x + 1417
rb_stat_hist.x = dw_select_screen.x + 1138
rb_stat_active.x = dw_select_screen.x + 869
//rb_ver_stat_both.x = dw_select_screen.x + 2441
rb_ver_stat_both.x = dw_select_screen.x + 2460 //Modified by Appeon long.zhang 01.25.2016 (BugL012501)
//rb_ver_impcompl.x = dw_select_screen.x + 2071
rb_ver_impcompl.x = dw_select_screen.x +2091 //Modified by Appeon long.zhang 01.25.2016 (BugL012501)
rb_ver_compl.x = dw_select_screen.x + 1737
dw_select_screen.y = tab_view.y + 130
gb_type.y = dw_select_screen.y
gb_response_stat.y = dw_select_screen.y


//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 01.06.2016
//<$>reason:BugL010601
dw_detail.y = dw_select_screen.y + dw_select_screen.height + 12
dw_detail.height = tab_view.height - dw_select_screen.height - 170
dw_detail.width = tab_view.width - dw_orgs_facilities.width - 44  //Start Code Change ----02.08.2016 #V15 maha
//messagebox("tab view", tab_view.width)
//messagebox("dw_detail", dw_detail.width)

dw_browse.y = dw_detail.y
dw_browse.height = dw_detail.height
dw_browse.width = dw_detail.width  //Start Code Change ----02.08.2016 #V15 maha
dw_orgs_facilities.height = tab_view.height
//------------------- APPEON END -------------------
////Start Code Change ----12.21.2013 #V12 maha - added   ----01.28.2016 #V15 maha - moved and modified
tab_view.tabpage_recred.dw_recred_info.height =  dw_detail.height                 //tab_view.tabpage_recred.height - 20
tab_view.tabpage_recred.dw_recred_info.width = dw_detail.width                   //tab_view.tabpage_recred.width - 20
//E Code Change ----12.21.2013


return 1
end function

public function integer of_security ();//Start Code Change ----10.10.2012 #V12 maha - function created - calles from w_prac_data_1.tab_1.ue_setsecurity

IF w_mdi.of_security_access( 40 ) < 2 THEN // readonly
	dw_detail.Modify("verification_method.protect = '1'")
	dw_detail.Modify("verification_method.background.color= '553648127'")
	dw_detail.Modify("first_sent.protect = '1'")
	dw_detail.Modify("first_sent.background.color= '553648127'")
	dw_detail.Modify("last_sent.protect = '1'")
	dw_detail.Modify("last_sent.background.color= '553648127'")
	dw_detail.Modify("number_sent.protect = '1'")
	dw_detail.Modify("number_sent.background.color= '553648127'")
	dw_detail.Modify("due_date.protect = '1'")
	dw_detail.Modify("due_date.background.color= '553648127'")
	dw_detail.Modify("notes.protect = '1'")
	dw_detail.Modify("notes.background.color= '553648127'")
	dw_detail.Modify("priority.protect = '1'")
	dw_detail.Modify("priority.background.color= '553648127'")	
	dw_detail.Modify("priority_user.protect = '1'")
	dw_detail.Modify("priority_user.background.color= '553648127'")
	dw_detail.Modify("response_code.protect = '1'")
	//tab_1.tabpage_verif.uo_verif_summary.dw_detail.Modify("response_code.background.color= '553648127'") //Delete by Evan 01/21/2009---Use dw property express instead
	dw_detail.Modify("user_name.protect = '1'")
	dw_detail.Modify("user_name.background.color= '553648127'")
	dw_detail.Modify("date_recieved.protect = '1'")
	dw_detail.Modify("date_recieved.background.color= '553648127'")
	dw_detail.Modify("date_recieved.protect = '1'")
	dw_detail.Modify("date_recieved.background.color= '553648127'")
else
	//set priority
	IF w_mdi.of_security_access( 182 ) = 0 THEN
		dw_detail.Modify("priority.protect = '1'")
		dw_detail.Modify("priority.background.color= '553648127'")
	END IF
	//priority user
	IF w_mdi.of_security_access( 185 ) = 0 THEN
		dw_detail.Modify("priority_user.protect = '1'")
	dw_detail.Modify("priority_user.background.color= '553648127'")
	END IF	
		//post results
	IF w_mdi.of_security_access( 160 ) = 0 THEN
		dw_detail.Modify("response_code.protect = '1'")
		//tab_1.tabpage_verif.uo_verif_summary.dw_detail.Modify("response_code.background.color= '553648127'") //Delete by Evan 01/21/2009---Use dw property express instead
		dw_detail.Modify("user_name.protect = '1'")
		dw_detail.Modify("user_name.background.color= '553648127'")
		dw_detail.Modify("date_recieved.protect = '1'")
		dw_detail.Modify("date_recieved.background.color= '553648127'")
		dw_detail.Modify("date_recieved.protect = '1'")
		dw_detail.Modify("date_recieved.background.color= '553648127'")
	END IF
	
	//Start Code Change ----09.12.2012 #V12 maha - no edit functionality
	if  w_mdi.of_security_access( 7360 ) = 0 then //add but no edit
		dw_detail.Modify( "notes.protect = '1'" )
		dw_detail.Modify("notes.background.color= '553648127'")
	end if
	//End Code Change ----09.12.2012	
	
END IF

 //Start Code Change ----10.09.2015 #V15 maha
if  w_mdi.of_security_access( 7802 ) = 0 then //add but no edit
	cb_batch_ver.visible = False
end if

return 1
end function

public function integer of_batch_verif_view (); //Start Code Change ----10.28.2015 #V15 maha
 gs_pass_ids lst_data
 
lst_data.s_stringval = gs_user_id  //user
lst_data.l_app_id =  0  //batch
lst_data.ls_ref_value = "I" //incomplete

lst_data.prac_id = il_prac_id
lst_data.i_ids[1] = 0  //entity
lst_data.i_ids[2] = 0  //recid
lst_data.ls_from_window = "N"  //Y will show message (used for testing)

openwithparm(w_verif_scan_log_incompl,lst_data)

return 1
end function

public function integer of_filter_defaults (boolean ab_run_filter);//Start Code Change ----01.04.2016 #V15 maha - added to reset the radio buttons

rb_ver_impcompl.checked = true
rb_ver_stat_both.checked = false
rb_ver_compl.checked = false
rb_stat_active.checked = true
rb_stat_hist.checked = false
rb_stat_both.checked = false

rb_ver_impcompl.enabled = true
rb_ver_stat_both.enabled = true
rb_ver_compl.enabled = true

is_status_filter = "active_status = 1" 
is_verif_filter = "((isnull(verif_info_wf_id) and response_code = 0 or IsNull(response_code)) or (verif_info_wf_complete_flag = 'N'))" 

if ab_run_filter then
	of_ver_filter()
end if



return 1
end function

public function integer of_ama_api ();//Start Code Change ----05.31.2016 #V152 maha
Integer li_cr
integer cnt
integer res
integer li_sent
datetime ldt_now
String ls_note
String ls_docids[]
Long ll_pracid[]
long ll_method

ll_method = -570 // long(gnv_data.of_getitem("code_lookup","lookup_code","lookup_code = -570" ))

dw_detail.SetFilter( "verification_method = " + String( ll_method) + " and active_status = 1 and isnull(response_code)")
dw_detail.Filter( )

if dw_detail.rowcount() = 0 then return 1
//for cnt = 1 to dw_detail.rowcount()
ls_docids[1] = dw_detail.getitemstring(1,"doc_id")
ll_pracid[1] = dw_detail.getitemnumber(1, "prac_id")

ldt_now = datetime(today(), Now())
	
res = inv_printletters.of_ama_profile( ll_pracid[] , ls_docids[] , true, "V", 0)

if res = 1 then
	ls_note = dw_detail.getitemstring(1,"notes")
	if len(ls_note) > 0 then 
		ls_note = "AMA API Profile " + string(today()) + " - " + ls_note
	else
		ls_note = "AMA API Profile " + string(today())
	end if
	
	dw_detail.setitem(1, "notes", ls_note) 
	dw_detail.setitem(1, "last_sent", ldt_now) 
	
	if isnull(dw_detail.getitemdatetime(1,"first_sent")) then dw_detail.setitem(1,"first_sent",ldt_now)

	li_sent = dw_detail.getitemnumber(1,"number_sent")
	if isnull(li_sent) then
		dw_detail.setitem(1 ,"number_sent",1)
	else
		li_sent++
		dw_detail.setitem(1,"number_sent",li_sent)
	end if
	dw_detail.setitem(1,"print_flag",0)
	
	dw_detail.setitem(1,"mod_user", gs_user_id )
	dw_detail.setitem(1,"mod_date", ldt_now )
else
	ls_note = dw_detail.getitemstring(1,"notes")
	if len(ls_note) > 0 then 
		ls_note = "FAILED: AMA API Profile " + string(today()) + " - " + ls_note
	else
		ls_note = "FAILED: AMA API Profile " + string(today())
	end if	
	
	dw_detail.setitem(1,"mod_user", gs_user_id )
	dw_detail.setitem(1,"mod_date", ldt_now )
//	dw_verifs.setitem(f,"date_recieved",datetime(today(),now()))
//	dw_verifs.setitem(f,"user_name",gs_user_id)
//	dw_verifs.setitem(f,"response_code",ll_code)
//	dw_verifs.setitem(f,"user_name",gs_user_id)
	
end if		

dw_detail.update()

of_Retrieve_Detail( dw_orgs_facilities.GetRow() )
of_ver_filter()

return 1
end function

public function integer of_get_ama_verifs (long al_facil);//Start Code Change ----10.20.2016 #V153 maha - added function called from clicked event of dw_detail
long li_facil
gs_pass_ids lst_ids

li_facil = al_facil   ///// dw_orgs_facilities.GetItemNumber( dw_orgs_facilities.getrow()  , "verifying_facility" )
lst_ids.facility_id = li_facil
lst_ids.sl_prac_ids[1]  = il_prac_id

openwithparm(w_ama_verifications, lst_ids)

return 1
end function

public subroutine of_zoom ();//Start Code Change ----07.13.2017 #V154 maha
dw_browse.Modify("DataWindow.Zoom=" + string(gi_zoom))  
dw_detail.Modify("DataWindow.Zoom=" + string(gi_zoom))
dw_orgs_facilities.Modify("DataWindow.Zoom=" + string(gi_zoom))  
tab_view.tabpage_recred.dw_recred_info.Modify("DataWindow.Zoom=" + string(gi_zoom))  

end subroutine

on pfc_cst_u_verification_info.create
this.cb_batch_ver=create cb_batch_ver
this.p_1=create p_1
this.rb_stat_hist=create rb_stat_hist
this.st_recs=create st_recs
this.gb_type=create gb_type
this.gb_response_stat=create gb_response_stat
this.rb_ver_stat_both=create rb_ver_stat_both
this.rb_ver_impcompl=create rb_ver_impcompl
this.rb_ver_compl=create rb_ver_compl
this.rb_stat_both=create rb_stat_both
this.rb_stat_active=create rb_stat_active
this.dw_orgs_facilities=create dw_orgs_facilities
this.dw_select_screen=create dw_select_screen
this.tab_view=create tab_view
this.dw_detail=create dw_detail
this.dw_browse=create dw_browse
this.Control[]={this.cb_batch_ver,&
this.p_1,&
this.rb_stat_hist,&
this.st_recs,&
this.gb_type,&
this.gb_response_stat,&
this.rb_ver_stat_both,&
this.rb_ver_impcompl,&
this.rb_ver_compl,&
this.rb_stat_both,&
this.rb_stat_active,&
this.dw_orgs_facilities,&
this.dw_select_screen,&
this.tab_view,&
this.dw_detail,&
this.dw_browse}
end on

on pfc_cst_u_verification_info.destroy
destroy(this.cb_batch_ver)
destroy(this.p_1)
destroy(this.rb_stat_hist)
destroy(this.st_recs)
destroy(this.gb_type)
destroy(this.gb_response_stat)
destroy(this.rb_ver_stat_both)
destroy(this.rb_ver_impcompl)
destroy(this.rb_ver_compl)
destroy(this.rb_stat_both)
destroy(this.rb_stat_active)
destroy(this.dw_orgs_facilities)
destroy(this.dw_select_screen)
destroy(this.tab_view)
destroy(this.dw_detail)
destroy(this.dw_browse)
end on

event constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-33
//$<modify> 01.24.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Write script to retrieve data from a cache instead of from the database.

/*
SELECT code_lookup.lookup_code  
INTO :il_exp_appt_ltr
FROM code_lookup  
WHERE ( code_lookup.lookup_name = 'verification method' ) AND  
   	( code_lookup.code = 'EXP APPT LTR'  )   ;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox("SQL ERROR", SQLCA.SQLERRTEXT)
	RETURN -1
END IF
*/
il_exp_appt_ltr = long(gnv_data.of_getitem("code_lookup","lookup_name","upper(code) = '" + 'EXP APPT LTR' + "'" ))

ib_object_created = TRUE
//---------------------------- APPEON END ----------------------------

inv_printletters = create pfc_n_cst_ai_printletters //Start Code Change ----07.17.2008 #V85 maha
inv_action_items = create pfc_n_cst_ai_action_items //Start Code Change ----08.12.2008 #V85 maha

if of_get_app_setting("set_55","I") = 1 then ib_i_r_filter = true //Start Code Change ----09.30.2008 #V85 maha - for ccvs customization

of_zoom()  //Start Code Change ----07.13.2017 #V154 maha

end event

event destructor;destroy inv_printletters  //Start Code Change ----07.17.2008 #V85 maha
destroy inv_action_items  //Start Code Change ----08.12.2008 #V85 maha
end event

type cb_batch_ver from commandbutton within pfc_cst_u_verification_info
integer x = 2432
integer y = 8
integer width = 475
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "View Batch Verifs"
end type

event clicked;of_batch_verif_view()

end event

type p_1 from picture within pfc_cst_u_verification_info
boolean visible = false
integer x = 649
integer y = 44
integer width = 82
integer height = 64
boolean originalsize = true
string picturename = "arrowhead.png"
boolean focusrectangle = false
end type

type rb_stat_hist from radiobutton within pfc_cst_u_verification_info
integer x = 2126
integer y = 192
integer width = 270
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
string text = "History"
end type

event clicked;rb_ver_compl.Checked = True
rb_ver_stat_both.Checked = False
rb_ver_stat_both.Enabled = False
rb_ver_impcompl.Checked = False
rb_ver_impcompl.Enabled = False
rb_ver_compl.Checked = False
rb_ver_compl.Enabled = False
gb_response_stat.Enabled = False

is_verif_filter = ""

is_status_filter = "active_status = 0" 

of_ver_filter()
end event

type st_recs from statictext within pfc_cst_u_verification_info
integer x = 2990
integer y = 28
integer width = 357
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
string text = "Record 1 of 1"
boolean focusrectangle = false
end type

type gb_type from groupbox within pfc_cst_u_verification_info
integer x = 1819
integer y = 124
integer width = 818
integer height = 160
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 16777215
string text = "Record Type"
end type

type gb_response_stat from groupbox within pfc_cst_u_verification_info
integer x = 2665
integer y = 124
integer width = 987
integer height = 160
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 16777215
string text = "Response Status"
end type

type rb_ver_stat_both from radiobutton within pfc_cst_u_verification_info
integer x = 3415
integer y = 188
integer width = 219
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
string text = "Both"
end type

event clicked;is_verif_filter = "" 
of_ver_filter()
end event

type rb_ver_impcompl from radiobutton within pfc_cst_u_verification_info
integer x = 3049
integer y = 188
integer width = 347
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
string text = "Incomplete"
boolean checked = true
end type

event clicked;//Begin changes-16/11/2006 Henry
//is_verif_filter = "(response_code = 0 OR IsNull(response_code)) " 
is_verif_filter = "((isnull(verif_info_wf_id) and response_code = 0 or IsNull(response_code)) or (verif_info_wf_complete_flag = 'N'))" 
//End changes-16/11/2006 Henry
of_ver_filter()
end event

type rb_ver_compl from radiobutton within pfc_cst_u_verification_info
integer x = 2688
integer y = 188
integer width = 338
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
string text = "Completed"
end type

event clicked;//Begin changes-16/11/2006 Henry
//is_verif_filter = "(response_code <> 0 AND Not IsNull(response_code)) " 
is_verif_filter = "((isnull(verif_info_wf_id) and response_code <> 0 AND Not IsNull(response_code)) or (verif_info_wf_complete_flag = 'Y'))" 
//End changes-16/11/2006 Henry

of_ver_filter()
end event

type rb_stat_both from radiobutton within pfc_cst_u_verification_info
integer x = 2395
integer y = 192
integer width = 210
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
string text = "Both"
end type

event clicked;rb_stat_active.TriggerEvent( Clicked! )
rb_stat_hist.TriggerEvent( Clicked! )

rb_ver_stat_both.Enabled = True
rb_ver_impcompl.Enabled = True

//Changes for Work Flow. 1/11/2006 Henry
//Do not to show the items that created by work flow and the status is -1
//is_status_filter = "" 
is_status_filter = "(active_status = 0 or active_status = 1)" //is_status_filter = "active_status = 0 or active_status = 1" Modify by Michael 09.30.2011 --- Fixed Bug 2681 filter not working correctly
//End changes

of_ver_filter()
end event

type rb_stat_active from radiobutton within pfc_cst_u_verification_info
integer x = 1847
integer y = 192
integer width = 270
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
string text = "Current"
boolean checked = true
end type

event clicked;rb_ver_stat_both.Enabled = True
rb_ver_impcompl.Enabled = True
rb_ver_compl.Enabled = True

gb_response_stat.Enabled = True

IF rb_ver_compl.Checked = False AND rb_ver_impcompl.Checked = False AND rb_ver_stat_both.Checked = False THEN
	rb_ver_impcompl.Checked = True
	//Begin changes-16/11/2006 Henry
	//is_verif_filter = "(response_code = 0 OR IsNull(response_code)) " 
	is_verif_filter = "((isnull(verif_info_wf_id) and response_code = 0 or IsNull(response_code)) or (verif_info_wf_complete_flag = 'N'))" 
	//End changes-16/11/2006 Henry
	
END IF

is_status_filter = "active_status = 1" 
of_ver_filter()
end event

type dw_orgs_facilities from u_dw within pfc_cst_u_verification_info
integer x = 9
integer y = 8
integer width = 905
integer height = 1960
integer taborder = 30
string title = "Select Facility"
string dataobject = "d_pd_affil_status_orgs"
boolean hscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;Integer li_org_id
Integer li_facility_id

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-09-05 By: Scofield
//$<Reason> When multiple verifications are updated at once, the program throws an exception and crashes.
//if CurrentRow > 0 and CurrentRow <= This.RowCount() then
//	gi_parent_facility = This.GetItemNumber(CurrentRow,'parent_facility_id')
//end if
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-08
//$<modify> 01.24.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Make an condition to make the following script not to be executed 
//$<modification> when the value of ib_first_retrieved is TRUE. For more information
//$<modification> refer to PT-01.
//IF This.RowCount() > 0 THEN
IF This.RowCount() > 0 AND NOT ib_first_retrieved THEN
//---------------------------- APPEON END ----------------------------
	of_retrieve_detail( currentrow )
//	dw_browse.SelectRow( 0, False )   //Start Code Change ----01.20.2016 #V15 maha - removed
//	dw_browse.SelectRow(1, True)
END IF

if tab_view.selectedtab = 3 then
	tab_view.selecttab(2)
end if
end event

event clicked;call super::clicked;Integer li_row

li_row = This.GetClickedRow( )

IF li_row = 0 THEN
	dw_detail.SetFocus( )
	Return -1
END IF

//This.SelectRow( 0, False )   //Start Code Change ----01.20.2016 #V15 maha - removed
//This.SelectRow( li_row, True )
This.ScrollToRow( li_row )
This.SetRow( li_row )

ib_rmbmenu	= False
end event

event retrieveend;call super::retrieveend;of_get_this_facility_data()
end event

event constructor;call super::constructor;IF gs_cust_type = "C" THEN
	This.Title = 'Select Client'
ELSEIF gs_cust_type = "I" THEN
	This.Title = 'Select Payor/Hospital'
ELSE
	This.Title = 'Select Facility'
END IF
end event

type dw_select_screen from u_dw within pfc_cst_u_verification_info
integer x = 974
integer y = 124
integer width = 823
integer height = 172
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_select_screen"
boolean vscrollbar = false
boolean border = false
end type

event itemchanged;call super::itemchanged;IF data = "0" THEN
	is_view_filter = ""
//Start Code Change ----11.14.2012 #V12 maha	
Elseif  data = "-5" THEN  //exp cred
	is_view_filter = "verification_method = 10015"
//End Code Change ----11.14.2012
//Start Code Change ----05.30.2013 #V14 maha
Elseif  data = "-6" THEN  //Web
	is_view_filter = "verification_method = 16"
Elseif  data = "-7" THEN //all letters
	is_view_filter =  "verification_method = 15  or  verification_method = 10014 or  verification_method = -300 or  verification_method = 10015 or  verification_method = 10023"
//End Code Change ----05.30.2013
ELSE
	is_view_filter = "screen_id = " + data
END IF

of_ver_filter()
end event

event constructor;call super::constructor;this.object.datawindow.color = il_rgb  //Start Code Change ----07.31.2013 #V14 maha
end event

type tab_view from tab within pfc_cst_u_verification_info
event create ( )
event destroy ( )
integer x = 919
integer y = 8
integer width = 3378
integer height = 1968
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 32891346
boolean raggedright = true
integer selectedtab = 1
tabpage_browse tabpage_browse
tabpage_detail tabpage_detail
tabpage_recred tabpage_recred
end type

on tab_view.create
this.tabpage_browse=create tabpage_browse
this.tabpage_detail=create tabpage_detail
this.tabpage_recred=create tabpage_recred
this.Control[]={this.tabpage_browse,&
this.tabpage_detail,&
this.tabpage_recred}
end on

on tab_view.destroy
destroy(this.tabpage_browse)
destroy(this.tabpage_detail)
destroy(this.tabpage_recred)
end on

event selectionchanged;

If Upper(appeongetclienttype()) = "PB" Then
	if oldindex = 2 and newindex = 1 and ib_select = true then 
		ib_select = false
		selecttab(2)
		return
	end if
end if

IF newindex = 1 THEN
	dw_detail.Visible = False
	dw_browse.Visible = True
ELSEIF newindex = 2 THEN
	dw_browse.Visible = False
	dw_detail.Visible = True
	
	if ib_select1 = false then
		ib_select1 = true
		ib_select = true
	end if
	
ELSE
	Integer li_rc
	Integer i	
	integer ll_test1 //maha 012501
	integer ll_test2 //maha 012501
	integer t //maha 012501
	integer del //maha 012501
	dw_browse.Visible = False
	dw_detail.Visible = False	
	dw_detail.Update()
	
	//Start Code Change ----07.15.2008 #V81 maha - moved retrieve code to function
	of_retrieve_recreds(tab_view.tabpage_recred.dw_recred_info)
	//End Code Change---07.15.2008
//	li_rc = tab_view.tabpage_recred.dw_recred_info.Retrieve( il_prac_id)
//	FOR i = 1 TO li_rc
//		IF tab_view.tabpage_recred.dw_recred_info.GetItemString( i, "verify_data" ) = "B" THEN
//			tab_view.tabpage_recred.dw_recred_info.SetItem( i, "selected", 1 )
//		ELSE
//			tab_view.tabpage_recred.dw_recred_info.SetItem( i, "selected", 0 )
//		END IF
//		//\/maha 012501
//		
//		IF tab_view.tabpage_recred.dw_recred_info.GetItemnumber( i, "facility_id" ) = ii_ver_id THEN
//			tab_view.tabpage_recred.dw_recred_info.SetItem( i, "color", 1 )
//		else
//			tab_view.tabpage_recred.dw_recred_info.SetItem( i, "selected", 0 )
//		end if
//		//\maha
//	END FOR
//	tab_view.tabpage_recred.dw_recred_info.Sort()
//	tab_view.tabpage_recred.dw_recred_info.GroupCalc() //maha 012403
////\/maha 012501 test for duplicates and delete from datawindow  PIX code removed 010902 maha readded 020102
//	FOR i = 1 TO li_rc
//			ll_test1 = tab_view.tabpage_recred.dw_recred_info.GetItemNumber( i, "rec_id" )
//			del = tab_view.tabpage_recred.dw_recred_info.GetItemNumber( i, "del" )
//			if del = 1 then continue
//			for t = 1 to li_rc
//					ll_test2 = tab_view.tabpage_recred.dw_recred_info.GetItemNumber( t, "rec_id" )
//					if i <> t and ll_test1 = ll_test2 and isnull(tab_view.tabpage_recred.dw_recred_info.GetItemnumber( i, "verification_id" )) and isnull(tab_view.tabpage_recred.dw_recred_info.GetItemnumber( t, "verification_id" )) then
//						tab_view.tabpage_recred.dw_recred_info.SetItem( t, "del", 1 )
//				   end if
//			next
//	next
//	FOR i =  li_rc to 1 step -1
//		if tab_view.tabpage_recred.dw_recred_info.getItemnumber( i, "del") = 1 then
//			tab_view.tabpage_recred.dw_recred_info.SetItem( i, "selected", 0 )
//		end if
//		next
//		//\maha
END IF


IF newindex = 3 THEN
	gb_type.BringToTop = False
	gb_response_stat.Visible = False
	rb_stat_active.Visible = False
	rb_stat_both.Visible = False
	rb_stat_hist.Visible = False
	dw_select_screen.Visible = False
	rb_ver_compl.Visible = False
	rb_ver_impcompl.Visible = False
	rb_ver_stat_both.Visible = False
//	tab_view.tabpage_recred.enabled = true //maha 112102 because if there is a verification higher in the list then the exp appt letter the tab becomes disabled
ELSE
	gb_response_stat.Visible = True
	rb_stat_active.Visible = True
	rb_stat_both.Visible = True
	rb_stat_hist.Visible = True
	dw_select_screen.Visible = True
	rb_ver_compl.Visible = True
	rb_ver_impcompl.Visible = True
	rb_ver_stat_both.Visible = True
	
	gb_type.BringToTop = True
	gb_response_stat.BringToTop = True
	rb_stat_active.BringToTop = True
	rb_stat_both.BringToTop = True
	rb_stat_hist.BringToTop = True
	dw_select_screen.BringToTop = True
	rb_ver_compl.BringToTop = True
	rb_ver_impcompl.BringToTop = True
	rb_ver_stat_both.BringToTop = True
END IF




end event

type tabpage_browse from userobject within tab_view
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 3342
integer height = 1852
long backcolor = 32891346
string text = "Browse"
long tabtextcolor = 33554432
long tabbackcolor = 32891346
long picturemaskcolor = 12632256
end type

type tabpage_detail from userobject within tab_view
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 3342
integer height = 1852
boolean border = true
long backcolor = 32891346
string text = "Detail"
long tabtextcolor = 33554432
long tabbackcolor = 32891346
long picturemaskcolor = 12632256
end type

type tabpage_recred from userobject within tab_view
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 3342
integer height = 1852
boolean enabled = false
boolean border = true
long backcolor = 32891346
string text = "Recred."
long tabtextcolor = 33554432
long tabbackcolor = 32891346
long picturemaskcolor = 12632256
cbx_preserve cbx_preserve
cbx_check_miss cbx_check_miss
cbx_privs cbx_privs
cb_crednoverif cb_crednoverif
cb_init_recred cb_init_recred
dw_recred_info dw_recred_info
end type

on tabpage_recred.create
this.cbx_preserve=create cbx_preserve
this.cbx_check_miss=create cbx_check_miss
this.cbx_privs=create cbx_privs
this.cb_crednoverif=create cb_crednoverif
this.cb_init_recred=create cb_init_recred
this.dw_recred_info=create dw_recred_info
this.Control[]={this.cbx_preserve,&
this.cbx_check_miss,&
this.cbx_privs,&
this.cb_crednoverif,&
this.cb_init_recred,&
this.dw_recred_info}
end on

on tabpage_recred.destroy
destroy(this.cbx_preserve)
destroy(this.cbx_check_miss)
destroy(this.cbx_privs)
destroy(this.cb_crednoverif)
destroy(this.cb_init_recred)
destroy(this.dw_recred_info)
end on

type cbx_preserve from checkbox within tabpage_recred
integer x = 923
integer y = 128
integer width = 608
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "Keep EXP APPT Active"
end type

event clicked;//if this.checked then   //Start Code Change ----08.31.2017 #V154 maha - removed
//	gb_preserve_exp_appt_verif = true
//else
//	gb_preserve_exp_appt_verif = false
//end if

end event

event constructor;if gb_preserve_exp_appt_verif = true then this.checked = true   //Start Code Change ----07.22.2015 #V15 maha
end event

type cbx_check_miss from checkbox within tabpage_recred
integer x = 923
integer y = 68
integer width = 640
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "Check for missing Verifs"
boolean checked = true
end type

type cbx_privs from checkbox within tabpage_recred
integer x = 923
integer width = 530
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "Rollover Privileges"
end type

type cb_crednoverif from commandbutton within tabpage_recred
integer x = 1568
integer y = 48
integer width = 937
integer height = 104
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Recredential WITHOUT Verifications"
end type

event clicked;//Start Code Change ----07.17.2008 #V81 maha - modified to use instance object
//pfc_n_cst_ai_printletters inv_print_letters
uo_priv_data_ent inv_privs

Integer li_facility_id

li_facility_id = dw_orgs_facilities.GetItemNumber( dw_orgs_facilities.GetRow(), "parent_facility_id" )

//inv_printletters = CREATE pfc_n_cst_ai_printletters
 
//IF inv_printletters.of_start_reappointment_processing( dw_recred_info, dw_detail, li_facility_id,il_prac_id,"NOVER") = 1 THEN //Start Code Change ----03.22.2010 #V10 maha - changed prac_variable

//Start Code Change ----08.31.2017 #V154 maha - for variable change
if tab_view.tabpage_recred.cbx_preserve.checked then
	inv_printletters.ib_preserve_exp_appt = true
else
	inv_printletters.ib_preserve_exp_appt = false
end if
//End Code Change ----08.31.2017

IF inv_printletters.of_start_reappointment_processing_new( dw_recred_info, dw_detail, li_facility_id,il_prac_id,"NOVER",0) = 1 THEN //Start Code Change ----10.22.2015#V10 maha - changed to updated function
	tab_view.SelectTab( 1 )
	of_Retrieve_Detail( dw_orgs_facilities.GetRow() )
END IF



if cbx_privs.checked then
	openwithparm(w_renew_priv_form,il_prac_id)
//	inv_privs = create uo_priv_data_ent
//	inv_privs.of_priv_batch("R",il_prac_id,ii_facility_id)
//	DESTROY inv_privs
end if

//DESTROY inv_print_letters

end event

type cb_init_recred from u_cb within tabpage_recred
integer x = 14
integer y = 52
integer width = 855
integer height = 104
integer taborder = 50
fontcharset fontcharset = ansi!
string text = "Initiate Recredentialing Process"
end type

event clicked;
integer i
integer t
integer trows
integer irows
Integer li_facility_id
integer li_row_cnt
long li_ver_facil
long ll_test1
long ll_test2
string ls_type
//pfc_n_cst_ai_printletters inv_print_letters 
uo_priv_data_ent inv_privs

This.SetRedraw( False )

li_facility_id = dw_orgs_facilities.GetItemNumber( dw_orgs_facilities.GetRow(), "parent_facility_id" )
 li_ver_facil =  dw_orgs_facilities.GetItemNumber( dw_orgs_facilities.GetRow(), "verifying_facility" )
ls_type = dw_orgs_facilities.getitemstring(dw_orgs_facilities.GetRow(),"pd_affil_stat_apptmnt_type")

if tab_view.tabpage_recred.cbx_check_miss.checked then
	inv_printletters.of_find_missing_verifs( il_prac_id, li_ver_facil, 0, ls_type)  //Start Code Change ----03.22.2010 #V10 maha - changed prac_variable
end if

////moved here from reaappointment process function
//li_row_cnt = dw_recred_info.rowcount()
//trows = li_row_cnt
//FOR i = 1 TO li_row_cnt //test for duplicate verifications
//	IF dw_recred_info.GetItemNumber( i, "selected" ) = 1 THEN
//		ll_test1 = dw_recred_info.GetItemNumber( i, "rec_id" )
//		for t = 1 to trows
//			IF dw_recred_info.GetItemNumber( t, "selected" ) = 1 THEN
//				ll_test2 = dw_recred_info.GetItemNumber( t, "rec_id" )
//				if i <> t and ll_test1 = ll_test2 then
//					messagebox("Copy Error","There are duplicate records selected for reverification.~n~rPlease deselect the duplicates")
//					return 
//				end if
//			end if
//		next
//	end if
//next

//inv_print_letters = CREATE pfc_n_cst_ai_printletters

//Start Code Change ----08.31.2017 #V154 maha - for variable change
if tab_view.tabpage_recred.cbx_preserve.checked then
	inv_printletters.ib_preserve_exp_appt = true
else
	inv_printletters.ib_preserve_exp_appt = false
end if
//End Code Change ----08.31.2017

//Added by (APPEON) Harry 12.04.2017  Bug # 5898 - Issue when re-credentialing 2 facilities at the same time
String ls_sort_org
ls_sort_org = tab_view.tabpage_recred.dw_recred_info.Describe("DataWindow.Table.Sort")

IF inv_printletters.of_start_reappointment_processing_new( dw_recred_info, dw_detail, li_facility_id,il_prac_id,"RECRED", 0) = 1 THEN  //Start Code Change ----03.22.2010 #V10 maha - changed prac_variable
//IF inv_print_letters.of_start_reappointment_processing_new( dw_recred_info, dw_detail, li_facility_id,gl_prac_id,"RECRED") = 1 THEN
	tab_view.SelectTab( 1 )
//of_Retrieve_Detail( dw_orgs_facilities.GetRow() )
END IF
//Added by (APPEON) Harry 12.04.2017  Bug # 5898 - Issue when re-credentialing 2 facilities at the same time
tab_view.tabpage_recred.dw_recred_info.setsort(ls_sort_org)
tab_view.tabpage_recred.dw_recred_info.sort()	

//moved outside of previous if because otherwise exp letters was getting set to inactive
of_Retrieve_Detail( dw_orgs_facilities.GetRow() )
of_ver_filter( )   //Start Code Change ----10.22.2015 #V15 maha - refilter as filter was removed in reapp function
//DESTROY inv_print_letters

//\/maha 083000
w_prac_data_1.tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_browse.dw_browse.settransobject(sqlca)//maha110700
w_prac_data_1.tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_browse.dw_browse.retrieve(il_prac_id,li_facility_id,gs_user_id) //Start Code Change ----03.22.2010 #V10 maha - changed prac_variable
w_prac_data_1.tab_1.tabpage_apptmnt_status.uo_affill_status.of_retrieve_children()//maha 030304

//Refresh w_prac_data_1.il_affil_rec_id, Added by Appeon long.zhang 10.22.2015 (Bug id 4796 - Lights turning gray)
If li_facility_id = w_prac_data_1.ii_parent_facility_id  And w_prac_data_1.tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_detail_1.dw_apptmnt_status.GetRow() > 0 Then
	w_prac_data_1.il_affil_rec_id = w_prac_data_1.tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_detail_1.dw_apptmnt_status.GetItemNumber(w_prac_data_1.tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_detail_1.dw_apptmnt_status.GetRow(), 'rec_id')
	w_prac_data_1.uo_app_stat.of_get_status( il_prac_id, li_facility_id)  
End If

//\maha
w_prac_data_1.ib_app_audit_retrieved = false //Start Code Change ---- 10.30.2006 #1 maha

if cbx_privs.checked then
	if of_get_app_setting("set_65","I") = 1 then  //Start Code Change ----09.26.2011 #V12 maha - added option for add window
		openwithparm(w_renew_priv_form,il_prac_id)
	else
		openwithparm(w_clin_area_select, "R*" + string(ii_facility_id ) + "@" + string(il_prac_id))
		if isvalid(w_prac_data_1) then w_prac_data_1.ib_priv_retrieved = false
	end if
//	inv_privs = create uo_priv_data_ent
//	inv_privs.of_priv_batch("R",il_prac_id,ii_facility_id)
//	DESTROY inv_privs
end if


This.SetRedraw( True )


end event

type dw_recred_info from u_dw within tabpage_recred
integer x = 5
integer y = 184
integer width = 3319
integer height = 1608
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_copy_verification"
boolean hscrollbar = true
boolean border = false
end type

type dw_detail from u_dw within pfc_cst_u_verification_info
event ue_after_row_focus_changed ( )
event type long ue_clicked ( integer xpos,  integer ypos,  long row,  dwobject dwo )
integer x = 951
integer y = 308
integer width = 3319
integer height = 1636
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_ver_summary_record_view"
boolean border = false
end type

event ue_after_row_focus_changed;IF This.GetColumnName( ) = "notes" THEN
	This.SetColumn( "first_sent" )
END IF


end event

event type long ue_clicked(integer xpos, integer ypos, long row, dwobject dwo);//////////////////////////////////////////////////////////////////////////////
//	Event:			ue_clicked
//	Description:		DataWindow clicked
//////////////////////////////////////////////////////////////////////////////
//	Rev. History		Version
//						5.0		Initial version
// 						6.0 	Added Linkage service notification
// 						6.0 	Introduced non zero return value
// 						7.0		Do not bypass processing on linkage failure.  
// 						7.0		Linkage service should not fire events when querymode is enabled
//////////////////////////////////////////////////////////////////////////////
//	Copyright © 1996-2000 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
integer li_rc
boolean lb_disablelinkage

// Check arguments
if IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) then return -1

//------------------- APPEON BEGIN -------------------
//$<modify> Evan 05.11.2009
//$<reason> Corrected BugG061301. Register for due date only.
/*
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 02.22.2006 By: Cao YongWang
//$<reason> Performance tuning
string ls_coltype
If isvalid(iuo_Calendar) Then
	ls_coltype = this.Describe(dwo.name+".ColType")	
	If ls_coltype = 'date' or ls_coltype = 'datetime' Then
		iuo_Calendar.of_Register(dwo.name, iuo_Calendar.DDLB_WITHARROW)
	End If
End If
//---------------------------- APPEON END ----------------------------
*/
// V10.1 - Notification Alert - Andy 01/30/2010
// I changed "verif_info_due_date" to "due_date" in the datawindow.
// if dwo.name = "verif_info_due_date" then
if dwo.name = "due_date" then
	iuo_Calendar.of_Register(dwo.name, iuo_Calendar.DDLB_WITHARROW)
end if
//------------------- APPEON END ---------------------

// Is Querymode enabled?
if IsValid(inv_QueryMode) then lb_disablelinkage = inv_QueryMode.of_GetEnabled()

if not lb_disablelinkage then
	if IsValid (inv_Linkage) then
		if inv_Linkage.Event pfc_clicked ( xpos, ypos, row, dwo ) = &
			inv_Linkage.PREVENT_ACTION then
			// The user or a service action prevents from going to the clicked row.
			return 1
		end if
	end if
end if

	
if IsValid (inv_RowSelect) then inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )

if IsValid (inv_Sort) then inv_Sort.Event pfc_clicked ( xpos, ypos, row, dwo ) 

return 1
end event

event constructor;ib_rmbmenu = False

this.of_SetDropDownCalendar(true) //Add by Evan 05.11.2009 --- Corrected BugG061301. Register for due date only.
end event

event pfc_addrow;of_new_record( il_prac_id )

This.SetFocus( )

Return 0


end event

event retrieveend;call super::retrieveend;integer r    //maha  12.18.2012
double ld_fee   //maha  12.18.2012

IF This.RowCount() > 0 THEN
//	dw_browse.SelectRow( 0, False )   //Start Code Change ----01.20.2016 #V15 maha - removed
//	dw_browse.SelectRow(1, True)

	st_recs.Text = "Record 1 of " + String( This.rowcount() )

	
	Long ll_exp_appt_ltr	

ELSE
	st_recs.Text = "Record 0 of 0"
END IF

//Start Code Change ----12.18.2012 #V12 maha - set fee value
for r = 1 to this.rowcount()
	if not isnull(this.getitemnumber(r, "address_lookup_code")) then
		if isnull(this.getitemnumber(r, "verif_info_fee")) then
			ld_fee = this.getitemnumber(r, "address_lookup_fee")
			if not isnull( ld_fee) then
				this.setitem(r, "verif_info_fee", ld_fee)
			end if
		end if
	end if
next
//End Code Change ----12.18.2012
end event

event rowfocuschanged;call super::rowfocuschanged;IF IsValid( m_pfe_cst_verif_info ) THEN
	inv_action_items.of_enable_action_menu( This, "1" ,2)  //Start Code Change ----02.10.2010 #V10 maha - 3rd arg based on action items tabs
	w_mdi.of_menu_security( "m_pfe_cst_verif_info" )		
END IF

IF This.RowCount() >= currentrow AND This.RowCount() > 0 AND currentrow >0 THEN
	
	Long ll_exp_appt_ltr	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-35
	//$<modify> 01.24.2006 By: Cao YongWang
	//$<reason> performance tuning
	//$<modification> Write script to retrieve data from a cache instead of from the database.
	/*
	SELECT code_lookup.lookup_code  
   INTO :ll_exp_appt_ltr  
   FROM code_lookup  
   WHERE code_lookup.code = 'Exp Appt Ltr'   ;
	*/
//	ll_exp_appt_ltr = long(gnv_data.of_getitem("code_lookup","lookup_code","upper(code)='" + upper('Exp Appt Ltr') + "'"))
//	//---------------------------- APPEON END ----------------------------
//		
//	IF This.GetItemNumber( currentrow, "verification_method" ) = ll_exp_appt_ltr  AND +&
//		This.GetItemNumber( currentrow, "active_status" ) = 1 THEN
//		tab_view.tabpage_recred.Enabled = True
//	ELSE
//		tab_view.tabpage_recred.Enabled = False
//	END IF
	
	dw_browse.SetRow( currentrow )
	
END IF

st_recs.Text = "Record " + String( currentrow ) + " of " + String( This.RowCount() )

IF IsValid( w_capture ) THEN
	gs_pass_ids ls_pass_ids
	
	ls_pass_ids.ls_doc_id = This.GetItemString( currentrow, "doc_id" )
	ls_pass_ids.ls_ref_value = This.GetItemString( currentrow, "reference_value" )
	ls_pass_ids.ls_from_window = "Prac_Folder"
	IF This.GetItemNumber( currentrow, "verification_picture_flag" ) = 1 THEN
		ls_pass_ids.ls_image_available = True
	ELSE
		ls_pass_ids.ls_image_available = False
	END IF

	w_capture.of_setup( ls_pass_ids )
END IF


PostEvent( "ue_after_row_focus_changed" )
end event

event clicked;//Start Code Change ----05.05.2008 #V8 maha - changed to variable rather than repeating getclickedrow function
integer r
long res
long ll_ver_method //maha 07.15.2016
long ll_facil
string ls_path
Long ll_verification_id
gs_pass_ids ls_pass_ids
integer li_type
string ls_file
string ls_ext
string ls_docid
integer li_Interface

r = This.GetClickedRow()
IF r > 0 THEN
	This.SetRow( r)
	dw_browse.ScrollToRow( r)	//Start Code Change ----05.05.2008 #V8 maha - removed becaues it was causing a n inability to click the npdb button
END IF
//End Code Change---05.05.2008

//Start Code Change ----02.08.2016 #V15 maha -  moved from buttonclicked
IF dwo.name = 'b_notes' THEN
	string s
	
	s = This.GetItemString( row, "notes" )
	if isnull(s) then s = ""
	OpenWithParm( w_ai_notes_new,  "V#" + s)

	IF Message.StringParm = "Cancel" THEN
		Return -1
	ELSE
		s = Message.StringParm

		 if this.getitemnumber( row, "active_status") <> 0 then This.SetItem( row, "notes", s )	//long.zhang 10.19.2012 history record do not set notes BugL100905
	END IF
End if

this.Event ue_Clicked(xPos, yPos, Row, DWO) //Add by Evan 05.11.2009 --- Corrected BugG061301. Register for due date only.


//Start Code Change ---- 01.29.2007 #V7 maha
IF dwo.name  = "image_data" OR dwo.name = "image_button_no_image" THEN
	//messagebox(string(row), "ff")
	li_type = dw_detail.GetItemNumber( row,"verification_picture_flag")
	choose case li_type
		case 4
			ls_file = "display.bmp"
		case 2
			ls_file = "display.pdf"
		case 3
			ls_file = "display.htm"
		Case 5 //Start Code Change ----04.29.2016 #V15 maha
			ls_file = "display.png"
		//case 1 = HTML
		Case 6  //Start Code Change ----05.31.2016 #V152 maha
			ls_file = "display.xml"
		Case 7  //Start Code Change ----10.24.2016 #V152 maha
			ls_file = "display.jpg"	
	end choose
	
	ll_verification_id = dw_detail.GetItemNumber( row, "address_lookup_code")
	
	ll_ver_method = This.GetItemnumber( row, "verification_method" )  //Start Code Change ----07.15.2016 #V153 maha
	
	ls_docid = This.GetItemString( row, "doc_id" )
	ls_pass_ids.ls_doc_id = ls_docid
	ls_pass_ids.ls_ref_value = This.GetItemString( row, "reference_value" )
	ls_pass_ids.ls_from_window = "Prac_Folder"
	ls_pass_ids.ll_verification_id = ll_verification_id
	
	IF This.GetItemNumber( row, "verification_picture_flag" ) = 1 THEN		
		ls_pass_ids.ls_image_available = True
	ELSE
		ls_pass_ids.ls_image_available = False
	END IF
	
	//debugbreak()
	
	//------------------- APPEON BEGIN -------------------
	//<$>added:long.zhang 06.14.2016
	//<$>reason:Restore if statement (Missing Capture Software Case#64368 Bug_id#5190)

//	//Start Code Change ----05.31.2016 #V152 maha - changed to case statement
//	//if li_type > 1 then  
//	Choose case li_type
//		case 1, 6 , 2 , 3, 4, 5 //add 2,3,4,5 by Appeon long.zhang 06.08.2016 (Missing Capture Software Case#64368 Bug_id#5190)
//			inv_action_items.of_display_web_image(ls_pass_ids.ls_doc_id, ls_file)
//		case else
//			IF Not IsValid( w_capture ) THEN
//				OpenWithParm( w_capture,  ls_pass_ids )
//			ELSE
//				w_capture.of_setup( ls_pass_ids )
//			END IF
//	End choose
//	//end if
//Start Code Change ----10.24.2016 #V152 maha - split code for the two buttons
	if dwo.name = "image_button_no_image" THEN
		if w_mdi.of_security_access(150) = 0 then return 
		ls_path = getcurrentdirectory() //(Appeon)Stephen 02.25.2017 - BugS022206
		ls_ext = inv_action_items.of_upload_document( This.GetItemString( row, "doc_id" )) 
		ChangeDirectory(ls_path)  //(Appeon)Stephen 02.25.2017 - BugS022206
		if ls_ext = "F" then 
			//failed
		else
			choose case upper(ls_ext)
				case "XML"
					li_type = 6
				case "PNG"
					li_type = 5
				case "BMP"
					li_type = 4
				case "HTM"
					li_type = 3
				case "PDF"
					li_type = 2
				case "JPG"
					li_type = 7
			end choose
			 dw_detail.SetItem( row,"verification_picture_flag", li_type)
			//Start Code Change ----08.17.2017 #V154 maha - stamp upload values
			dw_detail.SetItem( row, "image_stamp", datetime( today(), (Now()) ) )
			dw_detail.SetItem( row, "image_stamp_user", gs_user_id )
			dw_detail.SetItem( row, "image_stamp_site", "Manual Upload")
			//End Code Change ----08.17.2017 			 
			 dw_detail.update()
		end if
		
	else  //display image
	//Start Code Change ----07.15.2016 #V153 maha - for AMA xml 
		if ll_ver_method = -570 and li_type = 6 then  //AMA & XML
			//Start Code Change ----10.20.2016 #V153 maha - change to use ama verif window
			ll_facil = dw_orgs_facilities.GetItemNumber( dw_orgs_facilities.getrow()  , "verifying_facility" )
			of_get_ama_verifs(ll_facil)
			//End Code Change ----10.20.2016 
		else
			//Start Code Change ----08.21.2017 #V154 maha - changed to use display window
		//	if li_type > 1 then			
			choose case li_type
				case 1
					IF Not IsValid( w_capture ) THEN
						OpenWithParm( w_capture,  ls_pass_ids )
					ELSE
						w_capture.of_setup( ls_pass_ids )
					END IF	
				case 2 //pdf
					inv_action_items.of_display_web_image(ls_pass_ids.ls_doc_id, ls_file)
				case else
					gs_pass_ids lst_data
					lst_data.s_stringval = "Verif"
					lst_data.ls_doc_id = ls_docid 
					openwithparm(w_verif_image_view , lst_data)
			end choose
				//End Code Change ----08.21.2017			
		end if
	//End Code Change ----07.15.2016
	End if
//End Code Change ----10.24.2016	
	//------------------- APPEON END -------------------
END IF
//End Code Change---01.29.2007



if dwo.name = "b_npdb" then

	ls_docid = dw_detail.GetItemString(Row, "doc_id")
	li_Interface = of_get_app_setting("set_8", "I")
	choose case li_Interface
		case 1 //ITP_INTERFACE
			OpenSheetWithParm(w_npdb_report, ls_docid, "w_npdb_report", w_mdi, 0, original!)
		case 2 //QRXS_INTERFACE
			if not IsValid(w_npdb_reports) then Open(w_npdb_reports)
			w_npdb_reports.SetFocus()
			w_npdb_reports.of_show_prac_rpts(ls_docid)
	end choose
end if


IF dwo.name = 'b_web' THEN
	//debugbreak()
	gs_passstring[1] = dw_detail.GetItemString(Row, "doc_id")
	gs_passstring[2] =  string(dw_detail.GetItemnumber(Row, "rec_id"))
	gs_passstring[3] =  string(dw_detail.GetItemnumber(Row, "prac_id"))
	gs_passstring[4] =  string(dw_detail.GetItemnumber(Row, "screen_id"))
	gs_passstring[5] =  string(dw_detail.GetItemnumber(Row, "parent_facility_id"))
	
	//Start Code Change ----03.22.2016 #V15 maha - if modified re-retrieve data
	open(w_wc_accept_data_verif)
	res = message.doubleparm
	if res = 1 then 
		of_retrieve_detail( dw_orgs_facilities.getrow())
	end if
	//End Code Change ----03.22.2016
	
end if
//End Code Change ----02.08.2016

//Start Code Change ----11.04.2016 #V153 maha
IF dwo.name = 'oig_view' THEN
	openwithparm(w_oig_scan_log_prac, il_prac_id)
End if

end event

event itemchanged;call super::itemchanged;IF This.GetColumnName() = "response_code" THEN
	This.SetItem( row, "user_name", gs_user_id )
	This.SetItem( row, "source", "P" )
	This.SetItem( row, "date_recieved", Today() )
	This.SetItem( row, "exp_credential_flag", 0 )
	This.SetItem( row, "print_flag", 0 )
	//Start Code Change ----08.01.2008 #V85 maha - if status flag indicates historical or inactive set to not create expired verif
	if this.getitemstring(row, "reference_value") <> 'Expiring Appointment Letter' then//maha 100400 to keep recieved letters from being recredentialed
		if this.getitemnumber(row,"verif_info_data_status") = 0 or this.getitemnumber(row,"verif_info_data_status") = 2 then
			This.SetItem( row, "exp_credential_flag", 2 )
		elseif this.getitemnumber( row, "verification_method" ) = 10015 and (data='' or isnull(data)) then //(Appeon)Stephen 04.07.2017 - V15.2 Bug # 5592 - Verifications-> Expiring Credential: Selecting a response code then clearing sets the Expired Notice to No
			This.SetItem( row, "exp_credential_flag", 1 )
		else
			This.SetItem( row, "exp_credential_flag", 0 )
		end if
	end if
	//End Code Change---08.01.2008
END IF

IF This.GetColumnName() = "verification_method" THEN  //maha 061504 make the verification 'expired' if method changed to EXP CRED
	//Start Code Change ----05.29.2009 #V92 maha - added to trap for mistaken changes.
	if messagebox("Verification method","Are you sure you want to change the Verification Method?",question!,Yesno!,2) = 2 then
		This.SetItem( row, "exp_credential_flag", This.getItemnumber( row, "exp_credential_flag", primary!,true) )
		return 2
	else
		this.accepttext()
		if this.getitemnumber( row, "verification_method" ) = 10015 then
			if isnull(this.getitemnumber(row,"response_code")) then  //Start Code Change ----11.098.2011 #V12 maha - trap for change after completed.
				This.SetItem( row, "exp_credential_flag", 1 )
			end if
		end if
	end if
	//End Code Change---05.29.2009
end if


end event

event pfc_validation;call super::pfc_validation;IF inv_action_items.of_Validate_Receive( This ) = -1 THEN
	Return -1
ELSE
	Return AncestorReturnValue
END IF
end event

event pfc_preupdate;call super::pfc_preupdate;Integer li_rc
Integer i,li_seq
Integer z
Integer li_cnt
Integer li_facility_id
Integer li_facility_ids[]
Boolean lb_found


//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.20.2006 By: Jervis
//$<reason> 
str_action_item lstr_init[]

//Reset str_action_item value
istr_action = lstr_init

long ll_ori,ll_cur
//---------------------------- APPEON END ----------------------------


ii_facility_ids = li_facility_ids //nulling it out
ii_screen_ids = li_facility_ids
li_rc = This.RowCount()
li_seq = 1
//gets the unique verifying facilities; should not be more than 2 (verif and npdb); used by of_is_verif_compete
FOR i = 1 TO li_rc
	IF This.GetItemStatus( i, "response_code", Primary! ) = DataModified! THEN
		//li_facility_id = This.GetItemNumber( i, "facility_id" )
		ii_facility_ids[1] = This.GetItemNumber( i, "verif_info_facility_id" )
		ii_screen_ids[1] = This.GetItemNumber( i, "screen_id" )//maha 110304
		lb_found = False
		
	END IF
	
	//Start Code Change ----08.05.2011 #V11 maha 
	IF This.GetItemStatus( i, 0, Primary! ) = DataModified! then
		this.setitem(i,"mod_user",gs_user_id)
		this.setitem(i,"mod_date",datetime(today(),now()))
	end if
	//End Code Change ----08.05.2011
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 11.20.2006 By: Jervis
	//$<reason> modify work flow
	If gb_workflow Then
		IF This.GetItemStatus( i, 0, Primary! ) = DataModified! then
			//if this.GetItemNumber(i,"response_code",primary!,true) <> this.GetItemNumber(i,"response_code") Then
			ll_ori = this.GetItemNumber(i,"response_code",primary!,true)
			ll_cur = this.GetItemNumber(i,"response_code")
			if ((ll_ori <> ll_cur) or (isnull(ll_ori) and not isnull(ll_cur)) or (not isnull(ll_ori) and isnull(ll_cur))) Then
				istr_action[li_seq].rec_id = This.getItemnumber( i, "rec_id" )
				istr_action[li_seq].prac_id = This.getItemnumber( i, "prac_id" )
				istr_action[li_seq].facility_id = This.getItemnumber( i, "verif_info_facility_id" )
				istr_action[li_seq].wf_id = this.GetItemNumber(i,"verif_info_wf_id")
				istr_action[li_seq].wf_action_status_id = this.GetItemNumber(i,"response_code")
				istr_action[li_seq].wf_action_type_id = this.GetItemNumber(i,"verification_method")
				istr_action[li_seq].status_changed_flag = false
				istr_action[li_seq].module = "01"	//IntelliGred
				istr_action[li_seq].trigger_by = "008"		//Trigger By Action Item Changed
				istr_action[li_seq].screen_id = -10
				
				if istr_action[li_seq].wf_id > 0 and this.GetItemString(i,"verif_info_wf_complete_flag") = "N" THEN
					istr_action[li_seq].wf_step_id = this.GetItemNumber(i,"verif_info_wf_action_type_id")
					istr_action[li_seq].notes = this.GetItemString(i,"notes")
					istr_action[li_seq].status_changed_flag = true
					istr_action[li_seq].seq_no = This.getItemnumber( i, "seq_no" )
				end if
				li_seq++
			//elseif this.GetItemNumber(i,"verification_method",primary!,true) <> this.GetItemNumber(i,"verification_method") Then
			else
				ll_ori = this.GetItemNumber(i,"verification_method",primary!,true)
				ll_cur = this.GetItemNumber(i,"verification_method")
				if ((ll_ori <> ll_cur) or (isnull(ll_ori) and not isnull(ll_cur)) or (not isnull(ll_ori) and isnull(ll_cur))) Then
					istr_action[li_seq].rec_id = This.getItemnumber( i, "rec_id" )
					istr_action[li_seq].prac_id = This.getItemnumber( i, "prac_id" )
					istr_action[li_seq].facility_id = This.getItemnumber( i, "verif_info_facility_id" )
					istr_action[li_seq].wf_action_status_id = this.GetItemNumber(i,"response_code")
					istr_action[li_seq].wf_action_type_id = this.GetItemNumber(i,"verification_method")
					istr_action[li_seq].status_changed_flag = false
					istr_action[li_seq].module = "01"	//IntelliGred
					istr_action[li_seq].trigger_by = "008"		//Trigger By Action Item Changed
					istr_action[li_seq].screen_id = -10
					li_seq++
				end if
			end if
		END IF
	End if
		
END For



//ii_facility_ids = li_facility_ids //nulling it out
//ii_screen_ids = li_facility_ids
//li_rc = This.RowCount()
////gets the unique verifying facilities; should not be more than 2 (verif and npdb); used by of_is_verif_compete
//FOR i = 1 TO li_rc
//	IF This.GetItemStatus( i, "response_code", Primary! ) = DataModified! THEN
//		//li_facility_id = This.GetItemNumber( i, "facility_id" )
//		li_facility_id = This.GetItemNumber( i, "verif_info_facility_id" )
//		lb_found = False
//		FOR z = 1 TO upperbound(ii_facility_ids)
//			IF li_facility_id = ii_facility_ids[ z ] THEN
//				lb_found = True
//				Exit
//			END IF
//		END FOR
//		IF NOT lb_found THEN
//			li_cnt++
//			ii_facility_ids[li_rc] = li_facility_id
//			ii_screen_ids[li_rc] = This.GetItemNumber( i, "screen_id" )//maha 110304
//			messagebox("",ii_facility_ids[li_rc])
//		END IF
//	END IF
//END FOR

Return 1
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

event buttonclicked;call super::buttonclicked;//Start Code Change ----02.08.2016 #V15 maha - moved to clicked event


////Start Code Change ---- 01.29.2007 #V7 maha
//IF dwo.name  = "image_data" OR dwo.name = "image_button_no_image" THEN
//	Long ll_verification_id
//	gs_pass_ids ls_pass_ids
//	integer li_type
//	string ls_file
//	//messagebox(string(row), "ff")
//	li_type = dw_detail.GetItemNumber( row,"verification_picture_flag")
//	choose case li_type
//		case 4
//			ls_file = "display.bmp"
//		case 2
//			ls_file = "display.pdf"
//		case 3
//			ls_file = "display.htm"
//	end choose
//	
//	ll_verification_id = dw_detail.GetItemNumber( row, "address_lookup_code")
//	
//	ls_pass_ids.ls_doc_id = This.GetItemString( row, "doc_id" )
//	ls_pass_ids.ls_ref_value = This.GetItemString( row, "reference_value" )
//	ls_pass_ids.ls_from_window = "Prac_Folder"
//	ls_pass_ids.ll_verification_id = ll_verification_id
//	
//	
//	IF This.GetItemNumber( row, "verification_picture_flag" ) = 1 THEN		
//		ls_pass_ids.ls_image_available = True
//	ELSE
//		ls_pass_ids.ls_image_available = False
//	END IF
//	
//	if li_type > 1 then
//		inv_action_items.of_display_web_image(ls_pass_ids.ls_doc_id, ls_file)
//	else
//		IF Not IsValid( w_capture ) THEN
//			OpenWithParm( w_capture,  ls_pass_ids )
//		ELSE
//			w_capture.of_setup( ls_pass_ids )
//		END IF
//	end if
//END IF
////End Code Change---01.09.2007
//
////------------------- APPEON BEGIN -------------------
////$<Modify> 04.16.2010 By: Evan
////$<Reason> V10.1 - NPDB QRXS
///*
//if dwo.name  = "b_npdb" then
//  //window w_npdb_report
//  OpenSheetWithParm(w_npdb_report, dw_detail.GetItemstring( row, "DOC_id"), "w_npdb_report", w_mdi, 0, original!)
//end if
//*/
//string ls_doc_id
//integer li_Interface
//if dwo.name = "b_npdb" then
//	ls_doc_id = dw_detail.GetItemString(Row, "doc_id")
//	li_Interface = of_get_app_setting("set_8", "I")
//	choose case li_Interface
//		case 1 //ITP_INTERFACE
//			OpenSheetWithParm(w_npdb_report, ls_doc_id, "w_npdb_report", w_mdi, 0, original!)
//		case 2 //QRXS_INTERFACE
//			if not IsValid(w_npdb_reports) then Open(w_npdb_reports)
//			w_npdb_reports.SetFocus()
//			w_npdb_reports.of_show_prac_rpts(ls_doc_id)
//	end choose
//end if
////------------------- APPEON END ---------------------
//
//Start Code Change ----08.04.2009 #V92 maha - added expanded notes
//Start Code Change ----02.08.2016 #V15 maha - moved notes code to clicked event
//IF dwo.name = 'b_notes' THEN
//	string s
//	//------Begin Modified by Alfee 01.15.2010 ---------------
//	//<$Reason> for a richtext bug in APB 6.0 
//		//Start Code Change ----09.12.2012 #V12 maha - new exp. notes screen
//
//	//---------Begin Modified by (Appeon)Harry 07.17.2014  for the Bug 4115
//	//OpenWithParm( w_ai_notes_new, "V#" +  This.GetItemString( row, "notes" ))
//	string ls_notes
//	ls_notes = This.GetItemString( row, "notes" )
//	if isnull(ls_notes) then ls_notes = ""
//	OpenWithParm( w_ai_notes_new,  "V#" + ls_notes)
//	//---------End Modfiied ------------------------------------------------------	
////	IF appeongetclienttype() = 'WEB' THEN  
////		//OpenWithParm( w_ai_notes_web, "V" + This.GetItemString( row, "notes" ))
////		OpenWithParm( w_ai_notes_web, "V#" + This.GetItemString( row, "notes" ))
////	ELSE		
////		//OpenWithParm( w_ai_notes, "V" + This.GetItemString( row, "notes" ))//Start Code Change ----03.03.2011 #V11 maha - added V to front
////		OpenWithParm( w_ai_notes, "V#" + This.GetItemString( row, "notes" )) //Changed by long.zhang 08.25.2011 added V# to front
////	END IF		
//	//OpenWithParm( w_ai_notes, This.GetItemString( row, "notes" ))
//	//------End Modified --------------------------------------		
//
//	IF Message.StringParm = "Cancel" THEN
//		Return -1
//	ELSE
//		s = Message.StringParm
////		if LenA(s) > 255 then  //Start Code Change ----11.4.2010 #V10 maha - removed with change to varchar
////			s = MidA(s,1,255)
////			messagebox("Notes","This Notes field is limited to 255 characters.")
////		end if
//		//This.SetItem( row, "notes", s )
//		 if this.getitemnumber( row, "active_status") <> 0 then This.SetItem( row, "notes", s )	//long.zhang 10.19.2012 history record do not set notes BugL100905
//	END IF
//End if
//End Code Change---08.04.2009
//
//IF dwo.name = 'b_web' THEN
//	//debugbreak()
//	gs_passstring[1] = dw_detail.GetItemString(Row, "doc_id")
//	gs_passstring[2] =  string(dw_detail.GetItemnumber(Row, "rec_id"))
//	gs_passstring[3] =  string(dw_detail.GetItemnumber(Row, "prac_id"))
//	gs_passstring[4] =  string(dw_detail.GetItemnumber(Row, "screen_id"))
//	gs_passstring[5] =  string(dw_detail.GetItemnumber(Row, "parent_facility_id"))
//	
//	open(w_wc_accept_data_verif)
//end if
//	
end event

event pfc_postupdate;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.06.2006 By: Jervis
//$<reason> modify work flow
long ll_i,ll_count
n_cst_workflow_triggers    lnv_trigger

If not gb_workflow Then return 1

//Added by Appeon long.zhang 09.19.2014 (v14.1 bug of Duplicate IntelliCred Emails)
if isvalid(w_mdi) then
	if isvalid(w_mdi.iw_prac_window) then w_mdi.iw_prac_window.cb_save.enabled = false
end if

lnv_trigger = create n_cst_workflow_triggers


ll_count = UpperBound(istr_action)

For ll_i = 1 to ll_count
	if istr_action[ll_i].status_changed_flag then
		lnv_trigger.of_status_changed( istr_action[ll_i])
	end if
Next

//2006-11-20 by jervis
//Create Work Flow By Action Item Changed
lnv_trigger.of_workflow_triggers(istr_action)   
//2006-11-20

destroy lnv_trigger

//
// Add by andy 01/30/2010 V10.1 - Notification Alert
//
n_cst_notification_alert_upd	lnv_na

lnv_na.of_update_alert_records( "verif_info", This)

//Added by Appeon long.zhang 09.19.2014 (v14.1 bug of Duplicate IntelliCred Emails)
if isvalid(w_mdi) then
	if isvalid(w_mdi.iw_prac_window) then w_mdi.iw_prac_window.cb_save.enabled = true
end if

// Because I must check column status in the above function,
// I unextend ancestor script and call it at last.
Call Super::pfc_postupdate

return 1
//---------------------------- APPEON END ----------------------------



end event

event pfc_retrieve;call super::pfc_retrieve;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.23.2006 By: Jervis
//$<reason> 
Integer li_facility_id[2]
Integer li_row_cnt,li_row

li_row = dw_orgs_facilities.GetRow()
if li_row = 0 THEN
	Return 0
END IF

li_facility_id[1] = dw_orgs_facilities.GetItemNumber( li_row, "verifying_facility" )
li_facility_id[2] = dw_orgs_facilities.GetItemNumber( li_row, "parent_facility_id" )
ii_facility_id = li_facility_id[2]
ii_ver_id = li_facility_id[1]
li_row_cnt = dw_detail.Retrieve(1, il_prac_id, li_facility_id[]  )

IF dw_detail.RowCount() > 0 THEN
	il_rec_id = dw_detail.GetItemNumber( 1, "rec_id" )
END IF

RETURN li_row_cnt
//---------------------------- APPEON END ----------------------------

end event

event itemfocuschanged;call super::itemfocuschanged;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 12.05.2006 By: Jervis
//$<reason> Filter Status
datawindowchild ldwc
long ll_wf_id,ll_wf_step_id
string ls_filter

ll_wf_id = this.GetItemNumber(row,"verif_info_wf_id")
ll_wf_step_id = this.GetItemNumber(row,"verif_info_wf_action_type_id")
	
if dwo.name = "response_code" and ll_wf_id > 0 then
	if this.GetChild(dwo.name,ldwc) = 1 then
		ls_filter = "wf_id =" + string(ll_wf_id) + " and step_id = " + string(ll_wf_step_id) 
		ls_filter = gnv_data.of_get_filter_data("workflow_status_filter",ls_filter,"lookup_code")
		if ls_filter <> "" then
			ls_filter += " or isnull(lookup_code) or lookup_code = -777"
		else
			ls_filter = "isnull(lookup_code) or lookup_code = -777"
		end if
		ldwc.SetFilter( ls_filter)
		ldwc.Filter()
		//this.SetRedraw( false)
		is_prior = dwo.name
	end if
elseif is_prior = "response_code" then
	if this.GetChild(is_prior,ldwc) = 1 then
		ldwc.SetFilter("")
		ldwc.Filter()
		is_prior = ""
		this.SetRedraw( true )
	end if
end if

//---------------------------- APPEON END ----------------------------

end event

type dw_browse from u_dw within pfc_cst_u_verification_info
integer x = 951
integer y = 308
integer width = 3319
integer height = 1628
integer taborder = 70
string dataobject = "d_ver_summary_record_view_browse"
boolean hscrollbar = true
end type

event constructor;ib_rmbmenu	= False
end event

event doubleclicked;tab_view.SelectTab( 2 )
end event

event rowfocuschanged;call super::rowfocuschanged;IF IsValid( m_pfe_cst_action_items ) THEN
	inv_action_items.of_enable_action_menu( This, "1" ,2) //Start Code Change ----02.10.2010 #V10 maha - 3rd arg bease on action items tabs
	w_mdi.of_menu_security( "m_pfe_cst_verif_info" )		
END IF


IF This.RowCount() > 0 THEN
	
//	This.SelectRow( 0, False )   //Start Code Change ----01.20.2016 #V15 maha - removed
//	This.SelectRow( currentrow, True )
	
	Long ll_exp_appt_ltr	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-36
	//$<modify> 01.24.2006 By: Cao YongWang
	//$<reason> performance tuning
	//$<modification> Write script to retrieve data from a cache instead of from the database.
	/*
	SELECT code_lookup.lookup_code  
   INTO :ll_exp_appt_ltr  
   FROM code_lookup  
   WHERE code_lookup.code = 'Exp Appt Ltr'   ;
	*/
//	ll_exp_appt_ltr = long(gnv_data.of_getitem("code_lookup","lookup_code","upper(code)='" + upper('Exp Appt Ltr') + "'"))
//	//---------------------------- APPEON END ----------------------------
//		
//	IF This.GetItemNumber( currentrow, "verification_method" ) = ll_exp_appt_ltr  AND +&
//		This.GetItemNumber( currentrow, "active_status" ) = 1 THEN
//		tab_view.tabpage_recred.Enabled = True
//	ELSE
//		tab_view.tabpage_recred.Enabled = False
//	END IF
END IF

IF dw_detail.RowCount() >= currentrow and dw_detail.GetRow() <> currentrow THEN // Evan 03.03.2009
	dw_detail.SetRow( currentrow )
	dw_detail.ScrollToRow( currentrow )
END IF

st_recs.Text = "Record " + String( currentrow ) + " of " + String( This.RowCount() )
end event

event clicked;call super::clicked;IF This.GetClickedRow() > 0 THEN
	This.ScrollToRow( This.GetClickedRow() )
	This.SetRow( This.GetClickedRow() )
END IF
end event

