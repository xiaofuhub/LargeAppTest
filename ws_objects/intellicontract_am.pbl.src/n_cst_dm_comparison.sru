$PBExportHeader$n_cst_dm_comparison.sru
forward
global type n_cst_dm_comparison from nonvisualobject
end type
end forward

global type n_cst_dm_comparison from nonvisualobject
end type
global n_cst_dm_comparison n_cst_dm_comparison

type variables
Long il_source_docid
Decimal idc_source_revid
String is_soure_docname, is_call_from, is_step

DataStore ids_target_docs
DataWindow idw_doc
Window iw_parent

end variables

forward prototypes
public subroutine of_close_comparison (string as_call_from)
public subroutine of_close_comparison_wizard (string as_call_from)
public function integer of_ini_info ()
public function integer of_refresh_info ()
public function integer of_start_compare_clauses (window aw_parent, datawindow adw_doc, string as_call_from)
public function integer of_select_document (long al_row)
public function integer of_clear_flags ()
public function string of_get_flag (long al_docid, decimal adc_revid)
end prototypes

public subroutine of_close_comparison (string as_call_from);//Close comparison window - called in parent window closed event
IF IsValid(w_dm_comparison_wizard) THEN
	IF w_dm_comparison_wizard.of_get_call_from() = as_call_from THEN
		Close(w_dm_comparison_wizard)
	END IF
END IF

end subroutine

public subroutine of_close_comparison_wizard (string as_call_from);//Called after browse datawindow refreshed

//Refresh the comparison info
of_refresh_info() 	

//Close comparison wizard window while the step isn't 'compare'
IF is_step <> 'compare' AND IsValid(w_dm_comparison_wizard) THEN
	IF w_dm_comparison_wizard.of_get_call_from() = as_call_from THEN
		Close(w_dm_comparison_wizard)
	END IF
END IF



end subroutine

public function integer of_ini_info ();//initilize the comparison info.

is_step = ''
il_source_docid = -1
idc_source_revid = -1
is_soure_docname = ''

ids_target_docs.Reset()

RETURN 1


end function

public function integer of_refresh_info ();//refresh the comparison info after clause treeview refreshed.

il_source_docid = -1
idc_source_revid = -1
is_soure_docname = ''

ids_target_docs.Reset()

RETURN 1


end function

public function integer of_start_compare_clauses (window aw_parent, datawindow adw_doc, string as_call_from);String ls_call_from

//Return if the comparison window is opened before 
IF IsValid(w_dm_comparison_wizard) THEN 
	ls_call_from = w_dm_comparison_wizard.of_get_call_from()
END IF
IF Len(Trim(ls_call_from)) > 0 THEN
	//If already opened in other module before, then prompt the message.
	IF ls_call_from <> as_call_from THEN MessageBox("Document Comparison","The Document Comparison window has been opened in other module, please close it first.")
	RETURN 0
END IF

//Initilize the variables
iw_parent = aw_parent
idw_doc = adw_doc
is_call_from = as_call_from
is_step = 'source' 

//Open compare wizard window
OpenwithParm(w_dm_comparison_wizard, This, aw_parent)


RETURN 1
end function

public function integer of_select_document (long al_row);//*****Select the source or target document(s) to compare *****//
Long ll_found, ll_row, ll_cnt, ll_docid
Decimal ldc_revid
String ls_compare_status, ls_docname, ls_docext, ls_find

//Return if not under comparison mode
IF IsNull(is_step) OR Len(Trim(is_step)) < 1 THEN RETURN 0
IF Not IsValid(idw_doc) OR al_row < 1 THEN RETURN -1
IF Lower(is_step) <> 'source' AND Lower(is_step) <> 'target' THEN RETURN 0

//Return if not a Word document
ls_docext = idw_doc.GetItemString(al_row, "doc_ext")
IF IsNull(ls_docext) OR Lower(ls_docext) <> 'doc' THEN //Alfee 09.08.2008
	IF IsValid(w_dm_comparison_wizard) THEN 
		Beep(1)
//		w_dm_comparison_wizard.st_alert.text = "Please select a document with a Word format!" //modify by gavins 20120205
		If idw_doc.classname( ) = 'dw_detail' Then
			w_dm_comparison_wizard.st_alert.text = "Please select a Word format document in Document History!" 
		Else
			w_dm_comparison_wizard.st_alert.text = "Please select a document with a Word format!"
		End If
	END IF
	RETURN 0
END IF
//IF IsNull(ls_docext) OR Lower(ls_docext) <> 'doc' THEN RETURN 0


//Get data of current row
ls_compare_status = idw_doc.GetItemString(al_row, "compare_status")
IF IsNull(ls_compare_status) THEN ls_compare_status = ''
ll_docid = idw_doc.GetItemNumber(al_row, "doc_id")
IF idw_doc.GetItemNumber(al_row, "level") = 1 THEN
	ldc_revid = idw_doc.GetItemDecimal(al_row, "revision")
ELSE
	ldc_revid = idw_doc.GetItemDecimal(al_row, "audit_version")
END IF
ls_docname = idw_doc.GetItemString(al_row, "doc_name")

//Return if another same document selected already to compare
ll_cnt = idw_doc.RowCount()
ls_find = "doc_id = " + String(ll_docid) +" And (compare_status = '1' or compare_status = '2')" + &
		    " And ((Level = 1 And revision = " + String(ldc_revid) + ") OR (Level = 2 AND audit_version = " + String(ldc_revid) + "))"
ll_found = idw_doc.Find(ls_find, 1, ll_cnt)
IF ll_found = al_row THEN ll_found = idw_doc.Find(ls_find, ll_found + 1, ll_cnt)
IF ll_found > 0 THEN  //Alfee 09.06.2008
	IF IsValid(w_dm_comparison_wizard) THEN
		Beep(1)
//		w_dm_comparison_wizard.st_alert.text = "Please select a document with a different revision!"	// modify by gavins 20120205
		If idw_doc.classname( ) = 'dw_detail' Then
			w_dm_comparison_wizard.st_alert.text = "Please select a document in Document History with a different revision!"
		Else
			w_dm_comparison_wizard.st_alert.text = "Please select a document with a different revision!"
		End If
	END IF
	RETURN 0
END IF
//IF ll_found > 0 THEN RETURN 0


//Select source document.
IF Lower(is_step) = 'source' THEN	
	//Select a new source document
	IF ls_compare_status <> '1' THEN 
		//Restore compare status's flag for last source document
		IF (il_source_docid > 0 and il_source_docid <> ll_docid ) OR &
			(idc_source_revid >=0 and idc_source_revid <> ldc_revid ) THEN
			ll_found = idw_doc.Find("compare_status = '1'", 1, idw_doc.RowCount())
			IF ll_found > 0 THEN idw_doc.SetItem(ll_found, "compare_status", '')
		END IF
		//Reset the datastore to target documents if it's a target document
		IF ls_compare_status = '2' THEN
			ll_found = ids_target_docs.Find('doc_id = ' + String(ll_docid) + ' AND revision = ' + String(ldc_revid), 1, ids_target_docs.RowCount())
			IF ll_found > 0 THEN ids_target_docs.DeleteRow(ll_found)
		END IF
		//Set compare status' flag for current selected document
		idw_doc.SetItem(al_row, "compare_status", '1')
		il_source_docid = ll_docid
		idc_source_revid = ldc_revid
		is_soure_docname = ls_docname
		IF IsValid(w_dm_comparison_wizard) THEN w_dm_comparison_wizard.st_alert.text = "" //Alfee 09.06.2008
	//Unselect the source document
	ELSE	
		//Clear the current compare status' flag
		idw_doc.SetItem(al_row, "compare_status", '')
		il_source_docid = -1
		idc_source_revid = -1
		is_soure_docname = ''
	END IF
END IF

//Select target document
IF Lower(is_step) = 'target' THEN
	//Return if it's already a source document 
	IF ls_compare_status = '1' THEN RETURN 0
	//Select a new target document
	IF ls_compare_status <> '2' THEN 
		//Set the compare status' flag
		idw_doc.SetItem(al_row, "compare_status", '2')
		//Set datastore to target documents
		ll_found = ids_target_docs.Find('doc_id = ' + String(ll_docid) + ' AND revision = ' + String(ldc_revid), 1, ids_target_docs.RowCount())
		IF NOT ll_found > 0 THEN 
			ll_row = ids_target_docs.InsertRow(0)
			ids_target_docs.SetItem(ll_row, 'doc_id', ll_docid)
			ids_target_docs.SetItem(ll_row, 'revision', ldc_revid)
			ids_target_docs.SetItem(ll_row, 'doc_name', ls_docname)
		END IF
	//Unselect the target document
	ELSE	
		//Clear the current compare status' flag
		idw_doc.SetItem(al_row, "compare_status", '')
		//Clear datastore to target documents
		ll_found = ids_target_docs.Find('doc_id = ' + String(ll_docid) + ' AND revision = ' + String(ldc_revid), 1, ids_target_docs.RowCount())
		IF ll_found > 0 THEN ids_target_docs.DeleteRow(ll_found)		
	END IF
	IF IsValid(w_dm_comparison_wizard) THEN w_dm_comparison_wizard.st_alert.text = "" //Alfee 09.06.2008	
END IF

RETURN 1
end function

public function integer of_clear_flags ();//Clear out the compare flags in browse datawindow
Long ll_cnt, ll_found

IF NOT IsValid(idw_doc) THEN RETURN -1

ll_cnt = idw_doc.RowCount()
DO
	ll_found = idw_doc.Find("compare_status = '1'", 1, ll_cnt)
	IF ll_found > 0 THEN idw_doc.SetItem(ll_found, "compare_status", '')
LOOP While ll_found > 0

DO
	ll_found = idw_doc.Find("compare_status = '2'", 1, ll_cnt)
	IF ll_found > 0 THEN idw_doc.SetItem(ll_found, "compare_status", '')	
LOOP While ll_found > 0

RETURN 1
end function

public function string of_get_flag (long al_docid, decimal adc_revid);//Get comparison flag based on doc & rev id after a collapse & expand operation in browse datawindow
Long  ll_cnt
String ls_find

IF IsNull(al_docid) OR al_docid < 1 THEN RETURN ""
IF IsNull(adc_revid) OR adc_revid < 0 THEN RETURN ""
IF NOT IsValid(idw_doc) THEN RETURN ""

//for a duplicate document record
ll_cnt = idw_doc.RowCount()
ls_find = "doc_id = " + String(al_docid) +" And (compare_status = '1' or compare_status = '2')" + &
		    " And ((Level = 1 And revision = " + String(adc_revid) + ") OR (Level = 2 AND audit_version = " + String(adc_revid) + "))"
IF idw_doc.Find(ls_find, 1, ll_cnt) > 0 THEN RETURN ""

//for a source document
IF al_docid = il_source_docid AND adc_revid = idc_source_revid THEN RETURN '1'

//For a target document
ll_cnt = ids_target_docs.RowCount()
IF ll_cnt < 1 THEN RETURN ""
IF ids_target_docs.Find("doc_id = " + String(al_docid) + " And revision = " + String(adc_revid), 1, ll_cnt) > 0 THEN
	RETURN "2"
END IF

RETURN ''
end function

on n_cst_dm_comparison.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_dm_comparison.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ids_target_docs = Create DataStore
ids_target_docs.DataObject = 'd_dm_comparison'

ids_target_docs.SetTransObject(SQLCA)
end event

event destructor;Destroy ids_target_docs
end event

