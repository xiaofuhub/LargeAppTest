$PBExportHeader$w_clause_painter.srw
$PBExportComments$Create by Jack 11/03/2006
forward
global type w_clause_painter from w_main
end type
type tab_1 from u_tab_agreement_clause_painter within w_clause_painter
end type
type tab_1 from u_tab_agreement_clause_painter within w_clause_painter
end type
end forward

global type w_clause_painter from w_main
integer width = 4549
integer height = 2208
string title = "Clause Library Painter"
windowstate windowstate = maximized!
long backcolor = 33551856
boolean clientedge = true
event pfc_cst_go ( )
event pfc_clear ( )
event pfc_addrow ( )
event pfc_cst_add_clause ( )
event type long pfc_deleterow ( )
event pfc_cst_rules ( )
event pfc_cst_properties ( )
event pfc_cst_rights ( )
event pfc_cst_expandall ( )
event pfc_cst_collapseall ( )
event pfc_cst_autonum ( )
event pfc_cst_select ( )
event pfc_cst_clause_reference ( )
event pfc_cst_insert_field ( )
event pfc_cst_merge_data ( )
event pfc_cst_analysis ( )
event pfc_cst_print ( )
event pfc_cst_compare ( )
event pfc_cst_insert_requirement ( )
event pfc_cst_copy ( )
event pfc_cst_checkin ( )
event pfc_cst_checkout ( )
event pfc_cst_revision ( )
event pfc_cst_saveas ( )
event pfc_cst_email ( )
event pfc_cst_add_folder ( )
event pfc_cst_export_clause_single ( )
event pfc_cst_export ( )
event ue_auto_retrieve ( )
event pfc_cst_batchupdatedoc ( )
event pfc_cst_analysis_bak ( )
tab_1 tab_1
end type
global w_clause_painter w_clause_painter

type variables
long il_handle,il_ctx_acp_folder_id,il_ctx_acp_clause_id,il_parent_folder_id,il_category
long il_first = 1
long il_folder[]
string is_type,is_types,is_clause_name
string is_data = '',is_data_delete,is_filter
String is_agreement_path //by alfee 04.182007

str_folder istr_folder
datastore ids_template_clause
datastore ids_folder
datastore ids_clause
datastore ids_clause_rely
datastore ids_next_handle
datastore ids_search_clause_text
datawindowchild idw_child

Constant long wdFieldRef = 3
Constant long wdFieldAutoTextList = 89
Constant long wdFieldHyperlink  = 88

// WdLanguageID
constant long wdSendToNewDocument = 0
// WdSaveOptions
constant int wdDoNotSaveChanges = 0
constant int wdPromptToSaveChanges = -2
constant int wdSaveChanges = -1
constant int wdNormalView = 1 //Added By Mark Lee 06/19/2013
constant int 	wdPageView = 3	//Added By Mark Lee 06/19/2013

OLEObject    				iole_object  
OLEObject    				iole_document 
OLEObject    				iole_workbook
n_cst_word_utility 			inv_word_util
//w_ole_word					iw_ole_word
n_cst_dm_utils  			inv_dm_utils
w_appeon_gifofwait 		iw_appeon_gifofwait	
String 				is_tmp_directory, is_export_file 
Boolean				ib_status	
n_ds					ids_template_msg
end variables

forward prototypes
public function integer of_ltrimword ()
public function integer of_rtrimword ()
public function integer of_check_numbering ()
public function integer of_changetitle ()
public function integer of_selectcontract (ref string as_ctx_id)
public subroutine of_delete_directory_file ()
public function long of_negotiated_clause (string as_ctx_id, long al_clause_id, decimal ade_revision)
public function integer of_download_file (long al_clause_id, decimal adec_revision, ref string as_filename, string as_type)
public function integer of_unmergedata (long al_ctx_id, long al_doc_id, decimal adec_revision, string as_open_file, ref string as_merge_file)
public function integer of_compare_doc (long al_clause_id, long al_doc_id, string as_file_clause_name, string as_merge_file)
end prototypes

event pfc_cst_go();tab_1.tabpage_browse.cb_go.triggerevent(clicked!)

end event

event pfc_clear();tab_1.tabpage_browse.cb_clear.triggerevent(clicked!)
tab_1.tabpage_browse.cb_go.triggerevent(clicked!)

end event

event pfc_addrow();tab_1.of_add_folder()

end event

event pfc_cst_add_clause();tab_1.of_add_clause()


end event

event type long pfc_deleterow();tab_1.of_deleterow()
Return 1

end event

event pfc_cst_rules();tab_1.of_rely()

end event

event pfc_cst_properties();tab_1.of_properties()


end event

event pfc_cst_rights();Open(w_security_roles_painter)

end event

event pfc_cst_expandall();long ll_tvi
ll_tvi = tab_1.tabpage_browse.tv_clause.FindItem(RootTreeItem!, 0)
tab_1.tabpage_browse.tv_clause.ExpandAll(ll_tvi)

end event

event pfc_cst_collapseall();long ll_tvi

ll_tvi = tab_1.tabpage_browse.tv_clause.finditem(roottreeitem!, 0)
ll_tvi = tab_1.tabpage_browse.tv_clause.FindItem(ChildTreeItem!,ll_tvi)

Do While ll_tvi > 0 
	tab_1.tabpage_browse.tv_clause.collapseitem(ll_tvi)
	ll_tvi = tab_1.tabpage_browse.tv_clause.finditem(NextTreeItem!, ll_tvi)
Loop


end event

event pfc_cst_autonum();////////////////////////////////////////////////////////////////////
// $<event>pfc_cst_autonum of w_clause_painter()
// $<arguments>
//		None		
// $<returns> (None)
// $<description>Insert a number field into the clause file
//////////////////////////////////////////////////////////////////////
// $<add> 04.16.2007 by Alfee (Contract Logix Clause Painter)
//////////////////////////////////////////////////////////////////////

If tab_1.tabpage_clause.ole_1.object.DocType <> 1 Then return //no word document opened

//--------Begin Modified by Alfee 05.25.2007---------------
//Open(w_clause_insnum)
////w_clause_insnum.of_set_parent(this)
//w_clause_insnum.of_set_object(tab_1.tabpage_clause.ole_1.object.ActiveDocument)
OpenwithParm(w_clause_insnum, 'clause')
//--------End Modified ---------------------------------------


end event

event pfc_cst_select();If tab_1.tabpage_browse.dw_browse.rowcount() < 1 Then Return

If tab_1.of_open_word_file() = 1 Then
	tab_1.selecttab(2)
End If


end event

event pfc_cst_clause_reference();//////////////////////////////////////////////////////////////////////
// $<event>pfc_cst_clause_reference of w_clause_painter()
// $<arguments>
//		None		
// $<returns> (None)
// $<description>Insert clause reference in document
//////////////////////////////////////////////////////////////////////
// $<add> 03.24.2007 by Alfee (Contract Logix Clause Painter)
//////////////////////////////////////////////////////////////////////
//---------Modified by alfee 04.17.2007----------
String ls_parm, ls_clauseid, ls_clausename, ls_bookmark, ls_text, ls_code
Oleobject lole_word, lole_field

IF tab_1.tabpage_clause.ole_1.object.DocType < 1 THEN RETURN	
	
Open(w_clause_reference)
ls_parm = Message.StringParm

IF Not IsNull(ls_parm) and Len(Trim(ls_parm)) > 0 THEN
	ls_clauseid = Left(ls_parm, Pos(ls_parm,"-") - 1)
	ls_clausename = Mid(ls_parm, Pos(ls_parm,"-") + 1)
	ls_bookmark = "clause_" + ls_clauseid 
	
	lole_word = tab_1.tabpage_clause.ole_1.object.activedocument
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_save,'enabled', True)	 //fix bug
	//-------Begin Added by Alfee 09.20.2007--------
	If w_mdi.of_security_access(6800) < 2 Then
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_save,'enabled', False)
	End If
	//-------End Added------------------------------
	Try 
		lole_field = lole_word.Fields.Add(lole_word.ActiveWindow.Selection.Range, wdFieldHyperlink, "\l " +ls_bookmark, True)
   	lole_field.Result.Text = "<<|"+ls_clausename+"|>>"
	Catch (Throwable th)
		MessageBox("Alert Message","Add clause reference field failed!")
		Destroy lole_word
		Destroy lole_field
	End Try
END IF

Destroy lole_word
Destroy lole_field

//String ls_parm
//Oleobject lole_word
//	
//Open(w_clause_reference)
//ls_parm = Message.StringParm
//
//IF Not IsNull(ls_parm) and Len(Trim(ls_parm)) > 0 THEN
//	IF tab_1.tabpage_clause.ole_1.object.DocType < 1 THEN RETURN 
//	lole_word = tab_1.tabpage_clause.ole_1.object.activedocument
//	lole_word.ActiveWindow.Selection.InsertAfter(ls_parm)
//	Destroy lole_word
//END IF
//
//-----------End modified-------------------------------------------
end event

event pfc_cst_insert_field();//////////////////////////////////////////////////////////////////////
// $<event>pfc_cst_insert_field of w_clause_painter()
// $<arguments>
//		None		
// $<returns> (None)
// $<description>Insert a selected field into the file
//////////////////////////////////////////////////////////////////////
// $<add> 04.18.2007 by Alfee (Contract Logix Clause Painter)
//////////////////////////////////////////////////////////////////////
long ll_export_id,ll_row
string ls_merge_field

ll_row = tab_1.tabpage_browse.dw_browse.getrow()
if ll_row < 1 then return

If tab_1.tabpage_clause.ole_1.object.DocType <> 1 Then return //no word document opened

ll_export_id = tab_1.tabpage_browse.dw_browse.getitemnumber(ll_row,"export_id")
if isnull(ll_export_id) then 
	//messagebox("IntelliSoftGroup","There isn't a related export id found, please check it firstly!")
	messagebox("Export ID Not Found","No related export ID was found. Please verify first!")
	return
end if

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 25/04/2007 By: Jervis
//$<reason> 
//openwithparm(w_agreement_template_merge_fields,ll_export_id)
str_pass lstr_pass
lstr_pass.s_long[1] = ll_export_id
lstr_pass.s_string = "CLAUSE"
openwithparm(w_agreement_template_merge_fields,lstr_pass)
//---------------------------- APPEON END ----------------------------

//w_agreement_template_merge_fields.of_set_parent(this)
//w_agreement_template_merge_fields.of_set_object(tab_1.tabpage_clause.ole_1.object.ActiveDocument)//commented by alfee 05.25.2007
end event

event pfc_cst_merge_data();//added by alfee 04.18.2007
string ls_name , ls_path , ls_source_file, ls_filename
long ll_row, ll_clause_id
integer li_export_id
oleobject lole_word
n_cst_word_utility lnv_word 

IF IsValid(w_agreement_template_merge_data) THEN Close(w_agreement_template_merge_data) //Alfee 09.19.2008

ll_row  = tab_1.tabpage_browse.dw_browse.getrow()
if ll_row < 1 then return 
li_export_id = tab_1.tabpage_browse.dw_browse.getitemnumber(ll_row,"export_id")
ll_clause_id = tab_1.tabpage_browse.dw_browse.getitemnumber(ll_row,"ctx_acp_clause_id")

lnv_word = Create n_cst_word_utility

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2009-07-22 By: Ken.Guo
//$<reason> Must get CTX ID, and single selected CTX for Merge data. 
//ls_source_file = lnv_word.of_run_export(li_export_id)
Long ll_ctx_id[]
String ls_master_contract_name
Openwithparm(w_mastert_contract_search,'ALL')
ls_master_contract_name = message.stringparm  
ll_ctx_id[1] = long(mid(ls_master_contract_name,1,pos(ls_master_contract_name,'-') - 1))  
If ll_ctx_id[1] <= 0 Then
	If isvalid(lnv_word) then destroy lnv_word
	If isvalid(lole_word) then destroy lole_word	
	Return 
End If
ls_source_file = lnv_word.of_run_export(li_export_id,ll_ctx_id[])
//---------------------------- APPEON END ----------------------------

if len(trim(ls_source_file)) < 1 then return

setpointer(HourGlass!)
IF not isvalid(w_export_progress) then Open(w_export_progress)			//Added By Mark Lee 05/29/2013
w_export_progress.hpb_bar.position = 100
w_export_progress.st_progress.text = "Merging Data"
w_export_progress.st_export.text = ""
w_export_progress.st_export1.text = ""
w_export_progress.hpb_1.stepit( )

this.setredraw(false)

if FileExists(is_agreement_path + "tem_2.doc") then
	FileDelete(is_agreement_path + "tem_2.doc")
end if
if FileExists(is_agreement_path + "tem_2_merged.doc") then
	FileDelete(is_agreement_path + "tem_2_merged.doc")
end if
	
//Save current document and copy to a temporary file
//ls_filename = is_agreement_path + "clause_" + string(ll_clause_id) + ".doc"
ls_filename = tab_1.inv_clause.of_generate_name( ll_clause_id) //Modified By Ken.Guo 2010-01-18

tab_1.tabpage_clause.ole_1.object.savetolocal(ls_filename, true)
FileCopy(ls_filename,is_agreement_path + "tem_2.doc",true)	
	
w_export_progress.hpb_1.stepit( )

lole_word = create oleobject
if lole_word.Connecttonewobject("word.application") <> 0 then
	IF isvalid( w_export_progress) THEN CLOSE(w_export_progress)
	messagebox('Client Error', 'This application could not connect to Microsoft Word. Please make sure it is properly installed.')
	If isvalid(lnv_word) then destroy lnv_word
	If isvalid(lole_word) then destroy lole_word
	return
end if 
w_export_progress.hpb_1.stepit( )

lole_word.visible = false
lole_word.Application.NormalTemplate.Saved = TRUE //Added By Ken.Guo 2008-07-22
lole_word.Application.Documents.Open(is_agreement_path + "tem_2.doc",false,true)
gnv_word_utility.of_modify_word_property( lole_word.Activedocument)	//Added By Mark Lee 06/20/2013 change for office 2013.
gnv_shell.of_delete_recent( "tem_2.doc", false) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
w_export_progress.hpb_1.stepit( )
String ls_error
lnv_word.of_refresh_reqmnt_fields(lole_word,ll_ctx_id[1],ls_error) //Added By Ken.Guo 2009-07-22.
w_export_progress.hpb_1.stepit( )

Try	
	
//Unprotect document if needed - Alfee 03.10.2008
lnv_word = Create n_cst_word_utility
//lnv_word.of_unprotect_doc(lole_word.ActiveDocument) 	
IF lnv_word.of_unprotect_doc(lole_word.ActiveDocument)  = -1 THEN //Alfee 10.08.2008
	IF isvalid( w_export_progress) THEN CLOSE(w_export_progress)
	f_word_destroy(lole_word,"")
	this.setredraw(true)
	If isvalid(lnv_word) then destroy lnv_word
	If isvalid(lole_word) then destroy lole_word	
	RETURN  
END IF	
gnv_word_utility.of_modify_word_property( lole_word.Activedocument)	//Added By Mark Lee 06/20/2013 change for office 2013.
lole_word.visible = false
lole_word.Application.NormalTemplate.Saved = TRUE //Alfee 01.17.2008
lole_word.ActiveDocument.MailMerge.OpenDataSource(ls_source_file)
gnv_shell.of_delete_recent( ls_source_file, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.

lole_word.ActiveDocument.MailMerge.DataSource.FirstRecord = 1
lole_word.ActiveDocument.MailMerge.DataSource.LastRecord = 100000
lole_word.ActiveDocument.Mailmerge.Destination = wdSendToNewDocument
lole_word.ActiveDocument.MailMerge.SuppressBlankLines = True
w_export_progress.hpb_1.stepit( )

//---------Begin added by alfee 04.30.2007 fix a bug-------
//0 -- not locked ; -1 -- all locked ; 99999 -- partly locked
If lole_word.ActiveDocument.Fields.Locked <> 0 Then
	lole_word.ActiveDocument.Fields.Locked = 0
End If
//---------End added by alfee 04.30.2007------------------

lole_word.ActiveDocument.Mailmerge.Execute
w_export_progress.hpb_1.stepit( )

//Save the merged file
lole_word.ActiveDocument.SaveAs(is_agreement_path + "tem_2_merged.doc",0,false,'',false)
gnv_shell.of_delete_recent( "tem_2_merged.doc", false) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
w_export_progress.hpb_1.stepit( )

Catch (Throwable th)
	IF isvalid( w_export_progress) THEN CLOSE(w_export_progress)
	//-------Begin Modified by Alfee 01.17.2008-----
	f_word_destroy(lole_word,"")
	/* lole_word.ActiveDocument.Close(wdDoNotSaveChanges)
	lole_word.Quit(wdDoNotSaveChanges)
	lole_word.DisconnectObject( )
	destroy lole_word */
	//-------End Modified -------------------------
	this.setredraw(true)
	If isvalid(lnv_word) then destroy lnv_word
	If isvalid(lole_word) then destroy lole_word
	RETURN //Alfee 09.19.2008	
End Try

//Quit Word application
lole_word.ActiveDocument.Close(wdDoNotSaveChanges)
lole_word.Quit(wdDoNotSaveChanges)
lole_word.DisconnectObject( )
If isvalid(lnv_word) then destroy lnv_word
If isvalid(lole_word) then destroy lole_word
w_export_progress.hpb_1.stepit( )

this.setredraw(true)
setpointer(HourGlass!)
//Display the merged data
IF isvalid( w_export_progress) THEN CLOSE(w_export_progress)

openwithparm(w_agreement_template_merge_data,is_agreement_path + "tem_2_merged.doc")




end event

event pfc_cst_analysis();//////////////////////////////////////////////////////////////////////
// $<event>pfc_cst_analysis
// $<arguments> (None)
// $<returns> (None)
// $<description> Analysis clause
//////////////////////////////////////////////////////////////////////
// $<add> 10.22.2007 by Evan
//////////////////////////////////////////////////////////////////////
long ll_FindRow
long ll_RowCount
long ll_ctx_acp_folder_id
long ll_ctx_acp_clause_id
long i, ll_ClauseRefCount
string ls_ctx_id
string ls_SQLSelect, ls_update_sql[]
DataStore lds_ClauseRef
DataWindow ldw_Browse
str_clause_painter_analysis_option		lstr_option			//Added By Mark Lee 03/25/2013
String 					ls_ctx_acp_clause_id
Decimal{1}			lde_revision
Long					ll_negotiated, ll_select, j, k , ll_maxposition, ll_insertrow				//Added By Mark Lee 03/26/2013

ib_status = False 					//Added By Mark Lee 04/02/2013
tab_1.of_collapse_all( ) //Added By Ken.Guo 2010-01-18.		

Open(w_clause_painter_analysis_option)				//Added By Mark Lee 03/25/2013
lstr_option = Message.powerobjectparm
If isvalid(lstr_option) = False  Then 
	Return 
End If 

If (lstr_option.as_full_analysis = 'Y')  or (lstr_option.as_full_analysis = 'N' and lstr_option.as_all_clauses = 'Y' ) Then 
	ldw_browse =tab_1.tabpage_browse.dw_clause_full_analysis
	ldw_browse.settransobject(sqlca)
	ldw_browse.SetSort("clause_name A")
	ldw_browse.Sort()
	ldw_browse.Retrieve( )	
Else 
	// Get folder and clause ID from Browse DW
	ldw_Browse = tab_1.tabpage_browse.dw_browse
End IF
ll_RowCount = ldw_Browse.RowCount()
if ll_RowCount > 0 then
	ll_ctx_acp_folder_id = ldw_Browse.GetItemNumber(1, "ctx_acp_folder_id")
	ll_ctx_acp_clause_id = ldw_Browse.GetItemNumber(1, "ctx_acp_clause_id")
else
	MessageBox("Prompt", "There is no caluse could analysis.")
	Return
end if
ll_maxposition = ll_RowCount										//Added By Mark Lee 04/09/2013

//// Select contract											//Added By Mark Lee 03/25/2013
//if of_SelectContract(ls_ctx_id) < 1 then Return
ls_ctx_id = ''
If lstr_option.as_full_analysis = 'N' and lstr_option.as_all_contracts = 'N' Then
	ls_ctx_id = lstr_option.as_ctx_id 
	// Get select statement
	ls_SQLSelect = &
		"SELECT " + &
		"  ctx_acp_clause_id, " + &
		"  temp_usage = (select count(*) from ctx_acp_template_clause where ctx_acp_clause_id = C.ctx_acp_clause_id), " + &
		"  dm_usage = (select count(*) " + &
		"						from ctx_am_document A, ctx_am_document_clause B " + &
		"						where A.doc_id = B.doc_id and " + &
		"								A.revision = B.revision and " + &
		"								B.ctx_acp_clause_id = C.ctx_acp_clause_id and " + &
		"								A.ctx_id in(" + ls_ctx_id + ")) " + &
		"FROM ctx_acp_clause C "
Else
		ls_SQLSelect = &
		"SELECT " + &
		"  ctx_acp_clause_id, " + &
		"  temp_usage = (select count(*) from ctx_acp_template_clause where ctx_acp_clause_id = C.ctx_acp_clause_id), " + &
		"  dm_usage = (select count(*) " + &
		"						from ctx_am_document A, ctx_am_document_clause B " + &
		"						where A.doc_id = B.doc_id and " + &
		"								A.revision = B.revision and " + &
		"								B.ctx_acp_clause_id = C.ctx_acp_clause_id ) " + &
		"FROM ctx_acp_clause C "
End If
	
////Added By Mark Lee 03/25/2013
//choose case tab_1.is_TreeItemType
//	case "FOLDER"
//		ls_SQLSelect += "WHERE C.ctx_acp_folder_id = "  + String(ll_ctx_acp_folder_id)
//	case "CLAUSE"
//		ls_SQLSelect += "WHERE C.ctx_acp_clause_id = " + String(ll_ctx_acp_clause_id)
//	case else
//end choose
If  lstr_option.as_full_analysis = 'N' and lstr_option.as_all_clauses = 'N' Then
	for i = 1 to ll_RowCount
		If ldw_Browse.IsSelected(i)  Then
			ll_ctx_acp_clause_id = ldw_Browse.GetItemNumber(i, "ctx_acp_clause_id")
			ls_ctx_acp_clause_id = ls_ctx_acp_clause_id + string(ll_ctx_acp_clause_id) +  ","
			ll_select ++
		End IF 
	Next
	If right(ls_ctx_acp_clause_id, 1) = "," then 
		ls_ctx_acp_clause_id = left(ls_ctx_acp_clause_id,len(ls_ctx_acp_clause_id) - 1)
	End If
	ls_SQLSelect += "WHERE C.ctx_acp_clause_id in(" + ls_ctx_acp_clause_id + ") "
	ll_maxposition = ll_select
End If 

// Open gifwait window
Open(iw_appeon_gifofwait)
Timer(0, iw_appeon_gifofwait)
iw_appeon_gifofwait.of_SetPosition(0)
iw_appeon_gifofwait.of_SetMinPosition(0)
iw_appeon_gifofwait.of_SetMaxPosition((ll_maxposition + 1) * 10)    //Added By Mark Lee 04/08/2013 need modify it (ll_maxposition + 1 )
iw_appeon_gifofwait.of_setstep(10)
// Retrieve clause reference count
iw_appeon_gifofwait.of_SetText("Analyzing, Please wait...")
lds_ClauseRef = Create DataStore
lds_ClauseRef.DataObject = "d_clause_usage"
lds_ClauseRef.SetTransObject(SQLCA)
lds_ClauseRef.SetSQLSelect(ls_SQLSelect)
ll_ClauseRefCount = lds_ClauseRef.Retrieve()
iw_appeon_gifofwait.of_SkipNextPosition(10)

of_delete_directory_file()						//Added By Mark Lee 03/26/2013		clean the directory 
// Set clause reference count to Browse DW
iw_appeon_gifofwait.of_SetText("Refreshing data, Please wait...")
//ldw_Browse.SetRedraw(false)				//Added By Mark Lee 04/17/2013	

k = 0
is_tmp_directory = 'tmp'+String(date(now()),'MMddyyyy')+String(time(now()),'hhmmss')

//msg
If not isvalid(ids_template_msg) Then 
	ids_template_msg = Create n_ds
	ids_template_msg.dataobject = 'd_template_msg'
	ids_template_msg.SetTransobject(sqlca)	
End If
ids_template_msg.reset()
ids_template_msg.accepttext( )

SetPointer(HourGlass!)
for i = 1 to ll_RowCount
	//Added By Mark Lee 03/26/2013
	If  lstr_option.as_full_analysis = 'N' and lstr_option.as_all_clauses = 'N' Then
		If ldw_Browse.IsSelected(i)  = False  Then
			Continue
		End IF 
	End If

	ll_insertrow = ids_template_msg.insertrow(0)
	ids_template_msg.SetItem(ll_insertrow,"name",ldw_Browse.GetItemString(i, "clause_full_name") )
	
	ll_ctx_acp_clause_id = ldw_Browse.GetItemNumber(i, "ctx_acp_clause_id")
	lde_revision = ldw_Browse.GetItemDecimal(i, "revision")
	ll_FindRow = lds_ClauseRef.Find("ctx_acp_clause_id=" + String(ll_ctx_acp_clause_id), 1, ll_ClauseRefCount)
	if ll_FindRow > 0 then
		k = 1 			//		k ++							//Added By Mark Lee 04/01/2013
		ib_status = False
		ls_update_sql[k]= " Update ctx_acp_clause Set "
		If lstr_option.as_template_usage = 'Y' Then
			ldw_Browse.SetItem(i, "temp_usage", lds_ClauseRef.object.temp_usage[ll_FindRow])
			ls_update_sql[k] = ls_update_sql[k] + " temp_usage =" +string(lds_ClauseRef.object.temp_usage[ll_FindRow]) + ", "
			If  lstr_option.as_full_analysis = 'Y' Then
//				ldw_Browse.SetItem(i, "temp_usage_last_date", date(now()))
				ls_update_sql[k] = ls_update_sql[k] + " temp_usage_last_date = getdate() , "				
			End If
		End IF
		If lstr_option.as_dm_usage = 'Y' Then
			ldw_Browse.SetItem(i, "dm_usage", lds_ClauseRef.object.dm_usage[ll_FindRow])
			ls_update_sql[k] = ls_update_sql[k] + " dm_usage =" +string(lds_ClauseRef.object.dm_usage[ll_FindRow]) + ", "
			If  lstr_option.as_full_analysis = 'Y' Then
//				ldw_Browse.SetItem(i, "dm_usage_last_date", date(now()))
				ls_update_sql[k] = ls_update_sql[k] + " dm_usage_last_date = getdate() , "					
			End If
		End IF 
		If lstr_option.as_negotiated = 'Y' Then 
			If  lstr_option.as_full_analysis = 'N' and lstr_option.as_all_clauses = 'N' Then
				j ++
				iw_appeon_gifofwait.of_SetText("Analyzing clause ("+ string(j)+'/'+string(ll_select)+")")    
			Else
				iw_appeon_gifofwait.of_SetText("Analyzing clause ("+string(i)+'/'+string(ll_RowCount)+")" )    
			End If
			ll_negotiated = of_negotiated_clause(ls_ctx_id,ll_ctx_acp_clause_id,lde_revision)		
			If ll_negotiated >= 0 and  ib_status = False  Then 
				ldw_Browse.SetItem(i, "negotiated", ll_negotiated )			 
				ls_update_sql[k] = ls_update_sql[k] + " negotiated =" +string(ll_negotiated) + ", "
//				If  lstr_option.as_full_analysis = 'Y' Then
					ldw_Browse.SetItem(i, "negotiated_last_date", date(now()))
					ls_update_sql[k] = ls_update_sql[k] + " negotiated_last_date = getdate() , "
//				End If
			Else
				ids_template_msg.SetItem(ll_insertrow,"result","Failure")
				k =   0 
				IF ib_status = True and lstr_option.abn_quit = True Then 
					Exit
				Else 
					iw_appeon_gifofwait.of_SkipNextPosition(10)
					Continue
				End IF 
			End IF
		End If
		IF right(ls_update_sql[k] ,2) = ", " Then
			ls_update_sql[k] = left(ls_update_sql[k],len(ls_update_sql[k]) - 2 )
			ls_update_sql[k] = ls_update_sql[k] + " Where ctx_acp_clause_id ="+string(ll_ctx_acp_clause_id)
			//commit by every times
			If gnv_string.of_execute_sql( ls_update_sql, "Update the Clause data","Updating...",False)	 = -1 Then 
				ids_template_msg.SetItem(ll_insertrow,"result","Failure")				
				IF ib_status = True and lstr_option.abn_quit = True Then 
					Exit
				Else 
					iw_appeon_gifofwait.of_SkipNextPosition(10)
					Continue
				End IF 
			End If 
		End If 
		ids_template_msg.SetItem(ll_insertrow,"result","Success")		
	else
//		ldw_Browse.SetItem(i, "temp_usage", 0) 
//		ldw_Browse.SetItem(i, "dm_usage", 0)
//		ldw_Browse.SetItem(i, "negotiated", 0)				//Added By Mark Lee 03/25/2013
		ids_template_msg.SetItem(ll_insertrow,"result","Success")			
	end if
	iw_appeon_gifofwait.of_SkipNextPosition(10)
next
//ldw_Browse.SetRedraw(true)
ldw_Browse.ResetUpdate()
Close(iw_appeon_gifofwait)
Destroy lds_ClauseRef

//IF k > 0 and  lstr_option.as_full_analysis  = 'Y' Then 
//	gnv_string.of_execute_sql( ls_update_sql, "Update the Clause data","Updating...")	 			
//End If

IF ib_status = False  and (lstr_option.as_full_analysis = 'Y')  Then 
//	Messagebox(gnv_app.iapp_object.DisplayName,'Clause analysis complete.')
	If lstr_option.as_template_usage = 'Y' Then
		gnv_user_option.of_Set_option_value( "intellisoft-super-master", "Last_Full_Clause_Analysis_date_for_temp_usage",string(date(now()),'MM/dd/yyyy')	 )  //(Appeon)Harry 05.28.2014 - V142 ISG-CLX  modify "contractlogix-super-master" to "intellisoft-super-master"
	End If 
	If lstr_option.as_dm_usage = 'Y' Then
		gnv_user_option.of_Set_option_value( "intellisoft-super-master", "Last_Full_Clause_Analysis_date_for_dm_usage",string(date(now()),'MM/dd/yyyy') )  //(Appeon)Harry 05.28.2014 - V142 ISG-CLX  modify "contractlogix-super-master" to "intellisoft-super-master"
	End If
	If lstr_option.as_negotiated = 'Y' Then 
		gnv_user_option.of_Set_option_value( "intellisoft-super-master", "Last_Full_Clause_Analysis_date_for_negotiated",string(date(now()),'MM/dd/yyyy') )  //(Appeon)Harry 05.28.2014 - V142 ISG-CLX  modify "contractlogix-super-master" to "intellisoft-super-master"
	End If 
	gnv_user_option.of_save( )	
//Else 
//	Messagebox(gnv_app.iapp_object.DisplayName,'Clause analysis failed.')
//	gnv_debug.of_output( True, 'Clause analysis failed.' + "~r~n Clause Id :"+string(ll_ctx_acp_clause_id) + " revision:"+string(lde_revision) )
End If 

SetPointer(arrow! )
If ids_template_msg.rowcount() > 0 Then 
	OpenWithParm(w_template_msg,ids_template_msg)
End IF 

If (lstr_option.as_full_analysis = 'Y')  or (lstr_option.as_full_analysis = 'N' and lstr_option.as_all_clauses = 'Y' ) Then 
	tab_1.tabpage_browse.cb_go.event clicked( )
End IF 



end event

event pfc_cst_print();//////////////////////////////////////////////////////////////////////
// $<event>pfc_cst_print
// $<arguments> (None)
// $<returns> (None)
// $<description> Print browse DW
//////////////////////////////////////////////////////////////////////
// $<add> 10.23.2007 by Evan
//////////////////////////////////////////////////////////////////////

tab_1.dynamic of_print() //Added By Ken.Guo 2010-01-12.

/*
if MessageBox("Print", "Are you sure you want to print browse data?", Question!, YesNo!) = 2 then Return

SetPointer(HourGlass!)
tab_1.tabpage_browse.dw_browse.print(false)
SetPointer(Arrow!)
*/
end event

event pfc_cst_compare();//Added by Alfee 10.18.2007 
tab_1.of_compare_clauses()
end event

event pfc_cst_insert_requirement();//////////////////////////////////////////////////////////////////////
// $<event>pfc_cst_insert_requirement()
// $<arguments>(None)
// $<returns> 
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2009-07-13 by Ken.Guo
//////////////////////////////////////////////////////////////////////

long ll_export_id,ll_row
string ls_merge_field

ll_row = tab_1.tabpage_browse.dw_browse.Getrow()
if ll_row < 1 then return

If tab_1.tabpage_clause.ole_1.object.DocType <> 1 Then return //no word document opened

str_ole_ctxid lstr_ole_ctxid
lstr_ole_ctxid.sole_word = tab_1.tabpage_clause.ole_1
lstr_ole_ctxid.sl_ctx_id = -1
Openwithparm(w_agreement_template_insert_requirement,lstr_ole_ctxid)

Return 
end event

event pfc_cst_copy();//jervis 10.10.2009 -- Copy Clause
tab_1.of_copy()


end event

event pfc_cst_checkin();tab_1.of_checkin( ) 
end event

event pfc_cst_checkout();tab_1.of_checkout()
end event

event pfc_cst_revision();tab_1.of_save(True)
end event

event pfc_cst_saveas();tab_1.of_saveas( )
end event

event pfc_cst_email();tab_1.of_email( )
end event

event pfc_cst_add_folder();Tab_1.of_add_folder()

end event

event pfc_cst_export_clause_single();tab_1.of_export_single( )
end event

event pfc_cst_export();Long ll_value


Open(w_export_clause_type_choose)

ll_value = Message.Doubleparm
If ll_value = 0 Then Return

If ll_value = 1 Then
	tab_1.of_export('DW')
ElseIf ll_value = 2 Then
	tab_1.of_export_single()	
End If

Return 
end event

event ue_auto_retrieve();//====================================================================
// Event: ue_auto_retrieve
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 07/18/12
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

tab_1.event ue_auto_retrieve( )
end event

event pfc_cst_batchupdatedoc();tab_1.Dynamic of_batchupdatedoc( )
end event

event pfc_cst_analysis_bak();//////////////////////////////////////////////////////////////////////
// $<event>pfc_cst_analysis
// $<arguments> (None)
// $<returns> (None)
// $<description> Analysis clause
//////////////////////////////////////////////////////////////////////
// $<add> 10.22.2007 by Evan			//Added By Mark Lee 03/25/2013
//////////////////////////////////////////////////////////////////////
long ll_FindRow
long ll_RowCount
long ll_ctx_acp_folder_id
long ll_ctx_acp_clause_id
long i, ll_ClauseRefCount
string ls_ctx_id
string ls_SQLSelect
DataStore lds_ClauseRef
DataWindow ldw_Browse

tab_1.of_collapse_all( ) //Added By Ken.Guo 2010-01-18.

// Get folder and clause ID from Browse DW
ldw_Browse = tab_1.tabpage_browse.dw_browse
ll_RowCount = ldw_Browse.RowCount()
if ll_RowCount > 0 then
	ll_ctx_acp_folder_id = ldw_Browse.GetItemNumber(1, "ctx_acp_folder_id")
	ll_ctx_acp_clause_id = ldw_Browse.GetItemNumber(1, "ctx_acp_clause_id")
else
	MessageBox("Prompt", "There is no caluse could analysis.")
	Return
end if

// Select contract
if of_SelectContract(ls_ctx_id) < 1 then Return

// Get select statement
ls_SQLSelect = &
	"SELECT " + &
	"  ctx_acp_clause_id, " + &
	"  temp_usage = (select count(*) from ctx_acp_template_clause where ctx_acp_clause_id = C.ctx_acp_clause_id), " + &
	"  dm_usage = (select count(*) " + &
	"						from ctx_am_document A, ctx_am_document_clause B " + &
	"						where A.doc_id = B.doc_id and " + &
	"								A.revision = B.revision and " + &
	"								B.ctx_acp_clause_id = C.ctx_acp_clause_id and " + &
	"								A.ctx_id in(" + ls_ctx_id + ")) " + &
	"FROM ctx_acp_clause C "
choose case tab_1.is_TreeItemType
	case "FOLDER"
		ls_SQLSelect += "WHERE C.ctx_acp_folder_id = "  + String(ll_ctx_acp_folder_id)
	case "CLAUSE"
		ls_SQLSelect += "WHERE C.ctx_acp_clause_id = " + String(ll_ctx_acp_clause_id)
	case else
end choose

// Open gifwait window
Open(w_appeon_gifofwait)
Timer(0, w_appeon_gifofwait)
w_appeon_gifofwait.of_SetPosition(0)
w_appeon_gifofwait.of_SetMinPosition(0)
w_appeon_gifofwait.of_SetMaxPosition(ll_RowCount + 1)

// Retrieve clause reference count
w_appeon_gifofwait.of_SetText("Analyzing...")
lds_ClauseRef = Create DataStore
lds_ClauseRef.DataObject = "d_clause_usage"
lds_ClauseRef.SetTransObject(SQLCA)
lds_ClauseRef.SetSQLSelect(ls_SQLSelect)
ll_ClauseRefCount = lds_ClauseRef.Retrieve()
w_appeon_gifofwait.of_SkipNextPosition(1)

// Set clause reference count to Browse DW
w_appeon_gifofwait.of_SetText("Refreshing data...")
ldw_Browse.SetRedraw(false)
for i = 1 to ll_RowCount
	ll_ctx_acp_clause_id = ldw_Browse.GetItemNumber(i, "ctx_acp_clause_id")
	ll_FindRow = lds_ClauseRef.Find("ctx_acp_clause_id=" + String(ll_ctx_acp_clause_id), 1, ll_ClauseRefCount)
	if ll_FindRow > 0 then
		ldw_Browse.SetItem(i, "temp_usage", lds_ClauseRef.object.temp_usage[ll_FindRow])
		ldw_Browse.SetItem(i, "dm_usage", lds_ClauseRef.object.dm_usage[ll_FindRow])
	else
		ldw_Browse.SetItem(i, "temp_usage", 0)
		ldw_Browse.SetItem(i, "dm_usage", 0)
	end if
	w_appeon_gifofwait.of_SkipNextPosition(1)
next
ldw_Browse.SetRedraw(true)
ldw_Browse.ResetUpdate()
Close(w_appeon_gifofwait)

Destroy lds_ClauseRef
end event

public function integer of_ltrimword ();integer li_count, i, li_length, j, li_asc, li_todelete[], k
string ls_content, ls_char
boolean lb_deleteit

li_count = tab_1.tabpage_clause.ole_1.object.ActiveDocument.Paragraphs.count
for i = 1 to li_count
	ls_content = tab_1.tabpage_clause.ole_1.object.ActiveDocument.Paragraphs[i].range.text
	ls_content = trim( ls_content )
	
	li_length = Len( ls_content )
	lb_deleteit = True
	for j = 1 to li_length
		ls_char = Mid( ls_content, j, 1 )
		//li_asc = ASC( ls_char )
		
		if pos("~n~t~v~r~f", ls_char ) > 0 then
			continue;
		else
			lb_deleteit = False
			exit
		end if
	next
	
	if lb_deleteit then
		k++
		li_todelete[k] = i
	else
		exit;
	end if
next

li_count = Upperbound( li_todelete )
for i = li_count to 1 step -1
	j = li_todelete[i]
	tab_1.tabpage_clause.ole_1.object.ActiveDocument.Paragraphs[j].range.delete()
next

return li_count;
end function

public function integer of_rtrimword ();integer li_count, i, li_length, j, li_asc, k
string ls_content, ls_char
boolean lb_deleteit

li_count = tab_1.tabpage_clause.ole_1.object.ActiveDocument.Paragraphs.count
for i = li_count to 1 step -1
	ls_content = tab_1.tabpage_clause.ole_1.object.ActiveDocument.Paragraphs[i].range.text
	ls_content = trim( ls_content )
	
	li_length = Len( ls_content )
	lb_deleteit = True
	for j = 1 to li_length
		ls_char = Mid( ls_content, j, 1 )
		//li_asc = ASC( ls_char )
		
		if pos("~n~t~v~r~f", ls_char ) > 0 then
			continue;
		else
			lb_deleteit = False
			exit
		end if
	next
	
	if lb_deleteit then
		tab_1.tabpage_clause.ole_1.object.ActiveDocument.Paragraphs[i].range.delete()
		k++;
	else
		exit;
	end if
next

return k;
end function

public function integer of_check_numbering ();//////////////////////////////////////////////////////////////////////
// $<function>w_clause_painter.of_check_numbering()
// $<arguments>	(none)	
// $<returns> integer
// $<description>Check the numbering in clause document
//////////////////////////////////////////////////////////////////////
// $<add> 03.07.2006 by Alfee (Contract Logix Agreement Clause Painter)
//////////////////////////////////////////////////////////////////////
//Remark: This function is obsolete. by alfee 04.20.2007

//WdFindWrap
Constant int wdFindAsk = 2 
Constant int wdFindContinue = 1 
Constant int wdFindStop = 0 
//WdReplace
Constant int wdReplaceAll = 2 
Constant int wdReplaceNone = 0 
Constant int wdReplaceOne = 1 

String is_chapter[] = {"##","@@"}
String is_paragraph = "#.0"
String is_section = "#.#"
Boolean lb_found_chapter[] = {false,false}
Boolean lb_found_paragraph = false 
Boolean lb_found_section = false
Boolean lb_found = false
Long ll_pos_chapter, ll_pos_paragraph,ll_pos_section
Oleobject lole_word

if tab_1.tabpage_clause.ole_1.object.DocType < 1 then return -1
lole_word = tab_1.tabpage_clause.ole_1.object.activedocument


//--------------------------- APPEON BEGIN ---------------------------
//$<add> 26-03-2007 By: Ken.Guo
//$<reason> Add check numbering "#.?" ,
//If it is equal #.[1-9],it is invalid;
//If it is not equal #.# or #.0, it is invalid.
string ls_text
lole_word.content.select()
lole_word.activewindow.selection.find.ClearFormatting()
lb_found =  lole_word.activewindow.selection.find.Execute("#.?", false, true, true, false, false, true, wdFindStop, false, "", wdReplaceNone )
If lb_found Then 
	ll_pos_section = lole_word.activewindow.selection.start
	ls_text = lole_word.activewindow.selection.text
	//Check whether existing #.1 - #.9
	if match(ls_text ,'#.[1-9]') then
		MessageBox("Alert","#.1-9 is an invalid auto number format!",Exclamation!)
		Return -1	
	//Check whether existing #.# or #.0	
	elseif ls_text <> is_paragraph and ls_text <> is_section then
		MessageBox("Alert",ls_text + " is an invalid auto number format!",Exclamation!)
		return -1
	end if
End If
//---------------------------- APPEON END ----------------------------

//Check whether existing #.# but without #.0, or existing #.# but without ## above it
//Find section (#.#)
lole_word.content.select()
lole_word.activewindow.selection.find.ClearFormatting()
lb_found_section =  lole_word.activewindow.selection.find.Execute(is_section, false, true, false, false, false, true, wdFindStop, false, "", wdReplaceNone )
If lb_found_section Then 
	ll_pos_section = lole_word.activewindow.selection.start
End If

//Find & check paragraph (#.0)
lole_word.content.select()
lole_word.activewindow.selection.find.ClearFormatting()
lb_found_paragraph = lole_word.activewindow.selection.find.Execute(is_paragraph, false, true, false, false, false, true, wdFindStop, false, "", wdReplaceNone )
ll_pos_paragraph = lole_word.activewindow.selection.start
If lb_found_section Then // If section(#.#) found
	If Not lb_found_paragraph Then  //If paragraph(#.0) not found
		lole_word.Range(0,0).select() //by alfee at 03.13.2007			
  	 	//MessageBox("Alert","The auto number " + is_paragraph +" is missed!",Exclamation!)
   	MessageBox("Alert","The auto number " + is_paragraph +" is missing!",Exclamation!)
		Return -1
	Else //If paragraph(#.0) found
		If ll_pos_section < ll_pos_paragraph Then
			lole_word.Range(0,0).select() //by alfee at 03.13.2007						
			MessageBox("Alert","The auto number format is out of order!",Exclamation!)
   		Return -1
	 	End If
	End If
End If

//Find chapter (## or @@) if paragraph #.0 found
If lb_found_paragraph then 
 	lole_word.content.select()
	lole_word.activewindow.selection.find.ClearFormatting()
	lb_found_chapter[1] = lole_word.activewindow.selection.find.Execute(is_chapter[1], false, true, false, false, false, true, wdFindStop, false, "", wdReplaceNone )	
	If Not lb_found_chapter[1] Then //If ## not found
 	 	lole_word.content.select()
		lole_word.activewindow.selection.find.ClearFormatting()
		lb_found_chapter[2] = lole_word.activewindow.selection.find.Execute(is_chapter[2], false, true, false, false, false, true, wdFindStop, false, "", wdReplaceNone )				
		If not lb_found_chapter[2] Then //If @@ also not found
			lole_word.Range(0,0).select() //by alfee at 03.13.2007
  			//MessageBox("Alert","The auto number " + is_chapter[1] +" is missed!",Exclamation!)
			MessageBox("Alert","The auto number " + is_chapter[1] +" is missing!",Exclamation!)
			Return -1
		End if
	End If
	If lb_found_chapter[1] or lb_found_chapter[2] Then // If any chapter(## or @@) found
	 	ll_pos_chapter = lole_word.activewindow.selection.start
		If ll_pos_paragraph < ll_pos_chapter Then
			lole_word.Range(0,0).select() //by alfee at 03.13.2007			
			MessageBox("Alert","The auto number format is out of order!",Exclamation!)
			Return -1
	 	End If	
	End If	
End If

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 26-03-2007 By: Ken.Guo
//$<reason> #.1-9 is checked at first.So comment it.

/*
//Check whether existing #.1 - #.9 
lole_word.content.select()
lole_word.activewindow.selection.find.ClearFormatting()
lb_found = lole_word.activewindow.selection.find.Execute("#.[1-9]", false, true, true, false, false, true, wdFindStop, false, "", wdReplaceNone )	
If lb_found Then 
	MessageBox("Alert","#.1-9 is an invalid auto number format!",Exclamation!)
	Return -1
End If
*/
//---------------------------- APPEON END ----------------------------
lole_word.Range(0,0).select()
Return 1
end function

public function integer of_changetitle ();Long ll_row
String ls_clause_name

ll_row = tab_1.tabpage_browse.dw_browse.GetRow()
IF ll_row > 0 THEN
	ls_clause_name = tab_1.tabpage_browse.dw_browse.GetItemString(ll_row, "clause_name")
	this.title = "Clause Library Painter" + " - " + ls_clause_name
ELSE
	this.title = "Clause Library Painter"	
END IF

RETURN 1
end function

public function integer of_selectcontract (ref string as_ctx_id);//////////////////////////////////////////////////////////////////////
// $<function>of_selectcontract()
// $<arguments>
// $		ref as_ctx_id
// $<returns> integer
// $<description> Select contract
//////////////////////////////////////////////////////////////////////
// $<add> 10.22.2007 by Evan
//////////////////////////////////////////////////////////////////////
string ls_Temp
string ls_ctxid
string ls_Return
long ll_Count
integer li_Position, i

as_ctx_id = ""
Open(w_rpt_contract_search)
ls_Return = Message.StringParm
if ls_Return = "" then Return -1

do
	ls_Temp = f_get_token(ls_Return, "|")
	li_Position = Pos(ls_Temp, "~t")
	ls_ctxid = Left(ls_Temp, li_Position - 1)
		
	if as_ctx_id <> "" then as_ctx_id += ","
	as_ctx_id += ls_ctxid
	
	ll_Count ++
loop while ls_Return <> ""

Return ll_Count
end function

public subroutine of_delete_directory_file ();//====================================================================
// Function: of_delete_directory_file
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 04/19/2013
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
Integer 		li_cnt, li_entries
String 		ls_import,ls_currdir
long 			ll_i,	ll_Rtn

//n_cst_dirattrib lnv_dirlist[]
//SetPointer(HourGlass!)
//
//n_cst_filesrvwin32 lnv_filesrv
//lnv_filesrv = create n_cst_filesrvwin32
//
//ls_currdir = gs_dir_path + gs_DefDirName + "\Negotiated\*.*"
//li_entries = lnv_filesrv.of_DirList(ls_currdir, 0, lnv_dirlist)
//
//for ll_i = 1 to upperbound(lnv_dirlist)
//    FileDelete ( gs_dir_path + gs_DefDirName + "\Negotiated\" + lnv_dirlist[ll_i].is_filename )
//next
//
//Destroy lnv_filesrv
//SetPointer(arrow! )

n_cst_filesrv inv_filesrv

//SetPointer(HourGlass!)
f_SetFileSrv(inv_filesrv,TRUE)
//ls_TempDir = gs_dir_path + gs_DefDirName + "\Agreement"
ls_currdir = gs_dir_path + gs_DefDirName +"\Negotiated"
ll_Rtn = inv_filesrv.of_deltree(ls_currdir, False)
Destroy inv_filesrv
//SetPointer(arrow! )
end subroutine

public function long of_negotiated_clause (string as_ctx_id, long al_clause_id, decimal ade_revision);//====================================================================
// Function: of_negotiated_clause
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                as_ctx_id
//                al_clause_id
//                ade_revision
//--------------------------------------------------------------------
// Returns:  long (the negotiated times)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 03/26/2013
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
String 			ls_file_clause_name,		ls_SQLSelect, 	ls_filter, ls_file_document_name
n_ds				lds_filter_contract	
Long 				ll_rowcount_contract, ll_return, i , ll_file_count, ll_doc_id, ll_ctx_id
Decimal{1}		lde_revision
String 			ls_merge_file, ls_text, ls_msg

ll_return = 0 
//get the clause document.
If of_download_file(al_clause_id,ade_revision,ls_file_clause_name,'clause') <> 1 Then 
	Return  ll_return
End IF 

IF as_ctx_id = '' Then 
		ls_SQLSelect = &
		" Select distinct A.ctx_id, A.doc_id, A.revision	 " + &
		"						from ctx_am_document A, ctx_am_document_clause B, ctx_acp_clause C  " + &
		"						where A.doc_id = B.doc_id and " + &
		"								A.revision = B.revision and " + &
		"								B.ctx_acp_clause_id = C.ctx_acp_clause_id and " + & 
		"								C.ctx_acp_clause_id = " +string(al_clause_id) +" and "+ &
		"								A.doc_ext = 'doc' and " + &
		"								C.revision = " + string(ade_revision) + " Order by A.ctx_id, A.doc_id "
Else 
	ls_SQLSelect = &
		" Select distinct A.ctx_id, A.doc_id, A.revision	 " + &
		"						from ctx_am_document A, ctx_am_document_clause B, ctx_acp_clause C  " + &
		"						where A.doc_id = B.doc_id and " + &
		"								A.revision = B.revision and " + &
		"								B.ctx_acp_clause_id = C.ctx_acp_clause_id and " + & 
		"								A.doc_ext = 'doc' and " + &
		"								C.ctx_acp_clause_id = " +string(al_clause_id) +" and "+ &
		"								C.revision = " + string(ade_revision) + " and " + &
		"								A.ctx_id in(" + as_ctx_id + ")  Order by A.ctx_id, A.doc_id "
End If

lds_filter_contract = Create  n_ds
lds_filter_contract.dataobject = 'd_clause_painter_negotiated'
lds_filter_contract.settransobject(sqlca)
lds_filter_contract.SetSQLSelect(ls_SQLSelect)
ll_rowcount_contract = lds_filter_contract.Retrieve()

ls_msg = ''
IF ll_rowcount_contract > 0 Then 
	For i = 1 to ll_rowcount_contract
      	Yield()
		ll_doc_id = lds_filter_contract.GetItemNumber(i, "doc_id")
		lde_revision = lds_filter_contract.GetItemDecimal( i, "revision")
		ll_ctx_id  = lds_filter_contract.GetItemNumber(i, "ctx_id")
		//comment
		If isvalid(iw_appeon_gifofwait) Then
			ls_text  =	iw_appeon_gifofwait.of_gettext( )		
			If Pos(ls_text,'/') > 0 and Pos(ls_text,')') > 0 Then 
				ls_msg = Left(ls_text, Pos(ls_text,')') )
			Else
				ls_msg = ls_text
			End If 
			iw_appeon_gifofwait.of_SetText(ls_msg + " in document"+" ("+string(i)+"/"+string(ll_rowcount_contract)+"), Please wait...")
		End If
		If of_download_file(ll_doc_id,lde_revision,ls_file_document_name,'document') <> 1 Then 			
			continue
		Else
//			If ls_msg <> '' Then
//				iw_appeon_gifofwait.of_SkipNextPosition(10)
//				iw_appeon_gifofwait.of_SetText(ls_msg + " negotiating data...merging"+' ('+string(i)+'/'+string(ll_rowcount_contract)+')')
//			End If
			//unmergedata
			If of_unmergedata(ll_ctx_id,ll_doc_id,lde_revision,ls_file_document_name,ls_merge_file) < 0 Then 
				ll_return =  - 1
				Exit
			End IF 
//			If ls_msg <> '' Then
//				iw_appeon_gifofwait.of_SkipNextPosition(10)
//				iw_appeon_gifofwait.of_SetText(ls_msg + " negotiating data...comparing"+' ('+string(i)+'/'+string(ll_rowcount_contract)+')')
//			End If
			//find the clause		ls_merge_file d_dm_clause_map
			ll_file_count = of_compare_doc(al_clause_id,ll_doc_id,ls_file_clause_name,ls_merge_file)
//			ll_file_count = of_compare_doc_original(al_clause_id,ll_doc_id,ls_file_clause_name,ls_merge_file)
			
			IF ll_file_count >= 0 Then 
				ll_return  = ll_return + ll_file_count
			Else
				ll_return = - 1 
				Exit
			End If 
//			If ls_msg <> '' Then
//				iw_appeon_gifofwait.of_SkipNextPosition(10)
//			End If
		End IF 
//		If ls_msg <> '' Then
//			iw_appeon_gifofwait.of_SkipNextPosition(10)
//		End If
	Next
End If 

return ll_return

end function

public function integer of_download_file (long al_clause_id, decimal adec_revision, ref string as_filename, string as_type);//====================================================================
// Function: of_download_file
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                al_clause_id
//                adec_revision
//                as_filename
//                as_type
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 03/29/2013
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
long 		ll_getupdate,ll_data_length,li_loops,li_counter,ll_start,ll_BlobLen
Long 		ll_CurrentPos,li_Cnt
Blob 		lb_all_data,lb_data,lblb_Data
Integer 	li_FileNum,li_Writes, li_return
String 	ls_download_file
OleObject 		lole_save

ls_download_file = ''
If Not DirectoryExists(gs_dir_path + gs_DefDirName + "\Negotiated\") Then
	gnv_appeondll.of_parsepath(gs_dir_path + gs_DefDirName + "\Negotiated\")
End If
If Not DirectoryExists(gs_dir_path + gs_DefDirName + "\Negotiated\"+is_tmp_directory+"\") Then
	gnv_appeondll.of_parsepath(gs_dir_path + gs_DefDirName + "\Negotiated\"+is_tmp_directory+"\")
End If

CHoose Case as_type
	Case 'clause'
		as_filename = gs_dir_path + gs_DefDirName + "\Negotiated\"+is_tmp_directory+"\N_clause_" + string(al_clause_id) + '.' + String(adec_revision) +  ".doc"
		If tab_1.inv_clause.of_download_file( al_clause_id, adec_revision, ls_download_file) < 0 Then
			ib_status = True
			gnv_debug.of_output( True,"Failed to download the clause file. ~r~n syntax:tab_1.inv_clause.of_download_file( al_clause_id, adec_revision, ls_download_file)"+":clause id"+string(al_clause_id)+" :revision"+string(adec_revision))
			Messagebox('Clause','Failed to download the clause file, please call support.')
			Return -1
		End If	

	Case 'document'
		as_filename = gs_dir_path + gs_DefDirName + "\Negotiated\"+is_tmp_directory+"\N_document_original_" + string(al_clause_id) + '.' + String(adec_revision) +  ".doc"		
		ls_download_file = inv_dm_utils.of_download_file( al_clause_id, adec_revision)

End Choose 

If Fileexists(ls_download_file) Then
	lole_save = Create OleObject
	IF lole_save.Connecttonewobject("word.application") <> 0 THEN
		ib_status = True
		gnv_debug.of_output( True,"Could not connect to Microsoft Word. Please make sure it is properly installed. ~r~n syntax:of_download_file( ) ") 
		Destroy lole_save					
		RETURN -1
	END IF
	lole_save.Application.NormalTemplate.Saved = TRUE  
	lole_save.Application.Documents.Open(ls_download_file, False, True) 	
	gnv_word_utility.of_modify_word_property( lole_save.Activedocument)	//Added By Mark Lee 06/20/2013 change for office 2013.
	gnv_shell.of_delete_recent( ls_download_file, true) //  Delete Windows Recent Document.
	
	lole_save.ActiveDocument.SaveAs(as_filename, 0,false,'',false)
	gnv_shell.of_delete_recent( as_filename, true) // Delete Windows Recent Document.			
	
	lole_save.ActiveDocument.Close(wdDoNotSaveChanges)
	lole_save.Quit(wdDoNotSaveChanges)
	lole_save.DisconnectObject( )
	destroy lole_save
Else
	ib_status = True
	Return -1
End IF 

//Begin - Added By Mark Lee 05/29/2013 adjust the document protected property
li_return = 0 
n_cst_word_utility 		ln_cst_word_utility
ln_cst_word_utility  = Create n_cst_word_utility
li_return = ln_cst_word_utility.of_unprotect_doc_file( as_filename)
Destroy ln_cst_word_utility
If li_return < 0 Then 
	ib_status = True
	Return -1
End If 
//End - Added By Mark Lee 05/29/2013

Return 1
/*
If Not fileexists(as_filename) Then
	If  appeongetclienttype() <> 'PB' Then		
		IF as_type = 'clause' Then
			SELECTBLOB image_file INTO :lb_all_data
			  FROM ctx_acp_clause_image WHERE clause_id = :al_clause_id and revision = :adec_revision;
		Else
			SELECTBLOB image_file
				INTO :lb_all_data
				FROM ctx_am_doc_image  WHERE doc_id = :al_clause_id AND revision = :adec_revision and doc_ext = 'doc' ;
		End IF
	Else			
		IF as_type = 'clause' Then 
			SELECT Datalength(image_file) INTO :ll_data_length
			  FROM ctx_acp_clause_image WHERE clause_id = :al_clause_id and revision = :adec_revision;
		Else
			SELECT Datalength(image_file) INTO :ll_data_length
			  FROM ctx_am_doc_image WHERE doc_id = :al_clause_id and revision = :adec_revision and doc_ext = 'doc';
		End IF
		
		If isnull(ll_data_length) Then ll_data_length = 0
		If ll_data_length > 8000 Then 
			If Mod(ll_data_length,8000) = 0 Then
				li_loops = ll_data_length /8000 
			Else
				li_loops = (ll_data_length /8000) + 1 
			End If 
		ElseIf ll_data_length > 0 Then 
			li_loops = 1 
		End If 
		
		For li_counter = 1 To li_loops				
			ll_start = (li_counter - 1) * 8000 + 1
			IF as_type = 'clause' Then 
				SELECTBLOB substring(image_file,:ll_start,8000) INTO :lb_data
				  FROM ctx_acp_clause_image WHERE clause_id = :al_clause_id and revision = :adec_revision;	
			Else
				SELECTBLOB substring(image_file,:ll_start,8000) INTO :lb_data
				  FROM ctx_am_doc_image WHERE doc_id = :al_clause_id and revision = :adec_revision and doc_ext = 'doc';	
			End If
			lb_all_data += lb_data
		Next 
	End If
	If isnull(lb_all_data) Then lb_all_data = blob('')
	If Len(lb_all_data) < 1 Then 
		as_filename = ''
		Return -1	 	
	End If
	
	li_FileNum = FileOpen(as_filename , StreamMode! ,Write!,Shared!, Replace!)
	If li_FileNum = -1 Then 
		as_filename = ''
		Return -1
	End If
		
	ll_BlobLen = Len(lb_all_data)
	If ll_BlobLen > 32765 Then
		If Mod(ll_BlobLen, 32765) = 0 Then
			li_Writes = ll_BlobLen / 32765
		Else
			li_Writes = (ll_BlobLen / 32765) + 1
		End If
	 Else
		li_Writes = 1
	End If
	
	ll_CurrentPos = 1
	
	For li_Cnt = 1 To li_Writes
		lblb_Data = BlobMid(lb_all_data, ll_CurrentPos, 32765)
		ll_CurrentPos += 32765
		If FileWrite(li_FileNum, lblb_Data) = -1 Then
			as_filename = ''
			Return -1
		End If
	Next
	
	FileClose(li_FileNum)

End If	
Return 1
*/

end function

public function integer of_unmergedata (long al_ctx_id, long al_doc_id, decimal adec_revision, string as_open_file, ref string as_merge_file);//====================================================================
// Function: of_mergedata
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                al_ctx_id
//                al_doc_id
//                adec_revision
//                as_open_file
//                as_merge_file
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 03/28/2013
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
String 			ls_source_file, ls_merge_tmp_file
Boolean	 		lb_need_merged
Long				i , ll_cnt, ll_export_id
OLEObject 		lole_word
n_cst_ovole_utils 		lnv_ole_utils_doc

//Setpointer(Hourglass!)
IF Len(Trim(as_open_file)) < 1  THEN RETURN -1

//Get export id for merging	
Select ctx_acp_template.export_id Into :ll_export_id
  From ctx_am_document,ctx_acp_template
 Where ctx_am_document.doc_id = :al_doc_id
  And ctx_am_document.from_templete_id = ctx_acp_template.ctx_acp_template_id;

ls_merge_tmp_file = gs_dir_path + gs_DefDirName + "\Negotiated\"+is_tmp_directory+"\document_unmerge_" + string(al_doc_id) + '.' + String(adec_revision) +  ".doc"		

//Create a new Word object	and open the Word document which need to be merged.
lole_word = Create oleobject
IF lole_word.Connecttonewobject("word.application") <> 0 THEN
	ib_status = True
	Destroy lole_word  
	gnv_debug.of_output( True, 'Could not connect to Microsoft Word. Please make sure it is properly installed.'+"File name:"+ls_merge_tmp_file+" ~r~n ctx id:"+string(al_ctx_id)+ " doc id:"+string(al_doc_id))
	Messagebox('Client Error', 'Could not connect to Microsoft Word. Please make sure it is properly installed.')
	RETURN -1
END IF

TRY
	lole_word.Application.NormalTemplate.Saved = TRUE  
	lole_word.Application.Documents.Open(as_open_file,false,true)	
	gnv_word_utility.of_modify_word_property( lole_word.Activedocument)	//Added By Mark Lee 06/20/2013 change for office 2013.
	gnv_shell.of_delete_recent( as_open_file, true) // Delete Windows Recent Document.			
	//comment
//	If isvalid(iw_appeon_gifofwait) Then
//		iw_appeon_gifofwait.of_SkipNextPosition(10)
//	End If
	
	IF not isvalid(inv_word_util) Then 
		inv_word_util = create n_cst_word_utility
	End If 
	//Unprotect document if needed 
	//inv_word_util.of_unprotect_doc(lole_word.ActiveDocument) 
	IF inv_word_util.of_unprotect_doc(lole_word.ActiveDocument) = -1 THEN  
		ib_status = True
		gnv_debug.of_output( True, 'Merge data in document failed!. syntax:inv_word_util.of_unprotect_doc(lole_word.ActiveDocument)'+"File name:"+as_open_file+" ~r~n  ctx id:"+string(al_ctx_id)+ " doc id:"+string(al_doc_id))
		lole_word.ActiveDocument.Close(wdDoNotSaveChanges)
		lole_word.Quit(wdDoNotSaveChanges)
		lole_word.DisconnectObject( )
		destroy lole_word
		destroy inv_word_util
		RETURN -1
	END IF		
	lole_word.ActiveDocument.TrackRevisions = false

	//Check whether this document need to be merged
	IF lole_word.ActiveDocument.Fields.Count < 1 THEN
		as_merge_file = as_open_file							//be abled to use the word
		lole_word.ActiveDocument.Close(wdDoNotSaveChanges)
		lole_word.Quit(wdDoNotSaveChanges)
		lole_word.DisconnectObject( )
		destroy lole_word
		destroy inv_word_util
		RETURN 0
	End If
	
	IF isnull(is_export_file) or is_export_file = '' Then  
		//Generate source file
//		n_cst_ovole_utils lnv_ole_utils_doc
		lnv_ole_utils_doc = Create n_cst_ovole_utils
		is_export_file = lnv_ole_utils_doc.of_runexport(ll_export_id, al_ctx_id)
		Destroy lnv_ole_utils_doc
		//comment
//		If isvalid(iw_appeon_gifofwait) Then
//			iw_appeon_gifofwait.of_SkipNextPosition(10)
//		End If
		IF Not FileExists(is_export_file) THEN //keep last export info
			is_export_file = ''
			ib_status = True
			gnv_debug.of_output( True, 'Merge data in document failed!. syntax: Not FileExists(ls_source_file)'+"File name:"+ls_source_file+" ~r~n  ctx id:"+string(al_ctx_id)+ " doc id:"+string(al_doc_id))	
			lole_word.ActiveDocument.Close(wdDoNotSaveChanges)
			lole_word.Quit(wdDoNotSaveChanges)
			lole_word.DisconnectObject( )
			destroy lole_word
			destroy inv_word_util
			RETURN -1
		END IF			
	End IF 

	//Open source file and merge data in the temporary file
//	lole_word.ActiveDocument.MailMerge.MainDocumentType = wdFormLetters
	lole_word.ActiveDocument.MailMerge.MainDocumentType = 0
//	lole_word.ActiveDocument.MailMerge.OpenDataSource(ls_source_file)
//	gnv_shell.of_delete_recent( ls_source_file, true) // Delete Windows Recent Document.
	lole_word.ActiveDocument.MailMerge.OpenDataSource(is_export_file)
	gnv_shell.of_delete_recent( is_export_file, true) // Delete Windows Recent Document.
	lole_word.ActiveDocument.MailMerge.SuppressBlankLines = True
	
//	//comment
//	If isvalid(iw_appeon_gifofwait) Then
//		iw_appeon_gifofwait.of_SkipNextPosition(10)
//	End If

	//0 -- not locked ; -1 -- all locked ; 99999 
	If lole_word.ActiveDocument.Fields.Locked <> 0 Then
		lole_word.ActiveDocument.Fields.Locked = 0
	End If

	//Update Fileds value
	inv_word_util.of_update_field( lole_word.ActiveDocument, false)
	Destroy inv_word_util
	
	//Save as file and quit Word application
	gnv_rights.of_check_dir_right(ls_merge_tmp_file, true, 'Word Save')
	lole_word.ActiveDocument.MailMerge.DataSource.Close()		
//	lole_word.ActiveDocument.MailMerge.MainDocumentType = wdNotAMergeDocument
	lole_word.ActiveDocument.MailMerge.MainDocumentType = -1
	lole_word.ActiveDocument.saveas(ls_merge_tmp_file,0,false,'',false)
	gnv_shell.of_delete_recent( ls_merge_tmp_file, true) //Delete Windows Recent Document.
	lole_word.ActiveDocument.Close(wdDoNotSaveChanges)
	lole_word.Quit(wdDoNotSaveChanges)
	lole_word.DisconnectObject( )
	destroy lole_word
	as_merge_file	= ls_merge_tmp_file						//be abled to use the word
	
//	//comment
//	If isvalid(iw_appeon_gifofwait) Then
//		iw_appeon_gifofwait.of_SkipNextPosition(10)
//	End If
CATCH(Throwable th)
	ib_status = True
	gnv_debug.of_output( True, 'Merge data in document failed!.'+"File name:"+ls_merge_tmp_file+" ~r~n error msg:"+th.text+" ~r~n ctx id:"+string(al_ctx_id)+ " doc id:"+string(al_doc_id))
	MessageBox("Alert Message","Merge data in document failed!")
	if lole_word.ActiveDocument.MailMerge.DataSource.Name <> '' then
		lole_word.ActiveDocument.MailMerge.DataSource.Close()
	end if
	if isvalid(lole_word) then
		lole_word.Quit(wdDoNotSaveChanges)
		lole_word.DisconnectObject( )
		destroy lole_word
	end if
	IF isvalid(inv_word_util) then Destroy inv_word_util
	Return -1
END TRY

Return 1

end function

public function integer of_compare_doc (long al_clause_id, long al_doc_id, string as_file_clause_name, string as_merge_file);//====================================================================
// Function: of_compare_doc
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                al_clause_id
//                al_doc_id
//                as_file_clause_name
//                as_merge_file
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 03/29/2013
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
integer 					li_return 
String 					ls_compare, ls_compared, ls_text, ls_file, ls_clipboard
OLEObject 				lole_word, lole_clause
n_cst_ovole_utils 		lnv_ole_utils_doc
String ls_targe_file, ls_source_file //Added By Ken.Guo 04/16/2013

li_return  =  0
//Create a new Word object	and open the Word document 
lole_word = Create oleobject
IF lole_word.Connecttonewobject("word.application") <> 0 THEN
	ib_status = True
	gnv_debug.of_output( True,"Could not connect to Microsoft Word. Please make sure it is properly installed. ~r~n syntax:of_compare_doc")
	Destroy lole_word  
	Messagebox('Client Error', 'Could not connect to Microsoft Word. Please make sure it is properly installed.')
	RETURN -1
END IF

TRY
	lole_word.Application.NormalTemplate.Saved = TRUE 
	lole_word.Application.Documents.Open(as_merge_file,false,true)
	gnv_word_utility.of_modify_word_property( lole_word.Activedocument)	//Added By Mark Lee 06/20/2013 change for office 2013.
	gnv_shell.of_delete_recent( as_merge_file, true) // Delete Windows Recent Document.
//	//comment
//	If isvalid(iw_appeon_gifofwait) Then
//		iw_appeon_gifofwait.of_SkipNextPosition(10)
//	End If
	IF not isvalid(inv_word_util) Then 
		inv_word_util = create n_cst_word_utility
	End If 
	//Unprotect document if needed 
	IF inv_word_util.of_unprotect_doc(lole_word.ActiveDocument) = -1 THEN  
		ib_status = True
		gnv_debug.of_output( True," Unprotect document ~r~n syntax:of_compare_doc")
		lole_word.ActiveDocument.Close(wdDoNotSaveChanges)
		lole_word.Quit(wdDoNotSaveChanges)
		lole_word.DisconnectObject( )
		destroy lole_word
		destroy inv_word_util
		RETURN -1
	END IF		
	lole_word.ActiveDocument.TrackRevisions = false
	
	//find the clause txt
	oleobject ole_document,ole_bookmarks,ole_range,ole_range_temp
//	ole_document = lole_word.activedocument
//	ole_bookmarks = lole_word.activedocument.Content.bookmarks

	If lole_word.activedocument.Content.bookmarks.exists("clause_" +string(al_clause_id)) then 
		// select the clipboard()
		ls_clipboard =  Clipboard()
//		ole_range =  lole_word.activedocument.GoTo(3, -1) 
//		ole_range.select()
//		//Select first line in bookmark.  
//		ole_range_temp = ole_document.range(ole_bookmarks.item("clause_" +string(al_clause_id)).start,ole_bookmarks.item("clause_" +string(al_clause_id)).start)
//		ole_range_temp.select()
		//Select bookmark. Then the first line in bookmark will show in top in cuurent page
		lole_word.activedocument.Content.bookmarks.item("clause_" +string(al_clause_id)).select()
		lole_word.selection.Copy
		// close module
		lole_word.activedocument.Close()
		//add new 
		lole_word.documents.add
		lole_word.selection.Paste
		//restore the code for the clipboard 	
		Clipboard(ls_clipboard)
		
		//Numbering
		inv_word_util.of_preview(lole_word.ActiveDocument, True)		
		destroy inv_word_util
//		//comment
//		If isvalid(iw_appeon_gifofwait) Then
//			iw_appeon_gifofwait.of_SkipNextPosition(10)
//		End If
		//save the doc
		ls_compare = gs_dir_path + gs_DefDirName + "\Negotiated\"+is_tmp_directory+"\clause_document_"+string(al_clause_id)+"_"+string(al_doc_id)+".doc"
		ls_compared = gs_dir_path + gs_DefDirName + "\Negotiated\"+is_tmp_directory+"\compared_"+string(al_clause_id)+"_"+string(al_doc_id)+".doc"
		lole_word.activedocument.saveas( ls_compare,0,false,'',false)
		gnv_shell.of_delete_recent(ls_compare,true )
		lole_word.ActiveDocument.Close(wdDoNotSaveChanges)
		lole_word.Quit(wdDoNotSaveChanges)
		lole_word.DisconnectObject( )
		destroy lole_word
		
//		//comment
//		If isvalid(iw_appeon_gifofwait) Then
//			iw_appeon_gifofwait.of_SkipNextPosition(10)
//		End If
		//compare as_file_clause_name --source; ls_compare----compare
		// Accept ALL changes for two file 		
		lnv_ole_utils_doc = Create n_cst_ovole_utils
		lnv_ole_utils_doc.of_acceptall(as_file_clause_name)		
		lnv_ole_utils_doc.of_acceptall(ls_compare)	
//		Destroy lnv_ole_utils_doc	
		
//		//comment
//		If isvalid(iw_appeon_gifofwait) Then
//			iw_appeon_gifofwait.of_SkipNextPosition(10)
//		End If

		//Added By Ken.Guo 04/16/2013. for Merge Function. the source argument and target argument is different between Word 2003 and 2007.
		IF gs_word_version = 'word2003' or gs_word_version = 'wordxp'  Then
			ls_targe_file = as_file_clause_name 
			ls_source_file = ls_compare 					
		Else
			ls_targe_file = ls_compare
			ls_source_file = as_file_clause_name	
		End If
		
		IF Len(ls_source_file) > 0 and FileExists(ls_source_file) THEN
			IF NOT IsValid(lole_clause) THEN
				lole_clause = Create OleObject
				IF lole_clause.Connecttonewobject("word.application") <> 0 THEN
					ib_status = True
					gnv_debug.of_output( True,"Could not connect to Microsoft Word. Please make sure it is properly installed. ~r~n syntax:of_compare_doc, lole_clause.Connecttonewobject( ) . "+"~r~n Clause id:"+string(al_clause_id)+" doc id:"+string(al_doc_id))
					Messagebox('Client Error', 'Could not connect to Microsoft Word. Please make sure it is properly installed.')
					IF isvalid(lnv_ole_utils_doc) then Destroy lnv_ole_utils_doc	
					Destroy lole_clause					
					RETURN 0
				END IF
				lole_clause.Application.NormalTemplate.Saved = TRUE  
				lole_clause.Application.Documents.Open(ls_source_file, False, True) 		
				gnv_word_utility.of_modify_word_property( lole_clause.Activedocument)	//Added By Mark Lee 06/20/2013 change for office 2013.
				gnv_shell.of_delete_recent( ls_source_file, true) //  Delete Windows Recent Document.
			END IF

			//Compare and saveas the document under a new Word2007 application
			IF gs_word_version = 'word2007'  or gs_word_version = 'word2010'  THEN
				lole_clause.ActiveDocument.Compare(ls_targe_file, "External", 1, True, True, False)  
				gnv_shell.of_delete_recent( ls_targe_file, true) // Delete Windows Recent Document.
			END IF		
			//Compare with the source document if under non Word 2007 environment
			IF gs_word_version <> 'word2007' THEN 
				IF gs_word_version = 'word2003' or gs_word_version = 'wordxp' THEN
					lole_clause.ActiveDocument.Compare(ls_targe_file, "External", 1, True, True, False )
				ELSE
					lole_clause.ActiveDocument.Compare(ls_targe_file)
				END IF
			END IF	
			gnv_shell.of_delete_recent( ls_targe_file, true) // Delete Windows Recent Document.
			
//			//comment
//			If isvalid(iw_appeon_gifofwait) Then
//				iw_appeon_gifofwait.of_SkipNextPosition(10)
//			End If		
		END IF
		
		lole_clause.Application.NormalTemplate.Saved = TRUE  //Added By Mark Lee 04/17/2013 let the NormalTemplate do not change.
		//Added By Mark Lee 04/10/2013
		ls_file = gs_dir_path + gs_DefDirName + "\Negotiated\"+is_tmp_directory+"\clause_document_compared_before_format_"+string(al_clause_id)+"_"+string(al_doc_id)+".doc"
		lole_clause.ActiveDocument.SaveAs(ls_file, 0,false,'',false)
		gnv_shell.of_delete_recent( ls_file, true) // Delete Windows Recent Document.			
	
//		IF Not isvalid(iw_ole_word) Then 
//			Open(iw_ole_word)
////			iw_ole_word.event activate( )
//		End IF 

//		iw_ole_word.ole_1.is_filepath = ls_file						
//		iw_ole_word.ole_1.of_open(ls_file,True  )
//		gnv_shell.of_delete_recent( ls_file, true) // Delete Windows Recent Document.			
		//Accept or Reject changes according to the spec
	//	inv_ole_utils_doc = create n_cst_ovole_utils
	
		lnv_ole_utils_doc.of_initialdoc( lole_clause.ActiveDocument) //Modified By Ken.Guo 04/19/2013
//		lnv_ole_utils_doc.of_open( ls_file, True)		
//		lnv_ole_utils_doc.of_accept_reject('accept', 'all format')
		lnv_ole_utils_doc.of_accept_reject_special_character('accept', 'all format',True)

//		//delete the  char(13)  
//		oleobject 	ole_ranges
//		i = 1
//		Do
////			lole_clause.ActiveDocument.Paragraphs(i).Range.Select
//			ole_ranges =	lole_clause.ActiveDocument.Paragraphs[i].Range
//			ole_ranges.select()
//			
//			If trim(lole_clause.Selection.Text) = char(13) or trim(lole_clause.Selection.Text) = char(10)   Then
//				lole_clause.Selection.Delete
//			Else
//				lole_clause.Selection.MoveDown
//				i = i + 1 
//			End If
//		Loop Until i = lole_clause.ActiveDocument.Paragraphs.count 
//		Destroy ole_ranges
		li_return = lnv_ole_utils_doc.of_revision_count()
		IF li_return > 0 Then 
			li_return = 1
		Else
			li_return = 0 
		End IF
		
		//Modified By Ken.Guo 04/19/2013
		//lnv_ole_utils_doc.of_savetofile( ls_compared)
		lole_clause.Application.NormalTemplate.Saved = TRUE  //Added By Mark Lee 04/17/2013 let the NormalTemplate do not change.
		lole_clause.ActiveDocument.SaveAs(ls_compared, 0,false,'',false)
		gnv_shell.of_delete_recent( ls_compared, true) // Delete Windows Recent Document.				
		Destroy 	lnv_ole_utils_doc
		
		//Added By Mark Lee 04/09/2013
		lole_clause.ActiveDocument.Close(wdDoNotSaveChanges)
		lole_clause.Quit(wdDoNotSaveChanges)
		lole_clause.DisconnectObject( )
		destroy lole_clause		
		
		
//		iw_ole_word.ole_1.of_close( ) 		
//		Close(iw_ole_word)		//Added By Mark Lee 04/17/2013
		
		IF FileExists(ls_compared) Then 
			gnv_shell.of_delete_recent( ls_compared, true) // Delete Windows Recent Document.
		Else 
			ib_status = True		
			Return -1
		End If 
//		//comment
//		If isvalid(iw_appeon_gifofwait) Then
//			iw_appeon_gifofwait.of_SkipNextPosition(10)
//		End If
	Else
		//Added By Ken.Guo 04/19/2013
		lole_word.ActiveDocument.Close(wdDoNotSaveChanges)
		lole_word.Quit(wdDoNotSaveChanges)
		lole_word.DisconnectObject( )
		destroy lole_word		
	End If
	
CATCH(Throwable th)
	ib_status = True
	gnv_debug.of_output( True, "Comparing data in document failed! syntax: of_compare_doc()"+" ~r~n error msg:"+th.text+"~r~n Clause id:"+string(al_clause_id)+" doc id:"+string(al_doc_id))
	MessageBox("Alert Message","Compare data in document failed!")
	if isvalid(lole_word) then
		if lole_word.ActiveDocument.MailMerge.DataSource.Name <> '' then
			lole_word.ActiveDocument.MailMerge.DataSource.Close()
		end if
		lole_word.Quit(wdDoNotSaveChanges)
		lole_word.DisconnectObject( )
		destroy lole_word
	end if
	If isvalid(lole_clause) Then 
		lole_clause.Quit(wdDoNotSaveChanges)
		lole_clause.DisconnectObject( )
		destroy lole_clause
	End If 
	IF isvalid(lnv_ole_utils_doc) then Destroy lnv_ole_utils_doc	
	IF isvalid(inv_word_util) then Destroy inv_word_util	
//	If Isvalid(iw_ole_word) Then Close(iw_ole_word)			//Added By Mark Lee 04/17/2013
	Return -1
END TRY	
	
return li_return
end function

on w_clause_painter.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_clause_painter.destroy
call super::destroy
destroy(this.tab_1)
end on

event close;call super::close;tab_1.of_close()
w_mdi.ChangeMenu(m_pfe_cst_mdi_menu)
w_mdi.of_menu_security( w_mdi.MenuName )


IF isvalid(inv_word_util) Then 
	Destroy inv_word_util
End If 

//Added By Mark Lee 04/15/2013
IF isvalid(ids_template_msg) Then 
	Destroy ids_template_msg
End If 
end event

event pfc_save;tab_1.of_save()
Return 1
end event

event open;call super::open;//////////////////////////////////////////////////////////////////////
// $<event>openw_clause_painter()
// $<arguments>(None)
// $<returns> long
// $<description>This window is designed by Jack
// $<description>Clause Library Painter
//////////////////////////////////////////////////////////////////////
// $<add> 12.08.2006 by Jack (Clause Library Painter)
//////////////////////////////////////////////////////////////////////

This.move(1,1)

is_agreement_path = gs_dir_path + gs_DefDirName + "\Agreement\" //by alfee 04.18.2007

end event

event pfc_preopen;call super::pfc_preopen;
long ll_i
string ls_scale

if isvalid(w_dashboard) then this.WindowState =normal! //(Appeon)Stephen 2013-06-18 - can not load the clause library window at all in C/S

This.of_SetResize(True)

This.inv_resize.of_SetOrigSize (This.workspacewidth(),This.workspaceheight())
ls_scale = this.inv_resize.scale

For ll_i =  1 To upperbound(This.CONTrol)
   This.inv_resize.of_Register (This.CONTrol[ll_i],ls_scale)
Next


end event

event activate;call super::activate;long ll_handle

If w_mdi.menuname <> 'm_pfe_cst_clause_painter' Then 
	ll_handle = handle(w_mdi)
	w_mdi.ChangeMenu( m_pfe_cst_clause_painter )
	w_mdi.SetToolbarPos ( 2, 1, 200, False )
	w_mdi.of_menu_security( w_mdi.MenuName )
	gnv_appeondll.of_settoolbarpos(ll_handle)

	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 13/04/2007 By: Ken.Guo
	//$<reason> Use m_rolepainter replace to m_rights
	//Because if user no right ,the toolbar item shouldn't display!
	
	//---------Begin Modified by (Appeon)Harry 03.12.2014 for V142 ISG-CLX--------
	/*
	if m_pfe_cst_clause_painter.m_system.m_painters.m_rolepainter.visible = false then
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_system.m_painters.m_rolepainter,'toolbaritemvisible', false)
	end if
	*/
	if m_pfe_cst_clause_painter.m_system.m_painters.m_security.m_rolepainter.visible = false then
		gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_system.m_painters.m_security.m_rolepainter,'toolbaritemvisible', false)
	end if
	//---------End Modfiied ------------------------------------------------------
	
	//---------------------------- APPEON END ----------------------------

//	If w_mdi.of_security_access( 6803 ) = 0 Then
//		m_pfe_cst_clause_painter.m_edit.m_rights.toolbaritemvisible = False
//	Else
//		m_pfe_cst_clause_painter.m_edit.m_rights.toolbaritemvisible = True
//	End If
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_save,'enabled', False)
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_properties,'enabled', False)
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_addfolder,'enabled', False)			//Added by Scofield on 2010-05-19
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_file.m_addclause,'enabled', False)
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_edit.m_delete1,'enabled', False)
	gnv_app.of_modify_menu_attr( m_pfe_cst_clause_painter.m_view.m_rules,'enabled', False)	
End If

tab_1.of_set_menu(tab_1.selectedtab )

//Added By Ken.Guo 2011-05-05. Workaround Office OCX's bug
If gs_imageview_version = '5.0' and isvalid(tab_1.tabpage_clause.ole_1 ) Then
	tab_1.tabpage_clause.ole_1.object.activate(true)
End If
end event

event deactivate;call super::deactivate;//Added By Ken.Guo 2011-05-05. Workaround Office OCX's bug
//If gs_imageview_version = '5.0' and isvalid(tab_1.tabpage_clause.ole_1 ) Then
//	tab_1.tabpage_clause.ole_1.object.activate(false)
//End If


end event

type tab_1 from u_tab_agreement_clause_painter within w_clause_painter
integer width = 4498
integer taborder = 11
long backcolor = 33551856
end type

