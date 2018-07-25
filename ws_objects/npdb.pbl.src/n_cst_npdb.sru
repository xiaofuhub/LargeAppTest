$PBExportHeader$n_cst_npdb.sru
forward
global type n_cst_npdb from nonvisualobject
end type
end forward

global type n_cst_npdb from nonvisualobject
end type
global n_cst_npdb n_cst_npdb

type prototypes
FUNCTION ulong SetCapture(ulong a) LIBRARY "user32.dll"
FUNCTION boolean ReleaseCapture() LIBRARY "user32.dll"
Function boolean ExitWindowsEx(uint dwReserved, uint uReserved ) library "user32.dll"
end prototypes

type variables
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                n_cst_npdb 
//==================================================================================================================
//  Purpose   	: instance variables
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael B. Skinner  03 January 2005 
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
public:
boolean ib_initialize
string ls_sql_statments[]

constant string is_recieve = 'RECIEVE'
constant string is_SEND = 'SEND'
constant string is_report = 'REPORT'

// REMOVE BEGIN
constant string NPDB_STATEMENT = 'The information contained in this report is maintained by the National Practitioner Data Bank for restricted use under the provisions of Title IV of the Public Law 99-660 as amended, 45 CFR Part 60. All information is confidential and must used solely for the purpose for which it was disclosed. For additional information or clarification, contact the reporting entity identified in Section A.'
constant string HIDB_STATEMENT = 'The information contained in this report is maintained by the Healthcare Integrity and Protection Data Bank for restricted use under the provisions of Section 1128E of the Social Security Act as codified in 45 CFR Part 61. All information is confidential and must used solely for the purpose for which it was disclosed. For additional information or clarification, contact the reporting entity identified in Section A.'
// REMOVE END
n_ds ids_npdb_dws[] 			// array of datastors used in updateing the NPDB tables
n_ds ids_report_dws[]		// array of datastors used in NPDB reports
STRING IS_RETREIVE_TIME
string is_doc_id[]
string is_failed_doc_id[] //maha 05.02.08
string is_docid_current
string is_null

integer ii_report_id  // stephen 11.05.2012


PRIVATE:
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// pfc services
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

n_cst_filesrvwin32 inv_filesrv  
n_cst_string       lnv_string
n_cst_datetime     inv_datetime
n_cst_color        inv_color

boolean ib_process_failed // the upload or recive failed due to an error
boolean ib_recieving
string is_current_prac_name
string is_internet_inuse// N - not is use
string is_directories[]
string is_batch_files[]
string is_files[]
string is_batch_file_text[]
string is_current_facility  // the facility we are working on
string is_current_facility_id
string is_err_mess[]
string is_blank[] // used to clear out existing arrays
string is_messsages[] // concatinated on to the is_err_mess variable

string is_error_info
string is_current_path
STRING IS_CURRENT_FILE_NAME // THE CURRENT DOC ID
string is_itp_path
string is_status_files[]
STRING IS_STATUS_CODE // THE CODE WE GET FROM THE ERROR FILE
STRING is_process // send or recieve
string is_fac_id_status[]// holds the status fac_id,status code of the send/recieve -- used in the tracker
STRING is_classpath
STRING is_current_file /* the name of the text file*/
string is_password //maha 040808
string is_npdb_user_id //maha040808
string is_user_name //maha040808

long ll_hdr_position
// mskinner 18 april 2006 -- begin
long    il_current_fac_id
// mskinner 18 april 2006 -- end
long il_upload_prac //maha 09.04.2012


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// datastores
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

n_ds ids_dw_datatore       // datastore with all datawindow information
n_ds ids_lookup_code			// retrivies all of the codes in NPDB
n_ds ids_pracs					// external datawindow
n_ds ids_pracs_info			// Practitioner information
//n_ds ids_npdb_dws[] 			// array of datastors used in updateing the NPDB tables
n_ds ids_npdb_fac_info     // the facilities we are using
n_ds ids_error             // error  datawindow
n_ds ids_npdb_TRACKER_upd  // update the database with submitted doc_ids and status
n_ds ids_varification
n_ds ids_tracker_by_doc_id // tracker records by doc id
n_ds ids_CC_information
//d_npdb_prac_address  il_current_fac_id
n_ds lds_address_info // mskinner 18 april 2006 
n_ds ids_qrxs_log


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// constants
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CONSTANT STRING DELIMITER 			= '~~' 					// delimeter used in the creation and parsing of files
CONSTANT STRING NEW_LINE  			=	'~r~n'			// new line
CONSTANT STRING TLR       			= 'TLR' + DELIMITER	// trailer record
CONSTANT STRING NPDB_DATE_FORMAT = 'MMDDYYYY'			// the default date format used by the npdb
CONSTANT LONG   SUCCESS 			= 0						// all is ok
CONSTANT LONG   FAILURE 			= -1						// function failed

// REPORT CONSTANTS
constant string ADVERSE_ACTION_REPORT = 'C'
constant string JUDJEMENT_OR_CONVICTION_REPORT = 'J'
constant string MEDICAL_MALPRACTICE_PAYMENT_REPORT = 'P'
constant string LEGACY_ADVERSE_ACTION_REPORT = 'A'
constant string LEGACY_MEDICAL_MALPRACTICE_REPORT = 'M'
//constant string NPDB_STATEMENT = 'The information contained in this report is maintained by the National Practitioner Data Bank for restricted use under the provisions of Title IV of the Public Law 99-660 as amended, 45 CFR Part 60. All information is confidential and must used solely for the purpose for which it was disclosed. For additional information or clarification, contact the reporting entity identified in Section A.'
//constant string HIDB_STATEMENT = 'The information contained in this report is maintained by the Healthcare Integrity and Protection Data Bank for restricted use under the provisions of Section 1128E of the Social Security Act as codified in 45 CFR Part 61. All information is confidential and must used solely for the purpose for which it was disclosed. For additional information or clarification, contact the reporting entity identified in Section A.'

n_cst_filesrvwin32 inv_filesrvwin32
N_CST_STRING inv_string

//------------ APPEON BEGIN ------------
//$<Add> 11.18.2009 By: Evan
//$<Reason> V10.1 - NPDB QRXS
string is_qrxs_path
string is_directories2[]
string is_batch_files2[]
string is_files2[]
string is_batch_file_text2[]
string is_status_files2[]

long il_Interface
constant long ITP_INTERFACE  = 1
constant long QRXS_INTERFACE = 2
//------------ APPEON END --------------

n_cst_message inv_message //scheduler - alfee 02.06.2010
Boolean ib_schedule = false //scheduler - alfee 02.25.2010
Integer ii_sched_id //scheduler - alfee 02.26.2010


end variables

forward prototypes
private function integer of_create_batch_files ()
private function integer of_create_encode_batch (string as_password)
private function integer of_create_folders ()
private function integer of_create_ini ()
private subroutine of_alter_database ()
private function string of_assemble_string (string as_tag_string[])
private function integer of_check_missing_values (n_ds a_dw)
private function integer of_check_status (string as_string)
private function string of_create_alias ()
private function string of_create_cert ()
private function string of_create_cuse ()
private function string of_create_dea ()
private function string of_create_fien ()
private function integer of_create_file (string as_file_name, string as_text)
private function string of_create_grad ()
private function string of_create_hdr ()
private function string of_create_isofl ()
private function string of_create_isubj ()
private function string of_create_npi ()
private function string of_create_qry ()
private function string of_create_ssn ()
private function integer of_create_submission_file ()
private function integer of_create_tables ()
private function integer of_display_error ()
private subroutine of_drop_tables ()
private function datetime of_get_server_datetime ()
private subroutine of_modify_code_lookup ()
private function integer of_recieve ()
private function integer of_send (string as_doc_ids[])
private function integer of_set_internet_inuse ()
private function integer of_upload ()
private function string of_create_upin ()
private function integer of_reset_tracker ()
private function integer of_post_send (integer ai_status)
public function integer of_open_progress_window ()
public function integer of_create_reports ()
public function integer of_get_max_id_for_prac (long al_prac_id)
public function integer of_report_retrieve_ds (integer il_npdb_hdr_id)
private function integer of_report_filter (integer al_record_id)
private function integer of_create_datastores (string as_type)
private function integer of_report_set_items (string as_report_code_type)
public function integer of_report_unfilter ()
public function integer of_create_database ()
private function integer of_set_npdb_id ()
private function integer of_update_database ()
public function integer of_report_npdb (long al_prac_id, long al_npdb_id, string as_doc_id)
public function long of_get_npdb_hdr_id (string as_doc_id)
protected subroutine of_set_error_message (string as_message)
public function integer of_set_post_import_status ()
private function integer of_set_tracker_export_id (string as_doc_ids[])
public function integer of_start_npdb (string as_process, long al_prac_id, long al_npdb_id, string as_doc_id, u_dw adw)
private function integer of_get_npdb_quert_code ()
public function integer of_move_jar ()
public function integer of_mail_error (string as_subject, string as_notetext, string as_person[])
public function integer of_initialize ()
public function integer of_create_classpath ()
public function string of_create_itin ()
public function integer of_post_original_db_create ()
public function integer of_insert_dbcontrol ()
public function integer of_set_version_1_12 ()
protected function integer of_file_succeded (string as_file_text[])
public function string of_replacenonprint (string as_source)
public function boolean of_file_has_report (string as_file_text[])
public function string of_create_isofl_new ()
public function integer of_get_user_password ()
public function integer of_failed_message (string as_section)
public subroutine of_insert_codes ()
public subroutine of_insert_codes2 ()
public subroutine of_insert_new_error_codes ()
public function integer of_delete_npdb_data (long al_hdr_id)
private function integer of_create_upload_dat_indv (string as_docid)
public function integer of_create_classpath_old ()
private function integer of_create_qrxs_upload_file (string as_docid)
private function integer of_check_status_old (string as_string)
private function integer of_recieve_qrxs ()
private function integer of_get_qrxs_report_hdr (n_cst_xml_parser anv_xml, ref datastore ads_report, string as_doc_id)
private function integer of_get_qrxs_report_status (n_cst_xml_parser anv_xml, ref datastore ads_report)
private function integer of_get_qrxs_report_individual (n_cst_xml_parser anv_xml, ref datastore ads_report)
private function integer of_get_qrxs_report_aar (n_cst_xml_parser anv_xml, ref datastore ads_report)
private function integer of_get_qrxs_report_jocr (n_cst_xml_parser anv_xml, ref datastore ads_report)
private function integer of_get_qrxs_report_mmpr (n_cst_xml_parser anv_xml, ref datastore ads_report)
private function integer of_get_qrxs_report_laar (n_cst_xml_parser anv_xml, ref datastore ads_report)
private function integer of_get_qrxs_report_lmmpr (n_cst_xml_parser anv_xml, ref datastore ads_report)
private function integer of_get_qrxs_report ()
public function integer of_set_post_import_status_qrxs (datastore ads_npdb_hdr, datastore ads_npdb_status)
private function integer of_setitem (ref datastore ads_report, long al_insertrow, string as_columnstr, string as_elementstr, ref string as_elementtext[])
public function string of_get_sched_msg ()
public function integer of_get_sched_cnt ()
public function integer of_set_sched_flag (integer ai_sched_id, boolean ab_flag)
public function integer of_create_qrxs_upload_file_org (string as_docid)
public function integer of_check_status_send_qrxs ()
public function integer of_create_qrxs_log (string as_doc, long al_prac, long al_facility, string as_file, string as_type, string as_note)
public function integer of_post_send_qrxs (integer ai_success)
public function integer of_set_tracker_qrsx (string as_doc_id)
public function integer of_create_qrxs_download_log (string as_file, integer ai_count, integer ai_dowloaded, string as_missing, string as_type)
private function integer of_create_upidlist (string as_docid)
private function integer of_create_qrxs_prop (string as_process)
public subroutine of_insert_codes3 ()
public function integer of_get_qrxs_report_contact (n_cst_xml_parser anv_xml, datastore ads_report)
public function integer of_get_qrxs_report_reload (string as_filename[])
public function integer of_get_qrxs_report_util_call ()
public function integer of_initial_qrxs ()
public function integer of_test_password (string as_pw)
end prototypes

private function integer of_create_batch_files ();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : of_create_batch_files
//==================================================================================================================
//  Purpose   	: This function will create the needed batch files for the NPDB
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael B. Skinner  Thursday 06 Jan 2005
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

long li_FileNum, ll_i
string ls_start

choose case il_Interface
	case ITP_INTERFACE
		FOR ll_i = 1 TO UPPERBOUND(is_batch_files)
			IF NOT FileExists (is_batch_files[ll_i]) THEN
				li_FileNum = fileopen(is_batch_files[ll_i],StreamMode!, Write!, LockWrite!, Replace!)
				if FileWrite(li_FileNum, is_batch_file_text[ll_i]) = -1 then
					is_messsages[upperbound(is_messsages) + 1 ] = 'Could create batch files, please check your permissions.'
					return failure
					FileClose (li_FileNum)
				end if 
			END IF 
		NEXT
	case QRXS_INTERFACE //Add by Evan 11.18.2009 (V10.1 - NPDB QRXS)
		FOR ll_i = 1 TO UPPERBOUND(is_batch_files2)
			IF NOT FileExists (is_batch_files2[ll_i]) THEN
				li_FileNum = FileOpen(is_batch_files2[ll_i], StreamMode!, Write!, LockWrite!, Replace!)
				if FileWrite(li_FileNum, is_batch_file_text2[ll_i]) = -1 then
					FileClose(li_FileNum)
					is_messsages[upperbound(is_messsages) + 1 ] = 'Could create batch files, please check your permissions.'
					Return FAILURE
				end if
				FileClose(li_FileNum)
			END IF 
		NEXT
	case else
		Return FAILURE
end choose

RETURN success
end function

private function integer of_create_encode_batch (string as_password);////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : open:w_reappointment_measurements
//==================================================================================================================
//  Purpose   	: open event
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael Skinner  Wednesday 13 October 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

LONG li_FileNum
string ls_file 

//ls_file = is_batch_file_text[3] + ' ' +ids_npdb_fac_info.object.npdb_pass[1]
ls_file = is_batch_file_text[3] + ' ' +ids_npdb_fac_info.object.security_users_npdb_user_id[1]  //Start Code Change ----12.05.2008 #V8 maha  --changed to get from user record
//debugbreak()
li_FileNum = fileopen(ls_file,StreamMode!, Write!, LockWrite!, Replace!)
		
if li_FileNum < 1 then
	is_err_mess[upperbound(is_err_mess) + 1] = 'The ' + ls_file + ' could not be opened. Please check to see if you have FULL permissions to this file' 
	FileClose (li_FileNum)
	return failure
end if
		
if  FileWrite(li_FileNum, is_batch_file_text[3] + as_password) < 1 then
 	 is_err_mess[upperbound(is_err_mess) + 1] = 'The ' + ls_file + ' could not be modified. Please check to see if you have FULL permissions to this file' 
	  FileClose (li_FileNum)
	 return failure
end if 
		
if FileClose (li_FileNum) < 1 then
   is_err_mess[upperbound(is_err_mess) + 1] = 'The ' + ls_file + ' could not be closed. Please check to see if you have FULL permissions to this file' 
	return failure
end if

return success
end function

private function integer of_create_folders ();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : of_create_folders
//==================================================================================================================
//  Purpose   	: This function will create the needed directores for the NPDB
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael B. Skinner  Thursday 06 Jan 2005
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// check to see the directory exists if it does not then create it
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

long ll_i

choose case il_Interface
	case ITP_INTERFACE
		FOR ll_i = 1 to upperbound(is_directories )
			IF NOT inv_filesrv.of_DirectoryExists (is_directories[ll_i]) THEN
					 inv_filesrv.of_CreateDirectory (is_directories[ll_i])
			END IF
		NEXT
	case QRXS_INTERFACE //Add by Evan 11.18.2009 (V10.1 - NPDB QRXS)
		FOR ll_i = 1 to upperbound(is_directories2 )
			IF NOT inv_filesrv.of_DirectoryExists (is_directories2[ll_i]) THEN
					 inv_filesrv.of_CreateDirectory (is_directories2[ll_i])
			END IF
		NEXT
	case else
		Return FAILURE
end choose

return success
end function

private function integer of_create_ini ();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : of_create_ini 
//==================================================================================================================
//  Purpose   	: Create the itp.ini file
//==================================================================================================================
LONG   ll_i
string ls_dbid //maha040808
STRING ls_file_text_array[]
STRING ls_file_text
string ls_ini_val
//debugbreak()

//Start Code Change ----08.06.2008 #V85 maha - when this is called from of_recieve, the facility info will not have been retrieved, so
//as long as the itp.ini exists then use the existing one.
//ids_npdb_fac_info.dataobject = 'd_npdb_fac_info'
if ids_npdb_fac_info.rowcount() < 1 then
	if not fileexists(is_files[1]) then
		return failure
	else
		return success
	end if
end if
//End Code Change---08.06.2008


//Start Code Change ----04.08.2008 #V8 maha -
of_get_user_password( ) //sets the user and password

// if agent filled in use agent; otherwise use entity
if not isnull(ids_npdb_fac_info.object.npdb_agent_dbid[1]) then //
	ls_dbid = string(ids_npdb_fac_info.object.npdb_agent_dbid[1])
else
	ls_dbid = string(ids_npdb_fac_info.object.npdb_entity_dbid[1])
end if

//Start Code Change ----12.05.2007 #V8 maha --changed userid and password to get from user rather than from facility
//Start Code Change ---- 08.07.2007 #V7 maha added userid and changed order
ls_file_text_array[upperbound(ls_file_text_array) + 1] = "DataBankIdNbr=" + ls_dbid + NEW_LINE
//ls_file_text_array[upperbound(ls_file_text_array) + 1] = "DataBankIdNbr="          + string(ids_npdb_fac_info.object.npdb_entity_dbid[1]) + NEW_LINE
//End Code Change---04.08.2008
ls_file_text_array[upperbound(ls_file_text_array) + 1] = "UserId=" + is_npdb_user_id  + New_line
//ls_file_text_array[upperbound(ls_file_text_array) + 1] = "Password=" + string(ids_npdb_fac_info.object.security_users_npdb_password[1])  + New_line
//ls_file_text_array[upperbound(ls_file_text_array) + 1] = "UserId=" + string(ids_npdb_fac_info.object.npdb_user_id[1])  + New_line
ls_file_text_array[upperbound(ls_file_text_array) + 1] = "Password=" + NEW_LINE                         // leave blank filled in during the encode process
ls_file_text_array[upperbound(ls_file_text_array) + 1] = "DownloadDir=download"    + NEW_LINE
ls_file_text_array[upperbound(ls_file_text_array) + 1] = "UploadFile=upidlist.fil" + NEW_LINE
ls_file_text_array[upperbound(ls_file_text_array) + 1] = "TempDir=temp" + NEW_LINE
ls_file_text_array[upperbound(ls_file_text_array) + 1] = "DownloadListFile=icdresp.fil" + NEW_LINE
ls_file_text_array[upperbound(ls_file_text_array) + 1] = "UserName=" + is_user_name
//End Code Change---08.07.2007
//End Code Change---12.05.2007


//Start Code Change ---- 02.23.2007 #V7 maha
 ls_ini_val =  ProfileString(gs_dir_path + "intellicred\intellicred.ini", "npdb", "ProxyHostName", "None")
 if ls_ini_val <> "None" then
	ls_file_text_array[upperbound(ls_file_text_array) + 1] = NEW_LINE + "ProxyHostName=" +  ls_ini_val 
end if

 ls_ini_val =  ProfileString(gs_dir_path + "intellicred\intellicred.ini", "npdb", "ProxyPort", "None")
 if ls_ini_val <> "None" then
	ls_file_text_array[upperbound(ls_file_text_array) + 1] = NEW_LINE + "ProxyPort=" +  ls_ini_val 
end if	
//End Code Change---02.23.2007

// ESCAPE THE \ WITH \\

//// create the file text
//FOR ll_i = 1 TO upperbound(ls_file_text_array)
//	lnv_string.OF_GLObalreplace( ls_file_text_array[upperbound(ls_file_text_array) + LL_I], '\', '\\')
//NEXT



// create the file text
FOR ll_i = 1 TO upperbound(ls_file_text_array)
    ls_file_text = ls_file_text +  ls_file_text_array[ll_i]
NEXT

////////////////////////////////////////////////////////////////////
// check to see if there are any nulls
////////////////////////////////////////////////////////////////////


/*
	#Fri Jan 07 11:04:52 PST 2005
	DataBankIdNbr=399700000000123
	DownloadDir=download
	UploadFile=upidlist.fil
	DownloadListFile=icdresp.fil
	ItpLogFile=itperror.log
	Password=KC`z\:2\=sGeaIgD;J\:eMJ8e4IaegJ
	TempDir=temp
	UserName=Bob Jones
*/



//li_FileNum = fileopen(is_files[1],StreamMode!, Write!, LockWrite!, Replace!)
//	if li_FileNum < 1 then
//		is_err_mess[upperbound(is_err_mess) + 1] = 'The ' + is_files[1] + ' could not be opened. Please check to see if you have FULL permissions to this file' 
//		return -1
//	end if
//		
//	if FileWrite(li_FileNum,ls_file_text) < 1 then
//		is_err_mess[upperbound(is_err_mess) + 1] = 'The ' + is_files[1] + ' could not be modified. Please check to see if you have FULL permissions to this file' 
//		return -1
//	end if 
//		
//	if FileClose (li_FileNum) < 1 then
//	   is_err_mess[upperbound(is_err_mess) + 1] = 'The ' + is_files[1] + ' could not be closed. Please check to see if you have FULL permissions to this file' 
//		return -1
//	end if
//			
//
//FileWrite(li_FileNum, ls_file_text)
//fileclose(li_FileNum)
//






return of_create_file( is_files[1], ls_file_text)
end function

private subroutine of_alter_database ();//Modifications in this OBJECT
//maha 04.08.08 - added inst variables for userid, password and user name - added of_get_user_password function
// maha 04.08.08 - modified of_create.ini and of_create_hdr to use new variables
//maha 04.08.08 - modified of_initialize and of_check_status moving delete of the itpstat.dat file from the end of the process to the beginning

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PRIVATE]   : of_alter_database
//==================================================================================================================
//  Purpose   	: Alter existing columns 
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [none]     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael Skinner 
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// added coulms so the user can add the requred cc information for NPDB -ITP UPLOAD
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2005-11-11 By: owen chen
//$<reason> add database option for sql excution
choose case gs_dbtype
	case 'ASA'
		// start code change --- 11.04.2005 MSKINNER
		// removed qa stuff
		ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if NOT EXISTS(SELECT 1 FROM systable,sys.syscolumn  WHERE sys.syscolumn.table_id = systable.table_id  and  systable.table_name = 'facility'  AND sys.syscolumn.column_name = 'cc_cardholder')        THEN ALTER TABLE facility    ADD cc_cardholder     varchar(40)  NULL end if ;"
		ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if NOT EXISTS(SELECT 1 FROM systable,sys.syscolumn  WHERE sys.syscolumn.table_id = systable.table_id  and  systable.table_name = 'facility'  AND sys.syscolumn.column_name = 'cc_billing_addr1')     THEN ALTER TABLE facility    ADD cc_billing_addr1  varchar(60)  NULL end if ;"
		ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if NOT EXISTS(SELECT 1 FROM systable,sys.syscolumn  WHERE sys.syscolumn.table_id = systable.table_id  and  systable.table_name = 'facility'  AND sys.syscolumn.column_name = 'cc_billing_addr2')     THEN ALTER TABLE facility    ADD cc_billing_addr2  varchar(60)  NULL end if ;"
		ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if NOT EXISTS(SELECT 1 FROM systable,sys.syscolumn  WHERE sys.syscolumn.table_id = systable.table_id  and  systable.table_name = 'facility'  AND sys.syscolumn.column_name = 'cc_billing_city')      THEN ALTER TABLE facility    ADD cc_billing_city   varchar(40)  NULL end if ;"
		ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if NOT EXISTS(SELECT 1 FROM systable,sys.syscolumn  WHERE sys.syscolumn.table_id = systable.table_id  and  systable.table_name = 'facility'  AND sys.syscolumn.column_name = 'cc_billing_state')     THEN ALTER TABLE facility    ADD cc_billing_state  varchar(2)   NULL end if ;"
		ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if NOT EXISTS(SELECT 1 FROM systable,sys.syscolumn  WHERE sys.syscolumn.table_id = systable.table_id  and  systable.table_name = 'facility'  AND sys.syscolumn.column_name = 'cc_zip5')              THEN ALTER TABLE facility    ADD cc_zip5           varchar(5)   NULL end if ;"
		// end code change --- 11.04.2005 MSKINNER

case 'SQL'
		ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if NOT EXISTS(SELECT 1 FROM v_systable,v_syscolumn  WHERE v_syscolumn.table_id = v_systable.table_id  and  v_systable.table_name = 'facility'  AND v_syscolumn.column_name = 'cc_cardholder')       ALTER TABLE facility    ADD cc_cardholder     varchar(40)  NULL  ;"
		ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if NOT EXISTS(SELECT 1 FROM v_systable,v_syscolumn  WHERE v_syscolumn.table_id = v_systable.table_id  and  v_systable.table_name = 'facility'  AND v_syscolumn.column_name = 'cc_billing_addr1')      ALTER TABLE facility    ADD cc_billing_addr1  varchar(60)  NULL ;"
		ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if NOT EXISTS(SELECT 1 FROM v_systable,v_syscolumn  WHERE v_syscolumn.table_id = v_systable.table_id  and  v_systable.table_name = 'facility'  AND v_syscolumn.column_name = 'cc_billing_addr2')     ALTER TABLE facility    ADD cc_billing_addr2  varchar(60)  NULL  ;"
		ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if NOT EXISTS(SELECT 1 FROM v_systable,v_syscolumn  WHERE v_syscolumn.table_id = v_systable.table_id  and  v_systable.table_name = 'facility'  AND v_syscolumn.column_name = 'cc_billing_city')       ALTER TABLE facility    ADD cc_billing_city   varchar(40)  NULL ;"
		ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if NOT EXISTS(SELECT 1 FROM v_systable,v_syscolumn  WHERE v_syscolumn.table_id = v_systable.table_id  and  v_systable.table_name = 'facility'  AND v_syscolumn.column_name = 'cc_billing_state')      ALTER TABLE facility    ADD cc_billing_state  varchar(2)   NULL ;"
		ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if NOT EXISTS(SELECT 1 FROM v_systable,v_syscolumn  WHERE v_syscolumn.table_id = v_systable.table_id  and  v_systable.table_name = 'facility'  AND v_syscolumn.column_name = 'cc_zip5')               ALTER TABLE facility    ADD cc_zip5           varchar(5)   NULL ;"		
end choose
//---------------------------- APPEON END ------------------------


end subroutine

private function string of_assemble_string (string as_tag_string[]);
string ls_return

lnv_string.of_arraytostring( as_tag_string, '', true, ls_return)



return ls_return
end function

private function integer of_check_missing_values (n_ds a_dw);////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : of_check_missing_values
//==================================================================================================================
//  Purpose   	: open event
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael Skinner  Wednesday 13 October 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// check to see if there are any nulls

//Start Code Change ---- 10.04.2006 #652 maha:  was crashing on facility name field for practitioner data. trapped and added pracid to message
long ll_j
string ls_message
string ls_required 
string s_type //maha
LONG ll_return
long lcc //maha

if a_dw.rowcount() < 1 then return failure
 lcc = long(a_dw.Object.DataWindow.Column.Count)
FOR ll_j = 1 TO lcc
			  // all columns are required
			 ls_required=  a_dw.Describe("#" + string(ll_j) + ".Edit.Required")
			 ls_message = string(a_dw.Describe(a_dw.Describe("#"+String(ll_j)+".name")+"_t.text"))
			s_type = 	upper(LeftA ( string(a_dw.Describe("#" + string(ll_j) + ".ColType")), 5))
 			CHOOSE CASE  s_type //maha
					case 'CHAR(' // char	 
						if ( isnull(a_dw.getItemstring(1, ll_j)) or LenA(trim(string(a_dw.getItemstring(1, ll_j)))) < 1)   and ls_required=  "yes" then
						   if a_dw = ids_pracs_info then //practitioner
								of_set_error_message('Missing data: ' +   ls_message + ' is a required value.')// Please check the NPDB tab for facility :' + a_dw.getItemString(1,'facility_name'))
							else
								of_set_error_message('Missing data: ' +   ls_message + ' is a required value. Please check the NPDB tab for facility :' + a_dw.getItemString(1,'facility_name'))
							end if
							ll_return = failure
						end if
					case 'LONG(' // long
						if isnull(a_dw.getItemNumber(1, ll_j)) or LenA(trim(string(a_dw.getItemNumber(1, ll_j)))) < 1 and ls_required=  "yes" then
							if a_dw = ids_pracs_info then //practitioner
								of_set_error_message('Missing data: ' +   ls_message + ' is a required value.')// Please check the NPDB tab for facility :' + a_dw.getItemString(1,'facility_name'))
							else
								of_set_error_message('Missing data: ' +   ls_message + ' is a required value. Please check the NPDB tab for facility :' + a_dw.getItemString(1,'facility_name'))
							end if
							ll_return = failure
						end if
					case 'DATE(' // date
						if isnull(a_dw.getItemdate(1, ll_j)) or LenA(trim(string(a_dw.getItemdate(1, ll_j)))) < 1  and ls_required=  "yes" then
							if a_dw = ids_pracs_info then //practitioner
								of_set_error_message('Missing data: ' +   ls_message + ' is a required value.')// Please check the NPDB tab for facility :' + a_dw.getItemString(1,'facility_name'))
							else
								of_set_error_message('Missing data: ' +   ls_message + ' is a required value. Please check the NPDB tab for facility :' + a_dw.getItemString(1,'facility_name'))
							end if
							ll_return = failure
						end if
					case 'DATET' // date
						if isnull(a_dw.getItemdatetime(1, ll_j)) or LenA(trim(string(a_dw.getItemdatetime(1, ll_j)))) < 1 and ls_required=  "yes" then
							if a_dw = ids_pracs_info then //practitioner
								of_set_error_message('Missing data: ' +   ls_message + ' is a required value.')// Please check the NPDB tab for facility :' + a_dw.getItemString(1,'facility_name'))
							else
								of_set_error_message('Missing data: ' +   ls_message + ' is a required value. Please check the NPDB tab for facility :' + a_dw.getItemString(1,'facility_name'))
							end if
							ll_return = failure
						end if
				end choose
			next
			 
	if ll_return = failure then
		if a_dw = ids_pracs_info then
			of_set_error_message(upper('~rNPDB request has not been submitted due to missing data. For practitioner ID number ' + string(a_dw.getItemnumber(1, "prac_id"))))
		else
			of_set_error_message(upper('~rNPDB request has not been submitted for facility: ' + a_dw.getItemString(1,'facility_name')+ ' due to missing data.'))
		end if
	end if
	//End Code Change---08.23.2006
return ll_return
end function

private function integer of_check_status (string as_string);//////////////////////////////////////////////////////////////////////
// $<function> of_check_status
// $<arguments>
//			string	as_string
// $<returns> integer
// $<description> Read the file and check the error code,
//                display message to user or stuff it into the database.
//                (V10.1 - NPDB QRXS)
//////////////////////////////////////////////////////////////////////
// $<add> Evan 11.30.2009
//////////////////////////////////////////////////////////////////////

//maha - this function is not used for QRXS RECEIVE only the SEND

long    ll_i,ll_j
long    li_FileNum
long    ll_return, chk
string  ls_read_string
string  ls_search_string
string  ls_stat
string  ls_file
integer li_err_cnt = 0
integer li_find
string  ls_Error[]
string  ls_Flag[]
string  ls_Text
n_cst_xml_parser lnv_Xml
n_cst_xml_parser lnv_Element

choose case il_Interface
	case ITP_INTERFACE
		// Filter on the error codes that are applicaple to the part
		ids_lookup_code.SetFilter("npdb_list = 'error_cd'")
		ids_lookup_code.Filter()
		// Get status file path
		ls_file = is_status_files[1]
	case QRXS_INTERFACE
		// Filter on the error codes that are applicaple to the part
		ids_lookup_code.SetFilter("npdb_list = 'error_cd_qrxs'")
		ids_lookup_code.Filter()
		// Get status file path
		ls_file = is_status_files2[1]
		//qrxsstat.dat
	case else
		Return FAILURE
end choose

// The status file will ALWAYS be retured accoribg to the documntation. Even if there are no files returned
for ll_i = 1 to 100000
	chk ++
	if FileExists(ls_file) = true then
		Exit
	end if
	if chk > 99999 then
		//chk = MessageBox(ls_file, "Waiting for status file. Continue to wait?", Question!, YesNo!, 1)
		//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
       chk = inv_message.of_MessageBox(ls_file, "Waiting for status file. Continue to wait?", Question!, YesNo!, 1,true)
		if chk = 1 then
			ll_i = 1
		else
			Return FAILURE
		end if
	end if
next

// Open the status file and check the error codes, add to the message
li_FileNum = FileOpen(ls_file, StreamMode!)
FileRead(li_FileNum, ls_read_string)
FileClose(li_FileNum)
ls_stat = MidA(ls_read_string, PosA(ls_read_string, "StatusCode=") + 11)
IS_STATUS_CODE = ls_stat
if ls_stat <> "C00" then
	li_find = ids_lookup_code.find("npdb_list_code ='" + ls_stat + "'", 1, ids_lookup_code.rowcount())
	if li_find > 0 then
		//is_err_mess[upperbound(is_err_mess) + 1 ] = ids_lookup_code.object.npdb_list_code_description[li_find]
		is_err_mess[upperbound(is_err_mess) + 1 ] = ls_stat + " - " + ids_lookup_code.object.npdb_list_code_description[li_find]   //Start Code Change ----03.24.2015 #V15 maha - added code to message
		li_err_cnt ++
	else
		is_err_mess[upperbound(is_err_mess) + 1 ] = "Unknown NPDB error code:" + ls_stat 
		li_err_cnt ++
	end if
	ib_process_failed = true
	ll_return = FAILURE
end if

// Check the confirmation file, add to the message
//C00 - success no errors
if ls_Stat = "C00" and il_Interface = QRXS_INTERFACE then
	// Get confirmation file name
	//maha 07.24.2012 - As the file being checked is just a list of file names this trap will never fail.  Should it be reading from a different file?
	ls_File = is_files2[3]  //is_current_path  + "\qrxs\download.lst"
	li_FileNum = FileOpen(ls_File, StreamMode!)
	FileRead(li_FileNum, ls_read_string)
	FileClose(li_FileNum)
	ls_read_string = Lower(Trim(ls_read_string))
	ls_read_string = LeftA(ls_read_string, PosA(ls_read_string, ".xml"))
	ls_read_string += "xml"
	ls_File = is_directories2[2] + "\" + ls_read_string
	// Check the confirmation file
	lnv_Xml.of_CreateFromFile(ls_File)
	ls_Flag[1] = lnv_Xml.of_GetElementText("queryConfirmation\batchStatus\successfullyProcessed")
	ls_Flag[2] = lnv_Xml.of_GetElementText("queryConfirmation\subjectConfirmation\accepted")
	if IsNull(ls_Flag[1]) then ls_Flag[1] = ""
	if IsNull(ls_Flag[2]) then ls_Flag[2] = ""
	if Trim(Lower(ls_Flag[1])) = "false" or Trim(Lower(ls_Flag[2])) = "false" then
		ls_Text = lnv_Xml.of_GetElementText("queryConfirmation\batchStatus")
		lnv_Element.of_CreateFromString(ls_Text)
		lnv_Element.of_GetElementText("error", ls_Error[])
		for ll_i = 1 to UpperBound(ls_Error)
			lnv_Element.of_CreateFromString(ls_Error[ll_i])
			ls_Text = lnv_Element.of_GetElementText("message")
			is_err_mess[upperbound(is_err_mess) + 1 ] = ls_Text
			li_err_cnt ++
		next
		ls_Text = lnv_Xml.of_GetElementText("queryConfirmation\subjectConfirmation")
		lnv_Element.of_CreateFromString(ls_Text)
		lnv_Element.of_GetElementText("error", ls_Error[])
		for ll_i = 1 to UpperBound(ls_Error)
			lnv_Element.of_CreateFromString(ls_Error[ll_i])
			ls_Text = lnv_Element.of_GetElementText("message")
			is_err_mess[upperbound(is_err_mess) + 1 ] = ls_Text
			li_err_cnt ++
		next
		ls_Stat= "C99" // Custom error code
		IS_STATUS_CODE = ls_Stat
		ib_process_failed = true
		ll_Return = FAILURE
	end if
	// Delete the confirmation file
//Start Code Change ----07.24.2012 #V12 maha
	//before deleting copy the download file to the processed folder
	string ls_org
	string ls_new
	string ls_path
	date ld_now
	time lt_time
	boolean r

	ld_now = today()
	lt_time = now()
	debugbreak()
	ls_path = is_current_path + "\qrxs\Processed"
	
	ls_org = ls_File
	
	
	ls_new = "download-" + string(year(ld_now)) + string(month(ld_now)) + string(day(ld_now)) + string(hour(lt_time)) + string(minute(lt_time)) + ".lst"
	ls_new = ls_path + ls_new
	
	r = copyfilea(ls_org, ls_new, false)
//End Code Change ----07.24.2012
	FileDelete(ls_File)
end if

is_fac_id_status[upperbound(is_fac_id_status) + 1 ] = is_current_facility_id + "," + IS_STATUS_CODE
ids_lookup_code.SetFilter("")
ids_lookup_code.Filter()

// Update the tracker with the latest message
for ll_i = 1 to ids_npdb_tracker_upd.rowcount()
	ids_npdb_tracker_upd.object.cust_3[ll_i] = ls_search_string
next

// Delete itpstat.dat file
if il_Interface = ITP_INTERFACE then
	FileDelete(is_directories[5] + "\itpstat.dat")
	FileMove(is_status_files[1], is_directories[5])
end if

// Update date the doc_ids
choose case is_process
	case is_send
		if ls_stat = "C00" then
		   of_post_send(SUCCESS)
		else
			of_post_send(FAILURE)
		end if
	case is_recieve
		// ADD POST RECIEVE HERE
end choose

Return ll_Return
end function

private function string of_create_alias ();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : of_create_alias
//==================================================================================================================
//  Purpose   	: open event
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [STRING] THE TAG STRING     
//==================================================================================================================
//  Notes     	: 	 we do not caputre any alias, also ity is not required  
//==================================================================================================================
//  Created By	: Michael B. Skinner Friday 14 January 2004 
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

LONG   ll_i
STRING ls_tag_string[]
STRING ls_return

///////////////////////////////////////////////////////////////////////
// INSERT THE DATA INTO THE SPOT
///////////////////////////////////////////////////////////////////////

ls_tag_string[upperbound(ls_tag_string) + 1]  =  'ALIAS'	  + delimiter   // TAG
// ASIAS 1
/*
ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''        + delimiter   // LAST NAME OF SUBJECT  	(NR)
ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''     	  + delimiter   // FIRST NAME OF SUBJECT  (NR)
ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''   	  + delimiter   // MIDDLE NAME OF SUBJECT	(NR)
ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''        + delimiter   // SUFFIX 						(NR)
// ASIAS 2
ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''        + delimiter   // LAST NAME OF SUBJECT 	(NR)
ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''     	  + delimiter   // FIRST NAME OF SUBJECT 	(NR)
ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''   	  + delimiter   // MIDDLE NAME OF SUBJECT	(NR)
ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''        + delimiter   // SUFFIX 						(NR)
// ASIAS 3
ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''        + delimiter   // LAST NAME OF SUBJECT 	(NR)
ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''     	  + delimiter   // FIRST NAME OF SUBJECT 	(NR)
ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''   	  + delimiter   // MIDDLE NAME OF SUBJECT (NR)
ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''        + delimiter   // SUFFIX 						(NR)
// ASIAS 4
ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''        + delimiter   // LAST NAME OF SUBJECT 	(NR)
ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''     	  + delimiter   // FIRST NAME OF SUBJECT 	(NR)
ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''   	  + delimiter   // MIDDLE NAME OF SUBJECT (NR)
ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''        + delimiter   // SUFFIX 						(NR)
// ASIAS 5
ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''        + delimiter   // LAST NAME OF SUBJECT 	(NR)
ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''     	  + delimiter   // FIRST NAME OF SUBJECT 	(NR)
ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''   	  + delimiter   // MIDDLE NAME OF SUBJECT (NR)
ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''        + delimiter   // SUFFIX 						(NR)
*/
ls_tag_string[upperbound(ls_tag_string) + 1]  =  new_line


RETURN of_assemble_string(ls_tag_string)
end function

private function string of_create_cert ();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : 
//==================================================================================================================
//  Purpose   	: open event
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [STRING] THE TAG STRING     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael B. Skinner Friday 14 January 2004 
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

LONG   ll_i
STRING ls_tag_string[]
STRING ls_return
string ls_phone  //maha 06.01.2009

///////////////////////////////////////////////////////////////////////
// INSERT THE DATA INTO THE SPOT
///////////////////////////////////////////////////////////////////////

if isnull(ids_npdb_fac_info.object.npdb_cert_ext[1]) then
	ids_npdb_fac_info.object.npdb_cert_ext[1] = ''
end if

ls_tag_string[upperbound(ls_tag_string) + 1]  =  'CERT'                                       + delimiter   // TAG
ls_tag_string[upperbound(ls_tag_string) + 1]  =  ids_npdb_fac_info.object.npdb_cert_name [1]  + delimiter   // certifying indv
ls_tag_string[upperbound(ls_tag_string) + 1]  =  ids_npdb_fac_info.object.npdb_cert_title [1] + delimiter   // certifying titlt
//Start Code Change ----06-01.2009 #V92 maha - added to srtip non-numerics as the other chars cause untrapped error
ls_phone = ids_npdb_fac_info.object.npdb_cert_phone [1] 
ls_phone =  of_strip_char("", ls_phone,"@NUM@")
ls_tag_string[upperbound(ls_tag_string) + 1]  = ls_phone + delimiter   // cert.person phone
//End Code Change---06.01.2009
ls_tag_string[upperbound(ls_tag_string) + 1]  =  ids_npdb_fac_info.object.npdb_cert_ext[1]    + delimiter   // cert. phone ext
ls_tag_string[upperbound(ls_tag_string) + 1]  =  STRING(ids_npdb_fac_info.object.npdb_cert_date[1], 'MMDDYYYY')   + delimiter   //CERT date
ls_tag_string[upperbound(ls_tag_string) + 1]  =  new_line


RETURN of_assemble_string(ls_tag_string)
end function

private function string of_create_cuse ();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : of_create_cuse
//==================================================================================================================
//  Purpose   	: open event
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [STRING] THE TAG STRING     
//==================================================================================================================
//  Notes     	:  Costumer User record
//==================================================================================================================
//  Created By	: Michael B. Skinner Friday 14 January 2004 
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

STRING ls_tag_string[]
STRING ls_return

///////////////////////////////////////////////////////////////////////
// INSERT THE DATA INTO THE SPOT
///////////////////////////////////////////////////////////////////////

ls_tag_string[upperbound(ls_tag_string) + 1]  =  'CUSE'                   + delimiter   // TAG
/// 20 char string
ls_tag_string[upperbound(ls_tag_string) + 1]  =  IS_CURRENT_FILE_NAME     + delimiter   // the doc id
									
ls_tag_string[upperbound(ls_tag_string) + 1]  =  new_line


RETURN of_assemble_string(ls_tag_string)
end function

private function string of_create_dea ();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : of_create_dea
//==================================================================================================================
//  Purpose   	: open event
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [STRING] THE TAG STRING     
//==================================================================================================================
//  Notes     	:  Costumer User record
//==================================================================================================================
//  Created By	: Michael B. Skinner Friday 14 January 2004 
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

STRING ls_tag_string[]
STRING ls_return
long ll_i
///////////////////////////////////////////////////////////////////////
// INSERT THE DATA INTO THE SPOT
///////////////////////////////////////////////////////////////////////

datastore ids_dea
ids_dea = create datastore
ids_dea.dataobject = 'd_npdb_pd_dea'
ids_dea.settransobject( sqlca)
ids_dea.retrieve(ids_pracs_info.object.prac_id[1])
ls_tag_string[upperbound(ls_tag_string) + 1]  =  'DEA'                   + delimiter   // TAG

for ll_i = 1 to ids_dea.rowcount()
	if ll_i < 5 then  // can handle only 4 DEA codes
		if f_validstr(ids_dea.object.license_number[ll_i]) then 
			ls_tag_string[upperbound(ls_tag_string) + 1]  =  ids_dea.object.license_number[ll_i]  + delimiter 
		end if 
   end if 
next

ls_tag_string[upperbound(ls_tag_string) + 1]  =  new_line


RETURN of_assemble_string(ls_tag_string)
end function

private function string of_create_fien ();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : of_create_fien
//==================================================================================================================
//  Purpose   	: open event
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [STRING] THE TAG STRING     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael B. Skinner Friday 14 January 2004 
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

STRING ls_tag_string[]
STRING ls_return
long ll_i
///////////////////////////////////////////////////////////////////////
// INSERT THE DATA INTO THE SPOT
///////////////////////////////////////////////////////////////////////

ls_tag_string[upperbound(ls_tag_string) + 1]  =  'FEIN'                   + delimiter   // TAG


datastore ids_fien
ids_fien = create datastore
ids_fien.dataobject = 'd_npdb_pd_fien'
ids_fien.settransobject( sqlca)
ids_fien.retrieve(ids_pracs_info.object.prac_id[1])

for ll_i = 1 to ids_fien.rowcount()
	if ll_i < 5 then  // can only support 4
	ls_tag_string[upperbound(ls_tag_string) + 1]  =  ids_fien.getItemString(ll_i,'id_number')  + delimiter
	end if 
next 
												
ls_tag_string[upperbound(ls_tag_string) + 1]  =  new_line


RETURN of_assemble_string(ls_tag_string)
end function

private function integer of_create_file (string as_file_name, string as_text);////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : of_create_file
//==================================================================================================================
//  Purpose   	: open and create a file
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael Skinner  Wednesday 13 October 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

blob lblb_Data
long ll_BlobLen
long ll_WriteLength

if FileExists(as_file_name) then
	if not FileDelete(as_file_name) then
		is_err_mess[upperbound(is_err_mess) + 1] = 'The ' + as_file_name + ' could not be opened. Please check to see if you have FULL permissions to this file'
		Return -1
	end if
end if

lblb_Data = Blob(as_Text,EncodingAnsi!) //Encoding – Nova 11.16.2010
ll_BlobLen = LenA(lblb_Data)
ll_WriteLength = AppeonWriteFile(as_file_name, lblb_Data, ll_BlobLen)
if ll_WriteLength < 0 then
	is_err_mess[upperbound(is_err_mess) + 1] = 'The ' + as_file_name + ' could not be opened. Please check to see if you have FULL permissions to this file' 
	Return -1
end if

Return 0

/* Delete by Evan 03.23.2010 (The function cannot create file which is more than 32KB)
long li_FileNum

li_FileNum = fileopen(as_file_name,StreamMode!, Write!, Shared!, Replace!)

if li_FileNum < 1 then
	is_err_mess[upperbound(is_err_mess) + 1] = 'The ' + as_file_name + ' could not be opened. Please check to see if you have FULL permissions to this file' 
	FileClose ( li_FileNum )
	return -1
end if
		
if FileWrite(li_FileNum,as_text) < 1 then
	is_err_mess[upperbound(is_err_mess) + 1] = 'The ' + as_file_name + ' could not be modified. Please check to see if you have FULL permissions to this file' 
	FileClose ( li_FileNum )
	return -1
end if 
		
if FileClose (li_FileNum) < 1 then
   is_err_mess[upperbound(is_err_mess) + 1] = 'The ' + as_file_name + ' could not be closed. Please check to see if you have FULL permissions to this file' 
	FileClose ( li_FileNum )
	return -1
end if
	
FileClose ( li_FileNum )
		
			
return 0
*/
end function

private function string of_create_grad ();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : 
//==================================================================================================================
//  Purpose   	: open event
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [STRING] THE TAG STRING     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael B. Skinner Friday 14 January 2004 
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

LONG   ll_i
string  ls_year_thru
STRING ls_tag_string[]
STRING ls_return
string ls_instition_name
decimal ld_lookup_code
string ls_category
Integer ll_row
integer li_grad

datastore ids_grad
ids_grad = create datastore
ids_grad.dataobject = 'd_npdb_grad2'
ids_grad.settransobject( sqlca)
ids_grad.retrieve(ids_pracs_info.object.prac_id[1])


///////////////////////////////////////////////////////////////////////
// INSERT THE DATA INTO THE SPOT
///////////////////////////////////////////////////////////////////////

if isnull(ids_npdb_fac_info.object.npdb_cert_ext[1]) then
	ids_npdb_fac_info.object.npdb_cert_ext[1] = ''
end if

ls_tag_string[upperbound(ls_tag_string) + 1]  =  'GRAD'                                      				      + delimiter   // TAG
// school 1

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<add> 06.19.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Use datastore to cache data instead of using SQLs in the loop in PT-02 to
//$<modification> reduce client-server interactions.
IF ids_grad.rowcount() > 0 THEN
	Long ll_lookup_code[]
	FOR ll_i = 1 to ids_grad.rowcount()
		ll_lookup_code[ll_i] = ids_grad.getitemdecimal( ll_i, 'institution_code')
	END FOR
	
	Datastore lds_address_lookup
	lds_address_lookup = Create Datastore
	lds_address_lookup.Dataobject = "d_address_lookup_forpt"
	lds_address_lookup.Settransobject( SQLCA )
	lds_address_lookup.Retrieve( ll_lookup_code[] )
END IF
//---------------------------- APPEON END ----------------------------

for ll_i = 1 to ids_grad.rowcount()
	if ll_i < 6 then // can only have five
			
		ld_lookup_code = ids_grad.getitemdecimal( ll_i, 'institution_code')
		//Start Code Change ----11.01 .2006 #1 maha changed to get the year from the end_date; if missing from year_to
		ls_year_thru   =  string(year(date((ids_grad.GetItemdatetime( ll_i, 'end_date')))))
		if LenA(ls_year_thru) < 1 or isnull(ls_year_thru) then  //Start Code Change ---- 05.11.2007 #V7 maha added null check
			ls_year_thru   =  string(ids_grad.GetItemNumber( ll_i, 'year_thru'))
		end if
//	debugbreak()
		//Start Code Change ----05.01.2008 #V8 maha - tray to be sure that grad year is at least 15 years after dob
		li_grad = integer(string(ids_pracs_info.object.date_of_birth[1],'YYYY'))
		if integer(string(ids_pracs_info.object.date_of_birth[1],'YYYY')) + 15 >  integer(ls_year_thru) then
			return "Failed"
		end if
		//End Code Change---05.01.2008
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<ID> PT-02
		//$<modify> 06.19.2006 By: LeiWei
		//$<reason> Performance tuning
		//$<modification> Write script to retrieve data from a cache in PT-01 instead of from the database.
		/*
		SELECT address_lookup.entity_name
		INTO :ls_instition_name  
		FROM  address_lookup
		WHERE address_lookup.lookup_code = :ld_lookup_code;
		*/
		ll_row = lds_address_lookup.Find("lookup_code = " + String(ld_lookup_code), 1, lds_address_lookup.Rowcount())
		IF ll_row > 0 THEN
			ls_instition_name = lds_address_lookup.getitemstring(ll_row, "entity_name")
		ELSE
			Setnull(ls_instition_name)
		END IF
		//---------------------------- APPEON END ----------------------------
		
		// set the inst name
		if f_validstr(ls_instition_name) then 
			ls_tag_string[upperbound(ls_tag_string) + 1]  =  ls_instition_name     + delimiter 
		else 
			ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''      					      + delimiter 
		end if 
		
		
		// set then year	
		if f_validstr(ls_year_thru) then 
			ls_tag_string[upperbound(ls_tag_string) + 1]  =  ls_year_thru     + delimiter 
		else 
			ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''      		   + delimiter 
		end if 
	end if
next


ls_tag_string[upperbound(ls_tag_string) + 1]  =  new_line

RETURN of_assemble_string(ls_tag_string)
end function

private function string of_create_hdr ();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : 
//==================================================================================================================
//  Purpose   	: 
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [STRING] THE TAG STRING     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael B. Skinner Friday 14 January 2004 
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
long ll_i
long ll_j
string ls_hdr_string[]
STRING ls_return
///////////////////////////////////////////////////////////////////////
// INSERT THE DATA INTO THE SPOT
///////////////////////////////////////////////////////////////////////

ls_hdr_string[upperbound(ls_hdr_string)+ 1]  =  'HDR'                                        + delimiter // TAG
ls_hdr_string[upperbound(ls_hdr_string)+ 1]  =  ids_npdb_fac_info.object.npdb_entity_dbid[1] + delimiter // ENTITY_DBID
ls_hdr_string[upperbound(ls_hdr_string)+ 1]  =  is_password        + delimiter // PASSWORD on facility or user level
ls_hdr_string[upperbound(ls_hdr_string)+ 1]  =  '1L'                                         + delimiter // TRANS_CD(SECTION 4 LIST T)
ls_hdr_string[upperbound(ls_hdr_string)+ 1]  =  'R10.0'                                       + delimiter // VER_NUM ////Start Code Change ---- 08.13.2007 #V7 maha
ls_hdr_string[upperbound(ls_hdr_string)+ 1]  =  IS_CURRENT_FILE_NAME                         + delimiter // SUBMISSION_FILE_NAME
ls_hdr_string[upperbound(ls_hdr_string)+ 1]  =  STRING(TODAY(),NPDB_DATE_FORMAT)             + delimiter // SUBMISSION_FILE_DATE
// AGENT ID
IF ISNULL(ids_npdb_fac_info.object.npdb_agent_dbid[1]) THEN 
	ls_hdr_string[upperbound(ls_hdr_string)+ 1] = "" + delimiter
ELSE 
	ls_hdr_string[upperbound(ls_hdr_string)+ 1] = ids_npdb_fac_info.object.npdb_agent_dbid[1]  + delimiter
END IF 
														 
ls_hdr_string[upperbound(ls_hdr_string)+ 1]  =  is_npdb_user_id  + delimiter // USER ID from user or facility
ls_hdr_string[upperbound(ls_hdr_string)+ 1] =   new_line                                                 // new_line

// we need to update this table so that we can have a record of the submission
is_current_facility_id = string(ids_pracs.object.fac_id[1])


//@@@@old code 04.08.2008@@@@ 

//ls_hdr_string[upperbound(ls_hdr_string)+ 1]  =  'HDR'                                        + delimiter // TAG
//ls_hdr_string[upperbound(ls_hdr_string)+ 1]  =  ids_npdb_fac_info.object.npdb_entity_dbid[1] + delimiter // ENTITY_DBID
//ls_hdr_string[upperbound(ls_hdr_string)+ 1]  =  ids_npdb_fac_info.object.npdb_pass[1]        + delimiter // PASSWORD
//ls_hdr_string[upperbound(ls_hdr_string)+ 1]  =  '1L'                                         + delimiter // TRANS_CD(SECTION 4 LIST T)
//ls_hdr_string[upperbound(ls_hdr_string)+ 1]  =  'R9.0'                                       + delimiter // VER_NUM ////Start Code Change ---- 08.13.2007 #V7 maha
//ls_hdr_string[upperbound(ls_hdr_string)+ 1]  =  IS_CURRENT_FILE_NAME                         + delimiter // SUBMISSION_FILE_NAME
//ls_hdr_string[upperbound(ls_hdr_string)+ 1]  =  STRING(TODAY(),NPDB_DATE_FORMAT)             + delimiter // SUBMISSION_FILE_DATE
//// AGENT ID
//IF ISNULL(ids_npdb_fac_info.object.npdb_agent_dbid[1]) THEN 
//	ls_hdr_string[upperbound(ls_hdr_string)+ 1] = "" + delimiter
//ELSE 
//	ls_hdr_string[upperbound(ls_hdr_string)+ 1] = ids_npdb_fac_info.object.npdb_agent_dbid[1]  + delimiter
//END IF 
//														 
//ls_hdr_string[upperbound(ls_hdr_string)+ 1]  =  gs_user_id                                   + delimiter // USER_IF
//ls_hdr_string[upperbound(ls_hdr_string)+ 1] =   new_line                                                 // new_line
//
//// we need to update this table so that we can have a record of the submission
//
////ids_npdb_tracker_upd.insertrow(0)
////ids_npdb_tracker_upd.OBJECT.user_id[ids_npdb_tracker_upd.rowcount()]     = gs_user_id 
////ids_npdb_tracker_upd.OBJECT.doc_id[ids_npdb_tracker_upd.rowcount()]      = IS_CURRENT_file_name           // THE DOC ID
////ids_npdb_tracker_upd.OBJECT.PRAC_id[ids_npdb_tracker_upd.rowcount()]     = ids_pracs.object.prac_id[1]    // THE PRAC_ID
//is_current_facility_id = string(ids_pracs.object.fac_id[1])
////ids_npdb_tracker_upd.OBJECT.facility_id[ids_npdb_tracker_upd.rowcount()] = ids_pracs.object.fac_id[1]

RETURN of_assemble_string(ls_hdr_string)
end function

private function string of_create_isofl ();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : of_create_ISOFL
//==================================================================================================================
//  Purpose   	: open event
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [STRING] THE TAG STRING     
//==================================================================================================================
//  Notes     	:  Costumer User record
//==================================================================================================================
//  Created By	: Michael B. Skinner Friday 14 January 2004 
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//THIS FUNCTION NO LONGER USED

STRING ls_tag_string[]
STRING ls_return
string ls_category
long ll_cat //Start Code Change ---- 10.03.2006 #654 maha
long ll_spec_count
long ll_lic_count
long ll_max_count
long ll_i

long ld_state_code, ld_speciality_code,ld_prac_cat
string ls_state,ls_specilaity	


//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-09
//$<modify> 04.04.2006 By: Rodger Wu
//$<reason> Performance Tuning
//$<modification> Define the datastore for caching data.
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
/*
datastore ids_speciality
ids_speciality = create datastore
ids_speciality.dataobject = 'd_npdb_pd_speciality'
ids_speciality.settransobject( sqlca)
ll_spec_count = ids_speciality.retrieve(ids_pracs_info.object.prac_id[1])

datastore ids_lic
ids_lic = create datastore
ids_lic.dataobject = 'd_npdb_pd_lic'
ids_lic.settransobject( sqlca)
ll_lic_count = ids_lic.retrieve(ids_pracs_info.object.prac_id[1] )
*/
datastore ids_speciality
ids_speciality = create datastore
ids_speciality.dataobject = 'd_npdb_pd_speciality'
ids_speciality.settransobject( sqlca)

datastore ids_lic
ids_lic = create datastore
ids_lic.dataobject = 'd_npdb_pd_lic'
ids_lic.settransobject( sqlca)

gnv_appeondb.of_startqueue( )

ids_speciality.retrieve(ids_pracs_info.object.prac_id[1])
ids_lic.retrieve(ids_pracs_info.object.prac_id[1] )

gnv_appeondb.of_commitqueue( )

ll_spec_count = ids_speciality.Rowcount( )
ll_lic_count = ids_lic.Rowcount( )
//---------------------------- APPEON END ----------------------------

///////////////////////////////////////////////////////////////////////
// INSERT THE DATA INTO THE SPOT
///////////////////////////////////////////////////////////////////////

ls_tag_string[upperbound(ls_tag_string) + 1]  =  'ISOFL'                   + delimiter   // TAG
//////////// 1
///OCCUPATIONAL FIELD REQUIRED

//mahald_prac_cat = ids_pracs_info.OBJECT.prac_category[1]

ld_prac_cat = ids_pracs_info.OBJECT.license[1]




//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-10
//$<comment> 06.19.2006 By: LeiWei
//$<reason> Performance tuning 
//$<modification> Write script to retrieve data from a cache instead of from the database.
/*
SELECT code_lookup.description
INTO :ls_category  
FROM  code_lookup  
WHERE code_lookup.lookup_code = :ld_prac_cat;
*/
//Start Code Change ---- 10.03.2006 #655 maha
//ls_category = gnv_data.of_getitem("code_lookup" , "description","lookup_code = " + String(ld_prac_cat))

//---------------------------- APPEON END ----------------------------

//\/maha
//////SELECT code_lookup.ic_n
//////INTO :ll_cat  
//////FROM  code_lookup  
//////WHERE code_lookup.lookup_code = :ld_prac_cat;
//////
//////if isnull(ll_cat) then  //Start Code Change ---- 12.19.06.2006 #V7 maha
//////	ls_category = ''
//////else
//////	ls_category = string(ll_cat)
////////end if

if isnull(ld_prac_cat) then  //Start Code Change ---- 12.19.06.2006 #V7 maha
	ls_category = ''
else
	ls_category = string(ld_prac_cat)
end if
//messagebox("ls_category",ls_category)
if LenA(ls_category) = 0 then
	ls_category = "699"
elseif LenA(ls_category) = 1 then
	ls_category = "00" + ls_category 
elseif LenA(ls_category) = 2 then
	ls_category = "0" + ls_category
end if

choose case ls_category
		case "010","015","020","025","030","035"
			//don't add description
			ls_tag_string[upperbound(ls_tag_string) + 1]  = ls_category                        +  delimiter
			ls_tag_string[upperbound(ls_tag_string) + 1]  =  ""		      + delimiter 
//		case "699","899"
//			ls_tag_string[upperbound(ls_tag_string) + 1]  = ls_category  +  delimiter  //Start Code Change ---- 011007 maha added delimiter
//			SELECT code_lookup.description
//			INTO :ls_category  
//			FROM  code_lookup  
//			WHERE code_lookup.lookup_code = :ld_prac_cat;
//			ls_tag_string[upperbound(ls_tag_string) + 1]  = ls_category  +   delimiter  //Start Code Change ---- 011007 maha added delimiter
		case else
			ls_tag_string[upperbound(ls_tag_string) + 1]  =  ""		      + delimiter 
			ls_tag_string[upperbound(ls_tag_string) + 1]  =  ""		      + delimiter 
end choose


////if ls_category <> "699" then
////	ls_tag_string[upperbound(ls_tag_string) + 1]  = ls_category                        +  delimiter
////	ls_tag_string[upperbound(ls_tag_string) + 1]  =  ""		      + delimiter 
////else //if 699 add the license type description
////	ls_tag_string[upperbound(ls_tag_string) + 1]  = ls_category  +  delimiter  //Start Code Change ---- 011007 maha added delimiter
////	SELECT code_lookup.description
////	INTO :ls_category  
////	FROM  code_lookup  
////	WHERE code_lookup.lookup_code = :ld_prac_cat;
////	ls_tag_string[upperbound(ls_tag_string) + 1]  = ls_category  +   delimiter  //Start Code Change ---- 011007 maha added delimiter
////
////end if
//choose case upper(trim(ls_category)) //removed 8-17
//	case upper("Allopathic Physician")
//		 ls_tag_string[upperbound(ls_tag_string) + 1]  = '010'                        +  delimiter
//		 ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''		      + delimiter  
//	case else 
//		 ls_tag_string[upperbound(ls_tag_string) + 1]  = '699'                         +  delimiter
//		 ls_tag_string[upperbound(ls_tag_string) + 1]  = ls_category                  +  delimiter
//		 
//end choose 

//End Code Change---10.03.2006


///////////////////////////////////////////////////////////////////////////////////////////
// determine which is greater lic or spec
///////////////////////////////////////////////////////////////////////////////////////////

if  ll_spec_count > ll_lic_count then ll_max_count = ll_spec_count
if  ll_lic_count  > ll_spec_count then ll_max_count = ll_lic_count
if  ll_lic_count  = ll_spec_count then ll_max_count = ll_lic_count

///////////////////////////////////////////////////////////////////////////////////////////
// set the values
///////////////////////////////////////////////////////////////////////////////////////////

for ll_i = 1 to ll_max_count
	// state lic #
	if ids_lic.rowcount() >= ll_i then 
	   ls_tag_string[upperbound(ls_tag_string) + 1]  =  ids_lic.getItemString(ll_i,'license_number') + delimiter
	else 
		ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''		      + delimiter 
	end if
	// state of Lic
	
	if ids_lic.rowcount() >= ll_i then 
		
		ld_state_code = ids_lic.GetItemDecimal (ll_i,'state')
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<ID> PT-11
		//$<comment> 06.19.2006 By: LeiWei
		//$<reason> Performance tuning 
		//$<modification> Write script to retrieve data from a cache instead of from the database.
		/*
		SELECT code_lookup.code
		INTO :ls_state  
		FROM  code_lookup  
		WHERE code_lookup.lookup_code = :ld_state_code;
		*/
		
		ls_state = gnv_data.of_getitem("code_lookup" , "code", "lookup_code = " + String(ld_state_code))
		
		//---------------------------- APPEON END ----------------------------

		
		if f_validstr(ls_state) then 
			ls_tag_string[upperbound(ls_tag_string) + 1]  =  ls_state      + delimiter
		else 
			ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''		      + delimiter 
		end if 
		
	else 
		ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''		         + delimiter 
   end if
	// speciality - from list D
	if ll_spec_count > 0 and ll_spec_count <= ll_i then//Start Code Change ----10.03.2006 #656 maha 
		// get the description of the speciality
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<ID> PT-12
		//$<comment> 06.19.2006 By: LeiWei
		//$<reason> Performance tuning 
		//$<modification> Write script to retrieve data from a cache instead of from the database.
		/*
		SELECT code_lookup.description
      INTO :ls_specilaity  
      FROM  code_lookup  
      WHERE code_lookup.lookup_code = :ld_speciality_code;
		*/
		
		ls_specilaity = gnv_data.of_getitem("code_lookup" , "description", "lookup_code = " + String(ld_speciality_code))
		
		//---------------------------- APPEON END ----------------------------
		
		string ls_speciality_code
	   
		SELECT npdb_list_code
      INTO :ls_speciality_code
      FROM  npdb_code_lookup 
      WHERE npdb_list = 'list_d' and npdb_list_code_description  = :ls_specilaity ;

		if f_validstr(ls_speciality_code) then 
			ls_tag_string[upperbound(ls_tag_string) + 1]  =  ls_speciality_code		      + delimiter 
		else 
			ls_tag_string[upperbound(ls_tag_string) + 1]  =  '98'		                     + delimiter 
		end if 
		
	else 
		
		ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''		             + delimiter 
		
	end if
	
	// second occupation field -- not supported
	ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''		                     + delimiter 
	// other occuplation field -- not supported
	ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''		                   + delimiter 
next



ls_tag_string[upperbound(ls_tag_string) + 1]  =  new_line


RETURN of_assemble_string(ls_tag_string)
end function

private function string of_create_isubj ();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : invd subject data record
//==================================================================================================================
//  Purpose   	: open event
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [STRING] THE TAG STRING     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael B. Skinner Friday 14 January 2004 
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

LONG   ll_i
STRING ls_tag_string[]
STRING ls_return
decimal ld_lookup
		string ls_state_code
///////////////////////////////////////////////////////////////////////
// INSERT THE DATA INTO THE SPOT
///////////////////////////////////////////////////////////////////////

if isnull(ids_npdb_fac_info.object.npdb_cert_ext[1]) then
	ids_npdb_fac_info.object.npdb_cert_ext[1] = ''
end if
//debugbreak()
// mskinner 18 april 2006 -- begin 
// get the address info
 
   lds_address_info.retrieve(ids_pracs_info.object.prac_id[1] ,il_current_fac_id )
// mskinner 18 april 2006 -- end
ls_tag_string[upperbound(ls_tag_string) + 1]  =  'ISUBJ'                                      				  + delimiter   // TAG
ls_tag_string[upperbound(ls_tag_string) + 1]  =  ids_pracs_info.object.last_name [1]      					  + delimiter   // LAST NAME OF SUBJECT
ls_tag_string[upperbound(ls_tag_string) + 1]  =  ids_pracs_info.object.first_name [1]     					  + delimiter   // FIRST NAME OF SUBJECT
ls_tag_string[upperbound(ls_tag_string) + 1]  =  TRIM(ids_pracs_info.object.middle_name [1])    			  + delimiter   // MIDDLE NAME OF SUBJECT (NR)
ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''                                       				     + delimiter   // SUFFIX (NR)
ls_tag_string[upperbound(ls_tag_string) + 1]  =  upper(LeftA(string(ids_pracs_info.object.gender[1]),1))    + delimiter   // GENGER 
// filter out the home address

lds_address_info.Setfilter('home_address = 1')
lds_address_info.filter( )


if lds_address_info.rowcount() > 0 then 
	// street
	if f_validstr(lds_address_info.object.street[1]) then
		 ls_tag_string[upperbound(ls_tag_string) + 1]  =  lds_address_info.object.street[1]						  + delimiter // HOME ADDRESS (NR IF WORK ADDRESS KNOWN)
	   else 
	   ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''  																  + delimiter   // HOME ADDRESS (NR IF WORK ADDRESS KNOWN)
   end if 
	
	// street_2
	if f_validstr(lds_address_info.object.street_2[1]) then
		 ls_tag_string[upperbound(ls_tag_string) + 1]  =  lds_address_info.object.street_2[1]						  + delimiter // HOME ADDRESS (NR IF WORK ADDRESS KNOWN)
	   else 
	   ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''  																  + delimiter   // HOME ADDRESS (NR IF WORK ADDRESS KNOWN)
   end if 
	// city
	if f_validstr(lds_address_info.object.city[1]) then
		ls_tag_string[upperbound(ls_tag_string) + 1]  =  lds_address_info.object.city[1]							 + delimiter   // HOME CITY (NR)
	else 
		ls_tag_string[upperbound(ls_tag_string) + 1]  =  '' 																 + delimiter   // HOME CITY (NR)
	end if 
	
	// state
	if f_validstr(string(lds_address_info.object.state[1])) then
		
		
		ld_lookup = lds_address_info.object.state[1]
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<ID> PT-14
		//$<comment> 06.19.2006 By: LeiWei
		//$<reason> Performance tuning 
		//$<modification> Write script to retrieve data from a cache instead of from the database.
		/*
		SELECT code_lookup.code
		INTO :ls_state_code  
		FROM code_lookup
		WHERE code_lookup.lookup_code = :ld_lookup;
		*/
		
		ls_state_code = gnv_data.of_getitem("code_lookup" , "code", "lookup_code = " + String(ld_lookup))
		
		//---------------------------- APPEON END ----------------------------

		ls_tag_string[upperbound(ls_tag_string) + 1]  =  ls_state_code    											+ delimiter   // HOME STATE (NR)
	else 
		ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''    															+ delimiter   // HOME STATE (NR)
	end if 
	
	// country
	
	if f_validstr(string(lds_address_info.object.country[1])) then
		ld_lookup = lds_address_info.object.country[1]
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<ID> PT-15
		//$<comment> 06.19.2006 By: LeiWei
		//$<reason> Performance tuning 
		//$<modification> Write script to retrieve data from a cache instead of from the database.
		/*
		SELECT code_lookup.code
		INTO :ls_state_code  
		FROM code_lookup
		WHERE code_lookup.lookup_code = :ld_lookup;
		*/
		
		ls_state_code = gnv_data.of_getitem("code_lookup" , "code", "lookup_code = " + String(ld_lookup))
		
		//---------------------------- APPEON END ----------------------------

		ls_tag_string[upperbound(ls_tag_string) + 1]  =  ls_state_code    											+ delimiter   // HOME STATE (NR)
	else 
		ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''    															+ delimiter   // HOME STATE (NR)
	end if 
	// zip
	
	if f_validstr(string(lds_address_info.object.zip[1])) then
		ls_tag_string[upperbound(ls_tag_string) + 1]  =  lefta(lds_address_info.object.zip[1],5	)						+ delimiter   // HOME ZIP5 (NR)   //Start Code Change ----07.25.2012 #V12 maha - limit to 5 char
   	else
		ls_tag_string[upperbound(ls_tag_string) + 1]  =  '' 																+ delimiter   // HOME ZIP5 (NR)
   end if 
	// not supported by intellicred
	
	ls_tag_string[upperbound(ls_tag_string) + 1]  =  '' 																	+ delimiter   // HOME ZIP4 (NR)
	
	
	
	
else 
	ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''  																		  + delimiter   // HOME ADDRESS (NR IF WORK ADDRESS KNOWN)
	ls_tag_string[upperbound(ls_tag_string) + 1]  =  '' 																		  + delimiter   // HOME ADDDR2 (NR)
	ls_tag_string[upperbound(ls_tag_string) + 1]  =  '' 																		  + delimiter   // HOME CITY (NR)
	ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''    																	  + delimiter   // HOME STATE (NR)
	ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''   																	  + delimiter   // HOME CNTRY (NR)
	ls_tag_string[upperbound(ls_tag_string) + 1]  =  '' 																		  + delimiter   // HOME ZIP5 (NR)
	ls_tag_string[upperbound(ls_tag_string) + 1]  =  '' 																		  + delimiter   // HOME ZIP4 (NR)
end if 



// filter out the primary_office address

lds_address_info.Setfilter('primary_office = 1')
lds_address_info.filter( )

//Start Code Change ---- 10.03.2006 #657 maha
if lds_address_info.rowcount( ) > 0 then
	ls_tag_string[upperbound(ls_tag_string) + 1]  =  lds_address_info.object.street[1]							       + delimiter   // ORG NAME (NR)
else
	return "Failed"  //Start Code Change ----04.25.2008 #V8 maha
	ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''
end if
//End Code Change---10.03.2006

ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''    																	    + delimiter   // ORG_TYPE (NR)
ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''																		    + delimiter   // ORG TYPE DESC (NR)
if lds_address_info.rowcount( ) > 0 then 
	// address_1
	if f_validstr(lds_address_info.object.street[1]) then
		 ls_tag_string[upperbound(ls_tag_string) + 1]  =  lds_address_info.object.street[1]						  + delimiter // HOME ADDRESS (NR IF WORK ADDRESS KNOWN)
	   else 
	   ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''  																  + delimiter   // HOME ADDRESS (NR IF WORK ADDRESS KNOWN)
   end if 
	
	// street_2
	if f_validstr(lds_address_info.object.street_2[1]) then
		 ls_tag_string[upperbound(ls_tag_string) + 1]  =  lds_address_info.object.street_2[1]						  + delimiter // HOME ADDRESS (NR IF WORK ADDRESS KNOWN)
	   else 
	   ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''  																  + delimiter   // HOME ADDRESS (NR IF WORK ADDRESS KNOWN)
   end if 
	
	// city
	if f_validstr(lds_address_info.object.city[1]) then
		ls_tag_string[upperbound(ls_tag_string) + 1]  =  lds_address_info.object.city[1]							 + delimiter   // HOME CITY (NR)
	else 
		ls_tag_string[upperbound(ls_tag_string) + 1]  =  '' 																 + delimiter   // HOME CITY (NR)
	end if 
	
	// state
	if f_validstr(string(lds_address_info.object.state[1])) then
		
		
		ld_lookup = lds_address_info.object.state[1]
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<ID> PT-16
		//$<comment> 06.19.2006 By: LeiWei
		//$<reason> Performance tuning 
		//$<modification> Write script to retrieve data from a cache instead of from the database.
		/*
		SELECT code_lookup.code
		INTO :ls_state_code  
		FROM code_lookup
		WHERE code_lookup.lookup_code = :ld_lookup;
		*/
		
		ls_state_code = gnv_data.of_getitem("code_lookup" , "code", "lookup_code = " + String(ld_lookup))
		
		//---------------------------- APPEON END ----------------------------

		ls_tag_string[upperbound(ls_tag_string) + 1]  =  ls_state_code    											+ delimiter   // HOME STATE (NR)
	else 
		ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''    															+ delimiter   // HOME STATE (NR)
	end if 
	
	// country
	
	if f_validstr(string(lds_address_info.object.country[1])) then
		ld_lookup = lds_address_info.object.country[1]
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<ID> PT-17
		//$<comment> 06.19.2006 By: LeiWei
		//$<reason> Performance tuning 
		//$<modification> Write script to retrieve data from a cache instead of from the database.
		/*
		SELECT code_lookup.code
		INTO :ls_state_code  
		FROM code_lookup
		WHERE code_lookup.lookup_code = :ld_lookup;
		*/
		
		ls_state_code = gnv_data.of_getitem("code_lookup" , "code", "lookup_code = " + String(ld_lookup))
		
		//---------------------------- APPEON END ----------------------------

		ls_tag_string[upperbound(ls_tag_string) + 1]  =  ls_state_code    											+ delimiter   // HOME STATE (NR)
	else 
		ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''    															+ delimiter   // HOME STATE (NR)
	end if 
	// zip
	
	if f_validstr(string(lds_address_info.object.zip[1])) then
		ls_tag_string[upperbound(ls_tag_string) + 1]  =  lefta(lds_address_info.object.zip[1]	, 5 )						+ delimiter   // HOME ZIP5 (NR)   //Start Code Change ----07.25.2012 #V12 maha - limit to 5 char
   	else
		ls_tag_string[upperbound(ls_tag_string) + 1]  =  '' 																+ delimiter   // HOME ZIP5 (NR)
   end if 
	// not supported by intellicred
	ls_tag_string[upperbound(ls_tag_string) + 1]  =  '' 																	+ delimiter   // HOME ZIP4 (NR)
	
else 
	ls_tag_string[upperbound(ls_tag_string) + 1]  =  ""           				                                      + delimiter   // WORK ADDRESS1
	ls_tag_string[upperbound(ls_tag_string) + 1]  =  "" 							  + delimiter   // WORK ADDRESS2
	ls_tag_string[upperbound(ls_tag_string) + 1]  =  ""								  + delimiter   // WORK STATE // WORK CITY
	ls_tag_string[upperbound(ls_tag_string) + 1]  =  "" 								  + delimiter   // work state 
	ls_tag_string[upperbound(ls_tag_string) + 1]  =  "" 																		  + delimiter   // WORK CNTRY
	ls_tag_string[upperbound(ls_tag_string) + 1]  =  ""									  + delimiter   // WORK ZIP5
	ls_tag_string[upperbound(ls_tag_string) + 1]  =  ""                                                        + delimiter   // WORK ZIP4 (NR)
end if 
ls_tag_string[upperbound(ls_tag_string) + 1]  =  string(ids_pracs_info.object.date_of_birth[1],'MMDDYYYY') + delimiter   // DOB
/*
ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''																		  + delimiter   // DECEASED
ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''  																		  + delimiter   // DECEASED DATE
*/
ls_tag_string[upperbound(ls_tag_string) + 1]  =  new_line

RETURN of_assemble_string(ls_tag_string)
end function

private function string of_create_npi ();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : of_create_NPI
//==================================================================================================================
//  Purpose   	: open event
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [STRING] THE TAG STRING     
//==================================================================================================================
//  Notes     	: National Provider Indentifier    
//==================================================================================================================
//  Created By	: Michael B. Skinner Friday 14 January 2004 
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

STRING ls_tag_string[]
STRING ls_return
string ls_npi_number
long ll_prac_id
///////////////////////////////////////////////////////////////////////
// INSERT THE DATA INTO THE SPOT
///////////////////////////////////////////////////////////////////////

ll_prac_id = ids_pracs_info.object.prac_id[1]
ls_tag_string[upperbound(ls_tag_string) + 1]  =  'NPI'                   + delimiter   // TAG

SELECT pd_basic.npi_number
INTO   :ls_npi_number  
FROM   pd_basic 
WHERE  pd_basic.prac_id = :ll_prac_id;


if f_validstr(ls_npi_number) then
	ls_tag_string[upperbound(ls_tag_string) + 1]  =  ls_npi_number		  + delimiter  
end if 


/*
/// NPI 1
ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''      					  + delimiter   
/// NPI 2
ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''      					  + delimiter   
/// NPI 3
ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''      					  + delimiter   
/// NPI 4
ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''      					  + delimiter  */ 
												
ls_tag_string[upperbound(ls_tag_string) + 1]  =  new_line

// ASSEMBLE THE STRING

RETURN of_assemble_string(ls_tag_string)
end function

private function string of_create_qry ();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : 
//==================================================================================================================
//  Purpose   	: open event
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [STRING] THE TAG STRING     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael B. Skinner Friday 14 January 2004 
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


LONG   ll_i
STRING ls_tag_string[]
STRING ls_return

///////////////////////////////////////////////////////////////////////
// INSERT THE DATA INTO THE SPOT
///////////////////////////////////////////////////////////////////////

if isnull(ids_cc_information.object.cc_billing_addr2[1]) then
	ids_cc_information.object.cc_billing_addr2[1] = ''
end if

ls_tag_string[upperbound(ls_tag_string)+ 1] =  'QRY'                                           + delimiter   // TAG
ls_tag_string[upperbound(ls_tag_string)+ 1] =  'R'                                             + delimiter   // QUERY PORPOSE R - PROFESSIONAL REVIEW
ls_tag_string[upperbound(ls_tag_string)+ 1] =  '1'        												  + delimiter   // NBR_QRY
ls_tag_string[upperbound(ls_tag_string)+ 1] =  ids_npdb_fac_info.object.npdb_pay_type[1]       + delimiter   // Payment type

if upper(ids_npdb_fac_info.object.npdb_pay_type[1]) = "C" and not (ib_recieving)then
	ls_tag_string[upperbound(ls_tag_string)+ 1] =  ids_cc_information.object.npdb_cc_nbr[1]         + delimiter   // credi card number
	ls_tag_string[upperbound(ls_tag_string)+ 1] =  ids_cc_information.object.npdb_cc_exp[1]         + delimiter   // cc_exp date
	ls_tag_string[upperbound(ls_tag_string)+ 1] =  ids_cc_information.object.cc_cardholder[1]       + delimiter   // cc_cardholder
	ls_tag_string[upperbound(ls_tag_string)+ 1] =  ids_cc_information.object.cc_billing_addr1[1]    + delimiter   // cc_billing addr1
	ls_tag_string[upperbound(ls_tag_string)+ 1] =  ids_cc_information.object.cc_billing_addr2[1]    + delimiter   // not required cc_billing addr1
	ls_tag_string[upperbound(ls_tag_string)+ 1] =  ids_cc_information.object.cc_billing_city[1]     + delimiter   // billing city
	ls_tag_string[upperbound(ls_tag_string)+ 1] =  ids_cc_information.object.cc_billing_state[1]    + delimiter   // billing state
	ls_tag_string[upperbound(ls_tag_string)+ 1] =  ''                                              + delimiter   // leave county blank (usa)
	ls_tag_string[upperbound(ls_tag_string)+ 1] =  ids_cc_information.object.cc_zip5[1]             + delimiter   // 
end if

ls_tag_string[upperbound(ls_tag_string)+ 1] =  new_line

RETURN of_assemble_string(ls_tag_string)
end function

private function string of_create_ssn ();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : of_create_alias
//==================================================================================================================
//  Purpose   	: open event
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [STRING] THE TAG STRING     
//==================================================================================================================
//  Notes     	: 	 we do not caputre any alias, also ity is not required  
//==================================================================================================================
//  Created By	: Michael B. Skinner Friday 14 January 2004 
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//NOTE: USED ONLY FOR ITP


LONG   ll_i
STRING ls_tag_string[]
STRING ls_return

///////////////////////////////////////////////////////////////////////
// INSERT THE DATA INTO THE SPOT
///////////////////////////////////////////////////////////////////////


ls_tag_string[upperbound(ls_tag_string) + 1]  =  'SSN'	                     + delimiter   // TAG
// SSN 1
ls_tag_string[upperbound(ls_tag_string) + 1]  =  ids_pracs_info.OBJECT.ssn[1]	+ delimiter   
/*
// SSN 2
ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''     	                     + delimiter   
// SSN 3
ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''   	                     + delimiter   
// SSN 4
ls_tag_string[upperbound(ls_tag_string) + 1]  =  ''                           + delimiter  
*/					
ls_tag_string[upperbound(ls_tag_string) + 1]  =  new_line


RETURN of_assemble_string(ls_tag_string)
end function

private function integer of_create_submission_file ();return 1
end function

private function integer of_create_tables ();

// create tables
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_aar  (     npdb_hdr_id  integer not null,report_id integer not null,    rpt_dcn              varchar(20)   NULL,    aa_rpt_type          varchar(20)   NULL,    aa_dte_of_action     varchar(20)   NULL,    aa_class_cd          varchar(20)   NULL,    length_of_act_day    varchar(20)   NULL,    length_of_act_man    varchar(20)   NULL,    eff_dte_of_action    varchar(20)   NULL,    pract_deceassed_fl   varchar(20)   NULL,    aa_desc              varchar(2000)   NULL, primary key (npdb_hdr_id,report_id) );"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_aart (     npdb_hdr_id  integer not null,report_id integer not null,  AAR_TYPE             char(2)   NULL,    aar_subject_type     char(1)   NULL,    rpt_type             char(1)   NULL,    orig_dt              char(8)   NULL,    rec_dt               char(8)   NULL,    titleiv              char(1)   NULL,    reserved             varchar(20)   NULL,    aart_1128e           char(1)   NULL,    npdb_fl              char(1)   NULL,    hipdb_fl             char(1)   NULL,    primary key (npdb_hdr_id,report_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_aff  (     npdb_hdr_id  integer not null,report_id integer not null,  name1                varchar(50)   NULL, addr1_1              varchar(50)   NULL, addr2_1              varchar(50)   NULL, city1                varchar(50)   NULL, state1               char(2)   NULL,cntry1               varchar(30)   NULL, zip5_1               char(5)   NULL, zip4_1               varchar(4)   NULL, nrs1                 varchar(10)   NULL,o_nrs1               varchar(40)   NULL, name2                varchar(50)   NULL,addr1_2              varchar(50)   NULL, addr2_2              varchar(50)   NULL, city2                varchar(40)   NULL, state2               char(2)   NULL,cntry2               varchar(30)   NULL, zip5_2               char(5)   NULL, zip4_2               char(4)   NULL, nrs2                 varchar(20)   NULL, o_nrs2               varchar(50)   NULL, name3                varchar(50)   NULL, addr1_3              varchar(50)   NULL,  addr2_3              varchar(50)   NULL, city3                varchar(40)   NULL, state3               char(2)   NULL, cntry3               varchar(30)   NULL, zip5_3               char(5)   NULL,zip4_3               char(4)   NULL, nrs3                 varchar(10)   NULL,o_nrs3               varchar(50)   NULL, name4                varchar(50)   NULL, addr1_4              varchar(50)   NULL,  addr2_4              varchar(50)   NULL, city4                varchar(50)   NULL, state4               char(2)   NULL, cntry4               varchar(30)   NULL, zip5_4               char(5)   NULL, zip4_4               char(4)   NULL, nrs4                 varchar(10)   NULL,o_nrs4               varchar(50)   NULL, primary key (npdb_hdr_id,report_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_agnt (     npdb_hdr_id  integer not null,report_id integer not null, agent_nm             varchar(50)   NULL, agent_phone          varchar(10)   NULL,    agent_ext            varchar(10)   NULL,    primary key (npdb_hdr_id,report_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_alias(     npdb_hdr_id  integer not null,report_id integer not null, alias_lname1         varchar(30)   NULL, alias_fname1         varchar(30)   NULL,alias_mname1         varchar(30)   NULL, alias_suffix1        varchar(30)   NULL, alias_lname2         varchar(30)   NULL,alias_fname2         varchar(30)   NULL,alias_mname2         varchar(30)   NULL,alias_suffix2        varchar(30)   NULL, alias_lname3         varchar(30)   NULL,alias_fname3         varchar(30)   NULL, alias_mname3         varchar(30)   NULL,alias_suffix3        varchar(30)   NULL, alias_lname4         varchar(30)   NULL,alias_fname4         varchar(30)   NULL, alias_mname4         varchar(30)   NULL,  alias_suffix4        varchar(30)   NULL, alias_lname5         varchar(30)   NULL, alias_fname5         varchar(30)   NULL, alias_mname5         varchar(30)   NULL,  alias_suffix5        varchar(30)   NULL,  primary key (npdb_hdr_id,report_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_aocd (     npdb_hdr_id  integer not null,report_id integer not null, act_or_code1         varchar(10)   NULL,    o_act_or_code1       varchar(50)   NULL,    act_or_code2         varchar(10)   NULL,    o_act_or_code2       varchar(50)   NULL,    act_or_code3         varchar(10)   NULL,    o_act_or_code3       varchar(50)   NULL,    act_or_code4         varchar(10)   NULL,    o_act_or_code4       varchar(50)   NULL,    act_or_code5         varchar(10)   NULL,    o_act_or_code5       varchar(50)   NULL,primary key (npdb_hdr_id,report_id) );"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_apeal(     npdb_hdr_id  integer not null,report_id integer not null, on_appeal            varchar(50)   NULL,  appeal_date          varchar(8)   NULL,  creation_date        timestamp   NULL,  primary key (npdb_hdr_id,report_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_bactn(     npdb_hdr_id  integer not null,report_id integer not null,basis1               varchar(10)   NULL, basis_desc1          VARCHAR(100)   NULL, basis2               varchar(10)   NULL, basis_desc2          varchar(100)   NULL,  basis3               varchar(10)   NULL,  basis_desc3          varchar(100)   NULL, basis4               varchar(10)   NULL,  basis_desc4          varchar(100)   NULL, primary key (npdb_hdr_id,report_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_caar (     npdb_hdr_id  integer not null,report_id integer not null, rpt_dcn varchar(20)   NULL,name varchar(50)   NULL, amount varchar(20)   NULL, actn_taken_dte       varchar(8)   NULL, dte_of_actn          varchar(8)   NULL, aar_action_length_type varchar(5)   NULL, aar_actn_years       varchar(5)   NULL, arr_actn_mnths       varchar(5)   NULL, arr_actn_days        varchar(5)   NULL, automatic_rnstmnt    varchar(5)   NULL, narrative_desc       varchar(2000)   NULL,reserved             varchar(40)   NULL, ccb        varchar(10)   NULL, aa_class_cd1  varchar(10)   NULL,aa_class_cd_desc1 varchar(50)   NULL, aa_class_cd2 varchar(10)   NULL,aa_class_cd_desc2    varchar(2000)   NULL,aa_class_cd_3        varchar(10)   NULL,aa_class_cd_desc3 varchar(2000)   NULL, aa_class_cd_4 varchar(10)   NULL,  aa_class_cd_desc4 varchar(2000)   NULL, aa_class_cd_5 varchar(10)   NULL, aa_class_cd_desc5 varchar(2000)   NULL, primary key (npdb_hdr_id,report_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_cert (     npdb_hdr_id  integer not null,report_id integer not null, cert_nm              varchar(50)   NULL, cert_title           varchar(50)   NULL,  cert_phone           varchar(10)   NULL,cert_ext             varchar(10)   NULL,  cert_date            varchar(8)   NULL, primary key (npdb_hdr_id,report_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_clia (     npdb_hdr_id  integer not null,report_id integer not null,  number1              varchar(20)   NULL, number2              varchar(20)   NULL, number3              varchar(20)   NULL, number4              varchar(20)   NULL, number5              varchar(20)   NULL, number6              varchar(20)   NULL, primary key (npdb_hdr_id,report_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_code_lookup ( npdb_list    varchar(50)                    not null, npdb_list_code       varchar(50)                    not null,  npdb_list_code_description varchar(2000)   NULL, primary key (npdb_list, npdb_list_code));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_control     ( control_id           integer                        not null, dw_name              varchar(30)                    not null,  submission_indv_order integer   NULL,  submission_org_order integer   NULL, primary key (control_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_cuse (     npdb_hdr_id  integer not null,report_id integer not null, customer_use_fld     varchar(20)   NULL, primary key (npdb_hdr_id,report_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_data_columns(data_record varchar(10)  not null, field                varchar(100)                   not null, field_type           char(1)   NULL, field_description    varchar(1000)   NULL,  primary key (data_record, field));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_dea  (     npdb_hdr_id  integer not null,report_id integer not null, dea1                 varchar(20)   NULL,  dea2                 varchar(20)   NULL, dea3                 varchar(20)   NULL, dea4                 varchar(20)   NULL,  primary key (npdb_hdr_id,report_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_enty (     npdb_hdr_id  integer not null,report_id integer not null, reserved             varchar(25)   NULL, entity_nm            varchar(70)   NULL, entity_addr1         varchar(40)   NULL, entity_addr2         varchar(40)   NULL, entity_city          varchar(30)   NULL, entity_state         varchar(2)   NULL, entity_cntry         varchar(30)   NULL, entity_zip5          varchar(5)   NULL,  entity_zip4          varchar(5)   NULL,reserved1            varchar(20)   NULL, RESERVED2            VARCHAR(20)   NULL,    primary key (npdb_hdr_id,report_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_er   (     npdb_hdr_id  integer not null,report_id integer not null,    entity_ref           varchar(40)   NULL,    primary key (npdb_hdr_id,report_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_error( error_id  integer not null, user_id  varchar(20) not null, error  varchar(2000)   NULL, primary key (user_id, error_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_esln (     npdb_hdr_id  integer not null,report_id integer not null,  eslnnumber1          varchar(20)   NULL, eslnstate1           varchar(2)   NULL, eslnnumber2          varchar(20)   NULL, eslnstate2           varchar(2)   NULL, elsnnumber3          varchar(20)   NULL, eslnstate3           varchar(2)   NULL,  primary key (npdb_hdr_id,report_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_esubj(     npdb_hdr_id  integer not null,report_id integer not null, org_name             varchar(50)   NULL, org_addr1            varchar(50)   NULL,  org_addr2            varchar(50)   NULL, org_city             varchar(40)   NULL,  org_state            varchar(2)   NULL, org_cntry            varchar(30)   NULL, org_zip5             varchar(5)   NULL, org_zip4             varchar(4)   NULL,  org_type             varchar(10)   NULL, org_other_type       varchar(150)   NULL, org_defn  varchar(20)   NULL,   primary key (npdb_hdr_id,report_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_esuppl(    npdb_hdr_id  integer not null,report_id integer not null, org_name1            varchar(60)   NULL,  org_name2            varchar(60)   NULL,  org_name3            varchar(60)   NULL,  org_name4            varchar(60)   NULL,  org_name5            varchar(60)   NULL,  primary key (npdb_hdr_id,report_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_fda (      npdb_hdr_id  integer not null,report_id integer not null, number1              varchar(15)   NULL,  number2              varchar(15)   NULL,number3              varchar(15)   NULL, number4              varchar(15)   NULL,number5              varchar(15)   NULL, number6              varchar(15)   NULL, primary key (npdb_hdr_id,report_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_fein(      npdb_hdr_id  integer not null,report_id integer not null, fien1                varchar(10)   NULL,fien2                varchar(10)   NULL,fien3                varchar(10)   NULL, fien4                varchar(10)   NULL, primary key (npdb_hdr_id,report_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_fqsl ( npdb_hdr_id  integer not null,report_id integer not null,fqsl_nbr1  varchar(20)   NULL,fqsl_st1 varchar(2)   NULL,fqsl_fld1 varchar(10)   NULL, fqsl_other1 varchar(100)   NULL,fqsl_nbr2 varchar(20)   NULL,fqsl_st2 varchar(2)   NULL,fqsl_fld2 varchar(10)   NULL,fsql_other2 varchar(100)   NULL,fsql_nbr3 varchar(20)   NULL, fsql_st3 varchar(2)   NULL, fsql_fld3 varchar(10)   NULL,fqsl_other3 varchar(100)   NULL, fqsl_nbr4 varchar(20)   NULL,fqsl_st4 varchar(2)   NULL,fqsl_fld4 varchar(10)   NULL,fqsl_other4 varchar(100)   NULL,fqsl_nbr5 varchar(20)   NULL,fqsl_st5 varchar(2)   NULL,fqsl_fld5 varchar(10)   NULL,fqsl_other5 varchar(100)   NULL,fqsl_nbr6 varchar(20)   NULL,fqsl_st6 varchar(2)   NULL, fqsl_fld6 varchar(10)   NULL, fqsl_other6 varchar(100)   NULL, fqsl_nbr7 varchar(20)   NULL,fqsl_st7 varchar(2)   NULL, fqsl_fld7 varchar(10)   NULL,fqsl_other7 varchar(100)   NULL,fqsl_nbr8 varchar(20)   NULL,fqsl_st8 varchar(20)   NULL,fqsl_fld8 varchar(10)   NULL,fqsl_other8 varchar(100)   NULL,fqsl_nbr9 varchar(20)   NULL,fqsl_st9 varchar(2)   NULL,fqsl_fld9 varchar(10)   NULL, fqsl_other9 varchar(100)   NULL,fqsl_nbr10 varchar(20)   NULL,fqsl_st10 varchar(2)   NULL,fqsl_fld10 varchar(10)   NULL,fqsl_other10 varchar(100)   NULL, primary key (npdb_hdr_id,report_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_fsta(      npdb_hdr_id  integer not null,report_id integer not null,  file_trans_status    char(1)   NULL,query_batch_nbr      varchar(20)   NULL, npdb_fee_per_name    varchar(10)   NULL, npdb_nbr_billed      varchar(10)   NULL,hipdb_fee_per_name   varchar(10)   NULL, hipdb_nbr_billed     varchar(10)   NULL, referance_number     varchar(20)   NULL,  err_cd               varchar(10)   NULL,    primary key (npdb_hdr_id,report_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_grad (     npdb_hdr_id  integer not null,report_id integer not null,  school1              varchar(100)  NULL, grad_yr1             varchar(4)  NULL, school2              varchar(100)  NULL, grad_yr2             varchar(4)  NULL, school3              varchar(100)  NULL, grad_yr3             varchar(4)  NULL, school4              varchar(100)  NULL, grad_yr5             varchar(4)  NULL, primary key (npdb_hdr_id,report_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_hdr (      npdb_hdr_id  integer not null,report_id integer not null,  doc_id  varchar(20) not null, prac_id numeric(6) not null,  entity_dbid          varchar(20)  NULL,passwd               varchar(14)  NULL, trans_cd             varchar(2)  NULL,ver_num              varchar(4)  NULL, submission_filename  varchar(20)  NULL, submission_filedate  varchar(20)  NULL,agent_dbid           varchar(20)  NULL, user_id              varchar(20)  NULL, primary key (npdb_hdr_id, doc_id, prac_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_hosp (     npdb_hdr_id  integer not null,report_id integer not null, hosp_affil1          varchar(100)  NULL, hosp_affil_city_1    varchar(100)  NULL,hosp_affil_state_1   varchar(2)  NULL,hosp_affil2          varchar(100)  NULL,osp_affil_city_2    varchar(100)  NULL,hosp_affil_state_2   varchar(2)  NULL,hosp_affil3          varchar(100)  NULL,hosp_affil_city_3    varchar(100)  NULL,hosp_affil_state_3   varchar(2)  NULL,hosp_affil4          varchar(100)  NULL,hosp_affil_city_4    varchar(100)  NULL, hosp_affil_state_4   varchar(2)  NULL, hosp_affil5          varchar(100)  NULL,hosp_affil_city_5    varchar(100)  NULL,hosp_affil_state_5   varchar(2)  NULL, primary key (npdb_hdr_id,report_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_invtg(     npdb_hdr_id  integer not null,report_id integer not null, i_agency1            varchar(100)  NULL, a_case_number1       varchar(20)  NULL,i_agency2            varchar(100)  NULL, a_case_number2       varchar(20)  NULL,i_agency3            varchar(100)  NULL, a_case_number3       varchar(20)  NULL, i_agency4            varchar(100)  NULL, a_case_number4       varchar(20)  NULL,primary key (npdb_hdr_id,report_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_isofl(     npdb_hdr_id  integer not null,report_id integer not null, isofl_fld1           varchar(5)  NULL,  o_isofl_description  varchar(100)  NULL, isofl_nbr1           varchar(20)  NULL, isofl_st1            varchar(2)  NULL,specialty1           varchar(5)  NULL,   isofl_fld2           varchar(5)  NULL, o_isofl_description2 varchar(100)  NULL,    isofl_nbr2           varchar(20)  NULL, isofl_st2            varchar(2)  NULL,    specialty2           varchar(5)  NULL, isofl_fld3           varchar(5)  NULL,    o_isofl_description3 varchar(100)  NULL,isofl_nbr3           varchar(20)  NULL,isofl_st3            varchar(2)  NULL,specialty3  varchar(5)  NULL, isofl_fld4           varchar(5)  NULL,o_isofl_description4 varchar(100)  NULL,   isofl_nbr4           varchar(20)  NULL, isofl_st4            varchar(2)  NULL, specialty4           varchar(5)  NULL,     isofl_fld5           varchar(5)  NULL, o_isofl_description5 varchar(100)  NULL,isofl_nbr5           varchar(20)  NULL,isofl_st5            varchar(2)  NULL, specialty5           varchar(5)  NULL,isofl_fld6           varchar(5)  NULL, o_isofl_description6 varchar(100)  NULL,isofl_nbr6           varchar(20)  NULL,isofl_st6            varchar(2)  NULL,specialty6           varchar(5)  NULL,isofl_fld7           varchar(5)  NULL, o_isofl_description7 varchar(100)  NULL, isofl_nbr7           varchar(20)  NULL, isofl_st7            varchar(2)  NULL, specialty7           varchar(5)  NULL, isofl_fld8           varchar(5)  NULL,o_isofl_description8 varchar(100)  NULL,  isofl_nbr8           varchar(20)  NULL, isofl_st8            varchar(2)  NULL,specialty8           varchar(5)  NULL, isofl_fld9           varchar(5)  NULL,   o_isofl_description9 varchar(100)  NULL, isofl_nbr9           varchar(20)  NULL, isofl_st9            varchar(2)  NULL, specialty9           varchar(5)  NULL,isofl_fld10          varchar(5)  NULL, o_isofl_descripion10 varchar(100)  NULL,  isofl_nbr10          varchar(20)  NULL, isofl_st10           varchar(2)  NULL,  specialty10          varchar(5)  NULL, primary key (npdb_hdr_id  NULL,report_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_isubj (    npdb_hdr_id  integer not null,report_id integer not null,  lname                varchar(30)  NULL,  fname                varchar(30)  NULL,  mname                varchar(30)  NULL,  suffix               varchar(5)  NULL, gender               char(1)  NULL,  home_addr1           varchar(50)  NULL,  home_addr2           varchar(50)  NULL,  home_city            varchar(40)  NULL,  home_state           varchar(2)  NULL,  home_cntry           varchar(40)  NULL,  home_zip5            varchar(5)  NULL,  home_zip4            varchar(4)  NULL,  org_name             varchar(100)  NULL,  org_type             varchar(5)  NULL, org_type_desc        varchar(200)  NULL, work_addr1           varchar(50)  NULL,  work_addr2           varchar(50)  NULL, work_city            varchar(40)  NULL,  work_state           varchar(2)  NULL, work_cntry           varchar(40)  NULL, work_zip5            varchar(5)  NULL, work_zip4            varchar(4)  NULL, dob                  varchar(8)  NULL,    deceased             char(1)  NULL,    deceased_dt          varchar(8)  NULL,    primary key (npdb_hdr_id,report_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_isuppl (   npdb_hdr_id  integer not null,report_id integer not null, deceased_dt          varchar(8)  NULL,  lname1               varchar(30)  NULL, fname1               varchar(30)  NULL, mname1               varchar(30)  NULL, suffix1              varchar(5)  NULL, lname2               varchar(30)  NULL,fname2               varchar(30)  NULL,  mname2               varchar(30)  NULL,suffix2              varchar(5)  NULL,lname3               varchar(30)  NULL,fname3               varchar(30)  NULL, mname3               varchar(30)  NULL, suffix3              varchar(5)  NULL,lname4               varchar(30)  NULL, fname4               varchar(30)  NULL, mname4               varchar(30)  NULL, suffix4              varchar(5)  NULL,lname5               varchar(30)  NULL,fname5               varchar(30)  NULL, mname5               varchar(30)  NULL, suffix5              varchar(5)  NULL, primary key (npdb_hdr_id,report_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_jocr(      npdb_hdr_id  integer not null,report_id integer not null, rpt_dcn              varchar(20)  NULL, venue                varchar(100)  NULL,venue_type           varchar(5)  NULL, c_city               varchar(40)  NULL,c_state              varchar(2)  NULL, dc_file_number       varchar(20)  NULL, pagent_cplaintiff    varchar(100)  NULL, p_case_number        varchar(40)  NULL, type_of_action       varchar(5)  NULL, nar_desc             varchar(2000)  NULL,date_js              varchar(8)  NULL,primary key (npdb_hdr_id,report_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_jocrt(     npdb_hdr_id  integer not null,report_id integer not null, jocr_subject_type    char(1)  NULL, rpt_type             char(1)  NULL, orig_date            varchar(8)  NULL, rec_dt               varchar(8)  NULL, titleiv              char(1)  NULL,reserved             varchar(20)  NULL, jocrt_1128e          char(1)  NULL,npdb_fl              char(1)  NULL,hipdb_fl             char(1)  NULL, primary key (npdb_hdr_id,report_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_laart(     npdb_hdr_id  integer not null,report_id integer not null,rpt_type             char(1)  NULL,orig_dt              varchar(8)  NULL, rec_dt               varchar(8)  NULL, titleiv              char(1)  NULL, reserved             varchar(20)  NULL, laart_1128e          char(1)  NULL, npdb_fl              char(1)  NULL, hipdb_fl             char(1)  NULL, primary key (npdb_hdr_id,report_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_medicarep( npdb_hdr_id  integer not null,report_id integer not null,number1              varchar(20)  NULL,number2              varchar(20)  NULL, number3              varchar(20)  NULL, number4              varchar(20)  NULL,    primary key (npdb_hdr_id,report_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_mmpr(      npdb_hdr_id  integer not null,report_id integer not null,prev_dcn             varchar(20)  NULL,relationship_of_entity char(1)  NULL, amount_paid          varchar(15)  NULL, payment_date         varchar(8)  NULL,payment_type         char(1)  NULL,total_payment_amount varchar(20)  NULL,payment_result_of    char(1)  NULL, judgment_date        varchar(8)  NULL,adj_body_case_nbr    varchar(20)  NULL, adj_body_nm          varchar(100)  NULL, court_file_nbr       varchar(20)  NULL,desc_judgment_settlememt varchar(2000)  NULL, tot_amt_all_pract    varchar(20)  NULL, nbr_of_pract         varchar(5)  NULL, state_fund_paid      char(1)  NULL, amt_state_fund_paid  varchar(20)  NULL, self_insured_paid    char(1)  NULL,amt_self_insured_paid varchar(20)  NULL,patient_age_type     char(1)  NULL,patient_age          varchar(3)  NULL,patient_gender       char(1)  NULL, patient_type         char(1)  NULL,patient_condition    varchar(1000)  NULL,desc_procedure       varchar(1000)  NULL, nature_allegation    varchar(3)  NULL,specific_allegation1 varchar(3)  NULL,other_allegation_desc1 varchar(60)  NULL,date_event1          varchar(8)  NULL, specific_allegation2 varchar(3)  NULL, other_allegation_desc2 varchar(60)  NULL, date_event2 varchar(8)  NULL,outcome varchar(2)  NULL,rpt_dcn varchar(2000)  NULL, primary key (npdb_hdr_id,report_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_mmr(       npdb_hdr_id  integer not null,report_id integer not null,  primary key (npdb_hdr_id,report_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_mmrt(      npdb_hdr_id  integer not null,report_id integer not null, rpt_type             char(1)  NULL,orig_dt              varchar(20)  NULL,rec_dt               varchar(20)  NULL, titleiv              char(1)  NULL,reserved             varchar(20)  NULL, mmrt_1128e           char(1)  NULL, npdb_fl              char(1)  NULL, hipdb_fl             char(1)  NULL, primary key (npdb_hdr_id,report_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_npi(       npdb_hdr_id  integer not null,report_id integer not null,  npi1                 varchar(20)  NULL, npi2                 varchar(20)  NULL, npi3                 varchar(20)  NULL, npi4                 varchar(20)  NULL, primary key (npdb_hdr_id,report_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_oenam(     npdb_hdr_id  integer not null,report_id integer not null, org_name1            varchar(100)  NULL, org_name2            varchar(100)  NULL,org_name3            varchar(100)  NULL,org_name4            varchar(100)  NULL,org_name5            varchar(100)  NULL,primary key (npdb_hdr_id,report_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_pdcn(      npdb_hdr_id  integer not null,report_id integer not null,prev_dcn             varchar(20)  NULL,primary key (npdb_hdr_id,report_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_poo(       npdb_hdr_id  integer not null,report_id integer not null, lname1               varchar(30)  NULL,fname1               varchar(30)  NULL, mname1               varchar(30)  NULL,suffix1              varchar(5)  NULL,title1               varchar(50)  NULL, lname2               varchar(30)  NULL, fname2               varchar(30)  NULL, mname2               varchar(30)  NULL,suffix2              varchar(5)  NULL,title2               varchar(50)  NULL, lname3               varchar(30)  NULL, fname3               varchar(30)  NULL,  mname3               varchar(30)  NULL,suffix3              varchar(5)  NULL, title3               varchar(50)  NULL,lname4               varchar(30)  NULL, fname4               varchar(30)  NULL, mname4               varchar(30)  NULL, suffix4              varchar(5)  NULL,  title4               varchar(50)  NULL, lname5               varchar(30)  NULL, fname5               varchar(30)  NULL, mname5               varchar(30)  NULL, suffix5              varchar(5)  NULL,  title5               varchar(50)  NULL, primary key (npdb_hdr_id,report_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_qrsd(      npdb_hdr_id  integer not null,report_id integer not null,report_dcn_nbr       varchar(20)  NULL, report_dt            varchar(8)  NULL, report_type_cd       char(1)  NULL, primary key (npdb_hdr_id,report_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_qry(       npdb_hdr_id  integer not null,report_id integer not null, qry_purpose          char(1)  NULL,nbr_qry              varchar(5)  NULL, pymt_type            char(1)  NULL,credit_card_nbr      varchar(16)  NULL, cc_exp_dt            varchar(6)  NULL,cc_cardholder        varchar(150)  NULL,cc_billing_addr1     varchar(40)  NULL, cc_billing_addr2     varchar(40)  NULL, cc_billing_city      varchar(40)  NULL, cc_billing_state     varchar(2)  NULL, cc_billing_cntry     varchar(30)  NULL,cc_zip5              varchar(5)  NULL,cc_zip4              varchar(4)  NULL,primary key (npdb_hdr_id,report_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_qsta(      npdb_hdr_id  integer not null,report_id integer not null, query_dcn_nbr        varchar(20)  null,query_result_ind     char(1)  null,nbr_reports          varchar(4)  null, err_cd               varchar(4)  null,primary key (npdb_hdr_id,report_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_rpoc(      npdb_hdr_id  integer not null,report_id integer not null, name_office          varchar(50)  null, title_dept           varchar(50)  null, phone                varchar(10)  null, phone_ext            varchar(5)  null, primary key (npdb_hdr_id,report_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_rsdr(      npdb_hdr_id  integer not null,report_id integer not null,subject_stmt_dt      varchar(8)  null,subject_stmt_dt_status char(1)  null, subject_stmt         varchar(2000)  null, secretary_stmt_dt    varchar(8)  null, secretary_stmt_dt_status char(1)  null,secretary_stmt       varchar(2000)  null, dispute_fl           char(1)  null,primary key (npdb_hdr_id,report_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_sj(        npdb_hdr_id  integer not null,report_id integer not null, restitution_amount   varchar(20)  null, judgement_amount     varchar(20)  null, incarceration_years  varchar(2)  null,incarceration_mnths  varchar(2)  null,incarceration_days   varchar(3)  null, suspend_sent_years   varchar(2)  null,suspend_sent_mnths   varchar(2)  null, suspend_sent_days    varchar(3)  null, home_deten_years     varchar(2)  null,home_deten_mnths     varchar(2)  null, home_deten_days      varchar(3)  null,probation_years      varchar(2)  null, probation_mnths      varchar(2)  null, probation_days       varchar(3)  null,comm_service_hours   varchar(5)  null, other                varchar(200)  null, primary key (npdb_hdr_id,report_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_ssn(       npdb_hdr_id  integer not null,report_id integer not null,ssn1                 varchar(9)  null, ssn2                 varchar(9)  null, ssn3                 varchar(9)  null, ssn4                 varchar(9)  null,  primary key (npdb_hdr_id,report_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_statoc  (    npdb_hdr_id  integer not null,report_id integer not null, violat1              varchar(100)  null, offense1             varchar(100)  null, count1               varchar(3)  null, violat2              varchar(100)  null, offense2             varchar(100)  null,  count2               varchar(3)  null, violat3              varchar(100)  null, offense3             varchar(100)  null,  count3               varchar(3)  null, violat4              varchar(100)  null,  offense4             varchar(100)  null,  count4               varchar(3)  null, violat5              varchar(100)  null, offense5             varchar(100)  null, count5               varchar(3)  null, primary key (npdb_hdr_id,report_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_supplsnd(  npdb_hdr_id  integer not null,report_id integer not null, notify_dt            varchar(8)  null, addr1                varchar(50)  null,addr2                varchar(50)  null, city                 varchar(30)  null,state                varchar(2)  null,cntry                varchar(30)  null, zip5                 varchar(5)  null, zip4                 varchar(4)  null, primary key (npdb_hdr_id,report_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_upin (npdb_hdr_id  integer not null,report_id integer not null, upin1                varchar(10)  null, upin2                varchar(10)  null, upin3                varchar(10)  null,  upin4                varchar(10)  null, primary key (npdb_hdr_id,report_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_prct ( npdb_hdr_id integer not null,report_id integer not null ,lname varchar(30)  null,fname varchar(30)  null,mname varchar(30)  null,suffix varchar(30)  null,olname varchar(30)  null,ofname varchar(30)  null,omname  varchar(30)  null,osuffix varchar(30)  null, gender char(1)  null, org_name varchar(50)  null,work_addr1 varchar(40)  null,work_addr2 varchar(40)  null,work_city varchar(28)  null, work_state varchar(2)  null,work_cntry varchar(20)  null,work_zip5 varchar(5)  null,work_zip4 varchar(4)  null,home_addr1 varchar(40)  null,home_addr2 varchar(40)  null,home_city varchar(20)  null, home_state varchar(2)  null, home_cntry varchar(20)  null, home_zip5 varchar(5)  null,home_zip4 varchar(4)  null, dob varchar(8)  null, ssn varchar(20)  null, primary key (npdb_hdr_id,report_id) )"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_itin ( npdb_hdr_id          integer                        not null default NULL,    itin1                varchar(20)   null                 default NULL,    itin2                varchar(20)   null                 default NULL,    itin3                varchar(20)    null                default NULL,    itin4      null           varchar(20)                    default NULL,    primary key (npdb_hdr_id)) " 

// add foreign keys

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_agnt   add foreign key FK_NPDB_AGN_REFERENCE_NPDB_HDR (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_aar   add foreign key FK_NPDB_AAR_REFERENCE_NPDB_HDR2 ()      references npdb_hdr ()      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_qsta   add foreign key FK_NPDB_QST_REFERENCE_NPDB_HDR (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_fda   add foreign key FK_NPDB_FDA_REFERENCE_NPDB_HDR (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_statoc   add foreign key FK_NPDB_STA_REFERENCE_NPDB_HDR (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_mmr   add foreign key FK_NPDB_MMR_REFERENCE_NPDB_HDR2 (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_poo   add foreign key FK_NPDB_POO_REFERENCE_NPDB_HDR (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_enty   add foreign key FK_NPDB_ENT_REFERENCE_NPDB_HDR (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_rsdr   add foreign key FK_NPDB_RSD_REFERENCE_NPDB_HDR (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_invtg   add foreign key FK_NPDB_INV_REFERENCE_NPDB_HDR (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_sj   add foreign key FK_NPDB_SJ_REFERENCE_NPDB_HDR (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_cert   add foreign key FK_NPDB_CER_REFERENCE_NPDB_HDR (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_itin   add foreign key FK_NPDB_ITI_REFERENCE_NPDB_HDR (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_esubj   add foreign key FK_NPDB_ESU_REFERENCE_NPDB_HDR2 (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_alias   add foreign key FK_NPDB_ALI_REFERENCE_NPDB_HDR (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_qrsd   add foreign key FK_NPDB_QRS_REFERENCE_NPDB_HDR (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_apeal   add foreign key FK_NPDB_APE_REFERENCE_NPDB_HDR (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_fqsl   add foreign key FK_NPDB_FQS_REFERENCE_NPDB_HDR (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_medicarep   add foreign key FK_NPDB_MED_REFERENCE_NPDB_HDR (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_dea   add foreign key FK_NPDB_DEA_REFERENCE_NPDB_HDR (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_aart   add foreign key FK_NPDB_AAR_REFERENCE_NPDB_HDR (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_fsta   add foreign key FK_NPDB_FST_REFERENCE_NPDB_HDR (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_supplsnd   add foreign key FK_NPDB_SUP_REFERENCE_NPDB_HDR (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_hosp   add foreign key FK_NPDB_HOS_REFERENCE_NPDB_HDR (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_laart   add foreign key FK_NPDB_LAA_REFERENCE_NPDB_HDR (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_qry   add foreign key FK_NPDB_QRY_REFERENCE_NPDB_HDR (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_bactn   add foreign key FK_NPDB_BAC_REFERENCE_NPDB_HDR (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_oenam   add foreign key FK_NPDB_OEN_REFERENCE_NPDB_HDR (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_clia   add foreign key FK_NPDB_CLI_REFERENCE_NPDB_HDR (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_caar   add foreign key FK_NPDB_CAA_REFERENCE_NPDB_HDR (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_prct   add foreign key FK_NPDB_PRC_REFERENCE_NPDB_HDR (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_pdcn   add foreign key FK_NPDB_PDC_REFERENCE_NPDB_HDR (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_mmrt   add foreign key FK_NPDB_MMR_REFERENCE_NPDB_HDR (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_npi   add foreign key FK_NPDB_NPI_REFERENCE_NPDB_HDR (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_grad   add foreign key FK_NPDB_GRA_REFERENCE_NPDB_HDR (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_upin   add foreign key FK_NPDB_UPI_REFERENCE_NPDB_HDR (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_esln   add foreign key FK_NPDB_ESL_REFERENCE_NPDB_HDR (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_jocr   add foreign key FK_NPDB_JOC_REFERENCE_NPDB_HDR2 (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_rpoc   add foreign key FK_NPDB_RPO_REFERENCE_NPDB_HDR (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_jocrt   add foreign key FK_NPDB_JOC_REFERENCE_NPDB_HDR3 (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_jocrt   add foreign key FK_NPDB_JOC_REFERENCE_NPDB_HDR (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_isubj   add foreign key FK_NPDB_ISU_REFERENCE_NPDB_HDR2 (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_aocd   add foreign key FK_NPDB_AOC_REFERENCE_NPDB_HDR (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_er   add foreign key FK_NPDB_ER_REFERENCE_NPDB_HDR (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_fein   add foreign key FK_NPDB_FEI_REFERENCE_NPDB_HDR (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_cuse   add foreign key FK_NPDB_CUS_REFERENCE_NPDB_HDR ()      references npdb_hdr ()      on update restrict      on delete restrict " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_mmpr   add foreign key FK_NPDB_MMP_REFERENCE_NPDB_HDR (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_aff   add foreign key FK_NPDB_AFF_REFERENCE_NPDB_HDR (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_isofl   add foreign key FK_NPDB_ISO_REFERENCE_NPDB_HDR (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_esuppl   add foreign key FK_NPDB_ESU_REFERENCE_NPDB_HDR (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_isuppl   add foreign key FK_NPDB_ISU_REFERENCE_NPDB_HDR (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete cascade " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_ssn   add foreign key FK_NPDB_SSN_REFERENCE_NPDB_HDR (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete cascade " 




// table comments
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_ssn is 'Social Security Number Data Record (SSN)';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_sj is 'Sentence/Judgment Data Record (SJ)';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_medicarep is 'Medicare Provider/Supplier Number Data Record (MEDICAREP)';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_laart is 'Legacy Format Adverse Action Report Type Data Record (LAART)';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_laart is 'Legacy Format Adverse Action Report Type Data Record (LAART)';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_jocrt is 'Judgment or Conviction Report Type Data Record (JOCRT)';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_isubj is 'Individual Subject Data Record (ISUBJ)';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_isofl is 'Individual Subject Occupation/Field(s) of Licensure Data Record (ISOFL)';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_invtg is 'Investigating Agencies Data Record (INVTG)';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_hosp is 'Hospital Data Record (HOSP)';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_grad is 'Professional School Data Record (GRAD)';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_fsta is 'Query File Status Data Record (FSTA)';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_fsta is 'Query File Status Data Record (FSTA)';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_fqsl is 'Fully Qualified State License Data Record (FQSL)';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_fein is 'Federal Employer Identification Number Data Record (FEIN)';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_fda is 'Food and Drug Administration Number Data Record (FDA)';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_esuppl is 'Organization Supplemental Information Data Record (ESUPPL)';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_esubj is 'Organization Subject Data Record (ESUBJ)';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_esln is 'Organization Subject State License Number Data Record (ESLN)';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_enty is 'Entity Data Record (ENTY)';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_dea is 'Drug Enforcement Administration Data Record (DEA)';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_cuse is 'Customer Use Data Record (CUSE)';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_control is 'Table used to maintain information about the datawindows used in the NPDB. Including the order';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_clia is 'Clinical Laboratory Improvement Act Data Record (CLIA)';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_cert is 'Certification Data Record (CERT)';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_caar is 'Adverse Action Report Data Record (CAAR)';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_bactn is 'Basis for Action Data Record (BACTN)';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_apeal is 'This tabel maintains data related to the APEAL Data Record';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_aocd is 'Judgment or Conviction Report Act(s) or Omission(s) Data Record (AOCD)';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_agnt is 'Agent Data Record';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_aff is 'Affiliations Data Record';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_aart is 'Adverse Action Report Type Record (AART)';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_ssn is 'Social Security Number Data Record (SSN)';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_rsdr is 'Report Statement Data Record (RSDR)';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_rpoc is 'Report Point of Contact Data Record (RPOC)';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_qsta is 'Query Status Data Record (QSTA)';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_qry is 'Query Data Record (QRY)';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_qrsd is 'Query Report Status Data Record (QRSD)';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_poo is 'Principal Officers and Owners Data Record (POO)';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_pdcn is 'Previous DCN Data Record (PDCN)';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_oenam is 'Other Organization Name(s) Used Data Record (OENAM)';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_npi is 'National Provider Identifier Data Record (NPI)';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_mmpr is 'Medical Malpractice Payment Report Data Record (MMPR)'; "
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_jocr is ' Judgment or Conviction Report Data Record (JOCR)';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_error is 'Error log table';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_code_lookup is 'This table is used to maintain code lool up values for the NPDB. NOTE: This table is not referanced via RF. This is so that the data will be added into the DB no matter what.';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_statoc is 'Statutory Offenses and Counts Data Record (STATOC)';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_supplsnd is 'Subject Notification Failure Supplemental Information Data Record (SUPPLSND)';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_isuppl is 'Individual Supplemental Information Data Record (ISUPPL)';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table npdb_er is 'Entity Internal Report Reference Data Record (ER)';"

// pfc message table
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table messages (msgid   varchar(40)            not null, msgtitle                        varchar(255)           not null,msgtext                         varchar(255)           not null,msgicon                         varchar(12)            not null, msgbutton                       varchar(17)            not null, msgdefaultbutton                int                    not null, msgseverity                     int                    not null, msgprint                        char(1)                not null,msguserinput                    char(1)                not null, constraint pk_messages primary key nonclustered (msgid))"
// qa_profile tables
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table PD_QA_HDR (PD_QA_HDR_ID   numeric(12,2) not null, QA_PROFILE_ID integer  null, PRAC_ID  numeric(10,0) not null, FROM_DATE            timestamp  null, TO_DATE              timestamp  null, ACTIVE_STATUS        integer  null              default 1,FACILITY_ID integer  null, HDR_COMMENT varchar(255)  null, REASON integer not null,primary key (PD_QA_HDR_ID));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table PD_QA_HDR is 'Prectintioner Measurements Header';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table PD_QA_MEASUREMENTS(PD_QA_MEASUREMENTS_ID integer not null,PD_QA_HDR_ID   numeric(12,2) not null, PROFILE_GROUP_MEASUREMENT_ID integer not null,  MEASUREMENT_VALUE    numeric(10,2)  null, primary key (PD_QA_MEASUREMENTS_ID));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table PD_QA_MEASUREMENTS is 'Prectintioner Measurements';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table QA_MEASUREMENT(PROFILE_GROUP_MEASUREMENT_ID integer  not null, QA_PROFILE_ID integer not null,  QA_PROFILE_GROUP_ID  integer  not null,PD_QA_HDR_ID numeric(12,2)  null, THRESHOLD numeric(6,2)  null, INCLUDE_IN_PROFILE   integer  null,DATA_FORMAT          integer not null,QA_MEASUREMENT_NAME  varchar(100)not null, primary key (PROFILE_GROUP_MEASUREMENT_ID, QA_PROFILE_ID, QA_PROFILE_GROUP_ID) );"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table QA_PD_REVIEW_ACTION_ITEMS (PD_PEER_REVIEW_ACTION_ITEMS_ID numeric(10) not null,PD_QA_HDR_ID numeric(12,2) not null, ACTION_TYPE          numeric(10)  null,ACTION_TO            numeric(10)  null,ACTION_DATE          date  null, ACTION_USER          varchar(15)  null,ACTIVE_STATUS        INTEGER  null,DATE_COMPLETED       DATE  null, ACTION_STATUS        numeric(10)  null,ID                   numeric(10)  null,ACTION_TO_NAME       varchar(100)  null, NOTES                long varchar  null,PRAC_ID numeric(10,0)  not null, primary key (PD_PEER_REVIEW_ACTION_ITEMS_ID) );"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table QA_PROFILE(QA_PROFILE_ID integer not null, FACILITY_ID integer  null,PROFILE_NAME varchar(100) not null,SPECIALTY_ID numeric(8,0) not null, primary key (QA_PROFILE_ID) );"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "comment on table QA_PROFILE is 'qa_profile';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table QA_PROFILE_GROUP(QA_PROFILE_GROUP_ID  integer not null,QA_PROFILE_ID integer  null,QA_PROFILE_GROUP_NAME varchar(100) not null,primary key (QA_PROFILE_GROUP_ID));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table QA_PROFILE_GROUP add foreign key FK_QA_PROFILE_REF_573_QA_PROFILE_GROUP (QA_PROFILE_ID) references QA_PROFILE (QA_PROFILE_ID) on update restrict on delete cascade;"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table QA_PD_REVIEW_ACTION_ITEMS add foreign key FK_QA_PD_RE_REF_810_PD_QA_HD (PD_QA_HDR_ID) references PD_QA_HDR (PD_QA_HDR_ID) on update restrict on delete cascade;"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table PD_QA_MEASUREMENTS add foreign key FK_PD_QA_MEASURMENTS_REF_820_PD_QA_HDR (PD_QA_HDR_ID) references PD_QA_HDR (PD_QA_HDR_ID) on update restrict on delete cascade;"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table QA_MEASUREMENT add foreign key FK_QA_MEASUREMENT_REF_830_QA_PROFILE (QA_PROFILE_ID) references QA_PROFILE (QA_PROFILE_ID) on update restrict on delete cascade;"
// trigger
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create trigger npdb_before_ins         before insert order 1 on npdb_error referencing new as new_ins for each row begin	set new_ins.error_id = (IsNull((select Max(error_ID) from npdb_error),0)+1 ) end"


return 1
end function

private function integer of_display_error ();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : of_display_error
//==================================================================================================================
//  Purpose   	: display a message to the user or set a record into the database
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael Skinner  
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

long   ll_i
string ls_err_message

if upperbound(is_err_mess) < 1 then return 1

for ll_i = 1 to upperbound(is_err_mess )
	ls_err_message = ls_err_message +  is_err_mess[ll_i] + new_line
next

if upper(is_internet_inuse) =  "N" then
	// display a messagebox
	//messagebox('ITP Interface Message', ls_err_message )
	if not gb_AutoSchedule and not ib_schedule then //Added by Nova 01.28.2010 - v10.1 Scheduler Functionality
		openwithparm(w_npdb_error,ls_err_message )   //Start Code Change ----03.24.2015 #V15 maha - changed from w_sql_msg
   else
		inv_message.of_messagebox("Error message from NPDB", ls_err_message,true)
   end if
else
	//update  the database1
	ll_i = ids_error.insertrow(0)
	ids_error.object.user_id[ll_i]  =  gs_user_id
	ids_error.object.error[ll_i]    =  ls_err_message
	 if gb_AutoSchedule or ib_schedule then
		inv_message.of_messagebox("Error message from NPDB", ls_err_message,true)		
	 end if
end if  

//IS_STATUS_CODE

ids_error.UPDATE()

return 1
end function

private subroutine of_drop_tables ();
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2005-11-11 By: owen chen
//$<reason> add database option for sql excution
choose case gs_dbtype
	case 'ASA'
		
		   ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_AGN_REFERENCE_NPDB_HDR') then    alter table npdb_agnt       delete foreign key FK_NPDB_AGN_REFERENCE_NPDB_HDR end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_AAR_REFERENCE_NPDB_HDR2') then    alter table npdb_aar       delete foreign key FK_NPDB_AAR_REFERENCE_NPDB_HDR2 end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_QST_REFERENCE_NPDB_HDR') then    alter table npdb_qsta       delete foreign key FK_NPDB_QST_REFERENCE_NPDB_HDR end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_FDA_REFERENCE_NPDB_HDR') then    alter table npdb_fda       delete foreign key FK_NPDB_FDA_REFERENCE_NPDB_HDR end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_STA_REFERENCE_NPDB_HDR') then    alter table npdb_statoc       delete foreign key FK_NPDB_STA_REFERENCE_NPDB_HDR end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_MMR_REFERENCE_NPDB_HDR2') then    alter table npdb_mmr       delete foreign key FK_NPDB_MMR_REFERENCE_NPDB_HDR2 end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_POO_REFERENCE_NPDB_HDR') then    alter table npdb_poo       delete foreign key FK_NPDB_POO_REFERENCE_NPDB_HDR end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_ENT_REFERENCE_NPDB_HDR') then    alter table npdb_enty       delete foreign key FK_NPDB_ENT_REFERENCE_NPDB_HDR end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_RSD_REFERENCE_NPDB_HDR') then    alter table npdb_rsdr       delete foreign key FK_NPDB_RSD_REFERENCE_NPDB_HDR end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_INV_REFERENCE_NPDB_HDR') then    alter table npdb_invtg       delete foreign key FK_NPDB_INV_REFERENCE_NPDB_HDR end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_SJ_REFERENCE_NPDB_HDR') then    alter table npdb_sj       delete foreign key FK_NPDB_SJ_REFERENCE_NPDB_HDR end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_CER_REFERENCE_NPDB_HDR') then    alter table npdb_cert       delete foreign key FK_NPDB_CER_REFERENCE_NPDB_HDR end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_ITI_REFERENCE_NPDB_HDR') then    alter table npdb_itin       delete foreign key FK_NPDB_ITI_REFERENCE_NPDB_HDR end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_ESU_REFERENCE_NPDB_HDR2') then    alter table npdb_esubj       delete foreign key FK_NPDB_ESU_REFERENCE_NPDB_HDR2 end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_ALI_REFERENCE_NPDB_HDR') then    alter table npdb_alias       delete foreign key FK_NPDB_ALI_REFERENCE_NPDB_HDR end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_QRS_REFERENCE_NPDB_HDR') then    alter table npdb_qrsd       delete foreign key FK_NPDB_QRS_REFERENCE_NPDB_HDR end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_APE_REFERENCE_NPDB_HDR') then    alter table npdb_apeal       delete foreign key FK_NPDB_APE_REFERENCE_NPDB_HDR end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_FQS_REFERENCE_NPDB_HDR') then    alter table npdb_fqsl       delete foreign key FK_NPDB_FQS_REFERENCE_NPDB_HDR end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_MED_REFERENCE_NPDB_HDR') then    alter table npdb_medicarep       delete foreign key FK_NPDB_MED_REFERENCE_NPDB_HDR end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_DEA_REFERENCE_NPDB_HDR') then    alter table npdb_dea       delete foreign key FK_NPDB_DEA_REFERENCE_NPDB_HDR end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_AAR_REFERENCE_NPDB_HDR') then    alter table npdb_aart       delete foreign key FK_NPDB_AAR_REFERENCE_NPDB_HDR end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_FST_REFERENCE_NPDB_HDR') then    alter table npdb_fsta       delete foreign key FK_NPDB_FST_REFERENCE_NPDB_HDR end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_SUP_REFERENCE_NPDB_HDR') then    alter table npdb_supplsnd       delete foreign key FK_NPDB_SUP_REFERENCE_NPDB_HDR end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_HOS_REFERENCE_NPDB_HDR') then    alter table npdb_hosp       delete foreign key FK_NPDB_HOS_REFERENCE_NPDB_HDR end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_LAA_REFERENCE_NPDB_HDR') then    alter table npdb_laart       delete foreign key FK_NPDB_LAA_REFERENCE_NPDB_HDR end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_QRY_REFERENCE_NPDB_HDR') then    alter table npdb_qry       delete foreign key FK_NPDB_QRY_REFERENCE_NPDB_HDR end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_BAC_REFERENCE_NPDB_HDR') then    alter table npdb_bactn       delete foreign key FK_NPDB_BAC_REFERENCE_NPDB_HDR end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_OEN_REFERENCE_NPDB_HDR') then    alter table npdb_oenam       delete foreign key FK_NPDB_OEN_REFERENCE_NPDB_HDR end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_CLI_REFERENCE_NPDB_HDR') then    alter table npdb_clia       delete foreign key FK_NPDB_CLI_REFERENCE_NPDB_HDR end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_CAA_REFERENCE_NPDB_HDR') then    alter table npdb_caar       delete foreign key FK_NPDB_CAA_REFERENCE_NPDB_HDR end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_PRC_REFERENCE_NPDB_HDR') then    alter table npdb_prct       delete foreign key FK_NPDB_PRC_REFERENCE_NPDB_HDR end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_PDC_REFERENCE_NPDB_HDR') then    alter table npdb_pdcn       delete foreign key FK_NPDB_PDC_REFERENCE_NPDB_HDR end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_MMR_REFERENCE_NPDB_HDR') then    alter table npdb_mmrt       delete foreign key FK_NPDB_MMR_REFERENCE_NPDB_HDR end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_NPI_REFERENCE_NPDB_HDR') then    alter table npdb_npi       delete foreign key FK_NPDB_NPI_REFERENCE_NPDB_HDR end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_GRA_REFERENCE_NPDB_HDR') then    alter table npdb_grad       delete foreign key FK_NPDB_GRA_REFERENCE_NPDB_HDR end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_UPI_REFERENCE_NPDB_HDR') then    alter table npdb_upin       delete foreign key FK_NPDB_UPI_REFERENCE_NPDB_HDR end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_ESL_REFERENCE_NPDB_HDR') then    alter table npdb_esln       delete foreign key FK_NPDB_ESL_REFERENCE_NPDB_HDR end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_JOC_REFERENCE_NPDB_HDR2') then    alter table npdb_jocr       delete foreign key FK_NPDB_JOC_REFERENCE_NPDB_HDR2 end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_RPO_REFERENCE_NPDB_HDR') then    alter table npdb_rpoc       delete foreign key FK_NPDB_RPO_REFERENCE_NPDB_HDR end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_JOC_REFERENCE_NPDB_HDR3') then    alter table npdb_jocrt       delete foreign key FK_NPDB_JOC_REFERENCE_NPDB_HDR3 end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_JOC_REFERENCE_NPDB_HDR') then    alter table npdb_jocrt       delete foreign key FK_NPDB_JOC_REFERENCE_NPDB_HDR end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_ISU_REFERENCE_NPDB_HDR2') then    alter table npdb_isubj       delete foreign key FK_NPDB_ISU_REFERENCE_NPDB_HDR2 end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_AOC_REFERENCE_NPDB_HDR') then    alter table npdb_aocd       delete foreign key FK_NPDB_AOC_REFERENCE_NPDB_HDR end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_ER_REFERENCE_NPDB_HDR') then    alter table npdb_er       delete foreign key FK_NPDB_ER_REFERENCE_NPDB_HDR end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_FEI_REFERENCE_NPDB_HDR') then    alter table npdb_fein       delete foreign key FK_NPDB_FEI_REFERENCE_NPDB_HDR end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_CUS_REFERENCE_NPDB_HDR') then    alter table npdb_cuse       delete foreign key FK_NPDB_CUS_REFERENCE_NPDB_HDR end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_MMP_REFERENCE_NPDB_HDR') then    alter table npdb_mmpr       delete foreign key FK_NPDB_MMP_REFERENCE_NPDB_HDR end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_AFF_REFERENCE_NPDB_HDR') then    alter table npdb_aff       delete foreign key FK_NPDB_AFF_REFERENCE_NPDB_HDR end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_ISO_REFERENCE_NPDB_HDR') then    alter table npdb_isofl       delete foreign key FK_NPDB_ISO_REFERENCE_NPDB_HDR end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_ESU_REFERENCE_NPDB_HDR') then    alter table npdb_esuppl       delete foreign key FK_NPDB_ESU_REFERENCE_NPDB_HDR end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_ISU_REFERENCE_NPDB_HDR') then    alter table npdb_isuppl       delete foreign key FK_NPDB_ISU_REFERENCE_NPDB_HDR end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_SSN_REFERENCE_NPDB_HDR') then    alter table npdb_ssn       delete foreign key FK_NPDB_SSN_REFERENCE_NPDB_HDR end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_aar' and table_type='BASE') then    drop table npdb_aar end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_aart' and table_type='BASE') then    drop table npdb_aart end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_aff' and table_type='BASE') then    drop table npdb_aff end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_agnt' and table_type='BASE') then    drop table npdb_agnt end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_alias' and table_type='BASE') then    drop table npdb_alias end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_aocd' and table_type='BASE') then    drop table npdb_aocd end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_apeal' and table_type='BASE') then    drop table npdb_apeal end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_bactn' and table_type='BASE') then    drop table npdb_bactn end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_caar' and table_type='BASE') then    drop table npdb_caar end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_cert' and table_type='BASE') then    drop table npdb_cert end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_clia' and table_type='BASE') then    drop table npdb_clia end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_code_lookup' and table_type='BASE') then    drop table npdb_code_lookup end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_control' and table_type='BASE') then    drop table npdb_control end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_cuse' and table_type='BASE') then    drop table npdb_cuse end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_data_columns' and table_type='BASE') then    drop table npdb_data_columns end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_dea' and table_type='BASE') then    drop table npdb_dea end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_enty' and table_type='BASE') then    drop table npdb_enty end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_er' and table_type='BASE') then    drop table npdb_er end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_error' and table_type='BASE') then    drop table npdb_error end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_esln' and table_type='BASE') then    drop table npdb_esln end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_esubj' and table_type='BASE') then    drop table npdb_esubj end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_esuppl' and table_type='BASE') then    drop table npdb_esuppl end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_fda' and table_type='BASE') then    drop table npdb_fda end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_fein' and table_type='BASE') then    drop table npdb_fein end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_fqsl' and table_type='BASE') then    drop table npdb_fqsl end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_fsta' and table_type='BASE') then    drop table npdb_fsta end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_grad' and table_type='BASE') then    drop table npdb_grad end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_hdr' and table_type='BASE') then    drop table npdb_hdr end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_hosp' and table_type='BASE') then    drop table npdb_hosp end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_invtg' and table_type='BASE') then    drop table npdb_invtg end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_isofl' and table_type='BASE') then    drop table npdb_isofl end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_isubj' and table_type='BASE') then    drop table npdb_isubj end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_isuppl' and table_type='BASE') then    drop table npdb_isuppl end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_itin' and table_type='BASE') then    drop table npdb_itin end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_jocr' and table_type='BASE') then    drop table npdb_jocr end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_jocrt' and table_type='BASE') then    drop table npdb_jocrt end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_laart' and table_type='BASE') then    drop table npdb_laart end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_medicarep' and table_type='BASE') then    drop table npdb_medicarep end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_mmpr' and table_type='BASE') then    drop table npdb_mmpr end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_mmr' and table_type='BASE') then    drop table npdb_mmr end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_mmrt' and table_type='BASE') then    drop table npdb_mmrt end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_npi' and table_type='BASE') then    drop table npdb_npi end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_oenam' and table_type='BASE') then    drop table npdb_oenam end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_pdcn' and table_type='BASE') then    drop table npdb_pdcn end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_poo' and table_type='BASE') then    drop table npdb_poo end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_prct' and table_type='BASE') then    drop table npdb_prct end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_qrsd' and table_type='BASE') then    drop table npdb_qrsd end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_qry' and table_type='BASE') then    drop table npdb_qry end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_qsta' and table_type='BASE') then    drop table npdb_qsta end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_rpoc' and table_type='BASE') then    drop table npdb_rpoc end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_rsdr' and table_type='BASE') then    drop table npdb_rsdr end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_sj' and table_type='BASE') then    drop table npdb_sj end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_ssn' and table_type='BASE') then    drop table npdb_ssn end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_statoc' and table_type='BASE') then    drop table npdb_statoc end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_supplsnd' and table_type='BASE') then    drop table npdb_supplsnd end if  " 
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.systable where table_name='npdb_upin' and table_type='BASE') then    drop table npdb_upin end if  " 

			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_aar' and table_type='BASE') then drop table npdb_aar end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_aart' and table_type='BASE') then drop table npdb_aart end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_aff' and table_type='BASE') then drop table npdb_aff end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_agnt' and table_type='BASE') then drop table npdb_agnt end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_alias' and table_type='BASE') then drop table npdb_alias end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_aocd' and table_type='BASE') then drop table npdb_aocd end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_apeal' and table_type='BASE') then drop table npdb_apeal end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_bactn' and table_type='BASE') then drop table npdb_bactn end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_caar' and table_type='BASE') then  drop table npdb_caar end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_cert' and table_type='BASE') then drop table npdb_cert end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_clia' and table_type='BASE') then drop table npdb_clia end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_code_lookup' and table_type='BASE') then drop table npdb_code_lookup end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_control' and table_type='BASE') then drop table npdb_control end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_cuse' and table_type='BASE') then drop table npdb_cuse end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_data_columns' and table_type='BASE') then drop table npdb_data_columns end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_dea' and table_type='BASE') then drop table npdb_dea end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_enty' and table_type='BASE') then drop table npdb_enty end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_er' and table_type='BASE') then drop table npdb_er end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_error' and table_type='BASE') then drop table npdb_error end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_esln' and table_type='BASE') then drop table npdb_esln end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_esubj' and table_type='BASE') then drop table npdb_esubj end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_esuppl' and table_type='BASE') then drop table npdb_esuppl end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_fda' and table_type='BASE') then drop table npdb_fda end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_fein' and table_type='BASE') then drop table npdb_fein end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_fqsl' and table_type='BASE') then drop table npdb_fqsl end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_fsta' and table_type='BASE') then drop table npdb_fsta end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_grad' and table_type='BASE') then drop table npdb_grad end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_hdr' and table_type='BASE') then drop table npdb_hdr end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_hosp' and table_type='BASE') then drop table npdb_hosp end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_invtg' and table_type='BASE') then drop table npdb_invtg end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_isofl' and table_type='BASE') then drop table npdb_isofl end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_isubj' and table_type='BASE') then drop table npdb_isubj end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_isuppl' and table_type='BASE') then drop table npdb_isuppl end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_jocr' and table_type='BASE') then drop table npdb_jocr end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_jocrt' and table_type='BASE') then drop table npdb_jocrt end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_laart' and table_type='BASE') then drop table npdb_laart end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_medicarep' and table_type='BASE') then drop table npdb_medicarep end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_mmpr' and table_type='BASE') then drop table npdb_mmpr end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_mmr' and table_type='BASE') then drop table npdb_mmr end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_mmrt' and table_type='BASE') then drop table npdb_mmrt end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_npi' and table_type='BASE') then drop table npdb_npi end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_oenam' and table_type='BASE') then drop table npdb_oenam end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_pdcn' and table_type='BASE') then drop table npdb_pdcn end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_poo' and table_type='BASE') then drop table npdb_poo end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_qrsd' and table_type='BASE') then drop table npdb_qrsd end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_qry' and table_type='BASE') then drop table npdb_qry end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_qsta' and table_type='BASE') then drop table npdb_qsta end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_rpoc' and table_type='BASE') then drop table npdb_rpoc end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_rsdr' and table_type='BASE') then drop table npdb_rsdr end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_sj' and table_type='BASE') then drop table npdb_sj end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_ssn' and table_type='BASE') then drop table npdb_ssn end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_statoc' and table_type='BASE') then drop table npdb_statoc end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_supplsnd' and table_type='BASE') then drop table npdb_supplsnd end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='npdb_upin' and table_type='BASE') then drop table npdb_upin end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] ="if exists(select 1 from systable where table_name='npdb_prct' and table_type='BASE') then drop table npdb_prct end if"
			
			// pfc_messages
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='messages' and table_type='BASE') then drop table messages end if;"
			// qa_profile
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='PD_QA_HDR' and table_type='BASE') then drop table PD_QA_HDR end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='PD_QA_MEASUREMENTS' and table_type='BASE') then drop table PD_QA_MEASUREMENTS end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='QA_MEASUREMENT' and table_type='BASE') then drop table QA_MEASUREMENT end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='QA_PD_REVIEW_ACTION_ITEMS' and table_type='BASE') then drop table QA_PD_REVIEW_ACTION_ITEMS end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='QA_PROFILE' and table_type='BASE') then drop table QA_PROFILE end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='QA_PROFILE_GROUP' and table_type='BASE') then drop table QA_PROFILE_GROUP end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='QA_PD_REVIEW_ACTION_ITEMS' and table_type='BASE') then drop table QA_PD_REVIEW_ACTION_ITEMS end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='PD_QA_MEASUREMENTS' and table_type='BASE') then drop table PD_QA_MEASUREMENTS end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from systable where table_name='QA_MEASUREMENT' and table_type='BASE') then drop table QA_MEASUREMENT end if;"
		  ls_sql_statments[upperbound(ls_sql_statments) + 1]    = "if exists(select 1 from sys.systable where table_name='npdb_itin' and table_type='BASE') then drop table npdb_itin end if;"



	case 'SQL'
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_aar' and table_type='BASE') then drop table npdb_aar end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_aart' and table_type='BASE') then drop table npdb_aart end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_aff' and table_type='BASE') then drop table npdb_aff end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_agnt' and table_type='BASE') then drop table npdb_agnt end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_alias' and table_type='BASE') then drop table npdb_alias end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_aocd' and table_type='BASE') then drop table npdb_aocd end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_apeal' and table_type='BASE') then drop table npdb_apeal end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_bactn' and table_type='BASE') then drop table npdb_bactn end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_caar' and table_type='BASE') then  drop table npdb_caar end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_cert' and table_type='BASE') then drop table npdb_cert end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_clia' and table_type='BASE') then drop table npdb_clia end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_code_lookup' and table_type='BASE') then drop table npdb_code_lookup end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_control' and table_type='BASE') then drop table npdb_control end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_cuse' and table_type='BASE') then drop table npdb_cuse end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_data_columns' and table_type='BASE') then drop table npdb_data_columns end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_dea' and table_type='BASE') then drop table npdb_dea end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_enty' and table_type='BASE') then drop table npdb_enty end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_er' and table_type='BASE') then drop table npdb_er end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_error' and table_type='BASE') then drop table npdb_error end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_esln' and table_type='BASE') then drop table npdb_esln end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_esubj' and table_type='BASE') then drop table npdb_esubj end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_esuppl' and table_type='BASE') then drop table npdb_esuppl end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_fda' and table_type='BASE') then drop table npdb_fda end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_fein' and table_type='BASE') then drop table npdb_fein end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_fqsl' and table_type='BASE') then drop table npdb_fqsl end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_fsta' and table_type='BASE') then drop table npdb_fsta end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_grad' and table_type='BASE') then drop table npdb_grad end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_hdr' and table_type='BASE') then drop table npdb_hdr end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_hosp' and table_type='BASE') then drop table npdb_hosp end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_invtg' and table_type='BASE') then drop table npdb_invtg end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_isofl' and table_type='BASE') then drop table npdb_isofl end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_isubj' and table_type='BASE') then drop table npdb_isubj end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_isuppl' and table_type='BASE') then drop table npdb_isuppl end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_jocr' and table_type='BASE') then drop table npdb_jocr end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_jocrt' and table_type='BASE') then drop table npdb_jocrt end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_laart' and table_type='BASE') then drop table npdb_laart end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_medicarep' and table_type='BASE') then drop table npdb_medicarep end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_mmpr' and table_type='BASE') then drop table npdb_mmpr end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_mmr' and table_type='BASE') then drop table npdb_mmr end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_mmrt' and table_type='BASE') then drop table npdb_mmrt end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_npi' and table_type='BASE') then drop table npdb_npi end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_oenam' and table_type='BASE') then drop table npdb_oenam end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_pdcn' and table_type='BASE') then drop table npdb_pdcn end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_poo' and table_type='BASE') then drop table npdb_poo end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_qrsd' and table_type='BASE') then drop table npdb_qrsd end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_qry' and table_type='BASE') then drop table npdb_qry end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_qsta' and table_type='BASE') then drop table npdb_qsta end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_rpoc' and table_type='BASE') then drop table npdb_rpoc end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_rsdr' and table_type='BASE') then drop table npdb_rsdr end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_sj' and table_type='BASE') then drop table npdb_sj end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_ssn' and table_type='BASE') then drop table npdb_ssn end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_statoc' and table_type='BASE') then drop table npdb_statoc end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_supplsnd' and table_type='BASE') then drop table npdb_supplsnd end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='npdb_upin' and table_type='BASE') then drop table npdb_upin end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] ="if exists(select 1 from v_systable where table_name='npdb_prct' and table_type='BASE') then drop table npdb_prct end if"
			
			// pfc_messages
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='messages' and table_type='BASE') then drop table messages end if;"
			// qa_profile
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='PD_QA_HDR' and table_type='BASE') then drop table PD_QA_HDR end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='PD_QA_MEASUREMENTS' and table_type='BASE') then drop table PD_QA_MEASUREMENTS end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='QA_MEASUREMENT' and table_type='BASE') then drop table QA_MEASUREMENT end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='QA_PD_REVIEW_ACTION_ITEMS' and table_type='BASE') then drop table QA_PD_REVIEW_ACTION_ITEMS end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='QA_PROFILE' and table_type='BASE') then drop table QA_PROFILE end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='QA_PROFILE_GROUP' and table_type='BASE') then drop table QA_PROFILE_GROUP end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='QA_PD_REVIEW_ACTION_ITEMS' and table_type='BASE') then drop table QA_PD_REVIEW_ACTION_ITEMS end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='PD_QA_MEASUREMENTS' and table_type='BASE') then drop table PD_QA_MEASUREMENTS end if;"
			ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from v_systable where table_name='QA_MEASUREMENT' and table_type='BASE') then drop table QA_MEASUREMENT end if;"
		
end choose
//---------------------------- APPEON END ------------------------

end subroutine

private function datetime of_get_server_datetime ();datetime ldtServerDate


   select getdate() into :ldtServerDate
     from sysobjects
   using SQLCA;
	 
	 
	 
	 RETURN ldtServerDate
end function

private subroutine of_modify_code_lookup ();// code lookup
///ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if NOT EXISTS(SELECT 1 FROM sys.systable,sys.syscolumn  WHERE sys.syscolumn.table_id = sys.systable.table_id  and  sys.systable.table_name = 'code_lookup'  AND sys.syscolumn.column_name = 'npdb_code')  THEN ALTER TABLE dba.code_lookup ADD npdb_code varchar(5) end if ;"

//////////////////////////////////////////////////
// UPDATE THESE VALUES
//////////////////////////////////////////////////
//Start Code Change ---- 05.22.2006 #471 maha
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE CODE_LOOKUP SET DESCRIPTION = 'Clinical Psychology'             WHERE  CODE = 'CP' and lookup_name ='Practitioner Specialties';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE CODE_LOOKUP SET DESCRIPTION = 'Dentist'                         WHERE  CODE = 'DD' and lookup_name ='Practitioner Specialties';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE CODE_LOOKUP SET DESCRIPTION = 'Osteopathic Physician (DO)'      WHERE  CODE = 'DO' and lookup_name ='Practitioner Specialties';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE CODE_LOOKUP SET DESCRIPTION = 'LAW'                             WHERE  CODE = 'LW' and lookup_name ='Practitioner Specialties';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE CODE_LOOKUP SET DESCRIPTION = 'Physician (MD)'                  WHERE  CODE = 'MD' and lookup_name ='Practitioner Specialties';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE CODE_LOOKUP SET DESCRIPTION = 'Nurse Anesthetist'               WHERE  CODE = 'NA' and lookup_name ='Practitioner Specialties';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE CODE_LOOKUP SET DESCRIPTION = 'Nurse Midwifery'                 WHERE  CODE = 'NM' and lookup_name ='Practitioner Specialties';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE CODE_LOOKUP SET DESCRIPTION = 'Nurse Practitioner'              WHERE  CODE = 'NP' and lookup_name ='Practitioner Specialties';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE CODE_LOOKUP SET DESCRIPTION = 'Optometrist'                     WHERE  CODE = 'OP' and lookup_name ='Practitioner Specialties';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE CODE_LOOKUP SET DESCRIPTION = 'Occupational Therapist'          WHERE  CODE = 'OT' and lookup_name ='Practitioner Specialties';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE CODE_LOOKUP SET DESCRIPTION = 'Physician Assistant - Allopathic'WHERE  CODE = 'PA' and lookup_name ='Practitioner Specialties';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE CODE_LOOKUP SET DESCRIPTION = 'Podiatrist'                      WHERE  CODE = 'PD' and lookup_name ='Practitioner Specialties';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE CODE_LOOKUP SET DESCRIPTION = 'Pharmacist'                      WHERE  CODE = 'PH' and lookup_name ='Practitioner Specialties';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE CODE_LOOKUP SET DESCRIPTION = 'Physical Therapist'              WHERE  CODE = 'PT' and lookup_name ='Practitioner Specialties';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE CODE_LOOKUP SET DESCRIPTION = 'Social Worker'                   WHERE  CODE = 'SW' and lookup_name ='Practitioner Specialties';"
//End Code Change---05.22.2006

//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and ic_n is not NULL and code not in('DD','DO','LW','MD','NA','NM','NP','OP','OT','PA','PD','PH','PT','SW');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE CODE_LOOKUP SET IC_N = 030 WHERE CODE  = 'DD' and lookup_name ='Practitioner Specialties';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE CODE_LOOKUP SET IC_N = 020 WHERE CODE  = 'DO' and lookup_name ='Practitioner Specialties';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE CODE_LOOKUP SET IC_N = 899 WHERE CODE  = 'LW' and lookup_name ='Practitioner Specialties';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE CODE_LOOKUP SET IC_N = 010 WHERE CODE  = 'MD' and lookup_name ='Practitioner Specialties';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE CODE_LOOKUP SET IC_N = 110 WHERE CODE  = 'NA' and lookup_name ='Practitioner Specialties';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE CODE_LOOKUP SET IC_N = 120 WHERE CODE  = 'NM' and lookup_name ='Practitioner Specialties';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE CODE_LOOKUP SET IC_N = 130 WHERE CODE  = 'NP' and lookup_name ='Practitioner Specialties';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE CODE_LOOKUP SET IC_N = 363 WHERE CODE  = 'OP' and lookup_name ='Practitioner Specialties';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE CODE_LOOKUP SET IC_N = 410 WHERE CODE  = 'OT' and lookup_name ='Practitioner Specialties';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE CODE_LOOKUP SET IC_N = 642 WHERE CODE  = 'PA' and lookup_name ='Practitioner Specialties';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE CODE_LOOKUP SET IC_N = 350 WHERE CODE  = 'PD' and lookup_name ='Practitioner Specialties';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE CODE_LOOKUP SET IC_N = 050 WHERE CODE  = 'PH' and lookup_name ='Practitioner Specialties';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE CODE_LOOKUP SET IC_N = 430 WHERE CODE  = 'PT' and lookup_name ='Practitioner Specialties';"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE CODE_LOOKUP SET IC_N = 300 WHERE CODE  = 'SW' and lookup_name ='Practitioner Specialties';"

// the following trigger will be dropped once up date ia all over
///ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create trigger code_lookup_before_ins  before insert order 1 on code_lookup referencing new as new_ins for each row begin	set code_lookup.lookup_code = (IsNull((select Max(lookup_code) from code_lookup),0)+1 ) end"


//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO CO
//////////////////////////////////////////////////
// INSERT THESE VALUES string(gnv_app.of_get_id("LOOKUP"))  
//////////////////////////////////////////////////
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "UPDATE CODE_LOOKUP set IC_N = 899 where lookup_name = 'License Types' and IC_N is null;   "
// delete the newly added codes (for testing)
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'Chiropractor';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'Counselor,MH';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'PC';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'PCA';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'PCFM';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'PCSA';"
//
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'MFT';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'DA';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'DH';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'Denturist';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'Dietician';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'Nutritionist';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'EMT-B';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'EMT-CC';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'EMT-I';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'EMT-P';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'Ocularist';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'Optician';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'RPN';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'LPN';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'CNS';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'NURSE-AIDE';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'HOMEMAKER';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'PI';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'Pharmacist-N';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = Pharm Assis.';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'Pharm Tech';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'OP';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'PAO';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'POD ASSIS';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'PSY';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'PSY-SCHOOL';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'PSY-ASSIS';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'PSY-ASSIS';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'ART';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'MT';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'OCCTA';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'PTASSIS';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'REHAB-T';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'RT';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'RTT';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'AUD';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'SLP';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'MEDTECH';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'CYTO';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'NMTECH';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'RTTECH';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'REDTECH';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'Acupuncturist';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'Homeopath';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'MIDWIFE-LAY';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'Naturopath';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'BUSMGR';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'BUSOWNER';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'CORPOFF';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'INSAGNT';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'INSBKR';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'REASH';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'SALESPER';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'OTHER';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'BOOKKEPPER';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'BOOKKEPPER';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'BOOKKEPPER';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'OPF';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'Perfusionist';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'PSYTECH';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'OTHER';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'ACFM';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'HA';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'LTCA';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'ACCOUNTANT';"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'License Types' and code = 'BOOKKEPPER';"
//

string ls_description


select description into:ls_description from code_lookup  where description = 'Other Occupation - Not Classified,';

if not f_validstr(ls_description) then
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','OTHER','Other Occupation - Not Classified,',899);"
 

end if 

select description into:ls_description from code_lookup  where description = 'Salesperson';

if not f_validstr(ls_description) then 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','SALESPER','Salesperson',840);"

end if 
select description into:ls_description from code_lookup  where description = 'Researcher, Clinical';

if not f_validstr(ls_description) then 
  ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','REASH','Researcher, Clinical',800);"

end if 
select description into:ls_description from code_lookup  where description = 'Insurance Broker';

if not f_validstr(ls_description) then 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','INSBKR','Insurance Broker',812);"

end if 
select description into:ls_description from code_lookup  where description = 'Insurance Agent';

if not f_validstr(ls_description) then 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','INSAGNT','Insurance Agent',810);"

end if 
select description into:ls_description from code_lookup  where description = 'Corporate Officer';

if not f_validstr(ls_description) then 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','CORPOFF','Corporate Officer',820);"

end if 
select description into:ls_description from code_lookup  where description = 'Business Owner';

if not f_validstr(ls_description) then 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','BUSOWNER','Business Owner',830);"

end if 

select description into:ls_description from code_lookup  where description = 'Business Manager';

if not f_validstr(ls_description) then 
  ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','BUSMGR','Business Manager',822);"

end if 

select description into:ls_description from code_lookup  where description = 'Bookkeeper';

if not f_validstr(ls_description) then 
  ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','BOOKKEPPER','Bookkeeper',853);"

end if 
select description into:ls_description from code_lookup  where description = 'Accountant';

if not f_validstr(ls_description) then 
  ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','ACCOUNTANT','Accountant',850);"

end if 

select description into:ls_description from code_lookup  where description = 'Long-Term Care Administrator';

if not f_validstr(ls_description) then 
  ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','LTCA','Long-Term Care Administrator',758);"

end if 
select description into:ls_description from code_lookup  where description = 'Hospital Administrator';

if not f_validstr(ls_description) then 
  ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','HA','Hospital Administrator',755);"

end if 

if not f_validstr(ls_description) then 
  ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','ACFM','Adult Care Facility Administrator',752);"

end if 

select description into:ls_description from code_lookup  where description = 'Other Health Care Practitioner - Not Classified';

if not f_validstr(ls_description) then 
  ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','OTHER','Other Health Care Practitioner - Not Classified',699);"

end if 

select description into:ls_description from code_lookup  where description = 'Psychiatric Technician';

if not f_validstr(ls_description) then 
  ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','PSYTECH','Psychiatric Technician',170);"

end if 
select description into:ls_description from code_lookup  where description = 'Perfusionist';

if not f_validstr(ls_description) then 
  ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','Perfusionist','Perfusionist',647);"

end if 

select description into:ls_description from code_lookup  where description = 'Orthotics/Prosthetics Fitter';

if not f_validstr(ls_description) then 
  ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','OPF','Orthotics/Prosthetics Fitter',639);"
end if 
select description into:ls_description from code_lookup  where description = 'Naturopath';

if not f_validstr(ls_description) then 
  ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','Naturopath','Naturopath',627);"

end if 

select description into:ls_description from code_lookup  where description = 'Midwife, Lay (Non-Nurse)';

if not f_validstr(ls_description) then 
  ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','MIDWIFE-LAY','Midwife, Lay (Non-Nurse)',624);"

end if 

select description into:ls_description from code_lookup  where description = 'Medical Assistant';

if not f_validstr(ls_description) then 
  ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','MA','Medical Assistant',618);"

end if 

select description into:ls_description from code_lookup  where description = 'Homeopath';

if not f_validstr(ls_description) then 
  ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','Homeopath','Homeopath',615);"

end if 
select description into:ls_description from code_lookup  where description = 'Athletic Trainer';

if not f_validstr(ls_description) then 
 ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','AT','Athletic Trainer',610);"
 
end if 

select description into:ls_description from code_lookup  where description = 'Acupuncturist';

if not f_validstr(ls_description) then 
  ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','Acupuncturist','Acupuncturist',600);"

end if 
select description into:ls_description from code_lookup  where description = 'Radiologic Technologist';

if not f_validstr(ls_description) then 
 ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','REDTECH','Radiologic Technologist',530);"
 
end if 

select description into:ls_description from code_lookup  where description = 'Radiation Therapy Technologist';

if not f_validstr(ls_description) then 
  ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','RTTECH','Radiation Therapy Technologist',520);"

end if 

select description into:ls_description from code_lookup  where description = 'Nuclear Medicine Technologist';

if not f_validstr(ls_description) then 
  ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','NMTECH','Nuclear Medicine Technologist',510);"

end if 

select description into:ls_description from code_lookup  where description = 'Cytotechnologist';

if not f_validstr(ls_description) then 
  ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','CYTO','Cytotechnologist',505);"

end if 

select description into:ls_description from code_lookup  where description = 'Medical Technologist';

if not f_validstr(ls_description) then 
  ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','MEDTECH','Medical Technologist',500);"

end if 

select description into:ls_description from code_lookup  where description = 'Speech/Language Pathologist';

if not f_validstr(ls_description) then 
  ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','SLP','Speech/Language Pathologist',460);"

end if 

select description into:ls_description from code_lookup  where description = 'Audiologist';

if not f_validstr(ls_description) then 
  ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','AUD','Audiologist',400);"

end if 

select description into:ls_description from code_lookup  where description = 'Respiratory Therapy Technician';

if not f_validstr(ls_description) then 
  ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','RTT','Respiratory Therapy Technician',666);"

end if 

select description into:ls_description from code_lookup  where description = 'Respiratory Therapist';

if not f_validstr(ls_description) then 
  ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','RT','Respiratory Therapist',663);"

end if 

select description into:ls_description from code_lookup  where description = 'Rehabilitation Therapist';

if not f_validstr(ls_description) then 
  ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','REHAB-T','Rehabilitation Therapist',450);"

end if 

select description into:ls_description from code_lookup  where description = 'Physical Therapy Assistant';

if not f_validstr(ls_description) then 
  ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','PTASSIS','Physical Therapy Assistant',440);"

end if 

select description into:ls_description from code_lookup  where description = 'Occupational Therapy Assistant';

if not f_validstr(ls_description) then 
  ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','OCCTA','Occupational Therapy Assistant',420);"

end if 


select description into:ls_description from code_lookup  where description = 'Massage Therapist';

if not f_validstr(ls_description) then 
  ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','MT','Massage Therapist',405);"

end if 
select description into:ls_description from code_lookup  where description = 'Art/Recreation Therapist';

if not f_validstr(ls_description) then 
  ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','ART','Art/Recreation Therapist',402);"

end if 

select description into:ls_description from code_lookup  where description = 'Art/Recreation Therapist';

if not f_validstr(ls_description) then 
  ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','ART','Art/Recreation Therapist',402);"

end if 
select description into:ls_description from code_lookup  where description = 'Psychological Assistant, Associate,Examiner';

if not f_validstr(ls_description) then 
  ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','PSY-ASSIS','Psychological Assistant, Associate,Examiner',373);"

end if 
select description into:ls_description from code_lookup  where description = 'Psychological Assistant, Associate,Examiner';

if not f_validstr(ls_description) then 
  ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','PSY-ASSIS','Psychological Assistant, Associate,Examiner',373);"

end if 
select description into:ls_description from code_lookup  where description = 'School Psychologist';

if not f_validstr(ls_description) then 
  ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','PSY-SCHOOL','School Psychologist',372);"

end if 
select description into:ls_description from code_lookup  where description = 'Psychologist';

if not f_validstr(ls_description) then 
  ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','PSY','Psychologist',371);"
end if 

select description into:ls_description from code_lookup  where description = 'Podiatric Assistant';

if not f_validstr(ls_description) then 
  ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','POD ASSIS','Podiatric Assistant',648);"

end if 
select description into:ls_description from code_lookup  where description = 'Physician Assistant, Osteopathic';

if not f_validstr(ls_description) then 
  ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','PAO','Physician Assistant, Osteopathic',645);"

end if 

select description into:ls_description from code_lookup  where description = 'Osteopathic Physician Intern/Resident';

if not f_validstr(ls_description) then 
  ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','OP','Osteopathic Physician Intern/Resident',025);"

end if 
select description into:ls_description from code_lookup  where description = 'Physician Intern/Resident (MD)';

if not f_validstr(ls_description) then 
  ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','Physician I/R','Physician Intern/Resident (MD)',015);"

end if 
select description into:ls_description from code_lookup  where description = 'Pharmacy Technician';

if not f_validstr(ls_description) then 
  ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','Pharm Tech','Pharmacy Technician',075);"

end if 

select description into:ls_description from code_lookup  where description = 'Pharmacy Assistant';

if not f_validstr(ls_description) then 
  ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','Pharm Assis.','Pharmacy Assistant',070);"

end if 
select description into:ls_description from code_lookup  where description = 'Pharmacist, Nuclear';

if not f_validstr(ls_description) then 
  ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','Pharmacist-N','Pharmacist, Nuclear',060);"

end if 
select description into:ls_description from code_lookup  where description = 'Pharmacy Intern';

if not f_validstr(ls_description) then 
  ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','PI','Pharmacy Intern',055);"

end if 

select description into:ls_description from code_lookup  where description = 'Chiropractor';

if not f_validstr(ls_description) then 
   ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','Chiropractor','Chiropractor',603);"
end if 

select description into:ls_description from code_lookup  where description = 'Counselor, Mental Health';

if not f_validstr(ls_description) then 
   ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))    + ",'License Types','Counselor,MH','Counselor, Mental Health',621);"
end if 


select description into:ls_description from code_lookup  where description = 'Professional Counselor';

if not f_validstr(ls_description) then 
   ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','PC','Professional Counselor',651);"

end if 

select description into:ls_description from code_lookup  where description = 'Professional Counselor, Alcohol';

if not f_validstr(ls_description) then 
   ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','PCA','Professional Counselor, Alcohol',654);"

end if 

select description into:ls_description from code_lookup  where description = 'Professional Counselor, Family/Marriage';

if not f_validstr(ls_description) then 
   ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','PCFM','Professional Counselor, Family/Marriage',657);"

end if 

select description into:ls_description from code_lookup  where description = 'Marriage and Family Therapist';

if not f_validstr(ls_description) then 
   ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','MFT','Marriage and Family Therapist',661);"
end if 

select description into:ls_description from code_lookup  where description = 'Professional Counselor, Substance Abuse';

if not f_validstr(ls_description) then 
   ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','PCSA','Professional Counselor, Substance Abuse',660);"
end if 


select description into:ls_description from code_lookup  where description = 'Nurses Aide';

if not f_validstr(ls_description) then
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','NURSE-AIDE','Nurses Aide',150);"
	
end if 

select description into:ls_description from code_lookup  where description = 'Clinical Nurse Specialist';

if not f_validstr(ls_description) then
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','CNS','Clinical Nurse Specialist',141);"

	
end if 
select description into:ls_description from code_lookup  where description = 'Licensed Practical or Vocational Nurse';

if not f_validstr(ls_description) then
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','LPN','Licensed Practical or Vocational Nurse',140);"

end if 

select description into:ls_description from code_lookup  where description = 'Registered (Professional) Nurse';

if not f_validstr(ls_description) then
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','RPN','Registered (Professional) Nurse',100);"

end if 
select description into:ls_description from code_lookup  where description = 'Optician';

if not f_validstr(ls_description) then
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','Optician','Optician',633);"

end if 
select description into:ls_description from code_lookup  where description = 'Ocularist';

if not f_validstr(ls_description) then
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','Ocularist','Ocularist',630);"

end if 

select description into:ls_description from code_lookup  where description = 'EMT, Paramedic';

if not f_validstr(ls_description) then
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','EMT-P','EMT, Paramedic'   ,280);"

end if 
select description into:ls_description from code_lookup  where description = 'EMT, Intermediate';

if not f_validstr(ls_description) then
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','EMT-I','EMT, Intermediate',270);"

end if 
select description into:ls_description from code_lookup  where description = 'EMT, Cardiac/Critical Care';

if not f_validstr(ls_description) then
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','EMT-CC','EMT, Cardiac/Critical Care',260);"

end if 
select description into:ls_description from code_lookup  where description = 'EMT, Basic';

if not f_validstr(ls_description) then
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','EMT-B','EMT, Basic',250);"
	
end if 
select description into:ls_description from code_lookup  where description = 'Nutritionist';

if not f_validstr(ls_description) then
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','Nutritionist','Nutritionist',210);"
	
end if 
select description into:ls_description from code_lookup  where description = 'Dietician';

if not f_validstr(ls_description) then
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','Dietician','Dietician',200);"

end if 
select description into:ls_description from code_lookup  where description = 'Denturist';

if not f_validstr(ls_description) then
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','Denturist','Denturist',612);"

end if 
select description into:ls_description from code_lookup  where description = 'Dental Hygienist';

if not f_validstr(ls_description) then
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','DH','Dental Hygienist',609);"

end if 
select description into:ls_description from code_lookup  where description = 'Dental Assistant';

if not f_validstr(ls_description) then
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','DA','Dental Assistant',606);"

end if 
select description into:ls_description from code_lookup  where description = '';

if not f_validstr(ls_description) then
	ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description,ic_n) VALUES ( " + string(gnv_app.of_get_id("LOOKUP"))   + ",'License Types','DR','Dental Resident',035);"

end if 

end subroutine

private function integer of_recieve ();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : of_recieve
//==================================================================================================================
//  Purpose   	: s
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael Skinner  Wednesday 13 October 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
boolean lb_found
boolean ib_first_time
boolean ib_first_time2
long    li_FileNum,ll_i,ll_j,ll_k,li_FileNum2,ll_l,ll_x,ll_y
long    ll_row
long    ll_start_count 
long    ll_loopcounter
long    ll_record_id
long    ll_tag_array_count
LONG    LL_ROW2
long    ll_found
string  ls_null[]
string  ls_tag_array[]
string  ls_file_dump,ls_file_dump2
string  ls_current_tag
string ls_tag[]
string  ls_file_names[]
string  ls_array[]
string ls_execute
string ls_Null_string
setnull(ls_Null_string)
LONG value
String ls_currdir
Integer li_cnt, li_entries
integer li_process
String ls_import
string ls_file
string ls_new_file
string pdn
string ls_bad_files_error //maha 101408
long ll_file_doc

///////////////////////////////////////////////////////////////////
// run the batch file to get any new data
///////////////////////////////////////////////////////////////////
IF of_create_ini()                                <>  success THEN return failure  //Start Code Change ----06.16.2008 #V81 maha
filedelete(is_itp_path + "\itpstat.dat") //Start Code Change ----04.30.2008 #V8 maha - make sure the file is deleted before running - maha 07.25.08 added slash
//if not fileexists(is_files[3]) then // can be removed for deployment
	inv_filesrv.of_ChangeDirectory (is_itp_path)
	ls_execute = is_batch_files[1]
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-01
	//$<modify> 03.24.2006 By: Liang QingShi
	//$<reason> Performance tuning
	//$<modification> This original script opens a new page in the same IE, which is incorrect.
	//$<modification> Modify the script to open a new IE instead of open a new page in the same IE.
	/*
	value = ShellExecuteA( Handle( This ), "open", ls_execute , ls_Null_string, ls_Null_string, 0)
	*/
	//value = ShellExecuteA( Handle( This ), "open", 'IEXPLORE', ls_execute , ls_Null_string, 0)
	
	//Start Code Change ---- 05.03.2007 #V7 maha
	//Modified 'correction' because it no longer worked via windows version
	If appeongetclienttype() = 'PB' Then
		value = ShellExecuteA( Handle( This ), "open", ls_execute , ls_Null_string, ls_Null_string, 0)
	else //web
		//value = ShellExecuteA( Handle( This ), "open", 'IEXPLORE', ls_execute , ls_Null_string, 0)   //Commented by (Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
		value = ShellExecuteA( Handle( This ), "open", of_getbrowserversion( ), ls_execute , ls_Null_string, 0)  //(Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
	end if
	//End Code Change---05.03.2007
	//---------------------------- APPEON END ----------------------------   
	//run(is_batch_files[1],Minimized! )
//inv_filesrv.of_ChangeDirectory (is_current_path)
inv_filesrv.of_ChangeDirectory (is_itp_path) ////Start Code Change ---- 05.01.2007 #V7 maha
//if of_check_status('Receiving Error') = failure then
if of_check_status('R') = failure then	 //Start Code Change ---- 08.28.2012 #V12 maha - changed the passed value
	return failure
end if 
///end if

n_cst_dirattrib lnv_dirlist[]

inv_filesrvwin32 = create n_cst_filesrvwin32

li_entries = inv_filesrvwin32.of_DirList(is_directories[2] + '\*.csm', 0, lnv_dirlist) //get the list of received files

if isvalid(w_infodisp) then w_infodisp.wf_set_min_max(1,upperbound(ls_file_names))
//messagebox(string(upperbound(lnv_dirlist)), is_directories[2])		//test message 
for ll_i = 1 to upperbound(lnv_dirlist)
			 ll_record_id =1 // reinit the record id -- for consistancy
			 ib_first_time = false
			 ib_first_time2 = false
			 of_create_datastores('' ) // reset/recreate
			 ll_l = 1 // reset counter
			
          		ls_file =    lnv_dirlist[ll_i].is_filename
			 is_current_file = ls_file
			 // testing 
			 li_FileNum2 = FileOpen(is_directories[2] +'\'+ls_file,StreamMode!)
			 //li_FileNum2 = FileOpen('',StreamMode! )
			 			 
			 FileRead ( li_FileNum2 , ls_file_dump2 )
			 lnv_string.of_parsetoarray(ls_file_dump2, '~n' , ls_tag_array) //n_pfc_string is in pfeappsrv: parse file into ls_tag_array
			 fileclose(li_FileNum2)
		 
		 //Start Code Change ----04.29.2008 #V8 maha - this gets the doc_id from the file
		 //Start Code Change ----10.14.2008 #V8 maha - trap for missing CUSE
		 	is_docid_current = ""  //reset
			 for ll_l = 1 to upperbound(ls_tag_array)
				if MidA(ls_tag_array[ll_l],1,4) = "CUSE" then
					lnv_string.of_parsetoarray(ls_tag_array[ll_l], delimiter , ls_tag)
					is_docid_current = ls_tag[2]
				end if
			next
			 if is_docid_current = "" then 
				ls_bad_files_error += is_current_file + ','
				continue  //trap: if CUSE section is not found skip the rest of the functionality
			end if
		//End Code Change---10.14.2008
			
	
			//copy the original file, rename to doc id and save in processed; delete original file
			ls_new_file = is_directories[5] +'\'+  is_docid_current + ".csm" 
			ll_file_doc = FileOpen(ls_new_file ,StreamMode! , write!, lockwrite!,replace! )
			FileWrite ( ll_file_doc, ls_file_dump2  )
			fileclose(ll_file_doc)
			filedelete( is_directories[3] +'\'+ is_docid_current + ".csm") //delete the original upload file 05.01.2008
		//End Code Change---04.29.2008
			/////////////////////////////////////////////////////////////////////////////////////
			// first lets look through the the file to see if it passed muster (FSTA) record
			/////////////////////////////////////////////////////////////////////////////////////
			//Start Code Change ----05.07.2008 #V8 maha
			//if of_file_succeded( ls_tag_array) <> success then continue
			li_process = of_file_succeded( ls_tag_array) 
			if li_process = -1 then continue //receive failed
			//End Code Change---05.07.2008	 
			/////////////////////////////////////////////////////////////////////////////////////
			// lets see if the QRSD record exists if not then there are no reports
			///////////////////////////////////////////////////////////////////////////////////// 
			
		//	IF of_file_has_report( ls_tag_array) THEN 
			
				ll_tag_array_count = upperbound(ls_tag_array)
				for ll_l = 1 to ll_tag_array_count
					ll_j = 1// reset counter
					ll_loopcounter = ll_loopcounter + 1
					ls_tag = ls_null
					lnv_string.of_parsetoarray(ls_tag_array[ll_l], delimiter , ls_tag) //further breakdown the array section
					// get  the tab
					ls_current_tag = ls_tag[1]
					
									
					for ll_j = 1 to upperbound(ids_npdb_dws)
					//	pdn = ids_npdb_dws[ll_j].Object.DataWindow.Print.DocumentName
					//	if pdn = "MMR" then debugbreak()	
						ll_k = 2 // reset counter
						if ls_current_tag = ids_npdb_dws[ll_j].Object.DataWindow.Print.DocumentName then
							
							lb_found = true
							ll_row = ids_npdb_dws[ll_j].insertrow(0)
							LL_ROW2 = ll_row
							FOR ll_k = 2 to  UPPERBOUND(LS_TAG)
								// need to match the isubj with the report id
								if ls_current_tag = 'QRSD' THEN// ISUBJ
									IF not ib_first_time then
										ll_record_id =1 
										ib_first_time = TRUE
									ELSE
										ll_record_id  = ll_record_id + 1
									END IF
									ls_current_tag = ''
								end if
								
											//messagebox(ls_current_tag,'tag: ' + string( ls_tag[ll_k]) +"column: " +string(ll_k) +' of '+ string(( LONG(ids_npdb_dws[ll_j].Object.DataWindow.Column.Count) -1))) 
											// DO A FIND ON THIS RECORD IN THE DATAWINDOW IF FOUND THEN REPLACE 
											// THE OLD DATA WITH THE NEW DATA. THE NEW DATA WILL BE WHAT IS IN THE REPORT THE 
											// FIRST ONE CANE FROM THE SUBMISSION
								ll_found = ids_npdb_dws[ll_j].Find("REPORT_ID = " +STRING(ll_record_id), 1, ids_npdb_dws[ll_j].RowCount())
								IF ll_found > 0 THEN
									ids_npdb_dws[ll_j].setItem(ll_found, (ll_k) , ls_tag[ll_k])
									//ids_npdb_dws[ll_j].setItem(ll_found, 'report_id' , ll_record_id)
									IF ll_row <> 0 THEN
										ids_npdb_dws[ll_j].DELETEROW(ll_row)
										ll_row = 0 // RESET THE ROW
									END IF
								ELSE
									ids_npdb_dws[ll_j].setItem(ll_row, (ll_k) , ls_tag[ll_k])
									//ids_npdb_dws[ll_j].setItem(ll_row, 'report_id' , ll_record_id)
								END IF
											
							NEXT
							// SET THE RECORD ID OUT SIDE THE LOOP
							ids_npdb_dws[ll_j].setItem(ll_row2, 'report_id' , ll_record_id)
							END IF
							if lb_found then
								lb_found = false
								exit
							end if
					next //ll_j
				next //ll_l
		  // if isvalid(w_infodisp) then w_infodisp.wf_step_pbar(1)
		    // set the header id
			
			long ll_cuse_position,ll_z,ll_isubj_position
			for ll_z = 1 to upperbound(ids_npdb_dws)
				if ids_npdb_dws[ll_z].dataobject = 'd_npdb_cuse' then
					ll_cuse_position = ll_z
				end if
			next
			
			for ll_z = 1 to upperbound(ids_npdb_dws)
				if ids_npdb_dws[ll_z].dataobject = 'd_npdb_hdr' then
					ll_hdr_position = ll_z
				end if
			next
			
			for ll_z = 1 to upperbound(ids_npdb_dws)
				if ids_npdb_dws[ll_z].dataobject = 'd_npdb_isubj' then
					ll_isubj_position = ll_z
				end if
			next
		
				
		  	ids_npdb_dws[ll_hdr_position].setItem(ids_npdb_dws[ll_hdr_position].rowcount(), 'doc_id' , ids_npdb_dws[ll_cuse_position].getItemString(1,'customer_use_fld') )
			//messagebox('debug',string(ids_npdb_dws[ll_cuse_position].getItemString(1,'customer_use_fld'))  )
			// the doc_id
			LNV_string.of_parsetoarray( ids_npdb_dws[ll_cuse_position].getItemString(1,'customer_use_fld'), '-', ls_arrAY[])
			ids_npdb_dws[ll_hdr_position].setItem(ids_npdb_dws[ll_hdr_position].rowcount(), 'prac_id' , long(ls_array[2]))

				IF of_display_error( ) =  failure THEN //function does not return failure
				   // do nothing else
				else
					// set the npdn header id fo these records
					of_set_npdb_id()
					// update the npdb record datawindows
					of_update_database( )
					// set the verification response code - if we can
				//	if il_Interface = QRXS_INTERFACE then
//						of_set_post_import_status_qrxs()
				//	else
						of_set_post_import_status()
				//	end if
				 end if
				  //if not ib_first_time2 then
					//is_messsages[upperbound(is_messsages) +  1] = "Recieved report information for: " +ids_npdb_dws[ll_isubj_position].object.lname[1] +','+ ids_npdb_dws[ll_isubj_position].object.fname[1] 
					//ib_first_time2 = true
				//end if
					
NEXT //ll_i

///end if // if fileexists(is_files[3] ) then

 
for ll_i = 1 to upperbound(lnv_dirlist)
	//move from itp\download to processed directory
	//Start Code Change ----04.29.2008 #V8 maha - changed from filemove because filemove cannot overwrite an existing file
	//writing file under doc id name above then deleting here
      //FileMove ( is_directories[2] +'\'+lnv_dirlist[ll_i].is_filename, is_directories[5] +'\' +lnv_dirlist[ll_i].is_filename )
	//FileCopy ( is_directories[2] +'\'+lnv_dirlist[ll_i].is_filename, is_directories[5] +'\' +lnv_dirlist[ll_i].is_filename ,true) 
	filedelete( is_directories[2] +'\'+lnv_dirlist[ll_i].is_filename)
	//End Code Change---04.29.2008
next
return 0
end function

private function integer of_send (string as_doc_ids[]);////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [private]   : of_send
//==================================================================================================================
//  Purpose   	: the opening function to the NPDB submission process
//==================================================================================================================
//  Arguments 	: [string]  as_doc_ids[] -- an array of doc ids to be processed
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael Skinner  
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
boolean lb_found
long ll_i,ll_j // LOOP COUNTERS
// mskinner 18 april 2006 - begin
// moved to instace var 
// long    il_current_fac_id
// mskinner 18 april 2006 - end
long ll_foundrow
long ll_prac_ids[]
long ll_prac
string  ls_null_array[]
string  ls_array[]
string  ls_tracker_docs[]
string  ls_fac_id[]

// clear out the error messages if there are any
is_err_mess[] =  ls_null_array[]
filedelete(is_itp_path + "\itpstat.dat") //Start Code Change ----05.05.2008 #V8 maha- maha 07.25.08 added slash
OF_create_datastores( '')

// make the batch files
// reset the dataobject - no transobject - external dw
ids_pracs.dataobject = ''
ids_pracs.dataobject = 'd_npdb_pracs'
//debugbreak()
//////////////////////////////////////////////////////////////
// parse out doc set the faciliy and prac_id to the  datastore
//////////////////////////////////////////////////////////////
string ls_find
FOR ll_i = 1 TO upperbound(as_doc_ids)
	 lnv_string.of_ParseToArray ( as_doc_ids[ll_i], '-', ls_array )
	 // make sure there are no dups
	 ls_find = "prac_id = " + ls_array[2] + ""
	 ll_foundrow = ids_pracs.Find(ls_find, 1, ids_pracs.rowcount() )
	 IF ll_foundrow = 0 THEN
		ids_pracs.insertrow(0)
		ids_pracs.object.prac_id[ids_pracs.rowcount()] = long(ls_array[2])
		long ll_k
		
		for ll_k = 1 to upperbound(ls_fac_id)
			if ls_fac_id[ll_k] = ls_array[3] then lb_found = true
		next
		if not lb_found  and ls_array[3] <> string(0) then // I found zeros in an old db
			ls_fac_id[upperbound(ls_fac_id) + 1] = ls_array[3]
		end if
		
		lb_found = false
		ids_pracs.object.fac_id[ids_pracs.rowcount()]  = long(ls_array[3])
		ids_pracs.object.doc_id[ids_pracs.rowcount()]  = as_doc_ids[ll_i]
	ELSEif ll_foundrow < 0 then
	 //	messagebox("Find failure in of send",ls_find)
		//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
		inv_message.of_MessageBox("Find failure in of send",ls_find,true)	
	END IF
NEXT

for ll_i = 1 to ids_pracs.rowcount() 
	ll_prac_ids[ll_i] = ids_pracs.object.prac_id[ll_i]
next

if isvalid(w_infodisp) THEN w_infodisp.wf_set_min_max(1,ids_pracs.rowcount())
////////////////////////////////////////////////////////////////////
// now we have all of the info we need to start the process
////////////////////////////////////////////////////////////////////

//get the facliliies
//ids_npdb_fac_info.retrieve()
ids_npdb_fac_info.retrieve(gs_user_id) //Start Code Change ----12.05.2007 #V8 maha changed retrieval to new argument
ids_cc_information.retrieve( )
ids_pracs_info.retrieve(ll_prac_ids)
if isvalid(w_infodisp) then w_infodisp.st_1.text = 'DOC IDS: ' + string(upperbound(as_doc_ids))

for ll_j = 1 to upperbound(ls_fac_id)
	il_current_fac_id = long(ls_fac_id[ll_j])
	
	// filter out the ids_npdb_fac_info datastore
	ids_npdb_fac_info.SetFilter("facility_id = " + String(il_current_fac_id))
	ids_npdb_fac_info.filter()
	
	// filter cc information
	ids_cc_information.SetFilter("facility_id = " + String(il_current_fac_id))
	ids_cc_information.filter()
			
	if ids_npdb_fac_info.rowcount() > 0 then
		is_current_facility = ids_npdb_fac_info.object.facility_name[1]
	else
		is_err_mess[upperbound(is_err_mess) + 1 ] = 'No such facility found with facility id : ' + ls_fac_id[ll_j]
	end if
	// filter out the facility id on the first row
			
	// ********** need to make sure dup docs do not exist
	ids_pracs.SetFilter("fac_id = " + String(il_current_fac_id))
	ids_pracs.filter()
	
	if il_Interface = ITP_INTERFACE then
		IF of_create_ini() <> success THEN CONTINUE
	else
		IF of_create_qrxs_prop("SEND") <> success THEN CONTINUE //Add by Evan 11.23.2009 (V10.1 - NPDB QRXS)
	end if
	
	// ONLY CHECK THE FACILITY INFO IF WE ARE USING CC
	IF of_check_missing_values(ids_npdb_fac_info) <>  success THEN CONTINUE
	if upper(ids_cc_information.object.npdb_pay_type[1]) = "C"  then
		IF of_check_missing_values(ids_cc_information) <>  success THEN continue
	end if
	if isvalid(w_infodisp) then w_infodisp.st_information.text = 'Creating Upload file for facility ' + is_current_facility
	
	FOR ll_i = 1 to ids_pracs.rowcount()
		IF isvalid(w_infodisp) then w_infodisp.wf_step_pbar(1)
		if isvalid(w_infodisp) then w_infodisp.st_information.text = 'Creating Upload file for facility ' + is_current_facility + string(ll_i) +' of '+ string(ids_pracs.rowcount())
		ll_prac = ids_pracs.object.prac_id[ll_i]
		il_upload_prac = ll_prac
		IS_CURRENT_FILE_NAME = ids_pracs.object.doc_id[ll_i]    // the doc_id is the file name
		ids_pracs_info.setfilter("prac_id = " + string(ll_prac))
		ids_pracs_info.filter()
		IF of_check_missing_values(ids_pracs_info) <> success THEN 
			of_create_qrxs_log( IS_CURRENT_FILE_NAME, ll_prac,il_current_fac_id,"", "VAL", "Missing data")
			CONTINUE
		end if
		if il_Interface = ITP_INTERFACE then
			IF of_create_upload_dat_indv(IS_CURRENT_FILE_NAME) <> success THEN CONTINUE
		else //QRXS_interface
		//	debugbreak()
			IF of_create_qrxs_upload_file(IS_CURRENT_FILE_NAME) <> success THEN //Add by Evan 11.24.2009 (V10.1 - NPDB QRXS)
				of_create_qrxs_log( IS_CURRENT_FILE_NAME, ll_prac,il_current_fac_id,"", "VAL", "Missing License data")
				CONTINUE 
			End if
		end if
		
		//Start Code Change ----06.04.2008 #V81 maha - populate array to create tracker to eliminate creation of tracker records for pracs that fail because of missing data
		ls_tracker_docs[upperbound(ls_tracker_docs) + 1] = IS_CURRENT_FILE_NAME
		//End Code Change---06.04.2008
		//Start Code Change ----09.04.2012 #V12 maha - functional change: as NPDB confirmation process fails for multiple pracs in a upload, change to send each file separately
		IF of_create_upidlist(IS_CURRENT_FILE_NAME) <> success THEN CONTINUE
		IF isvalid(w_infodisp) then w_infodisp.st_information.text = 'Starting upload process to the NPDB for facility ' + is_current_facility
		debugbreak()
		//Start Code Change ----09.04.2012 #V12 maha - moved inside of loop to run each prac separately
		//UPLOAD
		of_upload()
		of_set_tracker_qrsx( IS_CURRENT_FILE_NAME)

	NEXT// prac
//	debugbreak()
//@@@@@@@@@@@@@@@@@@	
	
	ids_npdb_fac_info.RowsMove(1, ids_npdb_fac_info.rowcount(), Primary! , ids_npdb_fac_info, 1, Delete!) //Modify by Evan 03.23.2010 (move to ids_pracs is incorrect)
	// CLEAR PRAC FILTER
	ids_pracs.RowsMove(1, ids_pracs.rowcount(), Primary! , ids_pracs, 1, Delete!)
	ids_pracs.SetFilter("")  
	ids_pracs.filter()
	// CLEAR FAC_INFO FILTER
	ids_npdb_fac_info.SetFilter("")  
	ids_npdb_fac_info.Filter()
   if isvalid(w_infodisp) then w_infodisp.st_information.text = 'Process Completed' 
	if isvalid(w_infodisp) then w_infodisp.wf_step_pbar(1)	
NEXT// ll_j = 1 to upperbound(ls_fac_id)

//Start Code Change ----06.04.2008 #V81 maha - change arrary sent to by pass incomplete files
if il_Interface = ITP_INTERFACE then //maha 09.05.2012
	of_set_tracker_export_id(as_doc_ids[] )
	if upperbound (ls_tracker_docs) > 0 then  //Start Code Change ----08.04.2008 #V85 maha - trap for empty array
		of_set_tracker_export_id(ls_tracker_docs[] )
	end if
end if
//End Code Change---06.04.2008

if isvalid(w_infodisp) then  close(w_infodisp)

return success
end function

private function integer of_set_internet_inuse ();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : of_set_internet_inuse
//==================================================================================================================
//  Purpose   	: Set the instance var to "Y" if we are comeing the web application
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [integer] not used     
//==================================================================================================================
//  Notes     	: 	When is_internet_inuse is set to Y no message will be displayed, sent the DB instead.
//==================================================================================================================
//  Created By	: Michael Skinner  05 Jan 2005 
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

is_internet_inuse = "Y"



return 1
end function

private function integer of_upload ();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : of_upload
//==================================================================================================================
//  Purpose   	: Run the barch files for upload
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael Skinner  
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
long i, ll_return
STRING LS_NULL
string ls_execute
LONG value

SetNull(ls_Null)

choose case il_Interface
	case ITP_INTERFACE
		inv_filesrv.of_ChangeDirectory (is_itp_path)
		of_create_file(is_batch_files[3], is_batch_file_text[3] + ' ' + is_password)  
		inv_datetime.of_wait(1)
		ls_execute = is_batch_files[3]		
		If appeongetclienttype() = 'PB' Then
			value = ShellExecuteA ( Handle( This ), "open", ls_execute , ls_Null, ls_Null, 0)
		else
			//value = ShellExecuteA( Handle( This ), "open", 'IEXPLORE', ls_execute , ls_Null, 0)   //Commented by (Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
			value = ShellExecuteA( Handle( This ), "open", of_getbrowserversion( ), ls_execute , ls_Null, 0)  //(Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
		end if
		
		inv_datetime.of_wait(3)
		ls_execute = is_batch_files[2]
		If appeongetclienttype() = 'PB' Then
			value = ShellExecuteA ( Handle( This ), "open", ls_execute , ls_Null, ls_Null, 0)
		else
			//value = ShellExecuteA( Handle( This ), "open", 'IEXPLORE', ls_execute , ls_Null, 0)   //Commented by (Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
			value = ShellExecuteA( Handle( This ), "open", of_getbrowserversion( ), ls_execute , ls_Null, 0)  //(Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
		end if
	case QRXS_INTERFACE //Add by Evan 11.26.2009 (V10.1 - NPDB QRXS)
		// Change qrxs path into current path
		inv_filesrv.of_ChangeDirectory(is_qrxs_path)
		
		// Encode password of qrxs.properties file
		if gi_test_mode = 1 then
			// Password is: bSTIrO3yVunS8272zwvjPb6fIpM\=
		else
			FileDelete(is_status_files2[1])
		//	debugbreak()
			//Start Code Change ----04.13.2010 #V10 maha - changed to the variable
			//of_create_file(is_batch_files2[3], is_batch_file_text2[3] + ' ' + ids_npdb_fac_info.object.npdb_pass[1])
			of_create_file(is_batch_files2[3], is_batch_file_text2[3] + ' ' + is_password )
			//End Code Change ----04.13.2010
			ls_execute = is_batch_files2[3]
			value = ShellExecuteA ( Handle( This ), "open", ls_execute , ls_Null, ls_Null, 0)
			for i = 1 to 30
				inv_datetime.of_wait(1)
				if FileExists(is_status_files2[1]) then
					Exit
				else
					if i = 30 then
						//MessageBox("Error", "Failed to encode password.")
						//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
						inv_message.of_MessageBox("Error", "Failed to encode password.",true)
						Return FAILURE
					end if
				end if
			next
		end if
		FileDelete(is_status_files2[1])

		// Executes Send command to upload XML files to NPDB
		inv_filesrv.of_ChangeDirectory(is_qrxs_path)
		ls_execute = is_batch_files2[2]
		value = ShellExecuteA ( Handle( This ), "open", ls_execute , ls_Null, ls_Null, 0)
		inv_datetime.of_wait(2) //maha 09.05.2012 changed from 3
	case else //not ITP or QRXS
		Return FAILURE
end choose

//Start Code Change ---- 08.28.2012 #V12 maha - changed QRSX to use different function
choose case il_Interface
	case QRXS_INTERFACE
		of_check_status_send_qrxs( )
	case else
		of_check_status("Please check the facility " + is_current_facility)
end choose
//End Code Change ---- 08.28.2012


inv_filesrv.of_ChangeDirectory(is_current_path)

Return SUCCESS
end function

private function string of_create_upin ();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : of_create_upin
//==================================================================================================================
//  Purpose   	: open event
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [STRING] THE TAG STRING     
//==================================================================================================================
//  Notes     	:  Unique Physician Inentification Number
//==================================================================================================================
//  Created By	: Michael B. Skinner Friday 14 January 2004 
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

STRING ls_tag_string[]
STRING ls_return
LONG ll_i

///////////////////////////////////////////////////////////////////////
// INSERT THE DATA INTO THE SPOT
///////////////////////////////////////////////////////////////////////
datastore ids_upin
ids_upin = create datastore
ids_upin.dataobject = 'd_npdb_pd_upin'
ids_upin.settransobject( sqlca)
ids_upin.retrieve(ids_pracs_info.object.prac_id[1])

ls_tag_string[upperbound(ls_tag_string) + 1]  =  'UPIN'                   + delimiter   // TAG

for ll_i = 1 to ids_upin.rowcount()
	if ll_i < 5 then  // can only support 4
	ls_tag_string[upperbound(ls_tag_string) + 1]  =  ids_upin.getItemString(ll_i,'id_number')  + delimiter
	end if 
next 


ls_tag_string[upperbound(ls_tag_string) + 1]  =  new_line

RETURN of_assemble_string(ls_tag_string)
end function

private function integer of_reset_tracker ();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : n_cst_npdb :: of_reset_tracker
//==================================================================================================================
//  Purpose   	: reset the tracker datastore 
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael Skinner  Wednesday 13 October 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//of_reset_tracker



return success
end function

private function integer of_post_send (integer ai_status);////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : of_post_send
//==================================================================================================================
//  Purpose   	: This function sets values in the varif_info table that should be set after the doc_ids are sent
//==================================================================================================================
//  Arguments 	: [ai_status] The status of weather or not the file was sent
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael Skinner  Monday 07 Febuary 2005
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CONSTANT LONG   AWAITING_RESPONSE = 0
CONSTANT LONG   NEEDS_PROCESSING  = 1
CONSTANT LONG   MAX_LENGTH        = 255 // THE MAX LENGTH OF THE NOTES FIELD
//CONSTANT STRING SENT_NOTE         = 'Information sent to the NPDB for this practitioner'
//CONSTANT STRING NOT_SENT_NOTE     = 'Information not sent to the NPDB for this practitioner'

long   ll_i
long i
string ls_doc_id[]
string ls_note
datetime ldt_now
boolean lb_failed
string ls_fullname
long ll_prac_id
ldt_now  = OF_GET_server_datetime( ) 
// set a filter on ids_pracs
FOR ll_i = 1 TO ids_pracs.rowcount()
	ls_doc_id[ll_i] = ids_pracs.object.doc_id[ll_i]
NEXT
ids_varification.retrieve(ls_doc_id)

// need to set the flag to 0 so that we do not 
FOR ll_i = 1 TO ids_varification.rowcount()
	ll_prac_id=ids_varification.object.prac_id[ll_i]
	//Start Code Change ----05.02.2008 #V8 maha - test for individual failure
	lb_failed = false
	for i = 1 to upperbound (is_failed_doc_id)
		if ids_varification.object.doc_id[ll_i] = is_failed_doc_id[i] then
			lb_failed = true
		end if
	next
	IF lb_failed = true then
		ls_note = " Send Error " + string(date(ldt_now))
		ids_varification.object.print_flag[ll_i] = NEEDS_PROCESSING
		// update the notes field
		IF isnull(ids_varification.object.notes[ll_i]) then
			ids_varification.object.notes[ll_i] = ls_NOTE
		ELSE
			ids_varification.object.notes[ll_i] = MidA(ids_varification.object.notes[ll_i] +' , '+ ls_NOTE ,1 , MAX_LENGTH )
		END IF
	ELSE		
		CHOOSE CASE ai_status
			CASE SUCCESS
			//Start Code Change ----04.30.2008 #V8 maha - changed message and added updates to sent fields
				ls_note = "Sent " + string(date(ldt_now))
				ids_varification.object.print_flag[ll_i] = AWAITING_RESPONSE
				// update the notes field
				IF isnull(ids_varification.object.notes[ll_i]) THEN
					ids_varification.object.notes[ll_i] = ls_NOTE
				ELSE 
					ids_varification.object.notes[ll_i] = MidA(ids_varification.object.notes[ll_i] +' , '+ ls_NOTE ,1 , MAX_LENGTH )
				END IF
				//update first sent
				IF isnull(ids_varification.object.first_sent[ll_i]) THEN
					ids_varification.object.first_sent[ll_i] = ldt_now
				END IF
				//update last sent
				ids_varification.object.last_sent[ll_i] = ldt_now
				//update attempts
				if isnull(  ids_varification.object.number_sent[ll_i]) then
					ids_varification.object.number_sent[ll_i] = 1
				else
					ids_varification.object.number_sent[ll_i] =  ids_varification.object.number_sent[ll_i] + 1
				end if
			CASE FAILURE
				ls_note = " Send failed " + string(date(ldt_now))
				ids_varification.object.print_flag[ll_i] = NEEDS_PROCESSING
				// update the notes field
				IF isnull(ids_varification.object.notes[ll_i]) then
					ids_varification.object.notes[ll_i] = ls_NOTE
				ELSE
					ids_varification.object.notes[ll_i] = MidA(ids_varification.object.notes[ll_i] +' , '+ ls_NOTE ,1 , MAX_LENGTH )
				END IF
			//End Code Change---04.30.2008
		END CHOOSE
	END IF
	IF (gb_AutoSchedule or ib_schedule) And IsValid(w_auto_schedule) THEN //Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
		//getfullname
		select full_name into:ls_fullname from v_full_name where  prac_id=:ll_prac_id;
		w_auto_schedule.inv_scheduler.of_log_schedule_verif(ii_sched_id, ls_fullname, ids_varification.Object.screen_id[ll_i], ids_varification.Object.reference_value[ll_i], ids_varification.Object.doc_id[ll_i],ls_note)
	END IF
NEXT

ids_varification.UPDATE()

return success
end function

public function integer of_open_progress_window ();
if upper(is_internet_inuse) <> "Y" then
   open(w_infodisp)
	//w_infodisp.center = true
	w_infodisp.height = 650
	w_infodisp.title = 'NPDB Interface Progress'  //Start Code Change ----08.29.2012 #V12 maha - modified title
	w_infodisp.st_information.BackColor	 = inv_color.buttonface
	w_infodisp.st_information.TextColor	  = inv_color.black
	w_infodisp.st_information.text = ''
	w_infodisp.st_information.x = 18
	w_infodisp.st_information.y = 448
	w_infodisp.st_information.width = 1765
	w_infodisp.st_information.height = 68
	
end if


return success
end function

public function integer of_create_reports ();

return success
end function

public function integer of_get_max_id_for_prac (long al_prac_id);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : of_get_max_id_for_prac
//==================================================================================================================
//  Purpose   	: Retrieves the max npdb_hdr_id for the pactitiner
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael Skinner  
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



long ll_npdb_hdr_id


select max(npdb_hdr_id)
into :ll_npdb_hdr_id
from npdb_hdr
where prac_id = :al_prac_id
;



return ll_npdb_hdr_id


end function

public function integer of_report_retrieve_ds (integer il_npdb_hdr_id);////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : of_report_retrieve_ds
//==================================================================================================================
//  Purpose   	: retries all of the datastore based on npdb_hdr_id
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael Skinner  
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

long ll_i
long ll_start, ll_used
long ll_upperbound
ll_start = Cpu()

ll_upperbound  =upperbound(ids_npdb_dws)

for ll_i = 1 to ll_upperbound
	ids_npdb_dws[ll_i].retrieve(il_npdb_hdr_id)
next

ll_used = Cpu() - ll_start

is_retreive_time =  "Data retrieval Time:" + STRING(ll_used/1000) + ' seconds'

return success
end function

private function integer of_report_filter (integer al_record_id);////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : OF_REPORT_FILTER
//==================================================================================================================
//  Purpose   	: FILTER ALL OF THE DATAWINDOWS BASED ON RECORD ID
//==================================================================================================================
//  Arguments 	: [integer] al_record_id
//==================================================================================================================
//  Returns   	: [long]     FAILURE/ SUCESS
//==================================================================================================================
//  Notes     	: IF THE DATAWINDOW HAS ONLY ONE ROW AND THE THE RECORD ID IS 1 THEN DO NOTHING
//==================================================================================================================
//  Created By	: Michael Skinner  
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


STRING FILTER = 'report_id'
LONG ll_i
LONG LL_UPPERBOUND
LL_UPPERBOUND = upperbound(ids_npdb_dws)
FOR ll_i = 1 TO LL_UPPERBOUND
	IF ids_npdb_dws[LL_I].rowcount() > 0  THEN
		IF ids_npdb_dws[LL_I].rowcount() = 1 AND ids_npdb_dws[LL_I].object.report_id[1] = 1 THEN
			// do nothing -- THIS IS 'HEADER' RECORD
		ELSE
			// filter the dw
			ids_npdb_dws[LL_I].setfilter('report_id = ' + string(AL_RECORD_ID)) 
			ids_npdb_dws[LL_I].filter()
		END IF
	END IF
NEXT

RETURN Success
end function

private function integer of_create_datastores (string as_type);////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : of_create_datastores
//==================================================================================================================
//  Purpose   	: open event
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael Skinner 
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


LONG ll_I
CHOOSE CASE as_type
	CASE 'REPORT'
			// GET THE UPPERBOUND
			
			ll_I = UPPERBOUND(Ids_report_dws) + 1
			Ids_report_dws[ll_i] = CREATE n_ds
			Ids_report_dws[ll_i].DataObject = 'd_npdb_report_master'
			Ids_report_dws[ll_i].insertrow(0)
	CASE ELSE
//		ids_dw_datatore.retrieve()
//		ids_dw_datatore.sort()
		// create the array of NPDB datastors
		FOR ll_I = 1 TO ids_dw_datatore.rowcount()
			ids_npdb_dws[ll_i] = CREATE n_ds
			ids_npdb_dws[ll_i].DataObject = ids_dw_datatore.getItemstring(ll_I, 'dw_name')
			ids_npdb_dws[ll_i].of_setTransObject(sqlca)
		NEXT

END CHOOSE

RETURN Success
end function

private function integer of_report_set_items (string as_report_code_type);////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PRIVATE]  : OF_REPORT_SET_ITEMS
//==================================================================================================================
//  Purpose   	: 
//==================================================================================================================
//  Arguments 	: [STRING]  al_report_code_type
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael Skinner  
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
LONG   LL_I             /* loop counter */
LONG   LL_J             /* loop counter */
LONG   ll_column_cnt
LONG   ll_column        /* master report datawindow column count */
LONG   ll_number_of_columns
LONG   ll_upperbound
long   ll_last_column /* the last column to be read in the datawindow*/

STRING ls_test
STRING ls_column_name, ls_column_prefix

ll_column_cnt = 1
// SET THE REPORT CODE TYPE

ids_report_dws[upperbound(ids_report_dws)].OBJECT.REPORT_TYPE_CODE[1] = as_report_code_type // used as a filter for the master report datawindow
//Start Code Change ----05.07.2008 #V8 maha - changes the legacy report to mmpr report
if as_report_code_type = "M" then
	ids_report_dws[upperbound(ids_report_dws)].OBJECT.REPORT_TYPE_CODE[1] = "P"
end if
// NEED TO WORK ON THIS MAYBEE
CHOOSE CASE adverse_action_report
	CASE  adverse_action_report
		   ids_report_dws[upperbound(ids_report_dws)].OBJECT.statement[1] = NPDB_STATEMENT
END CHOOSE 

ll_upperbound = upperbound(ids_npdb_dws)

FOR ll_i = 1 TO ll_upperbound
	if  ids_npdb_dws[ll_i].rowcount() > 0  then
				
		   	IF ids_npdb_dws[ll_i].dataobject <> 'd_npdb_hdr' THEN ll_last_column = 2
				IF ids_npdb_dws[ll_i].dataobject  = 'd_npdb_hdr' THEN ll_last_column  = 4
				
				ll_column = 2 // reset the coulum count with every new dw
				ll_number_of_columns = LONG(ids_npdb_dws[ll_i].Object.DataWindow.Column.Count)
				
				FOR LL_J = 1 TO ll_number_of_columns - ll_last_column
					// desriibe the column name
					ls_column_name   = ids_npdb_dws[ll_i].Describe("#" + string(ll_column) + ".Name")
					ls_column_prefix = ids_npdb_dws[ll_i].Object.DataWindow.Print.DocumentName
					if ls_column_prefix = "MMR" then ls_column_prefix = 'mmpr' //Start Code Change ----05.07.2008 #V8 maha
					ls_column_name = ls_column_prefix +'_'+ls_column_name
									
					TRY 
					ls_test = ids_npdb_dws[ll_i].getitemstring(1, ll_column) // THERE WILL BE ONLY ONE ROW
					CATCH (RunTimeError rte1)
									//MESSAGEBOX('',ls_column_name +' IS MISSING' )
					END TRY
					
					TRY //maha removed 05.07.08
					ids_report_dws[upperbound(ids_report_dws)].setItem(1, ls_column_name , ls_test )
					CATCH (RunTimeError rte)
						//MESSAGEBOX('',ls_column_name +' IS MISSING' )
					END TRY
					
					ll_column_cnt ++ // increment
					ll_column ++     // increment
								
				NEXT 
 	end if
NEXT

RETURN Success
end function

public function integer of_report_unfilter ();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : OF_REPORT_UNFILTER
//==================================================================================================================
//  Purpose   	: UNFILTER ALL OF THE DATAWINDOWS BASED ON RECORD ID
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     FAILURE/ SUCESS
//==================================================================================================================
//  Notes     	: IF THE DATAWINDOW HAS ONLY ONE ROW AND THE THE RECORD ID IS 1 THEN DO NOTHING
//==================================================================================================================
//  Created By	: Michael Skinner  
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


STRING FILTER = 'report_id'
LONG ll_i
LONG LL_UPPERBOUND 

LL_UPPERBOUND = upperbound(ids_npdb_dws)
FOR ll_i = 1 TO LL_UPPERBOUND
	ids_npdb_dws[LL_I].setfilter("") 
	ids_npdb_dws[LL_I].filter()
	
NEXT

RETURN Success


end function

public function integer of_create_database ();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : of_create_database
//==================================================================================================================
//  Purpose   	: This function contains all of the need information to create the table structor for the NPDB
//					  module
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael Skinner  Monday 10 January 2005
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
LONG   LL_I
long   ll_j
long ll_max


////////////////////////////////////////////////////////////////////////////////////////
// IF THE npdb_hdr EXISTS THEN GET OUT OF HERE!!!!
////////////////////////////////////////////////////////////////////////////////////////


if gs_dbtype = "ASA" then 

			select COUNT(*) 
			INTO :LL_i
			From systable 
			where table_name='npdb_hdr' and 
			table_type='BASE';
			
		
			if ll_i < 1  then 
				of_alter_database( )
				of_drop_tables( )
				of_create_tables( )
				of_insert_codes( )
				of_insert_codes2( )
				of_modify_code_lookup( )
				of_insert_new_error_codes( )
			end if
					
			
			////////////////////////////////////////////////////////////////////////////////////////
			// now chch to see if the new stuff exists
			////////////////////////////////////////////////////////////////////////////////////////
			
			select COUNT(*) 
			INTO :LL_i
			From systable 
			where table_name='npdb_itin' and 
			table_type='BASE';
			
			IF ll_i < 1 THEN 
				of_post_original_db_create()
			ELSE
				//RETURN 1
			END IF
			
			//------------------- APPEON BEGIN -------------------
			//$<add> Stephen 09.10.2012
			//$<reason>  V12.2 modify NPDB qrxs report
			select COUNT(*) 
			INTO :LL_i
			From systable 
			where table_name='npdb_qrxs_contact' and 
			table_type='BASE';
			
			IF ll_i < 1 THEN 
				of_insert_codes3( )			
			END IF
			//------------------- APPEON END -------------------
end if 


if gs_dbtype = "SQL" then
		n_cst_npdb_mss lnvo_mss
		lnvo_mss = CREATE n_cst_npdb_mss
 		lnvo_mss.of_create_npdb_mss_database(ls_sql_statments)
		of_alter_database( )
		of_insert_codes( )
		of_insert_codes2( )
		of_insert_codes3( )	//add by stephen 09.10.2012 --V12.2 modify NPDB qrxs report
		of_modify_code_lookup( )
end if 


// ADD IN THE VERSION NEW VERSION CHANGES
of_set_version_1_12( )

open(w_infodisp)
w_infodisp.title = 'DataBase Modification in progress'
w_infodisp.Center = TRUE
w_infodisp.st_complete.visible = false
w_infodisp.st_3.visible = false
w_infodisp.st_information.visible = false
w_infodisp.st_1.text = 'Mofifying Database Please stand by!'
w_infodisp.wf_set_min_max(1,upperbound(ls_sql_statments))
		 
FOR ll_i = 1 TO upperbound(ls_sql_statments)
		w_infodisp.st_1.text = 'Modification:' +string(ll_i) +' of '+ string(upperbound(ls_sql_statments)) +' Please stand by!'
    	 execute immediate :ls_sql_statments[LL_I] using sqlca;
		 IF LenA(sqlca.sqlerrtext) > 0 THEN
		//	messagebox(string(LL_I), string(sqlca.sqlerrtext)  + new_line + error.object + new_line +    string(ls_sql_statments[LL_I]) + new_line + "Please contact software vendor."   )
		END IF
		w_infodisp.wf_step_pbar(1)
NEXT

w_infodisp.st_1.text = 'Commiting modifications Please stand by!'

COMMIT USING SQLCA;

if LenA(sqlca.sqlerrtext) > 0 then
	   //messagebox('Database not updated',string(sqlca.sqlerrtext) + new_line + "Please contact software vendor.")
		//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
      inv_message.of_MessageBox('Database not updated',string(sqlca.sqlerrtext) + new_line + "Please contact software vendor.",true)
end if 

close(w_infodisp)

RETURN 1
end function

private function integer of_set_npdb_id ();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [private]   : of_set_npdb_id
//==================================================================================================================
//  Purpose   	: 
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael Skinner  
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

long ll_x,ll_k
long ll_max 

select max(npdb_hdr_id)
into :ll_max
from npdb_hdr;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// make sure there are no nulls
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


if isnull(ll_max) then 
	ll_max = 1
 else
  ll_max = ll_max +1
end if

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Update all of the datastores with the new hdr_id
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

									
if isvalid(w_infodisp) then w_infodisp.wf_set_min_max(1,upperbound(ids_npdb_dws) * 2)
for ll_x = 1 to upperbound(ids_npdb_dws)
   if isvalid(w_infodisp) then w_infodisp.wf_step_pbar(1)
 	  for ll_k = 1 to ids_npdb_dws[ll_x].rowcount()
		   ids_npdb_dws[ll_x].setitem(ll_k,1,ll_max)
	  next
next

return success // do not see a reason to any other
end function

private function integer of_update_database ();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [private]   : of_update_database
//==================================================================================================================
//  Purpose   	: open event
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael Skinner  
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

long ll_i

for ll_i = 1 to upperbound(ids_npdb_dws)
	if isvalid(w_infodisp) then w_infodisp.wf_step_pbar(1) 
	ids_npdb_dws[ll_i].update()
next


return success
end function

public function integer of_report_npdb (long al_prac_id, long al_npdb_id, string as_doc_id);////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : of_report_npdb(al_prac_id,al_npdb_id)
//==================================================================================================================
//  Purpose   	: 
//==================================================================================================================
//  Arguments 	: [Long]   al_prac_id
//  				: [long]   al_npdb_id --- not used at this time 
//             : [string] as_doc_id
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael Skinner  Wednesday 14 February 2005
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
LONG    ll_array
LONG    ll_max_npdb_hdr_id
LONG    ll_report_number[]
LONG    ll_i               /* loop counter */
LONG    ll_j               /* loop counter */
LONG    LL_K					/* loop counter */
LONG    ll_record_id
LONG    LL_UPPERBOUND
LONG    LL_ROWCOUNT
long ll_report_id 
long    LL_ROWCOUNT2
STRING  ls_report_types[]
STRING  LS_REPORT_CODE
datastore lds_blank[]
SetCapture(Handle(this)) // keeps the hourglass solid
SetPointer(hourglass!)
// blank out the current info
Ids_report_dws = lds_blank
// create the datastors
of_create_datastores('')

//if isnull(al_npdb_id) then
//   ll_max_npdb_hdr_id = of_get_max_id_for_prac(as_doc_id)
//else
//	ll_max_npdb_hdr_id = al_npdb_id
//end if
// GET THE ll_max_npdb_hdr_id FOR THE DOC_ID

ll_max_npdb_hdr_id = of_get_npdb_hdr_id(as_doc_id)
//debugbreak()	
IF (NOT ll_max_npdb_hdr_id = 0 OR NOT isnull(ll_max_npdb_hdr_id)) THEN
	of_report_retrieve_ds(ll_max_npdb_hdr_id)
	// now look at the qsrd record set see what the reoprts are that need to be processed
	LL_UPPERBOUND = upperbound(ids_npdb_dws)
	FOR ll_i = 1 TO LL_UPPERBOUND
		IF ids_npdb_dws[ll_i].dataobject =  'd_npdb_qrsd' THEN
			// only use the non-legacy records
			LL_ROWCOUNT = ids_npdb_dws[ll_i].rowcount()
			choose case LL_ROWCOUNT
				case is > 0
					FOR ll_j = 1 TO LL_ROWCOUNT
						ll_record_id =ids_npdb_dws[ll_i].OBJECT.report_id[LL_j]
						LS_REPORT_CODE = ids_npdb_dws[ll_i].object.report_type_cd[ll_j]
								
						 CHOOSE CASE LS_REPORT_CODE
							CASE ADVERSE_ACTION_REPORT, JUDJEMENT_OR_CONVICTION_REPORT, MEDICAL_MALPRACTICE_PAYMENT_REPORT , '', "A", "M"
								 // filter out the records
								 OF_CREate_datastores('REPORT')
								 
								 LL_ROWCOUNT2 = ids_npdb_dws[ll_i].ROWCOUNT()
								 FOR LL_K = 1 TO LL_ROWCOUNT2
									  // filter out the records
									  OF_REPORT_FILTER(ll_record_id)
									  // set the items
									  OF_REPORT_SET_ITEMS(LS_REPORT_CODE)
								 NEXT
								 OF_REPORT_UNFILTER( )
							CASE ELSE
										//
						 END CHOOSE							
							 
					NEXT // ll_j = 1 TO ids_npdb_dws[ll_i].rowcount()
							//EXIT
							
							
				case 0 // there is not ADVERSE_ACTION_REPORT, JUDJEMENT_OR_CONVICTION_REPORT, MEDICAL_MALPRACTICE_PAYMENT_REPORT reports
					FOR ll_i = 1 TO LL_UPPERBOUND
						IF ids_npdb_dws[ll_i].dataobject =  'd_npdb_hdr' THEN
							if ids_npdb_dws[ll_i].rowcount() > 0 then
								long ll_a	
								ll_a = UPPERBOUND(Ids_report_dws) + 1
								Ids_report_dws[ll_a] = CREATE n_ds
								Ids_report_dws[ll_a].DataObject = 'd_npdb_report_master_no_report_found'
								Ids_report_dws[ll_a].insertrow(0)
								
								ll_report_id = ids_npdb_dws[ll_i].object.report_id[1]
													
								OF_REPORT_FILTER(ll_report_id)
								OF_REPORT_SET_ITEMS('')				
							   end if 
						end if 
					next 
						
						
					continue
						
				end choose
			END IF // IF ids_npdb_dws[ll_i].dataobject =  'd_npdb_qrsd' THEN
		NEXT //ll_i = 1 TO upperbound(ids_npdb_dws)
		
		
			///////////////////////////////////////////////////////////////////////////////////////
			// !!!!!!!!!!!!!!!!!!!  HACK ALERT !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
			//  ThE enty tag does not come back for 'no report records' - set the entity name get the facility
			// name for that practitioner.
			///////////////////////////////////////////////////////////////////////////////////////
		
			if not f_validstr(Ids_report_dws[upperbound(Ids_report_dws)].GetItemstring(1,'enty_entity_nm' )) Then
			// parse out the then doc id
			string ls_parse_arrray[]
			string ls_facility
			string ls_fac_id
			string ls_cert_phone
			string ls_cert_title
			string ls_cert_ext  
			string ls_cred_contact_name
			string ls_title  
			
			inv_string.of_parsetoarray(as_doc_id, '-',ls_parse_arrray)
			
			ls_fac_id = ls_parse_arrray[3]
			
//			SELECT "facility"."facility_name"  
//			INTO :ls_facility  
//			FROM "facility"  
//			WHERE "facility"."facility_id" = :ls_fac_id   
//			 ;
			 
			 SELECT facility.facility_name ,
			        facility.npdb_cert_phone,   
					  facility.npdb_cert_title,   
					  facility.npdb_cert_ext,   
					  facility.npdb_cert_NAME,   
					  facility.credentialing_contact_title  
				 INTO :ls_facility,
				      :ls_cert_phone,   
						:ls_cert_title,   
						:ls_cert_ext,   
						:ls_cred_contact_name,   
						:ls_title  
				 FROM facility  
				WHERE facility.facility_id = :ls_fac_id  ;
			
			Ids_report_dws[upperbound(Ids_report_dws)].setItem(1,'enty_entity_nm',ls_facility )
			Ids_report_dws[upperbound(Ids_report_dws)].setItem(1,'cert_phone',ls_cert_phone )
			Ids_report_dws[upperbound(Ids_report_dws)].setItem(1,'cert_nm',ls_cred_contact_name )
			Ids_report_dws[upperbound(Ids_report_dws)].setItem(1,'cert_title',ls_cert_title )
			Ids_report_dws[upperbound(Ids_report_dws)].setItem(1,'cert_ext',ls_cert_ext )
				
			// also then CERT record does not come back
END IF //IF (NOT ll_max_npdb_hdr_id = 0 OR NOT isnull(ll_max_npdb_hdr_id)) THEN
	
end if 



ReleaseCapture() // release the hourglass

return success
end function

public function long of_get_npdb_hdr_id (string as_doc_id);/******************************************************************************************************************
**  [PUBLIC]   : of_get_npdb_hdr_id( /*string as_doc_id */)
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [string]  as_doc_id
**==================================================================================================================
**  Returns   	: [long]   The max npdb_hdr_id header id for the docid
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  today()
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

 
long ll_hdr_id
 
SELECT max(npdb_hdr.npdb_hdr_id)
INTO :ll_hdr_id  
FROM npdb_hdr  
WHERE npdb_hdr.doc_id = :as_doc_id;


return ll_hdr_id
end function

protected subroutine of_set_error_message (string as_message);is_err_mess[upperbound(is_err_mess) + 1] =  as_message
end subroutine

public function integer of_set_post_import_status ();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : of_set_post_import_status
//==================================================================================================================
//  Purpose   	: this function will go through all of the doc_ids and update the varification info table
//               based on the QRSD table
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael B. Skinner  
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

LONG   ll_i,ll_k
LONG   ll_npdb_hdr_id
LONG   ll_report_id
LONG   ll_found_row
long   ll_z,ll_qsta_position
long ll_hdr_array[] //maha 050108
long q
long ll_trc
integer li_rcnt[]
//STRING ls_doc_id[]
STRING ls_blank_array[]
STRING ls_err_cd
STRING ls_result_indicator
string ls_note_string
datetime ldt_server
long ll_lookup_code

ldt_server = of_get_server_datetime( )

// clear out any error messages
is_err_mess[] = ls_blank_array[]

// filter lookup datawindow
ids_lookup_code.setfilter('npdb_list = list_q' )
ids_lookup_code.filter()

/////////////////////////////////////////////////////////////////
// GET THE DOC IDS FROM CUSE RECORD
/////////////////////////////////////////////////////////////////
// position 24 = ll_hdr_position
// position 49 = d_npdb_qsta

for ll_z = 1 to upperbound(ids_npdb_dws)
	if ids_npdb_dws[ll_z].dataobject = 'd_npdb_qsta' then
		ll_qsta_position = ll_z
	end if
next

for ll_i =1 to ids_npdb_dws[ll_hdr_position].rowcount()
	is_doc_id[ll_i] = ids_npdb_dws[ll_hdr_position].object.doc_id[ll_i]
	ll_hdr_array[ll_i] =  ids_npdb_dws[ll_hdr_position].object.npdb_hdr_id[ll_i] //maha 050108
NEXT

// RETRIEVE THE VERIFICATON INFO
ids_varification.RETrieve(is_doc_id)
ll_trc =ids_tracker_by_doc_id.retrieve(is_doc_id)

// get the doc_ids from the CUSE record header ds is 24
for ll_i =1 to ids_npdb_dws[ll_hdr_position].rowcount()	
	ll_npdb_hdr_id =  ll_hdr_array[ll_i]

	  //now look a the QSTA record to see if there are any rejections
	ids_npdb_dws[ll_qsta_position].setfilter('npdb_hdr_id =' +  STRING(ll_npdb_hdr_id) )
	ids_npdb_dws[ll_qsta_position].filter()
	ids_tracker_by_doc_id.setfilter('npdb_hdr_id =' +  STRING(ll_npdb_hdr_id) )
	ids_tracker_by_doc_id.filter()
	
	if ids_npdb_dws[ll_qsta_position].rowcount() < 1  then continue
	  // get the rejections for message
	//for q = 1 to ids_npdb_dws[ll_qsta_position].rowcount() 
	ls_err_cd = ids_npdb_dws[ll_qsta_position].object.err_cd[1]
	ls_result_indicator = ids_npdb_dws[ll_qsta_position].object.query_result_ind[1]
	li_rcnt[1] = integer(ids_npdb_dws[ll_qsta_position].object.nbr_reports[1])

	if LenA(ls_err_cd) > 0 then  //write error messages to message
		ll_found_row = ids_npdb_dws[ll_qsta_position].find("npdb_list_code = '" + ls_err_cd + "'",1, ids_npdb_dws[ll_qsta_position].rowcount() )
		if ll_found_row > 0 then
			//is_err_mess[UPPERBOUND(is_err_mess) + 1 ] = 'NPDB REJECTION: ' +  ids_lookup_code.OBJECT.npdb_list_code_description[ll_found_row]
			is_err_mess[UPPERBOUND(is_err_mess) + 1 ] = 'NPDB REJECTION: ' +  ls_err_cd + " - " + ids_lookup_code.OBJECT.npdb_list_code_description[ll_found_row]   //Start Code Change ----03.24.2015 #V15 maha - added code
		end if 
	end if 
	//next
      // get the matching reports
		
	ll_found_row = ids_varification.find("doc_id = '" + is_doc_id[1]  + "'",1, ids_varification.rowcount() )	
	IF ll_found_row > 0 then
		if LenA(ls_err_cd) > 1 then  //got an error
			ls_note_string = 'NPDB error ' + ls_err_cd
			if isnull(ids_varification.object.notes[ll_found_row]) then
				ids_varification.object.notes[ll_found_row] = ls_note_string
			else
			   ids_varification.object.notes[ll_found_row] = ids_varification.object.notes[ll_found_row] +' , '+ ls_note_string
		  	end if

			 ids_varification.object.print_flag[ll_found_row] = 1 //Start Code Change ----05.05.2008 #V8 maha - on error reset the print flag so it can be resent
	
		//make a note how many reports on the note field
		elseif li_rcnt[1] > 0 then  //got reports
			if isnull(ids_varification.object.notes[ll_found_row]) then
				ids_varification.object.notes[ll_found_row] = string(li_rcnt[1]) +' NPDB report(s) found' 
			else
				ids_varification.object.notes[ll_found_row] = ids_varification.object.notes[ll_found_row] +' , '+ string(li_rcnt[1]) +' NPDB report(s) found' 
			end if

		else // no reports found for this doc_id
			// update the verification record
			ll_lookup_code = long(gnv_data.of_getitem("code_lookup","lookup_code","lookup_name = 'Credentials Verification Response' and code = 'ND'"))
			ids_varification.object.response_code[ll_found_row] = ll_lookup_code
			ids_varification.object.date_recieved[ll_found_row] = ldt_server
			ids_varification.object.user_name[ll_found_row] = gs_user_id //Start Code Change ----05.09.2008 #V8 maha - added user set -- 05.09.2008 #V8 maha - corrected field name from user_id
			if isnull(ids_varification.object.notes[ll_found_row]) then
				ids_varification.object.notes[ll_found_row] = 'No NPDB reports found-' + string(date(ldt_server))
			else
			   ids_varification.object.notes[ll_found_row] = ids_varification.object.notes[ll_found_row] +' , '+ 'No NPDB reports found-' + string(date(ldt_server))
		  	end if
		end if
	END IF
	//update filtered tracker record

	if ids_tracker_by_doc_id.rowcount() > 0 then 
		if LenA(ls_err_cd) > 0 then  //got an error
			ids_tracker_by_doc_id.object.cust_3[ll_i] = ls_err_cd
			ids_tracker_by_doc_id.object.rec_cnt[ll_i] = -1
		else //no error set rep count and recieve date
			ids_tracker_by_doc_id.object.rec_cnt[ll_i] = li_rcnt[1] // report count
			ids_tracker_by_doc_id.object.cust_3[ll_i] = "C00"  //Start Code Change ----05.05.2008 #V8 maha - reset error code
		end if	
		ids_tracker_by_doc_id.object.r_date[ll_i] = ldt_server
	end if
	
next //hdr record

ids_varification.update()
ids_tracker_by_doc_id.update()

//FileDelete (is_files[3])


return success








//@@@@@@@@ org code 050108 @@@@@@@@@@@
/*
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : of_set_post_import_status
//==================================================================================================================
//  Purpose   	: this function will go through all of the doc_ids and update the varification info table
//               based on the QRSD table
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael B. Skinner  
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

LONG   ll_i,ll_k
LONG   ll_npdb_hdr_id
LONG   ll_report_id
LONG   ll_found_row
long   ll_z,ll_qsta_position
long ll_hdr_array[] //maha 050108
long q
integer li_rcnt[]
//STRING ls_doc_id[]
STRING ls_blank_array[]
STRING ls_err_cd
STRING ls_result_indicator

// clear out any error messages
is_err_mess[] = ls_blank_array[]

// filter lookup datawindow
ids_lookup_code.setfilter('npdb_list = list_q' )
ids_lookup_code.filter()

/////////////////////////////////////////////////////////////////
// GET THE DOC IDS FROM CUSE RECORD
/////////////////////////////////////////////////////////////////
// position 24 = ll_hdr_position
// position 49 = d_npdb_qsta

for ll_z = 1 to upperbound(ids_npdb_dws)
				if ids_npdb_dws[ll_z].dataobject = 'd_npdb_qsta' then
					ll_qsta_position = ll_z
				end if
next

for ll_i =1 to ids_npdb_dws[ll_hdr_position].rowcount()
	is_doc_id[ll_i] = ids_npdb_dws[ll_hdr_position].object.doc_id[ll_i]
	ll_hdr_array[ll_i] =  =  ids_npdb_dws[ll_hdr_position].object.npdb_hdr_id[ll_i] //maha 050108
NEXT

// RETRIEVE THE VERIFICATON INFO
ids_varification.RETrieve(is_doc_id)

ids_tracker_by_doc_id.retrieve(is_doc_id)

long lll
lll = ids_tracker_by_doc_id.rowcount()

// get the doc_ids from the CUSE record header ds is 24
for ll_i =1 to ids_npdb_dws[ll_hdr_position].rowcount()
	// ll_npdb_hdr_id =  ids_npdb_dws[ll_hdr_position].object.npdb_hdr_id[ll_i]
	ll_npdb_hdr_id =  ll_hdr_array[ll_i]
	//ll_report_id   =  ids_npdb_dws[ll_hdr_position].object.report_id[ll_i]
	//  is_doc_id[upperbound(is_doc_id) + 1]   =  ids_npdb_dws[ll_hdr_position].object.doc_id[ll_i] //@@@@ seems redundant 050108
 	  
	  //now look a the QSTA record to see if there are any rejections
	  ids_npdb_dws[ll_qsta_position].setfilter('npdb_hdr_id =' +  STRING(ll_npdb_hdr_id) )
	  ids_npdb_dws[ll_qsta_position].filter()
	  // get the rejections
	for q = 1 to ids_npdb_dws[ll_qsta_position].rowcount() 
			  ls_err_cd = ids_npdb_dws[ll_qsta_position].object.err_cd[q]
			  ls_result_indicator = ids_npdb_dws[ll_qsta_position].object.query_result_ind[q]
			  if len(ls_err_cd) > 0 then
				 ll_found_row = ids_npdb_dws[ll_qsta_position].find("npdb_list_code = '" + ls_err_cd + "'",1, ids_npdb_dws[ll_qsta_position].rowcount() )
				 if ll_found_row > 0 then
		       		  is_err_mess[UPPERBOUND(is_err_mess) + 1 ] = 'NPDB REJECTION: ' +  ids_lookup_code.OBJECT.npdb_list_code_description[ll_found_row]
				 end if
			  end if 
	next
      // get the matching reports
	if ids_npdb_dws[ll_qsta_position].rowcount() > 0 then
			ll_found_row = ids_varification.find("doc_id = '" + is_doc_id[1]  + "'",1, ids_varification.rowcount() )
		   
			if not isnull(ids_npdb_dws[ll_qsta_position].object.nbr_reports[1]) or len(ls_err_cd) < 0 then
						 //make a note how many reports on the note field
						 string ls_note_string
						 
						 if ll_found_row > 0 then
							//if len(ls_err_cd) > 0 then
		       			 ls_note_string = ''
							 if isnull(ids_varification.object.notes[ll_found_row]) then
								 ids_varification.object.notes[ll_found_row] = string(ids_npdb_dws[ll_qsta_position].object.nbr_reports[1]) +' NPDB reports found' 
								 else
								 ids_varification.object.notes[ll_found_row] = ids_varification.object.notes[ll_found_row] +' , '+ string(ids_npdb_dws[ll_qsta_position].object.nbr_reports[1]) +' NPDB reports found' 
							 end if
							// end if
						 end if
			else // no reports found for this doc_id
						long ll_lookup_code
						// update the varification record
						select code_lookup.lookup_code
						into : ll_lookup_code
						from code_lookup
						where code_lookup.lookup_name = 'Credentials Verification Response' and
								code_lookup.code = 'ND';
								
						ids_varification.object.response_code[ll_found_row] = ll_lookup_code
						if ll_found_row > 0 then
							if isnull(ids_varification.object.notes[ll_found_row]) then
								ids_varification.object.notes[ll_found_row] = 'No NPDB reports found' 
							else
							   ids_varification.object.notes[ll_found_row] = ids_varification.object.notes[ll_found_row] +' , '+ 'No NPDB reports found' 
						   end if
						end if
				
			end if
			
    	end if 
	
next //ll_i =1 to ids_npdb_dws[24].rowcount()

// update the tracker
datetime ldt_server
ldt_server = of_get_server_datetime( )

for ll_i = 1 to ids_tracker_by_doc_id.rowcount()
	ids_tracker_by_doc_id.object.r_date[ll_i] = ldt_server // recieve date
	ids_tracker_by_doc_id.object.c_date[ll_i] = ldt_server // completed date
next

ids_varification.update()
ids_tracker_by_doc_id.update()

//FileDelete (is_files[3])


return success

*/
end function

private function integer of_set_tracker_export_id (string as_doc_ids[]);////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : n_cst_npdb::of_set_tracker_export_id
//==================================================================================================================
//  Purpose   	: Update the tracker export_id (PK)
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long] success/failure     
//==================================================================================================================
//  Notes     	: 	   called from of_send
//==================================================================================================================
//  Created By	: Michael Skinner  
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

long ll_max_id
long ll_i
long ll_found
long ll_current_row
long i //maha 050208
datetime ldt
string ls_array[]
long ll_j
string ls_array2[]
integer itest

ldt = OF_GET_server_datetime( )      // SUBMISSION DATE TIME
//debugbreak()
itest = upperbound(as_doc_ids)
if upperbound(as_doc_ids) = 0 or isnull(as_doc_ids) then return -1  //Start Code Change ----06.04.2008 #V81 maha - added trap

datastore lds
lds = CREATE Datastore
lds.dataobject = 'd_ids'
lds.settransobject( sqlca)
lds.retrieve( )

ids_tracker_by_doc_id.retrieve(as_doc_ids)

ll_max_id = lds.object.export_id[1]

for ll_i = 1 to upperbound(as_doc_ids)
	    
       ll_found = ids_tracker_by_doc_id.Find("doc_id = '" + as_doc_ids[ll_i] + "'" , 1, ids_tracker_by_doc_id.RowCount())			
	 if ll_found > 0 then
		lnv_string.of_ParseToArray ( as_doc_ids[ll_i], '-', ls_array )
		ids_tracker_by_doc_id.OBJECT.user_id[ll_found]     = gs_user_id 
       	ids_tracker_by_doc_id.OBJECT.s_date[ll_found] = ldt
		ids_tracker_by_doc_id.OBJECT.file_name[ll_found]      = as_doc_ids[ll_i] 	//Start Code Change ----05.05.2008 #V8 maha
		// set the proper satus for each file			
		for ll_j = 1 to upperbound(is_fac_id_status)
			lnv_string.of_ParseToArray ( is_fac_id_status[ll_j], ',', ls_array2 )
			if UpperBound(ls_array) >= 3 and UpperBound(ls_array2) >= 2 then					//Added by Scofield on 2008-07-15
				if long(ls_array[3]) = long(ls_array2[1]) then
					ids_tracker_by_doc_id.OBJECT.cust_3[ll_found]      = ls_array2[2]
				end if
			end if
		next		
	else 
		lnv_string.of_ParseToArray ( as_doc_ids[ll_i], '-', ls_array )
		if long(ls_array[3]) <> 0 then // found zeros in old db file
			ll_max_id ++
			//Start Code Change ----05.02.2008 #V8 maha
			for i = 1 to upperbound(is_failed_doc_id)
				if as_doc_ids[ll_i] = is_failed_doc_id[i] then //is the docid is in the failed don't create tracker record
					continue
				end if
			next
			//End Code Change---05.02.2008
			ll_current_row = ids_tracker_by_doc_id.insertrow(0)
			ids_tracker_by_doc_id.object.export_id[ll_current_row]   = ll_max_id
			ids_tracker_by_doc_id.OBJECT.user_id[ll_current_row]     = gs_user_id 
			ids_tracker_by_doc_id.OBJECT.file_name[ll_current_row]      = as_doc_ids[ll_i] // THE DOC ID
			ids_tracker_by_doc_id.OBJECT.doc_id[ll_current_row]      = as_doc_ids[ll_i] // THE DOC ID  //Start Code Change ----05.08.2008 #V8 maha - aded doc id as well as the file name which is the same value.
			ids_tracker_by_doc_id.OBJECT.PRAC_id[ll_current_row]     = long(ls_array[2])      // THE PRAC_ID
			ids_tracker_by_doc_id.OBJECT.facility_id[ll_current_row] = long(ls_array[3]) 
			ids_tracker_by_doc_id.OBJECT.s_date[ll_current_row]      = ldt
//debugbreak()				
				// set the proper satus for each file
			for ll_j = 1 to upperbound(is_fac_id_status)
				lnv_string.of_ParseToArray ( is_fac_id_status[ll_j], ',', ls_array2 )
					if UpperBound(ls_array2) >= 2 then			//Added by Scofield on 2008-07-15
						if long(ls_array[3]) = long(ls_array2[1]) then
							ids_tracker_by_doc_id.OBJECT.cust_3[ll_current_row]      = ls_array2[2]
						end if
					end if
			next //status
		end if //<> 0
	 end if	  //found
next //docid
		

lds.object.export_id[1] = ll_max_id

// update the verifications 

ids_tracker_by_doc_id.update( )

lds.update()

return success
end function

public function integer of_start_npdb (string as_process, long al_prac_id, long al_npdb_id, string as_doc_id, u_dw adw);////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : of_start_npdb
//==================================================================================================================
//  Purpose   	: opening to the process
//==================================================================================================================
//  Arguments 	: [string]  the process recieve/ send 
//               [adw] the datawindow with the doc_ids
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael Skinner  Tuesday February 01 2005
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



long   ll_i
string ls_doc_ids[]
//n_cst_array lnvo_array
any aa_any[] /* used to reset arrays  */
string ls_facility_field  //maha 09.11.2012

if not ib_initialize  then 
	of_display_error()
   return failure
end if


// reset the report datastore 
aa_any = ids_report_dws

SetCapture(Handle(this)) // keeps the hourglass solid
SetPointer(hourglass!)

// set the current process neeed for of_check_status
is_process = as_process

CHOOSE CASE TRIM(UPPER(as_process))
//SEND
	CASE IS_Send
		// GET ALL OF THE DOC_ID THAT 'NEED PROCESS'

		CHOOSE CASE adw.dataobject
			//CASE 'd_ver_sum_records_for_exp_app_npdb' 
			//CASE 'd_ver_sum_records_for_exp_app_npdb', 'd_ver_summary_record_view_for_ai_all' //scheduler , action items
			CASE 'd_ver_sum_records_for_exp_app_npdb', 'd_ver_summary_record_view_for_ai_all', 'd_ver_summary_record_view_for_sched' //Modified by Appeon long.zhang 01.14.2015 (Allegheny Scheduler)	
				FOR ll_i = 1 to adw.rowcount()
					IF adw.object.selected[ll_i] = 1 THEN
						ls_doc_ids[upperbound(ls_doc_ids) + 1] = adw.object.doc_id[ll_i]
					END IF
				NEXT 
			
		   CASE 'd_ver_summary_record_view_browse'  //practitioner folder
				long ll_found
				adw.accepttext()
       			 ll_found = adw.Find("verification_method = " + string(OF_GET_NPDB_QUERT_CODE()) ,  1, adw.RowCount())
				IF ll_found > 0 THEN
				  ls_doc_ids[upperbound(ls_doc_ids) + 1] = adw.object.doc_id[ll_found]
			   END IF
//				//ll_found = adw.GetSelectedRow(0)
//				IF ll_found > 0 THEN
//				  ls_doc_ids[upperbound(ls_doc_ids) + 1] = adw.object.doc_id[ll_found]
//			   END IF
				
	      CASE ELSE
				 RETURN failure
				
		end choose
			
		// set display information
    		of_open_progress_window( )
		IF isvalid(w_infodisp) THEN w_infodisp.wf_set_min_max(1,upperbound(ls_doc_ids))
		IF isvalid(w_infodisp) THEN w_infodisp.st_1.text = 'Sending Practitioner Information to NPDB ' + "(" +string(upperbound(ls_doc_ids)) + ")"
		
		IF upperbound(ls_doc_ids) > 0 THEN
			//debugbreak()
			of_send(ls_doc_ids)
		ELSE
			 is_err_mess[upperbound(is_err_mess) + 1 ] = 'There are no records to send to the NPDB for processing.'
		END IF
//RECEIVE		 		 
	CASE IS_Recieve
		ib_recieving = true
		// GET ALL OF THE DOC_ID THAT 'AWAITING'
		CHOOSE CASE adw.dataobject
			//CASE 'd_ver_sum_records_for_exp_app_npdb', 'd_ver_summary_record_view_for_ai_all' //scheduler , action items
			CASE 'd_ver_sum_records_for_exp_app_npdb', 'd_ver_summary_record_view_for_ai_all', 'd_ver_summary_record_view_for_sched' //Modified by Appeon long.zhang 01.14.2015 (Allegheny Scheduler)	
				ls_facility_field = "verif_info_facility_id"
			CASE 'd_ver_summary_record_view_browse'  //practitioner folder
				ls_facility_field = "facility_id"	
			END choose
		//need to get facility for properties file
		 //Start Code Change ----09.10.2012 #V12 maha - we will process based on the facility of the first record	
		is_current_facility_id = string(adw.getitemnumber(1, ls_facility_field))
 		ids_npdb_fac_info.retrieve(gs_user_id)
		ll_i =  ids_npdb_fac_info.setfilter( "facility_id = " + is_current_facility_id  )
		if ll_i < 0 then messagebox("of_start_npdb", "failure of facility filter")
		ids_npdb_fac_info.filter()
		 //End Code Change ----09.10.2012  
		 
		 of_open_progress_window( )
		IF isvalid(w_infodisp) THEN w_infodisp.st_1.text = 'Receiving Practitioner Information from NPDB '
		choose case il_Interface
			case ITP_INTERFACE
				of_recieve()
			case QRXS_INTERFACE //Add by Evan 12.01.2009 (V10.1 - NPDB QRXS)
				of_recieve_qrxs()
			case else
				Return FAILURE
		end choose
		
	CASE  is_report // REPORT	  
  		  of_open_progress_window( )
		  w_infodisp.st_1.text = 'Creating NPDB Reports - Please stand by.'
		  w_infodisp.title = 'NPDB Reports'
		  w_infodisp.st_information.visible = false
		  of_report_npdb(al_prac_id,al_npdb_id,as_doc_id)
		 
	CASE ELSE
		//messagebox('Process Not found', 'Process: ' + as_process )
		is_err_mess[upperbound(is_err_mess) + 1 ] = 'Process Not found : ' + as_process
END CHOOSE

COMMIT USING SQLCA;

// CONCATINATE MESSAGES THAT ARE NOT ERRORS
if not ib_process_failed then
	for ll_i = 1 to  upperbound(is_messsages)
		OF_set_error_message(is_messsages[ll_i])
	next
end if
// blank out the message array - just for safety sake
is_messsages = is_blank

of_display_error()

IF isvalid(w_infodisp) THEN close(w_infodisp)

ReleaseCapture() // release the hourglass

RETURN success

end function

private function integer of_get_npdb_quert_code ();/******************************************************************************************************************
**  [PUBLIC]   : OF_GET_NPDB_QUERT_CODE
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner MONDAY 04  APRIL 2005
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

LONG LL_LOOKUP_CODE

SELECT LOOKUP_CODE 
INTO :LL_LOOKUP_CODE
FROM CODE_LOOKUP
WHERE LOOKUP_NAME = 'Verification Method' AND CODE = 'NPDB Query'
USING SQLCA;

RETURN LL_LOOKUP_CODE
end function

public function integer of_move_jar ();/******************************************************************************************************************
**  [PUBLIC]   : of_move_jar( )
**==================================================================================================================
**  Purpose   	: moved the jar file to the current version of the JRE
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  today()
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
constant string JAR_LOCATION = '\lib\ext\'
long ret,ll_return
string ls_notify[]
string ls_current_version,ls_java_home
string ls_src_path //alfee 03.13.2014
ll_return = success

// get the current version of the JRE
//RegistryGet("HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java Runtime Environment", "CurrentVersion", RegString!, ls_current_version)
// get javahome
//RegistryGet("HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java Runtime Environment\" + ls_current_version , "JavaHome", RegString!, ls_java_home)

choose case il_Interface
	case ITP_INTERFACE
		IF NOT FileExists ( is_current_path + "\itp\itp.jar") THEN 
			//---------Begin Modified by (Appeon)Alfee 03.13.2014 ---------------- -------------------
			ls_src_path = is_current_path + "\jarfiles"
			IF NOT FileExists ( ls_src_path + "\itp.jar" ) THEN ls_src_path = Gs_Current_Directory + "\Drivers\ITP"			

			ret = FileCopy ( ls_src_path + "\itp.jar"  ,  is_current_path + "\itp\itp.jar" )
			ret = FileCopy ( ls_src_path + "\commons-logging.jar"  , is_current_path + "\itp\commons-logging.jar")
			ret = FileCopy ( ls_src_path + "\commons-httpclient-2.0.jar"  , is_current_path + "\itp\commons-httpclient-2.0.jar")
			ret = FileCopy ( ls_src_path + "\commons-fileupload-1.0.jar"  , is_current_path + "\itp\commons-fileupload-1.0.jar")			
			/*ret = FileCopy ( is_current_path + "\jarfiles\itp.jar"  ,  is_current_path + "\itp\itp.jar" )
			ret = FileCopy ( is_current_path + "\jarfiles\commons-logging.jar"  , is_current_path + "\itp\commons-logging.jar")
			ret = FileCopy ( is_current_path + "\jarfiles\commons-httpclient-2.0.jar"  , is_current_path + "\itp\commons-httpclient-2.0.jar")
			ret = FileCopy ( is_current_path + "\jarfiles\commons-fileupload-1.0.jar"  , is_current_path + "\itp\commons-fileupload-1.0.jar")*/
			//---------End Modifid ----------------------------------------------------------------------------	
			choose case ret
				case 1
					// success
				case -1 					
					is_messsages[upperbound(is_messsages) + 1] = 'The ITP Jar file is missing. Please contact IntelliSoft Support for assistance.'
					//messagebox('ITP JAR File Error','The ITP Jar file is missing. Please contact IntelliSoft Support for assistance.')
				case -2
					//Error writing targetfile
					is_messsages[upperbound(is_messsages) + 1] = 'The ITP Jar file Can not be copied. Contact your System Administrator to check your permissions on the directory : ' + ls_java_home +  JAR_LOCATION + "itp.jar"
					//messagebox('ITP JAR File Error','The ITP Jar file Can not be copied. Contact your System Administrator to check your permissions on the directory : ' + ls_java_home +  JAR_LOCATION + "itp.jar")
				case else
					// unknown error
					is_messsages[upperbound(is_messsages) + 1] = "An unknown error has occurred while copying the jar file. Contact IntelliSoft Support for assistance."
					//messagebox('ITP JAR File Error','An unknown error has occurred while copying the jar file. Contact IntelliSoft Support for assistance.')
			end choose
			if ret <> 1 then				
				ls_notify[1] = "maha@intelliSoftGroup.com"
				of_mail_error('ITP Interface', 'The jar file could not be copied', ls_notify)
				ll_return = failure
			end if
		END IF
	case QRXS_INTERFACE //Add by Evan 11.18.2009 (V10.1 - NPDB QRXS)
		if not FileExists(is_current_path + "\qrxs\qrxs-v1_05.jar") then
			//---------Begin Modified by (Appeon)Alfee 03.13.2014 ---------------- -------------------
			ls_src_path = is_current_path + "\qrxsjarfiles"
			IF NOT FileExists ( ls_src_path + "\qrxs-v1_05.jar" ) THEN ls_src_path = Gs_Current_Directory + "\Drivers\QRXS"			

			ret = FileCopy(ls_src_path + "\qrxs-v1_05.jar", is_current_path + "\qrxs\qrxs-v1_05.jar")
			ret = FileCopy(ls_src_path + "\commons-codec-1.3.jar", is_current_path + "\qrxs\commons-codec-1.3.jar")
			ret = FileCopy(ls_src_path + "\commons-fileupload-1.1.jar", is_current_path + "\qrxs\commons-fileupload-1.1.jar")
			ret = FileCopy(ls_src_path + "\commons-httpclient-2.0.jar", is_current_path + "\qrxs\commons-httpclient-2.0.jar")
			ret = FileCopy(ls_src_path + "\commons-logging.jar", is_current_path + "\qrxs\commons-logging.jar")			
			/*ret = FileCopy(is_current_path + "\qrxsjarfiles\qrxs-v1_05.jar", is_current_path + "\qrxs\qrxs-v1_05.jar")
			ret = FileCopy(is_current_path + "\qrxsjarfiles\commons-codec-1.3.jar", is_current_path + "\qrxs\commons-codec-1.3.jar")
			ret = FileCopy(is_current_path + "\qrxsjarfiles\commons-fileupload-1.1.jar", is_current_path + "\qrxs\commons-fileupload-1.1.jar")
			ret = FileCopy(is_current_path + "\qrxsjarfiles\commons-httpclient-2.0.jar", is_current_path + "\qrxs\commons-httpclient-2.0.jar")
			ret = FileCopy(is_current_path + "\qrxsjarfiles\commons-logging.jar", is_current_path + "\qrxs\commons-logging.jar")*/
			//---------End Modifid ----------------------------------------------------------------------------			
			choose case ret
				case 1
					// success
				case -1 					
					is_messsages[upperbound(is_messsages) + 1] = 'The QRXS Jar file is missing. Please contact IntelliSoft Support for assistance.'
				case -2
					//Error writing targetfile
					is_messsages[upperbound(is_messsages) + 1] = 'The QRXS Jar file Can not be copied. Contact your System Administrator to check your permissions on the directory : ' + ls_java_home +  JAR_LOCATION + "qrxs.jar"
				case else
					// unknown error
					is_messsages[upperbound(is_messsages) + 1] = "An unknown error has occurred while copying the jar file. Contact IntelliSoft Support for assistance."
			end choose
			if ret <> 1 then				
				ls_notify[1] = "maha@intelliSoftGroup.com"
				of_mail_error('QRXS Interface', 'The jar file could not be copied', ls_notify)
				ll_return = failure
			end if
		end if
	case else
		Return FAILURE
end choose

return ll_return
end function

public function integer of_mail_error (string as_subject, string as_notetext, string as_person[]);/****************************************************************************************************************
** [PUBLIC] Function of_lc_processnotify in n_cst_error inherited from pfc_n_cst_error
**--------------------------------------------------------------------------------------------------------------
** Description:
**--------------------------------------------------------------------------------------------------------------
** Arguments:	
**
**	[value] string as_subject      <Description>
**	[value] string as_notetext      <Description>
**--------------------------------------------------------------------------------------------------------------
** Returns:	(INTEGER) 
**--------------------------------------------------------------------------------------------------------------
** Author:	MSKINNER		Date: Monday, July 23, 2001    10:11:57
**--------------------------------------------------------------------------------------------------------------
** Modification Log:	

** Date            Who                   Change  	
**--------------------------------------------------------------------------------------------------------------


****************************************************************************************************************/


return  0
String				ls_notesubject
String				ls_notetext
string 				ls_Recipient
string 				ls_userName
Integer				li_i
Integer				li_count
Integer				li_addresscount
Integer				li_rc
mailReturnCode		lmrc_mRet
mailMessage  		lmm_mMsg
mailSession  	ims_mSes	
ims_mSes=  CREATE mailsession //mbs
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-01
//$<add> 01.25.2006 By: LeiWei
//$<reason> mailSession is currently unsupported.
//$<modification> Manually specify mailReturnSuccess! as the initial value to mRet. 
lmrc_mRet = mailReturnSuccess!
//---------------------------- APPEON END ----------------------------
ims_mSes.mailLogon(mailNewSession!)//mbs
string ls_first_name,ls_first_nameA
string  ls_last_name


// Check for a mail connection.
If IsNull(ims_mSes) Or Not IsValid(ims_mSes) Then
	//Messagebox("Mail Error", "A Mail connection  could no be made")
	Return 0
End If


//////////////////////////////////////////////////////////////////////////////
// Populate the Message Recipients
//////////////////////////////////////////////////////////////////////////////

 
FOR  li_i = 1 TO UPPERBOUND(as_person)
	lmm_mMsg.Recipient[1].Name = as_person[li_i]
	
	string ls_notetext1
	ls_notetext1 = as_notetext
	
	// Populate the Message Subject.
   lmm_mMsg.Subject = as_subject
	
	// Populate the Message Text. 
	lmm_mMsg.NoteText = ls_notetext1
	
	// Send the mail.
	lmrc_mRet = ims_mSes.mailSend ( lmm_mMsg )
	
	// Check for a succesful Send Mail.
	If lmrc_mRet <> mailReturnSuccess! Then
		//Messagebox("Mail Error", "The mail was not properly sent!!")
		//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
      inv_message.of_MessageBox("Mail Error", "The mail was not properly sent!!",true)
		Return -1
	End If
NEXT

destroy ims_mSes// mbs
Return 1
end function

public function integer of_initialize ();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : of_initialize
//==================================================================================================================
//  Purpose   	: used set up the needed datastores and arrays
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]   (not used)  
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael Skinner  
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

long ll_I
integer chk
is_internet_inuse = 'N'
is_current_path = gs_dir_path + 'intellicred'//gnv_app.is_application_path //Start Code Change ---- 04.26.2006 #422 maha

setnull(is_null)

inv_filesrv =  CREATE  n_cst_filesrvwin32

is_itp_path = is_current_path + '\itp'

filedelete(is_itp_path + "\itpstat.dat") //Start Code Change ----04.08.2008 #V8 maha moved here from of_check_status to delete the file at the start rather than at the end of the process. - maha 07.25.08 added slash

ids_pracs = CREATE n_ds
ids_pracs.dataobject = 'd_npdb_pracs'

ids_npdb_fac_info = create N_ds
ids_npdb_fac_info.dataobject = 'd_npdb_fac_info'
ids_npdb_fac_info.settransobject(sqlca)

ids_pracs_info = create N_ds
ids_pracs_info.dataobject = 'd_npdb_prac_info'
ids_pracs_info.settransobject(sqlca)

// create and retrieve the list of needed datawindows
ids_dw_datatore = create n_ds
ids_dw_datatore.dataobject = 'd_npdb_dw'
ids_dw_datatore.of_settransobject(sqlca)
ids_dw_datatore.retrieve()


//ids_dw_datatore.sort()
ids_error = create N_ds
ids_error.dataobject = 'd_npdb_ERROR'
ids_error.settransobject(sqlca)

ids_lookup_code = create N_ds
ids_lookup_code.dataobject = 'd_npdb_lookup_code'
ids_lookup_code.settransobject(sqlca)
ids_lookup_code.retrieve()

// heADER UPDATE DATAWINDOW
ids_npdb_tracker_upd = CREATE n_ds 
ids_npdb_tracker_upd.dataobject= 'd_npdb_tracker'
ids_npdb_tracker_upd.settransobject(sqlca)

ids_varification = create n_ds
ids_varification.dataobject = 'd_npdb_varification_info'
ids_varification.settransobject( sqlca)

ids_tracker_by_doc_id = CREATE n_ds
ids_tracker_by_doc_id.dataobject = 'd_npdb_tracker_by_doc_id'
ids_tracker_by_doc_id.settransobject( sqlca)

ids_cc_information = CREATE n_ds
ids_cc_information.dataobject = 'd_npdb_cc_info'
ids_cc_information.settransobject( sqlca)

lds_address_info =  create n_ds
lds_address_info.dataobject = 'd_npdb_prac_address'
lds_address_info.settransobject(sqlca)

//Start Code Change ----08.29.2012 #V12 maha
ids_qrxs_log =  create n_ds
ids_qrxs_log.dataobject = "d_npdb_qrxs_log_add"
ids_qrxs_log.settransobject(sqlca)
//End Code Change ----08.29.2012

//---------------------------------------------------------------------------------------------------------------
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// !!!!!!!!!!!!!!  DO NOT CHANGE THE SEQUENCE OF THE FOLLOWING ARRAYS. YOU MAY ADD TO THEM HOWEVER !!!!!!!!!!!!!
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//---------------------------------------------------------------------------------------------------------------


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// the needed directories for the ITP interface
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

is_directories[upperbound(is_directories) + 1 ] = is_current_path + "\itp" //[1]
is_directories[upperbound(is_directories) + 1 ] = is_current_path + "\itp\Download"//[2]
is_directories[upperbound(is_directories) + 1 ] = is_current_path + "\itp\Upload" //[3]
is_directories[upperbound(is_directories) + 1 ] = is_current_path + "\itp\Temp"  //[4]
is_directories[upperbound(is_directories) + 1 ] = is_current_path + "\itp\Processed" // files that have been processed   [5]


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// the needED batch files
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
is_batch_files[upperbound(is_batch_files) + 1 ] = is_current_path + "\itp\itp_recieve.bat" //[1]
is_batch_files[upperbound(is_batch_files) + 1 ] = is_current_path + "\itp\itp_send.bat" //[2]
is_batch_files[upperbound(is_batch_files) + 1 ] = is_current_path + "\itp\itp_encode.bat"//[3]

	

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// batch file text 'set PATH="C:\Program Files\Java\j2re1.4.2_07\bin' + new_line 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
is_batch_file_text[upperbound(is_batch_file_text) + 1 ] = 'java Itp receive'
is_batch_file_text[upperbound(is_batch_file_text) + 1 ] = 'java Itp send'
is_batch_file_text[upperbound(is_batch_file_text) + 1 ] = 'java Encode'

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// need files 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
is_files[upperbound(is_files) + 1 ] = is_current_path  + "\itp\itp.ini"       // CONFIG FILE  is_files[1]
is_files[upperbound(is_files) + 1 ] = is_current_path  + "\itp\upidlist.fil"  // LIST IF FILES TO BE UPLOADED  is_files[2]
is_files[upperbound(is_files) + 1 ] = is_current_path  + "\itp\download.lst"  // LIST OF FILES DOWN LOADED  is_files[3]
	
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// STATUS FILES
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
is_status_files[1] = is_current_path + '\itp\itpstat.dat' 
//is_status_files[2] = is_current_path + '\itp\itp.log' // this is useless 

//----------------------------- APPEON BEGIN -----------------------------
//$<Add> 11.18.2009 By: Evan
//$<Reason> V10.1 - NPDB QRXS
is_qrxs_path = is_current_path + '\qrxs'
is_directories2[1] = is_current_path + "\qrxs"
is_directories2[2] = is_current_path + "\qrxs\Download"
is_directories2[3] = is_current_path + "\qrxs\Upload"
is_directories2[4] = is_current_path + "\qrxs\Temp"
is_directories2[5] = is_current_path + "\qrxs\Processed"
is_directories2[6] = is_current_path + "\qrxs\Downloadconf"   //Start Code Change ----09.05.2012 #V12 maha - added

is_batch_files2[1] = is_current_path + "\qrxs\qrxs_recieve.bat"
is_batch_files2[2] = is_current_path + "\qrxs\qrxs_send.bat"
is_batch_files2[3] = is_current_path + "\qrxs\qrxs_encode.bat"

is_batch_file_text2[1] = 'java com.npdbhipdb.QRXS receive'
is_batch_file_text2[2] = 'java com.npdbhipdb.QRXS send'
is_batch_file_text2[3] = 'java com.npdbhipdb.QRXS encode'

is_files2[1] = is_current_path  + "\qrxs\qrxs.properties"
is_files2[2] = is_current_path  + "\qrxs\upload.lst"
is_files2[3] = is_current_path  + "\qrxs\download.lst"

is_status_files2[1] = is_current_path + '\qrxs\qrxsstat.dat'
//----------------------------- APPEON END -------------------------------

//Start Code Change ----07.29.2008 #V85 maha - added error messages
if of_create_folders( )      <> success then 
	//messagebox("Failure in NPDB", "of_create_folders failed") //Evan 11.19.2009 - change message
	//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
	inv_message.of_MessageBox("Failure in NPDB", "of_create_folders failed",true)
	return failure
end if
if of_create_batch_files( )  <> success then 
//	messagebox("Failure in NPDB", "of_create_batch_files failed") //Evan 11.19.2009 - change message
	//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
	inv_message.of_MessageBox("Failure in NPDB", "of_create_batch_files failed",true)
	return failure
end if
//debugbreak()
if of_move_jar( )            <> success then 
	//messagebox("Failure in NPDB", "of_move_jar failed") //Evan 11.19.2009 - change message
	//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
	inv_message.of_MessageBox("Failure in NPDB", "of_move_jar failed  current directory:" + is_current_path ,true)
	return failure
end if

if of_create_classpath( ) <> success then 
	//messagebox("Failure in NPDB", "of_create_classpath failed") //Evan 11.19.2009 - change message
	//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
	//inv_message.of_MessageBox("Failure in NPDB", "of_create_classpath failed",true)  //Start Code Change ----06.13.2014 #V14.2 maha - removed redundant message.
	return failure
end if
//End Code Change---07.29.2008
ib_initialize = true // all OK

return success
end function

public function integer of_create_classpath ();//////////////////////////////////////////////////////////////////////
// $<function> of_create_classpath
// $<arguments>
// $<returns> integer
// $<description> Create class path (V10.1 - NPDB QRXS)
//////////////////////////////////////////////////////////////////////
// $<add> Evan 11.19.2009
//////////////////////////////////////////////////////////////////////

string ls_null
string ls_java_home
string ls_current_version
string ls_current_class_path
string ls_java_path
string ls_message //alfee 10.14.2016

SetNull(ls_null)

ls_java_path = "HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java Runtime Environment\" //(Appeon)Stephen 09.16.2015 - NPDB error message
choose case il_Interface
	case ITP_INTERFACE
		// Check to see if JRE is installed
		RegistryGet("HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java Runtime Environment", "CurrentVersion", RegString!, ls_current_version)
		if not f_validstr(ls_current_version) then 
			//if messagebox('Java JRE Missing','The JRE is not installed on this machine. Would you like to install it now?',question!,yesNo!,1) = 1 then
			//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
			//---------Begin Added by (Appeon)Stephen 09.16.2015 for NPDB error message--------
			gnv_appeondll.of_registerget64("SOFTWARE\Wow6432Node\JavaSoft\Java Runtime Environment",  "CurrentVersion", ls_current_version)
			ls_java_path = "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\JavaSoft\Java Runtime Environment\"
			if not f_validstr(ls_current_version) then
			//---------End Added ------------------------------------------------------
				if inv_message.of_MessageBox('Java JRE Missing','The JRE is not installed on this machine. Would you like to install it now?',question!,yesNo!,1,true) = 1 then
					 //ShellExecuteA(Handle(This), "open", 'IEXPLORE', "http://jdl.sun.com/webapps/download/AutoDL?BundleId=10342", ls_Null, 0)   //Commented by (Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
					 ShellExecuteA(Handle(This), "open", of_getbrowserversion( ), "http://jdl.sun.com/webapps/download/AutoDL?BundleId=10342", ls_Null, 0)  //(Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
					return failure
				end if 
			end if
		end if 
		
		// Create the class path
		//---------Begin Modified by (Appeon)Stephen 09.16.2015 for NPDB error message--------
		//RegistryGet("HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java Runtime Environment\" + ls_current_version , "JavaHome", RegString!, ls_java_home)
		RegistryGet(ls_java_path + ls_current_version , "JavaHome", RegString!, ls_java_home)
		//---------End Modfiied ------------------------------------------------------		
		RegistryGet("HKEY_CURRENT_USER\Environment", "classpath", RegString!, ls_current_class_path)
		is_classpath = ".;" + ls_java_home + "\bin;" + is_current_path + "\itp\itp.jar;" + is_current_path + "\itp\commons-fileupload-1.1.jar;" + is_current_path + "\itp\commons-httpclient-2.0.jar;" + is_current_path + "\itp\commons-logging.jar;" + is_current_path + "\itp\commons-codec-1.3.jar"
		RegistrySet("HKEY_CURRENT_USER\Environment", "classpath", RegString!, is_classpath)
		
		// If the classpath is new we must log on and off
		if ls_current_class_path <> is_classpath then 
			//if messagebox('New ClassPath Set', 'A new class path has been set, you must log off before using the NPDB. Would you like to do this now?',question!,YESNO!,1) = 1 then 
			//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
			if inv_message.of_MessageBox('New ClassPath Set', 'A new class path has been set, you must log off before using the NPDB. Would you like to do this now?',question!,YESNO!,1,true) = 1 then 
				// start intellicred once the os starts
				RegistrySet("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\RUNONCE", "DEFAULT", RegString!, is_current_path + "\intellicred.exe")
				// exit windows
				ExitWindowsEx(0,0)
			end if
			return failure
		end if
	case QRXS_INTERFACE //Add by Evan 11.18.2009 (V10.1 - NPDB QRXS)
		// Check to see if JRE is installed
		//RegistryGet("HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java Runtime Environment", "CurrentVersion", RegString!, ls_current_version)
		gnv_appeondll.of_registerget64("SOFTWARE\JavaSoft\Java Runtime Environment",  "CurrentVersion", ls_current_version) //alfee 07.22.2014
		if not f_validstr(ls_current_version) or ls_current_version < "1.6" then
			//---------Begin Added by (Appeon)Stephen 09.16.2015 for NPDB error message--------
			gnv_appeondll.of_registerget64("SOFTWARE\Wow6432Node\JavaSoft\Java Runtime Environment",  "CurrentVersion", ls_current_version)
			ls_java_path = "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\JavaSoft\Java Runtime Environment\"
			if not f_validstr(ls_current_version) or ls_current_version < "1.6" then
			//---------End Added ------------------------------------------------------
				//--------Begin Modified by alfee 10.14.2016 (Bug #5368) -------------------------
				//if inv_message.of_MessageBox("Java JRE Missing", "The machine need to install JRE version 1.6 or higher. Would you like to install it now?", Question!, YesNo!, 1,true) = 1 then
				//	ShellExecuteA(Handle(this), "open", "http://java.sun.com/javase/downloads", ls_Null, ls_Null, 0)
				ls_message = "The Java RunTime Environment (JRE) version 8 or higher is not installed on the machine. Would you like to download and install it now? Contact your System Administrator for help."
				if inv_message.of_MessageBox("Java JRE Missing", ls_message, Question!, YesNo!, 1, true) = 1 then
					ShellExecuteA(Handle(this), "open", "http://www.oracle.com/technetwork/java/javase/downloads/index.html", ls_Null, ls_Null, 0)	
				//---------End Modified ----------------------------------------------------------------	
					Return FAILURE
				end if 
			end if
		end if 
		
		// Create the class path
		//---------Begin Modified by (Appeon)Stephen 09.16.2015 for NPDB error message--------
		//RegistryGet("HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java Runtime Environment\" + ls_current_version , "JavaHome", RegString!, ls_java_home)
		RegistryGet(ls_java_path + ls_current_version , "JavaHome", RegString!, ls_java_home)
		//---------End Modfiied ------------------------------------------------------
		RegistryGet("HKEY_CURRENT_USER\Environment", "classpath", RegString!, ls_current_class_path)
		is_classpath = ".;" + ls_java_home + "\bin;" + is_current_path + "\qrxs\qrxs-v1_05.jar;" + is_current_path + "\qrxs\commons-fileupload-1.1.jar;" + is_current_path + "\qrxs\commons-httpclient-2.0.jar;" + is_current_path + "\qrxs\commons-logging.jar;" + is_current_path + "\qrxs\commons-codec-1.3.jar"
		if Lower(ls_current_class_path) <> Lower(is_classpath) then
			RegistrySet("HKEY_CURRENT_USER\Environment", "classpath", RegString!, is_classpath)
			// If the classpath is new we must log on and off
			 //Start Code Change ----06.13.2014 #V14.2 maha - removed restart; modified message.
			inv_message.of_MessageBox("New ClassPath has been set for JRE", "Please re-run the NPDB function", Question!, YesNo!, 1,true) 
				//RegistrySet("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\RUNONCE", "DEFAULT", RegString!, is_current_path + "\intellicred.exe") 
				//ExitWindowsEx(0, 0)
			//end if
			Return FAILURE
			//End Code Change ----06.13.2014
		end if
	case else
		Return FAILURE
end choose

Return SUCCESS
end function

public function string of_create_itin ();

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : of_create_ITIN
//==================================================================================================================
//  Purpose   	: open event
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [STRING] THE TAG STRING     
//==================================================================================================================
//  Notes     	:  tAX ID NUMBER - NOT TAG REQUIRED BUT DATA IS NOT
//==================================================================================================================
//  Created By	: Michael B. Skinner Friday 14 January 2004 
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

STRING ls_tag_string[]
STRING ls_return

///////////////////////////////////////////////////////////////////////
// INSERT THE DATA INTO THE SPOT
///////////////////////////////////////////////////////////////////////

ls_tag_string[upperbound(ls_tag_string) + 1]  =  'ITIN'                   + delimiter   // TAG
									
ls_tag_string[upperbound(ls_tag_string) + 1]  =  new_line


RETURN of_assemble_string(ls_tag_string)
return ""
end function

public function integer of_post_original_db_create ();/******************************************************************************************************************
**  [PUBLIC]   : of_post_original_db_create
**==================================================================================================================
**  Purpose   	: ADD NEW DATABASE COLUMNS ETC AFTER THE INTIAL CREATION
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 03 November 2005  ?Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "if exists(select 1 from sys.sysforeignkey where role='FK_NPDB_ITI_REFERENCE_NPDB_HDR') then    alter table npdb_itin       delete foreign key FK_NPDB_ITI_REFERENCE_NPDB_HDR end if  " 
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "create table npdb_itin (npdb_hdr_id integer not null default NULL, itin1 varchar(20) null default NULL, itin2 varchar(20) null default NULL, itin3 varchar(20) null DEfault NULL, itin4 varchar(20) null default NULL,primary key (npdb_hdr_id));"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table npdb_itin   add foreign key FK_NPDB_ITI_REFERENCE_NPDB_HDR (npdb_hdr_id)      references npdb_hdr (npdb_hdr_id)      on update restrict      on delete cascade " 

of_insert_dbcontrol()



return success
end function

public function integer of_insert_dbcontrol ();
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "DELETE FROM NPDB_CONTROL;"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (1,'d_npdb_arr',NULL,NULL);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (2,'d_npdb_aart',NULL,NULL);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (3,'d_npdb_aff',NULL,NULL);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (4,'d_npdb_agnt',NULL,NULL);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (5,'d_npdb_alias',8,NULL);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (6,'d_npdb_aocd',NULL,NULL);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (7,'d_npdb_apeal',NULL,	NULL);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (8,'d_npdb_bactn',NULL,	NULL);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (9,'d_npdb_caar',NULL,NULL);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (10,'d_npdb_cert',3,3);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (11,'d_npdb_clia',null,null);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (12,'d_npdb_cuse',14,14);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (13,'d_npdb_dea',5,5);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (14,'d_npdb_enty',NULL,	NULL);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (15,'d_npdb_er',NULL,NULL);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (16,'d_npdb_esln',NULL,	6);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (17,'d_npdb_esubj',NULL,4);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (18,'d_npdb_esuppl',NULL,NULL);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (19,'d_npdb_fda',NULL,13);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (20,'d_npdb_fien',11,10);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (21,'d_npdb_fqsl',NULL,	NULL);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (22,'d_npdb_fsta',NULL,NULL);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (23,'d_npdb_grad',7,NULL);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (24,'d_npdb_hdr',1,1);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (25,'d_npdb_hosp',NULL,	NULL);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (26,'d_npdb_invtg',NULL,NULL);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (27,'d_npdb_isofl',6,NULL);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (28,'d_npdb_isubj',4,NULL);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (29,'d_npdb_isuppl',NULL,NULL);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (30,'d_npdb_jocr',NULL,NULL);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (31,'d_npdb_jocrt',NULL,NULL);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (32,'d_npdb_laart',NULL,NULL);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (33,'d_npdb_medicarep',NULL,12);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (34,'d_npdb_mmpr',NULL,	NULL);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (35,'d_npdb_mmrt',NULL,NULL);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (36,'d_npdb_npi',12,12);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (37,'d_npdb_oenam',NULL,8);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (38,'d_npdb_pdcn',NULL,	NULL);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (39,'d_npdb_poo',NULL,NULL);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (40,'d_npdb_qrsd',NULL,	NULL);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (41,'d_npdb_rsdr',NULL,	NULL);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (42,'d_npdb_sj',NULL,NULL);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (43,'d_npdb_ssn',9,9);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (44,'d_npdb_statoc',NULL,NULL);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (45,'d_npdb_supplsnd',NULL,NULL);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (46,'d_npdb_upin',13,NULL);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (47,'d_npdb_rpoc',NULL,NULL);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (48,'d_npdb_qry',2,2);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (49,'d_npdb_qsta',NULL,	NULL);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (50,'d_npdb_prct',NULL,	NULL);"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (51,'d_npdb_itin',10,	null);"

return success
end function

public function integer of_set_version_1_12 ();/******************************************************************************************************************
**  [PUBLIC]   : of_set_Version_1_12
**==================================================================================================================
**  Purpose   	: version 1.2 changes
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 27 Febuary 2006 ?Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','RB','Due to the publication of final regulations impementing Section 1921 of the Social Security Act, the DBID for your organization must be renewed before the submission file can be &processed by the Data Banks. The certifying official for your organization must review the new Section 1921 statutory authorities, available at http://www.npdb-hipdb.com/legislation.html, as part of the renewal process. Once the statutory authorities have been reviewed, complete the on-line registration &renewal form by logging in to the IQRS and selecting Renew Registration on the registration confirmation screen. The completed form must be signed and mailed to the NPDB-HIPDB for processing. If your organization has already mailed your registration renewal to the Data Banks, it will be processed within one &&business day of its receipt by the NPDB-HIPDB. You will receive Data Bank Correspondence once the Data Banks have successfully  processed your registration renewal form. If necessary, you may complete a new form by selecting Renew Registration on the registration confirmation screen within the IQRS. If you need further assistance, please contact the NPDB-HIPDB Customer Service Center at 1-800-767-6732.');"																		
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','RC', 'Due to the publication of final regulations implementing Section 1921 of the Social Security Act, the DBID for your organization must be renewed before the submission file can be processed by the Data Banks.The certifying official for your organization must review the new Section 1921 statutory authorities, available at http://www.npdb-hipdb.com/legislation.html, as part of the renewal process. Contact the administrator of your organization so they can renew the registration. If you need further assistance, please contact the NPDB-HIPDB Customer Service Center at 1-800-767-6732.');"
																	
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','148', 'Certified Nurse Aide/Certified Nursing Assistant')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','165', 'Health Care Aide/Direct Care Worker')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','175', 'Certified or Qualified Medication Aide')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','470', 'Hearing Aid/Hearing Instrument Specialist')"
		

return 0

end function

protected function integer of_file_succeded (string as_file_text[]); /******************************************************************************************************************
**  [PUBLIC]   : of_file_succeded( /*string as_file_text[] */)
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [string] as_file_text[]
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 27 Febuary 2006 ?Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
//called from of_receive()
long ll_array_count
string ls_tag[]
string ls_null[]
long ll_foundrow
integer s
//checks the FSTA segment field 2 for an F for failure.  If failed in FSTA with out errors may also check the QSTA
for ll_array_count = 1 to upperbound(as_file_text)
//Start Code Change ---- 09.24.2007 #V7 maha //modified to get multiple errors
  	IF inv_string.of_CountOccurrences ( as_file_text[ll_array_count], 'FSTA' ) > 0 THEN 
		inv_string.of_parsetoarray(as_file_text[ll_array_count], delimiter , ls_tag)
		IF ls_tag[2] = "F" THEN // THE QUERY FAILED ;  'R'means ok
			If upperbound(ls_tag) > 8 then  //if failed and no err code allow it to go to the QSTA later
				for s = 9 to upperbound(ls_tag) // 9 and greater of the FSTA will be the error codes
					//messagebox(string(s),ls_tag[s])
					ll_foundrow = ids_lookup_code.Find(" npdb_list = 'list_q' AND npdb_list_code = '" + ls_tag[s] + "'", 1, ids_lookup_code.rowcount())
					if ll_foundrow > 0 then 
						//Start Code Change ----04.29.2008 #V8 maha - changed file name
						//is_messsages[upperbound(is_messsages) + 1] = 'An NPDB error has occured. In file ' + is_current_file +new_line + new_line+ ids_lookup_code.getItemString(ll_foundrow,'npdb_list_code_description') +new_line + new_line 
						is_messsages[upperbound(is_messsages) + 1] = 'An NPDB error has occured. In file ' + is_docid_current +new_line + new_line+ ids_lookup_code.getItemString(ll_foundrow,'npdb_list_code_description') +new_line + new_line 				
					else
						is_messsages[upperbound(is_messsages) + 1] = 'An NPDB error has occured. The Query failed. The code is :' + ls_tag[s] + ' Please inform IntelliSoft that the error code is missing from the system.' 
					end if 
				next
				return failure //-1
			end if
	   END IF
	//added maha 09-24-07 ;  usually will not get here; will probably be rejected in the FSTA
	ELSEIF inv_string.of_CountOccurrences ( as_file_text[ll_array_count], 'QSTA' ) > 0 THEN 
		ls_tag = ls_null //Start Code Change ----04.09.2008 #V8 maha - reset the array or the higher values will remain
		inv_string.of_parsetoarray(as_file_text[ll_array_count], delimiter , ls_tag)
		//debugbreak()
		IF ls_tag[3] = "R" THEN // rejected
			for s = 5 to upperbound(ls_tag) // 5 and greater of the QSTA will be the error codes
				//messagebox(string(s),ls_tag[s])
				ll_foundrow = ids_lookup_code.Find(" npdb_list = 'list_q' AND npdb_list_code = '" + ls_tag[s] + "'", 1, ids_lookup_code.rowcount())
				if ll_foundrow > 0 then 
					//Start Code Change ----04.29.2008 #V8 maha - changed file name
					//is_messsages[upperbound(is_messsages) + 1] = 'An NPDB error has occured. In file ' + is_current_file +new_line + new_line+ ids_lookup_code.getItemString(ll_foundrow,'npdb_list_code_description') +new_line + new_line 
					is_messsages[upperbound(is_messsages) + 1] = 'An NPDB error has occured. In file ' + is_docid_current +new_line + new_line+ ids_lookup_code.getItemString(ll_foundrow,'npdb_list_code_description') +new_line + new_line 
				else
					is_messsages[upperbound(is_messsages) + 1] = 'An NPDB error has occured. The Query was rejected. The code is :' + ls_tag[s] + ' Please inform IntelliSoft that the error code is missing from the system.' 
				end if 
			next
			return -2 ////Start Code Change ----04.18.2008 #V8 maha - moved from below the if statement so the no match files return success
		ELSEIF ls_tag[3] = "N" then //no match is good : means no reports
			//Start Code Change ----04.29.2008 #V8 maha - changed file name
		End if
	END IF 
next
//End Code Change---09.24.2007
return success
end function

public function string of_replacenonprint (string as_source);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_RemoveNonPrint
//
//	Access:  		public

//
//	Arguments:
//	as_source		The string from which all nonprint characters are to
//						be removed.
//
//	Returns:  		string
//						as_source with all desired characters removed.
//						If any argument's value is NULL, function returns NULL.
//
//	Description: 	Removes all nonprint characters.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright ?1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

char		lch_char
long		ll_pos = 1
long		ll_loop
string	ls_source
long		ll_source_len

//Check parameters
If IsNull(as_source) Then
	string ls_null
	SetNull(ls_null)
	Return ls_null
End If

ls_source = as_source
ll_source_len = LenA(ls_source)

// Remove nonprintable characters 
FOR ll_loop = 1 TO ll_source_len
	
	lch_char = MidA(ls_source, ll_pos , 1)

	if inv_string.of_IsPrintable(lch_char) then
			ll_pos ++
	else
		//messagebox(STRING(ASC(new_line)), asc(lch_char))
		ls_source = ReplaceA(ls_source, ll_pos, 1, new_line)
		ll_pos = ll_pos + 2
	end if 
	
NEXT

Return ls_source
end function

public function boolean of_file_has_report (string as_file_text[]); /******************************************************************************************************************
**  [PUBLIC]   : of_file_has_report( /*string as_file_text[] */)
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [string] as_file_text[]
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 27 Febuary 2006 ?Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
long ll_array_count
string ls_tag[]
long ll_foundrow

for ll_array_count = 1 to upperbound(as_file_text)
  	IF inv_string.of_CountOccurrences ( as_file_text[ll_array_count], 'QRSD' ) > 0 THEN 
	  	return TRUE
	   END IF
next

return FALSE
end function

public function string of_create_isofl_new ();//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////  [PUBLIC]   : of_create_ISOFL_new
////==================================================================================================================
////  Created By	: Mike Aha from of_create_isofl code  10.03.2006
////==================================================================================================================
//// get the list of license records from the practitioner
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

STRING ls_tag_string[]
STRING ls_return
string ls_lic[]
integer i
long ll_cat //Start Code Change ---- 10.03.2006 #654 maha
long ll_spec_count
long ll_lic_count
long ll_max_count
long ll_i
long ll_speciality_code
long ll_lic_code
long ll_state_code
string ls_state[]
string ls_lic_num[]
string ls_lic_desc[]
string ls_spec	
string ls_speciality_code
//string ls_spec_desc //maha 042908

datastore ids_speciality
ids_speciality = create datastore
ids_speciality.dataobject = 'd_npdb_pd_speciality'
ids_speciality.settransobject( sqlca)

datastore ids_lic
ids_lic = create datastore
ids_lic.dataobject = 'd_npdb_pd_lic'
ids_lic.settransobject( sqlca)

gnv_appeondb.of_startqueue( )

ids_speciality.retrieve(ids_pracs_info.object.prac_id[1])
ids_lic.retrieve(ids_pracs_info.object.prac_id[1] )

gnv_appeondb.of_commitqueue( )

ll_spec_count = ids_speciality.Rowcount( )
ll_lic_count = ids_lic.Rowcount( )

if ll_lic_count < 1 then return "Failed"  //Start Code Change ----04.25.2008 #V8 maha


///////////////////////////////////////////////////////////////////////
// create tag beginning
///////////////////////////////////////////////////////////////////////


//ISOFL~111~2222222222~33333~44~55~ ...
 //111 -- Occupation/Field of Licensure, required. It should be the three-digit License Type code (i.e., 010 for Allopathic Physician, etc.). If for some reason there is no match, it should probably continue to be set to 699.
//2222222222 -- Occupation/Field of Licensure description. It should be filled in if Occupation/Field of Licensure is either 699 or 899, otherwise it should be left blank.
 //33333 -- State license number, required.
 //44 -- State of licensure, required.
 //55 -- Specialty code. If Occupation/Field of Licensure is 010, 015, 020, 025, 030 or 035, then this should be the two-digit specialty code from List D (and I assume we should be using the primary specialty only). Otherwise, it should be blank.


ls_tag_string[upperbound(ls_tag_string) + 1]  =  'ISOFL'                   + delimiter   // TAG
//////////// 1
///OCCUPATIONAL FIELD REQUIRED

//get the specialty data  #55

//Start Code Change ----04.29.2008 #V8 maha - trap for missing specialty
if ll_spec_count > 0 then
	ll_speciality_code = ids_speciality.getitemnumber(1,"specialty")
	ls_spec= gnv_data.of_getitem("code_lookup" , "description", "lookup_code = " + String(ll_speciality_code))
else
	ls_spec = "99"  //Start Code Change ----04.29.2008 #V8 maha - changed from 98  99 = not specified
end if
//End Code Change---04.29.2008

//for each license get data then build the tag
if ll_lic_count < 1 then
	ll_lic_code = 699
	
else
	for i = 1 to ll_lic_count
		ll_lic_code = ids_lic.OBJECT.code_lookup_ic_n[i]
		if isnull(ll_lic_code) then  //Start Code Change ---- 12.19.06.2006 #V7 maha
			ls_lic[i] = ""
		else
			ls_lic[i] = string(ll_lic_code)
		end if
		//messagebox("ls_category",ls_category)
		//set default and leading zeros
		if LenA(ls_lic[i]) = 0 then
			ls_lic[i] = "699"
		elseif LenA(ls_lic[i]) = 1 then
			ls_lic[i] = "00" + ls_lic[i]
		elseif LenA(ls_lic[i]) = 2 then
			ls_lic[i] = "0" + ls_lic[i]
		end if
		
		choose case ls_lic[i]
			case "699","899"
				//get license type discription only if one of theses codes
				ls_lic_desc[i] = ids_lic.OBJECT.code_lookup_description[i]
				ls_speciality_code = "" //Start Code Change ----04.29.2008 #V8 maha - changed variable
			case "010","015","020","025","030","035"
				ls_lic_desc[i] = ""
				//only use specialty code for these values
				 //Start Code Change ----04.29.2008 #V8 maha - first check ic_c field in specialty table if no code then try to match on description in the npdb lookup table
				ls_speciality_code = gnv_data.of_getitem("code_lookup" , "ic_c", "lookup_code = " + String(ll_speciality_code))
				if ls_speciality_code = '' or isnull(ls_speciality_code) then
					SELECT npdb_list_code
					INTO :ls_speciality_code
					FROM  npdb_code_lookup 
					WHERE npdb_list = 'list_d' and npdb_list_code_description  = :ls_spec;
				end if
				//debugbreak()
				if not f_validstr(ls_speciality_code) then ls_speciality_code = "99"    //Start Code Change ----04.29.2008 #V8 maha - changed from 98
			case else
				ls_lic_desc[i] = ""
				ls_speciality_code = ""  //Start Code Change ----04.29.2008 #V8 maha - changed variable
		end choose
		
		ls_lic_num[i] = ids_lic.getItemString(i,'license_number')
		
		ll_state_code = ids_lic.GetItemDecimal (i,'state')
		ls_state[i] = gnv_data.of_getitem("code_lookup" , "code", "lookup_code = " + String(ll_state_code))
		if not f_validstr(ls_state[i]) then ls_state[i] = ""
		
		ls_tag_string[upperbound(ls_tag_string) + 1]  += ls_lic[i] + delimiter + ls_lic_desc[i] + delimiter + ls_lic_num[i] + delimiter + ls_state[i] + delimiter
		ls_tag_string[upperbound(ls_tag_string) + 1]  += ls_speciality_code + delimiter
	next

//Start Code Change ----04.25.2008 #V8 maha	- removed the extra deliniters
//	for i = ll_lic_count + 1 to 10 //add the extra delimiters
//		ls_tag_string[upperbound(ls_tag_string) + 1]  += delimiter + delimiter + delimiter + delimiter + delimiter
//	next
//End Code Change---04.25.2008
		
end if
		

//add tag tail
ls_tag_string[upperbound(ls_tag_string) + 1]  +=  new_line


RETURN of_assemble_string(ls_tag_string)
end function

public function integer of_get_user_password ();//function created 04.04.2008 maha - to set the user id and password that will be user in the itp
//either from the user record, or from facility record
//called from of_create_ini

//first check user id from user record, if doesn't exist get both id and password from facility
//if pw doesn't exist in user record use the facility
//note: ids_npdb_fac_info.dw object modified to include facility security 040808
//debugbreak()
if isnull(ids_npdb_fac_info.object.security_users_npdb_user_id[1]) or ids_npdb_fac_info.object.security_users_npdb_user_id[1] = "" then  //Start Code Change ----12.07.2011 #V12 maha - added code for empty string
	is_npdb_user_id = ids_npdb_fac_info.object.npdb_user_id[1]
	is_password =  ids_npdb_fac_info.object.npdb_pass[1]
else
	is_npdb_user_id = ids_npdb_fac_info.object.security_users_npdb_user_id[1]
	if isnull(ids_npdb_fac_info.object.security_users_npdb_password[1]) or ids_npdb_fac_info.object.security_users_npdb_password[1] = "" then  //Start Code Change ----12.07.2011 #V12 maha - added code for empty string
		is_password =  ids_npdb_fac_info.object.npdb_pass[1]
	else
		is_password = ids_npdb_fac_info.object.security_users_npdb_password[1]
	end if
end if

if isnull(ids_npdb_fac_info.object.security_users_user_name[1]) or ids_npdb_fac_info.object.security_users_user_name[1] = "" then  //Start Code Change ----12.07.2011 #V12 maha - added code for empty string
	is_user_name = gs_user_id
else
	is_user_name = ids_npdb_fac_info.object.security_users_user_name[1]
end if

//------------ APPEON BEGIN ------------
//$<Add> 11.23.2009 By: Evan
//$<Reason> V10.1 - NPDB QRXS
if IsNull(is_npdb_user_id) then is_npdb_user_id = ""
if IsNull(is_password) then is_password = ""
if IsNull(is_user_name) then is_user_name = ""
//------------ APPEON END --------------

of_test_password( is_password)  //Start Code Change ----11.19.2014 #V14.2 maha

return 1
end function

public function integer of_failed_message (string as_section);
//Start Code Change ----04.25.2008 #V8 maha - function created for displaying error specifics for file sections
//called from of_create_upload_dat_indv

choose case as_section
	case "ISUBJ"
		//messagebox("Failure to create " + as_section, "Check for missing required data: Last name, First name, Date of Birth, Gender, Primary Office Address: Street, City, State,Zip (check for existing link)")
		//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
		inv_message.of_MessageBox("Failure to create " + as_section, "Check for missing required data: Last name, First name, Date of Birth, Gender, Primary Office Address: Street, City, State,Zip (check for existing link)",true)
	case "GRAD"
		//messagebox("Failure to create " + as_section, "Graduation year must be 15 years greater than the birth year.  Check for data entry error.")
		//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
		inv_message.of_MessageBox("Failure to create " + as_section, "Graduation year must be 15 years greater than the birth year.  Check for data entry error.",true)
end choose
		
return 1
end function

public subroutine of_insert_codes ();
long ll_max
///////////////////////////////////////////////////
/// Error Codes
////////////////////////////////////////////////////
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from npdb_code_lookup;"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','AL','Alabama');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','AK','Alaska');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','AZ','Arizona');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','AR','Arkansas');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','CA','California');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','CO','Colorado');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','CT','Connecticut');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','DE','Delaware');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','DC','District of Columbia');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','FL','Florida');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','GA','Georgia');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','HI','Hawaii');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','ID','Idaho');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','IL','Illinois');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','IN','Indiana');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','IA','Iowa');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','KS','Kansas');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','KY','Kentucky');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','LA','Louisiana');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','ME','Maine');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','MD','Maryland');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','MA','Massachusetts');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','MI','Michigan');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','MN','Minnesota');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','MS','Mississippi');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','MO','Missouri');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','MT','Montana');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','NE','Nebraska');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','NV','Nevada');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','NH','New Hampshire');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','NJ','New Jersey');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','NM','New Mexico');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','NY','New York');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','NC','North Carolina');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','ND','North Dakota');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','OH','Ohio');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','OK','Oklahoma');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','OR','Oregon');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','PA','Pennsylvania');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','RI','Rhode Island');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','SC','South Carolina');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','SD','South Dakota');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','TN','Tennessee');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','TX','Texas');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','UT','Utah');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','VT','Vermont');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','VA','Virginia');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','WA','Washington');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','WV','West Virginia');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','WI','Wisconsin');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','WY','Wyoming');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','AS','American Samoa');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','FM','Federated States of Micronesia');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','GU','Guam');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','MP','Northern Marianas');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','PW','Palau');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','PR','Puerto Rico');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_a_1 ','VI','Virgin Islands');"
//Start Code Change ---- 11.16.2006 #V7 maha
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values('list_d','01','Allergy and Immunology');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values('list_d','03','Aerospace Medicine');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values('list_d','05','Anesthesiology');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values('list_d','10','Cardiovascular Diseases');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values('list_d','13','Child Psychiatry');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values('list_d','20','Dermatology');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values('list_d','23','Diagnostic Radiology');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values('list_d','25','Emergency Medicine');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values('list_d','29','Forensic Pathology ');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values('list_d','30','Gastroenterology');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values('list_d','33','General Practice/Family Practice');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values('list_d','35','General Preventive Medicine');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_d','37','Hospitalist Dental Specialties');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_d','39','Internal Medicine');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_d','40','Neurology ');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_d','43','Neurology, Clinical Neurophysiology');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_d','45','Nuclear Medicine ');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_d','50','Obstetrics & Gynecology ');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_d','53','Occupational Medicine ');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_d','55','Ophthalmology ');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_d','59','Otolaryngology ');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_d','60','Pediatrics ');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_d','63','Psychiatry ');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_d','65','Public Health ');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_d','67','Clinical Pharmacology');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_d','69','Physical Medicine & Rehabilitation');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_d','70','Pulmonary Diseases');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_d','73','Anatomic/Clinical Pathology');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_d','75','Radiology');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_d','76','Radiation Oncology');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_d','80','Colon and Rectal Surgery');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_d','81','General Surgery');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_d','82','Neurological Surgery');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_d','83','Orthopedic Surgery');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_d','84','Plastic Surgery');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_d','85','Thoracic Surgery');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_d','86','Urological Surgery');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_d','98','Other Specialty - Not Classified');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_d','99','Unspecified');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_d','D1','General Dentistry (No Specialty)');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_d','D2','Dental: Public Health');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_d','D3','Endodontics');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_d','D4','Oral and Maxillofacial Surgery');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_d','D5','Oral and Maxillofacial Pathology');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_d','D6','Orthodontics and Dentofacial Orthopedics');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_d','D7','Pediatric Dentistry');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_d','D8','Periodontics');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_d','D9','Prosthodontics');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_d','DA','Oral and Maxillofacial Radiology');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_d','DB','Unknown');"


ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_e','P','Privileging or Employment');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_e','R','Professional Review');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_e','M','Mandatory Two-Year Review (For Use by Hospitals)');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_e','S','Licensing');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_e','F','Fraud and Abuse Investigation');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_e','G','Certification to Participate in a Government Program');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_e','I','Claims Processing');"


ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_f','100','Subject is Owner/Partner of Affiliate or Associate');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_f','150','Subject is Manager/Supervisor/Director of Affiliate or Associate');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_f','200','Subject is Employee of Affiliate or Associate');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_f','250','Subject is Contractor to Affiliate or Associate');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_f','300','Subject is Member of Affiliate or Associates Network');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_f','350','Subject has Clinical Privileges With Affiliate or Associate');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_f','400','Subject is Supplier to Affiliate or Associate');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_f','450','Subject is Customer of Affiliate or Associate');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_f','700','Subject is in Joint Venture With Affiliate or Associate');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_f','999','Other Relationship - Not Classified');"


ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_g','500','Subject is Parent Organization of Affiliate or Associate');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_g','600','Subject is Subsidiary of Affiliate or Associate');"

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','39','License Revocation, Suspension or Other Disciplinary Action Taken by a Federal, State or Local Licensing Authority');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','A7','Surrendered License to Practice');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','A4','Practicing Without a Valid License');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','29','Practicing Beyond the Scope of Practice');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','A8','Clinical Privileges Restricted, Suspended or Revoked by Another Hospital or Health Care Facility');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','AD','Surrendered Clinical Privileges');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','AB','Practicing Beyond the Scope of Privileges');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','45','Failure to Maintain Records or Provide Medical, Financial or Other Required Information');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','AA','Failure to Comply With Corrective Action Plan Criminal Conviction or Adjudication');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','B1','Nolo Contendere Plea');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','19','Criminal Conviction Confidentiality, Consent or Disclosure Violations');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','C1','Failure to Obtain Informed Consent');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','C2','Failure to Comply With Patient Consultation Requirements');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','C3','Breach of Confidentiality Misconduct or Abuse');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','14','Patient Abuse');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','D1','Sexual Misconduct');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','D2','Non-Sexual Dual Relationship or Boundary Violation');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','71','Conflict of Interest');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','16','Misappropriation of Patient Property or Other Property');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','10','Unprofessional Conduct Fraud, Deception, or Misrepresentation');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','E1','Insurance Fraud (Medicare, Medicaid or Other Insurance');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','55','Improper or Abusive Billing Practices');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','56','Submitting False Claims');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','E3','Filing False Reports or Falsifying Records');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','E4','Fraud, Deceit or Material Omission in Obtaining License or Credentials');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','81','Misrepresentation of Credentials');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','05','Fraud - Unspecified Unsafe Practice or Substandard Care');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','F1','Immediate Threat to Health or Safety');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','F2','Unable to Practice Safely by Reason of Alcohol or Other Substance Abuse');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','F3','Unable to Practice Safely by Reason of Psychological Impairment or Mental Disorder');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','F4','Unable to Practice Safely by Reason of Physical Illness or Impairment');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','F5','Unable to Practice Safely');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','F6','Substandard or Inadequate Care');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','F7','Substandard or Inadequate Skill Level');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','F8','Failure to Consult or Delay in Seeking Consultation With Supervisor/Proctor');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','11','Incompetence');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','12','Malpractice');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','13','Negligence');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','15','Patient Neglect');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','F9','Patient Abandonment');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','FA','Inappropriate Refusal to Treat');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','53','Failure to Provide Medically Reasonable and/or Necessary Items or Services Improper Supervision or Allowing Unlicensed Practice');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','G1','Improper or Inadequate Supervision or Delegation');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','G2','Allowing or Aiding Unlicensed Practice Improper Prescribing, Dispensing, Administering Medication/Drug Violation');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','H1','Narcotics Violation or Other Violation of Drug Statutes');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','H2','Unauthorized Prescribing of Medication');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','H3','Unauthorized Dispensing of Medication');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','H4','Unauthorized Administration of Medication');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','H5','Error in Prescribing, Dispensing or Administering Medication');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','H6','Diversion of Controlled Substance Other');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','99','Other - Not Classified, Specify,');"



ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_N','1','State licensure actions are adverse actions taken by State licensing authorities related to the license, certification, or registration of health care practitioners, providers, and suppliers. State licensing actions include State professional and health care facility licensing sanctions. State licensing actions against physicians and dentists that are based upon the subject’s professional competence or conduct are reportable to the NPDB under provisions of Title IV of the Health Care Quality Improvement Act of 1986, as amended, and 45 CFR Part 60. All State licensing actions against health care practitioners, providers, and suppliers are reportable to the HIPDB under Section 1128E of the Social Security Act and 45 CFR Part 61.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_N','2','Federal licensure actions are adverse actions taken by Federal licensing authorities related to the license, certification, or registration of health care providers, practitioners, and suppliers. Federal licensure actions include Federal CLIA certification actions; Federal DEA registration actions; and Federal FDA licensing, certification, and registration actions. These actions are reportable to the HIPDB under Section 1128E of the Social Security Act and 45 CFR Part 61. DEA registration actions against health care practitioners also are reportable to the NPDB under Title IV of the Health Care Quality Improvement Act of 1986, as amended, and 45 CFR Part 60.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_N','3','Clinical Privilege actions are adverse actions taken by hospitals and other health care entities related to the authorization of health care practitioners to provide health care services, including actions related to a practitioner’s membership on the medical staff or panel, and based upon the subject’s professional competence or conduct. These actions are reportable to the NPDB under Title IV of the Health Care Quality Improvement Act of 1986, as amended, and 45 CFR Part 60.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_N','4','Health Plan Health plan actions are adverse actions that are taken by a health plan against a health care practitioner, provider or supplier and that are reportable to the HIPDB under Section 1128E of the Social Security Act and 45 CFR part 61. These actions must meet the regulatory definition of “other adjudicated actions,?which requires that they: 1) be formal or official actions; 2) include the availability of a due process mechanism; and 3) be based on acts or omissions that affect or could affect the payment, provision or delivery of a health care item or service. The definition specifically excludes clinical privileging actions or paneling decisions (which normally are the result of a formal peer review process). However, quality actions that include the availability of due process are reportable. An example of a reportable health plan action would be the termination of a practitioner’s contract to provide health care services, as long as it meets the three specified criteria.');"

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_N','5' ,'The exclusion or debarment of a health care practitioner, provider, or supplier from participating in and/or contracting with a Federal or State health care program is reportable to the HIPDB under Section 1128E of the Social Security Act and 45 CFRPart 61.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_N','6','Professional Society Professional Society actions are adverse actions taken by associations of health care practitioners that follow formal peer review processes for the purpose of furthering quality health care and that are based upon the subject’s professional competence or conduct. These actions are reportable to the NPDB under the provisions of Title IV of the Health Care Quality Improvement Act of 1986, as amended, and 45 CFR Part 60.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_N','7','RESERVED');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_N','8','RESERVED');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_N','9','Government Administrative actions are reportable to the HIPDB under Section 1128E of the Social Security Act and 45 CFR Part 61. They encompass adverse actions reportable to HIPDB that are not classified elsewhere. This category includes any publicly available negative action or finding by Federal or State agencies that certify health care practitioners, providers, and suppliers for participation in a Government health care program. In addition, other Government Administrative actions include any other adjudicated action or decision by an authorized Federal or State agency against a health care practitioner, provider, or supplier. These adjudicated actions or decisions may include, for example, personnel actions, employment disqualifications, and contract terminations.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_O','200','Fraudulent Billing/Cost Reporting');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_O','205','Billing for Services Not Rendered/Supplies Not Provided');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_O','207','Misrepresentation of Services/ Supplies Provided');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_O','210','Duplicate Billing');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_O','220','Unbundling of Services');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_O','222','Upcoding of Services');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_O','230','Fraudulent Cost Reporting');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_O','240','Medicare/Medicaid Secondary Payor Fraud');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_O','250','Submitting Claims After Sanctions');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_O','260','Overcharging');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_O','270','Failure to Pay Non-Assigned Claim');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_O','300','Patient Abuse');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_O','305','Theft or Misappropriation of Patient Property');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_O','310','Billing for Medically Unnecessary Services');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_O','320','Poor Quality of Care');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_O','350','Failure to Provide Medically Necessary Care');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_O','400','Licensed Practitioner Impersonation/ Allowing Unlicensed Persons to Practice');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_O','500','Procurement Fraud');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_O','525','Research Fraud');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_O','550','Medical Record Falsification');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_O','551','Creating Medical Record for Patient Who Does Not Exist');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_O','552','Alteration/Misrepresentation of Medical Record');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_O','600','Anti-Competition Violation/Deceptive Advertising');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_O','700','Controlled Substances Violation');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_O','710','Mislabeling Drugs');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_O','720','Generic Substitutions');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_O','730','Prescription Splitting');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_O','735','Prescription Shorting');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_O','740','Drug Diversion');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_O','750','Forged/Altered Prescription Drugs');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_O','760','Illegal Prescription of Controlled Substance');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_O','770','Counterfeiting Drugs');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_O','780','Illegal Drug Use/Possession');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_O','790','Illegal Drug Trafficking');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_O','810','Kickbacks');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_O','820','Self-Referral Violations');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_O','999','Other Act/Omission  Not Classified');"

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_P','10','Criminal Conviction (Guilty Plea or Trial)');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_P','20','Deferred Conviction/Pre-Trial Diversion');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_P','30','Nolo Contendere (No Contest) Plea');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_P','40','Civil Judgment');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_P','50','Injunction');"

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','05','SQL error.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','06','Invalid transaction code entered.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','07','Invalid Data Bank ID.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','08','Invalid password.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','09','This entity does not have the privilege to perform this transaction.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','10','This entity has already registered with the NPDB, the HIPDB, or both.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','11','Entity registration has expired.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','12','Agent registration has expired.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','13','This agent does not have the authority to act for entity.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','14','All or part of agent information is missing or illegible.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','15','Entity name or Data Bank ID is missing or illegible.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','16','All or part of the entity address is missing or invalid.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','17','All or part of the entity registration information is missing or illegible.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','18','Invalid entity type code.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','19','Invalid governmental designation code.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','20','All or part of subjects name is missing or illegible.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','21','All or part of the subjects address is missing or illegible.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','22','Invalid subject type.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','23','Incomplete subject Occupation/Field of Licensure information. For each license number you provide, you must also provide a valid, two-letter abbreviation for the U.S. State from where the license was issued, and a valid, three-digit Occupation/Field of Licensure code.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','24','Invalid Occupation/Field of Licensure code.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','25','All or part of school information is missing or illegible: professional school information must include both the name of the professional health care school attended and the year the subject graduated. If the subject did not graduate, provide the last year he or she attended the school-this will be presented on the response as the subject year of graduation.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','26','At least one Drug Enforcement Administration number was not included.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','27','Invalid Social Security Number.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','28','Missing, invalid, or illegible date of birth. Date of birth must be at least 15 years before todays date and after 1900.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','29','Invalid gender code.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','30','Adverse Action Report data is missing or illegible: required information is missing in section C of the Adverse Action Report you submitted. Each of the fields in this section must be completed legibly. Please submit a new, fully completed adverse action report to the Data Bank(s). Do not reference Data Bank Control Number of this rejection notice on your new report. If this rejected report was an initial report, you must submit a new initial report; if a correction or void was rejected, you must resubmit your correction or void as if this rejected report was never submitted to the Data Bank(s).');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','31','Invalid Adverse Action Classification code.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','32','Invalid Adverse Action type code: the type of Adverse Action taken (licensure, clinical privileges, or professional society membership) was not indicated in field 3 of your Adverse Action Report form, or more than one type was marked. Please submit a new, fully completed Adverse Action Report to the Data Bank(s), indicating the type of adverse action your organization is reporting. Do not reference the document control number of this rejection notice on your new report. If this rejected report was an initial report, you must submit a new initial report; if a correction or void was rejected, you must resubmit your correction or void as if this rejected report was never submitted to the Data Bank(s).');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','33','Invalid Omission code.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','34','Medical Malpractice Payment Report data is missing or illegible: required information is missing or illegible in section C of the Medical Malpractice Payment Report you submitted. Each of the unshaded fields in this section must be completed legibly. Please submit a new, fully completed Medical Malpractice Payment Report to the Data Bank(s). Do not reference the Data Bank Control Number of this rejection notice on your new report. If this rejected report was an initial report, you must submit a new initial report; if a correction or void was rejected, you must resubmit your correction or void as if this rejected report was never submitted to the Data Bank(s).');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','35','Hospital data invalid.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','36','Missing or invalid relation of entity to subject.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','37','Invalid payment type.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','38','Invalid payment result.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','39','All or part of certification is missing: you must provide your printed name, your title (except for individual subject self-queries), your daytime telephone number, your signature, and the date you signed the form. Please submit a new, fully completed form to the Data Bank(s).');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','40','All or part of notarization is missing: to be legal and valid, a notarized form must include the notary publics signature; the date that the practitioner appeared before the notary; the date the notarys commission expires; and the notarys stamp, seal, or notary number. Please submit a new, fully completed and notarized form to the Data Bank(s).');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','41','Missing or invalid credit card information.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','42','Your registered entity does not have a valid EFT account on file.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','43','Expired credit card: please contact your credit card company for further information.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','44','Rejected credit card: the bank that issued your credit card has denied these charges. No further information was made available to the data bank(s) regarding the reason for this rejection. Please contact your credit card company for further information.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','45','Duplicate report.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','46','Data Bank Control Number of report to be voided or corrected is missing or invalid.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','47','Query data is missing.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','48','Invalid Query Category code.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','49','Time to dispute a report has expired.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','50','Valid Data Bank Control Number of report to be corrected or voided was not provided.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','51','Cannot dispute a changed/voided report.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','52','Attempted to correct or void a report that has been previously voided or replaced by a corrected version.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','53','Report is already in dispute.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','54','Report is already in Secretarial Review.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','55','Report is not in dispute: cannot withdraw dispute.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','56','Report is not in Secretarial Review: cannot withdraw dispute.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','57','Control character (non-alphanumeric) found in file.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','58','Possible data entry error found.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','59','Credit card bill authorization error.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','61','Query file with this name has already been processed.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','62','Cannot access drive.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','63','Damaged diskette.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','64','Bad sector(s) on disk.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','65','Warning detection error.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','66','No files found on disk.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','67','I/O error.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','68','Missing, invalid, or illegible date of omission. Date of omission must not be later than todays date and not earlier than 1900.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','69','Graduation year is inconsistent with year of birth: the subjects date of birth and year of graduation must be at least 15 years apart.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','70','Length of action is missing or contains more than two digits.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','71','Invalid Agent Identification Number.');"

//End Code Change---11.16.2006
end subroutine

public subroutine of_insert_codes2 ();// 25 Jan 2005 -added chnges for version 1.12
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','72','Entity does not have active status.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','73','Agent does not have active status.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','74','Possible @ sign in data.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','75','Invalid entity phone number.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','76','Invalid entity phone extension.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','77','Invalid certification phone number.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','78','Invalid certification phone extension.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','79','Invalid subject deceased flag.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','80','Invalid subject identification number.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','81','Invalid subject address.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','82','Invalid payment on Medical Malpractice Payment Report.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','83','Invalid Medical Malpractice Payment Report data.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','84','Invalid report category code.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','85','Credit card authorization unavailable: the NPDB-HIPDB experienced communications problems with our credit card authorization service when we attempted to bill your account for the enclosed query. As a result, the charges were not fully authorized and we are unable to process the query. Your credit card account may show a temporary hold for these charges that will expire within 10 days of the process date shown above. If, for any reason, you are billed for the enclosed query file, please contact the NPDB-HIPDB Customer Service Center immediately at 1-800-767-6732. Please create a new query file for the subject names you need to have processed and transmit it to the Data Bank(s). We regret any inconvenience that this may cause.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','86','Unknown record tag was found in input file. Valid tags are PRCT, DEA, FQSL, and GRAD.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','87','Unable to read certification data record.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','88','Unable to read query data record.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','89','Unable to read password data record.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','90','Missing last name from name record.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','91','Missing first name from name record.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','92','Missing password.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','94','Invalid judgment date format.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','95','Invalid Taxpayer Identification Number.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','97','The NPDB-HIPDB no longer accepts payment by check or money order. Entities who wish to query the NPDB-HIPDB must either include valid credit card information in their query files or pre-authorize payment through Electronic Funds Transfer (EFT).');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','98','As of October 1, 1998, the NPDB no longer accepts 5-1/4?diskettes.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','99','Billing problem - transaction on hold.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','A0','The date the action became effective cannot be before the date action was taken.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','A1','Invalid type of adverse action.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','A2','Missing program name in section C.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','A3','Invalid or duplicate Adverse Action Classification code.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','A4','Invalid entry for total amount of monetary penalty, assessment, restitution and/or fine.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','A5','Invalid entry for date of action, date of finding, or date action became effective.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','A6','Invalid length of action.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','A7','Invalid entry in automatic reinstatement field.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','A8','Missing narrative description.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','A9','Invalid entries in the publicly available or professional competence or conduct field.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','AA','Invalid combination of Adverse Action Classification codes. State Licensure actions taken against physicians, dentists, or medical or dental residents may not contain multiple codes when one of the following codes is reported: 1139, 1149, or 1189. Federal Licensure actions taken by the DEA against health care practitioners may not contain multiple codes when one of the following codes is reported: 1149, 1173, or 1189. Exclusion/Debarment actions taken by the HHS Office of Inspector General may not contain multiple codes when one of the following codes is reported: 1508, 1509, 3508, or 3509. Additional actions should be submitted in separate reports.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','AB','Invalid or duplicate Negative Finding Classification code.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','AC','Length of action information should not be included in the report for the selected Adverse Action Classification codes.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','B1','Incomplete individual subject Occupation/Field of Licensure record.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','B2','Incomplete subject Occupation/Field of Licensure information. For each license number you provide, you must also provide a valid, two-letter abbreviation for the U.S. State from where the license was issued, and a valid, three-digit Occupation/Field of Licensure code.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','B3','The specialty code selected is either invalid or incompatible with the occupation/field of licensure code selected. Physician specialty codes should only be used for physicians (occupation/field of licensure codes 010, 015, 020 and 025). Dental specialty codes should only be used for dentists (occupation/field of licensure codes 030 and 035).');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','B4','Invalid organization subject license number.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','B5','Incomplete organization subject license number record.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','B6','Invalid organization subject license number State field.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','B7','Incomplete short organization subject data record.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','B8','Act or Omission code missing or invalid.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','B9','Missing Judgment or Conviction Report information.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','BA','Specialty code is a required field for this occupation/field of licensure selection.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','C0','Incomplete or incorrect Organization Name or Type information. For each organization, you must provide a valid Organization Name and Organization Type.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','C1','Missing or invalid sentence/judgment information.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','C2','Missing Occupation code.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','C3','Invalid Judgment or Conviction Report type record.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','C4','Invalid Food and Drug Administration number(s).');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','C5','Invalid National Provider Identifier(s).');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','C6','Invalid Federal Employer Identification Number(s).');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','C7','Invalid affiliation record.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','C8','Invalid appeal record.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','C9','Incomplete information for statutory offenses and counts.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','D0','Invalid deceased date.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','D1','Invalid deceased flag.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','D2','Invalid health care entity definition entry.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','D3','Invalid type of organization.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','D4','Missing organization name.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','D5','Missing or invalid Basis for Action code.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','D6','Report is not valid under any NPDB-HIPDB statutory authority.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','D7','This type of report does not accept notices of appeal.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','D8','You do not have the statutory authority to submit a notice of appeal for this report.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','D9','Professional school and year of graduation should not be present for non-practitioners.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','E0','Missing basis code.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','E1','No basis code should be present for revision to actions.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','E3','Missing publicly available entry.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','E4','Publicly available field should not be filled in.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','E5','Missing competence or conduct basis entry.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','E6','Competence or conduct entry not applicable to your report.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','E7','You selected a statutory function/service in section C that is incompatible with your selection under at least one other statutory authority. Please review once more the statutory information regarding the eligibility requirements for Title IV, Section 1921, and Section 1128E; then complete and submit a new Entity Registration form.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','E8','Entities that indicate that they are a Federal Government agency in field 8 of the Entity Registration form must also indicate the appropriate Federal department or agency. The receipt of financial support or reimbursement from a Federal Government agency for providing health care services does not qualify an entity as a Federal Government agency. Entities that are not Federal Government agencies may not select a federal department or agency in field 8 of the Entity Registration form.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','E9','1128E clinical privileges Adverse Action Reports are not reportable to the HIPDB. Only the NPDB collects clinical privileges reports under Title IV of Public Law 99-660. Please contact the NPDB-HIPDB Customer Service Center at 1-800-767-6732 to obtain the latest copy of the Adverse Action Report Interface Control Document specification.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','F1','The NPDB-HIPDB no longer accepts reports submitted via QPRAC or paper forms. All reports submitted to the NPDB-HIPDB must be submitted through the Integrated Querying and Reporting Service found on the World Wide Web at http://www.npdb-hipdb.com.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','F2','The NPDB-HIPDB no longer accepts Adverse Action Reports submitted via disk. All Adverse Action Reports submitted to the NPDB-HIPDB must be submitted through the Integrated Querying and Reporting Service found on the World Wide Web at http://www.npdb-hipdb.com.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','F3','The NPDB-HIPDB no longer accepts any transactions submitted via QPRAC. All transactions submitted to the NPDB-HIPDB must be submitted through the Integrated Querying and Reporting Service found on the World Wide Web at http://www.npdb-hipdb.com.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','F4','A correction transaction attempted to correct a revision to action report.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','F5','A revision to action transaction attempted to modify certain fields that must contain the same information as the report being revised: Type of Action, Occupation/Field of Licensure if you are filing a report on an individual subject, as well as Competence/Conduct Basis if you are filing a State licensure report on an individual subject, or Health Care Entity Definition if you are filing a State licensure report on an organizational subject.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','F6','The previous DCN did not match a report in the Data Bank.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','F7','A transaction type was not found for the specified report.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','G1','Set A and set B mandatory fields not complete for individual query.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','G2','Set A and set B mandatory fields not complete for organization query.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','J1','Credit Card Issuer Unavailable: The Data Banks experienced communication problems in contacting your financial institution when we attempted to bill your account for the enclosed query. Since your financial institution was not contacted, your account should not have been charged for this query. If, for any reason, you are billed for the enclosed file, please contact the NPDB-HIPDB Customer Service Center immediately at 1-800-767-6732. Please create a new query file for the subject name(s) in the enclosed query file and transmit it to the Data Bank(s). Should you add additional subject names to your new query, your new charges will be higher than your original charge because fees are levied on a per-name basis. We regret any inconvenience that this may cause.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','J2','Missing or invalid credit card information, the card holder name is missing or not valid.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','J3','Missing or invalid credit card information, the credit card number is not a valid credit card number.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','J4','Missing or invalid credit card information, the credit card expiration date is not valid.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','J5','All or part of the credit card billing address is missing or invalid.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','M0','Specific allegation or date of event is missing or invalid, or description for an unclassified specific allegation is missing.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','M1','Payment date is missing or invalid.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','M2','Description of judgment or settlement is missing.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','M3','Number of practitioners for whom this payer has paid or will pay in this case must be a value between 1 and 999 inclusive.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','M4','State fund payment flag or amount is invalid.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','M5','Self-insured payment flag or amount is invalid.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','M6','Patient age, gender or type is missing or invalid.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','M7','Description of the medical condition with which the patient presented for treatment is missing.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','M8','Description of the procedure performed is missing.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','M9','Nature of allegation code is missing or invalid.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','MA','Outcome is missing or invalid.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','MB','Description of allegations and injuries or illnesses is missing.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','MC','Total amount paid or to be paid by this payer for this practitioner must be greater than or equal to the amount of this payment by this payer for this practitioner.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','MD','Total amount paid or to be paid by this payer for all practitioners must be greater than or equal to total amount paid or to be paid by this payer for this practitioner.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','ME','The NPDB no longer accepts initial Medical Malpractice Payment Reports in legacy format.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','MF','State fund payment flag and/or amount is invalid. Your entity’s relationship to this practitioner (as specified in this submission) does not allow the completion of the state fund payment fields.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q ','MG','Self-insured payment flag or amount is invalid. Your entitys relationship to this practitioner (as specified in this submission) does not allow the completion of the self-insured organization and/or other insurance company payment fields.');"




ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_t','1L','Single Query ?Individual Subject.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_t','1C','Single Query ?Organization Subject.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_t','1A','Multiple-Name Query ?Individual Subject.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_t','1J','Multiple-Name Query ?Organization Subject.');"




ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_U','001','Diagnosis Related 060 Treatment Related');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_U','010','Anesthesia Related 070 Monitoring Related');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_U','020','Surgery Related 080 Equipment/Product Related');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_U','030','Medication Related 090 Other Miscellaneous');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_U','040','IV & Blood Products Related 100 Behavioral Health Related');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_U','050','Obstetrics Related');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_U','060','Treatment Related');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_U','070','Monitoring Related');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_U','080','Equipment/Product Related');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_U','090','Other Miscellaneous');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_U','100','Behavioral Health Related');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','100','Failure to Use Aseptic Technique');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','101','Failure to Diagnose (i.e., Concluding That Patient Has No Disease or Condition Worthy of Follow-Up or Observation)');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','102','Failure to Delay a Case When Indicated');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','103','Failure to Identify Fetal Distress');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','104','Failure to Treat Fetal Distress');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','105','Failure to Medicate');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','106','Failure to Monitor');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','107','Failure to Order Appropriate Medication');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','108','Failure to Order Appropriate Test');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','109','Failure to Perform Preoperative Evaluation');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','110','Failure to Perform Procedure');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','111','Failure to Perform Resuscitation');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','112','Failure to Recognize a Complication');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','113','Failure to Treat Delay In Performance');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','200','Delay in Diagnosis');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','201','Delay in Performance');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','202','Delay in Treatment');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','203','Delay in Treatment of Identified Fetal Distress Error/Improper Performance');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','300','Administration of Blood or Fluids Problem');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','301','Agent Use or Selection Error');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','302','Complementary or Alternative Medication Problem');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','303','Equipment Utilization Problem');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','304','Improper Choice of Delivery Method');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','305','Improper Management');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','306','Improper Performance');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','307','Improperly Performed C-Section');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','308','Improperly Performed Vaginal Delivery');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','309','Improperly Performed Resuscitation');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','310','Improperly Performed Test');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','311','Improper Technique');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','312','Intubation Problem');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','313','Laboratory Error');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','314','Pathology Error');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','315','Medication Administered via Wrong Route');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','316','Patient History, Exam, or Workup Problem');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','317','Problems With Patient Monitoring in Recovery');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','318','Patient Monitoring Problem');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','319','Patient Positioning Problem');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','320','Problem with Appliance, Prostheses, Orthotic, Restorative, Splint, Device, etc.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','321','Radiology or Imaging Error');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','322','Surgical or Other Foreign Body Retained');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','323','Wrong Diagnosis or Misdiagnosis (e.g., Original Diagnosis is Incorrect)');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','324','Wrong Dosage Administered');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','325','Wrong Dosage Dispensed');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','326','Wrong Dosage Ordered of Correct Medication');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','327','Wrong Medication Administered');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','328','Wrong Medication Dispensed');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','329','Wrong Medication Ordered');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','330','Wrong Body Part');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','331','Wrong Blood Type');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','332','Wrong Equipment');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','333','Wrong Patient');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','334','Wrong Procedure or Treatment Unnecessary/Contraindicated Procedure');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','400','Contraindicated Procedure');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','401','Surgical or Procedural Clearance Contraindicated');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','402','Unnecessary Procedure');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','403','Unnecessary Test');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','404','Unnecessary Treatment Communication/Supervision');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','500','Communication Problem Between Practitioners');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','501','Failure to Instruct or Communicate with Patient or Family');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','502','Failure to Report on Patient Condition');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','503','Failure to Respond to Patient');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','504','Failure to Supervise');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','505','Improper Supervision Continuity of Care/Care Management');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','600','Failure/Delay in Admission to Hospital or Institution');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','601','Failure/Delay in Referral or Consultation');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','602','Premature Discharge from Institution');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','603','Altered, Misplaced or Prematurely Destroyed Records Behavior/Legal');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','700','Abandonment');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','701','Assault and Battery');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','702','Breach of Contract or Warranty');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','703','Breach of Patient Confidentiality');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','704','Equipment Malfunction');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','705','Failure to Conform with Regulation, Statute, or Rule');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','706','Failure to Ensure Patient Safety (e.g., from Assault, Falls, Burns, Elopement, etc.)');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','707','Failure to Obtain Consent or Lack of Informed Consent');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','708','Failure to Protect a Third Party (e.g., Failure to Warn or Protect from Violence)');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','709','Failure to Test Equipment');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','710','False Imprisonment');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','711','Improper Conduct');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','712','Inadequate Utilization Review');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','713','Negligent Credentialing');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','714','Practitioner with Communicable Disease');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','715','Product Liability');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','716','Religious Issues');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','717','Sexual Misconduct');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','718','Third Party Claimant');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','719','Vicarious Liability');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','720','Wrongful Life/Birth');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','899','Cannot Be Determined from Available Records');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_V','999','Allegation Not Otherwise Classified, Specify');"

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_w','01','Emotional injury only');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_w','02','Insignificant injury');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_w','03','Minor temporary injury');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_w','04','Major temporary injury');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_w','05','Minor permanent injury');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_w','06','Significant permanent injury');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_w','07','Major permanent injury');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_w','08','Quadriplegic, brain damage, lifelong care');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_w','09','Death');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_w','10','Cannot be determined from available records');"
//Start Code Change ----04.29.2008 #V8 maha - these error codes removed as no longer valid
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','0','Success, no errors');"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','-1','Error on NPDB-HIPDB server, reattempt transfer');"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','-4','Database error on NPDB-HIPDB server, reattempt transfer');"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','-18','Error in downloaded response files, reattempt transfer');"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','-19','Error in getting information from the downloaded file, reattempt transfer');"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','-20','Unable to open downloaded file, check if sufficient disk space is available to download file and reattempt transfer');"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','-21','Generic error code; used for failures not yet categorized');"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','-22','Usage error, check command-line parameter');"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','-23','Error in reading Initialization file itp.ini, check that itp.ini file is in working directory');"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','-24','Unable to open program log file, check that disk space is available');"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','-25','Error in username and password validation, check that the DBID and password are correct');"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','-30','Error validating parameter in itp.ini, a parameter is missing or value is invalid');"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','-31','Error validating UploadFile, upload file missing or a file listed in the upload file does not exist');"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','-32','Error validating DownloadDir, directory does not exist');"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','-40','Error opening connection to NPDB-HIPDB server, check internet connection and reattempt transfer');"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','-41','Error getting input stream to NPDB-HIPDB server, check internet connection and reattempt transfer');"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','-42','Error getting output stream from NPDB-HIPDB server, check internet connection and reattempt transfer');"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','-50','Error reading status response from NPDB-HIPDB server, reattempt transfer');"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','-51','Error processing web request, reattempt transfer');"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','-52','Error getting status code, reattempt transfer');"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','-53','Error sending submission files, reattempt transfer');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','603', 'Chiropractor')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','621', 'Counselor, Mental Health')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','651','Professional Counselor')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','654', 'Professional Counselor, Alcohol')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','657', 'Professional Counselor, Family/Marriage')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','660', 'Professional Counselor, Substance Abuse')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','661', 'Marriage and Family Therapist')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','030', 'Dentist')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','035', 'Dental Resident')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','606', 'Dental Assistant')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','609', 'Dental Hygienist')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','612', 'Denturist')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','200', 'Dietician')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','210', 'Nutritionist')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','250', 'EMT, Basic')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','260', 'EMT, Cardiac/Critical Care')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','270', 'EMT, Intermediate')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','280', 'EMT, Paramedic')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','630', 'Ocularist')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','633', 'Optician')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','636', 'Optometrist')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','100', 'Registered (Professional) Nurse')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','110', 'Nurse Anesthetist')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','120', 'Nurse Midwife')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','130', 'Nurse Practitioner')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','140', 'Licensed Practical or Vocational Nurse')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','141', 'Clinical Nurse Specialist')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','150', 'Nurses Aide')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','160', 'Home Health Aide (Homemaker)')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','050', 'Pharmacist')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','055', 'Pharmacy Intern')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','060', 'Pharmacist, Nuclear')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','070', 'Pharmacy Assistant')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','075', 'Pharmacy Technician')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','010', 'Physician (MD)')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','015', 'Physician Intern/Resident (MD)')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','020', 'Osteopathic Physician (DO)')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','025', 'Osteopathic Physician Intern/Resident(DO)')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','642', 'Physician Assistant, Allopathic')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','645', 'Physician Assistant, Osteopathic')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','350', 'Podiatrist')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','648', 'Podiatric Assistant')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','371', 'Psychologist')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','372', 'School Psychologist')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','373', 'Psychological Assistant, Associate,')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','402', 'Art/Recreation Therapist')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','405', 'Massage Therapist')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','410', 'Occupational Therapist')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','420', 'Occupational Therapy Assistant')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','430', 'Physical Therapist')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','440', 'Physical Therapy Assistant')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','450', 'Rehabilitation Therapist')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','663', 'Respiratory Therapist')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','666', 'Respiratory Therapy Technician')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','300', 'Social Worker')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','400', 'Audiologist')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','460', 'Speech/Language Pathologist')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','500', 'Medical Technologist')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','505', 'Cytotechnologist')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','510', 'Nuclear Medicine Technologist')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','520', 'Radiation Therapy Technologist')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','530', 'Radiologic Technologist')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','600', 'Acupuncturistv')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','601', 'Athletic Trainer')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','615', 'Homeopath')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','618', 'Medical Assistant')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','624', 'Midwife, Lay (Non-Nurse)')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','627', 'Naturopath')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','639', 'Orthotics/Prosthetics Fitter')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','647', 'Perfusionist')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','170', 'Psychiatric Technician')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','699', 'Other Health Care Practitioner - Not Classified, ')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','752', 'Adult Care Facility Administrator')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','755' ,'Hospital Administrator')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','758', 'Long-Term Care Administrator')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','850', 'Accountant')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','853', 'Bookkeeper')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','822', 'Business Manager')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','830', 'Business Owner')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','820', 'Corporate Officer')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','810', 'Insurance Agent')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','812', 'Insurance Broker')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','800', 'Researcher, Clinical')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','840', 'Salesperson')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_c','899', 'Other Occupation - Not Classified')"


ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h', '1610' , 'Revocation of Clinical Privileges')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1630','Suspension of Clinical Privileges')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1632','Summary or Emergency Suspension of Clinical Privileges')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1635','Voluntary Surrender of Clinical Privilege(s), While Under, or to Avoid, Investigation Relating to Professional Competence or Conduct')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1640','Reduction of Clinical Privileges')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1645','Other Restriction/Limitation of Clinical Privileges')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1650','Denial of Clinical Privileges')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1680','Clinical Privileges Restored or Reinstated, Complete')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1681','Clinical Privileges Restored or Reinstated, Conditional')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1689','Clinical Privileges Restoration or Reinstatement Denied')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1690','Reduction of Previous Action')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1695','Extension of Previous Action')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1920','Contract Termination')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1930','Suspension of Contract')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1932','Administrative Fine/Monetary Penalty')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1941','Employment Termination')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1942','Employment Suspension')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1950','Denial of Contract Application or')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1989','Other Health Plan Action, Specify')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1990','Reinstatement')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1992','Reinstatement Denied')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1995','Reduction of Previous Action')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1996','Extension of Previous Action')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1110','Revocation of License')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1125','Probation of License')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1135','Suspension of License')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1139','Summary or Emergency Suspension of License ')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1140','Reprimand or Censure')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1145','Voluntary Surrender of License')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1147','Limitation or Restriction on License')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1148','Denial of License Renewal')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1149','Denial of Initial License')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1173','Publicly Available Fine/Monetary Penalty2')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1189','Publicly Available Negative Action or Finding')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1199','Other Licensure Action - Not Classified')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1280','License Restored or Reinstated, Complete')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1282','License Restored or Reinstated, Conditional')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1285','License Restoration or Reinstatement Denied')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1295','Reduction of Previous Action')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1296','Extension of Previous Action')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1510','Termination of Medicare or Other Federal Health Care Program Participation')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1512','Voluntary Termination of Medicare or Other Federal Health Care Program Participation After Notification of Investigation or Disciplinary Action')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1513','Nonrenewal of Medicare or Other Federal Health Care Program Participation Agreement for Cause')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1517','Voluntary Termination of Medicaid or Other State Health Care Program Participation After Notification of Investigation or Disciplinary Action')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1518','Nonrenewal of Medicaid or Other State Health Care Program Participation Agreement for Cause')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1520','Contract Termination')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1530','Civil Money Penalty')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1532','Administrative Fine/Monetary Penalty')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1550','Disqualification of Clinical Investigator From Receiving Investigational Products')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1551','Termination of Medicaid or Other State Health Care Program Participation')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1555','Employment Disqualification Based on Finding in State Nurse Aide Registry')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1560','Personnel Action - Employee Termination')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1562','Personnel Action - Employee Suspension')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1565','Personnel Action - Not Classified')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1589','Other Action - Not Classified')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1590','Reinstatement')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1592','Reinstatement Denied')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1595','Reduction of Previous Action')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1596','Extension of Previous Action')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1710','Revocation of Professional Society')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1730','Suspension of Professional Society')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1745','Other Restriction/Limitation on Professional')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1750','Denial of Professional Society Membership')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1780','Membership Reinstated, Complete')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1781','Membership Reinstated, Conditional')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1789','Membership Reinstatement Denied')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1790','Reduction of Previous Action')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_h','1795','Extension of Previous Action')"
//


ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','60','Felony Conviction Relating to Health Care Fraud')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','61',' Felony Conviction Relating to Controlled Substance Violations')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','62',' Program-Related Conviction')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','63',' Conviction Relating to Patient Abuse or Neglect')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','64','Conviction Relating to Fraud')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','65','Conviction Relating to Obstruction of an Investigation')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','66','Conviction Relating to Controlled Substances')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','69','Criminal Conviction - Not Classified')"

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','31','Failure to Comply With Health and Safety Requirements')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','32','Lack of Appropriately Qualified Professionals')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','34','Financial Insolvency')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','40','Exclusion or Suspension From a Federal or State Health Care Program')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','42','Individuals Controlling Sanctioned Entities')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','44','Default on Health Education Loan or Scholarship Obligations')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','46','Failure to Grant Immediate Access')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','47','Failure to Take Corrective Action')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','51','Failure to Perform Contractual Obligations')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','57','Fraud, Kickbacks and Other Prohibited Activities')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','58','Imposition of Civil Money Penalty or Assessment')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','59','Peer Review Organization Recommendation')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','A1','Failure to Meet the Initial Requirements of a License')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','A2','Failure to Comply With Continuing Education or Competency Requirements')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','A3','Failure to Meet Licensing Board Reporting Requirements')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','A5','Violation of or Failure to Comply With Licensing Board Order')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','A6','Violation of Federal or State Statutes, Regulations or Rules')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','D3','Exploiting a Patient for Financial Gain')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','E2','Providing or Ordering Unnecessary Tests or Services')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','E5','Misleading, False or Deceptive Advertising or Marketing')"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_k_1','FB','Excessive Malpractice Cases/Extensive Malpractice History')"

//// PFC message table
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO messages VALUES ('pfc_closequery_savechanges','Application','Do you want to save changes?','Exclamation','YesNoCancel',1,0,'N','N');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO messages VALUES ('pfc_closequery_failsvalidation','Application','The information entered does not pass validation and must be corrected before changes can be saved.~r~n~r~nClose without saving changes?','Exclamation','YesNo',2,5,'N','N');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO messages VALUES ('pfc_requiredmissing','Application','Required value missing for %s on row %s.  Please enter a value.','Information','Ok',1,5,'N','N');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO messages VALUES ('pfc_dwdberror','Application','%s','StopSign','Ok',1,20,'N','N');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO messages VALUES ('pfc_systemerror',	'System Error','%s','StopSign','Ok',1,20,'N','N');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO messages VALUES ('pfc_dwlinkage_rowchanging','Application','Updates are pending. ~r~n Save them now?','Exclamation','YesNoCancel',1,0,'N','N');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO messages VALUES ('pfc_dwlinkage_predelete','Application','Delete row(s)?','Exclamation','OkCancel',1,0,'N','N');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO messages VALUES ('pfc_dwlinkage_requiredmissing','Application','Required value missing for %s on row %s.  Please enter a value.','Information','Ok',1,5,'N','N');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO messages VALUES ('pfc_dsaccepttext','Application','Failed accepttext validation on datastore.  Column  %s  on row  %s.','Exclamation','Ok',	1,20,'N','Y');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO messages VALUES ('pfc_requiredmissingondatastore','Application','Required value missing for %s on row %s.','StopSign','Ok',	1,20,'N','Y');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "delete from code_lookup where lookup_name = 'Measurement Reason';"
//INSERT INTO code_lookup (lookup_code,lookup_name,code,description)
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))  +  ",'Measurement Reason','1','Initial Appointment');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))   + ",'Measurement Reason','2','Provisional');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup (lookup_code,lookup_name,code,description) VALUES (" + string(gnv_app.of_get_id("LOOKUP"))   + ",'Measurement Reason','3','Peer Review');"
///ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO code_lookup VALUES (" + string(gnv_app.of_get_id("LOOKUP"))   + ",'Verification Method','3','NPDB/HIB'       ,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,null);"


of_insert_dbcontrol()



//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (35,'d_npdb_mmr',NULL,NULL);"


//// facility
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO facility VALUES (46,'d_npdb_supplsnd',NULL,NULL);"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (47,'d_npdb_upin',12,NULL);"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (48,'d_npdb_rpoc',NULL,NULL);"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (49,'d_npdb_qry',2,2);"
//ls_sql_statments[upperbound(ls_sql_statments) + 1] = "INSERT INTO npdb_control VALUES (50,'d_npdb_qsta',NULL,	NULL);"

end subroutine

public subroutine of_insert_new_error_codes ();//Start Code Change ----04.29.2008 #V8 maha - copied from w_priv_updates for reinserting theses codes in w_npdb_lookups utility


string ls_sql
integer i

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C00','Success, no errors');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C01','Error on NPDB-HIPDB server, reattempt transfer');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C04','Database error on NPDB-HIPDB server, reattempt transfer');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C06','Database connection error on NPDB-HIPDB server, reattempt transfer');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C08','Communication error with NPDB-HIPDB ICD server during response retrieval, reattempt transfer.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C18','Error in downloaded response files, reattempt transfer');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C19','Error in getting information from the downloaded file, reattempt transfer');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C20','Unable to open downloaded file, check if sufficient disk space is available to download file and reattempt transfer');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C21','Generic error code; used for failures not yet categorized');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C22','Usage error, check command-line parameter');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C23','Error in reading Initialization file itp.ini, check that itp.ini file is in working directory');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C24','Unable to open program log file, check that disk space is available');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C25','Error in username and password validation, check that the DBID and password are correct');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C30','Error validating parameter in itp.ini, a parameter is missing or value is invalid');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C31','Error validating UploadFile, upload file missing or a file listed in the upload file does not exist');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C32','Error validating DownloadDir, directory does not exist');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C40','Error opening connection to NPDB-HIPDB server, check internet connection and reattempt transfer');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C41','Error getting input stream to NPDB-HIPDB server, check internet connection and reattempt transfer');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C42','Error getting output stream from NPDB-HIPDB server, check internet connection and reattempt transfer');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C50','Error reading status response from NPDB-HIPDB server, reattempt transfer');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C51','Error processing web request, reattempt transfer');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C52','Error getting status code, reattempt transfer');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C53','Error sending submission files, reattempt transfer');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C54','Error downloading response files, reattempt transfer.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C55','Error moving response files to the download directory, no permission to write to the directory or the device has run out of space.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C56','Your password change request could not be successfully processed. Download the response file for further details.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C57','Your account has been locked out. Contact your entity administrator to reset the password. If you are using an administrator account, contact the NPDB-HIPDB Customer Service Center to reset the password.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C58','Your account has been locked out. The number of invalid login attempts has exceeded the allowable login limit. Contact your entity administrator to reset the password. If you are using an administrator account, contact the NPDB-HIPDB Customer Service Center to reset the password.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C59','Your account password has expired. Contact your entity administrator to reset the password. If you are using an administrator account, contact the NPDB-HIPDB Customer Service Center to reset the password.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C60','Unable to process submission files. The files are not in the appropriate format. Check to ensure that the files are not zipped or in a binary format prior to resubmission.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C61','Your password must be changed before other transactions can be submitted.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C62','The entity identified by the DBID in itp.ini does not have active status.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C63','The entity identified by the DBID in itp.ini does not match the DBID in the submission file.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C64','No more than one password change transaction can be listed in the upload file UploadFile at any time. Modify UploadFile to include only one password change transaction, reattempt transfer.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C65','Password change transaction processing was successful but an error occurred sending the other transaction files. Re-encode new password if necessary, remove password change transactions from the upload file UploadFile, and reattempt transfer of other transaction files.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('error_cd','C66','Password change transaction processing failed but the other transaction files were sent successfully. Modify the upload file UploadFile to include only one password change transaction, reattempt transfer.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "alter table facility add npdb_user_id varchar(35) null;"


end subroutine

public function integer of_delete_npdb_data (long al_hdr_id);//Start Code Change ----05.01.2008 #V8 maha - function created to delete data connected to an NPDB hrd record (or all)

integer i
string ls_table
string ls_sql
string ls_where

if al_hdr_id > 0 then
	ls_where = " Where npdb_hdr_id = " + string(al_hdr_id ) + ";"
else //delete all
	ls_where = ";"
end if

//------------ APPEON BEGIN ------------
//$<Add> 12.15.2009 By: Evan
//$<Reason> V10.1 - NPDB QRXS
if il_Interface = QRXS_INTERFACE then
	ls_sql += "DELETE FROM npdb_qrxs_hdr" + ls_where
	ls_sql += "DELETE FROM npdb_qrxs_status" + ls_where
	ls_sql += "DELETE FROM npdb_qrxs_individual" + ls_where
	ls_sql += "DELETE FROM npdb_qrxs_aar" + ls_where
	ls_sql += "DELETE FROM npdb_qrxs_jocr" + ls_where
	ls_sql += "DELETE FROM npdb_qrxs_mmpr" + ls_where
	ls_sql += "DELETE FROM npdb_qrxs_laar" + ls_where
	ls_sql += "DELETE FROM npdb_qrxs_lmmpr" + ls_where
	ls_sql += "DELETE FROM npdb_qrxs_contact" + ls_where	//add by stephen 09.19.2012 - delete npdb_qrxs_contact  (v12.2 modify NPDB qrxs report)
	ls_sql += "DELETE FROM npdb_qrxs_individual_total" + ls_where //add by stephen 11.05.2012 - delete npdb_qrxs_individual_total  (v12.2 modify NPDB qrxs report)
	gnv_appeondb.of_StartQueue()
	execute immediate :ls_sql using sqlca;
	commit using sqlca;
	gnv_appeondb.of_CommitQueue()
	Return 1
end if
//------------ APPEON END --------------

for i = 1 to 52
	choose case i
		case 1
			ls_table = "npdb_aar"
		case 2
			ls_table = "npdb_aart"
		case 3
			ls_table = "npdb_aff"
		case 4
			ls_table = "npdb_agnt"
		case 5
			ls_table = "npdb_alias"
		case 6
			ls_table = "npdb_aocd"
		case 7
			ls_table = "npdb_apeal"
		case 8
			ls_table = "npdb_bactn"
		case 9
			ls_table = "npdb_caar"
		case 10
			ls_table = "npdb_cert"
		case 11
			ls_table = "npdb_clia"
		case 12
			ls_table = "npdb_cuse"
		case 13
			ls_table = "npdb_dea"
		case 14
			ls_table = "npdb_enty"
		case 15
			ls_table = "npdb_er"
		case 16
			ls_table = "npdb_esln"
		case 17
			ls_table = "npdb_esubj"
		case 18
			ls_table = "npdb_esuppl"
		case 19
			ls_table = "npdb_fda"
		case 20
			ls_table = "npdb_fein"
		case 21
			ls_table = "npdb_fqsl"
		case 22
			ls_table = "npdb_fsta"
		case 23
			ls_table = "npdb_grad"
		case 24
			ls_table = "npdb_hosp"
		case 25
			ls_table = "npdb_invtg"
		case 26
			ls_table = "npdb_isofl"
		case 27
			ls_table = "npdb_isubj"
		case 28
			ls_table = "npdb_isuppl"
		case 29
			ls_table = "npdb_itin"
		case 30
			ls_table = "npdb_jocr"
		case 31
			ls_table = "npdb_jocrt"
		case 32
			ls_table = "npdb_laart"
		case 33
			ls_table = "npdb_medicarep"
		case 34
			ls_table = "npdb_mmrp"
		case 35
			ls_table = "npdb_mmr"
		case 36
			ls_table = "npdb_mmrt"
		case 37
			ls_table = "npdb_npi"
		case 38
			ls_table = "npdb_oenam"
		case 39
			ls_table = "npdb_pdcn"
		case 40
			ls_table = "npdb_poo"
		case 42
			ls_table = "npdb_prct"
		case 43			
			ls_table = "npdb_qsta"
		case 44
			ls_table = "npdb_qrsd"
		case 45
			ls_table = "npdb_qry"	
		case 46
			ls_table = "npdb_rsdr"
		case 47
			ls_table = "npdb_sj"
		case 48
			ls_table = "npdb_ssn"
		case 49
			ls_table = "npdb_statoc"
		case 50
			ls_table = "npdb_supplsnd"
		case 51
			ls_table = "npdb_upn"
		case 52
			ls_table = "npdb_hdr"
//		case 49
//			ls_table = ""

				
	end choose
	ls_sql = "Delete from " + ls_table + ls_where
	execute immediate :ls_sql using sqlca;
	commit using sqlca;
	
next

return 1
end function

private function integer of_create_upload_dat_indv (string as_docid);////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : of_create_upload_dat
//==================================================================================================================
//  Purpose   	: Create the upload datafile (one doc per file)
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	   called from of_send
//==================================================================================================================
//  Created By	: Michael Skinner  
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

string ls_tag_array[] // array of tags to be sent to the DB
long   ll_i           // counter
long   ll_j
integer li_fail
string ls_text_string // the string being written to the file
string maha[] //Start Code Change ----10.03 .2006 #658 maha

/////////////////////////////////////////////////////////////////////////
// filter and sort the datawindow listing
/////////////////////////////////////////////////////////////////////////


ids_dw_datatore.setfilter("not isNull(submission_indv_order)")
ids_dw_datatore.filter()
ids_dw_datatore.setsort("submission_indv_order A")
ids_dw_datatore.sort()

//if ids_dw_datatore.rowcount() <> 13 then messagebox('of_create_upload_dat','')

// CREATE THE ARRAY IN THE PROPER ORDER (DATABASE DRIVEN)

for ll_i = 1 to ids_dw_datatore.rowcount()
	// find the datawindow in the array of dw
	for ll_j = 1 to upperbound(ids_npdb_dws)
	  if ids_npdb_dws[ll_j].DataObject = ids_dw_datatore.object.dw_name[ll_i]  then
           ls_tag_array[upperbound(ls_tag_array) + 1] = UPPER(MidA(string(ids_npdb_dws[ll_j ].DATAOBJECT),8,LenA(ids_npdb_dws[ll_j ].DATAOBJECT) ))
     end if 
    next
next


/////////////////////////////////////////////////////
// NOW ASSEMBLE THE STRINGS
/////////////////////////////////////////////////////
//Start Code Change ---- 10.03.2006 #658 maha
FOR LL_I = 1 TO UPPERBOUND(ls_tag_array)
	maha[ll_i] = ls_tag_array[LL_I] //copy the original values for trapping below
	CHOOSE CASE ls_tag_array[LL_I]
		CASE 'HDR'
			ls_tag_array[LL_I] = of_create_hdr()
		CASE 'QRY'
			ls_tag_array[LL_I] = of_create_qry()
		CASE 'CERT'
			ls_tag_array[LL_I] = of_create_cert()
		CASE 'ISUBJ'
			ls_tag_array[LL_I] = of_create_isubj()
		CASE 'DEA'
			ls_tag_array[LL_I] = of_create_dea()
		CASE 'ISOFL'
			ls_tag_array[LL_I] = of_create_isofl_new()
		CASE 'GRAD'
			ls_tag_array[LL_I] = of_create_grad()
		CASE 'ALIAS'
			ls_tag_array[LL_I] = of_create_alias()
		CASE 'SSN'
			ls_tag_array[LL_I] = of_create_ssn()
		CASE 'FIEN'
			ls_tag_array[LL_I] = of_create_fien()
		CASE 'NPI'
			ls_tag_array[LL_I] = of_create_npi()
		CASE 'UPIN'
			ls_tag_array[LL_I] = of_create_upin()
		CASE 'CUSE'
			ls_tag_array[LL_I] = of_create_cuse()
      		CASE 'ITIN'
			ls_tag_array[LL_I] = of_create_itin() 
	END CHOOSE
	
NEXT
// add the trailer

ls_tag_array[upperbound(ls_tag_array[]) + 1 ] = TLR

string ls_temp
//string ls_temp_sect
for ll_i = 1 to upperbound(ls_tag_array)
	ls_temp = ls_tag_array[ll_i]
	//ls_temp_sect = ls_tag_array[LL_I]
//Start Code Change ----04.25.2008 #V8 maha -  added section failure
	if ls_temp = "Failed" then
		is_failed_doc_id[upperbound(is_failed_doc_id) + 1] = as_docid //Start Code Change ----05.02.2008 #V8 maha - get failed so can trap in add tracker id
		of_failed_message(maha[LL_I] )
		li_fail ++
	elseif isnull(ls_temp) then 
		//messagebox(maha[ll_i], "failure to create text file" )
		//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
		inv_message.of_MessageBox(maha[ll_i], "failure to create text file",true)
		li_fail ++
	end if
//End Code Change---04.25.2008	
	ls_text_string =  ls_text_string + ls_temp
	//ls_text_string =  ls_text_string + ls_tag_array[ll_i]
next
//debugbreak()
if li_fail > 0 then 
	
	return - 1
end if
IF ISNULL(ls_text_string) OR LenA(TRIM(ls_text_string)) < 1 THEN 
	
	//MESSAGEBOX('','ls_text_string IS NULL')
	//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
	inv_message.of_MessageBox('','ls_text_string IS NULL',true)
	return -1
end if
//End Code Change---10.03.2006

of_create_file(is_directories[3] + '\'+ is_current_file_name + '.dat' , ls_text_string)


ids_dw_datatore.setfilter("")
ids_dw_datatore.filter()



return 0
end function

public function integer of_create_classpath_old ();/******************************************************************************************************************
**  [PUBLIC]   : of_create_classpath
**==================================================================================================================
**  Purpose   	: Create the classpath string
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	 Example : SET CLASSPATH=.;C:\Program Files\Java\jre1.5.0_06\bin;C:\project\version5\itp\itp.jar;C:\project\version5\itp\commons-fileupload-1.0.jar;C:\project\version5\itp\commons-httpclient-2.0.jar;C:\project\version5\itp\commons-logging.jar
**=================================================================================================================
**  Created By	: Michael B. Skinner 19 December 2005  ?Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

long ret,ll_return
string ls_null
string ls_current_version
string ls_java_home
string ls_current_class_path
ll_return = success
setnull(ls_null)

///////////////////////////////////////////////////////////////////////////////////////////////
// get the current version of the JRE
///////////////////////////////////////////////////////////////////////////////////////////////

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-02
//$<add> 04.13.2006 By: Cao YongWang
//$<reason> The RegistryGet function is currently unsupported.
//$<modification> Use Appeon DLL function to provide the same functionality.
/*
RegistryGet("HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java Runtime Environment", "CurrentVersion", RegString!, ls_current_version)
*/
If appeongetclienttype() = 'PB' Then
	RegistryGet("HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java Runtime Environment", "CurrentVersion", RegString!, ls_current_version)
Else
	gnv_appeondll.of_RegistryGet("HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java Runtime Environment", "CurrentVersion", RegString!, ls_current_version)
End If
//---------------------------- APPEON END ----------------------------

///////////////////////////////////////////////////////////////////////////////////////////////
// Check to see if java is installed, if not prompt the user to get and then downlaod it, do 
// not continue.
///////////////////////////////////////////////////////////////////////////////////////////////

if not f_validstr(ls_current_version) then 
	if messagebox('Java JRE Missing','The JRE is not installed on this machine. Would you like to install it now?',question!,yesNo!,1) = 1 then 
		//--------------------------- APPEON BEGIN ---------------------------
		//$<ID> PT-05
		//$<modify> 03.24.2006 By: Liang QingShi
		//$<reason> Performance tuning
		//$<modification> This original script opens a new page in the same IE, which is incorrect.
		//$<modification> Modify the script to open a new IE instead of open a new page in the same IE.
		/*
        ShellExecuteA ( Handle( This ), "open", "http://jdl.sun.com/webapps/download/AutoDL?BundleId=10342"  , ls_Null, ls_Null, 0)
		*/
      
	//ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', "http://jdl.sun.com/webapps/download/AutoDL?BundleId=10342"  , ls_Null, 0)   //Commented by (Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
		ShellExecuteA(Handle(This), "open", of_getbrowserversion( ), "http://jdl.sun.com/webapps/download/AutoDL?BundleId=10342", ls_Null, 0)  //(Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
	   //---------------------------- APPEON END ----------------------------   
		return failure
	end if 
end if 
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-03
//$<add> 04.13.2006 By: Cao YongWang
//$<reason> The RegistryGet function is currently unsupported.
//$<modification> Use Appeon DLL function to provide the same functionality.
/*
RegistryGet("HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java Runtime Environment\" + ls_current_version , "JavaHome", RegString!, ls_java_home)
*/
If appeongetclienttype() = 'PB' Then
	RegistryGet("HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java Runtime Environment\" + ls_current_version , "JavaHome", RegString!, ls_java_home)
Else
	gnv_appeondll.of_RegistryGet("HKEY_LOCAL_MACHINE\SOFTWARE\JavaSoft\Java Runtime Environment\" + ls_current_version , "JavaHome", RegString!, ls_java_home)
End If
//---------------------------- APPEON END ----------------------------

///////////////////////////////////////////////////////////////////////////////////////////////
// Createe the class path
///////////////////////////////////////////////////////////////////////////////////////////////
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-04
//$<add> 04.13.2006 By: Cao YongWang
//$<reason> The RegistryGet function is currently unsupported.
//$<modification> Use Appeon DLL function to provide the same functionality.
/*
RegistryGet("HKEY_CURRENT_USER\Environment", "classpath", RegString!, ls_current_class_path)
*/
If appeongetclienttype() = 'PB' Then
	RegistryGet("HKEY_CURRENT_USER\Environment", "classpath", RegString!, ls_current_class_path)
Else
	gnv_appeondll.of_RegistryGet("HKEY_CURRENT_USER\Environment", "classpath", RegString!, ls_current_class_path)
End If
//---------------------------- APPEON END ----------------------------
//messagebox("is_current_path",is_current_path)
//Start Code Change ---- 06.27.2007 #V7 maha change for new itpfile
//is_classpath = ".;" + ls_java_home + "\bin;" + is_current_path + "\itp\itp.jar;" + is_current_path + "\itp\commons-fileupload-1.0.jar;" + is_current_path + "\itp\commons-httpclient-2.0.jar;" + is_current_path + "\itp\commons-logging.jar"
is_classpath = ".;" + ls_java_home + "\bin;" + is_current_path + "\itp\itp.jar;" + is_current_path + "\itp\commons-fileupload-1.1.jar;" + is_current_path + "\itp\commons-httpclient-2.0.jar;" + is_current_path + "\itp\commons-logging.jar;" + is_current_path + "\itp\commons-codec-1.3.jar"
//set classpath=.;C:\Program Files\Java\jre1.6.0_01\bin;C:\intellicred\itp\itp.jar;C:\intellicred\itp\commons-fileupload-1.1.jar;C:\intellicred\itp\commons-httpclient-2.0.jar;C:\intellicred\itp\commons-logging.jar;C:\intellicred\itp\commons-codec-1.3.jar
//End Code Change---06.27.2007

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-05
//$<add> 04.13.2006 By: Cao YongWang
//$<reason> The RegistryGet function is currently unsupported.
//$<modification> Use Appeon DLL function to provide the same functionality.
/*
RegistrySet( "HKEY_CURRENT_USER\Environment", "classpath", RegString!, is_classpath)
*/
If appeongetclienttype() = 'PB' Then
	RegistrySet( "HKEY_CURRENT_USER\Environment", "classpath", RegString!, is_classpath)
Else
	gnv_appeondll.of_RegistrySet( "HKEY_CURRENT_USER\Environment", "classpath", RegString!, is_classpath)
End If
//---------------------------- APPEON END ----------------------------

///////////////////////////////////////////////////////////////////////////////////////////////
// if the classpath is new we must log on and off,
///////////////////////////////////////////////////////////////////////////////////////////////

if ls_current_class_path <> is_classpath then 
	if messagebox('New ClassPath Set', 'A new class path has been set, you must log off before using the NPDB. Would you like to do this now?',question!,YESNO!,1) = 1 then 
		// start intellicred once the os starts
		RegistrySet( "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\RUNONCE", "DEFAULT", RegString!, is_current_path + "\intellicred.exe")
		// exit windows
		ExitWindowsEx(0,0)
	end if 
	return failure
end if 

return success
end function

private function integer of_create_qrxs_upload_file (string as_docid);//////////////////////////////////////////////////////////////////////
// $<function> of_create_qrxs_upload_file
// $<arguments>
//			string	as_docid
// $<returns> integer
// $<description> Create upload files (V10.1 - NPDB QRXS)
//////////////////////////////////////////////////////////////////////
// $<add> Evan 11.24.2009
//////////////////////////////////////////////////////////////////////

string ls_XML, ls_File
string ls_npdb_entity_dbid, ls_npdb_agent_dbid, ls_npdb_user_id
string ls_npdb_pay_type, ls_npdb_cc_nbr, ls_npdb_cc_exp, ls_cc_cardholder, ls_cc_billing_addr1, ls_cc_billing_city, ls_cc_billing_state, ls_cc_zip5
string ls_npdb_cert_name, ls_npdb_cert_title, ls_npdb_cert_phone, ls_npdb_cert_ext, ls_npdb_cert_date
string ls_pd_basic_last_name, ls_pd_basic_first_name, ls_pd_basic_middle_name
string ls_pd_basic_gender, ls_pd_basic_date_of_birth, ls_pd_basic_ssn, ls_pd_basic_npi_number
string ls_pd_address_street[2], ls_pd_address_street_2[2], ls_pd_address_city[2], ls_pd_address_state[2], ls_pd_address_zip[2]
string ls_lic_field, ls_lic_num, ls_lic_state, ls_lic_desc, ls_spec, ls_speciality
string ls_Element, ls_year_thru, ls_instition_name
long   ll_Row, ll_FindRow, ll_prac_id, ll_speciality_code, ll_Grad, ld_lookup_code, ll_lookup_code_arr[]
DataStore lds_fien, lds_dea, lds_upin, lds_grad, lds_address_lookup, lds_speciality, lds_lic
boolean lb_home = false //maha 04.14.2010 - for home address
is_current_facility_id = String(ids_pracs.object.fac_id[1])

//////////////////////////////////////////////////////////////////////
// Get submission information
ll_prac_id = ids_pracs_info.object.prac_id[1]
lds_fien = Create DataStore
lds_fien.DataObject = "d_npdb_pd_fien"
lds_fien.SetTransObject(SQLCA)
lds_dea = Create DataStore
lds_dea.DataObject = "d_npdb_pd_dea"
lds_dea.SetTransObject(SQLCA)
lds_upin = Create DataStore
lds_upin.DataObject = "d_npdb_pd_upin"
lds_upin.SetTransObject(SQLCA)
lds_grad = Create DataStore
lds_grad.DataObject = "d_npdb_grad2"
lds_grad.SetTransObject(SQLCA)
lds_speciality = Create DataStore
lds_speciality.DataObject = "d_npdb_pd_speciality"
lds_speciality.SetTransObject(SQLCA)
lds_lic = Create DataStore
lds_lic.DataObject = "d_npdb_pd_lic"
lds_lic.SetTransObject(SQLCA)

gnv_appeondb.of_StartQueue()
lds_fien.Retrieve(ll_prac_id)
lds_dea.Retrieve(ll_prac_id)
lds_upin.Retrieve(ll_prac_id)
lds_address_info.Retrieve(ll_prac_id, il_current_fac_id)
lds_grad.Retrieve(ll_prac_id)
lds_speciality.Retrieve(ll_prac_id)
lds_lic.Retrieve(ll_prac_id)
SELECT npi_number INTO :ls_pd_basic_npi_number FROM pd_basic WHERE prac_id = :ll_prac_id;
gnv_appeondb.of_CommitQueue()

//Start Code Change ----11.14.2011 #V12 maha - trap for no license data
if lds_lic.rowcount() = 0 then
	return -1
end if
//Start Code Change ----11.14.2011

if lds_grad.RowCount() > 0 then
	ll_lookup_code_arr[] = lds_grad.object.institution_code[1, lds_grad.RowCount()]
	lds_address_lookup = Create Datastore
	lds_address_lookup.Dataobject = "d_address_lookup_forpt"
	lds_address_lookup.Settransobject(SQLCA)
	lds_address_lookup.Retrieve(ll_lookup_code_arr[])
end if

// <submitter>
if not IsNull(ids_npdb_fac_info.object.npdb_entity_dbid[1]) then ls_npdb_entity_dbid = ids_npdb_fac_info.object.npdb_entity_dbid[1]
if not IsNull(ids_npdb_fac_info.object.npdb_agent_dbid[1]) then ls_npdb_agent_dbid = ids_npdb_fac_info.object.npdb_agent_dbid[1]
//if not IsNull(ids_npdb_fac_info.object.npdb_user_id[1]) then ls_npdb_user_id = ids_npdb_fac_info.object.npdb_user_id[1]
ls_npdb_user_id = '1111252'  //Start Code Change ----04.13.2010 #V10 maha - used for the vendorid; is a hardcoded value for ISG
// <payment>
if not IsNull(ids_cc_information.object.npdb_pay_type[1]) then ls_npdb_pay_type = ids_cc_information.object.npdb_pay_type[1]
if not IsNull(ids_cc_information.object.npdb_cc_nbr[1]) then ls_npdb_cc_nbr = ids_cc_information.object.npdb_cc_nbr[1]
if not IsNull(ids_cc_information.object.npdb_cc_exp[1]) then ls_npdb_cc_exp = ids_cc_information.object.npdb_cc_exp[1]
if not IsNull(ids_cc_information.object.cc_cardholder[1]) then ls_cc_cardholder = ids_cc_information.object.cc_cardholder[1]
if not IsNull(ids_cc_information.object.cc_billing_addr1[1]) then ls_cc_billing_addr1 = ids_cc_information.object.cc_billing_addr1[1]
if not IsNull(ids_cc_information.object.cc_billing_city[1]) then ls_cc_billing_city = ids_cc_information.object.cc_billing_city[1]
if not IsNull(ids_cc_information.object.cc_billing_state[1]) then ls_cc_billing_state = ids_cc_information.object.cc_billing_state[1]
if not IsNull(ids_cc_information.object.cc_zip5[1]) then ls_cc_zip5 = ids_cc_information.object.cc_zip5[1]
// <certification>
if not IsNull(ids_npdb_fac_info.object.npdb_cert_name[1]) then ls_npdb_cert_name = ids_npdb_fac_info.object.npdb_cert_name[1]
if not IsNull(ids_npdb_fac_info.object.npdb_cert_title[1]) then ls_npdb_cert_title = ids_npdb_fac_info.object.npdb_cert_title[1]
if not IsNull(ids_npdb_fac_info.object.npdb_cert_phone[1]) then 
	ls_npdb_cert_phone = ids_npdb_fac_info.object.npdb_cert_phone[1]
	ls_npdb_cert_phone = of_strip_char("", ls_npdb_cert_phone,"@NUM@")  //Start Code Change ----04.13.2010 #V10 maha - strip to numbers only
end if
if not IsNull(ids_npdb_fac_info.object.npdb_cert_ext[1]) then ls_npdb_cert_ext = ids_npdb_fac_info.object.npdb_cert_ext[1]
if not IsNull(ids_npdb_fac_info.object.npdb_cert_date[1]) then ls_npdb_cert_date = String(ids_npdb_fac_info.object.npdb_cert_date[1],'YYYY-MM-DD')
// <individual>-<name>
if not IsNull(ids_pracs_info.object.last_name[1]) then ls_pd_basic_last_name = ids_pracs_info.object.last_name[1]
if not IsNull(ids_pracs_info.object.first_name[1]) then ls_pd_basic_first_name = ids_pracs_info.object.first_name[1]
if not IsNull(ids_pracs_info.object.middle_name[1]) then ls_pd_basic_middle_name = Trim(ids_pracs_info.object.middle_name[1])
// <individual>-<gender>
if not IsNull(ids_pracs_info.object.gender[1]) then ls_pd_basic_gender = Upper(LeftA(String(ids_pracs_info.object.gender[1]),1))
// <individual>-<birthdate>
if not IsNull(ids_pracs_info.object.date_of_birth[1]) then ls_pd_basic_date_of_birth = String(ids_pracs_info.object.date_of_birth[1],'YYYY-MM-DD')
// <individual>-<workAddress>
lds_address_info.Setfilter("primary_office = 1")
lds_address_info.Filter()
if lds_address_info.RowCount() > 0 then
	if not IsNull(lds_address_info.object.street[1]) then ls_pd_address_street[1] = lds_address_info.object.street[1]
	if not IsNull(lds_address_info.object.street_2[1]) then ls_pd_address_street_2[1] = lds_address_info.object.street_2[1]
	if not IsNull(lds_address_info.object.city[1]) then ls_pd_address_city[1] = lds_address_info.object.city[1]
	if not IsNull(lds_address_info.object.zip[1]) then ls_pd_address_zip[1] =lefta(lds_address_info.object.zip[1], 5)  //Start Code Change ----09.14.2012 #V12 maha
	if not IsNull(lds_address_info.object.state[1]) then
		ls_pd_address_state[1] = gnv_data.of_getitem("code_lookup", "code", "lookup_code = " + String(lds_address_info.object.state[1]))
		if IsNull(ls_pd_address_state[1]) then ls_pd_address_state[1] = ""
	end if
end if
// <individual>-<homeAddress>
lds_address_info.Setfilter("home_address = 1")
lds_address_info.Filter()
if lds_address_info.RowCount() > 0 then
	if not IsNull(lds_address_info.object.street[1]) then ls_pd_address_street[2] = lds_address_info.object.street[1]
	if not IsNull(lds_address_info.object.street_2[1]) then ls_pd_address_street_2[2] = lds_address_info.object.street_2[1]
	if not IsNull(lds_address_info.object.city[1]) then ls_pd_address_city[2] = lds_address_info.object.city[1]
	if not IsNull(lds_address_info.object.zip[1]) then ls_pd_address_zip[2] = lefta(lds_address_info.object.zip[1], 5)  //Start Code Change ----09.14.2012 #V12 maha
	if not IsNull(lds_address_info.object.state[1]) then
		ls_pd_address_state[2] = gnv_data.of_getitem("code_lookup", "code", "lookup_code = " + String(lds_address_info.object.state[1]))
		if IsNull(ls_pd_address_state[2]) then ls_pd_address_state[2] = ""
	end if
	lb_home = true  //Start Code Change ----04.14.2010 #V10 maha
end if
// <individual>-<ssn>
if not IsNull(ids_pracs_info.object.ssn[1]) then ls_pd_basic_ssn = ids_pracs_info.object.ssn[1]

//////////////////////////////////////////////////////////////////////
// Create submission file
//ls_XML = & //evan 05.11.2012 --- header be moved to bottom
//'<?xml version="1.0" encoding="UTF-8"?>' + &
//'<query:querySubmission xmlns:query="http://www.npdb-hipdb.hrsa.gov/Query">' + &
ls_XML = &
'	<submitter>~r~n' + &
'		<entityDBID>' + ls_npdb_entity_dbid + '</entityDBID>'
if LenA(ls_npdb_agent_dbid) > 0 then
	ls_XML += &
'		<agentDBID>' + ls_npdb_agent_dbid + '</agentDBID>'
end if
ls_XML += &
'		<vendorID>' + ls_npdb_user_id + '</vendorID>' + &
'	</submitter>' + &
'	<payment>'
if ls_npdb_pay_type = "A" then
	ls_XML += &
'		<EFT>true</EFT>'
elseif ls_npdb_pay_type = "C" then
	ls_XML += &
'		<creditCard>' + &
'			<number>' + ls_npdb_cc_nbr + '</number>' + &
'			<expirationDate>' + ls_npdb_cc_exp + '</expirationDate>' + &
'			<cardholderName>' + ls_cc_cardholder + '</cardholderName>' + &
'			<cardholderAddress>' + &
'				<address>' + ls_cc_billing_addr1 + '</address>' + &
'				<city>' + ls_cc_billing_city + '</city>' + &
'				<state>' + ls_cc_billing_state + '</state>' + &
'				<zip>' + ls_cc_zip5 + '</zip>' + &
'			</cardholderAddress>' + &
'		</creditCard>'
end if
ls_XML += &
'	</payment>' + &
'	<purpose>P</purpose>' + &
'	<certification>' + &
'		<name>' + ls_npdb_cert_name + '</name>' + &
'		<title>' + ls_npdb_cert_title + '</title>' + &
'		<phone>' + &
'			<number>' + ls_npdb_cert_phone + '</number>' + &
'			<extension>' + ls_npdb_cert_ext + '</extension>' + &
'		</phone>' + &
'		<date>' + ls_npdb_cert_date + '</date>' + &
'	</certification>' + &
'	<individual>' + &
'		<name>' + &
'			<last>' + ls_pd_basic_last_name + '</last>' + &
'			<first>' + ls_pd_basic_first_name + '</first>' + &
'			<middle>' + ls_pd_basic_middle_name + '</middle>' + &
'			<suffix></suffix>' + &
'		</name>' + &
'		<gender>' + ls_pd_basic_gender + '</gender>' + &
'		<birthdate>' + ls_pd_basic_date_of_birth + '</birthdate>' + &
'		<workAddress>' + &
'			<address>' + ls_pd_address_street[1] + '</address>' + &
'			<address2>' + ls_pd_address_street_2[1] + '</address2>' + &
'			<city>' + ls_pd_address_city[1] + '</city>' + &
'			<state>' + ls_pd_address_state[1] + '</state>' + &
'			<zip>' + ls_pd_address_zip[1] + '</zip>' + &
'		</workAddress>'
//Start Code Change ----04.14.2010 #V10 maha - only put in file if there is data 
if lb_home = true then
	ls_XML += &
'		<homeAddress>' + &
'			<address>' + ls_pd_address_street[2] + '</address>' + &
'			<address2>' + ls_pd_address_street_2[2] + '</address2>' + &
'			<city>' + ls_pd_address_city[2] + '</city>' + &
'			<state>' + ls_pd_address_state[2] + '</state>' + &
'			<zip>' + ls_pd_address_zip[2] + '</zip>' + &
'		</homeAddress>' 
end if
//End Code Change ----04.14.2010

//Start Code Change ----08.30.2012 #V12 maha - trap out invalid SSN
if LEN(ls_pd_basic_ssn) <> 9 OR ls_pd_basic_ssn = "000000000" THEN
	//INVALID - DO NOT WRITE TO FILE
else
	ls_XML += '		<ssn>' + ls_pd_basic_ssn + '</ssn>'
end if
//Start Code Change ----08.30.2012

//fein
for ll_Row = 1 to lds_fien.RowCount()
	if ll_Row < 5 and not IsNull(lds_fien.object.id_number[ll_Row]) then
		ls_XML += '		<fein>' + lds_fien.object.id_number[ll_Row] + '</fein>'
	end if
next
//npi
if f_validstr(ls_pd_basic_npi_number) then
		ls_XML += '		<npi>' + ls_pd_basic_npi_number + '</npi>'
end if
//dea
for ll_Row = 1 to lds_dea.RowCount()
	if ll_Row < 5 and not IsNull(lds_dea.object.license_number[ll_Row]) then
		ls_XML += '		<dea>' + lds_dea.object.license_number[ll_Row] + '</dea>'
	end if
next
//upin
for ll_Row = 1 to lds_upin.RowCount()
	if ll_Row < 5 and not IsNull(lds_upin.object.id_number[ll_Row]) then
		ls_XML += '		<upin>' + lds_upin.object.id_number[ll_Row] + '</upin>'
	end if
next
//professionalSchool
for ll_Row = 1 to lds_grad.RowCount()
	if ll_Row > 5 then Exit
	ls_year_thru = ""
	ls_instition_name = ""
	ld_lookup_code = lds_grad.GetItemDecimal(ll_Row, "institution_code")
	ls_year_thru = String(year(date((lds_grad.GetItemdatetime(ll_Row, "end_date")))))
	if LenA(ls_year_thru) < 1 or IsNull(ls_year_thru) then
		ls_year_thru =  String(lds_grad.GetItemNumber(ll_Row, "year_thru"))
	end if
	ll_Grad = Integer(String(ids_pracs_info.object.date_of_birth[1], "YYYY"))
	if ll_Grad + 15 <  Integer(ls_year_thru) then		
		ll_FindRow = lds_address_lookup.Find("lookup_code = " + String(ld_lookup_code), 1, lds_address_lookup.Rowcount())
		if ll_FindRow > 0 then
			ls_instition_name = lds_address_lookup.GetItemString(ll_FindRow, "entity_name")
		end if
		if f_validstr(ls_instition_name) and f_validstr(ls_year_thru) then
			ls_XML += '		<professionalSchool>' + &
						 '			<school>' + ls_instition_name + '</school>' + &
						 '			<graduationYear>' + ls_year_thru + '</graduationYear>' + &
						 '		</professionalSchool>'
		end if
	end if
next
//debugbreak()
//occupationAndLicensure
if lds_speciality.Rowcount() > 0 then
	ll_speciality_code = lds_speciality.GetItemNumber(1, "specialty")
	ls_spec = gnv_data.of_getitem("code_lookup", "description", "lookup_code = " + String(ll_speciality_code))
else
	ls_spec = "99"
end if
if lds_lic.Rowcount() > 0 then
	//Field
	ls_lic_field = String(lds_lic.object.code_lookup_ic_n[1])
	if IsNull(ls_lic_field) then ls_lic_field = ""
	if LenA(ls_lic_field) = 0 then
		ls_lic_field = "699"
	elseif LenA(ls_lic_field) = 1 then
		ls_lic_field = "00" + ls_lic_field
	elseif LenA(ls_lic_field) = 2 then
		ls_lic_field = "0" + ls_lic_field
	end if
	//Description, Specialty
	choose case ls_lic_field
		case "699", "899"
			ls_lic_desc = lds_lic.object.code_lookup_description[1]
			ls_speciality = ""
		case "010", "015", "020", "025", "030", "035"
			ls_speciality = gnv_data.of_getitem("code_lookup", "ic_c", "lookup_code = " + String(ll_speciality_code))
			if ls_speciality = "" or IsNull(ls_speciality) then
				//Start Code Change ----04.14.2010 #V10 maha - added upper to filter
				SELECT npdb_list_code INTO :ls_speciality FROM  npdb_code_lookup
				WHERE npdb_list = 'list_d' and upper(npdb_list_code_description)  = upper(:ls_spec);
			end if
			if not f_validstr(ls_speciality) then ls_speciality = "99"
		case else
			ls_lic_desc = ""
			ls_speciality = ""
	end choose
	//Number
	ls_lic_num = lds_lic.object.license_number[1]
	//State
	ls_lic_state = gnv_data.of_getitem("code_lookup", "code", "lookup_code = " + String(lds_lic.object.state[1]))
	//Build XML
	ls_XML += '		<occupationAndLicensure>'
	if f_validstr(ls_lic_num) then
		ls_XML += '			<number>' + ls_lic_num + '</number>'
	end if
	if f_validstr(ls_lic_state) then
		ls_XML += '			<state>' + ls_lic_state + '</state>'
	end if
	if f_validstr(ls_lic_field) then
		ls_XML += '			<field>' + ls_lic_field + '</field>'
	end if
	if f_validstr(ls_lic_desc) then
		ls_XML += '			<description>' + ls_lic_desc + '</description>'
	end if
	if f_validstr(ls_speciality) then
		ls_XML += '			<specialty>' + ls_speciality + '</specialty>'
	end if
	ls_XML += '		</occupationAndLicensure>'
end if
ls_XML += &
'		<customerUse>' + as_DocID + '</customerUse>' + &
'	</individual>' + &
'</query:querySubmission>'

//---------- APPEON BEGIN ----------
//$<add> Evan 05.11.2012
//$<reason> trap for some specific characters
ls_XML = inv_string.of_GlobalReplace(ls_XML, "&", "&amp;")
ls_XML = inv_string.of_GlobalReplace(ls_XML, "'", "&apos;")
ls_XML = inv_string.of_GlobalReplace(ls_XML, "~"", "&quot;")

//if date(today()) > date("2014/02/16") then     //Start Code Change ----10.02.2013 #V14 maha -  change for new link
if of_get_app_setting("set_27","I") = 100 then  //Start Code Change ----03.18.2014 #V14 maha - temp modification to allow manual change
	ls_XML = '<?xml version="1.0" encoding="UTF-8"?>' + &
         '<query:querySubmission xmlns:query="http://www.npdb.hrsa.gov/Query">' + ls_XML
else 
	ls_XML = '<?xml version="1.0" encoding="UTF-8"?>' + &
			 '<query:querySubmission xmlns:query="http://www.npdb-hipdb.hrsa.gov/Query">' + ls_XML
end if

//---------- APPEON END ------------

ls_File = is_directories2[3] + '\' + is_current_file_name + ".xml"
of_create_file(ls_File, ls_XML)

// Destroy objects
if IsValid(lds_fien) then Destroy lds_fien
if IsValid(lds_dea) then Destroy lds_dea
if IsValid(lds_upin) then Destroy lds_upin
if IsValid(lds_grad) then Destroy lds_grad
if IsValid(lds_address_lookup) then Destroy lds_address_lookup
if IsValid(lds_speciality) then Destroy lds_speciality
if IsValid(lds_lic) then Destroy lds_lic

Return SUCCESS
end function

private function integer of_check_status_old (string as_string);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : of_check_status
//==================================================================================================================
//  Purpose   	: Read the file and check the error code, display message to user or stuff 
//               it into the database
//==================================================================================================================
//  Arguments 	: [string] helpfull message information - not needed
//==================================================================================================================
//  Returns   	: [long]   0 - SUCCES,  -1 FAILURE
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael Skinner  
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

LONG ll_i,ll_j
LONG li_FileNum
long ll_return, chk
STRING ls_read_string    //he string in which you want to find ls_search_string.
STRING ls_search_string // THE SEARCH STRING
string ls_stat  //Start Code Change ---- 09.24.2007 #V7 maha
string ls_file
string ls_count
integer li_err_cnt = 0 //Start Code Change ---- 10.03.2006 #653 maha
integer li_find  //Start Code Change ---- 09.24.2007 #V7 maha

///////////////////////////////////////////////////////////////////////////
// filter on the error codes that are applicaple to the part
///////////////////////////////////////////////////////////////////////////

ids_lookup_code.setfilter(" npdb_list  = 'error_cd' ")
ids_lookup_code.filter( )

///////////////////////////////////////////////////////////////////////////
// the file itpstat.dat will ALWAYS be retured accoribg to the documntation.
// Even if there are no files returned
///////////////////////////////////////////////////////////////////////////
//Start Code Change ---- 12.20.2006 #V7 maha
//DO
//   Yield()
//LOOP UNTIL (Filelength(is_status_files[1]) > 0)
ls_file = is_status_files[1]
for ll_i = 1 to 100000
	chk++
	//if Filelength(is_status_files[1]) > 0 then exit 
	if Fileexists(ls_file) = true then      //   \itp\itpstat.dat' 
		//messagebox("of_check_status","Found file.")  
		exit //\itp\itpstat.dat' 
	end if
	if chk > 99999 then 
		//debugbreak()
		chk = messagebox(ls_file,"Waiting for status file.  Continue to wait?",question!,yesno!,1)
		if chk = 1 then
			ll_i = 1
		else
			return failure
		end if
	end if
next



///////////////////////////////////////////////////////////////////////////
// open  the status file and check the error codes, add to the message
///////////////////////////////////////////////////////////////////////////
//Start Code Change ---- 10.03.2006 #653 maha

li_FileNum = FileOpen(ls_file,StreamMode!  )
FileRead ( li_FileNum, ls_read_string )
FILECLOSE(li_FileNum)
//Start Code Change ---- 09.24.2007 #V7 maha
ls_stat = MidA(ls_read_string, PosA(ls_read_string, "StatusCode=" ) + 11 )
//messagebox("stat code",ls_stat)
IS_STATUS_CODE = ls_stat
//debugbreak()
if ls_stat <> 'C00' then
	li_find = ids_lookup_code.find("npdb_list_code ='" + ls_stat + "'", 1,ids_lookup_code.rowcount() )
	if li_find > 0 then
		is_err_mess[upperbound(is_err_mess) + 1 ] = ids_lookup_code.object.npdb_list_code_description[li_find]
		li_err_cnt ++
	else
		is_err_mess[upperbound(is_err_mess) + 1 ] = "Unknown NPDB error code:" + ls_stat 
		li_err_cnt ++
	end if
	ib_process_failed = true // failure flag
	ll_return = failure
	//messagebox("mess",is_err_mess[upperbound(is_err_mess)])
end if

is_fac_id_status[upperbound(is_fac_id_status) + 1 ] = is_current_facility_id +','+ IS_STATUS_CODE

ids_lookup_code.setfilter('')
ids_lookup_code.filter( )

///////////////////////////////////////////////////////////////////////////
// update the tracker with the latest message
///////////////////////////////////////////////////////////////////////////

for ll_i = 1 to ids_npdb_tracker_upd.rowcount()
	ids_npdb_tracker_upd.object.cust_3[ll_i] = ls_search_string
next

///////////////////////////////////////////////////////////////////////////
// delete itpstat.dat
///////////////////////////////////////////////////////////////////////////

//Start Code Change ----04.08.2008 #V8 maha - moved from here to of_initialize to delete at beginning rather than at the end.
//for ll_i =1 TO upperbound(is_status_files)

FileDelete ( is_directories[5] +"\itpstat.dat" )
FileMove (  is_status_files[1], is_directories[5] ) //move to processed
//next


///////////////////////////////////////////////////////////////////////////
// UPDATE DATE THE DOC_IDS
///////////////////////////////////////////////////////////////////////////


CHOOSE CASE is_process
	CASE is_send
		//IF ls_search_string = 'C00' THEN
		IF ls_stat = 'C00' THEN //Start Code Change ---- 09.24.2007 #V7 maha
		   	of_post_send(success)
		ELSE
			of_post_send(failure)
		END IF
	CASE is_recieve
		// ADD POST RECIEVE HERE
	CASE ELSE
		//
END CHOOSE


return ll_return
end function

private function integer of_recieve_qrxs ();//////////////////////////////////////////////////////////////////////
// $<function> of_recieve_qrxs
// $<arguments>
// $<returns> integer
// $<description> Recieve for QRXS (V10.1 - NPDB QRXS)
//////////////////////////////////////////////////////////////////////
// $<add> Evan 12.01.2009
//////////////////////////////////////////////////////////////////////

//is_qrxs_path = is_current_path + '\qrxs'
//is_directories2[1] = is_current_path + "\qrxs"
//is_directories2[2] = is_current_path + "\qrxs\Download"
//is_directories2[3] = is_current_path + "\qrxs\Upload"
//is_directories2[4] = is_current_path + "\qrxs\Temp"
//is_directories2[5] = is_current_path + "\qrxs\Processed"

string  ls_Null
string  ls_Execute
string  ls_StatusCode
integer li_FileNum
integer i, li_Find
integer value

// Run the batch file to get any new data
SetNull(ls_Null)

//Start Code Change ----09.07.2012 #V12 maha - added code related to the creation of the properties file
if of_create_qrxs_prop("RECV") <> success then Return FAILURE

//encode the password
inv_filesrv.of_ChangeDirectory(is_qrxs_path)  //add by stephen 12.19.2012 --Bug 3344
of_create_file(is_batch_files2[3], is_batch_file_text2[3] + ' ' + is_password )
ls_execute = is_batch_files2[3]
value = ShellExecuteA ( Handle( This ), "open", ls_execute , ls_Null, ls_Null, 0)
for i = 1 to 30
	inv_datetime.of_wait(1)
	if FileExists(is_status_files2[1]) then
		Exit
	else
		if i = 30 then
			//MessageBox("Error", "Failed to encode password.")
			//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
			inv_message.of_MessageBox("Error", "Failed to encode password.",true)
			Return FAILURE
		end if
	end if
next
//End Code Change ----09.07.2012 

FileDelete(is_status_files2[1])
inv_filesrv.of_ChangeDirectory(is_qrxs_path)
ls_Execute = is_batch_files2[1]
ShellExecuteA(Handle(this), "open", ls_Execute, ls_Null, ls_Null, 0)
do while true
	inv_datetime.of_Wait(3)
	if FileExists(is_status_files2[1]) then
		Exit
	else
		//if MessageBox(is_status_files2[1], "Waiting for status file. Continue to wait?", Question!, YesNo!, 1) = 2 then
		//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
		if inv_message.of_MessageBox(is_status_files2[1], "Waiting for status file. Continue to wait?", Question!, YesNo!, 1,true) = 2 then
			Return FAILURE
		end if
	end if
loop

// Open the status file and check the error codes, add to the message
li_FileNum = FileOpen(is_status_files2[1], StreamMode!)
FileRead(li_FileNum, ls_StatusCode)
FileClose(li_FileNum)
ls_StatusCode = MidA(ls_StatusCode, PosA(ls_StatusCode, "StatusCode=") + 11)
ls_StatusCode = Trim(ls_StatusCode)
if ls_StatusCode <> "C00" then
	ids_lookup_code.SetFilter("npdb_list = 'error_cd_qrxs'")
	ids_lookup_code.Filter()
	li_Find = ids_lookup_code.Find("npdb_list_code ='" + ls_StatusCode + "'", 1, ids_lookup_code.rowcount())
	if li_Find > 0 then
		//is_err_mess[upperbound(is_err_mess) + 1 ] = ids_lookup_code.object.npdb_list_code_description[li_find]
		is_err_mess[upperbound(is_err_mess) + 1 ] = ls_StatusCode + " - " +  ids_lookup_code.object.npdb_list_code_description[li_find]   //Start Code Change ----03.24.2015 #V15 maha - added code to message
	else
		is_err_mess[upperbound(is_err_mess) + 1 ] = "Unknown NPDB error code:" + ls_StatusCode 
	end if
	ids_lookup_code.SetFilter("")
	ids_lookup_code.Filter()
	//Start Code Change ----07.24.2013 #V14 maha
	of_create_qrxs_download_log( "No file", 0 , 0 , "Receive Failure: " + ls_StatusCode + "-" + gs_user_id , "R")	
	Return FAILURE
end if

// The following is test code
if gi_test_mode = 1 then
	MessageBox("Testing", "The response file was recieved. Please modify its content to test NPDB QRXS recieve process.")
end if

// Parse XML file content into report tables
of_get_qrxs_report()

Return SUCCESS
end function

private function integer of_get_qrxs_report_hdr (n_cst_xml_parser anv_xml, ref datastore ads_report, string as_doc_id);//////////////////////////////////////////////////////////////////////
// $<function> of_get_qrxs_report_hdr
// $<arguments>
//				 n_cst_xml_parser	anv_xml
//			ref datastore			ads_report
//				 string				as_doc_id
// $<returns> integer
// $<description> Parse XML file data into report tables
//                (V10.1 - NPDB QRXS)
//////////////////////////////////////////////////////////////////////
// $<add> Evan 12.07.2009
//////////////////////////////////////////////////////////////////////

long   ll_prac_id
long   ll_InsertRow
string ls_Array[]
string ls_ElementText[]

ls_ElementText[1] = anv_Xml.of_GetElementText("submitter\entityDBID")
ls_ElementText[2] = anv_Xml.of_GetElementText("submitter\agentDBID")
ls_ElementText[3] = anv_Xml.of_GetElementText("submitter\vendorID")
ls_ElementText[4] = anv_Xml.of_GetElementText("submissionFilename")
ls_ElementText[5] = anv_Xml.of_GetElementText("certification\name")
ls_ElementText[6] = anv_Xml.of_GetElementText("certification\title")
ls_ElementText[7] = anv_Xml.of_GetElementText("certification\phone\number")
ls_ElementText[8] = anv_Xml.of_GetElementText("certification\phone\extension")
ls_ElementText[9] = anv_Xml.of_GetElementText("certification\date")

lnv_string.of_ParseToArray(as_doc_id, '-', ls_Array[])
if UpperBound(ls_Array) > 1 then
	ll_prac_id = Long(ls_Array[2])
end if

ll_InsertRow = ads_Report.InsertRow(0)
ads_Report.Setitem(ll_InsertRow, "report_id", ll_InsertRow)
ads_Report.Setitem(ll_InsertRow, "doc_id", as_doc_id)
ads_Report.Setitem(ll_InsertRow, "prac_id", ll_prac_id)
ads_Report.Setitem(ll_InsertRow, "entity_dbid", ls_ElementText[1])
ads_Report.Setitem(ll_InsertRow, "agent_dbid", ls_ElementText[2])
ads_Report.Setitem(ll_InsertRow, "vendor_id", ls_ElementText[3])
ads_Report.Setitem(ll_InsertRow, "submission_filename", ls_ElementText[4])
ads_Report.Setitem(ll_InsertRow, "cert_name", ls_ElementText[5])
ads_Report.Setitem(ll_InsertRow, "cert_title", ls_ElementText[6])
ads_Report.Setitem(ll_InsertRow, "cert_phone_number", ls_ElementText[7])
ads_Report.Setitem(ll_InsertRow, "cert_phone_extension", ls_ElementText[8])
ads_Report.Setitem(ll_InsertRow, "cert_date", ls_ElementText[9])

Return SUCCESS
end function

private function integer of_get_qrxs_report_status (n_cst_xml_parser anv_xml, ref datastore ads_report);//////////////////////////////////////////////////////////////////////
// $<function> of_get_qrxs_report_status
// $<arguments>
//				 n_cst_xml_parser	anv_xml
//			ref datastore			ads_report
// $<returns> integer
// $<description> Parse XML file data into report tables
//                (V10.1 - NPDB QRXS)
//////////////////////////////////////////////////////////////////////
// $<add> Evan 12.07.2009
//////////////////////////////////////////////////////////////////////

long   ll_InsertRow
string ls_Xml
string ls_ElementText[]
n_cst_xml_parser lnv_Xml

ls_Xml = anv_Xml.of_GetElementText("status")
lnv_Xml.of_CreateFromString(ls_Xml)

ls_ElementText[1] = lnv_Xml.of_GetElementText("dcn")
ls_ElementText[2] = lnv_Xml.of_GetElementText("processDate")
ls_ElementText[3] = lnv_Xml.of_GetElementText("successfullyProcessed")
ls_ElementText[4] = lnv_Xml.of_GetElementText("error\code")
ls_ElementText[5] = lnv_Xml.of_GetElementText("error\message")

ll_InsertRow = ads_Report.InsertRow(0)
ads_Report.Setitem(ll_InsertRow, "report_id", ll_InsertRow)
ads_Report.Setitem(ll_InsertRow, "dcn", ls_ElementText[1])
ads_Report.Setitem(ll_InsertRow, "process_date", ls_ElementText[2])
ads_Report.Setitem(ll_InsertRow, "successfully_processed", ls_ElementText[3])
ads_Report.Setitem(ll_InsertRow, "error_code", ls_ElementText[4])
ads_Report.Setitem(ll_InsertRow, "error_message", ls_ElementText[5])

Return SUCCESS
end function

private function integer of_get_qrxs_report_individual (n_cst_xml_parser anv_xml, ref datastore ads_report);//////////////////////////////////////////////////////////////////////
// $<function> of_get_qrxs_report_individual
// $<arguments>
//				 n_cst_xml_parser	anv_xml
//			ref datastore			ads_report
// $<returns> integer
// $<description> Parse XML file data into report tables
//                (V10.1 - NPDB QRXS)
//////////////////////////////////////////////////////////////////////
// $<add> Evan 12.07.2009
//////////////////////////////////////////////////////////////////////

long   ll_InsertRow
string ls_Xml
string ls_ElementText[]
n_cst_xml_parser lnv_Xml

ls_Xml = anv_Xml.of_GetElementText("individual")
lnv_Xml.of_CreateFromString(ls_Xml)

ll_InsertRow = ads_Report.InsertRow(0)

//------------------- APPEON BEGIN -------------------
//$<modify> Stephen 11.06.2012
//$<reason> add section querySubjectResponse->report->individual
/*
 ads_Report.Setitem(ll_InsertRow, "report_id", ll_InsertRow)
*/
if ads_Report.dataobject = 'd_npdb_qrxs_individual_total' then
	ads_Report.Setitem(ll_InsertRow, "report_id", ll_InsertRow)
else
	ads_Report.Setitem(ll_InsertRow, "report_id", ii_report_id)
end if
//------------------- APPEON END -------------------

ls_ElementText[1] = lnv_Xml.of_GetElementText("name\last")
ls_ElementText[2] = lnv_Xml.of_GetElementText("name\first")
ls_ElementText[3] = lnv_Xml.of_GetElementText("name\middle")
ls_ElementText[4] = lnv_Xml.of_GetElementText("name\suffix")
ads_Report.Setitem(ll_InsertRow, "last_name", ls_ElementText[1])
ads_Report.Setitem(ll_InsertRow, "first_name", ls_ElementText[2])
ads_Report.Setitem(ll_InsertRow, "middle_name", ls_ElementText[3])
ads_Report.Setitem(ll_InsertRow, "suffix_name", ls_ElementText[4])

ls_ElementText[1] = lnv_Xml.of_GetElementText("otherName\last")
ls_ElementText[2] = lnv_Xml.of_GetElementText("otherName\first")
ls_ElementText[3] = lnv_Xml.of_GetElementText("otherName\middle")
ls_ElementText[4] = lnv_Xml.of_GetElementText("otherName\suffix")
ads_Report.Setitem(ll_InsertRow, "last_othername1", ls_ElementText[1])
ads_Report.Setitem(ll_InsertRow, "first_othername1", ls_ElementText[2])
ads_Report.Setitem(ll_InsertRow, "middle_othername1", ls_ElementText[3])
ads_Report.Setitem(ll_InsertRow, "suffix_othername1", ls_ElementText[4])

ls_ElementText[1] = lnv_Xml.of_GetElementText("gender")
ls_ElementText[2] = lnv_Xml.of_GetElementText("birthdate")
ls_ElementText[3] = lnv_Xml.of_GetElementText("organizationName")
ads_Report.Setitem(ll_InsertRow, "gender", ls_ElementText[1])
ads_Report.Setitem(ll_InsertRow, "birthdate", ls_ElementText[2])
ads_Report.Setitem(ll_InsertRow, "organization_name", ls_ElementText[3])

ls_ElementText[1] = lnv_Xml.of_GetElementText("organizationType\typeCode")
ls_ElementText[2] = lnv_Xml.of_GetElementText("organizationType\description")
ads_Report.Setitem(ll_InsertRow, "org_type_code", ls_ElementText[1])
ads_Report.Setitem(ll_InsertRow, "org_description", ls_ElementText[2])

ls_ElementText[1] = lnv_Xml.of_GetElementText("workAddress\address")
ls_ElementText[2] = lnv_Xml.of_GetElementText("workAddress\address2")
ls_ElementText[3] = lnv_Xml.of_GetElementText("workAddress\city")
ls_ElementText[4] = lnv_Xml.of_GetElementText("workAddress\state")
ls_ElementText[5] = lnv_Xml.of_GetElementText("workAddress\zip")
ls_ElementText[6] = lnv_Xml.of_GetElementText("workAddress\zip4")
ls_ElementText[7] = lnv_Xml.of_GetElementText("workAddress\country")
ads_Report.Setitem(ll_InsertRow, "work_address", ls_ElementText[1])
ads_Report.Setitem(ll_InsertRow, "work_address2", ls_ElementText[2])
ads_Report.Setitem(ll_InsertRow, "work_city", ls_ElementText[3])
ads_Report.Setitem(ll_InsertRow, "work_state", ls_ElementText[4])
ads_Report.Setitem(ll_InsertRow, "work_zip", ls_ElementText[5])
ads_Report.Setitem(ll_InsertRow, "work_zip4", ls_ElementText[6])
ads_Report.Setitem(ll_InsertRow, "work_country", ls_ElementText[7])

ls_ElementText[1] = lnv_Xml.of_GetElementText("homeAddress\address")
ls_ElementText[2] = lnv_Xml.of_GetElementText("homeAddress\address2")
ls_ElementText[3] = lnv_Xml.of_GetElementText("homeAddress\city")
ls_ElementText[4] = lnv_Xml.of_GetElementText("homeAddress\state")
ls_ElementText[5] = lnv_Xml.of_GetElementText("homeAddress\zip")
ls_ElementText[6] = lnv_Xml.of_GetElementText("homeAddress\zip4")
ls_ElementText[7] = lnv_Xml.of_GetElementText("homeAddress\country")
ads_Report.Setitem(ll_InsertRow, "home_address", ls_ElementText[1])
ads_Report.Setitem(ll_InsertRow, "home_address2", ls_ElementText[2])
ads_Report.Setitem(ll_InsertRow, "home_city", ls_ElementText[3])
ads_Report.Setitem(ll_InsertRow, "home_state", ls_ElementText[4])
ads_Report.Setitem(ll_InsertRow, "home_zip", ls_ElementText[5])
ads_Report.Setitem(ll_InsertRow, "home_zip4", ls_ElementText[6])
ads_Report.Setitem(ll_InsertRow, "home_country", ls_ElementText[7])

lnv_Xml.of_GetElementText("ssn", ls_ElementText[])
of_Setitem(ads_Report, ll_InsertRow, "ssn", "ssn", ls_ElementText[])
lnv_Xml.of_GetElementText("itin", ls_ElementText[])
of_Setitem(ads_Report, ll_InsertRow, "itin", "itin", ls_ElementText[])
lnv_Xml.of_GetElementText("fein", ls_ElementText[])
of_Setitem(ads_Report, ll_InsertRow, "fein", "fein", ls_ElementText[])
lnv_Xml.of_GetElementText("npi", ls_ElementText[])
of_Setitem(ads_Report, ll_InsertRow, "npi", "npi", ls_ElementText[])
lnv_Xml.of_GetElementText("dea", ls_ElementText[])
of_Setitem(ads_Report, ll_InsertRow, "dea", "dea", ls_ElementText[])
lnv_Xml.of_GetElementText("upin", ls_ElementText[])
of_Setitem(ads_Report, ll_InsertRow, "upin", "upin", ls_ElementText[])
lnv_Xml.of_GetElementText("professionalSchool", ls_ElementText[])
of_Setitem(ads_Report, ll_InsertRow, "prof_school,prof_graduation_year", "school,graduationYear", ls_ElementText[])

ls_ElementText[1] = lnv_Xml.of_GetElementText("occupationAndLicensure\number")
ls_ElementText[2] = lnv_Xml.of_GetElementText("occupationAndLicensure\noLicense")
ls_ElementText[3] = lnv_Xml.of_GetElementText("occupationAndLicensure\state")
ls_ElementText[4] = lnv_Xml.of_GetElementText("occupationAndLicensure\field")
ls_ElementText[5] = lnv_Xml.of_GetElementText("occupationAndLicensure\description")
ls_ElementText[6] = lnv_Xml.of_GetElementText("occupationAndLicensure\specialty")
ads_Report.Setitem(ll_InsertRow, "oal_number", ls_ElementText[1])
ads_Report.Setitem(ll_InsertRow, "oal_no_license", ls_ElementText[2])
ads_Report.Setitem(ll_InsertRow, "oal_state", ls_ElementText[3])
ads_Report.Setitem(ll_InsertRow, "oal_field", ls_ElementText[4])
ads_Report.Setitem(ll_InsertRow, "oal_description", ls_ElementText[5])
ads_Report.Setitem(ll_InsertRow, "oal_specialty", ls_ElementText[6])

ls_ElementText[1] = lnv_Xml.of_GetElementText("otherOccupationAndLicensure\number")
ls_ElementText[2] = lnv_Xml.of_GetElementText("otherOccupationAndLicensure\noLicense")
ls_ElementText[3] = lnv_Xml.of_GetElementText("otherOccupationAndLicensure\state")
ls_ElementText[4] = lnv_Xml.of_GetElementText("otherOccupationAndLicensure\field")
ls_ElementText[5] = lnv_Xml.of_GetElementText("otherOccupationAndLicensure\description")
ls_ElementText[6] = lnv_Xml.of_GetElementText("otherOccupationAndLicensure\specialty")
ads_Report.Setitem(ll_InsertRow, "ooal_number1", ls_ElementText[1])
ads_Report.Setitem(ll_InsertRow, "ooal_no_license1", ls_ElementText[2])
ads_Report.Setitem(ll_InsertRow, "ooal_state1", ls_ElementText[3])
ads_Report.Setitem(ll_InsertRow, "ooal_field1", ls_ElementText[4])
ads_Report.Setitem(ll_InsertRow, "ooal_description1", ls_ElementText[5])
ads_Report.Setitem(ll_InsertRow, "ooal_specialty1", ls_ElementText[6])

ls_ElementText[1] = lnv_Xml.of_GetElementText("subjectID")
ls_ElementText[2] = lnv_Xml.of_GetElementText("customerUse")
ads_Report.Setitem(ll_InsertRow, "subject_id", ls_ElementText[1])
ads_Report.Setitem(ll_InsertRow, "customer_use", ls_ElementText[2])

//------------------- APPEON BEGIN -------------------
//$<add> stephen 09.12.2012
//$<reason> v12.2 modify NPDB qrxs report

//Deceased Date
ls_ElementText[1] = lnv_Xml.of_GetElementText("deceasedDate\isDeceased")
ls_ElementText[2] = lnv_Xml.of_GetElementText("deceasedDate\date")
ads_Report.Setitem(ll_InsertRow, "isdeceased", ls_ElementText[1])
ads_Report.Setitem(ll_InsertRow, "deceased_date", ls_ElementText[2])

//Hospital Affiliation(s)
ls_ElementText[1] = lnv_Xml.of_GetElementText("hospitalAffiliation\name")
ls_ElementText[2] = lnv_Xml.of_GetElementText("hospitalAffiliation\city")
ls_ElementText[3] = lnv_Xml.of_GetElementText("hospitalAffiliation\state")
ads_Report.Setitem(ll_InsertRow, "hosp_affi_name", ls_ElementText[1])
ads_Report.Setitem(ll_InsertRow, "hosp_affi_city", ls_ElementText[2])
ads_Report.Setitem(ll_InsertRow, "hosp_affi_state", ls_ElementText[3])

//Affiliation
ls_ElementText[1] = lnv_Xml.of_GetElementText("affiliation\name")
ls_ElementText[2] = lnv_Xml.of_GetElementText("affiliation\address\address")
ls_ElementText[3] = lnv_Xml.of_GetElementText("affiliation\address\city")
ls_ElementText[4] = lnv_Xml.of_GetElementText("affiliation\address\state")
ls_ElementText[5] = lnv_Xml.of_GetElementText("affiliation\address\zip")
ls_ElementText[6] = lnv_Xml.of_GetElementText("affiliation\natureRelationship")
ls_ElementText[7] = lnv_Xml.of_GetElementText("affiliation\otherNatureRelationship")
ads_Report.Setitem(ll_InsertRow, "affi_name", ls_ElementText[1])
ads_Report.Setitem(ll_InsertRow, "affi_address", ls_ElementText[2])
ads_Report.Setitem(ll_InsertRow, "affi_city", ls_ElementText[3])
ads_Report.Setitem(ll_InsertRow, "affi_state", ls_ElementText[4])
ads_Report.Setitem(ll_InsertRow, "affi_zip", ls_ElementText[5])
ads_Report.Setitem(ll_InsertRow, "affi_nature_rela", ls_ElementText[6])
ads_Report.Setitem(ll_InsertRow, "affi_other_nature", ls_ElementText[7])
//------------------- APPEON END -------------------

Return SUCCESS
end function

private function integer of_get_qrxs_report_aar (n_cst_xml_parser anv_xml, ref datastore ads_report);//////////////////////////////////////////////////////////////////////
// $<function> of_get_qrxs_report_aar
// $<arguments>
//				 n_cst_xml_parser	anv_xml
//			ref datastore			ads_report
// $<returns> integer
// $<description> Parse XML file data into report tables
//                (V10.1 - NPDB QRXS)
//////////////////////////////////////////////////////////////////////
// $<add> Evan 12.07.2009
//////////////////////////////////////////////////////////////////////

long   ll_InsertRow
string ls_Xml
string ls_ElementText[]
n_cst_xml_parser lnv_Xml

ls_Xml = anv_Xml.of_GetElementText("informationReported\aar")
if lnv_Xml.of_CreateFromString(ls_Xml) = -1 then Return SUCCESS

ls_ElementText[1] = lnv_Xml.of_GetElementText("action")
ls_ElementText[2] = lnv_Xml.of_GetElementText("agencyProgramName")
ls_ElementText[3] = lnv_Xml.of_GetElementText("findingDate")
ls_ElementText[4] = lnv_Xml.of_GetElementText("actionTakenDate")
ls_ElementText[5] = lnv_Xml.of_GetElementText("actionEffectiveDate")
ls_ElementText[6] = lnv_Xml.of_GetElementText("actionLength\indefinite")
ls_ElementText[7] = lnv_Xml.of_GetElementText("actionLength\permanent")
ls_ElementText[8] = lnv_Xml.of_GetElementText("actionLength\length")
ls_ElementText[9] = lnv_Xml.of_GetElementText("automaticReinstatement")
ls_ElementText[10] = lnv_Xml.of_GetElementText("amount")
ls_ElementText[11] = lnv_Xml.of_GetElementText("orgDefn")
ls_ElementText[12] = lnv_Xml.of_GetElementText("ccb")
ls_ElementText[13] = lnv_Xml.of_GetElementText("narrative")
ls_ElementText[14] = lnv_Xml.of_GetElementText("appeal\onAppeal")
ls_ElementText[15] = lnv_Xml.of_GetElementText("appeal\appealDate")

ll_InsertRow = ads_Report.InsertRow(0)
ads_Report.Setitem(ll_InsertRow, "report_id", ii_report_id)  //modify by stephen 11.05.2012  ll_InsertRow to ii_report_id --npdb test error
ads_Report.Setitem(ll_InsertRow, "action", ls_ElementText[1])
ads_Report.Setitem(ll_InsertRow, "agency_program_name", ls_ElementText[2])
ads_Report.Setitem(ll_InsertRow, "finding_date", ls_ElementText[3])
ads_Report.Setitem(ll_InsertRow, "action_taken_date", ls_ElementText[4])
ads_Report.Setitem(ll_InsertRow, "action_effective_date", ls_ElementText[5])
ads_Report.Setitem(ll_InsertRow, "action_indefinite", ls_ElementText[6])
ads_Report.Setitem(ll_InsertRow, "action_permanent", ls_ElementText[7])
ads_Report.Setitem(ll_InsertRow, "action_length", ls_ElementText[8])
ads_Report.Setitem(ll_InsertRow, "automatic_reinstatement", ls_ElementText[9])
ads_Report.Setitem(ll_InsertRow, "amount", ls_ElementText[10])
ads_Report.Setitem(ll_InsertRow, "org_defn", ls_ElementText[11])
ads_Report.Setitem(ll_InsertRow, "ccb", ls_ElementText[12])
ads_Report.Setitem(ll_InsertRow, "narrative", ls_ElementText[13])
ads_Report.Setitem(ll_InsertRow, "on_appeal", ls_ElementText[14])
ads_Report.Setitem(ll_InsertRow, "appeal_date", ls_ElementText[15])

lnv_Xml.of_GetElementText("classification", ls_ElementText[])
of_Setitem(ads_Report, ll_InsertRow, "class_code,class_description", "code,description", ls_ElementText[])
lnv_Xml.of_GetElementText("basis", ls_ElementText[])
of_Setitem(ads_Report, ll_InsertRow, "basis_code,basis_description", "code,description", ls_ElementText[])

Return SUCCESS
end function

private function integer of_get_qrxs_report_jocr (n_cst_xml_parser anv_xml, ref datastore ads_report);//////////////////////////////////////////////////////////////////////
// $<function> of_get_qrxs_report_jocr
// $<arguments>
//				 n_cst_xml_parser	anv_xml
//			ref datastore			ads_report
// $<returns> integer
// $<description> Parse XML file data into report tables
//                (V10.1 - NPDB QRXS)
//////////////////////////////////////////////////////////////////////
// $<add> Evan 12.08.2009
//////////////////////////////////////////////////////////////////////

long   ll_InsertRow
string ls_Xml
string ls_ElementText[]
n_cst_xml_parser lnv_Xml

ls_Xml = anv_Xml.of_GetElementText("informationReported\jocr")
if lnv_Xml.of_CreateFromString(ls_Xml) = -1 then Return SUCCESS

ls_ElementText[1] = lnv_Xml.of_GetElementText("action")
ls_ElementText[2] = lnv_Xml.of_GetElementText("jurisdiction")
ls_ElementText[3] = lnv_Xml.of_GetElementText("venueName")
ls_ElementText[4] = lnv_Xml.of_GetElementText("venueCity")
ls_ElementText[5] = lnv_Xml.of_GetElementText("venueState")
ls_ElementText[6] = lnv_Xml.of_GetElementText("fileNumber")
ls_ElementText[7] = lnv_Xml.of_GetElementText("prosecutor")
ls_ElementText[8] = lnv_Xml.of_GetElementText("caseNumber")
//ls_ElementText[9] = lnv_Xml.of_GetElementText("investigatingAgency\agencyName")
//ls_ElementText[10] = lnv_Xml.of_GetElementText("investigatingAgency\caseNumber")
//ls_ElementText[11] = lnv_Xml.of_GetElementText("statutoryOffense\statuteTitleSection")
//ls_ElementText[12] = lnv_Xml.of_GetElementText("statutoryOffense\statutoryOffense")
//ls_ElementText[13] = lnv_Xml.of_GetElementText("statutoryOffense\count")
ls_ElementText[14] = lnv_Xml.of_GetElementText("narrative")
//ls_ElementText[15] = lnv_Xml.of_GetElementText("actOmission\actOmissionCode")
//ls_ElementText[16] = lnv_Xml.of_GetElementText("actOmission\actOmissionDesc")
ls_ElementText[17] = lnv_Xml.of_GetElementText("judgmentOrSentenceDate")
ls_ElementText[18] = lnv_Xml.of_GetElementText("appeal\onAppeal")
ls_ElementText[19] = lnv_Xml.of_GetElementText("appeal\appealDate")
//ls_ElementText[20] = lnv_Xml.of_GetElementText("sentenceOrJudgment\restitutionAmount")
//ls_ElementText[21] = lnv_Xml.of_GetElementText("sentenceOrJudgment\otherSentenceJudgmentAmou")
//ls_ElementText[22] = lnv_Xml.of_GetElementText("sentenceOrJudgment\incarcerationLength")
//ls_ElementText[23] = lnv_Xml.of_GetElementText("sentenceOrJudgment\suspendedSentenceLength")
//ls_ElementText[24] = lnv_Xml.of_GetElementText("sentenceOrJudgment\homeDetentionLength")
//ls_ElementText[25] = lnv_Xml.of_GetElementText("sentenceOrJudgment\probationLength")
//ls_ElementText[26] = lnv_Xml.of_GetElementText("sentenceOrJudgment\communityServiceHours")
//ls_ElementText[27] = lnv_Xml.of_GetElementText("sentenceOrJudgment\otherCourtOrders")

ll_InsertRow = ads_Report.InsertRow(0)
ads_Report.Setitem(ll_InsertRow, "report_id", ii_report_id)  //modify by stephen 11.05.2012  ll_InsertRow to ii_report_id --npdb test error
ads_Report.Setitem(ll_InsertRow, "action", ls_ElementText[1])
ads_Report.Setitem(ll_InsertRow, "jurisdiction", ls_ElementText[2])
ads_Report.Setitem(ll_InsertRow, "venue_name", ls_ElementText[3])
ads_Report.Setitem(ll_InsertRow, "venue_city", ls_ElementText[4])
ads_Report.Setitem(ll_InsertRow, "venue_state", ls_ElementText[5])
ads_Report.Setitem(ll_InsertRow, "file_number", ls_ElementText[6])
ads_Report.Setitem(ll_InsertRow, "prosecutor", ls_ElementText[7])
ads_Report.Setitem(ll_InsertRow, "case_number", ls_ElementText[8])
ads_Report.Setitem(ll_InsertRow, "narrative", ls_ElementText[14])
ads_Report.Setitem(ll_InsertRow, "judgment_or_sentence_date", ls_ElementText[17])

//appeal+
ads_Report.Setitem(ll_InsertRow, "on_appeal", ls_ElementText[18])
ads_Report.Setitem(ll_InsertRow, "appeal_date", ls_ElementText[19])

//investigatingAgency+
lnv_Xml.of_GetElementText("investigatingAgency", ls_ElementText[])
of_Setitem(ads_Report, ll_InsertRow, "ia_agency_name,ia_case_number", "agencyName,caseNumber", ls_ElementText[])

//statutoryOffense+
lnv_Xml.of_GetElementText("statutoryOffense", ls_ElementText[])
of_Setitem(ads_Report, ll_InsertRow, "sta_title_section,sta_offense,sta_count", "statuteTitleSection,statutoryOffense,count", ls_ElementText[])

//actOmission+
lnv_Xml.of_GetElementText("actOmission", ls_ElementText[])
of_Setitem(ads_Report, ll_InsertRow, "act_omission_code,act_omission_desc", "actOmissionCode,actOmissionDesc", ls_ElementText[])

//sentenceOrJudgment+
lnv_Xml.of_GetElementText("sentenceOrJudgment", ls_ElementText[])
of_Setitem(ads_Report, ll_InsertRow, "soj_res_amount,soj_osj_amount,soj_inc_length,soj_ss_length,soj_hd_length,soj_pr_length,soj_cs_hours,soj_oc_orders", "restitutionAmount,otherSentenceJudgmentAmou,incarcerationLength,suspendedSentenceLength,homeDetentionLength,probationLength,communityServiceHours,otherCourtOrders", ls_ElementText[])

Return SUCCESS
end function

private function integer of_get_qrxs_report_mmpr (n_cst_xml_parser anv_xml, ref datastore ads_report);//////////////////////////////////////////////////////////////////////
// $<function> of_get_qrxs_report_mmpr
// $<arguments>
//				 n_cst_xml_parser	anv_xml
//			ref datastore			ads_report
// $<returns> integer
// $<description> Parse XML file data into report tables
//                (V10.1 - NPDB QRXS)
//////////////////////////////////////////////////////////////////////
// $<add> Evan 12.08.2009
//////////////////////////////////////////////////////////////////////

long   ll_InsertRow
string ls_Xml
string ls_ElementText[]
n_cst_xml_parser lnv_Xml

ls_Xml = anv_Xml.of_GetElementText("informationReported\mmpr")
if lnv_Xml.of_CreateFromString(ls_Xml) = -1 then Return SUCCESS

ls_ElementText[1] = lnv_Xml.of_GetElementText("relationshipOfEntity")
ls_ElementText[2] = lnv_Xml.of_GetElementText("paymentForThisPractitioner")
ls_ElementText[3] = lnv_Xml.of_GetElementText("paymentDate")
ls_ElementText[4] = lnv_Xml.of_GetElementText("paymentType")
ls_ElementText[5] = lnv_Xml.of_GetElementText("totalPaymentForThisPractitioner")
ls_ElementText[6] = lnv_Xml.of_GetElementText("paymentResultOf")
ls_ElementText[7] = lnv_Xml.of_GetElementText("judgmentOrSettlementDate")
ls_ElementText[8] = lnv_Xml.of_GetElementText("adjudicativeBodyCaseNumber")
ls_ElementText[9] = lnv_Xml.of_GetElementText("adjudicativeBodyName")
ls_ElementText[10] = lnv_Xml.of_GetElementText("courtFileNumber")
ls_ElementText[11] = lnv_Xml.of_GetElementText("judgmentOrSettlementDesc")
ls_ElementText[12] = lnv_Xml.of_GetElementText("totalPaymentForAllPractitioners")
ls_ElementText[13] = lnv_Xml.of_GetElementText("numberPractitioners")
ls_ElementText[14] = lnv_Xml.of_GetElementText("stateFundPayment\paymentMade")
ls_ElementText[15] = lnv_Xml.of_GetElementText("stateFundPayment\amountPaid")
ls_ElementText[16] = lnv_Xml.of_GetElementText("selfInsuredOrgPayment\paymentMade")
ls_ElementText[17] = lnv_Xml.of_GetElementText("selfInsuredOrgPayment\amountPaid")
ls_ElementText[18] = lnv_Xml.of_GetElementText("patientAge\days")
ls_ElementText[19] = lnv_Xml.of_GetElementText("patientAge\months")
ls_ElementText[20] = lnv_Xml.of_GetElementText("patientAge\years")
ls_ElementText[21] = lnv_Xml.of_GetElementText("patientAge\unknown")
ls_ElementText[22] = lnv_Xml.of_GetElementText("patientGender")
ls_ElementText[23] = lnv_Xml.of_GetElementText("patientType")
ls_ElementText[24] = lnv_Xml.of_GetElementText("medicalConditionDesc")
ls_ElementText[25] = lnv_Xml.of_GetElementText("procedureDesc")
ls_ElementText[26] = lnv_Xml.of_GetElementText("natureAllegation")
//ls_ElementText[27] = lnv_Xml.of_GetElementText("specificAllegation\code")
//ls_ElementText[28] = lnv_Xml.of_GetElementText("specificAllegation\otherDesc")
//ls_ElementText[29] = lnv_Xml.of_GetElementText("specificAllegation\date")
//------------------- APPEON BEGIN -------------------
//$<add> Michael 06.07.2012
//$<reason> Bug id 3110 - Ticket # 00035676: NPDB Report Formatting Issue
ls_ElementText[27] = lnv_Xml.of_GetElementText("specificAllegation\code")
ls_ElementText[28] = lnv_Xml.of_GetElementText("specificAllegation\otherDesc")
ls_ElementText[29] = lnv_Xml.of_GetElementText("specificAllegation\date")
//------------------- APPEON END ---------------------
ls_ElementText[30] = lnv_Xml.of_GetElementText("outcome")
//modify Michael 06.07.2012 Bug id 3110 - Ticket # 00035676: NPDB Report Formatting Issue
//ls_ElementText[31] = lnv_Xml.of_GetElementText("allegationDesc")
ls_ElementText[31] = lnv_Xml.of_GetElementText("allegationsDesc")

ll_InsertRow = ads_Report.InsertRow(0)
ads_Report.Setitem(ll_InsertRow, "report_id", ii_report_id)  //modify by stephen 11.05.2012  ll_InsertRow to ii_report_id --npdb test error
ads_Report.Setitem(ll_InsertRow, "relationship_of_entity", ls_ElementText[1])
ads_Report.Setitem(ll_InsertRow, "payment_for_this_prac", ls_ElementText[2])
ads_Report.Setitem(ll_InsertRow, "payment_date", ls_ElementText[3])
ads_Report.Setitem(ll_InsertRow, "payment_type", ls_ElementText[4])
ads_Report.Setitem(ll_InsertRow, "total_payment_for_this_prac", ls_ElementText[5])
ads_Report.Setitem(ll_InsertRow, "payment_result_of", ls_ElementText[6])
ads_Report.Setitem(ll_InsertRow, "judgment_or_settlement_date", ls_ElementText[7])
ads_Report.Setitem(ll_InsertRow, "adjudicative_body_case_number", ls_ElementText[8])
ads_Report.Setitem(ll_InsertRow, "adjudicative_body_name", ls_ElementText[9])
ads_Report.Setitem(ll_InsertRow, "court_file_number", ls_ElementText[10])
ads_Report.Setitem(ll_InsertRow, "judgment_or_settlement_desc", ls_ElementText[11])
ads_Report.Setitem(ll_InsertRow, "total_payment_for_all_prac", ls_ElementText[12])
ads_Report.Setitem(ll_InsertRow, "number_prac", ls_ElementText[13])
ads_Report.Setitem(ll_InsertRow, "sfp_payment_made", ls_ElementText[14])
ads_Report.Setitem(ll_InsertRow, "sfp_amount_paid", ls_ElementText[15])
ads_Report.Setitem(ll_InsertRow, "siop_payment_made", ls_ElementText[16])
ads_Report.Setitem(ll_InsertRow, "siop_amount_paid", ls_ElementText[17])
ads_Report.Setitem(ll_InsertRow, "patient_age_days", ls_ElementText[18])
ads_Report.Setitem(ll_InsertRow, "patient_age_months", ls_ElementText[19])
ads_Report.Setitem(ll_InsertRow, "patient_age_years", ls_ElementText[20])
ads_Report.Setitem(ll_InsertRow, "patient_age_unknown", ls_ElementText[21])
ads_Report.Setitem(ll_InsertRow, "patient_gender", ls_ElementText[22])
ads_Report.Setitem(ll_InsertRow, "patient_type", ls_ElementText[23])
ads_Report.Setitem(ll_InsertRow, "medical_condition_desc", ls_ElementText[24])
ads_Report.Setitem(ll_InsertRow, "procedure_desc", ls_ElementText[25])
ads_Report.Setitem(ll_InsertRow, "nature_allegation", ls_ElementText[26])
//------------------- APPEON BEGIN -------------------
//$<add> Michael 06.07.2012
//$<reason> Bug id 3110 - Ticket # 00035676: NPDB Report Formatting Issue
ads_Report.Setitem(ll_InsertRow, "sa_code1", ls_ElementText[27])
ads_Report.Setitem(ll_InsertRow, "sa_other_desc1", ls_ElementText[28])
ads_Report.Setitem(ll_InsertRow, "sa_date1", ls_ElementText[29])
//------------------- APPEON END ---------------------
ads_Report.Setitem(ll_InsertRow, "outcome", ls_ElementText[30])
ads_Report.Setitem(ll_InsertRow, "allegation_desc", ls_ElementText[31])

//specificAllegation+
lnv_Xml.of_GetElementText("specificAllegation", ls_ElementText[])
of_Setitem(ads_Report, ll_InsertRow, "sa_code,sa_other_desc,sa_date", "code,otherDesc,date", ls_ElementText[])

Return SUCCESS
end function

private function integer of_get_qrxs_report_laar (n_cst_xml_parser anv_xml, ref datastore ads_report);//////////////////////////////////////////////////////////////////////
// $<function> of_get_qrxs_report_laar
// $<arguments>
//				 n_cst_xml_parser	anv_xml
//			ref datastore			ads_report
// $<returns> integer
// $<description> Parse XML file data into report tables
//                (V10.1 - NPDB QRXS)
//////////////////////////////////////////////////////////////////////
// $<add> Evan 12.08.2009
//////////////////////////////////////////////////////////////////////

long   ll_InsertRow
string ls_Xml
string ls_ElementText[]
n_cst_xml_parser lnv_Xml

ls_Xml = anv_Xml.of_GetElementText("informationReported\legacyAAR")
if lnv_Xml.of_CreateFromString(ls_Xml) = -1 then Return SUCCESS

ls_ElementText[1] = lnv_Xml.of_GetElementText("action")
ls_ElementText[2] = lnv_Xml.of_GetElementText("classification")
ls_ElementText[3] = lnv_Xml.of_GetElementText("actionTakenDate")
ls_ElementText[4] = lnv_Xml.of_GetElementText("actionEffectiveDate")
ls_ElementText[5] = lnv_Xml.of_GetElementText("actionLength\indefinite")
ls_ElementText[6] = lnv_Xml.of_GetElementText("actionLength\permanent")
ls_ElementText[7] = lnv_Xml.of_GetElementText("actionLength\length")
ls_ElementText[8] = lnv_Xml.of_GetElementText("narrative")

ll_InsertRow = ads_Report.InsertRow(0)
ads_Report.Setitem(ll_InsertRow, "report_id", ii_report_id)  //modify by stephen 11.05.2012  ll_InsertRow to ii_report_id --npdb test error
ads_Report.Setitem(ll_InsertRow, "action", ls_ElementText[1])
ads_Report.Setitem(ll_InsertRow, "classification", ls_ElementText[2])
ads_Report.Setitem(ll_InsertRow, "action_taken_date", ls_ElementText[3])
ads_Report.Setitem(ll_InsertRow, "action_effective_date", ls_ElementText[4])
ads_Report.Setitem(ll_InsertRow, "action_length_indefinite", ls_ElementText[5])
ads_Report.Setitem(ll_InsertRow, "action_length_permanent", ls_ElementText[6])
ads_Report.Setitem(ll_InsertRow, "action_length_length", ls_ElementText[7])
ads_Report.Setitem(ll_InsertRow, "narrative", ls_ElementText[8])

Return SUCCESS
end function

private function integer of_get_qrxs_report_lmmpr (n_cst_xml_parser anv_xml, ref datastore ads_report);//////////////////////////////////////////////////////////////////////
// $<function> of_get_qrxs_report_lmmpr
// $<arguments>
//				 n_cst_xml_parser	anv_xml
//			ref datastore			ads_report
// $<returns> integer
// $<description> Parse XML file data into report tables
//                (V10.1 - NPDB QRXS)
//////////////////////////////////////////////////////////////////////
// $<add> Evan 12.08.2009
//////////////////////////////////////////////////////////////////////

long   ll_InsertRow
string ls_Xml
string ls_ElementText[]
n_cst_xml_parser lnv_Xml

ls_Xml = anv_Xml.of_GetElementText("informationReported\legacyMMPR")
if lnv_Xml.of_CreateFromString(ls_Xml) = -1 then Return SUCCESS

ls_ElementText[1] = lnv_Xml.of_GetElementText("relationshipOfEntity")
//ls_ElementText[2] = lnv_Xml.of_GetElementText("actOrOmission\code")
//ls_ElementText[3] = lnv_Xml.of_GetElementText("actOrOmission\date")
ls_ElementText[4] = lnv_Xml.of_GetElementText("paymentDate")
ls_ElementText[5] = lnv_Xml.of_GetElementText("paymentForThisPractitioner")
ls_ElementText[6] = lnv_Xml.of_GetElementText("paymentType")
ls_ElementText[7] = lnv_Xml.of_GetElementText("totalPaymentForThisPractitioner")
ls_ElementText[8] = lnv_Xml.of_GetElementText("numberPractitioners")
ls_ElementText[9] = lnv_Xml.of_GetElementText("paymentResultOf")
ls_ElementText[10] = lnv_Xml.of_GetElementText("judgmentOrSettlementDate")
ls_ElementText[11] = lnv_Xml.of_GetElementText("adjudicativeBodyCaseNumber")
ls_ElementText[12] = lnv_Xml.of_GetElementText("adjudicativeBodyName")
ls_ElementText[13] = lnv_Xml.of_GetElementText("courtFileNumber")
ls_ElementText[14] = lnv_Xml.of_GetElementText("actOrOmissionDesc")
ls_ElementText[15] = lnv_Xml.of_GetElementText("judgmentOrSettlementDesc")

ll_InsertRow = ads_Report.InsertRow(0)
ads_Report.Setitem(ll_InsertRow, "report_id", ii_report_id)  //modify by stephen 11.05.2012  ll_InsertRow to ii_report_id --npdb test error
ads_Report.Setitem(ll_InsertRow, "relationship_of_entity", ls_ElementText[1])
ads_Report.Setitem(ll_InsertRow, "payment_date", ls_ElementText[4])
ads_Report.Setitem(ll_InsertRow, "payment_for_this_prac", ls_ElementText[5])
ads_Report.Setitem(ll_InsertRow, "payment_type", ls_ElementText[6])
ads_Report.Setitem(ll_InsertRow, "total_payment_for_this_prac", ls_ElementText[7])
ads_Report.Setitem(ll_InsertRow, "number_prac", ls_ElementText[8])
ads_Report.Setitem(ll_InsertRow, "payment_result_of", ls_ElementText[9])
ads_Report.Setitem(ll_InsertRow, "judgment_or_settlement_date", ls_ElementText[10])
ads_Report.Setitem(ll_InsertRow, "adjudicative_body_case_number", ls_ElementText[11])
ads_Report.Setitem(ll_InsertRow, "adjudicative_body_name", ls_ElementText[12])
ads_Report.Setitem(ll_InsertRow, "court_file_number", ls_ElementText[13])
ads_Report.Setitem(ll_InsertRow, "act_or_omission_desc", ls_ElementText[14])
ads_Report.Setitem(ll_InsertRow, "judgment_or_settlement_desc", ls_ElementText[15])

//actOrOmission+
lnv_Xml.of_GetElementText("actOrOmission", ls_ElementText[])
of_Setitem(ads_Report, ll_InsertRow, "aoo_code,aoo_date", "code,date", ls_ElementText[])

Return SUCCESS
end function

private function integer of_get_qrxs_report ();//////////////////////////////////////////////////////////////////////
// $<function> of_get_qrxs_report
// $<arguments>
// $<returns> integer
// $<description> Parse XML file content into report tables
//                (V10.1 - NPDB QRXS)
//////////////////////////////////////////////////////////////////////
// $<add> Evan 12.01.2009
//////////////////////////////////////////////////////////////////////

//is_qrxs_path = is_current_path + '\qrxs'
//is_directories2[1] = is_current_path + "\qrxs"
//is_directories2[2] = is_current_path + "\qrxs\Download"
//is_directories2[3] = is_current_path + "\qrxs\Upload"
//is_directories2[4] = is_current_path + "\qrxs\Temp"
//is_directories2[5] = is_current_path + "\qrxs\Processed"

long   ll_Row
long   ll_npdb_hdr_id
long   ll_ReportCount
long   i, j, ll_FileCount, f
long ll_list_count  //maha 10.22.2013
long eof = 1
integer chk = 0
long li_FileNum  //maha 09.06.2012
string ls_doc_id
string ls_UplodFile
string ls_DownLoadFileOld
string ls_DownLoadFileNew
string ls_bakfile
string ls_ElementText
string ls_ElementTextArray[]
string ls_reportnames[] //maha 09.06.2012
string ls_file_names[] //maha 09.06.2012
string ls_dllist_file //maha 09.06.2012
string ls_read_string //maha 09.06.2012
string ls_dlf_name  //maha 09.06.2012
string ls_file_error  //maha 09.06.2012
string ls_file_error_list  //maha 09.06.2012
string ls_temp   //maha 09.06.2012
string ls_array[]   //maha 09.06.2012
date ld_today
time lt_now

n_cst_xml_parser lnv_Xml
n_cst_dirattrib lnv_dirlist[]
n_cst_filesrvwin32 lnv_filesrvwin32
DataStore lds_Report[]
datastore lds_list   //Start Code Change ----10.22.2013 #V14 maha

// Get receive files
lnv_filesrvwin32 = Create n_cst_filesrvwin32
lnv_filesrvwin32.of_DirList(is_directories2[2] + "\*.xml", 0, lnv_dirlist)
ll_FileCount = UpperBound(lnv_dirlist[])

//messagebox("","change file")

//Start Code Change ----09.06.2012 #V12 maha
//get the filenames from the downloadlist
ls_dllist_file = is_current_path  + "\qrxs\download.lst"
li_FileNum = FileOpen( ls_dllist_file, LineMode!)

//store file list in dw
lds_list = create datastore	
lds_list.dataobject = "d_print_space"
lds_list.settransobject(sqlca)

//Start Code Change ----10.22.2013 #V14 maha
if li_FileNum = -1 then
	ll_list_count = 0
else

	//read the download file
	do until eof < 1
		eof = FileRead(li_FileNum, ls_read_string)
		if eof = -100 then exit
		ls_read_string = Lower(Trim(ls_read_string))
		ls_file_names[upperbound(ls_file_names) + 1] = ls_read_string
	loop
	
	ll_list_count = upperbound(ls_file_names)
	
	FileClose(li_FileNum)
	

	for i = 1 to ll_list_count
		lds_list.insertrow(1)
		lds_list.setitem(1, "print_space", ls_file_names[i])
	next
	
		
	//backup the download file
	ld_today = today()
	lt_now = now()
	
	ls_dlf_name = "RCVD-" + string(year(ld_today)) + string(month(ld_today)) + string(day(ld_today)) + string(hour(lt_now)) + string(minute(lt_now)) + string(second(lt_now)) + ".lst"
	
	ls_bakfile =  is_current_path  + "\qrxs\processed\" + ls_dlf_name
	CopyFileA(ls_dllist_file, ls_bakfile, false)
End if

//End Code Change ----10.22.2013

//if no files return
//if upperbound(ls_file_names) = 0 then
if ll_list_count = 0 and ll_FileCount = 0 then   //Start Code Change ----10.22.2013 #V14 maha - only leave function if no files exist
//if ll_FileCount <= 0 then
	of_create_qrxs_download_log( ls_dlf_name, 0 ,0, "", "R")
	
	Destroy lnv_filesrvwin32
	Return SUCCESS
end if

// get downloaded file names
for i = 1 to  ll_FileCount
	lnv_string.of_ParseToArray ( is_directories2[2] + "\" + lnv_dirlist[i].is_FileName, '\', ls_array )
	ls_reportnames[i] =  ls_array[upperbound(ls_array)] 
next


// Create report datastores
ll_ReportCount = 10
for i = 1 to ll_ReportCount
	lds_Report[i] = Create DataStore
next
lds_Report[1].DataObject = "d_npdb_qrxs_hdr"
lds_Report[2].DataObject = "d_npdb_qrxs_status"
lds_Report[3].DataObject = "d_npdb_qrxs_individual"
lds_Report[4].DataObject = "d_npdb_qrxs_aar"
lds_Report[5].DataObject = "d_npdb_qrxs_jocr"
lds_Report[6].DataObject = "d_npdb_qrxs_mmpr"
lds_Report[7].DataObject = "d_npdb_qrxs_laar"
lds_Report[8].DataObject = "d_npdb_qrxs_lmmpr"
lds_Report[9].DataObject = "d_npdb_qrxs_contact"  //add by stephen 09.12.2012 -- v12.2 modify NPDB qrxs report
lds_Report[10].DataObject = "d_npdb_qrxs_individual_total"  //add by stephen 11.06.2012 --save querySubjectResponse->individual

for i = 1 to ll_ReportCount
	lds_Report[i].SetTransObject(SQLCA)
next

// Get max npdb_hdr_id
SELECT max(npdb_hdr_id) INTO :ll_npdb_hdr_id FROM npdb_qrxs_hdr;
if IsNull(ll_npdb_hdr_id) then ll_npdb_hdr_id = 0
ll_npdb_hdr_id ++


//@@@@@@@@@@@@@
// Parse XML files process

//Start Code Change ----10.22.2013 #V14 maha - loop through files first rather than file list
For i = 1 to ll_FileCount
//for i = 1 to upperbound(ls_file_names) 
	chk = 0
	chk = lds_list.find("print_space = '" + ls_reportnames[i] + "'", 1, lds_list.rowcount()) // find the file in the file list data
//	//check for file existence // maha 09.06.2012
//	for f = 1 to upperbound(ls_reportnames)
//		//if ls_file_names[i] = ls_reportnames[f] then
//		if lower(ls_file_names[i]) = lower(ls_reportnames[f]) then //alfee 10.16.2012
//			//filefound
//			chk = f
//			exit
//		end if
//	next
	debugbreak()
	if chk < 0 then
		messagebox("of_get_qrxs_report Error","Error filtering List names.")
		return -1
	elseif chk = 0 then //file not found in download list
		ls_file_error_list+=  ls_reportnames[i] + " "
		//continue
	else
		lds_list.deleterow(chk)
	end if
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@	
	// Construct a XML object
	ls_DownLoadFileOld = is_directories2[2] + "\" + lnv_dirlist[ i ].is_FileName
	lnv_Xml.of_CreateFromFile(ls_DownLoadFileOld)
		
	if gi_test_mode = 1 then //add Michael 07.25.2012 Ticket # 00036476: QRXS NPDB Urgent Issue 
		ls_bakfile = is_directories2[5] +'\'+  lnv_dirlist[i].is_FileName 
		CopyFileA(ls_DownLoadFileOld, ls_bakfile, false)
	end if

	
	// Check Doc ID if exists
	ls_ElementText = lnv_Xml.of_GetElementText("queryResponse\querySubjectResponse\individual\customerUse")
	if IsNull(ls_ElementText) or ls_ElementText = "" then
		ls_ElementText = lnv_Xml.of_GetElementText("pdsResponse\pdsSubjectResponse\individual\customerUse")
		if IsNull(ls_ElementText) or ls_ElementText = "" then
			ls_file_error =  ls_reportnames[i] + " "  // maha 09.06.2012
			Continue
		end if
	end if
	ls_doc_id = ls_ElementText
	
	// Delete upload file and backup download file
	ls_UplodFile = is_directories2[3] +'\'+ ls_doc_id + ".xml"
//	ls_DownLoadFileNew = is_directories2[5] +'\'+  ls_doc_id + ".xml"
	ls_DownLoadFileNew = is_directories2[5] +'\R-'+  ls_doc_id + '@' +  mid(ls_DownLoadFileOld, pos(ls_DownLoadFileOld, ".xml") - 7, 7)  +".xml"  //Start Code Change ----08.29.2012 #V12 maha - modified to preserve last 7 of download file name
	FileDelete(ls_UplodFile)
	CopyFileA(ls_DownLoadFileOld, ls_DownLoadFileNew, false)

	// Parse data into each report datastore
	// [$queryResponse\] hdr
	ls_ElementText = lnv_Xml.of_GetElementText("queryResponse")
	if IsNull(ls_ElementText) or ls_ElementText = "" then
		ls_ElementText = lnv_Xml.of_GetElementText("pdsResponse")
	end if
	lnv_Xml.of_CreateFromString(ls_ElementText)
	of_get_qrxs_report_hdr(lnv_Xml, lds_Report[1], ls_doc_id)
	
	// [$queryResponse\querySubjectResponse\] status, individual
	ls_ElementText = lnv_Xml.of_GetElementText("querySubjectResponse")
	if IsNull(ls_ElementText) or ls_ElementText = "" then
		ls_ElementText = lnv_Xml.of_GetElementText("pdsSubjectResponse")
	end if
	lnv_Xml.of_CreateFromString(ls_ElementText)
	of_get_qrxs_report_status(lnv_Xml, lds_Report[2])
	of_get_qrxs_report_individual(lnv_Xml, lds_Report[10])  //add by stephen 11.06.2012 --save querySubjectResponse->individual
	
	// [$queryResponse\querySubjectResponse\report\] aar, jocr, mmpr, laar, lmmpr
	lnv_Xml.of_GetElementText("report", ls_ElementTextArray[])
	
	ii_report_id = 1
	for j = 1 to UpperBound(ls_ElementTextArray)
		lnv_Xml.of_CreateFromString(ls_ElementTextArray[j])
		of_get_qrxs_report_aar(lnv_Xml, lds_Report[4])
		of_get_qrxs_report_jocr(lnv_Xml, lds_Report[5])
		of_get_qrxs_report_mmpr(lnv_Xml, lds_Report[6])
		of_get_qrxs_report_laar(lnv_Xml, lds_Report[7])
		of_get_qrxs_report_lmmpr(lnv_Xml, lds_Report[8])
		of_get_qrxs_report_contact(lnv_Xml, lds_Report[9])  //move by stephen 10.15.2012 --add by stephen 09.12.2012 -- v12.2 modify NPDB qrxs report
		of_get_qrxs_report_individual(lnv_Xml, lds_Report[3]) //move by stephen 11.06.2012 --use querySubjectResponse->report->individual
		ii_report_id = ii_report_id +1 //add by stephen 11.05.2012 --NPDB test error
	next
	if lds_Report[2].RowCount() > 0 then
		lds_Report[2].SetItem(1, "report_count", String(UpperBound(ls_ElementTextArray)))
	end if

	// Set npdb_hdr_id and update datastores
	gnv_appeondb.of_StartQueue()
	for j = 1 to ll_ReportCount
		for ll_Row = 1 to lds_Report[j].RowCount()
			lds_Report[j].SetItem(ll_Row, "npdb_hdr_id", ll_npdb_hdr_id)
		next
		lds_Report[j].Update()
	next
	gnv_appeondb.of_CommitQueue()
	ll_npdb_hdr_id ++
	
	// Update verification record (lds_Report[1] is hdr; lds_Report[1] is status)
	of_set_post_import_status_qrxs(lds_Report[1], lds_Report[2])
	for j = 1 to ll_ReportCount
		lds_Report[j].Reset()
	next
	
	FileDelete(is_directories2[2] + "\" + lnv_dirlist[i].is_FileName)
next

//Start Code Change ----10.22.2013 #V14 maha
//check to see if list shows other files
for i = 1 to lds_list.rowcount( )
	 ls_file_error+= lds_list.getitemstring(i,"print_space")
next

if lenA(ls_file_error_list) > 0 then
	 ls_file_error_list = " Missing files:" +  ls_file_error_list
end if

if lenA(ls_file_error) > 0 then
	 ls_file_error = " Missing from list:" +  ls_file_error
end if

ls_file_error =  ls_file_error +  ls_file_error_list
ls_file_error = leftA( ls_file_error, 255)
//End Code Change ----10.22.2013

//download log // maha 09.06.2012
of_create_qrxs_download_log( ls_dlf_name, ll_list_count , ll_FileCount,  ls_file_error , "R") 

// Destroy report datastores
for j = 1 to ll_ReportCount
	Destroy lds_Report[j]
next

Destroy lds_list

//// Delete all receive files //// maha 09.06.2012 - moved delete to loop to preserve any files not in the downloadlist
//for i = 1 to UpperBound(lnv_dirlist)
//	FileDelete(is_directories2[2] + "\" + lnv_dirlist[i].is_FileName)
//next
Destroy lnv_filesrvwin32

Return SUCCESS
end function

public function integer of_set_post_import_status_qrxs (datastore ads_npdb_hdr, datastore ads_npdb_status);//////////////////////////////////////////////////////////////////////
// $<function> of_set_post_import_status_qrxs
// $<arguments>
//			datastore	ads_npdb_hdr
//			datastore	ads_npdb_status
// $<returns> integer
// $<description> Update verification record according to status
//                (V10.1 - NPDB QRXS)
//////////////////////////////////////////////////////////////////////
// $<add> Evan 12.10.2009
//////////////////////////////////////////////////////////////////////

long i, ll_Found
long ll_lookup_code
long ll_npdb_hdr_id
long ll_ReportCount
string ls_blank_array[]
string ls_doc_id_arr[]
string ls_doc_id
string ls_error_code
string ls_note_string
datetime ldt_ServerTime

// Retrieve verification records
if ads_npdb_hdr.RowCount() > 0 then
	ls_doc_id_arr[] = ads_npdb_hdr.object.doc_id[1, ads_npdb_hdr.RowCount()]
	gnv_appeondb.of_StartQueue()
	ids_varification.Retrieve(ls_doc_id_arr[])
	ids_tracker_by_doc_id.Retrieve(ls_doc_id_arr[])
	gnv_appeondb.of_CommitQueue()
else
	Return SUCCESS
end if
is_err_mess[] = ls_blank_array[]
ldt_ServerTime = of_get_server_datetime()
debugbreak()
// Filter lookup datawindow
ids_lookup_code.SetFilter("npdb_list = 'error_cd_qrxs'")
ids_lookup_code.Filter()

// Update verification record process (actually, ads_npdb_hdr and ads_npdb_status row count always is 1)
for i = 1 to ads_npdb_hdr.RowCount()
	ll_npdb_hdr_id = ads_npdb_hdr.object.npdb_hdr_id[i]
	ads_npdb_status.SetFilter("npdb_hdr_id = " + String(ll_npdb_hdr_id))
	ads_npdb_status.Filter()
	if ads_npdb_status.RowCount() < 1 then Continue	
	//ids_tracker_by_doc_id.setfilter('npdb_hdr_id =' +  STRING(ll_npdb_hdr_id))
	//ids_tracker_by_doc_id.filter()	
		
	// Get the rejections for message
	ls_error_code = ads_npdb_status.object.error_code[1]
	ll_ReportCount = Long(ads_npdb_status.object.report_count[1])
	if LenA(ls_error_code) > 0 and ls_error_code <> "C00" then
		ll_Found = ids_lookup_code.Find("npdb_list_code = '" + ls_error_code + "'", 1, ids_lookup_code.RowCount())
		if ll_Found > 0 then
			//is_err_mess[upperbound(is_err_mess) + 1] = "NPDB REJECTION: " + ids_lookup_code.object.npdb_list_code_description[ll_Found] 
			is_err_mess[upperbound(is_err_mess) + 1] = "NPDB REJECTION: " + ls_error_code + " - " +  ids_lookup_code.object.npdb_list_code_description[ll_Found]  //Start Code Change ----03.24.2015 #V15 maha - added code to message
		end if
	end if

   // Update verification record
	ls_doc_id = ads_npdb_hdr.object.doc_id[i]
	ll_Found = ids_varification.Find("doc_id = '" + ls_doc_id + "'", 1, ids_varification.RowCount())
	if ll_Found > 0 then
		ls_note_string = ids_varification.object.notes[ll_Found]
		if IsNull(ls_note_string) or Trim(ls_note_string) = "" then ls_note_string = ""
		if LenA(ls_note_string) > 0 then ls_note_string += " , "
		if LenA(ls_error_code) > 0 and ls_error_code <> "C00" then //got an error
		   ids_varification.object.print_flag[ll_Found] = 1
			ls_note_string += "NPDB error " + ls_error_code
		elseif ll_ReportCount > 0 then  //got reports
			ls_note_string += String(ll_ReportCount) + " NPDB report(s) found"
		else //no reports found for this doc_id
			ll_lookup_code = Long(gnv_data.of_getitem("code_lookup", "lookup_code", "lookup_name = 'Credentials Verification Response' and code = 'ND'"))
			ids_varification.object.response_code[ll_Found] = ll_lookup_code
			ids_varification.object.date_recieved[ll_Found] = ldt_ServerTime
			ids_varification.object.user_name[ll_Found] = gs_user_id
			ls_note_string += "No NPDB reports found-" + String(Date(ldt_ServerTime))
		end if
		ids_varification.object.notes[ll_Found] = ls_note_string
	end if
	
	// Update filtered tracker record
	if ids_tracker_by_doc_id.RowCount() > 0 then
		if LenA(ls_error_code) > 0 and ls_error_code <> "C00" then //got an error
			ids_tracker_by_doc_id.object.cust_3[1] = ls_error_code
			ids_tracker_by_doc_id.object.rec_cnt[1] = -1
		else //no error set rep count and recieve date
			ids_tracker_by_doc_id.object.rec_cnt[1] = ll_ReportCount
			ids_tracker_by_doc_id.object.cust_3[1] = "C00"
		end if	
		ids_tracker_by_doc_id.object.r_date[1] = ldt_ServerTime
	end if
next

// Update data
gnv_appeondb.of_StartQueue()
ids_varification.Update()
ids_tracker_by_doc_id.Update()
gnv_appeondb.of_CommitQueue()

Return SUCCESS
end function

private function integer of_setitem (ref datastore ads_report, long al_insertrow, string as_columnstr, string as_elementstr, ref string as_elementtext[]);//////////////////////////////////////////////////////////////////////
// $<function> of_setitem
// $<arguments>
//			ref datastore	ads_report
//				 long			al_insertrow
//				 string		as_columnstr
//				 string		as_elementstr
//			ref string		as_elementtext[]
// $<returns> integer
// $<description> Set items
//                (V10.1 - NPDB QRXS)
//////////////////////////////////////////////////////////////////////
// $<add> Evan 12.17.2009
//////////////////////////////////////////////////////////////////////

long i, j
long ll_ColCount
long ll_ElementTextCount
string ls_Text
string ls_Column[]
string ls_Element[]
n_cst_xml_parser lnv_Xml

lnv_Xml.of_ParseToArray(as_ColumnStr, ",", ls_Column[])
lnv_Xml.of_ParseToArray(as_ElementStr, ",", ls_Element[])

ll_ElementTextCount = UpperBound(as_ElementText[])
ll_ColCount = UpperBound(ls_Column[])
if ll_ColCount < 1 then Return FAILURE
if ll_ColCount <> UpperBound(ls_Element[]) then Return FAILURE

for i = 1 to ll_ElementTextCount
	if ll_ColCount > 1 then
		if lnv_Xml.of_CreateFromString(as_ElementText[i]) = 1 then
			for j = 1 to ll_ColCount
				ls_Text = lnv_Xml.of_GetElementText(ls_Element[j])
				ads_Report.SetItem(al_InsertRow, ls_Column[j] + String(i), ls_Text)
			next
		end if
	else
		ads_Report.SetItem(al_InsertRow, ls_Column[1] + String(i), as_ElementText[i])
	end if
next

Return SUCCESS
end function

public function string of_get_sched_msg ();//Get messages of the schedule - alfee 02.06.2010

return inv_message.of_get_message()
end function

public function integer of_get_sched_cnt ();//Get processed count of the schedule - alfee 02.06.2010

return inv_message.of_get_proc_cnt( )
end function

public function integer of_set_sched_flag (integer ai_sched_id, boolean ab_flag);//Set the schedule flag - Scheduler - alfee 02.06.2010

ib_schedule = ab_flag
ii_sched_id = ai_sched_id //specially for npdb

IF Isvalid(inv_message) THEN
	inv_message.of_set_schedule(ab_flag)		
END IF

RETURN 1
end function

public function integer of_create_qrxs_upload_file_org (string as_docid);//////////////////////////////////////////////////////////////////////
// $<function> of_create_qrxs_upload_file_org
// $<arguments>
//			string	as_docid
// $<returns> integer
// $<description> Create upload files (V10.1 - NPDB QRXS) copy of original code 04.14.2010
//////////////////////////////////////////////////////////////////////
// $<add> Evan 11.24.2009
//////////////////////////////////////////////////////////////////////

string ls_XML, ls_File
string ls_npdb_entity_dbid, ls_npdb_agent_dbid, ls_npdb_user_id
string ls_npdb_pay_type, ls_npdb_cc_nbr, ls_npdb_cc_exp, ls_cc_cardholder, ls_cc_billing_addr1, ls_cc_billing_city, ls_cc_billing_state, ls_cc_zip5
string ls_npdb_cert_name, ls_npdb_cert_title, ls_npdb_cert_phone, ls_npdb_cert_ext, ls_npdb_cert_date
string ls_pd_basic_last_name, ls_pd_basic_first_name, ls_pd_basic_middle_name
string ls_pd_basic_gender, ls_pd_basic_date_of_birth, ls_pd_basic_ssn, ls_pd_basic_npi_number
string ls_pd_address_street[2], ls_pd_address_street_2[2], ls_pd_address_city[2], ls_pd_address_state[2], ls_pd_address_zip[2]
string ls_lic_field, ls_lic_num, ls_lic_state, ls_lic_desc, ls_spec, ls_speciality
string ls_Element, ls_year_thru, ls_instition_name
long   ll_Row, ll_FindRow, ll_prac_id, ll_speciality_code, ll_Grad, ld_lookup_code, ll_lookup_code_arr[]
DataStore lds_fien, lds_dea, lds_upin, lds_grad, lds_address_lookup, lds_speciality, lds_lic
boolean lb_home = false //maha 04.14.2010 - for home address
is_current_facility_id = String(ids_pracs.object.fac_id[1])

//////////////////////////////////////////////////////////////////////
// Get submission information
ll_prac_id = ids_pracs_info.object.prac_id[1]
lds_fien = Create DataStore
lds_fien.DataObject = "d_npdb_pd_fien"
lds_fien.SetTransObject(SQLCA)
lds_dea = Create DataStore
lds_dea.DataObject = "d_npdb_pd_dea"
lds_dea.SetTransObject(SQLCA)
lds_upin = Create DataStore
lds_upin.DataObject = "d_npdb_pd_upin"
lds_upin.SetTransObject(SQLCA)
lds_grad = Create DataStore
lds_grad.DataObject = "d_npdb_grad2"
lds_grad.SetTransObject(SQLCA)
lds_speciality = Create DataStore
lds_speciality.DataObject = "d_npdb_pd_speciality"
lds_speciality.SetTransObject(SQLCA)
lds_lic = Create DataStore
lds_lic.DataObject = "d_npdb_pd_lic"
lds_lic.SetTransObject(SQLCA)

gnv_appeondb.of_StartQueue()
lds_fien.Retrieve(ll_prac_id)
lds_dea.Retrieve(ll_prac_id)
lds_upin.Retrieve(ll_prac_id)
lds_address_info.Retrieve(ll_prac_id, il_current_fac_id)
lds_grad.Retrieve(ll_prac_id)
lds_speciality.Retrieve(ll_prac_id)
lds_lic.Retrieve(ll_prac_id)
SELECT npi_number INTO :ls_pd_basic_npi_number FROM pd_basic WHERE prac_id = :ll_prac_id;
gnv_appeondb.of_CommitQueue()

if lds_grad.RowCount() > 0 then
	ll_lookup_code_arr[] = lds_grad.object.institution_code[1, lds_grad.RowCount()]
	lds_address_lookup = Create Datastore
	lds_address_lookup.Dataobject = "d_address_lookup_forpt"
	lds_address_lookup.Settransobject(SQLCA)
	lds_address_lookup.Retrieve(ll_lookup_code_arr[])
end if

// <submitter>
if not IsNull(ids_npdb_fac_info.object.npdb_entity_dbid[1]) then ls_npdb_entity_dbid = ids_npdb_fac_info.object.npdb_entity_dbid[1]
if not IsNull(ids_npdb_fac_info.object.npdb_agent_dbid[1]) then ls_npdb_agent_dbid = ids_npdb_fac_info.object.npdb_agent_dbid[1]
//if not IsNull(ids_npdb_fac_info.object.npdb_user_id[1]) then ls_npdb_user_id = ids_npdb_fac_info.object.npdb_user_id[1]
ls_npdb_user_id = '1111252'  //Start Code Change ----04.13.2010 #V10 maha - used for the vendorid; is a hardcoded value for ISG
// <payment>
if not IsNull(ids_cc_information.object.npdb_pay_type[1]) then ls_npdb_pay_type = ids_cc_information.object.npdb_pay_type[1]
if not IsNull(ids_cc_information.object.npdb_cc_nbr[1]) then ls_npdb_cc_nbr = ids_cc_information.object.npdb_cc_nbr[1]
if not IsNull(ids_cc_information.object.npdb_cc_exp[1]) then ls_npdb_cc_exp = ids_cc_information.object.npdb_cc_exp[1]
if not IsNull(ids_cc_information.object.cc_cardholder[1]) then ls_cc_cardholder = ids_cc_information.object.cc_cardholder[1]
if not IsNull(ids_cc_information.object.cc_billing_addr1[1]) then ls_cc_billing_addr1 = ids_cc_information.object.cc_billing_addr1[1]
if not IsNull(ids_cc_information.object.cc_billing_city[1]) then ls_cc_billing_city = ids_cc_information.object.cc_billing_city[1]
if not IsNull(ids_cc_information.object.cc_billing_state[1]) then ls_cc_billing_state = ids_cc_information.object.cc_billing_state[1]
if not IsNull(ids_cc_information.object.cc_zip5[1]) then ls_cc_zip5 = ids_cc_information.object.cc_zip5[1]
// <certification>
if not IsNull(ids_npdb_fac_info.object.npdb_cert_name[1]) then ls_npdb_cert_name = ids_npdb_fac_info.object.npdb_cert_name[1]
if not IsNull(ids_npdb_fac_info.object.npdb_cert_title[1]) then ls_npdb_cert_title = ids_npdb_fac_info.object.npdb_cert_title[1]
if not IsNull(ids_npdb_fac_info.object.npdb_cert_phone[1]) then 
	ls_npdb_cert_phone = ids_npdb_fac_info.object.npdb_cert_phone[1]
	ls_npdb_cert_phone = of_strip_char("", ls_npdb_cert_phone,"@NUM@")  //Start Code Change ----04.13.2010 #V10 maha - strip to numbers only
end if
if not IsNull(ids_npdb_fac_info.object.npdb_cert_ext[1]) then ls_npdb_cert_ext = ids_npdb_fac_info.object.npdb_cert_ext[1]
if not IsNull(ids_npdb_fac_info.object.npdb_cert_date[1]) then ls_npdb_cert_date = String(ids_npdb_fac_info.object.npdb_cert_date[1],'YYYY-MM-DD')
// <individual>-<name>
if not IsNull(ids_pracs_info.object.last_name[1]) then ls_pd_basic_last_name = ids_pracs_info.object.last_name[1]
if not IsNull(ids_pracs_info.object.first_name[1]) then ls_pd_basic_first_name = ids_pracs_info.object.first_name[1]
if not IsNull(ids_pracs_info.object.middle_name[1]) then ls_pd_basic_middle_name = Trim(ids_pracs_info.object.middle_name[1])
// <individual>-<gender>
if not IsNull(ids_pracs_info.object.gender[1]) then ls_pd_basic_gender = Upper(LeftA(String(ids_pracs_info.object.gender[1]),1))
// <individual>-<birthdate>
if not IsNull(ids_pracs_info.object.date_of_birth[1]) then ls_pd_basic_date_of_birth = String(ids_pracs_info.object.date_of_birth[1],'YYYY-MM-DD')
// <individual>-<workAddress>
lds_address_info.Setfilter("primary_office = 1")
lds_address_info.Filter()
if lds_address_info.RowCount() > 0 then
	if not IsNull(lds_address_info.object.street[1]) then ls_pd_address_street[1] = lds_address_info.object.street[1]
	if not IsNull(lds_address_info.object.street_2[1]) then ls_pd_address_street_2[1] = lds_address_info.object.street_2[1]
	if not IsNull(lds_address_info.object.city[1]) then ls_pd_address_city[1] = lds_address_info.object.city[1]
	if not IsNull(lds_address_info.object.zip[1]) then ls_pd_address_zip[1] = lds_address_info.object.zip[1]
	if not IsNull(lds_address_info.object.state[1]) then
		ls_pd_address_state[1] = gnv_data.of_getitem("code_lookup", "code", "lookup_code = " + String(lds_address_info.object.state[1]))
		if IsNull(ls_pd_address_state[1]) then ls_pd_address_state[1] = ""
	end if
end if
// <individual>-<homeAddress>
lds_address_info.Setfilter("home_address = 1")
lds_address_info.Filter()
if lds_address_info.RowCount() > 0 then
	if not IsNull(lds_address_info.object.street[1]) then ls_pd_address_street[2] = lds_address_info.object.street[1]
	if not IsNull(lds_address_info.object.street_2[1]) then ls_pd_address_street_2[2] = lds_address_info.object.street_2[1]
	if not IsNull(lds_address_info.object.city[1]) then ls_pd_address_city[2] = lds_address_info.object.city[1]
	if not IsNull(lds_address_info.object.zip[1]) then ls_pd_address_zip[2] = lds_address_info.object.zip[1]
	if not IsNull(lds_address_info.object.state[1]) then
		ls_pd_address_state[2] = gnv_data.of_getitem("code_lookup", "code", "lookup_code = " + String(lds_address_info.object.state[1]))
		if IsNull(ls_pd_address_state[2]) then ls_pd_address_state[2] = ""
	end if
	lb_home = true  //Start Code Change ----04.14.2010 #V10 maha
end if
// <individual>-<ssn>
if not IsNull(ids_pracs_info.object.ssn[1]) then ls_pd_basic_ssn = ids_pracs_info.object.ssn[1]

//////////////////////////////////////////////////////////////////////
// Create submission file
ls_XML = &
'<?xml version="1.0" encoding="UTF-8"?>~r~n' + &
'<query:querySubmission xmlns:query="http://www.npdb-hipdb.hrsa.gov/Query">~r~n' + &
'	<submitter>~r~n' + &
'		<entityDBID>' + ls_npdb_entity_dbid + '</entityDBID>~r~n'
if LenA(ls_npdb_agent_dbid) > 0 then
	ls_XML += &
'		<agentDBID>' + ls_npdb_agent_dbid + '</agentDBID>~r~n'
end if
ls_XML += &
'		<vendorID>' + ls_npdb_user_id + '</vendorID>~r~n' + &
'	</submitter>~r~n' + &
'	<payment>~r~n'
if ls_npdb_pay_type = "A" then
	ls_XML += &
'		<EFT>true</EFT>~r~n'
elseif ls_npdb_pay_type = "C" then
	ls_XML += &
'		<creditCard>~r~n' + &
'			<number>' + ls_npdb_cc_nbr + '</number>~r~n' + &
'			<expirationDate>' + ls_npdb_cc_exp + '</expirationDate>~r~n' + &
'			<cardholderName>' + ls_cc_cardholder + '</cardholderName>~r~n' + &
'			<cardholderAddress>~r~n' + &
'				<address>' + ls_cc_billing_addr1 + '</address>~r~n' + &
'				<city>' + ls_cc_billing_city + '</city>~r~n' + &
'				<state>' + ls_cc_billing_state + '</state>~r~n' + &
'				<zip>' + ls_cc_zip5 + '</zip>~r~n' + &
'			</cardholderAddress>~r~n' + &
'		</creditCard>~r~n'
end if
ls_XML += &
'	</payment>~r~n' + &
'	<purpose>P</purpose>~r~n' + &
'	<certification>~r~n' + &
'		<name>' + ls_npdb_cert_name + '</name>~r~n' + &
'		<title>' + ls_npdb_cert_title + '</title>~r~n' + &
'		<phone>~r~n' + &
'			<number>' + ls_npdb_cert_phone + '</number>~r~n' + &
'			<extension>' + ls_npdb_cert_ext + '</extension>~r~n' + &
'		</phone>~r~n' + &
'		<date>' + ls_npdb_cert_date + '</date>~r~n' + &
'	</certification>~r~n' + &
'	<individual>~r~n' + &
'		<name>~r~n' + &
'			<last>' + ls_pd_basic_last_name + '</last>~r~n' + &
'			<first>' + ls_pd_basic_first_name + '</first>~r~n' + &
'			<middle>' + ls_pd_basic_middle_name + '</middle>~r~n' + &
'			<suffix></suffix>~r~n' + &
'		</name>~r~n' + &
'		<gender>' + ls_pd_basic_gender + '</gender>~r~n' + &
'		<birthdate>' + ls_pd_basic_date_of_birth + '</birthdate>~r~n' + &
'		<workAddress>~r~n' + &
'			<address>' + ls_pd_address_street[1] + '</address>~r~n' + &
'			<address2>' + ls_pd_address_street_2[1] + '</address2>~r~n' + &
'			<city>' + ls_pd_address_city[1] + '</city>~r~n' + &
'			<state>' + ls_pd_address_state[1] + '</state>~r~n' + &
'			<zip>' + ls_pd_address_zip[1] + '</zip>~r~n' + &
'		</workAddress>~r~n'
//Start Code Change ----04.14.2010 #V10 maha - only put in file if there is data 
if lb_home = true then
	ls_XML += &
'		<homeAddress>~r~n' + &
'			<address>' + ls_pd_address_street[2] + '</address>~r~n' + &
'			<address2>' + ls_pd_address_street_2[2] + '</address2>~r~n' + &
'			<city>' + ls_pd_address_city[2] + '</city>~r~n' + &
'			<state>' + ls_pd_address_state[2] + '</state>~r~n' + &
'			<zip>' + ls_pd_address_zip[2] + '</zip>~r~n' + &
'		</homeAddress>~r~n' 
end if
//End Code Change ----04.14.2010
ls_XML += &
'		<ssn>' + ls_pd_basic_ssn + '</ssn>~r~n'

//fein
for ll_Row = 1 to lds_fien.RowCount()
	if ll_Row < 5 and not IsNull(lds_fien.object.id_number[ll_Row]) then
		ls_XML += '		<fein>' + lds_fien.object.id_number[ll_Row] + '</fein>~r~n'
	end if
next
//npi
if f_validstr(ls_pd_basic_npi_number) then
		ls_XML += '		<npi>' + ls_pd_basic_npi_number + '</npi>~r~n'
end if
//dea
for ll_Row = 1 to lds_dea.RowCount()
	if ll_Row < 5 and not IsNull(lds_dea.object.license_number[ll_Row]) then
		ls_XML += '		<dea>' + lds_dea.object.license_number[ll_Row] + '</dea>~r~n'
	end if
next
//upin
for ll_Row = 1 to lds_upin.RowCount()
	if ll_Row < 5 and not IsNull(lds_upin.object.id_number[ll_Row]) then
		ls_XML += '		<upin>' + lds_upin.object.id_number[ll_Row] + '</upin>~r~n'
	end if
next
//professionalSchool
for ll_Row = 1 to lds_grad.RowCount()
	if ll_Row > 5 then Exit
	ls_year_thru = ""
	ls_instition_name = ""
	ld_lookup_code = lds_grad.GetItemDecimal(ll_Row, "institution_code")
	ls_year_thru = String(year(date((lds_grad.GetItemdatetime(ll_Row, "end_date")))))
	if LenA(ls_year_thru) < 1 or IsNull(ls_year_thru) then
		ls_year_thru =  String(lds_grad.GetItemNumber(ll_Row, "year_thru"))
	end if
	ll_Grad = Integer(String(ids_pracs_info.object.date_of_birth[1], "YYYY"))
	if ll_Grad + 15 <  Integer(ls_year_thru) then		
		ll_FindRow = lds_address_lookup.Find("lookup_code = " + String(ld_lookup_code), 1, lds_address_lookup.Rowcount())
		if ll_FindRow > 0 then
			ls_instition_name = lds_address_lookup.GetItemString(ll_FindRow, "entity_name")
		end if
		if f_validstr(ls_instition_name) and f_validstr(ls_year_thru) then
			ls_XML += '		<professionalSchool>~r~n' + &
						 '			<school>' + ls_instition_name + '</school>~r~n' + &
						 '			<graduationYear>' + ls_year_thru + '</graduationYear>~r~n' + &
						 '		</professionalSchool>~r~n'
		end if
	end if
next
debugbreak()
//occupationAndLicensure
if lds_speciality.Rowcount() > 0 then
	ll_speciality_code = lds_speciality.GetItemNumber(1, "specialty")
	ls_spec = gnv_data.of_getitem("code_lookup", "description", "lookup_code = " + String(ll_speciality_code))
else
	ls_spec = "99"
end if
if lds_lic.Rowcount() > 0 then
	//Field
	ls_lic_field = String(lds_lic.object.code_lookup_ic_n[1])
	if IsNull(ls_lic_field) then ls_lic_field = ""
	if LenA(ls_lic_field) = 0 then
		ls_lic_field = "699"
	elseif LenA(ls_lic_field) = 1 then
		ls_lic_field = "00" + ls_lic_field
	elseif LenA(ls_lic_field) = 2 then
		ls_lic_field = "0" + ls_lic_field
	end if
	//Description, Specialty
	choose case ls_lic_field
		case "699", "899"
			ls_lic_desc = lds_lic.object.code_lookup_description[1]
			ls_speciality = ""
		case "010", "015", "020", "025", "030", "035"
			ls_speciality = gnv_data.of_getitem("code_lookup", "ic_c", "lookup_code = " + String(ll_speciality_code))
			if ls_speciality = "" or IsNull(ls_speciality) then
				//Start Code Change ----04.14.2010 #V10 maha - added upper to filter
				SELECT npdb_list_code INTO :ls_speciality FROM  npdb_code_lookup
				WHERE npdb_list = 'list_d' and upper(npdb_list_code_description)  = upper(:ls_spec);
			end if
			if not f_validstr(ls_speciality) then ls_speciality = "99"
		case else
			ls_lic_desc = ""
			ls_speciality = ""
	end choose
	//Number
	ls_lic_num = lds_lic.object.license_number[1]
	//State
	ls_lic_state = gnv_data.of_getitem("code_lookup", "code", "lookup_code = " + String(lds_lic.object.state[1]))
	//Build XML
	ls_XML += '		<occupationAndLicensure>~r~n'
	if f_validstr(ls_lic_num) then
		ls_XML += '			<number>' + ls_lic_num + '</number>~r~n'
	end if
	if f_validstr(ls_lic_state) then
		ls_XML += '			<state>' + ls_lic_state + '</state>~r~n'
	end if
	if f_validstr(ls_lic_field) then
		ls_XML += '			<field>' + ls_lic_field + '</field>~r~n'
	end if
	if f_validstr(ls_lic_desc) then
		ls_XML += '			<description>' + ls_lic_desc + '</description>~r~n'
	end if
	if f_validstr(ls_speciality) then
		ls_XML += '			<specialty>' + ls_speciality + '</specialty>~r~n'
	end if
	ls_XML += '		</occupationAndLicensure>~r~n'
end if
ls_XML += &
'		<customerUse>' + as_DocID + '</customerUse>~r~n' + &
'	</individual>~r~n' + &
'</query:querySubmission>'

ls_File = is_directories2[3] + '\' + is_current_file_name + ".xml"
of_create_file(ls_File, ls_XML)

// Destroy objects
if IsValid(lds_fien) then Destroy lds_fien
if IsValid(lds_dea) then Destroy lds_dea
if IsValid(lds_upin) then Destroy lds_upin
if IsValid(lds_grad) then Destroy lds_grad
if IsValid(lds_address_lookup) then Destroy lds_address_lookup
if IsValid(lds_speciality) then Destroy lds_speciality
if IsValid(lds_lic) then Destroy lds_lic

Return SUCCESS
end function

public function integer of_check_status_send_qrxs ();//Start Code Change ----08.2012 #V12 maha - added new function for QRXS send - copied from of_check_status
//called_from of_upload
//Used only for Send
long    ll_i,ll_j
integer i
long    li_FileNum
long    ll_return, chk, cnt
string  ls_read_string
string  ls_search_string
string  ls_stat
string  ls_status_code
string  ls_file
string  ls_dllist_file
string ls_path
integer li_err_cnt = 0
integer li_find
string  ls_Error[]
string  ls_Flag[]
string  ls_Text
string ls_file_list[]
string ls_file_names[]
string ls_docids[]
string ls_org
string ls_new
string ls_miss_files
string ls_log
window lw_1
listbox llb_1
integer li_items, li_i
integer eof = 1
date ld_now
time lt_time
boolean r
n_cst_xml_parser lnv_Xml
n_cst_xml_parser lnv_Element

//ls_patha = "c:\intellicred"
ls_path = is_current_path

// Filter on the error codes that are applicaple to the part
ids_lookup_code.SetFilter("npdb_list = 'error_cd_qrxs'")
ids_lookup_code.Filter()
// Get status file path
ls_file = is_status_files2[1]
//ls_file = ls_path + '\qrxs\qrxsstat.dat'

//Check the status file qrxsstat.dat
for ll_i = 1 to 100000
	chk ++
	if FileExists(ls_file) = true then
		Exit
	end if
	if chk > 99999 then
		//chk = MessageBox(ls_file, "Waiting for status file. Continue to wait?", Question!, YesNo!, 1)
		//Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
       chk = inv_message.of_MessageBox(ls_file, "Waiting for status file. Continue to wait?", Question!, YesNo!, 1,true)
		if chk = 1 then
			ll_i = 1
		else
			Return FAILURE
		end if
	end if
next

// Open the status file and check the error codes, add to the message
li_FileNum = FileOpen(ls_file, StreamMode!)
FileRead(li_FileNum, ls_read_string)
FileClose(li_FileNum)
ls_stat = MidA(ls_read_string, PosA(ls_read_string, "StatusCode=") + 11)

if ls_stat = "" then ls_stat = "C00"  //Start Code Change ----11.06.2012 #V12 maha - assume no code is success
ls_status_code = ls_stat
IS_STATUS_CODE = ls_stat


//ls_Stat = "OK"
if ls_stat <> "C00" then
	li_find = ids_lookup_code.find("npdb_list_code ='" + ls_stat + "'", 1, ids_lookup_code.rowcount())
	if li_find > 0 then
		//is_err_mess[upperbound(is_err_mess) + 1 ] = ids_lookup_code.object.npdb_list_code_description[li_find]
		is_err_mess[upperbound(is_err_mess) + 1 ] = ls_stat + " - " + ids_lookup_code.object.npdb_list_code_description[li_find]   //Start Code Change ----03.24.2015 #V15 maha - added code to message
		li_err_cnt ++
	else
		is_err_mess[upperbound(is_err_mess) + 1 ] = "Unknown NPDB error code:" + ls_stat 
		li_err_cnt ++
		is_error_info = "Unknown NPDB error code:" + ls_stat 
		messagebox("","Unknown error")
	end if
	//code for specific failures in the qrxsstat.dat file but pass for others
	choose case ls_stat
		case 'C01','C02','C03','C04', 'C05', 'C06','C07','C08','C09','C10','C12','C13', 'C16','C17'
			ll_return = FAILURE
		case  'C21','C22','C23','C24', 'C30','C31','C32','C40','C43'
			ll_return = FAILURE
		case   'C54','C56','C57','C58', 'C59','C60'
			ll_return = FAILURE
		case   'C62','C64','C68', 'C69'   //Start Code Change ----03.24.2015 #V15 maha - added new codes
			ll_return = FAILURE
		case else  //provider specific failure
			ll_return = 0
	end choose
	
	of_create_qrxs_log( IS_CURRENT_FILE_NAME, il_upload_prac ,il_current_fac_id,"", "SCE", "Status code error" + is_err_mess[li_err_cnt ])
	ib_process_failed = true
	
	if ll_return = FAILURE then  //initial file failure
		of_post_send_qrxs(FAILURE)
		return FAILURE
	else //provider specific failure
		ll_return = FAILURE
	end if
end if

// Check the confirmation file, add to the message
//C00 - success no errors

//create a list of files from the download folder
Open( lw_1 )
lw_1.openUserObject( llb_1 )
llb_1.DirList( ls_path  + "\qrxs\downloadconf\", 0 )
li_items = llb_1.TotalItems()

For li_i = 1 to li_items
	ls_file_list[ li_i ] = llb_1.Text( li_i )
Next

lw_1.closeUserObject( llb_1 )
Close( lw_1 )

//get the filenames from the downloadlist
//ls_File = is_files2[3]  //is_current_path  + "\qrxs\download.lst"
ls_dllist_file = ls_path  + "\qrxs\download.lst"
li_FileNum = FileOpen( ls_dllist_file, LineMode!)

do until eof < 1
	eof = FileRead(li_FileNum, ls_read_string)
	if eof = -100 then exit
	ls_read_string = Lower(Trim(ls_read_string))
	ls_file_names[upperbound(ls_file_names) + 1] = ls_read_string
loop
	
FileClose(li_FileNum)


for i = 1 to upperbound(ls_file_names[])  //should only be one
	ls_File = ls_path  + "\qrxs\downloadconf\"  + ls_file_names[i]
	if not fileexists(ls_file) then
		ls_miss_files+=  ls_file_names[i] + " "
		is_err_mess[upperbound(is_err_mess) + 1 ] = "File in list was not downloaded (" + ls_file_names[i] + " )"
		of_create_qrxs_log( IS_CURRENT_FILE_NAME, il_upload_prac ,il_current_fac_id,"", "NFE", "NPDB File error:" + is_err_mess[upperbound(is_err_mess)] )
		of_post_send_qrxs(FAILURE)
		continue
	end if
	cnt++
	// Check the confirmation file
	lnv_Xml.of_CreateFromFile(ls_File)
	ls_Flag[1] = lnv_Xml.of_GetElementText("queryConfirmation\batchStatus\successfullyProcessed")
	ls_Flag[2] = lnv_Xml.of_GetElementText("queryConfirmation\subjectConfirmation\accepted")
	ls_docids[i] = lnv_Xml.of_GetElementText("queryConfirmation\subjectConfirmation\individual\customerUse")
	if IsNull(ls_Flag[1]) then ls_Flag[1] = ""
	if IsNull(ls_Flag[2]) then ls_Flag[2] = ""
	if Trim(Lower(ls_Flag[1])) = "false" or Trim(Lower(ls_Flag[2])) = "false" then
		ls_Text = lnv_Xml.of_GetElementText("queryConfirmation\batchStatus")
		lnv_Element.of_CreateFromString(ls_Text)
		lnv_Element.of_GetElementText("error", ls_Error[])
		for ll_i = 1 to UpperBound(ls_Error)
			lnv_Element.of_CreateFromString(ls_Error[ll_i])
			ls_Text = lnv_Element.of_GetElementText("message")
			is_err_mess[upperbound(is_err_mess) + 1 ] = ls_Text
			li_err_cnt ++
			is_error_info = ls_text //Start Code Change ----09.10.2012 #V12 maha
		next
		ls_Text = lnv_Xml.of_GetElementText("queryConfirmation\subjectConfirmation")
		lnv_Element.of_CreateFromString(ls_Text)
		lnv_Element.of_GetElementText("error", ls_Error[])
		for ll_i = 1 to UpperBound(ls_Error)
			lnv_Element.of_CreateFromString(ls_Error[ll_i])
			ls_Text = lnv_Element.of_GetElementText("message")
			IS_STATUS_CODE = lnv_Element.of_GetElementText("code")
			is_err_mess[upperbound(is_err_mess) + 1 ] = ls_Text
			li_err_cnt ++
			is_error_info = ls_text //Start Code Change ----09.10.2012 #V12 maha
		next
		//ls_Stat= "C99" // Custom error code
		//IS_STATUS_CODE = ls_Stat
		of_create_qrxs_log( IS_CURRENT_FILE_NAME, il_upload_prac ,il_current_fac_id,"", "CFE", "Confirmation file error: " + ls_text)
		of_post_send_qrxs(FAILURE)
		ib_process_failed = true
		ll_Return = FAILURE
		
	else
		IS_STATUS_CODE = "C00"
		of_post_send_qrxs(SUCCESS)
	end if
//	ls_DownLoadFileNew = is_directories2[5] +'\R-'+  ls_doc_id + '@' +  mid(ls_DownLoadFileOld, pos(ls_DownLoadFileOld, ".xml") - 7, 7)  +".xml"  //Start Code Change ----08.29.2012 #V12 maha - modified to preserve last 7 of download file name
	ls_org =  ls_file
	ls_new = "C-" + ls_docids[i] + "@" + ls_file_names[i]
	ls_new = is_current_path + "\qrxs\Processed\" + ls_new
	copyfilea(ls_org, ls_new, false)
	filedelete(ls_org)
next

	// Delete the confirmation file
	//before deleting copy the download file to the processed folder
ld_now = today()
lt_time = now()

	

//ls_path = ls_patha + "\qrxs\Processed"
ls_path = is_current_path + "\qrxs\Processed\"
ls_org =  ls_dllist_file
	debugbreak()
ls_new = "CONF-" + string(year(ld_now)) + string(month(ld_now)) + string(day(ld_now)) + string(hour(lt_time)) + string(minute(lt_time)) + string(second(lt_time))  + ".lst"

ls_new = ls_path + ls_new

r = copyfilea(ls_org, ls_new, false)

of_create_qrxs_download_log( ls_log, upperbound(ls_file_names) , cnt , ls_miss_files, "C")

//	FileDelete(ls_File)
//is_fac_id_status[upperbound(is_fac_id_status) + 1 ] = is_current_facility_id + "," + IS_STATUS_CODE
ids_lookup_code.SetFilter("")
ids_lookup_code.Filter()

// Update the tracker with the latest message
//for ll_i = 1 to ids_npdb_tracker_upd.rowcount()
//	ids_npdb_tracker_upd.object.cust_3[ll_i] = ls_search_string
//next


Return ll_Return
end function

public function integer of_create_qrxs_log (string as_doc, long al_prac, long al_facility, string as_file, string as_type, string as_note);//Start Code Change ----08.29.2012 #V12 maha - created for new qrxs log records

long nr
datetime ldt_now
integer i
long ll_id

nr = ids_qrxs_log.insertrow(0)

ldt_now = datetime( Today(),Now())

//select max(nql_id) into :ll_id from npdb_qrxs_log;
//
//ll_id++
//
//ids_qrxs_log.setitem(nr, "nql_id" ,ll_id )
ids_qrxs_log.setitem(nr, "doc_id" ,as_doc )
ids_qrxs_log.setitem(nr, "prac_id" ,al_prac )
ids_qrxs_log.setitem(nr, "facility_id" , al_facility)
ids_qrxs_log.setitem(nr, "user_id" , gs_user_id )
ids_qrxs_log.setitem(nr, "file_name" , as_file )
ids_qrxs_log.setitem(nr, "log_type" , as_type)
ids_qrxs_log.setitem(nr, "log_time",ldt_now )
ids_qrxs_log.setitem(nr, "status_note" , as_note)

//i = ids_qrxs_log.update( )
//messagebox("Update status of the qrxs log ds", i)

return 1
end function

public function integer of_post_send_qrxs (integer ai_success);//Start Code Change ----09.04.2012 #V12 maha - copied from of_post_send
//note: code changed in 12.2 to do one record at a time; reflected in this function
//called from of_check_status_send_qrxs
CONSTANT LONG   AWAITING_RESPONSE = 0
CONSTANT LONG   NEEDS_PROCESSING  = 1
CONSTANT LONG   MAX_LENGTH        = 6000 // THE MAX LENGTH OF THE NOTES FIELD
//long   ll_i
long i
string ls_doc_id[]
string ls_note
datetime ldt_now
boolean lb_failed
string ls_fullname
long ll_prac_id
ldt_now  = OF_GET_server_datetime( ) 

ls_doc_id[1] = is_current_file_name
ids_varification.retrieve(ls_doc_id)

// need to set the flag to 0 so that we do not  reprocess
ll_prac_id=ids_varification.object.prac_id[1]

if ai_success = 0 then 
	lb_failed = false
else
	lb_failed = True
end if
	
IF lb_failed = true then
	ls_note = " Send Error " + string(date(ldt_now)) + ": " + is_error_info
	ids_varification.object.print_flag[1] = NEEDS_PROCESSING
else
	ls_note = "Sent " + string(date(ldt_now))
	ids_varification.object.print_flag[1] = AWAITING_RESPONSE
	//update first sent
	IF isnull(ids_varification.object.first_sent[1]) THEN
		ids_varification.object.first_sent[1] = ldt_now
	END IF
	//update last sent
	ids_varification.object.last_sent[1] = ldt_now
	//update attempts
	if isnull(  ids_varification.object.number_sent[1]) then
		ids_varification.object.number_sent[1] = 1
	else
		ids_varification.object.number_sent[1] =  ids_varification.object.number_sent[1] + 1
	end if	
end if
		
// update the notes field	
IF isnull(ids_varification.object.notes[1]) then
	ids_varification.object.notes[1] = ls_NOTE
ELSE
	ids_varification.object.notes[1] = MidA(ids_varification.object.notes[1] +' , '+ ls_NOTE ,1 , MAX_LENGTH )
END IF


IF (gb_AutoSchedule or ib_schedule) And IsValid(w_auto_schedule) THEN //Added by Nova 01.26.2010 - v10.1 Scheduler Functionality
//getfullname
	select full_name into:ls_fullname from v_full_name where  prac_id=:ll_prac_id;
	w_auto_schedule.inv_scheduler.of_log_schedule_verif(ii_sched_id, ls_fullname, ids_varification.Object.screen_id[1], ids_varification.Object.reference_value[1], ids_varification.Object.doc_id[1],ls_note)
END IF

ids_varification.UPDATE()
ids_tracker_by_doc_id.update( )
i = ids_qrxs_log.update( )
//messagebox("Update status of the qrxs log ds", i)

return success
end function

public function integer of_set_tracker_qrsx (string as_doc_id);////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : n_cst_npdb::of_set_tracker_export_id
//==================================================================================================================
//  Purpose   	: Update the tracker export_id (PK)
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long] success/failure     
//==================================================================================================================
//  Notes     	: 	   called from of_send
//==================================================================================================================
//  Created By	: Michael Skinner  
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

long ll_max_id
long ll_i
long ll_found
long ll_current_row
long i //maha 050208
datetime ldt
string ls_array[]
long r
string ls_array2[]
string ls_docids[]
integer itest

ldt = OF_GET_server_datetime( )      // SUBMISSION DATE TIME
ls_docids[1] = as_doc_id
ll_found = ids_tracker_by_doc_id.retrieve(ls_docids[])

if ll_found = 1 then
	ids_tracker_by_doc_id.OBJECT.user_id[ll_found]     = gs_user_id 
	ids_tracker_by_doc_id.OBJECT.s_date[ll_found] = ldt
	ids_tracker_by_doc_id.OBJECT.file_name[ll_found]      = as_doc_id 	//Start Code Change ----05.05.2008 #V8 maha
		// set the proper satus for each file	
	ids_tracker_by_doc_id.OBJECT.cust_3[ll_found]      = IS_STATUS_CODE
else
	//---------Begin Modified by (Appeon)Harry 09.29.2016 - for  the issue of duplicate key---------
	//(Appeon)Stephen 10.26.2016 - Bug ID #5382 for Case # 00067243: Issue with NPDB Report
	/*
	select max(export_id) into :ll_max_id from npdb_tracker;
	if isnull(ll_max_id) then ll_max_id = 0
	ll_max_id++
	*/
	//ll_max_id = gnv_app.of_get_id("EXPORT") 
	ll_max_id = gnv_app.of_get_id("NPDB_TRACKER_ID")
	//---------End Modfiied ------------------------------------------------------
	ll_current_row = ids_tracker_by_doc_id.insertrow(0)
	lnv_string.of_ParseToArray ( as_doc_id, '-', ls_array )
	ids_tracker_by_doc_id.object.export_id[ll_current_row]   = ll_max_id
	ids_tracker_by_doc_id.OBJECT.user_id[ll_current_row]     = gs_user_id 
	ids_tracker_by_doc_id.OBJECT.file_name[ll_current_row]      = as_doc_id // THE DOC ID
	ids_tracker_by_doc_id.OBJECT.doc_id[ll_current_row]      = as_doc_id // THE DOC ID  //Start Code Change ----05.08.2008 #V8 maha - aded doc id as well as the file name which is the same value.
	ids_tracker_by_doc_id.OBJECT.PRAC_id[ll_current_row]     = long(ls_array[2])      // THE PRAC_ID
	ids_tracker_by_doc_id.OBJECT.facility_id[ll_current_row] = long(ls_array[3]) 
	ids_tracker_by_doc_id.OBJECT.s_date[ll_current_row]      = ldt
	ids_tracker_by_doc_id.OBJECT.cust_3[ll_current_row]      = IS_STATUS_CODE
 end if	 
		
r = ids_tracker_by_doc_id.update( )
if r < 1 then messagebox("", "Tracker creation failed.")


return success
end function

public function integer of_create_qrxs_download_log (string as_file, integer ai_count, integer ai_dowloaded, string as_missing, string as_type);datetime ldt_now

ldt_now = datetime(today(),now())

insert into npdb_qrxs_download_log ( file_id ,log_date,file_count, files_downloaded, failed_files,ptype, user_id )
values( :as_file, :ldt_now, :ai_count, :ai_dowloaded, :as_missing, :as_type, :gs_user_id);
//Start Code Change ----07.24.2013 #V14 maha - user_id

commit using sqlca;

return 1
end function

private function integer of_create_upidlist (string as_docid);////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : of_create_upidlist
//==================================================================================================================
//  Purpose   	: create the upidlist.fil
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael Skinner  Wednesday 13 October 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
////Start Code Change ----09.06.2012 #V12 maha - added argument for QRXS
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
integer cnt //maha 080408
long ll_i
string ls_text
string ls_file //maha 080408

if ids_pracs.rowcount() < 1 then return -1 //Start Code Change ----06.04.2008 #V81 maha

choose case il_Interface
	case ITP_INTERFACE
		//Start Code Change ----08.04.2008 #V85 maha - trap: only add to list if file has been created; if no files created return failure
		for ll_i = 1 to ids_pracs.rowcount()
			ls_file = is_directories[3] + '\' +  ids_pracs.object.doc_id[ll_i] + '.lst' 
			if  fileexists(ls_file) then
				ls_text =  ls_text  + ls_file + NEW_LINE
				cnt++
			end if
		next		
		if LenA(ls_text) > 1 then
			of_create_file( is_directories[1] + '\upidlist.fil', ls_text)
		else
			return failure
		end if
		//End Code Change---08.04.2008
	case QRXS_INTERFACE //Add by Evan 11.25.2009 (V10.1 - NPDB QRXS)
		//Start Code Change ----09.06.2012 #V12 maha - with 12.2 modification the file is created for each pract record.
//		for ll_i = 1 to ids_pracs.RowCount()
//			ls_File = is_directories2[3] + "\" +  ids_pracs.object.doc_id[ll_i] + ".xml"
//			if FileExists(ls_File) then
//				ls_Text = ls_Text + ls_File + NEW_LINE
//				cnt ++
//			end if
//		next
		ls_text = is_directories2[3] + "\" +  as_docid + ".xml"
		//End Code Change ----09.06.2012 #V12 maha
		if LenA(ls_Text) > 0 then
			of_create_file(is_files2[2], ls_Text)
		else
			Return FAILURE
		end if
	case else
		Return FAILURE
end choose

Return SUCCESS
end function

private function integer of_create_qrxs_prop (string as_process);//////////////////////////////////////////////////////////////////////
// $<function> of_create_qrxs_prop
// $<arguments>
// $<returns> integer
// $<description> Create the qrxs.properties file (V10.1 - NPDB QRXS)
//////////////////////////////////////////////////////////////////////
// $<add> Evan 11.23.2009
//////////////////////////////////////////////////////////////////////

integer i
string ls_dbid
string ls_file_text_array[]
string ls_file_text
string ls_ini_val
string ls_agent
long ll_facil

// When this is called from of_recieve, the facility info will not have been retrieved, so
// as long as the qrxs.properties exists then use the existing one.
//Start Code Change ----09.10.2012 #V12 maha:
//removed because it is inappropriate to not create the properties file
//if ids_npdb_fac_info.rowcount() < 1 then
//	if not fileexists(is_files2[1]) then
//		return failure
//	else
//		return success
//	end if
//end if

debugbreak()
// Sets the user and password
of_get_user_password()


// If agent filled in use agent; otherwise use entity
//Start Code Change ----09.10.2012 #V12 maha: get facility info if one exists
if ids_npdb_fac_info.rowcount() > 0 then
	if not IsNull(ids_npdb_fac_info.object.npdb_agent_dbid[1]) then
		ls_dbid = String(ids_npdb_fac_info.object.npdb_agent_dbid[1])
	else
		ls_dbid = String(ids_npdb_fac_info.object.npdb_entity_dbid[1])
	end if
else
	ll_facil = long(is_current_facility_id)
	select npdb_agent_dbid, npdb_agent_dbid into :ls_dbid, :ls_agent from facility where facility_id = :ll_facil;
	if isnull(ls_agent) or ls_agent = '' then
		//leave as entity id
	else
		ls_dbid = ls_agent
	end if
end if
if IsNull(ls_dbid) then ls_dbid = ""
//End Code Change ----09.10.2012

// Gets the QRXS information
ls_file_text_array[upperbound(ls_file_text_array) + 1] = "DBID=" + ls_dbid + NEW_LINE
ls_file_text_array[upperbound(ls_file_text_array) + 1] = "UserID=" + is_npdb_user_id + New_line
if gi_test_mode = 1 then
	ls_file_text_array[upperbound(ls_file_text_array) + 1] = "Password=bSTIrO3yVunS8272zwvjPb6fIpM\=" + NEW_LINE
else
	ls_file_text_array[upperbound(ls_file_text_array) + 1] = "Password=" + NEW_LINE  // leave blank filled in during the encode process
end if
ls_file_text_array[upperbound(ls_file_text_array) + 1] = "UploadListFile=upload.lst" + NEW_LINE

if as_process = "SEND" then //Start Code Change ----08.29.2012 #V12 maha - modify to use separate download folder for confirmations
	ls_file_text_array[upperbound(ls_file_text_array) + 1] = "DownloadDir=downloadconf" + NEW_LINE
else
	ls_file_text_array[upperbound(ls_file_text_array) + 1] = "DownloadDir=download" + NEW_LINE
end if

ls_file_text_array[upperbound(ls_file_text_array) + 1] = "DownloadListFile=download.lst" + NEW_LINE

//---------Begin Added by (Appeon)Stephen 12.27.2014 for NPDB QRXS using proxy --------
string ls_ProxyHostName, ls_ProxyPort, ls_ProxyUser, ls_ProxyPassword, ls_ProxyDomain
Select npdb_proxyhostname, npdb_proxyport, npdb_proxyuser, npdb_proxypassword, npdb_proxydomain
    Into :ls_ProxyHostName, :ls_ProxyPort, :ls_ProxyUser, :ls_ProxyPassword, :ls_ProxyDomain
    From security_users
  Where user_id = :gs_user_id;
if not(isnull(ls_ProxyHostName) or trim(ls_ProxyHostName) = '' or isnull(ls_ProxyPort) or trim(ls_ProxyPort) = '') then
	ls_file_text_array[upperbound(ls_file_text_array) + 1] = "ProxyHostName=" + ls_ProxyHostName + NEW_LINE
	ls_file_text_array[upperbound(ls_file_text_array) + 1] = "ProxyPort=" + ls_ProxyPort + NEW_LINE
	
	if not(isnull(ls_ProxyUser) or ls_ProxyUser = "") then
		ls_file_text_array[upperbound(ls_file_text_array) + 1] = "ProxyUser=" + ls_ProxyUser + NEW_LINE
	end if
	if not(isnull(ls_ProxyPassword) or ls_ProxyPassword = "") then
		ls_file_text_array[upperbound(ls_file_text_array) + 1] = "ProxyPassword=" + ls_ProxyPassword + NEW_LINE
	end if
	if not(isnull(ls_ProxyDomain) or ls_ProxyDomain = "") then
		ls_file_text_array[upperbound(ls_file_text_array) + 1] = "ProxyDomain=" + ls_ProxyDomain + NEW_LINE
	end if
else
//---------End Added ------------------------------------------------------
	ls_ini_val = ProfileString(gs_dir_path + "intellicred\intellicred.ini", "npdb", "ProxyHostName", "None")
	if ls_ini_val <> "None" then
		ls_file_text_array[upperbound(ls_file_text_array) + 1] = "ProxyHostName=" + ls_ini_val + NEW_LINE
	end if
	ls_ini_val = ProfileString(gs_dir_path + "intellicred\intellicred.ini", "npdb", "ProxyPort", "None")
	if ls_ini_val <> "None" then
		ls_file_text_array[upperbound(ls_file_text_array) + 1] = "ProxyPort=" + ls_ini_val + NEW_LINE
	end if
	ls_ini_val = ProfileString(gs_dir_path + "intellicred\intellicred.ini", "npdb", "ProxyUser", "None")
	if ls_ini_val <> "None" then
		ls_file_text_array[upperbound(ls_file_text_array) + 1] = "ProxyUser=" + ls_ini_val + NEW_LINE
	end if
	ls_ini_val = ProfileString(gs_dir_path + "intellicred\intellicred.ini", "npdb", "ProxyPassword", "None")
	if ls_ini_val <> "None" then
		ls_file_text_array[upperbound(ls_file_text_array) + 1] = "ProxyPassword=" + ls_ini_val + NEW_LINE
	end if
	ls_ini_val = ProfileString(gs_dir_path + "intellicred\intellicred.ini", "npdb", "ProxyDomain", "None")
	if ls_ini_val <> "None" then
		ls_file_text_array[upperbound(ls_file_text_array) + 1] = "ProxyDomain=" + ls_ini_val + NEW_LINE
	end if
end if

if gi_test_mode = 1 then
	ls_file_text_array[upperbound(ls_file_text_array) + 1] = "InputURL=https\://qa.npdb-hipdb.hrsa.gov/qrxs/servlet/XMLInputServlet" + NEW_LINE
	ls_file_text_array[upperbound(ls_file_text_array) + 1] = "OutputURL=https\://qa.npdb-hipdb.hrsa.gov/qrxs/servlet/XMLOutputServlet" + NEW_LINE
	ls_file_text_array[upperbound(ls_file_text_array) + 1] = "VerificationURL=https\://qa.npdb-hipdb.hrsa.gov/qrxs/servlet/XMLResponseVerificationServlet" + NEW_LINE
end if

//---------Begin Added by (Appeon)Stephen 09.23.2015 for NPDB query not Sending--------
string ls_line

If AppeonGetClientType() = 'PB' then
	ls_line = ""
else
	ls_line = "~r~n"
end if
//---------End Added ------------------------------------------------------

// Create the file text
for i = 1 to UpperBound(ls_file_text_array)
	//---------Begin Modified by (Appeon)Stephen 09.23.2015 for NPDB query not Sending--------
	//ls_file_text += ls_file_text_array[i]
	ls_file_text += ls_file_text_array[i] + ls_line
	//---------End Modfiied ------------------------------------------------------
next

Return of_create_file(is_files2[1], ls_file_text)
end function

public subroutine of_insert_codes3 ();//////////////////////////////////////////////////////////////////////
// $<Function> of_insert_codes3
// $<arguments> N/A
// $<returns> NONE
// $<description>add code list  (v12.2 modify NPDB qrxs report)
//////////////////////////////////////////////////////////////////////
// $<add> 09.10.2012 by Stephen
//////////////////////////////////////////////////////////////////////

//Type of Report
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_con','I','Initial');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_con','C','Correction');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_con','V','Void');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_con','R',' Revision to Action');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_con','O',' Correction of Revision to Action');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_con','A',' Notice of Appeal');"

//Type of Organization
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_jo_org','361','Chiropractic Group/Practice');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_jo_org','362','Dental Group/Practice');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_jo_org','365','Medical Group/Practice');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_jo_org','366','Mental Health/Substance Abuse Group/Practice');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_jo_org','363','Optician/Optometric Group/Practice');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_jo_org','367','Physical/Occupational Therapy Group/Practice');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_jo_org','364','Podiatric Group/Practice');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_jo_org','393','Home Health Agency/Organization');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_jo_org','382','Hospice/Hospice Care Provider');"

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_jo_org','304','Federal Hospital');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_jo_org','301','General/Acute Care Hospital');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_jo_org','302','Psychiatric Hospital');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_jo_org','303','Rehabilitation Hospital');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_jo_org','307','Psychiatric Unit');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_jo_org','308','Rehabilitation Unit');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_jo_org','310','Laboratory/CLIA Laboratory');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_jo_org','389','Nursing Facility/Skilled Nursing Facility');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_jo_org','370','Research Center/Facility');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_jo_org','390','Ambulance Service/Transportation Company');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_jo_org','320','Health Insurance Company/Provider');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_jo_org','381','Adult Day Care Facility');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_jo_org','392','Ambulatory Clinic/Center');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_jo_org','391','Ambulatory Surgical Center');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_jo_org','398','End Stage Renal Disease Facility');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_jo_org','394','Health Center/Federally Qualified Health Center/Community Health Center');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_jo_org','383','Intermediate Care Facility for Mentally Retarded/Substance Abuse');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_jo_org','397','Mammography Service Provider');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_jo_org','395','Mental Health Center/Community Mental Health Center');"

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_jo_org','388','Outpatient Rehabilitation Facility/ Comprehensive Outpatient Rehabilitation Facility');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_jo_org','399','Radiology/Imaging Center');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_jo_org','386','Residential Treatment Facility/ Program');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_jo_org','396','Rural Health Clinic');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_jo_org','331','Health Maintenance Organization');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_jo_org','335','Preferred Provider Organization');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_jo_org','336','Provider Sponsored Organization');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_jo_org','338','Religious, Fraternal Benefit Society Plan');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_jo_org','347','Biological Products Manufacturer1');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_jo_org','342','Blood Bank');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_jo_org','343','Durable Medical Equipment Supplier1');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_jo_org','344','Eyewear Equipment Supplier1');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_jo_org','351','Fiscal/Billing/Management Agent1');"

ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_jo_org','353','Nursing/Health Care Staffing Service1');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_jo_org','348','Organ Procurement Organization1');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_jo_org','345','Pharmacy');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_jo_org','346','Pharmaceutical Manufacturer1');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_jo_org','349','Portable X-Ray Supplier1');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_jo_org','352','Purchasing Service1');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_jo_org','999','Other Type - Not Classified, Specify,');"

//AAR Type of Action Codes
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_aar_act','SL','State Licensure');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_aar_act','FL','Federal Licensure');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_aar_act','CP','Includes Panel Membership');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_aar_act','HP','Health Plan');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_aar_act','ED','Exclusion or Debarment');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_aar_act','PS','Professional Society');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_aar_act','PR','Peer Review Organization');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_aar_act','AC','Accreditation');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_aar_act','GA','Government Administrative');"

//add error_codes list
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','01','Format of information in subject record(s) was in error.');"
ls_sql_statments[upperbound(ls_sql_statments) + 1] = "insert into npdb_code_lookup values ('list_q','03','File is not compliant with the current format version.');"










end subroutine

public function integer of_get_qrxs_report_contact (n_cst_xml_parser anv_xml, datastore ads_report);//////////////////////////////////////////////////////////////////////
// $<function> of_get_qrxs_report_contact
// $<arguments>
//				 n_cst_xml_parser 	anv_xml
//			      ref datastore			ads_report
// $<returns> integer
// $<description> Parse XML file data into report tables
//                  v12.2 modify NPDB qrxs report
//////////////////////////////////////////////////////////////////////
// $<add> 09.10.2012 by Stephen
//////////////////////////////////////////////////////////////////////

long   ll_InsertRow
string ls_Xml
string ls_ElementText[]
n_cst_xml_parser lnv_Xml

ls_Xml = anv_Xml.of_GetElementText("contact")
lnv_Xml.of_CreateFromString(ls_Xml)

ll_InsertRow = ads_Report.InsertRow(0)
ads_Report.Setitem(ll_InsertRow, "report_id", ii_report_id) //modify by stephen 11.05.2012  ll_InsertRow to ii_report_id --npdb test error

//get ..report/contact data
ls_ElementText[1] = lnv_Xml.of_GetElementText("entityName")
ls_ElementText[2] = lnv_Xml.of_GetElementText("officeOrName")
ls_ElementText[3] = lnv_Xml.of_GetElementText("titleOrDept")
ls_ElementText[4] = lnv_Xml.of_GetElementText("entityReference")
ads_Report.Setitem(ll_InsertRow, "entity_name", ls_ElementText[1])
ads_Report.Setitem(ll_InsertRow, "office_name", ls_ElementText[2])
ads_Report.Setitem(ll_InsertRow, "dept_title", ls_ElementText[3])
ads_Report.Setitem(ll_InsertRow, "entity_ref", ls_ElementText[4])

ls_ElementText[5] = lnv_Xml.of_GetElementText("phone\number")
ls_ElementText[6] = lnv_Xml.of_GetElementText("phone\extension")
ls_ElementText[7] = lnv_Xml.of_GetElementText("address\address")
ls_ElementText[8] = lnv_Xml.of_GetElementText("address\city")
ls_ElementText[9] = lnv_Xml.of_GetElementText("address\state")
ls_ElementText[10] = lnv_Xml.of_GetElementText("address\zip")
ls_ElementText[11] = lnv_Xml.of_GetElementText("address\country")
ads_Report.Setitem(ll_InsertRow, "phone_number", ls_ElementText[5])
ads_Report.Setitem(ll_InsertRow, "phone_extension", ls_ElementText[6])
ads_Report.Setitem(ll_InsertRow, "con_address", ls_ElementText[7])
ads_Report.Setitem(ll_InsertRow, "con_city", ls_ElementText[8])
ads_Report.Setitem(ll_InsertRow, "con_state", ls_ElementText[9])
ads_Report.Setitem(ll_InsertRow, "con_zip", ls_ElementText[10])
ads_Report.Setitem(ll_InsertRow, "con_country", ls_ElementText[11])

//get ..report/statement
ls_Xml = anv_Xml.of_GetElementText("Statement")
lnv_Xml.of_CreateFromString(ls_Xml)
ls_ElementText[12] = lnv_Xml.of_GetElementText("subjectStatement\submitDate")
ls_ElementText[13] = lnv_Xml.of_GetElementText("subjectStatement\statementThisVersion")
ls_ElementText[14] = lnv_Xml.of_GetElementText("subjectStatement\statement")
ls_ElementText[15] = lnv_Xml.of_GetElementText("secretaryStatement\submitDate")
ls_ElementText[16] = lnv_Xml.of_GetElementText("secretaryStatement\statementThisVersion")
ls_ElementText[17] = lnv_Xml.of_GetElementText("secretaryStatement\statement")
ls_ElementText[18] = lnv_Xml.of_GetElementText("disputeStatus")
ads_Report.Setitem(ll_InsertRow, "submit_date", ls_ElementText[12])
ads_Report.Setitem(ll_InsertRow, "statement_version", ls_ElementText[13])
ads_Report.Setitem(ll_InsertRow, "subject_statement", ls_ElementText[14])
ads_Report.Setitem(ll_InsertRow, "secretary_submit_date", ls_ElementText[15])
ads_Report.Setitem(ll_InsertRow, "secretary_version", ls_ElementText[16])
ads_Report.Setitem(ll_InsertRow, "secretary_statement", ls_ElementText[17])
ads_Report.Setitem(ll_InsertRow, "dispute_Status", ls_ElementText[18])

//get ..report/reportData
ls_Xml = anv_Xml.of_GetElementText("reportData")
lnv_Xml.of_CreateFromString(ls_Xml)
ls_ElementText[19] = lnv_Xml.of_GetElementText("transaction")
ls_ElementText[20] = lnv_Xml.of_GetElementText("originalSubmitDate")
ls_ElementText[21] = lnv_Xml.of_GetElementText("recentChangeDate")
ads_Report.Setitem(ll_InsertRow, "report_type", ls_ElementText[19])
ads_Report.Setitem(ll_InsertRow, "orig_submitdate", ls_ElementText[20])
ads_Report.Setitem(ll_InsertRow, "rec_changedate", ls_ElementText[21])

//..maintainedUnder
ls_Xml = anv_Xml.of_GetElementText("reportData\maintainedUnder")
lnv_Xml.of_CreateFromString(ls_Xml)
lnv_Xml.of_GetElementText("statute", ls_ElementText[])
of_Setitem(ads_Report, ll_InsertRow, "report_provision", "statute", ls_ElementText[])


Return SUCCESS
end function

public function integer of_get_qrxs_report_reload (string as_filename[]);//////////////////////////////////////////////////////////////////////
// $<function> of_get_qrxs_report_reload
// $<arguments>
// $<returns> integer
// $<description> reload  XML file content into report tables
//                (V12.2 - NPDB QRXS)
//////////////////////////////////////////////////////////////////////
// $<add> Stephen 11.08.2012
//////////////////////////////////////////////////////////////////////


long   ll_Row
long   ll_npdb_hdr_id
long   ll_ReportCount
long   i, j, ll_FileCount, f
long eof = 1
integer chk = 0
long li_FileNum  //maha 09.06.2012
string ls_doc_id
string ls_UplodFile
string ls_DownLoadFileOld
string ls_DownLoadFileNew
string ls_bakfile
string ls_ElementText
string ls_ElementTextArray[]
string ls_file_names[] //maha 09.06.2012
string ls_dllist_file //maha 09.06.2012
string ls_read_string //maha 09.06.2012
string ls_dlf_name  //maha 09.06.2012
string ls_file_error  //maha 09.06.2012
string ls_temp   //maha 09.06.2012
string ls_array[]   //maha 09.06.2012
integer li_pos
long  ll_hdr_id

n_cst_xml_parser lnv_Xml
DataStore lds_Report[]


// get downloaded file names
ls_file_names = as_filename

if upperbound(ls_file_names) = 0 then return -1

ids_varification = create n_ds
ids_varification.dataobject = 'd_npdb_varification_info'
ids_varification.settransobject( sqlca)

ids_tracker_by_doc_id = CREATE n_ds
ids_tracker_by_doc_id.dataobject = 'd_npdb_tracker_by_doc_id'
ids_tracker_by_doc_id.settransobject( sqlca)

ids_lookup_code = create N_ds
ids_lookup_code.dataobject = 'd_npdb_lookup_code'
ids_lookup_code.settransobject(sqlca)
ids_lookup_code.retrieve()

// Create report datastores
ll_ReportCount = 10
for i = 1 to ll_ReportCount
	lds_Report[i] = Create DataStore
next
lds_Report[1].DataObject = "d_npdb_qrxs_hdr"
lds_Report[2].DataObject = "d_npdb_qrxs_status"
lds_Report[3].DataObject = "d_npdb_qrxs_individual"
lds_Report[4].DataObject = "d_npdb_qrxs_aar"
lds_Report[5].DataObject = "d_npdb_qrxs_jocr"
lds_Report[6].DataObject = "d_npdb_qrxs_mmpr"
lds_Report[7].DataObject = "d_npdb_qrxs_laar"
lds_Report[8].DataObject = "d_npdb_qrxs_lmmpr"
lds_Report[9].DataObject = "d_npdb_qrxs_contact"  //add by stephen 09.12.2012 -- v12.2 modify NPDB qrxs report
lds_Report[10].DataObject = "d_npdb_qrxs_individual_total"  //add by stephen 11.06.2012 --save querySubjectResponse->individual

for i = 1 to ll_ReportCount
	lds_Report[i].SetTransObject(SQLCA)
next

// Get max npdb_hdr_id
SELECT max(npdb_hdr_id) INTO :ll_npdb_hdr_id FROM npdb_qrxs_hdr;
if IsNull(ll_npdb_hdr_id) then ll_npdb_hdr_id = 0
ll_npdb_hdr_id ++

//@@@@@@@@@@@@@
// Parse XML files process
//for i = 1 to ll_FileCount

is_internet_inuse = 'N'
of_open_progress_window( )
	
for i = 1 to upperbound(ls_file_names) 
    ls_DownLoadFileOld = ls_file_names[i]
	lnv_Xml.of_CreateFromFile(ls_DownLoadFileOld)
		
	// Check Doc ID if exists
	ls_ElementText = lnv_Xml.of_GetElementText("queryResponse\querySubjectResponse\individual\customerUse")
	if IsNull(ls_ElementText) or ls_ElementText = "" then
		ls_ElementText = lnv_Xml.of_GetElementText("pdsResponse\pdsSubjectResponse\individual\customerUse")
		if IsNull(ls_ElementText) or ls_ElementText = "" then
			Continue
		end if
	end if
	ls_doc_id = ls_ElementText	
	
	select npdb_hdr_id into :ll_hdr_id from npdb_qrxs_hdr where doc_id =:ls_doc_id;
	if ll_hdr_id > 0 and (not isnull(ll_hdr_id)) then
		if of_delete_npdb_data(ll_hdr_id) <> 1 then return -1
	end if
	
	// Parse data into each report datastore
	// [$queryResponse\] hdr
	ls_ElementText = lnv_Xml.of_GetElementText("queryResponse")
	if IsNull(ls_ElementText) or ls_ElementText = "" then
		ls_ElementText = lnv_Xml.of_GetElementText("pdsResponse")
	end if
	lnv_Xml.of_CreateFromString(ls_ElementText)
	of_get_qrxs_report_hdr(lnv_Xml, lds_Report[1], ls_doc_id)
	
	// [$queryResponse\querySubjectResponse\] status, individual
	ls_ElementText = lnv_Xml.of_GetElementText("querySubjectResponse")
	if IsNull(ls_ElementText) or ls_ElementText = "" then
		ls_ElementText = lnv_Xml.of_GetElementText("pdsSubjectResponse")
	end if
	lnv_Xml.of_CreateFromString(ls_ElementText)
	of_get_qrxs_report_status(lnv_Xml, lds_Report[2])
	of_get_qrxs_report_individual(lnv_Xml, lds_Report[10])  //add by stephen 11.06.2012 --save querySubjectResponse->individual
	
	// [$queryResponse\querySubjectResponse\report\] aar, jocr, mmpr, laar, lmmpr
	lnv_Xml.of_GetElementText("report", ls_ElementTextArray[])
	
	ii_report_id = 1
	for j = 1 to UpperBound(ls_ElementTextArray)
		lnv_Xml.of_CreateFromString(ls_ElementTextArray[j])
		of_get_qrxs_report_aar(lnv_Xml, lds_Report[4])
		of_get_qrxs_report_jocr(lnv_Xml, lds_Report[5])
		of_get_qrxs_report_mmpr(lnv_Xml, lds_Report[6])
		of_get_qrxs_report_laar(lnv_Xml, lds_Report[7])
		of_get_qrxs_report_lmmpr(lnv_Xml, lds_Report[8])
		of_get_qrxs_report_contact(lnv_Xml, lds_Report[9])  //move by stephen 10.15.2012 --add by stephen 09.12.2012 -- v12.2 modify NPDB qrxs report
		of_get_qrxs_report_individual(lnv_Xml, lds_Report[3]) //move by stephen 11.06.2012 --use querySubjectResponse->report->individual
		ii_report_id = ii_report_id +1 //add by stephen 11.05.2012 --NPDB test error
	next
	if lds_Report[2].RowCount() > 0 then
		lds_Report[2].SetItem(1, "report_count", String(UpperBound(ls_ElementTextArray)))
	end if

	// Set npdb_hdr_id and update datastores
	gnv_appeondb.of_StartQueue()
	for j = 1 to ll_ReportCount
		for ll_Row = 1 to lds_Report[j].RowCount()
			lds_Report[j].SetItem(ll_Row, "npdb_hdr_id", ll_npdb_hdr_id)
		next
		lds_Report[j].Update()
	next
	gnv_appeondb.of_CommitQueue()
	ll_npdb_hdr_id ++
	
	// Update verification record (lds_Report[1] is hdr; lds_Report[1] is status)
	of_set_post_import_status_qrxs(lds_Report[1], lds_Report[2])
	for j = 1 to ll_ReportCount
		lds_Report[j].Reset()
	next
	
next

//download log // maha 09.06.2012
of_create_qrxs_download_log( ls_dlf_name, upperbound(ls_file_names) , ll_FileCount,  ls_file_error , "R") 

// Destroy report datastores
for j = 1 to ll_ReportCount
	Destroy lds_Report[j]
next
destroy ids_varification
destroy ids_tracker_by_doc_id
destroy ids_lookup_code

IF isvalid(w_infodisp) then close(w_infodisp)
Return 1
end function

public function integer of_get_qrxs_report_util_call ();//Start Code Change ----10.22.2013 #V14 maha - called from w_npdb_qrxs_file_util
of_get_qrxs_report( )

return 1
end function

public function integer of_initial_qrxs ();//Start Code Change ----10.22.2013 #V14 maha - called from w_npdb_qrxs_file_util
is_current_path = gs_dir_path + 'intellicred'

is_qrxs_path = is_current_path + '\qrxs'
is_directories2[1] = is_current_path + "\qrxs"
is_directories2[2] = is_current_path + "\qrxs\Download"
is_directories2[3] = is_current_path + "\qrxs\Upload"
is_directories2[4] = is_current_path + "\qrxs\Temp"
is_directories2[5] = is_current_path + "\qrxs\Processed"
is_directories2[6] = is_current_path + "\qrxs\Downloadconf"   //Start Code Change ----09.05.2012 #V12 maha - added

return 1

end function

public function integer of_test_password (string as_pw);//Start Code Change ----11.19.2014 #V14.2 maha - added to test for characters known to cause issues.
string ls_pw
string c, ct
string ls_mes
integer r
integer p
integer res = 1

ls_pw = as_pw

for r = 1 to 5
	choose case r
		case 1
			c = "&"
		case 2
			c = ">"
		case 3
			c = "<"
		case 4
			c = "|"
		case 5
			c = "$"
	end choose
	if pos(ls_pw,c,1) > 0 then ct = ct + c + ","
next

if len(ct) > 0 then
	ct = mid(ct, 1, len(ct) - 1)
	ls_mes = "The NPDB's QRXS functionality is know to have issues with some special characters in the password.~rYour password includes:~r" + ct + "~r~rThis may cause errors:~r     Failed to Encode Password.~r     Error on the NPDB HIPDB server, reattempt transfer."
	ls_mes+= "~r~rYou may want to consider changing your password."
	Messagebox("Npdb Password test", ls_mes)
	res = -1
end if

return res
end function

on n_cst_npdb.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_npdb.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : 
//==================================================================================================================
//  Purpose   	: constructor
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]   (not used)  
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael Skinner  
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//of_initialize( )

il_Interface = of_get_app_setting("set_8","I") //Add by Evan 11.18.2009 (V10.1 - NPDB QRXS)
end event

event destructor;string ls_string

IF isvalid(w_infodisp) THEN close(w_infodisp)

//------------ APPEON BEGIN ------------
//$<Add> 12.30.2009 By: Evan
//$<Reason> Needs to destroy objects here
if IsValid(inv_filesrv) then Destroy inv_filesrv
if IsValid(ids_pracs) then Destroy ids_pracs
if IsValid(ids_npdb_fac_info) then Destroy ids_npdb_fac_info
if IsValid(ids_pracs_info) then Destroy ids_pracs_info
if IsValid(ids_dw_datatore) then Destroy ids_dw_datatore
if IsValid(ids_error) then Destroy ids_error
if IsValid(ids_lookup_code) then Destroy ids_lookup_code
if IsValid(ids_npdb_tracker_upd) then Destroy ids_npdb_tracker_upd
if IsValid(ids_varification) then Destroy ids_varification
if IsValid(ids_tracker_by_doc_id) then Destroy ids_tracker_by_doc_id
if IsValid(ids_cc_information) then Destroy ids_cc_information
if IsValid(lds_address_info) then Destroy lds_address_info
//------------ APPEON END --------------
end event

