$PBExportHeader$u_tabpg_dm_email.sru
$PBExportComments$[intellicontract_tab]
forward
global type u_tabpg_dm_email from u_tabpg_contract_master
end type
type tab_1 from tab within u_tabpg_dm_email
end type
type tabpage_browse from userobject within tab_1
end type
type dw_browse from u_dw_contract within tabpage_browse
end type
type dw_filter from u_dw_contract within tabpage_browse
end type
type tabpage_browse from userobject within tab_1
dw_browse dw_browse
dw_filter dw_filter
end type
type tabpage_preview from userobject within tab_1
end type
type uo_2 from uo_dm_image_view_cp within tabpage_preview
end type
type gb_map from groupbox within tabpage_preview
end type
type cb_approve from commandbutton within tabpage_preview
end type
type cb_original from commandbutton within tabpage_preview
end type
type cb_reject from commandbutton within tabpage_preview
end type
type dw_change from u_dw within tabpage_preview
end type
type dw_head from u_dw_contract within tabpage_preview
end type
type dw_clause from u_dw within tabpage_preview
end type
type ole_1 from u_email_edit within tabpage_preview
end type
type ole_doc from u_email_edit within tabpage_preview
end type
type tabpage_preview from userobject within tab_1
uo_2 uo_2
gb_map gb_map
cb_approve cb_approve
cb_original cb_original
cb_reject cb_reject
dw_change dw_change
dw_head dw_head
dw_clause dw_clause
ole_1 ole_1
ole_doc ole_doc
end type
type tab_1 from tab within u_tabpg_dm_email
tabpage_browse tabpage_browse
tabpage_preview tabpage_preview
end type
type rb_current from radiobutton within u_tabpg_dm_email
end type
type rb_other from radiobutton within u_tabpg_dm_email
end type
type pb_browse from picturebutton within u_tabpg_dm_email
end type
type st_other from statictext within u_tabpg_dm_email
end type
type gb_1 from groupbox within u_tabpg_dm_email
end type
end forward

global type u_tabpg_dm_email from u_tabpg_contract_master
integer width = 3899
integer height = 2048
event ue_preview ( long al_doc_id,  decimal adc_revision,  string as_doc_ext )
event type integer ue_retrieve ( )
event ue_print ( )
event ue_locatefile ( )
event ue_clausemap ( )
event ue_addclause ( )
event ue_mergedata ( string as_mergemode )
event type integer ue_save ( )
event ue_delete ( )
event ue_revision ( )
event ue_refresh_audit ( long ll_doc_id )
tab_1 tab_1
rb_current rb_current
rb_other rb_other
pb_browse pb_browse
st_other st_other
gb_1 gb_1
end type
global u_tabpg_dm_email u_tabpg_dm_email

type variables
string  is_filter
n_cst_ovole_utils  inv_ole_utils_doc
long    il_preview_doc_id=-1
dec{1}  idc_preview_revision=0
string  is_doc_ext=''
string  is_doc_right //user rights on current document
string  is_clause_right //user rights on current clause

n_cst_dm_utils  inv_dm_utils
n_cst_filesrvwin32  inv_filesvr
boolean ib_locate = true //locate clause in file
boolean ib_locate_change = true //locate change in file
boolean ib_showclausemap=false
boolean ib_retrieving =false//Is it retrieving data? If true, do not trigger rowfocuschanged event.
datetime idt_modify_date //modify date for current revision file
datastore ids_clause_temp //for clause map version control in of_updateclausemap
datastore ids_clause_right //for clause right in of_setclauserights
datastore ids_changes //for document change list 

CONSTANT INTEGER wdActiveEndPageNumber = 3
CONSTANT INTEGER wdFirstCharacterLineNumber = 10
CONSTANT INTEGER wdFirstCharacterColumnNumber = 9
CONSTANT INTEGER wdPropertyKeywords = 4 //by alfee at 03.09.2007

boolean ib_browse 

Boolean ib_merged_data = false

//Opened file name
String is_opened_file

Boolean ib_showed = False	//Added by Ken.Guo on 2008-11-06

Long il_org_ctx_id,il_ctx_id //Added By Ken.Guo 2009-06-19.
end variables

forward prototypes
public function string of_generate_filter ()
public function integer of_retrieve ()
public subroutine of_showole (boolean ab_show_doc_ole, boolean ab_show_clausemap)
public function integer of_refreshmap ()
public function integer of_maponoff (boolean ab_flag)
public function integer of_savefile ()
public subroutine of_getchanges ()
public function integer of_collapse_row (long ll_doc_id, long ll_row)
public subroutine of_previewdoc ()
public subroutine of_previewimage ()
public subroutine of_selectole (string as_doctype)
public function integer of_getclauserights ()
public subroutine of_setpreviewmenu ()
public function integer of_updateclausemap (string as_filename, decimal adec_new_revision)
public function integer of_updateclausemap (decimal adec_new_revision)
public function integer of_mergefile (long al_clauseid[], string as_rights[])
public function integer of_setclauserights (datastore ads_clause_right)
public subroutine of_setreviewbutton ()
public function string of_setdocumentrights ()
public function integer of_setclausestatus (string as_rights[])
public subroutine of_add_merge_field (string is_merge_field)
public subroutine of_set_default ()
public subroutine of_filter_category (ref datastore adw_data)
public function integer of_filter_clause (long ai_doc_id, decimal adc_revision)
end prototypes

event ue_preview(long al_doc_id, decimal adc_revision, string as_doc_ext);//////////////////////////////////////////////////////////////////////
// $<event>ue_previewu_tabpg_dm_data_master_browse()
// $<arguments>
//		value	long   	al_doc_id    		Document ID
//		value	decimal	adc_revision		Document revision
//		value	string 	as_doc_ext   		Document extended name, such as doc,tif
// $<returns> 
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.06.2007 by Davis
//////////////////////////////////////////////////////////////////////

string ls_null
String ls_doc_nme
long	 ll_size

CHOOSE CASE Lower(as_doc_ext)
	CASE 'tif','tiff','jfk','bmp','jpc','jpe','jpeg','pcx','dcx','xif','gif','wif','ibk'
		of_previewimage()
		If tab_1.selectedtab = 1 Then
			tab_1.post selecttab(2)
		End If		 
	CASE 'pdf' //Added By Ken.Guo 2011-05-06. for Open PDF Mode
		If gnv_data.of_getitem( 'icred_settings', 'openpdfwith', false) = '1' Then
			of_previewimage()
			If tab_1.selectedtab = 1 Then
				tab_1.post selecttab(2)
			End If					
		Else
			IF tab_1.selectedtab = 2 THEN tab_1.selecttab(1)
			setnull(ls_null)
			ls_doc_nme = inv_dm_utils.of_download_file( al_doc_id, adc_revision)
			IF FileExists(ls_doc_nme) THEN
				if ShellExecuteA ( Handle( This ), "open", ls_doc_nme , ls_Null, ls_Null, 4) <= 32 then
					run("rundll32.exe shell32.dll,OpenAs_RunDLL " + ls_doc_nme)
				end if
			END IF			
		End If
	CASE 'doc'
		of_previewdoc()
		If tab_1.selectedtab = 1 Then
			tab_1.post selecttab(2)
		End If		
	CASE 'htm','html'
		IF tab_1.selectedtab = 2 THEN tab_1.selecttab(1)
		setnull(ls_null)
		ls_doc_nme = inv_dm_utils.of_download_file( al_doc_id, adc_revision)
		IF FileExists(ls_doc_nme) THEN
		//ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', ls_doc_nme, ls_Null, 4)   //Commented by (Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
		ShellExecuteA ( Handle( This ), "open", of_getbrowserversion( ), ls_doc_nme, ls_Null, 4) //(Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
		END IF
	CASE else
		IF tab_1.selectedtab = 2 THEN tab_1.selecttab(1)
		setnull(ls_null)
		ls_doc_nme = inv_dm_utils.of_download_file( al_doc_id, adc_revision)
		IF FileExists(ls_doc_nme) THEN
			if ShellExecuteA ( Handle( This ), "open", ls_doc_nme , ls_Null, ls_Null, 4) <= 32 then
				run("rundll32.exe shell32.dll,OpenAs_RunDLL " + ls_doc_nme)
			end if
		END IF
END CHOOSE


end event

event type integer ue_retrieve();Return tab_1.tabpage_browse.dw_browse.event pfc_retrieve()

end event

event ue_print();//IF is_doc_ext='doc' THEN
//	inv_ole_utils_doc.of_print( )
//ELSE
//	tab_1.tabpage_preview.uo_1.Dynamic event ue_print()
//END IF
//
/////////////////////////////////////////////////////////////////////////
////// Trigger off audit trail
/////////////////////////////////////////////////////////////////////////
//str_add_audit lstr_add_audit
//lstr_add_audit.doc_id = il_doc_id
//lstr_add_audit.revision = idc_revision
//lstr_add_audit.doc_ext = is_doc_ext
//lstr_add_audit.action = "OutPut - Print"
//inv_dm_utils.of_add_audit_trail( lstr_add_audit )
//
////THIS.event ue_retrieve( )
//
end event

event ue_locatefile();//////////////////////////////////////////////////////////////////////
// $<event>ue_locatefileu_tabpg_dm_data()
// $<arguments>(None)
// $<returns> 
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.12.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////

//by alfee at 2007/01/12
tab_1.tabpage_preview.dw_clause.post event ue_locatefile()
end event

event ue_clausemap();//////////////////////////////////////////////////////////////////////
// $<event>ue_clausemapu_tabpg_dm_data()
// $<arguments>(None)
// $<returns> 
// $<description>Show/Hide clause map
//////////////////////////////////////////////////////////////////////
// $<add> 01.17.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////
IF ib_showclausemap THEN
	ib_showclausemap = FALSE
ELSE
	ib_showclausemap = TRUE
END IF

of_maponoff(ib_showclausemap)

//IF is_doc_ext<>'doc' OR tab_1.tabpage_browse.dw_browse.getrow() < 1 THEN
//	RETURN
//END IF
//
//of_showole(true,not ib_showclausemap)
end event

event ue_addclause();//////////////////////////////////////////////////////////////////////
// $<event>ue_addclauseu_tabpg_dm_data()
// $<arguments>
//		value	integer		
// $<returns> 
// $<description>Add clauses into document
//////////////////////////////////////////////////////////////////////
// $<add> 01.17.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////

Open(w_dm_add_clause)
end event

event ue_mergedata(string as_mergemode);//////////////////////////////////////////////////////////////////////
// $<event>ue_mergedata of u_tabpg_dm_data()
// $<arguments>
//		value	string as_mergemode		
// $<returns> 
// $<description>Merge data in document with export file
//////////////////////////////////////////////////////////////////////
// $<add> 01.17.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////

//Integer ll_export_id
//string  ls_merge_tmp_file
//setredraw(false)
//Setpointer(HourGlass!)
//ls_merge_tmp_file = gs_dir_path + gs_DefDirName + "\agreement\_merged_data.doc"
//
//If tab_1.tabpage_preview.ole_doc.object.activedocument.Fields.count < 1 Then
//	Messagebox("Merge Data" , "No merge field in the current document.")
//	setredraw(true)
//	RETURN
//End If
//
//If not ib_merged_data Then //merge operation
//
//	tab_1.tabpage_preview.ole_doc.object.savetolocal(ls_merge_tmp_file, true)
//	
//	Select ctx_acp_template.export_id Into :ll_export_id
//	   From ctx_am_document,ctx_acp_template
//	 	Where ctx_am_document.doc_id = :il_preview_doc_id
//		And ctx_am_document.from_templete_id = ctx_acp_template.ctx_acp_template_id;
//		
//	IF Not IsNull(ll_export_id) and IsValid(inv_ole_utils_doc) THEN
//		tab_1.tabpage_preview.ole_doc.object.close()
//		If lower(as_mergemode) = 'auto' Then//by alfee at 03.09.2007
//			If not isvalid(w_appeon_gifofwait) Then OpenwithParm(w_appeon_gifofwait,"Merging and Auto Numbering......")		
//			inv_ole_utils_doc.of_mergedata_auto(ll_export_id, inv_contract_details.of_get_ctx_id( ),ls_merge_tmp_file,is_opened_file,true)
//		Else
//			inv_ole_utils_doc.of_mergedata(ll_export_id, inv_contract_details.of_get_ctx_id( ),ls_merge_tmp_file,is_opened_file,true) 
//		End If			
//		inv_ole_utils_doc.of_displayfile(is_opened_file, inv_ole_utils_doc.of_isreadonly()) 
//	END IF
//	ib_merged_data = true
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergedata.toolbaritemdown = True
//Else //undo merge operation 
//	//Openwithparm( w_appeon_gifofwait, "Undo merging data in document..." )
//	tab_1.tabpage_preview.ole_doc.object.savetolocal(ls_merge_tmp_file, true)
//	
//	IF Not IsNull(ll_export_id) and IsValid(inv_ole_utils_doc) THEN
//		tab_1.tabpage_preview.ole_doc.object.close()
//		If lower(as_mergemode) = 'auto' Then//by alfee at 03.09.2007		
//			If not isvalid(w_appeon_gifofwait) Then OpenwithParm(w_appeon_gifofwait,"Merging and Auto Numbering...")
//			inv_ole_utils_doc.of_mergedata_auto(ll_export_id, inv_contract_details.of_get_ctx_id( ),ls_merge_tmp_file,is_opened_file,false)
//		Else
//			inv_ole_utils_doc.of_mergedata(ll_export_id, inv_contract_details.of_get_ctx_id( ),ls_merge_tmp_file,is_opened_file,false) 
//		End If
//		inv_ole_utils_doc.of_displayfile(is_opened_file, inv_ole_utils_doc.of_isreadonly()) 
//	END IF
//	
//	ib_merged_data = false
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergedata.toolbaritemdown = False
//	//IF Isvalid( w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)
//
//End If
//FileDelete(ls_merge_tmp_file)
//setredraw(true)
//tab_1.tabpage_preview.ole_doc.setfocus()
//IF isvalid( w_export_progress) THEN CLOSE(w_export_progress)	
//If isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)		

end event

event type integer ue_save();///******************************************************************************************************************
//**  [PUBLIC]   : 
//**==================================================================================================================
//**  Purpose   	: 
//**==================================================================================================================
//**  Arguments 	: [none] 
//**==================================================================================================================
//**  Returns   	: [none]   
//**==================================================================================================================
//**  Notes     	: Save current document to DB
//**==================================================================================================================
//**  Created By	: Davis 01.23.2007
//**==================================================================================================================
//**  Modification Log
//**   Changed By             Change Date                                               Reason
//** ------------------------------------------------------------------------------------------------------------------
//********************************************************************************************************************/
//
//Boolean lb_revision_control
//Integer li_ret
//Decimal ldec_new_revision
//String ls_filename, ls_filename_writable
//DateTime ldt_modify_date
//str_add_audit lstr_add_audit
//Long ll_row
//Long ll_level
//Boolean lb_checkout_status
//
//ldt_modify_date = DateTime(Today(), Now())
//
//ll_row = tab_1.tabpage_browse.dw_browse.GetRow()
//lb_revision_control = (tab_1.tabpage_browse.dw_browse.GetItemString(ll_row, "revision_control") = "1")
//ll_level = tab_1.tabpage_browse.dw_browse.GetItemNumber(ll_row, "level")
//lb_checkout_status = (tab_1.tabpage_browse.dw_browse.GetItemString(ll_row, "checkout_status") = "1")
//
//// Check rights
//IF ll_level = 2 THEN
//	MessageBox("Save Document", "Can't save a history revision.")
//	RETURN 0
//END IF
//
//IF lb_checkout_status THEN
//	MessageBox("Save Document", "Can't save a checked-out document.")
//	RETURN 0
//END IF
//
//CHOOSE CASE Lower(is_doc_ext)
//	CASE "doc" // SAVE WORD DOCUMENT
//		IF lb_revision_control AND NOT inv_ole_utils_doc.of_ismodified( ) THEN
//			MessageBox("Save Document", "The document is not modified.")
//			RETURN 0
//		END IF
//
//		IF NOT lb_revision_control THEN
//			li_ret = MessageBox("Save Doucment", "Do you want to start version control?", Question!, YesNo!, 1)
//			IF li_ret = 1 THEN
//				lb_revision_control = TRUE
//			ELSE
//				IF NOT inv_ole_utils_doc.of_ismodified( ) THEN RETURN 0
//			END IF
//		END IF
//		
//		Setpointer(HourGlass!)
//		Openwithparm(w_appeon_gifofwait, "Saving the document...")
//
//		// Increment revision number
//		IF lb_revision_control THEN
//			ldec_new_revision = inv_dm_utils.of_newversion( idc_revision )
//		ELSE
//			ldec_new_revision = idc_revision
//		END IF
//		
//		// Generate file name
//		ls_filename = inv_dm_utils.of_generate_tempname(il_doc_id, ldec_new_revision, is_doc_ext)
//		ls_filename_writable = inv_dm_utils.of_generate_tempname_writable(il_doc_id, ldec_new_revision, is_doc_ext)
//		
//		// Save document
//		inv_ole_utils_doc.of_savetofile( ls_filename )
//		inv_ole_utils_doc.of_savetofile( ls_filename_writable )
//		
//		IF lb_revision_control THEN
//			gnv_appeondb.of_startqueue( )
//			
//			// Insert new record of image to the DB
//			INSERT Ctx_am_doc_image(Doc_id, Revision, doc_ext, modify_date)
//				Values( :il_doc_id, :ldec_new_revision, :is_doc_ext, :ldt_modify_date );
//				
//			// Set check out status to record
//			UPDATE Ctx_am_document
//				SET 	revision = :ldec_new_revision,
//				revision_control = '1',
//				checkout_by = '',
//				checkout_date = NULL,
//				checkout_status = '0'
//				Where Doc_id = :il_doc_id;
//				
//			 //COMMIT;  marked by alfee at 03.14.2007 for performance tunning
//			
//			gnv_appeondb.of_commitqueue( )
//		END IF
//		
//		w_appeon_gifofwait.event timer()
//
//		// Upload local file to DB
//		inv_dm_utils.of_upload_file( il_doc_id, ldec_new_revision, ls_filename)
//		
//		//update clause map for word document
//		of_updateclausemap(ldec_new_revision)
//		
//		//-------Appeon Begin - added by alfee at 03.14.2007 for performance tunning
//		IF tab_1.tabpage_preview.dw_change.visible THEN 
//			//Get changed text in document if clause map on
//			//of_getchanges() 
//			//Set Approve/Reject button if clause map on
//		   of_setreviewbutton()
//		END IF
//		//-------Appeon End-----------
//		
//		//Save the latest update date of the current file in Registry
//		inv_dm_utils.of_updateregistry(il_doc_id, ldec_new_revision, is_doc_ext, ldt_modify_date)
//		
//		///////////////////////////////////////////////////////////////////// //
//		//// Trigger off audit trail
//		///////////////////////////////////////////////////////////////////////
//		lstr_add_audit.Doc_id = il_doc_id
//		lstr_add_audit.Revision = ldec_new_revision
//		lstr_add_audit.doc_ext = is_doc_ext
//		lstr_add_audit.action = "Modified"
//		inv_dm_utils.of_add_audit_trail( lstr_add_audit )
//
//		w_appeon_gifofwait.event timer()
//
//		// Refresh painter
//		IF lb_revision_control THEN
//			tab_1.tabpage_browse.dw_browse.SetItem(ll_row, "revision_control", "1")
//			tab_1.tabpage_browse.dw_browse.SetItem(ll_row, "revision", ldec_new_revision)
//			THIS.of_collapse_row( il_doc_id, tab_1.tabpage_browse.dw_browse.GetRow())
//			THIS.EVENT ue_doc_changed( il_doc_id, il_doc_id, idc_revision,ldec_new_revision )
//			idc_revision = ldec_new_revision
//			This.inv_ole_utils_doc.is_current_file = ls_filename_writable
//			w_appeon_gifofwait.event timer()
//		END IF
//		
//		IF Isvalid(w_appeon_gifofwait) THEN POST Close(w_appeon_gifofwait)
//		
//	CASE ELSE // SAVE TIF DOCUMENT
//		li_ret = tab_1.tabpage_preview.uo_1.EVENT ue_save( )
//		IF li_ret > 0 THEN
//			ldec_new_revision = tab_1.tabpage_preview.uo_1.of_get_revision( )
//			IF lb_revision_control THEN
//				tab_1.tabpage_browse.dw_browse.SetItem(ll_row, "revision_control", "1")
//				tab_1.tabpage_browse.dw_browse.SetItem(ll_row, "revision", ldec_new_revision)
//				THIS.of_collapse_row( il_doc_id, tab_1.tabpage_browse.dw_browse.GetRow())
//				
//				THIS.EVENT ue_doc_changed( il_doc_id, il_doc_id, idc_revision, ldec_new_revision)
//				idc_revision = ldec_new_revision
//			END IF
//		ELSE
//			return li_ret
//		END IF
//END CHOOSE
//


RETURN 1


end event

event ue_delete();/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: Delete all of this document.
**==================================================================================================================
**  Created By	: Davis 01.26.2007
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

Integer li_ret
Boolean lb_checkout_status

IF tab_1.tabpage_browse.dw_browse.Rowcount( ) = 0 THEN RETURN
IF tab_1.tabpage_browse.dw_browse.Getrow( ) = 0 THEN RETURN

//lb_checkout_status = (tab_1.tabpage_browse.dw_browse.GetItemString(tab_1.tabpage_browse.dw_browse.Getrow( ), "checkout_status") = "1")
lb_checkout_status = (tab_1.tabpage_browse.dw_browse.GetItemString(tab_1.tabpage_browse.dw_browse.Getrow( ), "checkout_status") <> "0") //Modified by Ken.Guo on 2009-03-27
IF lb_checkout_status THEN
	MessageBox("Delete Document", "Can't delete a checked-out document.")
	RETURN
END IF

li_ret = messagebox('Delete Document', 'Are you sure you want to delete this document?',question!,Yesno!,2)
IF li_ret = 2 THEN RETURN

gnv_appeondb.of_startqueue( )

DELETE FROM  Ctx_am_doc_audit WHERE doc_id = :il_doc_id;
DELETE FROM  ctx_am_action_item WHERE doc_id = :il_doc_id;
DELETE FROM  Ctx_am_doc_image WHERE doc_id = :il_doc_id;
DELETE FROM  Ctx_am_document_clause WHERE doc_id = :il_doc_id;
DELETE FROM  Ctx_am_document WHERE doc_id = :il_doc_id;
COMMIT;

gnv_appeondb.of_commitqueue( )

This.event ue_retrieve( )

end event

event ue_revision();/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: Start version control manually.
**==================================================================================================================
**  Created By	: Davis 01.26.2007
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

Integer li_ret
Decimal ldec_new_revision

IF tab_1.tabpage_browse.dw_browse.object.revision_control[tab_1.tabpage_browse.dw_browse.getrow()] = "0" THEN
	li_ret = MessageBox("Start Version Control", "Do you want to start version control?", Question!, YesNo!, 1)
	IF li_ret = 1 THEN
		ldec_new_revision = inv_dm_utils.of_newversion( idc_revision )
		
		gnv_appeondb.of_startqueue( )
		
		//Add doc_ext_full Filed  - jervis 10.21.2009
		INSERT ctx_am_doc_image(Doc_id, Revision, doc_ext, modify_date, image_file,doc_ext_full)
		SELECT doc_id, :ldec_new_revision, doc_ext, getdate(), image_file,doc_ext_full
		FROM ctx_am_doc_image
		Where doc_id = :il_doc_id 
			And revision = :idc_revision;
			
		Update ctx_am_document
		Set revision = :ldec_new_revision,
			revision_control = '1'
		Where doc_id = :il_doc_id 
			And revision = :idc_revision;
			
		Insert Ctx_am_document_clause(Doc_id, Revision, ctx_acp_clause_id, orders )
		Select Doc_id, :ldec_new_revision, ctx_acp_clause_id, orders
		From	Ctx_am_document_clause
		Where doc_id = :il_doc_id
			And Revision = :idc_revision;

		Commit;
		
		gnv_appeondb.of_commitqueue( )
		
		///////////////////////////////////////////////////////////////////// //
		//// Trigger off audit trail
		///////////////////////////////////////////////////////////////////////
		str_add_audit lstr_add_audit
		lstr_add_audit.doc_id = il_doc_id
		lstr_add_audit.revision = ldec_new_revision
		lstr_add_audit.doc_ext = is_doc_ext
		lstr_add_audit.action = "Start Version Control"
		inv_dm_utils.of_add_audit_trail( lstr_add_audit )

		Event ue_retrieve()
	END IF
END IF

end event

event ue_refresh_audit(long ll_doc_id);Long ll_row

ll_row = tab_1.tabpage_browse.dw_browse.Find( "doc_id = " + String(ll_doc_id) + " And level = 1", 1, 1000)
IF ll_row > 0 THEN
	THIS.of_collapse_row( ll_doc_id, ll_row )
END IF

RETURN
end event

public function string of_generate_filter ();//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_dm_data_master_browse.of_generate_filter()
// $<arguments>
//		value	integer		
// $<returns> string
// $<description>Generate filter string
//////////////////////////////////////////////////////////////////////
// $<add> 2006-12-19 by Frank.Gui
//////////////////////////////////////////////////////////////////////

string ls_filter,ls_create_by,ls_doc_name,ls_doc_type,ls_status_by
long ll_category,ll_status
date ld_create_date,ld_status_date
date ld_create_date2,ld_status_date2
dec{1} ldc_revision
datawindow   dw_filter

dw_filter = tab_1.tabpage_browse.dw_filter
dw_filter.accepttext()
ls_doc_type = dw_filter.getitemstring(1,"doc_type")
ll_category = dw_filter.getitemnumber(1,"category")
ls_doc_name = dw_filter.getitemstring(1,"doc_name")
ldc_revision = dw_filter.getitemdecimal(1,"revision")
ll_status = dw_filter.getitemnumber(1,"status")
ls_create_by = dw_filter.getitemstring(1,'create_by')
ld_create_date = date(dw_filter.getitemdatetime(1,"create_date"))
ld_create_date2 = date(dw_filter.getitemdatetime(1,"create_date2"))
ls_status_by = dw_filter.getitemstring(1,'status_by')
ld_status_date = date(dw_filter.getitemdatetime(1,"status_date"))
ld_status_date2 = date(dw_filter.getitemdatetime(1,"status_date2"))


if not isnull(ls_doc_type) and ls_doc_type<>'A' then 
	ls_filter += "and doc_type = '" + ls_doc_type+"' "
end if
if not isnull(ll_category) then 
	ls_filter += "and category = " + string(ll_category) + " "
end if
if len(trim(ls_doc_name)) > 0 then 
	ls_filter += "and pos(lower(doc_name), '" + lower(ls_doc_name) + "') > 0 " 
end if
if not isnull(ldc_revision) then 
	ls_filter += "and revision = " + string(ldc_revision) + " "
end if
if len(trim(ls_create_by)) > 0 then
	ls_filter += "and create_by = '" + ls_create_by + "' "
end if
if not isnull(ld_create_date) then 
	ls_filter += "and string(create_date,'yyyy/mm/dd') >= '" + string(ld_create_date,'yyyy/mm/dd') + "' "
end if
if not isnull(ld_create_date2) then 
	ls_filter += "and string(create_date,'yyyy/mm/dd') <= '" + string(ld_create_date2,'yyyy/mm/dd') + "' "
end if
if not isnull(ll_status)  then
	ls_filter += "and status = " + string(ll_status)
end if

if len(trim(ls_status_by)) > 0 then
	ls_filter += "and status_by = '" + ls_status_by + "' "
end if
if not isnull(ld_status_date) then 
	ls_filter += "and string(status_date,'yyyy/mm/dd') >= '" + string(ld_status_date,'yyyy/mm/dd') + "' "
end if
if not isnull(ld_status_date2) then 
	ls_filter += "and string(status_date,'yyyy/mm/dd') <= '" + string(ld_status_date2,'yyyy/mm/dd') + "' "
end if

if left(ls_filter,4) = "and " then 
	ls_filter = right(ls_filter, len(ls_filter)-4 )
end if

is_filter = ls_filter //

return ls_filter


end function

public function integer of_retrieve ();return event ue_retrieve()
end function

public subroutine of_showole (boolean ab_show_doc_ole, boolean ab_show_clausemap);//////////////////////////////////////////////////////////////////////
// $<function>of_showole()
// $<arguments>
//		boolean	ab_show_doc_ole  	:True  - Show the Office Viewer OCX OLE control
//                               :False - Show the Image Editing OCX OLE control
//		boolean	ab_show_clausemap	:Show the Clause Map controls or not. 
//										    IF ab_show_doc_ole is false, this has not effect.	
// $<returns> (none)
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.13.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////

IF ab_show_doc_ole THEN
	tab_1.tabpage_preview.ole_doc.visible = true
	//tab_1.tabpage_preview.uo_1.visible = false
	tab_1.tabpage_preview.uo_2.visible = false //Alfee 05.19.2008	 
	IF ab_show_clausemap THEN
		IF not tab_1.tabpage_preview.gb_map.visible THEN
			tab_1.tabpage_preview.gb_map.visible=true
			tab_1.tabpage_preview.dw_clause.visible=true
			tab_1.tabpage_preview.dw_change.visible=true
			tab_1.tabpage_preview.gb_map.visible=true
			tab_1.tabpage_preview.cb_approve.visible=true
			tab_1.tabpage_preview.cb_reject.visible=true
			tab_1.tabpage_preview.cb_original.visible=true
			tab_1.tabpage_preview.ole_doc.x = 1179
			tab_1.tabpage_preview.ole_doc.width = tab_1.tabpage_preview.ole_doc.width - 1171
			tab_1.tabpage_preview.dw_clause.bringtotop=true
			tab_1.tabpage_preview.dw_change.bringtotop=true
			
			tab_1.tabpage_preview.cb_approve.bringtotop=true
			tab_1.tabpage_preview.cb_reject.bringtotop=true
			tab_1.tabpage_preview.cb_original.bringtotop=true
		END IF
	ELSE
		IF tab_1.tabpage_preview.gb_map.visible THEN
			tab_1.tabpage_preview.gb_map.visible=false
			tab_1.tabpage_preview.dw_clause.visible=false
			tab_1.tabpage_preview.dw_change.visible=false
			tab_1.tabpage_preview.gb_map.visible=false
			tab_1.tabpage_preview.cb_approve.visible=false
			tab_1.tabpage_preview.cb_reject.visible=false
			tab_1.tabpage_preview.cb_original.visible=false
			tab_1.tabpage_preview.ole_doc.x = 8
			tab_1.tabpage_preview.ole_doc.width = tab_1.tabpage_preview.ole_doc.width + 1171
		END IF
	END IF
	
	m_pfe_cst_mdi_menu_contract_am  lm_menu

	lm_menu = w_mdi.menuid
	gnv_app.of_modify_menu_attr( lm_menu.m_documentmanager.m_clausemap,'checked', ab_show_clausemap)
	
	ib_showclausemap = ab_show_clausemap
ELSE
	tab_1.tabpage_preview.ole_doc.visible = false
	//-----------Begin Modified by Alfee on 05.19.2008 ----------------	
	//tab_1.tabpage_preview.uo_1.visible = true
	IF gi_imageocx = 1 THEN //Imaging 360
		//tab_1.tabpage_preview.uo_1.visible = true
		tab_1.tabpage_preview.uo_2.visible = false
	ELSE	//new Image OCX
		//tab_1.tabpage_preview.uo_1.visible = false
		tab_1.tabpage_preview.uo_2.visible = true		
	END IF
	//-----------End Modified -----------------------------------------			
END IF



end subroutine

public function integer of_refreshmap ();//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_dm_data.of_refresh_clause()
// $<arguments>(None)
// $<returns> integer
// $<description>
// $<description>refresh clause and changed text map list
//////////////////////////////////////////////////////////////////////
// $<add> 01.12.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////

//by alfee at 2007/01/15 - modify function name(of_refresh_clause) & content
Integer li_rtn

//For performance tunning, don't do locating firstly.
ib_locate = false

Setpointer(HourGlass!)

//Retrieve and filter clauses
tab_1.tabpage_preview.dw_clause.setredraw(False)
//tab_1.tabpage_preview.dw_clause.retrieve()
li_rtn = of_filter_clause(il_doc_id,idc_revision)
tab_1.tabpage_preview.dw_clause.setredraw(True)

//Refresh user rights on clause level
of_getclauserights() 

//Reset the changed text list
tab_1.tabpage_preview.dw_change.setredraw(False)
tab_1.tabpage_preview.dw_change.reset()
//This.of_getchanges()
tab_1.tabpage_preview.dw_change.setredraw(True)

//Locate current clause in document file
ib_locate = True
This.Event ue_locatefile()

RETURN li_rtn


end function

public function integer of_maponoff (boolean ab_flag);//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_dm_dataControl List()
// $<arguments>
//		value	boolean	ab_flag		
// $<returns> (none)
// $<description>Show/Hide clause map in document preview tabpage
//////////////////////////////////////////////////////////////////////
// $<add> 01.15.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////
Long ll_cnt, i, ll_clauseid[]
String ls_rights[]

//-------Appeon Begin ---added by alfee at 03.14.2007 for performance tunning
IF ab_flag THEN 
	SetPointer(HourGlass!)
	//Get changed text in document if clause map on
	//of_getchanges() 
	//Set Approve/Reject button if clause map on
   of_setreviewbutton()

	ll_cnt = tab_1.tabpage_preview.dw_clause.RowCount()
	FOR i = 1 to ll_cnt
		ll_clauseid[i] = tab_1.tabpage_preview.dw_clause.GetItemNumber(i,"ctx_acp_clause_id")
	NEXT
	//Get clauses' status according to revisions
	inv_ole_utils_doc.of_getclausestatus(ll_clauseid, ls_rights)
	//Set flag in clause datawindow by user rights
	of_setclausestatus(ls_rights)
END IF
//--------Appeon End--------

IF ab_flag THEN
	IF tab_1.tabpage_preview.ole_doc.x = tab_1.tabpage_preview.gb_map.x THEN
		tab_1.tabpage_preview.ole_doc.width = tab_1.tabpage_preview.ole_doc.width - tab_1.tabpage_preview.gb_map.width - 20	
	END IF	
	tab_1.tabpage_preview.ole_doc.x =tab_1.tabpage_preview.gb_map.x + tab_1.tabpage_preview.gb_map.width + 20	
	IF Isvalid(m_pfe_cst_mdi_menu_contract_am) THEN
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_clausemap,'toolbaritemdown', TRUE)
	END IF
ELSE
	tab_1.tabpage_preview.ole_doc.width += tab_1.tabpage_preview.ole_doc.x - tab_1.tabpage_preview.gb_map.x
	tab_1.tabpage_preview.ole_doc.x = tab_1.tabpage_preview.gb_map.x
	IF Isvalid(m_pfe_cst_mdi_menu_contract_am) THEN
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_clausemap,'toolbaritemdown', FALSE)
	END IF
END IF

tab_1.tabpage_preview.gb_map.Visible = ab_flag
tab_1.tabpage_preview.dw_clause.Visible = ab_flag
tab_1.tabpage_preview.dw_change.Visible = ab_flag
tab_1.tabpage_preview.cb_approve.Visible = ab_flag
tab_1.tabpage_preview.cb_reject.Visible = ab_flag
tab_1.tabpage_preview.cb_original.Visible = ab_flag

tab_1.tabpage_preview.dw_clause.Enabled = ab_flag
tab_1.tabpage_preview.dw_change.Enabled = ab_flag

IF ab_flag and tab_1.tabpage_preview.dw_clause.GetRow() > 0 THEN
	tab_1.tabpage_preview.cb_original.Enabled = True
ELSE
	tab_1.tabpage_preview.cb_original.Enabled = False
END IF

RETURN 1
end function

public function integer of_savefile ();//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_dm_dataof_savefile()
// $<arguments>
//		value	integer		
// $<returns> integer
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.15.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////

//by alfee at 2007/01/15

integer li_begin, li_end,i,j,li_rtn
long ll_template_id,ll_clause_id
datetime ldt_lastupdate
any la_rtn
string ls_bookmark[]
boolean lb_found
//
////check whether a file is opened and dirty
//if is_current_file ="" or tab_1.tabpage_2.ole_1.object.doctype <> 1 then return 1
////if not isvalid(iole_word) or isnull(iole_word) then 
////	iole_word = tab_1.tabpage_2.ole_1.object.ActiveDocument
////end if
//
////save the word file
////la_rtn = tab_1.tabpage_2.ole_1.object.save(is_current_file)
//la_rtn = tab_1.tabpage_2.ole_1.object.saveToLocal(is_current_file , true)
//if not iole_word.saved then 
//	messagebox("IntelliSoftGroup","Saving the current file failed!")
//	return -1
//end if
//
////parse the file name and get the template id
//li_begin = pos(lower(is_current_file),"template_",1) + 9
//li_end = pos(lower(is_current_file),".doc",1) 
//ll_template_id = long(mid(is_current_file,li_begin,li_end - li_begin))
//ldt_lastupdate = datetime(today(),now())
//
////update dw_clause according to bookmarks
//if tab_1.tabpage_2.ole_1.object.doctype = 1 then
////	iole_word = tab_1.tabpage_2.ole_1.object.ActiveDocument
//	for i = 1 to iole_word.bookmarks.count
//		ls_bookmark[i] = iole_word.bookmarks.item(i).name
//	next
//	
//	//delete mapped clause(s) according to bookmarks
//	for i =  1 to tab_1.tabpage_2.dw_clause.rowcount()
//		ll_clause_id = tab_1.tabpage_2.dw_clause.object.ctx_acp_clause_id[i]
//		lb_found = false
//		for j =  1 to upperbound(ls_bookmark)
//			if ls_bookmark[j] = "clause_" + string(ll_clause_id) then 
//				lb_found = true
//				exit				
//			end if	
//		next
//		if not lb_found then 
//			tab_1.tabpage_2.dw_clause.deleterow(i)
//			i = i -1
//		end if
//	next
//end if
//
////update db and registry it		
//if of_put_template_file(ll_template_id,ldt_lastupdate) <> 1 then 
//	messagebox("IntelliSoftGroup","Saving the current file failed!")
//	return -1
//end if
//
//li_rtn = tab_1.tabpage_2.dw_clause.update()
//
return li_rtn
end function

public subroutine of_getchanges ();//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_dm_data.of_getchanges()
// $<arguments>
//		value	integer		
// $<returns> integer
// $<description>Get and Display change list in word document
//////////////////////////////////////////////////////////////////////
// $<add> 01.15.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////

//Long ll_cnt
//integer li_rtn
//
//ids_changes = inv_ole_utils_doc.of_getchanges()
//ll_cnt = ids_changes.rowcount()
//
//ib_locate_change = False
//
//tab_1.tabpage_preview.dw_change.setredraw(false)
//tab_1.tabpage_preview.dw_change.reset()
//IF ll_cnt > 0 THEN
//	li_rtn= ids_changes.RowsCopy(1, ll_cnt, Primary!, tab_1.tabpage_preview.dw_change, 1, Primary!)
//END IF
//tab_1.tabpage_preview.dw_change.setredraw(true)
//
//ib_locate_change = True
//	
////li_rtn = ids_changes.sharedata(tab_1.tabpage_preview.dw_clause)

end subroutine

public function integer of_collapse_row (long ll_doc_id, long ll_row);Long Li_find

tab_1.tabpage_browse.dw_browse.Setredraw( False )

//Delete Rows
li_Find = tab_1.tabpage_browse.dw_browse.find("doc_id="+string(ll_doc_id)+" and level=2",1,tab_1.tabpage_browse.dw_browse.rowcount())
do while li_Find > 0 
	tab_1.tabpage_browse.dw_browse.deleterow( li_find)
	li_Find = tab_1.tabpage_browse.dw_browse.find("doc_id="+string(ll_doc_id)+" and level=2",1,tab_1.tabpage_browse.dw_browse.rowcount())
loop

tab_1.tabpage_browse.dw_browse.setitem( ll_row,'style','+')
tab_1.tabpage_browse.dw_browse.setitem( ll_row,'audit_count',1)

tab_1.tabpage_browse.dw_browse.Setredraw( True )

Return 1

end function

public subroutine of_previewdoc ();//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_dm_data.of_previewdoc()
// $<arguments>(None)
// $<returns> (none)
// $<description>Select operation: get and open word document
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.11.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////
long ll_row
integer li_rtn
string ls_doc_ext, ls_filename, ls_filename_tmp

//Reset preview tabage if current file not specified
ll_row  = tab_1.tabpage_browse.dw_browse.getrow()
IF ll_row < 1 THEN
	inv_ole_utils_doc.of_displayfile(ls_filename,TRUE)
	of_filter_clause(il_doc_id,idc_revision)
	//of_getchanges()
	RETURN
END IF

//Check whether this file is already opened in preview tabpage
IF il_doc_id = il_preview_doc_id AND idc_revision = idc_preview_revision THEN 
	RETURN 
Else
	ib_merged_data = false
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 05.05.2007 By: Jack
	//$<reason> Fix a defect.
	/*
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergedata,'toolbaritemdown', False)
	*/
	If isvalid(m_pfe_cst_mdi_menu_contract_am) Then
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergedata,'toolbaritemdown', False)
	End If
	//---------------------------- APPEON END ----------------------------
END IF

////Filter clause map
//of_filter_clause(il_doc_id,idc_revision)
//
Openwithparm(w_appeon_gifofwait, "Opening the selected document...")

//Choose OLE control for different type of document
of_selectole(is_doc_ext)

//Get the file 
//ls_filename = inv_ole_utils_doc.of_Getfile(il_doc_id,idc_revision,is_doc_ext,idt_modify_date)
ls_filename = inv_dm_utils.of_download_file( il_doc_id, idc_revision)

// Added by davis, make sure this file can't be occupy, so save as the file
IF FileExists(ls_filename) THEN
//	IF inv_ole_utils_doc.of_isreadonly() THEN
//		//Get and Set user rights on document level
//		is_doc_right = of_setdocumentrights()				
//		//Open the file
		li_rtn = inv_ole_utils_doc.of_displayfile(ls_filename, TRUE)
		is_opened_file = ls_filename
//	ELSE
//		ls_filename_tmp = inv_dm_utils.of_generate_tempname_writable( il_doc_id, idc_revision, "doc")
//		If inv_filesvr.of_filecopy( ls_filename, ls_filename_tmp ) = 1 Then
//			IF FileExists(ls_filename_tmp) THEN 	
//				//Get and Set user rights on document level
//				is_doc_right = of_setdocumentrights()				
//				//Open the file
//				li_rtn = inv_ole_utils_doc.of_displayfile(ls_filename_tmp, FALSE) 
//				is_opened_file = ls_filename_tmp
//			END If
//		End If
//	END IF
END IF
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.07.2007 By: Machongmin
//$<reason> Fix a defect.
/*
w_appeon_gifofwait.event timer()
*/
if isvalid(w_appeon_gifofwait) then
	if w_appeon_gifofwait.hpb_1.position < 80 then
		w_appeon_gifofwait.hpb_1.position = 80
	end if
end if
//---------------------------- APPEON END ----------------------------
IF li_rtn < 1 THEN
	il_preview_doc_id = -1
	idc_preview_revision = 0
ELSE
	il_preview_doc_id = il_doc_id
	idc_preview_revision = idc_revision
//	//Get change list //add If statement by alfee at 03.14.2007 for performance
//	IF tab_1.tabpage_preview.dw_change.visible THEN of_getchanges()
//	//Set review toolbar 
//	inv_ole_utils_doc.of_setreviewstatus() 
//	//Set approve/reject button //add If statement by alfee at 03.14.2007 for performance
//	IF tab_1.tabpage_preview.dw_change.visible THEN of_setreviewbutton()				
//	//Get user rights on clause level
//	of_getclauserights()
END IF

///////////////////////////////////////////////////////////////////////
//// Trigger off audit trail
///////////////////////////////////////////////////////////////////////
//IF tab_1.tabpage_browse.dw_browse.object.level[tab_1.tabpage_browse.dw_browse.getrow()] = 1 THEN
//	str_add_audit lstr_add_audit
//	lstr_add_audit.doc_id = il_doc_id
//	lstr_add_audit.revision = idc_revision
//	lstr_add_audit.doc_ext = is_doc_ext
//	lstr_add_audit.action = "Viewed"
//	inv_dm_utils.of_add_audit_trail( lstr_add_audit )
//END IF

//Added by Davis 02.09.2007
IF Upper(tab_1.tabpage_browse.dw_browse.object.doc_type[tab_1.tabpage_browse.dw_browse.getrow()]) = "S" THEN
	IF tab_1.tabpage_preview.ole_doc.object.activedocument.Fields.Count > 0 THEN 
	//IF tab_1.tabpage_preview.ole_doc.object.activedocument.MailMerge.Fields.Count > 0 THEN 
		THIS.Event ue_mergedata('auto')
	END IF
END IF

IF Isvalid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)
end subroutine

public subroutine of_previewimage ();//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_dm_data.of_previewimage()
// $<arguments>(None)
// $<returns> (none)
// $<description>Select operation: get and open document
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.11.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////
long ll_row, ll_doc_id
decimal ldc_revision
datetime ldt_modify_date
string ls_doc_ext, ls_filename
Integer li_rtn 

//Check whether this file is already opened in preview tabpage
IF il_doc_id = il_preview_doc_id AND idc_revision = idc_preview_revision THEN 
	RETURN 
END IF

//Choose OLE control for different type of document
of_selectole(is_doc_ext)

//Load image document
//-----------Begin Modified by Alfee on 05.19.2008 ----------------	
//li_rtn = tab_1.tabpage_preview.uo_1.event ue_load_image2(il_doc_id,idc_revision,is_doc_ext)
IF gi_imageocx = 1 THEN //Imaging 360
	//li_rtn = tab_1.tabpage_preview.uo_1.event ue_load_image2(il_doc_id,idc_revision,is_doc_ext)
ELSE	//new Image OCX
	li_rtn = tab_1.tabpage_preview.uo_2.event ue_load_image2(il_doc_id,idc_revision,is_doc_ext)
END IF
//-----------End Modified -----------------------------------------
IF li_rtn > 0 THEN
	il_preview_doc_id = il_doc_id
	idc_preview_revision = idc_revision
END IF	

///////////////////////////////////////////////////////////////////////
//// Trigger off audit trail
///////////////////////////////////////////////////////////////////////
IF tab_1.tabpage_browse.dw_browse.object.level[tab_1.tabpage_browse.dw_browse.getrow()] = 1 THEN
	str_add_audit lstr_add_audit
	lstr_add_audit.doc_id = il_doc_id
	lstr_add_audit.revision = idc_revision
	lstr_add_audit.doc_ext = is_doc_ext
	lstr_add_audit.action = "Viewed"
	inv_dm_utils.of_add_audit_trail( lstr_add_audit )
END IF
end subroutine

public subroutine of_selectole (string as_doctype);//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_dm_dataof_showole()
// $<arguments>
//		value	string	as_doctype		
// $<returns> (none)
// $<description>Choose ole control for different type of document
//////////////////////////////////////////////////////////////////////
// $<add> 01.17.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////

IF lower(as_doctype) = 'doc' THEN
	//tab_1.tabpage_preview.uo_1.visible = false
	tab_1.tabpage_preview.uo_2.visible = false //Alfee 05.19.2008	
	tab_1.tabpage_preview.ole_doc.visible = true
	//tab_1.tabpage_preview.dw_head.visible = true
	of_maponoff(ib_showclausemap)	
ELSE
	//--------Begin Modified by Alfee on 05.19.2008 -----
	//tab_1.tabpage_preview.uo_1.visible = true
	IF gi_imageocx = 1 THEN //imaging 360
		//tab_1.tabpage_preview.uo_1.visible = true
		tab_1.tabpage_preview.uo_2.visible = false	
	ELSE  //New Image OCX
		//tab_1.tabpage_preview.uo_1.visible = false
		tab_1.tabpage_preview.uo_2.visible = true		
	END IF
	//--------End Modified ------------------------------
	tab_1.tabpage_preview.ole_doc.visible = false	
	tab_1.tabpage_preview.gb_map.visible = false
	tab_1.tabpage_preview.dw_clause.visible = false
	tab_1.tabpage_preview.dw_change.visible = false
	tab_1.tabpage_preview.cb_approve.visible = false
	tab_1.tabpage_preview.cb_reject.visible = false
	tab_1.tabpage_preview.cb_original.visible = false	
END IF
//-------------Appeon Begin -----by Derek at 03.13.2007---------
//tab_1.tabpage_preview.cb_1.visible = true
//-------------Appeon end --------------------------------------



end subroutine

public function integer of_getclauserights ();//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_dm_data.of_getclauserights()
// $<arguments>(None)
// $<returns> (none)
// $<description>Get all user rights on clause level
//////////////////////////////////////////////////////////////////////
// $<add> 01.23.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////

Long ll_row, ll_cnt, i
Long ll_clauseid[]
String ls_rights[]

ll_row = tab_1.tabpage_browse.dw_browse.GetRow()
IF ll_row < 1 Then RETURN -1

//Get user rights on clause level
ll_cnt = tab_1.tabpage_preview.dw_clause.RowCount()
FOR i = 1 TO ll_cnt
	ll_clauseid[i] = tab_1.tabpage_preview.dw_clause.GetItemNumber(i,"ctx_acp_clause_id")
NEXT
ids_clause_right = inv_ole_utils_doc.of_getclauserights(gs_user_id, 2, ll_clauseid)

//Add IF statement by alfee at 03.14.2007 for save performance tunning
IF tab_1.tabpage_preview.dw_clause.visible THEN
	//Get clauses' status according to revisions
	inv_ole_utils_doc.of_getclausestatus(ll_clauseid, ls_rights)
	
	//Set flag in clause datawindow by user rights
	of_setclausestatus(ls_rights)
END IF

RETURN 1

end function

public subroutine of_setpreviewmenu ();//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_dm_data.of_setpreviewmenu()
// $<arguments>
//		value			
// $<returns> integer
// $<description>Set menu for preview according to user rights 
//////////////////////////////////////////////////////////////////////
// $<add> 01.23.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////

This.Post Event ue_set_security()
end subroutine

public function integer of_updateclausemap (string as_filename, decimal adec_new_revision);//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_dm_dataof_updateclausemap()
// $<arguments>
//		value	string 	as_filename      		
//		value	decimal	adec_new_revision		
// $<returns> integer
// $<description>Update clause map table for the document checked in
//////////////////////////////////////////////////////////////////////
// $<add> 01.25.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////
//Note: This function in u_tabpg_dm_email will never be called

Integer i, j, li_rtn
Long ll_cnt, ll_doc_id, ll_clause_id
Decimal ldec_revision
String ls_bookmark, ls_bm[], ls_temp_file
Boolean lb_found
Oleobject lole_word, lole_document

lole_word = Create Oleobject
lole_document = Create Oleobject

//If no clause existed in current revision, then return
ll_cnt = tab_1.tabpage_preview.dw_clause.RowCount()
IF ll_cnt < 1 THEN RETURN 1

//Copy to a temporary file
IF not FileExists(as_filename) THEN RETURN -1
ls_temp_file = inv_ole_utils_doc.is_agreement_path + "tem_" + String(Rand(1000)) +".doc"
IF FileCopy(as_filename, ls_temp_file, TRUE) < 0 THEN RETURN -1 

//Open the file with readonly property in a new word application
IF lole_word.Connecttonewobject("word.application") <> 0 THEN
	Destroy lole_word 
	Destroy lole_document
	messagebox('Client Error', 'This application could not connect to Microsoft Word. Please make sure it is properly installed.')
	RETURN -1
END IF

	
lole_word.Visible = FALSE
lole_word.Application.NormalTemplate.Saved = TRUE //Alfee 01.17.2008
lole_word.Application.Documents.Open(ls_temp_file,FALSE,TRUE)
gnv_word_utility.of_modify_word_property( lole_word.Activedocument)	//Added By Mark Lee 06/20/2013 change for office 2013.
gnv_shell.of_delete_recent( ls_temp_file, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
lole_document = lole_word.ActiveDocument
IF Not IsValid(lole_document) OR IsNull(lole_document) THEN 
	lole_word.Quit(0)
	lole_word.DisconnectObject( )
	Destroy lole_word
	RETURN -1
END IF

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


//Veision control
ll_doc_id = tab_1.tabpage_preview.dw_clause.GetItemNumber(1,"doc_id")
ldec_revision = tab_1.tabpage_preview.dw_clause.GetItemDecimal(1,"revision")
IF adec_new_revision <> ldec_revision THEN
	//Copy old revision to new revision and reset old revision
	ids_clause_temp.Reset()
	tab_1.tabpage_preview.dw_clause.AcceptText()
	tab_1.tabpage_preview.dw_clause.RowsCopy(1, ll_cnt, Primary!, ids_clause_temp, 1, Primary!)	
	FOR i = 1 to ll_cnt
		ids_clause_temp.SetItem(i,"revision",adec_new_revision)
	Next
	tab_1.tabpage_preview.dw_clause.Reset()	
	ids_clause_temp.RowsCopy(1, ll_cnt, Primary!, tab_1.tabpage_preview.dw_clause, 1, Primary!)		
END IF	

//update dw_clause according to bookmarks
For i =  1 to ll_cnt
	ll_clause_id = tab_1.tabpage_preview.dw_clause.object.ctx_acp_clause_id[i]
	lb_found = False
	For j =  1 to Upperbound(ls_bm)
		IF ls_bm[j] = "clause_" + string(ll_clause_id) THEN
			lb_found = True
			EXIT				
		END IF
	Next
	IF not lb_found THEN
		tab_1.tabpage_preview.dw_clause.DeleteRow(i)
		i = i -1
		ll_cnt = ll_cnt -1
	END IF
NEXT
li_rtn = tab_1.tabpage_preview.dw_clause.Update() 

//Refresh user rights on clause level
of_getclauserights()

lole_document.Close(0)
lole_word.Quit(0)
lole_word.DisconnectObject( )
Destroy lole_document
Destroy lole_word

FileDelete(ls_temp_file)

RETURN li_rtn
end function

public function integer of_updateclausemap (decimal adec_new_revision);//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_dm_data.of_updateclausemap()
// $<arguments>decimal adec_new_revision
// $<returns> integer
// $<description>Update clause map table accordingly
//////////////////////////////////////////////////////////////////////
// $<add> 01.22.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////

//Integer i,j, li_rtn
//Long ll_doc_id, ll_clause_id, ll_cnt
//Decimal ldec_revision
//Boolean lb_found 
//String ls_bookmark[]
//
////If no clause for new revision, then return
//ll_cnt = tab_1.tabpage_preview.dw_clause.RowCount()
//IF ll_cnt < 1 THEN RETURN -1
//
////Get bookmarks from document
//inv_ole_utils_doc.of_getbookmarks(ls_bookmark)
//
////Veision control
//ll_doc_id = tab_1.tabpage_preview.dw_clause.GetItemNumber(1,"doc_id")
//ldec_revision = tab_1.tabpage_preview.dw_clause.GetItemDecimal(1,"revision")
//IF adec_new_revision <> ldec_revision THEN
//	//Copy old revision to new revision and reset old revision
//	ids_clause_temp.Reset()
//	tab_1.tabpage_preview.dw_clause.AcceptText()
//	tab_1.tabpage_preview.dw_clause.RowsCopy(1, ll_cnt, Primary!, ids_clause_temp, 1, Primary!)	
//	FOR i = 1 to ll_cnt
//		ids_clause_temp.SetItem(i,"revision",adec_new_revision)
//	Next
//	tab_1.tabpage_preview.dw_clause.Reset()	
//	ids_clause_temp.RowsCopy(1, ll_cnt, Primary!, tab_1.tabpage_preview.dw_clause, 1, Primary!)		
//END IF	
//
////update dw_clause according to bookmarks
//For i =  1 to ll_cnt
//	ll_clause_id = tab_1.tabpage_preview.dw_clause.getitemnumber(i,"ctx_acp_clause_id")
//	lb_found = False
//	For j =  1 to Upperbound(ls_bookmark)
//		IF ls_bookmark[j] = "clause_" + string(ll_clause_id) THEN
//			lb_found = True
//			EXIT				
//		END IF
//	Next
//	IF not lb_found THEN
//		tab_1.tabpage_preview.dw_clause.DeleteRow(i)
//		i = i -1
//		ll_cnt = ll_cnt -1
//	END IF
//NEXT
//li_rtn = tab_1.tabpage_preview.dw_clause.Update() 
//
////Refresh user rights on clause level
//of_getclauserights()

RETURN 1
end function

public function integer of_mergefile (long al_clauseid[], string as_rights[]);//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_dm_data.of_mergefile()
// $<arguments>
//		long	al_clauseid[]		
// $<returns> integer
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.12.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////

//return inv_ole_utils_doc.of_mergefile(al_clauseid,as_rights)
return 1
end function

public function integer of_setclauserights (datastore ads_clause_right);Long ll_cnt, i, ll_find, ll_clauseid
String ls_rights

ids_clause_right = ads_clause_right

ll_cnt = tab_1.tabpage_preview.dw_clause.RowCount()
FOR i = 1 TO ll_cnt
	ll_clauseid = tab_1.tabpage_preview.dw_clause.GetItemNumber(i,"ctx_acp_clause_id")
	ll_find = ids_clause_right.Find("ctx_acp_clause_id = " + String(ll_clauseid),1,ll_cnt)	
	IF ll_find > 0 THEN
		ls_rights = ids_clause_right.GetItemString(ll_find,"description")
		CHOOSE CASE lower(ls_rights)
			CASE "editing with approval"
				 tab_1.tabpage_preview.dw_clause.object.disp_flag[ll_find] = 0 //red
			CASE "adding with approval"
				 tab_1.tabpage_preview.dw_clause.object.disp_flag[ll_find] = 1 //blue
			CASE ELSE	 
				 tab_1.tabpage_preview.dw_clause.object.disp_flag[ll_find] = -1
		END CHOOSE
	END IF	
NEXT

RETURN 1
end function

public subroutine of_setreviewbutton ();//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_dm_dataof_setreviewbutton()
// $<arguments>(None)
// $<returns> (none)
// $<description>
// $<description>Set approve/reject button according to user rights
//////////////////////////////////////////////////////////////////////
// $<add> 01.26.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////

CHOOSE CASE lower(is_doc_right) 
	CASE  "no editing", "editing with approval" //no "", by alfee at 03.13.2007
		tab_1.tabpage_preview.cb_approve.Enabled = FALSE
		tab_1.tabpage_preview.cb_reject.Enabled = FALSE
	CASE ELSE		
		//Set button on clause level
		CHOOSE CASE lower(is_clause_right)
			CASE "full access",""  //"",by alfee at 03.13.2007
				IF tab_1.tabpage_preview.ole_doc.Object.ActiveDocument.Revisions.Count > 0 Then
					tab_1.tabpage_preview.cb_approve.Enabled = TRUE
					tab_1.tabpage_preview.cb_reject.Enabled = TRUE
				ELSE
					tab_1.tabpage_preview.cb_approve.Enabled = FALSE
					tab_1.tabpage_preview.cb_reject.Enabled = FALSE
				END IF
			CASE "no editing","editing with approval","no adding","adding with approval"
				tab_1.tabpage_preview.cb_approve.Enabled = FALSE
				tab_1.tabpage_preview.cb_reject.Enabled = FALSE
			CASE else
				tab_1.tabpage_preview.cb_approve.Enabled = FALSE
				tab_1.tabpage_preview.cb_reject.Enabled = FALSE				
		END CHOOSE
END CHOOSE


end subroutine

public function string of_setdocumentrights ();//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_dm_data.of_setdocumentrights
// $<arguments>(None)
// $<returns> (none)
// $<description>Get user rights and set status on document level
//////////////////////////////////////////////////////////////////////
// $<add> 01.23.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////

Long ll_category, ll_row
String ls_doc_rights

ll_row = tab_1.tabpage_browse.dw_browse.GetRow()
IF ll_row < 1 Then RETURN ""

//Get user rights on document level
ll_category = tab_1.tabpage_browse.dw_browse.GetItemNumber(ll_row,"category")
ls_doc_rights = inv_ole_utils_doc.of_getdocumentrights(gs_user_id,il_doc_id,ll_category)

//Set document readonly status according to the user rights
inv_ole_utils_doc.of_setdocumentstatus(ls_doc_rights)

//Set preview menu according to the user rights
of_setpreviewmenu()

RETURN ls_doc_rights


end function

public function integer of_setclausestatus (string as_rights[]);//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_dm_data.of_setclausestatus()
// $<arguments>
//		value	string	as_rights[]		
// $<returns> integer
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.30.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////

Long ll_cnt, i

ll_cnt = tab_1.tabpage_preview.dw_clause.RowCount()
IF ll_cnt > UpperBound(as_rights) THEN ll_cnt = UpperBound(as_rights)

tab_1.tabpage_preview.dw_clause.setredraw(false)
FOR i = 1 TO ll_cnt
	CHOOSE CASE lower(as_rights[i])
		CASE "editing with approval"
			 tab_1.tabpage_preview.dw_clause.object.disp_flag[i] = 0 //red
		CASE "adding with approval"
			 tab_1.tabpage_preview.dw_clause.object.disp_flag[i] = 1 //blue
		CASE ELSE	 
			 tab_1.tabpage_preview.dw_clause.object.disp_flag[i] = -1
	END CHOOSE
NEXT
tab_1.tabpage_preview.dw_clause.setredraw(true)

RETURN 1
end function

public subroutine of_add_merge_field (string is_merge_field);

If not len(is_merge_field) > 0 Then 
	return
End If

//Insert field
inv_ole_utils_doc.of_insertfield(is_merge_field)
end subroutine

public subroutine of_set_default ();il_org_ctx_id = inv_contract_details.of_get_ctx_id( ) 
il_ctx_id = il_org_ctx_id
rb_current.Text = 'Current - ' + String(il_org_ctx_id)
rb_current.checked = True

end subroutine

public subroutine of_filter_category (ref datastore adw_data);n_cst_right lnv_right

If gnv_data.of_getitem( 'icred_settings', 'filter_documents', False) = '0' Then Return

lnv_right = Create n_cst_right
lnv_right.of_filter_right( adw_data, 'category', 1)
Destroy lnv_right
end subroutine

public function integer of_filter_clause (long ai_doc_id, decimal adc_revision);//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_dm_dataof_filter_clause()
// $<arguments>
//		value	integer	ai_doc_id   		
//		value	decimal	adc_revision		
// $<returns> integer
// $<description>filter clauses according to doc id & revision
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.12.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////

//string ls_filter
//if isnull(ai_doc_id) or isnull(adc_revision) then 
//	ls_filter = "1=2"
//else
//	ls_filter ="doc_id = "+string(ai_doc_id) + " and revision = " + string(adc_revision)
//end if
//tab_1.tabpage_preview.dw_clause.setfilter(ls_filter)

//filter clauses
ib_locate = false 
//tab_1.tabpage_preview.dw_clause.filter()
tab_1.tabpage_preview.dw_clause.retrieve(ai_doc_id,adc_revision)
ib_locate = true

//locate in file
if tab_1.selectedtab = 2 then this.event ue_locatefile()

return 1
end function

on u_tabpg_dm_email.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.rb_current=create rb_current
this.rb_other=create rb_other
this.pb_browse=create pb_browse
this.st_other=create st_other
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.rb_current
this.Control[iCurrent+3]=this.rb_other
this.Control[iCurrent+4]=this.pb_browse
this.Control[iCurrent+5]=this.st_other
this.Control[iCurrent+6]=this.gb_1
end on

on u_tabpg_dm_email.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.rb_current)
destroy(this.rb_other)
destroy(this.pb_browse)
destroy(this.st_other)
destroy(this.gb_1)
end on

event constructor;call super::constructor;inv_filesvr = create n_cst_filesrvwin32
This.of_setupdateable( FALSE )
this.of_setresize( true)
this.inv_resize.of_register( tab_1,inv_resize.scalerightbottom)
this.inv_resize.of_register( tab_1.tabpage_browse.dw_filter,inv_resize.scaleright)
this.inv_resize.of_register( tab_1.tabpage_browse.dw_browse,inv_resize.scalerightbottom)
this.inv_resize.of_register( tab_1.tabpage_preview.dw_head,inv_resize.scaleright)
this.inv_resize.of_register( tab_1.tabpage_preview.ole_doc,inv_resize.scalerightbottom)
//this.inv_resize.of_register( tab_1.tabpage_preview.uo_1,inv_resize.scalerightbottom)
this.inv_resize.of_register( tab_1.tabpage_preview.uo_2,inv_resize.scalerightbottom) //Alfee 05.19.2008

this.inv_resize.of_register( tab_1.tabpage_preview.gb_map,inv_resize.scalebottom)
this.inv_resize.of_register( tab_1.tabpage_preview.dw_change,inv_resize.scalebottom)
this.inv_resize.of_register( tab_1.tabpage_preview.cb_approve,inv_resize.fixedbottom)
this.inv_resize.of_register( tab_1.tabpage_preview.cb_reject,inv_resize.fixedbottom)
this.inv_resize.of_register( tab_1.tabpage_preview.cb_original,inv_resize.fixedbottom)

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 02.09.2007 By: Jack (Document Manager)
//$<reason> Fix a defect.
ids_clause_temp = Create datastore
ids_clause_temp.dataobject = 'd_dm_clause_map'
ids_clause_temp.settransobject(sqlca)

ids_clause_right = Create datastore
ids_clause_right.dataobject = 'd_dm_clause_rights'
ids_clause_right.settransobject(sqlca)

ids_changes = Create datastore
ids_changes.dataobject = 'd_dm_change_list'
ids_changes.settransobject(sqlca)
//---------------------------- APPEON END ----------------------------

//Added By Ken.Guo 2010-02-05.
String ls_express
If gnv_data.of_getitem( 'icred_settings','doc_name_format', False) = '0' Then 
	tab_1.tabpage_browse.dw_browse.Modify('doc_name_full.Expression = "doc_name" ')
Else
	tab_1.tabpage_browse.dw_browse.Modify('doc_name_full.Expression = "doc_name + ~' ~' + String( doc_id )+ ~'.~' + String( revision ,~'##0.0~')" ')
End If
end event

event ue_set_security;//Integer li_setting
//
//If Not isvalid(m_pfe_cst_mdi_menu_contract_am) Then Return
//w_mdi.setredraw(false)
//If w_mdi.of_security_access( 6903 ) = 0 Then
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_properties0.toolbaritemvisible = False
//Else
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_properties0.toolbaritemvisible = True
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_properties0.enabled = True	
//End If
//If w_mdi.of_security_access( 6905 ) = 0 Then
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_email0.toolbaritemvisible = False
//Else
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_email0.toolbaritemvisible = True
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_email0.enabled = True
//End If
//
//If w_mdi.of_security_access( 6906 ) = 0 And w_mdi.of_security_access( 6907 ) = 0 And w_mdi.of_security_access( 6908 ) = 0 And w_mdi.of_security_access( 6909 ) = 0 Then
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.toolbaritemvisible = False	
//Else
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.toolbaritemvisible = True			
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.enabled = True			
//End If
//
//If w_mdi.of_security_access( 6907 ) = 0 Then
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_email1.toolbaritemvisible = False
//Else
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_email1.toolbaritemvisible = True
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_email1.enabled = True
//End If
//If w_mdi.of_security_access( 6909 ) = 0 Then
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_saveas.toolbaritemvisible = False
//Else
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_saveas.toolbaritemvisible = True
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_saveas.enabled = True
//End If
//
////--------------------------- APPEON BEGIN ---------------------------
////$<add> 2007-02-25 By: Rodger Wu (add other)
//integer li_addbuy, li_addsell, li_addother, li_temp
////---------------------------- APPEON END ----------------------------
//
//li_setting = of_get_app_setting("set_51","I")
//CHOOSE CASE li_setting
//	CASE 0	//OFF
//	CASE 1	//Buy/Sell
//		//--------------------------- APPEON BEGIN ---------------------------
//		//$<add> 2007-02-25 By: Rodger Wu (add other)
//		
//		if w_mdi.of_security_access( 6901 ) > 0 then li_addbuy = 1
//		if w_mdi.of_security_access( 6902 ) > 0 then li_addsell = 1
//		if w_mdi.of_security_access( 6926 ) > 0 then li_addother = 1
//		
//		li_temp = li_addbuy + li_addsell + li_addother
//		//---------------------------- APPEON END ----------------------------
//
//		//--------------------------- APPEON BEGIN ---------------------------
//		//$<modify> 2007-02-25 By: Rodger Wu (add other)
//		/*
//		If w_mdi.of_security_access( 6901 ) = 0 And w_mdi.of_security_access( 6902 ) = 0 Then
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.toolbaritemvisible = False
//		Else
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.toolbaritemvisible = True
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.enabled = True
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.dropdown= True
//		End If
//		*/
//		If li_temp = 0 then
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.toolbaritemvisible = False
//		Elseif li_temp = 1 then
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.dropdown= False
//		Else
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.dropdown= True
//		End If
//		//---------------------------- APPEON END ----------------------------
//		
//		If w_mdi.of_security_access( 6901 ) = 0 Then
//			//--------------------------- APPEON BEGIN ---------------------------
//			//$<comment> 2007-02-25 By: Rodger Wu (add other)
//			/* m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.dropdown = False */
//			//---------------------------- APPEON END ----------------------------
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addbuy.toolbaritemvisible = False
//		Else
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addbuy.toolbaritemvisible = True			
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addbuy.enabled = True
//		End If
//		
//		If w_mdi.of_security_access( 6902 ) = 0 Then
//			//--------------------------- APPEON BEGIN ---------------------------
//			//$<comment> 2007-02-25 By: Rodger Wu (add other)
//			/* m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.dropdown = False */
//			//---------------------------- APPEON END ----------------------------
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addsell.toolbaritemvisible = False
//		Else
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addsell.toolbaritemvisible = True
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addsell.enabled = True
//		End If
//
//		//--------------------------- APPEON BEGIN ---------------------------
//		//$<add> 2007-02-25 By: Rodger Wu (add other)
//		If w_mdi.of_security_access( 6926 ) = 0 Then
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addother.toolbaritemvisible = False
//		Else
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addother.toolbaritemvisible = True
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addother.enabled = True
//		End If
//		//---------------------------- APPEON END ----------------------------
//
//	CASE 2	//Sell
//		//--------------------------- APPEON BEGIN ---------------------------
//		//$<add> 2007-02-25 By: Rodger Wu (add other)
//		
//		if w_mdi.of_security_access( 6902 ) > 0 then li_addsell = 1
//		if w_mdi.of_security_access( 6926 ) > 0 then li_addother = 1
//		
//		li_temp = li_addother + li_addsell
//		//---------------------------- APPEON END ----------------------------
//
//		//--------------------------- APPEON BEGIN ---------------------------
//		//$<add> 2007-02-25 By: Rodger Wu (add other)
//		If li_temp = 0 then
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.toolbaritemvisible = False
//		Elseif li_temp = 1 then
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.dropdown= False
//		Else
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.dropdown= True
//		End If
//		//---------------------------- APPEON END ----------------------------
//
//		m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addbuy.toolbaritemvisible = False			
//		If w_mdi.of_security_access( 6902 ) = 0 Then
//			//--------------------------- APPEON BEGIN ---------------------------
//			//$<comment> 2007-02-25 By: Rodger Wu (add other)
//			/* m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.dropdown = False */
//			//---------------------------- APPEON END ----------------------------
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addsell.toolbaritemvisible = False
//		Else
//			//--------------------------- APPEON BEGIN ---------------------------
//			//$<comment> 2007-02-25 By: Rodger Wu (add other)
//			/* m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.dropdown = False */
//			//---------------------------- APPEON END ----------------------------
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.toolbaritemvisible = True
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addsell.toolbaritemvisible = True
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addsell.enabled = True
//		End If
//
//		//--------------------------- APPEON BEGIN ---------------------------
//		//$<add> 2007-02-25 By: Rodger Wu (add other)
//		If w_mdi.of_security_access( 6926 ) = 0 Then
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addother.toolbaritemvisible = False
//		Else
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addother.toolbaritemvisible = True
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addother.enabled = True
//		End If
//		//---------------------------- APPEON END ----------------------------
//
//	CASE 3	//Buy
//
//		//--------------------------- APPEON BEGIN ---------------------------
//		//$<add> 2007-02-25 By: Rodger Wu (add other)
//		
//		if w_mdi.of_security_access( 6901 ) > 0 then li_addbuy = 1
//		if w_mdi.of_security_access( 6926 ) > 0 then li_addother = 1
//		
//		li_temp = li_addbuy + li_addother
//		//---------------------------- APPEON END ----------------------------
//
//		//--------------------------- APPEON BEGIN ---------------------------
//		//$<add> 2007-02-25 By: Rodger Wu (add other)
//		If li_temp = 0 then
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.toolbaritemvisible = False
//		Elseif li_temp = 1 then
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.dropdown= False
//		Else
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.dropdown= True
//		End If
//		//---------------------------- APPEON END ----------------------------
//		
//		m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addsell.toolbaritemvisible = False
//		If w_mdi.of_security_access( 6901 ) = 0 Then
//			//--------------------------- APPEON BEGIN ---------------------------
//			//$<comment> 2007-02-25 By: Rodger Wu (add other)
//			/* m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.dropdown = False */
//			//---------------------------- APPEON END ----------------------------
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addbuy.toolbaritemvisible = False
//		Else
//			//--------------------------- APPEON BEGIN ---------------------------
//			//$<comment> 2007-02-25 By: Rodger Wu (add other)
//			/* m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.dropdown = False */
//			//---------------------------- APPEON END ----------------------------
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.toolbaritemvisible = True
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addbuy.toolbaritemvisible = True			
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addbuy.enabled = True
//		End If
//
//		//--------------------------- APPEON BEGIN ---------------------------
//		//$<add> 2007-02-25 By: Rodger Wu (add other)
//		If w_mdi.of_security_access( 6926 ) = 0 Then
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addother.toolbaritemvisible = False
//		Else
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addother.toolbaritemvisible = True
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addother.enabled = True
//		End If
//		//---------------------------- APPEON END ----------------------------
//
//End CHOOSE
//
//If tab_1.tabpage_browse.dw_browse.rowcount() > 0 Then
//	//For Check in & out
//	If tab_1.tabpage_browse.dw_browse.getitemnumber(tab_1.tabpage_browse.dw_browse.getrow(),'level') = 1 Then
//		// LEVEL 1
//		If tab_1.tabpage_browse.dw_browse.object.revision_control[tab_1.tabpage_browse.dw_browse.getrow()] = "1" Then
//			If tab_1.tabpage_browse.dw_browse.object.checkout_status[tab_1.tabpage_browse.dw_browse.getrow()] = "0" Then
//				If w_mdi.of_security_access( 6911 ) = 0 Then
//					m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkout.toolbaritemvisible = False	
//				Else
//					m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkout.toolbaritemvisible = True
//					m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkout.enabled = True
//					m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_revision0.toolbaritemvisible = False			
//				End If												
//				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkin.toolbaritemvisible = False
//			ElseIf tab_1.tabpage_browse.dw_browse.object.checkout_status[tab_1.tabpage_browse.dw_browse.getrow()] = "1" Then
//				If w_mdi.of_security_access( 6910 ) = 0 Then
//					m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkin.toolbaritemvisible = False
//				Else
//					m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkin.toolbaritemvisible = True
//					m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkin.enabled = True
//					m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_revision0.toolbaritemvisible = False			
//				End If
//				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkout.toolbaritemvisible = False	
//			End If
//		Else
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.toolbaritemvisible = False	
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkin.toolbaritemvisible = False			
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkout.toolbaritemvisible = False					
//		End If
//	End If
//	
//	CHOOSE CASE tab_1.Selectedtab
//		CASE 1	// BROWSE TAB
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_select.toolbaritemvisible = True	
//
//			If w_mdi.of_security_access( 6904 ) = 0 Then
//				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_report.toolbaritemvisible = False			
//			Else
//				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_report.toolbaritemvisible = True			
//				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_report.enabled = True			
//			End If
//
//			If w_mdi.of_security_access( 6922 ) = 0 Then
//				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_delete0.toolbaritemvisible = False
//			Else
//				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_delete0.toolbaritemvisible = True
//				If m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkin.toolbaritemvisible = True Then
//					m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_delete0.enabled = False	
//				Else
//					m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_delete0.enabled = True
//				End If
//			End If
//			
//			If w_mdi.of_security_access( 6921 ) = 0 Then
//				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_revision0.toolbaritemvisible = False			
//			Else
//				If tab_1.tabpage_browse.dw_browse.getitemstring(tab_1.tabpage_browse.dw_browse.getrow(),'revision_control') = "0" Then
//					m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_revision0.toolbaritemvisible = True				
//					m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_revision0.enabled = True	
//					m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkin.toolbaritemvisible = False
//					m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkout.toolbaritemvisible = False	
//					m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_delete0.enabled = True
//				End If	
//			End If	
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_save0.toolbaritemvisible = False			
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_print0.toolbaritemvisible = False			
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_addclause.toolbaritemvisible = False					
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.toolbaritemvisible = False	
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergefield.toolbaritemvisible = False			
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergedata.toolbaritemvisible = False		
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_clausemap.toolbaritemvisible = False
////			//--------------------------- APPEON BEGIN ---------------------------
////			//Added by alfee at 2007.03.06
////			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0.toolbaritemvisible = False	
////			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0.m_autonum1.toolbaritemvisible = False
////			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0.m_autonum2.toolbaritemvisible = False
////			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0.m_autonum3.toolbaritemvisible = False
////			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0.m_autonum4.toolbaritemvisible = False
////			//--------------------------- APPEON END ---------------------------	
//			
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.toolbaritemvisible = true					
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addbuy.toolbaritemvisible = true			
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addsell.toolbaritemvisible = true
//			
//		CASE 2	// PREVIEW TAB		
//			//Show toolbars of perview tabpage
//			If w_mdi.of_security_access( 6906 ) = 0 Then
//				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_print0.enabled = False			
//				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_print0.toolbaritemvisible = False
//			Else
//				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_print0.toolbaritemvisible = True				
//				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_print0.enabled = True			
//			End If
//			If w_mdi.of_security_access( 6912 ) = 0 Then
//				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_save0.toolbaritemvisible = False	
//			Else
//				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_save0.toolbaritemvisible = True	
//			End If
//			If w_mdi.of_security_access( 6913 ) = 0 Then
//				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_addclause.toolbaritemvisible = False
//			Else
//				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_addclause.toolbaritemvisible = True
//				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_addclause.enabled = True
//			End If
//			
//			If w_mdi.of_security_access( 6914 ) = 0 And w_mdi.of_security_access( 6915 ) = 0 Then
//				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.toolbaritemvisible = False	
//			Else
//				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.toolbaritemvisible = True	
//				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.enabled = True	
//			End If
//			
//			If w_mdi.of_security_access( 6914 ) = 0 Then
//				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergefield.toolbaritemvisible = False	
//			Else
//				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergefield.toolbaritemvisible = True	
//				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergefield.enabled = True	
//			End If
//						
//			If w_mdi.of_security_access( 6915 ) = 0 Then
//				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergedata.toolbaritemvisible = False	
//			Else
//				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergedata.toolbaritemvisible = True	
//				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergedata.enabled = True	
//			End If
//			
//			If w_mdi.of_security_access( 6917 ) = 0 Then
//				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_clausemap.toolbaritemvisible = False
//			Else
//				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_clausemap.toolbaritemvisible = True
//				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_clausemap.enabled = True
//			End If
//			//----Appeon Begin added by alfee at 03.14.2007---------
//			If w_mdi.of_security_access( 6921 ) = 0 Then
//				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_revision0.toolbaritemvisible = False			
//			Else
//				If tab_1.tabpage_browse.dw_browse.getitemstring(tab_1.tabpage_browse.dw_browse.getrow(),'revision_control') = "0" Then
//					m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_revision0.toolbaritemvisible = True				
//					m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_revision0.enabled = True	
//				END IF
//			END IF
//			//----Appeon End --------------------------------------		
////			//--------------------------- APPEON BEGIN ---------------------------
////			//Added by alfee at 2007.03.06
////			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0.enabled = True	
////			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0.m_autonum1.enabled = True
////			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0.m_autonum2.enabled = True
////			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0.m_autonum3.enabled = True
////			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0.m_autonum4.enabled = True
////			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0.toolbaritemvisible = True	
////			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0.m_autonum1.toolbaritemvisible = True
////			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0.m_autonum2.toolbaritemvisible = True
////			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0.m_autonum3.toolbaritemvisible = True
////			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0.m_autonum4.toolbaritemvisible = True
////			//--------------------------- APPEON END ---------------------------	
//			If tab_1.tabpage_browse.dw_browse.object.level[tab_1.tabpage_browse.dw_browse.getrow()] = 1 Then
//				If tab_1.tabpage_browse.dw_browse.object.checkout_status[tab_1.tabpage_browse.dw_browse.getrow()] = "0" Then
//					If m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkin.toolbaritemvisible = True Then						
//						m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_save0.enabled = False	
//					Else
//						m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_save0.enabled = True
//					End If
//				End If
//			End If
//			
//			//Hide toolbars for buy contract	document
//			//--------------------------- APPEON BEGIN ---------------------------
//			//$<modify> 2007-02-25 By: Rodger Wu (add other)
//			/* If lower(tab_1.tabpage_browse.dw_browse.getitemstring(tab_1.tabpage_browse.dw_browse.getrow(),'doc_type')) = "Buy" Then */
//			string ls_type
//			ls_type = lower(tab_1.tabpage_browse.dw_browse.getitemstring(tab_1.tabpage_browse.dw_browse.getrow(),'doc_type'))
//			If ls_type = "Buy" or ls_type = "Other" Then
//			//---------------------------- APPEON END ----------------------------
//				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_addclause.enabled = False
//				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.enabled = False	
//				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergefield.enabled = False	
//				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergedata.enabled = False
////				//--------------------------- APPEON BEGIN ---------------------------
////				//Added by alfee at 2007.03.06
////				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0.enabled = False	
////				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0.m_autonum1.enabled = False
////				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0.m_autonum2.enabled = False
////				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0.m_autonum3.enabled = False
////				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0.m_autonum4.enabled = False
////				//--------------------------- APPEON END ---------------------------	
//			End If
//			
//			//Hide toolbars for not current revision/readonly document
//			If inv_ole_utils_doc.of_isreadonly() OR tab_1.tabpage_browse.dw_browse.getitemnumber(tab_1.tabpage_browse.dw_browse.getrow(),'level') <> 1 Then
//				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_addclause.enabled = False				
//				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.enabled = False	
//				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergefield.enabled = False	
//				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergedata.enabled = False
//				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_save0.enabled = False		
////				//--------------------------- APPEON BEGIN ---------------------------
////				//Added by alfee at 2007.03.06
////				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0.enabled = False	
////				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0.m_autonum1.enabled = False
////				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0.m_autonum2.enabled = False
////				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0.m_autonum3.enabled = False
////				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0.m_autonum4.enabled = False
////				//--------------------------- APPEON END ---------------------------					
//			End If
//			
//			//Hide merge toolbar for document not from template
//			If tab_1.tabpage_browse.dw_browse.getitemnumber(tab_1.tabpage_browse.dw_browse.getrow(),'level') = 1 THEN
//				If tab_1.tabpage_browse.dw_browse.GetitemString(tab_1.tabpage_browse.dw_browse.getrow(),'base_type') <> '1' Then
//					m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.enabled = False	
//					m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergefield.enabled = False	
//					m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergedata.enabled = False
//				End If
//			End If
//			
//			//Hide toolbars according to system setting
//			If li_setting = 0 or li_setting = 3 Then //Off or Buy setting
//				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_addclause.toolbaritemvisible = False
//				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.toolbaritemvisible = False	
//				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergefield.toolbaritemvisible = False	
//				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergedata.toolbaritemvisible = False
////				//--------------------------- APPEON BEGIN ---------------------------
////				//Added by alfee at 2007.03.06
////				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0.enabled = False	
////				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0.m_autonum1.enabled = False
////				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0.m_autonum2.enabled = False
////				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0.m_autonum3.enabled = False
////				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0.m_autonum4.enabled = False
////				//--------------------------- APPEON END ---------------------------					
//			End If
//			
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.toolbaritemvisible = False					
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addbuy.toolbaritemvisible = False			
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addsell.toolbaritemvisible = False
//			
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_select.toolbaritemvisible = False			
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_report.toolbaritemvisible = False			
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_delete0.toolbaritemvisible = False
//			//m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_revision0.toolbaritemvisible = False		
//			
//			//--------------------------- APPEON BEGIN ---------------------------
//			//Set readonly reason of document. Added by alfee at 03.08.2007
//			inv_ole_utils_doc.is_readonly_reason = ''
//			If tab_1.tabpage_browse.dw_browse.object.level[tab_1.tabpage_browse.dw_browse.getrow()] = 1 Then
//				If tab_1.tabpage_browse.dw_browse.object.checkout_status[tab_1.tabpage_browse.dw_browse.getrow()] = "1" Then
//					inv_ole_utils_doc.is_readonly_reason = 'checkout'
//				end if
//			Else
//				inv_ole_utils_doc.is_readonly_reason = 'history'
//			End If
//			//--------------------------- APPEON END ---------------------------								
//	End CHOOSE
//ELSE
////	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_select.toolbaritemvisible = True	
//	If w_mdi.of_security_access( 6904 ) = 0 Then
//		m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_report.toolbaritemvisible = False			
//	Else
//		m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_report.toolbaritemvisible = True			
//	End If
//
//	If w_mdi.of_security_access( 6922 ) = 0 Then
//		m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_delete0.toolbaritemvisible = False
//	Else
//		m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_delete0.toolbaritemvisible = True
//	End If
//	
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_save0.toolbaritemvisible = False			
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.toolbaritemvisible = False	
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkin.toolbaritemvisible = False			
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkout.toolbaritemvisible = False			
//	
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_print0.toolbaritemvisible = False			
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_addclause.toolbaritemvisible = False					
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.toolbaritemvisible = False	
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergefield.toolbaritemvisible = False			
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergedata.toolbaritemvisible = False		
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_clausemap.toolbaritemvisible = False		
////	//--------------------------- APPEON BEGIN ---------------------------
////	//Added by alfee at 2007.03.06
////	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0.toolbaritemvisible = False	
////	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0.m_autonum1.toolbaritemvisible = False
////	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0.m_autonum2.toolbaritemvisible = False
////	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0.m_autonum3.toolbaritemvisible = False
////	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0.m_autonum4.toolbaritemvisible = False
////	//--------------------------- APPEON END ---------------------------	
//			
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_select.enabled = False
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_report.enabled = False
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_properties0.enabled = False
//	
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.enabled = False			
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_email1.enabled = False
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_print0.enabled = False
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_saveas.enabled = False
//		
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkin.enabled = False
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkout.enabled = False
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_delete0.enabled = False	
//	//m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_revision0.enabled = False	//by alfee at 03.14.2007
//End If
//
//m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_workflow0.toolbaritemvisible = False			
//m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_addactioneitem.toolbaritemvisible = False			
//m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_deleteactioneitem.toolbaritemvisible = False			
//m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_letter.toolbaritemvisible = False	
//m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_fullscreen.toolbaritemvisible = False	
//
//If is_doc_ext <> 'doc' Then
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_addclause.enabled = False
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_clausemap.enabled = False
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_fullscreen.enabled = False
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergedata.enabled = False
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_addclause.toolbaritemvisible = False
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_clausemap.toolbaritemvisible = False
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_fullscreen.toolbaritemvisible = False
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.toolbaritemvisible = False	
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergefield.toolbaritemvisible = False	
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergedata.toolbaritemvisible = False	
//End If
//
////--------------------------- APPEON BEGIN ---------------------------
//// This menu item not used yet, added by alfee at 2007.03.07
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0.toolbaritemvisible = False	
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0.m_autonum1.toolbaritemvisible = False
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0.m_autonum2.toolbaritemvisible = False
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0.m_autonum3.toolbaritemvisible = False
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0.m_autonum4.toolbaritemvisible = False
////--------------------------- APPEON END ---------------------------	
//
//w_mdi.setredraw(true)
//
end event

event ue_post_doc_changed;call super::ue_post_doc_changed;IF al_old_doc_id <> al_new_doc_id OR adc_old_revision <> adc_new_revision OR tab_1.tabpage_preview.dw_head.Rowcount() = 0 THEN
	IF lower(is_doc_ext)='doc' THEN//Added by Frank.
		gnv_appeondb.of_startqueue( )
		tab_1.tabpage_preview.dw_head.retrieve(al_new_doc_id)
	   of_filter_clause(al_new_doc_id,adc_new_revision)
		of_getclauserights() 
		gnv_appeondb.of_commitqueue( )
	END IF
END IF

//// Added by Davis, Don't delete
////--------------------------- APPEON BEGIN ---------------------------
////$<modify> 01.27.2007 By: Jack (Document Manager)
////$<reason> Fix a defect.
///*
//this.event ue_set_security( )
//*/	
//If ib_browse Then
//	If tab_1.tabpage_browse.dw_browse.rowcount() > 0 Then
//		m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkin.toolbaritemvisible = False
//		m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkout.toolbaritemvisible = False	
//		m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_revision0.toolbaritemvisible = False	
//		//For Check in & out
//		If tab_1.tabpage_browse.dw_browse.getitemnumber(tab_1.tabpage_browse.dw_browse.getrow(),'level') = 1 Then
//			// LEVEL 1
//			If tab_1.tabpage_browse.dw_browse.object.revision_control[tab_1.tabpage_browse.dw_browse.getrow()] = "1" Then
//				If tab_1.tabpage_browse.dw_browse.object.checkout_status[tab_1.tabpage_browse.dw_browse.getrow()] = "0" Then
//					If w_mdi.of_security_access( 6911 ) = 0 Then
//						m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkout.toolbaritemvisible = False	
//					Else
//						m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkout.toolbaritemvisible = True
//						m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkout.enabled = True
//						m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_delete0.enabled = True
//					End If												
//				ElseIf tab_1.tabpage_browse.dw_browse.object.checkout_status[tab_1.tabpage_browse.dw_browse.getrow()] = "1" Then
//					If w_mdi.of_security_access( 6910 ) = 0 Then
//						m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkin.toolbaritemvisible = False
//					Else
//						m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkin.toolbaritemvisible = True
//						m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkin.enabled = True
//						m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_delete0.enabled = False
//					End If
//				End If
//			End If
//		End If
//		If w_mdi.of_security_access( 6921 ) = 0 Then
//			m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_revision0.toolbaritemvisible = False			
//		Else
//			If tab_1.tabpage_browse.dw_browse.getitemstring(tab_1.tabpage_browse.dw_browse.getrow(),'revision_control') = "0" Then
//				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_revision0.toolbaritemvisible = True				
//				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_revision0.enabled = True	
//			End If	
//		End If											
//	End If
//End If
//
If tab_1.tabpage_browse.dw_browse.rowcount() = 0 Then
	tab_1.tabpage_preview.enabled = False
End If	
////---------------------------- APPEON END ----------------------------

return 1
end event

event resize;call super::resize;//-------------Appeon Begin -----by Derek at 03.13.2007---------
//tab_1.tabpage_preview.cb_1.x = tab_1.width - 112
//-------------Appeon end --------------------------------------


end event

event destructor;call super::destructor;Destroy inv_filesvr

Destroy ids_clause_temp
Destroy ids_clause_right
Destroy ids_changes
end event

type st_1 from u_tabpg_contract_master`st_1 within u_tabpg_dm_email
long backcolor = 67108864
end type

type tab_1 from tab within u_tabpg_dm_email
integer x = 18
integer y = 16
integer width = 3726
integer height = 1808
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean fixedwidth = true
boolean raggedright = true
boolean focusonbuttondown = true
alignment alignment = center!
integer selectedtab = 1
tabpage_browse tabpage_browse
tabpage_preview tabpage_preview
end type

on tab_1.create
this.tabpage_browse=create tabpage_browse
this.tabpage_preview=create tabpage_preview
this.Control[]={this.tabpage_browse,&
this.tabpage_preview}
end on

on tab_1.destroy
destroy(this.tabpage_browse)
destroy(this.tabpage_preview)
end on

event selectionchanged;// Set toolbar
If ib_browse Then
	parent.event ue_set_security( )
End If
ib_browse = True

//for preview tabpage
IF newindex = 2 THEN
	If Not ib_showed Then
		gnv_reg_ocx.of_check_ocx( 1,'', True) //1: office //Added by Ken.Guo on 2008-11-06
		ib_showed = True
	End If
	event ue_preview(il_doc_id,idc_revision,is_doc_ext)
END IF
end event

type tabpage_browse from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 3689
integer height = 1692
long backcolor = 33551856
string text = "Browse"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_browse dw_browse
dw_filter dw_filter
end type

on tabpage_browse.create
this.dw_browse=create dw_browse
this.dw_filter=create dw_filter
this.Control[]={this.dw_browse,&
this.dw_filter}
end on

on tabpage_browse.destroy
destroy(this.dw_browse)
destroy(this.dw_filter)
end on

type dw_browse from u_dw_contract within tabpage_browse
string tag = "Document Browse"
integer x = 18
integer y = 548
integer width = 3648
integer height = 1120
integer taborder = 30
boolean titlebar = true
string title = "Document Browse"
string dataobject = "d_dm_email_browse"
boolean hscrollbar = true
end type

event clicked;call super::clicked;if row < 1 then return

long  ll_doc_id
int  li,li_new,li_rows,li_Find

ll_doc_id = this.getitemnumber(row,'doc_id')

if dwo.name='p_1' then

	This.Setredraw( false )

	//Add rows
	n_ds  ds_audit
	
	ds_audit = create n_ds 
	ds_audit.dataobject = 'd_dm_doc_audit_all'
	ds_audit.settransobject( sqlca)
	li_rows = ds_audit.retrieve( ll_doc_id)
	li_new = row+1
	for li = 1 to li_rows
		li_new = this.insertrow(li_new)
		this.setitem(li_new,'row',li_new)
		this.setitem(li_new,'doc_id',ll_doc_id)
		this.setitem(li_new,'level',2)
		this.setitem(li_new,'revision',this.getitemdecimal(row,'revision'))
		this.setitem(li_new,'doc_type',this.getitemstring(row,'doc_type'))
		this.setitem(li_new,'doc_name',this.getitemstring(row,'doc_name'))
		this.setitem(li_new,'audit_version',ds_audit.getitemdecimal(li,'revision'))
		this.setitem(li_new,'audit_status',ds_audit.getitemstring(li,'action'))
		this.setitem(li_new,'audit_date',ds_audit.getitemdatetime(li,'action_date'))
		this.setitem(li_New,'doc_ext',ds_audit.getitemstring(li,'doc_ext'))//char(1),Sell or Buy
		this.setitem(li_new,'audit_user',ds_audit.getitemstring(li,'action_by'))
		this.setitem(li_new,'audit_note',ds_audit.getitemstring(li,'notes'))
		li_new = li_new+1
	next
	this.setitem(row,'style','-')
	destroy ds_audit

	This.Setredraw( true )
elseif dwo.name='p_2' then
	of_collapse_row(ll_doc_id, row)
end if

end event

event constructor;call super::constructor;of_setrowselect( true)
this.inv_rowselect.of_setstyle( inv_rowselect.single)

this.of_setupdateable( false)
this.ib_rmbmenu=false

this.Event ue_populatedddws()
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-02-25 By: Rodger Wu (add other)
/* This datawindow needs to add Other ddlb and resize. */
//---------------------------- APPEON END ----------------------------

end event

event doubleclicked;call super::doubleclicked;if row > 0 then
	//Start 02.07.2007 By Jervis
	//Fixed a defect
	/*
	event ue_preview(il_doc_id,idc_revision,is_doc_ext)
	*/
	tab_1.selecttab(2)
	//End
end if
end event

event rbuttondown;return u_dw::event rbuttondown(xpos,ypos,row,dwo)
end event

event rowfocuschanged;call super::rowfocuschanged;IF ib_retrieving THEN return

String ls_checkout_status

IF Getrow() = 0 THEN RETURN
IF Rowcount() = 0 THEN RETURN

tab_1.tabpage_preview.enabled = TRUE

if currentrow >0 then
	is_doc_ext = Lower(This.getitemstring(currentrow,'doc_ext'))
	CHOOSE CASE Lower(is_doc_ext)
		CASE 'tif','tiff','jfk','bmp','jpc','jpe','jpeg','pcx','dcx','xif','gif','wif','ibk','pdf'
			If Lower(is_doc_ext) = 'pdf' and gnv_data.of_getitem( 'icred_settings', 'openpdfwith', false) = '2' Then
				tab_1.tabpage_preview.enabled = FALSE
			End If
		CASE 'doc'
		CASE ELSE
			tab_1.tabpage_preview.enabled = FALSE
	END CHOOSE

	dec{1} ldc_temp
	IF this.getitemnumber(currentrow,'level')=1 THEN
		ldc_temp = this.getitemdecimal( currentrow,'revision')
	ELSE
		ldc_temp = this.getitemdecimal( currentrow,'audit_version')
	END IF
	
	ls_checkout_status = this.getitemstring(currentrow,'checkout_status')
	//inv_ole_utils_doc.of_setreadonly( this.getitemnumber(currentrow,'level')=2 OR ls_checkout_status = "1")
	inv_ole_utils_doc.of_setreadonly( this.getitemnumber(currentrow,'level')=2 OR ls_checkout_status <> "0") //Modified by Ken.Guo on 2009-03-27
	
	event ue_doc_changed(il_doc_id,this.getitemnumber( currentrow, 'doc_id'),idc_revision ,ldc_temp)
else
	tab_1.tabpage_preview.enabled = FALSE
end if

end event

event pfc_retrieve;call super::pfc_retrieve;n_ds   lds_doc
int li, li_rows,li_new
Long ll_doc_id, ll_row
ll_doc_id = il_doc_id

lds_doc = create n_ds
lds_doc.dataobject = 'd_dm_doc_all'
lds_doc.settransobject( sqlca)

//li_Rows = lds_doc.retrieve(inv_contract_details.of_get_ctx_id( )) //Comment By Ken.Guo 2009-06-19
li_Rows = lds_doc.retrieve(il_ctx_id) //Added By Ken.Guo 2009-06-19.

of_filter_category(lds_doc) //Added By Ken.Guo 2010-02-25.
li_Rows = lds_doc.rowcount()

This.Setredraw( False )
this.reset( )
ib_retrieving = true
for li = 1 to li_rows
	li_new = this.insertrow(0)
	this.setitem(li_New,'row',li_new)
	this.setitem(li_New,'level',1)
	this.setitem(li_New,'style','+')
	this.setitem(li_New,'doc_id',lds_doc.getitemnumber(li,'doc_id'))
	this.setitem(li_New,'doc_Type',lds_doc.getitemstring(li,'doc_type'))//char(1),Sell or Buy
	this.setitem(li_New,'doc_ext',lds_doc.getitemstring(li,'doc_ext'))
	this.setitem(li_New,'category',lds_doc.getitemnumber(li,'category'))
	this.setitem(li_New,'doc_name',lds_doc.getitemstring(li,'doc_name'))
	this.setitem(li_New,'revision',lds_doc.getitemdecimal(li,'revision'))
	this.setitem(li_New,'revision_control',lds_doc.getitemstring(li,'revision_control'))
	this.setitem(li_New,'create_by',lds_doc.getitemstring(li,'create_by'))
	this.setitem(li_New,'create_date',lds_doc.getitemdatetime(li,'create_date'))
	this.setitem(li_New,'status',lds_doc.getitemnumber(li,'status'))
	this.setitem(li_New,'status_by',lds_doc.getitemstring(li,'status_by'))
	this.setitem(li_New,'status_date',lds_doc.getitemdatetime(li,'status_date'))
	this.setitem(li_New,'audit_count',lds_doc.getitemnumber(li,'audit_count'))
	this.setitem(li_New,'checkout_by',lds_doc.getitemstring(li,'checkout_by'))
	this.setitem(li_New,'checkout_date',lds_doc.getitemdatetime(li,'checkout_date'))
	this.setitem(li_New,'checkout_status',lds_doc.getitemstring(li,'checkout_status'))
	this.setitem(li_New,'base_type',lds_doc.getitemstring(li,'base_type'))
	this.setitem(li_New,'notes',lds_doc.getitemstring(li,'notes'))		
next
if is_Filter<>'' and (not isnull(is_Filter)) THEN
	this.setfilter( is_Filter)
	this.filter()
	this.sort()
end if
This.Setredraw( True )

if this.rowcount()>0 then
	ll_row = this.Find( "doc_id = " + String(ll_doc_id), 1, rowcount())
	IF ll_row <= 0 THEN ll_row = 1

	This.Scrolltorow( ll_row )
	this.setrow( ll_row )
	post event rowfocuschanged( ll_row )
ELSE
	post event ue_doc_changed( -1,-2, 0,0)
end if

destroy lds_doc

ib_retrieving=false

IF tab_1.Selectedtab = 2 THEN
	Post Event ue_preview(il_doc_id,idc_revision,is_doc_ext)
END IF


return li_rows
end event

event pfc_prermbmenu;call super::pfc_prermbmenu;am_dw.m_table.m_insert.enabled = false
gnv_app.of_modify_menu_attr( am_dw.m_table.m_addrow,'enabled', false)
gnv_app.of_modify_menu_attr( am_dw.m_table.m_delete,'enabled', false)
end event

event retrieveend;
end event

type dw_filter from u_dw_contract within tabpage_browse
string tag = "Search Criteria"
integer x = 18
integer y = 16
integer width = 3648
integer height = 504
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Search Criteria"
string dataobject = "d_dm_browse_filter"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event buttonclicked;call super::buttonclicked;if row < 1 then return

IF dwo.name='b_go' then
	is_filter = of_generate_filter( )
ELSEIF dwo.name='b_clear' THEN
	this.deleterow(0)
	this.insertrow(0)
	is_filter = ""
END IF

dw_browse.setfilter(is_filter)
dw_browse.filter()
dw_browse.sort()
dw_browse.event rowfocuschanged(1)
end event

event constructor;call super::constructor;this.of_setdropdowncalendar( true)
this.of_setupdateable( false)
this.ib_rmbmenu=false
//
long ll_row,ll_category,ll_find
datawindowchild ldw_category
setnull(ll_category)
//
this.Event ue_populatedddws()

//this.getchild('category',child)
//ll_find = child.find("code = '(NONE)'",1,child.rowcount())
//If ll_find > 0 Then
//	child.setitem(ll_find,'code','All')
//End If
ll_row = dw_filter.insertrow(0)
dw_filter.setitem(1,'category',ll_category)
dw_filter.setfocus()

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-02-25 By: Rodger Wu (add other)
/* This datawindow needs to add a Other ddlb. */
//---------------------------- APPEON END ----------------------------

//Added By Ken.Guo 2010-02-25.
n_cst_right lnv_right
If gnv_data.of_getitem( 'icred_settings', 'filter_documents', False) = '1' Then 
	dw_filter.Getchild('category',ldw_category)
	ldw_category.deleterow(2) //Delete *Add lookup code*
	lnv_right = Create n_cst_right
	lnv_right.of_filter_right( ldw_category, 'lookup_code', 1)
	Destroy lnv_right
End If
end event

event ue_populatedddws;call super::ue_populatedddws;//(Appeon)Harry 10.16.2014 - for BugH101101
//d_dm_browse_filter  d_dm_new_sell_document
n_ds					lds_doc_type, lds_temp
string					ls_coltag, ls_lable
integer				li_value, li_i
Datawindowchild	dwchild



ls_coltag = Lower(Describe("doc_type.TAG"))
li_value = gnv_app.inv_dwcache.of_GetRegistered (ls_coltag,lds_doc_type)

IF li_value <> 1 THEN
	gnv_app.of_setcontraccache_code_lookup( ls_coltag )
	li_value = gnv_app.inv_dwcache.of_GetRegistered (ls_coltag,lds_doc_type)
END IF


IF li_value = 1 THEN
	getchild( 'doc_type', dwchild)
	
	lds_doc_type.ShareData ( dwchild )				

	long ll_find
	string ls_displaycolumn
	ls_displaycolumn = This.Describe("doc_type.dddw.displaycolumn")
	ll_find = dwchild.find(ls_displaycolumn + " = '(NONE)'",1,dwchild.rowcount())
	If ll_find > 0 Then
		dwchild.setitem(ll_find,ls_displaycolumn,'')
	End If
	ll_find = dwchild.find(ls_displaycolumn + " = 'No value selected'",1,dwchild.rowcount())
	If ll_find > 0 Then
		dwchild.setitem(ll_find,ls_displaycolumn,'')
	End If
	//---------------------------- APPEON END ----------------------------
	
	//Start code by jervis 10.20.2009
	//dynamically change the words *Add lookup Code* to *Add Agreement Type* and 
	//replace the words lookup code with the field label
	
	ll_find = dwchild.find("lookup_code = -777", 1, dwchild.rowcount())
	If ll_find > 0 Then 
//		ls_lable = This.Describe("doc_type_t.text")
//		if ls_lable <> '!' and ls_lable <> '?' then
			dwchild.deleterow( ll_find )
//			dwchild.setitem(ll_find,"code","*Add " + ls_lable + "*")
//			dwchild.setitem(ll_find,"description","")
//			dwchild.setitem(ll_find,"large_description_1","")
//			dwchild.setitem(ll_find,"large_description_2","")
//		end if
	end if

END IF
end event

type tabpage_preview from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3689
integer height = 1692
boolean enabled = false
long backcolor = 79741120
string text = "Preview"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
uo_2 uo_2
gb_map gb_map
cb_approve cb_approve
cb_original cb_original
cb_reject cb_reject
dw_change dw_change
dw_head dw_head
dw_clause dw_clause
ole_1 ole_1
ole_doc ole_doc
end type

on tabpage_preview.create
this.uo_2=create uo_2
this.gb_map=create gb_map
this.cb_approve=create cb_approve
this.cb_original=create cb_original
this.cb_reject=create cb_reject
this.dw_change=create dw_change
this.dw_head=create dw_head
this.dw_clause=create dw_clause
this.ole_1=create ole_1
this.ole_doc=create ole_doc
this.Control[]={this.uo_2,&
this.gb_map,&
this.cb_approve,&
this.cb_original,&
this.cb_reject,&
this.dw_change,&
this.dw_head,&
this.dw_clause,&
this.ole_1,&
this.ole_doc}
end on

on tabpage_preview.destroy
destroy(this.uo_2)
destroy(this.gb_map)
destroy(this.cb_approve)
destroy(this.cb_original)
destroy(this.cb_reject)
destroy(this.dw_change)
destroy(this.dw_head)
destroy(this.dw_clause)
destroy(this.ole_1)
destroy(this.ole_doc)
end on

type uo_2 from uo_dm_image_view_cp within tabpage_preview
integer x = 5
integer y = 8
integer width = 3671
integer height = 1664
integer taborder = 40
end type

on uo_2.destroy
call uo_dm_image_view_cp::destroy
end on

event constructor;call super::constructor;//Alfee 07.28.2008

this.of_set_module('EMAIL') //from email document browser
end event

type gb_map from groupbox within tabpage_preview
boolean visible = false
integer x = 9
integer width = 1147
integer height = 1792
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Clause Map"
end type

type cb_approve from commandbutton within tabpage_preview
boolean visible = false
integer x = 32
integer y = 1592
integer width = 325
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Approve"
end type

event clicked;//inv_ole_utils_doc.of_acceptchanges()
end event

type cb_original from commandbutton within tabpage_preview
boolean visible = false
integer x = 741
integer y = 1592
integer width = 393
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Original Clause"
end type

event clicked;Long ll_row, ll_clause_id
String ls_filename
DateTime ldt_modify_date
n_cst_clause lnv_clause
decimal{1} ldec_revision

ll_row = dw_clause.getrow()
IF ll_row <1 THEN RETURN

ll_clause_id = dw_clause.getitemnumber(ll_row,"ctx_acp_clause_id")
ldt_modify_date = dw_clause.getitemdatetime(ll_row,"modify_date")

//ls_filename = inv_ole_utils_doc.is_agreement_path + "clause_" + string(ll_clause_id)+ ".doc"
//Get or Generate local clause file 
//inv_ole_utils_doc.of_getclausefile(ll_clause_id,ldt_modify_date)	
lnv_clause = Create n_cst_clause
ldec_revision = lnv_clause.of_get_revision(ll_clause_id)
inv_ole_utils_doc.of_getclausefile(ll_clause_id,ldec_revision,ls_filename)

//Open clause file in new window
IF Not IsValid(w_dm_original_clause) THEN
	Openwithparm(w_dm_original_clause, ls_filename)
ELSE
	w_dm_original_clause.of_displayfile(ls_filename)
	w_dm_original_clause.BringToTop = TRUE
END IF
end event

type cb_reject from commandbutton within tabpage_preview
boolean visible = false
integer x = 384
integer y = 1592
integer width = 325
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Reject"
end type

event clicked;//inv_ole_utils_doc.of_rejectchanges()
end event

type dw_change from u_dw within tabpage_preview
event ue_locatefile ( )
boolean visible = false
integer x = 32
integer y = 892
integer width = 1102
integer height = 692
integer taborder = 31
boolean bringtotop = true
string dataobject = "d_dm_change_list"
boolean minbox = true
end type

event ue_locatefile();//////////////////////////////////////////////////////////////////////
// $<event>ue_locatefile() of dw_changes
// $<arguments>(None)
// $<returns> 
// $<description>Locate changes in document
//////////////////////////////////////////////////////////////////////
// $<add> 01.15.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////

Long ll_row
Integer li_page,li_line,li_col,li_charcnt
string ls_desc, ls_desc_ori
oleobject lole_document

// added 02.07.2007 By: Davis
IF NOT Visible THEN RETURN

lole_document = ole_doc.Object.ActiveDocument

IF tab_1.SelectedTab <> 2 OR NOT ib_locate_change THEN RETURN 

//If no word document opened, then return
IF tab_1.tabpage_preview.ole_doc.object.DocType <> 1 THEN RETURN

ll_row =This.Getrow()
IF ll_row < 1 THEN RETURN

//IF ll_row <= lole_document.Revisions.Count THEN
//	ls_desc_ori = This.Getitemstring(ll_row,"description")
//	
//	li_page = lole_document.Revisions.Item[ll_row].Range.Information[wdActiveEndPageNumber]
//	li_line = lole_document.Revisions.Item[ll_row].Range.Information[wdFirstCharacterLineNumber]
//	li_col  = lole_document.Revisions.Item[ll_row].Range.Start
//	li_charcnt = lole_document.Revisions.Item[ll_row].Range.End - lole_document.Revisions.Item[ll_row].Range.Start
//	ls_desc = "Page " + string(li_page) + "->Line " + String(li_line) + "->" +String(li_charcnt) + " Character(s)"	
//
//	//If document changed, then refresh change list
//	IF Lower(ls_desc_ori) <> Lower(ls_desc) THEN	
//		of_getchanges() 
//	END IF
//ELSE
//	of_getchanges()
//END IF

//Locate in document
IF lole_document.Revisions.Count >= ll_row THEN
	lole_document.Revisions.Item[ll_row].Range.Select()
END IF

end event

event constructor;call super::constructor;//by alfee at 2007/01/15
of_SetRowManager(TRUE)
of_SetRowSelect(TRUE)
end event

event getfocus;//Refresh change list of document
//of_getchanges()
end event

event clicked;call super::clicked;this.event ue_locatefile()
end event

type dw_head from u_dw_contract within tabpage_preview
boolean visible = false
integer x = 14
integer y = 24
integer width = 3657
integer height = 160
integer taborder = 10
string dataobject = "d_dm_doc_audit_preview"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;this.of_setupdateable( false)
this.Event ue_populatedddws()

end event

event getfocus;//
end event

event losefocus;//
end event

event itemchanged;call super::itemchanged;long	ll_size

If tab_1.tabpage_preview.ole_doc.object.doctype <> 1 Then return 


end event

event pfc_retrieve;call super::pfc_retrieve;//Add By Jervis 02.07.2007
return retrieve(il_doc_id)
end event

type dw_clause from u_dw within tabpage_preview
event ue_locatefile ( )
boolean visible = false
integer x = 32
integer y = 52
integer width = 1102
integer height = 844
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_dm_clause_map"
end type

event ue_locatefile();//////////////////////////////////////////////////////////////////////
// $<event>ue_locatefiledw_clause()
// $<arguments>(None)
// $<returns> 
// $<description>Locate clause in document
//////////////////////////////////////////////////////////////////////
// $<add> 01.12.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////

//by alfee at 2007/01/15 All
long ll_clause_id,ll_row

// added 02.07.2007 By: Davis
IF NOT Visible THEN RETURN

if tab_1.selectedtab <> 2 or not ib_locate then return
ll_row = tab_1.tabpage_preview.dw_clause.getrow()
if ll_row < 1 then return

ll_clause_id = tab_1.tabpage_preview.dw_clause.getitemnumber(ll_row,"ctx_acp_clause_id")

If tab_1.tabpage_preview.ole_doc.object.DocType <> 1 Then return //no word document opened

inv_ole_utils_doc.of_setstatuschanged(FALSE)

if tab_1.tabpage_preview.ole_doc.object.activedocument.bookmarks.exists("clause_" +string(ll_clause_id)) then 
	tab_1.tabpage_preview.ole_doc.object.activedocument.bookmarks.item("clause_" +string(ll_clause_id)).select()
end if

inv_ole_utils_doc.of_setstatuschanged(TRUE)
end event

event constructor;call super::constructor;of_SetRowManager(TRUE)
of_SetRowSelect(TRUE)

ids_clause_temp = Create DataStore
ids_clause_right = Create DataStore
ids_clause_temp.dataobject = this.dataobject

end event

event getfocus;//by alfee at 2007/01/15
end event

event clicked;call super::clicked;this.post event ue_locatefile()

IF ib_showclausemap and This.GetRow() > 0 THEN
	cb_original.Enabled = True
ELSE
	cb_original.Enabled = False
END IF
end event

type ole_1 from u_email_edit within tabpage_preview
boolean visible = false
integer x = 1376
integer y = 484
integer taborder = 41
string binarykey = "u_tabpg_dm_email.udo"
end type

type ole_doc from u_email_edit within tabpage_preview
integer x = 5
integer y = 8
integer width = 3671
integer height = 1664
integer taborder = 41
string binarykey = "u_tabpg_dm_email.udo"
integer binaryindex = 1
end type

event constructor;call super::constructor;ole_doc.x = tab_1.tabpage_preview.gb_map.x 
inv_ole_utils_doc = create n_cst_ovole_utils
inv_ole_utils_doc.of_initial( ole_doc)
end event

event destructor;call super::destructor;if isvalid(inv_ole_utils_doc) then
	destroy inv_ole_utils_doc
end if
end event

type rb_current from radiobutton within u_tabpg_dm_email
integer x = 46
integer y = 1900
integer width = 498
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Current"
end type

event clicked;il_ctx_id = il_org_ctx_id
Parent.event ue_retrieve( )
end event

type rb_other from radiobutton within u_tabpg_dm_email
integer x = 544
integer y = 1900
integer width = 261
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Other"
end type

event clicked;If st_other.text = '' Then
	pb_browse.event clicked( )
Else
	il_ctx_id = Long(st_other.text)
	Parent.event ue_retrieve( )
End If
end event

type pb_browse from picturebutton within u_tabpg_dm_email
integer x = 795
integer y = 1884
integer width = 110
integer height = 96
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "find.bmp"
alignment htextalign = left!
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event>pb_browse::clicked()
// $<arguments>(None)
// $<returns> long
// $<description>
// $<description> Browse contract window
//////////////////////////////////////////////////////////////////////
// $<add> 2009-06-19 by Ken.Guo
//////////////////////////////////////////////////////////////////////

String ls_master_contract_name
Long ll_master_contract_id

Openwithparm(w_mastert_contract_search,'ALL')
ls_master_contract_name = message.stringparm  
ll_master_contract_id = long(mid(ls_master_contract_name,1,pos(ls_master_contract_name,'-') - 1))  
If ll_master_contract_id > 0 Then
	rb_other.checked = True
	il_ctx_id = ll_master_contract_id
	st_other.text = String(il_ctx_id)
	Parent.event ue_retrieve( )
Else
	If Not rb_other.checked Or st_other.text = '' Then
		rb_current.checked = True
	End If
End If
end event

type st_other from statictext within u_tabpg_dm_email
integer x = 910
integer y = 1896
integer width = 210
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type gb_1 from groupbox within u_tabpg_dm_email
integer x = 27
integer y = 1832
integer width = 1134
integer height = 172
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Select Contract"
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
00u_tabpg_dm_email.bin 
2100000e00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff000000010000000000000000000000000000000000000000000000000000000049a2b52001d17e9200000003000005000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000025400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003c9bc4e0f4a3c4248a763498a04f417d30000000049a2b52001d17e9249a2b52001d17e920000000000000000000000000054004e004f004b0066004f0069006600650063007400430053006c006d0074000000000000000000000000000000000000000000000000000000000000000001020022ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000025400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000c0000000d0000000e0000000f00000010000000110000001200000013fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
26ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1234abcd000024b10000193800dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b4000000010000000000000000000000000000000000000000000000010000000000000000000000010000000000800000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001234abcd000024b10000193800dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b4000000010000000000000000000000000000000000000000000000010000000000000000000000010000000000800000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000e00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
26fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff000000010000000000000000000000000000000000000000000000000000000049a2b52001d17e9200000003000005000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000025400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003c9bc4e0f4a3c4248a763498a04f417d30000000049a2b52001d17e9249a2b52001d17e920000000000000000000000000054004e004f004b0066004f0069006600650063007400430053006c006d0074000000000000000000000000000000000000000000000000000000000000000001020022ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000025400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000c0000000d0000000e0000000f00000010000000110000001200000013fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1234abcd000052fe00002aff00dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff
2D000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b4000000010000000000000000000000000000000000000000000000010000000000000000000000010000000000800000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001234abcd000052fe00002aff00dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b4000000010000000000000000000000000000000000000000000000010000000000000000000000010000000000800000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
10u_tabpg_dm_email.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
