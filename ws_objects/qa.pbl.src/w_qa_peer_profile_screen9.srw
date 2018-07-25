$PBExportHeader$w_qa_peer_profile_screen9.srw
$PBExportComments$The Reappointment Measurements search window
forward
global type w_qa_peer_profile_screen9 from w_sheet
end type
type cb_1 from commandbutton within w_qa_peer_profile_screen9
end type
type tab_qa from pfc_cst_qa_peer_profile within w_qa_peer_profile_screen9
end type
type tab_qa from pfc_cst_qa_peer_profile within w_qa_peer_profile_screen9
end type
end forward

global type w_qa_peer_profile_screen9 from w_sheet
string tag = "Quality Profiles"
integer width = 3813
integer height = 2012
string title = "Quality Profiles"
long backcolor = 67108864
string icon = "Form!"
event pfc_cst_letter ( )
event pfc_cst_run_report ( )
event pfc_cst_filter ( )
event pfc_cst_print_report ( )
cb_1 cb_1
tab_qa tab_qa
end type
global w_qa_peer_profile_screen9 w_qa_peer_profile_screen9

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
string is_window_title//Added by  Nova 02.23.2010
end variables

forward prototypes
public function integer of_select_tab ()
public subroutine of_new ()
public subroutine of_delete ()
public function long of_save ()
public function long of_getheader_id ()
public subroutine of_setheader_id (long al_header_id)
public subroutine of_retrieve_site_survey ()
public function long of_getprac_id ()
public function long of_get_zoom_value ()
public subroutine of_selecttab ()
public function long of_set_hdr_id (integer al_hdr_id)
public subroutine of_set_measurments_menu ()
public subroutine of_insert_action_item (string as_notes, long al_action_to)
public function integer of_get_current_prac ()
public function integer of_security ()
public subroutine of_retrieve_oppe (long al_prac, long al_facil)
public subroutine of_retrieve_measuremts (long al_facility_id)
public subroutine of_retrieve_priv (long al_prac_id, long al_faci)
public subroutine of_run_report (long al_prac_id, long al_facility_id, long al_view_id)
public subroutine of_set_profile_menu ()
public subroutine of_retrieve_case_review (long al_prac_id, long al_facility_id)
public subroutine of_setup_title_search ()
public subroutine of_set_caseview_menu ()
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
IF tab_qa.SelectedTab = 2 THEN
//	This.tab_qa.tabpage_quality_profile.uo_qa.tab_measurements.tabpage_action_items.Event pfc_cst_letter( )
ELSEIF tab_qa.SelectedTab = 4 THEN//Added by  Nova 02.24.2010
	This.tab_qa.tabpage_case_review.uo_case.Event pfc_cst_letter( )
END IF



end event

event pfc_cst_run_report();//Added by  Nova 12.05.2009 --v10.1 Profiles Build out
IF This.tab_qa.tabpage_profile.uo_profile.il_facility_id = 0 Or This.tab_qa.tabpage_profile.uo_profile.il_prac_id = 0 THEN RETURN
This.tab_qa.tabpage_profile.uo_profile.of_Run_Report()


end event

event pfc_cst_filter();//Added by  Nova 02.24.2010
tab_qa.tabpage_case_review.uo_case.event pfc_cst_filter( )
end event

event pfc_cst_print_report();//Added by  Nova 02.24.2010
if tab_qa.selectedtab=4 then
	tab_qa.tabpage_case_review.uo_case.event pfc_cst_print_report( )
elseif tab_qa.selectedtab=6 then //Added by  Nova 03.23.2010 fixed BugE031901	(PB&WEB P3 Nova)
	This.tab_qa.tabpage_profile.uo_profile.of_print_report( )
end if	
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

//this.tab_qa.tabpage_quality_profile.uo_qa.tab_measurments.tabpage_detail.of_set_not_new( )
this.tab_qa.tabpage_quality_profile.uo_qa.tab_measurments.selecttab(2)

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



this.tab_qa.tabpage_quality_profile.uo_qa.tab_measurments.selecttab(2)
//this.tab_qa.tabpage_quality_profile.uo_qa.tab_measurments.tabpage_detail.dw_measuremt_header.event pfc_addrow( )






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

//this.tab_qa.tabpage_quality_profile.uo_qa.tab_measurments.tabpage_detail.of_set_delete( true)
THIS.OF_SElect_tab( )

//this.tab_qa.tabpage_quality_profile.uo_qa.tab_measurments.tabpage_detail.dw_measuremt_header.event pfc_deleterow( )
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



if this.tab_qa.tabpage_site_survey.visible=false then return//Added by  Nova 12.04.2009 --v10.1 Profiles Build out
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







return long(this.tab_qa.tabpage_quality_profile.uo_qa.tab_measurments.tabpage_browse.dw_browse.Object.DataWindow.Zoom)
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
IF This.tab_qa.tabpage_quality_profile.Visible = True THEN
	This.tab_qa.SelectTab( 2)
ELSEIF This.tab_qa.tabpage_site_survey.Visible = True THEN
	This.tab_qa.SelectTab( 3)
//Added by  Nova 12.04.2009 --v10.1 Profiles Build out	
ELSEIF This.tab_qa.tabpage_case_review.Visible = True THEN
	This.tab_qa.SelectTab( 4)
ELSEIF This.tab_qa.tabpage_oppe.Visible = True THEN
	This.tab_qa.SelectTab( 5)
ELSEIF This.tab_qa.tabpage_profile.Visible = True THEN
	This.tab_qa.SelectTab( 6)
//ELSEIF This.tab_qa.tabpage_priv.Visible = True THEN
//	This.tab_qa.SelectTab( 7)
END IF
//End Code Change---02.29.2008

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



//this.tab_qa.tabpage_quality_profile.uo_1.tab_measurements.tabpage_reports.of_set_hdr_id(al_hdr_id )
// added in case a profile is added for the first time, action items get the header id from the browse window
//this.tab_qa.tabpage_quality_profile.uo_1.tab_measurements.tabpage_browse.of_set_header_id(al_hdr_id)



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
			m_pfe_cst_data_entry.m_file.m_dataentrycomplete.toolbaritemvisible = false
			m_pfe_cst_data_entry.m_view.m_nextpage.disable ( )
			//m_pfe_cst_data_entry.m_view.m_nextpage.enable ()
			m_pfe_cst_data_entry.m_view.m_lastpage.disable ( )
			m_pfe_cst_data_entry.m_view.m_priorpage.disable ( )
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
			
	end if 
	

end subroutine

public subroutine of_insert_action_item (string as_notes, long al_action_to);//of_insert_action_item('Sent: ' + ls_doc_name)


//this.tab_qa.tabpage_quality_profile.uo_qa.tab_measurments.tabpage_action_items.of_insert_action_item(as_notes,al_action_to)
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
long ll_facility_id
w_prac_data_1 lw_prac_window //maha 0903.09

//Start Code Change ----09.03.2009 #V92 maha - simplified code and added facility filter when opening for current prac
if isvalid(w_prac_data_1) then
	lw_prac_window = w_prac_data_1
elseif isvalid(w_prac_data_intelliapp ) then
	lw_prac_window = w_prac_data_intelliapp
end if

this.tab_qa.tabpage_search.uo_search.of_set_open_for( "PROFILE" )  //Start Code Change ----09.11.2009 #V92 maha
	
if isvalid(w_prac_data_1) or isvalid(w_prac_data_intelliapp )  then
	//If isvalid(w_prac_data_1) Then //Added By Ken.Guo 05.27.2008
		if lw_prac_window.il_prac_id <> 0 and not isnull(lw_prac_window.il_prac_id) then 
			if messagebox(title,'Do you want to retrieve the current practitioner in the practitioner window?',Question!,yesno!,1) = 1 then
				ll_facility_id = lw_prac_window.ii_parent_facility_id  //09.03.2009 #V92 maha 
				setpointer(hourglass!)
					ll_e = lw_prac_window.il_prac_id
					this.tab_qa.tabpage_search.uo_search.dw_org_facility_select.SetItem( 1, "facility_id", ll_facility_id )	//09.03.2009 #V92 maha 
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
//	ElseIf isvalid(w_prac_data_intelliapp) Then
//		if w_prac_data_intelliapp.il_prac_id <> 0 and not isnull(w_prac_data_intelliapp.il_prac_id) then
//			if messagebox(title,'Do you want to retrieve the current practitioner in the practitioner window?',Question!,yesno!,1) = 1 then
//				setpointer(hourglass!)
//					ll_e = w_prac_data_intelliapp.il_prac_id
//					this.tab_qa.tabpage_search.uo_search.sle_srch_val.text = string(ll_e)
//					this.tab_qa.tabpage_search.uo_search.ddlb_search_type.SelectItem ('I.D.',1 )
//					this.tab_qa.tabpage_search.uo_search.cb_search.event clicked( )
//					this.tab_qa.tabpage_search.uo_search.cb_select.event clicked( )
//			end if
//		end if	
//	//---------------------------- APPEON END ----------------------------	
//	End If
end if
//End Code Change---09.03.2009



//ll_facility_id = set to user default facility
//this.tab_qa.tabpage_search.uo_search.dw_org_facility_select.SetItem( 1, "facility_id", ll_facility_id )	


return success
end function

public function integer of_security ();//maha app1005405 called from open event
this.tab_qa.tabpage_oppe.uo_oppe.of_setup(0,0)  //Start Code Change ----12.03.2009 #V92 maha - added to resolve appl error for read only users
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

public subroutine of_retrieve_oppe (long al_prac, long al_facil);IF This.tab_qa.tabpage_oppe.Visible = False THEN RETURN //Added by  Nova 12.04.2009 --v10.1 Profiles Build out
datawindow ldw_dw_1

ldw_dw_1 = This.tab_qa.tabpage_oppe.uo_oppe.tab_1.tabpage_1.dw_browse
This.tab_qa.tabpage_oppe.uo_oppe.of_setup( al_prac, al_facil)
IF ldw_dw_1.RowCount() > 0 THEN
	This.tab_qa.tabpage_oppe.Text = This.tab_qa.tabpage_oppe.uo_oppe.Tag + ' (' + String(ldw_dw_1.RowCount()) + ")"
ELSE
	This.tab_qa.tabpage_oppe.Text = This.tab_qa.tabpage_oppe.uo_oppe.Tag
END IF



end subroutine

public subroutine of_retrieve_measuremts (long al_facility_id);/***********************************************************************************************************
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
IF this.tab_qa.tabpage_quality_profile.Visible = False THEN RETURN//Added by  Nova 12.04.2009 --v10.1 Profiles Build out

DATAWINDOW LDW_DW_SEARCH

LDW_DW_SEARCH = this.tab_qa.tabpage_search.uo_search.dw_search

if LDW_DW_SEARCH.rowcount() < 1 then return 
//@@rebuild
//this.tab_qa.tabpage_quality_profile.uo_qa.tab_measurments.tabpage_browse.of_set_prac_id( of_getprac_id() )
//this.tab_qa.tabpage_quality_profile.uo_qa.tab_measurments.tabpage_browse.il_facility_id = al_facility_id ////Start Code Change ----09.11.2009 #V92 maha
//this.tab_qa.tabpage_quality_profile.uo_qa.tab_measurments.tabpage_reports.dw_report.reset()
//this.tab_qa.tabpage_quality_profile.uo_qa.tab_measurments.tabpage_action_items.event ue_reset( )
//this.tab_qa.tabpage_quality_profile.uo_qa.tab_measurments.TABpage_detail.event ue_reset( )


//this.tab_qa.tabpage_quality_profile.uo_1.tab_measurements.tabpage_detail.of_set_prac_id( of_getprac_id() )

////this.tab_qa.tabpage_quality_profile.uo_1.tab_measurements.tabpage_reports.of_set_facility_id(LDW_DW_SEARCH.object.PARENT_FACILITY_ID[LDW_DW_SEARCH.GETROW()])


//this.tab_qa.tabpage_quality_profile.uo_1.tab_measurements.selecttab( 1)

//this.tab_qa.of_retrieve_measuremts( )

//this.tab_qa.tabpage_quality_profile.uo_1.tab_measurements.selecttab( 1)
end subroutine

public subroutine of_retrieve_priv (long al_prac_id, long al_faci);//Added by  Nova 12.04.2009 --v10.1 Profiles Build out
IF This.tab_qa.tabpage_priv.Visible = False THEN RETURN
datawindow ldw_dw_1
ldw_dw_1 = This.tab_qa.tabpage_priv.uo_priv.dw_priv
This.tab_qa.tabpage_priv.uo_priv.of_retrieve(al_prac_id,al_faci)
IF ldw_dw_1.RowCount() > 0 THEN
	This.tab_qa.tabpage_priv.Text = This.tab_qa.tabpage_priv.uo_priv.Tag + ' (' + String(ldw_dw_1.RowCount()) + ")"
ELSE
	This.tab_qa.tabpage_priv.Text = This.tab_qa.tabpage_priv.uo_priv.Tag
END IF

end subroutine

public subroutine of_run_report (long al_prac_id, long al_facility_id, long al_view_id);//Added by  Nova 12.04.2009 --v10.1 Profiles Build out
IF This.tab_qa.tabpage_profile.Visible = False THEN RETURN
This.tab_qa.tabpage_profile.uo_profile.of_set_up( al_prac_id, al_facility_id,al_view_id)

end subroutine

public subroutine of_set_profile_menu ();//Added by  Nova 12.05.2009 --v10.1 Profiles Build out
Long ll_changeMenu
Long ll_handle
IF w_mdi.MenuName <> 'm_pfe_cst_profile' THEN
	ll_changeMenu = w_mdi.ChangeMenu(m_pfe_cst_profile)
ELSE
	ll_changeMenu = 1
END IF
IF ll_changeMenu <> 1 THEN
	of_messagebox( '', 'Menu Change', 'There is a menu change error in function of_set_measurments_menu()', information!, ok!, 1)
ELSE
	w_mdi.of_menu_security( w_mdi.MenuName )
	// doc the toolbar at the end
	w_mdi.SetToolbarPos ( 2, 1, 200, False)
	ll_handle = Handle(w_mdi)
	gnv_appeondll.of_settoolbarpos(ll_handle)
	//Added by  Nova 03.23.2010 fixed BugE031901	(PB&WEB P3 Nova)
	//	m_pfe_cst_profile.m_file.m_print.Visible = False
	//	m_pfe_cst_profile.m_file.m_print.ToolbarItemVisible = False
END IF


end subroutine

public subroutine of_retrieve_case_review (long al_prac_id, long al_facility_id);
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

IF This.tab_qa.tabpage_case_review.Visible = False THEN RETURN//Added by  Nova 12.04.2009 --v10.1 Profiles Build out
this.tab_qa.tabpage_case_review.uo_case.of_set_prac_id( al_prac_id)
//Added by  Nova 12.08.2009 --v10.1 Profiles Build out
this.tab_qa.tabpage_case_review.uo_case.of_set_facility_id(al_facility_id)
this.tab_qa.of_retrive_case_review( )

end subroutine

public subroutine of_setup_title_search ();//Added by  Nova 02.23.2010
String ls_name
String ls_facility_name
Integer li_parent_facility_id,li_prac_id

li_parent_facility_id = tab_qa.tabpage_search.uo_search.dw_search.getitemnumber(tab_qa.tabpage_search.uo_search.dw_search.getrow(),'parent_facility_id')
li_prac_id = tab_qa.tabpage_search.uo_search.dw_search.getitemnumber(tab_qa.tabpage_search.uo_search.dw_search.getrow(),'prac_id')

nv_prac_info lnv_full_name
lnv_full_name = CREATE nv_prac_info
ls_name = lnv_full_name.of_get_name( li_prac_id )
if isnull(ls_name) then ls_name = ''
DESTROY lnv_full_name	
SELECT facility.facility_name  
INTO :ls_facility_name  
FROM facility  
WHERE facility.facility_id = :li_parent_facility_id   ;
	
this.Title =is_window_title+'   Practitioner : '+ ls_name + " - " + String( li_prac_id ) + "  (" + ls_facility_name + ")"

end subroutine

public subroutine of_set_caseview_menu ();//Added by  Nova 12.05.2009 --v10.1 Profiles Build out
Long ll_changeMenu
Long ll_handle
IF w_mdi.MenuName <> 'm_pfe_cst_qa' THEN
	ll_changeMenu = w_mdi.ChangeMenu(m_pfe_cst_qa)
ELSE
	ll_changeMenu = 1
END IF
IF ll_changeMenu <> 1 THEN
	of_messagebox( '', 'Menu Change', 'There is a menu change error in function of_set_measurments_menu()', information!, ok!, 1)
ELSE
	w_mdi.of_menu_security( w_mdi.MenuName )
	// doc the toolbar at the end
	w_mdi.SetToolbarPos ( 2, 1, 200, False)
	ll_handle = Handle(w_mdi)
	gnv_appeondll.of_settoolbarpos(ll_handle)
//	m_pfe_cst_profile.m_file.m_print.Visible = False
//	m_pfe_cst_profile.m_file.m_print.ToolbarItemVisible = False
END IF

end subroutine

on w_qa_peer_profile_screen9.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.tab_qa=create tab_qa
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.tab_qa
end on

on w_qa_peer_profile_screen9.destroy
call super::destroy
destroy(this.cb_1)
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
//Added by  Nova 12.10.2009 --fixed a bug.
if isvalid(w_case_review_filter) then close(w_case_review_filter)

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

//this.inv_resize.of_setminsize( this.workspacewidth( ) , this.WorkSpaceHeight()	)//For Resize  Added by  Nova 02.11.2010
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
//If appeongetclienttype() = 'WEB' Then return//fixed BugE032201	(WEB P3 Nova)  Added by  Nova 03.23.2010
//---------------------------- APPEON END ----------------------------
this.inv_resize.of_Register (this.tab_qa.tabpage_search.uo_search, ls_scale  )
FOR LL_I =  1 TO UPPERBOUND(this.tab_qa.tabpage_search.uo_search.CONTrol)
   this.inv_resize.of_Register (this.tab_qa.tabpage_search.uo_search.CONTrol[LL_I]  , ls_scale )
next


this.inv_resize.of_Register (this.tab_qa.tabpage_quality_profile.uo_qa, ls_scale  )
FOR LL_I =  1 TO UPPERBOUND(this.tab_qa.tabpage_quality_profile.uo_qa.CONTrol)
   this.inv_resize.of_Register (this.tab_qa.tabpage_quality_profile.uo_qa.CONTrol[LL_I]  , ls_scale )
next



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// the site survey user object
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

this.inv_resize.of_Register (this.tab_qa.tabpage_site_survey.uo_5, ls_scale )
 for LL_I =  1 TO UPPERBOUND(this.tab_qa.tabpage_site_survey.uo_5.CONTrol)
   this.inv_resize.of_Register (this.tab_qa.tabpage_site_survey.uo_5.CONTrol[LL_I]  , ls_scale )
next

FOR LL_I =  1 TO UPPERBOUND(this.tab_qa.tabpage_site_survey.uo_5.tab_review.tabpage_browse.CONTrol)
   this.inv_resize.of_Register (this.tab_qa.tabpage_site_survey.uo_5.tab_review.tabpage_browse.CONTrol[LL_I]  , ls_scale )
next

FOR LL_I =  1 TO UPPERBOUND(this.tab_qa.tabpage_site_survey.uo_5.tab_review.tabpage_questions.CONTrol)
   this.inv_resize.of_Register (this.tab_qa.tabpage_site_survey.uo_5.tab_review.tabpage_questions.CONTrol[LL_I]  , ls_scale )
next

FOR LL_I =  1 TO UPPERBOUND(this.tab_qa.tabpage_site_survey.uo_5.tab_review.tabpage_setup.CONTrol)
   this.inv_resize.of_Register (this.tab_qa.tabpage_site_survey.uo_5.tab_review.tabpage_setup.CONTrol[LL_I]  , ls_scale )
next


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// the case review user object
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

this.inv_resize.of_Register (this.tab_qa.tabpage_case_review.uo_case , ls_scale  )

FOR LL_I =  1 TO UPPERBOUND(this.tab_qa.tabpage_case_review.uo_case.CONTrol)
   this.inv_resize.of_Register (this.tab_qa.tabpage_case_review.uo_case.CONTrol[LL_I]  , ls_scale )
next

FOR LL_I =  1 TO UPPERBOUND(this.tab_qa.tabpage_case_review.uo_case.tab_1.tabpage_browse.CONTrol)
   this.inv_resize.of_Register (this.tab_qa.tabpage_case_review.uo_case.tab_1.tabpage_browse.CONTrol[LL_I]  , ls_scale )
next

FOR LL_I =  1 TO UPPERBOUND(this.tab_qa.tabpage_case_review.uo_case.tab_1.tabpage_detail.CONTrol)
   this.inv_resize.of_Register (this.tab_qa.tabpage_case_review.uo_case.tab_1.tabpage_detail.CONTrol[LL_I]  , ls_scale )
next

FOR LL_I =  1 TO UPPERBOUND(this.tab_qa.tabpage_case_review.uo_case.tab_1.tabpage_detail.tab_2.tabpage_ai.CONTrol)
   this.inv_resize.of_Register (this.tab_qa.tabpage_case_review.uo_case.tab_1.tabpage_detail.tab_2.tabpage_ai.CONTrol[LL_I]  , ls_scale )
next

//------------------- APPEON BEGIN -------------------
//$<modify> Evan 05.20.2009
//$<reason> Corrected BugN1215001
/*
FOR LL_I =  1 TO UPPERBOUND(this.tab_qa.tabpage_case_review.uo_1.tab_1.tabpage_detail.tab_2.tabpage_case_detail.CONTrol)
   this.inv_resize.of_Register (this.tab_qa.tabpage_case_review.uo_1.tab_1.tabpage_detail.tab_2.tabpage_case_detail.CONTrol[LL_I]  , ls_scale )
next
*/
this.inv_resize.of_Register(this.tab_qa.tabpage_case_review.uo_case.tab_1.tabpage_detail.tab_2.tabpage_case_detail.dw_detail, ls_Scale)
//dw_physicians  For resize  Added by  Nova 02.12.2010
this.inv_resize.of_Register(this.tab_qa.tabpage_case_review.uo_case.tab_1.tabpage_detail.tab_2.tabpage_case_detail.dw_physicians , ls_Scale)

//------------------- APPEON END ---------------------
//priv  For resize  Added by  Nova 02.12.2010
this.inv_resize.of_Register (this.tab_qa.tabpage_priv.uo_priv , ls_scale  )

FOR LL_I =  1 TO UPPERBOUND(this.tab_qa.tabpage_priv.uo_priv.CONTrol)
   this.inv_resize.of_Register (this.tab_qa.tabpage_priv.uo_priv.CONTrol[LL_I]  , ls_scale )
next

//profile  For resize  Added by  Nova 02.12.2010
this.inv_resize.of_Register (this.tab_qa.tabpage_profile.uo_profile , ls_scale  )

FOR LL_I =  1 TO UPPERBOUND(this.tab_qa.tabpage_profile.uo_profile.CONTrol)
   this.inv_resize.of_Register (this.tab_qa.tabpage_profile.uo_profile.CONTrol[LL_I]  , ls_scale )
next

FOR LL_I =  1 TO UPPERBOUND(this.tab_qa.tabpage_profile.uo_profile.tab_report.tabpage_profile.CONTrol)
   this.inv_resize.of_Register (this.tab_qa.tabpage_profile.uo_profile.tab_report.tabpage_profile.CONTrol[LL_I]  , ls_scale )
next

FOR LL_I =  1 TO UPPERBOUND(this.tab_qa.tabpage_profile.uo_profile.tab_report.tabpage_verification.CONTrol)
   this.inv_resize.of_Register (this.tab_qa.tabpage_profile.uo_profile.tab_report.tabpage_verification.CONTrol[LL_I]  , ls_scale )
next

//oppe   For resize  Added by  Nova 02.12.2010
this.inv_resize.of_Register (this.tab_qa.tabpage_oppe.uo_oppe , ls_scale  )
FOR LL_I =  1 TO UPPERBOUND(this.tab_qa.tabpage_oppe.uo_oppe.CONTrol)
   this.inv_resize.of_Register (this.tab_qa.tabpage_oppe.uo_oppe.CONTrol[LL_I]  , ls_scale )
next

FOR LL_I =  1 TO UPPERBOUND(this.tab_qa.tabpage_oppe.uo_oppe.tab_1.tabpage_1.CONTrol)
   this.inv_resize.of_Register (this.tab_qa.tabpage_oppe.uo_oppe.tab_1.tabpage_1.CONTrol[LL_I]  , ls_scale )
next

FOR LL_I =  1 TO UPPERBOUND(this.tab_qa.tabpage_oppe.uo_oppe.tab_1.tabpage_2.CONTrol)
   this.inv_resize.of_Register (this.tab_qa.tabpage_oppe.uo_oppe.tab_1.tabpage_2.CONTrol[LL_I]  , ls_scale )
next


///////////////////////////////////////////////
// assign user objects
//////////////////////////////////////////////

uo_quality_profile = this.tab_qa.tabpage_quality_profile.uo_qa


end event

event pfc_postopen;call super::pfc_postopen;
of_get_current_prac( )
setpointer(arrow!)
setredraw(true)

end event

event open;call super::open;//maha app1005405

of_security()
//Added by  Nova 02.23.2010
IF LenA(is_window_title) < 1 THEN
	is_window_title = This.Title
END IF


end event

event activate;call super::activate;//Added by  Nova 02.24.2010
CHOOSE CASE tab_qa.SelectedTab
	CASE 2
		of_set_measurments_menu( )
	CASE 4
		of_set_caseview_menu()
	CASE 6
		of_set_profile_menu( )
	CASE ELSE
		IF w_mdi.MenuName	 <> 'm_pfe_cst_mdi_menu' THEN
			IF w_mdi.MenuName <> 'm_pfe_cst_mdi_menu' THEN w_mdi.ChangeMenu( m_pfe_cst_mdi_menu )
			w_mdi.of_menu_security( w_mdi.MenuName )
		END IF
END CHOOSE



end event

event pfc_save;call super::pfc_save;//Added by  Nova 02.25.2010
IF This.tab_qa.SelectedTab = 4 THEN
	//This.tab_qa.of_retrive_case_review( )
	This.tab_qa.tabpage_case_review.uo_case.event uo_retrieve_browse( )
		if this.tab_qa.tabpage_case_review.uo_case.tab_1.tabpage_browse.dw_browse.rowcount( ) > 0 then
		this.tab_qa.tabpage_case_review.text = this.tab_qa.tabpage_case_review.uo_case.is_title + " ("  + string(this.tab_qa.tabpage_case_review.uo_case.tab_1.tabpage_browse.dw_browse.rowcount( )) + ")"
	 else
		this.tab_qa.tabpage_case_review.text = this.tab_qa.tabpage_case_review.uo_case.is_title
	end if
END IF

RETURN 0

end event

type cb_1 from commandbutton within w_qa_peer_profile_screen9
boolean visible = false
integer x = 2825
integer y = 24
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "none"
end type

event clicked;string qqq

qqq = w_mdi.menuname

messagebox("menu",qqq)
end event

type tab_qa from pfc_cst_qa_peer_profile within w_qa_peer_profile_screen9
integer taborder = 11
boolean showpicture = false
end type

event selectionchanged;//////// //  OVERRIDE!!!!!

//iw_parent.dynamic of_accepttext( true)
//if iw_parent.function dynamic of_validation( ) <> 1 then 
//	return  // prevent close
//end if
//
Long ll_parent //Added by  Nova 02.23.2010
Long ll_prac //Added by  Nova 02.23.2010
Long ll_view_id //Added by  Nova 02.23.2010
//IF tab_qa.tabpage_search.uo_search.dw_search.RowCount() = 0 THEN
//	
//end if
IF oldindex < 1 Or newindex < 1 THEN RETURN
//Added by  Nova 02.23.2010
IF oldindex = 1 THEN
	IF tab_qa.tabpage_search.uo_search.dw_search.RowCount() > 0 THEN
		ll_parent = tab_qa.tabpage_search.uo_search.dw_search.GetItemNumber(tab_qa.tabpage_search.uo_search.dw_search.GetRow(),'parent_facility_id')
		ll_prac = tab_qa.tabpage_search.uo_search.dw_search.GetItemNumber(tab_qa.tabpage_search.uo_search.dw_search.GetRow(),'prac_id')
		ll_view_id = tab_qa.tabpage_search.uo_search.dw_view.GetItemNumber(1,"data_view_id")
		iw_parent.SetRedraw( False)
		iw_parent.Dynamic of_retrieve_measuremts(ll_parent)
		iw_parent.Dynamic of_retrieve_site_survey()
		iw_parent.Dynamic of_retrieve_case_review(ll_prac,ll_parent)
		iw_parent.Dynamic of_retrieve_oppe(ll_prac,ll_parent)
		iw_parent.Dynamic of_retrieve_priv(ll_prac,ll_parent)
		iw_parent.Dynamic of_run_report(ll_prac,ll_parent,ll_view_id)
	ELSE
		tab_qa.selecttab( 1)
		This.of_messagebox( '',iw_parent.Title , 'Please select a practitioner before continuing.', information!, ok!, 1)
		
		RETURN
	END IF
	
END IF
//end Nova 02.23.2010
iw_parent.SetRedraw( False)
CHOOSE CASE newindex
	CASE 1
		IF w_mdi.MenuName	 <> 'm_pfe_cst_mdi_menu' THEN
			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 08.21.2006 By: LeiWei
			//$<reason> Fix a defect.
												/*
												 w_mdi.ChangeMenu(m_pfe_cst_mdi_menu)
			*/
			IF w_mdi.MenuName <> 'm_pfe_cst_mdi_menu' THEN w_mdi.ChangeMenu( m_pfe_cst_mdi_menu )
			w_mdi.of_menu_security( w_mdi.MenuName )
			//---------------------------- APPEON END ----------------------------
			
		END IF
	CASE 2
		//save
		Parent.of_set_measurments_menu( )
		tab_qa.tabpage_quality_profile.uo_qa.tab_measurments.tabpage_browse.dw_browse.setfocus( )
		//
	CASE 4
		Parent.of_set_caseview_menu()
		tab_qa.tabpage_case_review.uo_case.tab_1.tabpage_browse.dw_browse.setfocus( )
	CASE 6 //Added by  Nova 12.05.2009 --v10.1 Profiles Build out
		// profile
		Parent.of_set_profile_menu( )
	CASE ELSE
		IF w_mdi.MenuName	 <> 'm_pfe_cst_mdi_menu' THEN
			
			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 08.21.2006 By: LeiWei
			//$<reason> Fix a defect.
											/*
											w_mdi.ChangeMenu(m_pfe_cst_mdi_menu)
			*/
			IF w_mdi.MenuName <> 'm_pfe_cst_mdi_menu' THEN w_mdi.ChangeMenu( m_pfe_cst_mdi_menu )
			w_mdi.of_menu_security( w_mdi.MenuName )
			//---------------------------- APPEON END ----------------------------
		END IF
END CHOOSE


//if newindex > oldindex then
//if il_prac_id = 0  then
//	this.of_messagebox( '',iw_parent.title , 'Please select a practitioner before continuing.', information!, ok!, 1)
//	return 1
//end if 
//
//end if 
//


iw_parent.SetRedraw( True)






end event

