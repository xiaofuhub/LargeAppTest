$PBExportHeader$n_cst_tdl_function.sru
$PBExportComments$Public function of TDL
forward
global type n_cst_tdl_function from nonvisualobject
end type
end forward

global type n_cst_tdl_function from nonvisualobject autoinstantiate
end type

type variables
DataStore ids_tdl_user_access //alfee 12.06.2013

end variables

forward prototypes
public function integer of_get_module (ref string as_module[])
public function integer of_filter_module (datawindow adw)
public function string of_gen_where_due_date (string as_module_id, datetime adt_where_due_date)
public function string of_gen_tdl_sql (string as_user_id, datastore ads_todoitem, ref string as_where[], ref string as_filter[], datetime adt_where_due_date, long al_tdl_right, string as_other_user, long al_facility_id)
public function string of_gen_tdl_sql (string as_user_id, datastore ads_todoitem, ref string as_where[], ref string as_filter[], datetime adt_where_due_date, long al_tdl_right, string as_other_user)
public function string of_get_tdl_users (long al_tdl_id)
end prototypes

public function integer of_get_module (ref string as_module[]);//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-12-18 By: Allen
//$<reason> Filter mudule according to setup
Integer i, li_set_9, li_set_cont
integer li_iapp //maha043008
String ls_Filter
String ls_null[]

li_set_9 = of_get_app_setting("set_9","I")
li_set_cont = of_get_app_setting("set_cont","I")
li_iapp = of_get_app_setting("set_iapps","I")

as_module = ls_null

//Modules:
//01 = Verifications
//02 = App Actions
//03 = Contracts
//04 = Contracts Documents
//05 = none
//06 = Checklist
//07 = Notifications
//08 = Recruitment
//09 = WebView tracking
//10 = Recruit Tasks

//Start Code Change ----04.28.2009 #V92 maha - changed functionality so that Cred and App always have mods 1,2,5

CHOOSE CASE li_set_9
	CASE 0, 1, 3, 5		//IntelliCred //app //credapp.SK 04.28.2009 #V92 maha  //09.01.2010 #V10 maha
		as_module[1] = "01"									//IntelliCred
//Start Code Change ----04.30.2008 #V8 maha - bug correction: most IntelliCred/App systems are set up
//as Intellicred with applcation mapping module (not with IntelliCred/IntelliApp setting ) so it needs to work as well
		if li_iapp = 1 then
			as_module[2] = "02"	
		end if
		IF li_set_cont = 1 THEN 
			as_module[upperbound(as_module) + 1] = "03"	//IntelliContract
			as_module[upperbound(as_module) + 1] = "04"	//05/14/2007 By Jervis
		end if
		
		//-------------appeon begin----------------------
		//<$>added:long.zhang 09.18.2013
		//<$>reason:V14.1 Recruitment Functionality
		//if li_set_9 = 0 then
		if  of_get_app_setting("set_recruit","I") <> 0 then//long.zhang 11.18.2013 BugL111503
				as_module[upperbound(as_module) + 1] = "08"
		end if
		//-------------appeon End------------------------
		
	as_module[8] = "09"//Added by Appeon long.zhang 03.17.2014 (V14.2 To Do List for PracView)
	as_module[9] = "10" //(Appeon)Stephen 05.21.2015 - V15.1-Additional TDL type of Recruitment Task
	 
//End Code Change---04.30.2008
//	CASE 1		//IntelliApp
//		as_module[1] = "02"									//IntelliApp
//		IF li_set_cont = 1 THEN 
//			as_module[2] = "03"	//IntelliContract
//			as_module[3] = "04"	//05/14/2007 By Jervis
//		end if
	CASE 2		//IntelliCred SE
//	CASE 3		//IntelliCred/IntelliApp
//		as_module[1] = "01"									//IntelliCred
//		as_module[2] = "02"									//IntelliApp
//		//--------------------------- APPEON BEGIN ---------------------------
//		//$<modify> 03.26.2007 By: Machongmin
//		//$<reason> Fix a defect.
//		/*
//		IF li_set_cont = 1 THEN as_module[3] = "03"	
//		*/
//		IF li_set_cont = 1 THEN 
//			as_module[3] = "03"	
//			as_module[4] = "04"	
//		END IF
//		//---------------------------- APPEON END ----------------------------
	CASE 4		//IntelliContract
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 03.26.2007 By: Machongmin
		//$<reason> Fix a defect.
		/*
		as_module[1] = "03"									//IntelliContract
		*/
		as_module[1] = "03"									
		as_module[2] = "04"									
		//as_module[3] = "03"									//IntelliContract
		//as_module[4] = "04"
		//---------------------------- APPEON END ----------------------------
END CHOOSE

//Start Code Change ----04.28.2009 #V92 maha - if not contract version add mod 5
if li_set_9 <> 4 then
	// Del by andy 01/08/2010 (V10.1 - TDL) No use.
	// as_module[5] = "05"	
	// Add by andy 12/05/2009 (V10.1 - TDL)
	as_module[6] = "06"
	if not gb_sk_ver then  //Start Code Change ----09.01.2010 #V10 maha - exception for SK
		as_module[7] = "07"	
	end if
end if
//End Code Change---04.28.2009

Return 0
//---------------------------- APPEON END ----------------------------

end function

public function integer of_filter_module (datawindow adw);//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-12-18 By: Allen
//$<reason> Filter mudule according to setup
String ls_Filter
String ls_module[]
Integer i

of_get_module(ls_module)

FOR i = 1 To UpperBound( ls_module )
	IF LenA(ls_module[i]) > 0 THEN
		ls_Filter += "'" + ls_module[i] + "',"
	END IF
NEXT

ls_Filter = LeftA(ls_Filter, LenA(ls_Filter) - 1)
IF LenA(ls_Filter) = 0 THEN Return -1

//Filter dw_tdl_role in pfc_cst_u_tdl_role_painter: list type dw.
IF adw.ClassName() = "dw_tdl_role" THEN
	adw.SetFilter("module in (" + ls_Filter + ")")
	adw.Filter()
ELSE
	//Filter dwc_child
	DatawindowChild ldwc_child
	ldwc_child.SetTransObject(Sqlca)
	IF adw.GetChild("module", ldwc_child) = -1 THEN Return -2
	ldwc_child.SetFilter("module_id in (" + ls_Filter + ")")
	ldwc_child.Filter()
END IF



Return 0
//---------------------------- APPEON END ----------------------------

end function

public function string of_gen_where_due_date (string as_module_id, datetime adt_where_due_date);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_tdl_function::of_gen_where_due_date()
// $<arguments>
//		value	string  	as_module_id		
//		value	datetime	adt_dut_date		
// $<returns> integer
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 02.25.2009 by Ken.Guo
//////////////////////////////////////////////////////////////////////

If isnull(adt_where_due_date) Then Return ''
Choose Case as_module_id
	Case '01'
		Return ''
	Case '02'
		Return ''
	Case '03'
		Return " And ctx_action_items.due_date = Convert(datetime,'"+String(adt_where_due_date,'yyyy-mm-dd')+"',126) "
	Case '04'
		Return " And ctx_am_action_item.due_date = Convert(datetime,'"+String(adt_where_due_date,'yyyy-mm-dd')+"',126) "
End Choose

Return ''
end function

public function string of_gen_tdl_sql (string as_user_id, datastore ads_todoitem, ref string as_where[], ref string as_filter[], datetime adt_where_due_date, long al_tdl_right, string as_other_user, long al_facility_id);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_tdl_function::of_gen_tdl_sql()
// $<arguments>
//		value    	string   	as_user_id        		
//		value    	datastore	ads_todoitem      		
//		reference	string   	as_where[]        		
//		reference	string   	as_filter[]       		
//		value    	datetime 	adt_where_due_date		
//		value    	long     	al_tdl_right      		
//		value    	string   	as_other_user     	
//		value		long		al_facility_id		 
// $<returns> string
// $<description> Move from u_cst_todolist::ue_retrieve_todolist()
// $<description> 
//////////////////////////////////////////////////////////////////////
// $<add> 02.25.2009 by Ken.Guo
 //(Appeon)Eugene 06.13.2013 - V141 ISG-CLX
//////////////////////////////////////////////////////////////////////


string ls_ext_sql,ls_sql
long ll_row
Long ll_tdl_id,ll_tdli_id,ll_Action_Type
Long ll_Action_Status,ll_Print_Flag,ll_Due_Date,ll_UserType
String ls_tdl_name,ls_tdl_module,ls_Max_Sends_Flag,ls_AssignUser,ls_AmAssignUser
String ls_sql_where,ls_sql_filter,ls_colname
Boolean lb_exists_term
String ls_module[]
Boolean lb_all_user = False

LONG ll_audit_status, ll_audit_received_date //andy 12/09/2009 (V10.1 - TDL)
n_cst_string lnvo_string //andy 12/18/2009 (V10.1 - TDL)
String ls_user_id2 //andy 12/18/2009 (V10.1 - TDL) Use for saving gs_user_id
string ls_status = "(1,4)"  //maha 07.19.2011 - for potential customization


//If as_user_id = '-ALL-' Then //Commented by (Appeon)Harry 01.09.2014
If Upper(as_user_id) = "-ALL-" Then  //(Appeon)Harry 01.09.2014 - V141 for Bug # 3816
	lb_all_user = True
End If

// Construct SQL according to term of to do item.
FOR ll_row = 1 TO ads_todoitem.Rowcount()

	ll_tdl_id = ads_todoitem.GetitemNumber( ll_row, "tdl_id" )
	ll_tdli_id = ads_todoitem.GetitemNumber( ll_row, "tdli_id" )
	ls_tdl_name = ads_todoitem.GetitemString( ll_row, "tdl_basic_info_tdl_name" )
	ls_tdl_module = ads_todoitem.GetitemString( ll_row, "tdl_basic_info_module" )
	
	ll_Action_Type = ads_todoitem.GetitemNumber( ll_row, "Action_Type" )
	ll_Action_Status = ads_todoitem.GetitemNumber( ll_row, "Action_Status" )
	ll_Print_Flag = ads_todoitem.GetitemNumber( ll_row, "Print_Flag" )
	ll_Due_Date = ads_todoitem.GetitemNumber( ll_row, "Due_Date" )
	ls_Max_Sends_Flag = ads_todoitem.GetitemString( ll_row, "Max_Sends_Flag" )

	// Add by andy 12/09/2009 (V10.1 - TDL)
	If ls_tdl_module = "06" Then
		ll_audit_status = ads_todoitem.GetitemNumber( ll_row, "audit_status" )
		ll_audit_received_date = ads_todoitem.GetitemNumber( ll_row, "audit_received_date" )
	End If
	
	ls_sql_where = ""
	ls_sql_filter = ""
	lb_exists_term = FALSE
If ls_tdl_module = "07" Then debugbreak()
	// Facility - Modify by andy 12/09/2009 (V10.1 - TDL)
	// IF (ls_tdl_module = "01" OR ls_tdl_module = "02") AND al_facility_id > 0 THEN
	IF (ls_tdl_module = "01" OR ls_tdl_module = "02" OR ls_tdl_module = "06" OR ls_tdl_module = "07") AND al_facility_id > 0 THEN
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
		END CHOOSE

		IF lb_exists_term THEN
			ls_sql_where += " AND "
			ls_sql_filter += " AND "
		END IF

		ls_sql_where += ls_colname + " = " + String(al_facility_id)
		
		//Begin Modified by long.zhang 08.31.2011 #BugL082903
		//ls_sql_filter += "facility_id = " + String(al_facility_id)
		IF ls_tdl_module = "06" THEN
			ls_sql_filter += "pd_app_audit_facility_id = " + String(al_facility_id)
		ELSEIF 	ls_tdl_module = "07" THEN
			ls_sql_filter += "alert_records_facility_id = " + String(al_facility_id)
		ELSEIF ls_tdl_module = "01" THEN 
			ls_sql_filter += "pd_affil_stat_parent_facility_id = " + String(al_facility_id) //Bug 3112 - alfee 05.25.2012	
		ELSE
			ls_sql_filter += "facility_id = " + String(al_facility_id)
		END IF
		//End Modified by long.zhang 08.31.2011
		
		lb_exists_term = TRUE
	END IF
	
	IF Not (ls_tdl_module = "06" OR ls_tdl_module = "07") Then // Add by andy 12/09/2009 (V10.1 - TDL)
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
			END CHOOSE
	
			IF lb_exists_term THEN
				ls_sql_where += " AND "
				ls_sql_filter += " AND "
			END IF
			//---------Begin Modified by Nova 03.26.2010------------------------
			//ls_sql_where += ls_colname + " = " + String( ll_Action_Type )
			//ls_sql_filter += "action_type = " + String( ll_Action_Type )
			IF ll_Action_Type = -1    THEN // Action Type Is Null
				ls_sql_where += ls_colname + " is null "
				//ls_sql_filter += " isnull(ll_Action_Type) "
				ls_sql_filter += " isnull(action_type) "	//long.zhang 08.29.2011 - #Bugl082003  
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
			END CHOOSE
	
			IF lb_exists_term THEN
				ls_sql_where += " AND "
				ls_sql_filter += " AND "
			END IF

			//IF ll_Action_Status = -1  or isnull(ll_action_status) THEN // Action Status Is Null
			IF ll_Action_Status = -1  THEN // Nova 03.26.2010
				ls_sql_where += ls_colname + " is null "
				ls_sql_filter += " isnull(action_status) "
			ELSE
				ls_sql_where += ls_colname + " = " + String( ll_Action_Status )
				ls_sql_filter += "action_status = " + String( ll_Action_Status )
			END IF
	
			lb_exists_term = TRUE
		END IF
	
		// Term of Print Flag
		IF ll_Print_Flag >= 0 THEN
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
		IF ls_Max_Sends_Flag = '1' THEN
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
	
	// Set where condition to array
	as_where[ll_row] = ls_sql_where
	as_filter[ll_row] = ls_sql_filter
	
	// Construct SQL for dynamic sql
	IF LenA(ls_sql) > 0 THEN ls_sql += "~r~n UNION ~r~n"
//	debugbreak()
	CHOOSE CASE ls_tdl_module
		CASE "01"		//IntelliCred
			 choose case al_tdl_right
				case 0
					//ls_ext_sql = " and (verif_info.priority_user = '" + gs_user_id + "')"
					ls_ext_sql = " and (verif_info.priority_user in ('" + ls_user_id2 + "','Public'))" //andy 12/18/2009 (V10.1 - TDL) Replace gs_user_id with ls_user_id2.
				case 1
					as_other_user = trim(as_other_user)
					if LenA(as_other_user) > 0 then
						ls_ext_sql = " and (verif_info.priority_user = '" + ls_user_id2 + "' or verif_info.priority_user = '" +  as_other_user + "')" 	// andy 12/18/2009 (V10.1 - TDL) Replace gs_user_id with ls_user_id2.
					else
						ls_ext_sql = " and (verif_info.priority_user = '" + ls_user_id2 + "')" //andy 12/18/2009 (V10.1 - TDL) Replace gs_user_id with ls_user_id2.
					end if
				case 2			
					//Start Code Change ----03.16.2011 #V11 maha - added ability to include all in the list
					//if as_user_id = "-All-" then //Commented by (Appeon)Harry 01.09.2014
					if Upper(as_user_id) = "-ALL-" then  //(Appeon)Harry 01.09.2014 - V141 for Bug # 3816
						ls_ext_sql = ""
					else
						ls_ext_sql = " and (verif_info.priority_user in ('" + as_user_id + "','Public'))"//Michael 09.14.2011: Replace ls_user_id2 with as_user_id
					end if
					//End Code Change ----03.16.2011 
			end choose
						
			ls_sql += "SELECT tdl_id = " + String(ll_tdl_id) + ", tdli_id = " + String(ll_tdli_id) +&
			", cnt = count(1) FROM verif_info &
			 JOIN pd_basic ON verif_info.prac_id = pd_basic.prac_id &
			 JOIN pd_affil_stat ON verif_info.prac_id = pd_affil_stat.prac_id &
			 AND verif_info.facility_id = pd_affil_stat.verifying_facility &
			 AND verif_info.active_status = 1 &
			 AND pd_affil_stat.active_status IN " + ls_status + ls_ext_sql
			// AND pd_affil_stat.active_status IN (1,4)" + ls_ext_sql  //Start Code Change ----07.19.2011 #V11 maha 
			
			if LenA(trim(ls_ext_sql)) > 0 then
				if LenA(trim(as_where[ll_row])) > 0 then
					as_where[ll_row] += ls_ext_sql
				else
					as_where[ll_row] = MidA(ls_ext_sql,5,LenA(ls_ext_sql) - 4)
				end if
				if LenA(trim(ls_sql_where)) > 0 then
					ls_sql_where += ls_ext_sql
				else
					ls_sql_where = MidA(ls_ext_sql,5,LenA(ls_ext_sql) - 4)
				end if
			end if

			 //---------------------------- APPEON END ----------------------------
		CASE "02"		//IntelliApp
			 choose case al_tdl_right
				case 0
					//ls_ext_sql = " and (net_dev_action_items.action_user = '" + gs_user_id + "')"
					ls_ext_sql = " and (net_dev_action_items.action_user in ('" + ls_user_id2 + "','Public'))" //andy 12/18/2009 (V10.1 - TDL) Replace gs_user_id with ls_user_id2.
				case 1
					as_other_user = trim(as_other_user)
					if LenA(as_other_user) > 0 then
						ls_ext_sql = " and (net_dev_action_items.action_user = '" + ls_user_id2 + "' or net_dev_action_items.action_user = '" +  as_other_user + "')" //andy 12/18/2009 (V10.1 - TDL) Replace gs_user_id with ls_user_id2.
					else
						ls_ext_sql = " and (net_dev_action_items.action_user = '" + ls_user_id2 + "')" //andy 12/18/2009 (V10.1 - TDL) Replace gs_user_id with ls_user_id2.
					end if
				case 2				
					//Start Code Change ----03.16.2011 #V11 maha - added ability to include all in the list
					//if as_user_id = "-All-" then //Commented by (Appeon)Harry 01.09.2014
					if Upper(as_user_id) = "-ALL-" then  //(Appeon)Harry 01.09.2014 - V141 for Bug # 3816
						ls_ext_sql = ""
					else
						ls_ext_sql = " and (net_dev_action_items.action_user in ('" + as_user_id + "','Public'))"//Michael 09.14.2011: Replace ls_user_id2 with as_user_id
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
				if LenA(trim(as_where[ll_row])) > 0 then
					as_where[ll_row] += ls_ext_sql
				else
					as_where[ll_row] = MidA(ls_ext_sql,5,LenA(ls_ext_sql) - 4)
				end if
				if LenA(trim(ls_sql_where)) > 0 then
					ls_sql_where += ls_ext_sql
				else
					ls_sql_where = MidA(ls_ext_sql,5,LenA(ls_ext_sql) - 4)
				end if
			end if

			 
			 //---------------------------- APPEON END ----------------------------
		CASE "03"		//IntelliContract
			choose case al_tdl_right
				case 0
					//ls_ext_sql = " and (ctx_action_items.action_user = '" + gs_user_id + "')"
					ls_ext_sql = " and (ctx_action_items.action_user in ('" + ls_user_id2 + "','Public'))" // Modify by andy 12/18/2009 (V10.1 - TDL) Replace gs_user_id with ls_user_id2.
				case 1
					as_other_user = trim(as_other_user)
					if LenA(as_other_user) > 0 then						
						ls_ext_sql = " and (ctx_action_items.action_user = '" + ls_user_id2 + "' or ctx_action_items.action_user = '" +  as_other_user + "')" // Modify by andy 12/18/2009 (V10.1 - TDL) Replace gs_user_id with ls_user_id2.
					else
						ls_ext_sql = " and (ctx_action_items.action_user = '" + ls_user_id2 + "')" // Modify by andy 12/18/2009 (V10.1 - TDL) Replace gs_user_id with ls_user_id2.
					end if
				case 2				
					//Start Code Change ----03.16.2011 #V11 maha - added ability to include all in the list
					//if as_user_id = "-All-" then  //Commented by (Appeon)Harry 01.09.2014
					if Upper(as_user_id) = "-ALL-" then  //(Appeon)Harry 01.09.2014 - V141 for Bug # 3816
						ls_ext_sql = ""
					else
						ls_ext_sql = " and (ctx_action_items.action_user in ('" + as_user_id + "','Public'))"//Modify by Michael 09.14.2011: Replace ls_user_id2 with as_user_id
					end if
					//End Code Change ----03.16.2011
			end choose
						
			ls_sql += "SELECT tdl_id = " + String(ll_tdl_id) + ", tdli_id = " + String(ll_tdli_id) +&
			", cnt = count(1) FROM ctx_action_items &
			 JOIN ctx_basic_info ON ctx_action_items.ctx_id = ctx_basic_info.ctx_id &
			 AND Isnull(ctx_action_items.active_status,0) >= 0" + ls_ext_sql
			
			if LenA(trim(ls_ext_sql)) > 0 then
				if LenA(trim(as_where[ll_row])) > 0 then
					as_where[ll_row] += ls_ext_sql
				else
					as_where[ll_row] = MidA(ls_ext_sql,5,LenA(ls_ext_sql) - 4)
				end if
				if LenA(trim(ls_sql_where)) > 0 then
					ls_sql_where += ls_ext_sql
				else
					ls_sql_where = MidA(ls_ext_sql,5,LenA(ls_ext_sql) - 4)
				end if
			end if
		//---------------------------- APPEON END ----------------------------	 


		case "04"  //contract documents
			choose case al_tdl_right
				case 0
					//ls_ext_sql = " and (ctx_am_action_item.action_user = '" + gs_user_id + "')"
					ls_ext_sql = " and (ctx_am_action_item.action_user in ('" + ls_user_id2 + "','Public'))"// Modify by andy 12/18/2009 (V10.1 - TDL) Replace gs_user_id with ls_user_id2.
				case 1
					as_other_user = trim(as_other_user)
					if LenA(as_other_user) > 0 then						
						ls_ext_sql = " and (ctx_am_action_item.action_user = '" + ls_user_id2 + "' or ctx_am_action_item.action_user = '" +  as_other_user + "')"// Modify by andy 12/18/2009 (V10.1 - TDL) Replace gs_user_id with ls_user_id2.
					else
						ls_ext_sql = " and (ctx_am_action_item.action_user = '" + ls_user_id2 + "')"// Modify by andy 12/18/2009 (V10.1 - TDL) Replace gs_user_id with ls_user_id2.
					end if
				case 2
					//Start Code Change ----03.16.2011 #V11 maha - added ability to include all in the list
					//if as_user_id = "-All-" then //Commented by (Appeon)Harry 01.09.2014
					if Upper(as_user_id) = "-ALL-" then  //(Appeon)Harry 01.09.2014 - V141 for Bug # 3816
						ls_ext_sql = ""
					else
						ls_ext_sql = " and (ctx_am_action_item.action_user in ('" + as_user_id + "','Public'))"//Michael 09.14.2011: Replace ls_user_id2 with as_user_id
					end if
					//End Code Change ----03.16.2011						
			end choose
						
			ls_sql += "SELECT tdl_id = " + String(ll_tdl_id) + ", tdli_id = " + String(ll_tdli_id) +&
			", cnt = count(1) FROM ctx_am_action_item &
			,ctx_am_document,ctx_basic_info where ctx_am_action_item.doc_id = ctx_am_document.doc_id and ctx_am_document.ctx_id = ctx_basic_info.ctx_id &
			AND Isnull(ctx_am_action_item.active_status,0) >= 0" + ls_ext_sql
			
			if LenA(trim(ls_ext_sql)) > 0 then
				if LenA(trim(as_where[ll_row])) > 0 then
					as_where[ll_row] += ls_ext_sql
				else
					as_where[ll_row] = MidA(ls_ext_sql,5,LenA(ls_ext_sql) - 4)
				end if
				if LenA(trim(ls_sql_where)) > 0 then
					ls_sql_where += ls_ext_sql
				else
					ls_sql_where = MidA(ls_ext_sql,5,LenA(ls_ext_sql) - 4)
				end if
			end if
		//---------------------------- APPEON END ----------------------------	 
		
		// Add by andy 12/10/2009 (V10.1 - TDL)
		case "06" 	//checklist
			ls_ext_sql = ""
						
			choose case al_tdl_right
				case 0
					ls_ext_sql = " and (pd_affil_stat.priority_user in ('" + ls_user_id2 + "','Public') OR pd_affil_stat.priority_user IS NULL)"
				case 1
					as_other_user = trim(as_other_user)
					if LenA(as_other_user) > 0 then
						ls_ext_sql = " and (pd_affil_stat.priority_user = '" + ls_user_id2 + "' or verif_info.priority_user = '" +  as_other_user + "')"
					else
						ls_ext_sql = " and (pd_affil_stat.priority_user = '" + ls_user_id2 + "')"
					end if
				case 2
						ls_ext_sql = " and (pd_affil_stat.priority_user in ('" + as_user_id + "','Public') OR pd_affil_stat.priority_user IS NULL)"
			end choose

			//Added "or data_view_app_audit.app_type = 'B'" by alfee 11.12.2014 for BugA102105 			
			ls_sql += "SELECT tdl_id = " + String(ll_tdl_id) + ", tdli_id = " + String(ll_tdli_id) +&
						 ", cnt = count(1) FROM pd_app_audit &
								 INNER JOIN data_view_app_audit ON ( data_view_app_audit.app_audit_id = pd_app_audit.app_audit_id ) &
								 INNER JOIN pd_affil_stat ON ( pd_affil_stat.apptmnt_type = data_view_app_audit.app_type or data_view_app_audit.app_type = 'B' ) and ( pd_affil_stat.rec_id = pd_app_audit.appt_stat_id ) &
								 INNER JOIN pd_basic ON ( pd_app_audit.prac_id = pd_basic.prac_id ) AND ( ( pd_affil_stat.active_status in (1,4, 6) ) AND ( pd_affil_stat.apptmnt_start_date is null ) ) " + ls_ext_sql
			
			if LenA(trim(ls_ext_sql)) > 0 then
				if LenA(trim(as_where[ll_row])) > 0 then
					as_where[ll_row] += ls_ext_sql
				else
					as_where[ll_row] = MidA(ls_ext_sql,5,LenA(ls_ext_sql) - 4)
				end if
				if LenA(trim(ls_sql_where)) > 0 then
					ls_sql_where += ls_ext_sql
				else
					ls_sql_where = MidA(ls_ext_sql,5,LenA(ls_ext_sql) - 4)
				end if
			end if
			
		// Add by andy 12/26/2009 (V10.1 - TDL)
		case "07"  //notifications
			ls_ext_sql = ""
						
			choose case al_tdl_right
				case 0
					ls_ext_sql = " and (pd_affil_stat.priority_user in ('" + ls_user_id2 + "','Public') OR pd_affil_stat.priority_user IS NULL)"
				case 1
					as_other_user = trim(as_other_user)
					if LenA(as_other_user) > 0 then
						ls_ext_sql = " and (pd_affil_stat.priority_user = '" + ls_user_id2 + "' or verif_info.priority_user = '" +  as_other_user + "')"
					else
						ls_ext_sql = " and (pd_affil_stat.priority_user = '" + ls_user_id2 + "')"
					end if
				case 2
						ls_ext_sql = " and (pd_affil_stat.priority_user in ('" + as_user_id + "','Public') OR pd_affil_stat.priority_user IS NULL)"
			end choose
						
			ls_sql += "SELECT tdl_id = " + String(ll_tdl_id) + ", tdli_id = " + String(ll_tdli_id) +&
						 ", cnt = count(1) FROM alert_records &
						 		 INNER JOIN alert_hdr ON (alert_records.alert_id = alert_hdr.alert_id) &
								 INNER JOIN pd_affil_stat ON ( alert_records.prac_id = pd_affil_stat.prac_id and alert_records.Facility_id = pd_affil_stat.parent_facility_id ) &
								 INNER JOIN pd_basic ON ( pd_affil_stat.prac_id = pd_basic.prac_id ) &
								 AND pd_affil_stat.active_status IN " + ls_status + ls_ext_sql
									//AND ( pd_affil_stat.active_status in (1,4) ) " + ls_ext_sql  // AND pd_affil_stat.active_status IN (1,4)" + ls_ext_sql  //Start Code Change ----07.19.2011 #V11 maha 
		
			if LenA(trim(ls_ext_sql)) > 0 then
				if LenA(trim(as_where[ll_row])) > 0 then
					as_where[ll_row] += ls_ext_sql
				else
					as_where[ll_row] = MidA(ls_ext_sql,5,LenA(ls_ext_sql) - 4)
				end if
				if LenA(trim(ls_sql_where)) > 0 then
					ls_sql_where += ls_ext_sql
				else
					ls_sql_where = MidA(ls_ext_sql,5,LenA(ls_ext_sql) - 4)
				end if
			end if
			
			
		case "09"  //WebView
			ls_ext_sql = ""
						
			choose case al_tdl_right
				case 0
					ls_ext_sql = " and (pd_affil_stat.priority_user in ('" + ls_user_id2 + "','Public') OR pd_affil_stat.priority_user IS NULL)"
				case 1
					as_other_user = trim(as_other_user)
					if LenA(as_other_user) > 0 then
						ls_ext_sql = " and (pd_affil_stat.priority_user = '" + ls_user_id2 + "' or verif_info.priority_user = '" +  as_other_user + "')"
					else
						ls_ext_sql = " and (pd_affil_stat.priority_user = '" + ls_user_id2 + "')"
					end if
				case 2
						ls_ext_sql = " and (pd_affil_stat.priority_user in ('" + as_user_id + "','Public') OR pd_affil_stat.priority_user IS NULL)"
			end choose
			
			ls_sql += "SELECT tdl_id = " + String(ll_tdl_id) + ", tdli_id = " + String(ll_tdli_id) +&
						 ", cnt = count(1) FROM wv_prac_tracking &
								 INNER JOIN pd_affil_stat ON ( alert_records.prac_id = pd_affil_stat.prac_id and alert_records.Facility_id = pd_affil_stat.parent_facility_id ) &
								 INNER JOIN pd_basic ON ( pd_affil_stat.prac_id = pd_basic.prac_id ) &
								 AND pd_affil_stat.active_status IN " + ls_status + ls_ext_sql
									//AND ( pd_affil_stat.active_status in (1,4) ) " + ls_ext_sql  // AND pd_affil_stat.active_status IN (1,4)" + ls_ext_sql  //Start Code Change ----07.19.2011 #V11 maha 
		
			if LenA(trim(ls_ext_sql)) > 0 then
				if LenA(trim(as_where[ll_row])) > 0 then
					as_where[ll_row] += ls_ext_sql
				else
					as_where[ll_row] = MidA(ls_ext_sql,5,LenA(ls_ext_sql) - 4)
				end if
				if LenA(trim(ls_sql_where)) > 0 then
					ls_sql_where += ls_ext_sql
				else
					ls_sql_where = MidA(ls_ext_sql,5,LenA(ls_ext_sql) - 4)
				end if
			end if
			//debugbreak()
	END CHOOSE
	
   IF lb_exists_term THEN
		CHOOSE CASE ls_tdl_module
			case '04'
				ls_sql += " and " + ls_sql_where
			case else
				ls_sql += " WHERE " + ls_sql_where
		end choose
	end if
NEXT

//// Construct SQL according to term of to do item.
//FOR ll_row = 1 TO ads_todoitem.Rowcount()
//	ll_tdl_id = ads_todoitem.GetitemNumber( ll_row, "tdl_id" )
//	ll_tdli_id = ads_todoitem.GetitemNumber( ll_row, "tdli_id" )
//	ls_tdl_name = ads_todoitem.GetitemString( ll_row, "tdl_basic_info_tdl_name" )
//	ls_tdl_module = ads_todoitem.GetitemString( ll_row, "tdl_basic_info_module" )
//	
//	ll_Action_Type = ads_todoitem.GetitemNumber( ll_row, "Action_Type" )
//	ll_Action_Status = ads_todoitem.GetitemNumber( ll_row, "Action_Status" )
//	ll_Print_Flag = ads_todoitem.GetitemNumber( ll_row, "Print_Flag" )
//	ll_Due_Date = ads_todoitem.GetitemNumber( ll_row, "Due_Date" )
//	ls_Max_Sends_Flag = ads_todoitem.GetitemString( ll_row, "Max_Sends_Flag" )
//
//	If lb_all_user Then
//		as_user_id = ads_todoitem.GetItemString(ll_row,'tdl_users_access')
//		If isnull(as_user_id) Then 
//			as_user_id = ''
//		Else
//			//Cut single quotation marks
//			as_user_id = Mid(as_user_id,2)
//			as_user_id = Mid(as_user_id,1,len(as_user_id) - 1)
//		End If
//	End If
//	
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$< Add  > 2009-01-15 By: Scofield
//	//$<Reason> Add Assigned by user type.
//
//	ll_UserType = ads_todoitem.GetitemNumber(ll_row, "tdl_detail_user_type")
//	if IsNull(ll_UserType) then ll_UserType = 1
//	if ll_UserType = 1 then
//		ls_AssignUser = "ctx_action_items.action_user"
//		ls_AmAssignUser = "ctx_am_action_item.action_user"
//	else
//		ls_AssignUser = "ctx_action_items.wf_assigned_by"
//		ls_AmAssignUser = "ctx_am_action_item.wf_assigned_by"
//	end if
//	//---------------------------- APPEON END ----------------------------
//
//	ls_sql_where = ""
//	ls_sql_filter = ""
//	lb_exists_term = FALSE
//
//	// Term of Action Type
//	IF ll_Action_Type > 0 THEN
//		CHOOSE CASE ls_tdl_module
//			CASE "03"		//Contract Logix
//				ls_colname = "ctx_action_items.action_type"
//			//--------------------------- APPEON BEGIN ---------------------------
//			//$<modify> 03.21.2007 By: Machongmin
//			//$<reason> Fix a defect.
//			case "04"
//				ls_colname = "ctx_am_action_item.action_type"
//			//---------------------------- APPEON END ----------------------------	
//			CASE ELSE
//				RETURN ''
//		END CHOOSE
//
//		IF lb_exists_term THEN
//			ls_sql_where += " AND "
//			ls_sql_filter += " AND "
//		END IF
//		
//		ls_sql_where += ls_colname + " = " + String( ll_Action_Type )
//		ls_sql_filter += "action_type = " + String( ll_Action_Type )
//		
//		lb_exists_term = TRUE
//	END IF
//
//	// Term of Action Status
//	IF ll_Action_Status > 0 OR ll_Action_Status = -1 THEN
//		CHOOSE CASE ls_tdl_module
//			CASE "03"		//Contract Logix
//				ls_colname = "ctx_action_items.action_status"
//			//--------------------------- APPEON BEGIN ---------------------------
//			//$<modify> 03.21.2007 By: Machongmin
//			//$<reason> Fix a defect.
//			case "04"
//				ls_colname = "ctx_am_action_item.action_status"
//			//---------------------------- APPEON END ----------------------------
//			CASE ELSE
//				RETURN ''
//		END CHOOSE
//
//		IF lb_exists_term THEN
//			ls_sql_where += " AND "
//			ls_sql_filter += " AND "
//		END IF
//		
//		IF ll_Action_Status = -1 THEN // Action Status Is Null
//			ls_sql_where += ls_colname + " is null "
//			ls_sql_filter += " isnull(action_status) "
//		ELSE
//			ls_sql_where += ls_colname + " = " + String( ll_Action_Status )
//			ls_sql_filter += "action_status = " + String( ll_Action_Status )
//		END IF
//
//		lb_exists_term = TRUE
//	END IF
//
//	// Term of Print Flag
//	IF ll_Print_Flag >= 0 THEN
//		IF lb_exists_term THEN
//			ls_sql_where += " AND "
//			ls_sql_filter += " AND "
//		END IF
//
//		ls_sql_where += "Print_Flag = " + String( ll_Print_Flag )
//		ls_sql_filter += "Print_Flag = " + String( ll_Print_Flag )
//		
//		lb_exists_term = TRUE
//	END IF
//	
//	// Term of Due Date
//	IF ll_Due_Date >= 0 THEN
//		IF lb_exists_term THEN
//			ls_sql_where += " AND "
//			ls_sql_filter += " AND "
//		END IF
//
//		IF ll_Due_Date = 0 THEN
//			ls_sql_where += "DATEDIFF(Day,Due_Date,getdate()) >= 1"	//Modified by Scofield on 2009-01-14
//			ls_sql_filter += "daysafter(Due_Date,today()) >= 1"		//Modified by Scofield on 2009-01-14
//		ELSEIF ll_Due_Date = 1 THEN		//Added by Scofield on 2008-12-23
//			ls_sql_where += "DATEDIFF(Day,Due_Date,getdate()) = 0"
//			ls_sql_filter += "daysafter(Due_Date,today()) = 0"
//		ELSE
//			ls_sql_where += "(Due_Date >= getdate() AND Due_Date <= dateadd(day," + String(ll_Due_Date) + ",getdate()))"
//			ls_sql_filter += "(Due_Date >= today() AND Due_Date <= RelativeDate(today()," + String(ll_Due_Date) + "))"
//		END IF
//
//		lb_exists_term = TRUE
//	END IF
//
//	// Max Number Attempts
//	IF ls_Max_Sends_Flag = '1' THEN
//		IF lb_exists_term THEN
//			ls_sql_where += " AND "
//			ls_sql_filter += " AND "
//		END IF
//		
//		CHOOSE CASE ls_tdl_module
//			CASE "03"		//Contract Logix
//				//ls_sql_where += "ctx_action_items.no_attemp >= wf_action_status.send_count"
//				ls_sql_where += "(Exists (select 1 from wf_action_status where ctx_action_items.wf_id = wf_action_status.wf_id &
//										AND ctx_action_items.wf_action_type_id = wf_action_status.step_id &
//										AND ctx_action_items.action_status = wf_action_status.action_status_id &
//										AND ctx_action_items.no_attempts >= wf_action_status.send_count))"
//				ls_sql_filter += "number_sent >= wf_action_status_send_count"
//				//--------------------------- APPEON BEGIN ---------------------------
//				//$<modify> 03.21.2007 By: Machongmin
//				//$<reason> Fix a defect.
//			case "04"
//				ls_sql_where += "(Exists (select 1 from wf_action_status where ctx_am_action_item.wf_id = wf_action_status.wf_id AND ctx_am_action_item.wf_action_type_id = wf_action_status.step_id AND ctx_am_action_item.action_status = wf_action_status.action_status_id AND ctx_am_action_item.Attempt_Times >= wf_action_status.send_count))"
//				ls_sql_filter += "Attempt_Times >= wf_action_status_send_count"
//				
//				//---------------------------- APPEON END ----------------------------	
//		END CHOOSE
//
//		lb_exists_term = TRUE
//	END IF
//	
//
//	// Set where condition to array
//	as_where[ll_row] = ls_sql_where
//	as_filter[ll_row] = ls_sql_filter
//	
//	// Construct SQL for dynamic sql
//	IF Len(ls_sql) > 0 THEN ls_sql += "~r~n UNION ~r~n"
//	
//	CHOOSE CASE ls_tdl_module
//		CASE "03"		//Contract Logix
//			choose case al_tdl_right
//				case 0
//					//<Modify> 07/31/2007 by: Andy
//					//ls_ext_sql = " and (" + ls_AssignUser + " = '" + gs_user_id + "')"
//					ls_ext_sql = " and (" + ls_AssignUser + " in ('" + gs_user_id + "','Public'))"		//Modified by Scofield on 2009-01-15
//					//end of modify
//				case 1
//					as_other_user = trim(as_other_user)
//					if len(as_other_user) > 0 then
//						ls_ext_sql = " and (" + ls_AssignUser + " = '" + gs_user_id + "' or " + ls_AssignUser + " = '" +  as_other_user + "')"		//Modified by Scofield on 2009-01-15
//					else
//						ls_ext_sql = " and (" + ls_AssignUser + " = '" + gs_user_id + "')"					//Modified by Scofield on 2009-01-15
//					end if
//				case 2
//						ls_ext_sql = " and (" + ls_AssignUser + " in ('" + as_user_id + "','Public'))"	//Modified by Scofield on 2009-01-15
//			end choose
//		
//			ls_ext_sql += This.of_gen_where_due_date(ls_tdl_module,adt_where_due_date) //Added by Ken.Guo on 2009-01-20
//			
//			ls_sql += "SELECT tdl_id = " + String(ll_tdl_id) + ", tdli_id = " + String(ll_tdli_id) +&
//			", cnt = count(1) FROM ctx_action_items &
//			 JOIN ctx_basic_info ON ctx_action_items.ctx_id = ctx_basic_info.ctx_id and ctx_basic_info.is_template = 0 &
//			 JOIN code_lookup ctx_status On (ctx_basic_info.status = ctx_status.lookup_code And ctx_status.custom_3 = 'YES' )  &
//			 AND Isnull(ctx_action_items.active_status,0) >= 0" + ls_ext_sql
//			
//			if len(trim(ls_ext_sql)) > 0 then
//				if len(trim(as_where[ll_row])) > 0 then
//					as_where[ll_row] += ls_ext_sql
//				else
//					as_where[ll_row] = mid(ls_ext_sql,5,len(ls_ext_sql) - 4)
//				end if
//				if len(trim(ls_sql_where)) > 0 then
//					ls_sql_where += ls_ext_sql
//				else
//					ls_sql_where = mid(ls_ext_sql,5,len(ls_ext_sql) - 4)
//				end if
//			end if
//		//---------------------------- APPEON END ----------------------------	 
//
//
//		case "04"
//			choose case al_tdl_right
//				case 0
//					ls_ext_sql = " and (" + ls_AmAssignUser + " in ('" + gs_user_id + "','Public'))"			//Modified by Scofield on 2009-01-15	
//				case 1
//					as_other_user = trim(as_other_user)
//					if len(as_other_user) > 0 then
//						ls_ext_sql = " and (" + ls_AmAssignUser + " = '" + gs_user_id + "' or " + ls_AmAssignUser + " = '" +  as_other_user + "')"		//Modified by Scofield on 2009-01-15
//					else
//						ls_ext_sql = " and (" + ls_AmAssignUser + " = '" + gs_user_id + "')"						//Modified by Scofield on 2009-01-15
//					end if
//				case 2
//						ls_ext_sql = " and (" + ls_AmAssignUser + " in ('" + as_user_id + "','Public'))"		//Modified by Scofield on 2009-01-15
//			end choose
//		
//			ls_ext_sql += This.of_gen_where_due_date(ls_tdl_module,adt_where_due_date) //Added by Ken.Guo on 2009-01-20
//			
//			ls_sql += "SELECT tdl_id = " + String(ll_tdl_id) + ", tdli_id = " + String(ll_tdli_id) +&
//			", cnt = count(1) FROM ctx_am_action_item &
//			,ctx_am_document,ctx_basic_info &
//			JOIN code_lookup ctx_status On (ctx_basic_info.status = ctx_status.lookup_code And ctx_status.custom_3 = 'YES' )  &
//			where ctx_am_action_item.doc_id = ctx_am_document.doc_id and ctx_am_document.ctx_id = ctx_basic_info.ctx_id and ctx_basic_info.is_template = 0 &
//			AND Isnull(ctx_am_action_item.active_status,0) >= 0" + ls_ext_sql
//			
//			if len(trim(ls_ext_sql)) > 0 then
//				if len(trim(as_where[ll_row])) > 0 then
//					as_where[ll_row] += ls_ext_sql
//				else
//					as_where[ll_row] = mid(ls_ext_sql,5,len(ls_ext_sql) - 4)
//				end if
//				if len(trim(ls_sql_where)) > 0 then
//					ls_sql_where += ls_ext_sql
//				else
//					ls_sql_where = mid(ls_ext_sql,5,len(ls_ext_sql) - 4)
//				end if
//			end if
//		//---------------------------- APPEON END ----------------------------	 
//	END CHOOSE
//	
//	
//   IF lb_exists_term THEN
//		CHOOSE CASE ls_tdl_module
//			case '04'
//				ls_sql += " and " + ls_sql_where
//			case else
//				ls_sql += " WHERE " + ls_sql_where
//		end choose
//	end if
//	//---------------------------- APPEON END ----------------------------
//NEXT

Return ls_sql

end function

public function string of_gen_tdl_sql (string as_user_id, datastore ads_todoitem, ref string as_where[], ref string as_filter[], datetime adt_where_due_date, long al_tdl_right, string as_other_user);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_tdl_function::of_gen_tdl_sql()
// $<arguments>
//		value    	string   	as_user_id        		
//		value    	datastore	ads_todoitem      		
//		reference	string   	as_where[]        		
//		reference	string   	as_filter[]       		
//		value    	datetime 	adt_where_due_date		
//		value    	long     	al_tdl_right      		
//		value    	string   	as_other_user     		
// $<returns> string
// $<description> Move from u_cst_todolist::ue_retrieve_todolist()
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 02.25.2009 by Ken.Guo
//(Appeon)Toney 10.14.2013 - V141 ISG-CLX  Fix Reintegration BugH101101
//////////////////////////////////////////////////////////////////////
string ls_ext_sql,ls_sql
long ll_row
Long ll_tdl_id,ll_tdli_id,ll_Action_Type
Long ll_Action_Status,ll_Print_Flag,ll_Due_Date,ll_UserType
String ls_tdl_name,ls_tdl_module,ls_Max_Sends_Flag,ls_AssignUser,ls_AmAssignUser
String ls_sql_where,ls_sql_filter,ls_colname
Boolean lb_exists_term
String ls_module[]
Boolean lb_all_user = False

If as_user_id = '-ALL-' Then 
	lb_all_user = True
End If

// Construct SQL according to term of to do item.
FOR ll_row = 1 TO ads_todoitem.Rowcount()
	ll_tdl_id = ads_todoitem.GetitemNumber( ll_row, "tdl_id" )
	ll_tdli_id = ads_todoitem.GetitemNumber( ll_row, "tdli_id" )
	ls_tdl_name = ads_todoitem.GetitemString( ll_row, "tdl_basic_info_tdl_name" )
	ls_tdl_module = ads_todoitem.GetitemString( ll_row, "tdl_basic_info_module" )
	
	ll_Action_Type = ads_todoitem.GetitemNumber( ll_row, "Action_Type" )
	ll_Action_Status = ads_todoitem.GetitemNumber( ll_row, "Action_Status" )
	ll_Print_Flag = ads_todoitem.GetitemNumber( ll_row, "Print_Flag" )
	ll_Due_Date = ads_todoitem.GetitemNumber( ll_row, "Due_Date" )
	ls_Max_Sends_Flag = ads_todoitem.GetitemString( ll_row, "Max_Sends_Flag" )

	If lb_all_user Then
		//as_user_id = ads_todoitem.GetItemString(ll_row,'tdl_users_access')
		as_user_id = of_get_tdl_users (ll_tdl_id) //BugL120301 - alfee 12.06.2013
		If isnull(as_user_id) Then 
			as_user_id = ''
		Else
			//Cut single quotation marks
			as_user_id = Mid(as_user_id,2)
			as_user_id = Mid(as_user_id,1,len(as_user_id) - 1)
		End If
	End If
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$< Add  > 2009-01-15 By: Scofield
	//$<Reason> Add Assigned by user type.

	ll_UserType = ads_todoitem.GetitemNumber(ll_row, "tdl_detail_user_type")
	if IsNull(ll_UserType) then ll_UserType = 1
	if ll_UserType = 1 then
		ls_AssignUser = "ctx_action_items.action_user"
		ls_AmAssignUser = "ctx_am_action_item.action_user"
	else
		ls_AssignUser = "ctx_action_items.wf_assigned_by"
		ls_AmAssignUser = "ctx_am_action_item.wf_assigned_by"
	end if
	//---------------------------- APPEON END ----------------------------

	ls_sql_where = ""
	ls_sql_filter = ""
	lb_exists_term = FALSE

	// Term of Action Type
	IF ll_Action_Type > 0 THEN
		CHOOSE CASE ls_tdl_module
			CASE "03"		//Contract Logix
				ls_colname = "ctx_action_items.action_type"
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 03.21.2007 By: Machongmin
			//$<reason> Fix a defect.
			case "04"
				ls_colname = "ctx_am_action_item.action_type"
			//---------------------------- APPEON END ----------------------------	
		END CHOOSE

		IF lb_exists_term THEN
			ls_sql_where += " AND "
			ls_sql_filter += " AND "
		END IF
		
		ls_sql_where += ls_colname + " = " + String( ll_Action_Type )
		ls_sql_filter += "action_type = " + String( ll_Action_Type )
		
		lb_exists_term = TRUE
	END IF

	// Term of Action Status
	IF ll_Action_Status > 0 OR ll_Action_Status = -1 THEN
		CHOOSE CASE ls_tdl_module
			CASE "03"		//Contract Logix
				ls_colname = "ctx_action_items.action_status"
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 03.21.2007 By: Machongmin
			//$<reason> Fix a defect.
			case "04"
				ls_colname = "ctx_am_action_item.action_status"
			//---------------------------- APPEON END ----------------------------	
		END CHOOSE

		IF lb_exists_term THEN
			ls_sql_where += " AND "
			ls_sql_filter += " AND "
		END IF
		
		IF ll_Action_Status = -1 THEN // Action Status Is Null
			ls_sql_where += ls_colname + " is null "
			ls_sql_filter += " isnull(action_status) "
		ELSE
			ls_sql_where += ls_colname + " = " + String( ll_Action_Status )
			ls_sql_filter += "action_status = " + String( ll_Action_Status )
		END IF

		lb_exists_term = TRUE
	END IF

	// Term of Print Flag
	IF ll_Print_Flag >= 0 THEN
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

		IF ll_Due_Date = 0 THEN
			ls_sql_where += "DATEDIFF(Day,Due_Date,getdate()) >= 1"	//Modified by Scofield on 2009-01-14
			ls_sql_filter += "daysafter(Due_Date,today()) >= 1"		//Modified by Scofield on 2009-01-14
		ELSEIF ll_Due_Date = 1 THEN		//Added by Scofield on 2008-12-23
			ls_sql_where += "DATEDIFF(Day,Due_Date,getdate()) = 0"
			ls_sql_filter += "daysafter(Due_Date,today()) = 0"
		ELSE
			ls_sql_where += "(Due_Date >= getdate() AND Due_Date <= dateadd(day," + String(ll_Due_Date) + ",getdate()))"
			ls_sql_filter += "(Due_Date >= today() AND Due_Date <= RelativeDate(today()," + String(ll_Due_Date) + "))"
		END IF

		lb_exists_term = TRUE
	END IF

	// Max Number Attempts
	IF ls_Max_Sends_Flag = '1' THEN
		IF lb_exists_term THEN
			ls_sql_where += " AND "
			ls_sql_filter += " AND "
		END IF
		
		CHOOSE CASE ls_tdl_module
			CASE "03"		//Contract Logix
				//ls_sql_where += "ctx_action_items.no_attemp >= wf_action_status.send_count"
				ls_sql_where += "(Exists (select 1 from wf_action_status where ctx_action_items.wf_id = wf_action_status.wf_id &
										AND ctx_action_items.wf_action_type_id = wf_action_status.step_id &
										AND ctx_action_items.action_status = wf_action_status.action_status_id &
										AND ctx_action_items.no_attempts >= wf_action_status.send_count))"
				ls_sql_filter += "number_sent >= wf_action_status_send_count"
				//--------------------------- APPEON BEGIN ---------------------------
				//$<modify> 03.21.2007 By: Machongmin
				//$<reason> Fix a defect.
			case "04"
				ls_sql_where += "(Exists (select 1 from wf_action_status where ctx_am_action_item.wf_id = wf_action_status.wf_id AND ctx_am_action_item.wf_action_type_id = wf_action_status.step_id AND ctx_am_action_item.action_status = wf_action_status.action_status_id AND ctx_am_action_item.Attempt_Times >= wf_action_status.send_count))"
				ls_sql_filter += "Attempt_Times >= wf_action_status_send_count"
				
				//---------------------------- APPEON END ----------------------------	
		END CHOOSE

		lb_exists_term = TRUE
	END IF
	

	// Set where condition to array
	as_where[ll_row] = ls_sql_where
	as_filter[ll_row] = ls_sql_filter
	
	// Construct SQL for dynamic sql
	IF Len(ls_sql) > 0 THEN ls_sql += "~r~n UNION ~r~n"
	
	CHOOSE CASE ls_tdl_module
		CASE "03"		//Contract Logix
			choose case al_tdl_right
				case 0
					//<Modify> 07/31/2007 by: Andy
					//ls_ext_sql = " and (" + ls_AssignUser + " = '" + gs_user_id + "')"
					ls_ext_sql = " and (" + ls_AssignUser + " in ('" + gs_user_id + "','Public'))"		//Modified by Scofield on 2009-01-15
					//end of modify
				case 1
					as_other_user = trim(as_other_user)
					if len(as_other_user) > 0 then
						ls_ext_sql = " and (" + ls_AssignUser + " = '" + gs_user_id + "' or " + ls_AssignUser + " = '" +  as_other_user + "')"		//Modified by Scofield on 2009-01-15
					else
						ls_ext_sql = " and (" + ls_AssignUser + " = '" + gs_user_id + "')"					//Modified by Scofield on 2009-01-15
					end if
				case 2
						ls_ext_sql = " and (" + ls_AssignUser + " in ('" + as_user_id + "','Public'))"	//Modified by Scofield on 2009-01-15
			end choose
		
			ls_ext_sql += This.of_gen_where_due_date(ls_tdl_module,adt_where_due_date) //Added by Ken.Guo on 2009-01-20
			
			ls_sql += "SELECT tdl_id = " + String(ll_tdl_id) + ", tdli_id = " + String(ll_tdli_id) +&
			", cnt = count(1) FROM ctx_action_items &
			 JOIN ctx_basic_info ON ctx_action_items.ctx_id = ctx_basic_info.ctx_id and ctx_basic_info.is_template = 0 &
			 JOIN code_lookup ctx_status On (ctx_basic_info.status = ctx_status.lookup_code And ctx_status.custom_3 = 'YES' )  &
			 AND Isnull(ctx_action_items.active_status,0) >= 0" + ls_ext_sql
			
			if len(trim(ls_ext_sql)) > 0 then
				if len(trim(as_where[ll_row])) > 0 then
					as_where[ll_row] += ls_ext_sql
				else
					as_where[ll_row] = mid(ls_ext_sql,5,len(ls_ext_sql) - 4)
				end if
				if len(trim(ls_sql_where)) > 0 then
					ls_sql_where += ls_ext_sql
				else
					ls_sql_where = mid(ls_ext_sql,5,len(ls_ext_sql) - 4)
				end if
			end if
		//---------------------------- APPEON END ----------------------------	 


		case "04"
			choose case al_tdl_right
				case 0
					ls_ext_sql = " and (" + ls_AmAssignUser + " in ('" + gs_user_id + "','Public'))"			//Modified by Scofield on 2009-01-15	
				case 1
					as_other_user = trim(as_other_user)
					if len(as_other_user) > 0 then
						ls_ext_sql = " and (" + ls_AmAssignUser + " = '" + gs_user_id + "' or " + ls_AmAssignUser + " = '" +  as_other_user + "')"		//Modified by Scofield on 2009-01-15
					else
						ls_ext_sql = " and (" + ls_AmAssignUser + " = '" + gs_user_id + "')"						//Modified by Scofield on 2009-01-15
					end if
				case 2
						ls_ext_sql = " and (" + ls_AmAssignUser + " in ('" + as_user_id + "','Public'))"		//Modified by Scofield on 2009-01-15
			end choose
		
			ls_ext_sql += This.of_gen_where_due_date(ls_tdl_module,adt_where_due_date) //Added by Ken.Guo on 2009-01-20
			
			ls_sql += "SELECT tdl_id = " + String(ll_tdl_id) + ", tdli_id = " + String(ll_tdli_id) +&
			", cnt = count(1) FROM ctx_am_action_item &
			,ctx_am_document,ctx_basic_info &
			JOIN code_lookup ctx_status On (ctx_basic_info.status = ctx_status.lookup_code And ctx_status.custom_3 = 'YES' )  &
			where ctx_am_action_item.doc_id = ctx_am_document.doc_id and ctx_am_document.ctx_id = ctx_basic_info.ctx_id and ctx_basic_info.is_template = 0 &
			AND Isnull(ctx_am_action_item.active_status,0) >= 0" + ls_ext_sql
			
			if len(trim(ls_ext_sql)) > 0 then
				if len(trim(as_where[ll_row])) > 0 then
					as_where[ll_row] += ls_ext_sql
				else
					as_where[ll_row] = mid(ls_ext_sql,5,len(ls_ext_sql) - 4)
				end if
				if len(trim(ls_sql_where)) > 0 then
					ls_sql_where += ls_ext_sql
				else
					ls_sql_where = mid(ls_ext_sql,5,len(ls_ext_sql) - 4)
				end if
			end if
		//---------------------------- APPEON END ----------------------------	 
	END CHOOSE
	
	
   IF lb_exists_term THEN
		CHOOSE CASE ls_tdl_module
			case '04'
				ls_sql += " and " + ls_sql_where
			case else
				ls_sql += " WHERE " + ls_sql_where
		end choose
	end if
	//---------------------------- APPEON END ----------------------------
NEXT

Return ls_sql

end function

public function string of_get_tdl_users (long al_tdl_id);//====================================================================
//$<Function>: of_get_tdl_users()
//$<Arguments>:
// 	value    long    al_tdl_id
//$<Return>:  string
//$<Description>: Get users for a specified to do list
//$<Author>: (Appeon) Alfee 12.06.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Long ll_cnt, i
String ls_filter, ls_users, ls_user_id

IF IsNull(al_tdl_id) THEN RETURN ''

ids_tdl_user_access.SetFilter ("")
ids_tdl_user_access.Filter ()

IF ids_tdl_user_access.RowCount () < 1 THEN
   ids_tdl_user_access.Retrieve ()
END IF

ls_filter = "tdl_id = " + String (al_tdl_id)
ids_tdl_user_access.SetFilter (ls_filter)
ids_tdl_user_access.Filter ()

ll_cnt = ids_tdl_user_access.RowCount ()
FOR i = 1 TO ll_cnt
	ls_user_id = ids_tdl_user_access.GetItemString (i, "user_id") 
	IF i <> 1 THEN ls_users += ","
	ls_users += "'"+ ls_user_id + "'"
NEXT

RETURN ls_users





end function

on n_cst_tdl_function.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_tdl_function.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//alfee 12.06.2013

ids_tdl_user_access = Create DataStore
ids_tdl_user_access.DataObject = 'd_tdl_user_access'
ids_tdl_user_access.SetTransObject (SQLCA)
end event

event destructor;If IsValid(ids_tdl_user_access) Then Destroy ids_tdl_user_access //alfee 12.06.2013
end event

