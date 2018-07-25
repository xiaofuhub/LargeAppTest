$PBExportHeader$u_cst_todolist.sru
forward
global type u_cst_todolist from u_base
end type
type cb_collapse from picturebutton within u_cst_todolist
end type
type cb_max from commandbutton within u_cst_todolist
end type
type dw_result from u_dw within u_cst_todolist
end type
type cb_close from picturebutton within u_cst_todolist
end type
type cb_refresh from picturebutton within u_cst_todolist
end type
type cb_print from picturebutton within u_cst_todolist
end type
type cb_go from picturebutton within u_cst_todolist
end type
type cb_save from picturebutton within u_cst_todolist
end type
type dw_facility from u_dw within u_cst_todolist
end type
type st_time from statictext within u_cst_todolist
end type
type dw_action_status from u_dw within u_cst_todolist
end type
type tv_results from u_tvs within u_cst_todolist
end type
end forward

global type u_cst_todolist from u_base
integer width = 2848
integer height = 1604
long backcolor = 33551856
event ue_retrieve_todolist ( )
event ue_close ( )
event ue_refresh_dddw ( datastore ads_tdl )
event ue_resize ( )
event ue_ini ( )
event ue_move_picture ( )
event ue_refresh_unread_email ( )
event ue_move_max_button ( )
cb_collapse cb_collapse
cb_max cb_max
dw_result dw_result
cb_close cb_close
cb_refresh cb_refresh
cb_print cb_print
cb_go cb_go
cb_save cb_save
dw_facility dw_facility
st_time st_time
dw_action_status dw_action_status
tv_results tv_results
end type
global u_cst_todolist u_cst_todolist

type prototypes
//BEGIN---Modify by Jervis 12.02.2008
Function long SendMessage(long hWnd, ulong Msg, long wParam, long lParam) Library "user32.dll" Alias For "SendMessageA"

end prototypes

type variables
n_ds dw_document,dw_document_all
n_ds dw_tdl_intelliapp,dw_tdl_intelliapp_all
//see ue_ini for object definitions
n_ds dw_tdl_intellicontract,dw_tdl_intellicontract_all
n_ds dw_tdl_intellicred, dw_tdl_intellicred_all
n_ds dw_todoitem
n_ds ds_tdl_icon  //(Appeon)Eugene 06.04.2013 - V141 ISG-CLX
n_ds dw_tdl_app_audit, dw_tdl_app_audit_all // Add by andy 12/10/2009 (V10.1 - TDL)
n_ds dw_tdl_alert_item, dw_tdl_alert_item_all // Add by andy 12/26/2009 (V10.1 - TDL)
n_ds dw_tdl_recruit,dw_tdl_recruit_all//Added by Appeon long.zhang 09.23.2013 (V14.1 Recruitment Functionality)
n_ds dw_tdl_pracview,dw_tdl_pracview_all//Added by Appeon long.zhang 03.24.2014 (V14.2 To Do List for PracView)
n_ds dw_task_recruit, dw_task_recruit_all //(Appeon)Stephen 05.28.2015 - V15.1-Additional TDL type of Recruitment Task
//---------Begin Added by (Appeon)Harry 03.14.2014 for V142 ISG-CLX--------
n_cst_dm_utils inv_utils //Added By Ken.Guo 03/27/2013

window iw_parent 
//---------End Added ------------------------------------------------------

Private:

STRING is_filter[]
STRING is_where[]

LONG il_facility_id

STRING is_sql_intellicred
STRING is_sql_intelliapp
STRING is_sql_intellicontract
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.21.2007 By: Machongmin
//$<reason> Fix a defect.
string Is_sql_document
//---------------------------- APPEON END ----------------------------

string Is_sql_app_audit // Add by andy 12/10/2009 (V10.1 - TDL)
string Is_sql_alert_item // Add by andy 12/26/2009 (V10.1 - TDL)
string is_sql_recruit	//Added by Appeon long.zhang 09.23.2013 (V14.1 Recruitment Functionality)
string is_sql_pracview //Added by Appeon long.zhang 03.24.2014 (V14.2 To Do List for PracView)
string is_sql_task_recruit //(Appeon)Stephen 05.26.2015 - V15.1-Additional TDL type of Recruitment Task
String is_user_id_facility_retrieved //Added by Appeon long.zhang 04.13.2017 (user_id to retrieve facility dddw)

LONG il_tdl_id[]
LONG il_tdli_id[]
LONG il_tdli_cnt[]

w_contract iw_contract
w_prac_data_1 iw_prac

STRING is_module[]

BOOLEAN ib_doubleclick

DatawindowChild idwc_action_status

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.16.2007 By: Machongmin
//$<reason> Fix a defect.
boolean ib_isvalid_contract = true
//---------------------------- APPEON END ----------------------------

//---------Begin Added by (Appeon)Eugene 06.04.2013 for V141 ISG-CLX--------
Datetime idt_where_due_date

str_picture_index istr_picture_index[]

//---------End Added ------------------------------------------------------

pfc_cst_nv_data_entry_functions inv_data_entry//Added by Appeon long.zhang 12.26.2014

n_cst_datastore ids_net_dev_action_items //Added by Appeon long.zhang 12.26.2014

//---------Begin Added by (Appeon)Harry 03.14.2014 for V142 ISG-CLX--------
Public:
Long 			il_ctx_id 					//Added By Mark Lee 12/26/2012
boolean		ibn_use_ctx_id	= False 	//Added By Mark Lee 12/27/2012
//---------End Added ------------------------------------------------------

end variables

forward prototypes
public function integer of_fill_tdl_data (long ll_handle)
public function integer of_fill_treeview ()
public function integer of_fill_report (datawindow adw)
public subroutine of_item_changed (long handle)
public function integer of_run_action (integer ai_action, string as_sql_where)
public function integer of_goto_practitioner_action (long ll_prac_id, long ll_facility_id, long ll_parent_facility_id, long ll_rec_id, long ll_seq_no, string ls_moveto, string ls_action)
public function integer of_goto_practitioner (long ll_prac_id, long ll_facility_id, long ll_parent_facility_id, long ll_rec_id, long ll_seq_no, string ls_moveto, string ls_action)
public function integer of_goto_contract (long ll_ctx_id, string ls_moveto)
public function integer of_find_actionitem (integer al_seq_id)
public function integer of_find_document (integer al_doc_id, string as_tabpage, integer al_seq_id)
public function integer of_preview_doc ()
public function integer of_27_11 (long al_doc_id, string as_moveto, long al_seq_id)
public function integer of_29_09 (long al_doc_id, string as_moveto, long al_seq_id)
public function integer of_clausemap ()
public function integer of_29_10 (long al_doc_id, string as_moveto, long al_seq_id)
public function integer of_30 (long al_doc_id, string as_moveto, long al_seq_id)
public function integer of_31 (long al_doc_id, string as_moveto, long al_seq_id)
public subroutine of_set_bg_color (long al_color)
public subroutine of_set_where_due_date (datetime ldt_due_date)
public function string of_gen_where_due_date (string as_module_id)
public subroutine of_retrievedata ()
public subroutine of_reset_tv_picture ()
public function integer of_find_picture_index (string as_picturename)
public subroutine of_showcontract ()
public subroutine of_setredraw_details_dws ()
public function integer of_fill_tdl_data (long ll_handle, string as_type)
public subroutine of_invisible_close_button (boolean abn_visible)
public subroutine of_set_contractmodule (string ab_value)
public function integer of_getwhereclause (ref string as_where, ref string as_filter, integer ai_days, string as_field, string as_tablename)
public function string of_get_sql_facilities ()
public function string of_get_sql_facilities_exists (string as_facility_column_name)
end prototypes

event ue_retrieve_todolist();LONG ll_row,ll_rowcnt
LONG ll_Action_Type
LONG ll_Action_Status
INTEGER ll_Print_Flag
INTEGER ll_Due_Date
STRING ls_Max_Sends_Flag
STRING ls_sql_where
STRING ls_sql_filter
BOOLEAN lb_exists_term
STRING ls_sql
STRING ls_tdl_module
STRING ls_tdl_name
STRING ls_colname
LONG ll_tdli_id, ll_tdl_id, ll_cnt, i
LONG ll_null[]
STRING ls_null[]
LONG ll_audit_status, ll_audit_received_date //andy 12/09/2009 (V10.1 - TDL)
n_cst_string lnvo_string //andy 12/18/2009 (V10.1 - TDL)
String ls_user_id2 //andy 12/18/2009 (V10.1 - TDL) Use for saving gs_user_id
string ls_status = "(1,4)"  //maha 07.19.2011 - for potential customization 
Long ll_UserType //(Appeon)Harry 11.28.2013
String ls_AssignUser //(Appeon)Harry 11.28.2013
String ls_AmAssignUser //(Appeon)Harry 11.28.2013
string ls_test  //maha 09.21.2015
integer li_sig_status //(Appeon)Stephen 10.28.2016 - V15.3-To Do List additional Modifications
long ll_de_comp, ll_doc_comp, ll_re_comp, ll_att_comp,ll_agr_comp , ll_fin_comp//Added by Appeon long.zhang 03.18.2014 (V14.2 To Do List for PracView)

//---------Begin Added by (Appeon)Harry 03.02.2015 for V151-Additional TDL Filters--------
String ls_addtl_filter
long ll_facility_id
long ll_table_id
//---------End Added ------------------------------------------------------

if of_get_app_setting("set_61","I") = 1 then ls_status = "(1,4,3)"  //maha 07.20.2011 - to allow inactive providers to be included in todolist 
// Retrieve todolist Begin
SetPointer( HourGlass! )

// Initialize array
il_tdl_id = ll_null
il_tdli_id = ll_null
il_tdli_cnt = ll_null
is_filter = ls_null
is_where = ls_null

dw_tdl_intellicred_all.Reset( )
dw_tdl_intelliapp_all.Reset( )
dw_tdl_intellicontract_all.Reset( )
This.of_reset_tv_picture( ) //(Appeon)Eugene 06.05.2013 - V141 ISG-CLX

String ls_user_id
ls_user_id = dw_facility.GetItemString(1, "user_id")
IF NOT f_validstr(ls_user_id) THEN ls_user_id = gs_user_id

ls_user_id2 = gs_user_id
if PosA(ls_user_id,"'") > 0 then ls_user_id  = lnvo_string.of_globalreplace( ls_user_id, "'", "''")
if PosA(ls_user_id2,"'") > 0 then ls_user_id2  = lnvo_string.of_globalreplace( ls_user_id2, "'", "''")

string ls_ext_sql,ls_other_user 
long ll_tdl_right
//---------Begin Modified by (Appeon)Eugene 06.05.2013 for V141 ISG-CLX--------
//SELECT tdl_rights,tdl_other_user into :ll_tdl_right,:ls_other_user from security_users where user_id = :gs_user_id;
If ls_user_id = '-ALL-' Then
	//Added by Ken.Guo on 2009-02-26
	ll_tdl_right = 2
	ls_other_user = ''
Else
	SELECT tdl_rights,tdl_other_user into :ll_tdl_right,:ls_other_user from security_users where user_id = :gs_user_id;
End If
//---------End Modfiied ------------------------------------------------------

//Start Code Change ----10.25.2012 #V12 maha
if upper(ls_user_id) = "PUBLIC" then ll_tdl_right = 2
//End Code Change ----10.25.2012
//debugbreak()
// Construct SQL according to term of to do item.
FOR ll_row = 1 TO dw_todoitem.Rowcount()

	ll_tdl_id = dw_todoitem.GetitemNumber( ll_row, "tdl_id" )
	ll_tdli_id = dw_todoitem.GetitemNumber( ll_row, "tdli_id" )
	ls_tdl_name = dw_todoitem.GetitemString( ll_row, "tdl_basic_info_tdl_name" )
	ls_tdl_module = dw_todoitem.GetitemString( ll_row, "tdl_basic_info_module" )
	
	ll_Action_Type = dw_todoitem.GetitemNumber( ll_row, "Action_Type" )
	ll_Action_Status = dw_todoitem.GetitemNumber( ll_row, "Action_Status" )
	ll_Print_Flag = dw_todoitem.GetitemNumber( ll_row, "Print_Flag" )
	ll_Due_Date = dw_todoitem.GetitemNumber( ll_row, "Due_Date" )
	ls_Max_Sends_Flag = dw_todoitem.GetitemString( ll_row, "Max_Sends_Flag" )
	// Add by andy 12/09/2009 (V10.1 - TDL)
	If ls_tdl_module = "06" Then
		ll_audit_status = dw_todoitem.GetitemNumber( ll_row, "audit_status" )
		ll_audit_received_date = dw_todoitem.GetitemNumber( ll_row, "audit_received_date" )
	End If
	
	//---------Begin Added by (Appeon)Stephen 10.28.2016 for V15.3-To Do List additional Modifications--------
	if ls_tdl_module = "02" then
		if (gnv_data.of_getitem( 'icred_settings', 'esign', False) ='0' or gs_esigntype = 'echosign') then //(Appeon)Stephen 02.14.2017 - V15.3-To Do List additional Modifications:BugL012302
		else
			li_sig_status = dw_todoitem.GetitemNumber( ll_row, "sig_status" )
		end if
	end if
	//---------End Added ------------------------------------------------------
	
	If ls_tdl_module = "09" Then//Added by Appeon long.zhang 03.18.2014 (V14.2 To Do List for PracView)
		ll_de_comp = ll_action_type
		ll_doc_comp = ll_Action_Status
		ll_re_comp = ll_print_flag
		ll_att_comp = ll_due_date
		ll_agr_comp = dw_todoitem.getitemnumber( ll_row, 'tdl_detail_user_type')
		ll_fin_comp =	dw_todoitem.getitemnumber( ll_row, 'tdl_detail_condition01')
	End If
	
	//---------Begin Modified by (Appeon)Harry 11.28.2013 for V141 for BugH112601 of Reintegration Issues--------
	ll_UserType = dw_todoitem.GetitemNumber(ll_row, "tdl_detail_user_type")
	if IsNull(ll_UserType) then ll_UserType = 1
	if ll_UserType = 1 then
		ls_AssignUser = "ctx_action_items.action_user"
		ls_AmAssignUser = "ctx_am_action_item.action_user"
	else
		ls_AssignUser = "ctx_action_items.wf_assigned_by"
		ls_AmAssignUser = "ctx_am_action_item.wf_assigned_by"
	end if
	//---------End Modfiied ------------------------------------------------------
	
	ls_sql_where = ""
	ls_sql_filter = ""
	lb_exists_term = FALSE
	
	//---------Begin Added by (Appeon)Harry 03.14.2014 for V142 ISG-CLX--------
	If not isnull(il_ctx_id) and ibn_use_ctx_id = True then 
		//Begin - Added By Mark Lee 01/03/2013
		CHOOSE CASE ls_tdl_module
				CASE "03","04"		//Contract Logix
	//				lb_exists_term = TRUE
					ls_sql_where += "  ctx_basic_info.ctx_id = "+string(il_ctx_id) +" AND "
					ls_sql_filter += " ctx_id = "+string(il_ctx_id) +" AND "
		End Choose 				
		//End - Added By Mark Lee 01/03/2013
	end if
	//---------End Added ------------------------------------------------------

	// Facility - Modify by andy 12/09/2009 (V10.1 - TDL)
	// IF (ls_tdl_module = "01" OR ls_tdl_module = "02") AND il_facility_id > 0 THEN
//	IF (ls_tdl_module = "01" OR ls_tdl_module = "02" OR ls_tdl_module = "06" OR ls_tdl_module = "07") AND il_facility_id > 0 THEN
//	IF (ls_tdl_module = "01" OR ls_tdl_module = "02" OR ls_tdl_module = "06" OR ls_tdl_module = "07" OR ls_tdl_module = "09") AND il_facility_id > 0 THEN//Added by Appeon long.zhang 03.18.2014 (V14.2 To Do List for PracView)
	IF (ls_tdl_module = "01" OR ls_tdl_module = "02" OR ls_tdl_module = "06" OR ls_tdl_module = "07" OR ls_tdl_module = "09")  THEN //Added by Appeon long.zhang 12.19.2014 (To Do list facility security)
		CHOOSE CASE ls_tdl_module
			CASE "01"		//IntelliCred
				//ls_colname = "verif_info.facility_id"
				ls_colname = "pd_affil_stat.parent_facility_id" //Bug 3112 - alfee 05.25.2012
			CASE "02"		//IntelliApp
				ls_colname = "net_dev_action_items.facility_id"
			CASE "06" 			// Add by andy 12/09/2009 (V10.1 - TDL)
				ls_colname = "pd_app_audit.facility_id"
			CASE "07"			// Add by andy 12/26/2009 (V10.1 - TDL)
				ls_colname = "alert_records.facility_id"
			CASE "09"//Added by Appeon long.zhang 03.18.2014 (V14.2 To Do List for PracView)
				ls_colname = "wv_prac_tracking.facility_id"			
		END CHOOSE

		IF lb_exists_term THEN
			ls_sql_where += " AND "
			ls_sql_filter += " AND "
		END IF

		//------------------- APPEON BEGIN -------------------
		//<$>added:long.zhang 12.19.2014
		//<$>reason:To Do list facility security
		
		//ls_sql_where += ls_colname + " = " + String(il_facility_id)
		If il_facility_id > 0 Then
			ls_sql_where += ls_colname + " = " + String(il_facility_id)
		Else
			//------------------- APPEON BEGIN -------------------
			//<$>added:long.zhang 04.13.2017
			//<$>reason:Use Exists() condion instead of in condition. Mednax- ODBC connect message and Data retrieval Case#70296 Bug_id#5602
			//ls_sql_where += ls_colname + " in (" + of_get_sql_facilities() + ")"
			ls_sql_where += of_get_sql_facilities_exists(ls_colname)
			//------------------- APPEON END -------------------
		End if
		
		/*
		//Begin Modified by long.zhang 08.31.2011 #BugL082903
		//ls_sql_filter += "facility_id = " + String(il_facility_id)
		IF ls_tdl_module = "06" THEN
			ls_sql_filter += "pd_app_audit_facility_id = " + String(il_facility_id)
		ELSEIF 	ls_tdl_module = "07" THEN
			ls_sql_filter += "alert_records_facility_id = " + String(il_facility_id)
		ELSEIF ls_tdl_module = "01" THEN 
			ls_sql_filter += "pd_affil_stat_parent_facility_id = " + String(il_facility_id) //Bug 3112 - alfee 05.25.2012	
		elseif 	ls_tdl_module = "09" then//Added by Appeon long.zhang 03.26.2014 (V14.2 To Do List for PracView)
			ls_sql_filter += "wv_prac_tracking_facility_id = " + String(il_facility_id)
		ELSE
			ls_sql_filter += "facility_id = " + String(il_facility_id)
		END IF
		//End Modified by long.zhang 08.31.2011
		*/
		IF ls_tdl_module = "06" THEN
			ls_colname = "pd_app_audit_facility_id"
		ELSEIF 	ls_tdl_module = "07" THEN
			ls_colname = "alert_records_facility_id"
		ELSEIF ls_tdl_module = "01" THEN 
			ls_colname = "pd_affil_stat_parent_facility_id"
		elseif 	ls_tdl_module = "09" then
			ls_colname = "wv_prac_tracking_facility_id"
		ELSE
			ls_colname = "facility_id"
		END IF

		If il_facility_id > 0 Then
			ls_sql_filter += ls_colname + " = " + String(il_facility_id)
		Else
			ls_sql_filter += ls_colname + " in (" + of_get_sql_facilities() + ")"
		End if	
		//------------------- APPEON END -------------------
		
		lb_exists_term = TRUE
	END IF
	
//	IF Not (ls_tdl_module = "06" OR ls_tdl_module = "07") Then // Add by andy 12/09/2009 (V10.1 - TDL)
//	IF Not (ls_tdl_module = "06" OR ls_tdl_module = "07" or ls_tdl_module = "08") Then //long.zhang 09.22.2013 (V14.1 Recruitment Functionality)
	IF Not (ls_tdl_module = "06" OR ls_tdl_module = "07" or ls_tdl_module = "08" or ls_tdl_module = "09") Then//Added by Appeon long.zhang 03.18.2014 (V14.2 To Do List for PracView)
		// Term of Action Type
   		IF Not IsNull(ll_Action_Type) THEN //Nova 03.26.2010
			CHOOSE CASE ls_tdl_module
				CASE "01"		//IntelliCred
					ls_colname = "verif_info.verification_method"
				CASE "02"		//IntelliApp
					ls_colname = "net_dev_action_items.action_type"
				CASE "03"		//IntelliContract
					ls_colname = "ctx_action_items.action_type"
				case "04"
					ls_colname = "ctx_am_action_item.action_type"
				case "10" //(Appeon)Stephen 05.25.2015 - V15.1-Additional TDL type of Recruitment Task
					ls_colname = "action_type"
			END CHOOSE
	
			IF lb_exists_term THEN
				ls_sql_where += " AND "
				ls_sql_filter += " AND "
			END IF
			//---------Begin Modified by Nova 03.26.2010------------------------
			//ls_sql_where += ls_colname + " = " + String( ll_Action_Type )
			//ls_sql_filter += "action_type = " + String( ll_Action_Type )
			IF ll_Action_Type = -1    THEN // Action Type Is Null
				if ls_tdl_module <> "10" then //(Appeon)Stephen 06.02.2015 - V15.1-Additional TDL type of Recruitment Task
					ls_sql_where += ls_colname + " is null "
					//ls_sql_filter += " isnull(ll_Action_Type) "
					ls_sql_filter += " isnull(action_type) "	//long.zhang 08.29.2011 - #Bugl082003  
				else
					ls_sql_where += " 1=1 "
					ls_sql_filter += " 1 =1 "
				end if
			ELSEIF Not IsNull(ll_Action_Type) THEN
				ls_sql_where += ls_colname + " = " + String( ll_Action_Type )
				ls_sql_filter += "action_type = " + String( ll_Action_Type )
			END IF
			//--------End Modified --------------------------------------------
			lb_exists_term = TRUE
		END IF
	
		// Term of Action Status
		//IF ll_Action_Status > 0 OR ll_Action_Status = -1 or isnull(ll_action_status) THEN  //Start Code Change ----07.29.2009 #V92 maha - added null
		IF Not IsNull(ll_Action_Status) THEN //Nova 03.26.2010
			CHOOSE CASE ls_tdl_module
				CASE "01"		//IntelliCred (verifications)
					ls_colname = "verif_info.response_code"
				CASE "02"		//IntelliApp (Appl Status)
					ls_colname = "net_dev_action_items.action_status"
				CASE "03"		//IntelliContract
					ls_colname = "ctx_action_items.action_status"
				case "04"
					ls_colname = "ctx_am_action_item.action_status"
				case "10" //(Appeon)Stephen 05.25.2015 - V15.1-Additional TDL type of Recruitment Task
					ls_colname = "action_status"
			END CHOOSE
	
			IF lb_exists_term THEN
				ls_sql_where += " AND "
				ls_sql_filter += " AND "
			END IF

			//IF ll_Action_Status = -1  or isnull(ll_action_status) THEN // Action Status Is Null
			IF ll_Action_Status = -1  THEN // Nova 03.26.2010
				if ls_tdl_module <> "10" then //(Appeon)Stephen 06.02.2015 - V15.1-Additional TDL type of Recruitment Task
					ls_sql_where += ls_colname + " is null "
					ls_sql_filter += " isnull(action_status) "
				else
					ls_sql_where += " 1=1 "
					ls_sql_filter += " 1 =1 "
				end if
			ELSE
				ls_sql_where += ls_colname + " = " + String( ll_Action_Status )
				ls_sql_filter += "action_status = " + String( ll_Action_Status )
			END IF
	
			lb_exists_term = TRUE
		END IF
	
		// Term of Print Flag
		IF ll_Print_Flag >= 0  and not(ls_tdl_module = "10")THEN //(Appeon)Stephen 05.25.2015 -add " not ls_tdl_module = "10"" V15.1-Additional TDL type of Recruitment Task
			IF lb_exists_term THEN
				ls_sql_where += " AND "
				ls_sql_filter += " AND "
			END IF
	
			ls_sql_where += "Print_Flag = " + String( ll_Print_Flag )
			ls_sql_filter += "Print_Flag = " + String( ll_Print_Flag )
			
			lb_exists_term = TRUE
		END IF
		
		// Term of Due Date
		IF ll_Due_Date >= 0 THEN
			IF lb_exists_term THEN
				ls_sql_where += " AND "
				ls_sql_filter += " AND "
			END IF
			//--------------appeon begin--------------------------
			//<$>Modified:long.zhang appeon 05.16.2013
			//<$>reason:Problem with To do list regarding due dates Bug id # 3537
//			IF ll_Due_Date = 0 THEN
//				ls_sql_where += "Due_Date < getdate()"
//				ls_sql_filter += "Due_Date < today()"
//			//Start Code Change ----03.16.2011 #V11 maha - added today option
//			ELSEIF ll_Due_Date = 1 THEN
//				// messagebox("","today")
//				ls_sql_where += " (Due_Date >= dateadd(day,-1,getdate()) and Due_Date <= dateadd(day,1,getdate()))"
//				ls_sql_filter += "date(Due_Date) = today()"
//			//End Code Change ----03.16.2011
//			ELSE
//				ls_sql_where += "(Due_Date >= getdate() AND Due_Date <= dateadd(day," + String(ll_Due_Date) + ",getdate()))"
//				ls_sql_filter += "(Due_Date >= today() AND Due_Date <= RelativeDate(today()," + String(ll_Due_Date) + "))"
//			END IF
			
			IF ll_Due_Date = 0 THEN
				ls_sql_where += "convert(char(10),Due_Date,126) < convert(char(10),getdate(),126)"
				ls_sql_filter += "date(Due_Date) < date(today())"
			//Start Code Change ----03.16.2011 #V11 maha - added today option
			ELSEIF ll_Due_Date = 1 THEN
				// messagebox("","today")
				ls_sql_where += " (convert(char(10),Due_Date,126) = convert(char(10),getdate(),126))"
				ls_sql_filter += "date(Due_Date) = date(today())"
			//End Code Change ----03.16.2011
			ELSE
				ls_sql_where += "(convert(char(10),Due_Date,126) >= convert(char(10),getdate(),126) AND convert(char(10),Due_Date,126) <= convert(char(10),dateadd(day," + String(ll_Due_Date) + ",getdate()),126))"
				ls_sql_filter += "(date(Due_Date) >= date(today()) AND date(Due_Date) <= RelativeDate(date(today())," + String(ll_Due_Date) + "))"
			END IF

			//--------------appeon end-----------------------------------
			lb_exists_term = TRUE
		END IF
	
		// Max Number Attempts
		IF ls_Max_Sends_Flag = '1' and not(ls_tdl_module = "10")THEN //(Appeon)Stephen 05.25.2015 -add " not ls_tdl_module = "10"" V15.1-Additional TDL type of Recruitment Task
			IF lb_exists_term THEN
				ls_sql_where += " AND "
				ls_sql_filter += " AND "
			END IF
			
			CHOOSE CASE ls_tdl_module
				CASE "01"		//IntelliCred
					//ls_sql_where += "(verif_info.number_sent >= wf_action_status.send_count OR verif_info.number_sent >= facility_ver_rules.ver_letter_max_sends)"
					ls_sql_where += "(Exists (select 1 from wf_action_status where verif_info.wf_id = wf_action_status.wf_id &
											AND verif_info.wf_action_type_id = wf_action_status.step_id &
											AND verif_info.response_code = wf_action_status.action_status_id &
											AND verif_info.number_sent >= wf_action_status.send_count) &
											OR Exists (select 1 from facility_ver_rules where facility_ver_rules.facility_id = verif_info.facility_id &
											AND facility_ver_rules.screen_id = verif_info.screen_id &
											AND verif_info.number_sent >= facility_ver_rules.ver_letter_max_sends) )"
					ls_sql_filter += "(number_sent >= wf_action_status_send_count OR number_sent >= facility_ver_rules_ver_letter_max_sends)"
					ls_colname = "wf_action_status.send_count"
				CASE "02"		//IntelliApp
					//ls_sql_where += "net_dev_action_items.number_sent >= wf_action_status.send_count"
					ls_sql_where += "(Exists (select 1 from wf_action_status where net_dev_action_items.wf_id = wf_action_status.wf_id &
											AND net_dev_action_items.wf_action_type_id = wf_action_status.step_id &
											AND net_dev_action_items.action_status = wf_action_status.action_status_id &
											AND  net_dev_action_items.number_sent >= wf_action_status.send_count)) "
					ls_sql_filter += "number_sent >= wf_action_status_send_count"
				CASE "03"		//IntelliContract
					//ls_sql_where += "ctx_action_items.no_attemp >= wf_action_status.send_count"
					ls_sql_where += "(Exists (select 1 from wf_action_status where ctx_action_items.wf_id = wf_action_status.wf_id &
											AND ctx_action_items.wf_action_type_id = wf_action_status.step_id &
											AND ctx_action_items.action_status = wf_action_status.action_status_id &
											AND ctx_action_items.no_attempts >= wf_action_status.send_count))"
					ls_sql_filter += "number_sent >= wf_action_status_send_count"
				case "04"
					ls_sql_where += "(Exists (select 1 from wf_action_status where ctx_am_action_item.wf_id = wf_action_status.wf_id AND ctx_am_action_item.wf_action_type_id = wf_action_status.step_id AND ctx_am_action_item.action_status = wf_action_status.action_status_id AND ctx_am_action_item.Attempt_Times >= wf_action_status.send_count))"
					ls_sql_filter += "Attempt_Times >= wf_action_status_send_count"
			END CHOOSE
	
			lb_exists_term = TRUE
		END IF
	End If

	// Add by andy 12/10/2009 (V10.1 - TDL)
	If ls_tdl_module = "06" Then
		// Term of Status
		ls_colname = "pd_app_audit.data_status"

		IF lb_exists_term THEN
			ls_sql_where += " AND "
			ls_sql_filter += " AND "
		END IF
		
		IF isnull(ll_audit_status) THEN // Status Is Null

			ls_sql_where += ls_colname + " is null "
			ls_sql_filter += " isnull(pd_app_audit_data_status) "
		ELSE
			ls_sql_where += ls_colname + " = " + String( ll_audit_status )
			ls_sql_filter += "pd_app_audit_data_status = " + String( ll_audit_status )
		END IF

		lb_exists_term = TRUE
		
		//Term of Received Date
		IF ll_audit_received_date >= 0 THEN
			IF lb_exists_term THEN
				ls_sql_where += " AND "
				ls_sql_filter += " AND "
			END IF
	
			IF ll_audit_received_date = 0 THEN
				ls_sql_where += "pd_app_audit.date_completed is Null"
				ls_sql_filter += "isnull(pd_app_audit_date_completed)"
			ELSE
				ls_sql_where += "pd_app_audit.date_completed is Not Null"
				ls_sql_filter += "Not isnull(pd_app_audit_date_completed)"
			END IF
	
			lb_exists_term = TRUE
		END IF
		
	END IF

	// Add by andy 01/14/2010 (V10.1 - TDL)
	If ls_tdl_module = "07" Then
		// Term of Alert Category
		IF ll_Action_Type > 0 THEN
			ls_colname = "alert_hdr.alert_category"
	
			IF lb_exists_term THEN
				ls_sql_where += " AND "
				ls_sql_filter += " AND "
			END IF
			
			ls_sql_where += ls_colname + " = " + String( ll_Action_Type )
			ls_sql_filter += "alert_hdr_alert_category = " + String( ll_Action_Type )
			
			lb_exists_term = TRUE
		END IF

		// Term of Alert Type
		IF ll_Action_Status > 0 THEN
			ls_colname = "alert_hdr.alert_type"
	
			IF lb_exists_term THEN
				ls_sql_where += " AND "
				ls_sql_filter += " AND "
			END IF
			
			ls_sql_where += ls_colname + " = " + String( ll_Action_Status )
			ls_sql_filter += "alert_hdr_alert_type = " + String( ll_Action_Status )
			
			lb_exists_term = TRUE
		END IF
		
		// Term of Active Status
		IF ll_Due_Date <> -1 THEN
			ls_colname = "alert_records.active_status"
	
			IF lb_exists_term THEN
				ls_sql_where += " AND "
				ls_sql_filter += " AND "
			END IF
			
			ls_sql_where += ls_colname + " = " + String( ll_Due_Date )
			ls_sql_filter += "alert_records_active_status = " + String( ll_Due_Date )
			
			lb_exists_term = TRUE
		END IF
	End If
	
	//-------------appeon begin----------------------
	//<$>added:long.zhang 09.22.2013
	//<$>reason:V14.1 Recruitment Functionality
	If ls_tdl_module = "08" Then
		
		if ll_Action_Type <> -1 then
			IF lb_exists_term THEN
				ls_sql_where += " AND "
				ls_sql_filter += " AND "
			END IF
			
			of_getwhereclause(ls_sql_where,ls_sql_filter,ll_action_type,'add_date','recruit_prac')
			lb_exists_term = true
		end if
		
		if ll_Due_Date <> -1 then
			IF lb_exists_term THEN
				ls_sql_where += " AND "
				ls_sql_filter += " AND "
			END IF
			
			of_getwhereclause(ls_sql_where,ls_sql_filter,ll_Due_Date,'mod_date','recruit_prac')
			lb_exists_term = true
		end if
		
		if not isNull(ll_Action_Status) then
			IF lb_exists_term THEN
				ls_sql_where += " AND "
				ls_sql_filter += " AND "
			END IF
				ls_sql_where += 'recruit_status=' + String(ll_Action_Status)
				ls_sql_filter +=  'recruit_status=' + String(ll_Action_Status)
			end if
			lb_exists_term = true
	end if

//-------------appeon End------------------------

//-------------appeon begin----------------------
//<$>added:long.zhang 03.18.2014
//<$>reason:V14.2 To Do List for PracView
	If ls_tdl_module = "09" Then
//			ll_de_comp = ll_action_type
//		ll_doc_comp = ll_Action_Status
//		ll_re_comp = ll_print_flag
//		ll_att_comp = ll_due_date
//		ll_agr_comp = dw_todoitem.getitemnumber( ll_row, 'user_type')
//		ll_fin_comp =	-1	//stay
		//if ll_de_comp <> -1 then
		if not isNUll(ll_de_comp) and ll_de_comp <> -1 then//long.zhang 04.18.2014
			IF lb_exists_term THEN
				ls_sql_where += " AND "
				ls_sql_filter += " AND "
			END IF
			
			of_getwhereclause(ls_sql_where,ls_sql_filter,ll_de_comp,'de_compl','wv_prac_tracking')
			lb_exists_term = true
		end if
		
		//if ll_doc_comp <> -1 then
		if not isNUll(ll_doc_comp) and ll_doc_comp <> -1 then//long.zhang 04.18.2014
			IF lb_exists_term THEN
				ls_sql_where += " AND "
				ls_sql_filter += " AND "
			END IF
			
			of_getwhereclause(ls_sql_where,ls_sql_filter,ll_doc_comp,'document_compl','wv_prac_tracking')
			lb_exists_term = true
		end if
		
	//	if ll_re_comp <> -1 then
		if not isNUll(ll_re_comp) and ll_re_comp <> -1 then//long.zhang 04.18.2014
			IF lb_exists_term THEN
				ls_sql_where += " AND "
				ls_sql_filter += " AND "
			END IF
			of_getwhereclause(ls_sql_where,ls_sql_filter,ll_re_comp,'priv_compl','wv_prac_tracking')
			lb_exists_term = true
		end if
		
	//	if ll_att_comp <> -1 then
	if not isNUll(ll_att_comp) and ll_att_comp <> -1 then//long.zhang 04.18.2014
			IF lb_exists_term THEN
				ls_sql_where += " AND "
				ls_sql_filter += " AND "
			END IF
			of_getwhereclause(ls_sql_where,ls_sql_filter,ll_att_comp,'agree_compl','wv_prac_tracking')
			lb_exists_term = true
		end if
		
	//	if ll_fin_comp <> -1 then
	if not isNUll(ll_fin_comp) and ll_fin_comp <> -1 then//long.zhang 04.18.2014
			IF lb_exists_term THEN
				ls_sql_where += " AND "
				ls_sql_filter += " AND "
			END IF
			of_getwhereclause(ls_sql_where,ls_sql_filter,ll_fin_comp,'final_compl','wv_prac_tracking')
			lb_exists_term = true
		end if
	end if
//-------------appeon End------------------------
	//---------Begin Added by (Appeon)Stephen 05.25.2015 for V15.1-Additional TDL type of Recruitment Task--------
	If ls_tdl_module = "10" Then
		ll_facility_id = dw_todoitem.GetitemNumber( ll_row, "facility_id" )
		if not isNUll(ll_facility_id) and ll_facility_id <> -1 then
			IF lb_exists_term THEN
				ls_sql_where += " AND "
				ls_sql_filter += " AND "
			END IF
			of_getwhereclause(ls_sql_where,ls_sql_filter,ll_facility_id,'meet_date','pd_recruit_actions')
			lb_exists_term = true
		end if		
	end if
	//---------End Added ------------------------------------------------------

	//---------Begin Added by (Appeon)Harry 03.02.2015 for V151-Additional TDL Filters--------
	IF (ls_tdl_module = "01" OR ls_tdl_module = "02" OR ls_tdl_module = "06" OR ls_tdl_module = "07" OR ls_tdl_module = "08" OR ls_tdl_module = "09")  THEN
		IF ls_tdl_module = "01" THEN
			ll_table_id = dw_todoitem.GetitemNumber( ll_row, "table_id" )
			IF Not IsNull(ll_table_id) and ll_table_id > 0 THEN
				IF lb_exists_term THEN
					ls_sql_where += " AND "
				END IF
				ls_sql_where +=" verif_info.screen_id = " + String(ll_table_id)
				lb_exists_term = true
			END IF
		END IF
		
		//---------Begin Added by (Appeon)Stephen 10.28.2016 for V15.3-To Do List additional Modifications--------
		if ls_tdl_module = "02" then
			if  not(gnv_data.of_getitem( 'icred_settings', 'esign', False) ='0' or gs_esigntype = 'echosign') then
				if not isnull(li_sig_status) then
					IF lb_exists_term THEN
						ls_sql_where += " AND "
						ls_sql_filter += " AND "
					end if
					ls_sql_where += " net_dev_action_items.sig_status = " + string(li_sig_status)
					ls_sql_filter += " net_dev_action_items_sig_status = " + string(li_sig_status)
					lb_exists_term = true
				end if
			end if
		end if
		//---------End Added ------------------------------------------------------

		IF ls_tdl_module = "01" OR ls_tdl_module = "02" OR ls_tdl_module = "06" OR ls_tdl_module = "08" OR ls_tdl_module = "09" THEN
			ll_facility_id = dw_todoitem.GetitemNumber( ll_row, "facility_id" )
			IF Not IsNull(ll_facility_id) and ll_facility_id > 0 THEN
				CHOOSE CASE ls_tdl_module
					CASE "01"		//IntelliCred
						ls_colname = "pd_affil_stat.parent_facility_id" 
					CASE "02"		//IntelliApp
						ls_colname = "net_dev_action_items.facility_id"
					CASE "06" 			
						ls_colname = "pd_app_audit.facility_id"
					CASE "08"		
						ls_colname = "pd_affil_stat.parent_facility_id" 
					CASE "09"
						ls_colname = "wv_prac_tracking.facility_id"
				END CHOOSE
		
				IF lb_exists_term THEN
					ls_sql_where += " AND "
					ls_sql_filter += " AND "
				END IF
				ls_sql_where += ls_colname + " = " + String(ll_facility_id)
				
				IF ls_tdl_module = "06" THEN
					ls_colname = "pd_app_audit_facility_id"
				ELSEIF 	ls_tdl_module = "07" THEN
					ls_colname = "alert_records_facility_id"
				ELSEIF ls_tdl_module = "01" THEN 
					ls_colname = "pd_affil_stat_parent_facility_id"
				ELSEIF ls_tdl_module = "08" then
					ls_colname = "pd_affil_stat_parent_facility_id"
				ELSEIF ls_tdl_module = "09" then
					ls_colname = "wv_prac_tracking_facility_id"
				ELSE
					ls_colname = "facility_id"
				END IF
				ls_sql_filter += ls_colname + " = " + String(ll_facility_id)
				lb_exists_term = true
			END IF
		END IF
		IF ls_tdl_module = "01" OR ls_tdl_module = "02" OR ls_tdl_module = "06" OR ls_tdl_module = "07" OR ls_tdl_module = "08" THEN
			ls_addtl_filter = dw_todoitem.GetitemString( ll_row, "addtl_filter" )
			IF Not IsNull (ls_addtl_filter) AND (LenA(Trim(ls_addtl_filter)) > 0) THEN //Add Trim(), Modified by Appeon long.zhang 01.04.2016 (BugL121502)
				IF lb_exists_term THEN
					ls_sql_where += " AND "
					//ls_sql_filter += " AND "
				END IF
				ls_sql_where += ls_addtl_filter
				//ls_sql_filter += lnvo_string.of_globalreplace( ls_addtl_filter, ".", "_")
				lb_exists_term = true
			END IF
		END IF
	END IF
	//---------End Added ------------------------------------------------------
	// Set where condition to array
	is_where[ll_row] = ls_sql_where
	is_filter[ll_row] = ls_sql_filter
	
	// Construct SQL for dynamic sql
	IF LenA(ls_sql) > 0 THEN ls_sql += "~r~n UNION ~r~n"
	//debugbreak()
	CHOOSE CASE ls_tdl_module
		CASE "01"		//IntelliCred
			 choose case ll_tdl_right
				case 0
					//ls_ext_sql = " and (verif_info.priority_user = '" + gs_user_id + "')"
					ls_ext_sql = " and (verif_info.priority_user in ('" + ls_user_id2 + "','Public'))" //andy 12/18/2009 (V10.1 - TDL) Replace gs_user_id with ls_user_id2.
				case 1
					ls_other_user = trim(ls_other_user)
					if LenA(ls_other_user) > 0 then
						ls_ext_sql = " and (verif_info.priority_user = '" + ls_user_id2 + "' or verif_info.priority_user = '" +  ls_other_user + "')" 	// andy 12/18/2009 (V10.1 - TDL) Replace gs_user_id with ls_user_id2.
					else
						ls_ext_sql = " and (verif_info.priority_user = '" + ls_user_id2 + "')" //andy 12/18/2009 (V10.1 - TDL) Replace gs_user_id with ls_user_id2.
					end if
				case 2			
					//Start Code Change ----03.16.2011 #V11 maha - added ability to include all in the list
					//if ls_user_id = "-All-" then //Commented by (Appeon)Harry 01.09.2014
					if Upper(ls_user_id) = "-ALL-" then  //(Appeon)Harry 01.09.2014 - V141 for Bug # 3816
						ls_ext_sql = ""
					else
						ls_ext_sql = " and (verif_info.priority_user in ('" + ls_user_id + "','Public'))"//Michael 09.14.2011: Replace ls_user_id2 with ls_user_id
					end if
					//End Code Change ----03.16.2011 
			end choose
			
			//(Appeon)Harry 11.21.2013 - V141 for BugH092901 of IntelliCredApp V14.1 History Issues
			/*
			ls_sql += "SELECT tdl_id = " + String(ll_tdl_id) + ", tdli_id = " + String(ll_tdli_id) +&
			", cnt = count(1) FROM verif_info &
			 JOIN pd_basic ON verif_info.prac_id = pd_basic.prac_id &
			 JOIN pd_affil_stat ON verif_info.prac_id = pd_affil_stat.prac_id &
			 AND verif_info.facility_id = pd_affil_stat.verifying_facility &
			 AND verif_info.active_status = 1 &
			 AND pd_affil_stat.active_status IN " + ls_status + ls_ext_sql
			// AND pd_affil_stat.active_status IN (1,4)" + ls_ext_sql  //Start Code Change ----07.19.2011 #V11 maha 
			*/
			//---------Begin Modified by (Appeon)Stephen 09.05.2014 for  Robert:retrieve the To Do List count for the second work flow action item--------
			/*
			ls_sql += "SELECT tdl_id = " + String(ll_tdl_id) + ", tdli_id = " + String(ll_tdli_id) +&
			", cnt = count(1) FROM verif_info &
			 JOIN pd_basic ON verif_info.prac_id = pd_basic.prac_id &
			 JOIN pd_affil_stat ON verif_info.prac_id = pd_affil_stat.prac_id &
			 AND (( verif_info.facility_id = pd_affil_stat.verifying_facility and verif_info.screen_id <> 1) OR ( verif_info.facility_id = pd_affil_stat.parent_facility_id and verif_info.screen_id = 1))&
			 AND verif_info.active_status = 1 &
			 AND pd_affil_stat.active_status IN " + ls_status + ls_ext_sql
			 */
			ls_sql += "SELECT tdl_id = " + String(ll_tdl_id) + ", tdli_id = " + String(ll_tdli_id) +&
			", cnt = count(1) FROM verif_info &
			 JOIN pd_basic ON verif_info.prac_id = pd_basic.prac_id &
			 JOIN pd_affil_stat ON verif_info.prac_id = pd_affil_stat.prac_id &
			 AND (( verif_info.facility_id = pd_affil_stat.verifying_facility and verif_info.screen_id <> 1 and verif_info.screen_id <> -10) OR ( verif_info.facility_id = pd_affil_stat.parent_facility_id and verif_info.screen_id in (1, -10)))&
			 AND verif_info.active_status = 1 &
			 AND pd_affil_stat.active_status IN " + ls_status + ls_ext_sql
			 //---------End Modfiied ------------------------------------------------------

			//end BugH092901---------------
			
			if LenA(trim(ls_ext_sql)) > 0 then
				if LenA(trim(is_where[ll_row])) > 0 then
					is_where[ll_row] += ls_ext_sql
				else
					is_where[ll_row] = MidA(ls_ext_sql,5,LenA(ls_ext_sql) - 4)
				end if
				if LenA(trim(ls_sql_where)) > 0 then
					ls_sql_where += ls_ext_sql
				else
					ls_sql_where = MidA(ls_ext_sql,5,LenA(ls_ext_sql) - 4)
				end if
			end if

			 //---------------------------- APPEON END ----------------------------
		CASE "02"		//IntelliApp
			 choose case ll_tdl_right
				case 0
					//ls_ext_sql = " and (net_dev_action_items.action_user = '" + gs_user_id + "')"
					ls_ext_sql = " and (net_dev_action_items.action_user in ('" + ls_user_id2 + "','Public'))" //andy 12/18/2009 (V10.1 - TDL) Replace gs_user_id with ls_user_id2.
				case 1
					ls_other_user = trim(ls_other_user)
					if LenA(ls_other_user) > 0 then
						ls_ext_sql = " and (net_dev_action_items.action_user = '" + ls_user_id2 + "' or net_dev_action_items.action_user = '" +  ls_other_user + "')" //andy 12/18/2009 (V10.1 - TDL) Replace gs_user_id with ls_user_id2.
					else
						ls_ext_sql = " and (net_dev_action_items.action_user = '" + ls_user_id2 + "')" //andy 12/18/2009 (V10.1 - TDL) Replace gs_user_id with ls_user_id2.
					end if
				case 2				
					//Start Code Change ----03.16.2011 #V11 maha - added ability to include all in the list
					//if ls_user_id = "-All-" then //Commented by (Appeon)Harry 01.09.2014
					if Upper(ls_user_id) = "-ALL-" then  //(Appeon)Harry 01.09.2014 - V141 for Bug # 3816
						ls_ext_sql = ""
					else
						ls_ext_sql = " and (net_dev_action_items.action_user in ('" + ls_user_id + "','Public'))"//Michael 09.14.2011: Replace ls_user_id2 with ls_user_id
					end if
					//End Code Change ----03.16.2011
			end choose	
			ls_sql += "SELECT tdl_id = " + String(ll_tdl_id) + ", tdli_id = " + String(ll_tdli_id) +&
			", cnt = count(1) FROM net_dev_action_items &
			 JOIN pd_basic ON net_dev_action_items.Prac_id = pd_basic.prac_id &
			 JOIN pd_affil_stat ON net_dev_action_items.prac_id = pd_affil_stat.prac_id &
			 AND net_dev_action_items.facility_id = pd_affil_stat.parent_facility_id &
			 AND net_dev_action_items.active_status = 1 &
			 AND pd_affil_stat.active_status IN " + ls_status + ls_ext_sql
			// AND pd_affil_stat.active_status IN (1,4)" + ls_ext_sql  // AND pd_affil_stat.active_status IN (1,4)" + ls_ext_sql  //Start Code Change ----07.19.2011 #V11 maha 
			
			if LenA(trim(ls_ext_sql)) > 0 then
				if LenA(trim(is_where[ll_row])) > 0 then
					is_where[ll_row] += ls_ext_sql
				else
					is_where[ll_row] = MidA(ls_ext_sql,5,LenA(ls_ext_sql) - 4)
				end if
				if LenA(trim(ls_sql_where)) > 0 then
					ls_sql_where += ls_ext_sql
				else
					ls_sql_where = MidA(ls_ext_sql,5,LenA(ls_ext_sql) - 4)
				end if
			end if

			 
			 //---------------------------- APPEON END ----------------------------
		CASE "03"		//IntelliContract
			choose case ll_tdl_right
				//---------Begin Modified by (Appeon)Harry 11.28.2013 for V141 for BugH112601 of Reintegration Issues--------
				/*
				case 0
					//ls_ext_sql = " and (ctx_action_items.action_user = '" + gs_user_id + "')"
					ls_ext_sql = " and (ctx_action_items.action_user in ('" + ls_user_id2 + "','Public'))" // Modify by andy 12/18/2009 (V10.1 - TDL) Replace gs_user_id with ls_user_id2.
				case 1
					ls_other_user = trim(ls_other_user)
					if LenA(ls_other_user) > 0 then						
						ls_ext_sql = " and (ctx_action_items.action_user = '" + ls_user_id2 + "' or ctx_action_items.action_user = '" +  ls_other_user + "')" // Modify by andy 12/18/2009 (V10.1 - TDL) Replace gs_user_id with ls_user_id2.
					else
						ls_ext_sql = " and (ctx_action_items.action_user = '" + ls_user_id2 + "')" // Modify by andy 12/18/2009 (V10.1 - TDL) Replace gs_user_id with ls_user_id2.
					end if
				case 2				
					//Start Code Change ----03.16.2011 #V11 maha - added ability to include all in the list
					if ls_user_id = "-All-" then
						ls_ext_sql = ""
					else
						ls_ext_sql = " and (ctx_action_items.action_user in ('" + ls_user_id + "','Public'))"//Modify by Michael 09.14.2011: Replace ls_user_id2 with ls_user_id
					end if
					//End Code Change ----03.16.2011
				*/
				case 0
					ls_ext_sql = " and (" + ls_AssignUser + " in ('" + ls_user_id2 + "','Public'))"
				case 1
					ls_other_user = trim(ls_other_user)
					if LenA(ls_other_user) > 0 then						
						ls_ext_sql = " and (" + ls_AssignUser + " = '" + ls_user_id2 + "' or " + ls_AssignUser + " = '" +  ls_other_user + "')"
					else
						ls_ext_sql = " and (" + ls_AssignUser + " = '" + ls_user_id2 + "')"
					end if
				case 2				
					//Start Code Change ----03.16.2011 #V11 maha - added ability to include all in the list
					//if ls_user_id = "-All-" then //Commented by (Appeon)Harry 01.09.2014
					if Upper(ls_user_id) = "-ALL-" then  //(Appeon)Harry 01.09.2014 - V141 for Bug # 3816
						ls_ext_sql = ""
					else
						ls_ext_sql = " and (" + ls_AssignUser + " in ('" + ls_user_id + "','Public'))"
					end if
				//---------End Modfiied ------------------------------------------------------

			end choose
			ls_ext_sql += This.of_gen_where_due_date(ls_tdl_module)  //(Appeon)Harry 03.20.2014 - V142 ISG-CLX
			
			//(Appeon)Harry 11.21.2013 - V141 for BugH092901 of IntelliCredApp V14.1 History Issues
			/*
			ls_sql += "SELECT tdl_id = " + String(ll_tdl_id) + ", tdli_id = " + String(ll_tdli_id) +&
			", cnt = count(1) FROM ctx_action_items &
			 JOIN ctx_basic_info ON ctx_action_items.ctx_id = ctx_basic_info.ctx_id &
			 AND Isnull(ctx_action_items.active_status,0) >= 0" + ls_ext_sql
			*/
			ls_sql += "SELECT tdl_id = " + String(ll_tdl_id) + ", tdli_id = " + String(ll_tdli_id) +&
			", cnt = count(1) FROM ctx_action_items &
			 JOIN ctx_basic_info ON (ctx_action_items.ctx_id = ctx_basic_info.ctx_id &
			 AND Isnull(ctx_action_items.active_status,0) >= 0&
			 And ctx_basic_info.is_template = 0)&
			 JOIN code_lookup ctx_status On (ctx_basic_info.status = ctx_status.lookup_code AND ctx_status.custom_3 = 'YES' ) " // + ls_ext_sql
			//---------Begin Added by (Appeon)Harry 03.14.2014 for V142 ISG-CLX--------
			If not isnull(il_ctx_id) and ibn_use_ctx_id = True then 
				ls_sql +=  " AND ctx_basic_info.ctx_id = " + string(il_ctx_id) + " "
			end if
			ls_sql += ls_ext_sql
			//---------End Added ------------------------------------------------------
			//end BugH092901
			if LenA(trim(ls_ext_sql)) > 0 then
				if LenA(trim(is_where[ll_row])) > 0 then
					is_where[ll_row] += ls_ext_sql
				else
					is_where[ll_row] = MidA(ls_ext_sql,5,LenA(ls_ext_sql) - 4)
				end if
				if LenA(trim(ls_sql_where)) > 0 then
					ls_sql_where += ls_ext_sql
				else
					ls_sql_where = MidA(ls_ext_sql,5,LenA(ls_ext_sql) - 4)
				end if
			end if
		//---------------------------- APPEON END ----------------------------	 


		case "04"
			choose case ll_tdl_right
				//---------Begin Modified by (Appeon)Harry 11.28.2013 for V141 for BugH112601 of Reintegration Issues--------
				/*
				case 0
					//ls_ext_sql = " and (ctx_am_action_item.action_user = '" + gs_user_id + "')"
					ls_ext_sql = " and (ctx_am_action_item.action_user in ('" + ls_user_id2 + "','Public'))"// Modify by andy 12/18/2009 (V10.1 - TDL) Replace gs_user_id with ls_user_id2.
				case 1
					ls_other_user = trim(ls_other_user)
					if LenA(ls_other_user) > 0 then						
						ls_ext_sql = " and (ctx_am_action_item.action_user = '" + ls_user_id2 + "' or ctx_am_action_item.action_user = '" +  ls_other_user + "')"// Modify by andy 12/18/2009 (V10.1 - TDL) Replace gs_user_id with ls_user_id2.
					else
						ls_ext_sql = " and (ctx_am_action_item.action_user = '" + ls_user_id2 + "')"// Modify by andy 12/18/2009 (V10.1 - TDL) Replace gs_user_id with ls_user_id2.
					end if
				case 2
					//Start Code Change ----03.16.2011 #V11 maha - added ability to include all in the list
					if ls_user_id = "-All-" then
						ls_ext_sql = ""
					else
						ls_ext_sql = " and (ctx_am_action_item.action_user in ('" + ls_user_id + "','Public'))"//Michael 09.14.2011: Replace ls_user_id2 with ls_user_id
					end if
					//End Code Change ----03.16.2011		
				*/
				case 0
					ls_ext_sql = " and (" + ls_AmAssignUser + " in ('" + ls_user_id2 + "','Public'))"
				case 1
					ls_other_user = trim(ls_other_user)
					if LenA(ls_other_user) > 0 then						
						ls_ext_sql = " and (" + ls_AmAssignUser + " = '" + ls_user_id2 + "' or " + ls_AmAssignUser + " = '" +  ls_other_user + "')"// Modify by andy 12/18/2009 (V10.1 - TDL) Replace gs_user_id with ls_user_id2.
					else
						ls_ext_sql = " and (" + ls_AmAssignUser + " = '" + ls_user_id2 + "')"// Modify by andy 12/18/2009 (V10.1 - TDL) Replace gs_user_id with ls_user_id2.
					end if
				case 2
					//if ls_user_id = "-All-" then //Commented by (Appeon)Harry 01.09.2014
					if Upper(ls_user_id) = "-ALL-" then  //(Appeon)Harry 01.09.2014 - V141 for Bug # 3816
						ls_ext_sql = ""
					else
						ls_ext_sql = " and (" + ls_AmAssignUser + " in ('" + ls_user_id + "','Public'))"
					end if
				//---------End Modfiied ------------------------------------------------------
			end choose
			ls_ext_sql += This.of_gen_where_due_date(ls_tdl_module)  //(Appeon)Harry 03.20.2014 - V142 ISG-CLX
			//(Appeon)Harry 11.21.2013 - V141 for BugH092901 of IntelliCredApp V14.1 History Issues
			/*
			ls_sql += "SELECT tdl_id = " + String(ll_tdl_id) + ", tdli_id = " + String(ll_tdli_id) +&
			", cnt = count(1) FROM ctx_am_action_item &
			,ctx_am_document,ctx_basic_info where ctx_am_action_item.doc_id = ctx_am_document.doc_id and ctx_am_document.ctx_id = ctx_basic_info.ctx_id &
			AND Isnull(ctx_am_action_item.active_status,0) >= 0" + ls_ext_sql
			*/
			ls_sql += "SELECT tdl_id = " + String(ll_tdl_id) + ", tdli_id = " + String(ll_tdli_id) +&
			", cnt = count(1) FROM ctx_am_action_item &
			,ctx_am_document,ctx_basic_info &
			JOIN code_lookup ctx_status On (ctx_basic_info.status = ctx_status.lookup_code And ctx_status.custom_3 = 'YES' )  &
			where ctx_am_action_item.doc_id = ctx_am_document.doc_id and ctx_am_document.ctx_id = ctx_basic_info.ctx_id and ctx_basic_info.is_template = 0 &
			AND Isnull(ctx_am_action_item.active_status,0) >= 0" //+ ls_ext_sql
			 //---------Begin Added by (Appeon)Harry 03.14.2014 for V142 ISG-CLX--------
			If not isnull(il_ctx_id) and ibn_use_ctx_id = True then 
				ls_sql +=  " AND ctx_basic_info.ctx_id = " + string(il_ctx_id) + " "
			end if
			ls_sql += ls_ext_sql
			//---------End Added ------------------------------------------------------
			//end BugH092901
			if LenA(trim(ls_ext_sql)) > 0 then
				if LenA(trim(is_where[ll_row])) > 0 then
					is_where[ll_row] += ls_ext_sql
				else
					is_where[ll_row] = MidA(ls_ext_sql,5,LenA(ls_ext_sql) - 4)
				end if
				if LenA(trim(ls_sql_where)) > 0 then
					ls_sql_where += ls_ext_sql
				else
					ls_sql_where = MidA(ls_ext_sql,5,LenA(ls_ext_sql) - 4)
				end if
			end if
		//---------------------------- APPEON END ----------------------------	 
		
		// Add by andy 12/10/2009 (V10.1 - TDL)
		case "06"
			ls_ext_sql = ""
						
			choose case ll_tdl_right
				case 0
					ls_ext_sql = " and (pd_affil_stat.priority_user in ('" + ls_user_id2 + "','Public') OR pd_affil_stat.priority_user IS NULL)"
				case 1
					ls_other_user = trim(ls_other_user)
					if LenA(ls_other_user) > 0 then
						ls_ext_sql = " and (pd_affil_stat.priority_user = '" + ls_user_id2 + "' or verif_info.priority_user = '" +  ls_other_user + "')"
					else
						ls_ext_sql = " and (pd_affil_stat.priority_user = '" + ls_user_id2 + "')"
					end if
				case 2
						ls_ext_sql = " and (pd_affil_stat.priority_user in ('" + ls_user_id + "','Public') OR pd_affil_stat.priority_user IS NULL)"
			end choose
			
			//---------Begin Modified by (Appeon)Stephen 02.24.2014 for V141 Import Modifications for Facility and Group--------
			//add "or data_view_app_audit.app_type = 'B'"
			ls_sql += "SELECT tdl_id = " + String(ll_tdl_id) + ", tdli_id = " + String(ll_tdli_id) +&
						 ", cnt = count(1) FROM pd_app_audit &
								 INNER JOIN data_view_app_audit ON ( data_view_app_audit.app_audit_id = pd_app_audit.app_audit_id ) &
								 INNER JOIN pd_affil_stat ON ( pd_affil_stat.apptmnt_type = data_view_app_audit.app_type  or data_view_app_audit.app_type = 'B'  ) and ( pd_affil_stat.rec_id = pd_app_audit.appt_stat_id ) &
								 INNER JOIN pd_basic ON ( pd_app_audit.prac_id = pd_basic.prac_id ) AND ( ( pd_affil_stat.active_status in (1,4, 6) ) AND ( pd_affil_stat.apptmnt_start_date is null ) ) " + ls_ext_sql
			//---------End Modfiied ------------------------------------------------------
			if LenA(trim(ls_ext_sql)) > 0 then
				if LenA(trim(is_where[ll_row])) > 0 then
					is_where[ll_row] += ls_ext_sql
				else
					is_where[ll_row] = MidA(ls_ext_sql,5,LenA(ls_ext_sql) - 4)
				end if
				if LenA(trim(ls_sql_where)) > 0 then
					ls_sql_where += ls_ext_sql
				else
					ls_sql_where = MidA(ls_ext_sql,5,LenA(ls_ext_sql) - 4)
				end if
			end if
			
		// Add by andy 12/26/2009 (V10.1 - TDL)
		case "07"
			ls_ext_sql = ""
						
			choose case ll_tdl_right
				case 0
					ls_ext_sql = " and (pd_affil_stat.priority_user in ('" + ls_user_id2 + "','Public') OR pd_affil_stat.priority_user IS NULL)"
				case 1
					ls_other_user = trim(ls_other_user)
					if LenA(ls_other_user) > 0 then
						ls_ext_sql = " and (pd_affil_stat.priority_user = '" + ls_user_id2 + "' or verif_info.priority_user = '" +  ls_other_user + "')"
					else
						ls_ext_sql = " and (pd_affil_stat.priority_user = '" + ls_user_id2 + "')"
					end if
				case 2
						ls_ext_sql = " and (pd_affil_stat.priority_user in ('" + ls_user_id + "','Public') OR pd_affil_stat.priority_user IS NULL)"
			end choose
						
			ls_sql += "SELECT tdl_id = " + String(ll_tdl_id) + ", tdli_id = " + String(ll_tdli_id) +&
						 ", cnt = count(1) FROM alert_records &
						 		 INNER JOIN alert_hdr ON (alert_records.alert_id = alert_hdr.alert_id) &
								 INNER JOIN pd_affil_stat ON ( alert_records.prac_id = pd_affil_stat.prac_id and alert_records.Facility_id = pd_affil_stat.parent_facility_id ) &
								 INNER JOIN pd_basic ON ( pd_affil_stat.prac_id = pd_basic.prac_id ) &
								 AND pd_affil_stat.active_status IN " + ls_status + ls_ext_sql
									//AND ( pd_affil_stat.active_status in (1,4) ) " + ls_ext_sql  // AND pd_affil_stat.active_status IN (1,4)" + ls_ext_sql  //Start Code Change ----07.19.2011 #V11 maha 
		
			if LenA(trim(ls_ext_sql)) > 0 then
				if LenA(trim(is_where[ll_row])) > 0 then
					is_where[ll_row] += ls_ext_sql
				else
					is_where[ll_row] = MidA(ls_ext_sql,5,LenA(ls_ext_sql) - 4)
				end if
				if LenA(trim(ls_sql_where)) > 0 then
					ls_sql_where += ls_ext_sql
				else
					ls_sql_where = MidA(ls_ext_sql,5,LenA(ls_ext_sql) - 4)
				end if
			end if
	case "08"	//Added by Appeon long.zhang 09.23.2013 (V14.1 Recruitment Functionality)	
			//---------Begin Modified by (Appeon)Harry 03.04.2015 for V151-Additional TDL Filters--------
			/*
			ls_sql += "SELECT tdl_id = " + String(ll_tdl_id) + ", tdli_id = " + String(ll_tdli_id) +&
						 ", cnt = count(1) FROM recruit_prac " 
			 */
			 ls_sql += "SELECT tdl_id = " + String(ll_tdl_id) + ", tdli_id = " + String(ll_tdli_id) +&
						 ", cnt = count(1) FROM recruit_prac " + &
						" LEFT JOIN pd_basic on recruit_prac.prac_id = pd_basic.prac_id " + &
						"LEFT JOIN pd_affil_stat ON recruit_prac.prac_id = pd_affil_stat.prac_id"
			//---------End Modfiied ------------------------------------------------------
						 
	case "09"//Added by Appeon long.zhang 03.18.2014 (V14.2 To Do List for PracView)
			ls_ext_sql = ""
			
			ls_test = "SELECT tdl_id = " + String(ll_tdl_id) + ", tdli_id = " + String(ll_tdli_id) +&
						 ", cnt = count(1) FROM wv_prac_tracking, pd_affil_stat, pd_basic "		
			 //Start Code Change ----09.21.2015 #V15 maha	 - added filtering for user and active status		 
			
			ls_test += " WHERE ( pd_basic.prac_id = pd_affil_stat.prac_id ) and  &
         ( pd_affil_stat.prac_id = wv_prac_tracking.prac_id ) and &
	    ( pd_affil_stat.parent_facility_id = wv_prac_tracking.facility_id ) and &
		 ( pd_affil_stat.rec_id = wv_prac_tracking.appt_stat_id ) and &
		 ( pd_affil_stat.apptmnt_start_date is null ) and &
					 pd_affil_stat.active_status IN " + ls_status  // + ls_ext_sql
	 				 
			//openwithparm(w_sql_msg, ls_test)
			ls_sql += ls_test
			 //End Code Change ----09.21.2015
	case "10"
			//---------Begin Modified by (Appeon)Stephen 10.27.2016 for V15.3-To Do List additional Modifications--------
			/*
			ls_sql += "SELECT tdl_id = " + String(ll_tdl_id) + ", tdli_id = " + String(ll_tdli_id) +&
						 ", cnt = count(1) FROM pd_recruit_actions "
						 */
			ls_sql += "SELECT tdl_id = " + String(ll_tdl_id) + ", tdli_id = " + String(ll_tdli_id) +&
						 ", cnt = count(1) FROM pd_recruit_actions, v_recruit_prac where pd_recruit_actions.prac_id = v_recruit_prac.prac_id "
	END CHOOSE
	
   IF lb_exists_term THEN
		CHOOSE CASE ls_tdl_module
			case '04'	, '09'	, '10'	//(Appeon)Stephen 12.26.2016 - add '10'  V15.3-To Do List additional Modifications  //Start Code Change ----09.21.2015 #V15 maha - added 09
				ls_sql += " and " + ls_sql_where
			case else
				ls_sql += " WHERE " + ls_sql_where
		end choose
	end if
NEXT

//
DataStore lds_tdl
String ls_error_syntaxfromSQL, ls_error_create
String ls_syntax
Long ll_count,ll_ret = 1
If ls_sql <> '' Then
	lds_tdl = Create DataStore 
	ls_syntax = SQLCA.SyntaxFromSQL(ls_sql, 'Style(Type=Grid)', ls_error_syntaxfromSQL)
	IF LenA(ls_error_syntaxfromSQL) > 0 THEN
		Messagebox('Syntax Error',ls_error_syntaxfromSQL)
		openwithparm(w_sql_msg,ls_sql)
		ll_ret = -1
	ELSE
		lds_tdl.Create(ls_syntax, ls_error_create)
		IF LenA(ls_error_create) > 0 THEN
			Messagebox('Create Error',ls_error_create)
			ll_ret = -1
		END IF
	END IF
	If ll_ret = 1 Then
		lds_tdl.SetTransObject(SQLCA)
		ll_count = lds_tdl.Retrieve()
		If ll_count > 0 Then
			il_tdl_id[] = lds_tdl.object.#1[1,ll_count]
			il_tdli_id[] = lds_tdl.object.#2[1,ll_count]
			il_tdli_cnt[] = lds_tdl.object.#3[1,ll_count]
		End If
	End If
End If

// Fill Treeview
THIS.of_fill_treeview( )

// Last refreshed time
st_time.Text = "Last refreshed " + String( Now( ), "hh:mm:ss" )



end event

event ue_close();//////////////////////////////////////////////////////////////////////
// $<event>u_cst_todolist::ue_close()
// $<arguments>(None)
// $<returns> 
// $<description> 
// $<description> Close this window on Todolist window.
//////////////////////////////////////////////////////////////////////
// $<add> 2008-08-14 by Ken.Guo
//////////////////////////////////////////////////////////////////////


powerobject	lpo_parent

lpo_parent = this.GetParent()
do while IsValid (lpo_parent)
	If lpo_parent.TypeOf() = window! Then Exit
	lpo_parent = lpo_parent.GetParent()
loop

if IsValid (lpo_parent) then
	Close(lpo_parent)
end If

end event

event ue_refresh_dddw(datastore ads_tdl);
datawindowchild dwchild

ads_tdl.SettransObject( SQLCA )

Choose Case lower(ads_tdl.dataobject)
	Case 'd_tdl_document_all'
		Is_sql_document = ads_tdl.getsqlselect()
		
		ads_tdl.GetChild( "action_type", dwchild )
		gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Contract Action Type') = upper(lookup_name)", dwchild)
		
		ads_tdl.GetChild( "action_status", dwchild )
		gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Contract Action Status') = upper(lookup_name)", dwchild)
		
		ads_tdl.GetChild( "ctx_basic_info_status", dwchild )
		gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Contract Status') = upper(lookup_name)", dwchild)
		
		ads_tdl.GetChild( "ctx_basic_info_category", dwchild )
		gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Contract Category') = upper(lookup_name)", dwchild)
		
		ads_tdl.GetChild( "ctx_basic_info_contract_type", dwchild )
		gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Contract Type') = upper(lookup_name)", dwchild)
		
		ads_tdl.GetChild( "ctx_basic_info_dvision", dwchild )
		gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Contract Division') = upper(lookup_name)", dwchild)
	Case 'd_tdl_intelliapp', 'd_tdl_intelliapp_w_inactive'
		Is_sql_intelliapp = ads_tdl.getsqlselect( )
		
		// Practitional Basic info
		ads_tdl.GetChild( "pd_basic_prac_category", dwchild )
		gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Practitioner Category') = upper(lookup_name)", dwchild)
		
		ads_tdl.GetChild( "pd_basic_name_suffix", dwchild )
		gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Name Suffix') = upper(lookup_name)", dwchild)
		
		ads_tdl.GetChild( "pd_basic_prof_suffix", dwchild )
		gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Professional Suffix') = upper(lookup_name)", dwchild)
		
		// Application Status
		ads_tdl.GetChild( "net_dev_action_items_action_dept", dwchild )
		gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Action Department') = upper(lookup_name)", dwchild)
		
		ads_tdl.GetChild( "action_status", dwchild )
		gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Action Status') = upper(lookup_name)", dwchild)
		
		ads_tdl.GetChild( "action_type", dwchild )
		gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Action Type') = upper(lookup_name)", dwchild)
		
	Case 'd_tdl_intellicontract'
		// Initialize syntax of dw
		Is_sql_intellicontract = ads_tdl.getsqlselect( )
		
		// Action Item
		ads_tdl.GetChild( "action_type", dwchild )
		gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Contract Action Type') = upper(lookup_name)", dwchild)
		
		ads_tdl.GetChild( "action_status", dwchild )
		gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Contract Action Status') = upper(lookup_name)", dwchild)
		
		// CTX Basic Info
		ads_tdl.GetChild( "ctx_basic_info_status", dwchild )
		gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Contract Status') = upper(lookup_name)", dwchild)
		
		ads_tdl.GetChild( "ctx_basic_info_category", dwchild )
		gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Contract Category') = upper(lookup_name)", dwchild)
		
		ads_tdl.GetChild( "ctx_basic_info_contract_type", dwchild )
		gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Contract Type') = upper(lookup_name)", dwchild)
		
		ads_tdl.GetChild( "ctx_basic_info_dvision", dwchild )
		gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Contract Division') = upper(lookup_name)", dwchild)
		
	Case 'd_tdl_intellicred', 'd_tdl_intellicred_w_inactive'
		// Initialize syntax of dw
		Is_sql_intellicred = ads_tdl.getsqlselect( )
		
		// Practitional Basic info
		ads_tdl.GetChild( "pd_basic_prac_category", dwchild )
		gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Practitioner Category') = upper(lookup_name)", dwchild)
		
		ads_tdl.GetChild( "pd_basic_name_suffix", dwchild )
		gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Name Suffix') = upper(lookup_name)", dwchild)
		
		ads_tdl.GetChild( "pd_basic_prof_suffix", dwchild )
		gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Professional Suffix') = upper(lookup_name)", dwchild)

		// Verification Status
		ads_tdl.GetChild( "action_type", dwchild )
		gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Verification Method') = upper(lookup_name)", dwchild)
		
		ads_tdl.GetChild( "action_status", dwchild )
		gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('credentials verification response') = upper(lookup_name)", dwchild)

		//Affiliation Status
		ads_tdl.GetChild( "pd_affil_stat_affiliation_status", dwchild )
		gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Affiliation Status') = upper(lookup_name)", dwchild)

		// Department
		ads_tdl.GetChild( "pd_affil_dept_department", dwchild )
		gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('department') = upper(lookup_name)", dwchild)
		
		ads_tdl.GetChild( "pd_affil_dept_rank", dwchild )
		gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('division') = upper(lookup_name)", dwchild)
		
		ads_tdl.GetChild( "pd_affil_dept_section", dwchild )
		gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('section') = upper(lookup_name)", dwchild)
		
		// Staff category
		ads_tdl.GetChild( "pd_affil_staff_cat_staff_category", dwchild )
		gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('staff category') = upper(lookup_name)", dwchild)
	
	// Add by andy 12/12/2009 (V10.1 - TDL)
	Case 'd_tdl_app_audit'
		// Initialize syntax of dw
		Is_sql_app_audit = ads_tdl.getsqlselect( )
		
		// Practitional Basic info
		ads_tdl.GetChild( "pd_basic_prac_category", dwchild )
		gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Practitioner Category') = upper(lookup_name)", dwchild)
		
		ads_tdl.GetChild( "pd_basic_name_suffix", dwchild )
		gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Name Suffix') = upper(lookup_name)", dwchild)
		
		ads_tdl.GetChild( "pd_basic_prof_suffix", dwchild )
		gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Professional Suffix') = upper(lookup_name)", dwchild)

		// App.Audit Status		
		ads_tdl.GetChild( "pd_app_audit_data_status", dwchild )
		gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Required Data Status') = upper(lookup_name)", dwchild)

	// Add by andy 12/26/2009 (V10.1 - TDL)
	Case 'd_tdl_alert_item'
		// Initialize syntax of dw
		Is_sql_alert_item = ads_tdl.getsqlselect( )
		
		// Practitional Basic info
		ads_tdl.GetChild( "pd_basic_prac_category", dwchild )
		gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Practitioner Category') = upper(lookup_name)", dwchild)
		
		ads_tdl.GetChild( "pd_basic_name_suffix", dwchild )
		gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Name Suffix') = upper(lookup_name)", dwchild)
		
		ads_tdl.GetChild( "pd_basic_prof_suffix", dwchild )
		gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Professional Suffix') = upper(lookup_name)", dwchild)
		
	Case "d_tdl_recruit"//Added by Appeon long.zhang 09.23.2013 (V14.1 Recruitment Functionality)
		
		is_sql_recruit = ads_tdl.getsqlselect( )
		
		ads_tdl.GetChild( "title", dwchild )
		gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Title') = upper(lookup_name)", dwchild)
		
		ads_tdl.GetChild( "name_suffix", dwchild )
		gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Name Suffix') = upper(lookup_name)", dwchild)
		
		ads_tdl.GetChild( "prof_suffix", dwchild )
		gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Professional Suffix') = upper(lookup_name)", dwchild)
		
		ads_tdl.GetChild( "state", dwchild )
		gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('State') = upper(lookup_name)", dwchild)
		
		ads_tdl.GetChild( "country", dwchild )
		gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Country') = upper(lookup_name)", dwchild)
		
		ads_tdl.GetChild( "specialty1", dwchild )
		gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Practitioner Specialties') = upper(lookup_name)", dwchild)
		
		ads_tdl.GetChild( "specialty2", dwchild )
		gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Practitioner Specialties') = upper(lookup_name)", dwchild)
		
		ads_tdl.GetChild( "specialty3", dwchild )
		gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Practitioner Specialties') = upper(lookup_name)", dwchild)
		
		ads_tdl.GetChild( "Board_certified1", dwchild )
		gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Yes/No') = upper(lookup_name)", dwchild)
		
		ads_tdl.GetChild( "Board_certified2", dwchild )
		gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Yes/No') = upper(lookup_name)", dwchild)
		
		ads_tdl.GetChild( "Board_certified3", dwchild )
		gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Yes/No') = upper(lookup_name)", dwchild)
		
		ads_tdl.GetChild( "Board_code1", dwchild )
		gnv_data.of_set_dwchild_fromcache("address_lookup" , "upper('Boards') = upper(lookup_name)", dwchild)
		
		ads_tdl.GetChild( "Board_code2", dwchild )
		gnv_data.of_set_dwchild_fromcache("address_lookup" , "upper('Boards') = upper(lookup_name)", dwchild)
		
		ads_tdl.GetChild( "Board_code3", dwchild )
		gnv_data.of_set_dwchild_fromcache("address_lookup" , "upper('Boards') = upper(lookup_name)", dwchild)
		
	Case "d_tdl_pracview"//Added by Appeon long.zhang 03.24.2014 (V14.2 To Do List for PracView)
		is_sql_pracview = ads_tdl.getsqlselect()
		// Practitional Basic info
		ads_tdl.GetChild( "pd_basic_prac_category", dwchild )
		gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Practitioner Category') = upper(lookup_name)", dwchild)
		
		ads_tdl.GetChild( "pd_basic_name_suffix", dwchild )
		gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Name Suffix') = upper(lookup_name)", dwchild)
		
		ads_tdl.GetChild( "pd_basic_prof_suffix", dwchild )
		gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Professional Suffix') = upper(lookup_name)", dwchild)
	Case "d_tdl_recruit_task" //(Appeon)Stephen 05.26.2015 - V15.1-Additional TDL type of Recruitment Task
		is_sql_task_recruit = ads_tdl.getsqlselect()
		
End Choose

end event

event ue_resize();//////////////////////////////////////////////////////////////////////
// $<event>u_cst_todolist::resize()
// $<arguments>
//		unsignedlong	sizetype 		
//		integer     	newwidth 		
//		integer     	newheight		
// $<returns> long
// $<description>
// $<description> Resize Todolist
//////////////////////////////////////////////////////////////////////
// $<add> 2008-08-18 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Long ll_button_width

//---------Begin Modified by (Appeon)Harry 03.20.2014 for V142 ISG-CLX--------
//tv_results.width = This.Width - 24 * 2
tv_results.width = This.Width - 28 * 2
//---------End Modfiied ------------------------------------------------------

cb_save.x = 670

ll_button_width = (This.Width - cb_save.x - 24)/5

cb_save.width = ll_button_width
cb_go.width = ll_button_width
cb_print.width = ll_button_width
cb_refresh.width = ll_button_width
cb_close.width = ll_button_width

cb_go.x = cb_save.x + cb_save.width
cb_print.x = cb_go.x + cb_go.width
cb_refresh.x = cb_print.x + cb_print.width
cb_close.x = cb_refresh.x + cb_refresh.width


If ll_button_width <= 215 Then
	cb_save.Text = "S"	
	cb_go.Text = "G"
	cb_print.Text = "P"
	cb_refresh.Text = "R"
	cb_close.Text = "C"
Else
	cb_save.Text = "Save"	
	cb_go.Text = "Go"
	cb_print.Text = "Print"
	cb_refresh.Text = "Refresh"
	cb_close.Text = "Close"	
End If

//---------Begin Added by (Appeon)Harry 03.14.2014 for V142 ISG-CLX--------
//Start Code Change ----03.08.2016 #V15 maha - removed picture references
//Event ue_move_picture()
//If ll_button_width <= 350 Then
//	p_save.visible = False
//	p_go.visible = False
//	p_print.visible = False
//	p_refresh.visible = False
//	p_close.visible = False	
//Else
//	p_save.visible = True
//	p_go.visible = True
//	p_print.visible = True
//	p_refresh.visible = True
//	p_close.visible = True	
//End If
//---------End Added ------------------------------------------------------
end event

event ue_ini();String 	ls_Scale
Long 	  	ll_Cycle
integer li_all

n_cst_tdl_function 	lnvo_tdl_function
DataWindowChild 		dwchild,dwchild_user

dw_document = Create n_ds 
dw_document_all = Create n_ds 
dw_tdl_intelliapp = Create n_ds
dw_tdl_intelliapp_all = Create n_ds
dw_tdl_intellicontract = Create n_ds
dw_tdl_intellicontract_all = Create n_ds
dw_tdl_intellicred = Create n_ds
dw_tdl_intellicred_all = Create n_ds
dw_todoitem = Create n_ds
// Add by andy 12/10/2009 (V10.1 - TDL)
dw_tdl_app_audit = Create n_ds
dw_tdl_app_audit_all = Create n_ds
// Add by andy 12/26/2009 (V10.1 - TDL)
dw_tdl_alert_item = Create n_ds
dw_tdl_alert_item_all = Create n_ds
ds_tdl_icon = Create n_ds //(Appeon)Eugene 06.05.2013 - V141 ISG-CLX
//-------------appeon begin----------------------
//<$>added:long.zhang 09.23.2013
//<$>reason:V14.1 Recruitment Functionality
dw_tdl_recruit = create n_ds
dw_tdl_recruit_all = create n_ds
//-------------appeon End------------------------

//-------------appeon begin----------------------
//<$>added:long.zhang 03.18.2014
//<$>reason:V14.2 To Do List for PracView
dw_tdl_pracview = create n_ds
dw_tdl_pracview_all = create n_ds
//-------------appeon End------------------------

//---------Begin Added by (Appeon)Stephen 05.28.2015 for V15.1-Additional TDL type of Recruitment Task--------
dw_task_recruit = create n_ds
dw_task_recruit_all = create n_ds
//---------End Added ------------------------------------------------------

dw_document.dataobject = 'd_tdl_document_all'
dw_document_all.dataobject = 'd_tdl_document_all'
dw_tdl_intellicontract.dataobject = 'd_tdl_intellicontract'
dw_tdl_intellicontract_all.dataobject = 'd_tdl_intellicontract'
dw_todoitem.dataobject = 'd_tdl_painter_detail_list'
//Start Code Change ----07.20.2011 #V11 maha - include inactives
if of_get_app_setting("set_61","I") = 1 then
	dw_tdl_intelliapp.dataobject = 'd_tdl_intelliapp_w_inactive'
	dw_tdl_intelliapp_all.dataobject = 'd_tdl_intelliapp_w_inactive'
	dw_tdl_intellicred.dataobject = 'd_tdl_intellicred_w_inactive'
	dw_tdl_intellicred_all.dataobject = 'd_tdl_intellicred_w_inactive'
else
	dw_tdl_intelliapp.dataobject = 'd_tdl_intelliapp'
	dw_tdl_intelliapp_all.dataobject = 'd_tdl_intelliapp'
	dw_tdl_intellicred.dataobject = 'd_tdl_intellicred'
	dw_tdl_intellicred_all.dataobject = 'd_tdl_intellicred'
end if
//End Code Change ----07.20.2011
// Add by andy 12/10/2009 (V10.1 - TDL)
dw_tdl_app_audit.dataobject = 'd_tdl_app_audit'
dw_tdl_app_audit_all.dataobject = 'd_tdl_app_audit'
// Add by andy 12/26/2009 (V10.1 - TDL)
dw_tdl_alert_item.dataobject = 'd_tdl_alert_item'
dw_tdl_alert_item_all.dataobject = 'd_tdl_alert_item'
ds_tdl_icon.dataobject = 'd_tdl_icons' //(Appeon)Eugene 06.05.2013 - V141 ISG-CLX

//-------------appeon begin----------------------
//<$>added:long.zhang 09.23.2013
//<$>reason:V14.1 Recruitment Functionality
dw_tdl_recruit_all.dataobject = 'd_tdl_recruit'
dw_tdl_recruit.dataobject = 'd_tdl_recruit'
//-------------appeon end----------------------

//-------------appeon begin----------------------
//<$>added:long.zhang 03.18.2014
//<$>reason:V14.2 To Do List for PracView
dw_tdl_pracview.dataobject = 'd_tdl_pracview'
dw_tdl_pracview_all.dataobject = 'd_tdl_pracview'
//-------------appeon End------------------------

//---------Begin Added by (Appeon)Stephen 05.28.2015 for V15.1-Additional TDL type of Recruitment Task--------
dw_task_recruit.dataobject = "d_tdl_recruit_task"
dw_task_recruit_all.dataobject = "d_tdl_recruit_task"
//---------End Added ------------------------------------------------------

dw_document.SetTransObject(SQLCA)
dw_document_all.SetTransObject(SQLCA)
dw_tdl_intelliapp.SetTransObject(SQLCA)
dw_tdl_intelliapp_all.SetTransObject(SQLCA)
dw_tdl_intellicontract.SetTransObject(SQLCA)
dw_tdl_intellicontract_all.SetTransObject(SQLCA)
dw_tdl_intellicred.SetTransObject(SQLCA)
dw_tdl_intellicred_all.SetTransObject(SQLCA)
dw_todoitem.SetTransObject(SQLCA)
// Add by andy 12/10/2009 (V10.1 - TDL)
dw_tdl_app_audit.SetTransObject(SQLCA)
dw_tdl_app_audit_all.SetTransObject(SQLCA)
// Add by andy 12/26/2009 (V10.1 - TDL)
dw_tdl_alert_item.SetTransObject(SQLCA)
dw_tdl_alert_item_all.SetTransObject(SQLCA)
ds_tdl_icon.SetTransObject(SQLCA) //(Appeon)Eugene 06.05.2013 - V141 ISG-CLX
//-------------appeon begin----------------------
//<$>added:long.zhang 09.23.2013
//<$>reason:V14.1 Recruitment Functionality
dw_tdl_recruit.settransobject(sqlca)
dw_tdl_recruit_all.settransobject( sqlca)
//-------------appeon end----------------------

//-------------appeon begin----------------------
//<$>added:long.zhang 03.18.2014
//<$>reason:V14.2 To Do List for PracView
dw_tdl_pracview.settransobject( sqlca)
dw_tdl_pracview_all.settransobject( sqlca)
//-------------appeon End------------------------

//---------Begin Added by (Appeon)Stephen 05.28.2015 for V15.1-Additional TDL type of Recruitment Task--------
dw_task_recruit.settransobject( sqlca)
dw_task_recruit_all.settransobject( sqlca)
//---------End Added ------------------------------------------------------

dw_document.of_setbase(True)
dw_document_all.of_setbase(True)
dw_tdl_intelliapp.of_setbase(True)
dw_tdl_intelliapp_all.of_setbase(True)
dw_tdl_intellicontract.of_setbase(True)
dw_tdl_intellicontract_all.of_setbase(True)
dw_tdl_intellicred.of_setbase(True)
dw_tdl_intellicred_all.of_setbase(True)
dw_todoitem.of_setbase(True)
// Add by andy 12/10/2009 (V10.1 - TDL)
dw_tdl_app_audit.of_setbase(True)
dw_tdl_app_audit_all.of_setbase(True)
// Add by andy 12/26/2009 (V10.1 - TDL)
dw_tdl_alert_item.of_setbase(True)
dw_tdl_alert_item_all.of_setbase(True)
ds_tdl_icon.of_setbase(True) //(Appeon)Eugene 06.05.2013 - V141 ISG-CLX
//-------------appeon begin----------------------
//<$>added:long.zhang 09.23.2013
//<$>reason:V14.1 Recruitment Functionality
dw_tdl_recruit.of_setbase( true)
dw_tdl_recruit_all.of_setbase( true)
//-------------appeon end----------------------

//-------------appeon begin----------------------
//<$>added:long.zhang 03.25.2014
dw_tdl_pracview.of_setbase( true)
dw_tdl_pracview_all.of_setbase( true)
//<$>reason:V14.2 To Do List for PracView
//-------------appeon End------------------------

//---------Begin Added by (Appeon)Stephen 05.28.2015 for V15.1-Additional TDL type of Recruitment Task--------
dw_task_recruit.of_setbase( true)
dw_task_recruit_all.of_setbase( true)
//---------End Added ------------------------------------------------------

lnvo_tdl_function.of_get_module(is_module[])

dw_facility.GetChild("facility_id",dwchild)
dw_facility.GetChild("user_id",dwchild_user)
dwchild.SetTransObject(SQLCA)
dwchild_user.SetTransObject(SQLCA)
dw_todoitem.SetTransObject(SQLCA)

//---------Begin Added by (Appeon)Harry 03.20.2014 for V142 ISG-CLX--------
if iw_parent.classname( ) = 'w_todolist_contract' then
	String ls_null[]
	is_module = ls_null
	is_module[1] = "03"									
	is_module[2] = "04"
end if
//---------End Added ------------------------------------------------------
gnv_appeondb.of_startqueue( )
	dwchild.Retrieve(gs_user_id)
	dwchild_user.Retrieve(gs_user_id)
	dw_todoitem.Retrieve(gs_user_id,is_module)
gnv_appeondb.of_commitqueue( )

dw_todoitem.sort()  
//Remember the user_id which is used to retrieve Facilities, Added by Appeon long.zhang 04.13.2017 (Mednax- ODBC connect message and Data retrieval Case#70296 Bug_id#5602)
is_user_id_facility_retrieved = gs_user_id

dwchild.InsertRow(1)
dwchild.SetItem(1,"facility_name","All")
dwchild.SetItem(1,"facility_id",0)


//Start Code Change ----04.12.2011 #V11 maha 
select tdl_rights into :li_all from security_users where user_id = :gs_user_id;
//Start Code Change ----03.16.2011 #V11 maha
if li_all = 2 then
	//---------Begin Commented by (Appeon)Eugene 05.31.2013 for V141 ISG-CLX--------
//	dwchild_user.InsertRow(1)
//	dwchild_user.SetItem(1,"user_id","-All-")
	//---------End Commented ------------------------------------------------------
	
end if
//End Code Change ----03.16.2011
//End Code Change ----04.12.2011

dw_facility.SetTransObject( SQLCA )
dw_facility.InsertRow( 0 )

dw_facility.SetItem( 1, "facility_id", 0 )
dw_facility.SetItem( 1, "user_id", gs_user_id )

IF gb_contract_version THEN  //(Appeon)Eugene 06.05.2013 - V141 ISG-CLX
//	IF dwchild_user.RowCount( ) <= 1 THEN
//	IF dwchild_user.RowCount( ) <= 2 THEN //Commented by (Appeon)Harry 08.21.2014 - BugH070701
	IF  li_all = 0 THEN //(Appeon)Harry 08.21.2014 - BugH070701
//		dw_facility.Visible = False
		//---------Begin Modified by (Appeon)Harry 03.14.2014 for V142 ISG-CLX--------
		//dw_facility.Modify( "t_3.visible=1 due_date.visible=1 b_clear.visible = 1 t_1.visible=0 facility_id.visible=0 t_3.x = 50 due_date.x = 50 b_clear.x = 560 t_2.visible=0 user_id.visible=0 gb_1.width = 746")
		dw_facility.Modify( "t_2.visible=0 user_id.visible=0 gb_1.width = 746")
		//---------End Modfiied ------------------------------------------------------
//		tv_results.Y -= 200
//		tv_results.Height += 200
	ELSE
//		dw_facility.Modify( "t_1.visible=0 facility_id.visible=0 t_2.x=50 user_id.x=50 gb_1.width = 500")
		//dw_facility.Modify( "t_3.visible=1 due_date.visible=1 b_clear.visible = 1 t_1.visible=0 facility_id.visible=0 t_3.x = 50 due_date.x = 50 b_clear.x = 560")  //Commented by (Appeon)Harry 03.14.2014 - V142 ISG-CLX
//		dw_facility.Modify( "t_2.x=50 user_id.x=50")
//		dw_facility.Modify( "gb_1.width = 500")
	END IF
	dw_facility.setitem( 1, 'contract', 'Y') //(Appeon)Harry 03.14.2014 - V142 ISG-CLX
ELSE
//	IF dwchild_user.RowCount( ) <= 1 THEN
//	IF dwchild_user.RowCount( ) <= 2 THEN //Commented by (Appeon)Harry 08.21.2014 - BugH070701
	IF  li_all = 0 THEN //(Appeon)Harry 08.21.2014 - BugH070701
		dw_facility.Modify( "t_2.visible=0 user_id.visible=0 gb_1.width = 846")
//		dw_facility.Modify( "gb_1.width = 846")
	END IF
	dw_facility.setitem( 1, 'contract', 'N') //(Appeon)Harry 03.14.2014 - V142 ISG-CLX
END IF

//This.PostEvent("ue_retrieve_todolist")

//---------Begin Added by (Appeon)Harry 03.14.2014 for V142 ISG-CLX--------
Long 	  ll_value, ll_begin, ll_posx, ll_pre_width, ll_pre_posx, ll_space, ll_value_size
//Added By Ken.Guo 01/17/2013
String ls_value
ls_value = gnv_user_option.of_get_option_value( gs_user_id, 'todolist_expanded')
If (ls_value = '1' and cb_max.text = '+') or (ls_value = '0' and cb_max.text = '-') Then
	cb_max.event clicked( )
End If

//Added By Ken.Guo 01/23/2013
String ls_modify_filter, ls_modify
Long i
If gnv_user_option.of_get_option_value( 'todolist_style' ) = '2' Then //Treeview DW
	dw_result.visible = True
	tv_results.visible = False
	
	//Filter Screen
	ls_value = gnv_user_option.of_get_option_value( 'todolist_tv_filter_font' )
	If Not isnull(ls_value) and ls_value <> '' Then
		ls_modify_filter += " gb_1.Font.Face = '"+ls_value+"' "
		ls_modify_filter += " t_3.Font.Face = '"+ls_value+"' "
		ls_modify_filter += " t_2.Font.Face = '"+ls_value+"' "
		ls_modify_filter += " user_id.Font.Face = '"+ls_value+"' "
		ls_modify_filter += " due_date.Font.Face = '"+ls_value+"' "
		ls_modify_filter += " compute_email_info.Font.Face = '"+ls_value+"' "
		ls_modify_filter += " t_read_email.Font.Face = '"+ls_value+"' "
		
		//ls_modify_filter += " compute_2.Font.Face = '"+ls_value+"' "
	End If	
	
	If iw_parent.classname() = 'w_todolist' Then
		//Filter BK Color
		ls_value = gnv_user_option.of_get_option_value( 'todolist_filter_bk_color' )
		If Not isnull(ls_value) and ls_value <> '' and isnumber(ls_value) Then
			ls_modify_filter += " Datawindow.Color = '"+ls_value+"' "
		End If	
	End If
	dw_facility.Modify(ls_modify_filter)
	
	If iw_parent.classname() = 'w_todolist' Then
		//To Do List Screen BK Color
		ls_value = gnv_user_option.of_get_option_value( 'todolist_tv_bk_color' )
		If Not isnull(ls_value) and ls_value <> '' and isnumber(ls_value) Then
			ls_modify += " Datawindow.Color = '"+ls_value+"' "
		End If	
	End If

	//Level 1
	ls_value = gnv_user_option.of_get_option_value( 'todolist_tv_level1_font' )
	If Not isnull(ls_value) and ls_value <> '' Then
		ls_modify += " tdl_name.Font.Face = '"+ls_value+"' "
	End If
	
	ls_value = gnv_user_option.of_get_option_value( 'todolist_tv_level1_font_size' )
	If Not isnull(ls_value) and ls_value <> '' Then
		ls_modify += "tdl_name.Font.Height = '-"+ls_value+"' "
		If Long(ls_value) > 12 Then
			ll_value = 84 + (Long(ls_value) - 12)*10
			ls_modify += "DataWindow.Tree.Level.1.Height= '"+String(ll_value)+"'"
		End If
	End If	
	
	ls_value = gnv_user_option.of_get_option_value( 'todolist_tv_level1_font_color' )
	If Not isnull(ls_value) and ls_value <> '' Then
		ls_modify += "tdl_name.color = '"+ls_value+"' "
	End If	
	
	ls_value = gnv_user_option.of_get_option_value( 'todolist_tv_level1_font_bold' )
	If isnull(ls_value) or ls_value = '' or ls_value = '0' Then
		ls_value = '400'
	Else
		ls_value = '700'
	End If
	ls_modify += " tdl_name.Font.Weight = '"+ls_value+"' "  
	
	ls_value = gnv_user_option.of_get_option_value( 'todolist_tv_level1_font_italy' )
	If Not isnull(ls_value) and ls_value <> '' Then
		ls_modify += " tdl_name.Font.italic = '"+ls_value+"' "  
	End If	

	ls_value = gnv_user_option.of_get_option_value( 'todolist_tv_level1_font_underline' )
	If Not isnull(ls_value) and ls_value <> '' Then
		ls_modify += " tdl_name.Font.underline = '"+ls_value+"' "  
	End If		

	//Level 2
	ls_value = gnv_user_option.of_get_option_value( 'todolist_tv_level2_font' )
	If Not isnull(ls_value) and ls_value <> '' Then
		ls_modify += " tdli_name.Font.Face = '"+ls_value+"' "
	End If
	 
	ls_value = gnv_user_option.of_get_option_value( 'todolist_tv_level2_font_size' )
	If Not isnull(ls_value) and ls_value <> '' Then
		ls_modify += "tdli_name.Font.Height = '-"+ls_value+"' "
		If Long(ls_value) > 12 Then
			ll_value = 84 + (Long(ls_value) - 12)*10
			ls_modify += "DataWindow.Tree.Level.2.Height= '"+String(ll_value)+"'"
		End If		
	End If	
	
	ls_value = gnv_user_option.of_get_option_value( 'todolist_tv_level2_font_color' )
	If Not isnull(ls_value) and ls_value <> '' Then
		ls_modify += "tdli_name.color = '"+ls_value+"' "
	End If	
	
	ls_value = gnv_user_option.of_get_option_value( 'todolist_tv_level2_font_bold' )
	If isnull(ls_value) or ls_value = '' or ls_value = '0' Then
		ls_value = '400'
	Else
		ls_value = '700'
	End If
	ls_modify += " tdli_name.Font.Weight = '"+ls_value+"' "  
	
	ls_value = gnv_user_option.of_get_option_value( 'todolist_tv_level2_font_italy' )
	If Not isnull(ls_value) and ls_value <> '' Then
		ls_modify += " tdli_name.Font.italic = '"+ls_value+"' "  
	End If	

	ls_value = gnv_user_option.of_get_option_value( 'todolist_tv_level2_font_underline' )
	If Not isnull(ls_value) and ls_value <> '' Then
		ls_modify += " tdli_name.Font.underline = '"+ls_value+"' "  
	End If			

	//Level 3
	ls_value = gnv_user_option.of_get_option_value( 'todolist_tv_level3_font' )
	If Not isnull(ls_value) and ls_value <> '' Then
		For i = 1 To 12
			ls_modify += " display_field"+String(i)+".Font.Face = '"+ls_value+"' "  
		Next
	End If
	
	ls_value = gnv_user_option.of_get_option_value( 'todolist_tv_level3_font_size' )
	If Not isnull(ls_value) and ls_value <> '' Then
		For i = 1 To 12
			ls_modify += " display_field"+String(i)+".Font.Height = '-"+ls_value+"' "  
		Next
		If Long(ls_value) > 12 Then
			ll_value = 84 + (Long(ls_value) - 12)*10
			ls_modify += "DataWindow.Detail.Height= '"+String(ll_value)+"'"
		End If		
	End If	

	ls_value = gnv_user_option.of_get_option_value( 'todolist_tv_level3_font_color' )
	If Not isnull(ls_value) and ls_value <> '' Then
		For i = 1 To 12
			ls_modify += " display_field"+String(i)+".Color = '"+ls_value+"' "  
		Next
	End If		
	
	ls_value = gnv_user_option.of_get_option_value( 'todolist_tv_level3_font_bold' )
	If isnull(ls_value) or ls_value = '' or ls_value = '0' Then
		ls_value = '400'
	Else
		ls_value = '700'
	End If
	For i = 1 To 12
		ls_modify += " display_field"+String(i)+".Font.Weight = '"+ls_value+"' "  
	Next
	
	ls_value = gnv_user_option.of_get_option_value( 'todolist_tv_level3_font_italy' )
	If Not isnull(ls_value) and ls_value <> '' Then
		For i = 1 To 12
			ls_modify += " display_field"+String(i)+".Font.italic = '"+ls_value+"' "  
		Next
	End If	

	ls_value = gnv_user_option.of_get_option_value( 'todolist_tv_level3_font_underline' )
	If Not isnull(ls_value) and ls_value <> '' Then
		For i = 1 To 12
			ls_modify += " display_field"+String(i)+".Font.underline = '"+ls_value+"' "  
		Next
	End If		
	
	dw_result.Modify(ls_modify)
	
	//Set display Field Width
	ll_begin = 430
	ll_space = 50
	ls_modify = ' '
	ll_value_size = Long(gnv_user_option.of_get_option_value( 'todolist_tv_level3_font_size' ))
	For i = 1 To 12
		If ll_value_size > 9 Then
			ls_modify += " display_field"+String(i)+".Height = '" + String(( ll_value_size - 9 ) * 10 + 64 ) + "' "
		End If
		ls_value = gnv_user_option.of_get_option_value( 'todolist_display_field'+String(i)+'_width' )
		If ls_value = '' or isnull(ls_value) Then ls_value = '500' //Default Value
		If i = 1 Then
			ls_modify += " display_field"+String(i)+".width = '" + ls_value + "' "
			ll_pre_posx = ll_begin
		Else
			ll_posx = ll_pre_posx + ll_pre_width + ll_space
			ls_modify += " display_field"+String(i)+".width = '" + ls_value + "' "
			ls_modify += " display_field"+String(i)+".x = '" + String(ll_posx) + "' "
			ll_pre_posx = ll_posx
		End If
		ll_pre_width = Long(ls_value)
	Next
	
	dw_result.Modify(ls_modify)
	
	If iw_parent.classname() = 'w_todolist' Then
		ls_value = gnv_user_option.of_get_option_value( 'todolist_whole_bk_color' )
		If Not isnull(ls_value) and ls_value <> '' and isnumber(ls_value) Then
			This.Backcolor = Long(ls_value)
			dw_action_status.Modify("Datawindow.Color='"+String(ls_value)+"'")  //(Appeon)Harry 03.20.2014 - V142 ISG-CLX
		End If		
	End If
		
Else //TreeView Control
	dw_result.visible = False
	tv_results.visible = True
End If

cb_max.bringtotop = True


//---------End Added ------------------------------------------------------
end event

event ue_move_picture();//Added By Ken.Guo 2010-08-26.
//p_save.x = cb_save.x + 36
//p_go.x = cb_go.x + 36
//p_print.x = cb_print.x + 36
//p_refresh.x = cb_refresh.x + 36
//p_close.x = cb_close.x + 36
//p_save.y = cb_save.y + 14
//p_go.y = cb_go.y + 12
//p_print.y = cb_print.y + 14
//p_refresh.y = cb_refresh.y + 12
//p_close.y = cb_close.y + 14

end event

event ue_refresh_unread_email();If Isnull(gl_unread_email_cnt) Then gl_unread_email_cnt = 0

//---------Begin Modified by (Appeon)Harry 03.14.2014 for V142 ISG-CLX--------
/*
dw_facility.Modify("t_email_info.Text = 'You have " +String(gl_unread_email_cnt)+ " unread emails.'")	
If gl_unread_email_cnt > 0 Then
	dw_facility.Modify("t_read_email.visible = '1' t_email_info.color = '" + String(RGB(255,0,0)) + "' t_read_email.color = '" + String(RGB(255,0,0)) + "' " )
Else
	dw_facility.Modify("t_read_email.visible = '0' t_email_info.color = '" + String(RGB(0,0,0)) + "' t_read_email.color = '" + String(RGB(0,0,0)) + "' ")		
End If
*/
dw_facility.SetItem(1,'unread_email_cnt', gl_unread_email_cnt)
//---------End Modfiied ------------------------------------------------------

Return 
end event

event ue_move_max_button();// (Appeon)Harry 03.14.2014 - V142 ISG-CLX Copy from CLX12.0
cb_max.y = tv_results.y - 78 //(Appeon)Stephen 10.10.2016 - modify '38' to '78'  ---V15.2 Cosmetic Bug # 5358 - Minor overlap on TDL when there is a scroll bar
cb_max.x = tv_results.x + tv_results.Width - 60
cb_max.visible = True
end event

public function integer of_fill_tdl_data (long ll_handle);//---------Begin Modified by (Appeon)Harry 03.14.2014 for V142 ISG-CLX--------
Return of_fill_tdl_data(ll_handle, 'tv')
/*
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.28.2006 By: Davis
//$<reason> To retrieve to do list item.
//called from tv_results.itemexpanding

LONG ll_row,ll_rowcnt
STRING ls_tdl_module
LONG ll_tdli_id
STRING LS_Allow_Drill_Down
LONG i,j
STRING ls_column[12]
STRING ls_value
Integer li_pos, res
long ll_tvi
STRING ls_str
STRING ls_sql, ls_sql_where
n_ds ldw_tdl, ldw_tdl_all
TREEVIEWITEM ltv_item, ltv_item_data
LONG ll_rowcount
INTEGER li_width, li_column_width[12]

string ls_stat

// Check dw data
IF UpperBound(is_filter) = 0 THEN RETURN 0

// Check treeview item
tv_results.Getitem( ll_handle, ltv_item_data)
IF ltv_item_data.level <> 2 THEN RETURN 0
IF NOT ltv_item_data.children THEN RETURN 0
ll_tvi = tv_results.FindItem(ChildTreeItem!, ll_handle)
IF ll_tvi > 0 THEN RETURN 0		// The data already list

// Set Initializtion Value
ll_row = Long( ltv_item_data.Data )
IF ll_row = 0 THEN RETURN 0
IF UpperBound(is_where) < ll_row THEN RETURN 0

// Construct SQL according to term of to do item.
ls_tdl_module = dw_todoitem.GetitemString( ll_row, "tdl_basic_info_module" )
LS_Allow_Drill_Down = dw_todoitem.GetitemString( ll_row, "Allow_Drill_Down" )
IF Isnull(LS_Allow_Drill_Down) THEN LS_Allow_Drill_Down = "0"
IF LS_Allow_Drill_Down <> "1" THEN RETURN 0

// Fill Treeview Begin
SetPointer( HourGlass! )
tv_results.SetRedraw( False )

// Add the SQL that where condition to datawindow
ls_sql_where = is_where[ll_row]

IF f_validstr(ls_sql_where) THEN
	//(Appeon)Harry 11.21.2013 - V141 for BugH092901 of IntelliCredApp V14.1 History Issues
	/*
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 03.21.2007 By: Machongmin
	//$<reason> Fix a defect.
	/*
	ls_sql_where = " WHERE " + ls_sql_where
	*/
	choose case ls_tdl_module
		case "04"
			ls_sql_where = " and " + ls_sql_where
		case else
			ls_sql_where = " WHERE " + ls_sql_where
	end choose
	//---------------------------- APPEON END ----------------------------
	*/
	ls_sql_where = " WHERE " + ls_sql_where
	//end BugH092901
ELSE
	ls_sql_where = ""
END IF

CHOOSE CASE ls_tdl_module
	CASE "01"		//IntelliCred
		ldw_tdl = dw_tdl_intellicred
		ldw_tdl_all = dw_tdl_intellicred_all
		IF NOT f_validstr(Is_sql_intellicred) THEN
			Event ue_refresh_dddw(dw_tdl_intellicred)
		END IF
		ls_sql = Is_sql_intellicred + ls_sql_where
	CASE "02"		//IntelliApp
		ldw_tdl = dw_tdl_intelliapp
		ldw_tdl_all = dw_tdl_intelliapp_all
		IF NOT f_validstr(Is_sql_intelliapp) THEN event ue_refresh_dddw(dw_tdl_intelliapp )
		ls_sql = Is_sql_intelliapp + ls_sql_where
	CASE "03"		//IntelliContract
		ldw_tdl = dw_tdl_intellicontract
		ldw_tdl_all = dw_tdl_intellicontract_all
		IF NOT f_validstr(Is_sql_intellicontract) THEN event ue_refresh_dddw( dw_tdl_intellicontract)
		ls_sql = Is_sql_intellicontract + ls_sql_where
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 03.21.2007 By: Machongmin
	//$<reason> Fix a defect.
	case "04"
		ldw_tdl = dw_document
		ldw_tdl_all = dw_document_all
		IF NOT f_validstr(Is_sql_document) THEN event ue_refresh_dddw( dw_document)
		ls_sql = Is_sql_document + ls_sql_where
		
	//---------------------------- APPEON END ----------------------------
	// Add by andy 12/10/2009 (V10.1 - TDL)
	CASE "06"		
		ldw_tdl = dw_tdl_app_audit
		ldw_tdl_all = dw_tdl_app_audit_all
		IF NOT f_validstr(Is_sql_app_audit) THEN event ue_refresh_dddw( dw_tdl_app_audit )
		ls_sql = Is_sql_app_audit + ls_sql_where		
	// Add by andy 12/26/2009 (V10.1 - TDL)
	CASE "07"		
		ldw_tdl = dw_tdl_alert_item
		ldw_tdl_all = dw_tdl_alert_item_all
		IF NOT f_validstr(Is_sql_alert_item) THEN event ue_refresh_dddw( dw_tdl_alert_item )
		ls_sql = Is_sql_alert_item + ls_sql_where		
	CASE "08"	//Added by Appeon long.zhang 09.23.2013 (V14.1 Recruitment Functionality)
		ldw_tdl = dw_tdl_recruit
		ldw_tdl_all = dw_tdl_recruit_all
		IF NOT f_validstr(Is_sql_recruit) THEN event ue_refresh_dddw( dw_tdl_recruit )
		ls_sql = Is_sql_recruit + ls_sql_where		
END CHOOSE

// Retrive To Do List data
ldw_tdl.Reset()
ldw_tdl.SetFilter( "" )

//---------Begin Modified by (Appeon)Eugene 06.05.2013 for V141 ISG-CLX--------
////--------------------------- APPEON BEGIN ---------------------------
////$<add> 01.10.2007 By: Davis
////$<reason> The To Do List should always sort by the first column. 
//String ls_sort
//FOR j = 1 TO 12
//	ls_sort = dw_todoitem.GetitemString(ll_row, "Display" + String(j,"00"))
//	IF f_validstr(ls_sort) THEN
//		ldw_tdl.Setsort( ls_sort )
//		EXIT
//	END IF
//END FOR
////---------------------------- APPEON END ----------------------------

//$<Modify> 2009-01-12 By: Scofield
//$<Reason> The To Do List should always sort by the frist column and the second column

String ls_SortList,ls_SortCol
long	 ll_SortCnt

for j = 1 TO 12
	ls_SortCol = dw_todoitem.GetitemString(ll_row, "Display" + String(j,"00"))
	if f_ValidStr(ls_SortCol) then
		ls_SortList += "LookUpDisplay(" + ls_SortCol + ") A,"
		
		ll_SortCnt++
		if ll_SortCnt >= 2 then exit
	end if
next

if Right(ls_SortList,1) = "," then
	ls_SortList = Left(ls_SortList,Len(ls_SortList) - 1)
	ldw_tdl.SetSort(ls_SortList)
end if
//---------End Modfiied ------------------------------------------------------

ldw_tdl.Modify('datawindow.table.select = "' + ls_sql + '"')

ll_rowcnt = ldw_tdl.Retrieve( )
IF ll_rowcnt = 0 THEN
	DEBUGBREAK();
	messagebox("module",	ls_tdl_module)
END IF

// Copy data to total dw
ll_rowcount = ldw_tdl_all.Rowcount( )
ldw_tdl.Rowscopy( 1, ll_rowcnt, Primary!, ldw_tdl_all, ll_rowcount + 1, Primary!)


// Get 12 field from results of TO DO LIST item data
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 12.18.2006 By: Davis
//$<reason> Use new method that width perfect but performance is too bad.
/*
FOR j = 1 TO 12
	ls_column[j] = dw_todoitem.GetitemString(ll_row, "Display" + String(j,"00"))
	IF f_validstr(ls_column[j]) THEN
		li_width = Integer(ldw_tdl.Describe( ls_column[j] + ".width" ))
		li_column_width[j] = Integer(li_width / 32)		// 32 units per word
	END IF
END FOR
*/
FOR j = 1 TO 12
	ls_column[j] = dw_todoitem.GetitemString(ll_row, "Display" + String(j,"00"))
	IF NOT f_validstr(ls_column[j]) THEN CONTINUE

	FOR i = 1 TO ll_rowcnt
		ls_str = Trim(ldw_tdl.inv_base.of_getitem( i, ls_column[j] ))
		IF f_validstr(ls_str) THEN
			li_width = LenA( ls_str)
		ELSE
			li_width = 6
		END IF
		IF li_column_width[j] < li_width OR Isnull(li_column_width[j]) THEN li_column_width[j] = li_width
	END FOR
END FOR
//---------------------------- APPEON END ----------------------------


// Get content from 12 filed
FOR i = 1 TO ll_rowcnt
	ls_value = ""
	//debugbreak()
	ls_stat = ldw_tdl.inv_base.of_getitem( i, "affil_status" )
	if ls_stat = "3" then ls_value = "INACTIVE  "
	
	FOR j = 1 TO 12
		IF NOT f_validstr(ls_column[j]) THEN CONTINUE  //Start Code Change ----11.08.2012 #V12 maha - readded from V10 to not add none for non-selected fields
		
		ls_str = Trim(ldw_tdl.inv_base.of_getitem( i, ls_column[j] ))
		IF NOT f_validstr(ls_str) THEN ls_str = "(None)"
		
		li_width = LenA( ls_str)
		IF li_column_width[j] > li_width THEN
			ls_str +=  space((li_column_width[j] - li_width) )
		ELSEIF li_column_width[j] < li_width THEN
			li_column_width[j] = li_width
		END IF
		
		ls_value +=  ls_str + "    "
	END FOR
	
	ltv_item.label = ls_value
	//ltv_item. = 255
	ltv_item.data = i + ll_rowcount
	ltv_item.PictureIndex = 5
	ltv_item.SelectedPictureIndex = 6
	tv_results.InsertItemLast(ll_handle, ltv_item)
	//tv_results.textcolor = 255
END FOR

tv_results.SetRedraw( True )

SetPointer( Arrow! )

Return 1

//---------------------------- APPEON END ----------------------------
*/
//---------End Modfiied ------------------------------------------------------
end function

public function integer of_fill_treeview ();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.28.2006 By: Davis
//$<reason> To retrieve to do list item.

LONG ll_row,ll_rowcnt
STRING ls_tdl_module
STRING ls_tdl_name
STRING ls_verbiage
LONG ll_tdl_id, ll_tdl_id_previous
LONG ll_tdli_id
LONG ll_lev1, ll_lev2
TREEVIEWITEM ltv_item
STRING LS_Allow_Drill_Down
STRING ls_value
Integer li_pos
STRING ls_filter
INTEGER i
String ls_picturename
LONG ll_per_count, ll_all_count //(Appeon)Harry 03.14.2014 - V142 ISG-CLX

SetPointer( HourGlass! )

tv_results.SetRedraw( False )
dw_result.SetRedraw(False) //(Appeon)Harry 03.14.2014 - V142 ISG-CLX


// Delete all items in the TreeView.
DO UNTIL tv_results.FindItem(RootTreeItem!, 0) = -1
    tv_results.DeleteItem( 0 )
LOOP

//---------Begin Added by (Appeon)Harry 03.14.2014 for V142 ISG-CLX--------
dw_result.Reset() //Added By Ken.Guo 01/07/2013
//---------End Added ------------------------------------------------------

// Construct SQL according to term of to do item.
FOR ll_row = 1 TO dw_todoitem.Rowcount()
	ll_tdl_id = dw_todoitem.GetitemNumber( ll_row, "tdl_id" )
	ll_tdli_id = dw_todoitem.GetitemNumber( ll_row, "tdli_id" )
	ls_verbiage = dw_todoitem.GetitemString( ll_row, "verbiage" )
	ls_tdl_name = dw_todoitem.GetitemString( ll_row, "tdl_basic_info_tdl_name" )
	ls_tdl_module = dw_todoitem.GetitemString( ll_row, "tdl_basic_info_module" )
	LS_Allow_Drill_Down = dw_todoitem.GetitemString( ll_row, "Allow_Drill_Down" )
	ls_picturename = dw_todoitem.GetitemString( ll_row, "tv_icon" )
	
	//---------Begin Added by (Appeon)Harry 03.14.2014 for V142 ISG-CLX--------
	//Added By Ken.Guo 03/27/2013
	If isnumber(ls_picturename) Then
		inv_utils.of_download_picture( Long(ls_picturename),ls_picturename) 
	End If
	If Lower(ls_picturename) = 'custom039!'   Then
		ls_picturename = 'folderclosed.gif'
	End If
	
	//Added By Ken.Guo 04/11/2013. Do not support system icon for tv dw. so use default gif file.
	If AppeonGetClientType() = 'PB' and gnv_user_option.of_get_option_value( 'todolist_style' ) = '2' Then 
		If Pos(ls_picturename, ':\') = 0 and 	pos(ls_picturename, '!' ) > 0 Then
			ls_picturename = 'folderclosed.gif'
		End If
	End If	
	//---------End Added ------------------------------------------------------
	
	IF Isnull(LS_Allow_Drill_Down) THEN LS_Allow_Drill_Down = "0"

	// Find total num of TO DO LIST
	ll_rowcnt = 0
	FOR i = 1 TO UPPERBOUND( il_tdl_id )
		IF il_tdl_id[i] = ll_tdl_id AND il_tdli_id[i] = ll_tdli_id THEN
			ll_rowcnt = il_tdli_cnt[i]
			EXIT
		END IF
	END FOR

	IF Isnull( ll_rowcnt ) THEN ll_rowcnt = 0
	
	//---------Begin Added by (Appeon)Harry 03.14.2014 for V142 ISG-CLX--------
	ll_all_count += ll_rowcnt //Added By Ken.Guo 12/29/2012
	//---------End Added ------------------------------------------------------

	// TO DO LIST
	IF ll_tdl_id_previous <> ll_tdl_id THEN
		//---------Begin Added by (Appeon)Harry 03.14.2014 for V142 ISG-CLX--------
		//Added By Ken.Guo 12/29/2012
		If ll_tdl_id_previous > 0 and ll_per_count = 0 Then
			tv_results.collapseitem(ll_lev1)
		End If
		ll_per_count = ll_rowcnt
		//---------End Added ------------------------------------------------------
		ll_tdl_id_previous = ll_tdl_id
		
		ltv_item.label = ls_tdl_name
		ltv_item.data = ll_row
		ltv_item.Expanded	= TRUE
		ltv_item.Children = TRUE
		ltv_item.Bold = TRUE
		
		ltv_item.PictureIndex = 1
		ltv_item.SelectedPictureIndex = 2
		ll_lev1 = tv_results.InsertItemLast(0, ltv_item)
	//---------Begin Added by (Appeon)Harry 03.14.2014 for V142 ISG-CLX--------
	Else //Added By Ken.Guo 12/29/2012
		ll_per_count += ll_rowcnt
	//---------End Added ------------------------------------------------------
	END IF

	// TO DO LIST ITEM
	li_pos = PosA(ls_verbiage, "##")
	IF li_pos > 0 THEN
		ls_verbiage = LeftA(ls_verbiage,li_pos - 1) + STRING(ll_rowcnt) + MidA(ls_verbiage,li_pos + 2)
	END IF
	
	ltv_item.label = ls_verbiage
	ltv_item.data = ll_row
	ltv_item.Expanded	= FALSE
	ltv_item.Children = LS_Allow_Drill_Down = "1" AND ll_rowcnt > 0
	ltv_item.Bold = FALSE
	
	//---------Begin Added by (Appeon)Harry 03.14.2014 for V142 ISG-CLX--------
	If gnv_user_option.of_get_option_value( 'todolist_style' ) = '2' Then
		dw_result.InsertRow(0)
		dw_result.SetItem(dw_result.RowCount(), 'tdl_id', ll_tdl_id)
		dw_result.SetItem(dw_result.RowCount(), 'tdli_id', ll_tdli_id)
		dw_result.SetItem(dw_result.RowCount(), 'tdl_name', ls_tdl_name)
		dw_result.SetItem(dw_result.RowCount(), 'tdli_name', ls_verbiage)
		dw_result.SetItem(dw_result.RowCount(), 'tv_icon', ls_picturename)
		dw_result.SetItem(dw_result.RowCount(), 'Allow_Drill_Down', LS_Allow_Drill_Down)
		dw_result.SetItem(dw_result.RowCount(), 'child_count', ll_rowcnt)
		dw_result.SetItem(dw_result.RowCount(), 'tdl_module', ls_tdl_module)
		dw_result.SetItem(dw_result.RowCount(), 'tdl_row', ll_row)
		dw_result.SetItem(dw_result.RowCount(), 'display_field1', '0 To Do Items')
	End If
	//---------End Added ------------------------------------------------------

	//---------Begin Modified by (Appeon)Harry 03.14.2014 for V142 ISG-CLX--------
	/*
	//---------Begin Modified by (Appeon)Eugene 06.05.2013 for V141 ISG-CLX--------
//	ltv_item.PictureIndex = 3
//	ltv_item.SelectedPictureIndex = 4
	ltv_item.PictureIndex = of_find_picture_index(ls_picturename)
	ltv_item.SelectedPictureIndex = of_find_picture_index(ls_picturename)
	//---------End Modfiied ------------------------------------------------------
	
	ll_lev2 = tv_results.InsertItemLast(ll_lev1, ltv_item)
	*/
	//Added By Ken.Guo 05/07/2013. Added 'or' statement. fixed bug.
	If gnv_user_option.of_get_option_value( 'todolist_style' ) = '1' or isnull(gnv_user_option.of_get_option_value( 'todolist_style' ))  or gnv_user_option.of_get_option_value( 'todolist_style' ) = '' Then 
		ltv_item.PictureIndex = of_find_picture_index(ls_picturename)
		ltv_item.SelectedPictureIndex = of_find_picture_index(ls_picturename)
		ll_lev2 = tv_results.InsertItemLast(ll_lev1, ltv_item)
		//Added By Ken.Guo 12/29/2012	
		If ll_row = dw_todoitem.Rowcount() Then
			If ll_per_count = 0 Then
				tv_results.collapseitem(ll_lev1)
			End If	
		End If
	End If
	//---------End Modfiied ------------------------------------------------------
NEXT

tv_results.SetRedraw( True )
//---------Begin Added by (Appeon)Harry 03.14.2014 for V142 ISG-CLX--------
If gnv_user_option.of_get_option_value( 'todolist_style' ) = '2' Then
	dw_result.groupcalc( )
	Long ll_tdl_id_pre
	For i = 1 To dw_result.RowCount()
		ll_tdl_id = dw_result.GetItemNumber(i, 'tdl_id')
		If ll_tdl_id_pre = ll_tdl_id Then Continue
		If dw_result.Find('tdl_id = ' + string(ll_tdl_id) + ' and child_count > 0 ' , i, dw_result.RowCount()) > 0 Then
			dw_result.expand( i, 1)
			ll_tdl_id_pre = ll_tdl_id
		End If
	Next
End If

dw_result.SetRedraw(True)

//Added By Ken.Guo 12/29/2012
dw_facility.SetItem(1,'todo_cnt', ll_all_count)
//---------End Added ------------------------------------------------------
SetPointer( Arrow! )



Return 1

//---------------------------- APPEON END ----------------------------

end function

public function integer of_fill_report (datawindow adw);//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.28.2006 By: Davis
//$<reason> To retrieve to do list item.
//this function is for the report window

LONG ll_row,ll_rowcnt
STRING ls_tdl_module
STRING ls_tdl_name
STRING ls_verbiage
LONG ll_tdl_id, ll_tdl_id_previous
LONG ll_tdli_id
n_ds ldw_tdl
STRING LS_Allow_Drill_Down
STRING ls_value
Integer li_pos
STRING ls_filter
STRING ls_column[12]
LONG i,j
STRING ls_str
Long ll_newrow
STRING ls_sql1,ls_sql2,ls_sql3,ls_sql_where
INTEGER li_width, li_column_width[12],li_null[12]
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.27.2007 By: Machongmin
//$<reason> Fix a defect.	
string ls_sql4
//---------------------------- APPEON END ----------------------------
String ls_sql6  // Add by andy 12/18/2009 (V10.1 - TDL)
String ls_sql7  // Add by andy 12/26/2009 (V10.1 - TDL)
String ls_sql8  //Added by Appeon long.zhang 09.23.2013 (V14.1 Recruitment Functionality)
string ls_sql9  //Added by Appeon long.zhang 03.26.2014 (V14.2 To Do List for PracView)
string ls_sql10 //(Appeon)Stephen 05.26.2015 - V15.1-Additional TDL type of Recruitment Task
SetPointer( HourGlass! )

// Check dw data
IF UpperBound(is_filter) = 0 THEN RETURN 0

adw.SetRedraw( False )

// Delete all items in the TreeView.
adw.Reset()
//debugbreak()
// Construct SQL that where condition
FOR ll_row = 1 TO dw_todoitem.Rowcount()
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 03.27.2007 By: Machongmin
	//$<reason> Fix a defect.	
	ls_sql1 = ''
	ls_sql2 = ''
	ls_sql3 = ''
	ls_sql4 = ''
	ls_sql6 = ''    // Add by andy 12/18/2009 (V10.1 - TDL)
	ls_sql7 = ''    // Add by andy 12/26/2009 (V10.1 - TDL)
	ls_sql8 = ''    //Added by Appeon long.zhang 09.23.2013 (V14.1 Recruitment Functionality)
	ls_sql9 = ''    //Added by Appeon long.zhang 03.26.2014 (V14.2 To Do List for PracView)
	ls_sql10 =  '' //(Appeon)Stephen 05.26.2015 - V15.1-Additional TDL type of Recruitment Task
	//---------------------------- APPEON END ----------------------------
	ls_tdl_module = dw_todoitem.GetitemString( ll_row, "tdl_basic_info_module" )

	ls_sql_where = is_where[ll_row]
	
	CHOOSE CASE ls_tdl_module
		CASE "01"		//IntelliCred
			IF f_validstr(ls_sql_where) THEN 
				IF LenA(ls_sql1) = 0 THEN
					ls_sql1 += " (" + ls_sql_where + ")"
				ELSE
					ls_sql1 += " OR (" + ls_sql_where + ")"
				END IF
			END IF
		CASE "02"		//IntelliApp
			IF f_validstr(ls_sql_where) THEN 
				IF LenA(ls_sql2) = 0 THEN
					ls_sql2 += " (" + ls_sql_where + ")"
				ELSE
					ls_sql2 += " OR (" + ls_sql_where + ")"
				END IF
			END IF
		CASE "03"		//IntelliContract
			IF f_validstr(ls_sql_where) THEN 
				IF LenA(ls_sql3) = 0 THEN
					ls_sql3 += " (" + ls_sql_where + ")"
				ELSE
					ls_sql3 += " OR (" + ls_sql_where + ")"
				END IF
			END IF
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 03.27.2007 By: Machongmin
		//$<reason> Fix a defect.	
		CASE "04"		//IntelliContract
			IF f_validstr(ls_sql_where) THEN 
				IF LenA(ls_sql4) = 0 THEN
					ls_sql4 += " (" + ls_sql_where + ")"
				ELSE
					ls_sql4 += " OR (" + ls_sql_where + ")"
				END IF
			END IF
		//---------------------------- APPEON END ----------------------------
		// Add by andy 12/18/2009 (V10.1 - TDL)
		CASE "06"
			IF f_validstr(ls_sql_where) THEN 
				IF LenA(ls_sql6) = 0 THEN
					ls_sql6 += " (" + ls_sql_where + ")"
				ELSE
					ls_sql6 += " OR (" + ls_sql_where + ")"
				END IF
			END IF
		// Add by andy 12/26/2009 (V10.1 - TDL)
		CASE "07"
			IF f_validstr(ls_sql_where) THEN 
				IF LenA(ls_sql7) = 0 THEN
					ls_sql7 += " (" + ls_sql_where + ")"
				ELSE
					ls_sql7 += " OR (" + ls_sql_where + ")"
				END IF
			END IF
		CASE "08"//Added by Appeon long.zhang 09.23.2013 (V14.1 Recruitment Functionality)
			IF f_validstr(ls_sql_where) THEN 
				IF LenA(ls_sql8) = 0 THEN
					ls_sql8 += " (" + ls_sql_where + ")"
				ELSE
					ls_sql8 += " OR (" + ls_sql_where + ")"
				END IF
			END IF
		CASE "09"//Added by Appeon long.zhang 09.23.2013 (V14.1 Recruitment Functionality)
			IF f_validstr(ls_sql_where) THEN 
				IF LenA(ls_sql9) = 0 THEN
					ls_sql9 += " (" + ls_sql_where + ")"
				ELSE
					ls_sql9 += " OR (" + ls_sql_where + ")"
				END IF
			END IF	
		CASE "10" //(Appeon)Stephen 05.26.2015 - V15.1-Additional TDL type of Recruitment Task
			IF f_validstr(ls_sql_where) THEN 
				IF LenA(ls_sql10) = 0 THEN
					ls_sql10 += " (" + ls_sql_where + ")"
				ELSE
					ls_sql10 += " OR (" + ls_sql_where + ")"
				END IF
			END IF	
	END CHOOSE
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.27.2007 By: Machongmin
//$<reason> Fix a defect.		
//END FOR
//---------------------------- APPEON END ----------------------------
// Retrieve dw
gnv_appeondb.of_startqueue( )

IF f_validstr(ls_sql1) THEN
	IF NOT f_validstr(Is_sql_intellicred) THEN event ue_refresh_dddw( dw_tdl_intellicred)
	ls_sql1 = Is_sql_intellicred + " WHERE " + ls_sql1

	dw_tdl_intellicred.Reset()
	dw_tdl_intellicred.Modify('datawindow.table.select = "' + ls_sql1 + '"')
	dw_tdl_intellicred.Retrieve( )
END IF

IF f_validstr(ls_sql2) THEN
	IF NOT f_validstr(Is_sql_intelliapp) THEN event ue_refresh_dddw(dw_tdl_intelliapp )
	ls_sql2 = Is_sql_intelliapp + " WHERE " + ls_sql2

	dw_tdl_intelliapp.Reset()
	dw_tdl_intelliapp.Modify('datawindow.table.select = "' + ls_sql2 + '"')
	dw_tdl_intelliapp.Retrieve( )
END IF

IF f_validstr(ls_sql3) THEN
	IF NOT f_validstr(Is_sql_intellicontract) THEN event ue_refresh_dddw(dw_tdl_intellicontract )
	ls_sql3 = Is_sql_intellicontract + " where " + ls_sql3

	dw_tdl_intellicontract.Reset()
	dw_tdl_intellicontract.Modify('datawindow.table.select = "' + ls_sql3 + '"')
	dw_tdl_intellicontract.Retrieve( )
END IF
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.27.2007 By: Machongmin
//$<reason> Fix a defect.	
IF f_validstr(ls_sql4) THEN
	IF NOT f_validstr(Is_sql_document) THEN event ue_refresh_dddw(dw_document )
	ls_sql4 = Is_sql_document + " where (" + ls_sql4 + ")"//ls_sql4 = Is_sql_document + " and (" + ls_sql4 + ")"//(Appeon)Toney 09.06.2013 - V141 ISG-CLX Fix reintegration BugH082803

	dw_document.Reset()
	dw_document.Modify('datawindow.table.select = "' + ls_sql4 + '"')
	dw_document.Retrieve( )
else
	if ls_sql4 = "" then
		IF NOT f_validstr(Is_sql_document) THEN event ue_refresh_dddw(dw_document )
		ls_sql4 = Is_sql_document
	
		dw_document.Reset()
		dw_document.Modify('datawindow.table.select = "' + ls_sql4 + '"')
		dw_document.Retrieve( )
	end if
END IF
//---------------------------- APPEON END ----------------------------

// Add by andy 12/18/2009 (V10.1 - TDL)
IF f_validstr(ls_sql6) THEN
	IF NOT f_validstr(Is_sql_app_audit) THEN event ue_refresh_dddw(dw_tdl_app_audit)
	ls_sql6 = Is_sql_app_audit + " WHERE " + ls_sql6

	dw_tdl_app_audit.Reset()
	dw_tdl_app_audit.Modify('datawindow.table.select = "' + ls_sql6 + '"')
	dw_tdl_app_audit.Retrieve( )
END IF

// Add by andy 12/26/2009 (V10.1 - TDL)
IF f_validstr(ls_sql7) THEN
	IF NOT f_validstr(Is_sql_alert_item) THEN event ue_refresh_dddw(dw_tdl_alert_item)
	ls_sql7 = Is_sql_alert_item + " WHERE " + ls_sql7

	dw_tdl_alert_item.Reset()
	dw_tdl_alert_item.Modify('datawindow.table.select = "' + ls_sql7 + '"')
	dw_tdl_alert_item.Retrieve( )
END IF

IF f_validstr(ls_sql8) THEN//Added by Appeon long.zhang 09.23.2013 (V14.1 Recruitment Functionality)
	IF NOT f_validstr(Is_sql_recruit) THEN event ue_refresh_dddw(dw_tdl_recruit)
	ls_sql8 = Is_sql_recruit + " WHERE " + ls_sql8

	dw_tdl_recruit.Reset()
	dw_tdl_recruit.Modify('datawindow.table.select = "' + ls_sql8 + '"')
	dw_tdl_recruit.Retrieve( )
END IF

IF f_validstr(ls_sql9) THEN//Added by Appeon long.zhang 03.26.2014 (V14.2 To Do List for PracView)
	IF NOT f_validstr(Is_sql_pracview) THEN event ue_refresh_dddw(dw_tdl_pracview)
	ls_sql9 = Is_sql_pracview + " AND " + ls_sql9

	dw_tdl_pracview.Reset()
	dw_tdl_pracview.Modify('datawindow.table.select = "' + ls_sql9 + '"')
	dw_tdl_pracview.Retrieve( )
ELSE
	//---------Begin Added by (Appeon)Harry 08.05.2014 for BugS071101 of V14.2 Issues of New Features--------
	IF ls_sql9 = "" THEN
		IF NOT f_validstr(Is_sql_pracview) THEN event ue_refresh_dddw(dw_tdl_pracview)
		ls_sql9 = Is_sql_pracview
	
		dw_tdl_pracview.Reset()
		dw_tdl_pracview.Modify('datawindow.table.select = "' + ls_sql9 + '"')
		dw_tdl_pracview.Retrieve( )
	END IF
	//---------End Added ------------------------------------------------------
END IF

//---------Begin Added by (Appeon)Stephen 05.26.2015 for V15.1-Additional TDL type of Recruitment Task--------
IF f_validstr(ls_sql10) THEN
	IF NOT f_validstr(is_sql_task_recruit) THEN event ue_refresh_dddw(dw_task_recruit)
	ls_sql10 = is_sql_task_recruit + " WHERE " + ls_sql10

	dw_task_recruit.Reset()
	dw_task_recruit.Modify('datawindow.table.select = "' + ls_sql10 + '"')
	dw_task_recruit.Retrieve( )
END IF
//---------End Added ------------------------------------------------------
gnv_appeondb.of_commitqueue( )


// Construct SQL according to term of to do item.
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.27.2007 By: Machongmin
//$<reason> Fix a defect.	
//FOR ll_row = 1 TO dw_todoitem.Rowcount()
//---------------------------- APPEON END ----------------------------
	ll_tdl_id = dw_todoitem.GetitemNumber( ll_row, "tdl_id" )
	ll_tdli_id = dw_todoitem.GetitemNumber( ll_row, "tdli_id" )
	ls_verbiage = dw_todoitem.GetitemString( ll_row, "verbiage" )
	ls_tdl_name = dw_todoitem.GetitemString( ll_row, "tdl_basic_info_tdl_name" )
	ls_tdl_module = dw_todoitem.GetitemString( ll_row, "tdl_basic_info_module" )
	LS_Allow_Drill_Down = dw_todoitem.GetitemString( ll_row, "Allow_Drill_Down" )
	IF Isnull(LS_Allow_Drill_Down) THEN LS_Allow_Drill_Down = "0"

	CHOOSE CASE ls_tdl_module
		CASE "01"		//IntelliCred
			ldw_tdl = dw_tdl_intellicred
		CASE "02"		//IntelliApp
			ldw_tdl = dw_tdl_intelliapp
		CASE "03"		//IntelliContract
			ldw_tdl = dw_tdl_intellicontract
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 03.27.2007 By: Machongmin
		//$<reason> Fix a defect.
		CASE "04"		//IntelliContract
			ldw_tdl = dw_document	
		//---------------------------- APPEON END ----------------------------
		
		// Add by andy 12/18/2009 (V10.1 - TDL)
		CASE "06"
			ldw_tdl = dw_tdl_app_audit
			
		// Add by andy 12/26/2009 (V10.1 - TDL)
		CASE "07"
			ldw_tdl = dw_tdl_alert_item
		case "08"//Added by Appeon long.zhang 09.23.2013 (V14.1 Recruitment Functionality)
			ldw_tdl = dw_tdl_recruit
		case "09"//Added by Appeon long.zhang 03.26.2014 (V14.2 To Do List for PracView)
			ldw_tdl = dw_tdl_pracview
	END CHOOSE

	// Get 12 field from results of TO DO LIST item data
	li_column_width = li_null
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<Delete> 08.22.2007 By: Evan
	//$<Reason> Use new method that width perfect but performance is too bad.
	/*
	FOR j = 1 TO 12
		ls_column[j] = dw_todoitem.GetitemString(ll_row, "Display" + String(j,"00"))
		IF f_validstr(ls_column[j]) THEN
			li_width = Integer(ldw_tdl.Describe( ls_column[j] + ".width" ))
			li_column_width[j] = Integer(li_width / 32)		// 32 units per word
		END IF
	END FOR
	*/
	//---------------------------- APPEON END ----------------------------
	
	// Get 12 Field Column
	FOR j = 1 TO 12
		ls_column[j] = dw_todoitem.GetitemString(ll_row, "Display" + String(j,"00"))
	END FOR
	
	// Set Filter for to do list data
	ls_filter = is_filter[ll_row]
	IF ldw_tdl.SetFilter( ls_filter ) <> 1 THEN
		IF Handle(getapplication()) = 0 THEN MEssagebox("SET FILTER ERROR",ls_filter)
	END IF
	ldw_tdl.Filter( )
	ll_rowcnt = ldw_tdl.Rowcount( )

	// TO DO LIST ITEM
	li_pos = PosA(ls_verbiage, "##")
	IF li_pos > 0 THEN
		ls_verbiage = LeftA(ls_verbiage,li_pos - 1) + STRING(ldw_tdl.Rowcount()) + MidA(ls_verbiage,li_pos + 2)
	END IF
	
	IF LS_Allow_Drill_Down <> "1" OR ll_rowcnt = 0 THEN
		ll_newrow = adw.Insertrow( 0 )
		adw.SetItem(ll_newrow, "tdl_id", ll_tdl_id )
		adw.SetItem(ll_newrow, "tdl_name", ls_tdl_name )
		adw.SetItem(ll_newrow, "tdli_id", ll_tdli_id )
		adw.SetItem(ll_newrow, "tdli_name", ls_verbiage )
		
		CONTINUE;
	END IF


	// TO DO LIST ITEM DATA
	IF LS_Allow_Drill_Down = "1" THEN
		//--------------------------- APPEON BEGIN ---------------------------
		//$<Add> 08.22.2007 By: Evan
		//$<Reason> Use new method that width perfect but performance is too bad.
		for j = 1 to 12
			for i = 1 to ldw_tdl.Rowcount()
				if f_validstr(ls_Column[j]) then				
					ls_str = Trim(ldw_tdl.inv_base.of_getitem(i, ls_Column[j]))
					if f_validstr(ls_str) then
						li_Width = LenA(ls_str)
					else
						li_Width = 6
					end if					
					if li_column_width[j] < li_Width or IsNull(li_column_width[j]) then 
						li_column_width[j] = li_Width
					end if				
				end if
			next
		next		
		//---------------------------- APPEON END ----------------------------
				
		FOR i = 1 TO ldw_tdl.Rowcount()
			ls_value = ""
			FOR j = 1 TO 12
				IF f_validstr(ls_column[j]) THEN
					ls_str = Trim(ldw_tdl.inv_base.of_getitem( i, ls_column[j] ))
					IF NOT f_validstr(ls_str) THEN ls_str = "(None)"
					
					li_width = LenA( ls_str)
					IF li_column_width[j] > li_width THEN
						ls_str +=  space((li_column_width[j] - li_width) )
					ELSEIF li_column_width[j] < li_width THEN
						li_column_width[j] = li_width
					END IF
					
					ls_value +=  ls_str + "    "
				END IF
			END FOR
		
		ll_newrow = adw.Insertrow( 0 )
		adw.SetItem(ll_newrow, "tdl_id", ll_tdl_id )
		adw.SetItem(ll_newrow, "tdl_name", ls_tdl_name )
		adw.SetItem(ll_newrow, "tdli_id", ll_tdli_id )
		adw.SetItem(ll_newrow, "tdli_name", ls_verbiage )
		adw.SetItem(ll_newrow, "tdl_data", ls_value )
		
		END FOR
	END IF
NEXT

adw.Sort()
adw.GroupCalc ( )

adw.SetRedraw( True )

SetPointer( Arrow! )

Return 1

//---------------------------- APPEON END ----------------------------

end function

public subroutine of_item_changed (long handle);//--------------------------- APPEON BEGIN ---------------------------
//$<add> 12.01.2006 By: Davis
//$<reason> Implement Dashboard.

LONG ll_tvi, ll_tvi2
LONG ll_row
TREEVIEWITEM ltv_item, ltv_item2
STRING ls_tdl_module
LONG ll_wf_id, ll_wf_step_id
STRING ls_module, ls_filter
n_ds ldw
LONG ll_action_status
LONG ll_lookup_code
STRING ls_wf_complete_flag
LONG ll_active_status
boolean lb_true  //maha 11.08.2012

//Start Code Change ----11.08.2012 #V12 maha - security (prac folder - verification- set response code)
//maha changed hide and show to visible/invisible
IF w_mdi.of_security_access( 160 ) = 0 THEN
	lb_true = false
else
	lb_true = true
end if
//End Code Change ----11.08.2012

//---------Begin Modified by (Appeon)Harry 03.14.2014 for V142 ISG-CLX--------
/*
// Check treeview item
ll_tvi = tv_results.FindItem(CurrentTreeItem!, 0)
IF ll_tvi <= 0 THEN RETURN

tv_results.Getitem( ll_tvi, ltv_item)
CHOOSE CASE ltv_item.level
*/	
Long ll_level

// Check treeview item
If tv_results.visible Then
	ll_tvi = tv_results.FindItem(CurrentTreeItem!, 0)
	IF ll_tvi <= 0 THEN RETURN
	tv_results.Getitem( ll_tvi, ltv_item)
	ll_level = ltv_item.level
Else
	ll_level = 3
End If
CHOOSE CASE ll_level
//---------End Modfiied ------------------------------------------------------
	CASE 1	// To Do List level
		dw_action_status.visible = false
	CASE 2	// To Do Item level
		dw_action_status.visible = false
	CASE 3	// Drill Down record level
		If tv_results.visible Then  //(Appeon)Harry 03.14.2014 - V142 ISG-CLX
			// Get info of To Do Item Level
			ll_tvi2 = tv_results.FindItem(ParentTreeItem!, ll_tvi)
			IF ll_tvi2 <= 0 THEN RETURN
	
			tv_results.Getitem( ll_tvi2, ltv_item2)
			ll_row = Long( ltv_item2.Data )
			ls_tdl_module = dw_todoitem.GetitemString( ll_row, "tdl_basic_info_module" )
			
			// Add by andy 12/26/2009 (V10.1 - TDL)
		//	If ls_tdl_module = "07" Then
		//	If ls_tdl_module = "07" or ls_tdl_module = "08" Then//Appeon long.zhang 09.23.2013 (V14.1 Recruitment Functionality)
			If ls_tdl_module = "07" or ls_tdl_module = "08" or ls_tdl_module = "09" or ls_tdl_module = "10" Then //Add by stephen 05.26.2015 add 'ls_tdl_module = "10"' ---Added by Appeon long.zhang 03.25.2014 (V14.2 To Do List for PracView)
				dw_action_status.visible = false
				Return
			End If
			
			// Get Info of current action item
			ls_module = dw_action_status.GetitemString(1, "module")
	
			// Get info of Drill Down Record Level
			ll_row = Long( ltv_item.Data )
		//---------Begin Added by (Appeon)Harry 03.14.2014 for V142 ISG-CLX--------
		Else
			//Added By Ken.Guo 01/17/2013
			If handle <= 0 Then 
				dw_action_status.visible = false
				Return
			End If
			If Not dw_result.isexpanded( handle, 2) Then 
				dw_action_status.visible = false
				Return
			End If
			ll_row = dw_result.GetItemNumber(handle,'tdl_row')
			If ll_row = 0 Then 
				dw_action_status.visible = false
				Return
			End If
			ls_tdl_module = dw_todoitem.GetitemString( ll_row, "tdl_basic_info_module" )
			ls_module = dw_action_status.GetitemString(1, "module")
			ll_row =  dw_result.GetItemNumber(handle,'tdl_ai_row')
			If ll_row = 0 Then 
				dw_action_status.visible = false
				Return
			End If
			If ls_tdl_module = "07" or ls_tdl_module = "08" or ls_tdl_module = "09" or ls_tdl_module = "10" Then //Add by stephen 05.26.2015 add 'ls_tdl_module = "10"' ---Added by Appeon long.zhang 03.25.2014 (V14.2 To Do List for PracView)
				dw_action_status.visible = false
				Return
			End If
		End If
		//---------End Added ------------------------------------------------------
		
		CHOOSE CASE ls_tdl_module
			CASE "01"		// IntelliCred
				ldw = dw_tdl_intelliCred_all

				ls_filter = upper("'credentials verification response'")
			CASE "02"		// IntelliApp
				ldw = dw_tdl_intelliapp_all

				ls_filter = upper("'Action Status'")
			CASE "03"		// IntelliContract
				ldw = dw_tdl_intellicontract_all

				ls_filter = upper("'Contract Action Status'")
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 03.21.2007 By: Machongmin
			//$<reason> Fix a defect.
			case "04"
				ldw = dw_document_all
				ls_filter = upper("'Contract Action Status'")
			//---------------------------- APPEON END ----------------------------	
			// Add by andy 12/10/2009 (V10.1 - TDL)
			case "06"
				ldw = dw_tdl_app_audit_all
				ls_filter = upper("'Required Data Status'")
		END CHOOSE
		
		// Set data to dddw of action status field
		IF NOT f_validstr(ls_module) OR ls_module <> ls_tdl_module THEN
			dw_action_status.Setitem(1, "module", ls_tdl_module)
			
			idwc_action_status.Reset( )
			gnv_data.of_set_dwchild_fromcache("code_lookup" , ls_filter + " = upper(lookup_name)", idwc_action_status)

			SetNull(ll_lookup_code)
			idwc_action_status.Insertrow( 1 )
			//idwc_action_status.Setitem( 1, "code", "(none)")						//Commented by Scofield on 2007-08-29
			idwc_action_status.Setitem( 1, "lookup_code", ll_lookup_code)
		END IF

		// Modify by andy 12/10/2009 (V10.1 - TDL)
		If Not (ls_tdl_module = "06") Then
			ls_filter = ""
			ll_wf_id = ldw.GetItemNumber(ll_row, "wf_id")
			IF ll_wf_id > 0 THEN
				ll_wf_step_id = ldw.GetItemNumber(ll_row, "wf_action_type_id")
				ls_filter = "wf_id =" + string(ll_wf_id) + " and step_id = " + string(ll_wf_step_id) 
				ls_filter = gnv_data.of_get_filter_data("workflow_status_filter",ls_filter,"lookup_code")
			END IF
			
			idwc_action_status.SetFilter( ls_filter )
			idwc_action_status.Filter()
			
			ll_action_status = ldw.GetItemNumber(ll_row, "action_status")
		Else
			// "06"
			ll_action_status = ldw.GetItemNumber(ll_row, "pd_app_audit_data_status")
		End If

		dw_action_status.SetItem( 1, "action_status", ll_action_status)		
		
		dw_action_status.visible = lb_true  //Start Code Change ----11.08.2012 #V12 maha - security
		
		// Added by davis 01.05.2007
		If Not (ls_tdl_module = "06") Then // Add by andy 12/10/2009 (V10.1 - TDL)
			ls_wf_complete_flag = ldw.GetItemString(ll_row, "wf_complete_flag")
		End If
		CHOOSE CASE ls_tdl_module
			CASE "01"		// IntelliCred
				ll_active_status = ldw.GetItemNumber(ll_row, "verif_info_active_status")
			CASE "02"		// IntelliApp
				ll_active_status = ldw.GetItemNumber(ll_row, "net_dev_action_items_active_status")
			CASE "03"		// IntelliContract
				ll_active_status = ldw.GetItemNumber(ll_row, "ctx_action_items_active_status")
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 03.21.2007 By: Machongmin
			//$<reason> Fix a defect.
			case "04"
				ll_active_status = ldw.GetItemNumber(ll_row, "ctx_am_action_item_active_status")
			//---------------------------- APPEON END ----------------------------	
			// Add by andy 12/10/2009 (V10.1 - TDL)
			CASE "06"
				ll_active_status = ldw.GetItemNumber(ll_row, "pd_app_audit_active_status")
		END CHOOSE
		
		dw_action_status.Enabled = TRUE
		// Modify by andy 12/10/2009 (V10.1 - TDL)
		If Not (ls_tdl_module = "06") Then
			IF Upper(ls_wf_complete_flag) = 'Y' OR ll_active_status < 0 THEN
				dw_action_status.Enabled = FALSE
			END IF
		Else
			// "06"
			IF ll_active_status < 0 THEN
				dw_action_status.Enabled = FALSE
			END IF
		End If
END CHOOSE

//---------------------------- APPEON END ----------------------------

end subroutine

public function integer of_run_action (integer ai_action, string as_sql_where);//--------------------------- APPEON BEGIN ---------------------------
//$<add> 12.06.2006 By: Davis
//$<reason> Open action item window.

//---------Begin Added by (Appeon)Harry 12.02.2013 for V141 for BugH112601 of History Issues 2--------
IF isvalid(w_mdi) THEN
	IF w_mdi.of_security_access( 240 ) = 0 THEN
		messagebox('Prompt','No access privilege to Action Items.')
		RETURN 0
	END IF
END IF
//---------End Added ------------------------------------------------------
IF gs_cust_type = "I" THEN
	IF Not IsValid( w_action_items_ia ) THEN
		OpenSheetWithParm( w_action_items_ia, 99, w_mdi, 4, Layered! )
		w_action_items_ia.ii_dashboard_macro = ai_action
		w_action_items_ia.ii_dashboard_where = as_sql_where
	ELSE
		w_action_items_ia.ii_dashboard_macro = ai_action
		w_action_items_ia.ii_dashboard_where = as_sql_where
		w_action_items_ia.Event pfc_postopen()
	END IF
	
	w_action_items_ia.BringToTop = TRUE
ELSE
	IF Not IsValid( w_action_items ) THEN
		OpenSheetWithParm( w_action_items, 99, w_mdi, 4, Layered! )
		w_action_items.ii_dashboard_macro = ai_action
		w_action_items.ii_dashboard_where = as_sql_where
	ELSE
		w_action_items.ii_dashboard_macro = ai_action
		w_action_items.ii_dashboard_where = as_sql_where
		w_action_items.Event pfc_postopen( )
	END if

	w_action_items.BringToTop = TRUE
END IF

RETURN 1

//---------------------------- APPEON END ----------------------------

end function

public function integer of_goto_practitioner_action (long ll_prac_id, long ll_facility_id, long ll_parent_facility_id, long ll_rec_id, long ll_seq_no, string ls_moveto, string ls_action);//--------------------------- APPEON BEGIN ---------------------------
//$<add> 12.11.2006 By: Davis
//$<reason> The system will bring the user into the area selected in 
//$<reason> the Move To field in the To Do List Painter and then click a menu option 
//$<reason> if a value was selected in the Perform Function field in the To Do List.

// Go to appropriate row
IF ls_moveto = "05" OR ls_moveto = "06" OR ls_moveto = "07" THEN 	//Verification Status->Detail Tab
	u_dw	ldw
	Long ll_row

	iw_prac.tab_1.tabpage_verif.uo_verif_summary.rb_stat_both.checked = TRUE
	iw_prac.tab_1.tabpage_verif.uo_verif_summary.rb_stat_both.event clicked( )

	iw_prac.tab_1.tabpage_verif.uo_verif_summary.rb_ver_stat_both.checked = TRUE
	iw_prac.tab_1.tabpage_verif.uo_verif_summary.rb_ver_stat_both.event clicked( )

	ldw = iw_prac.tab_1.tabpage_verif.uo_verif_summary.dw_detail
	ll_row = ldw.Find("prac_id = " + String(ll_prac_id) + " and verif_info_facility_id = " +&
			String(ll_facility_id) + " and rec_id = " + String(ll_rec_id) +&
			" and seq_no = " + String(ll_seq_no), 1, ldw.Rowcount( ))
	IF ll_row > 0 THEN
		ldw.Setrow( ll_row )
		ldw.Scrolltorow( ll_row)
	END IF
END IF

// Perform action
Choose Case ls_action
	Case "01"		//Generate Missing Info Letter
		IF ls_moveto <> "02" THEN RETURN 1	//App Audit Tab
		iw_prac.tab_1.tabpage_app_audit.uo_app_audit.PostEvent("pfc_cst_compose_request")
	Case "02"		//Print Letters
		IF ls_moveto <> "06" THEN RETURN 1	//Verification Status->Detail Tab
		iw_prac.tab_1.tabpage_verif.uo_verif_summary.PostEvent( "pfc_cst_print_letters" )
	Case "03"		//Crawl Web
		IF ls_moveto <> "06" THEN RETURN 1	//Verification Status->Detail Tab
		iw_prac.tab_1.tabpage_verif.uo_verif_summary.PostEvent("pfc_cst_goto_web")
	Case "04"		//Send NPDB Query
		IF ls_moveto <> "06" THEN RETURN 1	//Verification Status->Detail Tab
		iw_prac.tab_1.tabpage_verif.uo_verif_summary.PostEvent( "pfc_cst_npdb_export" )
	Case "05"		//Receive NPDB Query
		IF ls_moveto <> "06" THEN RETURN 1	//Verification Status->Detail Tab
		iw_prac.tab_1.tabpage_verif.uo_verif_summary.PostEvent( "pfc_cst_npdb_export" )
	Case "06"		//Audit WebView Application
		IF ls_moveto <> "07" THEN RETURN 1	//Verification Status->Recred Tab
		// To do
	Case "07"		//Initiate Recredentialing
		IF ls_moveto <> "07" THEN RETURN 1	//Verification Status->Recred Tab
		iw_prac.tab_1.tabpage_verif.uo_verif_summary.tab_view.tabpage_recred.cbx_privs.Checked = FALSE
		iw_prac.tab_1.tabpage_verif.uo_verif_summary.tab_view.tabpage_recred.cb_init_recred.Postevent( Clicked! )
	Case "08"		//Initiate Recredentialing and Update Privileges
		IF ls_moveto <> "07" THEN RETURN 1	//Verification Status->Recred Tab
		iw_prac.tab_1.tabpage_verif.uo_verif_summary.tab_view.tabpage_recred.cbx_privs.Checked = TRUE
		iw_prac.tab_1.tabpage_verif.uo_verif_summary.tab_view.tabpage_recred.cb_init_recred.Postevent( Clicked! )
End Choose

RETURN 1

//---------------------------- APPEON END ----------------------------

end function

public function integer of_goto_practitioner (long ll_prac_id, long ll_facility_id, long ll_parent_facility_id, long ll_rec_id, long ll_seq_no, string ls_moveto, string ls_action);//--------------------------- APPEON BEGIN ---------------------------
//$<add> 12.11.2006 By: Davis
//$<reason> The system will bring the user into the area selected in 
//$<reason> the Move To field in the To Do List Painter and then click a menu option 
//$<reason> if a value was selected in the Perform Function field in the To Do List.

//Initiate serach
IF iw_prac.tab_1.SelectedTab <> 1 THEN
	iw_prac.tab_1.SelectTab( 1 )
END IF

// Find appropriate practitioner
pfc_cst_u_extended_search luo_search
luo_search = iw_prac.tab_1.tabpage_search.uo_search

luo_search.dw_org_facility_select.SetItem( 1, "facility_id", 0 )
//Start Code Change ----07.20.2011 #V11 maha - modified to retrieve only the selected practitioner not the entire list. 
//luo_search.ddlb_search_type.Text = "Last Name"
//luo_search.sle_srch_val.Text = ""
luo_search.ddlb_search_type.Text = "Prac ID"//(Appeon)Toney 11.14.2013 - V141 ISG-CLX,fix BugT110703,changed "I.D." to "Prac ID"
luo_search.sle_srch_val.Text = String(ll_prac_id)
luo_search.ddlb_status.selectitem(2) //set to search to inactive as well
iw_prac.ib_skip_inactive_mess = true
//Start Code Change ----07.20.2011

luo_search.cb_search.TriggerEvent(Clicked!)

// Check rights
Long ll_row
ll_row = luo_search.dw_search.Find("prac_id = " + String(ll_prac_id) + " AND parent_facility_id = " +&
	String(ll_parent_facility_id), 1, luo_search.dw_search.RowCount())
IF ll_row <= 0 THEN
	if of_get_app_setting("set_63","I") <> 1 then iw_prac.ib_skip_inactive_mess = false //Commented by (Appeon)Stephen 03.02.2016 - Bug id 5016 - 'Hide Do you want to re-activate practitioner' message 
	MessageBox("Warning", "Unable to find the practitioner #" + String(ll_prac_id)  + " connected to Parent Facility #" + String(ll_parent_facility_id))
	//MessageBox("Warning", "The #" + String(ll_prac_id) + " practitioner does not exist!")
	RETURN 0
END IF

luo_search.dw_search.SetRow(ll_row)
luo_search.dw_search.ScrollToRow(ll_row)

//----Begin Added by alfee 10.09.2010 ----------------
//V10.5 SK Section D - Menu and Setup
//IF gb_sk_ver and IsValid(w_prac_data_sk)THEN
IF IsValid(w_prac_data_sk)THEN	//Bug 3375 - Alfee 01.08.2013 
	IF w_prac_data_sk.cb_filter.text = "Clear" THEN
		w_prac_data_sk.dw_prac_list.setfilter("")
		w_prac_data_sk.dw_prac_list.filter()
		w_prac_data_sk.cb_filter.text = "Filter"
	END IF
	w_prac_data_sk.of_find_tv_search(ll_parent_facility_id, ll_prac_id)
END IF
//----End Added ------------------------------------------

// Go to tabpage
CHOOSE CASE ls_moveto
	CASE "01" //Credentialing Tab
		iw_prac.tab_1.SelectTab( 2 )
	CASE "02" //App Audit Tab
		iw_prac.tab_1.SelectTab( 3 )
	CASE "03" //Appointment Status->Detail 1 Tab
		iw_prac.tab_1.SelectTab( 4 )
		iw_prac.tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.Post SelectTab ( 2 )
	CASE "04" //Appointment Status->Detail 2 Tab
		iw_prac.tab_1.SelectTab( 4 )
		iw_prac.tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.Post SelectTab ( 3 )
	CASE "05" //Verification Status->Browse Tab
		IF iw_prac.tab_1.tabpage_verif.Visible = False THEN//Added by  Nova 03.31.2010
			if of_get_app_setting("set_63","I") <> 1 then iw_prac.ib_skip_inactive_mess = false //Commented by (Appeon)Stephen 03.02.2016 - Bug id 5016 - 'Hide Do you want to re-activate practitioner' message 
			Close(iw_prac)
			RETURN 0
		END IF
		iw_prac.tab_1.SelectTab( 5 )
		iw_prac.tab_1.tabpage_verif.uo_verif_summary.tab_view.Post SelectTab ( 1 )
	CASE "06" //Verification Status->Detail Tab
		IF iw_prac.tab_1.tabpage_verif.Visible = False THEN//Added by  Nova 03.31.2010
			if of_get_app_setting("set_63","I") <> 1 then iw_prac.ib_skip_inactive_mess = false //Commented by (Appeon)Stephen 03.02.2016 - Bug id 5016 - 'Hide Do you want to re-activate practitioner' message 
			Close(iw_prac)
			RETURN 0
		END IF
		iw_prac.tab_1.SelectTab( 5 )
		iw_prac.tab_1.tabpage_verif.uo_verif_summary.tab_view.Post SelectTab ( 2 )
	CASE "07" //Verification Status->Recred Tab
		IF iw_prac.tab_1.tabpage_verif.Visible = False THEN//Added by  Nova 03.31.2010
			if of_get_app_setting("set_63","I") <> 1 then iw_prac.ib_skip_inactive_mess = false //Commented by (Appeon)Stephen 03.02.2016 - Bug id 5016 - 'Hide Do you want to re-activate practitioner' message 
			Close(iw_prac)
			RETURN 0
		END IF
		iw_prac.tab_1.SelectTab( 5 )
		iw_prac.tab_1.tabpage_verif.uo_verif_summary.tab_view.Post SelectTab ( 3 )
	CASE "08" //Application Status->Detail Tab
		iw_prac.tab_1.SelectTab( 9 )
		iw_prac.tab_1.tabpage_net.uo_net.tab_1.SelectTab ( 1 )
	CASE "09" //Application Status->Id's Tab
		iw_prac.tab_1.SelectTab( 9 )
		iw_prac.tab_1.tabpage_net.uo_net.tab_1.SelectTab ( 2 )
	CASE "10" //Privileges->Browse
		iw_prac.tab_1.SelectTab( 8 )
		iw_prac.tab_1.tabpage_privileges.uo_priv.tab_1.Post SelectTab ( 1 )
	CASE "11" //Privileges->Detail
		iw_prac.tab_1.SelectTab( 8 )
		iw_prac.tab_1.tabpage_privileges.uo_priv.tab_1.Post SelectTab ( 2 )
	CASE "12" //Privileges->Expiring
		iw_prac.tab_1.SelectTab( 8 )
		iw_prac.tab_1.tabpage_privileges.uo_priv.tab_1.Post SelectTab ( 3 )
END CHOOSE

if of_get_app_setting("set_63","I") <> 1 then iw_prac.ib_skip_inactive_mess = false //Commented by (Appeon)Stephen 03.02.2016 - Bug id 5016 - 'Hide Do you want to re-activate practitioner' message 
// Perform action
This.Post Of_goto_practitioner_action( ll_prac_id, ll_facility_id, ll_parent_facility_id, ll_rec_id, ll_seq_no, ls_moveto, ls_action )

RETURN 1

//---------------------------- APPEON END ----------------------------


end function

public function integer of_goto_contract (long ll_ctx_id, string ls_moveto);//--------------------------- APPEON BEGIN ---------------------------
//$<add> 12.11.2006 By: Davis
//$<reason> The system will bring the user into the area selected in 
//$<reason> the Move To field in the To Do List Painter and then click a menu option 
//$<reason> if a value was selected in the Perform Function field in the To Do List.




// Check Right

//Start Code By Jervis 11-23-2007
/*
IF iw_contract.tab_contract_details.tabpage_search.ids_contract_access.Find("ctx_id = " + String(ll_ctx_id), 1, 1000) <= 0 THEN
	Messagebox(title, 'Access denied for contract ' +string(ll_ctx_id)+ '. Contact the contract owner.')
	iw_contract.tab_contract_details.Selecttab( 1 )
	Return 0
END IF
*/

//---------Begin Modified by (Appeon)Stephen 2013-06-17 for bug 3564--------
if iw_contract.tab_contract_details.tabpage_search.ids_search.rowcount() < 1 then
	iw_contract.tab_contract_details.tabpage_search.cb_3.event Clicked() 
end if
//---------End Modfiied ------------------------------------------------------
iw_contract.tab_contract_details.tabpage_search.ids_search.SetFilter('')
iw_contract.tab_contract_details.tabpage_search.ids_search.Filter()
IF iw_contract.tab_contract_details.tabpage_search.ids_search.Find("ctx_id = " + String(ll_ctx_id), 1, iw_contract.tab_contract_details.tabpage_search.ids_search.RowCount()) <= 0 THEN
	Messagebox("Warning", 'Access denied for contract ' +string(ll_ctx_id)+ '. Contact the contract owner.')
	iw_contract.tab_contract_details.Selecttab( 1 )
	Return 0
END IF
//End Code By Jervis 11-23-2007

//Locate in browse tabpage - Alfee 05.30.2008
Long ll_cnt, ll_found
ll_cnt = iw_contract.tab_contract_details.tabpage_search.dw_search_det1.RowCount() 
ll_found = iw_contract.tab_contract_details.tabpage_search.dw_search_det1.Find("ctx_id = " +String(ll_ctx_id), 1, ll_cnt)
IF ll_cnt < 1 or ll_found < 1 THEN 
	//Search for all contracts	
	iw_contract.tab_contract_details.tabpage_search.dw_search.Reset()
	iw_contract.tab_contract_details.tabpage_search.dw_search.InsertRow(0)
	iw_contract.tab_contract_details.tabpage_search.cb_3.event Clicked() 
	//Find the contract again
	ll_cnt = iw_contract.tab_contract_details.tabpage_search.dw_search_det1.RowCount() 
	ll_found = iw_contract.tab_contract_details.tabpage_search.dw_search_det1.Find("ctx_id = " +String(ll_ctx_id), 1, ll_cnt)	
END IF
IF ll_found > 0 THEN 
	iw_contract.tab_contract_details.tabpage_search.dw_search_det1.ScrolltoRow(ll_found)
	iw_contract.tab_contract_details.tabpage_search.dw_search_det1.SetRow(ll_found)
END IF

// Get category
Long ll_category
String ls_company
SELECT category,(select top 1 facility_name from app_facility where app_facility.facility_id = ctx_basic_info.app_facility)
INTO :ll_category, :ls_company
FROM ctx_basic_info
WHERE ctx_id = :ll_ctx_id;

// Set tab visible
Integer li_view_id
li_view_id = integer(gnv_data.of_getitem('code_lookup','ic_n',"lookup_code = " + string(ll_category)))
If li_view_id <> gi_contract_view_id Then
	gi_contract_view_id = li_view_id
	iw_contract.function dynamic wf_tab_visible(li_view_id) 
	iw_contract.function dynamic wf_set_select('All',false) 
End If

// Juage access
Boolean lb_tab_visible
String ls_tab_name
Choose Case ls_moveto
	Case "13"		//IntelliContract Folder->Detail
		lb_tab_visible = iw_contract.tab_contract_details.tabpage_details.visible
		ls_tab_name = "Detail"
	Case "14"		//IntelliContract Folder->Contacts
		lb_tab_visible = iw_contract.tab_contract_details.tabpage_contacts.visible
		ls_tab_name = "Contacts"
	Case "15"		//IntelliContract Folder->Locations
		lb_tab_visible = iw_contract.tab_contract_details.tabpage_locations.visible
		ls_tab_name = "Locations"
	Case "16"		//IntelliContract Folder->Organizations
		lb_tab_visible = iw_contract.tab_contract_details.tabpage_orgabizations.visible
		ls_tab_name = "Organizations"
	Case "17"		//IntelliContract Folder->Fee Schedule
		lb_tab_visible = iw_contract.tab_contract_details.tabpage_fee_schedules.visible
		ls_tab_name = "Fee Schedule"
	Case "18"		//IntelliContract Folder->Fee Schedule (NM)
		lb_tab_visible = iw_contract.tab_contract_details.tabpage_fee_sched2.visible
		ls_tab_name = "Fee Schedule (NM)"
	Case "19"		//IntelliContract Folder->Supporting Documents
		lb_tab_visible = iw_contract.tab_contract_details.tabpage_images.visible
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 04.16.2007 By: Machongmin
		//$<reason> Fix a defect.
		/*
		ls_tab_name = "Supporting Documents"
		*/
		ls_tab_name = "Document Manager"
		ib_isvalid_contract = lb_tab_visible
		//---------------------------- APPEON END ----------------------------
		
	Case "20"		//IntelliContract Folder->Action Items
		lb_tab_visible = iw_contract.tab_contract_details.tabpage_action_items.visible
		ls_tab_name = "Action Items"
	Case Else
		lb_tab_visible = True
End Choose

IF NOT lb_tab_visible THEN
	Messagebox("Warning", "Access denied for IntelliContract Folder->" + ls_tab_name + " tab.")
	iw_contract.tab_contract_details.Selecttab( 1 )
	Return 0
END IF

// reset the retived flag to false
iw_contract.function dynamic wf_reset_retrieved()
iw_contract.function dynamic of_select_details_tab_retrieved(false)
iw_contract.tab_contract_details.tabpage_search.inv_contract_details.is_mode = iw_contract.tab_contract_details.tabpage_search.inv_contract_details.edit
iw_contract.tab_contract_details.tabpage_images.inv_contract_details.of_set_ctx_id( ll_ctx_id )

// Set title
IF ls_moveto <> "detail" THEN
	IF f_validstr(ls_company) THEN ls_company = ' Company: ' + ls_company ELSE ls_company = ""
	iw_contract.title = 'IntelliContract ' + ls_company + '        Contract ID: ' + String(ll_ctx_id)
END IF

// Go to the appropriate tab
Choose Case ls_moveto
	Case "13"		//IntelliContract Folder->Detail
		iw_contract.tab_contract_details.Selecttab( 2 )
		Post of_setredraw_details_dws()  //(Appeon)Eugene 06.05.2013 - V141 ISG-CLX
	Case "14"		//IntelliContract Folder->Contacts
		iw_contract.tab_contract_details.Selecttab( 4 )
	Case "15"		//IntelliContract Folder->Locations
		iw_contract.tab_contract_details.Selecttab( 5 )
	Case "16"		//IntelliContract Folder->Organizations
		iw_contract.tab_contract_details.Selecttab( 6 )
	Case "17"		//IntelliContract Folder->Fee Schedule
		iw_contract.tab_contract_details.Selecttab( 7 )
	Case "18"		//IntelliContract Folder->Fee Schedule (NM)
		iw_contract.tab_contract_details.Selecttab( 8 )
	Case "19"		//IntelliContract Folder->Supporting Documents
		iw_contract.tab_contract_details.Selecttab( 9 )
	Case "20"		//IntelliContract Folder->Action Items
		iw_contract.tab_contract_details.Selecttab( 10 )
End Choose

RETURN 1

//---------------------------- APPEON END ----------------------------

end function

public function integer of_find_actionitem (integer al_seq_id);//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.24.2007 By: Machongmin
//$<reason> Fix a defect.
long ll_rowcount,ll_current

if isvalid(iw_contract) then
		
	ll_rowcount = iw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_action.tab_1.tabpage_detail.dw_detail.rowcount()
	ll_current = iw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_action.tab_1.tabpage_detail.dw_detail.find("seq_id = " + string(al_seq_id),1,ll_rowcount) 
	if ll_current > 0 then
		iw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_action.tab_1.tabpage_detail.dw_detail.post scrolltorow(ll_current)
		iw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_action.tab_1.tabpage_detail.dw_detail.post setrow(ll_current)
		iw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_action.tab_1.tabpage_detail.dw_detail.post setfocus()
	end if
end if

return 0
//---------------------------- APPEON END ----------------------------
end function

public function integer of_find_document (integer al_doc_id, string as_tabpage, integer al_seq_id);//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.24.2007 By: Machongmin
//$<reason> Fix a defect.

long ll_rowcount,ll_current

if not isvalid(iw_contract) then return -1 //modified if statement by alfee 09.04.2007

//if isvalid(iw_contract) then		
ll_rowcount = iw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.tab_1.tabpage_browse.dw_browse.rowcount()
ll_current = iw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.tab_1.tabpage_browse.dw_browse.find("doc_id = " + string(al_doc_id),1,ll_rowcount) 
if ll_current > 0 then
	iw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.tab_1.tabpage_browse.dw_browse.post setrow(ll_current)
	iw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.tab_1.tabpage_browse.dw_browse.post scrolltorow(ll_current)
	iw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.tab_1.tabpage_browse.dw_browse.post selectrow( ll_current,true)
end if
//end if

choose case as_tabpage
	case '29'
		//---------Begin Added by Alfee 09.04.2007-------------------------------------
		iw_contract.tab_contract_details.tabpage_images.tab_1.post selecttab(1)
		iw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.tab_1.Post SelectTab(1)
		//---------End Added ----------------------------------------------------------
	case '30'
		iw_contract.tab_contract_details.tabpage_images.tab_1.post selecttab(2)
		iw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_action.post event ue_post_doc_changed(al_doc_id,0,0,0)
		this.post of_find_actionitem(al_seq_id)
	//---------Begin Modified by (Appeon)Harry 06.11.2014 for BugH2014061101 of IntelliCredApp V14.1 Issues of Reintegration--------
	//case '31'
	//	iw_contract.tab_contract_details.tabpage_images.tab_1.post selecttab(3)
	case '31' //Approval Status
		iw_contract.tab_contract_details.tabpage_images.tab_1.post selecttab(1)
		iw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.Post event ue_show_approve_status( )
	case '32' //Esign Status
		iw_contract.tab_contract_details.tabpage_images.tab_1.post selecttab(1)
		iw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.Post event ue_show_sertifi_status( )
	//---------End Modfiied ------------------------------------------------------
end choose


return 0

//---------------------------- APPEON END ----------------------------
end function

public function integer of_preview_doc ();//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.26.2007 By: Machongmin
//$<reason> Fix a defect.
if isvalid(iw_contract) then
	iw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.tab_1.post selecttab(2)
end if
return 0
//---------------------------- APPEON END ----------------------------
end function

public function integer of_27_11 (long al_doc_id, string as_moveto, long al_seq_id);
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.16.2007 By: Machongmin
//$<reason> Fix a defect.
if ib_isvalid_contract then
	this.post of_find_document(al_doc_id,as_moveto,al_seq_id)
	this.post of_preview_doc()
end if	
return 1
//---------------------------- APPEON END ----------------------------
end function

public function integer of_29_09 (long al_doc_id, string as_moveto, long al_seq_id);
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.16.2007 By: Machongmin
//$<reason> Fix a defect.
if ib_isvalid_contract then
	this.post of_find_document(al_doc_id,as_moveto,al_seq_id)
	this.post of_preview_doc()								
end if
return 1
//---------------------------- APPEON END ----------------------------
end function

public function integer of_clausemap ();//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.29.2007 By: Machongmin
//$<reason> Fix a defect.	
if isvalid(iw_contract) then
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 04.16.2007 By: Machongmin
	//$<reason> Fix a defect.
	If w_mdi.of_security_access( 6917 ) = 0 Then
		return -1		
	End If
	//---------------------------- APPEON END ----------------------------
	iw_contract.dynamic post event ue_do('clausemap')
end if
return 0
//---------------------------- APPEON END ----------------------------
end function

public function integer of_29_10 (long al_doc_id, string as_moveto, long al_seq_id);
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.16.2007 By: Machongmin
//$<reason> Fix a defect.
if ib_isvalid_contract then
	this.post of_find_document(al_doc_id,as_moveto,al_seq_id)
	this.post of_preview_doc()								
	this.post of_clausemap()
end if	
return 1
//---------------------------- APPEON END ----------------------------
end function

public function integer of_30 (long al_doc_id, string as_moveto, long al_seq_id);
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.16.2007 By: Machongmin
//$<reason> Fix a defect.
if ib_isvalid_contract then
	this.post of_find_document(al_doc_id,as_moveto,al_seq_id)
end if	
return 1
//---------------------------- APPEON END ----------------------------
end function

public function integer of_31 (long al_doc_id, string as_moveto, long al_seq_id);
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.16.2007 By: Machongmin
//$<reason> Fix a defect.
if ib_isvalid_contract then
	this.post of_find_document(al_doc_id,as_moveto,al_seq_id)
end if
return 1
//---------------------------- APPEON END ----------------------------
end function

public subroutine of_set_bg_color (long al_color);This.backcolor = al_color
tv_results.backcolor = al_color

dw_facility.Modify("Datawindow.Color='"+String(al_color)+"'")
//---------Begin Modified by (Appeon)Harry 03.14.2014 for V142 ISG-CLX--------
/*
dw_facility.Modify("t_1.Background.Color='"+String(al_color)+"'")
dw_facility.Modify("t_2.Background.Color='"+String(al_color)+"'")
//dw_facility.Modify("facility_id.Background.Color='"+String(al_color)+"'")

dw_action_status.Modify("Datawindow.Color='"+String(al_color)+"'")
dw_action_status.Modify("t_1.Background.Color='"+String(al_color)+"'")
//dw_action_status.Modify("action_status.Background.Color='"+String(al_color)+"'")
*/
dw_result.Modify("Datawindow.Color='"+String(al_color)+"'")
dw_action_status.Modify("Datawindow.Color='"+String(al_color)+"'")
//---------End Modfiied ------------------------------------------------------

end subroutine

public subroutine of_set_where_due_date (datetime ldt_due_date);//////////////////////////////////////////////////////////////////////
// $<function>u_cst_todolist::of_set_where_due_date()
// $<arguments>
//		value	datetime	ldt_due_date		
// $<returns> (none)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.20.2009 by Ken.Guo
//////////////////////////////////////////////////////////////////////

idt_where_due_date = ldt_due_date


end subroutine

public function string of_gen_where_due_date (string as_module_id);//////////////////////////////////////////////////////////////////////
// $<function>u_cst_todolist::of_gen_where_due_date()
// $<arguments>
//		value	String	as_module_id		
// $<returns> string
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.20.2009 by Ken.Guo
//////////////////////////////////////////////////////////////////////

If isnull(idt_where_due_date) Then Return ''
Choose Case as_module_id
	Case '01'
		Return ''
	Case '02'
		Return ''
	Case '03'
		//---------Begin Modified by (Appeon)Harry 03.21.2014 for V142 ISG-CLX--------
		//Return " And ctx_action_items.due_date = Convert(datetime,'"+String(idt_where_due_date,'yyyy-mm-dd')+"',126) "
		Return " And (ctx_action_items.due_date >= Convert(datetime,'"+String(idt_where_due_date,'yyyy-mm-dd')+"',126)  And ctx_action_items.due_date < Convert(datetime,'"+String(RelativeDate(date(idt_where_due_date),1),'yyyy-mm-dd')+"',126) )" 
		//---------End Modfiied ------------------------------------------------------
	Case '04'
		//---------Begin Modified by (Appeon)Harry 03.21.2014 for V142 ISG-CLX--------
		//Return " And ctx_am_action_item.due_date = Convert(datetime,'"+String(idt_where_due_date,'yyyy-mm-dd')+"',126) "
		Return " And (ctx_am_action_item.due_date >= Convert(datetime,'"+String(idt_where_due_date,'yyyy-mm-dd')+"',126)  And ctx_am_action_item.due_date < Convert(datetime,'"+String(RelativeDate(date(idt_where_due_date),1),'yyyy-mm-dd')+"',126) )" 
		//---------End Modfiied ------------------------------------------------------
End Choose

Return ''
end function

public subroutine of_retrievedata ();//Added By Alan on 2009-1-21
if iw_contract.tab_contract_details.tabpage_search.ib_retriev_detail then iw_contract.tab_contract_details.tabpage_search.CB_1.event clicked()	
end subroutine

public subroutine of_reset_tv_picture ();//////////////////////////////////////////////////////////////////////
// $<function>u_cst_todolist.of_reset_tv_picture()
// $<arguments>(None)
// $<returns> (none)
// $<description>
// $<description> Refresh the Picture
//////////////////////////////////////////////////////////////////////
// $<add> 2010-09-17 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Long i,ll_cnt,ll_index
String ls_basic_picture[] = {'Custom039!','Custom050!','Custom039!','Custom050!','ScriptNo!','ScriptYes!'}
String ls_picturename
str_picture_index lstr_picture_index[]

ds_tdl_icon.Retrieve()

//Reset 
tv_results.DeletePictures()
istr_picture_index[] = lstr_picture_index[]

//Add Basic Pictures
ll_cnt = UpperBound(ls_basic_picture[])
For i = 1 To ll_cnt
	ll_index = tv_results.Addpicture( ls_basic_picture[i])
	If ll_index > 0 Then
		istr_picture_index[ UpperBound(istr_picture_index[]) + 1 ].as_picturename = ls_basic_picture[i]
		istr_picture_index[ UpperBound(istr_picture_index[]) ].al_index = ll_index
	End If
Next

//Add To Do List Pictures
ll_cnt = ds_tdl_icon.RowCount()
For i = 1 To ll_cnt
	ls_picturename = ds_tdl_icon.GetItemString(i,'tv_icon')
	//---------Begin Added by (Appeon)Harry 03.14.2014 for V142 ISG-CLX--------
	//Added By Ken.Guo 03/27/2013
	If isnumber(ls_picturename) Then
		inv_utils.of_download_picture( Long(ls_picturename),ls_picturename) 
	End If
	//---------End Added ------------------------------------------------------
	ll_index = tv_results.Addpicture( ls_picturename)
	If ll_index > 0 Then
		istr_picture_index[ UpperBound(istr_picture_index[]) + 1 ].as_picturename = ls_picturename
		istr_picture_index[ UpperBound(istr_picture_index[]) ].al_index = ll_index
	End If	
Next


Return

end subroutine

public function integer of_find_picture_index (string as_picturename);//////////////////////////////////////////////////////////////////////
// $<function>u_cst_todolistof_find_picture_index()
// $<arguments>
//		value	string	as_picturename		
// $<returns> integer
// $<description>
// $<description> Find the index in picture control.
//////////////////////////////////////////////////////////////////////
// $<add> 2010-09-17 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Long i,ll_cnt

ll_cnt = UpperBound(istr_picture_index[])
For i = 1 To ll_cnt
	If Lower(istr_picture_index[i].as_picturename ) = Lower(as_picturename) Then
		Return istr_picture_index[i].al_index
	End If
Next

Return 3 //Default Value //Custom039!


end function

public subroutine of_showcontract ();If IsValid( w_contract ) Then w_contract.Post of_show( ) //add by gavin 2011-12-31
end subroutine

public subroutine of_setredraw_details_dws ();//====================================================================
// Function: of_setredraw_details_dws
//--------------------------------------------------------------------
// Description: To workaround APB bug. The screens sometimes show as blank.
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:         Ken.Guo           Date: 01/21/2013
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


If Not Isvalid(gw_contract) Then Return 
If AppeonGetClientType() = 'PB' Then Return

If gw_contract.tab_contract_details.Selectedtab = 2 Then
	gw_contract.tab_contract_details.tabpage_details.uo_1.dw_1.Post Setredraw( True)
	gw_contract.tab_contract_details.tabpage_details.uo_1.dw_occ.Post Setredraw( True)
	gw_contract.tab_contract_details.tabpage_details.uo_1.dw_ccc.Post Setredraw( True)
	gw_contract.tab_contract_details.tabpage_details.uo_1.dw_1.Post Setredraw( True)
	gw_contract.tab_contract_details.tabpage_details.uo_1.dw_products.Post Setredraw( True)
	gw_contract.tab_contract_details.tabpage_details.uo_1.dw_contract_dates.Post Setredraw( True)
End If


end subroutine

public function integer of_fill_tdl_data (long ll_handle, string as_type);// (Appeon)Harry 03.14.2014 - V142 ISG-CLX Copy from CLX12.0
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.28.2006 By: Davis
//$<reason> To retrieve to do list item.

LONG ll_row,ll_rowcnt
STRING ls_tdl_module
LONG ll_tdli_id
STRING LS_Allow_Drill_Down
LONG i,j
STRING ls_column[12]
STRING ls_value
Integer li_pos
long ll_tvi
STRING ls_str
STRING ls_sql, ls_sql_where
n_ds ldw_tdl, ldw_tdl_all
TREEVIEWITEM ltv_item, ltv_item_data
LONG ll_rowcount
INTEGER li_width, li_column_width[12]
string ls_stat  //(Appeon)Harry 03.14.2014 - V142 ISG-CLX from ISG

// Check dw data
IF UpperBound(is_filter) = 0 THEN RETURN 0

If as_type = 'tv' Then
	// Check treeview item
	tv_results.Getitem( ll_handle, ltv_item_data)
	IF ltv_item_data.level <> 2 THEN RETURN 0
	IF NOT ltv_item_data.children THEN RETURN 0
	ll_tvi = tv_results.FindItem(ChildTreeItem!, ll_handle)
	IF ll_tvi > 0 THEN RETURN 0		// The data already list
	
	// Set Initializtion Value
	ll_row = Long( ltv_item_data.Data )
ElseIf as_type = 'dw' Then //Added By Ken.Guo 01/07/2013
	dw_result.SetRedraw(False)
	ll_row = dw_result.GetItemNumber(ll_handle,'tdl_row')
End If

IF ll_row = 0 THEN RETURN 0
IF UpperBound(is_where) < ll_row THEN RETURN 0

// Construct SQL according to term of to do item.
ls_tdl_module = dw_todoitem.GetitemString( ll_row, "tdl_basic_info_module" )
LS_Allow_Drill_Down = dw_todoitem.GetitemString( ll_row, "Allow_Drill_Down" )
IF Isnull(LS_Allow_Drill_Down) THEN LS_Allow_Drill_Down = "0"
IF LS_Allow_Drill_Down <> "1" THEN RETURN 0

// Fill Treeview Begin
SetPointer( HourGlass! )
tv_results.SetRedraw( False )

// Add the SQL that where condition to datawindow
ls_sql_where = is_where[ll_row]

IF f_validstr(ls_sql_where) THEN
	if ls_tdl_module = '10' then //(Appeon)Stephen 01.04.2017 - V15.3-To Do List additional Modifications
		ls_sql_where = " AND " + ls_sql_where
	else
		ls_sql_where = " WHERE " + ls_sql_where
	end if
	/*
	choose case ls_tdl_module
		case "04"
			ls_sql_where = " and " + ls_sql_where
		case else
			ls_sql_where = " WHERE " + ls_sql_where
	end choose
	*/
	
ELSE
	ls_sql_where = ""
END IF

CHOOSE CASE ls_tdl_module
	CASE "01"		//IntelliCred
		ldw_tdl = dw_tdl_intellicred
		ldw_tdl_all = dw_tdl_intellicred_all
		IF NOT f_validstr(Is_sql_intellicred) THEN
			Event ue_refresh_dddw(dw_tdl_intellicred)
		END IF
		ls_sql = Is_sql_intellicred + ls_sql_where
	CASE "02"		//IntelliApp
		ldw_tdl = dw_tdl_intelliapp
		ldw_tdl_all = dw_tdl_intelliapp_all
		IF NOT f_validstr(Is_sql_intelliapp) THEN event ue_refresh_dddw(dw_tdl_intelliapp )
		ls_sql = Is_sql_intelliapp + ls_sql_where
	CASE "03"		//IntelliContract
		ldw_tdl = dw_tdl_intellicontract
		ldw_tdl_all = dw_tdl_intellicontract_all
		IF NOT f_validstr(Is_sql_intellicontract) THEN event ue_refresh_dddw( dw_tdl_intellicontract)
		//Begin - Added By Mark Lee 12/26/2012
		If not isnull(il_ctx_id) and ibn_use_ctx_id = True Then 
			IF f_validstr(ls_sql_where) THEN
				ls_sql_where += " And ( ctx_basic_info.ctx_id =" + string(il_ctx_id) + ") "
			Else
				ls_sql_where += " WHERE ( ctx_basic_info.ctx_id =" + string(il_ctx_id) + ") "
			End If
		End If
		//End - Added By Mark Lee 12/26/2012

		ls_sql = Is_sql_intellicontract + ls_sql_where
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 03.21.2007 By: Machongmin
	//$<reason> Fix a defect.
	case "04"
		ldw_tdl = dw_document
		ldw_tdl_all = dw_document_all
		IF NOT f_validstr(Is_sql_document) THEN event ue_refresh_dddw( dw_document)
		//Begin - Added By Mark Lee 12/26/2012
		If not isnull(il_ctx_id)  and ibn_use_ctx_id = True Then 
			IF f_validstr(ls_sql_where) THEN
				ls_sql_where += " And ( ctx_basic_info.ctx_id =" + string(il_ctx_id) + ") "
			Else
				ls_sql_where += " WHERE ( ctx_basic_info.ctx_id =" + string(il_ctx_id) + ") "
			End If
		End If
		//End - Added By Mark Lee 12/26/2012
		ls_sql = Is_sql_document + ls_sql_where
		
	//---------------------------- APPEON END ----------------------------
	//---------Begin Added by (Appeon)Harry 03.14.2014 for V142 ISG-CLX From ISG--------
	// Add by andy 12/10/2009 (V10.1 - TDL)
	CASE "06"		
		ldw_tdl = dw_tdl_app_audit
		ldw_tdl_all = dw_tdl_app_audit_all
		IF NOT f_validstr(Is_sql_app_audit) THEN event ue_refresh_dddw( dw_tdl_app_audit )
		ls_sql = Is_sql_app_audit + ls_sql_where		
	// Add by andy 12/26/2009 (V10.1 - TDL)
	CASE "07"		
		ldw_tdl = dw_tdl_alert_item
		ldw_tdl_all = dw_tdl_alert_item_all
		IF NOT f_validstr(Is_sql_alert_item) THEN event ue_refresh_dddw( dw_tdl_alert_item )
		ls_sql = Is_sql_alert_item + ls_sql_where		
	CASE "08"	//Added by Appeon long.zhang 09.23.2013 (V14.1 Recruitment Functionality)
		ldw_tdl = dw_tdl_recruit
		ldw_tdl_all = dw_tdl_recruit_all
		IF NOT f_validstr(Is_sql_recruit) THEN event ue_refresh_dddw( dw_tdl_recruit )
		ls_sql = Is_sql_recruit + ls_sql_where	
	//---------End Added ------------------------------------------------------
	CASE "09"//Added by Appeon long.zhang 03.24.2014 (V14.2 To Do List for PracView)
		ldw_tdl = dw_tdl_pracview
		ldw_tdl_all = dw_tdl_pracview_all
		IF NOT f_validstr(Is_sql_pracview) THEN event ue_refresh_dddw( dw_tdl_pracview )
		if pos(lower(trim(ls_sql_where)),"where") > 0 then
			ls_sql_where = " AND " + MID(ls_sql_where,8)
		end if
		ls_sql = is_sql_pracview + ls_sql_where
		//debugbreak()
	CASE "10" //(Appeon)Stephen 05.26.2015 - V15.1-Additional TDL type of Recruitment Task
		ldw_tdl = dw_task_recruit
		ldw_tdl_all = dw_task_recruit_all
		IF NOT f_validstr(is_sql_task_recruit) THEN event ue_refresh_dddw( dw_task_recruit )
		ls_sql = is_sql_task_recruit + ls_sql_where
END CHOOSE

// Retrive To Do List data
ldw_tdl.Reset()
ldw_tdl.SetFilter( "" )

//Added By Ken.Guo 10/14/2013. In order to Refresh DDDW data for lookupdislplay() function.
ldw_tdl.Dataobject = ldw_tdl.Dataobject
ldw_tdl.SetTransObject(SQLCA)
event ue_refresh_dddw( ldw_tdl)

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2009-01-12 By: Scofield
//$<Reason> The To Do List should always sort by the frist column and the second column
String ls_SortList,ls_SortCol
long	 ll_SortCnt

for j = 1 TO 12
	ls_SortCol = dw_todoitem.GetitemString(ll_row, "Display" + String(j,"00"))
	if f_ValidStr(ls_SortCol) then
		ls_SortList += "LookUpDisplay(" + ls_SortCol + ") A,"
		
		ll_SortCnt++
		if ll_SortCnt >= 2 then exit
	end if
next

if Right(ls_SortList,1) = "," then
	ls_SortList = Left(ls_SortList,Len(ls_SortList) - 1)
	ldw_tdl.SetSort(ls_SortList)
end if
//---------------------------- APPEON END ----------------------------

ldw_tdl.Modify('datawindow.table.select = "' + ls_sql + '"')
ll_rowcnt = ldw_tdl.Retrieve( )
//IF ll_rowcnt = 0 THEN
//	DEBUGBREAK();
//END IF

// Copy data to total dw
ll_rowcount = ldw_tdl_all.Rowcount( )
ldw_tdl.Rowscopy( 1, ll_rowcnt, Primary!, ldw_tdl_all, ll_rowcount + 1, Primary!)

// Get 12 field from results of TO DO LIST item data
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 12.18.2006 By: Davis
//$<reason> Use new method that width perfect but performance is too bad.
/*
FOR j = 1 TO 12
	ls_column[j] = dw_todoitem.GetitemString(ll_row, "Display" + String(j,"00"))
	IF f_validstr(ls_column[j]) THEN
		li_width = Integer(ldw_tdl.Describe( ls_column[j] + ".width" ))
		li_column_width[j] = Integer(li_width / 32)		// 32 units per word
	END IF
END FOR
*/
FOR j = 1 TO 12
	ls_column[j] = dw_todoitem.GetitemString(ll_row, "Display" + String(j,"00"))
	IF NOT f_validstr(ls_column[j]) THEN CONTINUE

	FOR i = 1 TO ll_rowcnt
		ls_str = Trim(ldw_tdl.inv_base.of_getitem( i, ls_column[j] ))
		IF f_validstr(ls_str) THEN
			li_width = LEN( ls_str)
		ELSE
			li_width = 6
		END IF
		IF li_column_width[j] < li_width OR Isnull(li_column_width[j]) THEN li_column_width[j] = li_width
	END FOR
END FOR
//---------------------------- APPEON END ----------------------------

Long ll_dw_row, ll_col_index
String ls_value_org

// Get content from 12 filed
FOR i = 1 TO ll_rowcnt
	ls_value = ""
	//---------Begin Added by (Appeon)Harry 03.14.2014 for V142 ISG-CLX from ISG--------
	ls_stat = ldw_tdl.inv_base.of_getitem( i, "affil_status" )
	if ls_stat = "3" then ls_value = "INACTIVE  "
	//---------End Added ------------------------------------------------------
	//Commented By Ken.Guo 01/07/2013
	If as_type = 'dw' Then
		If i = 1 Then
			ll_dw_row = ll_handle
		Else
			dw_result.RowsCopy( ll_handle,ll_handle, Primary!, dw_result, ll_handle + i - 1, Primary!	)
			ll_dw_row = ll_handle + i - 1
			dw_result.SetItem(ll_dw_row, 'expanded1', 0)
			dw_result.SetItem(ll_dw_row, 'expanded2', 0)
		End If
	End If	
	
	ll_col_index = 0 //Added By Ken.Guo 01/07/2013
	FOR j = 1 TO 12
		
		IF NOT f_validstr(ls_column[j]) THEN CONTINUE

		ls_str = Trim(ldw_tdl.inv_base.of_getitem( i, ls_column[j] ))
		IF NOT f_validstr(ls_str) THEN ls_str = "(None)"
		ls_value_org = ls_str //Added By Ken.Guo 01/07/2013
		
		li_width = LEN( ls_str)
		IF li_column_width[j] > li_width THEN
			ls_str +=  space((li_column_width[j] - li_width) )
		ELSEIF li_column_width[j] < li_width THEN
			li_column_width[j] = li_width
		END IF
		
		ls_value +=  ls_str + "    "
		
		//Added By Ken.Guo 01/07/2013
		ll_col_index++
		If as_type = 'dw' Then
			dw_result.SetItem(ll_dw_row, 'retrieved_child' ,1)
			dw_result.SetItem(ll_dw_row, 'display_field' + String(ll_col_index) , ls_value_org)
		End If
		
	END FOR
	
	//Added By Ken.Guo 01/08/2013. Added if Statement
	If as_type = 'tv' Then
		ltv_item.label = ls_value
		ltv_item.data = i + ll_rowcount
		ltv_item.PictureIndex = 5
		ltv_item.SelectedPictureIndex = 6
		tv_results.InsertItemLast(ll_handle, ltv_item)
	ElseIf as_type = 'dw' Then
		dw_result.SetItem(ll_dw_row, 'tdl_ai_row' ,i + ll_rowcount ) //Added By Ken.Guo 01/16/2013
	End If
	
END FOR
tv_results.SetRedraw( True )

//Added By Ken.Guo 01/08/2013
Long ll_tdl_id
If as_type = 'dw' Then
	dw_result.SetItem(ll_handle, 'expanded2', 1)
//	For i = 1 To dw_result.RowCount()
//		If dw_result.GetItemNumber(i, 'expanded1') = 1 Then
//			dw_result.Expand( i,1)
//		End If
//		If dw_result.GetItemNumber(i, 'expanded2') = 1 Then
//			ll_tdl_id = dw_result.GetItemNumber(i, 'tdl_id')
//			If dw_result.Find('tdl_id = ' + String(ll_tdl_id) + ' and expanded1 = 1 ', 1, i) > 0 Then
//				dw_result.Expand( i,2)
//			End If
//		End If
//	Next
	dw_result.Event ue_expand_histroy()
	dw_result.SetRedraw(True)
End If


//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 01.20.2009 By: Ken.Guo
//$<reason> Should not Destroy these ds, 
//$ Because they are the pointer for Instance var for ds(e.g. dw_tdl_intellicontract_all)
/*
//01.19.2009 By Jervis
if isvalid(ldw_tdl) then destroy ldw_tdl
if isvalid(ldw_tdl_all) then destroy ldw_tdl_all
*/
//---------------------------- APPEON END ----------------------------
SetPointer( Arrow! )

Return 1

//---------------------------- APPEON END ----------------------------

end function

public subroutine of_invisible_close_button (boolean abn_visible);// (Appeon)Harry 03.14.2014 - V142 ISG-CLX Copy from CLX12.0
//Added By Mark Lee 04/12/2013
//p_close.visible = abn_visible
cb_close.visible = abn_visible
end subroutine

public subroutine of_set_contractmodule (string ab_value);//--------- Added by (Appeon)Harry 03.20.2014 for V142 ISG-CLX--------
dw_facility.setitem( 1, 'contract', ab_value)

end subroutine

public function integer of_getwhereclause (ref string as_where, ref string as_filter, integer ai_days, string as_field, string as_tablename);//====================================================================
//$<Function>: of_getwhereclause
//$<Arguments>:
// 	reference    string     as_where
// 	reference    string     as_filter
// 	value        integer    ai_days
// 	value        string     as_field
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.23.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

String ls_filter_field

if lower(as_tablename) = 'wv_prac_tracking' then
		ls_filter_field = as_tablename + '_' + as_field
else
		ls_filter_field = as_field
end if

if ai_days = 0 then
	as_where += " (convert(char(10),"+ as_field +",126) = convert(char(10),getdate(),126))"
	as_filter += " date(" + ls_filter_field + ") = date(today())"
elseif ai_days >= -90 then	//less than 90 days
	as_where += " (convert(char(10),"+ as_field +",126) <= convert(char(10),getdate(),126) AND convert(char(10),"+ as_field +",126) > convert(char(10),dateadd(day," + String(ai_days) + ",getdate()),126))"
	as_filter += " (date(" + ls_filter_field + ")<=date(today()) AND date(" + ls_filter_field + ")>RelativeDate(date(today()),(" + String(ai_days) + ")))"
else	//No less than 90 days
	ai_days ++
	as_where += " (convert(char(10),"+ as_field +",126) <= convert(char(10),dateadd(day," + String(ai_days) + ",getdate()),126))"
	as_filter += " (date(" + ls_filter_field + ")<=RelativeDate(date(today()),(" + String(ai_days) + ")))"
END IF

return 1
end function

public function string of_get_sql_facilities ();//====================================================================
//$<Function>: of_get_sql_facilities
//$<Arguments>:
//$<Return>:  string
//$<Description>: get the facilities of dw_facility for sql condition
//$<Author>: (Appeon) long.zhang 12.19.2014 
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
String ls_all_facilities
Int i
DataWindowChild dwchild

dw_facility.GetChild( "facility_id", dwchild )

FOR i = 1 TO dwchild.RowCount()
	ls_all_facilities = ls_all_facilities + String( dwchild.GetItemNumber( i, "facility_id" ) ) + ","
END FOR

ls_all_facilities = MidA( ls_all_facilities , 1 , LenA( ls_all_facilities ) -1 ) //gets rid of the extra comma

Return ls_all_facilities
end function

public function string of_get_sql_facilities_exists (string as_facility_column_name);//====================================================================
//$<Function>: of_get_sql_facilities_exists
//$<Arguments>:
// 	value    string    as_facility_column_name
//$<Return>:  string
//$<Description>: get the facilities of dw_facility for sql condition. Use EXISTS Where Condition to optimize the sql.
//$<Author>: (Appeon) long.zhang 04.13.2017 (Mednax- ODBC connect message and Data retrieval Case#70296 Bug_id#5602)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

String ls_all_facilities_sql
Int i

//Sub Select facilities by user id
ls_all_facilities_sql = " EXISTS (SELECT 1 FROM  security_user_facilities " & 
+ " WHERE  ( security_user_facilities.user_id = '" + is_user_id_facility_retrieved + "' ) AND  " & 
+ " ( security_user_facilities.access_rights = 1 ) AND " &
+ " ( security_user_facilities.facility_id = " + as_facility_column_name + " ))" 

Return ls_all_facilities_sql
end function

on u_cst_todolist.create
int iCurrent
call super::create
this.cb_collapse=create cb_collapse
this.cb_max=create cb_max
this.dw_result=create dw_result
this.cb_close=create cb_close
this.cb_refresh=create cb_refresh
this.cb_print=create cb_print
this.cb_go=create cb_go
this.cb_save=create cb_save
this.dw_facility=create dw_facility
this.st_time=create st_time
this.dw_action_status=create dw_action_status
this.tv_results=create tv_results
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_collapse
this.Control[iCurrent+2]=this.cb_max
this.Control[iCurrent+3]=this.dw_result
this.Control[iCurrent+4]=this.cb_close
this.Control[iCurrent+5]=this.cb_refresh
this.Control[iCurrent+6]=this.cb_print
this.Control[iCurrent+7]=this.cb_go
this.Control[iCurrent+8]=this.cb_save
this.Control[iCurrent+9]=this.dw_facility
this.Control[iCurrent+10]=this.st_time
this.Control[iCurrent+11]=this.dw_action_status
this.Control[iCurrent+12]=this.tv_results
end on

on u_cst_todolist.destroy
call super::destroy
destroy(this.cb_collapse)
destroy(this.cb_max)
destroy(this.dw_result)
destroy(this.cb_close)
destroy(this.cb_refresh)
destroy(this.cb_print)
destroy(this.cb_go)
destroy(this.cb_save)
destroy(this.dw_facility)
destroy(this.st_time)
destroy(this.dw_action_status)
destroy(this.tv_results)
end on

event constructor;call super::constructor;this.of_SetResize(true)

this.inv_resize.of_setdwzoom( false)

//This.inv_resize.of_SetOrigSize(This.WorkSpaceWidth(),This.WorkSpaceHeight())
This.inv_resize.of_Register(tv_results,This.inv_resize.scalerightbottom )
This.inv_resize.of_Register(dw_action_status,This.inv_resize.fixedbottom )
This.inv_resize.of_Register(cb_save,This.inv_resize.fixedrightbottom )
This.inv_resize.of_Register(cb_close,This.inv_resize.fixedrightbottom )
This.inv_resize.of_Register(cb_go,This.inv_resize.fixedrightbottom )
This.inv_resize.of_Register(cb_print,This.inv_resize.fixedrightbottom )
This.inv_resize.of_Register(cb_refresh,This.inv_resize.fixedrightbottom )
This.inv_resize.of_Register(cb_collapse,This.inv_resize.fixedrightbottom ) //(Appeon)Stephen 10.18.2016 - V15.3-To Do List additional Modifications

This.PostEvent("ue_move_picture") //(Appeon)Eugene 06.07.2013 - V141 ISG-CLX

IF w_mdi.of_security_access( 160 ) = 0 THEN  //Start Code Change ----11.08.2012 #V12 maha
	cb_save.visible = false  
	cb_go.visible = false 
	//---------Begin Added by (Appeon)Eugene 06.05.2013 for V141 ISG-CLX--------
//	p_save.visible = false  
//	p_go.visible = false 
	//---------End Added ------------------------------------------------------
	
end if
This.inv_resize.of_Register(dw_facility,This.inv_resize.scaleright ) //(Appeon)Harry 03.14.2014 - V142 ISG-CLX

Setnull(idt_where_due_date)  //(Appeon)Eugene 06.05.2013 - V141 ISG-CLX

This.of_getparentwindow(iw_parent) //Added By Ken.Guo 04/10/2013 //(Appeon)Harry 03.14.2014 - V142 ISG-CLX
end event

event destructor;call super::destructor;If isvalid(dw_document) Then Destroy dw_document
If isvalid(dw_document_all) Then Destroy dw_document_all
If isvalid(dw_tdl_intelliapp) Then Destroy dw_tdl_intelliapp
If isvalid(dw_tdl_intelliapp_all) Then Destroy dw_tdl_intelliapp_all
If isvalid(dw_tdl_intellicontract) Then Destroy dw_tdl_intellicontract
If isvalid(dw_tdl_intellicontract_all) Then Destroy dw_tdl_intellicontract_all
If isvalid(dw_tdl_intellicred) Then Destroy dw_tdl_intellicred
If isvalid(dw_tdl_intellicred_all) Then Destroy dw_tdl_intellicred_all
If isvalid(dw_todoitem) Then Destroy dw_todoitem
// Add by andy 03/24/2010 (V10.1 - TDL)
If isvalid(dw_tdl_app_audit) Then Destroy dw_tdl_app_audit
If isvalid(dw_tdl_app_audit_all) Then Destroy dw_tdl_app_audit_all
If isvalid(dw_tdl_alert_item) Then Destroy dw_tdl_alert_item
If isvalid(dw_tdl_alert_item_all) Then Destroy dw_tdl_alert_item_all

//-------------appeon begin----------------------
//<$>added:long.zhang 09.23.2013
//<$>reason:V14.1 Recruitment Functionality
if isValid(dw_tdl_recruit) then destroy dw_tdl_recruit
if isValid(dw_tdl_recruit_all) then destroy dw_tdl_recruit_all
//-------------appeon End------------------------

//---------Begin Added by (Appeon)Stephen 05.26.2015 for V15.1-Additional TDL type of Recruitment Task--------
if isValid(dw_task_recruit) then destroy dw_task_recruit
if isValid(dw_task_recruit_all) then destroy dw_task_recruit_all
//---------End Added ------------------------------------------------------

//-------------appeon begin----------------------
//<$>added:long.zhang 03.18.2014
//<$>reason:V14.2 To Do List for PracView
if isValid(dw_tdl_pracview) then destroy dw_tdl_pracview
if isValid(dw_tdl_pracview_all) then destroy dw_tdl_pracview_all
//-------------appeon End------------------------

if isValid(inv_data_entry) then Destroy inv_data_entry //Added by Appeon long.zhang 12.26.2014(Bug 4379 created for Case# 00051492: Audit Trail Issue)

if isValid(ids_net_dev_action_items) then Destroy ids_net_dev_action_items //Added by Appeon long.zhang 12.26.2014(Bug 4379 created for Case# 00051492: Audit Trail Issue)
end event

event resize;call super::resize;Event ue_move_picture()

//---------Begin Added by (Appeon)Harry 03.14.2014 for V142 ISG-CLX--------
dw_result.Resize(tv_results.width, tv_results.height)

This.event ue_move_max_button( )
//---------End Added ------------------------------------------------------

//---------Begin Added by (Appeon)Harry 04.11.2014 for V142 ISG-CLX--------
//When resize this window to dw_action_status.y < 320 and adjust cb_max button, the cb_go button and so on was recovered.
Boolean lb_max
lb_max = cb_max.visible
if dw_action_status.y < 320 then
	cb_max.visible = False
else
	cb_max.visible = lb_max
end if
//---------End Added ------------------------------------------------------
end event

type cb_collapse from picturebutton within u_cst_todolist
integer x = 434
integer y = 1472
integer width = 393
integer height = 92
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Collapse &All"
boolean originalsize = true
vtextalign vtextalign = vcenter!
string powertiptext = "Close"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 10.18.2016 (V15.3-To Do List additional Modifications)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_tvi

ll_tvi = tv_results.FindItem(RootTreeItem!, 0)
if this.text = "Collapse &All" then
	Do While ll_tvi > 0 
		tv_results.CollapseItem(ll_tvi)
		ll_tvi = tv_results.finditem(NextTreeItem!, ll_tvi)
	Loop
	this.text = "Expand &All"
else
	Do While ll_tvi > 0 
		tv_results.expandItem(ll_tvi)
		ll_tvi = tv_results.finditem(NextTreeItem!, ll_tvi)
	Loop
	this.text = "Collapse &All"
end if

end event

type cb_max from commandbutton within u_cst_todolist
integer x = 2743
integer y = 264
integer width = 87
integer height = 76
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "+"
end type

event clicked;// (Appeon)Harry 03.14.2014 - V142 ISG-CLX Copy from CLX12.0
cb_max.visible = False

dw_result.SetRedraw(False)
If cb_max.text = '+' Then
	dw_facility.Height = 100
	tv_results.y = tv_results.y - 220
	tv_results.Height = tv_results.Height + 220

	If dw_facility.RowCount() > 0 Then
		dw_facility.SetItem(1,'expanded',1)
	End If	
	cb_max.text = '-'
	gnv_user_option.of_set_option_value( gs_user_id, 'todolist_expanded', '1')
Else
	dw_facility.Height = 320
	If dw_facility.RowCount() > 0 Then
		dw_facility.SetItem(1,'expanded',0)
	End If
	tv_results.y = tv_results.y + 220
	tv_results.Height = tv_results.Height - 220

	cb_max.text = '+'
	gnv_user_option.of_set_option_value( gs_user_id, 'todolist_expanded', '0')
End If
gnv_user_option.of_save( )

dw_result.y = tv_results.y
dw_result.Height = tv_results.Height
dw_result.SetRedraw(True)
tv_results.SetFocus() //Workaround PB's Bug.
Parent.event ue_move_max_button( )

end event

type dw_result from u_dw within u_cst_todolist
event ue_select_getrow ( )
event ue_expand_histroy ( )
integer x = 23
integer y = 308
integer width = 2766
integer height = 1104
integer taborder = 30
string dataobject = "d_todolist_treeview"
boolean hscrollbar = true
boolean livescroll = false
end type

event ue_select_getrow();// (Appeon)Harry 03.14.2014 - V142 ISG-CLX Copy from CLX12.0
//gnv_debug.of_output( 'This.GetRow() = ' + String(This.GetRow()))
If This.GetRow() > 0 Then
//	This.SelectRow(0, True)
	This.SelectRow(0, False)
//	gnv_debug.of_output( 'This.SelectRow(0, True) = ' + String(This.SelectRow(0, True)))
//	gnv_debug.of_output( 'This.SelectRow(0, False) = ' + String(This.SelectRow(0, False)))
	This.SelectRow(GetRow(), True)
End If
end event

event ue_expand_histroy();// (Appeon)Harry 03.14.2014 - V142 ISG-CLX Copy from CLX12.0
Long i,ll_tdl_id
For i = 1 To dw_result.RowCount()
	If dw_result.GetItemNumber(i, 'expanded1') = 1 Then
		dw_result.Expand( i,1)
	End If
	If dw_result.GetItemNumber(i, 'expanded2') = 1 Then
		ll_tdl_id = dw_result.GetItemNumber(i, 'tdl_id')
		If dw_result.Find('tdl_id = ' + String(ll_tdl_id) + ' and expanded1 = 1 ', 1, i) > 0 Then
			dw_result.Expand( i,2)
		End If
	End If
Next
end event

event collapsed;call super::collapsed;// (Appeon)Harry 03.14.2014 - V142 ISG-CLX Copy from CLX12.0
If Row > 0 Then
	If GroupLevel = 1 Then
		This.SetItem(row, 'expanded1', 0)
	Else
		This.SetItem(row, 'expanded2', 0)
	End If
End If

Parent.of_item_changed(GetRow())
end event

event constructor;call super::constructor;// (Appeon)Harry 03.14.2014 - V142 ISG-CLX Copy from CLX12.0

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.04.2007 By: Davis

this.of_setupdateable( false)

dw_action_status.GetChild("action_status", idwc_action_status ) 
idwc_action_status.Insertrow(0)
dw_action_status.Insertrow(0)

//---------------------------- APPEON END ----------------------------

end event

event doubleclicked;call super::doubleclicked;If Row > 0 Then
	cb_go.PostEvent(Clicked!) 
End If
end event

event expanded;call super::expanded;// (Appeon)Harry 03.14.2014 - V142 ISG-CLX Copy from CLX12.0
If Row > 0 Then
	If GroupLevel = 1 Then
		This.SetItem(row, 'expanded1', 1)
	Else
		This.SetItem(row, 'expanded2', 1)
	End If
End If

This.Post event ue_select_getrow( )

Parent.of_item_changed(GetRow())
end event

event expanding;call super::expanding;// (Appeon)Harry 03.14.2014 - V142 ISG-CLX Copy from CLX12.0

If row > 0 and grouplevel = 2 Then
	If This.GetItemString(row, 'Allow_Drill_Down') = '1'  Then
		If This.GetItemNumber(row, 'retrieved_child') = 1  Then
			//Ignore it if added before.
		ElseIf This.GetItemNumber(row, 'child_count')  > 0 Then
			of_fill_tdl_data(row,'dw')
		End If
		Return 0
	Else
		messagebox('To-Do-List', 'Drill-down has not been set up for this item.')  //---------Added by (Appeon)Harry 07.17.2014 for To do list issues
		Return -1
	End If
End If


Return 0
end event

event itemchanged;call super::itemchanged;// (Appeon)Harry 03.14.2014 - V142 ISG-CLX Copy from CLX12.0
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.04.2007 By: Davis

cb_save.Enabled = TRUE

//---------------------------- APPEON END ----------------------------
end event

event rowfocuschanged;call super::rowfocuschanged;// (Appeon)Harry 03.14.2014 - V142 ISG-CLX Copy from CLX12.0
//Added By Ken.Guo 01/16/2013. it auto high select row in the web.
If AppeonGetClientType() = 'PB' Then
//	If This.GetRow() > 0 Then
//		This.SelectRow(0, False)
//		This.SelectRow(GetRow(), True)
//	End If
	Event ue_select_getrow()
End If

cb_save.enabled = FALSE
Parent.of_item_changed( GetRow() )
end event

type cb_close from picturebutton within u_cst_todolist
integer x = 2400
integer y = 1472
integer width = 393
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
boolean originalsize = true
vtextalign vtextalign = vcenter!
string powertiptext = "Close"
end type

event clicked;Parent.Trigger Event ue_close()
end event

type cb_refresh from picturebutton within u_cst_todolist
integer x = 2007
integer y = 1472
integer width = 393
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Refresh"
boolean originalsize = true
vtextalign vtextalign = vcenter!
string powertiptext = "Refresh"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 12.06.2006 By: Davis
//$<reason> Refresh To do list.

String ls_user_id

// Check product.
n_cst_tdl_function lnvo_tdl_function
lnvo_tdl_function.of_get_module( is_module[])

ls_user_id = dw_facility.GetItemString(1, "user_id")
//---------Begin Modified by (Appeon)Harry 01.09.2014 for V141 Bug # 3816--------
//if ls_user_id = "-All-" then ls_user_id = gs_user_id  //Start Code Change ----04.13.2011 #V11 maha 
if Upper(ls_user_id) = "-ALL-" then ls_user_id = "%" 
//---------End Modfiied ------------------------------------------------------
IF NOT f_validstr(ls_user_id) THEN ls_user_id = gs_user_id


//---------Begin Added by (Appeon)Harry 03.20.2014 for V142 ISG-CLX--------
if iw_parent.classname( ) = 'w_todolist_contract' then
	String ls_null[]
	is_module = ls_null
	is_module[1] = "03"									
	is_module[2] = "04"
end if
//---------End Added ------------------------------------------------------

dw_todoitem.Retrieve(ls_user_id, is_module)

Parent.PostEvent("ue_retrieve_todolist")

//---------------------------- APPEON END ----------------------------

end event

type cb_print from picturebutton within u_cst_todolist
integer x = 1614
integer y = 1472
integer width = 393
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Print"
boolean originalsize = true
vtextalign vtextalign = vcenter!
string powertiptext = "Print"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 12.01.2006 By: Davis
//$<reason> Implement Dashboard.

Openwithparm( w_todolist_report, Parent)

//---------------------------- APPEON END ----------------------------

end event

type cb_go from picturebutton within u_cst_todolist
integer x = 1221
integer y = 1472
integer width = 393
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Go"
boolean originalsize = true
vtextalign vtextalign = vcenter!
string powertiptext = "Go"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 12.01.2006 By: Davis
//$<reason> Implement Dashboard.

LONG ll_tvi, ll_tvi2
LONG ll_row
TREEVIEWITEM ltv_item, ltv_item2
STRING ls_tdl_module
STRING ls_moveto, ls_action
LONG ll_ctx_id
LONG ll_prac_id
LONG ll_facility_id,ll_parent_facility_id
LONG ll_rec_id
LONG ll_seq_no 
LONG ll_rowcnt
LONG ll_tdl_id
LONG ll_tdli_id
LONG i
//
// Add by andy 01/14/2010 (V10.1 - TDL)
//
LONG ll_alert_category
LONG ll_alert_type
LONG ll_active_status
STRING ls_where
//
long ll_Handle
constant long SW_SHOW       = 5
constant long WM_SYSCOMMAND = 274
constant long SC_RESTORE    = 61728

PowerObject lpo_NullParm

//////////////  DONT DELETE /////////
ib_doubleclick = FALSE
////////////////////////////////////

//---------Begin Modified by (Appeon)Harry 03.14.2014 for V142 ISG-CLX--------
/*
// Check treeview item
ll_tvi = tv_results.FindItem(CurrentTreeItem!, 0)
IF ll_tvi <= 0 THEN RETURN 0

tv_results.Getitem( ll_tvi, ltv_item)

CHOOSE CASE ltv_item.level
*/
Long ll_level
If tv_results.visible Then
	// Check treeview item
	ll_tvi = tv_results.FindItem(CurrentTreeItem!, 0)
	IF ll_tvi <= 0 THEN RETURN 0
	tv_results.Getitem( ll_tvi, ltv_item)
	ll_level = ltv_item.level 
Else
	//Added By Ken.Guo 01/16/2013
	Long ll_selected_row
	//ll_selected_row = dw_result.GetSelectedrow(0)
	ll_selected_row = dw_result.GetRow() //Web Bug, we can only use GetRow.
	
//	gnv_debug.of_output( 'll_selected_row= ' + String(ll_selected_row))
	If ll_selected_row <= 0 Then Return 0
//	gnv_debug.of_output( 'isexpanded= ' + String(dw_result.isexpanded( ll_selected_row, 2)))
	If dw_result.isexpanded( ll_selected_row, 2) Then 
		//re-set current row, because current row = 0 when collapsed and expanded tv.
		dw_result.SetRow(ll_selected_row)		
	End If
	If dw_result.GetRow() <= 0 Then Return 0
	ll_level = 3  //Only Support 3 for TV DW
End If

CHOOSE CASE ll_level
//---------End Modfiied ------------------------------------------------------
	CASE 1	// To Do List level
	CASE 2	// To Do Item level
		ll_row = Long( ltv_item.Data )
		ls_tdl_module = dw_todoitem.GetitemString( ll_row, "tdl_basic_info_module" )
		ll_tdl_id = dw_todoitem.GetitemNumber( ll_row, "tdl_id" )
		ll_tdli_id = dw_todoitem.GetitemNumber( ll_row, "tdli_id" )

		// Find total num of TO DO LIST
		ll_rowcnt = 0
		FOR i = 1 TO UPPERBOUND( il_tdl_id )
			IF il_tdl_id[i] = ll_tdl_id AND il_tdli_id[i] = ll_tdli_id THEN
				ll_rowcnt = il_tdli_cnt[i]
				EXIT
			END IF
		END FOR
	
		IF Isnull( ll_rowcnt ) THEN RETURN
		IF ll_rowcnt = 0 THEN RETURN

		CHOOSE CASE ls_tdl_module
			CASE "01"		//IntelliCred
				of_run_action(101, is_where[ll_row])		// Go to Action Items->Action Item Detail
			CASE "02"		//IntelliApp
				of_run_action(102, is_where[ll_row])		// Go to Action Items->Application Status
			CASE "03"		//IntelliContract
				of_run_action(103, is_where[ll_row])		// Go to Action Items->Contract
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 03.22.2007 By: Machongmin
			//$<reason> Fix a defect.
			CASE "04"
				of_run_action(104,is_where[ll_row])
				//W_ACTION_TEIMS.tab_1.tabpage_document_manager.tab_1.tabpage_2.dw_details.retrieve()
			//---------------------------- APPEON END ----------------------------	
			// Add by andy 12/10/2009 (V10.1 - TDL)
			CASE "06"
				of_run_action(10,is_where[ll_row])
			// Add by andy 01/14/2010 (V10.1 - TDL)
			CASE "07"
				ll_alert_category = dw_todoitem.GetitemNumber( ll_row, "action_type" )
				ll_alert_type = dw_todoitem.GetitemNumber( ll_row, "action_status" )
				ll_active_status = dw_todoitem.GetitemNumber( ll_row, "due_date" )
				
				If IsNull(ll_alert_category) Then ll_alert_category = 0
				If IsNull(ll_alert_type) Then ll_alert_type = 0
				If IsNull(ll_active_status) Then ll_active_status = -1
				
				ls_where = String(ll_alert_category) + "|" + &
							  String(ll_alert_type) + "|" + &
							  String(ll_active_status) + "|" + &
							  is_where[ll_row]
				
				// Open w_alert_audit
				OpenWithParm(w_alert_audit, ls_where)
			Case "10" //(Appeon)Stephen 10.27.2016 - V15.3-To Do List additional Modifications
				OpenWithParm(w_recruitment_data_tabs, "TDL")
				w_recruitment_data_tabs.of_run_tdl(0, is_where[ll_row], "33", "10")
		END CHOOSE

	CASE 3	// Drill Down record level
		If tv_results.visible Then  //(Appeon)Harry 03.14.2014 - V142 ISG-CLX
			// Get info of To Do Item Level
			ll_tvi2 = tv_results.FindItem(ParentTreeItem!, ll_tvi)
			IF ll_tvi2 <= 0 THEN RETURN 0
			
			tv_results.Getitem( ll_tvi2, ltv_item2)
			ll_row = Long( ltv_item2.Data )
		else
			//Added By Ken.Guo 01/16/2013
			If dw_result.getrow() <= 0 Then Return 0
			ll_row = dw_result.GetItemNumber(dw_result.GetRow(),'tdl_row')
			If ll_row = 0 Then Return 0
		end if
		ls_moveto = dw_todoitem.GetitemString( ll_row, "moveto" )
		IF NOT f_validstr(ls_moveto) THEN RETURN
		
		ls_action = dw_todoitem.GetitemString( ll_row, "perform" )
		
		ls_tdl_module = dw_todoitem.GetitemString( ll_row, "tdl_basic_info_module" )
		
		// Get info of Drill Down Record Level
		//---------Begin Modified by (Appeon)Harry 03.14.2014 for V142 ISG-CLX--------
		//ll_row = Long( ltv_item.Data )
		If tv_results.visible Then
			ll_row = Long( ltv_item.Data )
		Else
			ll_row = dw_result.GetItemNumber(dw_result.GetRow(),'tdl_ai_row')
			If ll_row = 0 Then Return 0
		End If
		//---------End Modfiied ------------------------------------------------------
		CHOOSE CASE ls_tdl_module
			//---------Begin Added by (Appeon)Stephen 10.27.2016 for V15.3-To Do List additional Modifications--------
			CASE "08" 
				ll_prac_id = dw_tdl_recruit.GetitemNumber( ll_row, "prac_id" ) 
				OpenWithParm(w_recruitment_data_tabs, "TDL")
				w_recruitment_data_tabs.of_run_tdl(ll_prac_id, "", "33", "08")
			CASE "10"
				ll_prac_id = dw_task_recruit.GetitemNumber( ll_row, "prac_id" ) 
				OpenWithParm(w_recruitment_data_tabs, "TDL")
				w_recruitment_data_tabs.of_run_tdl(ll_prac_id, "", "34", "10")
			//---------End Added ------------------------------------------------------
			CASE "01","02","06","07", "09" //IntelliCred & IntelliApp & App. Audit & Notification // Modify by andy 12/26/2009 (V10.1 - TDL)
				//---------Begin Added by (Appeon)Harry 12.02.2013 for V141 for BugH112601 of History Issues 2--------
				IF isvalid(w_mdi) THEN
					IF w_mdi.of_security_access( 40 ) = 0 THEN
						messagebox('Prompt','No access privilege to Provider.')
						RETURN 0
					END IF
				END IF
				//---------End Added ------------------------------------------------------
				IF ls_tdl_module = "01" THEN
					ll_prac_id = dw_tdl_intelliCred_all.GetitemNumber( ll_row, "prac_id" )
					ll_facility_id = dw_tdl_intelliCred_all.GetitemNumber( ll_row, "facility_id" )
					ll_rec_id = dw_tdl_intelliCred_all.GetitemNumber( ll_row, "rec_id" )
					ll_seq_no = dw_tdl_intelliCred_all.GetitemNumber( ll_row, "verif_info_seq_no" )
					ll_parent_facility_id = dw_tdl_intelliCred_all.GetitemNumber( ll_row, "pd_affil_stat_parent_facility_id" )
				ELSEIF ls_tdl_module = "02" THEN// Modify by andy 12/10/2009 (V10.1 - TDL)
					ll_prac_id = dw_tdl_intelliapp_all.GetitemNumber( ll_row, "prac_id" )
					ll_facility_id = dw_tdl_intelliapp_all.GetitemNumber( ll_row, "facility_id" )
					ll_rec_id = dw_tdl_intelliapp_all.GetitemNumber( ll_row, "rec_id" )
					ll_seq_no = dw_tdl_intelliapp_all.GetitemNumber( ll_row, "net_dev_action_items_seq_no" )
					ll_parent_facility_id = ll_facility_id
				// Add by andy 12/10/2009 (V10.1 - TDL) App. Audit
				ELSEIF ls_tdl_module = "06" THEN
					ll_prac_id = dw_tdl_app_audit_all.GetitemNumber( ll_row, "pd_app_audit_prac_id" )
					ll_facility_id = dw_tdl_app_audit_all.GetitemNumber( ll_row, "pd_app_audit_facility_id" )
					// Needn't find verif row, so set ll_rec_id and ll_seq_no to 0.
					ll_rec_id = 0//ll_rec_id = dw_tdl_app_audit_all.GetitemNumber( ll_row, "pd_app_audit_record_id" )
					ll_seq_no = 0
					ll_parent_facility_id = dw_tdl_app_audit_all.GetitemNumber( ll_row, "pd_affil_stat_parent_facility_id" )
				// Add by andy 12/26/2009 (V10.1 - TDL) Notification
				ELSEIF ls_tdl_module = "09" THEN //(Appeon)Stephen 10.27.2016 - V15.3-To Do List additional Modifications
					ll_prac_id = dw_tdl_pracview_all.GetitemNumber( ll_row, "pd_basic_prac_id" )
					ll_rec_id = dw_tdl_pracview_all.GetitemNumber( ll_row, "pd_affil_stat_rec_id" )
					ll_seq_no = 0
					ll_parent_facility_id = dw_tdl_pracview_all.GetitemNumber( ll_row, "pd_affil_stat_parent_facility_id" )
					ll_facility_id = ll_parent_facility_id		
				Else
					ll_prac_id = dw_tdl_alert_item_all.GetitemNumber( ll_row, "alert_records_prac_id" )
					ll_facility_id = dw_tdl_alert_item_all.GetitemNumber( ll_row, "alert_records_facility_id" )
					// Needn't find verif row, so set ll_rec_id and ll_seq_no to 0.
					ll_rec_id = 0//ll_rec_id = dw_tdl_alert_item_all.GetitemNumber( ll_row, "alert_records_rec_id" )
					ll_seq_no = 0
					ll_parent_facility_id = dw_tdl_alert_item_all.GetitemNumber( ll_row, "pd_affil_stat_parent_facility_id" )					
				END IF
				
				// Open the practitioner window
				IF gs_cust_type = "I" THEN
					//--------Begin Modified by  Nova 09.06.2010-----------------------
					//V10.5 SK Section D - Menu and Setup
					//					IF NOT Isvalid(w_prac_data_intelliapp) THEN
					//						OpenSheet( w_prac_data_intelliapp, w_mdi, 4, original!)
					//						w_prac_data_intelliapp.move(0,0)
					//						w_prac_data_intelliapp.BringToTop = TRUE
					//					END IF
					//					
					//					iw_prac = w_prac_data_intelliapp
					//if gb_sk_ver = False then	
					IF NOT gb_sk_ver AND (IsNull(gi_prac_tab) OR gi_prac_tab <> 1) THEN //Bug 3375 - Alfee 01.08.2013 	
						IF NOT Isvalid(w_prac_data_intelliapp) THEN
							OpenSheet( w_prac_data_intelliapp, w_mdi, 4, original!)
							w_prac_data_intelliapp.move(0,0)
							w_prac_data_intelliapp.BringToTop = TRUE
						END IF
						iw_prac = w_prac_data_intelliapp
					//elseif gb_sk_ver = true  then
					ELSE	//Bug 3375 - Alfee 01.08.2013 
						IF NOT Isvalid(w_prac_data_sk) THEN
							OpenSheet( w_prac_data_SK, w_mdi, 4, original!)
						END IF
						iw_prac = w_prac_data_SK
					END IF
					//--------End Modified --------------------------------------------
				ELSE
					IF NOT Isvalid(w_prac_data_1) THEN
						OpenSheet( w_prac_data_1, w_mdi, 4, original!)
					END IF
					
					iw_prac = w_prac_data_1
				END IF
				iw_prac.BringToTop = TRUE

				Parent.post of_goto_practitioner( ll_prac_id, ll_facility_id, ll_parent_facility_id, ll_rec_id, ll_seq_no, ls_moveto, ls_action)
			CASE "03"		//IntelliContract
				ll_ctx_id = dw_tdl_intellicontract_all.GetitemNumber( ll_row, "ctx_id")
				IF Isnull(ll_ctx_id) OR ll_ctx_id = 0 THEN RETURN
				//---------Begin Added by (Appeon)Harry 12.02.2013 for V141 for BugH112601 of History Issues 2--------
				IF isvalid(w_mdi) THEN
					IF w_mdi.of_security_access( 2070 ) = 0 THEN
						messagebox('Prompt','No access privilege to Contract.')
						RETURN 0
					END IF
				END IF
				//---------End Added ------------------------------------------------------
				//Open the Contract window
				IF NOT Isvalid(gw_contract) THEN
					/*window child
					OpenSheet(child, "w_contract", w_mdi, 4, original!)*/
					gf_OpenContractFolder(lpo_NullParm)				//Modified by Scofield on 2008-11-19
				END IF
				
				//Start code By Jervis 12.02.2008
				//Restore windows size
				if isvalid(gw_contract) then
					if gw_contract.windowstate = Minimized! then
						ll_Handle = Handle(w_contract)
						SendMessage(ll_Handle, WM_SYSCOMMAND, SC_RESTORE, 0)
					end if
				end if
				//End code By Jervis 12.02.2008
				
				iw_contract = gw_contract
				iw_contract.Bringtotop = TRUE
				



				Parent.post of_goto_contract( ll_ctx_id, ls_moveto )
				//--------------------------- APPEON BEGIN ---------------------------
				//$<modify> 03.22.2007 By: Machongmin
				//$<reason> Fix a defect.
			CASE "04"
				long ll_rowcount,ll_current,ll_doc_id,ll_seq_id
				
				ll_ctx_id = dw_document_all.GetitemNumber( ll_row, "ctx_id")
				ll_doc_id = dw_document_all.getitemnumber( ll_row, "doc_id")
				ll_seq_id = dw_document_all.getitemnumber( ll_row, "seq_id")
				
				IF Isnull(ll_ctx_id) OR ll_ctx_id = 0 THEN RETURN
				//---------Begin Added by (Appeon)Harry 12.02.2013 for V141 for BugH112601 of History Issues 2--------
				IF isvalid(w_mdi) THEN
					IF w_mdi.of_security_access( 2070 ) = 0 THEN
						messagebox('Prompt','No access privilege to Contract.')
						RETURN 0
					END IF
				END IF
				//---------End Added ------------------------------------------------------

				//Open the Contract window
				IF NOT Isvalid(gw_contract) THEN
					//OpenSheet(child, "w_contract", w_mdi, 4, original!)
					gf_OpenContractFolder(lpo_NullParm)				//Modified by Scofield on 2008-11-19
				END IF
				
				//Start code By Jervis 12.02.2008
				//Restore windows size
				if isvalid(gw_contract) then
					if gw_contract.windowstate = Minimized! then
						ll_Handle = Handle(w_contract)
						SendMessage(ll_Handle, WM_SYSCOMMAND, SC_RESTORE, 0)
					end if
				end if
				//End code By Jervis 12.02.2008
				
				iw_contract = gw_contract
				iw_contract.Bringtotop = TRUE
				
				
				choose case ls_moveto
					case '21','22','23','24','25','26','28'
						Parent.post of_goto_contract( ll_ctx_id, string (long (ls_moveto) - 8 ))
					case '27'
						choose case ls_action 
							case '11'
								Parent.post of_goto_contract( ll_ctx_id, '19')
								//--------------------------- APPEON BEGIN ---------------------------
								//$<modify> 04.16.2007 By: Machongmin
								//$<reason> Fix a defect.
								/*
								parent.post of_find_document(ll_doc_id,ls_moveto,ll_seq_id)
								parent.post of_preview_doc()
								*/
								parent.post of_27_11(ll_doc_id,ls_moveto,ll_seq_id)
								//---------------------------- APPEON END ----------------------------
						end choose
					case '29','32'
						Parent.post of_goto_contract( ll_ctx_id, '19') //moved here by Alfee 09.04.2007
						choose case ls_action 
							case '09'	
								//Parent.post of_goto_contract( ll_ctx_id, '19')
								//--------------------------- APPEON BEGIN ---------------------------
								//$<modify> 04.16.2007 By: Machongmin
								//$<reason> Fix a defect.
								/*
								parent.post of_find_document(ll_doc_id,ls_moveto,ll_seq_id)
								parent.post of_preview_doc()								
								*/
								parent.post of_29_09(ll_doc_id,ls_moveto,ll_seq_id)
								//---------------------------- APPEON END ----------------------------
							case '10'
								//Parent.post of_goto_contract( ll_ctx_id, '19')
								//--------------------------- APPEON BEGIN ---------------------------
								//$<modify> 04.16.2007 By: Machongmin
								//$<reason> Fix a defect.
								/*
								parent.post of_find_document(ll_doc_id,ls_moveto,ll_seq_id)
								parent.post of_preview_doc()
								parent.post of_clausemap()
								*/
								parent.post of_29_10(ll_doc_id,ls_moveto,ll_seq_id)
								//---------------------------- APPEON END ----------------------------
							case else //added by alfee 09.04.2007
								parent.post of_find_document(ll_doc_id,ls_moveto,ll_seq_id)
						end choose
						
					case '30'
						Parent.post of_goto_contract( ll_ctx_id, '19')
						//--------------------------- APPEON BEGIN ---------------------------
						//$<modify> 04.16.2007 By: Machongmin
						//$<reason> Fix a defect.
						/*
						parent.post of_find_document(ll_doc_id,ls_moveto,ll_seq_id)
						*/
						parent.post of_30(ll_doc_id,ls_moveto,ll_seq_id)
						//---------------------------- APPEON END ----------------------------
					case '31'
						Parent.post of_goto_contract( ll_ctx_id, '19')
						//--------------------------- APPEON BEGIN ---------------------------
						//$<modify> 04.16.2007 By: Machongmin
						//$<reason> Fix a defect.
						/*
						parent.post of_find_document(ll_doc_id,ls_moveto,ll_seq_id)
						*/
						parent.post of_31(ll_doc_id,ls_moveto,ll_seq_id)
						//---------------------------- APPEON END ----------------------------
				end choose 
				//---------------------------- APPEON END ----------------------------
		END CHOOSE
		//---------Begin Added by (Appeon)Eugene 06.05.2013 for V141 ISG-CLX--------
		//Begin - Added By Mark Lee 04/28/12
		If isvalid(w_appeon_gifofwait ) Then Post close( w_appeon_gifofwait ) // add by gavin 2012-01-09
		//Parent.Post of_ShowContract( ) //add by gavin 2012-01-09//(Appeon)Toney 11.18.2013 - V141 ISG-CLX Fix BugT111301
		//End - Added By Mark Lee 04/28/12
		//---------End Added ------------------------------------------------------
END CHOOSE

//---------------------------- APPEON END ----------------------------

end event

type cb_save from picturebutton within u_cst_todolist
integer x = 827
integer y = 1472
integer width = 393
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "&Save"
boolean originalsize = true
vtextalign vtextalign = vcenter!
string powertiptext = "Save"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.04.2007 By: Davis

Long ll_ctx_id, ll_ctx_action_item_id
Long ll_prac_id
Long ll_facility_id
Long ll_rec_id
Long ll_seq_no
Long ll_wf_id, ll_wf_step_id
String ls_module
String ls_rtn
Long ll_action_status
String ls_reference_value
Long ll_exp_credential_flag
Long ll_tvi
Long ll_row
TREEVIEWITEM ltv_item
str_action_item lstr_action[1]
n_cst_workflow_triggers    lnv_trigger
DateTime ldt_Null // Add by andy 12/17/2009 (V10.1 - TDL)
DateTime ldt_today //Added by Appeon long.zhang 12.26.2014 
//---------Begin Added by (Appeon)Eugene 06.05.2013 for V141 ISG-CLX--------
string ls_assigned_to
n_cst_notification lnv_notification
String ls_alm_table,ls_alm_column //Added By Ken.Guo 2011-05-05.
String ls_table_arr[],ls_column_arr[]
String ls_sql_old,ls_sql_new,ls_errtext //Added by Appeon long.zhang 12.26.2014
Long ll_ctx_arr[]
long ll_docid_arr[],ll_doc_id,ll_level_id1_arr[],ll_level_id1,ll_level_id2_arr[],ll_level_id2
//---------End Added ------------------------------------------------------
Long i, ll_tdl_id	, ll_tdli_id //(Appeon)Harry 03.14.2014 - V142 ISG-CLX
long ll_row_update,rtn //Added by Appeon long.zhang 12.26.2014 

// Check treeview item
If tv_results.visible Then //(Appeon)Harry 03.14.2014 - V142 ISG-CLX
	ll_tvi = tv_results.FindItem(CurrentTreeItem!, 0)
	If ll_tvi <= 0 Then Return
	
	tv_results.GetItem( ll_tvi, ltv_item)
	If ltv_item.Level <> 3 Then Return
//---------Begin Added by (Appeon)Harry 03.14.2014 for V142 ISG-CLX--------
Else
	//Added By Ken.Guo 01/17/2013
	If dw_result.GetRow() = 0 Then Return
	If Not dw_result.isexpanded( dw_result.GetRow(), 2) Then Return 
End If
//---------End Added ------------------------------------------------------

//IF messagebox('Modify Action Status', 'Are you sure you want to modify the action status?',question!,YesNo!,2) = 2 THEN
//	RETURN 1
//END IF

// Get Info of current action item
ls_module = dw_action_status.GetItemString(1, "module")
//---------Begin Modified by (Appeon)Harry 03.14.2014 for V142 ISG-CLX--------

//ll_row = Long( ltv_item.Data )  //(Appeon)Harry 12.05.2013 - V141 for BugH120201 of Reintegration Issues
ll_action_status = dw_action_status.GetItemNumber(1, "action_status")

If tv_results.Visible Then
	ll_row = Long( ltv_item.Data )
Else
	ll_row = dw_result.GetItemNumber(dw_result.GetRow(), 'tdl_ai_row')
End If
//---------End Modfiied ------------------------------------------------------

//---------Begin Added by (Appeon)Eugene 06.05.2013 for V141 ISG-CLX--------

//Pop-up prompt when action status change	- jervis 03.10.2009
if gb_workflow then
	lnv_trigger = create n_cst_workflow_triggers
	if ls_module = "03" then
		lstr_action[1].wf_id = dw_tdl_intellicontract_all.GetItemNumber(ll_row,"wf_id")
		lstr_action[1].wf_step_id = dw_tdl_intellicontract_all.GetItemNumber(ll_row,"wf_action_type_id")
		ls_assigned_to =  dw_tdl_intellicontract_all.getitemstring(ll_row,"ctx_action_items_action_user")  //jervis 01.13.2011
	elseif ls_module = "04" then
		lstr_action[1].wf_id = dw_document_all.GetItemNumber(ll_row,"wf_id")
		lstr_action[1].wf_step_id = dw_document_all.GetItemNumber(ll_row,"wf_action_type_id")
		ls_assigned_to =  dw_document_all.getitemstring(ll_row,"ctx_am_action_item_action_user")  //jervis 01.13.2011
		
	end if 
	if not isnull(lstr_action[1].wf_id) then
		lstr_action[1].wf_action_status_id =  ll_action_status
		lstr_action[1].as_assigned_to = ls_assigned_to		//jervis 01.13.2011
		if lnv_trigger.of_popup_prompt( lstr_action[1]) <> 1 then
			destroy lnv_trigger
			return 
		end if
	end if
end if
//---------End Added ------------------------------------------------------
// Add by andy 12/26/2009 (V10.1 - TDL)
If ls_module = "07" Then
	This.Enabled = False
	Return
End If

//---------Begin Commented by (Appeon)Harry  03.14.2014 for V142 ISG-CLX--------
//ll_action_status = dw_action_status.GetItemNumber(1, "action_status")
//ll_row = Long( ltv_item.Data )
//---------End Commented ------------------------------------------------------
Choose Case ls_module
	Case "01" // IntelliCred
		ll_prac_id = dw_tdl_intelliCred_all.GetItemNumber( ll_row, "prac_id" )
		ll_facility_id = dw_tdl_intelliCred_all.GetItemNumber( ll_row, "facility_id" )
		ll_rec_id = dw_tdl_intelliCred_all.GetItemNumber( ll_row, "rec_id" )
		ll_seq_no = dw_tdl_intelliCred_all.GetItemNumber( ll_row, "verif_info_seq_no" )
		ls_reference_value = dw_tdl_intelliCred_all.GetItemString( ll_row, "verif_info_reference_value" )
		ll_exp_credential_flag = dw_tdl_intelliCred_all.GetItemNumber( ll_row, "verif_info_exp_credential_flag" )
		
		If ls_reference_value <> 'Expiring Appointment Letter' Then
			ll_exp_credential_flag = 0
		End If
		
		gnv_appeondb.of_autocommit( )
		Update verif_info
			Set response_code = :ll_action_status
			, user_name = :gs_user_id
			, source = 'P'
			, date_recieved = getdate()
			, print_flag = 0
			, exp_credential_flag = :ll_exp_credential_flag
			Where prac_id = :ll_prac_id
			And facility_id = :ll_facility_id
			And rec_id = :ll_rec_id
			And seq_no = :ll_seq_no;
		Commit;
		
		// Trigger work flow
		If gb_workflow Then
			lstr_action[1].rec_id = ll_rec_id //dw_tdl_intelliCred_all.getItemnumber( ll_row, "rec_id" )
			lstr_action[1].prac_id = 	ll_prac_id				//dw_tdl_intelliCred_all.getItemnumber( ll_row, "prac_id" )
			lstr_action[1].facility_id = ll_facility_id		//dw_tdl_intelliCred_all.getItemnumber( ll_row, "facility_id" )
			lstr_action[1].wf_id = dw_tdl_intelliCred_all.GetItemNumber(ll_row,"wf_id")
			lstr_action[1].wf_action_status_id = ll_action_status //dw_tdl_intelliCred_all.GetItemNumber(ll_row,"action_status")
			lstr_action[1].wf_action_type_id = dw_tdl_intelliCred_all.GetItemNumber(ll_row,"action_type")
			lstr_action[1].status_changed_flag = False
			lstr_action[1].module = "01" //IntelliGred
			lstr_action[1].trigger_by = "008"		//Trigger By Action Item Changed
			lstr_action[1].screen_id = -10
			
			If lstr_action[1].wf_id > 0 And dw_tdl_intelliCred_all.GetItemString(ll_row,"wf_complete_flag") = "N" Then
				lstr_action[1].wf_step_id = dw_tdl_intelliCred_all.GetItemNumber(ll_row,"wf_action_type_id")
				lstr_action[1].notes = dw_tdl_intelliCred_all.GetItemString(ll_row,"verif_info_notes")
				lstr_action[1].status_changed_flag = True
				lstr_action[1].seq_no = dw_tdl_intelliCred_all.GetItemNumber( ll_row, "verif_info_seq_no" )
			End If
			
			//lnv_trigger = Create n_cst_workflow_triggers  //Commented by (Appeon)Harry 03.14.2014 - V142 ISG-CLX
			lnv_trigger.of_status_changed( lstr_action[1] )
			
			//Create Work Flow By Action Item Changed
			lnv_trigger.of_workflow_triggers(lstr_action)
		End If
	Case "02" // IntelliApp
		ll_rec_id = dw_tdl_intelliApp_all.GetItemNumber( ll_row, "rec_id" )
		
		gnv_appeondb.of_autocommit( )
		
		//------------------- APPEON BEGIN -------------------
		//<$>added:long.zhang 12.26.2014
		//<$>reason:Bug 4379 created for Case# 00051492: Audit Trail Issue
		if not isvalid(inv_data_entry) then 	inv_data_entry = CREATE pfc_cst_nv_data_entry_functions 

		If not isvalid(ids_net_dev_action_items) then
			ids_net_dev_action_items = Create n_cst_datastore
			ids_net_dev_action_items.DataObject = "d_appeon_net_dev_action_items_save"
			ids_net_dev_action_items.SetTransObject( sqlca)
		End if
		/*
		Update net_dev_action_items
			Set action_status = :ll_action_status
			, action_date = getdate()
			Where rec_id = :ll_rec_id;
		*/
		
		ls_sql_old = ids_net_dev_action_items.GetSqlSelect()
		ls_sql_new = ls_sql_old + ' WHERE rec_id = '+ string(ll_rec_id)
		
		//------------------- APPEON BEGIN -------------------
		//<$>added:long.zhang 04.21.2015
		//<$>reason:Use 'Modify' for ASA database	 (issue:Batch Add process completing action status.)
		//rtn = ids_net_dev_action_items.SetSqlSelect(ls_sql_new)		
		ls_rtn = ids_net_dev_action_items.modify('datawindow.table.select = "' +  ls_sql_new  + '"')
		If ls_rtn = '' Then
			rtn = ids_net_dev_action_items.Retrieve()
			//rtn = ids_net_dev_action_items.SetSqlSelect(ls_sql_old)	
			ids_net_dev_action_items.modify('datawindow.table.select = "' +  ls_sql_old  + '"')
		Else
			//MessageBox("Modify Error", ls_rtn )
			rtn = 0	
		End If
		//------------------- APPEON END -------------------
		
		ldt_today = DateTime( Today(), Now( ))
		
		For ll_row_update = 1 to rtn
			ids_net_dev_action_items.SetItem( ll_row_update, "action_status", ll_action_status)
			ids_net_dev_action_items.SetItem( ll_row_update, "action_date", ldt_today)
		Next
		
		inv_data_entry.of_field_audit( ids_net_dev_action_items,ls_errtext )
		
		rtn = ids_net_dev_action_items.update()
		//------------------- APPEON END -------------------
		
		Commit;
		
		// Trigger work flow
		If gb_workflow Then
			lstr_action[1].rec_id = ll_rec_id //dw_tdl_intelliApp_all.getItemnumber( ll_row, "rec_id" )
			lstr_action[1].prac_id = dw_tdl_intelliApp_all.GetItemNumber( ll_row, "prac_id" )
			lstr_action[1].facility_id = dw_tdl_intelliApp_all.GetItemNumber( ll_row, "facility_id" )
			lstr_action[1].wf_id = dw_tdl_intelliApp_all.GetItemNumber(ll_row,"wf_id")
			lstr_action[1].wf_action_status_id = ll_action_status //dw_tdl_intelliApp_all.GetItemNumber(ll_row,"action_status")
			lstr_action[1].wf_action_type_id = dw_tdl_intelliApp_all.GetItemNumber(ll_row,"action_type")
			lstr_action[1].module = "02" //IntelliApp
			lstr_action[1].trigger_by = "008"		//Trigger By Action Item Changed
			lstr_action[1].screen_id = -10
			If lstr_action[1].wf_id > 0 And dw_tdl_intelliApp_all.GetItemString(ll_row,"wf_complete_flag") = "N" Then
				lstr_action[1].wf_step_id = dw_tdl_intelliApp_all.GetItemNumber(ll_row,"wf_action_type_id")
				lstr_action[1].seq_no = dw_tdl_intelliApp_all.GetItemNumber( ll_row, "net_dev_action_items_seq_no" )
				lstr_action[1].notes = dw_tdl_intelliApp_all.GetItemString(ll_row,"net_dev_action_items_notes")
				lstr_action[1].status_changed_flag = True
			End If
			
			//lnv_trigger = Create n_cst_workflow_triggers   //Commented by (Appeon)Harry 03.14.2014 - V142 ISG-CLX
			lnv_trigger.of_status_changed( lstr_action[1] )
			
			//Create Work Flow By Action Item Changed
			lnv_trigger.of_workflow_triggers(lstr_action)
		End If
		
	Case "03" // IntelliContract
		ll_ctx_id = dw_tdl_intellicontract_all.GetItemNumber( ll_row, "ctx_id")
		ll_ctx_action_item_id = dw_tdl_intellicontract_all.GetItemNumber( ll_row, "ctx_action_items_ctx_action_item_id")
		
		gnv_appeondb.of_autocommit( )
		Update ctx_action_items
			Set action_status = :ll_action_status
			, action_date = getdate()
			Where ctx_id = :ll_ctx_id
			And ctx_action_item_id = :ll_ctx_action_item_id;
		Commit;
		
		// Trigger work flow
		If gb_workflow Then
			lstr_action[1].ctx_action_item_id = ll_ctx_action_item_id //dw_tdl_intellicontract_all.getItemnumber( ll_row, "ctx_action_items_ctx_action_item_id" )
			lstr_action[1].ctx_id = ll_ctx_id	//dw_tdl_intellicontract_all.getItemnumber( ll_row, "ctx_id" )
			lstr_action[1].wf_id = dw_tdl_intellicontract_all.GetItemNumber(ll_row,"wf_id")
			lstr_action[1].wf_action_status_id = ll_action_status //dw_tdl_intellicontract_all.GetItemNumber(ll_row,"action_status")
			lstr_action[1].wf_action_type_id = dw_tdl_intellicontract_all.GetItemNumber(ll_row,"action_type")
			lstr_action[1].status_changed_flag = False
			lstr_action[1].module = "03" //IntelliContract Tracking
			lstr_action[1].trigger_by = "008"		//Trigger By Action Item Changed
			lstr_action[1].screen_id = -10
			lstr_action[1].as_assigned_to = ls_assigned_to		//jervis 01.13.2011  //(Appeon)Harry 03.14.2014 - V142 ISG-CLX
			If lstr_action[1].wf_id > 0 And dw_tdl_intellicontract_all.GetItemString(ll_row,"wf_complete_flag") = "N" Then
				lstr_action[1].wf_step_id = dw_tdl_intellicontract_all.GetItemNumber(ll_row,"wf_action_type_id")
				lstr_action[1].notes = dw_tdl_intellicontract_all.GetItemString(ll_row,"ctx_action_items_notes")
				lstr_action[1].status_changed_flag = True
			End If
			
			//lnv_trigger = Create n_cst_workflow_triggers  //Commented by (Appeon)Harry 03.14.2014 - V142 ISG-CLX
			lnv_trigger.of_status_changed( lstr_action[1] )
			
			//Create Work Flow By Action Item Changed
			lnv_trigger.of_workflow_triggers(lstr_action)
			
			//---------Begin Added by (Appeon)Eugene 06.05.2013 for V141 ISG-CLX--------
			//Added By Ken.Guo 2011-05-05. Update Snooze Date.
			If Not isvalid(lnv_notification) Then lnv_notification = Create n_cst_notification 
			Select  alm_table, alm_column,level_id1,level_id2,doc_id 
			Into :ls_alm_table,:ls_alm_column,:ll_level_id1,:ll_level_id2, :ll_doc_id
			From ctx_action_items 
				Where  ctx_id = :ll_ctx_id And ctx_action_item_id = :ll_ctx_action_item_id;
			ll_ctx_arr[1] = ll_ctx_id
			ls_table_arr[1] = ls_alm_table
			ls_column_arr[1] = ls_alm_column
			ll_docid_arr[1] = ll_doc_id
			ll_level_id1_arr[1] = ll_level_id1
			ll_level_id2_arr[1] = ll_level_id2
			choose case lower(ls_alm_table)
				case 'ctx_basic_info','ctx_custom' 
					lnv_notification.of_update_ctx_notification( ll_ctx_arr[], ls_table_arr[], ls_column_arr[])
				case 'ctx_custom_multi_hdr','ctx_custom_multi_detail'
					lnv_notification.of_update_ctx_notification( ll_ctx_arr[], ls_table_arr[], ls_column_arr[],ll_docid_arr,ll_level_id1_arr,ll_level_id2_arr)	
			end choose
			gnv_data.of_retrieve( "ctx_ai_notification")
			If Not isvalid(lnv_notification) Then Destroy lnv_notification
			//---------End Added ------------------------------------------------------
		End If
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 03.26.2007 By: Machongmin
		//$<reason> Fix a defect.	
	Case "04"
		
//		Long ll_doc_id  //Commented by (Appeon)Eugene 06.10.2013 - V141 ISG-CLX
		Long ll_seq_id
		ll_doc_id = dw_document_all.GetItemNumber( ll_row, "doc_id")
		ll_seq_id = dw_document_all.GetItemNumber( ll_row, "seq_id")
		
		ll_ctx_id = dw_document_all.GetItemNumber(ll_row,"ctx_id") //Added By Ken.Guo 10/22/2012  //(Appeon)Harry 03.14.2014 - V142 ISG-CLX
		
		gnv_appeondb.of_autocommit( )
		Update ctx_am_action_item
			Set action_status = :ll_action_status
			, status_date = getdate()
			Where doc_id = :ll_doc_id
			And seq_id = :ll_seq_id;
		Commit;
		
		// Trigger work flow
		If gb_workflow Then
			lstr_action[1].ctx_id = dw_document_all.GetItemNumber(ll_row,"ctx_id")	//01.30.2008 By Jervis
			lstr_action[1].seq_no = ll_seq_id //dw_tdl_intellicontract_all.getItemnumber( ll_row, "ctx_action_items_ctx_action_item_id" )
			lstr_action[1].doc_id = ll_doc_id	//dw_tdl_intellicontract_all.getItemnumber( ll_row, "ctx_id" )
			lstr_action[1].wf_id = dw_document_all.GetItemNumber(ll_row,"wf_id")
			lstr_action[1].wf_action_status_id = ll_action_status //dw_tdl_intellicontract_all.GetItemNumber(ll_row,"action_status")
			lstr_action[1].wf_action_type_id = dw_document_all.GetItemNumber(ll_row,"action_type")
			lstr_action[1].status_changed_flag = False
			lstr_action[1].module = "04" //IntelliContract Document manager
			lstr_action[1].trigger_by = "008"		//Trigger By Action Item Changed
			lstr_action[1].screen_id = -10
			lstr_action[1].as_assigned_to = ls_assigned_to		//jervis 01.13.2011    //(Appeon)Harry 03.14.2014 - V142 ISG-CLX
			If lstr_action[1].wf_id > 0 And dw_document_all.GetItemString(ll_row,"wf_complete_flag") = "N" Then
				lstr_action[1].wf_step_id = dw_document_all.GetItemNumber(ll_row,"wf_action_type_id")
				lstr_action[1].notes = dw_document_all.GetItemString(ll_row,"notes")
				lstr_action[1].status_changed_flag = True
			End If
			
			//lnv_trigger = Create n_cst_workflow_triggers   //Commented by (Appeon)Harry 03.14.2014 - V142 ISG-CLX
			lnv_trigger.of_status_changed( lstr_action[1] )
			
			//Create Work Flow By Action Item Changed
			lnv_trigger.of_workflow_triggers(lstr_action)
		End If
		//---------------------------- APPEON END ----------------------------	
		
	// Add by andy 12/17/2009 (V10.1 - TDL)
	Case "06"
		ll_rec_id = dw_tdl_app_audit_all.GetItemNumber( ll_row, "pd_app_audit_record_id" )
		SetNull(ldt_Null)
		
		gnv_appeondb.of_autocommit( )
		Update pd_app_audit
			Set data_status = :ll_action_status
			, date_completed = Case When :ll_action_status IS NULL Then :ldt_Null Else getdate() End
			Where record_id = :ll_rec_id;
			
		Commit;
		
End Choose

If IsValid(lnv_trigger) Then Destroy lnv_trigger //05/08/2007 By Jervis

// Refresh
//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 05.08.2007 By: Frank.Gui
//$<reason> 
//dw_action_status.Hide()
//Parent.PostEvent("ue_retrieve_todolist")

TREEVIEWITEM   tv_parent
Long  ll_actionStatus,ll_Parent,ll_ParentRow
String  ls_Label

If tv_results.visible Then //(Appeon)Harry 03.14.2014 - V142 ISG-CLX
	ll_Parent = tv_results.FindItem( parenttreeitem!, ll_tvi)
	
	tv_results.GetItem(ll_Parent,tv_parent)
	ll_ParentRow = Long(tv_parent.Data)
//---------Begin Added by (Appeon)Harry 03.14.2014 for V142 ISG-CLX--------
Else
	ll_ParentRow = dw_result.GetItemNumber(dw_result.GetRow(), 'tdl_row')
End If
//---------End Added ------------------------------------------------------

// Modify by andy 12/17/2009 (V10.1 - TDL)
If ls_module <> "06" Then
	ll_actionStatus = dw_todoitem.GetItemNumber(ll_ParentRow,'action_status')
Else
	ll_actionStatus = dw_todoitem.GetItemNumber(ll_ParentRow,'audit_status')
End If

// Modify by andy 12/17/2009 (V10.1 - TDL)
// There are two bugs:
// 1. Status: original value -> original value, the row is deleted.
// 2. Status: Null -> Not Null, the row is not deleted.
// If ll_actionStatus > 0 Then
If (IsNull(ll_actionStatus) And Not IsNull(ll_action_status)) Or &
	(Not IsNUll(ll_actionStatus) And (ll_actionStatus <> ll_action_status Or IsNull(ll_action_status))) Then
	ls_Label = dw_todoitem.GetItemString(ll_ParentRow,'verbiage')
	
	Int  li_Pos,li_old_Number,li_PosBlank
	string ls_LabelPostfix,ls_LabelPrefix,ls_NewLabel, ls_current_label
	
	//---------Begin Added by (Appeon)Harry 03.14.2014 for V142 ISG-CLX--------
	if tv_results.visible Then
		ls_current_label = tv_parent.Label
	Else
		ls_current_label = dw_result.GetItemString(dw_result.GetRow(), 'tdli_name')
	End If
	//---------End Added ------------------------------------------------------

	li_Pos = PosA(ls_Label,'##')
	If li_Pos > 0 Then
		ls_LabelPostfix = MidA(ls_Label,li_Pos+2)
		ls_LabelPrefix = LeftA(ls_Label,li_pos -1)
		
		//---------Begin Modified by (Appeon)Harry 03.14.2014 for V142 ISG-CLX--------
		//li_PosBlank = PosA(tv_parent.Label,' ',li_Pos+1)
		li_PosBlank = PosA(ls_current_label,' ',li_Pos+1)
		//---------End Modfiied ------------------------------------------------------
		
		If li_PosBlank < 1 Then 
			li_PosBlank = li_Pos
			//---------Begin Modified by (Appeon)Harry 03.14.2014 for V142 ISG-CLX--------
			//DO WHILE isNumber(MidA(tv_parent.Label,li_PosBlank+1,1))
			DO WHILE isNumber(MidA(ls_current_label,li_PosBlank+1,1))
			//---------End Modfiied ------------------------------------------------------
				li_PosBlank++
			LOOP
		END IF
		
		//---------Begin Modified by (Appeon)Harry 03.14.2014 for V142 ISG-CLX--------
		//li_old_Number = Integer(MidA(tv_parent.Label,li_Pos,li_PosBlank - li_Pos + 1))
		
		//ls_NewLabel = ls_LabelPrefix+String(li_old_Number - 1)+ls_LabelPostfix//Mid(tv_parent.Label,li_PosBlank)
		
		//tv_parent.Label = ls_NewLabel
		//tv_results.SetItem(ll_Parent,tv_parent)
		
		li_old_Number = Integer(MidA(ls_current_label,li_Pos,li_PosBlank - li_Pos + 1))
		
		ls_NewLabel = ls_LabelPrefix+String(li_old_Number - 1)+ls_LabelPostfix//Mid(tv_parent.Label,li_PosBlank)
		
		If tv_results.visible Then
			tv_parent.Label = ls_NewLabel
			tv_results.SetItem(ll_Parent,tv_parent)
		Else
			dw_result.SetRedraw(False)
			ll_tdl_id = dw_result.GetItemNumber(dw_result.Getrow(), 'tdl_id' )
			ll_tdli_id = dw_result.GetItemNumber(dw_result.Getrow(), 'tdli_id' )
			For i = 1 To dw_result.rowcount()
				If dw_result.GetItemNumber(i, 'tdl_id' ) = ll_tdl_id and dw_result.GetItemNumber(i, 'tdli_id' ) = ll_tdli_id Then
					dw_result.SetItem(i,'tdli_name',ls_NewLabel)
					dw_result.SetItem(i,'expanded1',1)
					dw_result.SetItem(i,'expanded2',1)
					If i = dw_result.Getrow() Then
						dw_result.SetItem(i,'child_count',0)
						dw_result.SetItem(i,'tv_icon','')
						dw_result.SetItem(i,'tdl_row',0)
						dw_result.SetItem(i,'tdl_ai_row',0)
						dw_result.SetItem(i,'display_field1','0 To Do Items')
						dw_result.SetItem(i,'display_field2','')
						dw_result.SetItem(i,'display_field3','')
						dw_result.SetItem(i,'display_field4','')
						dw_result.SetItem(i,'display_field5','')
						dw_result.SetItem(i,'display_field6','')
						dw_result.SetItem(i,'display_field7','')
						dw_result.SetItem(i,'display_field8','')
						dw_result.SetItem(i,'display_field9','')
						dw_result.SetItem(i,'display_field10','')
						dw_result.SetItem(i,'display_field11','')
						dw_result.SetItem(i,'display_field12','')
					End If
				End If
			Next
		End If
		//---------End Modfiied ------------------------------------------------------
	End If
	dw_action_status.Hide()
	//---------Begin Added by (Appeon)Harry 03.14.2014 for V142 ISG-CLX--------
	/*
	tv_results.DeleteItem(ll_tvi)
	ll_tvi = tv_results.FindItem(CurrentTreeItem!, 0)
	Parent.of_item_changed( ll_tvi)
	tv_results.post setfocus()
	*/
	dw_facility.SetItem(1, 'todo_cnt', dw_facility.GetItemNumber(1, 'todo_cnt') - 1)
	If tv_results.visible Then
		tv_results.DeleteItem(ll_tvi)
		ll_tvi = tv_results.FindItem(CurrentTreeItem!, 0)
	Else
		If li_old_Number > 1 Then
			dw_result.DeleteRow(dw_result.Getrow())
			//dw_result.groupcalc( )
			dw_result.Event ue_expand_histroy()
		End If
		ll_tvi = dw_result.GetRow()		
	End If
	Parent.of_item_changed( ll_tvi)
	If tv_results.visible Then
		tv_results.post setfocus()
	Else
		dw_result.Post SetRedraw(True)
		dw_result.Post SetFocus()	
	End If
	//---------End Added ------------------------------------------------------
ELSE
	n_ds  ldw
	
	ls_module = dw_todoitem.GetitemString(ll_ParentRow, "tdl_basic_info_module")

	CHOOSE CASE ls_module
		CASE "01"		// IntelliCred
			ldw = dw_tdl_intelliCred_all
		CASE "02"		// IntelliApp
			ldw = dw_tdl_intelliapp_all
		CASE "03"		// IntelliContract
			ldw = dw_tdl_intellicontract_all
		case "04"
			ldw = dw_document_all
		// Add by andy 12/17/2009 (V10.1 - TDL)
		case "06"
			ldw = dw_tdl_app_audit_all
	END CHOOSE

	// Modify by andy 12/17/2009 (V10.1 - TDL)
	If ls_module <> "06" Then
		ldw.SetItem(ll_row, "action_status",ll_action_status)
	Else
		ldw.SetItem(ll_row, "pd_app_audit_data_status",ll_action_status)
	End If
End If
//---------------------------- APPEON END ----------------------------


This.Enabled = False
//---------------------------- APPEON END ----------------------------

//---------Begin Added by (Appeon)Eugene 06.05.2013 for V141 ISG-CLX--------
//Added By Ken.Guo 10/22/2012. Refresh AI Data and WF Status Data
window lw_parent
u_tabpg_dm_manager luo_docmanager
If isvalid(gw_contract) Then
	If gw_contract.tab_contract_details.tabpage_search.il_ctx_id = ll_ctx_id Then
		If ls_module = '03' Then
			//Refresh AI Data
			If gw_contract.tab_contract_details.ib_select10 Then
				gw_contract.tab_contract_details.ib_select10 = False
			End If
			//Refresh CTX WF Status Windows Data
			If IsValid(w_ctxwfstepstatus) then 
				close(w_ctxwfstepstatus)	
				open(w_ctxwfstepstatus)
			Else
				open(w_ctxwfstepstatus)
			End If			
		ElseIf ls_module = '04' Then
			If gw_contract.tab_contract_details.ib_select9 Then
				//Refresh Document AI Data
				luo_docmanager = gw_contract.tab_contract_details.tabpage_images
				If luo_docmanager.tab_1.tabpage_data.of_get_doc_id() = ll_doc_id Then
					luo_docmanager.tab_1.tabpage_action. event ue_doc_changed(luo_docmanager.tab_1.tabpage_action.of_get_doc_id(),luo_docmanager.tab_1.tabpage_data.of_get_doc_id(),&
												luo_docmanager.tab_1.tabpage_action.of_get_revision(),luo_docmanager.tab_1.tabpage_data.of_get_revision())		
				End If
				//Refresh Doc WF Status Windows Data
				If IsValid(w_DocWFStepStatus) then 
					close(w_DocWFStepStatus)	
					open(w_DocWFStepStatus)
				Else
					open(w_DocWFStepStatus)
				End If				
			End If		
			
			//Refresh CTX WF Status Windows Data
			If IsValid(w_ctxwfstepstatus) then 
				close(w_ctxwfstepstatus)	
				open(w_ctxwfstepstatus)
			Else
				open(w_ctxwfstepstatus)
			End If			
			
			//Set WF Status Window to Back
			If isvalid(w_ctxwfstepstatus) or isvalid(w_DocWFStepStatus) Then
				Parent.of_getparentwindow(lw_parent) 
				If isvalid(lw_parent) Then
					lw_parent.bringtotop = True
				End If
			End If
				
		End If
	End If
End If
//---------End Added ------------------------------------------------------
end event

type dw_facility from u_dw within u_cst_todolist
integer x = 18
integer width = 2766
integer height = 308
integer taborder = 10
string dataobject = "d_tdl_facility_user"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.28.2006 By: Davis
//$<reason> Implement dashbord.

this.of_setupdateable( false)
this.of_SetDropDownCalendar(TRUE) //(Appeon)Eugene 06.05.2013 - V141 ISG-CLX
//---------------------------- APPEON END ----------------------------

end event

event itemchanged;call super::itemchanged;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.29.2006 By: Davis
//$<reason> Filter faciltiy for TODoList.
Datetime ldt_due_date
IF This.GetColumnName() = "facility_id" THEN	

	il_facility_id = Integer( data )
	parent.PostEvent("ue_retrieve_todolist")

ELSEIF This.GetColumnName() = "user_id" THEN
	
	DataWindowChild dwchild
	String ls_user_id

	ls_user_id = String( data )
	//---------Begin Modified by (Appeon)Harry 01.09.2014 for V141 Bug # 3816--------
	//if ls_user_id = "-All-" then ls_user_id = gs_user_id  //Start Code Change ----03.18.2011 #V11 maha  
	if Upper(ls_user_id) = "-ALL-" then ls_user_id = "%" 
	//---------End Modfiied ------------------------------------------------------


	dw_facility.GetChild( "facility_id", dwchild )
	dwchild.SetTransObject( SQLCA )
	
	gnv_appeondb.of_startqueue( )

	//---------Begin Modified by (Appeon)Harry 03.20.2014 for bug 3983--------
	//dwchild.Retrieve( ls_user_id )
	if Upper(ls_user_id) =  "%" then
		dwchild.Retrieve( gs_user_id )
		
		//Remember the user_id which is used to retrieve Facilities, Added by Appeon long.zhang 04.13.2017 (Mednax- ODBC connect message and Data retrieval Case#70296 Bug_id#5602)
		is_user_id_facility_retrieved = gs_user_id
	else
		dwchild.Retrieve( ls_user_id )
		
		//Remember the user_id which is used to retrieve Facilities, Added by Appeon long.zhang 04.13.2017 (Mednax- ODBC connect message and Data retrieval Case#70296 Bug_id#5602)
		is_user_id_facility_retrieved = ls_user_id
	end if
	//---------End Modfiied ------------------------------------------------------
	
	dw_todoitem.Retrieve( ls_user_id, is_module )
	
	gnv_appeondb.of_commitqueue( )

	dwchild.InsertRow(1)
	dwchild.SetItem( 1, "facility_name", "All" )
	dwchild.SetItem( 1, "facility_id", 0 )

	il_facility_id = 0
	dw_facility.SetItem( 1, "facility_id", 0 )
	
	parent.PostEvent("ue_retrieve_todolist")
	//---------Begin Added by (Appeon)Eugene 06.05.2013 for V141 ISG-CLX--------
ELSEIF This.GetColumnName() = "due_date" THEN 	
		If isdate(data) Then
			ldt_due_date = DateTime(date(data), Time(00:00:00.000))
			of_set_where_due_date(ldt_due_date)
			Parent.PostEvent("ue_retrieve_todolist")
		ElseIf Isnull(data) or data = '' or data = '1900-01-01' Then
			SetNull(ldt_due_date)
			of_set_where_due_date(ldt_due_date)
			Parent.PostEvent("ue_retrieve_todolist")
		End If
	//---------End Added ------------------------------------------------------
END IF

//---------------------------- APPEON END ----------------------------

end event

event buttonclicked;call super::buttonclicked;//////////////////////////////////////////////////////////////////////
// $<event>dw_facility::buttonclicked()
// $<arguments>
//		value	long    	row             		
//		value	long    	actionreturncode		
//		value	dwobject	dwo             		
// $<returns> long
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 02.07.2009 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Datetime ldt_null,ldt_due_date
Setnull(ldt_null)
If dwo.name = 'b_clear' Then
	//If Isnull( This.GetItemDate(1,'due_date')) Then Return 1//(Appeon)Toney 09.05.2013 - V141 ISG-CLX Fix Reintegration BugH082802
	This.SetItem(1,'due_date',ldt_null)
	This.SetItem(1,'due_date',ldt_null) //Do again. Workaround APB Bug.
	This.SetColumn('due_date') // Workaround APB Bug. To set focus.		
	This.Trigger Event ItemChanged(1,dwo,'')
End If
end event

event clicked;call super::clicked;//---------Begin Added by (Appeon)Eugene 06.29.2013 for V141 ISG-CLX--------
If dwo.name = 't_read_email' Then
	int	li_opentype,li_tabpage
	str_email_parm lstr_email_parm
	Long ll_ctx_id
	
	if w_mdi.of_security_access(6931) = 0 then //(Appeon)Harry 11.03.2015 - for Bug_id#4822
		messagebox('Prompt','No access privilege to read.')
		return 
	end if
	
	lstr_email_parm.ai_folder_type = 2 //Inbox
	lstr_email_parm.ai_from_type = 0 
	
	If isvalid(w_email_folder) Then
		w_email_folder.BringtoTop = True
		If w_email_folder.WindowState = Minimized! Then
			w_email_folder.WindowState = Normal!
		End If
		w_email_folder.SetFocus()
		If w_email_folder.rb_all.checked = False Then
			w_email_folder.rb_all.checked = True
			w_email_folder.rb_all.Event Clicked()
		End If
		If w_email_folder.tv_mail.FindItem(CurrentTreeItem!, 0) <> 2 Then
			w_email_folder.tv_mail.SelectItem(2)
		End If
	Else
		OpenSheetwithparm(w_email_folder,lstr_email_parm, w_mdi, 4, Original!) 	
		//---------Begin Added by (Appeon)Harry 09.10.2014 for BugH070904--------
		 if Upper(AppeonGetClienttype()) = 'WEB'  and iw_parent.classname( ) = 'w_todolist_contract' Then
			w_email_folder.ib_tdl_ctx = true 
		 end if 
		//---------End Added ------------------------------------------------------
	End If
	
End If
//---------End Added ------------------------------------------------------------------

end event

event rbuttondown;call super::rbuttondown;//////////////////////////////////////////////////////////////////////
// $<event>dw_facility::rbuttondown()
// $<arguments>
//		integer 	xpos		
//		integer 	ypos		
//		long    	row 		
//		dwobject	dwo 		
// $<returns> long
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.21.2009 by Ken.Guo
//////////////////////////////////////////////////////////////////////

//Override
Datetime ldt_null,ldt_due_date
Setnull(ldt_null)
If dwo.name = 'due_date' Then
	If Isnull( This.GetItemDate(1,'due_date')) Then Return 1
	If Messagebox('Reset', "Would you like to set this Date to null?",Question!,YesNo!) = 1 Then
		This.SetItem(1,'due_date',ldt_null)
		This.SetItem(1,'due_date',ldt_null) //Do again. Workaround APB Bug.
		This.SetColumn('due_date') // Workaround APB Bug. To set focus.		
		This.Trigger Event ItemChanged(1,dwo,'')
	End If
End If
end event

type st_time from statictext within u_cst_todolist
boolean visible = false
integer x = 1714
integer width = 681
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_action_status from u_dw within u_cst_todolist
boolean visible = false
integer x = 23
integer y = 1416
integer width = 626
integer height = 160
integer taborder = 30
string dataobject = "d_tdl_action_status_changes"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.04.2007 By: Davis

this.of_setupdateable( false)

dw_action_status.GetChild("action_status", idwc_action_status ) 
idwc_action_status.Insertrow(0)
dw_action_status.Insertrow(0)

//---------------------------- APPEON END ----------------------------

end event

event itemchanged;call super::itemchanged;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.04.2007 By: Davis

cb_save.Enabled = TRUE

//---------------------------- APPEON END ----------------------------

end event

type tv_results from u_tvs within u_cst_todolist
boolean visible = false
integer x = 18
integer y = 304
integer width = 2766
integer height = 1104
integer taborder = 20
fontcharset fontcharset = ansi!
long textcolor = 0
long backcolor = 16777215
boolean linesatroot = true
boolean hideselection = false
string picturename[] = {"Custom039!","Custom050!","Custom039!","Custom050!","ScriptNo!","ScriptYes!","Exclamation!"}
boolean ib_rmbmenu = false
end type

event doubleclicked;call super::doubleclicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 12.01.2006 By: Davis
//$<reason> Implement Dashboard.

ib_doubleclick = TRUE

cb_go.PostEvent(Clicked!)

//---------------------------- APPEON END ----------------------------

end event

event itemcollapsing;call super::itemcollapsing;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.29.2006 By: Davis
//$<reason> Implement Dashboard.

IF ib_doubleclick THEN RETURN 1

//---------------------------- APPEON END ----------------------------

end event

event itemexpanding;call super::itemexpanding;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.29.2006 By: Davis
//$<reason> Implement Dashboard.

IF ib_doubleclick THEN RETURN 1
//messagebox("","tdl fill") //Comment by Appeon long.zhang 12.12.2015 (BugL112703)
Parent.of_fill_tdl_data( handle )

//---------------------------- APPEON END ----------------------------

end event

event selectionchanged;call super::selectionchanged;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.04.2007 By: Davis
//$<reason> Implement Dashboard.

cb_save.enabled = FALSE

Parent.of_item_changed( newhandle )

//---------------------------- APPEON END ----------------------------

end event

