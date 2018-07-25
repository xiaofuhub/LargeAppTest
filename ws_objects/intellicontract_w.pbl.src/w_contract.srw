$PBExportHeader$w_contract.srw
$PBExportComments$[intellicontract_w] The main contract window
forward
global type w_contract from w_sheet
end type
type cb_1 from commandbutton within w_contract
end type
type tab_contract_details from u_tab_contract_details within w_contract
end type
type tab_contract_details from u_tab_contract_details within w_contract
end type
end forward

global type w_contract from w_sheet
integer x = 214
integer y = 221
integer width = 3982
integer height = 2256
string title = "IntelliContract"
long backcolor = 33551856
event type long ue_save ( )
event ue_keydown pbm_keydown
event ue_add_blank_page ( )
event ue_annotationtoolselection ( )
event ue_burninannotations ( )
event ue_del_thumbs ( )
event ue_delete_image_page ( )
event ue_draw_text_zone ( )
event ue_hide_add_annotation_groups ( )
event ue_image_copy ( )
event ue_image_cut ( )
event ue_image_paste ( )
event ue_ocr ( )
event ue_ocr_all ( )
event ue_pagedirection ( )
event ue_print ( )
event ue_redo ( )
event ue_remove_all_ocr_zones ( )
event ue_rotate_all_pages ( )
event ue_rotatepage ( )
event ue_scan ( )
event ue_setthumbsize ( )
event ue_show_anotations ( )
event ue_showannotationtoolpalette ( )
event ue_straighten_page ( )
event ue_undo ( )
event ue_delete_image_object ( )
event ue_save_contract_dir ( )
event pfc_cst_print_report ( )
event pfc_cst_email ( )
event ue_view ( )
event pfc_cst_contact ( )
event pfc_cst_workflow ( )
event pfc_cst_contact_detail ( )
event ue_do ( string as_action )
event pfc_copy ( )
event ue_print_letter ( )
event ue_copy_contract ( )
event ue_set_tabpage_properties ( )
event type long ue_show_closequery ( )
event ue_show_preopen ( )
event ue_show_open ( )
event ue_show_postopen ( )
event ue_show_close ( )
event ue_show_loadtabpage ( )
event ue_saveas_ctx ( )
event ue_use_template ( )
event pfc_cst_batch_email ( )
event display_calendar ( )
event display_default ( )
event display_treeview ( )
event ue_select ( )
event ue_refresh ( )
event ue_report ( )
event ue_auto_refresh ( )
event ue_batch_add ( )
event ue_batch_create ( )
event ue_batch_queue ( )
event ue_powerfilter ( )
event pfc_cst_contract_alarm_analyzer ( )
event ue_use_template_list ( long al_id )
event ue_copy_sub_contract ( )
event ue_new_sub_contract ( )
event ue_contract_templates_management ( )
event ue_select_all ( )
event pfc_cst_newmail ( )
event type integer pfc_cst_reply ( )
event type integer pfc_cst_reply_all ( )
event type integer pfc_cst_forward ( )
event pfc_cst_checkin ( )
event type integer pfc_cst_options ( )
event pfc_cst_email_log ( )
event pfc_cst_importmsg ( )
event type integer pfc_cst_find ( )
event pfc_cst_refresh ( )
event pfc_filterdlg ( )
cb_1 cb_1
tab_contract_details tab_contract_details
end type
global w_contract w_contract

type prototypes
//BEGIN---Modify by Evan 10/29/2008
Function long ShowWindow(long hWnd, long nCmdShow) Library "user32.dll"
Function long SendMessage(long hWnd, ulong Msg, long wParam, long lParam) Library "user32.dll" Alias For "SendMessageA"
//END---Modify by Evan 10/29/2008
end prototypes

type variables

string is_title 
n_cst_contract inv_contract_codes 
boolean ib_validation_1 = False //Add by Jack 04/19/2007
boolean ib_just_saved

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 01.29.2007 By: Frank.Gui
//$<reason> Change Supporting Document to Document Manager. This is unuseful.
//uo_ctt_image iuo_1/* The Imaging object*/

//---------------------------- APPEON END ----------------------------
//u_tabpg_contract_search u_to_open

n_cst_ctx_audit inv_audit

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<add> 03.17.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Define a variable to be used in subsequent script.
Boolean ib_win_just_open = TRUE
Boolean ib_manage_tabs_enabled = TRUE
//---------------------------- APPEON END ----------------------------

Boolean ib_copy,ib_copy1   //Add by Jack 07/09/2007      

//Integer ii_changes = 10 //The rows per page displayed in user changed text list //by Alfee 07.23.2007

n_ds ids_screen_prop  //Add by Evan 07/15/2008
n_ds ids_tabpage_prop //Add by Evan 07/15/2008
long il_data_view_id  //Add by Evan 07/15/2008
str_dashboard str_para//Added by Nova on 2008-08-13
Boolean ib_auto_locate //Ken.Guo 2008-09-27
boolean ib_IsMDIClose = false //Add by Evan 10/29/2008

long		il_CurScreenID = 2


end variables

forward prototypes
public function integer wf_change_opject (u_tabpg as_powerobject)
public function integer of_select_tabpage (string as_tab_name)
public function integer of_save_contract ()
public function integer wf_reset_retrieved ()
public function long wf_set_save_status (boolean lb_saved)
public function boolean wf_get_save_status ()
public subroutine of_select_details_tab ()
public function integer of_select_contact_tab ()
public function integer of_set_security ()
public function integer wf_audit (u_dw adw)
public function integer wf_manage_tabs (boolean al_bool)
public function integer of_updatecheck (powerobject apo_control[], ref powerobject apo_control_update[])
public subroutine wf_tab_visible (integer arg_view_id)
public subroutine wf_set_select (string arg_tab, boolean arg_select)
public subroutine of_select_details_tab_retrieved (boolean arg_retrieved)
public subroutine of_add_merge_field (string is_merge_field)
public subroutine of_set_validation (boolean ab_validation)
public function long of_get_view_id ()
public function integer of_set_view_id (long al_data_view_id)
public function integer of_set_tabpage_property (long al_row, ref userobject au_tabpage, string as_icon, string as_def_text, string as_def_icon)
public function long of_get_tabpage_prop_row (long al_data_view_id, string as_tabpage_name)
public function long of_get_screen_prop_row (long al_data_view_id, long al_screen_id)
public subroutine of_dashboard (long ai_ctx_id)
public function integer of_show ()
public function integer of_hide ()
public subroutine of_loadtabpage ()
public function integer of_resetstatus (windowobject awo_control)
public function integer of_backupfocusobject (windowobject awo_control[])
public function integer of_restorefocusobject (windowobject awo_control[])
public function long of_getcurrentscreenid ()
public subroutine of_setcurrentscreenid (long al_curscreenid)
public function boolean of_isexceedmaxcnts ()
public subroutine of_savewindowstate ()
public subroutine of_restorewindowstate ()
public subroutine of_setbkcolor (long al_bkcolor)
public function integer wf_set_tab_enabled (boolean ab_enable)
public subroutine of_set_searchtab_menu ()
public function integer wf_get_tab_visible (long al_view_id, string as_tabname)
public function integer wf_get_batch_ctx (ref str_batch_doc astr_ctx_doc)
public subroutine wf_set_tabs_icon ()
public subroutine of_show_contract_window ()
public subroutine of_check_validation ()
public function string wf_addtextblank (string as_text)
public subroutine wf_setupdateobjects ()
public subroutine of_set_tab_attribute ()
public subroutine wf_open_document (long al_docid)
public function datawindow of_getactivedatawindow ()
end prototypes

event type long ue_save();/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner  today()
**==================================================================================================================
**  ModIfication Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


long li_rc,ll_rc2

setpointer(hourglass!)

///this.tab_contract_details.tabpage_images.tab_details.tabpage_image.tab_1.tabpage_view.uo_1.of_del_save( )

event pfc_microhelp('Saving Contract. Please Stand by')

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 06.28.2006 By: Liang QingShi
//$<reason> fix a bug
//If tab_contract_details.tabpage_details.uo_1.tab_1.tabpage_notes.dw_1.modIfiedcount() > 0 or tab_contract_details.tabpage_details.uo_1.tab_1.tabpage_custom.dw_1.modIfiedcount() > 0 Then
//	If li_rc = 0 Then
//		gnv_appeondb.of_startqueue( )		
//		tab_contract_details.tabpage_details.uo_1.tab_1.tabpage_notes.dw_1.update()
//		tab_contract_details.tabpage_details.uo_1.tab_1.tabpage_custom.dw_1.update()
//		gnv_appeondb.of_commitqueue( )		
//		m_pfe_cst_mdi_menu_contract.m_file.m_save.enabled = false
//	End If
//End If
//---------------------------- APPEON End ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02
//$<modIfy> 03.10.2006 By: LeiWei
//$<reason> Performance tuning
//$<modIfication> Have the application only check the current tab page instead
//$<modIfication> chekcing the whole tab control before updating the database.
/*	
li_rc =  this.of_updatechecks( )
//this.tab_contract_details.tabpage_details.tab_1.of_accepttext( true)
//ll_rc2 = this.tab_contract_details.tabpage_details.tab_1.of_UpdatesPEnding( )


//li_rc =  THIS.tab_contract_details.tabpage_details.tab_1.tabpage_1.of_updatechecks( )
// start code change --- 11.01.2005 MSKINNER
choose case li_rc
	case -1 
		//of_MessageBox ("pfc_master_closequery_savechanges", gnv_app.iapp_object.DisplayName, "AcceptText error - Please contact Intelisoft Support", exclamation!, ok!, 1)
		return failure
	case -2
		//of_MessageBox ("pfc_master_closequery_savechanges", gnv_app.iapp_object.DisplayName, "UpdatesPEnding error - Please contact Intelisoft Support", exclamation!, ok!, 1)
		return failure
	case -3
		//of_MessageBox ("pfc_master_closequery_savechanges", gnv_app.iapp_object.DisplayName, "Validation error - Please contact Intelisoft Support", exclamation!, ok!, 1)
		return failure
End choose 


// End code change --- 11.01.2005 MSKINNER
If li_rc > 0 or ll_rc2 > 0 Then 
			li_rc =  1 //of_MessageBox ("pfc_master_closequery_savechanges", gnv_app.iapp_object.DisplayName, "Do you want to save changes?", exclamation!, YesNoCancel!, 1)
	Choose Case li_rc
		Case 1
			// YES - Update
			// If the update fails, prevent the window from closing
	      //this.tab_contract_details.tabpage_details.tab_1.of_update( true,true)
			If 1 = 1 Then
			If This.Event pfc_save() < 0 Then return failure
			// ony retrive the contract window If there is a new contract available to see
		   // get the max id in window
			//tab_contract_details.tabpage_search.of_retrieve( )
			
			
			this.wf_set_save_status(true)
			//tab_contract_details.post selecttab( 'tabpage_search')
			this.post wf_set_save_status(false)
			
			  Else 
				setpointer(arrow!)
				 return failure
			End If
		Case 2
			// do nothing reset the datawindows			
		Case 3
			// CANCEL -  Prevent the window from closing
			setpointer(arrow!)
			return success
	End Choose
Else 
	// reset the retived flag to false
		wf_reset_retrieved()
		inv_contract_codes.is_mode = inv_contract_codes.edit
End If
*/

powerobject lpo_empty[], apo_control[]
// Check all object
IF NOT ib_win_just_open THEN
	/*
	//comment by jervis 11.25.2009
	If appeongetclienttype() = 'WEB' Then
		li_rc = This.of_updatecheck( tab_contract_details.Control[tab_contract_details.SelectedTab].Control, apo_control )
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 04.19.2007 By: Jack
		//$<reason> Fix a defect.
		/*
		If li_rc < 0 Then Return FAILURE
		*/
		//---------Begin Modified by Alfee 01.10.2008-------------------------
		//<$Reason>Keep same logic with PB - A bug about setting date alarm in a new ctx		
		/* If li_rc < 0 Then 
			If tab_contract_details.selectedtab = 2 And ib_validation_1 = False Then
  				MESSAGEBOX('IntelliContract' ,'There is no DEFAULT TO assigned to this contract. Please add one before continuing.')			
			End If
			Return FAILURE
		End If */
		If li_rc <= 0 Then 
			If tab_contract_details.selectedtab = 2 And ib_validation_1 = False Then
				If tab_contract_details.tabpage_details.uo_1.dw_ccc.rowcount() < 1 Then
	  				MESSAGEBOX('IntelliContract' ,'There is no DEFAULT TO assigned to this contract. Please add one before continuing.')		
					Return FAILURE 
				End If					  
			End If
			If li_rc < 0 Then Return FAILURE
		End If		
		//---------End Modified ----------------------------------------------
		ib_validation_1 = False
		//---------------------------- APPEON END ----------------------------
	
		If li_rc > 0 Then
			// Initialize array holding the objects that need to be updated.
			of_SetUpdateObjects(tab_contract_details.Control[tab_contract_details.SelectedTab].Control)
	
			// Perform the actual update(s).
			li_rc = Super::Event pfc_save()
			
			If li_rc < 0 Then Return FAILURE	
			this.wf_set_save_status(true)  
			//tab_contract_details.post selecttab( 'tabpage_search')
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 06.11.2007 By: Jack
			//$<reason> Fix a defect.
			/*
			this.post wf_set_save_status(false)
			*/
			wf_set_save_status(false)			
			//---------------------------- APPEON END ----------------------------

			// Clear array holding the objects that were just updated.
			of_SetUpdateObjects(This.control)
		End If
	Else
	*/
		li_rc =  this.of_updatechecks( )
		If li_rc > 0 Then
			li_rc = Super::Event pfc_save()
			If li_rc < 0 Then Return FAILURE	
			this.wf_set_save_status(true)
			//tab_contract_details.post selecttab( 'tabpage_search')
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 06.11.2007 By: Jack
			//$<reason> Fix a defect.
			/*
			this.post wf_set_save_status(false)
			*/
			wf_set_save_status(false)
			//---------------------------- APPEON END ----------------------------
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 04.19.2007 By: Jack
		//$<reason> Fix a defect.
			ib_validation_1 = False
		Elseif li_rc < 0 then
			If tab_contract_details.selectedtab = 2 And ib_validation_1 = False Then
				IF tab_contract_details.tabpage_details.uo_1.dw_ccc.rowcount() < 1 THEN
					MESSAGEBOX('IntelliContract' ,'There is no DEFAULT TO assigned to this contract. Please add one before continuing.')
					Return FAILURE
				End If
			End If
			If li_rc < 0 Then Return FAILURE //Added by Alfee 01.10.2008
		//---------------------------- APPEON END ----------------------------
		else	//No changes to update were found - jervis 11.18.2010
			If isvalid(m_pfe_cst_mdi_menu_contract) Then
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_file.m_save,'enabled', false)
			end if
		End If
	//End If
END IF
//---------------------------- APPEON End ----------------------------

//THIS.TITLE = 'IntelliContract '  + '(' + 'Search Mode' + ')'

// reset the retived flag to false
wf_reset_retrieved()
inv_contract_codes.is_mode = inv_contract_codes.edit
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 07.06.2007 By: Jack
//$<reason> Fix a defect.
If isvalid(m_pfe_cst_mdi_menu_contract) Then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_newcontract.m_copyctx,'enabled', True)
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_contract0.m_copy_contract_record,'enabled', True)						//Added By Mark Lee 12/18/2012
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_contract0.m_copy_create_sub_contract_record,'enabled', True)		//Added By Mark Lee 12/18/2012
End If 
//Begin - Added By Mark Lee 12/18/2012
If isvalid(m_pfe_cst_mdi_menu_contract_am) Then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_contract0.m_copy_contract_record,'enabled', True)						
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_contract0.m_copy_create_sub_contract_record,'enabled', True)		
End If 
//End - Added By Mark Lee 12/18/2012
//---------------------------- APPEON END ----------------------------

setpointer(arrow!)
return success
end event

event ue_keydown;


IF KeyDown(KeyControl!) and KeyDown(65) then

end if
end event

event ue_add_blank_page();

//$<comment> 01.29.2007 By: Frank.Gui
//$<reason> Change Supporting Document to Document Manager. This is unuseful.
//iuo_1.event ue_add_blank_page(message.longparm ,message.stringparm)
//---------------------------- APPEON END ----------------------------

end event

event ue_annotationtoolselection();
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 01.29.2007 By: Frank.Gui
//$<reason> Change Supporting Document to Document Manager. This is unuseful.
//iuo_1.event ue_annotationtoolselection(message.stringparm)
//---------------------------- APPEON END ----------------------------
end event

event ue_burninannotations();
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 01.29.2007 By: Frank.Gui
//$<reason> Change Supporting Document to Document Manager. This is unuseful.
//iuo_1.event UE_BurnInAnnotations()
//---------------------------- APPEON END ----------------------------

end event

event ue_del_thumbs();
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 01.29.2007 By: Frank.Gui
//$<reason> Change Supporting Document to Document Manager. This is unuseful.
//iuo_1.event ue_del_thumbs( )
//---------------------------- APPEON END ----------------------------

end event

event ue_delete_image_page();
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 01.29.2007 By: Frank.Gui
//$<reason> Change Supporting Document to Document Manager. This is unuseful.
//iuo_1.event ue_delete_image_page( )
//---------------------------- APPEON END ----------------------------

end event

event ue_draw_text_zone();

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 01.29.2007 By: Frank.Gui
//$<reason> Change Supporting Document to Document Manager. This is unuseful.
//iuo_1. event ue_draw_text_zone( )
//---------------------------- APPEON END ----------------------------

end event

event ue_hide_add_annotation_groups();
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 01.29.2007 By: Frank.Gui
//$<reason> Change Supporting Document to Document Manager. This is unuseful.

/*choose case message.longparm
	case 1 // hide
		iuo_1.ole_edit.object.HideAnnotationGroup(message.stringparm)
	case 2 // show
		iuo_1.ole_edit.object.ShowAnnotationGroup(message.stringparm)
end choose

iuo_1.ole_edit.object.Refresh()
*/
//---------------------------- APPEON END ----------------------------


end event

event ue_image_copy();
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 01.29.2007 By: Frank.Gui
//$<reason> Change Supporting Document to Document Manager. This is unuseful.
//iuo_1.event ue_image_copy( )
//---------------------------- APPEON END ----------------------------
end event

event ue_image_cut();
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 01.29.2007 By: Frank.Gui
//$<reason> Change Supporting Document to Document Manager. This is unuseful.
//iuo_1.event ue_image_cut( )
//---------------------------- APPEON END ----------------------------


end event

event ue_image_paste();
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 01.29.2007 By: Frank.Gui
//$<reason> Change Supporting Document to Document Manager. This is unuseful.
//iuo_1.event ue_image_paste( )
//---------------------------- APPEON END ----------------------------

end event

event ue_ocr();
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 01.29.2007 By: Frank.Gui
//$<reason> Change Supporting Document to Document Manager. This is unuseful.
//iuo_1.event ue_ocr( )
//---------------------------- APPEON END ----------------------------

end event

event ue_ocr_all();
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 01.29.2007 By: Frank.Gui
//$<reason> Change Supporting Document to Document Manager. This is unuseful.
//iuo_1.event ue_ocr_all( )
//---------------------------- APPEON END ----------------------------

end event

event ue_pagedirection();

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 01.29.2007 By: Frank.Gui
//$<reason> Change Supporting Document to Document Manager. This is unuseful.
//iuo_1.event ue_pagedirection(message.longparm)
//---------------------------- APPEON END ----------------------------



end event

event ue_print();

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 01.29.2007 By: Frank.Gui
//$<reason> Change Supporting Document to Document Manager. This is unuseful.
//iuo_1.event ue_print( )
//---------------------------- APPEON END ----------------------------

end event

event ue_redo();
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 01.29.2007 By: Frank.Gui
//$<reason> Change Supporting Document to Document Manager. This is unuseful.
//iuo_1.event ue_redo( )
//---------------------------- APPEON END ----------------------------

end event

event ue_remove_all_ocr_zones();
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 01.29.2007 By: Frank.Gui
//$<reason> Change Supporting Document to Document Manager. This is unuseful.
//iuo_1.event ue_remove_all_ocr_zones()
//---------------------------- APPEON END ----------------------------
end event

event ue_rotate_all_pages();//

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 01.29.2007 By: Frank.Gui
//$<reason> Change Supporting Document to Document Manager. This is unuseful.
//iuo_1.event ue_rotate_all_pages(message.longparm)
//---------------------------- APPEON END ----------------------------


end event

event ue_rotatepage();
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 01.29.2007 By: Frank.Gui
//$<reason> Change Supporting Document to Document Manager. This is unuseful.
//iuo_1.event ue_rotatepage(message.longparm)
//---------------------------- APPEON END ----------------------------

end event

event ue_scan();/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner 26 August 2005  ?Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 01.29.2007 By: Frank.Gui
//$<reason> Change Supporting Document to Document Manager. This event is unuseful.

/*ldw = this.tab_contract_details.tabpage_images.tab_1.tabpage_browse.dw_1

choose case m_pfe_cst_mdi_menu_contract.m_imagingtools.m_scan.ToolbarItemText 
	case 'Browse'
		    this.tab_contract_details.tabpage_images.tab_1.tabpage_browse.of_browse( )
	case 'Scan'
		   // fix
			setredraw(false)
			this.tab_contract_details.tabpage_images.tab_1.tabpage_view.enabled = true
			this.tab_contract_details.tabpage_images.tab_1.SelectTab ('tabpage_view')
			IF NOT F_VALIDSTR(inv_contract_codes.OF_GET_current_image( )) THEN 
				this.iuo_1.event dynamic ue_scan(1 )
				this.tab_contract_details.tabpage_images.tab_1.SelectTab ('tabpage_browse')
				string ls_current_sort
				ls_current_sort = ldw.Object.DataWindow.Table.Sort
				ldw.setsort('image_id')
				ldw.sort( )
				ldw.setrow(this.tab_contract_details.tabpage_images.tab_1.tabpage_browse.dw_1.rowcount())
				ldw.triggerevent(doubleclicked!)
				ldw.setsort(ls_current_sort)
				ldw.sort( )
				
				inv_contract_codes.of_adjust_menu( this.tab_contract_details.tabpage_images.tab_1.tabpage_view , '')
			else
				openwithparm(w_contract_print,iuo_1)

			end if
			setredraw(true)
	case else
		
end choose */
//---------------------------- APPEON END ----------------------------u_dw ldw 



end event

event ue_setthumbsize();
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 01.29.2007 By: Frank.Gui
//$<reason> Change Supporting Document to Document Manager. This is unuseful.
//iuo_1.event ue_setthumbsize( )
//---------------------------- APPEON END ----------------------------

end event

event ue_show_anotations();
 
 //--------------------------- APPEON BEGIN ---------------------------
//$<comment> 01.29.2007 By: Frank.Gui
//$<reason> Change Supporting Document to Document Manager. This is unuseful.
//iuo_1.event ue_show_anotations(message.longparm)
//---------------------------- APPEON END ----------------------------

 
 

end event

event ue_showannotationtoolpalette();
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 01.29.2007 By: Frank.Gui
//$<reason> Change Supporting Document to Document Manager. This is unuseful.
//iuo_1.event ue_showannotationtoolpalette( )
//---------------------------- APPEON END ----------------------------

end event

event ue_straighten_page();

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 01.29.2007 By: Frank.Gui
//$<reason> Change Supporting Document to Document Manager. This is unuseful.
//iuo_1.event ue_straighten_page( )
//---------------------------- APPEON END ----------------------------

end event

event ue_undo();
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 01.29.2007 By: Frank.Gui
//$<reason> Change Supporting Document to Document Manager. This is unuseful.
//iuo_1.event ue_undo( )
//---------------------------- APPEON END ----------------------------


end event

event ue_delete_image_object();



//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 01.29.2007 By: Frank.Gui
//$<reason> Change Supporting Document to Document Manager. This is unuseful.
//iuo_1.event ue_delete_image_object( )
//---------------------------- APPEON END ----------------------------


//
end event

event ue_save_contract_dir();//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.23.2007 By: Jack
//$<reason> Fix a defect.
/*
inv_contract_codes.of_save_contract_dir( )
*/
If isvalid(inv_contract_codes) Then
	inv_contract_codes.of_save_contract_dir( )
End If
//---------------------------- APPEON END ----------------------------


end event

event pfc_cst_print_report();

triggerevent( 'ue_print')
end event

event pfc_cst_email();//////////////////////////////////////////////////////////////////////
// $<event>w_sheetpfc_cst_email()
// $<arguments>
//		None		
// $<returns> (None)
// $<description>Contract module modification 
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 07.25.2006 by Liang QingShi
//////////////////////////////////////////////////////////////////////
long ll_contact_id
string ls_dw,ls_contact_email
ll_contact_id = tab_contract_details.tabpage_details.uo_1.il_contact_id
ls_dw = tab_contract_details.tabpage_details.uo_1.is_dw
if isnull(ls_dw) or trim(ls_dw) = '' then return

//SELECT top 1 contact_email into :ls_contact_email FROM CTX_CONTACTS_NUMBERS WHERE contact_id = :ll_contact_id and contact_email is not null;

IF ls_dw = 'Contracted Company' THEN
	tab_contract_details.tabpage_details.uo_1.dw_ccc.event ue_mail('',ls_contact_email)	
ELSE
	tab_contract_details.tabpage_details.uo_1.dw_occ.event ue_mail('',ls_contact_email)	
END IF

end event

event ue_view();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.08.2006 By: LeiWei
//$<reason> Implement new requirement.
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 01.29.2007 By: Frank.Gui
//$<reason> Change Supporting Document to Document Manager. This is unuseful.
/*
u_dw ldw 
ldw = this.tab_contract_details.tabpage_images.tab_1.tabpage_browse.dw_1
this.tab_contract_details.tabpage_images.tab_1.tabpage_browse.of_view( )*/
//---------------------------- APPEON END ----------------------------


//---------------------------- APPEON END ----------------------------

end event

event pfc_cst_contact();//////////////////////////////////////////////////////////////////////
// $<event>w_sheet pfc_cst_contact()
// $<arguments>
//		value	integer		
// $<returns> 
// $<description> Add a new icon to Menu Bar named Contacts.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 10.30.2006 by Jack 
//////////////////////////////////////////////////////////////////////

str_pass lstr_pass
Long ll_screen_id
Powerobject luo_focus

//Added By Ken.Guo 2011-05-27.  Show current contact detail
If isvalid(gw_contract) Then
	If gw_contract.tab_contract_details.selectedtab = 2 Then
		If Not gw_contract.tab_contract_details.tabpage_details.of_check_read_only( ) Then
			ll_screen_id = gw_contract.of_getcurrentscreenid( )
			Choose Case ll_screen_id
				Case 6
					If gw_contract.tab_contract_details.tabpage_details.uo_1.dw_ccc.rowcount() > 0 Then
						gw_contract.tab_contract_details.tabpage_details.uo_1.dw_ccc.event pfc_contract_detail( )
						Return
					End If
				Case 7
					If gw_contract.tab_contract_details.tabpage_details.uo_1.dw_occ.rowcount() > 0 Then
						gw_contract.tab_contract_details.tabpage_details.uo_1.dw_occ.event pfc_contract_detail( )
						Return
					End If					
			End Choose
		End If
	End If
End If

lstr_pass.s_string = 'All LOCATIONS'
OpenWithParm ( w_contract_contact, lstr_pass)


end event

event pfc_cst_workflow();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.17.2006 By: Jervis
//$<reason> 
tab_contract_details.tabpage_action_items.tab_1.tabpage_detail.triggerevent("pfc_cst_manual_workflow")


//---------------------------- APPEON END ----------------------------


end event

event pfc_cst_contact_detail();//////////////////////////////////////////////////////////////////////
// $<event>w_sheet pfc_cst_contact_detail()
// $<arguments>
// $<returns> 
// $<description> Add a new icon to Menu Bar named Contact detail.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.24.2007 by Davis
//////////////////////////////////////////////////////////////////////


string ls_dw
ls_dw = tab_contract_details.tabpage_details.uo_1.is_dw

IF ls_dw = 'Contracted Company' THEN
	IF Isvalid(tab_contract_details.tabpage_details.uo_1.dw_ccc) THEN
		IF tab_contract_details.tabpage_details.uo_1.dw_ccc.Getrow() > 0 THEN
			tab_contract_details.tabpage_details.uo_1.of_open_contact( tab_contract_details.tabpage_details.uo_1.dw_ccc,'EXTERNAL', TRUE )
		END IF
	END IF
ELSEIF ls_dw = 'Our Company' THEN
	IF Isvalid(tab_contract_details.tabpage_details.uo_1.dw_occ) THEN
		IF tab_contract_details.tabpage_details.uo_1.dw_occ.Getrow() > 0 THEN
			tab_contract_details.tabpage_details.uo_1.of_open_contact( tab_contract_details.tabpage_details.uo_1.dw_occ,'INTERNAL', TRUE )
		END IF
	END IF
END IF


end event

event ue_do(string as_action);//////////////////////////////////////////////////////////////////////
// $<event>ue_do()
// $<arguments>
//		value	string	as_action		
// $<returns> 
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.29.2007 by Frank.Gui
//////////////////////////////////////////////////////////////////////
		
tab_contract_details.tabpage_images.event ue_do(  as_action)
end event

event pfc_copy();//////////////////////////////////////////////////////////////////////
// $<event>pfc_copyw_contract()
// $<arguments>
//		value	integer		
// $<returns> 
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 05.30.2007 by Jack
//////////////////////////////////////////////////////////////////////
string 	ls_copy_contract
long 		ll_ctx_id

graphicobject lgo_focus

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-01-08 By: Scofield
//$<Reason> When current is not on search tabpage,Try sending the message to 
//				the current control, if successful exit event.
if tab_contract_details.SelectedTab <> 1 then
	lgo_focus = GetFocus()
	If IsValid (lgo_focus) Then
		If lgo_focus.TriggerEvent ("pfc_copy") = 1 Then Return
	End If
end if
//---------------------------- APPEON END ----------------------------

This.TriggerEvent("ue_copy_contract")		//Added By Scofield on 2008-03-12: Move below code into ue_copy_contract

////-------Begin Added by Alfee 09.30.2007------
////<$Reason>Add read only control to Contract Module
//If Not inv_contract_codes.of_allow_copyctx() Then 
//	MessageBox("Contract Logix","You don't have rights to copy the contract!")
//	Return
//End If
////-------End Added ---------------------------
//
//ls_copy_contract = tab_contract_details.tabpage_search.is_copy_contract
//openwithparm(w_copy_contract,ls_copy_contract)
//
//ll_ctx_id = message.doubleparm
//
//If ll_ctx_id > 0 Then
//	tab_contract_details.tabpage_search.il_ctx_id = ll_ctx_id
//	inv_contract_codes.of_set_ctx_id(ll_ctx_id)
//	tab_contract_details.tabpage_search.cb_1.triggerevent(clicked!)
//	inv_contract_codes.of_set_ctx_id(ll_ctx_id)
//	wf_set_save_status(false)
//	wf_set_select('All',false)
//	tab_contract_details.tabpage_details.inv_contract_details.il_count = 0  //Add by Jack 07.05.2007
//	of_select_details_tab()	
//	tab_contract_details.tabpage_details.uo_1.dw_1.of_enable_save()  //Add by Jack 07.05.2007
//	//Add by Jack 07.09.2007
//	ib_copy1 = True  
//End If


end event

event ue_print_letter();//Function:ue_print_letter() returns (none)
//describe:multiple print letter
//<add> 06.12.2007 by: Andy
tab_contract_details.tabpage_action_items.tab_1.tabpage_detail.of_print_letter( )
//end of add
end event

event ue_copy_contract();//------------------------------------------------------------------------------
// Event: ue_copy_contract
//------------------------------------------------------------------------------
// Description: Copy contract
// Arguments:
//		None
// Return Value: 
//		None
//------------------------------------------------------------------------------
// Author:	Scofield		Date: 2008-03-12
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

string 	ls_Copy_Contract
long 		ll_ctx_id
Integer li_ret1, li_ret2, li_ret3

if of_IsExceedMaxCnts() then Return

If Not inv_contract_codes.of_allow_copyctx() Then 
	MessageBox("IntelliContract","You don't have rights to copy the contract!")
	Return
End If

//Added By Ken.Guo 2009-08-27.
n_cst_copy_ctx lnv_copy_ctx
lnv_copy_ctx = Create n_cst_copy_ctx
If lnv_copy_ctx.of_check_exist_contract() <= 0 Then 
	If isvalid(lnv_copy_ctx) Then Destroy lnv_copy_ctx
	Return 
End IF


long ll_ctx_id_source //Added By Ken.Guo 2009-08-24.
ll_ctx_id_source = tab_contract_details.tabpage_search.il_ctx_id
//ls_Copy_Contract = tab_contract_details.tabpage_search.is_copy_contract
OpenWithParm(w_copy_contract,ll_ctx_id_source)

ll_ctx_id = Message.DoubleParm

If ll_ctx_id > 0 Then
	lnv_copy_ctx.of_locate_ctx(ll_ctx_id) //Modified By Ken.Guo 2009-08-27
	
	this.of_check_validation( )
//	gw_contract.tab_contract_details.tabpage_details.uo_1.dw_1.of_enable_save()
//	
//	li_ret1 = tab_contract_details.tabpage_details.uo_1.dw_1.event pfc_validation( )
//	If li_ret1 = 1 Then
//		li_ret2 = tab_contract_details.tabpage_details.uo_1.dw_ccc.event pfc_validation( )
//		If li_ret2 = 1 Then
//			li_ret3 = tab_contract_details.tabpage_details.uo_1.dw_occ.event pfc_validation( )			
//		End If
//	End If
//	
//	If (li_ret1 <> 1 or li_ret2 <> 1 or li_ret3 <> 1) Or tab_contract_details.tabpage_details.uo_1.dw_ccc.Modifiedcount( ) + tab_contract_details.tabpage_details.uo_1.dw_occ.Modifiedcount( ) > 0 Then 
//		gw_contract.tab_contract_details.tabpage_details.uo_1.dw_1.of_enable_save()
//	Else
//		If isvalid(m_pfe_cst_mdi_menu_contract) Then
//			m_pfe_cst_mdi_menu_contract.m_file.m_save.enabled = False
//		End If
//	End If

	ib_copy1 = True  
End If


If isvalid(lnv_copy_ctx) Then Destroy lnv_copy_ctx
end event

event ue_set_tabpage_properties();long ll_FindRow
string ls_Condition

//Fix APB Bug:The Contract Folder Flashes to the QRG tab and flashes back to the search screen
//this.SetRedraw(false)		//Commented by Scofield on 2009-09-25

// [Search] Set tabpage_search property
ll_FindRow = of_get_tabpage_prop_row(il_data_view_id, "tabpage_search")
of_set_tabpage_property(ll_FindRow, tab_contract_details.tabpage_search, "Search!", "Search", "Search!")
tab_contract_details.tabpage_search.st_1.backcolor = tab_contract_details.tabpage_search.backcolor
//Added By Alan on 2009-1-15
tab_contract_details.tabpage_search.cbx_1.backcolor = tab_contract_details.tabpage_search.backcolor

// [Details] Set tabpage_details property
ll_FindRow = of_get_tabpage_prop_row(il_data_view_id, "tabpage_details")
of_set_tabpage_property(ll_FindRow, tab_contract_details.tabpage_details, "ArrangeTables!", "Details", "ArrangeTables!")
tab_contract_details.tabpage_details.uo_1.backcolor = tab_contract_details.tabpage_details.backcolor
tab_contract_details.tabpage_details.uo_1.tab_1.backcolor = tab_contract_details.tabpage_details.backcolor

// [Requirements] Set tabpage_requirements property
ll_FindRow = of_get_tabpage_prop_row(il_data_view_id, "tabpage_requirements")
of_set_tabpage_property(ll_FindRow, tab_contract_details.tabpage_requirements, "DosEdit!", "Requirements", "DosEdit!")
tab_contract_details.tabpage_requirements.st_1.backcolor = tab_contract_details.tabpage_requirements.backcolor

// [Other Contacts] Set tabpage_contacts property
ll_FindRow = of_get_tabpage_prop_row(il_data_view_id, "tabpage_contacts")
of_set_tabpage_property(ll_FindRow, tab_contract_details.tabpage_contacts, "Picture!", "Other Contacts", "Picture!")

// [Locations] Set tabpage_locations property
ll_FindRow = of_get_tabpage_prop_row(il_data_view_id, "tabpage_locations")
of_set_tabpage_property(ll_FindRow, tab_contract_details.tabpage_locations, "Globals!", "Locations", "Globals!")
tab_contract_details.tabpage_locations.st_1.backcolor = tab_contract_details.tabpage_locations.backcolor

// [Organizations] Set tabpage_orgabizations property
ll_FindRow = of_get_tabpage_prop_row(il_data_view_id, "tabpage_orgabizations")
of_set_tabpage_property(ll_FindRow, tab_contract_details.tabpage_orgabizations, "SetDefaultClass!", "Organizations", "SetDefaultClass!")

// [Fee Schedules] Set tabpage_fee_schedules property
ll_FindRow = of_get_tabpage_prop_row(il_data_view_id, "tabpage_fee_schedules")
of_set_tabpage_property(ll_FindRow, tab_contract_details.tabpage_fee_schedules, "FormatDollar!", "Fee Schedules", "FormatDollar!")
tab_contract_details.tabpage_fee_schedules.tab_1.backcolor = tab_contract_details.tabpage_fee_schedules.backcolor

// [Fee Schedules(NM)] Set tabpage_fee_sched2 property
ll_FindRow = of_get_tabpage_prop_row(il_data_view_id, "tabpage_fee_sched2")
of_set_tabpage_property(ll_FindRow, tab_contract_details.tabpage_fee_sched2, "FormatDollar!", "Fee Schedule (NM)", "FormatDollar!")
tab_contract_details.tabpage_fee_sched2.st_1.backcolor = tab_contract_details.tabpage_fee_sched2.backcolor

// [Document Manager] Set tabpage_images property
ll_FindRow = of_get_tabpage_prop_row(il_data_view_id, "tabpage_images")
of_set_tabpage_property(ll_FindRow, tab_contract_details.tabpage_images, "Custom083!", "Document Manager", "Custom083!")
tab_contract_details.tabpage_images.tab_1.backcolor = tab_contract_details.tabpage_images.backcolor

// [Action Items] Set tabpage_action_items property
ll_FindRow = of_get_tabpage_prop_row(il_data_view_id, "tabpage_action_items")
of_set_tabpage_property(ll_FindRow, tab_contract_details.tabpage_action_items, "watcom!", "Action Items", "watcom!")
tab_contract_details.tabpage_action_items.tab_1.backcolor = tab_contract_details.tabpage_action_items.backcolor
tab_contract_details.tabpage_action_items.tab_1.tabpage_browse.backcolor = tab_contract_details.tabpage_action_items.backcolor
tab_contract_details.tabpage_action_items.tab_1.tabpage_browse.tabbackcolor = tab_contract_details.tabpage_action_items.backcolor
tab_contract_details.tabpage_action_items.tab_1.tabpage_detail.backcolor = tab_contract_details.tabpage_action_items.backcolor
tab_contract_details.tabpage_action_items.tab_1.tabpage_detail.tabbackcolor = tab_contract_details.tabpage_action_items.backcolor

// [QRG] Set tabpage_qrg property
//ll_FindRow = of_get_tabpage_prop_row(il_data_view_id, "tabpage_qrg")
//of_set_tabpage_property(ll_FindRow, tab_contract_details.tabpage_qrg, "Report5!", "QRG", "Report5!")
//tab_contract_details.tabpage_qrg.tab_1.backcolor = tab_contract_details.tabpage_qrg.backcolor
// [Custom Multi Data] -- jervis 05.31.2011
ll_FindRow = of_get_tabpage_prop_row(il_data_view_id, "tabpage_multi")
of_set_tabpage_property(ll_FindRow, tab_contract_details.tabpage_multi, "Report5!", "Custom multi", "Report5!")
tab_contract_details.tabpage_multi.tab_multi.backcolor = tab_contract_details.tabpage_multi.backcolor

//Added By Mark Lee 02/05/2013
ll_FindRow = of_get_tabpage_prop_row(il_data_view_id, "tabpage_email")
of_set_tabpage_property(ll_FindRow, tab_contract_details.tabpage_email, "home.gif", "Email Manager", "home.gif")
tab_contract_details.tabpage_email.backcolor = tab_contract_details.tabpage_email.backcolor

wf_set_tabs_icon() //Added By Ken.Guo 2010-09-19.

//this.SetRedraw(true)

of_Set_tab_attribute( )//added by gavins 2010415


end event

event type long ue_show_closequery();//////////////////////////////////////////////////////////////////////
// $<event>  ue_show_closequery()
// $<arguments> (None)
// $<returns>   long
// $<description> Close query
//////////////////////////////////////////////////////////////////////
// $<add> 10/29/2008 by Evan
//////////////////////////////////////////////////////////////////////

Constant Integer	ALLOW_CLOSE = 0
Constant Integer	PREVENT_CLOSE = 1
 
Integer	li_msg
Integer	li_rc

long ll_ret 
String	ls_msgparms[]
Powerobject lpo_updatearray[]

// Check if the CloseQuery process has been disabled
If ib_disableclosequery Then
	Return ALLOW_CLOSE
End If

// Call event to perform any pre-CloseQuery processing
If This.Event pfc_preclose ( ) <> 1 Then
	// Prevent the window from closing
	Return PREVENT_CLOSE 
End If

// Prevent validation error messages from appearing while the window is closing
// and allow others to check if the  CloseQuery process is in progress
ib_closestatus = True

// Determine the objects for which an update will be attempted.
// For the CloseQuery, the order sequence is as follows: 
//		1) Specified permananent sequence (thru of_SetUpdateObjects(...)).
//		2) None was specified, so use default window control array.
If UpperBound(ipo_updateobjects) > 0 Then
	lpo_updatearray = ipo_updateobjects
Else
	lpo_updatearray = This.Control		
End If
long ll_rc2


//this.tab_contract_details.tabpage_details.tab_1.of_accepttext( true)
//ll_rc2 = this.tab_contract_details.tabpage_details.tab_1.of_UpdatesPending( )

// Check for any pending updates
li_rc = of_UpdateChecks(lpo_updatearray)
If li_rc = 0  and ll_rc2 =  0 Then
	// Updates are NOT pending, allow the window to be closed.
	ib_closestatus = False
	Return ALLOW_CLOSE
ElseIf li_rc < 0 Then
	// Make sure the window is not minimized and behind other windows.
	If this.WindowState = Minimized! Then
		this.WindowState = Normal!
	End If
	this.BringToTop = True

	// There are Updates pending, but at least one data entry error was found.
	// Give the user an opportunity to close the window without saving changes
	If IsValid(gnv_app.inv_error) Then
		li_msg = gnv_app.inv_error.of_Message('pfc_closequery_failsvalidation', &
					 ls_msgparms, gnv_app.iapp_object.DisplayName)
	Else
		li_msg = of_MessageBox ("pfc_master_closequery_failsvalidation", 	gnv_app.iapp_object.DisplayName, &
					"The information entered does not pass validation and must be corrected before changes can be saved.~r~n~r~n" + &
					"Close without saving changes?", exclamation!, YesNo!, 2)
	End If
	If li_msg = 1 Then
		ib_closestatus = False
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 07.09.2007 By: Jack
		//$<reason> 
		If ib_copy1 = True  Then
			ib_copy = True
			If isvalid(m_pfe_cst_mdi_menu_contract) Then
				m_pfe_cst_mdi_menu_contract.m_edit.m_delete1.triggerevent(clicked!)
			End If
		End If 		
		//---------------------------- APPEON END ----------------------------
		Return ALLOW_CLOSE
	End If
Else
	// Make sure the window is not minimized and behind other windows.
	If this.WindowState = Minimized! Then
		this.WindowState = Normal!
	End If	
	this.BringToTop = True
	
	// Changes are pending, prompt the user to determine if they should be saved
	If IsValid(gnv_app.inv_error) Then
		li_msg = gnv_app.inv_error.of_Message('pfc_closequery_savechanges',  &
					ls_msgparms, gnv_app.iapp_object.DisplayName)		
	Else
		li_msg = of_MessageBox ("pfc_master_closequery_savechanges", &
					gnv_app.iapp_object.DisplayName, &
					"Do you want to save changes?", exclamation!, YesNoCancel!, 1)
	End If
	Choose Case li_msg
		Case 1
			// YES - Update
			// If the update fails, prevent the window from closing
			//tab_contract_details.tabpage_details.tab_1.of_update( true,true)
			
			ll_ret =  Event pfc_save() 
			
			if ll_ret = success or ll_ret = -9 Then ///mskinner because of the nested tabs the update prep may  fail - who cares
				// Successful update, allow the window to be closed
				//ib_closestatus = False
				Return ALLOW_CLOSE
			End If
		Case 2
			// NO - Allow the window to be closed without saving changes
			ib_closestatus = False
			Return ALLOW_CLOSE
		Case 3
			// CANCEL -  Prevent the window from closing
	End Choose
End If

// Prevent the window from closing
ib_closestatus = False
Return PREVENT_CLOSE
end event

event ue_show_preopen();//////////////////////////////////////////////////////////////////////
// $<event>  ue_show_preopen()
// $<arguments> (None)
// $<returns>   (None)
// $<description> Execute preopen event when before shows window
//////////////////////////////////////////////////////////////////////
// $<add> 10/29/2008 by Evan
//////////////////////////////////////////////////////////////////////

if gb_IsDocMode then This.of_Hide()			//Added by Scofield on 2009-07-21

if IsValid(inv_contract_codes) then
	//inv_contract_codes.of_adjust_menu(this.tab_contract_details.tabpage_search, "")
	inv_contract_codes.of_adjust_menu(this.tab_contract_details.tabpage_search, "", True)//Set redraw to false when changing menu, added by Appeon long.zhang 03.09.2017 (Contracts Module Slowness)
end if

end event

event ue_show_open();//////////////////////////////////////////////////////////////////////
// $<event>  ue_show_open()
// $<arguments> (None)
// $<returns>   (None)
// $<description> Execute open event when shows window
//////////////////////////////////////////////////////////////////////
// $<add> 10/29/2008 by Evan
//////////////////////////////////////////////////////////////////////

gnv_win_backcolor.of_ChangeWindowBackColor(this) //Add by Evan 11/25/2008
tab_contract_details.tabpage_search.st_1.Visible = false			//Added by Scofield on 2008-11-21

// Initialization
of_set_security()
gw_contract = this
gnv_appeondb.of_StartQueue()
ids_tabpage_prop.Retrieve()
ids_screen_prop.Retrieve()
gnv_appeondb.of_CommitQueue()

// Get UI back to the first opened
DataWindow ldw_search, ldw_browse
ldw_search = tab_contract_details.tabpage_search.dw_search
ldw_browse = tab_contract_details.tabpage_search.dw_search_det1
if ldw_search.Describe("b_clear.name") = "b_clear" then
	this.Title = "IntelliContract"
	ldw_search.Event ButtonClicked(1, 0, ldw_search.object.b_clear)	
	ldw_browse.Title = "Contract Browse"
	ldw_browse.Reset()
	tab_contract_details.tabpage_search.tv_ctx.deleteitem(1) //Added By Ken.Guo 2009-12-21.
end if

// Get Dashboard parameter from message object
ib_auto_locate = false
if IsValid(Message.PowerObjectParm) then
	if Message.PowerObjectParm.ClassName() = 'str_dashboard' then
		str_para = Message.PowerObjectParm
		ib_auto_locate = true
	end if
end if

//Begin - Added By Mark Lee 10/26/12
//Added By Ken.Guo 2009-12-03.
String ls_mode, ls_browse_screen_results_style

//Added By Mark Lee 10/26/12
ls_browse_screen_results_style = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_Browse_Screen_Results_Style" )
If isnull(ls_browse_screen_results_style ) or trim(ls_browse_screen_results_style ) = '' Then 
	
	If w_Mdi.of_security_access(6978) = 0 Then
		tab_contract_details.tabpage_search.of_set_style(0)
	Else
		ls_mode = gnv_data.of_getitem( "security_users", "contract_display_mode", "user_id = '" +gs_user_id+ "'") 
		If ls_mode = '' or isnull(ls_mode ) or w_Mdi.of_security_access(6957) = 0 Then ls_mode = '0'
		tab_contract_details.tabpage_search.of_set_style(Integer(ls_mode)) 
		If ls_mode = '2' Then
			This.event display_calendar( )
		End If
	End If
Else
	//Added By Mark Lee 10/26/12
	If w_Mdi.of_security_access(6978) = 0 Then
		tab_contract_details.tabpage_search.of_set_styles(True)
	Else
		tab_contract_details.tabpage_search.of_set_styles(False)
	End If
End If
//End - Added By Mark Lee 10/26/12

ib_CloseStatus = false

//Added By Mark Lee 05/14/12 set the tab icon in the first open it by default view setting
//Begin - Added By Mark Lee 05/14/12
If ldw_browse.rowcount( ) <= 0 and ( isnull(il_data_view_id) Or il_data_view_id = 0 ) Then
	il_data_view_id = integer(gnv_data.of_getitem('security_users','contract_default_view',"upper(user_id)='" + upper(gs_user_id) + "'"))
	If isnull(il_data_view_id) Or il_data_view_id = 0 Then
		il_data_view_id = 1001
	End If
	 wf_set_tabs_icon()
End IF	 
 //End - Added By Mark Lee 05/08/12
end event

event ue_show_postopen();//////////////////////////////////////////////////////////////////////
// $<event>  ue_show_postopen()
// $<arguments> (None)
// $<returns>   (None)
// $<description> Execute post open event when after shows window
//////////////////////////////////////////////////////////////////////
// $<add> 10/29/2008 by Evan
//////////////////////////////////////////////////////////////////////

long 		ll_category,ll_Dynamic
integer 	li_view_id
Boolean	lb_DefaultViewSearch
String 	ls_set_as_default

inv_contract_codes = CREATE n_cst_contract
tab_contract_details.of_set_contract_details(inv_contract_codes)

This.wf_set_tab_enabled(False) //Added By Ken.Guo 2010-06-25. After retrieve, they will be set enabled

if AppeonGetClientType() = "WEB" then
	// Execute of_adjust_menu function in ue_show_preopen event for Windows version. This is APB bug.
	//inv_contract_codes.of_adjust_menu(this.tab_contract_details.tabpage_search, "")
	inv_contract_codes.of_adjust_menu(this.tab_contract_details.tabpage_search, "", True) //Set redraw to false when changing menu, added by Appeon long.zhang 03.09.2017 (Contracts Module Slowness)
end if

//Modified By Alan on 2009-1-14
if this.tab_contract_details.tabpage_search.ib_autoretrieve then this.tab_contract_details.tabpage_search.ib_PostOpen = true
if Not ib_win_just_open or w_mdi.Visible then		//Added by Scofield on 2008-11-06
	
	SELECT Dynamic_Search_Tab
	  INTO :ll_Dynamic
	  FROM security_users 
	 WHERE user_id = :gs_user_id;
	
	if ll_Dynamic = 0 or Not IsValid(w_contract_data_design) then
		lb_DefaultViewSearch = true
	else
		if w_contract_data_design.uo_design.il_CurCtxID <= 0 then
			lb_DefaultViewSearch = true
		end if
	end if
	
	if lb_DefaultViewSearch then
		gl_SearchTab_View_id = long(gnv_data.of_getitem('security_users','contract_default_view',"upper(user_id)='" + Upper(gs_user_id) + "'"))
	end if
	if IsNull(gl_SearchTab_View_id) or gl_SearchTab_View_id = 0 then gl_SearchTab_View_id = 1001
	
	tab_contract_details.tabpage_search.TriggerEvent("ue_show_constructor")
	//Begin - Added By Mark Lee 12/03/2012
//	//Modified By Alan on 2009-1-14
//	if this.tab_contract_details.tabpage_search.ib_autoretrieve then this.tab_contract_details.tabpage_search.CB_1.event clicked()	
	If this.tab_contract_details.tabpage_search.ib_autoretrieve then
		//
		ls_set_as_default = gnv_user_option.of_Get_option_value( gs_user_id, "Contract_Search_Tab_Search_filter_set_as_default" )
		IF Not Isnull(ls_set_as_default) and Trim(ls_set_as_default) <> '' and isnumber(ls_set_as_default) Then 
			 this.tab_contract_details.tabpage_search.event ue_search_filter( ls_set_as_default,False)
		End If
		//---------Begin Modified by (Appeon)Harry 02.13.2014 for Bug # 3867 ADDITIONAL INFORMATION IntelliCred stops responding and dies when loading Contract Folder 
		// this.tab_contract_details.tabpage_search.CB_1.event clicked()
		Long ll_ctx_count
		Boolean lb_refresh
		lb_refresh = true
		SELECT COUNT(*) INTO :ll_ctx_count FROM  ctx_basic_info;
		if ll_ctx_count > 20000 then
			if messagebox('Prompt', 'There are so many contracts that querying all records may be very slow. Would you like to skip the Auto Refresh in Contract window?', Question!, YesNo!,1) = 1 then
				lb_refresh = false
				if isvalid(m_pfe_cst_mdi_menu_contract) then
					m_pfe_cst_mdi_menu_contract.m_file.m_options.m_autorefresh.toolbaritemdown = False
					m_pfe_cst_mdi_menu_contract.m_file.m_options.m_autorefresh.tag = 'non-auto'
				end if
				this.tab_contract_details.tabpage_search.of_set_auto_refresh(false)
				this.tab_contract_details.tabpage_search.dw_search.event ue_populatedddws( )
			else
				lb_refresh = true
			end if
		end if
		if lb_refresh then this.tab_contract_details.tabpage_search.CB_1.event clicked()
		//---------End Modfiied ------------------------------------------------------
	End If	
	//End - Added By Mark Lee 12/03/2012
	
end if
ib_win_just_open = FALSE

SetPointer(HourGlass!)
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2009-03-19 By: Ken.Guo
//$<reason> If tabpage_search has retrieved, it do not reget view id.
/*
ll_category = this.tab_contract_details.tabpage_search.inv_contract_details.il_category
li_view_id = integer(gnv_data.of_getitem('code_lookup','ic_n',"lookup_code = " + string(ll_category)))
If isnull(li_view_id) Or li_view_id = 0 Then
	li_view_id = integer(gnv_data.of_getitem('security_users','contract_default_view',"upper(user_id)='" + upper(gs_user_id) + "'"))
End If
//If li_view_id <> gi_contract_view_id Then
	gi_contract_view_id = li_view_id
   wf_tab_visible(li_view_id)
	wf_set_select('All', false)
//End If
*/
If (This.of_get_view_id() = 0) Or (Not tab_contract_details.tabpage_search.ib_autoretrieve) Then //Means do no retrieve.
	li_view_id = integer(gnv_data.of_getitem('security_users','contract_default_view',"upper(user_id)='" + upper(gs_user_id) + "'"))
	If isnull(li_view_id) or li_view_id = 0 Then li_view_id = 1001 //Added By Ken.Guo 09/23/2013
	gi_contract_view_id = li_view_id
   wf_tab_visible(li_view_id)
	wf_set_select('All', false)	
End If
//---------------------------- APPEON END ----------------------------

//Added By Alan on 2009-1-19
//this.tab_contract_details.tabpage_search.ib_autoretrieve = this.tab_contract_details.tabpage_search.cbx_1.checked //Modified By Ken.Guo 2010-06-25

tab_contract_details.tabpage_search.st_1.Visible = true			//Added by Scofield on 2008-11-21
tab_contract_details.tabpage_search.dw_search_det1.SetFocus( ) //Add by jervis 12.7.2009
//if ib_auto_locate then of_Dashboard(str_para.data_id) remove to gf_opencontractfolder() jervis 02.23.2011
If Not tab_contract_details.tabpage_search.ib_autoretrieve Then TriggerEvent("ue_set_tabpage_properties") //added by gavin 20120515
end event

event ue_show_close();//////////////////////////////////////////////////////////////////////
// $<event>  ue_show_close()
// $<arguments> (None)
// $<returns>   (None)
// $<description> Close event
//////////////////////////////////////////////////////////////////////
// $<add> 10/29/2008 by Evan
//////////////////////////////////////////////////////////////////////

window lw_sheet
window lw_invalid

//Save Window State -- jervis 09.10.2009
of_savewindowstate()

// Get next sheet window before hide Contract Folder
lw_sheet = w_mdi.GetNextSheet(this)

// Hide Contract Folder
this.of_Hide()
gw_contract = lw_invalid
this.of_ResetStatus(tab_contract_details)
tab_contract_details.SelectTab(1)
wf_manage_tabs(true)
wf_set_select("All", false)
This.of_set_view_id(0) //Added By Ken.Guo 09/23/2013
this.of_Hide()

if IsValid(w_DocWFStepStatus) then Close(w_DocWFStepStatus)		//Added by Scofield on 2009-07-13
if IsValid(w_CtxWFStepStatus) then Close(w_CtxWFStepStatus)		//Added by Scofield on 2009-08-31

if isvalid(w_profile_report) then close(w_profile_report)  //jervis 09.26.2011

// Change MDI menu
this.Event ue_save_contract_dir()
if IsValid(w_dm_comparison_wizard) then Close(w_dm_comparison_wizard)
if w_mdi.menuname <> 'm_pfe_cst_mdi_menu' then w_mdi.ChangeMenu(m_pfe_cst_mdi_menu)
w_mdi.of_menu_security(w_mdi.MenuName)
if IsValid(w_contract_globalsearch) then Close(w_contract_globalsearch)

////Added By Ken.Guo 2009-09-07.
If isvalid(This.tab_contract_details.tabpage_images.tab_1.tabpage_data.tab_1.tabpage_preview.ole_doc.object) Then
	This.tab_contract_details.tabpage_images.tab_1.tabpage_data.tab_1.tabpage_preview.ole_doc.object.close()
End If

// Active next sheet window
if IsValid(lw_sheet) then
	lw_sheet.Event Activate()
	lw_sheet.SetFocus()
end if

//Added By Ken.Guo 2009-12-24.
String ls_mode
Integer li_mode
li_mode = This.tab_contract_details.tabpage_search.ii_style
ls_mode = gnv_data.of_getitem( "security_users", "contract_display_mode", "user_id = '" +gs_user_id+ "'") 
If Integer(ls_mode) <> li_mode Then
	update security_users set contract_display_mode = :li_mode where user_id = :gs_user_id;
	gnv_data.of_retrieve('security_users')
End If

end event

event ue_show_loadtabpage();//////////////////////////////////////////////////////////////////////
// $<event>  ue_show_loadtabpage()
// $<arguments> (None)
// $<returns>   (None)
// $<description> Select all tabpage
//////////////////////////////////////////////////////////////////////
// $<add> 11/04/2008 by Scofield
//////////////////////////////////////////////////////////////////////

long		ll_Cycle,ll_TabCnt,ll_Step,ll_CurView

Window 	lw_Invalid

gw_contract = lw_Invalid

if IsValid(w_appeon_gifofwait) then w_appeon_gifofwait.of_SkipNextPosition(20)

if gb_IsDocMode then
	ll_TabCnt = 2
else
	ll_TabCnt = UpperBound(This.tab_contract_details.Control[])
end if

if IsValid(w_appeon_gifofwait) then 
	ll_Step = (w_appeon_gifofwait.hpb_1.MaxPosition - w_appeon_gifofwait.hpb_1.Position)/ll_TabCnt
end if

//Modified By Ken.Guo 09/23/2013
ll_CurView = integer(gnv_data.of_getitem('security_users','contract_default_view',"upper(user_id)='" + upper(gs_user_id) + "'"))
IF Isnull(ll_CurView) OR  ll_CurView = 0 THEN ll_CurView = 1001 

if gi_contract_view_id <> ll_CurView then
	//ll_CurView = gi_contract_view_id
	gi_contract_view_id = ll_CurView
	
	if IsValid(gds_contract_screen) then
		gds_contract_screen.SetTransObject(SQLCA)
		gds_contract_screen.Retrieve(gi_contract_view_id)
	end if
end if

if gb_IsDocMode then
	This.tab_contract_details.SelectTab(1)
	if IsValid(w_appeon_gifofwait) then w_appeon_gifofwait.of_SkipNextPosition(ll_Step)
		
	This.tab_contract_details.SelectTab(9)
	if IsValid(w_appeon_gifofwait) then w_appeon_gifofwait.of_SkipNextPosition(ll_Step)
else
	for ll_Cycle = 1 to ll_TabCnt
		If Not This.tab_contract_details.control[ll_Cycle].visible Then Continue //Added By Ken.Guo 09/23/2013
		This.tab_contract_details.SelectTab(ll_Cycle)
		if IsValid(w_appeon_gifofwait) then w_appeon_gifofwait.of_SkipNextPosition(ll_Step)
	next
end if

This.tab_contract_details.SelectTab(1)

if Not This.tab_contract_details.tabpage_search.ib_autoretrieve then  //Jervis 06.30.2009
	This.tab_contract_details.tabpage_search.of_retrieve_ctx() //Added By Ken.Guo 2009-06-03. DataCache.
end if

if ll_CurView <> 0 then
	gi_contract_view_id = ll_CurView
	
	if IsValid(gds_contract_screen) then
		gds_contract_screen.SetTransObject(SQLCA)
		gds_contract_screen.Retrieve(gi_contract_view_id)
	end if
end if

if IsValid(w_appeon_gifofwait) then 
	w_appeon_gifofwait.hpb_1.Position = w_appeon_gifofwait.hpb_1.MaxPosition
end if

this.Post TriggerEvent("ue_show_close")
if IsValid(w_appeon_gifofwait) then Close(w_appeon_gifofwait)

if Not gb_IsDocMode then
	w_mdi.WindowState = Maximized!
	w_mdi.Post Show()
end if

end event

event ue_saveas_ctx();//////////////////////////////////////////////////////////////////////
// $<event>w_contract::ue_saveas_ctx()
// $<arguments>(None)
// $<returns> 
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2009-08-24 by Ken.Guo
//////////////////////////////////////////////////////////////////////

long ll_ctx_id
If Not inv_contract_codes.of_allow_copyctx() Then 
	MessageBox("IntelliContract","You don't have rights to save the contract as a template!")
	Return
End If
ll_ctx_id = This.tab_contract_details.tabpage_details.inv_contract_details.of_get_ctx_id( )
If ll_ctx_id <> 0 and Not Isnull(ll_ctx_id) Then
	OpenWithParm(w_saveas_contract,ll_ctx_id)
End If

end event

event ue_use_template();n_cst_copy_ctx lnv_copy_ctx 

If Not inv_contract_codes.of_allow_newctx() Then 
	MessageBox("IntelliContract","You don't have rights to create a new contract!")
	Return
End If

lnv_copy_ctx = Create n_cst_copy_ctx
If lnv_copy_ctx.of_check_exist_contract() <= 0 Then 
	If isvalid(lnv_copy_ctx) Then destroy lnv_copy_ctx
	Return 
End IF

Open(w_use_template_create_ctx)

//Commented By Ken.Guo 05/03/2012
////Added By Ken.Guo 2011-04-18.
//If Message.doubleparm = 1 Then
//	This.of_check_validation( )
//End If

If isvalid(lnv_copy_ctx) Then destroy lnv_copy_ctx
end event

event pfc_cst_batch_email();//////////////////////////////////////////////////////////////////////
// $<event>w_contract::pfc_cst_batch_email()
// $<arguments>(None)
// $<returns> 
// $<description>
// $<description> Batch Email for multi-contract.
//////////////////////////////////////////////////////////////////////
// $<add> 2009-10-10 by Ken.Guo
//////////////////////////////////////////////////////////////////////
Long ll_cnt,ll_row
DataWindow ldw_search, ldw_browse
ldw_browse = tab_contract_details.tabpage_search.dw_search_det1
ll_row = ldw_browse.GetSelectedRow(0)
Do While ll_row > 0 
         ll_cnt++
         ll_row = ldw_browse.GetSelectedRow(ll_row)
         If ll_row > 1 Then Exit
Loop
If ll_row <= 1 Then
         Open(w_batch_email_tip)
Else
         This.event pfc_cst_email( )       
End If

//First Swith to other menu, then change to current menu in active event.
//Workaround unsupport property menu.currentitem. 
w_mdi.Changemenu(m_pfe_cst_mdi_menu) 
This.event activate( )

end event

event display_calendar();tab_contract_details.tabpage_search.of_set_style(2) //Added By Ken.Guo 2009-12-23.
if IsValid(w_SearchPage_Calendar) then
	//Close(w_SearchPage_Calendar) //Commented By Ken.Guo 2009-12-23
else
	Open(w_SearchPage_Calendar,This)
	If isvalid(w_SearchPage_Calendar) Then
		w_SearchPage_Calendar.Resizable = False	//Added By Ken.Guo 2009-12-23.
	End If
end if

end event

event display_default();this.tab_contract_details.tabpage_search.of_set_style(0)
end event

event display_treeview();this.tab_contract_details.tabpage_search.of_set_style(1)
end event

event ue_select();If tab_contract_details.selectedtab = 1 Then
	tab_contract_details.tabpage_search.cb_2.event clicked( )
End If
end event

event ue_refresh();If tab_contract_details.selectedtab = 1 Then
	tab_contract_details.tabpage_search.cb_1.event clicked( )
End If
end event

event ue_report();If tab_contract_details.selectedtab = 1 Then
	tab_contract_details.tabpage_search.cb_print.event clicked( )
End If
end event

event ue_auto_refresh();Boolean lb_auto

If tab_contract_details.selectedtab = 1 Then
		If isvalid(m_pfe_cst_mdi_menu_contract) Then
			If tab_contract_details.tabpage_search.ib_autoretrieve Then
				lb_auto = False
			Else
				lb_auto = True
			End If
			
			If tab_contract_details.tabpage_search.of_set_auto_refresh(lb_auto) > 0 Then
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_file.m_options.m_autorefresh,'toolbaritemdown', lb_auto)
			End If
		Else
			Return 
		End If
End If
end event

event ue_batch_add();str_batch_doc lstr_ctx_doc
str_ctx_email lstr_ctx_email
Long		ll_DOCID


IF wf_get_batch_ctx(lstr_ctx_doc) <= 0 Then Return
If UpperBound(lstr_ctx_doc.al_ctx_id[]) = 0 Then
	Messagebox('Add Doc','No contract can be add document.')
	Return
Else 
	If Isnull(lstr_ctx_doc.al_ctx_id[1]) Then
		Messagebox('Add Doc','Please save contract first.')
		Return
	End If
End If

str_add_doc lstr_add_doc
If UpperBound(lstr_ctx_doc.al_ctx_id[]) = 1 Then
	lstr_add_doc.ctx_id = lstr_ctx_doc.al_ctx_id[1]
Else
	lstr_add_doc.ctx_id = 0
End if
lstr_add_doc.doc_id = 0
lstr_add_doc.new = True
lstr_add_doc.ab_batch_new = True
lstr_add_doc.al_batch_ctx_id[] = lstr_ctx_doc.al_ctx_id[]
OpenWithParm(w_dm_buy_document, lstr_add_doc)



If IsValid( gw_contract ) Then//added by gavins 20130531
	ll_docid = gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.il_add_doc_id
	If ll_docid > 0 Then
		gw_contract.tab_contract_details.post Selecttab(9) //Document Manager
		Post wf_open_document( 	ll_docid )
		gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.il_add_doc_id = -1
	End If
End If
		
tab_contract_details.ib_select9 = False
tab_contract_details.ib_select10 = False

//Begin - Added By Mark Lee 12/17/2012
If isvalid(w_todolist_contract) Then 
	w_todolist_contract.of_refreshdata()
End If
If isvalid(w_tabpg_contract_doc_mgr) Then 
	w_tabpg_contract_doc_mgr.ibn_refresh = True
	w_tabpg_contract_doc_mgr.of_refreshdata()
End If
//End - Added By Mark Lee 12/17/2012

If This.tab_contract_details.selectedtab = 1 and ll_docid <= 0 Then
	If isvalid(Message.powerobjectparm) Then
		lstr_ctx_email = Message.PowerObjectParm
		If UpperBound(lstr_ctx_email.ctx_id_list[]) > 0 Then
			If Messagebox('Email','Would you like to email the added document to the Contracted Company Default To contact?', question!,yesno!) = 2 Then Return 
		End If
		lstr_ctx_email.doc_from = 'CTXS_ADD'
		OpenWithParm(w_dm_email_document_send, lstr_ctx_email)
	End If
End If

If Message.StringParm = 'design' Then //added by gavins 20130205
	SetPointer(HourGlass!)
	if IsValid(gw_Contract) then gw_Contract.of_SetCurrentScreenID(  51   )
	//---------Begin Added by (Appeon)Harry 03.14.2014 for V142 ISG-CLX--------
	//m_pfe_cst_mdi_menu.m_system.m_painters.m_contractdatascreenpainter.Post Event Clicked()
	m_pfe_cst_mdi_menu.m_system.m_painters.m_screensetup.m_contractdatascreenpainter.Post Event Clicked()  //(Appeon)Harry 06.28.2013 - V141 ISG-CLX
	//---------End Added -----------------------------------------------------
	SetPointer(Arrow!)
End If	


end event

event ue_batch_create();str_batch_doc lstr_ctx_doc
str_ctx_email lstr_ctx_email
Long		ll_docid

IF wf_get_batch_ctx(lstr_ctx_doc) <= 0 Then Return
If UpperBound(lstr_ctx_doc.al_ctx_id[]) = 0 Then
	Messagebox('Create Doc','No contract can be add document.')
	Return
Else 
	If Isnull(lstr_ctx_doc.al_ctx_id[1]) Then
		Messagebox('Create Doc','Please save contract first.')
		Return
	End If	
End If

str_add_doc lstr_add_doc
If UpperBound(lstr_ctx_doc.al_ctx_id[]) = 1 Then
	lstr_add_doc.ctx_id = lstr_ctx_doc.al_ctx_id[1]
Else
	lstr_add_doc.ctx_id = 0
End if
lstr_add_doc.doc_id = 0
lstr_add_doc.new = True
lstr_add_doc.ab_batch_new = True
lstr_add_doc.al_batch_ctx_id[] = lstr_ctx_doc.al_ctx_id[]
OpenWithParm(w_dm_sell_document, lstr_add_doc)


If IsValid( gw_contract ) Then//added by gavins 20130531
	ll_docid = gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.il_add_doc_id
	If ll_docid > 0 Then
		gw_contract.tab_contract_details.post Selecttab(9) //Document Manager
		Post wf_open_document( 	ll_docid )
		gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.il_add_doc_id = -1
	End If
End If		
		
tab_contract_details.ib_select9 = False
tab_contract_details.ib_select10 = False

//Begin - Added By Mark Lee 12/17/2012
If isvalid(w_todolist_contract) Then 
	w_todolist_contract.of_refreshdata()
End If
If isvalid(w_tabpg_contract_doc_mgr) Then 
	w_tabpg_contract_doc_mgr.ibn_refresh = True
	w_tabpg_contract_doc_mgr.of_refreshdata()
End If
//End - Added By Mark Lee 12/17/2012

If This.tab_contract_details.selectedtab = 1 and ll_docid <=0 Then
	If isvalid(Message.powerobjectparm) Then
		lstr_ctx_email = Message.PowerObjectParm
		If UpperBound(lstr_ctx_email.ctx_id_list[]) > 0 Then
			If Messagebox('Email','Would you like to email the created document to the Contracted Company Default To contact?', question!,yesno!) = 2 Then Return 
		End If
		lstr_ctx_email.doc_from = 'CTXS_CREATE'
		OpenWithParm(w_dm_email_document_send, lstr_ctx_email)
	End If
End If

If Message.StringParm = 'design' Then //added by gavins 20130205
	SetPointer(HourGlass!)
	if IsValid(gw_Contract) then gw_Contract.of_SetCurrentScreenID(  52   )
	//---------Begin Modified by (Appeon)Harry 03.14.2014 for V142 ISG-CLX--------
	//m_pfe_cst_mdi_menu.m_system.m_painters.m_contractdatascreenpainter.Post Event Clicked()
	m_pfe_cst_mdi_menu.m_system.m_painters.m_screensetup.m_contractdatascreenpainter.Post Event Clicked()  //(Appeon)Harry 06.28.2013 - V141 ISG-CLX
	//---------End Modfiied ------------------------------------------------------
	SetPointer(Arrow!)
End If	
end event

event ue_batch_queue();str_batch_doc lstr_ctx_doc

IF wf_get_batch_ctx(lstr_ctx_doc) <= 0 Then Return
If UpperBound(lstr_ctx_doc.al_ctx_id[]) = 0 Then
	Messagebox('Add Doc','No contract can be add document.')
	Return
Else 
	If Isnull(lstr_ctx_doc.al_ctx_id[1]) Then
		Messagebox('Add Doc','Please save contract first.')
		Return
	End If	
End If

lstr_ctx_doc.as_from = 'search_tab'
OpenWithParm(w_bidq_import_document_select, lstr_ctx_doc)
tab_contract_details.ib_select9 = False
tab_contract_details.ib_select10 = False

end event

event ue_powerfilter();//Added By Ken.Guo 10/30/2012. Support PowerFilter
Choose Case tab_contract_details.selectedtab
	Case 1 
		tab_contract_details.tabpage_search.event ue_powerfilter( )
End Choose
end event

event pfc_cst_contract_alarm_analyzer();//====================================================================
// Event: pfc_cst_contract_alarm_analyzer
//--------------------------------------------------------------------
// Description: Batch Set Date Alarms
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:         Ken.Guo           Date: 11/07/2012
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
 
u_dw_contract ldw_search
Long ll_category_id,ll_view_id,ll_ctx_id,ll_row
str_ctx_info lstr_ctx_info[]
String ls_readonly_ctx

//If tab_contract_details.selectedtab <> 1 Then 
//	Return 
//End If

//n_ds lds_view_tab 
//lds_view_tab = Create n_ds
//lds_view_tab.dataobject = 'd_ctx_view_tab'
//lds_view_tab.SetTransObject(SQLCA)
//lds_view_tab.Retrieve()

ldw_search = tab_contract_details.tabpage_search.dw_search_det1
ll_row = ldw_search.Getselectedrow(0)
If ll_row <= 0 Then 
	Messagebox('IntelliSoft','Please select contract(s) first.')  
	Return 
End If
		
Do While ll_row > 0
	//Get CTX Info
	ll_ctx_id = ldw_search.GetItemNumber(ll_row,'ctx_id')
	ll_category_id = ldw_search.GetItemNumber(ll_row,'category')
	ll_view_id = tab_contract_details.tabpage_search.of_get_ctx_view(ll_category_id,ll_ctx_id)
	
	//Check Same View
	If UpperBound(lstr_ctx_info[]) > 0 Then
		If ll_view_id <> lstr_ctx_info[1].al_view_id Then
			Messagebox('IntelliSoft',"Batch Set Alarms requires all contracts to be from the same view.~r~n" +  &
												"The system has detected that contract #"+String(lstr_ctx_info[1].al_ctx_id)+" and contract #"+String(ll_ctx_id)+" are from different views." )
			Return
		End If
	End If
	
	//Check Roles Right and set to structure array
	If ldw_search.GetItemString(ll_row,'access') <> 'F' Then
		If ls_readonly_ctx = '' Then
			ls_readonly_ctx = '#' + String(ll_ctx_id)
		Else
			ls_readonly_ctx += ', #' + String(ll_ctx_id)
		End If
	Else
		lstr_ctx_info[UpperBound(lstr_ctx_info[]) + 1].al_ctx_id = ll_ctx_id 
		lstr_ctx_info[UpperBound(lstr_ctx_info[]) ].al_view_id = ll_view_id		
	End If

	ll_row = ldw_search.Getselectedrow(ll_row)
Loop

If ls_readonly_ctx <> '' Then
	Messagebox('IntelliSoft', "You only have read-only permission to contract "+ls_readonly_ctx+" in your selection, they will be ignored. " )
End If

If UpperBound(lstr_ctx_info[]) = 0 Then
	Messagebox('IntelliSoft','No contract is suitable for Batch Set Alarms.')
End If

str_ctx_info_array lstr_ctx_info_array
lstr_ctx_info_array.astr_ctx_info[] =  lstr_ctx_info[]
OpenWithParm(w_ctx_alarm_batch,lstr_ctx_info_array)


Return 
end event

event ue_use_template_list(long al_id);//====================================================================
// Event: ue_use_template_list
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                al_id
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 11/16/2012
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
str_copy_ctx 		lstr_copy_ctx
long 					ll_new_ctx_id,ll_row,ll_template_id, ll_find, ll_rowcount, ll_rtn
integer 				li_tab_index
n_cst_copy_ctx 	lnv_copy_ctx
String 				ls_name

If al_id <= 0  Then 
	Return 
End If

//tab_contract_details.tabpage_search.of_create_templates_list( )
ll_rowcount = tab_contract_details.tabpage_search.ids_templates_list.rowcount( )
ll_find = tab_contract_details.tabpage_search.ids_templates_list.find( " id ="+string(al_id), 1,ll_rowcount)
If ll_find > 0 Then
	ls_name =  tab_contract_details.tabpage_search.ids_templates_list.getitemString(ll_find,'template_name') 
//	ll_rtn = Messagebox(gnv_app.iapp_object.DisplayName,"Do you want to create the <"+ls_name+"> Contract Template?",Question!,YesNo!)		//Added By Mark Lee 02/19/2013
	ll_rtn = Messagebox('Contract Template','Do you want to create a new contract record with the contract template ~''+ls_name+'~'?',Question!,YesNo!) 
	If ll_rtn <> 1 then 
		Return 
	End If
		
	lnv_copy_ctx = Create n_cst_copy_ctx

	//Get template info
	ll_template_id = al_id
	
	//Copy CTX from Template
	ll_new_ctx_id = lnv_copy_ctx.of_copy_ctx_from_template(ll_template_id )
	If ll_new_ctx_id < 0 Then
		Messagebox('Error','Failed to create contract from the template, please call support.')
		If isvalid(lnv_copy_ctx) Then Destroy lnv_copy_ctx
		Return 
	End If
	
	//Open new CTX
	li_tab_index = tab_contract_details.tabpage_search.ids_templates_list.getitemnumber(ll_find,'located_tab_index') 
	If isnull(li_tab_index) Then li_tab_index = 2
	lnv_copy_ctx.of_locate_ctx(ll_new_ctx_id,li_tab_index)
	
	If isvalid(lnv_copy_ctx) Then Destroy lnv_copy_ctx

End If


end event

event ue_copy_sub_contract();//====================================================================
// Event: ue_copy_sub_contract
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 11/16/2012
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
string 	ls_Copy_Contract
long 		ll_ctx_id
Integer li_ret1, li_ret2, li_ret3
long ll_ctx_id_source,			ll_row
n_cst_copy_ctx lnv_copy_ctx
String 	ls_master_contract_name
str_copy_sub_contract		lstr_copy_sub_contract

if of_IsExceedMaxCnts() then Return

If Not inv_contract_codes.of_allow_copyctx() Then 
	MessageBox("IntelliContract","You don't have rights to copy the contract!")
	Return
End If

lnv_copy_ctx = Create n_cst_copy_ctx
If lnv_copy_ctx.of_check_exist_contract() <= 0 Then 
	If isvalid(lnv_copy_ctx) Then Destroy lnv_copy_ctx
	Return 
End IF

ll_row = tab_contract_details.tabpage_search.dw_search_det1.getselectedrow(0)
ll_ctx_id_source = tab_contract_details.tabpage_search.il_ctx_id
lstr_copy_sub_contract.al_ctx_id = ll_ctx_id_source
lstr_copy_sub_contract.as_type = 'Copy_&_Create_Sub_Contract_Record'
ls_master_contract_name = tab_contract_details.tabpage_search.dw_search_det1.describe("Evaluate( 'lookupdisplay(app_facility) ', "+string(ll_row)+" )")
lstr_copy_sub_contract.as_master_contract_name = string(ll_ctx_id_source) +'-'+ls_master_contract_name

//Added By Mark Lee 11/16/2012
OpenWithParm(w_copy_sub_contract,lstr_copy_sub_contract)

ll_ctx_id = Message.DoubleParm

If ll_ctx_id > 0 Then
	
	lnv_copy_ctx.of_locate_ctx(ll_ctx_id) 
	
	this.of_check_validation( )

	ib_copy1 = True  
End If

If isvalid(lnv_copy_ctx) Then Destroy lnv_copy_ctx
end event

event ue_new_sub_contract();//====================================================================
// Event: ue_new_sub_contract
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 11/16/2012
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
long 		ll_Msg, ll_row, ll_ctx_id
Integer	li_rc
n_cst_copy_ctx lnv_copy_ctx
Powerobject lpo_updatearray[]
String 		ls_company

if of_IsExceedMaxCnts() then Return

If Not inv_contract_codes.of_allow_newctx() Then 
	MessageBox("IntelliContract","You don't have rights to create a new contract!")
	Return
End If


//Begin - Added By Mark Lee 05/13/2013
//ll_row = tab_contract_details.tabpage_search.dw_search_det1.GetSelectedRow(0)
//ll_ctx_id 	=	tab_contract_details.tabpage_search.dw_search_det1.GetItemNumber(ll_row,'ctx_id')
//ls_company = tab_contract_details.tabpage_search.dw_search_det1.describe("Evaluate( 'lookupdisplay(app_facility) ', "+string(ll_row)+" )")
ll_ctx_id =  tab_contract_details.tabpage_search.il_ctx_id

Select app_facility.facility_name
Into :ls_company
FROM ctx_basic_info ,app_facility
Where ctx_basic_info.app_facility = app_facility.facility_id 
and ctx_basic_info.ctx_id = :ll_ctx_id ; 
//End - Added By Mark Lee 05/13/2013

lnv_copy_ctx = Create n_cst_copy_ctx
If lnv_copy_ctx.of_check_exist_contract() <= 0 Then 
	If isvalid(lnv_copy_ctx) Then Destroy lnv_copy_ctx
	Return 
End IF

If UpperBound(ipo_updateobjects) > 0 Then
	lpo_updatearray = ipo_updateobjects
Else
	lpo_updatearray = This.Control		
End If

// Check for any pending updates
li_rc = of_UpdateChecks(lpo_updatearray)

//choose case li_rc
//	case -1 
//		of_MessageBox ("pfc_master_closequery_savechanges", gnv_app.iapp_object.DisplayName, "AcceptText error - Please contact Intelisoft Support", exclamation!, ok!, 1)
//		return 
//	case -2
//		of_MessageBox ("pfc_master_closequery_savechanges", gnv_app.iapp_object.DisplayName, "UpdatesPending error - Please contact Intelisoft Support", exclamation!, ok!, 1)
//		return
//	case -3
//		of_MessageBox ("pfc_master_closequery_savechanges", gnv_app.iapp_object.DisplayName, "Validation error - Please contact Intelisoft Support", exclamation!, ok!, 1)
//		return
//		
//end choose 

if li_rc > 0 then 
			ll_Msg = of_MessageBox ("pfc_master_closequery_savechanges", gnv_app.iapp_object.DisplayName, "Do you want to save changes?", exclamation!, YesNoCancel!, 1)
	Choose Case ll_Msg
		Case 1
			// YES - Update
			// If the update fails, prevent the window from closing
			If This.Event pfc_save() >= 1 Then
			else 
				return 
			End If
		Case 2
			// do nothing reset the datawindows			
		Case 3
			// CANCEL -  Prevent the window from closing
			If isvalid(lnv_copy_ctx) Then Destroy lnv_copy_ctx
			return 
	End Choose

end if

////////////////////////////////////////////////////////////////////////////////////
// trigger the new events on the tabpages
////////////////////////////////////////////////////////////////////////////////////

inv_contract_codes.of_set_protect_columns(false)
inv_contract_codes.of_set_tab_change( true)

tab_contract_details.tabpage_search.inv_contract_details.is_mode = tab_contract_details.tabpage_search.inv_contract_details.new
inv_contract_codes.of_set_ctx_id(0)
tab_contract_details.tabpage_details.uo_1.tab_1.tabpage_1.il_ctx_id = inv_contract_codes.of_get_ctx_id( )

If tab_contract_details.tabpage_details.visible = False Then
  	gi_contract_view_id = 1001
	wf_tab_visible(gi_contract_view_id)
End If

tab_contract_details.selecttab('tabpage_details' )
//tab_contract_details.tabpage_details.tab_1.selecttab( 1)
tab_contract_details.tabpage_details.uo_1.event ue_new( )

//Added By Mark Lee 11/16/2012
ll_row = tab_contract_details.tabpage_details.uo_1.dw_1.GetRow()
tab_contract_details.tabpage_details.uo_1.dw_1.setitem(ll_row,'master_contract_id',ll_ctx_id)			
tab_contract_details.tabpage_details.uo_1.dw_1.setitem(ll_row,'master_contract_name',string(ll_ctx_id)+'-'+ls_company) 

If isvalid(m_pfe_cst_mdi_menu_contract) Then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_newcontract.m_copyctx,'enabled', False)
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_contract0.m_copy_contract_record,'enabled', False)						//Added By Mark Lee 12/18/2012
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_contract0.m_copy_create_sub_contract_record,'enabled', False)		//Added By Mark Lee 12/18/2012
End If 
//Begin - Added By Mark Lee 12/18/2012
If isvalid(m_pfe_cst_mdi_menu_contract_am) Then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_contract0.m_copy_contract_record,'enabled', False)						
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_contract0.m_copy_create_sub_contract_record,'enabled', False)		
End If 
//End - Added By Mark Lee 12/18/2012
ib_copy = False  

wf_manage_tabs(false)
tab_contract_details.tabpage_details.enabled = True

This.Title = 'IntelliContract '  + '(' + 'New Mode' + ')'

If isvalid(lnv_copy_ctx) Then Destroy lnv_copy_ctx
end event

event ue_contract_templates_management();//====================================================================
// Event: ue_contract_templates_management
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 11/19/2012
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
n_cst_copy_ctx lnv_copy_ctx 

If Not inv_contract_codes.of_allow_newctx() Then 
	MessageBox("IntelliSoft","You don't have rights to create a new contract!")
	Return
End If

lnv_copy_ctx = Create n_cst_copy_ctx
If lnv_copy_ctx.of_check_exist_contract() <= 0 Then 
	If isvalid(lnv_copy_ctx) Then destroy lnv_copy_ctx
	Return 
End IF

Open(w_contract_templates_management)

If isvalid(lnv_copy_ctx) Then destroy lnv_copy_ctx
end event

event ue_select_all();//====================================================================
// Event: ue_select_all
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 12/05/2012
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
If tab_contract_details.selectedtab = 1 Then
	tab_contract_details.tabpage_search.event ue_select_all( )
End If
end event

event pfc_cst_newmail();//Added By Mark Lee 02/17/2013
If this.tab_contract_details.selectedtab = 12 and isvalid(w_contract_email_folder) then	//Email Manager
	w_contract_email_folder.event	pfc_cst_newmail()
End If 
end event

event type integer pfc_cst_reply();//Added By Mark Lee 02/17/2013
If this.tab_contract_details.selectedtab = 12 and isvalid(w_contract_email_folder) then	//Email Manager
	w_contract_email_folder.event	pfc_cst_reply()
End If 

Return 1
end event

event type integer pfc_cst_reply_all();//Added By Mark Lee 02/17/2013
If this.tab_contract_details.selectedtab = 12 and isvalid(w_contract_email_folder) then	//Email Manager
	w_contract_email_folder.event	pfc_cst_reply_all()
End If 

Return 1
end event

event type integer pfc_cst_forward();//Added By Mark Lee 02/17/2013
If this.tab_contract_details.selectedtab = 12 and isvalid(w_contract_email_folder) then	//Email Manager
	w_contract_email_folder.event	pfc_cst_forward()
End If 

Return 1
end event

event pfc_cst_checkin();//Added By Mark Lee 02/17/2013
If this.tab_contract_details.selectedtab = 12 and isvalid(w_contract_email_folder) then	//Email Manager
	w_contract_email_folder.event	pfc_cst_checkin()
End If 
end event

event type integer pfc_cst_options();//Added By Mark Lee 02/17/2013
If this.tab_contract_details.selectedtab = 12 and isvalid(w_contract_email_folder) then	//Email Manager
	w_contract_email_folder.event	pfc_cst_options()
End If 

Return 1
end event

event pfc_cst_email_log();//Added By Mark Lee 02/17/2013
If this.tab_contract_details.selectedtab = 12 and isvalid(w_contract_email_folder) then	//Email Manager
	w_contract_email_folder.event	pfc_cst_email_log()
End If 
end event

event pfc_cst_importmsg();//Added By Mark Lee 02/17/2013
If this.tab_contract_details.selectedtab = 12 and isvalid(w_contract_email_folder) then	//Email Manager
	w_contract_email_folder.event	pfc_cst_importmsg()
End If 
end event

event type integer pfc_cst_find();//Added By Mark Lee 02/17/2013
If this.tab_contract_details.selectedtab = 12 and isvalid(w_contract_email_folder) then	//Email Manager
	w_contract_email_folder.event	pfc_cst_find()
End If 

Return 1
end event

event pfc_cst_refresh();//Added By Mark Lee 02/17/2013
If this.tab_contract_details.selectedtab = 12 and isvalid(w_contract_email_folder) then	//Email Manager
	w_contract_email_folder.event	pfc_cst_refresh()
End If 
end event

event pfc_filterdlg();If this.tab_contract_details.selectedtab = 9  then	// filter
	If tab_contract_details.tabpage_images.tab_1.selectedtab = 1 Then
		tab_contract_details.tabpage_images.tab_1.tabpage_data.tab_1.tabpage_browse.dw_browse.event pfc_filterdlg()
	Else
		If tab_contract_details.tabpage_images.tab_1.tabpage_action.tab_1.selectedtab = 1 Then
			tab_contract_details.tabpage_images.tab_1.tabpage_action.tab_1.tabpage_browse.dw_browse.event pfc_filterdlg()
		Else
			tab_contract_details.tabpage_images.tab_1.tabpage_action.tab_1.tabpage_detail.dw_detail.event pfc_filterdlg()
		End If
	End If
End If 
//

If this.tab_contract_details.selectedtab = 10  then
	If  tab_contract_details.tabpage_action_items.tab_1.selectedtab = 1 Then
		tab_contract_details.tabpage_action_items.tab_1.tabpage_browse.dw_1.event pfc_filterdlg()
	Else
		tab_contract_details.tabpage_action_items.tab_1.tabpage_detail.dw_1.event pfc_filterdlg( )
	End If
End If
end event

public function integer wf_change_opject (u_tabpg as_powerobject);

return 1
end function

public function integer of_select_tabpage (string as_tab_name);

this.tab_contract_details.selecttab(as_tab_name)

return success
end function

public function integer of_save_contract ();return success
end function

public function integer wf_reset_retrieved ();/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner xx September 2005  ?Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


this.tab_contract_details.of_reset_retrived_status( )


return success
end function

public function long wf_set_save_status (boolean lb_saved);

//wf_set_save_status

ib_just_saved =  lb_saved

return 1


end function

public function boolean wf_get_save_status ();

return ib_just_saved
end function

public subroutine of_select_details_tab ();
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 08.24.2006 By: Liang QingShi
//$<reason> Contract module modification
//$<reason> Fix a defect.
/*
tab_contract_details.selecttab('tabpage_details' )
*/
if this.tab_contract_details.tabpage_details.visible = true then
	tab_contract_details.selecttab('tabpage_details' )
	tab_contract_details.tabpage_details.uo_1.dw_1.Post SetColumn("category")
	tab_contract_details.tabpage_details.uo_1.dw_1.Post SetFocus()
	
	If isvalid(m_pfe_cst_mdi_menu_contract) Then
	   gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_file.m_save,'enabled', False)
	End If
//Add by Jack 05/24/2007
elseif this.tab_contract_details.tabpage_requirements.visible = true then
	tab_contract_details.selecttab('tabpage_requirements' )
elseif this.tab_contract_details.tabpage_contacts.visible = true then
	tab_contract_details.selecttab('tabpage_contacts' )
elseif this.tab_contract_details.tabpage_locations.visible = true then
	tab_contract_details.selecttab('tabpage_locations' )
elseif this.tab_contract_details.tabpage_orgabizations.visible = true then
	tab_contract_details.selecttab('tabpage_orgabizations' )
elseif this.tab_contract_details.tabpage_fee_schedules.visible = true then
	tab_contract_details.selecttab('tabpage_fee_schedules' )
elseif this.tab_contract_details.tabpage_fee_sched2.visible = true then
	tab_contract_details.selecttab('tabpage_fee_sched2' )
elseif this.tab_contract_details.tabpage_images.visible = true then
	tab_contract_details.selecttab('tabpage_images' )
elseif this.tab_contract_details.tabpage_action_items.visible = true then
	tab_contract_details.selecttab('tabpage_action_items' )
/*elseif this.tab_contract_details.tabpage_qrg.visible = true then
	tab_contract_details.selecttab('tabpage_qrg' )
*/
elseif this.tab_contract_details.tabpage_multi.visible = true then  //add custom multi-jervis 05.31.2011
	tab_contract_details.selecttab('tabpage_multi' )
elseif this.tab_contract_details.tabpage_email.visible = true then  	//Added By Mark Lee 02/05/2013
	tab_contract_details.selecttab('tabpage_email' )	
end if
//---------------------------- APPEON END ----------------------------

end subroutine

public function integer of_select_contact_tab ();

tab_contract_details.selecttab('tabpage_contacts' )
return 1
end function

public function integer of_set_security ();//Function created maha app100405  for tab security
//Called from open event of window

integer i


i = w_mdi.of_security_access( 2090 ) //detail
IF i = 0 THEN
	this.tab_contract_details.tabpage_details.visible = false
elseif i = 1 then
	//disable stuff
	//this.tab_contract_details.tabpage_details.
	//this.tab_contract_details.tabpage_requirements.dw_2.enabled = false
end if

i = w_mdi.of_security_access( 2100 ) //requirements
IF i = 0 THEN
	this.tab_contract_details.tabpage_requirements.visible = false
//----Begin commented by Alfee 09.30.2007-----------------------------------
//<$Reason>Replaced with of_disable_columns()
/*elseif i = 1 then
	//disable stuff
	this.tab_contract_details.tabpage_requirements.dw_req_det.enabled = false
	this.tab_contract_details.tabpage_requirements.dw_2.enabled = false*/
//----End Commented --------------------------------------------------------
end if

i = w_mdi.of_security_access( 2110 ) //Contacts
IF i = 0 THEN
	this.tab_contract_details.tabpage_contacts.visible = false
//----Begin commented by Alfee 09.30.2007-----------------------------------
//<$Reason>Replaced with of_disable_columns()
/*elseif i = 1 then
	//disable stuff
	this.tab_contract_details.tabpage_contacts.dw_detail.enabled = false
	this.tab_contract_details.tabpage_contacts.dw_notes.enabled = false
	this.tab_contract_details.tabpage_contacts.dw_phone.enabled = false*/
//----End Commented --------------------------------------------------------	
end if

i = w_mdi.of_security_access( 2120 ) //Locations
IF i = 0 THEN
	this.tab_contract_details.tabpage_locations.visible = false
elseif i = 1 then
	//disable stuff
	
end if

i = w_mdi.of_security_access( 2130 ) //Organizations
IF i = 0 THEN
	this.tab_contract_details.tabpage_orgabizations.visible = false
elseif i = 1 then
	//disable stuff
	
end if

i = w_mdi.of_security_access( 2140 ) //Fee Scheduals
IF i = 0 THEN
	this.tab_contract_details.tabpage_fee_schedules.visible = false
elseif i = 1 then
	//disable stuff
	
end if

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 01.12.2007 By: Jack (Document Manager)
//$<reason> 
/*
i = w_mdi.of_security_access( 2150 ) //Documents
IF i = 0 THEN
	this.tab_contract_details.tabpage_images.visible = false
elseif i = 1 then
	//disable stuff
	
end if
*/
IF long(gnv_data.of_getitem( "icred_settings", "set_51", FALSE)) = 0 THEN
	this.tab_contract_details.tabpage_images.visible = false
ELSE
	i = w_mdi.of_security_access( 2150 ) //Documents
	IF i = 0 THEN
		this.tab_contract_details.tabpage_images.visible = false
	elseif i = 1 then
		//disable stuff
		
	end if
END IF

//---------------------------- APPEON END ----------------------------

i = w_mdi.of_security_access( 2160 ) //Action Items
IF i = 0 THEN
	this.tab_contract_details.tabpage_action_items.visible = false
elseif i = 1 then
	//disable stuff
	
end if

//comment by jervis 05.31.2011
//i = w_mdi.of_security_access( 2170 ) //Analysis
//IF i = 0 THEN
//	this.tab_contract_details.tabpage_analysis.visible = false
//elseif i = 1 then
	//disable stuff
	
//end if

//i = w_mdi.of_security_access( 2180 ) //QRG tab
//IF i = 0 THEN
//	this.tab_contract_details.tabpage_qrg.visible = false
//elseif i = 1 then
//	//disable stuff
//	
//end if
i = w_mdi.of_security_access( 2170 ) //Change Analysis to custom multi - jervis 05.31.2011
IF i = 0 THEN
	this.tab_contract_details.tabpage_multi.visible = false
elseif i = 1 then
	//disable stuff
	
end if

//Start Code Change ---- 05.15.2006 #453 maha	
i = w_mdi.of_security_access( 2220 ) //Fee Scheduals
IF i = 0 THEN
	this.tab_contract_details.tabpage_fee_sched2.visible = false
elseif i = 1 then
	//disable stuff
	
end if
//End Code Change---05.15.2006

//Added By Mark Lee 02/06/2013
i = w_mdi.of_security_access( 6984 ) // Email Manager
IF i = 0 THEN
	this.tab_contract_details.tabpage_email.visible = false
elseif i = 1 then
	//disable stuff
end if

return 1
end function

public function integer wf_audit (u_dw adw);

inv_audit.of_set_prac_id( inv_contract_codes.of_get_ctx_id( ) )
inv_audit.of_audit_fields(adw)



return 0
end function

public function integer wf_manage_tabs (boolean al_bool);//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.11.2006 By: LeiWei
//$<reason> Performance tuning
IF ib_manage_tabs_enabled = al_bool THEN RETURN 0
//---------------------------- APPEON END ----------------------------

setredraw(false)
this.tab_contract_details.tabpage_contacts.enabled = al_bool
this.tab_contract_details.tabpage_fee_schedules.enabled = al_bool
this.tab_contract_details.tabpage_images.enabled = al_bool
this.tab_contract_details.tabpage_locations.enabled = al_bool
this.tab_contract_details.tabpage_orgabizations.enabled = al_bool
//this.tab_contract_details.tabpage_qrg.enabled = al_bool
this.tab_contract_details.tabpage_email.enabled = al_bool 	//Added By Mark Lee 02/16/2013
this.tab_contract_details.tabpage_multi.enabled = al_bool //jervis 05.31.2011
this.tab_contract_details.tabpage_requirements.enabled = al_bool
this.tab_contract_details.tabpage_action_items .enabled = al_bool
this.tab_contract_details.tabpage_fee_sched2.Enabled = al_bool //rodger wu add.
setredraw(true)	//Commented byJervis 08.24.2010  //Uncommented by Ken 09/08/2010

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.11.2006 By: LeiWei
//$<reason> Performance tuning
ib_manage_tabs_enabled = al_bool
//---------------------------- APPEON END ----------------------------

return 0
end function

public function integer of_updatecheck (powerobject apo_control[], ref powerobject apo_control_update[]);//////////////////////////////////////////////////////////////////////
// $<function>w_prac_data_1of_updatecheck()
// $<arguments>
//		value    	PowerObject	apo_control         		
//		reference	PowerObject	apo_control_update[]		
// $<returns> integer
// $<description> Performance tunging
//////////////////////////////////////////////////////////////////////
// $<add> 02.23.2006 by LeiWei
//////////////////////////////////////////////////////////////////////

Integer		li_max, li_i, li_max_updatecontrol, li_rc
Powerobject	lpo_tocheck
UserObject	luo_control
tab			ltab_control
Window		lw_control
Datawindow 	ldw_nonpfc
pfc_u_dw		ldw_u_dw
String ls_UpdateTable

// Loop thru all the objects
li_max = UpperBound (apo_control)
For li_i = 1 To li_max
	lpo_tocheck = apo_control[li_i]
	If IsNull(lpo_tocheck) Or Not IsValid(lpo_tocheck) Then Continue
	
	Choose Case TypeOf ( lpo_tocheck )
	
		Case Window!
			// Test for Window Controls
			lw_control = lpo_tocheck
			This.of_updatecheck ( lw_control.Control, apo_control_update[] )
			
		Case tab!
			// Test for tab controls 
			ltab_control = lpo_tocheck
			This.of_updatecheck ( ltab_control.Control, apo_control_update[] )
			
		Case UserObject!
			// Test for UserObjects 
			luo_control = lpo_tocheck
			This.of_updatecheck ( luo_control.Control, apo_control_update[] )

		Case DataWindow!
			ldw_nonpfc = lpo_tocheck
			
			// Perform AcceptText, check rc
			li_rc = ldw_nonpfc.AcceptText()
			If li_rc < 0 Then 
				ldw_nonpfc.SetFocus()
				Return FAILURE
			end if

			IF ldw_nonpfc.ModifiedCount() + ldw_nonpfc.DeletedCount() = 0 Then
				Continue
			End If

			ls_UpdateTable = Trim(ldw_nonpfc.Describe("Datawindow.Table.UpdateTable"))
			IF Isnull(ls_UpdateTable) Or ls_UpdateTable="" Or ls_UpdateTable="?" Or ls_UpdateTable="!" Then
				Continue
			End If

			If ldw_nonpfc.TriggerEvent ("pfc_descendant") = 1 Then
				ldw_u_dw = ldw_nonpfc
				If Not ldw_u_dw.of_isupdateable() Then
					Continue
				End If
			End If
			
			li_max_updatecontrol = UpperBound(apo_control_update)
			apo_control_update[li_max_updatecontrol + 1] = lpo_tocheck
	End Choose
Next

Return UpperBound (apo_control_update)

end function

public subroutine wf_tab_visible (integer arg_view_id);//////////////////////////////////////////////////////////////////////
// $<function>w_contractProperties -  tab_contract_details  inherited  from  u_tab_contract_details()
// $<arguments>
//		value	integer	arg_view_id		
// $<returns> (none)
// $<description>Contract module modification
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 07.28.2006 by Liang QingShi
//////////////////////////////////////////////////////////////////////
tab_contract_details.of_tab_visible(arg_view_id)
of_set_security()
end subroutine

public subroutine wf_set_select (string arg_tab, boolean arg_select);//////////////////////////////////////////////////////////////////////
// $<function>w_contractwf_set_select()
// $<arguments>
//		value	boolean	arg_select		
// $<returns> (none)
// $<description>Contract module modification
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 07.28.2006 by Liang QingShi
//////////////////////////////////////////////////////////////////////
tab_contract_details.of_set_select(arg_tab,arg_select)

end subroutine

public subroutine of_select_details_tab_retrieved (boolean arg_retrieved);//////////////////////////////////////////////////////////////////////
// $<function>w_contractof_select_details_tab_retrieved()
// $<arguments>
//		value	boolean	arg_retrieved		
// $<returns> (none)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 09.18.2006 by Liang QingShi
//////////////////////////////////////////////////////////////////////
tab_contract_details.of_reset_det_retrived_status()

end subroutine

public subroutine of_add_merge_field (string is_merge_field);
If len(is_merge_field) > 0 Then
	tab_contract_details.tabpage_images.tab_1.tabpage_data.inv_ole_utils_doc.of_insertfield(is_merge_field)
End If
end subroutine

public subroutine of_set_validation (boolean ab_validation);ib_validation_1 = ab_validation

end subroutine

public function long of_get_view_id ();Return il_data_view_id
end function

public function integer of_set_view_id (long al_data_view_id);il_data_view_id = al_data_view_id

Return 1
end function

public function integer of_set_tabpage_property (long al_row, ref userobject au_tabpage, string as_icon, string as_def_text, string as_def_icon);

// Set tab page property
if al_Row > 0 then
	// Set tab page property according to settings

	If au_tabpage.Text <> 	wf_AddTextBlank( ids_tabpage_prop.object.text[al_Row]  ) Then
		au_tabpage.Text = 	wf_AddTextBlank( ids_tabpage_prop.object.text[al_Row]  )
	End If
	
	If au_tabpage.TabTextColor <> ids_tabpage_prop.object.text_color[al_Row] Then
		au_tabpage.TabTextColor = ids_tabpage_prop.object.text_color[al_Row]
	End If 
	
	if IsNull(ids_tabpage_prop.object.tab_backcolor[al_Row]) then
		If au_tabpage.TabBackColor <> 67108864 Then
			au_tabpage.TabBackColor = 67108864
		End If
	else
		IF au_tabpage.TabBackColor <> ids_tabpage_prop.object.tab_backcolor[al_Row] Then
			au_tabpage.TabBackColor = ids_tabpage_prop.object.tab_backcolor[al_Row]
		End If
	end if
	if IsNull(ids_tabpage_prop.object.backcolor[al_Row]) then
		If au_tabpage.BackColor <> 67108864 Then
			au_tabpage.BackColor = 67108864
		End If
	else
		If au_tabpage.BackColor <> ids_tabpage_prop.object.backcolor[al_Row] Then
			au_tabpage.BackColor = ids_tabpage_prop.object.backcolor[al_Row]
		End If
	end if
	
	if ids_tabpage_prop.object.tab_visible[al_row] = 'F' then 
		If au_tabpage.visible Then
			au_tabpage.visible = false //jervis 09.15.2011
		End If
	End If
	
else
	// Set default property
	If au_tabpage.Text <> 	wf_AddTextBlank( as_def_text  ) Then
		au_tabpage.Text = wf_AddTextBlank( as_def_text  )
	End If
	If au_tabpage.TabTextColor <> 33554432 Then
		au_tabpage.TabTextColor = 33554432
	End If
	If au_tabpage.TabBackColor <> 67108864 Then
		au_tabpage.TabBackColor = 67108864
	End If
	If au_tabpage.BackColor <> 67108864 Then
		au_tabpage.BackColor = 67108864
	End If

end if




Return 1
end function

public function long of_get_tabpage_prop_row (long al_data_view_id, string as_tabpage_name);long ll_FindRow
string ls_Condition

//Added By Mark Lee 06/13/12	APB BUG
ll_FindRow = 0 

// Get tab page property row number
ls_Condition = "data_view_id=" + String(al_data_view_id) + " AND tabpage_name='" + as_tabpage_name + "'"

IF IsValid(ids_tabpage_prop) THEN ll_FindRow = ids_tabpage_prop.Find(ls_Condition, 1, ids_tabpage_prop.RowCount()) //Alfee 09.17.2008
//ll_FindRow = ids_tabpage_prop.Find(ls_Condition, 1, ids_tabpage_prop.RowCount())

Return ll_FindRow
end function

public function long of_get_screen_prop_row (long al_data_view_id, long al_screen_id);long ll_FindRow
string ls_Condition

// Get screen property row number
ls_Condition = "data_view_id=" + String(al_data_view_id) + " AND screen_id=" + String(al_screen_id)
ll_FindRow = ids_screen_prop.Find(ls_Condition, 1, ids_screen_prop.RowCount())

Return ll_FindRow
end function

public subroutine of_dashboard (long ai_ctx_id);long ll_find
//Added By Alan on 2009-1-21
if this.tab_contract_details.tabpage_search.ib_retriev_detail then this.tab_contract_details.tabpage_search.CB_1.event clicked()	

ll_find=tab_contract_details.tabpage_search.dw_search_det1.find("ctx_id="+string(ai_ctx_id), 1, tab_contract_details.tabpage_search.dw_search_det1.rowcount())
if ll_find>0 then
tab_contract_details.tabpage_search.dw_search_det1.selectrow( 0, false)
tab_contract_details.tabpage_search.dw_search_det1.scrolltorow(ll_find)
tab_contract_details.tabpage_search.dw_search_det1.selectrow( ll_find, true)
tab_contract_details.tabpage_search.inv_contract_details.of_set_ctx_id(ll_find)
tab_contract_details.tabpage_search.dw_search_det1.event rowfocuschanged( ll_find)
this.function dynamic of_select_details_tab()

if gb_restore_contract_state and ProfileString(gs_IniWindowState,"w_contract","Maximized",'1') <> '1' then	//add by jervis 09.10.2009
	If This.WindowState = Minimized! Then This.windowstate = Normal!
else
	If This.WindowState = Minimized! Then This.windowstate = maximized!
end if
end if
end subroutine

public function integer of_show ();//////////////////////////////////////////////////////////////////////
// $<function>  of_show()
// $<arguments> (None)
// $<returns>   integer
// $<description> Show window
//////////////////////////////////////////////////////////////////////
// $<add> 10/29/2008 by Evan
//////////////////////////////////////////////////////////////////////

long ll_Handle
constant long SW_SHOW       = 5
constant long WM_SYSCOMMAND = 274
constant long SC_RESTORE    = 61728
constant long SC_MAXIMIZE   = 61488

ll_Handle = Handle(this)
if gb_restore_contract_state and ProfileString(gs_IniWindowState,"w_contract","Maximized",'1') <> '1' then	//Add by jervis 09.10.2009
	If AppeonGetClientType() = 'WEB' Then This.windowstate = Normal! //Added By Ken.Guo 2009-11-23.
	SendMessage(ll_Handle, WM_SYSCOMMAND, SC_RESTORE, 0)
else
	If AppeonGetClientType() = 'WEB' Then This.windowstate = Maximized! //Added By Ken.Guo 2009-11-23.
	SendMessage(ll_Handle, WM_SYSCOMMAND, SC_MAXIMIZE, 0)
end if
ShowWindow(ll_Handle, SW_SHOW)


//this.Move(1, 1)	jervis 09.23.2009
this.SetPosition(ToTop!)
this.SetFocus()

Return 1

end function

public function integer of_hide ();//////////////////////////////////////////////////////////////////////
// $<function>  of_hide()
// $<arguments> (None)
// $<returns>   integer
// $<description> Hide window
//////////////////////////////////////////////////////////////////////
// $<add> 10/29/2008 by Evan
//////////////////////////////////////////////////////////////////////

long ll_Handle
constant long SW_HIDE       = 0
constant long WM_SYSCOMMAND = 274
constant long SC_MINIMIZE   = 61472

ll_Handle = Handle(this)
If AppeonGetClientType() = 'WEB' Then This.windowstate = Minimized! //Added By Ken.Guo 2009-11-23.
SendMessage(ll_Handle, WM_SYSCOMMAND, SC_MINIMIZE, 0)
ShowWindow(ll_Handle, SW_HIDE)



Return 1
end function

public subroutine of_loadtabpage ();//////////////////////////////////////////////////////////////////////
// $<Function>  of_loadtabpage()
// $<arguments> (None)
// $<returns>   (None)
// $<description> Load Contract Folder
//////////////////////////////////////////////////////////////////////
// $<add> 11/04/2008 by Scofield
//////////////////////////////////////////////////////////////////////

this.TriggerEvent("ue_show_open")
this.TriggerEvent("ue_show_postopen")
this.TriggerEvent("ue_show_loadtabpage")

end subroutine

public function integer of_resetstatus (windowobject awo_control);//////////////////////////////////////////////////////////////////////
// $<function>  of_resetstatus
// $<arguments> 
// 		windowobject	awo_control
// $<returns>   integer
// $<description>
// 1.Reset datawindow data
// 2.Reset instance variables
//////////////////////////////////////////////////////////////////////
// $<add> 10/29/2008 by Evan
//////////////////////////////////////////////////////////////////////

Tab        lwo_tab
UserObject lwo_userobject
DataWindow lwo_datawindow
integer    i, li_Count

if not IsValid(awo_control) then Return -1

choose case awo_control.TypeOf()
	case DataWindow!
		lwo_datawindow = awo_control
		if lwo_datawindow.ClassName() <> "dw_search_det1" then
			lwo_datawindow.Reset()
		end if
		if lwo_datawindow.DataObject = "d_contract_action_items_filter" then
			lwo_datawindow.InsertRow(0)
		end if
	case Tab!
		lwo_tab = awo_control
		li_Count = UpperBound(lwo_tab.control[])
		for i = 1 to li_Count
			of_ResetStatus(lwo_tab.control[i])
		next
	case UserObject!
		lwo_userobject = awo_control
		lwo_userobject.TriggerEvent("ue_initinstancevar")
		li_Count = UpperBound(lwo_userobject.control[])
		for i = 1 to li_Count
			of_ResetStatus(lwo_userobject.control[i])			
		next
	case else
		Return -1
end choose

Return 1
end function

public function integer of_backupfocusobject (windowobject awo_control[]);//====================================================================
// Event: w_contract.of_backupfocusobject()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	windowobject	awo_control[]	
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-01-13
//--------------------------------------------------------------------
//	Copyright (c) 2002-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Long 		ll_i
Long 		ll_count,ll_CurRow
Integer 	li_index

WindowObject 	lwo_tocheck
u_dw_contract 	ldw_tocheck
tab				ltab_control
UserObject		luo_control
DataWindow		ldw_Control

ll_count = UpperBound(awo_control)

If ll_count = 0 Then Return NO_ACTION

For ll_i = 1 To ll_count
	lwo_tocheck = awo_control[ll_i]
	If IsNull(lwo_tocheck) Or Not IsValid(lwo_tocheck) Then Continue
	Choose Case TypeOf(lwo_tocheck)
		Case tab!
			ltab_control = lwo_tocheck
			li_index = ltab_control.SelectedTab
			If li_index > 0 Then
				gf_SetBakSelect(ltab_control,li_index)
				if li_index <> 1 then
					of_BackupFocusObject(ltab_control.Control[1].Control)
				end if
				of_BackupFocusObject(ltab_control.Control[li_index].Control)
			Else
				Continue
			End If
		Case UserObject!
			luo_control = awo_control[ll_i]
			If IsValid(luo_control) Then
				of_BackupFocusObject(luo_control.Control)
			Else
				Continue
			End If
		Case DataWindow!
			ldw_Control = awo_control[ll_i]
			if ldw_Control.ClassName() <> "dw_browse" then Continue
			ll_CurRow = ldw_Control.GetRow()
			if ll_CurRow > 0 then
				gf_SetBakSelect(ldw_Control,ll_CurRow)
			end if
	End Choose
Next

Return SUCCESS

end function

public function integer of_restorefocusobject (windowobject awo_control[]);//====================================================================
// Event: w_contract.of_restorefocusobject()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value	windowobject	awo_control[]	
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-01-13
//--------------------------------------------------------------------
//	Copyright (c) 2002-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long 		ll_i
long 		ll_count,ll_CurRow
integer 	li_index

WindowObject 	lwo_tocheck
u_dw_contract 	ldw_tocheck
tab				ltab_control
UserObject		luo_control
DataWindow		ldw_Control

ll_count = UpperBound(awo_control)

If ll_count = 0 Then Return NO_ACTION

for ll_i = 1 to ll_count
	lwo_tocheck = awo_control[ll_i]
	If IsNull(lwo_tocheck) or Not IsValid(lwo_tocheck) Then Continue
	Choose case TypeOf(lwo_tocheck)
		case tab!
			ltab_control = lwo_tocheck
			li_index = gf_GetBakSelect(ltab_control.tag)
			if li_index > 0 then
				ltab_control.SelectTab(1)
				of_RestoreFocusObject(ltab_control.control[1].control)
				if li_index <> 1 then
					ltab_control.SelectTab(li_index)
					of_RestoreFocusObject(ltab_control.control[li_index].control)
				end if
				gf_SetBakSelect(ltab_control,0)
			else
				continue
			end if
		case userobject!
			luo_control = awo_control[ll_i]
			of_RestoreFocusObject(luo_control.control[])
		Case DataWindow!
			ldw_Control = awo_control[ll_i]
			if ldw_Control.ClassName() <> "dw_browse" then Continue
			ll_CurRow = gf_GetBakSelect(ldw_Control.tag)
			if ll_CurRow > 0 and ll_CurRow <= ldw_Control.RowCount() then
				ldw_Control.ScrollToRow(ll_CurRow)
				ldw_Control.SetRow(ll_CurRow)
				gf_SetBakSelect(ldw_Control,0)
			end if
	end choose
next

Return 1

end function

public function long of_getcurrentscreenid ();//====================================================================
// Function: of_GetCurrentScreenID()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-04-20
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Return il_CurScreenID

end function

public subroutine of_setcurrentscreenid (long al_curscreenid);//====================================================================
// Function: of_SetCurrentScreenID()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    long    al_CurScreenID
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-04-20
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

il_CurScreenID = al_CurScreenID

end subroutine

public function boolean of_isexceedmaxcnts ();//====================================================================
// Function: of_IsExceedMaxCnts()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  boolean
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-05-12
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Contractlogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long	ll_CurCnts,ll_MaxCnts

SELECT Count(*) INTO :ll_CurCnts FROM ctx_basic_info;
SELECT MaxContractCnt INTO :ll_MaxCnts FROM icred_settings;

if IsNull(ll_CurCnts) then ll_CurCnts = 0
if IsNull(ll_MaxCnts) then ll_MaxCnts = 0

if ll_MaxCnts > 0 and ll_CurCnts >= ll_MaxCnts then
	//---------Begin Modified by (Appeon)Harry 03.14.2014 for V142 ISG-CLX--------
	//MessageBox(gnv_app.iapp_object.DisplayName,"Your record limit for number of contracts has been reached.  ~r~n~r~nCall Contract Logix sales at 866-371-4445 to purchase an upgrade.")
	MessageBox(gnv_app.iapp_object.DisplayName,"Your record limit for number of contracts has been reached.  ~r~n~r~nCall IntelliSoft sales to purchase an upgrade.")
	//---------End Modfiied ------------------------------------------------------
	Return true
end if

Return false

end function

public subroutine of_savewindowstate ();//Add by jervis 09.10.2009
//Save Windows State
if this.windowstate <> Minimized! then //and this.Visible then -- jervis 04.25.2011
	SetProfileString(gs_IniWindowState,this.ClassName(),'X',string(this.x))
	SetProfileString(gs_IniWindowState,this.ClassName(),'Y',string(this.Y))
	SetProfileString(gs_IniWindowState,this.ClassName(),'WIDTH',string(this.width))
	SetProfileString(gs_IniWindowState,this.ClassName(),'HEIGHT',string(this.height))
	if this.windowstate = Maximized! then
		SetProfileString(gs_IniWindowState,this.ClassName(),'Maximized','1')
	else
		SetProfileString(gs_IniWindowState,this.ClassName(),'Maximized','0')
	end if
end if
end subroutine

public subroutine of_restorewindowstate ();//Add by jervis 09.10.2009
//Restore Windows State
long ll_x,ll_y,ll_width,ll_height

ll_x = Long(ProfileString(gs_IniWindowState,this.ClassName(),'X','-1'))
ll_y = Long(ProfileString(gs_IniWindowState,this.ClassName(),'Y','-1'))
ll_width = Long(ProfileString(gs_IniWindowState,this.ClassName(),'WIDTH','-1'))
ll_height = Long(ProfileString(gs_IniWindowState,this.ClassName(),'HEIGHT','-1'))

if ll_x > 0 then this.x = ll_x
if ll_y > 0 then this.y = ll_y
if ll_width > 0 and ll_height > 0 then
	this.resize( ll_width,ll_height)
elseif ll_width > 0 then
	this.width = ll_width
elseif ll_height > 0 then
	this.height = ll_height
end if

this.ib_movetozero = false	//jervis 09.23.2009 - Prevent move(0,0)

end subroutine

public subroutine of_setbkcolor (long al_bkcolor);//====================================================================
// Function: of_SetBkColor()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    long    al_BkColor
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-10-28
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Contract Logix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Tab_Contract_Details.BackColor = al_BkColor
This.BackColor = al_BkColor

end subroutine

public function integer wf_set_tab_enabled (boolean ab_enable);Integer i
For i = 2 To UpperBound(Tab_contract_details.Control[])
	Tab_contract_details.Control[i].Enabled = ab_enable
Next

Return 1
end function

public subroutine of_set_searchtab_menu ();////Auto Refresh Toolbar Item
//If Not isvalid(m_pfe_cst_mdi_menu_contract) Then Return 
//If This.tab_contract_details.tabpage_search.ib_autoretrieve Then
//	m_pfe_cst_mdi_menu_contract.m_file.m_options.m_autorefresh.toolbaritemdown = True
//	m_pfe_cst_mdi_menu_contract.m_file.m_options.m_autorefresh.tag = 'auto'
//Else
//	m_pfe_cst_mdi_menu_contract.m_file.m_options.m_autorefresh.toolbaritemdown = False
//	m_pfe_cst_mdi_menu_contract.m_file.m_options.m_autorefresh.tag = 'non-auto'
//End If
//
////Report Toolbar Item
//Long ll_Right
//ll_Right = w_mdi.of_security_access(6952)
//If ll_Right = 1 Then
//	m_pfe_cst_mdi_menu_contract.m_file.m_output0.visible = True
//	m_pfe_cst_mdi_menu_contract.m_file.m_output0.toolbaritemvisible = True
//	m_pfe_cst_mdi_menu_contract.m_file.m_output0.m_output1.visible = True
//	m_pfe_cst_mdi_menu_contract.m_file.m_output0.m_output1.toolbaritemvisible = True
//	m_pfe_cst_mdi_menu_contract.m_file.m_output0.m_report.visible = True
//	m_pfe_cst_mdi_menu_contract.m_file.m_output0.m_report.toolbaritemvisible = True	
//Else
//	m_pfe_cst_mdi_menu_contract.m_file.m_output0.visible = False
//	m_pfe_cst_mdi_menu_contract.m_file.m_output0.toolbaritemvisible = False
//	m_pfe_cst_mdi_menu_contract.m_file.m_output0.m_output1.visible = False
//	m_pfe_cst_mdi_menu_contract.m_file.m_output0.m_output1.toolbaritemvisible = False
//	m_pfe_cst_mdi_menu_contract.m_file.m_output0.m_report.visible = False
//	m_pfe_cst_mdi_menu_contract.m_file.m_output0.m_report.toolbaritemvisible = False
//End If
end subroutine

public function integer wf_get_tab_visible (long al_view_id, string as_tabname);////////////////////////////////////////////////////////////////////////
//// $<function>u_tab_contract_detailsof_tab_visible()
//// $<arguments>
////		value	integer	arg_view_id		
//// $<returns> (none)
//// $<description>Contract module modIfication
//// $<description>
////////////////////////////////////////////////////////////////////////
//// $<add> 07.25.2006 by Liang QingShi
////////////////////////////////////////////////////////////////////////
//string ls_tab_name[]
//string ls_tab
//integer li_num,i,li_find,li_rowcount
//datastore lds_tab
//lds_tab = create datastore
//lds_tab.dataobject = 'd_contract_tab'
//lds_tab.settransobject(sqlca)
//gds_contract_screen = create datastore
//gds_contract_screen.dataobject = 'd_contract_dw_sql_all'
//gds_contract_screen.settransobject(sqlca)
//setpointer(hourglass!)
//
//If isnull(arg_view_id) Or arg_view_id = 0 Then arg_view_id = 1001
//gnv_appeondb.of_startqueue( )		
//li_rowcount = lds_tab.retrieve(arg_view_id)
//gds_contract_screen.retrieve(arg_view_id)
//gnv_appeondb.of_commitqueue( )		
//
//li_rowcount = lds_tab.rowcount()
//If li_rowcount <= 0 Then
//	Destroy lds_tab
//	Return
//end if
//
//ls_tab_name[1] = 'tabpage_search'
//ls_tab_name[2] = 'tabpage_details'
//ls_tab_name[3] = 'tabpage_requirements'
//ls_tab_name[4] = 'tabpage_contacts'
//ls_tab_name[5] = 'tabpage_locations'
//ls_tab_name[6] = 'tabpage_orgabizations'
//ls_tab_name[7] = 'tabpage_fee_schedules'
//ls_tab_name[8] = 'tabpage_fee_sched2'
//ls_tab_name[9] = 'tabpage_images'
//ls_tab_name[10] = 'tabpage_action_items'
//ls_tab_name[11] = 'tabpage_analysis'
//ls_tab_name[12] = 'tabpage_qrg'
//
//li_num = upperbound(ls_tab_name)
//For i = 1 to li_num
//	ls_tab = ls_tab_name[i]
//	choose case ls_tab
////		case 'tabpage_search'
////			li_find = lds_tab.find("tab_name = 'tabpage_search'",1,li_rowcount)
////			If li_find > 0 Then
////				tabpage_search.visible = True
////			Else
////				tabpage_search.visible = False				
////			End If	
//		case 'tabpage_details'
//			li_find = lds_tab.find("tab_name = 'tabpage_details'",1,li_rowcount)
//			If li_find > 0 Then
//				tabpage_details.visible = True
//			Else
//				tabpage_details.visible = False				
//			End If	
//		case 'tabpage_requirements'
//			li_find = lds_tab.find("tab_name = 'tabpage_requirements'",1,li_rowcount)
//			If li_find > 0 Then
//				tabpage_requirements.visible = True
//			Else
//				tabpage_requirements.visible = False				
//			End If	
//		case 'tabpage_contacts'
//			li_find = lds_tab.find("tab_name = 'tabpage_contacts'",1,li_rowcount)
//			If li_find > 0 Then
//				tabpage_contacts.visible = True
//			Else
//				tabpage_contacts.visible = False				
//			End If	
//		case 'tabpage_locations'
//			li_find = lds_tab.find("tab_name = 'tabpage_locations'",1,li_rowcount)
//			If li_find > 0 Then
//				tabpage_locations.visible = True
//			Else
//				tabpage_locations.visible = False				
//			End If	
//		case 'tabpage_orgabizations'
//			li_find = lds_tab.find("tab_name = 'tabpage_orgabizations'",1,li_rowcount)
//			If li_find > 0 Then
//				tabpage_orgabizations.visible = True
//			Else
//				tabpage_orgabizations.visible = False				
//			End If	
//		case 'tabpage_fee_schedules'
//			li_find = lds_tab.find("tab_name = 'tabpage_fee_schedules'",1,li_rowcount)
//			If li_find > 0 Then
//				tabpage_fee_schedules.visible = True
//			Else
//				tabpage_fee_schedules.visible = False				
//			End If	
//		case 'tabpage_fee_sched2'
//			li_find = lds_tab.find("tab_name = 'tabpage_fee_sched2'",1,li_rowcount)
//			If li_find > 0 Then
//				tabpage_fee_sched2.visible = True
//			Else
//				tabpage_fee_sched2.visible = False				
//			End If	
//		case 'tabpage_images'
//			li_find = lds_tab.find("tab_name = 'tabpage_images'",1,li_rowcount)
//			If li_find > 0 Then
//				tabpage_images.visible = True
//			Else
//				tabpage_images.visible = False				
//			End If	
//		case 'tabpage_action_items'
//			li_find = lds_tab.find("tab_name = 'tabpage_action_items'",1,li_rowcount)
//			If li_find > 0 Then
//				tabpage_action_items.visible = True
//			Else
//				tabpage_action_items.visible = False				
//			End If	
//		case 'tabpage_analysis'
//			li_find = lds_tab.find("tab_name = 'tabpage_analysis'",1,li_rowcount)
//			If li_find > 0 Then
//				tabpage_analysis.visible = True
//			Else
//				tabpage_analysis.visible = False				
//			End If	
//		case 'tabpage_qrg'
//			li_find = lds_tab.find("tab_name = 'tabpage_qrg'",1,li_rowcount)
//			If li_find > 0 Then
//				tabpage_qrg.visible = True
//			Else
//				tabpage_qrg.visible = False				
//			End If	
//	End choose
//Next
//
////--------------------------- APPEON BEGIN ---------------------------
////$< Add  > 2007-08-07 By: Scofield
////$<Reason> Destroy lds_tab
//if isValid(lds_tab) then
//	Destroy lds_tab
//end if
////---------------------------- APPEON END ----------------------------
//
////---------------------------- APPEON End ----------------------------
//
Return 1
//
end function

public function integer wf_get_batch_ctx (ref str_batch_doc astr_ctx_doc);String ls_access
Long ll_row,ll_category_id,ll_view_id,ll_ctx_id
Datawindow ldw_search
str_batch_doc lstr_ctx_doc,lstr_ctx_doc_invalid

DataStore lds_view_tab 
lds_view_tab = Create DataStore
lds_view_tab.dataobject = 'd_ctx_view_tab'
lds_view_tab.SetTransObject(SQLCA)
lds_view_tab.Retrieve()

Choose Case tab_contract_details.Selectedtab
	Case 1
		ldw_search = tab_contract_details.tabpage_search.dw_search_det1
		ll_row = ldw_search.Getselectedrow(0)
		If ll_row <= 0 Then Return 0
		
		Do While ll_row > 0
			ll_ctx_id = ldw_search.GetItemNumber(ll_row,'ctx_id')
			
			//Check View ID
			ll_category_id = ldw_search.GetItemNumber(ll_row,'category')
			ll_view_id = tab_contract_details.tabpage_search.of_get_ctx_view(ll_category_id,ll_ctx_id)
			If lds_view_tab.Find('data_view_id = ' + String(ll_view_id) + ' and tab_name = "tabpage_images"' ,1,lds_view_tab.RowCount()) = 0 Then
				lstr_ctx_doc_invalid.al_ctx_id[UpperBound(lstr_ctx_doc_invalid.al_ctx_id[]) + 1] = ll_ctx_id
				lstr_ctx_doc_invalid.as_companyname[UpperBound(lstr_ctx_doc_invalid.as_companyname[]) + 1] = ldw_search.Describe("Evaluate( 'lookupdisplay(app_facility) ', "+string(ll_row)+" )")	
				lstr_ctx_doc_invalid.as_category[UpperBound(lstr_ctx_doc_invalid.as_category[]) + 1] = ldw_search.Describe("Evaluate( 'lookupdisplay(category) ', "+string(ll_row)+" )")			
				lstr_ctx_doc_invalid.as_errtext[UpperBound(lstr_ctx_doc_invalid.as_errtext[]) + 1] = 'No Document Manager Tab for the View.'		
				ll_row = ldw_search.Getselectedrow(ll_row)
				Continue
			End If
			
			//Check Roles right
			If ldw_search.GetItemString(ll_row,'access') <> 'F' Then
				lstr_ctx_doc_invalid.al_ctx_id[UpperBound(lstr_ctx_doc_invalid.al_ctx_id[]) + 1] = ll_ctx_id
				lstr_ctx_doc_invalid.as_companyname[UpperBound(lstr_ctx_doc_invalid.as_companyname[]) + 1] = ldw_search.Describe("Evaluate( 'lookupdisplay(app_facility) ', "+string(ll_row)+" )")	
				lstr_ctx_doc_invalid.as_category[UpperBound(lstr_ctx_doc_invalid.as_category[]) + 1] = ldw_search.Describe("Evaluate( 'lookupdisplay(category) ', "+string(ll_row)+" )")			
				lstr_ctx_doc_invalid.as_errtext[UpperBound(lstr_ctx_doc_invalid.as_errtext[]) + 1] = 'Read Only for ' +gs_user_id + '.'
				ll_row = ldw_search.Getselectedrow(ll_row)
				Continue
			End If
			
			lstr_ctx_doc.al_ctx_id[UpperBound(lstr_ctx_doc.al_ctx_id[]) + 1] = ll_ctx_id
			lstr_ctx_doc.as_companyname[UpperBound(lstr_ctx_doc.as_companyname[]) + 1] = ldw_search.Describe("Evaluate( 'lookupdisplay(app_facility) ', "+string(ll_row)+" )")	
			lstr_ctx_doc.as_category[UpperBound(lstr_ctx_doc_invalid.as_category[]) + 1] = ldw_search.Describe("Evaluate( 'lookupdisplay(category) ', "+string(ll_row)+" )")				
			ll_row = ldw_search.Getselectedrow(ll_row)
		Loop
	Case 2
		ldw_search = tab_contract_details.tabpage_details.uo_1.dw_1
		ll_row = ldw_search.GetRow()
		If ll_row <= 0 Then Return 0
		lstr_ctx_doc.al_ctx_id[1] = ldw_search.GetItemNumber(ll_row,'ctx_id')
		lstr_ctx_doc.as_companyname[1] = ldw_search.Describe("Evaluate( 'lookupdisplay(app_facility) ', "+string(ll_row)+" )")	
		lstr_ctx_doc.as_category[1] = ldw_search.Describe("Evaluate( 'lookupdisplay(category) ', "+string(ll_row)+" )")						
		lstr_ctx_doc.al_default_category = ldw_search.GetItemNumber(ll_row,'category')
End Choose


If UpperBound(lstr_ctx_doc_invalid.al_ctx_id[]) > 0 Then
	OpenWithParm(w_ctx_batch_doc_invalid_list,lstr_ctx_doc_invalid)
	If Message.Doubleparm <> 1 Then
		Return -1
	End If
End If

astr_ctx_doc = lstr_ctx_doc
Return 1
end function

public subroutine wf_set_tabs_icon ();//////////////////////////////////////////////////////////////////////
// $<function>gw_contract.wf_set_tabs_icon()
// $<arguments>(None)
// $<returns> (none)
// $<description>
// $<description> Set all Tab pages Icon
//////////////////////////////////////////////////////////////////////
// $<add> 2010-09-19 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Long i, ll_cnt
String ls_Condition,ls_tabname,ls_icon,ls_tabicon_show
userobject luo_tabpage
n_cst_dm_utils lnv_utils //Added By Ken.Guo 03/28/2013

//Added By Mark Lee 05/14/12
ids_tabpage_prop.SetFilter("")
ids_tabpage_prop.Filter()

ls_Condition = "data_view_id=" + String(il_data_view_id) 
ids_tabpage_prop.SetFilter(ls_Condition)
ids_tabpage_prop.Filter()

ll_cnt = ids_tabpage_prop.RowCount()
For i = 1 to ll_cnt
	ls_tabname = ids_tabpage_prop.GetItemString(i,'tabpage_name')
	ls_icon = ids_tabpage_prop.GetItemString(i,'tab_icon')
	ls_tabicon_show = ids_tabpage_prop.GetItemString(i,'icon_visible')
	If isnull(ls_icon) OR TRIM(ls_icon) = '' Then ls_icon = ''

	Choose Case Lower(ls_tabname)
		Case 'tabpage_search'
			luo_tabpage = gw_contract.tab_contract_details.tabpage_search
		Case 'tabpage_details'
			luo_tabpage = gw_contract.tab_contract_details.tabpage_details
		Case 'tabpage_det_notes'
			luo_tabpage = gw_contract.tab_contract_details.tabpage_details.uo_1.tab_1.tabpage_notes
		Case 'tabpage_det_custom'
			luo_tabpage = gw_contract.tab_contract_details.tabpage_details.uo_1.tab_1.tabpage_custom
		Case 'tabpage_det_audit'
			luo_tabpage = gw_contract.tab_contract_details.tabpage_details.uo_1.tab_1.tabpage_1
		Case 'tabpage_det_linked'
			luo_tabpage = gw_contract.tab_contract_details.tabpage_details.uo_1.tab_1.tabpage_2			
		Case 'tabpage_det_group'
			luo_tabpage = gw_contract.tab_contract_details.tabpage_details.uo_1.tab_1.tabpage_group_access
		Case 'tabpage_requirements'
			luo_tabpage = gw_contract.tab_contract_details.tabpage_requirements
		Case 'tabpage_contacts'
			luo_tabpage = gw_contract.tab_contract_details.tabpage_contacts	
		Case 'tabpage_locations'
			luo_tabpage = gw_contract.tab_contract_details.tabpage_locations			
		Case 'tabpage_orgabizations'
			luo_tabpage = gw_contract.tab_contract_details.tabpage_orgabizations
		Case 'tabpage_fee_schedules'
			luo_tabpage = gw_contract.tab_contract_details.tabpage_fee_schedules			
		Case 'tabpage_fee_browse'	
			luo_tabpage = gw_contract.tab_contract_details.tabpage_fee_schedules.tab_1.tabpage_fee_browse
		Case 'tabpage_fee_notes'
			luo_tabpage = gw_contract.tab_contract_details.tabpage_fee_schedules.tab_1.tabpage_fee_notes		
		Case 'tabpage_fee_sched2'
			luo_tabpage = gw_contract.tab_contract_details.tabpage_fee_sched2
		Case 'tabpage_images'
			luo_tabpage = gw_contract.tab_contract_details.tabpage_images	
		Case 'tabpage_dm_document'
			luo_tabpage = gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data
		Case 'tabpage_dm_workflow'
			luo_tabpage = gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_action
		Case 'tabpage_dm_audit'
			//Added By Mark Lee 05/11/12   cancel the  comment  /  add  continue
//			luo_tabpage = gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_audit
			Continue 
		Case 'tabpage_action_items'
			luo_tabpage = gw_contract.tab_contract_details.tabpage_action_items
			//Added By Mark Lee 05/11/12  cancel the  comment  /  add  continue
		Case 'tabpage_qrg'
//			luo_tabpage = gw_contract.tab_contract_details.tabpage_qrg
			Continue 
		Case 'tabpage_multi'
			luo_tabpage = gw_contract.tab_contract_details.tabpage_multi
			//Added By Mark Lee 05/11/12  cancel the  comment  /  add  continue
		Case 'tabpage_qrg_select'
//			luo_tabpage = gw_contract.tab_contract_details.tabpage_qrg.tab_1.tabpage_selection
			Continue 
		Case 'tabpage_email'									//Added By Mark Lee 02/05/2013
			luo_tabpage = gw_contract.tab_contract_details.tabpage_email			
		Case Else
			Continue		
	End Choose
	If ls_tabicon_show = 'T' Then
		If ls_icon <> '' Then
			
			//Added By Ken.Guo 03/28/2013
			If isnumber(ls_icon) Then
				If isnumber(ls_icon) Then
					lnv_utils.of_download_picture( Long(ls_icon),ls_icon) 
				End If
			End If

			//If luo_tabpage.picturename <> ls_icon Then  //Commented by (Appeon)Harry 12.10.2014
			If isnull( luo_tabpage.picturename) or luo_tabpage.picturename <> ls_icon Then //(Appeon)Harry 12.10.2014 - for Bug 4346
				luo_tabpage.picturename = ls_icon
			End If
		Else
			ls_icon = gf_get_tabpage_default_icon(ls_tabname)
			//If luo_tabpage.picturename <> ls_icon Then //Commented by (Appeon)Harry 12.10.2014
			If isnull( luo_tabpage.picturename) or luo_tabpage.picturename <> ls_icon Then //(Appeon)Harry 12.10.2014 - for Bug 4346
				luo_tabpage.picturename = ls_icon
			End If
		End If
	Else
		If luo_tabpage.picturename <> '' Then
			luo_tabpage.picturename =''
			//Added By Mark Lee 06/13/12	APB BUG
			setnull(luo_tabpage.picturename)
		End If
	End If	
	
Next

//Added By Ken.Guo 2011-02-15. Must unfilter data.
ids_tabpage_prop.SetFilter("")
ids_tabpage_prop.Filter()

Return 
end subroutine

public subroutine of_show_contract_window ();//////////////////////////////////////////////////////////////////////
// $<function>of_show_contract_window()
// $<arguments>(None)
// $<returns> (none)
// $<description>
// $<description> Set Focus and Show window if it is hide(To No Flash).
//////////////////////////////////////////////////////////////////////
// $<add> 2009-08-27 by Ken.Guo
// Modified By Ken.Guo 2010-10-09. Copy from n_cst_copy_ctx.of_show_contract_window()
//////////////////////////////////////////////////////////////////////

this.setfocus()
this.tab_contract_details.tabpage_details.uo_1.dw_1.SetColumn('app_facility')	
this.setredraw(True)
this.tab_contract_details.setredraw(True)	
If gb_open_from_template = True Then
	w_mdi.WindowState = Maximized!
	w_mdi.Show()
	this.of_Show()
	gb_open_from_template = False
End If
If this.windowstate = Minimized! Then 
	this.windowstate = Maximized!
End If
end subroutine

public subroutine of_check_validation ();//Added By Ken.Guo 2011-04-18. Check necessary data.
Integer li_ret1,li_ret2,li_ret3
If isvalid(gw_contract) Then 
	This.tab_contract_details.tabpage_details.uo_1.dw_1.of_enable_save()
	
	li_ret1 = This.tab_contract_details.tabpage_details.uo_1.dw_1.event pfc_validation( )
	If li_ret1 = 1 Then
		li_ret2 = This.tab_contract_details.tabpage_details.uo_1.dw_ccc.event pfc_validation( )
		If li_ret2 = 1 Then
			li_ret3 = This.tab_contract_details.tabpage_details.uo_1.dw_occ.event pfc_validation( )			
		End If
	End If
	
	If (li_ret1 <> 1 or li_ret2 <> 1 or li_ret3 <> 1) Or This.tab_contract_details.tabpage_details.uo_1.dw_ccc.Modifiedcount( ) + This.tab_contract_details.tabpage_details.uo_1.dw_occ.Modifiedcount( ) > 0 Then 
		This.tab_contract_details.tabpage_details.uo_1.dw_1.of_enable_save()
	Else
		If isvalid(m_pfe_cst_mdi_menu_contract) Then
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_file.m_save,'enabled', False)
		End If
	End If	
End If

end subroutine

public function string wf_addtextblank (string as_text);Dec{2}   ldec_Len = 6.00

/*******************************************///added by gavins 20120507
ldec_Len = Ceiling( Len( as_text ) / ldec_Len )
as_text = space(ldec_Len) +  as_text  + space(ldec_Len)
/*******************************************/


Return as_Text
end function

public subroutine wf_setupdateobjects ();//added by gavins 20121113

of_updatechecks( )
end subroutine

public subroutine of_set_tab_attribute ();string	ls_fontname, ls_italic, ls_underline, ls_fixedwidth
long	ll_Font_height

//added by gaivns 20130415
ls_fontname = gnv_user_option.of_get_viewid_option_value( il_data_view_id, 'View_Tab_Font_Name_Properties' , FALSE )
ls_italic = gnv_user_option.of_get_viewid_option_value( il_data_view_id, 'View_Tab_Font_Italic_Properties' , FALSE )
ls_underline = gnv_user_option.of_get_viewid_option_value( il_data_view_id, 'View_Tab_Font_Underline_Properties' , FALSE )
ll_Font_height = Long( gnv_user_option.of_get_viewid_option_value( il_data_view_id, 'View_Tab_Font_Height_Properties' , FALSE ) )
ls_fixedwidth = gnv_user_option.of_get_viewid_option_value( il_data_view_id, 'View_Tab_Fixed_Width_Properties' , FALSE )

If ls_fontname = '' then ls_fontname = 'Segoe UI'
If ls_italic = '' Then ls_italic = 'F' 
If ls_underline = '' Then ls_underline = 'F' 
If ls_fixedwidth = '' Then ls_fixedwidth = 'T' 
If ll_Font_height = 0 Then ll_Font_height = 8

If Len( ls_fontname ) > 0 Then
	tab_contract_details.FaceName	= ls_fontname
End If

If Len( ls_italic ) > 0 Then
	tab_contract_details.italic = ( ls_italic = 'T' )
End If

If Len( ls_underline ) > 0 Then
	tab_contract_details.Underline	= ( ls_underline = 'T' )
End If
If Len( ls_fixedwidth ) > 0 Then
	tab_contract_details.Fixedwidth= ( ls_fixedwidth = 'T' )
End If
If ll_Font_height > 0 Then
	tab_contract_details.TextSize	= - ll_Font_height
End If
end subroutine

public subroutine wf_open_document (long al_docid);//gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.Post of_open_document( ll_docid )	
gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.Post of_open_document( al_docid )	
end subroutine

public function datawindow of_getactivedatawindow ();// (Appeon)Harry 05.05.2014 - V142 ISG-CLX Copy from CLX12.0
return idw_active
end function

on w_contract.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.tab_contract_details=create tab_contract_details
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.tab_contract_details
end on

on w_contract.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.tab_contract_details)
end on

event pfc_postopen;call super::pfc_postopen;/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner xx August 2005  ?Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 01.29.2007 By: Frank.Gui
//$<reason> Change Supporting Document to Document Manager. This is unuseful.
/*iuo_1 = this.tab_contract_details.tabpage_images.tab_1.tabpage_view.uo_1
*/
//---------------------------- APPEON END ----------------------------

//BEGIN---Delete by Evan 10/29/2008
//Remark: Move the following code to ue_show_postopen event
/*
inv_contract_codes = CREATE n_cst_contract

// broadcast the userobject to all the tabpages
tab_contract_details.of_set_contract_details(inv_contract_codes)
//THIS.TITLE = 'Contract Logix '  + '(' + 'Search Mode' + ')'


//parent.ib_retriev_detail = true
//--------------------------- APPEON BEGIN ---------------------------
//$< Ad   > 2007-08-17 By: Scofield
//$<Reason> Make a remark to decide if popup a dialog when there is no record
this.tab_contract_details.tabpage_search.ib_PostOpen = true
//---------------------------- APPEON END ----------------------------

this.tab_contract_details.tabpage_search.CB_1.event clicked( )
//parent.ib_retriev_detail = false


//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 09.05.2006 By: LeiWei
//$<reason> Performance tuning.
//$<modification> The following script moved to u_tabpg_contract_search.of_retrieve().
//inv_contract_codes.of_del_ctx_directory( )
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-03
//$<add> 03.17.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Define a variable to be used in subsequent script.
ib_win_just_open = FALSE
//---------------------------- APPEON END ----------------------------

//this.event ue_save_contract_dir( )
*/
//END---Delete by Evan 10/29/2008


//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 10.19.2006 By: Davis
//$<reason> Should only start the email on initial logon. 
/*

///////////////////////////////////////////////////////////////////////
// start the email
///////////////////////////////////////////////////////////////////////
n_cst_notification  lnvo_notification
lnvo_notification =  create n_cst_notification
lnvo_notification.of_start_notification_process( )

*/
//---------------------------- APPEON END ----------------------------


//BEGIN---Delete by Evan 10/29/2008
//Remark: Move the following code to ue_show_postopen event
/*
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.09.2007 By: Jack 
//$<reason> Fix a defect.

long ll_category
integer li_view_id
setpointer(hourglass!)
ll_category = this.tab_contract_details.tabpage_search.inv_contract_details.il_category

li_view_id = integer(gnv_data.of_getitem('code_lookup','ic_n',"lookup_code = " + string(ll_category)))

If isnull(li_view_id) Or li_view_id = 0 Then
	li_view_id = integer(gnv_data.of_getitem('security_users','contract_default_view',"upper(user_id)='" + upper(gs_user_id) + "'"))
End If

If li_view_id <> gi_contract_view_id Then
	gi_contract_view_id = li_view_id
   wf_tab_visible(li_view_id)
	wf_set_select('All',false) 
End If
//---------------------------- APPEON END ----------------------------
//Added by Nova on 2008-08-13
if ib_auto_locate then  of_dashboard(str_para.data_id)
*/
//END---Delete by Evan 10/29/2008

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.25.2008 By: Ken.Guo
//$<reason> Workaround APB Bug27168. 
//$If APB Bug27168 is fixed in the future, below script should be Commented.
If AppeonGetClientType() = 'WEB' Then
	w_contract.tab_contract_details.Event SelectionChanged(1,1)
End If
//---------------------------- APPEON END ----------------------------

//This.SetRedraw( true)  //Jervis 05.26.2009 --Temporary add for John's require
end event

event pfc_preopen;call super::pfc_preopen;/****************************************************************************************************************
** [PUBLIC] EVENT   w_reappointment_measurements_search::pfc_preopen
**--------------------------------------------------------------------------------------------------------------
** Description: Perform pre open requirments
**--------------------------------------------------------------------------------------------------------------
** Arguments:	
**--------------------------------------------------------------------------------------------------------------
** Returns:	(none) 
**--------------------------------------------------------------------------------------------------------------
** Author:	Michael Skinner 	Date: 		Wednesday November 10 2004
**--------------------------------------------------------------------------------------------------------------
** ModIFication Log:	
**
** Date            Who                   Change  	
**--------------------------------------------------------------------------------------------------------------
****************************************************************************************************************/
// set up the rezize, we only need to register userobjects and non PFC objects. All pfc related stuff will be handeled
// automatically


//BEGIN---Modify by Evan 10/29/2008
//Remark: Move the following code to ue_show_preopen event
/*
THIS.Move(1,1)

if isvalid(inv_contract_codes) then 
    inv_contract_codes.of_adjust_menu(this.tab_contract_details.tabpage_details,'')
end if 

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.23.2006 By: Gary
//$<reason> Fix a defect.
IF NOT gb_autoresize THEN RETURN
//---------------------------- APPEON END ----------------------------

LONG LL_I
string ls_scale

this.of_SetResize(TRUE)

this.inv_resize.of_SetOrigSize (this.workspacewidth( ) ,  this.workspaceheight( ) )

//Add by jervis 02.15.2007
this.inv_resize.of_SetMinSize (800 ,600 )

ls_scale = this.inv_resize.scale

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// The search user object
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

FOR LL_I =  1 TO UPPERBOUND(this.CONTrol)
   this.inv_resize.of_Register (this.CONTrol[LL_I]  , ls_scale	 )
NEXT
*/

integer i

if gb_AutoResize then
	this.of_SetResize(true)
	this.inv_resize.of_SetOrigSize(this.WorkSpaceWidth(), this.WorkSpaceHeight())
	this.inv_resize.of_SetMinSize(800, 600)
	for i =  1 to UpperBound(this.Control)
		this.inv_resize.of_Register(this.Control[i], this.inv_resize.scale)
	next
end if
//END---Modify by Evan 10/29/2008

//Restore Window State -- jervis 09.10.2009
if gb_restore_contract_state and ProfileString(gs_IniWindowState,"w_contract","Maximized",'1') <> '1' then
	of_RestoreWindowState()
end if
 
this.hide( )  //Jervis 08.24.2010
end event

event pfc_new;call super::pfc_new;/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner  today()
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
long 		ll_Msg
Integer	li_rc

Powerobject lpo_updatearray[]

if of_IsExceedMaxCnts() then Return

//-------Begin Added by Alfee 09.30.2007------
//<$Reason>Add read only control to Contract Module
If Not inv_contract_codes.of_allow_newctx() Then 
	MessageBox("IntelliContract","You don't have rights to create a new contract!")
	Return
End If
//-------End Added ---------------------------

//Added By Ken.Guo 2009-08-27.
n_cst_copy_ctx lnv_copy_ctx
lnv_copy_ctx = Create n_cst_copy_ctx
If lnv_copy_ctx.of_check_exist_contract() <= 0 Then 
	If isvalid(lnv_copy_ctx) Then Destroy lnv_copy_ctx
	Return 
End IF

If UpperBound(ipo_updateobjects) > 0 Then
	lpo_updatearray = ipo_updateobjects
Else
	lpo_updatearray = This.Control		
End If

// Check for any pending updates
li_rc = of_UpdateChecks(lpo_updatearray)

//choose case li_rc
//	case -1 
//		of_MessageBox ("pfc_master_closequery_savechanges", gnv_app.iapp_object.DisplayName, "AcceptText error - Please contact Intelisoft Support", exclamation!, ok!, 1)
//		return 
//	case -2
//		of_MessageBox ("pfc_master_closequery_savechanges", gnv_app.iapp_object.DisplayName, "UpdatesPending error - Please contact Intelisoft Support", exclamation!, ok!, 1)
//		return
//	case -3
//		of_MessageBox ("pfc_master_closequery_savechanges", gnv_app.iapp_object.DisplayName, "Validation error - Please contact Intelisoft Support", exclamation!, ok!, 1)
//		return
//		
//end choose 


if li_rc > 0 then 
			ll_Msg = of_MessageBox ("pfc_master_closequery_savechanges", gnv_app.iapp_object.DisplayName, "Do you want to save changes?", exclamation!, YesNoCancel!, 1)
	Choose Case ll_Msg
		Case 1
			// YES - Update
			// If the update fails, prevent the window from closing
			If This.Event pfc_save() >= 1 Then
			else 
				return 
			End If
		Case 2
			// do nothing reset the datawindows			
		Case 3
			// CANCEL -  Prevent the window from closing
			If isvalid(lnv_copy_ctx) Then Destroy lnv_copy_ctx
			return 
	End Choose

end if

////////////////////////////////////////////////////////////////////////////////////
// trigger the new events on the tabpages
////////////////////////////////////////////////////////////////////////////////////

inv_contract_codes.of_set_protect_columns(false)
inv_contract_codes.of_set_tab_change( true)

tab_contract_details.tabpage_search.inv_contract_details.is_mode = tab_contract_details.tabpage_search.inv_contract_details.new
inv_contract_codes.of_set_ctx_id(0)
tab_contract_details.tabpage_details.uo_1.tab_1.tabpage_1.il_ctx_id = inv_contract_codes.of_get_ctx_id( )	//Added by Scofield on 2008-09-18

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 06.20.2007 By: Jack
//$<reason> Fix a defect.
If tab_contract_details.tabpage_details.visible = False Then
  	gi_contract_view_id = 1001
	wf_tab_visible(gi_contract_view_id)
End If
//---------------------------- APPEON END ----------------------------

tab_contract_details.selecttab('tabpage_details' )
//tab_contract_details.tabpage_details.tab_1.selecttab( 1)
tab_contract_details.tabpage_details.uo_1.event ue_new( )
//tab_contract_details.tabpage_details.tab_1.ue

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 07.06.2007 By: Jack
//$<reason> Fix a defect.
If isvalid(m_pfe_cst_mdi_menu_contract) Then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_newcontract.m_copyctx,'enabled', False)
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_contract0.m_copy_contract_record,'enabled', False)						//Added By Mark Lee 12/18/2012
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_contract0.m_copy_create_sub_contract_record,'enabled', False)		//Added By Mark Lee 12/18/2012
End If 
//Begin - Added By Mark Lee 12/18/2012
If isvalid(m_pfe_cst_mdi_menu_contract_am) Then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_contract0.m_copy_contract_record,'enabled', False)						
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_contract0.m_copy_create_sub_contract_record,'enabled', False)		
End If 
//End - Added By Mark Lee 12/18/2012

ib_copy = False    //Add by Jack 07.09.2007
//---------------------------- APPEON END ----------------------------

wf_manage_tabs(false)
tab_contract_details.tabpage_details.enabled = True //Added By Ken.Guo 2010-09-08.

This.Title = 'IntelliContract '  + '(' + 'New Mode' + ')'

If isvalid(lnv_copy_ctx) Then Destroy lnv_copy_ctx
end event

event closequery;/******************************************************************************************************************
**  [PUBLIC]   : Event:  event closequery( )
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   OVERRIDE ANCESTOR SCRIPT
**==================================================================================================================
**  Created By	: sybasetab_contract_details.tabpage_details.tab_1
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
** Michael B. Skinner      23 June 2005														made changes for the nested tab  
********************************************************************************************************************/

//BEGIN---Modify by Evan 10/29/2008
//Remark: Move the following code to ue_show_closequery event
/*
Constant Integer	ALLOW_CLOSE = 0
Constant Integer	PREVENT_CLOSE = 1

Integer	li_msg
Integer	li_rc

long ll_ret 
String	ls_msgparms[]
Powerobject lpo_updatearray[]

// Check if the CloseQuery process has been disabled
If ib_disableclosequery Then
	Return ALLOW_CLOSE
End If

// Call event to perform any pre-CloseQuery processing
If This.Event pfc_preclose ( ) <> 1 Then
	// Prevent the window from closing
	Return PREVENT_CLOSE 
End If

// Prevent validation error messages from appearing while the window is closing
// and allow others to check if the  CloseQuery process is in progress
ib_closestatus = True

// Determine the objects for which an update will be attempted.
// For the CloseQuery, the order sequence is as follows: 
//		1) Specified permananent sequence (thru of_SetUpdateObjects(...)).
//		2) None was specified, so use default window control array.
If UpperBound(ipo_updateobjects) > 0 Then
	lpo_updatearray = ipo_updateobjects
Else
	lpo_updatearray = This.Control		
End If
long ll_rc2


//this.tab_contract_details.tabpage_details.tab_1.of_accepttext( true)
//ll_rc2 = this.tab_contract_details.tabpage_details.tab_1.of_UpdatesPending( )




// Check for any pending updates
li_rc = of_UpdateChecks(lpo_updatearray)
If li_rc = 0  and ll_rc2 =  0 Then
	// Updates are NOT pending, allow the window to be closed.
	ib_closestatus = False
	Return ALLOW_CLOSE
ElseIf li_rc < 0 Then
	// Make sure the window is not minimized and behind other windows.
	If this.WindowState = Minimized! Then
		this.WindowState = Normal!
	End If
	this.BringToTop = True

	// There are Updates pending, but at least one data entry error was found.
	// Give the user an opportunity to close the window without saving changes
	If IsValid(gnv_app.inv_error) Then
		li_msg = gnv_app.inv_error.of_Message('pfc_closequery_failsvalidation', &
					 ls_msgparms, gnv_app.iapp_object.DisplayName)
	Else
		li_msg = of_MessageBox ("pfc_master_closequery_failsvalidation", 	gnv_app.iapp_object.DisplayName, &
					"The information entered does not pass validation and must be corrected before changes can be saved.~r~n~r~n" + &
					"Close without saving changes?", exclamation!, YesNo!, 2)
	End If
	If li_msg = 1 Then
		ib_closestatus = False
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 07.09.2007 By: Jack
		//$<reason> 
		If ib_copy1 = True  Then
			ib_copy = True
			If isvalid(m_pfe_cst_mdi_menu_contract) Then
				m_pfe_cst_mdi_menu_contract.m_edit.m_delete1.triggerevent(clicked!)
			End If
		End If 		
		//---------------------------- APPEON END ----------------------------
		Return ALLOW_CLOSE
	End If
Else
	// Make sure the window is not minimized and behind other windows.
	If this.WindowState = Minimized! Then
		this.WindowState = Normal!
	End If	
	this.BringToTop = True
	
	// Changes are pending, prompt the user to determine if they should be saved
	If IsValid(gnv_app.inv_error) Then
		li_msg = gnv_app.inv_error.of_Message('pfc_closequery_savechanges',  &
					ls_msgparms, gnv_app.iapp_object.DisplayName)		
	Else
		li_msg = of_MessageBox ("pfc_master_closequery_savechanges", &
					gnv_app.iapp_object.DisplayName, &
					"Do you want to save changes?", exclamation!, YesNoCancel!, 1)
	End If
	Choose Case li_msg
		Case 1
			// YES - Update
			// If the update fails, prevent the window from closing
			//tab_contract_details.tabpage_details.tab_1.of_update( true,true)
			
			ll_ret =  Event pfc_save() 
			
			if ll_ret = success or ll_ret = -9 Then ///mskinner because of the nested tabs the update prep may  fail - who cares
				// Successful update, allow the window to be closed
				//ib_closestatus = False
				Return ALLOW_CLOSE
			End If
		Case 2
			// NO - Allow the window to be closed without saving changes
			ib_closestatus = False
			Return ALLOW_CLOSE
		Case 3
			// CANCEL -  Prevent the window from closing
	End Choose
End If

// Prevent the window from closing
ib_closestatus = False
Return PREVENT_CLOSE
*/

gnv_tracking.of_tracking_doc_delete('Document Management')	//Added By Mark Lee 07/20/12

if this.Event ue_show_closequery() = 1 then
	Return 1    // Hide window
else
	this.Event ue_show_close()
	if ib_IsMDIClose then
		Return 0 // Close window
	else
		Return 1 // Hide window
	end if
end if
//END---Modify by Evan 10/29/2008
end event

event close;call super::close;//BEGIN---Modify by Evan 10/29/2008
//Remark: Move the following code to ue_show_close event


//this.event ue_save_contract_dir( )
//
//IF IsValid(w_dm_comparison_wizard) THEN Close(w_dm_comparison_wizard) //Alfee 09.17.2008
////--------------------------- APPEON BEGIN ---------------------------
////$<add> 08.21.2006 By: LeiWei
////$<reason> Fix a defect.
///*
//w_mdi.changemenu(m_pfe_cst_mdi_menu)
//*/
//If w_mdi.menuname <> 'm_pfe_cst_mdi_menu' Then w_mdi.ChangeMenu( m_pfe_cst_mdi_menu )
//w_mdi.of_menu_security( w_mdi.MenuName )
////---------------------------- APPEON END ----------------------------
//
////setpointer(hourglass!)
////gnv_app.ib_ref_cache  = true
////gnv_app.of_setcontraccache( ) 
////setpointer(arrow!)
//
////--------------------------- APPEON BEGIN ---------------------------
////$<Add> 08.23.2007 By: Evan
////$<Reason> Need to destroy object.
////if IsValid(inv_contract_codes) then Destroy inv_contract_codes
////---------------------------- APPEON END ----------------------------
//
////==============================APPEON BEGIN==========================
//// $<Added>:   Date: Feb 02,2008       Author:Nova
////--------------------------------------------------------------------
//// $<reason>   Fix a defect.
//
//if IsValid(w_contract_globalsearch) then close(w_contract_globalsearch)
////==============================APPEON END============================


if IsValid(ids_tabpage_prop) then Destroy ids_tabpage_prop
if IsValid(ids_screen_prop) then Destroy ids_screen_prop
//END---Modify by Evan 10/29/2008
end event

event activate;if not IsValid(gw_contract) then Return //Add by Evan 10/29/2008

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.18.2007 By: Jack (Document Manager)
//$<reason> 
If tab_contract_details.selectedtab = 9 Then
	If w_mdi.menuname <> 'm_pfe_cst_mdi_menu_contract_am' Or w_mdi.is_current_window_name <> 'w_contract' Then 
		if isvalid(tab_contract_details.tabpage_images.iw_parent ) then tab_contract_details.SelectTab(tab_contract_details.selectedtab) //Add isvalid(...) -- jervis 03.14.2011
		This.SetFocus() //for BugE090207 - Alfee 09.18.2008
	End If
ElseIF tab_contract_details.selectedtab = 12 Then 	//Added By Mark Lee 02/17/2013
	If w_mdi.menuname <> 'm_pfe_cst_mail' Or w_mdi.is_current_window_name <> 'w_contract' Then 
	if isvalid(tab_contract_details.tabpage_email.iw_parent ) then tab_contract_details.SelectTab(tab_contract_details.selectedtab) 
		This.SetFocus()  
	End If
Else
	//If tab_contract_details.ib_select Then				//Commented by Scofield on 2008-11-26
		If w_mdi.menuname <> 'm_pfe_cst_mdi_menu_contract' Then 
			tab_contract_details.SelectTab(tab_contract_details.selectedtab)
		End If
	//End If
	w_mdi.of_menu_security( w_mdi.MenuName )
End If
//---------------------------- APPEON END ----------------------------


//if isvalid(inv_contract_codes) then 
//    inv_contract_codes.of_adjust_menu(this.tab_contract_details.tabpage_details,'')
//end if 
//Start code By Jervis 01.19.2009
if isvalid(inv_contract_codes) and this.tab_contract_details.selectedtab = 1 and this.tab_contract_details.tabpage_search.dw_search_det1.rowcount() < 1 then 
   	//inv_contract_codes.of_adjust_menu(this.tab_contract_details.tabpage_search,'')
    inv_contract_codes.of_adjust_menu(this.tab_contract_details.tabpage_search,'', True) //Set w_mdi redraw to false in this function, Added by Appeon long.zhang 03.09.2017 (Contracts Module Slowness)
end if 
//End code by Jervis 01.19.2009

//Added By Ken.Guo 2011-05-05. Workaround Office OCX's bug
If gs_imageview_version = '5.0' and isvalid(tab_contract_details.tabpage_images.tab_1.tabpage_data.inv_dm_comparison) Then
	tab_contract_details.tabpage_images.tab_1.tabpage_data.tab_1.tabpage_preview.ole_doc.object.activate(true)
End If


//Add profile report - jervis 09.27.2011
if this.tab_contract_details.tabpage_search.dw_search_det1.rowcount() > 0 then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu.m_reports.m_profilerpt,'enabled', true)
end if
end event

event pfc_endtran;call super::pfc_endtran;

if ai_update_results = success then 
	event pfc_microhelp('Update Successful')
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 01.24.2007 By: Jack (Document Manager)
	//$<reason> Fix a defect.
	/*
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_file.m_save,'enabled', false)
	*/
	If isvalid(m_pfe_cst_mdi_menu_contract) Then
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_file.m_save,'enabled', false)
	End If
	//---------------------------- APPEON END ----------------------------
else 
	event pfc_microhelp('Update Failed!!!')
end if 

this.event ue_save_contract_dir( )

//THIS.TAB_contract_details.OF_Reset_retrived_status( )
return success
end event

event open;call super::open;//BEGIN---Modify by Evan 10/29/2008
//Remark: Move the following code to ue_show_open event
/*
//BEGIN---Add by Evan 07/15/2008
ids_tabpage_prop = Create n_ds
ids_tabpage_prop.DataObject = "d_tabpage_properties"
ids_tabpage_prop.SetTransObject(SQLCA)
ids_screen_prop = Create n_ds
ids_screen_prop.DataObject = "d_screen_properties"
ids_screen_prop.SetTransObject(SQLCA)

gnv_appeondb.of_StartQueue()
ids_tabpage_prop.Retrieve()
ids_screen_prop.Retrieve()
gnv_appeondb.of_CommitQueue()
//END---Add by Evan 07/15/2008

//maha app100405 for security
of_set_security()

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.22.2006 By: Davis
//$<reason> Set the window to global window.

gw_contract = this

//---------------------------- APPEON END ----------------------------
//Added by Nova on 2008-08-13
If Isvalid(message.powerobjectparm) Then
	If message.powerobjectparm.classname() = 'str_dashboard' Then
		str_para=message.powerobjectparm
		ib_auto_locate = True
	End If
End If
*/

ids_tabpage_prop = Create n_ds
ids_tabpage_prop.DataObject = "d_tabpage_properties"
ids_tabpage_prop.SetTransObject(SQLCA)
ids_screen_prop = Create n_ds
ids_screen_prop.DataObject = "d_screen_properties"
ids_screen_prop.SetTransObject(SQLCA)
//END---Modify by Evan 10/29/2008

This.SetRedraw( false)  //Jervis 05.26.2009 --Temporary add for John's require
end event

event resize;call super::resize;//====================================================================
// Event: resize()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    unsignedlong    sizetype
// 	value    integer         newwidth
// 	value    integer         newheight
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-10-28
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Contract Logix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

CONSTANT LONG SIDESPACE = 16

//if This.WindowState = Maximized! then
If sizetype = 2 Then
	/*
	tab_contract_details.X = 0
	tab_contract_details.Y = 0
	tab_contract_details.Width = NewWidth
	tab_contract_details.Height = NewHeight
	*/
	If tab_contract_details.x <> 0 or tab_contract_details.y <> 0 Then
		tab_contract_details.Move(0,0)
	End If
	If tab_contract_details.width <> NewWidth or tab_contract_details.height <> NewHeight Then
		tab_contract_details.Resize(NewWidth ,NewHeight)
	End If
//elseif This.WindowState = Normal! then
elseif sizetype = 0 then	
	/*
	tab_contract_details.X = SIDESPACE
	tab_contract_details.Y = SIDESPACE
	tab_contract_details.Width = NewWidth - 2 * SIDESPACE
	tab_contract_details.Height = NewHeight - 2 * SIDESPACE
	*/
	If tab_contract_details.x <> SIDESPACE or tab_contract_details.y <> SIDESPACE Then
		tab_contract_details.Move(SIDESPACE,SIDESPACE)
	End If
	If tab_contract_details.width <> (NewWidth - 2 * SIDESPACE ) or tab_contract_details.height <> (NewHeight - 2 * SIDESPACE) Then
		tab_contract_details.Resize(NewWidth - 2 * SIDESPACE, NewHeight - 2 * SIDESPACE)
	End If
end if

end event

event pfc_save;call super::pfc_save;//Added By Ken.Guo 2011-02-16.
If AncestorReturnValue = 0 Then
	If isvalid(m_pfe_cst_mdi_menu_contract) Then
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_file.m_save,'enabled', false)
	End If	
End If

Return AncestorReturnValue
end event

event deactivate;call super::deactivate;////Added By Ken.Guo 2011-05-05. Workaround Office OCX's bug
//If gs_imageview_version = '5.0' and isvalid(tab_contract_details.tabpage_images.tab_1.tabpage_data.inv_dm_comparison) Then
//	tab_contract_details.tabpage_images.tab_1.tabpage_data.tab_1.tabpage_preview.ole_doc.object.activate(false)
//End If


//---------Begin Added by (Appeon)Harry 12.17.2015 --------
// IntelliContract v14.2: Issues Encountered After Uploaded MS-Excel Workbook Is Opened In Document Manager Case#60518 Bug_id#4868 - 7
If isvalid(tab_contract_details.tabpage_images.tab_1.tabpage_data.inv_dm_comparison) and pos(lower(tab_contract_details.tabpage_images.tab_1.tabpage_data.is_doc_ext),'xls') > 0 Then
	tab_contract_details.tabpage_images.tab_1.tabpage_data.tab_1.tabpage_preview.ole_doc.object.activate(false)
End If
//---------End Added ------------------------------------------------------
end event

event hide;call super::hide;gnv_user_option.of_Save( ) // added by gavins 20120216
gnv_status_info.of_display("", '1')//added by gavins 20130410
end event

type cb_1 from commandbutton within w_contract
boolean visible = false
integer x = 1819
integer y = 2000
integer width = 411
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Create Database"
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
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  03 June 2005
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
FUNCTION long ShellExecuteA (long hwnd, string lpOperation, string lpFile, string lpParameters,  string lpDirectory, integer nShowCmd ) LIBRARY "SHELL32"
********************************************************************************************************************/

//nvo_commdlg lnvo
//
//lnvo.printdialog( )
//return 

//oleobject ws, loo_shortcut
//string ls_desktop
//
//ws = CREATE oleobject
//ws.ConnectToNewObject("WScript.Shell")
//
//// other "specialfolder" of interest
////  AllUsersDesktop
////  AllUsersStartMenu
////  AllUsersPrograms
////  AllUsersStartup
////  Desktop
////  Favorites
////  MyDocuments
////  Programs
////  Recent
////  SendTo
////  StartMenu
////  Startup
//ls_desktop = ws.SpecialFolders("Desktop")
//loo_shortcut = ws.CreateShortcut(ls_desktop +"\realhowto.lnk")
//loo_shortcut.TargetPath = "http://www.rgagnon.com/howto.html"
//loo_shortcut.WorkingDirectory = ls_desktop
//
//
//// 1 Activates and displays a window.
////   If the window is minimized or maximized, the system restores it to
////   its original size and position.
//// 3 Activates the window and displays it as a maximized window.
//// 7 Minimizes the window and activates the next top-level window.
//loo_shortcut.WindowStyle = 1
//
////oShortCut.IconLocation = "sWinSysDir\Shell32.dll,47"
////"%WINDIR%\SYSTEM\url.dll , 0"
//loo_shortcut.IconLocation = ws.ExpandEnvironmentStrings("C:\WINDOWS\system32\shell32.dll , 110")
//loo_shortcut.Save
//return 0
//
//
////OPEN(w_test_import)
//
//RETURN 
//

//long integers
//
//long ll_start, ll_used
//
//
//ll_start = Cpu()
//
//
//
//
//
//string is_docname,is_named
//long   ll_FileNum
//long   ll_return 
//blob   b_text_blob
//string ls_file_dump
//string is_file_names[]
//long ll_i
//CONSTANT STRING NEW_LINE = '~r~n'	
////string ls_file_path
//n_cst_string       lnv_string
//
//integer li_FileNum
//
//if GetFileOpenName("Select File For Import",  is_docname, is_named, "SQL", "PowerDesigner Sql File (*.sql),*.sql," ) = 1 then
//	
//end if 	
//
//blob lbl_data
//blob lbl_temp
//
//
//ll_FileNum = FileOpen(is_docname,StreamMode! )
//this.text = 'Reading file'
//DO WHILE FileRead ( ll_FileNum , lbl_temp) > 0
//  lbl_data += lbl_temp
//LOOP
//
//
//
//ls_file_dump = string(lbl_data)
//fileclose(ll_FileNum)	
//
//this.text = 'Parsing file'
//// msslnv_string.of_parsetoarray(ls_file_dump, ')', is_file_names)
//lnv_string.of_parsetoarray(ls_file_dump, ';', is_file_names)
////lnv_string.of_parsetoarray(ls_file_dump, '/', is_file_names)
//
//this.text = 'Remove non print ' + string(upperbound(is_file_names))	
//for ll_i = 1 to upperbound(is_file_names)
//	is_file_names[ll_i] = lnv_string.of_RemoveNonPrint ( is_file_names[ll_i] )
//	is_file_names[ll_i] = lnv_string.of_globalreplace( is_file_names[ll_i], 'end if', ' end if ', true)
//next
//
//
//
//li_FileNum = FileOpen("C:\sql.sql",StreamMode!, Write!, LockWrite!, REPLACE!)
//this.text = 'writing file ' 	
//FileWrite ( li_FileNum, "string  ls_sql_statments []" + NEW_LINE)
//FileWrite ( li_FileNum, "long  ll_i" + NEW_LINE)
//
//for ll_i = 1 to upperbound(is_file_names)
//	 this.text = 'writing file ' + string(ll_i) +' of ' + string(upperbound(is_file_names))	
//	 FileWrite ( li_FileNum, 'ls_sql_statments[upperbound(ls_sql_statments) + 1] = "' + is_file_names[ll_i]  + ' " '+ NEW_LINE)
//next
//
//
//FileWrite ( li_FileNum, "FOR ll_i = 1 TO upperbound(ls_sql_statments)" + NEW_LINE)
//FileWrite ( li_FileNum, "execute immediate :ls_sql_statments[LL_I] using sqlca;" + NEW_LINE)
//FileWrite ( li_FileNum, "IF len(sqlca.sqlerrtext) > 0 THEN " + NEW_LINE)
//FileWrite ( li_FileNum, "messagebox(string(LL_I), string(sqlca.sqlerrtext)  + new_line + error.object + new_line +    string(ls_sql_statments[LL_I]) + new_line + 'Please contact software vendor.' )"  + NEW_LINE )
//FileWrite ( li_FileNum, "END IF" + NEW_LINE)
//FileWrite ( li_FileNum, "NEXT" + NEW_LINE)
//
//FileClose ( li_FileNum )
//this.text = "DONE"
//
//
//string ls_Null
//SetNull(ls_Null)
//
//
//ShellExecuteA ( Handle( This ), "open", "C:\sql.sql", ls_Null, ls_Null, 1)
//
//ll_used = Cpu() - ll_start
//

string ls_sql_statments[]
ls_sql_statments[upperbound(ls_sql_statments) + 1] = " CREATE PROCEDURE sp_contract_search" + &
																		 " as " + &
																			 " BEGIN " + &
																				 " SELECT DISTINCT ctx_basic_info.app_facility,   " + &
																					 "	 ctx_basic_info.product_name,   " + &
																						 " ctx_basic_info.effective_date,   " + &
																						 " ctx_basic_info.expriation_date,   " + &
																						 "ctx_basic_info.status,   " + &
																						 "ctx_basic_info.group_multi_loc_id,   " + &
																						 "ctx_basic_info.ctx_id,   " + &
																						 "ctx_basic_info.category,    " + &
																						 "ctx_basic_info.facility_id,   " + &
																						 "ctx_basic_info.contract_type,   " + &
																						 "ctx_basic_info.product_type,   " + &
																						 "ctx_basic_info.reimbursment_menth,  " + & 
																						 "ctx_basic_info.file_location,   " + &
																						 "ctx_basic_info.review_date,   " + &
																						 "ctx_basic_info.review_by,   " + &
																						 "ctx_basic_info.term_date,   " + &
																						 "ctx_basic_info.term_reason,   " + &
																						 "ctx_basic_info.last_revis_date,   " + &
																						 "ctx_basic_info.other_date_1,   " + &
																						 "ctx_basic_info.other_date_2,   " + &
																						 "ctx_basic_info.oc_signed_by,   " + &
																						 "ctx_basic_info.oc_title,   " + &
																						 "ctx_basic_info.oc_department,   " + &
																						 "ctx_basic_info.oc_legal_rep,   " + &
																						 "ctx_basic_info.cc_signed_by,   " + &
																						 "ctx_basic_info.cc_title,   " + &
																						 "ctx_basic_info.cc_department,   " + &
																						 "ctx_basic_info.cc_legal_rep,   " + &
																						 "ctx_basic_info.notes,   " + &
																						 "ctx_basic_info.keyword,   " + &
																						 "ctx_basic_info.dvision,   " + &
																						 "ctx_basic_info.custom_1,   " + &
																						 "ctx_basic_info.custom_2,   " + &
																						 "ctx_basic_info.custom_3,   " + &
																						 "ctx_basic_info.custom_4,   " + &
																						 "ctx_basic_info.custom_5,   " + &
																						 "ctx_basic_info.custom_6,   " + &
																						 "ctx_basic_info.custom_7,   " + &
																						 "ctx_basic_info.custom_8,   " + &
																						 "ctx_basic_info.custom_9,   " + &
																						 "ctx_basic_info.custom_10,   " + &
																						 "ctx_basic_info.group_id,   " + &
																						 "ctx_basic_info.revision_reason, " + &  
																						 "ctx_basic_info.record_id ," + &
																						 "owner = upper((SELECT ctx_contacts.user_d " + &
																						 "				FROM ctx_contacts,ctx_contract_contacts" + &
																						 "				WHERE (ctx_contract_contacts.contact_id = ctx_contacts.contact_id ) and  " + &
																						 "						(ctx_contract_contacts.ctx_id = ctx_basic_info.ctx_id ) AND  " + &
																						 "						( ctx_contract_contacts.owner = 'Y' ) ))," + &
																					   "contracted_entity = (  SELECT top 1 group_multi_loc.rec_id  " + &
																							 "											FROM ctx_loc,   " + &
																							 "												group_multi_loc  " + &
																							 "											WHERE ( ctx_loc.parent_comp_id = group_multi_loc.rec_id ) and  " + &
																							 "													( ctx_loc.ctx_id = ctx_basic_info.ctx_id  ) AND  " + &
																							 "													ctx_loc.loc_id = 0    )" + &
																																 "FROM ctx_basic_info  " + &
																																					 "END"
		 long ll_i
		FOR ll_i = 1 TO upperbound(ls_sql_statments)
			if isvalid(w_infodisp) then w_infodisp.st_1.text = 'Modification:' +string(ll_i) +' of '+ string(upperbound(ls_sql_statments)) +' Please stand by!'
				 EXECUTE IMMEDIATE :ls_sql_statments[LL_I] using sqlca;
				 IF len(sqlca.sqlerrtext) > 0 THEN
			        messagebox(string(LL_I), string(sqlca.sqlerrtext)  + error.object  +    string(ls_sql_statments[LL_I]) +  "Please contact software vendor."   )
					else
				  commit;
					
				END IF
				if isvalid(w_infodisp) then w_infodisp.wf_step_pbar(1)
		NEXT
end event

event constructor;

//if handle(GetApplication ( )) = 0 then this.visible = true
end event

type tab_contract_details from u_tab_contract_details within w_contract
string tag = "Search for a contract."
integer width = 3936
integer height = 2152
integer taborder = 10
end type

