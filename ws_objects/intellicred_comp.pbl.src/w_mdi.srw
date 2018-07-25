$PBExportHeader$w_mdi.srw
forward
global type w_mdi from w_frame
end type
type st_vsplit from statictext within w_mdi
end type
type dw_ezmenu from uo_listbar within w_mdi
end type
type dw_statusbar from uo_statusbar within w_mdi
end type
end forward

global type w_mdi from w_frame
integer width = 4722
integer height = 2000
string title = "IntelliCred"
string menuname = "m_pfe_cst_mdi_menu"
windowtype windowtype = mdi!
windowstate windowstate = maximized!
long backcolor = 33551856
event pfc_cst_screen_painter ( )
event pfc_cst_lookup_painter ( )
event pfc_cst_practitioner ( )
event pfc_cst_action_items ( )
event pfc_cst_meetings_month_calendar ( )
event pfc_cst_meetings_month_list ( )
event pfc_cst_app_audit_painter ( )
event pfc_cst_export_painter ( )
event pfc_cst_reports ( )
event pfc_cst_profile_view_manager ( )
event pfc_cst_survey_painter ( )
event pfc_cst_facility_painter ( )
event pfc_cst_letter_painter ( )
event pfc_cst_letter_generator ( )
event pfc_cst_view_audit ( )
event pfc_cst_security_role_painter ( )
event pfc_cst_delete_practitioner ( )
event pfc_cst_security_user_painter ( )
event pfc_cst_image_type_painter ( )
event pfc_cst_priviledge_painter ( )
event pfc_cst_multi_app_painter ( )
event pfc_cst_prac_profile_painter ( )
event pfc_cst_case_review ( )
event pfc_cst_contract_screen_painter ( )
event pfc_cst_workflow_painter ( )
event pfc_cst_email_painter ( )
event pfc_cst_import_painter ( )
event pfc_cst_contact ( )
event pfc_cst_bidq ( )
event pfc_cst_report_painter ( )
event pfc_cst_peer_reference_painter ( )
event pfc_cst_notification_alert_painter ( )
event pfc_cst_scheduler_painter ( )
event pfc_cst_data_flow_painter ( )
event pfc_cst_practitioner_folder2 ( )
event pfc_cst_profile_rpt ( )
event ue_refreshezmenu ( )
event pfc_cst_ezmenu_painter ( )
event pfc_cst_contract_details_layout_setting ( )
event pfc_cst_relogin ( )
event pfc_cst_image_ocr ( )
st_vsplit st_vsplit
dw_ezmenu dw_ezmenu
dw_statusbar dw_statusbar
end type
global w_mdi w_mdi

type prototypes
Function long SendMessage(long hWnd, ulong Msg, long wParam, long lParam) Library "user32.dll" Alias For "SendMessageA"
end prototypes

type variables
Integer iw_prac_cnt
Integer iw_action_items_cnt
Integer ii_security_action_id[]
Integer ii_security_action_value[]

Long il_AtomID			//Added by Scofield on 2008-06-11
Long il_AtomdwStates	//Added by Scofield on 2010-04-27 - (Appeon)Alfee 06.27.2013 - V141 ISG-CLX
Long il_time_seq //Added by Ken.Guo 08.26.2008

String is_current_window_name  //(Appeon)Alfee 06.27.2013 - V141 ISG-CLX
Boolean ib_contract_menu = False //(Appeon)Alfee 07.30.2013 - V141 ISG-CLX

Window iw_prac[]
w_prac_data_1 iw_prac_window
Window iw_action_items[]

n_coolmenu inv_CoolMenu

//---------Begin Added by (Appeon)Alfee 01.26.2014 for V142 ISG-CLX -------------------
Boolean		ib_ShowMainToolbar //Added by gavins 20130312
Long			il_Original_EZMenuWidth

private:
Boolean		ib_EZMen_First //added by gavins 20130325
Integer		ii_offsetX, ii_LastX
Boolean		ib_Drag
Boolean		ib_ReLogin
//---------End Added ----------------------------------------------------------------------------

Int ii_check_prac_position_time = 0 //check prac tab_1 position for a web version bug, Added by Appeon long.zhang 06.07.2016 (Bug ID #5189 for Case # 00064308: Problems after weekend update )
Boolean ib_event_pfc_cst_practitioner = False //Processing pfc_cst_practitioner event flag, Added by Appeon long.zhang 04.07.2017 (Question:  Issue # 5585 - Provider folder is blank, deformed or partially there, why is this occurring?)

String is_set_menu_security_last//Remember the last menu in of_menu_security(), Added by Appeon long.zhang 06.20.2017 (Bug id 5673 - IE Freezes When Trying to Search Providers)
Long il_set_menu_security_last_cpu //Remember the last menu cpu() in of_menu_security(), Added by Appeon long.zhang 06.20.2017 (Bug id 5673 - IE Freezes When Trying to Search Providers)
end variables

forward prototypes
public function integer of_security_access (integer ai_action_id)
public function integer of_setup_security ()
public function integer of_menu_security (string as_menu_name)
public function integer of_prac_folder_security (w_prac_data_1 aw_prac_folder)
public function integer of_action_items_security (w_action_items aw_action_items)
public function integer of_delete_practitioner ()
public function integer of_module_check ()
public function integer of_version_check ()
public subroutine of_getcurrentobject ()
public function integer of_qa_peer_screen_security (w_qa_peer_profile_screen aw_prac_folder)
public function integer of_menu_security_data_entry ()
public function integer of_menu_security_app_audit ()
public function integer of_menu_security_verif_info ()
public function integer of_menu_security_profile ()
public function integer of_menu_security_image (string as_menu_image)
public function integer of_menu_security_privilege ()
public function integer of_menu_security_appl_status ()
public function integer of_menu_security_meeting ()
public function integer of_case_review_security (w_case_review aw_case_review)
public function integer of_menu_security_sk ()
public function integer of_menu_shrink_action_items ()
public subroutine of_hidemenuandtoolitems (menu am_menu)
public subroutine of_menu_security_2 (string as_menu_name)
public function integer of_menu_security_contract ()
public function integer of_menu_security_contract_am ()
public function integer of_menu_shrink_toolbars (integer ai_module)
public function integer of_menu_security_email ()
public function integer of_showezmenu (boolean ab_show)
public subroutine of_showtoolbar (boolean ab_show)
public subroutine of_refresh_ezmenu_enable ()
public subroutine of_refresh_ezmenu_screen ()
public subroutine of_set_ezmenu_enabled (string as_parentmenuname, string as_menuname, boolean ab_enabled)
public subroutine of_set_ezmenu_visible (string as_parentmenu, string as_menu, boolean ab_value)
public subroutine of_set_ezmenu_check (string as_parentmenu, string as_menu, boolean ab_value)
public subroutine of_set_ezmenu_text (string as_parentmenu, string as_menu, string as_text)
public subroutine of_set_ezmenu_pic (string as_parentmenu, string as_menu, string as_pic)
public subroutine of_set_spitbar_visible (boolean ab_visible)
public subroutine of_restore_toolbar_attr ()
public function integer wf_checkisvalidwin (boolean ab_closewin)
public subroutine of_resize_statusbar ()
public function integer of_menu_security_contract_profile ()
public function boolean of_check_provider_position (w_prac_data_1 aw_prac)
end prototypes

event pfc_cst_screen_painter();//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 09.26.2006 By: Liang QingShi
//$<reason> 
/*
OpenSheet( w_prac_data_design, This)
*/
OpenSheet(w_prac_data_design, w_mdi, 4, original!)
//---------------------------- APPEON END ----------------------------

end event

event pfc_cst_lookup_painter;Open( w_lookup_maint )
IF IsValid( m_pfe_cst_data_entry ) THEN
	m_pfe_cst_data_entry.m_edit.m_refreshlookupdata.Event Clicked ( )
END IF


end event

event pfc_cst_practitioner();/****************************************************************************************************************
** [PUBLIC] EVENT   w_mdui :: pfc_cst_practitioner
**--------------------------------------------------------------------------------------------------------------
** Description	:
**--------------------------------------------------------------------------------------------------------------
** Arguments	:	NONE
**--------------------------------------------------------------------------------------------------------------
** Returns		:	(none) 
**--------------------------------------------------------------------------------------------------------------
** Author		:	? 
**--------------------------------------------------------------------------------------------------------------
** ModIFication Log:	
**
** Date            Who                   Change  	
**--------------------------------------------------------------------------------------------------------------
** 15 Nov 2004     MSKINNER				Changed Layered! to ORIGINAL! Needed for the resize
**                                        to work properly
**	28 March 2005  Mskinner              added Move(0,0) to make sure it is in the upper left corner												 
**
****************************************************************************************************************/
SetPointer(hourglass!)

//OpenWithParm(w_extended_search, "DATAENTRY")

//iw_prac_cnt++
//debugbreak()
//OpenSheet( iw_prac[ iw_prac_cnt], "w_prac_data_1", w_mdi, 4, Layered!)

//--------Begin Modified by  Nova 09.07.2010-----------------------
//Nova 09.07.2010  V10.5 SK Section D - Menu and Setup
//Modified by alfee 11.09.2010
//if gb_sk_ver = True then //Start Code Change ----05.24.2010 #V10 maha - special k
//	OpenSheet( w_prac_data_sk, w_mdi, 4, original!)
//ELSEIF gs_cust_type = "I" THEN
//	OpenSheet( w_prac_data_intelliapp, w_mdi, 4, original!)
//	w_prac_data_intelliapp.move(0,0)
//ELSE
//	OpenSheet( w_prac_data_1, w_mdi, 4, original!)
//	//w_prac_data_1.move(0,0)
//END IF

window lw_prac
integer li_tab = 0
integer c

//Start Code Change ----01.10.2011 #V11 maha - modified for app setting allowing the smart setting for regular App
IF gb_sk_ver = True then
	li_tab = 1
elseif gs_cust_type = "I" and gi_prac_tab = 10 then //Start Code Change ----08.10.2016 #V152 maha - changed option number
	li_tab = 1
end if

ib_event_pfc_cst_practitioner = True //used in of_check_provider_position, Added by Appeon long.zhang 04.07.2017 (Question:  Issue # 5585 - Provider folder is blank, deformed or partially there, why is this occurring?)

//IF gb_sk_ver = True or gi_prac_tab = 1 THEN 
IF li_tab = 1 then
	OpenSheet( w_prac_data_sk, w_mdi, 4, Original!)
	lw_prac = w_prac_data_sk
ELSEIF gs_cust_type = "I" THEN
	OpenSheet( w_prac_data_intelliapp, w_mdi, 4,Original!)
	w_prac_data_intelliapp.move(0,0)
	lw_prac = w_prac_data_intelliapp
	lw_prac.windowstate=maximized!
ELSE
	OpenSheet( w_prac_data_1, w_mdi, 4, Original!)
	lw_prac = w_prac_data_1
//-------------------------- RP modified 1.21.2016 --------------------------------
	lw_prac.setRedraw(TRUE)
//-------------------------- end RP modified ----------------------------------------
	lw_prac.windowstate=maximized!
END IF
//End Code Change ----01.10.2011

ib_event_pfc_cst_practitioner = False //used in of_check_provider_position, Added by Appeon long.zhang 04.07.2017 (Question:  Issue # 5585 - Provider folder is blank, deformed or partially there, why is this occurring?)

IF IsValid(lw_prac) THEN
	IF lw_prac.windowstate=minimized! THEN lw_prac.windowstate=normal!
	iw_prac_window = lw_prac
END IF
//--------End Modified --------------------------------------------



//////@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
//// for version 12.3
/////****************************************************************************************************************
////** [PUBLIC] EVENT   w_mdui :: pfc_cst_practitioner
////**--------------------------------------------------------------------------------------------------------------
////** Description	:
////**--------------------------------------------------------------------------------------------------------------
////** Arguments	:	NONE
////**--------------------------------------------------------------------------------------------------------------
////** Returns		:	(none) 
////**--------------------------------------------------------------------------------------------------------------
////** Author		:	? 
////**--------------------------------------------------------------------------------------------------------------
////** ModIFication Log:	
////**
////** Date            Who                   Change  	
////**--------------------------------------------------------------------------------------------------------------
////** 15 Nov 2004     MSKINNER				Changed Layered! to ORIGINAL! Needed for the resize
////**                                        to work properly
////**	28 March 2005  Mskinner              added Move(0,0) to make sure it is in the upper left corner												 
////**
////****************************************************************************************************************/
//SetPointer(hourglass!)
//
////OpenWithParm(w_extended_search, "DATAENTRY")
//
////iw_prac_cnt++
////debugbreak()
////OpenSheet( iw_prac[ iw_prac_cnt], "w_prac_data_1", w_mdi, 4, Layered!)
//
////--------Begin Modified by  Nova 09.07.2010-----------------------
////Nova 09.07.2010  V10.5 SK Section D - Menu and Setup
////Modified by alfee 11.09.2010
////if gb_sk_ver = True then //Start Code Change ----05.24.2010 #V10 maha - special k
////	OpenSheet( w_prac_data_sk, w_mdi, 4, original!)
////ELSEIF gs_cust_type = "I" THEN
////	OpenSheet( w_prac_data_intelliapp, w_mdi, 4, original!)
////	w_prac_data_intelliapp.move(0,0)
////ELSE
////	OpenSheet( w_prac_data_1, w_mdi, 4, original!)
////	//w_prac_data_1.move(0,0)
////END IF
//window lw_prac
//w_prac_data_1 lw_prac1
//integer li_tab = 0
//
////Start Code Change ----01.10.2011 #V11 maha - modified for app setting allowing the smart setting for regular App
//IF gb_sk_ver = True then
//	li_tab = 1
//elseif gs_cust_type = "I" and gi_prac_tab = 1 then
//	li_tab = 1
//end if
//
////Start Code Change ----10.31.2012 #V12 maha - prep for multiple provider folders
//
//////IF gb_sk_ver = True or gi_prac_tab = 1 THEN 
////IF li_tab = 1 then
////	OpenSheet( w_prac_data_sk, w_mdi, 4, original!)
////	lw_prac = w_prac_data_sk
////ELSEIF gs_cust_type = "I" THEN
////	OpenSheet( w_prac_data_intelliapp, w_mdi, 4, original!)
////	w_prac_data_intelliapp.move(0,0)
////	lw_prac = w_prac_data_intelliapp
////ELSE
////	OpenSheet( w_prac_data_1, w_mdi, 4, original!)
////	lw_prac = w_prac_data_1
////END IF
//////End Code Change ----01.10.2011
//
//IF gs_cust_type = "I" THEN
//	IF gb_sk_ver = False THEN	//app
//		lw_prac1 = w_prac_data_intelliapp
//	ELSEIF gb_sk_ver = true  THEN//sk
//		lw_prac1 = w_prac_data_sk
//   end if
//ELSE //cred
//	lw_prac1 = w_prac_data_1
//END IF
//
//lw_prac = lw_prac1
//
//IF IsValid(iw_prac_window) THEN
//	IF iw_prac_window.windowstate=minimized! THEN iw_prac_window.windowstate=normal!
//	//iw_prac_window = lw_prac
//else
//	OpenSheet(lw_prac1,w_mdi,4,Original!)
//	iw_prac_window = lw_prac
//END IF
////End Code Change ----10.31.2012
//
////IF IsValid(lw_prac) THEN
////	IF lw_prac.windowstate=minimized! THEN lw_prac.windowstate=normal!
////	iw_prac_window = lw_prac
////END IF
////--------End Modified --------------------------------------------
//
//
end event

event pfc_cst_action_items();//iw_action_items_cnt++
//OpenSheet( iw_action_items[ iw_action_items_cnt ], "w_action_items",  w_mdi, 4)

IF gs_cust_type = "I" THEN
	OpenSheet( w_action_items_ia,  w_mdi, 4)
	// w_action_items_ia.windowstate=maximized!  //Start Code Change ----02.12.2016 #V15 maha
ELSE
	OpenSheet( w_action_items,  w_mdi, 4)
	//w_action_items.resizable = true
	//w_action_items.windowstate=maximized!  //Start Code Change ----02.12.2016 #V15 maha
END IF
end event

event pfc_cst_meetings_month_calendar;OpenSheet( w_meetings , This, 4)
end event

event pfc_cst_app_audit_painter();//Start Code Change ----10.25.2010 #V10 maha - use same window for all
//IF gs_cust_type = "I" THEN
//	Open( w_app_audit_setup_ia )	
//ELSE
	Open( w_app_audit_setup )
//END IF
end event

event pfc_cst_export_painter();//--------Begin Modified by Nova 11.01.2008-----------
//Open( w_export_painter )
//$<reason> New feature of import module.
OpenSheet(w_export_painter, w_mdi, 4, Original!)
//--------End Modified -------------------------------
end event

event pfc_cst_reports();OpenSheet( w_report, w_mdi, 4, Original!)
end event

event pfc_cst_profile_view_manager;Open( w_profile_view_manager )
end event

event pfc_cst_survey_painter;Open(w_survey_painter)
end event

event pfc_cst_facility_painter;IF gs_cust_type = "I" THEN
	Open( w_facility_setup_intelliapp )
ELSE
	Open( w_facility_setup )
END IF
end event

event pfc_cst_letter_painter;IF gs_cust_type = "I" THEN
	Open( w_letter_painter_ia )
ELSE
	Open( w_letter_painter )
END IF
end event

event pfc_cst_letter_generator;Open( w_letter_generator )
end event

event pfc_cst_view_audit;Open( w_view_audit )
end event

event pfc_cst_security_role_painter;Open( w_security_roles_painter )
end event

event pfc_cst_delete_practitioner;of_delete_practitioner()
end event

event pfc_cst_security_user_painter();//---------Begin Modified by (Appeon)Eugene 06.20.2013 for V141 ISG-CLX--------
//Open( w_security_user_painter )
If gb_contract_version Then
	Open(w_security_user_painter_ctx)
Else
	Open(w_security_user_painter)
End If
//---------End Modfiied ------------------------------------------------------
end event

event pfc_cst_image_type_painter;Open(w_image_type_painter )
end event

event pfc_cst_priviledge_painter();OpenSheet(w_privilege_painter, w_mdi, 4, Original!) //Modify by Evan 01.20.2011
end event

event pfc_cst_multi_app_painter;IF gs_cust_type = 'I' THEN
	Open( w_multi_app_painter_new )	
ELSE
	Open( w_multi_app_painter )
END IF
end event

event pfc_cst_prac_profile_painter;OpenSheet( w_prac_profile_design, This)
end event

event pfc_cst_case_review();OpenSheet( w_case_review, w_mdi, 1 )
w_case_review.Height = 2000
w_case_review.Width = 3400
end event

event pfc_cst_contract_screen_painter();SetPointer(HourGlass!)  //(Appeon)Alfee 06.27.2013 - V141 ISG-CLX
OpenSheet( w_contract_data_design, This,4,original!)
SetPointer(Arrow!)  //(Appeon)Alfee 06.27.2013 - V141 ISG-CLX


end event

event pfc_cst_workflow_painter();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-10-31 By: Allen
//$<reason> open the workflow painter.
opensheet(w_workflow_painter_app,this,0,original!)
//---------------------------- APPEON END ----------------------------
end event

event pfc_cst_email_painter();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-10-31 By: Liu Hongxin
//$<reason> open the email painter.
open(w_email_painter)
//opensheet(w_email_painter,this,0,original!)
//---------------------------- APPEON END ----------------------------
end event

event pfc_cst_import_painter();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 07.26.2007 By: Evan
//$<reason> New feature of import module.
OpenSheet(w_import_painter, w_mdi, 4, Original!)
//---------------------------- APPEON END ----------------------------
end event

event pfc_cst_contact();str_pass lstr_pass
lstr_pass.s_string = 'All LOCATIONS'

//---------Begin Modified by (Appeon)Alfee 06.27.2013 for V141 ISG-CLX--------
If isvalid(w_contract_contact) Then
	If w_contract_contact.WindowState = Minimized! Then
		w_contract_contact.WindowState = Normal!
	End If
	w_contract_contact.BringToTop = True
Else
	OpenWithParm( w_contract_contact, lstr_pass)
End If
//OpenWithParm( w_contract_contact, lstr_pass)
//---------End Modfiied ----------------------------------------------------------------
end event

event pfc_cst_bidq();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08.19.2008 By: Evan
//$<reason> New feature of Batch Import Document Queue module.
OpenSheet(w_bidq_import_document, w_mdi, 4, Original!)
//---------------------------- APPEON END ----------------------------
end event

event pfc_cst_report_painter();//
OpenSheet(w_prac_report_design, w_mdi, 4, original!)
end event

event pfc_cst_peer_reference_painter();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.05.2009 By: Evan
//$<reason> New feature of Peer Reference
OpenSheet(w_peer_reference_painter, w_mdi, 4, Original!)
//---------------------------- APPEON END ----------------------------
end event

event pfc_cst_notification_alert_painter();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.04.2010 By: Evan
//$<reason> New feature of notification alert.
OpenSheet(w_notification_alert_painter, w_mdi, 4, Original!)
//---------------------------- APPEON END ----------------------------
end event

event pfc_cst_scheduler_painter();Open(w_auto_schedule) //scheduler - alfee 02.15.2010
end event

event pfc_cst_data_flow_painter();open(w_data_flow_painter)
end event

event pfc_cst_practitioner_folder2();//Start Code Change ----10.04.2012 #V12 maha - code to open additional practitoiner window
Long ll_data_id
long ll_facil
long ll_prac
string ls_name
str_dashboard str_para
w_prac_data_1 lw_prac
w_prac_data_2 lw_prac1  //maha 06.18.2013
w_prac_data_intelliapp_2 lw_prac2 //maha 06.18.2013
w_prac_data_sk_2 lw_prac3 //maha 06.18.2013

gs_search lstr_search
gs_batch_search lst_select 

lstr_search.stran_transaction = SQLCA
lstr_search.ls_open_for = "PRIVILEGE" 
OpenWithParm( w_extended_search_new , lstr_search )

if upper(message.stringparm) = "CANCEL" then return
if message.doubleparm < 0 then return

lst_select = message.powerobjectparm

ll_prac = lst_select.li_prac_id[1]
ll_facil = lst_select.ll_facility[1] 

select facility_name into :ls_name from facility where facility_id = :ll_facil;
//select default_search_facility into :ll_facil from security_users where user_id = :gs_user_id;
//if isnull(ll_facil) then ll_facil = 0

str_para.data_id = ll_prac
str_para.data_name = ls_name
str_para.data_ext_id = ll_facil
//str_para.color = 16638439 //violet
//str_para.color = 16448250 //silver
//str_para.color = 14149365 //tan
str_para.color = 16775925 //pale blue
//str_para.color = 16449525 //pale green
//Start Code Change ----06.18.2013 #V14 maha - modified using variables for each window type
//debugbreak()
IF gs_cust_type = "I" THEN
	IF gb_sk_ver = true  THEN//sk
		OpenSheetWithParm(lw_prac3,str_para,w_mdi,4,Original!)
		lw_prac = lw_prac3
	ELSEIF gi_prac_tab = 1 then //app with setting
		OpenSheetWithParm(lw_prac3 ,str_para,w_mdi,4,Original!)
		lw_prac = lw_prac3
	ELSE  //app
		OpenSheetWithParm(lw_prac2 ,str_para,w_mdi,4,Original!)
		lw_prac = lw_prac2
	END IF
ELSE //cred
	OpenSheetWithParm(lw_prac1 ,str_para,w_mdi,4,Original!)
	lw_prac = lw_prac1
END IF

//OpenSheetWithParm(lw_prac,str_para,w_mdi,4,Original!)
//End Code Change ----06.18.2013
//w_mdi.iw_prac_window = lw_prac 

return

end event

event pfc_cst_profile_rpt();//====================================================================
//$<Event>: pfc_cst_profile_rpt()
//$<Arguments>:
//$<Return>:  (None)
//$<Description>: 
//$<Author>: (Appeon) Alfee 06.27.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:From CLX.
//====================================================================
opensheet(w_profile_report,this,0,original!)  //contract profile report - jervis 05.09.2011
end event

event ue_refreshezmenu();// (Appeon)Harry 03.17.2014 - V142 ISG-CLX Copy from CLX12.0
//dw_ezmenu.SetRedraw( False )		
dw_ezmenu.of_Set_Menu( This.MenuID )	
//dw_ezmenu.SetRedraw( True )	

end event

event pfc_cst_ezmenu_painter();// (Appeon)Harry 03.17.2014 - V142 ISG-CLX Copy from CLX12.0

open( w_ezmenu_painter )

end event

event pfc_cst_contract_details_layout_setting();// (Appeon)Harry 03.17.2014 - V142 ISG-CLX Copy from CLX12.0
//Added By Mark Lee 01/23/2013
OpenSheet( w_contract_layout, This,4,original!)
//OpenSheet( w_contract_layout, This,0,Layered!)
end event

event pfc_cst_relogin();// (Appeon)Harry 03.17.2014 - V142 ISG-CLX Copy from CLX12.0
app_filler		app
Integer		li_Return, li_Count, li_Return2


app = GetApplication( )

If IsValid( app ) Then
	If IsValid( gnv_Status_Info ) Then 
		If gnv_Status_Info.ib_red_process Then
			MessageBox( 'Login As', 'The system is sending/receiving emails and is in the process of exporting data, etc. ~r~n~r~nPlease switch your account after it is finished.' )
			Return
		End If
	End If
	
	//check opened window
	If wf_checkisvalidwin( false )> 0 Then
		li_Return = MessageBox( 'Login As', 'All windows will be closed when you login as another user.~r~n~r~nDo you want to continue?' , Question! , yesno!, 1 )
		If li_Return = 1 Then
			do
				wf_checkisvalidwin( true )//close
				li_Count = wf_checkisvalidwin( false )
				If li_Count > 0 Then
					li_Return2 = MessageBox( 'Login As', 'Some of the windows are not closed. ~r~n~r~nDo you want to close them?', question!, yesno!, 1  )
					If li_Return2 <> 1 Then
						Return
					End If
				End If
					
			Loop while li_Count <> 0
		Else
			Return //no operation
		End If
				
	End If	
	
	//relogin
	app.of_set_relogin_status( True )
	Open( w_logon_screen )
	IF Message.StringParm = "Cancel" Or Message.StringParm = "DB Error" Or Message.StringParm = "" THEN //the last added maha 081502 for user clicking on X on login screen
		Return
	END IF
	app.of_logout( )
	app.Event open(  app.is_commandline )
	
	Event open( )
	event pfc_postopen( )
	
	app.of_Set_relogin_status( False )
End If

end event

event pfc_cst_image_ocr();OpenSheet( w_ocr_import_applications,  w_mdi, 4, Original!)  //(Appeon)Stephen 06.20.2014 - Using image OCR to import data into IntelliCred 14.2
end event

public function integer of_security_access (integer ai_action_id);//IF of_version_check() = 0 THEN
//	RETURN 1
//END IF

Integer i
Integer li_action_cnt


li_action_cnt = UpperBound( ii_security_action_id[] )

FOR i = 1 TO li_action_cnt
	IF ii_security_action_id[i] = ai_action_id THEN
		//Start Code Change ----05.27.2009 #V92 maha - the actions values for read-only access are set in of_set_security
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 09.10.2008 By: Ken.Guo
		//$<reason> For Readonly user.
		//Return ii_security_action_value[i]
//		If ii_security_action_value[i] = 0 Then 
//			Return 0
//		Else
//			If gi_user_readonly = 1 Then
//				Return 1
//			Else
				Return ii_security_action_value[ i ]
//			End If
//		End If
		//---------------------------- APPEON END ----------------------------
		//End Code Change---05.27.2009
	END IF
END FOR

Return -1
end function

public function integer of_setup_security ();IF of_version_check() = 0 THEN
	RETURN 1
END IF

Integer li_role_id
Integer i
Integer li_row_cnt
Integer li_action_cnt
integer li_set  //maha 05.27.2009
integer li_val //maha 05.27.2009
n_ds lds_all_actions
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<modify> 03.15.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Write script to retrieve data from a cache instead of from the database.

/*
SELECT security_users.role_id  
INTO :li_role_id  
FROM security_users  
WHERE ( security_users.user_id = :gs_user_id )   ;
*/
li_role_id = integer(gnv_data.of_getitem("security_users" , "role_id" , "upper(user_id)='" + upper(gs_user_id) + "'"))
//---------------------------- APPEON END ----------------------------
lds_all_actions = CREATE n_ds

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 08.18.2006 By: LeiWei
//$<reason> Making the Contract Module a Standalone Product
/*
lds_all_actions.DataObject = "d_security_actions_all"
*/
IF gb_contract_version THEN
	lds_all_actions.DataObject = "d_security_actions_all_for_contract"
ELSE
	lds_all_actions.DataObject = "d_security_actions_all"
END IF
//---------------------------- APPEON END ----------------------------
//messagebox("",gi_user_readonly)
lds_all_actions.of_SetTransObject( SQLCA )
li_row_cnt = lds_all_actions.Retrieve( li_role_id )
FOR i = 1 TO li_row_cnt
	ii_security_action_id[ i ] = lds_all_actions.GetItemNumber( i, "action_id" )
	//if ii_security_action_id[ i ] = 1590 then debugbreak()
//Start Code Change ----05.27.2009 #V92 maha - creation of read only menu functionality
	li_val = lds_all_actions.GetItemNumber( i, "value_id" )
	//Start Code Change ----06.07.2009 #V10 maha - exception for reset password
	if lds_all_actions.GetItemNumber( i, "action_id" ) = 2200 and li_val = 1 then 
		ii_security_action_value[ i ] = 1  //
		continue
	end if
	//End Code Change---06.77.2010
	if gi_user_readonly = 1 then  // for readonly user set the action value to 0 or 1 depending on the dddw_type
		li_set = lds_all_actions.GetItemNumber( i, "dddw_type" ) - 1 //will be either 0 or 1
		if li_val < li_set then li_set = li_val // if the role value is less than the R/O value (no access) use the role
		ii_security_action_value[ i ] = li_set
	else
		ii_security_action_value[ i ] = li_val             // lds_all_actions.GetItemNumber( i, "value_id" )
	end if
//End Code Change---05.27.2009
END FOR

RETURN 1
end function

public function integer of_menu_security (string as_menu_name);//////====================================================================
//$<Function>: of_menu_security()
//$<Arguments>:
// 	value    string    as_menu_name
//$<Return>:  integer
//$<Description>: 
//$<Author>: Michael B. Skinner     28 December 2005
//--------------------------------------------------------------------------------------------------------------------------
//$<Modify History>:(Appeon) Alfee 06.29.2013 (V141 ISG-CLX)
//====================================================================

Integer 	li_intelli_cnt = 0
Integer 	ncnt
Integer	test
Long 		ll_pracid
Long 		ll_Cycle,ll_ItemCnts  //(Appeon)Alfee 06.29.2013 - V141 ISG-CLX
String		ls_WinName
String 	ls_label
Boolean	lb_Display //(Appeon)Alfee 06.29.2013 - V141 ISG-CLX
Window	lw_Win
Window	lw_currentsheet //(Appeon)Alfee 06.29.2013 - V141 ISG-CLX

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 06.20.2017
//<$>reason: Remember the last menu to reduce refresh time, Added by Appeon long.zhang 06.20.2017 (Bug id 5673 - IE Freezes When Trying to Search Providers)
If as_menu_name <> is_set_menu_security_last Then
	is_set_menu_security_last = as_menu_name
	il_set_menu_security_last_cpu = Cpu()
Else //Don't refresh it anymore during 1.2s
	If as_menu_name =  "m_pfe_cst_mdi_menu" Then //Only for this menu now.
		If (Cpu() - il_set_menu_security_last_cpu) < 1200 Then	
			Return 0
		End If
	End If
	
	il_set_menu_security_last_cpu = Cpu() //remember time
End If
//------------------- APPEON END -------------------

//This.SetRedraw(False) //alfee 12.01.2010  //Start Code Change ----05.24.2011 #V11 maha - removed for bleedthrough issues

//m_pfe_cst_master_menu.menutitles = false

//IF appeongetclienttype() = "WEB" THEN //alfee 08.18.2011   //Start Code Change ----05.22.2015 #V15 maha - readded for C/S
	This.SetRedraw(False)	
	//This.Post SetRedraw(True) //Comment by Appeon long.zhang 02.04.2017 (For Screen Bleed Issue)
//END IF

IF IsValid(m_pfe_cst_master_menu) THEN
	IF IsValid(gds_settings) THEN
		IF gds_settings.RowCount() > 0 THEN
			ls_label = gds_settings.GetItemString(1,"app_stat_facility_label")
		END IF
	END IF
	
	IF LenA(Trim(ls_label)) > 0 THEN
		m_pfe_cst_master_menu.m_system.m_painters.m_systemsetup.m_facilitypainter.Text = ls_label + ' Setup~tCtrl+Alt+F' //'&' +  //Painter->Setup Alfee 12.16.2010
		IF AppeonGetClientType() = 'NONE'/*'PB'*/ then //Modified by Evan 04.10.2012
			app_filler.inv_CoolMenu.of_loadimagesfrommenu(This.MenuID)
		END IF
	END IF
END IF

//---------Begin Added by (Appeon)Alfee 06.29.2013 for V141 ISG-CLX--------
is_current_window_name = ''
ib_contract_menu = False
lw_currentsheet = w_mdi.GetActiveSheet ( )
If isvalid(lw_currentsheet) Then is_current_window_name = lw_currentsheet.classname()
If as_menu_name="m_pfe_cst_mdi_menu_contract" Or  as_menu_name = "m_pfe_cst_mdi_menu_contract_am" Then ib_contract_menu = True
//---------End Added ------------------------------------------------------------------

if gb_home_visible then  //(Appeon)Harry 12.07.2015 - for V14.2 Bug # 4867
	//Start Code Change ----07.10.2014 #V14.2 maha - home icon
	if gb_home_icon = false then
		m_pfe_cst_master_menu.m_file.m_home.toolbaritemvisible = false
	else
		m_pfe_cst_master_menu.m_file.m_home.toolbaritemvisible = True
	end if
else
	m_pfe_cst_master_menu.m_file.m_home.toolbaritemvisible = false
end if

//**********************BEGIN OF THE IF STATEMENT********************************
//Add "m_pfe_cst_mdi_menu_lookup", "m_pfe_cst_mail" & "m_pfe_cst_contract_profile" - (Appeon)Alfee 06.29.2013 - V141 ISG-CLX
IF as_menu_name = "m_pfe_cst_reports" Or as_menu_name =  "m_pfe_cst_mdi_menu" Or+&
	as_menu_name = "m_pfe_cst_clause_painter" Or as_menu_name = "m_pfe_cst_agreement_template" Or +&
	as_menu_name = "m_pfe_cst_mdi_menu_contract_am" Or +&
	as_menu_name = "m_ctx_doc_painter" OR as_menu_name = "m_pfe_cst_mdi_menu_lookup" OR +& 
	as_menu_name = "m_pfe_cst_action_items" Or as_menu_name = "m_pfe_cst_data_entry" Or as_menu_name = "m_pfe_cst_prac_meetings" Or+&
	as_menu_name = "m_pfe_cst_app_audit" Or as_menu_name = "m_pfe_cst_meetings" Or as_menu_name = "m_pfe_cst_privileges" Or+&
	as_menu_name = "m_pfe_cst_prac_data_design" Or as_menu_name = "m_pfe_cst_verif_info" Or+&
	as_menu_name = "m_pfe_cst_qa" Or as_menu_name = "m_pfe_cst_mes" Or as_menu_name = "m_pfe_cst_contract_data_design" Or+&
	as_menu_name = "m_pfe_cst_contract" Or as_menu_name = "m_pfe_cst_mdi_menu_contract" Or as_menu_name = "m_pfe_cst_net_dev_action_items" Or+&
	as_menu_name = "m_pfe_cst_net_dev" Or as_menu_name = "m_pfe_cst_profile" Or PosA( as_menu_name, "m_pfe_cst_imaging" ) > 0 Or PosA( as_menu_name, "m_pfe_train_app" ) > 0 Or+&
	as_menu_name = "m_pfe_cst_import_painter" Or as_menu_name =  "m_pfe_cst_mdi_dashboard" or as_menu_name = 'm_pfe_cst_mail'  or  +&
	as_menu_name = "m_pfe_cst_contract_profile" &
THEN
	m_pfe_cst_master_menu.m_file.m_caqhfileimport.Visible = False
	m_pfe_cst_master_menu.m_file.m_caqhfileimport.ToolbarItemVisible = False
	m_pfe_cst_master_menu.m_edit.m_clearchanges.visible = false
	IF NOT IsValid(m_pfe_cst_master_menu) Or IsNull(m_pfe_cst_master_menu) THEN 
		This.SetRedraw(True) //Added by Appeon long.zhang 02.04.2017 (For Screen Bleed Issue)
		RETURN 0
	End If
	
	IF gs_user_id = "SE" THEN
		m_pfe_cst_master_menu.m_system.m_painters.m_systemsetup.m_imagetypepainter.Visible = False
		m_pfe_cst_master_menu.m_system.m_painters.m_systemsetup.m_multiapppainter.Visible = False
		m_pfe_cst_master_menu.m_system.m_utilities.Visible = False
		m_pfe_cst_master_menu.m_system.m_batchupdate.Visible = False
		m_pfe_cst_master_menu.m_system.m_2.Visible = False
		m_pfe_cst_master_menu.m_file.m_sitesurvey.Visible = False
		m_pfe_cst_master_menu.m_help.m_iapply.Visible = False
	END IF
	//IntelliApp Train

	IF gi_iapp_on = 0 THEN //maha092302
		m_pfe_cst_master_menu.m_system.m_applicationmapping.Visible = False
		m_pfe_cst_master_menu.m_system.m_batchaddapplications.Visible = False
		m_pfe_cst_master_menu.m_system.m_applicationmapping.toolbaritemVisible = False//Start Code Change ----06.20.2012 #V12 maha
	ELSE
		IF of_security_access( 1460 ) = 0 THEN
			IF IsValid( m_pfe_cst_master_menu.m_system.m_applicationmapping) THEN
				m_pfe_cst_master_menu.m_system.m_applicationmapping.Visible = False
				m_pfe_cst_master_menu.m_system.m_applicationmapping.toolbaritemVisible = False//Start Code Change ----06.20.2012 #V12 maha
			END IF
			li_intelli_cnt++
		ELSE
			IF IsValid( m_pfe_cst_master_menu.m_system.m_applicationmapping) THEN
				m_pfe_cst_master_menu.m_system.m_applicationmapping.Visible = True
			
				//Start Code Change ----04.08.2010 #V10 maha
				//if gi_prod_setting = 1 then //intelliapp //Start Code Change ----06.20.2012 #V12 maha - made visible for Cred
				if gb_use_prac_toolbar = true then  //Start Code Change ----11.13.2012 #V12 maha - hide if use buttons
					m_pfe_cst_master_menu.m_system.m_applicationmapping.toolbaritemVisible = false
				else
					if not ib_contract_menu and as_menu_name <> "m_pfe_cst_mdi_dashboard" then //Add if statement - (Appeon)Alfee 08.06.2013 - V141 ISG-CLX
						m_pfe_cst_master_menu.m_system.m_applicationmapping.toolbaritemVisible = True 
					end if
				end if
				//end if
				//End Code Change---04.08.2010
			END IF
			//m_pfe_cst_master_menu.m_file.m_intelliapp.m_training.toolbaritemvisible = True
		END IF
	END IF

	//IntelliApp Print
	IF gi_iapp_on = 0 THEN //maha092302 mod 110403
		m_pfe_cst_master_menu.m_reports.m_applications.Visible = False
		m_pfe_cst_master_menu.m_reports.m_applications.ToolbarItemVisible = False
	ELSE
		IF of_security_access( 1330 ) = 0 THEN
			m_pfe_cst_master_menu.m_reports.m_applications.Visible = False
			m_pfe_cst_master_menu.m_reports.m_applications.ToolbarItemVisible = False
			li_intelli_cnt++
		ELSE
			m_pfe_cst_master_menu.m_reports.m_applications.Visible = True
			IF NOT ib_contract_menu THEN m_pfe_cst_master_menu.m_reports.m_applications.ToolbarItemVisible = True 
		END IF
	END IF
	IF li_intelli_cnt = 2 THEN //????
		m_pfe_cst_master_menu.m_reports.m_applications.Visible = False
		m_pfe_cst_master_menu.m_reports.m_applications.ToolbarItemVisible = False
	END IF

	IF of_security_access( 40 ) = 0 THEN
		m_pfe_cst_master_menu.m_file.m_practitioner.Visible = False
		m_pfe_cst_master_menu.m_file.m_practitioner.ToolbarItemVisible = False
		m_pfe_cst_master_menu.m_file.m_practitioner.Enabled = False //Start Code Change ----07.07.2009 #V92 maha - block shortcut keys
		m_pfe_cst_master_menu.m_file.m_additionalprovider.Visible = False  //Start Code Change ----10.31.2012 #V12 maha - for 12.3
		m_pfe_cst_master_menu.m_file.m_additionalprovider.Enabled = False
	ELSE
		m_pfe_cst_master_menu.m_file.m_practitioner.Visible = True
		IF NOT ib_contract_menu THEN m_pfe_cst_master_menu.m_file.m_practitioner.ToolbarItemVisible = True
		m_pfe_cst_master_menu.m_file.m_practitioner.Enabled = True //Start Code Change ----07.07.2009 #V92 maha
		m_pfe_cst_master_menu.m_file.m_additionalprovider.Visible = True  //Start Code Change ----10.31.2012 #V12 maha - for 12.3
		m_pfe_cst_master_menu.m_file.m_additionalprovider.Enabled = true  //Start Code Change ----02.25.2013 #V12 maha - added
	END IF
	
	//---------Begin Added by (Appeon)Alfee 07.25.2013 for V141 ISG-CLX--------
	//Close
	 //Start Code Change ----11.18.2015 #V15 maha - modified so close can appear in Cred
	//IF gb_contract_module  AND  as_menu_name <> "m_pfe_cst_mdi_dashboard" THEN 
	IF as_menu_name <> "m_pfe_cst_mdi_dashboard" THEN 
		m_pfe_cst_master_menu.m_file.m_close.ToolbarItemVisible = True 
	ELSE
		m_pfe_cst_master_menu.m_file.m_close.ToolbarItemVisible = False
	END IF
	 //End Code Change ----11.18.2015 
		
	// Output and TDL 	
	IF gb_contract_version THEN 
		m_pfe_cst_master_menu.m_reports.ToolbarItemOrder = 26
		m_pfe_cst_master_menu.m_file.m_todolist.ToolbarItemOrder = 27
	ELSE		
		m_pfe_cst_master_menu.m_reports.ToolbarItemOrder = 3		
		m_pfe_cst_master_menu.m_file.m_todolist.ToolbarItemOrder = 7
	END IF
	//---------End Added ------------------------------------------------------------------
	
	//action items
	//Start Code Change ----02.05.2008 #V8 maha -  cleaned up code
	IF gb_contract_version = True THEN
		//---------Begin Modified by (Appeon)Alfee 06.29.2013 for V141 ISG-CLX--------
		m_pfe_cst_master_menu.m_file.m_actionitems.Visible = False
		m_pfe_cst_master_menu.m_file.m_actionitems.ToolbarItemVisible = False		
		/*IF of_security_access( 5210 ) = 0 And gb_contract_version THEN
			m_pfe_cst_master_menu.m_file.m_actionitems.Visible = False
			m_pfe_cst_master_menu.m_file.m_actionitems.ToolbarItemVisible = False
		ELSE
			m_pfe_cst_master_menu.m_file.m_actionitems.Visible = True
			m_pfe_cst_master_menu.m_file.m_actionitems.ToolbarItemVisible = True
		END IF */
		//---------End Modified------------------------------------------------------------------		
	ELSE
		IF of_security_access( 240 ) = 0 THEN
			m_pfe_cst_master_menu.m_file.m_actionitems.Visible = False
			m_pfe_cst_master_menu.m_file.m_actionitems.ToolbarItemVisible = False
		ELSE
			m_pfe_cst_master_menu.m_file.m_actionitems.Visible = True
			if not ib_contract_menu then m_pfe_cst_master_menu.m_file.m_actionitems.ToolbarItemVisible = True
		END IF
	END IF
	//End Code Change---02.05.2008

	//meetings
	//IF of_security_access( 340 ) = 0 THEN
	IF of_security_access( 340 ) = 0 OR gb_contract_version THEN  //(Appeon)Alfee 07.26.2013 - V141 ISG-CLX
		m_pfe_cst_master_menu.m_file.m_meetings.Visible = False
		m_pfe_cst_master_menu.m_file.m_meetings.ToolbarItemVisible = False
	ELSE
		m_pfe_cst_master_menu.m_file.m_meetings.Visible = True
		if not ib_contract_menu then m_pfe_cst_master_menu.m_file.m_meetings.ToolbarItemVisible = True  //(Appeon)Alfee 07.26.2013 - V141 ISG-CLX
	END IF
	
	//---------Begin Added by (Appeon)Alfee 06.29.2013 for V141 ISG-CLX--------
	//Getting Started for CTX.
	IF NOT gb_contract_module OR of_security_access( 6980 ) = 0 THEN
		m_pfe_cst_master_menu.m_help.m_gettingstarted.Visible = False
		m_pfe_cst_master_menu.m_help.m_gettingstarted.ToolBarItemVisible = False			
	ELSE
		m_pfe_cst_master_menu.m_help.m_gettingstarted.Visible = True
		if not ib_contract_menu then m_pfe_cst_master_menu.m_help.m_gettingstarted.ToolBarItemVisible = True
	END IF	
	//---------End Added ------------------------------------------------------------------

	//privileges  maha 040201  modified 110303
	IF gi_priv_mod = 0 THEN //maha 110403
//		m_pfe_cst_master_menu.m_file.m_privileging.Visible = False
		m_pfe_cst_master_menu.m_system.m_painters.m_privilegesandqa.m_privilegepainter.Visible = False
		m_pfe_cst_master_menu.m_system.m_painters.m_privilegesandqa.m_fppeplantemplates.Visible = False  //Start Code Change ----02.07.2012 #V12 maha
		m_pfe_cst_master_menu.m_reports.m_privilegelisting.Visible = False
		m_pfe_cst_master_menu.m_reports.m_privilegelisting.ToolbarItemVisible = False
	ELSE
		IF of_security_access( 1310 ) = 0 THEN
//			m_pfe_cst_master_menu.m_file.m_privileging.Visible = False
			m_pfe_cst_master_menu.m_system.m_painters.m_privilegesandqa.m_privilegepainter.Visible = False
			m_pfe_cst_master_menu.m_system.m_painters.m_privilegesandqa.m_fppeplantemplates.Visible = False   //Start Code Change ----02.07.2012 #V12 maha
		ELSE
//			m_pfe_cst_master_menu.m_file.m_privileging.Visible = True
			m_pfe_cst_master_menu.m_system.m_painters.m_privilegesandqa.m_privilegepainter.Visible = True
			m_pfe_cst_master_menu.m_system.m_painters.m_privilegesandqa.m_fppeplantemplates.Visible = True   //Start Code Change ----02.07.2012 #V12 maha
		END IF
		IF of_security_access( 210 ) = 0 THEN //maha 092705 based on security for pract folder priv tab
			m_pfe_cst_master_menu.m_reports.m_privilegelisting.Visible = False
			m_pfe_cst_master_menu.m_reports.m_privilegelisting.ToolbarItemVisible = False
		ELSE
			m_pfe_cst_master_menu.m_reports.m_privilegelisting.Visible = True
			if not ib_contract_menu then m_pfe_cst_master_menu.m_reports.m_privilegelisting.ToolbarItemVisible = True
		END IF
	END IF
	//group practice  maha 040201
	IF of_security_access( 1320 ) = 0 THEN
		m_pfe_cst_master_menu.m_file.m_grouppractices.Visible = False
		m_pfe_cst_master_menu.m_file.m_grouppractices.ToolbarItemVisible = False //Start Code Change ----02.02.2010 #V10 maha
	ELSE
		m_pfe_cst_master_menu.m_file.m_grouppractices.Visible = True
		if not ib_contract_menu then m_pfe_cst_master_menu.m_file.m_grouppractices.ToolbarItemVisible = true //Start Code Change ----02.02.2010 #V10 maha
	END IF
	//correspondence
	IF of_security_access( 400 ) = 0 THEN
		m_pfe_cst_master_menu.m_reports.m_letters.Visible = False
		m_pfe_cst_master_menu.m_reports.m_letters.ToolbarItemVisible = False
	ELSE
		IF gb_contract_version THEN
			m_pfe_cst_master_menu.m_reports.m_letters.Visible = False
			m_pfe_cst_master_menu.m_reports.m_letters.ToolbarItemVisible = False
		ELSE
			m_pfe_cst_master_menu.m_reports.m_letters.Visible = True
			if not ib_contract_menu then m_pfe_cst_master_menu.m_reports.m_letters.ToolbarItemVisible = True
		END IF
	END IF
	//reports
	IF of_security_access( 700 ) = 0 THEN
		m_pfe_cst_master_menu.m_reports.m_reportsgraphs.Visible = False
		m_pfe_cst_master_menu.m_reports.m_reportsgraphs.ToolbarItemVisible = False
	ELSE
		m_pfe_cst_master_menu.m_reports.m_reportsgraphs.Visible = True
		if not ib_contract_menu then m_pfe_cst_master_menu.m_reports.m_reportsgraphs.ToolbarItemVisible = True
	END IF
	
	//---------Begin Added by (Appeon)Stephen 05.25.2017 for V15.4-WebView Reporting Functionality--------
	IF of_security_access( 7850 ) = 0 THEN
		m_pfe_cst_master_menu.m_reports.m_savedreports.Visible = False
		m_pfe_cst_master_menu.m_reports.m_savedreports.ToolbarItemVisible = False
	ELSE
		m_pfe_cst_master_menu.m_reports.m_savedreports.Visible = True
		if not ib_contract_menu then m_pfe_cst_master_menu.m_reports.m_savedreports.ToolbarItemVisible = True
	END IF
	//---------End Added ------------------------------------------------------

	//Start Code Change ----01.15.2013 #V12 maha - one click
	IF of_security_access( 7505 ) = 0 THEN
		m_pfe_cst_master_menu.m_reports.m_oneclickreports.Visible = False
		m_pfe_cst_master_menu.m_reports.m_oneclickreports.ToolbarItemVisible = False
	ELSE
		m_pfe_cst_master_menu.m_reports.m_oneclickreports.Visible = True
		if not ib_contract_menu then m_pfe_cst_master_menu.m_reports.m_oneclickreports.ToolbarItemVisible = True
	END IF
	
//Start Code Change ----10.05.2017 #V154 maha - activity reports
	IF of_security_access( 7861 ) = 0 THEN
		m_pfe_cst_master_menu.m_reports.m_activityreport.Visible = False
		m_pfe_cst_master_menu.m_reports.m_activityreport.ToolbarItemVisible = False
	ELSE
		m_pfe_cst_master_menu.m_reports.m_activityreport.Visible = True
		m_pfe_cst_master_menu.m_reports.m_activityreport.ToolbarItemVisible = True
	END IF	
//End Code Change ----10.05.2017

	//screen painter
	IF of_security_access( 410 ) = 0 THEN
		m_pfe_cst_master_menu.m_system.m_painters.m_screensetup.m_screenpainter.Visible = False
		m_pfe_cst_master_menu.m_system.m_painters.m_screensetup.m_appointmentlabels.Visible = False  //Start Code Change ----02.28.2011 #V11 maha
		m_pfe_cst_master_menu.m_system.m_painters.m_screensetup.m_intelliapppainter.Visible = False  //Start Code Change ----02.28.2011 #V11 maha
		m_pfe_cst_master_menu.m_system.m_painters.m_screensetup.m_groupdatalabels.Visible = False  //Start Code Change ----02.28.2011 #V11 maha
	ELSE
		m_pfe_cst_master_menu.m_system.m_painters.m_screensetup.m_screenpainter.Visible = True
		m_pfe_cst_master_menu.m_system.m_painters.m_screensetup.m_appointmentlabels.Visible = True  //Start Code Change ----02.28.2011 #V11 maha
		m_pfe_cst_master_menu.m_system.m_painters.m_screensetup.m_intelliapppainter.Visible = True  //Start Code Change ----02.28.2011 #V11 maha
		m_pfe_cst_master_menu.m_system.m_painters.m_screensetup.m_groupdatalabels.Visible = True  //Start Code Change ----02.28.2011 #V11 maha
		
	END IF

	//report painter
	IF of_security_access( 6938 ) = 0 THEN
		m_pfe_cst_master_menu.m_system.m_painters.m_profiles.m_reportpainter.Visible = False
	ELSE
		m_pfe_cst_master_menu.m_system.m_painters.m_profiles.m_reportpainter.Visible = True
	END IF

	//application audit painter
	IF of_security_access( 460 ) = 0 THEN
		m_pfe_cst_master_menu.m_system.m_painters.m_systemsetup.m_applicationauditpainter.Visible = False
	ELSE
		m_pfe_cst_master_menu.m_system.m_painters.m_systemsetup.m_applicationauditpainter.Visible = True
	END IF

	// facility painter
	IF of_security_access( 470 ) = 0 THEN
		m_pfe_cst_master_menu.m_system.m_painters.m_systemsetup.m_facilitypainter.Visible = False
		m_pfe_cst_master_menu.m_system.m_painters.m_systemsetup.m_facilitypainter.Enabled = False //Start Code Change ----07.07.2009 #V92 maha - block shortcut keys
		m_pfe_cst_master_menu.m_system.m_painters.m_systemsetup.m_commimtstpainter.Visible = False
	ELSE
		m_pfe_cst_master_menu.m_system.m_painters.m_systemsetup.m_facilitypainter.Visible = True
		m_pfe_cst_master_menu.m_system.m_painters.m_systemsetup.m_facilitypainter.Enabled = True //Start Code Change ----07.07.2009 #V92 maha - 
		IF of_security_access( 530 ) = 0 THEN
			m_pfe_cst_master_menu.m_system.m_painters.m_systemsetup.m_commimtstpainter.Visible = False
		ELSE
			m_pfe_cst_master_menu.m_system.m_painters.m_systemsetup.m_commimtstpainter.Visible = True
		END IF	
	END IF

	//------------------- APPEON BEGIN -------------------
	//$<add> Stephen 11.09.2011
	//$<reason> V12.1-Fax modification
	if of_security_access( 7210 ) = 0 THEN
		m_pfe_cst_master_menu.m_system.m_communicationlogs.m_fax_log.Visible = false
	else
		IF IsValid(gds_settings) THEN
			IF gds_settings.RowCount() > 0 THEN
				If gds_settings.GetItemNumber(1,'set_52') = 1 then
					m_pfe_cst_master_menu.m_system.m_communicationlogs.m_fax_log.Visible = false
				else
					m_pfe_cst_master_menu.m_system.m_communicationlogs.m_fax_log.Visible = true
				end if
			else
				m_pfe_cst_master_menu.m_system.m_communicationlogs.m_fax_log.Visible = true
			END IF
		else
			m_pfe_cst_master_menu.m_system.m_communicationlogs.m_fax_log.Visible = true
		END IF
		
	end if
	//------------------- APPEON END -------------------

	//------------------- APPEON BEGIN -------------------
	//$<add> Stephen 01.04.2012
	//$<reason>  v12.1 -WV audit acceptance code migration to PB 
	if of_security_access( 7230 ) = 0 THEN
		m_pfe_cst_master_menu.m_system.m_webviewfunctions.m_webviewauditing.Visible = false
		m_pfe_cst_master_menu.m_system.m_webviewfunctions.m_webviewesignlog.Visible = false  //Start Code Change ----07.03.2013 #V14 maha
	//else
	ELSEIF NOT gb_contract_version THEN  //(Appeon)Alfee 06.29.2013 - V141 ISG-CLX	
		m_pfe_cst_master_menu.m_system.m_webviewfunctions.m_webviewauditing.Visible = true
		m_pfe_cst_master_menu.m_system.m_webviewfunctions.m_webviewesignlog.Visible = true   //Start Code Change ----07.03.2013 #V14 maha
	end if
	//------------------- APPEON END -------------------

	//------------------- APPEON BEGIN -------------------
	//$<add> Stephen 03.06.2012
	//$<reason> V12.1 WebView Painter Migration to Cred
	if of_security_access( 7250 ) = 0 THEN
		m_pfe_cst_master_menu.m_system.m_painters.m_webview.m_esignatureagreements.Visible = false
	else
		m_pfe_cst_master_menu.m_system.m_painters.m_webview.m_esignatureagreements.Visible = false ////Start Code Change ----04.26.2012 #V12 maha - hide from view
	end if
	if of_security_access( 7260 ) = 0 THEN
		m_pfe_cst_master_menu.m_system.m_painters.m_webview.m_lettertemplatemaintenance.Visible = false
	else
		m_pfe_cst_master_menu.m_system.m_painters.m_webview.m_lettertemplatemaintenance.Visible = true
	end if
	if of_security_access( 7270 ) = 0 THEN
		m_pfe_cst_master_menu.m_system.m_painters.m_webview.m_logoimage.Visible = false
	else
		m_pfe_cst_master_menu.m_system.m_painters.m_webview.m_logoimage.Visible = true
	end if
	if of_security_access( 7280 ) = 0 THEN
		m_pfe_cst_master_menu.m_system.m_painters.m_webview.m_privilegeviewoptions.Visible = false
	else
		m_pfe_cst_master_menu.m_system.m_painters.m_webview.m_privilegeviewoptions.Visible = true
	end if
	if of_security_access( 7290 ) = 0 THEN
		m_pfe_cst_master_menu.m_system.m_painters.m_webview.m_webviewaccessrolemanagement.Visible = false
	else
		m_pfe_cst_master_menu.m_system.m_painters.m_webview.m_webviewaccessrolemanagement.Visible = true
	end if
	if of_security_access( 7300 ) = 0 THEN
		m_pfe_cst_master_menu.m_system.m_painters.m_webview.m_webviewagreementspainter.Visible = false
	else
		m_pfe_cst_master_menu.m_system.m_painters.m_webview.m_webviewagreementspainter.Visible = true
	end if
	if of_security_access( 7310 ) = 0 THEN
		m_pfe_cst_master_menu.m_system.m_painters.m_webview.m_webviewsettingsmaintenance.Visible = false
	else
		m_pfe_cst_master_menu.m_system.m_painters.m_webview.m_webviewsettingsmaintenance.Visible = true
	end if
	if of_security_access( 7320 ) = 0 THEN
		m_pfe_cst_master_menu.m_system.m_painters.m_webview.m_webviewuserpainter.Visible = false
	else
		m_pfe_cst_master_menu.m_system.m_painters.m_webview.m_webviewuserpainter.Visible = true
	end if
	//------------------- APPEON END -------------------


	//------------------- APPEON BEGIN -------------------
	//$<add> Stephen 07.09.2012
	//$<reason>  v12.2 -V12.2 WebCrawler extract data 
	if  gi_prod_setting <> 0 then
		m_pfe_cst_master_menu.m_system.m_wc_data_audit.Visible = false
	else
		if of_security_access( 7330 ) = 0 THEN
			m_pfe_cst_master_menu.m_system.m_wc_data_audit.Visible = false
		else
			m_pfe_cst_master_menu.m_system.m_wc_data_audit.Visible = true
		end if
	end if
	if gb_contract_version then m_pfe_cst_master_menu.m_system.m_wc_data_audit.Visible = false //(Appeon)Alfee 07.26.2013 - V141 ISG-CLX 
	//------------------- APPEON END -------------------

	//------------------- APPEON BEGIN -------------------
	//added by Stephen 02.25.2013 
	//$<reason>Import audit -V12.3 Import Logging modifications
	if of_get_app_setting("set_9", "I") = 4 then
		m_pfe_cst_master_menu.m_system.m_imp_audit.Visible = false
	else
		IF w_mdi.of_security_access( 7380 ) = 0 THEN  
			m_pfe_cst_master_menu.m_system.m_imp_audit.Visible = false
		else
			m_pfe_cst_master_menu.m_system.m_imp_audit.Visible = True
		end if
	end if
	//------------------- APPEON END -------------------
	
	//---------Begin Added by (Appeon)Stephen 2013-07-31 for V141 File Packet creation--------
	if of_security_access( 7410 ) = 0 THEN
		m_pfe_cst_master_menu.m_system.m_communicationlogs.m_packagelog.Visible = false
	else
		m_pfe_cst_master_menu.m_system.m_communicationlogs.m_packagelog.Visible = true
	end if
	//---------End Added ------------------------------------------------------
	
	//---------Begin Added by (Appeon)Stephen 05.27.2014 for Using image OCR to import data into IntelliCred 14.2--------
	if of_security_access( 7760 ) = 0 or gb_contract_version THEN
		m_pfe_cst_master_menu.m_file.m_ocr_appl.Visible = false
	else
		m_pfe_cst_master_menu.m_file.m_ocr_appl.Visible = true
	end if
	//---------End Added ------------------------------------------------------
	
	//-------------appeon begin----------------------
	//<$>added:long.zhang 09.16.2013
	if of_security_access( 7711 ) = 0 or of_get_app_setting("set_recruit","I") = 0  THEN  //Start Code Change ----11.14.2013 #V14 maha - added module check
		m_pfe_cst_master_menu.m_file.m_recruitmentevaluations.Visible = false  //Start Code Change ----02.01.2016 #V15 maha - moved from system menu
	else
		m_pfe_cst_master_menu.m_file.m_recruitmentevaluations.Visible = true
	end if
		
//		if of_security_access( 7701 ) = 0 THEN
//			m_pfe_cst_master_menu.m_system.m_recruitmentfunction.m_recruitmentscreensettings.Visible = false
//		else
//			m_pfe_cst_master_menu.m_system.m_recruitmentfunction.m_recruitmentscreensettings.Visible = true
//		end if
//		
//		if of_security_access( 7721 ) = 0 THEN
//			m_pfe_cst_master_menu.m_system.m_recruitmentfunction.m_recruitmentwebsettings.Visible = false
//		else
//			m_pfe_cst_master_menu.m_system.m_recruitmentfunction.m_recruitmentwebsettings.Visible = true
//		end if
	//<$>reason:V14.1 Recruitment Functionality
	//-------------appeon End------------------------

	// letter painter
	IF of_security_access( 580 ) = 0 THEN
		m_pfe_cst_master_menu.m_system.m_painters.m_communication.m_letterpainter.Visible = False
	ELSE
		m_pfe_cst_master_menu.m_system.m_painters.m_communication.m_letterpainter.Visible = True
	END IF
	// lookup painter
	IF of_security_access( 560 ) = 0 THEN
		m_pfe_cst_master_menu.m_system.m_painters.m_lookups.m_lookuppainter.Visible = False
		m_pfe_cst_master_menu.m_system.m_painters.m_lookups.m_standingflagsettings.Visible = False  //Start Code Change ----02.28.2011 #V11 maha 
	ELSE
		m_pfe_cst_master_menu.m_system.m_painters.m_lookups.m_lookuppainter.Visible = True
		m_pfe_cst_master_menu.m_system.m_painters.m_lookups.m_standingflagsettings.Visible = True   //Start Code Change ----02.28.2011 #V11 maha
	END IF
	// profile painter
	IF of_security_access( 570 ) = 0 THEN
		m_pfe_cst_master_menu.m_system.m_painters.m_profiles.m_profilepainter.Visible = False
	ELSE
		m_pfe_cst_master_menu.m_system.m_painters.m_profiles.m_profilepainter.Visible = True
	END IF
	// export painter
	IF of_security_access( 550 ) = 0 THEN
		m_pfe_cst_master_menu.m_system.m_painters.m_datatransfer.m_outputpainter.Visible = False
	ELSE
		m_pfe_cst_master_menu.m_system.m_painters.m_datatransfer.m_outputpainter.Visible = True
	END IF
	//Start Code Change ---- 11.03.2005 #25 maha
	//Start Code Change ----01.04.2008 #V8 maha - added tool bar items
	IF of_security_access( 2190 ) = 0 THEN
		m_pfe_cst_master_menu.m_reports.m_runexport.Visible = False
		m_pfe_cst_master_menu.m_reports.m_runexport.ToolbarItemVisible = False
	ELSE
		m_pfe_cst_master_menu.m_reports.m_runexport.Visible = True
		if not ib_contract_menu then m_pfe_cst_master_menu.m_reports.m_runexport.ToolbarItemVisible = True
	END IF
	IF gi_export_on = 0 THEN
		m_pfe_cst_master_menu.m_reports.m_runexport.Visible = False
		m_pfe_cst_master_menu.m_system.m_painters.m_datatransfer.m_outputpainter.Visible = False
		if not ib_contract_menu then m_pfe_cst_master_menu.m_reports.m_runexport.ToolbarItemVisible = False
	END IF
	//End Code Change---01.04.2008		
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 07.26.2007 By: Evan (Import)
	//$<reason> New feature of import module.
	//IF of_security_access( 6928 ) = 0 THEN
	IF of_get_app_setting("set_import","I") = 0 OR of_security_access( 6928 ) = 0  THEN  //(Appeon)Alfee 06.29.2013 - V141 ISG-CLX
		m_pfe_cst_master_menu.m_system.m_painters.m_datatransfer.m_importpainter.Visible = False
	ELSE
		m_pfe_cst_master_menu.m_system.m_painters.m_datatransfer.m_importpainter.Visible = True
	END IF
	//---------------------------- APPEON END ----------------------------	
	
	IF of_security_access( 7221 ) = 0 THEN //added by Evan 05.23.2012 - for Privilege Procedures 
		m_pfe_cst_master_menu.m_system.m_painters.m_privilegesandqa.m_procedurelookup.Visible = False
	ELSE
		m_pfe_cst_master_menu.m_system.m_painters.m_privilegesandqa.m_procedurelookup.Visible = True
	END IF
	
	//Start Code Change ----05.04.2011 #V11 maha 
	IF of_security_access( 6928 ) = 0 and  of_security_access( 550 ) = 0 then
		m_pfe_cst_master_menu.m_system.m_painters.m_datatransfer.Visible = False
	else
		m_pfe_cst_master_menu.m_system.m_painters.m_datatransfer.Visible = True
	end if
	//End Code Change ----05.04.2011

	//dashboard.
	//Start Code Change ----04.16.2010 #V10 maha - all systems include dashboard so setting test not required
	//IF gnv_data.of_GetItem( "icred_settings", "set_dashb", False ) = '1' THEN //Added By Ken.Guo 2008-11-19
		IF of_security_access( 6942 ) = 0 THEN
			m_pfe_cst_master_menu.m_file.m_dashboard0.Visible = False
			m_pfe_cst_master_menu.m_file.m_dashboard0.toolbaritemvisible = False //(Appeon)Alfee 06.29.2013 - V141 ISG-CLX		
		ELSE
			m_pfe_cst_master_menu.m_file.m_dashboard0.Visible = True
			m_pfe_cst_master_menu.m_file.m_dashboard0.toolbaritemvisible = False  //(Appeon)Alfee 07.26.2013 - V141 ISG-CLX
			if gb_contract_module and as_menu_name <> "m_pfe_cst_mdi_menu_contract_am" then  
				m_pfe_cst_master_menu.m_file.m_dashboard0.toolbaritemvisible = True //(Appeon)Alfee 06.29.2013 - V141 ISG-CLX			
			end if
		END IF
	//ELSE
	//	m_pfe_cst_master_menu.m_file.m_dashboard0.Visible = False //Added By Ken.Guo 2008-11-19
	//END IF

	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 03.19.2009 By: Evan
	//$<reason> New feature of peer reference.
	//IF of_security_access( 6951 ) = 0 THEN
	IF of_security_access( 7601 ) = 0 THEN	 //(Appeon)Alfee 06.29.2013 - V141 ISG-CLX
		m_pfe_cst_master_menu.m_system.m_painters.m_lookups.m_peerrefpainter.Visible = False
	ELSE
		m_pfe_cst_master_menu.m_system.m_painters.m_lookups.m_peerrefpainter.Visible = True
	END IF
	//---------------------------- APPEON END ----------------------------
	//End Code Change---11.03.2005 		

	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 01.13.2010 By: Andy
	//$<reason> V10.1 - Notification Alert
	IF of_security_access( 7090 ) = 0 THEN
		m_pfe_cst_master_menu.m_system.m_painters.m_automation.m_notificationalertpainter.Visible = False
		m_pfe_cst_master_menu.m_system.m_painters.m_automation.m_dataflowpainter.Visible = False  //Start Code Change ----04.08.2010 #V10 maha
	ELSE
		m_pfe_cst_master_menu.m_system.m_painters.m_automation.m_notificationalertpainter.Visible = True
		m_pfe_cst_master_menu.m_system.m_painters.m_automation.m_dataflowpainter.Visible = True  //Start Code Change ----04.08.2010 #V10 maha
	END IF
	//---------------------------- APPEON END ----------------------------

	// survey painter
	//Start Code Change ---- 05.11.2006 #440 maha
	IF of_get_app_setting("set_site","I") = 0 THEN
		m_pfe_cst_master_menu.m_system.m_painters.m_systemsetup.m_surveypainter.Visible = False
	ELSE
		IF of_security_access( 590 ) = 0 THEN
			m_pfe_cst_master_menu.m_system.m_painters.m_systemsetup.m_surveypainter.Visible = False
		ELSE
			m_pfe_cst_master_menu.m_system.m_painters.m_systemsetup.m_surveypainter.Visible = True
		END IF
	END IF
	//End Code Change---05.10.2006

	// role painter
	IF of_security_access( 540 ) = 0 THEN
		m_pfe_cst_master_menu.m_system.m_painters.m_security.m_rolepainter.Visible = False
	ELSE
		m_pfe_cst_master_menu.m_system.m_painters.m_security.m_rolepainter.Visible = True
	END IF
	// user painter
	IF of_security_access( 900 ) = 0 THEN
		m_pfe_cst_master_menu.m_system.m_painters.m_security.m_userpainter.Visible = False
	ELSE
		m_pfe_cst_master_menu.m_system.m_painters.m_security.m_userpainter.Visible = True
	END IF
	// field audit - use the audit trail, commented by Eugene 11.13.2013 
	//	IF of_security_access( 600 ) = 0 THEN
	//		m_pfe_cst_master_menu.m_system.m_audittrail.Visible = False
	//	ELSE
	//		m_pfe_cst_master_menu.m_system.m_audittrail.Visible = True
	//	END IF
	// view painter
	IF of_security_access( 800 ) = 0 THEN
		m_pfe_cst_master_menu.m_system.m_painters.m_screensetup.m_viewpainter.Visible = False
	ELSE
		m_pfe_cst_master_menu.m_system.m_painters.m_screensetup.m_viewpainter.Visible = True
	END IF
	
	IF gi_imaging = 0 THEN
		m_pfe_cst_master_menu.m_system.m_painters.m_systemsetup.m_imagetypepainter.Visible = False
	ELSE
		IF of_security_access( 1370 ) = 0 THEN
			m_pfe_cst_master_menu.m_system.m_painters.m_systemsetup.m_imagetypepainter.Visible = False
		ELSE
			m_pfe_cst_master_menu.m_system.m_painters.m_systemsetup.m_imagetypepainter.Visible = True
		END IF
	END IF
	// multi app painter   maha112701
	IF of_security_access( 1360 ) = 0 THEN
		m_pfe_cst_master_menu.m_system.m_painters.m_systemsetup.m_multiapppainter.Visible = False
	ELSE
		m_pfe_cst_master_menu.m_system.m_painters.m_systemsetup.m_multiapppainter.Visible = True
	END IF
	// system utilities   maha112701
	IF of_security_access( 1340 ) = 0 THEN
		m_pfe_cst_master_menu.m_system.m_utilities.Visible = False
	ELSE
		m_pfe_cst_master_menu.m_system.m_utilities.Visible = True
	END IF
	// system Delete Practitioner   maha012103
	IF of_security_access( 1440 ) = 0 THEN
		m_pfe_cst_master_menu.m_system.m_deletepractitioner.Visible = False
	ELSE
		m_pfe_cst_master_menu.m_system.m_deletepractitioner.Visible = True
	END IF
	
	// system Audit Trail   maha012103 
	IF of_security_access( 1450 ) = 0 THEN
		m_pfe_cst_master_menu.m_system.m_audittrail.Visible = False
		m_pfe_cst_master_menu.m_system.m_audittrail.ToolbarItemVisible = False  //(Appeon)Eugene 11.13.2013 - V141 ISG-CLX		
	ELSE
		m_pfe_cst_master_menu.m_system.m_audittrail.Visible = True
		IF Lower(as_menu_name) = "m_pfe_cst_mdi_menu_contract" THEN 
			m_pfe_cst_master_menu.m_system.m_audittrail.ToolbarItemVisible = True //(Appeon)Eugene 11.13.2013 - V141 ISG-CLX
		ELSE
			m_pfe_cst_master_menu.m_system.m_audittrail.ToolbarItemVisible = False //(Appeon)Eugene 11.13.2013 - V141 ISG-CLX
		END IF					
	END IF
	// system batch update   maha112701
	IF of_security_access( 1350 ) = 0 THEN
		m_pfe_cst_master_menu.m_system.m_batchupdate.Visible = False
	ELSE
		m_pfe_cst_master_menu.m_system.m_batchupdate.Visible = True
	END IF
	// intellireports maha 092302 else 020404
	IF gi_ireport_on = 0 THEN
		m_pfe_cst_master_menu.m_reports.m_intellireport.Visible = False
		m_pfe_cst_master_menu.m_reports.m_intellireport.ToolbarItemVisible = False
	ELSE
		IF of_security_access( 1470 ) = 0 THEN
			m_pfe_cst_master_menu.m_reports.m_intellireport.Visible = False
			m_pfe_cst_master_menu.m_reports.m_intellireport.ToolbarItemVisible = False
		ELSE
			m_pfe_cst_master_menu.m_reports.m_intellireport.Visible = True
			if not ib_contract_menu then m_pfe_cst_master_menu.m_reports.m_intellireport.ToolbarItemVisible = True
		END IF
	END IF
	// Group Practice maha 012103
	IF of_security_access( 1320 ) = 0 THEN
		m_pfe_cst_master_menu.m_file.m_grouppractices.Visible = False
		m_pfe_cst_master_menu.m_file.m_grouppractices.Enabled = False //Start Code Change ----07.07.2009 #V92 maha - block shortcut keys
		m_pfe_cst_master_menu.m_file.m_grouppractices.ToolbarItemVisible = False //Start Code Change ----02.02.2010 #V10 maha
	ELSE
		m_pfe_cst_master_menu.m_file.m_grouppractices.Visible = True
		m_pfe_cst_master_menu.m_file.m_grouppractices.Enabled = True //Start Code Change ----07.07.2009 #V92 maha 
		if not ib_contract_menu then m_pfe_cst_master_menu.m_file.m_grouppractices.ToolbarItemVisible = True //Start Code Change ----02.02.2010 #V10 maha
		
	END IF
	// Site Survey maha 102103
	IF of_get_app_setting("set_site","I") = 0 THEN   //Start Code Change ----10.24.2013 #V14 maha
		m_pfe_cst_master_menu.m_file.m_sitesurvey.Visible = False
	else
		IF of_security_access( 1430 ) = 0 THEN
			m_pfe_cst_master_menu.m_file.m_sitesurvey.Visible = False
		ELSE
			m_pfe_cst_master_menu.m_file.m_sitesurvey.Visible = True
		END IF
	end if

	//system batch add apps   maha020404
	IF of_security_access( 1590 ) = 0 THEN
		m_pfe_cst_master_menu.m_system.m_batchaddapplications.Visible = False
	ELSE
		m_pfe_cst_master_menu.m_system.m_batchaddapplications.Visible = True
	END IF
	// system intellibatch   maha020204
	IF of_security_access( 2000 ) = 0 THEN
		m_pfe_cst_master_menu.m_system.m_intellibatch.Visible = False
		m_pfe_cst_master_menu.m_system.m_painters.m_systemsetup.m_intellibatchpainter.Visible = False
	ELSE
		m_pfe_cst_master_menu.m_system.m_intellibatch.Visible = True
		m_pfe_cst_master_menu.m_system.m_painters.m_systemsetup.m_intellibatchpainter.Visible = True
	END IF


	// fax template painter   maha110904
	IF of_security_access( 2050 ) = 0 THEN
		m_pfe_cst_master_menu.m_system.m_painters.m_communication.m_faxemailtemplatepainter.Visible = False
	ELSE
		m_pfe_cst_master_menu.m_system.m_painters.m_communication.m_faxemailtemplatepainter.Visible = True
	END IF
	
	//---------Begin Added by Alfee 03.24.2008---------------------------------
	IF gb_contract_version THEN
		m_pfe_cst_master_menu.m_system.m_browseweb.Visible = False
		m_pfe_cst_master_menu.m_reports.m_npdbreports.Visible = False
		m_pfe_cst_master_menu.m_reports.m_npdbreports.ToolbarItemVisible = False
	ELSE
		m_pfe_cst_master_menu.m_system.m_browseweb.Visible = True
		m_pfe_cst_master_menu.m_reports.m_npdbreports.Visible = True
		if not ib_contract_menu then m_pfe_cst_master_menu.m_reports.m_npdbreports.ToolbarItemVisible = True
	END IF
	//--------End Added -------------------------------------------------------		

	IF of_security_access( 260 ) = 0 And Not gb_contract_version THEN //run action items maha 012505
		m_pfe_cst_master_menu.m_system.m_browseweb.Visible = False
		 //Start Code Change ----11.18.2015 #V15 maha
		//m_pfe_cst_master_menu.m_system.m_batchoig.Visible = False
		m_pfe_cst_master_menu.m_system.m_verificationbatchfunctions.m_batchoig.Visible = False
		//m_pfe_cst_master_menu.m_system.m_importoigdata.Visible = False
		m_pfe_cst_master_menu.m_system.m_verificationbatchfunctions.m_importoigdata.Visible = False
		 //Start Code Change ----11.18.2015
		m_pfe_cst_master_menu.m_reports.m_npdbreports.Visible = False
		m_pfe_cst_master_menu.m_reports.m_npdbreports.ToolbarItemVisible = False
		//Start Code Change ----07.11.2008 #V81 maha - added exceptions for non-inherited menus; isvalid did not work
		IF as_menu_name <> "m_pfe_cst_app_audit"  And  as_menu_name <> "m_pfe_cst_meetings" And  as_menu_name <> "m_pfe_cst_prac_meetings" And PosA( as_menu_name, "m_pfe_cst_imaging" ) = 0  THEN
			IF IsValid(m_pfe_cst_mdi_menu) THEN
				m_pfe_cst_mdi_menu.m_system.m_runactionitemsquery.Visible = False
			END IF
		END IF
		//End Code Change---07.11.2008
		m_pfe_cst_master_menu.m_window.m_dashboard.Visible = False
	END IF

	//IF of_security_access( 2020 ) = 0  And of_security_access( 2040 ) = 0 THEN //Start Code Change ----02.29.2008 #V8 maha - added peer parameter
	IF of_security_access( 7021 ) = 0  then //Added by  Nova 12.04.2009 --v10.1 Profiles Build out
		m_pfe_cst_master_menu.m_file.m_qualityprofilemeasurements.Visible = False
		m_pfe_cst_master_menu.m_file.m_qualityprofilemeasurements.ToolbarItemVisible = False
	ELSE
		m_pfe_cst_master_menu.m_file.m_qualityprofilemeasurements.Visible = True
		if not ib_contract_menu then m_pfe_cst_master_menu.m_file.m_qualityprofilemeasurements.ToolbarItemVisible = True
	END IF
	//QA Painter
	IF of_get_app_setting("set_qa","I") = 0 THEN
		m_pfe_cst_master_menu.m_system.m_painters.m_privilegesandqa.m_reappointmentmeasurements.Visible = False
		m_pfe_cst_master_menu.m_system.m_painters.m_privilegesandqa.m_qametriclookup.Visible = False  //Start Code Change ----03.01.2011 #V11 maha 
	ELSE
		IF of_security_access( 2010 ) = 0 THEN
			m_pfe_cst_master_menu.m_system.m_painters.m_privilegesandqa.m_reappointmentmeasurements.Visible = False
			m_pfe_cst_master_menu.m_system.m_painters.m_privilegesandqa.m_qametriclookup.Visible = False  //Start Code Change ----03.01.2011 #V11 maha 
		ELSE
			m_pfe_cst_master_menu.m_system.m_painters.m_privilegesandqa.m_reappointmentmeasurements.Visible = True
			m_pfe_cst_master_menu.m_system.m_painters.m_privilegesandqa.m_qametriclookup.Visible = True  //Start Code Change ----03.01.2011 #V11 maha 
		END IF
	END IF
	
	//Start Code Change ----02.05.2008 #V8 maha moved here from below and added security access code
	//PEER Review
	IF of_get_app_setting("set_peer","I") = 0 THEN
		m_pfe_cst_master_menu.m_file.m_casepeerreview.Visible = False
		//m_pfe_cst_master_menu.m_file.m_casepeerreview.toolbaritemVisible = FALSE
	ELSE //if peer is valid
		IF of_security_access(2040 ) > 0  THEN
			m_pfe_cst_master_menu.m_file.m_casepeerreview.Visible = True
		ELSE
			m_pfe_cst_master_menu.m_file.m_casepeerreview.Visible = False
		END IF
	END IF
	//End Code Change---02.05.2008

	//CONTRACTS maha app100405
	IF of_get_app_setting("set_cont","I") = 0 THEN //app setting
		m_pfe_cst_master_menu.m_file.m_contract.Visible = False
		m_pfe_cst_master_menu.m_file.m_contract.ToolbarItemVisible = False
		m_pfe_cst_master_menu.m_system.m_painters.m_contractrequirementprofile.Visible = False
		
		IF IsValid(m_pfe_cst_mdi_menu) THEN
			m_pfe_cst_mdi_menu.m_file.m_contacts.ToolbarItemVisible = False //Added by Scofield on 2007-12-19
			m_pfe_cst_mdi_menu.m_file.m_contacts.Visible = False
		END IF
	ELSE
		//Start Code Change ----02.05.2008 #V8 maha - wiil be set visible if appropriate down in the case statement
		IF IsValid(m_pfe_cst_mdi_menu) THEN
			m_pfe_cst_mdi_menu.m_file.m_contacts.ToolbarItemVisible = False
			m_pfe_cst_mdi_menu.m_file.m_contacts.Visible = False
		END IF
		
		IF of_security_access( 2070 ) = 0 THEN //user security
			m_pfe_cst_master_menu.m_file.m_contract.Visible = False
			m_pfe_cst_master_menu.m_file.m_contract.ToolbarItemVisible = False
			m_pfe_cst_master_menu.m_system.m_painters.m_contractrequirementprofile.Visible = False
		ELSE
			m_pfe_cst_master_menu.m_file.m_contract.Visible = True
			IF as_menu_name <> "m_pfe_cst_mdi_menu_contract_am" THEN m_pfe_cst_master_menu.m_file.m_contract.ToolbarItemVisible = True//add if statement - (Appeon)Alfee 08.02.2013 - V141 ISG-CLX			
			m_pfe_cst_master_menu.m_system.m_painters.m_contractrequirementprofile.Visible = True
		END IF	
	END IF

	//Start Code Change ---- 12.02.2005 #158 maha
	//Question painter maha app101305
	IF of_security_access( 2210 ) = 0 THEN
		m_pfe_cst_master_menu.m_system.m_painters.m_lookups.m_questionpainter.Visible = False
	ELSE
		m_pfe_cst_master_menu.m_system.m_painters.m_lookups.m_questionpainter.Visible = True
	END IF
	//End Code Change---12.02.2005

	//Letter Storage Area Painter
	IF gnv_data.of_getitem('icred_settings' ,'set_50' , False ) = '1' Or &
		appeongetclienttype() <> 'PB' THEN
		IF of_security_access( 5010 ) > 0 THEN
			m_pfe_cst_master_menu.m_system.m_painters.m_communication.m_letterstorageareapainter.Visible = True
		ELSE
			m_pfe_cst_master_menu.m_system.m_painters.m_communication.m_letterstorageareapainter.Visible = False
		END IF
	ELSE
		m_pfe_cst_master_menu.m_system.m_painters.m_communication.m_letterstorageareapainter.Visible = False
	END IF

	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 11.06.2006 By: Jack (IntelliContract Agreement Manager Painters)
	//$<reason> The following script determines whether the menu item Clause Library Painter£¬Template Library Painter£¬Document Library Painter appears or not.
	IF gb_agreement_manager And gnv_data.of_getitem('icred_settings' ,'set_cont' , False ) = '1' THEN
		IF of_security_access( 6800 ) = 0 And of_security_access( 6801 ) = 0 And of_security_access( 6802 ) = 0 THEN
			m_pfe_cst_master_menu.m_system.m_painters.m_agreement.Visible = False //Added by Scofield on 2008-11-12
		ELSE
			m_pfe_cst_master_menu.m_system.m_painters.m_agreement.Visible = True
			IF of_security_access( 6800 ) = 0 THEN
				m_pfe_cst_master_menu.m_system.m_painters.m_agreement.m_clauselibrarypainter.Visible = False
			ELSE
				m_pfe_cst_master_menu.m_system.m_painters.m_agreement.m_clauselibrarypainter.Visible = True
			END IF
			IF of_security_access( 6801 ) = 0 THEN
				m_pfe_cst_master_menu.m_system.m_painters.m_agreement.m_templatelibrarypainter.Visible = False
			ELSE
				m_pfe_cst_master_menu.m_system.m_painters.m_agreement.m_templatelibrarypainter.Visible = True
			END IF
			IF of_security_access( 6802 ) = 0 THEN
				m_pfe_cst_master_menu.m_system.m_painters.m_agreement.m_documentlibrarypainter.Visible = False
			ELSE
				m_pfe_cst_master_menu.m_system.m_painters.m_agreement.m_documentlibrarypainter.Visible = True
			END IF
		END IF
	ELSE
		m_pfe_cst_master_menu.m_system.m_painters.m_agreement.Visible = False
	END IF

	//Only for Buy side
	IF gnv_data.of_getitem('icred_settings' ,'set_cont' , False ) = '1' And &
		gnv_data.of_getitem('icred_settings' ,'set_51' , False ) = '3' And &
		of_security_access( 6802 ) <> 0 	THEN
	ELSE
		m_pfe_cst_master_menu.m_system.m_painters.m_agreement.m_documentlibrarypainter_l2.Visible = False
	END IF

	//Setup WorkFlow and Email Painter menu item.
	IF of_get_app_setting("set_47","I") = 0 THEN
		m_pfe_cst_master_menu.m_system.m_painters.m_systemsetup.m_workflowpainter.Visible = False
	ELSE
		IF of_security_access( 5830 ) = 0 THEN
			m_pfe_cst_master_menu.m_system.m_painters.m_systemsetup.m_workflowpainter.Visible = False
		ELSE
			m_pfe_cst_master_menu.m_system.m_painters.m_systemsetup.m_workflowpainter.Visible = True
		END IF
		IF of_security_access( 5831 ) = 0 THEN
			m_pfe_cst_master_menu.m_system.m_painters.m_communication.m_emailpainter.Visible = False
		ELSE
			m_pfe_cst_master_menu.m_system.m_painters.m_communication.m_emailpainter.Visible = True
		END IF
	END IF

	//Setup To Do List Menu Item
	IF Not gb_ToDoList THEN
		m_pfe_cst_master_menu.m_system.m_painters.m_systemsetup.m_todolistpainter.Visible = False
		m_pfe_cst_master_menu.m_file.m_todolist.Visible = False
		m_pfe_cst_master_menu.m_file.m_todolist.ToolbarItemVisible = False
	ELSE
		IF of_security_access( 5840 ) = 0 THEN
			m_pfe_cst_master_menu.m_system.m_painters.m_systemsetup.m_todolistpainter.Visible = False
		ELSE
			m_pfe_cst_master_menu.m_system.m_painters.m_systemsetup.m_todolistpainter.Visible = True
		END IF
		IF of_security_access( 5850 ) = 0 THEN
			m_pfe_cst_master_menu.m_file.m_todolist.Visible = False
			m_pfe_cst_master_menu.m_file.m_todolist.ToolbarItemVisible = False
		ELSE
			m_pfe_cst_master_menu.m_file.m_todolist.Visible = True
			if not ib_contract_menu then m_pfe_cst_master_menu.m_file.m_todolist.ToolbarItemVisible = True
		END IF
	END IF

	//Making the Contract Module a Standalone Product
	IF of_get_app_setting("set_cont","I") = 0 THEN //app setting
		m_pfe_cst_master_menu.m_system.m_painters.m_screensetup.m_contractdatascreenpainter.Visible = False
		m_pfe_cst_master_menu.m_system.m_painters.m_screensetup.m_contractviewpainter.Visible = False
	ELSE
		IF of_security_access( 5300 ) = 0 THEN //user security contract screen painter
			m_pfe_cst_master_menu.m_system.m_painters.m_screensetup.m_contractdatascreenpainter.Visible = False
		ELSE
			m_pfe_cst_master_menu.m_system.m_painters.m_screensetup.m_contractdatascreenpainter.Visible = True
		END IF
		
		IF of_security_access( 5400 ) = 0 THEN //user security contract view painter
			m_pfe_cst_master_menu.m_system.m_painters.m_screensetup.m_contractviewpainter.Visible = False
		ELSE
			m_pfe_cst_master_menu.m_system.m_painters.m_screensetup.m_contractviewpainter.Visible = True
		END IF
	END IF


	//user security Scan OIG
	IF of_security_access( 5500 ) = 0 THEN
		//m_pfe_cst_master_menu.m_system.m_batchoig.Visible = False   //Start Code Change ----11.18.2015 #V15 maha
		m_pfe_cst_master_menu.m_system.m_verificationbatchfunctions.m_batchoig.Visible = False
	ELSE
	//	m_pfe_cst_master_menu.m_system.m_batchoig.Visible = True   //Start Code Change ----11.18.2015 #V15 maha
		m_pfe_cst_master_menu.m_system.m_verificationbatchfunctions.m_batchoig.Visible = True
	END IF
	
	
	//user security Import OIG
	IF of_security_access( 5510 ) = 0 THEN
		//m_pfe_cst_master_menu.m_system.m_importoigdata.Visible = False //Start Code Change ----11.18.2015 #V15 maha
		m_pfe_cst_master_menu.m_system.m_verificationbatchfunctions.m_importoigdata.Visible = False
	ELSE
		//m_pfe_cst_master_menu.m_system.m_importoigdata.Visible = True //Start Code Change ----11.18.2015 #V15 maha
		m_pfe_cst_master_menu.m_system.m_verificationbatchfunctions.m_importoigdata.Visible = True
	END IF
	


	//User ID Batch Update
	IF of_security_access( 5511 ) = 0 THEN
		m_pfe_cst_master_menu.m_system.m_useridbatchupdate.Visible = False
	ELSE
		IF gnv_data.of_getitem('icred_settings' ,'set_cont' , False ) = '1' THEN
			m_pfe_cst_master_menu.m_system.m_useridbatchupdate.Visible = True
		ELSE
			m_pfe_cst_master_menu.m_system.m_useridbatchupdate.Visible = False
		END IF
	END IF

	IF of_get_app_setting("set_cont","I") = 1 THEN //app setting	//Start Code Change ----06.24.2009 #V92 maha
		IF of_security_access( 5600 ) = 0 And of_security_access( 5700 ) = 0 THEN //Added by Scofield on 2008-11-12
			m_pfe_cst_master_menu.m_system.m_painters.m_contractrequirementprofile.Visible = False
		ELSE
			m_pfe_cst_master_menu.m_system.m_painters.m_contractrequirementprofile.Visible = True
			
			//user security Contract Requirement Profile
			IF of_security_access( 5600 ) = 0 THEN
				m_pfe_cst_master_menu.m_system.m_painters.m_contractrequirementprofile.m_contractrequirementprofile0.Visible = False
			ELSE
				m_pfe_cst_master_menu.m_system.m_painters.m_contractrequirementprofile.m_contractrequirementprofile0.Visible = True
			END IF
			
			//user security Code Import (CPT Code)
			IF of_security_access( 5700 ) = 0 THEN
				m_pfe_cst_master_menu.m_system.m_painters.m_contractrequirementprofile.m_cptcode.Visible = False
			ELSE
				m_pfe_cst_master_menu.m_system.m_painters.m_contractrequirementprofile.m_cptcode.Visible = True
			END IF
		END IF
	END IF

	// system Audit Trail   maha012103
	If (gb_contract_version Or w_mdi.of_security_access( 5800 ) = 0) And w_mdi.of_security_access( 5810 ) = 0 THEN
		m_pfe_cst_master_menu.m_system.m_audittrail.Visible = False
		m_pfe_cst_master_menu.m_system.m_audittrail.ToolbarItemVisible = False //(Appeon)Eugene 11.13.2013 - V141 ISG-CLX
	END IF
	
	// Fix a defect.
	IF gb_contract_version THEN
		m_pfe_cst_master_menu.m_system.m_1.Visible = False
	END IF

	// If the software setting = IntelliContract then Change File->Group Practices menu 
	// to be renamed to File->Locations - 09.13.2006 By: LeiWei
	IF gb_contract_version THEN
		m_pfe_cst_master_menu.m_file.m_grouppractices.Text = "&Locations"
		//m_pfe_cst_master_menu.m_file.m_exit.Text = "E&xit IntelliContract~tAlt+F4"  //Start Code Change ----01.14.2011 #V11 maha  - removed
		m_pfe_cst_master_menu.m_reports.m_letters.Text = "Contract Correspondence"
		m_pfe_cst_master_menu.m_file.m_grouppractices.ToolbarItemVisible = False //Start Code Change ----02.02.2010 #V10 maha
		IF IsValid(m_pfe_cst_mdi_menu) THEN //Start Code Change ---- 10.31.2006 #1 maha
			m_pfe_cst_mdi_menu.m_system.m_runactionitemsquery.Text = "Run Date Email Alarm Query"
		END IF
	ELSE
		m_pfe_cst_master_menu.m_file.m_grouppractices.Text = "&Group Practices"
		//m_pfe_cst_master_menu.m_file.m_exit.Text = "E&xit IntelliCred~tAlt+F4"  //Start Code Change ----01.14.2011 #V11 maha  - removed
		m_pfe_cst_master_menu.m_reports.m_letters.Text = "Practitioner Correspondence"
		
		IF IsValid(m_pfe_cst_mdi_menu) THEN //Start Code Change ---- 10.31.2006 #1 maha
			//---------Begin Modified by Alfee on 05.12.2008 ------------------------------
			IF gb_contract_module THEN
				m_pfe_cst_mdi_menu.m_system.m_runactionitemsquery.Text = "Run Email and Action Items Query"
			ELSE
				m_pfe_cst_mdi_menu.m_system.m_runactionitemsquery.Text = "Run Action Items Query"
			END IF
			//m_pfe_cst_mdi_menu.m_system.m_runactionitemsquery.text = "Run Action Items Query"
			//---------End Modified --------------------------------------------------------
		END IF
	END IF

	//Set security of Global Search.
	IF gs_dbtype = "SQL" And gnv_data.of_getitem('icred_settings' ,'set_48' , False ) = '1' And w_mdi.of_security_access( 2076 ) >= 1 And gnv_data.of_getitem('icred_settings' ,'set_cont' , False ) = '1' THEN
		m_pfe_cst_master_menu.m_file.m_contractglobalsearch.Visible = True
		m_pfe_cst_master_menu.m_file.m_contractglobalsearch.ToolbarItemVisible = True
	ELSE
		m_pfe_cst_master_menu.m_file.m_contractglobalsearch.Visible = False
		m_pfe_cst_master_menu.m_file.m_contractglobalsearch.ToolbarItemVisible = False
	END IF

	//Start Code Change ---- 10.03.2006 #630 maha
	IF of_get_app_setting("set_19","I") = 20 THEN
		m_pfe_cst_master_menu.m_file.m_importdata.Visible = True
	ELSE
		m_pfe_cst_master_menu.m_file.m_importdata.Visible = False
	END IF
	//End Code Change---10.03.2006	

	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 05.22.2007 By: Frank.Gui
	TRY
		//IF of_get_app_setting("set_9","I") = 4 Or of_security_access( 6927 ) = 0 THEN //WebView Required Document Template Action ID=6927
		IF gb_webview = false Or of_security_access( 6927 ) = 0 THEN //Start Code Change ----08.25.2011 #V11 maha - changed to global variable
			m_pfe_cst_master_menu.m_system.m_painters.m_webview.Visible = False
			m_pfe_cst_master_menu.m_system.m_painters.m_webview.m_webviewtemplatepainter.Visible = False
			m_pfe_cst_master_menu.m_system.m_painters.m_webview.m_practitionerhelp.Visible = False   //Start Code Change ----03.01.2011 #V11 maha 
			//m_pfe_cst_master_menu.m_system.m_webviewtracking.Visible = False  //Start Code Change ----08.25.2011 #V11 maha - new item
			m_pfe_cst_master_menu.m_system.m_webviewfunctions.Visible = False  //Start Code Change ----11.14.2011 #V112maha - changed hierarchy
		//ELSE
		ELSEIF NOT gb_contract_version THEN  //(Appeon)Alfee 06.29.2013 - V141 ISG-CLX
			m_pfe_cst_master_menu.m_system.m_painters.m_webview.Visible = True
			m_pfe_cst_master_menu.m_system.m_painters.m_webview.m_webviewtemplatepainter.Visible = True
			m_pfe_cst_master_menu.m_system.m_painters.m_webview.m_practitionerhelp.Visible = True  //Start Code Change ----03.01.2011 #V11 maha 
			//m_pfe_cst_master_menu.m_system.m_webviewtracking.Visible = True  //Start Code Change ----08.25.2011 #V11 maha - new item
			m_pfe_cst_master_menu.m_system.m_webviewfunctions.Visible = True  //Start Code Change ----11.14.2011 #V112maha - changed hierarchy
		END IF
		IF gb_contract_version THEN m_pfe_cst_master_menu.m_system.m_webviewfunctions.Visible = False  //(Appeon)Alfee 07.25.2013 - V141 ISG-CLX
	Catch(exception ex)
	END TRY
	//---------------------------- APPEON END ----------------------------
	
	//Start Code Change ----05.11.2016 #V15 maha
	if gb_contract_version or gb_webview = false then
		m_pfe_cst_master_menu.m_system.m_webviewfunctions.m_wvaffletterlog.Visible = false
	else
		if of_security_access( 7821 ) = 0 THEN
			m_pfe_cst_master_menu.m_system.m_webviewfunctions.m_wvaffletterlog.Visible= false
		else
			m_pfe_cst_master_menu.m_system.m_webviewfunctions.m_wvaffletterlog.Visible = True
		end if
	End if
	//End Code Change ----05.11.2016	
	

	//Start Code Change ----02.05.2008 #V8 maha - Security added in version 8
	//Help - Updates
	IF of_security_access( 6933 ) = 0 THEN
		m_pfe_cst_master_menu.m_help.m_updates.Visible = False
	ELSE
		m_pfe_cst_master_menu.m_help.m_updates.Visible = True
	END IF

	m_pfe_cst_master_menu.m_help.m_newdevtesting.Visible = False
	//Start Code Change ----04.01.2009 #V92 maha - CAQH Import menu item
	IF of_security_access( 7100 ) = 0 THEN  //Start Code Change ----02.02.2010 #V10 maha - changed from 20 (add prac)
		m_pfe_cst_master_menu.m_file.m_caqhfileimport.Visible = False
		m_pfe_cst_master_menu.m_file.m_caqhfileimport.ToolbarItemVisible = False
	//ELSE
	ELSEIF NOT gb_contract_version THEN  //(Appeon)Alfee 06.29.2013 - V141 ISG-CLX
		m_pfe_cst_master_menu.m_file.m_caqhfileimport.Visible = True
		if not ib_contract_menu and as_menu_name <> "m_pfe_cst_mdi_dashboard" then  //add if statement - (Appeon)Alfee 06.29.2013 - V141 ISG-CLX 
			m_pfe_cst_master_menu.m_file.m_caqhfileimport.ToolbarItemVisible = True
		end if
	END IF
	//End Code Change---04.01.2009

	//Start Code Change ----02.02.2010 #V10 maha - Schedule painter
	IF of_security_access( 7110 ) = 0 THEN  
		m_pfe_cst_master_menu.m_system.m_painters.m_automation.m_schedulerpainter.visible = false
	else
		m_pfe_cst_master_menu.m_system.m_painters.m_automation.m_schedulerpainter.visible = True
	end if

	//Notification Painter / Data Flow
	IF of_security_access( 7090 ) = 0 THEN  
		m_pfe_cst_master_menu.m_system.m_painters.m_automation.m_notificationalertpainter.visible = false
		m_pfe_cst_master_menu.m_system.m_painters.m_automation.m_dataflowpainter.Visible = False
	else
		m_pfe_cst_master_menu.m_system.m_painters.m_automation.m_notificationalertpainter.visible = True
		m_pfe_cst_master_menu.m_system.m_painters.m_automation.m_dataflowpainter.Visible = True
	end if
	
	//launch pad
	IF of_security_access( 7140 ) = 0 THEN  
		m_pfe_cst_master_menu.m_file.m_launchpad.visible = false
	else
		m_pfe_cst_master_menu.m_file.m_launchpad.visible = True
	end if
	if gb_contract_version then m_pfe_cst_master_menu.m_file.m_launchpad.visible = false //(Appeon)Alfee 06.29.2013 - V141 ISG-CLX	
	//End Code Change---02.02.2010
	
	 //Start Code Change ----07.09.2013 #V14 maha - CALL Log
	If of_get_app_setting("set_call_log","I")	= 1 and of_security_access( 7661 ) > 0 THEN  
		m_pfe_cst_master_menu.m_file.m_contactlog.visible = true
	else
		m_pfe_cst_master_menu.m_file.m_contactlog.visible = false
	end if
	
	 //Start Code Change ----07.18.2013 #V14 maha - open CALL s
	If of_get_app_setting("set_call_log","I")	= 1 and of_security_access( 7671 ) > 0 THEN  
		m_pfe_cst_master_menu.m_file.m_contactopencalls.visible = true
	else
		m_pfe_cst_master_menu.m_file.m_contactopencalls.visible = false
	end if

	//Start Code Change ----09.29.2016 #V152 maha
	If of_get_app_setting("set_35","I")	= 2  and of_security_access( 7827 ) > 0 THEN  
		m_pfe_cst_master_menu.m_file.m_invoices.visible = true
	else
		m_pfe_cst_master_menu.m_file.m_invoices.visible = false
	end if
	
	 //Start Code Change ----06.01.2017 #V154 maha - texting: batch and logs
	If of_security_access( 7855 ) > 0 THEN  
		m_pfe_cst_master_menu.m_system.m_batchprovidertext.visible = true
	else
		m_pfe_cst_master_menu.m_system.m_batchprovidertext.visible = false
	end if
	
	If of_security_access( 7856 ) > 0 THEN  
		m_pfe_cst_master_menu.m_system.m_communicationlogs.m_textinglog.visible = true
	else
		m_pfe_cst_master_menu.m_system.m_communicationlogs.m_textinglog.visible = false
	end if

	//########################## this section for items on mdi menu but not on master ##########################
	//Start Code Change ----02.05.2008 #V8 maha    
	IF IsValid(m_pfe_cst_mdi_menu) THEN
		//Change password- readded 02.05.2008		
		IF of_security_access( 2200 ) = 0 THEN
			m_pfe_cst_mdi_menu.m_system.m_changepassword.Visible = False
		ELSE
			m_pfe_cst_mdi_menu.m_system.m_changepassword.Visible = True
		END IF
		
		//Email
		//---------Begin Added by (Appeon)Alfee 06.29.2013 for V141 ISG-CLX--------
		If gl_unread_email_cnt > 0 Then
			m_pfe_cst_mdi_menu.m_system.m_emailsignature.m_emailsentitems.ToolbarItemName = 'folder_full.png'  //Start Code Change ----03.28.2016 #V15 maha - was home_fill.gif
		Else
			m_pfe_cst_mdi_menu.m_system.m_emailsignature.m_emailsentitems.ToolbarItemName = 'folder_man.png'//Start Code Change ----03.28.2016 #V15 maha - was home.gif
		End If
		//---------End Added ------------------------------------------------------------------					
		IF of_security_access( 6931 ) = 0 THEN //email
			m_pfe_cst_mdi_menu.m_system.m_emailsignature.m_emailsignature2.Visible = False
			m_pfe_cst_mdi_menu.m_system.m_emailsignature.m_personalaccount.Visible = False
			m_pfe_cst_mdi_menu.m_system.m_newmailmessage.Visible = False
			//---------Begin Added by (Appeon)Alfee 06.29.2013 for V141 ISG-CLX--------
			m_pfe_cst_mdi_menu.m_file.m_new_mail_message.visible = false
			m_pfe_cst_mdi_menu.m_system.m_emailsignature.m_emailsentitems.visible = False 
			m_pfe_cst_mdi_menu.m_system.m_emailsignature.m_emailsentitems.ToolbarItemVisible = False 
			If as_menu_name = 'm_pfe_cst_mdi_menu_contract_am' Then
				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_email0.visible = False 
				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_email0.ToolbarItemVisible = False 
			End If
			//---------End Added ------------------------------------------------------------------			
		ELSE
			m_pfe_cst_mdi_menu.m_system.m_emailsignature.m_emailsignature2.Visible = True
			m_pfe_cst_mdi_menu.m_system.m_emailsignature.m_personalaccount.Visible = True	
			//---------Begin Modified by (Appeon)Alfee 06.29.2013 for V141 ISG-CLX--------			
			//m_pfe_cst_mdi_menu.m_system.m_newmailmessage.Visible = True
			m_pfe_cst_mdi_menu.m_system.m_emailsignature.m_emailsentitems.visible = True 			
			m_pfe_cst_mdi_menu.m_system.m_emailsignature.m_emailsentitems.ToolbarItemVisible = False			
			IF NOT gb_contract_module THEN //IntelliCred Only
				m_pfe_cst_mdi_menu.m_system.m_newmailmessage.Visible = True
				m_pfe_cst_mdi_menu.m_file.m_new_mail_message.visible = False
			ELSEIF gb_contract_version THEN //Contract Only
				m_pfe_cst_mdi_menu.m_system.m_newmailmessage.Visible = False
				m_pfe_cst_mdi_menu.m_file.m_new_mail_message.visible = True
				if not ib_contract_menu then m_pfe_cst_mdi_menu.m_system.m_emailsignature.m_emailsentitems.ToolbarItemVisible = True				
			ELSE //IntelliCred with Contract module
				m_pfe_cst_mdi_menu.m_system.m_newmailmessage.Visible = True
				m_pfe_cst_mdi_menu.m_file.m_new_mail_message.visible = True				
			END IF			
			If as_menu_name = 'm_pfe_cst_mdi_menu_contract_am' Then
				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_email0.visible = True 
				m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_email0.ToolbarItemVisible = True 
			End If			
			//---------End Modfiied ----------------------------------------------------------------			
			
			//--------Begin Added by Alfee 06.08.2010------------------------
			//IF gi_email_type = 1 THEN //outlook
			IF NOT gb_contract_module AND gi_email_type = 1 THEN //IntelliCred and Outlook -  (Appeon)Alfee 06.29.2013 for V141 ISG-CLX			
				m_pfe_cst_mdi_menu.m_system.m_newmailmessage.visible = False
				m_pfe_cst_mdi_menu.m_system.m_emailsignature.m_emailsignature2.visible = False
				//m_pfe_cst_mdi_menu.m_system.m_emailsignature.m_emailsentitems.visible = False //evan 06.11.2012 --- V12.2-Email Logging
			END IF
			//--------End Added --------------------------------------------		
		END IF
		
		//Temp folders - new added 02.05.2008
		IF of_security_access( 6932 ) = 0 THEN
			m_pfe_cst_mdi_menu.m_system.m_emailsignature.m_clientsettings.Visible = False
		ELSE
			m_pfe_cst_mdi_menu.m_system.m_emailsignature.m_clientsettings.Visible = True
		END IF
		
		//Personal settings
		//Start Code Change ----07.28.2014 #V14.2 maha
		IF gb_contract_version THEN 
			m_pfe_cst_mdi_menu.m_system.m_emailsignature.m_mysettings.Visible = False  //(Appeon)Alfee 07.25.2013 - V141 ISG-CLX
		Else
			if of_get_app_setting("set_cont","I") = 0 THEN
				m_pfe_cst_mdi_menu.m_system.m_emailsignature.m_autorefreshsettings.Visible = false
			end if
		End if
		//End Code Change ----07.28.2014	
		
		//Start Code Change ----12.13.2016 #V153 maha
		
		IF of_security_access( 7833 ) = 0 THEN
			m_pfe_cst_mdi_menu.m_system.m_emailsignature.m_userdocuments.Visible = false
		else
			m_pfe_cst_mdi_menu.m_system.m_emailsignature.m_userdocuments.Visible = true
		end if
		//End Code Change ----12.13.2016
		
		IF of_security_access( 6932 ) = 0 And of_security_access( 6931 ) = 0   THEN //if both set to off hide upper level
			m_pfe_cst_mdi_menu.m_system.m_emailsignature.Visible = False
		ELSE
			m_pfe_cst_mdi_menu.m_system.m_emailsignature.Visible = True
		END IF
	END IF
	//End Code Change---02.05.2008		
	//#################################################################################################		

	//Start Code Change ----08.21.2008 #V85 maha
	IF of_security_access( 170 ) = 0 THEN //prac folder, verifications, recred verifications
		m_pfe_cst_master_menu.m_system.m_verificationbatchfunctions.m_batchrecredential.Visible = False
	ELSE
		m_pfe_cst_master_menu.m_system.m_verificationbatchfunctions.m_batchrecredential.Visible = True
	END IF
	//End Code Change---08.21.2008
	
END IF 
//**********************END OF THE IF STATEMENT********************************

//---------Begin Commented by (Appeon)Harry 05.31.2013 for V141 ISG-CLX   BugH110603--------
//BEGIN---Add by Evan 09/04/2008
IF of_get_app_setting("set_cont", "I") = 0 Or of_security_access(6937) = 0 THEN
	m_pfe_cst_master_menu.m_system.m_bidq.Visible = False
	
	IF IsValid(m_pfe_cst_mdi_menu_contract_am) THEN //Added by Scofield on 2008-11-24
		m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_fromqueue.ToolbarItemVisible = False
	END IF
ELSE
	m_pfe_cst_master_menu.m_system.m_bidq.Visible = True
	
	IF IsValid(m_pfe_cst_mdi_menu_contract_am) THEN //Added by Scofield on 2008-11-24
		m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_fromqueue.ToolbarItemVisible = True
	END IF
END IF
//END---Add by Evan 09/04/2008
//---------End Commented ------------------------------------------------------

//Start Code Change ----02.28.2011 #V11 maha - admin utility security
if w_mdi.of_security_access( 1345 ) = 0   then
	m_pfe_cst_master_menu.m_system.m_painters.m_security.m_securitysettings.Visible = False
	m_pfe_cst_master_menu.m_system.m_painters.m_systemsetup.m_nonpractitioners.Visible = False
	m_pfe_cst_master_menu.m_system.m_painters.m_systemsetup.m_webcrawlersetup.Visible = False
	m_pfe_cst_master_menu.m_system.m_painters.m_systemsetup.m_applicationtrackingsettings.Visible = False //Start Code Change ----10.03.2012 #V12 maha
ELSE
	m_pfe_cst_master_menu.m_system.m_painters.m_security.m_securitysettings.Visible = True
	m_pfe_cst_master_menu.m_system.m_painters.m_systemsetup.m_nonpractitioners.Visible = True
	m_pfe_cst_master_menu.m_system.m_painters.m_systemsetup.m_webcrawlersetup.Visible = True
	m_pfe_cst_master_menu.m_system.m_painters.m_systemsetup.m_applicationtrackingsettings.Visible = True  //Start Code Change ----10.03.2012 #V12 maha
end if
//End Code Change ----02.28.2011

//Begin added by long.zhang 06.27.2011
//<reason> for red flag data
if of_security_access(7170) = 0 then
	m_pfe_cst_master_menu.m_system.m_viewredflagdata.Visible = False
else
	m_pfe_cst_master_menu.m_system.m_viewredflagdata.Visible = True
end if
//End added by long.zhang 06.27.2011

//Start Code Change ----07.12.2011 #V11 maha - process templates
if w_mdi.of_security_access( 7191 ) = 0   then
	m_pfe_cst_master_menu.m_system.m_painters.m_privilegesandqa.m_processtemplates.Visible = False
ELSE
	m_pfe_cst_master_menu.m_system.m_painters.m_privilegesandqa.m_processtemplates.Visible = True
end if
//End Code Change ----07.12.2011

 //Start Code Change ----11.18.2015 #V15 maha - verification batch
If w_mdi.of_security_access( 7801 ) = 0 then
	m_pfe_cst_master_menu.m_system.m_verificationbatchfunctions.m_batchverifications.Visible = False
Else
	m_pfe_cst_master_menu.m_system.m_verificationbatchfunctions.m_batchverifications.Visible = True
End if

If w_mdi.of_security_access( 7802 ) = 0 then
	m_pfe_cst_master_menu.m_system.m_verificationbatchfunctions.m_verificationbatchlog.Visible = False
	m_pfe_cst_master_menu.m_system.m_verificationbatchfunctions.m_verificationincomplete.Visible = False  //Start Code Change ----08.24.2017 #V154 maha
Else
	m_pfe_cst_master_menu.m_system.m_verificationbatchfunctions.m_verificationbatchlog.Visible = True
	m_pfe_cst_master_menu.m_system.m_verificationbatchfunctions.m_verificationincomplete.Visible = True  //Start Code Change ----08.24.2017 #V154 maha
End if
 //End Code Change ----10.27.2015
 
 
 
//@@@@@@@@@ END OF MAIN FUNCTION @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@



CHOOSE CASE as_menu_name
		//Credentials
	CASE "m_pfe_cst_data_entry"
		of_menu_security_data_entry()
		//App.Audit
	CASE "m_pfe_cst_app_audit"
		of_menu_security_app_audit()
		//Verification
	CASE  "m_pfe_cst_verif_info"
		of_menu_security_verif_info()
		//Profile
	CASE "m_pfe_cst_profile"
		of_menu_security_profile()
	//---------Begin Added by (Appeon)Harry 08.31.2015 for Bug # 4694 --------
	CASE "m_pfe_cst_contract_profile"
		of_menu_security_contract_profile()
	//---------End Added ------------------------------------------------------
		//Image
	CASE "m_pfe_cst_imaging" ,"m_pfe_cst_imaging_browse", "m_pfe_cst_imaging_setup","m_pfe_cst_imaging_view" //maha 092204
		IF gi_imaging = 1 THEN
			of_menu_security_image(as_menu_name)
		END IF		
		//Privilege
	CASE "m_pfe_cst_privileges"
		of_menu_security_privilege()
		//Appl.Status
	CASE "m_pfe_cst_net_dev"
		of_menu_security_appl_status()
		//Meetings
	CASE "m_pfe_cst_prac_meetings"
		of_menu_security_meeting()
		//Email Manager - For BugA082102 -  (Appeon)Alfee 09.23.2013 - V141 ISG-CLX
	CASE "m_pfe_cst_mail" 
		of_menu_security_email()				
	CASE  "m_pfe_cst_contract_data_design"
		//user security :Screen Painter - Contract View Manager
		IF of_security_access( 5310 ) = 0 THEN
			m_pfe_cst_contract_data_design.m_view.m_viewmanager.Visible = False
			m_pfe_cst_contract_data_design.m_view.m_viewmanager.ToolbarItemVisible = False
		ELSE
			m_pfe_cst_contract_data_design.m_view.m_viewmanager.Visible = True
			m_pfe_cst_contract_data_design.m_view.m_viewmanager.ToolbarItemVisible = True
		END IF
		
		//---------Begin Added by (Appeon)Alfee 06.29.2013 for V141 ISG-CLX--------
		if of_security_access(5310) = 0 or of_security_access(5400) = 0 then
			m_pfe_cst_contract_data_design.m_file.m_selectview.Visible = false
			m_pfe_cst_contract_data_design.m_file.m_selectview.ToolBarItemVisible = false
		else
			m_pfe_cst_contract_data_design.m_file.m_selectview.Visible = true
			m_pfe_cst_contract_data_design.m_file.m_selectview.ToolBarItemVisible = true
		end if
		//---------End Added ------------------------------------------------------------------

		//user security :Screen Painter - Contract Field Properties
		IF of_security_access( 5320 ) = 0 THEN
			m_pfe_cst_contract_data_design.m_view.m_fieldproperties.Visible = False
			m_pfe_cst_contract_data_design.m_view.m_fieldproperties.ToolbarItemVisible = False
		ELSE
			m_pfe_cst_contract_data_design.m_view.m_fieldproperties.Visible = True
			m_pfe_cst_contract_data_design.m_view.m_fieldproperties.ToolbarItemVisible = True
		END IF

		//---------Begin Added by (Appeon)Alfee 06.29.2013 for V141 ISG-CLX--------
		//user security:Screen Painter - Contract Field Depend 
		IF of_security_access( 5330 ) = 0 THEN
			m_pfe_cst_contract_data_design.m_view.m_fielddepend.Visible = False
			m_pfe_cst_contract_data_design.m_view.m_fielddepend.ToolBarItemVisible = False
		ELSE
			m_pfe_cst_contract_data_design.m_view.m_fielddepend.Visible = True
			m_pfe_cst_contract_data_design.m_view.m_fielddepend.ToolBarItemVisible = True
		END IF		
		//---------End Added ------------------------------------------------------------------

		//Menu logic for Contacts
	CASE  "m_pfe_cst_contract" , "m_pfe_cst_mdi_menu_contract", "m_pfe_cst_mdi_menu","m_pfe_cst_mdi_menu_contract_am" // Add "m_pfe_cst_mdi_menu_contract_am" - (Appeon)Alfee 06.29.2013 - V141 ISG-CLX
		//---------Begin Added by (Appeon)Harry 03.18.2014 for V142 ISG-CLX--------
		//Begin - Added By Mark Lee 12/18/2012
		IF as_menu_name =  'm_pfe_cst_mdi_menu_contract_am'	 and is_current_window_name ='w_contract'  Then
			if w_contract.tab_contract_details.selectedtab = 9 then	//document Manager
				m_pfe_cst_mdi_menu_contract_am.m_contract0.visible = True
				m_pfe_cst_mdi_menu_contract_am.m_contract0.enabled = True
				
				If of_security_access( 6988 ) = 0 Then 	 //New CTX //Added if statement By Ken.Guo 04/17/2013
					m_pfe_cst_mdi_menu_contract_am.m_contract0.m_new_blank_contract_record.visible =  True
					m_pfe_cst_mdi_menu_contract_am.m_contract0.m_new_blank_contract_record.enabled = False
					m_pfe_cst_mdi_menu_contract_am.m_contract0.m_new_blank_sub_contract_record.visible = True
					m_pfe_cst_mdi_menu_contract_am.m_contract0.m_new_blank_sub_contract_record.enabled = False
					m_pfe_cst_mdi_menu_contract_am.m_contract0.m_new_contract.visible =  True						//--		
					m_pfe_cst_mdi_menu_contract_am.m_edit.m_newcontract.enabled = False //Added By Ken.Guo 04/17/2013
				Else
					m_pfe_cst_mdi_menu_contract_am.m_contract0.m_new_blank_contract_record.visible =  True
					m_pfe_cst_mdi_menu_contract_am.m_contract0.m_new_blank_contract_record.enabled = True
					m_pfe_cst_mdi_menu_contract_am.m_contract0.m_new_blank_sub_contract_record.visible = True
					m_pfe_cst_mdi_menu_contract_am.m_contract0.m_new_blank_sub_contract_record.enabled = True
					m_pfe_cst_mdi_menu_contract_am.m_contract0.m_new_contract.visible =  True						//--									
					m_pfe_cst_mdi_menu_contract_am.m_edit.m_newcontract.enabled = True//Added By Ken.Guo 04/17/2013
				End If
				If of_security_access( 6989 ) = 0 Then 	 //Copy CTX //Added statement By Ken.Guo 04/17/2013
					m_pfe_cst_mdi_menu_contract_am.m_contract0.m_copy_contract_record.visible =  True
					m_pfe_cst_mdi_menu_contract_am.m_contract0.m_copy_contract_record.enabled = False
					m_pfe_cst_mdi_menu_contract_am.m_contract0.m_copy_create_sub_contract_record.visible = True
					m_pfe_cst_mdi_menu_contract_am.m_contract0.m_copy_create_sub_contract_record.enabled = False
					m_pfe_cst_mdi_menu_contract_am.m_contract0.m_copy_contract.visible = True						//--
				Else
					m_pfe_cst_mdi_menu_contract_am.m_contract0.m_copy_contract_record.visible =  True
					m_pfe_cst_mdi_menu_contract_am.m_contract0.m_copy_contract_record.enabled = True
					m_pfe_cst_mdi_menu_contract_am.m_contract0.m_copy_create_sub_contract_record.visible = True
					m_pfe_cst_mdi_menu_contract_am.m_contract0.m_copy_create_sub_contract_record.enabled = True	
					m_pfe_cst_mdi_menu_contract_am.m_contract0.m_copy_contract.visible = True						//--					
				End If
				
				m_pfe_cst_mdi_menu_contract_am.m_contract0.m_contract_templates.visible = True
				If of_security_access( 6955 ) = 0 Then 	 //use template
					m_pfe_cst_mdi_menu_contract_am.m_contract0.m_contract_templates.enabled = false
				else
					m_pfe_cst_mdi_menu_contract_am.m_contract0.m_contract_templates.enabled = True
				end if
				m_pfe_cst_mdi_menu_contract_am.m_contract0.m_template_item.visible = True 	//--
				
				
				If of_security_access( 6988 ) = 0 Then 	 //New CTX //Added By Ken.Guo 04/17/2013
					m_pfe_cst_mdi_menu_contract_am.m_contract0.m_contract_templates.enabled = false
				else
					m_pfe_cst_mdi_menu_contract_am.m_contract0.m_contract_templates.enabled = True
				end if				
				
			end if				
		End If
		//End - Added By Mark Lee 12/18/2012
		//---------End Added ------------------------------------------------------
		
		IF of_security_access( 6930 ) = 0   THEN //Contact security
			//---------Begin Modified by (Appeon)Alfee 06.29.2013 for V141 ISG-CLX--------			
			//m_pfe_cst_mdi_menu.m_file.m_contacts.ToolbarItemVisible = False
			//m_pfe_cst_mdi_menu.m_file.m_contacts.Visible = False
			m_pfe_cst_master_menu.m_file.m_contacts.ToolbarItemVisible = False
			m_pfe_cst_master_menu.m_file.m_contacts.Visible = False			
			//---------End Modfiied ----------------------------------------------------------------
		ELSE
			IF as_menu_name = "m_pfe_cst_mdi_menu" And Not gb_contract_version THEN
				//---------Begin Modified by (Appeon)Alfee 06.29.2013 for V141 ISG-CLX--------			
				//m_pfe_cst_mdi_menu.m_file.m_contacts.Visible = False
				//m_pfe_cst_mdi_menu.m_file.m_contacts.ToolbarItemVisible = False
				m_pfe_cst_master_menu.m_file.m_contacts.Visible = False
				m_pfe_cst_master_menu.m_file.m_contacts.ToolbarItemVisible = False				
				//---------End Modfiied ----------------------------------------------------------------				
			ELSE
				//---------Begin Modified by (Appeon)Alfee 06.29.2013 for V141 ISG-CLX--------							
				//m_pfe_cst_mdi_menu.m_file.m_contacts.Visible = True
				//m_pfe_cst_mdi_menu.m_file.m_contacts.ToolbarItemVisible = True
				m_pfe_cst_master_menu.m_file.m_contacts.Visible = True
				IF as_menu_name <> "m_pfe_cst_mdi_menu_contract_am" THEN m_pfe_cst_master_menu.m_file.m_contacts.ToolbarItemVisible = True				
				//---------End Modfiied ----------------------------------------------------------------								
			END IF
		END IF
		
		//---------Begin Added by (Appeon)Alfee 06.29.2013 for V141 ISG-CLX--------
		If isvalid(m_pfe_cst_mdi_menu_contract) Then
			//---------Begin Added by (Appeon)Harry 03.18.2014 for V142 ISG-CLX--------
			//Begin - Added By Mark Lee 12/18/2012
				m_pfe_cst_mdi_menu_contract.m_contract0.visible = True
				m_pfe_cst_mdi_menu_contract.m_contract0.enabled = True

				m_pfe_cst_mdi_menu_contract.m_contract0.m_new_contract.visible =  True						//--	
				If isvalid(gw_contract)  Then 
					IF gw_contract.tab_contract_details.Selectedtab = 1 &
						and  gw_contract.tab_contract_details.tabpage_search.dw_search_det1.GetSelectedRow(0) <= 0 then 
						lb_Display = False
					Else
						lb_Display = True
					End If
				Else
					lb_Display = False
				End If

				m_pfe_cst_mdi_menu_contract.m_contract0.m_new_blank_contract_record.visible =  True
//				m_pfe_cst_mdi_menu_contract.m_contract0.m_new_blank_contract_record.enabled = True				
				m_pfe_cst_mdi_menu_contract.m_contract0.m_new_blank_sub_contract_record.visible = True
//				m_pfe_cst_mdi_menu_contract.m_contract0.m_new_blank_sub_contract_record.enabled = lb_Display
				m_pfe_cst_mdi_menu_contract.m_contract0.m_copy_contract_record.visible =  True
//				m_pfe_cst_mdi_menu_contract.m_contract0.m_copy_contract_record.enabled = lb_Display
				m_pfe_cst_mdi_menu_contract.m_contract0.m_copy_create_sub_contract_record.visible = True
//				m_pfe_cst_mdi_menu_contract.m_contract0.m_copy_create_sub_contract_record.enabled = lb_Display	
				
				m_pfe_cst_mdi_menu_contract.m_contract0.m_copy_contract.visible = True						//--
				m_pfe_cst_mdi_menu_contract.m_contract0.m_contract_templates.visible = True
				m_pfe_cst_mdi_menu_contract.m_contract0.m_template_item.visible = True 	//--
				
				//Added By Ken.Guo 04/17/2013
				If of_security_access( 6988 ) = 0 Then //New CTX
					m_pfe_cst_mdi_menu_contract.m_edit.m_newcontract.m_newctx .enabled = False
					m_pfe_cst_mdi_menu_contract.m_contract0.m_new_blank_contract_record.enabled = False
					m_pfe_cst_mdi_menu_contract.m_contract0.m_new_blank_sub_contract_record.enabled = False
				Else
					m_pfe_cst_mdi_menu_contract.m_edit.m_newcontract.m_newctx .enabled = True
					m_pfe_cst_mdi_menu_contract.m_contract0.m_new_blank_contract_record.enabled = True
					m_pfe_cst_mdi_menu_contract.m_contract0.m_new_blank_sub_contract_record.enabled = lb_Display
				End If
				
				If of_security_access( 6989 ) = 0 Then //Copy CTX
					m_pfe_cst_mdi_menu_contract.m_edit.m_newcontract.m_copyctx .enabled = False
					m_pfe_cst_mdi_menu_contract.m_contract0.m_copy_contract_record.enabled = False
					m_pfe_cst_mdi_menu_contract.m_contract0.m_copy_create_sub_contract_record.enabled = False
				Else
					m_pfe_cst_mdi_menu_contract.m_edit.m_newcontract.m_copyctx .enabled = True
					m_pfe_cst_mdi_menu_contract.m_contract0.m_copy_contract_record.enabled = lb_Display
					m_pfe_cst_mdi_menu_contract.m_contract0.m_copy_create_sub_contract_record.enabled = lb_Display					
				End If	
		
				//End - Added By Mark Lee 12/18/2012		
			//---------End Added ------------------------------------------------------
			If of_security_access( 6955 ) = 0 Then 	 //use template
				m_pfe_cst_mdi_menu_contract.m_edit.m_newcontract.m_usetemplate.visible = False
				m_pfe_cst_mdi_menu_contract.m_edit.m_newcontract.m_usetemplate.toolbaritemvisible = False
				//---------Begin Added by (Appeon)Harry 03.18.2014 for V142 ISG-CLX--------
				m_pfe_cst_mdi_menu_contract.m_contract0.m_contract_templates.enabled = false				//Added By Mark Lee 12/18/2012
				//---------End Added ------------------------------------------------------
			Else
				m_pfe_cst_mdi_menu_contract.m_edit.m_newcontract.m_usetemplate.visible = True
				m_pfe_cst_mdi_menu_contract.m_edit.m_newcontract.m_usetemplate.toolbaritemvisible = True
				//---------Begin Added by (Appeon)Harry 03.18.2014 for V142 ISG-CLX--------
				m_pfe_cst_mdi_menu_contract.m_contract0.m_contract_templates.enabled = True			//Added By Mark Lee 12/18/2012
				//---------End Added ------------------------------------------------------
			End If
			If of_security_access( 6956 ) = 0  Then 	 //Save As...
				m_pfe_cst_mdi_menu_contract.m_file.m_saveas.toolbaritemvisible = False
			Else
				If isvalid(gw_contract) Then
					If gw_contract.tab_contract_details.selectedtab = 2 Then						
						m_pfe_cst_mdi_menu_contract.m_file.m_saveas.toolbaritemvisible = True
					End IF
				End If
			End If	
			
			If isvalid(gw_contract) Then
				//Email menu
				If gw_contract.tab_contract_details.selectedtab = 9 Then
					//
				Else
					IF w_mdi.of_security_access( 6931 ) = 0 THEN
						m_pfe_cst_mdi_menu_contract.m_edit.m_emaildd.toolbaritemvisible = False
					Else
						//m_pfe_cst_mdi_menu_contract.m_edit.m_emaildd.currentitem = m_pfe_cst_mdi_menu_contract.m_edit.m_emaildd.m_emaildd_email //Web not support.
						m_pfe_cst_mdi_menu_contract.m_edit.m_emaildd.toolbaritemvisible = True
						If gw_contract.tab_contract_details.selectedtab = 1 Then 
							m_pfe_cst_mdi_menu_contract.m_edit.m_emaildd.m_emaildd_email.toolbaritemtext = 'Email'		
							m_pfe_cst_mdi_menu_contract.m_edit.m_emaildd.m_emaildd_batch.toolbaritemvisible = True	
						Else
							//m_pfe_cst_mdi_menu_contract.m_edit.m_emaildd.m_emaildd_email.toolbaritemtext = 'New Email'
							m_pfe_cst_mdi_menu_contract.m_edit.m_emaildd.m_emaildd_email.toolbaritemtext = 'Email'
							m_pfe_cst_mdi_menu_contract.m_edit.m_emaildd.m_emaildd_batch.toolbaritemvisible = False	
						End If		
					End If					
				End If
				
				//Display Options
				If gw_contract.tab_contract_details.Selectedtab = 1 and  w_mdi.of_security_access( 6978 ) > 0 Then
					m_pfe_cst_mdi_menu_contract.m_file.m_display.toolbaritemvisible = True
					m_pfe_cst_mdi_menu_contract.m_file.m_display.visible = True //(Appeon)Harry 10.16.2014 - for BugH091101
				Else
					m_pfe_cst_mdi_menu_contract.m_file.m_display.toolbaritemvisible = False
					m_pfe_cst_mdi_menu_contract.m_file.m_display.visible = False //(Appeon)Harry 10.16.2014 - for BugH091101
				End If	
				
				//Add by jervis -- 12.16.2010
				if gw_contract.tab_contract_details.selectedtab = 8 then
					m_pfe_cst_mdi_menu_contract.m_edit.m_duplicate.toolbaritemvisible = True
				else
					m_pfe_cst_mdi_menu_contract.m_edit.m_duplicate.toolbaritemvisible = false
				end if
				//---------Begin Added by (Appeon)Toney 10.29.2013 for V141 ISG-CLX--------
				//$Reason: Fix Bug #3714
				IF of_security_access( 5300 ) = 0 THEN //user security contract screen painter
					m_pfe_cst_mdi_menu_contract.m_system.m_painters.m_screensetup.m_contractdatascreenpainter.ToolbarItemVisible = False 		
				ELSE
					m_pfe_cst_mdi_menu_contract.m_system.m_painters.m_screensetup.m_contractdatascreenpainter.ToolbarItemVisible = True 
				END IF				
				//---------End Added ------------------------------------------------------------------
			End If
		End IF
		//---------End Added ------------------------------------------------------------------	
		
		//---------Begin Added by (Appeon)Harry 05.06.2014 for V142 ISG-CLX--------
		If isvalid(m_pfe_cst_mdi_menu_contract_am) Then
			IF of_security_access( 5300 ) = 0 THEN //user security contract screen painter
				m_pfe_cst_mdi_menu_contract_am.m_system.m_painters.m_screensetup.m_contractdatascreenpainter.ToolbarItemVisible = False 		
			ELSE
				m_pfe_cst_mdi_menu_contract_am.m_system.m_painters.m_screensetup.m_contractdatascreenpainter.ToolbarItemVisible = True 
			END IF	
		end if
		//---------End Added ------------------------------------------------------
	CASE  "m_pfe_cst_action_items"
		//process verifications
		//Start Code Change ----02.16.2016 #V15 maha - removed toolbaritem references
		IF of_security_access( 260 ) = 0 THEN
			m_pfe_cst_action_items.m_action.m_connecttoweb.Visible = False
			//m_pfe_cst_action_items.m_action.m_connecttoweb.ToolbarItemVisible = False //maha 110804
			m_pfe_cst_action_items.m_action.m_exportdata.Visible = False
			//m_pfe_cst_action_items.m_action.m_exportdata.ToolbarItemVisible = False
			m_pfe_cst_action_items.m_action.m_phonedialer.Visible = False
			//m_pfe_cst_action_items.m_action.m_phonedialer.ToolbarItemVisible = False
			m_pfe_cst_action_items.m_action.m_printallletters.Visible = False
			//m_pfe_cst_action_items.m_action.m_printallletters.ToolbarItemVisible = False
			m_pfe_cst_action_items.m_action.m_searchoig.Visible = False
		//	m_pfe_cst_action_items.m_action.m_searchoig.ToolbarItemVisible = False
			//Start Code Change ----01.19.2009 #V92 maha
			m_pfe_cst_action_items.m_action.m_batchresponse.Visible = False
			//m_pfe_cst_action_items.m_action.m_batchresponse.ToolbarItemVisible = False
			m_pfe_cst_action_items.m_action.m_batchrecred.Enabled = False
			//m_pfe_cst_action_items.m_action.m_batchrecred.ToolbarItemVisible = False
			//End Code Change---01.19.2009
			m_pfe_cst_action_items.m_action.m_clearprint.Visible = False  //Start Code Change ----04.13.2010 #V10 maha
		ELSE
			m_pfe_cst_action_items.m_action.m_connecttoweb.Visible = True
			//m_pfe_cst_action_items.m_action.m_connecttoweb.ToolbarItemVisible = True
			m_pfe_cst_action_items.m_action.m_exportdata.Visible = True
			//m_pfe_cst_action_items.m_action.m_exportdata.ToolbarItemVisible = True
			m_pfe_cst_action_items.m_action.m_phonedialer.Visible = True
			//m_pfe_cst_action_items.m_action.m_phonedialer.ToolbarItemVisible = True  //Start Code Change ----02.28.2013 #V12 maha - removed
			m_pfe_cst_action_items.m_action.m_printallletters.Visible = True
			//m_pfe_cst_action_items.m_action.m_printallletters.ToolbarItemVisible = True
			m_pfe_cst_action_items.m_action.m_searchoig.Visible = True
			//m_pfe_cst_action_items.m_action.m_searchoig.ToolbarItemVisible = True
			//Start Code Change ----01.19.2009 #V92 maha
			m_pfe_cst_action_items.m_action.m_batchresponse.Visible = True
			//m_pfe_cst_action_items.m_action.m_batchresponse.ToolbarItemVisible = True
//			m_pfe_cst_action_items.m_action.m_batchrecred.Enabled = True  //Start Code Change ----02.03.2010 #V10 maha - enabled handled in Action Items code
			//m_pfe_cst_action_items.m_action.m_batchrecred.ToolbarItemVisible = True
			//End Code Change---01.19.2009
			m_pfe_cst_action_items.m_action.m_clearprint.Visible = true //Start Code Change ----04.13.2010 #V10 maha
		END IF
		
		//Start Code Change ----05.16.2011 #V11 maha - hide in app
		IF Upper( gs_cust_type ) = 'I' THEN
			m_pfe_cst_action_items.m_action.m_exportdata.Visible = False
		//	m_pfe_cst_action_items.m_action.m_exportdata.ToolBarItemVisible = False	
			m_pfe_cst_action_items.m_action.m_connecttoweb.Visible = False
		//	m_pfe_cst_action_items.m_action.m_connecttoweb.ToolBarItemVisible = False	
			m_pfe_cst_action_items.m_action.m_phonedialer.Visible = False	
		//	m_pfe_cst_action_items.m_action.m_phonedialer.ToolBarItemVisible = False	
			m_pfe_cst_action_items.m_action.m_editverificationdata.Visible = False
			m_pfe_cst_action_items.m_action.m_searchoig.Visible = False
		//	m_pfe_cst_action_items.m_action.m_searchoig.ToolbarItemVisible = False
			m_pfe_cst_action_items.m_action.m_batchrecred.Enabled = False
		//	m_pfe_cst_action_items.m_action.m_batchrecred.ToolbarItemVisible = False
		
		END IF
		//End Code Change ----02.16.2016
		//End Code Change ----05.16.2011
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$< Add  > 2008-04-15 By: Scofield
		//$<Reason> Hide Practitioner Search menu item when it is in contract version.
		IF gb_contract_version = True THEN
			m_pfe_cst_action_items.m_action.m_41.Visible = False
			
			m_pfe_cst_action_items.m_action.m_practitionersearch.Visible = False
			m_pfe_cst_action_items.m_action.m_practitionersearch.ToolbarItemVisible = False
		END IF
		//---------------------------- APPEON END ----------------------------
		
	CASE "m_pfe_cst_prac_data_design" //maha 080902
		ncnt = of_get_app_setting("set_11","I")
		IF ncnt = 1 And IsValid(w_prac_data_design) THEN
			m_pfe_cst_prac_data_design.m_file.m_newscreenpainter.Visible = True
			m_pfe_cst_prac_data_design.m_file.m_newscreenpainter.ToolbarItemVisible = True
		END IF
		
		//--------Begin Added by Nova 09.18.2009------------------------
		//user security :Screen Painter - intellicred view manager
		IF of_security_access( 430 ) = 0 THEN
			m_pfe_cst_prac_data_design.m_view.m_viewmanager.Visible = False
			m_pfe_cst_prac_data_design.m_view.m_viewmanager.ToolbarItemVisible = False
		ELSE
			m_pfe_cst_prac_data_design.m_view.m_viewmanager.Visible = True
			m_pfe_cst_prac_data_design.m_view.m_viewmanager.ToolbarItemVisible = True
		END IF
		
		//user security :Screen Painter - intellicred Field Properties
		IF of_security_access( 440 ) = 0 THEN
			m_pfe_cst_prac_data_design.m_view.m_fieldproperties.Visible = False
			m_pfe_cst_prac_data_design.m_view.m_fieldproperties.ToolbarItemVisible = False
		ELSE
			m_pfe_cst_prac_data_design.m_view.m_fieldproperties.Visible = True
			m_pfe_cst_prac_data_design.m_view.m_fieldproperties.ToolbarItemVisible = True
		END IF
		//--------End Added --------------------------------------------
		
		//Start Code Change ----03.24.2008 #V8 maha - Hide if web version
		IF appeongetclienttype() <> 'PB' THEN
			m_pfe_cst_prac_data_design.m_file.m_toggleprofile.Visible = False
			m_pfe_cst_prac_data_design.m_file.m_toggleprofile.ToolbarItemVisible = False
			m_pfe_cst_prac_data_design.m_file.m_saveasprofilescreen.Visible = False
			m_pfe_cst_prac_data_design.m_file.m_saveasprofilescreen.ToolbarItemVisible = False
		END IF
		//End Code Change---03.24.2008
		
		//Start Code Change ----04.15.2008 #V8 maha - code added because upable to modify in PB 
	CASE "m_pfe_cst_net_dev_action_items"
		m_pfe_cst_net_dev_action_items.m_edit.m_batchaddfacilities.ToolbarItemVisible = False
		//End Code Change---04.15.2008
		
		//------------------------APPEON BEGIN-------------------------
		//$<add> appeon long.zhang 06.19.2012
		//$<reason> for v12.2 app batch update read only secutiry control
		//Start Code Change ----02.16.2016 #V15 maha - removed tool bar references
		if of_security_access(5200) < 2 then
			m_pfe_cst_net_dev_action_items.m_file.m_batchupdateactions.Visible = false
			//m_pfe_cst_net_dev_action_items.m_file.m_batchupdateactions.ToolbarItemVisible = false
			m_pfe_cst_net_dev_action_items.m_file.m_save.Visible = false
			//m_pfe_cst_net_dev_action_items.m_file.m_save.ToolbarItemVisible = false
		else
			m_pfe_cst_net_dev_action_items.m_file.m_batchupdateactions.Visible = true
			//m_pfe_cst_net_dev_action_items.m_file.m_batchupdateactions.ToolbarItemVisible = true
			m_pfe_cst_net_dev_action_items.m_file.m_save.Visible = true
			//m_pfe_cst_net_dev_action_items.m_file.m_save.ToolbarItemVisible = true
		end if
		//End Code Change ----02.16.2016
		//------------------------APPEON END---------------------------
		
	CASE "m_pfe_cst_mdi_dashboard" //This Case is Added By Ken.Guo 2008-11-20
		IF of_security_access( 6943 ) = 1 THEN //Add tab
			m_pfe_cst_mdi_dashboard.m_dashboard2.m_tab.m_addtab.Visible = True
		ELSE
			m_pfe_cst_mdi_dashboard.m_dashboard2.m_tab.m_addtab.Visible = False
		END IF
		
		IF of_security_access( 6944 ) = 1 THEN //delete tab
			m_pfe_cst_mdi_dashboard.m_dashboard2.m_tab.m_deletetab.Visible = True
		ELSE
			m_pfe_cst_mdi_dashboard.m_dashboard2.m_tab.m_deletetab.Visible = False
		END IF
		
		IF of_security_access( 6945 ) = 1 THEN //Tab page settings
			m_pfe_cst_mdi_dashboard.m_dashboard2.m_tab.m_tabsettings.Visible = True
			m_pfe_cst_mdi_dashboard.m_dashboard2.m_tab.m_tabsettings.ToolbarItemVisible = True
		ELSE
			m_pfe_cst_mdi_dashboard.m_dashboard2.m_tab.m_tabsettings.Visible = False
			m_pfe_cst_mdi_dashboard.m_dashboard2.m_tab.m_tabsettings.ToolbarItemVisible = False
		END IF
		
		IF m_pfe_cst_mdi_dashboard.m_dashboard2.m_tab.m_deletetab.Visible = False And &
			m_pfe_cst_mdi_dashboard.m_dashboard2.m_tab.m_addtab.Visible = False And &
			m_pfe_cst_mdi_dashboard.m_dashboard2.m_tab.m_tabsettings.Visible = False THEN
			m_pfe_cst_mdi_dashboard.m_dashboard2.m_tab.Visible = False
			m_pfe_cst_mdi_dashboard.m_dashboard2.m_dashboard_dash01.Visible = False
		ELSE
			m_pfe_cst_mdi_dashboard.m_dashboard2.m_dashboard_dash01.Visible = True
			m_pfe_cst_mdi_dashboard.m_dashboard2.m_tab.Visible = True
		END IF
		
		IF of_security_access( 6946 ) = 1 THEN //save
			m_pfe_cst_mdi_dashboard.m_dashboard2.m_saveas.Visible = True
		ELSE
			m_pfe_cst_mdi_dashboard.m_dashboard2.m_saveas.Visible = False
		END IF
		
		IF of_security_access( 6947 ) = 1 THEN //load
			m_pfe_cst_mdi_dashboard.m_dashboard2.m_load.Visible = True
		ELSE
			m_pfe_cst_mdi_dashboard.m_dashboard2.m_load.Visible = False
		END IF
		
		IF of_security_access( 6948 ) = 1 THEN //Management
			m_pfe_cst_mdi_dashboard.m_dashboard2.m_templatesmanagement.Visible = True
		ELSE
			m_pfe_cst_mdi_dashboard.m_dashboard2.m_templatesmanagement.Visible = False
		END IF
		
		IF of_security_access( 6949 ) = 1 THEN //Logo settings
			m_pfe_cst_mdi_dashboard.m_dashboard2.m_logosettings.Visible = True
			m_pfe_cst_mdi_dashboard.m_dashboard2.m_logosettings.ToolbarItemVisible = True
			m_pfe_cst_mdi_dashboard.m_dashboard2.m_dashboard_dash03.Visible = True
		ELSE
			m_pfe_cst_mdi_dashboard.m_dashboard2.m_logosettings.Visible = False
			m_pfe_cst_mdi_dashboard.m_dashboard2.m_logosettings.ToolbarItemVisible = False
			m_pfe_cst_mdi_dashboard.m_dashboard2.m_dashboard_dash03.Visible = False
		END IF

		//---------Begin Modified by (Appeon)Alfee 06.18.2013 for V141 ISG-CLX--------
		//		IF of_security_access( 6950 ) = 1 THEN //Close
		//			m_pfe_cst_mdi_dashboard.m_dashboard2.m_close0.Visible = True
		//			m_pfe_cst_mdi_dashboard.m_dashboard2.m_close0.ToolbarItemVisible = True
		//		ELSE
		//			m_pfe_cst_mdi_dashboard.m_dashboard2.m_close0.Visible = False
		//			m_pfe_cst_mdi_dashboard.m_dashboard2.m_close0.ToolbarItemVisible = False
		//		END IF
		m_pfe_cst_mdi_dashboard.m_dashboard2.m_close0.Visible = True
		m_pfe_cst_mdi_dashboard.m_dashboard2.m_close0.ToolbarItemVisible = True
		m_pfe_cst_mdi_dashboard.m_file.m_close.ToolbarItemVisible = False
		m_pfe_cst_mdi_dashboard.m_file.m_caqhfileimport.ToolbarItemVisible = False
		m_pfe_cst_mdi_dashboard.m_system.m_applicationmapping.ToolbarItemVisible = False
		//---------End Modfiied ------------------------------------------------------

		IF m_pfe_cst_mdi_dashboard.m_dashboard2.m_saveas.Visible = False And &
			m_pfe_cst_mdi_dashboard.m_dashboard2.m_load.Visible = False And &
			m_pfe_cst_mdi_dashboard.m_dashboard2.m_templatesmanagement.Visible = False	And &
			m_pfe_cst_mdi_dashboard.m_dashboard2.m_close0.Visible = False	THEN
			m_pfe_cst_mdi_dashboard.m_dashboard2.m_dashboard_dash02.Visible = False
		ELSE
			m_pfe_cst_mdi_dashboard.m_dashboard2.m_dashboard_dash02.Visible = True
		END IF
	//---------Begin Commented by (Appeon)Harry  03.18.2014 for V142 ISG-CLX--------
	/*
	//---------Begin Added by (Appeon)Alfee 06.29.2013 for V141 ISG-CLX--------
	CASE 'm_pfe_cst_mdi_menu_contract_am'	//02.12.2009 By Jervis
		Choose Case is_current_window_name
			Case 'w_contract'
				if w_contract.tab_contract_details.selectedtab = 9 then	//document Manager
					w_contract.tab_contract_details.tabpage_images.event ue_set_security()
				end if				
			Case 'w_documents_browse'
				w_documents_browse.uo_1.event ue_set_security()
		End Choose
	//---------End Added ------------------------------------------------------------------
	*/
	//---------End Commented ------------------------------------------------------	
	
	//---------Begin Commented by (Appeon)Alfee 08.02.2013 for V141 ISG-CLX--------
	//	CASE "m_pfe_train_app" //for App Mapping tools issue - Ticket #00024923 - alfee 04.29.2010
	//		if isvalid(m_pfe_train_app) and AppeonGetClientType() = "WEB" then
	//			m_pfe_train_app.m_file.m_caqhfileimport.toolbaritemvisible = False
	//			m_pfe_train_app.m_file.m_contract.toolbaritemvisible = False
	//			m_pfe_train_app.m_file.m_grouppractices.toolbaritemvisible = False
	//		//Start Code Change ----03.03.2011 #V11 maha - added to shorten tool bar
	//		else
	//			m_pfe_train_app.m_file.m_caqhfileimport.toolbaritemvisible = False
	//			m_pfe_train_app.m_file.m_contract.toolbaritemvisible = False
	//			m_pfe_train_app.m_file.m_grouppractices.toolbaritemvisible = False
	//			m_pfe_cst_master_menu.m_system.toolbaritemVisible = False
	//			m_pfe_cst_master_menu.m_file.m_contractglobalsearch.ToolbarItemVisible = False
	//		end if	
	//		//End Code Change ----03.03.2011
	//---------End Commented ------------------------------------------------------
		
	//Start Code Change ----03.06.2012 #V12 maha
	CASE "m_pfe_cst_qa" //peer rev tab of prac profiles
			m_pfe_cst_qa.m_system.m_batchaddapplications.visible = false
			m_pfe_cst_qa.m_file.m_cvodata.visible = false
			m_pfe_cst_qa.m_file.m_cvodata.toolbaritemvisible = false
			IF of_security_access(2020) = 1 THEN
				m_pfe_cst_qa.m_file.m_save.visible = false
				m_pfe_cst_qa.m_edit.m_insert.visible = false
				m_pfe_cst_qa.m_edit.m_delete1.visible = false
				m_pfe_cst_qa.m_file.m_save.toolbaritemvisible = false
				m_pfe_cst_qa.m_edit.m_insert.toolbaritemvisible = false
				m_pfe_cst_qa.m_edit.m_delete1.toolbaritemvisible = false
			else
				m_pfe_cst_qa.m_file.m_save.visible = true 
				m_pfe_cst_qa.m_edit.m_insert.visible = true
				m_pfe_cst_qa.m_edit.m_delete1.visible = true
				 //Start Code Change ----12.03.2015 #V15 maha - button removal
				m_pfe_cst_qa.m_file.m_save.toolbaritemvisible = false
				m_pfe_cst_qa.m_edit.m_insert.toolbaritemvisible = false
				m_pfe_cst_qa.m_edit.m_delete1.toolbaritemvisible = false
				//End Code Change ----12.03.2015 
			end if
		CASE "m_pfe_cst_mes"  //Qa tab of prac profiles
			m_pfe_cst_mes.m_file.m_save.toolbaritemvisible = true
			m_pfe_cst_mes.m_file.m_cvodata.visible = false
			m_pfe_cst_mes.m_file.m_cvodata.toolbaritemvisible = false
			IF of_security_access(2020) = 1 THEN
				m_pfe_cst_mes.m_file.m_save.visible = false
				m_pfe_cst_mes.m_edit.m_insert.visible = false
				m_pfe_cst_mes.m_edit.m_delete1.visible = false
				m_pfe_cst_mes.m_file.m_save.toolbaritemvisible = false
				m_pfe_cst_mes.m_edit.m_insert.toolbaritemvisible = false
				m_pfe_cst_mes.m_edit.m_delete1.toolbaritemvisible = false
			else
				m_pfe_cst_mes.m_file.m_save.visible = true  
				m_pfe_cst_mes.m_edit.m_insert.visible = true
				m_pfe_cst_mes.m_edit.m_delete1.visible = true
				//Start Code Change ----12.03.2015 #V15 maha - button removal
				m_pfe_cst_mes.m_file.m_save.toolbaritemvisible = false   
				m_pfe_cst_mes.m_edit.m_insert.toolbaritemvisible = false
				m_pfe_cst_mes.m_edit.m_delete1.toolbaritemvisible = false
				//End Code Change ----12.03.2015
			end if	
		
		 //Start Code Change ----03.12.2015 #V15 maha
		CASE "m_pfe_train_app_setup" 
			IF of_security_access(7787) = 0 THEN
				m_pfe_train_app_setup.m_file.m_save.visible = false
				m_pfe_train_app_setup.m_edit.m_insert.visible = false
				m_pfe_train_app_setup.m_edit.m_delete1.visible = false
				m_pfe_train_app_setup.m_file.m_importapplications.visible = false
				m_pfe_train_app_setup.m_file.m_changeorganization.visible = false
				m_pfe_train_app_setup.m_file.m_importapplications.toolbaritemvisible = false
				m_pfe_train_app_setup.m_file.m_save.toolbaritemvisible = false
				m_pfe_train_app_setup.m_edit.m_insert.toolbaritemvisible = false
				m_pfe_train_app_setup.m_edit.m_delete1.toolbaritemvisible = false
			end if
			
			IF of_security_access(7789) = 0 THEN
				m_pfe_train_app_setup.m_edit.m_delete1.visible = false
				m_pfe_train_app_setup.m_edit.m_delete1.toolbaritemvisible = false
			end if
		 //End Code Change ----03.12.2015
	//End Code Change ----03.06.2012
	
			IF of_security_access(7844) = 0 THEN   //Start Code Change ----02.21.2017 #V153 maha
				m_pfe_train_app_setup.m_file.m_importapplications.visible = false
			end if
				
	CASE ELSE
		
		IF Handle(GetApplication()) =  0 THEN
			//f_system_error_handler("The Menu " + as_menu_name + " does not have any scurity applied to it!" )
			//MESSAGEBOX('Menu security',"The Menu " + as_menu_name + " does not any scurity applied to it!" )
		END IF
		
END CHOOSE

//---------Begin Added by (Appeon)Alfee 06.29.2013 for V141 ISG-CLX--------
IF gb_contract_module THEN
	If IsValid( m_pfe_cst_mdi_menu ) Then 
		If gnv_data.of_getitem( 'icred_settings', 'esign', False) = '1' Then
			m_pfe_cst_mdi_menu.m_system.m_refresh_sertifi.Visible = True // Added by (Appeon)Alfee 07.18.2016
		Else
			m_pfe_cst_mdi_menu.m_system.m_refresh_sertifi.Visible = false 
		End If
		//---------Begin Added by (Appeon)Toney 11.07.2013 for V141 ISG-CLX--------
		//$Reason:Fix BugT102201
		m_pfe_cst_mdi_menu.m_window.m_savecontractfolderstate.visible = True
		m_pfe_cst_mdi_menu.m_window.m_savecontractfolderstate.checked = gb_restore_contract_state		
		//---------End Added ------------------------------------------------------------------
	End If
ELSEIF IsValid( m_pfe_cst_mdi_menu ) Then 
	//If gnv_data.of_getitem( 'icred_settings', 'esign', False) = '1' and gs_esigntype = 'sertifi' Then // (Appeon)Harry 05.26.2016 - Application Electronic Signature - Sertifi
	If gnv_data.of_getitem( 'icred_settings', 'esign', False) = '1' and gs_esigntype <> 'echosign' Then  // (Appeon)Harry 07.19.2016
		m_pfe_cst_mdi_menu.m_system.m_refresh_sertifi.Visible = true // (Appeon)Harry 06.30.2016 - for BugL062901
	Else
		m_pfe_cst_mdi_menu.m_system.m_refresh_sertifi.Visible = false
	End If
	m_pfe_cst_mdi_menu.m_system.m_refreshdocumentapprovaldata.Visible = false 	
	m_pfe_cst_mdi_menu.m_window.m_savecontractfolderstate.Visible = false
	m_pfe_cst_mdi_menu.m_reports.m_profilerpt.Visible = false
END If

of_Menu_Security_2(as_menu_name)

if gb_IsDocMode then of_HideMenuAndToolItems(This.MenuID)	
//---------End Added ------------------------------------------------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08.31.2006 By: Liang QingShi
//$<reason> Contract module modification 
IF gb_contract_version = True THEN
	m_pfe_cst_master_menu.m_file.m_casepeerreview.Visible = False //Added by Scofield on 2008-04-23
	m_pfe_cst_master_menu.m_system.m_painters.m_profiles.m_reportpainter.Visible = False //Added by Alan on 2008-10-13
	//m_pfe_cst_master_menu.m_file.m_contract.ToolbarItemOrder = 0  //Commented by (Appeon)Alfee 07.26.2013 - V141 ISG-CLX
	//Start Code Change ----07.25.2012 #V12 maha - added item trapping for contracts version
	m_pfe_cst_master_menu.m_file.m_qualityprofilemeasurements.toolbaritemvisible = false
//	m_pfe_cst_master_menu.m_file.m_contract.toolbaritemvisible = false //Start Code Change ----01.02.2013 #V12 maha - removed
	m_pfe_cst_master_menu.m_file.m_casepeerreview.toolbaritemvisible = false
	m_pfe_cst_master_menu.m_file.m_caqhfileimport.toolbaritemvisible = false
	m_pfe_cst_master_menu.m_system.m_setup.toolbaritemvisible = false
	m_pfe_cst_master_menu.m_system.m_applicationmapping.toolbaritemvisible = false
	m_pfe_cst_master_menu.m_system.m_viewredflagdata.Visible = False
	m_pfe_cst_master_menu.m_system.m_communicationlogs.m_fax_log.Visible = false
	//End Code Change ----07.25.2012
	m_pfe_cst_master_menu.m_file.m_recruitmentevaluations.Visible = false//long.zhang 11.18.2013
	m_pfe_cst_master_menu.m_system.m_verificationbatchfunctions.m_oiglog.Visible = false  //Start Code Change ----07.07.2015 #V15 maha
		//m_pfe_cst_master_menu.m_system.m_verificationbatchfunctions.m_batchverifications.Visible = False
ELSE
	IF NOT IsValid (m_pfe_cst_mdi_menu_contract) AND NOT IsValid (m_pfe_cst_mdi_menu_contract_am) THEN
		m_pfe_cst_master_menu.m_system.m_setup.toolbaritemvisible = true//(Appeon)Alfee 07.26.2013 - V141 ISG-CLX 
	END IF
	//m_pfe_cst_master_menu.m_file.m_contract.ToolbarItemOrder = 8 //Commented by (Appeon)Alfee 07.26.2013 - V141 ISG-CLX 
END IF
//---------------------------- APPEON END ----------------------------

if gi_user_readonly = 1 then 
	m_pfe_cst_master_menu.m_system.m_setup.visible = false
	m_pfe_cst_master_menu.m_system.m_setup.toolbaritemvisible = false
	m_pfe_cst_master_menu.m_system.m_batchupdate.Visible = False
	m_pfe_cst_master_menu.m_system.m_utilities.Visible = False
	m_pfe_cst_master_menu.m_system.m_verificationbatchfunctions.m_batchoig.Visible = False   //Start Code Change ----11.18.2015 #V15 maha
	m_pfe_cst_master_menu.m_system.m_verificationbatchfunctions.m_importoigdata.Visible = False  //Start Code Change ----11.18.2015 #V15 maha
	m_pfe_cst_master_menu.m_reports.m_letters.Visible = False
else
	//Start Code Change ----08.11.2014 #V14.2 maha
	// Setup screen
	IF of_security_access( 7767 ) = 0 THEN
		m_pfe_cst_master_menu.m_system.m_setup.toolbaritemvisible = false
		m_pfe_cst_master_menu.m_system.m_setup.Visible = False
	ELSE
		m_pfe_cst_master_menu.m_system.m_setup.Visible = True  //Start Code Change ----09.10.2014 #V14.2 maha - corrected from m_painters
		m_pfe_cst_master_menu.m_system.m_setup.toolbaritemvisible = True
	END IF
end if

if gb_use_prac_toolbar = true then //Start Code Change ----11.13.2012 #V12 maha
	m_pfe_cst_master_menu.m_system.m_setup.toolbaritemvisible = false
end if


if gb_sk_ver then
	of_menu_security_sk( )
end if

//Shrink toolbars
if as_menu_name =  "m_pfe_cst_action_items" then
	of_menu_shrink_action_items( ) //Start Code Change ----02.26.2013 #V12 maha
end if

//---------Begin Added by (Appeon)Alfee 08.02.2013 for V141 ISG-CLX--------
IF 	PosA( as_menu_name, "m_pfe_train_app" ) > 0 Or as_menu_name = "m_pfe_cst_import_painter" Or as_menu_name = "m_pfe_cst_prac_data_design" THEN   //Start Code Change ----01.20.2017 #V153 maha - removed Or as_menu_name = "m_pfe_cst_meetings"  &
	of_menu_shrink_toolbars (1 )  //IntelliCred
ELSEIF as_menu_name = "m_ctx_doc_painter" OR as_menu_name = "m_pfe_cst_agreement_template" OR as_menu_name = "m_pfe_cst_clause_painter" &
	OR PosA( as_menu_name, "m_pfe_cst_contract" ) > 0 OR as_menu_name = "m_req"  THEN
	of_menu_shrink_toolbars (2 )  //Contract
ELSEIF as_menu_name = "m_pfe_cst_mail" AND (gb_contract_module OR gi_email_type = 0) THEN   
	of_menu_shrink_toolbars (3 )  //Both
END IF
//---------End Added ------------------------------------------------------------------

//---------Begin Added by (Appeon)Harry 03.18.2014 for V142 ISG-CLX--------
If gb_contract_version Then
	//added by gavins 20130304
	dw_ezmenu.of_Refresh_toolbar( this.menuid )
	
	If gb_show_EZMenu Then
		If ib_EZMen_First = True Then
			dw_ezmenu.SetRedraw( False )			
			dw_ezmenu.of_Set_Menu( This.MenuID )			
			dw_ezmenu.SetRedraw( True )	
		Else
			gnv_app.of_Set_ezmenu_refresh_state( TRUE )
			gnv_app.post of_refresh_ezmenu( )
		End If
	End If
	
	ib_EZMen_First = FALSE
End If
//---------End Added ------------------------------------------------------


//messagebox("","menu security")

This.SetRedraw(True) //Added by Appeon long.zhang 02.04.2017 (For Screen Bleed Issue)

RETURN 0

end function

public function integer of_prac_folder_security (w_prac_data_1 aw_prac_folder);IF of_version_check() = 0 THEN
	RETURN 1
END IF
//Start Code Change ---- 03.30.2006 #360 maha

aw_prac_folder.SetRedraw(False) //Walkaround for web version, Added by Appeon long.zhang 04.22.2016 (Bug id 5109 - IE closing after adding an appointment)
aw_prac_folder.tab_1.tabpage_app_audit.visible = true
aw_prac_folder.SetRedraw(True) //Walkaround for web version, Added by Appeon long.zhang 04.22.2016 (Bug id 5109 - IE closing after adding an appointment)

aw_prac_folder.tab_1.tabpage_image.visible = true
aw_prac_folder.tab_1.tabpage_net.visible = true
aw_prac_folder.tab_1.tabpage_meetings.visible = true
aw_prac_folder.tab_1.tabpage_privileges.visible = true
aw_prac_folder.tab_1.tabpage_profile.visible = true
aw_prac_folder.tab_1.tabpage_verif.visible = true
//End Code Change---03.30.2006
Integer i
Integer li_cnt

li_cnt = UpperBound( ii_security_action_id )

FOR i = 1 TO li_cnt
	//credentialing data
//	IF ii_security_action_id[ i ] = 1000 THEN
//		IF ii_security_action_value[ i ] = 0 THEN
//			 
//		ELSEIF ii_security_action_value[ i ] = 1 THEN
//			//aw_prac_folder.tab_1.tabpage_detail.uo_data_entry.dw_detail.Enabled = False
//		END IF
//	END IF
	//credentialing data
	IF ii_security_action_id[ i ] = 50 THEN
		IF ii_security_action_value[ i ] = 0 THEN
			aw_prac_folder.tab_1.tabpage_detail.Visible = False
		ELSEIF ii_security_action_value[ i ] = 1 THEN
			 //Start Code Change ----05.26.2009 #V92 maha - removed; handled from the pfc_cst_u_data_entry object
			//aw_prac_folder.tab_1.tabpage_detail.uo_data_entry.dw_detail.Enabled = False //Start Code Change --05.26.2009 #V92 maha - read only security now done at the field level 
			//aw_prac_folder.tab_1.tabpage_detail.uo_data_entry.dw_link_list.Enabled = False  //Start Code Change ----05.26.2009 #V92 maha - read only security now done elsewhere
		END IF
	END IF
	//application audit
	IF ii_security_action_id[ i ] = 90 THEN
		IF ii_security_action_value[ i ] = 0 THEN
			aw_prac_folder.tab_1.tabpage_app_audit.Visible = False
		ELSEIF ii_security_action_value[ i ] = 1 THEN
			 //Start Code Change ----06.16.2009 #V92 maha - removed; handled from the pfc_cst_u_application_audit
			//aw_prac_folder.tab_1.tabpage_app_audit.uo_app_audit.dw_detail.Enabled = False
			//aw_prac_folder.tab_1.tabpage_app_audit.uo_app_audit.dw_tracker.Enabled = False			
		END IF
	END IF
	//appointment status
	IF ii_security_action_id[ i ] = 120 THEN
		IF ii_security_action_value[ i ] = 0 THEN
			aw_prac_folder.tab_1.tabpage_apptmnt_status.Visible = False
		ELSEIF ii_security_action_value[ i ] = 1 THEN
			//aw_prac_folder.tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_detail_1.dw_apptmnt_status.Enabled = False   //Start Code Change ----03.23.2017 #V153 maha - moved to uo
			aw_prac_folder.tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_detail_1.dw_comm_review.Enabled = false //maha 063004
			aw_prac_folder.tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_detail_2.dw_staff_cat.Enabled = False			
			aw_prac_folder.tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_detail_2.dw_departments.Enabled = False						
			aw_prac_folder.tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_detail_2.dw_leave.Enabled = False
		END IF
	END IF
	//IF ii_security_action_id[ i ] = 6961 THEN  //Start Code Change ----03.30.2012 #V12 maha - security on OFE tab
	IF ii_security_action_id[ i ] = 7611 THEN  //(Appeon)Alfee 06.29.2013 - V141 ISG-CLX
		IF ii_security_action_value[ i ] = 0 THEN
			//------------------- APPEON BEGIN -------------------
			//<$>added:long.zhang 07.01.2016
			//<$>reason:Bug id 5221 - IE crashing when clicking on Provider Documents tab 
			
//			aw_prac_folder.tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_ofe.visible = True	//Walkaround for Web Version,Added by Appeon long.zhang 06.24.2016 (Bug id 5211 - Cannot make Provider Documents tab Read Only)
//			aw_prac_folder.tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_ofe.visible = false
			aw_prac_folder.tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.tabpage_ofe.enabled = False
			//------------------- APPEON END -------------------	
		end if
	end if
	
	
//verification status
//Start Code Change ---- 05.11.2006 #439 maha
	if gs_cust_type = "I" then
		aw_prac_folder.tab_1.tabpage_verif.Visible = False
	else
		IF ii_security_action_id[ i ] = 140 THEN
			IF ii_security_action_value[ i ] = 0 THEN
				aw_prac_folder.tab_1.tabpage_verif.Visible = False
			ELSEIF ii_security_action_value[ i ] = 1 THEN
				//aw_prac_folder.tab_1.tabpage_verif.uo_verif_summary.dw_detail.Enabled = False = //Start Code Change ----10.10.2012 #V12 maha - removed
			END IF
		END IF
	end if
//Start Code Change ---- 11.01.2005 #3 maha	
	IF ii_security_action_id[ i ] = 170 THEN
		IF ii_security_action_value[ i ] = 0 THEN
			aw_prac_folder.tab_1.tabpage_verif.uo_verif_summary.tab_view.tabpage_recred.cb_init_recred.Enabled = False
			aw_prac_folder.tab_1.tabpage_verif.uo_verif_summary.tab_view.tabpage_recred.cb_crednoverif.Enabled = False
			aw_prac_folder.tab_1.tabpage_verif.uo_verif_summary.tab_view.tabpage_recred.dw_recred_info.Enabled = False
		END IF
	END IF
//End Code Change---11.01.2005 



	//net development - appointment status
	if gi_iapp_on = 0 then
		aw_prac_folder.tab_1.tabpage_net.Visible = False
	else
		IF ii_security_action_id[ i ] = 1400 THEN
			IF ii_security_action_value[ i ] = 0 THEN
				aw_prac_folder.tab_1.tabpage_net.Visible = False
			ELSEIF ii_security_action_value[ i ] = 1 THEN //view only
				 //Start Code Change ----06.16.2009 #V92 maha - removed; handled from the pfc_ia_cst_nv_net_dev_new
				//aw_prac_folder.tab_1.tabpage_net.uo_net.tab_1.tabpage_ai.dw_net_dev.Enabled = False
				//aw_prac_folder.tab_1.tabpage_net.uo_net.tab_1.tabpage_ids.dw_ids.Enabled = False
				
//				aw_prac_folder.tab_1.tabpage_net.uo_net.tab_1.tabpage_notes.dw_notes.Enabled = False  //Commented by (Appeon)Stephen 06.19.2015 - Bug id 4567 - Read Only user is missing notes scroll bar, SAAS 14.2 and Client Server 14.1 and 14.2
				aw_prac_folder.tab_1.tabpage_net.uo_net.tab_1.tabpage_ai.dw_appoint_stat.Enabled = False	//maha 071604
//				aw_prac_folder.tab_1.tabpage_net.uo_net.cb_1.Enabled = False	//maha 071604
				aw_prac_folder.tab_1.tabpage_net.uo_net.cb_batch.Enabled = False  //Start Code Change ----06.16.2009 #V92 maha
				aw_prac_folder.tab_1.tabpage_net.uo_net.cb_ma.Enabled = False //Added by Appeon long.zhang 11.20.2014
			END IF
		END IF	
		 //Start Code Change ----03.12.2015 #V15 maha
		IF  ii_security_action_id[ i ] = 7776 and ii_security_action_value[ i ] = 0 then
			aw_prac_folder.tab_1.tabpage_net.uo_net.cb_batch.visible = False 
		end if
			
		IF  ii_security_action_id[ i ] = 7777  and ii_security_action_value[ i ] = 0 then
			aw_prac_folder.tab_1.tabpage_net.uo_net.cb_ma.visible = False
		end if
		 //End Code Change ----03.12.2015	
	end if
	
	//privileging	maha040201
	if gi_priv_mod = 0 or gs_cust_type = "I" then   //Start Code Change ----01.17.2017 #V153 maha - hide for App
		aw_prac_folder.tab_1.tabpage_privileges.visible = False
	else
		IF ii_security_action_id[ i ] = 210 THEN
			IF ii_security_action_value[ i ] = 0 THEN
				aw_prac_folder.tab_1.tabpage_privileges.visible = False
			//Start Code Change ----10.18.2010 #V10 maha - moved to function in object set variable	
			else
				aw_prac_folder.tab_1.tabpage_privileges.uo_priv.ii_rights =  ii_security_action_value[ i ]
			//ELSEIF ii_security_action_value[ i ] = 1 THEN //view only
				//aw_prac_folder.tab_1.tabpage_privileges.uo_priv.tab_1.tabpage_detail.dw_detail.Enabled = False
				//aw_prac_folder.tab_1.tabpage_privileges.uo_priv.tab_1.tabpage_exp_priv.dw_expired.Enabled = False
			END IF
		END IF
	end if
	//imaging	maha040201
	if gi_imaging = 0 then
		aw_prac_folder.tab_1.tabpage_image.visible = False
	else
		IF ii_security_action_id[ i ] = 1000 THEN
			IF ii_security_action_value[ i ] = 0 THEN
				aw_prac_folder.tab_1.tabpage_image.visible = False
			ELSEIF ii_security_action_value[ i ] = 1 THEN //view only
				//------------------- APPEON BEGIN -------------------
				//<$>added:long.zhang 07.01.2016
				//<$>reason:Bug id 5221 - IE crashing when clicking on Provider Documents tab
				
//				// maha removed 092204 aw_prac_folder.tab_1.tabpage_image.uo_image.tab_view.tabpage_browse.dw_browse.object.deleteall.visible = False
//				aw_prac_folder.tab_1.tabpage_image.uo_image.tab_view.tabpage_setup.visible = True	//Walkaround for Web Version,Added by Appeon long.zhang 06.24.2016 (Bug id 5211 - Cannot make Provider Documents tab Read Only)
//				aw_prac_folder.tab_1.tabpage_image.uo_image.tab_view.tabpage_setup.visible = False
				aw_prac_folder.tab_1.tabpage_image.uo_image.tab_view.tabpage_setup.enabled = False
				//------------------- APPEON END -------------------
			END IF
		END IF
			//imaging page data access maha012103
		IF ii_security_action_id[ i ] = 1390 THEN
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 01-16-2007 By: Allen
			//$<reason> 
			/*
			IF ii_security_action_value[ i ] = 0 THEN
			*/
			IF ii_security_action_value[ i ] = 0  AND aw_prac_folder.tab_1.tabpage_image.visible and aw_prac_folder.ib_page7_selected THEN
				//---------------------------- APPEON END ----------------------------
				
				//--------------------------- APPEON BEGIN ---------------------------
				//$<modify> 06.01.2007 By: Frank.Gui; Ken.Guo 2008-02-25 added 'and aw_prac_folder.ib_page7_selected'
				//$<reason> 
				//Old Codes:
					//aw_prac_folder.tab_1.tabpage_image.uo_image.tab_view.tabpage_browse.dw_browse.object.start_page.protect = true
					//aw_prac_folder.tab_1.tabpage_image.uo_image.tab_view.tabpage_browse.dw_browse.object.num_pages.protect = true
				//New Codes:	
				aw_prac_folder.tab_1.tabpage_image.uo_image.tab_view.tabpage_browse.dw_browse.modify("start_page.protect =1")
				aw_prac_folder.tab_1.tabpage_image.uo_image.tab_view.tabpage_browse.dw_browse.modify("num_pages.protect =1")
			ELSEIF ii_security_action_value[ i ] = 1  AND aw_prac_folder.tab_1.tabpage_image.visible and aw_prac_folder.ib_page7_selected THEN
				aw_prac_folder.tab_1.tabpage_image.uo_image.tab_view.tabpage_browse.dw_browse.modify("start_page.protect =0")
				aw_prac_folder.tab_1.tabpage_image.uo_image.tab_view.tabpage_browse.dw_browse.modify("num_pages.protect =0")				
				//---------------------------- APPEON END ----------------------------
			END IF
		END IF
	end if
	
//imaging page data access maha012103 //Start Code Change ----01.04.2008 #V8 maha copied from version4.5
	//IF ii_security_action_id[ i ] = 1390 THEN
	IF ii_security_action_id[ i ] = 1390 and aw_prac_folder.ib_page7_selected THEN //Modified by Ken.Guo 2008-02-25
		IF ii_security_action_value[ i ] = 0 THEN
			aw_prac_folder.tab_1.tabpage_image.uo_image.tab_view.tabpage_browse.dw_browse.object.start_page.protect = true
			aw_prac_folder.tab_1.tabpage_image.uo_image.tab_view.tabpage_browse.dw_browse.object.num_pages.protect = true
		END IF
	END IF
	
//End Code Change---05.10.2006
	//profile printing access maha 082905
	IF ii_security_action_id[ i ] = 1580 THEN
		IF ii_security_action_value[ i ] = 0 THEN
			aw_prac_folder.tab_1.tabpage_profile.visible = False
		END IF
	END IF
	
//Start Code Change ----03.16.2016 #V15 maha	- moved to object of_set_security
////Start Code Change ----02.29.2008 #V8 maha	-  new button security
//	//Practitioner search screen
//	IF ii_security_action_id[ i ] = 20 THEN
//		IF ii_security_action_value[ i ] = 0 THEN
//			aw_prac_folder.tab_1.tabpage_search.uo_search.cb_new.visible = false
//			aw_prac_folder.tab_1.tabpage_search.uo_search.r_new.visible = false
//		END IF
//	END IF
////End Code Change---02.29.2008
	
		//meetings	maha 012103
	IF ii_security_action_id[ i ] = 190 THEN
		IF ii_security_action_value[ i ] = 0 THEN
			aw_prac_folder.tab_1.tabpage_meetings.visible = False
		ELSEIF ii_security_action_value[ i ] = 1 THEN //view only
			aw_prac_folder.tab_1.tabpage_meetings.uo_meetings.tab_view.tabpage_detail.dw_detail.Enabled = False
		END IF
	END IF
	
	 //Start Code Change ----02.21.2017 #V153 maha
	 IF ii_security_action_id[ i ] = 7843 THEN
		IF ii_security_action_value[ i ] = 0 THEN
			aw_prac_folder.dw_p_data.modify("b_text.visible = false")
		end if
	End if
END FOR

if gb_sk_ver then  //Start Code Change ----05.24.2010 #V10 maha - smart
	aw_prac_folder.tab_1.tabpage_meetings.visible = false
	aw_prac_folder.tab_1.tabpage_privileges.visible = false
	aw_prac_folder.tab_1.tabpage_profile.visible = false
	aw_prac_folder.tab_1.tabpage_verif.visible = false
	aw_prac_folder.tab_1.tabpage_apptmnt_status.Visible = False
end if


		
	

RETURN 1
end function

public function integer of_action_items_security (w_action_items aw_action_items);IF of_version_check() = 0 THEN
	RETURN 1
END IF

Integer i
Integer li_cnt

li_cnt = UpperBound( ii_security_action_id )

FOR i = 1 TO li_cnt
	//Analysis tab
	IF ii_security_action_id[ i ] = 250 THEN
		IF ii_security_action_value[ i ] = 0 THEN
			aw_action_items.tab_1.tabpage_analysis.Visible = False
		ELSEIF ii_security_action_value[ i ] = 1 THEN
			aw_action_items.tab_1.tabpage_analysis.tab_analysis.tabpage_exp_appointments.dw_expiring_appointments_graph.enabled = False
			aw_action_items.tab_1.tabpage_analysis.tab_analysis.tabpage_expiring_credentials.dw_expiring_credential_graph.enabled = False
			aw_action_items.tab_1.tabpage_analysis.tab_analysis.tabpage_last_attempt.dw_last_attemp_graph.Enabled = False
			aw_action_items.tab_1.tabpage_analysis.tab_analysis.tabpage_total_attempts.dw_total_attempts.enabled = False
			//------------------- APPEON BEGIN -------------------
			//<$>added:long.zhang 12.09.2015
			//<$>reason:V14.2 Applause Cycle 2 Bug # 4873 - Can click on Missing Checklist chart after setting Action Items->Analysis->View Rights to Read Only
			aw_action_items.tab_1.tabpage_analysis.tab_analysis.tabpage_audit.dw_app_audit_graph.Enabled = False
			aw_action_items.tab_1.tabpage_analysis.tab_analysis.tabpage_process.dw_process_graph.Enabled = False
			//------------------- APPEON END -------------------
		END IF
	END IF
	//Detail tab
	IF ii_security_action_id[ i ] = 255 THEN
		IF ii_security_action_value[ i ] = 0 THEN
			aw_action_items.tab_1.tabpage_detail.Visible = False
		ELSEIF ii_security_action_value[ i ] = 1 THEN
			//aw_action_items.tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.enabled = False  //Start Code Change ----07.12.2011 #V11 maha - moved to dw_detail.retrieveend
			aw_action_items.tab_1.tabpage_detail.tab_view.tabpage_details.dw_detail.enabled = False
		END IF
	END IF	

	//network development
	IF ii_security_action_id[ i ] = 1700 THEN
		IF ii_security_action_value[ i ] = 0 THEN
			aw_action_items.tab_1.tabpage_net_dev.visible = False
		END IF
	END IF		
	
	
	//Completed Applications
	IF ii_security_action_id[ i ] = 310 THEN
		IF ii_security_action_value[ i ] = 0 THEN
			aw_action_items.tab_1.tabpage_ready.visible = False
		ELSEIF ii_security_action_value[ i ] = 1 THEN
			//---------Begin Commented by (Appeon)Stephen 12.08.2015 for V14.2 Applause Cycle 2 Bug # 4870 - Can't use scroll bar when Committee Status is set to Read Only--------
			/*
			aw_action_items.tab_1.tabpage_ready.tab_ready.tabpage_ready_to_send.dw_ready.enabled = False
			aw_action_items.tab_1.tabpage_ready.tab_ready.tabpage_sent_to_comm.dw_sent_to_comm.enabled = False
			*/
			//---------End Commented ------------------------------------------------------

		END IF
	END IF		
	//Send to Committee
	IF ii_security_action_id[ i ] = 320 THEN
		IF ii_security_action_value[ i ] = 0 THEN
			aw_action_items.tab_1.tabpage_ready.cb_send.enabled = False				
			aw_action_items.tab_1.tabpage_ready.cb_1.visible = false  //Start Code Change ----02.11.2016 #V15 maha
		END IF
	END IF			
	//Post Committee Results
	IF ii_security_action_id[ i ] = 330 THEN
		IF ii_security_action_value[ i ] = 0 THEN
			aw_action_items.tab_1.tabpage_ready.cb_post.enabled = False	
			aw_action_items.tab_1.tabpage_ready.cb_1.visible = false   //Start Code Change ----02.11.2016 #V15 maha
		END IF
	END IF				

	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 08.18.2006 By: LeiWei
	//$<reason> Making the Contract Module a Standalone Product
	//Application Status 
	IF ii_security_action_id[ i ] = 5200 THEN
		IF ii_security_action_value[ i ] = 0 THEN
			aw_action_items.tab_1.tabpage_net_dev.Visible = False									
		END IF
	END IF				

	//Contract tab
	IF ii_security_action_id[ i ] = 5210 THEN
		IF ii_security_action_value[ i ] = 0 THEN
			aw_action_items.tab_1.tabpage_contract.Visible = False									
		END IF
	END IF

	//---------------------------- APPEON END ----------------------------
END FOR


RETURN 0
end function

public function integer of_delete_practitioner ();//Start Code Change ----04.14.2008 #V8 maha - this functionality moved to the pfc_cst_extended_search object for v 8

//Long ll_prac_id
//Integer li_ans
gs_search lstr_search
//n_ds lds_tables
//integer t
//integer tc
//string ls_tname
//string ls_sql
//
lstr_search.stran_transaction = SQLCA
lstr_search.ls_open_for = "DELETE"
//
//Start Code Change ----12.14.2010 #V11 maha 
if gb_sk_ver then
	OpenWithParm( w_extended_search_app , lstr_search )
else
	OpenWithParm( w_extended_search_new , lstr_search )
end if
//End Code Change ----12.14.2010

//
//IF Message.DoubleParm = -1 THEN
//	Return -1
//END IF
//
//ll_prac_id = gl_prac_id
//
//li_ans = MessageBox("DELETE", "This will delete all of the data associated with the practitioner.  Continue?", Information!, YesNo!, 2 )
//
//IF li_ans = 1 THEN
//	li_ans = MessageBox("DELETE", "Are you sure?", Information!, YesNo!, 2 )
//	IF li_ans = 2 THEN
//		RETURN -1
//	END IF
//ELSE
//	RETURN -1
//END IF
//
//COMMIT USING SQLCA;
//
//// code rewritten maha 061804 (4.187)to catch all pd tables including customs.
//lds_tables = create n_ds
//lds_tables.dataobject = "d_pd_tables_for_prac_delete"
//lds_tables.settransobject(sqlca)
//
////--------------------------- APPEON BEGIN ---------------------------
////$<modify> 2005-11-11 By: owen chen
////$<reason> add database option for sql excution
//
//string ls_sqlsyntax
////ls_sqlsyntax =   " SELECT systable.table_id, "+&  
////						"systable.table_name "+& 
////						"FROM systable "+& 
////						"WHERE systable.table_name like 'pd%'"  
//
//choose case gs_dbtype
//	case 'ASA'
//		ls_sqlsyntax =   " SELECT systable.table_id, "+&  
//         					"systable.table_name "+& 
//    							"FROM systable "+& 
//   							"WHERE systable.table_name like 'pd%'"  
//	case 'SQL'
//		ls_sqlsyntax =  " SELECT v_systable.table_id, "+&  
//        						"v_systable.table_name "+& 
//    							"FROM v_systable "+& 
//   							"WHERE v_systable.table_name like 'pd%' "    
//end choose
//lds_tables.setSqlSelect(ls_sqlsyntax)
//
////---------------------------- APPEON END ----------------------------
//
//
//
//
//
//tc = lds_tables.retrieve()
//
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-03
////$<add> 03.21.2006 By: LeiWei
////$<reason> Performance tuning
////$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
// 
//gnv_appeondb.of_startqueue( )
////---------------------------- APPEON END ----------------------------
//
//for t = 1 to tc
//	ls_tname = lds_tables.getitemstring(t,"table_name")
//	choose case ls_tname
//		case "pd_basic", "pd_affil_stat"
//			continue
//		case else
//			ls_sql = "DELETE FROM " + ls_tname + " where prac_id = " + string(ll_prac_id) + ";"
//			execute immediate :ls_sql using sqlca;
//			commit using sqlca;
//	end choose
//next
//	
//delete from pd_affil_stat
//where prac_id = :ll_prac_id;
//IF SQLCA.SQLCODE = -1 THEN
//	MessageBox("Delete", SQLCA.SQLERRTEXT )
//	RETURN -1
//END IF
//
//delete from verif_info
//where prac_id = :ll_prac_id;
//IF SQLCA.SQLCODE = -1 THEN
//	MessageBox("Delete", SQLCA.SQLERRTEXT )
//	RETURN -1
//END IF
//
//delete from net_dev_ids
//where prac_id = :ll_prac_id;
//IF SQLCA.SQLCODE = -1 THEN
//	MessageBox("Delete", SQLCA.SQLERRTEXT )
//	RETURN -1
//END IF
//
//delete from net_dev_action_items
//where prac_id = :ll_prac_id;
//IF SQLCA.SQLCODE = -1 THEN
//	MessageBox("Delete", SQLCA.SQLERRTEXT )
//	RETURN -1
//END IF
//
//delete from pd_basic
//where prac_id = :ll_prac_id;
//IF SQLCA.SQLCODE = -1 THEN
//	MessageBox("Delete", SQLCA.SQLERRTEXT )
//	RETURN -1
//END IF
//
//COMMIT USING SQLCA;
//
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-04
////$<add> 03.21.2006 By: LeiWei
////$<reason> Performance tuning
////$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
// 
//gnv_appeondb.of_commitqueue( )
////---------------------------- APPEON END ----------------------------
//
//MessageBox("DELETE", "The record has been deleted.", Information! )

RETURN 0
end function

public function integer of_module_check ();//VERSION CODES	FIRST 4 ALPHA NUMERIC OF VERSION CODE
//
//LIGHT			AA115
//GOLD			BB226
//WORKGROUP		CC337
//ENTERPRISE		EE448
//
//
//
//DIGIT		MODULE				ON VALUE		OFF VALUE
//6			SECURITY MODULE	7					0
//7			PRIVILIGING			3					0
//8			IMAGING				8					0
//9			SITE SURVEYS		5					0
//10			AUDIT TRAIL			1					0
//11			APPLICATION AUDIT	4					0
//12			ACTION ITEMS		6					0
//13			SCREEN PAINTER		2					0
//14			MEETINGS				5					0





Return 1

//Start Code Change ----02.24.2011 #V11 maha  - as this is not used, commented out


//
//String ls_version
//
////check to see if security is installed, if it is not then give access to new view
//ls_version = ProfileString(gs_IniFilePathName, "setup", "version", "None")
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-05
////$<modify> 01.17.2006 By: Cao YongWang
////$<reason> No need to make sure the intellicred.ini file exists in the client on web application.
////IF NOT FileExists(gs_dir_path + "intellicred\intellicred.ini" ) THEN
////	MessageBox("ini File Error", "No intellicred.ini file found at: " + gs_dir_path + "intellicred\intellicred.ini" )
////	Return -1
////END IF
//If appeongetclienttype() = 'PB' Then
//	IF NOT FileExists(gs_IniFilePathName) THEN
//		MessageBox("ini File Error", "No intellicred.ini file found at: " + gs_IniFilePathName )
//		Return -1
//	END IF
//End If
////---------------------------- APPEON END ----------------------------
//
//IF ls_version = "None" THEN
//	MessageBox("Error", "Version number not setup.")
//	RETURN -1
//END IF
//
//
////security
//IF MidA( ls_version, 6, 1) = "7" THEN
//	m_pfe_cst_master_menu.m_system.m_painters.m_rolepainter.enabled = True
//ELSE
//	m_pfe_cst_master_menu.m_system.m_painters.m_rolepainter.enabled = False
//END IF
//
//
////site survey
//IF MidA( ls_version, 9, 1) = "5" THEN
//	m_pfe_cst_master_menu.m_system.m_painters.m_surveypainter.visible = True
//ELSE
//	m_pfe_cst_master_menu.m_system.m_painters.m_surveypainter.visible = False
//END IF
//
//
////audit trail
//IF MidA( ls_version, 10, 1) = "1" THEN
//	m_pfe_cst_master_menu.m_system.m_audittrail.visible = True
//ELSE
//	m_pfe_cst_master_menu.m_system.m_audittrail.visible = False
//END IF
//
//
////app audit painter
//IF MidA( ls_version, 11, 1) = "4" THEN
//	m_pfe_cst_master_menu.m_system.m_painters.m_applicationauditpainter.visible = True
//ELSE
//	m_pfe_cst_master_menu.m_system.m_painters.m_applicationauditpainter.visible = False	
//END IF
//
//
////action items
//IF MidA( ls_version, 12, 1) = "6" THEN
//	m_pfe_cst_master_menu.m_file.m_actionitems.visible = True
//ELSE
//	m_pfe_cst_master_menu.m_file.m_actionitems.visible = False
//	m_pfe_cst_master_menu.m_file.m_actionitems.toolbaritemvisible = False
//END IF
//
////screen painter
//IF MidA( ls_version, 13, 1) = "2" THEN
//	m_pfe_cst_master_menu.m_system.m_painters.m_screenpainter.visible = True
//ELSE
//	m_pfe_cst_master_menu.m_system.m_painters.m_screenpainter.visible = False	
//END IF
//
////meetings
//IF MidA( ls_version, 14, 1) = "5" THEN
//	m_pfe_cst_master_menu.m_file.m_meetings.visible = True
//ELSE
//	m_pfe_cst_master_menu.m_file.m_meetings.visible = False
//	m_pfe_cst_master_menu.m_file.m_meetings.toolbaritemvisible = False
//END IF
//
//
//RETURN 1


end function

public function integer of_version_check ();Return 1

String ls_version

//VERSION CODES
//
//LIGHT			AA115
//GOLD			BB226
//WORKGROUP		CC337
//ENTERPRISE		EE448
//
//SECURITY MODULE
//If the security module is installed then the 6th  digit of the version code will equel to 7 else it will be 0
//
//PRIVILIGING
//If privileging is installed then the 7th digit will equel 3
//
//IMAGING 
//IF imaging is installed then the 8th digit will equal 8
//
//SITE SURVEYS
//If site surveys is installed then the 9th digit will equal 5




ls_version = ProfileString(gs_IniFilePathName, "setup", "version", "None")
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-06
//$<modify> 01.17.2006 By: Cao YongWang
//$<reason> Performance tuning. There is no need to check the INI file on local machine. The Web application
//$<reason> reads INI file from the server.
//$<modification> Make an condition to make sure when it is on the Web, the IntelliCred application
//$<modification> does not read local INI file.
//IF NOT FileExists( gs_dir_path + "intellicred\intellicred.ini" ) THEN
//	MessageBox("ini File Error", "No intellicred.ini file found at: " + gs_dir_path + "intellicred\intellicred.ini" )
//	Return -1
//END IF
If appeongetclienttype() = 'PB' Then
	IF NOT FileExists(gs_IniFilePathName) THEN
		MessageBox("ini File Error", "No intellicred.ini file found at: " + gs_IniFilePathName )
		Return -1
	END IF
End If
//---------------------------- APPEON END ----------------------------


IF ls_version = "None" THEN
	MessageBox("Error", "Version number not setup.")
	RETURN -1
END IF

IF MidA( ls_version, 6, 1) = "7" THEN
	Return 1
ELSE
	Return 0
END IF



RETURN 1


RETURN 0
end function

public subroutine of_getcurrentobject ();//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-03-05 By: Scofield
//$<Reason> Convenience the coder to open object

String				ls_Temp,ls_DaObj,ls_LibPath,ls_LibList,ls_LibFile,ls_DataInfo
String				ls_WinName,ls_MenuName,ls_UserObjInfo,ls_AppPath
Integer				li_Rtn
long					ll_Pos
Boolean				lb_IsUserObj = false
GraphicObject 		lgo_Obj,lgo_Temp,lgo_UserObj
ClassDefinition	lcd_Temp,lcd_ClassDef
DataWindow			ldw_Obj
Window 				lw_Win

String ls_PBTKey = "HKEY_CURRENT_USER\Software\Sybase\PowerBuilder\9.0\Target\"

lgo_Obj = GetFocus()
if IsNull(lgo_Obj) then Return

ls_AppPath = Trim(Gs_Current_Directory)
if RightA(ls_AppPath,1) <> "\" then ls_AppPath += "\"

ll_Pos = PosA(ls_AppPath,"\")
do while ll_Pos > 0
	ls_AppPath = ReplaceA(ls_AppPath,ll_Pos,1,"$")
	ll_Pos = PosA(ls_AppPath,"\")
loop

ls_AppPath += "app_filler.pbt"

////////////////////////////Find Parent Object/////////////////////////////////////
lgo_Temp = lgo_Obj

do while Not IsNull(lgo_Temp) and TypeOf(lgo_Temp) <> Window!
	if TypeOf(lgo_Temp) = userobject! and Not lb_IsUserObj then
		lb_IsUserObj = true
		lgo_UserObj = lgo_Temp
	end if
	
	if TypeOf(lgo_Temp) = datawindow! then
		ldw_Obj = lgo_Temp
		ls_DaObj = ldw_Obj.DataObject
		
		if Trim(ls_Temp) = "" then
			ls_Temp = lgo_Temp.ClassName() + "(" + ls_DaObj + ")"
		else
			ls_Temp = lgo_Temp.ClassName() + "(" + ls_DaObj + ")" + "." + ls_Temp
		end if
		
		ls_LibList = GetLibraryList() + ","
		ll_Pos = PosA(ls_LibList,",")
		do while ll_Pos > 0
			ls_LibFile = LeftA(ls_LibList,ll_Pos - 1)
			ls_LibList = MidA(ls_LibList,ll_Pos + 1)
			ll_Pos = PosA(ls_LibList,",")
			
			ls_DataInfo = "~n" + LibraryDirectory(ls_LibFile, DirDataWindow!)
			
			if PosA(ls_DataInfo,"~n" + ls_DaObj + "~t") > 0 then
				if PosA(ls_LibPath,ls_LibFile) <= 0 then
					ls_LibPath += ls_LibFile + ";"
				end if
				Exit
			end if
		loop
	else
		if Trim(ls_Temp) = "" then
			ls_Temp = lgo_Temp.ClassName()
		else
			ls_Temp = lgo_Temp.ClassName() + "." + ls_Temp
		end if
	end if
	
	lgo_Temp = lgo_Temp.GetParent()
loop

if IsNull(lgo_Temp) then
	MessageBox('Information',ls_Temp)
	Return
end if

if TypeOf(lgo_Temp) = Window! then
	lw_Win = lgo_Temp
	ls_WinName = lw_Win.ClassName()
	lcd_ClassDef = FindClassDefinition(ls_WinName)
	
	if PosA(ls_LibPath,lcd_ClassDef.LibraryName) <= 0 then
		ls_LibPath += lcd_ClassDef.LibraryName + ";"
	end if
	
	if IsNull(lw_Win.MenuName) or Trim(lw_Win.MenuName) = "" then
		ls_MenuName = "MdiMenu: " + w_mdi.MenuName
	else
		ls_MenuName = "WinMenu: " + lw_Win.MenuName
	end if
	
	ls_Temp = ls_MenuName + "~n~n" + ls_WinName + "." + ls_Temp
end if

/////////////////////////////UserObject trace to//////////////////////////////////////

if lb_IsUserObj and Not IsNull(lgo_UserObj) then
	ls_UserObjInfo += "~n~n"
	lgo_Temp = lgo_UserObj
	
	ls_UserObjInfo += lgo_Temp.ClassName()
	
	lcd_Temp = lgo_Temp.ClassDefinition
	lcd_Temp = lcd_Temp.Ancestor
	
	do while Not IsNull(lcd_Temp) and lower(lcd_Temp.Name) <> 'userobject'
		ls_UserObjInfo += "---->" + lcd_Temp.Name
		
		if PosA(ls_LibPath,lcd_Temp.LibraryName) <= 0 then
			ls_LibPath += lcd_Temp.LibraryName + ";"
		end if
		
		lcd_Temp = lcd_Temp.Ancestor
	loop
	
	if PosA(ls_UserObjInfo,"---->") > 0 then ls_Temp += ls_UserObjInfo
end if
////////////////////////////////////////////////////////////////////////////

RegistrySet(ls_PBTKey + ls_AppPath,"DefLibList",RegString!,ls_LibPath)

MessageBox("Object Information",ls_Temp)

//---------------------------- APPEON END ----------------------------

end subroutine

public function integer of_qa_peer_screen_security (w_qa_peer_profile_screen aw_prac_folder);// //Start Code Change ----02.29.2008 #V8 maha - Function added for security
Integer i
Integer li_cnt

aw_prac_folder.tab_qa.tabpage_quality_profile.Visible = True
aw_prac_folder.tab_qa.tabpage_site_survey.Visible = True
aw_prac_folder.tab_qa.tabpage_case_review.Visible = True

li_cnt = UpperBound( ii_security_action_id )
//Start Code Change ----12.01.2009 #V92 maha - added module security
FOR i = 1 To li_cnt
	//QA
	IF of_get_app_setting("set_qa","I") = 1 THEN
		IF ii_security_action_id[ i ] = 2020 THEN
			IF ii_security_action_value[ i ] = 0 THEN
				aw_prac_folder.tab_qa.tabpage_quality_profile.Visible = False
			ELSEIF ii_security_action_value[ i ] = 1 THEN
//				aw_prac_folder.tab_qa.tabpage_quality_profile.uo_qa.tab_measurments.tabpage_detail.dw_measuremt_header.Enabled = False
//				aw_prac_folder.tab_qa.tabpage_quality_profile.uo_qa.tab_measurments.tabpage_detail.dw_measuremt_detail.Enabled = False
			END IF
		END IF
		//QA AI
		IF ii_security_action_id[ i ] = 2030 THEN
			IF ii_security_action_value[ i ] = 0 THEN
				aw_prac_folder.tab_qa.tabpage_quality_profile.uo_qa.tab_measurments.tabpage_action_items.Visible = False
			ELSEIF ii_security_action_value[ i ] = 1 THEN
				aw_prac_folder.tab_qa.tabpage_quality_profile.uo_qa.tab_measurments.tabpage_action_items.dw_actions.Enabled = False
			END IF
		END IF
	ELSE
		aw_prac_folder.tab_qa.tabpage_quality_profile.Visible = False
	END IF

//	PEER
	IF of_get_app_setting("set_peer","I") = 1 THEN
		//IF ii_security_action_id[ i ] = 2040 then
		IF  ii_security_action_id[ i ] = 7031  THEN//Added by  Nova 12.04.2009 --v10.1 Profiles Build out
			IF ii_security_action_value[ i ] = 0 THEN
				aw_prac_folder.tab_qa.tabpage_case_review.Visible = False
			ELSEIF ii_security_action_value[ i ] = 1 THEN
//				aw_prac_folder.tab_qa.tabpage_case_review.uo_1.tab_1.tabpage_detail.tab_2.tabpage_case_detail.dw_detail.Enabled = False
//				aw_prac_folder.tab_qa.tabpage_case_review.uo_1.tab_1.tabpage_detail.tab_2.tabpage_case_detail.dw_physicians.Enabled = False
			END IF
		END IF
		//PEER AI
		//IF ii_security_action_id[ i ] = 2060 then
		IF  ii_security_action_id[ i ] = 7081 THEN//Added by  Nova 12.04.2009 --v10.1 Profiles Build out
			IF ii_security_action_value[ i ] = 0 THEN
//				aw_prac_folder.tab_qa.tabpage_case_review.uo_1.tab_1.tabpage_detail.tab_2.tabpage_ai.Visible = False
			ELSEIF ii_security_action_value[ i ] = 1 THEN
//				aw_prac_folder.tab_qa.tabpage_case_review.uo_qa.tab_1.tabpage_detail.tab_2.tabpage_ai.dw_action_item.Enabled = False
//				aw_prac_folder.tab_qa.tabpage_case_review.uo_1.tab_1.tabpage_detail.tab_2.tabpage_ai.dw_ai_report.Enabled = False
			END IF
		END IF
	ELSE
		aw_prac_folder.tab_qa.tabpage_case_review.Visible = False
	END IF

//SITE
IF of_get_app_setting("set_site","I") = 1 THEN
	
	//IF ii_security_action_id[ i ] = 1430
	IF  ii_security_action_id[ i ] = 7071 THEN //Added by  Nova 12.04.2009 --v10.1 Profiles Build out
		//Start Code Change ----12.01.2009 #V92 maha - added the approprate security
		IF ii_security_action_value[ i ] = 0 THEN
			aw_prac_folder.tab_qa.tabpage_site_survey.Visible = False
		ELSEIF ii_security_action_value[ i ] = 1 THEN
//			aw_prac_folder.tab_qa.tabpage_site_survey.uo_1.tab_review.tabpage_browse.dw_addresses.Enabled = False
//			aw_prac_folder.tab_qa.tabpage_site_survey.uo_1.tab_review.tabpage_browse.dw_browse.Enabled = False
//			aw_prac_folder.tab_qa.tabpage_site_survey.uo_1.tab_review.tabpage_setup.dw_setup.Enabled = False
//			aw_prac_folder.tab_qa.tabpage_site_survey.uo_1.tab_review.tabpage_questions.dw_questions.Enabled = False
		END IF
	END IF
ELSE
	aw_prac_folder.tab_qa.tabpage_site_survey.Visible = False
END IF
//End Code Change---12.01.2009

//OPPE
//IF ii_security_action_id[ i ] = 6971
IF  ii_security_action_id[ i ] = 7041 THEN //Added by  Nova 12.04.2009 --v10.1 Profiles Build out
	IF ii_security_action_value[ i ] = 0 THEN
		aw_prac_folder.tab_qa.tabpage_oppe.Visible = False
	END IF
END IF
//PRIVS
IF ii_security_action_id[ i ] =7051 THEN
	IF ii_security_action_value[ i ] = 0 THEN
		aw_prac_folder.tab_qa.tabpage_priv.visible = false
	END IF
END IF	
//profile
IF ii_security_action_id[ i ] = 7061 THEN
	IF ii_security_action_value[ i ] = 0 THEN
		aw_prac_folder.tab_qa.tabpage_profile.Visible = False
	END IF
END IF
NEXT

RETURN 1



end function

public function integer of_menu_security_data_entry ();//////////////////////////////////////////////////////////////////////
// $<function> of_menu_security_data_entry
// $<arguments>
// $<returns> integer
// $<description> Set security for m_pfe_cst_data_entry menu (Menu readonly security)
//////////////////////////////////////////////////////////////////////
// $<add> Evan 06.17.2009
//////////////////////////////////////////////////////////////////////

long ncnt
long ll_pracid
integer set_ck
integer li_Index
integer li_screen_id
w_prac_data_1 lw_prac  //maha 12.04.2012

//Start Code Change ----12.04.2012 #V12 maha - rewrote to variable
//Start Code Change ----03.18.2012 #V12 maha - global variable
//if IsValid(w_prac_data_intelliapp) then 
//	lw_prac = w_prac_data_intelliapp
//elseif IsValid(w_prac_data_sk) then
//	lw_prac = w_prac_data_sk
//elseif 	 IsValid(w_prac_data_1) then
//	lw_prac = w_prac_data_1
//elseif 	 IsValid(w_prac_data_2) then
//	lw_prac = w_prac_data_2
//else
//	return -1
//end if
lw_prac = gw_prac_data
//End Code Change ----03.18.2012

ll_pracid = lw_prac.il_prac_id
li_Index = lw_prac.tab_1.selectedtab
li_screen_id = lw_prac.tab_1.tabpage_detail.uo_data_entry.ii_screen_id	

////m_pfe_cst_data_entry.m_edit.m_clearchanges.visible = true  //Start Code Change ----10.31.2012 #V12 maha - added for appointment screen
//// maha 090204 trap for return from committee window in action items that changes the menu
////if isvalid(w_prac_data_intelliapp) or isvalid(w_prac_data_1) then
//	IF gs_cust_type = "I" THEN //maha added 032404
//		//------Begin Modified by alfee 09.29.2010 -------------
//		//SK Practitioner Folder
//		if IsValid(w_prac_data_intelliapp) then
//			ll_pracid = w_prac_data_intelliapp.il_prac_id
//			li_Index = w_prac_data_intelliapp.tab_1.selectedtab
//			li_screen_id = w_prac_data_intelliapp.tab_1.tabpage_detail.uo_data_entry.ii_screen_id		
//		elseif IsValid(w_prac_data_sk) then
//			ll_pracid = w_prac_data_sk.il_prac_id
//			li_Index = w_prac_data_sk.tab_1.selectedtab
//			li_screen_id = w_prac_data_sk.tab_1.tabpage_detail.uo_data_entry.ii_screen_id	
//		else
//			Return -1
//		end if
//		//if not IsValid(w_prac_data_intelliapp) then Return -1
//		//ll_pracid = w_prac_data_intelliapp.il_prac_id
//		//li_Index = w_prac_data_intelliapp.tab_1.selectedtab
//		//li_screen_id = w_prac_data_intelliapp.tab_1.tabpage_detail.uo_data_entry.ii_screen_id
//		//------End Modified ---------------------------------------		
//	ELSE
//		if not IsValid(w_prac_data_1) then Return -1
//		ll_pracid = w_prac_data_1.il_prac_id
//		li_Index = w_prac_data_1.tab_1.selectedtab
//		li_screen_id = w_prac_data_1.tab_1.tabpage_detail.uo_data_entry.ii_screen_id
//	END IF
////end if
//End Code Change ----12.04.2012

//notes icon
If isvalid(w_prac_data_1) Then
	ncnt = w_prac_data_1.il_pd_notes_cnt
Elseif isvalid(w_prac_data_intelliapp) Then
	ncnt = w_prac_data_intelliapp.il_pd_notes_cnt
Elseif isvalid(w_prac_data_sk) Then //SK Practitioner Folder - alfee 09.29.2010
	ncnt = w_prac_data_sk.il_pd_notes_cnt
Else
	select count(record_id) into :ncnt from pd_notes where prac_id = :ll_pracid;	
End If
if ncnt > 0 then 
	m_pfe_cst_data_entry.m_view.m_notes.toolbaritemname = "ScriptYes!"
else
	m_pfe_cst_data_entry.m_view.m_notes.toolbaritemname = "ScriptNO!"
end if

////Start Code Change ----01.30.2013 #V12 maha
//if ncnt > 0 then 
//	string scnt
//	if ncnt > 9 then 
//		scnt = "9+"
//	else
//		scnt = string(ncnt)
//	end if
//	lw_prac.cb_notes.text =  scnt + " Notes"
//	lw_prac.cb_notes.textcolor = 16711680	
//else
//	lw_prac.cb_notes.text = "0 Notes"
//	lw_prac.cb_notes.textcolor = 0
//end if
//End Code Change ----01.30.2013

//maha 022304
ncnt = of_get_app_setting("set_35","I")
if ncnt > 0 and of_security_access( 7830 ) > 0 THEN  //Start Code Change ----08.23.2016 #V153 maha - change from  if ncnt = 1 then  09.29.2016 - added role security
	m_pfe_cst_data_entry.m_edit.m_practitionerinvoices.Visible = True
else
	m_pfe_cst_data_entry.m_edit.m_practitionerinvoices.Visible = False
end if


IF of_get_app_setting( "set_38","I" ) = 1 THEN  //for this 1 is off
	m_pfe_cst_data_entry.m_file.m_facilitydata.Visible = False
	m_pfe_cst_data_entry.m_file.m_facilitydata.ToolBarItemVisible = False
ELSE
	IF Upper( gs_cust_type ) <> 'I' THEN  	//Start Code Change ----03.25.2008 #V8 maha
		m_pfe_cst_data_entry.m_file.m_facilitydata.Visible = true
		m_pfe_cst_data_entry.m_file.m_facilitydata.ToolBarItemVisible = True
	else
		m_pfe_cst_data_entry.m_file.m_facilitydata.Visible = False
		m_pfe_cst_data_entry.m_file.m_facilitydata.ToolBarItemVisible = False	
	end if
END IF
		
//Start Code Change ----03.25.2008 #V8 maha
IF Upper( gs_cust_type ) = 'I' THEN  //maha 
	IF of_security_access( 1590 ) = 0 THEN //same access as batch add apps
		m_pfe_cst_data_entry.m_edit.m_batchaddfacilities.visible = False
		m_pfe_cst_data_entry.m_edit.m_batchaddfacilities.ToolBarItemVisible = False
	end if
else
	m_pfe_cst_data_entry.m_edit.m_batchaddfacilities.visible = False
	m_pfe_cst_data_entry.m_edit.m_batchaddfacilities.ToolBarItemVisible = False		
END IF
//End Code Change---03.25.2008

if of_security_access(80) = 0 then
	m_pfe_cst_data_entry.m_file.m_dataentrycomplete.Visible = false
	m_pfe_cst_data_entry.m_file.m_dataentrycomplete.ToolBarItemVisible = false
else
	m_pfe_cst_data_entry.m_file.m_dataentrycomplete.Visible = true
	m_pfe_cst_data_entry.m_file.m_dataentrycomplete.ToolBarItemVisible = true
end if

 //Start Code Change ----03.12.2015 #V15 maha
if of_security_access(7773) = 0 then
	m_pfe_cst_data_entry.m_edit.m_addverificationentry.Visible = false
end if

if of_security_access(7771) = 0 then
	m_pfe_cst_data_entry.m_edit.m_delete1.Visible = false
end if
//End Code Change ----03.12.2015

//Start Code Change ----03.16.2016 #V15 maha
if of_security_access(7818) = 0 then
	m_pfe_cst_data_entry.m_view.m_relationshipreport.Visible = false
end if
//End Code Change ----03.16.2016

//----------------APPEON BEGIN-------------------------
	//$<add> long.zhang 06.27.2011
	//$<reason> for red flag Data menu security
	if of_security_access(7160) = 0  then
		m_pfe_cst_data_entry.m_system.m_addredflagdata.Visible = False
	else
		m_pfe_cst_data_entry.m_system.m_addredflagdata.Visible = True
	end if
	//---------------APPEON END

//Start Code Change ----01.12.2012 #V12 maha -
//Start Code Change ----07.23.2014 #V14.2 maha - added - was previously commented out
if of_security_access(7320) = 0  then
	m_pfe_cst_data_entry.m_system.m_webviewfunctions.m_createwebviewuser.Visible = False
else
	m_pfe_cst_data_entry.m_system.m_webviewfunctions.m_createwebviewuser.Visible = True
end if
//End Code Change ----01.12.2012

//Start Code Change ----10.30.2012 #V12 maha - childrens hosp customization
if gb_use_prac_toolbar = true then
		//Start Code Change ----02.16.2012 #V12 maha - show tool bar items 
//	m_pfe_cst_data_entry.m_view.m_aptnote.toolbaritembarindex = 2
//	m_pfe_cst_data_entry.m_file.m_multiapp.toolbaritembarindex = 2
//	m_pfe_cst_data_entry.m_view.m_nextpage.toolbaritembarindex = 2
//	m_pfe_cst_data_entry.m_view.m_priorpage.toolbaritembarindex = 2
//	m_pfe_cst_data_entry.m_edit.m_addverificationentry.toolbaritembarindex = 2
//	m_pfe_cst_data_entry.m_file.m_cvodata.toolbaritembarindex = 2
//	m_pfe_cst_data_entry.m_file.m_save.toolbaritembarindex = 2
//	m_pfe_cst_data_entry.m_edit.m_insert.toolbaritembarindex = 2
//	m_pfe_cst_data_entry.m_edit.m_delete1.toolbaritembarindex = 2
//	m_pfe_cst_data_entry.m_file.m_importphoto.toolbaritembarindex = 2
//	m_pfe_cst_data_entry.m_view.m_notes.toolbaritembarindex = 2	
	
	m_pfe_cst_data_entry.m_view.m_aptnote.ToolBarItemVisible = true
	m_pfe_cst_data_entry.m_file.m_multiapp.ToolBarItemVisible = true
	m_pfe_cst_data_entry.m_view.m_nextpage.ToolBarItemVisible = true
	m_pfe_cst_data_entry.m_view.m_priorpage.ToolBarItemVisible = true
	m_pfe_cst_data_entry.m_edit.m_addverificationentry.ToolBarItemVisible = true
	m_pfe_cst_data_entry.m_file.m_cvodata.ToolBarItemVisible = true
	m_pfe_cst_data_entry.m_file.m_save.ToolBarItemVisible = true
	m_pfe_cst_data_entry.m_edit.m_insert.ToolBarItemVisible = true
	m_pfe_cst_data_entry.m_edit.m_delete1.ToolBarItemVisible = true
	m_pfe_cst_data_entry.m_file.m_importphoto.ToolBarItemVisible = true
	m_pfe_cst_data_entry.m_view.m_notes.ToolBarItemVisible = true
	m_pfe_cst_data_entry.m_file.m_dataentrycomplete.ToolBarItemVisible = true


else
	//Start Code Change ----02.16.2012 #V12 maha - hide tool bar items 
	m_pfe_cst_data_entry.m_view.m_aptnote.ToolBarItemVisible = false
	m_pfe_cst_data_entry.m_file.m_multiapp.ToolBarItemVisible = false
	m_pfe_cst_data_entry.m_view.m_nextpage.ToolBarItemVisible = false
	m_pfe_cst_data_entry.m_view.m_priorpage.ToolBarItemVisible = false
	m_pfe_cst_data_entry.m_edit.m_addverificationentry.ToolBarItemVisible = false
	m_pfe_cst_data_entry.m_file.m_cvodata.ToolBarItemVisible = false
	m_pfe_cst_data_entry.m_file.m_save.ToolBarItemVisible = false
	m_pfe_cst_data_entry.m_edit.m_insert.ToolBarItemVisible = false
	m_pfe_cst_data_entry.m_edit.m_delete1.ToolBarItemVisible = false
	m_pfe_cst_data_entry.m_file.m_importphoto.ToolBarItemVisible = false
	m_pfe_cst_data_entry.m_view.m_notes.ToolBarItemVisible = false
	m_pfe_cst_data_entry.m_file.m_facilitydata.ToolBarItemVisible = false
	m_pfe_cst_data_entry.m_file.m_dataentrycomplete.ToolBarItemVisible = false
	
end if

 //Start Code Change ----05.31.2017 #V154 maha
if of_security_access(7852) = 0 then
	m_pfe_cst_data_entry.m_view.m_facilitynotes.visible = false
else
	m_pfe_cst_data_entry.m_view.m_facilitynotes.visible = true
end if
 //End Code Change ----05.31.2017
 
// Set menu security
choose case li_Index
	case 2 //Credentials
		m_pfe_cst_data_entry.m_view.m_aptnote.Visible = false
		m_pfe_cst_data_entry.m_view.m_aptnote.ToolBarItemVisible = false
		m_pfe_cst_data_entry.m_file.m_multiapp.Visible = false
		m_pfe_cst_data_entry.m_file.m_multiapp.ToolBarItemVisible = false
		m_pfe_cst_data_entry.m_file.m_importphoto.Visible = true
		//m_pfe_cst_data_entry.m_file.m_importphoto.ToolBarItemVisible = true  /Start Code Change ----11.04.2011 #V12 maha  - removed
		m_pfe_cst_data_entry.m_file.m_clearphoto.Enabled = true  //Start Code Change ----07.22.2009 #V92 maha
		m_pfe_cst_data_entry.m_view.m_nextpage.Visible = true
		//m_pfe_cst_data_entry.m_view.m_nextpage.ToolBarItemVisible = true
		m_pfe_cst_data_entry.m_view.m_priorpage.Visible = true
		//m_pfe_cst_data_entry.m_view.m_priorpage.ToolBarItemVisible = true
		m_pfe_cst_data_entry.m_edit.m_addverificationentry.Visible = true
		//m_pfe_cst_data_entry.m_edit.m_addverificationentry.ToolBarItemVisible = true
		m_pfe_cst_data_entry.m_file.m_cvodata.Visible = false  //Start Code Change ----02.01.2010 #V10 maha
		m_pfe_cst_data_entry.m_file.m_cvodata.ToolBarItemVisible = false  //Start Code Change ----02.01.2010 #V10 maha
		m_pfe_cst_data_entry.m_edit.m_clearchanges.visible = true
		//m_pfe_cst_master_menu.m_edit.m_clearchanges.visible = true

		// Readonly security settings
		if of_security_access(40) < 2 or of_security_access(50) < 2 then
			m_pfe_cst_data_entry.m_file.m_save.enabled = false
			m_pfe_cst_data_entry.m_edit.m_insert.enabled = false
			m_pfe_cst_data_entry.m_edit.m_delete1.enabled = false
			m_pfe_cst_data_entry.m_file.m_importphoto.enabled = false
			m_pfe_cst_data_entry.m_file.m_clearphoto.Enabled = false  //Start Code Change ----07.22.2009 #V92 maha
			m_pfe_cst_data_entry.m_file.m_dataentrycomplete.enabled = false
			m_pfe_cst_data_entry.m_edit.m_addverificationentry.enabled = false
			m_pfe_cst_data_entry.m_file.m_facilitydata.enabled = false
			m_pfe_cst_data_entry.m_edit.m_practitionerinvoices.enabled = false
			m_pfe_cst_data_entry.m_edit.m_batchaddfacilities.enabled = false
			m_pfe_cst_data_entry.m_file.m_pracsignature.enabled = false	//E-Sign: - added by long.zhang 06.13.2011
			m_pfe_cst_data_entry.m_system.m_checkdatalinks.Visible = False  //Start Code Change ----10.11.2012 #V12 maha
			//Start Code Change ----11.04.2011 #V12 maha - added button code
			if isvalid(iw_prac_window) then //add judgement by stephen 05.22.2012 -Null object reference at line 14 in function of_refresh_page_menu of object pfc_cst_u_data_entry
				iw_prac_window.cb_add.enabled = false
				iw_prac_window.cb_save.enabled = false
				iw_prac_window.cb_delete.enabled = false
				iw_prac_window.cb_print.enabled = false
				iw_prac_window.cb_b3.enabled = false
				iw_prac_window.cb_b4.enabled = false
			end if

		else
			m_pfe_cst_data_entry.m_file.m_save.enabled = true
			//---------Begin modified by Alfee 01.20.2010 -------------
			IF li_screen_id = 1 or li_screen_id = 27 THEN  
				m_pfe_cst_data_entry.m_edit.m_delete1.enabled = False
				m_pfe_cst_data_entry.m_edit.m_insert.enabled = False
			ELSE	
//				m_pfe_cst_data_entry.m_edit.m_delete1.enabled = True  //Start Code Change ----06.27.2012 #V12 maha - removed because causing issues with basic info screen
//				m_pfe_cst_data_entry.m_edit.m_insert.enabled = True
			END IF			
			/* if li_screen_id <> 1 then
				m_pfe_cst_data_entry.m_edit.m_insert.enabled = true
				m_pfe_cst_data_entry.m_edit.m_delete1.enabled = true
			end if */
			//---------End Modified -------------------------------------
			m_pfe_cst_data_entry.m_file.m_importphoto.enabled = true
			m_pfe_cst_data_entry.m_file.m_clearphoto.Enabled = true  //Start Code Change ----07.22.2009 #V92 maha
			m_pfe_cst_data_entry.m_file.m_dataentrycomplete.enabled = true
			m_pfe_cst_data_entry.m_edit.m_addverificationentry.enabled = true
			m_pfe_cst_data_entry.m_file.m_facilitydata.enabled = true
			m_pfe_cst_data_entry.m_edit.m_practitionerinvoices.enabled = true
			m_pfe_cst_data_entry.m_edit.m_batchaddfacilities.enabled = true
			m_pfe_cst_data_entry.m_file.m_pracsignature.enabled = true	//E-Sign: - added by long.zhang 06.13.2011
			m_pfe_cst_data_entry.m_system.m_checkdatalinks.Visible = True   //Start Code Change ----12.22.2015 #V15 maha
			
			if isvalid(iw_prac_window) then //add judgement by stephen 05.22.2012 -Null object reference at line 14 in function of_refresh_page_menu of object pfc_cst_u_data_entry
//				iw_prac_window.cb_add.enabled = true //Start Code Change ----06.28.2012 #V12 maha - removed for basic info screen issue
				iw_prac_window.cb_save.enabled = true
//				iw_prac_window.cb_delete.enabled = true  //Start Code Change ----06.28.2012 #V12 maha - removed for basic info screen issue
				iw_prac_window.cb_print.enabled = true
				iw_prac_window.cb_b3.enabled = true
				iw_prac_window.cb_b4.enabled = true
			end if
			//End Code Change ----11.04.2011 
		end if
		
		 //Start Code Change ----03.12.2015 #V15 maha
		if of_security_access(7773) = 0 then
			m_pfe_cst_data_entry.m_edit.m_addverificationentry.Visible = false
		end if
		
		if of_security_access(7771) = 0 then
			m_pfe_cst_data_entry.m_edit.m_delete1.Visible = false
		end if

		IF of_security_access( 7772 ) = 0 THEN 
			m_pfe_cst_data_entry.m_file.m_facilitydata.Visible = False
			m_pfe_cst_data_entry.m_file.m_facilitydata.ToolBarItemVisible = False	
		end if
		//End Code Change ----03.12.2015	

	
	case 4 //Appmt.Status
		m_pfe_cst_data_entry.m_file.m_importphoto.Visible = false
		//m_pfe_cst_data_entry.m_file.m_importphoto.ToolBarItemVisible = false
		m_pfe_cst_data_entry.m_file.m_clearphoto.Enabled = true  //Start Code Change ----07.22.2009 #V92 maha
		m_pfe_cst_data_entry.m_view.m_nextpage.Visible = false
		m_pfe_cst_data_entry.m_view.m_nextpage.ToolBarItemVisible = false
		m_pfe_cst_data_entry.m_view.m_priorpage.Visible = false
		m_pfe_cst_data_entry.m_view.m_priorpage.ToolBarItemVisible = false
		m_pfe_cst_data_entry.m_edit.m_addverificationentry.Visible = false
		m_pfe_cst_data_entry.m_edit.m_addverificationentry.ToolBarItemVisible = false
		m_pfe_cst_data_entry.m_file.m_multiapp.Visible = true
		m_pfe_cst_data_entry.m_file.m_cvodata.Visible = true  //Start Code Change ----02.01.2010 #V10 maha
		if gb_use_prac_toolbar = true then  //Start Code Change ----10.30.2012 #V12 maha - childrens hosp customization
			m_pfe_cst_data_entry.m_file.m_multiapp.ToolBarItemVisible = true
			m_pfe_cst_data_entry.m_file.m_cvodata.ToolBarItemVisible = true  
		end if
		if IsValid(m_pfe_cst_data_entry) then
			//Start Code Change ----12.03.2013 #V14 maha
			m_pfe_cst_data_entry.m_view.m_aptnote.visible = false
//			set_ck = of_get_app_setting("set_14","I")
//			if set_ck = 1 then //appointment note tool
//				m_pfe_cst_data_entry.m_view.m_aptnote.visible = true
//				if gb_use_prac_toolbar = true then  //Start Code Change ----10.30.2012 #V12 maha - childrens hosp customization
//					m_pfe_cst_data_entry.m_view.m_aptnote.toolbaritemvisible = true
//				end if
//			else
//				m_pfe_cst_data_entry.m_view.m_aptnote.visible = false
//				if gb_use_prac_toolbar = true then  //Start Code Change ----10.30.2012 #V12 maha - childrens hosp customization
//					m_pfe_cst_data_entry.m_view.m_aptnote.toolbaritemvisible = false
//				end if
//			end if
			//End Code Change ----12.03.2013
		end if
		
		//Start Code Change ----02.02.2010 #V10 maha - security for CVO data 
		if of_security_access(7130) = 0 then
			m_pfe_cst_data_entry.m_file.m_cvodata.Visible = false  
			if gb_use_prac_toolbar = true then  //Start Code Change ----10.30.2012 #V12 maha - childrens hosp customization
				m_pfe_cst_data_entry.m_file.m_cvodata.ToolBarItemVisible = false 
			end if
			if isvalid(iw_prac_window) then //add judgement by stephen 05.22.2012 -Null object reference at line 14 in function of_refresh_page_menu of object pfc_cst_u_data_entry
				iw_prac_window.cb_b4.visible = false
				//messagebox("","menu security")
			end if
		else
			m_pfe_cst_data_entry.m_file.m_cvodata.Visible = true 
			if gb_use_prac_toolbar = true then  //Start Code Change ----10.30.2012 #V12 maha - childrens hosp customization
				m_pfe_cst_data_entry.m_file.m_cvodata.ToolBarItemVisible = true
			end if
			if isvalid(iw_prac_window) then //add judgement by stephen 05.22.2012 -Null object reference at line 14 in function of_refresh_page_menu of object pfc_cst_u_data_entry
				iw_prac_window.cb_b4.visible = true
			end if
		end if
		//End Code Change---02.02.2010
		
		m_pfe_cst_data_entry.m_system.m_checkdatalinks.Visible = False  //Start Code Change ----10.11.2012 #V12 maha
		
		// Readonly security settings
		if of_security_access(40) < 2 or of_security_access(120) < 2 then
			m_pfe_cst_data_entry.m_file.m_save.enabled = false
			m_pfe_cst_data_entry.m_edit.m_insert.enabled = false
			m_pfe_cst_data_entry.m_edit.m_delete1.enabled = false
			//m_pfe_cst_data_entry.m_view.m_aptnote.enabled = false
			m_pfe_cst_data_entry.m_file.m_dataentrycomplete.enabled = false
			m_pfe_cst_data_entry.m_file.m_multiapp.enabled = false
			m_pfe_cst_data_entry.m_file.m_facilitydata.enabled = false
			m_pfe_cst_data_entry.m_edit.m_practitionerinvoices.enabled = false
			m_pfe_cst_data_entry.m_edit.m_batchaddfacilities.enabled = false
			m_pfe_cst_data_entry.m_file.m_pracsignature.enabled = false	//E-Sign: - added by long.zhang 08.05.2011
			//Start Code Change ----11.04.2011 #V12 maha - added button code
			if isvalid(iw_prac_window) then //add judgement by stephen 05.22.2012 -Null object reference at line 14 in function of_refresh_page_menu of object pfc_cst_u_data_entry
				iw_prac_window.cb_add.enabled = false
				iw_prac_window.cb_save.enabled = false
				iw_prac_window.cb_delete.enabled = false
				iw_prac_window.cb_print.enabled = false
				iw_prac_window.cb_b3.enabled = false
				iw_prac_window.cb_b4.enabled = false
				iw_prac_window.cb_b5.enabled = false
			end if
		else
			m_pfe_cst_data_entry.m_file.m_save.enabled = true
			m_pfe_cst_data_entry.m_edit.m_insert.enabled = true
			if of_security_access(7774) = 0 then   //Start Code Change ----03.12.2015 #V15 maha
				m_pfe_cst_data_entry.m_edit.m_delete1.Visible = false
			else
				m_pfe_cst_data_entry.m_edit.m_delete1.enabled = true
			end if
			//m_pfe_cst_data_entry.m_view.m_aptnote.enabled = true
			m_pfe_cst_data_entry.m_file.m_dataentrycomplete.enabled = true
			m_pfe_cst_data_entry.m_file.m_multiapp.enabled = true
			m_pfe_cst_data_entry.m_file.m_facilitydata.enabled = true
			m_pfe_cst_data_entry.m_edit.m_practitionerinvoices.enabled = true
			m_pfe_cst_data_entry.m_edit.m_batchaddfacilities.enabled = true
			m_pfe_cst_data_entry.m_file.m_pracsignature.enabled = true	//E-Sign: - added by long.zhang 08.05.2011
			if isvalid(iw_prac_window) then //add judgement by stephen 05.22.2012 -Null object reference at line 14 in function of_refresh_page_menu of object pfc_cst_u_data_entry
				iw_prac_window.cb_add.enabled = true
				iw_prac_window.cb_save.enabled = true
				iw_prac_window.cb_delete.enabled = true
				iw_prac_window.cb_print.enabled = true
				iw_prac_window.cb_b3.enabled = true
				iw_prac_window.cb_b4.enabled = true
				iw_prac_window.cb_b5.enabled = true
			end if
			//End Code Change ----11.04.2011
		end if
end choose
//End Code Change ----02.16.2012

////Start Code Change ----03.03.2011 #V11 maha - hide on this tab for space purposes     //Start Code Change ----11.04.2011 #V12 maha -  removed
//m_pfe_cst_master_menu.m_system.m_painters.m_applicationmapping.toolbaritemVisible = False
//m_pfe_cst_master_menu.m_file.m_grouppractices.ToolbarItemVisible = False
////Start Code Change ----03.03.2011

Return 1
end function

public function integer of_menu_security_app_audit ();//////////////////////////////////////////////////////////////////////
// $<function> of_menu_security_app_audit
// $<arguments>
// $<returns> integer
// $<description> Set security for m_pfe_cst_app_audit menu (Menu readonly security)
//////////////////////////////////////////////////////////////////////
// $<add> Evan 06.17.2009
//////////////////////////////////////////////////////////////////////

//print missing info letter
IF of_security_access( 100 ) = 0 THEN
	m_pfe_cst_app_audit.m_action.m_faxmissinginforequest.Visible = False
//	m_pfe_cst_app_audit.m_action.m_faxmissinginforequest.toolbaritemvisible = False //Add by Evan 01/14/2008 - 
ELSE
	m_pfe_cst_app_audit.m_action.m_faxmissinginforequest.Visible = True
//	m_pfe_cst_app_audit.m_action.m_faxmissinginforequest.toolbaritemvisible = True //Add by Evan 01/16/2008 //Start Code Change ----01.31.2012 #V12 maha
END IF

//Start Code Change ----10.24.2012 #V12 maha - childrens hosp customization
if gb_use_prac_toolbar = true then
	m_pfe_cst_app_audit.m_action.m_faxmissinginforequest.toolbaritemvisible = true
	m_pfe_cst_app_audit.m_action.m_copyrequireddata.toolbaritemvisible = true
	m_pfe_cst_app_audit.m_action.m_addmissingitems.toolbaritemvisible = true
	m_pfe_cst_app_audit.m_edit.m_insert.toolbaritemvisible = true
	m_pfe_cst_app_audit.m_edit.m_delete1.toolbaritemvisible = true
	m_pfe_cst_app_audit.m_file.m_save.toolbaritemvisible = true
	m_pfe_cst_app_audit.m_file.m_print.toolbaritemvisible = true
else
 //End Code Change ----10.24.2012	
	 //Start Code Change ----01.31.2012 #V12 maha - hide these tools
	m_pfe_cst_app_audit.m_action.m_faxmissinginforequest.toolbaritemvisible = false
	m_pfe_cst_app_audit.m_action.m_copyrequireddata.toolbaritemvisible = false
	m_pfe_cst_app_audit.m_action.m_addmissingitems.toolbaritemvisible = false
	m_pfe_cst_app_audit.m_edit.m_insert.toolbaritemvisible = false
	m_pfe_cst_app_audit.m_edit.m_delete1.toolbaritemvisible = false
	m_pfe_cst_app_audit.m_file.m_save.toolbaritemvisible = false
	m_pfe_cst_app_audit.m_file.m_print.toolbaritemvisible = false
end if
 //End Code Change ----01.31.2012


// Readonly security settings
if of_security_access(40) < 2 or of_security_access(90) < 2 then
	
	m_pfe_cst_app_audit.m_edit.m_insert.enabled = false
	m_pfe_cst_app_audit.m_edit.m_delete1.enabled = false
	m_pfe_cst_app_audit.m_file.m_save.enabled = false
	m_pfe_cst_app_audit.m_file.m_print.enabled = false
	m_pfe_cst_app_audit.m_action.m_faxmissinginforequest.enabled = false
	m_pfe_cst_app_audit.m_action.m_copyrequireddata.enabled= false
	m_pfe_cst_app_audit.m_action.m_addmissingitems.enabled = false
	m_pfe_cst_app_audit.m_action.visible = false  //Start Code Change ----10.10.2012 #V12 maha - added
	//Start Code Change ----11.04.2011 #V12 maha - added button code
	if isvalid(iw_prac_window) then //add judgement by stephen 05.22.2012 -Null object reference at line 14 in function of_refresh_page_menu of object pfc_cst_u_data_entry
		iw_prac_window.cb_add.enabled = false
		iw_prac_window.cb_save.enabled = false
		iw_prac_window.cb_delete.enabled = false
		iw_prac_window.cb_print.enabled = false
		iw_prac_window.cb_b3.enabled = false
		iw_prac_window.cb_b4.enabled = false
		iw_prac_window.cb_b5.enabled = false
	end if
else
	m_pfe_cst_app_audit.m_file.m_save.enabled = true
	m_pfe_cst_app_audit.m_file.m_print.enabled = true
	m_pfe_cst_app_audit.m_action.m_faxmissinginforequest.enabled = true
	m_pfe_cst_app_audit.m_action.m_copyrequireddata.enabled= true
	m_pfe_cst_app_audit.m_action.m_addmissingitems.enabled = true
	if isvalid(iw_prac_window) then //add judgement by stephen 05.22.2012 -Null object reference at line 14 in function of_refresh_page_menu of object pfc_cst_u_data_entry
		iw_prac_window.cb_add.enabled = true
		iw_prac_window.cb_save.enabled = true
		iw_prac_window.cb_delete.enabled = true
		iw_prac_window.cb_print.enabled = true
		iw_prac_window.cb_b3.enabled = true
		iw_prac_window.cb_b4.enabled = true
		iw_prac_window.cb_b5.enabled = true
	end if
	//End Code Change ----11.04.2011 
end if

if of_security_access(7785) = 0 then
	m_pfe_cst_app_audit.m_edit.m_delete1.visible = false
end if
	
if of_security_access(7786) = 0 then
	m_pfe_cst_app_audit.m_action.m_addmissingitems.visible = false
	m_pfe_cst_app_audit.m_action.m_copyrequireddata.visible = false
end if
	
 //Start Code Change ----05.31.2017 #V154 maha
if of_security_access(7852) = 0 then
	m_pfe_cst_app_audit.m_view.m_facilitynotesz.visible = false
else
	m_pfe_cst_app_audit.m_view.m_facilitynotesz.visible = true
end if

if gb_sk_ver then //SK Practitioner Folder - alfee 09.10.2010
	m_pfe_cst_app_audit.m_edit.m_insert.visible = false 
	iw_prac_window.cb_add.enabled = false
end if

Return 1
end function

public function integer of_menu_security_verif_info ();//////////////////////////////////////////////////////////////////////
// $<function> of_menu_security_verif_info
// $<arguments>
// $<returns> integer
// $<description> Set security for m_pfe_cst_verif_info menu (Menu readonly security)
//////////////////////////////////////////////////////////////////////
// $<add> Evan 06.19.2009
//////////////////////////////////////////////////////////////////////


// Process Verifications
IF of_security_access( 150 ) = 0 THEN
	m_pfe_cst_verif_info.m_action.m_connecttoweb.Visible = False
	//m_pfe_cst_verif_info.m_action.m_connecttoweb.ToolBarItemVisible = False  //maha 110804
	m_pfe_cst_verif_info.m_action.m_exportdata.Visible = False
//	m_pfe_cst_verif_info.m_action.m_exportdata.ToolBarItemVisible = False
	m_pfe_cst_verif_info.m_action.m_phonedialer.Visible = False
	//m_pfe_cst_verif_info.m_action.m_phonedialer.ToolBarItemVisible = False  //Start Code Change ----07.16.2008 #V85 maha - removed
	m_pfe_cst_verif_info.m_action.m_printallletters.Visible = False
	//m_pfe_cst_verif_info.m_action.m_printallletters.ToolBarItemVisible = False
	m_pfe_cst_verif_info.m_action.m_searchoig.Visible = False
	//m_pfe_cst_verif_info.m_action.m_searchoig.ToolBarItemVisible = False
	m_pfe_cst_verif_info.m_action.m_deleteverification.Visible = False
	m_pfe_cst_verif_info.m_action.m_clearprintflag.Visible = False
	//m_pfe_cst_verif_info.m_action.m_clearprintflag.ToolBarItemVisible = False
	//Start Code Change ----07.16.2008 #V85 maha - new items
	m_pfe_cst_verif_info.m_action.m_sendtohistory.Visible = False
	m_pfe_cst_verif_info.m_action.m_findmissingverifs.Visible = False
	m_pfe_cst_verif_info.m_action.m_zip.visible = false  //(Appeon)Stephen 2013-07-30 - V141 File Packet creation
	m_pfe_cst_verif_info.m_action.m_extractverifdocuments.visible = false  //Start Code Change ----11.16.2017 #V154 maha
	//m_pfe_cst_verif_info.m_action.m_findmissingverifs.ToolBarItemVisible = False
	//End Code Change---07.16.2008
	
	m_pfe_cst_verif_info.m_action.m_amaprofileapi.Visible = False  //Start Code Change ----05.23.2016 #V152 maha

	
	//Start Code Change ----10.30.2012 #V12 maha - childrens hosp customization
	if gb_use_prac_toolbar = true then
		m_pfe_cst_verif_info.m_action.m_connecttoweb.ToolBarItemVisible = False  //maha 110804
		m_pfe_cst_verif_info.m_action.m_exportdata.ToolBarItemVisible = False
		m_pfe_cst_verif_info.m_action.m_printallletters.ToolBarItemVisible = False
		m_pfe_cst_verif_info.m_action.m_searchoig.ToolBarItemVisible = False
		m_pfe_cst_verif_info.m_action.m_clearprintflag.ToolBarItemVisible = False
		m_pfe_cst_verif_info.m_action.m_findmissingverifs.ToolBarItemVisible = False
		m_pfe_cst_verif_info.m_action.m_zip.ToolBarItemVisible = false  //(Appeon)Stephen 2013-07-30 - V141 File Packet creation
		m_pfe_cst_verif_info.m_action.m_extractverifdocuments.visible = false  //Start Code Change ----11.16.2017 #V154 maha
	end if
	//End Code Change ----10.30.2012
ELSE
	// mskinner 21 March 2006 -- begin
	if isvalid(m_pfe_cst_verif_info) then
		m_pfe_cst_verif_info.m_action.m_connecttoweb.Visible = True
		//m_pfe_cst_verif_info.m_action.m_connecttoweb.ToolBarItemVisible = True
		m_pfe_cst_verif_info.m_action.m_exportdata.Visible = True
		//m_pfe_cst_verif_info.m_action.m_exportdata.ToolBarItemVisible = True
		m_pfe_cst_verif_info.m_action.m_phonedialer.Visible = True
		m_pfe_cst_verif_info.m_action.m_printallletters.Visible = True
		//m_pfe_cst_verif_info.m_action.m_printallletters.ToolBarItemVisible = True	
		m_pfe_cst_verif_info.m_action.m_searchoig.Visible = True
		//m_pfe_cst_verif_info.m_action.m_searchoig.ToolBarItemVisible = True
		m_pfe_cst_verif_info.m_action.m_clearprintflag.Visible = True
		//m_pfe_cst_verif_info.m_action.m_clearprintflag.ToolBarItemVisible = True
		//Start Code Change ----07.16.2008 #V85 maha - new items
		m_pfe_cst_verif_info.m_action.m_findmissingverifs.Visible = True
		//m_pfe_cst_verif_info.m_action.m_findmissingverifs.ToolBarItemVisible = True
		//End Code Change---07.16.2008	
		m_pfe_cst_verif_info.m_action.m_zip.visible = true  //(Appeon)Stephen 2013-07-30 - V141 File Packet creation
		m_pfe_cst_verif_info.m_action.m_amaprofileapi.Visible = True  //Start Code Change ----05.23.2016 #V152 maha
		m_pfe_cst_verif_info.m_action.m_extractverifdocuments.visible = true  //Start Code Change ----11.16.2017 #V154 maha
		//Start Code Change ----05.23.2016 #V152 maha
		m_pfe_cst_verif_info.m_action.m_amaprofileapi.Visible = False
		//Start Code Change ----05.23.2016
		
		//Start Code Change ----10.30.2012 #V12 maha - childrens hosp customization
		if gb_use_prac_toolbar = true then
			m_pfe_cst_verif_info.m_action.m_connecttoweb.ToolBarItemVisible = True
			m_pfe_cst_verif_info.m_action.m_exportdata.ToolBarItemVisible = True
			m_pfe_cst_verif_info.m_action.m_printallletters.ToolBarItemVisible = True
			m_pfe_cst_verif_info.m_action.m_searchoig.ToolBarItemVisible = True
			m_pfe_cst_verif_info.m_action.m_clearprintflag.ToolBarItemVisible = True
			m_pfe_cst_verif_info.m_action.m_findmissingverifs.ToolBarItemVisible = True
			m_pfe_cst_verif_info.m_action.m_zip.ToolBarItemVisible = true  //(Appeon)Stephen 2013-07-30 - V141 File Packet creation
			m_pfe_cst_verif_info.m_action.m_extractverifdocuments.visible = true  //Start Code Change ----11.16.2017 #V154 maha
		end if
		//End Code Change ----10.30.2012
		
		//Start Code Change ----02.02.2010 #V10 maha - security for delete/history
	//	if of_security_access(7130) = 0 then
		if of_security_access(7150) = 0 then  //Start Code Change ----01.21.2015 #V14.2 maha - corrected action value (was CVO data access)
			m_pfe_cst_verif_info.m_action.m_deleteverification.Visible = False
			m_pfe_cst_verif_info.m_action.m_sendtohistory.Visible = False
		else
			m_pfe_cst_verif_info.m_action.m_deleteverification.Visible = True
			m_pfe_cst_verif_info.m_action.m_sendtohistory.Visible = True
		end if
		//End Code Change---02.02.2010
	end if
	
	if of_security_access(7788) = 0 then  //Start Code Change ----03.12.2015 #V15 maha
		m_pfe_cst_verif_info.m_action.m_findmissingverifs.Visible = false
	end if
	// // mskinner 21 March 2006 -- end
END IF

// Reverify Credential
IF of_security_access( 170 ) = 0 THEN
	m_pfe_cst_verif_info.m_action.m_reverifydata.Visible = False
	if gb_use_prac_toolbar = true then //Start Code Change ----10.30.2012 #V12 maha - childrens hosp customization
		m_pfe_cst_verif_info.m_action.m_reverifydata.ToolBarItemVisible = False
	end if
ELSE
	m_pfe_cst_verif_info.m_action.m_reverifydata.Visible = True
	if gb_use_prac_toolbar = true then //Start Code Change ----10.30.2012 #V12 maha - childrens hosp customization
		m_pfe_cst_verif_info.m_action.m_reverifydata.ToolBarItemVisible = True
	end if
END IF

// Copy Credential
IF of_security_access( 180 ) = 0 THEN
	m_pfe_cst_verif_info.m_action.m_copyverification.Visible = False
	if gb_use_prac_toolbar = true then //Start Code Change ----10.30.2012 #V12 maha - childrens hosp customization
		m_pfe_cst_verif_info.m_action.m_copyverification.ToolBarItemVisible = False
	end if
ELSE
	m_pfe_cst_verif_info.m_action.m_copyverification.Visible = True	
	if gb_use_prac_toolbar = true then //Start Code Change ----10.30.2012 #V12 maha - childrens hosp customization
		m_pfe_cst_verif_info.m_action.m_copyverification.ToolBarItemVisible = True
	end if
END IF

//Begin add for work flow menu item. 14/11/2006 Henry
//If gb_workflow and of_get_app_setting("set_9", "I") = 1 Then
If not gb_workflow or of_get_app_setting("set_9", "I") = 1 Then  //Start Code Change ----06.09.2011 #V11 maha
	m_pfe_cst_verif_info.m_action.m_workflow.Visible = False
	if gb_use_prac_toolbar = true then //Start Code Change ----10.30.2012 #V12 maha - childrens hosp customization
		m_pfe_cst_verif_info.m_action.m_workflow.ToolBarItemVisible = False
	end if
ELSE
	m_pfe_cst_verif_info.m_action.m_workflow.Visible = True
	if gb_use_prac_toolbar = true then //Start Code Change ----10.30.2012 #V12 maha - childrens hosp customization
		m_pfe_cst_verif_info.m_action.m_workflow.ToolBarItemVisible = True
	end if
End If
//End add for work flow menu item

// Readonly security settings
if of_security_access(40) < 2 or of_security_access(140) < 2 then
	m_pfe_cst_verif_info.m_action.m_connecttoweb.enabled = false
	m_pfe_cst_verif_info.m_action.m_exportdata.enabled = false
	m_pfe_cst_verif_info.m_action.m_phonedialer.enabled = false
	m_pfe_cst_verif_info.m_action.m_printallletters.enabled = false
	m_pfe_cst_verif_info.m_action.m_searchoig.enabled = false
	m_pfe_cst_verif_info.m_action.m_deleteverification.enabled = false
	m_pfe_cst_verif_info.m_action.m_clearprintflag.enabled = false
	m_pfe_cst_verif_info.m_action.m_sendtohistory.enabled = false
	m_pfe_cst_verif_info.m_action.m_findmissingverifs.enabled = false
	m_pfe_cst_verif_info.m_file.m_save.enabled = false
	m_pfe_cst_verif_info.m_action.m_reverifydata.enabled = false
	m_pfe_cst_verif_info.m_action.m_copyverification.enabled = false
	m_pfe_cst_verif_info.m_action.m_workflow.enabled = false
	m_pfe_cst_verif_info.m_action.m_zip.enabled = false  //(Appeon)Stephen 2013-07-30 - V141 File Packet creation			
	m_pfe_cst_verif_info.m_action.m_amaprofileapi.Visible = False //Start Code Change ----05.23.2016 #V152 maha
	m_pfe_cst_verif_info.m_action.m_extractverifdocuments.visible = false  //Start Code Change ----11.16.2017 #V154 maha
else
	//m_pfe_cst_verif_info.m_action.m_connecttoweb.enabled = true
	//m_pfe_cst_verif_info.m_action.m_exportdata.enabled = true
	//m_pfe_cst_verif_info.m_action.m_searchoig.enabled = true
	m_pfe_cst_verif_info.m_action.m_phonedialer.enabled = true
	m_pfe_cst_verif_info.m_action.m_printallletters.enabled = true
	m_pfe_cst_verif_info.m_action.m_deleteverification.enabled = true
	m_pfe_cst_verif_info.m_action.m_clearprintflag.enabled = true
	m_pfe_cst_verif_info.m_action.m_sendtohistory.enabled = true
	m_pfe_cst_verif_info.m_action.m_findmissingverifs.enabled = true
	m_pfe_cst_verif_info.m_file.m_save.enabled = true
	m_pfe_cst_verif_info.m_action.m_reverifydata.enabled = true
	m_pfe_cst_verif_info.m_action.m_copyverification.enabled = true
	m_pfe_cst_verif_info.m_action.m_workflow.enabled = true
	m_pfe_cst_verif_info.m_action.m_zip.enabled = true  //(Appeon)Stephen 2013-07-30 - V141 File Packet creation
	m_pfe_cst_verif_info.m_action.m_amaprofileapi.Visible = true //Start Code Change ----05.23.2016 #V152 maha
	m_pfe_cst_verif_info.m_action.m_extractverifdocuments.visible = true  //Start Code Change ----11.16.2017 #V154 maha
end if

//----------------APPEON BEGIN-------------------------
//$<add> long.zhang 07.14.2011
//$<reason> for red flag Data menu security
if of_security_access(7160) = 0  then
	m_pfe_cst_verif_info.m_system.m_addredflagdata.Visible = False
else
	m_pfe_cst_verif_info.m_system.m_addredflagdata.Visible = True
end if
//---------------APPEON END

  //Start Code Change ----05.31.2017 #V154 maha
if of_security_access(7852) = 0 then
	m_pfe_cst_verif_info.m_view.m_facilitynotes.visible = false
else
	m_pfe_cst_verif_info.m_view.m_facilitynotes.visible = true
end if

//Start Code Change ----02.16.2012 #V12 maha - rempved -no longer needed
////Start Code Change ----03.03.2011 #V11 maha - hide on this tab for space purposes
//m_pfe_cst_master_menu.m_system.m_painters.m_applicationmapping.toolbaritemVisible = False
//m_pfe_cst_master_menu.m_file.m_grouppractices.ToolbarItemVisible = False
//m_pfe_cst_verif_info.m_file.m_contract.ToolbarItemVisible = False  //Start Code Change ----06.09.2011 #V11 maha 
//m_pfe_cst_verif_info.m_file.m_contractglobalsearch.ToolbarItemVisible = False    //Start Code Change ----06.09.2011 #V11 maha
////End Code Change ----03.03.2011
//End Code Change ----02.16.2012
Return 1
end function

public function integer of_menu_security_profile ();//////////////////////////////////////////////////////////////////////
// $<function> of_menu_security_profile
// $<arguments>
// $<returns> integer
// $<description> Set security for m_pfe_cst_profile menu (Menu readonly security)
//////////////////////////////////////////////////////////////////////
// $<add> Evan 06.19.2009
//////////////////////////////////////////////////////////////////////

// Readonly security settings
//if the practitioner folder main setting is read only profile cannot be printed
if of_security_access(40) < 2 then
	m_pfe_cst_profile.m_file.m_print.enabled = false
else
	m_pfe_cst_profile.m_file.m_print.enabled = true
end if

//Start Code Change ----02.17.2012 #V12 maha
//Start Code Change ----10.30.2012 #V12 maha - childrens hosp customization
if gb_use_prac_toolbar = true then
	m_pfe_cst_profile.m_file.m_print.toolbaritemvisible = True
	m_pfe_cst_profile.m_file.m_runreport.toolbaritemvisible = True
else
	m_pfe_cst_profile.m_file.m_print.toolbaritemvisible = false
	m_pfe_cst_profile.m_file.m_runreport.toolbaritemvisible = false
end if
//End Code Change ----10.30.2012 
//End Code Change ----02.17.2012
Return 1
end function

public function integer of_menu_security_image (string as_menu_image);//////////////////////////////////////////////////////////////////////
// $<function> of_menu_security_image
// $<arguments>
// $<returns> integer
// $<description> Set security for image menus (Menu readonly security)
//////////////////////////////////////////////////////////////////////
// $<add> Evan 06.19.2009
//////////////////////////////////////////////////////////////////////

m_pfe_cst_imaging lm_image

// Get current image menu
choose case Lower(as_menu_image)
	case "m_pfe_cst_imaging_browse"
		lm_image = m_pfe_cst_imaging_browse		
	case "m_pfe_cst_imaging_view"
		lm_image = m_pfe_cst_imaging_view
	case "m_pfe_cst_imaging_setup"
		lm_image = m_pfe_cst_imaging_setup
	case else
		lm_image = m_pfe_cst_imaging
end choose
if not IsValid(lm_image) then Return -1

// Readonly security settings
if of_security_access(40) < 2 or of_security_access(1000) < 2  then
	lm_image.m_file.m_save.enabled = false
	lm_image.m_file.m_saveimage.enabled = false
	lm_image.m_edit.m_insert.enabled = false
	lm_image.m_edit.m_110.enabled = false
	lm_image.m_edit.m_delete1.enabled = false
	lm_image.m_edit.m_3.enabled = false
	lm_image.m_edit.m_restorerow.enabled = false
	
	//lm_image.m_file.m_print.enabled = false //Start Code Change ----02.19.2010 #V10 maha - allow printing
	//lm_image.m_file.m_batchprint.enabled = false  //Start Code Change ----02.19.2010 #V10 maha - allow printing
	lm_image.m_file.m_emailimage.enabled = false	
	lm_image.m_edit.m_undo.enabled = false
	lm_image.m_edit.m_annotations.enabled = false
	lm_image.m_edit.m_pageproperties.enabled = false
	if IsValid(m_pfe_cst_imaging_browse) then
		m_pfe_cst_imaging_browse.m_file.m_faximage.enabled = false
		m_pfe_cst_imaging_browse.m_edit.m_setashistorical.enabled = false   //Start Code Change ----08.17.2011 #V11 maha 
	end if
else
	lm_image.m_file.m_save.enabled = true
	lm_image.m_file.m_saveimage.enabled = true
	lm_image.m_edit.m_insert.enabled = true
	lm_image.m_edit.m_110.enabled = true
	lm_image.m_edit.m_delete1.enabled = true
	lm_image.m_edit.m_3.enabled = true
	lm_image.m_edit.m_restorerow.enabled = true
	//
	lm_image.m_file.m_print.enabled = true
	lm_image.m_file.m_batchprint.enabled = true
	lm_image.m_file.m_emailimage.enabled = true
	lm_image.m_edit.m_undo.enabled = true
	lm_image.m_edit.m_annotations.enabled = true
	lm_image.m_edit.m_pageproperties.enabled = true
	if IsValid(m_pfe_cst_imaging_browse) then
		m_pfe_cst_imaging_browse.m_file.m_faximage.enabled = true
		m_pfe_cst_imaging_browse.m_edit.m_setashistorical.enabled = True  //Start Code Change ----08.17.2011 #V11 maha 
	end if
end if

// //Start Code Change ----05.31.2017 #V154 maha
if of_security_access(7852) = 0 then
	lm_image.m_view.m_facilitynotes.visible = false
else
	lm_image.m_view.m_facilitynotes.visible = true
end if

Return 1

//------------------- APPEON BEGIN -------------------
//$<delete> Evan 06.19.2009
//$<reason> Menu readonly security
/*
//Set menu security for imaging tabpages - Added by Alfee on 10.13.2008 

m_pfe_cst_imaging lm_image

IF of_security_access( 1000 ) < 2  THEN //read only
	//Get current image menu
	CHOOSE CASE Lower(as_menu_image)
		CASE 'm_pfe_cst_imaging_browse'
			lm_image = m_pfe_cst_imaging_browse
		CASE 'm_pfe_cst_imaging_view'
			lm_image = m_pfe_cst_imaging_view
		CASE 'm_pfe_cst_imaging_setup'
			lm_image = m_pfe_cst_imaging_setup
		CASE ELSE
			lm_image = m_pfe_cst_imaging
	END CHOOSE
	
	//Set menu items and toolbars accordingly
	IF IsValid(lm_image) THEN
		lm_image.m_file.m_save.Visible = False
		lm_image.m_file.m_saveimage.Visible = False		
		lm_image.m_edit.m_insert.Visible = False
		lm_image.m_edit.m_110.Visible = False
		lm_image.m_edit.m_delete1.Visible = False
		lm_image.m_edit.m_3.Visible = False
		lm_image.m_edit.m_restorerow.Visible = False		

		lm_image.m_file.m_save.ToolbarItemVisible = False
		lm_image.m_file.m_saveimage.ToolbarItemVisible = False		
		lm_image.m_edit.m_delete1.ToolbarItemVisible = False
		lm_image.m_edit.m_restorerow.ToolbarItemVisible = False				
	END IF	
END IF

RETURN 1
*/
//------------------- APPEON END ---------------------
end function

public function integer of_menu_security_privilege ();//////////////////////////////////////////////////////////////////////
// $<function> of_menu_security_privilege
// $<arguments>
// $<returns> integer
// $<description> Set security for m_pfe_cst_privileges menu (Menu readonly security)
//////////////////////////////////////////////////////////////////////
// $<add> Evan 06.19.2009
//////////////////////////////////////////////////////////////////////

//Start Code Change ----10.30.2012 #V12 maha - childrens hosp customization
if gb_use_prac_toolbar = true then
	m_pfe_cst_master_menu.m_file.m_save.ToolBarItemVisible = True
	m_pfe_cst_master_menu.m_edit.m_insert.ToolBarItemVisible = True
	m_pfe_cst_master_menu.m_edit.m_delete1.ToolBarItemVisible = True
	m_pfe_cst_privileges.m_edit.m_batchupdate1.ToolBarItemVisible = True
	m_pfe_cst_master_menu.m_file.m_print.ToolBarItemVisible = True
else
	m_pfe_cst_master_menu.m_file.m_save.ToolBarItemVisible = False
	m_pfe_cst_master_menu.m_edit.m_insert.ToolBarItemVisible = False
	m_pfe_cst_master_menu.m_edit.m_delete1.ToolBarItemVisible = False
	m_pfe_cst_privileges.m_edit.m_batchupdate1.ToolBarItemVisible = False
	m_pfe_cst_master_menu.m_file.m_print.ToolBarItemVisible = False
end if
//End Code Change ----10.30.2012
//m_pfe_cst_data_entry.m_file.m_multiapp.ToolBarItemVisible = False

// Readonly security settings
if of_security_access(40) < 2 or of_security_access(210) < 2 then
	m_pfe_cst_master_menu.m_file.m_save.enabled = false
	m_pfe_cst_master_menu.m_edit.m_insert.enabled = false
	m_pfe_cst_master_menu.m_edit.m_delete1.enabled = false
	m_pfe_cst_privileges.m_edit.m_batchupdate1.enabled = false
	if of_security_access(210) = 0 then //pracfolder readonly//Start Code Change ----03.02.2010 #V10 maha - removed for readonly
		m_pfe_cst_master_menu.m_file.m_print.enabled = false
	end if
	//Start Code Change ----11.04.2011 #V12 maha - added button code
	iw_prac_window.cb_add.enabled = false
	iw_prac_window.cb_save.enabled = false
	iw_prac_window.cb_delete.enabled = false
	iw_prac_window.cb_print.enabled = false
	iw_prac_window.cb_b3.enabled = false
	iw_prac_window.cb_b4.enabled = false
else
	m_pfe_cst_master_menu.m_file.m_save.enabled = true
	m_pfe_cst_master_menu.m_edit.m_insert.enabled = true
	m_pfe_cst_master_menu.m_edit.m_delete1.enabled = true	
	m_pfe_cst_privileges.m_edit.m_batchupdate1.enabled = true
	m_pfe_cst_master_menu.m_file.m_print.enabled = true
end if

//----------------APPEON BEGIN-------------------------
//$<add> long.zhang 07.13.2011
//$<reason> for red flag Data menu security
if of_security_access(7160) = 0  then
	m_pfe_cst_privileges.m_system.m_addredflagdata.Visible = False
else
	m_pfe_cst_privileges.m_system.m_addredflagdata.Visible = True
end if
//---------------APPEON END


 //Start Code Change ----03.12.2015 #V15 maha
if of_security_access(7784) = 0  then
	m_pfe_cst_master_menu.m_edit.m_delete1.visible = false
end if

if of_security_access(7782) = 0  then
	m_pfe_cst_master_menu.m_file.m_print.Visible = False
end if
	
if of_security_access(7783) = 0  then
	m_pfe_cst_privileges.m_edit.m_batchupdate1.visible = false
end if
 //Start Code Change ----03.12.2015
 
  //Start Code Change ----05.31.2017 #V154 maha
if of_security_access(7852) = 0 then
	m_pfe_cst_privileges.m_view.m_facilitynotes.visible = false
else
	m_pfe_cst_privileges.m_view.m_facilitynotes.visible = true
end if
 
 
IF gb_se_version THEN
	IF IsValid( m_pfe_cst_data_entry ) THEN
		m_pfe_cst_data_entry.m_file.m_multiapp.Visible = False
		m_pfe_cst_data_entry.m_file.m_multiapp.ToolBarItemVisible = False
	END IF
END IF

Return 1
end function

public function integer of_menu_security_appl_status ();//////////////////////////////////////////////////////////////////////
// $<function> of_menu_security_appl_status
// $<arguments>
// $<returns> integer
// $<description> Set security for m_pfe_cst_net_dev menu (Menu readonly security)
//////////////////////////////////////////////////////////////////////
// $<add> Evan 06.22.2009
//////////////////////////////////////////////////////////////////////

if gi_iapp_on = 0 then
	m_pfe_cst_net_dev.m_file.m_printapps.Visible = False
//	m_pfe_cst_net_dev.m_file.m_printapps.ToolBarItemVisible = False
end if

 //Start Code Change ----02.01.2010 #V10 maha - these inherited items should not be visible
m_pfe_cst_data_entry.m_file.m_cvodata.Visible = false 
m_pfe_cst_data_entry.m_file.m_cvodata.ToolBarItemVisible = false  
//End Code Change---02.01.2010

//Begin add for work flow menu item. 14/11/2006 Henry
If gb_workflow and of_get_app_setting("set_9", "I") = 1 Then
	m_pfe_cst_net_dev.m_action.m_workflow.Visible = True
//	m_pfe_cst_net_dev.m_action.m_workflow.ToolBarItemVisible = True
End If
//End add for work flow menu item

m_pfe_cst_net_dev.m_edit.m_batchaddfacilities.ToolBarItemVisible = False  //Start Code Change ----04.15.2008 #V8 maha - code added because upable to modify in PB
m_pfe_cst_net_dev.m_system.m_checkdatalinks.Visible = False  //Start Code Change ----10.11.2012 #V12 maha

//Start Code Change ----10.30.2012 #V12 maha - childrens hosp customization
if gb_use_prac_toolbar = true then
	m_pfe_cst_net_dev.m_file.m_save.ToolBarItemVisible = true
	m_pfe_cst_net_dev.m_edit.m_insert.ToolBarItemVisible = true
	m_pfe_cst_net_dev.m_edit.m_delete1.ToolBarItemVisible = true
	m_pfe_cst_net_dev.m_file.m_print.ToolBarItemVisible = true
	m_pfe_cst_net_dev.m_file.m_printapps.ToolBarItemVisible = true
	m_pfe_cst_net_dev.m_action.m_initiatereappointment.ToolBarItemVisible =  true
	m_pfe_cst_net_dev.m_file.m_popwebsite.ToolBarItemVisible = true
	m_pfe_cst_net_dev.m_view.m_filter.ToolBarItemVisible =  true
	m_pfe_cst_net_dev.m_view.m_notes.ToolBarItemVisible =  true
	m_pfe_cst_net_dev.m_action.m_zip.ToolBarItemVisible =  true  //(Appeon)Stephen 2013-07-30 - V141 File Packet creation
else
	m_pfe_cst_net_dev.m_file.m_save.ToolBarItemVisible = False
	m_pfe_cst_net_dev.m_edit.m_insert.ToolBarItemVisible = False
	m_pfe_cst_net_dev.m_edit.m_delete1.ToolBarItemVisible = False
	m_pfe_cst_net_dev.m_file.m_print.ToolBarItemVisible = False
	m_pfe_cst_net_dev.m_file.m_printapps.ToolBarItemVisible = False
	m_pfe_cst_net_dev.m_action.m_initiatereappointment.ToolBarItemVisible = False
	m_pfe_cst_net_dev.m_file.m_popwebsite.ToolBarItemVisible = False
	m_pfe_cst_net_dev.m_view.m_filter.ToolBarItemVisible = False
	m_pfe_cst_net_dev.m_view.m_notes.ToolBarItemVisible =  false
	m_pfe_cst_net_dev.m_action.m_zip.ToolBarItemVisible =  false  //(Appeon)Stephen 2013-07-30 - V141 File Packet creation
end if
//End Code Change ----10.30.2012

// Readonly security settings
if of_security_access(40) < 2 or of_security_access(1400) < 2 then
	m_pfe_cst_net_dev.m_file.m_save.enabled = false
	m_pfe_cst_net_dev.m_edit.m_insert.enabled = false
	m_pfe_cst_net_dev.m_edit.m_delete1.enabled = false
	m_pfe_cst_net_dev.m_file.m_print.enabled = false
	m_pfe_cst_net_dev.m_file.m_printapps.enabled = false
	m_pfe_cst_net_dev.m_action.visible = false  //Start Code Change ----10.10.2012 #V12 maha
	m_pfe_cst_net_dev.m_action.m_initiatereappointment.enabled = false //Start Code Change ----10.30.2012 #V12 maha
	m_pfe_cst_net_dev.m_file.m_popwebsite.enabled = false //Start Code Change ----10.30.2012 #V12 maha
	//Start Code Change ----11.04.2011 #V12 maha - added button code
	if isvalid(iw_prac_window) then //add judgement by stephen 05.22.2012 -Null object reference at line 14 in function of_refresh_page_menu of object pfc_cst_u_data_entry
		iw_prac_window.cb_add.enabled = false
		iw_prac_window.cb_save.enabled = false
		iw_prac_window.cb_delete.enabled = false
		iw_prac_window.cb_print.enabled = false
		iw_prac_window.cb_b4.enabled = false
		iw_prac_window.cb_b5.enabled = false
	end if
	//End Code Change ----11.04.2011 
else
	m_pfe_cst_net_dev.m_file.m_save.enabled = true
	m_pfe_cst_net_dev.m_edit.m_insert.enabled = true
	m_pfe_cst_net_dev.m_edit.m_delete1.enabled = true
	m_pfe_cst_net_dev.m_file.m_print.enabled = true
	m_pfe_cst_net_dev.m_file.m_printapps.enabled = true
	m_pfe_cst_net_dev.m_action.m_initiatereappointment.enabled = true
	m_pfe_cst_net_dev.m_action.m_zip.visible = true   //(Appeon)Stephen 2013-07-30 - V141 File Packet creation
	//Start Code Change ----11.04.2011 #V12 maha - added button code
	if isvalid(iw_prac_window) then //add judgement by stephen 05.22.2012 -Null object reference at line 14 in function of_refresh_page_menu of object pfc_cst_u_data_entry
		iw_prac_window.cb_add.enabled = true
		iw_prac_window.cb_save.enabled = true
		iw_prac_window.cb_delete.enabled = true
		iw_prac_window.cb_print.enabled = true
		iw_prac_window.cb_b4.enabled = true
		iw_prac_window.cb_b5.enabled = true
	end if
	//End Code Change ----11.04.2011 
end if

//Start Code Change ----03.12.2015 #V15 maha
if of_security_access(7775) = 0 then
 	m_pfe_cst_net_dev.m_edit.m_delete1.visible = false
end if

if of_security_access(7778) = 0 then
 	m_pfe_cst_net_dev.m_action.m_initiatereappointment.visible = false 
end if

if of_security_access(7779) = 0 then
 	m_pfe_cst_net_dev.m_file.m_printapps.visible = false 
end if

if of_security_access(7781) = 0 then
	m_pfe_cst_net_dev.m_file.m_popwebsite.visible = false
end if

 //Start Code Change ----05.31.2017 #V154 maha
if of_security_access(7852) = 0 then
	m_pfe_cst_net_dev.m_view.m_facilitynotes.visible = false
end if

//Start Code Change ----12.01.2017 #V16 maha
if of_security_access(7862) = 0 then
	m_pfe_cst_net_dev.m_action.m_workflowactionedit.visible = false
end if

Return 1
end function

public function integer of_menu_security_meeting ();//////////////////////////////////////////////////////////////////////
// $<function> of_menu_security_meeting
// $<arguments>
// $<returns> integer
// $<description> Set security for m_pfe_cst_prac_meetings menu (Menu readonly security)
//////////////////////////////////////////////////////////////////////
// $<add> Evan 06.22.2009
//////////////////////////////////////////////////////////////////////
//Start Code Change ----02.17.2012 #V12 maha - added change to button code
//Start Code Change ----10.30.2012 #V12 maha - childrens hosp customization
if gb_use_prac_toolbar = true then
	m_pfe_cst_prac_meetings.m_file.m_save.ToolBarItemVisible = True
	m_pfe_cst_prac_meetings.m_edit.m_insert.ToolBarItemVisible = True
	m_pfe_cst_prac_meetings.m_edit.m_delete1.ToolBarItemVisible = True
	m_pfe_cst_prac_meetings.m_file.m_print.ToolBarItemVisible = True
else
	m_pfe_cst_prac_meetings.m_file.m_save.ToolBarItemVisible = False
	m_pfe_cst_prac_meetings.m_edit.m_insert.ToolBarItemVisible = False
	m_pfe_cst_prac_meetings.m_edit.m_delete1.ToolBarItemVisible = False
	m_pfe_cst_prac_meetings.m_file.m_print.ToolBarItemVisible = False
end if

// Readonly security settings
if of_security_access(40) < 2 or of_security_access(190) < 2 then
	m_pfe_cst_prac_meetings.m_edit.m_undo.enabled = false
	m_pfe_cst_prac_meetings.m_edit.m_cut.enabled = false
	m_pfe_cst_prac_meetings.m_edit.m_copy.enabled = false
	m_pfe_cst_prac_meetings.m_edit.m_paste.enabled = false
	//
	m_pfe_cst_prac_meetings.m_file.m_save.enabled = false
	m_pfe_cst_prac_meetings.m_edit.m_insert.enabled = false
	m_pfe_cst_prac_meetings.m_edit.m_delete1.enabled = false
	m_pfe_cst_prac_meetings.m_file.m_print.enabled = false
	if isvalid(iw_prac_window) then //add judgement by stephen 05.22.2012 -Null object reference at line 14 in function of_refresh_page_menu of object pfc_cst_u_data_entry
		iw_prac_window.cb_add.enabled = false
		iw_prac_window.cb_save.enabled = false
		iw_prac_window.cb_delete.enabled = false
		iw_prac_window.cb_print.enabled = false
	end if
else
	m_pfe_cst_prac_meetings.m_edit.m_undo.enabled = true
	m_pfe_cst_prac_meetings.m_edit.m_cut.enabled = true
	m_pfe_cst_prac_meetings.m_edit.m_copy.enabled = true
	m_pfe_cst_prac_meetings.m_edit.m_paste.enabled = true
	//
	m_pfe_cst_prac_meetings.m_file.m_save.enabled = true
	m_pfe_cst_prac_meetings.m_edit.m_insert.enabled = true
	m_pfe_cst_prac_meetings.m_edit.m_delete1.enabled = true
	m_pfe_cst_prac_meetings.m_file.m_print.enabled = true
	if isvalid(iw_prac_window) then //add judgement by stephen 05.22.2012 -Null object reference at line 14 in function of_refresh_page_menu of object pfc_cst_u_data_entry
		//Start Code Change ----10.30.2012 #V12 maha - childrens hosp customization
		if gb_use_prac_toolbar = false then
			iw_prac_window.cb_add.enabled = true
			iw_prac_window.cb_save.enabled = true
			iw_prac_window.cb_delete.enabled = true
			iw_prac_window.cb_print.enabled = true
		end if
		//End Code Change ----10.30.2012
	end if
end if
//Start Code Change ----02.17.2012
Return 1
end function

public function integer of_case_review_security (w_case_review aw_case_review);//Security control for w_case_review - alfee 01.14.2010

integer i, li_cnt
integer li_rights_main, li_rights_ai

if not isvalid(aw_case_review) then return 0

li_cnt = UpperBound( ii_security_action_id )
for i = 1 to li_cnt
	if ii_security_action_id[i] = 2040 then li_rights_main = ii_security_action_value[i]
	if ii_security_action_id[i] = 2060 then li_rights_ai = ii_security_action_value[i]	
next
  

if li_rights_main = 1 then //readonly for view rights
	//set both 2 tabpages
	aw_case_review.uo_case_review.tab_1.tabpage_detail.tab_2.tabpage_case_detail.dw_detail.enabled = false
	aw_case_review.uo_case_review.tab_1.tabpage_detail.tab_2.tabpage_case_detail.dw_physicians.enabled = false	
	aw_case_review.uo_case_review.tab_1.tabpage_detail.tab_2.tabpage_ai.dw_action_item.enabled = false	
	if isvalid(m_pfe_cst_qa) then
		m_pfe_cst_qa.m_file.m_save.enabled = false
		m_pfe_cst_qa.m_edit.m_insert.enabled = false
		m_pfe_cst_qa.m_edit.m_delete1.enabled = false
		
	end if
elseif li_rights_main = 2 THEN //full for view rights
	//set case detail
	aw_case_review.uo_case_review.tab_1.tabpage_detail.tab_2.tabpage_case_detail.dw_detail.enabled = true
	aw_case_review.uo_case_review.tab_1.tabpage_detail.tab_2.tabpage_case_detail.dw_physicians.enabled = true
	if aw_case_review.uo_case_review.tab_1.tabpage_detail.tab_2.selectedtab = 1 then			
		if isvalid(m_pfe_cst_qa) then
			m_pfe_cst_qa.m_file.m_save.enabled = true
			m_pfe_cst_qa.m_edit.m_insert.enabled = true
			m_pfe_cst_qa.m_edit.m_delete1.enabled = true
		end if
	end if
	//set action item
	if li_rights_ai = 2 then //full for ai
		aw_case_review.uo_case_review.tab_1.tabpage_detail.tab_2.tabpage_ai.dw_action_item.enabled = true
		if aw_case_review.uo_case_review.tab_1.tabpage_detail.tab_2.selectedtab = 2 then			
			if isvalid(m_pfe_cst_qa) then	
				m_pfe_cst_qa.m_edit.m_insert.enabled = true
				m_pfe_cst_qa.m_edit.m_delete1.enabled = true
			end if
		end if	
	elseif li_rights_ai = 1 then //readonly for ai
		aw_case_review.uo_case_review.tab_1.tabpage_detail.tab_2.tabpage_ai.dw_action_item.enabled = false		
		if aw_case_review.uo_case_review.tab_1.tabpage_detail.tab_2.selectedtab = 2 then			
			if isvalid(m_pfe_cst_qa) then
				m_pfe_cst_qa.m_edit.m_insert.enabled = false
				m_pfe_cst_qa.m_edit.m_delete1.enabled = false
			end if
		end if			
	end if	
end if

//no access for ai
if li_rights_ai = 0 then 
	aw_case_review.uo_case_review.tab_1.tabpage_detail.tab_2.tabpage_ai.visible = false
end if	
	

//action item
FOR i = 1 TO li_cnt
	IF ii_security_action_id[ i ] = 2060 THEN 
		IF ii_security_action_value[ i ] = 1 THEN
			//set datawindow
			aw_case_review.uo_case_review.tab_1.tabpage_detail.tab_2.tabpage_ai.dw_action_item.enabled = false
			//set menu
			if aw_case_review.uo_case_review.tab_1.tabpage_detail.tab_2.selectedtab = 2 then
				if isvalid(m_pfe_cst_qa) then
					m_pfe_cst_qa.m_edit.m_insert.enabled = false
					m_pfe_cst_qa.m_edit.m_delete1.enabled = false
				end if	
			end if			
		ELSEIF ii_security_action_value[ i ] = 0 THEN
			aw_case_review.uo_case_review.tab_1.tabpage_detail.tab_2.tabpage_ai.visible = false
		END IF		
	END IF
NEXT

//Start Code Change ----10.05.2010 #V10 maha
//items that should be hidden
if isvalid(m_pfe_cst_qa) then //add if statement - alfee 11.19.2010
	m_pfe_cst_qa.m_system.m_batchaddapplications.visible = false
	//messagebox("","cvo vis")
	m_pfe_cst_qa.m_file.m_cvodata.visible = false
end if
//End Code Change ----10.05.2010

RETURN 0
end function

public function integer of_menu_security_sk ();//Start Code Change ----05.24.2010 #V10 maha

m_pfe_cst_master_menu.m_file.m_sitesurvey.Visible = False
m_pfe_cst_master_menu.m_file.m_privileging.Visible = False
m_pfe_cst_master_menu.m_file.m_launchpad.visible = false
m_pfe_cst_master_menu.m_file.m_qualityprofilemeasurements.Visible = False
m_pfe_cst_master_menu.m_file.m_qualityprofilemeasurements.ToolbarItemVisible = False
m_pfe_cst_master_menu.m_file.m_qualityprofilemeasurements.toolbaritemVisible = False
m_pfe_cst_master_menu.m_file.m_casepeerreview.Visible = False 
m_pfe_cst_master_menu.m_file.m_sitesurvey.Visible = False 
m_pfe_cst_master_menu.m_file.m_contract.Visible = False
m_pfe_cst_master_menu.m_file.m_contract.ToolbarItemVisible = False
m_pfe_cst_master_menu.m_file.m_launchpad.ToolbarItemVisible = true
m_pfe_cst_master_menu.m_file.m_launchpad.ToolbarItemText = 'LaunchPad'
m_pfe_cst_master_menu.m_file.m_todolist.ToolbarItemVisible = False
m_pfe_cst_master_menu.m_file.m_additionalprovider.Visible = False  //Start Code Change ----04.03.2013 #V12 maha - for 12.3
m_pfe_cst_master_menu.m_file.m_additionalprovider.Enabled = False
m_pfe_cst_master_menu.m_file.m_home.visible = False
m_pfe_cst_master_menu.m_file.m_home.ToolbarItemVisible = False
//m_pfe_cst_master_menu.m_reports.Visible = False//Start Code Change ----10.03.2014 #V14.2 maha
//m_pfe_cst_master_menu.m_reports.ToolbarItemVisible = False
m_pfe_cst_master_menu.m_file.m_dashboard0.ToolbarItemVisible = True

m_pfe_cst_master_menu.m_file.m_meetings.Visible = False
	m_pfe_cst_master_menu.m_file.m_meetings.ToolbarItemVisible = False

m_pfe_cst_master_menu.m_reports.m_privilegelisting.Visible = False
m_pfe_cst_master_menu.m_reports.m_privilegelisting.ToolbarItemVisible = False
m_pfe_cst_master_menu.m_reports.m_npdbreports.Visible = False
m_pfe_cst_master_menu.m_reports.m_npdbreports.ToolbarItemVisible = False

m_pfe_cst_master_menu.m_system.m_applicationmapping.ToolbarItemVisible = True
m_pfe_cst_master_menu.m_system.m_painters.m_systemsetup.m_imagetypepainter.Visible = False
m_pfe_cst_master_menu.m_system.m_painters.m_systemsetup.m_multiapppainter.Visible = False
//m_pfe_cst_master_menu.m_system.m_utilities.Visible = False
m_pfe_cst_master_menu.m_system.m_batchupdate.Visible = False
m_pfe_cst_master_menu.m_system.m_2.Visible = False
m_pfe_cst_master_menu.m_system.m_painters.m_privilegesandqa.m_reappointmentmeasurements.Visible = False
m_pfe_cst_master_menu.m_system.m_painters.visible = false
m_pfe_cst_master_menu.m_system.m_batchupdate.Visible = False
m_pfe_cst_master_menu.m_system.m_painters.m_privilegesandqa.m_privilegepainter.Visible = False
m_pfe_cst_master_menu.m_system.m_browseweb.Visible = False
m_pfe_cst_master_menu.m_system.m_painters.m_systemsetup.m_todolistpainter.Visible = False //Start Code Change ----03.23.2011 #V11 maha 
m_pfe_cst_master_menu.m_file.m_todolist.Visible = False //Start Code Change ----03.23.2011 #V11 maha 
m_pfe_cst_master_menu.m_file.m_todolist.ToolbarItemVisible = False //Start Code Change ----03.23.2011 #V11 maha 

if isvalid(m_pfe_cst_mdi_menu) then
	m_pfe_cst_mdi_menu.m_system.m_runactionitemsquery.Visible = False
end if
m_pfe_cst_master_menu.m_system.m_intellibatch.Visible = False
m_pfe_cst_master_menu.m_system.m_painters.m_systemsetup.m_intellibatchpainter.Visible = False
m_pfe_cst_master_menu.m_system.m_verificationbatchfunctions.m_batchoig.Visible = False
// m_pfe_cst_master_menu.m_system.m_batchoig.Visible = False
//m_pfe_cst_master_menu.m_system.m_importoigdata.Visible = False
m_pfe_cst_master_menu.m_system.m_verificationbatchfunctions.m_importoigdata.Visible = False
m_pfe_cst_master_menu.m_system.m_bidq.Visible = False
m_pfe_cst_master_menu.m_system.m_useridbatchupdate.Visible = False

m_pfe_cst_master_menu.m_window.m_dashboard.Visible = True  //Start Code Change ----03.23.2011 #V11 maha - changed from false

if isvalid(m_pfe_cst_data_entry) then
	m_pfe_cst_data_entry.m_file.m_cvodata.ToolBarItemVisible = false 
	m_pfe_cst_data_entry.m_file.m_facilitydata.ToolBarItemVisible = False
	m_pfe_cst_data_entry.m_file.m_dataentrycomplete.ToolBarItemVisible = False
	m_pfe_cst_data_entry.m_view.m_aptnote.ToolBarItemVisible = false
	m_pfe_cst_data_entry.m_file.m_multiapp.ToolBarItemVisible = false
	m_pfe_cst_data_entry.m_edit.m_addverificationentry.ToolBarItemVisible = false
end if

m_pfe_cst_master_menu.m_help.m_iapply.Visible = False

return 1
end function

public function integer of_menu_shrink_action_items ();//Start Code Change ----02.26.2013 #V12 maha - added to hide tool bar items in action items because the tool bar is too long

m_pfe_cst_master_menu.m_file.m_qualityprofilemeasurements.ToolbarItemVisible = False
m_pfe_cst_master_menu.m_file.m_actionitems.ToolbarItemVisible = False
m_pfe_cst_master_menu.m_file.m_todolist.ToolbarItemVisible = False
m_pfe_cst_mdi_menu.m_file.m_contacts.ToolbarItemVisible = False
m_pfe_cst_master_menu.m_file.m_caqhfileimport.ToolbarItemVisible = False
m_pfe_cst_master_menu.m_system.m_applicationmapping.toolbaritemvisible = false

//---------Begin Added by (Appeon)Alfee 08.06.2013 for V141 ISG-CLX--------
m_pfe_cst_master_menu.m_file.m_documents.toolbaritemvisible = false
m_pfe_cst_master_menu.m_file.m_contractglobalsearch.toolbaritemvisible = false
m_pfe_cst_master_menu.m_file.m_calendar.toolbaritemvisible = false
//m_pfe_cst_master_menu.m_file.m_close.toolbaritemvisible = false  //Start Code Change ----02.22.2016 #V15 maha - removed
m_pfe_cst_master_menu.m_help.m_gettingstarted.toolbaritemvisible = false
//---------End Added ------------------------------------------------------------------

return 1
end function

public subroutine of_hidemenuandtoolitems (menu am_menu);//====================================================================
// Function: of_HideMenuAndToolItems()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    menu    am_Menu
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-07-20
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Contractlogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History: Moved from CLX by (Appeon)Alfee 06.29.2013 - V141 ISG-CLX
//====================================================================

if Not IsValid(am_Menu) then Return

long	ll_Cycle,ll_ItemCnts

ll_ItemCnts = UpperBound(am_Menu.Item)
for ll_Cycle = 1 to ll_ItemCnts
	if am_Menu.Item[ll_Cycle].Text = "&Close" then CONTINUE
	if am_Menu.Item[ll_Cycle].Text = "E&xit InteliCred" then CONTINUE
	if am_Menu.Item[ll_Cycle].Text = "Document Manager" then CONTINUE
	
	of_HideMenuAndToolItems(am_Menu.Item[ll_Cycle])
	am_Menu.Item[ll_Cycle].Enabled = false
	am_Menu.Item[ll_Cycle].ToolbarItemVisible = false
next

end subroutine

public subroutine of_menu_security_2 (string as_menu_name);//====================================================================
// Function: of_Menu_Security_2()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2010-01-13
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History: Add as_menu_name parm by Ken.Guo 2010-03-26
// Moved from CLX and modified by (Appeon)Alfee 06.29.2013 - V141 ISG-CLX
//====================================================================

if gb_contract_version = true then
	m_pfe_cst_master_menu.m_window.m_dashboard.Visible = False //Task list
end if	

if gb_contract_module and of_security_access(6957) = 1 then //Calendar settings
	m_pfe_cst_master_menu.m_file.m_Calendar.Visible = true
	m_pfe_cst_master_menu.m_file.m_Calendar.ToolbarItemVisible = true
else
	m_pfe_cst_master_menu.m_file.m_Calendar.Visible = false
	m_pfe_cst_master_menu.m_file.m_Calendar.ToolbarItemVisible = false
end if

//Added By Ken.Guo 2010-05-14.
integer i
//---------Begin Modified by (Appeon)Harry 03.18.2014 for V142 ISG-CLX--------
//If isvalid(m_pfe_cst_mail) and Not isvalid(w_email_folder) Then
If isvalid(m_pfe_cst_mail) and Not isvalid(w_email_folder) and Not isvalid(w_contract_email_folder) Then
//---------End Modfiied ------------------------------------------------------
	For i = 1 to UpperBound(m_pfe_cst_mail.m_email.Item[])
		m_pfe_cst_mail.m_email.Item[i].toolbaritemvisible = False
	Next
End If

If isvalid(m_pfe_cst_master_menu) Then
	if gb_contract_module and of_security_access(6979) <> 0 then //Documents Browse
		m_pfe_cst_master_menu.m_file.m_documents.Visible = true
		If Lower(as_menu_name) <> "m_pfe_cst_mdi_menu_contract_am" Then //Add if statement - (Appeon)Alfee 07.30.2013 - V141 ISG-CLX
			m_pfe_cst_master_menu.m_file.m_documents.ToolbarItemVisible = true
		End If
	else
		m_pfe_cst_master_menu.m_file.m_documents.Visible = false
		m_pfe_cst_master_menu.m_file.m_documents.ToolbarItemVisible = false
	end if	
End If


If Lower(as_menu_name) =  'm_pfe_cst_mdi_menu_contract' Then
	of_menu_security_contract ()
End If

If Lower(as_menu_name) =  'm_pfe_cst_mdi_menu_contract_am' Then
	of_menu_security_contract_am ()
End If




end subroutine

public function integer of_menu_security_contract ();//====================================================================
//$<Function>: of_menu_security_contract()
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Hide some toolbars for Contract window as the limit of the screen
//$<Author>: (Appeon) Alfee 07.29.2013 (V141 ISG-CLX)
//-------------------------------------------------------------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Long ll_Right

IF NOT IsValid (m_pfe_cst_mdi_menu_contract) THEN RETURN 0

//IF appeongetclienttype() = "PB" THEN This.SetRedraw(False)	

If isvalid(gw_contract) Then
	If gw_contract.tab_contract_details.selectedtab = 1 Then		
		//---------Begin Commented by (Appeon)Harry  03.18.2014 for V142 ISG-CLX--------
		/*
		//m_Disp_Calendar
		if of_security_access(6957) = 1  then
			m_pfe_cst_mdi_menu_contract.m_File.m_Display.m_Disp_Calendar.Visible = true
			m_pfe_cst_mdi_menu_contract.m_File.m_Display.m_Disp_Calendar.ToolbarItemVisible = true
		else
			m_pfe_cst_mdi_menu_contract.m_File.m_Display.m_Disp_Calendar.Visible = false
			m_pfe_cst_mdi_menu_contract.m_File.m_Display.m_Disp_Calendar.ToolbarItemVisible = false
		end if		
		*/
		//---------End Commented ------------------------------------------------------
		
		//
		m_pfe_cst_mdi_menu_contract.m_file.m_options.m_autorefresh.toolbaritemvisible = True
		m_pfe_cst_mdi_menu_contract.m_file.m_select.toolbaritemvisible = True
		m_pfe_cst_mdi_menu_contract.m_file.m_refresh.toolbaritemvisible = True
		
		//Auto Refresh Toolbar Item
		If gw_contract.tab_contract_details.tabpage_search.ib_autoretrieve Then
			m_pfe_cst_mdi_menu_contract.m_file.m_options.m_autorefresh.toolbaritemdown = True
			m_pfe_cst_mdi_menu_contract.m_file.m_options.m_autorefresh.tag = 'auto'
		Else
			m_pfe_cst_mdi_menu_contract.m_file.m_options.m_autorefresh.toolbaritemdown = False
			m_pfe_cst_mdi_menu_contract.m_file.m_options.m_autorefresh.tag = 'non-auto'
		End If
		
		//Report Toolbar Item
		ll_Right = w_mdi.of_security_access(6952)
		If ll_Right = 1 Then
			m_pfe_cst_mdi_menu_contract.m_file.m_output0.visible = True
			//m_pfe_cst_mdi_menu_contract.m_file.m_output0.toolbaritemvisible = True
			m_pfe_cst_mdi_menu_contract.m_file.m_output0.m_output1.visible = True
			//m_pfe_cst_mdi_menu_contract.m_file.m_output0.m_output1.toolbaritemvisible = True
			m_pfe_cst_mdi_menu_contract.m_file.m_output0.m_report.visible = True
			//m_pfe_cst_mdi_menu_contract.m_file.m_output0.m_report.toolbaritemvisible = True	
		Else
			m_pfe_cst_mdi_menu_contract.m_file.m_output0.visible = False
			m_pfe_cst_mdi_menu_contract.m_file.m_output0.toolbaritemvisible = False
			m_pfe_cst_mdi_menu_contract.m_file.m_output0.m_output1.visible = False
			m_pfe_cst_mdi_menu_contract.m_file.m_output0.m_output1.toolbaritemvisible = False
			m_pfe_cst_mdi_menu_contract.m_file.m_output0.m_report.visible = False
			m_pfe_cst_mdi_menu_contract.m_file.m_output0.m_report.toolbaritemvisible = False
		End If
		//---------Begin Added by (Appeon)Harry 03.18.2014 for V142 ISG-CLX--------
		//Batch Alarms //Added By Ken.Guo 03/28/2013
		m_pfe_cst_mdi_menu_contract.m_edit.m_7.toolbaritemvisible = True
		//---------End Added ------------------------------------------------------
	Else
		//---------Begin Commented by (Appeon)Harry  03.18.2014 for V142 ISG-CLX--------
		//m_Disp_Calendar
		//m_pfe_cst_mdi_menu_contract.m_File.m_Display.m_Disp_Calendar.Visible = false
		//m_pfe_cst_mdi_menu_contract.m_File.m_Display.m_Disp_Calendar.ToolbarItemVisible = false		
		//---------End Commented ------------------------------------------------------
		
		//Hide Output	
		m_pfe_cst_mdi_menu_contract.m_file.m_output0.visible = False
		m_pfe_cst_mdi_menu_contract.m_file.m_output0.toolbaritemvisible = False
		m_pfe_cst_mdi_menu_contract.m_file.m_output0.m_output1.visible = False
		m_pfe_cst_mdi_menu_contract.m_file.m_output0.m_output1.toolbaritemvisible = False
		m_pfe_cst_mdi_menu_contract.m_file.m_output0.m_report.visible = False
		m_pfe_cst_mdi_menu_contract.m_file.m_output0.m_report.toolbaritemvisible = False				
		//Hide AutoRefresh/Select/Refreh  	
		m_pfe_cst_mdi_menu_contract.m_file.m_options.m_autorefresh.toolbaritemvisible = False
		m_pfe_cst_mdi_menu_contract.m_file.m_select.toolbaritemvisible = False
		m_pfe_cst_mdi_menu_contract.m_file.m_refresh.toolbaritemvisible = False
		//---------Begin Added by (Appeon)Harry 03.18.2014 for V142 ISG-CLX--------
		//Batch Alarms //Added By Ken.Guo 03/28/2013
		m_pfe_cst_mdi_menu_contract.m_edit.m_7.toolbaritemvisible = False
		//---------End Added ------------------------------------------------------
	End If
			
	If gw_contract.tab_contract_details.selectedtab = 1 or gw_contract.tab_contract_details.selectedtab = 2 Then
		//New Document Toolbar: Set by License. Document Manager Module
		Choose Case gnv_data.of_getitem( "icred_settings", "set_51", FALSE) 
			Case '3' //Off (Buy)
				m_pfe_cst_mdi_menu_contract.m_edit.m_newdocument.visible = True
				m_pfe_cst_mdi_menu_contract.m_edit.m_newdocument.toolbaritemvisible = True						
				m_pfe_cst_mdi_menu_contract.m_edit.m_newdocument.m_adddoc.visible = True
				m_pfe_cst_mdi_menu_contract.m_edit.m_newdocument.m_adddoc.toolbaritemvisible = True
				m_pfe_cst_mdi_menu_contract.m_edit.m_newdocument.m_createdoc.visible = False
				m_pfe_cst_mdi_menu_contract.m_edit.m_newdocument.m_createdoc.toolbaritemvisible = False		
			Case '1'	//On (Buy/Sell)
				m_pfe_cst_mdi_menu_contract.m_edit.m_newdocument.visible = True
				m_pfe_cst_mdi_menu_contract.m_edit.m_newdocument.toolbaritemvisible = True
				m_pfe_cst_mdi_menu_contract.m_edit.m_newdocument.m_adddoc.visible = True
				m_pfe_cst_mdi_menu_contract.m_edit.m_newdocument.m_adddoc.toolbaritemvisible = True
				m_pfe_cst_mdi_menu_contract.m_edit.m_newdocument.m_createdoc.visible = True
				m_pfe_cst_mdi_menu_contract.m_edit.m_newdocument.m_createdoc.toolbaritemvisible = True										
			Case '0' //N/A
				m_pfe_cst_mdi_menu_contract.m_edit.m_newdocument.visible = False
				m_pfe_cst_mdi_menu_contract.m_edit.m_newdocument.toolbaritemvisible = False
				m_pfe_cst_mdi_menu_contract.m_edit.m_newdocument.m_adddoc.visible = False
				m_pfe_cst_mdi_menu_contract.m_edit.m_newdocument.m_adddoc.toolbaritemvisible = False
				m_pfe_cst_mdi_menu_contract.m_edit.m_newdocument.m_createdoc.visible = False
				m_pfe_cst_mdi_menu_contract.m_edit.m_newdocument.m_createdoc.toolbaritemvisible = False							
		End Choose
		
		//New Document Toolbar: Setting by Roles Painter 
		Choose Case w_mdi.of_security_access( 2150 )
			Case 0 //No Access
				m_pfe_cst_mdi_menu_contract.m_edit.m_newdocument.visible = False
				m_pfe_cst_mdi_menu_contract.m_edit.m_newdocument.toolbaritemvisible = False
				m_pfe_cst_mdi_menu_contract.m_edit.m_newdocument.m_adddoc.visible = False
				m_pfe_cst_mdi_menu_contract.m_edit.m_newdocument.m_adddoc.toolbaritemvisible = False
				m_pfe_cst_mdi_menu_contract.m_edit.m_newdocument.m_createdoc.visible = False
				m_pfe_cst_mdi_menu_contract.m_edit.m_newdocument.m_createdoc.toolbaritemvisible = False							
			Case 1 //Read Only
				m_pfe_cst_mdi_menu_contract.m_edit.m_newdocument.enabled = False
				m_pfe_cst_mdi_menu_contract.m_edit.m_newdocument.m_adddoc.enabled = False
				m_pfe_cst_mdi_menu_contract.m_edit.m_newdocument.m_createdoc.enabled = False					
			Case 2 //Full Access
				m_pfe_cst_mdi_menu_contract.m_edit.m_newdocument.enabled = True
				m_pfe_cst_mdi_menu_contract.m_edit.m_newdocument.m_adddoc.enabled = True
				m_pfe_cst_mdi_menu_contract.m_edit.m_newdocument.m_createdoc.enabled = True
		End Choose
		
		//New Document Toolbar - Add Doc: Setting by Roles Painter 
		If w_mdi.of_security_access( 6901 ) < 2 Then
			m_pfe_cst_mdi_menu_contract.m_edit.m_newdocument.m_adddoc.enabled = False
		End If
		
		//New Document Toolbar - Create Doc: Setting by Roles Painter 
		If w_mdi.of_security_access( 6902 ) < 2 Then
			m_pfe_cst_mdi_menu_contract.m_edit.m_newdocument.m_createdoc.enabled = False
		End If

		//Disable Add/Create/Import Toolbar if Contract Main Module is readonly
		If w_mdi.of_security_access( 2070 ) < 2 Then
			m_pfe_cst_mdi_menu_contract.m_edit.m_newdocument.enabled = False
			m_pfe_cst_mdi_menu_contract.m_edit.m_newdocument.m_adddoc.enabled = False
			m_pfe_cst_mdi_menu_contract.m_edit.m_newdocument.m_createdoc.enabled = False
		End If				
	Else
		//Hide New Document
		m_pfe_cst_mdi_menu_contract.m_edit.m_newdocument.visible = False
		m_pfe_cst_mdi_menu_contract.m_edit.m_newdocument.toolbaritemvisible = False
		m_pfe_cst_mdi_menu_contract.m_edit.m_newdocument.m_adddoc.visible = False
		m_pfe_cst_mdi_menu_contract.m_edit.m_newdocument.m_adddoc.toolbaritemvisible = False
		m_pfe_cst_mdi_menu_contract.m_edit.m_newdocument.m_createdoc.visible = False
		m_pfe_cst_mdi_menu_contract.m_edit.m_newdocument.m_createdoc.toolbaritemvisible = False		
	End If
End If

//Added By Ken.Guo 2011-06-21. 
If gnv_data.of_getitem( "icred_settings", "esign", FALSE) = '1' Then
	m_pfe_cst_mdi_menu_contract.m_system.m_refresh_sertifi.visible = True
Else
	m_pfe_cst_mdi_menu_contract.m_system.m_refresh_sertifi.visible = False
End If

//Hide some toolbars for Contract window as the limit of the screen - alfee 07.29.2013
m_pfe_cst_mdi_menu_contract.m_file.m_practitioner.ToolbarItemVisible = False
m_pfe_cst_mdi_menu_contract.m_file.m_meetings.ToolbarItemVisible = False
m_pfe_cst_mdi_menu_contract.m_file.m_actionitems.ToolbarItemVisible = False
m_pfe_cst_mdi_menu_contract.m_file.m_todolist.ToolbarItemVisible = False
m_pfe_cst_mdi_menu_contract.m_file.m_grouppractices.ToolbarItemVisible = False
m_pfe_cst_mdi_menu_contract.m_file.m_qualityprofilemeasurements.ToolbarItemVisible = False
m_pfe_cst_mdi_menu_contract.m_file.m_caqhfileimport.ToolbarItemVisible = False
m_pfe_cst_mdi_menu_contract.m_reports.ToolbarItemVisible = False
m_pfe_cst_mdi_menu_contract.m_system.m_setup.ToolbarItemVisible = False
m_pfe_cst_mdi_menu_contract.m_system.m_applicationmapping.ToolbarItemVisible = False

//m_pfe_cst_mdi_menu_contract.m_file.m_documents.ToolbarItemVisible = False
m_pfe_cst_mdi_menu_contract.m_file.m_calendar.ToolbarItemVisible = False
m_pfe_cst_mdi_menu_contract.m_file.m_output0.ToolbarItemVisible = False
//m_pfe_cst_mdi_menu_contract.m_system.m_audittrail.ToolbarItemVisible = False
m_pfe_cst_mdi_menu_contract.m_help.m_gettingstarted.ToolbarItemVisible = False

//IF appeongetclienttype() = "PB" THEN This.SetRedraw(True)	

RETURN 1
end function

public function integer of_menu_security_contract_am ();//====================================================================
//$<Function>: of_menu_security_contract_am()
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Hide some toolbars for Document Manager in Contract window as the limit of the screen
//$<Author>: (Appeon) Alfee 07.29.2013 (V141 ISG-CLX)
//-------------------------------------------------------------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Long ll_Right

IF NOT IsValid (m_pfe_cst_mdi_menu_contract_am) THEN RETURN 0

IF appeongetclienttype() = "PB" THEN This.SetRedraw(False)	

//Hide some toolbars for Contract window as the limit of the screen - alfee 07.29.2013
m_pfe_cst_mdi_menu_contract_am.m_file.m_practitioner.ToolbarItemVisible = False
m_pfe_cst_mdi_menu_contract_am.m_file.m_meetings.ToolbarItemVisible = False
m_pfe_cst_mdi_menu_contract_am.m_file.m_actionitems.ToolbarItemVisible = False
m_pfe_cst_mdi_menu_contract_am.m_file.m_todolist.ToolbarItemVisible = False
m_pfe_cst_mdi_menu_contract_am.m_file.m_grouppractices.ToolbarItemVisible = False
m_pfe_cst_mdi_menu_contract_am.m_file.m_qualityprofilemeasurements.ToolbarItemVisible = False
m_pfe_cst_mdi_menu_contract_am.m_file.m_caqhfileimport.ToolbarItemVisible = False
m_pfe_cst_mdi_menu_contract_am.m_reports.ToolbarItemVisible = False
m_pfe_cst_mdi_menu_contract_am.m_system.m_setup.ToolbarItemVisible = False
m_pfe_cst_mdi_menu_contract_am.m_system.m_applicationmapping.ToolbarItemVisible = False

//m_pfe_cst_mdi_menu_contract_am.m_file.m_documents.ToolbarItemVisible = False
m_pfe_cst_mdi_menu_contract_am.m_file.m_calendar.ToolbarItemVisible = False
//m_pfe_cst_mdi_menu_contract_am.m_file.m_output0.ToolbarItemVisible = False
m_pfe_cst_mdi_menu_contract_am.m_system.m_audittrail.ToolbarItemVisible = False
m_pfe_cst_mdi_menu_contract_am.m_help.m_gettingstarted.ToolbarItemVisible = False

IF appeongetclienttype() = "PB" THEN This.SetRedraw(True)	

RETURN 1
end function

public function integer of_menu_shrink_toolbars (integer ai_module);//====================================================================
//$<Function>: of_menu_shrink_toolbars()
//$<Arguments>:
// 	value    integer    ai_module 1 - IntelliCred; 2 - IntelliContract; 3 - Both
//$<Return>:  (None)
//$<Description>: Shrink toolbars for the limit width
//$<Author>: (Appeon) Alfee 08.02.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------------------------------------------------------------
//$<Modify History>:
//====================================================================
IF NOT isvalid(m_pfe_cst_master_menu)  THEN  RETURN -1
	
IF ai_module = 1 THEN //IntelliCred
	m_pfe_cst_master_menu.m_file.m_caqhfileimport.toolbaritemvisible = False
	m_pfe_cst_master_menu.m_file.m_grouppractices.toolbaritemvisible = False
	m_pfe_cst_master_menu.m_system.toolbaritemVisible = False
	m_pfe_cst_master_menu.m_file.m_contract.toolbaritemvisible = False			
	m_pfe_cst_master_menu.m_file.m_contractglobalsearch.ToolbarItemVisible = False
	m_pfe_cst_master_menu.m_file.m_documents.ToolbarItemVisible = False
	//m_pfe_cst_master_menu.m_file.m_close.ToolbarItemVisible = False   //Start Code Change ----02.22.2016 #V15 maha - removed			
	m_pfe_cst_master_menu.m_file.m_calendar.ToolbarItemVisible = False
ELSEIF ai_module = 2 THEN //Contract
	m_pfe_cst_master_menu.m_file.m_practitioner.toolbaritemvisible = False
	m_pfe_cst_master_menu.m_file.m_grouppractices.toolbaritemvisible = False
	m_pfe_cst_master_menu.m_reports.toolbaritemvisible = False
	m_pfe_cst_master_menu.m_file.m_qualityprofilemeasurements.toolbaritemvisible = False
	m_pfe_cst_master_menu.m_file.m_caqhfileimport.toolbaritemvisible = False
	m_pfe_cst_master_menu.m_file.m_actionitems.toolbaritemvisible = False	
	m_pfe_cst_master_menu.m_file.m_todolist.toolbaritemvisible = False		
	m_pfe_cst_master_menu.m_file.m_meetings.toolbaritemvisible = False		
	m_pfe_cst_master_menu.m_system.m_applicationmapping.toolbaritemVisible = False
	m_pfe_cst_master_menu.m_system.m_setup.toolbaritemVisible = False

	//m_pfe_cst_master_menu.m_file.m_contract.toolbaritemvisible = False			
	//m_pfe_cst_master_menu.m_file.m_contractglobalsearch.ToolbarItemVisible = False
	//m_pfe_cst_master_menu.m_file.m_documents.ToolbarItemVisible = False
	m_pfe_cst_master_menu.m_file.m_close.ToolbarItemVisible = False			
	m_pfe_cst_master_menu.m_file.m_calendar.ToolbarItemVisible = False
ELSEIF ai_module = 3 THEN //Both
	m_pfe_cst_master_menu.m_file.m_meetings.toolbaritemvisible = False		
	m_pfe_cst_master_menu.m_file.m_actionitems.toolbaritemvisible = False			
	m_pfe_cst_master_menu.m_file.m_todolist.toolbaritemvisible = False		
	m_pfe_cst_master_menu.m_file.m_caqhfileimport.toolbaritemvisible = False
	m_pfe_cst_master_menu.m_system.m_applicationmapping.toolbaritemVisible = False
	m_pfe_cst_master_menu.m_system.m_setup.toolbaritemVisible = False	
	
	m_pfe_cst_master_menu.m_file.m_contractglobalsearch.ToolbarItemVisible = False
	m_pfe_cst_master_menu.m_file.m_calendar.ToolbarItemVisible = False
	m_pfe_cst_master_menu.m_help.m_gettingstarted.ToolbarItemVisible = False			
	//m_pfe_cst_master_menu.m_file.m_close.ToolbarItemVisible = False			
END IF
	
RETURN 1






end function

public function integer of_menu_security_email ();//====================================================================
//$<Function>: of_menu_security_email()
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Menu security for Email Manager
//$<Author>: (Appeon) Alfee 09.23.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:For BugA082102 
//====================================================================

IF NOT IsValid (m_pfe_cst_mail) THEN RETURN 0

//Display the Search toolbar only for IC + OutLook
IF NOT gb_contract_module AND gi_email_type = 1 THEN 
	m_pfe_cst_mail.m_email.m_new.toolbaritemvisible = False
	m_pfe_cst_mail.m_email.m_reply.toolbaritemvisible = False
	m_pfe_cst_mail.m_email.m_replytoall.toolbaritemvisible = False
	m_pfe_cst_mail.m_email.m_forward.toolbaritemvisible = False
	m_pfe_cst_mail.m_email.m_receive.toolbaritemvisible = False
	m_pfe_cst_mail.m_email.m_stopreceive.toolbaritemvisible = False
	m_pfe_cst_mail.m_email.m_checkindoc.toolbaritemvisible = False
	m_pfe_cst_mail.m_email.m_options.toolbaritemvisible = False
	m_pfe_cst_mail.m_email.m_emaillog.toolbaritemvisible = False
	m_pfe_cst_mail.m_email.m_importmsg.toolbaritemvisible = False
END IF

//---------Begin Added by (Appeon)Harry 03.18.2014 for V142 ISG-CLX--------
//Begin - Added By Mark Lee 02/17/2013
IF is_current_window_name ='w_contract'  Then
	If w_contract.tab_contract_details.selectedtab = 12 then		//Email Manager
		m_pfe_cst_mail.m_email.m_new.toolbaritemvisible = True
		m_pfe_cst_mail.m_email.m_reply.toolbaritemvisible = True		
		m_pfe_cst_mail.m_email.m_replytoall.toolbaritemvisible = True				
		m_pfe_cst_mail.m_email.m_forward.toolbaritemvisible = True	
		
		//			m_pfe_cst_mail.m_email.m_options.toolbaritemvisible = True
		m_pfe_cst_mail.m_email.m_emaillog.toolbaritemvisible = True
		m_pfe_cst_mail.m_email.m_importmsg.toolbaritemvisible = True		
		m_pfe_cst_mail.m_email.m_findemail.toolbaritemvisible = True				
		m_pfe_cst_mail.m_email.m_refresh.toolbaritemvisible = True			
		
		m_pfe_cst_mail.m_email.m_checkindoc.toolbaritemvisible = False
		m_pfe_cst_mail.m_email.m_receive.toolbaritemvisible = False
		m_pfe_cst_mail.m_email.m_stopreceive.toolbaritemvisible = False
		
		If gnv_data.of_getitem('icred_settings', 'receive_email', False) = '0' Then
			m_pfe_cst_mail.m_email.m_options.toolbaritemvisible = False
		Else
			m_pfe_cst_mail.m_email.m_options.toolbaritemvisible = True
		End If
	End If
End If
//End - Added By Mark Lee 02/17/2013
//---------End Added ------------------------------------------------------
RETURN 1
end function

public function integer of_showezmenu (boolean ab_show);// (Appeon)Harry 03.17.2014 - V142 ISG-CLX Copy from CLX12.0
ab_show = false
If ab_Show Then
	if this.windowstate <> minimized!  then
		dw_ezmenu.Visible = True
		IF Not dw_ezmenu.ib_Dock_Prevent Then st_vsplit.visible = True
		dw_ezmenu.x = this.Workspacex( )
		dw_ezmenu.y = this.workspacey( )
		//
		dw_ezmenu.height = this.workspaceheight() - dw_statusbar.height - 8 //Added by gavins 20130510
		st_vsplit.y = dw_ezmenu.y
		st_vsplit.Height =dw_ezmenu.height
		dw_statusbar.x= dw_ezmenu.x
		dw_statusbar.y = dw_ezmenu.y+ dw_ezmenu.height + 8
		dw_statusbar.width = this.workspaceWidth()
		//
		mdi_1.move( dw_ezmenu.x + dw_ezmenu.width + 12 ,  dw_ezmenu.y )
		mdi_1.resize(this.workspaceWidth() - dw_ezmenu.width - 12, dw_ezmenu.height  + 4 )
		dw_ezmenu.height = dw_ezmenu.height  - 4
	end if
Else
	if this.windowstate <> minimized!  then
		If dw_ezmenu.Visible Then
			dw_ezmenu.Visible = False
		End If	
		st_vsplit.Visible = False
		mdi_1.move(  this.Workspacex( ) , this.workspacey( )  )
		mdi_1.resize(this.workspaceWidth() ,  this.workspaceheight() - dw_statusbar.height  -  4 )//Added by gavins 20130510
		dw_statusbar.x = this.workspacex( )
		dw_statusbar.y =  mdi_1.y + mdi_1.height + 4
		dw_statusbar.width = this.workspaceWidth() 
	end if
End If
If IsValid( w_dashboard ) and this.windowstate <> minimized! Then
	w_dashboard.Event  ue_resize( )
End If

Return 0
end function

public subroutine of_showtoolbar (boolean ab_show);//====================================================================
// Function: of_ShowToolbar
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	ab_show
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	gavin		Date: 2013-03-12
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
// (Appeon)Harry 03.17.2014 - V142 ISG-CLX Copy from CLX12.0
//====================================================================
This.Toolbarvisible = ab_show
end subroutine

public subroutine of_refresh_ezmenu_enable ();// (Appeon)Harry 03.17.2014 - V142 ISG-CLX Copy from CLX12.0

If gb_show_EZMenu Then  dw_ezmenu.of_Refreshenabled( this.menuid )

end subroutine

public subroutine of_refresh_ezmenu_screen ();// (Appeon)Harry 03.17.2014 - V142 ISG-CLX Copy from CLX12.0
dw_ezmenu.of_set_screen()
end subroutine

public subroutine of_set_ezmenu_enabled (string as_parentmenuname, string as_menuname, boolean ab_enabled);//====================================================================
// Function: of_Set_Menu_enabled
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	as_menuname
// 	ab_enabled
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	gavin		Date: 2013-03-13
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
// (Appeon)Harry 03.17.2014 - V142 ISG-CLX Copy from CLX12.0
//====================================================================

If gb_show_EZMenu Then dw_ezmenu.of_SetEnabled( as_parentmenuname, as_menuname, ab_enabled )
end subroutine

public subroutine of_set_ezmenu_visible (string as_parentmenu, string as_menu, boolean ab_value);// (Appeon)Harry 03.17.2014 - V142 ISG-CLX Copy from CLX12.0
If gb_show_EZMenu Then dw_ezmenu.of_SetVisible( as_parentmenu, as_menu, ab_value )
end subroutine

public subroutine of_set_ezmenu_check (string as_parentmenu, string as_menu, boolean ab_value);// (Appeon)Harry 03.17.2014 - V142 ISG-CLX Copy from CLX12.0
If gb_show_EZMenu Then dw_ezmenu.of_Setchecked( as_parentmenu, as_menu, ab_value )
end subroutine

public subroutine of_set_ezmenu_text (string as_parentmenu, string as_menu, string as_text);// (Appeon)Harry 03.17.2014 - V142 ISG-CLX Copy from CLX12.0
If gb_show_EZMenu Then dw_ezmenu.of_SetText( as_parentmenu, as_menu, as_text )
end subroutine

public subroutine of_set_ezmenu_pic (string as_parentmenu, string as_menu, string as_pic);// (Appeon)Harry 03.17.2014 - V142 ISG-CLX Copy from CLX12.0
If gb_show_EZMenu Then dw_ezmenu.of_Setitemname( as_parentmenu, as_menu, as_pic )
end subroutine

public subroutine of_set_spitbar_visible (boolean ab_visible);// (Appeon)Harry 03.17.2014 - V142 ISG-CLX Copy from CLX12.0
st_vsplit.visible = ab_visible
end subroutine

public subroutine of_restore_toolbar_attr ();// (Appeon)Harry 03.17.2014 - V142 ISG-CLX Copy from CLX12.0
dw_ezmenu.of_restore_toolbar_attr( this.menuid)
end subroutine

public function integer wf_checkisvalidwin (boolean ab_closewin);// (Appeon)Harry 03.17.2014 - V142 ISG-CLX Copy from CLX12.0
Window		lw_Temp2,lw_Temp
long			ll_i, ll_count



For ll_i = 1 To UpperBound(gw_popup[])
	If Isvalid(gw_popup[ll_i])  Then
		If gw_popup[ll_i].classname() <> 'w_statusbar' Then 
			ll_count++
			If ab_closewin Then close( gw_popup[ll_i] )
		End If
	End If
Next

lw_Temp = w_mdi.GetFirstSheet( )

do 
	If isvalid( lw_temp ) then	
		lw_Temp2 = w_mdi.Getnextsheet( lw_Temp )
		
		If ab_closewin Then
			close( lw_temp )
		Else
			If lw_temp.classname( ) = 'w_contract'  And Not isvalid(gw_contract) Then 
			Else
				ll_count++
			End If
		End If
		lw_Temp = lw_Temp2
	End If
loop while isvalid( lw_temp )



Return ll_count
end function

public subroutine of_resize_statusbar ();//====================================================================
//$<Function>: of_resize_statusbar
//$<Arguments>:
// 	
//$<Return>:  (None)
//$<Description>: To adjust the position of column on statusbar
//$<Author>: (Appeon)Harry 04.03.2014 - new statusbar
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_process_width, ll_text_x, ll_database_x, ll_citrix_x, ll_UserID_x, ll_wspacewidth, ll_db_width
long ll_spac = 16
long ll_text_width, ll_citrix_width, ll_UserID_width
String ls_modify

//---------Begin Commented by (Appeon)Harry  04.22.2014 for V142 ISG-CLX--------
/*
if this.windowstate <> minimized!  then
	mdi_1.move(  this.Workspacex( ) , this.workspacey( )  )
	mdi_1.resize(this.workspaceWidth() ,  this.workspaceheight() - dw_statusbar.height )
	dw_statusbar.x = this.workspacex( )
	dw_statusbar.y =  mdi_1.y + mdi_1.height + 4
	dw_statusbar.width = this.workspaceWidth() 
end if
*/
//---------End Commented ------------------------------------------------------

ll_wspacewidth = this.workspaceWidth() 

choose case gs_dbtype
	case 'ASA'
	  	ll_db_width =  200
	case 'SQL'
		ll_db_width = 450	
end choose
ll_text_width = 1500
ll_citrix_width = 200
ll_UserID_width = 700

ll_text_x = ll_wspacewidth - ll_text_width 
ll_database_x = ll_wspacewidth - ll_text_width - ll_db_width - ll_spac
ll_citrix_x = ll_wspacewidth - ll_text_width - ll_db_width - ll_citrix_width - 2 * ll_spac
ll_UserID_x = ll_wspacewidth - ll_text_width - ll_db_width - ll_citrix_width - ll_UserID_width - 3 * ll_spac

ll_process_width = ll_wspacewidth - ll_text_width - ll_db_width - ll_citrix_width - ll_UserID_width - 5 * ll_spac

ls_modify = ""
ls_modify +=  "Text.width='" + string(ll_text_width) + "' Text.x='" + string(ll_text_x) + "' "
ls_modify +=  "Database.width='" + string(ll_db_width) + "' Database.x='" + string(ll_database_x) + "' "
ls_modify +=  "Citrix.width='" + string(ll_citrix_width) + "' Citrix.x='" + string(ll_citrix_x) + "' "
ls_modify +=  "UserID.width='" + string(ll_UserID_width) + "' UserID.x='" + string(ll_UserID_x) + "' "
ls_modify +=  "Process.width='" + string(ll_process_width) + "' "

dw_statusbar.modify( ls_modify) 
end subroutine

public function integer of_menu_security_contract_profile ();
//////////////////////////////////////////////////////////////////////
// $<function> of_menu_security_contract_profile
// $<arguments>
// $<returns> integer
// $<description> Set security for of_menu_security_contract_profile menu (Menu readonly security)
//////////////////////////////////////////////////////////////////////
// $<add> harry 08.31.2015 
// for Bug # 4694
//////////////////////////////////////////////////////////////////////

IF of_security_access( 6932 ) = 0 THEN
	m_pfe_cst_contract_profile.m_system.m_emailsignature.m_clientsettings.Visible = False
ELSE
	m_pfe_cst_contract_profile.m_system.m_emailsignature.m_clientsettings.Visible = True
END IF
		
IF of_security_access( 6932 ) = 0 And of_security_access( 6931 ) = 0   THEN //if both set to off hide upper level
	m_pfe_cst_contract_profile.m_system.m_emailsignature.Visible = False
ELSE
	m_pfe_cst_contract_profile.m_system.m_emailsignature.Visible = True
END IF

IF of_security_access( 6931 ) = 0 THEN //email
	m_pfe_cst_contract_profile.m_system.m_emailsignature.m_emailsignature2.Visible = False
	m_pfe_cst_contract_profile.m_system.m_emailsignature.m_personalaccount.Visible = False
	m_pfe_cst_contract_profile.m_system.m_newmailmessage.Visible = False
	m_pfe_cst_contract_profile.m_system.m_emailsignature.m_emailsentitems.visible = False 
	m_pfe_cst_contract_profile.m_system.m_emailsignature.m_emailsentitems.ToolbarItemVisible = False 		
ELSE
	m_pfe_cst_contract_profile.m_system.m_emailsignature.m_emailsignature2.Visible = True
	m_pfe_cst_contract_profile.m_system.m_emailsignature.m_personalaccount.Visible = True	
	m_pfe_cst_contract_profile.m_system.m_emailsignature.m_emailsentitems.visible = True 			
	m_pfe_cst_contract_profile.m_system.m_emailsignature.m_emailsentitems.ToolbarItemVisible = False						
END IF

return 1
end function

public function boolean of_check_provider_position (w_prac_data_1 aw_prac);//====================================================================
//$<Function>: of_check_provider_position
//$<Arguments>:
// 	value    w_prac_data_1    aw_prac
//$<Return>:  boolean  False:need to reopen provider window/True: do nothing.
//$<Description>: Some times tab_1.x is not correct after Clicking Provider in Home Screen 
//						(e.g.: move IE as soon as click  Provider in Home Screen). 
//						Only web version has this bug.
//$<Author>: (Appeon) long.zhang 06.07.2016 (Bug ID #5189 for Case # 00064308: Problems after weekend update)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

String ls_classname = ''
Long ll_x_ori = 0
ls_classname = aw_prac.Classname()
w_prac_data_1 lw_prac

If AppeonGetClientType() = "WEB" then	
	If  aw_prac.tab_1.x > 0 and &
		(gi_openscreen = 1  or ib_event_pfc_cst_practitioner) Then //add ib_event_pfc_cst_practitioner, Added by Appeon long.zhang 04.07.2017 (Question:  Issue # 5585 - Provider folder is blank, deformed or partially there, why is this occurring?)			
		Choose Case ls_classname
			Case 'w_prac_data_sk'
				lw_prac = Create w_prac_data_sk
			Case 'w_prac_data_intelliapp'
				lw_prac = Create w_prac_data_intelliapp
			Case 'w_prac_data_1'
				lw_prac = Create w_prac_data_1
			Case Else
				Return True
		End Choose
		
		If IsValid(lw_prac) Then
			ll_x_ori = lw_prac.tab_1.x
			Destroy lw_prac
			
			If aw_prac.tab_1.x = ll_x_ori Then
				ii_check_prac_position_time = 0
				Return True
			Else
				ii_check_prac_position_time++
				If ii_check_prac_position_time = 3 Then //Only check it for at most 2 times.
					Return True
				Else
					//Added by Appeon long.zhang 04.07.2017 (Question:  Issue # 5585 - Provider folder is blank, deformed or partially there, why is this occurring?)	
					If ib_event_pfc_cst_practitioner Then //called by Event pfc_cst_practitioner
						This.Post Event pfc_cst_practitioner()
					Else //called by Home Buttons.
						Post of_open_at_start_new(False) //Reopen this window (the same with the logic in w_home_buttons) 
					End If
					
					Close(aw_prac) //Close the window
					
					Return False
				End If
			End If
		End If
	End If
End If

Return True
end function

on w_mdi.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_pfe_cst_mdi_menu" then this.MenuID = create m_pfe_cst_mdi_menu
this.st_vsplit=create st_vsplit
this.dw_ezmenu=create dw_ezmenu
this.dw_statusbar=create dw_statusbar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_vsplit
this.Control[iCurrent+2]=this.dw_ezmenu
this.Control[iCurrent+3]=this.dw_statusbar
end on

on w_mdi.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_vsplit)
destroy(this.dw_ezmenu)
destroy(this.dw_statusbar)
end on

event activate;call super::activate;window lw_sheet //Added by Appeon long.zhang 08.04.2017

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-07
//$<comment> 03.15.2006 By: Cao YongWang
//$<reason> Performance tuning. 
//$<modification> Comment the following script since of_menu_security has already been  
//$<modification> called in Activate event of the ancestor w_master.
/*
of_menu_security( w_mdi.MenuName )
*/
//---------------------------- APPEON END ----------------------------

//w_mdi.of_module_check() //Comment by Appeon long.zhang 06.20.2017

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 08.04.2017
//<$>reason:Only refresh menu when no activesheet, Bug id 5673 - IE Freezes When Trying to Search Providers
lw_sheet = This.GetActivesheet()
If Not IsValid(lw_sheet) Then
	w_mdi.of_menu_security( w_mdi.MenuName )
End If
//------------------- APPEON END -------------------
end event

event open;call super::open;integer i
long ll_width
string ls_path
string ls_database
//---------Begin Added by (Appeon)Harry 03.17.2014 for V142 ISG-CLX--------
String		ls_Value
String		ls_ShowToolBar
String 	ls_ShowMainToolBar
long		ll_AppHandle
//---------End Added ------------------------------------------------------

n_cst_imaging lnv_imaging


//---------Begin Added by (Appeon)Harry 03.17.2014 for V142 ISG-CLX--------
ib_ReLogin = gf_get_relogin_status( )//added by gavins 20130515
//debugbreak()
ib_EZMen_First = True
If Not gb_contract_version Then //(Appeon)Harry 10.16.2014 - BugH091202  restore
	gb_show_EZMenu = False
Else
	ls_Value = gnv_user_option.of_Get_Option_Value( dw_ezmenu.of_get_user( ), 'EZMENU_SHOW' ) //added by gavins 20130312
	If IsNull( ls_Value ) Then ls_Value = ''
	If ls_Value = '' Then 
		//gb_show_EZMenu = True
		gb_show_EZMenu = False  //(Appeon)Harry 10.16.2014 - BugH091202
	Else
		gb_show_EZMenu = ( ls_Value = '1' )
	End If
End If
//---------End Added ------------------------------------------------------

w_mdi.of_Setup_Security()
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-07
//$<comment> 03.15.2006 By: Cao YongWang
//$<reason> Performance tuning. 
//$<modification> Comment the following script since of_menu_security has already been  
//$<modification> called in the Open event of the ancestor w_master.
/*
w_mdi.of_menu_security( w_mdi.MenuName )
*/
//---------------------------- APPEON END ----------------------------
w_mdi.of_module_check()

//\/maha app101705 to allow debug mode to function (set in the inifile aprox 60)
ls_path = ProfileString(gs_IniFilePathName, "Setup", "refreshrate", "None")
if isnull(ls_path) or ls_path = "None" then
	i = 1 
else
	i = integer(ls_path)
end if
//\maha

///////////////////////////////////////////////////////////////////////////////
// set the status bar
/////////////////////////////////////////////////////////////////////////////// 
// mskinner 1 aug 2005 - begin
If Not ib_ReLogin Then //(Appeon)Harry 03.17.2014 - V142 ISG-CLX
	of_SetStatusBar(TRUE)
	//---------Begin Modified by (Appeon)Harry 03.17.2014 for V142 ISG-CLX--------
	/*
	//---------Begin Added by (Appeon)Harry 02.19.2014 for Bug # 3898--------
	inv_statusbar.of_Register("Process", "text", "Ready" , 2000) //Added By Ken.Guo 2010-08-19.
	inv_statusbar.of_modify("Process.Color = ~"33554432~tIf ( Process = 'Ready' , RGB(0,0,0),RGB(255,0,0))~"")
	//---------End Added ------------------------------------------------------
	*/
	inv_statusbar.of_Set_statusbar_dw( dw_statusbar )
	inv_statusbar.of_Register("Process", "text", "Ready" , 1800) //Added By Ken.Guo 2010-08-19.    1600
	inv_statusbar.of_modify("Process.Color=0" )
	//---------End Modfiied ------------------------------------------------------
	inv_statusbar.of_Register("UserID", "text", "Welcome "+gs_user_id , 700) //Ken.Guo 11/23/2007
	inv_statusbar.of_SetMem(False)  //Start Code Change ----06.27.2012 #V12 maha -  removed counter.  Is available from the Support utilities.
	choose case gs_dbtype
		case 'ASA'
		  ls_database = 'ASA' 
		  ll_width =  200
		case 'SQL'
			ls_database = 'MS SQL Server' 
			ll_width = 450
			
	end choose
	
	string ls_citrix
	
	//Start Code Change ---- 12.06.2006 #V7 maha
	if upper(appeongetclienttype())  = "WEB" then
		ls_citrix = 'IC Web'
	else
		if gi_citrix = 1 then
			ls_citrix = 'Citrix'
		else 
			ls_citrix = 'Desktop'
		end if 
	end if
	//End Code Change---12.06.2006
	
	inv_statusbar.of_Register("Citrix", "text", ls_citrix , 200)
	inv_statusbar.of_Register("Database", "text", space(1)+ 'DB:' + ls_database , ll_width)
	inv_statusbar.of_SetMemThreshold(1048576 * 60 )
	inv_statusbar.of_setrefreshrate( i )
	
	//---------Begin Modified by (Appeon)Harry 03.17.2014 for V142 ISG-CLX--------
	//inv_statusbar.of_Register("Text", "text", gnv_app.of_getversion( ) , 1500)
	inv_statusbar.of_Register("Text", "text", gnv_app.of_getversion( ) , 3500) //1500 modify by gavins 20130510
	//---------End Modfiied ------------------------------------------------------
	
	//Register imaging OCX - 10.12.2006 By: Zhang XingRen
	lnv_imaging.of_registry_ocx()
	//Determine current image OCX - Alfee 05.19.2008
	lnv_imaging.of_get_imageocx()
	
	//------------------- APPEON BEGIN -------------------
	//$<add> Evan 12.24.2009
	//$<reason> V10.1 - NPDB QRXS
	n_appeon_download lnv_download
	lnv_download.of_DownloadQrxsJar()
	//------------------- APPEON END ---------------------
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$< Add  > 2008-06-11 By: Scofield
	//$<Reason> Add System Hot Key.
	//if AppeonGetClientType() = "PB" then
	if AppeonGetClientType() = "PB" and gi_dev_mode	> 0 then //alfee 04.16.2009
		il_AtomID = GlobalAddAtom(String(Handle(GetApplication())))
		RegisterHotKey(Handle(This),il_AtomID,0,111 + 11)			//F11
	end if
	//---------------------------- APPEON END ----------------------------
End If

//---------Begin Added by (Appeon)Harry 03.17.2014 for V142 ISG-CLX--------
If gb_show_EZMenu Then
	ls_ShowToolBar = gnv_user_option.of_Get_Option_value( dw_ezmenu.of_get_user( ), 'EZMENU_SHOWTOOLBAR' )
	If IsNull( ls_ShowToolBar ) Then ls_ShowToolBar = ''
	If ls_ShowToolBar= '' Or ls_ShowToolBar = '1' Then
		of_ShowToolbar( True )
	Else
		of_ShowToolbar( False )
	End If
	ll_width = Long( gnv_user_option.of_get_option_value( gs_user_id, "EZMENU_VERTICALSPLITBAR_LOCATION"  ) )
	If ll_width = 0 Then ll_width = 1019
	If ll_width > 0 Then st_vsplit.event ue_restore_vsplitbar_location( ll_width )
	ls_value = gnv_user_option.of_get_option_value(gs_user_id, "EZMENU_DOCK_STATUS" )
	If ls_value = '0' Then 
		dw_ezmenu.event ue_dock( '0' )
	Else
		dw_ezmenu.event ue_dock( '1' )
	End If
	
	//Start Code Change ----07.28.2014 #V14.2 maha
	if this.of_security_access( 6985) = 0 then
		dw_ezmenu.object.t_painter.visible = false
	end if
	//End Code Change ----07.28.2014
	
Else
 	//dw_ezmenu.of_set_menu_quick(  This.MenuID )
	 If gb_contract_version Then dw_ezmenu.of_set_menu_quick(  This.MenuID ) //alfee 06.24.2014
End If

If ib_ReLogin Then	
	of_ShowEZMenu(  gb_show_EZMenu )
End If
//---------End Added ------------------------------------------------------

end event

event pfc_postopen;call super::pfc_postopen;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : w_mdi::pfc_postopen
//==================================================================================================================
//  Purpose   	: set up xp menu styes
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael Skinner  Wednesday 14 December 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

string ls_height

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 12.07.2006 By: Davis
//$<reason> The To Do List will display on the MDI Frame after the 
//$<reason> user logs into the system. 

//IF gb_ToDoList THEN
if gb_OpenToDoList then //12/7/2007 By Jervis
	//IF of_security_access( 5850 ) > 0 THEN
	IF of_security_access( 5850 ) > 0 and gb_DocQuickView = False THEN  //(Appeon)Alfee 06.27.2013 - V141 ISG-CLX		
		OpenSheet(w_todolist, w_mdi, 4, original!)
	END IF
END IF
//---------------------------- APPEON END ----------------------------

//---------Begin Modified by (Appeon)Harry 03.17.2014 for V142 ISG-CLX--------
/*
//---------Begin Added by (Appeon)Alfee 06.27.2013 for V141 ISG-CLX--------
If isvalid(inv_statusbar) Then //Added if statements By Ken.Guo 2011-03-28
	inv_statusbar.of_modify("Process.Font.Weight='700' Process.Color = ~"33554432~tIf ( Process = 'Ready' , RGB(0,0,0),RGB(255,0,0))~"")
	inv_statusbar.of_modify("Process.Font.Weight=~"700~tIf ( Process  = 'Ready' , 400, 700)~"")
	
	inv_statusbar.of_modify("Process.Height=56 UserID.Height=56 Citrix.Height=56 Database.Height=56  Text.Height=56 pfc_mem.Height=56 ") //add by gavin 2012-01-11 by gavins 20120710
	inv_statusbar.of_modify("Process.Border=5 UserID.Border=5 Citrix.Border=5 Database.Border=5  Text.Border=5  ")
End If
//---------End Added ------------------------------------------------------------------
*/
If Not ib_ReLogin Then
	If isvalid(inv_statusbar) Then //Added if statements By Ken.Guo 2011-03-28
		ls_height = '58' 
		inv_statusbar.of_modify("Process.Height=" + ls_height + " UserID.Height="+ls_height+" Citrix.Height="+ls_height+" Database.Height="+ls_height+"  Text.Height="+ls_height+" pfc_mem.Height="+ls_height) //add by gavin 2012-01-11
		inv_statusbar.of_modify("Process.Border=5 UserID.Border=5 Citrix.Border=5 Database.Border=5  Text.Border=5  ")
	End If
Else
	If isvalid(inv_statusbar) Then inv_statusbar.of_modify( "UserID", "Welcome "+gs_user_id )
End If
//---------End Modfiied ------------------------------------------------------

This.of_resize_statusbar()  //(Appeon)Harry 04.03.2014 - new statusbar

//w_MDI.event ue_RefreshEZMenu( )  //Start Code Change ----07.25.2014 #V14.2 maha - added



Timer(1) //Added by Ken.Guo 08.26.2008 
end event

event timer;call super::timer;//////////////////////////////////////////////////////////////////////
// $<event>timerw_mdi()
// $<arguments>(None)
// $<returns> long
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 08.26.2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

integer li_session_refresh_time  //Unit: Minute
Integer		li_serti, li_approve   //(Appeon)Alfee 06.27.2013 - V141 ISG-CLX

il_time_seq++  //Second
If il_time_seq >= 7200 Then il_time_seq = 1

//Session Update
li_session_refresh_time = gnv_session.ii_session_refresh_frequency 
If li_session_refresh_time = 0 Then li_session_refresh_time = 3
If Mod(il_time_seq,li_session_refresh_time*60) = 0 Then
	gnv_session.of_update_current_session()
End If

//Dashboard Update

//---------Begin Added by (Appeon)Alfee 06.27.2013 for V141 ISG-CLX--------
IF gb_contract_module THEN
	li_serti =  Integer( gnv_data.of_GetItem( 'security_users', 'refresh_sertifi_time', 'user_id = "' + gs_user_id + '"' ) )
	li_approve = Integer(  gnv_data.of_GetItem( 'security_users', 'refresh_approve_time', 'user_id = "' + gs_user_id + '"' ) )
	// Refresh Document Signature Data        
	If li_serti <> 0  Then
		If Mod( il_time_seq, li_serti * 60 ) = 0 Then
			If gnv_data.of_getitem( 'icred_settings', 'esign', False) = '1' Then
				gnv_sertifi.of_refresh_sertifi_status()
				//---------Begin Added by (Appeon)Harry 03.17.2014 for V142 ISG-CLX--------
				gnv_echosign.of_refresh_sertifi_status() //Added By Jay Chen 10-18-2013
				//---------End Added ------------------------------------------------------
				
				//---------Begin Added by (Appeon)Harry 07.11.2016 for docusign--------
				gnv_docusign.ib_ping_server = false //Added By Jay Chen 07-24-2014
				gnv_docusign.of_refresh_sertifi_status() //Added By Jay Chen 04-15-2014
				gnv_docusign.ib_ping_server = true
				//---------End Added ------------------------------------------------------
			End If	
		End If
	End If
	//Refresh Document Approval Data 
	If li_approve <> 0 Then
		If Mod( il_time_seq, li_approve * 60 ) = 0  Then
			gnv_webapprove.of_refresh_status( )
		End If
	End If
END IF
//---------End Added ------------------------------------------------------------------
end event

event close;call super::close;//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-06-11 By: Scofield
//$<Reason> Unregister Hot Key.
//if AppeonGetClientType() = "PB" then
if AppeonGetClientType() = "PB" and gi_dev_mode	> 0 then //alfee 04.16.2009	
	UnregisterHotKey(Handle(This),il_AtomID)
	GlobalDeleteAtom(il_AtomID)
end if
//---------------------------- APPEON END ----------------------------

//---------Begin Added by (Appeon)Harry 03.17.2014 for V142 ISG-CLX--------
gnv_user_option.of_save( )//added by gavins 20130419
//---------End Added ------------------------------------------------------

halt close //alfee 06.25.2009
end event

event resize;call super::resize;this.setredraw( false)   //Start Code Change ----12.03.2015 #V15 maha
If isvalid(w_dashboard) Then
	w_dashboard.Post Event ue_resize()
End If

//---------Begin Added by (Appeon)Harry 03.17.2014 for V142 ISG-CLX--------
//added by gavins 20130304
of_ShowEZMenu(  gb_show_EZMenu )
//---------End Added ------------------------------------------------------

This.of_resize_statusbar()  //(Appeon)Harry 04.03.2014 - new statusbar
this.setredraw( true)  //Start Code Change ----12.03.2015 #V15 maha
end event

event closequery;//****************************[Not Extend Ancestor Script]****************************//

//BEGIN---Add by Evan 10/29/2008
long ll_Return

if IsValid(w_contract) then
	w_contract.ib_IsMDIClose = true
	Close(w_contract)
	if IsValid(w_contract) then
		w_contract.ib_IsMDIClose = false
		Return 1
	end if
end if

ll_Return = Super::Event CloseQuery()

if ll_Return <> 1 then this.Hide() //Add by Evan 02/15/2011

//---------Begin Added by (Appeon)Harry 03.17.2014 for V142 ISG-CLX--------
long ll_i
For ll_i = 1 To UpperBound(gw_popup[])//added by gavins 20130515
	If Isvalid(gw_popup[ll_i])  Then
		If gw_popup[ll_i].classname() <> 'w_statusbar' Then 
		 close( gw_popup[ll_i] )
		End If
	End If
Next
//---------End Added ------------------------------------------------------

Return ll_Return
//END---Add by Evan 10/29/2008
end event

event pfc_minimizeall;
//////////////////////////////////////////////////////////////////////
// $<add> 12/22/2008 by Evan
//////////////////////////////////////////////////////////////////////

long ll_Handle
window lw_sheet
constant long WM_SYSCOMMAND = 274
constant long SC_MINIMIZE   = 61472

lw_sheet = w_mdi.GetFirstSheet()

do while IsValid(lw_sheet)
	if lw_sheet.ClassName() <> "w_dashboard" then   
		//---------Begin Modified by (Appeon)Stephen 12.06.2013 for Healh Partner's workflow/IE issue - Windows Event Log--------
//		//------------------- APPEON BEGIN -------------------
//		//$<add>Kater 03.15.2011
//		//$<reason>Srceen issue
//		ll_Handle = Handle(lw_sheet)
//		SendMessage(ll_Handle, WM_SYSCOMMAND, SC_MINIMIZE, 0)
//		//------------------- APPEON END ---------------------
//		lw_sheet.WindowState = Minimized!
   		
		lw_sheet.WindowState = Minimized!
		if lw_sheet.WindowState <> Minimized! then
			//------------------- APPEON BEGIN -------------------
			//$<add>Kater 03.15.2011
			//$<reason>Srceen issue
			ll_Handle = Handle(lw_sheet)
			SendMessage(ll_Handle, WM_SYSCOMMAND, SC_MINIMIZE, 0)
			//------------------- APPEON END ---------------------
		end if	
		//---------End Modfiied ------------------------------------------------------
	end if
	lw_sheet = w_mdi.GetNextSheet(lw_sheet)
loop

Return 1
end event

event pfc_preopen;call super::pfc_preopen; //Added by (Appeon)Alfee 06.27.2013 - V141 ISG-CLX
If gb_DocQuickView Then This.Visible = False //Added By Ken.Guo 2010-09-07.

 //Start Code Change ----12.22.2015 #V15 maha
//this.mdi_1.backcolor = 255

//this.mdi_1.backcolor = 16777215
this.mdi_1.backcolor = rgb(243,243,243)  //Start Code Change ----01.07.2016 #V15 maha - grey

//this.SetToolbar(1, TRUE, AlignAtLeft!) //Start Code Change ----01.15.2016 #V15 maha - left side
//app_filler.toolbartext  =false

end event

type st_vsplit from statictext within w_mdi
event ue_lbuttondown pbm_lbuttondown
event ue_lbuttonup pbm_lbuttonup
event ue_mousemove pbm_mousemove
event ue_restore_vsplitbar_location ( integer ai_x )
integer x = 1019
integer width = 18
integer height = 1724
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 8421504
boolean focusrectangle = false
end type

event ue_lbuttondown;// (Appeon)Harry 03.17.2014 - V142 ISG-CLX Copy from CLX12.0
This.backcolor = 12250607
ib_Drag = True

end event

event ue_lbuttonup;// (Appeon)Harry 03.17.2014 - V142 ISG-CLX Copy from CLX12.0
Long		ll_Width, ll_TempW

ib_Drag = False
if  dw_ezmenu.Width + ii_offsetX > il_Original_EZMenuWidth then
	ll_Width = il_Original_EZMenuWidth
Else
	ll_Width =  dw_ezmenu.Width + ii_offsetX
end if	
if dw_ezmenu.Width + ii_offsetX < 120 Then
	ll_Width = 120
End If

ll_TempW = ll_Width + dw_ezmenu.x
If ll_TempW < 730 Then ll_TempW = 730

dw_ezmenu.modify( "p_titlebar.width = " + string ( ll_TempW - 8 ) +" t_title.width="+ string( ll_TempW - ( 1019 - 516 ) )+ &
	" items.width = " + string( ll_TempW - ( 1019 - 690 ) ) + " itempic.width = " + string( ll_TempW - ( 1019 - 930 ) ) + " l_split1.x2 = " + &
	string( ll_TempW - ( 1019 - 882 ) ) + " l_split2.X2 = " + string( ll_TempW - ( 1019 - 882 ) ) + " t_painter.x = " + string( ll_TempW - ( 1019 - 654 ) ) + &
	" t_refresh.x = " + string( ll_TempW - ( 1019 - 745 ) ) + " t_contract.x = " + string ( ll_TempW - ( 1019 - 846 ) ) )


 dw_ezmenu.width = ll_Width
dw_ezmenu.ii_Width = ll_Width	

this.x=dw_ezmenu.x + dw_ezmenu.width

this.SetPosition(ToTop!)
this.backcolor = 78682240


dw_ezmenu.of_Resizemdi( )
//mdi_1.move( dw_ezmenu.x + dw_ezmenu.width + 12 ,  dw_ezmenu.y )
//mdi_1.resize(parent.workspaceWidth() - dw_ezmenu.width - 12, dw_ezmenu.height )

ii_LastX = This.X

gnv_user_option.of_Set_option_value(gs_user_id, "EZMENU_VERTICALSPLITBAR_LOCATION", string( ii_LastX ) )



end event

event ue_mousemove;// (Appeon)Harry 03.17.2014 - V142 ISG-CLX Copy from CLX12.0

If Not KeyDown(keyLeftButton!) Then
	Return
End If

If ib_Drag Then
	
	If This.X + xpos > il_Original_EZMenuWidth Then 
		This.X = il_Original_EZMenuWidth
	Else
		This.X = This.X + xpos
	End If
	ii_offsetX =  This.X - ii_LastX
End If
end event

event ue_restore_vsplitbar_location(integer ai_x);// (Appeon)Harry 03.17.2014 - V142 ISG-CLX Copy from CLX12.0
Long		ll_x

ll_X = this.x

If dw_ezmenu.ib_dock_prevent then ll_x = dw_ezmenu.x + dw_ezmenu.Width 


ii_offsetX = ai_x - ll_X

event ue_lbuttonup( 0, 0 , 0 )
end event

event constructor;// (Appeon)Harry 03.17.2014 - V142 ISG-CLX Copy from CLX12.0
this.SetPosition(ToTop!)
this.backcolor = 78682240
il_Original_EZMenuWidth = dw_ezmenu.width * 3
ii_LastX = This.X
end event

event getfocus;// (Appeon)Harry 03.17.2014 - V142 ISG-CLX Copy from CLX12.0
window 	lw_parent

//Check for microhelp requirements.
If gnv_app.of_GetMicrohelp() Then
	If IsValid(w_mdi) Then
		w_mdi.Dynamic Event pfc_ControlGotFocus (this)
	End If
End If

end event

type dw_ezmenu from uo_listbar within w_mdi
integer height = 1724
integer taborder = 10
end type

type dw_statusbar from uo_statusbar within w_mdi
integer x = 5
integer y = 1728
integer width = 4667
integer height = 80
integer taborder = 20
string dataobject = "d_mdi_statusbar_ext"
end type

