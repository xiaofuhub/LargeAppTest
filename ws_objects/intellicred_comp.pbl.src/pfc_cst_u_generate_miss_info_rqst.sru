$PBExportHeader$pfc_cst_u_generate_miss_info_rqst.sru
forward
global type pfc_cst_u_generate_miss_info_rqst from userobject
end type
end forward

global type pfc_cst_u_generate_miss_info_rqst from userobject
integer width = 2016
integer height = 1208
boolean border = true
long backcolor = 67108864
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type
global pfc_cst_u_generate_miss_info_rqst pfc_cst_u_generate_miss_info_rqst

type variables

end variables

forward prototypes
public function integer of_dial_phone (string as_phone)
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

public function integer of_generate_miss_info_letter (integer ai_facility_ids[], long al_prac_ids[], long al_rec_ids[], datawindow adw);//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

//THIS OBJECT IS NO LONGER USED!!!//maha using pfc_cst_u_generate_miss_info_rqst_apb
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

//n_ds lds_miss_data
//n_ds lds_address_info
//n_ds lds_copy
//n_ds lds_tracker
//n_ds lds_verifs
//String ls_app_type
//String ls_descr
//String ls_local_area_code
//String ls_fax_number
//String ls_word_path
//String ls_letter_path
//string ls_open_merge
//Integer li_prac_cnt
//Integer i
//Integer m
//integer r //maha 012301
//long ll_seq_no //maha 012301
//Integer li_address_rc
//Integer li_miss_cnt
//Integer li_attempts
//integer li_set6
//integer li_add_verifs
//string ls_dept //maha 090304
//string ls_from
//string ls_to
//string ls_file_name = "ind_missing_info_request.doc"
//string ls_doc_name
//string ls_note //maha 092403
//string ls_reference //maha 083104
//string ls_run_path //maha 021805
//long ll_loop_count
//long prac
//long ll_facil[]
//long ll_ver_fac
//
////SELECT set_30 INTO :li_add_verifs FROM icred_settings; //maha 071403 for adding verification to letter
//li_add_verifs = of_get_app_setting("set_30","I")
//li_set6 = of_get_app_setting("set_6","I")
//
////Start Code Change ---- 01.23.2006 #216 maha
//ls_run_path = of_letter_paths("L")
//ls_open_merge = of_letter_paths("D")
////End Code Change---01.23.2006
//
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-24
////$<add> 06.08.2006 By: Rodger Wu
////$<reason> Performance tuning
////$<modification> Create the downloading directory if it does not exist.
//n_appeon_download lnv_download
//If gnv_data.of_getitem('icred_settings' ,'set_50' , False ) = '1' or &
//   Upper( appeongetclienttype() ) = 'WEB' Then
//	lnv_download.of_parsepath( ls_open_merge)
//End If
////---------------------------- APPEON END ----------------------------
//
//li_prac_cnt = UpperBound( al_prac_ids )
//
//lds_miss_data = CREATE n_ds
//lds_miss_data.DataObject = "d_pd_app_audit_rqrd_data"
//lds_miss_data.of_SetTransObject( SQLCA )
//
//IF li_add_verifs = 1 THEN //maha 071403 for verifs on letter
//	lds_address_info = CREATE n_ds
//	lds_address_info.DataObject = "d_pd_app_audit_miss_rqst_data_w_vers"
//	lds_address_info.of_SetTransObject( SQLCA )
//	lds_copy = CREATE n_ds //copy
//	lds_copy.DataObject = "d_pd_app_audit_miss_rqst_data_w_vers"
//	lds_copy.of_SetTransObject( SQLCA )
//else
//	lds_address_info = CREATE n_ds //normal
//	lds_address_info.DataObject = "d_pd_app_audit_miss_rqst_data"
//	lds_address_info.of_SetTransObject( SQLCA )
//	lds_copy = CREATE n_ds //copy ds  maha072903
//	lds_copy.DataObject = "d_pd_app_audit_miss_rqst_data"
//	lds_copy.of_SetTransObject( SQLCA )
//end if
////this function originally designed for 1 letter at a time.  Redesigned 07-03 for action items.
//lds_tracker = CREATE n_ds
//lds_tracker.DataObject = "d_pd_app_audit_tracker"
//lds_tracker.of_SetTransObject( SQLCA )
//
//IF li_add_verifs = 1 THEN //maha 071403
//	lds_verifs = CREATE n_ds
//	lds_verifs.DataObject = "d_ver_summary_record_view"
//	lds_verifs.of_SetTransObject( SQLCA )
//end if
//
//
//FOR i = 1 TO li_prac_cnt
//	li_attempts = lds_tracker.Retrieve( al_rec_ids[ i ]) 
//	li_address_rc = lds_address_info.Retrieve( ai_facility_ids[ i ], al_prac_ids[ i ] )
//	//MessageBox("li_address_rc",li_address_rc)
//	IF li_address_rc < 1 THEN
//		MessageBox("Address", "You must have a mailing address links for practitioner id of " + string(al_prac_ids[ i ]) + " for facility_id " + string(ai_facility_ids[ i ]) + " before using this option.")
//		continue//GOTO ERROR
//	ELSE
//
////		SELECT pd_affil_stat.apptmnt_type  
////		INTO :ls_app_type  
////		FROM pd_affil_stat  
////		WHERE ( pd_affil_stat.parent_facility_id = :ai_facility_ids[ i ] ) AND  
////				( pd_affil_stat.active_status in (1,4) );  //maha  changed to include pending 072402
//		//ls_app_type = lds_address_info.GetItemString( 1, "appointment_type" )
//		li_miss_cnt = lds_miss_data.Retrieve( al_rec_ids[i] )
//		debugbreak()
//		lds_miss_data.SetFilter( "IsNull( date_completed )" )
//		lds_miss_data.Filter( )
//		li_miss_cnt = lds_miss_data.RowCount()
//		FOR m = 1 TO li_miss_cnt
////			choose case m
////				case 30,31,32,33,34,35
////					messagebox("Missing information",m)
////			end choose
//			//Start Code Change ---- 05.17.2006 #456 maha changed from 60 to 30
//			if m > 60 then //new trap 110304
//				messagebox("Missing information","There are more than 60 missing items.  This letter will generate only the first 60.")
//				exit
//			else
//			//if m <= 60 then //trap for too many items maha 071403
//				ls_descr = lds_miss_data.GetItemString( m, "pd_app_audit_fax_message" )
//				ls_note = lds_miss_data.GetItemString( m, "notes" )
//				ls_reference = lds_miss_data.GetItemString( m, "identifying_number" )
//				lds_address_info.SetItem( 1, "cmissing_info_" + String( m ), ls_descr )
//				lds_address_info.SetItem( 1, "missing_info__note_" + String( m ), ls_note )
//				lds_address_info.SetItem( 1, "missing_info_reference_" + String( m ), ls_reference ) //Start Code Change ---- 09.24.2007 #V7 maha; changed from setting with ls_note
//			end if
//		END FOR
//		
//		IF li_add_verifs = 1 THEN //maha 071403
//			select verifying_facility into :ll_ver_fac from pd_affil_stat 
//			where prac_id = :al_prac_ids[ i ] and parent_facility_id = :ai_facility_ids[ i ] and active_status in (1,4);
//			ll_facil[1] = ai_facility_ids[ i ] //copy the facilid into an array for retrieval
//			if ll_ver_fac <> ll_facil[1] then ll_facil[2] = ll_ver_fac //add ver facility to array if different
//			li_miss_cnt = lds_verifs.Retrieve( 1,al_prac_ids[ i ],ll_facil[ ])
//			lds_verifs.SetFilter( "IsNull( response_code ) and screen_id > 1"  )
//			lds_verifs.Filter( )
//			li_miss_cnt = lds_verifs.RowCount()
//			//MessageBox("li_miss_cnt fil",li_miss_cnt)
//			FOR m = 1 TO li_miss_cnt //get the incomplete verifications
//			//Start Code Change ---- 05.17.2006 #456 maha changed from 60 to 30
//			if m > 30 then //new trap 110304
//				messagebox("Missing information","There are more than 30 incomplete verification items.  This letter will generate only the first 30.")
//			//End Code Change---05.17.2006
//				exit
//			else
//				//if m <= 60 then //trap for too many items maha 071403
//					ls_descr = lds_verifs.GetItemString( m, "reference_value" )
//					lds_address_info.SetItem( 1, "verif_info_" + String( m ), ls_descr )
//					lds_address_info.SetItem( 1, "verif_screen_" + String( m ), lds_verifs.GetItemString( m, "screen" ) )
//					lds_address_info.SetItem( 1, "verif_note_" + String( m ), lds_verifs.GetItemString( m, "notes" ) )
//				end if
//			END FOR
//		end if
//		
//		//\/maha 090304 dept and staff cat data
//		//Start Code Change ----04.19.2011 #V11 maha - added qualifier for facility_id filter.
//		select description into :ls_dept from code_lookup, pd_affil_dept where lookup_code = department and primary_dept = 1 and prac_id = :al_prac_ids[ i ] and pd_affil_dept.facility_id = :ai_facility_ids[ i ] and active_status in (1,4); 
//		lds_address_info.SetItem( 1, "prime_dept", ls_dept )
//		ls_dept = '' //clear or the next blank will duplicate
//		select description into :ls_dept from code_lookup, pd_affil_dept where lookup_code = section and primary_dept = 1 and prac_id = :al_prac_ids[ i ] and pd_affil_dept.facility_id = :ai_facility_ids[ i ] and active_status in (1,4); 
//		lds_address_info.SetItem( 1, "prime_section", ls_dept )
//		ls_dept = ''
//		select description into :ls_dept from code_lookup, pd_affil_dept where lookup_code = rank and primary_dept = 1 and prac_id = :al_prac_ids[ i ] and pd_affil_dept.facility_id = :ai_facility_ids[ i ] and active_status in (1,4); 
//		lds_address_info.SetItem( 1, "prime_division", ls_dept )
//		ls_dept = ''
//		select description into :ls_dept from code_lookup, pd_affil_staff_cat where lookup_code = staff_category and requested = 1 and prac_id = :al_prac_ids[ i ] and pd_affil_staff_cat.facility_id = :ai_facility_ids[ i ] and active_status in (1,4); 
//		lds_address_info.SetItem( 1, "staff_cat", ls_dept )
//		//End Code Change ----04.19.2011
//		//\maha
//		lds_address_info.SetItem( 1, "cnumber_of_requests", li_attempts )
//		
//		ls_fax_number = lds_address_info.GetItemString( 1, "fax" )
//		ls_local_area_code = ProfileString(gs_IniFilePathName, "Setup","local_area_code", "None")
//	
//		IF IsNull( ls_local_area_code ) OR ls_local_area_code = "" THEN
//			MessageBox("Setup Error", "You must setup your local area code in the INTELLICRED.INI file under the [setup] section.")
//			Return -1
//		END IF
//	
//		IF PosA( ls_fax_number, "(" ) > 0 THEN
//			IF MidA(ls_fax_number, PosA( ls_fax_number, "(" ) +1 ,3) = ls_local_area_code THEN
//				ls_fax_number = MidA( ls_fax_number, PosA( ls_fax_number, ")" ) +1, 100 )
//			END IF
//		ELSE
//			IF MidA(ls_fax_number,1,3) = ls_local_area_code THEN
//				ls_fax_number = MidA( ls_fax_number, 4, 100 )
//			END IF	
//		END IF
//		
//		lds_address_info.SetItem( 1, "fax", ls_fax_number )
//	End if
//	
//	lds_address_info.Rowscopy(1,1,primary!,lds_copy,10000,primary!)
//	
//END FOR
//
//if lds_copy.rowcount() < 1 then
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<ID> UM-01
//	//$<modify> 03.13.2006 By: LiuHongXin
//	//$<reason> The Goto statement is currently unsupported.
//	//$<modification> Copy the script associated with the GOTO label here.
//	/*
//	goto ERROR
//	*/
//	DESTROY lds_miss_data
//	DESTROY lds_address_info
//	DESTROY lds_tracker
//	DESTROY lds_copy
//	RETURN -1
//	//---------------------------- APPEON END ----------------------------
//end if
//
//lds_copy.SaveAs( ls_open_merge + "missing_info_request.txt", Text!, True ) //maha moved outside of loop 072903
//ls_open_merge = ls_open_merge + "missing_info_request.txt"
//
////for the letter path use the first facility
//SELECT facility.letter_path  
//INTO :ls_letter_path  
//FROM facility  
//WHERE facility.facility_id = :ai_facility_ids[1]   ;
//IF SQLCA.SQLCODE = -1 THEN
//	MessageBox("SQL ERROR", SQLCA.SQLERRTEXT )
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<ID> UM-02
//	//$<modify> 03.13.2006 By: LiuHongXin
//	//$<reason> The Goto statement is currently unsupported.
//	//$<modification> Copy the script associated with the GOTO label here.
//	/*
//	goto ERROR
//	*/
//	DESTROY lds_miss_data
//	DESTROY lds_address_info
//	DESTROY lds_tracker
//	DESTROY lds_copy
//	RETURN -1
//	//---------------------------- APPEON END ----------------------------
//END IF
//
//ls_word_path = ProfileString(gs_IniFilePathName, "paths", "word", "None")
//
////ls_word_path = "'" + ls_word_path + "'"  
//		//copy down to local drive from network?	//maha copied from ver letters 06/11/03	
//		//SELECT set_6 INTO :li_set6 FROM icred_settings;
//		//li_set6 = of_get_app_setting("set_6","I")
//		IF li_set6 = 1 THEN
//			//messagebox("ls_path",ls_path)
//			if upper(ls_letter_path) = upper(ls_run_path) then //maha 050602 trap against copying to same location
//				messagebox("Setting Problem","Your letter path is set to " + gs_dir_path + "intellicred\letters\standard\ ~rand the Copy Letters setting is turned on. ~rGo to System->Utilities->Application Settings and set the Copy Letters setting to No to run letters normally.")
//				//--------------------------- APPEON BEGIN ---------------------------
//				//$<ID> UM-03
//				//$<modify> 03.13.2006 By: LiuHongXin
//				//$<reason> The Goto statement is currently unsupported.
//				//$<modification> Copy the script associated with the GOTO label here.
//				/*
//				goto ERROR
//				*/
//				DESTROY lds_miss_data
//				DESTROY lds_address_info
//				DESTROY lds_tracker
//				DESTROY lds_copy
//				RETURN -1
//				//---------------------------- APPEON END ----------------------------
//
//			end if
//			
//			//check to make sure letter and path exists
//			IF NOT FileExists( ls_letter_path + "ind_missing_info_request.doc" ) THEN
//				MessageBox("Print Error", "Cannot find word letter " + "ind_missing_info_request.doc" + " in directory: " + ls_letter_path )
//				//--------------------------- APPEON BEGIN ---------------------------
//				//$<ID> UM-04
//				//$<modify> 03.13.2006 By: LiuHongXin
//				//$<reason> The Goto statement is currently unsupported.
//				//$<modification> Copy the script associated with the GOTO label here.
//							/*
//				goto ERROR
//				*/
//				DESTROY lds_miss_data
//				DESTROY lds_address_info
//				DESTROY lds_tracker
//				DESTROY lds_copy
//				RETURN -1
//				//---------------------------- APPEON END ----------------------------
//			else
//				ls_from  = ls_letter_path + ls_file_name
//			END IF
//		
//			ls_to = ls_run_path + ls_file_name
//				//copy letter to c drive then run
//				if fileexists(ls_to) then
//					if FileDelete( ls_to) = false then //maha040705
//						messagebox("Copying letter from server","Unable to delete existing letter " + ls_doc_name + " in " + gs_dir_path + "intellicred\letters\standard\ prior to copy.~r  Check letter properties to see if letter is Read Only.")
//					end if
//				end if
//				//messagebox("","copy " + as_doc_name + " C:\IntelliCred\Letters\Standard")
//				//Run( ls_path + "copyltr.bat " + as_doc_name, Minimized! )
//				CopyFileA( ls_from, ls_to, true )
//				ls_doc_name = ls_to //"c:\intellicred\letters\standard\" + ls_file_name
//				DO WHILE NOT FileExists( ls_to )
//					ll_loop_count++
//					IF ll_loop_count = 1000000 THEN
//						MessageBox("Timeout", "Timed out trying to copy Word file." )
//						EXIT
//					END IF
//				LOOP
//		else
//			ls_doc_name = ls_letter_path + ls_file_name 	
//		END IF
//
//IF NOT FileExists( ls_doc_name ) THEN
//	MessageBox("Open Letter Error", "Invalid Word Letter path: " + ls_doc_name  )
//	Return -1
//END IF
//
//if li_set6 = 5 then
//	IF NOT FileExists( ls_word_path ) THEN
//		MessageBox("Print Error", "Invalid MS Word for Windows path set in ini file: " + ls_word_path )
//		Return -1
//	END IF
//	//MessageBox("ls_open_merge",ls_open_merge)
//	//MessageBox("ls_open_merge",ls_open_merge)
//	Run( ls_word_path +  " " + ls_doc_name + " /mpreview", Maximized! )
//else
//	// mskinner 04 oct 2005 - begin
//	//Start Code Change ---- 03.27.2006 #344 maha
//	if gnv_app.gnvlo_msword.of_open_word_document( ls_doc_name, ls_open_merge, "Missing Information") = -1 then
//		return -1
//	end if
//	//End Code Change---03.27.2006
//	//of_open_letter(ls_doc_name, ls_open_merge,"Missing Information")
//	// mskinner 04 oct 2005 - end
//end if
//
//gs_fax lgs_fax
//n_ds lds_letters
//Integer li_Retval
//
//lgs_fax.ss_message = "Did the Missing Information Letter print ok?"
////lgs_fax.ss_letter_document_name = ls_doc_name + " /mpreview"
//lgs_fax.ss_letter_document_name = ls_file_name //Ken.Guo 11/01/2007
//lgs_fax.ss_mail_label_doc = ls_letter_path + "mailing_labels_prac_corro_letters.doc"//
//lgs_fax.ss_letter_name = "Missing Information Letter"
//lgs_fax.sdw_letter = lds_copy
//lgs_fax.ss_letter_type = "MissInfo"
//		
//OpenWithParm( w_ai_print_msg_box, lgs_fax )	
//	
//gs_fax_error_records lst_fax_error_records
//lst_fax_error_records = Message.PowerObjectParm
//IF lst_fax_error_records.il_error_rec_num[ 1 ] = -2 THEN		
//	Return -1
//END IF
//	
//
//for i = 1 to li_prac_cnt
//	r =	adw.insertrow(0)
//
//	select max(seq_no)
//	into :ll_seq_no
//	from pd_app_audit_attempts
//	where record_id = :al_rec_ids[i];
//	if isnull(ll_seq_no) then ll_seq_no = 0
//	ll_seq_no++
//	
//	adw.setitem(r,"rec_id",al_rec_ids[i])
//	adw.setitem(r,"prac_id",al_prac_ids[i])
//	adw.setitem(r,"facility_id",ai_facility_ids[i])
//	adw.setitem(r,"seq_no",ll_seq_no)
//	adw.setitem(r,"date_attempted",today())
//	adw.setitem(r,"user_name",gs_user_id)
//	// start code change --- 11.17.2005 MSKINNER
//	choose case lst_fax_error_records.il_error_rec_num[ 1 ]
//		case -5
//			adw.setitem(r,"method","Fax")
//		case -4
//			adw.setitem(r,"method","Email")
//		case else
//			adw.setitem(r,"method","Letter")
//	end choose 
//	//	IF lst_fax_error_records.il_error_rec_num[ 1 ] = -5 THEN		
//	//		adw.setitem(r,"method","Fax")
//	//	ELSE
//	//		adw.setitem(r,"method","Letter")
//	//	END IF
//next
//// end code change --- 11.17.2005 MSKINNER
//adw.update()
//commit using sqlca;
//
//
//DESTROY lds_miss_data
//DESTROY lds_address_info
//DESTROY lds_tracker
//DESTROY lds_copy
RETURN 0

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-05
//$<comment> 03.13.2006 By: LiuHongXin
//$<reason> The Goto statement is currently unsupported.
//$<modification> Move the scripts to the location of GOTO ERROR.
/*
ERROR:
DESTROY lds_miss_data
DESTROY lds_address_info
DESTROY lds_tracker
DESTROY lds_copy
RETURN -1
*/
//---------------------------- APPEON END ----------------------------

end function

on pfc_cst_u_generate_miss_info_rqst.create
end on

on pfc_cst_u_generate_miss_info_rqst.destroy
end on

