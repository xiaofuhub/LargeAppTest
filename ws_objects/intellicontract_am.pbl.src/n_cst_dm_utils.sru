$PBExportHeader$n_cst_dm_utils.sru
$PBExportComments$Global util functions for Document Manager
forward
global type n_cst_dm_utils from nonvisualobject
end type
end forward

global type n_cst_dm_utils from nonvisualobject autoinstantiate
end type

type variables
string CS_SUPPORT_DOCTYPES[]={'doc','tif'}
n_cst_pdf2text inv_cst_pdf2text

datastore ids_doc_image //by alfee at 03.19.2007
n_cst_ocr inv_cst_tif2text //by alfee at 08.19.2008
end variables

forward prototypes
public function integer of_readblob (string as_filename, ref blob ab_value)
public function integer of_saveblob (string as_filename, blob ab_value)
public function decimal of_newversion (decimal adc_initial_version)
public function string of_generate_tempname (long al_doc_id, decimal adc_revision, string as_doc_ext)
public function integer of_add_audit_trail (str_add_audit astr_add_audit)
public function integer of_upload_file (long al_doc_id, decimal adc_revision, string as_filename)
public function string of_get_fileext (string as_filename)
public function string of_download_file (long al_doc_id, decimal adc_revision)
public function integer of_updateregistry (long al_doc_id, decimal adc_revision, string as_doc_ext, datetime adt_modify_date)
public function boolean of_comparefile (long al_doc_id, decimal adc_revision, string as_doc_ext, datetime adt_modify_date)
public subroutine of_menu_security ()
public function integer of_download_file (long al_doc_id, decimal adc_revision, string as_filename)
public function integer of_getblob_fromdb (long al_doc_id, decimal adc_revision, ref blob lb_image_data)
public function string of_generate_tempname_writable (long al_doc_id, decimal adc_revision, string as_doc_ext)
public function integer of_download_multi_files (long al_doc_id[], decimal adc_revision[], ref string as_filename[])
public function boolean of_verify_filename (string as_filename)
public function string of_get_filename (string as_filename)
public function string of_generate_tempname_random (long al_doc_id, decimal adc_revision, string as_doc_ext)
public function string of_convert_word_file_ext (string as_input_file)
public function integer of_gen_document_on_rules (string as_source_file, string as_target_file, datastore ads_clause_rule_results)
public function integer of_update_document (long al_doc_id, decimal adc_revision, string as_filename, datetime adt_modify)
public function integer of_add_audit_trail (long al_doc_id[])
public function integer of_get_clause_rule_reuslts (long al_ctx_id, long al_template_id, datastore ads_results)
public function integer of_updateregistry (string as_module, long al_doc_id, decimal adc_revision, string as_doc_ext, datetime adt_modify_date)
public function integer of_readblob_bk (string as_filename, ref blob ab_value)
public function integer of_saveblob_bk (string as_filename, blob ab_value)
public function integer of_update_tif_ocr (long al_doc_id, decimal adec_revision, string as_filename)
public function string of_get_fileext (string as_filename, boolean ab_original)
public function integer of_convert2pdf (long al_doc_id, ref decimal adec_revision, string as_filename, string as_old_ext)
public function integer of_update_clausemap (long al_doc_id, decimal adec_old_revision, decimal adec_new_revision, datawindow adw_clause, string as_filename)
public function string of_generate_tempname (long al_doc_id, decimal adc_revision, string as_doc_name, string as_doc_ext)
public function integer of_convert2pdf (string as_sourcefile, string as_targetfile)
public function integer of_create_clean_doc (string as_sourcefile, ref string as_targetfile, string as_from)
public function string of_get_ocr_result (string as_filename)
public function integer of_upload_file (long al_doc_id, decimal adc_revision, string as_filename, string as_ocr_result)
public function long of_get_sharps_revision_count (oleobject aole_document)
public function integer of_accept_or_reject_sharp_revisions (oleobject aole_document, integer ai_type)
public function String of_gettempfilename (string as_keyname)
public function integer of_add_audit_trail (long al_doc_id[], string as_action)
public function integer of_add_audit_trail (long al_doc_id[], str_ctx_email astr_sertifi, string as_action)
public function integer of_add_audit_trail (str_add_audit astr_add_audit[])
public function string of_merge_file_name (long al_doc_id, decimal adec_revision, string as_doc_name, string as_doc_ext, integer ai_type)
public function integer of_get_clause_rule_reuslts (long al_ctx_id, long al_template_id, datastore ads_results, boolean ab_ctx_find)
public function integer of_download_picture (long al_pic_id, ref string as_file)
end prototypes

public function integer of_readblob (string as_filename, ref blob ab_value);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_dm_utils.of_readblob()
// $<arguments>
//		value    	string	as_filename		:The specified file name.
//		reference	blob  	ab_value   		:The content of the specified file.
// $<returns> integer: 1 - Success;  -1 - Failure
// $<description>Read blob value of a specified file.
//////////////////////////////////////////////////////////////////////
// $<add> Alfee 09.28.2008
//////////////////////////////////////////////////////////////////////
Long ll_FileLength, ll_readlength

if not fileexists(as_filename) then return -1

SetPointer(HourGlass!) 

//initilize variables
ll_FileLength = filelength(as_filename)
ab_value = Blob(Space(ll_FileLength),EncodingANSI!) //Modified By Ken.Guo 03/28/2012. EncodingANSI

//Read file to blob
ll_readlength = AppeonReadFile(as_filename, ab_value, ll_FileLength)
//---------Begin Modified by (Appeon)Harry 01.27.2014 for V142 ISG-CLX--------
//if ll_readlength < 0 then return -1
if ll_readlength < 0 then 
	ab_value = Blob("",EncodingAnsi!) //BugA090403  - Alfee 09.24.2013
	return -1
end if
//---------End Modfiied ------------------------------------------------------

return 1

end function

public function integer of_saveblob (string as_filename, blob ab_value);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_dm_utils.of_saveblob()
// $<arguments>
//		value    	string	as_filename		: The specified file name.
//		value		   blob  	ab_value   		: The content of the specified file.
// $<returns> integer: 1 - Success; -1 - Failure
// $<description>Save blob value to a specified file.
//////////////////////////////////////////////////////////////////////
// $<add> Alfee 09.28.2008
//////////////////////////////////////////////////////////////////////
Long ll_writelength, ll_readlength
string ls_save_path

if fileexists(as_filename) then 
	if not filedelete(as_FileName) then
		return -1
	end if
end if

SetPointer(HourGlass!) 

//Start Change Code By Jervis 01.08.2009
//Create path if not exists
ls_save_path = mid(as_FileName,1,lastpos(as_FileName,'\'))
gnv_appeondll.of_parsepath(ls_save_path)
//End Change Code By Jervis


//initilize variables
ll_readlength = Len(ab_value)

//Write blob into file
ll_writelength = AppeonWriteFile(as_FileName, ab_value, ll_readlength)
if ll_writelength < 0 then return -1

SetPointer(Arrow!)
return 1

end function

public function decimal of_newversion (decimal adc_initial_version);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_dm_utilsof_newrevision()
// $<arguments>
//		value	decimal	adc_initial_version		
// $<returns> decimal
// $<description>Return the new increased revision
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2006-12-04 by Frank.Gui
//////////////////////////////////////////////////////////////////////
decimal{1} ldc_new
long li_version_type

If Isnull(adc_initial_version) Then adc_initial_version = 0 //Added By Ken.Guo 2010-01-11.

if adc_initial_version=0 then
	ldc_new = 1.0
else
	//Version number increment type-jervis 03.19.2009
	//0-Major version number increment
	//1-Minor version number increment
	li_version_type = of_get_app_setting("set_58",'I')
	
	if li_version_type = 0 then	//Major increment -03.19.2009
		ldc_new = Truncate(adc_initial_version + 1,0)
	else	//Minor increment
		ldc_new = adc_initial_version+0.1
	end if
end if


return ldc_new
end function

public function string of_generate_tempname (long al_doc_id, decimal adc_revision, string as_doc_ext);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_dm_utils.of_generate_tempname()
// $<arguments>
// $<returns> string: Generated temporary file name
// $<description>Generate a temporary file name to store OLE content
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2006-12-04 by Frank.Gui
//////////////////////////////////////////////////////////////////////

String ls_file_name
int  i
boolean   ab_support=false
string ls_name

gnv_appeondll.of_parsepath(gs_dir_path + gs_DefDirName + "\Agreement\Manager\")

as_doc_ext = lower(as_doc_ext)

//Use actual doc name - jervis 10.14.2009
//ls_file_name = gs_dir_path + gs_DefDirName + "\Agreement\Manager\doc_" + string(al_doc_id) + "_"+String(adc_revision)+"."+as_doc_ext
if al_doc_id > 0 then
	select doc_name into :ls_name from ctx_am_document where doc_id = :al_doc_id;
end if
if isnull(ls_name) then ls_name = ''

//Modified By Ken.Guo 2010-06-30
//ls_file_name = gs_dir_path + gs_DefDirName + "\Agreement\Manager\" + ls_name +  string(al_doc_id) + "."+String(adc_revision)+"."+as_doc_ext
ls_file_name = of_generate_tempname(al_doc_id,adc_revision,ls_name,as_doc_ext)

return ls_file_name
end function

public function integer of_add_audit_trail (str_add_audit astr_add_audit);/******************************************************************************************************************
**  [PUBLIC]   : of_add_audit_trail
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: str_add_audit
**==================================================================================================================
**  Returns   	: integer
**==================================================================================================================
**  Notes     	: Create a aduit trail record.
**==================================================================================================================
**  Created By	: Davis 01.11.2007
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

str_add_audit lstr_add_audit[]

//Modified By Ken.Guo 2011-06-29
lstr_add_audit[1] = astr_add_audit 
Return of_add_audit_trail(lstr_add_audit[])

//Commented By Ken.Guo 2011-06-29
/* 
Long ll_max_audit_id

IF Isnull(astr_add_audit.doc_id) OR astr_add_audit.doc_id = 0 THEN RETURN -1

Select Max(audit_id)
Into :ll_max_audit_id
From Ctx_am_doc_audit
Where doc_id = :astr_add_audit.doc_id;

IF Isnull(ll_max_audit_id) OR ll_max_audit_id = 0 THEN
	ll_max_audit_id = 1
ELSE
	ll_max_audit_id ++
END IF

Insert Into Ctx_am_doc_audit (doc_id, audit_id, revision, action, 
action_by, action_date,	filename, doc_from_type, doc_from_name, notes, doc_ext,
es_apicode, es_fileid,es_docid,es_sender,es_sender_email)
Values (:astr_add_audit.doc_id, :ll_max_audit_id, :astr_add_audit.revision, :astr_add_audit.action, 
:gs_user_id, getdate(), :astr_add_audit.filename, :astr_add_audit.doc_from_type, 
:astr_add_audit.doc_from_name, :astr_add_audit.notes, :astr_add_audit.doc_ext,
:astr_add_audit.astr_sertifi_doc.as_es_apicode,:astr_add_audit.astr_sertifi_doc.as_es_fileid,:astr_add_audit.astr_sertifi_doc.as_es_docid,
:astr_add_audit.astr_sertifi_doc.as_es_sender,:astr_add_audit.astr_sertifi_doc.as_es_email );

IF SQLCA.SQLCODE = 0 THEN
	COMMIT;
ELSE
	MESSAGEBOX("Add document", sqlca.sqlerrtext)
	RETURN -1
END IF

IF Isvalid(gw_contract) THEN
	gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.dynamic event ue_refresh_audit(astr_add_audit.doc_id)
END IF

RETURN 1
*/
end function

public function integer of_upload_file (long al_doc_id, decimal adc_revision, string as_filename);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utilsof_savetodb()
// $<arguments>
//		value	long   	al_doc_id      :	Corresponding Document ID
//		value	decimal	adc_revision	:	Corresponding Document revision
//    value string   as_doc_ext     :  Document Extended Name
// $<returns> integer: 1 - Success
// 		             -1: Cannot generate temporary file.
//       		       -2: Failed to save data to the temporary file.
//            		    -3: Failed to read content from the temporary file.
//                    -4: Failed to insert base data to ctx_am_doc_image.
//                    -5: Failed to update blob value to ctx_am_doc_image.
// $<description>Save the content of current OCX to the corresponding record in the DB.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2006-12-04 by Frank.Gui
//////////////////////////////////////////////////////////////////////

Return This.of_upload_file(al_doc_id,adc_revision,as_filename,'')
/*
String ls_doc_ext
string ls_doc_ext_full	//jervis 10.21.2009
Blob   lb_value
Int   li_count
Int	li_count_all //Added By Ken.Guo 2009-12-22.
String ls_pdftext
n_cst_image_cp_ocr lnv_ocr

// Get blob from file
if of_readblob( as_filename, ref lb_value ) < 0 then
	messagebox('Error1','Failed to get document data')
	return -1
end if

// Get File extend name
ls_doc_ext = Lower(of_get_fileext( as_filename ))
ls_doc_ext_full = Lower(of_get_fileext( as_filename ,true))	//jervis 10.21.2009
// Check doc exists in DB
SELECT count(*) into :li_count FROM ctx_am_doc_image 
WHERE doc_id = :al_doc_id AND revision = :adc_revision;

//Check whether new document //Added By Ken.Guo 2009-12-22.
Select Count(1) Into :li_count_all From ctx_am_doc_image
Where doc_id = :al_doc_id;

//-------Appeon Begin ----modified by alfee at 03.14.2007 for performance tunning
//gnv_appeondb.of_commitqueue( ) //commented by alfee 09.14.2007
IF li_count < 1 THEN
	//Add doc_ext_full Field - jervis10.21.2009
	INSERT INTO ctx_am_doc_image (doc_id, revision, doc_ext, modify_date,doc_ext_full)
	VALUES(:al_doc_id, :adc_revision, :ls_doc_ext, getdate(),:ls_doc_ext_full);
//---------Begin Modified by Alfee 09.14.2007---------------
//<$Reason>for check in/out operation
ELSE 
	//Add doc_ext,doc_ext_full fileds - jervis 10.21.2009
	UPDATE ctx_am_doc_image SET modify_date = getdate(),doc_ext = :ls_doc_ext,doc_ext_full = :ls_doc_ext_full  
	 WHERE doc_id = :al_doc_id AND revision = :adc_revision;
//----------End Modified -----------------------------------
//	if sqlca.sqlcode =  0 then
//		COMMIT;
//	ELSE
//		messagebox('Error2','Failed to save document to DB due to '+sqlca.sqlerrtext)
//		return -2
//	end if
END IF
//---------Begin Modified by Alfee 09.14.2007---------------
IF SQLCA.SQLCODE <> 0 THEN 
	MessageBox('Error2','Failed to save document to DB due to '+sqlca.sqlerrtext)
	RETURN -2
END IF
//----------End Modified -----------------------------------

// Store blob value to DB. 
UPDATEBLOB ctx_am_doc_image
SET image_file=:lb_value 
WHERE doc_id=:al_doc_id AND revision=:adc_revision;

//Added By Ken.Guo 2009-12-22. Rollback main data if updateblob failed.
IF SQLCA.SQLCODE <> 0 THEN 
	MessageBox('Error3','Failed to upload document to DB due to '+sqlca.sqlerrtext)
	If li_count_all = 0 Then
		Delete from ctx_am_doc_image Where doc_id = :al_doc_id;
		Delete from ctx_am_document where doc_id = :al_doc_id;
	End If
	RETURN -3
END IF


//Added By Ken.Guo 2009-07-01. If it is new 
IF li_count < 1 THEN
	Update ctx_am_document Set Revision = :adc_revision Where doc_id = :al_doc_id;
End  If

IF SQLCA.SQLCODE <> 0 THEN 
	MessageBox('Error4','Failed to save document to DB due to '+sqlca.sqlerrtext)
	RETURN -4
END IF
//-------Appeon End ---------------------


If gnv_data.of_getitem('icred_settings' ,'set_48' , False ) = '1'  /*Global Search module is On*/ &
and gnv_data.of_getitem('icred_settings' ,'auto_ocr' , False ) = '1'  Then //Auto OCR is Yes
	lnv_ocr = Create n_cst_image_cp_ocr
	Choose Case Upper(ls_doc_ext) 
		Case 'PDF'
			inv_cst_pdf2text.of_pdf2text(as_FileName, ls_PdfText) //For searchable PDF.
			If ls_PdfText = '' Then
				ls_PdfText = lnv_ocr.of_ocr(as_FileName)
			End If
		Case 'BMP','TIF','TIFF','JPG','GIF'
				ls_PdfText = lnv_ocr.of_ocr(as_FileName)	
	End Choose
	
	if Len(ls_PdfText) > 0 then
		UPDATE ctx_am_doc_image
		SET pdftext = :ls_PdfText
		WHERE doc_id = :al_doc_id AND revision = :adc_Revision;
	end if
	//END---Modify by Evan 08/19/2008
End If

If isvalid(lnv_ocr) Then Destroy lnv_ocr

Return 1
*/
end function

public function string of_get_fileext (string as_filename);//////////////////////////////////////////////////////////////////////
// $<function>of_get_fileext()
// $<arguments>
//		value	string	as_filename		
// $<returns> string
// $<description>Get file extended name
//////////////////////////////////////////////////////////////////////
// $<add> 01.13.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////

//Modified by jervis 10.21.2009
/*
string  ls_temp
int  pos

ls_temp = reverse(as_filename)
pos = pos(ls_temp,'.')
IF pos > 0 THEN
	//--------Begin Modfied by Alfee 10.31.2007-------
	//<$Reason>To support Word 2007
	String ls_fileext
	ls_fileext = reverse(left(ls_temp,pos - 1))
	IF Left(Upper(ls_fileext), 3) = "DOC" THEN ls_fileext = Left(ls_fileext, 3)	
	RETURN ls_fileext
	//return reverse(left(ls_temp,pos - 1))	
	//--------End Modified ----------------------------
ELSE
	return ''
END IF
*/
return of_get_fileext(as_filename,false)
end function

public function string of_download_file (long al_doc_id, decimal adc_revision);//////////////////////////////////////////////////////////////////// //
// $<function>of_download_file()
// $<arguments>
//		value	long   	al_doc_id      :	Corresponding Document ID
//		value	decimal	adc_revision	:	Corresponding Document revision
// $<returns> String fullpath filename
// $<description> Save the content of current OCX to the corresponding record in the DB.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.22.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////

String ls_FileName
String ls_doc_ext
DateTime ldt_modify_date
Blob  lb_image_data

// Get last modify date
SELECT modify_date, doc_ext
INTO :ldt_modify_date, :ls_doc_ext
FROM ctx_am_doc_image
WHERE doc_id = :al_doc_id AND Revision = :adc_revision;

//Begin - Added By Mark Lee 08/04/12
//IF SQLCA.SQLCODE <> 0 THEN
//	//MessageBox( "DownLoad File", SQLCA.SQLERRTEXT )// by alfee 04.11.2007
//	MessageBox( "DownLoad File", "Download file failed! ~r~n" + SQLCA.SQLERRTEXT )
//	Return ""
//END IF
IF SQLCA.SQLCODE < 0 THEN
	MessageBox( "DownLoad File", "Download file failed! ~r~n" + SQLCA.SQLERRTEXT )
	Return ""
ElseIf  SQLCA.SQLCODE = 100 Then
	Messagebox('Download File','Failed to download the document. ~r~n~r~nBecause the file content does not exist in database, please delete the document (ID = '+String(al_doc_id)+') in the Document Manager and reupload the original file to database.',Exclamation!)
	Return ""
END IF
//End - Added By Mark Lee 08/04/12


// Generate file name
ls_filename = Of_generate_tempname(al_doc_id, adc_revision, ls_doc_ext)

// Compare modify date between local files and from db, if same then return 
IF of_comparefile(al_doc_id, adc_revision, ls_doc_ext, ldt_modify_date) THEN
	RETURN ls_filename
END IF

// Download file from DB
IF of_download_file( al_doc_id, adc_revision, ls_filename ) > 0 THEN
	//Save the latest update date of the current file in Registry
	of_updateregistry(al_doc_id, adc_revision, ls_doc_ext, ldt_modify_date)

	IF FileExists(ls_filename) THEN
		RETURN ls_FileName
	END IF
END IF

RETURN ""
end function

public function integer of_updateregistry (long al_doc_id, decimal adc_revision, string as_doc_ext, datetime adt_modify_date);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_updateregistry()
// $<arguments>
//		value	integer 	ai_doc_id      		
//		value	decimal 	adc_revision   		
//		value	string  	as_doc_ext     		
//		value	datetime	adt_modify_date		
// $<returns> integer
// $<description>Register new key value of the document
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.11.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////

String ls_regstr, ls_regupdate
Integer li_rtn

//ls_regstr = "doc_" + String(al_doc_id) + "_"+ String(adc_revision)+"."+ as_doc_ext
ls_regstr = "doc_" + String(al_doc_id) + "_"+ String(adc_revision)+"_"+ as_doc_ext
ls_regupdate = String(adt_modify_date, "mm/dd/yyyy hh:mm:ss")
//Modified By Mark Lee 04/18/12
li_rtn = gnv_appeondll.of_registryset("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Document",ls_regstr, regstring!, ls_regupdate) //(Appeon)Harry 06.25.2013 - V141 ISG-CLX
//li_rtn = gnv_appeondll.of_registryset("HKEY_LOCAL_MACHINE\SOFTWARE\"+gs_DefDirName+"\Document",ls_regstr, regstring!, ls_regupdate) //Commented by (Appeon)Harry 06.25.2013 - V141 ISG-CLX

RETURN li_rtn

	
		

end function

public function boolean of_comparefile (long al_doc_id, decimal adc_revision, string as_doc_ext, datetime adt_modify_date);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utilsof_comparefile()
// $<arguments>
//		value	integer 	ai_doc_id      		
//		value	decimal 	adc_revision   		
//		value	string  	as_doc_ext     		
//		value	datetime	adt_modify_date		
// $<returns> boolean
// $<description>Compare the updated date between local files and from db
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.11.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////

String ls_regstr, ls_regupdate, ls_lastupdate,ls_filename

ls_filename = of_generate_tempname(al_doc_id,adc_revision,as_doc_ext)
IF Not FileExists(ls_filename) THEN RETURN FALSE

//ls_regstr = "doc_" + String(al_doc_id) + "_"+ String(adc_revision)+"."+ as_doc_ext
ls_regstr = "doc_" + String(al_doc_id) + "_"+ String(adc_revision)+"_"+ as_doc_ext
ls_lastupdate = String(adt_modify_date, "mm/dd/yyyy hh:mm:ss")
//Modified By Mark Lee 04/18/12
//registryget("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Document", ls_regstr, regstring!, ls_regupdate)
gnv_appeondll.of_registryget("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Document", ls_regstr, regstring!, ls_regupdate)  //(Appeon)Harry 06.25.2013 - V141 ISG-CLX
//gnv_appeondll.of_registryget("HKEY_LOCAL_MACHINE\SOFTWARE\"+gs_DefDirName+"\Document", ls_regstr, regstring!, ls_regupdate)  //Commented by (Appeon)Harry 06.25.2013 - V141 ISG-CLX

IF ls_lastupdate = ls_regupdate AND Len(Trim(ls_lastupdate)) > 0  THEN
	RETURN TRUE
ELSE
	RETURN FALSE
END IF

end function

public subroutine of_menu_security ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_dm_utilsof_menu_security()
// $<arguments>
//		value	integer		
// $<returns> (none)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.22.2007 by Jack (Document Manager)
//////////////////////////////////////////////////////////////////////

If Not isvalid(m_pfe_cst_mdi_menu_contract_am) Then Return

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2007-02-25 By: Rodger Wu (add other)
/* 
If w_mdi.of_security_access( 6901 ) = 0 And w_mdi.of_security_access( 6902 ) = 0 Then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add,'toolbaritemvisible', False)			
End If
*/
integer li_addbuy, li_addsell, li_addother, li_temp

if w_mdi.of_security_access( 6901 ) > 0 then li_addbuy = 1
if w_mdi.of_security_access( 6902 ) > 0 then li_addsell = 1
if w_mdi.of_security_access( 6926 ) > 0 then li_addother = 1

li_temp = li_addbuy + li_addsell + li_addother
If li_temp = 0 Then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add,'toolbaritemvisible', False)
Elseif li_temp = 1 Then
	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.dropdown=FALSE
Else
	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.dropdown=TRUE
End If
//---------------------------- APPEON END ----------------------------

If w_mdi.of_security_access( 6901 ) = 0 Then
	//--------------------------- APPEON BEGIN ---------------------------
	//$<comment> 2007-02-25 By: Rodger Wu (add other)
	/*	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.dropdown=FALSE */
	//---------------------------- APPEON END ----------------------------
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addbuy,'toolbaritemvisible', False)			
End If
If w_mdi.of_security_access( 6902 ) = 0 Then
	//--------------------------- APPEON BEGIN ---------------------------
	//$<comment> 2007-02-25 By: Rodger Wu (add other)
	/* m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.dropdown=FALSE */
	//---------------------------- APPEON END ----------------------------
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addsell,'toolbaritemvisible', False)			
End If

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-02-25 By: Rodger Wu (add other)
If li_addother = 0 Then
	//m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addother.toolbaritemvisible = False
End If
//---------------------------- APPEON END ----------------------------

If w_mdi.of_security_access( 6903 ) = 0 Then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_properties0,'toolbaritemvisible', False)			
End If
If w_mdi.of_security_access( 6904 ) = 0 Then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_report,'toolbaritemvisible', False)			
End If
If w_mdi.of_security_access( 6905 ) = 0 Then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_email0,'toolbaritemvisible', False)			
End If

//If w_mdi.of_security_access( 6906 ) = 0 And w_mdi.of_security_access( 6907 ) = 0 And w_mdi.of_security_access( 6908 ) = 0 And w_mdi.of_security_access( 6909 ) = 0 Then  //(Appeon)Harry 10.15.2015 - for Bug_Id#4780
If w_mdi.of_security_access( 6906 ) = 0 And w_mdi.of_security_access( 6907 ) = 0 And w_mdi.of_security_access( 6909 ) = 0 Then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0,'toolbaritemvisible', False)			
End If

If w_mdi.of_security_access( 6906 ) = 0 Then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_print0,'enabled', False)			
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_print0,'toolbaritemvisible', False)			
End If
If w_mdi.of_security_access( 6907 ) = 0 Then
	//m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_email1.toolbaritemvisible = False			
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_email0,'toolbaritemvisible', False) //alfee 03.22.2007
End If
If w_mdi.of_security_access( 6909 ) = 0 Then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_saveas,'toolbaritemvisible', False)			
End If

If w_mdi.of_security_access( 6910 ) = 0 And w_mdi.of_security_access( 6911 ) = 0 Then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check,'toolbaritemvisible', False)			
End If

If w_mdi.of_security_access( 6910 ) = 0 Then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkin,'toolbaritemvisible', False)			
End If
If w_mdi.of_security_access( 6911 ) = 0 Then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkout,'toolbaritemvisible', False)			
End If
If w_mdi.of_security_access( 6912 ) = 0 Then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_save0,'toolbaritemvisible', False)			
End If
If w_mdi.of_security_access( 6913 ) = 0 Then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_addclause,'toolbaritemvisible', False)			
End If

If w_mdi.of_security_access( 6914 ) = 0 And w_mdi.of_security_access( 6915 ) = 0 And w_mdi.of_security_access( 6954 ) = 0  Then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge,'toolbaritemvisible', False)			
End If

If w_mdi.of_security_access( 6914 ) = 0 Then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergefield,'enabled', False)			
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergefield,'toolbaritemvisible', False)			
End If
If w_mdi.of_security_access( 6915 ) = 0 Then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergedata,'toolbaritemvisible', False)			
End If

//Added By Ken.Guo 2009-06-30.
If w_mdi.of_security_access( 6954 ) = 0 Then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_insertreqmnt,'toolbaritemvisible', False)			
End If

If w_mdi.of_security_access( 6916 ) = 0 Then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_workflow0,'toolbaritemvisible', False)			
End If
If w_mdi.of_security_access( 6917 ) = 0 Then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_clausemap,'toolbaritemvisible', False)			
End If
If w_mdi.of_security_access( 6918 ) = 0 Then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_addactioneitem,'toolbaritemvisible', False)			
End If
If w_mdi.of_security_access( 6919 ) = 0 Then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_deleteactioneitem,'toolbaritemvisible', False)			
End If
If w_mdi.of_security_access( 6920 ) = 0 Then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_letter,'toolbaritemvisible', False)			
End If
If w_mdi.of_security_access( 6921 ) = 0 Then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_revision0,'toolbaritemvisible', False)			
End If
If w_mdi.of_security_access( 6922 ) = 0 Then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_delete0,'toolbaritemvisible', False)			
End If

end subroutine

public function integer of_download_file (long al_doc_id, decimal adc_revision, string as_filename);//////////////////////////////////////////////////////////////////// //
// $<function>of_download_file()
// $<arguments>
//		value	long   	al_doc_id      :	Corresponding Document ID
//		value	decimal	adc_revision	:	Corresponding Document revision
//		value	string	as_filename		:	save to this path
// $<returns> String fullpath filename
// $<description> Save the content of current OCX to the corresponding record in the DB.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.22.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////

Blob  lb_image_data
Long ll_data_length,ll_ret

// Get file data from database
IF appeongetclienttype() = 'PB' AND gs_dbtype = 'SQL' THEN
	//--------------Begin Modified by Alfee 09.07.2007-------------
	//IF of_getblob_fromdb(al_doc_id, adc_revision, lb_image_data) <= 0 THEN		
	ll_ret = of_getblob_fromdb(al_doc_id, adc_revision, lb_image_data)
	IF ll_ret < 0 THEN				
		MessageBox( "DownLoad File", "Download file failed!" )		
		RETURN -1
	ElseIf ll_ret = 0 Then
		Messagebox('Download File','Failed to download the document. ~r~n~r~nBecause the file content does not exist in database, please delete the document (ID = '+String(al_doc_id)+') in the Document Manager and reupload the original file to database.',Exclamation!)
		Return -1		
	END IF
ELSE
	SELECT Datalength(image_file)
	INTO :ll_data_length
	FROM ctx_am_doc_image
	WHERE doc_id = :al_doc_id
	AND revision = :adc_revision;	
	
	SELECTBLOB image_file
	INTO :lb_image_data
	FROM ctx_am_doc_image
	WHERE doc_id = :al_doc_id AND Revision = :adc_revision;

	If Isnull(ll_data_length) or ll_data_length = 0 Then
		Messagebox('Download File','Failed to download the document. ~r~n~r~nBecause the file content does not exist in database, please delete the document (ID = '+String(al_doc_id)+') in the Document Manager and reupload the original file to database.',Exclamation!)
		Return -1
	End If		
	
	//-------------Begin Added by Alfee 09.07.2007-------------------
	IF SQLCA.SQLCODE = -1 THEN 
		MessageBox( "DownLoad File", "Download file failed! ~r~n" + SQLCA.SQLERRTEXT )
		Return -1
	END IF
	//-------------End Added ----------------------------------------
END IF

// Save blob value to a local file.
Return of_saveblob(as_filename, lb_image_data)

end function

public function integer of_getblob_fromdb (long al_doc_id, decimal adc_revision, ref blob lb_image_data);//Get blob data from DB, only for PB and SQL Server 
//Commented by Alfee 09.17.2007

Integer li_counter, li_loops, li_MaxPosition, li_Position
Integer li_SetStep, li_NewStep, li_loopsR, li_rtn
Long ll_start, ll_data_length
String ls_title
Boolean lb_needrestore = FALSE
Blob lb_data, lb_all_data

SetPointer(HourGlass!) 

// Get file data from database
SELECT Datalength(image_file)
INTO :ll_data_length
FROM ctx_am_doc_image
WHERE doc_id = :al_doc_id
AND revision = :adc_revision;

IF SQLCA.SQLCODE = -1 THEN RETURN -1 //Added by Alfee 09.07.2007

IF ll_data_length = 0 OR Isnull(ll_data_length) THEN
	RETURN 0
END IF

//Get length of the blob
IF ll_data_length > 8000 THEN 
  	 IF Mod(ll_data_length,8000) = 0 THEN 
        li_loops = ll_data_length/8000 
    ELSE 
  	     li_loops = (ll_data_length/8000) + 1 
    END IF 
ELSE 
  	 li_loops = 1 
END IF 

//--------Begin Modified by Alfee 09.17.2007--------------------------------
//<$Reason>Display progress bar for the large blob
li_NewStep = 20
IF li_loops > li_NewStep THEN
	IF IsValid(w_appeon_gifofwait) THEN 
		//Keep the original progress bar
		lb_needrestore = TRUE
		ls_title = w_appeon_gifofwait.st_1.Text
		li_MaxPosition = w_appeon_gifofwait.hpb_1.MaxPosition
		li_Position = w_appeon_gifofwait.hpb_1.Position
		li_SetStep = w_appeon_gifofwait.hpb_1.SetStep
	ELSE
		OpenwithParm(w_appeon_gifofwait,"Getting the data...")
	END IF
	//Set the new progress bar
	li_loopsR = li_loops / li_NewStep
	IF Mod(li_loops, li_NewStep) <> 0 THEN li_loopsR ++
	w_appeon_gifofwait.st_1.Text = "Getting the data..."
	w_appeon_gifofwait.hpb_1.MaxPosition = li_loopsR * li_NewStep
	w_appeon_gifofwait.hpb_1.Position = 0
	w_appeon_gifofwait.hpb_1.SetStep = li_loopsR		
END IF

//Get and store the blob
li_rtn = 1
FOR li_counter = 1 to li_loops
	yield() //Added By Ken.Guo 05/30/2013
	ll_start = (li_counter - 1) * 8000 + 1
	SELECTBLOB substring(image_file,:ll_start,8000)
			INTO :lb_data
			FROM ctx_am_doc_image
			WHERE doc_id = :al_doc_id
			AND revision = :adc_revision;
	IF SQLCA.SQLCODE = -1 THEN 
		li_rtn = -1
		EXIT
	END IF
	
	lb_all_data += lb_data
	
	//Change the progress bar
	IF IsValid(w_appeon_gifofwait) AND li_loops > li_NewStep THEN
		IF Mod(li_counter, li_loopsR) = 1 THEN w_appeon_gifofwait.hpb_1.StepIt() 
	ELSE
		IF IsValid(w_appeon_gifofwait) THEN w_appeon_gifofwait.hpb_1.StepIt()
	END IF
	
NEXT 

//Restore Progress Bar
IF IsValid(w_appeon_gifofwait) and li_loops > li_NewStep THEN 
	IF lb_needrestore THEN
		w_appeon_gifofwait.st_1.Text = ls_title
		w_appeon_gifofwait.hpb_1.MaxPosition = li_MaxPosition
		w_appeon_gifofwait.hpb_1.Position = li_Position
		w_appeon_gifofwait.hpb_1.SetStep = li_SetStep
	ELSE
		Close(w_appeon_gifofwait)
	END IF
END IF

//Store the blob
lb_image_data = lb_all_data

Return li_rtn
/*FOR li_counter = 1 to li_loops
	ll_start = (li_counter - 1) * 8000 + 1
	SELECTBLOB substring(image_file,:ll_start,8000)
		INTO :lb_data
		FROM ctx_am_doc_image
		WHERE doc_id = :al_doc_id
		AND revision = :adc_revision;

	IF SQLCA.SQLCODE = -1 THEN RETURN -1	//Added by Alfee 09.07.2007
	lb_all_data += lb_data
NEXT 

lb_image_data = lb_all_data

Return 1*/
//--------End Modified --------------------------------------------------



end function

public function string of_generate_tempname_writable (long al_doc_id, decimal adc_revision, string as_doc_ext);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_dm_utils.of_generate_tempname()
// $<arguments>
// $<returns> string: Generated temporary file name
// $<description>Generate a temporary file name to store OLE content
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2006-12-04 by Frank.Gui
//////////////////////////////////////////////////////////////////////

String ls_file_name
int  i
boolean   ab_support=false

gnv_appeondll.of_parsepath(gs_dir_path + gs_DefDirName + "\Agreement\Manager\")

as_doc_ext = lower(as_doc_ext)

ls_file_name = gs_dir_path + gs_DefDirName + "\Agreement\Manager\tmp_doc_" + string(al_doc_id) + "_"+String(adc_revision)+"."+as_doc_ext

return ls_file_name
end function

public function integer of_download_multi_files (long al_doc_id[], decimal adc_revision[], ref string as_filename[]);//////////////////////////////////////////////////////////////////// //
// $<function>of_download_multi_files()
// $<arguments>
//		value	long   	al_doc_id[]     :	Corresponding Document IDs
//		value	decimal	adc_revision[]	:	Corresponding Document revisions
//		Ref	string	as_filename[]	:	Corresponding Document full names
// $<returns> integer
// $<description> Get files according to specified doc ids and revisions.
//////////////////////////////////////////////////////////////////////
// $<add> 03.19.2007 by Alfee
//////////////////////////////////////////////////////////////////////
Long ll_cnt, ll_cnt_ds, ll_found, i
String ls_doc_ext[], ls_search
DateTime ldt_modify_date[]
Blob  lb_image_data[]

ll_cnt_ds = ids_doc_image.Retrieve(al_doc_id, adc_revision)
IF ll_cnt_ds < 1 THEN RETURN -1

ll_cnt = UpperBound(al_doc_id) 
FOR i = 1 TO ll_cnt 	
	ls_search = "doc_id = " + String(al_doc_id[i]) + " and revision = " + String(adc_revision[i])
	ll_found = ids_doc_image.Find(ls_search, 1, ll_cnt_ds)
	IF ll_found > 0  THEN
		// Get files' extension, modify date & file name
		ls_doc_ext[i] = ids_doc_image.GetItemString(ll_found,"doc_ext")
		ldt_modify_date[i] = ids_doc_image.GetItemDateTime(ll_found,"modify_date")
		as_filename[i] = Of_generate_tempname(al_doc_id[i], adc_revision[i], ls_doc_ext[i])
		
		// Compare modify date between local files and from db, if not same then download
		IF Not of_comparefile(al_doc_id[i], adc_revision[i], ls_doc_ext[i], ldt_modify_date[i]) THEN
			// Download file from DB
			IF of_download_file(al_doc_id[i], adc_revision[i], as_filename[i]) > 0 THEN
				//Save the latest update date of the current file in Registry
				of_updateregistry(al_doc_id[i], adc_revision[i], ls_doc_ext[i], ldt_modify_date[i])
			END IF
		END IF
	ELSE
		as_filename[i] = ""
		Return -1 //added by alfee 08.29.2007
	END IF
NEXT			

RETURN 1
end function

public function boolean of_verify_filename (string as_filename);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_dm_utils.of_verify_filename
// $<arguments> String as_filename
// $<returns> Boolean 
// $<description>Verify File Name field
//////////////////////////////////////////////////////////////////////
// $<add> 05.08.2007 Alfee
//////////////////////////////////////////////////////////////////////
//File name field can't be empty
IF IsNull(as_filename) or Len(Trim(as_filename)) < 1 THEN
	MessageBox("Verification","The document name field can't be empty!")
	RETURN FALSE
END IF

//File name can include: \ / : * ? " < > | ,
IF Match(as_filename, '[\/:*?"<>,]') THEN
	MessageBox("Verification", 'The document name cannot include any of the following characters: ] [ { } \ / : * ? " < > ,  ')
	RETURN FALSE
END IF

//File name can't be duplicated with the existed


RETURN TRUE
end function

public function string of_get_filename (string as_filename);//////////////////////////////////////////////////////////////////////
// $<function>of_get_filenamet()
// $<arguments>
//		value	string	as_filename		
// $<returns> string
// $<description>Get file name without extension
//////////////////////////////////////////////////////////////////////
// $<add> 08.22.2007 by Alfee
//////////////////////////////////////////////////////////////////////

Integer li_pos
String ls_filename, ls_rtn

IF IsNull(as_filename) OR Len(Trim(as_filename)) < 1 THEN RETURN ""

li_pos = LastPos(as_filename,"\")
IF li_pos > 0 THEN
	ls_filename = Mid(as_filename, li_pos + 1)
ELSE
	ls_filename = as_filename
END If

li_pos = LastPos(ls_filename,".")
IF li_pos > 1 THEN
	ls_rtn = Mid(ls_filename, 1, li_pos -1)
ELSE
	ls_rtn = ls_filename
END If

RETURN ls_rtn
end function

public function string of_generate_tempname_random (long al_doc_id, decimal adc_revision, string as_doc_ext);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_dm_utils.of_generate_tempname_random()
// $<arguments>
// $<returns> string: Generated temporary file name
// $<description>Generate a temporary file name to store OLE content
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> By Alfee 09.21.2007
//////////////////////////////////////////////////////////////////////

String ls_file_name

gnv_appeondll.of_parsepath(gs_dir_path + gs_DefDirName + "\Agreement\Manager\")

as_doc_ext = lower(as_doc_ext)

ls_file_name = gs_dir_path + gs_DefDirName + "\Agreement\Manager\tmp" + String(Rand(100)) + "_doc_"+ string(al_doc_id) + "_"+String(adc_revision)+"."+as_doc_ext

return ls_file_name
end function

public function string of_convert_word_file_ext (string as_input_file);//To support Word 2007 - copy a 'DOCX' file to the 'DOC' file with the same name 
//Added by Alfee 10.31.2007

String ls_target_file, ls_file_ext
Integer li_pos

IF Not FileExists(as_input_file) THEN RETURN ""

ls_target_file = as_input_file

li_pos = LastPos(as_input_file, ".")
IF li_pos < 1 THEN RETURN ls_target_file

ls_file_ext = Mid(as_input_file, li_pos + 1, Len(as_input_file))
IF Left(Upper(ls_file_ext), 3) = "DOC" and Len(ls_file_ext) > 3 THEN
	ls_target_file = Left(as_input_file, li_pos) + Left(ls_file_ext, 3)
	IF FileCopy(as_input_file, ls_target_file, TRUE) <> 1 THEN ls_target_file = as_input_file
END IF

RETURN ls_target_file


end function

public function integer of_gen_document_on_rules (string as_source_file, string as_target_file, datastore ads_clause_rule_results);//Clear invalid clauses based on dynamic adding clause rules' results
//Added by Alfee 11.12.2007

Long i, j, ll_cnt, ll_clause_id
String ls_bookmark
Boolean lb_rules = FALSE
OLEObject lole_word, lole_document

//Return if file not existed or no rules defined or rules' result equals to 0
IF Not FileExists(as_source_file) THEN RETURN 0

ll_cnt = ads_clause_rule_results.RowCount()
IF ll_cnt < 1 THEN RETURN 0

FOR i = 1 TO ll_cnt
	IF ads_clause_rule_results.GetItemNumber(i, "rules_result") = 0 THEN 
		lb_rules = TRUE
		EXIT
	END If
NEXT
IF NOT lb_rules THEN RETURN 0

//Create a new Word object	and open the Word document.
lole_word = Create oleobject
IF lole_word.Connecttonewobject("word.application") <> 0 THEN
	Destroy lole_word //Alfee 01.17.2008
	Messagebox('Client Error', 'Could not connect to Microsoft Word. Please make sure it is properly installed.')
	RETURN -1
END IF

TRY
	//Open the file 
	lole_word.Application.NormalTemplate.Saved = TRUE //Alfee 01.17.2008
	//lole_word.Application.Documents.Open(as_source_file,false,false) 
	lole_word.Application.Documents.Open(as_source_file,false,true) //01.21.2008
	gnv_word_utility.of_modify_word_property( lole_word.Activedocument)	//Added By Mark Lee 06/20/2013 change for office 2013.
	gnv_shell.of_delete_recent( as_source_file, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
	lole_word.Visible = FALSE
	lole_document = lole_word.ActiveDocument
	
	//Clear the invalid clauses
	FOR i = 1 TO ll_cnt
		//continue if rules' result is not zero
		IF ads_clause_rule_results.GetItemNumber(i, "rules_result") <> 0 THEN CONTINUE
		//clear invalid clauses according to the adding rules
		ll_clause_id = ads_clause_rule_results.GetItemNumber(i, "ctx_acp_clause_id")
		ls_bookmark = "clause_" + String(ll_clause_id)
		IF lole_document.content.bookmarks.Exists(ls_bookmark) THEN
			lole_document.content.bookmarks.Item(ls_bookmark).Range.Delete()
			IF lole_document.content.bookmarks.Exists(ls_bookmark) Then
				lole_document.content.bookmarks.Item(ls_bookmark).delete()
			End If
		END IF	
	NEXT

	//Save the document & quit
	gnv_rights.of_check_dir_right( as_target_file, true, 'Clause Rule')
	lole_word.ActiveDocument.saveas(as_target_file,0,false,'',false)	
	gnv_shell.of_delete_recent( as_target_file, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
	lole_word.ActiveDocument.Close(0)
	lole_word.Quit(0)
	lole_word.DisconnectObject( )
	Destroy lole_document
	Destroy lole_word

CATCH (Throwable th)
	lole_word.Quit(0)
	lole_word.DisconnectObject( )
	Destroy lole_document
	Destroy lole_word
	RETURN -1
END TRY

RETURN 1


end function

public function integer of_update_document (long al_doc_id, decimal adc_revision, string as_filename, datetime adt_modify);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_dm_utils.of_update_document()
// $<arguments>
//		value long 		al_doc_id		:	the document id
//		value long 		adc_revision	:  the document revision
//		value	string  	as_filename    :	The file name to be updated
//		value	datetime	adt_modify		:	The modify date to current update
// $<returns> integer: 1 - Success ;  -1 - Failed
// $<description>Update document to DB and registry with the modify date
//////////////////////////////////////////////////////////////////////
// $<add>Alfee 11.12.2007 
//////////////////////////////////////////////////////////////////////

Long i, ll_cnt
Blob lb_value

// Get blob from file
if of_readblob( as_filename, ref lb_value ) < 0 then
	messagebox('Read Document','Failed to read from document.')
	return -1
end if

// Store blob value to DB. 
UPDATEBLOB ctx_am_doc_image
SET image_file=:lb_value 
WHERE doc_id=:al_doc_id AND revision=:adc_revision;

IF SQLCA.SQLCODE <> 0 THEN 
	MessageBox('Update Document','Failed to save document to DB due to '+sqlca.sqlerrtext)
	RETURN -1
END IF

// Update registry
of_updateregistry(al_doc_id, adc_revision, 'doc', adt_modify )

return 1

end function

public function integer of_add_audit_trail (long al_doc_id[]);Return of_add_audit_trail(al_doc_id[], 'OutPut - Email')

////Add audit trail based on attached document ids in email
////Added by Alfee 11.28.2007
//Long ll_cnt, i, ll_max_audit_id, ll_row, ll_doc_id
//DataStore lds_audit_trail, lds_document
//
//ll_cnt = UpperBound(al_doc_id)
//IF ll_cnt < 1 THEN RETURN 0
//
//lds_audit_trail = Create DataStore
//lds_audit_trail.DataObject = 'd_dm_doc_audit_browse'
//lds_audit_trail.SetTransObject(SQLCA)
//
//lds_document = Create DataStore
//lds_document.DataObject = 'd_dm_doc_audit_info'
//lds_document.SetTransObject(SQLCA)
//
//ll_cnt = lds_document.Retrieve(al_doc_id)
//
//FOR i = 1 to ll_cnt
//	ll_row = lds_audit_trail.InsertRow(0)
//	ll_max_audit_id = lds_document.GetItemNumber(i, "audit_id")
//	IF NOT ll_max_audit_id > 0 THEN ll_max_audit_id = 1	
//	lds_audit_trail.SetItem(ll_row, "doc_id", lds_document.GetItemNumber(i, "doc_id"))
//	lds_audit_trail.SetItem(ll_row, "audit_id", ll_max_audit_id)
//	lds_audit_trail.SetItem(ll_row, "revision", lds_document.GetItemDecimal(i, "revision"))
//	lds_audit_trail.SetItem(ll_row, "doc_ext", lds_document.GetItemString(i, "doc_ext"))
//	lds_audit_trail.SetItem(ll_row, "action", "OutPut - Email")
//	lds_audit_trail.SetItem(ll_row, "action_by", gs_user_id)
//	lds_audit_trail.SetItem(ll_row, "action_date", DateTime(Today(), Now())	)
//NEXT
//
//lds_audit_trail.Update()
//
//Destroy lds_document
//Destroy lds_audit_trail
//
//IF SQLCA.SQLCODE = -1 THEN
//	MESSAGEBOX("Add document", "Add audit trail records failed due to "+ sqlca.sqlerrtext)
//	RETURN -1
//END IF
//
//IF Isvalid(gw_contract) THEN
//	If gw_contract.tab_contract_details.ib_select9 = True Then
//		ll_doc_id = gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.il_preview_doc_id
//		IF ll_doc_id > 0 THEN gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.dynamic event ue_refresh_audit(ll_doc_id)
//	End If
//END IF
//
//RETURN 1
//
end function

public function integer of_get_clause_rule_reuslts (long al_ctx_id, long al_template_id, datastore ads_results);Return of_get_clause_rule_reuslts( al_ctx_id, al_template_id, ads_results, true ) //modified by gavins 20120726

/*
//Added by Alfee 11.12.2007
Integer li_result
Long i, ll_cnt, ll_clause_id, ll_row
DataStore lds_rules, lds_clauses
string ls_where 

SetPointer(HourGlass!) //01.21.2008

lds_rules = Create DataStore
lds_clauses = Create DataStore
lds_rules.DataObject = 'd_dm_template_clause_rules'
lds_clauses.DataObject = 'd_dm_template_clause_rules'

//Get distinct clauses with rules defined
gnv_data.of_get_data_from_cache('template_clause_rules', 'ctx_acp_template_id = ' + String(al_template_id), lds_clauses) 

FOR i = 1 TO lds_clauses.RowCount()
	IF i = 1 THEN 
		ll_clause_id = lds_clauses.GetItemNumber(i, "ctx_acp_clause_id")
	ELSEIF ll_clause_id = lds_clauses.GetItemNumber(i, "ctx_acp_clause_id") THEN
		lds_clauses.DeleteRow(i)
		i --
	ELSE
		ll_clause_id = lds_clauses.GetItemNumber(i, "ctx_acp_clause_id")		
	END IF
NEXT

//Get rules' result for each clause
ll_cnt = lds_clauses.RowCount()
FOR i = 1 to ll_cnt
	//Get rules for the clause
//	lds_rules.Reset()
	ll_clause_id = lds_clauses.GetItemNumber(i, "ctx_acp_clause_id")
//	gnv_data.of_get_data_from_cache('template_clause_rules', 'ctx_acp_template_id = ' + String(al_template_id) + ' and ctx_acp_clause_id = ' + String(ll_clause_id), lds_rules) 
	//Get and store result to the clause's rules
//	string ls_updatecol[]
//	li_result = f_ctx_find( al_ctx_id, lds_rules,ls_updatecol,'1',ls_where)//add params - jervis 09.14.2010 //modified by gavins  20120723
	li_result = 1 
	ll_row = ads_results.InsertRow(0)
	ads_results.SetItem(ll_row, "ctx_id", al_ctx_id)
	ads_results.SetItem(ll_row, "ctx_acp_template_id", al_template_id)
	ads_results.SetItem(ll_row, "ctx_acp_clause_id", ll_clause_id)
	ads_results.SetItem(ll_row, "rules_result", li_result)	
NEXT

If IsValid(lds_rules) Then Destroy lds_rules 
If IsValid(lds_clauses) Then Destroy lds_clauses

RETURN 1
*/
end function

public function integer of_updateregistry (string as_module, long al_doc_id, decimal adc_revision, string as_doc_ext, datetime adt_modify_date);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils.of_updateregistry()
// $<arguments>
//		value string 	as_module - from which module
//		value	integer 	ai_doc_id      		
//		value	decimal 	adc_revision   		
//		value	string  	as_doc_ext     		
//		value	datetime	adt_modify_date		
// $<returns> integer
// $<description>Register new key value of the document
//////////////////////////////////////////////////////////////////////
// $<add> 07.28.2008 by Alfee
//////////////////////////////////////////////////////////////////////
String ls_regstr, ls_regupdate
Integer li_rtn

CHOOSE CASE Lower(as_module)
	CASE 'document manager'
		//ls_regstr = "doc_" + String(al_doc_id) + "_"+ String(adc_revision)+"."+ as_doc_ext
		ls_regstr = "doc_" + String(al_doc_id) + "_"+ String(adc_revision)+"_"+ as_doc_ext
		ls_regupdate = String(adt_modify_date, "mm/dd/yyyy hh:mm:ss")
		//Modified By Mark Lee 04/18/12
		li_rtn = gnv_appeondll.of_registryset("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Document",ls_regstr, regstring!, ls_regupdate) 	//(Appeon)Harry 06.25.2013 - V141 ISG-CLX	
		//li_rtn = gnv_appeondll.of_registryset("HKEY_LOCAL_MACHINE\SOFTWARE\"+gs_DefDirName+"\Document",ls_regstr, regstring!, ls_regupdate) 	//Commented by (Appeon)Harry 06.25.2013 - V141 ISG-CLX	
	CASE 'clause library painter'
		//		
	CASE 'agreement library painter'
		//
	CASE 'document library painter'
		ls_regstr = 'Document-'+string(al_doc_id)
		ls_regupdate = String(adt_modify_date, "mm/dd/yyyy hh:mm:ss")
		//Modified By Mark Lee 04/18/12 
		li_rtn = gnv_appeondll.of_registryset("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Agreement",ls_regstr, regstring!, ls_regupdate) //(Appeon)Harry 06.25.2013 - V141 ISG-CLX
		//li_rtn = gnv_appeondll.of_registryset("HKEY_LOCAL_MACHINE\SOFTWARE\"+gs_DefDirName+"\Agreement",ls_regstr, regstring!, ls_regupdate) //Commented by (Appeon)Harry 06.25.2013 - V141 ISG-CLX
END CHOOSE		

RETURN li_rtn

	
		

end function

public function integer of_readblob_bk (string as_filename, ref blob ab_value);//A backup for of_readblob() - Alfee 09.28.2008
//////////////////////////////////////////////////////////////////////
// $<function>n_cst_dm_utils.of_readblob()
// $<arguments>
//		value    	string	as_filename		:Specified file name.
//		reference	blob  	ab_value   		: The content value of the specified file.
// $<returns> integer: 1 - Success
//                     -1 - Failure
// $<description>Read blob value of a specified file.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2006-12-04 by Frank.Gui
//////////////////////////////////////////////////////////////////////

if not fileexists(as_filename) then return -1

Int li, li_MaxPosition, li_Position, li_SetStep, li_NewStep
Long ll_FileNum,ll_FileLength,ll_Loop, ll_LoopR
String ls_title
Boolean lb_needrestore = FALSE
Blob lb_temp

SetPointer(HourGlass!) 

//Get the file length
ll_FileLength = filelength(as_FileName)
IF ll_FileLength > 32765 THEN
   IF Mod(ll_FileLength, 32765) = 0 THEN
      ll_Loop = ll_FileLength/32765
   ELSE
     ll_Loop = (ll_FileLength/32765) + 1
   END IF
ELSE
   ll_Loop = 1
END IF

//--------Begin Modified by Alfee 09.17.2007--------------------------------
//<$Reason>Display progress bar for the large document
li_NewStep = 20
IF ll_Loop > li_NewStep THEN
	IF IsValid(w_appeon_gifofwait) THEN 
		//Keep the original progress bar
		lb_needrestore = TRUE
		ls_title = w_appeon_gifofwait.st_1.Text
		li_MaxPosition = w_appeon_gifofwait.hpb_1.MaxPosition
		li_Position = w_appeon_gifofwait.hpb_1.Position
		li_SetStep = w_appeon_gifofwait.hpb_1.SetStep
	ELSE
		OpenwithParm(w_appeon_gifofwait,"Reading the document...")
	END IF
	//Set the new progress bar
	ll_LoopR = ll_Loop / li_NewStep
	IF Mod(ll_Loop, li_NewStep) <> 0 THEN ll_LoopR ++
	w_appeon_gifofwait.st_1.Text = "Reading the document..."
	w_appeon_gifofwait.hpb_1.MaxPosition = ll_LoopR * li_NewStep
	w_appeon_gifofwait.hpb_1.Position = 0
	w_appeon_gifofwait.hpb_1.SetStep = ll_LoopR		
END IF

//Open and Read the document into blob
ll_FileNum = FileOpen(as_FileName,streammode!,read!,Shared! )

for li=1 to ll_loop
	if FileRead(ll_FileNum,lb_temp)< 0 then Exit
	ab_Value+=lb_temp
	IF IsValid(w_appeon_gifofwait) AND ll_Loop > li_NewStep THEN
		IF Mod(li, ll_LoopR) = 1 THEN w_appeon_gifofwait.hpb_1.StepIt() 
	ELSE
		IF IsValid(w_appeon_gifofwait) THEN w_appeon_gifofwait.hpb_1.StepIt()
	END IF
next

//Restore Progress Bar
IF IsValid(w_appeon_gifofwait) and ll_Loop > li_NewStep THEN 
	IF lb_needrestore THEN
		w_appeon_gifofwait.st_1.Text = ls_title
		w_appeon_gifofwait.hpb_1.MaxPosition = li_MaxPosition
		w_appeon_gifofwait.hpb_1.Position = li_Position
		w_appeon_gifofwait.hpb_1.SetStep = li_SetStep
	ELSE
		Close(w_appeon_gifofwait)
	END IF
END IF

//Close the document
IF ll_FileNum > 0 THEN FileClose(ll_FileNum)
/*ll_FileNum = FileOpen(as_FileName,streammode!,read!,Shared! )
for li=1 to ll_loop
	if FileRead(ll_FileNum,lb_temp)< 0 then return -1
	ab_Value+=lb_temp
next
FileClose(ll_FileNum)*/
//--------End Modified --------------------------------------------------

return 1

end function

public function integer of_saveblob_bk (string as_filename, blob ab_value);//A backup for of_saveblob() - Alfee 09.28.2008
//////////////////////////////////////////////////////////////////////
// $<function>n_cst_dm_utils.of_saveblob()
// $<arguments>
//		value    	string	as_filename		:Specified file name.
//		value		   blob  	ab_value   		: The content value of the specified file.
// $<returns> integer: 1 - Success
//                     -1 - Failure
// $<description>Save blob value to a specified file.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2006-12-04 by Frank.Gui
//////////////////////////////////////////////////////////////////////
Int li, li_MaxPosition, li_Position, li_SetStep, li_NewStep
long ll_FileNum,ll_BlobLength,ll_Loop,ll_CurrentPos, ll_LoopR
String ls_title
Boolean lb_needrestore = FALSE
Blob lb_temp

if fileexists(as_filename) then 
	if not filedelete(as_FileName) then
		return -1
	end if
end if

SetPointer(HourGlass!) 

//Get length of the blob 
ll_BlobLength = Len(ab_value)
IF ll_BlobLength > 32765 THEN
   IF Mod(ll_BlobLength, 32765) = 0 THEN
      ll_Loop = ll_BlobLength/32765
   ELSE
     ll_Loop = (ll_BlobLength/32765) + 1
   END IF
ELSE
   ll_Loop = 1
END IF

//Open the document
ll_FileNum = FileOpen(as_FileName,streammode!,write!,LockWrite!,replace!)
if ll_FileNum< 0 then return -1

//--------Begin Modified by Alfee 09.17.2007--------------------------------
//<$Reason>Display progress bar for the large document
li_NewStep = 20
IF ll_Loop > li_NewStep THEN
	IF IsValid(w_appeon_gifofwait) THEN 
		//Keep the original progress bar
		lb_needrestore = TRUE
		ls_title = w_appeon_gifofwait.st_1.Text
		li_MaxPosition = w_appeon_gifofwait.hpb_1.MaxPosition
		li_Position = w_appeon_gifofwait.hpb_1.Position
		li_SetStep = w_appeon_gifofwait.hpb_1.SetStep
	ELSE
		OpenwithParm(w_appeon_gifofwait,"Writing the document...")
	END IF
	//Set the new progress bar
	ll_LoopR = ll_Loop / li_NewStep
	IF Mod(ll_Loop, li_NewStep) <> 0 THEN ll_LoopR ++
	w_appeon_gifofwait.st_1.Text = "Writing the document..."
	w_appeon_gifofwait.hpb_1.MaxPosition = ll_LoopR * li_NewStep
	w_appeon_gifofwait.hpb_1.Position = 0
	w_appeon_gifofwait.hpb_1.SetStep = ll_LoopR		
END IF

//Write blob into the document
ll_CurrentPos = 1
FOR li=1 TO ll_loop
	lb_temp = BlobMid(ab_value, ll_CurrentPos, 32765)
	ll_CurrentPos += 32765
	IF FileWrite(ll_FileNum, lb_temp) < 0 THEN EXIT
	IF IsValid(w_appeon_gifofwait) AND ll_Loop > li_NewStep THEN
		IF Mod(li, ll_LoopR) = 1 THEN w_appeon_gifofwait.hpb_1.StepIt() 
	ELSE
		IF IsValid(w_appeon_gifofwait) THEN w_appeon_gifofwait.hpb_1.StepIt()
	END IF	 
NEXT

//Restore Progress Bar
IF IsValid(w_appeon_gifofwait) and ll_Loop > li_NewStep THEN 
	IF lb_needrestore THEN
		w_appeon_gifofwait.st_1.Text = ls_title
		w_appeon_gifofwait.hpb_1.MaxPosition = li_MaxPosition
		w_appeon_gifofwait.hpb_1.Position = li_Position
		w_appeon_gifofwait.hpb_1.SetStep = li_SetStep
	ELSE
		Close(w_appeon_gifofwait)
	END IF
END IF

//Close the document
IF ll_FileNum > 0 THEN FileClose(ll_FileNum)
/*ll_CurrentPos = 1
for li=1 to ll_loop
	 lb_temp = BlobMid(ab_value, ll_CurrentPos, 32765)
	 ll_CurrentPos += 32765
	 If FileWrite(ll_FileNum, lb_temp) = -1 Then
		 Return -1
	 End If
next
FileClose(ll_FileNum)*/
//--------End Modified --------------------------------------------------

return 1

end function

public function integer of_update_tif_ocr (long al_doc_id, decimal adec_revision, string as_filename);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_dm_utilsof_update_tif_ocr()
// $<arguments>
//		value	long   	al_doc_id    		
//		value	decimal	adec_revision		
//		value	string 	as_filename  		
// $<returns> integer
// $<description>
// $<description> Update OCR by tif file.
//////////////////////////////////////////////////////////////////////
// $<add> 2009-05-31 by Ken.Guo
//////////////////////////////////////////////////////////////////////

String ls_doc_ext,ls_PdfText
ls_doc_ext = Lower(of_get_fileext( as_filename ))

If ls_doc_ext <> 'tif' Then Return -1

n_cst_image_cp_ocr lnv_ocr
lnv_ocr = Create n_cst_image_cp_ocr
//inv_cst_tif2text.of_tif2text(as_filename, ls_PdfText)
ls_PdfText = lnv_ocr.of_ocr(as_filename)

If Len(ls_PdfText) > 0 then
	UPDATE ctx_am_doc_image
	SET pdftext = :ls_PdfText
	WHERE doc_id = :al_doc_id AND revision = :adec_Revision;
End If

If isvalid(lnv_ocr) Then destroy lnv_ocr
Return 1
end function

public function string of_get_fileext (string as_filename, boolean ab_original);//////////////////////////////////////////////////////////////////////
// $<function>of_get_fileext()
// $<arguments>
//		value	string	as_filename		
//		boolean	ab_original
// $<returns> string
// $<description>Get file extended name
//////////////////////////////////////////////////////////////////////
// $<add> 01.13.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////

string  ls_temp
int  pos

ls_temp = reverse(as_filename)
pos = pos(ls_temp,'.')
IF pos > 0 THEN
	//--------Begin Modfied by Alfee 10.31.2007-------
	//<$Reason>To support Word 2007
	String ls_fileext
	ls_fileext = reverse(left(ls_temp,pos - 1))
	if not ab_original then	// Jervis 10.21.2009
		IF Left(Upper(ls_fileext), 3) = "DOC" THEN ls_fileext = Left(ls_fileext, 3)	
	end if
	RETURN ls_fileext
	//return reverse(left(ls_temp,pos - 1))	
	//--------End Modified ----------------------------
ELSE
	return ''
END IF
end function

public function integer of_convert2pdf (long al_doc_id, ref decimal adec_revision, string as_filename, string as_old_ext);Integer li_ret
long ll_doc_id
decimal{1} ldec_new_revision,ldec_old_revision
String ls_pdf_file
Datetime ldt_modify_date

n_cst_image_functions_cp lnv_image_cp
lnv_image_cp = Create n_cst_image_functions_cp

ldec_old_revision = adec_revision

//Get new revision.
ldec_new_revision = Truncate(adec_revision + 1,0)

//Get new file name
ls_pdf_file = This.of_generate_tempname(al_doc_id, ldec_new_revision, 'pdf')

//Save as to PDF file.
If lnv_image_cp.of_convert2pdf( as_filename, ls_pdf_file) < 0 Then
	Messagebox('Error','Failed to convert to PDF.')
	If isvalid(lnv_image_cp) Then Destroy lnv_image_cp
	Return -1
End If

//Upload row to DB
INSERT Ctx_am_doc_image(Doc_id, Revision, doc_ext, modify_date,doc_ext_full)
	Values( :al_doc_id, :ldec_new_revision, 'pdf', :ldt_modify_date ,'pdf');

//updata blob to DB
li_ret = This.of_upload_file( al_doc_id, ldec_new_revision, ls_pdf_file)
If li_ret < 0 Then
	Messagebox('Error','Failed to upload the file.')
	If isvalid(lnv_image_cp) Then Destroy lnv_image_cp
	Return -2
End If

//Add audit trail
str_add_audit lstr_add_audit
lstr_add_audit.doc_id = al_doc_id
lstr_add_audit.revision = ldec_new_revision
lstr_add_audit.doc_ext = 'pdf'
lstr_add_audit.action = "Convert to PDF from " + Upper(as_old_ext)
li_ret = This.of_add_audit_trail( lstr_add_audit )

//Update register.
Select Modify_date into :ldt_modify_date From ctx_am_doc_image Where doc_id = :al_doc_id and revision = :ldec_new_revision;
This.of_updateregistry(al_doc_id, ldec_new_revision, 'pdf', ldt_modify_date)	

//Update main record
UPDATE Ctx_am_document
	SET revision = :ldec_new_revision,
	revision_control = '1',
	doc_ext = 'pdf'
	Where Doc_id = :al_doc_id;

//Update OCR Result
Update ctx_am_doc_image 
	Set pdftext = (Select pdftext From ctx_am_doc_image where doc_id = :al_doc_id and  revision = :ldec_old_revision  )
Where doc_id = :al_doc_id and  revision = :ldec_new_revision ;

//return revision argument 
adec_revision = ldec_new_revision

Return 1

end function

public function integer of_update_clausemap (long al_doc_id, decimal adec_old_revision, decimal adec_new_revision, datawindow adw_clause, string as_filename);String ls_temp_file,ls_bookmark,ls_bm[]
long i,j,ll_clause_id,ll_cnt,li_rtn
oleobject lole_word,lole_document
DataStore lds_clause,lds_clause_temp
Boolean lb_found

lole_word = Create oleobject
lole_document = Create oleobject

lds_clause = Create DataStore
lds_clause.DataObject = 'd_dm_clause_map'
lds_clause.SetTransObject(SQLCA)

lds_clause_temp = Create DataStore
lds_clause_temp.DataObject = 'd_dm_clause_map'
lds_clause_temp.SetTransObject(SQLCA)

If isvalid(adw_clause) Then
	adw_clause.ShareData(lds_clause)
Else	
	lds_clause.Retrieve(al_doc_id,adec_old_revision)
End If

ll_cnt = lds_clause.rowcount()

//Copy to a temporary file
IF not FileExists(as_filename) THEN RETURN -1
ls_temp_file = gs_dir_path + gs_DefDirName + "\Agreement\"  + "tem_" + String(Rand(1000)) +".doc"
IF FileCopy(as_filename, ls_temp_file, TRUE) < 0 THEN 
	Messagebox('Error','Failed to replace the file ' + String(ls_temp_file) + '.')
	RETURN -1 
End If

//Open the file with readonly property in a new word application
IF lole_word.Connecttonewobject("word.application") <> 0 THEN
	Destroy lole_word //Alfee 01.17.2008
	Destroy lole_document //Alfee 01.17.2008
	messagebox('Client Error', 'This application could not connect to Microsoft Word. Please make sure it is properly installed.')
	RETURN -1
END IF
lole_word.Visible = FALSE

Try
lole_word.Application.NormalTemplate.Saved = TRUE //Alfee 01.17.2008	
lole_word.Application.Documents.Open(ls_temp_file,FALSE,TRUE)
gnv_word_utility.of_modify_word_property( lole_word.Activedocument)	//Added By Mark Lee 06/20/2013 change for office 2013.
gnv_shell.of_delete_recent( ls_temp_file, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
lole_document = lole_word.ActiveDocument
Catch (Throwable th)
	//----Begin Modified by Alfee 01.17.2008----
	f_word_destroy(lole_word, "")
	Destroy lole_document
	RETURN -1	
End Try

Try
//Clear invalid bookmark(s)
FOR i = 1 TO lole_document.Content.Bookmarks.Count
	ls_bookmark = lole_document.Content.Bookmarks.Item[i].Name
	IF Lower(Left(ls_bookmark,7)) <> "clause_" THEN
		lole_document.Content.bookmarks.item[i].Delete()
		i --
	END IF
NEXT

//Get clause bookmark(s) name in order
FOR i = 1 TO lole_document.Content.Bookmarks.Count
	ls_bm[i] = lole_document.Content.Bookmarks.Item(i).Name
NEXT

Catch (Throwable th2)
	f_word_destroy(lole_word, "")
	Destroy lole_document
	RETURN -1	//05.28.2007
End Try

//Veision control
IF adec_new_revision <> adec_old_revision THEN
	//Copy old revision to new revision and reset old revision. for Insert data again.
	lds_clause_temp.Reset()
	lds_clause.AcceptText()
	lds_clause.RowsCopy(1, lds_clause.rowcount(), Primary!, lds_clause_temp, 1, Primary!)	
	FOR i = 1 to ll_cnt
		lds_clause_temp.SetItem(i,"revision",adec_new_revision)
	Next
	lds_clause.Reset()	
	lds_clause_temp.RowsCopy(1, lds_clause_temp.rowcount(), Primary!, lds_clause, 1, Primary!)		
END IF	

//update dw_clause according to bookmarks
For i =  1 to ll_cnt
	ll_clause_id = lds_clause.object.ctx_acp_clause_id[i]
	lb_found = False
	For j =  1 to Upperbound(ls_bm)
		IF ls_bm[j] = "clause_" + string(ll_clause_id) THEN
			lb_found = True
			EXIT				
		END IF
	Next
	IF not lb_found THEN
		lds_clause.DeleteRow(i)
		i = i -1
		ll_cnt = ll_cnt -1
	END IF
NEXT
li_rtn = lds_clause.Update() 

lole_document.Close(0)
lole_word.Quit(0)
lole_word.DisconnectObject( )
Destroy lole_document
Destroy lole_word

Return li_rtn
end function

public function string of_generate_tempname (long al_doc_id, decimal adc_revision, string as_doc_name, string as_doc_ext);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_dm_utils.of_generate_tempname()
// $<arguments>
// $<returns> string: Generated temporary file name
// $<description>Generate a temporary file name to store OLE content
// $<description>
//////////////////////////////////////////////////////////////////////
//Added By Ken.Guo 2010-06-30.
//////////////////////////////////////////////////////////////////////

String ls_file_name
int  i
boolean   ab_support=false
string ls_name

gnv_appeondll.of_parsepath(gs_dir_path + gs_DefDirName + "\Agreement\Manager\")

as_doc_ext = lower(as_doc_ext)

ls_file_name = gs_dir_path + gs_DefDirName + "\Agreement\Manager\" + as_doc_name + ' ' + string(al_doc_id) + "."+String(adc_revision,'##0.0')+"."+as_doc_ext

return ls_file_name
end function

public function integer of_convert2pdf (string as_sourcefile, string as_targetfile);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_dm_utilsof_convert2pdf()
// $<arguments>
//		value	string	as_sourcefile		
//		value	string	as_targetfile		
// $<returns> integer
// $<description>
// $<description> Convert to file to PDF if it can be converted.
//////////////////////////////////////////////////////////////////////
// $<add> 2010-07-05 by Ken.Guo
//////////////////////////////////////////////////////////////////////

String ls_fileext,ls_prntrs,ls_SourceFile,ls_DefPrinter
Integer li_file
long ll_Len
oleobject lole_word
n_cst_filesrvwin32 lnv_filesvr
n_cst_image_functions_cp lnv_image_cp

If Not FileExists(as_sourcefile) Then 
	Messagebox('Convert to PDF Error','The source file '+as_sourcefile+' is not exists.')	
	Return -1
End If

ls_fileext = Lower(This.of_get_fileext( as_sourcefile, True))
lnv_image_cp = Create n_cst_image_functions_cp
If Not lnv_image_cp.of_is_image2pdf(ls_fileext) and ls_fileext <> 'doc' and ls_fileext <> 'docx'  Then
	If isvalid(lnv_image_cp) Then Destroy lnv_image_cp	
	Return 0
End If

If as_sourcefile = as_targetfile Then
	If isvalid(lnv_image_cp) Then Destroy lnv_image_cp	
	Return 0	
End If

//Delete the old target pdf file if exists.
IF FileExists(as_targetfile) THEN 
	IF Not FileDelete(as_targetfile) THEN 
		MessageBox("Convert to PDF Error", "Please delete the temp file of '" + as_targetfile + "' first! ")				
		RETURN -1
	END IF
END IF

SetPointer(HourGlass!)
If ls_fileext = 'doc' or ls_fileext = 'docx' Then
	//Check PDF Printer for Word dcoument
	if f_PrinterSetup(2) >= 2 then 
		Return -1
	end If
	ls_prntrs = PrintGetPrinters ( )
	//---------Begin Modified by (Appeon)Harry 01.27.2014 for V142 ISG-CLX--------
	/*
	IF NOT Pos(lower(ls_prntrs),lower("Contract Logix PDF Writer")) > 0 THEN
		MessageBox("Printer Error","The Contract Logix PDF Writer is not configured correctly!")
		If isvalid(lnv_image_cp) Then Destroy lnv_image_cp	
		RETURN -1
	END IF

	//Convert to PDF, get & convert Word document
	ls_SourceFile = "C:\Program Files\PDFPrinter\temp\SampleOut.PDF"
	*/
	IF NOT Pos(lower(ls_prntrs),lower("IntelliSoft PDF Writer")) > 0 THEN
		MessageBox("Printer Error","The IntelliSoft PDF Writer is not configured correctly!")
		If isvalid(lnv_image_cp) Then Destroy lnv_image_cp	
		RETURN -1
	END IF
	
	ls_SourceFile = gs_temp_pdf
	//---------End Modfiied ------------------------------------------------------
	
	//Delete temporary pdf file 
	IF FileExists(ls_SourceFile) THEN 
		IF Not FileDelete(ls_SourceFile) THEN 
			MessageBox("Printer Error", "Please delete the file of '" + ls_SourceFile + "' first! ")				
			If isvalid(lnv_image_cp) Then Destroy lnv_image_cp				
			RETURN -1
		END IF
	END IF
	
	lole_word = Create oleobject
	IF lole_word.Connecttonewobject("word.application") <> 0 THEN
		Destroy lole_word 
		Messagebox('Client Error', 'Could not connect to Microsoft Word. Please make sure it is properly installed.')
		If isvalid(lnv_image_cp) Then Destroy lnv_image_cp	
		RETURN -1
	END IF
	lole_word.Visible = FALSE	
	lole_word.Application.NormalTemplate.Saved = TRUE 

	If Not isvalid(w_appeon_gifofwait) Then OpenwithParm(w_appeon_gifofwait,"Converting to PDF...")
	SetPointer(HourGlass!)

	IF Isvalid(w_appeon_gifofwait) THEN w_appeon_gifofwait.event timer()
	
	//Delete temporary pdf file 
	IF FileExists(ls_SourceFile) THEN FileDelete(ls_SourceFile)
	
	//Open Word Document 		
	lole_word.Application.Documents.Open(as_sourcefile,false,true)	
	gnv_word_utility.of_modify_word_property( lole_word.Activedocument)	//Added By Mark Lee 06/20/2013 change for office 2013.
	gnv_shell.of_delete_recent( as_sourcefile, true) //Delete Windows Recent Document.
		
	//Set pdf Printer and print to PDF format
	Try
		ll_Len = 100
		ls_DefPrinter = SPACE(ll_Len)
		GetDefaultPrinter(ls_DefPrinter,ll_Len)	
		
		//---------Begin Modified by (Appeon)Harry 01.27.2014 for V142 ISG-CLX--------
		//lole_word.ActiveDocument.Application.ActivePrinter = "Contract Logix PDF Writer"
		lole_word.ActiveDocument.Application.ActivePrinter = "IntelliSoft PDF Writer"
		//---------End Modfiied ------------------------------------------------------
		lole_word.ActiveDocument.Printout( 0 )
		lole_word.ActiveDocument.Close(0)
		
		SetDefaultPrinter(ls_DefPrinter)				
	Catch(Throwable th1) 
		lole_word.ActiveDocument.Close(0)		
		lole_word.Quit(0)
		lole_word.DisconnectObject( )
		Destroy lole_word
		If isvalid(lnv_filesvr) Then Destroy lnv_filesvr		
		If isvalid(n_cst_filesrvwin32) Then Destroy n_cst_filesrvwin32
		IF Isvalid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)
		//---------Begin Modified by (Appeon)Harry 01.27.2014 for V142 ISG-CLX--------
		//MessageBox("Printer Error","The Contract Logix PDF Writer is not configured correctly!")
		MessageBox("Printer Error","The IntelliSoft PDF Writer is not configured correctly!")
		//---------End Modfiied ------------------------------------------------------
		RETURN -1
	End Try

	// Copy to target file
	If not isvalid(lnv_filesvr) Then lnv_filesvr = create n_cst_filesrvwin32
	Do 
		//Yield()
		If FileExists(ls_sourcefile) Then 
			li_file = FileOpen(ls_sourcefile, StreamMode!, Write!)
		Else
			li_file = -1
		End If
	Loop While li_file = -1
	FileClose(li_file)
	
	//lnv_filesvr.of_filecopy(ls_sourcefile, as_targetfile )
	filecopy(ls_sourcefile, as_targetfile ,true) //APB Blob Bug
	
Else
	If lnv_image_cp.of_is_image2pdf(ls_fileext) Then
		If lnv_image_cp.of_convert2pdf(as_sourcefile, as_targetfile) <> 1 Then
			If isvalid(lnv_image_cp) Then Destroy lnv_image_cp
			If isvalid(n_cst_filesrvwin32) Then Destroy n_cst_filesrvwin32
			Messagebox('Convert to PDF Error','Failed to convert the image file ' + as_sourcefile + ' to PDF.')
			Return -1
		End If
	Else
		//Unsupport File.
		If isvalid(lnv_image_cp) Then Destroy lnv_image_cp
		If isvalid(n_cst_filesrvwin32) Then Destroy n_cst_filesrvwin32
		IF Isvalid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)
		Return 0
	End If
End If

If isvalid(lnv_image_cp) Then Destroy lnv_image_cp
If isvalid(n_cst_filesrvwin32) Then Destroy n_cst_filesrvwin32
IF Isvalid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)
Return 1
end function

public function integer of_create_clean_doc (string as_sourcefile, ref string as_targetfile, string as_from);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_dm_utilsof_create_clean_doc()
// $<arguments>
//		value	string	as_sourcefile		
//		value	string	as_targetfile		
//		value	string	as_from      		
// $<returns> integer
// $<description>
// $<description> Create Clean Document. Need Delete all redlines and bookmarks.
//////////////////////////////////////////////////////////////////////
// $<add> 2010-07-05 by Ken.Guo
//////////////////////////////////////////////////////////////////////

String ls_clean_path,ls_ext,ls_filename
Integer i
oleobject lole_word
Long ll_comments_cnt,ll_revi_cnt
String ls_cleanfile_fullname

//Check file ext.
ls_ext = Mid(as_sourcefile, LastPos(as_sourcefile, ".") + 1)
If lower(ls_ext) = 'doc' Then Return 0

//Create directory
ls_clean_path = gs_dir_path + gs_DefDirName + "\Agreement\Email\CleanDoc\" + as_from  
IF Not DirectoryExists( ls_clean_path ) THEN
	If Not f_createdirectory(ls_clean_path ) Then
		Messagebox('IntelliSoft','Failed to create temporary directory, please call support.') //(Appeon)Harry 01.27.2014 - V142 ISG-CLX  modify 'ContractLogix' to 'IntelliSoft'
		Return -1
	End If
END IF

//Delete the old target file if exists.
IF FileExists(as_targetfile) THEN 
	IF Not FileDelete(as_targetfile) THEN 
		MessageBox("Create Clean File Error", "Please delete the temp file of '" + as_targetfile + "' first! ")				
		RETURN -1
	END IF
END IF

//Generate word document
If lower(ls_ext) = 'doc' Then
	lole_word = Create oleobject
	IF lole_word.Connecttonewobject("word.application") <> 0 THEN
		Destroy lole_word 
		Messagebox('Client Error', 'Could not connect to Microsoft Word. Please make sure it is properly installed.')
		RETURN -1
	END IF

	//Accept revisions and remove comments in word	
	Try
		lole_word.Visible = FALSE	
		lole_word.Application.NormalTemplate.Saved = TRUE
		lole_word.Application.Documents.Open(as_sourcefile,False,True)
		gnv_word_utility.of_modify_word_property( lole_word.Activedocument)	//Added By Mark Lee 06/20/2013 change for office 2013.
		gnv_shell.of_delete_recent( as_sourcefile, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
		ll_revi_cnt = lole_word.ActiveDocument.Revisions.Count
		ll_revi_cnt += This.of_get_sharps_revision_count( lole_word.ActiveDocument) //Added By Ken.Guo 2010-10-14.
		ll_comments_cnt = lole_word.ActiveDocument.Comments.Count
		
		If ll_revi_cnt > 0 or ll_comments_cnt > 0 Then
			ls_filename = Mid(as_sourcefile,LastPos(as_sourcefile, "\") + 1, LastPos(as_sourcefile,'.') - LastPos(as_sourcefile, "\") + 1 ) + '(Clean).doc'
			ls_cleanfile_fullname = ls_clean_path + '\' + ls_filename
			//If document have redline.
			If ll_revi_cnt > 0 Then
				//lole_word.ActiveDocument.Revisions.AcceptAll()
				lole_word.ActiveDocument.AcceptAllRevisions() //Modified By Ken.Guo 2010-10-14
			End If
			ll_comments_cnt = lole_word.ActiveDocument.Comments.Count
			For i = ll_comments_cnt To 1 Step -1
				lole_word.ActiveDocument.Comments[i].Delete()
			Next
			//SaveAs to clean dir
			lole_word.ActiveDocument.SaveAS(ls_cleanfile_fullname,0,false,'',false)
			gnv_shell.of_delete_recent( ls_cleanfile_fullname, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
			If as_targetfile = '' Then
				as_targetfile = ls_cleanfile_fullname
			Else
				FileCopy(ls_cleanfile_fullname,as_targetfile,True)
			End If
		Else
			lole_word.ActiveDocument.Close(0)		
			lole_word.Quit(0)
			lole_word.DisconnectObject( )	
			If isvalid(lole_word) Then Destroy lole_word
			Return 0
		End If
		lole_word.ActiveDocument.Close(0)		
		lole_word.Quit(0)
		lole_word.DisconnectObject( )
	Catch(Throwable th1)
		lole_word.ActiveDocument.Close(0)		
		lole_word.Quit(0)
		lole_word.DisconnectObject( )
		Destroy lole_word		
		Return -1
	End Try

Else
	If isvalid(lole_word) Then Destroy lole_word
	Return 0
End If

If isvalid(lole_word) Then Destroy lole_word

Return 1

end function

public function string of_get_ocr_result (string as_filename);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_dm_utilsof_get_ocr_result()
// $<arguments>
//		value	string	as_filename		
// $<returns> string
// $<description>
// $<description> Get the OCR result
//////////////////////////////////////////////////////////////////////
// $<add> 2010-07-08 by Ken.Guo
//////////////////////////////////////////////////////////////////////

String ls_doc_ext,ls_PdfText
n_cst_image_cp_ocr lnv_ocr

ls_doc_ext = This.of_get_fileext(as_filename)
If gnv_data.of_getitem('icred_settings' ,'set_48' , False ) = '1'  /*Global Search module is On*/ &
and gnv_data.of_getitem('icred_settings' ,'auto_ocr' , False ) = '1'  Then //Auto OCR is Yes
	lnv_ocr = Create n_cst_image_cp_ocr
	Choose Case Upper(ls_doc_ext) 
		Case 'PDF'
			inv_cst_pdf2text.of_pdf2text(as_FileName, ls_PdfText) //For searchable PDF.
			If ls_PdfText = '' Then
				ls_PdfText = lnv_ocr.of_ocr(as_FileName)
			End If
		Case 'BMP','TIF','TIFF','JPG','GIF'
				ls_PdfText = lnv_ocr.of_ocr(as_FileName)	
	End Choose
End If

Return ls_PdfText
end function

public function integer of_upload_file (long al_doc_id, decimal adc_revision, string as_filename, string as_ocr_result);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ovole_utils::of_upload_file()
// $<arguments>
//		value	long   	al_doc_id      :	Corresponding Document ID
//		value	decimal	adc_revision	:	Corresponding Document revision
//    value string   as_filename    :  Document File Name
//    value string   as_ocr_result  :  Document OCR Result
// $<returns> integer: 1 - Success
// 		             -1: Cannot generate temporary file.
//       		       -2: Failed to save data to the temporary file.
//            		    -3: Failed to read content from the temporary file.
//                    -4: Failed to insert base data to ctx_am_doc_image.
//                    -5: Failed to update blob value to ctx_am_doc_image.
// $<description>Save the content of current OCX to the corresponding record in the DB.
// $<description>
//////////////////////////////////////////////////////////////////////
//Created By Frank.Gui 
//Modified By Ken.Guo 2010-07-08.
//////////////////////////////////////////////////////////////////////

String ls_doc_ext
string ls_doc_ext_full	
Blob   lb_value
Int   li_count
Int	li_count_all 
String ls_pdftext
n_cst_image_cp_ocr lnv_ocr

// Get blob from file
if of_readblob( as_filename, ref lb_value ) < 0 then
	messagebox('Error1','Failed to get document data')
	return -1
end if

// Get File extend name
ls_doc_ext = Lower(of_get_fileext( as_filename ))
ls_doc_ext_full = Lower(of_get_fileext( as_filename ,true))	
// Check doc exists in DB
SELECT count(*) into :li_count FROM ctx_am_doc_image 
WHERE doc_id = :al_doc_id AND revision = :adc_revision;

//Check whether new document 
Select Count(1) Into :li_count_all From ctx_am_doc_image
Where doc_id = :al_doc_id;

//-------Appeon Begin ----modified by alfee at 03.14.2007 for performance tunning
//gnv_appeondb.of_commitqueue( ) //commented by alfee 09.14.2007
IF li_count < 1 THEN
	//Add doc_ext_full Field - jervis10.21.2009
	INSERT INTO ctx_am_doc_image (doc_id, revision, doc_ext, modify_date,doc_ext_full)
	VALUES(:al_doc_id, :adc_revision, :ls_doc_ext, getdate(),:ls_doc_ext_full);
//---------Begin Modified by Alfee 09.14.2007---------------
//<$Reason>for check in/out operation
ELSE 
	//Add doc_ext,doc_ext_full fileds - jervis 10.21.2009
	UPDATE ctx_am_doc_image SET modify_date = getdate(),doc_ext = :ls_doc_ext,doc_ext_full = :ls_doc_ext_full  
	 WHERE doc_id = :al_doc_id AND revision = :adc_revision;
//----------End Modified -----------------------------------
//	if sqlca.sqlcode =  0 then
//		COMMIT;
//	ELSE
//		messagebox('Error2','Failed to save document to DB due to '+sqlca.sqlerrtext)
//		return -2
//	end if
END IF
//---------Begin Modified by Alfee 09.14.2007---------------
IF SQLCA.SQLCODE <> 0 THEN 
	MessageBox('Error2','Failed to save document to DB due to '+sqlca.sqlerrtext)
	RETURN -2
END IF
//----------End Modified -----------------------------------

// Store blob value to DB. 
UPDATEBLOB ctx_am_doc_image
SET image_file=:lb_value 
WHERE doc_id=:al_doc_id AND revision=:adc_revision;

//Added By Ken.Guo 2009-12-22. Rollback main data if updateblob failed.
IF SQLCA.SQLCODE <> 0 THEN 
	MessageBox('Error3','Failed to upload document to DB due to '+sqlca.sqlerrtext)
	If li_count_all = 0 Then
		Delete from ctx_am_doc_image Where doc_id = :al_doc_id;
		Delete from ctx_am_document where doc_id = :al_doc_id;
	End If
	RETURN -3
END IF


//Added By Ken.Guo 2009-07-01. If it is new 
IF li_count < 1 THEN
	Update ctx_am_document Set Revision = :adc_revision, doc_ext = :ls_doc_ext Where doc_id = :al_doc_id;
End  If

IF SQLCA.SQLCODE <> 0 THEN 
	MessageBox('Error4','Failed to save document to DB due to '+sqlca.sqlerrtext)
	RETURN -4
END IF
//-------Appeon End ---------------------


If gnv_data.of_getitem('icred_settings' ,'set_48' , False ) = '1'  /*Global Search module is On*/ &
and gnv_data.of_getitem('icred_settings' ,'auto_ocr' , False ) = '1'  Then //Auto OCR is Yes
	if as_ocr_result = '' Then 
		lnv_ocr = Create n_cst_image_cp_ocr
		Choose Case Upper(ls_doc_ext) 
			Case 'PDF'
				inv_cst_pdf2text.of_pdf2text(as_FileName, ls_PdfText) //For searchable PDF.
				If ls_PdfText = '' Then
					ls_PdfText = lnv_ocr.of_ocr(as_FileName)
				End If
			Case 'BMP','TIF','TIFF','JPG','GIF'
					ls_PdfText = lnv_ocr.of_ocr(as_FileName)	
		End Choose
		
		if Len(ls_PdfText) > 0 then
			UPDATE ctx_am_doc_image
			SET pdftext = :ls_PdfText
			WHERE doc_id = :al_doc_id AND revision = :adc_Revision;
		end if
	Else
		UPDATE ctx_am_doc_image
		SET pdftext = :as_ocr_result
		WHERE doc_id = :al_doc_id AND revision = :adc_Revision;		
	End if
End If

If isvalid(lnv_ocr) Then Destroy lnv_ocr

Return 1
end function

public function long of_get_sharps_revision_count (oleobject aole_document);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_dm_utils.of_get_sharps_revision_count()
// $<arguments>
//		value	oleobject	aole_document		
// $<returns> long
// $<description> Get Revision Count for Sharps object.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2010-10-14 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Long ll_sharp_cnt,i,ll_sharp_revision_cnt,li_count
oleobject lole_sharp

ll_sharp_cnt = aole_document.Shapes.Count
For i = 1 To ll_sharp_cnt
	ll_sharp_revision_cnt = 0
	lole_sharp = aole_document.Shapes.Item(i)
	If lole_sharp.TextFrame.HasText Then
		ll_sharp_revision_cnt = Long(lole_sharp.TextFrame.TextRange.Revisions.Count)
		li_count += ll_sharp_revision_cnt	
	End If
Next

Return li_count
end function

public function integer of_accept_or_reject_sharp_revisions (oleobject aole_document, integer ai_type);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_dm_utils.of_accept_or_reject_sharp_revisions()
// $<arguments>
//		value	oleobject aole_document
//		value	integer	ai_type	1: Accept all; 0: Reject all	
// $<returns> integer
// $<description>
// $<description> Accept or Reject all revisions in Sharps object.
//////////////////////////////////////////////////////////////////////
// $<add> 2010-10-14 by Ken.Guo
//////////////////////////////////////////////////////////////////////


Long ll_sharp_cnt,i,li_count
oleobject lole_sharp

ll_sharp_cnt = aole_document.Shapes.Count
For i = 1 To ll_sharp_cnt
	lole_sharp = aole_document.Shapes.Item(i)
	If lole_sharp.TextFrame.HasText Then
		li_count = lole_sharp.TextFrame.TextRange.Revisions.Count 
		If li_count > 0 Then
			If ai_type = 1 Then
				lole_sharp.TextFrame.TextRange.Revisions.AcceptAll()
			Else
				lole_sharp.TextFrame.TextRange.Revisions.RejectAll()
			End If
		End If
	End If
Next

Return 1
end function

public function String of_gettempfilename (string as_keyname);//////////////////////////////////////////////////////////////////////
// Function: of_gettempfilename()
// Arguments:
// 	value    string    as_keyname
//--------------------------------------------------------------------
// Return:  String
//--------------------------------------------------------------------
// Author:	 Ken.Guo 2011-05-20.
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////

String ls_FileName,ls_FileName1,ls_filepath
Long i,ll_max

ll_max = 1000 //max try times.

ls_filepath = gs_dir_path + gs_DefDirName
gnv_appeondll.of_parsepath(ls_filepath)
IF NOT DirectoryExists(ls_filepath) THEN Return ""


For i = 1 To ll_max
	ls_FileName = ls_filepath + "\" + as_keyname + String(i) + ".doc"
	If FileExists(ls_filename) Then
		If Not FileDelete(ls_filename) Then
			If i = ll_max Then
				Messagebox('Delete Temporary File','Failed to delete the temporary file "Temp*.doc". ~r~nThis will cause your WindWord.exe process to be locked up.  Please open Windows Task Manager (Ctrl-Alt-Del to bring up option to open Task Manager).  Click on the Process tab and look for the WINWORD.exe process and right click on that entry and click End Process.',Exclamation!)
				Return ''
			End If
			Continue
		End If
	End If
	
	ls_FileName1 = ls_filepath + "\~~$" + as_keyname + String(i) + ".doc"	
	If FileExists(ls_filename1) Then
		If Not FileDelete(ls_filename1) Then
			If i = ll_max Then
				Messagebox('Delete Temporary File','Failed to delete the temporary file "Temp*.doc". ~r~nThis will cause your WindWord.exe process to be locked up.  Please open Windows Task Manager (Ctrl-Alt-Del to bring up option to open Task Manager).  Click on the Process tab and look for the WINWORD.exe process and right click on that entry and click End Process.',Exclamation!)
				Return ''
			End If
			Continue
		End If
	End If
	
	Return ls_FileName
	
Next

Return ''
end function

public function integer of_add_audit_trail (long al_doc_id[], string as_action);str_ctx_email lstr_ctx_email

Return of_add_audit_trail(al_doc_id[],lstr_ctx_email,as_action)

////////////////////////////////////////////////////////////////////////
//// Function: of_add_audit_trail()
//// Arguments:
//// 	value    long      al_doc_id[]
//// 	value    string    as_action
////--------------------------------------------------------------------
//// Return:  integer
////--------------------------------------------------------------------
//// Author:	 Ken.Guo 2011-06-13.
////--------------------------------------------------------------------
//// Description:
////Add audit trail based on attached document ids in email
////Added by Alfee 11.28.2007
////Added as_action argument By Ken.Guo 2011-05-30. 
////--------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////
//Long ll_cnt, i, ll_max_audit_id, ll_row, ll_doc_id
//DataStore lds_audit_trail, lds_document
//
//ll_cnt = UpperBound(al_doc_id)
//IF ll_cnt < 1 THEN RETURN 0
//
//lds_audit_trail = Create DataStore
//lds_audit_trail.DataObject = 'd_dm_doc_audit_browse'
//lds_audit_trail.SetTransObject(SQLCA)
//
//lds_document = Create DataStore
//lds_document.DataObject = 'd_dm_doc_audit_info'
//lds_document.SetTransObject(SQLCA)
//
//ll_cnt = lds_document.Retrieve(al_doc_id)
//
//FOR i = 1 to ll_cnt
//	ll_row = lds_audit_trail.InsertRow(0)
//	ll_max_audit_id = lds_document.GetItemNumber(i, "audit_id")
//	IF NOT ll_max_audit_id > 0 THEN ll_max_audit_id = 1	
//	lds_audit_trail.SetItem(ll_row, "doc_id", lds_document.GetItemNumber(i, "doc_id"))
//	lds_audit_trail.SetItem(ll_row, "audit_id", ll_max_audit_id)
//	lds_audit_trail.SetItem(ll_row, "revision", lds_document.GetItemDecimal(i, "revision"))
//	lds_audit_trail.SetItem(ll_row, "doc_ext", lds_document.GetItemString(i, "doc_ext"))
//	lds_audit_trail.SetItem(ll_row, "action", as_action) 
//	lds_audit_trail.SetItem(ll_row, "action_by", gs_user_id)
//	lds_audit_trail.SetItem(ll_row, "action_date", DateTime(Today(), Now())	)
//NEXT
//
//lds_audit_trail.Update()
//
//Destroy lds_document
//Destroy lds_audit_trail
//
//IF SQLCA.SQLCODE = -1 THEN
//	MESSAGEBOX("Add document", "Add audit trail records failed due to "+ sqlca.sqlerrtext)
//	RETURN -1
//END IF
//
//IF Isvalid(gw_contract) THEN
//	If gw_contract.tab_contract_details.ib_select9 = True Then
//		ll_doc_id = gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.il_preview_doc_id
//		IF ll_doc_id > 0 THEN gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.dynamic event ue_refresh_audit(ll_doc_id)
//	End If
//END IF
//
//RETURN 1
//
end function

public function integer of_add_audit_trail (long al_doc_id[], str_ctx_email astr_sertifi, string as_action);
//////////////////////////////////////////////////////////////////////
// Function: of_add_audit_trail()
// Arguments:
// 	value    long				al_doc_id[]
//		value 	str_ctx_email	str_sertifi
// 	value    string			as_action
//--------------------------------------------------------------------
// Return:  integer
//--------------------------------------------------------------------
// Author:	 Ken.Guo 2011-06-13.
//--------------------------------------------------------------------
// Description:
//Add audit trail based on attached document ids in email
//Added by Alfee 11.28.2007
//Added as_action,str_sertifi argument By Ken.Guo 2011-06-13. 
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////
Long ll_cnt, i, ll_max_audit_id, ll_row, ll_doc_id
DataStore lds_audit_trail, lds_document

ll_cnt = UpperBound(al_doc_id)
IF ll_cnt < 1 THEN RETURN 0

lds_audit_trail = Create DataStore
lds_audit_trail.DataObject = 'd_dm_doc_audit_browse'
lds_audit_trail.SetTransObject(SQLCA)

lds_document = Create DataStore
lds_document.DataObject = 'd_dm_doc_audit_info'
lds_document.SetTransObject(SQLCA)

ll_cnt = lds_document.Retrieve(al_doc_id)

//---------Begin Added by (Appeon)Harry 07.08.2016 for Docusign--------
string ls_mode,ls_license_user_id
choose case gs_esigntype
	case 'docusign'
		ls_mode = gnv_user_option.of_get_option_value(gs_user_id, "docusign_license_mode" )
	case 'echosign'
		ls_mode = gnv_user_option.of_get_option_value(gs_user_id, "echosign_license_mode" )
	case 'sertifi'
		ls_mode = gnv_user_option.of_get_option_value(gs_user_id, "sertifi_license_mode" )
end choose
if isnull(ls_mode) or ls_mode = '' then ls_mode = "global_license"
if ls_mode = "global_license" then
	ls_license_user_id = "global_license_user"
else
	ls_license_user_id = gs_user_id
end if
//---------End Added ------------------------------------------------------

FOR i = 1 to ll_cnt
	ll_row = lds_audit_trail.InsertRow(0)
	ll_max_audit_id = lds_document.GetItemNumber(i, "audit_id")
	IF ll_max_audit_id = 0 or isnull(ll_max_audit_id) THEN ll_max_audit_id = 1	
	lds_audit_trail.SetItem(ll_row, "doc_id", lds_document.GetItemNumber(i, "doc_id"))
	lds_audit_trail.SetItem(ll_row, "audit_id", ll_max_audit_id)
	lds_audit_trail.SetItem(ll_row, "revision", lds_document.GetItemDecimal(i, "revision"))
	lds_audit_trail.SetItem(ll_row, "doc_ext", lds_document.GetItemString(i, "doc_ext"))
	lds_audit_trail.SetItem(ll_row, "action", as_action) 
	lds_audit_trail.SetItem(ll_row, "action_by", gs_user_id)
	lds_audit_trail.SetItem(ll_row, "action_date", DateTime(Today(), Now())	)
	If Len(astr_sertifi.as_sertifi_fileid) > 0 and UpperBound(astr_sertifi.as_sertifi_docid[]) = ll_cnt Then
		//Added By Jay Chen 10-22-2013 
		choose case gs_esigntype
			case 'sertifi'
				lds_audit_trail.SetItem(ll_row, "es_apicode", gnv_sertifi.is_apicode )		
			case 'echosign'
				lds_audit_trail.SetItem(ll_row, "es_apicode", gnv_echosign.is_apicode )		
			case 'docusign' // (Appeon)Harry 07.08.2016 - for docusign
				lds_audit_trail.SetItem(ll_row, "es_apicode", gnv_docusign.is_apicode )	
		end choose
		lds_audit_trail.SetItem(ll_row, "es_fileid", astr_sertifi.as_sertifi_fileid )
		lds_audit_trail.SetItem(ll_row, "es_docid", astr_sertifi.as_sertifi_docid[i] )
		lds_audit_trail.SetItem(ll_row, "es_sender", astr_sertifi.as_sender)
		lds_audit_trail.SetItem(ll_row, "es_sender_email", astr_sertifi.as_mail_from )
		lds_audit_trail.SetItem(ll_row, "esign_type", gs_esigntype ) //Added By Jay Chen 10-18-2013
		lds_audit_trail.SetItem(ll_row, 'es_license_user_id',ls_license_user_id)  // (Appeon)Harry 07.08.2016 - for docusign
	End If
	lds_audit_trail.SetItem(ll_row, "approve_id", astr_sertifi.al_approve_id  )
NEXT

lds_audit_trail.Update()

Destroy lds_document
Destroy lds_audit_trail

IF SQLCA.SQLCODE = -1 THEN
	MESSAGEBOX("Add document", "Add audit trail records failed due to "+ sqlca.sqlerrtext)
	RETURN -1
END IF

IF Isvalid(gw_contract) THEN
	If gw_contract.tab_contract_details.ib_select9 = True Then
		ll_doc_id = gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.il_preview_doc_id
		IF ll_doc_id > 0 THEN gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.dynamic event ue_refresh_audit(ll_doc_id)
	End If
END IF

RETURN 1

end function

public function integer of_add_audit_trail (str_add_audit astr_add_audit[]);//////////////////////////////////////////////////////////////////////
// Function: of_add_audit_trail()
// Arguments:
// 	value    str_add_audit    astr_add_audit[]
//--------------------------------------------------------------------
// Return:  integer
//--------------------------------------------------------------------
// Author:	 Ken.Guo 2011-06-29.
//--------------------------------------------------------------------
// Description: Insert audit data
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////

Long ll_doc_arr[],ll_find_row
Long ll_cnt, i, ll_max_audit_id, ll_row, ll_doc_id
DataStore lds_audit_trail, lds_document

ll_cnt = UpperBound(astr_add_audit[])
IF ll_cnt < 1 THEN RETURN 0
For i = 1 To ll_cnt
	ll_doc_arr[i] = astr_add_audit[i].doc_id
Next

lds_audit_trail = Create DataStore
lds_audit_trail.DataObject = 'd_dm_doc_audit_browse'
lds_audit_trail.SetTransObject(SQLCA)

lds_document = Create DataStore
lds_document.DataObject = 'd_dm_doc_audit_info'
lds_document.SetTransObject(SQLCA)

ll_cnt = lds_document.Retrieve(ll_doc_arr[])

FOR i = 1 to UpperBound(astr_add_audit[])
	ll_row = lds_audit_trail.InsertRow(0)
	ll_find_row = lds_document.Find('doc_id = ' + String(astr_add_audit[i].doc_id),1,lds_document.rowcount()  )
	If ll_find_row <= 0 Then Continue
	
	ll_max_audit_id = lds_document.GetItemNumber(ll_find_row, "audit_id")
	IF ll_max_audit_id = 0 or isnull(ll_max_audit_id) THEN ll_max_audit_id = 1	
	lds_audit_trail.SetItem(ll_row, "audit_id", ll_max_audit_id)	
	lds_audit_trail.SetItem(ll_row, "doc_id", astr_add_audit[i].doc_id )
	lds_audit_trail.SetItem(ll_row, "revision", astr_add_audit[i].revision )
	lds_audit_trail.SetItem(ll_row, "doc_ext", astr_add_audit[i].doc_ext)
	lds_audit_trail.SetItem(ll_row, "action",  astr_add_audit[i].action) 
	lds_audit_trail.SetItem(ll_row, "filename",  astr_add_audit[i].filename) 
	lds_audit_trail.SetItem(ll_row, "doc_from_type",  astr_add_audit[i].doc_from_type) 
	lds_audit_trail.SetItem(ll_row, "doc_from_name",  astr_add_audit[i].doc_from_name) 
	lds_audit_trail.SetItem(ll_row, "notes",  astr_add_audit[i].notes) 
	lds_audit_trail.SetItem(ll_row, "action_by", gs_user_id)
	lds_audit_trail.SetItem(ll_row, "action_date", DateTime(Today(), Now())	)
	
	lds_audit_trail.SetItem(ll_row, "es_apicode", astr_add_audit[i].astr_sertifi_doc.as_es_apicode )		
	lds_audit_trail.SetItem(ll_row, "es_fileid", astr_add_audit[i].astr_sertifi_doc.as_es_fileid)
	lds_audit_trail.SetItem(ll_row, "es_docid", astr_add_audit[i].astr_sertifi_doc.as_es_docid )
	lds_audit_trail.SetItem(ll_row, "es_sender", astr_add_audit[i].astr_sertifi_doc.as_es_sender)
	lds_audit_trail.SetItem(ll_row, "es_sender_email", astr_add_audit[i].astr_sertifi_doc.as_es_email )
	lds_audit_trail.SetItem(ll_row, "esign_type", gs_esigntype ) //Added By Jay Chen 10-22-2013
	lds_audit_trail.SetItem(ll_row, "approve_id",astr_add_audit[i].approve_id)
	
	lds_document.SetItem(ll_find_row, "audit_id",ll_max_audit_id )
NEXT

lds_audit_trail.Update()

Destroy lds_document
Destroy lds_audit_trail

IF SQLCA.SQLCODE = -1 THEN
	MESSAGEBOX("Add document", "Add audit trail records failed due to "+ sqlca.sqlerrtext)
	RETURN -1
END IF

IF Isvalid(gw_contract) THEN
	If gw_contract.tab_contract_details.ib_select9 = True Then
		ll_doc_id = gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.il_preview_doc_id
		IF ll_doc_id > 0 THEN gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.dynamic event ue_refresh_audit(ll_doc_id)
	End If
END IF

RETURN 1



/*
Long ll_max_audit_id

IF Isnull(astr_add_audit[i].doc_id) OR astr_add_audit[i].doc_id = 0 THEN RETURN -1

Select Max(audit_id)
Into :ll_max_audit_id
From Ctx_am_doc_audit
Where doc_id = :astr_add_audit[i].doc_id;

IF Isnull(ll_max_audit_id) OR ll_max_audit_id = 0 THEN
	ll_max_audit_id = 1
ELSE
	ll_max_audit_id ++
END IF

Insert Into Ctx_am_doc_audit (doc_id, audit_id, revision, action, 
action_by, action_date,	filename, doc_from_type, doc_from_name, notes, doc_ext,
es_apicode, es_fileid,es_docid,es_sender,es_sender_email)
Values (:astr_add_audit[i].doc_id, :ll_max_audit_id, :astr_add_audit[i].revision, :astr_add_audit[i].action, 
:gs_user_id, getdate(), :astr_add_audit[i].filename, :astr_add_audit[i].doc_from_type, 
:astr_add_audit[i].doc_from_name, :astr_add_audit[i].notes, :astr_add_audit[i].doc_ext,
:astr_add_audit[i].astr_sertifi_doc.as_es_apicode,:astr_add_audit[i].astr_sertifi_doc.as_es_fileid,:astr_add_audit[i].astr_sertifi_doc.as_es_docid,
:astr_add_audit[i].astr_sertifi_doc.as_es_sender,:astr_add_audit[i].astr_sertifi_doc.as_es_email );

IF SQLCA.SQLCODE = 0 THEN
	COMMIT;
ELSE
	MESSAGEBOX("Add document", sqlca.sqlerrtext)
	RETURN -1
END IF

IF Isvalid(gw_contract) THEN
	gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.dynamic event ue_refresh_audit(astr_add_audit[i].doc_id)
END IF
*/
RETURN 1

end function

public function string of_merge_file_name (long al_doc_id, decimal adec_revision, string as_doc_name, string as_doc_ext, integer ai_type);//Added By Ken.Guo 12/09/2011. 
String ls_doc_name

Choose Case ai_type
	Case 0 //Short Name
		ls_doc_name = as_doc_name + '.' + as_doc_ext
	Case 1 //Use Settings
		If gnv_data.of_getitem( 'icred_settings','doc_name_format', False) = '1' Then 
			ls_doc_name = as_doc_name + ' ' + String(al_doc_id) + '.' + String(adec_revision,'##0.0') + '.' + as_doc_ext
		Else
			ls_doc_name = as_doc_name + '.' + as_doc_ext
		End If	
	Case 2 //Long Name
		ls_doc_name = as_doc_name + ' ' + String(al_doc_id) + '.' + String(adec_revision,'##0.0') + '.' + as_doc_ext
End Choose

Return ls_doc_name
end function

public function integer of_get_clause_rule_reuslts (long al_ctx_id, long al_template_id, datastore ads_results, boolean ab_ctx_find);//Added by Alfee 11.12.2007
Integer li_result
Long i, ll_cnt, ll_clause_id, ll_row, ll_find,ll_Find2
DataStore lds_rules, lds_clauses,lds_ctx_find
string ls_where , ls_Error='', ls_Return, ls_Sql='', ls_Clause=''

SetPointer(HourGlass!) //01.21.2008

lds_rules = Create DataStore
lds_clauses = Create DataStore
lds_rules.DataObject = 'd_dm_template_clause_rules'
lds_clauses.DataObject = 'd_dm_template_clause_rules'

lds_ctx_find = create datastore
lds_ctx_find.dataobject = 'ds_sys_dynamic_sql'
lds_ctx_find.SettransObject( sqlca )
lds_ctx_find.Retrieve( gs_session_id )

//------------------------------------------------------------------------
// 2.24.2016 RP added
gnv_data.of_retrieveIfNecessary("template_clause_rules", FALSE)
gnv_data.of_retrieveIfNecessary("clause", FALSE)
//------------------------------------------------------------------------

//Get distinct clauses with rules defined
gnv_data.of_get_data_from_cache('template_clause_rules', 'ctx_acp_template_id = ' + String(al_template_id), lds_clauses) 

FOR i = 1 TO lds_clauses.RowCount()
	IF i = 1 THEN 
		ll_clause_id = lds_clauses.GetItemNumber(i, "ctx_acp_clause_id")
	ELSEIF ll_clause_id = lds_clauses.GetItemNumber(i, "ctx_acp_clause_id") THEN
		lds_clauses.DeleteRow(i)
		i --
	ELSE
		ll_clause_id = lds_clauses.GetItemNumber(i, "ctx_acp_clause_id")		
	END IF
NEXT

//Get rules' result for each clause
ll_cnt = lds_clauses.RowCount()
FOR i = 1 to ll_cnt
	//Get rules for the clause

	ll_clause_id = lds_clauses.GetItemNumber(i, "ctx_acp_clause_id")
	
	if ab_ctx_find then
//		lds_rules.Reset()
//		gnv_data.of_get_data_from_cache('template_clause_rules', 'ctx_acp_template_id = ' + String(al_template_id) + ' and ctx_acp_clause_id = ' + String(ll_clause_id), lds_rules) 

		gnv_data.ids_template_clause_rules.SetFilter(  'ctx_acp_template_id = ' + String(al_template_id) + ' and ctx_acp_clause_id = ' + String(ll_clause_id) )
		gnv_data.ids_template_clause_rules.Filter( )
		
		ll_Find = lds_ctx_find.find( "id1 = '" + string( al_ctx_id ) + "' and id2= '" + string( al_template_id ) + "' and id3 = '" + string( ll_clause_id ) + "'" , 1, lds_ctx_find.rowcount( ) )
		If ll_Find <= 0 Then
			ll_find = lds_ctx_find.InsertRow( 0 )
		End If
		lds_ctx_find.SetItem( ll_find, 'sessionid', gs_session_id )
		lds_ctx_find.SetItem( ll_find, 'id1', string(al_ctx_id ) )
		lds_ctx_find.SetItem( ll_find, 'id2', string( al_template_id ) )
		lds_ctx_find.SetItem( ll_find, 'id3', string( ll_clause_id ) )
		lds_ctx_find.SetItem( ll_find, 'arg_numbers', 1 )

		//Get and store result to the clause's rules
		string ls_updatecol[]
//		li_result = f_ctx_find( al_ctx_id, lds_rules,ls_updatecol,'1',ls_where)//add params - jervis 09.14.2010 //modified by gavins  20120723
		gf_ctx_find_ds( al_ctx_id, gnv_data.ids_template_clause_rules,ls_updatecol,'1',ls_where, lds_ctx_find, ll_find )//modified by gavins 20120730
	Else
		li_result = 1 
	End If
	ll_row = ads_results.InsertRow(0)
	ads_results.SetItem(ll_row, "ctx_id", al_ctx_id)
	ads_results.SetItem(ll_row, "ctx_acp_template_id", al_template_id)
	ads_results.SetItem(ll_row, "ctx_acp_clause_id", ll_clause_id)
	ads_results.SetItem(ll_row, "rules_result", li_result)	
NEXT

if ab_ctx_find then//added by gavins 20120731

	gnv_data.ids_template_clause_rules.Setfilter( "" )
	gnv_data.ids_template_clause_rules.Filter( )
		
	If  lds_ctx_find.Update( ) <> 1 Then
		MessageBox( 'Tips', SQLCA.SQLErrText )
	End If
		
	DECLARE dynamicsql PROCEDURE FOR up_dynamic_sql
				  :gs_session_id;
				  
		EXECUTE dynamicsql;
		
	If SQLCA.SQLCode < 0 Then
		ls_Error = SQLCA.SQLErrText 
		If gnv_data.ids_clause.RowCount( ) = 0 Then
			gnv_data.of_Retrieve( "clause")
		End If
	End If
	
	CLOSE dynamicsql;
		
	lds_ctx_find.Retrieve( gs_session_id )
	
	For i = 1 To  ads_results.RowCount( )
		ll_clause_id = ads_results.GetItemNumber(i, "ctx_acp_clause_id")
		ll_Find = lds_ctx_find.find( "id1 = '" + string( al_ctx_id ) + "' and id2= '" + string( al_template_id ) + "' and id3 = '" + string( ll_clause_id ) + "'" , 1, lds_ctx_find.rowcount( ) )
		If ll_find > 0 Then
			ls_Return = lds_ctx_find.GetItemString( ll_Find, 'return_value1' )
			If ls_Return = 'error' Then
				ll_Find2 = gnv_data.ids_Clause.Find( "ctx_acp_clause_id=" + String ( ll_clause_id ) ,1, gnv_data.ids_Clause.RowCount( ) )
				ls_Sql = ls_Sql + "~r~n" + lds_ctx_find.GetItemString( ll_Find, 'sqlstring' )
				If ll_Find2 > 0 Then ls_Clause = ls_Clause + "~r~n" + gnv_data.ids_Clause.GetItemString( ll_Find2, 'clause_name' )
				ads_results.SetItem( i, "rules_result", 0 )
			Else
				ads_results.SetItem( i, "rules_result", integer( ls_Return ) )
			End If
		End If
	Next
	If Len( ls_Error ) > 0 Then
		IF IsValid(gnv_debug)THEN gnv_debug.of_output( true,  ls_Clause + "~r~n" +  ls_sql  +  ls_Error    )
		MessageBox( 'Tips' ,'Failed to execute rules of clause ( clause:' + ls_Clause + "~r~nsql:" +  ls_sql + "~r~n" + ls_Error + ")" , Exclamation!)
	End If
End If



If IsValid(lds_ctx_find) Then Destroy lds_ctx_find 
If IsValid(lds_rules) Then Destroy lds_rules 
If IsValid(lds_clauses) Then Destroy lds_clauses

RETURN 1

end function

public function integer of_download_picture (long al_pic_id, ref string as_file);//====================================================================
// Function: of_download_picture
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                al_pic_id
//                as_file
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:         Ken.Guo           Date: 03/18/2013
//--------------------------------------------------------------------
//Copyright (c) 2008-2013 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


Blob  lb_image_data
Long ll_data_length,ll_ret
Integer li_counter, li_loops, li_MaxPosition, li_Position
Integer li_SetStep, li_NewStep, li_loopsR, li_rtn
Long ll_start, ll_find
String ls_title,ls_regstr,ls_lastupdate,ls_regupdate,ls_file_ext, ls_file_fullname
Boolean lb_needrestore = FALSE
Blob lb_data, lb_all_data
Datetime ldt_modify_date

// Get last modify date
//SELECT last_modified, file_ext ,Datalength(file_image)
//INTO :ldt_modify_date, :ls_file_ext, :ll_data_length
//FROM ctx_pictures
//WHERE id = :al_pic_id;

//----------------------2.25.2016 RP added to implement just-in-time cache--------------------
gnv_data.of_retrieveIfNecessary("ctx_pictures", FALSE)
//------------------------------------------------------------------------------------------------------

ll_find = gnv_data.ids_pictures.Find('id = ' + String(al_pic_id), 1, gnv_data.ids_pictures.RowCount())
If ll_find > 0 Then
	ldt_modify_date = gnv_data.ids_pictures.GetItemDateTime(ll_find, 'last_modified')
	ls_file_ext = gnv_data.ids_pictures.GetItemString(ll_find, 'file_ext')
Else
	//----------------------2.25.2016 RP added to implement just-in-time cache--------------------
	gnv_data.of_retrieveIfNecessary("ctx_pictures", TRUE)
	//gnv_data.of_retrieve('ctx_pictures')
	//------------------------------------------------------------------------------------------------------
	ll_find = gnv_data.ids_pictures.Find('id = ' + String(al_pic_id), 1, gnv_data.ids_pictures.RowCount())
	If ll_find > 0 Then
		ldt_modify_date = gnv_data.ids_pictures.GetItemDateTime(ll_find, 'last_modified')
		ls_file_ext = gnv_data.ids_pictures.GetItemString(ll_find, 'file_ext')	
	End If
End If

If ll_find <= 0 Then
	//Messagebox('Download Picture','Failed to download the picture ('+String(al_pic_id)+'). ~r~n~r~nBecause the picture does not exist in Picture Painter.',Exclamation!)
	gnv_Status_Info.of_display( 'Error 1. Failed to download the picture (ID = '+String(al_pic_id)+').' , '1')
	gnv_debug.of_output(True, 'Failed to download the picture ( '+String(al_pic_id)+'). ~r~n~r~nBecause the picture does not exist in Picture Painter.')
	Return -1
End If

//Gen file name
 gnv_appeondll.of_parsepath(gs_dir_path + gs_DefDirName + "\Pictures\") 
 ls_file_fullname = gs_dir_path + gs_DefDirName + "\Pictures\pic_" + String(al_pic_id) + '.' + ls_file_ext

//Return the cache file if it is exist. 
ls_regstr = "pic_" + String(al_pic_id) 
ls_lastupdate = String(ldt_modify_date, "mm/dd/yyyy hh:mm:ss")
gnv_appeondll.of_registryget("HKEY_LOCAL_MACHINE\SOFTWARE\"+gs_DefDirName+"\Pictures", ls_regstr, regstring!, ls_regupdate)
If ls_regupdate = ls_lastupdate and ls_regupdate <> ''  Then
	If FileExists(ls_file_fullname) Then
		as_file = ls_file_fullname
		Return 1
	End If
End If

// Get file data from database
SetPointer(HourGlass!) 
IF appeongetclienttype() = 'PB' THEN

	SELECT Datalength(file_image)
	INTO  :ll_data_length
	FROM ctx_pictures
	WHERE id = :al_pic_id;

	IF SQLCA.SQLCODE = -1 THEN RETURN -1 

	IF ll_data_length = 0 OR Isnull(ll_data_length) THEN
		//Messagebox('Download Picture','Failed to download the picture ('+String(al_pic_id)+'). ~r~n~r~nBecause the picture content does not exist in database, please delete the picture (ID = '+String(al_pic_id)+') in the Picture Management and reupload the original file to database.',Exclamation!)
		gnv_Status_Info.of_display( 'Error 2. Failed to download the picture (ID = '+String(al_pic_id)+').' , '1')
		gnv_debug.of_output(True,  'Failed to download the picture (ID ='+String(al_pic_id)+'). ~r~n~r~nBecause the picture content does not exist in database, please delete the picture (ID = '+String(al_pic_id)+') in the Picture Management and reupload the original file to database.')
		Return -1		
	END IF

	//Get length of the blob
	IF ll_data_length > 8000 THEN 
		 IF Mod(ll_data_length,8000) = 0 THEN 
			  li_loops = ll_data_length/8000 
		 ELSE 
			  li_loops = (ll_data_length/8000) + 1 
		 END IF 
	ELSE 
		 li_loops = 1 
	END IF 

	//Get and store the blob
	li_rtn = 1
	FOR li_counter = 1 to li_loops
		ll_start = (li_counter - 1) * 8000 + 1
		SELECTBLOB substring(file_image,:ll_start,8000)
				INTO :lb_data
				FROM ctx_pictures
				WHERE id = :al_pic_id;
				
		IF SQLCA.SQLCODE = -1 THEN 
			li_rtn = -1
			EXIT
		END IF
		lb_all_data += lb_data
	NEXT 

	//Store the blob
	lb_image_data = lb_all_data
ELSE
	SELECTBLOB file_image
	INTO :lb_image_data
	FROM ctx_pictures
	WHERE id = :al_pic_id;

	If Len(lb_image_data) = 0 or  isnull(lb_image_data) Then
		//Messagebox('Download Picture','Failed to download the picture ('+String(al_pic_id)+'). ~r~n~r~nBecause the picture content does not exist in database, please delete the picture (ID = '+String(al_pic_id)+') in the Picture Painter and reupload the original file to database.',Exclamation!)
		gnv_Status_Info.of_display( 'Error 3. Failed to download the picture (ID = '+String(al_pic_id)+').' , '1')
		gnv_debug.of_output(True,  'Failed to download the picture ('+String(al_pic_id)+'). ~r~n~r~nBecause the picture content does not exist in database, please delete the picture (ID = '+String(al_pic_id)+') in the Picture Painter and reupload the original file to database.')
		Return -2
	End If		
	
	IF SQLCA.SQLCODE = -1 THEN 
		gnv_Status_Info.of_display( 'Error 4. Failed to download the picture (ID = '+String(al_pic_id)+').' , '1')
		//MessageBox( "DownLoad Picture", "Download Picture ("+String(al_pic_id)+") failed! ~r~n" + SQLCA.SQLERRTEXT )
		gnv_debug.of_output(True,  "Download Picture ("+String(al_pic_id)+") failed! ~r~n" + SQLCA.SQLERRTEXT )
		Return -3
	END IF
END IF

// Save blob value to a local file.
If of_saveblob(ls_file_fullname, lb_image_data) > 0 Then
	gnv_appeondll.of_registryset("HKEY_LOCAL_MACHINE\SOFTWARE\"+gs_DefDirName+"\Pictures", ls_regstr, regstring!, ls_lastupdate)
Else
	gnv_Status_Info.of_display( 'Error 5. Failed to download the picture (ID = '+String(al_pic_id)+').' , '1')
	//MessageBox( "DownLoad Picture", "Download Picture ("+String(al_pic_id)+") failed!  Failed to write the file " +ls_file_fullname + "."  )
	gnv_debug.of_output(True,  "Download Picture ("+String(al_pic_id)+") failed!  Failed to write the file " +ls_file_fullname + "." )
	Return -4
End If

as_file = ls_file_fullname
Return 1


end function

on n_cst_dm_utils.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_dm_utils.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//by alfee at 03.19.2007
ids_doc_image = Create DataStore 
ids_doc_image.DataObject = 'd_dm_doc_image'
ids_doc_image.SetTransObject(Sqlca)
end event

event destructor;//by alfee at 03.19.2007
Destroy ids_doc_image 
end event

