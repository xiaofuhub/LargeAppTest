$PBExportHeader$app_filler.sra
forward
global type app_filler from application
end type
global n_tr sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global variables

CONSTANT STRING SUPER_MASTER_PASSWORD = "4ISG2login"  //Start Code Change ----12.29.2008 #V92 maha - changed from intellimaster
String	gs_DefDirName = "IntelliCred" //Evan 08.31.2010
String gs_temp_path  //stephen 02.18.2014
string  gs_temp_pdf = "C:\IntelliCred\PDFPrinter\temp\SampleOut.PDF" //alfee 03.27.2014

Boolean gb_se_version = False
Boolean gb_sk_ver = False		//maha 06.15.2010
Boolean gb_webview = False //maha  08.25.2011
Boolean gb_contract_version = False
Boolean gb_contract_module = False //On or off - Alfee 05.12.2008
Boolean gb_autoresize		//Add by Gary
Boolean gb_PreloadCTX = False //Add by Evan 11/12/2008
Boolean gb_workflow = False
Boolean gb_agreement_manager = False
Boolean gb_ToDoList = True  //Start Code Change ----10.28.2009 #V10 maha - changed to true 
Boolean gb_OpenToDoList = false	//12/10/2007 By Jervis
Boolean gb_autologin //Ken.Guo 11/19/2007
Boolean gb_upgrade_failed = FALSE //for DB Upgrade - Alfee 01.30.2008
Boolean gb_write_log = FALSE
boolean gb_IsAutoExport = false //Added by Evan 03.12.2009.
boolean gb_IsAutoImport = false //Added by Evan 03.12.2009.
boolean gb_IsAutoExpImp = false //Added by Evan 03.12.2009.
boolean gb_AutoSchedule= false //added by Nova 12.29.2009.
boolean gb_AutoDwnReg = true //Auto down&register plugins for Web - (v12.1 web component) Alfee 04.21.2012 
boolean gb_use_prac_toolbar = false //maha 10.24.2012
boolean gb_notes_at_top = true //maha 12.21.2012
boolean gb_IsOS64 = False //alfee 03.26.2014
boolean gb_home_icon = true //maha 07.10.2014
boolean gb_preserve_exp_appt_verif = false //07.22.2015
boolean gb_note_readonly = false  //maha 02.11.2016
boolean gb_cvo_user = false //maha 02.07.2017 - for session bypass
boolean gb_cvo_combo = false //maha 02.07.2017 - for session bypass
boolean gb_priv_lookup_update = false  //maha - 04.27.2017 - to force re-retrieve in priv templates

Int gi_seq //Ken.Guo 2007-10-26 for generate Client ID for print letter 
Integer gi_action_item_menus
Integer gi_burn_annos = 0
Integer gi_auto_search = 0
Integer gi_intelliapp_type = 0
Integer gi_app_ids[]
Integer gi_default_h = 2152
Integer gi_default_w = 3314
Integer gi_default_x = 352
Integer gi_default_y = 0
Integer gi_parent_facility
integer gi_facil_change
integer gi_cache_set
integer gi_server_id
integer gi_test_mode
integer gi_export_on
integer gi_ireport_on
integer gi_iapp_on
integer gi_test_database = 0
integer gi_scan_format = 0
integer gi_priv_mod
integer gi_case_review
integer gi_imaging
integer gi_temp_switch = 0
integer gi_dept_security
integer gi_citrix = 0
integer gi_support_pw_on
integer gi_copy_letters //maha app100705
integer gi_yield = 0 
integer gi_imageocx = 1 //1- Imaging 360; 2- new Image OCX - Alfee 05.19.2008
integer gi_wdhlink, gi_wdhlink_f //Alfee 06.27.2008
integer gi_prod_setting //Alfee 07.14.2008
integer gi_email_type //maha 10.08.08
integer gi_dev_mode = 0 //Alfee 04.16.2009 
integer gi_comm_return_facil_bypass //maha 03.05.2010
integer gi_prac_tab  //maha 01.01.2011
integer gi_print_dialog //maha 09.30.2011 - to show printer dialog box.
Integer gi_user_readonly //Added by Ken.Guo 09.10.2008.
Integer gi_opendashboard //Added by Ken.Guo 09.10.2008.
Integer Gi_MSFax_Number		//Ken.Guo 05/06/2008
integer gi_contract_view_id
integer gi_openscreen   //maha 08.21.2012
integer gi_encryption_val = -1 //alfee 04.08.2013 
integer gi_pw_expdays = -1 //alfee 04.10.2013
integer gi_role_id  //maha 06.14.2016
integer gi_zoom  //maha 07.13.2017

Long gl_prac_id
Long gl_prac_ids[]
Long gl_data_view_id = 1
Long gl_facility_id
Long gl_facility_ids[]
Long gl_committee_id 
long gl_bg_color //maha 05.24.10
long gl_dw_color  //maha 05.24.10
long gl_bg_color2 //maha 01.07.2016
long gl_button_bar_color //maha 02.16.2016
long gl_req_yellow = 11534335 // rgb(245,245,175)   //maha 01.20.2016
long gl_rec_id[] //Michael 11.08.2011
long gl_Company_id
long gl_cache_id
long gl_maha_test = 0
long gl_locations
long gl_export_rows_count  //maha 05.06.2015 
long gl_prac_de_appt_id = 0 //maha 07.15.2015 - for attest quest

String gs_app_image_path 
String gs_version = "10.2"
String gs_build = "1"
String gs_names[]
String gs_cust_type ="Regular"
string gs_dir_path
string gs_user_version
string gs_word_user //Alfee 07.08.2008
String gs_param
String gs_passstring[]  //maha 07.02.2015
String gs_password
String gs_user_id
String gs_role
string gs_fil_screen
string gs_fil_batch
string gs_fil_status
string gs_odbc
string gs_letter_path //maha app100705
string gs_merge_path //maha app100705
string gs_save_path //maha 012306
string gs_application_path // mbs 08 feb 2005
string gs_dllocx_path //alfee 01.07.2010
string gs_mdi_title //Alfee 01.16.2008
string gs_ssnnpi //maha added for ssn seach passing on the create of a new prac
String gs_dbtype = "ASA"
String gs_image_flag
string gs_current_path
String gs_word_version
String	gs_IniFilePathName
string gs_dir_x = "L"
string gs_dir_y = "U"
String	gs_CacheName,gs_CacheType,gs_CacheSet
String Gs_MSFax_ServerName //Ken.Guo 05/06/2008
String gs_current_version = '161' //for DB Upgrade,keep it updated
String gs_current_version_patch = '001' //for DB Upgrade, keep it updated 
String gs_session_id //Added by Ken.Guo 08.26.2008. Current session ID.
String gs_client_ip //Added by Ken.Guo 08.26.2008.
String Gs_Current_Directory
string gs_app_stat_facility_label //Added by Evan 05.12.2009.
string gs_app_stat_app_label      //Added by Evan 05.12.2009.
string gs_web_component_url = 'http://pre.intellisoftgroup.com/' //Downlad URL for plugins  - (v12.1 web component) Alfee 04.21.2012 
string gs_CommandLine //(v12.1 web component) Alfee 05.02.2012 
string gs_ireport_audit_from = "MAN"  //maha 06.07.2016
String gs_idpname //Added by Appeon long.zhang 10.20.2016 (v15.3 SSO Support with SAML)
String gs_verifycode//Added by Appeon long.zhang 10.20.2016 (v15.3 SSO Support with SAML)

DateTime gdt_screen_cache
DateTime gdt_lookup_cache
DateTime gdt_screen_obj_cache

appeon_nvo_db_update gnv_appeondb   // Define the variable for the approach of "use an object to pre-select data" 
datastore gds_settings
datastore gds_lookup   //$<add> 2006-04-10 By: owen chen
datastore gds_contract_screen
n_cst_appmanager   gnv_app
n_cst_appeondll	gnv_appeondll  // Define the variable for storing Appeon label related functions.  Applies to Web application only.
n_cst_globaldata	gnv_data
n_cst_dashboard_data gnv_dashboard_data //Added by Ken.Guo 08.06.2008
n_cst_session gnv_session //Added by Ken.Guo 08.26.2008.
n_cst_reg_control gnv_reg_ocx //Added by Ken.Guo 11.06.2008.
n_cst_backcolor_settings gnv_win_backcolor //Added by Evan.Cai 11.24.2008.
n_cst_datawindow gnv_dw //Added by Evan 05.11.2010
n_logservice gnv_logservice //Alfee 01.30.2008
n_tr CC_tansobject
w_contract gw_contract		// Add by Davis for global search
w_prac_data_1 gw_prac_data  //maha 03.05.2013


//---------Begin Added by (Appeon)Alfee 06.06.2013 for V141 ISG-CLX--------
Boolean gb_AutoExport //Added by Scofield on 2010-05-18
Boolean gb_DocQuickView = False //Added By Ken.Guo 2010-09-07.
Boolean gb_EnableSetPosition = TRUE //added by gavins 20120528
Boolean gb_IsDocMode //Added by Scofield on 2009-07-17
Boolean gb_open_from_template = False //Added By Ken.Guo 2009-08-27.
Boolean gb_openwith_showtips = True //Added By Ken.Guo 2011-04-13.
boolean gb_recordlog = false // 03/08/12 Added By mark for no prompt message with batch import files 
Boolean gb_restore_contract_state= false //Add by Jervis on 2009-9-10
Boolean gb_ShowEmailErrorMessage = True //Added By Ken.Guo 2010-11-25.
Boolean gb_ShowFullScreenButton = True //Added By Ken.Guo 2010-09-03.
boolean gb_use_opmode = true  //added by jervis 10.11.2011

integer gi_snaptogrid_x = 1
integer gi_snaptogrid_y = 1

Long gl_custom_colors[],gl_custom_colors_org[] //Added by Ken.Guo on 2009-01-06
long gl_MoveToCtxID //Added by Scofield on 2009-03-05
long gl_MovetoDocID  //Added by Ken.Guo 14.17.2009 
long gl_SearchTab_View_id //Added by Scofield on 2009-04-29
Long gl_unread_email_cnt = 0

n_cst_debug gnv_debug //Added by Ken.Guo 12.18.2008. Only for Debugging.
n_cst_xml_message gnv_message //Added By Ken.Guo 2010-11-12; Replace the n_cst_message - (Appeon)Alfee 07.26.2013 - V141 ISG-CLX.
n_cst_rights gnv_rights //Added By Ken.Guo 2011-07-15. 
n_cst_sertifi gnv_sertifi //Added By Ken.Guo 2011-05-30. 
n_cst_shell gnv_shell //Added By Ken.Guo 2010-05-24.
n_cst_statusbar_info gnv_Status_Info //Added By Ken.Guo 2010-08-19.
n_cst_string gnv_string //Added By Ken.Guo 12/31/2011. 
n_cst_user_option gnv_user_option //add by gavins 20120215
n_cst_webapprove gnv_webapprove //Added By Ken.Guo 11/23/2011. 
n_cst_workflow_prompt gnv_workflow_prompt //Added By Ken.Guo 2010-06-28.

OleObject gole_word_instance //Added By Ken.Guo 05/14/2012. opening a word processing to improve performance.

str_email_info gstr_email_info //Added By Ken.Guo 2009-10-13.  

String gs_CurAddresser //Added by Scofield on 2009-05-31
String gs_default_group_name = 'Default Group Email Alarm Template' //Added By Ken.Guo 2010-08-19.
string gs_errmsg = ''// 03/08/12 Added By mark for no prompt message with batch import files  
String gs_imageview_version = '5.0' //Added By Ken.Guo 2010-09-03.
string gs_IniWindowState //Add by jervis on 2009-9-10
String gs_MoveToTabNo //Added by Scofield on 2009-03-05

String gs_select_dir_path //Added by Ken.Guo 03.10.2009
string gs_sqlserver_version //Added By Ken.Guo 02/22/2012. 
String gs_excel_version
boolean gb_outlook_64bit = false  //add by stephen 04.28.2014

window gw_popup[] //w_popup - (Appeon)Alfee 01.21.2014 - V142 ISG-CLX
window gw_response[] //alfee 12.01.2014 for bug 4326
//---------End Added ------------------------------------------------------

//---------Begin Added by (Appeon)Alfee 01.21.2014 for V142 ISG-CLX -------------------
Boolean gb_autozoom		
Boolean gb_cut_autozoom
Boolean gb_AutoReport 	
Boolean gb_show_EZMenu=True 

String	gs_word_version_num
String gs_left_title_sign = ' >| '			
String gs_right_title_sign = ' |< '			
String gs_copyright	=	 '1998-2017'		
String gs_esigntype //sertifi,echosign  

n_cst_echosign gnv_echosign 
n_cst_tracking	gnv_tracking	
n_cst_word_utility	gnv_word_utility
//---------End Added ----------------------------------------------------------------------------

//---------Begin Added by (Appeon)Harry 05.06.2014 for V142 ISG-CLX--------
long		gl_SearchTab_document_View //Added By Jay Chen 04-03-2014	
//---------End Added ------------------------------------------------------

Boolean gb_home_visible = true //(Appeon)Harry 12.07.2015 - for Bug # 4867

n_cst_docusign gnv_docusign   //(Appeon)Harry 07.08.2016
boolean		gb_message = false	 //(Appeon)Harry 07.08.2016

Boolean gb_ad_login, gb_ad_command_off //Added By Ken.Guo 2016-06-24//Copied from CLX by Appeon long.zhang 11.15.2016 (v15.3 AD Authentication)
end variables
global type app_filler from application
string appname = "app_filler"
event open_oldcode ( )
end type
global app_filler app_filler

type prototypes
function boolean   CopyFileA (ref string cfrom, ref string cto, boolean flag) library "kernel32.dll" alias for "CopyFileA;Ansi"
FUNCTION boolean BringWindowToTop(ulong w_handle) LIBRARY "User32.dll"
FUNCTION ulong FindWindowA(ulong classname,string windowname) LIBRARY "User32.dll" alias for "FindWindowA;Ansi"
FUNCTION boolean CreateDirectoryA(ref string pathname, int sa) LIBRARY "Kernel32.dll" alias for "CreateDirectoryA;Ansi"
SUBROUTINE Sleep(ulong milli) LIBRARY "Kernel32.dll"
FUNCTION long ShellExecuteA (long hwnd, string lpOperation, string lpFile, string lpParameters,  string lpDirectory, integer nShowCmd ) LIBRARY "SHELL32" alias for "ShellExecuteA;Ansi"
FUNCTION ulong SHBrowseForFolder(ref str_browseinfo lstr_browseinfo) Library"SHELL32.DLL" alias for "SHBrowseForFolder;Ansi"
FUNCTION ulong SHGetPathFromIDList(ulong idlist,ref string ls_path) Library "SHELL32.DLL" alias for "SHGetPathFromIDList;Ansi"
FUNCTION ulong IsIconic(ulong hWnd) LIBRARY "User32.dll"
// $<Added>:   Date: Oct 25,2007       Author:Nova
//--------------------------------------------------------------------
// $<reason>   Fix a defect.
FUNCTION Ulong GetCurrentDirectoryA(ulong BufferLen, ref string Currentdir) LIBRARY "kernel32.dll" alias for "GetCurrentDirectoryA;Ansi"
//Function Boolean CreateDirectoryA( ref String PathName, int sa) Library "Kernel32.dll"
Function boolean RemoveDirectoryA (ref string directoryname) library "KERNEL32.DLL" alias for "RemoveDirectoryA;Ansi"
FUNCTION Ulong GetFileAttributesA(string lpFileName) library "Kernel32.dll" alias for "GetFileAttributesA;Ansi"
FUNCTION ulong SetFileAttributes(ref string lpFileName,ulong dwFileAttributes) LIBRARY "kernel32.dll" ALIAS FOR "SetFileAttributesA;Ansi"

//==============================APPEON END============================

//---------Begin Added by Alfee 01.16.2008----------------------------
FUNCTION ulong FindWindowExA(ulong hWnd1, ulong hWnd2, string lpsz1, string lpsz2) LIBRARY "User32.dll" alias for "FindWindowExA;Ansi" 
FUNCTION ulong GetWindowTextA(ulong hwnd, ref string lpString, ulong cch) LIBRARY "User32.dll" alias for "GetWindowTextA;Ansi" 
FUNCTION boolean IsWindowVisible (ulong hwnd) LIBRARY "User32.dll" 
//---------End Added -------------------------------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-06-11 By: Scofield
Function Long GlobalAddAtom(String as_Name) Library "kernel32" Alias for "GlobalAddAtomA;Ansi"
Function Long GlobalDeleteAtom(Long al_AtomID) Library "kernel32" Alias for "GlobalDeleteAtom"
Function Long RegisterHotKey(Long al_hwnd, Long al_AtomID, Long al_FlagKey, Long al_VirKey) Library "user32" Alias for "RegisterHotKey"
Function Long UnregisterHotKey(Long al_hwnd, Long al_AtomID) Library "user32" Alias for "UnregisterHotKey"
Function Long GetLastError() Library "kernel32" Alias for "GetLastError"
//---------------------------- APPEON END ----------------------------

Function Long SetWindowPos(Long   hwnd,Long   ord,Long   xx,Long   yy,Long   dx,Long   dy,Long   uflag)   Library  "user32.dll"   //Added by Ken.Guo on 2008-07-14

//--------------------------- APPEON BEGIN ---------------------------
//$< Add > 2008-07-30 By: Scofield
Function long GetDefaultPrinter(ref String pszPrinter,ref long nSize) library "WinSpool.drv" alias for "GetDefaultPrinterA;Ansi"
Function long SetDefaultPrinter(String pszPrinter) library "WinSpool.drv" alias for "SetDefaultPrinterA;Ansi"
//---------------------------- APPEON END ----------------------------

//---------Begin Added by Alfee 09.28.2008----------------------------
FUNCTION long AppeonReadFile(string as_file, ref blob ablb_Buffer, long al_FileSize) library "AppeonDLL.dll" alias for "AppeonReadFile;Ansi"
FUNCTION long AppeonWriteFile(string as_file, ref blob ablb_Buffer, long al_FileSize) library "AppeonDLL.dll" alias for "AppeonWriteFile;Ansi"
//---------End Added -------------------------------------------------

//---------Begin Added by Alfee 01.07.2010----------------------------
FUNCTION long GetDllDirectory(ref string as_Path) library "appeondll.dll" alias for "GetDllDirectory;Ansi" 
FUNCTION long GetShortPathNameA(string lf, ref string sf, long buflen) Library "kernel32.dll" alias for "GetShortPathNameA;Ansi"
//---------End Added -------------------------------------------------

//---------Begin Added by Andy 03.24.2010----------------------------
Function Int StopIEpopupmsg() library "StopIEpopupmsg.dll"
Function Int ResumeIEpopupmsg() library "StopIEpopupmsg.dll"
//---------End Added -------------------------------------------------

Function Long GetKeyState(Long nVirtKey) Library "user32" Alias For "GetKeyState" //Evan 09.01.2010 (V10.5-Advanced Report)

//---------Begin Added by (Appeon)Alfee 06.06.2013 for V141 ISG-CLX--------
Function long SendMessage(long hWnd, ulong Msg, long wParam, long lParam) Library "user32.dll" Alias For "SendMessageA"
Function boolean SetEnvironmentVariableA( string szVarName, string szValue ) LIBRARY "kernel32.dll" alias for "SetEnvironmentVariableA;Ansi" 
Function ulong GetEnvironmentVariableA( string szVarName,REF string lpValue, ulong dwSize ) LIBRARY "kernel32.dll" alias for "GetEnvironmentVariableA;Ansi" 
//---------End Added ------------------------------------------------------

//---------Begin Added by (Appeon)Alfee 01.21.2014 for V142 ISG-CLX -------------------
Function boolean GetTextExtentPoint32 ( ulong hdcr, string lpString, long nCount, Ref str_size_compute size ) Library "gdi32.dll" Alias For "GetTextExtentPoint32A"
Function ulong GetDC ( ulong hWnd ) Library "user32.dll"
Function ulong SelectObject ( ulong hdc, ulong hWnd ) Library "gdi32.dll"
Function long ReleaseDC ( ulong hWnd, ulong hdcr ) Library "user32.dll"
//---------End Added ----------------------------------------------------------------------------
end prototypes

type variables
Boolean ib_from_halt = False //Added By Ken.Guo 07.07.2008
Integer ii_set9, ii_db_ver //alfee 04.10.2013
String is_db_ver_patch, is_dbtype //alfee 04.10.2013

n_ds ids_address_dddw
n_ds ids_code_dddw
n_ds ids_screen_fields_cache
n_ds ids_screen_objects_cache
n_ds ids_report_fields_cache 			 //Added By Alan 08.20.2008
n_ds ids_report_objects_cache			 //Added By Alan 08.20.2008 	
n_ds ids_screen_report_objects_cache //Added By Alan 08.20.2008
n_coolmenu	inv_Coolmenu 
n_appeon_download inv_appeon_dwonload //alfee 03.14.2014

Integer ii_dir_right, ii_facility_cnt  //(Appeon)Alfee 06.19.2013 - V141 ISG-CLX
Boolean	ib_ReLogin   //(Appeon)Alfee 01.21.2014 - V142 ISG-CLX
String		is_CommandLine //(Appeon)Alfee 01.21.2014 - V142 ISG-CLX

end variables

forward prototypes
public function integer of_run_updates (integer ai_from)
public function integer of_create_cat_tables ()
public subroutine of_cleantmpfile ()
public function integer of_set_global_var ()
public function integer of_auto_upgradedb ()
public function integer of_test_mode_from_ini (string as_path)
public function integer of_check_version ()
public function integer of_create_session ()
public function integer of_downloaddll ()
public function integer of_initautoexpimpflag ()
public function integer of_version_expiration ()
public function integer of_initautoschedule ()
public subroutine of_parse_cmdline (string as_commandline)
public subroutine of_check_doc ()
public subroutine of_check_registry_right ()
public subroutine of_clean_emailtempfile ()
public subroutine of_getting_datacaches ()
public subroutine of_ini_registry ()
public subroutine of_run_email_notifications ()
public subroutine of_send_email (integer ai_did_allready, integer ai_dir_right, integer ai_run_date_alarm, integer al_interval_days)
public subroutine of_set_global_word (string as_value)
public function integer of_check_extra ()
public function integer of_set_odd ()
public function integer of_preload_contract ()
public subroutine of_set_relogin_status (boolean ab_relogin)
public function integer of_logout ()
public function boolean of_get_relogin_status ()
public function integer of_late_db_entries ()
end prototypes

event open_oldcode();
//********************************OLD CODE    11.15.07 ************************************************************
//Integer li_set_iapps
//Integer li_set_9
//Integer li_set7 
//integer li_prac_cnt
//integer vcnt
//integer set9
//Integer set_34
//integer setprod
//Integer li_rc
//Integer li_facility_cnt
//integer li_days
//String ls_password
//string ls_app
//Integer li_logon_cnt
//Integer i
//Integer li_i_did_allready  
//Date todaysdate
//datetime ld_lastupdate
//datetime ldt_now
//date ld_password
//date dateing
//string ls_dev_head
//string ls_ver_ck
//string ls_dir_path
//
////--------------------------- APPEON BEGIN ---------------------------
////$<add> 11.15.2006 By: Davis
////$<reason> Get Current Directory.
//Gs_Current_Directory = GetCurrentDirectory()
//gs_current_path = Gs_Current_Directory
////---------------------------- APPEON END ----------------------------
//
////--------------------------- APPEON BEGIN ---------------------------
////$<add> 10/09/2007 By: Ken.Guo
////$<reason> Get LDAP user name if exist,Login User,Domain name
//String ls_LDAPUser,ls_username,ls_domainname
//inv_systeminfo = Create n_cst_systeminfo
//ls_LDAPUser = AppeonGetAppeonUserName()
//If ls_LDAPUser = '' or isnull(ls_LDAPUser) Then
//	ls_username = inv_systeminfo.of_get_username()
//	ls_domainname = inv_systeminfo.of_get_domainname()
//End If
//Destroy inv_systeminfo
////---------------------------- APPEON END ----------------------------
//
//of_get_dir_path(Gs_Current_Directory)
//
////--------------------------- APPEON BEGIN ---------------------------
////$< Add  > 2007-09-14 By: Scofield
////$<Reason> Add connect cache process
//if AppeonGetClientType() = 'WEB' then
//	if Len(Trim(CommandLine)) > 0 then
//		if Pos(CommandLine,",") > 0 then
//			gs_CacheName = Lower(Trim(Left(CommandLine,Pos(CommandLine,",") - 1)))
//			gs_CacheType = Upper(Trim(Mid(CommandLine,Pos(CommandLine,",") + 1)))
//		else
//			gs_CacheName = Lower(Trim(CommandLine))
//		end if
//		
//		if gs_CacheName <> '' then
//			gs_CacheSet = "CacheName='" + gs_CacheName + "'"
//			if gs_CacheType = '' then
//				gs_CacheType = "ODB-MSS"				//default set to SQLServer
//			end if
//		end if
//	end if
//end if
////---------------------------- APPEON END ----------------------------
//
////mskinner 1 march 2005 -- begin
//inv_CoolMenu = Create n_coolmenu
//
//inv_CoolMenu.of_Initialize()
//inv_CoolMenu.of_SetResourceFile( "resources.dll" )
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> UM-01
////$<modify> 01/12/2006 By: Cao YongWang
////$<reason> The 'create using as_menu' syntax in n_coolmenu.of_setmenu(string as_menu) function 
////$<reason> is unsupported by Appeon, changed it to n_coolmenu.of_setmenu(menu amnu_menu)
////inv_CoolMenu.of_SetMenu( 'm_pfe_cst_mdi_menu' )
//menu lmnu_menu
//lmnu_menu = Create m_pfe_cst_mdi_menu
//inv_CoolMenu.of_SetMenu( lmnu_menu )
////---------------------------- APPEON END ----------------------------
////inv_CoolMenu.of_set2k3style( )
//
//inv_CoolMenu.of_setxpstyle( )
//
////inv_CoolMenu.of_setmenubarcolor( rgb(211,117,242))
////inv_CoolMenu.of_set2k3gradient(rgb(255,255,255), rgb(211,117,242))
//
////mskinner 1 march 2005 -- end
//
//todaysdate = Today()
//ldt_now = datetime(today(),now())
//
////messagebox("",string(ldt_now))
//gnv_app = CREATE n_cst_appmanager
////==============================APPEON BEGIN==========================
//// $<Deleted>:   Date: Oct 29,2007       Author:Nova
////--------------------------------------------------------------------
//// $<reason>   Fix a defect.
//
//////messagebox("version",gnv_app.of_getversion( ))
////Start Code Change ---- 10.03.2007 #V7 maha readded and modified
////if upper(appeongetclienttype())  = "WEB" then  
////	gs_user_version =  "Web 7.5x build100307"
////else
////==============================APPEON END============================
//	gs_user_version =  gnv_app.of_getversion( )
////end if
////End Code Change---10.03.2007
//
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-06
////$<add> 01.16.2006 By: Cao YongWang
////$<reason> Initialize the global varibal for preselect data approach.
//If not isvalid(gnv_data) Then gnv_data = create n_cst_globaldata
////---------------------------- APPEON END ----------------------------
//
//gnv_app.Event pfc_Open(commandline)
//
//
//
//
//
////If len(commandline) > 0 then 				//Commented by Scofield on 2007-09-14
//	
////	// Profile intellicrdd
////	SQLCA.DBMS = "ODBC"
////	SQLCA.AutoCommit = False
////	SQLCA.DBParm = "ConnectString='DSN=intellicred client;UID=dba;PWD=sql'"
////	connect;
////
////	str_pass lstr_pass
////	lstr_pass.s_long[1] = long(commandline)
////   n_cst_report_macro	invo_report_macro
////   invo_report_macro.of_start_report( lstr_pass)
////	DISCONNECT;
////	HALT
//	
////else
//
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<modify> 10/09/2007 By: Ken.Guo
//	//$<reason> Use LDAP user auto login
//	//Open( w_logon_screen )
//	OpenWithParm(w_logon_screen,ls_LDAPUser)
//	//---------------------------- APPEON END ----------------------------
//	IF Message.StringParm = "Cancel" OR Message.StringParm = "DB Error" or Message.StringParm = "" THEN //the last added maha 081502 for user clicking on X on login screen
//		Halt Close
//	END IF
//	//maha moved from w_login 083005 for expired password testing
//	select set_36 into :li_set7 from icred_settings; //maha 052404 again
//	
//	if upper(gs_user_id) = "MASTER" then
//		//skip
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<modify> 10/09/2007 By: Ken.Guo
//	//$<reason> If Login with LDAP user, need not Expired	
//	//else //if using expiring passwords for first time on a user it sets the expiration date for x days in the future.  Otherwise it checks the expiration date for the user and gives the appropriate message.
//	ElseIf ls_LDAPUser = '' Then  
//	//---------------------------- APPEON END ----------------------------
//		if li_set7 > 0 then
//			select last_pass_update into :ld_password from security_users where upper(user_id) = :gs_user_id;
//			li_days = DaysAfter ( today(), ld_password )
//			If isnull(ld_password) then
//				ld_password = RelativeDate ( today(),li_set7) //changed maha 031605 to theset7 value
//				//--------------------------- APPEON BEGIN ---------------------------
//				//$<ID> PT-09
//				//$<add> 01.17.2006 By: Cao YongWang
//				//$<reason> Performance tuning
//				//$<reason> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
//				gnv_appeondb.of_autocommit()				
//				//---------------------------- APPEON END ----------------------------
//				update security_users set last_pass_update = :ld_password where upper(user_id) = :gs_user_id;
//				commit using sqlca;
//				messagebox("Password Expiration","Your password will expire in " + string(li_set7) + " days.  You can go to System->Change Password to change" )
//			elseif li_days < 0 then
//				messagebox("Password Expired","Your password has expired. Please Change.")
//				openwithparm(w_change_password,"login")
//				if upper(message.stringparm) = "CANCEL" then
//					messagebox("Expired","Your password has expired.  It will have to be changed, or you will not be able to log in.  Closing program.")
//					halt Close
//				end if
//			elseif li_days <= 10 then
//				integer passmes
//				passmes = messagebox("Password Expiring","Your password will expire in " + string(li_days) + " days.  Would you like to change it now? (You can Go to System->Change Password to change later if you wish.",question!,yesno!,2 )
//				if passmes = 1 then
//					debugbreak()
//					openwithparm(w_change_password,"login")
//				end if
//			end if
//		end if
//	end if
////end if 
//
////Get last update date from ids table
////04/05/2007 By Jervis May be APB Bug,Can't put in APB queue
//select last_update into :ld_lastupdate from ids;
//
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-10
////$<add> 01.17.2006 By: Cao YongWang
////$<reason> Performance tuning
////$<reason> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
//gnv_appeondb.of_startqueue()
////---------------------------- APPEON END ----------------------------
//
////data updates moved up here maha 102904
////select last_update into :ld_lastupdate from ids; //04/05/2007 By Jervis repeat call
//select set_27 into :set9 from icred_settings; //skip auto updates
//
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-11
////$<add> 01.17.2006 By: Cao YongWang
////$<reason> Performance tuning
////$<reason> Integrate SQL statements into Appeon Queue labels to reduce client-server interactions for performance
////$<reason> tuning.
//string ls_dbtype
//
//gds_settings = create datastore //maha 102004
//gds_settings.dataobject = "d_icred_settings"
//i = gds_settings.settransobject(sqlca)
//if i < 1 then
//	messagebox("Database Connection Error","Error connecting to database.  Closing Program")
//	halt Close
//end if
//
//i = gds_settings.retrieve()	
//
////Check version
//select count(user_id) into :vcnt from sys_user_version where user_id = :gs_user_id;
//
////Get last update date from ids table
////select last_update into :ld_lastupdate from ids;
//
////
//SELECT Count( last_query)  
//INTO :li_i_did_allready  
//FROM ids  
//WHERE Convert(varchar(10),last_query,101) = convert(varchar(10),getdate(),101);
////
////ids_address_dddw = CREATE n_ds
////ids_address_dddw.DataObject = "d_dddw_address_lookup_cache"
////ids_address_dddw.of_SetTransObject( SQLCA )
////li_rc = ids_address_dddw.Retrieve()
//Select lookup_cache INTO :gdt_lookup_cache FROM ids;
//
//ids_screen_fields_cache = CREATE n_ds
//ids_screen_fields_cache.DataObject = "d_screen_fields_cache"
//ids_screen_fields_cache.of_SetTransObject( SQLCA )
//li_rc = ids_screen_fields_cache.Retrieve()
//Select screen_cache INTO :gdt_screen_cache FROM ids;
//
//
//ids_screen_objects_cache = CREATE n_ds
//ids_screen_objects_cache.DataObject = "d_screen_objects_cache"
//ids_screen_objects_cache.of_SetTransObject( SQLCA )
//li_rc = ids_screen_objects_cache.Retrieve()
//Select screen_obj_cache INTO :gdt_screen_obj_cache FROM ids;
//
////
//Select Count( prac_id )
//INTO :li_prac_cnt
//FROM pd_basic;
//
//select version_id into :ls_ver_ck from sys_user_version where user_id = :gs_user_id;
//
////
//SELECT Count( * )  
//   INTO :li_facility_cnt  
//   FROM committee_lookup  
//   WHERE committee_lookup.facility_id = 1   ;
//
////
//select top 1 @@version into :ls_dbtype from ids;
//
//gnv_appeondb.of_commitqueue()
//
////--------------------------- APPEON BEGIN ---------------------------
////$<edit> 2007-06-20 By: Jervis
////$<reason> Move to n_cst_dm_sql.of_update_version_7
//
////--------------------------- APPEON BEGIN ---------------------------
////$<add> 2007-01-27 By: Rodger Wu
////$<reason> Fix a defect that i equals to -1 due to a new field added to icred_settings.
////string ls_sql
////if i < 0 then
////	gnv_appeondb.of_startqueue()
////	ls_sql = "Alter table icred_settings add set_51 int; "
////	execute immediate :ls_sql using sqlca;
////	commit using sqlca;
////	
////	i = gds_settings.retrieve()
////	gnv_appeondb.of_commitqueue()
////end if
////---------------------------- APPEON END ----------------------------
////---------------------------- APPEON END ----------------------------
//
//
//If pos(upper(ls_dbtype) , 'SQL SERVER') > 0 Then
//	gs_dbType = 'SQL'
//Else
//	gs_dbType = 'ASA'
//End If
//
////---------------------------- APPEON END ----------------------------
//
////Start Code Change ---- 02.24.2006 # maha
//
//
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-12
////$<comment> 01.17.2006 By: Cao YongWang
////$<reason> Performance tuning.  Remove the SQL statements to Appeon Queue labels to reduce client-server interactions.
////$<reason> refer to PT-11 for details.
////gds_settings = create datastore //maha 102004
////gds_settings.dataobject = "d_icred_settings"
////i = gds_settings.settransobject(sqlca)
////if i < 1 then
////	messagebox("Database Connection Error","Error connecting to database.  Closing Program")
////	halt
////end if
////i = gds_settings.retrieve()
//i = gds_settings.rowcount()
////---------------------------- APPEON END ----------------------------
//
//if i < 1 then
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<Modify> 2007-08-01 By: Scofield
//	//$<Reason> Add the 'No' button to exit the application
//	
//	//messagebox("Settings Error","Error retrieving Settings. Running Updates.  After updates are run, restart the program")
//	//of_run_updates(1)
//	//halt
//	Integer	li_Rtn
//	li_Rtn = MessageBox("Database upgrade","To run the application, the database must be upgraded first. Would you like to upgrade it now?~r~nClick Yes to upgrade it now.~r~nClick No to exit the application.",Question!,YesNo!,2)
//	if li_Rtn = 1 then
//		of_run_updates(1)
//	end if
//	halt Close
//	//---------------------------- APPEON END ----------------------------
//end if
//
//// //==============================APPEON BEGIN==========================
//// $<Added>:   Date: Nov 12,2007       Author:Nova
////--------------------------------------------------------------------
//// $<reason>   Fix a defect.
//String ls_inifile
//Long ll_dbver,ls_update_version
//String ls_update_ver,ls_db_path_ver
//GS_SYSRUNPATH = GetCurrentDirectory ( )
//ls_inifile = GS_SYSRUNPATH + '\' + GS_INIFILE
//ls_update_version = Long(ProfileString(ls_inifile, "setup", 'version', 'error'))
//SELECT Top 1 set_18 Into :ll_dbver From icred_settings;
//IF ll_dbver < ls_update_version THEN
//	of_run_updates(0)
//ELSEIF ll_dbver = ls_update_version THEN
//	SELECT Top 1 set_patch_ver Into :ls_db_path_ver From icred_settings;
//	IF sqlca.SQLCode <> 0 THEN
//		of_run_updates(0)
//	ELSE
//		gs_patch_ver = ProfileString(ls_inifile, "updatemethod", 'patch_ver', 'error')
//		IF ls_db_path_ver < gs_patch_ver THEN
//			of_run_updates(0)
//		END IF
//	END IF
//	
//END IF
//
////==============================APPEON END============================
////==============================APPEON BEGIN==========================
//// $<Deleted>:   Date: Nov 12,2007       Author:Nova
////--------------------------------------------------------------------
//// $<reason>   Fix a defect.
//
//
////if set9 <> 1 then
////	if date(ld_lastupdate) < date("2007-08-24") then //maha added 100202to automatically run updates less then this date
////		of_run_updates(0)
////		//Start code changes - 1.4.2007 Henry. comment out the redundant scripts
////		/*
////		//--------------------------- APPEON BEGIN ---------------------------
////		//retrieve the cache data again after updating the database automacatilly
////		gnv_appeondb.of_startqueue()
////		gnv_data.of_retrieve('icred_settings') //cache data for icred_settings table
////		gnv_data.of_retrieve('security_users') //cache data for security_users table
////		gnv_data.of_retrieve('ids')				//cache data for ids table
////		gnv_data.of_retrieve('sys_tables')				//cache data for sys_tables table
////		gnv_data.of_retrieve('code_lookup')				//cache data for code_lookup table
////		gnv_data.of_retrieve('ctx_notification')				//cache data for ctx_notification table
////		gnv_data.of_retrieve('sys_fields')				//cache data for sys_fields and sys_tables table
////		gnv_data.of_retrieve('facility')				//cache data for facility table
////		gnv_data.of_retrieve('data_view_screen')				//cache data for data_view_screen table
////		//--------------------------- APPEON BEGIN ---------------------------
////		//$<add> 10.12.2006 By: Jack (Inova)
////		//$<reason> Queue Images for Scanning from Data Entry.
////		gnv_data.of_retrieve('image_type')				//cache data for image_type table	
////		//---------------------------- APPEON END ----------------------------
////		
////		gnv_data.of_retrieve('code_lookup_2') //Added 11.30.2006 henry
////		
////		//Added for work flow. 6/11/2006 Henry
////		gnv_data.of_retrieve('wf_workflow')	
////		gnv_data.of_retrieve('wf_action_types')	
////		gnv_data.of_retrieve('wf_action_status')	
////		gnv_data.of_retrieve('wf_trigger_param_data_comparison')	
////		gnv_data.of_retrieve('wf_trigger_param_action_status')	
////		
////		//End added for work flow.
////		
////		gnv_appeondb.of_commitqueue()
////		//---------------------------- APPEON END ----------------------------
////		*/
////		//End code changes - 1.4.2007 Henry
////	end if
////end if
////==============================APPEON END============================
////Start Code By Jervis 06.26.2007
//If  of_get_app_setting("set_47","I") = 1 Then gb_workflow = True
////End Code
//
////End Code Change---02.24.2006
//
////action item,  should there be just the psv or both psv and app status action items screens
////SELECT set_iapps, set_9
////INTO :li_set_iapps, :li_set_9
////FROM icred_settings;
//
//li_set_iapps = of_get_app_setting("set_iapps","I")
//gi_iapp_on = li_set_iapps
//li_set_9 = of_get_app_setting("set_9","I")
//
//
////debugbreak()
//IF ( li_set_iapps = 0 AND li_set_9 = 0 ) THEN
//	gi_action_item_menus = 1  //JUST PSV ACTION ITEMS MENU OPTION
//ELSEIF ( li_set_iapps = 1 AND li_set_9 = 0 ) THEN	
//	gi_action_item_menus = 1  //JUST PSV ACTION ITEMS MENU OPTION
//ELSEIF ( li_set_iapps = 1 AND li_set_9 = 1 ) THEN
//	gi_action_item_menus = 2  //JUST APPLICATION STATUS ACTION ITEMS MENU OPTION
//ELSEIF ( li_set_iapps = 0 AND li_set_9 = 1 ) THEN
//	gi_action_item_menus = 2  //JUST APPLICATION STATUS ACTION ITEMS MENU OPTION
//ELSEIF li_set_9 = 3  THEN	
//	gi_action_item_menus = 3  //BOTH APPLICATION STATUS ACTION ITEMS MENU OPTION AND PSV OPTION
//END IF
//
//if li_set_9 = 1 then gs_cust_type = "I"
//
//if li_set_9 = 2 then gb_se_version = True
//
////--------------------------- APPEON BEGIN ---------------------------
////$<add> 08.17.2006 By: LeiWei
////$<reason> Making the Contract Module a Standalone Product
//IF li_set_9 = 4 then gb_contract_version = True
////---------------------------- APPEON END ----------------------------
//
////Added for To Do List 7/12/2006 Allen
////Start Code Change ----11.15.2008 #V8 maha
////If of_get_app_setting("set_49","I") = 1 Then gb_ToDoList = True
//select set_tdl into :li_set7   from security_users where user_id = :gs_user_id;
//if li_set7 = 1 then gb_ToDoList = True
////End Code Change---11.15.2007
//
////--------------------------- APPEON BEGIN ---------------------------
////$<add> 11.27.2006 By: Jack (IntelliContract Agreement Manager Painters)
////$<reason> Making the Agreement Manager Module a Standalone Product
//
//IF of_get_app_setting("set_51","I") = 1 THEN
//	gb_agreement_manager = True
//END IF
////---------------------------- APPEON END ----------------------------
//
////check user version 
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-13
////$<comment> 01.17.2006 By: Cao YongWang
////$<reason> Performance tuning. Remove the SQL statements to Appeon Queue labels to reduce client-server interactions.
////$<reason> refer to PT-11 for details.
////select count(user_id) into :vcnt from sys_user_version where user_id = :gs_user_id;
////---------------------------- APPEON END ----------------------------
//
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-14
////$<add> 01.17.2006 By: Cao YongWang
////$<reason> Performance tuning.
////$<reason> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
////$<modification> Add the Apppeon Start Queue label.
//gnv_appeondb.of_startqueue()
////---------------------------- APPEON END ----------------------------
//
//if vcnt = 0 then
//	insert into sys_user_version values (:gs_user_id,:gs_user_version,:ldt_now);
//	commit using sqlca;
//else
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<ID> PT-15
//	//$<comment> 01.17.2006 By: Cao YongWang
//	//$<reason> Performance tuning. Remove the SQL statements to Appeon Queue labels to reduce client-server interactions.
//   //$<reason> refer to PT-11 for details.
//	//select version_id into :ls_ver_ck from sys_user_version where user_id = :gs_user_id;
//	//---------------------------- APPEON END ---------------------------
//	if ls_ver_ck <> gs_user_version then
//		update sys_user_version set version_id = :gs_user_version,mod_date = :ldt_now where user_id = :gs_user_id;
//		commit using sqlca;
//	end if
//end if
//
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-16
////$<add> 01.17.2006 By: Cao YongWang
////$<reason> Performance tuning.
////$<reason> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
////$<modification> Add the Appeon Commit Queue label.
//gnv_appeondb.of_commitqueue()
////---------------------------- APPEON END ----------------------------
//
////Start Code Change ---- 03.20.2006 #325 maha  duplicate code removed
//////debugbreak()	
////select last_update into :ld_lastupdate from ids;
////
////
//////select set_27 into :set9 from icred_settings;
////set9 = of_get_app_setting("set_27","I")
//////messagebox("",setprod)
////if set9 <> 1 then
////	if date(ld_lastupdate) < date("2004-09-25") then //maha added 100202to automatically run updates less then this date
////		of_run_updates(0)
////	end if
////end if
//////\maha
////End Code Change---03.20.2006
//
////\maha
//
////\/maha added 082302 to set inital product settings
////select set_product into :setprod from icred_settings;
//setprod = of_get_app_setting("set_product","I")
////messagebox("",setprod)
//if setprod = 1 then
//	open(w_install_module_update)
//	gds_settings.retrieve()
//	if message.stringparm = "Cancel" then 	
//		halt Close
//	end if
//end if
////\maha
//
////\/maha changed 061402
////select set_9 into :set9 from icred_settings;
////if set9 = 1 then gs_cust_type = "I"  //product intelliapp
//
////select set_31 into :set9 from icred_settings;
//gi_export_on = of_get_app_setting("set_iauto","I")
//gi_ireport_on = of_get_app_setting("set_ireport","I")
////gi_iapp_on = of_get_app_setting("set_iapps","I")
//gi_scan_format  = of_get_app_setting("set_29","I")
//gi_imaging = of_get_app_setting("set_img","I")
//gi_priv_mod = of_get_app_setting("set_priv","I")
//gi_case_review = of_get_app_setting("set_peer","I")
//gi_dept_security = of_get_app_setting("set_37","I")
////select set_31 into :set9 from icred_settings;
//
////start code changes - 1.4.2007 Henry.
////retrieve cache datas.  gnv_data is n_cst_globaldata in appeon_workaround
//gnv_appeondb.of_startqueue()
//gnv_data.of_retrieve('icred_settings') //cache data for icred_settings table
//gnv_data.of_retrieve('security_users') //cache data for security_users table
//gnv_data.of_retrieve('ids')				//cache data for ids table
//gnv_data.of_retrieve('sys_tables')				//cache data for sys_tables table
//gnv_data.of_retrieve('code_lookup')				//cache data for code_lookup table
//gnv_data.of_retrieve('ctx_notification')				//cache data for ctx_notification table
//gnv_data.of_retrieve('sys_fields')				//cache data for sys_fields and sys_tables table
//gnv_data.of_retrieve('facility')				//cache data for facility table
//gnv_data.of_retrieve('data_view_screen')				//cache data for data_view_screen table
////--------------------------- APPEON BEGIN ---------------------------
////$<add> 10.12.2006 By: Jack (Inova)
////$<reason> Queue Images for Scanning from Data Entry.
//gnv_data.of_retrieve('image_type')				//cache data for image_type table	
////---------------------------- APPEON END ----------------------------
//
//gnv_data.of_retrieve('code_lookup_2') //Added 11.30.2006 henry
//	
////Added for work flow. 6/11/2006 Henry
//gnv_data.of_retrieve('wf_workflow')	
//gnv_data.of_retrieve('wf_action_types')	
//gnv_data.of_retrieve('wf_action_status')	
//gnv_data.of_retrieve('wf_trigger_param_data_comparison')	
//gnv_data.of_retrieve('wf_trigger_param_action_status')	
////End added for work flow.
//	
////$<add> 10.12.2006 By: LeiWei
//IF appeongetclienttype() = 'WEB' Then
//	select image_flag into :gs_image_flag from security_users where user_id = :gs_user_id;
//END IF
////$<add> 10.12.2006 By: LeiWei
//
//gnv_appeondb.of_commitqueue()
////---------------------------- APPEON END ----------------------------
////end code changes - 1.4.2007 henry
//
//This.ToolbarText = True
//Open(w_mdi)
//
////open(w_store_image_in_db)
//
//
//
//
//IF of_get_app_setting("set_9","I")  = 1 THEN //
//	w_mdi.Title = "IntelliApp For Windows"
//	ls_app = "IntelliApp"
//elseif gb_contract_version = True then  //set_9 = 4   //Start Code Change ---- 10.06.2006 #688 maha
//	w_mdi.Title = "IntelliContract For Windows"
//	ls_app = "IntelliContract"
//ELSE
//	w_mdi.Title = "IntelliCred For Windows"
//	ls_app = "IntelliCred"
//END IF
////End Code Change---01.12.2005 
//
//gi_test_mode = of_get_app_setting("set_10","I")
//if gi_test_mode = 2 then //maha 080702 moved here 112502 from w_mdi(open) because of preceding code
//	w_mdi.Title =  ls_app + " Using Test Database"
//elseif gi_test_mode = 1 then
//	w_mdi.Title =  ls_app + " in Debug Mode"
//elseif gi_test_mode = 3 then
//	//select dev_title into :ls_dev_head from icred_settings;
//	ls_dev_head = gds_settings.getitemstring(1,"dev_title")
//	if isnull(ls_dev_head) then ls_dev_head = ""
//	w_mdi.Title = ls_app + " using " + ls_dev_head
//elseif gi_test_mode = 10 then
//	w_mdi.Title = ls_app + " using MAHA test database"
//elseif gi_test_mode = 200 then
//	w_mdi.Title = ls_app + " using Intellisoft Application Database"
//end if
//
//
//
//
//IF Upper( gs_cust_type ) = 'I' THEN
//	UPDATE facility_ver_rules
//	SET default_verif_means = 15,
//	    verifY_data = 'B'
//	WHERE ( facility_id = 1 ) AND
//			( facility_ver_rules.screen_id in (4,5,15,19,20,23) )   ;
//   commit using sqlca;
//	IF SQLCA.SQLCODE = -1 THEN
//		MessageBox("SQL Error", SQLCA.SQLERRTEXT )
//	END IF
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<ID> PT-17
//	//$<comment> 01.17.2006 By: Cao YongWang
//	//$<reason> Performance tuning. Remove the SQL statements to Appeon Queue labels to reduce client-server interactions.
//   //$<reason> refer to PT-11 for details.
//	//	SELECT Count( * )  
//	//   INTO :li_facility_cnt  
//	//   FROM committee_lookup  
//	//   WHERE committee_lookup.facility_id = 1   ;
//	//	IF SQLCA.SQLCODE = -1 THEN
//	//		MessageBox("SQL Error", SQLCA.SQLERRTEXT )
//	//	END IF
//	//---------------------------- APPEON END ----------------------------
//
//		
//	IF li_facility_cnt = 0 THEN
//		INSERT INTO committee_lookup  
//         ( committee_id,   
//           facility_id,   
//           committee_name )  
//		VALUES ( 1,   
//       			  1,   
//		           'Credentialing Committee' )  ;
//     
//		IF SQLCA.SQLCODE = -1 THEN
//			MessageBox("SQL Error", SQLCA.SQLERRTEXT )
//		END IF
//				  
//	END IF
//END IF
//
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-18
////$<comment> 01.17.2006 By: Cao YongWang
////$<reason> Performance tuning. Remove the SQL statements to Appeon Queue labels to reduce client-server interactions.
////$<reason> refer to PT-11 for details.
////SELECT Count( last_query)  
////INTO :li_i_did_allready  
////FROM ids  
////WHERE ids.last_query = :todaysdate   ;
////IF SQLCA.SQLCODE = -1 THEN
////	MessageBox("SQL Error", SQLCA.SQLERRTEXT )
////END IF
////---------------------------- APPEON END ----------------------------
//
//IF li_i_did_allready = 0 THEN
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<modify> 12.29.2006 By: Davis
//	//$<reason> Fix a defect.
//	/*
//	UPDATE ids  
//   SET last_query = :todaysdate  ;
//	*/
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<add> 10/31/2007 By: Ken.Guo
//	//$<reason> Delete Temp data if exist in below tables	when run app firstly every day.
//	gnv_appeondb.of_startqueue()
//	Delete From ic_array_to_db;
//	Delete From ic_client_data;
//	//---------------------------- APPEON END ----------------------------
//	UPDATE ids SET last_query = getdate()  ;	
//	commit using sqlca;
//	gnv_appeondb.of_commitqueue()
//	//---------------------------- APPEON END ----------------------------
//	IF SQLCA.SQLCODE = -1 THEN
//		MessageBox("SQL Error setting last_query date", SQLCA.SQLERRTEXT )
//	END IF
//	//maha moved below the last_query set to block near simultaneous logins from running duplicate action item querys.
//	pfc_n_cst_ai_printletters lnv_exp_cred
//	lnv_exp_cred = CREATE pfc_n_cst_ai_printletters
//	lnv_exp_cred.of_run_ai_query(1) //maha 082903
//	// MSKINNER 03 March 2006 -- begin
//	
//	long ll_contract
//	select set_cont into :ll_contract from icred_settings;
//	if ll_contract <> 0 then	
//		n_cst_notification  lnvo_notification
//		lnvo_notification =  create n_cst_notification
//		lnvo_notification.of_start_notification_process( )
//		//--------------------------- APPEON BEGIN ---------------------------
//		//$<Add> 08.23.2007 By: Evan
//		//$<Reason> Need to destroy object.
//		if IsValid(lnvo_notification) then Destroy lnvo_notification
//		//---------------------------- APPEON END ----------------------------	
//	end if
//	// MSKINNER 03 March 2006 -- end
//
////	lnv_exp_cred.of_expiring_credentials()
////	lnv_exp_cred.of_resend_letters()
////	lnv_exp_cred.of_expiring_appointments()
//	DESTROY lnv_exp_cred
//	
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<add> 11.10.2006 By: Jervis
//	//$<reason> Modify for workflow
//	//Reminder type emails should be send when the system starts up for the first tiem each day.
//	n_cst_workflow_triggers	lnv_workflow
//	lnv_workflow = create n_cst_workflow_triggers
//	lnv_workflow.of_reminder_mail_process()
//	destroy n_cst_workflow_triggers
//	//---------------------------- APPEON END ----------------------------
//END IF
//
//
////select set_2 into :gi_cache_set from icred_settings;
//
/////If gi_cache_set = 0 then //maha092701
//
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-19
////$<comment> 01.17.2006 By: Cao YongWang
////$<reason> Performance tuning. Remove the SQL statements to Appeon Queue labels to reduce client-server interactions.
////$<reason> refer to PT-11 for details.
////ids_address_dddw = CREATE n_ds
////ids_address_dddw.DataObject = "d_dddw_address_lookup_cache"
////ids_address_dddw.of_SetTransObject( SQLCA )
////li_rc = ids_address_dddw.Retrieve()
////Select lookup_cache INTO :gdt_lookup_cache FROM ids;
////
////ids_screen_fields_cache = CREATE n_ds
////ids_screen_fields_cache.DataObject = "d_screen_fields_cache"
////ids_screen_fields_cache.of_SetTransObject( SQLCA )
////li_rc = ids_screen_fields_cache.Retrieve()
////Select screen_cache INTO :gdt_screen_cache FROM ids;
////
////
////ids_screen_objects_cache = CREATE n_ds
////ids_screen_objects_cache.DataObject = "d_screen_objects_cache"
////ids_screen_objects_cache.of_SetTransObject( SQLCA )
////li_rc = ids_screen_objects_cache.Retrieve()
////Select screen_obj_cache INTO :gdt_screen_obj_cache FROM ids;
////---------------------------- APPEON END ----------------------------
//
////IF gs_cust_type = "I" THEN
//if	gi_iapp_on = 1 and of_get_app_setting("set_31","I") = 0 then //maha changed 101404
//	open( w_dash )
//END IF
//
////Select set_15 into :gi_intelliapp_type from icred_settings;
//gi_intelliapp_type = of_get_app_setting("set_15","I")
//
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-20
////$<comment> 01.17.2006 By: Cao YongWang
////$<reason> Performance tuning. Remove the SQL statements to Appeon Queue labels to reduce client-server interactions.
////$<reason> refer to PT-11 for details.
////Select Count( prac_id )
////INTO :li_prac_cnt
////FROM pd_basic;
////---------------------------- APPEON END ----------------------------
//
//IF li_prac_cnt <= 100 THEN
//	gi_auto_search = 1
//ELSE
//	gi_auto_search = 0
//END IF
//
//
////check for word path maha 073004 
////--------------------------- APPEON BEGIN ---------------------------
////$<modify> 01/12/2006 By: Cao YongWang
////$<reason> It is not necessary to determine the intellicred.ini exist in web application
//
////IF NOT FileExists( gs_dir_path + "intellicred\intellicred.ini" ) THEN
////	MessageBox("ini File Error", "No intellicred.ini file found at: " + gs_dir_path + "intellicred\intellicred.ini~rThis may cause errors in the program including printing letters." )
////else //check the word path
////	if fileexists( "C:\Program Files\Microsoft Office\Office12\winword.exe") then
////		SetProfileString(gs_dir_path + "intellicred\intellicred.ini", "paths", "word", " C:\Program Files\Microsoft Office\Office12\winword.exe")
////	elseif fileexists( "C:\Program Files\Microsoft Office\Office11\winword.exe") then
////		SetProfileString(gs_dir_path + "intellicred\intellicred.ini", "paths", "word", " C:\Program Files\Microsoft Office\Office11\winword.exe")
////	elseif fileexists( "C:\Program Files\Microsoft Office\Office10\winword.exe") then
////		SetProfileString(gs_dir_path + "intellicred\intellicred.ini", "paths", "word", " C:\Program Files\Microsoft Office\Office10\winword.exe")
////	else
////		//leave it as is
////	end if
////END IF
//If appeongetclienttype() = 'PB' Then
//	IF NOT FileExists(gs_IniFilePathName) THEN
//		MessageBox("ini File Error", "No intellicred.ini file found at: " + gs_IniFilePathName + "~rThis may cause errors in the program including printing letters." )
//	else //check the word path
//		if fileexists( "C:\Program Files\Microsoft Office\Office12\winword.exe") then
//			SetProfileString(gs_IniFilePathName, "paths", "word", " C:\Program Files\Microsoft Office\Office12\winword.exe")
//		elseif fileexists( "C:\Program Files\Microsoft Office\Office11\winword.exe") then
//			SetProfileString(gs_IniFilePathName, "paths", "word", " C:\Program Files\Microsoft Office\Office11\winword.exe")
//		elseif fileexists( "C:\Program Files\Microsoft Office\Office10\winword.exe") then
//			SetProfileString(gs_IniFilePathName, "paths", "word", " C:\Program Files\Microsoft Office\Office10\winword.exe")
//		else
//			//leave it as is
//		end if
//	END IF
//Else
//	if fileexists( "C:\Program Files\Microsoft Office\Office12\winword.exe") then
//		SetProfileString(gs_IniFilePathName, "paths", "word", " C:\Program Files\Microsoft Office\Office12\winword.exe")
//	elseif fileexists( "C:\Program Files\Microsoft Office\Office11\winword.exe") then
//		SetProfileString(gs_IniFilePathName, "paths", "word", " C:\Program Files\Microsoft Office\Office11\winword.exe")
//	elseif fileexists( "C:\Program Files\Microsoft Office\Office10\winword.exe") then
//		SetProfileString(gs_IniFilePathName, "paths", "word", " C:\Program Files\Microsoft Office\Office10\winword.exe")
//	else
//		//leave it as is
//	end if
//End IF
////---------------------------- APPEON END ----------------------------
//
////--------------------------- APPEON BEGIN ---------------------------
////$<modify> 01.05.2007 By: Davis
////$<reason> Modfiy the function.
////gnv_app.of_setcontraccache( )
//gnv_app.of_setcontraccache_register( )
////---------------------------- APPEON END ----------------------------
//
//// END  code change --- 01.01.2005 MSKINNER
//
////--------------------------- APPEON BEGIN ---------------------------
////$<add> 09.07.2006 By: LeiWei
////$<reason> Making the Contract Module a Standalone Product
//gnv_app.of_setcontraccache_code_lookup(TRUE)
////---------------------------- APPEON END ----------------------------
//
////Start Code Change ---- 01.23.2006 #213 maha
//if gs_cust_type = "I" then //maha 030606
//	gnv_app.of_sethelpfile( gs_dir_path + "Intellicred\IntelliApp_User_Guide.chm")
//else
//	gnv_app.of_sethelpfile( gs_dir_path + "Intellicred\IntelliCred_User_Guide.chm")
//end if
//
//if gi_citrix = 1 then
//	select letter_save_path into :gs_save_path from ids;
//	if isnull(gs_save_path) or len(gs_save_path) < 3 then gs_save_path = gs_dir_path + "Intellicred\Letters\Standard\"
//	CreateDirectory ( gs_save_path )
//else
//	gs_save_path = gs_dir_path + "Intellicred\Letters\Standard\"
//end if
////End Code Change---01.23.2005 
//
//gnv_app.of_set_contract_path( )
//
////mskinner 17 fab 2005 -- begin
//if of_get_app_setting("set_44","I") = 0 then
//	n_cst_rights LNVO_RIGHTS
//	LNVO_RIGHTS = create n_cst_rights
//	ls_ver_ck = LNVO_RIGHTS.OF_start( )
//	if ls_ver_ck <> "OK" then
//		openwithparm( w_sql_msg,ls_ver_ck)
//	end if
//	destroy LNVO_RIGHTS
//end if
////mskinner 17 fab 2005 -- end 
////Added for work flow. 6/11/2006 Henry
////If  of_get_app_setting("set_47","I") = 1 Then gb_workflow = True  //Move to top by Jervis 06.26.2007
//
//
////Added for pdf to text 12/8/2006 Henry
////gs_current_path = GetCurrentDirectory()//Start Code Change ---- 08.15.2007 #V7 maha  moved further up
//
////--------------------------- APPEON BEGIN ---------------------------
////$<add> 01.24.2007 By: Davis
//Integer li_set_autoresize
//Select set_autoresize
//Into :li_set_autoresize
//From icred_settings;
//IF li_set_autoresize = 1 THEN
//	gb_autoresize = TRUE
//END IF
////---------------------------- APPEON END ----------------------------
//
////Registry dll & ocx file - by alfee 08.17.2007
//of_reg_dllocx() 
//
////--------------------------- APPEON BEGIN ---------------------------
////$<add> 23-03-2007 By: Ken.Guo
////$<reason> set doc's user name to APP login name
//f_set_doc_author(gs_user_id)
////---------------------------- APPEON END ----------------------------
//
////--------------------------- APPEON BEGIN ---------------------------
////$<  Add > 2007-10-30 By: Scofield
////$<Reason> Clean the temporary files
//
//of_CleanTmpFile()
////---------------------------- APPEON END ----------------------------
//
////Start Code Change ----11.15.2008 #V8 maha  opens selected user screen 
//of_open_at_start()
////End Code Change---.2007
//
//

end event

public function integer of_run_updates (integer ai_from);//created as function maha 102704

//--------Begin Modified by Alfee 01.30.2008---------
//<$Note>The original code lines have been removed directly
open(w_priv_update)
w_priv_update.st_update.visible = True
w_priv_update.st_update.bringtotop = true
w_priv_update.cb_update.visible = false
w_priv_update.cb_reset.visible = false
w_priv_update.cb_1.visible = false
w_priv_update.cb_3.visible = False
w_priv_update.st_1.visible = false
w_priv_update.cbx_latest.visible = false
if ai_from = 1 then
	w_priv_update.cb_reset.triggerevent(clicked!)
end if

w_priv_update.cb_update.triggerevent(clicked!)

IF IsValid(w_priv_update) THEN Close(w_priv_update)

return 1
//------End Modified --------------------------------

end function

public function integer of_create_cat_tables ();//Start Code Change ---- 03.20.2006 #326 maha
//maha created function to create the cat tables if they do not exist.  Called from the open event
string ls_sql

long ll_rowcount 
select count(*)
into :ll_rowcount
from pbcatedt;

if ll_rowcount > 0 then return 0

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-04
//$<add> 04.03.2006 By: LeiWei
//$<reason> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
//$<modification> Add the Appeon Start Queue label.
gnv_appeondb.of_startqueue( )
//---------------------------- APPEON END ----------------------------

ls_sql = "CREATE TABLE pbcattbl (	pbt_tnam char(129),	pbt_tid float,	pbt_ownr char(129),	pbd_fhgt float,	pbd_fwgt float,	pbd_fitl char(1),	pbd_funl char(1),	pbd_fchr float,	pbd_fptc float,	pbd_ffce char(18),	pbh_fhgt float,	pbh_fwgt float,	pbh_fitl char(1),	pbh_funl char(1),	pbh_fchr float,	pbh_fptc float,	pbh_ffce char(18),	pbl_fhgt float,	pbl_fwgt float,	pbl_fitl char(1),	pbl_funl char(1),	pbl_fchr float,	pbl_fptc float,	pbl_ffce char(18),	pbt_cmnt char(254));"
execute immediate :ls_sql using sqlca;
commit using sqlca;
ls_sql = "CREATE TABLE pbcatcol (	pbc_tnam char(129),	pbc_tid float,	pbc_ownr char(129),	pbc_cnam char(129),	pbc_cid float,	pbc_labl char(254),	pbc_lpos float,	pbc_hdr char(254),	pbc_hpos float,	pbc_jtfy float,	pbc_mask char(31),	pbc_case float,	pbc_hght float,	pbc_wdth float,	pbc_ptrn char(31),	pbc_bmap char(1),	pbc_init char(254),	pbc_cmnt char(254),	pbc_edit char(31),	pbc_tag char(254));"
execute immediate :ls_sql using sqlca;
commit using sqlca;
ls_sql = "CREATE TABLE pbcatedt (pbe_name char(30) NOT NULL DEFAULT NULL, pbe_edit char(254) DEFAULT NULL, pbe_type smallint DEFAULT NULL, pbe_cntr integer DEFAULT NULL, pbe_seqn smallint NOT NULL DEFAULT NULL, pbe_flag integer DEFAULT NULL, pbe_work char(32) DEFAULT NULL) ;"
execute immediate :ls_sql using sqlca;
commit using sqlca;
ls_sql = "CREATE TABLE pbcatfmt (pbf_name char(30) NOT NULL DEFAULT NULL, pbf_frmt char(254) DEFAULT NULL, pbf_type smallint DEFAULT NULL, pbf_cntr integer DEFAULT NULL) ;"
execute immediate :ls_sql using sqlca;
commit using sqlca;
ls_sql = "CREATE TABLE pbcatvld (pbv_name char(30) NOT NULL DEFAULT NULL, pbv_vald char(254) DEFAULT NULL, pbv_type smallint DEFAULT NULL, pbv_cntr integer DEFAULT NULL, pbv_msg char(254) DEFAULT NULL) ;"
execute immediate :ls_sql using sqlca;


ls_sql = "INSERT INTO pbcatedt VALUES ('###,###.00','###,###.00',90,1,1,32,'10');"
execute immediate :ls_sql using sqlca;
commit using sqlca;
ls_sql ="INSERT INTO pbcatedt VALUES ('#####','#####',90,1,1,32,'10');"
execute immediate :ls_sql using sqlca;
commit using sqlca;

ls_sql ="INSERT INTO pbcatedt VALUES ('###-##-####','###-##-####',90,1,1,32,'00');"
execute immediate :ls_sql using sqlca;
commit using sqlca;
ls_sql ="INSERT INTO pbcatedt VALUES ('MM/DD/YY','MM/DD/YY',90,1,1,32,'20');"
execute immediate :ls_sql using sqlca;
commit using sqlca;
ls_sql ="INSERT INTO pbcatedt VALUES ('DD/MM/YY','DD/MM/YY',90,1,1,32,'20');"
execute immediate :ls_sql using sqlca;
commit using sqlca;
ls_sql ="INSERT INTO pbcatedt VALUES ('MM/DD/YYYY','MM/DD/YYYY',90,1,1,32,'20');"
execute immediate :ls_sql using sqlca;
commit using sqlca;
ls_sql ="INSERT INTO pbcatedt VALUES ('DD/MM/YYYY','DD/MM/YYYY',90,1,1,32,'20');"
execute immediate :ls_sql using sqlca;
commit using sqlca;
ls_sql ="INSERT INTO pbcatedt VALUES ('DD/MMM/YY','DD/MMM/YY',90,1,1,32,'20');"
execute immediate :ls_sql using sqlca;
commit using sqlca;
ls_sql ="INSERT INTO pbcatedt VALUES ('JJJ/YY','JJJ/YY',	90,1,1,32,'20');"
execute immediate :ls_sql using sqlca;
commit using sqlca;
ls_sql ="INSERT INTO pbcatedt VALUES ('JJJ/YYYY','JJJ/YYYY',90,1,1,32,'20');"
execute immediate :ls_sql using sqlca;
commit using sqlca;
ls_sql ="INSERT INTO pbcatedt VALUES ('HH:MM:SS','HH:MM:SS',90,1,1,32,'30');"
execute immediate :ls_sql using sqlca;
commit using sqlca;
ls_sql ="INSERT INTO pbcatedt VALUES ('HH:MM:SS:FFF','HH:MM:SS:FFF',90,1,1,32,'30');"
execute immediate :ls_sql using sqlca;
commit using sqlca;
ls_sql ="INSERT INTO pbcatedt VALUES ('HH:MM:SS:FFFFFF','HH:MM:SS:FFFFFF',90,1,1,32,'30');"
execute immediate :ls_sql using sqlca;
commit using sqlca;
ls_sql ="INSERT INTO pbcatedt VALUES ('MM/DD/YY HH:MM:SS','MM/DD/YY HH:MM:SS',90,1,1,32,	'40');"
execute immediate :ls_sql using sqlca;
commit using sqlca;
ls_sql ="INSERT INTO pbcatedt VALUES ('DD/MM/YY HH:MM:SS','DD/MM/YY HH:MM:SS',90,1,1,32,	'40');"
execute immediate :ls_sql using sqlca;
commit using sqlca;
ls_sql ="INSERT INTO pbcatedt VALUES ('MM/DD/YYYY HH:MM:SS','MM/DD/YYYY HH:MM:SS',90,1,1,32,'40');"
execute immediate :ls_sql using sqlca;
commit using sqlca;
ls_sql ="INSERT INTO pbcatedt VALUES ('DD/MM/YYYY HH:MM:SS','DD/MM/YYYY HH:MM:SS',90,1,1,32,'40');"
execute immediate :ls_sql using sqlca;
commit using sqlca;
ls_sql ="INSERT INTO pbcatedt VALUES ('DD/MMM/YY HH:MM:SS','DD/MMM/YY HH:MM:SS',90,1,1,32,'40');"
execute immediate :ls_sql using sqlca;
commit using sqlca;
ls_sql ="INSERT INTO pbcatedt VALUES ('JJJ/YY HH:MM:SS','JJJ/YY HH:MM:SS',90,1,1,32,'40');"
execute immediate :ls_sql using sqlca;
commit using sqlca;
ls_sql ="INSERT INTO pbcatedt VALUES ('JJJ/YYYY HH:MM:SS','JJJ/YYYY HH:MM:SS',90,1,1,32,	'40');"
execute immediate :ls_sql using sqlca;
commit using sqlca;
ls_sql ="INSERT INTO pbcatedt VALUES ('DD/MM/YY HH:MM:SS:FFFFFF','DD/MM/YY HH:MM:SS:FFFFFF',90,1,1,32,'40');"
execute immediate :ls_sql using sqlca;
commit using sqlca;
ls_sql =" INSERT INTO pbcatfmt VALUES ('[General]','[General]',81,0);"
execute immediate :ls_sql using sqlca;
commit using sqlca;

ls_sql =" INSERT INTO pbcatfmt VALUES ('[General]','[General]',81,0);"
execute immediate :ls_sql using sqlca;
commit using sqlca;
ls_sql =" INSERT INTO pbcatfmt VALUES ('0','0',81,0);"
execute immediate :ls_sql using sqlca;
commit using sqlca;
ls_sql =" INSERT INTO pbcatfmt VALUES ('0.00','0.00',81,0);"
execute immediate :ls_sql using sqlca;
commit using sqlca;
ls_sql =" INSERT INTO pbcatfmt VALUES ('#,##0','#,##0',81,0);"
execute immediate :ls_sql using sqlca;
commit using sqlca;
ls_sql =" INSERT INTO pbcatfmt VALUES ('#,##0.00','#,##0.00',81,0);"
execute immediate :ls_sql using sqlca;
commit using sqlca;
ls_sql =" INSERT INTO pbcatfmt VALUES ('$#,##0;($#,##0)','$#,##0;($#,##0)',81,0);"
execute immediate :ls_sql using sqlca;
commit using sqlca;
ls_sql =" INSERT INTO pbcatfmt VALUES ('$#,##0;[RED]($#,##0)','$#,##0;[RED]($#,##0)',81,0);"
execute immediate :ls_sql using sqlca;
commit using sqlca;
ls_sql =" INSERT INTO pbcatfmt VALUES ('$#,##0.00;($#,##0.00)','$#,##0.00;($#,##0.00)',81,0);"
execute immediate :ls_sql using sqlca;
commit using sqlca;
ls_sql =" INSERT INTO pbcatfmt VALUES ('$#,##0.00;[RED]($#,##0.00)','$#,##0.00;[RED]($#,##0.00)',81,0);"
ls_sql =" INSERT INTO pbcatfmt VALUES ('0%','0%',81,0);"
execute immediate :ls_sql using sqlca;
commit using sqlca;
ls_sql =" INSERT INTO pbcatfmt VALUES ('0.00%','0.00%',81,0);"
execute immediate :ls_sql using sqlca;
commit using sqlca;
ls_sql =" INSERT INTO pbcatfmt VALUES ('0.00E+00','0.00E+00',81,0);"
execute immediate :ls_sql using sqlca;
commit using sqlca;
ls_sql =" INSERT INTO pbcatfmt VALUES ('m/d/yy','m/d/yy',84,0);"
execute immediate :ls_sql using sqlca;
commit using sqlca;
ls_sql =" INSERT INTO pbcatfmt VALUES ('d-mmm-yy','d-mmm-yy',84,0);"
execute immediate :ls_sql using sqlca;
commit using sqlca;
ls_sql =" INSERT INTO pbcatfmt VALUES ('d-mmm','d-mmm',84,0);"
execute immediate :ls_sql using sqlca;
commit using sqlca;
ls_sql =" INSERT INTO pbcatfmt VALUES ('mmm-yy','mmm-yy',	84,0);"
execute immediate :ls_sql using sqlca;
commit using sqlca;
ls_sql =" INSERT INTO pbcatfmt VALUES ('h:mm AM/PM','h:mm AM/PM',84,0);"
execute immediate :ls_sql using sqlca;
commit using sqlca;
ls_sql =" INSERT INTO pbcatfmt VALUES ('h:mm:ss AM/PM','h:mm:ss AM/PM',84,0);"
execute immediate :ls_sql using sqlca;
commit using sqlca;
ls_sql =" INSERT INTO pbcatfmt VALUES ('h:mm:ss','h:mm:ss',84,0);"
execute immediate :ls_sql using sqlca;
commit using sqlca;
ls_sql =" INSERT INTO pbcatfmt VALUES ('m/d/yy h:mm','m/d/yy h:mm',84,0);"
execute immediate :ls_sql using sqlca;
commit using sqlca;

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-05
//$<add> 04.03.2006 By: LeiWei
//$<reason> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance. 
//$<modification> Add the Appeon Commit Queue label.
gnv_appeondb.of_commitqueue( )
//---------------------------- APPEON END ----------------------------


return 1
end function

public subroutine of_cleantmpfile ();//--------------------------- APPEON BEGIN ---------------------------
//$<  Add > 2007-10-30 By: Scofield
//$<Reason> Clean the temporary files

String	ls_LastClrDate
Date		ld_LastDate,ld_Today
long		ll_DiffDays,ll_IntervalDays

n_cst_filesrv inv_filesrv


f_SetFileSrv(inv_filesrv,TRUE)

ll_IntervalDays = ProfileInt(gs_IniFilePathName,"Setup","Interval_Days",30)
if ll_IntervalDays = 0 then return

ls_LastClrDate = ProfileString(gs_IniFilePathName,"Setup","Last_Clear_Date",String(Today(),"YYYY/MM/DD"))
ld_LastDate = Date(ls_LastClrDate)
ld_Today = Today()
ll_DiffDays = DaysAfter(ld_LastDate,ld_Today)

if ll_DiffDays < ll_IntervalDays then return

inv_filesrv.of_deltree(gs_temp_path + "Agreement")
//Start Code Change ---- 10.31.2007 #V7 maha  removed until all functionalities point to the noted temp folder
//	inv_filesrv.of_deltree(gs_dir_path + "IntelliCred\temp\applications")
//	inv_filesrv.of_deltree(gs_dir_path + "IntelliCred\temp\contract")
//	inv_filesrv.of_deltree(gs_dir_path + "IntelliCred\temp\Letters")
//	inv_filesrv.of_deltree(gs_dir_path + "IntelliCred\temp\oig")
//End Code Change---10.31.2007

Destroy inv_filesrv

ls_LastClrDate = String(Today(),"YYYY/MM/DD")
SetProfileString(gs_IniFilePathName,"Setup","Last_Clear_Date",ls_LastClrDate)
//---------------------------- APPEON END ----------------------------

end subroutine

public function integer of_set_global_var ();//Start Code Change ----11.15.2008 #V8 maha function added to clean up global variable setting
Integer li_set_autoresize
integer li_set
integer li_set_9
integer li_set_iapps
integer li_set_51		//Document managerment module
integer li_set_cont //Alfee 05.12.2008
integer li_prelod_ctx //Add by Evan 11/12/2008
integer li_image_storage
integer li_use_opsyntax  //(Appeon)Alfee 06.26.2013 - V141 ISG-CLX
long li_prac_cnt  //maha 06.13.2013  change from integer
string   ls_value //Alfee 04.21.2012
//string ls_dbtype
String	  ls_Option_Value  //(Appeon)Harry 03.18.2014 - V142 ISG-CLX

gi_intelliapp_type = of_get_app_setting("set_15","I")
gi_test_mode = of_get_app_setting("set_10","I")
//ls_dev_head = gds_settings.getitemstring(1,"dev_title")
gi_export_on = of_get_app_setting("set_iauto","I")
gi_ireport_on = of_get_app_setting("set_ireport","I")
gi_scan_format  = of_get_app_setting("set_29","I")
gi_imaging = of_get_app_setting("set_img","I")
gi_priv_mod = of_get_app_setting("set_priv","I")
gi_case_review = of_get_app_setting("set_peer","I")
gi_dept_security = of_get_app_setting("set_37","I")
If  of_get_app_setting("set_47","I") = 1 Then gb_workflow = True
//If of_get_app_setting("set_49","I") = 1 Then gb_ToDoList = True	//12.07.2007 by Jervis //Start Code Change ----12.11.2007 #V8 maha --removed; in version 8 dtl is user based
if of_get_app_setting("set_web","I") = 1 then gb_webview = true //Start Code Change ----08.25.2011 #V11 maha 

gi_iapp_on = of_get_app_setting("set_iapps","I")
li_set_9 = of_get_app_setting("set_9","I")
gi_prod_setting = li_set_9  //Alfee 07.14.2008
//Start Code Change ----01.28.2010 #V10 maha - set gs_cust_type for all types not just App
if li_set_9 = 1 then //app
	gs_cust_type = "I"
elseif li_set_9 = 2 then //Cred SE
	gb_se_version = True
	gs_cust_type = "SE"
elseIF li_set_9 = 4 then //Contracts
	gb_contract_version = True
	gs_cust_type = "X"
elseif li_set_9 = 5 then //Start Code Change ----05.24.2010 #V10 maha - special K
	gb_sk_ver = True
	gs_cust_type = "I"
else
	gs_cust_type = "CRED"
end if
//End Code Change---01.28.2010

//Start Code Change ----10.24.2012 #V12 maha - toolbar option childrens hosp
li_set_9 = of_get_app_setting("set_68","I") 
//Start Code Change ----12.21.2012 #V12 maha - removed system level setting reused for notes set to top.
//if li_set_9 = 1 then gb_use_prac_toolbar = true
if li_set_9 = 2 then gb_notes_at_top = false
//End Code Change ----12.21.2012
//-----Begin Modified by alfee 04.10.2013 for performance tuning ----------------
gnv_appeondb.of_startqueue()
Select set_tdl, set_prelod_ctx, set_4, set_autoresize into :li_set, :li_prelod_ctx, :li_set_9, :li_set_autoresize from security_users where user_id = :gs_user_id;//Add set_autoresize - (Appeon)Alfee 06.26.2013 - V141 ISG-CLX
Select app_stat_facility_label, app_stat_app_label, use_opsyntax  Into :gs_app_stat_facility_label, :gs_app_stat_app_label, :li_use_opsyntax From icred_settings; //Remove set_autoresize - (Appeon)Alfee 06.26.2013 - V141 ISG-CLX
Select Count( prac_id ) INTO :li_prac_cnt FROM pd_basic;
select letter_save_path into :gs_save_path from ids;
SELECT data_view.win_backcolor INTO :gnv_win_backcolor.il_win_backcolor FROM  security_users, data_view 
		WHERE data_view.data_view_id = security_users.contract_default_view AND	security_users.user_id = :gs_user_id;
gnv_appeondb.of_commitqueue()
//select set_4 into :li_set_9 from security_users where user_id = :gs_user_id;
//------End Modified --------------------------------------------------------------------
//if li_set_9 = 100 then gb_use_prac_toolbar = true  //Start Code Change ----10.13.2012 #V12 maha - user level option//Start Code Change ----12.03.2013 #V14 maha - removed

//End Code Change ----10.24.2012

IF ( gi_iapp_on = 0 AND li_set_9 = 0 ) THEN
	gi_action_item_menus = 1  //JUST PSV ACTION ITEMS MENU OPTION
ELSEIF ( gi_iapp_on = 1 AND li_set_9 = 0 ) THEN	
	gi_action_item_menus = 1  //JUST PSV ACTION ITEMS MENU OPTION
ELSEIF ( gi_iapp_on = 1 AND li_set_9 = 1 ) THEN
	gi_action_item_menus = 2  //JUST APPLICATION STATUS ACTION ITEMS MENU OPTION
ELSEIF ( gi_iapp_on = 0 AND li_set_9 = 1 ) THEN
	gi_action_item_menus = 2  //JUST APPLICATION STATUS ACTION ITEMS MENU OPTION
ELSEIF li_set_9 = 3  THEN	
	gi_action_item_menus = 3  //BOTH APPLICATION STATUS ACTION ITEMS MENU OPTION AND PSV OPTION
END IF

//---------Begin Added by Alfee on 05.12.2008----
li_set_cont = of_get_app_setting("set_cont","I")
IF li_set_cont = 1 THEN gb_contract_module = True
//---------End Added -----------------------------

//Start code by jervis 04.10.2008
//IF of_get_app_setting("set_51","I") = 1 THEN
li_set_51 = of_get_app_setting("set_51","I")
IF li_set_51 = 1 or li_set_51 = 2 THEN	//1-Sell/Buy,2-Sell,3-Buy,0-off
//End code by jervis 04.10.2008
	gb_agreement_manager = True
END IF
SetNull(gnv_win_backcolor.il_win_backcolor) //Add by Evan 11/28/2008

//--------Begin Commented by alfee 04.10.2013 ------------------------------
//gnv_appeondb.of_startqueue()
//	Select set_tdl into :li_set   from security_users where user_id = :gs_user_id;
//	Select set_autoresize  Into :li_set_autoresize From icred_settings;
//	Select Count( prac_id ) INTO :li_prac_cnt FROM pd_basic;
//	//select top 1 @@version into :ls_dbtype from ids;
//	select letter_save_path into :gs_save_path from ids;
//	select set_prelod_ctx into :li_prelod_ctx from security_users where user_id = :gs_user_id; //Add by Evan 11/12/2008	
//	SELECT data_view.win_backcolor INTO :gnv_win_backcolor.il_win_backcolor
//	FROM  security_users, data_view
//	WHERE data_view.data_view_id = security_users.contract_default_view AND
//			security_users.user_id = :gs_user_id;//Add by Evan 11/28/2008
// 	SELECT app_stat_facility_label, app_stat_app_label INTO :gs_app_stat_facility_label, :gs_app_stat_app_label FROM icred_settings; //Add by Evan 05.12.2009 --- Corrected BugA090104
//gnv_appeondb.of_commitqueue()
//--------End Commented ----------------------------------------------------------

if gi_citrix = 1 then  //var set in of_get_dir_path
	if isnull(gs_save_path) or LenA(gs_save_path) < 3 then gs_save_path = gs_temp_path + "Letters\Standard\"
	CreateDirectory ( gs_save_path )
else
	gs_save_path = gs_temp_path + "Letters\Standard\"
end if

//database type
//If pos(upper(ls_dbtype) , 'SQL SERVER') > 0 Then
//	gs_dbType = 'SQL'
//Else
//	gs_dbType = 'ASA'
//End If

//Start Code Change ----05.27.2010 #V102 maha - for prac folder coloring for special k
gl_button_bar_color = of_get_app_setting("set_dashb","I")
//messagebox("",gl_bg_color)
choose case gl_button_bar_color
	case 10 //lav
		gl_button_bar_color = 16769510
	case 80 //blue
		//gl_bg_color = 16773360
			gl_button_bar_color =  rgb(168, 205, 241)   //16774640 //16777215 //16114130  //(16445680 lighter blue)
	case 30 //yellow
		gl_button_bar_color =   rgb(255,255,175)  	//15794175
	case 40 //green
		gl_button_bar_color = 15792880
	case 50 //isg blue
		gl_button_bar_color = rgb(41,38,109)
	case 70 //gray
		gl_button_bar_color = rgb (225,225,225)
	case else
		gl_button_bar_color = 16774640
		//gl_bg_color = 15987699
end choose	
//End Code Change---05.27.2010

gl_bg_color = rgb(255,255,255)  //white
//gl_bg_color2 = 255
gl_bg_color2 = 16774640 //  light blue              15987699  //light grey //Start Code Change ----01.07.2016 #V15 maha

//TO DO LIST
//IF li_set = 1 then gb_ToDoList = True
//Start Code Change ----12.11.2007 #V8 maha --modified; in version 8 dtl is user based 
if li_set = 1 then
	if not gb_sk_ver then  //Start Code Change ----04.12.2011 #V11 maha - no todo list in smart
	//gb_ToDoList = true //Start Code Change ----01.23.2008 #V8 maha
		gb_OpenToDoList = true
	end if
end if
//If of_get_app_setting("set_49","I") = 1 Then gb_ToDoList = True  //Start Code Change ----10.28.2009 #V10 maha - should always be true

//---------Begin Modified by (Appeon)Harry 03.18.2014 for V142 ISG-CLX--------
//auto resize
//IF li_set_autoresize = 1 THEN 	gb_autoresize = TRUE
gb_autoresize = TRUE
If gb_contract_version Then
	ls_Option_Value = gnv_user_option.of_Get_option_value( gs_user_id, "m_pfe_cst_master_menu.m_autoresize" ) 
	If ls_Option_Value = '1' Then
		gb_autozoom = True
		gb_cut_autozoom = True
	End If
End If
//---------End Modfiied ------------------------------------------------------

if li_prelod_ctx = 1 then gb_PreloadCTX = true //Add by Evan 11/12/2008

//auto retrieve prac data
IF li_prac_cnt <= 1000 THEN   //Start Code Change ----03.21.2015 #V15 maha - change from 100
	gi_auto_search = 1
ELSE
	gi_auto_search = 0
END IF

gi_print_dialog = of_get_app_setting("set_66","I")  //Start Code Change ----09.30.2011 #V12 maha
gi_email_type = of_get_app_setting("set_56","I")  //Start Code Change ----10.08.2008 #V85 maha
//IF gb_contract_version THEN gi_email_type = 0 //EasyMail for intellicontract - (Appeon)Alfee 07.25.2013 - V141 ISG-CLX - Commented by Alfee 05.27.2014 - V142 ISG-CLX 
IF IsNull(li_use_opsyntax) OR li_use_opsyntax <> 1 THEN gb_use_opmode = FALSE //(Appeon)Alfee 09.24.2013 for V141 ISG-CLX (BugT090202 )

//Get DLL&OCX directory - alfee 01.07.2010
//for web, e.g.'C:\Documents and Settings\Administrator\Application Data\appeon\192.0.3.37_Dotnet_intelliprod\plugin'
gs_dllocx_path = Space(255)
GetDllDirectory(gs_dllocx_path)
gs_dllocx_path = Trim(gs_dllocx_path)
if LenA(gs_dllocx_path) > 0 then gs_dllocx_path += "\"

//Auto down& register plugins or not for Web version - (v12.1 web component) Alfee 04.21.2012
ls_Value = ProfileString(gs_IniFilePathName, "setup", "AutoDwnReg", "1") //for all clients
if ls_Value = "0" then gb_AutoDwnReg = False

li_set = of_get_app_setting("set_72","I") //for specified clients
if li_set = 1 then gb_AutoDwnReg = True

li_image_storage = of_get_app_setting("image_storage_type","I")
if li_image_storage <> 1 then
	messagebox("Image Storage requirement","Version 12 requires that the Images are stored in the database.  Your system is cuttently set to store on the hard drive.~r~rPlease go the System utilities and run the Migrate Images to DB migration tool before doing anything with Practitioner Images or Applications.")
	//open(w_image_to_db_conversion_utility)
End if

//Start Code Change ----08.31.2017 #V154 maha
if of_get_app_setting("set_93","I") = 1 then
	gb_preserve_exp_appt_verif = true
else
	gb_preserve_exp_appt_verif = false
end if
//End Code Change ----08.31.2017 

gb_IsOS64 = of_is_os64 () //alfee 03.26.2014
gs_temp_pdf = of_get_temp_pdf_path (gb_IsOS64) //alfee 03.26.2014

return 1
end function

public function integer of_auto_upgradedb ();//Auto run DB Upgrade
//Used global variables:gs_dbtype,gs_dir_path,Gs_Current_Directory

integer li_db_ver
string ls_db_ver_patch
string ls_dbtype
integer li_set9

//--------Begin Modified by alfee 04.10.2013 for performance tuning-------------
IF IsNull(is_db_ver_patch) OR is_db_ver_patch = "" THEN //Add if statement for upgrade - alfee 07.09.2013
	gnv_appeondb.of_startqueue( )
	//Get auto dbupdate flag
	SELECT set_27 Into :ii_set9 From icred_settings;
	
	//Get the number of version
	SELECT Top 1 set_18 Into :ii_db_ver From icred_settings;
	select top 1 set_patch_ver into :is_db_ver_patch from icred_settings;
	
	//Get DB Type
	select top 1 @@version into :is_dbtype from ids;
	gnv_appeondb.of_commitqueue( )
END IF

li_set9 = ii_set9
li_db_ver = ii_db_ver
ls_db_ver_patch  = is_db_ver_patch
ls_dbtype = is_dbtype
//--------End Modified ------------------------------------------------------

//-------Begin Commented by alfee 03.16.2016 --------------
//<$Reason>The is_dbtype is not valid anymore
//If PosA(upper(ls_dbtype) , 'SQL SERVER') > 0 Then
//	gs_dbType = 'SQL'
//Else
//	gs_dbType = 'ASA'
//End If
//-------End Commented -----------------------------------------

IF li_db_ver < Integer(gs_current_version) THEN
	if MessageBox("Database upgrade","To run the application, the database must be upgraded first. Would you like to upgrade it now?~r~nClick Yes to upgrade it now.~r~nClick No to exit the application.",question!,yesno!,2) = 1 then
		of_run_updates(0) 
	END IF
	ib_from_halt = True //Added By Ken.Guo 07.07.2008
	HALT close
ELSEIF li_db_ver = Integer(gs_current_version) AND li_set9 <> 1 THEN
	if integer(ls_db_ver_patch) < integer(gs_current_version_patch) then
		of_run_updates(0)
	end if
END IF


return 1
end function

public function integer of_test_mode_from_ini (string as_path);//Start Code Change ----07.22.2008 #V8 maha - setting for testmode from ini file
integer i
string ls_val
string ls_path

//Start Code Change ---- 07.30.2008 #V8 maha - Added trap for bad shortcuts
If AppeonGetClientType() = 'PB' then //windows trap
	if upper(MidA(as_path,1,25)) = "C:\DOCUMENTS AND SETTINGS" then //if start in for shortcut is blank
		ls_path = "C:\intellicred"
	elseif upper(as_path) = "C:\" then //if start in is c:\
		ls_path = "C:\intellicred"
	else
		ls_path = as_path
	end if
//end if //Moved it down by Ken.Guo 2008-08-04

	ls_path+= "\intellicred.ini"
	
	if not fileexists(ls_path) then //trap for no file at location
		i = 1 
	else
		ls_val = ProfileString(ls_path, "Setup", "Testmode", "0") 
		i = integer(ls_val)
	end if
	//End Code Change---07.30.2008
//Added by Ken.Guo 2008-08-04
Else
	ls_val = ProfileString("intellicred.ini", "Setup", "Testmode", "0") 
	i = integer(ls_val)	
End if
//End Added by Ken.Guo 2008-08-04

return i
end function

public function integer of_check_version ();//Added by Nova 08.14.2008
// var
Integer li_db_main_ver
String  ls_db_patch_ver
string ls_db_ver
string ls_p_ver
Boolean lb_tip_flag = False
integer res = 0 //maha 10.25.2010

//get value
//--------Begin Modified by alfee 04.08.2013 for performance tuning---------------
li_db_main_ver = of_get_app_setting("set_18","I")
ls_db_patch_ver = of_get_app_setting_ex("set_patch_ver","C")
//SELECT icred_settings.set_18, icred_settings.set_patch_ver INTO :li_db_main_ver, :ls_db_patch_ver From icred_settings  ;
//--------End Modified -------------------------------------------------------------------

//process	
IF li_db_main_ver > Integer(gs_current_version) THEN
	lb_tip_flag = True
ELSEIF li_db_main_ver = Integer(gs_current_version) THEN
	IF Integer(ls_db_patch_ver) > Integer(gs_current_version_patch) THEN
		lb_tip_flag = True
	END IF
END IF
//Start Code Change ----10.25.2010 #V10 maha - moved message to the function from the open event
IF lb_tip_flag THEN
	//put in the . in the version
	ls_db_ver = string(li_db_main_ver)
	ls_db_ver = mid( ls_db_ver,1, len(ls_db_ver) -1) + "." + mid( ls_db_ver, len(ls_db_ver) )
	ls_p_ver = mid( gs_current_version,1, len(gs_current_version) -1) + "." + mid( gs_current_version, len(gs_current_version))
	
	res = MessageBox("Warning","The version of the program ( " + ls_p_ver + " ) is earlier than the version to which the Database has been upgraded( " + string(ls_db_ver) + " ).  This typically means that another installation is running a later version. Use of two different versions of this software on a system is not recommended, as it may potentially cause problems with data integrity.~r~n~nIt is recommended that you click NO and update your software before proceeding.~r~n~nDo you want to continue opening the program without upgrading?",question!,yesno!,2)
end if 

IF res = 2 THEN
	RETURN 1
ELSE
	RETURN 0
END IF
//Start Code Change ----10.25.2010


end function

public function integer of_create_session ();//////////////////////////////////////////////////////////////////////
// $<function>app_fillerof_create_session()
// $<arguments>(None)
// $<returns> integer
// $<description>
// $<description> Check license and Create session
//////////////////////////////////////////////////////////////////////
// $<add> 2008-08-26 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Integer li_session_ret

//Start Code Change ----12.09.2009 #V10 maha - added to allow master to connect even if all licenses are used.
if upper(gs_user_id) = "MASTER" then
	//messagebox("","master") //12.09.2009 #V10 maha - removed msgbox
	return 1
end if
//End Code Change---12.09.2009

//Create session(include license check)
li_session_ret = gnv_session.of_create_session()
If li_session_ret < 0 Then
	Messagebox('Information',gnv_session.of_get_err_msg( li_session_ret ) )
	//Invalid license
	If li_session_ret <= -100 Then
		//Open license window to input it
		Open(w_install_module_update)
		If Message.Stringparm = 'OK' Then 
			//Create it again.
			li_session_ret = gnv_session.of_create_session() 
			If li_session_ret < 0 Then
				Messagebox('Information',gnv_session.of_get_err_msg( li_session_ret ) )
				Return li_session_ret
			End If
		Else
			Return -1
		End If
	Else
		//Failed to create session 
		Return li_session_ret
	End If
End If
	
Return 1
end function

public function integer of_downloaddll ();n_appeon_download lnv_download

lnv_download.of_DownloadDll()

Return 1
end function

public function integer of_initautoexpimpflag ();//////////////////////////////////////////////////////////////////////
// $<function>of_initautoexpimpflag
// $<arguments>
// $<returns> integer
// $<description> Initializes gb_IsAutoExport and gb_IsAutoImport variables
//////////////////////////////////////////////////////////////////////
// $<add> Evan 03.12.2009
//////////////////////////////////////////////////////////////////////

string ls_Value

gb_IsAutoExport = false
gb_IsAutoImport = false
gb_IsAutoExpImp = false

//if AppeonGetClientType() = "PB" then //commented by alfee 01.26.2011 - Web based scheduler
	ls_Value = ProfileString(gs_IniFilePathName, "setup", "AutoExp", "0")
	if ls_Value = "1" then gb_IsAutoExport = true
	
	ls_Value = ProfileString(gs_IniFilePathName, "setup", "AutoImp", "0")
	if ls_Value = "1" then gb_IsAutoImport = true
	
	if gb_IsAutoExport or gb_IsAutoImport then gb_IsAutoExpImp = true
//end if

Return 1
end function

public function integer of_version_expiration ();//Start Code Change ----09.09.2009 #V92 maha - Poison Pill.  Added to encourage version updates as well as to force functional end for inactive customers.
//Start Code Change ----08.26.2010 #V92 maha - Modified for Subscription tracking.
date ld_ver
date ld_end
date ld_check  //maha 08.26.2010
datetime ldt_ver
datetime ldt_end
integer li_days
integer li_sub  //maha 08.26.2010
integer li_return = 1 //maha 08.26.2010
string ls_mess

if upper(gs_user_id) = "MASTER" then return 1

//---------Begin Modified by alfee 04.10.2013 for performance tuning---------------
ldt_ver = DateTime(Date(gnv_data.of_getitem("ids", "pp_date" , false)), Now())
ldt_end = DateTime(Date(gnv_data.of_getitem("ids", "pp_end" , false)), Now())
li_sub = Integer(gnv_data.of_getitem("ids", "pp_s" , false))
//select pp_date, pp_end, pp_s into :ldt_ver , :ldt_end, :li_sub from ids;
//----------End Modified -------------------------------------------------------------

if isnull(ldt_ver)  then return 1

ld_ver = date(ldt_ver)
ld_end = date(ldt_end)

if li_sub > 0 and isnull(ldt_end) then li_sub = 0 //if set to subscrip, but end date is null, treat as version expiration   //Start Code Change ----06.06.2011 #V11 maha

if li_sub > 0 then  //Start Code Change ----06.06.2011 #V11 maha - corrected from > 1
	ld_check = RelativeDate ( ld_end, -60 ) //for subscriptions look 60 days back
	li_days = DaysAfter ( today(), ld_end ) //06.06.2011
else
	if pos(string(ld_ver),"1900",1 ) > 0 then return 1
	ld_check = ld_ver
	li_days = DaysAfter ( today(), ld_end )  //set first date to today so that the count number would decriment
end if

if ld_check > today()  then return 1



if li_sub > 0 then //subscription
	if ld_end < today() then //expired
		ls_mess= "Notice: Your subscription License Key has expired( " + string(ld_end) + " ).  Please contact your Intellisoft Group Support to get an updated license."
			li_return  = -2
	else
		ls_mess= "Notice: Your subscription License Key is nearing expiration; you have " + string(li_days) + " days until the License expires.  Please contact your Intellisoft Group Support to get an updated license."
	end if
else //program life
	if isnull(ld_end) or pos(string(ld_end),"1900",1 ) > 0 then //first time set
		ld_end = RelativeDate ( ld_ver, 60 )
		//if version end update end date
		li_days = 60
		ldt_end = datetime(ld_end,now())
		update ids set pp_end = :ldt_end;
		commit using sqlca;
	
		ls_mess= "Warning: The lifespan of this version is nearing the end, and ISG recommends that you upgrade to the latest version.  You currently have " + string(li_days) + " days until this version can no longer be run.  Please contact Intellisoft Group Support if  you need assistance updating, or if you are unable to update at this time, as they may be able to extend the expiration date.  "
	elseif ld_end < today() then
		ls_mess = "The version license on this program has expired( " + string(ld_end) + " ).  Please contact Intellisoft Group for options on extending your version license."
			li_return =  -1
	elseif ld_end > today() then
			ls_mess = "Warning: The lifespan of this version is nearing the end, and ISG strongly recommends that you upgrade to the latest version.  You have " + string(li_days) + " days until this version can no longer be run.  Please contact Intellisoft Group Support if you need assistance updating, or if you are unable to update at this time, as they may be able to extend the expiration date."
	end if
end if

openwithparm(w_pill_email,ls_mess)

return li_return
end function

public function integer of_initautoschedule ();string ls_Value

//if AppeonGetClientType() = "PB" then //commented by alfee 01.26.2011 - Web based scheduler
	ls_Value = ProfileString(gs_IniFilePathName, "setup", "AutoSchedule", "0")
	if ls_Value = "1" then gb_AutoSchedule = true
//end if

Return 1
end function

public subroutine of_parse_cmdline (string as_commandline);//Parse the command line for the Web version program 
//Moved and modfied from the Open event() for Web based scheduler - alfee 01.26.2011

Integer i, li_pos
int paramindex = 0 //Added by Appeon long.zhang 10.20.2016 (v15.3 SSO Support with SAML)
String ls_sched [3] = {"#scheduler","#autoimport","#autoexport"}
string lsa_queryArray[] //Added by Appeon long.zhang 10.20.2016 (v15.3 SSO Support with SAML)
string ls_idpname_tmp,ls_verifycode_tmp //Added by Appeon long.zhang 10.20.2016 (v15.3 SSO Support with SAML)

gs_CommandLine = as_commandline  //(v12.1 web component) Alfee 05.02.2012 

//For Web version only
IF AppeonGetClientType() <> 'WEB' THEN RETURN

//Determine if a Web based scheduler
IF LenA(Trim(as_commandline)) > 0 THEN
	FOR i = 1 to 3
		li_pos = PosA(Lower(as_commandline), ls_sched [i])
		IF  li_pos > 0 THEN 
			IF i = 1 THEN gb_AutoSchedule = TRUE
			IF i = 2 THEN gb_IsAutoImport = TRUE
			IF i = 3 THEN gb_IsAutoExport = TRUE
			IF i > 1 THEN gb_IsAutoExpImp = TRUE
			as_commandline = LeftA(as_commandline, li_pos - 1)
			EXIT		
		END IF
	NEXT
END IF

//---------Begin Added by (Appeon)Alfee 06.19.2013 for V141 ISG-CLX--------
//Determine the additional parameters for CTX
Long	ll_Pos
String	ls_RunParam,ls_CacheParam,ls_MoveToParam

ls_RunParam = Trim(as_commandline)
is_CommandLine = ls_RunParam  //(Appeon)Alfee 01.24.2014 - V142 ISG-CLX
IF NOT (IsNull(ls_RunParam) or ls_RunParam = "") THEN
	ll_Pos = Pos(ls_RunParam,"%")
	if ll_pos = 0 then ll_pos = Pos(ls_RunParam,"&")	//Fixed Bug, Change parm '%' to '&' - jervis 09.28.2010
	if ll_Pos > 0 then
		ls_CacheParam = Left(ls_RunParam,ll_Pos - 1)
		ls_MoveToParam = Mid(ls_RunParam,ll_Pos + 1)
		
		//------------------- APPEON BEGIN -------------------
		//<$>added:long.zhang 10.20.2016
		//<$>reason:Get idp server name and verify code, Copied from CLX , for v15.3 SSO Support with SAML	
			gnv_string.of_parsetoarray(ls_MoveToParam,"&",lsa_queryArray)
			if UpperBound(lsa_queryArray) > 0 then
				
				FOR paramindex = 1 to UpperBound(lsa_queryArray)
					ls_idpname_tmp = gnv_string.of_getkeyvalue(lsa_queryArray[paramindex],"idpname","=") 
					ls_verifycode_tmp = gnv_string.of_getkeyvalue(lsa_queryArray[paramindex],"verifycode","=")
					if ls_idpname_tmp <> "" then
						gs_idpname = ls_idpname_tmp
					end if
					if ls_verifycode_tmp <> "" then
						gs_verifycode = ls_verifycode_tmp
					end if
					i++
				NEXT
//				if gs_idpname <> "" and gs_verifycode <> "" then
//					messagebox("idp and verify",gs_idpname + ";"  + gs_verifycode)
//				end if				
			end if
		//------------------- APPEON END -------------------
		
		If Lower(Trim(ls_MoveToParam)) = '2docquickview' Then
			gb_DocQuickView = True //Added By Ken.Guo 2010-09-07.				
		Else
			ll_Pos = Pos(ls_MoveToParam,"&")
			if ll_Pos > 0 then
				if IsNumber(Left(ls_MoveToParam,ll_Pos - 1)) then
					gl_MoveToCtxID = long(Left(ls_MoveToParam,ll_Pos - 1))
					ls_MoveToParam = Mid(ls_MoveToParam,ll_Pos + 1)
					ll_Pos = Pos(ls_MoveToParam,"&")
					If ll_Pos > 0 Then 
						gs_MoveToTabNo = Left(ls_MoveToParam,ll_Pos - 1)
						gl_MoveToDocID = Long(Trim(Mid(ls_MoveToParam,ll_Pos + 1)))
					Else
						gs_MoveToTabNo = ls_MoveToParam
					End If
				end if
			end if
		End If
	else
		ls_CacheParam = ls_RunParam
	end if
END IF

if gl_MoveToCtxID > 0 and gl_MoveToDocID > 0 and gs_MoveToTabNo = "912" then
	gb_IsDocMode = true
	gb_PreloadCTX = true
end if

as_commandline = ls_CacheParam
//---------End Added ------------------------------------------------------------------

//Get the connection cache name and type
IF LenA(Trim(as_commandline)) > 0 THEN
	IF PosA(as_commandline,",") > 0 THEN
		gs_CacheName = Lower(Trim(LeftA(as_commandline,PosA(as_commandline,",") - 1)))
		gs_CacheType = Upper(Trim(MidA(as_commandline,PosA(as_commandline,",") + 1)))
	ELSE
		gs_CacheName = Lower(Trim(as_commandline))
	END IF
	
	IF gs_CacheName <> '' THEN
		gs_CacheSet = "CacheName='" + gs_CacheName + "'"
		IF gs_CacheType = '' THEN
			gs_CacheType = "ODB-MSS" //default set to SQLServer
		END IF
	END IF
END IF



end subroutine

public subroutine of_check_doc ();//====================================================================
//$<Function>: of_check_doc()
//$<Arguments>:
//$<Return>:  (none)
//$<Description>: Check MS Word Installed
//$<Author>: (Appeon) Alfee 06.26.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>: From CLX
//====================================================================
//Added By Ken.Guo 12/13/2011. Check MS Word Installed

OLEObject myoleobject

myoleobject = Create oleobject
IF myoleobject.Connecttonewobject("word.application") = 0 THEN 
	myoleobject.Quit(0) 
	myoleobject.DisconnectObject()	
	If isvalid(myoleobject) Then destroy myoleobject
Else
	If isvalid(myoleobject) Then destroy myoleobject
	If Messagebox('IntelliSoft','The system detects that MS Word is not install on your computer. IntelliSoft requires MS Word to be installed, or otherwise you will not be able to use some of the functions. ~r~n~r~nDo you want to continue? ', Exclamation!, YesNo!,2 ) = 2 Then
		ib_from_halt = True //Workaround APB Bug T102801 - alfee 11.13.2013
		Halt Close
	End If	
END IF





end subroutine

public subroutine of_check_registry_right ();//====================================================================
// Function: of_check_registry_right
//--------------------------------------------------------------------
// Description: Check Register
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:         Ken.Guo           Date: 01/14/2013
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History: Moved from CLX - (Appeon)Alfee 06.26.2013 - V141 ISG-CLX
//====================================================================

//---------Begin Modified by (Appeon)Harry 03.18.2014 for V142 ISG-CLX--------
//String ls_test,ls_test2
Long ll_ret
String ls_test,ls_test2, ls_key,ls_key_reg
n_cst_systeminfo lnv_systeminfo
//---------End Modfiied ------------------------------------------------------

ls_test = String(now(),'HHMMSS')
//---------Begin Modified by (Appeon)Harry 03.18.2014 for V142 ISG-CLX--------
//gnv_appeondll.of_registryset("HKEY_LOCAL_MACHINE\SOFTWARE\"+gs_DefDirName,ls_test, regstring!, ls_test) 
//gnv_appeondll.of_registryget( "HKEY_LOCAL_MACHINE\SOFTWARE\"+gs_DefDirName,ls_test, ls_test2)
//gnv_appeondll.of_registrydelete( "HKEY_LOCAL_MACHINE\SOFTWARE\"+gs_DefDirName,ls_test)
ls_key = String(now(),'SS')

ll_ret = gnv_appeondll.of_registryset("HKEY_LOCAL_MACHINE\SOFTWARE\"+gs_DefDirName,ls_key, regstring!, ls_test) 
gnv_appeondll.of_registryget( "HKEY_LOCAL_MACHINE\SOFTWARE\"+gs_DefDirName,ls_key, ls_test2)
gnv_appeondll.of_registrydelete( "HKEY_LOCAL_MACHINE\SOFTWARE\"+gs_DefDirName,ls_key)
//---------End Modfiied ------------------------------------------------------


If ls_test <> ls_test2 Then
	//---------Begin Added by (Appeon)Harry 03.18.2014 for V142 ISG-CLX--------
	//Added By Ken.Guo 05/31/2013
	lnv_systeminfo = Create n_cst_systeminfo
	If lnv_systeminfo.of_get_envvar('ProgramW6432') <> '' or lnv_systeminfo.of_get_envvar('ProgramFiles(x86)')  <> '' Then //Modified By Ken.Guo 03/22/2013
		ls_key_reg = 'HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\' + gs_DefDirName //x86
	Else
		ls_key_reg = 'HKEY_LOCAL_MACHINE\SOFTWARE\'  + gs_DefDirName //X64	
	End If	
	Destroy lnv_systeminfo

	gnv_debug.of_output( True, 'Failed to check registry. gnv_appeondll.of_registryset(...)  = ' + String(ll_ret) )
	gnv_debug.of_output( True,'Set Registry = ' + "HKEY_LOCAL_MACHINE\SOFTWARE\"+gs_DefDirName + '; Key =' + ls_key + '; value = ' + ls_test)
	gnv_debug.of_output( True, 'Get Registry = ' + "HKEY_LOCAL_MACHINE\SOFTWARE\"+gs_DefDirName + '; Key =' + ls_key + '; Get value = ' + ls_test2)
	//---------End Added ------------------------------------------------------
	Messagebox('IntelliSoftGroup',"The system detected that you do not have permission to the Windows Registry key 'HKEY_LOCAL_MACHINE\SOFTWARE'. " +&
										"The system needs to create the registry key ‘HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group’ and its sub keys." +&
										"~r~n~r~nPlease contact your IT administrator to grant you this permission. Otherwise, the performance and some functions will be affected." )
End If

Return 
end subroutine

public subroutine of_clean_emailtempfile ();//====================================================================
//$<Function>: of_clean_emailtempfile()
//$<Arguments>:
//$<Return>:  (none)
//$<Description>: Clean email temporary file
//$<Author>: (Appeon) Alfee 06.26.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>: Moved From CLX
//====================================================================
//Added By Ken.Guo 2009-08-13.
String ls_EmailDirectory,ls_FileName1,ls_FileName2,ls_FileName3,ls_FileName4

ls_EmailDirectory = gs_dir_path + gs_DefDirName + "\Email"
gnv_appeondll.of_parsepath(ls_EmailDirectory)
//ls_FileName1 = ls_EmailDirectory + "\Temp.doc"	
ls_FileName2 = ls_EmailDirectory + "\Empty.doc"	
ls_FileName3 = ls_EmailDirectory + "\Email.htm"	

Long i,ll_max = 1000
For i = 1 to ll_max
	ls_FileName1 = ls_EmailDirectory + "\Temp"+String(i)+".doc"	
	If FileExists(ls_FileName1) Then
		If Not FileDelete(ls_FileName1) and i = ll_max Then
			Messagebox('Delete Temporary File','Failed to delete the temporary file "' +ls_FileName1+ '". ~r~nThis will cause your WindWord.exe process to be locked up.  Please open Windows Task Manager (Ctrl-Alt-Del to bring up option to open Task Manager).  Click on the Process tab and look for the WINWORD.exe process and right click on that entry and click End Process.',Exclamation!)
		End If
	End If
	FileDelete( ls_EmailDirectory + "\~~$Temp"+String(i)+".doc" )
Next

//for performance, don't delete it. Ken.Guo 2010-09-10
//If FileExists(ls_FileName2) Then
//	If Not FileDelete(ls_FileName2) Then
//		Messagebox('Delete Temporary File','Failed to delete the temporary file "' +ls_FileName2+ '". ~r~nThis will cause your WindWord.exe process to be locked up.  Please open Windows Task Manager (Ctrl-Alt-Del to bring up option to open Task Manager).  Click on the Process tab and look for the WINWORD.exe process and right click on that entry and click End Process.',Exclamation!)
//		Return 
//	End If
//End If
FileDelete( ls_EmailDirectory + "\~~$Empty.doc")

If FileExists(ls_FileName3) Then
	If Not FileDelete(ls_FileName3) Then
		Messagebox('Delete Temporary File','Failed to delete the temporary file "' +ls_FileName3+ '". ~r~nThis will cause your WindWord.exe process to be locked up.  Please open Windows Task Manager (Ctrl-Alt-Del to bring up option to open Task Manager).  Click on the Process tab and look for the WINWORD.exe process and right click on that entry and click End Process.',Exclamation!)
		Return 
	End If
End If


Return 
end subroutine

public subroutine of_getting_datacaches ();//====================================================================
//$<Function>: of_getting_datacaches()
//$<Arguments>:
//$<Return>:  (none)
//$<Description>: Get Data Cache
//$<Author>: (Appeon) Alfee 06.20.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>: Moved from CLX
//====================================================================

//----------------------------------------------------------------------------------------------
// 2.24.2016 <RP>: Comment out; try retrieving each cache as needed
//gnv_data.of_refresh_systemdatacache( )
//----------------------------------------------------------------------------------------------

gnv_data.of_get_defaultdddwcache()

If isvalid(w_appeon_gifofwait) Then close(w_appeon_gifofwait)

//gnv_appeondb.of_startqueue() //Restored by Alfee 11.28.2007
//gnv_data.of_retrieve('icred_settings') //cache data for icred_settings table
//gnv_data.of_retrieve('security_users') //cache data for security_users table
////gnv_data.of_retrieve('ids') //cache data for ids table - moved above by alfee 04.10.2013
//gnv_data.of_retrieve('sys_tables') //cache data for sys_tables table
//gnv_data.of_retrieve('code_lookup') //cache data for code_lookup table
//gnv_data.of_retrieve('sys_fields') //cache data for sys_fields and sys_tables table
//gnv_data.of_retrieve('facility') //cache data for facility table
//gnv_data.of_retrieve('data_view_screen') //cache data for data_view_screen table
//gnv_data.of_retrieve('image_type') //cache data for image_type table	
//gnv_data.of_retrieve('code_lookup_2') 
//gnv_data.of_retrieve('wf_workflow')
//gnv_data.of_retrieve('wf_action_types')
//gnv_data.of_retrieve('wf_action_status')
//gnv_data.of_retrieve('wf_trigger_param_data_comparison')
//gnv_data.of_retrieve('wf_trigger_param_action_status')
//gnv_data.of_retrieve('question_lookup') //cache data for question_lookup table - Added by Alan 08.20.2008
//gnv_data.of_retrieve('data_flow') //dataflow - alfee 12.21.2009
//gnv_data.of_retrieve('alert_hdr') // V10.1 - Notification Alert - Andy 01/21/2010
//gnv_data.of_retrieve('app_steps') //Start Code Change ----07.30.2010 #V10 maha
//gnv_data.of_retrieve('process_steps') //Start Code Change ----06.30.2011 #V11 maha
//
//IF gb_contract_module THEN //add if statement by alfee 04.10.2013
//	gnv_data.of_retrieve('ctx_notification') //cache data for ctx_notification table
//	gnv_data.of_retrieve('ctx_ai_notification') //cache data for ctx_ai_notification table - Alfee 02.26.2008
//	gnv_data.of_retrieve('ctx_am_ai_notification') //cache data for ctx_am_ai_notification table - Alfee 02.26.2008
//	gnv_data.of_retrieve('template_clause_rules') //for dynamic add clauses - by Alfee 11.12.2007	 
//END IF
//
//IF appeongetclienttype() = 'WEB' THEN
//	SELECT image_flag Into :gs_image_flag From security_users Where user_id = :gs_user_id;
//END IF
//gnv_appeondb.of_commitqueue()
end subroutine

public subroutine of_ini_registry ();//====================================================================
//$<Function>: of_ini_registry()
//$<Arguments>:
//$<Return>:  (none)
//$<Description>: 
//$<Author>: (Appeon) Alfee 06.26.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>: Moved from CLX
//====================================================================
//Added By Ken.Guo 2009-12-21. In WEB, GDI count will large than 10000(widnows default), and will cause some error(flashing...) 
ULong ll_reg_value

//Use PB function to set
ll_reg_value = 0
RegistryGet( "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows", "GDIProcessHandleQuota", RegULong!, ll_reg_value)
If ll_reg_value <> 16000 Then
	RegistrySet( "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows", "GDIProcessHandleQuota", RegULong!, 16000)
End If
ll_reg_value = 0
RegistryGet( "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows", "USERProcessHandleQuota", RegULong!, ll_reg_value)
If ll_reg_value <> 16000 Then
	RegistrySet( "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows", "USERProcessHandleQuota", RegULong!, 16000)
End If

RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Applets\Wordpad","AllowConversion",RegULong!,1)
gnv_appeondll.of_RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Applets\Wordpad","AllowConversion",RegULong!,1)


//Use DLL function to Set. Sometimes PB function set failed.
ll_reg_value = 0
//gnv_appeondll.of_RegistryGet( "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows", "GDIProcessHandleQuota", RegULong!, ll_reg_value)
//If ll_reg_value <> 16000 Then
	gnv_appeondll.of_RegistrySet( "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows", "GDIProcessHandleQuota", RegULong!, 16000)
//End If
//ll_reg_value = 0
//gnv_appeondll.of_RegistryGet( "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows", "USERProcessHandleQuota", RegULong!, ll_reg_value)
//If ll_reg_value <> 16000 Then
	gnv_appeondll.of_RegistrySet( "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Windows", "USERProcessHandleQuota", RegULong!, 16000)
//End If


end subroutine

public subroutine of_run_email_notifications ();//////////////////////////////////////////////////////////////////////
// $<function>app_fillerof_run_email_notifications()
// $<arguments>(None)
// $<returns> (none)
// $<description>
// $<description> Run Email Notifications
//////////////////////////////////////////////////////////////////////
// $<add> 2010-08-18 by Ken.Guo
// $ Moved from CLX - (Appeon)Alfee 06.26.2013 - V141 ISG-CLX
//////////////////////////////////////////////////////////////////////


//UPDATE ids Set last_query = getdate()  ;
UPDATE ids Set last_query_ctx = getdate()  ;  //(Appeon)Alfee 06.26.2013 - V141 ISG-CLX

n_cst_email_alarm lnv_email_alarm
lnv_email_alarm.of_run_email_alarm( )


end subroutine

public subroutine of_send_email (integer ai_did_allready, integer ai_dir_right, integer ai_run_date_alarm, integer al_interval_days);//====================================================================
//$<Function>: of_send_email()
//$<Arguments>:
// 	value    integer    ai_did_allready
// 	value    integer    ai_dir_right
// 	value    integer    ai_run_date_alarm
// 	value    integer    al_interval_days
//$<Return>:  (none)
//$<Description>: Send All Email Alarms for Contract 
//$<Author>: (Appeon) Alfee 06.26.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>: Moved from CLX and Modified
//====================================================================

//Trigger work flow when on login contractlogix system - jervis 09.02.2010
Long ll_max_id
n_cst_workflow_triggers lnv_workflow

gb_ShowEmailErrorMessage = False
//Run_Email_Notifications
IF ai_did_allready = 0 and ai_dir_right > 0 and gb_DocQuickView = False THEN
	
	//Added By Ken.Guo 2011-08-30.  Workaround APB Bug
	w_mdi.inv_statusbar.of_setrefreshrate( 0 )
	Sleep(1)	
	
	gnv_appeondb.of_startqueue()
	DELETE From ic_array_to_db;
	DELETE From ic_client_data;	
	Select Max(id) into :ll_max_id From em_mail_audit Where user_id = :gs_user_id;
	gnv_appeondb.of_commitqueue()	
	
	//Must Fisrt Run Email Notifications
	If ai_run_date_alarm = 1 Then
		of_run_email_notifications()
	ElseIf ai_run_date_alarm = 0 and al_interval_days >= 10 Then
		If Messagebox('Email Alarms','The system has not sent Email Alarms more than 10 days. ~r~nDo you want to send it now?', Question!,YesNo!) = 1 Then
			//lnv_workflow.post of_trigger_by_onlogin( )
			of_run_email_notifications()
		Else
			//Added By Ken.Guo 2011-01-06. Prevent duplicate reminder
			//UPDATE ids Set last_query = getdate()  ;
			UPDATE ids Set last_query_ctx = getdate()  ;  //(Appeon)Alfee 06.26.2013 - V141 ISG-CLX
//			gnv_webapprove.of_refresh_status( ) 
			gb_ShowEmailErrorMessage = True
			w_mdi.inv_statusbar.of_setrefreshrate( 3 )
			Return 			
		End If
	Else
//		gnv_webapprove.of_refresh_status( ) 
		gb_ShowEmailErrorMessage = True
		w_mdi.inv_statusbar.of_setrefreshrate( 3 )
		Return 
	End If
	
	lnv_workflow = create n_cst_workflow_triggers
	lnv_workflow.of_set_message( false) //11.05.2010 By Jervis
	lnv_workflow.of_trigger_by_onlogin( )	//jervis 09.03.2010	
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 2009-04-14 By: Ken.Guo
	//$<reason> Send checkin email.
	n_cst_email_checkin lnv_email_checkin
	If ai_dir_right > 0 and gb_DocQuickView = False Then
		lnv_email_checkin = Create n_cst_email_checkin
		lnv_email_checkin.of_send_email()
		If Isvalid(lnv_email_checkin) Then Destroy lnv_email_checkin
	End If
	//---------------------------- APPEON END ----------------------------
	
	f_show_email_result(ll_max_id)

	w_mdi.inv_statusbar.of_setrefreshrate( 3 )
	
END IF 
gb_ShowEmailErrorMessage = True


If isvalid(lnv_workflow) Then destroy lnv_workflow
end subroutine

public subroutine of_set_global_word (string as_value);//====================================================================
//$<Function>: of_set_global_word()
//$<Arguments>:
// 	value    string    as_value
//$<Return>:  (none)
//$<Description>: 
//$<Author>: (Appeon) Alfee 06.26.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>: Moved From CLX
//====================================================================
Choose Case as_value
	Case 'open'
		If gnv_data.of_getitem( 'icred_settings', 'preload_word', False) = '1' Then
			If Not isvalid(gole_word_instance) Then
				gole_word_instance = Create oleobject
				IF gole_word_instance.Connecttonewobject("word.application") = 0 THEN 
					gole_word_instance.Application.NormalTemplate.Saved = TRUE
				END IF		
			End If
		End If
	Case 'close'
		If Isvalid(gole_word_instance) Then
			gole_word_instance.Quit(0) 
			gole_word_instance.DisconnectObject()	
			destroy gole_word_instance
		End If
End Choose



end subroutine

public function integer of_check_extra ();//====================================================================
//$<Function>: of_check_extra()
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Extra Checking 
//$<Author>: (Appeon) Alfee 06.19.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Integer li_https, li_set_cont
Integer li_check_registry, li_check_trusted_sites  //(Appeon)Alfee 01.24.2014 - V142 ISG-CLX
String ls_url, ls_tmp
String ls_registry  //(Appeon)Alfee 01.24.2014 - V142 ISG-CLX

//gnv_user_option = Create n_cst_user_option  
If Not ib_ReLogin Then gnv_user_option = Create n_cst_user_option //(Appeon)Harry 03.19.2014 for V142 ISG-CLX

gnv_appeondb.of_startqueue()
gnv_rights = Create n_cst_rights  
gnv_user_option.of_Retrieve( gs_user_id )
//---------Begin Added by (Appeon)Alfee 01.24.2014 for V142 ISG-CLX -------------------
gnv_user_option.of_system_retrieve(  )   
gnv_user_option.of_viewid_retrieve( )
//---------------------- <RP> 3.3.2016------------------------------------------------
//SELECT check_registry, check_trusted_sites Into :li_check_registry, :li_check_trusted_sites From icred_settings;
//-------------------------------------------------------------------------------------
//---------End Added ----------------------------------------------------------------------------

//------------------------<RP> 3.3.2016---------------------------------------------------------------------------
// Use cache rather than performing direct embedded SQL selects
//SELECT https Into :li_https From icred_settings;
//SELECT set_cont Into :li_set_cont From icred_settings;
gnv_appeondb.of_commitqueue()

li_check_registry = Integer(gnv_data.of_getItem("icred_settings", "check_registry", FALSE))
li_check_trusted_sites = Integer(gnv_data.of_getItem("icred_settings", "check_trusted_sites", FALSE))
li_https = Integer(gnv_data.of_getItem("icred_settings", "https", FALSE))
li_set_cont = Integer(gnv_data.of_getItem("icred_settings", "set_cont", FALSE))


//For Web version only
IF AppeonGetClientType() = 'WEB' THEN
	//https
	ls_url = 	appeongetieurl()
	If Not Isnull(li_https) And li_https = 1 Then
		If Upper(Left(ls_url,5)) <> 'HTTPS' Then
				MessageBox("IntelliSoft","The current settings of the system only allow you to access the URL using HTTPS. ~r~n Please change HTTP to HTTPS for accessing the URL.")
				ib_from_halt = TRUE //Workaround APB Bug T102801 - alfee 11.13.2013				
				HALT CLOSE
		End If
	End If

	//trusted sites
	If li_check_trusted_sites = 1 Then //Add if statement - (Appeon)Alfee 01.24.2014 - V142 ISG-CLX
		ls_tmp = gnv_user_option.of_get_option_value(gs_user_id, "trusted_sites" ) 
		If ls_tmp	= '1' or isnull(ls_tmp) or trim(ls_tmp) = '' Then
			If gf_trusted_sites(ls_url) = False Then
				Messagebox(gnv_app.iapp_object.DisplayName,"Please add the current URL <"+ls_url+"> to IE’s trusted sites. Otherwise, the system may not work properly.")
			End If 
		End If
	End If
END IF

//For Contract only
IF li_set_cont = 1 THEN 
	//Check MS Word
	of_check_doc ()
	IF ib_from_halt THEN HALT CLOSE //Workaround APB Bug T102801 - alfee 11.13.2013
	
	//Check Tempdir Right
	ii_dir_right = gnv_rights.of_check_tempdir_right( ) 
	
	//Check Registry Right
	//---------Begin Modified by (Appeon)Alfee 01.24.2014 for V142 ISG-CLX-----------------
	If li_check_registry = 1 Then 
		ls_registry = gnv_user_option.of_get_option_value(gs_user_id, "check_registry")
		If  ls_registry	= '1'  or isnull(ls_registry) or trim(ls_registry ) = '' Then
			of_check_registry_right() 
		End If
	End If
	//of_check_registry_right() 
	//---------End Modfiied ----------------------------------------------------------------

	//Clean email temporary file
	of_clean_emailtempfile() 
	
	//Get lookup values for Contract Web Approval
	gnv_webapprove.of_initialization ()  	
	
	//Save Contract Folder State
	//if ProfileString(gs_IniFilePathName, "Setup", "RestoreState", "0") = '1' then	
	If gnv_user_option.of_Get_option_value( gs_user_id,"restore_contract_state" ) = '1' then  //(Appeon)Alfee 01.24.2014 - V142 ISG-CLX
		gb_restore_contract_state = true
	end if
	
	gi_snaptogrid_x = ProfileInt ( gs_IniFilePathName, "Setup", "SnapToGridX", 1 )
	gi_snaptogrid_y = ProfileInt ( gs_IniFilePathName, "Setup", "SnapToGridY", 1 )	
END IF

RETURN 1
end function

public function integer of_set_odd ();//====================================================================
//$<Function>: of_set_odd()
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Odd Settings - Moved from the Open () event
//$<Author>: (Appeon) Alfee 06.21.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
String ls_app, ls_dev_head, ls

//SET WORD PATH
IF appeongetclienttype() = 'PB' THEN
	IF Not FileExists(gs_IniFilePathName) THEN
		MessageBox("ini File Error", "No intellicred.ini file found at: " + gs_IniFilePathName + "~rThis may cause errors in the program including printing letters." )
	ELSE //check the word path
		IF FileExists( "C:\Program Files\Microsoft Office\Office12\winword.exe") THEN
			SetProfileString(gs_IniFilePathName, "paths", "word", " C:\Program Files\Microsoft Office\Office12\winword.exe")
		ELSEIF FileExists( "C:\Program Files\Microsoft Office\Office11\winword.exe") THEN
			SetProfileString(gs_IniFilePathName, "paths", "word", " C:\Program Files\Microsoft Office\Office11\winword.exe")
		ELSEIF FileExists( "C:\Program Files\Microsoft Office\Office10\winword.exe") THEN
			SetProfileString(gs_IniFilePathName, "paths", "word", " C:\Program Files\Microsoft Office\Office10\winword.exe")
		ELSE
			//leave it as is
		END IF
	END IF
ELSE
	IF FileExists( "C:\Program Files\Microsoft Office\Office12\winword.exe") THEN
		SetProfileString(gs_IniFilePathName, "paths", "word", " C:\Program Files\Microsoft Office\Office12\winword.exe")
	ELSEIF FileExists( "C:\Program Files\Microsoft Office\Office11\winword.exe") THEN
		SetProfileString(gs_IniFilePathName, "paths", "word", " C:\Program Files\Microsoft Office\Office11\winword.exe")
	ELSEIF FileExists( "C:\Program Files\Microsoft Office\Office10\winword.exe") THEN
		SetProfileString(gs_IniFilePathName, "paths", "word", " C:\Program Files\Microsoft Office\Office10\winword.exe")
	ELSE
		//leave it as is
	END IF
END IF

//SET HELP FILES
IF gs_cust_type = "I" THEN //maha 030606
	gnv_app.of_sethelpfile( gs_dir_path + "Intellicred\IntelliApp_User_Guide.chm")
ELSE
	gnv_app.of_sethelpfile( gs_dir_path + "Intellicred\IntelliCred_User_Guide.chm")
END IF

//SET TITLE FOR MDI WINDOW
IF gb_sk_ver then  
	w_mdi.Title = "IntelliApp Smart 16.1" //Kenetics"
	ls_app = "IntelliApp Smart 16.1" //Kenetics"
ElseIF Upper( gs_cust_type ) = 'I' THEN
	w_mdi.Title = "IntelliApp 16.1"
	ls_app = "IntelliApp 16.1"
ELSEIF gb_contract_version = True THEN
	w_mdi.Title = "IntelliContract 16.1"
	ls_app = "IntelliContract 16.1"
ELSE
	w_mdi.Title = "IntelliCred 16.1"
	ls_app = "IntelliCred 16.1"
END IF

IF gi_test_mode = 2 THEN
	w_mdi.Title =  ls_app + " Using Test Database"
ELSEIF gi_test_mode = 1 THEN
	w_mdi.Title =  ls_app + " in Debug Mode"
ELSEIF gi_test_mode = 3 THEN
	ls_dev_head = gds_settings.GetItemString(1,"dev_title")
	IF IsNull(ls_dev_head) THEN ls_dev_head = ""
	w_mdi.Title = ls_app + " using " + ls_dev_head
END IF
gs_mdi_title = w_mdi.title //for clearing out Word instances - Alfee 01.16.2008

//SET TEST MODE
ls = ProfileString(gs_IniFilePathName, "Setup", "Testmode", "0") 
if ls = "1" then gi_test_mode = 1

//CREATE AGREEMENT PATH - (Appeon)Alfee 07.15.2013 - V141 ISG-CLX
IF gb_contract_module THEN 
	gnv_appeondll.of_parsepath(gs_dir_path + gs_DefDirName + "\Agreement\Manager") //Added By Ken.Guo 2010-02-04.
END IF

//---------Begin Added by (Appeon)Stephen 04.13.2016 for Bug #5071 for Case # 00062640: Issue with Printing Applications --------
if not directoryexists(gs_dir_path + gs_DefDirName +"\Letters\Standard") then
	gnv_appeondll.of_parsepath(gs_dir_path + gs_DefDirName + "\Letters\Standard")
end if
//---------End Added ------------------------------------------------------

//SET FOR INTELLIAPP
IF Upper( gs_cust_type ) = 'I' THEN
	UPDATE facility_ver_rules SET default_verif_means = 15, verifY_data = 'B' 	WHERE ( facility_id = 1 ) AND ( facility_ver_rules.screen_id In (4,5,15,19,20,23) ) ;
	IF sqlca.SQLCode = -1 THEN MessageBox("SQL Error", sqlca.SQLErrText )

	IF ii_facility_cnt = 0 THEN
		INSERT INTO committee_lookup ( committee_id, facility_id,	committee_name ) VALUES ( 1, 1, 'Credentialing Committee' )  ;			
		IF sqlca.SQLCode = -1 THEN MessageBox("SQL Error", sqlca.SQLErrText )
	END IF
END IF

//SET GLOBAL MS WORD VARIABLE
//---------Begin Modified by (Appeon)Harry 03.19.2014 for V142 ISG-CLX--------
//IF gb_contract_module THEN of_set_global_word('open')  //(Appeon)Alfee 06.20.2013 - V141 ISG-CLX
IF gb_contract_module THEN 
	If Not ib_ReLogin Then of_set_global_word('open')  //(Appeon)Alfee 06.20.2013 - V141 ISG-CLX
END IF
//---------End Modfiied ------------------------------------------------------

RETURN 1
end function

public function integer of_preload_contract ();
//====================================================================
//$<Function>: of_load_contract()
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Load Contract Window - moved from the Open () event
//$<Author>: (Appeon) Alfee 06.21.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

if gb_contract_version and gb_PreloadCTX and ii_dir_right > 0 then 
	if gb_IsDocMode then
		OpenWithParm(w_appeon_gifofwait,"Loading Document. Please wait...")//This may take a few minutes. ~r~nmodify by gavin 2012-01-10
	else
		OpenWithParm(w_appeon_gifofwait,"Loading Contract Folder. Please wait...")//This may take a few minutes. ~r~n
	end if
	
	Timer(0,w_appeon_gifofwait)
	
	w_appeon_gifofwait.st_1.Height = 120
	w_appeon_gifofwait.st_1.Y = 30
	w_appeon_gifofwait.SetRedraw(true)		//APB Bug - jervis 06.17.2009
	
	w_appeon_gifofwait.of_SetMaxPosition(100)
	w_appeon_gifofwait.of_SetPosition(10)
	w_appeon_gifofwait.of_SetStep(10)
	
	OpenSheet(w_contract, w_mdi, 4, original!)
	w_appeon_gifofwait.of_SkipNextPosition(20)
	w_contract.of_LoadTabpage()
else
	w_mdi.WindowState = Maximized!
	w_mdi.Show()
end if

RETURN 1
end function

public subroutine of_set_relogin_status (boolean ab_relogin);// (Appeon)Harry 03.17.2014 - V142 ISG-CLX Copy from CLX12.0
ib_ReLogin = ab_Relogin
end subroutine

public function integer of_logout ();// (Appeon)Harry 03.17.2014 - V142 ISG-CLX Copy from CLX12.0
Long			ll_i,ll_NullArray[]
Window		lw_Temp, lw_Temp2, lw_NullArray[]


IF Len(Trim(gs_word_user)) > 0 THEN f_set_doc_author(gs_word_user)

//Added By Ken.Guo 07/12/2012. to workaround APB bug. when refresh IE, the popup window do not close.
For ll_i = 1 To UpperBound(gw_popup[])
	If Isvalid(gw_popup[ll_i])  Then
		If gw_popup[ll_i].classname() <> 'w_statusbar' Then Close(gw_popup[ll_i])
	End If
Next

gw_popup = lw_NullArray

lw_Temp = w_mdi.GetFirstSheet( )

do 
	If isvalid( lw_temp ) then	
		lw_Temp2 = w_mdi.Getnextsheet( lw_Temp )
//		if lw_temp.classname() = 'w_contract' then lw_temp.dynamic of_hide( )
		close( lw_Temp )
		lw_Temp = lw_Temp2
	End If

loop while isvalid( lw_temp )

of_log_off()

gnv_session.of_delete_current_session() //Added by Ken.Guo 08.26.2008

gnv_app.of_Setcontraccache( )

If IsValid( ids_screen_fields_cache ) Then Destroy ids_screen_fields_cache
If IsValid( ids_screen_objects_cache ) Then Destroy ids_screen_objects_cache
If IsValid( ids_report_fields_cache ) Then Destroy ids_report_fields_cache
If IsValid( ids_report_objects_cache ) Then Destroy ids_report_objects_cache
If IsValid( ids_screen_report_objects_cache ) Then Destroy ids_screen_report_objects_cache

gl_custom_colors = gl_custom_colors

gi_test_mode = 0

Return 0
end function

public function boolean of_get_relogin_status ();// (Appeon)Harry 03.17.2014 - V142 ISG-CLX Copy from CLX12.0
Return  ib_Relogin
end function

public function integer of_late_db_entries ();//Start Code Change ----08.28.2014 #V14.2 maha
//created to run databse updates later in a deployed version
// at the release of a new version the code should be cleared out
string ls_sql

//Start Code Change ----08.19.2015 #V15 maha
if gs_dbtype = 'ASA' then
	ls_sql = "if exists(select TOP 1 1 from sys.syscolumn c , sys.systable t where c.table_id=t.table_id and " &
	+ "	c.column_name='wv_show_for_affletter' and t.table_name='facility' ) " &
	+ "ALTER TABLE facility ADD wv_show_for_affletter float null "
	execute immediate :ls_sql using sqlca; 
else
	//(Appeon)Modified by Harry 09.27.2016
	/*
	ls_sql = "if exists(select TOP 1 1 from syscolumns c, sysobjects t where c.id=t.id and " &
    + "	c.name='wv_show_for_affletter' and t.name='facility' and t.type = 'U') " &
    + "ALTER TABLE facility ADD wv_show_for_affletter float nul "	
	execute immediate :ls_sql using sqlca;
	*/
	ls_sql = "if exists(select TOP 1 1 from syscolumns c, sysobjects t where c.id=t.id and " &
    + "	c.name='wv_show_for_affletter' and t.name='facility' and t.type = 'U') " &
    + "ALTER TABLE facility ADD wv_show_for_affletter float null "	
	execute immediate :ls_sql using sqlca;
end if

return 1
end function

on app_filler.create
appname="app_filler"
message=create message
sqlca=create n_tr
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on app_filler.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;
Integer li_set_9
Integer li_set7
Integer li_task
Integer li_prac_cnt
Integer vcnt
Integer set_34
Integer setprod
Integer li_logon_cnt
Integer i
Integer li_i_did_allready
Integer li_Rtn
Integer li_days
Integer li_session_ret
Integer li_sess_ret
Integer passmes
Long	  li_rc
String ls_password
String ls_app
String ls_dev_head
String ls_ver_ck
String ls_dir_path
string ls_dbtype
string ls
string ls_version //maha 09.30.2009
Date todaysdate
DateTime ld_lastupdate
DateTime ldt_now
Date ld_password
Date dateing

//---------Begin Added by (Appeon)Alfee 06.19.2013 for V141 ISG-CLX--------
Integer 	li_run_alarm, li_run_date_alarm  
Integer 	li_em_cnt, li_i_did_allready_ctx
Integer 	li_refresh_sertifi, li_check_email = 1
Long		ll_OnlyExport,ll_refresh_interval
Long		ll_interval_days 	
String 	ls_custom_colors
String 	ls_arg_sys, ls_level
String		ls_tmp  //(Appeon)Alfee 01.24.2014 - V142 ISG-CLX

n_cst_string_appeon lnv_string_appeon
n_cst_easymail_pop3 lnv_pop3

If Not ib_ReLogin Then //(Appeon)Harry 03.19.2014 - V142 ISG-CLX
	gnv_debug = Create n_cst_debug 
	gnv_message = Create n_cst_xml_message
	gnv_sertifi = Create n_cst_sertifi 
	gnv_echosign = Create n_cst_echosign  //(Appeon)Alfee 01.24.2014 - V142 ISG-CLX
	gnv_docusign = Create n_cst_docusign  // (Appeon)Harry 07.11.2016 - for docusign
End If
//---------End Added ------------------------------------------------------------------

//GET CURRENT DIRECTORY AND VARIABLES
todaysdate = Today()
ldt_now = DateTime(Today(),Now())

Gs_Current_Directory = GetCurrentDirectory()

gs_current_path = Gs_Current_Directory

if of_test_mode_from_ini(Gs_Current_Directory  ) = 1 then 	gi_test_mode = 1  
of_get_dir_path(Gs_Current_Directory)
gs_temp_path = gs_dir_path  + gs_DefDirName + "\"
inv_appeon_dwonload.of_parsepath (gs_temp_path) //alfee 03.14.2014

SetNUll(Gs_MSFax_ServerName) 

If Not ib_ReLogin Then //(Appeon)Harry 03.19.2014 - V142 ISG-CLX
	gs_client_ip = appeongetclientip()  
	gnv_session = Create n_cst_session 
	gnv_win_backcolor = Create n_cst_backcolor_settings 
	gnv_app = Create n_cst_appmanager
End If

//----------------------<RP> 3.3.2016-------------------------------
gnv_app.of_benchmark("created gnv_app")

//INITIALIZE SCHEDULE FLAG AND PARSE COMMAND LINE
of_InitAutoExpImpFlag() 
of_initautoschedule()
of_ini_registry()  //(Appeon)Alfee 06.19.2013 - V141 ISG-CLX

of_parse_cmdline(commandline) 

//INITIALIZE GLOBAL VARIABLE FOR PRESELECT DATA APPROACH
IF Not IsValid(gnv_data) THEN gnv_data = Create n_cst_globaldata
IF Not IsValid(gnv_word_utility) THEN gnv_word_utility = Create n_cst_word_utility  //(Appeon)Alfee 01.24.2014 - V142 ISG-CLX

If Not ib_ReLogin Then  //(Appeon)Harry 03.19.2014 - V142 ISG-CLX
	gnv_app.Event pfc_Open(CommandLine)
	gs_user_version =  gnv_app.of_getversion( )
	
	//PB Trace - (Appeon)Alfee 01.24.2014 - V142 ISG-CLX
	ls_tmp = ProfileString(gs_IniFilePathName, "Setup", "PBTrace", "0") 
	If AppeonGetClientType() = 'PB' and not isnull(ls_tmp) and ls_tmp = '1' then			
		open(w_trace)
		w_trace.cb_startstop.triggerevent('clicked')
	End IF 
	
//----------------------<RP> 3.3.2016-------------------------------
gnv_app.of_benchmark("pre open w_logon_screen")

	//OPEN LOGON SCREEN AND TEST EXPIRED PASSWORD
	Open( w_logon_screen )
	IF Message.StringParm = "Cancel" Or Message.StringParm = "DB Error" Or Message.StringParm = "" THEN 
		If Message.StringParm = "DB Error" Then
			Halt // (Appeon)Alfee 01.24.2014 - V142 ISG-CLX
		Else
			Halt Close
		End If
	END IF
End If

//----------------------<RP> 3.3.2016-------------------------------
gnv_app.of_benchmark("post-logon")

IF gi_pw_expdays = -1 THEN 
	SELECT set_36 Into :gi_pw_expdays From icred_settings;
END IF
li_set7 = gi_pw_expdays

IF Upper(gs_user_id) = "MASTER" THEN
	//skip. If Login with LDAP user, need not Expired	
	//else //if using expiring passwords for first time on a user it sets the expiration date for x days in the future.  Otherwise it checks the expiration date for the user and gives the appropriate message.
ELSEIF gb_autologin = False THEN
	IF li_set7 > 0 THEN
		SELECT last_pass_update Into :ld_password From security_users Where Upper(user_id) = :gs_user_id;
		li_days = DaysAfter ( Today(), ld_password )
		IF IsNull(ld_password) THEN
			ld_password = RelativeDate ( Today(),li_set7)			
			gnv_appeondb.of_autocommit()
			UPDATE security_users Set last_pass_update = :ld_password Where Upper(user_id) = :gs_user_id;
			COMMIT Using sqlca;
			MessageBox("Password Expiration","Your password will expire in " + String(li_set7) + " days.  You can go to System->Change Password to change" )
		ELSEIF li_days < 0 THEN
			MessageBox("Password Expired","Your password has expired. Please Change.")
			OpenWithParm(w_change_password,"login")
			IF Upper(Message.StringParm) = "CANCEL" THEN
				MessageBox("Expired","Your password has expired.  It will have to be changed, or you will not be able to log in.  Closing program.")
				HALT CLOSE
			END IF
		ELSEIF li_days = 0 THEN  
			passmes = MessageBox("Password Expiring","Your password will be expired after Today.  Would you like to change it now?   If you do not change it today, you will be forced to tomorrow.",question!,yesno!,2 )
			IF passmes = 1 THEN
				DebugBreak()
				OpenWithParm(w_change_password,"login")
			END IF
		ELSEIF li_days <= 10 THEN
			passmes = MessageBox("Password Expiring","Your password will expire in " + String(li_days) + " days.  Would you like to change it now? (You can Go to System->Change Password to change later if you wish.",question!,yesno!,2 )
			IF passmes = 1 THEN
				DebugBreak()
				OpenWithParm(w_change_password,"login")
			END IF
		END IF
	END IF
END IF

//------------------------------- <RP> 3.3.2016-----------------------
gnv_app.of_benchmark("pre of_late_db_entries()")

//Start Code Change ----08.28.2014 #V14.2 maha
of_late_db_entries()

//------------------------------- <RP> 3.3.2016-----------------------
gnv_app.of_benchmark("post of_late_db_entries()")

//CHECT EXTRA SETTINGS
OF_CHECK_EXTRA () //(Appeon)Alfee 06.19.2013 - V141 ISG-CLX 
IF ib_from_halt THEN HALT CLOSE //Workaround APB Bug T102801 - alfee 11.13.2013

//------------------------------- <RP> 3.3.2016-----------------------
gnv_app.of_benchmark("post OF_CHECK_EXTRA()")

//Moved to below by Appeon long.zhang 04.01.2016 (SaaS in citrix environment)
////---------Begin Added by (Appeon)Stephen 02.18.2014 for citrix user's temporary file paths in the Letter Printing--------
//if gi_citrix = 1 then 
//	gs_DefDirName = gs_DefDirName + "\"+ gs_user_id
//end if
//gs_temp_path = gs_dir_path  + gs_DefDirName + "\"
////if NOT DirectoryExists(gs_temp_path) thenCreateDirectory(gs_temp_path)
//if NOT DirectoryExists(gs_temp_path) then inv_appeon_dwonload.of_parsepath (gs_temp_path) //alfee 03.14.2014
////---------End Added ------------------------------------------------------

//GET AND CACHE DATA BEFORE DB UPGRADE 
ids_screen_fields_cache = Create n_ds
ids_screen_fields_cache.DataObject = "d_screen_fields_cache"
ids_screen_fields_cache.of_SetTransObject( sqlca )
ids_screen_objects_cache = Create n_ds
ids_screen_objects_cache.DataObject = "d_screen_objects_cache"
ids_screen_objects_cache.of_SetTransObject( sqlca )
ids_report_fields_cache = Create n_ds
ids_report_fields_cache.DataObject = "d_report_fields_cache"
ids_report_fields_cache.of_SetTransObject( sqlca )
ids_report_objects_cache = Create n_ds
ids_report_objects_cache.DataObject = "d_report_objects_cache"
ids_report_objects_cache.of_SetTransObject( sqlca )
ids_screen_report_objects_cache = Create n_ds
ids_screen_report_objects_cache.DataObject = "d_screen_report_objects_cache"
ids_screen_report_objects_cache.of_SetTransObject( sqlca )

//----------------------<RP> 3.3.2016-------------------------------
gnv_app.of_benchmark("pre-SQL")


//-------------------------<RP> 3.3.2016 disable for testing-----------------
//gnv_appeondb.of_startqueue()
gnv_appeondb.of_startqueue() //Restore queue, Added by Appeon long.zhang 03.24.2016

//---------Begin Modified by (Appeon)Alfee 06.20.2013 for V141 ISG-CLX--------
//SELECT readonly, set_dashboard, prac_window_type Into :gi_user_readonly,:gi_opendashboard, :gi_prac_tab From security_users Where Upper(user_id) = :gs_user_id;  
//lnv_pop3.of_getunreademailcount(2, gs_user_id) 
SELECT COUNT(1) INTO :gl_unread_email_cnt FROM em_mail_items WHERE user_id = :gs_user_id AND (read_status = 0 OR read_status IS NULL) AND (folder_id = 2 AND deleted = 0 ); //BugH112101 - Eugene 12.02.2013	


//------------------------------<RP> 3.3.2016--------------------------------------------------------------------------------------------------------------------------------
// Avoid redundant SELECT statements; where possible, use gnv_data cache
SELECT readonly, set_dashboard, prac_window_type, refresh_sertifi, check_email, set_task, custom_colors, run_date_alarm, image_flag, AutoExport  
	INTO :gi_user_readonly, :gi_opendashboard, :gi_prac_tab, :li_refresh_sertifi, :li_check_email, :li_task, :ls_custom_colors , :li_run_date_alarm, :gs_image_flag, :ll_OnlyExport
	FROM security_users WHERE Upper(user_id) = :gs_user_id;  
//IF gnv_data.of_retrieveIfNecessary("security_users", FALSE) > 0 THEN
//	gi_user_readonly = gnv_data.ids_security_users.getItemNumber(1, "readonly")
//	gi_opendashboard = gnv_data.ids_security_users.getItemNumber(1, "set_dashboard")
//	gi_prac_tab = gnv_data.ids_security_users.getItemNumber(1, "prac_window_type")
//	li_refresh_sertifi = gnv_data.ids_security_users.getItemNumber(1, "refresh_sertifi")
//	li_check_email = gnv_data.ids_security_users.getItemNumber(1, "check_email")
//	li_task = gnv_data.ids_security_users.getItemNumber(1, "set_task")
//	ls_custom_colors = gnv_data.ids_security_users.getItemString(1, "custom_colors")
//	li_run_date_alarm = gnv_data.ids_security_users.getItemNumber(1, "run_date_alarm")
//	gs_image_flag = gnv_data.ids_security_users.getItemString(1, "image_flag")
//	ll_OnlyExport = gnv_data.ids_security_users.getItemNumber(1, "AutoExport")
//	li_set_9 = gnv_data.ids_security_users.getItemNumber(1, "set_home")
//END IF
//SELECT set_home INTO :li_set_9 From security_users WHERE Upper(user_id) = :gs_user_id; //Start Code Change ----07.10.2014 #V14.2 maha
SELECT COUNT(1) INTO :li_em_cnt FROM em_user_config WHERE user_id = :gs_user_id;
//IF gnv_data.of_retrieveIfNecessary("em_user_config", FALSE) > 0 THEN
//	li_em_cnt = gnv_data.ids_em_user_config.rowCount()
//END IF
//SELECT DATEDIFF(day,es_last_refresh,getdate()), DATEDIFF(Day,last_query_ctx,GetDate()) INTO :ll_refresh_interval,:ll_interval_days FROM ids;
//SELECT Count( last_query_ctx) INTO :li_i_did_allready_ctx FROM ids Where Convert(varchar(10),last_query_ctx,101) = convert(varchar(10),getdate(),101); //Get last update date for ctx
//---------End Modfiied ------------------------------------------------------------------	
//SELECT lookup_cache, screen_cache, screen_obj_cache Into :gdt_lookup_cache, :gdt_screen_cache, :gdt_screen_obj_cache From ids;

// <RP> added...
Date ldate_last_refresh, ldate_last_query_ctx
IF gnv_data.of_retrieveIfNecessary("ids", True) > 0 THEN //False -> True, modified by Appeon long.zhang 03.25.2016
	ldate_last_refresh = Date(gnv_data.ids_ids.object.es_last_refresh[1])
	ldate_last_query_ctx = Date(gnv_data.ids_ids.object.last_query_ctx[1])
	ll_refresh_interval = daysAfter(ldate_last_refresh, today())
	ll_interval_days = daysAfter(ldate_last_query_ctx, today())
	IF ll_interval_days = 0 THEN
		li_i_did_allready_ctx = 1
	END IF
	gdt_lookup_cache = gnv_data.ids_ids.object.lookup_cache[1]
	gdt_screen_cache = gnv_data.ids_ids.object.screen_cache[1]
	gdt_screen_obj_cache = gnv_data.ids_ids.object.screen_obj_cache[1]
END IF

SELECT count(user_id) Into :vcnt From sys_user_version Where user_id = :gs_user_id; //Check version
SELECT version_id Into :ls_ver_ck From sys_user_version Where user_id = :gs_user_id;
SELECT Count(*)	INTO :ii_facility_cnt FROM committee_lookup Where committee_lookup.facility_id = 1;	
// <RP> added 3.4.2016
IF gnv_data.of_retrieveIfNecessary("app_session_parms", FALSE) > 0 THEN
	is_dbtype = gnv_data.ids_app_session_parms.object.dbms_version[1]
	vcnt = gnv_data.ids_app_session_parms.object.version_count[1]
	ls_ver_ck = gnv_data.ids_app_session_parms.object.version_id[1]
	ii_facility_cnt = gnv_data.ids_app_session_parms.object.committee_count[1]
END IF

SELECT Top 1 @@version, set_18, set_patch_ver, set_27, run_alarm  INTO :is_dbtype, :ii_db_ver, :is_db_ver_patch, :ii_set9, :li_run_alarm FROM icred_settings; //Add run_alarm by (Appeon)Alfee 06.21.2013 for V141 ISG-CLX 
// <RP> added...
IF gnv_data.of_retrieveIfNecessary("icred_settings", True) > 0 THEN //False -> True, modified by Appeon long.zhang 03.25.2016
	//is_dbtype = 
	ii_db_ver = gnv_data.ids_icred_settings.object.set_18[1]
	is_db_ver_patch = gnv_data.ids_icred_settings.object.set_patch_ver[1]
	ii_set9 = gnv_data.ids_icred_settings.object.set_27[1]
	li_run_alarm = gnv_data.ids_icred_settings.object.run_alarm[1]
END IF
//SELECT Count( last_query) INTO :li_i_did_allready FROM ids Where Convert(varchar(10),last_query,101) = convert(varchar(10),getdate(),101); //Get last update date from ids table

////Start Code Change ----06.03.2014 #V14.2 maha //Start Code Change ----03.31.2015 #V15 maha - moved to update
//update net_dev_action_items set gp_id = 0 where gp_id is null;   //Start Code Change ----05.21.2014 #V14.2 maha
//update pd_appl_tracking set gp_id = 0 where gp_id is null;   //Start Code Change ----05.23.2014 #V14.2 maha
//Update net_dev_ids
//set net_dev_ids.address_id = pd_address.gp_id
//from  net_dev_ids join pd_address
//on  net_dev_ids.address_id = pd_address.rec_id and  pd_address.rec_id is not null;   //Start Code Change ----05.28.2014 #V14.2 maha
////End Code Change ----06.03.2014

//----------------------<RP> 3.3.2016-------------------------------
gnv_app.of_benchmark("post-SQL")

ids_screen_fields_cache.Retrieve()

//----------------------<RP> 3.3.2016-------------------------------
gnv_app.of_benchmark("post ids_screen_fields_cache.Retrieve()")

ids_screen_objects_cache.Retrieve()

//----------------------<RP> 3.3.2016-------------------------------
gnv_app.of_benchmark("post ids_screen_objects_cache.Retrieve()")

//-------------------------<RP> 3.3.2016 disable for testing-----------------
//gnv_appeondb.of_commitqueue()
gnv_appeondb.of_commitqueue() //Restore queue, Added by Appeon long.zhang 03.24.2016

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 02.10.2017
//<$>reason:Don't update last_query before AUTO EXPORT/IMPORT,  For Case #00068610 Expiring Letter Not Generating
////\/**** Should AIQ be run *************************
////Start Code Change ----02.09.2016 #V15 maha - separated from above
//SELECT Count( last_query) INTO :li_i_did_allready FROM ids Where Convert(varchar(10),last_query,101) = convert(varchar(10),getdate(),101); //Get last update date from ids table
//
//// moved from below to reduce chance of AIQ duplicates
//IF NOT gb_contract_version AND li_i_did_allready = 0 THEN
//	UPDATE ids Set last_query = getdate() ;
//	IF sqlca.SQLCode = -1 THEN MessageBox("SQL Error setting last_query date", sqlca.SQLErrText )
//end if
////End Code Change ----02.09.2016
////\**************************************
//------------------- APPEON END -------------------

If isnull(gi_user_readonly) Then gi_user_readonly = 0
If isnull(gi_opendashboard) Then gi_opendashboard = 0	
//if li_set_9 = 0 then gb_home_icon = false  //Start Code Change ----07.10.2014 #V14.2 maha - set variable for home icon - maha 03.15.2016 - removed

//RUN DB UPGRADE 
IF appeongetclienttype() = 'WEB' THEN StopIEpopupmsg()
if not gb_IsAutoExpImp or not gb_AutoSchedule then of_Auto_UpgradeDB() 
IF appeongetclienttype() = 'WEB' THEN ResumeIEpopupmsg()

If Not ib_ReLogin Then //(Appeon)Harry 03.19.2014 - V142 ISG-CLX
	gds_settings = Create datastore 
	gds_settings.DataObject = "d_icred_settings"
	i = gds_settings.SetTransObject(sqlca)
	IF i < 1 THEN
		If ib_from_halt Then //Added By Ken.Guo 07.07.2008. Workaround for APB Bug.
			Messagebox('Database Upgrade','The system exits now. Please log in to the system again.')
		Else
			MessageBox("Database Connection Error","Error connecting to database.  Closing Program")
		End If
		halt
	END IF
End If

//-------------------------- <RP> 3.3.2016
gnv_app.of_benchmark("pre-RETRIEVE AND CACHE OTHER SETTINGS")

//RETRIEVE AND CACHE OTHER SETTINGS
gnv_appeondb.of_startqueue()
//gnv_data.of_retrieve('ids') //cache data for ids table //ids has been retrieved above, comment by Appeon long.zhang 03.24.2016
gds_settings.Retrieve()
IF of_get_app_setting("set_44","I") = 0 THEN
	n_cst_rights LNVO_RIGHTS
	LNVO_RIGHTS = Create n_cst_rights
END IF
gnv_appeondb.of_commitqueue()

//-------------------------- <RP> 3.3.2016
gnv_app.of_benchmark("post-RETRIEVE AND CACHE OTHER SETTINGS")


//POISON PILL - 09.14.2009 #V92 maha
passmes =  of_version_expiration( ) 
if passmes = -1 then 
	if upper(gs_user_id) <> "MASTER" then
		HALT
	end if
elseif passmes = -2 then
	openwithparm(w_install_module_update,"S")
	if message.stringparm = "Cancel" then
		HALT
	end if
end if

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 04.01.2016
//<$>reason:Reset gi_citrix when runpath is not existing in intellicred.ini, Added by Appeon long.zhang 04.01.2016 (SaaS in citrix environment)
//Moved from above and modified 
If AppeonGetClientType() = 'WEB' And  of_get_app_setting("set_citrix","I") = 1 Then gi_citrix = 1

//---------Begin Added by (Appeon)Stephen 02.18.2014 for citrix user's temporary file paths in the Letter Printing--------
if gi_citrix = 1 then 
	gs_DefDirName = gs_DefDirName + "\"+ gs_user_id
end if
gs_temp_path = gs_dir_path  + gs_DefDirName + "\"
if NOT DirectoryExists(gs_temp_path) then inv_appeon_dwonload.of_parsepath (gs_temp_path) //alfee 03.14.2014
//---------End Added ------------------------------------------------------
//------------------- APPEON END -------------------
//SET GLOBAL VARIABLES
OF_SET_GLOBAL_VAR () 

if not gb_IsAutoExpImp or not gb_AutoSchedule then 
	//CHECK VERSION
	IF of_get_app_setting("set_ver_tip","I") = 1 THEN 
		IF of_check_version() = 1  THEN
			HALT CLOSE
		END IF
	END IF
		
	gnv_appeondb.of_startqueue()
	ls_version = LeftA(gs_user_version,75)
	IF vcnt = 0 THEN
		INSERT Into sys_user_version Values (:gs_user_id,:ls_version,:ldt_now);
		COMMIT Using sqlca;
	ELSE	
		IF ls_ver_ck <> gs_user_version THEN
			UPDATE sys_user_version Set version_id = :ls_version,mod_date = :ldt_now Where user_id = :gs_user_id;
			COMMIT Using sqlca;
		END IF
	END IF

	//---------Begin Added by (Appeon)Alfee 06.20.2013 for V141 ISG-CLX--------
	//SET PERSONAL EMAIL CONFIGURATION
	If li_em_cnt = 0 Then
		Insert Into em_user_config(user_id,email_receive_start_date,email_receive_by_date,email_receive_by_clx,email_receive_by_subject,email_receive_all,email_log,email_delete_from_server,email_timer,auto_add_ctx)
		Select :gs_user_id,(select email_start_date from icred_settings),1,1,1,0,2,0,3,1;
	End If
	lnv_string_appeon.of_parsetolangarray(ls_custom_colors,';',gl_custom_colors[])
	gl_custom_colors_org[] = gl_custom_colors[]
	//---------End Added ------------------------------------------------------------------
	gnv_appeondb.of_commitqueue()
	
	//TESTING FOR NEW INSTALL FOR MODULE SETUP
	setprod = of_get_app_setting("set_product","I")
	IF setprod = 1 THEN
		Openwithparm(w_install_module_update, "NEW") 
		gds_settings.Retrieve()
		IF Message.StringParm = "Cancel" THEN
			HALT CLOSE
		elseif Message.StringParm = "Bypass" THEN
			//skip
		else
			messagebox("IntelliSoft Group","License applied.  Please restart program")
			halt
		END IF
	END IF
	
	//CREATE SESSION FOR LICENSE CONTROL
	if gb_cvo_user = false then   //Start Code Change ----02.07.2017 #V153 maha - bypass for isg cvo user
		li_sess_ret = of_create_session()
		If li_sess_ret < 0 and li_sess_ret <> -12 Then
			gnv_session.of_delete_current_session()  //(Appeon)Alfee 06.20.2013 - V141 ISG-CLX
			Halt Close
		End If
	end if
end if

//RETRIEVE DATA CACHES
Openwithparm(w_open_message,"Retrieving Data Caches") //Start Code Change ----11.15.2008 #V8 maha


//-------------------------------- <RP> 3.1.2016------------------------------------------
gnv_app.of_benchmark("Before of_getting_datacaches()")

OF_GETTING_DATACACHES ()  //(Appeon)Alfee 06.20.2013 - V141 ISG-CLX

//-------------------------------- <RP> 3.1.2016------------------------------------------
gnv_app.of_benchmark("After of_getting_datacaches()")

Close(w_open_message)

//AUTO SCHEDULE
if gb_IsAutoExpImp then 
	if gb_IsAutoExport then Open(w_auto_export)
	if gb_IsAutoImport then Open(w_auto_import)
	Return
end if
if gb_AutoSchedule then 
	Open(w_auto_schedule)
	return 
end if

//PROMPT LICENSE AGREEMENT
n_cst_imaging lnv_imaging
IF NOT gb_contract_version THEN //Add if statement - (Appeon)Alfee 06.20.2013 - V141 ISG-CLX
	IF  lnv_imaging.of_prompt_license() = -1 THEN  
		Halt Close
	END IF
END IF

If Not ib_ReLogin Then //(Appeon)Harry 03.19.2014 - V142 ISG-CLX
	//OPEN MDI WINDOW
	This.ToolbarText = true
	if appeongetclienttype() = 'WEB' THEN this.toolbarusercontrol = false //add By Jervis:APB Bug
	Open(w_mdi)
End If

//SET ODD DATA
OF_SET_ODD ()  //(Appeon)Alfee 06.21.2013 - V141 ISG-CLX 

//set doc's user name to APP login name- 23-03-2007 By: Ken.Guo
f_set_doc_author(gs_user_id)

//Registry dll & ocx files - Alfee 08.17.2007
of_reg_dllocx() 

f_get_outlook_64bit() //(Appeon)Stephen 04.28.2014 - get outlook version
//Clean the temporary files - 2007-10-30 By: Scofield
of_CleanTmpFile()
//Clear out invalid Word instances opened by the program - Alfee 01.16.2008
of_clearout_word()

//---------Begin Added by (Appeon)Alfee 06.20.2013 for V141 ISG-CLX--------
//QUICK VIEW CTX DOCUMENTS 
IF gb_DocQuickView THEN 
	OpenSheet( w_documents_browse, w_mdi, 0, Original!) 
	RETURN
END IF

//OCR CTX DOCUEMTNS
IF ll_OnlyExport = 2  THEN
	OpenWithParm(w_ocr_all_document,"AUTO")
	Halt close
END IF
//---------End Added ------------------------------------------------------------------

//---------Begin Added by (Appeon)Alfee 01.24.2014 for V142 ISG-CLX -------------------
if ll_OnlyExport = 4 then
	gb_AutoReport = True
	OpenWithParm(w_auto_report,'')
	Halt close
end if
//---------End Added ----------------------------------------------------------------------------

//---------Begin Modified by (Appeon)Alfee 06.20.2013 for V141 ISG-CLX (Reconstructed)--------
//ACTION ITEMS QUERY FOR INTELLICRED

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 02.10.2017
//<$>reason:Moved from above, reduce time between gettig and setting last query, For Case #00068610 Expiring Letter Not Generating
If NOT gb_contract_version Then
	SELECT Count( last_query) INTO :li_i_did_allready FROM ids Where Convert(varchar(10),last_query,101) = convert(varchar(10),getdate(),101); //Get last update date from ids table
	IF  li_i_did_allready = 0 THEN
		UPDATE ids Set last_query = getdate() ;
		IF sqlca.SQLCode = -1 THEN MessageBox("SQL Error setting last_query date", sqlca.SQLErrText )
	end if
End If
//------------------- APPEON END -------------------

IF NOT gb_contract_version AND li_i_did_allready = 0 THEN
	gnv_appeondb.of_startqueue()
	DELETE From ic_array_to_db;
	DELETE From ic_client_data;	
	//UPDATE ids Set last_query = getdate()  ;  //Start Code Change ----02.09.2016 #V15 maha - moved above to reduce time between gettig and setting last query
	gnv_appeondb.of_commitqueue()
	IF sqlca.SQLCode = -1 THEN MessageBox("SQL Error setting last_query date", sqlca.SQLErrText )
	
	//AI Query for IntelliCred/App
	IF appeongetclienttype() = 'WEB' THEN StopIEpopupmsg()
	pfc_n_cst_ai_printletters lnv_exp_cred	
	lnv_exp_cred = Create pfc_n_cst_ai_printletters
	lnv_exp_cred.of_run_ai_query(1) 
	Destroy lnv_exp_cred
	IF appeongetclienttype() = 'WEB' THEN ResumeIEpopupmsg()

	//Remind Emails by Work Flow for IntelliCred/App
	n_cst_workflow_triggers	lnv_workflow
	lnv_workflow = Create n_cst_workflow_triggers
	lnv_workflow.of_reminder_mail_process_ic ()		
	Destroy lnv_workflow	
	
	//---------Begin Added by (Appeon)Harry 05.19.2016 Application Electronic Signature - Sertifi--------
	If gnv_data.of_getitem( 'icred_settings', 'esign', False) ='1' Then
		If isnull(gs_esigntype) or gs_esigntype = '' Then gs_esigntype = lower(gnv_data.of_getitem( 'icred_settings', 'esign_type', False))
		If gs_esigntype = 'sertifi' Then gnv_sertifi.of_refresh_sertifi_status(0, 0, 0)
		If gs_esigntype = 'docusign' Then gnv_docusign.of_refresh_sertifi_status(0, 0, 0)   //Added by (Appeon)Harry 07.15.2016
	End If
	//---------End Added ----------------------------------------------------	
END IF

//ACTION ITEMS QUERY FOR CONTRACT
IF gb_contract_module AND ii_dir_right > 0 THEN
	//Refresh status for CTX Web Approval
	gnv_webapprove.of_refresh_status( ) 	
	
	//Refresh Sertifi for CTX When User Login	
	gs_esigntype = lower(gnv_data.of_getitem( 'icred_settings', 'esign_type', False))  //(Appeon)Alfee 01.24.2014 - V142 ISG-CLX
	If gnv_data.of_getitem( 'icred_settings', 'esign', False) ='1' and li_refresh_sertifi = 1 And &
		gnv_data.of_getitem('security_users' ,'refresh_sertifi' ,'user_id = "' + gs_user_id +'"' ) = '1' Then	
//		gnv_sertifi.of_refresh_sertifi_status()
//		gnv_echosign.of_refresh_sertifi_status()	 //(Appeon)Alfee 01.24.2014 - V142 ISG-CLX
		 // (Appeon)Harry 07.11.2016 - for docusign
		long 		ll_count
		Select count(1) Into :ll_count from ctx_am_document 
		where checkout_status = '5'  and (esign_type = 'sertifi' or esign_type = 'echosign' or esign_type = 'docusign' ) ;
	
		if ll_count > 0 then 
			gnv_sertifi.of_refresh_sertifi_status()
			gnv_echosign.of_refresh_sertifi_status()
			gnv_docusign.ib_ping_server = false 
			gnv_docusign.of_refresh_sertifi_status()
			gnv_docusign.ib_ping_server = true 
		end if 
	End If	
	
	//SEND ALL EMAIL ALARMS FOR CONTRACT
	IF li_run_alarm = 1 OR IsNull(li_run_alarm) THEN
		POST of_send_email (li_i_did_allready_ctx, ii_dir_right, li_run_date_alarm, ll_interval_days) 
	END IF	
END IF	
//---------End Modified --------------------------------------------------------------------------------

//---------Begin Added by (Appeon)Harry 05.19.2016 Application Electronic Signature - Sertifi--------
If gnv_data.of_getitem( 'icred_settings', 'esign', False) ='1' Then
	If isnull(gs_esigntype) or gs_esigntype = '' Then gs_esigntype = lower(gnv_data.of_getitem( 'icred_settings', 'esign_type', False))
End If
//---------End Added ----------------------------------------------------	

//AUTO TEST PATH AT LOGIN - mskinner 17 fab 2005
IF of_get_app_setting("set_44","I") = 0 THEN
	ls_ver_ck = LNVO_RIGHTS.OF_start( )
	IF ls_ver_ck <> "OK" THEN
		OpenWithParm( w_sql_msg,ls_ver_ck)
	END IF
	Destroy LNVO_RIGHTS
END IF

//PRELOAD CONTRACT WINDOW
//OF_PRELOAD_CONTRACT () //(Appeon)Alfee 06.20.2013 for V141 ISG-CLX
If Not ib_ReLogin Then OF_PRELOAD_CONTRACT () //(Appeon)Harry 03.19.2014 for V142 ISG-CLX

//OPEN DASHBOARD
If gi_opendashboard = 1 and w_mdi.of_security_access(6942) <> 0 Then
	Opensheet(w_dashboard,w_mdi,4, Original!)
End If

//OPEN PREFERED WINDOW
//Post of_open_at_start()  //Start Code Change ----02.01.2016 #V15 maha - changed function
Post of_open_at_start_new(true)

//REMIND EMAIL SETTING
i = of_get_app_setting("set_56","I")
li_task = of_get_app_setting("set_64","I")
//if i = 1 or li_task = 1 then  
if i = 1 or li_task = 1 or (gb_contract_module and (IsNull(li_check_email) or li_check_email = 0)) then  //(Appeon)Alfee 06.21.2013 - V141 ISG-CLX 	
	//skip for outlook or if not required
else
	Post f_EmailSettingRemind(True) 
end if
	
//-------------------------- <RP> 3.3.2016
gnv_app.of_benchmark("app_filler: end of open() event")

end event

event close;long ll_i 
//select set_cont into :ll_i  from icred_settings;

If isvalid(w_trace) then Close(w_trace)  //(Appeon)Alfee 01.24.2014 - V142 ISG-CLX

//Restore the default user in Word - alfee 07.08.2008
IF LenA(Trim(gs_word_user)) > 0 THEN f_set_doc_author(gs_word_user)

//---------Begin Added by (Appeon)Alfee 06.26.2013 for V141 ISG-CLX--------
//Added By Ken.Guo 07/12/2012. to workaround APB bug. when refresh IE, the popup window do not close.
For ll_i = 1 To UpperBound(gw_popup[])
	If Isvalid(gw_popup[ll_i]) Then Close(gw_popup[ll_i])
Next
//---------End Added ------------------------------------------------------------------

of_log_off()  //Start Code Change ---- 10.05.2006 #686 maha

gnv_app.of_SetDwCache ( False )
destroy gds_settings

//Start code by Jervis 01-12-2008, APB Unsupport.
if AppeonGetClientType() = 'NONE'/*'PB'*/ then //Modified by Evan 04.10.2012
	inv_Coolmenu.of_Uninitialize()
	Destroy inv_Coolmenu
end if

if IsValid(gds_contract_screen) then
	Destroy gds_contract_screen
end if

 //Commented by (Appeon)Alfee 01.24.2014 - V142 ISG-CLX
//if IsValid(gnv_data) then
//	Destroy gnv_data
//end if

If isvalid(gnv_dashboard_data) Then
	Destroy gnv_dashboard_data
End If

gnv_session.of_delete_current_session() //Added by Ken.Guo 08.26.2008

of_set_global_word('close') //(Appeon)Alfee 06.26.2013 for V141 ISG-CLX
if AppeonGetClientType() = 'WEB' then ResumeIEpopupmsg() //(Appeon)Alfee 06.26.2013 for V141 ISG-CLX

Disconnect Using SQLCA;

//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 08.23.2007 By: Evan
//$<Reason> Need to destroy object.
if IsValid(gnv_data) then Destroy gnv_data
if IsValid(gds_lookup) then Destroy gds_lookup
if IsValid(gnv_app) then Destroy gnv_app
If Isvalid(gnv_session) Then Destroy gnv_session //Added by Ken.Guo 08.26.2008
If Isvalid(gnv_debug) Then Destroy gnv_debug  //(Appeon)Alfee 06.24.2013 - V141 ISG-CLX
If isvalid(gnv_rights ) Then Destroy gnv_rights  //(Appeon)Alfee 06.24.2013 - V141 ISG-CLX
If isvalid(gnv_message) Then Destroy gnv_message //(Appeon)Alfee 07.26.2013 - V141 ISG-CLX
If isvalid(gnv_word_utility ) Then Destroy gnv_word_utility  //(Appeon)Alfee 01.24.2014 - V142 ISG-CLX
//---------------------------- APPEON END ----------------------------
if isvalid(w_mdi) then w_mdi.hide()   //Start Code Change ----05.20.2011 #V11 maha 

if isvalid(w_idle) then close(w_idle) //for Web version - alfee 10.23.2012

end event

event systemerror;

f_system_error_handler ('')
end event

event idle;IF appeongetclienttype() = "PB" AND (gb_AutoSchedule OR gb_IsAutoExpImp) THEN RETURN //alfee 07.25.2013

gnv_app.event pfc_idle( )

end event

