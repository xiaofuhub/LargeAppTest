$PBExportHeader$n_cst_contract.sru
$PBExportComments$[intellicontract_tab]  Helper object for the contract module
forward
global type n_cst_contract from nonvisualobject
end type
end forward

global type n_cst_contract from nonvisualobject
end type
global n_cst_contract n_cst_contract

type variables
/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: 
**==================================================================================================================
**  Returns   	: 
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner      1 July 2005         ?  IntellisoftGroup Inc 2005
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
** MSKINNER                 13 march 2006                                        added new constants
**																				                     added is_contract_status
********************************************************************************************************************/

PUBLIC:

datetime idt_contract_exp_date
datetime idt_contract_eff_date	//1.23.2008 By Jervis

LONG   il_null
LONG   il_company_name
ANY    any_null_array[]

STRING is_null
STRING is_mode
STRING is_contrtact_dir_path
STRING is_contract_status
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.09.2007 By: Jack 
//$<reason> Fix a defect.
long il_category
long il_count
//---------------------------- APPEON END ----------------------------


CONSTANT LONG  HISTORICAL_VERSION = 1 /* HISTORIAL VERSION OF THE IMAGE - NO CHANGES CAN BE MADE*/ 
CONSTANT LONG  CURRENT_VERSION    = 0

String	is_RegKey = "HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Requirement"		//Modified By Mark Lee 04/18/12 modify in event of constructor 

/*****SCAN METHODS *********/
constant long APPEND_TO_IMAGE = 2
constant long REPLACE_IMAGE = 6



CONSTANT LONG PROGRESS_OPEN = 1000000 // THE MIN SIZE FOR THE PROGRESS WINDOW TO COME UP

/************************** REPORT VARS END******************************/


CONSTANT STRING NEW_LINE  = '~r~n'	
CONSTANT STRING NEW       = 'NEW'
CONSTANT STRING EDIT      = 'EDIT'
CONSTANT STRING QUERY     = 'QUERY'

constant string CONTRACT_ACTIVE    = 'ACTIVE'
constant string CONTRACT_PENDING   = 'PENDING'
constant string CONTRACT_CANCELED  = 'CANCELED'
constant string CONTRACT_EXPIRED   = 'EXPIRED'
constant string CONTRACT_HISTORY   = 'HISTORY'
constant string CONTRACT_INACTIVE  = 'INACTIVE'



/**************************************************************************************/
/************************** PROTECTED SECTION *****************************************/
/**************************************************************************************/

PROTECTED:
boolean ib_medical_contract
LONG il_ctx_id 
long il_Old_ctx_id	//05/11/2007 By Jervis
LONG il_fee_sched_id
LONG il_req_profile_id /*** requitements profile id    */
LONG il_scan_method
long il_active_code
long il_history_code 
long il_canceled_code
long il_par_unknown



/**************************  Vars related to saving images ***************************/
long il_image_id
datastore ids_data
blob iblob_fileblob        // contains all of 'fhandle's file
blob packedfileblob  // contains 'packed' file
long flength       // length of input file
long packedLen
string is_file_location

n_cst_string inv_cst_string

n_cst_filesrvwin32 inv_filesrv
boolean ib_protect_columns
boolean ib_allow_tab_change




//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.16.2006 By: Davis
//$<reason> Storage file extend name, pdf text
String is_filename_extend
String is_pdftext
//---------------------------- APPEON END ----------------------------


end variables

forward prototypes
public function integer of_set_ctx_id (long al_ctx_id)
public function long of_get_ctx_id ()
public function long of_set_fee_id (long al_fee_id)
public function integer of_get_fee_id ()
public function integer of_create_database ()
public function long of_get_req_profile_id ()
public function integer of_set_dataobject (n_ds ids)
public function integer of_add_filetodb (string as_file_location, long al_image_id)
public function integer of_get_image_id ()
public function integer of_set_image_id (long al_image_id)
private function integer of_read_from_disk (string as_file_location)
public function integer of_save_contract_dir ()
public function integer of_set_scan_method (integer al_method)
public function integer of_get_scan_method ()
public function integer of_insert_row (long al_image_id, long al_ctx_id, long al_image_version)
public function string of_get_current_image ()
protected function integer of_store_image (long al_image_id, long al_ctx_id)
public function integer of_set_lock_status (string as_lock_type, long al_image_id, long al_max_version)
public function boolean of_file_modified (string as_filename)
public function integer of_set_modified_dtm (string as_filename)
public function string of_get_image (long al_image_id, long al_current_version)
public function integer of_del_ctx_directory ()
public function integer of_adjust_menu (u_tabpg adw_tabpage, string as_other)
public function long of_get_next_record_id ()
public function long of_get_active_status_code ()
public function long of_get_history_status_code ()
public function long of_get_canceled_status_code ()
public subroutine of_set_protect_columns (boolean lb_protect)
public function boolean of_get_protect_columns ()
public subroutine of_set_tab_change (boolean ab_bool)
public function boolean of_get_tab_change ()
public function long of_get_par_unknown ()
public function boolean of_get_is_ctx_medial ()
public function integer of_set_contact_type (long al_ctx_type)
public function integer of_set_old_ctx_id (long al_ctx_id)
public function long of_get_old_ctx_id ()
public function boolean of_get_protect_tabpg ()
public function boolean of_get_protect_contract ()
public function boolean of_allow_newctx ()
public function boolean of_allow_copyctx ()
public function string of_getelementdoc (long al_elements_id)
public function integer of_writefile (string as_filename, ref blob ablb_data)
public function integer of_delete_ctx_detail (long al_ctx_id)
public function integer of_set_alarm (u_dw adw_screen, string as_table, dwobject dwo)
public subroutine of_set_alarm_flag (u_dw adw_screen, string as_table, string as_columns[], long al_ctx_id, long al_doc_id, long al_level_id1, long al_level_id2)
public subroutine of_reset_alarm (u_dw adw_alarm, string as_table, dwobject dwo)
public function integer of_show_missing_msg (string as_column_name, u_dw adw, string as_field_type, long al_row)
public function integer of_adjust_menu (u_tabpg adw_tabpage, string as_other, boolean ab_auto_setredraw2false)
end prototypes

public function integer of_set_ctx_id (long al_ctx_id);//messagebox('set',al_ctx_id)

il_ctx_id = al_ctx_id

return 0
end function

public function long of_get_ctx_id ();
//messagebox('get',il_ctx_id)
return il_ctx_id
end function

public function long of_set_fee_id (long al_fee_id);

il_fee_sched_id = al_fee_id

return 0
end function

public function integer of_get_fee_id ();

return il_fee_sched_id
end function

public function integer of_create_database ();/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner  22 July 2005
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

//f_create_ctx_database()


return 0

end function

public function long of_get_req_profile_id ();
/******************************************************************************************************************
**  [PUBLIC]   : of_get_req_profile_id
**==================================================================================================================
**  Purpose   	: Gets the profile id for this contract. Since we may not have seleted the tab already we will get it 
**               here as need.
**==================================================================================================================
**  Arguments 	: 
**==================================================================================================================
**  Returns   	:   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner      25 July 2005         ?  IntellisoftGroup Inc 2005
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

n_ds l_nds  
l_nds = create n_ds
l_nds.dataobject = 'd_profile_header'
l_nds.of_settransobject( sqlca)
l_nds.retrieve( Il_ctx_id )

// THERE WILL BE ONLY ONE ROW!!!!!!!!!!!!

IF l_nds.ROWcount( ) > 0 THEN 
	il_req_profile_id = L_NDS.OBJECT.ctx_req_profile_hdr_id[1]
END IF

return il_req_profile_id
end function

public function integer of_set_dataobject (n_ds ids);return 1


end function

public function integer of_add_filetodb (string as_file_location, long al_image_id);/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner xx September 2005  ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
n_cst_image_cp_ocr lnv_ocr 
lnv_ocr = Create n_cst_image_cp_ocr

if f_validstr(as_file_location) then 

	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 11.06.2006 By: Davis
	//$<reason> Get file name for global search.
	Integer li_pos
	li_pos = LastPos(as_file_location,".")
	IF li_pos > 0 THEN
		// Get file extend name
		is_filename_extend = Lower(Mid(as_file_location, li_pos + 1))

		// pick-up PDF text
		IF is_filename_extend = "pdf" THEN
			IF FileExists(as_file_location) THEN
				n_cst_pdf2text lnv_cst_pdf2text
				lnv_cst_pdf2text.of_pdf2text( as_file_location, is_pdftext )
				If is_pdftext = '' Then
					is_pdftext = lnv_ocr.of_ocr(as_file_location)
				End If
			END IF
		END IF
	END IF
	//---------------------------- APPEON END ----------------------------

if of_read_from_disk(as_file_location ) = 0 then 
   of_store_image(al_image_id,of_get_ctx_id( ))
else 
	If isvalid(lnv_ocr) Then Destroy lnv_ocr
	return -1
end if 

else
	of_save_contract_dir( )
end if 


If isvalid(lnv_ocr) Then Destroy lnv_ocr
return 0


end function

public function integer of_get_image_id ();

return il_image_id
end function

public function integer of_set_image_id (long al_image_id);



il_image_id = al_image_id

return  0 
end function

private function integer of_read_from_disk (string as_file_location);/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner 02 September 2005  ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

string mypath   // file variable including path
string myfile   // just filename
integer fhandle // file control handle
integer cread   // bytes read
blob l_fileblob
blob fdata      // data read in (max is 32766)

ulong fleft     // how much file is left to read in
long iterations // nos. of loops to needed to write file
long totalread  // accumlative count of how many bytes read
long rem        // remainder of file to read in (<32765)
long reps       // current nos. of repitions
long blobpos    // current blob position whilst writing file
string ls_temp_location
string ls_parse_array[]
integer res

//inv_string.of_parsetoarray( /*string as_source*/, /*string as_delimiter*/, /*ref string as_array[] */)


inv_cst_string.of_parsetoarray( as_file_location, '\', ls_parse_array)

IF upperbound(ls_parse_array)  < 1 then return -1

//startchange 
//ls_temp_location =    'c:\' + ls_parse_array[upperbound(ls_parse_array)]
ls_temp_location =    gs_dir_path + gs_DefDirName + '\' + ls_parse_array[upperbound(ls_parse_array)]  //Start Code Change ---- 01.25.2007 #V7 maha

is_file_location = as_file_location


if FileCopy (as_file_location,   ls_temp_location,true) <> 1  then
	res =  FileCopy (is_contrtact_dir_path +'\'+ as_file_location,   ls_temp_location,true)
	choose case res //if error
		case -1
			messagebox("Copy Error","Unable to copy from file " + as_file_location )
			return -1
		case -2
			messagebox("Copy Write Error","Unable to copy to file " + ls_temp_location )
			return -1
	end choose
end if 


flength=filelength(ls_temp_location)
fhandle=fileopen(ls_temp_location,StreamMode!)



if fhandle=-1 then
    //messagebox("Error opening file  "  ,ls_temp_location)
    return -1
end if


if flength = 0 then return -1

if flength > PROGRESS_OPEN then
	
		open(w_infodisp)
		w_infodisp.center = true
		w_infodisp.height = 680
		w_infodisp.cb_2.x = 626
		w_infodisp.cb_2.y = 436
		w_infodisp.st_complete.visible = false
		w_infodisp.st_3.visible = false
		w_infodisp.st_information.visible = false
		w_infodisp.st_1.text = 'Saving Document to Database - Please Stand By'
		
		
end if 
// get the name of the doc from as_doc_path

fleft=flength
if isvalid(w_infodisp) then
   w_infodisp.wf_set_min_max(0,flength)
end if 

/*
if w_infodisp.ib_cancel  then 
					close(w_infodisp)
					of_set_lock_status('unlock',al_image_id,ll_max_version)
				  	fileclose(ll_file)
					filedelete(is_contrtact_dir_path + "\" + ls_file_name)
					return ''
				end if 

*/
 setpointer(HourGlass!)
DO
 
   
  cread=fileread(fhandle,fdata)
  fleft -= cread
  l_fileblob=l_fileblob+fdata     

  totalread+=cread
  
  if isvalid(w_infodisp) then
	
     w_infodisp.wf_step(cread)
	  yield()
	  if w_infodisp.ib_cancel  then
		setnull(l_fileblob)
		close(w_infodisp)
		return -1
	  end if 
	  
	 
  end if 
  
 
  fileseek(fhandle,totalread,frombeginning!)
LOOP WHILE fleft>0 

if fileclose(fhandle)=-1 then
	messagebox("CLOSE ERROR","Error closing : "+mypath)
end if
	

iblob_fileblob = l_fileblob
packedfileblob = l_fileblob

filedelete(ls_temp_location)

return 0
end function

public function integer of_save_contract_dir ();
/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner xx September 2005  ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

long     i_cnt 
long     li_entries
long     ll_ctx_id
long     ll_image_id
String   ls_currdir
String   ls_import
STRING   LS_START_FILE_NAME
string ls_file_name 
long ll_image_version
long ll_max_version
n_cst_dirattrib   lnv_dirlist[]
string ls_fullfile_name // includes the whole path
//////////////////////////////////////////////////////////////////////////////////////////////
// Make sure we have the max version :: do not update the historical versions
//////////////////////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

ls_currdir = is_contrtact_dir_path +'\*.*'
li_entries = inv_filesrv.of_DirList(ls_currdir , 0, lnv_dirlist)

for i_cnt =  1 to  li_entries
	ls_file_name = lnv_dirlist[i_cnt].is_filename
	LS_START_FILE_NAME = ls_file_name
	
	/////////////////////////////////////////////////
	// THE FOLLOWING ADDED TO FIX IMAGIGING BUG
	/////////////////////////////////////////////////
	
	
	// strip out the version number if is there
	long ll_pos
	ll_pos = Pos ( ls_file_name, '_')
	if	ll_pos > 0 then
	IF ISNUMBER(MID(ls_file_name,1 , ll_pos -1 )) THEN
		 	ls_file_name = mid(ls_file_name,ll_pos + 1)
		ELSE 
			LS_START_FILE_NAME = ls_file_name
	END IF
	end if
	
	

	SELECT ctx_images.image_id,   
          ctx_images.ctx_id,
			 ctx_image.image_version 
   INTO   :ll_image_id,   
          :ll_ctx_id ,
			 :ll_image_version
   FROM ctx_image,   
         ctx_images  
   WHERE ( ctx_image.image_id = ctx_images.image_id ) and  
         ( ctx_images.file_name = :ls_file_name ) and
			( ctx_image.locked_by = :gs_user_id ) ;
	// Make sure we have the max version 'cheked out' :: do not update the historical versions
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 09.21.2006 By: Liang QingShi
	//$<reason> Fxi a defect.
	/*
    select max(ctx_image.image_version)
	 into :ll_max_version
	 FROM ctx_image,
	 where ctx_image.image_id = :ll_image_id;
	*/ 
    select max(ctx_image.image_version)
	 into :ll_max_version
	 FROM ctx_image
	 where ctx_image.image_id = :ll_image_id;
	
	//---------------------------- APPEON END ----------------------------
	 
	 
	 //////////////////////////////////////////////////////////////////////////////////////////
	 // check to see if the file has been modified if not then do not save ir
	 //////////////////////////////////////////////////////////////////////////////////////////
    ls_fullfile_name =is_contrtact_dir_path +'\' + LS_START_FILE_NAME
	 
		 
	 if (ll_max_version <> ll_image_version) OR not of_file_modified( ls_fullfile_name ) then
		// delete the file not the current version
		filedelete(ls_fullfile_name )
		of_set_lock_status('UNLOCK',ll_image_id,ll_image_version)
	 else 
		 if not isnull(ll_image_id) then 
			if of_read_from_disk( ls_fullfile_name ) <> -1 then 
				if of_store_image( ll_image_id, ll_ctx_id) <> -1 then 
				  //clear out the contract directory
					 filedelete(ls_fullfile_name )
				 end if 
			end if
					
		end if
	 end if
	
next

if li_entries < 1 then 

			UPDATE   ctx_image  
				SET  locked_by            = '',   
					  lock_status          = 0 /*,
					  updated_by_user      = :gs_user_id,
					  updated_at_date_time = :ldtServerDate */
			WHERE  locked_by = :gs_user_id  
			using sqlca;
	   
		 
end if 




return 0
end function

public function integer of_set_scan_method (integer al_method);

il_scan_method = AL_METHOD

RETURN 0
end function

public function integer of_get_scan_method ();


LONG LL_SCAN_METHOD

LL_SCAN_METHOD = IL_SCAN_METHOD
//IL_SCAN_METHOD =  0

RETURN  LL_SCAN_METHOD
end function

public function integer of_insert_row (long al_image_id, long al_ctx_id, long al_image_version);/******************************************************************************************************************
**  [PUBLIC]   : OF_INSERT_ROW
**==================================================================================================================
**  Purpose   	: iNSERRTS A NEW ROW INTO THE DATASTORE
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner xx September 2005  ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
LONG LL_ROW

ll_row = ids_data.InsertRow(0)
ids_data.SetItem(ll_row,"image_id",al_image_id)
ids_data.SetItem(ll_row,"ctx_id",al_ctx_id)
ids_data.SetItem(ll_row,"image_version",Al_image_version)
ids_data.SetItem(ll_row,"record_id", of_get_next_record_id( ) )





RETURN 0
end function

public function string of_get_current_image ();/******************************************************************************************************************
**  [PUBLIC]   : of_get_current_image
**==================================================================================================================
**  Purpose   	: The the current image in the users contract directory
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner xx September 2005  ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


long     i_cnt 
long     li_entries
long     ll_ctx_id
long     ll_image_id
String   ls_currdir
String   ls_import
string ls_file_name 

n_cst_dirattrib   lnv_dirlist[]


SetPointer(HourGlass!)

ls_currdir = is_contrtact_dir_path +'\*.tif'
li_entries = inv_filesrv.of_DirList(ls_currdir , 0, lnv_dirlist)

for i_cnt =  1 to  li_entries
	ls_file_name = lnv_dirlist[i_cnt].is_filename
next


return ls_file_name
end function

protected function integer of_store_image (long al_image_id, long al_ctx_id);/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner 02 September 2005  ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

BOOLEAN  lb_exists
BLOB     lblb_fileblob
DATETIME ldt_date
DATETIME ldtServerDate
LONG     ll_rows
LONG     ll_row
LONG     ll_image_version
STRING   ls_file
STRING   ls_comment

////////////////////////////////////////////////////////////////////////////////////
// get the max version for the image
////////////////////////////////////////////////////////////////////////////////////

select max(image_version)
into :ll_image_version
from CTX_IMAGE  
WHERE image_id = :al_image_id;

if isnull(ll_image_version) then ll_image_version =  1

////////////////////////////////////////////////////////////////////////////////////
// Check to see if the image exists in the table if so update it else insert a new record
////////////////////////////////////////////////////////////////////////////////////

IF of_get_scan_method( ) = REPLACE_IMAGE THEN
	ll_image_version = ll_image_version + 1
   of_insert_row( al_image_id, al_ctx_id, ll_image_version)
ELSE 
	
	if ids_data.retrieve(al_image_id) > 0 then
		ids_data.SetItem(ll_row,"image_id",al_image_id)
		ids_data.SetItem(ll_row,"ctx_id",al_ctx_id)
		ids_data.SetItem(ll_row,"image_version",ll_image_version)
		ids_data.SetItem(ll_row,"record_id",of_get_next_record_id( ) )
	else
	    of_insert_row( al_image_id, al_ctx_id, ll_image_version)
	end if

END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<add> 03.16.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_startqueue( )
//---------------------------- APPEON END ----------------------------

ids_data.Update() 

////////////////////////////////////////////////////////////////////////////////////
// upodate the blob file
////////////////////////////////////////////////////////////////////////////////////

if isvalid(w_infodisp) then
  w_infodisp.st_1.text = 'Saving document to database - Updating Please Stand By '
end if

UPDATEBLOB  CTX_IMAGE 
       set image_file = :iblob_fileblob
     WHERE image_id = :al_image_id AND 
           image_version = :ll_image_version;
			  
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02
//$<add> 03.16.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_commitqueue( )
//---------------------------- APPEON END ----------------------------
						
IF SQLCA.SQLCode <> 0 THEN
	MessageBox("Save failed", "Save failed:~r~n" + SQLCA.SQLErrText)
	Rollback using SQLCA;
	return -1
ELSE
	of_set_lock_status('UNLOCK',al_image_id,ll_image_version)
	
   // UPDATE THE USER UPDATE TIME
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-03
	//$<modify> 03.16.2006 By: LeiWei
	//$<reason> Performance tuning
	//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

	/*
	select getdate() 
   into :ldtServerDate
   from sysobjects
   using SQLCA;

	UPDATE  ctx_image
		SET  updated_by_user      = :gs_user_id,
			  updated_at_date_time = :ldtServerDate 
	WHERE  image_id = :al_image_id AND 
			 image_version = :ll_image_version;

	Commit using SQLCA;
	*/
	gnv_appeondb.of_startqueue( )

	UPDATE  ctx_image
		SET  updated_by_user      = :gs_user_id,
			  updated_at_date_time = getdate()
	WHERE  image_id = :al_image_id AND 
			 image_version = :ll_image_version;
			 
	//$<add> 09.14.2006 By: LeiWei
	//$<reason> Fix a defect.
	UPDATE  ctx_image
		SET  inserted_by_user      = :gs_user_id,
			  inserted_at_date_time = getdate()
	WHERE  image_id = :al_image_id AND 
			 image_version = :ll_image_version
			 AND inserted_by_user IS NULL;
	//$<add> 09.14.2006 By: LeiWei

	//$<add> 11.06.2006 By: Davis
	IF gs_dbtype = "SQL" THEN
		UPDATE  ctx_image
			SET  doctype = :is_filename_extend,
				  pdftext = :is_pdftext
		WHERE  image_id = :al_image_id AND 
				 image_version = :ll_image_version;
	END IF
	//$<add> 11.06.2006 By: Davis

	Commit using SQLCA;
	
	gnv_appeondb.of_commitqueue( )
	//---------------------------- APPEON END ----------------------------
						
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 11.16.2006 By: Davis
	//$<reason> Start an incremental population of the full-text index for the table.
	IF gs_dbtype = "SQL" THEN
		String ls_sql
		ls_sql = "exec sp_fulltext_table 'ctx_image','start_incremental'"
		EXECUTE IMMEDIATE :ls_sql using sqlca;
	  	COMMIT;
	END IF
	//---------------------------- APPEON END ----------------------------

	// CLEAR THE MEMORY
	setnull(iblob_fileblob)

END IF

if isvalid(w_infodisp) then
    close(w_infodisp)
end if 



return 0
end function

public function integer of_set_lock_status (string as_lock_type, long al_image_id, long al_max_version);/******************************************************************************************************************
**  [PUBLIC]   : of_set_lock_status
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [string] al_lock_type
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner xx September 2005  ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                           Reason
** ------------------------------------------------------------------------------------------------------------------
	  MSKINNER               3 October 2005                       I WILL BE SETTING THE CHANGE DATE AND
	  																				  USER THROUGH SQL RATHER THEN THE DEFAULT
																					  BECAUSE CHANGING THEN LOCK STATUS CHANGES THE WHOLE RECORD.
																					  WHEN WE MAY NOT WANT TO.
********************************************************************************************************************/
STRING LS_LOCKED_BY
STRING LS_LOCK_STATUS
datetime ldtServerDate

choose case upper(as_lock_type)
	case 'LOCK'
		   LS_LOCKED_BY = gs_user_id
			LS_LOCK_STATUS = '1'
		case 'UNLOCK'
			LS_LOCK_STATUS = '0'
END CHOOSE 
		
///////////////////////////////////////////////////////////////////////////////////////////////////
// use  the server date time
///////////////////////////////////////////////////////////////////////////////////////////////////

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-04
//$<comment> 03.16.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Comment out the following script since ldtServerDate is not used by subsequent script.
/*
select getdate() 
into :ldtServerDate
from dummy
using SQLCA;
*/
//---------------------------- APPEON END ----------------------------

UPDATE  ctx_image  
	SET  locked_by            = :LS_LOCKED_BY,   
	     lock_status          = :LS_LOCK_STATUS/*,
		  updated_by_user      = :gs_user_id,
		  updated_at_date_time = :ldtServerDate */
WHERE  image_id = :al_image_id AND 
	    image_version = :Al_max_version;

return 0
end function

public function boolean of_file_modified (string as_filename);/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: determine if a file has been modified. 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 23 September 2005  ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

date ld_create_date
date ld_write_date
time lt_create_time
time lt_write_time


inv_filesrv.of_getcreationdatetime(as_filename, ld_create_date, lt_create_time)
inv_filesrv.of_getlastwritedatetime(as_filename, ld_write_date, lt_write_time)


if (ld_create_date = ld_write_date) and (lt_create_time = lt_write_time ) then 
	return false
end if 



return true
end function

public function integer of_set_modified_dtm (string as_filename);/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: sets the modified time to be the same as the creation time
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 23 September 2005  ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

date ld_create_date
time lt_create_time



inv_filesrv.of_getcreationdatetime(as_filename, ld_create_date, lt_create_time)
inv_filesrv.of_setlastwritedatetime(as_filename, ld_create_date, lt_create_time)


return 0
end function

public function string of_get_image (long al_image_id, long al_current_version);/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner xx September 2005  ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
integer cread      // bytes read
blob    fdata       // data read in (max is 32766)
blob    writeBlob     // the blob we are currently writing
long    fleft         // how much file is left to read in
long    iterations    // nos. of loops to needed to write file
long    totalread     // accumlative count of how many bytes read
long    rem           // remainder of file to read in (<32765)
long    reps          // current nos. of repitions
long    blobpos       // current blob position whilst writing file
long    ll_ctx_id
String  ls_project
String  ls_file
long    ll_file // file control handle
string   ls_file_name
long ll_max_version
string ls_user



setpointer(HourGlass!)
ll_ctx_id  = of_get_ctx_id( )

///////////////////////////////////////////////////////////////
// get the BLOB name, using the max version id
////////////////////////////////////////////////////////////////

select CTX_IMAGEs.file_name
into :ls_file_name
FROM CTX_IMAGES
WHERE CTX_IMAGES.image_id = :al_image_id AND
      CTX_IMAGES.ctx_id   = :ll_ctx_id ;
IF SQLCA.SQLCode <> 0 THEN
	MessageBox("Read failed ls_file_name", "Read failed:~r~n" + SQLCA.SQLErrText)
	return ''
END IF



////////////////////////////////////////////////////////////////
// get the BLOB name, using the max version id
////////////////////////////////////////////////////////////////

IF al_current_version  =  0 then 
	select max(image_version)
   into :ll_max_version
   from CTX_IMAGE  
   WHERE image_id = :al_image_id;
else 
	ll_max_version = al_current_version
end if 

IF SQLCA.SQLCode <> 0 THEN
	MessageBox("Read failed ll_max_version ", "Read failed:~r~n" + SQLCA.SQLErrText)
	return ''
END IF


//////////////////////////////////////////////////////////////////////////////////////
// TODO now check to see if the file is locked out by another user
//////////////////////////////////////////////////////////////////////////////////////

  SELECT locked_by
    INTO :ls_user  
    FROM ctx_image 
   WHERE image_id = :al_image_id AND 
			image_version = :ll_max_version  ;
			
if f_validstr(ls_user) and  ls_user <> gs_user_id  then 
	messagebox('File Locked','The requested file is locked by '+upper(ls_user)+ ' please try again later.')
	return''
end if 
		
setnull(iblob_fileblob)
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 08.19.2006 By: LeiWei
//$<reason> Fix a defect.
/*
	SELECTblob image_file 
		INTO :iblob_fileblob
		FROM CTX_IMAGE 
		WHERE image_id = :al_image_id AND 
				image_version = :ll_max_version
	USING sqlca ;
*/
IF appeongetclienttype() = 'PB' AND gs_dbtype = 'SQL' THEN
	of_get_image_ctx_image(al_image_id, ll_max_version, iblob_fileblob)
ELSE
	SELECTblob image_file 
		INTO :iblob_fileblob
		FROM CTX_IMAGE 
		WHERE image_id = :al_image_id AND 
				image_version = :ll_max_version
	USING sqlca ;
END IF
//---------------------------- APPEON END ----------------------------
		
//////////////////////////////////////////////////////////////////////////////////////
// update the locked status - used for referance updating file again
//////////////////////////////////////////////////////////////////////////////////////

of_set_lock_status('lock',al_image_id,ll_max_version)

IF SQLCA.SQLCode <> 0 THEN
	MessageBox("Read failed", "Read failed:~r~n" + SQLCA.SQLErrText)
	return ''
END IF

IF IsNull(iblob_fileblob) THEN
	MessageBox("Blob error","Blob is NULL!", StopSign!)
	return ''
END IF

//////////////////////////////////////////////////////////////////////////////////////
// !!!!!!!  IMAGING BUG : EDIT Control in Imaging will not refresh if the same file
//           file name is used twice. So trick by adding the version infront
//////////////////////////////////////////////////////////////////////////////////////
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2006-10-11 By: Liu Hongxin
//$<reason> Used for Send Email of Contract.
/*
ls_file_name =  string(ll_max_version) + '_' + ls_file_name
*/
IF is_mode = "attach" THEN
	is_contrtact_dir_path = gs_dir_path + gs_DefDirName + "\"
ELSE
	ls_file_name =  string(ll_max_version) + '_' + ls_file_name
END IF
//---------------------------- APPEON END ----------------------------

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// File security    If any security is set for the file (for example, if you are sharing the file on a network),
// you must call FileLength before FileOpen or after FileClose. Otherwise, you get a sharing violation.
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
flength = Len(iblob_fileblob)
if  flength > PROGRESS_OPEN  then 
		open(w_infodisp)
		w_infodisp.height = 680
		w_infodisp.cb_2.x = 626
		w_infodisp.cb_2.y = 436
		w_infodisp.st_complete.visible = false
		w_infodisp.st_3.visible = false
		w_infodisp.st_information.visible = false
		w_infodisp.st_1.text = 'Retrieving File From Database - Please Stand By'
		w_infodisp.center = true
		// get the name of the doc from as_doc_path
		w_infodisp.wf_set_min_max(0,flength)
end if 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// save file to gs_dir_path (application path)
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//is_contrtact_dir_path
//ll_file =fileopen(gnv_app.is_application_path + "\contract\" + ls_file_name ,streammode!,write!,lockreadwrite!,replace!)
ll_file =fileopen(is_contrtact_dir_path + "\" + ls_file_name ,streammode!,write!,lockreadwrite!,replace!)
//Start Code Change ---- 01.25.2007 #V7 maha
if ll_file = -1 then
	messagebox("Image file","Unable to open file " + is_contrtact_dir_path + "\" + ls_file_name)
	return ''
end if
//End Code Change---01.25.2006
// figure out the number of interations
iterations=flength/32765
rem=mod(flength,32765)
blobpos=1

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
// save file to is_contrtact_dir_path + "\"  
// Filewrite can only write 32K at a time
/////////////////////////////////////////////////////////////////////////////////
if iterations>=1 then
	do
		reps++
		yield()
		of_set_modified_dtm( is_contrtact_dir_path + "\" + ls_file_name)
		if isvalid(w_infodisp) then 
				if w_infodisp.ib_cancel  then 
					close(w_infodisp)
					of_set_lock_status('unlock',al_image_id,ll_max_version)
				  	fileclose(ll_file)
					filedelete(is_contrtact_dir_path + "\" + ls_file_name)
					return ''
				end if 
		 end if 
		writeblob=blobmid(iblob_fileblob,blobpos,32765)
		filewrite(ll_file,writeblob)
		blobpos+=32765
		if isvalid(w_infodisp) then
		    w_infodisp.wf_step(32765)
	   end if 
	loop until reps=iterations 
	writeblob=blobmid(iblob_fileblob,blobpos,rem)
	filewrite(ll_file,writeblob)
else  
	filewrite(ll_file,iblob_fileblob) 
end if

fileclose(ll_file)

setpointer(arrow!)

if isvalid(w_infodisp) then 
  close(w_infodisp)
end if 

of_set_modified_dtm( is_contrtact_dir_path + "\" + ls_file_name)

return is_contrtact_dir_path + "\" + ls_file_name

end function

public function integer of_del_ctx_directory ();
/******************************************************************************************************************
**  [PUBLIC]   : of_del_ctx_directory
**==================================================================================================================
**  Purpose   	: deletes the files in the directory. This function is run from the post_open event of the parent window
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner xx September 2005  ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

long     i_cnt 
long     li_entries
long     ll_ctx_id
long     ll_image_id
String   ls_currdir
String   ls_import
string ls_file_name 
long ll_image_version
long ll_max_version
n_cst_dirattrib   lnv_dirlist[]
string ls_fullfile_name // includes the whole path
//////////////////////////////////////////////////////////////////////////////////////////////
// Make sure we have the max version :: do not update the historical versions
//////////////////////////////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

ls_currdir = is_contrtact_dir_path +'\*.*'
li_entries = inv_filesrv.of_DirList(ls_currdir , 0, lnv_dirlist)

for i_cnt =  1 to  li_entries
	 filedelete(is_contrtact_dir_path +'\' + lnv_dirlist[i_cnt].is_filename )
next


//////////////////////////////////////////////////////////////////////////////////////////
// there should be no locked filess from this user
//////////////////////////////////////////////////////////////////////////////////////////

UPDATE ctx_image
	SET  locked_by           = '',   
		  lock_status          = 0 
 WHERE  locked_by = :gs_user_id  ;
   

return 0
end function

public function integer of_adjust_menu (u_tabpg adw_tabpage, string as_other);
/******************************************************************************************************************
**  [PUBLIC]   : of_adjust_menu( /*u_tabpg adw_tabpage*/
**==================================================================================================================
**  Purpose   	: Function will modify the menu items as directed
**==================================================================================================================
**  Arguments 	: [u_tabpg]  adw_tabpage   The tab page being passed
**             : [string]   as_other      Used to send helpfull info to the function
*==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  27 July 2005
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

//Comment all script in this function, add a new argument, Don't set w_mdi redraw to false by default, by Appeon long.zhang 03.09.2017 (Contracts Module Slowness)
Return of_adjust_menu(adw_tabpage, as_other, False) 

//boolean lb_boolean
//long ll_index
//
////if upperbound(is_class_name) < 1 then
////	is_class_name[upperbound(is_class_name)+ 1] = adw_tabpage.classname()
////	of_create_sys_fields(adw_tabpage)
////else
////	string ls_class_name
////	long ll_i
////	boolean ib_found
////	ls_class_name = adw_tabpage.classname()
////	
////	for ll_i = 1 to upperbound(is_class_name)
////       if is_class_name[ll_i] = ls_class_name then
////			ib_found = true
////		else 
////			is_class_name[upperbound(is_class_name)+ 1] = adw_tabpage.classname()
////		end if 
////		
////	next
////end if 
////
////if not ib_found  then 
////	messagebox('not found',ls_class_name)
////    of_create_sys_fields(adw_tabpage)
////end if 
//
//
/////////////////////////////////////////////////////////////////////////////////////////////////
//// set the menu
//////////////////////////////////////////////////////////////////////////////////////////////////
////w_mdi.title = classname(adw_tabpage)
//
////w_mdi.SetRedraw(false) 
//
//if w_mdi.menuname <> 'm_pfe_cst_mdi_menu_contract' then 
//		//--------------------------- APPEON BEGIN ---------------------------
//		//$<modify> 2006-11-14 By: Allen
//		//$<reason> Fix APB Bug: the Toolbar Icon is invalid.
//		/*
//		w_mdi.ChangeMenu( m_pfe_cst_mdi_menu_contract )	
//		*/
//		If w_mdi.menuname <> 'm_pfe_cst_mdi_menu_contract' Then w_mdi.ChangeMenu( m_pfe_cst_mdi_menu_contract )
//		//---------------------------- APPEON END ----------------------------
//
//		//--------------------------- APPEON BEGIN ---------------------------
//		//$<add> 01.12.2007 By: Jack (Document Manager)
//		//$<reason> Fix a defect.
//				
//		w_mdi.of_menu_security("m_pfe_cst_mdi_menu_contract")
//		//---------------------------- APPEON END ----------------------------
//		
//		////////////////////////////////////////////////////////////////////////////////////////////////
//		// toolbar position
//		////////////////////////////////////////////////////////////////////////////////////////////////
//		
//		//---------Begin Modified by (Appeon)Harry 03.10.2014 for V142 ISG-CLX--------
//		/*
//		//--------------------------- APPEON BEGIN ---------------------------
//		//$<modify> 08.16.2006 By: Liang QingShi
//		//$<reason> Contract module modification
//		/*
//		ll_index = 10
//		*/
//		ll_index = 11
//		
//		//---------------------------- APPEON END ----------------------------
//		*/
//		ll_index = 100 //11	->100  (Appeon)Alfee 07.30.2013 - V141 ISG-CLX
//		//---------End Modfiied ------------------------------------------------------
//		
//		//---------Begin Commented by (Appeon)Harry  03.10.2014 for V142 ISG-CLX--------
//		//gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_file.m_save,'toolbaritemorder', ll_index)
//		//ll_index ++
//		//---------End Commented ------------------------------------------------------
//		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_insert,'toolbaritemorder', ll_index)
//		ll_index ++
//		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_delete1,'toolbaritemorder', ll_index)
//		ll_index ++
//		//---------Begin Added by (Appeon)Harry 03.10.2014 for V142 ISG-CLX--------
//		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_file.m_save,'toolbaritemorder', ll_index)
//		ll_index ++
//		//---------End Added ------------------------------------------------------
//		m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan.toolbaritemorder	 = ll_index
//		ll_index ++
//		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_previous,'toolbaritemorder', ll_index)
//		ll_index ++
//		m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_next.toolbaritemorder 	  = ll_index
//		ll_index ++
//		m_pfe_cst_mdi_menu_contract.m_imagingtools.m_editimage.toolbaritemorder 						= ll_index
//		ll_index ++
//		m_pfe_cst_mdi_menu_contract.m_imagingtools.m_editimage.m_delete.toolbaritemorder 			= ll_index
//		ll_index ++
//		m_pfe_cst_mdi_menu_contract.m_imagingtools.m_editimage.m_maximize.toolbaritemorder 			= ll_index
//		ll_index ++
//		m_pfe_cst_mdi_menu_contract.m_imagingtools.m_editimage.m_objectcopy.toolbaritemorder 		= ll_index
//		ll_index ++
//		m_pfe_cst_mdi_menu_contract.m_imagingtools.m_editimage.m_objectcut.toolbaritemorder 		= ll_index
//		ll_index ++
//		m_pfe_cst_mdi_menu_contract.m_imagingtools.m_editimage.m_objectpaste.toolbaritemorder 		= ll_index
//		ll_index ++
//		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_annotations.m_selectannotations,'toolbaritemorder', ll_index)
//		
//	
//end if 
//
//////////////////////////////////////////////////////////////////////////////////////////////////
//// enable/disable Imaging tool menu item
//////////////////////////////////////////////////////////////////////////////////////////////////
////m_pfe_cst_mdi_menu_contract.m_edit.m_delete1.toolbaritemvisible = false
//
////--------------------------- APPEON BEGIN ---------------------------
////$<add> 10.08.2006 By: LeiWei
//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_image_view.visible	= false
//gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_image_view,'toolbaritemvisible', false)
//gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_image_view,'enabled', false) 
////---------------------------- APPEON END ----------------------------
//
//choose case classname(adw_tabpage)
//	case 'tabpage_view'//,'tabpage_image'
//		  m_pfe_cst_mdi_menu_contract.m_imagingtools.visible = true
//		  m_pfe_cst_mdi_menu_contract.m_imagingtools.m_ocr.visible = FALSE
//		   if as_other = STRING(historical_version) then 
//					//m_pfe_cst_mdi_menu_contract.m_imagingtools.ENABLED = FALSE
//					m_pfe_cst_mdi_menu_contract.m_imagingtools.visible = true
//					m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_next.visible 		            = true
//					m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_previous.visible             = true
//					m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_next.toolbaritemvisible 		= true
//					gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_previous,'toolbaritemvisible', true)
//					//
//					m_pfe_cst_mdi_menu_contract.m_imagingtools.m_annotations.visible = FALSE
//					//
//					m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_appendblankpage.visible = FALSE
//					m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_right1.visible = FALSE
//					m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_rotateallpages.visible = FALSE
//					m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_straightenpage.visible = FALSE
//					
//             
//			ELSE
//					//m_pfe_cst_mdi_menu_contract.m_imagingtools.ENABLED = TRUE
//						m_pfe_cst_mdi_menu_contract.m_imagingtools.m_annotations.visible = TRUE
//					//
//					m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_appendblankpage.visible = TRUE
//					m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_right1.visible = TRUE
//					m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_rotateallpages.visible = TRUE
//					m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_straightenpage.visible = TRUE
//					
//					m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_next.visible 		            = true
//					m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_previous.visible             = true
//					m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_next.toolbaritemvisible 		= true
//					gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_previous,'toolbaritemvisible', true)
//					m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan.visible	= true
//					gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan,'enabled', true)
//					gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_annotations.m_selectannotations,'toolbaritemvisible', true)
//					//m_pfe_cst_mdi_menu_contract.m_edit.visible = false
//					//m_pfe_cst_mdi_menu_contract.m_view.visible = false
//					//m_pfe_cst_mdi_menu_contract.m_edit.m_insert.toolbaritemvisible = false
//					//m_pfe_cst_mdi_menu_contract.m_file.m_save.toolbaritemvisible  = false
//					//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan.visible =  true
//					gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan,'toolbaritemvisible', true)
//					gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_delete1,'toolbaritemvisible', false)
//					
//			end if
//			
//			lb_boolean = false
//	case 'tabpage_browse'
//         u_tabpage_supporting_images_det_browse	   ladw_tabpage  
//			ladw_tabpage = adw_tabpage
//		   		
//		   m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_next.visible 		            = false
//         m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_previous.visible             = false
//			m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_next.toolbaritemvisible 		= false
//         gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_previous,'toolbaritemvisible', false)
//			m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan.visible	= true
//			
//			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan,'toolbaritemvisible', true)
//         //m_pfe_cst_mdi_menu_contract.m_edit.visible = false
//         //m_pfe_cst_mdi_menu_contract.m_view.visible = false
//			//m_pfe_cst_mdi_menu_contract.m_edit.m_insert.toolbaritemvisible = false
//			//m_pfe_cst_mdi_menu_contract.m_file.m_save.toolbaritemvisible  = false
//			m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan.visible =  true
//			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_delete1,'toolbaritemvisible', true)
//			if ladw_tabpage.dw_1.rowcount( ) > 0 then 
//				ladw_tabpage.dw_1.accepttext( )
//				
//				if ladw_tabpage.dw_1.object.media_type[ladw_tabpage.dw_1.getrow()] <> 1 then
//					
//				   m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan.text = 'Browse'
//					gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan,'ToolbarItemText', 'Browse')
//				else 
//					m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan.text = 'Scan'
//					gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan,'ToolbarItemText', 'Scan')
//				end if
//						
//				
//			end if 
//
//			//--------------------------- APPEON BEGIN ---------------------------
//			//$<add> 10.08.2006 By: LeiWei
//			m_pfe_cst_mdi_menu_contract.m_imagingtools.m_image_view.visible	= true
//			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_image_view,'toolbaritemvisible', true)
//			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_image_view,'enabled', true) 
//			//---------------------------- APPEON END ----------------------------
//
//  case 'tabpage_search'
//			//--------------------------- APPEON BEGIN ---------------------------
//			//$<add> 03.20.2006 By: LeiWei
//			//$<reason> Fix a defect.
//		   m_pfe_cst_mdi_menu_contract.m_imagingtools.visible = false
//		   m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_next.toolbaritemvisible 		= false
//         gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_previous,'toolbaritemvisible', false)
//			lb_boolean = false
//		   m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan.visible	= false
//			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan,'toolbaritemvisible', false)
//			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_annotations.m_selectannotations,'toolbaritemvisible', false)
//			//m_pfe_cst_mdi_menu_contract.m_edit.visible = true
//         //m_pfe_cst_mdi_menu_contract.m_view.visible = true
//			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_insert,'toolbaritemvisible', true)
//	      gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_file.m_save,'toolbaritemvisible', true)
//			m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan.visible =  false
//         gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_insert,'toolbaritemvisible', true)
//			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_delete1,'toolbaritemvisible', true)
//			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_delete1,'enabled', true) //jervis-12.7.2009
//			//---------------------------- APPEON END ----------------------------
//			
//			//m_pfe_cst_mdi_menu_contract.m_edit.m_delete1.toolbaritemvisible = false
//   case else
//		   m_pfe_cst_mdi_menu_contract.m_imagingtools.visible = false
//		   m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_next.toolbaritemvisible 		= false
//         gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_previous,'toolbaritemvisible', false)
//			lb_boolean = false
//		   m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan.visible	= false
//			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan,'toolbaritemvisible', false)
//			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_annotations.m_selectannotations,'toolbaritemvisible', false)
//			//m_pfe_cst_mdi_menu_contract.m_edit.visible = true
//         //m_pfe_cst_mdi_menu_contract.m_view.visible = true
//			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_insert,'toolbaritemvisible', true)
//	      gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_file.m_save,'toolbaritemvisible', true)
//			m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan.visible =  false
//         gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_insert,'toolbaritemvisible', true)
//			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_delete1,'toolbaritemvisible', true)
//			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_file.m_print,'toolbaritemvisible', false)
//
//			//--------------------------- APPEON BEGIN ---------------------------
//			//$<add> 2007-01-08 By: Rodger Wu
//			//$<reason> Fix a APB defect.
//			if classname(adw_tabpage) = "tabpage_images" then
//				m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan.visible	= true
//				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan,'toolbaritemvisible', true)
//				m_pfe_cst_mdi_menu_contract.m_imagingtools.m_image_view.visible	= true
//				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_image_view,'toolbaritemvisible', true)
//				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_image_view,'enabled', true) 
//			end if
//			//---------------------------- APPEON END ----------------------------
//
//end choose
//
//////////////////////////////////////////////////////////////////////////////////////////////////
//// WholeSale  menu changes
//////////////////////////////////////////////////////////////////////////////////////////////////
//
//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_editimage.visible 						= lb_boolean
//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_editimage.m_delete.visible 			= lb_boolean
//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_editimage.m_maximize.visible 			= lb_boolean
//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_editimage.m_objectcopy.visible 		= lb_boolean
//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_editimage.m_objectcut.visible 		= lb_boolean
//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_editimage.m_objectpaste.visible 		= lb_boolean
//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_editimage.toolbaritemvisible 						= lb_boolean
//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_editimage.m_delete.toolbaritemvisible 			= lb_boolean
//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_editimage.m_maximize.toolbaritemvisible 			= lb_boolean
//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_editimage.m_objectcopy.toolbaritemvisible 		= lb_boolean
//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_editimage.m_objectcut.toolbaritemvisible 		= lb_boolean
//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_editimage.m_objectpaste.toolbaritemvisible 		= lb_boolean
////m_pfe_cst_mdi_menu_contract.m_file.m_print.toolbaritemvisible = lb_boolean
//
//
//////////////////////////////////////////////////////////////////////////////////////////////////
//// show/hide view/edit menu
//////////////////////////////////////////////////////////////////////////////////////////////////
//
//
//if classname(adw_tabpage) = 'tabpage_search' then 
//	//m_pfe_cst_mdi_menu_contract.m_edit.visible = false
//   //m_pfe_cst_mdi_menu_contract.m_view.visible = false
//	m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan.visible	= false
//	w_mdi.setredraw(false) //(Appeon)Harry 03.10.2014 - V142 ISG-CLX
//	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_insert,'toolbaritemvisible', false)
//	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_file.m_save,'toolbaritemvisible', false)
//	w_mdi.setredraw(true) //(Appeon)Harry 03.10.2014 - V142 ISG-CLX
//else 
//	
//end if 
//
//if classname(adw_tabpage) = 'tabpage_view' then 
//		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_file.m_print,'toolbaritemvisible', true)
//			m_pfe_cst_mdi_menu_contract.m_file.m_print.text= 'Print Image'  
//		else
//		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_file.m_print,'toolbaritemvisible', false)
//	
//end if 
//
////--------------------------- APPEON BEGIN ---------------------------
////$<add> 09.22.2006 By: Lei Wei
////$<reason> Contract module modification
//
//if classname(adw_tabpage) = 'tabpage_action_items' then 
//	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_view.m_filter,'toolbaritemvisible', true)
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<add> 11.17.2006 By: Jervis
//	//$<reason> 
//	if gb_workflow then
//		m_pfe_cst_mdi_menu_contract.m_edit.m_workflow.visible = true
//		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_workflow,'toolbaritemvisible', true)
//	end if
//	
//	//<add> 06.12.2007 by: andy
//	m_pfe_cst_mdi_menu_contract.m_edit.m_letter.visible = true
//	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_letter,'toolbaritemvisible', true)	
//	//end of add
//	
//	//---------------------------- APPEON END ----------------------------
//
//else
//	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_view.m_filter,'toolbaritemvisible', false)
//	//--------------------------- APPEON BEGIN ---------------------------
//	//Add By Jervis 01.08.2009
//	if classname(adw_tabpage) = 'tabpage_details' and gb_workflow then
//		m_pfe_cst_mdi_menu_contract.m_edit.m_workflow.visible = true
//		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_workflow,'toolbaritemvisible', true)
//		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_delete1,'enabled', true) //jervis-12.7.2009
//	else
//	//End by Jervis 01.08.2009
//		//--------------------------- APPEON BEGIN ---------------------------
//		//$<add> 11.17.2006 By: Jervis
//		//$<reason> 
//		m_pfe_cst_mdi_menu_contract.m_edit.m_workflow.visible = false
//		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_workflow,'toolbaritemvisible', false)
//	end if
//
//	//<add> 06.12.2007 by: andy
//	m_pfe_cst_mdi_menu_contract.m_edit.m_letter.visible = false
//	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_letter,'toolbaritemvisible', false)	
//	//end of add
//	
//	//---------------------------- APPEON END ----------------------------
//end if
//
////---------------------------- APPEON END ----------------------------
//
////w_mdi.SetRedraw(true)
//
//return 0
//
//
//
////
////m_pfe_cst_mdi_menu_contract.m_imagingtools.m_annotations.m_filledrectandle.visible
////m_pfe_cst_mdi_menu_contract.m_imagingtools.m_annotations.m_freehandline.visible
////m_pfe_cst_mdi_menu_contract.m_imagingtools.m_annotations.m_hideallannotations.visible
////m_pfe_cst_mdi_menu_contract.m_imagingtools.m_annotations.m_hidenon-ocrzones.visible
////m_pfe_cst_mdi_menu_contract.m_imagingtools.m_annotations.m_hideocrtextzonehighlights.visible
////m_pfe_cst_mdi_menu_contract.m_imagingtools.m_annotations.m_highlighter.visible
////m_pfe_cst_mdi_menu_contract.m_imagingtools.m_annotations.m_hollowrectangle.visible
////m_pfe_cst_mdi_menu_contract.m_imagingtools.m_annotations.m_hyperlink.visible
////m_pfe_cst_mdi_menu_contract.m_imagingtools.m_annotations.m_makeannotationspermanent.visible
////m_pfe_cst_mdi_menu_contract.m_imagingtools.m_annotations.m_rubberstamp.visible
////m_pfe_cst_mdi_menu_contract.m_imagingtools.m_annotations.m_selectannotations.visible
////m_pfe_cst_mdi_menu_contract.m_imagingtools.m_annotations.m_straightline.visible
////m_pfe_cst_mdi_menu_contract.m_imagingtools.m_annotations.m_textfromfile.visible
////m_pfe_cst_mdi_menu_contract.m_imagingtools.m_annotations.m_typedtext.visible
////
////m_pfe_cst_mdi_menu_contract.m_imagingtools.m_editimage.visible
////m_pfe_cst_mdi_menu_contract.m_imagingtools.m_editimage.m_delete.visible
////m_pfe_cst_mdi_menu_contract.m_imagingtools.m_editimage.m_maximize.visible
////m_pfe_cst_mdi_menu_contract.m_imagingtools.m_editimage.m_objectcopy.visible
////m_pfe_cst_mdi_menu_contract.m_imagingtools.m_editimage.m_objectcut.visible
////m_pfe_cst_mdi_menu_contract.m_imagingtools.m_editimage.m_objectpaste.visible
////
////m_pfe_cst_mdi_menu_contract.m_imagingtools.m_ocr.visible
////m_pfe_cst_mdi_menu_contract.m_imagingtools.m_ocr.m_drawtextzone.visible
////m_pfe_cst_mdi_menu_contract.m_imagingtools.m_ocr.m_ocr0.visible
////m_pfe_cst_mdi_menu_contract.m_imagingtools.m_ocr.m_ocrwholeimage.visible
////m_pfe_cst_mdi_menu_contract.m_imagingtools.m_ocr.m_removeallocrzones.visible
////m_pfe_cst_mdi_menu_contract.m_imagingtools.m_ocr.m_showocrzones.visible
////
////m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.visible
////m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_appendblankpage.visible
////m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.visible
////m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_firstpage.visible
////m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_last.visible
////
////m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_appendblankpage.visible
////m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_right1.visible
////m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_rotateallpages.visible
////m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_straightenpage.visible
//


end function

public function long of_get_next_record_id ();
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-05
//$<modify> 03.28.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Replace the following script with of_get_id to provide
//$<modification> the same functionality.
/*
long ll_record_id

SELECT MAX(ids.record_id)
INTO :ll_record_id
FROM ids  ;

// scheck for nulls
if not f_validstr(string(ll_record_id)) then 
   ll_record_id = 1 
else 
	ll_record_id++
end if 

update ids set ids.record_id = :ll_record_id;

return ll_record_id
*/

RETURN gnv_app.of_get_id( "RECORD_ID" )

//---------------------------- APPEON END ----------------------------

end function

public function long of_get_active_status_code ();/******************************************************************************************************************
**  [PUBLIC]   : of_get_active_status_code
**==================================================================================================================
**  Purpose   	: Gets the code for active stats
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 13 Martch 2006 ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/



if il_active_code = 0 then
	
		//--------------------------- APPEON BEGIN ---------------------------
		//$<ID> PT-06
		//$<modify> 04.01.2006 By: LeiWei
		//$<reason> Performance tuning
		//$<modification> Write script to retrieve data from a cache instead of from the database.
		
		/*
		select lookup_code  
		into :il_active_code
		from code_lookup
		where lookup_name = 'Contract Status' and code = 'active';
		*/
		il_active_code = Long(gnv_data.of_getitem( "code_lookup", "lookup_code", "upper(lookup_name) = upper('Contract Status') and upper(code) = upper('active')"))
		//---------------------------- APPEON END ----------------------------
				
		if il_active_code < 1 or isnull(il_active_code) then 
			messagebox('Missisng Data','Active - lookup code from Contract Status is missing')
		end if 
		
end if

return il_active_code
			
	
end function

public function long of_get_history_status_code ();/******************************************************************************************************************
**  [PUBLIC]   : of_get_history_status_code
**==================================================================================================================
**  Purpose   	: Gets the code for active stats
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 13 Martch 2006 ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/



if il_history_code = 0 then
	
		//--------------------------- APPEON BEGIN ---------------------------
		//$<ID> PT-07
		//$<modify> 04.01.2006 By: LeiWei
		//$<reason> Performance tuning
		//$<modification> Write script to retrieve data from a cache instead of from the database.

		/*
		select lookup_code  
		into :il_history_code
		from code_lookup
		where lookup_name = 'Contract Status' and code = 'history';
		*/
		il_history_code = Long(gnv_data.of_getitem( "code_lookup", "lookup_code", "upper(lookup_name) = upper('Contract Status') and upper(code) = upper('history')"))
		//---------------------------- APPEON END ----------------------------
				
		if il_history_code < 1 or isnull(il_history_code) then 
			messagebox('Missisng Data','History - lookup code from Contract Status is missing')
		end if 
		
end if

return il_history_code
			
	
end function

public function long of_get_canceled_status_code ();/******************************************************************************************************************
**  [PUBLIC]   : of_get_canceled_status_code
**==================================================================================================================
**  Purpose   	: Gets the code for active stats
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 13 Martch 2006 ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/



if il_canceled_code = 0 then
	
		//--------------------------- APPEON BEGIN ---------------------------
		//$<ID> PT-08
		//$<modify> 04.01.2006 By: LeiWei
		//$<reason> Performance tuning
		//$<modification> Write script to retrieve data from a cache instead of from the database.
		
		/*
		select lookup_code  
		into :il_canceled_code
		from code_lookup
		where lookup_name = 'Contract Status' and code = 'canceled';
		*/
		il_canceled_code = Long(gnv_data.of_getitem( "code_lookup", "lookup_code", "upper(lookup_name) = upper('Contract Status') and upper(code) = upper('canceled')"))
		//---------------------------- APPEON END ----------------------------
				
		if il_canceled_code < 1 or isnull(il_canceled_code) then 
			messagebox('Missisng Data','History - lookup code from Contract Status is missing')
		end if 
		
end if

return il_canceled_code
			
	
end function

public subroutine of_set_protect_columns (boolean lb_protect);

ib_protect_columns = lb_protect
end subroutine

public function boolean of_get_protect_columns ();

return ib_protect_columns
end function

public subroutine of_set_tab_change (boolean ab_bool);

ib_allow_tab_change = ab_bool
end subroutine

public function boolean of_get_tab_change ();

return ib_allow_tab_change
end function

public function long of_get_par_unknown ();
if not f_validstr(string(il_par_unknown)) or il_par_unknown = 0 then 
		SELECT code_lookup.lookup_code  
		into :il_par_unknown   
		FROM code_lookup  
		WHERE code_lookup.lookup_name = 'Contract Practitioner Contract Stat'  
			      and code_lookup.code = 'Par. Unknown.';
	 
end if 
		 
		 
return il_par_unknown

end function

public function boolean of_get_is_ctx_medial ();
return ib_medical_contract

end function

public function integer of_set_contact_type (long al_ctx_type);/******************************************************************************************************************
**  [PUBLIC]   : of_set_contact_type( /*long al_ctx_type */)
**==================================================================================================================
**  Purpose   	: set the contract type
**==================================================================================================================
**  Arguments 	: [long] al_ctx_type
**==================================================================================================================
**  Returns   	: 
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner     24 June 2006         ? IntellisoftGroup Inc 2005
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


string ls_custom_6
LONG LL_CONTRACT_TYPE


//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 09.13.2006 By: LeiWei
//$<reason> Performance tuning
/*
select  custom_6
into   :ls_custom_6
from   code_lookup
where  lookup_name = 'Contract Category' AND lookup_code = :al_ctx_type   ;
*/

ls_custom_6 = gnv_data.of_getitem( "code_lookup", "custom_6", "lower(lookup_name) = lower('Contract Category') AND lookup_code = " + String(al_ctx_type) )

//---------------------------- APPEON END ----------------------------

CHOOSE CASE upper(ls_custom_6)
	CASE  'PAYORCTX'
		ib_medical_contract = TRUE
	CASE ELSE 
		ib_medical_contract = FALSE
		
END CHOOSE 

return 1

end function

public function integer of_set_old_ctx_id (long al_ctx_id);//messagebox('set',al_ctx_id)

il_old_ctx_id = al_ctx_id

return 0
end function

public function long of_get_old_ctx_id ();
//messagebox('get',il_ctx_id)
return il_old_ctx_id
end function

public function boolean of_get_protect_tabpg ();//Get access right in role painter for the current tabpage of contract window
//Added by Alfee 09.30.2007
Integer li_tabpg_id, li_access
Boolean lb_rtn

//Check role right to Contract module first(Main->Access Rights)
li_access = w_mdi.of_security_access(2070) 
IF li_access < 2 or Not IsValid(gw_contract) THEN //Read Only
	//Set read only flag at tab page level
	of_set_protect_columns(TRUE)
	RETURN TRUE 
END IF

//Check role right to the current tab page
li_tabpg_id = gw_contract.tab_contract_details.SelectedTab
CHOOSE CASE li_tabpg_id //for Access Rights
	CASE 1 //Search tab
		//nothing
	CASE 2 //Detail Tab
		li_access = w_mdi.of_security_access(2090)
	CASE 3 //Requirements
		li_access = w_mdi.of_security_access(2100)
	CASE 4 //Contacts
		li_access = w_mdi.of_security_access(2110)
	CASE 5 //Locations
		li_access = w_mdi.of_security_access(2120)
	CASE 6 //Organizations
		li_access = w_mdi.of_security_access(2130)		
	CASE 7 //Fee Schedules
		li_access = w_mdi.of_security_access(2140)		
	CASE 8 //Fees Non-Medical
		li_access = w_mdi.of_security_access(2220)		
	CASE 9 //Document Manager
		li_access = w_mdi.of_security_access(2150)		
	CASE 10 //Action Items
		li_access = w_mdi.of_security_access(2160)				
	CASE 11 //Analysis
		li_access = w_mdi.of_security_access(2170)				
//	CASE 12 //QRG														//Commented By Mark Lee 02/06/2013
//		li_access = w_mdi.of_security_access(2180)	
	Case 12	//Email Manager										//Added By Mark Lee 02/06/2013
		li_access = w_mdi.of_security_access(6984)	
	CASE ELSE
		//		
END CHOOSE

IF li_access > 1 THEN  //Full Access	
	IF gw_contract.tab_contract_details.tabpage_search.inv_contract_details.is_mode = &
		gw_contract.tab_contract_details.tabpage_search.inv_contract_details.new THEN //new contract
		lb_rtn = FALSE //Full Access
	ELSE
		lb_rtn = gw_contract.tab_contract_details.tabpage_search.ib_readonly_current //current contract
	END IF	
ELSE
	lb_rtn = TRUE //Read Only
END IF

//Set read only flag at tab page level
of_set_protect_columns(lb_rtn) 

Return lb_rtn
end function

public function boolean of_get_protect_contract ();//Get access right for the current contract
//Added by Alfee 09.30.2007
Integer li_tabpg_id, li_access
Boolean lb_rtn

IF Not IsValid(gw_contract) THEN RETURN TRUE //Read Only

//Check role right to Contract module first(Main->Access Rights)
li_access = w_mdi.of_security_access(2070) 
If li_access < 2 THEN RETURN TRUE //Read Only

//Check user right to the current contract
lb_rtn = gw_contract.tab_contract_details.tabpage_search.ib_readonly_current 

RETURN lb_rtn

end function

public function boolean of_allow_newctx ();//Get access right to Contract module
//Added by Alfee 09.30.2007
Integer li_access
Boolean lb_readonly = FALSE

li_access = w_mdi.of_security_access(2070)  //Main->Access Rights
IF li_access > 1 THEN 
	li_access = w_mdi.of_security_access(2090) //Detail Tab
	IF li_access < 2 THEN lb_readonly = TRUE
ELSE
	lb_readonly = TRUE
END IF

RETURN NOT lb_readonly

end function

public function boolean of_allow_copyctx ();//Get access right to copy a contract
//Added by Alfee 09.30.2007
Integer li_access
Boolean lb_readonly = FALSE

//Read only control to Contract module
li_access = w_mdi.of_security_access(2070)  //Main->Access Rights
IF li_access > 1 THEN 
	li_access = w_mdi.of_security_access(2090) //Detail Tab
	IF li_access < 2 THEN lb_readonly = TRUE 
ELSE
	lb_readonly = TRUE 
END IF

//Read only control to current contract 
IF not lb_readonly THEN
	lb_readonly = gw_contract.tab_contract_details.tabpage_search.ib_readonly_current
END IF

RETURN NOT lb_readonly

end function

public function string of_getelementdoc (long al_elements_id);//====================================================================
// Function: of_GetElementDoc()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    long    al_elements_id
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-06-30
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Contractlogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String	ls_ShortFileName,ls_FullFileName,ls_AgrDir,ls_UpdateDT
long		ll_DataLen,ll_Cycle,ll_Count,ll_Start
Blob		lblb_Document,lb_Temp

DateTime	ldt_LastUpdate

long READ_ONE_LENGTH = 8000

ls_ShortFileName = "reqmnt_" + String(al_elements_id) + ".doc"

ls_AgrDir = gs_dir_path + gs_DefDirName + "\agreement\"
gnv_AppeonDLL.of_ParsePath(ls_AgrDir)
ls_FullFileName = ls_AgrDir + ls_ShortFileName

SELECT DATALENGTH(image_file),Modify_Date
  INTO :ll_DataLen,:ldt_LastUpdate
  FROM ctx_elements
 WHERE ctx_elements_id = :al_elements_id;

RegistryGet(is_RegKey,ls_ShortFileName,RegString!,ls_UpdateDT)

if FileExists(ls_FullFileName) and String(ldt_LastUpdate) = ls_UpdateDT then
	Return ls_FullFileName
end if

//RegistrySet(is_RegKey,ls_ShortFileName,RegString!,String(ldt_LastUpdate))
gnv_AppeonDLL.of_RegistrySet(is_RegKey,ls_ShortFileName,RegString!,String(ldt_LastUpdate)) //Modified By Ken.Guo 2009-07-14

if AppeonGetClientType() = 'PB' and gs_dbtype = 'SQL' and ll_DataLen > READ_ONE_LENGTH then
	ll_Count = Ceiling(ll_DataLen/READ_ONE_LENGTH)
	
	for ll_Cycle = 1 To ll_Count
		ll_Start = (ll_Cycle - 1) * READ_ONE_LENGTH + 1
		SELECTBLOB SubString(image_file,:ll_Start,:READ_ONE_LENGTH)
		      INTO :lb_Temp
		      FROM ctx_elements
		     WHERE ctx_elements_id = :al_elements_id;
		
		lblb_Document += lb_Temp
	next
else
	SELECTBLOB image_file
	      INTO :lblb_Document
	      FROM ctx_elements
	     WHERE ctx_elements_id = :al_elements_id;
end if

AppeonWriteFile(ls_FullFileName,lblb_Document,ll_DataLen)

Return ls_FullFileName

end function

public function integer of_writefile (string as_filename, ref blob ablb_data);blob lblb_Buf
long ll_BlobLen
long ll_CurrentPos
long l, ll_Writes
integer li_FileNum

gnv_AppeonDLL.of_ParsePath(Left(as_FileName,LastPos(as_FileName,"\")))		//Added by Scofield on 2009-07-21

// Create a local file
//---------Begin Modified by Alfee 03.27.2008------------------------------------
li_FileNum = FileOpen(as_FileName, StreamMode!, Write!, LockWrite!, Replace!)
if IsNull(li_FileNum) or li_FileNum < 0 then Return -1
//li_FileNum = FileOpen(as_FileName, StreamMode!, Write!, LockReadWrite!, Replace!)
//if li_FileNum < 0 then Return -1
//---------End Modified ---------------------------------------------------------

ll_BlobLen = Len(ablb_Data)

// Write data
if ll_BlobLen > 0 then
	if ll_BlobLen > 32765 then
		 if Mod(ll_BlobLen, 32765) = 0 then
			 ll_Writes = ll_BlobLen / 32765
		 else
			 ll_Writes = (ll_BlobLen / 32765) + 1
		 end if
	else
		ll_Writes = 1
	end if
	ll_CurrentPos = 1
	
	For l = 1 To ll_Writes
		lblb_Buf = BlobMid(ablb_Data, ll_CurrentPos, 32765)
		ll_CurrentPos += 32765
		if FileWrite(li_FileNum, lblb_Buf) = -1 then
			FileClose(li_FileNum) //Alfee 03.27.2008
			Return -1
		end if
	Next
end if

// Close file
FileClose(li_FileNum)

Return 1
end function

public function integer of_delete_ctx_detail (long al_ctx_id);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_contract::of_delete_ctx_detail()
// $<arguments>
//		value	long	al_ctx_id		
// $<returns> integer
// $<description> Delete Contract's sub info. No include main table: ctx_basic_info 
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2009-08-27 by Ken.Guo
//////////////////////////////////////////////////////////////////////

gnv_appeondb.of_startqueue( )		
if gs_dbtype <> "ASA" then
	DELETE FROM  CTX_LOCATION_CONTACTS WHERE ctx_id = :al_ctx_id;
	DELETE FROM  CTX_LOCATION_SPECIALTY WHERE ctx_id = :al_ctx_id;
	DELETE FROM  CTX_LOCATION_PRACS WHERE ctx_id = :al_ctx_id;
	DELETE FROM  CTX_LOC WHERE ctx_id = :al_ctx_id;
	
	DELETE FROM  CTX_ELEMENTS WHERE CTX_REQ_PROFILE_HDR_id in (SELECT a.CTX_REQ_PROFILE_HDR_id FROM CTX_REQ_PROFILE_HDR a WHERE a.ctx_id = :al_ctx_id);
	DELETE FROM  CTX_REQ_PROFILE_HDR WHERE ctx_id = :al_ctx_id;
	
	DELETE FROM  CTX_FEE_SCHED_DATA WHERE fee_sched_location_id in (SELECT a.fee_sched_location_id FROM CTX_FEE_SCHED_LOCATIONS a where a.fee_sched_id in (SELECT b.fee_sched_id FROM CTX_FEE_SCHED_HDR b WHERE b.ctx_id = :al_ctx_id));
	DELETE FROM  CTX_FEE_SCHED_LOCATIONS WHERE fee_sched_id in (SELECT a.fee_sched_id FROM CTX_FEE_SCHED_HDR a WHERE a.ctx_id = :al_ctx_id);
	DELETE FROM  CTX_FEE_SCHED_PRACS WHERE fee_sched_id in (SELECT a.fee_sched_id FROM CTX_FEE_SCHED_HDR a WHERE a.ctx_id = :al_ctx_id);		
	DELETE FROM  CTX_FEE_SCHED_HDR WHERE ctx_id = :al_ctx_id;
	
	DELETE FROM  CTX_FILE_LOCATION WHERE ctx_id = :al_ctx_id;
	DELETE FROM  CTX_ORGS_CONTACT WHERE ctx_id = :al_ctx_id;
	DELETE FROM  CTX_AI_NOTIFICATION_USERS WHERE ctx_id = :al_ctx_id; //Alfee 02.26.2008
	DELETE FROM  ctx_ai_alarm_attachment WHERE ctx_id = :al_ctx_id; 	//Added by Scofield on 2009-02-24
	DELETE FROM  CTX_AI_NOTIFICATION WHERE ctx_id = :al_ctx_id; 		//Alfee 02.26.2008
	DELETE FROM  CTX_ACTION_ITEMS WHERE ctx_id = :al_ctx_id;
	DELETE FROM  CTX_IMAGE WHERE ctx_id = :al_ctx_id;
	DELETE FROM  CTX_IMAGES WHERE ctx_id = :al_ctx_id;
	DELETE FROM  CTX_NOTIFICATION_USERS WHERE ctx_id = :al_ctx_id;
	DELETE FROM  ctx_alarm_attachment WHERE ctx_id = :al_ctx_id;		//Added by Scofield on 2009-02-24
	DELETE FROM  CTX_NOTIFICATION WHERE ctx_id = :al_ctx_id;
	DELETE FROM  CTX_FEE_SCHED_NM WHERE ctx_id = :al_ctx_id;
	DELETE FROM  ctx_products WHERE ctx_id = :al_ctx_id;
	DELETE FROM  CTX_CONTRACT_CONTACTS WHERE ctx_id = :al_ctx_id;
	
	//Delete custom and multi data -- jervis 06.09.2011
	DELETE FROM  ctx_custom WHERE ctx_id = :al_ctx_id;
	DELETE FROM  ctx_custom_multi_detail WHERE ctx_id = :al_ctx_id;
	DELETE FROM  ctx_custom_multi_hdr WHERE ctx_id = :al_ctx_id;
end if
DELETE FROM  ctx_version WHERE ctx_id = :al_ctx_id;
DELETE FROM  sys_StatusAudit WHERE ctx_id = :al_ctx_id;					//Added by Scofield on 2008-05-22
DELETE FROM  dashboard_gadgets_recent WHERE UPPER(recent_type) = 'CTX' AND data_id = :al_ctx_id;	//Added by Scofield on 2009-08-07
Delete From  ctx_templates_info Where ctx_id = :al_ctx_id; //Added By Ken.Guo 2009-08-28.
commit;

// Delete document data	//Added by Davis 01.29.2007
DELETE FROM  Ctx_am_doc_audit WHERE doc_id In (Select doc_id From Ctx_am_document Where ctx_id = :al_ctx_id );
DELETE FROM  CTX_AM_AI_NOTIFICATION_USERS WHERE doc_id In (Select doc_id From Ctx_am_document Where ctx_id = :al_ctx_id ); //Alfee 02.26.2008
DELETE FROM  ctx_am_ai_alarm_attachment WHERE doc_id In (Select doc_id From Ctx_am_document Where ctx_id = :al_ctx_id ); 	//Added by Scofield on 2009-02-24
DELETE FROM  CTX_AM_AI_NOTIFICATION WHERE doc_id In (Select doc_id From Ctx_am_document Where ctx_id = :al_ctx_id ); 		//Alfee 02.26.2008
DELETE FROM  ctx_am_action_item WHERE doc_id In (Select doc_id From Ctx_am_document Where ctx_id = :al_ctx_id );
DELETE FROM  Ctx_am_document_clause WHERE doc_id In (Select doc_id From Ctx_am_document Where ctx_id = :al_ctx_id );	
DELETE FROM  Ctx_am_doc_image WHERE doc_id In (Select doc_id From Ctx_am_document Where ctx_id = :al_ctx_id );
DELETE FROM  Ctx_am_document WHERE ctx_id = :al_ctx_id;
DELETE FROM ctx_alarm_attachment WHERE ctx_id = :al_ctx_id;
DELETE FROM ctx_ai_alarm_attachment WHERE  ctx_id = :al_ctx_id;
DELETE FROM ctx_ai_notification where ctx_id = :al_ctx_id;
DELETE FROM ctx_products where ctx_id = :al_ctx_id;
DELETE FROM  sys_StatusAudit WHERE ctx_id = :al_ctx_id;

//Added by Appeon long.zhang 08.26.2014 (v14.2 BugH082103 of IntelliCredApp V14.2 Issues of New Features)
delete from ctx_prac_link where ctx_id = :al_ctx_id ;

Update ctx_basic_info Set master_contract_id = 0 Where master_contract_id = :al_ctx_id;   //Added By Ken.Guo 2009-05-18.
gnv_appeondb.of_commitqueue( )


Return 1
end function

public function integer of_set_alarm (u_dw adw_screen, string as_table, dwobject dwo);//Set Alarm - Add by jervis 05.18.2011

string ls_datatype, ls_dwoname,ls_ColName,ls_filename
str_pass lstr_pass 
long ll_ctx_id
long ll_level_id1,ll_level_id2
long ll_doc_id

////if of_check_read_only( ) then return success  //Add by Jack 08.30.2007


//Added By Ken.Guo 2010-01-07.
adw_screen.accepttext()
//if not f_validstr(string(adw_screen.getItemNumber(1,'ctx_id'))) then
	IF gw_contract.EVENT DYNAMIC UE_SAVE() <> 1 THEN RETURN  0
//end if 

//add by jervis - 07.01.2011
ll_ctx_id = adw_screen.getitemnumber(adw_screen.getrow(),'ctx_id')
choose case lower(as_table)
	case 'ctx_basic_info','ctx_custom'
		
	case 'ctx_custom_multi_hdr'
		//ll_ctx_id = adw_screen.getitemnumber(adw_screen.getrow(),'ctx_id')
		ll_level_id1 = adw_screen.getitemnumber(adw_screen.getrow(),'hdr_id')
	case 'ctx_custom_multi_detail'
		ll_level_id1 = adw_screen.getitemnumber(adw_screen.getrow(),'hdr_id')
		ll_level_id2 = adw_screen.getitemnumber(adw_screen.getrow(),'detail_id')
	case 'ctx_fee_sched_nm'  //jervis 08.02.2011
		ll_level_id1 = adw_screen.GetItemNumber(adw_screen.getrow(),'fee_sched_nm_id')
end choose
ls_dwoname = lower( dwo.name )

if left( ls_dwoname , 2 ) = "b_" then
	if Right(ls_dwoname,2) = '_r' or Right(ls_dwoname,2) = '_g' then //jervis - 07.07.2011
		ls_colname = Mid(ls_dwoname,3,Len(ls_dwoname) - 4)
	else
		ls_colname = Mid(ls_dwoname,3 )
	end if
	ls_datatype = adw_screen.Describe( ls_colname + ".ColType" )
end if

//--------Begin Added by Alfee 09.27.2007-----------------------------

String ls_contract_status, ls_alarm_enabled, ls_msg

IF Lower(ls_datatype) = 'datetime' and IsValid(gw_contract) THEN
	//ls_ColName = Mid(dwo.Name,3)
	
	if isnumber(adw_screen.Describe(ls_ColName + ".x")) then		
		//Return if the alarm disabled to the current contract stauts
		/*
		comment by jervis - 07.01.2011
		IF gw_contract.tab_contract_details.tabpage_details.uo_1.dw_1.RowCount() > 0 THEN 
			ls_contract_status = String(gw_contract.tab_contract_details.tabpage_details.uo_1.dw_1.GetItemNumber(1, 'status'))
		END IF
		IF NOT IsNull(ls_contract_status) THEN ls_alarm_enabled = gnv_data.of_getitem('code_lookup','custom_1',"lookup_name = 'Contract Status' and lookup_code = " + ls_contract_status)
		*/
		select code_lookup.custom_1 into :ls_alarm_enabled from ctx_basic_info,code_lookup
		where ctx_id = :ll_ctx_id and status = lookup_code;
		
		IF Upper(ls_alarm_enabled) <> 'YES' THEN
			ls_msg = "Alarms can't be set because the Contract Status you have selected has the Alarmed Enabled flag set to No.  "
			ls_msg +="To change this setting go to the System->Lookup Painter and select the Contract Status lookup table and change the Alarms Enabled Flag to Yes." 
			MessageBox("Contract Alarms", ls_msg)
			RETURN 0
		END IF
		
		adw_screen.SetColumn(ls_ColName)
		
		
		if Of_Show_Missing_Msg(ls_ColName, adw_screen,ls_datatype,adw_screen.getrow()) = 1 then
			lstr_pass.s_string_array[1] = String(ll_ctx_id)
			lstr_pass.s_string_array[2] = as_table
			lstr_pass.s_string_array[3] = ls_ColName
			lstr_pass.s_string_array[4] = adw_screen.Describe(ls_ColName + "_t.Text")
			
			//add hdr_id and detail_id - jervis 07.01.2011
			lstr_pass.s_string_array[6] = string(ll_level_id1)
			lstr_pass.s_string_array[7] = string(ll_level_id2)
			lstr_pass.s_datetime[1] = adw_screen.GetItemDateTime(adw_screen.getrow(),ls_ColName) //Get Alarm Date - jervis 07.50.2011
			OpenWithParm(w_ctx_alarm, lstr_pass)
			adw_screen.SetColumn(ls_ColName)
		else
			return 0
		end if
		
		
		choose case lower(as_table)
			case 'ctx_basic_info','ctx_custom'
				ls_filename = f_set_flag(as_table, ls_ColName, ll_ctx_id,ll_doc_id,ll_level_id1,ll_level_id2)
				adw_screen.Modify(ls_dwoname + ".filename ='" + ls_filename + "'")
			//case 'ctx_custom_multi_hdr','ctx_custom_multi_detail'
			case else //add fee scheduce --jervis 08.02.2011
				adw_screen.SetItem( adw_screen.getrow(), ls_ColName + "_flag", f_set_ai_flag(as_table, ls_ColName,ll_ctx_id,ll_doc_id, ll_level_id1 ,ll_level_id2))
				adw_screen.SetItemStatus(adw_screen.getrow(), ls_ColName + "_flag", Primary!, NotModified!)	
		end choose
	
		gw_contract.Function Dynamic Of_Set_Validation(True) // Add by Jack 05/04/2007
		return 1
	else
		return 0
	end if
else
	return 0
END IF



/*
SetPointer(HourGlass!)
adw_screen.object.b_custom_date1.filename = f_set_flag('ctx_basic_info', 'custom_date1', ll_ctx_id)
adw_screen.object.b_custom_date2.filename = f_set_flag('ctx_basic_info', 'custom_date2', ll_ctx_id)
adw_screen.object.b_custom_date3.filename = f_set_flag('ctx_basic_info', 'custom_date3', ll_ctx_id)
adw_screen.object.b_custom_date4.filename = f_set_flag('ctx_basic_info', 'custom_date4', ll_ctx_id)
adw_screen.object.b_custom_date5.filename = f_set_flag('ctx_basic_info', 'custom_date5', ll_ctx_id)
adw_screen.object.b_custom_date6.filename = f_set_flag('ctx_basic_info', 'custom_date6', ll_ctx_id)
adw_screen.object.b_custom_date7.filename = f_set_flag('ctx_basic_info', 'custom_date7', ll_ctx_id)
adw_screen.object.b_custom_date8.filename = f_set_flag('ctx_basic_info', 'custom_date8', ll_ctx_id)
adw_screen.object.b_custom_date9.filename = f_set_flag('ctx_basic_info', 'custom_date9', ll_ctx_id)
adw_screen.object.b_custom_date10.filename = f_set_flag('ctx_basic_info', 'custom_date10', ll_ctx_id)

//BEGIN---Modify by Scofield on July-28 2009 Tuesday
adw_screen.object.b_custom_date11.filename = f_set_flag('ctx_basic_info', 'custom_date11', ll_ctx_id)
adw_screen.object.b_custom_date12.filename = f_set_flag('ctx_basic_info', 'custom_date12', ll_ctx_id)
adw_screen.object.b_custom_date13.filename = f_set_flag('ctx_basic_info', 'custom_date13', ll_ctx_id)
adw_screen.object.b_custom_date14.filename = f_set_flag('ctx_basic_info', 'custom_date14', ll_ctx_id)
adw_screen.object.b_custom_date15.filename = f_set_flag('ctx_basic_info', 'custom_date15', ll_ctx_id)
//END---Modify by Scofield on July-28 2009 Tuesday
*/


//iw_parent.Function Dynamic Of_Set_Validation(True) // Add by Jack 05/04/2007
//SetPointer(Arrow!)
//---------------------------- APPEON END ----------------------------

end function

public subroutine of_set_alarm_flag (u_dw adw_screen, string as_table, string as_columns[], long al_ctx_id, long al_doc_id, long al_level_id1, long al_level_id2);//Refresh Alarm Flag - Add by jervis 05.19.2011
long ll_i,ll_count
string ls_filename

ll_count = UpperBound(as_columns)
for ll_i = 1 to ll_count
	ls_filename = f_set_flag(as_table, as_columns[ll_i], al_ctx_id,al_doc_id,al_level_id1,al_level_id2)
	adw_screen.Modify("b_" + as_columns[ll_i] + ".filename ='" + ls_filename + "'")
next

end subroutine

public subroutine of_reset_alarm (u_dw adw_alarm, string as_table, dwobject dwo);//Added by Jervis 07.04.2011
//<$Reason>If a user clears a date then the alarm for that date should also be cleared out.
	
long ll_ctxid, ll_find
string ls_colname, ls_msg, ls_filename
boolean lb_alarm = TRUE //01.26.2008
BOOLEAN lb_refresh_ai = FALSE	
long ll_doc_id,ll_hdr_id,ll_detail_id,ll_row
long ll_action_id
datastore lds_wf_triggered
boolean lb_del_wf_ai = FALSE
long ll_cnt,ll_found,ll_wf_id
string ls_dwoname
string ls_datatype



ls_colname = dwo.name
ls_datatype = adw_alarm.Describe( ls_colname + ".ColType" )


ll_row = adw_alarm.GetRow()

if adw_alarm.Describe("DataWindow.ReadOnly") = "yes" or adw_alarm.Describe(ls_colname + ".protect") <> "0" or adw_alarm.Describe(ls_colname + ".TabSequence") = "0" then return

if ls_datatype = "datetime" then
	if Not IsNull(adw_alarm.GetItemDateTime(ll_row, ls_colname) ) then return

	ll_ctxid = adw_alarm.getitemnumber( ll_row, "ctx_id")
	lds_wf_triggered = Create DataStore
	
	choose case lower(as_table)
		case 'ctx_basic_info','ctx_custom'
			ll_ctxid = adw_alarm.getitemnumber( ll_row, "ctx_id")
			lds_wf_triggered.Dataobject = 'd_alm_wf_triggered'
			lds_wf_triggered.SetTransObject(SQLCA)
			ll_cnt = lds_wf_triggered.Retrieve(ll_ctxid)
		case 'ctx_action_item'
			ll_ctxid = adw_alarm.getitemnumber( ll_row, "ctx_id")
			ll_action_id = adw_alarm.GetItemNumber(ll_row,'ctx_action_item_id')
		case 'ctx_am_action_item'
			ll_ctxid = 0
			ll_doc_id = adw_alarm.GetItemNumber(ll_row,'doc_id')
			ll_action_id = adw_alarm.GetItemNumber(ll_row,'seq_id')
		case 'ctx_custom_multi_hdr'
			ll_ctxid = adw_alarm.getitemnumber( ll_row, "ctx_id")
			ll_doc_id = 0
			ll_hdr_id = adw_alarm.GetItemNumber(ll_row,'hdr_id')
			ll_detail_id = 0
			lds_wf_triggered.Dataobject = 'd_alm_all_wf_triggered'
			lds_wf_triggered.SetTransObject(SQLCA)
			ll_cnt = lds_wf_triggered.Retrieve(ll_ctxid,ll_doc_id,ll_hdr_id,ll_detail_id,as_table)
		case 'ctx_custom_multi_detail'
			ll_ctxid = adw_alarm.getitemnumber( ll_row, "ctx_id")
			ll_doc_id = 0
			ll_hdr_id = adw_alarm.GetItemNumber(ll_row,'hdr_id')
			ll_detail_id = adw_alarm.GetItemNumber(ll_row,'detail_id')
			lds_wf_triggered.Dataobject = 'd_alm_all_wf_triggered'
			lds_wf_triggered.SetTransObject(SQLCA)
			ll_cnt = lds_wf_triggered.Retrieve(ll_ctxid,ll_doc_id,ll_hdr_id,ll_detail_id,as_table)
		case 'ctx_fee_sched_nm'  //jervis - 08.02.2011
			ll_ctxid = adw_alarm.getitemnumber( ll_row, "ctx_id")
			ll_doc_id = 0
			ll_hdr_id = adw_alarm.GetItemNumber(ll_row,'fee_sched_nm_id')
			ll_detail_id = 0
			lds_wf_triggered.Dataobject = 'd_alm_all_wf_triggered'
			lds_wf_triggered.SetTransObject(SQLCA)
			ll_cnt = lds_wf_triggered.Retrieve(ll_ctxid,ll_doc_id,ll_hdr_id,ll_detail_id,as_table)
	end choose
	
	//Checking if there are any action items from workflow need to be deleted
	

	ll_found = lds_wf_triggered.Find("Lower(alm_column) = '" + Lower(ls_colname) + "'", 1, ll_cnt)
	IF ll_found > 0 THEN ll_wf_id = lds_wf_triggered.GetItemNumber(ll_found, "wf_id")
	IF ll_wf_id > 0 AND NOT lds_wf_triggered.Find("wf_id = " + String(ll_wf_id) + " AND Lower(alm_column) <> '" + Lower(ls_colname) + "'",1, ll_cnt) > 0 THEN
		lb_del_wf_ai = TRUE
	END IF	
	Destroy lds_wf_triggered
	
	//Delete the alarm setting if it's existed.
	if lb_alarm then 
		SetPointer(HourGlass!)
		gnv_appeondb.of_startqueue()
		choose case lower(as_table)
			case 'ctx_basic_info','ctx_custom'
				delete from ctx_notification_users where ctx_id = :ll_ctxid and alm_table = :as_table and alm_column = :ls_colname ;
				delete from ctx_alarm_attachment where ctx_id = :ll_ctxid and alm_table = :as_table and alm_column = :ls_colname ;		//Added by Scofield on 2009-02-24
				delete from ctx_notification where ctx_id = :ll_ctxid and alm_table = :as_table and alm_column = :ls_colname ;
				delete from ctx_action_items where ctx_id = :ll_ctxid and alm_table = :as_table and alm_column = :ls_colname ;  		//Added By Ken.Guo 2009-09-16. //alfee 12.09.2008	
				delete from ctx_alm_snooze   where ctx_id = :ll_ctxid and alm_table = :as_table and alm_column = :ls_colname ; 		//Added By Ken.Guo 2009-09-16.
			case 'ctx_action_item'
				delete from ctx_am_ai_notification_users where ctx_id = :ll_ctxid and alm_table = :as_table and alm_column = :ls_colname and ctx_action_item_id = :ll_action_id ;
				delete from ctx_am_ai_alarm_attachment where ctx_id = :ll_ctxid and alm_table =:as_table and alm_column = :ls_colname  and ctx_action_item_id = :ll_action_id;
				delete from ctx_am_ai_notification where ctx_id = :ll_ctxid and alm_table = :as_table and alm_column = :ls_colname  and ctx_action_item_id = :ll_action_id;
			case 'ctx_am_action_item'
				delete from ctx_ai_notification_users where doc_id = :ll_doc_id and seq_id = :ll_action_id and alm_table = :as_table and alm_column = :ls_colname ;
				delete from ctx_ai_alarm_attachment where doc_id = :ll_doc_id and seq_id = :ll_action_id and alm_table = :as_table and alm_column = :ls_colname;
				delete from ctx_ai_notification where doc_id = :ll_doc_id and seq_id = :ll_action_id and alm_table = :as_table and alm_column = :ls_colname;
			//case 'ctx_custom_multi_hdr','ctx_custom_multi_detail'
			case else //add fee scheduce --jervis 08.02.2011
				delete from ctx_all_alarm_attachment where ctx_id = :ll_ctxid and doc_id = :ll_doc_id and level_id1 = :ll_hdr_id and level_id2 = :ll_detail_id and alm_table = :as_table and alm_column = :ls_colname;
				delete from ctx_all_notification where ctx_id = :ll_ctxid and doc_id = :ll_doc_id and level_id1 = :ll_hdr_id and level_id2 = :ll_detail_id and alm_table = :as_table and alm_column = :ls_colname;
				delete from ctx_action_items where  ctx_id = :ll_ctxid and doc_id = :ll_doc_id and level_id1 = :ll_hdr_id and level_id2 = :ll_detail_id and alm_table = :as_table and alm_column = :ls_colname;
				delete from ctx_alm_snooze   where ctx_id = :ll_ctxid and doc_id = :ll_doc_id and level_id1 = :ll_hdr_id and level_id2 = :ll_detail_id and alm_table = :as_table and alm_column = :ls_colname;
		end choose
		
		IF lb_del_wf_ai THEN 
			delete from ctx_action_items where ctx_id = :ll_ctxid and wf_id = :ll_wf_id ; //alfee 12.09.2008
		END IF
		gnv_appeondb.of_commitqueue()
		
		//detele cache data - jervis 07.04.2011
		if sqlca.sqlcode = 0 then 
			ls_msg = "lower(alm_table) = '" + lower(as_table) + "' and upper(alm_column) = '" + upper(ls_colname) + "' "
			ls_msg +=" and ctx_id = " + String(ll_ctxid)
			choose case lower(as_table)
				case 'ctx_basic_info','ctx_custom'
					//------------------------------------------------------------------------
					// 2.24.2016 RP added
					gnv_data.of_retrieveIfNecessary("ctx_notification", FALSE)
					//------------------------------------------------------------------------
					ll_find = gnv_data.ids_ctx_notification.Find(ls_msg, 1, gnv_data.ids_ctx_notification.Rowcount())	
					if ll_find > 0 then gnv_data.ids_ctx_notification.DeleteRow(ll_find)
				//case 'ctx_custom_multi_hdr','ctx_custom_multi_detail'
				case else //add fee scheduce --jervis 08.02.2011
					//------------------------------------------------------------------------
					// 2.24.2016 RP added
					gnv_data.of_retrieveIfNecessary("ctx_all_notification", FALSE)
					//------------------------------------------------------------------------
					ls_msg +=" and doc_id = " + String(ll_doc_id) + " and level_id1 = " + String(ll_hdr_id) + " and level_id2 = " + String(ll_detail_id)
					ll_find = gnv_data.ids_ctx_all_notification.Find(ls_msg, 1, gnv_data.ids_ctx_all_notification.Rowcount())	
					if ll_find > 0 then gnv_data.ids_ctx_all_notification.DeleteRow(ll_find)
			end choose
		end if

		//Checking if action items need to be refreshed
		IF gw_contract.tab_contract_details.tabpage_action_items.tab_1.tabpage_detail.dw_1.rowcount( ) > 0 OR &
			gw_contract.tab_contract_details.tabpage_action_items.tab_1.tabpage_detail.dw_1.FilteredCount( ) > 0 OR &
			gw_contract.tab_contract_details.tabpage_action_items.tab_1.tabpage_detail.dw_1.DeletedCount( ) > 0 THEN
			lb_refresh_ai = TRUE
		END IF	

		//Added By Ken.Guo 2009-09-16. //Refresh action items if needed - alfee 12.09.2008 
		IF lb_refresh_ai THEN 
			gw_contract.tab_contract_details.tabpage_action_items.tab_1.tabpage_detail.of_retrieve() 
		END IF

		//Reset the flag for the button	
		
		choose case lower(as_table)
			case 'ctx_basic_info','ctx_custom'
				ls_filename = f_set_flag(as_table, ls_colname, ll_ctxid,ll_doc_id,ll_hdr_id,ll_detail_id)
				adw_alarm.modify("b_"+ ls_colname + ".FileName ='" + ls_filename + "'")
			case 'ctx_action_item','ctx_am_action_item'
				adw_alarm.SetItem( ll_row, ls_ColName + "_flag", f_set_ai_flag(as_table, ls_ColName,ll_ctxid,ll_doc_id, ll_action_id ,ll_detail_id))
				adw_alarm.SetItemStatus(ll_row, ls_ColName + + "_flag", Primary!, NotModified!)	
			//case 'ctx_custom_multi_hdr','ctx_custom_multi_detail'
			case else //add fee scheduce --jervis 08.02.2011
				adw_alarm.SetItem( ll_row, ls_ColName + "_flag", f_set_ai_flag(as_table, ls_ColName,ll_ctxid,ll_doc_id, ll_hdr_id ,ll_detail_id))
				adw_alarm.SetItemStatus(ll_row, ls_ColName, Primary!, NotModified!)	
			
		end choose
	end if	
	
end if		



end subroutine

public function integer of_show_missing_msg (string as_column_name, u_dw adw, string as_field_type, long al_row);/******************************************************************************************************************
**  [PUBLIC]   : of_show_missing_msg
**==================================================================================================================
**  Purpose   	: Display a missing data message
**==================================================================================================================
**  Arguments 	: [string]  AS_COLUMN_NAME
					  [u_dw]    ADW
					  [string]  as_field_type
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 12 October 2005  ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

string ls_statement1
string ls_statement2
string ls_title

ls_statement1 = 'The field '
ls_statement2 = ' is missing a value. Please enter one and try again.'
//ls_title       = 'Missing Infomation'
ls_title       = 'Missing Information'  //(Appeon)Harry 10.30.2013 - V141 ISG-CLX  for V14 Testing - Bug # 3720:modify 'Missing Infomation' to 'Missing Information'


choose case lower(as_field_type)
	case 'date'
		if not f_validstr(string(ADw.getitemDate(al_row, as_column_name))) then 
			messagebox(ls_title, ls_statement1 +  ADW.INV_base.OF_GETcolumndisplayname(AS_COLUMN_NAME ) + ls_statement2)
			ADW.setcolumn( AS_COLUMN_NAME)
			return 0
		end if 
		
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 07.10.2006 By: Rodger Wu
	//$<reason> fix a defect.
	case 'datetime'
		if not f_validstr(string(ADw.getitemDatetime(al_row, as_column_name))) then 
			messagebox(ls_title, ls_statement1 +  ADW.INV_base.OF_GETcolumndisplayname(AS_COLUMN_NAME ) + ls_statement2)
			ADW.setcolumn( AS_COLUMN_NAME)
			return 0
		end if 		
	//---------------------------- APPEON END ----------------------------

	CASE 'number'
		if not f_validstr(string(ADw.getitemnumber(al_row, as_column_name))) then 
			messagebox(ls_title, ls_statement1 +  ADW.INV_base.OF_GETcolumndisplayname(AS_COLUMN_NAME ) + ls_statement2)
			ADW.setcolumn( AS_COLUMN_NAME)
			return 0
		end if
		
end choose
	

RETURN 1
		
end function

public function integer of_adjust_menu (u_tabpg adw_tabpage, string as_other, boolean ab_auto_setredraw2false);//====================================================================
//$<Function>: of_adjust_menu
//$<Arguments>:
// 	value    u_tabpg    adw_tabpage	The tab page being passed
// 	value    string     as_other	 Used to send helpfull info to the function
// 	value    Boolean    ab_auto_setredraw2false	Whether to set w_mdi redraw to false during adjusting menu.
//$<Return>:  integer
//$<Description>:  Function will modify the menu items as directed
//$<Author>: (Appeon) long.zhang 03.09.2017 (Contracts Module Slowness)
//--------------------------------------------------------------------
//$<Modify History>: Copied from of_adjust_menu(adw_tabpage,as_other)
//====================================================================

boolean lb_boolean
long ll_index

//if upperbound(is_class_name) < 1 then
//	is_class_name[upperbound(is_class_name)+ 1] = adw_tabpage.classname()
//	of_create_sys_fields(adw_tabpage)
//else
//	string ls_class_name
//	long ll_i
//	boolean ib_found
//	ls_class_name = adw_tabpage.classname()
//	
//	for ll_i = 1 to upperbound(is_class_name)
//       if is_class_name[ll_i] = ls_class_name then
//			ib_found = true
//		else 
//			is_class_name[upperbound(is_class_name)+ 1] = adw_tabpage.classname()
//		end if 
//		
//	next
//end if 
//
//if not ib_found  then 
//	messagebox('not found',ls_class_name)
//    of_create_sys_fields(adw_tabpage)
//end if 


///////////////////////////////////////////////////////////////////////////////////////////////
// set the menu
////////////////////////////////////////////////////////////////////////////////////////////////
//w_mdi.title = classname(adw_tabpage)

//w_mdi.SetRedraw(false) 
If ab_auto_setredraw2false Then w_mdi.SetRedraw(false) //Added by Appeon long.zhang 03.09.2017 (Contracts Module Slowness)

if w_mdi.menuname <> 'm_pfe_cst_mdi_menu_contract' then 
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 2006-11-14 By: Allen
		//$<reason> Fix APB Bug: the Toolbar Icon is invalid.
		/*
		w_mdi.ChangeMenu( m_pfe_cst_mdi_menu_contract )	
		*/
		If w_mdi.menuname <> 'm_pfe_cst_mdi_menu_contract' Then w_mdi.ChangeMenu( m_pfe_cst_mdi_menu_contract )
		//---------------------------- APPEON END ----------------------------

		//------------------- APPEON BEGIN -------------------
		//<$>added:long.zhang 03.09.2017
		//<$>reason:don't need to modify in w_mdi setredraw, Contracts Module Slowness
		
//		//--------------------------- APPEON BEGIN ---------------------------
//		//$<add> 01.12.2007 By: Jack (Document Manager)
//		//$<reason> Fix a defect.				
		w_mdi.of_menu_security("m_pfe_cst_mdi_menu_contract")
		If ab_auto_setredraw2false Then w_mdi.SetRedraw(false)
//		//---------------------------- APPEON END ----------------------------
		
		//------------------- APPEON END -------------------
		
		////////////////////////////////////////////////////////////////////////////////////////////////
		// toolbar position
		////////////////////////////////////////////////////////////////////////////////////////////////
		
		//---------Begin Modified by (Appeon)Harry 03.10.2014 for V142 ISG-CLX--------
		/*
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 08.16.2006 By: Liang QingShi
		//$<reason> Contract module modification
		/*
		ll_index = 10
		*/
		ll_index = 11
		
		//---------------------------- APPEON END ----------------------------
		*/
		ll_index = 100 //11	->100  (Appeon)Alfee 07.30.2013 - V141 ISG-CLX
		//---------End Modfiied ------------------------------------------------------
		
		//---------Begin Commented by (Appeon)Harry  03.10.2014 for V142 ISG-CLX--------
		//gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_file.m_save,'toolbaritemorder', ll_index)
		//ll_index ++
		//---------End Commented ------------------------------------------------------
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_insert,'toolbaritemorder', ll_index)
		ll_index ++
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_delete1,'toolbaritemorder', ll_index)
		ll_index ++
		//---------Begin Added by (Appeon)Harry 03.10.2014 for V142 ISG-CLX--------
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_file.m_save,'toolbaritemorder', ll_index)
		ll_index ++
		//---------End Added ------------------------------------------------------
		m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan.toolbaritemorder	 = ll_index
		ll_index ++
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_previous,'toolbaritemorder', ll_index)
		ll_index ++
		m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_next.toolbaritemorder 	  = ll_index
		ll_index ++
		m_pfe_cst_mdi_menu_contract.m_imagingtools.m_editimage.toolbaritemorder 						= ll_index
		ll_index ++
		m_pfe_cst_mdi_menu_contract.m_imagingtools.m_editimage.m_delete.toolbaritemorder 			= ll_index
		ll_index ++
		m_pfe_cst_mdi_menu_contract.m_imagingtools.m_editimage.m_maximize.toolbaritemorder 			= ll_index
		ll_index ++
		m_pfe_cst_mdi_menu_contract.m_imagingtools.m_editimage.m_objectcopy.toolbaritemorder 		= ll_index
		ll_index ++
		m_pfe_cst_mdi_menu_contract.m_imagingtools.m_editimage.m_objectcut.toolbaritemorder 		= ll_index
		ll_index ++
		m_pfe_cst_mdi_menu_contract.m_imagingtools.m_editimage.m_objectpaste.toolbaritemorder 		= ll_index
		ll_index ++
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_annotations.m_selectannotations,'toolbaritemorder', ll_index)
		
	
end if 

////////////////////////////////////////////////////////////////////////////////////////////////
// enable/disable Imaging tool menu item
////////////////////////////////////////////////////////////////////////////////////////////////
//m_pfe_cst_mdi_menu_contract.m_edit.m_delete1.toolbaritemvisible = false

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.08.2006 By: LeiWei
m_pfe_cst_mdi_menu_contract.m_imagingtools.m_image_view.visible	= false
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_image_view,'toolbaritemvisible', false)
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_image_view,'enabled', false) 
//---------------------------- APPEON END ----------------------------

choose case classname(adw_tabpage)
	case 'tabpage_view'//,'tabpage_image'
		  m_pfe_cst_mdi_menu_contract.m_imagingtools.visible = true
		  m_pfe_cst_mdi_menu_contract.m_imagingtools.m_ocr.visible = FALSE
		   if as_other = STRING(historical_version) then 
					//m_pfe_cst_mdi_menu_contract.m_imagingtools.ENABLED = FALSE
					m_pfe_cst_mdi_menu_contract.m_imagingtools.visible = true
					m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_next.visible 		            = true
					m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_previous.visible             = true
					m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_next.toolbaritemvisible 		= true
					gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_previous,'toolbaritemvisible', true)
					//
					m_pfe_cst_mdi_menu_contract.m_imagingtools.m_annotations.visible = FALSE
					//
					m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_appendblankpage.visible = FALSE
					m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_right1.visible = FALSE
					m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_rotateallpages.visible = FALSE
					m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_straightenpage.visible = FALSE
					
             
			ELSE
					//m_pfe_cst_mdi_menu_contract.m_imagingtools.ENABLED = TRUE
						m_pfe_cst_mdi_menu_contract.m_imagingtools.m_annotations.visible = TRUE
					//
					m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_appendblankpage.visible = TRUE
					m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_right1.visible = TRUE
					m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_rotateallpages.visible = TRUE
					m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_straightenpage.visible = TRUE
					
					m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_next.visible 		            = true
					m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_previous.visible             = true
					m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_next.toolbaritemvisible 		= true
					gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_previous,'toolbaritemvisible', true)
					m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan.visible	= true
					gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan,'enabled', true)
					gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_annotations.m_selectannotations,'toolbaritemvisible', true)
					//m_pfe_cst_mdi_menu_contract.m_edit.visible = false
					//m_pfe_cst_mdi_menu_contract.m_view.visible = false
					//m_pfe_cst_mdi_menu_contract.m_edit.m_insert.toolbaritemvisible = false
					//m_pfe_cst_mdi_menu_contract.m_file.m_save.toolbaritemvisible  = false
					//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan.visible =  true
					gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan,'toolbaritemvisible', true)
					gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_delete1,'toolbaritemvisible', false)
					
			end if
			
			lb_boolean = false
	case 'tabpage_browse'
         u_tabpage_supporting_images_det_browse	   ladw_tabpage  
			ladw_tabpage = adw_tabpage
		   		
		   m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_next.visible 		            = false
         m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_previous.visible             = false
			m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_next.toolbaritemvisible 		= false
         gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_previous,'toolbaritemvisible', false)
			m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan.visible	= true
			
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan,'toolbaritemvisible', true)
         //m_pfe_cst_mdi_menu_contract.m_edit.visible = false
         //m_pfe_cst_mdi_menu_contract.m_view.visible = false
			//m_pfe_cst_mdi_menu_contract.m_edit.m_insert.toolbaritemvisible = false
			//m_pfe_cst_mdi_menu_contract.m_file.m_save.toolbaritemvisible  = false
			m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan.visible =  true
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_delete1,'toolbaritemvisible', true)
			if ladw_tabpage.dw_1.rowcount( ) > 0 then 
				ladw_tabpage.dw_1.accepttext( )
				
				if ladw_tabpage.dw_1.object.media_type[ladw_tabpage.dw_1.getrow()] <> 1 then
					
				   m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan.text = 'Browse'
					gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan,'ToolbarItemText', 'Browse')
				else 
					m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan.text = 'Scan'
					gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan,'ToolbarItemText', 'Scan')
				end if
						
				
			end if 

			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 10.08.2006 By: LeiWei
			m_pfe_cst_mdi_menu_contract.m_imagingtools.m_image_view.visible	= true
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_image_view,'toolbaritemvisible', true)
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_image_view,'enabled', true) 
			//---------------------------- APPEON END ----------------------------

  case 'tabpage_search'
			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 03.20.2006 By: LeiWei
			//$<reason> Fix a defect.
		   m_pfe_cst_mdi_menu_contract.m_imagingtools.visible = false
		   m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_next.toolbaritemvisible 		= false
         gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_previous,'toolbaritemvisible', false)
			lb_boolean = false
		   m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan.visible	= false
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan,'toolbaritemvisible', false)
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_annotations.m_selectannotations,'toolbaritemvisible', false)
			//m_pfe_cst_mdi_menu_contract.m_edit.visible = true
         //m_pfe_cst_mdi_menu_contract.m_view.visible = true
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_insert,'toolbaritemvisible', true)
	      gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_file.m_save,'toolbaritemvisible', true)
			m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan.visible =  false
         gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_insert,'toolbaritemvisible', true)
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_delete1,'toolbaritemvisible', true)
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_delete1,'enabled', true) //jervis-12.7.2009
			//---------------------------- APPEON END ----------------------------
			
			//m_pfe_cst_mdi_menu_contract.m_edit.m_delete1.toolbaritemvisible = false
   case else
		   m_pfe_cst_mdi_menu_contract.m_imagingtools.visible = false
		   m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_next.toolbaritemvisible 		= false
         gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_previous,'toolbaritemvisible', false)
			lb_boolean = false
		   m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan.visible	= false
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan,'toolbaritemvisible', false)
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_annotations.m_selectannotations,'toolbaritemvisible', false)
			//m_pfe_cst_mdi_menu_contract.m_edit.visible = true
         //m_pfe_cst_mdi_menu_contract.m_view.visible = true
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_insert,'toolbaritemvisible', true)
	      gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_file.m_save,'toolbaritemvisible', true)
			m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan.visible =  false
         gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_insert,'toolbaritemvisible', true)
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_delete1,'toolbaritemvisible', true)
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_file.m_print,'toolbaritemvisible', false)

			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 2007-01-08 By: Rodger Wu
			//$<reason> Fix a APB defect.
			if classname(adw_tabpage) = "tabpage_images" then
				m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan.visible	= true
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan,'toolbaritemvisible', true)
				m_pfe_cst_mdi_menu_contract.m_imagingtools.m_image_view.visible	= true
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_image_view,'toolbaritemvisible', true)
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_imagingtools.m_image_view,'enabled', true) 
			end if
			//---------------------------- APPEON END ----------------------------

end choose

////////////////////////////////////////////////////////////////////////////////////////////////
// WholeSale  menu changes
////////////////////////////////////////////////////////////////////////////////////////////////

m_pfe_cst_mdi_menu_contract.m_imagingtools.m_editimage.visible 						= lb_boolean
m_pfe_cst_mdi_menu_contract.m_imagingtools.m_editimage.m_delete.visible 			= lb_boolean
m_pfe_cst_mdi_menu_contract.m_imagingtools.m_editimage.m_maximize.visible 			= lb_boolean
m_pfe_cst_mdi_menu_contract.m_imagingtools.m_editimage.m_objectcopy.visible 		= lb_boolean
m_pfe_cst_mdi_menu_contract.m_imagingtools.m_editimage.m_objectcut.visible 		= lb_boolean
m_pfe_cst_mdi_menu_contract.m_imagingtools.m_editimage.m_objectpaste.visible 		= lb_boolean
m_pfe_cst_mdi_menu_contract.m_imagingtools.m_editimage.toolbaritemvisible 						= lb_boolean
m_pfe_cst_mdi_menu_contract.m_imagingtools.m_editimage.m_delete.toolbaritemvisible 			= lb_boolean
m_pfe_cst_mdi_menu_contract.m_imagingtools.m_editimage.m_maximize.toolbaritemvisible 			= lb_boolean
m_pfe_cst_mdi_menu_contract.m_imagingtools.m_editimage.m_objectcopy.toolbaritemvisible 		= lb_boolean
m_pfe_cst_mdi_menu_contract.m_imagingtools.m_editimage.m_objectcut.toolbaritemvisible 		= lb_boolean
m_pfe_cst_mdi_menu_contract.m_imagingtools.m_editimage.m_objectpaste.toolbaritemvisible 		= lb_boolean
//m_pfe_cst_mdi_menu_contract.m_file.m_print.toolbaritemvisible = lb_boolean


////////////////////////////////////////////////////////////////////////////////////////////////
// show/hide view/edit menu
////////////////////////////////////////////////////////////////////////////////////////////////


if classname(adw_tabpage) = 'tabpage_search' then 
	//m_pfe_cst_mdi_menu_contract.m_edit.visible = false
   //m_pfe_cst_mdi_menu_contract.m_view.visible = false
	m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan.visible	= false
	//w_mdi.setredraw(false) //(Appeon)Harry 03.10.2014 - V142 ISG-CLX //Comment by Appeon long.zhang 03.09.2017 (Contracts Module Slowness)
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_insert,'toolbaritemvisible', false)
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_file.m_save,'toolbaritemvisible', false)
	//w_mdi.setredraw(true) //(Appeon)Harry 03.10.2014 - V142 ISG-CLX //Comment by Appeon long.zhang 03.09.2017 (Contracts Module Slowness)
else 
	
end if 

if classname(adw_tabpage) = 'tabpage_view' then 
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_file.m_print,'toolbaritemvisible', true)
			m_pfe_cst_mdi_menu_contract.m_file.m_print.text= 'Print Image'  
		else
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_file.m_print,'toolbaritemvisible', false)
	
end if 

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.22.2006 By: Lei Wei
//$<reason> Contract module modification

if classname(adw_tabpage) = 'tabpage_action_items' then 
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_view.m_filter,'toolbaritemvisible', true)
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 11.17.2006 By: Jervis
	//$<reason> 
	if gb_workflow then
		m_pfe_cst_mdi_menu_contract.m_edit.m_workflow.visible = true
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_workflow,'toolbaritemvisible', true)
	end if
	
	//<add> 06.12.2007 by: andy
	m_pfe_cst_mdi_menu_contract.m_edit.m_letter.visible = true
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_letter,'toolbaritemvisible', true)	
	//end of add
	
	//---------------------------- APPEON END ----------------------------

else
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_view.m_filter,'toolbaritemvisible', false)
	//--------------------------- APPEON BEGIN ---------------------------
	//Add By Jervis 01.08.2009
	if classname(adw_tabpage) = 'tabpage_details' and gb_workflow then
		m_pfe_cst_mdi_menu_contract.m_edit.m_workflow.visible = true
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_workflow,'toolbaritemvisible', true)
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_delete1,'enabled', true) //jervis-12.7.2009
	else
	//End by Jervis 01.08.2009
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 11.17.2006 By: Jervis
		//$<reason> 
		m_pfe_cst_mdi_menu_contract.m_edit.m_workflow.visible = false
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_workflow,'toolbaritemvisible', false)
	end if

	//<add> 06.12.2007 by: andy
	m_pfe_cst_mdi_menu_contract.m_edit.m_letter.visible = false
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_letter,'toolbaritemvisible', false)	
	//end of add
	
	//---------------------------- APPEON END ----------------------------
end if

//---------------------------- APPEON END ----------------------------

//w_mdi.SetRedraw(true)
If ab_auto_setredraw2false Then w_mdi.SetRedraw(true) //Added by Appeon long.zhang 03.09.2017 (Contracts Module Slowness)

return 0



//
//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_annotations.m_filledrectandle.visible
//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_annotations.m_freehandline.visible
//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_annotations.m_hideallannotations.visible
//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_annotations.m_hidenon-ocrzones.visible
//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_annotations.m_hideocrtextzonehighlights.visible
//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_annotations.m_highlighter.visible
//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_annotations.m_hollowrectangle.visible
//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_annotations.m_hyperlink.visible
//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_annotations.m_makeannotationspermanent.visible
//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_annotations.m_rubberstamp.visible
//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_annotations.m_selectannotations.visible
//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_annotations.m_straightline.visible
//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_annotations.m_textfromfile.visible
//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_annotations.m_typedtext.visible
//
//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_editimage.visible
//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_editimage.m_delete.visible
//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_editimage.m_maximize.visible
//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_editimage.m_objectcopy.visible
//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_editimage.m_objectcut.visible
//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_editimage.m_objectpaste.visible
//
//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_ocr.visible
//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_ocr.m_drawtextzone.visible
//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_ocr.m_ocr0.visible
//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_ocr.m_ocrwholeimage.visible
//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_ocr.m_removeallocrzones.visible
//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_ocr.m_showocrzones.visible
//
//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.visible
//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_appendblankpage.visible
//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.visible
//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_firstpage.visible
//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_last.visible
//
//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_appendblankpage.visible
//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_right1.visible
//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_rotateallpages.visible
//m_pfe_cst_mdi_menu_contract.m_imagingtools.m_page.m_straightenpage.visible



end function

on n_cst_contract.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_contract.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;

setnull(il_null)
setnull(is_null)
setnull(il_ctx_id )
//Modified By Mark Lee 04/18/12
is_RegKey	= "HKEY_LOCAL_MACHINE\SOFTWARE\"+gs_DefDirName+"\Requirement"	

ids_data = create datastore 
ids_data.dataobject = 'd_cntx_image'
ids_data.settransobject(sqlca)

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// check to see the directory exists if it does not then create it
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

inv_filesrv = create n_cst_filesrvwin32


is_contrtact_dir_path = gnv_app.is_application_path + '\' + 'contract\' + gs_user_id 

IF NOT inv_filesrv.of_DirectoryExists (is_contrtact_dir_path) THEN
	    inv_filesrv.of_CreateDirectory (gnv_app.is_application_path + '\' + 'contract')
	    inv_filesrv.of_CreateDirectory (gnv_app.is_application_path + '\' + 'contract\' + gs_user_id)
END IF


is_mode = EDIT//added by gavins 20121011


end event

