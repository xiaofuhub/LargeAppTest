$PBExportHeader$w_clause_document.srw
forward
global type w_clause_document from w_response
end type
type ole_1 from u_email_edit within w_clause_document
end type
type cbx_redline from checkbox within w_clause_document
end type
type cb_retrieve from commandbutton within w_clause_document
end type
type cb_select from commandbutton within w_clause_document
end type
type dw_filter from u_dw_contract within w_clause_document
end type
type st_1 from statictext within w_clause_document
end type
type cb_close from commandbutton within w_clause_document
end type
type cb_update from commandbutton within w_clause_document
end type
type dw_doc from u_dw within w_clause_document
end type
end forward

global type w_clause_document from w_response
integer width = 3941
integer height = 2048
string title = "Update Documents"
boolean controlmenu = false
long backcolor = 33551856
ole_1 ole_1
cbx_redline cbx_redline
cb_retrieve cb_retrieve
cb_select cb_select
dw_filter dw_filter
st_1 st_1
cb_close cb_close
cb_update cb_update
dw_doc dw_doc
end type
global w_clause_document w_clause_document

type variables
Integer ii_pagebreak, ii_appendparagraph
Decimal{1} idec_ver_step
str_clause istr_clause
n_cst_clause inv_clause //Added By Ken.Guo 07/30/2012

Constant Long wdDoNotSaveChanges = 0 
Constant Long wdPromptToSaveChanges = -2 
Constant Long wdSaveChanges = -1 


// WdBreakType
Constant long wdSectionBreakNextPage = 2 
Constant long wdSectionBreakContinuous = 3 
// WdCollapseDirection
Constant long wdCollapseEnd = 0
Constant long wdCollapseStart = 1

Constant long wdFormatDocument = 0 

Constant STRING ENTERCHAR = "~r~n"

Constant LONG	ATTRIBUTECNTS = 6
end variables

forward prototypes
public function integer of_update_document ()
public function integer of_get_field_count ()
public function integer of_add_redline (long al_doc_id, string as_source_file, string as_target_file)
end prototypes

public function integer of_update_document ();//////////////////////////////////////////////////////////////////////
// Function: of_update_document()
// Arguments:
//--------------------------------------------------------------------
// Return:  integer
//--------------------------------------------------------------------
// Author:	Ken.Guo		Date: 2010-01-22
//--------------------------------------------------------------------
// Description: After saved clause, update exist documents if it used the clause.
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////
Long i,ll_cnt,ll_count,li_ret,j,ll_count_bk
String ls_doc_filename[] ,ls_merge_file_temp
String ls_bookmark,ls_bk_name
Long ll_start_ori,ll_len_ori,ll_end_new
Long ll_ctx_id, ll_doc_id,ll_export_id
Decimal ldec_revision,ldec_new_revision, ldec_clause_revision
String ls_doc_file,ls_error,ls_doc_file_org,ls_doc_file_update
str_doc_info lstr_docinfo
str_add_audit lstr_add_audit
n_cst_dm_utils lnv_dm_utils
n_cst_word_utility inv_word_utility 
n_cst_ovole_utils inv_ole_utils_doc
Datetime ldt_lastmodify

Long		k, ll_upperbound									//Added By Mark Lee 07/23/12
Integer	li_rtn															//Added By Mark Lee 07/23/12
String		ls_user_name, ls_msg										//Added By Mark Lee 07/23/12
str_sys_tracking_log_arr			str_sys_tracking_log_arr_s	//Added By Mark Lee 07/23/12

Long ll_pagebreak,ll_AppendParagraph,w		
String ls_clausename

ll_cnt = dw_doc.rowcount()
If ll_cnt = 0 Then Return -1

//If no checked document 
If dw_doc.find('checked = 1',1,ll_cnt) <= 0 Then 
	Messagebox('','Please select a document first.')
	Return -1
End If

//Reset flag to Refresh Document Manager data after clause update.
If Isvalid(gw_contract) Then
	If gw_contract.tab_contract_details.ib_select9 Then
		If gw_contract.tab_contract_details.selectedtab = 9 Then
			gw_contract.tab_contract_details.selecttab(1)
		End If
		gw_contract.tab_contract_details.ib_select9 = False
	End If
End If

//of_get_field_count() //Commented By Ken.Guo 07/30/2012

//Open a Word Application and create user object
OLEObject lole_word,lole_document
lole_word = Create OLEObject
IF lole_word.Connecttonewobject("word.application") <> 0 THEN
	Messagebox('Client Error', 'This application could not connect to Microsoft Word. Please make sure it is properly installed.')
	Destroy lole_word
	RETURN -1
END IF
lole_word.Application.NormalTemplate.Saved = TRUE 

lole_word.Visible = False
lole_document = Create OLEObject
inv_word_utility = Create n_cst_word_utility
inv_ole_utils_doc = Create n_cst_ovole_utils 

//ls_bookmark = "clause_" + string(istr_clause.al_clause_id) //Commented By Ken.Guo 07/30/2012

IF Not IsValid(w_appeon_gifofwait) THEN	
	OpenWithParm(w_appeon_gifofwait, 'Updating document file...')
	w_appeon_gifofwait.of_setposition(10)
End If

//Update Document
For i = 1 To ll_cnt
	//Get document info
	If dw_doc.GetItemNumber(i,'checked') = 0 Then Continue

	dw_doc.ScrolltoRow(i)
	dw_doc.SetRow(i)
	dw_doc.SetItem(i,'update_result','Updating ...')
	
	ll_ctx_id = dw_doc.GetItemNumber(i,'ctx_am_document_ctx_id')
	ll_doc_id = dw_doc.GetItemNumber(i,'ctx_am_document_doc_id')
	ldec_revision = dw_doc.GetItemDecimal(i,'ctx_am_document_revision')
	ll_export_id = dw_doc.GetItemNumber(i,'ctx_am_document_export_id')
	lstr_docinfo.doc_name = dw_doc.GetItemString(i,'ctx_am_document_doc_name')
	lstr_docinfo.create_by = dw_doc.GetItemString(i,'ctx_am_document_create_by')
	lstr_docinfo.ver_num = ldec_revision
	lstr_docinfo.ver_date = Date(dw_doc.GetItemDatetime(i,'ctx_am_doc_image_modify_date'))

	If dw_doc.GetItemString(i,'ctx_am_document_checkout_status') <> '0' Then
		dw_doc.SetItem(i,'update_result','Can not update the checked out document.')
		Continue
	End If
	//Begin - Added By Mark Lee 07/23/12
	li_rtn = gnv_tracking.of_find_recorde(gnv_tracking.document_management,string(ll_doc_id),'','',str_sys_tracking_log_arr_s)
	If li_rtn > 0 Then 
		ls_user_name = ''
		ll_upperbound = Upperbound(str_sys_tracking_log_arr_s.astr_sys_tracking_log_arr[])
		For k = 1 to ll_upperbound 
			ls_user_name	= str_sys_tracking_log_arr_s.astr_sys_tracking_log_arr[k].as_user + ","
		Next 
		If len(ls_user_name) > 2 Then
			ls_user_name = left(ls_user_name,len(ls_user_name) - 1)
		End If 
		ls_msg =	"Currently <"+ls_user_name+ "> is editing the <"+lstr_docinfo.doc_name+"> document.~r~n You will have to wait until <"+ls_user_name+"> has finished editing that document and closed the document before continuing. "
		dw_doc.SetItem(i,'update_result','Failure. '+ls_msg)
		continue
	End If
	//End - Added By Mark Lee 07/23/12

	//Download document
	If isvalid(w_appeon_gifofwait) Then
		w_appeon_gifofwait.of_setposition(20)
		w_appeon_gifofwait.of_settext('Downloading the document file ...')
	End If
	ls_doc_file = lnv_dm_utils.of_download_file(ll_doc_id,ldec_revision )
	If ls_doc_file = '' or Not fileexists(ls_doc_file) Then
		dw_doc.SetItem(i,'update_result','Failed to download the document.')
		Continue
	End If

	ls_doc_file_update = gs_dir_path + gs_DefDirName + "\Agreement\doc" + String(ll_doc_id) +'_update.doc'
	ls_doc_file_org = gs_dir_path + gs_DefDirName + "\Agreement\doc" + String(ll_doc_id) +'_org.doc'
	
	If FileCopy(ls_doc_file,ls_doc_file_org,True) <> 1 Then
		dw_doc.SetItem(i,'update_result','Failed to replace the document file "' + ls_doc_file_org +'".')
		Continue
	End If
	If FileCopy(ls_doc_file,ls_doc_file_update,True) <> 1 Then
		dw_doc.SetItem(i,'update_result','Failed to replace the document file "' + ls_doc_file_update +'".')
		Continue
	End If

	//Replace clause in document file
	TRY 
		IF Not IsValid(w_appeon_gifofwait) THEN	
			OpenWithParm(w_appeon_gifofwait, 'Updating the document file...')
			w_appeon_gifofwait.of_setposition(30)
		Else
			w_appeon_gifofwait.of_setposition(30)
			w_appeon_gifofwait.of_settext('Updating the document file ...')			
		End If
	
		lole_word.Application.NormalTemplate.Saved = TRUE 
		lole_document = lole_word.Application.Documents.Open(ls_doc_file_update,false,false)
		gnv_word_utility.of_modify_word_property( lole_word.Activedocument)	//Added By Mark Lee 06/20/2013 change for office 2013.
		gnv_shell.of_delete_recent( ls_doc_file_update, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
		IF lole_word.Application.Documents.Count < 1 THEN 			
			dw_doc.SetItem(i,'update_result','Failed to Open the document file "' + ls_doc_file_update +'".')
			EXIT
		END IF

		
		If UpperBound(istr_clause.al_clause_id_arr[]) = 0 Then
			istr_clause.al_clause_id_arr[1] = istr_clause.al_clause_id
		End If

		For w = 1 to UpperBound(istr_clause.al_clause_id_arr[])
			ls_bookmark = "clause_" + string(istr_clause.al_clause_id_arr[w])
			If Not lole_document.content.bookmarks.Exists(ls_bookmark) Then Continue
			ldec_clause_revision = inv_clause.of_get_revision( istr_clause.al_clause_id_arr[w])
	
			ls_clausename = inv_clause.of_generate_name( istr_clause.al_clause_id_arr[w], ldec_clause_revision)
			If Not FileExists(ls_clausename) Then
				inv_clause.of_download_file( istr_clause.al_clause_id_arr[w], ldec_clause_revision, ls_clausename)
			End If
			If Not FileExists(ls_clausename) Then
				Messagebox('Update Template','Failed to download the clause file, please try again.')
				Return -1
			End If
			istr_clause.as_clause_file = ls_clausename
			of_get_field_count() 			
			
			ls_bookmark = "clause_" + string(istr_clause.al_clause_id_arr[w])
			Select page_break,append_paragraph into :ll_pagebreak,:ll_AppendParagraph From ctx_acp_clause Where ctx_acp_clause_id = :istr_clause.al_clause_id_arr[w];
	
			if istr_clause.ai_type = 1 then //jervis 01.30.2010
				ll_start_ori = lole_document.content.bookmarks.item(ls_bookmark).start
				ll_len_ori = lole_document.content.bookmarks.item(ls_bookmark).end - ll_start_ori
						
				//Delete the sub bookmark before update the clause. because inserted file include the same bookmarks name
				ll_count_bk = lole_document.content.bookmarks.count
				For j = ll_count_bk to 1 Step -1
					If lole_document.content.bookmarks.item[j].start >= ll_start_ori and &
						lole_document.content.bookmarks.item[j].end <= lole_document.content.bookmarks.item(ls_bookmark).end and &
						lole_document.content.bookmarks.item[j].name <> ls_bookmark	Then
							lole_document.content.bookmarks.item[j].delete()
					End IF
				Next
						
				lole_document.content.bookmarks.item(ls_bookmark).select()
				lole_document.activewindow.selection.collapse(wdCollapseStart)
		
				//for the case of adding content before an existed table
				IF lole_document.activewindow.selection.tables.count > 0 THEN 
					lole_document.activewindow.selection.InsertBreak(wdSectionBreakContinuous)	
					lole_document.activewindow.selection.Start = ll_start_ori
					lole_document.activewindow.selection.End = lole_document.content.bookmarks.item(ls_bookmark).End
					lole_document.activewindow.selection.collapse(wdCollapseStart)			
				END IF			
					
				If ll_pagebreak = 1 Then lole_document.activewindow.selection.insertbreak(wdSectionBreakNextPage)	//added by alfee at 05.29.2007
				If ll_AppendParagraph = 1 Then 
					lole_document.activewindow.selection.TypeParagraph()
					//lole_document.activewindow.selection.InsertParagraphAfter()
				End If
				lole_document.activewindow.selection.InsertFile( ls_clausename )
				gnv_shell.of_delete_recent( ls_clausename, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
				lole_document.activewindow.selection.Expand()
		
				ll_end_new = lole_document.content.bookmarks.item(ls_bookmark).end
				lole_document.range(ll_end_new - ll_len_ori, ll_end_new).Delete()
				
//				//Update Requirment
//				If istr_clause.al_require_field_count > 0 Then
//					inv_word_utility.of_refresh_reqmnt_fields(lole_word,ll_ctx_id,ls_error)
//					inv_word_utility.of_update_reqmnt_field(lole_word , ll_doc_id, 'D') 
//				End If
			end if
		Next		
		
		//Update Requirment
		If istr_clause.ai_type = 1 then
			If istr_clause.al_require_field_count > 0 Then
				inv_word_utility.of_refresh_reqmnt_fields(lole_word,ll_ctx_id,ls_error)
				inv_word_utility.of_update_reqmnt_field(lole_word , ll_doc_id, 'D') 
			End If
		End If
		
		//Update Clause Text Color and Word comment 
		inv_word_utility.of_update_clausecolor( lole_document, istr_clause.al_clause_id_arr[])
		if istr_clause.ai_type = 1 then
			inv_word_utility.of_update_wordcomment( lole_document, istr_clause.al_clause_id_arr[])
		end if	
		
		
		lole_document.Close(wdSaveChanges)

		if istr_clause.ai_type = 1 then
			
			//Merge document
			If istr_clause.al_merge_field_count > 0 Then
				If isvalid(w_appeon_gifofwait) Then
					w_appeon_gifofwait.of_setposition(50)
					w_appeon_gifofwait.of_settext('Merging data for the document file ...')
				End If			
				ls_merge_file_temp = gs_dir_path + gs_DefDirName + "\Agreement\Manager\merge_temp.doc"
				If FileCopy(ls_doc_file_update,ls_merge_file_temp,True) <> 1 Then
					Messagebox('Error','Failed to delete the temp file "' +ls_merge_file_temp+ '"')
					Exit
				End If
				
				If inv_ole_utils_doc.of_mergedata(ll_export_id, ll_ctx_id,ls_merge_file_temp, ls_doc_file_update, False, lstr_docinfo) < 0 Then
					dw_doc.SetItem(i,'update_result','Failed to merge data.')
					Continue			
				End If
			End If	
			
			//Update Auto Number
			inv_ole_utils_doc.of_autonumbering(ls_doc_file_update)
		
		end if
		
		//Generate Revision
		If dw_doc.GetItemString(i,'ctx_am_document_revision_control') = '1' Then
			If idec_ver_step = 1 Then
				ldec_new_revision = Int(ldec_revision + idec_ver_step)
			Else
				ldec_new_revision = ldec_revision + idec_ver_step
			End If
		Else
			ldec_new_revision = ldec_revision
		End If
		
		//Add redline in document
		If cbx_redline.checked Then
			of_add_redline(ll_doc_id,ls_doc_file_org,ls_doc_file_update)
		End If
		
		//Update document file to DB
		If isvalid(w_appeon_gifofwait) Then
			w_appeon_gifofwait.of_setposition(60)
			w_appeon_gifofwait.of_settext('Uploading the document file ...')
		End If			
		
		//Select ldt_lastmodify
		If lnv_dm_utils.of_upload_file(ll_doc_id,ldec_new_revision,ls_doc_file_update) < 0 Then
			dw_doc.SetItem(i,'update_result','Failed to upload the document.')
			Continue
		End If
		
		//Update document clause map
		If isvalid(w_appeon_gifofwait) Then
			w_appeon_gifofwait.of_setposition(80)
			w_appeon_gifofwait.of_settext('Updating the clause map ...')
		End If			
		If ldec_new_revision <> ldec_revision Then
			Select count(1) into :ll_count From ctx_am_document_clause Where doc_id = :ll_doc_id and revision = :ldec_new_revision;
			If ll_count = 0 Then
				Insert ctx_am_document_clause(doc_id,revision,ctx_acp_clause_id,orders) 
				Select doc_id,:ldec_new_revision,ctx_acp_clause_id,orders From ctx_am_document_clause 
				Where ctx_am_document_clause.doc_id = :ll_doc_id and ctx_am_document_clause.revision = :ldec_revision;
				If sqlca.sqlcode <> 0 Then
					//Rollback data
					Delete from ctx_am_doc_image where doc_id = :ll_doc_id and revision = :ldec_new_revision ;
					dw_doc.SetItem(i,'update_result','Failed to update the clause map.')
					Continue
				End If
			End If
		End If
		
		//Add audit 
		If isvalid(w_appeon_gifofwait) Then
			w_appeon_gifofwait.of_setposition(90)
			w_appeon_gifofwait.of_settext('Updating the audit ...')
		End If			
		lstr_add_audit.Doc_id = ll_doc_id
		lstr_add_audit.Revision = ldec_new_revision
		lstr_add_audit.doc_ext = 'doc'
		if istr_clause.ai_type = 1 then
			lstr_add_audit.action = "Modified - From Clause"
		else
			lstr_add_audit.action = "Modified - From Clause Status Change"
		end if
		lnv_dm_utils.of_add_audit_trail( lstr_add_audit )		
		
		//Set Update Result
		dw_doc.SetItem(i,'update_result','The update is completed.')	
		
		If isvalid(w_appeon_gifofwait) Then
			w_appeon_gifofwait.of_setposition(100)
			w_appeon_gifofwait.of_settext('Completed.')
		End If

		FileDelete(ls_doc_file_org)
		FileDelete(ls_doc_file_update)
		
	Catch( Throwable th)
		f_word_destroy(lole_word, "") 
		Destroy lole_document
		If isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
		MessageBox("Warning","Update Document file(s) failed! " + th.text, exclamation!)	
		Return -1 
	End Try
	
Next

//Quit Word application
lole_word.Quit(0)
lole_word.DisconnectObject( )
Destroy lole_document
Destroy lole_word
If isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)

MessageBox("Update","Document update completed!" )	

Return 1
end function

public function integer of_get_field_count ();//////////////////////////////////////////////////////////////////////
// Function: of_get_field_count()
// Arguments:
//--------------------------------------------------------------------
// Return:  integer
//--------------------------------------------------------------------
// Author:	Ken.Guo		Date: 2010-02-04
//--------------------------------------------------------------------
// Description: Get cluase info whether exists fields.
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////
String ls_file_copy,ls_bk_name
Long i, ll_bk_cnt,ll_var_cnt,ll_field_cnt

ls_file_copy = gs_dir_path + gs_DefDirName + "\Agreement\clause_" + string(istr_clause.al_clause_id) + "_fields.doc"

FileCopy(istr_clause.as_clause_file,ls_file_copy,True)

//Open a Word Application and create user object
OLEObject lole_word,lole_document
lole_word = Create OLEObject
IF lole_word.Connecttonewobject("word.application") <> 0 THEN
	Messagebox('Client Error', 'This application could not connect to Microsoft Word. Please make sure it is properly installed.')
	Destroy lole_word
	RETURN -1
END IF
lole_word.Application.NormalTemplate.Saved = TRUE 

lole_word.Visible = False
lole_document = Create OLEObject
lole_word.Application.Documents.Open(ls_file_copy,false,false)
gnv_word_utility.of_modify_word_property( lole_word.Activedocument)	//Added By Mark Lee 06/20/2013 change for office 2013.
gnv_shell.of_delete_recent( ls_file_copy, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
ll_var_cnt = lole_word.ActiveDocument.Variables.Count
ll_field_cnt = lole_word.ActiveDocument.Fields.Count

//Get merge field count
istr_clause.al_merge_field_count += ll_var_cnt + ll_field_cnt

ll_bk_cnt = lole_word.ActiveDocument.Bookmarks.Count
For i = 1 To ll_bk_cnt
	ls_bk_name = lole_word.ActiveDocument.Bookmarks.Item[i].Name
	If Left(ls_bk_name,7) = 'reqmnt_' Then
		//exists requirement count
		istr_clause.al_require_field_count = 1
		Exit
	End If
Next

lole_word.ActiveDocument.Close(wdDoNotSaveChanges)
lole_word.Quit(0)
lole_word.DisconnectObject( )
Destroy lole_word
FileDelete(ls_file_copy)

Return 1
end function

public function integer of_add_redline (long al_doc_id, string as_source_file, string as_target_file);String ls_targetfile_copy,ls_sourcefile_copy
oleobject lole_word
ls_targetfile_copy = gs_dir_path + gs_DefDirName + "\Agreement\doc" + String(al_doc_id) +'_compare.doc'
ls_sourcefile_copy = gs_dir_path + gs_DefDirName + "\Agreement\doc" +String(al_doc_id) + '_compare_copy.doc'

//Copy target file to a temporary compare file 
IF FileExists(as_target_file) and FileCopy(as_target_file, ls_targetfile_copy, TRUE) <> 1 THEN 
	MessageBox("Clause Comparison","Please make sure the file of '" + ls_targetfile_copy + "' can be deleted!" )
	RETURN -1
END IF

//IF FileCopy(ls_targetfile, ls_sourcefile_copy, TRUE) <> 1 THEN
IF FileCopy(as_source_file, ls_sourcefile_copy, TRUE) <> 1 THEN //Alfee 07.24.2008
	MessageBox("Clause Comparison","Please make sure the file of '" + ls_sourcefile_copy + "' can be deleted!" )
	RETURN -1
END IF

//Accept ALL changes for two file 
n_cst_ovole_utils lnv_ole_utils_doc
lnv_ole_utils_doc = Create n_cst_ovole_utils
lnv_ole_utils_doc.of_acceptall(ls_sourcefile_copy)		
lnv_ole_utils_doc.of_acceptall(ls_targetfile_copy)	
Destroy lnv_ole_utils_doc			
			
IF Len(ls_targetfile_copy) > 0 and FileExists(ls_targetfile_copy) THEN
	//Compare and saveas the document under a new Word2007 application
	IF gs_word_version = 'word2007' THEN
		IF NOT IsValid(lole_word) THEN
			lole_word = Create OleObject
			IF lole_word.Connecttonewobject("word.application") <> 0 THEN
				Messagebox('Client Error', 'Could not connect to Microsoft Word. Please make sure it is properly installed.')
				Destroy lole_word					
				RETURN -1
			END IF
		END IF

		lole_word.Visible = FALSE
		lole_word.Application.NormalTemplate.Saved = TRUE  //Alfee 01.17.2008
		lole_word.Application.Documents.Open(ls_sourcefile_copy, False, True) 
		gnv_word_utility.of_modify_word_property( lole_word.Activedocument)	//Added By Mark Lee 06/20/2013 change for office 2013.		
		gnv_shell.of_delete_recent( ls_sourcefile_copy, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
		//lole_word.ActiveDocument.Compare(ls_sourcefile, "External", 1, True, True, False)
		lole_word.ActiveDocument.Compare(ls_targetfile_copy, "External", 1, True, True, False) //Alfee 07.24.2008
		gnv_shell.of_delete_recent( ls_targetfile_copy, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
		lole_word.ActiveDocument.SaveAs(as_target_file, wdFormatDocument,false,'',false)
		gnv_shell.of_delete_recent( as_target_file, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
		lole_word.ActiveDocument.Close(0)
		lole_word.Quit(0)
		lole_word.DisconnectObject( )
	Else
		//Open the file to be compared
		OLE_1.Object.OpenLocalFile(ls_targetfile_copy, TRUE) 		
		gnv_word_utility.of_modify_word_property( OLE_1.object.ActiveDocument)	//Added By Mark Lee 06/20/2013 change for office 2013.
		//Compare with the source document if under non Word 2007 environment
		IF gs_word_version <> 'word2007' THEN 
			IF gs_word_version = 'word2003' or gs_word_version = 'wordxp' THEN
				ole_1.object.ActiveDocument.Compare(ls_sourcefile_copy, "External", 1, True, True, False )
			ELSE
				ole_1.object.ActiveDocument.Compare(ls_sourcefile_copy)
			END IF
		END IF
		gnv_shell.of_delete_recent( ls_sourcefile_copy, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
		If gs_ImageView_Version <> '4.0' Then ole_1.object.filesave = True
		ole_1.object.ActiveDocument.SaveAs(as_target_file, wdFormatDocument,false,'',false)
		If gs_ImageView_Version <> '4.0' Then ole_1.object.filesave = False
		gnv_shell.of_delete_recent( as_target_file, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
		ole_1.object.Close()
	End IF
End If


FileDelete(ls_sourcefile_copy)
FileDelete(ls_targetfile_copy)

Return 1
end function

on w_clause_document.create
int iCurrent
call super::create
this.ole_1=create ole_1
this.cbx_redline=create cbx_redline
this.cb_retrieve=create cb_retrieve
this.cb_select=create cb_select
this.dw_filter=create dw_filter
this.st_1=create st_1
this.cb_close=create cb_close
this.cb_update=create cb_update
this.dw_doc=create dw_doc
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ole_1
this.Control[iCurrent+2]=this.cbx_redline
this.Control[iCurrent+3]=this.cb_retrieve
this.Control[iCurrent+4]=this.cb_select
this.Control[iCurrent+5]=this.dw_filter
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.cb_close
this.Control[iCurrent+8]=this.cb_update
this.Control[iCurrent+9]=this.dw_doc
end on

on w_clause_document.destroy
call super::destroy
destroy(this.ole_1)
destroy(this.cbx_redline)
destroy(this.cb_retrieve)
destroy(this.cb_select)
destroy(this.dw_filter)
destroy(this.st_1)
destroy(this.cb_close)
destroy(this.cb_update)
destroy(this.dw_doc)
end on

event open;call super::open;long ll_row,ll_rowcount

inv_clause = Create n_cst_clause

//DatawindowChild ldwc_ctx_category,ldwc_doc_category
//
//dw_filter.GetChild('ctx_category',ldwc_ctx_category)
//dw_filter.GetChild('doc_category',ldwc_doc_category)
//
//ldwc_ctx_category.SetTransObject(SQLCA)
//ldwc_doc_category.SetTransObject(SQLCA)
//
//gnv_appeondb.of_startqueue( )
//	ldwc_ctx_category.Retrieve(gs_user_id)
//	ldwc_doc_category.Retrieve(gs_user_id)
//gnv_appeondb.of_commitqueue( )	
//

If gnv_data.of_getitem( 'icred_settings','doc_name_format', False) = '0' Then 
	dw_doc.Modify('doc_name_full.Expression = "ctx_am_document_doc_name" doc_name_full_t.text = "Document Name" ')
Else
	dw_doc.Modify('doc_name_full.Expression = "ctx_am_document_doc_name + ~' ~' + String( ctx_am_document_doc_id )+ ~'.~' + String( ctx_am_document_revision ,~'##0.0~')" doc_name_full_t.text = "Document Name && ID" ')
End If

dw_doc.of_SetTransObject( SQLCA )

istr_clause = message.powerobjectparm

cb_retrieve.event clicked( )
dw_doc.setfocus()






end event

event activate;call super::activate;//Added By Ken.Guo 2011-11-30. Workaround Office OCX's bug
If isvalid(ole_1 ) Then
	ole_1.object.activate(true)
End If
end event

event close;call super::close;If isvalid(inv_clause) Then Destroy inv_clause
end event

type ole_1 from u_email_edit within w_clause_document
boolean visible = false
integer x = 2418
integer y = 1844
integer width = 151
integer height = 116
integer taborder = 30
string binarykey = "w_clause_document.win"
end type

event constructor;call super::constructor;this.object.filesaveas = true
end event

type cbx_redline from checkbox within w_clause_document
integer x = 434
integer y = 1864
integer width = 1609
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Redline Changes in Documents"
boolean checked = true
end type

type cb_retrieve from commandbutton within w_clause_document
integer x = 2880
integer y = 1852
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Retrieve"
end type

event clicked;
//Added By Ken.Guo 07/30/2012
If UpperBound(istr_clause.al_clause_id_arr[]) = 0 Then
	istr_clause.al_clause_id_arr[1] = istr_clause.al_clause_id
End If

//Retrieve Data and filter
dw_doc.retrieve(istr_clause.al_clause_id_arr[] )
dw_filter.event ue_filter( )

//Get clause information and version settings
//Select page_break,append_paragraph into :ii_pagebreak,:ii_appendparagraph From ctx_acp_clause Where ctx_acp_clause_id = :istr_clause.al_clause_id ;


If of_get_app_setting("set_58",'I') = 0 Then
	idec_ver_step = 1.0
Else
	idec_ver_step = 0.1
End If

end event

type cb_select from commandbutton within w_clause_document
integer x = 37
integer y = 1852
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Select All"
end type

event clicked;Integer li_value0[], li_value1[]
long i,ll_cnt

ll_cnt = dw_doc.rowcount() 
If ll_cnt = 0 Then Return

For i = 1 to ll_cnt
	li_value0[i] = 0
	li_value1[i] = 1
Next

If This.text = '&Deselect All' Then
	This.Text = '&Select All'
	dw_doc.object.checked[1,ll_cnt] = li_value0[]
Else
	This.Text = '&Deselect All'
	dw_doc.object.checked[1,ll_cnt] = li_value1[]
End If

end event

type dw_filter from u_dw_contract within w_clause_document
event ue_system pbm_syscommand
event ue_filter ( )
integer x = 23
integer y = 20
integer width = 3881
integer height = 472
integer taborder = 10
boolean titlebar = true
string title = "Search"
string dataobject = "d_document_filter"
boolean vscrollbar = false
end type

event ue_system;If message.wordparm = 61458 Then
	Return -1
End If

end event

event ue_filter();Long ll_ctx_id,ll_ctx_category,ll_ctx_status
Long ll_doc_category,ll_doc_status
String ls_filter,ls_ctx_company,ls_doc_name

This.AcceptText()
ll_ctx_id = This.GetItemNumber(1,'ctx_id')
If ll_ctx_id > 0 Then
	ls_filter = ' ctx_am_document_ctx_id = ' + String(ll_ctx_id)
End If

ll_ctx_category = This.GetItemNumber(1,'ctx_category')
If Not isnull(ll_ctx_category) Then
	If ls_filter <> '' Then
		ls_filter +=  ' and (ctx_basic_info_category) = ' +String(ll_ctx_category)
	Else
		ls_filter +=  ' (ctx_basic_info_category) = ' +String(ll_ctx_category)
	End If
End If

ll_ctx_status = This.GetItemNumber(1,'ctx_status')
If Not isnull(ll_ctx_status) Then
	If ls_filter <> '' Then
		ls_filter +=  ' and (ctx_basic_info_status) = ' +String(ll_ctx_status)
	Else
		ls_filter +=  ' (ctx_basic_info_status) = ' +String(ll_ctx_status)
	End If
End If

ls_ctx_company = This.GetItemString(1,'ctx_company')
If Not isnull(ls_ctx_company) and ls_ctx_company <> '' Then
	If ls_filter <> '' Then
		ls_filter +=  ' And Pos( Upper(app_facility_facility_name) ,"' + Upper(ls_ctx_company) + '",1 ) > 0'
	Else
		ls_filter +=  ' Pos( Upper(app_facility_facility_name) ,"' + Upper(ls_ctx_company) + '",1 ) > 0'
	End If
End If

ll_doc_category = This.GetItemNumber(1,'doc_category')
If Not isnull(ll_doc_category) Then
	If ls_filter <> '' Then
		ls_filter +=  ' and (ctx_am_document_category) = ' +String(ll_doc_category)
	Else
		ls_filter +=  ' (ctx_am_document_category) = ' +String(ll_doc_category)
	End If
End If

ll_doc_status = This.GetItemNumber(1,'doc_status')
If Not isnull(ll_doc_status) Then
	If ls_filter <> '' Then
		ls_filter +=  ' and (ctx_am_document_status) = ' +String(ll_doc_status)
	Else
		ls_filter +=  ' (ctx_am_document_status) = ' +String(ll_doc_status)
	End If
End If

ls_doc_name = This.GetItemString(1,'doc_name')
If Not isnull(ls_doc_name) and ls_doc_name <> '' Then
	If ls_filter <> '' Then
		ls_filter +=  ' And Pos( Upper(doc_name_full) ,"' + Upper(ls_doc_name) + '",1 ) > 0'
	Else
		ls_filter +=  ' Pos( Upper(doc_name_full) ,"' + Upper(ls_doc_name) + '",1 ) > 0'
	End If
End If

SetPointer(HourGlass!)
dw_doc.SetRedraw(False)
dw_doc.VScrollbar = False
dw_doc.SetFilter(ls_filter)
dw_doc.Filter()
dw_doc.SetSort('ctx_am_document_ctx_id Asc, ctx_am_document_doc_name Asc, ctx_am_document_doc_id Asc ')
dw_doc.Sort()
dw_doc.groupcalc( )
dw_doc.VScrollbar = True
dw_doc.SetRedraw(True)
SetPointer(Arrow!)

end event

event buttonclicked;Choose Case dwo.name
	Case 'b_clear'
		dw_filter.Reset()
		dw_filter.InsertRow(0)
	Case 'b_filter'
		This.event ue_filter( )
End Choose
end event

event constructor;This.event ue_populatedddws( )
This.of_SetUpdateable( False )
This.InsertRow(0)
end event

event getfocus;//Override Ancestor Script
end event

type st_1 from statictext within w_clause_document
boolean visible = false
integer x = 466
integer y = 1988
integer width = 1705
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 67108864
string text = "Note: Please make sure all document files are closed before updating."
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_clause_document
integer x = 3570
integer y = 1852
integer width = 334
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;Close(Parent)


end event

type cb_update from commandbutton within w_clause_document
integer x = 3227
integer y = 1852
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Update"
end type

event clicked;If Messagebox('Update','The changes you will be making will be permanent. Are you sure you want to continue?',Question!,YesNo!) = 1 Then
	of_update_document()
End If
end event

type dw_doc from u_dw within w_clause_document
event ue_system pbm_syscommand
integer x = 23
integer y = 508
integer width = 3881
integer height = 1316
integer taborder = 20
boolean titlebar = true
string title = "Document Browse"
string dataobject = "d_clause_document"
boolean hscrollbar = true
end type

event ue_system;If message.wordparm = 61458 Then
	Return -1
End If

end event

event constructor;This.of_setrowselect(True)
This.inv_rowselect.of_setstyle(This.inv_rowselect.single)
This.of_SetUpdateable( False )
end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
08w_clause_document.bin 
2400000e00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000cdef1d0001d1752300000003000005000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000025400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003c9bc4e0f4a3c4248a763498a04f417d300000000cdef1d0001d17523cdef1d0001d175230000000000000000000000000054004e004f004b0066004f0069006600650063007400430053006c006d0074000000000000000000000000000000000000000000000000000000000000000001020022ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000025400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000c0000000d0000000e0000000f00000010000000110000001200000013fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Effffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1234abcd00000369000002ff00dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b4000000010000000000000000000000000000000000000000000000010000000000000000000000010000000000800000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001234abcd00000369000002ff00dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b400000001000000000000000000000000000000000000000000000001000000000000000000000001000000000080000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
18w_clause_document.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
