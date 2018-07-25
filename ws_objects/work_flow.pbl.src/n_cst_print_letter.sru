$PBExportHeader$n_cst_print_letter.sru
forward
global type n_cst_print_letter from nonvisualobject
end type
end forward

global type n_cst_print_letter from nonvisualobject autoinstantiate
end type

type variables
//Boolean ib_fax_num_email_search = False
Boolean ib_from_net_dev = False
//Boolean ib_from_prac_folder=True
//Boolean ib_from_case_review = False
//boolean ib_qa_letter // mskinner 16 nov 2004


/*pfc_cst_u_reports inv_reports

Integer il_current_wizard_step = 0
Integer il_wizard_step_cnt = 0

Integer il_facility_ids_all[]
Integer ii_app_ids[]
*/
//Integer il_facility_id
/*
Integer il_profile_view_id
Integer ii_letter_id

integer ii_batch_button

Long il_case_number


Long il_prac_ids[]
Long il_action_type[]
Long il_action_status[]
*/
/*
Date id_from
Date id_to
*/

n_ds  ids_print_letter
end variables

forward prototypes
public function integer of_print_letter (long al_letter_id, long al_rec_ids[], long al_prac_ids[], long al_facility_ids[], long al_seq_no[], long al_app_ids[])
public function integer of_init_net_dev ()
public function integer of_app_rcvd_prac ()
public function integer of_run_export (long ai_pracs[], integer ai_exp_id, ref string as_path)
end prototypes

public function integer of_print_letter (long al_letter_id, long al_rec_ids[], long al_prac_ids[], long al_facility_ids[], long al_seq_no[], long al_app_ids[]);
// MSKINNER COMMENTED OUT THE -- /mmail_labels PORTION OF THE STRING
long ll_loop_count
Boolean lb_error_rec

DateTime nulldate,ldt_first_date ,ldt_last_date
long nulllong,ll_number_sent
string ls_run_path
string ls_open_merge
string ls_doc_name
string ls_letter_name
string ls_exportname
integer res
integer li_export_on
integer li_row_cnt
integer li_ans
integer i
integer li_check
integer i2
long ll_prac_id_check
string ls_full_name
string ls_letter_path
string ls_word_path
integer li_set6
string ls_from
string ls_to
integer li_export_id,li_use_export
long ll_rowcount,ll_find
datastore lds_full_name

SetNull( nulldate )
SetNull( nulllong )

String ls_doc_name_nopath //Ken.Guo 11/01/2007

//Start Code Change ---- 01.23.2006 #214 maha
ls_run_path = of_letter_paths("L")
ls_open_merge = of_letter_paths("D")
//End Code Change---01.23.2006 

lds_full_name = create datastore
lds_full_name.dataobject = 'd_v_full_name'
lds_full_name.settransobject(sqlca)

gnv_appeondb.of_startqueue( )
//Gets Letter Info
select document_name,letter_name,export_id,use_export
into :ls_doc_name,:ls_letter_name,:li_export_id,:li_use_export
from sys_letters
where letter_id = :al_letter_id;

//Gets Action Item Info
if ib_from_net_dev then
	select first_sent,isnull(number_sent,0)
	into :ldt_first_date,:ll_number_sent
	from net_dev_action_items
	where rec_id = :al_rec_ids[1];
else
	select first_sent,isnull(number_sent,0)
	into :ldt_first_date,:ll_number_sent
	from verif_info
	where rec_id = :al_rec_ids[1] and prac_id = :al_prac_ids[1] and facility_id = :al_facility_ids[1] and seq_no = :al_seq_no[1];
end if

//Gets Full Name
ll_rowcount = lds_full_name.retrieve()

gnv_appeondb.of_commitqueue()
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-01
//$<add> 01.13.2006 By: Cao YongWang
//$<modification> Create the downloading directory if it does not exist.
n_appeon_storage_area lnv_storage_area
n_appeon_download lnv_download
If gnv_data.of_getitem('icred_settings' ,'set_50' , False ) = '1' or &
   Upper( appeongetclienttype() ) = 'WEB' Then
	lnv_download.of_parsepath( ls_open_merge)
End If
//---------------------------- APPEON END ----------------------------

//Credentialing Application Signature Follow up letter
//CHOOSE CASE tab_ltr.tabpage_criteria.dw_select_report.GetItemNumber( tab_ltr.tabpage_criteria.dw_select_report.GetRow( ), "letter_id" )
Choose case al_letter_id
	//Credentialing Application Signature Follow up letter( INDIVIDUAL PRACTITIONER)
	CASE 1001
		ids_print_letter.DataObject = "d_ltr_net_dev_app_rcvd_prac"
	//Credentialing Application Signature Follow up letter( ALL PRACTITIONERS)		
	CASE 1002
		ids_print_letter.DataObject = "d_ltr_net_dev_app_rcvd_prac_all"
	//Payer Follow up Letter (Individual)
	CASE 1003
		ids_print_letter.DataObject = "d_ltr_net_dev_app_rcvd_payer"		
	//Payer Follow up Letter (Individual)		
	CASE 1004
		ids_print_letter.DataObject = "d_ltr_net_dev_app_rcvd_payer_all"				
END CHOOSE //default is "d_ltr_general_corrospondence"
				
				
				
CHOOSE CASE ids_print_letter.DataObject
	CASE "d_ltr_general_corrospondence", "d_ltr_net_dev"
		ids_print_letter.of_SetTransObject( SQLCA )
		//li_row_cnt = ids_print_letter.retrieve( il_facility_id, il_prac_ids )				 
		li_row_cnt = ids_print_letter.retrieve( al_facility_ids[1], al_prac_ids )				 
	CASE "d_ltr_net_dev_app_rcvd_prac", "d_ltr_net_dev_app_rcvd_payer"
		ids_print_letter.of_SetTransObject( SQLCA )
		ids_print_letter.retrieve( al_prac_ids, al_facility_ids, al_app_ids )				 
		li_row_cnt = ids_print_letter.RowCount( )
		IF li_row_cnt = 0 THEN
			MessageBox( "No Data", "No data was returned.  Check the following: You need to have Par Action Type with an action status of Incomplete.  You need to have a mailing address setup.  For follow up with Payor letter you need to have the Credentialing Application setup under an organization in the application mapping utility.")
			destroy lds_full_name
			Return -1
		END IF		
		IF ids_print_letter.DataObject = "d_ltr_net_dev_app_rcvd_prac" THEN
			of_app_rcvd_prac( )
		END IF
		li_row_cnt = 1
	CASE "d_ltr_net_dev_app_rcvd_prac_all", "d_ltr_net_dev_app_rcvd_payer_all"
		ids_print_letter.SetTransObject( SQLCA )
		if upperbound(al_prac_ids) <= 0 then al_prac_ids[1] = 0
		if upperbound(al_facility_ids) <= 0 then al_facility_ids[1] = 0
		if upperbound(al_app_ids) <= 0 then al_app_ids[1] = 0
		li_row_cnt = ids_print_letter.retrieve( al_prac_ids, al_facility_ids, al_app_ids )
		IF li_row_cnt = 0 THEN
			MessageBox( "No Data", "No data was returned.  Check the following: You need to have an Par Action Type with an action status of Incomplete.  You need to have a mailing address setup.  For follow up with Payor letter you need to have the Credentialing Application setup under an organization in the application mapping utility. ")
			destroy lds_full_name
			Return -1
		END IF				 
		IF ids_print_letter.DataObject = "d_ltr_net_dev_app_rcvd_prac_all" THEN
			//ids_print_letter.saveas( "c:\jad.txt" , Text!, True )			
			of_app_rcvd_prac( )
		END IF
		li_row_cnt =  ids_print_letter.RowCount( )
END CHOOSE
				
IF li_row_cnt = 0 THEN
	MessageBox( "Letter Generation Error", "No rows were returned.  Data incomplete for the selected practitioners." )
	destroy lds_full_name
	Return -1
END IF
				
//sort the dw_letters table so that the sort matches the criteria table
IF ids_print_letter.Describe( "v_full_name_full_name.border" ) <> "!" THEN
	ids_print_letter.SetSort( "v_full_name_full_name" )
	ids_print_letter.Sort( )		
ELSEIF ids_print_letter.Describe( "full_name.border" ) <> "!" THEN
	ids_print_letter.SetSort( "full_name" )
	ids_print_letter.Sort( )		
ELSEIF ids_print_letter.Describe( "last_name.border" ) <> "!" THEN
	ids_print_letter.SetSort( "last_name" )
	ids_print_letter.Sort( )		
ELSE
	li_ans = MessageBox("No full name", "If you plan on using FAXING there must be a v_full_name_full_name or full_name or last_name column included in the letter query for sorting.  If you are not faxing this letter then click YES to continue or if you plan on faxing this letter then contact support.", StopSign!, YesNo!, 1)
	IF li_ans = 2 THEN
		destroy lds_full_name
		Return -1
	END IF
END IF

//\/maha081600
//FOR i = 1 TO li_num_pracs
FOR i = 1 TO UpperBound(al_prac_ids)
	li_check = 0
	//il_prac_ids[i] = tab_ltr.tabpage_criteria.dw_criteria.GetItemNumber( i, "prac_id" )
	//ls_full_name = tab_ltr.tabpage_criteria.dw_criteria.GetItemstring( i, "full_name" )
	for i2 = 1 to li_row_cnt
		ll_prac_id_check = ids_print_letter.GetItemNumber( i2, "prac_id" )
		if al_prac_ids[i] = ll_prac_id_check then
			li_check = 1
			continue
		end if
	next
	if li_check = 0 then 
		ll_find = lds_full_name.Find( "prac_id = " + String( ll_prac_id_check ), 1, ll_rowcount )
   	if ll_find > 0 then 
			ls_full_name = lds_full_name.getitemstring(ll_find,'full_name')
		else
			ls_full_name = ""
		end if
		MessageBox("Error", "Unable to create letter for practitioner # " + string(al_prac_ids[i]) + " ("+ ls_full_name +") ~n~r1) Check to see if there is a mailing address link for the selected facility.~n~r2) Make sure that that address is active.~n~r3) Make sure the Appointment Status for this practitioner is active or pending for the selected facility.~n~r4) Be sure the practitioner has a specialty of Primary order.")
	end if
NEXT
if isvalid(lds_full_name) then destroy lds_full_name
//\maha
				
IF li_row_cnt = 0 THEN
	MessageBox("Error", "No letters to print.")
	Return -1
ELSE
	
	//\/maha 073002 check and create export file for merge document 
	if gi_export_on = 1 then //maha 102302
		if li_use_export = 1 then
			res = of_run_export(al_prac_ids[],li_export_id,ls_open_merge)
			if res < 1 then
				messagebox("Export Error","Failed to create file from export.")
				li_export_on = 0
			else
				select export_name into :ls_exportname from export_header where export_id = :li_export_id;
				li_export_on = 1
				ls_exportname = ls_open_merge + ls_exportname + ".txt"
			end if
		end if
	end if
	//\maha
	
	CHOOSE CASE ids_print_letter.DataObject
		CASE "d_ltr_net_dev"
			ls_open_merge = ls_open_merge + "net_dev_ai.txt"
			ids_print_letter.SaveAs( ls_open_merge, Text!, True )				
		CASE "d_ltr_net_dev_app_rcvd_prac", "d_ltr_net_dev_app_rcvd_prac_all"
			ls_open_merge = ls_open_merge + "net_dev_app_rcvd_prac.txt"
			ids_print_letter.SaveAs( ls_open_merge, Text!, True )							
		CASE "d_ltr_net_dev_app_rcvd_payer", "d_ltr_net_dev_app_rcvd_payer_all"
			ls_open_merge = ls_open_merge + "net_dev_app_rcvd_payer.txt"
			ids_print_letter.SaveAs( ls_open_merge, Text!, True )										
		CASE ELSE
			ls_open_merge = ls_open_merge +  "ind_generic_corrospondence.txt"
			ids_print_letter.SaveAs( ls_open_merge, Text!, True )	

	END CHOOSE
	
	//if using an export set the merge file path to the export file
	if li_export_on = 1 then
		//ls_open_merge = ls_exportname 08.28.2007 By Jervis
	end if
	
end if


Integer li_word_storage_type
Integer li_facility_id

li_word_storage_type = Integer(gnv_data.of_getitem( "icred_settings", "set_50", FALSE))
IF Isnull(li_word_storage_type) THEN li_word_storage_type = 0
IF Upper( AppeonGetClientType() ) = "PB" AND li_word_storage_type = 0 THEN
	IF gs_cust_type = "I" THEN //intelliapp
		SELECT facility.letter_path  
   	INTO :ls_letter_path  
	   FROM facility  
   	WHERE facility.facility_id = 1;		
	ELSE
		SELECT facility.letter_path  
   	INTO :ls_letter_path  
	   FROM facility  
   	WHERE facility.facility_id = :al_facility_ids[1];
	END IF
	
	//ls_letter_path = "'" + ls_letter_path + "'"
	IF IsNull( ls_letter_path ) OR ls_letter_path = "" THEN
		MessageBox("Data Error", "You must define a letter path in the facility painter for selected facility.")
		Return -1 
	END IF
	
	//li_cr = tab_ltr.tabpage_criteria.dw_select_report.GetRow()
	//li_response_required = 	tab_ltr.tabpage_criteria.dw_select_report.GetItemNumber( li_cr, "response_required" )
	//ls_doc_name = tab_ltr.tabpage_criteria.dw_select_report.GetItemString( li_cr, "document_name" )
	ls_word_path = ProfileString(gs_IniFilePathName, "paths", "word", "None")
ELSE
	//li_cr = tab_ltr.tabpage_criteria.dw_select_report.GetRow()
	//li_response_required = 	tab_ltr.tabpage_criteria.dw_select_report.GetItemNumber( li_cr, "response_required" )
	//ls_doc_name = tab_ltr.tabpage_criteria.dw_select_report.GetItemString( li_cr, "document_name" )
	ls_word_path = ProfileString(gs_IniFilePathName, "paths", "word", "None")

	IF gs_cust_type = "I" THEN //intelliapp
		li_facility_id = 1
	ELSE
		li_facility_id = al_facility_ids[1]
	END IF

	IF lnv_storage_area.of_retrieve_doc_from_db( li_facility_id, ls_doc_name, ls_letter_path) < 0 THEN
		Messagebox("Download File",'The MSWord document '+  ls_doc_name  +'  does not exist in the database.')
		RETURN -1
	END IF

END IF

ls_doc_name_nopath = ls_doc_name //Ken.Guo 11/01/2007	
	
//copy down to local drive from network?	//maha copied from ver letters 06/11/03	
//SELECT set_6 INTO :li_set6 FROM icred_settings;
li_set6 = of_get_app_setting("set_6","I") 
IF li_set6 = 1 THEN
	if upper(ls_letter_path) = upper(ls_run_path ) then //maha 050602 trap against copying to same location
		messagebox("Path error","Your letter path is set to " + gs_temp_path + "letters\standard\ ~rand the Copy Letters setting is turned on. ~rGo to system->utilities->Application settings and set copy letters to No to run letters normally.")
		return -1
	end if

	//check to make sure letter and path exists
	IF NOT FileExists( ls_letter_path + ls_doc_name ) THEN
		MessageBox("Print Error", "Cannot find word letter " + ls_doc_name + " in directory: " + ls_letter_path )
		Return -1
	else
		ls_from  = ls_letter_path + ls_doc_name
	END IF

	//ls_to = gs_dir_path + "intellicred\letters\standard\" + ls_doc_name
	ls_to = ls_run_path + ls_doc_name
	//copy letter to c drive then run 
	//FileDelete( gs_dir_path + "intellicred\letters\standard\" + ls_doc_name )
	if fileexists(ls_to) then  //maha042805
		if FileDelete( ls_to) = false then //maha040705
			messagebox("Copying letter from server","Unable to delete existing letter " + ls_doc_name + " in  " + ls_to + " prior to copy.~r  Check letter properties to see if letter is Read Only.")
		end if
	end if			

	CopyFileA( ls_from, ls_to, true )
	//reset ls_doc_name
	ls_doc_name = ls_to //"c:\intellicred\letters\standard\" + ls_file_name
	DO WHILE NOT FileExists( ls_doc_name )
		ll_loop_count++
		IF ll_loop_count = 100000 THEN
			MessageBox("Timeout", "Timed out trying to copy Word file." )
			EXIT
		END IF
	LOOP
else
	ls_doc_name = ls_letter_path + ls_doc_name
END IF

IF NOT FileExists( ls_doc_name ) THEN //maha 101504
	messagebox("Unable to find letter:",ls_doc_name)
	//messagebox("to",ls_to)
	return -1
end if

// mskinner 04 oct 2005 -- begin
// mbs 22 Nov 2004 -- begin fax modification
//Run( ls_word_path + " " + ls_doc_name + " /mpreview", Maximized!)
//Start Code Change ---- 03.27.2006 #348 maha added trap return
if gnv_app.gnvlo_msword.of_open_word_document( ls_doc_name, ls_open_merge, "Correspondence") = -1 then
	return -1
end if
//End Code Change---03.27.2006
// mbs 22 Nov 2004 -- end	fax modificationfax modification
//of_open_letter(ls_doc_name,ls_open_merge,"Correspondence") //maha 022505
// mskinner 04 oct 2005 -- end 
//ls_letter_name = tab_ltr.tabpage_criteria.dw_select_report.GetItemString( li_cr, "letter_name" )


gs_fax lgs_fax
n_ds lds_letters
Integer li_Retval
	
lds_letters = Create n_ds;


IF Upper( AppeonGetClientType() ) = "PB" AND li_word_storage_type = 0 THEN
	IF al_letter_id = 1001 OR al_letter_id = 1002 THEN
		lgs_fax.ss_mail_label_doc = ls_letter_path + "mailing_labels_action_items_letters.doc" // /mmail_labels"
	ELSEIF al_letter_id = 1003 OR al_letter_id = 1004 THEN
		lgs_fax.ss_mail_label_doc = ls_letter_path + "mailing_labels_net_dev_payer_letters.doc" // /mmail_labels"
	ELSE
		lgs_fax.ss_mail_label_doc = ls_letter_path + "mailing_labels_prac_corro_letters.doc" // /mmail_labels"
	END IF
ELSE
	IF al_letter_id = 1001 OR al_letter_id = 1002 THEN
		lgs_fax.ss_mail_label_doc = "mailing_labels_action_items_letters.doc" // /mmail_labels"
	ELSEIF al_letter_id = 1003 OR al_letter_id = 1004 THEN
		lgs_fax.ss_mail_label_doc = "mailing_labels_net_dev_payer_letters.doc" // /mmail_labels"
	ELSE
		lgs_fax.ss_mail_label_doc = "mailing_labels_prac_corro_letters.doc" // /mmail_labels"
	END IF
END IF


	
lds_letters.DataObject = ids_print_letter.DataObject
li_retval = ids_print_letter.RowsCopy( 1, 100000, Primary!, lds_letters, 1, Primary!  )
	
lgs_fax.ss_message = "Did the " + ls_letter_name + " letter print ok?"
//lgs_fax.ss_letter_document_name = ls_doc_name + " /mpreview"
lgs_fax.ss_letter_document_name = ls_doc_name_nopath //Ken.Guo 11/01/2007
lgs_fax.ss_letter_name = ls_letter_name 
lgs_fax.sdw_letter = lds_letters
lgs_fax.ss_letter_type = "Corro"
	
OpenWithParm( w_ai_print_msg_box, lgs_fax  )	

gs_fax_error_records lst_fax_error_records
lst_fax_error_records = Message.PowerObjectParm
IF lst_fax_error_records.il_error_rec_num[ 1 ] = -2 THEN		
	Return -1
END IF

//Update the print flag for action item
ldt_last_date = datetime(today(),now())
ll_number_sent++
gnv_appeondb.of_startqueue( )
if ib_from_net_dev then
	update net_dev_action_items
	set print_flag = 0,last_sent = :ldt_last_date,number_sent = :ll_number_sent
	where rec_id = :al_rec_ids[1];
	
	if isnull(ldt_first_date) then
		update verif_info
		set first_sent = :ldt_last_date
		where rec_id = :al_rec_ids[1] and prac_id = :al_prac_ids[1] and facility_id = :al_facility_ids[1] and seq_no = :al_seq_no[1];
	end if
else
	update verif_info
	set print_flag = 0,last_sent = :ldt_last_date,number_sent = :ll_number_sent
	where rec_id = :al_rec_ids[1] and prac_id = :al_prac_ids[1] and facility_id = :al_facility_ids[1] and seq_no = :al_seq_no[1];
	
	if isnull(ldt_first_date) then
		update verif_info
		set first_sent = :ldt_last_date
		where rec_id = :al_rec_ids[1] and prac_id = :al_prac_ids[1] and facility_id = :al_facility_ids[1] and seq_no = :al_seq_no[1];
	end if
end if
commit;
gnv_appeondb.of_commitqueue()
Return 1
end function

public function integer of_init_net_dev ();ids_print_letter.dataobject = "d_ltr_net_dev"
ib_from_net_dev = true

return 1
end function

public function integer of_app_rcvd_prac ();Integer li_rc
Integer z
Integer i
Integer p
Integer li_cnt
Integer li_first_record
Integer li_remove_rc
Integer r
String ls_fld_1
String ls_fld_2
Long ll_prac_id[]
Long ll_temp_id
Long ll_action_status
Long ll_action_type
Boolean ll_found_id = False
DataStore ds_temp_data


ll_action_status = Long(gnv_data.of_getitem("code_lookup" , "lookup_code" , "upper(lookup_name) = 'ACTION STATUS' and upper(code) = 'INCOMPLETE'"))
IF ll_action_status = 0 THEN
	MessageBox("Lookup missing", "You will need to add a 'Incomplete' code to the Action Status lookup table." )
END IF
ll_action_type = Long(gnv_data.of_getitem("code_lookup" , "lookup_code" , "upper(lookup_name) = 'ACTION TYPE' and upper(code) = 'APP RCVD PRAC'"))
IF ll_action_type = 0 THEN
	MessageBox("Lookup missing", "You will need to add a 'PAR' code to the Action Type lookup table." )
END IF


li_rc = ids_print_letter.RowCount()

ll_temp_id = 0
FOR i = 1 TO li_rc
	ll_temp_id = ids_print_letter.GetItemNumber( i, "prac_id" )
	ll_found_id = False
	FOR p = 1 TO UpperBound( ll_prac_id )
		IF ll_prac_id[ p ] = ll_temp_id THEN
			ll_found_id = True
		END IF
	END FOR
	IF ll_found_id = False THEN
		IF ids_print_letter.GetItemNumber( i, "action_type" ) = ll_action_type AND ids_print_letter.GetItemNumber( i, "action_status" ) = ll_action_status THEN
			li_cnt++
			ids_print_letter.SetItem( i, "removeit", 0 )			
			ll_prac_id[ li_cnt ] = ll_temp_id
		ELSE
			ids_print_letter.SetItem( i, "removeit", 1 )					
		END IF
	ELSE
		ids_print_letter.SetItem( i, "removeit", 1 )		
	END IF
END FOR


IF li_cnt = 0 THEN
		MessageBox( "No Data", "No data was returned.  Check the following: You need to have an App Rcvd Payor Action Type with an action status of Incomplete.  You need to have a mailing address setup.  ")
		Return -1	
END IF



FOR z = 1 TO li_cnt
	ids_print_letter.SetFilter( "prac_id = " + String( ll_prac_id[z] ) )
	ids_print_letter.Filter( )
	li_rc = ids_print_letter.RowCount( )
	//messagebox(String( ll_prac_id[z]), li_rc )
	FOR i = 1 TO li_rc
		IF	ids_print_letter.GetItemNumber( i, "removeit" ) = 0 THEN
			//messagebox(String( ll_prac_id[z]), "remove it 0" )			
			li_first_record = i
		END IF
	END FOR

	FOR i = 1 TO li_rc
		ls_fld_1 = "app_name_" + String( i )
		ls_fld_2 = "date_" + String( i )
		ids_print_letter.SetItem( li_first_record, ls_fld_1, ids_print_letter.GetItemString( i, "application_name" ) )
		ids_print_letter.SetItem( li_first_record, ls_fld_2, String( ids_print_letter.GetItemDateTime( i, "action_date" ), "mm/dd/yyyy") )	
	END FOR

	//FOR i = 2 TO li_rc
	//	ids_print_letter.DeleteRow( ids_print_letter.RowCount() )
	//END FOR 
END FOR

//delete duplicates
ids_print_letter.SetFilter( "removeit = 1" )
ids_print_letter.Filter( )
li_remove_rc =	ids_print_letter.RowCount( )
FOR r = 1 TO li_remove_rc
	ids_print_letter.DeleteRow( 0 )
END FOR
ids_print_letter.SetFilter( "" )
ids_print_letter.Filter( )


li_rc = ids_print_letter.RowCount( )


Return 0
end function

public function integer of_run_export (long ai_pracs[], integer ai_exp_id, ref string as_path);//maha 073002

Long prac_ids[]

string ls_exp_name

string ls_path
integer res
pfc_n_cst_ai_export_apb  n_export
long ll_export_id
integer i


ls_path = as_path//022305 

n_export = CREATE pfc_n_cst_ai_export_apb

res = n_export.of_export_data_with_text( ai_exp_id, ai_pracs[],ls_path,0,"","","",2,"" )

destroy n_export


if res < 0 then
	return -1
else
	as_path = ls_path
	return 1
end if


end function

on n_cst_print_letter.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_print_letter.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ids_print_letter = create n_ds

ids_print_letter.dataobject = "d_ltr_general_corrospondence"
end event

event destructor;if isvalid(ids_print_letter) then destroy ids_print_letter
end event

