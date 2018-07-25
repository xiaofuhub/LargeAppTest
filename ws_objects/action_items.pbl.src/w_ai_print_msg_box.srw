$PBExportHeader$w_ai_print_msg_box.srw
forward
global type w_ai_print_msg_box from w_response
end type
type st_export_msg from statictext within w_ai_print_msg_box
end type
type cb_view from commandbutton within w_ai_print_msg_box
end type
type rb_fax from radiobutton within w_ai_print_msg_box
end type
type rb_email from radiobutton within w_ai_print_msg_box
end type
type rb_print from radiobutton within w_ai_print_msg_box
end type
type ole_print from olecustomcontrol within w_ai_print_msg_box
end type
type ole_admin from olecustomcontrol within w_ai_print_msg_box
end type
type st_msg from statictext within w_ai_print_msg_box
end type
type cb_yes from commandbutton within w_ai_print_msg_box
end type
type cbx_mail from checkbox within w_ai_print_msg_box
end type
type cbx_priv from checkbox within w_ai_print_msg_box
end type
type cbx_release from checkbox within w_ai_print_msg_box
end type
type cb_print from commandbutton within w_ai_print_msg_box
end type
type cb_continuefax from commandbutton within w_ai_print_msg_box
end type
type cb_cancelfax from commandbutton within w_ai_print_msg_box
end type
type st_text from statictext within w_ai_print_msg_box
end type
type uo_print_app from pfc_cst_u_create_app2 within w_ai_print_msg_box
end type
type dw_errors from datawindow within w_ai_print_msg_box
end type
type st_error_cnt from statictext within w_ai_print_msg_box
end type
type cb_fax from commandbutton within w_ai_print_msg_box
end type
type cb_1 from commandbutton within w_ai_print_msg_box
end type
type cb_no from commandbutton within w_ai_print_msg_box
end type
type cb_email from commandbutton within w_ai_print_msg_box
end type
type gb_1 from groupbox within w_ai_print_msg_box
end type
type gb_2 from groupbox within w_ai_print_msg_box
end type
end forward

global type w_ai_print_msg_box from w_response
integer x = 110
integer y = 208
integer width = 2565
integer height = 904
string title = "Process Documents"
boolean controlmenu = false
long backcolor = 33551856
event ue_setfocus ( )
event ue_post_closewithreturn ( gs_fax_error_records ags_fax_error_records )
st_export_msg st_export_msg
cb_view cb_view
rb_fax rb_fax
rb_email rb_email
rb_print rb_print
ole_print ole_print
ole_admin ole_admin
st_msg st_msg
cb_yes cb_yes
cbx_mail cbx_mail
cbx_priv cbx_priv
cbx_release cbx_release
cb_print cb_print
cb_continuefax cb_continuefax
cb_cancelfax cb_cancelfax
st_text st_text
uo_print_app uo_print_app
dw_errors dw_errors
st_error_cnt st_error_cnt
cb_fax cb_fax
cb_1 cb_1
cb_no cb_no
cb_email cb_email
gb_1 gb_1
gb_2 gb_2
end type
global w_ai_print_msg_box w_ai_print_msg_box

type prototypes
FUNCTION ulong FindWindowA(ulong classname,string windowname) LIBRARY "User32.dll" alias for "FindWindowA;Ansi"
end prototypes

type variables
Boolean ib_no_faxing  = False
Boolean ib_faxing_doc = True
boolean ib_skip
boolean ib_fax_docs_created
boolean ib_export_used  //maha 05.06.2015
String is_mail_label_doc
String is_letter_name
String is_msg
String is_cover_page
String is_cover_message
String is_subject 
String is_letter_type
string is_old_docpath  //stephen 02.18.2014
string is_document   //Start Code Change ---- 10.25.2007 #V7 maha
String is_merge_file_path //Added By Ken.Guo 03.25.2008
Integer li_click_times = 0
Integer li_timeout = 0
Integer il_error_rec_num []
long il_image_pk //maha 03.30.2011
n_cst_filesrvwin32 inv_filesrv
n_ds ids_letter
n_cst_dirattrib lnv_dirlist[]

String is_ext //Added by (APPEON) Harry 11.15.2017 (V161 Storage of Documents as PDFs)






end variables

forward prototypes
public function integer of_fax (boolean ab_error_checking)
public function integer of_print_image_document (string as_print_to)
public function integer of_email (boolean ab_error_checking)
public function long of_get_documents (ref string as_docs[], string as_search)
public function integer of_fax_email (boolean ab_error_checking, string as_type)
public function integer of_is_word_open ()
public function long of_find_image_id (integer ai_type, long al_prac, long al_fac)
public function integer of_retrieve_image_from_db (integer ai_activestatus, integer ai_imagetypeid, long al_pracid, long al_facid)
public subroutine of_set_process (string as_type)
public subroutine of_emaillog (string as_subject, string as_attachments[], long al_email_id, long al_prac_id)
public function integer of_check_rec_counts (string as_type)
end prototypes

event ue_post_closewithreturn(gs_fax_error_records ags_fax_error_records);//////////////////////////////////////////////////////////////////////
// $<event>w_response.ue_post_closewithreturn()
// $<arguments>
//		value	gs_fax_error_records	ags_fax_error_records		
// $<returns> 
// $<description> Maybe PB Bug,So create this event to post close this window.
//////////////////////////////////////////////////////////////////////
// $<add> 11/02/2007 by Ken.Guo
//////////////////////////////////////////////////////////////////////
CloseWithReturn(This,ags_fax_error_records)
end event

public function integer of_fax (boolean ab_error_checking);return 0
//////Jervis 12-10-2008
////This function is obsolete.  DO NOT USE THIS FUNCTION
//
//
//Boolean lb_error_rec
//String ls_facility_name
//String ls_full_name
//string ls_attachments[]
//String ls_recipient
//String ls_company
//String ls_fax
//String ls_lookup_entity_name
////String ls_cover_page
////String ls_cover_message
////String ls_subject
//String ls_no_fax
//Integer li_attach_cnt
//Integer e
//Integer li_nr
//Integer li_error
//Integer li_error_cnt
//Long li_rc
//Long i
//Long f
//Long ChanNum
//gs_pass_ids  lg_pass_ids
//gs_fax_error_records lst_fax_error_records
//
//ChanNum = OpenChannel("FAXMNG32", "CONTROL")
//IF ChanNum < 0 THEN
//	MessageBox("Error", "Winfax is not installed or needs to be configured." )
//	Return -1
//END IF
//
//ib_faxing_doc = True
//
////IF all letter records were missing fax numbers then return with -2 or Cancel
//IF UpperBound( il_error_rec_num ) = ids_letter.RowCount( ) THEN
//	lst_fax_error_records.il_error_rec_num[1] = -2
//	CloseWithReturn( This, lst_fax_error_records  )
//END IF
//
//li_rc = ids_letter.RowCount( )
//
////preprocess list to make sure the appropriate info is there to fax
//IF ab_error_checking THEN
//	FOR i = 1 TO li_rc
//
//		IF is_letter_type = "Verif" THEN
//			//grap the name of the school, ins company etc.
//			IF ids_letter.Describe( "entity_name.border" ) <> "!" THEN			
//				ls_company = ids_letter.GetItemString( i, "entity_name" )							
//			ELSEIF ids_letter.Describe( "entity.border" ) <> "!" THEN			
//				ls_company = ids_letter.GetItemString( i, "entity" )							
//			ELSEIF ids_letter.Describe( "address_lookup_entity_name.border" ) <> "!" THEN			
//				ls_company = ids_letter.GetItemString( i, "address_lookup_entity_name" )			
//			ELSE
//				MessageBox("Support", "The " + ids_letter.DataObject + " data object does not have an entity_name field in it.  Call support." )
//				Return -1
//			END IF
//			//grap the name of the contact person at the school, ins company etc.
//			IF ids_letter.Describe( "contact_name.border" ) <> "!" THEN			
//				ls_recipient = ids_letter.GetItemString( i, "contact_name" )							
//			ELSEIF ids_letter.Describe( "address_lookup_contact_name.border" ) <> "!" THEN			
//				ls_recipient = ids_letter.GetItemString( i, "address_lookup_contact_name" )			
//			ELSE
//				//--------------------------- APPEON BEGIN ---------------------------
//				//$<modify> 2007.08.31 By: Jack
//				//$<reason> Fix a defect
//				/*
//				MessageBox("Support", "The " + ids_letter.DataObject + " data object does not have contact_name field in it.  Call support." )
//				*/
//  				MessageBox("Support", "The " + ids_letter.DataObject + " data object does not have a contact_name field in it.  Call support." )
//				//---------------------------- APPEON END ----------------------------
//				Return -1				
//			END IF
//		ELSE
//			//grap the name of the practitioner if its a corro or exp or exp appoint letter
//			IF ids_letter.Describe( "v_full_name_full_name.border" ) <> "!" THEN						
//				ls_recipient = ids_letter.GetItemString( i, "v_full_name_full_name" )
//				ls_company = ""				
//			ELSEIF ids_letter.Describe( "full_name.border" ) <> "!" THEN						
//				ls_recipient = ids_letter.GetItemString( i, "full_name" )
//				ls_company = ""			
//			ELSE
//				//--------------------------- APPEON BEGIN ---------------------------
//				//$<modify> 2007.08.31 By: Jack
//				//$<reason> Fix a defect.
//				/*
//				MessageBox("Support", "The " + ids_letter.DataObject + " data object does not have FULL NAME field in it.  Call support." )
//				*/
//  				MessageBox("Support", "The " + ids_letter.DataObject + " data object does not have a FULL NAME field in it.  Call support." )
//				//---------------------------- APPEON END ----------------------------
//				Return -1								
//			END IF
//		END IF
//
//		//grap the email address.  Could be from the prac address or the address lookup table
//		IF ids_letter.Describe( "fax.border" ) <> "!" THEN
//			ls_fax =  ids_letter.GetItemString( i, "fax" )
//		ELSEIF ids_letter.Describe( "pd_address_fax.border" ) <> "!" THEN
//			ls_fax =  ids_letter.GetItemString( i, "pd_address_fax" )
//		ELSEIF ids_letter.Describe( "address_lookup_fax.border" ) <> "!" THEN
//			ls_fax =  ids_letter.GetItemString( i, "address_lookup_fax" )
//		ELSE
//			MessageBox("Support", "The " + ids_letter.DataObject + " data object does not have an email_address field in it.  Call support." )
//			Return -1
//		END IF
//				
//		//if its a corro letter then check to see if the prac address has a email number
//		IF IsNull( ls_fax ) OR ls_fax = "" THEN
//			IF ids_letter.Describe( "facility_facility_name.border" ) <> "!" THEN
//				ls_facility_name = ids_letter.GetItemString( i, "facility_facility_name" )
//			ELSEIF ids_letter.Describe( "facility_name.border" ) <> "!" THEN
//				ls_facility_name = ids_letter.GetItemString( i, "facility_name" )
//			ELSEIF ids_letter.Describe( "facility_return_facility_name.border" ) <> "!" THEN
//				ls_facility_name = ids_letter.GetItemString( i, "facility_return_facility_name" )
//			ELSE
//				//--------------------------- APPEON BEGIN ---------------------------
//				//$<modify> 2007.08.31 By: Jack
//				//$<reason> Fix a defect.
//				/*
//				MessageBox("Support", "The " + ids_letter.DataObject + " data object does not have an facility_name field in it.  Call support." )
//				*/
//  				MessageBox("Support", "The " + ids_letter.DataObject + " data object does not have a facility_name field in it.  Call support." )
//				//---------------------------- APPEON END ----------------------------
//				Return -1
//			END IF
//	
//			//grab the full name field.
//			IF ids_letter.Describe( "v_full_name_full_name.border" ) <> "!" THEN
//				ls_full_name = ids_letter.GetItemString( i, "v_full_name_full_name" )
//			ELSEIF ids_letter.Describe( "full_name.border" ) <> "!" THEN
//				ls_full_name = ids_letter.GetItemString( i, "full_name" )		
//			ELSE
//				MessageBox("Support", "The " + ids_letter.DataObject + " data object does not have an full_name field in it.  Call support." )
//				Return -1
//			END IF
//			
//			IF ids_letter.Describe( "address_lookup_entity_name.border" ) <> "!" THEN
//				ls_lookup_entity_name =  ids_letter.GetItemString( i, "address_lookup_entity_name" )
//			ELSEIF ids_letter.Describe( "entity_name.border" ) <> "!" THEN
//				ls_lookup_entity_name =  ids_letter.GetItemString( i, "entity_name" )
//			ELSE
//				ls_lookup_entity_name = "N/A"
//			END IF			
//			
//			li_nr = dw_errors.InsertRow( 0 )
//			
//			li_error_cnt++
//			il_error_rec_num[ li_error_cnt ] = i
//			
//			IF ls_lookup_entity_name <> "N/A" THEN
//				st_text.Text = "The following lookup entity did not have a fax number associated with it."
//				dw_errors.Modify( "facility_name_t.text = 'Address Lookup Record'" )
//				dw_errors.SetItem( li_nr, "facility_name", ls_lookup_entity_name )	
//			ELSE
//				dw_errors.SetItem( li_nr, "facility_name", ls_facility_name )
//			END IF			
//			dw_errors.SetItem( li_nr, "full_name", ls_full_name )	
//		END IF			
//	END FOR	
//
//	st_error_cnt.Text = "There was " + String( li_error_cnt ) + " out of " + String( li_rc ) + " records in error."
//
//	IF li_error_cnt = li_rc THEN
//		cb_continuefax.Enabled = False
//		//--------------------------- APPEON BEGIN ---------------------------
//		//$<comment> 2006-10-12 By: Liu Hongxin
//		//$<reason> fail to fax, it should change print status.
//		/*
//		cb_yes.Enabled = False
//		*/
//		//---------------------------- APPEON END ----------------------------
//		cb_fax.Enabled = False
//	END IF
//
//	IF dw_errors.RowCount( ) > 0 THEN
//		w_ai_print_msg_box.Height = 1475
//		Return -1
//	END IF
//	
//	ab_error_checking	= False		
//	
//END IF
//
//pfc_cst_nv_fax nv_fax
//nv_fax = CREATE pfc_cst_nv_fax;
//
//
//OpenWithParm( w_fax_win, is_letter_type )
//IF Message.StringParm = "Cancel" THEN
//	Return -1
//END IF
//lg_pass_ids = Message.PowerObjectParm
//
//is_cover_page = lg_pass_ids.s_fax_cover
//is_cover_message = lg_pass_ids.s_fax_message 
//is_subject = lg_pass_ids.s_fax_subject	
//	
////check to see if user wants to print attachments (release, priv stuff )
//of_print_image_document( "File" )
//
//IF ids_letter.DataObject = "d_ltr_expiring_appointment" OR  ids_letter.DataObject = "d_ltr_expiring_provisional" OR ids_letter.DataObject = "d_ltr_expiring_allied_health" THEN
//	gi_burn_annos	= 1
//	w_ai_print_letters.of_Print_Application( True )
//	w_ai_print_letters.ib_app_faxed = True	
//	gi_burn_annos	= 0	
//END IF
//	
//
//li_error_cnt = UpperBound( il_error_rec_num )
//
//FOR i = 1 TO li_rc
//	
//	lb_error_rec = False
//	FOR e = 1 TO li_error_cnt
//		IF il_error_rec_num[e] = i THEN
//			lb_error_rec = True
//			Exit
//		END IF
//	END FOR
//	IF lb_error_rec THEN
//		CONTINUE
//	END IF
//	
//	IF is_letter_type = "Verif" THEN
//		//grap the name of the school, ins company etc.
//		IF ids_letter.Describe( "entity_name.border" ) <> "!" THEN			
//			ls_company = ids_letter.GetItemString( i, "entity_name" )							
//		ELSEIF ids_letter.Describe( "entity.border" ) <> "!" THEN			
//			ls_company = ids_letter.GetItemString( i, "entity" )							
//		ELSEIF ids_letter.Describe( "address_lookup_entity_name.border" ) <> "!" THEN			
//			ls_company = ids_letter.GetItemString( i, "address_lookup_entity_name" )			
//		ELSE
//			MessageBox("Support", "The " + ids_letter.DataObject + " data object does not have an entity_name field in it.  Call support." )
//			Return -1
//		END IF
//		
//		//grap the name of the contact person at the school, ins company etc.
//		IF ids_letter.Describe( "contact_name.border" ) <> "!" THEN			
//			ls_recipient = ids_letter.GetItemString( i, "contact_name" )							
//		ELSEIF ids_letter.Describe( "address_lookup_contact_name.border" ) <> "!" THEN			
//			ls_recipient = ids_letter.GetItemString( i, "address_lookup_contact_name" )			
//		ELSE
//			//--------------------------- APPEON BEGIN ---------------------------
//			//$<modify> 2007.08.31 By: Jack
//			//$<reason> Fix a defect.
//			/*
//			MessageBox("Support", "The " + ids_letter.DataObject + " data object does not have contact_name field in it.  Call support." )
//			*/
// 			MessageBox("Support", "The " + ids_letter.DataObject + " data object does not have a contact_name field in it.  Call support." )
//			//---------------------------- APPEON END ----------------------------
//			Return -1				
//		END IF
//		//if the address lookup table does not have a contact then put "no data".
//		IF IsNull( ls_recipient ) OR ls_recipient = "" THEN
//			ls_recipient = "No Data"
//		END IF
//		
//	ELSE
//		//grap the name of the practitioner if its a corro or exp or exp appoint letter
//		IF ids_letter.Describe( "v_full_name_full_name.border" ) <> "!" THEN						
//			ls_recipient = ids_letter.GetItemString( i, "v_full_name_full_name" )
//			ls_company = ""				
//		ELSEIF ids_letter.Describe( "full_name.border" ) <> "!" THEN						
//			ls_recipient = ids_letter.GetItemString( i, "full_name" )
//			ls_company = ""			
//		ELSE
//			//--------------------------- APPEON BEGIN ---------------------------
//			//$<modify> 2007.08.31 By: Jack
//			//$<reason> Fix a defect.
//			/*
//			MessageBox("Support", "The " + ids_letter.DataObject + " data object does not have FULL NAME field in it.  Call support." )
//			*/
// 			MessageBox("Support", "The " + ids_letter.DataObject + " data object does not have a FULL NAME field in it.  Call support." )
//			//---------------------------- APPEON END ----------------------------
//			Return -1								
//		END IF
//	END IF
//
//	//grap the fax address.  Could be from the prac address or the address lookup table
//	IF ids_letter.Describe( "fax.border" ) <> "!" THEN
//		ls_fax =  ids_letter.GetItemString( i, "fax" )
//	ELSEIF ids_letter.Describe( "pd_address_fax.border" ) <> "!" THEN
//		ls_fax =  ids_letter.GetItemString( i, "pd_address_fax" )
//	ELSEIF ids_letter.Describe( "address_lookup_fax.border" ) <> "!" THEN
//		ls_fax =  ids_letter.GetItemString( i, "address_lookup_fax" )
//	ELSE
//		MessageBox("Support", "The " + ids_letter.DataObject + " data object does not have an email_address field in it.  Call support." )
//		Return -1
//	END IF				
//
//	li_attach_cnt = 1
//
//   
//	
//	// mskinner 15 Dec 2005 -- begin
//	of_get_documents(ls_attachments, "_" + String( i ))
//	
//   /*
//	//NEED TO DO SOMETHING WITH SORTING BY DOC ID THEN LINKING TO fax_1, fax_2
//	ls_attachments[ li_attach_cnt ] = gs_dir_path + "IntelliCred\Fax\fax_" + String( i ) + ".doc"
//
//	IF FileExists( gs_dir_path + "IntelliCred\Fax\fax_a_" + String( i ) + ".tif" ) THEN
//		li_attach_cnt++
//		ls_attachments[ li_attach_cnt ] = gs_dir_path + "IntelliCred\Fax\fax_a_" + String( i ) + ".tif"	
//	END IF
//	
//	IF FileExists( gs_dir_path + "IntelliCred\Fax\app_" + String( i ) + ".tif" ) THEN
//		li_attach_cnt++
//		ls_attachments[ li_attach_cnt ] = gs_dir_path + "IntelliCred\Fax\app_" + String( i ) + ".tif"			
//	END IF			
//	*/
//	
//	// mskinner 15 Dec 2005 -- end 
//	String ls_errtext
//	IF nv_fax.of_fax( ls_recipient, ls_company, ls_fax, is_subject, is_cover_message, ls_attachments, is_cover_page,ls_errtext )	= -1 THEN
//		Messagebox('Fax Send',ls_errtext)
//		Return -1
//	END IF
//END FOR
//
//
////structure to return array of records in error
//
//IF UpperBound( il_error_rec_num ) = 0 THEN
//	il_error_rec_num[1] = -5
//END IF
//
//lst_fax_error_records.il_error_rec_num = il_error_rec_num[]
//
////--------------------------- APPEON BEGIN ---------------------------
////$<modify> 11/02/2007 By: Ken.Guo
////$<reason> Maybe PB Bug,So create this event to post close this window.
////CloseWithReturn( This, lst_fax_error_records)
//Post Event ue_post_closewithreturn(lst_fax_error_records)
////---------------------------- APPEON END ----------------------------
//
//
//Return 0
end function

public function integer of_print_image_document (string as_print_to);String ls_image_path
Boolean lb_print_label
Boolean lb_print_priv
Boolean lb_print_release
Boolean lb_error_rec
Integer li_error_cnt
Integer s
Integer e
Integer li_to_page
Integer li_rc
Integer li_image_cnt
Integer li_start_page
Integer li_num_pages
Long ll_prac_id
long ll_facility
String ls_image_file_name
String ls_letter_path
String ls_letter_dw
String ls_word_path,ls_Rtn
boolean lb_exist_pdf = false //Added by (APPEON) Harry 11.15.2017
String ls_filename_temp  //Added by (APPEON) Harry 11.15.2017
String ls_filepath_pdf  //Modified by (APPEON) Harry 11.24.2017
		
IF cbx_mail.Checked THEN
	lb_print_label = True
END IF
IF cbx_priv.Checked THEN
	lb_print_priv = True
END IF
IF cbx_release.Checked THEN
	lb_print_release = True
END IF		

//get image path
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<modify> 02.20.2006 By: Rodger Wu
//$<reason> Performance tuning
//$<modification> Write script to retrieve data from a cache instead of from the database.

/*
SELECT ids.imaging_path  
INTO :ls_image_path  
FROM ids  ;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox("Database Error", SQLCA.SQLERRTEXT )
	Return -1
END IF
*/

ls_image_path = gnv_data.of_GetItem( "ids", "imaging_path", False )
//---------------------------- APPEON END ----------------------------

li_rc = ids_letter.RowCount( )
li_error_cnt = UpperBound( il_error_rec_num )

//loop through and print images

Integer li_image_storage_type, li_print_release_image, li_print_priv

li_image_storage_type = Integer(gnv_data.of_getitem( "icred_settings", "image_storage_type", FALSE))
IF Isnull(li_image_storage_type) THEN li_image_storage_type = 0

IF NOT IsValid(w_dm_image_cp) THEN Open(w_dm_image_cp)  //Added by (APPEON) Harry 11.16.2017 (V161 Storage of Documents as PDFs)

if li_image_storage_type = 1 then//Get image from database;
	IF lb_print_priv = True OR lb_print_release = True THEN
		FOR s = 1 TO li_rc
			
			lb_error_rec = False
			FOR e = 1 TO li_error_cnt
				IF il_error_rec_num[e] = s THEN
					lb_error_rec = True
					Exit
				END IF
			END FOR
			IF lb_error_rec THEN
				CONTINUE
			END IF
	
			//create blank tif file for attachments
			// mskinner 17 Aug 2005 -- begin
			inv_filesrv =  create n_cst_filesrvwin32
			//---------Begin Modified by (Appeon)Stephen 02.18.2014 for citrix user's temporary file paths in the Letter Printing--------
			/*
			IF NOT inv_filesrv.of_DirectoryExists(gs_dir_path + "IntelliCred\Fax") THEN
				inv_filesrv.of_CreateDirectory(gs_dir_path + "IntelliCred\Fax")
			END IF
			*/
			IF NOT inv_filesrv.of_DirectoryExists(gs_temp_path + "Fax") THEN
				inv_filesrv.of_CreateDirectory(gs_temp_path + "Fax")
			END IF
			//---------End Modfiied ------------------------------------------------------
			
			// mskinner 17 Aug 2005 -- end
			//--------------------------- APPEON BEGIN ---------------------------
			//$<Add> 08.22.2007 By: Evan
			//$<Reason> Need to destroy object.
			if IsValid(inv_filesrv) then Destroy inv_filesrv
			//---------------------------- APPEON END ----------------------------
			
			//---------Begin Modified by (Appeon)Stephen 02.18.2014 for citrix user's temporary file paths in the Letter Printing--------
			//ole_admin.object.Image( gs_dir_path + "IntelliCred\Fax\" + "fax_a_" + String(s) + ".tif" )					
			ole_admin.object.Image( gs_temp_path + "Fax\" + "fax_a_" + String(s) + ".tif" )	
			ls_filepath_pdf = gs_temp_path + "Fax\" + "fax_a_" + String(s) + ".pdf"	 //Added by (APPEON) Harry 11.24.2017 (V161 Storage of Documents as PDFs)
			//---------End Modfiied ------------------------------------------------------									
			
			ll_prac_id = ids_letter.GetItemNumber( s, "prac_id" )	

			//Start Code Change ----04.28.2011 #V11 maha - for images
			if ids_letter.Describe("facility_id.ColType") <> "!" then
				ll_facility = ids_letter.GetItemNumber( s, "facility_id" )	
			elseif ids_letter.Describe("verif_facility_id.ColType") <> "!" then
				ll_facility = ids_letter.GetItemNumber( s, "verif_facility_id" )	
			else
				ll_facility = 0
			end if
			//End Code Change ----04.28.2011
			
			/*ls_image_file_name = ls_image_path + String( ll_prac_id ) + ".tif"
			
			IF NOT FileExists( ls_image_file_name ) THEN
				MessageBox( "No Image", "You do not have any images scanned for practitioner ( " + String( ll_prac_id ) + " )")
				CONTINUE
			END IF*/
	
			IF lb_print_release THEN
				if of_retrieve_image_from_db( 1, 1, ll_prac_id, ll_facility ) = 1 then  //Start Code Change ----04.28.2011 #V11 maha - added facility arg
					//Start Code Change ---- 08.10.2007 #V7 maha changed path added error message
					//---------Begin Modified by (Appeon)Stephen 02.18.2014 for citrix user's temporary file paths in the Letter Printing--------
					//ls_image_file_name = gs_dir_path + "\intellicred\Images\temp.tif" 
					//ls_image_file_name = gs_temp_path + "Images\temp.tif"  
					ls_image_file_name = gs_temp_path + "Images\temp." + is_ext   //Modified by (APPEON) Harry 11.16.2017 (V161 Storage of Documents as PDFs)
					//---------End Modfiied ------------------------------------------------------
					
					if not fileexists(ls_image_file_name) then
						messagebox("Printing Release Image", "Cannot find file " + ls_image_file_name + " to print.  Call Support")
						IF IsValid(w_dm_image_cp) THEN Close(w_dm_image_cp)  //Added by (APPEON) Harry 11.24.2017 (V161 Storage of Documents as PDFs)
						return -1
					end if
					//End Code Change---08.10.2007
					
					//Try to work around a bug, reset Image Property, Added by Appeon long.zhang 03.21.2017 (Bug ID #5512 for Case #00068932 Case 55841 Emailing Peer References)
					li_image_cnt = 0 
					IF Upper(is_ext) = 'PDF' THEN //Added by (APPEON) Harry 11.16.2017 (V161 Storage of Documents as PDFs)
						/*
						ole_printpdf.object.FileName = ''
						ole_printpdf.object.LoadMultiPage( ls_image_file_name, 1 )
						Sleep(1000) 
						li_image_cnt = ole_printpdf.object.GetTotalPage()
						*/
						li_image_cnt = w_dm_image_cp.of_gettotalpage(ls_image_file_name) //Modified by (APPEON) Harry 11.24.2017 (V161 Storage of Documents as PDFs)
					ELSE
						ole_print.object.Image = ''
	
						ole_print.object.Image( ls_image_file_name )
						ole_print.object.Display()
						Sleep(1000) //Added by Appeon long.zhang 09.13.2017 (V15.3 Bug # 5796 - Issue with batch emailing peer reference with release & DOP when not combining muliple files)			
						li_image_cnt = ole_print.object.pagecount()
					END IF
					
					//Start Code Change ----03.30.2011 #V11 maha - changed query to use image_pk
					SELECT pd_images.tif_start_page,   
							 pd_images.num_pages  
					INTO :li_start_page,   
						  :li_num_pages  
					FROM pd_images  
					WHERE  pd_images.image_pk = :il_image_pk   ;
					
					if li_start_page < 1 or isnull(li_start_page) then //maha 112904 added trap for no start page
						//MessageBox( "Image/Data mismatch", "The image data has no start page for the Release Form.  Unable to print Release Image for pracitioner id ( " + String( ll_prac_id ) + " )" )
    					MessageBox( "Image/Data mismatch", "The image data has no start page for the Release Form.  Unable to print Release Image for practitioner id ( " + String( ll_prac_id ) + " )" )
						continue
					end if
					if li_num_pages < 1 or isnull(li_num_pages)THEN li_num_pages = 1 //alfee 12.26.2008						
					li_to_page = li_start_page + li_num_pages -1
					//---------Begin Added by (Appeon)Stephen 08.07.2015 for V14.1 Bug # 4640 - Emailing 3+ letters with release & privilege list, the first AI throws a page count error for the privilege list--------
					if li_to_page > li_image_cnt then
						if of_retrieve_image_from_db( 1, 1, ll_prac_id, ll_facility ) = 1 then
							sleep(50)
							
							//Try to work around a bug, reset Image Property, Added by Appeon long.zhang 03.21.2017 (Bug ID #5512 for Case #00068932 Case 55841 Emailing Peer References)
							li_image_cnt = 0 
							IF Upper(is_ext) = 'PDF' THEN //Added by (APPEON) Harry 11.16.2017 (V161 Storage of Documents as PDFs)
								/*
								ole_printpdf.object.FileName = ''
								ole_printpdf.object.LoadMultiPage( ls_image_file_name, 1 )
								Sleep(2000) 
								li_image_cnt = ole_printpdf.object.GetTotalPage()
								*/
								li_image_cnt = w_dm_image_cp.of_gettotalpage(ls_image_file_name) //Modified by (APPEON) Harry 11.24.2017 (V161 Storage of Documents as PDFs)
							ELSE
								ole_print.object.Image = ''
								
								ole_print.object.Image =  ls_image_file_name
								ole_print.object.Display()
								Sleep(2000) //Added by Appeon long.zhang 09.13.2017 (V15.3 Bug # 5796 - Issue with batch emailing peer reference with release & DOP when not combining muliple files)			
								li_image_cnt = ole_print.object.pagecount()
							END IF
						end if
					end if
					//---------End Added ------------------------------------------------------
					
					IF SQLCA.SQLCODE = 0 THEN
						if li_to_page > li_image_cnt then //trap added maha 021904
							MessageBox( "File/Data mismatch", "The image data does not match the page count of the " + ls_image_file_name + " file. " +&
											"(" + String(li_image_cnt) + '-' + String(li_to_page) + ")" +&
											"The Release Form for practitioner (" + String( ll_prac_id ) + ") can not be printed.   (release form)" )//li_image_cnt and li_to_page, Added by Appeon long.zhang 03.21.2017 (Bug ID #5512 for Case #00068932 Case 55841 Emailing Peer References)
						else
							IF as_print_to = "File" THEN
								IF lb_exist_pdf = false AND Upper(is_ext) = 'PDF' THEN //Added by (APPEON) Harry 11.16.2017 (V161 Storage of Documents as PDFs)
									lb_exist_pdf = True
									w_dm_image_cp.of_Image2PDF (ole_admin.object.Image, ls_filepath_pdf)
								END IF
								//if faxing then append release to new file
								//--------------------------- APPEON BEGIN ---------------------------
								//$<add> 07/09/2007 By: Ken.Guo
								//$<reason> When Image Admin Merge(Append) file, The first image file must be in TIF format, Otherwise PB will runerror.
								IF lb_exist_pdf = false THEN  //Added by (APPEON) Harry 11.16.2017 (V161 Storage of Documents as PDFs)
									If ole_admin.object.pagecount() > 0 and ole_admin.object.FileType <> 1 Then
										Messagebox('Image','The first image file must be in "TIF" format.')
										IF IsValid(w_dm_image_cp) THEN Close(w_dm_image_cp)  //Added by (APPEON) Harry 11.24.2017 (V161 Storage of Documents as PDFs)
										Return -1			
									End If
								END IF
								//---------------------------- APPEON END ----------------------------
								
								//--------------------------- APPEON BEGIN ---------------------------
								//$< Add  > 2008-07-15 By: Scofield
								//$<Reason> Verify if the directory has write right for the current user.
								
								ls_Rtn = f_ExaWriteRight(ls_image_file_name)
								if LenA(ls_Rtn) > 0 then
									MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
									IF IsValid(w_dm_image_cp) THEN Close(w_dm_image_cp)  //Added by (APPEON) Harry 11.24.2017 (V161 Storage of Documents as PDFs)
									Return -1
								end if
								//---------------------------- APPEON END ----------------------------
								IF lb_exist_pdf THEN //Added by (APPEON) Harry 11.16.2017 (V161 Storage of Documents as PDFs)
									IF Upper(is_ext) <> 'PDF' THEN
										ls_filename_temp = Mid( ls_image_file_name , 1, LastPos( ls_image_file_name , '.')) + 'pdf'
										w_dm_image_cp.of_Image2PDF (ls_image_file_name , ls_filename_temp)
										ls_image_file_name = ls_filename_temp 
										is_ext = 'PDF'
									END IF
									w_dm_image_cp.of_insert_page_pdf( ls_filepath_pdf,  ls_image_file_name, 0, li_start_page , li_num_pages )
								ELSE
									ole_admin.object.Append( ls_image_file_name, li_start_page , li_num_pages  )			
								END IF
							ELSE
								IF Upper(is_ext) = 'PDF' THEN //Added by (APPEON) Harry 11.16.2017 (V161 Storage of Documents as PDFs)
									w_dm_image_cp.of_printimage(ls_image_file_name,  li_start_page, li_to_page, 9, false)
								ELSE
									ole_print.object.PrintImage( li_start_page, li_to_page, 3)
								END IF
							END IF
						end if									
					ELSE
						//MessageBox( "No Image", "There is no Release Form for pracitioner id ( " + String( ll_prac_id ) + " )" )											
    					MessageBox( "No Image", "There is no Release Form for practitioner id ( " + String( ll_prac_id ) + " )" )           
					END IF
				else
					//MessageBox( "No Image", "There is no Release Form for pracitioner id ( " + String( ll_prac_id ) + " )" )
   				MessageBox( "No Image", "There is no Release Form for practitioner id ( " + String( ll_prac_id ) + " )" )
				end if
			END IF
					
			IF lb_print_priv THEN
				if of_retrieve_image_from_db( 1, 2, ll_prac_id, ll_facility ) = 1 then   //Start Code Change ----04.28.2011 #V11 maha - added facility arg
					//Changed path and added error message By Ken.Guo 09-17-2008.
					
					//---------Begin Modified by (Appeon)Stephen 02.18.2014 for citrix user's temporary file paths in the Letter Printing--------
					//ls_image_file_name = gs_dir_path + "\intellicred\Images\temp.tif" 
					//ls_image_file_name = gs_temp_path + "Images\temp.tif" 
					ls_image_file_name = gs_temp_path + "Images\temp." + is_ext   //Modified by (APPEON) Harry 11.16.2017 (V161 Storage of Documents as PDFs)
					//---------End Modfiied ------------------------------------------------------	
					if not fileexists(ls_image_file_name) then
						messagebox("Printing Privilege Image", "Cannot find file " + ls_image_file_name + " to print.  Call Support")
						IF IsValid(w_dm_image_cp) THEN Close(w_dm_image_cp)  //Added by (APPEON) Harry 11.24.2017 (V161 Storage of Documents as PDFs)
						return -1
					end if		
					
					//Try to work around a bug, reset Image Property, Added by Appeon long.zhang 03.21.2017 (Bug ID #5512 for Case #00068932 Case 55841 Emailing Peer References)
					li_image_cnt = 0 
					IF Upper(is_ext) = 'PDF' THEN //Added by (APPEON) Harry 11.16.2017 (V161 Storage of Documents as PDFs)
						/*
						ole_printpdf.object.FileName = ''
						ole_printpdf.object.LoadMultiPage( ls_image_file_name, 1 )
						Sleep(1000) 
						li_image_cnt = ole_printpdf.object.GetTotalPage()
						*/
						li_image_cnt = w_dm_image_cp.of_gettotalpage(ls_image_file_name) //Modified by (APPEON) Harry 11.24.2017 (V161 Storage of Documents as PDFs)
					ELSE
						ole_print.object.Image = ''
								
						ole_print.object.Image( ls_image_file_name )
						ole_print.object.Display()
						Sleep(1000) //Added by Appeon long.zhang 09.13.2017 (V15.3 Bug # 5796 - Issue with batch emailing peer reference with release & DOP when not combining muliple files)			
						li_image_cnt = ole_print.object.pagecount()
					END IF
					
					//Start Code Change ----03.30.2011 #V11 maha - changed query to use image_pk
					SELECT pd_images.tif_start_page,   
							 pd_images.num_pages  
					INTO :li_start_page,   
						  :li_num_pages  
					FROM pd_images  
					WHERE pd_images.image_pk = :il_image_pk ;
							  
					if li_start_page < 1 or isnull(li_start_page) then //maha 112904 added trap for no start page
						//MessageBox( "Image/Data mismatch", "The image data has no start page for the Privileges.  Unable to print Privileges Image for pracitioner id ( " + String( ll_prac_id ) + " )" )
    						MessageBox( "Image/Data mismatch", "The image data has no start page for the Privileges.  Unable to print Privileges Image for practitioner id ( " + String( ll_prac_id ) + " )" )
						continue
					end if
					if li_num_pages < 1 or isnull(li_num_pages)THEN li_num_pages = 1 //alfee 12.26.2008						
					li_to_page = li_start_page + li_num_pages -1
					//---------Begin Added by (Appeon)Stephen 08.07.2015 for V14.1 Bug # 4640 - Emailing 3+ letters with release & privilege list, the first AI throws a page count error for the privilege list--------
					if li_to_page > li_image_cnt then
						if of_retrieve_image_from_db( 1, 2, ll_prac_id, ll_facility ) = 1 then
							sleep(50)
							
							//Try to work around a bug, reset Image Property, Added by Appeon long.zhang 03.21.2017 (Bug ID #5512 for Case #00068932 Case 55841 Emailing Peer References)
							li_image_cnt = 0 
							IF Upper(is_ext) = 'PDF' THEN //Added by (APPEON) Harry 11.16.2017 (V161 Storage of Documents as PDFs)
								/*
								ole_printpdf.object.FileName = ''
								ole_printpdf.object.LoadMultiPage( ls_image_file_name, 1 )
								Sleep(2000) 
								li_image_cnt = ole_printpdf.object.GetTotalPage()
								*/
								li_image_cnt = w_dm_image_cp.of_gettotalpage(ls_image_file_name) //Modified by (APPEON) Harry 11.24.2017 (V161 Storage of Documents as PDFs)
							ELSE
								ole_print.object.Image = ''
								
								ole_print.object.Image =  ls_image_file_name
								ole_print.object.Display()
	
								Sleep(2000) //Added by Appeon long.zhang 09.13.2017 (V15.3 Bug # 5796 - Issue with batch emailing peer reference with release & DOP when not combining muliple files)			
								li_image_cnt = ole_print.object.pagecount()
							END IF
						end if
					end if
					//---------End Added ------------------------------------------------------
					
					IF SQLCA.SQLCODE = 0 THEN
						if li_to_page > li_image_cnt then //trap added maha 021904
							MessageBox( "File/Data mismatch", "The image data does not match the page count of the " + ls_image_file_name + " file. " +&
											"(" + String(li_image_cnt) + '-' + String(li_to_page) + ") " +&
											"The Privilege List Form for practitioner (" + String( ll_prac_id ) + ") can not be printed.   (priv print)" ) //li_image_cnt and li_to_page, Added by Appeon long.zhang 03.21.2017 (Bug ID #5512 for Case #00068932 Case 55841 Emailing Peer References)
						else
							IF as_print_to = "File" THEN
								IF lb_exist_pdf = false AND Upper(is_ext) = 'PDF' THEN //Added by (APPEON) Harry 11.16.2017 (V161 Storage of Documents as PDFs)
									lb_exist_pdf = True
									w_dm_image_cp.of_Image2PDF (ole_admin.object.Image, ls_filepath_pdf)
								END IF
							
								//if faxing then append privs to new file	
								//--------------------------- APPEON BEGIN ---------------------------
								//$<add> 07/09/2007 By: Ken.Guo
								//$<reason> When Image Admin Merge file, The first image file must be in TIF format, Otherwise PB will runerror.
								IF  lb_exist_pdf = false THEN  //Added by (APPEON) Harry 11.16.2017 (V161 Storage of Documents as PDFs)
									If ole_admin.object.pagecount() > 0 and ole_admin.object.FileType <> 1 Then
										Messagebox('Image','The first image file must be in "TIF" format.')
										IF IsValid(w_dm_image_cp) THEN Close(w_dm_image_cp)  //Added by (APPEON) Harry 11.24.2017 (V161 Storage of Documents as PDFs)
										Return -1			
									End If
								END IF
								//---------------------------- APPEON END ----------------------------
								//--------------------------- APPEON BEGIN ---------------------------
								//$< Add  > 2008-07-15 By: Scofield
								//$<Reason> Verify if the directory has write right for the current user.
								
								ls_Rtn = f_ExaWriteRight(ls_image_file_name)
								if LenA(ls_Rtn) > 0 then
									MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
									IF IsValid(w_dm_image_cp) THEN Close(w_dm_image_cp)  //Added by (APPEON) Harry 11.24.2017 (V161 Storage of Documents as PDFs)
									Return -1
								end if
								//---------------------------- APPEON END ----------------------------
								IF lb_exist_pdf THEN //Added by (APPEON) Harry 11.16.2017 (V161 Storage of Documents as PDFs)
									IF Upper(is_ext) <> 'PDF' THEN
										ls_filename_temp = Mid( ls_image_file_name , 1, LastPos( ls_image_file_name , '.')) + 'pdf'
										w_dm_image_cp.of_Image2PDF (ls_image_file_name , ls_filename_temp)
										ls_image_file_name = ls_filename_temp 
										is_ext = 'PDF'
									END IF
									w_dm_image_cp.of_insert_page_pdf(ls_filepath_pdf,  ls_image_file_name, 0, li_start_page , li_num_pages )
								ELSE
									ole_admin.object.Append( ls_image_file_name, li_start_page , li_num_pages  )			
								END IF								
							ELSE
								IF Upper(is_ext) = 'PDF' THEN //Added by (APPEON) Harry 11.16.2017 (V161 Storage of Documents as PDFs)
									w_dm_image_cp.of_printimage(ls_image_file_name,  li_start_page, li_to_page, 9, false)
								ELSE
									ole_print.object.PrintImage( li_start_page, li_to_page, 3)
								END IF
							END IF
						end if								
					ELSE
						MessageBox( "No Image", "There is no Privilege List Form for practitioner id( " + String( ll_prac_id ) + " )" )																	
					END IF
				else
					MessageBox( "No Image", "There is no Privilege List Form for practitioner id( " + String( ll_prac_id ) + " )" )
				end if
			END IF						
		END FOR
	END IF
else //stored on hard drive
	IF lb_print_priv = True OR lb_print_release = True THEN
		FOR s = 1 TO li_rc
			
			lb_error_rec = False
			FOR e = 1 TO li_error_cnt
				IF il_error_rec_num[e] = s THEN
					lb_error_rec = True
					Exit
				END IF
			END FOR
			IF lb_error_rec THEN
				CONTINUE
			END IF
	
			//create blank tif file for attachments
			// mskinner 17 Aug 2005 -- begin
			inv_filesrv =  create n_cst_filesrvwin32
			//---------Begin Modified by (Appeon)Stephen 02.18.2014 for citrix user's temporary file paths in the Letter Printing--------
			/*
			IF NOT inv_filesrv.of_DirectoryExists(gs_dir_path + "IntelliCred\Fax") THEN
				inv_filesrv.of_CreateDirectory(gs_dir_path + "IntelliCred\Fax")
			END IF
			*/
			IF NOT inv_filesrv.of_DirectoryExists(gs_temp_path + "Fax") THEN
				inv_filesrv.of_CreateDirectory(gs_temp_path + "Fax")
			END IF
			//---------End Modfiied ------------------------------------------------------
			
			// mskinner 17 Aug 2005 -- end
			//--------------------------- APPEON BEGIN ---------------------------
			//$<Add> 08.22.2007 By: Evan
			//$<Reason> Need to destroy object.
			if IsValid(inv_filesrv) then Destroy inv_filesrv
			//---------------------------- APPEON END ----------------------------
			
			//---------Begin Modified by (Appeon)Stephen 02.18.2014 for citrix user's temporary file paths in the Letter Printing--------
			//ole_admin.object.Image( gs_dir_path + "IntelliCred\Fax\" + "fax_a_" + String(s) + ".tif" )		
			ole_admin.object.Image( gs_temp_path + "Fax\" + "fax_a_" + String(s) + ".tif" )
			ls_filepath_pdf = gs_temp_path + "Fax\" + "fax_a_" + String(s) + ".pdf" //Modified by (APPEON) Harry 11.24.2017 (V161 Storage of Documents as PDFs)
			//---------End Modfiied ------------------------------------------------------									
			
			ll_prac_id = ids_letter.GetItemNumber( s, "prac_id" )	
			
			//Added by (APPEON) Harry 11.16.2017 (V161 Storage of Documents as PDFs)
			//Start Code Change ----03.30.2011 #V11 maha - get image pk
			il_image_pk = of_find_image_id( 1, ll_prac_id,  0)
			if il_image_pk = 0 then continue
			//End Code Change ----03.30.2011
			
			//Start Code Change ----03.30.2011 #V11 maha - changed query to use image_pk
			SELECT pd_images.tif_start_page,   
					 pd_images.num_pages, 
					 image_ext
			INTO :li_start_page,   
				  :li_num_pages,
				  :is_ext
			FROM pd_images  
			WHERE  pd_images.image_pk = :il_image_pk ;  
			//End Added----------------------------------------------
			
			IF Upper(is_ext) = 'PDF' THEN //Added by (APPEON) Harry 11.16.2017 (V161 Storage of Documents as PDFs)
				ls_image_file_name = ls_image_path + String( ll_prac_id ) + ".pdf"
			ELSE
				ls_image_file_name = ls_image_path + String( ll_prac_id ) + ".tif"
			END IF
				
			IF NOT FileExists( ls_image_file_name ) THEN
				MessageBox( "No Image", "You do not have any images scanned for practitioner ( " + String( ll_prac_id ) + " )")
				CONTINUE
			END IF		
			IF Upper(is_ext) = 'PDF' THEN //Added by (APPEON) Harry 11.16.2017 (V161 Storage of Documents as PDFs)
				/*
				ole_printpdf.object.LoadMultiPage( ls_image_file_name, 1 )
				li_image_cnt = ole_printpdf.object.GetTotalPage()
				*/
				li_image_cnt = w_dm_image_cp.of_gettotalpage(ls_image_file_name) //Modified by (APPEON) Harry 11.24.2017 (V161 Storage of Documents as PDFs)
			ELSE
				ole_print.object.Image( ls_image_file_name )
				ole_print.object.Display()
				
				li_image_cnt = ole_print.object.pagecount()
			END IF
			
			
							
			IF lb_print_release THEN
				//Commented by (APPEON) Harry 11.16.2017 (V161 Storage of Documents as PDFs)
				/*
				//Start Code Change ----03.30.2011 #V11 maha - get image pk
				il_image_pk = of_find_image_id( 1, ll_prac_id,  0)
				if il_image_pk = 0 then continue
				//End Code Change ----03.30.2011
				
				//Start Code Change ----03.30.2011 #V11 maha - changed query to use image_pk
				SELECT pd_images.tif_start_page,   
						 pd_images.num_pages, 
						 image_ext
				INTO :li_start_page,   
					  :li_num_pages,
					  :is_ext
				FROM pd_images  
				WHERE  pd_images.image_pk = :il_image_pk   ;  //Added by (APPEON) Harry 11.16.2017 (V161 Storage of Documents as PDFs)
				*/
		
				if li_start_page < 1 or isnull(li_start_page) then //maha 112904 added trap for no start page
					//MessageBox( "Image/Data mismatch", "The image data has no start page for the Release Form.  Unable to print Release Image for pracitioner id ( " + String( ll_prac_id ) + " )" )
   				MessageBox( "Image/Data mismatch", "The image data has no start page for the Release Form.  Unable to print Release Image for practitioner id ( " + String( ll_prac_id ) + " )" )
					continue
				end if
				if li_num_pages < 1 or isnull(li_num_pages)THEN li_num_pages = 1 //alfee 12.26.2008					
				li_to_page = li_start_page + li_num_pages -1
				IF SQLCA.SQLCODE = 0 THEN
					if li_to_page > li_image_cnt then //trap added maha 021904
						MessageBox( "File/Data mismatch", "The image data does not match the  " + ls_image_path +  String( ll_prac_id ) + ".tif file. " +&
										"The Release Form for practitioner (" + String( ll_prac_id ) + ") can not be printed." )
					else
						
						IF as_print_to = "File" THEN
							IF lb_exist_pdf = False AND Upper(is_ext) = 'PDF' THEN //Added by (APPEON) Harry 11.16.2017 (V161 Storage of Documents as PDFs)
								lb_exist_pdf = True
								w_dm_image_cp.of_Image2PDF (ole_admin.object.Image, ls_filepath_pdf)
							END IF
							//if faxing then append release to new file
							//--------------------------- APPEON BEGIN ---------------------------
							//$<add> 07/09/2007 By: Ken.Guo
							//$<reason> When Image Admin Merge file, The first image file must be in TIF format, Otherwise PB will runerror.
							IF lb_exist_pdf = False THEN //Added by (APPEON) Harry 11.16.2017 (V161 Storage of Documents as PDFs)
								If ole_admin.object.pagecount() > 0 and ole_admin.object.FileType <> 1 Then
									Messagebox('Image','The first image file must be in "TIF" format.')
									IF IsValid(w_dm_image_cp) THEN Close(w_dm_image_cp)  //Added by (APPEON) Harry 11.24.2017 (V161 Storage of Documents as PDFs)
									Return -1			
								End If
							END IF
							//---------------------------- APPEON END ----------------------------
							
							//--------------------------- APPEON BEGIN ---------------------------
							//$< Add  > 2008-07-15 By: Scofield
							//$<Reason> Verify if the directory has write right for the current user.
							
							ls_Rtn = f_ExaWriteRight(ls_image_file_name)
							if LenA(ls_Rtn) > 0 then
								MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
								IF IsValid(w_dm_image_cp) THEN Close(w_dm_image_cp)  //Added by (APPEON) Harry 11.24.2017 (V161 Storage of Documents as PDFs)
								Return -1
							end if
							//---------------------------- APPEON END ----------------------------
							IF lb_exist_pdf THEN //Added by (APPEON) Harry 11.16.2017 (V161 Storage of Documents as PDFs)
								IF Upper(is_ext) <> 'PDF' THEN
									ls_filename_temp = Mid( ls_image_file_name , 1, LastPos( ls_image_file_name , '.')) + 'pdf'
									w_dm_image_cp.of_Image2PDF (ls_image_file_name , ls_filename_temp)
									ls_image_file_name = ls_filename_temp 
									is_ext = 'PDF'
								END IF
								w_dm_image_cp.of_insert_page_pdf( ls_filepath_pdf,  ls_image_file_name, 0, li_start_page , li_num_pages )
							ELSE
								ole_admin.object.Append( ls_image_file_name, li_start_page , li_num_pages  )				
							END IF		
															
						ELSE
							IF Upper(is_ext) = 'PDF' THEN //Added by (APPEON) Harry 11.16.2017 (V161 Storage of Documents as PDFs)
								w_dm_image_cp.of_printimage(ls_image_file_name,  li_start_page, li_to_page, 9, false)
							ELSE
								ole_print.object.PrintImage( li_start_page, li_to_page, 3)
							END IF
						END IF
					end if									
				ELSE
					//MessageBox( "No Image", "There is no Release Form for pracitioner id ( " + String( ll_prac_id ) + " )" )											
   				MessageBox( "No Image", "There is no Release Form for practitioner id ( " + String( ll_prac_id ) + " )" )           
				END IF
			END IF
					
			IF lb_print_priv THEN
				//Commented by (APPEON) Harry 11.16.2017 (V161 Storage of Documents as PDFs)
				/*
				//Start Code Change ----03.30.2011 #V11 maha - get image pk
				il_image_pk = of_find_image_id( 1, ll_prac_id,  0)
				if il_image_pk = 0 then continue
				//End Code Change ----03.30.2011
				
				//Start Code Change ----03.30.2011 #V11 maha - changed query to use image_pk
				SELECT pd_images.tif_start_page,   
						 pd_images.num_pages  
				INTO :li_start_page,   
					  :li_num_pages  
				FROM pd_images  
				WHERE  pd_images.image_pk = :il_image_pk   ;
				*/		  
				if li_start_page < 1 or isnull(li_start_page) then //maha 112904 added trap for no start page
					//MessageBox( "Image/Data mismatch", "The image data has no start page for the Privileges.  Unable to print Privileges Image for pracitioner id ( " + String( ll_prac_id ) + " )" )
   				MessageBox( "Image/Data mismatch", "The image data has no start page for the Privileges.  Unable to print Privileges Image for practitioner id ( " + String( ll_prac_id ) + " )" )
					continue
				end if
				if li_num_pages < 1 or isnull(li_num_pages)THEN li_num_pages = 1 //alfee 12.26.2008					
				li_to_page = li_start_page + li_num_pages -1
				IF SQLCA.SQLCODE = 0 THEN
					if li_to_page > li_image_cnt then //trap added maha 021904
						MessageBox( "File/Data mismatch", "The image data does not match the  " + ls_image_path +  String( ll_prac_id ) + ".tif file. " +&
										"The Privilege List Form for practitioner (" + String( ll_prac_id ) + ") can not be printed." )
					else
						IF as_print_to = "File" THEN
							IF lb_exist_pdf = False AND Upper(is_ext) = 'PDF' THEN //Added by (APPEON) Harry 11.16.2017 (V161 Storage of Documents as PDFs)
								lb_exist_pdf = True
								w_dm_image_cp.of_Image2PDF (ole_admin.object.Image, ls_filepath_pdf)
							END IF
							//if faxing then append privs to new file		
							//--------------------------- APPEON BEGIN ---------------------------
							//$<add> 07/09/2007 By: Ken.Guo
							//$<reason> When Image Admin Merge file, The first image file must be in TIF format, Otherwise PB will runerror.
							IF lb_exist_pdf = False THEN //Added by (APPEON) Harry 11.16.2017 (V161 Storage of Documents as PDFs)
								If ole_admin.object.pagecount() > 0 and ole_admin.object.FileType <> 1 Then
									Messagebox('Image','The first image file must be in "TIF" format.')
									IF IsValid(w_dm_image_cp) THEN Close(w_dm_image_cp)  //Added by (APPEON) Harry 11.24.2017 (V161 Storage of Documents as PDFs)
									Return -1			
								End If
							END IF
							//---------------------------- APPEON END ----------------------------
							
							//--------------------------- APPEON BEGIN ---------------------------
							//$< Add  > 2008-07-15 By: Scofield
							//$<Reason> Verify if the directory has write right for the current user.
							
							ls_Rtn = f_ExaWriteRight(ls_image_file_name)
							if LenA(ls_Rtn) > 0 then
								MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
								IF IsValid(w_dm_image_cp) THEN Close(w_dm_image_cp)  //Added by (APPEON) Harry 11.24.2017 (V161 Storage of Documents as PDFs)
								Return -1
							end if
							//---------------------------- APPEON END ----------------------------
							IF lb_exist_pdf THEN //Added by (APPEON) Harry 11.16.2017 (V161 Storage of Documents as PDFs)
								IF Upper(is_ext) <> 'PDF' THEN
									ls_filename_temp = Mid( ls_image_file_name , 1, LastPos( ls_image_file_name , '.')) + 'pdf'
									w_dm_image_cp.of_Image2PDF (ls_image_file_name , ls_filename_temp)
									ls_image_file_name = ls_filename_temp 
									is_ext = 'PDF'
								END IF
								w_dm_image_cp.of_insert_page_pdf( ls_filepath_pdf,  ls_image_file_name, 0, li_start_page , li_num_pages )
							ELSE
								ole_admin.object.Append( ls_image_file_name, li_start_page , li_num_pages  )				
							END IF										
						ELSE
							IF Upper(is_ext) = 'PDF' THEN //Added by (APPEON) Harry 11.16.2017 (V161 Storage of Documents as PDFs)
								w_dm_image_cp.of_printimage(ls_image_file_name,  li_start_page, li_to_page, 9, false)
							ELSE
								ole_print.object.PrintImage( li_start_page, li_to_page, 3)
							END IF
						END IF
					end if								
				ELSE
					MessageBox( "No Image", "There is no Privilege List Form for practitioner id( " + String( ll_prac_id ) + " )" )																	
				END IF
			END IF						
		END FOR
	END IF
end if
//---------------------------- APPEON END ----------------------------

IF IsValid(w_dm_image_cp) THEN Close(w_dm_image_cp)  //Added by (APPEON) Harry 11.15.2017 (V161 Storage of Documents as PDFs)

IF lb_print_label THEN
	
	//	ls_word_path = ProfileString( gs_dir_path + "intellicred\intellicred.ini", "paths", "word", "None" )
	//	IF NOT FileExists( gs_dir_path + "intellicred\intellicred.ini" ) THEN
	//		MessageBox("ini File Error", "No intellicred.ini file found at: " + gs_dir_path + "intellicred\intellicred.ini" )
	//		Return -1
	//	END IF
		
		///Run( ls_word_path + " " +  is_mail_label_doc, Maximized!)								
		
		// mskinner start
		
	// MSKINNER 06 JAN 2005 -- BEGIN
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 06.08.2006 By: Rodger Wu
	//$<reason> download the file from Database.
	if LenA( Trim( is_mail_label_doc )) = 0 then return 0
	
	If gnv_data.of_getitem('icred_settings' ,'set_50' , False ) = '1' or &
		Upper( appeongetclienttype() ) = 'WEB' Then
		
		//Mail labels :Store the letter_path in variable from facility_id = 1
		n_appeon_storage_area lnv_storage_area
		IF lnv_storage_area.of_retrieve_doc_from_db( 1, is_mail_label_doc, ls_letter_path) < 0 THEN
			Messagebox("Download File",'The MSWord document '+  is_mail_label_doc  +'  does not exist in the database.')
			RETURN -1
		END IF
		is_mail_label_doc = ls_letter_path + is_mail_label_doc
	End If
	//---------------------------- APPEON END ----------------------------
	
//Start Code Change ----07.28.2009 #V92 maha - changed to function call to make it consistant to the rest of the program
//	CHOOSE CASE  gi_citrix
//		CASE 0  //NO CITRIX
//			ls_image_path = gs_dir_path + "intellicred\letters\data\ind_generic_corrospondence.txt" 
//		CASE 1 //CITRIX
//			ls_image_path = gs_save_path + gs_user_id + "\ind_generic_corrospondence.txt"
//	END CHOOSE 
	ls_image_path  = of_letter_paths("D") + "ind_generic_corrospondence.txt"
//End Code Change---07.28.2009
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 03/25/2008 By: Ken.Guo
	//$<reason> Fix BugK032501
	//$ Merge datasource file maybe other file(e.g. "case_review_committee.txt","net_dev_ai.txt" ext.) 
	//$ When print letter from w_letter_generator.
	If LenA(is_merge_file_path) > 1 Then
		ls_image_path = is_merge_file_path
	End If
	//---------------------------- APPEON END ----------------------------
	
	gnv_app.gnvlo_msword.of_open_word_document(is_mail_label_doc, ls_image_path,'')
END IF		

// MSKINNER 06 JAN 2005 -- BEGIN


Return 0
end function

public function integer of_email (boolean ab_error_checking);return 0

////Jervis 12-10-2008
////This function is obsolete.  DO NOT USE THIS FUNCTION
//
//Boolean lb_error_rec
//String ls_facility_name
//String ls_full_name
//String ls_attachments[]
////--------------------------- APPEON BEGIN ---------------------------
////$<add> 08.08.2006 By: LeiWei
////$<reason> Fix a defect.
//String ls_attachments_null[]
////---------------------------- APPEON END ----------------------------
//String ls_recipient
//String ls_company
//string ls_column
//String ls_email
//String ls_lookup_entity_name
//String ls_no_email
//Integer li_attach_cnt
//Integer e
//Integer li_nr
//Integer li_error
//Integer li_error_cnt
//Long li_rc
//Long i
//Long f
//Long ChanNum
//gs_pass_ids  lg_pass_ids
//gs_fax_error_records lst_email_error_records
//
//ib_faxing_doc = False
//
////IF all letter records were missing email numbers then return with -2 or Cancel
//IF UpperBound( il_error_rec_num ) = ids_letter.RowCount( ) THEN
//	lst_email_error_records.il_error_rec_num[1] = -2
//	CloseWithReturn( This, lst_email_error_records  )
//END IF
//
//li_rc = ids_letter.RowCount( )
//
////preprocess list to make sure the appropriate info is there to email
//IF ab_error_checking THEN
//	FOR i = 1 TO li_rc
//		IF is_letter_type = "Verif" THEN
//			//grap the name of the school, ins company etc.
//			IF ids_letter.Describe( "entity_name.border" ) <> "!" THEN			
//				ls_company = ids_letter.GetItemString( i, "entity_name" )							
//			ELSEIF ids_letter.Describe( "entity.border" ) <> "!" THEN			
//				ls_company = ids_letter.GetItemString( i, "entity" )							
//			ELSEIF ids_letter.Describe( "address_lookup_entity_name.border" ) <> "!" THEN			
//				ls_company = ids_letter.GetItemString( i, "address_lookup_entity_name" )			
//			ELSE
//				MessageBox("Support", "The " + ids_letter.DataObject + " data object does not have an entity_name field in it.  Call support." )
//				Return -1
//			END IF
//			//grap the name of the contact person at the school, ins company etc.
//			IF ids_letter.Describe( "contact_name.border" ) <> "!" THEN			
//				ls_recipient = ids_letter.GetItemString( i, "contact_name" )							
//			ELSEIF ids_letter.Describe( "address_lookup_contact_name.border" ) <> "!" THEN			
//				ls_recipient = ids_letter.GetItemString( i, "address_lookup_contact_name" )			
//			ELSE
//				//MessageBox("Support", "The " + ids_letter.DataObject + " data object does not have contact_name field in it.  Call support." )
//  				MessageBox("Support", "The " + ids_letter.DataObject + " data object does not have a contact_name field in it.  Call support." )
//				Return -1				
//			END IF
//		ELSE
//			//grap the name of the practitioner if its a corro or exp or exp appoint letter
//			IF ids_letter.Describe( "v_full_name_full_name.border" ) <> "!" THEN						
//				ls_recipient = ids_letter.GetItemString( i, "v_full_name_full_name" )
//				ls_company = ""				
//			ELSEIF ids_letter.Describe( "full_name.border" ) <> "!" THEN						
//				ls_recipient = ids_letter.GetItemString( i, "full_name" )
//				ls_company = ""			
//			ELSE
//				//MessageBox("Support", "The " + ids_letter.DataObject + " data object does not have FULL NAME field in it.  Call support." )
//  				MessageBox("Support", "The " + ids_letter.DataObject + " data object does not have a FULL NAME field in it.  Call support." )
//				Return -1								
//			END IF
//		END IF
//      /////////////////////////////////////////////////////////////////////////////////////////////
//		//grab tbe email address.  Could be from the prac address or the address lookup table
//		/////////////////////////////////////////////////////////////////////////////////////////////
//		
//		// start code change --- 11.01.2005 MSKINNER
//		//--------------------------- APPEON BEGIN ---------------------------
//		//$<modify> 08.15.2006 By: LeiWei
//		//$<reason> Fix a defect.
//		/*
//		string ls_column
//		ls_column = ids_letter.of_get_column_name("email_address")
//		if len(ls_column) > 0 then
//			ls_email =  ids_letter.GetItemString( i, ls_column )
//			 if not f_validstr(ls_email) then
//				ls_column = ids_letter.of_get_column_name("e_mail_address")
//				if len(ls_column) > 0 then
//					ls_email =  ids_letter.GetItemString( i, ls_column )
//				end if 
//			end if
//		*/
////Start Code Change ---- 10.04.2006 #683 maha  rewrote slightly
////		IF ids_letter.Describe("email_address.name") = "email_address" THEN
////			ls_email =  ids_letter.GetItemString( i, "email_address" )
////			 if not f_validstr(ls_email) then
////				IF ids_letter.Describe("e_mail_address.name") = "e_mail_address" THEN
////					ls_email =  ids_letter.GetItemString( i, "e_mail_address" )
////				end if 
////			end if
////		//---------------------------- APPEON END ----------------------------
////		else 
////			
////			MessageBox("Support", "The " + ids_letter.DataObject + " data object does not have an email_address field in it.  Call support." )
////		  Return -1
////			
////   		end if 
////		
//
//		if ids_letter.Describe("email_address.ColType") = "!"	then
//			if ids_letter.Describe("e_mail_address.ColType") = "!"	then
//				if ids_letter.Describe("pd_address_e_mail_address.ColType") = "!"	then
//					MessageBox("Support", "The " + ids_letter.DataObject + " data object does not have a field called 'email_address' or 'e_mail_address'.  Contact IntelliSoft support to have this corrected for a later build.  You cannot email this letter type." )
//					 Return -1
//				else
//					ls_column = "pd_address_e_mail_address"
//				end if
//			else
//				ls_column = "e_mail_address"
//			end if
//		else 
//			ls_column = "email_address"
//		end if
//		ls_email =  ids_letter.GetItemString( i, ls_column )
////End Code Change---10.04.2006
//			
//				
//		//if its a corro letter then check to see if the prac address has a email number
//		IF IsNull( ls_email ) OR ls_email = "" THEN
//			IF ids_letter.Describe( "facility_facility_name.border" ) <> "!" THEN
//				ls_facility_name = ids_letter.GetItemString( i, "facility_facility_name" )
//			ELSEIF ids_letter.Describe( "facility_name.border" ) <> "!" THEN
//				ls_facility_name = ids_letter.GetItemString( i, "facility_name" )
//			ELSEIF ids_letter.Describe( "facility_return_facility_name.border" ) <> "!" THEN
//				ls_facility_name = ids_letter.GetItemString( i, "facility_return_facility_name" )
//			ELSE
//				//MessageBox("Support", "The " + ids_letter.DataObject + " data object does not have an facility_name field in it.  Call support." )
//  				MessageBox("Support", "The " + ids_letter.DataObject + " data object does not have a facility_name field in it.  Call support." )
//				Return -1
//			END IF
//	
//			//grab the full name field.
//			IF ids_letter.Describe( "v_full_name_full_name.border" ) <> "!" THEN
//				ls_full_name = ids_letter.GetItemString( i, "v_full_name_full_name" )
//			ELSEIF ids_letter.Describe( "full_name.border" ) <> "!" THEN
//				ls_full_name = ids_letter.GetItemString( i, "full_name" )		
//			ELSE
//				//MessageBox("Support", "The " + ids_letter.DataObject + " data object does not have an full_name field in it.  Call support." )
//  				MessageBox("Support", "The " + ids_letter.DataObject + " data object does not have a full_name field in it.  Call support." )
//				Return -1
//			END IF
//			
//			IF ids_letter.Describe( "address_lookup_entity_name.border" ) <> "!" THEN
//				ls_lookup_entity_name =  ids_letter.GetItemString( i, "address_lookup_entity_name" )
//			ELSEIF ids_letter.Describe( "entity_name.border" ) <> "!" THEN
//				ls_lookup_entity_name =  ids_letter.GetItemString( i, "entity_name" )
//			ELSE
//				ls_lookup_entity_name = "N/A"
//			END IF			
//			
//			li_nr = dw_errors.InsertRow( 0 )
//			
//			li_error_cnt++
//			il_error_rec_num[ li_error_cnt ] = i
//			
//			IF ls_lookup_entity_name <> "N/A" THEN
//				st_text.Text = "The following lookup entity did not have an email address associated with it."
//				dw_errors.Modify( "facility_name_t.text = 'Address Lookup Record'" )
//				dw_errors.SetItem( li_nr, "facility_name", ls_lookup_entity_name )	
//			ELSE
//				st_text.Text = "The following practitioners did not have an email address in there address screen."				
//				dw_errors.SetItem( li_nr, "facility_name", ls_facility_name )
//			END IF			
//			cb_continuefax.Text = "Email Pracs with email address."
//			cb_cancelfax.Text = "Cancel Email" 			
//			dw_errors.SetItem( li_nr, "full_name", ls_full_name )	
//		END IF			
//	END FOR	
//
//	st_error_cnt.Text = "There was " + String( li_error_cnt ) + " out of " + String( li_rc ) + " records in error."
//
//	IF li_error_cnt = li_rc THEN
//		cb_continuefax.Enabled = False
//		//--------------------------- APPEON BEGIN ---------------------------
//		//$<comment> 2006-10-12 By: Liu Hongxin
//		//$<reason> fail to send mail, it should change print status.
//		/*
//		cb_yes.Enabled = False
//		*/
//		//---------------------------- APPEON END ----------------------------
//		cb_email.Enabled = False
//	END IF
//
//	IF dw_errors.RowCount( ) > 0 THEN
//		w_ai_print_msg_box.Height = 1475
//		Return -1
//	END IF
//	
//	ab_error_checking	= False		
//	
//END IF
//
//pfc_cst_nv_fax nv_email
//nv_email = CREATE pfc_cst_nv_fax;
//
//OpenWithParm( w_fax_win, is_letter_type + "-" + "Email")
//IF Message.StringParm = "Cancel" THEN
//	Return -1
//END IF
//lg_pass_ids = Message.PowerObjectParm
//
//is_cover_page = lg_pass_ids.s_fax_cover
//is_cover_message = lg_pass_ids.s_fax_message 
//is_subject = lg_pass_ids.s_fax_subject	
//	
////check to see if user wants to print attachments (release, priv stuff )
//of_print_image_document( "File" )
//
//IF ids_letter.DataObject = "d_ltr_expiring_appointment" OR  ids_letter.DataObject = "d_ltr_expiring_provisional" OR ids_letter.DataObject = "d_ltr_expiring_allied_health" THEN
//	gi_burn_annos	= 1
//	w_ai_print_letters.of_Print_Application( True )
//	w_ai_print_letters.ib_app_faxed = True	
//	gi_burn_annos	= 0	
//END IF
//
//li_error_cnt = UpperBound( il_error_rec_num )
//
//FOR i = 1 TO li_rc
//	//messagebox("loop count", i )	
//	lb_error_rec = False
//	FOR e = 1 TO li_error_cnt
//		IF il_error_rec_num[e] = i THEN
//			lb_error_rec = True
//			Exit
//		END IF
//	END FOR
//	IF lb_error_rec THEN
//		CONTINUE
//	END IF
//	
//	IF is_letter_type = "Verif" THEN
//		//grap the name of the school, ins company etc.
//		IF ids_letter.Describe( "entity_name.border" ) <> "!" THEN			
//			ls_company = ids_letter.GetItemString( i, "entity_name" )							
//		ELSEIF ids_letter.Describe( "entity.border" ) <> "!" THEN			
//			ls_company = ids_letter.GetItemString( i, "entity" )							
//		ELSEIF ids_letter.Describe( "address_lookup_entity_name.border" ) <> "!" THEN			
//			ls_company = ids_letter.GetItemString( i, "address_lookup_entity_name" )			
//		ELSE
//			MessageBox("Support", "The " + ids_letter.DataObject + " data object does not have an entity_name field in it.  Call support." )
//			Return -1
//		END IF
//		
//		//grap the name of the contact person at the school, ins company etc.
//		IF ids_letter.Describe( "contact_name.border" ) <> "!" THEN			
//			ls_recipient = ids_letter.GetItemString( i, "contact_name" )							
//		ELSEIF ids_letter.Describe( "address_lookup_contact_name.border" ) <> "!" THEN			
//			ls_recipient = ids_letter.GetItemString( i, "address_lookup_contact_name" )			
//		ELSE
//			//MessageBox("Support", "The " + ids_letter.DataObject + " data object does not have contact_name field in it.  Call support." )
// 			MessageBox("Support", "The " + ids_letter.DataObject + " data object does not have a contact_name field in it.  Call support." )
//			Return -1				
//		END IF
//		//if the address lookup table does not have a contact then put "no data".
//		IF IsNull( ls_recipient ) OR ls_recipient = "" THEN
//			ls_recipient = "No Data"
//		END IF
//		
//	ELSE
//		//grap the name of the practitioner if its a corro or exp or exp appoint letter
//		IF ids_letter.Describe( "v_full_name_full_name.border" ) <> "!" THEN						
//			ls_recipient = ids_letter.GetItemString( i, "v_full_name_full_name" )
//			ls_company = ""				
//		ELSEIF ids_letter.Describe( "full_name.border" ) <> "!" THEN						
//			ls_recipient = ids_letter.GetItemString( i, "full_name" )
//			ls_company = ""			
//		ELSE
//			//MessageBox("Support", "The " + ids_letter.DataObject + " data object does not have FULL NAME field in it.  Call support." )
// 			MessageBox("Support", "The " + ids_letter.DataObject + " data object does not have a FULL NAME field in it.  Call support." )
//			Return -1								
//		END IF
//	END IF
//
//	//grap the email address.  Could be from the prac address or the address lookup table
//	IF ids_letter.Describe( "pd_address_e_mail_address.border" ) <> "!" THEN
//		ls_email = ids_letter.GetItemString( i, "pd_address_e_mail_address" )
//	ELSEIF ids_letter.Describe( "pd_address_email_address.border" ) <> "!" THEN
//		ls_email = ids_letter.GetItemString( i, "pd_address_email_address" )
//	ELSEIF ids_letter.Describe( "address_lookup_email_address.border" ) <> "!" THEN
//		ls_email = ids_letter.GetItemString( i, "address_lookup_email_address" )
//	END IF
//	
//	li_attach_cnt = 1
//	
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<add> 08.08.2006 By: LeiWei
//	//$<reason> Fix a defect.
//	ls_attachments = ls_attachments_null
//	//---------------------------- APPEON END ----------------------------
//
//	// msskinner 15 Dec 2005 -- begin
//	of_get_documents(ls_attachments, "_" + String( i ))
//	/*
//	//NEED TO DO SOMETHING WITH SORTING BY DOC ID THEN LINKING TO email_1, email_2
//	ls_attachments[ li_attach_cnt ] = gs_dir_path + "IntelliCred\fax\fax_" + String( i ) + ".doc"
//
//	IF FileExists( gs_dir_path + "IntelliCred\email\fax_a_" + String( i ) + ".tif" ) THEN
//		li_attach_cnt++
//		ls_attachments[ li_attach_cnt ] = gs_dir_path + "IntelliCred\fax\fax_a_" + String( i ) + ".tif"	
//	END IF
//	
//	IF FileExists( gs_dir_path + "IntelliCred\fax\app_" + String( i ) + ".tif" ) THEN
//		li_attach_cnt++
//		ls_attachments[ li_attach_cnt ] = gs_dir_path + "IntelliCred\fax\app_" + String( i ) + ".tif"			
//	END IF			
//	*/
//	
//	// msskinner 15 Dec 2005 -- end 
//	//IF nv_email.of_email( ls_recipient, ls_company, ls_email, is_subject, is_cover_message, ls_attachments, is_cover_page )	= -1 THEN
//		//messagebox("", "returned -1" )
//		Return -1
//	//END IF
//END FOR
//
//
////structure to return array of records in error
//// start code change --- 11.17.2005 MSKINNER
//IF UpperBound( il_error_rec_num ) = 0 THEN
//	il_error_rec_num[1] = -4   //-5
//END IF
//// end code change --- 11.17.2005 MSKINNER
//lst_email_error_records.il_error_rec_num = il_error_rec_num[]
//
////--------------------------- APPEON BEGIN ---------------------------
////$<modify> 11/02/2007 By: Ken.Guo
////$<reason> Maybe PB Bug,So create this event to post close this window.
////CloseWithReturn( This, lst_email_error_records)
//Post Event ue_post_closewithreturn(lst_email_error_records)
////---------------------------- APPEON END ----------------------------
//
//Return 0
end function

public function long of_get_documents (ref string as_docs[], string as_search);/******************************************************************************************************************
**  [PUBLIC]   : of_get_documents
**==================================================================================================================
**  Purpose   	: Gets all of the documents in the fax directory. The main.doc and mergeddoc.doc are remove
**==================================================================================================================
**  Arguments 	: [string]  as_search
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 03 November 2005  © Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


Integer li_cnt, li_entries
String ls_import
String ls_currdir
long ll_i
string ls_file1[], ls_file2[], ls_file3[]  //add by stephen 12.03.2012 -- Issues with exp appointment letters

SetPointer(HourGlass!)

//---------Begin Modified by (Appeon)Stephen 02.18.2014 for citrix user's temporary file paths in the Letter Printing--------
//ls_currdir = gs_dir_path + "IntelliCred\Fax\*" + as_search + ".*"
ls_currdir = gs_temp_path + "Fax\*" + as_search + ".*"
//---------End Modfiied ------------------------------------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 10/15/2007 By: Ken.Guo
//$<reason> Because of_print_image_document() destroy inv_filesrv,Need Create again.
//li_entries = inv_filesrv.of_DirList(ls_currdir, 0, lnv_dirlist)
If NOT isvalid(inv_filesrv) Then
	inv_filesrv =  create n_cst_filesrvwin32
End If
li_entries = inv_filesrv.of_DirList(ls_currdir, 0, lnv_dirlist)
If isvalid(inv_filesrv) Then Destroy inv_filesrv
//---------------------------- APPEON END ----------------------------

for ll_i = 1 to upperbound(lnv_dirlist)
	//------------------- APPEON BEGIN -------------------
	//$<modify> Stephen 12.03.2012
	//                 Stephen 01.10.2013
	//$<reason> Issues with exp appointment letters (emailed)
    /*
	as_docs[upperbound(as_docs) + 1 ] = gs_dir_path + "IntelliCred\Fax\" + lnv_dirlist[ll_i].is_filename
	//messagebox('',gs_dir_path + "IntelliCred\Fax\" + lnv_dirlist[ll_i].is_filename)
	*/
	if upper(MidA( lnv_dirlist[ll_i].is_filename, LastPos( lnv_dirlist[ll_i].is_filename, ".") + 1)) = 'DOC' OR upper(MidA( lnv_dirlist[ll_i].is_filename, LastPos( lnv_dirlist[ll_i].is_filename, ".") + 1)) ='DOCX' then
		as_docs[upperbound(as_docs) + 1 ] = gs_temp_path + "Fax\" + lnv_dirlist[ll_i].is_filename
	elseif upper(left(lnv_dirlist[ll_i].is_filename, 5)) = 'PRIV_' then
		ls_file2[upperbound(ls_file2) + 1] = gs_temp_path + "Fax\" + lnv_dirlist[ll_i].is_filename
	elseif upper(left(lnv_dirlist[ll_i].is_filename, 4)) = 'APP_' then
		ls_file3[upperbound(ls_file3) + 1] = gs_temp_path + "Fax\" + lnv_dirlist[ll_i].is_filename
	else
		ls_file1[upperbound(ls_file1) + 1] = gs_temp_path + "Fax\" + lnv_dirlist[ll_i].is_filename
	end if	
next
for ll_i = 1 to upperbound(ls_file1)
	as_docs[upperbound(as_docs) + 1 ] = ls_file1[ll_i]
next
for ll_i = 1 to upperbound(ls_file2)
	as_docs[upperbound(as_docs) + 1 ] = ls_file2[ll_i]
next
for ll_i = 1 to upperbound(ls_file3)
	as_docs[upperbound(as_docs) + 1 ] = ls_file3[ll_i]
next
//------------------- APPEON END -------------------	

SetPointer(arrow! )


return 0
end function

public function integer of_fax_email (boolean ab_error_checking, string as_type);//Start Code Change ---- 12.13.06.2006 #V7 maha created to combine of_fax and of_email

Boolean lb_error_rec
String ls_facility_name
String ls_facility_field
String ls_full_name
String ls_name_field
String ls_attachments[]
String ls_attachments_null[]
String ls_recipient
String ls_company
String ls_company_field
String ls_contact_field
String ls_column
String ls_errfield
String ls_value
String ls_no_fax
String ls_lookup_entity_name
String ls_no_email
string ls_cc  //maha 06.27.2013
string ls_doc_id
Integer li_attach_cnt
Integer e
Integer li_nr
Integer li_error
Integer li_error_cnt
Integer li_rtn //alfee 07.10.2014
Long li_rc
Long i
Long f
Long ChanNum
gs_pass_ids  lg_pass_ids
gs_fax_error_records lst_fax_error_records
gs_fax_error_records lst_email_error_records
Long ll_prac_id//Added by  Nova 11.25.2010
pfc_cst_nv_fax nv_emailfax
Long li_msg //(Appeon)Harry 08.11.2014

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04/29/2008 By: Ken.Guo
//$<reason> cb_continuefax.clicked event need use this var.
//ib_faxing_doc = False
IF as_type = "FAX" THEN
	ib_faxing_doc = True
ELSE
	ib_faxing_doc = False
END IF
//---------------------------- APPEON END ----------------------------

//IF all letter records were missing email numbers then return with -2 or Cancel
IF UpperBound( il_error_rec_num ) = ids_letter.RowCount( ) THEN
	lst_email_error_records.il_error_rec_num[1] = -2
	CloseWithReturn( This, lst_email_error_records  )
END IF

li_rc = ids_letter.RowCount( )

//check for needed fields
//grab the field of the school, ins company etc.

IF ids_letter.Describe( "entity_name.border" ) <> "!" THEN
	ls_company_field =  "entity_name"
ELSEIF ids_letter.Describe( "entity.border" ) <> "!" THEN
	ls_company_field =  "entity"
ELSEIF ids_letter.Describe( "address_lookup_entity_name.border" ) <> "!" THEN
	ls_company_field =  "address_lookup_entity_name"
ELSE
	ls_company_field = "N/A"
END IF

IF is_letter_type = "Verif" THEN
	//this test was adapted from the original of_email and has the original logic error that some verif letters may  
	// not require an entity_name field.
	IF ls_company_field = "N/A" THEN
		MessageBox("Support", "The " + ids_letter.DataObject + " data object does not have an entity_name field in it.  Call support." )
		RETURN -1
	END IF
	
	//grab the name of the contact person at the school, ins company etc.
	IF ids_letter.Describe( "contact_name.border" ) <> "!" THEN
		ls_contact_field =  "contact_name"
	ELSEIF ids_letter.Describe( "address_lookup_contact_name.border" ) <> "!" THEN
		ls_contact_field = "address_lookup_contact_name"
	ELSE
		//MessageBox("Support", "The " + ids_letter.DataObject + " data object does not have contact_name field in it.  Call support." )
		MessageBox("Support", "The " + ids_letter.DataObject + " data object does not have a contact_name field in it.  Call support." )
		RETURN -1
	END IF
ELSE
	//grab the name of the practitioner if its a corro or exp or exp appoint letter
	IF ids_letter.Describe( "v_full_name_full_name.border" ) <> "!" THEN
		ls_contact_field = "v_full_name_full_name"
		//ls_company = ""				
	ELSEIF ids_letter.Describe( "full_name.border" ) <> "!" THEN
		ls_contact_field =  "full_name"
		//ls_company = ""			
	ELSE
		//MessageBox("Support", "The " + ids_letter.DataObject + " data object does not have FULL NAME field in it.  Call support." )
		MessageBox("Support", "The " + ids_letter.DataObject + " data object does not have a FULL NAME field in it.  Call support." )
		RETURN -1
	END IF
END IF

//grab tbe email address /fax_number.  Could be from the prac address or the address lookup table

IF as_type = "EMAIL" THEN //email;
	ls_errfield = "n email address" //the n is the second letter of an in the message below
	IF ids_letter.Describe("email_address.ColType") = "!"	THEN
		IF ids_letter.Describe("e_mail_address.ColType") = "!"	THEN
			IF ids_letter.Describe("pd_address_e_mail_address.ColType") = "!"	THEN
				IF ids_letter.Describe("pd_prof_experience_e_mail_address.ColType") = "!"	THEN //Add By Jervis 12-10-2008 for professional experience
					MessageBox("Support", "The " + ids_letter.DataObject + " data object does not have a field called 'email_address' or 'e_mail_address'.  Contact IntelliSoft support to have this corrected for a later build.  You cannot email this letter type." )
					RETURN -1
				ELSE
					ls_column = "pd_prof_experience_e_mail_address"
				END IF
			ELSE
				ls_column = "pd_address_e_mail_address"
			END IF
		ELSE
			ls_column = "e_mail_address"
		END IF
	ELSE
		ls_column = "email_address"
	END IF
ELSEIF  as_type = "FAX" THEN //fax
	//get the fax field.  Could be from the prac address or the address lookup table
	ls_errfield = " fax number"
	IF ids_letter.Describe( "fax.border" ) <> "!" THEN
		ls_column = "fax"
	ELSEIF ids_letter.Describe( "pd_address_fax.border" ) <> "!" THEN
		ls_column = "pd_address_fax"
	ELSEIF ids_letter.Describe( "address_lookup_fax.border" ) <> "!" THEN
		ls_column = "address_lookup_fax"
	ELSEIF ids_letter.Describe( "pd_prof_experience_fax.border") <> "!" THEN //Add By Jervis 12-10-2008 for professional experience
		ls_column =  "pd_prof_experience_fax"
	ELSE
		MessageBox("Support", "The " + ids_letter.DataObject + " data object does not have a fax number field in it.  Call support." )
		RETURN -1
	END IF
ELSE
	RETURN 1
END IF

IF ids_letter.Describe( "facility_facility_name.border" ) <> "!" THEN
	ls_facility_field =  "facility_facility_name"
ELSEIF ids_letter.Describe( "facility_name.border" ) <> "!" THEN
	ls_facility_field = "facility_name"
ELSEIF ids_letter.Describe( "facility_return_facility_name.border" ) <> "!" THEN
	ls_facility_field = "facility_return_facility_name"
	//Start Code Change ----04.08.2008 #V8 maha
ELSEIF ids_letter.Describe( "creturn_facility_name.border" ) <> "!" THEN
	ls_facility_field = "creturn_facility_name"
	//End Code Change---04.08.2008
ELSE
	//MessageBox("Support", "The " + ids_letter.DataObject + " data object does not have an facility_name field in it.  Call support." )
	MessageBox("Support", "The " + ids_letter.DataObject + " data object does not have a facility_name field in it.  Call support." )
	RETURN -1
END IF

IF ids_letter.Describe( "v_full_name_full_name.border" ) <> "!" THEN
	ls_name_field =  "v_full_name_full_name"
ELSEIF ids_letter.Describe( "full_name.border" ) <> "!" THEN
	ls_name_field = "full_name"
ELSE
	//MessageBox("Support", "The " + ids_letter.DataObject + " data object does not have an full_name field in it.  Call support." )
	MessageBox("Support", "The " + ids_letter.DataObject + " data object does not have a full_name field in it.  Call support." )
	RETURN -1
END IF


//preprocess list to make sure the appropriate info is there to email/fax
IF ab_error_checking THEN
	FOR i = 1 To li_rc
		//if its a corro letter then check to see if the prac address has a email number
		ls_value =  ids_letter.GetItemString( i, ls_column )
		IF IsNull( ls_value ) Or ls_value = "" THEN //if there is no email or fax address
			//facility data
			ls_facility_name = ids_letter.GetItemString( i, ls_facility_field )
			//full name field
			ls_full_name = ids_letter.GetItemString( i, ls_name_field )
			//if a valid entity name field get the data
			IF ls_company_field = "N/A" THEN
				ls_lookup_entity_name = "N/A"
			ELSE
				ls_lookup_entity_name =  ids_letter.GetItemString( i, ls_company_field )
			END IF
			
			li_nr = dw_errors.InsertRow( 0 )
			
			li_error_cnt++
			il_error_rec_num[ li_error_cnt ] = i
			
			IF ls_lookup_entity_name <> "N/A" THEN //if a verif letter with an entity name field
				st_text.Text = "The following lookup Entity did not have a" + ls_errfield + " associated with it."
				dw_errors.Modify( "facility_name_t.text = 'Address Lookup Record'" )
				dw_errors.SetItem( li_nr, "facility_name", ls_lookup_entity_name )
			ELSE
				st_text.Text = "The following practitioners did not have a" + ls_errfield + " in their address screen."
				dw_errors.SetItem( li_nr, "facility_name", ls_facility_name )
			END IF
			
			IF as_type = "EMAIL" THEN
				cb_continuefax.Text = "Email Pracs with email address."
				cb_cancelfax.Text = "Cancel Email"
			ELSEIF as_type = "FAX" THEN
				cb_continuefax.Text = "Fax Pracs with Fax numbers."
				cb_cancelfax.Text = "Cancel Fax"
			END IF
			
			dw_errors.SetItem( li_nr, "full_name", ls_full_name )
		END IF
	NEXT
	
	st_error_cnt.Text = "There were " + String( li_error_cnt ) + " out of " + String( li_rc ) + " records in error."
	
	IF li_error_cnt = li_rc THEN
		cb_continuefax.Enabled = False
		//--------------------------- APPEON BEGIN ---------------------------
		//$<comment> 2006-10-12 By: Liu Hongxin
		//$<reason> fail to send mail, it should change print status.
		/*
		cb_yes.Enabled = False
		*/
		//---------------------------- APPEON END ----------------------------
		cb_email.Enabled = False
	END IF
	
	IF dw_errors.RowCount( ) > 0 THEN
		//---------Begin Modified by (Appeon)Stephen 04.15.2015 for Bug 4486 for Case # 00053256: FW: IC issue --------
		//w_ai_print_msg_box.Height = 1600   //1475  maha 11.14.2013
		w_ai_print_msg_box.Height = 1775
		//---------End Modfiied ------------------------------------------------------
		cb_yes.enabled = false  //Start Code Change ----01.13.2014 #V14 maha  - added to prevent re-clicking the continue button
		RETURN -1
	END IF
	
	ab_error_checking	 = False
	
END IF


nv_emailfax = Create pfc_cst_nv_fax;

IF as_type = "EMAIL" THEN
	OpenWithParm( w_fax_win, is_letter_type + "-" + "Email")
ELSEIF as_type = "FAX" THEN
	OpenWithParm( w_fax_win, is_letter_type )
END IF

IF Message.StringParm = "Cancel" THEN
	Destroy nv_emailfax
	RETURN -1
END IF
lg_pass_ids = Message.PowerObjectParm

is_cover_page = lg_pass_ids.s_fax_cover
is_cover_message = lg_pass_ids.s_fax_message
is_subject = lg_pass_ids.s_fax_subject
ls_cc =  lg_pass_ids.s_stringval  //Start Code Change ----06.27.2013 #V14 maha

//check to see if user wants to print attachments (release, priv stuff )
of_print_image_document( "File" )

for i = 1 to li_rc  //add by stephen 10.09.2013 for bug id 3688	
	IF ids_letter.DataObject = "d_ltr_expiring_appointment" Or  ids_letter.DataObject = "d_ltr_expiring_provisional" Or ids_letter.DataObject = "d_ltr_expiring_allied_health" THEN
		gi_burn_annos	 = 1
		//---------Begin Added by (Appeon)Stephen 10.09.2013 for bug id 3688	--------
		ls_doc_id = ids_letter.getitemstring(i, "doc_id")
		w_ai_print_letters.is_docid = ls_doc_id
		w_ai_print_letters.ii_num = i 
		//---------End Added ------------------------------------------------------
		
		//---------------------------APPEON BEGIN-------------------------------
		//$<modify> stephen 12.03.2012
		//$<reason> Issues with exp appointment letters
		w_ai_print_letters.of_Print_Application( True, ls_doc_id )  //restored by stephen 10.10.2013
		/*	if cbx_release.checked or as_type = "FAX" then 
			w_ai_print_letters.of_Print_Application( True )
		else
			w_ai_print_letters.of_Print_Application( false )
		end if	*/
		//---------------------------APPEON END---------------------------------
		
		w_ai_print_letters.ib_app_faxed = True
		
		//---------------------------APPEON BEGIN-------------------------------
		//$<add> long.zhang 02.07.2012
		//$<reason>Reappointment Packet Modification
		w_ai_print_letters.of_print_priv_form(True, ls_doc_id)
		w_ai_print_letters.ib_priv_faxed = TRUE
		//---------------------------APPEON END---------------------------------
		gi_burn_annos	 = 0
	END IF
next

li_error_cnt = UpperBound( il_error_rec_num )

FOR i = 1 To li_rc
	lb_error_rec = False
	FOR e = 1 To li_error_cnt
		IF il_error_rec_num[e] = i THEN
			lb_error_rec = True
			EXIT
		END IF
	NEXT
	IF lb_error_rec THEN
		CONTINUE
	END IF
	
	IF is_letter_type = "Verif" THEN
		//grab the name of the school, ins company etc.
		ls_company = ids_letter.GetItemString( i, ls_company_field )
		ls_recipient = ids_letter.GetItemString( i,ls_contact_field )
		//if the address lookup table does not have a contact then put "no data".
		IF IsNull( ls_recipient ) Or ls_recipient = "" THEN
			ls_recipient = "No Data"
		END IF
	ELSE
		//grab the name of the practitioner if its a corro or exp or exp appoint letter
		ls_recipient = ids_letter.GetItemString( i, ls_name_field )
		ls_company = ""
	END IF
	
	li_attach_cnt = 1
	
	ls_attachments = ls_attachments_null
	
	of_get_documents(ls_attachments, "_" + String( i ))
	String ls_errtext
	ls_value =  ids_letter.GetItemString( i, ls_column ) //Added By Ken.Guo 04.18.2008. Must get this value again in loop.
	ll_prac_id = ids_letter.GetItemNumber( i, "prac_id" )//Added by  Nova 11.25.2010
	
	IF as_type = "EMAIL" THEN
		//IF nv_emailfax.of_email( ls_recipient, ls_company, ls_value, is_subject, is_cover_message, ls_attachments, is_cover_page)	 = -1 THEN
		//IF nv_emailfax.of_email( ls_recipient, ls_company, ls_value, is_subject, is_cover_message, ls_attachments, is_cover_page, lg_pass_ids.email_id,ll_prac_id )	 = -1 THEN //modify by stephen 09.27.2011 Editing Fax Template while in process - Bug id 2668
		//---------Begin Modified by (Appeon)Alfee 07.10.2014---------------------------
		//IF nv_emailfax.of_email_new( ls_recipient, ls_company, ls_value, is_subject, is_cover_message, ls_attachments, is_cover_page, lg_pass_ids.email_id,ll_prac_id, lg_pass_ids.b_attach , ls_cc )	 = -1 THEN //Start Code Change ----06.27.2013 #V14 maha - added ls_cc argument
			//Destroy nv_emailfax
			//RETURN -1
		//END IF
		
		//---------Begin Modified by (Appeon)Harry 08.11.2014 Email Failed Again--------
		//li_rtn = nv_emailfax.of_email_new( ls_recipient, ls_company, ls_value, is_subject, is_cover_message, ls_attachments, is_cover_page, lg_pass_ids.email_id,ll_prac_id, lg_pass_ids.b_attach , ls_cc )
		DO 
			li_rtn = nv_emailfax.of_email_new( ls_recipient, ls_company, ls_value, is_subject, is_cover_message, ls_attachments, is_cover_page, lg_pass_ids.email_id,ll_prac_id, lg_pass_ids.b_attach , ls_cc )
			IF  li_rtn <> 1 THEN
				of_emaillog(is_subject, ls_attachments, lg_pass_ids.email_id,ll_prac_id)
			END IF
			IF li_rtn = -30 or li_rtn = -7 THEN  //(Appeon)Harry 09.26.2014 - Email Error - add "or li_rtn = -7"
				li_msg = messagebox("Prompt","Try again!", Exclamation!, RetryCancel!, 2)
				IF li_msg = 2 THEN
					Destroy nv_emailfax
					RETURN -1
				END IF
			ELSE
				li_msg = 2
			END IF
		LOOP WHILE li_msg = 1
		//---------End Modfiied ------------------------------------------------------
		IF li_rtn = -1 THEN 
			Destroy nv_emailfax
			RETURN -1
		ELSEIF li_rtn = -8 THEN
			li_error_cnt = UpperBound( il_error_rec_num ) + 1
			il_error_rec_num[li_error_cnt] = i 		
		END IF
		//---------End Modfiied ---------------------------------------------------------------				
	ELSEIF as_type = "FAX" THEN
		//Start Code Change ----01.21.2015 #V14.2 maha - code for fax prefix numbers (set_83) is in n_cst_msfax.of_send_fax().
		
		IF nv_emailfax.of_fax( ls_recipient, ls_company, ls_value, is_subject, is_cover_message, ls_attachments, is_cover_page,ls_errtext )	 = -1 THEN
			MessageBox('Fax Send',ls_errtext)
			Destroy nv_emailfax
			RETURN -1
		END IF
	END IF
NEXT


//structure to return array of records in error
IF UpperBound( il_error_rec_num ) = 0 THEN
	//------------------- APPEON BEGIN -------------------
	//$<modify> Stephen 08.26.2011
	//$<reason> Checklist attempts incorrect -Bug id 2585
	/*
	il_error_rec_num[1] = -4 //-5
	*/
	choose case as_type
		case 'EMAIL'
			il_error_rec_num[1] = -4
		case 'FAX'
			il_error_rec_num[1] = -5
		case else
			il_error_rec_num[1] = -2
	end choose
	//------------------- APPEON END -------------------
END IF
Destroy nv_emailfax
lst_email_error_records.il_error_rec_num = il_error_rec_num[]
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 11/02/2007 By: Ken.Guo
//$<reason> Maybe PB Bug,So create this event to post close this window.
//CloseWithReturn( This, lst_email_error_records)
Post Event ue_post_closewithreturn(lst_email_error_records)
//---------------------------- APPEON END ----------------------------



RETURN 0




end function

public function integer of_is_word_open ();//Start Code Change ---- 12.1302006 #V7 maha created function called from timer and yes button

ulong l_handle
string ls_wname
string ls_test
integer li_word_open = 0
integer i

for i = 1 to 16
	choose case i
		case 1
			ls_wname = "IntelliCred Letter Generation"
		case 2
			ls_wname = "Microsoft Word"
		case 3
			ls_wname = "IntelliCred Letter Generation - Verification Letter (Preview)"
		case 4
			 ls_wname = "IntelliCred Letter Generation - Verification Letter"
		case 5
			ls_wname = "Microsoft Word - Verification Letter"
		case 6
			ls_wname = "Microsoft Word - Verification Letter (Preview)"
		case 7
			//ls_wname = is_letter_name
			ls_wname = is_document  //Start Code Change ---- 10.25.2007 #V7 maha
		case 8 
			ls_wname = "Microsoft Word - Labels1"
		case 9
			ls_wname = "Microsoft Word - Form Letters1"
		case 10
			ls_wname = "- Microsoft Word"
		case 11
			ls_wname = ' ' + TRIM(LOWER(is_letter_name)) +   " - Microsoft Word"
		case 12 ////Start Code Change ---- 09.10.2007 #V7 maha
			ls_wname =  TRIM(LOWER(is_letter_name)) +   ".doc - Microsoft Word"
		Case 13 //Added by Ken.Guo 11/01/2007
			ls_wname = is_document + " - Microsoft Word"
		Case 14 //Added by Ken.Guo 11/01/2007
			ls_wname = 	is_document + ' /mpreview'  
		Case 15 //Added by Ken.Guo 11/01/2007
			ls_wname = 	is_document + ' /mpreview' + " - Microsoft Word"
		Case 16 //Start Code Change ----03.29.2013 V12 maha
			ls_wname =  ' ' + TRIM(LOWER(is_letter_name)) +   " [Compatability Mode] - Microsoft Word"
	end choose
	l_handle = FindWindowA(0, ls_wname)
	IF l_handle > 0 THEN
		li_word_open = 1
		ls_test = ls_wname
		//messagebox(string (i),ls_test)
		exit
	END IF
next
//messagebox("window",li_word_open)
return li_word_open
end function

public function long of_find_image_id (integer ai_type, long al_prac, long al_fac);//Start Code Change ----03.29.2011 #V11 maha - added for new image functionalty
datastore lds_image
integer r
integer f
long ll_id


lds_image = create datastore

lds_image.dataobject =  "d_pd_image_list_from_type"

lds_image.settransobject(sqlca)

//get all images of the type for the prac
r = lds_image.retrieve(al_prac, ai_type)

if r < 1 then
	ll_id =  -1
else 
	//first look for facility specific
	f =  lds_image.find( "pd_images_facility_id = " + string(al_fac), 1,10000)
	
	if f > 0 then
		ll_id = lds_image.getitemnumber( f ,"image_pk")
	elseif f =  0 then //then look for aa 'all'
		f =  lds_image.find( "pd_images_facility_id = 0", 1,10000)
		
		if f > 0 then
			ll_id = lds_image.getitemnumber( f ,"image_pk")
		else
			ll_id = -1
		end if
	end if
end if

destroy lds_image

return ll_id
	


end function

public function integer of_retrieve_image_from_db (integer ai_activestatus, integer ai_imagetypeid, long al_pracid, long al_facid);//////////////////////////////////////////////////////////////////////
// $<function>w_ai_print_msg_box.of_retrieve_image_from_db()
// $<arguments>
//		integer	ai_activestatus		
//		integer	ai_imagetypeid 		
//		long   	al_pracid      		
// $<returns> integer
// $<description> Get image file from pd_image.
//////////////////////////////////////////////////////////////////////
// $<add> 06.08.2006 by Rodger Wu
//////////////////////////////////////////////////////////////////////
//Start Code Change ----04.28.2011 #V11 maha - added al_facid argument for images

Long li_filenum
Long ll_filelen
Long ll_bytes_written
Long ll_new_pos
long ll_id
Integer li_loops
Integer li_counter
Integer li_retval
Blob  lb_image_data
Blob blob_temp
Blob lb_tot_b
Blob total_blob
Blob blank_blob

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 08.19.2006 By: LeiWei
//$<reason> Fix a defect.
/*
SELECTBLOB top 1 image_data
INTO :lb_image_data
FROM pd_images
WHERE prac_id = :al_pracid
AND active_status= :ai_activestatus
AND image_type_id = :ai_imagetypeid
USING SQLCA;
*/
//Start Code Change ----03.29.2011 #V11 maha - added to get a single image id - only works for images set to facility 0
ll_id = of_find_image_id(ai_imagetypeid,al_pracid, al_facid)
il_image_pk = ll_id

IF appeongetclienttype() = 'PB' AND gs_dbtype = 'SQL' THEN
	of_get_image_pd_images2(ll_id, lb_image_data) //Start Code Change ----03.29.2011 #V11 maha - change from of_get_image_pd_images1
ELSE
//Start Code Change ----03.29.2011 #V11 maha - modified SQL
//	SELECTBLOB image_data
//	INTO :lb_image_data
//	FROM pd_images
//	WHERE prac_id = :al_pracid
//	AND active_status= :ai_activestatus
//	AND image_type_id = :ai_imagetypeid
//	USING SQLCA;
	SELECTBLOB image_data
	INTO :lb_image_data
	FROM pd_images
	WHERE image_pk = :ll_id
	USING SQLCA;
END IF

//End Code Change ----03.29.2011 
//---------------------------- APPEON END ----------------------------

Choose Case SQLCA.SQLCODE
	Case -1
		MessageBox( "SQL ERROR", SQLCA.SQLERRTEXT )
		Return -1
	Case 100
		Return -1
End Choose

ll_filelen = LenA( lb_image_data )

IF ll_filelen > 32765 THEN 
  	 IF Mod(ll_filelen,32765) = 0 THEN 
        li_loops = ll_filelen/32765 
    ELSE 
  	     li_loops = (ll_filelen/32765) + 1 
    END IF 
ELSE 
  	 li_loops = 1 
END IF 
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 06.14.2007 By: Jack
//$<reason> Fix a defect.
/*
FileDelete( gs_dir_path + "temp.tif" )

li_filenum =  FileOpen( gs_dir_path + "temp.tif", StreamMode!, Write!, LockWrite!, Append!)
*/
string ls_file
//---------Begin Modified by (Appeon)Stephen 02.18.2014 for citrix user's temporary file paths in the Letter Printing--------
//ls_file = gs_dir_path + "\intellicred\Images\"
ls_file = gs_temp_path + "Images\"
if not directoryexists(ls_file) then createdirectory(ls_file)
//---------End Modfiied ------------------------------------------------------

//Added by (APPEON) Harry 11.15.2017 (V161 Storage of Documents as PDFs)
SELECT image_ext	 INTO :is_ext FROM pd_images WHERE image_pk = :ll_id USING SQLCA;
IF IsNull(is_ext) THEN is_ext = 'TIF'  //Added by (APPEON) Harry 12.08.2017 

gnv_appeondll.of_parsepath(ls_file)
//ls_file = ls_file + "temp.tif"
ls_file = ls_file + "temp." + lower(is_ext) //Modified by (APPEON) Harry 11.15.2017 (V161 Storage of Documents as PDFs)

//FileDelete( ls_file)
If FileExists( ls_file) Then //modified by Appeon long.zhang 03.21.2017 (Bug ID #5512 for Case #00068932 Case 55841 Emailing Peer References)
	If Not FileDelete( ls_file) Then
		MessageBox("Error in of_retrieve_image_from_db", "Error with FileDelete command.  Return -1." )
		Return -1
	End If
End If

li_filenum =  FileOpen( ls_file, StreamMode!, Write!, LockWrite!, Append!)
//---------------------------- APPEON END ----------------------------

ll_new_pos = 1

IF li_filenum <> -1 THEN	
	//read the file ... 
	FOR li_counter = 1 to li_loops 
		 blob_temp = BlobMid( lb_image_data, ll_new_pos, 32765 )
   	 	 ll_bytes_written = FileWrite( li_filenum, blob_temp) 		 
		 IF ll_bytes_written = -1 THEN
			MessageBox("Error in of_retrieve_image_from_db", "Error with FileRead command.  Return -1." )
			Return -1
		 END IF
	     lb_tot_b = lb_tot_b + blob_temp 
   		 ll_new_pos = ll_new_pos + ll_bytes_written 
	    //FileSeek(li_filenum, 0, FROMEND!) 
   	 	if LenA(lb_tot_b) > 1000000 then 
	        total_blob = total_blob + lb_tot_b 
   	     lb_tot_b = blank_blob 
	    end if 
	NEXT 

	total_blob = total_blob + lb_tot_b 

	lb_image_data = total_blob
	
	FileClose( li_filenum )

ELSE
	MessageBox( "File Open Error in of_retrieve_image_from_db", "Could not open the Document file" )
	Return -	1
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 06.14.2007 By: Jack
//$<reason> Fix a defect.
/*
IF Not FileExists( gs_dir_path + "temp.tif" ) THEN
	MessageBox("File Creation Error", "No image file created.  Check to make sure the directory " + gs_dir_path + " is valid." )
	Return -1;
END IF
*/
IF Not FileExists( ls_file ) THEN
	MessageBox("File Creation Error in in of_retrieve_image_from_db", "No image file created.  Check to make sure the directory " + gs_dir_path + "\intellicred\Images\  is valid." )
	Return -1;
END IF
//---------------------------- APPEON END ----------------------------
Return 1;
end function

public subroutine of_set_process (string as_type);

Choose case as_type
	case "E"
		rb_email.checked = true
		rb_email.triggerevent(Clicked!)
	case "F"
		rb_fax.checked = true
		rb_fax.triggerevent(Clicked!)
	case Else
		rb_print.checked = true
		rb_print.triggerevent(Clicked!)
end choose
end subroutine

public subroutine of_emaillog (string as_subject, string as_attachments[], long al_email_id, long al_prac_id);//////////////////////////////////////////////////////////////////////
// $<function>w_ai_print_msg_box.of_email_retry()
// $<arguments>   	
//		string		as_subject
//		string		as_attachments[]
//		long		al_email_id
//		long		al_prac_id
// $<returns> NONE
// $<description> .
//////////////////////////////////////////////////////////////////////
// $<add> 08.11.2014 by Harry 
//////////////////////////////////////////////////////////////////////
Long i
String ls_attachments
String ls_EmailLogFile
Long ll_EmailLogFileHandle
For i = 1 To UpperBound(as_attachments)
	If i = 1 Then
		ls_attachments = as_attachments[i]
	Else
		ls_attachments = ls_attachments + ',' +as_attachments[i]
	End If
Next

ls_EmailLogFile = gs_dir_path + gs_DefDirName + "\EmailDebug.log"
If NOT directoryexists( gs_dir_path + gs_DefDirName) Then
createdirectory( gs_dir_path + gs_DefDirName)
End If
ll_EmailLogFileHandle = FileOpen(ls_EmailLogFile,StreamMode!,write!,shared!,append!)
FileWrite(ll_EmailLogFileHandle,"~r~n"+ "Subject = " + as_subject)
FileWrite(ll_EmailLogFileHandle,"~r~n"+ "Attachments = " + ls_attachments)
FileWrite(ll_EmailLogFileHandle,"~r~n"+ "Email ID = " + String(al_email_id))
FileWrite(ll_EmailLogFileHandle,"~r~n"+ "Prac ID = " + String(al_prac_id))
FileClose(ll_EmailLogFileHandle)
end subroutine

public function integer of_check_rec_counts (string as_type); //Start Code Change ----05.06.2015 #V15 maha - created to prevent fax/email issues when using an export
 string s
 
 if ib_export_used then
	if ids_letter.rowcount() <> gl_export_rows_count then
		s = "The count between the export records (" +  string(gl_export_rows_count) + ") and the contact information records (" + string( ids_letter.rowcount()) + ") do not agree.  Emailing or faxing could cause mis-distributed letters to providers.  " + as_type + " function canceled."    
		if ids_letter.rowcount() > gl_export_rows_count then  //Start Code Change ----08.01.2016 #V152 maha
			s+= "~rNote: there appears to be multiple addresses for one or more providers.  Click the View Letter Records button on the Process Documents screen to help identify which provider(s) may be causing this."
		end if
		messagebox("Data error", s)
		return -1
	end if	
end if

return 1
end function

event open;call super::open;inv_filesrv = create n_cst_filesrvwin32

Long f
Integer li_cnt = 0
integer li_exp

gs_fax lgs_fax

lgs_fax = Message.PowerObjectParm

is_msg = lgs_fax.ss_message
is_letter_name = lgs_fax.ss_letter_name
ids_letter = lgs_fax.sdw_letter
is_mail_label_doc = lgs_fax.ss_mail_label_doc
is_letter_type = lgs_fax.ss_letter_type
is_document = lgs_fax.ss_letter_document_name  //Start Code Change ---- 10.25.2007 #V7 maha
is_merge_file_path = lgs_fax.ss_merge_file_path //Added By Ken.Guo 03.25.2008. Recieve it from w_letter_generator.of_run()
st_msg.Text = "Generating Microsoft Word Merge Letter"
if lgs_fax.ss_process_type = "Export" then ib_export_used = true   //Start Code Change ----05.06.2015 #V15 maha

//Start Code Change ----02.10.2015 #V14.2 maha
li_exp = integer(lgs_fax.ss_index)
if li_exp = 1 then st_export_msg.visible = true
//Start Code Change ----02.10.2015

of_set_process( lgs_fax.ss_process_type )  //Start Code Change ----07.09.2013 #V14 maha

//---------Begin Added by (Appeon)Stephen 02.18.2014 for citrix user's temporary file paths in the Letter Printing--------
if gi_citrix = 1 then
	is_old_docpath = gnv_app.gnvlo_msword.is_directory
	gnv_app.gnvlo_msword.is_directory = gs_temp_path +"fax\"				
	if NOT DirectoryExists(gnv_app.gnvlo_msword.is_directory) then CreateDirectory(gnv_app.gnvlo_msword.is_directory)
end if
//---------End Added ------------------------------------------------------

//------------------- APPEON BEGIN -------------------
//$<modify> Stephen 11.20.2012
//$<reason> 
/* Bug 3316 -Issues with Faxing combine
gnv_app.gnvlo_msword.of_delete_fax_documents( )
*/
if gnv_app.gnvlo_msword.of_delete_fax_documents( )= -1 then
	//close(this)
end if
//------------------- APPEON END -------------------

ib_fax_docs_created = false //(Appeon)Stephen 09.26.2017 - Question on Emailing Combine Functionailty
Timer(1)

end event

on w_ai_print_msg_box.create
int iCurrent
call super::create
this.st_export_msg=create st_export_msg
this.cb_view=create cb_view
this.rb_fax=create rb_fax
this.rb_email=create rb_email
this.rb_print=create rb_print
this.ole_print=create ole_print
this.ole_admin=create ole_admin
this.st_msg=create st_msg
this.cb_yes=create cb_yes
this.cbx_mail=create cbx_mail
this.cbx_priv=create cbx_priv
this.cbx_release=create cbx_release
this.cb_print=create cb_print
this.cb_continuefax=create cb_continuefax
this.cb_cancelfax=create cb_cancelfax
this.st_text=create st_text
this.uo_print_app=create uo_print_app
this.dw_errors=create dw_errors
this.st_error_cnt=create st_error_cnt
this.cb_fax=create cb_fax
this.cb_1=create cb_1
this.cb_no=create cb_no
this.cb_email=create cb_email
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_export_msg
this.Control[iCurrent+2]=this.cb_view
this.Control[iCurrent+3]=this.rb_fax
this.Control[iCurrent+4]=this.rb_email
this.Control[iCurrent+5]=this.rb_print
this.Control[iCurrent+6]=this.ole_print
this.Control[iCurrent+7]=this.ole_admin
this.Control[iCurrent+8]=this.st_msg
this.Control[iCurrent+9]=this.cb_yes
this.Control[iCurrent+10]=this.cbx_mail
this.Control[iCurrent+11]=this.cbx_priv
this.Control[iCurrent+12]=this.cbx_release
this.Control[iCurrent+13]=this.cb_print
this.Control[iCurrent+14]=this.cb_continuefax
this.Control[iCurrent+15]=this.cb_cancelfax
this.Control[iCurrent+16]=this.st_text
this.Control[iCurrent+17]=this.uo_print_app
this.Control[iCurrent+18]=this.dw_errors
this.Control[iCurrent+19]=this.st_error_cnt
this.Control[iCurrent+20]=this.cb_fax
this.Control[iCurrent+21]=this.cb_1
this.Control[iCurrent+22]=this.cb_no
this.Control[iCurrent+23]=this.cb_email
this.Control[iCurrent+24]=this.gb_1
this.Control[iCurrent+25]=this.gb_2
end on

on w_ai_print_msg_box.destroy
call super::destroy
destroy(this.st_export_msg)
destroy(this.cb_view)
destroy(this.rb_fax)
destroy(this.rb_email)
destroy(this.rb_print)
destroy(this.ole_print)
destroy(this.ole_admin)
destroy(this.st_msg)
destroy(this.cb_yes)
destroy(this.cbx_mail)
destroy(this.cbx_priv)
destroy(this.cbx_release)
destroy(this.cb_print)
destroy(this.cb_continuefax)
destroy(this.cb_cancelfax)
destroy(this.st_text)
destroy(this.uo_print_app)
destroy(this.dw_errors)
destroy(this.st_error_cnt)
destroy(this.cb_fax)
destroy(this.cb_1)
destroy(this.cb_no)
destroy(this.cb_email)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event timer;boolean lb_word_open
integer li_check

//Start Code Change ---- 12.13.2006 #V7 maha
if not ib_skip then
	gnv_app.gnvlo_msword.of_set_focus( )
	ib_skip = true
end if 

li_timeout = li_timeout + 1
//if li_timeout > 10 then return//maha 121306 skip rest of code

li_check =  of_is_word_open( )
if li_check = 1 then lb_word_open = true

//default timeout 8 seconds
if li_timeout > 8 then lb_word_open = true

IF not lb_word_open THEN // not opened
	IF st_msg.Visible = False THEN //flash message on and off
		st_msg.Visible = True	
	ELSE
		st_msg.Visible = False
	END IF
	cb_yes.Enabled = False
	cb_no.Enabled = False
ELSE
	st_msg.Visible = True
	cb_yes.Enabled = True
	cb_no.Enabled = True	
	st_msg.Text = is_msg
	Timer(0) //Ken.Guo 11/01/2007
END IF
//End Code Change---12.13.2006

end event

event close;call super::close;If isvalid(inv_filesrv) Then Destroy inv_filesrv
gnv_app.gnvlo_msword.of_dissconnect_from_word( )
if gi_citrix = 1 then gnv_app.gnvlo_msword.is_directory = is_old_docpath //(Appeon)Stephen 02.18.2014 - citrix user's temporary file paths in the Letter Printing
end event

type st_export_msg from statictext within w_ai_print_msg_box
boolean visible = false
integer x = 87
integer y = 648
integer width = 2368
integer height = 104
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "This letter is using an export as a data source.  The default sort will be by prac_id.  If you change the sort in the Word Document click the View Letter Records and changer the sort there as well."
boolean focusrectangle = false
end type

type cb_view from commandbutton within w_ai_print_msg_box
integer x = 1394
integer y = 316
integer width = 539
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "View Letter Records"
end type

event clicked;//Start Code Change ----02.04.2015 #V14.2 maha
gs_variable_array lst_array
integer r
string ls_filter


lst_array.as_ds[1] = ids_letter


openwithparm(w_view_letter_verifs, lst_array)
end event

type rb_fax from radiobutton within w_ai_print_msg_box
integer x = 859
integer y = 344
integer width = 315
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Fax"
end type

event clicked;cbx_mail.visible = false
end event

type rb_email from radiobutton within w_ai_print_msg_box
integer x = 512
integer y = 344
integer width = 402
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Email"
end type

event clicked;cbx_mail.visible = false
end event

type rb_print from radiobutton within w_ai_print_msg_box
integer x = 178
integer y = 344
integer width = 402
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Print"
end type

event clicked;cbx_mail.visible = true
end event

type ole_print from olecustomcontrol within w_ai_print_msg_box
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
boolean visible = false
integer x = 2208
integer y = 500
integer width = 187
integer height = 200
integer taborder = 50
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_ai_print_msg_box.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

type ole_admin from olecustomcontrol within w_ai_print_msg_box
event filepropertiesclose ( )
boolean visible = false
integer x = 2025
integer y = 484
integer width = 155
integer height = 136
integer taborder = 50
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_ai_print_msg_box.win"
integer binaryindex = 1
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

type st_msg from statictext within w_ai_print_msg_box
integer x = 69
integer y = 36
integer width = 2007
integer height = 224
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_yes from commandbutton within w_ai_print_msg_box
integer x = 2117
integer y = 40
integer width = 398
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "&Continue"
boolean default = true
end type

event clicked;//Start Code Change ----06.27.2013 #V14 maha - simplified funcitonality
String ls_retval

if rb_email.checked then 
	if of_check_rec_counts("Email") < 1 then return   //Start Code Change ----05.06.2015 #V15 maha
	cb_email.triggerevent(clicked!)
elseif rb_fax.checked then
	if of_check_rec_counts("Fax") < 1 then return  //Start Code Change ----05.06.2015 #V15 maha
	cb_fax.triggerevent(clicked!)
else //letter
	ls_retval = "1"
	of_print_image_document( "Print" )

	gs_fax_error_records lst_fax_error_records
	lst_fax_error_records.il_error_rec_num[1] = 0
	CloseWithReturn( Parent, lst_fax_error_records  )
end if


//@@ORG Code@@@@@@@@@@@@

//li_click_times++
//
//
//IF li_click_times = 1 THEN  //when Yes is clicked
////	if of_is_word_open( ) = 1 then //check to see if word is still open; if so enable the email/fax buttons maha 121306
//		cb_fax.Enabled = True	//function call does not work properly so will always = 1
//		cb_email.Enabled = True
////	else
////		cb_fax.Enabled = false
////		cb_email.Enabled = false
////	end if
//	
//	This.Text = "Continue" 
//
//	IF FileExists( gs_dir_path + "IntelliCred\Fax\fax_1.doc" ) THEN
//		//cb_fax.Enabled = True mbs - fax mod
//		cb_email.Enabled = True
//		IF ids_letter.Describe( "fax.width" ) = "!" AND ids_letter.Describe( "pd_address_fax.width" ) = "!" AND ids_letter.Describe( "address_lookup_fax.width" ) = "!" THEN
//			//cb_fax.Enabled = False mbs - fax mod
//		END IF
//		IF ids_letter.Describe( "pd_address_e_mail_address.width" ) = "!" THEN		
//			cb_email.Enabled = False			
//			Return -1
//		END IF	
//		cb_no.Enabled = False
//	END IF
//	st_msg.Visible = False
//	//checkboxes
//	cbx_mail.Visible = True
//	if of_get_app_setting("set_img","I") = 1 then //if imaging module maha121306
//		cbx_priv.Visible = True
//		cbx_release.Visible = True	
//	end if
//	cb_no.Visible = False
//	//This.x = This.x + 50
//	Timer(0)
//ELSE  //2
////	debugbreak()
//	ls_retval = "1"
//	of_print_image_document( "Print" )
//
//	gs_fax_error_records lst_fax_error_records
//	lst_fax_error_records.il_error_rec_num[1] = 0
//	CloseWithReturn( Parent, lst_fax_error_records  )
//END IF
end event

type cbx_mail from checkbox within w_ai_print_msg_box
integer x = 1431
integer y = 516
integer width = 517
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Print Mailing Label"
end type

type cbx_priv from checkbox within w_ai_print_msg_box
integer x = 855
integer y = 516
integer width = 517
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Print Privilege List"
end type

event clicked;//Added by Ken.Guo on 2008-11-07
If gnv_reg_ocx.of_check_ocx( 3, '', True) <> '' Then
	This.Checked = False
End If
end event

type cbx_release from checkbox within w_ai_print_msg_box
integer x = 183
integer y = 516
integer width = 553
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Print Release Forms"
end type

event clicked;//Added by Ken.Guo on 2008-11-07
If gnv_reg_ocx.of_check_ocx( 3, '', True) <> '' Then
	This.Checked = False
End If
end event

type cb_print from commandbutton within w_ai_print_msg_box
integer x = 73
integer y = 1544
integer width = 398
integer height = 96
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Print Errors"
boolean cancel = true
end type

event clicked;dw_errors.Print()
end event

type cb_continuefax from commandbutton within w_ai_print_msg_box
integer x = 914
integer y = 1544
integer width = 946
integer height = 96
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Fax Documents With Fax #~'s"
boolean cancel = true
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04/09/2008 By: Ken.Guo
//$<reason> Changed to combined function as cb_fax/cb_email button.
/*
IF ib_faxing_doc = True THEN
	of_Fax( False )
ELSE
	of_Email( False )
END IF
*/
IF ib_faxing_doc = True THEN
	of_fax_email( False, "FAX")
ELSE
	of_fax_email( False, "EMAIL")
END IF
//---------------------------- APPEON END ----------------------------

end event

type cb_cancelfax from commandbutton within w_ai_print_msg_box
integer x = 498
integer y = 1544
integer width = 398
integer height = 96
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel Fax"
boolean cancel = true
end type

event clicked;gs_fax_error_records lst_fax_error_records

lst_fax_error_records.il_error_rec_num[1] = -2
CloseWithReturn( Parent, lst_fax_error_records  )	
end event

type st_text from statictext within w_ai_print_msg_box
integer x = 69
integer y = 928
integer width = 1513
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
boolean enabled = false
string text = "The following physicians had no fax numbers "
boolean focusrectangle = false
end type

type uo_print_app from pfc_cst_u_create_app2 within w_ai_print_msg_box
boolean visible = false
integer x = 1888
integer y = 1276
integer width = 361
integer height = 124
integer taborder = 20
long backcolor = 80269524
borderstyle borderstyle = stylelowered!
end type

on uo_print_app.destroy
call pfc_cst_u_create_app2::destroy
end on

type dw_errors from datawindow within w_ai_print_msg_box
integer x = 64
integer y = 1000
integer width = 2437
integer height = 528
integer taborder = 60
string dataobject = "d_fax_errors"
boolean hscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_error_cnt from statictext within w_ai_print_msg_box
integer x = 69
integer y = 864
integer width = 1513
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
boolean enabled = false
string text = "Error Count"
boolean focusrectangle = false
end type

type cb_fax from commandbutton within w_ai_print_msg_box
boolean visible = false
integer x = 2277
integer y = 420
integer width = 192
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Fax "
boolean cancel = true
end type

event clicked;// start code change --- 11.7.2005 MSKINNER
this.enabled = false

choose case ib_fax_docs_created
	case false
		 if gnv_app.gnvlo_msword.of_setup( ) > 0 then  //note:this is n_cst_msword in pfeutil.pbl
			  //Start Code Change ---- 12.13.2006 #V7 maha changed to combined function
			of_fax_email( true, "FAX")
				//  of_fax( True )
				 // parent.ib_fax_docs_created = true
		 end if
	 case else
		of_fax_email( true, "FAX")
		 // of_fax( True )
		 //End Code Change---12.13.2006
end choose 
// end code change --- 11.7.2005 MSKINNER
end event

type cb_1 from commandbutton within w_ai_print_msg_box
integer x = 2117
integer y = 148
integer width = 398
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;gs_fax_error_records lst_fax_error_records

lst_fax_error_records.il_error_rec_num[1] = -2
CloseWithReturn( Parent, lst_fax_error_records  )	


end event

type cb_no from commandbutton within w_ai_print_msg_box
boolean visible = false
integer x = 2002
integer y = 492
integer width = 398
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "No"
boolean cancel = true
end type

event clicked;gs_fax_error_records lst_fax_error_records

IF li_click_times = 0 THEN  //if no is clicked
	lst_fax_error_records.il_error_rec_num[1] = -2
	CloseWithReturn( Parent, lst_fax_error_records  )	
	//CloseWithReturn(Parent, "2" )
ELSE
	lst_fax_error_records.il_error_rec_num[1] = -1
	CloseWithReturn( Parent, lst_fax_error_records  )	
	//CloseWithReturn(Parent, "1" )
END IF
end event

type cb_email from commandbutton within w_ai_print_msg_box
boolean visible = false
integer x = 2057
integer y = 420
integer width = 201
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Email"
boolean cancel = true
end type

event clicked;// start code change --- 11.7.2005 MSKINNER
This.Enabled = False

CHOOSE CASE ib_fax_docs_created
	CASE False
		IF gnv_app.gnvlo_msword.of_setup( ) > 0 THEN  //note:this is n_cst_msword in pfeutil.pbl
			//Start Code Change ---- 12.13.2006 #V7 maha changed to combined function
			of_fax_email( True, "EMAIL")
			//  of_email( True )
			// parent.ib_fax_docs_created = true
		END IF
	CASE ELSE
		of_fax_email( True, "EMAIL")
		// of_email( True )
		//End Code Change---12.13.2006
END CHOOSE
// end code change --- 11.7.2005 MSKINNER

end event

type gb_1 from groupbox within w_ai_print_msg_box
integer x = 41
integer y = 284
integer width = 1225
integer height = 140
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Process Method"
end type

type gb_2 from groupbox within w_ai_print_msg_box
integer x = 41
integer y = 456
integer width = 1929
integer height = 152
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Include:"
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
01w_ai_print_msg_box.bin 
2700000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe00000004fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000bda91bc001d36ffa00000003000003400000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000024d00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000036d94028011ce9f116002fd838ac03e8c00000000bda91bc001d36ffabda91bc001d36ffa000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000008400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000cfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Affffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe000201066d94028011ce9f116002fd838ac03e8c00000001fb8f0821101b01640008ed8413c72e2b000000300000021d0000000f000001000000008000000101000000880000010200000090000001030000009800000104000000a000000105000000a800000106000000bc00000107000000c400000108000000cc00000109000000d40000010a000000dc0000010b000000e40000010c000000ec0000010d000000f400000000000000fc0000000300020005000000030000043d000000030000052b000000030000006000000002000000010000001e0000000945676d493274696400000000000000032ffffffe0000000b0000ffff000000020000b6c4000000020000b6c4000000035ee0a7b0000000035ee0a7b00000000b0000ffff0000000b0000ffff0000000f000000000000000100010a0000000b0065726c0076726573003164650000010c0000000b73657262657672650b0031640b0000016c000000657365726465767201080032000b000072730000726573653164657600010d0000000b00657262007672657300326465000001090000000b7365727365767265030032640c0000015f000000636f74736f72706b040073700c000001620000006564726f797473720500656c0d000001690000006567616d746e6f63006c6f7200000101000000097478655f78746e65000102000000090078655f00746e657401070079001300006f660000666563726c656c69696b6e697831676e0001060000000f00646e75006675626f7372656600657a6900000100000000097265765f6e6f697300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000200050000043d0000052b0000006000010001000000006d490800696445670001327400000100c8000000020000420000ff0000ffff00ff000000ff00000000000000000100000000000000000100000101ff03000000fe000000002fffff0000000000000100b7d00000ffffb7d0ffffffff0000ffff00000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
27ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000bda942d001d36ffa00000003000001c00000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000012000000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003009541a0101c3b810204f392029c002400000000bda942d001d36ffabda942d001d36ffa000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000050000007a0000000000000001000000020000000300000004fffffffe00000006fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe00020106009541a0101c3b810204f392029c002400000001fb8f0821101b01640008ed8413c72e2b00000030000000f00000000700000100000000400000010100000048000001020000005000000103000000580000010400000060000001050000006800000000000000700000000300030002000000030000038400000003000003840000000300000000000000030000000000000003000000000000000700000000000000010001050000000d00697270006e65746e6761706401030065000c0000735f00006b636f74706f727001040073000f00007270000073746e697472617465676170000101000000090078655f00746e65740102007800090000655f00006e65747800007974090000015f00000073726576006e6f690000000000000000000000000000000000000000000000000000000000000000000300020000038400000384000000000000010000000000000000000000000001010000000000000000000000000000010003000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000001000000000200000300000000000300000100000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11w_ai_print_msg_box.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
