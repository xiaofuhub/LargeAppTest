$PBExportHeader$w_dm_comparison_wizard.srw
forward
global type w_dm_comparison_wizard from w_popup
end type
type ole_source from u_email_edit within w_dm_comparison_wizard
end type
type ole_1 from u_email_edit within w_dm_comparison_wizard
end type
type st_step from statictext within w_dm_comparison_wizard
end type
type st_source from statictext within w_dm_comparison_wizard
end type
type st_source_t from statictext within w_dm_comparison_wizard
end type
type st_splitbar from u_st_splitbar within w_dm_comparison_wizard
end type
type st_title from statictext within w_dm_comparison_wizard
end type
type cb_close from commandbutton within w_dm_comparison_wizard
end type
type st_alert from statictext within w_dm_comparison_wizard
end type
type cb_cancel from commandbutton within w_dm_comparison_wizard
end type
type cb_next from commandbutton within w_dm_comparison_wizard
end type
type st_prompt from statictext within w_dm_comparison_wizard
end type
type ln_1 from line within w_dm_comparison_wizard
end type
type ln_2 from line within w_dm_comparison_wizard
end type
type gb_source from groupbox within w_dm_comparison_wizard
end type
type dw_document from u_dw within w_dm_comparison_wizard
end type
type gb_clause from groupbox within w_dm_comparison_wizard
end type
end forward

global type w_dm_comparison_wizard from w_popup
integer width = 1865
integer height = 804
string title = "Document Comparison Wizard"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 33551856
boolean center = true
boolean ib_isupdateable = false
ole_source ole_source
ole_1 ole_1
st_step st_step
st_source st_source
st_source_t st_source_t
st_splitbar st_splitbar
st_title st_title
cb_close cb_close
st_alert st_alert
cb_cancel cb_cancel
cb_next cb_next
st_prompt st_prompt
ln_1 ln_1
ln_2 ln_2
gb_source gb_source
dw_document dw_document
gb_clause gb_clause
end type
global w_dm_comparison_wizard w_dm_comparison_wizard

type variables
Long il_source_docid, il_last_docid = -1
Decimal idc_source_revid
String is_call_from
string is_sourcefile,is_sourcefile_org
string is_source_docname
DataWindowChild idwc_doc, idwc_rev

n_cst_dm_comparison inv_comparison
n_cst_dm_utils  inv_dm_utils
OleObject iole_word 

Constant long wdFormatDocument = 0 
end variables

forward prototypes
public function string of_get_call_from ()
public subroutine of_adjust_ui ()
public function integer of_prepare_comparison_bak ()
public function integer of_prepare_comparison ()
public subroutine of_compare_document_bak (long al_docid, decimal adc_revid)
public subroutine of_compare_document (long al_docid, decimal adc_revid)
end prototypes

public function string of_get_call_from ();RETURN is_call_from
end function

public subroutine of_adjust_ui ();st_title.visible = FALSE
st_prompt.visible = FALSE
st_alert.visible = FALSE
cb_next.visible = FALSE
cb_cancel.visible = FALSE
ln_1.visible = FALSE
ln_2.visible = FALSE

gb_clause.visible = TRUE
dw_document.visible = TRUE
ole_1.visible = TRUE
ole_source.visible = true
cb_close.visible = TRUE
gb_source.visible = true
st_source.visible = true
st_source_t.visible = true

This.width = 4060
This.Height = 2150

gb_source.x = 20
gb_source.y = 20
st_source_t.x = gb_source.x + 30
st_source.x = gb_source.x + 30
st_source_t.y = 100
st_source.y = 160


ole_source.x = gb_source.x 
ole_source.y = 300
ole_source.width = 2000
ole_source.height = This.height - ole_source.y - 240

ole_1.x = ole_source.x + ole_source.width + 20
ole_1.y = ole_source.y
ole_1.width = 2000
ole_1.height = This.height - ole_1.y - 240


gb_clause.y = 20
dw_document.y = 80


st_splitbar.x = ole_source.x + ole_source.width
st_splitbar.y = ole_source.y
st_splitbar.height = ole_source.height

cb_close.x = ole_1.x + ole_1.width - cb_close.width
cb_close.y = ole_1.y + ole_1.height + 20


//Set window resizable
THIS.Title = "Document Comparison"
THIS.ControlMenu = TRUE
This.Maxbox = TRUE
THIS.Minbox = TRUE
THIS.Resizable = TRUE
THIS.Center = TRUE
this.windowstate = Maximized!

end subroutine

public function integer of_prepare_comparison_bak ();Long i, ll_row, ll_cnt, ll_docid
String ls_docname

SetReDraw(FALSE)

//Adjust the UI for documents comparison
of_adjust_ui()

//Get the source document
il_source_docid = inv_comparison.il_source_docid
idc_source_revid = inv_comparison.idc_source_revid

//Initilize the dddws with the source document
idwc_doc.InsertRow(0)
idwc_doc.SetItem(1, "doc_id", inv_comparison.il_source_docid)
idwc_doc.SetItem(1, "doc_name", inv_comparison.is_soure_docname)

idwc_rev.InsertRow(0)
idwc_rev.SetItem(1, "doc_id", inv_comparison.il_source_docid)
idwc_rev.SetItem(1, "doc_name", inv_comparison.is_soure_docname)
idwc_rev.SetItem(1, "revision", inv_comparison.idc_source_revid)

//initilize the dddws with target documents 
ll_cnt = inv_comparison.ids_target_docs.RowCount()
FOR i = 1 to ll_cnt
	ll_docid = inv_comparison.ids_target_docs.GetItemNumber(i, "doc_id")
   ls_docname = inv_comparison.ids_target_docs.GetItemString(i, "doc_name")
	IF idwc_doc.Find("doc_id = " + String(ll_docid),1, idwc_doc.RowCount()) > 0 THEN 
		CONTINUE
	END IF
	ll_row = idwc_doc.Insertrow(0)
	idwc_doc.SetItem(ll_row, "doc_id", ll_docid)
	idwc_doc.SetItem(ll_row, "doc_name", ls_docname)	
NEXT
inv_comparison.ids_target_docs.RowsCopy(1, ll_cnt, Primary!, idwc_rev, 2, Primary!)

idwc_doc.InsertRow(1)
idwc_rev.InsertRow(1)
dw_document.InsertRow(0)

SetReDraw(TRUE)

return 1
end function

public function integer of_prepare_comparison ();Long i, ll_row, ll_cnt, ll_docid
String ls_docname

SetReDraw(FALSE)

//Adjust the UI for documents comparison
of_adjust_ui()

//Get the source document
il_source_docid = inv_comparison.il_source_docid
idc_source_revid = inv_comparison.idc_source_revid

/*
//Initilize the dddws with the source document
idwc_doc.InsertRow(0)
idwc_doc.SetItem(1, "doc_id", inv_comparison.il_source_docid)
idwc_doc.SetItem(1, "doc_name", inv_comparison.is_soure_docname)

idwc_rev.InsertRow(0)
idwc_rev.SetItem(1, "doc_id", inv_comparison.il_source_docid)
idwc_rev.SetItem(1, "doc_name", inv_comparison.is_soure_docname)
idwc_rev.SetItem(1, "revision", inv_comparison.idc_source_revid)
*/
is_source_docname = inv_comparison.is_soure_docname
st_source.text = is_source_docname + " Ver " + string(inv_comparison.idc_source_revid)

//initilize the dddws with target documents 
ll_cnt = inv_comparison.ids_target_docs.RowCount()
FOR i = 1 to ll_cnt
	ll_docid = inv_comparison.ids_target_docs.GetItemNumber(i, "doc_id")
   ls_docname = inv_comparison.ids_target_docs.GetItemString(i, "doc_name")
	IF idwc_doc.Find("doc_id = " + String(ll_docid),1, idwc_doc.RowCount()) > 0 THEN 
		CONTINUE
	END IF
	ll_row = idwc_doc.Insertrow(0)
	idwc_doc.SetItem(ll_row, "doc_id", ll_docid)
	idwc_doc.SetItem(ll_row, "doc_name", ls_docname)	
NEXT
inv_comparison.ids_target_docs.RowsCopy(1, ll_cnt, Primary!, idwc_rev, 2, Primary!)

idwc_doc.InsertRow(1)
idwc_rev.InsertRow(1)
dw_document.InsertRow(0)

SetReDraw(TRUE)

//Download and display source document
//********Get Source File ******************//
IF not isnull(il_source_docid) and not isnull(idc_source_revid) and (il_source_docid > 0 and idc_source_revid >= 0 ) THEN
	//Get the selected document's file 
	IF IsValid(inv_dm_utils) THEN
		is_sourcefile = inv_dm_utils.of_download_file( il_source_docid, idc_source_revid)		
	END IF		
	
	//Open source document
	is_sourcefile_org = gs_dir_path + gs_DefDirName + "\Agreement\" + '_document_compare_org_copy.doc'
	FileCopy(is_sourcefile,is_sourcefile_org,True) //Added By Ken.Guo 2010-02-04.
	Try
		Ole_source.object.OpenLocalFile(is_sourcefile_org,true)
		gnv_word_utility.of_modify_word_property( Ole_source.object.ActiveDocument)	//Added By Mark Lee 06/20/2013 change for office 2013.
	CATCH (Throwable th) 
		IF OLE_1.Object.doctype = 1 THEN OLE_1.Object.Close()
	end try
END IF

//Comparison
if ll_cnt > 0 then 
	dw_document.SetItem(1,'doc_id',inv_comparison.ids_target_docs.GetItemNumber(1, "doc_id"))
	dw_document.event itemfocuschanged( 1, dw_document.object.revision)
end if

return 1
end function

public subroutine of_compare_document_bak (long al_docid, decimal adc_revid);String ls_sourcefile, ls_targetfile
String ls_comparefile,ls_comparefile_copy 
String ls_source_docname, ls_target_docname, ls_source_rev, ls_target_rev, ls_title 
Long ll_rowcnt, ll_found 

//ole_1.Object.Close()	- commented by alfee 09.23.2008
ls_title = "Document Comparison" //Alfee 09.17.2008
This.Title = ls_title  

IF IsNull(al_docid) OR IsNull(adc_revid) OR al_docid < 1 OR adc_revid < 0 THEN RETURN
IF Not IsValid(inv_comparison) THEN RETURN

//********Get target document file************//
//Get the selected document's file 
IF IsValid(inv_dm_utils) THEN
	ls_targetfile = inv_dm_utils.of_download_file(al_docid, adc_revid)
END IF
	
//********Get Source File ******************//
IF (al_docid <> il_source_docid and il_source_docid > 0 ) OR &
	(adc_revid <> idc_source_revid and idc_source_revid >= 0 ) THEN
	//Get the selected document's file 
	IF IsValid(inv_dm_utils) THEN
		ls_sourcefile = inv_dm_utils.of_download_file( il_source_docid, idc_source_revid)		
	END IF		
END IF

TRY 
			
//********Compare document Files *************//
ls_comparefile = gs_dir_path + gs_DefDirName + "\Agreement\" + '_docs_compare.doc'
ls_comparefile_copy = gs_dir_path + gs_DefDirName + "\Agreement\" + '_docs_compare_copy.doc'
//Copy target file to a temporary compare file 
IF FileExists(ls_targetfile) and FileCopy(ls_targetfile, ls_comparefile, TRUE) <> 1 THEN 
	MessageBox("Document Comparison","Please make sure the file of '" + ls_comparefile + "' can be deleted!" )
	RETURN
END IF
IF Len(ls_comparefile) > 0 and FileExists(ls_comparefile) THEN
	IF Len(ls_sourcefile) > 0 and FileExists(ls_sourcefile) THEN
		//Compare and saveas the document under a new Word2007 application
		IF gs_word_version = 'word2007' THEN
			IF NOT IsValid(iole_word) THEN
				iole_word = Create OleObject
				IF iole_word.Connecttonewobject("word.application") <> 0 THEN
					Messagebox('Client Error', 'Could not connect to Microsoft Word. Please make sure it is properly installed.')
					Destroy iole_word					
					RETURN 
				END IF
			END IF
			IF FileCopy(ls_sourcefile, ls_comparefile_copy, TRUE) <> 1 THEN				
				MessageBox("Document Comparison","Please make sure the file of '" + ls_comparefile_copy + "' can be deleted!" )
				RETURN 
			END IF
			iole_word.Visible = FALSE
			iole_word.Application.NormalTemplate.Saved = TRUE  
			iole_word.Application.Documents.Open(ls_comparefile_copy, False, True)
			gnv_word_utility.of_modify_word_property( iole_word.Activedocument)	//Added By Mark Lee 06/20/2013 change for office 2013.
			gnv_shell.of_delete_recent( ls_comparefile_copy, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
			iole_word.ActiveDocument.Compare(ls_targetfile, "External", 1, True, True, False)
			iole_word.ActiveDocument.SaveAs(ls_comparefile, wdFormatDocument,false,'',false)
			gnv_shell.of_delete_recent( ls_comparefile, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
			iole_word.ActiveDocument.Close(0)
		END IF	
		
		//Open the file to be compared
		OLE_1.Object.OpenLocalFile(ls_comparefile, TRUE) 			
		//Compare with the source document if under non Word 2007 environment
		IF gs_word_version <> 'word2007' THEN 
			IF gs_word_version = 'word2003' or gs_word_version = 'wordxp' THEN
				ole_1.object.ActiveDocument.Compare(ls_sourcefile, "External", 1, True, True, False )
			ELSE
				ole_1.object.ActiveDocument.Compare(ls_sourcefile)
			END IF
		END IF	
		
		//Open the source file - jervis 01.13.2010
		Ole_source.object.OpenLocalFile(ls_sourcefile,true)
	ELSE
		OLE_1.Object.OpenLocalFile(ls_comparefile, TRUE)
		OLE_source.Object.OpenLocalFile(ls_comparefile, TRUE)
	END IF	
	gnv_word_utility.of_modify_word_property( ole_1.object.ActiveDocument)	//Added By Mark Lee 06/20/2013 change for office 2013.	
	gnv_word_utility.of_modify_word_property( OLE_source.object.ActiveDocument)	//Added By Mark Lee 06/20/2013 change for office 2013.
	//Adjust the windows title accordingly //Alfee 09.17.2008
	//Get document names
	IF IsValid(idwc_doc) THEN ll_rowcnt = idwc_doc.RowCount()
	IF ll_rowcnt > 0 THEN ll_found = idwc_doc.Find("doc_id = " + String(al_docid), 1, ll_rowcnt)
	IF ll_found > 0 THEN ls_target_docname = idwc_doc.GetItemString(ll_found,"doc_name")
	IF ll_rowcnt > 0 THEN ll_found = idwc_doc.Find("doc_id = " + String(il_source_docid), 1, ll_rowcnt)
	IF ll_found > 0 THEN ls_source_docname = idwc_doc.GetItemString(ll_found,"doc_name")	
	
	//Get document revisions
	ls_target_rev = String(adc_revid) 
	ls_source_rev = String(idc_source_revid)
	IF ls_target_rev = "0" THEN ls_target_rev = "0.0"
	IF ls_source_rev = "0" THEN ls_source_rev = "0.0"
	
	//Generate and set windows title
	ls_title += " - [ " + ls_target_docname + " Ver " + ls_target_rev 
	IF ls_target_docname <> ls_source_docname THEN 
		ls_title += " vs. " + ls_source_docname + " Ver " + ls_source_rev
	ELSEIF ls_target_rev <> ls_source_rev THEN
		ls_title += " vs. Ver " + ls_source_rev
	END IF
	ls_title += " ]"
	This.Title = ls_title	

END IF

CATCH (Throwable th) 
	IF OLE_1.Object.doctype = 1 THEN OLE_1.Object.Close()
	if OLE_source.Object.doctype = 1 THEN OLE_source.Object.Close()
	f_word_destroy(iole_word, "")
END TRY
end subroutine

public subroutine of_compare_document (long al_docid, decimal adc_revid);String ls_sourcefile, ls_targetfile
String ls_comparefile,ls_comparefile_copy 
String ls_source_docname, ls_target_docname, ls_source_rev, ls_target_rev, ls_title 
Long ll_rowcnt, ll_found 

//ole_1.Object.Close()	- commented by alfee 09.23.2008
ls_title = "Document Comparison" //Alfee 09.17.2008
This.Title = ls_title  

IF IsNull(al_docid) OR IsNull(adc_revid) OR al_docid < 1 OR adc_revid < 0 THEN RETURN
IF Not IsValid(inv_comparison) THEN RETURN
if not FileExists(is_sourcefile) then Return

//********Get target document file************//
//Get the selected document's file 
IF (al_docid <> il_source_docid and al_docid > 0 ) OR (adc_revid <> idc_source_revid and adc_revid >= 0 ) THEN
	IF IsValid(inv_dm_utils) THEN
		ls_targetfile = inv_dm_utils.of_download_file(al_docid, adc_revid)
	END IF
end if


this.setredraw( false)
TRY 
OLE_1.Object.Close()	//Close doc before changed to another version number -- jervis 11.24.2010
//********Compare document Files *************//
ls_comparefile = gs_dir_path + gs_DefDirName + "\Agreement\" + '_docs_compare.doc'
ls_comparefile_copy = gs_dir_path + gs_DefDirName + "\Agreement\" + '_docs_compare_copy.doc'

//Copy the file to a temporary compare file 
IF FileExists(ls_targetfile) and FileCopy(ls_targetfile, ls_comparefile, TRUE) <> 1 THEN 
	MessageBox("Document Comparison","Please make sure the file of '" + ls_comparefile + "' can be deleted!" )
	RETURN
END IF

IF FileCopy(is_sourcefile, ls_comparefile_copy, TRUE) <> 1 THEN				
	MessageBox("Document Comparison","Please make sure the file of '" + ls_comparefile_copy + "' can be deleted!" )
	RETURN 
END IF

//Added By Ken.Guo 2010-02-04. Accept ALL changes for two file 
n_cst_ovole_utils lnv_ole_utils_doc
lnv_ole_utils_doc = Create n_cst_ovole_utils
lnv_ole_utils_doc.of_acceptall(ls_comparefile)		
lnv_ole_utils_doc.of_acceptall(ls_comparefile_copy)	
Destroy lnv_ole_utils_doc	

IF Len(ls_comparefile) > 0 and FileExists(ls_comparefile) THEN
	//Compare and saveas the document under a new Word2007 application
	IF gs_word_version = 'word2007' THEN
		IF NOT IsValid(iole_word) THEN
			iole_word = Create OleObject
			IF iole_word.Connecttonewobject("word.application") <> 0 THEN
				Messagebox('Client Error', 'Could not connect to Microsoft Word. Please make sure it is properly installed.')
				Destroy iole_word					
				RETURN 
			END IF
		END IF

		iole_word.Visible = FALSE
		iole_word.Application.NormalTemplate.Saved = TRUE  
		iole_word.Application.Documents.Open(ls_comparefile_copy, False, True) 
		gnv_word_utility.of_modify_word_property( iole_word.Activedocument)	//Added By Mark Lee 06/20/2013 change for office 2013.
		gnv_shell.of_delete_recent( ls_comparefile_copy, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
		iole_word.ActiveDocument.Compare(ls_targetfile, "External", 1, True, True, False)
		gnv_shell.of_delete_recent( ls_targetfile, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
		iole_word.ActiveDocument.SaveAs(ls_comparefile, wdFormatDocument,false,'',false)
		gnv_shell.of_delete_recent( ls_comparefile, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
		iole_word.ActiveDocument.Close(0)
	END IF	
		
	//Open the file to be compared
	OLE_1.Object.OpenLocalFile(ls_comparefile, TRUE) 			
	gnv_word_utility.of_modify_word_property( ole_1.object.ActiveDocument)	//Added By Mark Lee 06/20/2013 change for office 2013.	
	//Compare with the source document if under non Word 2007 environment
	IF gs_word_version <> 'word2007' THEN 
		IF gs_word_version = 'word2003' or gs_word_version = 'wordxp' THEN
			ole_1.object.ActiveDocument.Compare(ls_comparefile_copy, "External", 1, True, True, False )
		ELSE
			ole_1.object.ActiveDocument.Compare(ls_comparefile_copy)
		END IF
	END IF	
	gnv_shell.of_delete_recent( ls_comparefile_copy, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
	//Open the source file - jervis 01.13.2010
	//Ole_source.object.OpenLocalFile(ls_sourcefile,true)
	
	
	//Adjust the windows title accordingly //Alfee 09.17.2008
	//Get document names
	IF IsValid(idwc_doc) THEN ll_rowcnt = idwc_doc.RowCount()
	IF ll_rowcnt > 0 THEN ll_found = idwc_doc.Find("doc_id = " + String(al_docid), 1, ll_rowcnt)
	IF ll_found > 0 THEN ls_target_docname = idwc_doc.GetItemString(ll_found,"doc_name")
	//IF ll_rowcnt > 0 THEN ll_found = idwc_doc.Find("doc_id = " + String(il_source_docid), 1, ll_rowcnt)
	//IF ll_found > 0 THEN ls_source_docname = idwc_doc.GetItemString(ll_found,"doc_name")	
	
	//Get document revisions
	ls_target_rev = String(adc_revid) 
	ls_source_rev = String(idc_source_revid)
	IF ls_target_rev = "0" THEN ls_target_rev = "0.0"
	IF ls_source_rev = "0" THEN ls_source_rev = "0.0"
	
	//Generate and set windows title
	ls_title += " - [ " + ls_target_docname + " Ver " + ls_target_rev 
	IF ls_target_docname <> is_source_docname THEN 
		ls_title += " vs. " + is_source_docname + " Ver " + ls_source_rev
	ELSEIF ls_target_rev <> ls_source_rev THEN
		ls_title += " vs. Ver " + ls_source_rev
	END IF
	ls_title += " ]"
	This.Title = ls_title	

END IF

CATCH (Throwable th) 
	IF OLE_1.Object.doctype = 1 THEN OLE_1.Object.Close()
	if OLE_source.Object.doctype = 1 THEN OLE_source.Object.Close()
	f_word_destroy(iole_word, "")
END TRY
this.setredraw( true)
end subroutine

event open;call super::open;//Added by Ken.Guo on 2008-11-06
gnv_reg_ocx.of_check_ocx( 1,'', True) //1: office 


//Initilize variables and datastore
IF IsValid(Message.PowerObjectParm) THEN 
	inv_comparison = Message.PowerObjectParm
END IF

IF IsValid(inv_comparison) THEN is_call_from = inv_comparison.is_call_from

//Set the 1st step's prompt message

If inv_comparison.idw_doc.classname( ) <> 'dw_detail' Then
	st_title.text = "Select a Source Document!" 
Else
	st_title.text = "Select a Source Document in Document History!"//modify by gavins 20120205  Select a Source Document
End If

st_prompt.text = "Highlight the document that you want to compare other documents to (Compare to Document), then click Next.~r~n~r~nYou can compare different versions of the same document OR compare different documents."

end event

on w_dm_comparison_wizard.create
int iCurrent
call super::create
this.ole_source=create ole_source
this.ole_1=create ole_1
this.st_step=create st_step
this.st_source=create st_source
this.st_source_t=create st_source_t
this.st_splitbar=create st_splitbar
this.st_title=create st_title
this.cb_close=create cb_close
this.st_alert=create st_alert
this.cb_cancel=create cb_cancel
this.cb_next=create cb_next
this.st_prompt=create st_prompt
this.ln_1=create ln_1
this.ln_2=create ln_2
this.gb_source=create gb_source
this.dw_document=create dw_document
this.gb_clause=create gb_clause
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ole_source
this.Control[iCurrent+2]=this.ole_1
this.Control[iCurrent+3]=this.st_step
this.Control[iCurrent+4]=this.st_source
this.Control[iCurrent+5]=this.st_source_t
this.Control[iCurrent+6]=this.st_splitbar
this.Control[iCurrent+7]=this.st_title
this.Control[iCurrent+8]=this.cb_close
this.Control[iCurrent+9]=this.st_alert
this.Control[iCurrent+10]=this.cb_cancel
this.Control[iCurrent+11]=this.cb_next
this.Control[iCurrent+12]=this.st_prompt
this.Control[iCurrent+13]=this.ln_1
this.Control[iCurrent+14]=this.ln_2
this.Control[iCurrent+15]=this.gb_source
this.Control[iCurrent+16]=this.dw_document
this.Control[iCurrent+17]=this.gb_clause
end on

on w_dm_comparison_wizard.destroy
call super::destroy
destroy(this.ole_source)
destroy(this.ole_1)
destroy(this.st_step)
destroy(this.st_source)
destroy(this.st_source_t)
destroy(this.st_splitbar)
destroy(this.st_title)
destroy(this.cb_close)
destroy(this.st_alert)
destroy(this.cb_cancel)
destroy(this.cb_next)
destroy(this.st_prompt)
destroy(this.ln_1)
destroy(this.ln_2)
destroy(this.gb_source)
destroy(this.dw_document)
destroy(this.gb_clause)
end on

event close;call super::close;//Close the opened document
ole_1.Object.Close()
ole_source.object.close()

//Quit and destroy word instance for Word 2007 - Alfee 07.24.2008
IF gs_word_version = 'word2007' and IsValid(iole_word) THEN
	iole_word.Quit(0)
	iole_word.DisconnectObject()
	Destroy iole_word
END IF

FileDelete(is_sourcefile_org)

//Restore the comparison variables and flags 
IF IsValid(inv_comparison) THEN 
	inv_comparison.of_ini_info()
	inv_comparison.of_clear_flags()
END IF



end event

event resize;call super::resize;//Modify by jervis 01.13.2010
ole_source.width = (This.width - 80) / 2
ole_source.height = This.height - ole_source.y - 260
gb_source.width = ole_source.width
st_source.width = ole_source.width - 70

ole_1.x = ole_source.x + ole_source.width + 20
ole_1.width = ole_source.width 
ole_1.height = ole_source.height

gb_clause.x = ole_1.x
dw_document.x = gb_clause.x + 20
gb_clause.width = ole_1.width
dw_document.width = ole_1.width - 40


st_splitbar.x = ole_source.x + ole_source.width
st_splitbar.height = ole_source.height


cb_close.x = ole_1.x + ole_1.width - cb_close.width
cb_close.y = ole_1.y + ole_1.height + 15
end event

event activate;call super::activate;
//Added By Ken.Guo 2011-05-05. Workaround Office OCX's bug
If gs_imageview_version = '5.0' and isvalid(ole_1 ) Then
	If isvalid(ole_1.object) Then ole_1.object.activate(true)
	If isvalid(ole_source.object) Then ole_source.object.activate(true)
End If
end event

event deactivate;call super::deactivate;
//Added By Ken.Guo 2011-05-05. Workaround Office OCX's bug
//If gs_imageview_version = '5.0' and isvalid(ole_1 ) Then
//	ole_1.object.activate(false)
//	ole_source.object.activate(false)
//End If
end event

type ole_source from u_email_edit within w_dm_comparison_wizard
boolean visible = false
integer x = 453
integer y = 616
integer width = 347
integer height = 264
integer taborder = 10
string binarykey = "w_dm_comparison_wizard.win"
end type

event constructor;call super::constructor;this.object.filesaveas = true
end event

type ole_1 from u_email_edit within w_dm_comparison_wizard
boolean visible = false
integer x = 55
integer y = 616
integer width = 347
integer height = 264
integer taborder = 10
string binarykey = "w_dm_comparison_wizard.win"
integer binaryindex = 1
end type

event constructor;call super::constructor;this.object.filesaveas = true
end event

type st_step from statictext within w_dm_comparison_wizard
integer x = 1147
integer y = 16
integer width = 613
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Step 1 of 2"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_source from statictext within w_dm_comparison_wizard
boolean visible = false
integer x = 82
integer y = 1048
integer width = 1536
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_source_t from statictext within w_dm_comparison_wizard
boolean visible = false
integer x = 82
integer y = 980
integer width = 439
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 67108864
string text = "Document Name"
boolean focusrectangle = false
end type

type st_splitbar from u_st_splitbar within w_dm_comparison_wizard
integer x = 928
integer y = 792
integer width = 18
integer height = 500
end type

event constructor;call super::constructor;//Add by jervis 01.13.2010
this.of_register( ole_1,this.right )
this.of_register(Ole_source,this.left)
end event

type st_title from statictext within w_dm_comparison_wizard
integer x = 14
integer y = 16
integer width = 1102
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_dm_comparison_wizard
boolean visible = false
integer x = 1179
integer y = 716
integer width = 343
integer height = 92
integer taborder = 30
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

type st_alert from statictext within w_dm_comparison_wizard
integer x = 73
integer y = 472
integer width = 1687
integer height = 104
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 33551856
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_dm_comparison_wizard
integer x = 933
integer y = 608
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
end type

event clicked;Close(Parent)
end event

type cb_next from commandbutton within w_dm_comparison_wizard
integer x = 590
integer y = 608
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Next"
end type

event clicked;
IF Not IsValid(inv_comparison) THEN RETURN 

//First Step - Select source document
IF inv_comparison.is_step = 'source' THEN
	IF (NOT inv_comparison.il_source_docid > 0) OR &
	   (NOT inv_comparison.idc_source_revid >= 0) THEN
		Beep(1)
		If inv_comparison.idw_doc.classname( ) = 'dw_detail' Then
			st_alert.text = "Please select a Document (Compare to Document) in Document History first!" // modify by gavins 20120205 in Document History 
		Else
			st_alert.text = "Please select a Document (Compare to Document) first!"
		End If
	ELSE
		If inv_comparison.idw_doc.classname( ) = 'dw_detail' Then
			st_title.text = "Select Target Document(s) in Document History"
		Else
			st_title.text = "Select Target Document(s)"
		End If
		st_step.text = "Step 2 of 2"
		st_prompt.Text = "Highlight the Document(s) that you want to compare against the Compare to Document then click Next" //03.24.2008
		inv_comparison.is_step = 'target'
		st_alert.text = ""
	END IF
//Second Step - Select targe document(s)
ELSEIF inv_comparison.is_step = 'target'THEN
	IF NOT inv_comparison.ids_target_docs.RowCount() > 0 THEN
		Beep(1)
//		st_alert.text = "Please select the Document(s) that you want to compare against the Compare to Document first!"  //03.24.2008   modify by gavins 20120205
		If inv_comparison.idw_doc.classname( ) = 'dw_detail' Then
			st_alert.text ="Please select the document(s) that you want to compare against the Compare to Document in Document History first!"  
		Else
			st_alert.text ="Please select the document(s) that you want to compare against the Compare to Document first!"
		End If
	ELSE
		inv_comparison.is_step = 'compare'
		st_alert.text = ""
		st_title.text = ""
		st_step.text = ""
		//Prepare for the comparison
		of_prepare_comparison()		
	END IF
END IF	


end event

type st_prompt from statictext within w_dm_comparison_wizard
integer x = 73
integer y = 124
integer width = 1687
integer height = 340
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type ln_1 from line within w_dm_comparison_wizard
long linecolor = 134217746
integer linethickness = 5
integer beginy = 584
integer endx = 2002
integer endy = 584
end type

type ln_2 from line within w_dm_comparison_wizard
long linecolor = 134217746
integer linethickness = 5
integer beginy = 84
integer endx = 2002
integer endy = 84
end type

type gb_source from groupbox within w_dm_comparison_wizard
boolean visible = false
integer x = 41
integer y = 912
integer width = 1627
integer height = 264
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 67108864
string text = "Document To Compare Against"
end type

type dw_document from u_dw within w_dm_comparison_wizard
boolean visible = false
integer x = 1760
integer y = 972
integer width = 2002
integer height = 184
integer taborder = 10
string dataobject = "d_dm_comparison"
boolean vscrollbar = false
boolean border = false
boolean ib_isupdateable = false
boolean ib_rmbfocuschange = false
end type

event itemchanged;call super::itemchanged;long ll_docid
Decimal ldc_revid, ldc_null

SetPointer(HourGlass!)

SetNull(ldc_null)

CHOOSE CASE Lower(dwo.name) 
	CASE "doc_id" 
		//close document and clear revision field if document changed
		this.SetItem(row, "revision", ldc_null)
		ole_1.Object.Close()
		//ole_source.object.close()	//Jervis 01.13.2010
		This.title = "Document Comparison" //Alfee 09.07.2008
		RETURN 
		
	CASE "revision" 
		//Open or Compare document(s) accordingly if revision changed
		ll_docid = This.GetItemNumber(row, "doc_id")
		ldc_revid = Dec(data)
		
		of_compare_document(ll_docid, ldc_revid)
		
END CHOOSE








end event

event constructor;call super::constructor;This.GetChild("doc_id", idwc_doc)
This.GetChild("revision", idwc_rev)

idwc_doc.SetTransObject(SQLCA)
idwc_rev.SetTransObject(SQLCA)
end event

event itemfocuschanged;call super::itemfocuschanged;//Set DDDW of Revision Field  
long ll_docid

SetPointer(HourGlass!)

IF Lower(dwo.Name) <> 'revision' THEN RETURN

//Reset dddw of revision field if no document selected
ll_docid = This.GetItemNumber(row, "doc_id")
IF IsNull(ll_docid) OR (NOT ll_docid > 0) THEN 
	idwc_rev.SetFilter("IsNull(doc_id)")
	idwc_rev.Filter()
	il_last_docid = ll_docid //Set last doc id
	RETURN
END IF

//Do nothing if document not changed
IF ll_docid = il_last_docid THEN return
	
//Refersh dddw of revision field if document changed
idwc_rev.SetFilter("doc_id = " + String(ll_docid))
idwc_rev.Filter()
il_last_docid = ll_docid  //Set last doc id

//Comparison - jervis 01.23.2010
if idwc_rev.Rowcount( ) > 0 then
	this.SetItem( row,'revision',idwc_rev.getitemdecimal( 1, 'revision') )
	this.event itemchanged(row,this.object.revision, string(idwc_rev.getitemnumber( 1, 'revision')))
end if







end event

type gb_clause from groupbox within w_dm_comparison_wizard
boolean visible = false
integer x = 1728
integer y = 912
integer width = 2066
integer height = 264
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 67108864
string text = "Compare To Document"
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
08w_dm_comparison_wizard.bin 
2D00000e00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff000000010000000000000000000000000000000000000000000000000000000047a49e6001d17e9600000003000005000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000025400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003c9bc4e0f4a3c4248a763498a04f417d30000000047a49e6001d17e9647a49e6001d17e960000000000000000000000000054004e004f004b0066004f0069006600650063007400430053006c006d0074000000000000000000000000000000000000000000000000000000000000000001020022ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000025400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000c0000000d0000000e0000000f00000010000000110000001200000013fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Effffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1234abcd000007db000006d200dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b4000000010000000000000000000000000000000000000000000000010000000000000000000000010000000000800000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001234abcd000007db000006d200dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b4000000010000000000000000000000000000000000000000000000010000000000000000000000010000000000800000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000e00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
22fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff000000010000000000000000000000000000000000000000000000000000000047a49e6001d17e9600000003000005000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000025400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003c9bc4e0f4a3c4248a763498a04f417d30000000047a49e6001d17e9647a49e6001d17e960000000000000000000000000054004e004f004b0066004f0069006600650063007400430053006c006d0074000000000000000000000000000000000000000000000000000000000000000001020022ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000025400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000c0000000d0000000e0000000f00000010000000110000001200000013fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1234abcd000007db000006d200dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff
2D000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b4000000010000000000000000000000000000000000000000000000010000000000000000000000010000000000800000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001234abcd000007db000006d200dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b4000000010000000000000000000000000000000000000000000000010000000000000000000000010000000000800000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
18w_dm_comparison_wizard.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
