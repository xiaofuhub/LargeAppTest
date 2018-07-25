$PBExportHeader$w_dm_checkin_document.srw
forward
global type w_dm_checkin_document from w_response
end type
type ole_1 from u_email_edit within w_dm_checkin_document
end type
type pb_help from picturebutton within w_dm_checkin_document
end type
type cbx_redline from checkbox within w_dm_checkin_document
end type
type cb_email from commandbutton within w_dm_checkin_document
end type
type cb_useupload from commandbutton within w_dm_checkin_document
end type
type cb_preview from commandbutton within w_dm_checkin_document
end type
type cb_4 from commandbutton within w_dm_checkin_document
end type
type cb_checkin from commandbutton within w_dm_checkin_document
end type
type cb_2 from commandbutton within w_dm_checkin_document
end type
type cb_1 from commandbutton within w_dm_checkin_document
end type
type dw_1 from u_dw within w_dm_checkin_document
end type
end forward

global type w_dm_checkin_document from w_response
integer x = 214
integer y = 221
integer width = 2341
integer height = 1056
string title = "Check In"
long backcolor = 33551856
ole_1 ole_1
pb_help pb_help
cbx_redline cbx_redline
cb_email cb_email
cb_useupload cb_useupload
cb_preview cb_preview
cb_4 cb_4
cb_checkin cb_checkin
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_dm_checkin_document w_dm_checkin_document

type variables
String is_filename,is_filename_org  //include path
Boolean ib_new
Long il_doc_id
Decimal idc_revision
Boolean ib_Revision_control
String is_doc_ext
Boolean ib_modified = TRUE
String is_checkout_status //Added by Ken.Guo on 2009-04-10
String is_checkin_type //1: local file,2: paste file,3: use uploaded file. Added by Ken.Guo on 2009-04-10
String is_docname //docname,not include version info
string is_operation	//Check in or Combine - jervis 04.23.2010
// WdSaveOptions
constant int wdDoNotSaveChanges = 0
constant int wdPromptToSaveChanges = -2
constant int wdSaveChanges = -1

constant long wdFormatDocument = 0 //10.31.2007
constant int wdCompareDestinationNew = 2 //jervis 04.23.2010
constant int wdGranularityWordLevel=1 //jervis 04.23.2010

int ii_version_Increment	//02.19.2009

//Added By Ken.Guo 2010-01-05.
String is_doc_from 
n_cst_clause inv_clause 

String is_filepathname //Added By Ken.Guo 2010-04-29.
n_cst_dm_utils inv_dm_utils

str_add_doc istr_add_doc
String		is_checkout_by	//Added By Mark Lee 05/21/12 remember checkout_by value
String is_esigntype
end variables

forward prototypes
public function boolean of_compare_doc ()
public function integer of_getblob_fromdb (long al_doc_id, decimal adc_revision, ref blob ab_image_data)
public function integer of_save_blob_to_file (string as_filename, blob ab_value)
public function integer of_get_from_fileservice ()
public function integer of_get_from_sertifi ()
public function integer of_check_protect_doc (string as_filename)
end prototypes

public function boolean of_compare_doc ();/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: Compare new document with previous document
**==================================================================================================================
**  Created By	: Davis 01.19.2007
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

String ls_original_doc_nme
String ls_compare_doc
n_cst_dm_utils lnv_dm_utils
Long li_count
Long ll_export_id, ll_ctx_id //alfee
String ls_merge_tmp_file, ls_file_tempname //alfee 
n_cst_ovole_utils lnv_ole_utils_doc
OleObject lole_word //10.31.2007
str_doc_info	lstr_docinfo	//jervis 02.25.2009
long li_Oricount //jervis 04.23.2010

long ll_sharp_cnt,ll_sharp_revision_cnt,i, ll_null
oleobject lole_sharp,lole_range

string ls_compare_combine 

SetPointer(HourGlass!)
setnull(ll_null) //Added By Ken.Guo 05/30/2013
//Added by Ken.Guo on 2008-11-06
If gnv_reg_ocx.of_check_ocx( 1,'', False) <> '' Then //1: office 
	Messagebox('Compare','Failed to compare new document.')
	Return True
End If

// Default value is modified
ib_modified = TRUE

ls_compare_doc = gs_dir_path + gs_DefDirName + "\Agreement\Manager\preview_compare.doc"
gnv_appeondll.of_parsepath(gs_dir_path + gs_DefDirName + "\Agreement\Manager")
// Check document type
//----------Begin Modified by Alfee 10.31.2007-----------------------------
//<$Reason>To support Word 2007
/* IF Lower(is_doc_ext) = "doc" AND Lower(Right(is_filename, 3)) = "doc" THEN
	OpenWithParm( w_appeon_gifofwait, "Comparing the document..." )
	TRY
		ole_1.object.openlocalfile(is_filename, true) 
*/
String ls_filename_convert
IF NOT FileExists(is_filename) THEN RETURN FALSE
IF Lower(is_doc_ext) = "doc" AND lnv_dm_utils.of_get_fileext(Lower(is_filename)) = "doc" THEN	
	cbx_redline.checked = True
	cbx_redline.enabled = True	
	if is_operation = "checkin" then
		OpenWithParm( w_appeon_gifofwait, "Comparing the document..." )
		ls_compare_combine = 'compare'
	else
		OpenWithParm( w_appeon_gifofwait, "Combining the document..." )
		ls_compare_combine = 'combine'
	end if
	//Begin - Added By Mark Lee 05/28/2013  -1 protected, 1 unprotected
	li_count = of_check_protect_doc(is_filename)
	IF li_count > 0  THEN  
	//End - Added By Mark Lee 05/28/2013
		TRY
			ls_filename_convert = lnv_dm_utils.of_convert_word_file_ext(is_filename)
			IF gs_word_version = 'word2007' THEN //Word 2007 don't support compare fun. under OLE mode
				lole_word = Create oleobject
				IF lole_word.Connecttonewobject("word.application") <> 0 THEN
					Messagebox('Client Error', 'Could not connect to Microsoft Word. Please make sure it is properly installed.')
					Destroy lole_word					
					RETURN FALSE
				END IF
				lole_word.Application.NormalTemplate.Saved = TRUE //Alfee 01.17.2008
				lole_word.Visible = FALSE
			ELSE
				lole_word = ole_1.Object
			END IF	
	//----------End Modified ---------------------------------------------------	
			IF IsValid(w_appeon_gifofwait) THEN w_appeon_gifofwait.hpb_1.StepIt() //Alfee 09.17.2007 
			
			IF il_doc_id > 0 THEN
				If is_doc_from = 'clause' Then 
					inv_clause.of_download_file(il_doc_id, idc_revision, ls_original_doc_nme)
				Else
					ls_original_doc_nme = lnv_dm_utils.of_download_file( il_doc_id, idc_revision)
				End If
				IF IsValid(w_appeon_gifofwait) THEN w_appeon_gifofwait.hpb_1.StepIt() //Alfee 09.17.2007 
	
				IF FileExists( ls_original_doc_nme ) THEN
					//------Begin add by alfee at 03.23.2007---------
					ls_file_tempname = gs_dir_path + gs_DefDirName + "\Agreement\Manager\compare_temp.doc"
					ls_merge_tmp_file = gs_dir_path + gs_DefDirName + "\Agreement\_merged_data.doc"
					FileCopy(ls_original_doc_nme, ls_merge_tmp_file,true)	
					IF IsValid(w_appeon_gifofwait) THEN w_appeon_gifofwait.hpb_1.StepIt() //Alfee 09.17.2007 
					FileCopy(ls_original_doc_nme, ls_file_tempname,true)				
					IF IsValid(w_appeon_gifofwait) THEN w_appeon_gifofwait.hpb_1.StepIt() //Alfee 09.17.2007 
					
					If is_doc_from = 'clause' Then 
						//Added By Ken.Guo 2010-01-05. for NF, check in for clause.
						ls_merge_tmp_file = ls_file_tempname
						lnv_ole_utils_doc = Create n_cst_ovole_utils
						lnv_ole_utils_doc.of_acceptall(ls_merge_tmp_file)		
						Destroy lnv_ole_utils_doc
					ElseIf is_doc_from = 'email_doc' Then //Added By Ken.Guo 2010-04-29.
						ls_merge_tmp_file = ls_file_tempname
						lnv_ole_utils_doc = Create n_cst_ovole_utils
						lnv_ole_utils_doc.of_acceptall(ls_merge_tmp_file)		
						Destroy lnv_ole_utils_doc					
					Else
						gnv_appeondb.of_startqueue( )	//jervis 02.25.2009
						Select ctx_acp_template.export_id Into :ll_export_id
						  From ctx_am_document,ctx_acp_template
						 Where ctx_am_document.doc_id = :il_doc_id
							And ctx_am_document.from_templete_id = ctx_acp_template.ctx_acp_template_id;
						//Add by jervis 02.25.22009
						select doc_name,create_date,create_by 
						into :lstr_docinfo.doc_name, :lstr_docinfo.ver_date,:lstr_docinfo.create_by
						from ctx_am_document
						where doc_id = :il_doc_id;
						gnv_appeondb.of_commitqueue( )	
						lstr_docinfo.ver_num = idc_revision
						//End by jervis 02.25.2009
						
						IF IsValid(w_appeon_gifofwait) THEN w_appeon_gifofwait.hpb_1.StepIt() //Alfee 09.17.2007 
						
						Choose Case Upper(is_doc_from)
							Case 'DM'
								If isvalid(gw_contract) Then
									lnv_ole_utils_doc	= gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.inv_ole_utils_doc
								Else
									Messagebox('Document','Failed to '+ls_compare_combine+' two documents.')	
								End If
							Case 'DM_BROWSE'
								If isvalid(w_documents_browse) Then
									lnv_ole_utils_doc	= w_documents_browse.uo_1.inv_ole_utils_doc
								Else
									Messagebox('Document','Failed to '+ls_compare_combine+' two documents.')	
								End If
						End Choose
						
						IF ll_export_id > 0 THEN
							If isvalid(gw_contract) Then
								ll_ctx_id = gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.inv_contract_details.of_get_ctx_id()
							End IF										
							//lnv_ole_utils_doc.of_mergedata_auto(ll_export_id, ll_ctx_id,ls_file_tempname,ls_merge_tmp_file,true)
							lnv_ole_utils_doc.of_mergedata_auto(ll_export_id, ll_ctx_id,ls_file_tempname,ls_merge_tmp_file,false,lstr_docinfo)	//modify by jervis 02.25.2009
							IF IsValid(w_appeon_gifofwait) THEN w_appeon_gifofwait.hpb_1.StepIt() //Alfee 09.17.2007 					
							
							lnv_ole_utils_doc.of_autonumbering(ls_merge_tmp_file) //alfee 04.30.2007
							IF IsValid(w_appeon_gifofwait) THEN w_appeon_gifofwait.hpb_1.StepIt() //Alfee 09.17.2007 					
							
							IF isvalid(w_export_progress) THEN CLOSE(w_export_progress)
						End If
						if is_operation = "checkin" then	//Don't accept revisions when operation is combine - jervis 04.23.2010
							//Accept all revisions in target document - Moved here - Alfee 06.20.2008
							lnv_ole_utils_doc.of_acceptall(ls_merge_tmp_file)	
						end if 
					End If
					//--------------------------- APPEON BEGIN ---------------------------
					//$<add> 04/25/2007 By: Ken.Guo
					//$<reason> Accept all revisions in two document before compare.
					
					//--------Begin Modified by Alfee 10.31.2007--------------------
					
	
					
					//Open and Accept all revisions in current document
					IF gs_word_version = 'word2007' THEN //It's different for the source and targer file in Word 2007
						//lole_word.Application.Documents.Open(ls_filename_convert, False, True)
						lole_word.Application.Documents.Open(ls_merge_tmp_file, False, True)	//Alfee 06.20.2008
						gnv_word_utility.of_modify_word_property( lole_word.Activedocument)	//Added By Mark Lee 06/20/2013 change for office 2013.
						gnv_shell.of_delete_recent( ls_merge_tmp_file, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
					ELSE
						ole_1.object.OpenLocalFile(ls_filename_convert, TRUE)
						gnv_word_utility.of_modify_word_property( ole_1.object.ActiveDocument)	//Added By Mark Lee 06/20/2013 change for office 2013.
					END IF
	
					if is_operation = "checkin" then	//Don't accept revisions when operation is combine - jervis 04.23.2010
						//lole_word.ActiveDocument.Revisions.AcceptAll()
						lole_word.ActiveDocument.AcceptAllRevisions() //Modified By Ken.Guo 2010-10-14
	
						//ole_1.object.ActiveDocument.Revisions.AcceptAll()
						//--------End Modified -----------------------------------------	
					end if
					
					//Accept all revisions in target document
					//lnv_ole_utils_doc.of_acceptall(ls_merge_tmp_file) - Commented by Alfee 06.20.2008
					SetPointer(HourGlass!)
					IF IsValid(w_appeon_gifofwait) THEN w_appeon_gifofwait.hpb_1.StepIt() //Alfee 09.17.2007 					
					//---------------------------- APPEON END ----------------------------
					
					//--------Begin Modified by Alfee 10.31.2007--------------------
					//--------Begin Modified by Alfee 06.20.2008----------------
					If gs_word_version = 'word2007' Then 
						if is_operation = "checkin" then
							lole_word.ActiveDocument.Compare( ls_filename_convert, "External", 1, True, True, False )	
							gnv_shell.of_delete_recent( ls_filename_convert, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
						elseif is_operation = 'combine' then	//jervis 04.29.2010
							lole_word.ActiveWindow.Visible = False
							lole_word.Application.Documents.Open(ls_filename_convert, False, True)
							gnv_word_utility.of_modify_word_property( lole_word.Activedocument)	//Added By Mark Lee 06/20/2013 change for office 2013.
							gnv_shell.of_delete_recent( ls_filename_convert, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
							//MessageBox("",string(lole_word.Application.Documents.item[1].name))
							Yield ( ) //(Appeon)Harry 03.07.2014 - for Bug # 3904
							lole_word.Application.MergeDocuments(lole_word.Application.Documents.item[2],lole_word.Application.Documents.item[1])
							post garbagecollect()  //(Appeon)Harry 03.07.2014 - for Bug # 3904
							/*
							 Application.MergeDocuments OriginalDocument:=Documents("Original.docx"), _
								  RevisedDocument:=Documents("User1.docx"), Destination:= _
								  wdCompareDestinationNew, Granularity:=wdGranularityWordLevel, _
								  CompareFormatting:=True, CompareCaseChanges:=True, CompareWhitespace:= _
								  True, CompareTables:=True, CompareHeaders:=True, CompareFootnotes:=True, _
								  CompareTextboxes:=True, CompareFields:=True, CompareComments:=True, _
								  CompareMoves:=True, OriginalAuthor:="MASTER", RevisedAuthor:="MASTER", _
								  FormatFrom:=wdMergeFormatFromRevised
							*/					
						end if
							
					ElseIf gs_word_version = 'word2003' or gs_word_version = 'wordxp' Then
					//If gs_word_version = 'word2007' or gs_word_version = 'word2003' or gs_word_version = 'wordxp' Then
					//--------End Modified -------------------------------------
						lole_word.ActiveDocument.Compare( ls_merge_tmp_file, "External", 1, True, True, False )	
					Else
						f_set_doc_author('External')
						lole_word.ActiveDocument.Compare( ls_merge_tmp_file)
						f_set_doc_author(gs_user_id)
					End If
					gnv_shell.of_delete_recent( ls_merge_tmp_file, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
					/* If gs_word_version = 'word2003' or gs_word_version = 'wordxp' Then
						ole_1.object.ActiveDocument.Compare( ls_merge_tmp_file, "External", 1, True, True, False )	
					Else
						f_set_doc_author('External')
						ole_1.object.ActiveDocument.Compare( ls_merge_tmp_file)
						f_set_doc_author(gs_user_id)
					End If
					*/
					//--------End Modified -----------------------------------------
					
					SetPointer(HourGlass!)
					IF IsValid(w_appeon_gifofwait) THEN w_appeon_gifofwait.hpb_1.StepIt()  
									
					// Check revision changed of new document
					//li_count = Long(ole_1.object.ActiveDocument.Revisions.Count)
					li_count = Long(lole_word.ActiveDocument.Revisions.Count) //10.31.2007
					
					//Begin - Added By Ken.Guo 2010-10-14. Check revision for sharps object.
					li_count += inv_dm_utils.of_get_sharps_revision_count( lole_word.ActiveDocument )
	//				//End - Added By Ken.Guo 2010-10-14.
	
					ib_modified = li_count > 0
				
					IF dw_1.Rowcount( ) > 0 THEN
						dw_1.SetItem( 1, "modify_count", li_count)
					Else
						dw_1.SetItem( 1, "modify_count", ll_null) //Added By Ken.Guo 05/30/2013
					END IF
					
					//--------Begin Modified by Alfee 10.31.2007----------------
					//ole_1.object.SaveToLocal(ls_compare_doc,true)
					IF FileExists(ls_compare_doc) THEN FileDelete(ls_compare_doc)
					lole_word.ActiveDocument.SaveAs(ls_compare_doc, wdFormatDocument,false,'',false)
					gnv_shell.of_delete_recent( ls_compare_doc, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
					//--------End Modified --------------------------------------
					
					IF IsValid(w_appeon_gifofwait) THEN w_appeon_gifofwait.hpb_1.StepIt()
					
					IF FileExists(ls_compare_doc) THEN
						is_filename = ls_compare_doc
					END IF
					
					// Close current document
					//--------Begin Modified by Alfee 10.31.2007----------------
					IF gs_word_version = 'word2007' THEN
						lole_word.ActiveDocument.Close() 					
						lole_word.Quit(0)
						Destroy lole_word
					ELSE
						ole_1.object.close()
					END IF
					//ole_1.object.close()
					//--------End Modified --------------------------------------
					IF IsValid(w_appeon_gifofwait) THEN w_appeon_gifofwait.hpb_1.StepIt() 
				Else
					Messagebox('Document','Failed to download file to '+ls_compare_combine+', please call support.') //Added By Ken.Guo 2010-01-05.
				END IF
			END IF
		CATCH (runtimeerror rte)
			IF Isvalid( w_appeon_gifofwait) THEN CLOSE(w_appeon_gifofwait)
			//-------Begin Added by Alfee 01.17.2008 -----------
			IF ole_1.object.doctype = 1 THEN ole_1.object.Close()
			f_word_destroy(lole_word, "")
			//-------End Added ----------------------------------
			Messagebox('Document','Failed to '+ls_compare_combine+' two documents.')	
		END TRY
	Else
		//Added By Mark Lee 05/28/2013
		IF ls_compare_combine = 'combine' Then 
			Messagebox('Document', 'You cannot combine  the document because document protection is in effect.')
			RETURN FALSE
		End IF 
		cbx_redline.checked = False
		cbx_redline.enabled = False //Added By Ken.Guo 05/30/2013
		dw_1.SetItem( 1, "modify_count", ll_null) //Added By Ken.Guo 05/30/2013
	End IF //Added By Mark Lee 05/28/2013	
	IF Isvalid( w_appeon_gifofwait) THEN CLOSE(w_appeon_gifofwait)
END IF

IF	ib_modified THEN
	dw_1.SetItem(1, "status", "Modified")
ELSE
	dw_1.SetItem(1, "status", "Not Modified")				
END IF

RETURN ib_modified
end function

public function integer of_getblob_fromdb (long al_doc_id, decimal adc_revision, ref blob ab_image_data);//////////////////////////////////////////////////////////////////////
// $<function>w_dm_checkin_documentof_getblob_fromdb()
// $<arguments>
//		value    	long   	al_doc_id    		
//		value    	decimal	adc_revision 		
//		reference	blob   	ab_image_data		
// $<returns> integer
// $<description> Get blob data from DB, 
// $<description> Only for PB and SQL Server 
//////////////////////////////////////////////////////////////////////
// $<add> 2009-04-13 by Ken.Guo
//////////////////////////////////////////////////////////////////////


Integer li_counter, li_loops, li_MaxPosition, li_Position
Integer li_SetStep, li_NewStep, li_loopsR, li_rtn
Long ll_start, ll_data_length
String ls_title
Boolean lb_needrestore = FALSE
Blob lb_data, lb_all_data

SetPointer(HourGlass!) 

// Get file data from database
SELECT Datalength(New_Image_file)
INTO :ll_data_length
FROM ctx_am_image_weblink
WHERE doc_id = :al_doc_id
AND revision = :adc_revision;

IF SQLCA.SQLCODE = -1 THEN 
	Return -1 
ElseIf SQLCA.SQLCODE = 100 Then
	Return -100
End If

IF ll_data_length = 0 OR Isnull(ll_data_length) THEN
	RETURN -2
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
	ll_start = (li_counter - 1) * 8000 + 1
	SELECTBLOB substring(New_Image_file,:ll_start,8000)
			INTO :lb_data
			FROM ctx_am_image_weblink
			WHERE doc_id = :al_doc_id
			AND revision = :adc_revision;
	IF SQLCA.SQLCODE = -1 THEN 
		li_rtn = -3
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
ab_image_data = lb_all_data

Return li_rtn


end function

public function integer of_save_blob_to_file (string as_filename, blob ab_value);//////////////////////////////////////////////////////////////////////
// $<function>w_dm_checkin_documentof_save_blob_file()
// $<arguments>
//		value	string	as_filename		
//		value	blob  	ab_value   		
// $<returns> integer
// $<description> Save blob value to file.
//////////////////////////////////////////////////////////////////////
// $<add> 2009-04-13 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Long ll_writelength, ll_readlength
string ls_save_path

if fileexists(as_filename) then 
	if not filedelete(as_FileName) then
		return -1
	end if
end if

SetPointer(HourGlass!) 

//Create DIR
ls_save_path = mid(as_FileName,1,lastpos(as_FileName,'\'))
gnv_appeondll.of_parsepath(ls_save_path)

//initilize variables
ll_readlength = Len(ab_value)

//Write blob into file
ll_writelength = AppeonWriteFile(as_FileName, ab_value, ll_readlength)
if ll_writelength < 0 then return -1

SetPointer(Arrow!)
return 1
end function

public function integer of_get_from_fileservice ();//////////////////////////////////////////////////////////////////////
// $<event>Cut from cb_useupload::clicked()
// $<arguments>(None)
// $<returns> long
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2009-04-10 by Ken.Guo
// Cuted By Ken.Guo 2011-06-13
//////////////////////////////////////////////////////////////////////

String ls_fullname
String ls_doc_name 
Blob  lb_image_data
Integer li_ret

//Get full-path file name
Select file_name 
Into :ls_doc_name 
From ctx_am_image_weblink
Where doc_id = :il_doc_id AND Revision = :idc_revision;
If ls_doc_name = '' or isnull(ls_doc_name) Then 
	ls_doc_name = is_docname
End If
ls_fullname = gs_dir_path + gs_DefDirName + "\Agreement\Weblink\" + ls_doc_name

// Get file data from database
IF appeongetclienttype() = 'PB' AND gs_dbtype = 'SQL' THEN
	li_ret = of_getblob_fromdb(il_doc_id, idc_revision, lb_image_data) 
	IF li_ret < 0 THEN				
		MessageBox( "DownLoad File "+ String(li_ret), "Failed to Download file, please call support." )		
		RETURN -1
	END IF
ELSE
	SELECTBLOB New_Image_file
	INTO :lb_image_data
	FROM ctx_am_image_weblink
	WHERE doc_id = :il_doc_id AND Revision = :idc_revision;

	IF SQLCA.SQLCODE = -1 THEN 
		MessageBox( "DownLoad File", "Download file failed! ~r~n" + SQLCA.SQLERRTEXT )
		Return -2
	END IF
END IF

// Save blob value to a local file.
li_ret = of_save_blob_to_file(ls_fullname, lb_image_data)
If li_ret < 0 Then
	Messagebox('Download File ' + String(li_ret) ,'Failed to save file.')
	Return -3
End If

is_checkin_type = '3' 
is_filename = ls_fullname
is_filename_org = ls_fullname
dw_1.SetItem( 1, "filename", ls_doc_name ) //Doc name include version info
cb_preview.Enabled = TRUE
cb_checkin.Enabled = TRUE
IF NOT ib_new THEN
	of_compare_doc( )
END IF

Return 1



end function

public function integer of_get_from_sertifi ();//////////////////////////////////////////////////////////////////////
// Function: of_get_from_sertifi()
// Arguments:
//--------------------------------------------------------------------
// Return:  integer
//--------------------------------------------------------------------
// Author:	 Ken.Guo 2011-06-13.
//--------------------------------------------------------------------
// Description: Download the file from Sertifi.
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////

String ls_fullname
String ls_doc_name 
Blob  lb_download
Integer li_ret

ls_doc_name = istr_add_doc.filename + '.pdf'

//Download the document from sertifi.
choose case gs_esigntype //Modified By Jay Chen 10-18-2013
	case 'sertifi'
		ls_fullname = gnv_sertifi.of_download_doc( istr_add_doc.astr_sertifi_doc )
	case 'echosign'
		ls_fullname = gnv_echosign.of_download_doc( istr_add_doc.astr_sertifi_doc )
	case 'docusign'   // (Appeon)Harry 07.11.2016 - for docusign
		ls_fullname = gnv_docusign.of_download_doc( istr_add_doc.astr_sertifi_doc )
end choose
If Not FileExists(ls_fullname) Then 
	Messagebox('Error','Failed to get the document from sertifi server.')
	Return -1
End If

//Other
is_checkin_type = '5' 
is_filename = ls_fullname
is_filename_org = ls_fullname
dw_1.SetItem( 1, "filename", ls_doc_name ) //Doc name include version info
cb_preview.Enabled = TRUE
cb_checkin.Enabled = TRUE
ib_modified = True
dw_1.SetItem(1, "status", "Modified")

Return 1
end function

public function integer of_check_protect_doc (string as_filename);//Added By Mark Lee 05/28/2013
Integer 				li_return
	
li_return = 0 
n_cst_word_utility 		ln_cst_word_utility
ln_cst_word_utility  = Create n_cst_word_utility
li_return = ln_cst_word_utility.of_unprotect_doc_file( as_filename)
Destroy ln_cst_word_utility

Return  li_return
end function

on w_dm_checkin_document.create
int iCurrent
call super::create
this.ole_1=create ole_1
this.pb_help=create pb_help
this.cbx_redline=create cbx_redline
this.cb_email=create cb_email
this.cb_useupload=create cb_useupload
this.cb_preview=create cb_preview
this.cb_4=create cb_4
this.cb_checkin=create cb_checkin
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ole_1
this.Control[iCurrent+2]=this.pb_help
this.Control[iCurrent+3]=this.cbx_redline
this.Control[iCurrent+4]=this.cb_email
this.Control[iCurrent+5]=this.cb_useupload
this.Control[iCurrent+6]=this.cb_preview
this.Control[iCurrent+7]=this.cb_4
this.Control[iCurrent+8]=this.cb_checkin
this.Control[iCurrent+9]=this.cb_2
this.Control[iCurrent+10]=this.cb_1
this.Control[iCurrent+11]=this.dw_1
end on

on w_dm_checkin_document.destroy
call super::destroy
destroy(this.ole_1)
destroy(this.pb_help)
destroy(this.cbx_redline)
destroy(this.cb_email)
destroy(this.cb_useupload)
destroy(this.cb_preview)
destroy(this.cb_4)
destroy(this.cb_checkin)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;call super::open;/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   For checkin document.
**==================================================================================================================
**  Created By	: Davis 01.11.2007
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


DatawindowChild ldw_child
Long ll_ctx_id
Datastore lds_email
String ls_doc_name,	ls_original_doc_nme
Integer		li_count
n_cst_dm_utils 				lnv_dm_utils					//Added By Mark Lee 05/28/2013
string ls_es_license_user_id  // (Appeon)Harry 07.11.2016 - for docusign

lds_email = Create DataStore
lds_email.Dataobject = 'd_em_match_document'
lds_email.SetTransObject(SQLCA)

IF NOT Isvalid( Message.PowerObjectparm ) THEN RETURN

inv_clause = Create n_cst_clause
istr_add_doc = Message.PowerObjectparm
ll_ctx_id = istr_add_doc.ctx_id
ib_new = istr_add_doc.new
il_doc_id = istr_add_doc.doc_id
idc_revision = istr_add_doc.revision
ib_Revision_control = istr_add_doc.Revision_control
is_doc_ext = istr_add_doc.doc_ext
is_checkout_status = istr_add_doc.checkout_status //Added by Ken.Guo on 2009-04-10
is_docname = istr_add_doc.filename //Added by Ken.Guo on 2009-04-13
is_doc_from = Lower(istr_add_doc.doc_from)
is_operation = lower(istr_add_doc.operation)	//jervis 04.23.2010
is_filepathname = istr_add_doc.filepathname //Added By Ken.Guo 2010-04-29.

//Added By Jay Chen 10-18-2013
//select esign_type into :is_esigntype from ctx_am_document where es_docid = :istr_add_doc.astr_sertifi_doc.as_es_docid;
select esign_type,es_license_user_id into :is_esigntype,:ls_es_license_user_id from ctx_am_document where es_docid = :istr_add_doc.astr_sertifi_doc.as_es_docid;  // (Appeon)Harry 07.11.2016 - for docusign
if isnull(is_esigntype) or is_esigntype = '' then is_esigntype = gs_esigntype

//Gen file name for email
ls_doc_name = gf_merge_file_name(istr_add_doc.filename,istr_add_doc.doc_ext ,istr_add_doc.doc_id , istr_add_doc.revision )
//Begin - Added By Mark Lee 05/28/2013
ls_original_doc_nme = ''
IF Lower(is_doc_ext) = "doc" or Lower(is_doc_ext) = 'docx' THEN	
	IF il_doc_id > 0 THEN
		If is_doc_from = 'clause' Then 
			inv_clause.of_download_file(il_doc_id, idc_revision, ls_original_doc_nme)
		Else
			ls_original_doc_nme = lnv_dm_utils.of_download_file( il_doc_id, idc_revision)
		End If
	Else
		ls_original_doc_nme = is_filepathname
	End IF 
End IF 
IF FileExists(ls_original_doc_nme) Then 
	IF not ib_new and is_operation <> 'checkin' Then 
		li_count = of_check_protect_doc(ls_original_doc_nme)
		IF li_count < 0 THen 
			MessageBox(gnv_app.iapp_object.DisplayName,"You cannot combine  the document ("+string(is_docname)+").~r~n Because document protection is in effect.")
			Close(this)
			RETURN
		End IF 
	End IF 
End IF 
//End - Added By Mark Lee 05/28/2013

dw_1.GetChild( "doc_from_name", ldw_child)
ldw_child.SetTransObject( SQLCA )

gnv_appeondb.of_startqueue( )
	ldw_child.Retrieve( ll_ctx_id )
	lds_email.Retrieve(istr_add_doc.doc_id, ls_doc_name)
	//Begin - Added By Mark Lee 05/21/12	remember checkout_by value
    If is_doc_from <> 'clause' Then
		Select checkout_by 
		Into 	:is_checkout_by 
		From  ctx_am_document 
		Where doc_id = :il_doc_id ;
	End If
	//End - Added By Mark Lee 05/21/12

gnv_appeondb.of_commitqueue( )

//Added By Ken.Guo 2010-04-30.
If lds_email.rowCount() = 0 Then cb_email.enabled = False
Destroy lds_email

ldw_child.insertrow( 1 )

dw_1.InsertRow( 0 )

IF ib_new THEN
	// First check in
	dw_1.SetItem(1, "status", "New")
	This.title = "Check In - New Document"
ELSE
	if is_operation = 'checkin' then
		IF f_validstr(istr_add_doc.filename) THEN
			This.title =  'Contract ' + String(ll_ctx_id) + " - Check In - " + istr_add_doc.filename
		END IF
	else
		IF f_validstr(istr_add_doc.filename) THEN
			This.title =  'Contract ' + String(ll_ctx_id) + " - Check In - " + istr_add_doc.filename
		END IF
		cb_checkin.text = "C&ombine"
	end if
END IF

//Version nunber increment control
//Icred_setting.set_57.
//0-	Turn off versioning control
//1-	Increment version Number each time document is Update(Default)
//2-	Increment Version Number on Check in /Out only
ii_version_Increment = of_get_app_setting("set_57","I")

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2009-04-10 By: Ken.Guo
//$<reason> Add status control
Choose Case is_checkout_status
	Case '2','3'
		cb_useupload.Enabled = False
	Case '4'
		cb_useupload.Enabled = True
	Case '0','1'
		cb_useupload.Visible = False
	Case '5' //Creat request by sertifi, but not signed
		cb_useupload.Visible = True
		cb_useupload.Enabled = False
		//cb_useupload.text = 'From Signed Doc'  
		//Added By Jay Chen 11-07-2013
		choose case is_esigntype
			case 'sertifi'
				cb_useupload.text = 'From Sertifi'  
			case 'echosign'
				cb_useupload.text = 'From Echosign'
			case 'docusign'   // (Appeon)Harry 07.11.2016 - for docusign
				cb_useupload.text = 'From Docusign' 
		end choose
	Case '6' //Creat request by sertifi, and signed
		cb_useupload.Visible = True
		cb_useupload.Enabled = True
		//cb_useupload.text = 'From Signed Doc'  
		//Added By Jay Chen 11-07-2013
		choose case is_esigntype
			case 'sertifi'
				cb_useupload.text = 'From Sertifi'  
			case 'echosign'
				cb_useupload.text = 'From Echosign'
			case 'docusign'   // (Appeon)Harry 07.11.2016 - for docusign
				cb_useupload.text = 'From Docusign' 
		end choose
	Case '7'
		cb_useupload.Enabled = False				
	Case Else
		cb_useupload.Visible = False
End Choose
//---------------------------- APPEON END ----------------------------

//Added By Ken.Guo 2010-01-05.
If is_doc_from = 'clause' Then
	cb_useupload.Visible = False
End If

If is_doc_from = 'email_doc' Then
	cb_useupload.Visible = False
	cb_1.enabled = False
	cb_2.enabled = False
	is_checkin_type = '1' //Added by Ken.Guo on 2009-04-10

	dw_1.SetItem( 1, "filename", is_docname )
	is_filename = is_filepathname
	is_filename_org = is_filepathname
	
	cb_preview.Enabled = TRUE
	cb_checkin.Enabled = TRUE
	
	This.of_compare_doc( )
	
	cb_preview.enabled = True
End If

If istr_add_doc.ab_sertifi_auto Then //From Sertifi Status Window.
	is_filename = is_filepathname
	is_filename_org = is_filepathname
	cb_checkin.enabled = True
	is_checkin_type = '5'
	dw_1.SetItem( 1, "filename", is_docname + '.pdf' )
	dw_1.SetItem(1, "status", "Modified")	
	cb_preview.Enabled = True
	cb_1.Enabled = False	
	cb_2.Enabled = False	
	cb_email.Enabled = False	
	cb_useupload.Enabled = False	
	cb_1.Enabled = False	
	ib_modified = True
	ib_new = False
	//Added By Jay Chen 10-18-2013
	choose case is_esigntype
		case 'sertifi'
			This.title = 'Check in document from Sertifi Server'
		case 'echosign'
			This.title = 'Check in document from Echosign Server'
		case 'docusign'   // (Appeon)Harry 07.11.2016 - for docusign
			This.title = 'Check in document (Document ID:' + string(il_doc_id) + ') from Docusign Server' 
	end choose
End If

//For Web Approve

If is_checkout_status = '7' and istr_add_doc.ab_approval Then
	is_filename = is_filepathname
	is_filename_org = is_filepathname
	cb_checkin.enabled = True
	is_checkin_type = '7'
	dw_1.SetItem( 1, "filename", is_docname )
	
	If istr_add_doc.ab_notmodified Then
		dw_1.SetItem(1, "status", "Not Modified")	
		ib_modified = False
		cbx_redline.checked = False
		cbx_redline.visible = False
		pb_help.visible = False		
	Else
		ib_modified = True
		If (Lower(is_doc_ext) = 'doc' or Lower(is_doc_ext) = 'docx' ) Then
			This.of_compare_doc( )
		Else
			dw_1.SetItem(1, "status", "Modified")	
			cbx_redline.checked = False
			cbx_redline.visible = False
			pb_help.visible = False			
		End If
	End If
	
	cb_preview.Enabled = True
	cb_1.Enabled = False	
	cb_2.Enabled = False	
	cb_email.Enabled = False	
	cb_useupload.Enabled = False	
	cb_1.Enabled = False	
	ib_new = False
	This.title = 'Check in document from Web Approval'	
End If

//Added By Ken 09/16/2011. 
//If (Lower(is_doc_ext) = 'doc' or Lower(is_doc_ext) = 'docx' ) and Not ib_new and is_operation = 'checkin' Then
If (Lower(is_doc_ext) = 'doc' or Lower(is_doc_ext) = 'docx' ) and Not ib_new  Then	//Added By Mark Lee 05/29/2013
	//
Else
	cbx_redline.visible = False
	pb_help.visible = False //Added By Ken.Guo 05/30/2013
End If


end event

event close;call super::close;If isvalid(inv_clause) Then Destroy inv_clause
end event

event activate;call super::activate;//Added By Ken.Guo 2011-11-30. Workaround Office OCX's bug
If isvalid(ole_1 ) Then
	ole_1.object.activate(true)
End If
end event

event resize;//Override Ancestor Script //Added By Ken.Guo 12/19/2011. 
end event

type ole_1 from u_email_edit within w_dm_checkin_document
boolean visible = false
integer x = 1024
integer y = 384
integer width = 704
integer height = 252
integer taborder = 60
string binarykey = "w_dm_checkin_document.win"
end type

type pb_help from picturebutton within w_dm_checkin_document
integer x = 1170
integer y = 864
integer width = 110
integer height = 96
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean originalsize = true
string picturename = "Help!"
alignment htextalign = left!
string powertiptext = "Help"
end type

event clicked;Messagebox('Help','For the purpose of comparison and redlining changes, if there are any existing tracked changes in one or both of the compared documents, they will be automatically accepted.')

end event

type cbx_redline from checkbox within w_dm_checkin_document
integer x = 32
integer y = 876
integer width = 1138
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Compare and Redline Changes in Document "
boolean checked = true
end type

type cb_email from commandbutton within w_dm_checkin_document
integer x = 1751
integer y = 240
integer width = 544
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "From &Email..."
end type

event clicked;
String ls_filepath,ls_filename

openwithparm(w_em_mail_select,istr_add_doc)

ls_filepath = Message.stringparm

If FileExists(ls_filepath) Then
	is_filename = ls_filepath
	is_filename_org = ls_filepath
	ls_filename = Mid(ls_filepath, lastpos(ls_filepath,'\') + 1, Len(ls_filepath))

	dw_1.SetItem( 1, "filename", ls_filename )

	cb_preview.Enabled = TRUE
	cb_checkin.Enabled = TRUE
	
	IF NOT ib_new THEN
		Parent.of_compare_doc( )
	END IF
END IF	
	

end event

type cb_useupload from commandbutton within w_dm_checkin_document
integer x = 1751
integer y = 348
integer width = 544
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "&Use Uploaded File"
end type

event clicked;Choose Case istr_add_doc.checkout_status
	Case '4' //From File Service
		of_get_from_fileservice()
	Case '6' //From Sertifi
		of_get_from_sertifi()
End Choose 

//Commented By Ken.Guo 2011-06-13
////////////////////////////////////////////////////////////////////////
//// $<event>cb_useupload::clicked()
//// $<arguments>(None)
//// $<returns> long
//// $<description>
//// $<description>
////////////////////////////////////////////////////////////////////////
//// $<add> 2009-04-10 by Ken.Guo
////////////////////////////////////////////////////////////////////////
//
//String ls_fullname
//String ls_doc_name 
//Blob  lb_image_data
//Integer li_ret
//
////Get full-path file name
//Select file_name 
//Into :ls_doc_name 
//From ctx_am_image_weblink
//Where doc_id = :il_doc_id AND Revision = :idc_revision;
//If ls_doc_name = '' or isnull(ls_doc_name) Then 
//	ls_doc_name = is_docname
//End If
//ls_fullname = gs_dir_path + gs_DefDirName + "\Agreement\Weblink\" + ls_doc_name
//
//// Get file data from database
//IF appeongetclienttype() = 'PB' AND gs_dbtype = 'SQL' THEN
//	li_ret = of_getblob_fromdb(il_doc_id, idc_revision, lb_image_data) 
//	IF li_ret < 0 THEN				
//		MessageBox( "DownLoad File "+ String(li_ret), "Failed to Download file, please call support." )		
//		RETURN -1
//	END IF
//ELSE
//	SELECTBLOB New_Image_file
//	INTO :lb_image_data
//	FROM ctx_am_image_weblink
//	WHERE doc_id = :il_doc_id AND Revision = :idc_revision;
//
//	IF SQLCA.SQLCODE = -1 THEN 
//		MessageBox( "DownLoad File", "Download file failed! ~r~n" + SQLCA.SQLERRTEXT )
//		Return -2
//	END IF
//END IF
//
//// Save blob value to a local file.
//li_ret = of_save_blob_to_file(ls_fullname, lb_image_data)
//If li_ret < 0 Then
//	Messagebox('Download File ' + String(li_ret) ,'Failed to save file.')
//	Return -3
//End If
//
//is_checkin_type = '3' 
//is_filename = ls_fullname
//dw_1.SetItem( 1, "filename", ls_doc_name ) //Doc name include version info
//cb_preview.Enabled = TRUE
//cb_checkin.Enabled = TRUE
//IF NOT ib_new THEN
//	Parent.of_compare_doc( )
//END IF
//
//Return 1
//
//
//
end event

type cb_preview from commandbutton within w_dm_checkin_document
integer x = 1751
integer y = 456
integer width = 544
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Pre&view"
end type

event clicked;
/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: Dispaly document with redlined document.
**==================================================================================================================
**  Created By	: Davis 01.11.2007
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

String ls_filename_extend
String ls_null
str_add_doc lstr_add_doc
n_cst_dm_utils lnvo_dm_utils

SetNull(ls_null)

IF FileExists( is_filename ) THEN
	// Get file extend name
	ls_filename_extend = Lower(lnvo_dm_utils.of_get_fileext( is_filename ))
	CHOOSE CASE ls_filename_extend
		CASE "doc"
			//Modified By Ken 09/16/2011
			If cbx_redline.checked Then
				lstr_add_doc.filename = is_filename
			Else
				lstr_add_doc.filename = is_filename_org
			End If
			
			OpenWithParm(w_dm_document_preview, lstr_add_doc)
			
		CASE "html","htm"
			//ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', is_filename , ls_Null, 4)   //Commented by (Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
			ShellExecuteA ( Handle( This ), "open", of_getbrowserversion( ), is_filename, ls_Null, 4) //(Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
		CASE ELSE
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 08.07.2007 By: Jervis
			//$<reason> Open the 'Open With' Dialog
			//ShellExecuteA ( Handle( This ), "open", is_filename , ls_Null, ls_Null, 4)
			if ShellExecuteA ( Handle( This ), "open", is_filename , ls_Null, ls_Null, 4) <= 32 then
				run("rundll32.exe shell32.dll,OpenAs_RunDLL " + is_filename)
			end if
			//--------------------------- APPEON END ---------------------------

	END CHOOSE
END IF

end event

type cb_4 from commandbutton within w_dm_checkin_document
integer x = 1751
integer y = 748
integer width = 544
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;close(parent)
end event

type cb_checkin from commandbutton within w_dm_checkin_document
integer x = 1751
integer y = 640
integer width = 544
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "C&heck In"
end type

event clicked;/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: For checkin document.
**==================================================================================================================
**  Created By	: Davis 01.11.2007
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

str_add_doc lstr_add_doc
n_cst_dm_utils lnv_dm_utils
Integer li_rtn
Datetime ldt_modify
Decimal ldec_new_revision
Decimal ldec_max_revision   //Added By Ken.Guo 2009-05-15
String ls_filename_extend, ls_filename,ls_filename_checkin
string ls_filename_extend_full
Datawindow ldw_null

//Added by alfee at 01.25.2007
u_tabpg_dm_data uo_document 

IF NOT dw_1.Rowcount( ) > 0 THEN RETURN

dw_1.AcceptText()

//Added By Ken 09/16/2011. 
//If (Lower(is_doc_ext) = 'doc' or Lower(is_doc_ext) = 'docx' ) and Not ib_new and is_operation = 'checkin' and cbx_redline.checked Then
If (Lower(is_doc_ext) = 'doc' or Lower(is_doc_ext) = 'docx' ) and Not ib_new and cbx_redline.checked Then			//Added By Mark Lee 05/29/2013
	ls_filename_checkin = is_filename
Else
	ls_filename_checkin = is_filename_org
End If

IF NOT f_validstr( ls_filename_checkin ) THEN
	MessageBox(Parent.title,"Please Select/Paste a file first.")
	RETURN
END IF

// Check in new document
IF ib_new THEN
	lstr_add_doc.filename = ls_filename_checkin	//dw_1.GetItemstring( 1, "filename")
	lstr_add_doc.doc_from_name = dw_1.GetItemstring( 1, "doc_from_name")
	lstr_add_doc.notes = dw_1.GetItemstring( 1, "notes")
	lstr_add_doc.status = dw_1.GetItemstring( 1, "status")
	
	CloseWithReturn(Parent, lstr_add_doc) 
ELSE
	IF is_operation = 'checkin' Then
		Openwithparm(w_appeon_gifofwait, "Checking in the document...")  //Alfee 09.17.2007	
	Elseif is_operation = 'combine' then
		Openwithparm(w_appeon_gifofwait, "Combining the document...")
	End If
	ldec_new_revision = idc_revision
	ls_filename_extend =  lnv_dm_utils.of_get_fileext( ls_filename_checkin )
	ls_filename_extend_full =  lnv_dm_utils.of_get_fileext( ls_filename_checkin,true )
	
	IF ib_Revision_control THEN
		//Start code by jervis 02.19.2009
		//Version nunber increment control
		//0-	Turn off versioning control
		//1-	Increment version Number each time document is Update(Default)
		//2-	Increment Version Number on Check in /Out only
		If is_doc_from = 'clause' Then //Added By Ken.Guo 2010-01-05.
			Select Max(Revision) Into :ldec_max_revision From ctx_acp_clause_image where clause_id = :il_doc_id;
		Else
			Select Max(Revision) Into :ldec_max_revision From Ctx_am_doc_image	Where Doc_id = :il_doc_id;   //Added By Ken.Guo 2009-05-15. Get newest revision.			
		End If

		if ii_version_Increment >0 then	
			IF ib_modified THEN
				// Increment revision number
				ldec_new_revision = lnv_dm_utils.of_newversion( ldec_max_revision )
			END IF
			
			IF ib_modified THEN
				// Insert new record of image to the DB
				If is_doc_from = 'clause' Then //Added By Ken.Guo 2010-01-05. NF, for check in clause
					Insert ctx_acp_clause_image(clause_id,revision,doc_type)
					Values (:il_doc_id, :ldec_new_revision,'doc');
				Else
					//Add doc_ext_full -- jervis 10.21.2009
					Insert Ctx_am_doc_image(Doc_id, Revision, doc_ext, modify_date,doc_ext_full)
					Values( :il_doc_id, :ldec_new_revision, :ls_filename_extend, getdate() ,:ls_filename_extend_full);
				End If
			END IF
		end if
		//End code by jervis 02.19.2009

		//Commit; --commented by Alfee 09.17.2007
		If sqlca.sqlcode <> 0 Then
			IF is_operation = 'checkin' Then
				Messagebox('Check In','Failed to check in the document, please call support.~r~n' + sqlca.sqlerrtext )
			Elseif is_operation = 'combine' then
				Messagebox('Combine','Failed to combine the document, please call support.~r~n' + sqlca.sqlerrtext )
			End If

			Return 
		End If

		IF IsValid(w_appeon_gifofwait) THEN w_appeon_gifofwait.Event Timer() //Alfee 09.17.2007
	END IF

	//gnv_appeondb.of_startqueue( ) --Commented by Alfee 09.14.2007 

	// Update document to the DB	
	IF ib_modified THEN 
		//----------Begin Modified by Alfee 09.14.2007-------------------------
		//<$Reason>For performance tuning
		//lnv_dm_utils.of_upload_file( il_doc_id, ldec_new_revision, ls_filename_checkin)	
		If is_doc_from = 'clause' Then //Added By Ken.Guo 2010-01-05. NF, for check in clause
			If inv_clause.of_upload_file( il_doc_id, ldec_new_revision, ls_filename_checkin,ldt_modify) < 0 Then
				IF IsValid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait) //Alfee 09.17.2007
				RETURN					
			End If
		Else
			IF lnv_dm_utils.of_upload_file( il_doc_id, ldec_new_revision, ls_filename_checkin) < 0 THEN 
				IF IsValid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait) //Alfee 09.17.2007
				RETURN		
			END IF	
		End If
		IF IsValid(w_appeon_gifofwait) THEN //Alfee 11.21.2007
			IF w_appeon_gifofwait.hpb_1.Position < 90 THEN w_appeon_gifofwait.hpb_1.Position = 90
		END IF

		If is_doc_from <> 'clause' Then //Added By Ken.Guo 2010-01-05. NF, for check in clause
			SELECT modify_date INTO :ldt_modify FROM Ctx_am_doc_image 
			 WHERE doc_id = :il_doc_id AND revision = :ldec_new_revision ;
		End If
		//----------End Modified -----------------------------------------------
	END IF
	
	//Move to here from top
	If is_doc_from = 'clause' Then //Added By Ken.Guo 2010-01-05. NF, for check in clause
		Update ctx_acp_clause 
		Set Revision = :ldec_new_revision,
				checkout_by = '', 
				checkout_date = null, 
				checkout_status = '0'
		Where ctx_acp_clause_id = :il_doc_id;	
	Else
		// Set check out status to record
		gnv_appeondb.of_startqueue( )
			Update Ctx_am_document
			Set Revision = :ldec_new_revision,
					checkout_by = '', 
					checkout_date = null, 
					checkout_status = '0',
					doc_ext = :ls_filename_extend
			Where doc_id = :il_doc_id;		
			Update ctx_am_image_approve_detail Set flag = 2 Where doc_id = :il_doc_id ;
			Update ctx_am_image_approve Set flag = 2 Where doc_id = :il_doc_id ;
			
			If is_checkin_type = '3' Then
				Update ctx_am_image_weblink
				Set flag = '1'
				Where doc_id = :il_doc_id AND Revision = :idc_revision;
			Else
				Update ctx_am_image_weblink
				Set flag = '-1'
				Where doc_id = :il_doc_id AND Revision = :idc_revision;		
			End If
			
		gnv_appeondb.of_commitqueue( )		
	End If	
	
	//update clause map table accordingly --Added by alfee at 01.25.2007
	If is_doc_from = 'email_doc' Then //Added By Ken.Guo 2010-04-29. for email_doc
		inv_dm_utils.of_update_clausemap(il_doc_id,idc_revision, ldec_new_revision, ldw_null, ls_filename_checkin)
		//Reset flag to Refresh Document Manager data after clause update.
		If Isvalid(gw_contract) Then
			If gw_contract.tab_contract_details.ib_select9 Then
				If gw_contract.tab_contract_details.selectedtab = 9 Then
					gw_contract.tab_contract_details.selecttab(1)
				End If
				gw_contract.tab_contract_details.ib_select9 = False
			End If
		End If			
	Else
		IF IsValid(gw_contract) and is_doc_from <> 'clause'  THEN	
			uo_document = gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data
			uo_document.of_updateclausemap(ls_filename_checkin,ldec_new_revision)
		END IF
	End If

	IF IsValid(w_appeon_gifofwait) THEN w_appeon_gifofwait.Event Timer() //Alfee 09.17.2007
	
	//----------Begin Added by Alfee 09.14.2007-------------------------
	//<$Reason>For performance tuning
	//Generate local file & Update registry date
	IF ib_modified AND Not IsNull(ldt_modify) THEN
		If is_doc_from = 'clause' Then //Added By Ken.Guo 2010-01-05. NF, for check in clause
			ls_filename = inv_clause.of_generate_name(il_doc_id,ldec_new_revision)
			IF FileExists(ls_filename_checkin) THEN li_rtn = FileCopy(ls_filename_checkin, ls_filename, TRUE) 
			IF li_rtn > 0 THEN 
				//gnv_appeondll.of_RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Agreement", 'clause_' + string(il_doc_id) + '.' + String(ldec_new_revision) , regstring!, String(ldt_modify,"mm/dd/yyyy hh:mm:ss"))	
				inv_clause.of_registry_set( il_doc_id, ldec_new_revision, ldt_modify)
			End If
		Else
			ls_filename = lnv_dm_utils.of_generate_tempname(il_doc_id, ldec_new_revision, ls_filename_extend)
			IF FileExists(ls_filename_checkin) THEN li_rtn = FileCopy(ls_filename_checkin, ls_filename, TRUE) 
			IF li_rtn > 0 THEN lnv_dm_utils.of_updateregistry(il_doc_id, ldec_new_revision, ls_filename_extend, ldt_modify)
		End If
	END IF
	//----------End Added -----------------------------------------------
	
	///////////////////////////////////////////////////////////////////////
	//// Trigger off audit trail
	///////////////////////////////////////////////////////////////////////
	str_add_audit lstr_add_audit

	lstr_add_audit.doc_id = il_doc_id
	lstr_add_audit.revision = ldec_new_revision
	lstr_add_audit.filename = ls_filename_checkin
	lstr_add_audit.doc_from_name = dw_1.object.doc_from_name[1]
	IF Isnumber(lstr_add_audit.doc_from_name) THEN
		lstr_add_audit.doc_from_type = "1"		// Contract contacts
	ELSE
		lstr_add_audit.doc_from_type = "2"		// System user
	END IF
	lstr_add_audit.notes = dw_1.object.notes[1]
	lstr_add_audit.doc_ext = ls_filename_extend

//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<add> 2009-04-13 By: Ken.Guo
//	//$<reason> Set flag for web link file
//	If is_doc_from <> 'clause' Then //from document manager
//		If is_checkin_type = '3' Then
//			Update ctx_am_image_weblink
//			Set flag = '1'
//			Where doc_id = :il_doc_id AND Revision = :idc_revision;
//		Else
//			Update ctx_am_image_weblink
//			Set flag = '-1'
//			Where doc_id = :il_doc_id AND Revision = :idc_revision;		
//		End If
//	End If
//	//---------------------------- APPEON END ----------------------------
	
	IF is_operation = 'checkin' then
		IF ib_modified THEN
			Choose Case is_checkin_type
				Case '5' 
					//Added By Jay Chen 10-18-2013
					choose case is_esigntype
						case 'sertifi'
							lstr_add_audit.action = "Check In - Signed From Sertifi"
						case 'echosign'
							lstr_add_audit.action = "Check In - Signed From Echosign"
					end choose
					//Begin - Added By Mark Lee 05/21/12  automatically complete after you check in document and complete the process in the to do list 
					UPDATE ctx_am_action_item
					SET action_status = (Select top 1 lookup_code  From code_lookup Where lookup_name = 'Contract Action Status' And code = 'Complete')
					where  doc_id = :il_doc_id
					and action_type = (Select top 1 lookup_code  from code_lookup Where lookup_name = 'Contract Action Type' And code = 'Doc-Esign-CheckIn')
					and ( action_status = (Select top 1 lookup_code  From code_lookup Where lookup_name = 'Contract Action Status' And code = 'Incomplete')
					or action_status = (Select top 1 lookup_code  From code_lookup Where lookup_name = 'Contract Action Status' And code = 'Signed') )
					and action_user = :is_checkout_by ; 
					//End - Added By Mark Lee 05/21/12
				Case '7','8'
					lstr_add_audit.action = "Check In - From Web Approve"
					//Begin - Added By Mark Lee 05/21/12  automatically complete after you check in document and complete the process in the to do list 
					UPDATE ctx_am_action_item
					SET action_status = (Select top 1 lookup_code  From code_lookup Where lookup_name = 'Contract Action Status' And code = 'Complete')
					where  doc_id = :il_doc_id
					and action_type = (Select top 1 lookup_code  from code_lookup Where lookup_name = 'Contract Action Type' And code = 'Doc-Approval-CheckIn')
					and ( action_status = (Select top 1 lookup_code  From code_lookup Where lookup_name = 'Contract Action Status' And code = 'Incomplete')
					or action_status = (Select top 1 lookup_code  From code_lookup Where lookup_name = 'Contract Action Status' And code = 'Submitted') )
					and action_user = :is_checkout_by ; 
					//End - Added By Mark Lee 05/21/12
				Case Else
				lstr_add_audit.action = "Check In - Modified"				
			End Choose
		ELSE
			lstr_add_audit.action = "Check In - Not Modified"
		END IF
	
	Elseif is_operation = 'combine' then
		IF ib_modified THEN
			lstr_add_audit.action = "Combine - Modified"
		ELSE
			lstr_add_audit.action = "Combine - Not Modified"
		END IF
	End if

	lstr_add_audit.astr_sertifi_doc = istr_add_doc.astr_sertifi_doc
	lstr_add_audit.approve_id = istr_add_doc.al_approveid
	If is_doc_from = 'clause' Then
		inv_clause.of_add_audit_trail(lstr_add_audit)
	Else
		lnv_dm_utils.of_add_audit_trail( lstr_add_audit )
	End If
	IF IsValid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait) //Alfee 09.17.2007

	CloseWithReturn(Parent, 1) 
END IF
end event

type cb_2 from commandbutton within w_dm_checkin_document
integer x = 1751
integer y = 132
integer width = 544
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Paste File"
end type

event clicked;/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: Copy from within there email and the when in the check in box if they could do a Paster in the document instead. 
**==================================================================================================================
**  Created By	: Davis 01.11.2007
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

String ls_filepath
String ls_filename
String ls_fullname

ls_filepath = gs_dir_path + gs_DefDirName + '\'// "c:\"//Modified By Ken.Guo 2010-06-21
ls_filename = SPACE(256)

n_cst_appeondll lnv_appeondll
IF lnv_appeondll.of_pastefromclipboard( ls_filepath, ls_filename) > 0 THEN
	ls_fullname = ls_filepath + ls_filename
	IF FileExists(ls_fullname) THEN
		//dw_1.SetItem( 1, "filename", "Pasted From Email Complete" )
		dw_1.SetItem( 1, "filename", "Pasted from Clipboard" ) //Alfee 01.08.2008
		
		is_filename = ls_fullname
		is_filename_org = ls_fullname
		
		cb_preview.Enabled = TRUE
		cb_checkin.Enabled = TRUE
		is_checkin_type = '2' //Added by Ken.Guo on 2009-04-10
		IF NOT ib_new THEN
			Parent.of_compare_doc( )
		END IF
	END IF
END IF
end event

type cb_1 from commandbutton within w_dm_checkin_document
integer x = 1751
integer y = 24
integer width = 544
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Select File..."
end type

event clicked;/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: Open a local file.
**==================================================================================================================
**  Created By	: Davis 01.11.2007
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

string docname, named
integer value
gf_load_dir_path() //Added by Ken.Guo on 2009-03-10
IF ib_new THEN
	//--------Begin Modified by Alfee 10.31.2007--------
	
	value = GetFileOpenName("Select File",&
	+ docname, named, "DOC", &
		+ "Doc Files (*DOCX;*.DOC),*.DOCX;*.DOC,"&	
		+ "Xls Files (*XLSX;*.XLS),*.XLSX;*.XLS,"&			
		+ "Tif Files (*.TIF),*.TIF,"&
		+ "Pdf Files (*.PDF),*.PDF,"&
		+ "All Files (*.*), *.*" )
	/* 	value = GetFileOpenName("Select File",&
	+ docname, named, "DOC", &
		+ "Doc Files (*.DOC),*.DOC,"&	
		+ "Tif Files (*.TIF),*.TIF,"&
		+ "Pdf Files (*.PDF),*.PDF,"&
		+ "All Files (*.*), *.*" ) 	*/
	//-------End Modified -------------------------------
ELSE
	//-------Begin Modified by Alfee 01.08.2008----------
	IF Upper(is_doc_ext) = 'DOC' THEN 
		value = GetFileOpenName("Select File",&
		+ docname, named, is_doc_ext, "Doc Files (*DOCX;*.DOC),*.DOCX;*.DOC")
	ELSE		
		value = GetFileOpenName("Select File",&
		+ docname, named, is_doc_ext, is_doc_ext + " Files (*." + is_doc_ext+ "),*." + is_doc_ext )
	END IF		
	//value = GetFileOpenName("Select File",&
	//+ docname, named, is_doc_ext, is_doc_ext + " Files (*." + is_doc_ext+ "),*." + is_doc_ext )	
	//-------End Modified -------------------------------
END IF
gf_save_dir_path(docname) //Added by Ken.Guo on 2009-03-10
//ChangeDirectory(gs_current_path) //Added by Alfee 05.14.2007

IF value = 1 THEN
	is_checkin_type = '1' //Added by Ken.Guo on 2009-04-10
	IF NOT ib_new THEN
		//IF Lower(Right(named, LEN(is_doc_ext))) <> Lower(is_doc_ext) THEN	//Alfee 01.08.2008
		IF Lower(Right(named, LEN(is_doc_ext))) <> Lower(is_doc_ext) AND &
			NOT (Lower(Right(named, 4)) = 'docx' AND Lower(is_doc_ext) = 'doc') THEN
			MessageBox("Select File", "Please select a document of the same type as the previous one.")
			RETURN
		END IF
	END IF
	
	dw_1.SetItem( 1, "filename", docname )
	is_filename = docname
	is_filename_org = docname
	
	cb_preview.Enabled = TRUE
	cb_checkin.Enabled = TRUE
	
	IF NOT ib_new THEN
		Parent.of_compare_doc( )
	END IF
END IF
end event

type dw_1 from u_dw within w_dm_checkin_document
integer x = 32
integer y = 28
integer width = 1659
integer height = 812
integer taborder = 10
string dataobject = "d_dm_checkin_document"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;dw_1.of_setupdateable( False )

end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
00w_dm_checkin_document.bin 
2400000e00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff00000001000000000000000000000000000000000000000000000000000000009768051001d1db2300000003000005000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000025400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003c9bc4e0f4a3c4248a763498a04f417d3000000009768051001d1db239768051001d1db230000000000000000000000000054004e004f004b0066004f0069006600650063007400430053006c006d0074000000000000000000000000000000000000000000000000000000000000000001020022ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000025400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000c0000000d0000000e0000000f00000010000000110000001200000013fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Affffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1234abcd00000feb0000068300dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b4000000010000000000000000000000000000000000000000000000010000000000000000000000010000000000800000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001234abcd00000feb0000068300dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b400000001000000000000000000000000000000000000000000000001000000000000000000000001000000000080000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
10w_dm_checkin_document.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
