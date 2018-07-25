$PBExportHeader$u_tabpg_dm_audit.sru
$PBExportComments$[intellicontract_tab]
forward
global type u_tabpg_dm_audit from u_tabpg_contract_master
end type
type tab_1 from tab within u_tabpg_dm_audit
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
type dw_preview from u_dw_contract within tabpage_preview
end type
type uo_2 from uo_dm_image_view_cp within tabpage_preview
end type
type ole_doc from u_email_edit within tabpage_preview
end type
type tabpage_preview from userobject within tab_1
dw_preview dw_preview
uo_2 uo_2
ole_doc ole_doc
end type
type tab_1 from tab within u_tabpg_dm_audit
tabpage_browse tabpage_browse
tabpage_preview tabpage_preview
end type
end forward

global type u_tabpg_dm_audit from u_tabpg_contract_master
integer width = 3899
integer height = 1932
event type integer ue_preview ( long al_doc_id,  decimal adc_revision,  string as_doc_ext )
event ue_do ( string as_action )
event ue_print ( )
event ue_retrieve ( long al_doc_id,  decimal adc_revision,  string as_doc_ext )
event ue_set_screen_properties ( )
event ue_show_sertifi_status ( )
tab_1 tab_1
end type
global u_tabpg_dm_audit u_tabpg_dm_audit

type variables
string  is_filter
n_cst_ovole_utils  inv_ole_utils_doc
long    il_preview_doc_id
dec{1}  idc_preview_revision
string  is_doc_ext

boolean ib_browse
n_cst_dm_utils  inv_dm_utils

datawindowchild idw_child


end variables

forward prototypes
public subroutine of_showole (boolean ab_show_doc_ole)
public function integer of_retrieve ()
public function integer of_menu_security ()
public subroutine of_hidesearch ()
public subroutine of_showsearch ()
end prototypes

event type integer ue_preview(long al_doc_id, decimal adc_revision, string as_doc_ext);//////////////////////////////////////////////////////////////////////
// $<event>ue_previewu_tabpg_dm_audit()
// $<arguments>
//		long   	al_doc_id   		
//		decimal	adc_revision		
//		string 	as_doc_ext  		
// $<returns> (None)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.18.2007 by Jack (Document Manager)
//////////////////////////////////////////////////////////////////////

int  li_ret
String ls_filename
string ls_null
String ls_doc_nme
long	ll_size

If isnull(al_doc_id) Or al_doc_id = 0 Then Return 0
CHOOSE CASE Lower(as_doc_ext)
	CASE 'tif','tiff','jfk','bmp','jpc','jpe','jpeg','pcx','dcx','xif','gif','wif','ibk'
		of_showole( false)
		If al_doc_id <> il_preview_doc_id Or adc_revision <> idc_preview_revision Then
			li_ret = tab_1.tabpage_preview.uo_2.event ue_load_image2(al_doc_id,adc_revision,as_doc_ext)	
		Else
			li_ret = 1
		End If	
	CASE 'pdf' //Added By Ken.Guo 2011-05-06. for Open PDF Mode
		If gnv_data.of_getitem( 'icred_settings', 'openpdfwith', false) = '1' Then
			//Open with CL
			of_showole( false)
			If al_doc_id <> il_preview_doc_id Or adc_revision <> idc_preview_revision Then
				li_ret = tab_1.tabpage_preview.uo_2.event ue_load_image2(al_doc_id,adc_revision,as_doc_ext)	
			Else
				li_ret = 1
			End If				
		Else
			//Open with windows default program
			IF tab_1.selectedtab = 2 THEN tab_1.selecttab(1)
			setnull(ls_null)
			ls_doc_nme = inv_dm_utils.of_download_file( al_doc_id, adc_revision)
			IF FileExists(ls_doc_nme) THEN
				if ShellExecuteA ( Handle( This ), "open", ls_doc_nme , ls_Null, ls_Null, 4) <= 32 then
					run("rundll32.exe shell32.dll,OpenAs_RunDLL " + ls_doc_nme)
				end if
			END IF
			RETURN 0			
		End If
	CASE 'doc'
		of_showole( true)
		If al_doc_id <> il_preview_doc_id Or adc_revision <> idc_preview_revision Then
			idc_preview_revision = adc_revision
			openwithparm( w_appeon_gifofwait, "Opening the selected document..." )			
			ls_filename = inv_dm_utils.of_download_file( al_doc_id, adc_revision)
			If Isvalid( w_appeon_gifofwait) Then
				if w_appeon_gifofwait.hpb_1.position <= 80 Then
					w_appeon_gifofwait.hpb_1.position = 80
				end if
			end if
			If ls_filename = '' Then
				If Isvalid( w_appeon_gifofwait) Then Close( w_appeon_gifofwait)
				Return 0
			End If
			IF FileExists(ls_filename) THEN 
				li_ret = inv_ole_utils_doc.of_displayfile(ls_filename,True) 
			END If					
			If Isvalid( w_appeon_gifofwait) Then Close( w_appeon_gifofwait)
			
		Else
			li_ret = 1
		End If		
	CASE 'htm','html'
		IF tab_1.selectedtab = 2 THEN tab_1.selecttab(1)
		setnull(ls_null)
		ls_doc_nme = inv_dm_utils.of_download_file( al_doc_id, adc_revision)
		IF FileExists(ls_doc_nme) THEN
		//ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', ls_doc_nme, ls_Null, 4)   //Commented by (Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
		ShellExecuteA ( Handle( This ), "open", of_getbrowserversion( ), ls_doc_nme, ls_Null, 4) //(Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
		END IF
		RETURN 0
	CASE else
		IF tab_1.selectedtab = 2 THEN tab_1.selecttab(1)
		setnull(ls_null)
		ls_doc_nme = inv_dm_utils.of_download_file( al_doc_id, adc_revision)
		IF FileExists(ls_doc_nme) THEN
			if ShellExecuteA ( Handle( This ), "open", ls_doc_nme , ls_Null, ls_Null, 4) <= 32 then
				run("rundll32.exe shell32.dll,OpenAs_RunDLL " + ls_doc_nme)
			end if
		END IF
		RETURN 0
END CHOOSE

IF li_ret > 0 OR FileExists(ls_filename) THEN
	il_preview_doc_id = al_doc_id
	idc_preview_revision = adc_revision
	If tab_1.selectedtab = 1 Then
		tab_1.post selecttab(2)
	End If
END IF

return li_ret

end event

event ue_do(string as_action);//////////////////////////////////////////////////////////////////////
// $<event>ue_dou_tabpg_dm_audit()
// $<arguments>
//		string	as_action		
// $<returns> (None)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.23.2007 by Jack (Document Manager)
//////////////////////////////////////////////////////////////////////
str_add_doc lstr_add_doc
str_ctx_email lstr_ctx_email

//--------Begin Commented by Alfee 09.30.2007-----------------------
//if of_check_read_only( ) then return   //Add by Jack 08.30.2007
//--------End Modified ---------------------------------------------

CHOOSE CASE as_action
	CASE 'report' 
		//Start Change By Jervis At 01.24.2007
		/*openwithparm(w_dm_document_report, string(il_doc_id) + '+' )*/
		str_open_report lstr_pass
		
		lstr_pass.s_style = 'audit'
		lstr_pass.l_ctx_id = inv_contract_details.of_get_ctx_id( )
		lstr_pass.l_doc_id = il_doc_id
		lstr_pass.s_dataobject = "d_dm_audit_report"
		openwithparm(w_dm_document_report,lstr_pass )
		//End Change
	CASE 'select'
		event ue_preview(il_doc_id,idc_revision,is_doc_ext)		
	CASE 'output_email'
//		//-------Appeon Begin by alfee 04.30.2007-------------
//		//openwithparm(w_dm_email_document,il_doc_id)
//		lstr_ctx_email.doc_from = 'DM'
//		lstr_ctx_email.ctx_id = inv_contract_details.of_get_ctx_id( )
//		lstr_ctx_email.doc_id = this.il_doc_id
//		lstr_ctx_email.revision = this.idc_revision
//		lstr_ctx_email.doc_ext = this.is_doc_ext
//		OpenWithParm(w_dm_email_document_send, lstr_ctx_email)
//		//--------Appeon End--------------
	CASE 'output_saveas'
		lstr_add_doc.doc_id = il_doc_id
		lstr_add_doc.revision = idc_revision
		lstr_add_doc.doc_ext = is_doc_ext
		openwithparm(w_dm_saveto_document, lstr_add_doc)
		SetPointer(Arrow!) //for refresh problem - Alfee 05.19.2008
	Case 'ue_retrieve' //Added By Ken.Guo 2011-06-20. 
		This.event ue_retrieve( il_doc_id, idc_revision, is_doc_ext)
	Case 'ue_show_sertifi_status'
		This.event ue_show_sertifi_status( )
END CHOOSE

end event

event ue_print();if of_check_read_only( ) then return  //Add by Jack 08.30.2007

IF is_doc_ext = 'doc' THEN
	inv_ole_utils_doc.of_print( )
ELSE
	//-----------Begin Modified by Alfee on 05.19.2008 ----------------	
	//tab_1.tabpage_preview.uo_1.event ue_print( )
	IF gi_imageocx = 1 THEN //Imaging 360
		//tab_1.tabpage_preview.uo_1.event ue_print( )
	ELSE	//new Image OCX
		tab_1.tabpage_preview.uo_2.event ue_print( )
	END IF
	//-----------End Modified -----------------------------------------							
END IF

end event

event ue_retrieve(long al_doc_id, decimal adc_revision, string as_doc_ext);long li_ret
il_doc_id = al_doc_id
idc_revision = adc_revision
is_doc_ext = as_doc_ext
tab_1.tabpage_browse.dw_browse.reset()
tab_1.tabpage_browse.dw_filter.reset()
tab_1.tabpage_browse.dw_filter.insertrow(0)
tab_1.tabpage_browse.dw_browse.setfilter('')
tab_1.tabpage_browse.dw_browse.filter()

gnv_appeondb.of_startqueue( )		
tab_1.tabpage_preview.dw_preview.retrieve(il_doc_id)
tab_1.tabpage_browse.dw_browse.retrieve(il_doc_id )
idw_child.retrieve(il_doc_id)
gnv_appeondb.of_commitqueue( )
idw_child.insertrow(1)

IF tab_1.selectedtab = 2 THEN
	li_ret = event ue_preview( il_doc_id, idc_revision,is_doc_ext)		
	IF li_ret > 0 THEN
		il_preview_doc_id = il_doc_id
		idc_preview_revision = idc_revision
	END IF
End If

end event

event ue_set_screen_properties();u_dw_contract ldw_screen

// Set screen properties
ldw_screen = tab_1.tabpage_browse.dw_filter
ldw_screen.of_set_properties(ldw_screen.il_ViewID, ldw_screen.il_ScreenID, "Y")
ldw_screen = tab_1.tabpage_browse.dw_browse
ldw_screen.of_set_properties(ldw_screen.il_ViewID, ldw_screen.il_ScreenID, "Y")
end event

event ue_show_sertifi_status();String ls_es_docid
Long ll_row
Datawindow ldw_current
String ls_esign_type
String ls_es_fileid

ldw_current = Tab_1.tabpage_browse.dw_browse


ll_row = ldw_current.GetRow()
ls_es_docid = ldw_current.GetItemString(ll_row,'es_docid')		
ls_es_fileid =  ldw_current.GetItemString(ll_row,'es_fileid') // (Appeon)Harry 07.08.2016 - for docusign

Select esign_type into :ls_esign_type From ctx_am_document where es_docid = :ls_es_docid; 

choose case ls_esign_type //Added By Jay Chen 10-18-2013
	case 'sertifi'
		gnv_sertifi.of_show_sertifi_status(il_doc_id,ls_es_docid,'dm',true)
	case 'echosign'
		gnv_echosign.of_show_sertifi_status(il_doc_id,ls_es_docid,'dm',true)
	case 'docusign'   // (Appeon)Harry 07.08.2016 - for docusign
//		gnv_docusign.of_show_sertifi_status(il_doc_id,ls_es_docid,'dm',true)
		gnv_docusign.of_show_sertifi_status(il_doc_id,ls_es_docid,'dm',true,ls_es_fileid) //Modified By Jay Chen 04-30-2014
end choose

Return 
end event

public subroutine of_showole (boolean ab_show_doc_ole);//////////////////////////////////////////////////////////////////////
// $<function>of_showole()
// $<arguments>
//		boolean	ab_show_doc_ole  	:True  - Show the Office Viewer OCX OLE control
//                               :False - Show the Image Editing OCX OLE control
// $<returns> (none)
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.13.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////

IF ab_show_doc_ole THEN
	tab_1.tabpage_preview.ole_doc.visible = true
	//tab_1.tabpage_preview.uo_1.visible = false
	tab_1.tabpage_preview.uo_2.visible = false //Alfee 05.19.2008
ELSE
	tab_1.tabpage_preview.ole_doc.visible = false
	//-----------Begin Modified by Alfee on 05.19.2008 ----------------	
	//tab_1.tabpage_preview.uo_1.visible = true
	IF gi_imageocx = 1 THEN //Imaging 360
		//tab_1.tabpage_preview.uo_1.visible = true	
		tab_1.tabpage_preview.uo_2.visible = false
	ELSE	
		//tab_1.tabpage_preview.uo_1.visible = false	
		tab_1.tabpage_preview.uo_2.visible = true
	END IF
	//-----------End Modified -----------------------------------------						
	
END IF



end subroutine

public function integer of_retrieve ();//event ue_retrieve(il_doc_id)

return 1
end function

public function integer of_menu_security ();//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_dm_auditof_menu_security()
// $<arguments>(None)
// $<returns> integer
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.23.2007 by Jack (Document Manager)
//////////////////////////////////////////////////////////////////////
If Not isvalid(m_pfe_cst_mdi_menu_contract_am) Then Return 0
w_mdi.setredraw(false)

gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add,'toolbaritemvisible', False)					
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addbuy,'toolbaritemvisible', False)			
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addsell,'toolbaritemvisible', False)

gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_report,'toolbaritemvisible', False)			
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_select,'toolbaritemvisible', False)			
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_properties0,'toolbaritemvisible', False)			
//m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_email0.toolbaritemvisible = False //by alfee at 03.29.2007
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0,'toolbaritemvisible', False)	
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_print0,'toolbaritemvisible', False)			
//m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_email1.toolbaritemvisible = False			
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_saveas,'toolbaritemvisible', False)			

gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check,'toolbaritemvisible', False)	
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkin,'toolbaritemvisible', False)			
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkout,'toolbaritemvisible', False)			

gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_save0,'toolbaritemvisible', False)			
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_addclause,'toolbaritemvisible', False)					
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge,'toolbaritemvisible', False)	
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergefield,'toolbaritemvisible', False)			
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergedata,'toolbaritemvisible', False)			
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_insertreqmnt,'toolbaritemvisible', False)		

gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_workflow0,'toolbaritemvisible', False)			
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_clausemap,'toolbaritemvisible', False)			
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_addactioneitem,'toolbaritemvisible', False)			
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_deleteactioneitem,'toolbaritemvisible', False)			
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_letter,'toolbaritemvisible', False)	
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_fullscreen,'toolbaritemvisible', False)	
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_delete0,'toolbaritemvisible', False)
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_revision0,'toolbaritemvisible', False)			
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.29.2007 By: Jack
//$<reason> Fix a defect.
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0,'toolbaritemvisible', False)	
//---------------------------- APPEON END ----------------------------

Choose Case tab_1.selectedtab
	Case 1
		If ib_browse Then
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_select,'toolbaritemvisible', True)	
			If tab_1.tabpage_browse.dw_browse.rowcount() > 0 Then
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_select,'enabled', True)	
			Else
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_select,'enabled', False)	
			End If				

			If w_mdi.of_security_access( 6904 ) = 0 Then
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_report,'toolbaritemvisible', False)			
			Else
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_report,'toolbaritemvisible', True)			
				If tab_1.tabpage_browse.dw_browse.rowcount() > 0 Then
					gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_report,'enabled', True)
				Else
					gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_report,'enabled', False)
				End If					
			End If			
		End If	
	Case 2		
		//If w_mdi.of_security_access( 6906 ) = 0 And w_mdi.of_security_access( 6908 ) = 0 And w_mdi.of_security_access( 6909 ) = 0 Then   //(Appeon)Harry 10.15.2015 - for Bug_Id#4780
		If w_mdi.of_security_access( 6906 ) = 0  And w_mdi.of_security_access( 6909 ) = 0 Then
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0,'toolbaritemvisible', False)			
		Else
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0,'enabled', True)			
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0,'toolbaritemvisible', True)			
		End If
		
		If w_mdi.of_security_access( 6906 ) = 0 Then
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_print0,'enabled', False)			
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_print0,'toolbaritemvisible', False)			
		Else
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_print0,'enabled', True)			
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_print0,'toolbaritemvisible', True)			
		End If
		
		If w_mdi.of_security_access( 6907 ) = 0 Then
			//m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_email1.toolbaritemvisible = False	
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_email0,'toolbaritemvisible', False) //alfee 03.22.2007
		Else
			//m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_email1.enabled = True	
			//m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_email1.toolbaritemvisible = True	
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_email0,'enabled', True) //alfee 03.22.2007
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_email0,'toolbaritemvisible', True) //alfee 03.22.2007				
		End If
			
		If w_mdi.of_security_access( 6909 ) = 0 Then
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_saveas,'toolbaritemvisible', False)			
		Else
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_saveas,'enabled', True)			
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_saveas,'toolbaritemvisible', True)			
		End If					
End Choose

//Added By Ken.Guo 2009-06-04.
m_pfe_cst_mdi_menu_contract_am.of_refresh_option()

//Added By Ken.Guo 2011-06-20.  Set sertifi ICO
Long ll_row
Datawindow ldw_audit
ldw_audit = tab_1.tabpage_browse.dw_browse
ll_row = ldw_audit.getrow()
If ll_row = 0 Then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_sertify,'toolbaritemvisible', False)
Else
	If Len(ldw_audit.GetItemString(ll_row,'es_docid')) > 0 Then
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_sertify,'toolbaritemvisible', True)
	Else
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_sertify,'toolbaritemvisible', False)
	End If
End If

w_mdi.setredraw(true)

Return 0
end function

public subroutine of_hidesearch ();//====================================================================
// Function: of_HideSearch()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2010-04-28
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long	ll_Right,ll_BottomSpace

ll_BottomSpace = Tab_1.Tabpage_Browse.Height - Tab_1.Tabpage_Browse.dw_Browse.Y - Tab_1.Tabpage_Browse.dw_Browse.height

Tab_1.Tabpage_Browse.dw_Filter.Visible = false

Tab_1.Tabpage_Browse.dw_Browse.Y = Tab_1.Tabpage_Browse.dw_Filter.Y
Tab_1.Tabpage_Browse.dw_Browse.Height = Tab_1.Tabpage_Browse.Height - ll_BottomSpace - Tab_1.Tabpage_Browse.dw_Browse.Y
Tab_1.Tabpage_Browse.dw_Browse.SetFocus()

if IsValid(m_pfe_cst_mdi_menu_contract_am) then
	ll_Right = w_mdi.of_security_access(6924)
	if ll_Right <> 0 then
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_view.m_filter,'ToolbarItemVisible', true)
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_view.m_filter,'ToolbarItemDown', False)
	else
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_view.m_filter,'ToolbarItemVisible', false)
	end if
end if

end subroutine

public subroutine of_showsearch ();//====================================================================
// Function: of_ShowSearch()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2010-04-28
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long	ll_Right,ll_BottomSpace

if Tab_1.Tabpage_Browse.dw_Filter.Visible then Return

ll_BottomSpace = Tab_1.Tabpage_Browse.Height - Tab_1.Tabpage_Browse.dw_Browse.Y - Tab_1.Tabpage_Browse.dw_Browse.height

Tab_1.Tabpage_Browse.dw_Filter.Visible = true

Tab_1.Tabpage_Browse.dw_Browse.Y = Tab_1.Tabpage_Browse.dw_Filter.Y + Tab_1.Tabpage_Browse.dw_Filter.Height + 20
Tab_1.Tabpage_Browse.dw_Browse.Height = Tab_1.Tabpage_Browse.Height - ll_BottomSpace - Tab_1.Tabpage_Browse.dw_Browse.Y

if IsValid(m_pfe_cst_mdi_menu_contract_am) then
	ll_Right = w_mdi.of_security_access(6924)
	if ll_Right <> 0 then
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_view.m_filter,'ToolbarItemVisible', true)
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_view.m_filter,'ToolbarItemDown', true)
	else
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_view.m_filter,'ToolbarItemVisible', false)
	end if
end if

end subroutine

on u_tabpg_dm_audit.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on u_tabpg_dm_audit.destroy
call super::destroy
destroy(this.tab_1)
end on

event ue_post_doc_changed;call super::ue_post_doc_changed;//////////////////////////////////////////////////////////////////////
// $<event>ue_post_doc_changedu_tabpg_dm_audit()
// $<arguments>
//		long   	al_old_doc_id   		
//		long   	al_new_doc_id   		
//		decimal	adc_old_revision		
//		decimal	adc_new_revision		
// $<returns> integer
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.23.2007 by Jack (Document Manager)
//////////////////////////////////////////////////////////////////////
integer li_ret
//IF al_old_doc_id <> al_new_doc_id THEN
	tab_1.tabpage_browse.dw_browse.reset()
	tab_1.tabpage_browse.dw_filter.reset()
	tab_1.tabpage_browse.dw_filter.insertrow(0)
	tab_1.tabpage_browse.dw_browse.setfilter('')
	tab_1.tabpage_browse.dw_browse.filter()
	
	gnv_appeondb.of_startqueue( )		
	tab_1.tabpage_preview.dw_preview.retrieve(al_new_doc_id)
	tab_1.tabpage_browse.dw_browse.retrieve(al_new_doc_id )
	idw_child.retrieve(il_doc_id)
	gnv_appeondb.of_commitqueue( )
	idw_child.insertrow(1)
		
	IF tab_1.selectedtab = 2 THEN
		il_doc_id = al_new_doc_id
		idc_revision = adc_new_revision
		is_doc_ext = trim(lower(tab_1.tabpage_browse.dw_browse.getitemstring(tab_1.tabpage_browse.dw_browse.getrow(),'doc_ext')))
		IF il_doc_id <> il_preview_doc_id OR idc_revision <> idc_preview_revision THEN
			li_ret = event ue_preview( il_doc_id, idc_revision,is_doc_ext)
			
			IF li_ret > 0 THEN
				il_preview_doc_id = il_doc_id
				idc_preview_revision = idc_revision
			END IF
		END IF
	END IF
	
//END IF

return 1
end event

event constructor;call super::constructor;this.of_setresize( true)

//Start 04.17.2008 By Jervis
/*
this.inv_resize.of_register( tab_1,inv_resize.scalerightbottom)
this.inv_resize.of_register( tab_1.tabpage_browse.dw_filter,inv_resize.scaleright)
this.inv_resize.of_register( tab_1.tabpage_browse.dw_browse,inv_resize.scalerightbottom)
this.inv_resize.of_register( tab_1.tabpage_preview.ole_doc,inv_resize.scalerightbottom)
this.inv_resize.of_register( tab_1.tabpage_preview.uo_1,inv_resize.scalerightbottom)
*/

this.inv_resize.of_register( tab_1,inv_resize.scale)
this.inv_resize.of_register( tab_1.tabpage_browse.dw_filter,inv_resize.scale)
this.inv_resize.of_register( tab_1.tabpage_browse.dw_browse,inv_resize.scale)
this.inv_resize.of_register( tab_1.tabpage_preview.ole_doc,inv_resize.scale)
//this.inv_resize.of_register( tab_1.tabpage_preview.uo_1,inv_resize.scale)
this.inv_resize.of_register( tab_1.tabpage_preview.uo_2,inv_resize.scale) // Alfee 05.19.2008
//End 04.17.2008 By Jervis
end event

event ue_set_security;//////////////////////////////////////////////////////////////////////
// $<event>ue_set_securityu_tabpg_dm_audit()
// $<arguments>
//		None		
// $<returns> (None)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.23.2007 by Jack (Document Manager)
//////////////////////////////////////////////////////////////////////
of_menu_security()

//--------Begin Modified by Alfee 09.30.2007---------------
//<$Reason>Needn't disable columns in browse tab page
//Set read only flag at tab page level
inv_contract_details.of_get_protect_tabpg()

/*//Add by Jack 08.30.2007
integer          li_index, li_count 
windowobject     lwo_temp 
u_dw_contract       lst_temp 

li_count = UpperBound ( tab_1.tabpage_browse.Control[] ) 
FOR li_index = 1 TO li_count 
    lwo_temp = tab_1.tabpage_browse.Control[li_index] 
    CHOOSE CASE lwo_temp.TypeOf() 
       CASE datawindow! 
            lst_temp = lwo_temp 
				if inv_contract_details.of_get_protect_columns( ) then 
					lst_temp.of_disable_columns( ) 
				 else
					lst_temp.of_enable_columns( )
				end if 
       CASE ELSE 
               //Nothing 
   END CHOOSE 
NEXT
//End add by Jack 08.30.2007*/
//--------End Modified ------------------------------------

end event

event resize;call super::resize;tab_1.tabpage_preview.dw_preview.width = tab_1.width - 48
//-------------Appeon Begin -----by Derek at 03.13.2007---------
//tab_1.tabpage_preview.cb_1.x = tab_1.width - 88
//-------------Appeon End   ------------------------------------
//Start code by Jervis 05.29.2008
//Fixed BugG052902(PB&WEB p2)
this.tab_1.tabpage_browse.dw_filter.of_resize( )
this.tab_1.tabpage_browse.dw_browse.of_resize( )
//End code By Jervis 05.29.2008
end event

event ue_initinstancevar;call super::ue_initinstancevar;is_filter = ""
il_preview_doc_id = 0
idc_preview_revision = 0
is_doc_ext = ""
ib_browse = false
end event

type st_1 from u_tabpg_contract_master`st_1 within u_tabpg_dm_audit
end type

type tab_1 from tab within u_tabpg_dm_audit
integer x = 9
integer y = 4
integer width = 3803
integer height = 1880
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
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

event selectionchanged;int	li_ret
long	ll_Right

If ib_browse Then
	of_menu_security()
End If
ib_browse = True

IF newindex = 2 THEN
	IF il_doc_id <> il_preview_doc_id OR idc_revision <> idc_preview_revision THEN
		li_ret = parent.event ue_preview( il_doc_id, idc_revision,is_doc_ext)
		
		IF li_ret > 0 THEN
			il_preview_doc_id = il_doc_id
			idc_preview_revision = idc_revision
		END IF
	END IF
END IF

//BEGIN---Modify by Scofield on 2010-05-11
if IsValid(m_pfe_cst_mdi_menu_contract_am) then
	ll_Right = w_mdi.of_security_access(6924)
	if ll_Right <> 0 and NewIndex = 1 then
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_view.m_filter,'ToolbarItemVisible', true)
		if tabpage_browse.dw_filter.Visible then
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_view.m_filter,'Enabled', false)
		else
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_view.m_filter,'Enabled', true)
		end if
	else
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_view.m_filter,'ToolbarItemVisible', false)
	end if
end if
//END---Modify by Scofield on 2010-05-11

end event

type tabpage_browse from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 16
integer width = 3767
integer height = 1752
long backcolor = 79741120
string text = "Browse"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "custom065!"
long picturemaskcolor = 12632256
string powertiptext = "Browse"
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
integer x = 5
integer y = 352
integer width = 3749
integer height = 1396
integer taborder = 30
boolean bringtotop = true
boolean titlebar = true
string title = "Document Browse"
string dataobject_original = "d_dm_doc_audit_browse"
boolean ib_allow_sort = true
end type

event rowfocuschanged;call super::rowfocuschanged;if this.rowcount() < 1 then
	tab_1.tabpage_preview.enabled = False
	return success
end if 
If this.getrow() > 0 Then
	is_doc_ext = trim(lower(this.getitemstring(this.getrow(),'doc_ext')))
	of_set_docrevision(this.getitemnumber( currentrow, 'doc_id'),this.getitemdecimal( currentrow,'revision'))
	CHOOSE CASE Lower(is_doc_ext)
		CASE 'tif','tiff','jfk','bmp','jpc','jpe','jpeg','pcx','dcx','xif','gif','wif','ibk','pdf'
			tab_1.tabpage_preview.enabled = True
			
			//Added By Ken.Guo 2011-05-06. for Open PDF Mode
			If lower(is_doc_ext) = 'pdf' and gnv_data.of_getitem( 'icred_settings', 'openpdfwith', false) = '2' Then
				tab_1.tabpage_preview.enabled = False
			End If
			
		CASE 'doc'
			tab_1.tabpage_preview.enabled = True
		CASE ELSE
			tab_1.tabpage_preview.enabled = False
	END CHOOSE
End If

Event ue_set_security() //Added By Ken.Guo 2011-06-20. 
end event

event doubleclicked;call super::doubleclicked;If row > 0 Then
	event ue_preview(il_doc_id,idc_revision,is_doc_ext)
End If
end event

event pfc_retrieve;call super::pfc_retrieve;return this.retrieve(il_doc_id)

end event

event constructor;call super::constructor;this.of_SetRowManager(TRUE)
this.of_setrowselect( true)
this.inv_rowselect.of_setstyle( inv_rowselect.single)

this.of_setupdateable( false)
this.ib_rmbmenu=false



end event

event buttonclicked;call super::buttonclicked;string ls_notes
if of_check_read_only( ) then return success  //Add by Jack 08.30.2007
If dwo.name = 'b_note' Then
	If row > 0 Then
		ls_notes = this.getitemstring(row,'notes')
		If isnull(ls_notes) = False And ls_notes <> '' Then
			OpenWithParm( w_audit_notes, ls_notes)
		End If
	End If
	
End If

end event

event rbuttondown;//

end event

event resize;call super::resize;//of_resize()	//04.17.2008 By Jervis:resize dataobject
end event

event pfc_filterdlg;call super::pfc_filterdlg;If dw_filter.visible Then
	of_hidesearch()
Else
	of_ShowSearch()		//Added by Scofield on 2010-04-28	
End If


Return 1

end event

type dw_filter from u_dw_contract within tabpage_browse
string tag = "Filter Criteria"
integer x = 5
integer y = 8
integer width = 3753
integer height = 340
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Filter Criteria"
boolean vscrollbar = false
boolean livescroll = false
string dataobject_original = "d_dm_audit_filter"
end type

event constructor;call super::constructor;this.of_setdropdowncalendar( true)
this.iuo_calendar.of_register( "")
If this.rowcount() < 1 then this.insertrow(0)
this.of_setupdateable( false)
this.ib_rmbmenu=false
this.Event ue_populatedddws()
this.getchild('action',idw_child)
idw_child.settransobject(sqlca)

of_HideSearch()		//Added by Scofield on 2010-04-28

end event

event buttonclicked;call super::buttonclicked;string ls_action,ls_action_date,ls_action_date_1,ls_user
string ls_filter = ''
dec{1} ll_revision
long ll_row
datetime ldt_action_date, ldt_action_date_1 //03.14.2008

//---------Begin commented by Alfee 09.30.2007---------------------
//if of_check_read_only( ) then return success  //Add by Jack 08.30.2007
//---------End Commented ------------------------------------------

//-----Begin Modified by Alfee 08.23.2007 --------
//IF this.accepttext() < 1 THEN return 
this.accepttext()
//-----End Modified ------------------------------
If this.rowcount() < 1 Then Return
ll_row = this.getrow()
Choose case dwo.name
	case 'b_1'
		//--------Begin Modified by Alfee 01.09.2008-------
		//ll_revision = this.getitemnumber(ll_row,'revision')
		//If isnull(ll_revision) = False And ll_revision <> 0 Then
		ll_revision = this.getitemdecimal(ll_row,'revision')			
		If Not IsNull(ll_revision) Then
		//--------End modified-----------------------------
			ls_filter = "revision = " + string(ll_revision)						
		End If
		ls_action = this.getitemstring(ll_row,'action')
		If isnull(ls_action) = False And ls_action <> '' Then
			If isnull(ls_filter) = False And ls_filter <> '' Then
				ls_filter = ls_filter + " And action = '" + ls_action + "'"
			Else
				ls_filter = "action = '" + ls_action + "'"
			End If
		End If

		//----------Begin Modified by Alfee 03.14.2008 -----------------------
		ldt_action_date = this.getitemdatetime(ll_row,'action_date')
		ldt_action_date_1 = this.getitemdatetime(ll_row,'action_date_1')
		IF Not IsNull( ldt_action_date ) THEN
			If Not Isnull(ls_filter) and ls_filter <> '' Then ls_filter += " AND "
			//ls_filter += " Date(action_date) >= Date('" + String( Date( ldt_action_date ), "yyyy-mm-dd" ) + "') "
			ls_filter += " String(action_date, 'yyyy/mm/dd') >= '" + String( ldt_action_date, 'yyyy/mm/dd') + "' " //alfee 12.11.2008
		END IF		
		IF Not IsNull( ldt_action_date_1 ) THEN
			If Not Isnull(ls_filter) and ls_filter <> '' Then ls_filter += " AND "			
			//ls_filter += " Date(action_date) <= Date('" + String( Date( ldt_action_date_1 ), "yyyy-mm-dd" ) + "') "
			ls_filter += " String(action_date, 'yyyy/mm/dd') <= '" + String( ldt_action_date_1, 'yyyy/mm/dd') + "' "	 //alfee 12.11.2008
		END IF
		/*		ls_action_date = string(this.getitemdatetime(ll_row,'action_date'),'mm/dd/yyyy')
		ls_action_date_1 = string(this.getitemdatetime(ll_row,'action_date_1'),'mm/dd/yyyy')
		If isnull(ls_action_date) = False And ls_action_date <> '' Then
			If isnull(ls_action_date_1) Or ls_action_date_1 = '' Then
				this.setitem(ll_row,'action_date_1',this.getitemdatetime(ll_row,'action_date'))
				ls_action_date_1 = ls_action_date
			End If
			If isnull(ls_filter) = False And ls_filter <> '' Then
				ls_filter = ls_filter + " And string(action_date,'mm/dd/yyyy') between '" + ls_action_date + "' And '" + ls_action_date_1 + "'"
			Else
				ls_filter = "string(action_date,'mm/dd/yyyy') between '" + ls_action_date + "' And '" + ls_action_date_1 + "'"
			End If
		End If*/
		//-----------End Modified -----------------------------------------------
				
		ls_user = this.getitemstring(ll_row,'user')	
		If isnull(ls_user) = False And ls_user <> '' Then
			If isnull(ls_filter) = False And ls_filter <> '' Then
				ls_filter = ls_filter + " And lower(action_by) like '" + lower(ls_user) + "%'"
			Else
				ls_filter = "lower(action_by) like '" + lower(ls_user) + "%'"
			End If
		End If		
		dw_browse.setfilter(ls_filter)
		dw_browse.filter()
		dw_browse.event rowfocuschanged(1)
	case 'b_2'
		this.reset()
		this.insertrow(0)
		dw_browse.setfilter('')
		dw_browse.filter()
		dw_browse.event rowfocuschanged(1)
	Case 'b_me'
		This.Object.User[Row] = gs_user_id
		This.Trigger Event ButtonClicked(Row,ActionReturnCode,This.Object.b_1)
	Case 'b_close'
		of_HideSearch()
End Choose

end event

event itemchanged;call super::itemchanged;datetime ldt_action_date,ldt_action_date_1
this.accepttext()

If dwo.name = 'action_date' Then
	ldt_action_date = this.getitemdatetime(this.getrow(),'action_date')
	ldt_action_date_1 = this.getitemdatetime(this.getrow(),'action_date_1')
	If isnull(ldt_action_date_1) then
		this.setitem(this.getrow(),'action_date_1',ldt_action_date)
	End If
End If

end event

event retrieveend;call super::retrieveend;long ll_size

end event

event resize;call super::resize;//of_resize()	//04.17.2008 By Jervis:resize dataobject
end event

event pfc_filterdlg;Return dw_browse.Trigger Event pfc_filterdlg()
end event

type tabpage_preview from userobject within tab_1
integer x = 18
integer y = 16
integer width = 3767
integer height = 1752
long backcolor = 79741120
string text = "Preview"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "custom090!"
long picturemaskcolor = 12632256
string powertiptext = "Preview"
dw_preview dw_preview
uo_2 uo_2
ole_doc ole_doc
end type

on tabpage_preview.create
this.dw_preview=create dw_preview
this.uo_2=create uo_2
this.ole_doc=create ole_doc
this.Control[]={this.dw_preview,&
this.uo_2,&
this.ole_doc}
end on

on tabpage_preview.destroy
destroy(this.dw_preview)
destroy(this.uo_2)
destroy(this.ole_doc)
end on

type dw_preview from u_dw_contract within tabpage_preview
boolean visible = false
integer x = 18
integer y = 16
integer width = 3648
integer height = 164
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_dm_doc_audit_preview"
boolean vscrollbar = false
boolean livescroll = false
end type

event pfc_retrieve;call super::pfc_retrieve;return this.retrieve(il_doc_id)

end event

event constructor;call super::constructor;this.of_setupdateable( false)
this.Event ue_populatedddws()

end event

event getfocus;//
end event

event losefocus;//
end event

event itemchanged;call super::itemchanged;long	ll_size

If tab_1.tabpage_preview.ole_doc.object.doctype <> 1 Then return 

if tab_1.tabpage_preview.ole_doc.visible = false then return

end event

event rbuttondown;//

end event

event rbuttonup;//

end event

type uo_2 from uo_dm_image_view_cp within tabpage_preview
integer x = 5
integer y = 4
integer taborder = 70
end type

on uo_2.destroy
call uo_dm_image_view_cp::destroy
end on

event constructor;call super::constructor;//Alfee 07.28.2008.2008

this.of_set_module('AUDIT') //from document manager audit
end event

type ole_doc from u_email_edit within tabpage_preview
integer x = 238
integer width = 3749
integer height = 1752
integer taborder = 40
string binarykey = "u_tabpg_dm_audit.udo"
end type

event constructor;call super::constructor;inv_ole_utils_doc = create n_cst_ovole_utils
inv_ole_utils_doc.of_initial( ole_doc)
inv_ole_utils_doc.of_setreadonly( true)
end event

event destructor;call super::destructor;if isvalid(inv_ole_utils_doc) then
	destroy inv_ole_utils_doc
end if
end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
0Fu_tabpg_dm_audit.bin 
2B00000600e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe00000006000000000000000000000001000000010000000000001000fffffffe00000000fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000fffffffe00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1Fu_tabpg_dm_audit.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
