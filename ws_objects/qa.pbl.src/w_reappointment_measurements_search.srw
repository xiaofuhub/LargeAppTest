$PBExportHeader$w_reappointment_measurements_search.srw
$PBExportComments$The Reappointment Measurements search window
forward
global type w_reappointment_measurements_search from w_sheet
end type
type st_1 from statictext within w_reappointment_measurements_search
end type
type tab_qa from u_tab_quality within w_reappointment_measurements_search
end type
type tab_qa from u_tab_quality within w_reappointment_measurements_search
end type
end forward

global type w_reappointment_measurements_search from w_sheet
integer width = 3813
integer height = 2012
string title = "Quality Assurance"
long backcolor = 67108864
string icon = "Form!"
event pfc_cst_letter ( )
st_1 st_1
tab_qa tab_qa
end type
global w_reappointment_measurements_search w_reappointment_measurements_search

type prototypes
SUBROUTINE GetClientRect (ULONG hClntWnd, REF STR_CLIENT_RECT lpRect) LIBRARY "USER32.DLL" alias for "GetClientRect;Ansi" 
FUNCTION ulong SetCapture(ulong a) LIBRARY "user32.dll"
FUNCTION boolean ReleaseCapture() LIBRARY "user32.dll"
end prototypes

type variables
/***********************************************************************************************************
** [PUBLIC] INSTANCE VARIABLES
**--------------------------------------------------------------------------------------------------------------
** Author			 :	Michael Skinner 	Date: 		Wednesday November 10 2004
**--------------------------------------------------------------------------------------------------------------
** ModIFication Log:	
**
** Date            Who                   Change  	
**--------------------------------------------------------------------------------------------------------------
****************************************************************************************************************/




long il_header_id
long il_prac_id
userobject uo_quality_profile

end variables

forward prototypes
public function integer of_select_tab ()
public subroutine of_new ()
public subroutine of_delete ()
public function long of_save ()
public function long of_getheader_id ()
public subroutine of_setheader_id (long al_header_id)
public subroutine of_retrieve_measuremts ()
public subroutine of_retrieve_site_survey ()
public function long of_getprac_id ()
public function long of_get_zoom_value ()
public subroutine of_selecttab ()
public subroutine of_retrieve_case_review ()
public function long of_set_hdr_id (integer al_hdr_id)
public subroutine of_set_measurments_menu ()
public subroutine of_insert_action_item (string as_notes, long al_action_to)
public function integer of_get_current_prac ()
public function integer of_security ()
end prototypes

event pfc_cst_letter();/****************************************************************************************************************
** [PUBLIC] EVENT   w_reappointmet_measurements_seach::pfc_cst_letter( )
**--------------------------------------------------------------------------------------------------------------
** Description     :
**--------------------------------------------------------------------------------------------------------------
** Arguments		 :	[NONE] 
**--------------------------------------------------------------------------------------------------------------
** Returns			 :	[NONE]
**--------------------------------------------------------------------------------------------------------------
** Author/Date		 :	Michael B. Skinner/Wednesday , 17 November 2004 
**--------------------------------------------------------------------------------------------------------------
** ModIFication Log:	
**
** Date            Who                   Change  	
**--------------------------------------------------------------------------------------------------------------
****************************************************************************************************************/

// trigger the event on the tabpage
this.tab_qa.tabpage_quality_profile.uo_1.tab_measurements.tabpage_action_items.event pfc_cst_letter( )


end event

public function integer of_select_tab ();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : w_reappointment_tab::of_select_tab
//==================================================================================================================
//  Purpose   	: This function is used to select the detail tab. Trigger by a double click
//==================================================================================================================
//  Arguments 	: [none]  
//==================================================================================================================
//  Returns   	: [integer]      not used
//==================================================================================================================
//  Notes     	: 	
//==================================================================================================================
//  Created By	: Michael B. Skinner  Thursday  October 14, 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

this.tab_qa.tabpage_quality_profile.uo_1.tab_measurements.tabpage_detail.of_set_not_new( )
this.tab_qa.tabpage_quality_profile.uo_1.tab_measurements.selecttab(2)

return 1
end function

public subroutine of_new ();
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : OF_NEW
//==================================================================================================================
//  Purpose   	: 
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//=================================================================================================================
//  Notes     	: 
//==================================================================================================================
//  Created By	: Michael Skinner  Thursday  October 14, 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



this.tab_qa.tabpage_quality_profile.uo_1.tab_measurements.selecttab(2)
this.tab_qa.tabpage_quality_profile.uo_1.tab_measurements.tabpage_detail.dw_measuremt_header.event pfc_addrow( )






end subroutine

public subroutine of_delete ();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : OF_DELETE
//==================================================================================================================
//  Purpose   	: 
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	:     
//==================================================================================================================
//  Created By	: Michael Skinner  Thursday  October 14, 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

this.tab_qa.tabpage_quality_profile.uo_1.tab_measurements.tabpage_detail.of_set_delete( true)
THIS.OF_SElect_tab( )

this.tab_qa.tabpage_quality_profile.uo_1.tab_measurements.tabpage_detail.dw_measuremt_header.event pfc_deleterow( )
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<comment> 03.21.2006 By: Liang QingShi
//$<reason> Performance tuning
//$<modification> Comment out the following script since the previous script has already provided the same functionality.
/*
this.tab_qa.tabpage_quality_profile.uo_1.tab_measurements.tabpage_detail.of_set_delete(false)
*/
//---------------------------- APPEON END ----------------------------

end subroutine

public function long of_save ();/***********************************************************************************************************
** [PUBLIC] FUNCTION  w_reappointment_measurements_search::of_save
**--------------------------------------------------------------------------------------------------------------
** Description		 : 
**--------------------------------------------------------------------------------------------------------------
** Arguments		 :	NONE
**--------------------------------------------------------------------------------------------------------------
** Returns			 :	LONG
 **--------------------------------------------------------------------------------------------------------------
** Author			 :	Michael Skinner 	Date: 		Wednesday November 10 2004
**--------------------------------------------------------------------------------------------------------------
** ModIFication Log:	
**
** Date            Who                   Change  	
**--------------------------------------------------------------------------------------------------------------
****************************************************************************************************************/




return this.event pfc_save( )
end function

public function long of_getheader_id ();/****************************************************************************************************************
** [PUBLIC] EVENT   w_reappointment_measurements_search::of_getheader_id
**--------------------------------------------------------------------------------------------------------------
** Description		 : returns the header id
**--------------------------------------------------------------------------------------------------------------
** Arguments		 :	NONE
**--------------------------------------------------------------------------------------------------------------
** Returns			 :	(long) 
**--------------------------------------------------------------------------------------------------------------
** Author			 :	Michael Skinner 	Date: 		Wednesday November 10 2004
**--------------------------------------------------------------------------------------------------------------
** ModIFication Log:	
**
** Date            Who                   Change  	
**--------------------------------------------------------------------------------------------------------------
****************************************************************************************************************/





return il_header_id
end function

public subroutine of_setheader_id (long al_header_id);/***********************************************************************************************************
** [PUBLIC] FUNCTION  w_reappointment_measurements_search::of_setheader_id
**--------------------------------------------------------------------------------------------------------------
** Description		 : 
**--------------------------------------------------------------------------------------------------------------
** Arguments		 :	al_hdr_id [integer] HEADER ID
**--------------------------------------------------------------------------------------------------------------
** Returns			 :	NONE
 **--------------------------------------------------------------------------------------------------------------
** Author			 :	Michael Skinner 	Date: 		Wednesday November 10 2004
**--------------------------------------------------------------------------------------------------------------
** ModIFication Log:	
**
** Date            Who                   Change  	
**--------------------------------------------------------------------------------------------------------------
****************************************************************************************************************/



il_header_id = al_header_id

end subroutine

public subroutine of_retrieve_measuremts ();/***********************************************************************************************************
** [PUBLIC] EVENT   w_reappointment_measurements_search::of_retrieve_measuremts
**--------------------------------------------------------------------------------------------------------------
** Description		 : 
**--------------------------------------------------------------------------------------------------------------
** Arguments		 :	NONE
**--------------------------------------------------------------------------------------------------------------
** Returns			 :	(long) prac ID
 **--------------------------------------------------------------------------------------------------------------
** Author			 :	Michael Skinner 	Date: 		Wednesday November 10 2004
**--------------------------------------------------------------------------------------------------------------
** ModIFication Log:	
**
** Date            Who                   Change  	
**--------------------------------------------------------------------------------------------------------------
****************************************************************************************************************/

DATAWINDOW LDW_DW_SEARCH

LDW_DW_SEARCH = this.tab_qa.tabpage_search.uo_search.dw_search

if LDW_DW_SEARCH.rowcount() < 1 then return 

this.tab_qa.tabpage_quality_profile.uo_1.tab_measurements.tabpage_browse.of_set_prac_id( of_getprac_id() )
this.tab_qa.tabpage_quality_profile.uo_1.tab_measurements.tabpage_reports.dw_report.reset()
this.tab_qa.tabpage_quality_profile.uo_1.tab_measurements.tabpage_action_items.event ue_reset( )
this.tab_qa.tabpage_quality_profile.uo_1.tab_measurements.TABpage_detail.event ue_reset( )


this.tab_qa.tabpage_quality_profile.uo_1.tab_measurements.tabpage_detail.of_set_prac_id( of_getprac_id() )

////this.tab_qa.tabpage_quality_profile.uo_1.tab_measurements.tabpage_reports.of_set_facility_id(LDW_DW_SEARCH.object.PARENT_FACILITY_ID[LDW_DW_SEARCH.GETROW()])


//this.tab_qa.tabpage_quality_profile.uo_1.tab_measurements.selecttab( 1)

this.tab_qa.of_retrieve_measuremts( )

this.tab_qa.tabpage_quality_profile.uo_1.tab_measurements.selecttab( 1)
end subroutine

public subroutine of_retrieve_site_survey ();/***********************************************************************************************************
** [PUBLIC] FUNCTION  w_reappointment_measurements_search::of_retrieve_site_survey
**--------------------------------------------------------------------------------------------------------------
** Description		 : 
**--------------------------------------------------------------------------------------------------------------
** Arguments		 :	NONE
**--------------------------------------------------------------------------------------------------------------
** Returns			 :	
 **--------------------------------------------------------------------------------------------------------------
** Author			 :	Michael Skinner 	Date: 		Wednesday November 10 2004
**--------------------------------------------------------------------------------------------------------------
** ModIFication Log:	
**
** Date            Who                   Change  	
**--------------------------------------------------------------------------------------------------------------
****************************************************************************************************************/




this.tab_qa.of_retrieve_site_survey( )
end subroutine

public function long of_getprac_id ();/***********************************************************************************************************
** [PUBLIC] EVENT   w_reappointment_measurements_search::of_getprac_id
**--------------------------------------------------------------------------------------------------------------
** Description		 : returns the prac_id
**--------------------------------------------------------------------------------------------------------------
** Arguments		 :	NONE
**--------------------------------------------------------------------------------------------------------------
** Returns			 :	(long) prac ID
 **--------------------------------------------------------------------------------------------------------------
** Author			 :	Michael Skinner 	Date: 		Wednesday November 10 2004
**--------------------------------------------------------------------------------------------------------------
** ModIFication Log:	
**
** Date            Who                   Change  	
**--------------------------------------------------------------------------------------------------------------
****************************************************************************************************************/



if this.tab_qa.tabpage_search.uo_search.dw_search.rowcount( ) = 0 then
	return 0
end if
return this.tab_qa.tabpage_search.uo_search.dw_search.object.prac_id[this.tab_qa.tabpage_search.uo_search.dw_search.getrow() ]
end function

public function long of_get_zoom_value ();/***********************************************************************************************************
** [PUBLIC] EVENT   w_reappointment_measurements_search::of_get_zoom_value
**--------------------------------------------------------------------------------------------------------------
** Description		 : 
**--------------------------------------------------------------------------------------------------------------
** Arguments		 :	NONE
**--------------------------------------------------------------------------------------------------------------
** Returns			 :	(long) 
 **--------------------------------------------------------------------------------------------------------------
** Author			 :	Michael Skinner 	Date: 		Wednesday November 10 2004
**--------------------------------------------------------------------------------------------------------------
** ModIFication Log:	
**
** Date            Who                   Change  	
**--------------------------------------------------------------------------------------------------------------
****************************************************************************************************************/







return long(this.tab_qa.tabpage_quality_profile.uo_1.tab_measurements.tabpage_browse.dw_1.Object.DataWindow.Zoom)
end function

public subroutine of_selecttab ();/***********************************************************************************************************
** [PUBLIC] FUNCTION  w_reappointment_measurements_search::of_selecttab
**--------------------------------------------------------------------------------------------------------------
** Description		 : 
**--------------------------------------------------------------------------------------------------------------
** Arguments		 :	NONE
**--------------------------------------------------------------------------------------------------------------
** Returns			 :	LONG
 **--------------------------------------------------------------------------------------------------------------
** Author			 :	Michael Skinner 	Date: 		Wednesday November 10 2004
**--------------------------------------------------------------------------------------------------------------
** ModIFication Log:	
**
** Date            Who                   Change  	
**--------------------------------------------------------------------------------------------------------------
****************************************************************************************************************/

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.18.2006 By: LeiWei
//$<reason> Fix a defect.
//tab_qa.tabpage_quality_profile.visible = TRUE //Start Code Change ----02.29.2008 #V8 maha - removed because it breaks security
//---------------------------- APPEON END ----------------------------

//Start Code Change ----02.29.2008 #V8 maha - select tab based on security
If this.tab_qa.tabpage_quality_profile.visible = true then
	this.tab_qa.selecttab( 2)
elseif this.tab_qa.tabpage_site_survey.visible = true then
	this.tab_qa.selecttab( 3)
else
	this.tab_qa.selecttab( 4)
end if
//End Code Change---02.29.2008
end subroutine

public subroutine of_retrieve_case_review ();
/****************************************************************************************************************
** [PUBLIC] function w_reappointment_measurements_search::of_retrieve_case_review
**--------------------------------------------------------------------------------------------------------------
** Description:
**--------------------------------------------------------------------------------------------------------------
** Arguments: none
**--------------------------------------------------------------------------------------------------------------
** Returns:	(LONG) 
**--------------------------------------------------------------------------------------------------------------
** Author:	Michael Skinner 	Date: 		Wednesday November 10 2004
**--------------------------------------------------------------------------------------------------------------
** ModIFication Log:	
**
** Date            Who                   Change  	
**--------------------------------------------------------------------------------------------------------------
**
**
****************************************************************************************************************/

this.tab_qa.tabpage_case_review.uo_1.of_set_prac_id( il_prac_id)
this.tab_qa.of_retrive_case_review( )
end subroutine

public function long of_set_hdr_id (integer al_hdr_id);/***********************************************************************************************************
** [PUBLIC] FUNCTION  w_reappointment_measurements_search::of_set_hdr_id
**--------------------------------------------------------------------------------------------------------------
** Description		 : 
**--------------------------------------------------------------------------------------------------------------
** Arguments		 :	al_hdr_id [integer] HEADER ID
**--------------------------------------------------------------------------------------------------------------
** Returns			 :	LONG
 **--------------------------------------------------------------------------------------------------------------
** Author			 :	Michael Skinner 	Date: 		Wednesday November 10 2004
**--------------------------------------------------------------------------------------------------------------
** ModIFication Log:	
**
** Date            Who                   Change  	
**--------------------------------------------------------------------------------------------------------------
****************************************************************************************************************/



this.tab_qa.tabpage_quality_profile.uo_1.tab_measurements.tabpage_reports.of_set_hdr_id(al_hdr_id )
// added in case a profile is added for the first time, action items get the header id from the browse window
this.tab_qa.tabpage_quality_profile.uo_1.tab_measurements.tabpage_browse.of_set_header_id(al_hdr_id)



return 1
end function

public subroutine of_set_measurments_menu ();/****************************************************************************************************************
** [PUBLIC] FUNCTION    of_set_measurments_menu()
**--------------------------------------------------------------------------------------------------------------
** Description: CHANGE THE MENU THE ONE THAT IS REQUIRED FOR THE Quality Profile tab
**--------------------------------------------------------------------------------------------------------------
** Arguments:	[NONE]
**--------------------------------------------------------------------------------------------------------------
** Returns:	(NONE) 
**--------------------------------------------------------------------------------------------------------------
** Author:	Michael Skinner 	Date: 		Wednesday November 10 2004
**--------------------------------------------------------------------------------------------------------------
** ModIFication Log:	
**
** Date            Who                   Change  	
**--------------------------------------------------------------------------------------------------------------
**
****************************************************************************************************************/

	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> UM-01 
	//$<modify> 01.13.2006 By: Cao YongWang
	//$<reason> It is currently unsupported to use Changemenu in an expression.
	//$<modification> 1)Define a variable to store the return value of ChangeMenu;
	//$<modification> 2)Compare the variable to a value in the expression.

	//if w_mdi.changemenu(m_pfe_cst_mes) <> 1 then
	long ll_changeMenu
	If w_mdi.menuname <> 'm_pfe_cst_mes' Then
		ll_changeMenu = w_mdi.changemenu(m_pfe_cst_mes)
	ELSE
		ll_changeMenu = 1
	End If
	if ll_changeMenu <> 1 then
	//---------------------------- APPEON END ----------------------------
		of_messagebox( '', 'Menu Change', 'There is a menu change error in function of_set_measurments_menu()', information!, ok!, 1) 
		
	else 
			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 08.21.2006 By: LeiWei
			//$<reason> Fix a defect.
			w_mdi.of_menu_security( w_mdi.MenuName )
			//---------------------------- APPEON END ----------------------------

			// doc the toolbar at the end
			w_mdi.SetToolbarPos ( 2, 1, 200, False)
			
			//--------------------------- APPEON BEGIN ---------------------------
			//$<ID> UM-02
			//$<add> 01.13.2006 By: Rodger Wu
			//$<reason> The SetToolbarPos function is currently unsupported. 
			//$<modification> Replace the SetToolBarPos function with the Appeon defined function of_settoolbarpos to provide
			//$<modification> the same functionality.
			long ll_handle
			ll_handle = handle(w_mdi)
			gnv_appeondll.of_settoolbarpos(ll_handle)
			//---------------------------- APPEON END ----------------------------
									
			m_pfe_cst_data_entry.m_file.m_save.show ( )
			m_pfe_cst_data_entry.m_file.m_save.enable ( )
			// add
			m_pfe_cst_data_entry.m_edit.m_insert.show ( )
			m_pfe_cst_data_entry.m_edit.m_insert.enable ( )
			// delete
			m_pfe_cst_data_entry.m_edit.m_delete1.show ( )
			m_pfe_cst_data_entry.m_edit.m_delete1.enable ( )
			// printreport
			//m_pfe_cst_data_entry.m_edit.m_insert.toolbaritemvisible
			//---------Begin Modified by (Appeon)Harry 01.24.2014 for V142 ISG-CLX--------
			//m_pfe_cst_data_entry.m_file.m_dataentrycomplete.toolbaritemvisible = false
			gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_file.m_dataentrycomplete,'toolbaritemvisible', false)
			//---------End Modfiied ------------------------------------------------------
			m_pfe_cst_data_entry.m_view.m_nextpage.disable ( )
			//m_pfe_cst_data_entry.m_view.m_nextpage.enable ()
			m_pfe_cst_data_entry.m_view.m_lastpage.disable ( )
			m_pfe_cst_data_entry.m_view.m_priorpage.disable ( )
			
			//---------Begin Modified by (Appeon)Harry 01.24.2014 for V142 ISG-CLX--------
			/*
			m_pfe_cst_data_entry.m_view.m_nextpage.toolbaritemvisible = false
							
			//m_pfe_cst_data_entry.m_view.m_nextpage.enable ()
			m_pfe_cst_data_entry.m_view.m_lastpage.toolbaritemvisible = false
			m_pfe_cst_data_entry.m_view.m_priorpage.toolbaritemvisible = false
			m_pfe_cst_data_entry.m_view.m_notes.toolbaritemvisible = false
			m_pfe_cst_data_entry.m_file.m_multiapp.toolbaritemvisible = false
			m_pfe_cst_data_entry.m_edit.m_addverificationentry.toolbaritemvisible = false
			m_pfe_cst_data_entry.m_file.m_facilitydata.toolbaritemvisible = false
			m_pfe_cst_data_entry.m_edit.m_lookupsearch.toolbaritemvisible = false
			m_pfe_cst_mes.m_view.m_filter.enabled = false
			m_pfe_cst_mes.m_view.m_filter.toolbaritemvisible = false
			m_pfe_cst_mes.m_action.m_initiatereappointment.enabled = false
			m_pfe_cst_mes.m_action.m_initiatereappointment.toolbaritemvisible = false
			m_pfe_cst_mes.m_reports.m_applications.enabled = false 
			m_pfe_cst_mes.m_reports.m_applications.toolbaritemvisible = false
			m_pfe_cst_mes.m_action.m_generateletter.enabled = false
			m_pfe_cst_mes.m_action.m_generateletter.toolbaritemvisible = false
			*/
			gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_view.m_nextpage,'toolbaritemvisible', false)
							
			//m_pfe_cst_data_entry.m_view.m_nextpage.enable ()
			gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_view.m_lastpage,'toolbaritemvisible', false)
			gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_view.m_priorpage,'toolbaritemvisible', false)
			gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_view.m_notes,'toolbaritemvisible', false)
			gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_file.m_multiapp,'toolbaritemvisible', false)
			gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_edit.m_addverificationentry,'toolbaritemvisible', false)
			gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_file.m_facilitydata,'toolbaritemvisible', false)
			gnv_app.of_modify_menu_attr( m_pfe_cst_data_entry.m_edit.m_lookupsearch,'toolbaritemvisible', false)
			gnv_app.of_modify_menu_attr( m_pfe_cst_mes.m_view.m_filter,'enabled', false)
			gnv_app.of_modify_menu_attr( m_pfe_cst_mes.m_view.m_filter,'toolbaritemvisible', false)
			gnv_app.of_modify_menu_attr( m_pfe_cst_mes.m_action.m_initiatereappointment,'enabled', false)
			gnv_app.of_modify_menu_attr( m_pfe_cst_mes.m_action.m_initiatereappointment,'toolbaritemvisible', false)
			gnv_app.of_modify_menu_attr( m_pfe_cst_mes.m_reports.m_applications,'enabled', false) 
			gnv_app.of_modify_menu_attr( m_pfe_cst_mes.m_reports.m_applications,'toolbaritemvisible', false)
			gnv_app.of_modify_menu_attr( m_pfe_cst_mes.m_action.m_generateletter,'enabled', false)
			gnv_app.of_modify_menu_attr( m_pfe_cst_mes.m_action.m_generateletter,'toolbaritemvisible', false)
			//---------End Modfiied ------------------------------------------------------
			
	end if 
	

end subroutine

public subroutine of_insert_action_item (string as_notes, long al_action_to);//of_insert_action_item('Sent: ' + ls_doc_name)


this.tab_qa.tabpage_quality_profile.uo_1.tab_measurements.tabpage_action_items.of_insert_action_item(as_notes,al_action_to)
end subroutine

public function integer of_get_current_prac ();/******************************************************************************************************************
**  [PUBLIC]   : of_get_current_prac
**==================================================================================================================
**  Purpose   	: Retrives the current prac in the practitoner window
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 28 March 2005
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
long ll_e
	
if isvalid(w_prac_data_1) or isvalid(w_prac_data_intelliapp )  then
	If isvalid(w_prac_data_1) Then //Added By Ken.Guo 05.27.2008
		if w_prac_data_1.il_prac_id <> 0 and not isnull(w_prac_data_1.il_prac_id) then
			if messagebox(title,'Do you want to retrieve the current practitioner in the practitioner window?',Question!,yesno!,1) = 1 then
				setpointer(hourglass!)
					ll_e = w_prac_data_1.il_prac_id
					
					this.tab_qa.tabpage_search.uo_search.sle_srch_val.text = string(ll_e)
					this.tab_qa.tabpage_search.uo_search.ddlb_search_type.SelectItem ('I.D.',1 )
					this.tab_qa.tabpage_search.uo_search.cb_search.event clicked( )
					this.tab_qa.tabpage_search.uo_search.cb_select.event clicked( )
					//this.tab_qa.selecttab( 2)//Start Code Change ----02.29.2008 #V8 maha - removed because redundant
					
			end if
		end if
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 05/27/2008 By: Ken.Guo
	//$<reason> For IntelliApp
	ElseIf isvalid(w_prac_data_intelliapp) Then
		if w_prac_data_intelliapp.il_prac_id <> 0 and not isnull(w_prac_data_intelliapp.il_prac_id) then
			if messagebox(title,'Do you want to retrieve the current practitioner in the practitioner window?',Question!,yesno!,1) = 1 then
				setpointer(hourglass!)
					ll_e = w_prac_data_intelliapp.il_prac_id
					this.tab_qa.tabpage_search.uo_search.sle_srch_val.text = string(ll_e)
					this.tab_qa.tabpage_search.uo_search.ddlb_search_type.SelectItem ('I.D.',1 )
					this.tab_qa.tabpage_search.uo_search.cb_search.event clicked( )
					this.tab_qa.tabpage_search.uo_search.cb_select.event clicked( )
			end if
		end if	
	//---------------------------- APPEON END ----------------------------	
	End If
end if


return success
end function

public function integer of_security ();//maha app1005405 called from open event
//w_mdi.of_qa_peer_screen_security(this)
//if of_get_app_setting("set_qa","I") = 0 then
//	tab_qa.tabpage_quality_profile.visible = false
//end if
//
//if of_get_app_setting("set_site","I") = 0 then
//	tab_qa.tabpage_site_survey.visible = false
//end if
//
//if of_get_app_setting("set_peer","I") = 0 then
//	tab_qa.tabpage_case_review.visible = false
//end if

return 1
end function

on w_reappointment_measurements_search.create
int iCurrent
call super::create
this.st_1=create st_1
this.tab_qa=create tab_qa
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.tab_qa
end on

on w_reappointment_measurements_search.destroy
call super::destroy
destroy(this.st_1)
destroy(this.tab_qa)
end on

event close;call super::close;/****************************************************************************************************************
** [PUBLIC] EVENT   w_reappointment_measurements_search::close
**--------------------------------------------------------------------------------------------------------------
** Description		 : 
**--------------------------------------------------------------------------------------------------------------
** Arguments		 :	NONE
**--------------------------------------------------------------------------------------------------------------
** Returns			 :	(long) 
**--------------------------------------------------------------------------------------------------------------
** Author			 :	Michael Skinner 	Date: 		Wednesday November 10 2004
**--------------------------------------------------------------------------------------------------------------
** ModIFication Log:	
**
** Date            Who                   Change  	
**--------------------------------------------------------------------------------------------------------------
****************************************************************************************************************/



w_mdi.ChangeMenu(m_pfe_cst_mdi_menu)

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08.21.2006 By: LeiWei
//$<reason> Fix a defect.
w_mdi.of_menu_security( w_mdi.MenuName )
//---------------------------- APPEON END ----------------------------

end event

event pfc_endtran;call super::pfc_endtran;/****************************************************************************************************************
** [PUBLIC] EVENT   w_reappointment_measurements_search::pfc_endtran
**--------------------------------------------------------------------------------------------------------------
** Description		 : 
**--------------------------------------------------------------------------------------------------------------
** Arguments		 :	INTEGER [ai_update_results] -Upadte result flag
**--------------------------------------------------------------------------------------------------------------
** Returns			 :	(integer) 
**--------------------------------------------------------------------------------------------------------------
** Author			 :	Michael Skinner 	Date: 		Wednesday November 10 2004
**--------------------------------------------------------------------------------------------------------------
** ModIFication Log:	
**
** Date            Who                   Change  	
**--------------------------------------------------------------------------------------------------------------
****************************************************************************************************************/





choose case ai_update_results
	case success
		this.of_messagebox( this.title , this.title   , 'Update successful',information!, ok!, 1)
	case else
		this.of_messagebox( this.title , this.title   , 'Update failed',information!, ok!, 1)
end choose

return ai_update_results



end event

event pfc_preopen;/****************************************************************************************************************
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
// set up the rezize, we only need to register userobjects and non PFC objects. All pfc relared stuff will be handeled
// automatically
// NOTE:: DO NOT REGISTER TABS ONLY TAB PAGES !!!!!!!!!!!!!!!!!!!!!!!!!


setredraw(false)



Super::EVENT pfc_preopen( )

LONG LL_I
string ls_scale

powerobject lo_powerobjects[]

this.of_SetResize(TRUE)

this.inv_resize.of_SetOrigSize (this.workspacewidth( ) ,  this.workspaceheight( ) )

ls_scale = this.inv_resize.scale


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// The search user object
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

FOR LL_I =  1 TO UPPERBOUND(this.CONTrol)
   this.inv_resize.of_Register (this.CONTrol[LL_I]  , ls_scale	 )
NEXT
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<add> 01.18.2006 By: Cao YongWang
//$<reason> Performance tuning. 
//$<modification> Add a condition to ensure that inv_resize will not be executed, since
//$<modification> the execution of inv_resize negatively affects the performance very much
If appeongetclienttype() = 'WEB' Then return
//---------------------------- APPEON END ----------------------------
this.inv_resize.of_Register (this.tab_qa.tabpage_search.uo_search, ls_scale  )
FOR LL_I =  1 TO UPPERBOUND(this.tab_qa.tabpage_search.uo_search.CONTrol)
   this.inv_resize.of_Register (this.tab_qa.tabpage_search.uo_search.CONTrol[LL_I]  , ls_scale )
next


this.inv_resize.of_Register (this.tab_qa.tabpage_quality_profile.uo_1, ls_scale  )
FOR LL_I =  1 TO UPPERBOUND(this.tab_qa.tabpage_quality_profile.uo_1.CONTrol)
   this.inv_resize.of_Register (this.tab_qa.tabpage_quality_profile.uo_1.CONTrol[LL_I]  , ls_scale )
next



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// the site survey user object
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

this.inv_resize.of_Register (this.tab_qa.tabpage_site_survey.uo_1, ls_scale )
 for LL_I =  1 TO UPPERBOUND(this.tab_qa.tabpage_site_survey.uo_1.CONTrol)
   this.inv_resize.of_Register (this.tab_qa.tabpage_site_survey.uo_1.CONTrol[LL_I]  , ls_scale )
next

FOR LL_I =  1 TO UPPERBOUND(this.tab_qa.tabpage_site_survey.uo_1.tab_review.tabpage_browse.CONTrol)
   this.inv_resize.of_Register (this.tab_qa.tabpage_site_survey.uo_1.tab_review.tabpage_browse.CONTrol[LL_I]  , ls_scale )
next

FOR LL_I =  1 TO UPPERBOUND(this.tab_qa.tabpage_site_survey.uo_1.tab_review.tabpage_questions.CONTrol)
   this.inv_resize.of_Register (this.tab_qa.tabpage_site_survey.uo_1.tab_review.tabpage_questions.CONTrol[LL_I]  , ls_scale )
next

FOR LL_I =  1 TO UPPERBOUND(this.tab_qa.tabpage_site_survey.uo_1.tab_review.tabpage_setup.CONTrol)
   this.inv_resize.of_Register (this.tab_qa.tabpage_site_survey.uo_1.tab_review.tabpage_setup.CONTrol[LL_I]  , ls_scale )
next


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// the case review user object
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

this.inv_resize.of_Register (this.tab_qa.tabpage_case_review.uo_1 , ls_scale  )

FOR LL_I =  1 TO UPPERBOUND(this.tab_qa.tabpage_case_review.uo_1.CONTrol)
   this.inv_resize.of_Register (this.tab_qa.tabpage_case_review.uo_1.CONTrol[LL_I]  , ls_scale )
next

FOR LL_I =  1 TO UPPERBOUND(this.tab_qa.tabpage_case_review.uo_1.tab_1.tabpage_browse.CONTrol)
   this.inv_resize.of_Register (this.tab_qa.tabpage_case_review.uo_1.tab_1.tabpage_browse.CONTrol[LL_I]  , ls_scale )
next

FOR LL_I =  1 TO UPPERBOUND(this.tab_qa.tabpage_case_review.uo_1.tab_1.tabpage_detail.CONTrol)
   this.inv_resize.of_Register (this.tab_qa.tabpage_case_review.uo_1.tab_1.tabpage_detail.CONTrol[LL_I]  , ls_scale )
next

FOR LL_I =  1 TO UPPERBOUND(this.tab_qa.tabpage_case_review.uo_1.tab_1.tabpage_detail.tab_2.tabpage_ai.CONTrol)
   this.inv_resize.of_Register (this.tab_qa.tabpage_case_review.uo_1.tab_1.tabpage_detail.tab_2.tabpage_ai.CONTrol[LL_I]  , ls_scale )
next

//------------------- APPEON BEGIN -------------------
//$<modify> Evan 05.20.2009
//$<reason> Corrected BugN1215001
/*
FOR LL_I =  1 TO UPPERBOUND(this.tab_qa.tabpage_case_review.uo_1.tab_1.tabpage_detail.tab_2.tabpage_case_detail.CONTrol)
   this.inv_resize.of_Register (this.tab_qa.tabpage_case_review.uo_1.tab_1.tabpage_detail.tab_2.tabpage_case_detail.CONTrol[LL_I]  , ls_scale )
next
*/
this.inv_resize.of_Register(this.tab_qa.tabpage_case_review.uo_1.tab_1.tabpage_detail.tab_2.tabpage_case_detail.dw_detail, ls_Scale)
//------------------- APPEON END ---------------------

///////////////////////////////////////////////
// assign user objects
//////////////////////////////////////////////

uo_quality_profile = this.tab_qa.tabpage_quality_profile.uo_1


end event

event pfc_postopen;call super::pfc_postopen;
of_get_current_prac( )
setpointer(arrow!)
setredraw(true)

end event

event open;call super::open;//maha app1005405

of_security()

end event

type st_1 from statictext within w_reappointment_measurements_search
integer x = 114
integer y = 536
integer width = 2619
integer height = 300
integer textsize = -24
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "No longer used renamed w_qa_peer_..."
boolean focusrectangle = false
end type

type tab_qa from u_tab_quality within w_reappointment_measurements_search
integer height = 1888
integer taborder = 11
end type

event constructor;call super::constructor;this.of_setresize( true)
end event

event selectionchanged;
/****************************************************************************************************************
** [PUBLIC] EVENT   selectionchanged :: tab_qa
**--------------------------------------------------------------------------------------------------------------
** Description:
**--------------------------------------------------------------------------------------------------------------
** Arguments:	[long] oldindex
**				   [long] newindex
**
**--------------------------------------------------------------------------------------------------------------
** Returns:	(LONG) 
**--------------------------------------------------------------------------------------------------------------
** Author:	Michael Skinner 	Date: 		Wednesday November 10 2004
**--------------------------------------------------------------------------------------------------------------
** ModIFication Log:	
**
** Date            Who                   Change  	
**--------------------------------------------------------------------------------------------------------------
**
**
****************************************************************************************************************/


//////////  OVERRIDE!!!!!

//iw_parent.dynamic of_accepttext( true)
//if iw_parent.function dynamic of_validation( ) <> 1 then 
//	return  // prevent close
//end if
//


if oldindex < 1 or newindex < 1 then return 

iw_parent.setredraw( false)
CHOOSE CASE NEWIndex
	CASE 1
		if w_mdi.MenuName	<> 'm_pfe_cst_mdi_menu' then
			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 08.21.2006 By: LeiWei
			//$<reason> Fix a defect.
			/*
			 w_mdi.ChangeMenu(m_pfe_cst_mdi_menu)
			*/
			If w_mdi.menuname <> 'm_pfe_cst_mdi_menu' Then w_mdi.ChangeMenu( m_pfe_cst_mdi_menu )
			w_mdi.of_menu_security( w_mdi.MenuName )
			//---------------------------- APPEON END ----------------------------

	   end if 	
	CASE 2
		//save
		parent.of_set_measurments_menu( )
	CASE ELSE
		if w_mdi.MenuName	<> 'm_pfe_cst_mdi_menu' then
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 08.21.2006 By: LeiWei
		//$<reason> Fix a defect.
		/*
		w_mdi.ChangeMenu(m_pfe_cst_mdi_menu)
		*/
		If w_mdi.menuname <> 'm_pfe_cst_mdi_menu' Then w_mdi.ChangeMenu( m_pfe_cst_mdi_menu )
		w_mdi.of_menu_security( w_mdi.MenuName )
		//---------------------------- APPEON END ----------------------------
	end if 
END CHOOSE


//if newindex > oldindex then
//if il_prac_id = 0  then
//	this.of_messagebox( '',iw_parent.title , 'Please select a practitioner before continuing.', information!, ok!, 1)
//	return 1
//end if 
//
//end if 
//


iw_parent.setredraw( true)



end event

event selectionchanging;/****************************************************************************************************************
** [PUBLIC] EVENT  selectionchanged 
**--------------------------------------------------------------------------------------------------------------
** Description    :
**--------------------------------------------------------------------------------------------------------------
** Arguments	   :	[NONE] 
**--------------------------------------------------------------------------------------------------------------
** Returns		   :	[NONE]
**--------------------------------------------------------------------------------------------------------------
** Author/Date    :	Michael B. Skinner / Wednesday , 17 November 2004 
**--------------------------------------------------------------------------------------------------------------
** ModIFication Log:	
**
** Date            Who                   Change  	
**--------------------------------------------------------------------------------------------------------------
**
**
****************************************************************************************************************/


//////////  OVERRIDE!!!!!

iw_parent.setredraw( false)

///iw_parent.dynamic of_accepttext( true)
if iw_parent.function dynamic of_validation( ) <> 1 then 
	iw_parent.setredraw( true)
	return 1 // prevent close
end if



/////////////////////////////////////////////////////////////////
// make sure we have a prac before changing tabs
/////////////////////////////////////////////////////////////////


if newindex > 1 then
	if of_getprac_id( ) = 0 then
		of_messagebox( '', iw_parent.title, 'Please select a practitioner.',information!, ok!, 1)
		iw_parent.setredraw( true)
		return 1 // prevent close
	end if
end if

iw_parent.setredraw( true)

end event

