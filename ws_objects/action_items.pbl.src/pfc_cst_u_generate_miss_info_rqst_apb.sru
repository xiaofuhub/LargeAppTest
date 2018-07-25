$PBExportHeader$pfc_cst_u_generate_miss_info_rqst_apb.sru
forward
global type pfc_cst_u_generate_miss_info_rqst_apb from nonvisualobject
end type
end forward

global type pfc_cst_u_generate_miss_info_rqst_apb from nonvisualobject
end type
global pfc_cst_u_generate_miss_info_rqst_apb pfc_cst_u_generate_miss_info_rqst_apb

type variables
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<add> 02.10.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Define a variable to be used in subsequent script.
n_ds ids_miss_data_all
n_ds ids_address_info_all
n_ds ids_tracker_all
n_ds ids_verifs_all
n_ds ids_pd_affil_stat
//---------------------------- APPEON END ----------------------------
end variables

forward prototypes
public function integer of_dial_phone (string as_phone)
public subroutine of_get_cachedata (string as_type, string as_condition, ref n_ds ads_target)
public subroutine of_init_cache (integer ai_facility_ids[], long al_prac_ids[], long al_rec_ids[])
public function string of_getitem_fromcache (string as_condition, string as_columnname)
public function integer of_generate_miss_info_letter (integer ai_facility_ids[], long al_prac_ids[], long al_rec_ids[], datawindow adw)
end prototypes

public function integer of_dial_phone (string as_phone);String ls_dialer_path
String ls_dialer_ini_path

ls_dialer_ini_path = ProfileString(gs_IniFilePathName, "Paths","dialer_ini_path", "None")
SetProfileString( ls_dialer_ini_path + "Dialer.ini","Speed Dial Settings", "Name1", "IntelliCred" )
SetProfileString( ls_dialer_ini_path + "Dialer.ini","Speed Dial Settings", "Number1", as_phone )
ls_dialer_path = ProfileString(gs_IniFilePathName, "Paths","dialer", "None")

Run( ls_dialer_path + "dialer.exe")

Return 0

end function

public subroutine of_get_cachedata (string as_type, string as_condition, ref n_ds ads_target);//////////////////////////////////////////////////////////////////////
// $<function>pfc_cst_u_generate_miss_info_rqst_apbof_get_cachedata()
// $<arguments>
//		value	integer	al_type     		
//		value	long   	al_condition		
// $<returns> n_ds
// $<description>Performance tuning.
// $<description>Write script to retrieve data from a cache instead of retrieving data from DB.
//////////////////////////////////////////////////////////////////////
// $<add> 02.10.2006 by Cao YongWang
//////////////////////////////////////////////////////////////////////

Choose Case upper(as_type)
	Case "TRACKER"
		ids_tracker_all.setfilter(as_condition)
		ids_tracker_all.filter()
		ids_tracker_all.RowsCopy(1,ids_tracker_all.Rowcount(),Primary!,ads_target , 1, Primary!)
	Case "ADDRESS_INFO"
		ids_address_info_all.setfilter(as_condition)
		ids_address_info_all.filter()
		ids_address_info_all.RowsCopy(1,ids_tracker_all.Rowcount(),Primary!,ads_target , 1, Primary!)
	Case "MISS_DATA"
		ids_miss_data_all.setfilter(as_condition)
		ids_miss_data_all.filter()
		ids_miss_data_all.RowsCopy(1,ids_tracker_all.Rowcount(),Primary!,ads_target , 1, Primary!)
	Case "VERIFS"
		ids_verifs_all.setfilter(as_condition)
		ids_verifs_all.filter()
		ids_verifs_all.RowsCopy(1,ids_tracker_all.Rowcount(),Primary!,ads_target , 1, Primary!)
End Choose
end subroutine

public subroutine of_init_cache (integer ai_facility_ids[], long al_prac_ids[], long al_rec_ids[]);//////////////////////////////////////////////////////////////////////
// $<function>pfc_cst_u_generate_miss_info_rqst_apbof_init_cache()
// $<arguments>
//		value	integer   	ai_facility_ids[]		
//		value	long      	al_prac_ids[]    		
//		value	long      	al_rec_ids[]     		
//		value	datawindow	adw              		
// $<returns> integer
// $<description> Performance tuning.
// $<description> Initialize the cache data that will be used in of_generate_miss_info_letter function.
//////////////////////////////////////////////////////////////////////
// $<add> 02.10.2006 by Cao YongWang
//////////////////////////////////////////////////////////////////////
long li_add_verifs , ll_facil[ ]

li_add_verifs = of_get_app_setting("set_30","I")

ids_miss_data_all = Create n_ds
ids_miss_data_all.DataObject = "d_pd_app_audit_rqrd_data_apb"
ids_miss_data_all.of_SetTransObject( SQLCA )

If li_add_verifs = 1 Then 
	ids_address_info_all = Create n_ds
	ids_address_info_all.DataObject = "d_pd_app_audit_miss_rqst_data_w_vers_apb"
	ids_address_info_all.of_SetTransObject( SQLCA )
Else
	ids_address_info_all = Create n_ds //normal
	ids_address_info_all.DataObject = "d_pd_app_audit_miss_rqst_data_apb"
	ids_address_info_all.of_SetTransObject( SQLCA )
End If

ids_tracker_all = Create n_ds
ids_tracker_all.DataObject = "d_pd_app_audit_tracker_apb"
ids_tracker_all.of_SetTransObject( SQLCA )

If li_add_verifs = 1 Then //maha 071403
	ids_verifs_all = Create n_ds
	ids_verifs_all.DataObject = "d_ver_summary_record_view_apb"
	ids_verifs_all.of_SetTransObject( SQLCA )
End If

//
ids_pd_affil_stat = Create n_ds
ids_pd_affil_stat.DataObject = "d_pd_affil_stat_for_generate_miss_info"
ids_pd_affil_stat.of_SetTransObject( SQLCA )

//
gnv_appeondb.of_startqueue()

ids_tracker_all.Retrieve( al_rec_ids[])
ids_address_info_all.Retrieve( ai_facility_ids[], al_prac_ids[] )
ids_miss_data_all.Retrieve( al_rec_ids[] )
If li_add_verifs = 1 Then ids_verifs_all.Retrieve( 1,al_prac_ids[ ],ll_facil[ ]) //???
ids_pd_affil_stat.retrieve(ai_facility_ids[])

gnv_appeondb.of_commitqueue()
//---------------------------- APPEON END ----------------------------

end subroutine

public function string of_getitem_fromcache (string as_condition, string as_columnname);string ls_return
long ll_find

ls_return  = ''

ll_find = ids_pd_affil_stat.find(as_condition , 1, ids_pd_affil_stat.RowCount())

If ll_find > 0 Then ls_return = ids_pd_affil_stat.of_getitem(as_columnname , ll_find)

return ls_return
end function

public function integer of_generate_miss_info_letter (integer ai_facility_ids[], long al_prac_ids[], long al_rec_ids[], datawindow adw);n_ds lds_miss_data
n_ds lds_address_info
n_ds lds_copy
n_ds lds_tracker
n_ds lds_verifs
Integer li_prac_cnt
Integer i
Integer m
Integer r //maha 012301
long ll_seq_no //maha 012301
Long ll_loop_count
Long prac
Long ll_facil[]
Long ll_ver_fac
long ll_find  //maha 01.22.2016
Integer li_address_rc
Integer li_miss_cnt
Integer li_attempts
Integer li_set6
Integer li_add_verifs
integer res
datetime ldt_sent  //maha 01.25.2016
datetime ldt_rcvd   //maha 01.25.2016
datetime ldt_signed  //maha 01.25.2016
String ls_app_type
String ls_descr
String ls_local_area_code
String ls_fax_number
String ls_word_path
String ls_letter_path
String ls_open_merge
String ls_dept //maha 090304
String ls_from
String ls_to
String ls_file_name = "ind_missing_info_request.doc"
String ls_doc_name
String ls_note //maha 092403
String ls_reference //maha 083104
String ls_run_path //maha 021805
string ls_status  //maha 10.14.2015


//SELECT set_30 INTO :li_add_verifs FROM icred_settings; //maha 071403 for adding verification to letter
li_add_verifs = of_get_app_setting("set_30","I")
li_set6 = of_get_app_setting("set_6","I")

//Start Code Change ---- 01.23.2006 #216 maha
ls_run_path = of_letter_paths("L")
ls_open_merge = of_letter_paths("D")
//End Code Change---01.23.2006

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-24
//$<add> 06.08.2006 By: Rodger Wu
//$<reason> Performance tuning
//$<modification> Create the downloading directory if it does not exist.
n_appeon_download lnv_download
If gnv_data.of_getitem('icred_settings' ,'set_50' , False ) = '1' or &
   Upper( appeongetclienttype() ) = 'WEB' Then
	lnv_download.of_parsepath( ls_open_merge)
End If
//---------------------------- APPEON END ----------------------------

li_prac_cnt = UpperBound( al_prac_ids )

lds_miss_data = Create n_ds
lds_miss_data.DataObject = "d_pd_app_audit_rqrd_data_pt"


lds_miss_data.of_SetTransObject( SQLCA )

If li_add_verifs = 1 Then //maha 071403 for verifs on letter
	lds_address_info = Create n_ds
	lds_address_info.DataObject = "d_pd_app_audit_miss_rqst_data_w_vers_pt"
		
	lds_address_info.of_SetTransObject( SQLCA )
	lds_copy = Create n_ds //copy

	lds_copy.DataObject = "d_pd_app_audit_miss_rqst_data_w_vers_pt"

	
	lds_copy.of_SetTransObject( SQLCA )
Else
	lds_address_info = Create n_ds //normal
	lds_address_info.DataObject = "d_pd_app_audit_miss_rqst_data_pt"
	lds_address_info.of_SetTransObject( SQLCA )
	
	lds_copy = Create n_ds //copy ds  maha072903
	lds_copy.DataObject = "d_pd_app_audit_miss_rqst_data_pt"
	lds_copy.of_SetTransObject( SQLCA )
End If
//this function originally designed for 1 letter at a time.  Redesigned 07-03 for action items.
lds_tracker = Create n_ds


lds_tracker.Dataobject = "d_pd_app_audit_tracker_forpt"

lds_tracker.of_SetTransObject( SQLCA )

If li_add_verifs = 1 Then //maha 071403
	lds_verifs = Create n_ds
	
		lds_verifs.DataObject = "d_ver_summary_record_view_pt"

	lds_verifs.of_SetTransObject( SQLCA )
End If


//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-08
//$<modify> 02.24.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> 1)Create datastores to cache data in front of the loop instead of
//$<modification> using SQLs in loop.
//$<modification> 2)Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

Datastore lds_pd_affil_stat
Long ll_pd_affil_stat
lds_pd_affil_stat = Create Datastore

//Start Code Change ----01.22.2016 #V15 maha - for request 4946
//lds_pd_affil_stat.Dataobject = "d_pd_affil_stat_forpt"
lds_pd_affil_stat.Dataobject = "d_pd_affil_stat_for_recids"
lds_pd_affil_stat.Settransobject( SQLCA )
//lds_pd_affil_stat.Retrieve( ai_facility_ids[] )
//lds_pd_affil_stat.Retrieve( al_rec_ids[] ) //Moved below, by Appeon long.zhang 01.26.2016 (V14.2 Bug # 4946 - Missing info letter's data sourcce is not populating the appointment dates)
//End Code Change ----01.22.2016 

Datastore lds_pd_affil_stat_verifying_facility
Long ll_pd_affil_stat_verifying_facility
lds_pd_affil_stat_verifying_facility = Create Datastore
//Start Code Change ----01.22.2016 #V15 maha - for request 4946
//lds_pd_affil_stat_verifying_facility.Dataobject = "d_pd_affil_stat_verifying_facility_forpt"
lds_pd_affil_stat_verifying_facility.Dataobject = "d_pd_affil_stat_verifying_facility_recids"
lds_pd_affil_stat_verifying_facility.Settransobject( SQLCA )

Datastore lds_codelookup_affil_dept_description
Long ll_codelookup_affil_dept_description
lds_codelookup_affil_dept_description = Create Datastore
//lds_codelookup_affil_dept_description.Dataobject = "d_codelookup_affil_dept_description_pt"
lds_codelookup_affil_dept_description.Dataobject = "d_codelookup_affil_dept_recid"
lds_codelookup_affil_dept_description.Settransobject( SQLCA )

Datastore lds_codelookup_affil_staff_description
Long ll_codelookup_affil_staff_description
lds_codelookup_affil_staff_description = Create Datastore
//lds_codelookup_affil_staff_description.Dataobject = "d_codelookup_affil_staff_description_pt"
lds_codelookup_affil_staff_description.Dataobject = "d_codelookup_affil_staff_cat_recid"
//End Code Change ----01.22.2016
lds_codelookup_affil_staff_description.Settransobject( SQLCA )

gnv_appeondb.of_startqueue( )

lds_pd_affil_stat.Retrieve( al_rec_ids[] ) //Moved from above, by Appeon long.zhang 01.26.2016 (V14.2 Bug # 4946 - Missing info letter's data sourcce is not populating the appointment dates)
lds_tracker.Retrieve( al_rec_ids[]) 
debugbreak()
//---------Begin Added by (Appeon)Stephen 03.15.2017 for V15.3 Cosmetic Bug # 5548 - Missing info letter: getting retrieval failed after clicking letter button--------
if lds_address_info.DataObject = "d_pd_app_audit_miss_rqst_data_w_vers_pt" then
	res = lds_address_info.Retrieve( ai_facility_ids[ ], al_prac_ids[ ],  gs_user_id)
else
	res = lds_address_info.Retrieve( ai_facility_ids[ ], al_prac_ids[ ] )
end if
//---------End Added ------------------------------------------------------

//if res < 0 then messagebox("", "retrieval failed") //(Appeon)Stephen 03.23.2017 - V15.3 Cosmetic Bug # 5548 - Missing info letter: getting retrieval failed after clicking letter button
lds_miss_data.Retrieve( al_rec_ids[] )

//Start Code Change ----01.22.2016 #V15 maha - for request 4946
If li_add_verifs = 1 Then lds_verifs.Retrieve( 1,al_prac_ids[ ],ai_facility_ids[])
//lds_pd_affil_stat_verifying_facility.Retrieve( al_prac_ids[], ai_facility_ids[] )
//lds_codelookup_affil_dept_description.Retrieve( al_prac_ids[], ai_facility_ids[] )
//lds_codelookup_affil_staff_description.Retrieve( al_prac_ids[], ai_facility_ids[] )
lds_pd_affil_stat_verifying_facility.Retrieve( al_rec_ids[] )
lds_codelookup_affil_dept_description.Retrieve( al_rec_ids[] )
lds_codelookup_affil_staff_description.Retrieve(al_rec_ids[] )
//End Code Change ----01.22.2016 

gnv_appeondb.of_commitqueue( )
//---------------------------- APPEON END ----------------------------

For i = 1 To li_prac_cnt
	res  = lds_tracker.SetFilter("record_id = " + String(al_rec_ids[ i ]) )
	lds_tracker.Filter()
	li_attempts = lds_tracker.Rowcount( )

	res = lds_address_info.SetFilter("pd_address_link_facility_id = " + String(ai_facility_ids[ i ]) + " and pd_address_link_prac_id = " + String(al_prac_ids[ i ]) )
	lds_address_info.Filter()
	li_address_rc = lds_address_info.Rowcount( )

	If li_address_rc < 1 Then
		//MessageBox("Address", "You must have a mailing address links for practitioner id of " + String(al_prac_ids[ i ]) + " for facility_id " + String(ai_facility_ids[ i ]) + " before using this option.")
		MessageBox("Address", "You must have a mailing address link for practitioner ID of " + String(al_prac_ids[ i ]) + " for facility_id " + String(ai_facility_ids[ i ]) + " before using this option.")
		Continue //GOTO ERROR
	Else
		
		//Start Code Change ----01.22.2016 #V15 maha - for request 4946
//		ll_pd_affil_stat = lds_pd_affil_stat.Find( "parent_facility_id = " + String(ai_facility_ids[ i ]) ,1 ,lds_pd_affil_stat.rowcount())
//		If ll_pd_affil_stat > 0 Then ls_app_type = lds_pd_affil_stat.Getitemstring(ll_pd_affil_stat, "apptmnt_type"
		
		ll_pd_affil_stat = lds_pd_affil_stat.Find( "rec_id = " + String(al_rec_ids[ i ]) ,1 ,lds_pd_affil_stat.rowcount()) 
		
		If ll_pd_affil_stat > 0 Then 
			ls_app_type = lds_pd_affil_stat.Getitemstring(ll_pd_affil_stat, "apptmnt_type")
			ldt_sent = lds_pd_affil_stat.Getitemdatetime(ll_pd_affil_stat, "date_app_sent")
			ldt_rcvd = lds_pd_affil_stat.Getitemdatetime(ll_pd_affil_stat, "date_app_rcvd")
			ldt_signed = lds_pd_affil_stat.Getitemdatetime(ll_pd_affil_stat, "date_app_signed")
		end if
		//End Code Change ----01.22.2016
		
		lds_miss_data.SetFilter( "appt_stat_id = " + String(al_rec_ids[i]))
		
		lds_miss_data.Filter( )
		li_miss_cnt = lds_miss_data.RowCount()
		For m = 1 To li_miss_cnt
			//			choose case m
			//				case 30,31,32,33,34,35
			//					messagebox("Missing information",m)
			//			end choose
			If m > 80 Then //new trap 110304   //Start Code Change ----02.09.2017 #V153 maha - modified to 80
				MessageBox("Missing information","There are more than 80 missing items.  This letter will generate only the first 80.")
				Exit
			Else
			
				//if m <= 60 then //trap for too many items maha 071403
				//maha notes: This function pulls into the letter the fax_message value from the practitioner record
				// this is appropriate particularly because of auto generated values
				//if the audit painter records are modified, those changes will not show up in the missing letters for 
				//preexisting records.  The appropriate way to 'correct' those records is to delete the existing record and 
				//add using the add missing function
				ls_descr = lds_miss_data.GetItemString( m, "pd_app_audit_fax_message" )
				ls_note = lds_miss_data.GetItemString( m, "notes" )
				ls_reference = lds_miss_data.GetItemString( m, "identifying_number" )
				ls_status = lds_miss_data.GetItemString( m, "status_desc" )   //Start Code Change ----10.14.2015 #V15 maha
				lds_address_info.SetItem( 1, "cmissing_info_" + String( m ), ls_descr )
				lds_address_info.SetItem( 1, "missing_info__note_" + String( m ), ls_note )
				lds_address_info.SetItem( 1, "missing_info_reference_" + String( m ), ls_note )
				lds_address_info.SetItem( 1, "missing_info_status_" + String( m ), ls_status )  //Start Code Change ----10.14.2015 #V15 maha
			End If
		Next
		
		//ADD VERIFICATIONS
		If li_add_verifs = 1 Then //maha 071403
		
			ll_pd_affil_stat_verifying_facility = lds_pd_affil_stat_verifying_facility.Find( "prac_id = " + String(al_prac_ids[ i ]) +&
			" and parent_facility_id = " + String(ai_facility_ids[ i ]),1 ,lds_pd_affil_stat_verifying_facility.rowcount()) 
			If ll_pd_affil_stat_verifying_facility > 0 Then ll_ver_fac = lds_pd_affil_stat_verifying_facility.GetitemNumber(ll_pd_affil_stat_verifying_facility, "verifying_facility")
				
			ll_facil[1] = ai_facility_ids[ i ] //copy the facilid into an array for retrieval
			If ll_ver_fac <> ll_facil[1] Then ll_facil[2] = ll_ver_fac //add ver facility to array if different
			
			lds_verifs.Setfilter("prac_id = " + String(al_prac_ids[ i ]) + " and IsNull( response_code ) and screen_id > 1")
			lds_verifs.Filter( )
			li_miss_cnt = lds_verifs.RowCount()
			//
			For m = 1 To li_miss_cnt //get the incomplete verifications
			//Start Code Change ---- 05.17.2006 #456 maha changed from 60 to 30
			if m > 30 then //new trap 110304
				messagebox("Missing information","There are more than 30 incomplete verification items.  This letter will generate only the first 30.")
			//End Code Change---05.17.2006
					Exit
				Else
					//if m <= 60 then //trap for too many items maha 071403
					ls_descr = lds_verifs.GetItemString( m, "reference_value" )
					lds_address_info.SetItem( 1, "verif_info_" + String( m ), ls_descr )
					lds_address_info.SetItem( 1, "verif_screen_" + String( m ), lds_verifs.GetItemString( m, "screen" ) )
					lds_address_info.SetItem( 1, "verif_note_" + String( m ), lds_verifs.GetItemString( m, "notes" ) )
				End If
			Next
		End If


		lds_address_info.SetItem( 1, "cnumber_of_requests", li_attempts + 1 )   //Start Code Change ----09.03.2015 #V15 maha - readded
		//Start Code Change ----01.22.2016 #V15 maha - for request 4946
		lds_address_info.SetItem( 1, "cdate_app_sent", string(ldt_sent ,"mm/dd/yyyy" ) )
		lds_address_info.SetItem( 1, "cdate_app_rcvd", string(ldt_rcvd ,"mm/dd/yyyy") )
		lds_address_info.SetItem( 1, "cdate_app_signed", string(ldt_signed, "mm/dd/yyyy"  )) 
		//Start Code Change ----01.22.2016
		

		//Start Code Change ----01.22.2016 #V15 maha - for request 4946
		ll_find = lds_codelookup_affil_dept_description.Find( "rec_id = " + String(al_rec_ids[ i ]) ,1 ,lds_codelookup_affil_dept_description.rowcount()) 
		if ll_find > 0 then
			ls_dept = lds_codelookup_affil_dept_description.GetitemString(ll_find, "department_name")
			lds_address_info.SetItem( 1, "prime_dept", ls_dept )
			ls_dept = lds_codelookup_affil_dept_description.GetitemString(ll_find, "section_name")
			lds_address_info.SetItem( 1, "prime_section", ls_dept )
			ls_dept = lds_codelookup_affil_dept_description.GetitemString(ll_find, "division_name")
			lds_address_info.SetItem( 1, "prime_division", ls_dept )
		end if
		
		ll_find = lds_codelookup_affil_staff_description.Find( "rec_id = " + String(al_rec_ids[ i ]) ,1 ,lds_codelookup_affil_staff_description.rowcount())
		if ll_find > 0 then
			ls_dept = lds_codelookup_affil_staff_description.GetitemString(ll_find, "description")
			lds_address_info.SetItem( 1, "staff_cat", ls_dept )
		end if
		
//		ll_codelookup_affil_dept_description = lds_codelookup_affil_dept_description.Find( "prac_id = " + String(al_prac_ids[ i ]) +&
//		" and facility_id = " + String(ai_facility_ids[ i ]) + " and lookup_code = department",1 ,lds_codelookup_affil_dept_description.rowcount()) 
//		If ll_codelookup_affil_dept_description > 0 Then ls_dept = lds_codelookup_affil_dept_description.GetitemString(ll_codelookup_affil_dept_description, "description")
//		lds_address_info.SetItem( 1, "prime_dept", ls_dept )
//		ls_dept = '' //clear or the next blank will duplicate
//
//		ll_codelookup_affil_dept_description = lds_codelookup_affil_dept_description.Find( "prac_id = " + String(al_prac_ids[ i ]) +&
//		" and facility_id = " + String(ai_facility_ids[ i ]) + " and lookup_code = section",1 ,lds_codelookup_affil_dept_description.rowcount()) 
//		If ll_codelookup_affil_dept_description > 0 Then ls_dept = lds_codelookup_affil_dept_description.GetitemString(ll_codelookup_affil_dept_description, "description")
//		lds_address_info.SetItem( 1, "prime_section", ls_dept )
//		ls_dept = '' //clear or the next blank will duplicate
//
//		ll_codelookup_affil_dept_description = lds_codelookup_affil_dept_description.Find( "prac_id = " + String(al_prac_ids[ i ]) +&
//		" and facility_id = " + String(ai_facility_ids[ i ]) + " and lookup_code = rank",1 ,lds_codelookup_affil_dept_description.rowcount()) 
//		If ll_codelookup_affil_dept_description > 0 Then ls_dept = lds_codelookup_affil_dept_description.GetitemString(ll_codelookup_affil_dept_description, "description")
//		lds_address_info.SetItem( 1, "prime_division", ls_dept )
//		ls_dept = '' //clear or the next blank will duplicate

//		ll_codelookup_affil_staff_description = lds_codelookup_affil_staff_description.Find( "prac_id = " + String(al_prac_ids[ i ]) +&
//		" and facility_id = " + String(ai_facility_ids[ i ]) ,1 ,lds_codelookup_affil_staff_description.rowcount()) 
//		If ll_codelookup_affil_staff_description > 0 Then ls_dept = lds_codelookup_affil_staff_description.GetitemString(ll_codelookup_affil_staff_description, "description")
//		lds_address_info.SetItem( 1, "staff_cat", ls_dept )
		ls_dept = '' //clear or the next blank will duplicate
//End Code Change ----01.22.2016
	

		
		
		ls_fax_number = lds_address_info.GetItemString( 1, "fax" )
		ls_local_area_code = ProfileString(gs_IniFilePathName, "Setup","local_area_code", "None")
		
		If IsNull( ls_local_area_code ) Or ls_local_area_code = "" Then
			MessageBox("Setup Error", "You must setup your local area code in the INTELLICRED.INI file under the [setup] section.")
			//--------------------------- APPEON BEGIN ---------------------------
			//$<Add> 08.22.2007 By: Evan
			//$<Reason> Need to destroy object.
			if IsValid(lds_pd_affil_stat) then Destroy lds_pd_affil_stat
			if IsValid(lds_pd_affil_stat_verifying_facility) then Destroy lds_pd_affil_stat_verifying_facility
			if IsValid(lds_codelookup_affil_staff_description) then Destroy lds_codelookup_affil_staff_description
			if IsValid(lds_verifs) then Destroy lds_verifs
			if IsValid(lds_miss_data) then Destroy lds_miss_data
			if IsValid(lds_address_info) then Destroy lds_address_info
			if IsValid(lds_tracker) then Destroy lds_tracker
			if IsValid(lds_copy) then Destroy lds_copy
			//---------------------------- APPEON END ----------------------------
			Return -1
		End If
		
		If PosA( ls_fax_number, "(" ) > 0 Then
			If MidA(ls_fax_number, PosA( ls_fax_number, "(" ) +1 ,3) = ls_local_area_code Then
				ls_fax_number = MidA( ls_fax_number, PosA( ls_fax_number, ")" ) +1, 100 )
			End If
		Else
			If MidA(ls_fax_number,1,3) = ls_local_area_code Then
				ls_fax_number = MidA( ls_fax_number, 4, 100 )
			End If
		End If
		
		lds_address_info.SetItem( 1, "fax", ls_fax_number )
	End If
	
	lds_address_info.RowsCopy(1,1,primary!,lds_copy,10000,primary!)
	
Next

If lds_copy.RowCount() < 1 Then
	if IsValid(lds_pd_affil_stat) then Destroy lds_pd_affil_stat
	if IsValid(lds_pd_affil_stat_verifying_facility) then Destroy lds_pd_affil_stat_verifying_facility
	if IsValid(lds_codelookup_affil_staff_description) then Destroy lds_codelookup_affil_staff_description
	if IsValid(lds_verifs) then Destroy lds_verifs
	if IsValid(lds_miss_data) then Destroy lds_miss_data
	if IsValid(lds_address_info) then Destroy lds_address_info
	if IsValid(lds_tracker) then Destroy lds_tracker
	if IsValid(lds_copy) then Destroy lds_copy
	Return -1
	//---------------------------- APPEON END ----------------------------	
End If

lds_copy.SaveAs( ls_open_merge + "missing_info_request.txt", Text!, True ) //maha moved outside of loop 072903
ls_open_merge = ls_open_merge + "missing_info_request.txt"

Integer li_word_storage_type
li_word_storage_type = Integer(gnv_data.of_getitem( "icred_settings", "set_50", FALSE))
IF Isnull(li_word_storage_type) THEN li_word_storage_type = 0
IF Upper( AppeonGetClientType() ) = "PB" AND li_word_storage_type = 0 THEN
	Select facility.letter_path
		Into :ls_letter_path
		From facility
		Where facility.facility_id = :ai_facility_ids[1]   ;
ELSE

	//Missing Info Letter:Store the letter_path in variable from facility_id = 1
	n_appeon_storage_area lnv_storage_area
	//--------------------------- APPEON BEGIN ---------------------------
	//$<Modify> 2007.06.22 By: Scofield
	//$<Reason> Fix a defect.
	IF lnv_storage_area.of_retrieve_doc_from_db(ai_facility_ids[1], ls_file_name, ls_letter_path) < 0 THEN
	//---------------------------- APPEON END ----------------------------		
		IF lnv_storage_area.of_retrieve_doc_from_db( 1, ls_file_name, ls_letter_path) < 0 THEN
			Messagebox("Download File",'The MSWord document '+  ls_file_name  +'  does not exist in the database.')
			//--------------------------- APPEON BEGIN ---------------------------
			//$<Add> 08.22.2007 By: Evan
			//$<Reason> Need to destroy object.
			if IsValid(lds_pd_affil_stat) then Destroy lds_pd_affil_stat
			if IsValid(lds_pd_affil_stat_verifying_facility) then Destroy lds_pd_affil_stat_verifying_facility
			if IsValid(lds_codelookup_affil_staff_description) then Destroy lds_codelookup_affil_staff_description
			if IsValid(lds_verifs) then Destroy lds_verifs
			if IsValid(lds_miss_data) then Destroy lds_miss_data
			if IsValid(lds_address_info) then Destroy lds_address_info
			if IsValid(lds_tracker) then Destroy lds_tracker
			if IsValid(lds_copy) then Destroy lds_copy
			//---------------------------- APPEON END ----------------------------
			RETURN -1
		END IF
	END IF
END IF

//---------------------------- APPEON END ----------------------------

If SQLCA.SQLCode = -1 Then
	MessageBox("SQL ERROR", SQLCA.SQLErrText )	

	if IsValid(lds_pd_affil_stat) then Destroy lds_pd_affil_stat
	if IsValid(lds_pd_affil_stat_verifying_facility) then Destroy lds_pd_affil_stat_verifying_facility
	if IsValid(lds_codelookup_affil_staff_description) then Destroy lds_codelookup_affil_staff_description
	if IsValid(lds_verifs) then Destroy lds_verifs
	if IsValid(lds_miss_data) then Destroy lds_miss_data
	if IsValid(lds_address_info) then Destroy lds_address_info
	if IsValid(lds_tracker) then Destroy lds_tracker
	if IsValid(lds_copy) then Destroy lds_copy
	Return -1
	//---------------------------- APPEON END ----------------------------		
End If

ls_word_path = ProfileString(gs_IniFilePathName, "paths", "word", "None")


If li_set6 = 1 Then
	//messagebox("ls_path",ls_path)
	If Upper(ls_letter_path) = Upper(ls_run_path) Then //maha 050602 trap against copying to same location
		MessageBox("Setting Problem","Your letter path is set to " + gs_temp_path + "letters\standard\ ~rand the Copy Letters setting is turned on. ~rGo to System->Utilities->Application Settings and set the Copy Letters setting to No to run letters normally.")
	
		if IsValid(lds_pd_affil_stat) then Destroy lds_pd_affil_stat
		if IsValid(lds_pd_affil_stat_verifying_facility) then Destroy lds_pd_affil_stat_verifying_facility
		if IsValid(lds_codelookup_affil_staff_description) then Destroy lds_codelookup_affil_staff_description
		if IsValid(lds_verifs) then Destroy lds_verifs
		if IsValid(lds_miss_data) then Destroy lds_miss_data
		if IsValid(lds_address_info) then Destroy lds_address_info
		if IsValid(lds_tracker) then Destroy lds_tracker
		if IsValid(lds_copy) then Destroy lds_copy
		Return -1
		//---------------------------- APPEON END ----------------------------			
	End If
	
	//check to make sure letter and path exists
	If Not FileExists( ls_letter_path + "ind_missing_info_request.doc" ) Then
		MessageBox("Print Error", "Cannot find word letter " + "ind_missing_info_request.doc" + " in directory: " + ls_letter_path )
		
		if IsValid(lds_pd_affil_stat) then Destroy lds_pd_affil_stat
		if IsValid(lds_pd_affil_stat_verifying_facility) then Destroy lds_pd_affil_stat_verifying_facility
		if IsValid(lds_codelookup_affil_staff_description) then Destroy lds_codelookup_affil_staff_description
		if IsValid(lds_verifs) then Destroy lds_verifs
		if IsValid(lds_miss_data) then Destroy lds_miss_data
		if IsValid(lds_address_info) then Destroy lds_address_info
		if IsValid(lds_tracker) then Destroy lds_tracker
		if IsValid(lds_copy) then Destroy lds_copy
		Return -1
		//---------------------------- APPEON END ----------------------------			
	Else
		ls_from  = ls_letter_path + ls_file_name
	End If
	
	ls_to = ls_run_path + ls_file_name
	//copy letter to c drive then run
	If FileExists(ls_to) Then
		If FileDelete( ls_to) = False Then //maha040705
			MessageBox("Copying letter from server","Unable to delete existing letter " + ls_doc_name + " in " + gs_temp_path + "letters\standard\ prior to copy.~r  Check letter properties to see if letter is Read Only.")
		End If
	End If
	//Run( ls_path + "copyltr.bat " + as_doc_name, Minimized! )
	CopyFileA( ls_from, ls_to, True )
	ls_doc_name = ls_to
	Do While Not FileExists( ls_to )
		ll_loop_count++
		If ll_loop_count = 1000000 Then
			MessageBox("Timeout", "Timed out trying to copy Word file." )
			Exit
		End If
	Loop
Else
	ls_doc_name = ls_letter_path + ls_file_name
End If

If Not FileExists( ls_doc_name ) Then
	MessageBox("Open Letter Error", "Invalid Word Letter path: " + ls_doc_name  )
	//--------------------------- APPEON BEGIN ---------------------------
	//$<Add> 08.22.2007 By: Evan
	//$<Reason> Need to destroy object.	
	if IsValid(lds_pd_affil_stat) then Destroy lds_pd_affil_stat
	if IsValid(lds_pd_affil_stat_verifying_facility) then Destroy lds_pd_affil_stat_verifying_facility
	if IsValid(lds_codelookup_affil_staff_description) then Destroy lds_codelookup_affil_staff_description
	if IsValid(lds_verifs) then Destroy lds_verifs
	if IsValid(lds_miss_data) then Destroy lds_miss_data
	if IsValid(lds_address_info) then Destroy lds_address_info
	if IsValid(lds_tracker) then Destroy lds_tracker
	if IsValid(lds_copy) then Destroy lds_copy
	//---------------------------- APPEON END ----------------------------	
	Return -1
End If

If li_set6 = 5 Then
	If Not FileExists( ls_word_path ) Then
		//MessageBox("Print Error", "Invalid MS Word for Windows path set in ini file: " + ls_word_path )
		MessageBox("Print Error", "Invalid MS Word for Windows path set in INI file: " + ls_word_path )
		//--------------------------- APPEON BEGIN ---------------------------
		//$<Add> 08.22.2007 By: Evan
		//$<Reason> Need to destroy object.	
		if IsValid(lds_pd_affil_stat) then Destroy lds_pd_affil_stat
		if IsValid(lds_pd_affil_stat_verifying_facility) then Destroy lds_pd_affil_stat_verifying_facility
		if IsValid(lds_codelookup_affil_staff_description) then Destroy lds_codelookup_affil_staff_description
		if IsValid(lds_verifs) then Destroy lds_verifs
		if IsValid(lds_miss_data) then Destroy lds_miss_data
		if IsValid(lds_address_info) then Destroy lds_address_info
		if IsValid(lds_tracker) then Destroy lds_tracker
		if IsValid(lds_copy) then Destroy lds_copy
		//---------------------------- APPEON END ----------------------------			
		Return -1
	End If
	//MessageBox("ls_open_merge",ls_open_merge)
	//MessageBox("ls_open_merge",ls_open_merge)
	Run( ls_word_path +  " " + ls_doc_name + " /mpreview", Maximized! )
Else
	// mskinner 04 oct 2005 - begin
	gnv_app.gnvlo_msword.of_open_word_document( ls_doc_name, ls_open_merge, "Missing Information")
	//of_open_letter(ls_doc_name, ls_open_merge,"Missing Information")
	// mskinner 04 oct 2005 - end
End If

gs_fax lgs_fax
n_ds lds_letters
Integer li_Retval

lgs_fax.ss_message = "Did the Missing Information Letter print ok?"
//lgs_fax.ss_letter_document_name = ls_doc_name + " /mpreview"
lgs_fax.ss_letter_document_name = ls_file_name //Ken.Guo 11/01/2007
lgs_fax.ss_letter_name = "Missing Information Letter"
lgs_fax.sdw_letter = lds_copy
lgs_fax.ss_letter_type = "MissInfo"

OpenWithParm( w_ai_print_msg_box, lgs_fax )

gs_fax_error_records lst_fax_error_records
lst_fax_error_records = Message.PowerObjectParm
If lst_fax_error_records.il_error_rec_num[ 1 ] = -2 Then
	//--------------------------- APPEON BEGIN ---------------------------
	//$<Add> 08.22.2007 By: Evan
	//$<Reason> Need to destroy object.	
	if IsValid(lds_pd_affil_stat) then Destroy lds_pd_affil_stat
	if IsValid(lds_pd_affil_stat_verifying_facility) then Destroy lds_pd_affil_stat_verifying_facility
	if IsValid(lds_codelookup_affil_staff_description) then Destroy lds_codelookup_affil_staff_description
	if IsValid(lds_verifs) then Destroy lds_verifs
	if IsValid(lds_miss_data) then Destroy lds_miss_data
	if IsValid(lds_address_info) then Destroy lds_address_info
	if IsValid(lds_tracker) then Destroy lds_tracker
	if IsValid(lds_copy) then Destroy lds_copy
	//---------------------------- APPEON END ----------------------------	
	Return -1
End If

//Lexi and Sammy are the best		


For i = 1 To li_prac_cnt
	r = 	adw.InsertRow(0)


	
	IF ll_seq_no = 0 then
		Select max(seq_no)
		Into :ll_seq_no
		From pd_app_audit_attempts
		Where record_id = :al_rec_ids[i];
	End If

	//---------------------------- APPEON END ----------------------------

	If IsNull(ll_seq_no) Then ll_seq_no = 0
	ll_seq_no++

	adw.SetItem(r,"rec_id",al_rec_ids[i])
	adw.SetItem(r,"prac_id",al_prac_ids[i])
	adw.SetItem(r,"facility_id",ai_facility_ids[i])
	adw.SetItem(r,"seq_no",ll_seq_no)
	adw.SetItem(r,"date_attempted",Today())
	adw.SetItem(r,"user_name",gs_user_id)
	// start code change --- 11.17.2005 MSKINNER
	Choose Case lst_fax_error_records.il_error_rec_num[ 1 ]
		Case -5
			adw.SetItem(r,"method","Fax")
		Case -4
			adw.SetItem(r,"method","Email")
		Case Else
			adw.SetItem(r,"method","Letter")
	End Choose
Next

gnv_appeondb.of_autocommit( )
//---------------------------- APPEON END ----------------------------

if li_prac_cnt > 0 and adw.GetItemStatus(1,0,Primary!) = new! then
	//delete blank line
	adw.DeleteRow(1)
end if

adw.Update()
Commit Using SQLCA;


if IsValid(lds_pd_affil_stat) then Destroy lds_pd_affil_stat
if IsValid(lds_pd_affil_stat_verifying_facility) then Destroy lds_pd_affil_stat_verifying_facility
if IsValid(lds_codelookup_affil_staff_description) then Destroy lds_codelookup_affil_staff_description
if IsValid(lds_verifs) then Destroy lds_verifs
if IsValid(lds_miss_data) then Destroy lds_miss_data
if IsValid(lds_address_info) then Destroy lds_address_info
if IsValid(lds_tracker) then Destroy lds_tracker
if IsValid(lds_copy) then Destroy lds_copy
//---------------------------- APPEON END ----------------------------

Return 0



end function

on pfc_cst_u_generate_miss_info_rqst_apb.create
call super::create
TriggerEvent( this, "constructor" )
end on

on pfc_cst_u_generate_miss_info_rqst_apb.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

