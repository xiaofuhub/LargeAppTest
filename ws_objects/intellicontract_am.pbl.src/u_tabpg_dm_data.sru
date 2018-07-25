$PBExportHeader$u_tabpg_dm_data.sru
$PBExportComments$[intellicontract_tab]
forward
global type u_tabpg_dm_data from u_tabpg_contract_master
end type
type tab_1 from tab within u_tabpg_dm_data
end type
type tabpage_browse from userobject within tab_1
end type
type st_vsplitbar from u_st_splitbar within tabpage_browse
end type
type dw_browse from u_dw_contract within tabpage_browse
end type
type dw_filter from u_dw_contract within tabpage_browse
end type
type dw_detail from u_dw_contract within tabpage_browse
end type
type tabpage_browse from userobject within tab_1
st_vsplitbar st_vsplitbar
dw_browse dw_browse
dw_filter dw_filter
dw_detail dw_detail
end type
type tabpage_preview from userobject within tab_1
end type
type ole_doc from u_email_edit within tabpage_preview
end type
type uo_2 from uo_dm_image_view_cp within tabpage_preview
end type
type gb_map from groupbox within tabpage_preview
end type
type dw_head from u_dw_contract within tabpage_preview
end type
type dw_clause from u_dw within tabpage_preview
end type
type dw_change from u_dw within tabpage_preview
end type
type cb_approve from commandbutton within tabpage_preview
end type
type cb_original from commandbutton within tabpage_preview
end type
type cb_reject from commandbutton within tabpage_preview
end type
type uo_scrollbar from uo_dm_change_toollbar within tabpage_preview
end type
type pb_approve from picturebutton within tabpage_preview
end type
type pb_reject from picturebutton within tabpage_preview
end type
type tabpage_preview from userobject within tab_1
ole_doc ole_doc
uo_2 uo_2
gb_map gb_map
dw_head dw_head
dw_clause dw_clause
dw_change dw_change
cb_approve cb_approve
cb_original cb_original
cb_reject cb_reject
uo_scrollbar uo_scrollbar
pb_approve pb_approve
pb_reject pb_reject
end type
type tab_1 from tab within u_tabpg_dm_data
tabpage_browse tabpage_browse
tabpage_preview tabpage_preview
end type
type st_docinfo from statictext within u_tabpg_dm_data
end type
end forward

global type u_tabpg_dm_data from u_tabpg_contract_master
integer width = 3831
integer height = 1896
event ue_preview ( long al_doc_id,  decimal adc_revision,  string as_doc_ext )
event type integer ue_retrieve ( )
event ue_print ( )
event ue_do ( string as_action )
event ue_locatefile ( )
event ue_clausemap ( )
event ue_addclause ( )
event ue_mergedata ( string as_mergemode )
event type integer ue_save ( boolean ab_rev_ctrl )
event ue_delete ( )
event ue_revision ( )
event ue_insertfield ( )
event ue_refresh_audit ( long ll_doc_id )
event ue_autonum ( )
event ue_set_addsell ( boolean ab_add_sell )
event type integer ue_refreshdata ( boolean ab_merge )
event ue_checkout ( )
event ue_output_email ( )
event ue_output_saveas ( )
event type integer ue_approve_reject ( string as_action,  string as_criteria )
event ue_set_screen_properties ( )
event type integer ue_compare ( )
event ue_show_constructor ( )
event ue_insert_reqmnt ( )
event ue_merge_requirement ( )
event ue_ocr ( )
event ue_ocr_settings ( )
event ue_ocr_view ( )
event ue_opennewindow ( )
event ue_import_email ( )
event ue_set_secutiry2 ( )
event ue_undo_checkout ( )
event ue_open_with_default_program ( )
event ue_checkout_sertify ( )
event ue_show_sertifi_status ( )
event ue_show_approve_status ( )
event ue_checkout_approval ( )
event ue_document_history ( )
event ue_primary_document ( )
event ue_checkout_echosign ( )
event ue_checkout_docusign ( )
tab_1 tab_1
st_docinfo st_docinfo
end type
global u_tabpg_dm_data u_tabpg_dm_data

type variables
long    il_preview_doc_id=-1
long 	  il_preview_level = 0 //by alfee 05.15.2007
long 	  il_clause_approved //get approved code of clause by alfee 05.28.2007
long 	  il_BottomSpace

dec{1}  idc_preview_revision = 1
string  is_filter
string  is_doc_ext=''
string  is_doc_right //user rights on current document
string  is_clause_right //user rights on current clause
string is_opened_file //Opened file name
string is_search_text //Alfee 07.18.2008
datetime idt_modify_date //modify date for current revision file

boolean ib_locate = true //locate clause in file
boolean ib_locate_change = true //locate change in file
boolean ib_showclausemap=false
boolean ib_retrieving =false//Is it retrieving data? If true, do not trigger rowfocuschanged event.
boolean ib_add_sell = false
boolean ib_browse 
boolean ib_merged_data = false
boolean ib_allowtrack = true //deny tracking changes before file checking finished
boolean ib_allowcheckrights = true //for special cases. insert numbering, merge fields & etc by alfee 09.21.2007
boolean ib_allow_approve_reject = TRUE //set in role painter - Alfee 11.22.2007
boolean ib_detailRow = True //prevent rowfocuschanged add by gavin 20120131
boolean ib_controalinsert = true // add by gavins 20120131 
Boolean ib_set_Primary_document = False	//Added By Mark Lee 10/30/2012  	Its a check value which from the dw menu's 'set primary document' item. 

datastore ids_clause_temp //for clause map version control in of_updateclausemap
datastore ids_clause_right //for clause right in of_setclauserights
datastore ids_changes //for document change list 
datastore ids_infomsg //for clause information message
datastore ids_clause_approved //added by alfee 05.28.2007
datastore ids_template_clause_rules_result //Store dynamic add rules' result for current contract & template - by Alfee 11.12.2007

str_clause_filter	istr_ClauseFilter

n_cst_ovole_utils  inv_ole_utils_doc
n_cst_dm_utils  inv_dm_utils
n_cst_filesrvwin32  inv_filesvr
n_cst_dm_comparison inv_dm_comparison //Alfee 07.23.2008

CONSTANT INTEGER wdActiveEndPageNumber = 3
CONSTANT INTEGER wdFirstCharacterLineNumber = 10
CONSTANT INTEGER wdFirstCharacterColumnNumber = 9
CONSTANT INTEGER wdPropertyKeywords = 4 //by alfee at 03.09.2007
Constant long wdFieldMergeField = 59 
Constant long wdFieldDocVariable=64	//Add by jervis 02.25.2009

string is_OldSort = "D"  //Add by Evan on 05/22/2008
string is_OldSortColumn  //Add by Evan on 05/22/2008

n_cst_image_cp_ocr inv_ocr //Added By Ken.Guo 2009-10-20.
Boolean ib_havecheckinright = True //Added By Ken.Guo 12/08/2011. 

Integer	ii_ResizeWay=1 //added by gavins 2012-01-31  modify by gavins 20120704
DataWindow	idw_LastDW//added by gavins 2012-01-31
Long		il_BrowseRow
Boolean	ib_Zoom, ib_browseZoom = true
DateTime idt_LastDateTime

Long		il_Add_Doc_ID=-1

//---------Begin Added by (Appeon)Harry 05.06.2014 for V142 ISG-CLX--------
string is_parent_window //Added By Jay Chen 04-03-2014
//---------End Added ------------------------------------------------------

string is_mode,is_license_user_id  // (Appeon)Harry 07.08.2016 - for docusign
end variables

forward prototypes
public function string of_generate_filter ()
public function integer of_retrieve ()
public subroutine of_showole (boolean ab_show_doc_ole, boolean ab_show_clausemap)
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
public subroutine of_getchanges (integer ai_index)
public function integer of_refreshmap (boolean ab_bookmarkchanged, integer ai_revisionindex)
public function integer of_refreshclausestatus ()
public function integer of_mapresize (boolean ab_flag)
public function boolean of_havemergefield (long al_clauseid[])
public function integer of_getnewclauseid (long al_clauseid[], ref long al_newclauseid[])
public function integer of_setpagestatus (integer ai_pageno, integer ai_pagecnt)
public function integer of_restore_clause ()
public function integer of_set_checkrights (boolean ab_allow)
public function integer of_refreshdata ()
public function boolean of_issaved ()
public function integer of_setparent (menu am_menu)
public function integer of_parse_searchtext (string as_search_text, ref string as_rtn_text[])
public function integer of_get_docinfo (ref str_doc_info astr_docinfo)
public function integer of_goto_row (long al_doc_id)
public function integer of_open_document (long al_doc_id)
public function string of_gen_web_link ()
public function integer of_preview_excel ()
public function integer of_convert2pdf (long al_doc_id, decimal adec_revision, string as_filename)
public subroutine of_filter_category (datastore adw_data)
public subroutine of_hidesearch ()
public function integer of_filter_clause (long ai_doc_id, decimal adc_revision, boolean ab_locate)
public function long of_locate_doc (long al_doc_id)
public function boolean of_get_protect_tabpg ()
public function boolean of_check_read_only ()
public function u_tabpg_dm_data of_get_current_object ()
public function integer of_get_pagebreak (long al_clauseid[], ref long al_pagebreak[], ref long ai_appendparagraph[])
public function integer of_delete (long al_doc_id)
public subroutine of_show_sertifi_status (long al_row)
public function integer of_show_sertifi_status (str_sertifi_doc astr_sertifi_doc, boolean ab_refresh)
public function integer of_locate_doc (long al_doc_id[])
public subroutine of_show_approve_status ()
public subroutine of_registresize (integer ai_resize)
public subroutine of_create_dw ()
public subroutine of_sethistorytoolbar (integer ai_class)
public subroutine of_setpicturesize (datawindow adw_this, string as_zoom, string as_picture[], string as_originalwidth, string as_originalheight, string as_newwidth, string as_newheight)
public subroutine of_set_splitbar_location ()
public subroutine of_set_object_resize ()
public subroutine of_setdocumentpreopen (datawindow adw_current)
public subroutine of_insertdetail (datawindow adw_browse, datawindow adw_detail)
public function integer of_check_track_viewing ()
public subroutine of_reset_filter ()
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
	CASE 'bmp','tif','tiff','jpg','gif'//'tif','tiff','jfk','bmp','jpc','jpe','jpeg','pcx','dcx','xif','gif','wif','ibk'
		of_previewimage()
		If tab_1.selectedtab = 1 Then
			tab_1.post selecttab(2)
		End If		
	CASE 'pdf' //Added By Ken.Guo 2011-05-06. for Open PDF Mode
		if gnv_data.of_getitem( 'icred_settings', 'openpdfwith', false) = '1' Then 
			//Open with CL
			of_previewimage()
			If tab_1.selectedtab = 1 Then
				tab_1.post selecttab(2)
			End If				
		Else
			//Open with default windows program
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
	Case 'xls','xlsx' //Added By Ken.Guo 2009-09-07.
		If gs_word_version = 'word2007' Then
			of_preview_excel()
			If tab_1.selectedtab = 1 Then
				tab_1.post selecttab(2)
			End If		
		Else
			If Lower(as_doc_ext) = 'xls' Then
				of_preview_excel()
				If tab_1.selectedtab = 1 Then
					tab_1.post selecttab(2)
				End If				
			Else
				//excel 2003 application open 2007 file.
				IF tab_1.selectedtab = 2 THEN tab_1.selecttab(1)
				setnull(ls_null)
				ls_doc_nme = inv_dm_utils.of_download_file( al_doc_id, adc_revision)
				IF FileExists(ls_doc_nme) THEN
					if ShellExecuteA ( Handle( This ), "open", ls_doc_nme , ls_Null, ls_Null, 4) <= 32 then
						run("rundll32.exe shell32.dll,OpenAs_RunDLL " + ls_doc_nme)
					end if
				End If
			End If
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

event type integer ue_retrieve();of_reset_filter() //Added By Ken.Guo 11/25/2013
Return tab_1.tabpage_browse.dw_browse.event pfc_retrieve()

end event

event ue_print();//IF is_doc_ext='doc' THEN  //Commented by (Appeon)Harry 10.28.2015 - for Bug_id 4804
IF is_doc_ext='doc' or ( is_doc_ext= 'xlsx' or  is_doc_ext= 'xls' ) THEN  //(Appeon)Harry 10.28.2015 - for Bug_id 4804
	inv_ole_utils_doc.of_print( )
ELSE
	//-----------Begin Modified by Alfee on 05.19.2008 ----------------	
	//tab_1.tabpage_preview.uo_1.Dynamic event ue_print()
	IF gi_imageocx = 1 THEN //Imaging 360
		//tab_1.tabpage_preview.uo_1.Dynamic event ue_print()
	ELSE	
		tab_1.tabpage_preview.uo_2.Dynamic event ue_print()
	END IF
	//-----------End Modified -----------------------------------------
END IF

///////////////////////////////////////////////////////////////////////
//// Trigger off audit trail
///////////////////////////////////////////////////////////////////////
str_add_audit lstr_add_audit
lstr_add_audit.doc_id = il_doc_id
lstr_add_audit.revision = idc_revision
lstr_add_audit.doc_ext = is_doc_ext
lstr_add_audit.action = "OutPut - Print"
inv_dm_utils.of_add_audit_trail( lstr_add_audit )

//THIS.event ue_retrieve( )
//added by gavins 20120229
of_insertdetail(  tab_1.tabpage_browse.dw_browse, tab_1.tabpage_browse.dw_detail )


end event

event ue_do(string as_action);//////////////////////////////////////////////////////////////////////
// $<event>ue_do()
// $<arguments>
//		value	string	as_action		
// $<returns> 
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2007-01-11 by Frank.Gui
//////////////////////////////////////////////////////////////////////

str_add_doc lstr_add_doc
str_add_audit lstr_add_audit
str_ctx_email lstr_ctx_email
String  ls_DocType
int  li_row 
DateTIme ldt_null
Setnull(ldt_null)
string ls_checkout_status
Long ll_from_template_id //Added By Ken.Guo 2011-04-01.
Long ll_current_row , ll_screenid, ll_docid



as_action =  lower(as_action)
//--------Begin Modified by Alfee 09.30.2007-----------------------
//If of_check_read_only( ) Then Return   //Add by Jack 07.13.2007
IF of_check_read_only( ) THEN
	//IF as_action<>'output_email' and as_action<>'output_saveas' and as_action<>'output_print' and & //Alfee 07.23.2008
	IF as_action<>'output_email' and as_action<>'output_saveas' and as_action<>'output_print' and as_action <> 'compare' and &
		as_action<>'select' and as_action<>'clausemap' and as_action<>'report' and as_action<>'properties' THEN
		MessageBox("Infomation","The user only has Read Only rights, so this action can't be executed.")
		RETURN
	END IF
END IF
//--------End Modified ---------------------------------------------

lstr_add_doc.au_tabpg_dm_data = This

//--------------------------- APPEON BEGIN by Alfee 07.19.2007-------------------
//IF as_action<>'add_buy' and as_action<>'add_sell' and as_action<>'add_other' and as_action<>'clausemap'THEN
IF as_action<>'add_buy' and as_action<>'add_sell' and as_action<>'add_other' and as_action<>'output_email' and as_action <> 'ue_document_history' THEN	
//---------------------------- APPEON END ---------------------------------------
	//Fixed a defect by Jervis 03/28/2007
	//IF il_doc_id < 1 THEN return  	
	li_row = tab_1.tabpage_browse.dw_browse.getrow()
	IF li_row < 1 THEN return
	ls_DocType = tab_1.tabpage_browse.dw_browse.getitemstring(li_row,'doc_type')
	ll_from_template_id = tab_1.tabpage_browse.dw_browse.getitemnumber(li_row,'from_templete_id') //Added By Ken.Guo 2011-04-01.
END IF

ib_add_sell = False //for information message
CHOOSE CASE as_action
	CASE 'save'
		//This.Event ue_save() 
		This.Event ue_save(FALSE) 
		
	CASE 'properties'
		lstr_add_doc.new = FALSE
		lstr_add_doc.doc_id = il_doc_id
		lstr_add_doc.ctx_id = inv_contract_details.of_get_ctx_id( ) //Added By Ken.Guo 01/05/2012. 
		//Modified Begin By Ken.Guo 2011-04-01
		/*
		IF ls_DocType='Buy' or ls_DocType='Other' THEN
			openwithparm(w_dm_buy_document,lstr_add_doc)
		ELSE
			openwithparm(w_dm_sell_document,lstr_add_doc)
		END IF
		*/
//		IF ll_from_template_id > 0 THEN
		IF not isnull(ll_from_template_id) and ll_from_template_id > 0 THEN					//Added By Mark Lee 12/04/2012
			openwithparm(w_dm_sell_document,lstr_add_doc)
			ll_screenid = 52
		ELSE
			openwithparm(w_dm_buy_document,lstr_add_doc)
			ll_Screenid = 51
		END IF
		//Modified End By Ken.Guo 2011-04-01		
		

		IF Message.Doubleparm = 1 THEN 
			THIS.event ue_retrieve( )
			of_locate_doc(lstr_add_doc.doc_id)
		End If
		
		If Message.StringParm = 'design' Then //added by gavins 20130205
			SetPointer(HourGlass!)
			if IsValid(gw_Contract) then gw_Contract.of_SetCurrentScreenID(  ll_Screenid   )
			//m_pfe_cst_mdi_menu.m_system.m_painters.m_contractdatascreenpainter.Post Event Clicked()
			m_pfe_cst_mdi_menu.m_system.m_painters.m_screensetup.m_contractdatascreenpainter.Post Event Clicked() //(Appeon)Harry 06.28.2013 - V141 ISG-CLX
			SetPointer(Arrow!)
		End If	
		
	CASE 'add_buy','add_other'
		lstr_add_doc.new = TRUE
		lstr_add_doc.ctx_id = inv_contract_details.of_get_ctx_id( )
		lstr_add_doc.doc_id = 0
		OpenWithParm(w_dm_buy_document, lstr_add_doc)
		
		IF Message.Doubleparm > 0 THEN
			// Added by davis 02.08.2007
			il_doc_id = Message.Doubleparm
//			THIS.event ue_retrieve( )			//Added By Mark Lee 05/07/2013  checked the "Preview in Document Manager" function
//			tab_1.Post SelectTab( 2 )			//Added By Mark Lee 05/07/2013
			
			If il_Add_Doc_ID > 0 Then//added by gavins 20130531
				THIS.event ue_retrieve( )
				post of_open_document( il_Add_Doc_ID )
				il_Add_Doc_ID = -1
			End If
		END IF
		
		If Message.StringParm = 'design' Then //added by gavins 20130205
			SetPointer(HourGlass!)
			if IsValid(gw_Contract) then gw_Contract.of_SetCurrentScreenID(   51   )
			//m_pfe_cst_mdi_menu.m_system.m_painters.m_contractdatascreenpainter.Post Event Clicked()
			m_pfe_cst_mdi_menu.m_system.m_painters.m_screensetup.m_contractdatascreenpainter.Post Event Clicked()  //(Appeon)Harry 06.28.2013 - V141 ISG-CLX
			SetPointer(Arrow!)
		End If		
		
	CASE 'add_sell'
		lstr_add_doc.new = TRUE
		lstr_add_doc.ctx_id = inv_contract_details.of_get_ctx_id( )
		lstr_add_doc.doc_id = 0
		OpenWithParm(w_dm_sell_document, lstr_add_doc)

		IF Message.Doubleparm > 0 THEN
			// Added by davis 02.08.2007
			il_doc_id = Message.Doubleparm
//			THIS.event ue_retrieve( )					//Added By Mark Lee 05/07/2013
			//ib_add_sell = TRUE  - Replaced with the below statement by alfee 09.06.2007
			event ue_set_addsell(TRUE)
//			tab_1.Post SelectTab( 2 )				//Added By Mark Lee 05/07/2013
			post event ue_set_addsell(FALSE) //
			If il_Add_Doc_ID > 0 Then//added by gavins 20130531
				THIS.event ue_retrieve( )
				post of_open_document( il_Add_Doc_ID )
				il_Add_Doc_ID = -1
			End If
		END IF

		If Message.StringParm = 'design' Then //added by gavins 20130205
			SetPointer(HourGlass!)
			if IsValid(gw_Contract) then gw_Contract.of_SetCurrentScreenID(  52   )
			//m_pfe_cst_mdi_menu.m_system.m_painters.m_contractdatascreenpainter.Post Event Clicked()
			m_pfe_cst_mdi_menu.m_system.m_painters.m_screensetup.m_contractdatascreenpainter.Post Event Clicked()  //(Appeon)Harry 06.28.2013 - V141 ISG-CLX
			SetPointer(Arrow!)
		End If	
		
	CASE 'checkout'
		//--------------Begin Modified by Alfee 12.14.2007----------------------
		This.Event ue_checkout()
		/*  
		// User Can't Check out a dcoument until Revision Control is started
		IF tab_1.tabpage_browse.dw_browse.object.revision_control[tab_1.tabpage_browse.dw_browse.getrow()] = "1" THEN
			IF tab_1.tabpage_browse.dw_browse.object.checkout_status[tab_1.tabpage_browse.dw_browse.getrow()] = "0" THEN
				lstr_add_doc.revision_control = tab_1.tabpage_browse.dw_browse.object.revision_control[tab_1.tabpage_browse.dw_browse.getrow()] = "1"
				lstr_add_doc.doc_id = this.il_doc_id
				lstr_add_doc.revision = this.idc_revision
				lstr_add_doc.doc_ext = this.is_doc_ext
				lstr_add_doc.filename =	tab_1.tabpage_browse.dw_browse.object.doc_name[tab_1.tabpage_browse.dw_browse.getrow()]
				lstr_add_doc.ctx_id = inv_contract_details.of_get_ctx_id( )
				lstr_add_doc.doc_from = 'DM' //added by alfee 04.30.2007
				OpenWithParm( w_dm_checkout_document, lstr_add_doc )
				IF Message.Doubleparm = 1 THEN
					THIS.event ue_retrieve( )
				END IF
			ELSE
				MessageBox("Check Out","The document is already checked out.")
			END IF
		ELSE
			MessageBox("Check Out","Please start Revision Control for the document first.")
		END IF
		*/
		//---------------End Modified -------------------------------------------------

	CASE 'checkin','combine'	//Add Combine Feature - jervis 04.23.2010
		//-------------Begin Added by Alfee 03.13.2008---------------------------------
		ll_current_row = tab_1.tabpage_browse.dw_browse.getrow() //Added By Ken.Guo 2011-06-13. 
		
		IF tab_1.tabpage_browse.dw_browse.getitemnumber(ll_current_row,'level') = 2 THEN
			MessageBox("Check In","Can't check in a history revision.")
			RETURN
		END IF
		If IsValid( idw_LastDW ) Then
			If idw_LastDW.getRow( ) > 0 Then 
				If idw_LastDw.GetItemNumber( idw_LastDW.GetRow( ), 'level' ) = 2 Then
					MessageBox("Check In","Can't check in a history revision.")
					RETURN
				End If
			END IF			
		End If
				
		ls_checkout_status = tab_1.tabpage_browse.dw_browse.object.checkout_status[ll_current_row]
		//Set check out Flag when combine - jervis 04.23.2010
		//0-check in
		//1-check out
		//2,3,4-Download/Upload flag
		if as_action = 'combine' then
			if ls_checkout_status = '0' then
				Update Ctx_am_document set checkout_status = '1' ,checkout_by = :gs_user_id ,checkout_date = getdate() where doc_id = :il_doc_id;
				tab_1.tabpage_browse.dw_browse.object.checkout_status[ll_current_row] = '1'
			else
				MessageBox("Combine","Can't combine when the document be checkout or other,please retry")
				return
			end if
		end if
		
		//-------------End Added ------------------------------------------------------
		//IF tab_1.tabpage_browse.dw_browse.object.checkout_status[tab_1.tabpage_browse.dw_browse.getrow()] = "1" THEN
		IF tab_1.tabpage_browse.dw_browse.object.checkout_status[ll_current_row] <> "0" THEN //Modified by Ken.Guo on 2009-03-27
			lstr_add_doc.revision_control = tab_1.tabpage_browse.dw_browse.object.revision_control[ll_current_row] = "1"
			lstr_add_doc.doc_id = this.il_doc_id
			lstr_add_doc.revision = this.idc_revision
			lstr_add_doc.doc_ext = this.is_doc_ext
			if iw_parent.classname() = 'w_contract' Then
				lstr_add_doc.doc_from = 'DM'
				lstr_add_doc.ctx_id = inv_contract_details.of_get_ctx_id()
			Else
				lstr_add_doc.doc_from = 'DM_BROWSE'
				lstr_add_doc.ctx_id = tab_1.tabpage_browse.dw_browse.getitemnumber(ll_current_row,'ctx_id')
			End If
			lstr_add_doc.filename = tab_1.tabpage_browse.dw_browse.object.doc_name[ll_current_row]
			lstr_add_doc.new = FALSE
			lstr_add_doc.checkout_status =  tab_1.tabpage_browse.dw_browse.object.checkout_status[ll_current_row] //Added by Ken.Guo on 2009-04-10
			lstr_add_doc.operation = as_action //Add operation -- jervis 04.23.2010
			
			//Added By Ken.Guo 2011-06-13. 
			lstr_add_doc.astr_sertifi_doc.as_es_apicode = tab_1.tabpage_browse.dw_browse.GetItemString(ll_current_row,'es_apicode')
			lstr_add_doc.astr_sertifi_doc.as_es_fileid = tab_1.tabpage_browse.dw_browse.GetItemString(ll_current_row,'es_fileid')
			lstr_add_doc.astr_sertifi_doc.as_es_docid = tab_1.tabpage_browse.dw_browse.GetItemString(ll_current_row,'es_docid')
			lstr_add_doc.astr_sertifi_doc.as_es_sender = tab_1.tabpage_browse.dw_browse.GetItemString(ll_current_row,'es_sender')
			lstr_add_doc.astr_sertifi_doc.as_es_email  = tab_1.tabpage_browse.dw_browse.GetItemString(ll_current_row,'es_sender_email')
			
			lstr_add_doc.al_approveid = tab_1.tabpage_browse.dw_browse.GetItemNumber(ll_current_row,'approve_id')
			
			
			OpenWithParm( w_dm_checkin_document, lstr_add_doc )

			IF Message.Doubleparm = 1 THEN
				THIS.event ue_retrieve( )
				of_locate_doc(lstr_add_doc.doc_id)
			END IF
		ELSE
			MessageBox("Check Out","Please Check Out the document first.")
		END IF
		
		//Restore check out status - jervis 04.29.2010
		if as_action = 'combine' then
			if tab_1.tabpage_browse.dw_browse.object.checkout_status[tab_1.tabpage_browse.dw_browse.getrow()] = '1' then
				Update Ctx_am_document set checkout_status = '0',checkout_by = '', checkout_date = null where doc_id = :il_doc_id;
				tab_1.tabpage_browse.dw_browse.object.checkout_status[tab_1.tabpage_browse.dw_browse.getrow()] = '0'
			end if
		end if
		
	CASE 'output_email'
		This.Event ue_output_email() //Moved into this event- alfee 03.28.2008
		/*
		lstr_ctx_email.doc_from = 'DM'
		lstr_ctx_email.ctx_id = inv_contract_details.of_get_ctx_id( )
		lstr_ctx_email.doc_id = this.il_doc_id
		lstr_ctx_email.revision = this.idc_revision
		//----Begin Added by Alfee 11.28.2007--------------
		//<$Reason>Attach current not history revision's document
		Long ll_found 
		ll_found = tab_1.tabpage_browse.dw_browse.Find("doc_id = " +String(il_doc_id) + " and level = 1", 1, tab_1.tabpage_browse.dw_browse.RowCount())
		IF ll_found > 0 THEN lstr_ctx_email.revision	= tab_1.tabpage_browse.dw_browse.getitemnumber(ll_found, 'revision')	
		//----End Added -----------------------------------
		lstr_ctx_email.doc_ext = this.is_doc_ext
		If tab_1.tabpage_browse.dw_browse.getrow() > 0 Then
			lstr_ctx_email.filename = tab_1.tabpage_browse.dw_browse.object.doc_name[tab_1.tabpage_browse.dw_browse.getrow()]					
		End If
		OpenWithParm(w_dm_email_document_send, lstr_ctx_email)	
		*/
	CASE 'output_saveas'
		this.event ue_output_saveas() 

	CASE 'output_print'	 //added by alfee 04.29.2007 
		this.event ue_print()		
		
	CASE 'add_clause'
		this.event ue_addclause()
		
	CASE 'insert_reqmnt' //Added By Ken.Guo 2009-06-29.
		this.event ue_insert_reqmnt()
		
	CASE 'merge_field'
		this.event ue_insertfield()
		
	CASE 'merge_data'
		this.event ue_mergedata('manual')
		
	CASE 'clausemap'
		this.event ue_clausemap()

	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 04.19.2007 By: Alfee
	CASE 'auto_num'
		this.event ue_autonum()		
	//---------------------------- APPEON END ----------------------------
	
	CASE 'refresh_data'	// Added by Alfee 11.12.2007
		this.event ue_refreshdata(TRUE)			
		
	CASE 'report'
		//Start Change By Jervis 01.24.2007
		/*openwithparm(w_dm_document_report, inv_contract_details.of_get_ctx_id( ) )*/
		str_open_report lstr_pass
		lstr_pass.s_style = 'doc'
		if iw_parent.classname() = 'w_contract' Then
			lstr_pass.l_ctx_id  = inv_contract_details.of_get_ctx_id()
		Else
			lstr_pass.l_ctx_id = tab_1.tabpage_browse.dw_browse.getitemnumber(tab_1.tabpage_browse.dw_browse.getrow(),'ctx_id')
		End If
		lstr_pass.l_doc_id = il_doc_id
		lstr_pass.s_dataobject = "d_dm_browse_report"
		openwithparm(w_dm_document_report,lstr_pass )
		//End Change
	CASE 'select'
		event ue_preview(il_doc_id,idc_revision,is_doc_ext)
	CASE 'delete'
		this.event ue_delete( )
	CASE 'revision'
		IF tab_1.tabpage_browse.dw_browse.object.revision_control[tab_1.tabpage_browse.dw_browse.getrow()] = "0" THEN
			this.event ue_revision( )
		ELSE
			MessageBox("Start Version Control","Version control is already started for the document.")
		END IF
	CASE 'compare' //Alfee 07.23.2008
		this.event ue_compare()
	CASE 'undocheckout'	//jervis 10.27.2010
		this.event ue_undo_checkout()
	Case 'ue_show_sertifi_status' //Added By Ken.Guo 2011-06-16. 
		This.event ue_show_sertifi_status()
	Case 'ue_show_approve_status'
		This.event ue_show_approve_status()
	Case 'ue_document_history' //added by gavins 20120201
		This.event ue_document_history( )
	Case 'primary_document'	//Added By Mark Lee 10/30/2012
		This.event ue_primary_document( )
	CASE ELSE
		messagebox("Warning","Unsupported action code ["+as_action+"]. (Script: u_tabpg_dm_data.ue_do(as_action))",stopsign!)
END CHOOSE

//---------Appeon Begin ------------------------------------
//<Remark> Added by alfee 04.23.2007
IF Isvalid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)
//---------Appeon End----------------------------------------
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
If tab_1.tabpage_preview.ole_doc.object.doctype <> 1 Then Return //08.29.2007

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

str_pass lstr_pass
lstr_pass.s_string = ''
lstr_pass.w_parent_window = iw_parent
OpenWithParm(w_dm_add_clause,lstr_pass)


end event

event ue_mergedata(string as_mergemode);//////////////////////////////////////////////////////////////////////
// $<event>ue_mergedata of u_tabpg_dm_data()
// $<arguments>
//		value	string as_mergemode		
// $<returns> 
// $<description>Merge data in document with export file
// $<description>Called while opening document or pressed merge data toolbar
//////////////////////////////////////////////////////////////////////
// $<add> 01.17.2007 by Alfee (Contract Logix Document Management)
//-------Modified by alfee 04.28.2007----------------------------------
//////////////////////////////////////////////////////////////////////
Integer ll_export_id, li_cnt, i, li_rtn
string  ls_merge_tmp_file
Boolean lb_statuschanged_ori, lb_merged //
str_doc_info	lstr_docinfo
long ll_ctx_id

//If no word document opened
If tab_1.tabpage_preview.ole_doc.object.doctype <> 1 Then Return 

//If auto merge mode and file already merged
//---------Begin Modified by Alfee 06.25.2007---------------------------
lb_merged = inv_ole_utils_doc.of_ismerged()
If lower(as_mergemode) = 'auto' and lb_merged Then 
//If lower(as_mergemode) = 'auto' and inv_ole_utils_doc.of_ismerged() Then 
//---------End Modified ------------------------------------------------	
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergedata,'toolbaritemdown', True) //04.30.2007
	lstr_docinfo.ver_num = idc_preview_revision
	inv_ole_utils_doc.of_refresh_docinfo(tab_1.tabpage_preview.ole_doc.object.activedocument, lstr_docinfo,true)
	Return
End If

//---------Begin Added by Alfee 11.12.2007---------------
//Refresh data for dynamic adding only while Merge data manually
IF lower(as_mergemode) = 'manual' AND NOT lb_merged THEN 
	of_refreshdata()
END IF
//---------End Added ------------------------------------

//If no merge fields existed
//---------Begin Modified by Alfee 06.27.2007 -- for performance tunning-------
OLEObject lole_fields
lole_fields = tab_1.tabpage_preview.ole_doc.object.activedocument.Fields
li_cnt = lole_fields.count 
For i = 1 to li_cnt
	//Add DocVariable Field - 02.25.2009 by jervis
	//If lole_fields.Item[i].Type = wdFieldMergeField Then Exit
	If lole_fields.Item[i].Type = wdFieldMergeField or lole_fields.Item[i].Type = wdFieldDocVariable Then Exit
Next	
/*li_cnt = tab_1.tabpage_preview.ole_doc.object.activedocument.Fields.count 
For i = 1 to  li_cnt
	If tab_1.tabpage_preview.ole_doc.object.activedocument.Fields.Item[i].Type = wdFieldMergeField Then Exit
Next*/
//---------End Modified--------------------------------------------------------
IF i > li_cnt Then Return 

ls_merge_tmp_file = gs_dir_path + gs_DefDirName + "\agreement\_merged_data.doc"
	
gnv_appeondb.of_startqueue( )	//jervis 02.25.2009
//Get export id for merging	
Select ctx_acp_template.export_id Into :ll_export_id
  From ctx_am_document,ctx_acp_template
 Where ctx_am_document.doc_id = :il_preview_doc_id
  And ctx_am_document.from_templete_id = ctx_acp_template.ctx_acp_template_id;


//Start code by jervis 02.25.2009
//Get Doc Info
select doc_name,create_by,create_date 
into :lstr_docinfo.doc_name,:lstr_docinfo.create_by,:lstr_docinfo.ver_date
from ctx_am_document
where doc_id = :il_preview_doc_id;
gnv_appeondb.of_commitqueue( )	//jervis 02.25.2009
lstr_docinfo.ver_num = idc_preview_revision
If Not ll_export_id > 0 Then Return //added by alfee 04.28.2007
//end code by jervis 02.25.2009

setredraw(false)
lb_statuschanged_ori = inv_ole_utils_doc.of_isstatuschanged( ) //Alfee 05.15.2007
inv_ole_utils_doc.of_setstatuschanged(FALSE) //alfee 04.23.2007	

//Merge data (both on manaul and auto mode)
tab_1.tabpage_preview.ole_doc.object.savetolocal(ls_merge_tmp_file, True)			
tab_1.tabpage_preview.ole_doc.object.close()
//ll_ctx_id = inv_contract_details.of_get_ctx_id( )
if iw_parent.classname() = 'w_contract' Then
	ll_ctx_id = inv_contract_details.of_get_ctx_id()
Else
	ll_ctx_id = tab_1.tabpage_browse.dw_browse.getitemnumber(tab_1.tabpage_browse.dw_browse.getrow(),'ctx_id')
End If


If lower(as_mergemode) = 'auto' Then 
	//merge data under auto mode	
	If not isvalid(w_appeon_gifofwait) Then OpenwithParm(w_appeon_gifofwait,"Merging Data ...")		
	
	
	//li_rtn = inv_ole_utils_doc.of_mergedata_auto(ll_export_id, inv_contract_details.of_get_ctx_id( ),ls_merge_tmp_file,is_opened_file,true)	
	li_rtn = inv_ole_utils_doc.of_mergedata_auto(ll_export_id, ll_ctx_id,ls_merge_tmp_file,is_opened_file,false,lstr_docinfo)	//modify by Jervis 02.25.2009
	
	//If li_rtn > 0 Then m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergedata.toolbaritemdown = True
	inv_ole_utils_doc.of_displayfile(is_opened_file, inv_ole_utils_doc.of_isreadonly()) 	
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergedata,'toolbaritemdown', inv_ole_utils_doc.of_ismerged())	//05.05.2007 Alfee
Else  
	//merge or unmerge data under manaul mode	
	//li_rtn = inv_ole_utils_doc.of_mergedata(ll_export_id, inv_contract_details.of_get_ctx_id( ),ls_merge_tmp_file,is_opened_file,True) 
	
	//li_rtn = inv_ole_utils_doc.of_mergedata(ll_export_id, inv_contract_details.of_get_ctx_id( ),ls_merge_tmp_file,is_opened_file,lb_merged) //modifed by Alfee 06.25.2007
	li_rtn = inv_ole_utils_doc.of_mergedata(ll_export_id, ll_ctx_id,ls_merge_tmp_file,is_opened_file,lb_merged,lstr_docinfo) //modifed by jervis 02.25.2009
	
	inv_ole_utils_doc.of_displayfile(is_opened_file, inv_ole_utils_doc.of_isreadonly()) 	
	tab_1.tabpage_preview.ole_doc.object.ActiveDocument.Saved = False
	//If li_rtn > 0 Then m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergedata.toolbaritemdown = inv_ole_utils_doc.of_ismerged()
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergedata,'toolbaritemdown', inv_ole_utils_doc.of_ismerged()) //05.05.2007 Alfee
End If

//-----Begin Modified by Alfee 05.15.2007-----------
//inv_ole_utils_doc.of_setstatuschanged(TRUE) //alfee 04.23.2007	
inv_ole_utils_doc.of_setstatuschanged(lb_statuschanged_ori)
//-----End Modified-------------------------------

setredraw(true)

FileDelete(ls_merge_tmp_file)
tab_1.tabpage_preview.ole_doc.setfocus()
IF isvalid( w_export_progress) THEN CLOSE(w_export_progress)	
//-------Appeon Begin by alfee 04.23.2007---------------
//If isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)		
//-------Appeon End--------------------------------------

end event

event type integer ue_save(boolean ab_rev_ctrl);/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: ab_rev_ctrl: True - Revision operation; False - Save operation
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: Save current document to DB
**==================================================================================================================
**  Created By	: Davis 01.23.2007
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

Boolean lb_revision_control
Integer li_ret
Decimal ldec_new_revision
String ls_filename, ls_filename_writable
DateTime ldt_modify_date
str_add_audit lstr_add_audit
Long ll_row
Long ll_level
Boolean lb_checkout_status
long li_version_increment
str_doc_info	lstr_docinfo
Decimal ldec_max_revision   //Added By Ken.Guo 2009-05-15
n_cst_word_utility lnv_word_utility //Added By Ken.Guo 2009-06-30.

ldt_modify_date = DateTime(Today(), Now())

ll_row = tab_1.tabpage_browse.dw_browse.GetRow()
lb_revision_control = (tab_1.tabpage_browse.dw_browse.GetItemString(ll_row, "revision_control") = "1")
li_version_increment = of_get_app_setting("set_57",'I')	//Version Number Increment Option
ll_level = tab_1.tabpage_browse.dw_browse.GetItemNumber(ll_row, "level")
//lb_checkout_status = (tab_1.tabpage_browse.dw_browse.GetItemString(ll_row, "checkout_status") = "1")
lb_checkout_status = (tab_1.tabpage_browse.dw_browse.GetItemString(ll_row, "checkout_status") <> "0") //Added by Ken.Guo on 2009-03-27

// Check rights
IF ll_level = 2 THEN
	MessageBox("Save Document", "Can't save a history revision.")
	RETURN 0
END IF

IF lb_checkout_status THEN
	MessageBox("Save Document", "Can't save a checked-out document.")
	RETURN 0
END IF

CHOOSE CASE Lower(is_doc_ext)
	CASE "doc" , 'xls','xlsx' //Added By Ken.Guo 2009-09-07. added 'xls','xlsx' 
		IF lb_revision_control AND NOT inv_ole_utils_doc.of_ismodified( ) THEN
			MessageBox("Save Document", "The document is not modified.")
			RETURN 0
		END IF

		IF ab_rev_ctrl THEN lb_revision_control = ab_rev_ctrl //by alfee 03.27.2007 press revison toolbar
		
		IF NOT lb_revision_control THEN
			li_ret = MessageBox("Save Doucment", "Do you want to start version control?", Question!, YesNo!, 1)
			IF li_ret = 1 THEN
				lb_revision_control = TRUE
			ELSE
				IF NOT inv_ole_utils_doc.of_ismodified( ) THEN 
					MessageBox("Save Document", "The document is not modified.") //added by alfee at 04.13.2007
					RETURN 0
				END IF
			END IF
		END IF
		
//		Setpointer(HourGlass!)
		//by alfee at 03.27.2007
		IF ab_rev_ctrl THEN
			Openwithparm(w_appeon_gifofwait, "Generating the new revision document...")			
		Else
			Openwithparm(w_appeon_gifofwait, "Saving the document...")
		END IF

		// Increment revision number
		//Start code by Jervis 02.19.2009
		//0-	Turn off versioning control
		//1-	Increment version Number each time document is Update(Default)
		//2-	Increment Version Number on Check in /Out only
		//IF lb_revision_control THEN
		Select Max(Revision) Into :ldec_max_revision From Ctx_am_doc_image	Where Doc_id = :il_doc_id;   //Added By Ken.Guo 2009-05-15. Get newest revision.
		
		//IF lb_revision_control and li_version_increment = 1 THEN	
		IF (lb_revision_control and li_version_increment = 1) or ab_rev_ctrl THEN // Jervis 06.10.2009
		//End code by jervis 02.19.2009
			//ldec_new_revision = inv_dm_utils.of_newversion( idc_revision )
			ldec_new_revision = inv_dm_utils.of_newversion( ldec_max_revision )   //Modified By Ken.Guo 2009-05-15
		ELSE
			//ldec_new_revision = idc_revision
			ldec_new_revision = ldec_max_revision  //Modified By Ken.Guo 2009-05-15
		END IF
		
		// Generate file name
		ls_filename = inv_dm_utils.of_generate_tempname(il_doc_id, ldec_new_revision, is_doc_ext)
		ls_filename_writable = inv_dm_utils.of_generate_tempname_writable(il_doc_id, ldec_new_revision, is_doc_ext)
		
//		//Check numbering 
//		SetRedraw(False)
//		inv_ole_utils_doc.of_auto_numbering(TRUE)
//		SetRedraw(True)
		
		//---------Begin Commented by Alfee 08.30.2007----------
		//<$Reason>Move to below
		/*// Save document
		inv_ole_utils_doc.of_savetofile( ls_filename )
		inv_ole_utils_doc.of_savetofile( ls_filename_writable )*/
		//---------End Commented -------------------------------
		
		//Unprotect the document if necessary - Alfee 03.10.2008
		//inv_ole_utils_doc.of_unprotect_doc() 
		if not ab_rev_ctrl then
			IF  inv_ole_utils_doc.of_unprotect_doc() = -1 THEN //Alfee 10.08.2008
			//Added By Mark Lee 05/28/2013
//				IF IsValid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)
//				RETURN -1 
			END IF
		end if
		
		IF lb_revision_control THEN
			//gnv_appeondb.of_startqueue( )	
			
			//1-Increment version Number each time document is Update(Default) by jervis 02.19.2009
			if li_version_increment = 1 or ab_rev_ctrl then
				// Insert new record of image to the DB
				//-------Begin Added by Alfee 08.30.2007------------------
				If ab_rev_ctrl Then //revision operation
					//Add doc_ext_full Filed  - jervis 10.21.2009
					INSERT Ctx_am_doc_image(Doc_id, Revision, doc_ext, modify_date, image_file,doc_ext_full)
					Select :il_doc_id, :ldec_new_revision, :is_doc_ext, :ldt_modify_date, image_file ,:is_doc_ext
					  FROM ctx_am_doc_image Where doc_id = :il_doc_id And revision = :idc_revision ;
				Else //save operation 
				//---------End Added -------------------------------------	
					//Restore clauses with no editing right - Added by Alfee 09.21.2007
					IF of_restore_clause() < 0 THEN 
						IF IsValid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)
						RETURN 0	
					END IF
					
					//---------Begin Modified by (Appeon)Harry 11.06.2014 - IntelliContract: Restore Of Corrupt Document Version From Earlier One--------
					/*
					//Add doc_ext_full Filed  - jervis 10.21.2009
					INSERT Ctx_am_doc_image(Doc_id, Revision, doc_ext, modify_date,doc_ext_full)
					Values( :il_doc_id, :ldec_new_revision, :is_doc_ext, :ldt_modify_date ,:is_doc_ext);
					*/
					//when Internet Explorer crashes upon the “save” of a modified MS-Word document via IntelliContract.  The result is that the most-current document version is blank
					INSERT Ctx_am_doc_image(Doc_id, Revision, doc_ext, modify_date, image_file,doc_ext_full)
					Select :il_doc_id, :ldec_new_revision, :is_doc_ext, :ldt_modify_date, image_file ,:is_doc_ext
					  FROM ctx_am_doc_image Where doc_id = :il_doc_id And revision = :idc_revision ;
					//---------End Modfiied ------------------------------------------------------
				End If //08.30.2007				
			else
				//Restore clauses with no editing right - Added by Alfee 09.21.2007
				IF of_restore_clause() < 0 THEN 
					IF IsValid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)
					RETURN 0	
				END IF
			end if
				
			// Set check out status to record
			UPDATE Ctx_am_document
				SET 	revision = :ldec_new_revision,
				revision_control = '1',
				checkout_by = '',
				checkout_date = NULL,
				checkout_status = '0'
				Where Doc_id = :il_doc_id;
				
			 //COMMIT;  marked by alfee at 03.14.2007 for performance tuning
			//gnv_appeondb.of_commitqueue( )
			
			//STart code by jervis 02.26.2009
			//Refresh version number data alter saved.
			if ldec_new_revision <> idc_revision and inv_ole_utils_doc.of_isinitialized( ) then //Jervis 06.10.2009--of_isinitialized
				lstr_docinfo.ver_num = ldec_new_revision
				inv_ole_utils_doc.of_refresh_docinfo( this.tab_1.tabpage_preview.ole_doc.object.ActiveDocument , lstr_docinfo,true)
				
				//Refresh doc info-jervis 02.26.2009
				//st_docinfo.text = tab_1.tabpage_browse.dw_browse.GetItemString(ll_row,"Doc_name") + " - Version: " + string(ldec_new_revision)
				//st_docinfo.text = tab_1.tabpage_browse.dw_browse.GetItemString(tab_1.tabpage_browse.dw_browse.getrow(),"Doc_name_full") 
				st_docinfo.text =   tab_1.tabpage_browse.dw_browse.GetItemString( tab_1.tabpage_browse.dw_browse.getrow(),"Doc_name")  + ' ' + &
											 string(   tab_1.tabpage_browse.dw_browse.GetItemNumber( tab_1.tabpage_browse.dw_browse.getrow(),"Doc_id") ) + '.' 
				st_docinfo.Text += string(ldec_new_revision, '##0.0' )
			end if
			//End code by jervis 02.26.2009
			
		//-------Begin Added by Alfee 09.21.2007--------------------------			
		ELSE //Revison control not started
			//Restore clauses with no editing right
			IF of_restore_clause() < 0 THEN 
				IF IsValid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)
				RETURN 0	
			END IF	
		//-------End Added ------------------------------------------------						
		END IF
		
		If IsValid(w_appeon_gifofwait) Then w_appeon_gifofwait.event timer()

		//---------Begin Added by Alfee 08.30.2007---------------
		If Not ab_rev_ctrl Then //Save operation
			// Save document
			inv_ole_utils_doc.of_savetofile( ls_filename )
			inv_ole_utils_doc.of_savetofile( ls_filename_writable )
			
			//Added By Ken.Guo 2009-09-07. Set saved properties.
			If lower(is_doc_ext) = 'xls' or lower(is_doc_ext) = 'xlsx' Then
				inv_ole_utils_doc.of_setsaved(true)
			End If
		//---------End Added --------------------------------------	
			// Upload local file to DB
			inv_dm_utils.of_upload_file( il_doc_id, ldec_new_revision, ls_filename)
			IF Upper(tab_1.tabpage_browse.dw_browse.object.doc_type[tab_1.tabpage_browse.dw_browse.getrow()]) = "S" THEN
				//Added By Ken.Guo 2009-06-30.
				lnv_word_utility = Create n_cst_word_utility 
				lnv_word_utility.of_update_reqmnt_field(tab_1.tabpage_preview.ole_doc.object , il_doc_id, 'D') 
				Destroy lnv_word_utility
			End If
			
		End If //
		
		//update clause map for word document
		of_updateclausemap(ldec_new_revision)
		
		//-------Appeon Begin - added by alfee at 03.14.2007 for performance tuning
		IF tab_1.tabpage_preview.dw_change.visible THEN 
			//Get changed text in document if clause map on
			of_getchanges() 
			//Set Approve/Reject button if clause map on
		   of_setreviewbutton()
		END IF
		//-------Appeon End-----------
		
		//Save the latest update date of the current file in Registry
		inv_dm_utils.of_updateregistry(il_doc_id, ldec_new_revision, is_doc_ext, ldt_modify_date)
		
		///////////////////////////////////////////////////////////////////// //
		//// Trigger off audit trail
		///////////////////////////////////////////////////////////////////////
		lstr_add_audit.Doc_id = il_doc_id
		lstr_add_audit.Revision = ldec_new_revision
		lstr_add_audit.doc_ext = is_doc_ext
		lstr_add_audit.action = "Modified"
		inv_dm_utils.of_add_audit_trail( lstr_add_audit )

		If IsValid(w_appeon_gifofwait) Then w_appeon_gifofwait.event timer()

		// Refresh painter
		IF lb_revision_control THEN
			tab_1.tabpage_browse.dw_browse.SetItem(ll_row, "revision_control", "1")
			
			//1-Increment version Number each time document is Update(Default) by jervis 02.19.2009
			//if li_version_increment = 1 or ab_rev_ctrl then //jervis 06.10.2009-- add ab_rev_ctrl
				tab_1.tabpage_browse.dw_browse.SetItem(ll_row, "revision", ldec_new_revision)
				THIS.of_collapse_row( il_doc_id, tab_1.tabpage_browse.dw_browse.GetRow())
				THIS.EVENT ue_doc_changed( il_doc_id, il_doc_id, idc_revision,ldec_new_revision )
				idc_revision = ldec_new_revision
				This.inv_ole_utils_doc.is_current_file = ls_filename_writable
				
			//end if
			If IsValid(w_appeon_gifofwait) Then w_appeon_gifofwait.event timer()
		END IF
		
		//IF Isvalid(w_appeon_gifofwait) THEN POST Close(w_appeon_gifofwait)
		IF Isvalid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait) //03.28.2008
		
	CASE ELSE // SAVE TIF DOCUMENT
		//-----------Begin Modified by Alfee on 05.19.2008 ----------------	
		//li_ret = tab_1.tabpage_preview.uo_1.EVENT ue_save( )
		IF gi_imageocx = 1 THEN //Imaging 360
			//li_ret = tab_1.tabpage_preview.uo_1.EVENT ue_save( )
		ELSE	//new Image OCX
			li_ret = tab_1.tabpage_preview.uo_2.EVENT ue_save( )
		END IF
		//-----------End Modified -----------------------------------------
		
		IF li_ret > 0 THEN
			//-----------Begin Modified by Alfee on 05.19.2008 ----------------	
			//ldec_new_revision = tab_1.tabpage_preview.uo_1.of_get_revision( )
			IF gi_imageocx = 1 THEN //Imaging 360
				//ldec_new_revision = tab_1.tabpage_preview.uo_1.of_get_revision( )
			ELSE	//new Image OCX
				ldec_new_revision = tab_1.tabpage_preview.uo_2.of_get_revision( )
			END IF
			//-----------End Modified -----------------------------------------			
			IF lb_revision_control THEN
				tab_1.tabpage_browse.dw_browse.SetItem(ll_row, "revision_control", "1")
				//Start code by jervis 02.19.2009
				//Version nunber increment control
				//0-	Turn off versioning control
				//1-	Increment version Number each time document is Update(Default)
				//2-	Increment Version Number on Check in /Out only
				if li_version_increment = 1  then
				//End cody by jervis 02.19.2009
					tab_1.tabpage_browse.dw_browse.SetItem(ll_row, "revision", ldec_new_revision)
					THIS.of_collapse_row( il_doc_id, tab_1.tabpage_browse.dw_browse.GetRow())
					THIS.EVENT ue_doc_changed( il_doc_id, il_doc_id, idc_revision, ldec_new_revision)
					idc_revision = ldec_new_revision
				end if
				
			END IF
		ELSE
			return li_ret
		END IF
END CHOOSE

idc_preview_revision = ldec_new_revision //added by alfee at 03.27.2007 for performance tunning

//added by gavins 20120229
of_insertdetail(  tab_1.tabpage_browse.dw_browse, tab_1.tabpage_browse.dw_detail  )

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
Boolean lb_checkout_status,lb_checkout_status_exits
Long ll_row,ll_doc_id

IF tab_1.tabpage_browse.dw_browse.Rowcount( ) = 0 THEN RETURN
IF tab_1.tabpage_browse.dw_browse.Getrow( ) = 0 THEN RETURN

////lb_checkout_status = (tab_1.tabpage_browse.dw_browse.GetItemString(tab_1.tabpage_browse.dw_browse.Getrow( ), "checkout_status") = "1")
//lb_checkout_status = (tab_1.tabpage_browse.dw_browse.GetItemString(tab_1.tabpage_browse.dw_browse.Getrow( ), "checkout_status") <> "0") //Modified by Ken.Guo on 2009-03-27
//IF lb_checkout_status THEN
//	MessageBox("Save Document", "Can't delete a checked-out document.")
//	RETURN
//END IF

ll_row = tab_1.tabpage_browse.dw_browse.GetSelectedRow(0)
If ll_row = 0 Then Return

li_ret = messagebox('Delete Document', 'Are you sure you want to delete the selected document(s)?',question!,Yesno!,2)
IF li_ret = 2 THEN RETURN

If Tab_1.Selectedtab = 1 Then
	Do While ll_row > 0 
		lb_checkout_status = (tab_1.tabpage_browse.dw_browse.GetItemString(ll_row, "checkout_status") <> "0") //Modified by Ken.Guo on 2009-03-27
		IF lb_checkout_status THEN
			lb_checkout_status_exits = True
			ll_row = tab_1.tabpage_browse.dw_browse.GetSelectedRow(ll_row)
			Continue
		END IF
		ll_doc_id = tab_1.tabpage_browse.dw_browse.GetItemNumber(ll_row, 'doc_id')
		of_delete(ll_doc_id)
		ll_row = tab_1.tabpage_browse.dw_browse.GetSelectedRow(ll_row)
	Loop
Else
	ll_doc_id = tab_1.tabpage_browse.dw_browse.GetItemNumber(tab_1.tabpage_browse.dw_browse.GetRow(), 'doc_id')
	of_delete(ll_doc_id)	
End If

//gnv_appeondb.of_startqueue( )
//
//DELETE FROM  Ctx_am_doc_audit WHERE doc_id = :il_doc_id;
//DELETE FROM  ctx_am_ai_notification_user WHERE doc_id = :il_doc_id; 	//Alfee 02.26.2008
//DELETE FROM  ctx_am_ai_alarm_attachment WHERE doc_id = :il_doc_id;	//Added by WuZhiJun on 2009-02-26
//DELETE FROM  ctx_am_ai_notification WHERE doc_id = :il_doc_id; 		//Alfee 02.26.2008
//DELETE FROM  ctx_am_action_item WHERE doc_id = :il_doc_id;
////----------Appeon Begin - by alfee 04.23.2007----------
//DELETE FROM  Ctx_am_document_clause WHERE doc_id = :il_doc_id;
//DELETE FROM  Ctx_am_doc_image WHERE doc_id = :il_doc_id;
////DELETE FROM  Ctx_am_document_clause WHERE doc_id = :il_doc_id;
////----------Appeon End ----------------------------------
//DELETE FROM  Ctx_am_document WHERE doc_id = :il_doc_id;
//COMMIT;
//
//gnv_appeondb.of_commitqueue( )

//Begin - Added By Mark Lee 12/17/2012
If isvalid(w_tabpg_contract_doc_mgr) Then 
	w_tabpg_contract_doc_mgr.ibn_refresh = True
	w_tabpg_contract_doc_mgr.of_refreshdata()
End If
//End - Added By Mark Lee 12/17/2012

This.event ue_retrieve( )

If lb_checkout_status_exits Then
	MessageBox("Delete Document", "Can't delete the checked-out document(s).")	
End If

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
//below added and marked by alfee at 03.27.2007
This.Event ue_save(TRUE)

//Integer li_ret
//Decimal ldec_new_revision
//
//IF tab_1.tabpage_browse.dw_browse.object.revision_control[tab_1.tabpage_browse.dw_browse.getrow()] = "0" THEN
//	li_ret = MessageBox("Start Version Control", "Do you want to start version control?", Question!, YesNo!, 1)
//	IF li_ret = 1 THEN
//		ldec_new_revision = inv_dm_utils.of_newversion( idc_revision )
//		
//		gnv_appeondb.of_startqueue( )
//		
//		INSERT ctx_am_doc_image(Doc_id, Revision, doc_ext, modify_date, image_file)
//		SELECT doc_id, :ldec_new_revision, doc_ext, getdate(), image_file
//		FROM ctx_am_doc_image
//		Where doc_id = :il_doc_id 
//			And revision = :idc_revision;
//			
//		Update ctx_am_document
//		Set revision = :ldec_new_revision,
//			revision_control = '1'
//		Where doc_id = :il_doc_id 
//			And revision = :idc_revision;
//			
//		Insert Ctx_am_document_clause(Doc_id, Revision, ctx_acp_clause_id, orders )
//		Select Doc_id, :ldec_new_revision, ctx_acp_clause_id, orders
//		From	Ctx_am_document_clause
//		Where doc_id = :il_doc_id
//			And Revision = :idc_revision;
//
//		Commit;
//		
//		gnv_appeondb.of_commitqueue( )
//		
//		///////////////////////////////////////////////////////////////////// //
//		//// Trigger off audit trail
//		///////////////////////////////////////////////////////////////////////
//		str_add_audit lstr_add_audit
//		lstr_add_audit.doc_id = il_doc_id
//		lstr_add_audit.revision = ldec_new_revision
//		lstr_add_audit.doc_ext = is_doc_ext
//		lstr_add_audit.action = "Start Version Control"
//		inv_dm_utils.of_add_audit_trail( lstr_add_audit )
//
//		Event ue_retrieve()
//	END IF
//END IF

end event

event ue_insertfield();//////////////////////////////////////////////////////////////////////
// $<event>ue_insertfieldu_tabpg_dm_data()
// $<arguments>
//		value	integer		
// $<returns> 
// $<description>Insert a selected field into document
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.30.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////

long ll_export_id,ll_row
string ls_merge_field

IF IsNull(il_doc_id) THEN RETURN
If tab_1.tabpage_preview.ole_doc.object.DocType <> 1 Then return //no word document opened

Select export_id into :ll_export_id 
  From ctx_am_document
 Where doc_id = :il_doc_id;


IF isnull(ll_export_id) THEN 
	messagebox("IntelliSoftGroup","There isn't a related export id found, please check it firstly!")  //(Appeon)Harry 01.28.2014 - V142 ISG-CLX  Modify "ContractLogix" to "IntelliSoftGroup"
	RETURN
END IF


//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 25/04/2007 By: Jervis
//$<reason> 
//openwithparm(w_agreement_template_merge_fields,ll_export_id)
str_pass lstr_pass
lstr_pass.s_long[1] = ll_export_id
lstr_pass.s_string = "DOCUMENT"
lstr_pass.w_parent_window = iw_parent //Added By Ken.Guo 2010-07-31.
openwithparm(w_agreement_template_merge_fields,lstr_pass)
//---------------------------- APPEON END ----------------------------

//w_agreement_template_merge_fields.of_set_parent(iw_parent)
//w_agreement_template_merge_fields.of_set_object(tab_1.tabpage_preview.ole_doc.object.ActiveDocument) //commented by alfee 05.25.2007

/*
ls_merge_field = Message.Stringparm

If not len(ls_merge_field) > 0 Then 
	return
End If

//Insert field
inv_ole_utils_doc.of_insertfield(ls_merge_field)
*/


end event

event ue_refresh_audit(long ll_doc_id);Long ll_row

ll_row = tab_1.tabpage_browse.dw_browse.Find( "doc_id = " + String(ll_doc_id) + " And level = 1", 1, 1000)
IF ll_row > 0 THEN
	THIS.of_collapse_row( ll_doc_id, ll_row )
END IF

RETURN
end event

event ue_autonum();//////////////////////////////////////////////////////////////////////
// $<event>ue_addclause.ue_autonum()
// $<arguments>
//		value	string
// $<returns> 
// $<description>Insert a symbol in word document for auto numbering
//////////////////////////////////////////////////////////////////////
// $<add> 04.19.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////
IF IsNull(il_doc_id) THEN RETURN

If tab_1.tabpage_preview.ole_doc.object.DocType <> 1 Then return //no word document opened

//--------Begin Modified by Alfee 05.25.2007---------------
//Open(w_clause_insnum)
//w_clause_insnum.of_set_object(tab_1.tabpage_preview.ole_doc.object.activedocument)
OpenwithParm(w_clause_insnum, 'document')
//--------End Modified ---------------------------------------

end event

event ue_set_addsell(boolean ab_add_sell);ib_add_sell = ab_add_sell

//Force to export while add a new sell document - added by alfee 09.06.2007
If ib_add_sell then inv_ole_utils_doc.of_ini_expinfo()
end event

event type integer ue_refreshdata(boolean ab_merge);//////////////////////////////////////////////////////////////////////
// $<event>ue_refreshdata() of u_tabpg_dm_data
// $<arguments>
//		value	integer		
// $<returns> integer 
// $<description>Refresh data in document(dynamic adding of clauses and merge data)
//////////////////////////////////////////////////////////////////////
// $<add> 11.12.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////

//Refresh Data forcibly(Dynamic adding and merging data)

inv_ole_utils_doc.of_setmergestatus(False)
This.event ue_mergedata("manual")

RETURN 1

end event

event ue_checkout();//Check out document - Added by Alfee 12.14.2007
//<$Reason>Avoiding to call a response window in another response window
Integer li_rtn,i //03.28.2008
String ls_notes
str_add_doc lstr_add_doc_arr[],lstr_add_doc
str_checkout lstr_checkout
str_ctx_email lstr_dm_email
str_add_audit lstr_add_audit[]
//n_cst_dm_utils lnv_dm_utils
String ls_action_name //Added by Ken.Guo on 2009-03-26
String ls_checkout_status = '1' //Added by Ken.Guo on 2009-03-27
Long ll_current_row,ll_cnt
str_add_doc_multi lstr_add_doc_multi
string ls_docext,ls_filetype

If tab_1.tabpage_browse.dw_browse.rowcount() = 0 Then Return

//------------Begin Added by Alfee 03.28.2008------------------------------------------------------------
//Check if the document modified
IF NOT of_issaved() THEN
	li_rtn = MessageBox("Save Document","The document has been modified, save it first?",Question!,YesNoCancel!) 
	IF li_rtn = 1 THEN 
		This.Event ue_save(FALSE)
	ELSEIF li_rtn = 3 THEN
		RETURN
	END IF
END IF		
//-------------End Added -------------------------------------------------------------
If Not IsValid( idw_LastDW ) Or  iw_parent.classname()  = 'w_documents_browse' Then  
	tab_1.tabpage_browse.dw_browse.SetFocus( )
	idw_LastDW = tab_1.tabpage_browse.dw_browse
End If
ll_current_row = idw_LastDW.getselectedrow(0)
If ll_current_row <= 0 Then ll_current_row = idw_LastDW.getrow()
If ll_current_row = 0 Then Return


i = 0
Do While ll_current_row > 0 
	i++
	//-------------Begin Added by Alfee 03.13.2008---------------------------------
	IF idw_LastDW.getitemnumber(ll_current_row,'level') = 2 THEN
		idw_LastDW.scrolltorow(ll_current_row)		
		MessageBox("Check Out","Can't check out a history revision.")
		RETURN
	END IF	
	//-------------End Added ------------------------------------------------------
	
	//Can't Check out a document whose Revision Control isn't started
	IF idw_LastDW.object.revision_control[ll_current_row] <> "1" THEN
		idw_LastDW.scrolltorow(ll_current_row)
		MessageBox("Check Out","Please start Revision Control for the document first.")
		RETURN
	END IF
	
	//Do nothing on a document which has been currently Checked out 
	IF idw_LastDW.object.checkout_status[ll_current_row] <> "0" THEN
		idw_LastDW.scrolltorow(ll_current_row)		
		MessageBox("Check Out","The document is already checked out.")
		RETURN
	END IF	
	
	//Get documents info for Email
	Choose Case iw_parent.classname() 
		Case 'w_contract' 
			lstr_add_doc_arr[i].doc_from = 'DM'
			lstr_add_doc_arr[i].ctx_id =  inv_contract_details.of_get_ctx_id()
			lstr_dm_email.ctx_id_list[i] = inv_contract_details.of_get_ctx_id()
		Case 'w_documents_browse'
			lstr_add_doc_arr[i].doc_from = 'DM_BROWSE'
			lstr_add_doc_arr[i].ctx_id =  idw_LastDW.getitemnumber(ll_current_row,'ctx_id')
			lstr_dm_email.ctx_id_list[i] = idw_LastDW.getitemnumber(ll_current_row,'ctx_id')
	End Choose	
	lstr_dm_email.doc_id_list[i] =  idw_LastDW.getitemnumber(ll_current_row,'doc_id')
	lstr_dm_email.revision_list[i] = idw_LastDW.getitemdecimal(ll_current_row,'revision')
	lstr_dm_email.filename_list[i] = idw_LastDW.getitemstring(ll_current_row,'doc_name')
	lstr_dm_email.doc_ext_list[i] = idw_LastDW.getitemstring(ll_current_row,'doc_ext')
	
	//for Audit
	lstr_add_audit[i].doc_id = lstr_dm_email.doc_id_list[i]
	lstr_add_audit[i].revision = lstr_dm_email.revision_list[i] 
	lstr_add_audit[i].doc_ext = idw_LastDW.getitemstring(ll_current_row,'doc_ext')
	
	//For save as
	lstr_add_doc_arr[i].revision_control = True//tab_1.tabpage_browse.dw_browse.object.revision_control[ll_current_row] = "1"
	lstr_add_doc_arr[i].doc_id =lstr_dm_email.doc_id_list[i]
	lstr_add_doc_arr[i].revision =  lstr_dm_email.revision_list[i] 
	lstr_add_doc_arr[i].doc_ext = idw_LastDW.getitemstring(ll_current_row,'doc_ext')
	lstr_add_doc_arr[i].filename =	idw_LastDW.object.doc_name[ll_current_row]
	
	ll_current_row = idw_LastDW.getselectedrow(ll_current_row)
Loop 


//lstr_add_doc.revision_control = True//tab_1.tabpage_browse.dw_browse.object.revision_control[ll_current_row] = "1"
//lstr_add_doc.doc_id = this.il_doc_id
//lstr_add_doc.revision = this.idc_revision
//lstr_add_doc.doc_ext = this.is_doc_ext
//lstr_add_doc.filename =	tab_1.tabpage_browse.dw_browse.object.doc_name[	tab_1.tabpage_browse.dw_browse.getrow()]


Choose Case iw_parent.classname() 
	Case 'w_contract' 
		lstr_add_doc.doc_from = 'DM'
		lstr_add_doc.ctx_id = lstr_dm_email.ctx_id_list[1]
	Case 'w_documents_browse'
		lstr_add_doc.doc_from = 'DM_BROWSE' 	
		lstr_add_doc.ctx_id = lstr_dm_email.ctx_id_list[1]
End Choose

//Open the checkout type selection window and return if cancelled
OpenWithParm( w_dm_checkout_document, lstr_add_doc )
IF NOT Isvalid(Message.PowerobjectParm) THEN RETURN
			
lstr_checkout = Message.PowerobjectParm
ls_notes = lstr_checkout.checkout_notes

//Open the saveas or email window according to the above selection 
CHOOSE CASE lstr_checkout.checkout_type
	CASE "1"		// Only check out
		//this option is never selectable
	CASE "2"		// Check out with save as
		ls_action_name = 'Check Out & Save As' //Added by Ken.Guo on 2009-03-26

		lstr_add_doc_multi.astr_add_doc[] = lstr_add_doc_arr[]
		openwithparm(w_dm_saveto_document, lstr_add_doc_multi)
		IF Message.Doubleparm <> 1 THEN 	RETURN
	CASE "3"		// Check out With Email as attachment
		ls_action_name = 'Check Out & Email-Attachment' //Added by Ken.Guo on 2009-03-26
		
		//For web link
//		lstr_dm_email.doc_id = lstr_add_doc.doc_id
//		lstr_dm_email.revision = lstr_add_doc.revision
//		lstr_dm_email.doc_ext = lstr_add_doc.doc_ext
//		lstr_dm_email.filename = lstr_add_doc.filename
		
		lstr_dm_email.doc_from = 'DM'
		lstr_dm_email.action_type = 'CheckOut'
		lstr_dm_email.ctx_id = lstr_add_doc.ctx_id //for show error message
		lstr_dm_email.is_weblink = '0' //Added by Ken.Guo on 2009-03-26

//		lstr_dm_email.ctx_id_list[1] = lstr_add_doc.ctx_id
//		lstr_dm_email.doc_id_list[1] = lstr_add_doc.doc_id
//		lstr_dm_email.revision_list[1] = lstr_add_doc.revision
		openwithparm(w_dm_email_document_send, lstr_dm_email)
		IF Message.Doubleparm <> 1 THEN 	RETURN	
	Case "4"  // Check out With Email as web link. Added by Ken.Guo on 2009-03-26
		ls_action_name = 'Check Out & Email-Web Link' //Added by Ken.Guo on 2009-03-26
		
		//for web link
//		lstr_dm_email.doc_id = lstr_add_doc.doc_id
//		lstr_dm_email.revision = lstr_add_doc.revision
//		lstr_dm_email.doc_ext = lstr_add_doc.doc_ext
//		lstr_dm_email.filename = lstr_add_doc.filename
		
		lstr_dm_email.doc_from = 'DM'
		lstr_dm_email.action_type = 'CheckOut'
		lstr_dm_email.ctx_id = lstr_add_doc.ctx_id
		lstr_dm_email.is_weblink = '1'
		ls_checkout_status = '2'
		
		If UpperBound(lstr_dm_email.doc_id_list[]) > 1 Then
			Messagebox('Check Out','You must select only one document to check out with web link.')
			Return
		End If
		
		openwithparm(w_dm_email_document_send, lstr_dm_email)
		IF Message.Doubleparm <> 1 THEN 	
			//Delete waste data.
			Delete from ctx_am_image_weblink where doc_id = :lstr_dm_email.doc_id and revision = :lstr_dm_email.revision; 
			RETURN			
		End If
	Case '5' //Check out with Sertifi
		//ls_checkout_status = '5'  //5: checked out; 6: all client users signed.
//		Event ue_checkout_sertify()
//		Return
         choose case gs_esigntype //Modified By Jay Chen 10-11-2013
			case 'sertifi'
				Event ue_checkout_sertify()
			case 'echosign' 
				//Check: once checkout can only selected one row
				if i > 1 then //Added By Jay Chen 10-11-2013
					Messagebox('Check Out','You can only select one document to check out with Echosign Signature mode.')
					Return
				end if
				//Check file type is or not support  Added By Jay Chen 10-12-2013
				ls_filetype = ',pdf,doc,docx,xls,xlsx,ppt,pptx,'
				for i = 1 to UpperBound(lstr_dm_email.doc_ext_list[])
					if pos(ls_filetype, ',' + lower(lstr_dm_email.doc_ext_list[i]) + ',') <= 0 then
						Messagebox('Check Out','Echosign signature only support the follow document types:pdf,doc,docx,xls,xlsx,ppt,pptx .')
					    Return
					end if
				next
				Event ue_checkout_echosign()
			case 'docusign'  // (Appeon)Harry 07.11.2016 - for docusign
				//Check: once checkout can only selected less than 7 row
				if i > 6 then //Added By Jay Chen 10-11-2013
					Messagebox('Check Out','You can at most select six documents for signature with Docusign Signature mode.')
					Return
				end if
				//Added By Jay Chen 09-04-2014
				is_mode = gnv_user_option.of_get_option_value(gs_user_id, "docusign_license_mode" )
				if isnull(is_mode) or is_mode = '' then is_mode = "global_license"
				if is_mode = "global_license" then
					is_license_user_id = "global_license_user"
				else
					is_license_user_id = gs_user_id
				end if
				//end add
				Event ue_checkout_docusign()
		end choose
		Return
	Case '6'
		
		Event ue_checkout_approval()
		Return
//		ls_action_name = 'Check Out & Web Review/Approve' //Added by Ken.Guo on 2009-03-26
//
//		lstr_dm_email.action_type = 'CheckOut'
//		lstr_dm_email.ctx_id = lstr_add_doc.ctx_id
//		lstr_dm_email.is_weblink = '1'
//		ls_checkout_status = '7'  //7: checked out; 8: all client users submited.
//		
//		If UpperBound(lstr_dm_email.doc_id_list[]) > 1 Then
//			Messagebox('Check Out','You must select only one document to check out with web link.')
//			Return
//		End If
//
//		openwithparm(w_dm_approve, lstr_dm_email)
//		IF Message.Doubleparm <> 1 THEN 	
//			//Delete waste data.
//			//Delete from ctx_am_image_weblink where doc_id = :lstr_dm_email.doc_id and revision = :lstr_dm_email.revision; 
//			RETURN			
//		End If
//	
END CHOOSE

//Modified By Ken.Guo 2011-06-29.Trigger off audit trail
DateTime ldt_server
n_ds lds_checkout_stauts
lds_checkout_stauts = Create n_ds
lds_checkout_stauts.DataObject = 'd_am_checkout_status_update'
lds_checkout_stauts.SetTransObject(SQLCA)
ll_cnt = lds_checkout_stauts.Retrieve(lstr_dm_email.doc_id_list)
If ll_cnt <= 0 Then 
	Messagebox('Check Out','Failed to get the document list to set the check out status.')
	Return 
End If
ldt_server = f_get_server_dtm()
For i = 1 To ll_cnt
	lds_checkout_stauts.SetItem(i, 'checkout_by', gs_user_id)
	lds_checkout_stauts.SetItem(i, 'checkout_date', ldt_server)
	lds_checkout_stauts.SetItem(i, 'checkout_status',ls_checkout_status )
Next

If lds_checkout_stauts.update() = 1 Then
	For i = 1 To UpperBound(lstr_add_audit)
		lstr_add_audit[i].action = ls_action_name 
		lstr_add_audit[i].notes = ls_notes	
	Next
	inv_dm_utils.of_add_audit_trail( lstr_add_audit[] )
ELSE
	MESSAGEBOX("Check Out", 'Failed to set the document~'s check out status.' + sqlca.sqlerrtext)
	SetPointer(Arrow!)	
	If isvalid(lds_checkout_stauts) Then Destroy lds_checkout_stauts
	RETURN
END IF

//Refresh the browse window	
This.Event ue_retrieve( )
This.of_locate_doc(lstr_add_audit[1].doc_id)

SetPointer(Arrow!)  //for refresh problem on new image ocx - Alfee 05.19.2008

If isvalid(lds_checkout_stauts) Then Destroy lds_checkout_stauts
RETURN
end event

event ue_output_email();//Added by Alfee on 03.28.2008
Integer li_rtn
str_ctx_email lstr_ctx_email
string ls_flag

//Check if the document modified
IF NOT of_issaved() THEN
	//	li_rtn = MessageBox("Save Document","The document has been modified, save it first?",Question!,YesNoCancel!) 
	//	IF li_rtn = 1 THEN 
	//		This.Event ue_save(FALSE)
	//	ELSEIF li_rtn = 3 THEN
	//		RETURN
	//	END IF
	//Modified By Ken.Guo 2009-11-05
	MessageBox("Save Document","The document has been modified, please save it first.") 
	Return
END IF		

//Display Message - jervis 07.16.2009
ls_flag = ProfileString(gs_IniFilePathName, "setup", "dispaly-message", "0")
if ls_flag = "0" then
	OpenWithParm(w_custom_help,ls_flag)
	if Upper(Message.StringParm) = "CANCEL" then return
end if
		
//Set document info.
//lstr_ctx_email.ctx_id = inv_contract_details.of_get_ctx_id( )
if iw_parent.classname() = 'w_contract' Then
	lstr_ctx_email.doc_from = 'DM'
	lstr_ctx_email.ctx_id = inv_contract_details.of_get_ctx_id()
	//lstr_ctx_email.ctx_id_list[1] = lstr_ctx_email.ctx_id 
Elseif iw_parent.classname() = 'w_documents_browse' Then
	lstr_ctx_email.doc_from = 'DM_BROWSE'
	lstr_ctx_email.ctx_id = tab_1.tabpage_browse.dw_browse.getitemnumber(tab_1.tabpage_browse.dw_browse.getrow(),'ctx_id')
End If

//lstr_ctx_email.doc_id = this.il_doc_id		
//lstr_ctx_email.revision = this.idc_revision	
//lstr_ctx_email.doc_ext = this.is_doc_ext
//If tab_1.tabpage_browse.dw_browse.getrow() > 0 Then
//	lstr_ctx_email.filename = tab_1.tabpage_browse.dw_browse.object.doc_name[tab_1.tabpage_browse.dw_browse.getrow()]					
//End If

Long ll_find_row
Datawindow ldw_browse

ldw_browse = tab_1.tabpage_browse.dw_browse

If tab_1.selectedtab = 1 Then //Browse Tab
	ll_find_row = ldw_browse.GetSelectedRow(0)
	Do While ll_find_row > 0
		If lstr_ctx_email.doc_from = 'DM' Then
			lstr_ctx_email.ctx_id_list[1] = inv_contract_details.of_get_ctx_id()
		ElseIf  lstr_ctx_email.doc_from = 'DM_BROWSE' Then
			lstr_ctx_email.ctx_id_list[UpperBound(lstr_ctx_email.ctx_id_list)+1] = ldw_browse.getitemnumber(ll_find_row,'ctx_id')	
		End If
		lstr_ctx_email.doc_id_list[UpperBound(lstr_ctx_email.doc_id_list)+1] = ldw_browse.getitemnumber(ll_find_row,'doc_id')
		lstr_ctx_email.revision_list[UpperBound(lstr_ctx_email.revision_list)+1] = ldw_browse.getitemdecimal(ll_find_row,'revision')
		ll_find_row = ldw_browse.GetSelectedRow(ll_find_row)
	Loop
Else //PreView Tab. Email only Single Document
	If lstr_ctx_email.doc_from = 'DM' Then
		lstr_ctx_email.ctx_id_list[1] = inv_contract_details.of_get_ctx_id()
	ElseIf  lstr_ctx_email.doc_from = 'DM_BROWSE' Then
		lstr_ctx_email.ctx_id_list[1] = ldw_browse.getitemnumber(ldw_browse.GetRow(),'ctx_id')	
	End If
	lstr_ctx_email.doc_id_list[1] = ldw_browse.getitemnumber(ldw_browse.GetRow(),'doc_id')
	lstr_ctx_email.revision_list[1] = ldw_browse.getitemdecimal(ldw_browse.GetRow(),'revision')
End If

//Open email window 
w_mdi.SetRedraw(False)
SetPointer(HourGlass!)
OpenWithParm(w_dm_email_document_send, lstr_ctx_email)
w_mdi.SetRedraw(True)
end event

event ue_output_saveas();//Added by Alfee 03.28.2008
Integer li_rtn
str_add_doc lstr_add_doc
str_add_audit lstr_add_audit

//Check if the document modified
IF NOT of_issaved() THEN
	MessageBox("Save Document","The document has been modified, please save it first.") 
	Return
END IF		

//Added By Ken.Guo 05/10/2013. if user select multi row, then saveas each documents.
w_appeon_gifofwait lw_appeon_gifofwait
Long ll_find_row1,ll_find_row2, ll_count = 0,ll_RtnVal,i, ll_doc_id, ls_err_cnt
String ls_CurDir, ls_company_name, ls_doc_ext,ls_doc_name, ls_fileame
Decimal ldec_revision
u_dw_contract ldw_browse
ldw_browse = tab_1.tabpage_browse.dw_browse
ll_find_row1 = ldw_browse.GetSelectedRow(0)
Do While ll_find_row1 > 0 
	ll_count++
	ll_find_row1 = ldw_browse.GetSelectedRow(ll_find_row1)
Loop
If ll_count > 1 Then
	ls_CurDir = GetCurrentDirectory()
	ll_RtnVal = GetFolder("Export the selected documents to the folder",ls_CurDir)
	if ll_RtnVal <> 1 then Return
	if Right(ls_CurDir,1) <> '\' then ls_CurDir += '\'
	If not isvalid(lw_appeon_gifofwait) Then Open(lw_appeon_gifofwait)
	Timer(0,lw_appeon_gifofwait)
	lw_appeon_gifofwait.of_setmaxposition(100)
	ll_find_row1 = ldw_browse.GetSelectedRow(0)
	Do While ll_find_row1 > 0 
		i++
		Yield()
		lw_appeon_gifofwait.of_settext('Downloading the documents '+String(i) + '/' + String(ll_count)+'...')	
		lw_appeon_gifofwait.of_setposition( Long(i/ll_count*100))
		
		ls_company_name = ''
		ll_doc_id = ldw_browse.GetItemNumber(ll_find_row1, 'doc_id')
		ldec_revision = ldw_browse.GetItemDecimal(ll_find_row1, 'revision')
		ls_doc_name =ldw_browse.GetItemString(ll_find_row1, 'doc_name')
		ls_doc_ext =ldw_browse.GetItemString(ll_find_row1, 'doc_ext')
		ls_company_name = ''
		If ldw_browse.describe( 'facility_name.type') = 'column' Then
			ls_company_name =  ldw_browse.GetItemString(ll_find_row1, 'facility_name')
			If isnull(ls_company_name) Then ls_company_name = ''
		End If
		If ls_company_name <> '' Then
			ls_fileame = ls_CurDir + ls_company_name + '_' + ls_doc_name +'_'+ String(ll_doc_id) + '_' + String(ldec_revision) +'.'+ String(ls_doc_ext)
		Else
			ls_fileame = ls_CurDir + ls_doc_name +'_'+ String(ll_doc_id) + '_' + String(ldec_revision) +'.'+ String(ls_doc_ext)
		End If
		If inv_dm_utils.of_download_file(ll_doc_id, ldec_revision, ls_fileame) < 0 Then
			gnv_debug.of_output( True, 'Failed to download the document.' + 'doc_id = ' + String(ll_doc_id) + ', revision = ' + String(ldec_revision) )
			ls_err_cnt++
		End If
		ll_find_row1 = ldw_browse.GetSelectedRow(ll_find_row1)
	Loop	
	If isvalid(lw_appeon_gifofwait) Then Close(lw_appeon_gifofwait)
	If ls_err_cnt > 0 Then
		Messagebox('Error','Failed to export some of the documents. Please open the debug log to check the information in detail.',Exclamation!)
	Else
		If Messagebox('Save As','Documents have been exported successfully. Do you want to open the folder containing the documents?', question!, yesno!) = 1 Then
			Run("Explorer.exe " + ls_CurDir)
		End If
	End If
	Return 
End If

//Save as single Document.
lstr_add_doc.doc_id = il_doc_id
lstr_add_doc.revision = idc_revision
lstr_add_doc.doc_ext = is_doc_ext
//lstr_add_doc.ctx_id = inv_contract_details.of_get_ctx_id( )
if iw_parent.classname() = 'w_contract' Then
	lstr_add_doc.ctx_id = inv_contract_details.of_get_ctx_id()
Else
	lstr_add_doc.ctx_id = tab_1.tabpage_browse.dw_browse.getitemnumber(tab_1.tabpage_browse.dw_browse.getrow(),'ctx_id')
End If

If tab_1.tabpage_browse.dw_browse.getrow() > 0 Then
	//Added file name. Ken.Guo 2009-04-14
	lstr_add_doc.filename = tab_1.tabpage_browse.dw_browse.object.doc_name[tab_1.tabpage_browse.dw_browse.getrow()]					
End If

openwithparm(w_dm_saveto_document, lstr_add_doc)

IF Message.Doubleparm = 1 THEN
	///////////////////////////////////////////////////////////////////////
	//// Trigger off audit trail
	///////////////////////////////////////////////////////////////////////
	lstr_add_audit.doc_id = il_doc_id
	lstr_add_audit.revision = idc_revision
	lstr_add_audit.doc_ext = is_doc_ext
	lstr_add_audit.action = "OutPut - File"
	inv_dm_utils.of_add_audit_trail( lstr_add_audit )
	
	//added by gavins 20120229
	of_insertdetail(  tab_1.tabpage_browse.dw_browse, tab_1.tabpage_browse.dw_detail  )
END IF

SetPointer(Arrow!) //for refresh problem on new image ocx - Alfee 05.19.2008
end event

event type integer ue_approve_reject(string as_action, string as_criteria);//////////////////////////////////////////////////////////////////////
// $<event>u_tabpg_dm_data.ue_approve_reject()
// $<arguments> String as_aciton, as_criteria
// $<returns> integer
// $<description>Approve/Reject changes according to the specifed criteria
//////////////////////////////////////////////////////////////////////
// $<add> 07.17.2008 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////
Long ll_bmcount
String ls_msg
Boolean lb_bookmarkchanged = FALSE //Always False for accept
Integer 	li_return

//Prompt the user bofore it done.
ls_msg = 'Are you sure you want to '
CHOOSE CASE Lower(as_action)
	CASE 'accept'
		ls_msg += 'Accept '
	CASE 'reject'
		ls_msg += 'Reject '				
END CHOOSE
CHOOSE CASE lower(as_criteria)
	CASE 'all format'
		ls_msg += 'All Format changes?'
	CASE 'current page'
		ls_msg += 'All changes on current page?'
	CASE 'all changes'
		ls_msg += 'All changes on document?'
END CHOOSE

IF MessageBox("IntelliSoftGroup",ls_msg, Question!, YesNo!, 2 ) <> 1 THEN  //(Appeon)Harry 01.28.2014 - V142 ISG-CLX  Modify "ContractLogix" to "IntelliSoftGroup"
	RETURN 0
END IF

//Begin - Added By Mark Lee 05/29/2013 adjust the document protect property.
li_return = inv_ole_utils_doc.of_unprotect_doc()			
IF li_return < 0 then 
	RETURN 0
End If 
//End - Added By Mark Lee 05/29/2013

SetPointer(HourGlass!)
SetRedraw(FALSE)

//Keep bookmarks' count before reject operation
IF lower(as_action) = 'reject' THEN 
	ll_bmcount = inv_ole_utils_doc.of_getbookmarkscount()
END IF

//Accept or Reject changes according to the spec
inv_ole_utils_doc.of_accept_reject(as_action, as_criteria)

//Determine if the bookmarks changed after reject operation
IF lower(as_action) = 'reject' AND ll_bmcount <> inv_ole_utils_doc.of_getbookmarkscount() THEN 
	lb_bookmarkchanged = TRUE
END IF

//Refresh clause map & change list
of_refreshmap(lb_bookmarkchanged, -1)

SetRedraw(TRUE)

RETURN 1
end event

event ue_set_screen_properties();string ls_Modify
u_dw_contract ldw_filter
u_dw_contract ldw_browse

// Set Search Criteria screen properties
ldw_filter = tab_1.tabpage_browse.dw_filter
ldw_filter.of_set_properties(ldw_filter.il_ViewID, ldw_filter.il_ScreenID, "Y")

If ii_ResizeWay = 1 Then
	u_dw_contract ldw_screen //add by gavins 20120201

	// Set screen properties
	ldw_screen = tab_1.tabpage_browse.dw_browse
	ldw_screen.of_set_properties(ldw_screen.il_ViewID, ldw_screen.il_ScreenID, "Y")
	//ldw_screen.Title = "Document Browse" //Commented By Ken.Guo 04/19/2012
	ldw_screen.is_title_bar_text = ldw_screen.Title
	
	ldw_screen = tab_1.tabpage_browse.dw_detail
	ldw_screen.of_set_properties(ldw_screen.il_ViewID, ldw_screen.il_ScreenID, "Y")

Else
	// Set Document Browse screen properties with Search Criteria properties
	ldw_browse = tab_1.tabpage_browse.dw_browse
	ldw_browse.of_set_properties(ldw_filter.il_ViewID, ldw_filter.il_ScreenID, "Y")
	//Commented By Ken.Guo 05/18/2012. the color should depend on screen design.
	//	ls_Modify = "datawindow.color=" + ldw_filter.Describe("datawindow.color")
	//	ldw_browse.Modify(ls_Modify)
	ldw_browse.Title = "Document Browse"
	ldw_browse.is_title_bar_text = ldw_browse.Title
End If

end event

event type integer ue_compare();//Compare documents - Alfee 07.23.2008

IF Not IsValid(inv_dm_comparison) THEN RETURN -1

//inv_dm_comparison.of_start_compare_clauses( gw_contract, tab_1.tabpage_browse.dw_browse, 'dm')
//inv_dm_comparison.of_start_compare_clauses( iw_parent, tab_1.tabpage_browse.dw_browse, 'dm')//modify by gavins 20120205
inv_dm_comparison.of_start_compare_clauses( iw_parent, tab_1.tabpage_browse.dw_detail, 'dm')

RETURN 1
end event

event ue_show_constructor();//////////////////////////////////////////////////////////////////////
// $<event>  ue_show_constructor()
// $<arguments> (None)
// $<returns>   (None)
// $<description> Refresh right
//////////////////////////////////////////////////////////////////////
// $<add> 11/07/2008 by Scofield
//////////////////////////////////////////////////////////////////////

if Not w_mdi.of_security_access(6929) > 0 then
	ib_allow_approve_reject = false
else
	ib_allow_approve_reject = true
end if

st_docinfo.backcolor = tab_1.backcolor //Added By Ken.Guo 2011-02-14.

Post of_sethistorytoolbar( 4 )//add by gavins 20120203

Post of_Set_SplitBar_Location( )
end event

event ue_insert_reqmnt();long ll_export_id,ll_row
string ls_merge_field
long ll_ctx_id

//ll_ctx_id = inv_contract_details.of_get_ctx_id()
if iw_parent.classname() = 'w_contract' Then
	ll_ctx_id = inv_contract_details.of_get_ctx_id()
Else
	ll_ctx_id = tab_1.tabpage_browse.dw_browse.getitemnumber(tab_1.tabpage_browse.dw_browse.getrow(),'ctx_id')
End If

//If tab_1.tabpage_2.ole_1.object.DocType <> 1 Then return //no word document opened

str_ole_ctxid lstr_ole_ctxid
lstr_ole_ctxid.sole_word = tab_1.tabpage_preview.ole_doc
lstr_ole_ctxid.sl_ctx_id = ll_ctx_id
Openwithparm(w_agreement_template_insert_requirement,lstr_ole_ctxid)

end event

event ue_merge_requirement();//////////////////////////////////////////////////////////////////////
// $<event>ue_merge_requirementu_tabpg_dm_data()
// $<arguments>(None)
// $<returns> 
// $<description>
// $<description> Merge Requirement Fields
//////////////////////////////////////////////////////////////////////
// $<add> 2009-06-29 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Long  ll_ctx_id
Integer li_ret

oleobject ole_word
n_cst_word_utility lnv_word
string ls_filename_tmp,ls_error

lnv_word = Create n_cst_word_utility

//ll_ctx_id = inv_contract_details.of_get_ctx_id()
if iw_parent.classname() = 'w_contract' Then
	ll_ctx_id = inv_contract_details.of_get_ctx_id()
Else
	ll_ctx_id = tab_1.tabpage_browse.dw_browse.getitemnumber(tab_1.tabpage_browse.dw_browse.getrow(),'ctx_id')
End If


ole_word = tab_1.tabpage_preview.ole_doc.object

li_ret = lnv_word.of_refresh_reqmnt_fields(ole_word,ll_ctx_id,ls_error)

If ls_error <> '' Then
	Messagebox('Error','Failed to merge the requirement fields, please call support.')
	If isvalid(lnv_word) Then Destroy lnv_word	
	Return 
End If

//If no reqmnt fields.
If li_ret = 0 Then Return 

ls_filename_tmp = inv_dm_utils.of_generate_tempname_writable( il_doc_id, idc_revision, "doc")

ole_word.savetolocal(ls_filename_tmp, True)
ole_word.savetolocal(is_opened_file, True)

If inv_dm_utils.of_upload_file( il_doc_id, idc_revision, is_opened_file) > 0 Then
	lnv_word.of_update_reqmnt_field(tab_1.tabpage_preview.ole_doc.object , il_doc_id, 'D') 
End If

If isvalid(lnv_word) Then Destroy lnv_word

Return 
end event

event ue_ocr();String ls_doc_ext
Long ll_row
String ls_path_file
String ls_ocr_text
str_add_doc lstr_doc_info
n_cst_pdf2text lnv_cst_pdf2text

ll_row = tab_1.tabpage_browse.dw_browse.GetRow()
If ll_row = 0 Then Return

If tab_1.tabpage_preview.uo_2.of_ismodified() Then
	MessageBox("Save Document","The document has been modified, please save it first.") 
	Return 
End If

ls_doc_ext = Upper(tab_1.tabpage_browse.dw_browse.GetItemString(ll_row,'doc_ext'))

//Only for Image document
If ls_doc_ext <> 'PDF' and ls_doc_ext <>  'BMP' and ls_doc_ext <> 'TIF' &
	and ls_doc_ext <> 'TIFF' and ls_doc_ext <> 'JPG' and ls_doc_ext <>  'GIF' Then
	Messagebox('OCR','Current document type can not be OCR.')
	Return 
End If

//Only for current document. not for a history document
IF tab_1.tabpage_browse.dw_browse.getitemnumber(tab_1.tabpage_browse.dw_browse.getrow(),'level') = 2 THEN
	MessageBox("OCR","Can't OCR a history revision.")
	RETURN
END IF		

lstr_doc_info.filename = tab_1.tabpage_browse.dw_browse.GetItemString(ll_row,'doc_name_full')
lstr_doc_info.doc_id = tab_1.tabpage_browse.dw_browse.GetItemNumber(ll_row,'doc_id')
lstr_doc_info.revision = tab_1.tabpage_browse.dw_browse.GetItemDecimal(ll_row,'revision')

//Download file
ls_path_file = inv_dm_utils.of_download_file(lstr_doc_info.doc_id,lstr_doc_info.revision)
If Not FileExists(ls_path_file) Then
	Messagebox('OCR','Failed to download the document.')
	Return
End If

//Only For searchable PDF file.
If Upper(ls_doc_ext) = 'PDF' Then
	lnv_cst_pdf2text.of_pdf2text(ls_path_file, ls_ocr_text)
End If

//OCR with Image CP OCR plugin
If ls_ocr_text = '' Then
	ls_ocr_text = inv_ocr.of_ocr(ls_path_file)
End If

If ls_ocr_text = '' Then 
	Messagebox('OCR','Failed to OCR the document or the OCR result is empty.')
	Return
End If
		
//Update OCR result to database

UPDATE ctx_am_doc_image
SET pdftext = :ls_ocr_text
WHERE doc_id = :lstr_doc_info.doc_id AND revision = :lstr_doc_info.revision;
If SQLCA.sqlcode = 0 Then
	Commit;
	//Messagebox('OCR','The OCR is completed.')
	tab_1.tabpage_preview.uo_2.of_set_ocr_result(ls_ocr_text)
	Event ue_ocr_view()
	Return		
Else
	Rollback;
	Messagebox('OCR','Failed to upload the OCR result to database. ' + sqlca.sqlerrtext )			
End If

Return

end event

event ue_ocr_settings();String ls_parm

If tab_1.tabpage_browse.dw_browse.GetRow() > 0 Then
	If Upper(tab_1.tabpage_browse.dw_browse.GetItemString(tab_1.tabpage_browse.dw_browse.Getrow(),'doc_ext')) <> 'PDF' Then
		ls_parm = 'NO PDF'
	End If
End If

OpenwithParm(w_ocr_settings,ls_parm)
Return

end event

event ue_ocr_view();String ls_doc_ext
Long ll_row
str_add_doc lstr_doc_info

ll_row = tab_1.tabpage_browse.dw_browse.GetRow()
If ll_row = 0 Then Return

ls_doc_ext = tab_1.tabpage_browse.dw_browse.GetItemString(ll_row,'doc_ext')

IF tab_1.tabpage_browse.dw_browse.getitemnumber(tab_1.tabpage_browse.dw_browse.getrow(),'level') = 2 THEN
	MessageBox("OCR","Can't view the OCR result of the history revision.")
	RETURN
END IF		

lstr_doc_info.filename = tab_1.tabpage_browse.dw_browse.GetItemString(ll_row,'doc_name_full')
lstr_doc_info.doc_id = tab_1.tabpage_browse.dw_browse.GetItemNumber(ll_row,'doc_id')
lstr_doc_info.revision = tab_1.tabpage_browse.dw_browse.GetItemDecimal(ll_row,'revision')

Choose Case Upper(ls_doc_ext)
	Case 'PDF','BMP','TIF','TIFF','JPG','GIF'
		OpenwithParm(w_view_ocr_result,lstr_doc_info)
End Choose

Return 
end event

event ue_opennewindow();String ls_doc_ext
Long ll_row

w_document_view lw_1
Str_add_doc lstr_doc_info

Datawindow ldw_browse

ldw_browse = Tab_1.tabpage_browse.dw_browse
ll_row = ldw_browse.GetRow()
If ll_row <= 0 Then Return

ls_doc_ext = Lower(ldw_browse.getitemstring(ll_row,'doc_ext'))
CHOOSE CASE Lower(ls_doc_ext)
	CASE 'bmp','tif','tiff','jpg','gif', 'doc','xls','xlsx','pdf'
		//lstr_doc_info.ctx_id = inv_contract_details.of_get_ctx_id( )
		if iw_parent.classname() = 'w_contract' Then
			lstr_doc_info.ctx_id = inv_contract_details.of_get_ctx_id()
		Else
			lstr_doc_info.ctx_id = tab_1.tabpage_browse.dw_browse.getitemnumber(tab_1.tabpage_browse.dw_browse.getrow(),'ctx_id')
		End If

		lstr_doc_info.doc_id = ldw_browse.GetItemNumber(ll_row,"doc_id")
		lstr_doc_info.revision = ldw_browse.GetItemDecimal(ll_row,'revision')
		lstr_doc_info.filename = ldw_browse.GetItemString(ll_row,'doc_name_full')
		lstr_doc_info.doc_ext = ls_doc_ext
		OpenWithParm(lw_1, lstr_doc_info )
		//OpenSheetWithParm(lw_1, lstr_doc_info,w_mdi,2, Original! )
End Choose

end event

event ue_import_email();Long ll_row
n_cst_easymail_pop3 inv_em_pop3
str_import_msg lstr_import_msg

//lstr_import_msg.al_ctx_id = inv_contract_details.of_get_ctx_id( )
if iw_parent.classname() = 'w_contract' Then
	lstr_import_msg.al_ctx_id = inv_contract_details.of_get_ctx_id()
Else
	lstr_import_msg.al_ctx_id = tab_1.tabpage_browse.dw_browse.getitemnumber(tab_1.tabpage_browse.dw_browse.getrow(),'ctx_id')
End If


ll_row = tab_1.tabpage_browse.dw_browse.GetRow()
If ll_row > 0 Then
	lstr_import_msg.al_doc_id = tab_1.tabpage_browse.dw_browse.GetItemNumber(ll_row,'doc_id')
End If

inv_em_pop3.of_import_msg(lstr_import_msg )
Return 
end event

event ue_set_secutiry2();//Added By Ken.Guo 2010-10-26. if select multi rows, then only show add/email/delete icon.
Long ll_find_row1,ll_find_row2, ll_right

ll_find_row1 = tab_1.tabpage_browse.dw_browse.GetSelectedRow(0)
If ll_find_row1 > 0 Then
	ll_find_row2 = tab_1.tabpage_browse.dw_browse.GetSelectedRow(ll_find_row1)
	If ll_find_row2 > 0 Then
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_addclause,'enabled', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge,'enabled', False)	
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergedata,'enabled', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergefield,'enabled', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_insertreqmnt,'toolbaritemvisible', False)		
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkin,'enabled', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_undocheckout,'enabled', False)  //Add undo check out -- jervis 10.27.2010
		//m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkout.enabled = False
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0,'enabled', False)	
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_revision0,'enabled', False) 
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_save0,'enabled', False)	
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_select,'enabled', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_report,'enabled', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_properties0,'enabled', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_compare0,'enabled', False) 
	//	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0,'enabled', False)				
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_print0,'enabled', False)
	//	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_saveas,'enabled', False)		
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkin,'enabled', False)
		//m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkout.enabled = False
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_revision0,'enabled', False)		
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_workflow0,'enabled', false)
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_combine,'enabled', false)
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_sertify,'enabled', false)
		If iw_parent.classname() <> 'w_contract' Then //Added By Ken.Guo 2011-06-28. 
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkout,'enabled', False)
		End If
	End If
End If

If iw_parent.classname() = 'w_contract' Then of_sethistorytoolbar( 1 )//add by gavins 20120203

//Added By Ken.Guo 2009-06-04.
m_pfe_cst_mdi_menu_contract_am.of_refresh_option()


end event

event ue_undo_checkout();//Add undo check out feature - jervis 10.27.2010

Long ll_docid
str_add_audit lstr_add_audit
str_sertifi_doc lstr_sertifi_doc // (Appeon)Harry 07.11.2016 - for docusign
string ls_es_docid,ls_esign_type,ls_es_fileid,ls_license_user_id  // (Appeon)Harry 07.11.2016 - for docusign
SetPointer(HourGlass!)
//if tab_1.tabpage_browse.dw_browse.object.checkout_status[tab_1.tabpage_browse.dw_browse.getrow()] = '1' then
if tab_1.tabpage_browse.dw_browse.object.checkout_status[tab_1.tabpage_browse.dw_browse.getrow()] <> '0' then	//1-Check out ,2- check out weblink --jervis 11.24.2010
	If Messagebox('IntelliSoftGroup','Do you want to undo check out for the document?', Question!, yesno!) = 2 Then Return  //(Appeon)Harry 01.28.2014 - V142 ISG-CLX  Modify "ContractLogix" to "IntelliSoftGroup"
	Select es_docid,esign_type,es_fileid,es_license_user_id into :ls_es_docid,:ls_esign_type,:ls_es_fileid,:ls_license_user_id From Ctx_am_document Where doc_id = :il_doc_id;  // (Appeon)Harry 07.11.2016 - for docusign
	Update Ctx_am_document Set checkout_status = '0',checkout_by = '', checkout_date = null, 
			 es_apicode = '', es_fileid = '',es_docid = '',es_sender ='',es_sender_email = '',esign_type = '',es_license_user_id = '' //Modified By Jay Chen 10-22-2013				
	Where doc_id = :il_doc_id;
	
	if sqlca.sqlcode = 0 then
		//(Appeon)Added By Harry 07-11-2016  Remove request from docusign server
		if ls_esign_type = 'docusign' then
			lstr_sertifi_doc.as_es_apicode = gnv_docusign.is_apicode
			lstr_sertifi_doc.as_es_docid = ls_es_docid
			lstr_sertifi_doc.as_es_fileid = ls_es_fileid
//			if gnv_docusign.of_removesignaturerequest(lstr_sertifi_doc) = 1 then
			if gnv_docusign.of_removesignaturerequest(lstr_sertifi_doc,ls_license_user_id) = 1 then //Modified By Jay Chen 09-05-2014
				if IsNumber(ls_es_docid) then
					Update Ctx_am_document Set es_fileid = '',es_docid = '' Where es_fileid = :ls_es_fileid and esign_type = 'docusign' ;
				else
					Update Ctx_am_document Set es_fileid = '',es_docid = '' Where es_docid = :ls_es_docid and esign_type = 'docusign' ;
				end if
			end if
		end if
		//end add
		
		lstr_add_audit.doc_id = this.il_doc_id
		lstr_add_audit.revision = this.idc_revision
		lstr_add_audit.doc_ext = this.is_doc_ext

		lstr_add_audit.action = 'Undo Check Out'  
		lstr_add_audit.notes = 'Undo Check Out'	
		inv_dm_utils.of_add_audit_trail( lstr_add_audit )
		
		//added by gavins 20120229
		of_insertdetail(  tab_1.tabpage_browse.dw_browse, tab_1.tabpage_browse.dw_detail  )
	end if
	ll_docid = il_doc_id
	This.Event ue_retrieve( )
	of_locate_doc(ll_docid)
end if
SetPointer(Arrow!)




end event

event ue_open_with_default_program();//////////////////////////////////////////////////////////////////////
// Event: ue_open_with_default_program()
// Arguments:
//--------------------------------------------------------------------
// Return:  (None)
//--------------------------------------------------------------------
// Author:	Ken.Guo		Date: 2011-04-13
//--------------------------------------------------------------------
// Description: Open a file with default program
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////
String ls_doc_ext,ls_null,ls_doc_nme
Long ll_row,ll_doc_id
Decimal ldc_revision
String ls_filetempname
Integer i,li_pos1,li_pos2
setnull(ls_null)

w_document_view lw_1
Str_add_doc lstr_doc_info

Datawindow ldw_browse

//Show tips if need
If gb_openwith_showtips Then
	Open(w_openwith_tips)
End If

//Download orginal file
ldw_browse = Tab_1.tabpage_browse.dw_browse
ll_row = ldw_browse.GetRow()
If ll_row <= 0 Then Return
ls_doc_ext = Lower(ldw_browse.getitemstring(ll_row,'doc_ext'))
ll_doc_id= ldw_browse.GetItemNumber(ll_row,"doc_id")
ldc_revision = ldw_browse.GetItemDecimal(ll_row,'revision')
ls_doc_nme = inv_dm_utils.of_download_file( ll_doc_id, ldc_revision)

//Copy to temp file
Do while i <= 20
	li_pos1 = lastpos(ls_doc_nme,'\')
	li_pos2 = lastpos(ls_doc_nme,'.')
	If li_pos1 > li_pos2 Then
		ls_filetempname = ls_doc_nme + '_temp' + String(i) //means no EXT name
	Else
		ls_filetempname = Mid(ls_doc_nme,1,li_pos2 - 1 ) + '_temp' + String(i) + Mid(ls_doc_nme,li_pos2)
	End If
	If FileCopy(ls_doc_nme,ls_filetempname,True) = 1 Then	Exit
	i++
Loop
If i > 20 Then
	Messagebox('Error','Failed to create the temp file '+ls_filetempname+', please call support.')
	Return
End If

//Open file with default program
IF FileExists(ls_filetempname) THEN
	if ShellExecuteA ( Handle( This ), ls_null, ls_filetempname , ls_Null, ls_Null, 4) <= 32 then
		run("rundll32.exe shell32.dll,OpenAs_RunDLL " + ls_filetempname)
	end if
End If


end event

event ue_checkout_sertify();//////////////////////////////////////////////////////////////////////
// Event: ue_checkout_sertify()
// Arguments:
//--------------------------------------------------------------------
// Return:  (none)
//--------------------------------------------------------------------
// Author:	 Ken.Guo 2011-06-13.
//--------------------------------------------------------------------
// Description: Check out with sertifi
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////
Long ll_find_row,j
Datawindow ldw_browse
str_ctx_email lstr_ctx_email,lstr_sertifi_sign,lstr_sertifi_ref
n_ds lds_sertifi_update, lds_action_items
str_sertifi_doc lstr_sertifi_doc 

IF NOT of_issaved() THEN
	MessageBox("Save Document","The document has been modified, please save it first.") 
	Return
END IF		

//Set CTX info.
if iw_parent.classname() = 'w_contract' Then
	lstr_ctx_email.doc_from = 'DM'
	lstr_ctx_email.ctx_id = inv_contract_details.of_get_ctx_id()
Elseif iw_parent.classname() = 'w_documents_browse' Then
	lstr_ctx_email.doc_from = 'DM_BROWSE'
	lstr_ctx_email.ctx_id = tab_1.tabpage_browse.dw_browse.getitemnumber(tab_1.tabpage_browse.dw_browse.getrow(),'ctx_id')
End If

//Get Document Info
String ls_fullname
ldw_browse = tab_1.tabpage_browse.dw_browse
If tab_1.selectedtab = 1 Then //Browse Tab

	//Check record, only level 1 can be checked out.
	ll_find_row = ldw_browse.GetSelectedRow(0)
	Do While ll_find_row > 0
		If ldw_browse.getitemnumber(ll_find_row,'level') <> 1 Then
			Messagebox('Check Out','The history revision can not be checked out.')
			ldw_browse.ScrolltoRow(ll_find_row)
			Return
		End If
		ll_find_row = ldw_browse.GetSelectedRow(ll_find_row)
	Loop 

	//Get Doc Info
	ll_find_row = ldw_browse.GetSelectedRow(0)
	Do While ll_find_row > 0
		If lstr_ctx_email.doc_from = 'DM' Then
			lstr_ctx_email.ctx_id_list[UpperBound(lstr_ctx_email.ctx_id_list)+1] = inv_contract_details.of_get_ctx_id()
		ElseIf  lstr_ctx_email.doc_from = 'DM_BROWSE' Then
			lstr_ctx_email.ctx_id_list[UpperBound(lstr_ctx_email.ctx_id_list)+1] = ldw_browse.getitemnumber(ll_find_row,'ctx_id')	
		End If
		lstr_ctx_email.doc_id_list[UpperBound(lstr_ctx_email.doc_id_list)+1] = ldw_browse.getitemnumber(ll_find_row,'doc_id')
		lstr_ctx_email.revision_list[UpperBound(lstr_ctx_email.revision_list)+1] = ldw_browse.getitemdecimal(ll_find_row,'revision')
		lstr_ctx_email.fullfilename_list[UpperBound(lstr_ctx_email.fullfilename_list)+1] =  gf_merge_file_name(ldw_browse.getitemstring(ll_find_row,'doc_name'),ldw_browse.getitemstring(ll_find_row,'doc_ext'),ldw_browse.getitemnumber(ll_find_row,'doc_id'),ldw_browse.getitemdecimal(ll_find_row,'revision'))
		ll_find_row = ldw_browse.GetSelectedRow(ll_find_row)
	Loop
Else //PreView Tab. only Single Document
	//Check record, only level 1 can be checked out.
	If ldw_browse.getitemnumber(ldw_browse.GetRow(),'level') <> 1 Then
		Messagebox('Check Out','The history revision can not be checked out.')
		Return
	End If
	
	If lstr_ctx_email.doc_from = 'DM' Then
		lstr_ctx_email.ctx_id_list[1] = inv_contract_details.of_get_ctx_id()
	ElseIf  lstr_ctx_email.doc_from = 'DM_BROWSE' Then
		lstr_ctx_email.ctx_id_list[1] = ldw_browse.getitemnumber(ldw_browse.GetRow(),'ctx_id')	
	End If
	lstr_ctx_email.doc_id_list[1] = ldw_browse.getitemnumber(ldw_browse.GetRow(),'doc_id')
	lstr_ctx_email.revision_list[1] = ldw_browse.getitemdecimal(ldw_browse.GetRow(),'revision')
	lstr_ctx_email.fullfilename_list[1] = gf_merge_file_name(ldw_browse.getitemstring(ldw_browse.GetRow(),'doc_name'),ldw_browse.getitemstring(ldw_browse.GetRow(),'doc_ext'),ldw_browse.getitemnumber(ldw_browse.GetRow(),'doc_id'),ldw_browse.getitemdecimal(ldw_browse.GetRow(),'revision'))
End If

//Create Sertifi Request
OpenWithParm(w_dm_sertifi_request,lstr_ctx_email)

PowerObject lpo_pass
If Not Isvalid(Message.Powerobjectparm) Then Return
lpo_pass = Message.Powerobjectparm
If lpo_pass.classname( ) <> 'str_ctx_email' Then Return



lstr_ctx_email = lpo_pass

lstr_sertifi_doc.as_es_apicode = gnv_sertifi.is_apicode
lstr_sertifi_doc.as_es_fileid = lstr_ctx_email.as_sertifi_fileid

SetPointer(HourGlass!)

//Set check out status.
lds_sertifi_update = Create n_ds
lds_sertifi_update.dataobject = 'd_am_checkout_sertifi_update'
lds_sertifi_update.SetTransObject(SQLCA)

lds_action_items = Create n_ds
lds_action_items.dataobject = 'd_am_action_items'
lds_action_items.SetTransObject(SQLCA)

gnv_appeondb.of_startqueue( )
	lds_sertifi_update.Retrieve(lstr_ctx_email.doc_id_list[])
	lds_action_items.Retrieve(lstr_ctx_email.doc_id_list[])
gnv_appeondb.of_commitqueue( )

Long i,ll_find,ll_row
Long ll_sign_doc_id[], ll_ref_doc_id[]
Datetime ldt_now
ldt_now = datetime(today() , Now())
For i = 1 To UpperBound(lstr_ctx_email.doc_id_list[])
	If Len(lstr_ctx_email.as_sertifi_docid[i]) > 0 Then
		ll_sign_doc_id[UpperBound(ll_sign_doc_id[]) + 1] = lstr_ctx_email.doc_id_list[i]
		ll_find = lds_sertifi_update.Find('doc_id = ' + String(lstr_ctx_email.doc_id_list[i]), 1, lds_sertifi_update.RowCount() )
		If ll_find > 0 Then
			lds_sertifi_update.SetItem(ll_find, 'checkout_status','5')
			lds_sertifi_update.SetItem(ll_find, 'checkout_date',today())
			lds_sertifi_update.SetItem(ll_find, 'checkout_by',gs_user_id)
			lds_sertifi_update.SetItem(ll_find, 'es_apicode', gnv_sertifi.is_apicode)
			lds_sertifi_update.SetItem(ll_find, 'es_fileid', lstr_ctx_email.as_sertifi_fileid )
			lds_sertifi_update.SetItem(ll_find, 'es_docid', lstr_ctx_email.as_sertifi_docid[i] )
			lds_sertifi_update.SetItem(ll_find, 'es_sender', lstr_ctx_email.as_sender )
			lds_sertifi_update.SetItem(ll_find, 'es_sender_email', lstr_ctx_email.as_mail_from )
			lds_sertifi_update.SetItem(ll_find, 'esign_type',gs_esigntype)
		Else
			gnv_sertifi.of_removesignaturerequest(lstr_sertifi_doc)
			Messagebox('Error','Failed to check out the document ' + lstr_ctx_email.fullfilename_list[i] + '.' )
			If isvalid(lds_sertifi_update) Then Destroy lds_sertifi_update
			Return
		End If
//		//Insert Action Item for E-signer
		For j = 1 To UpperBound(lstr_ctx_email.as_user_arr[] )
			ll_row = lds_action_items.InsertRow(0)
			lds_action_items.SetItem(ll_row,'doc_id',lstr_ctx_email.doc_id_list[i] )
			lds_action_items.SetItem(ll_row,'action_type',gnv_sertifi.il_esign )  
			lds_action_items.SetItem(ll_row,'due_date', lstr_ctx_email.adt_duedate )
			lds_action_items.SetItem(ll_row,'wf_assigned_by', gs_user_id)
			lds_action_items.SetItem(ll_row,'active_status',0)
			lds_action_items.SetItem(ll_row,'action_status',gnv_sertifi.il_incomplete )
			lds_action_items.SetItem(ll_row,'status_date',ldt_now)
			lds_action_items.SetItem(ll_row,'create_date',ldt_now)
			lds_action_items.SetItem(ll_row,'action_user',lstr_ctx_email.as_user_arr[j])
			lds_action_items.SetItem(ll_row,'attempt_times',1)
			lds_action_items.SetItem(ll_row,'first_attempt',ldt_now)
			lds_action_items.SetItem(ll_row,'last_attempt',ldt_now)
			lds_action_items.SetItem(ll_row,'print_flag',-1)
			lds_action_items.SetItem(ll_row,'notes','')
			lds_action_items.SetItem(ll_row,'es_docid',lstr_ctx_email.as_sertifi_docid[i])			
		Next

		//Insert Action Item for Sender
		If lstr_ctx_email.ai_create_ai = 1 Then
			ll_row = lds_action_items.InsertRow(0)
			lds_action_items.SetItem(ll_row,'doc_id',lstr_ctx_email.doc_id_list[i] )
			lds_action_items.SetItem(ll_row,'action_type',gnv_sertifi.il_doccheckin )  
			lds_action_items.SetItem(ll_row,'due_date', lstr_ctx_email.adt_duedate )
			lds_action_items.SetItem(ll_row,'wf_assigned_by', gs_user_id)
			lds_action_items.SetItem(ll_row,'active_status',0)
			lds_action_items.SetItem(ll_row,'action_status',gnv_sertifi.il_incomplete )
			lds_action_items.SetItem(ll_row,'status_date',ldt_now)
			lds_action_items.SetItem(ll_row,'create_date',ldt_now)
			lds_action_items.SetItem(ll_row,'action_user',gs_user_id)
			lds_action_items.SetItem(ll_row,'attempt_times',1)
			lds_action_items.SetItem(ll_row,'first_attempt',ldt_now)
			lds_action_items.SetItem(ll_row,'last_attempt',ldt_now)
			lds_action_items.SetItem(ll_row,'print_flag',-1)
			lds_action_items.SetItem(ll_row,'notes','')
			lds_action_items.SetItem(ll_row,'es_docid',lstr_ctx_email.as_sertifi_docid[i])
		End If
		lstr_sertifi_sign.as_sertifi_fileid = lstr_ctx_email.as_sertifi_fileid
		lstr_sertifi_sign.as_sertifi_docid[UpperBound(lstr_sertifi_sign.as_sertifi_docid[]) + 1] = lstr_ctx_email.as_sertifi_docid[i]		
	Else
		ll_ref_doc_id[UpperBound(ll_sign_doc_id[]) + 1] = lstr_ctx_email.doc_id_list[i]
		lstr_sertifi_ref.as_sertifi_fileid = lstr_sertifi_ref.as_sertifi_fileid
		lstr_sertifi_ref.as_sertifi_docid[UpperBound(lstr_sertifi_ref.as_sertifi_docid[]) + 1] = lstr_sertifi_ref.as_sertifi_docid[i]				
	End If
Next


If lds_sertifi_update.Update() <> 1 Then
	gnv_sertifi.of_removesignaturerequest(lstr_sertifi_doc)
	Messagebox('Error','Failed to check out the document ' + lstr_ctx_email.fullfilename_list[i] + '.' )
	If isvalid(lds_sertifi_update) Then Destroy lds_sertifi_update
	Return	
End If

If lds_action_items.Update() <> 1 Then
	Messagebox('Error','The document(s) have been checked out, but failed to create the Action Item.')
	//Return -1
End If

//Set Sender info
lstr_sertifi_sign.as_mail_from = lstr_ctx_email.as_mail_from
lstr_sertifi_sign.as_sender =  lstr_ctx_email.as_sender
lstr_sertifi_ref.as_mail_from = lstr_ctx_email.as_mail_from
lstr_sertifi_ref.as_sender =  lstr_ctx_email.as_sender

//Add Audit
inv_dm_utils.of_add_audit_trail( ll_sign_doc_id[], lstr_sertifi_sign,'Check Out & Sertifi E-Sign Request')
inv_dm_utils.of_add_audit_trail( ll_ref_doc_id[], lstr_sertifi_ref,'Sertifi Ref Document')

//Invite now  
gnv_sertifi.of_invitesigners( lStr_sertifi_doc, '')

If isvalid(lds_sertifi_update) Then Destroy lds_sertifi_update
If isvalid(lds_action_items) Then Destroy lds_action_items

SetPointer(HourGlass!)

//Refresh DM browse window	
This.Event ue_retrieve( )
If tab_1.selectedtab = 1 Then
	ldw_browse.SetRedraw( False)
	This.of_locate_doc(lstr_ctx_email.doc_id_list[])
	ldw_browse.SetRedraw( True)
Else
	This.of_locate_doc(lstr_ctx_email.doc_id_list[1])
End If


//Refresh Action Items
If iw_parent.classname() = 'w_contract' and lstr_ctx_email.ai_create_ai = 1 Then 
	gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_action.of_retrieve()
End If


Return 


end event

event ue_show_sertifi_status();Long ll_row

ll_row = This.tab_1.tabpage_browse.dw_browse.GetRow()
If ll_row = 0 Then Return
This.post of_show_sertifi_status( ll_row )


end event

event ue_show_approve_status();Post of_show_approve_status()

/*

str_ctx_email lstr_ctx_email

Long ll_row

ll_row = This.tab_1.tabpage_browse.dw_browse.GetRow()
If ll_row = 0 Then Return

If iw_parent.classname() = 'w_contract' Then
	lstr_ctx_email.doc_from = 'DM'
	lstr_ctx_email.ctx_id = inv_contract_details.of_get_ctx_id()
	If tab_1.tabpage_browse.dw_browse.object.level[tab_1.tabpage_browse.dw_browse.getrow()] = 1 Then //For Level 1
		lstr_ctx_email.revision = This.tab_1.tabpage_browse.dw_browse.GetItemDecimal(ll_row, 'revision')
	Else
		lstr_ctx_email.revision = This.tab_1.tabpage_browse.dw_browse.GetItemDecimal(ll_row, 'audit_version')
	End If	
Else
	lstr_ctx_email.doc_from = 'DM_BROWSE'
	lstr_ctx_email.ctx_id = tab_1.tabpage_browse.dw_browse.getitemnumber(tab_1.tabpage_browse.dw_browse.getrow(),'ctx_id')
	lstr_ctx_email.revision = This.tab_1.tabpage_browse.dw_browse.GetItemDecimal(ll_row, 'revision')
End If
lstr_ctx_email.doc_id = This.tab_1.tabpage_browse.dw_browse.GetItemNumber(ll_row, 'doc_id')

If m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkin.enabled and m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkin.toolbaritemvisible Then
	ib_havecheckinright = True
Else
	ib_havecheckinright = False
End If

lstr_ctx_email.ab_checkinright = ib_havecheckinright
lstr_ctx_email.al_approve_id = This.tab_1.tabpage_browse.dw_browse.GetItemNumber(ll_row, 'approve_id')

gnv_webapprove.of_show_approve_status( lstr_ctx_email, this)
/*
OpenWithParm(w_dm_approve_status, lstr_ctx_email)

//Refresh document data if check in document
If Message.doubleparm > 0 Then
	This.Event ue_retrieve( )
	This.of_locate_doc(lstr_ctx_email.doc_id)	
	//Refresh action items data
	If isvalid(gw_contract) Then
		If gw_contract.tab_contract_details.ib_select9 Then
			If gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_action.of_get_doc_id() = lstr_ctx_email.doc_id Then
				gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_action.of_retrieve() 
			End If
		End If
	End If
End If
*/
Return 
*/
end event

event ue_checkout_approval();//////////////////////////////////////////////////////////////////////
// Event: ue_checkout_sertify()
// Arguments:
//--------------------------------------------------------------------
// Return:  (none)
//--------------------------------------------------------------------
// Author:	 Ken.Guo 2011-06-13.
//--------------------------------------------------------------------
// Description: Check out with sertifi
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////
Long ll_find_row,ll_current_ctxid
Datawindow ldw_browse
str_ctx_email lstr_ctx_email
n_cst_string lnv_string
String ls_fullname


IF NOT of_issaved() THEN
	MessageBox("Save Document","The document has been modified, please save it first.") 
	Return
END IF		

//Set CTX info.
if iw_parent.classname() = 'w_contract' Then
	lstr_ctx_email.doc_from = 'DM'
	lstr_ctx_email.ctx_id = inv_contract_details.of_get_ctx_id()
Elseif iw_parent.classname() = 'w_documents_browse' Then
	lstr_ctx_email.doc_from = 'DM_BROWSE'
	lstr_ctx_email.ctx_id = tab_1.tabpage_browse.dw_browse.getitemnumber(tab_1.tabpage_browse.dw_browse.getrow(),'ctx_id')
End If

//Get Document Info
ldw_browse = tab_1.tabpage_browse.dw_browse
If tab_1.selectedtab = 1 Then //Browse Tab

	//Check record, only level 1 can be checked out.
	ll_find_row = ldw_browse.GetSelectedRow(0)
	Do While ll_find_row > 0
		If ldw_browse.getitemnumber(ll_find_row,'level') <> 1 Then
			Messagebox('Check Out','The history revision can not be checked out.')
			ldw_browse.ScrolltoRow(ll_find_row)
			Return
		End If
		ll_find_row = ldw_browse.GetSelectedRow(ll_find_row)
	Loop 
	
	//Get doc info
	ll_find_row = ldw_browse.GetSelectedRow(0)
	Do While ll_find_row > 0
		If lstr_ctx_email.doc_from = 'DM' Then
			lstr_ctx_email.ctx_id_list[UpperBound(lstr_ctx_email.ctx_id_list)+1] = inv_contract_details.of_get_ctx_id()
		ElseIf  lstr_ctx_email.doc_from = 'DM_BROWSE' Then
			lstr_ctx_email.ctx_id_list[UpperBound(lstr_ctx_email.ctx_id_list)+1] = ldw_browse.getitemnumber(ll_find_row,'ctx_id')	
		End If
		lstr_ctx_email.doc_id_list[UpperBound(lstr_ctx_email.doc_id_list)+1] = ldw_browse.getitemnumber(ll_find_row,'doc_id')
		lstr_ctx_email.revision_list[UpperBound(lstr_ctx_email.revision_list)+1] = ldw_browse.getitemdecimal(ll_find_row,'revision')
		lstr_ctx_email.doc_ext_list[UpperBound(lstr_ctx_email.doc_ext_list[]) + 1] = ldw_browse.getitemstring(ll_find_row,'doc_ext')
		ls_fullname = inv_dm_utils.of_merge_file_name( ldw_browse.getitemnumber(ll_find_row,'doc_id'),ldw_browse.getitemdecimal(ll_find_row,'revision') ,ldw_browse.getitemstring(ll_find_row,'doc_name') ,ldw_browse.getitemstring(ll_find_row,'doc_ext') ,2)
		lstr_ctx_email.fullfilename_list[UpperBound(lstr_ctx_email.fullfilename_list)+1] = ls_fullname
		
		ll_find_row = ldw_browse.GetSelectedRow(ll_find_row)
	Loop
Else //PreView Tab. only Single Document
	//Check record, only level 1 can be checked out.
	If ldw_browse.getitemnumber(ldw_browse.GetRow(),'level') <> 1 Then
		Messagebox('Check Out','The history revision can not be checked out.')
		Return
	End If
	
	If lstr_ctx_email.doc_from = 'DM' Then
		lstr_ctx_email.ctx_id_list[1] = inv_contract_details.of_get_ctx_id()
	ElseIf  lstr_ctx_email.doc_from = 'DM_BROWSE' Then
		lstr_ctx_email.ctx_id_list[1] = ldw_browse.getitemnumber(ldw_browse.GetRow(),'ctx_id')	
	End If
	lstr_ctx_email.doc_id_list[1] = ldw_browse.getitemnumber(ldw_browse.GetRow(),'doc_id')
	lstr_ctx_email.revision_list[1] = ldw_browse.getitemdecimal(ldw_browse.GetRow(),'revision')
	lstr_ctx_email.doc_ext_list[1] = ldw_browse.getitemstring(ldw_browse.GetRow(),'doc_ext')
	lstr_ctx_email.fullfilename_list[1] = gf_merge_file_name(ldw_browse.getitemstring(ldw_browse.GetRow(),'doc_name'),ldw_browse.getitemstring(ldw_browse.GetRow(),'doc_ext'),ldw_browse.getitemnumber(ldw_browse.GetRow(),'doc_id'),ldw_browse.getitemdecimal(ldw_browse.GetRow(),'revision'))
End If

//Open web Approve Window
OpenWithParm(w_dm_approve,lstr_ctx_email)

If Message.doubleparm <= 0 Then Return

//Set Check Out Status
SetPointer(HourGlass!)


//Refresh DM browse window	
This.Event ue_retrieve( )
If tab_1.selectedtab = 1 Then
	ldw_browse.SetRedraw( False)
	This.of_locate_doc(lstr_ctx_email.doc_id_list[])
	ldw_browse.SetRedraw( True)
Else
	This.of_locate_doc(lstr_ctx_email.doc_id_list[1])
End If

//Refresh Action Items
If isvalid(gw_contract) Then
	If gw_contract.tab_contract_details.ib_select9 Then
		ll_current_ctxid = gw_contract.tab_contract_details.tabpage_images.inv_contract_details.of_get_ctx_id( )
		If lnv_string.of_isexists( lstr_ctx_email.ctx_id_list[], ll_current_ctxid) Then
			gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_action.of_retrieve()
		End If
	End If
End If
	
Return 	

end event

event ue_document_history();//add by gavins 20120201
// show or hide document history
Long			ll_right
String			ls_Option_Value

ib_browseZoom = False// fix browse's resize 

If tab_1.tabpage_browse.dw_detail.Visible Then
	
	tab_1.tabpage_browse.dw_detail.Visible = false
	
	tab_1.tabpage_browse.st_vsplitbar.Visible = false
	
	If tab_1.tabpage_browse.dw_filter.Visible Then
//		tab_1.tabpage_browse.dw_browse.Height = tab_1.tabpage_browse.Height - tab_1.tabpage_browse.dw_browse.y - 20
		tab_1.tabpage_browse.dw_browse.Y =  tab_1.tabpage_browse.dw_filter.Y + tab_1.tabpage_browse.dw_filter.height + 10
		tab_1.tabpage_browse.dw_browse.Height = tab_1.tabpage_browse.Height - tab_1.tabpage_browse.dw_filter.Y - tab_1.tabpage_browse.dw_filter.Height - 10
	Else
		tab_1.tabpage_browse.dw_browse.Y =   tab_1.tabpage_browse.dw_filter.Y
		tab_1.tabpage_browse.dw_browse.Height = tab_1.tabpage_browse.Height - 10
		
	End If
	tab_1.tabpage_browse.st_vsplitbar.Y = Tab_1.TabPage_Browse.dw_Browse.Y + Tab_1.TabPage_Browse.dw_Browse.Height + 4
	
	
//	this.inv_resize.of_Unregister( tab_1.tabpage_browse.dw_browse )
//	this.inv_resize.of_register( tab_1.tabpage_browse.dw_browse,inv_resize.scalerightbottom   )
Else
	tab_1.tabpage_browse.SetRedraw( false )
	
	tab_1.tabpage_browse.st_vsplitbar.Visible = true	
	If tab_1.tabpage_browse.dw_filter.Visible Then
		
//		tab_1.tabpage_browse.dw_browse.Height =  tab_1.tabpage_browse.Height  -  tab_1.tabpage_browse.dw_browse.y - tab_1.tabpage_browse.dw_detail.Height - 20
		tab_1.tabpage_browse.dw_browse.Y = tab_1.tabpage_browse.dw_filter.Y +  tab_1.tabpage_browse.dw_filter.height + 10 
		tab_1.tabpage_browse.dw_Browse.Height =  ( tab_1.tabpage_browse.Height  - tab_1.tabpage_browse.dw_filter.Y - tab_1.tabpage_browse.dw_filter.Height  ) / 2 - 10
		tab_1.tabpage_browse.st_vsplitbar.Y = tab_1.tabpage_browse.dw_browse.Y + tab_1.tabpage_browse.dw_browse.Height + 4
		tab_1.tabpage_browse.dw_detail.Y = tab_1.tabpage_browse.st_vsplitbar.y + tab_1.tabpage_browse.st_vsplitbar.height + 4 
		tab_1.tabpage_browse.dw_detail.Height = tab_1.tabpage_browse.Height - tab_1.tabpage_browse.st_vsplitbar.y - tab_1.tabpage_browse.st_vsplitbar.height - 20
	Else
//		tab_1.tabpage_browse.dw_browse.Height =  tab_1.tabpage_browse.Height  - tab_1.tabpage_browse.dw_detail.Height - 20
		tab_1.tabpage_browse.dw_browse.Y = tab_1.tabpage_browse.dw_filter.Y + 10 
		tab_1.tabpage_browse.dw_Browse.Height =  ( tab_1.tabpage_browse.Height   ) / 2 - 10
		tab_1.tabpage_browse.st_vsplitbar.Y = tab_1.tabpage_browse.dw_browse.Y + tab_1.tabpage_browse.dw_browse.Height + 4
		tab_1.tabpage_browse.dw_detail.Y = tab_1.tabpage_browse.st_vsplitbar.y + tab_1.tabpage_browse.st_vsplitbar.height + 4 
		tab_1.tabpage_browse.dw_detail.Height = tab_1.tabpage_browse.Height - tab_1.tabpage_browse.st_vsplitbar.y - tab_1.tabpage_browse.st_vsplitbar.height - 20
	End If
	tab_1.tabpage_browse.dw_detail.Visible = true
	of_set_splitbar_location( )
	
	tab_1.tabpage_browse.SetRedraw( true )
//	this.inv_resize.of_Unregister( tab_1.tabpage_browse.dw_browse )
//	this.inv_resize.of_register( tab_1.tabpage_browse.dw_browse,inv_resize.scaleright  )
	
	/******************************************/

End If

ib_browseZoom = true// fix browse's resize 



if IsValid(m_pfe_cst_mdi_menu_contract_am) then
	ll_Right = w_mdi.of_security_access(6924)
		
	If ll_Right<>0  Then // add by gavins 20120201
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_history,'toolbaritemvisible', true)
		If tab_1.tabpage_browse.dw_detail.Visible Then
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_history,'ToolbarItemDown', true)
		Else
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_history,'ToolbarItemDown', false)
		End If

	Else
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_history,'toolbaritemvisible', false)
	End If
end if

	gnv_user_option.of_Set_Option_Value( gs_user_id, 'm_documentmanager.m_history.ToolbarItemDown', &
					lower(string( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_history.ToolbarItemDown ) ) )


end event

event ue_primary_document();//====================================================================
// Event: ue_primary_document
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 10/30/2012
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
Long 		ll_ctx_id
String 	ls_primary_doc = ''

ll_ctx_id = inv_contract_details.of_get_ctx_id( )
	
If ib_set_Primary_document = True Then
	Update ctx_am_document
		set  primary_doc = '0'
		From ctx_am_document
		Where ctx_id = :ll_ctx_id and primary_doc = '1' 
		and doc_id = :il_doc_id ;
Else
	gnv_appeondb.of_startqueue( )
	Update ctx_am_document
		set  primary_doc = '0'
		From ctx_am_document
		Where ctx_id = :ll_ctx_id and primary_doc = '1' 
		and doc_id <> :il_doc_id ;

	Update ctx_am_document
		set  primary_doc = '1'
		From ctx_am_document
		Where ctx_id = :ll_ctx_id and (primary_doc = '0' or (primary_doc is null ))
		and doc_id = :il_doc_id ;
	gnv_appeondb.of_commitqueue( )		
End If

//refresh data
event ue_retrieve()
end event

event ue_checkout_echosign();//////////////////////////////////////////////////////////////////////
// Event: ue_checkout_echosign()
// Arguments:
//--------------------------------------------------------------------
// Return:  (none)
//--------------------------------------------------------------------
// Author:	 Jay.Chen 2013-09-29.
//--------------------------------------------------------------------
// Description: Check out with echosign
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////
Long ll_find_row,j
Datawindow ldw_browse
str_ctx_email lstr_ctx_email,lstr_sertifi_sign,lstr_sertifi_ref
n_ds lds_sertifi_update, lds_action_items
str_sertifi_doc lstr_sertifi_doc 

IF NOT of_issaved() THEN
	MessageBox("Save Document","The document has been modified, please save it first.") 
	Return
END IF		

//Set CTX info.
if iw_parent.classname() = 'w_contract' Then
	lstr_ctx_email.doc_from = 'DM'
	lstr_ctx_email.ctx_id = inv_contract_details.of_get_ctx_id()
Elseif iw_parent.classname() = 'w_documents_browse' Then
	lstr_ctx_email.doc_from = 'DM_BROWSE'
	lstr_ctx_email.ctx_id = tab_1.tabpage_browse.dw_browse.getitemnumber(tab_1.tabpage_browse.dw_browse.getrow(),'ctx_id')
End If

//Get Document Info
String ls_fullname
ldw_browse = tab_1.tabpage_browse.dw_browse
If tab_1.selectedtab = 1 Then //Browse Tab

	//Check record, only level 1 can be checked out.
	ll_find_row = ldw_browse.GetSelectedRow(0)
	Do While ll_find_row > 0
		If ldw_browse.getitemnumber(ll_find_row,'level') <> 1 Then
			Messagebox('Check Out','The history revision can not be checked out.')
			ldw_browse.ScrolltoRow(ll_find_row)
			Return
		End If
		ll_find_row = ldw_browse.GetSelectedRow(ll_find_row)
	Loop 

	//Get Doc Info
	ll_find_row = ldw_browse.GetSelectedRow(0)
	Do While ll_find_row > 0
		If lstr_ctx_email.doc_from = 'DM' Then
			lstr_ctx_email.ctx_id_list[UpperBound(lstr_ctx_email.ctx_id_list)+1] = inv_contract_details.of_get_ctx_id()
		ElseIf  lstr_ctx_email.doc_from = 'DM_BROWSE' Then
			lstr_ctx_email.ctx_id_list[UpperBound(lstr_ctx_email.ctx_id_list)+1] = ldw_browse.getitemnumber(ll_find_row,'ctx_id')	
		End If
		lstr_ctx_email.doc_id_list[UpperBound(lstr_ctx_email.doc_id_list)+1] = ldw_browse.getitemnumber(ll_find_row,'doc_id')
		lstr_ctx_email.revision_list[UpperBound(lstr_ctx_email.revision_list)+1] = ldw_browse.getitemdecimal(ll_find_row,'revision')
		lstr_ctx_email.fullfilename_list[UpperBound(lstr_ctx_email.fullfilename_list)+1] =  gf_merge_file_name(ldw_browse.getitemstring(ll_find_row,'doc_name'),ldw_browse.getitemstring(ll_find_row,'doc_ext'),ldw_browse.getitemnumber(ll_find_row,'doc_id'),ldw_browse.getitemdecimal(ll_find_row,'revision'))
		ll_find_row = ldw_browse.GetSelectedRow(ll_find_row)
	Loop
Else //PreView Tab. only Single Document
	//Check record, only level 1 can be checked out.
	If ldw_browse.getitemnumber(ldw_browse.GetRow(),'level') <> 1 Then
		Messagebox('Check Out','The history revision can not be checked out.')
		Return
	End If
	
	If lstr_ctx_email.doc_from = 'DM' Then
		lstr_ctx_email.ctx_id_list[1] = inv_contract_details.of_get_ctx_id()
	ElseIf  lstr_ctx_email.doc_from = 'DM_BROWSE' Then
		lstr_ctx_email.ctx_id_list[1] = ldw_browse.getitemnumber(ldw_browse.GetRow(),'ctx_id')	
	End If
	lstr_ctx_email.doc_id_list[1] = ldw_browse.getitemnumber(ldw_browse.GetRow(),'doc_id')
	lstr_ctx_email.revision_list[1] = ldw_browse.getitemdecimal(ldw_browse.GetRow(),'revision')
	lstr_ctx_email.fullfilename_list[1] = gf_merge_file_name(ldw_browse.getitemstring(ldw_browse.GetRow(),'doc_name'),ldw_browse.getitemstring(ldw_browse.GetRow(),'doc_ext'),ldw_browse.getitemnumber(ldw_browse.GetRow(),'doc_id'),ldw_browse.getitemdecimal(ldw_browse.GetRow(),'revision'))
End If

//Create Echosign Request
OpenWithParm(w_dm_echosign_request,lstr_ctx_email)

PowerObject lpo_pass
If Not Isvalid(Message.Powerobjectparm) Then Return
lpo_pass = Message.Powerobjectparm
If lpo_pass.classname( ) <> 'str_ctx_email' Then Return



lstr_ctx_email = lpo_pass

lstr_sertifi_doc.as_es_apicode = gnv_echosign.is_apicode
lstr_sertifi_doc.as_es_fileid = lstr_ctx_email.as_sertifi_fileid

SetPointer(HourGlass!)

//Set check out status.
lds_sertifi_update = Create n_ds
lds_sertifi_update.dataobject = 'd_am_checkout_sertifi_update'
lds_sertifi_update.SetTransObject(SQLCA)

lds_action_items = Create n_ds
lds_action_items.dataobject = 'd_am_action_items'
lds_action_items.SetTransObject(SQLCA)

gnv_appeondb.of_startqueue( )
	lds_sertifi_update.Retrieve(lstr_ctx_email.doc_id_list[])
	lds_action_items.Retrieve(lstr_ctx_email.doc_id_list[])
gnv_appeondb.of_commitqueue( )

Long i,ll_find,ll_row
Long ll_sign_doc_id[], ll_ref_doc_id[]
Datetime ldt_now
ldt_now = datetime(today() , Now())
For i = 1 To UpperBound(lstr_ctx_email.doc_id_list[])
	If Len(lstr_ctx_email.as_sertifi_docid[i]) > 0 Then
		ll_sign_doc_id[UpperBound(ll_sign_doc_id[]) + 1] = lstr_ctx_email.doc_id_list[i]
		ll_find = lds_sertifi_update.Find('doc_id = ' + String(lstr_ctx_email.doc_id_list[i]), 1, lds_sertifi_update.RowCount() )
		If ll_find > 0 Then
			lds_sertifi_update.SetItem(ll_find, 'checkout_status','5')
			lds_sertifi_update.SetItem(ll_find, 'checkout_date',today())
			lds_sertifi_update.SetItem(ll_find, 'checkout_by',gs_user_id)
			lds_sertifi_update.SetItem(ll_find, 'es_apicode', gnv_echosign.is_apicode)
			lds_sertifi_update.SetItem(ll_find, 'es_fileid', lstr_ctx_email.as_sertifi_fileid )
			lds_sertifi_update.SetItem(ll_find, 'es_docid', lstr_ctx_email.as_sertifi_docid[i] )
			lds_sertifi_update.SetItem(ll_find, 'es_sender', lstr_ctx_email.as_sender )
			lds_sertifi_update.SetItem(ll_find, 'es_sender_email', lstr_ctx_email.as_mail_from )
			lds_sertifi_update.SetItem(ll_find, 'esign_type',gs_esigntype)
		Else
			gnv_echosign.of_removesignaturerequest(lstr_sertifi_doc)
			Messagebox('Error','Failed to check out the document ' + lstr_ctx_email.fullfilename_list[i] + '.' )
			If isvalid(lds_sertifi_update) Then Destroy lds_sertifi_update
			Return
		End If
//		//Insert Action Item for E-signer
		For j = 1 To UpperBound(lstr_ctx_email.as_user_arr[] )
			ll_row = lds_action_items.InsertRow(0)
			lds_action_items.SetItem(ll_row,'doc_id',lstr_ctx_email.doc_id_list[i] )
			lds_action_items.SetItem(ll_row,'action_type',gnv_echosign.il_esign )  
			lds_action_items.SetItem(ll_row,'due_date', lstr_ctx_email.adt_duedate )
			lds_action_items.SetItem(ll_row,'wf_assigned_by', gs_user_id)
			lds_action_items.SetItem(ll_row,'active_status',0)
			lds_action_items.SetItem(ll_row,'action_status',gnv_echosign.il_incomplete )
			lds_action_items.SetItem(ll_row,'status_date',ldt_now)
			lds_action_items.SetItem(ll_row,'create_date',ldt_now)
			lds_action_items.SetItem(ll_row,'action_user',lstr_ctx_email.as_user_arr[j])
			lds_action_items.SetItem(ll_row,'attempt_times',1)
			lds_action_items.SetItem(ll_row,'first_attempt',ldt_now)
			lds_action_items.SetItem(ll_row,'last_attempt',ldt_now)
			lds_action_items.SetItem(ll_row,'print_flag',-1)
			lds_action_items.SetItem(ll_row,'notes','')
			lds_action_items.SetItem(ll_row,'es_docid',lstr_ctx_email.as_sertifi_docid[i])			
		Next

		//Insert Action Item for Sender
		If lstr_ctx_email.ai_create_ai = 1 Then
			ll_row = lds_action_items.InsertRow(0)
			lds_action_items.SetItem(ll_row,'doc_id',lstr_ctx_email.doc_id_list[i] )
			lds_action_items.SetItem(ll_row,'action_type',gnv_echosign.il_doccheckin )  
			lds_action_items.SetItem(ll_row,'due_date', lstr_ctx_email.adt_duedate )
			lds_action_items.SetItem(ll_row,'wf_assigned_by', gs_user_id)
			lds_action_items.SetItem(ll_row,'active_status',0)
			lds_action_items.SetItem(ll_row,'action_status',gnv_echosign.il_incomplete )
			lds_action_items.SetItem(ll_row,'status_date',ldt_now)
			lds_action_items.SetItem(ll_row,'create_date',ldt_now)
			lds_action_items.SetItem(ll_row,'action_user',gs_user_id)
			lds_action_items.SetItem(ll_row,'attempt_times',1)
			lds_action_items.SetItem(ll_row,'first_attempt',ldt_now)
			lds_action_items.SetItem(ll_row,'last_attempt',ldt_now)
			lds_action_items.SetItem(ll_row,'print_flag',-1)
			lds_action_items.SetItem(ll_row,'notes','')
			lds_action_items.SetItem(ll_row,'es_docid',lstr_ctx_email.as_sertifi_docid[i])
		End If
		lstr_sertifi_sign.as_sertifi_fileid = lstr_ctx_email.as_sertifi_fileid
		lstr_sertifi_sign.as_sertifi_docid[UpperBound(lstr_sertifi_sign.as_sertifi_docid[]) + 1] = lstr_ctx_email.as_sertifi_docid[i]		
	Else
		ll_ref_doc_id[UpperBound(ll_sign_doc_id[]) + 1] = lstr_ctx_email.doc_id_list[i]
		lstr_sertifi_ref.as_sertifi_fileid = lstr_sertifi_ref.as_sertifi_fileid
		lstr_sertifi_ref.as_sertifi_docid[UpperBound(lstr_sertifi_ref.as_sertifi_docid[]) + 1] = lstr_sertifi_ref.as_sertifi_docid[i]				
	End If
Next


If lds_sertifi_update.Update() <> 1 Then
	gnv_echosign.of_removesignaturerequest(lstr_sertifi_doc)
	Messagebox('Error','Failed to check out the document ' + lstr_ctx_email.fullfilename_list[i] + '.' )
	If isvalid(lds_sertifi_update) Then Destroy lds_sertifi_update
	Return	
End If

If lds_action_items.Update() <> 1 Then
	Messagebox('Error','The document(s) have been checked out, but failed to create the Action Item.')
	//Return -1
End If

//Set Sender info
lstr_sertifi_sign.as_mail_from = lstr_ctx_email.as_mail_from
lstr_sertifi_sign.as_sender =  lstr_ctx_email.as_sender
lstr_sertifi_ref.as_mail_from = lstr_ctx_email.as_mail_from
lstr_sertifi_ref.as_sender =  lstr_ctx_email.as_sender

//Add Audit
inv_dm_utils.of_add_audit_trail( ll_sign_doc_id[], lstr_sertifi_sign,'Check Out & Echosign Request')
inv_dm_utils.of_add_audit_trail( ll_ref_doc_id[], lstr_sertifi_ref,'Echosign Ref Document')

If isvalid(lds_sertifi_update) Then Destroy lds_sertifi_update
If isvalid(lds_action_items) Then Destroy lds_action_items

SetPointer(HourGlass!)

//Refresh DM browse window	
This.Event ue_retrieve( )
If tab_1.selectedtab = 1 Then
	ldw_browse.SetRedraw( False)
	This.of_locate_doc(lstr_ctx_email.doc_id_list[])
	ldw_browse.SetRedraw( True)
Else
	This.of_locate_doc(lstr_ctx_email.doc_id_list[1])
End If


//Refresh Action Items
If iw_parent.classname() = 'w_contract' and lstr_ctx_email.ai_create_ai = 1 Then 
	gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_action.of_retrieve()
End If


Return 


end event

event ue_checkout_docusign();//====================================================================
// Event: ue_checkout_docusign
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Jay Chen		Date: 04-09-2014
//--------------------------------------------------------------------
//	Copyright (c) 2008-2013 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Long ll_find_row,j
Datawindow ldw_browse
str_ctx_email lstr_ctx_email,lstr_sertifi_sign,lstr_sertifi_ref
n_ds lds_sertifi_update, lds_action_items
str_sertifi_doc lstr_sertifi_doc 

IF NOT of_issaved() THEN
	MessageBox("Save Document","The document has been modified, please save it first.") 
	Return
END IF		

//Set CTX info.
if iw_parent.classname() = 'w_contract' Then
	lstr_ctx_email.doc_from = 'DM'
	lstr_ctx_email.ctx_id = inv_contract_details.of_get_ctx_id()
Elseif iw_parent.classname() = 'w_documents_browse' Then
	lstr_ctx_email.doc_from = 'DM_BROWSE'
	lstr_ctx_email.ctx_id = tab_1.tabpage_browse.dw_browse.getitemnumber(tab_1.tabpage_browse.dw_browse.getrow(),'ctx_id')
End If

//Get Document Info
String ls_fullname
ldw_browse = tab_1.tabpage_browse.dw_browse
If tab_1.selectedtab = 1 Then //Browse Tab

	//Check record, only level 1 can be checked out.
	ll_find_row = ldw_browse.GetSelectedRow(0)
	Do While ll_find_row > 0
		If ldw_browse.getitemnumber(ll_find_row,'level') <> 1 Then
			Messagebox('Check Out','The history revision can not be checked out.')
			ldw_browse.ScrolltoRow(ll_find_row)
			Return
		End If
		ll_find_row = ldw_browse.GetSelectedRow(ll_find_row)
	Loop 

	//Get Doc Info
	ll_find_row = ldw_browse.GetSelectedRow(0)
	Do While ll_find_row > 0
		If lstr_ctx_email.doc_from = 'DM' Then
			lstr_ctx_email.ctx_id_list[UpperBound(lstr_ctx_email.ctx_id_list)+1] = inv_contract_details.of_get_ctx_id()
		ElseIf  lstr_ctx_email.doc_from = 'DM_BROWSE' Then
			lstr_ctx_email.ctx_id_list[UpperBound(lstr_ctx_email.ctx_id_list)+1] = ldw_browse.getitemnumber(ll_find_row,'ctx_id')	
		End If
		lstr_ctx_email.doc_id_list[UpperBound(lstr_ctx_email.doc_id_list)+1] = ldw_browse.getitemnumber(ll_find_row,'doc_id')
		lstr_ctx_email.revision_list[UpperBound(lstr_ctx_email.revision_list)+1] = ldw_browse.getitemdecimal(ll_find_row,'revision')
		lstr_ctx_email.fullfilename_list[UpperBound(lstr_ctx_email.fullfilename_list)+1] =  gf_merge_file_name(ldw_browse.getitemstring(ll_find_row,'doc_name'),ldw_browse.getitemstring(ll_find_row,'doc_ext'),ldw_browse.getitemnumber(ll_find_row,'doc_id'),ldw_browse.getitemdecimal(ll_find_row,'revision'))
		ll_find_row = ldw_browse.GetSelectedRow(ll_find_row)
	Loop
Else //PreView Tab. only Single Document
	//Check record, only level 1 can be checked out.
	If ldw_browse.getitemnumber(ldw_browse.GetRow(),'level') <> 1 Then
		Messagebox('Check Out','The history revision can not be checked out.')
		Return
	End If
	
	If lstr_ctx_email.doc_from = 'DM' Then
		lstr_ctx_email.ctx_id_list[1] = inv_contract_details.of_get_ctx_id()
	ElseIf  lstr_ctx_email.doc_from = 'DM_BROWSE' Then
		lstr_ctx_email.ctx_id_list[1] = ldw_browse.getitemnumber(ldw_browse.GetRow(),'ctx_id')	
	End If
	lstr_ctx_email.doc_id_list[1] = ldw_browse.getitemnumber(ldw_browse.GetRow(),'doc_id')
	lstr_ctx_email.revision_list[1] = ldw_browse.getitemdecimal(ldw_browse.GetRow(),'revision')
	lstr_ctx_email.fullfilename_list[1] = gf_merge_file_name(ldw_browse.getitemstring(ldw_browse.GetRow(),'doc_name'),ldw_browse.getitemstring(ldw_browse.GetRow(),'doc_ext'),ldw_browse.getitemnumber(ldw_browse.GetRow(),'doc_id'),ldw_browse.getitemdecimal(ldw_browse.GetRow(),'revision'))
End If

//Create Docusign Request
OpenWithParm(w_dm_docusign_request,lstr_ctx_email)

PowerObject lpo_pass
If Not Isvalid(Message.Powerobjectparm) Then Return
lpo_pass = Message.Powerobjectparm
If lpo_pass.classname( ) <> 'str_ctx_email' Then Return



lstr_ctx_email = lpo_pass

lstr_sertifi_doc.as_es_apicode = gnv_docusign.is_apicode
lstr_sertifi_doc.as_es_fileid = lstr_ctx_email.as_sertifi_fileid

SetPointer(HourGlass!)

//Set check out status.
lds_sertifi_update = Create n_ds
lds_sertifi_update.dataobject = 'd_am_checkout_sertifi_update'
lds_sertifi_update.SetTransObject(SQLCA)

lds_action_items = Create n_ds
lds_action_items.dataobject = 'd_am_action_items'
lds_action_items.SetTransObject(SQLCA)

gnv_appeondb.of_startqueue( )
	lds_sertifi_update.Retrieve(lstr_ctx_email.doc_id_list[])
	lds_action_items.Retrieve(lstr_ctx_email.doc_id_list[])
gnv_appeondb.of_commitqueue( )

Long i,ll_find,ll_row
Long ll_sign_doc_id[], ll_ref_doc_id[]
Datetime ldt_now
ldt_now = datetime(today() , Now())
For i = 1 To UpperBound(lstr_ctx_email.doc_id_list[])
	If Len(lstr_ctx_email.as_sertifi_docid[i]) > 0 Then
		ll_sign_doc_id[UpperBound(ll_sign_doc_id[]) + 1] = lstr_ctx_email.doc_id_list[i]
		ll_find = lds_sertifi_update.Find('doc_id = ' + String(lstr_ctx_email.doc_id_list[i]), 1, lds_sertifi_update.RowCount() )
		If ll_find > 0 Then
			lds_sertifi_update.SetItem(ll_find, 'checkout_status','5')
			lds_sertifi_update.SetItem(ll_find, 'checkout_date',today())
			lds_sertifi_update.SetItem(ll_find, 'checkout_by',gs_user_id)
			lds_sertifi_update.SetItem(ll_find, 'es_apicode', gnv_docusign.is_apicode)
			lds_sertifi_update.SetItem(ll_find, 'es_fileid', lstr_ctx_email.as_sertifi_fileid )
			lds_sertifi_update.SetItem(ll_find, 'es_docid', lstr_ctx_email.as_sertifi_docid[i] )
			lds_sertifi_update.SetItem(ll_find, 'es_sender', lstr_ctx_email.as_sender )
			lds_sertifi_update.SetItem(ll_find, 'es_sender_email', lstr_ctx_email.as_mail_from )
			lds_sertifi_update.SetItem(ll_find, 'esign_type',gs_esigntype)
			lds_sertifi_update.SetItem(ll_find, 'es_license_user_id',is_license_user_id) //Added By Jay Chen 09-04-2014
		Else
			gnv_docusign.of_removesignaturerequest(lstr_sertifi_doc)
			Messagebox('Error','Failed to check out the document ' + lstr_ctx_email.fullfilename_list[i] + '.' )
			If isvalid(lds_sertifi_update) Then Destroy lds_sertifi_update
			Return
		End If
//		//Insert Action Item for E-signer
		For j = 1 To UpperBound(lstr_ctx_email.as_user_arr[] )
			ll_row = lds_action_items.InsertRow(0)
			lds_action_items.SetItem(ll_row,'doc_id',lstr_ctx_email.doc_id_list[i] )
			lds_action_items.SetItem(ll_row,'action_type',gnv_docusign.il_esign )  
			lds_action_items.SetItem(ll_row,'due_date', lstr_ctx_email.adt_duedate )
			lds_action_items.SetItem(ll_row,'wf_assigned_by', gs_user_id)
			lds_action_items.SetItem(ll_row,'active_status',0)
			lds_action_items.SetItem(ll_row,'action_status',gnv_docusign.il_incomplete )
			lds_action_items.SetItem(ll_row,'status_date',ldt_now)
			lds_action_items.SetItem(ll_row,'create_date',ldt_now)
			lds_action_items.SetItem(ll_row,'action_user',lstr_ctx_email.as_user_arr[j])
			lds_action_items.SetItem(ll_row,'attempt_times',1)
			lds_action_items.SetItem(ll_row,'first_attempt',ldt_now)
			lds_action_items.SetItem(ll_row,'last_attempt',ldt_now)
			lds_action_items.SetItem(ll_row,'print_flag',-1)
			lds_action_items.SetItem(ll_row,'notes','')
			lds_action_items.SetItem(ll_row,'es_docid',lstr_ctx_email.as_sertifi_docid[i])			
		Next

		//Insert Action Item for Sender
		If lstr_ctx_email.ai_create_ai = 1 Then
			ll_row = lds_action_items.InsertRow(0)
			lds_action_items.SetItem(ll_row,'doc_id',lstr_ctx_email.doc_id_list[i] )
			lds_action_items.SetItem(ll_row,'action_type',gnv_docusign.il_doccheckin )  
			lds_action_items.SetItem(ll_row,'due_date', lstr_ctx_email.adt_duedate )
			lds_action_items.SetItem(ll_row,'wf_assigned_by', gs_user_id)
			lds_action_items.SetItem(ll_row,'active_status',0)
			lds_action_items.SetItem(ll_row,'action_status',gnv_docusign.il_incomplete )
			lds_action_items.SetItem(ll_row,'status_date',ldt_now)
			lds_action_items.SetItem(ll_row,'create_date',ldt_now)
			lds_action_items.SetItem(ll_row,'action_user',gs_user_id)
			lds_action_items.SetItem(ll_row,'attempt_times',1)
			lds_action_items.SetItem(ll_row,'first_attempt',ldt_now)
			lds_action_items.SetItem(ll_row,'last_attempt',ldt_now)
			lds_action_items.SetItem(ll_row,'print_flag',-1)
			lds_action_items.SetItem(ll_row,'notes','')
			lds_action_items.SetItem(ll_row,'es_docid',lstr_ctx_email.as_sertifi_docid[i])
		End If
		lstr_sertifi_sign.as_sertifi_fileid = lstr_ctx_email.as_sertifi_fileid
		lstr_sertifi_sign.as_sertifi_docid[UpperBound(lstr_sertifi_sign.as_sertifi_docid[]) + 1] = lstr_ctx_email.as_sertifi_docid[i]		
	Else
		ll_ref_doc_id[UpperBound(ll_sign_doc_id[]) + 1] = lstr_ctx_email.doc_id_list[i]
		lstr_sertifi_ref.as_sertifi_fileid = lstr_sertifi_ref.as_sertifi_fileid
		lstr_sertifi_ref.as_sertifi_docid[UpperBound(lstr_sertifi_ref.as_sertifi_docid[]) + 1] = lstr_sertifi_ref.as_sertifi_docid[i]				
	End If
Next


If lds_sertifi_update.Update() <> 1 Then
	gnv_docusign.of_removesignaturerequest(lstr_sertifi_doc)
	Messagebox('Error','Failed to check out the document ' + lstr_ctx_email.fullfilename_list[i] + '.' )
	If isvalid(lds_sertifi_update) Then Destroy lds_sertifi_update
	Return	
End If

If lds_action_items.Update() <> 1 Then
	Messagebox('Error','The document(s) have been checked out, but failed to create the Action Item.')
	//Return -1
End If

//Set Sender info
lstr_sertifi_sign.as_mail_from = lstr_ctx_email.as_mail_from
lstr_sertifi_sign.as_sender =  lstr_ctx_email.as_sender
lstr_sertifi_ref.as_mail_from = lstr_ctx_email.as_mail_from
lstr_sertifi_ref.as_sender =  lstr_ctx_email.as_sender

//Add Audit
inv_dm_utils.of_add_audit_trail( ll_sign_doc_id[], lstr_sertifi_sign,'Check Out & Docusign Request')
inv_dm_utils.of_add_audit_trail( ll_ref_doc_id[], lstr_sertifi_ref,'Docusign Ref Document')

If isvalid(lds_sertifi_update) Then Destroy lds_sertifi_update
If isvalid(lds_action_items) Then Destroy lds_action_items

SetPointer(HourGlass!)

//Refresh DM browse window	
This.Event ue_retrieve( )
If tab_1.selectedtab = 1 Then
	ldw_browse.SetRedraw( False)
	This.of_locate_doc(lstr_ctx_email.doc_id_list[])
	ldw_browse.SetRedraw( True)
Else
	This.of_locate_doc(lstr_ctx_email.doc_id_list[1])
End If


//Refresh Action Items
If iw_parent.classname() = 'w_contract' and lstr_ctx_email.ai_create_ai = 1 Then 
	gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_action.of_retrieve()
End If


Return 


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


if not isnull(ls_doc_type) and ls_doc_type <> 'A'and ls_doc_type <> ''and ls_doc_type <> ' ' then //Modified By Ken.Guo 10/10/2013
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
if len(trim(ls_create_by)) > 0  then
	ls_filter += "and lower(create_by) = '" + lower(ls_create_by) + "' "
end if
if not isnull(ld_create_date) then 
	ls_filter += "and string(create_date,'yyyy/mm/dd') >= '" + string(ld_create_date,'yyyy/mm/dd') + "' "
end if
if not isnull(ld_create_date2) then 
	ls_filter += "and string(create_date,'yyyy/mm/dd') <= '" + string(ld_create_date2,'yyyy/mm/dd') + "' "
end if
if not isnull(ll_status)  then
	//ls_filter += "and status = " + string(ll_status) 
	ls_filter += "and status = " + string(ll_status) + " " //alfee 08.22.2007
end if
if len(trim(ls_status_by)) > 0 then
	ls_filter += "and lower(status_by) = '" + lower(ls_status_by) + "' "
end if
if not isnull(ld_status_date) then 
	ls_filter += "and string(status_date,'yyyy/mm/dd') >= '" + string(ld_status_date,'yyyy/mm/dd') + "' "
end if
if not isnull(ld_status_date2) then 
	ls_filter += "and string(status_date,'yyyy/mm/dd') <= '" + string(ld_status_date2,'yyyy/mm/dd') + "' "
end if

//---------Begin Added by (Appeon)Harry 03.19.2014 for V142 ISG-CLX--------
//Added By Jay Chen 03-07-2014 Remark: add custom fields
string ls_colname,ls_value,ls_coltype,ls_visible,ls_Edit_Style,ls_data,ls_display
long ll_cnt,ll_row
dec{2} ldc_custom_number
datetime ldt_custom_date
ll_cnt = long(dw_filter.Describe( "DataWindow.Column.Count" ))
for ll_row = 1 to ll_cnt
	ls_colname = lower(dw_filter.Describe("#"+string( ll_row ) + ".name"))
	if left(ls_colname,7) <> 'custom_' then continue
	ls_coltype = lower(dw_filter.Describe("#"+string( ll_row ) + ".coltype" ))
	ls_visible = dw_filter.Describe(ls_colname + ".Visible")
	ls_Edit_Style = dw_filter.Describe(ls_colname + ".Edit.Style")
	if ls_visible <> '1' then continue
	choose case left(ls_coltype,4)
		case 'char'
			ls_value = dw_filter.getitemstring(1,ls_colname)
			if not isnull(ls_value) and ls_value<>''  then 
				if ls_Edit_Style = "dddw" then
					ls_filter += "and "+ls_colname+" = '" + ls_value+"' "
				else
					ls_filter += "and pos(lower("+ls_colname+"), '" + lower(ls_value) + "') > 0 " 
				end if
			end if
			
		case 'deci'
			ldc_custom_number = dw_filter.getitemdecimal(1,ls_colname)
			if not isnull(ldc_custom_number) then 
				ls_filter += "and "+ls_colname+" = " + string(ldc_custom_number) + " "
			end if
			
		case 'date'
			ldt_custom_date = dw_filter.getitemdatetime(1,ls_colname)
			if not isnull(ldt_custom_date) then 
				ls_filter += "and string("+ls_colname+",'yyyy/mm/dd') = '" + string(ldt_custom_date,'yyyy/mm/dd') + "' "
			end if
	end choose
next
//---------End Added ------------------------------------------------------

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
//	tab_1.tabpage_preview.uo_1.visible = false
	tab_1.tabpage_preview.uo_2.visible = false //Alfee 05.19.2008
	
	IF ab_show_clausemap THEN
		IF not tab_1.tabpage_preview.gb_map.visible THEN
			tab_1.tabpage_preview.gb_map.visible=true
			tab_1.tabpage_preview.dw_clause.visible=true
			tab_1.tabpage_preview.dw_change.visible=true
			tab_1.tabpage_preview.gb_map.visible=true
			tab_1.tabpage_preview.cb_approve.visible=true
			tab_1.tabpage_preview.cb_reject.visible=true
			tab_1.tabpage_preview.pb_approve.visible=true //07.09.2008
			tab_1.tabpage_preview.pb_reject.visible=true	//07.09.2008		
			tab_1.tabpage_preview.cb_original.visible=true
			tab_1.tabpage_preview.ole_doc.x = 1179
			tab_1.tabpage_preview.ole_doc.width = tab_1.tabpage_preview.ole_doc.width - 1171
			tab_1.tabpage_preview.dw_clause.bringtotop=true
			tab_1.tabpage_preview.dw_change.bringtotop=true
			
			tab_1.tabpage_preview.cb_approve.bringtotop=true
			tab_1.tabpage_preview.cb_reject.bringtotop=true
			tab_1.tabpage_preview.pb_approve.bringtotop=true  //07.09.2008
			tab_1.tabpage_preview.pb_reject.bringtotop=true	 //07.09.2008		
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
			tab_1.tabpage_preview.pb_approve.visible=false //07.09.2008
			tab_1.tabpage_preview.pb_reject.visible=false //07.09.2008			
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
	//	tab_1.tabpage_preview.uo_1.visible = true
	IF gi_imageocx = 1 THEN //Imaging 360
	//	tab_1.tabpage_preview.uo_1.visible = true
		tab_1.tabpage_preview.uo_2.visible = false		
	ELSE	//new Image OCX
	//	tab_1.tabpage_preview.uo_1.visible = false
		tab_1.tabpage_preview.uo_2.visible = true		
	END IF
	//-----------End Modified -----------------------------------------	
END IF



end subroutine

public function integer of_maponoff (boolean ab_flag);//////////////////////////////////////////////////////////////////////
// $<function>of_maponoff
// $<arguments>  value   boolean    ab_flag              
// $<returns> (none)
// $<description>Show/Hide clause map in document preview tabpage
//////////////////////////////////////////////////////////////////////
// $<add> 01.15.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////
Integer li_setting
Long ll_cnt, i, ll_clauseid[]
String ls_rights[], ls_type

tab_1.tabpage_preview.SetRedraw(false)

//-------Appeon Begin ---added by alfee at 03.14.2007 for performance tuning
IF ab_flag THEN 
	SetPointer(HourGlass!)
	//Get changed text in document if clause map on
	of_getchanges() 
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
 
//--------Begin Modified by Alfee 05.25.2007-----------------
	of_mapresize(ab_flag)

//IF ab_flag THEN
//	IF tab_1.tabpage_preview.ole_doc.x = tab_1.tabpage_preview.gb_map.x THEN
//		tab_1.tabpage_preview.ole_doc.width = tab_1.tabpage_preview.ole_doc.width - tab_1.tabpage_preview.gb_map.width - 20  
//	END IF      
//	tab_1.tabpage_preview.ole_doc.x =tab_1.tabpage_preview.gb_map.x + tab_1.tabpage_preview.gb_map.width + 20       
//	IF Isvalid(m_pfe_cst_mdi_menu_contract_am) THEN
//		m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_clausemap.toolbaritemdown = TRUE
//	END IF
//ELSE
//	tab_1.tabpage_preview.ole_doc.width += tab_1.tabpage_preview.ole_doc.x - tab_1.tabpage_preview.gb_map.x
//	tab_1.tabpage_preview.ole_doc.x = tab_1.tabpage_preview.gb_map.x
//	IF Isvalid(m_pfe_cst_mdi_menu_contract_am) THEN
//		m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_clausemap.toolbaritemdown = FALSE
//	END IF
//END IF
// 
//tab_1.tabpage_preview.gb_map.Visible = ab_flag
//tab_1.tabpage_preview.dw_clause.Visible = ab_flag
//tab_1.tabpage_preview.dw_change.Visible = ab_flag
//tab_1.tabpage_preview.cb_approve.Visible = ab_flag
//tab_1.tabpage_preview.cb_reject.Visible = ab_flag
//tab_1.tabpage_preview.cb_original.Visible = ab_flag
//tab_1.tabpage_preview.dw_clause.Enabled = ab_flag
//tab_1.tabpage_preview.dw_change.Enabled = ab_flag
//
//IF ab_flag and tab_1.tabpage_preview.dw_clause.GetRow() > 0 THEN
//	tab_1.tabpage_preview.cb_original.Enabled = True
//ELSE
//	tab_1.tabpage_preview.cb_original.Enabled = False
//END IF
//
//
//li_setting = of_get_app_setting("set_51","I")
//ls_type = Lower(tab_1.tabpage_browse.dw_browse.getitemstring(tab_1.tabpage_browse.dw_browse.getrow(),'doc_type'))
//
////Hide clause map if buy side setting or buy/other side document
//if li_setting = 3 or ls_type = "Buy" or ls_type = "Other" then
//	tab_1.tabpage_preview.cb_original.Visible = false
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_clausemap.toolbaritemtext = "Change List"
//	if tab_1.tabpage_preview.dw_clause.y <> tab_1.tabpage_preview.dw_change.y then
//		tab_1.tabpage_preview.gb_map.text = "Change List"
//		tab_1.tabpage_preview.dw_clause.visible = false
//		tab_1.tabpage_preview.dw_change.height = tab_1.tabpage_preview.dw_change.height + tab_1.tabpage_preview.dw_clause.height 
//		tab_1.tabpage_preview.dw_change.y = tab_1.tabpage_preview.dw_clause.y
//	end if
//else
//	tab_1.tabpage_preview.cb_original.Visible = ab_flag
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_clausemap.toolbaritemtext = "Clause Map"
//	if tab_1.tabpage_preview.dw_clause.y = tab_1.tabpage_preview.dw_change.y then
//		tab_1.tabpage_preview.gb_map.text = "Clause Map"
//		tab_1.tabpage_preview.dw_clause.visible = ab_flag
//		tab_1.tabpage_preview.dw_change.height = tab_1.tabpage_preview.dw_change.height - tab_1.tabpage_preview.dw_clause.height 
//		tab_1.tabpage_preview.dw_change.y = tab_1.tabpage_preview.dw_clause.y + tab_1.tabpage_preview.dw_clause.height 
//	end if
//end if
//--------End Modified ----------------------------------------------------------
tab_1.tabpage_preview.SetRedraw(true)

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
// $<returns> 
// $<description>Get and Display change list in word document
//////////////////////////////////////////////////////////////////////
// $<add> 01.15.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////

Long ll_cnt
integer li_rtn, li_newpageno, li_newpagecnt

//---------Begin Modified by Alfee 08.09.2007---------------
Integer li_h, li_dh, li_hh
//Set display rows per change page
li_h = tab_1.tabpage_preview.dw_change.Height
li_dh = Integer(tab_1.tabpage_preview.dw_change.Describe("DataWindow.Detail.Height"))
li_hh = Integer(tab_1.tabpage_preview.dw_change.Describe("DataWindow.Header.Height"))
//IF IsValid(gw_contract) THEN gw_contract.ii_changes = (li_h - li_hh) / li_dh
inv_ole_utils_doc.ii_changes = (li_h - li_hh) / li_dh

ib_locate_change = False
tab_1.tabpage_preview.dw_change.setredraw(false)

li_newpageno = Integer(tab_1.tabpage_preview.uo_scrollbar.st_page.Text)
li_newpagecnt = Integer(tab_1.tabpage_preview.uo_scrollbar.st_count.Text)
inv_ole_utils_doc.of_getchanges(li_newpageno, li_newpagecnt, tab_1.tabpage_preview.dw_change)
of_setpagestatus(li_newpageno, li_newpagecnt)

tab_1.tabpage_preview.dw_change.setredraw(true)
ib_locate_change = True

/*ll_cnt = ids_changes.rowcount()
ib_locate_change = False
tab_1.tabpage_preview.dw_change.setredraw(false)
tab_1.tabpage_preview.dw_change.reset()
IF ll_cnt > 0 THEN
	li_rtn= ids_changes.RowsCopy(1, ll_cnt, Primary!, tab_1.tabpage_preview.dw_change, 1, Primary!)
END IF
tab_1.tabpage_preview.dw_change.setredraw(true)
ib_locate_change = True*/
//---------End Modified ------------------------------------
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
long ll_row, ll_level//
integer li_rtn
string ls_doc_ext, ls_filename, ls_filename_tmp


//initilize the switch of document onstatuschanged event //By Alfee 05.15.2007
inv_ole_utils_doc.of_setstatuschanged(TRUE)

//Reset preview tabage if current file not specified
//ll_row  = tab_1.tabpage_browse.dw_browse.getrow() //modify by gavins 20120208
If IsValid( idw_LastDW ) Then ll_Row = idw_LastDW.GetRow( )
IF ll_row < 1 THEN
	inv_ole_utils_doc.of_displayfile(ls_filename,TRUE)
	//of_filter_clause(il_doc_id,idc_revision)
	of_filter_clause(il_doc_id,idc_revision, TRUE) //Alfee 05.09.2008
	of_getchanges()
	RETURN
END IF

//Refresh doc info-jervis 02.26.2009
//st_docinfo.text = tab_1.tabpage_browse.dw_browse.GetItemString(ll_row,"Doc_name") + " - Version: " + string(idc_revision)
//st_docinfo.text = tab_1.tabpage_browse.dw_browse.GetItemString(tab_1.tabpage_browse.dw_browse.getrow(),"Doc_name_full") 
If IsValid( idw_LastDW ) Then //modify by gavins 20120208
	If idw_LastDW.GetRow( ) > 0 Then 
		st_docinfo.text =  idw_LastDW.GetItemString(idw_LastDW.getrow(),"Doc_name")  + ' ' + &
		 string(  idw_LastDW.GetItemNumber(idw_LastDW.getrow(),"Doc_id") ) + '.' 
		 If idw_LastDW.classname() = 'dw_detail' Then
			st_docinfo.Text +=  string(  idw_LastDW.GetItemNumber(idw_LastDW.getrow(),"audit_version"), '##0.0' )
		Else
			 st_docinfo.Text +=string(  idw_LastDW.GetItemNumber(idw_LastDW.getrow(),"revision"), '##0.0' )
		End If
	End If
End If

//Check whether this file is already opened in preview tabpage
//--------Begin Modified by Alfee 05.15.2007----------------------------------
//<$Reason> Different level with differnt user rights control
//ll_level = tab_1.tabpage_browse.dw_browse.getitemnumber(ll_row,'level')
If idw_LastDW.Getrow( ) > 0 Then ll_level = idw_LastDW.GetItemNumber( idw_LastDW.GetRow( ), 'level' )

IF il_doc_id = il_preview_doc_id AND idc_revision = idc_preview_revision AND ll_level = il_preview_level THEN 
//IF il_doc_id = il_preview_doc_id AND idc_revision = idc_preview_revision THEN 
//--------End Modified by ----------------------------------------------------
	RETURN 
Else
	ib_merged_data = false
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergedata,'toolbaritemdown', False)
END IF

//Filter clause map
//of_filter_clause(il_doc_id,idc_revision)
of_filter_clause(il_doc_id,idc_revision, TRUE) //Alfee 05.09.2008

if gb_IsDocMode then
	OpenWithParm(w_appeon_gifofwait, "Opening Document...")
else
	OpenWithParm(w_appeon_gifofwait, "Opening the selected document...")
end if

//Choose OLE control for different type of document
of_selectole(is_doc_ext)

//Get the file 
//ls_filename = inv_ole_utils_doc.of_Getfile(il_doc_id,idc_revision,is_doc_ext,idt_modify_date)
ls_filename = inv_dm_utils.of_download_file( il_doc_id, idc_revision)

SetReDraw(FALSE)
// Added by davis, make sure this file can't be occupy, so save as the file
ib_allowtrack = FALSE //01.19.2007 
IF FileExists(ls_filename) THEN
	//Get and Set user rights on document level
	is_doc_right = of_setdocumentrights()	//by alfee at 04.10.2007			
	IF inv_ole_utils_doc.of_isreadonly() THEN
		//Open the file
		li_rtn = inv_ole_utils_doc.of_displayfile(ls_filename, TRUE)
		is_opened_file = ls_filename
	ELSE
		ls_filename_tmp = inv_dm_utils.of_generate_tempname_writable( il_doc_id, idc_revision, "doc")
		//If inv_filesvr.of_filecopy( ls_filename, ls_filename_tmp ) = 1 Then
		If FileExists( ls_filename_tmp  ) Then //added bygavins 20121011
			SetFileAttributes( ls_filename_tmp, 0 )
		End If
		IF FileCopy(ls_filename, ls_filename_tmp, TRUE) = 1 THEN //Alfee 09.14.2007 for performance
			IF FileExists(ls_filename_tmp) THEN 	
				//Open the file
				li_rtn = inv_ole_utils_doc.of_displayfile(ls_filename_tmp, FALSE) 
				is_opened_file = ls_filename_tmp
			END If
		End If
	END IF
	//Added By Mark Lee 07/20/12		add sys_tracking_log record
	gnv_tracking.of_tracking_doc(gnv_tracking.document_management,string(il_doc_id),'','','','add_doc_tracking',false)
	
END IF
ib_allowtrack = TRUE //01.19.2007
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
	IF li_rtn = -1 Then 				//Added By Mark Lee 05/29/2013 
		il_preview_doc_id = -1
		idc_preview_revision = 0
		il_preview_level = 1 //added by alfee 05.15.2007
	ElseIF li_rtn = 0 Then  //Added By Ken.Guo 05/30/2013 The value is 0 that the document was protected.
		il_preview_doc_id = il_doc_id
		idc_preview_revision = idc_revision
		il_preview_level = ll_level 		
	End IF 
ELSE
	il_preview_doc_id = il_doc_id
	idc_preview_revision = idc_revision
	il_preview_level = ll_level //added by alfee 05.15.2007
	//Merging data and Auto numbering
	IF Upper(tab_1.tabpage_browse.dw_browse.object.doc_type[tab_1.tabpage_browse.dw_browse.getrow()]) = "SELL" THEN
		ib_allowtrack = FALSE
		
		If ib_add_sell Then //Added By Ken.Guo 2009-06-29. Merge Requirement Field
			This.Event ue_merge_requirement()
		End IF
		THIS.Event ue_mergedata('auto') //check merging data
			
		inv_ole_utils_doc.of_auto_numbering() //numbering after merged		
		
		ib_allowtrack = TRUE
		IF Not inv_ole_utils_doc.of_isreadonly() THEN
			FileCopy(ls_filename_tmp, ls_filename,True)
		END IF
	END IF
	SetReDraw(TRUE)
	
	
	//Get change list //add If statement by alfee at 03.14.2007 for performance
	IF tab_1.tabpage_preview.dw_change.visible THEN of_getchanges()
	//Set review toolbar 
	inv_ole_utils_doc.of_trackchange_ini() //Initialize the review setting //05.09.2007 Alfee
	//-----Begin Modified by Alfee 11.22.2007 ------------------
	//inv_ole_utils_doc.of_setreviewstatus() 
	inv_ole_utils_doc.of_setreviewstatus(ib_allow_approve_reject)
	//-----End Modified ------------------------------------------
	//Set approve/reject button //add If statement by alfee at 03.14.2007 for performance
	IF tab_1.tabpage_preview.dw_change.visible THEN of_setreviewbutton()				
	//Get user rights on clause level
	of_getclauserights()
	//Clear undo list - 09.07.2007 
	inv_ole_utils_doc.of_undoclear( )
	
	//Set Saved property of the document - Alfee 03.28.2008
	inv_ole_utils_doc.of_setsaved(TRUE)	
END IF
SetReDraw(TRUE)

///////////////////////////////////////////////////////////////////////
//// Trigger off audit trail
///////////////////////////////////////////////////////////////////////
IF tab_1.tabpage_browse.dw_browse.object.level[tab_1.tabpage_browse.dw_browse.getrow()] = 1 THEN
	str_add_audit lstr_add_audit
	lstr_add_audit.doc_id = il_doc_id
	lstr_add_audit.revision = idc_revision
	lstr_add_audit.doc_ext = is_doc_ext
	lstr_add_audit.action = "Viewed"
	//Begin - Added By Mark Lee 07/10/12
	//	inv_dm_utils.of_add_audit_trail( lstr_add_audit )
	If of_check_track_viewing() = 1 then 
		inv_dm_utils.of_add_audit_trail( lstr_add_audit )
	End If
	//End - Added By Mark Lee 07/10/12

	//added by gavins 20120229
	of_insertdetail(  tab_1.tabpage_browse.dw_browse, tab_1.tabpage_browse.dw_detail  )

END IF

IF Isvalid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)

//If add a sell, prompt information message
IF ib_add_sell THEN 
	//IF ids_infomsg.Retrieve(il_doc_id) > 0 THEN
	IF ids_infomsg.Retrieve(il_doc_id, idc_revision) > 0 THEN //03.31.2008
		OpenwithParm(w_dm_clause_infomsg, ids_infomsg)
	END IF	
END IF
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
//	st_docinfo.text = tab_1.tabpage_browse.dw_browse.GetItemstring(tab_1.tabpage_browse.dw_browse.getrow() ,'doc_name_full' ) + '.' + &
//							tab_1.tabpage_browse.dw_browse.GetItemstring(tab_1.tabpage_browse.dw_browse.getrow() ,'doc_ext' )	
//	st_docinfo.text = tab_1.tabpage_browse.dw_browse.GetItemString(tab_1.tabpage_browse.dw_browse.getrow(),"Doc_name_full") 
	
	If IsValid( idw_LastDW ) Then //modify by gavins 20120208
		If idw_LastDW.GetRow( ) > 0 Then 
			st_docinfo.text =  idw_LastDW.GetItemString(idw_LastDW.getrow(),"Doc_name")  + ' ' + &
			 string(  idw_LastDW.GetItemNumber(idw_LastDW.getrow(),"Doc_id") ) + '.' 
			 If idw_LastDW.classname() = 'dw_detail' Then
				st_docinfo.Text +=  string(  idw_LastDW.GetItemNumber(idw_LastDW.getrow(),"audit_version"), '##0.0' )
			Else
				 st_docinfo.Text +=string(  idw_LastDW.GetItemNumber(idw_LastDW.getrow(),"revision"), '##0.0' )
			End If
		End If
	End If
	
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
//	st_docinfo.text = tab_1.tabpage_browse.dw_browse.GetItemString(tab_1.tabpage_browse.dw_browse.getrow(),"Doc_name_full") 
	If IsValid( idw_LastDW ) Then //modify by gavins 20120208
		If idw_LastDW.GetRow( ) > 0 Then 
			st_docinfo.text =  idw_LastDW.GetItemString(idw_LastDW.getrow(),"Doc_name")  + ' ' + &
			 string(  idw_LastDW.GetItemNumber(idw_LastDW.getrow(),"Doc_id") ) + '.' 
			 If idw_LastDW.classname() = 'dw_detail' Then
				st_docinfo.Text +=  string(  idw_LastDW.GetItemNumber(idw_LastDW.getrow(),"audit_version"), '##0.0' )
			Else
				 st_docinfo.Text +=string(  idw_LastDW.GetItemNumber(idw_LastDW.getrow(),"revision"), '##0.0' )
			End If
		End If
	End If
	//st_docinfo.text = tab_1.tabpage_browse.dw_browse.GetItemstring(tab_1.tabpage_browse.dw_browse.getrow() ,'doc_name_full' ) + '.' + &
	//						tab_1.tabpage_browse.dw_browse.GetItemstring(tab_1.tabpage_browse.dw_browse.getrow() ,'doc_ext' )
END IF	

///////////////////////////////////////////////////////////////////////
//// Trigger off audit trail
///////////////////////////////////////////////////////////////////////
//IF tab_1.tabpage_browse.dw_browse.object.level[tab_1.tabpage_browse.dw_browse.getrow()] = 1 THEN
If IsValid( idw_LastDW ) Then //modify by gavins 20120208
	If idw_LastDW.GetItemNumber( idw_LastDW.Getrow( ), 'level' ) = 1 Then
		str_add_audit lstr_add_audit
		lstr_add_audit.doc_id = il_doc_id
		lstr_add_audit.revision = idc_revision
		lstr_add_audit.doc_ext = is_doc_ext
		lstr_add_audit.action = "Viewed"
		//Begin - Added By Mark Lee 07/10/12
//		inv_dm_utils.of_add_audit_trail( lstr_add_audit )
		If of_check_track_viewing() = 1 then 
			inv_dm_utils.of_add_audit_trail( lstr_add_audit )
		End If
		//End - Added By Mark Lee 07/10/12
		//added by gavins 20120229
		of_insertdetail(  tab_1.tabpage_browse.dw_browse, tab_1.tabpage_browse.dw_detail  )
	End If
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
//	tab_1.tabpage_preview.uo_1.visible = false
	tab_1.tabpage_preview.uo_2.visible = false //Alfee 05.19.2008
	tab_1.tabpage_preview.ole_doc.visible = true
	//tab_1.tabpage_preview.dw_head.visible = true
	//-----Begin Modified by Alfee 05.25.2007--------
	//of_maponoff(ib_showclausemap)	
	of_mapresize(ib_showclausemap)
	//-----End Modified -----------------------------
ELSEIf lower(as_doctype) = 'xls' or lower(as_doctype) = 'xlsx' Then //Added By Ken.Guo 2009-09-07.
	//tab_1.tabpage_preview.uo_1.visible = false
	tab_1.tabpage_preview.uo_2.visible = false 
	tab_1.tabpage_preview.ole_doc.visible = true
	of_mapresize(False)	
Else
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
	tab_1.tabpage_preview.pb_approve.visible = false //07.09.2008
	tab_1.tabpage_preview.pb_reject.visible = false	//07.09.2008 
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

Integer i, j, li_rtn
Long ll_cnt, ll_doc_id, ll_clause_id
Decimal ldec_revision
String ls_bookmark, ls_bm[], ls_temp_file
Boolean lb_found
Oleobject lole_word, lole_document

//lole_word = Create Oleobject
//lole_document = Create Oleobject

//If no clause existed in current revision, then return
ll_cnt = tab_1.tabpage_preview.dw_clause.RowCount()
IF ll_cnt < 1 THEN RETURN 1

ll_doc_id = tab_1.tabpage_preview.dw_clause.GetItemNumber(1,"doc_id")
ldec_revision = tab_1.tabpage_preview.dw_clause.GetItemDecimal(1,"revision")

//Modified By Ken.Guo 2010-04-29. Move below script to function inv_dm_utils.of_update_clausemap()
inv_dm_utils.of_update_clausemap(ll_doc_id,ldec_revision, adec_new_revision, tab_1.tabpage_preview.dw_clause, as_filename)
////Copy to a temporary file
//IF not FileExists(as_filename) THEN RETURN -1
//ls_temp_file = inv_ole_utils_doc.is_agreement_path + "tem_" + String(Rand(1000)) +".doc"
//IF FileCopy(as_filename, ls_temp_file, TRUE) < 0 THEN RETURN -1 
//
////Open the file with readonly property in a new word application
//IF lole_word.Connecttonewobject("word.application") <> 0 THEN
//	Destroy lole_word //Alfee 01.17.2008
//	Destroy lole_document //Alfee 01.17.2008
//	messagebox('Client Error', 'This application could not connect to Microsoft Word. Please make sure it is properly installed.')
//	RETURN -1
//END IF
//lole_word.Visible = FALSE
//
//Try
//lole_word.Application.NormalTemplate.Saved = TRUE //Alfee 01.17.2008	
//lole_word.Application.Documents.Open(ls_temp_file,FALSE,TRUE)
//lole_document = lole_word.ActiveDocument
//Catch (Throwable th)
//	//----Begin Modified by Alfee 01.17.2008----
//	f_word_destroy(lole_word, "")
//	Destroy lole_document
//	RETURN -1	
//	/*IF Not IsValid(lole_document) OR IsNull(lole_document) THEN 
//		lole_word.Quit(0)
//		lole_word.DisconnectObject( )
//		Destroy lole_word
//		RETURN -1
//	END IF*/
//	//-----End Modified ------------------------
//End Try
//
//Try
////Clear invalid bookmark(s)
//FOR i = 1 TO lole_document.Content.Bookmarks.Count
//	ls_bookmark = lole_document.Content.Bookmarks.Item[i].Name
//	IF Lower(Left(ls_bookmark,7)) <> "clause_" THEN
//		lole_document.Content.bookmarks.item[i].Delete()
//		i --
//	END IF
//NEXT
//
////Get clause bookmark(s) name in order
//FOR i = 1 TO lole_document.Content.Bookmarks.Count
//	ls_bm[i] = lole_document.Content.Bookmarks.Item(i).Name
//NEXT
//
//Catch (Throwable th2)
//	//----Begin Modified by Alfee 01.17.2008----
//	/* lole_word.Quit(0)
//	lole_word.DisconnectObject( )
//	Destroy lole_word 	*/
//	f_word_destroy(lole_word, "")
//	//----End Modified ---------------------------
//	Destroy lole_document
//	RETURN -1	//05.28.2007
//End Try
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
//	ll_clause_id = tab_1.tabpage_preview.dw_clause.object.ctx_acp_clause_id[i]
//	lb_found = False
//	For j =  1 to Upperbound(ls_bm)
//		IF ls_bm[j] = "clause_" + string(ll_clause_id) THEN
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
//lole_document.Close(0)
//lole_word.Quit(0)
//lole_word.DisconnectObject( )
//Destroy lole_document
//Destroy lole_word
//
//Refresh user rights on clause level

of_getclauserights()

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

Integer i,j, li_rtn
Long ll_doc_id, ll_clause_id, ll_cnt
Decimal ldec_revision
Boolean lb_found 
String ls_bookmark[]

//If no clause for new revision, then return
ll_cnt = tab_1.tabpage_preview.dw_clause.RowCount()
IF ll_cnt < 1 THEN RETURN -1

//Get bookmarks from document
inv_ole_utils_doc.of_getbookmarks(ls_bookmark)

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
	ll_clause_id = tab_1.tabpage_preview.dw_clause.getitemnumber(i,"ctx_acp_clause_id")
	lb_found = False
	For j =  1 to Upperbound(ls_bookmark)
		IF ls_bookmark[j] = "clause_" + string(ll_clause_id) THEN
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

tab_1.tabpage_preview.dw_clause.accepttext()
li_rtn = tab_1.tabpage_preview.dw_clause.Update() 
//--------Appeon Begin by alfee at 04.13.2007--------
If li_rtn < 0 Then
	MessageBox("Alert Message","The Clause Map update failed! ~r~n" +SQLCA.SQLErrText)
End If
//--------Appeon End --------------------------------

//Refresh user rights on clause level
//---------Begin Modified by Alfee 08.23.2007------------------
//<$Reason>It will be called by ue_post_doc_changed event in ue_save
IF adec_new_revision = ldec_revision THEN of_getclauserights() 
//of_getclauserights()
//---------End Modified ---------------------------------------

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
//----------Begin Modified by Alfee 05.09.2007----------------
//return inv_ole_utils_doc.of_mergefile(al_clauseid,as_rights)
Integer li_rtn
Long ll_pagebreak[],ll_AppendParaGraph[] //Added By Ken.Guo 2010-10-22.

ib_allowtrack = FALSE
//----------Begin Modified by Alfee 05.28.2007 --------------
of_get_pagebreak(al_clauseid, ll_pagebreak[],ll_AppendParaGraph[])
li_rtn = inv_ole_utils_doc.of_mergefile(al_clauseid, as_rights, ll_pagebreak[],ll_AppendParaGraph[])
//li_rtn = inv_ole_utils_doc.of_mergefile(al_clauseid,as_rights)
//----------End Modified ------------------------------------
ib_allowtrack = TRUE


RETURN li_rtn
//----------End Modified--------------------------------------
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
//---------Begin Added by Alfee 11.22.2007-----------
IF NOT ib_allow_approve_reject THEN
	tab_1.tabpage_preview.cb_approve.Enabled = FALSE
	tab_1.tabpage_preview.cb_reject.Enabled = FALSE
	tab_1.tabpage_preview.pb_approve.Enabled = FALSE //Added by Ken.Guo on 2009-02-07
	tab_1.tabpage_preview.pb_reject.Enabled = FALSE	 //Added by Ken.Guo on 2009-02-07								
	RETURN 
END IF
//---------End Added --------------------------------

CHOOSE CASE lower(is_doc_right) 
	CASE  "no editing", "editing with approval" ,"no access"//no "", by alfee at 03.13.2007
		tab_1.tabpage_preview.cb_approve.Enabled = FALSE
		tab_1.tabpage_preview.cb_reject.Enabled = FALSE
		tab_1.tabpage_preview.pb_approve.Enabled = FALSE //Added by Ken.Guo on 2009-02-07
		tab_1.tabpage_preview.pb_reject.Enabled = FALSE	 //Added by Ken.Guo on 2009-02-07							
	CASE ELSE		
		//Set button on clause level
		CHOOSE CASE lower(is_clause_right)
			CASE "full access",""  //"",by alfee at 03.13.2007
				IF tab_1.tabpage_preview.ole_doc.Object.ActiveDocument.Revisions.Count > 0 Then
					tab_1.tabpage_preview.cb_approve.Enabled = TRUE
					tab_1.tabpage_preview.cb_reject.Enabled = TRUE
					tab_1.tabpage_preview.pb_approve.Enabled = TRUE //07.09.2008
					tab_1.tabpage_preview.pb_reject.Enabled = TRUE	//07.09.2008					
				ELSE
					tab_1.tabpage_preview.cb_approve.Enabled = FALSE
					tab_1.tabpage_preview.cb_reject.Enabled = FALSE
					tab_1.tabpage_preview.pb_approve.Enabled = FALSE //07.09.2008
					tab_1.tabpage_preview.pb_reject.Enabled = FALSE	//07.09.2008					
				END IF
			CASE "no editing","editing with approval","no adding","adding with approval"
				tab_1.tabpage_preview.cb_approve.Enabled = FALSE
				tab_1.tabpage_preview.cb_reject.Enabled = FALSE
				tab_1.tabpage_preview.pb_approve.Enabled = FALSE //07.09.2008
				tab_1.tabpage_preview.pb_reject.Enabled = FALSE	//07.09.2008					
			CASE else
				tab_1.tabpage_preview.cb_approve.Enabled = FALSE
				tab_1.tabpage_preview.cb_reject.Enabled = FALSE	
				tab_1.tabpage_preview.pb_approve.Enabled = FALSE //07.09.2008
				tab_1.tabpage_preview.pb_reject.Enabled = FALSE	//07.09.2008					
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

public subroutine of_getchanges (integer ai_index);//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_dm_data.of_getchanges(ai_index)
// $<argument>Integer  ai_index
// $<returns> 
// $<description>Reset change list according to the changed revision index in document 
//////////////////////////////////////////////////////////////////////
// $<add> 05.11.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////

Long ll_cnt
integer li_rtn, li_newpageno, li_newpagecnt

ll_cnt = tab_1.tabpage_preview.dw_change.rowcount()

ib_locate_change = False
tab_1.tabpage_preview.dw_change.setredraw(false)
//---------Begin Modified by Alfee 08.09.2007----------------------
//tab_1.tabpage_preview.dw_change.DeleteRow(ai_index)
li_newpageno = Integer(tab_1.tabpage_preview.uo_scrollbar.st_page.Text)
li_newpagecnt = Integer(tab_1.tabpage_preview.uo_scrollbar.st_count.Text)
li_rtn = inv_ole_utils_doc.of_getchanges(ai_index, li_newpageno, li_newpagecnt, tab_1.tabpage_preview.dw_change)
IF li_rtn > 0 THEN
	//Reset the page info
	of_setpagestatus(li_newpageno, li_newpagecnt)
ELSEIF li_rtn = 0 THEN 
	//Go to prior page if no row existed in current page
	IF li_newpageno > 1 THEN tab_1.tabpage_preview.uo_scrollbar.cb_prior.event clicked()
END IF
//---------End Modified ---------------------------------------------
tab_1.tabpage_preview.dw_change.setredraw(true)
ib_locate_change = True

end subroutine

public function integer of_refreshmap (boolean ab_bookmarkchanged, integer ai_revisionindex);//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_dm_data.of_refreshmap()
// $<arguments> Boolean ab_bookmarkchanged; 
// $<arguments> integer ai_revisionindex: -1 - All,  >0 - specified index
// $<returns> integer
// $<description>used only for approve/reject operation
// $<description>refresh clause and changed text map list
//////////////////////////////////////////////////////////////////////
// $<add> 01.12.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////
//Integer li_rtn
string ls_bookmark[]
long i,j,ll_cnt,ll_clause_id
boolean lb_found

//For performance tuning, don't do locating firstly.
tab_1.tabpage_preview.dw_clause.setredraw(False)

//----------Begin commented by alfee 05.11.2007-----
////Retrieve and filter clauses
/*//tab_1.tabpage_preview.dw_clause.retrieve()
li_rtn = of_filter_clause(il_doc_id,idc_revision)*/
//----------End commented--------------------------------

//Refresh clause---needed only if bookmarks' count changed
ll_cnt = tab_1.tabpage_preview.dw_clause.RowCount()
//IF ll_cnt > 0 THEN 
IF ab_bookmarkchanged and ll_cnt > 0 THEN //05.11.2007 Alfee
	//Get bookmarks from document
	inv_ole_utils_doc.of_getbookmarks(ls_bookmark)	
	//update dw_clause according to bookmarks
	For i =  1 to ll_cnt
		ll_clause_id = tab_1.tabpage_preview.dw_clause.getitemnumber(i,"ctx_acp_clause_id")
		lb_found = False
		For j =  1 to Upperbound(ls_bookmark)
			IF ls_bookmark[j] = "clause_" + string(ll_clause_id) THEN
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
	//Refresh clause status and user rights on clause level
	of_getclauserights() 
END IF
tab_1.tabpage_preview.dw_clause.setredraw(True)

//Refresh the changed text list
//-----------Begin Modified By Alfee 05.11.2007-------------
//<$Reason> for performance tuning
IF ai_revisionindex > 0 THEN
	of_getchanges(ai_revisionindex)
ELSE
	of_getchanges()	
END IF

//Refresh clauses' red/blue status
of_refreshclausestatus()

/*tab_1.tabpage_preview.dw_change.setredraw(False)
tab_1.tabpage_preview.dw_change.reset()
This.of_getchanges()
tab_1.tabpage_preview.dw_change.setredraw(True)

//Refresh button's status
of_setreviewbutton() // this fun needn't be called here */
//-----------End Modified------------------------------------

RETURN 1


end function

public function integer of_refreshclausestatus ();//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_dm_data.of_refreshclausestatus()
// $<arguments>
// $<returns> integer
// $<description>Refresh clause red/blue status
// $<description>NOTE: THIS FUNCTION MUST ONLY USED AFTER APPROVE/REJECT OPERATION!!!!
//////////////////////////////////////////////////////////////////////
// $<add> 05.11.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////

Long ll_cnt, i, ll_clauseid
String ls_clausename, ls_bookmark
OLEObject lole_document

ll_cnt = tab_1.tabpage_preview.dw_clause.RowCount()
IF ll_cnt < 1 THEN RETURN -1

TRY
lole_document = tab_1.tabpage_preview.ole_doc.Object.ActiveDocument

tab_1.tabpage_preview.dw_clause.setredraw(false)
FOR i = 1 TO ll_cnt
	ll_clauseid = tab_1.tabpage_preview.dw_clause.GetItemNumber(i, "ctx_acp_clause_id")
	ls_bookmark = "clause_" + String(ll_clauseid)
	IF lole_document.Content.Bookmarks.Exists(ls_bookmark) THEN
		IF lole_document.Content.Bookmarks.Item(ls_bookmark).Range.Revisions.Count = 0 THEN
			tab_1.tabpage_preview.dw_clause.object.disp_flag[i] = -1
		ELSEIF tab_1.tabpage_preview.dw_clause.object.disp_flag[i] = -1 THEN
			tab_1.tabpage_preview.dw_clause.object.disp_flag[i] = 0 //red
		END IF
	END IF
NEXT
tab_1.tabpage_preview.dw_clause.setredraw(true)
CATCH (THROWABLE th)
	MessageBox("Warning","Refresh clause status failed due to " + th.text, Exclamation!)	
	tab_1.tabpage_preview.dw_clause.setredraw(true)	
END TRY

RETURN 1
end function

public function integer of_mapresize (boolean ab_flag);//////////////////////////////////////////////////////////////////////
// $<function>of_mapresize
// $<arguments>  value   boolean    ab_flag              
// $<returns> (none)
// $<description>Resize according to the clause map
//////////////////////////////////////////////////////////////////////
// $<add> 05.25.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////
Integer li_setting
String ls_type

tab_1.tabpage_preview.SetRedraw(false)

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
tab_1.tabpage_preview.pb_approve.Visible = ab_flag //07.09.2008
tab_1.tabpage_preview.pb_reject.Visible = ab_flag	//07.09.2008	
tab_1.tabpage_preview.cb_original.Visible = ab_flag
tab_1.tabpage_preview.dw_clause.Enabled = ab_flag
tab_1.tabpage_preview.dw_change.Enabled = ab_flag
tab_1.tabpage_preview.uo_scrollbar.Visible = ab_flag //Alfee 07.23.2007

IF ab_flag and tab_1.tabpage_preview.dw_clause.GetRow() > 0 THEN
	tab_1.tabpage_preview.cb_original.Enabled = True
ELSE
	tab_1.tabpage_preview.cb_original.Enabled = False
END IF

li_setting = of_get_app_setting("set_51","I")
ls_type = Lower(tab_1.tabpage_browse.dw_browse.getitemstring(tab_1.tabpage_browse.dw_browse.getrow(),'doc_type'))

//Hide clause map if buy side setting or buy/other side document
if li_setting = 3 or ls_type = "Buy" or ls_type = "Other" then
	tab_1.tabpage_preview.cb_original.Visible = false
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_clausemap,'toolbaritemtext', "Change List" )
	if tab_1.tabpage_preview.dw_clause.y <> tab_1.tabpage_preview.dw_change.y then
		tab_1.tabpage_preview.gb_map.text = "Change List"
		tab_1.tabpage_preview.dw_clause.visible = false
		tab_1.tabpage_preview.dw_change.height = tab_1.tabpage_preview.dw_change.height + tab_1.tabpage_preview.dw_clause.height 
		tab_1.tabpage_preview.dw_change.y = tab_1.tabpage_preview.dw_clause.y
	end if
else
	tab_1.tabpage_preview.cb_original.Visible = ab_flag
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_clausemap,'toolbaritemtext', "Clause Map" )
	if tab_1.tabpage_preview.dw_clause.y = tab_1.tabpage_preview.dw_change.y then
		tab_1.tabpage_preview.gb_map.text = "Clause Map"
		tab_1.tabpage_preview.dw_clause.visible = ab_flag
		tab_1.tabpage_preview.dw_change.height = tab_1.tabpage_preview.dw_change.height - tab_1.tabpage_preview.dw_clause.height 
		tab_1.tabpage_preview.dw_change.y = tab_1.tabpage_preview.dw_clause.y + tab_1.tabpage_preview.dw_clause.height 
	end if
end if

tab_1.tabpage_preview.SetRedraw(true)

RETURN 1


end function

public function boolean of_havemergefield (long al_clauseid[]);//added by Alfee 06.22.2007
RETURN inv_ole_utils_doc.of_havemergefield(al_clauseid)

end function

public function integer of_getnewclauseid (long al_clauseid[], ref long al_newclauseid[]);//added by Alfee 06.22.2007

RETURN inv_ole_utils_doc.of_getnewclauseid(al_clauseid, al_newclauseid)


end function

public function integer of_setpagestatus (integer ai_pageno, integer ai_pagecnt);//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_dm_data.of_setpagestatus()
// $<arguments>
//		value	integer	ai_pageno, ai_pagecnt	
// $<returns> integer
// $<description>Set changed text page info
//////////////////////////////////////////////////////////////////////
// $<add> 07.24.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////
tab_1.tabpage_preview.uo_scrollbar.st_page.Text = String(ai_pageno)
tab_1.tabpage_preview.uo_scrollbar.st_count.Text = String(ai_pagecnt)

IF ai_pagecnt = 0 THEN
	tab_1.tabpage_preview.uo_scrollbar.cb_first.Enabled = FALSE
	tab_1.tabpage_preview.uo_scrollbar.cb_prior.Enabled = FALSE
	tab_1.tabpage_preview.uo_scrollbar.cb_next.Enabled = FALSE
	tab_1.tabpage_preview.uo_scrollbar.cb_last.Enabled = FALSE
ELSE
	IF ai_pageno = 1 THEN
		tab_1.tabpage_preview.uo_scrollbar.cb_first.Enabled = FALSE
		tab_1.tabpage_preview.uo_scrollbar.cb_prior.Enabled = FALSE
	ELSE
		tab_1.tabpage_preview.uo_scrollbar.cb_first.Enabled = TRUE
		tab_1.tabpage_preview.uo_scrollbar.cb_prior.Enabled = TRUE	
	END IF
	IF ai_pagecnt = ai_pageno THEN
		tab_1.tabpage_preview.uo_scrollbar.cb_next.Enabled = FALSE
		tab_1.tabpage_preview.uo_scrollbar.cb_last.Enabled = FALSE
	ELSE
		tab_1.tabpage_preview.uo_scrollbar.cb_next.Enabled = TRUE
		tab_1.tabpage_preview.uo_scrollbar.cb_last.Enabled = TRUE		
	END IF
END IF
	
RETURN 1
	
end function

public function integer of_restore_clause ();// Restore clauses with no editing right - Alfee 09.21.2007
Integer li_ret

If Lower(is_doc_ext) <> 'doc' Then Return 1 //Added By Ken.Guo 2009-09-07.

SetRedraw(FALSE)
//Replace clauses


//Modified By Ken.Guo 12/22/2011
//li_ret = inv_ole_utils_doc.of_restore_clausenew(il_doc_id, idc_revision, is_doc_ext, tab_1.tabpage_preview.ole_1) 
w_email_edit lw_email_edit
Open(lw_email_edit)
li_ret = inv_ole_utils_doc.of_restore_clausenew(il_doc_id, idc_revision, is_doc_ext, lw_email_edit.ole_word) 
lw_email_edit.ole_word.object.close()
Close(lw_email_edit)

IF li_ret > 0 THEN
	//Merge Data
	IF inv_ole_utils_doc.of_havemergefield('no editing') THEN 
		inv_ole_utils_doc.of_setmergestatus(FALSE)
		This.Event ue_mergedata('auto')
	END IF
	
	//Auto Numbering
	inv_ole_utils_doc.of_auto_numbering()
ELSEIF li_ret < 0 THEN
	IF li_ret = -1 THEN MessageBox("Save Document","Can't save a document due to failed to generating a temporary file!")
END IF			

//Clear undo list
inv_ole_utils_doc.of_undoclear()

SetRedraw(TRUE)

RETURN li_ret
end function

public function integer of_set_checkrights (boolean ab_allow);//Added by Alfee 09.21.2007

ib_allowcheckrights = ab_allow

RETURN 1
end function

public function integer of_refreshdata ();//////////////////////////////////////////////////////////////////////
// $<event>u_tabpg_dm_data.of_refreshdata
// $<arguments>
//		value	integer		
// $<returns> integer 
// $<description>Refresh data in document(dynamic adding of clauses)
//////////////////////////////////////////////////////////////////////
// $<add> 11.12.2007 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////

str_pass lstr_pass
Long ll_from_template_id,ll_ctx_id
Boolean lb_statuschanged_ori
DataStore lds_clause_rules_result

SetPointer(HourGlass!) //01.21.2008

lds_clause_rules_result = Create DataStore
lds_clause_rules_result.DataObject = 'd_dm_template_clause_rules_result'

//Get template id
Select from_templete_id into :ll_from_template_id From ctx_am_document Where doc_id = :il_preview_doc_id And base_type = 1 ;

lb_statuschanged_ori = inv_ole_utils_doc.of_isstatuschanged( ) 
inv_ole_utils_doc.of_setstatuschanged(FALSE) 

//Refersh clauses if the dynamic adding clause rules are valid
IF gnv_data.of_findrow('template_clause_rules', "ctx_acp_template_id = " + String(ll_from_template_id)) > 0 THEN
	//Get clause rules' result into datastore	if rules existed
	if iw_parent.classname() = 'w_contract' Then
		ll_ctx_id = inv_contract_details.of_get_ctx_id()
	Else
		ll_ctx_id = tab_1.tabpage_browse.dw_browse.getitemnumber(tab_1.tabpage_browse.dw_browse.getrow(),'ctx_id')
	End If
	inv_dm_utils.of_get_clause_rule_reuslts(ll_ctx_id, ll_from_template_id, lds_clause_rules_result)
	SetRedraw(FALSE)
	lstr_pass.s_string = 'invisible'
	lstr_pass.w_parent_window = iw_parent
	IF OpenwithParm(w_dm_add_clause, lstr_pass) = 1 THEN 
		//Synchronize the selected clauses
		w_dm_add_clause.of_update_document(ll_from_template_id, lds_clause_rules_result )
		IF IsValid(w_dm_add_clause) THEN Close(w_dm_add_clause)
	END IF
	SetRedraw(True)
END IF

inv_ole_utils_doc.of_setstatuschanged(lb_statuschanged_ori) 

Destroy lds_clause_rules_result

RETURN 1


end function

public function boolean of_issaved ();//Added by Alfee 03.28.2008
Boolean lb_modified = FALSE

CHOOSE CASE Lower(is_doc_ext)
	CASE 'doc','xls','xlsx'
		lb_modified = inv_ole_utils_doc.of_ismodified( )
	CASE 'bmp','tif','tiff','jpg','gif','pdf'//'tif','tiff','jfk','bmp','jpc','jpe','jpeg','pcx','dcx','xif','gif','wif','ibk'
		//-----------Begin Modified by Alfee on 05.19.2008 ----------------	
		//		lb_modified = tab_1.tabpage_preview.uo_1.of_ismodified( )
		IF gi_imageocx = 1 THEN //Imaging 360
			//lb_modified = tab_1.tabpage_preview.uo_1.of_ismodified( )
		ELSE	//new Image OCX
			//lb_modified = FALSE
			lb_modified = tab_1.tabpage_preview.uo_2.of_ismodified( ) //Modified By Ken.Guo 2009-11-05
		END IF
		//-----------End Modified -----------------------------------------				
		
END CHOOSE

//if it needs to be saved
IF lb_modified AND il_preview_doc_id = il_doc_id AND idc_preview_revision = idc_revision AND &
	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_save0.enabled THEN
	RETURN FALSE	
END IF

RETURN TRUE
end function

public function integer of_setparent (menu am_menu);//Alfee 07.15.2008

am_menu.dynamic of_setParent(this)

RETURN 1
end function

public function integer of_parse_searchtext (string as_search_text, ref string as_rtn_text[]);//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_dm_data.of_parse_searchtext()
// $<arguments>string as_search_text, Ref string as_rtn_text[]
// $<returns> integer
// $<description>Parse the search text in contract global search to
// $<description>the string to find in document
//////////////////////////////////////////////////////////////////////
// $<add> 07.18.2008 by Alfee (Contract Logix Document Management)
//////////////////////////////////////////////////////////////////////
Long ll_pos, ll_begin, ll_dlen, i
String ls_searchtext, ls_char
String ls_delimiter[] = {" and ", " NEAR ", " or "}

IF IsNull(as_search_text) OR Len(Trim(as_search_text)) < 1 THEN RETURN 0

ls_searchtext = as_search_text

//Find delimiter in Loop 
FOR i = 1 to UpperBound(ls_delimiter)
	ll_pos = Pos(ls_searchtext, ls_delimiter[i]) 
	IF ll_pos > 0 THEN 
		ll_dlen = Len(ls_delimiter[i]) 
		//Parse the search text into array with the found delimter
		DO 
			as_rtn_text[UpperBound(as_rtn_text) + 1] = Left(ls_searchtext, ll_pos - 1)
			ls_searchtext = Mid(ls_searchtext, ll_pos + ll_dlen)	
			ll_pos = Pos(ls_searchtext, ls_delimiter[i]) 						
		LOOP WHILE ll_pos > 0
		//Exit if a delimiter found
		EXIT
	END IF
NEXT
as_rtn_text[UpperBound(as_rtn_text) + 1] = ls_searchtext

//Get rid of quotes and wildcard(*) - Alfee 07.22.2008
FOR i = 1 to UpperBound(as_rtn_text)
	IF IsNull(as_rtn_text[i]) OR Len(Trim(as_rtn_text[i])) < 2 THEN CONTINUE
	//for wildcard *
	DO While (right(as_rtn_text[i], 1) = '*')
		as_rtn_text[i] = Left(as_rtn_text[i], Len(as_rtn_text[i]) - 1)
	LOOP
	//for quotes
	ls_char = Left(as_rtn_text[i], 1)	
	DO WHILE (ls_char = '"' OR ls_char = "'") 
		IF ls_char <> Right(as_rtn_text[i], 1) THEN EXIT
		as_rtn_text[i] = Mid(as_rtn_text[i], 2, Len(as_rtn_text[i]) - 2)
		ls_char = Left(as_rtn_text[i], 1)
	LOOP	 
NEXT

RETURN 1
end function

public function integer of_get_docinfo (ref str_doc_info astr_docinfo);//Add function by jervis 02.24.2009
//Get Document info
long ll_row

ll_row  = tab_1.tabpage_browse.dw_browse.getrow()
if ll_row > 0 then
	astr_docinfo.ver_num = idc_revision
	astr_docinfo.ver_date = tab_1.tabpage_browse.dw_browse.GetItemDate(ll_row,'create_date')
	astr_docinfo.doc_name = tab_1.tabpage_browse.dw_browse.GetItemString(ll_row,'doc_name')
	astr_docinfo.create_by = tab_1.tabpage_browse.dw_browse.GetItemString(ll_row,'create_by')
else
	return -1
end if
return 1
end function

public function integer of_goto_row (long al_doc_id);//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_dm_dataof_goto_row()
// $<arguments>
//		value	long	al_doc_id		
// $<returns> integer
// $<description>
// $<description> Highlight special document row
//////////////////////////////////////////////////////////////////////
// $<add> 2009-04-17 by Ken.Guo
//////////////////////////////////////////////////////////////////////

long ll_find
ll_find = Tab_1.tabpage_browse.dw_browse.find('doc_id = ' + String(al_doc_id),1,Tab_1.tabpage_browse.dw_browse.rowcount())
If ll_find > 0 Then
	Tab_1.tabpage_browse.dw_browse.SetRow(ll_find)
	Tab_1.tabpage_browse.dw_browse.ScrolltoRow(ll_find)
	Tab_1.tabpage_browse.dw_browse.SelectRow(0,False)
	Tab_1.tabpage_browse.dw_browse.SelectRow(ll_find,True)
Else 
	Return -1
End If

Return 1
end function

public function integer of_open_document (long al_doc_id);//====================================================================
// Function: of_open_document()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    long    al_doc_id
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-07-17
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Contractlogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long ll_Find

if IsValid(gw_Contract) and gb_IsDocMode then
	gw_Contract.tab_contract_details.tabpage_search.Visible = false
	gw_Contract.tab_contract_details.tabpage_details.Visible = false
	gw_Contract.tab_contract_details.tabpage_requirements.Visible = false
	gw_Contract.tab_contract_details.tabpage_contacts.Visible = false
	gw_Contract.tab_contract_details.tabpage_locations.Visible = false
	gw_Contract.tab_contract_details.tabpage_orgabizations.Visible = false
	gw_Contract.tab_contract_details.tabpage_fee_schedules.Visible = false
	gw_Contract.tab_contract_details.tabpage_fee_sched2.Visible = false
	gw_Contract.tab_contract_details.tabpage_action_items.Visible = false
	gw_Contract.tab_contract_details.tabpage_multi.Visible = false
end if

ll_Find = Tab_1.tabpage_browse.dw_browse.find('doc_id = ' + String(al_doc_id),1,Tab_1.tabpage_browse.dw_browse.rowcount())
If ll_Find > 0 Then
	Tab_1.tabpage_browse.dw_browse.SetRow(ll_Find)
	Tab_1.tabpage_browse.dw_browse.ScrolltoRow(ll_Find)
	Tab_1.tabpage_browse.dw_browse.SelectRow(0,False)
	Tab_1.tabpage_browse.dw_browse.SelectRow(ll_Find,True)
	Tab_1.SelectTab(2)
	If gb_IsDocMode Then	tab_1.tabpage_browse.Visible = false
End If

w_mdi.WindowState = Maximized!
w_mdi.Show()
gw_Contract.of_Show()

Return 1

end function

public function string of_gen_web_link ();//////////////////////////////////////////////////////////////////////
// $<function>w_dm_email_document_send::of_gen_web_link()
// $<arguments>(None)
// $<returns> string
// $<description>
// $<description> Generate Web Link
//////////////////////////////////////////////////////////////////////
// $<add> 2009-03-27 by Ken.Guo
//////////////////////////////////////////////////////////////////////


String 	ls_weblink_root,ls_web_link,ls_ie_url
String 	ls_file_name,ls_user_email,ls_cache_name
Integer 	i
long		ll_ctx_id
Long 		ll_check_sn
String 	ls_ctx_link

ll_ctx_id = inv_contract_details.of_get_ctx_id( )
if iw_parent.classname() = 'w_contract' Then
	ll_ctx_id = inv_contract_details.of_get_ctx_id()
Else
	ll_ctx_id = tab_1.tabpage_browse.dw_browse.getitemnumber(tab_1.tabpage_browse.dw_browse.getrow(),'ctx_id')
End If

//Get web_link name and cache name if they have been set in Web Link Settings Window.
Select web_link_name,cache_name Into :ls_weblink_root,:ls_cache_name From Icred_settings;

//If not exists in database, generate it from current URL
If isnull(ls_weblink_root) or ls_weblink_root = '' Then
	ls_ie_url = AppeonGetIEURL()
	If left(lower(ls_ie_url),7) = 'http://' Then
		ls_ie_url = 'https://' + Mid(ls_ie_url,8,len(ls_ie_url))
	End If
	//AppeonGetIEURL() will return the current web root URL, e.g. 'http://192.0.3.37/test_ken/'
	ls_ie_url = Mid(ls_ie_url,1,Len(ls_ie_url) - 1) //Cut last '/'
	ls_weblink_root = Mid(ls_ie_url,1,LastPos(ls_ie_url,'/'))
	ls_weblink_root = ls_weblink_root + 'fileservice/index.aspx'
Else
	If Right(ls_weblink_root,1) = '/' Then
		ls_weblink_root += 'index.aspx'
	Else
		ls_weblink_root += '/index.aspx'
	End If
End If

If isnull(ls_cache_name) or ls_cache_name = '' Then
	If gs_cachename <> '' Then
		ls_cache_name = gs_cachename
	Else
		//Failed to get cache name/database name.
		Messagebox('IntelliSoft Error -1','Failed to get cache name, please call support.')  //(Appeon)Harry 01.28.2014 - V142 ISG-CLX  Modify "ContractLogix" to "IntelliSoft"
		Return ""
	End If
End If

//Gen check SN
For i = 1 To Len(ls_cache_name)
	ll_check_sn += Asc(Mid(Lower(ls_cache_name),i,1))
Next
ll_check_sn += This.il_doc_id + This.idc_revision * 10

//Gen Web Link
ls_web_link = ls_weblink_root + '?dbname=' + lower(ls_cache_name) + '&doc_id=' + String(This.il_doc_id) + &
						'&rev_id=' + String(This.idc_revision) + '&ck=' + String(ll_check_sn)

//Gen CTX Link
If gs_cachename <> '' Then
	ls_ctx_link = AppeonGetIEURL() + '?' + gs_cachename + '&' + String(ll_ctx_id) + '&91&' + String(This.il_doc_id)
Else
	ls_ctx_link = AppeonGetIEURL() + '?' + '&' + String(ll_ctx_id) + '&91&'  +   String(This.il_doc_id)	 
End If

//Return WEB Link
Return ls_web_link

end function

public function integer of_preview_excel ();//String ls_filename
//ls_filename = inv_dm_utils.of_download_file( il_doc_id, idc_revision)
//
long ll_row, ll_level//
integer li_rtn
string ls_doc_ext, ls_filename, ls_filename_tmp


//initilize the switch of document onstatuschanged event //By Alfee 05.15.2007
inv_ole_utils_doc.of_setstatuschanged(TRUE)

//Reset preview tabage if current file not specified
//ll_row  = tab_1.tabpage_browse.dw_browse.getrow()//modify by gavins 20120208
If IsValid( idw_LastDW ) Then ll_row = idw_LastDW.GetRow( )
IF ll_row < 1 THEN
	inv_ole_utils_doc.of_displayfile_excel(ls_filename,TRUE)
	RETURN 1
END IF

//Refresh doc info-jervis 02.26.2009
//st_docinfo.text = tab_1.tabpage_browse.dw_browse.GetItemString(ll_row,"Doc_name") + " - Version: " + string(idc_revision)
//st_docinfo.text = tab_1.tabpage_browse.dw_browse.GetItemString(tab_1.tabpage_browse.dw_browse.getrow(),"Doc_name_full") 
If IsValid( idw_LastDW ) Then //modify by gavins 20120208
	If idw_LastDW.GetRow( ) > 0 Then 
		st_docinfo.text =  idw_LastDW.GetItemString(idw_LastDW.getrow(),"Doc_name")  + ' ' + &
		 string(  idw_LastDW.GetItemNumber(idw_LastDW.getrow(),"Doc_id") ) + '.' 
		  If idw_LastDW.classname() = 'dw_detail' Then
			st_docinfo.Text +=  string(  idw_LastDW.GetItemNumber(idw_LastDW.getrow(),"audit_version"), '##0.0' )
		Else
			 st_docinfo.Text +=string(  idw_LastDW.GetItemNumber(idw_LastDW.getrow(),"revision"), '##0.0' )
		End If
	End If
End If
//Check whether this file is already opened in preview tabpage
//--------Begin Modified by Alfee 05.15.2007----------------------------------
//<$Reason> Different level with differnt user rights control
//ll_level = tab_1.tabpage_browse.dw_browse.getitemnumber(ll_row,'level')//modify by gavins 20120208
ll_level = idw_LastDW.GetItemNumber( ll_Row, 'level' )
IF il_doc_id = il_preview_doc_id AND idc_revision = idc_preview_revision AND ll_level = il_preview_level THEN 
//IF il_doc_id = il_preview_doc_id AND idc_revision = idc_preview_revision THEN 
//--------End Modified by ----------------------------------------------------
	RETURN 1
END IF

//Choose OLE control for different type of document
of_selectole(is_doc_ext)

//Get the file 
//ls_filename = inv_ole_utils_doc.of_Getfile(il_doc_id,idc_revision,is_doc_ext,idt_modify_date)
ls_filename = inv_dm_utils.of_download_file( il_doc_id, idc_revision)
 

SetReDraw(FALSE)
// Added by davis, make sure this file can't be occupy, so save as the file
ib_allowtrack = FALSE //01.19.2007 
IF FileExists(ls_filename) THEN
	//Get and Set user rights on document level
	is_doc_right = of_setdocumentrights()	//by alfee at 04.10.2007			
	IF inv_ole_utils_doc.of_isreadonly() THEN
		//Open the file
		li_rtn = inv_ole_utils_doc.of_displayfile_excel(ls_filename, TRUE)
	ELSE
		li_rtn = inv_ole_utils_doc.of_displayfile_excel(ls_filename, FALSE)
	END IF
	is_opened_file = ls_filename
END IF
ib_allowtrack = TRUE //01.19.2007
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
	il_preview_level = 1 //added by alfee 05.15.2007
ELSE
	il_preview_doc_id = il_doc_id
	idc_preview_revision = idc_revision
	il_preview_level = ll_level //added by alfee 05.15.2007
	SetReDraw(TRUE)
	//Set Saved property of the document - Alfee 03.28.2008
//	inv_ole_utils_doc.of_setsaved(TRUE)	
END IF
SetReDraw(TRUE)

///////////////////////////////////////////////////////////////////////
//// Trigger off audit trail
///////////////////////////////////////////////////////////////////////
//IF tab_1.tabpage_browse.dw_browse.object.level[tab_1.tabpage_browse.dw_browse.getrow()] = 1 THEN
If idw_LastDW.GetItemNumber( idw_LastDW.GetRow( ), 'level' ) = 1 Then//modify by gavins 20120208
	str_add_audit lstr_add_audit
	lstr_add_audit.doc_id = il_doc_id
	lstr_add_audit.revision = idc_revision
	lstr_add_audit.doc_ext = is_doc_ext
	lstr_add_audit.action = "Viewed"
	//Begin - Added By Mark Lee 07/10/12
//	inv_dm_utils.of_add_audit_trail( lstr_add_audit )
	If of_check_track_viewing() = 1 then 
		inv_dm_utils.of_add_audit_trail( lstr_add_audit )
	End If
	//End - Added By Mark Lee 07/10/12
	
	//added by gavins 20120229
	of_insertdetail(  tab_1.tabpage_browse.dw_browse, tab_1.tabpage_browse.dw_detail  )
END IF

IF Isvalid(w_appeon_gifofwait) THEN Close(w_appeon_gifofwait)


Return 1

end function

public function integer of_convert2pdf (long al_doc_id, decimal adec_revision, string as_filename);Integer li_ret
//long ll_doc_id
decimal{1} ldec_old_revision
//String ls_pdf_file
Datetime ldt_modify_date

ldec_old_revision = adec_revision

//Convert image file to PDF
li_ret = inv_dm_utils.of_convert2pdf(al_doc_id, adec_revision, as_filename,is_doc_ext )
If li_ret < 0 Then Return -1

//Refresh dw_browse data
tab_1.tabpage_browse.dw_browse.SetItem(tab_1.tabpage_browse.dw_browse.Getrow(), "revision", adec_revision)
tab_1.tabpage_browse.dw_browse.SetItem(tab_1.tabpage_browse.dw_browse.Getrow(), "doc_ext", 'pdf')
tab_1.tabpage_browse.dw_browse.SetItem(tab_1.tabpage_browse.dw_browse.Getrow(), "revision_control", "1")

THIS.of_collapse_row( al_doc_id, tab_1.tabpage_browse.dw_browse.GetRow())
This.of_set_docrevision( al_doc_id,adec_revision)
idc_preview_revision = adec_revision
is_doc_ext = 'pdf'

Tab_1.Selecttab(1)
Tab_1.tabpage_browse.dw_browse.event rowfocuschanged(Tab_1.tabpage_browse.dw_browse.GetRow())

//View PDF document
Tab_1.tabpage_browse.dw_browse.event doubleclicked(0, 0, Tab_1.tabpage_browse.dw_browse.GetRow(), Tab_1.tabpage_browse.dw_browse.object.doc_ext)
//If isvalid(lnv_image_cp) Then Destroy lnv_image_cp

Return  1
end function

public subroutine of_filter_category (datastore adw_data);n_cst_right lnv_right

If gnv_data.of_getitem( 'icred_settings', 'filter_documents', False) = '0' Then Return

lnv_right = Create n_cst_right
lnv_right.of_filter_right( adw_data, 'category', 1)
Destroy lnv_right
end subroutine

public subroutine of_hidesearch ();//====================================================================
// Function: of_HideSearch()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2010-04-26
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History: by gavins 2012-01-31
//
//====================================================================

long	ll_Right

Tab_1.TabPage_Browse.dw_Filter.Visible = false				//Added By Mark Lee 12/07/2012

If ii_ResizeWay = 1 Then
	Tab_1.TabPage_Browse.SetRedraw( false )
	il_BottomSpace = Tab_1.TabPage_Browse.Height - Tab_1.TabPage_Browse.dw_detail.Y - Tab_1.TabPage_Browse.dw_detail.height - il_BottomSpace
	
//	Tab_1.TabPage_Browse.dw_Filter.Visible = false				//Added By Mark Lee 12/07/2012
	
	Tab_1.TabPage_Browse.dw_Browse.Y = Tab_1.TabPage_Browse.dw_Filter.Y
	
	If tab_1.tabpage_browse.dw_detail.Visible Then
//		Tab_1.TabPage_Browse.dw_Browse.Height = Tab_1.TabPage_Browse.Height - il_BottomSpace - Tab_1.TabPage_Browse.dw_detail.Height  - 20
		
		Tab_1.TabPage_Browse.dw_Browse.Height = ( Tab_1.TabPage_Browse.Height   ) / 2 - 10 
		tab_1.tabpage_browse.st_vsplitbar.Y =  tab_1.tabpage_browse.dw_browse.Y  + tab_1.tabpage_browse.dw_browse.Height  + 4
		Tab_1.TabPage_Browse.dw_detail.Y = tab_1.tabpage_browse.st_vsplitbar.Y + tab_1.tabpage_browse.st_vsplitbar.height +  4
		Tab_1.TabPage_Browse.dw_detail.Height = tab_1.tabpage_browse.Height  - tab_1.tabpage_browse.st_vsplitbar.Y - tab_1.tabpage_browse.st_vsplitbar.Height - 20 
		of_set_splitbar_location( )
	Else
		
		Tab_1.TabPage_Browse.dw_Browse.Height = Tab_1.TabPage_Browse.Height -  10		
		tab_1.tabpage_browse.st_vsplitbar.Y = Tab_1.TabPage_Browse.dw_Browse.Y + Tab_1.TabPage_Browse.dw_Browse.Height + 4
	End If

	Tab_1.TabPage_Browse.SetRedraw( true )
ElseIf ii_ResizeWay = 2 Then
	il_BottomSpace = Tab_1.TabPage_Browse.Height - Tab_1.TabPage_Browse.dw_Browse.Y - Tab_1.TabPage_Browse.dw_Browse.height - il_BottomSpace

//	Tab_1.TabPage_Browse.dw_Filter.Visible = false		//Added By Mark Lee 12/07/2012
	
	Tab_1.TabPage_Browse.dw_Browse.Y = Tab_1.TabPage_Browse.dw_Filter.Y
	Tab_1.TabPage_Browse.dw_Browse.Height = Tab_1.TabPage_Browse.Height - il_BottomSpace - Tab_1.TabPage_Browse.dw_Browse.Y
	
End If
	

if IsValid(m_pfe_cst_mdi_menu_contract_am) then
	ll_Right = w_mdi.of_security_access(6924)
	if ll_Right <> 0 then
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_view.m_filter,'ToolbarItemVisible', true)
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_view.m_filter,'ToolbarItemDown', False)
	else
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_view.m_filter,'ToolbarItemVisible', false)
	end if
end if

//Tab_1.TabPage_Browse.dw_Browse.SetFocus()
//If IsValid( this.idw_lastdw ) Then //modified by gavins 20120802
//	idw_Lastdw.Post setFocus( )
//Else
//	Tab_1.TabPage_Browse.dw_Browse.post SetFocus() //Apb bug - jervis 06.10.2010
//End If

end subroutine

public function integer of_filter_clause (long ai_doc_id, decimal adc_revision, boolean ab_locate);//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_dm_dataof_filter_clause()
// $<arguments>
//		value	integer	ai_doc_id   		
//		value	decimal	adc_revision		
//		value	boolean	ab_locate //Locate in document - Alfee 05.09.2008
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
tab_1.tabpage_preview.dw_clause.SetRedraw(FALSE)
//Added By Mark Lee 08/06/12
tab_1.tabpage_preview.dw_clause.of_set_idle_flag(False)

tab_1.tabpage_preview.dw_clause.retrieve(ai_doc_id,adc_revision)
tab_1.tabpage_preview.dw_clause.SetRedraw(TRUE)
ib_locate = true

//locate in file
if tab_1.selectedtab = 2 and tab_1.tabpage_preview.dw_clause.visible then  //
	If ab_locate Then this.event ue_locatefile() //Alfee 05.09.2008
	//this.event ue_locatefile()
end if

return 1
end function

public function long of_locate_doc (long al_doc_id);Long ll_find
ll_find = Tab_1.tabpage_browse.dw_browse.Find('doc_id = ' + String(al_doc_id) , 1, Tab_1.tabpage_browse.dw_browse.RowCount() )
If ll_find > 0 Then
	Tab_1.tabpage_browse.dw_browse.ScrolltoRow(ll_find)
	Tab_1.tabpage_browse.dw_browse.SetRow(ll_find)
	Tab_1.tabpage_browse.dw_browse.SelectRow(0,False)
	Tab_1.tabpage_browse.dw_browse.SelectRow(ll_find,True)
End If

Return ll_find
end function

public function boolean of_get_protect_tabpg ();Integer li_access
If Not isvalid(iw_parent) Then this.of_getparentwindow( iw_parent)

If iw_parent.classname() = 'w_contract' Then
	Return inv_contract_details.of_get_protect_tabpg( )
Else
	//For Documents Browse Windows
	li_access = w_mdi.of_security_access(2150)  //Document Manager
	If li_access < 2 Then Return True
	li_access = w_mdi.of_security_access(2070)  //Contract Main
	If li_access < 2 Then Return True
	Return False 
End If

end function

public function boolean of_check_read_only ();Return This.of_get_protect_tabpg( )

//
//Integer li_tabidx
//u_tabpg_contract_master	lu_tabpg
//
//IF IsValid(gw_contract) THEN
//	li_tabidx = gw_contract.tab_contract_details.selectedtab
//	IF li_tabidx > 0 THEN
//		// get the current tab page index
//		lu_tabpg = gw_contract.tab_contract_details.of_gettabpage(li_tabidx)
//		IF lu_tabpg.inv_contract_details.of_get_protect_columns( ) THEN
//			//of_set_message('Contract is presently read only. No changes can be made. ')
//			RETURN TRUE
//		END IF
//	END IF
//END IF
//
//return false
end function

public function u_tabpg_dm_data of_get_current_object ();Return This
end function

public function integer of_get_pagebreak (long al_clauseid[], ref long al_pagebreak[], ref long ai_appendparagraph[]);//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_dm_data.of_get_pagebreak()
// $<arguments>
//		Value long	al_clauseid[]
//		Reference integer ab_pagebreak[]
//		Reference integer ai_appendparagraph[]
// $<returns> integer
// $<description>Get clauses' pagebreak flags accordingly and Append Paragraph
//////////////////////////////////////////////////////////////////////
// $<add> 05.28.2007 by Alfee (Contract Logix Document Manager)
//////////////////////////////////////////////////////////////////////
Long ll_clause_cnt, ll_cnt, ll_found, i

ll_clause_cnt = UpperBound(al_clauseid)
IF ll_clause_cnt < 1 THEN RETURN -1

//Get all clauses
ll_cnt = ids_clause_approved.RowCount()
IF ll_cnt < 1 THEN ll_cnt = ids_clause_approved.Retrieve()

//Assign clauses' pagebreak flag array accordingly
FOR i = 1 to ll_clause_cnt
	IF ll_cnt < 1 THEN 
		al_pagebreak[i] = 0
		Continue
	END IF
	ll_found = ids_clause_approved.find( "ctx_acp_clause_id = " + String(al_clauseid[i]), 1, ll_cnt)
	IF ll_found > 0 THEN 
		al_pagebreak[i] = ids_clause_approved.GetItemNumber( ll_found, "page_break")
		ai_appendparagraph[i] = ids_clause_approved.GetItemNumber( ll_found, "append_paragraph")
	ELSE		
		al_pagebreak[i] = 0		
		ai_appendparagraph[i] = 0		
	END IF	
NEXT

RETURN 1
end function

public function integer of_delete (long al_doc_id);gnv_appeondb.of_startqueue( )

DELETE FROM  Ctx_am_doc_audit WHERE doc_id = :al_doc_id;
//Added By Mark Lee 08/02/12 Not exists table name ctx_am_ai_notification_user
//DELETE FROM  ctx_am_ai_notification_user WHERE doc_id = :al_doc_id; 	
DELETE FROM  ctx_am_ai_notification_users WHERE doc_id = :al_doc_id; 	

DELETE FROM  ctx_am_ai_alarm_attachment WHERE doc_id = :al_doc_id;	
DELETE FROM  ctx_am_ai_notification WHERE doc_id = :al_doc_id; 		
DELETE FROM  ctx_am_action_item WHERE doc_id = :al_doc_id;

DELETE FROM  Ctx_am_document_clause WHERE doc_id = :al_doc_id;
DELETE FROM  Ctx_am_doc_image WHERE doc_id = :al_doc_id;

DELETE FROM  Ctx_am_document WHERE doc_id = :al_doc_id;
COMMIT;

gnv_appeondb.of_commitqueue( )

Return 1
end function

public subroutine of_show_sertifi_status (long al_row);str_sertifi_doc lstr_sertifi_doc,lstr_sertifi_doc_ret

If al_row <= 0 Then Return

lstr_sertifi_doc.as_es_apicode = tab_1.tabpage_browse.dw_browse.GetItemString(al_row, 'es_apicode')
If lstr_sertifi_doc.as_es_apicode = '' or isnull(lstr_sertifi_doc.as_es_apicode) Then Return

lstr_sertifi_doc.al_doc_id = tab_1.tabpage_browse.dw_browse.GetItemNumber(al_row, 'doc_id')
lstr_sertifi_doc.as_es_fileid  = tab_1.tabpage_browse.dw_browse.GetItemString(al_row, 'es_fileid')
lstr_sertifi_doc.as_es_docid = tab_1.tabpage_browse.dw_browse.GetItemString(al_row, 'es_docid')
lstr_sertifi_doc.as_es_sender = tab_1.tabpage_browse.dw_browse.GetItemString(al_row, 'es_sender')
lstr_sertifi_doc.as_es_email = tab_1.tabpage_browse.dw_browse.GetItemString(al_row, 'es_sender_email')
lstr_sertifi_doc.as_checkout_by = tab_1.tabpage_browse.dw_browse.GetItemString(al_row, 'checkout_by')
lstr_sertifi_doc.as_checkout_status = tab_1.tabpage_browse.dw_browse.GetItemString(al_row, 'checkout_status')
lstr_sertifi_doc.as_filename = tab_1.tabpage_browse.dw_browse.GetItemString(al_row, 'doc_name')
lstr_sertifi_doc.as_type = 'dm'

of_show_sertifi_status(lstr_sertifi_doc, True)

Return

end subroutine

public function integer of_show_sertifi_status (str_sertifi_doc astr_sertifi_doc, boolean ab_refresh);str_sertifi_doc lstr_sertifi_doc_ret
OpenWithParm(w_dm_sertifi_status,astr_sertifi_doc)

SetPointer(HourGlass!)
//Refresh checkout status if document is signed.
If ab_refresh Then
	If isvalid(Message.powerobjectparm) Then
		lstr_sertifi_doc_ret = Message.powerobjectparm
		If astr_sertifi_doc.as_checkout_status <> lstr_sertifi_doc_ret.as_checkout_status Then
			//Refresh the browse window if refresh status or checked in.
			This.Event ue_retrieve( )
			This.of_locate_doc(astr_sertifi_doc.al_doc_id)	
			
			//Need Refresh Action Item
			If lstr_sertifi_doc_ret.as_checkout_status = '6' Then //5 become to 6
				If isvalid(gw_contract) Then
					If gw_contract.tab_contract_details.ib_select9 Then
						If gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_action.of_get_doc_id() = astr_sertifi_doc.al_doc_id Then
							gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_action.of_retrieve() 
						End If
					End If
				End If
			End If
			
		End If
	End If
End If

Return 1
end function

public function integer of_locate_doc (long al_doc_id[]);Long ll_find,i
Boolean lb_found

Tab_1.tabpage_browse.dw_browse.SelectRow(0,False)
For i = 1 To UpperBound(al_doc_id[])
	ll_find = Tab_1.tabpage_browse.dw_browse.Find('doc_id = ' + String(al_doc_id[i]) , 1, Tab_1.tabpage_browse.dw_browse.RowCount() )
	If ll_find > 0 Then
		Tab_1.tabpage_browse.dw_browse.ScrolltoRow(ll_find)
		Tab_1.tabpage_browse.dw_browse.SetRow(ll_find)
		Tab_1.tabpage_browse.dw_browse.SelectRow(ll_find,True)
		lb_found = True 
	End If
Next

If lb_found Then 
	Return 1
Else
	Return 0
End If

end function

public subroutine of_show_approve_status ();str_ctx_email lstr_ctx_email

Long ll_row

ll_row = This.tab_1.tabpage_browse.dw_browse.GetRow()
If ll_row = 0 Then Return

If iw_parent.classname() = 'w_contract' Then
	lstr_ctx_email.doc_from = 'DM'
	lstr_ctx_email.ctx_id = inv_contract_details.of_get_ctx_id()
	If tab_1.tabpage_browse.dw_browse.object.level[tab_1.tabpage_browse.dw_browse.getrow()] = 1 Then //For Level 1
		lstr_ctx_email.revision = This.tab_1.tabpage_browse.dw_browse.GetItemDecimal(ll_row, 'revision')
	Else
		lstr_ctx_email.revision = This.tab_1.tabpage_browse.dw_browse.GetItemDecimal(ll_row, 'audit_version')
	End If	
Else
	lstr_ctx_email.doc_from = 'DM_BROWSE'
	lstr_ctx_email.ctx_id = tab_1.tabpage_browse.dw_browse.getitemnumber(tab_1.tabpage_browse.dw_browse.getrow(),'ctx_id')
	lstr_ctx_email.revision = This.tab_1.tabpage_browse.dw_browse.GetItemDecimal(ll_row, 'revision')
End If
lstr_ctx_email.doc_id = This.tab_1.tabpage_browse.dw_browse.GetItemNumber(ll_row, 'doc_id')

If m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkin.enabled and m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkin.toolbaritemvisible Then
	ib_havecheckinright = True
Else
	ib_havecheckinright = False
End If

lstr_ctx_email.ab_checkinright = ib_havecheckinright
lstr_ctx_email.al_approve_id = This.tab_1.tabpage_browse.dw_browse.GetItemNumber(ll_row, 'approve_id')

gnv_webapprove.of_show_approve_status( lstr_ctx_email, this)
/*
OpenWithParm(w_dm_approve_status, lstr_ctx_email)

//Refresh document data if check in document
If Message.doubleparm > 0 Then
	This.Event ue_retrieve( )
	This.of_locate_doc(lstr_ctx_email.doc_id)	
	//Refresh action items data
	If isvalid(gw_contract) Then
		If gw_contract.tab_contract_details.ib_select9 Then
			If gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_action.of_get_doc_id() = lstr_ctx_email.doc_id Then
				gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_action.of_retrieve() 
			End If
		End If
	End If
End If
*/
Return 
end subroutine

public subroutine of_registresize (integer ai_resize);//add by gavins  20120131   resize  way 
//adapter  document manager and contract's document manager


If ai_Resize = 1 Then
	this.inv_resize.of_register( tab_1,inv_resize.scalerightbottom)
	ii_ResizeWay = 1
	//--------Begin Modified by Alfee on 04.23.2008----------------------------------
	this.inv_resize.of_register( tab_1.tabpage_browse.dw_filter,inv_resize.scale)
	this.inv_resize.of_register( tab_1.tabpage_browse.dw_browse,inv_resize.scale   )

	this.inv_resize.of_register( tab_1.tabpage_preview.dw_head,inv_resize.scaleright)
	//---------Begin Modified by (Appeon)Harry 06.28.2013 for V141 ISG-CLX--------
	//--------Begin Modified by Alfee on 08.31.2012 for bug 3224--------------------
//	this.inv_resize.of_register( tab_1.tabpage_preview.ole_doc,inv_resize.scalerightbottom)
//	//this.inv_resize.of_register( tab_1.tabpage_preview.uo_1,inv_resize.scalerightbottom)
//	this.inv_resize.of_register( tab_1.tabpage_preview.uo_2,inv_resize.scalerightbottom) //Alfee 05.19.2008
	this.inv_resize.of_register( tab_1.tabpage_preview.ole_doc,inv_resize.scalebottom) 
	this.inv_resize.of_register( tab_1.tabpage_preview.uo_2,inv_resize.scale) 
	//---------End Modfiied ------------------------------------------------------
	
	this.inv_resize.of_Register( tab_1.tabpage_browse.dw_detail, inv_resize.scale )

	this.inv_resize.of_Register( 	tab_1.tabpage_browse.st_vsplitbar, inv_resize.scale )
	
	this.inv_resize.of_register( tab_1.tabpage_preview.gb_map,inv_resize.scalebottom)
	this.inv_resize.of_register( tab_1.tabpage_preview.dw_change,inv_resize.scalebottom)
	this.inv_resize.of_register( tab_1.tabpage_preview.uo_scrollbar, inv_resize.fixedbottom) //alfee 07.24.2007
	this.inv_resize.of_register( tab_1.tabpage_preview.cb_approve,inv_resize.fixedbottom)
	this.inv_resize.of_register( tab_1.tabpage_preview.cb_reject,inv_resize.fixedbottom)
	this.inv_resize.of_register( tab_1.tabpage_preview.pb_approve,inv_resize.fixedbottom) //07.09.2008
	this.inv_resize.of_register( tab_1.tabpage_preview.pb_reject,inv_resize.fixedbottom) //07.09.2008
	this.inv_resize.of_register( tab_1.tabpage_preview.cb_original,inv_resize.fixedbottom)

ElseIf ai_Resize = 2 Then
	ii_ResizeWay =2
	this.inv_resize.of_register( tab_1,inv_resize.scalerightbottom)
	
	//--------Begin Modified by Alfee on 04.23.2008----------------------------------
	this.inv_resize.of_register( tab_1.tabpage_browse.dw_filter,inv_resize.scale)
	this.inv_resize.of_register( tab_1.tabpage_browse.dw_browse,inv_resize.scale)
	this.inv_resize.of_register( tab_1.tabpage_preview.dw_head,inv_resize.scaleright)
	//---------Begin Modified by (Appeon)Harry 06.28.2013 for V141 ISG-CLX--------
	//--------Begin Modified by Alfee on 08.31.2012 for bug 3224--------------------
//	this.inv_resize.of_register( tab_1.tabpage_preview.ole_doc,inv_resize.scalerightbottom)
//	//this.inv_resize.of_register( tab_1.tabpage_preview.uo_1,inv_resize.scalerightbottom)
//	this.inv_resize.of_register( tab_1.tabpage_preview.uo_2,inv_resize.scalerightbottom) //Alfee 05.19.2008
	this.inv_resize.of_register( tab_1.tabpage_preview.ole_doc,inv_resize.scalebottom) 
	this.inv_resize.of_register( tab_1.tabpage_preview.uo_2,inv_resize.scale) 
	//---------End Modfiied ------------------------------------------------------	
	
	this.inv_resize.of_register( tab_1.tabpage_preview.gb_map,inv_resize.scalebottom)
	this.inv_resize.of_register( tab_1.tabpage_preview.dw_change,inv_resize.scalebottom)
	this.inv_resize.of_register( tab_1.tabpage_preview.uo_scrollbar, inv_resize.fixedbottom) //alfee 07.24.2007
	this.inv_resize.of_register( tab_1.tabpage_preview.cb_approve,inv_resize.fixedbottom)
	this.inv_resize.of_register( tab_1.tabpage_preview.cb_reject,inv_resize.fixedbottom)
	this.inv_resize.of_register( tab_1.tabpage_preview.pb_approve,inv_resize.fixedbottom) //07.09.2008
	this.inv_resize.of_register( tab_1.tabpage_preview.pb_reject,inv_resize.fixedbottom) //07.09.2008
	this.inv_resize.of_register( tab_1.tabpage_preview.cb_original,inv_resize.fixedbottom)
		
	//---------Begin Added by (Appeon)Harry 05.06.2014 for V142 ISG-CLX--------
	//Added By Jay Chen 04-03-2014
	if iw_parent.classname() = 'w_documents_browse' then
		this.inv_resize.of_Register( 	tab_1.tabpage_browse.st_vsplitbar, inv_resize.scale )
	end if
	//---------End Added ------------------------------------------------------
	
End If


end subroutine

public subroutine of_create_dw ();//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_contract_requirementsof_create_dw()
// $<arguments>(None)
// $<returns> (none)
// $<description>Contract module modification
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> by gavins 20120201
//////////////////////////////////////////////////////////////////////
string ls_tab_name
string ls_dw_name[]
string ls_dataobject[]
integer li_view_id
datawindow ld_dw[]

ls_tab_name = 'tabpage_images'
ld_dw[1] = tab_1.tabpage_browse.dw_browse
ls_dw_name[1] = 'dw_browse'
ls_dataobject[1] = 'd_dm_doc_tree'
ld_dw[2] =  tab_1.tabpage_browse.dw_detail
ls_dw_name[2] = 'dw_detail'
ls_dataobject[2] = 'd_dm_doc_tree_detail'

f_create_contract_dw(gi_contract_view_id,ls_tab_name,ld_dw,ls_dw_name,ls_dataobject)		
iw_parent.function dynamic wf_set_select('tabpage_images',true) 


this.event ue_set_screen_properties( )  
end subroutine

public subroutine of_sethistorytoolbar (integer ai_class);Long		ll_Right
String		ls_Option_value

If ai_Class = 1 Then
	
	if IsValid(m_pfe_cst_mdi_menu_contract_am) then
		ll_Right = w_mdi.of_security_access(6924)
			
		If ll_Right<>0  Then // add by gavins 20120201
	
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_history,'toolbaritemvisible', true)
				
			If tab_1.tabpage_browse.dw_detail.Visible Then
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_history,'ToolbarItemDown', true)
			Else
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_history,'ToolbarItemDown', false)
			End If
		Else
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_history,'toolbaritemvisible', false)
		End If
	end if
	
ElseIf ai_Class = 2 Then
	
	if IsValid(m_pfe_cst_mdi_menu_contract_am) then
		ll_Right = w_mdi.of_security_access(6924)
			
		If ll_Right<>0  Then // add by gavins 20120201
			
			If tab_1.selectedtab = 1 Then
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_history,'toolbaritemvisible', true)
			Else
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_history,'toolbaritemvisible', false)				
			End If
		Else
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_history,'toolbaritemvisible', false)
		End If
	end if	
ElseIf ai_Class = 3 Then
	
	if IsValid(m_pfe_cst_mdi_menu_contract_am) then
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_history,'toolbaritemvisible', false)
	End If
ElseIf ai_Class = 4 Then
	if IsValid(m_pfe_cst_mdi_menu_contract_am) then
		ll_Right = w_mdi.of_security_access(6924)
			
		If ll_Right<>0  Then // add by gavins 20120201
	
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_history,'toolbaritemvisible', true)
			
			If iw_Parent.ClassName() = 'w_contract' Then
				ls_Option_Value = gnv_user_option.of_Get_option_value( gs_user_id, "m_documentmanager.m_history.ToolbarItemDown" ) 
			
				If Len( ls_Option_Value ) > 0 Then//add by gavins 20120215
					If ls_Option_Value = 'true' Then
						If Not  tab_1.tabpage_browse.dw_detail.Visible Then m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_history.event Clicked( )
					Else
						If  tab_1.tabpage_browse.dw_detail.Visible Then m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_history.event Clicked( )
					End If
				End If
			End IF
			If tab_1.tabpage_browse.dw_detail.Visible Then
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_history,'ToolbarItemDown', true)
			Else
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_history,'ToolbarItemDown', false)
			End If
		Else
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_history,'toolbaritemvisible', false)
		End If
	end if
End If
end subroutine

public subroutine of_setpicturesize (datawindow adw_this, string as_zoom, string as_picture[], string as_originalwidth, string as_originalheight, string as_newwidth, string as_newheight);Integer		li_i


For li_i = 1 To upperbound( as_picture )
	 adw_This.Modify( as_picture[li_i] + ".width = "+ as_originalwidth + " " +  as_picture[li_i] + ".height = " + as_originalheight  )
     adw_This.Modify( as_picture[li_i]  + ".width = '" + as_newwidth + "'  " +  as_picture[li_i] + ".height = '" + as_newheight + "'" ) 
Next
end subroutine

public subroutine of_set_splitbar_location ();//
String			ls_Option_Value

Dec{3}		ldec_Sacle
Integer		li_Y

//---------Begin Modified by (Appeon)Harry 05.06.2014 for V142 ISG-CLX--------
//ls_Option_Value = gnv_user_option.of_Get_option_value( gs_user_id, "tabpage_image.tab_1.tabpage_data.tab_1.tabpage_browse.st_vsplitbar" ) 
//Modified By Jay Chen 04-03-2014
if is_parent_window = 'w_documents_browse' then 
	ls_Option_Value = gnv_user_option.of_Get_option_value( gs_user_id, "w_documents_browse.tab_1.tabpage_browse.st_vsplitbar" )
else
	ls_Option_Value = gnv_user_option.of_Get_option_value( gs_user_id, "tabpage_image.tab_1.tabpage_data.tab_1.tabpage_browse.st_vsplitbar" ) 
end if
//---------End Modfiied ------------------------------------------------------
gnv_string.of_convert_numeric_for_language( ls_Option_Value)				//Added By Mark Lee 05/09/2013
ldec_Sacle = Dec( ls_Option_Value )

li_Y = tab_1.tabpage_browse.Height * ldec_Sacle

If li_Y > 0 Then
	//---------Begin Modified by (Appeon)Harry 05.06.2014 for V142 ISG-CLX--------
	//If  li_Y  < tab_1.tabpage_browse.dw_Browse.Y + 300 and tab_1.tabpage_browse.dw_filter.Visible  Then Return
		//Modified By Jay Chen 04-03-2014
	if is_parent_window <> 'w_documents_browse' then
		If  li_Y  < tab_1.tabpage_browse.dw_Browse.Y + 300 and tab_1.tabpage_browse.dw_filter.Visible  Then Return
	end if
	//---------End Modfiied ------------------------------------------------------
	
	If tab_1.tabpage_browse.st_vsplitbar.Y >  li_Y + 4 Or  tab_1.tabpage_browse.st_vsplitbar.Y <  li_Y - 4 Then
		//---------Begin Modified by (Appeon)Harry 05.06.2014 for V142 ISG-CLX--------
		/*
		If tab_1.tabpage_browse.dw_detail.Visible  Then 
			tab_1.tabpage_browse.dw_Browse.Height = li_Y - tab_1.tabpage_browse.dw_Browse.y - 8
			tab_1.tabpage_browse.st_vsplitbar.Y =  li_Y 
			tab_1.tabpage_browse.dw_detail.Y = tab_1.tabpage_browse.st_vsplitbar.Y + 8
			tab_1.tabpage_browse.dw_detail.Height = tab_1.tabpage_browse.Height -  tab_1.tabpage_browse.dw_detail.Y  - 10 
		End If
		*/
		if is_parent_window <> 'w_documents_browse' then //Modified By Jay Chen 04-03-2014
			If tab_1.tabpage_browse.dw_detail.Visible  Then 
				tab_1.tabpage_browse.dw_Browse.Height = li_Y - tab_1.tabpage_browse.dw_Browse.y - 8
				tab_1.tabpage_browse.st_vsplitbar.Y =  li_Y 
				tab_1.tabpage_browse.dw_detail.Y = tab_1.tabpage_browse.st_vsplitbar.Y + 8
				tab_1.tabpage_browse.dw_detail.Height = tab_1.tabpage_browse.Height -  tab_1.tabpage_browse.dw_detail.Y  - 10 
			End If
		else
			w_documents_browse.SetRedraw(false)
			tab_1.tabpage_browse.dw_filter.Height = li_Y - tab_1.tabpage_browse.dw_filter.y - 8
			tab_1.tabpage_browse.st_vsplitbar.Y =  li_Y 
			tab_1.tabpage_browse.dw_Browse.Y = tab_1.tabpage_browse.st_vsplitbar.Y + 8
			tab_1.tabpage_browse.dw_Browse.Height = tab_1.tabpage_browse.Height -  tab_1.tabpage_browse.dw_Browse.Y  - 10 
			w_documents_browse.SetRedraw(true)
		end if
		//---------End Modfiied ------------------------------------------------------
		
		of_Set_object_Resize( )//regist resize object
	End If		
End If
end subroutine

public subroutine of_set_object_resize ();
If ii_ResizeWay = 1 Then
	this.inv_resize.of_Unregister( tab_1.tabpage_browse.dw_browse )
	this.inv_resize.of_register( tab_1.tabpage_browse.dw_browse,inv_resize.scale   )
	this.inv_resize.of_Unregister( tab_1.tabpage_browse.dw_detail  )
	this.inv_resize.of_register( tab_1.tabpage_browse.dw_detail,inv_resize.scale   )
	this.inv_resize.of_Unregister( tab_1.tabpage_browse.st_vsplitbar )
	this.inv_resize.of_register( tab_1.tabpage_browse.st_vsplitbar,inv_resize.scale   )
	tab_1.tabpage_browse.st_vsplitbar.setPosition( tobottom!)
//---------Begin Added by (Appeon)Harry 05.06.2014 for V142 ISG-CLX--------
elseif ii_ResizeWay = 2 and is_parent_window = 'w_documents_browse' then //Added By Jay Chen 04-03-2014
	this.inv_resize.of_Unregister( tab_1.tabpage_browse.dw_filter )
	this.inv_resize.of_register( tab_1.tabpage_browse.dw_filter,inv_resize.scale   )
	this.inv_resize.of_Unregister( tab_1.tabpage_browse.dw_browse  )
	this.inv_resize.of_register( tab_1.tabpage_browse.dw_browse,inv_resize.scale   )
	this.inv_resize.of_Unregister( tab_1.tabpage_browse.st_vsplitbar )
	this.inv_resize.of_register( tab_1.tabpage_browse.st_vsplitbar,inv_resize.scale   )
	tab_1.tabpage_browse.st_vsplitbar.setPosition( tobottom!)
//---------End Added ------------------------------------------------------
End If

//this.inv_resize.of_SetOrigSize (This.Width, This.Height)
end subroutine

public subroutine of_setdocumentpreopen (datawindow adw_current);//set document before open  document
String		ls_checkout_status
Long		ll_Row
dec{1}	ldc_temp

ll_Row = adw_current.GetSelectedRow( 0 )
If ll_Row > 0 Then 
	is_doc_ext = Lower(adw_current.getitemstring(ll_Row,'doc_ext'))
	CHOOSE CASE Lower(is_doc_ext)
		CASE 'bmp','tif','tiff','jpg','gif','pdf'//'tif','tiff','jfk','bmp','jpc','jpe','jpeg','pcx','dcx','xif','gif','wif','ibk'
			If Lower(is_doc_ext) = 'pdf' and gnv_data.of_getitem( 'icred_settings', 'openpdfwith', false) = '2' Then //Added By Ken.Guo 2011-05-06. for Open PDF Mode
				tab_1.tabpage_preview.enabled = FALSE				
			End If
		CASE 'doc','xls','xlsx'
		CASE ELSE
			tab_1.tabpage_preview.enabled = FALSE
	END CHOOSE

	
	IF adw_current.getitemnumber(ll_Row,'level')=1 THEN
		ldc_temp = adw_current.getitemdecimal( ll_Row,'revision')
	ELSE
		ldc_temp = adw_current.getitemdecimal( ll_Row,'audit_version')
	END IF
	
	ls_checkout_status = adw_current.getitemstring( ll_Row ,'checkout_status')
	If Isnull(ls_checkout_status) Then ls_checkout_status = '0' //Added by Ken.Guo on 2009-03-27
	//inv_ole_utils_doc.of_setreadonly( this.getitemnumber(currentrow,'level')=2 OR ls_checkout_status = "1")
	inv_ole_utils_doc.of_setreadonly( adw_current.getitemnumber(ll_Row,'level')=2 OR ls_checkout_status <> "0")  //Modified by Ken.Guo on 2009-03-27
	//---------Begin Added by Alfee 09.30.2007------------------------------------------------
	//<$Reason>Add read only control to Contract module
	//If inv_contract_details.of_get_protect_tabpg() Then inv_ole_utils_doc.of_setreadonly(True)
	If of_get_protect_tabpg() Then inv_ole_utils_doc.of_setreadonly(True)
	//---------End Added ---------------------------------------------------------------------	
	event ue_doc_changed(il_doc_id,adw_current.getitemnumber( ll_Row, 'doc_id'),idc_revision ,ldc_temp)
	//add by gavins 20120131
End If
end subroutine

public subroutine of_insertdetail (datawindow adw_browse, datawindow adw_detail);Integer			li_rows, li_new, li, li_Rec
Long				ll_cnt, ll_doc_id, ll_Find
boolean			lb_comparison
String				ls_current_flag, ls_flag, ls_Doc_ID
decimal			ldc_revision
DateTime		ldt_LastDateTime

//----------------------------------------------//add by gavins 20120131 judge selectmultirow
li_rows = adw_browse.GetselectedRow( 0 )
If li_Rows > 0   Then//and ib_controalinsert
	adw_detail.Setredraw( false )
	If adw_detail.GetRow( ) > 0 Then
		ls_Doc_ID = string( adw_detail.GetItemnumber( adw_detail.GetRow( ), 'doc_id' ) )
	End If
	If isnull( ls_doc_id ) Or trim( ls_doc_id ) = '' Then ls_doc_id = '-999991'

	ll_doc_id = adw_browse.getitemnumber( li_rows,'doc_id')
	
	If adw_browse.GetSelectedRow( li_Rows ) > 0 Then
		adw_detail.Reset( )	
	Else
		//---------------------------------------------//
		SetPointer(HourGlass!) //Alfee 03.13.2008
		
		ib_detailrow = true
		
		adw_detail.Reset( ) // modify by gavins 20120131
		//Determine if it's in a document comparison process
		IF IsValid(inv_dm_comparison) THEN //Alfee 07.24.2008
			ll_cnt = inv_dm_comparison.ids_target_docs.RowCount()
			IF ll_cnt > 0 THEN
				IF inv_dm_comparison.ids_target_docs.Find("doc_id = " + String(ll_doc_id), 1, ll_cnt) > 0 THEN
					lb_comparison = TRUE	
					ls_current_flag = adw_browse.GetItemString(li_rows, "compare_status")
				END IF
			END IF
		END IF
	
		//Add rows
		n_ds  ds_audit
		
		ds_audit = create n_ds 
		ds_audit.dataobject = 'd_dm_doc_audit_all'
		ds_audit.settransobject( sqlca)
		//Added By Mark Lee 08/06/12
		ds_audit.of_set_idle_flag( False)
		
		li_Rec = ds_audit.retrieve( ll_doc_id)
		li_new = li_Rec+1
		for li = 1 to li_Rec
			li_new = adw_detail.insertrow(li_new)
			adw_detail.setitem(li_new,'row',li_new)
			adw_detail.setitem(li_new,'doc_id',ll_doc_id)
			adw_detail.setitem(li_new,'level',2)		
			adw_detail.setitem(li_new,'revision',adw_browse.getitemdecimal( li_rows,'revision'))
			adw_detail.setitem(li_new,'doc_type',adw_browse.getitemstring(li_rows,'doc_type'))
			adw_detail.setitem(li_new,'doc_name',adw_browse.getitemstring(li_rows,'doc_name'))
			adw_detail.setitem(li_new,'audit_version',ds_audit.getitemdecimal(li,'revision'))
			adw_detail.setitem(li_new,'audit_status',ds_audit.getitemstring(li,'action'))
			adw_detail.setitem(li_new,'audit_date',ds_audit.getitemdatetime(li,'action_date'))
			adw_detail.setitem(li_New,'doc_ext',ds_audit.getitemstring(li,'doc_ext')) //For Compare function
			adw_detail.setitem(li_New,'audit_doc_ext',ds_audit.getitemstring(li,'doc_ext'))
			adw_detail.setitem(li_new,'audit_user',ds_audit.getitemstring(li,'action_by'))
			adw_detail.setitem(li_new,'audit_note',ds_audit.getitemstring(li,'notes'))
	
			//Added By Ken.Guo 2011-06-13. 
			adw_detail.setitem(li_New,'es_apicode',ds_audit.getitemstring(li,'es_apicode'))
			adw_detail.setitem(li_New,'es_fileid',ds_audit.getitemstring(li,'es_fileid'))
			adw_detail.setitem(li_New,'es_docid',ds_audit.getitemstring(li,'es_docid'))
			adw_detail.setitem(li_New,'es_sender',ds_audit.getitemstring(li,'es_sender'))
			adw_detail.setitem(li_New,'es_sender_email',ds_audit.getitemstring(li,'es_sender_email'))			
			
			adw_detail.setitem(li_New,'approve_id',ds_audit.getitemnumber(li,'approve_id'))		
			adw_detail.setitem(li_New,'esign_type',ds_audit.getitemstring(li,'esign_type'))	 //(Appeon) Add by Harry 07.14.2016
			adw_detail.setitem(li_New,'esign_license_user_id',ds_audit.getitemstring(li,'es_license_user_id'))		 //(Appeon) Add by Harry 07.14.2016
			
			//Restore the comparison flag - Alfee 07.24.2008
			IF lb_comparison THEN 
				ldc_revision = ds_audit.getitemdecimal(li,'revision')
				ls_flag = inv_dm_comparison.of_get_flag(ll_doc_id, ldc_revision)
				IF ls_flag <> "" THEN adw_detail.setitem(li_new,'compare_status', ls_flag)
			END IF					
			li_new = li_new+1
		next
		adw_browse.setitem( li_rows,'style','-')
		destroy ds_audit
		
		adw_detail.Sort( )
		
		If adw_detail.RowCount( ) > 0 Then 
			adw_detail.selectrow( 0, false )
			adw_detail.Selectrow( 1, true )
		End If
		
		
	//elseif dwo.name='p_2' then  //modify by gavins 20120131
	//	of_collapse_row(ll_doc_id, row)
	end if
	ib_controalinsert = false
	
	If Not  IsNull( idt_LastDateTime ) and date(idt_LastDateTime ) > date('1900-01-01' )Then
				
		ll_Find = adw_detail.Find( "String( audit_date, 'yyyy-mm-dd hh:mm:ss' ) = '" + String( idt_LastDateTime, 'yyyy-mm-dd hh:mm:ss' ) + "' and doc_id=" + ls_doc_id , 1, &
		 	 adw_detail.RowCount( ) )
		If ll_Find > 0 Then
			adw_detail.selectrow( 0, false )
			adw_detail.Selectrow( ll_Find, true )
		End If	
	End If	
	adw_detail.Setredraw( true )
End If
end subroutine

public function integer of_check_track_viewing ();//====================================================================
// Function: of_check_track_viewing
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 07/10/12
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
String		ls_track_viewing

ls_track_viewing = gnv_data.of_getItem('icred_settings','track_viewing',false) 

If isnull(ls_track_viewing) or trim(ls_track_viewing) = '' or integer(ls_track_viewing) = 0 Then 
	return 0
Else
	return 1
End If 

end function

public subroutine of_reset_filter ();//Added By Ken.Guo 11/25/2013
Long ll_category
Tab_1.tabpage_browse.dw_filter.Reset()
Tab_1.tabpage_browse.dw_filter.insertrow(0)
setnull(ll_category)
Tab_1.tabpage_browse.dw_filter.setitem(1,'category',ll_category)

is_filter = ''
end subroutine

on u_tabpg_dm_data.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.st_docinfo=create st_docinfo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.st_docinfo
end on

on u_tabpg_dm_data.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.st_docinfo)
end on

event constructor;call super::constructor;inv_filesvr = create n_cst_filesrvwin32
inv_dm_comparison = Create n_cst_dm_comparison //Alfee 07.23.2008

//if iw_parent.classname() = 'w_contract' Then
//	of_create_dw( )//add by gavins 20120201
//End If

This.of_setupdateable( FALSE )
this.of_setresize( true)
this.inv_resize.of_register( tab_1,inv_resize.scalerightbottom)

this.inv_resize.of_setminsize( 1024, 768 )
//this.inv_resize.of_SetOrigsize( 3899, 2026)

if iw_parent.classname() = 'w_contract' Then
	tab_1.tabpage_browse.st_vsplitbar.Visible = true
End If
//---------Begin Added by (Appeon)Harry 05.06.2014 for V142 ISG-CLX--------
is_parent_window = iw_parent.classname()  //Added By Jay Chen 04-03-2014
//---------End Added ------------------------------------------------------

/*//modify by gavins 20120131
//--------Begin Modified by Alfee on 04.23.2008----------------------------------
this.inv_resize.of_register( tab_1.tabpage_browse.dw_filter,inv_resize.scale)
this.inv_resize.of_register( tab_1.tabpage_browse.dw_browse,inv_resize.scale)
this.inv_resize.of_register( tab_1.tabpage_preview.dw_head,inv_resize.scaleright)
this.inv_resize.of_register( tab_1.tabpage_preview.ole_doc,inv_resize.scalerightbottom)
//this.inv_resize.of_register( tab_1.tabpage_preview.uo_1,inv_resize.scalerightbottom)
this.inv_resize.of_register( tab_1.tabpage_preview.uo_2,inv_resize.scalerightbottom) //Alfee 05.19.2008

this.inv_resize.of_register( tab_1.tabpage_preview.gb_map,inv_resize.scalebottom)
this.inv_resize.of_register( tab_1.tabpage_preview.dw_change,inv_resize.scalebottom)
this.inv_resize.of_register( tab_1.tabpage_preview.uo_scrollbar, inv_resize.fixedbottom) //alfee 07.24.2007
this.inv_resize.of_register( tab_1.tabpage_preview.cb_approve,inv_resize.fixedbottom)
this.inv_resize.of_register( tab_1.tabpage_preview.cb_reject,inv_resize.fixedbottom)
this.inv_resize.of_register( tab_1.tabpage_preview.pb_approve,inv_resize.fixedbottom) //07.09.2008
this.inv_resize.of_register( tab_1.tabpage_preview.pb_reject,inv_resize.fixedbottom) //07.09.2008
this.inv_resize.of_register( tab_1.tabpage_preview.cb_original,inv_resize.fixedbottom)*/
//Start Code By Jervis 04.17.2008
/*
this.inv_resize.of_register( tab_1.tabpage_browse.dw_filter,inv_resize.scaleright)
this.inv_resize.of_register( tab_1.tabpage_browse.dw_browse,inv_resize.scalerightbottom)
this.inv_resize.of_register( tab_1.tabpage_preview.dw_head,inv_resize.scaleright)
this.inv_resize.of_register( tab_1.tabpage_preview.ole_doc,inv_resize.scalerightbottom)
this.inv_resize.of_register( tab_1.tabpage_preview.uo_1,inv_resize.scalerightbottom)

this.inv_resize.of_register( tab_1.tabpage_preview.gb_map,inv_resize.scalebottom)
this.inv_resize.of_register( tab_1.tabpage_preview.dw_change,inv_resize.scalebottom)
this.inv_resize.of_register( tab_1.tabpage_preview.uo_scrollbar, inv_resize.fixedbottom) //alfee 07.24.2007
this.inv_resize.of_register( tab_1.tabpage_preview.cb_approve,inv_resize.fixedbottom)
this.inv_resize.of_register( tab_1.tabpage_preview.cb_reject,inv_resize.fixedbottom)
this.inv_resize.of_register( tab_1.tabpage_preview.cb_original,inv_resize.fixedbottom)
*/

//this.inv_resize.of_register( tab_1.tabpage_browse.dw_filter,inv_resize.scale)
//this.inv_resize.of_register( tab_1.tabpage_browse.dw_browse,inv_resize.scale)
//this.inv_resize.of_register( tab_1.tabpage_preview.dw_head,inv_resize.scale)
//this.inv_resize.of_register( tab_1.tabpage_preview.ole_doc,inv_resize.scale)
//this.inv_resize.of_register( tab_1.tabpage_preview.uo_1,inv_resize.scale)
//
//this.inv_resize.of_register( tab_1.tabpage_preview.gb_map,inv_resize.scale)
//this.inv_resize.of_register( tab_1.tabpage_preview.dw_change,inv_resize.scale)
//this.inv_resize.of_register( tab_1.tabpage_preview.uo_scrollbar, inv_resize.scale)
//this.inv_resize.of_register( tab_1.tabpage_preview.cb_approve,inv_resize.scale)
//this.inv_resize.of_register( tab_1.tabpage_preview.cb_reject,inv_resize.scale)
//this.inv_resize.of_register( tab_1.tabpage_preview.cb_original,inv_resize.scale)
//End Code By Jervis 04.17.2008
//-------------End Modified ------------------------------------------------------

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

ids_infomsg = create DataStore
ids_infomsg.DataObject = 'd_dm_clause_infomsg'
ids_infomsg.SetTransObject(SQLCA)

//----Begin Added by Alfee 05.28.2007--------------------
//<$Reason>For pagebreak flags on merge file function
ids_clause_approved = Create DataStore
ids_clause_approved.DataObject = 'd_agreement_template_clause_approved'
ids_clause_approved.SetTransObject(SQLCA)

il_clause_approved = long(gnv_data.of_getitem('code_lookup','lookup_code',"lookup_name = 'Clause Approval Status' and code = 'Approved'"))	
//----End Added -----------------------------------------
IF NOT w_mdi.of_security_access(6929) > 0 THEN ib_allow_approve_reject = FALSE //Alfee 11.22.2007

//----Begin Added by Alfee 11.12.2007--------------------
//<$Reason>For dynamic adding clauses - external data source
ids_template_clause_rules_result = Create DataStore 
ids_template_clause_rules_result.DataObject = 'd_dm_template_clause_rules_result'
//----End Added -----------------------------------------

inv_ocr = Create n_cst_image_cp_ocr

end event

event ue_set_security;Integer li_setting
integer li_addbuy, li_addsell, li_addother, li_temp
integer li_AddQueue	//02.12.2009 By Jervis
string ls_type
datawindow idw_current

//---------Begin Modified by (Appeon)Harry 06.28.2013 for V141 ISG-CLX--------
Long ll_status  //alfee 04.20.2012
String  ls_doc_editable //alfee 04.20.2012
//---------End Modfiied ------------------------------------------------------

If ib_detailrow Then
	idw_current = tab_1.tabpage_browse.dw_browse
Else
	idw_current = tab_1.tabpage_browse.dw_detail
End If

gnv_app.of_set_ezmenu_refresh_state( TRUE )//added by gavins 20130325
gnv_app.post of_Refresh_EZMenu( )//added by gavins 20130325

//-----------Begin Added by Alfee 09.30.2007-----------------------------
//Get and set read only flag at tab page level
Boolean lb_protect
//lb_protect = inv_contract_details.of_get_protect_tabpg()
lb_protect = of_get_protect_tabpg()
//-----------End Added --------------------------------------------------

//For role's rights
If Not isvalid(m_pfe_cst_mdi_menu_contract_am) Then Return

//For Buy&Sell setting
li_setting = of_get_app_setting("set_51","I")

//-----------Begin Added by Alfee 08.03.2007-----------------------------
//<$Reason> For the add clause window
IF IsValid(gw_contract) Then
	If gw_contract.Enabled = False THEN
		m_pfe_cst_mdi_menu_contract_am.m_file.m_close.visible = False
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_file.m_close,'toolbaritemvisible', False)
		Return
	End If
END IF

m_pfe_cst_mdi_menu_contract_am.m_file.m_close.visible = True
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_file.m_close,'toolbaritemvisible', True)
//-----------End Added --------------------------------------------------

//w_mdi.setredraw(false)//modify by gavins 20120131
If w_mdi.of_security_access( 6903 ) = 0 Then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_properties0,'toolbaritemvisible', False)
Else
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_properties0,'toolbaritemvisible', True)
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_properties0,'enabled', True)	
End If
If w_mdi.of_security_access( 6905 ) = 0 Then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_email0,'toolbaritemvisible', False)
Else
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_email0,'toolbaritemvisible', True)
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_email0,'enabled', True)
End If

//If w_mdi.of_security_access( 6906 ) = 0 And w_mdi.of_security_access( 6907 ) = 0 And w_mdi.of_security_access( 6908 ) = 0 And w_mdi.of_security_access( 6909 ) = 0 Then   //(Appeon)Harry 10.15.2015 - for Bug_Id#4780
If w_mdi.of_security_access( 6906 ) = 0 And w_mdi.of_security_access( 6907 ) = 0 And w_mdi.of_security_access( 6909 ) = 0 Then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0,'toolbaritemvisible', False)	
Else
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0,'toolbaritemvisible', True)			
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0,'enabled', True)			
End If

If w_mdi.of_security_access( 6909 ) = 0 Then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_saveas,'toolbaritemvisible', False)
Else
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_saveas,'toolbaritemvisible', True)
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_saveas,'enabled', True)
End If

//Added By Ken.Guo 2009-06-04.
If w_mdi.of_security_access( 6953 ) = 0 Then 
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_versionsettings,'toolbaritemvisible', False)	
Else
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_versionsettings,'toolbaritemvisible', True)
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_versionsettings,'enabled', True)
End If



If iw_parent.classname() = 'w_contract' Then
	
	if w_mdi.of_security_access(6937) 	> 0 then li_AddQueue	= 1	//02.12.2009 By Jervis Batch import document queue.
	
	CHOOSE CASE li_setting
		CASE 0	//OFF
		CASE 1	//Buy/Sell
			if w_mdi.of_security_access( 6901 ) > 0 then li_addbuy = 1
			if w_mdi.of_security_access( 6902 ) > 0 then li_addsell = 1
			if w_mdi.of_security_access( 6926 ) > 0 then li_addother = 1	
					
			//li_temp = li_addbuy + li_addsell + li_addother 
			li_temp = li_addbuy + li_addsell + li_addother + li_AddQueue //02.12.2009 By Jervis
		
			If li_temp = 0 then
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add,'toolbaritemvisible', False)
			Elseif li_temp = 1 then
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add,'toolbaritemvisible', True) //added by alfee 04.23.2007
				//Start Code By Jervis 02.12.2009
				//m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.dropdown= False //commented by alfee 05.16.2007, it will cause a Web bug.
				//m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.dropdown= False
				//End code By Jervis 02.12.2009
			Else
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add,'toolbaritemvisible', True)	//added by alfee 04.23.2007
				//Start Code By Jervis 02.12.2009
				//m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.dropdown= True
				//m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.dropdown= True
				//End code By Jervis 02.12.2009
			End If
			
			If w_mdi.of_security_access( 6901 ) = 0 Then
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addbuy,'toolbaritemvisible', False)
			ElseIf w_mdi.of_security_access( 6901 ) = 1 Then  //(Appeon)Harry 10.10.2015 - Bud_id#4773
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addbuy,'toolbaritemvisible', True)	
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addbuy,'enabled', False)
			Else
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addbuy,'toolbaritemvisible', True)			
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addbuy,'enabled', True)
				//Set Current Menu Item  by Jervis 02.12.2009
				if li_temp = 1 then m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.CurrentItem =m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addbuy
			End If		
			If w_mdi.of_security_access( 6902 ) = 0 Then
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addsell,'toolbaritemvisible', False)
			ElseIf w_mdi.of_security_access( 6902 ) = 1 Then  //(Appeon)Harry 10.10.2015 - Bud_id#4773
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addsell,'toolbaritemvisible', True)
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addsell,'enabled', False)
			Else
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addsell,'toolbaritemvisible', True)
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addsell,'enabled', True)
				//Set Current Menu Item  by Jervis 02.12.2009
				if li_temp = 1 then m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.CurrentItem =m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addsell
			End If
			If w_mdi.of_security_access( 6926 ) = 0 Then
				//m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addother.toolbaritemvisible = False
			Else
				//m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addother.toolbaritemvisible = True
				//m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addother.enabled = True
				//Set Current Menu Item  by Jervis 02.12.2009
				if li_temp = 1 then
					//m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.CurrentItem =m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addother
				end if
			End If
			
			//Add 'From queue' menu Item by jervis 02.12.2009
			if w_mdi.of_security_access(6937) 	> 0  then
				//Set Current Menu Item  by Jervis 02.12.2009
				if li_temp = 1 then m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.CurrentItem =m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_fromqueue
			end if
			
		CASE 2	//Sell
			if w_mdi.of_security_access( 6902 ) > 0 then li_addsell = 1
			if w_mdi.of_security_access( 6926 ) > 0 then li_addother = 1		
			//li_temp = li_addother + li_addsell
			li_temp = li_addother + li_addsell + li_AddQueue //02.12.2009 By Jervis
			
			If li_temp = 0 then
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add,'toolbaritemvisible', False)
			Elseif li_temp = 1 then
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add,'toolbaritemvisible', True)
				//m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.dropdown= False
			Else
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add,'toolbaritemvisible', True)
				//m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.dropdown= True
			End If
	
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addbuy,'toolbaritemvisible', False)			
			If w_mdi.of_security_access( 6902 ) = 0 Then
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addsell,'toolbaritemvisible', False)
			Else
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addsell,'toolbaritemvisible', True)
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addsell,'enabled', True)
				//Set Current Menu Item  by Jervis 02.12.2009
				if li_temp = 1 then m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.CurrentItem =m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addsell
			End If
			If w_mdi.of_security_access( 6926 ) = 0 Then
				//m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addother.toolbaritemvisible = False
			Else
				//m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addother.toolbaritemvisible = True
				//m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addother.enabled = True
				//Set Current Menu Item  by Jervis 02.12.2009
				if li_temp = 1 then
					//m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.CurrentItem =m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addother
				end if
			End If
			
			//Add 'From queue' menu Item by jervis 02.12.2009
			if w_mdi.of_security_access(6937) 	> 0  then
				//Set Current Menu Item  by Jervis 02.12.2009
				if li_temp = 1 then m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.CurrentItem =m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_fromqueue
			End If
		CASE 3	//Buy
			if w_mdi.of_security_access( 6901 ) > 0 then li_addbuy = 1
			if w_mdi.of_security_access( 6926 ) > 0 then li_addother = 1		
			//li_temp = li_addbuy + li_addother 	
			li_temp = li_addbuy + li_addother + li_addqueue
			
			If li_temp = 0 then
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add,'toolbaritemvisible', False)
			Elseif li_temp = 1 then
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add,'toolbaritemvisible', True)
				//m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.dropdown= False
			Else
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add,'toolbaritemvisible', True)
				//m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.dropdown= True
			End If		
			
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addsell,'toolbaritemvisible', False)
			If w_mdi.of_security_access( 6901 ) = 0 Then
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addbuy,'toolbaritemvisible', False)
			Else
				//m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.toolbaritemvisible = True
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addbuy,'toolbaritemvisible', True)			
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addbuy,'enabled', True)
				//Set Current Menu Item  by Jervis 02.12.2009
				if li_temp = 1 then m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.CurrentItem =m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addbuy
			End If
			If w_mdi.of_security_access( 6926 ) = 0 Then
				//m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addother.toolbaritemvisible = False
			Else
				//m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addother.toolbaritemvisible = True
				//m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addother.enabled = True
				//Set Current Menu Item  by Jervis 02.12.2009
				if li_temp = 1 then
					//m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.CurrentItem =m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addother
				end if
			End If
			
			//Add 'From queue' menu Item by jervis 02.12.2009
			if w_mdi.of_security_access(6937) 	> 0  then
				//Set Current Menu Item  by Jervis 02.12.2009
				if li_temp = 1 then m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.CurrentItem =m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_fromqueue
			End If
	End CHOOSE
Else
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add,'toolbaritemvisible', False)
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addbuy,'toolbaritemvisible', False)
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addsell,'toolbaritemvisible', False)
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_workflow0,'toolbaritemvisible', False)
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_edit.m_newcontract,'toolbaritemvisible', False)
	//gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_system.m_painters.m_contractdatascreenpainter,'toolbaritemvisible', False)
	//gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_system. m_painters.m_screensetup.m_contractdatascreenpainter,'toolbaritemvisible', False)  //(Appeon)Harry 01.28.2014 - V142 ISG-CLX
End If

If idw_current.rowcount() > 0 Then
	//For Check in & out
	If idw_current.getitemnumber(idw_current.getrow(),'level') = 1 Then
		// LEVEL 1
		If idw_current.object.revision_control[idw_current.getrow()] = "1" Then
			If idw_current.object.checkout_status[idw_current.getrow()] = "0" Then
				If w_mdi.of_security_access( 6911 ) = 0 Then
					gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkout,'toolbaritemvisible', False)	
				Else
					gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkout,'toolbaritemvisible', True)
					gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkout,'enabled', True)
					gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_revision0,'toolbaritemvisible', False)			
				End If
				
				//Allow to combine - jervis 04.23.2010
				if lower(mid(idw_current.object.doc_ext[idw_current.getrow()],1,3)) = "doc" then
					gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_combine,'toolbaritemvisible', True)
					gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_combine,'enabled', True)
				else
					gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_combine,'toolbaritemvisible', false)
				end if
					
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkin,'toolbaritemvisible', False)
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_undocheckout,'toolbaritemvisible', False)  //Add undo check out - jervis 10.27.2010
			//ElseIf idw_current.object.checkout_status[idw_current.getrow()] = "1" Then
			ElseIf idw_current.object.checkout_status[idw_current.getrow()] <> "0" Then	//Modified by Ken.Guo on 2009-03-27			
				If w_mdi.of_security_access( 6910 ) = 0 Then
					gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkin,'toolbaritemvisible', False)
				Else
					gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkin,'toolbaritemvisible', True)
					gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkin,'enabled', True)
					gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_revision0,'toolbaritemvisible', False)			
				End If
				//Don't allow to combine -- jervis 04.23.2010
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_combine,'toolbaritemvisible', false)
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkout,'toolbaritemvisible', False)	
				
				//Add undo check out - jervis 10.27.2010
				if Lower(idw_current.object.checkout_by[idw_current.getrow()]) = Lower(gs_user_id) then
					gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_undocheckout,'toolbaritemvisible', true) 
					gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_undocheckout,'enabled', true)  
				end if
			End If
		Else
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check,'toolbaritemvisible', False)	
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkin,'toolbaritemvisible', False)
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkout,'toolbaritemvisible', False)			
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_combine,'toolbaritemvisible', false) //Don't allow to combine -- jervis 04.23.2010
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_undocheckout,'toolbaritemvisible', false)  //Add undo check out - jervis 10.27.2010 
		End If
	End If
	
	//---------Begin Modified by (Appeon)Harry 06.28.2013 for  Bug 4638--------
	//-----------Begin Added by Alfee 05.07.2012 ------------------------------------------------------
	//<$Reason>Contract Document Status
	ll_status = tab_1.tabpage_browse.dw_browse.getitemnumber(tab_1.tabpage_browse.dw_browse.getrow(), 'status')			
	ls_doc_editable = gnv_data.of_getitem("code_lookup","custom_1", "Lookup_name = 'Contract Document Status' and lookup_code=" + String(ll_status) )
	If IsNull (ls_doc_editable) Then ls_doc_editable = "0"	
	//---------End Modfiied ------------------------------------------------------
	
	CHOOSE CASE tab_1.Selectedtab
		CASE 1	// BROWSE TAB
			//Show toolbars of browse tabpage
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_select,'toolbaritemvisible', True)	
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_select,'enabled', True)
			//---------Begin Modified by (Appeon)Harry 08.11.2015 for Bug 4638--------
			//gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_compare0,'toolbaritemvisible', True) //Alfee 07.23.2008			
			If w_mdi.of_security_access( 6990 ) = 0 Then
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_compare0,'toolbaritemvisible', false) 
			Else
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_compare0,'toolbaritemvisible', True)			
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_compare0,'enabled', True)			
			End If
			//---------End Modfiied ------------------------------------------------------
			If w_mdi.of_security_access( 6904 ) = 0 Then
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_report,'toolbaritemvisible', False)			
			Else
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_report,'toolbaritemvisible', True)			
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_report,'enabled', True)			
			End If
			If w_mdi.of_security_access( 6922 ) = 0 Then
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_delete0,'toolbaritemvisible', False)
			Else
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_delete0,'toolbaritemvisible', True)
				If m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkin.toolbaritemvisible = True Then
					gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_delete0,'enabled', False)	
				Else
					gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_delete0,'enabled', True)
				End If
			End If			
			If w_mdi.of_security_access( 6921 ) = 0 Then
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_revision0,'toolbaritemvisible', False)			
			Else
				If idw_current.getitemstring(idw_current.getrow(),'revision_control') = "0" Then
					gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_revision0,'toolbaritemvisible', True)				
					gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_revision0,'enabled', True)	
					gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkin,'toolbaritemvisible', False)
					gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkout,'toolbaritemvisible', False)	
					gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_delete0,'enabled', True)
					gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_undocheckout,'toolbaritemvisible', false)  //Add undo check out - jervis 10.27.2010 
					
				End If	
			End If	
			//Hide toolbars of preview tabpage
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_save0,'toolbaritemvisible', False)			
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_print0,'toolbaritemvisible', False)			
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_addclause,'toolbaritemvisible', False)					
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge,'toolbaritemvisible', False)	
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergefield,'toolbaritemvisible', False)			
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergedata,'toolbaritemvisible', False)	
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_insertreqmnt,'toolbaritemvisible', False)		
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_clausemap,'toolbaritemvisible', False)
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0,'toolbaritemvisible', False)	
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_refresh,'toolbaritemvisible', False)//Alfee 11.12.2007
			
			//---------Begin Modified by (Appeon)Harry 06.28.2013 for V141 ISG-CLX--------
			//Disable toolbars
			If ls_doc_editable <> "1" Then
				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkout.enabled = False //Alfee 05.07.2012
			End If
			//---------End Modfiied ------------------------------------------------------
			
		CASE 2	// PREVIEW TAB		
			//Show toolbars of perview tabpage
			If w_mdi.of_security_access( 6906 ) = 0 Then
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_print0,'enabled', False)			
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_print0,'toolbaritemvisible', False)
			Else
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_print0,'toolbaritemvisible', True)				
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_print0,'enabled', True)			
			End If
			If w_mdi.of_security_access( 6912 ) = 0 Then
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_save0,'toolbaritemvisible', False)
			Else
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_save0,'toolbaritemvisible', True)	
			End If
			If w_mdi.of_security_access( 6913 ) = 0 Then
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_addclause,'toolbaritemvisible', False)
			Else
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_addclause,'toolbaritemvisible', True)
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_addclause,'enabled', True)
			End If			
			If w_mdi.of_security_access( 6914 ) = 0 And w_mdi.of_security_access( 6915 ) = 0 Then
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge,'toolbaritemvisible', False)	
			Else
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge,'toolbaritemvisible', True)	
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge,'enabled', True)	
			End If			
			If w_mdi.of_security_access( 6914 ) = 0 Then
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergefield,'toolbaritemvisible', False)	
			Else
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergefield,'toolbaritemvisible', True)	
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergefield,'enabled', True)	
			End If	
			//Added By Ken.Guo 2009-06-30.
			If w_mdi.of_security_access( 6954 ) = 0 Then
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_insertreqmnt,'toolbaritemvisible', False)	
			Else
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_insertreqmnt,'toolbaritemvisible', True)	
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_insertreqmnt,'enabled', True)	
			End If			
			
			If w_mdi.of_security_access( 6915 ) = 0 Then
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergedata,'toolbaritemvisible', False)					
			Else
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergedata,'toolbaritemvisible', True)	
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergedata,'enabled', True)					
			End If			
			//--------Begin Added by Alfee 11.12.2007----------------------------------------------
			//use the rights on merge data for refresh temporarily
			If w_mdi.of_security_access( 6915 ) = 0 Then
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_refresh,'toolbaritemvisible', False)					
			Else
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_refresh,'toolbaritemvisible', True)	
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_refresh,'enabled', True)									
			End If 
			//--------End Added--------------------------------------------------------------------
			If w_mdi.of_security_access( 6917 ) = 0 Then
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_clausemap,'toolbaritemvisible', False)
			Else
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_clausemap,'toolbaritemvisible', True)
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_clausemap,'enabled', True)
			End If
			//----Appeon Begin added by alfee at 03.14.2007---------
			If w_mdi.of_security_access( 6921 ) = 0 Then
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_revision0,'toolbaritemvisible', False)			
			Else
				If idw_current.getitemstring(idw_current.getrow(),'revision_control') = "0" Then
					gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_revision0,'toolbaritemvisible', True)				
					gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_revision0,'enabled', True)	
				END IF
			END IF
			//----Appeon End --------------------------------------		
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0,'enabled', True)	
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0,'toolbaritemvisible', True)	

			If idw_current.object.level[idw_current.getrow()] = 1 Then
				If idw_current.object.checkout_status[idw_current.getrow()] = "0" Then
					If m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkin.toolbaritemvisible = True Then						
						gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_save0,'enabled', False)	
					Else
						gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_save0,'enabled', True)
					End If
				End If
			End If
			
			//Hide toolbars for buy contract	document
			ls_type = lower(idw_current.getitemstring(idw_current.getrow(),'doc_type'))
			If ls_type = "buy" or ls_type = "other" Then
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_addclause,'enabled', False)
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge,'enabled', False)	
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergefield,'enabled', False)	
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergedata,'enabled', False)
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_insertreqmnt,'toolbaritemvisible', False)		
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0,'enabled', False)	
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_refresh,'enabled', False)	//Alfee 11.12.2007
			End If
			
			//---------Begin Modified by (Appeon)Harry 06.28.2013 for V141 ISG-CLX--------
			//Hide toolbars for not current revision/readonly document
			//If inv_ole_utils_doc.of_isreadonly() OR idw_current.getitemnumber(idw_current.getrow(),'level') <> 1 Then
			If ls_doc_editable <> "1" OR inv_ole_utils_doc.of_isreadonly() OR idw_current.getitemnumber(idw_current.getrow(),'level') <> 1 Then
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_addclause,'enabled', False)				
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge,'enabled', False)	
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergefield,'enabled', False)	
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergedata,'enabled', False)
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_insertreqmnt,'toolbaritemvisible', False)		
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_save0,'enabled', False)		
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0,'enabled', False)	
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_refresh,'enabled', False)	//Alfee 11.12.2007				
			
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkout,'enabled', False) 
			End If
			//---------End Modfiied ------------------------------------------------------
			//Hide merge toolbar for document not from template
			If idw_current.getitemnumber(idw_current.getrow(),'level') = 1 THEN
				If idw_current.GetitemString(idw_current.getrow(),'base_type') <> '1' Then
					gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge,'enabled', False)	
					gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergefield,'enabled', False)	
					gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergedata,'enabled', False)
					gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_insertreqmnt,'toolbaritemvisible', False)		
					gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_refresh,'enabled', False)	//Alfee 11.12.2007					
				End If
			End If
			
			//Hide toolbars according to system setting
			If li_setting = 0 or li_setting = 3 Then //Off or Buy setting
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_addclause,'toolbaritemvisible', False)
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge,'toolbaritemvisible', False)	
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergefield,'toolbaritemvisible', False)	
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergedata,'toolbaritemvisible', False)
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0,'toolbaritemvisible', False)	
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_refresh,'toolbaritemvisible', False)	//Alfee 11.12.2007				
			End If
			
			//----------Added by Alfee 05.06.2007--------------------------------
			//Set merge data & clause map toolbars' status
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergedata,'toolbaritemdown', inv_ole_utils_doc.of_ismerged())
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_clausemap,'toolbaritemdown', tab_1.tabpage_preview.dw_clause.visible)
			//----------End Added------------------------------------------------
			
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add,'toolbaritemvisible', False)					
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addbuy,'toolbaritemvisible', False)			
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addsell,'toolbaritemvisible', False)
			
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_select,'toolbaritemvisible', False)			
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_report,'toolbaritemvisible', False)
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_compare0,'toolbaritemvisible', False) //Alfee 07.23.2008
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_delete0,'toolbaritemvisible', False)

			//Set readonly reason of document. 
			inv_ole_utils_doc.is_readonly_reason = ''
			If idw_current.object.level[idw_current.getrow()] = 1 Then
				//If idw_current.object.checkout_status[idw_current.getrow()] = "1" Then
				If idw_current.object.checkout_status[idw_current.getrow()] <> "0" Then	//Modified by Ken.Guo on 2009-03-27 
					inv_ole_utils_doc.is_readonly_reason = 'checkout'
				end if
			Else
				inv_ole_utils_doc.is_readonly_reason = 'history'
			End If
	End CHOOSE
	
	//Check Sertifi ICO. //Added By Ken.Guo 2011-05-30. 
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_sertify,'enabled', True)
	If gnv_data.of_getitem( 'icred_settings', 'esign', False) = '0' or idw_current.getrow() = 0 Then
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_sertify,'toolbaritemvisible', False) 
	Else
		If Len(idw_current.GetItemString(idw_current.getrow(),'es_docid')) > 0  Then
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_sertify,'toolbaritemvisible', True) 
			 //Added By Jay Chen 11-07-2013
			If idw_current.GetItemString(idw_current.getrow(),'esign_type') = 'sertifi'  Then 
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_sertify,'toolbaritemname', 'sertifi.png') 
			else
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_sertify,'toolbaritemname', 'echosign.png')
			end if
			//end add
		Else
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_sertify,'toolbaritemvisible', False) 
		End If
//		If idw_current.object.level[idw_current.getrow()] = 1 Then //For Level 1
//			If idw_current.GetItemString(idw_current.getrow(),'checkout_status') = '5' or &
//				idw_current.GetItemString(idw_current.getrow(),'checkout_status') = '6' Then
//					m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_sertify.toolbaritemvisible = True 
//			Else		
//					m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_sertify.toolbaritemvisible = False
//			End If
//		Else //For Level 2
//			If Len(idw_current.GetItemString(idw_current.getrow(),'es_docid')) > 0 And &
//				Pos(Lower(idw_current.GetItemString(idw_current.getrow(),'audit_status')) ,'check' ) > 0 Then
//				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_sertify.toolbaritemvisible = True 
//			Else
//				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_sertify.toolbaritemvisible = False
//			End If
//		End If

	End If
	
	//Set Web Approve Status ICO
	If idw_current.GetItemNumber(idw_current.getrow(),'approve_id') > 0 Then
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_approval,'toolbaritemvisible', True) 
	Else
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_approval,'toolbaritemvisible', False)
	End If		
	/*
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_approval,'enabled', True)
	If idw_current.object.level[idw_current.getrow()] = 1 Then //For Level 1
		If idw_current.GetItemString(idw_current.getrow(),'checkout_status') = '7' or &
			idw_current.GetItemString(idw_current.getrow(),'checkout_status') = '8' Then
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_approval,'toolbaritemvisible', True) 
		Else		
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_approval,'toolbaritemvisible', False)
		End If
	Else //For Level 2
		If idw_current.GetItemNumber(idw_current.getrow(),'approve_id') > 0 And &
			Pos(Lower(idw_current.GetItemString(idw_current.getrow(),'audit_status')) ,'check' ) > 0 Then
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_approval,'toolbaritemvisible', True) 
		Else
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_approval,'toolbaritemvisible', False)
		End If
	End If	
	*/
	
ELSE  //rowcount < 1
	If w_mdi.of_security_access( 6904 ) = 0 Then
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_report,'toolbaritemvisible', False)			
	Else
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_report,'toolbaritemvisible', True)			
	End If

	If w_mdi.of_security_access( 6922 ) = 0 Then
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_delete0,'toolbaritemvisible', False)
	Else
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_delete0,'toolbaritemvisible', True)
	End If
	
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_save0,'toolbaritemvisible', False)			
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check,'toolbaritemvisible', False)	
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkin,'toolbaritemvisible', False)			
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkout,'toolbaritemvisible', False)		
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_undocheckout,'toolbaritemvisible', false)  //Add undo check out - jervis 10.27.2010 
	
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_print0,'toolbaritemvisible', False)			
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_addclause,'toolbaritemvisible', False)					
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge,'toolbaritemvisible', False)	
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergefield,'toolbaritemvisible', False)			
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergedata,'toolbaritemvisible', False)	
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_insertreqmnt,'toolbaritemvisible', False)		
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_clausemap,'toolbaritemvisible', False)		
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0,'toolbaritemvisible', False)	
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_refresh,'toolbaritemvisible', False)	//Alfee 11.12.2007
	
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_select,'enabled', False)
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_report,'enabled', False)
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_properties0,'enabled', False)
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_compare0.enabled = False //Alfee 07.23.2008  modify by gavins 20120205
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0,'enabled', False)				
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_print0,'enabled', False)
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_saveas,'enabled', False)		
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkin,'enabled', False)
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkout,'enabled', False)
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_undocheckout,'enabled', false)  //Add undo check out - jervis 10.27.2010 
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_delete0,'enabled', False)	
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_revision0,'enabled', False) //added by alfee 07.19.2007
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_sertify,'toolbaritemvisible', False) //Added By Ken.Guo 2011-05-30. 
End If

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2009-07-01 By: Scofield
//$<Reason> Display the workflow button.

//m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_workflow0.toolbaritemvisible = False
If w_mdi.of_security_access( 6916 ) = 0 or (Not gb_workflow) or iw_parent.classname() <> 'w_contract' Then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_workflow0,'toolbaritemvisible', False)
Else
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_workflow0,'enabled', True)	
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_workflow0,'toolbaritemvisible', True)	
End If
//---------------------------- APPEON END ----------------------------

gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_addactioneitem,'toolbaritemvisible', False)			
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_deleteactioneitem,'toolbaritemvisible', False)			
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_letter,'toolbaritemvisible', False)	
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_fullscreen,'toolbaritemvisible', False)	

If is_doc_ext <> 'doc' Then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_addclause,'enabled', False)
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_clausemap,'enabled', False)
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_fullscreen,'enabled', False)
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergedata,'enabled', False)
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_addclause,'toolbaritemvisible', False)
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_clausemap,'toolbaritemvisible', False)
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_fullscreen,'toolbaritemvisible', False)
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge,'toolbaritemvisible', False)	
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergefield,'toolbaritemvisible', False)	
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_insertreqmnt,'toolbaritemvisible', False)		
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergedata,'toolbaritemvisible', False)	
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0,'toolbaritemvisible', False)		
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_refresh,'toolbaritemvisible', False)	//Alfee 11.12.2007	
End If

gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_email1,'toolbaritemvisible', False)

//12.29.2008 By Jervis Fixed BugK120207
m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.CurrentItem =  m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_output1

//--------Begin Added by Alfee 09.30.2007 -----------------
//Disable toolbars for the read only contract
tab_1.tabpage_preview.uo_2.uo_toolbar.of_set_readonly_toolbar(False)//Added By Ken.Guo 05/14/2012
IF lb_protect THEN
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add,'enabled', False)
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addbuy,'enabled', False)
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addsell,'enabled', False)
	//m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addother.enabled = False
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_addclause,'enabled', False)
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge,'enabled', False)	
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergedata,'enabled', False)
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergefield,'enabled', False)
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_insertreqmnt,'toolbaritemvisible', False)		
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkin,'enabled', False)
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkout,'enabled', False)
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_undocheckout,'enabled', false)  //Add undo check out - jervis 10.27.2010 
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0,'enabled', False)	
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_refresh,'enabled', False)	//Alfee 11.12.2007	
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_delete0,'enabled', False)	
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_revision0,'enabled', False) 
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_save0,'enabled', False)		

	tab_1.tabpage_preview.uo_2.uo_toolbar.of_set_readonly_toolbar(True) //Added By Ken.Guo 05/14/2012
END If	

If m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkin.enabled and m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkin.toolbaritemvisible Then
	ib_havecheckinright = True
Else
	ib_havecheckinright = False
End If

Event ue_set_secutiry2()

//--------End Added ---------------------------------------


w_mdi.setredraw(true)




end event

event ue_post_doc_changed;call super::ue_post_doc_changed;gnv_app.of_set_ezmenu_refresh_state( TRUE )//added by gavins 20130325
gnv_app.post of_Refresh_EZMenu( )//added by gavins 20130325


IF al_old_doc_id <> al_new_doc_id OR adc_old_revision <> adc_new_revision THEN 
//IF al_old_doc_id <> al_new_doc_id OR adc_old_revision <> adc_new_revision OR tab_1.tabpage_preview.dw_head.Rowcount() = 0 THEN	
	IF lower(is_doc_ext)='doc' THEN
		//gnv_appeondb.of_startqueue( ) //Don't add it into a queue - Alfee 08.23.2007
		//tab_1.tabpage_preview.dw_head.retrieve(al_new_doc_id) 
	   //of_filter_clause(al_new_doc_id,adc_new_revision)
		of_filter_clause(al_new_doc_id,adc_new_revision, FALSE) //Alfee 05.09.2008
		of_getclauserights() 
		//gnv_appeondb.of_commitqueue( )
	END IF
END IF

// Added by Davis, Don't delete
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.30.2007 By: Jack
//$<reason> Fix a defect.
this.event ue_set_security( )
/*
If ib_browse Then
	If tab_1.tabpage_browse.dw_browse.rowcount() > 0 Then
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkin,'toolbaritemvisible', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkout,'toolbaritemvisible', False)	
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_revision0,'toolbaritemvisible', False)	
		//For Check in & out
		If tab_1.tabpage_browse.dw_browse.getitemnumber(tab_1.tabpage_browse.dw_browse.getrow(),'level') = 1 Then
			// LEVEL 1
			If tab_1.tabpage_browse.dw_browse.object.revision_control[tab_1.tabpage_browse.dw_browse.getrow()] = "1" Then
				If tab_1.tabpage_browse.dw_browse.object.checkout_status[tab_1.tabpage_browse.dw_browse.getrow()] = "0" Then
					If w_mdi.of_security_access( 6911 ) = 0 Then
						gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkout,'toolbaritemvisible', False)	
					Else
						gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkout,'toolbaritemvisible', True)
						gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkout,'enabled', True)
						gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_delete0,'enabled', True)
					End If												
				ElseIf tab_1.tabpage_browse.dw_browse.object.checkout_status[tab_1.tabpage_browse.dw_browse.getrow()] = "1" Then
					If w_mdi.of_security_access( 6910 ) = 0 Then
						gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkin,'toolbaritemvisible', False)
					Else
						gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkin,'toolbaritemvisible', True)
						gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkin,'enabled', True)
						gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_delete0,'enabled', False)
					End If
				End If
			End If
		End If
		If w_mdi.of_security_access( 6921 ) = 0 Then
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_revision0,'toolbaritemvisible', False)			
		Else
			If tab_1.tabpage_browse.dw_browse.getitemstring(tab_1.tabpage_browse.dw_browse.getrow(),'revision_control') = "0" Then
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_revision0,'toolbaritemvisible', True)				
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_revision0,'enabled', True)	
			End If	
		End If											
	End If
End If
*/

If tab_1.tabpage_browse.dw_browse.rowcount() = 0 Then
	tab_1.tabpage_preview.enabled = False
End If	
//---------------------------- APPEON END ----------------------------
If tab_1.SelectedTab = 2 Then 	Post of_SetHistoryToolBar( 3 )//add by gavins 20120203
return 1
end event

event resize;call super::resize;//-------------Appeon Begin -----by Derek at 03.13.2007---------
//tab_1.tabpage_preview.cb_1.x = tab_1.width - 112
//-------------Appeon end --------------------------------------

//Start code by Jervis 05.29.2008
//Fixed BugG052902(PB&WEB p2)
this.tab_1.tabpage_browse.dw_filter.of_resize( )
this.tab_1.tabpage_browse.dw_browse.of_resize( )
this.tab_1.tabpage_browse.dw_detail.of_resize( )//add by gavins 20120214
//End code By Jervis 05.29.2008

//Added By Ken.Guo 02/16/2012. 
st_docinfo.height = 56
st_docinfo.y =  tab_1.y + tab_1.height - st_docinfo.height - 15
st_docinfo.x = tab_1.x + 900
st_docinfo.width =  tab_1.width - 900 - 10
//st_docinfo.x = tab_1.x + tab_1.width - 900 - st_docinfo.width

tab_1.tabpage_preview.ole_doc.width =  tab_1.tabpage_browse.dw_filter. width - tab_1.tabpage_preview.ole_doc.x  //For bug 3244 - alfee 08.31.2012  //(Appeon)Harry 06.28.2013 - V141 ISG-CLX

end event

event destructor;call super::destructor;//Close comparison window - Alfee 07.23.2008
IF IsValid(inv_dm_comparison) THEN
	inv_dm_comparison.of_close_comparison('dm')
	Destroy inv_dm_comparison 
END IF
	
Destroy inv_filesvr
Destroy ids_clause_temp
Destroy ids_clause_right
Destroy ids_changes
Destroy ids_infomsg
Destroy ids_clause_approved //added by Alfee 05.28.2007
Destroy ids_template_clause_rules_result //11.12.2007

If isvalid(inv_ocr) Then Destroy inv_ocr //Added By Ken.Guo 2009-10-20.


end event

event ue_initinstancevar;call super::ue_initinstancevar;il_preview_doc_id = -1
il_preview_level = 0
il_clause_approved = 0
idc_preview_revision = 1
is_filter = ""
is_doc_ext = ""
is_doc_right = ""
is_clause_right = ""
is_opened_file = ""
is_search_text = ""
idt_modify_date = DateTime(1900-01-01, 00:00:00)
ib_locate = true
ib_locate_change = true
ib_showclausemap = false
ib_retrieving = false
ib_add_sell = false
ib_browse = false
ib_merged_data = false
ib_allowtrack = true
ib_allowcheckrights = true
ib_allow_approve_reject = true
is_OldSort = "D"
is_OldSortColumn = ""
end event

type st_1 from u_tabpg_contract_master`st_1 within u_tabpg_dm_data
long backcolor = 67108864
end type

type tab_1 from tab within u_tabpg_dm_data
integer width = 3845
integer height = 1888
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
boolean powertips = true
tabposition tabposition = tabsonbottom!
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

event selectionchanged;String 	ls_searchtext[] // - Alfee 07.18.2008
long		ll_Row,ll_RowCnts,ll_Right
DateTime		ldt_LastDateTime
Long				ll_Find

gnv_app.of_set_ezmenu_refresh_state( TRUE )//added by gavins 20130325

// Set toolbar
If ib_browse Then
	parent.event ue_set_security( )
End If

If newindex = 1 Then	tabpage_browse.setredraw( false )

ib_browse = True

//Reset doc info-jervis 02.26.2009
st_docinfo.text = ""


gnv_app.post of_Refresh_EZMenu( )//added by gavins 20130325

//BEGIN---Modify by Scofield on 2010-03-26
if IsValid(m_pfe_cst_mdi_menu_contract_am) then
	ll_Right = w_mdi.of_security_access(6924)
	if ll_Right <> 0 and NewIndex = 1 then
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_view.m_filter,'ToolbarItemVisible', true)
		if tabpage_browse.dw_filter.Visible then
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_view.m_filter,'ToolbarItemDown', True)
		else
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_view.m_filter,'ToolbarItemDown', False)
		end if
	else
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_view.m_filter,'ToolbarItemVisible', false)
	end if
	
	
end if
//END---Modify by Scofield on 2010-03-26

//for preview tabpage
if NewIndex = 2 then
	//BEGIN---Modify by Scofield on 2009-05-06
	ll_Row = tabpage_browse.dw_browse.GetRow()
	ll_RowCnts = tabpage_browse.dw_browse.RowCount()
	if ll_Row > 0 and ll_Row <= ll_RowCnts and il_doc_id <= 0 then
		tabpage_browse.dw_browse.Event RowFocusChanged(ll_Row)
	end if
	//END---Modify by Scofield on 2009-05-06
	
	event ue_preview(il_doc_id,idc_revision,is_doc_ext)
	
	//Find text in document for Contract Global Search - Alfee 07.18.2008
	if Len(Trim(is_search_text)) > 0 and il_preview_doc_id = il_doc_id and &
		idc_preview_revision = idc_revision and ( Lower(is_doc_ext) = 'doc' ) then  //Added 'Lower(is_doc_ext) = 'doc'' //Added By Ken.Guo 2009-10-20.
		//Parse the search text into an array
		of_parse_searchtext(is_search_text, ls_searchtext)
		//Find in the document with the array of search text 
		inv_ole_utils_doc.of_find_text(ls_searchtext)
		//Reset the search text variable
		is_search_text = ""
	end if
	
	//BEGIN---Modify by Scofield on 2009-07-13
	if IsValid(w_DocWFStepStatus) then 
		Show(w_DocWFStepStatus)
	else
		Open(w_DocWFStepStatus)
	end if
	//END---Modify by Scofield on 2009-07-13
	

else
	//if IsValid(w_DocWFStepStatus) then Hide(w_DocWFStepStatus)		//Added by Scofield on 2009-07-13
	if IsValid(w_DocWFStepStatus) then close(w_DocWFStepStatus)		//APB Bug - jervis 01.24.2011
		
end if



If IsValid( idw_LastDW ) Then

	If newindex = 1 Then //Added if statement By Ken.Guo 02/08/2012. 
		idw_LastDW.SetFocus( )//add by gavins 20120202
	End If
	

End If
If newindex = 1 Then 	tabpage_browse.setredraw( true )


end event

type tabpage_browse from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 16
integer width = 3808
integer height = 1760
long backcolor = 79741120
string text = "Browse"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "custom065!"
long picturemaskcolor = 12632256
string powertiptext = "Browse"
st_vsplitbar st_vsplitbar
dw_browse dw_browse
dw_filter dw_filter
dw_detail dw_detail
end type

on tabpage_browse.create
this.st_vsplitbar=create st_vsplitbar
this.dw_browse=create dw_browse
this.dw_filter=create dw_filter
this.dw_detail=create dw_detail
this.Control[]={this.st_vsplitbar,&
this.dw_browse,&
this.dw_filter,&
this.dw_detail}
end on

on tabpage_browse.destroy
destroy(this.st_vsplitbar)
destroy(this.dw_browse)
destroy(this.dw_filter)
destroy(this.dw_detail)
end on

type st_vsplitbar from u_st_splitbar within tabpage_browse
boolean visible = false
integer y = 1136
integer width = 3822
integer height = 12
integer ii_style = 2
end type

event constructor;call super::constructor;//regist split bar
//---------Begin Modified by (Appeon)Harry 05.06.2014 for V142 ISG-CLX--------
/*
tab_1.tabpage_browse.st_vsplitbar.of_register( tab_1.tabpage_browse.dw_browse, 3 )
tab_1.tabpage_browse.st_vsplitbar.of_register( tab_1.tabpage_browse.dw_detail, 4 )
tab_1.tabpage_browse.st_vsplitbar.of_SetMinobjectsize( 300 )
*/
//Modified By Jay Chen 04-03-2014
if is_parent_window = 'w_documents_browse' Then
	tab_1.tabpage_browse.st_vsplitbar.of_register( tab_1.tabpage_browse.dw_filter, 3 )
	tab_1.tabpage_browse.st_vsplitbar.of_register( tab_1.tabpage_browse.dw_browse, 4 )
	tab_1.tabpage_browse.st_vsplitbar.of_SetMinobjectsize( 300 )
else
	tab_1.tabpage_browse.st_vsplitbar.of_register( tab_1.tabpage_browse.dw_browse, 3 )
	tab_1.tabpage_browse.st_vsplitbar.of_register( tab_1.tabpage_browse.dw_detail, 4 )
	tab_1.tabpage_browse.st_vsplitbar.of_SetMinobjectsize( 300 )
end if
//---------End Modfiied ------------------------------------------------------
end event

event mousemove;call super::mousemove;//---------Begin Modified by (Appeon)Harry 05.06.2014 for V142 ISG-CLX--------
//gnv_user_option.of_Set_option_value( gs_user_id, "tabpage_image.tab_1.tabpage_data.tab_1.tabpage_browse.st_vsplitbar",string( this.y / tab_1.tabpage_browse.height ) )
if is_parent_window = 'w_documents_browse' then //Added By Jay Chen 04-03-2014
	gnv_user_option.of_Set_option_value( gs_user_id, "w_documents_browse.tab_1.tabpage_browse.st_vsplitbar",string( this.y / tab_1.tabpage_browse.height ) )
else
	gnv_user_option.of_Set_option_value( gs_user_id, "tabpage_image.tab_1.tabpage_data.tab_1.tabpage_browse.st_vsplitbar",string( this.y / tab_1.tabpage_browse.height ) )
end if
//---------End Modfiied ------------------------------------------------------

end event

event lbuttonup;call super::lbuttonup;of_Set_object_Resize( )//add by gavins 20120216
end event

type dw_browse from u_dw_contract within tabpage_browse
event ue_sort ( string as_column )
event ue_rowfocuschanged ( long al_row )
string tag = "Document Browse"
integer y = 536
integer width = 3822
integer height = 592
integer taborder = 30
boolean titlebar = true
string title = "Document Browse"
string dataobject = "d_dm_doc_tree"
boolean hscrollbar = true
boolean border = false
string dataobject_original = "d_dm_doc_tree"
end type

event ue_sort(string as_column);long ll_Row
long ll_RowCount
long ll_doc_id
string ls_CurrentSort

this.SetRedraw(false)

// Get current doc_id
ll_Row = this.GetRow()
if ll_Row <= 0 then Return
ll_doc_id = this.GetItemNumber(ll_Row, "doc_id")

// Delete rows those belong to level 2
this.SetFilter("level = 1")
this.Filter()
this.RowsMove(1, this.FilteredCount(), Filter!, this, 1, Delete!)
this.RowsDiscard(1, this.DeletedCount(), Delete!)
this.SetFilter(is_Filter)
this.Filter()

ll_RowCount = this.RowCount()
for ll_Row = 1 to ll_RowCount
	this.SetItem(ll_Row, "style", "+")
next

// Sort clicked column
if as_Column <> is_OldSortColumn then
	is_OldSort = "D"
	is_OldSortColumn = as_Column
end if
if is_OldSort = "D" then
	ls_CurrentSort = " A"
	is_OldSort = "A"
else
	ls_CurrentSort = " D"
	is_OldSort = "D"
end if

choose case Lower(as_Column)
	case "category"
		this.SetSort("doc_type" + ls_CurrentSort + ", LookUpDisplay(category)" + ls_CurrentSort)
	case "doc_ext"
		this.SetSort("Upper(doc_ext)" + ls_CurrentSort)
	case "current_version"
		this.SetSort("revision" + ls_CurrentSort)
	case "status"
		this.SetSort("LookUpDisplay(status)" + ls_CurrentSort)
	case else
		this.SetSort(as_Column + ls_CurrentSort)
end choose
this.Sort()

// Locate the old row after sort
ll_Row = this.Find("doc_id = " + String(ll_doc_id), 1, this.Rowcount())
if ll_Row <= 0 then ll_Row = 1
this.Scrolltorow(ll_Row)
this.Event RowFocusChanged(ll_Row)
	
this.SetRedraw(true)
end event

event ue_rowfocuschanged(long al_row);//====================================================================
// Event: ue_RowFocusChanged()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    long    al_Row
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-04-22
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

//if Tab_1.SelectedTab = 2 then Return    //Commented By Ken.Guo 2009-05-15

This.Event RowFocusChanged(al_Row)

end event

event clicked;call super::clicked;long  ll_doc_id
int  li,li_new,li_rows,li_Find
//---Alfee 07.24.2008-----
Long ll_cnt, ll_found 
Decimal ldc_revision
String ls_find, ls_flag, ls_current_flag
Boolean lb_comparison = FALSE 
//--------------------------

If row = 0 And    this.PointerX( ) <  Integer( describe( "compute_1.width" ) ) + 20  + xpos  and xpos > 0 Then Return 1

//BEGIN---Add by Evan on 05/22/2008
if Lower(dwo.Type) = "text" then	
	String ls_Column
	ls_Column = dwo.Name
	ls_Column = Left(ls_Column, Len(ls_Column) - 2)
	this.Event ue_Sort(ls_Column)	
end if
//END---Add by Evan on 05/22/2008

if row < 1 then return

ll_doc_id = this.getitemnumber(row,'doc_id')

//if dwo.name='p_1' then
If row > 0 Then //modify by gavins 20120131
	ib_controalinsert = true
//	//----------------------------------------------//add by gavins 20120131 judge selectmultirow
//	li_rows = this.GetselectedRow( 0 )
//	If li_Rows > 0 Then
//		If this.GetSelectedRow( li_Rows ) > 0 Then
//			dw_detail.Reset( )	
//		Else
//			//---------------------------------------------//
//			SetPointer(HourGlass!) //Alfee 03.13.2008
//			dw_detail.Setredraw( false )
//			ib_detailrow = true
//			
//			dw_detail.Reset( ) // modify by gavins 20120131

//	If IsValid( w_dm_comparison_wizard ) Then
//		If inv_dm_comparison.is_step = 'source' Then
//			//Determine if it's in a document comparison process
//			IF IsValid(inv_dm_comparison) THEN //Alfee 07.24.2008
//				ll_cnt = inv_dm_comparison.ids_target_docs.RowCount()
//				IF ll_cnt > 0 THEN
//					IF inv_dm_comparison.ids_target_docs.Find("doc_id = " + String(ll_doc_id), 1, ll_cnt) > 0 THEN
//						lb_comparison = TRUE	
//						ls_current_flag = this.GetItemString(row, "compare_status")
//					END IF
//				END IF
//			END IF
//		Else
//			If  IsValid(inv_dm_comparison) then //For document comparison functionality - alfee 07.23.2008	
//				inv_dm_comparison.of_select_document(row)	
//			end if
//		End If
//	End If
//		
//			//Add rows
//			n_ds  ds_audit
//			
//			ds_audit = create n_ds 
//			ds_audit.dataobject = 'd_dm_doc_audit_all'
//			ds_audit.settransobject( sqlca)
//			li_rows = ds_audit.retrieve( ll_doc_id)
//			li_new = row+1
//			for li = 1 to li_rows
//				li_new = dw_detail.insertrow(li_new)
//				dw_detail.setitem(li_new,'row',li_new)
//				dw_detail.setitem(li_new,'doc_id',ll_doc_id)
//				dw_detail.setitem(li_new,'level',2)		
//				dw_detail.setitem(li_new,'revision',this.getitemdecimal(row,'revision'))
//				dw_detail.setitem(li_new,'doc_type',this.getitemstring(row,'doc_type'))
//				dw_detail.setitem(li_new,'doc_name',this.getitemstring(row,'doc_name'))
//				dw_detail.setitem(li_new,'audit_version',ds_audit.getitemdecimal(li,'revision'))
//				dw_detail.setitem(li_new,'audit_status',ds_audit.getitemstring(li,'action'))
//				dw_detail.setitem(li_new,'audit_date',ds_audit.getitemdatetime(li,'action_date'))
//				dw_detail.setitem(li_New,'doc_ext',ds_audit.getitemstring(li,'doc_ext')) //For Compare function
//				dw_detail.setitem(li_New,'audit_doc_ext',ds_audit.getitemstring(li,'doc_ext'))
//				dw_detail.setitem(li_new,'audit_user',ds_audit.getitemstring(li,'action_by'))
//				dw_detail.setitem(li_new,'audit_note',ds_audit.getitemstring(li,'notes'))
//		
//				//Added By Ken.Guo 2011-06-13. 
//				dw_detail.setitem(li_New,'es_apicode',ds_audit.getitemstring(li,'es_apicode'))
//				dw_detail.setitem(li_New,'es_fileid',ds_audit.getitemstring(li,'es_fileid'))
//				dw_detail.setitem(li_New,'es_docid',ds_audit.getitemstring(li,'es_docid'))
//				dw_detail.setitem(li_New,'es_sender',ds_audit.getitemstring(li,'es_sender'))
//				dw_detail.setitem(li_New,'es_sender_email',ds_audit.getitemstring(li,'es_sender_email'))			
//				
//				dw_detail.setitem(li_New,'approve_id',ds_audit.getitemnumber(li,'approve_id'))		
//				
//				//Restore the comparison flag - Alfee 07.24.2008
//				IF lb_comparison THEN 
//					ldc_revision = ds_audit.getitemdecimal(li,'revision')
//					ls_flag = inv_dm_comparison.of_get_flag(ll_doc_id, ldc_revision)
//					IF ls_flag <> "" THEN dw_detail.setitem(li_new,'compare_status', ls_flag)
//				END IF					
//				li_new = li_new+1
//			next
//			this.setitem(row,'style','-')
//			destroy ds_audit
//		
//			If dw_detail.RowCount( ) > 0 Then 
//				dw_detail.selectrow( 0, false )
//				dw_detail.Selectrow( 1, true )
//			End If
//			dw_detail.Setredraw( true )
//		//elseif dwo.name='p_2' then  //modify by gavins 20120131
//		//	of_collapse_row(ll_doc_id, row)
//		end if
//	End If
End If

//If  IsValid(inv_dm_comparison) then //For document comparison functionality - alfee 07.23.2008	
//	inv_dm_comparison.of_select_document(row)	
//end if

Choose Case dwo.name
	Case 'p_9','p_10'
					
End Choose



end event

event constructor;call super::constructor;of_setrowselect( true)
this.inv_rowselect.of_setignorewin95(true)
this.inv_rowselect.of_setstyle( inv_rowselect.extended )

this.of_setupdateable( false)
this.ib_rmbmenu=false

this.Event ue_populatedddws()
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-02-25 By: Rodger Wu (add other)
/* This datawindow needs to add Other ddlb and resize. */
//---------------------------- APPEON END ----------------------------

//Added By Mark Lee 08/06/12
this.of_set_idle_flag( False)
end event

event doubleclicked;call super::doubleclicked;
if row > 0 then
	
	//Show Sertifi Status.
	Choose Case dwo.name 
		Case 'p_9','p_10'
			of_show_sertifi_status(row)
			Return			
	End Choose
	
	//Switch to Preview Tab
	tab_1.selecttab(2)
end if
end event

event rbuttondown;//====================================================================
// Event: rbuttondown()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    integer     xpos
// 	value    integer     ypos
// 	value    long        row
// 	value    dwobject    dwo
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-05-13
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Contractlogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

m_document_manager_browse	lm_Menu
String ls_doc_ext,	 ls_primary_doc

event ue_set_security( )//

if This.iw_parent.ClassName() <> "w_contract" and This.iw_parent.ClassName() <> "w_documents_browse"  then Return

lm_Menu = Create m_document_manager_browse

if IsValid(m_pfe_cst_mdi_menu_contract_am) then
	gnv_app.of_modify_menu_attr( lm_Menu.m_addbuy,'Enabled', m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addbuy.Enabled)
	lm_Menu.m_addbuy.Visible = m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addbuy.ToolbarItemVisible
	
	gnv_app.of_modify_menu_attr( lm_Menu.m_addsell,'Enabled', m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addsell.Enabled)
	lm_Menu.m_addsell.Visible = m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addsell.ToolbarItemVisible
	
	//lm_Menu.m_addother.Enabled = m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addother.Enabled
	//lm_Menu.m_addother.Visible = m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addother.ToolbarItemVisible
	
	gnv_app.of_modify_menu_attr( lm_Menu.m_properties,'Enabled', m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_properties0.Enabled)
	lm_Menu.m_properties.Visible = m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_properties0.ToolbarItemVisible
	
	gnv_app.of_modify_menu_attr( lm_Menu.m_email,'Enabled', m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_email0.Enabled)
	lm_Menu.m_email.Visible = m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_email0.ToolbarItemVisible
	
	gnv_app.of_modify_menu_attr( lm_Menu.m_checkin,'Enabled', m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkin.Enabled)
	lm_Menu.m_checkin.Visible = m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkin.ToolbarItemVisible
	
	gnv_app.of_modify_menu_attr( lm_Menu.m_checkout,'Enabled', m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkout.Enabled)
	lm_Menu.m_checkout.Visible = m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkout.ToolbarItemVisible
	
	//Add combine - jervis 04.23.2010
	gnv_app.of_modify_menu_attr( lm_Menu.m_combine,'Enabled', m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_combine.Enabled)
	lm_Menu.m_combine.Visible = m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_combine.ToolbarItemVisible
	
	//Add undo check out - jervis 10.27.2010
	gnv_app.of_modify_menu_attr( lm_Menu.m_undocheckout,'Enabled', m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_undocheckout.Enabled)
	lm_Menu.m_undocheckout.Visible = m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_undocheckout.ToolbarItemVisible
	
	gnv_app.of_modify_menu_attr( lm_Menu.m_saveas,'Enabled', m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_saveas.Enabled)
	lm_Menu.m_saveas.Visible = m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_saveas.ToolbarItemVisible
	
	gnv_app.of_modify_menu_attr( lm_Menu.m_delete,'Enabled', m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_delete0.Enabled)
	lm_Menu.m_delete.Visible = m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_delete0.ToolbarItemVisible
	
	//Added By Ken.Guo 2011-06-22. 
	gnv_app.of_modify_menu_attr( lm_Menu.m_sertifi,'Enabled', m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_sertify.Enabled)
	lm_Menu.m_sertifi.Visible = m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_sertify.ToolbarItemVisible
	
	//Added By Ken.Guo 12/09/2011. 
	gnv_app.of_modify_menu_attr( lm_Menu.m_webapprovestatus,'enabled', m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_approval.enabled)
	lm_Menu.m_webapprovestatus.Visible = m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_approval.ToolbarItemVisible
	
	//Added By Ken.Guo 05/14/2012. Set to Invisible for readonly 
	gnv_app.of_modify_menu_attr( lm_menu.m_importemailitem,'enabled', m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addbuy.Enabled)
	lm_Menu.m_importemailitem.Visible = m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addbuy.ToolbarItemVisible
	
	IF gs_dbtype = "SQL" AND gnv_data.of_getitem('icred_settings' ,'set_48' , False ) = '1' Then
		lm_Menu.m_ocr.visible = True
	Else
		lm_Menu.m_ocr.visible = False
		lm_Menu.m_sep_2.visible = False
	End If
	
	//Added By Ken.Guo 2009-12-16.
	if this.RowCount() > 0 then
		ls_doc_ext = Lower(tab_1.tabpage_browse.dw_browse.getitemstring(tab_1.tabpage_browse.dw_browse.GetRow(),'doc_ext'))
		CHOOSE CASE Lower(ls_doc_ext)
			CASE 'bmp','tif','tiff','jpg','gif', 'doc','xls','xlsx','pdf'
				lm_Menu.m_openinnewwindow.visible = True
				lm_Menu.m_openindocumentmanagerselect.visible = True //Added By Ken.Guo 2011-05-05. for new menu
				If Lower(ls_doc_ext) = 'pdf' and gnv_data.of_getitem( 'icred_settings', 'openpdfwith', false) = '2' Then
					lm_Menu.m_openindocumentmanagerselect.visible = false //Added By Ken.Guo 2011-05-06. for Open PDF Mode
				End If
				
			Case Else
				lm_Menu.m_openinnewwindow.visible = False
				lm_Menu.m_openindocumentmanagerselect.visible = False
				lm_Menu.m_sep_1.visible = False
		End Choose
//		
//		If tab_1.tabpage_browse.dw_browse.getitemstring(tab_1.tabpage_browse.dw_browse.GetRow(),'checkout_status') <> '7' Then
//			lm_Menu.m_webapprovestatus.visible = False
//		End If
	end if
			
	//Do not Support OCR in the Document Browse Window.
	If (This.iw_parent.ClassName() <> "w_contract" ) or (Lower(ls_doc_ext) <> 'pdf' and Lower(ls_doc_ext) <> 'bmp' and Lower(ls_doc_ext) <> 'tif' and Lower(ls_doc_ext) <> 'tiff' and Lower(ls_doc_ext) <> 'jpg' and Lower(ls_doc_ext) <> 'gif' )Then
		lm_Menu.m_ocr.visible = False
		lm_Menu.m_sep_2.visible = False		
	End If
	
	//Begin - Added By Mark Lee 11/12/2012		//Added By Mark Lee 12/04/2012
	If This.iw_parent.ClassName() = "w_contract" Then 
		lm_Menu.m_setprimarydocument.visible = True
		gnv_app.of_modify_menu_attr( lm_Menu.m_setprimarydocument,'enabled', True)
		//If  this.RowCount() > 0 then 
		If  this.RowCount() > 0 and row > 0 then //(Appeon)Harry 03.27.2014 - V142 ISG-CLX
			ls_primary_doc =	this.GetItemString(row,'primary_doc')
			If not Isnull(ls_primary_doc) and trim(ls_primary_doc) = '1' Then
				gnv_app.of_modify_menu_attr( lm_Menu.m_setprimarydocument,'checked', True)
				ib_set_Primary_document = True
			Else
				gnv_app.of_modify_menu_attr( lm_Menu.m_setprimarydocument,'checked', False)
				ib_set_Primary_document = False
			End If
		Else
			gnv_app.of_modify_menu_attr( lm_Menu.m_setprimarydocument,'enabled', False)
			ib_set_Primary_document = False
		End If
	Else
		lm_Menu.m_setprimarydocument.visible = False
		gnv_app.of_modify_menu_attr( lm_Menu.m_setprimarydocument,'enabled', False)
		ib_set_Primary_document = False			
	End If
	//End - Added By Mark Lee 11/12/2012
	
	If ( this.iw_parent.classname( ) <>"w_contract") Then
		lm_Menu.m_History.Visible = False
		lm_menu.m_importemailitem.Visible = False
		lm_Menu.m_setprimarydocument.visible = False				//Added By Mark Lee 12/04/2012
		gnv_app.of_modify_menu_attr( lm_Menu.m_setprimarydocument,'enabled', False)				//Added By Mark Lee 12/04/2012
		ib_set_Primary_document = False									//Added By Mark Lee 12/04/2012	
	End If
	
	
	//Added By Ken.Guo 2011-04-13. 
//	Choose Case  Lower(ls_doc_ext) 
//		Case 'bmp','tif','tiff','jpg','gif', 'doc','xls','xlsx','pdf'  //'These' type file will show this menu.
			lm_Menu.m_openwithdefaultprogram.visible = True
//	End Choose

	lm_Menu.iw_parent = This.iw_parent	 //Added By Ken.Guo 2009-12-17.
	lm_Menu.iu_tabpg_dm_data = of_get_current_object()
end if


//Added By Ken.Guo 2011-04-13.
If w_mdi.of_security_access( 6909 ) = 0 Then //output->saveas
	lm_Menu.m_ocr.visible = False
	lm_Menu.m_sep_2.visible = False	
	lm_Menu.m_openwithdefaultprogram.visible = False
End If

//Added By Ken.Guo 05/14/2012
If (lm_Menu.m_checkout.Enabled = False or lm_Menu.m_checkout.Visible = False ) And &
	(lm_Menu.m_checkin.Enabled = False or lm_Menu.m_checkin.Visible = False ) Then
	lm_menu.m_ocr.visible = False
	lm_Menu.m_sep_2.visible = False	
End If


lm_Menu.PopMenu(w_mdi.PointerX(),w_mdi.PointerY())

Destroy lm_Menu

end event

event rowfocuschanged;call super::rowfocuschanged;IF ib_retrieving THEN return

String ls_checkout_status

IF Getrow() = 0 THEN RETURN
IF Rowcount() = 0 THEN RETURN
If il_BrowseRow = Currentrow Then Return

tab_1.tabpage_preview.enabled = TRUE

if currentrow >0 then
	//insert add by gavins 20120131
	of_insertdetail( this, dw_detail )
	
	of_setdocumentpreopen( this )
else
	tab_1.tabpage_preview.enabled = FALSE
end if
il_BrowseRow = currentrow


end event

event pfc_retrieve;call super::pfc_retrieve;n_ds   lds_doc
int li, li_rows,li_new
Long ll_doc_id, ll_row,ll_ctx_id
String		ls_Name

DataWindowChild	ldwc_Child

ll_doc_id = il_doc_id

lds_doc = create n_ds
lds_doc.dataobject = 'd_dm_doc_all'
lds_doc.settransobject( sqlca)
//Added By Mark Lee 08/06/12
lds_doc.of_set_idle_flag( False)

If Not IsValid( iw_parent ) Then
	this.of_getparentwindow( iw_parent) //add by gavins 20120201
End If

//li_Rows = lds_doc.retrieve(inv_contract_details.of_get_ctx_id( ))
If iw_parent.classname() = 'w_contract' Then
	ll_ctx_id = inv_contract_details.of_get_ctx_id()
Else
	ll_ctx_id = tab_1.tabpage_browse.dw_browse.getitemnumber(tab_1.tabpage_browse.dw_browse.getrow(),'ctx_id')
End If

//Refresh Sertifi Status //Added By Ken.Guo 2011-06-21. 
If gnv_data.of_getitem('security_users' ,'refresh_sertifi_dm' ,'user_id = "' + gs_user_id +'"' ) = '1' Then
	gnv_sertifi.of_refresh_sertifi_status(ll_ctx_id , 0)
	gnv_echosign.of_refresh_sertifi_status(ll_ctx_id , 0)  //Added By Jay Chen 10-21-2013
	 // (Appeon)Harry 07.11.2016 - for docusign
	gnv_docusign.ib_ping_server = false //Added By Jay Chen 07-24-2014
    gnv_docusign.of_refresh_sertifi_status(ll_ctx_id , 0) //Added By Jay Chen 04-09-2014
    gnv_docusign.ib_ping_server = true
End If

This.GetChild("doc_type",ldwc_Child)
ldwc_Child.SetTransObject(SQLCA)

//Retrieve document
gnv_appeondb.of_startqueue( )
	li_Rows = lds_doc.retrieve(ll_ctx_id)
	ldwc_Child.Retrieve()
gnv_appeondb.of_commitqueue( )

//Added By Ken.Guo 2010-01-14. Filter data by contract category access right.
of_filter_category(lds_doc) 
li_rows = lds_doc.RowCount()


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
	ls_Name = lds_doc.getitemstring(li,'received_from')
	If Right( ls_Name, 1 ) = ',' Then ls_Name = Left( ls_Name, Len( ls_Name ) -1 )
	this.setitem(li_New,'Doc_From_Name',ls_Name)//modified by gavins 20130218  Doc_From_Name
	this.setitem(li_New,'Received_By',lds_doc.getitemstring(li,'Received_By'))
	this.setitem(li_New,'Received_Date',lds_doc.getitemdatetime(li,'Received_Date'))
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
	this.setitem(li_New,'from_templete_id',lds_doc.getitemnumber(li,'from_templete_id'))	 //Added By Ken.Guo 2011-04-01.
	
	//Added By Ken.Guo 2011-06-13. 
	this.setitem(li_New,'es_apicode',lds_doc.getitemstring(li,'es_apicode'))
	this.setitem(li_New,'es_fileid',lds_doc.getitemstring(li,'es_fileid'))
	this.setitem(li_New,'es_docid',lds_doc.getitemstring(li,'es_docid'))
	this.setitem(li_New,'es_sender',lds_doc.getitemstring(li,'es_sender'))
	this.setitem(li_New,'es_sender_email',lds_doc.getitemstring(li,'es_sender_email'))	
	this.setitem(li_New,'approve_id',lds_doc.getitemnumber(li,'approve_id'))	
	this.setitem(li_New,'primary_doc',lds_doc.getitemString(li,'primary_doc'))				//Added By Mark Lee 10/29/2012
	this.setitem(li_New,'esign_type',lds_doc.getitemString(li,'esign_type')) //Added By Jay Chen 11-07-2013
	
	//Added by gavins 20130204
	this.setitem(li_New,'custom_1',lds_doc.getitemstring(li,'custom_1'))
	this.setitem(li_New,'custom_2',lds_doc.getitemstring(li,'custom_2'))
	this.setitem(li_New,'custom_3',lds_doc.getitemstring(li,'custom_3'))
	this.setitem(li_New,'custom_4',lds_doc.getitemstring(li,'custom_4'))
	this.setitem(li_New,'custom_5',lds_doc.getitemstring(li,'custom_5'))
	this.setitem(li_New,'custom_6',lds_doc.getitemstring(li,'custom_6'))
	this.setitem(li_New,'custom_7',lds_doc.getitemstring(li,'custom_7'))
	this.setitem(li_New,'custom_8',lds_doc.getitemstring(li,'custom_8'))
	this.setitem(li_New,'custom_9',lds_doc.getitemstring(li,'custom_9'))
	this.setitem(li_New,'custom_10',lds_doc.getitemstring(li,'custom_10'))
	this.setitem(li_New,'custom_n1',lds_doc.getitemnumber(li,'custom_n1'))
	this.setitem(li_New,'custom_n2',lds_doc.getitemnumber(li,'custom_n2'))
	this.setitem(li_New,'custom_n3',lds_doc.getitemnumber(li,'custom_n3'))
	this.setitem(li_New,'custom_n4',lds_doc.getitemnumber(li,'custom_n4'))
	this.setitem(li_New,'custom_n5',lds_doc.getitemnumber(li,'custom_n5'))
	this.setitem(li_New,'custom_n6',lds_doc.getitemnumber(li,'custom_n6'))
	this.setitem(li_New,'custom_n7',lds_doc.getitemnumber(li,'custom_n7'))
	this.setitem(li_New,'custom_n8',lds_doc.getitemnumber(li,'custom_n8'))
	this.setitem(li_New,'custom_n9',lds_doc.getitemnumber(li,'custom_n9'))
	this.setitem(li_New,'custom_n10',lds_doc.getitemnumber(li,'custom_n10'))
	this.setitem(li_New,'custom_date1',lds_doc.getitemdatetime(li,'custom_date1'))
	this.setitem(li_New,'custom_date2',lds_doc.getitemdatetime(li,'custom_date2'))
	this.setitem(li_New,'custom_date3',lds_doc.getitemdatetime(li,'custom_date3'))
	this.setitem(li_New,'custom_date4',lds_doc.getitemdatetime(li,'custom_date4'))
	this.setitem(li_New,'custom_date5',lds_doc.getitemdatetime(li,'custom_date5'))
	this.setitem(li_New,'custom_date6',lds_doc.getitemdatetime(li,'custom_date6'))
next

of_generate_filter()  //Added By Ken.Guo 10/10/2013
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
	Post Event ue_RowFocusChanged(ll_row)
ELSE
	Post Event ue_doc_changed( -1,-2, 0,0)
	dw_detail.Reset( ) //add by gavins 20120215
end if

destroy lds_doc

ib_retrieving=false
il_BrowseRow = 0

IF tab_1.Selectedtab = 2 THEN
	Post Event ue_preview(il_doc_id,idc_revision,is_doc_ext)
END IF

//Close comparison window - Alfee 07.23.2008
if IsValid(inv_dm_comparison) then inv_dm_comparison.of_close_comparison_wizard('dm') 

return li_rows
end event

event pfc_prermbmenu;call super::pfc_prermbmenu;am_dw.m_table.m_insert.enabled = false
gnv_app.of_modify_menu_attr( am_dw.m_table.m_addrow,'enabled', false)
gnv_app.of_modify_menu_attr( am_dw.m_table.m_delete,'enabled', false)
end event

event resize;call super::resize;//of_resize()	//04.17.2008 By Jervis:resize dataobject
string	ls_zoom,  ls_height, ls_width, ls_objects[]

ls_zoom = this.describe( "datawindow.zoom" )




If Integer( ls_Zoom ) > 150 Then
	ls_height = string(  round(  56 * 100.0 /  double( ls_zoom  ),2 ) )
	ls_width =  string(  round(  55  * 100.0 /  double( ls_zoom  ),2) )
	
	ls_objects = {'p_5','p_6', 'p_primary_flag' }
	of_SetPictureSize( This, ls_Zoom, ls_objects ,'55', '56', ls_width, ls_height  )
	
	ls_height = string(  round( 64 * 100.0 /  double( ls_zoom  ),2 ) )
	ls_width =  string(  round( 73  * 100.0 /  double( ls_zoom  ),2) )	
	
	ls_objects = {'p_3','p_4', 'p_7','p_8', 'p_9','p_10', 'p_11','p_12' }
	of_SetPictureSize( This, ls_Zoom, ls_objects ,'73', '64', ls_width, ls_height  )
	ib_Zoom = True
Else
	If ib_Zoom Then
		ls_Zoom = '100'
	
		ls_objects = {'p_5','p_6', 'p_primary_flag' }
		of_SetPictureSize( This, ls_Zoom, ls_objects ,'55', '56','55', '56'  )
		
		ls_objects = {'p_3','p_4', 'p_7','p_8', 'p_9','p_10', 'p_11','p_12' }
		of_SetPictureSize( This, ls_Zoom, ls_objects ,'73', '64', '73', '64' )

		ib_Zoom = False
	End If
End If

//added by gavins 20120217
If this.y + this.Height > Parent.Height Or (  ib_browseZoom   and  this.y + this.height < Parent.Height - 10 and dw_detail.visible = false  )Then
	this.Height = Parent.Height - this.y - 10 
End If	


end event

event pfc_filterdlg;//BEGIN---Modify by Scofield on 2010-03-29  // modify by gavins  20120131
if dw_filter.Visible then 
	of_hidesearch()
Else
	
	if IsValid(m_pfe_cst_mdi_menu_contract_am) then
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_view.m_filter,'ToolbarItemVisible', true)
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_view.m_filter,'ToolbarItemDown', true)
	end if
	dw_filter.Visible = true
	If ii_ResizeWay = 1 Then
		Tab_1.TabPage_Browse.SetRedraw( false )
		Tab_1.TabPage_Browse.dw_Browse.Y = Tab_1.TabPage_Browse.dw_filter.Y + Tab_1.TabPage_Browse.dw_filter.height + 10
		If dw_detail.Visible Then
			Tab_1.tabpage_browse.st_vsplitbar.Visible = true
//			dw_Browse.Height = Parent.Height - il_BottomSpace - dw_Browse.Y - dw_detail.Height - 20
			Tab_1.TabPage_Browse.dw_Browse.Height = ( Tab_1.TabPage_Browse.Height  - Tab_1.TabPage_Browse.dw_filter.y - Tab_1.TabPage_Browse.dw_filter.Height - 10  ) / 2 -10
			Tab_1.tabpage_browse.st_vsplitbar.Y =  tab_1.tabpage_browse.dw_browse.Y  + tab_1.tabpage_browse.dw_browse.Height  + 4
			Tab_1.TabPage_Browse.dw_detail.Y = tab_1.tabpage_browse.st_vsplitbar.Y + tab_1.tabpage_browse.st_vsplitbar.height +  4
			Tab_1.TabPage_Browse.dw_detail.Height = tab_1.tabpage_browse.Height  - tab_1.tabpage_browse.st_vsplitbar.Y - tab_1.tabpage_browse.st_vsplitbar.Height - 10 
			of_set_splitbar_location( )
		Else
//			dw_Browse.Height = Parent.Height - il_BottomSpace - dw_Browse.Y - 20 
			Tab_1.tabpage_browse.st_vsplitbar.Visible = false
		
			Tab_1.TabPage_Browse.dw_Browse.Height = ( Tab_1.TabPage_Browse.Height  - Tab_1.TabPage_Browse.dw_filter.y - Tab_1.TabPage_Browse.dw_filter.Height ) - 10 
			
			tab_1.tabpage_browse.st_vsplitbar.Y = Tab_1.TabPage_Browse.dw_Browse.Y + Tab_1.TabPage_Browse.dw_Browse.Height + 4
		End If
	
		Tab_1.TabPage_Browse.SetRedraw( true )	
	ElseIf ii_ResizeWay = 2 Then
		dw_Browse.Y = dw_filter.Y + dw_filter.height + 20
		dw_Browse.Height = Parent.Height - il_BottomSpace - dw_Browse.Y - 20
	End If
	
End If
Tab_1.Tabpage_Browse.dw_browse.Width = Tab_1.TabPage_Browse.dw_Filter.Width
Tab_1.Tabpage_Browse.dw_detail.Width = Tab_1.TabPage_Browse.dw_Filter.Width



Return 1
//END---Modify by Scofield on 2010-03-29

end event

event rowfocuschanging;call super::rowfocuschanging;If This.ib_zoom_triggered Then Return 1 //Added By Ken.Guo 12/13/2011. 
end event

event getfocus;call super::getfocus;of_setdocumentpreopen( this )//add by gavins 20120212

idw_LastDW = This	
end event

type dw_filter from u_dw_contract within tabpage_browse
string tag = "Filter Criteria"
integer width = 3822
integer height = 524
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Filter Criteria"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
string dataobject_original = "d_dm_browse_filter"
end type

event buttonclicked;call super::buttonclicked;//---------Begin commented by Alfee 09.30.2007---------------------
//if of_check_read_only( ) then return success  //Add by Jack 08.30.2007
//---------End Commented ------------------------------------------

if row < 1 then return

IF dwo.name='b_go' then
	is_filter = of_generate_filter( )
ELSEIF dwo.name='b_clear' THEN
	this.deleterow(0)
	this.insertrow(0)
	is_filter = ""
//BEGIN---Modify by Scofield on 2010-03-29
elseif dwo.Name = "b_close" then
	of_HideSearch()
//END---Modify by Scofield on 2010-03-29
end if

dw_Browse.setfilter(is_filter)
dw_Browse.filter()
dw_Browse.sort()
dw_Browse.event rowfocuschanged(1)
//add by gavins 20120131
If dw_browse.RowCount( ) = 0 Then
	dw_detail.Reset( )
Else
	dw_browse.Event Clicked( 0,0,1, dw_browse.object.datawindow )
	dw_browse.Event RowFocusChanged( 1 )
End If

end event

event constructor;call super::constructor;this.of_setdropdowncalendar( true)
this.of_setupdateable( false)
this.ib_rmbmenu=false
//
long ll_row,ll_category,ll_find
datawindowchild ldwc_category
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

//Added By Ken.Guo 2010-02-25.
n_cst_right lnv_right
If gnv_data.of_getitem( 'icred_settings', 'filter_documents', False) = '1' Then
	If this.getchild('category',ldwc_category) = 1 Then
		ldwc_category.deleterow(2) //Delete  *Add lookup code*
		lnv_right = Create n_cst_right
		lnv_right.of_filter_right( ldwc_category, 'lookup_code', 1)
		Destroy lnv_right
	End If
End If

//---------Begin Commented by (Appeon)Harry  04.17.2014 for V142 ISG-CLX--------
//ue_populatedddws()
/*
//---------Begin Added by (Appeon)Harry 02.20.2014 for Bug # 3926-------
datawindowchild ldwc_child_type
this.GetChild( "doc_type",ldwc_child_type)
If ldwc_child_type.rowcount() >= 2 Then //Delete *Add Lookup Code* row
	ldwc_child_type.DeleteRow(2)
End If
//---------End Added ------------------------------------------------------
*/
//---------End Commented ------------------------------------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-02-25 By: Rodger Wu (add other)
/* This datawindow needs to add a Other ddlb. */
//---------------------------- APPEON END ----------------------------

of_HideSearch()		//Added by Scofield on 2010-04-26

end event

event resize;call super::resize;//of_resize()	//04.17.2008 By Jervis:resize dataobject
end event

event pfc_filterdlg;Return dw_browse.trigger event pfc_filterdlg()
end event

event ue_populatedddws;call super::ue_populatedddws;//d_dm_browse_filter  d_dm_new_sell_document
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

event clicked;call super::clicked;Long						ll_Find
Datawindowchild		dwchild

If dwo.Name = 'doc_type' and row > 0 then
	getchild( 'doc_type', dwchild )
	ll_find = dwchild.find("lookup_code = -777", 1, dwchild.rowcount())
	If ll_find > 0 Then 
		dwchild.deleterow( ll_find )
	end if
	
end if
end event

type dw_detail from u_dw_contract within tabpage_browse
event ue_sort ( string as_column )
string tag = "Document History"
integer y = 1152
integer width = 3822
integer height = 628
integer taborder = 41
boolean titlebar = true
string title = "Document History"
string dataobject = "d_dm_doc_tree_detail"
boolean hscrollbar = true
boolean border = false
boolean ib_use_row_selection = true
end type

event ue_sort(string as_column);//
long ll_Row
long ll_RowCount
long ll_doc_id
string ls_CurrentSort

this.SetRedraw(false)

// Get current doc_id
ll_Row = this.GetRow()
if ll_Row <= 0 then Return
ll_doc_id = this.GetItemNumber(ll_Row, "doc_id")

// Sort clicked column
if as_Column <> is_OldSortColumn then
	is_OldSort = "D"
	is_OldSortColumn = as_Column
end if
if is_OldSort = "D" then
	ls_CurrentSort = " A"
	is_OldSort = "A"
else
	ls_CurrentSort = " D"
	is_OldSort = "D"
end if

choose case Lower(as_Column)
	case "category"
		this.SetSort("doc_type" + ls_CurrentSort + ", LookUpDisplay(category)" + ls_CurrentSort)
	case "doc_ext"
		this.SetSort("Upper(doc_ext)" + ls_CurrentSort)
	case "current_version"
		this.SetSort("revision" + ls_CurrentSort)
	case "status"
		this.SetSort("LookUpDisplay(status)" + ls_CurrentSort)
	case else
		this.SetSort(as_Column + ls_CurrentSort)
end choose
this.Sort()

// Locate the old row after sort
ll_Row = this.Find("doc_id = " + String(ll_doc_id), 1, this.Rowcount())
if ll_Row <= 0 then ll_Row = 1
this.Scrolltorow(ll_Row)
this.Event RowFocusChanged(ll_Row)
	
this.SetRedraw(true)
end event

event pfc_filterdlg;call super::pfc_filterdlg;Return dw_browse.Event pfc_filterdlg( )  //add by gavins 20120131
end event

event rowfocuschanged;call super::rowfocuschanged;If  ib_detailrow Then Return

String ls_checkout_status

IF Getrow() = 0 THEN RETURN
IF Rowcount() = 0 THEN RETURN

tab_1.tabpage_preview.enabled = TRUE

if currentrow >0 then
	of_setdocumentpreopen( this )
	idt_LastDateTime = This.GetItemDateTime( currentrow, 'audit_date' )
else
	tab_1.tabpage_preview.enabled = FALSE
end if

end event

event rowfocuschanging;call super::rowfocuschanging;If This.ib_zoom_triggered Then Return 1 //Added By Ken.Guo 12/13/2011. 

If GetFocus( ) <> This Then Return 1
end event

event getfocus;call super::getfocus;ib_detailrow = false//add by gavin 20120131

If GetselectedRow( 0 ) > 0 Then Event RowFocusChanged( GetselectedRow( 0 ) )

idw_LastDW = This
end event

event losefocus;call super::losefocus;ib_detailrow = true
end event

event rbuttondown;//====================================================================
// Event: rbuttondown()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    integer     xpos
// 	value    integer     ypos
// 	value    long        row
// 	value    dwobject    dwo
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-05-13
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Contractlogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

m_document_manager_browse	lm_Menu
String ls_doc_ext

If row < 1 Then Return // add by gavins 20120131

if This.iw_parent.ClassName() <> "w_contract" and This.iw_parent.ClassName() <> "w_documents_browse"  then Return

lm_Menu = Create m_document_manager_browse

if IsValid(m_pfe_cst_mdi_menu_contract_am) then
	gnv_app.of_modify_menu_attr( lm_Menu.m_addbuy,'Enabled', m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addbuy.Enabled)
	lm_Menu.m_addbuy.Visible = m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addbuy.ToolbarItemVisible
	
	gnv_app.of_modify_menu_attr( lm_Menu.m_addsell,'Enabled', m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addsell.Enabled)
	lm_Menu.m_addsell.Visible = m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addsell.ToolbarItemVisible
	
	//lm_Menu.m_addother.Enabled = m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addother.Enabled
	//lm_Menu.m_addother.Visible = m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addother.ToolbarItemVisible
	
	gnv_app.of_modify_menu_attr( lm_Menu.m_properties,'Enabled', m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_properties0.Enabled)
	lm_Menu.m_properties.Visible = m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_properties0.ToolbarItemVisible
	
	gnv_app.of_modify_menu_attr( lm_Menu.m_email,'Enabled', m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_email0.Enabled)
	lm_Menu.m_email.Visible = m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_email0.ToolbarItemVisible
	
	gnv_app.of_modify_menu_attr( lm_Menu.m_checkin,'Enabled', m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkin.Enabled)
	lm_Menu.m_checkin.Visible = m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkin.ToolbarItemVisible
	
	gnv_app.of_modify_menu_attr( lm_Menu.m_checkout,'Enabled', m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkout.Enabled)
	lm_Menu.m_checkout.Visible = m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkout.ToolbarItemVisible
	
	//Add combine - jervis 04.23.2010
	gnv_app.of_modify_menu_attr( lm_Menu.m_combine,'Enabled', m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_combine.Enabled)
	lm_Menu.m_combine.Visible = m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_combine.ToolbarItemVisible
	
	//Add undo check out - jervis 10.27.2010
	gnv_app.of_modify_menu_attr( lm_Menu.m_undocheckout,'Enabled', m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_undocheckout.Enabled)
	lm_Menu.m_undocheckout.Visible = m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_undocheckout.ToolbarItemVisible
	
	gnv_app.of_modify_menu_attr( lm_Menu.m_saveas,'Enabled', m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_saveas.Enabled)
	lm_Menu.m_saveas.Visible = m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_saveas.ToolbarItemVisible
	
	gnv_app.of_modify_menu_attr( lm_Menu.m_delete,'Enabled', m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_delete0.Enabled)
	lm_Menu.m_delete.Visible = m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_delete0.ToolbarItemVisible
	
	//Added By Ken.Guo 2011-06-22. 
	gnv_app.of_modify_menu_attr( lm_Menu.m_sertifi,'Enabled', m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_sertify.Enabled)
	lm_Menu.m_sertifi.Visible = m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_sertify.ToolbarItemVisible
	
	//Added By Ken.Guo 12/09/2011. 
	gnv_app.of_modify_menu_attr( lm_Menu.m_webapprovestatus,'enabled', m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_approval.enabled)
	lm_Menu.m_webapprovestatus.Visible = m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_approval.ToolbarItemVisible
	
	IF gs_dbtype = "SQL" AND gnv_data.of_getitem('icred_settings' ,'set_48' , False ) = '1' Then
		lm_Menu.m_ocr.visible = True
	Else
		lm_Menu.m_ocr.visible = False
		lm_Menu.m_sep_2.visible = False
	End If
	
		lm_Menu.m_openinnewwindow.visible = True
		lm_Menu.m_openindocumentmanagerselect.visible = True
	
	//Added By Ken.Guo 2009-12-16.
	if this.RowCount() > 0 then
		ls_doc_ext = Lower(tab_1.tabpage_browse.dw_detail.getitemstring(tab_1.tabpage_browse.dw_detail.GetRow(),'doc_ext'))
		CHOOSE CASE Lower(ls_doc_ext)
			CASE 'bmp','tif','tiff','jpg','gif', 'doc','xls','xlsx','pdf'
				lm_Menu.m_openinnewwindow.visible = True
				lm_Menu.m_openindocumentmanagerselect.visible = True //Added By Ken.Guo 2011-05-05. for new menu
				If Lower(ls_doc_ext) = 'pdf' and gnv_data.of_getitem( 'icred_settings', 'openpdfwith', false) = '2' Then
					lm_Menu.m_openindocumentmanagerselect.visible = false //Added By Ken.Guo 2011-05-06. for Open PDF Mode
				End If
				
			Case Else
				lm_Menu.m_openinnewwindow.visible = False
				lm_Menu.m_openindocumentmanagerselect.visible = False
				lm_Menu.m_sep_1.visible = False
		End Choose
//		
//		If tab_1.tabpage_browse.dw_browse.getitemstring(tab_1.tabpage_browse.dw_browse.GetRow(),'checkout_status') <> '7' Then
//			lm_Menu.m_webapprovestatus.visible = False
//		End If
		
	end if
	
	//Do not Support OCR in the Document Browse Window.
	If (This.iw_parent.ClassName() <> "w_contract" ) or (Lower(ls_doc_ext) <> 'pdf' and Lower(ls_doc_ext) <> 'bmp' and Lower(ls_doc_ext) <> 'tif' and Lower(ls_doc_ext) <> 'tiff' and Lower(ls_doc_ext) <> 'jpg' and Lower(ls_doc_ext) <> 'gif' )Then
		lm_Menu.m_ocr.visible = False
		lm_Menu.m_sep_2.visible = False		
	End If
	
	//Added By Ken.Guo 2011-04-13. 
//	Choose Case  Lower(ls_doc_ext) 
//		Case 'bmp','tif','tiff','jpg','gif', 'doc','xls','xlsx','pdf'  //'These' type file will show this menu.
			lm_Menu.m_openwithdefaultprogram.visible = True
//	End Choose

	lm_Menu.iw_parent = This.iw_parent	 //Added By Ken.Guo 2009-12-17.
	lm_Menu.iu_tabpg_dm_data = of_get_current_object()
end if


//Added By Ken.Guo 2011-04-13.
If w_mdi.of_security_access( 6909 ) = 0 Then //output->saveas
	lm_Menu.m_ocr.visible = False
	lm_Menu.m_sep_2.visible = False	
	lm_Menu.m_openwithdefaultprogram.visible = False
End If

lm_Menu.PopMenu(w_mdi.PointerX(),w_mdi.PointerY())

Destroy lm_Menu

end event

event clicked;call super::clicked;long  ll_doc_id
int  li,li_new,li_rows,li_Find
//---Alfee 07.24.2008-----
Long ll_cnt, ll_found 
Decimal ldc_revision
String ls_find, ls_flag, ls_current_flag
Boolean lb_comparison = FALSE 

If row = 0 And    this.PointerX( ) <  Integer( describe( "compute_1.width" ) ) + 20  + xpos  and xpos > 0 Then Return 1

//--------------------------
//BEGIN---Add by Evan on 05/22/2008
if Lower(dwo.Type) = "text" then	
	String ls_Column
	ls_Column = dwo.Name
	ls_Column = Left(ls_Column, Len(ls_Column) - 2)
	this.Event ue_Sort(ls_Column)	
end if
//END---Add by Evan on 05/22/2008


If row < 1 Then Return


if IsValid(inv_dm_comparison) then //For document comparison functionality - alfee 07.23.2008	
	inv_dm_comparison.of_select_document(row)	
end if

end event

event constructor;call super::constructor;of_setrowselect( true)
this.inv_rowselect.of_setignorewin95(true)
this.inv_rowselect.of_setstyle( inv_rowselect.extended )

this.of_setupdateable( false)
this.ib_rmbmenu=false

this.Event ue_populatedddws()
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-02-25 By: Rodger Wu (add other)
/* This datawindow needs to add Other ddlb and resize. */
//---------------------------- APPEON END ----------------------------


end event

event doubleclicked;call super::doubleclicked;if row > 0 then
	
	//Show Sertifi Status.
	Choose Case dwo.name 
		Case 'p_9','p_10'
			of_show_sertifi_status(row)
			Return			
	End Choose
	
	//Switch to Preview Tab
	tab_1.selecttab(2)
end if
end event

event resize;call super::resize;string	ls_zoom,  ls_height, ls_width, ls_objects[]

ls_zoom = this.describe( "datawindow.zoom" )




If Integer( ls_Zoom ) > 150 Then
	ls_height = string(  round(  56 * 100.0 /  double( ls_zoom  ),2 ) )
	ls_width =  string(  round(  55  * 100.0 /  double( ls_zoom  ),2) )
	
	ls_objects = {'p_5','p_6'}
	of_SetPictureSize( This, ls_Zoom, ls_objects ,'55', '56', ls_width, ls_height  )
	
	ib_Zoom = True
Else
	If ib_Zoom Then
		ls_Zoom = '100'
	
		ls_objects = {'p_5','p_6'}
		of_SetPictureSize( This, ls_Zoom, ls_objects ,'55', '56','55', '56'  )
		
		ib_Zoom = False
	End If
End If


If Visible Then//add by gavins 20120217
	If this.y + this.Height > Parent.Height  Or this.y + this.Height < Parent.Height - 10 Then
		this.Height = Parent.Height - this.y - 10 
	End If	
	
End If
end event

type tabpage_preview from userobject within tab_1
integer x = 18
integer y = 16
integer width = 3808
integer height = 1760
boolean enabled = false
long backcolor = 79741120
string text = "Preview"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "custom090!"
long picturemaskcolor = 12632256
string powertiptext = "Preview"
ole_doc ole_doc
uo_2 uo_2
gb_map gb_map
dw_head dw_head
dw_clause dw_clause
dw_change dw_change
cb_approve cb_approve
cb_original cb_original
cb_reject cb_reject
uo_scrollbar uo_scrollbar
pb_approve pb_approve
pb_reject pb_reject
end type

on tabpage_preview.create
this.ole_doc=create ole_doc
this.uo_2=create uo_2
this.gb_map=create gb_map
this.dw_head=create dw_head
this.dw_clause=create dw_clause
this.dw_change=create dw_change
this.cb_approve=create cb_approve
this.cb_original=create cb_original
this.cb_reject=create cb_reject
this.uo_scrollbar=create uo_scrollbar
this.pb_approve=create pb_approve
this.pb_reject=create pb_reject
this.Control[]={this.ole_doc,&
this.uo_2,&
this.gb_map,&
this.dw_head,&
this.dw_clause,&
this.dw_change,&
this.cb_approve,&
this.cb_original,&
this.cb_reject,&
this.uo_scrollbar,&
this.pb_approve,&
this.pb_reject}
end on

on tabpage_preview.destroy
destroy(this.ole_doc)
destroy(this.uo_2)
destroy(this.gb_map)
destroy(this.dw_head)
destroy(this.dw_clause)
destroy(this.dw_change)
destroy(this.cb_approve)
destroy(this.cb_original)
destroy(this.cb_reject)
destroy(this.uo_scrollbar)
destroy(this.pb_approve)
destroy(this.pb_reject)
end on

type ole_doc from u_email_edit within tabpage_preview
integer x = 5
integer y = 4
integer width = 3749
integer height = 1732
integer taborder = 100
string binarykey = "u_tabpg_dm_data.udo"
end type

event constructor;call super::constructor;this.object.menubar(true)
ole_doc.x = tab_1.tabpage_preview.gb_map.x 
inv_ole_utils_doc = create n_cst_ovole_utils
inv_ole_utils_doc.of_initial( ole_doc)
end event

event destructor;call super::destructor;if isvalid(inv_ole_utils_doc) then
	destroy inv_ole_utils_doc
end if

end event

event onstatuschange;call super::onstatuschange;IF Not IsValid(inv_ole_utils_doc) THEN Return //(Appeon)Harry 01.28.2014 - V142 ISG-CLX
IF inv_ole_utils_doc.of_isstatuschanged() THEN
	//-----Begin Modified by Alfee 09.21.2007--------
	//<$Reason>Only for read only document, and the undo function is skipped.
	IF inv_ole_utils_doc.of_isreadonly() or lower(is_doc_right) = "no editing" or lower(is_doc_right) = "no access" THEN 
		inv_ole_utils_doc.of_checkrights()  
	END IF
	//inv_ole_utils_doc.Post of_checkrights()
	//-----End Modified ------------------------------
	//post of_getchanges() //Remarked by alfee at 03.14.2007 for performance
END IF

end event

event onwordwpsselchange;call super::onwordwpsselchange;Long ll_doc_lastpos
//String ls_clause_right - Replaced it with is_clause_right by alfee 09.18.2007

IF not ib_allowtrack THEN RETURN //for auto numbering, merging & ....

//Fixed bug - When they select Print Preview it comes up but when they attempt to scroll down they get kicked out of the print preview - jervis 01.12.2010
if ole_doc.object.Activedocument.Application.PrintPreview = true then return

//Check rights only at clause level - By Alfee 09.21.2007
IF Not inv_ole_utils_doc.of_isreadonly() and lower(is_doc_right) <> "no editing" and lower(is_doc_right) <> "no access" THEN 
//IF lower(is_doc_right) <> "no editing" and lower(is_doc_right) <> "no access"THEN  
	//Get current position in document
	ll_doc_lastpos = ole_doc.object.Activedocument.Activewindow.Selection.Start
	
	//Get user rights on current position in document
	is_clause_right = inv_ole_utils_doc.of_get_clauseright(ll_doc_lastpos)
	
	//Set review toolbar on document according to rights on current clause
	//-------Begin Modified by Alfee 11.22.2007----------------------------
	//inv_ole_utils_doc.of_setreviewstatus(is_clause_right)
	inv_ole_utils_doc.of_setreviewstatus(is_clause_right, ib_allow_approve_reject)
	//-------End Modified -------------------------------------------------

	//Set approve/reject button
	of_setreviewbutton()
	
	//Check rights on current clause - Added by Alfee 09.21.2007
	IF ib_allowcheckrights THEN inv_ole_utils_doc.of_checkrights()  
END IF
end event

type uo_2 from uo_dm_image_view_cp within tabpage_preview
integer x = 5
integer y = 4
integer height = 1732
integer taborder = 70
end type

on uo_2.destroy
call uo_dm_image_view_cp::destroy
end on

event constructor;call super::constructor;//Set module called from - Alfee 07.28.2008
this.of_set_module( "document manager")
end event

event ue_ocr;call super::ue_ocr;u_tabpg_dm_data lpg_data
lpg_data = tab_1.getparent()
lpg_data.dynamic event ue_ocr()
end event

event ue_ocr_setting;call super::ue_ocr_setting;u_tabpg_dm_data lpg_data
lpg_data = tab_1.getparent()
lpg_data.dynamic event ue_ocr_settings()
end event

event ue_ocr_view_result;call super::ue_ocr_view_result;u_tabpg_dm_data lpg_data
lpg_data = tab_1.getparent()
lpg_data.dynamic event ue_ocr_view()
end event

event ue_saveto_pdf;call super::ue_saveto_pdf;String ls_pdf_file,ls_pdf_path, ls_pdf_name
String ls_Null
u_tabpg_dm_data luo_data
Setnull(ls_null)

If of_ismodified() Then
	MessageBox("Save Document","The document has been modified, please save it first.") 
	Return 
End If

If Upper(Right(ole_edit.object.filename,3)) = 'PDF' or &
	inv_ole_utils_doc.of_isreadonly() or &
	lower(is_doc_right) = "no editing" or &
	lower(is_doc_right) = "no access" THEN 	
		OpenWithParm(w_saveas_action_type, 2)
Else
	Open(w_saveas_action_type)
End If

Choose Case Message.doubleparm
	Case 0
		Return
	Case 1
		This.of_saveaspdf( )
	Case 2
		luo_data = Tab_1.GetParent()
		luo_data.of_convert2pdf(il_preview_doc_id,idc_preview_revision, This.ole_edit.object.filename  )
End Choose

Return
end event

type gb_map from groupbox within tabpage_preview
boolean visible = false
integer x = 9
integer width = 1147
integer height = 1756
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
event keydown pbm_dwnkey
event ue_postkeydown ( )
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
long ll_clause_id,ll_row
Boolean lb_statuschanged_ori

IF NOT Visible THEN RETURN // added 02.07.2007 By: Davis

if tab_1.selectedtab <> 2 or not ib_locate then return
ll_row = tab_1.tabpage_preview.dw_clause.getrow()
if ll_row < 1 then return
If tab_1.tabpage_preview.ole_doc.object.DocType <> 1 Then return //no word document opened

lb_statuschanged_ori = inv_ole_utils_doc.of_isstatuschanged() //Alfee 05.15.2007
inv_ole_utils_doc.of_setstatuschanged(FALSE)

//Added by Ken for below Modify at 04/29/2007
oleobject ole_document,ole_bookmarks,ole_range,ole_range_temp
ole_document = tab_1.tabpage_preview.ole_doc.object.activedocument
ole_bookmarks = tab_1.tabpage_preview.ole_doc.object.activedocument.Content.bookmarks

ll_clause_id = tab_1.tabpage_preview.dw_clause.getitemnumber(ll_row,"ctx_acp_clause_id")
if ole_document.Content.bookmarks.exists("clause_" +string(ll_clause_id)) then 
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 04/29/2007 By: Ken.Guo
	//$<reason> The first line in bookmark need show on top in page when click a clause.
	//tab_1.tabpage_preview.ole_doc.object.activedocument.bookmarks.item("clause_" +string(ll_clause_id)).select()
	//Goto EndLine and Select it
	ib_allowtrack = FALSE //for performance tunning - Added by Alfee 05.11.2007
	ole_range = ole_document.GoTo(3, -1) 
	ole_range.select()
	//Select first line in bookmark.  
	ole_range_temp = ole_document.range(ole_bookmarks.item("clause_" +string(ll_clause_id)).start,ole_bookmarks.item("clause_" +string(ll_clause_id)).start)
	ole_range_temp.select()
	//Select bookmark. Then the first line in bookmark will show in top in cuurent page
	ib_allowtrack = True //for performance tunning - Added by Alfee 05.11.2007
	ole_bookmarks.item("clause_" +string(ll_clause_id)).select()
	//---------------------------- APPEON END ----------------------------
end if

//-------Begin Modified by Alfee 05.15.2007---------------
//inv_ole_utils_doc.of_setstatuschanged(TRUE)
inv_ole_utils_doc.of_setstatuschanged(lb_statuschanged_ori) 
//-------End Modified--------------------------------------

end event

event keydown;//for performance tuning, coding here instead of in the rowfocuschanged event - Alfee 03.13.2008

IF This.RowCount() < 1 THEN RETURN 0

IF key = KeyUpArrow! or key = KeyDownArrow! or key = KeyPageUp! or key = KeyPageDown! THEN
	Post Event ue_postkeydown()
END IF

RETURN 0
end event

event ue_postkeydown();//----Alfee 03.13.2008---------------
this.event ue_locatefile()

IF ib_showclausemap and This.GetRow() > 0 THEN
	cb_original.Enabled = True
ELSE
	cb_original.Enabled = False
END IF
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

type dw_change from u_dw within tabpage_preview
event ue_locatefile ( )
boolean visible = false
integer x = 32
integer y = 816
integer width = 1102
integer height = 680
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
Integer li_page,li_line,li_col,li_charcnt
Integer li_changes, li_pageno //alfee 07.24.2007
Long ll_row, ll_cnt, i, ll_start, ll_findrow
string ls_desc, ls_desc_ori, ls_clausename
oleobject lole_document,lole_range,lole_range_temp

IF NOT Visible THEN RETURN // added 02.07.2007 By: Davis
IF tab_1.SelectedTab <> 2 OR NOT ib_locate_change THEN RETURN 
IF tab_1.tabpage_preview.ole_doc.object.DocType <> 1 THEN RETURN
ll_row =This.Getrow()
IF ll_row < 1 THEN RETURN
//---------Begin Added by Alfee 07.24.2007------------------
//IF IsValid(gw_contract) THEN li_changes = gw_contract.ii_changes
li_changes = inv_ole_utils_doc.ii_changes

li_pageno = Integer(tab_1.tabpage_preview.uo_scrollbar.st_page.Text)
ll_row += (li_pageno - 1) * li_changes
//---------End Added----------------------------------------

lole_document = ole_doc.Object.ActiveDocument
IF lole_document.Revisions.Count >= ll_row THEN
	ll_start = lole_document.Revisions.Item[ll_row].Range.Start
	ll_cnt = lole_document.content.bookmarks.count
	//Locate in clause datawindow
	For i = 1 to ll_cnt
		IF Lower(Left(lole_document.content.bookmarks.Item[i].Name, 7)) <> 'clause_' THEN CONTINUE //added by Alfee 05.30.2007
		IF ll_start > 0 and lole_document.range(ll_start, ll_start).InRange(lole_document.Content.Bookmarks[i].Range) THEN
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 28-03-2007 By: Ken.Guo
			//$<reason> Need locate correct row with bookmark, find DW's row by bookmark's name instead of bookmark's index.
			ls_clausename = lole_document.Content.Bookmarks[i].Name
			ll_findrow = dw_clause.find("ctx_acp_clause_id = "+right(ls_clausename,len(ls_clausename)-len('clause_')) ,1,dw_clause.rowcount())
			if ll_findrow > 0 then
				dw_clause.ScrolltoRow(ll_findrow)
				dw_clause.Selectrow(0,false)	
				dw_clause.Selectrow(ll_findrow,True)	
			else
				dw_clause.Selectrow(0,false)	
			end if
			exit
			//---------------------------- APPEON END ----------------------------			
		END IF
	Next	
	//Locate revison in document
	ole_doc.setredraw(false)
	//--------------------------- APPEON BEGIN ---------------------------	
	//$<add> 28-03-2007 By: Ken.Guo
	//$<reason> For current revision data must show on top in page.
	//lole_document.Revisions.Item[lole_document.Revisions.Count].Range.Select()
	//Goto EndLine and Selected it
	ib_allowtrack = FALSE //For performance tuning -- Added by Alfee 05.11.2007
	//---------Begin Modified by Alfee 01.09.2008----------------------------
	//<$Reason>GoTo statement in Word VBA has a very bad performance especially 
	//<$Reason>to a large range of revision.
	//lole_range = lole_document.GoTo(3, -1) 
	//lole_range.select()
	ll_start = lole_document.content.End
	IF ll_start > 0 THEN lole_document.Range(ll_start -1, ll_start -1).Select()
	//---------End Modified --------------------------------------------------
	//Select first line in the revision.  
	lole_range_temp = lole_document.range(lole_document.Revisions.Item[ll_row].range.start,lole_document.Revisions.Item[ll_row].range.start)
	lole_range_temp.select()	
	//---------------------------- APPEON END ----------------------------
	ib_allowtrack = TRUE //For performance tuning -- Added by Alfee 05.11.2007
	lole_document.Revisions.Item[ll_row].Range.Select()	
	ole_doc.setredraw(true) 
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

type cb_approve from commandbutton within tabpage_preview
boolean visible = false
integer x = 32
integer y = 1588
integer width = 251
integer height = 76
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

event clicked;Integer li_revindex, li_pageno, li_changes
Long ll_row, ll_rowcount, ll_bmcount
Boolean lb_singlerevision
Boolean lb_bookmarkchanged = FALSE //Always False for accept
dwobject ldwo_col

//--------Begin Modified by alfee 05.10.2007-------------
//<$Reason>for performance tuning
//Whether the selected area in document is just for the specified revision 
SetPointer(HourGlass!)

//Get the selected revision index
ll_row = tab_1.tabpage_preview.dw_change.getrow()
//--------Begin Modified by Alfee 08.09.2007---------------
IF ll_row < 1 THEN RETURN
//IF IsValid(gw_contract) THEN li_changes = gw_contract.ii_changes
li_changes = inv_ole_utils_doc.ii_changes

li_pageno = Integer(tab_1.tabpage_preview.uo_scrollbar.st_page.Text) //
li_revindex = li_changes * (li_pageno - 1) + ll_row

//Is there only 1 revision to be approved
lb_singlerevision = inv_ole_utils_doc.of_isselectedrevision(li_revindex)

//Accept the change(s) 
IF inv_ole_utils_doc.of_acceptchanges(li_revindex) = -1 THEN 
	//-------Begin Modified by Alfee on 04.16.2008-------	
	li_revindex = -1 
	//of_getchanges() //Refresh change list
	//RETURN
	//-------End Modified --------------------------------
END IF

IF not lb_singlerevision THEN li_revindex = -1 
/*IF inv_ole_utils_doc.of_isselectedrevision(ll_row) THEN
	li_revindex = ll_row
ELSE
	li_revindex = -1 
END IF
//Accept Changes
IF inv_ole_utils_doc.of_acceptchanges(ll_row) = -1 THEN RETURN
//inv_ole_utils_doc.of_acceptchanges()*/
//--------End Modified ------------------------------------

//Refresh clause map & change list
of_refreshmap(lb_bookmarkchanged, li_revindex)
//of_refreshmap()
//--------End Modified ---------------------------------

//Scroll to next row ,and locate to doc file. --Added By Ken
ll_rowcount = tab_1.tabpage_preview.dw_change.rowcount()
if ll_rowcount >= ll_row then
	tab_1.tabpage_preview.dw_change.scrolltorow(ll_row)
	tab_1.tabpage_preview.dw_change.post event clicked(0,0,ll_row,ldwo_col)
elseif ll_rowcount < ll_row and ll_rowcount > 0 then
	tab_1.tabpage_preview.dw_change.scrolltorow(ll_rowcount)
	tab_1.tabpage_preview.dw_change.post event clicked(0,0,ll_rowcount,ldwo_col)	
end if

end event

type cb_original from commandbutton within tabpage_preview
boolean visible = false
integer x = 727
integer y = 1588
integer width = 398
integer height = 76
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
integer x = 379
integer y = 1588
integer width = 251
integer height = 76
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

event clicked;Integer li_revindex, li_pageno, li_changes
Long ll_row, ll_rowcount, ll_bmcount
Boolean lb_singlerevision
Boolean lb_bookmarkchanged = FALSE 
dwobject ldwo_col

//--------Begin Modified by Alfee 05.10.2007-------------
//<$Reason>for performance tuning
//Keep bookmarks' count in document before accpet/reject operation
ll_bmcount = inv_ole_utils_doc.of_getbookmarkscount()

//Get the selected revision index
ll_row = tab_1.tabpage_preview.dw_change.getrow()
//--------Begin Modified by Alfee 08.09.2007---------------
IF ll_row < 1 THEN RETURN
//IF IsValid(gw_contract) THEN li_changes = gw_contract.ii_changes
li_changes = inv_ole_utils_doc.ii_changes

li_pageno = Integer(tab_1.tabpage_preview.uo_scrollbar.st_page.Text)
li_revindex = li_changes * (li_pageno - 1) + ll_row

//Is there only 1 revision to be Rejected
lb_singlerevision = inv_ole_utils_doc.of_isselectedrevision(li_revindex)

//Reject the change(s) 
IF inv_ole_utils_doc.of_rejectchanges(li_revindex) = -1 THEN 
	//-------Begin Modified by Alfee on 04.16.2008-------	
	li_revindex = -1 
	//of_getchanges() //Refresh change list
	//RETURN
	//-------End Modified --------------------------------
END IF

IF not lb_singlerevision THEN li_revindex = -1 
/*//Whether the selected area in document is just for the specified revision 
IF inv_ole_utils_doc.of_isselectedrevision(ll_row) THEN
	li_revindex = ll_row
ELSE
	li_revindex = -1 
END IF
//Reject Changes
IF inv_ole_utils_doc.of_rejectchanges(ll_row) = -1 THEN RETURN
//inv_ole_utils_doc.of_rejectchanges()*/
//-------End Modified ------------------------------------

//Refresh clause map & change list
IF ll_bmcount <> inv_ole_utils_doc.of_getbookmarkscount() THEN lb_bookmarkchanged = TRUE
of_refreshmap(lb_bookmarkchanged, li_revindex)
//of_refreshmap()
//--------End Modified ---------------------------------

//Scroll to next row ,and locate to doc file. -- By Ken
ll_rowcount = tab_1.tabpage_preview.dw_change.rowcount()
if ll_rowcount >= ll_row then
	tab_1.tabpage_preview.dw_change.scrolltorow(ll_row)
	tab_1.tabpage_preview.dw_change.post event clicked(0,0,ll_row,ldwo_col)
elseif ll_rowcount < ll_row and ll_rowcount > 0 then
	tab_1.tabpage_preview.dw_change.scrolltorow(ll_rowcount)
	tab_1.tabpage_preview.dw_change.post event clicked(0,0,ll_rowcount,ldwo_col)	
end if

end event

type uo_scrollbar from uo_dm_change_toollbar within tabpage_preview
boolean visible = false
integer x = 32
integer y = 1500
integer taborder = 41
boolean bringtotop = true
end type

on uo_scrollbar.destroy
call uo_dm_change_toollbar::destroy
end on

event ue_scroll;call super::ue_scroll;Integer li_pageno, li_pagecnt

//Get current page no. and page count
li_pageno = Integer(tab_1.tabpage_preview.uo_scrollbar.st_page.Text)
li_pagecnt = Integer(tab_1.tabpage_preview.uo_scrollbar.st_count.Text)

CHOOSE CASE Upper(as_scrolltype)
	CASE 'FIRST'
		IF li_pageno <> 1 THEN 
			tab_1.tabpage_preview.uo_scrollbar.st_page.Text = '1'
			of_getchanges()
		END IF		
	CASE 'PRIOR'
		IF li_pageno > 1 THEN 
			tab_1.tabpage_preview.uo_scrollbar.st_page.Text = String(li_pageno - 1)
			of_getchanges()			
		END IF
	CASE 'NEXT'
		IF li_pageno < li_pagecnt THEN 
			tab_1.tabpage_preview.uo_scrollbar.st_page.Text = String(li_pageno + 1)
			of_getchanges()			
		END IF		
	CASE 'LAST'
		IF li_pageno <> li_pagecnt THEN 
			tab_1.tabpage_preview.uo_scrollbar.st_page.Text = String(li_pagecnt)
			of_getchanges()			
		END IF		
END CHOOSE

end event

event ue_page_modified;call super::ue_page_modified;//integer li_page, li_pageno, li_pagecnt
//
//li_page = integer(em_page.text)
//li_pageno = Integer(st_page.text)
//li_pagecnt = Integer(st_count.text)
//
//IF li_page <> li_pageno and li_page > 0 and li_page <= li_pagecnt THEN 
//	st_page.text = String(li_page)
//	of_getchanges()
//END IF
end event

type pb_approve from picturebutton within tabpage_preview
boolean visible = false
integer x = 283
integer y = 1588
integer width = 82
integer height = 76
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "darrow.bmp"
alignment htextalign = left!
vtextalign vtextalign = top!
boolean map3dcolors = true
end type

event clicked;//Alfee 07.15.2008

m_dm_approve_reject lm_apprej
lm_apprej = Create m_dm_approve_reject

of_setparent(lm_apprej)
lm_apprej.m_approve.popmenu( w_mdi.pointerx( ), w_mdi.pointery())

Destroy lm_apprej







end event

type pb_reject from picturebutton within tabpage_preview
boolean visible = false
integer x = 631
integer y = 1588
integer width = 82
integer height = 76
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "darrow.bmp"
alignment htextalign = left!
boolean map3dcolors = true
end type

event clicked;//Alfee 07.15.2008

m_dm_approve_reject lm_apprej
lm_apprej = Create m_dm_approve_reject

of_setparent(lm_apprej)
lm_apprej.m_reject.popmenu( w_mdi.pointerx( ), w_mdi.pointery())

Destroy lm_apprej







end event

type st_docinfo from statictext within u_tabpg_dm_data
integer x = 741
integer y = 1804
integer width = 3072
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
alignment alignment = right!
boolean focusrectangle = false
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
02u_tabpg_dm_data.bin 
2200000e00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff00000001000000000000000000000000000000000000000000000000000000002eba65f001d1dd8d00000003000005000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000025400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003c9bc4e0f4a3c4248a763498a04f417d3000000002eba17d001d1dd8d2eba65f001d1dd8d0000000000000000000000000054004e004f004b0066004f0069006600650063007400430053006c006d0074000000000000000000000000000000000000000000000000000000000000000001020022ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000025400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000c0000000d0000000e0000000f00000010000000110000001200000013fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Effffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1234abcd000054c000002cc000dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b4000000010000000000000000000000000000000000000000000000010000000000000000000000010000000000800000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001234abcd000054c000002cc000dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b400000001000000000000000000000000000000000000000000000001000000000000000000000001000000000080000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
12u_tabpg_dm_data.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
