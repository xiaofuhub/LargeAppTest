$PBExportHeader$w_todolist_bak.srw
forward
global type w_todolist_bak from w_sheet
end type
type cb_1 from commandbutton within w_todolist_bak
end type
type dw_document from u_dw within w_todolist_bak
end type
type dw_document_all from u_dw within w_todolist_bak
end type
type cb_save from commandbutton within w_todolist_bak
end type
type dw_action_status from u_dw within w_todolist_bak
end type
type st_time from statictext within w_todolist_bak
end type
type dw_tdl_intellicred_all from u_dw within w_todolist_bak
end type
type cb_refresh from commandbutton within w_todolist_bak
end type
type cb_go from commandbutton within w_todolist_bak
end type
type cb_print from commandbutton within w_todolist_bak
end type
type dw_facility from u_dw within w_todolist_bak
end type
type dw_tdl_intelliapp_all from u_dw within w_todolist_bak
end type
type dw_tdl_intelliapp from u_dw within w_todolist_bak
end type
type dw_tdl_intellicred from u_dw within w_todolist_bak
end type
type dw_todoitem from u_dw within w_todolist_bak
end type
type dw_tdl_intellicontract_all from u_dw within w_todolist_bak
end type
type tv_results from u_tvs within w_todolist_bak
end type
type dw_tdl_intellicontract from u_dw within w_todolist_bak
end type
end forward

global type w_todolist_bak from w_sheet
integer x = 214
integer y = 221
integer width = 2871
integer height = 1708
string title = "To Do List"
event ue_retrieve_todolist ( )
cb_1 cb_1
dw_document dw_document
dw_document_all dw_document_all
cb_save cb_save
dw_action_status dw_action_status
st_time st_time
dw_tdl_intellicred_all dw_tdl_intellicred_all
cb_refresh cb_refresh
cb_go cb_go
cb_print cb_print
dw_facility dw_facility
dw_tdl_intelliapp_all dw_tdl_intelliapp_all
dw_tdl_intelliapp dw_tdl_intelliapp
dw_tdl_intellicred dw_tdl_intellicred
dw_todoitem dw_todoitem
dw_tdl_intellicontract_all dw_tdl_intellicontract_all
tv_results tv_results
dw_tdl_intellicontract dw_tdl_intellicontract
end type
global w_todolist_bak w_todolist_bak

type variables
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
end variables

forward prototypes
public function integer of_fill_treeview ()
public function integer of_fill_tdl_data (long ll_handle)
public function integer of_fill_report (datawindow adw)
public function integer of_goto_contract (long ll_ctx_id, string ls_moveto)
public function integer of_run_action (integer ai_action, string as_sql_where)
public function integer of_goto_practitioner (long ll_prac_id, long ll_facility_id, long ll_parent_facility_id, long ll_rec_id, long ll_seq_no, string ls_moveto, string ls_action)
public function integer of_goto_practitioner_action (long ll_prac_id, long ll_facility_id, long ll_parent_facility_id, long ll_rec_id, long ll_seq_no, string ls_moveto, string ls_action)
public subroutine of_item_changed (long handle)
public function integer of_document ()
public function integer of_find_actionitem (integer al_seq_id)
public function integer of_find_document (integer al_doc_id, string as_tabpage, integer al_seq_id)
public function integer of_preview_doc ()
public function integer of_clausemap ()
public function integer of_29_10 (long al_doc_id, string as_moveto, long al_seq_id)
public function integer of_27_11 (long al_doc_id, string as_moveto, long al_seq_id)
public function integer of_29_09 (long al_doc_id, string as_moveto, long al_seq_id)
public function integer of_30 (long al_doc_id, string as_moveto, long al_seq_id)
public function integer of_31 (long al_doc_id, string as_moveto, long al_seq_id)
end prototypes

event ue_retrieve_todolist();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.28.2006 By: Davis
//$<reason> To retrieve to do list item.

LONG ll_row,ll_rowcnt
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

//<add> 06/25/2007 by: Andy fixed a bug
String ls_user_id
ls_user_id = dw_facility.GetItemString(1, "user_id")
IF NOT f_validstr(ls_user_id) THEN ls_user_id = gs_user_id
//end of add

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.28.2007 By: Machongmin
//$<reason> Fix a defect.	

string ls_ext_sql,ls_other_user 
long ll_tdl_right
SELECT tdl_rights,tdl_other_user into :ll_tdl_right,:ls_other_user from security_users where user_id = :gs_user_id;
//---------------------------- APPEON END ----------------------------

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
	

	ls_sql_where = ""
	ls_sql_filter = ""
	lb_exists_term = FALSE

	// Facility
	IF (ls_tdl_module = "01" OR ls_tdl_module = "02") AND il_facility_id > 0 THEN
		CHOOSE CASE ls_tdl_module
			CASE "01"		//IntelliCred
				ls_colname = "verif_info.facility_id"
			CASE "02"		//IntelliApp
				ls_colname = "net_dev_action_items.facility_id"
		END CHOOSE

		IF lb_exists_term THEN
			ls_sql_where += " AND "
			ls_sql_filter += " AND "
		END IF

		ls_sql_where += ls_colname + " = " + String(il_facility_id)
		ls_sql_filter += "facility_id = " + String(il_facility_id)

		lb_exists_term = TRUE
	END IF

	// Term of Action Type
	IF ll_Action_Type > 0 THEN
		CHOOSE CASE ls_tdl_module
			CASE "01"		//IntelliCred
				ls_colname = "verif_info.verification_method"
			CASE "02"		//IntelliApp
				ls_colname = "net_dev_action_items.action_type"
			CASE "03"		//IntelliContract
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
			CASE "01"		//IntelliCred
				ls_colname = "verif_info.response_code"
			CASE "02"		//IntelliApp
				ls_colname = "net_dev_action_items.action_status"
			CASE "03"		//IntelliContract
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
			ls_sql_where += "Due_Date < getdate()"
			ls_sql_filter += "Due_Date < today()"
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
			CASE "01"		//IntelliCred
				//ls_sql_where += "(verif_info.number_sent >= wf_action_status.send_count OR verif_info.number_sent >= facility_ver_rules.ver_letter_max_sends)"
				ls_sql_where += "(Exists (select 1 from wf_action_status where verif_info.wf_id = wf_action_status.wf_id &
										AND verif_info.wf_action_type_id = wf_action_status.step_id &
										AND verif_info.response_code = wf_action_status.action_status_id &
										AND verif_info.number_sent >= wf_action_status.send_count) &
										OR Exists (select 1 from facility_ver_rules where facility_ver_rules.facility_id = verif_info.facility_id &
										AND facility_ver_rules.screen_id = verif_info.screen_id &
										AND verif_info.number_sent >= facility_ver_rules.ver_letter_max_sends))"
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
	is_where[ll_row] = ls_sql_where
	is_filter[ll_row] = ls_sql_filter
	
	// Construct SQL for dynamic sql
	IF LenA(ls_sql) > 0 THEN ls_sql += "~r~n UNION ~r~n"
	
	CHOOSE CASE ls_tdl_module
		CASE "01"		//IntelliCred
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 03.28.2007 By: Machongmin
			//$<reason> Fix a defect.	
			/*
			ls_sql += "SELECT tdl_id = " + String(ll_tdl_id) + ", tdli_id = " + String(ll_tdli_id) +&
			", cnt = count(1) FROM verif_info &
			 JOIN pd_basic ON verif_info.prac_id = pd_basic.prac_id &
			 JOIN pd_affil_stat ON verif_info.prac_id = pd_affil_stat.prac_id &
			 AND verif_info.facility_id = pd_affil_stat.verifying_facility &
			 AND verif_info.active_status = 1 &
			 AND pd_affil_stat.active_status IN (1,4)"
			 */
			 choose case ll_tdl_right
				case 0
					//<Modify> 07/31/2007 by: Andy
					//ls_ext_sql = " and (verif_info.priority_user = '" + gs_user_id + "')"
					ls_ext_sql = " and (verif_info.priority_user in ('" + gs_user_id + "','Public'))"
					//end of Modify
				case 1
					ls_other_user = trim(ls_other_user)
					if LenA(ls_other_user) > 0 then
						ls_ext_sql = " and (verif_info.priority_user = '" + gs_user_id + "' or verif_info.priority_user = '" +  ls_other_user + "')"
					else
						ls_ext_sql = " and (verif_info.priority_user = '" + gs_user_id + "')"
					end if
				case 2
					//<add> 06/25/2007 by: Andy
					//if lower(ls_user_id) = lower(gs_user_id) then
					//	ls_ext_sql = ""
					//else
						//All user is filtered(include ls_user_id = gs_user_id)
						//<Modify> 07/31/2007 by: Andy
						//ls_ext_sql = " and (verif_info.priority_user = '" + ls_user_id + "')"
						ls_ext_sql = " and (verif_info.priority_user in ('" + ls_user_id + "','Public'))"
						//end of Modify
					//end if
					//end of add
					//comment 06/25/2007 by: Andy
					//ls_ext_sql = ""
			end choose
						
			ls_sql += "SELECT tdl_id = " + String(ll_tdl_id) + ", tdli_id = " + String(ll_tdli_id) +&
			", cnt = count(1) FROM verif_info &
			 JOIN pd_basic ON verif_info.prac_id = pd_basic.prac_id &
			 JOIN pd_affil_stat ON verif_info.prac_id = pd_affil_stat.prac_id &
			 AND verif_info.facility_id = pd_affil_stat.verifying_facility &
			 AND verif_info.active_status = 1 &
			 AND pd_affil_stat.active_status IN (1,4)" + ls_ext_sql
			
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
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 03.28.2007 By: Machongmin
			//$<reason> Fix a defect.	
			/*
			ls_sql += "SELECT tdl_id = " + String(ll_tdl_id) + ", tdli_id = " + String(ll_tdli_id) +&
			", cnt = count(1) FROM net_dev_action_items &
			 JOIN pd_basic ON net_dev_action_items.Prac_id = pd_basic.prac_id &
			 JOIN pd_affil_stat ON net_dev_action_items.prac_id = pd_affil_stat.prac_id &
			 AND net_dev_action_items.facility_id = pd_affil_stat.parent_facility_id &
			 AND net_dev_action_items.active_status = 1 &
			 AND pd_affil_stat.active_status IN (1,4)"
			 */
			 choose case ll_tdl_right
				case 0
					//<Modify> 07/31/2007 by: Andy
					//ls_ext_sql = " and (net_dev_action_items.action_user = '" + gs_user_id + "')"
					ls_ext_sql = " and (net_dev_action_items.action_user in ('" + gs_user_id + "','Public'))"
					//end of modify
				case 1
					ls_other_user = trim(ls_other_user)
					if LenA(ls_other_user) > 0 then
						ls_ext_sql = " and (net_dev_action_items.action_user = '" + gs_user_id + "' or net_dev_action_items.action_user = '" +  ls_other_user + "')"
					else
						ls_ext_sql = " and (net_dev_action_items.action_user = '" + gs_user_id + "')"
					end if
				case 2
					//<add> 06/25/2007 by: Andy
					//if lower(ls_user_id) = lower(gs_user_id) then
					//	ls_ext_sql = ""
					//else
						//All user is filtered(include ls_user_id = gs_user_id)
						//<Modify> 07/31/2007 by: Andy
						//ls_ext_sql = " and (net_dev_action_items.action_user = '" + ls_user_id + "')"
						ls_ext_sql = " and (net_dev_action_items.action_user in ('" + ls_user_id + "','Public'))"
						//end of modify
					//end if
					//end of add
					//comment 06/25/2007 by: Andy
					//ls_ext_sql = ""
			end choose
						
			ls_sql += "SELECT tdl_id = " + String(ll_tdl_id) + ", tdli_id = " + String(ll_tdli_id) +&
			", cnt = count(1) FROM net_dev_action_items &
			 JOIN pd_basic ON net_dev_action_items.Prac_id = pd_basic.prac_id &
			 JOIN pd_affil_stat ON net_dev_action_items.prac_id = pd_affil_stat.prac_id &
			 AND net_dev_action_items.facility_id = pd_affil_stat.parent_facility_id &
			 AND net_dev_action_items.active_status = 1 &
			 AND pd_affil_stat.active_status IN (1,4)" + ls_ext_sql
			
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
 			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 03.28.2007 By: Machongmin
			//$<reason> Fix a defect.
			/*
			ls_sql += "SELECT tdl_id = " + String(ll_tdl_id) + ", tdli_id = " + String(ll_tdli_id) +&
			", cnt = count(1) FROM ctx_action_items &
			 JOIN ctx_basic_info ON ctx_action_items.ctx_id = ctx_basic_info.ctx_id &
			 AND Isnull(ctx_action_items.active_status,0) >= 0"
			*/
			choose case ll_tdl_right
				case 0
					//<Modify> 07/31/2007 by: Andy
					//ls_ext_sql = " and (ctx_action_items.action_user = '" + gs_user_id + "')"
					ls_ext_sql = " and (ctx_action_items.action_user in ('" + gs_user_id + "','Public'))"
					//end of modify
				case 1
					ls_other_user = trim(ls_other_user)
					if LenA(ls_other_user) > 0 then
						ls_ext_sql = " and (ctx_action_items.action_user = '" + gs_user_id + "' or ctx_action_items.action_user = '" +  ls_other_user + "')"
					else
						ls_ext_sql = " and (ctx_action_items.action_user = '" + gs_user_id + "')"
					end if
				case 2
					//<add> 06/25/2007 by: Andy
					//if lower(ls_user_id) = lower(gs_user_id) then
					//	ls_ext_sql = ""
					//else
						//All user is filtered(include ls_user_id = gs_user_id)
						//<Modify> 07/31/2007 by: Andy
						//ls_ext_sql = " and (ctx_action_items.action_user = '" + ls_user_id + "')"
						ls_ext_sql = " and (ctx_action_items.action_user in ('" + ls_user_id + "','Public'))"
						//end of modify
					//end if
					//end of add
					//comment 06/25/2007 by: Andy
					//ls_ext_sql = ""
			end choose
						
			ls_sql += "SELECT tdl_id = " + String(ll_tdl_id) + ", tdli_id = " + String(ll_tdli_id) +&
			", cnt = count(1) FROM ctx_action_items &
			 JOIN ctx_basic_info ON ctx_action_items.ctx_id = ctx_basic_info.ctx_id &
			 AND Isnull(ctx_action_items.active_status,0) >= 0" + ls_ext_sql
			
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
			//--------------------------- APPEON BEGIN ---------------------------
			//$<modify> 03.28.2007 By: Machongmin
			//$<reason> Fix a defect.
			/*
			ls_sql += "SELECT tdl_id = " + String(ll_tdl_id) + ", tdli_id = " + String(ll_tdli_id) +&
			", cnt = count(1) FROM ctx_am_action_item &
			,ctx_am_document,ctx_basic_info where ctx_am_action_item.doc_id = ctx_am_document.doc_id and ctx_am_document.ctx_id = ctx_basic_info.ctx_id &
			AND Isnull(ctx_am_action_item.active_status,0) >= 0"
			*/
			choose case ll_tdl_right
				case 0
					//<Modify> 07/31/2007 by: Andy
					//ls_ext_sql = " and (ctx_am_action_item.action_user = '" + gs_user_id + "')"
					ls_ext_sql = " and (ctx_am_action_item.action_user in ('" + gs_user_id + "','Public'))"
					//end of modify
				case 1
					ls_other_user = trim(ls_other_user)
					if LenA(ls_other_user) > 0 then
						ls_ext_sql = " and (ctx_am_action_item.action_user = '" + gs_user_id + "' or ctx_am_action_item.action_user = '" +  ls_other_user + "')"
					else
						ls_ext_sql = " and (ctx_am_action_item.action_user = '" + gs_user_id + "')"
					end if
				case 2
					//<add> 06/25/2007 by: Andy
					//if lower(ls_user_id) = lower(gs_user_id) then
					//	ls_ext_sql = ""
					//else
						//All user is filtered(include ls_user_id = gs_user_id)
						//<Modify> 07/31/2007 by: Andy
						//ls_ext_sql = " and (ctx_am_action_item.action_user = '" + ls_user_id + "')"
						ls_ext_sql = " and (ctx_am_action_item.action_user in ('" + ls_user_id + "','Public'))"
						//end of modify
					//end if
					//end of add
					//comment 06/25/2007 by: Andy
					//ls_ext_sql = ""
			end choose
						
			ls_sql += "SELECT tdl_id = " + String(ll_tdl_id) + ", tdli_id = " + String(ll_tdli_id) +&
			", cnt = count(1) FROM ctx_am_action_item &
			,ctx_am_document,ctx_basic_info where ctx_am_action_item.doc_id = ctx_am_document.doc_id and ctx_am_document.ctx_id = ctx_basic_info.ctx_id &
			AND Isnull(ctx_am_action_item.active_status,0) >= 0" + ls_ext_sql
			
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
	END CHOOSE
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 03.21.2007 By: Machongmin
	//$<reason> Fix a defect.
	/*
	IF lb_exists_term THEN ls_sql += " WHERE " + ls_sql_where
	*/
	
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

// Count total number for ToDoList from action item table
IF f_validstr(ls_sql) THEN
	DECLARE rec_cursor DYNAMIC CURSOR FOR SQLSA ;
	PREPARE SQLSA FROM :ls_sql ;
	
	OPEN DYNAMIC rec_cursor;
	
	FETCH rec_cursor INTO :ll_tdl_id, :ll_tdli_id, :ll_cnt ;
	DO WHILE sqlca.sqlcode = 0
	
		i++
		il_tdl_id[i] = ll_tdl_id
		il_tdli_id[i] = ll_tdli_id
		il_tdli_cnt[i] = ll_cnt
		
		FETCH rec_cursor INTO :ll_tdl_id, :ll_tdli_id, :ll_cnt ;
	LOOP
	
	CLOSE rec_cursor ;
END IF

// Fill Treeview
THIS.of_fill_treeview( )

// Last refreshed time
st_time.Text = "Last refreshed " + String( Now( ), "hh:mm:ss" )

//---------------------------- APPEON END ----------------------------

end event

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

SetPointer( HourGlass! )

tv_results.SetRedraw( False )

// Delete all items in the TreeView.
DO UNTIL tv_results.FindItem(RootTreeItem!, 0) = -1
    tv_results.DeleteItem( 0 )
LOOP

// Construct SQL according to term of to do item.
FOR ll_row = 1 TO dw_todoitem.Rowcount()
	ll_tdl_id = dw_todoitem.GetitemNumber( ll_row, "tdl_id" )
	ll_tdli_id = dw_todoitem.GetitemNumber( ll_row, "tdli_id" )
	ls_verbiage = dw_todoitem.GetitemString( ll_row, "verbiage" )
	ls_tdl_name = dw_todoitem.GetitemString( ll_row, "tdl_basic_info_tdl_name" )
	ls_tdl_module = dw_todoitem.GetitemString( ll_row, "tdl_basic_info_module" )
	LS_Allow_Drill_Down = dw_todoitem.GetitemString( ll_row, "Allow_Drill_Down" )
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

	// TO DO LIST
	IF ll_tdl_id_previous <> ll_tdl_id THEN
		ll_tdl_id_previous = ll_tdl_id
		
		ltv_item.label = ls_tdl_name
		ltv_item.data = ll_row
		ltv_item.Expanded	= TRUE
		ltv_item.Children = TRUE
		ltv_item.Bold = TRUE
		
		ltv_item.PictureIndex = 1
		ltv_item.SelectedPictureIndex = 2
		ll_lev1 = tv_results.InsertItemLast(0, ltv_item)
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
	
	ltv_item.PictureIndex = 3
	ltv_item.SelectedPictureIndex = 4
	ll_lev2 = tv_results.InsertItemLast(ll_lev1, ltv_item)
NEXT

tv_results.SetRedraw( True )

SetPointer( Arrow! )

Return 1

//---------------------------- APPEON END ----------------------------

end function

public function integer of_fill_tdl_data (long ll_handle);//--------------------------- APPEON BEGIN ---------------------------
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
u_dw ldw_tdl, ldw_tdl_all
TREEVIEWITEM ltv_item, ltv_item_data
LONG ll_rowcount
INTEGER li_width, li_column_width[12]

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
	
ELSE
	ls_sql_where = ""
END IF

CHOOSE CASE ls_tdl_module
	CASE "01"		//IntelliCred
		ldw_tdl = dw_tdl_intellicred
		ldw_tdl_all = dw_tdl_intellicred_all
		IF NOT f_validstr(Is_sql_intellicred) THEN
			dw_tdl_intellicred.event ue_retrieve_dddw( )
		END IF
		ls_sql = Is_sql_intellicred + ls_sql_where
	CASE "02"		//IntelliApp
		ldw_tdl = dw_tdl_intelliapp
		ldw_tdl_all = dw_tdl_intelliapp_all
		IF NOT f_validstr(Is_sql_intelliapp) THEN dw_tdl_intelliapp.event ue_retrieve_dddw( )
		ls_sql = Is_sql_intelliapp + ls_sql_where
	CASE "03"		//IntelliContract
		ldw_tdl = dw_tdl_intellicontract
		ldw_tdl_all = dw_tdl_intellicontract_all
		IF NOT f_validstr(Is_sql_intellicontract) THEN dw_tdl_intellicontract.event ue_retrieve_dddw( )
		ls_sql = Is_sql_intellicontract + ls_sql_where
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 03.21.2007 By: Machongmin
	//$<reason> Fix a defect.
	case "04"
		ldw_tdl = dw_document
		ldw_tdl_all = dw_document_all
		IF NOT f_validstr(Is_sql_document) THEN dw_document.event ue_refresh_dddw( )
		ls_sql = Is_sql_document + ls_sql_where
		
	//---------------------------- APPEON END ----------------------------
END CHOOSE

// Retrive To Do List data
ldw_tdl.Reset()
ldw_tdl.SetFilter( "" )

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.10.2007 By: Davis
//$<reason> The To Do List should always sort by the first column. 
String ls_sort
FOR j = 1 TO 12
	ls_sort = dw_todoitem.GetitemString(ll_row, "Display" + String(j,"00"))
	IF f_validstr(ls_sort) THEN
		ldw_tdl.Setsort( ls_sort )
		EXIT
	END IF
END FOR
//---------------------------- APPEON END ----------------------------

ldw_tdl.Modify('datawindow.table.select = "' + ls_sql + '"')
ll_rowcnt = ldw_tdl.Retrieve( )
IF ll_rowcnt = 0 THEN
	DEBUGBREAK();
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
	FOR j = 1 TO 12
		IF NOT f_validstr(ls_column[j]) THEN CONTINUE

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
	ltv_item.data = i + ll_rowcount
	ltv_item.PictureIndex = 5
	ltv_item.SelectedPictureIndex = 6
	tv_results.InsertItemLast(ll_handle, ltv_item)

END FOR

tv_results.SetRedraw( True )

SetPointer( Arrow! )

Return 1

//---------------------------- APPEON END ----------------------------

end function

public function integer of_fill_report (datawindow adw);//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.28.2006 By: Davis
//$<reason> To retrieve to do list item.

LONG ll_row,ll_rowcnt
STRING ls_tdl_module
STRING ls_tdl_name
STRING ls_verbiage
LONG ll_tdl_id, ll_tdl_id_previous
LONG ll_tdli_id
u_dw ldw_tdl
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
SetPointer( HourGlass! )

// Check dw data
IF UpperBound(is_filter) = 0 THEN RETURN 0

adw.SetRedraw( False )

// Delete all items in the TreeView.
adw.Reset()

// Construct SQL that where condition
FOR ll_row = 1 TO dw_todoitem.Rowcount()
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 03.27.2007 By: Machongmin
	//$<reason> Fix a defect.	
	ls_sql1 = ''
	ls_sql2 = ''
	ls_sql3 = ''
	ls_sql4 = ''
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
	END CHOOSE
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.27.2007 By: Machongmin
//$<reason> Fix a defect.		
//END FOR
//---------------------------- APPEON END ----------------------------
// Retrieve dw
gnv_appeondb.of_startqueue( )

IF f_validstr(ls_sql1) THEN
	IF NOT f_validstr(Is_sql_intellicred) THEN dw_tdl_intellicred.event ue_retrieve_dddw( )
	ls_sql1 = Is_sql_intellicred + " WHERE " + ls_sql1

	dw_tdl_intellicred.Reset()
	dw_tdl_intellicred.Modify('datawindow.table.select = "' + ls_sql1 + '"')
	dw_tdl_intellicred.Retrieve( )
END IF

IF f_validstr(ls_sql2) THEN
	IF NOT f_validstr(Is_sql_intelliapp) THEN dw_tdl_intelliapp.event ue_retrieve_dddw( )
	ls_sql2 = Is_sql_intelliapp + " WHERE " + ls_sql2

	dw_tdl_intelliapp.Reset()
	dw_tdl_intelliapp.Modify('datawindow.table.select = "' + ls_sql2 + '"')
	dw_tdl_intelliapp.Retrieve( )
END IF

IF f_validstr(ls_sql3) THEN
	IF NOT f_validstr(Is_sql_intellicontract) THEN dw_tdl_intellicontract.event ue_retrieve_dddw( )
	ls_sql3 = Is_sql_intellicontract + " where " + ls_sql3

	dw_tdl_intellicontract.Reset()
	dw_tdl_intellicontract.Modify('datawindow.table.select = "' + ls_sql3 + '"')
	dw_tdl_intellicontract.Retrieve( )
END IF
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.27.2007 By: Machongmin
//$<reason> Fix a defect.	
IF f_validstr(ls_sql4) THEN
	IF NOT f_validstr(Is_sql_document) THEN dw_document.event ue_refresh_dddw( )
	ls_sql4 = Is_sql_document + " and (" + ls_sql4 + ")"

	dw_document.Reset()
	dw_document.Modify('datawindow.table.select = "' + ls_sql4 + '"')
	dw_document.Retrieve( )
else
	if ls_sql4 = "" then
		IF NOT f_validstr(Is_sql_document) THEN dw_document.event ue_refresh_dddw( )
		ls_sql4 = Is_sql_document
	
		dw_document.Reset()
		dw_document.Modify('datawindow.table.select = "' + ls_sql4 + '"')
		dw_document.Retrieve( )
	end if
END IF
//---------------------------- APPEON END ----------------------------
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
iw_contract.tab_contract_details.tabpage_search.ids_search.SetFilter('')
iw_contract.tab_contract_details.tabpage_search.ids_search.Filter()
IF iw_contract.tab_contract_details.tabpage_search.ids_search.Find("ctx_id = " + String(ll_ctx_id), 1, iw_contract.tab_contract_details.tabpage_search.ids_search.RowCount()) <= 0 THEN
	Messagebox(title, 'Access denied for contract ' +string(ll_ctx_id)+ '. Contact the contract owner.')
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
	Messagebox(title, "Access denied for IntelliContract Folder->" + ls_tab_name + " tab.")
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

public function integer of_run_action (integer ai_action, string as_sql_where);//--------------------------- APPEON BEGIN ---------------------------
//$<add> 12.06.2006 By: Davis
//$<reason> Open action item window.

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

public function integer of_goto_practitioner (long ll_prac_id, long ll_facility_id, long ll_parent_facility_id, long ll_rec_id, long ll_seq_no, string ls_moveto, string ls_action);//--------------------------- APPEON BEGIN ---------------------------
//$<add> 12.11.2006 By: Davis
//$<reason> The system will bring the user into the area selected in 
//$<reason> the Move To field in the To Do List Painter and then click a menu option 
//$<reason> if a value was selected in the Perform Function field in the To Do List.

//Initiate serach
IF iw_prac.tab_1.Selectedtab <> 1 THEN
	iw_prac.tab_1.SelectTab( 1 )
END IF

// Find appropriate practitioner
pfc_cst_u_extended_search luo_search
luo_search = iw_prac.tab_1.tabpage_search.uo_search

luo_search.dw_org_facility_select.SetItem( 1, "facility_id", 0 )
luo_search.ddlb_search_type.Text = "Last Name"
luo_search.sle_srch_val.Text = ""
luo_search.cb_search.TriggerEvent(Clicked!)

// Check rights
Long ll_row
ll_row = luo_search.dw_search.Find("prac_id = " + String(ll_prac_id) + " AND parent_facility_id = " +&
		String(ll_parent_facility_id), 1, luo_search.dw_search.RowCount())
IF ll_row <=0 THEN
	Messagebox(title, "The #" + String(ll_prac_id) + " practitioner does not exist!")
	RETURN 0
END IF

luo_search.dw_search.Setrow(ll_row)
luo_search.dw_search.ScrollTorow(ll_row)

// Go to tabpage
Choose Case ls_moveto
	Case "01"		//Credentialing Tab
		iw_prac.tab_1.SelectTab( 2 )
	Case "02"		//App Audit Tab
		iw_prac.tab_1.SelectTab( 3 )
	Case "03"		//Appointment Status->Detail 1 Tab
		iw_prac.tab_1.SelectTab( 4 )
		iw_prac.tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.Post SelectTab ( 2 )
	Case "04"		//Appointment Status->Detail 2 Tab
		iw_prac.tab_1.SelectTab( 4 )
		iw_prac.tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.Post SelectTab ( 3 )
	Case "05"		//Verification Status->Browse Tab
		iw_prac.tab_1.SelectTab( 5 )
		iw_prac.tab_1.tabpage_verif.uo_verif_summary.tab_view.Post SelectTab ( 1 )
	Case "06"		//Verification Status->Detail Tab
		iw_prac.tab_1.SelectTab( 5 )
		iw_prac.tab_1.tabpage_verif.uo_verif_summary.tab_view.Post SelectTab ( 2 )
	Case "07"		//Verification Status->Recred Tab
		iw_prac.tab_1.SelectTab( 5 )
		iw_prac.tab_1.tabpage_verif.uo_verif_summary.tab_view.Post SelectTab ( 3 )
	Case "08"		//Application Status->Detail Tab
		iw_prac.tab_1.SelectTab( 9 )
		iw_prac.tab_1.tabpage_net.uo_net.tab_1.SelectTab ( 1 )
	Case "09"		//Application Status->Id's Tab
		iw_prac.tab_1.SelectTab( 9 )
		iw_prac.tab_1.tabpage_net.uo_net.tab_1.SelectTab ( 2 )
	Case "10"		//Privileges->Browse
		iw_prac.tab_1.SelectTab( 8 )
		iw_prac.tab_1.tabpage_privileges.uo_priv.tab_1.Post SelectTab ( 1 )
	Case "11"		//Privileges->Detail
		iw_prac.tab_1.SelectTab( 8 )
		iw_prac.tab_1.tabpage_privileges.uo_priv.tab_1.Post SelectTab ( 2 )
	Case "12"		//Privileges->Expiring
		iw_prac.tab_1.SelectTab( 8 )
		iw_prac.tab_1.tabpage_privileges.uo_priv.tab_1.Post SelectTab ( 3 )
End Choose

// Perform action
THIS.Post Of_goto_practitioner_action( ll_prac_id, ll_facility_id, ll_parent_facility_id, ll_rec_id, ll_seq_no, ls_moveto, ls_action )

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

public subroutine of_item_changed (long handle);//--------------------------- APPEON BEGIN ---------------------------
//$<add> 12.01.2006 By: Davis
//$<reason> Implement Dashboard.

LONG ll_tvi, ll_tvi2
LONG ll_row
TREEVIEWITEM ltv_item, ltv_item2
STRING ls_tdl_module
LONG ll_wf_id, ll_wf_step_id
STRING ls_module, ls_filter
Datawindow ldw
LONG ll_action_status
LONG ll_lookup_code
STRING ls_wf_complete_flag
LONG ll_active_status

// Check treeview item
ll_tvi = tv_results.FindItem(CurrentTreeItem!, 0)
IF ll_tvi <= 0 THEN RETURN

tv_results.Getitem( ll_tvi, ltv_item)
CHOOSE CASE ltv_item.level
	CASE 1	// To Do List level
		dw_action_status.Hide( )
	CASE 2	// To Do Item level
		dw_action_status.Hide( )
	CASE 3	// Drill Down record level
		// Get info of To Do Item Level
		ll_tvi2 = tv_results.FindItem(ParentTreeItem!, ll_tvi)
		IF ll_tvi2 <= 0 THEN RETURN

		tv_results.Getitem( ll_tvi2, ltv_item2)
		ll_row = Long( ltv_item2.Data )
		ls_tdl_module = dw_todoitem.GetitemString( ll_row, "tdl_basic_info_module" )

		// Get Info of current action item
		ls_module = dw_action_status.GetitemString(1, "module")

		// Get info of Drill Down Record Level
		ll_row = Long( ltv_item.Data )
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
		dw_action_status.SetItem( 1, "action_status", ll_action_status)
		
		dw_action_status.Show( )
		
		// Added by davis 01.05.2007
		ls_wf_complete_flag = ldw.GetItemString(ll_row, "wf_complete_flag")
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
		END CHOOSE
		
		dw_action_status.Enabled = TRUE
		IF Upper(ls_wf_complete_flag) = 'Y' OR ll_active_status < 0 THEN
			dw_action_status.Enabled = FALSE
		END IF
END CHOOSE

//---------------------------- APPEON END ----------------------------

end subroutine

public function integer of_document ();return 0
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
	case '31'
		iw_contract.tab_contract_details.tabpage_images.tab_1.post selecttab(3)
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

on w_todolist_bak.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.dw_document=create dw_document
this.dw_document_all=create dw_document_all
this.cb_save=create cb_save
this.dw_action_status=create dw_action_status
this.st_time=create st_time
this.dw_tdl_intellicred_all=create dw_tdl_intellicred_all
this.cb_refresh=create cb_refresh
this.cb_go=create cb_go
this.cb_print=create cb_print
this.dw_facility=create dw_facility
this.dw_tdl_intelliapp_all=create dw_tdl_intelliapp_all
this.dw_tdl_intelliapp=create dw_tdl_intelliapp
this.dw_tdl_intellicred=create dw_tdl_intellicred
this.dw_todoitem=create dw_todoitem
this.dw_tdl_intellicontract_all=create dw_tdl_intellicontract_all
this.tv_results=create tv_results
this.dw_tdl_intellicontract=create dw_tdl_intellicontract
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_document
this.Control[iCurrent+3]=this.dw_document_all
this.Control[iCurrent+4]=this.cb_save
this.Control[iCurrent+5]=this.dw_action_status
this.Control[iCurrent+6]=this.st_time
this.Control[iCurrent+7]=this.dw_tdl_intellicred_all
this.Control[iCurrent+8]=this.cb_refresh
this.Control[iCurrent+9]=this.cb_go
this.Control[iCurrent+10]=this.cb_print
this.Control[iCurrent+11]=this.dw_facility
this.Control[iCurrent+12]=this.dw_tdl_intelliapp_all
this.Control[iCurrent+13]=this.dw_tdl_intelliapp
this.Control[iCurrent+14]=this.dw_tdl_intellicred
this.Control[iCurrent+15]=this.dw_todoitem
this.Control[iCurrent+16]=this.dw_tdl_intellicontract_all
this.Control[iCurrent+17]=this.tv_results
this.Control[iCurrent+18]=this.dw_tdl_intellicontract
end on

on w_todolist_bak.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.dw_document)
destroy(this.dw_document_all)
destroy(this.cb_save)
destroy(this.dw_action_status)
destroy(this.st_time)
destroy(this.dw_tdl_intellicred_all)
destroy(this.cb_refresh)
destroy(this.cb_go)
destroy(this.cb_print)
destroy(this.dw_facility)
destroy(this.dw_tdl_intelliapp_all)
destroy(this.dw_tdl_intelliapp)
destroy(this.dw_tdl_intellicred)
destroy(this.dw_todoitem)
destroy(this.dw_tdl_intellicontract_all)
destroy(this.tv_results)
destroy(this.dw_tdl_intellicontract)
end on

event pfc_preopen;call super::pfc_preopen;string ls_scale
long 	  ll_i

this.of_SetResize(TRUE)

this.inv_resize.of_SetOrigSize (this.workspacewidth( ) ,  this.workspaceheight( ) )
ls_scale = this.inv_resize.scale

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// The search user object
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

FOR LL_I =  1 TO UPPERBOUND(this.CONTrol)
   this.inv_resize.of_Register (this.CONTrol[LL_I]  , ls_scale	 )
NEXT
end event

event open;call super::open;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 12.07.2006 By: Davis
//$<reason> Retrieve dddw.

// Check product.
n_cst_tdl_function lnvo_tdl_function
lnvo_tdl_function.of_get_module( is_module[])

// Retrieve dddw.
DataWindowChild dwchild,dwchild_user

gnv_appeondb.of_startqueue( )

dw_facility.GetChild( "facility_id", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve(gs_user_id)

dw_facility.GetChild( "user_id", dwchild_user )
dwchild_user.SetTransObject( SQLCA )
dwchild_user.Retrieve(gs_user_id)

dw_todoitem.SetTransObject( SQLCA )
dw_todoitem.Retrieve(gs_user_id, is_module)

gnv_appeondb.of_commitqueue( )

dwchild.InsertRow(1)
dwchild.SetItem( 1, "facility_name", "All" )
dwchild.SetItem( 1, "facility_id", 0 )

dw_facility.SetTransObject( SQLCA )
dw_facility.InsertRow( 0 )

dw_facility.SetItem( 1, "facility_id", 0 )
dw_facility.SetItem( 1, "user_id", gs_user_id )

IF gb_contract_version THEN
	IF dwchild_user.Rowcount( ) <= 1 THEN
		dw_facility.visible = FALSE
		tv_results.y -= 200
		tv_results.Height += 200
	ELSE
		dw_facility.Modify( "t_1.visible=0 facility_id.visible=0")
		dw_facility.Modify( "t_2.x=50 user_id.x=50")
	END IF
ELSE
	IF dwchild_user.Rowcount( ) <= 1 THEN
		dw_facility.Modify( "t_2.visible=0 user_id.visible=0")
	END IF
END IF

This.PostEvent("ue_retrieve_todolist")

//---------------------------- APPEON END ----------------------------

end event

event activate;call super::activate;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-12-14 By: Allen
//$<reason> Refresh Menu
If w_mdi.menuname <> "m_pfe_cst_mdi_menu" Then
	w_mdi.ChangeMenu( m_pfe_cst_mdi_menu )
	w_mdi.of_menu_security( w_mdi.MenuName )
END IF
//---------------------------- APPEON END ----------------------------
end event

type cb_1 from commandbutton within w_todolist_bak
integer x = 2482
integer y = 1476
integer width = 315
integer height = 88
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;close(parent)
end event

type dw_document from u_dw within w_todolist_bak
event ue_refresh_dddw ( )
boolean visible = false
integer x = 416
integer y = 920
integer width = 1691
integer height = 488
integer taborder = 160
boolean bringtotop = true
boolean titlebar = true
string dataobject = "d_tdl_document_all"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean resizable = true
end type

event ue_refresh_dddw();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.21.2007 By:machongmin
//$<reason> Initialize datawindow.

This.SettransObject( SQLCA )

// Initialize syntax of dw
Is_sql_document = dw_document.getsqlselect( )

// Set DDDW DATA
datawindowchild dwchild

// Action Item
This.GetChild( "action_type", dwchild )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Contract Action Type') = upper(lookup_name)", dwchild)

This.GetChild( "action_status", dwchild )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Contract Action Status') = upper(lookup_name)", dwchild)

// CTX Basic Info
This.GetChild( "ctx_basic_info_status", dwchild )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Contract Status') = upper(lookup_name)", dwchild)

This.GetChild( "ctx_basic_info_category", dwchild )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Contract Category') = upper(lookup_name)", dwchild)

//ctx_basic_info_app_facility

This.GetChild( "ctx_basic_info_contract_type", dwchild )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Contract Type') = upper(lookup_name)", dwchild)

This.GetChild( "ctx_basic_info_dvision", dwchild )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Contract Division') = upper(lookup_name)", dwchild)


//---------------------------- APPEON END ----------------------------


end event

event constructor;call super::constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.26.2007 By: MaChongmin
//$<reason> Implement dashbord.

This.of_setupdateable( False )

//---------------------------- APPEON END ----------------------------


end event

type dw_document_all from u_dw within w_todolist_bak
boolean visible = false
integer x = 402
integer y = 336
integer width = 1691
integer height = 480
integer taborder = 140
boolean titlebar = true
string dataobject = "d_tdl_document_all"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean resizable = true
end type

event constructor;call super::constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.26.2007 By: MaChongmin
//$<reason> Implement dashbord.

This.of_setupdateable( False )

//---------------------------- APPEON END ----------------------------


end event

type cb_save from commandbutton within w_todolist_bak
integer x = 1221
integer y = 1476
integer width = 315
integer height = 88
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "&Save"
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
Long ll_action_status
String ls_reference_value
Long ll_exp_credential_flag
Long ll_tvi
Long ll_row
TREEVIEWITEM ltv_item
str_action_item lstr_action[1]
n_cst_workflow_triggers    lnv_trigger

// Check treeview item
ll_tvi = tv_results.FindItem(CurrentTreeItem!, 0)
If ll_tvi <= 0 Then Return

tv_results.GetItem( ll_tvi, ltv_item)
If ltv_item.Level <> 3 Then Return

//IF messagebox('Modify Action Status', 'Are you sure you want to modify the action status?',question!,YesNo!,2) = 2 THEN
//	RETURN 1
//END IF

// Get Info of current action item
ls_module = dw_action_status.GetItemString(1, "module")
ll_action_status = dw_action_status.GetItemNumber(1, "action_status")
ll_row = Long( ltv_item.Data )
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
			
			lnv_trigger = Create n_cst_workflow_triggers
			lnv_trigger.of_status_changed( lstr_action[1] )
			
			//Create Work Flow By Action Item Changed
			lnv_trigger.of_workflow_triggers(lstr_action)
		End If
	Case "02" // IntelliApp
		ll_rec_id = dw_tdl_intelliApp_all.GetItemNumber( ll_row, "rec_id" )
		
		gnv_appeondb.of_autocommit( )
		Update net_dev_action_items
			Set action_status = :ll_action_status
			, action_date = getdate()
			Where rec_id = :ll_rec_id;
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
			
			lnv_trigger = Create n_cst_workflow_triggers
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
			If lstr_action[1].wf_id > 0 And dw_tdl_intellicontract_all.GetItemString(ll_row,"wf_complete_flag") = "N" Then
				lstr_action[1].wf_step_id = dw_tdl_intellicontract_all.GetItemNumber(ll_row,"wf_action_type_id")
				lstr_action[1].notes = dw_tdl_intellicontract_all.GetItemString(ll_row,"ctx_action_items_notes")
				lstr_action[1].status_changed_flag = True
			End If
			
			lnv_trigger = Create n_cst_workflow_triggers
			lnv_trigger.of_status_changed( lstr_action[1] )
			
			//Create Work Flow By Action Item Changed
			lnv_trigger.of_workflow_triggers(lstr_action)
		End If
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 03.26.2007 By: Machongmin
		//$<reason> Fix a defect.	
	Case "04"
		
		Long ll_doc_id
		Long ll_seq_id
		ll_doc_id = dw_document_all.GetItemNumber( ll_row, "doc_id")
		ll_seq_id = dw_document_all.GetItemNumber( ll_row, "seq_id")
		
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
			If lstr_action[1].wf_id > 0 And dw_document_all.GetItemString(ll_row,"wf_complete_flag") = "N" Then
				lstr_action[1].wf_step_id = dw_document_all.GetItemNumber(ll_row,"wf_action_type_id")
				lstr_action[1].notes = dw_document_all.GetItemString(ll_row,"notes")
				lstr_action[1].status_changed_flag = True
			End If
			
			lnv_trigger = Create n_cst_workflow_triggers
			lnv_trigger.of_status_changed( lstr_action[1] )
			
			//Create Work Flow By Action Item Changed
			lnv_trigger.of_workflow_triggers(lstr_action)
		End If
		//---------------------------- APPEON END ----------------------------	
		
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

ll_Parent = tv_results.FindItem( parenttreeitem!, ll_tvi)

tv_results.GetItem(ll_Parent,tv_parent)
ll_ParentRow = Long(tv_parent.Data)
ll_actionStatus = dw_todoitem.GetItemNumber(ll_ParentRow,'action_status')
If ll_actionStatus > 0 Then
	ls_Label = dw_todoitem.GetItemString(ll_ParentRow,'verbiage')
	
	Int  li_Pos,li_old_Number,li_PosBlank
	string ls_LabelPostfix,ls_LabelPrefix,ls_NewLabel
	
	li_Pos = PosA(ls_Label,'##')
	If li_Pos > 0 Then
		ls_LabelPostfix = MidA(ls_Label,li_Pos+2)
		ls_LabelPrefix = LeftA(ls_Label,li_pos -1)
		
		li_PosBlank = PosA(tv_parent.Label,' ',li_Pos+1)
		If li_PosBlank < 1 Then 
			li_PosBlank = li_Pos
			DO WHILE isNumber(MidA(tv_parent.Label,li_PosBlank+1,1))
				li_PosBlank++
			LOOP
		END IF
		
		li_old_Number = Integer(MidA(tv_parent.Label,li_Pos,li_PosBlank - li_Pos + 1))
		
		ls_NewLabel = ls_LabelPrefix+String(li_old_Number - 1)+ls_LabelPostfix//Mid(tv_parent.Label,li_PosBlank)
		
		tv_parent.Label = ls_NewLabel
		tv_results.SetItem(ll_Parent,tv_parent)
	End If
	dw_action_status.Hide()
	
	tv_results.DeleteItem(ll_tvi)
	ll_tvi = tv_results.FindItem(CurrentTreeItem!, 0)
	Parent.of_item_changed( ll_tvi)
	tv_results.post setfocus()
ELSE
	datawindow  ldw
	
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
	END CHOOSE

	ldw.SetItem(ll_row, "action_status",ll_action_status)
End If
//---------------------------- APPEON END ----------------------------


This.Enabled = False
//---------------------------- APPEON END ----------------------------


end event

type dw_action_status from u_dw within w_todolist_bak
boolean visible = false
integer x = 23
integer y = 1420
integer width = 960
integer height = 160
integer taborder = 30
string dataobject = "d_tdl_action_status_changes"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
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

type st_time from statictext within w_todolist_bak
boolean visible = false
integer x = 1714
integer width = 681
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_tdl_intellicred_all from u_dw within w_todolist_bak
boolean visible = false
integer x = 393
integer y = 300
integer width = 1691
integer height = 264
integer taborder = 110
boolean bringtotop = true
boolean titlebar = true
string dataobject = "d_tdl_intellicred"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean resizable = true
end type

event constructor;call super::constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.28.2006 By: Davis
//$<reason> Implement dashbord.

This.of_setupdateable( False )

//---------------------------- APPEON END ----------------------------


end event

type cb_refresh from commandbutton within w_todolist_bak
integer x = 2167
integer y = 1476
integer width = 315
integer height = 88
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Refresh"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 12.06.2006 By: Davis
//$<reason> Refresh To do list.

String ls_user_id

// Check product.
n_cst_tdl_function lnvo_tdl_function
lnvo_tdl_function.of_get_module( is_module[])

ls_user_id = dw_facility.GetItemString(1, "user_id")
IF NOT f_validstr(ls_user_id) THEN ls_user_id = gs_user_id
	
dw_todoitem.Retrieve(ls_user_id, is_module)

Parent.PostEvent("ue_retrieve_todolist")

//---------------------------- APPEON END ----------------------------

end event

type cb_go from commandbutton within w_todolist_bak
integer x = 1536
integer y = 1476
integer width = 315
integer height = 88
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Go"
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

PowerObject lpo_NullParm

//////////////  DONT DELETE /////////
ib_doubleclick = FALSE
////////////////////////////////////

// Check treeview item
ll_tvi = tv_results.FindItem(CurrentTreeItem!, 0)
IF ll_tvi <= 0 THEN RETURN 0

tv_results.Getitem( ll_tvi, ltv_item)

CHOOSE CASE ltv_item.level
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
		END CHOOSE

	CASE 3	// Drill Down record level
		
		// Get info of To Do Item Level
		ll_tvi2 = tv_results.FindItem(ParentTreeItem!, ll_tvi)
		IF ll_tvi2 <= 0 THEN RETURN 0

		tv_results.Getitem( ll_tvi2, ltv_item2)
		ll_row = Long( ltv_item2.Data )
		ls_moveto = dw_todoitem.GetitemString( ll_row, "moveto" )
		IF NOT f_validstr(ls_moveto) THEN RETURN
		
		ls_action = dw_todoitem.GetitemString( ll_row, "perform" )
		
		ls_tdl_module = dw_todoitem.GetitemString( ll_row, "tdl_basic_info_module" )

		// Get info of Drill Down Record Level
		ll_row = Long( ltv_item.Data )
		CHOOSE CASE ls_tdl_module
			CASE "01","02"		//IntelliCred & IntelliApp
				IF ls_tdl_module = "01" THEN
					ll_prac_id = dw_tdl_intelliCred_all.GetitemNumber( ll_row, "prac_id" )
					ll_facility_id = dw_tdl_intelliCred_all.GetitemNumber( ll_row, "facility_id" )
					ll_rec_id = dw_tdl_intelliCred_all.GetitemNumber( ll_row, "rec_id" )
					ll_seq_no = dw_tdl_intelliCred_all.GetitemNumber( ll_row, "verif_info_seq_no" )
					ll_parent_facility_id = dw_tdl_intelliCred_all.GetitemNumber( ll_row, "pd_affil_stat_parent_facility_id" )
				ELSE
					ll_prac_id = dw_tdl_intelliapp_all.GetitemNumber( ll_row, "prac_id" )
					ll_facility_id = dw_tdl_intelliapp_all.GetitemNumber( ll_row, "facility_id" )
					ll_rec_id = dw_tdl_intelliapp_all.GetitemNumber( ll_row, "rec_id" )
					ll_seq_no = dw_tdl_intelliapp_all.GetitemNumber( ll_row, "net_dev_action_items_seq_no" )
					ll_parent_facility_id = ll_facility_id
				END IF
				
				// Open the practitioner window
				IF gs_cust_type = "I" THEN
					IF NOT Isvalid(w_prac_data_intelliapp) THEN
						OpenSheet( w_prac_data_intelliapp, w_mdi, 4, original!)
						w_prac_data_intelliapp.move(0,0)
						w_prac_data_intelliapp.BringToTop = TRUE
					END IF
					
					iw_prac = w_prac_data_intelliapp
				ELSE
					IF NOT Isvalid(w_prac_data_intelliapp) THEN
						OpenSheet( w_prac_data_1, w_mdi, 4, original!)
					END IF
					
					iw_prac = w_prac_data_1
				END IF
				iw_prac.BringToTop = TRUE

				Parent.post of_goto_practitioner( ll_prac_id, ll_facility_id, ll_parent_facility_id, ll_rec_id, ll_seq_no, ls_moveto, ls_action)
			CASE "03"		//IntelliContract
				ll_ctx_id = dw_tdl_intellicontract_all.GetitemNumber( ll_row, "ctx_id")
				IF Isnull(ll_ctx_id) OR ll_ctx_id = 0 THEN RETURN

				//Open the Contract window
				IF NOT Isvalid(gw_contract) THEN
					/*window child
					OpenSheet(child, "w_contract", w_mdi, 4, original!)*/
					gf_OpenContractFolder(lpo_NullParm)					//Modified by Scofield on 2008-11-19
				END IF
				
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

				//Open the Contract window
				IF NOT Isvalid(gw_contract) THEN
					//OpenSheet(child, "w_contract", w_mdi, 4, original!)
					gf_OpenContractFolder(lpo_NullParm)					//Modified by Scofield on 2008-11-19
				END IF
				
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
					case '29'
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
END CHOOSE

//---------------------------- APPEON END ----------------------------

end event

type cb_print from commandbutton within w_todolist_bak
integer x = 1851
integer y = 1476
integer width = 315
integer height = 88
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Print Report"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 12.01.2006 By: Davis
//$<reason> Implement Dashboard.

Open( w_todolist_report )

//---------------------------- APPEON END ----------------------------

end event

type dw_facility from u_dw within w_todolist_bak
integer x = 18
integer width = 1655
integer height = 232
integer taborder = 10
string dataobject = "d_tdl_facility_user"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.28.2006 By: Davis
//$<reason> Implement dashbord.

this.of_setupdateable( false)

//---------------------------- APPEON END ----------------------------

end event

event itemchanged;call super::itemchanged;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.29.2006 By: Davis
//$<reason> Filter faciltiy for TODoList.

IF This.GetColumnName() = "facility_id" THEN	

	il_facility_id = Integer( data )
	parent.PostEvent("ue_retrieve_todolist")

ELSEIF This.GetColumnName() = "user_id" THEN
	
	DataWindowChild dwchild
	String ls_user_id

	ls_user_id = String( data )

	dw_facility.GetChild( "facility_id", dwchild )
	dwchild.SetTransObject( SQLCA )
	
	gnv_appeondb.of_startqueue( )

	dwchild.Retrieve( ls_user_id )
	dw_todoitem.Retrieve( ls_user_id, is_module )
	
	gnv_appeondb.of_commitqueue( )

	dwchild.InsertRow(1)
	dwchild.SetItem( 1, "facility_name", "All" )
	dwchild.SetItem( 1, "facility_id", 0 )

	il_facility_id = 0
	dw_facility.SetItem( 1, "facility_id", 0 )
	
	parent.PostEvent("ue_retrieve_todolist")
END IF

//---------------------------- APPEON END ----------------------------

end event

type dw_tdl_intelliapp_all from u_dw within w_todolist_bak
boolean visible = false
integer x = 453
integer y = 500
integer width = 1691
integer height = 264
integer taborder = 120
boolean titlebar = true
string dataobject = "d_tdl_intelliapp"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean resizable = true
end type

event constructor;call super::constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.28.2006 By: Davis
//$<reason> Implement dashbord.

This.of_setupdateable( False )

//---------------------------- APPEON END ----------------------------


end event

type dw_tdl_intelliapp from u_dw within w_todolist_bak
event ue_retrieve_dddw ( )
boolean visible = false
integer x = 457
integer y = 692
integer width = 1691
integer height = 264
integer taborder = 100
boolean bringtotop = true
boolean titlebar = true
string dataobject = "d_tdl_intelliapp"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean resizable = true
end type

event ue_retrieve_dddw();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.28.2006 By: Davis
//$<reason> Initialize datawindow.

This.SettransObject( SQLCA )

// Initialize syntax of dw
Is_sql_intelliapp = dw_tdl_intelliapp.getsqlselect( )

// Set DDDW DATA
datawindowchild dwchild

// Practitional Basic info
This.GetChild( "pd_basic_prac_category", dwchild )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Practitioner Category') = upper(lookup_name)", dwchild)

This.GetChild( "pd_basic_name_suffix", dwchild )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Name Suffix') = upper(lookup_name)", dwchild)

This.GetChild( "pd_basic_prof_suffix", dwchild )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Professional Suffix') = upper(lookup_name)", dwchild)


// Application Status
This.GetChild( "net_dev_action_items_action_dept", dwchild )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Action Department') = upper(lookup_name)", dwchild)

This.GetChild( "action_status", dwchild )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Action Status') = upper(lookup_name)", dwchild)

This.GetChild( "action_type", dwchild )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Action Type') = upper(lookup_name)", dwchild)

//---------------------------- APPEON END ----------------------------


end event

event constructor;call super::constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.28.2006 By: Davis
//$<reason> Implement dashbord.

This.of_setupdateable( False )

//---------------------------- APPEON END ----------------------------


end event

type dw_tdl_intellicred from u_dw within w_todolist_bak
event ue_retrieve_dddw ( )
boolean visible = false
integer x = 457
integer y = 412
integer width = 1691
integer height = 264
integer taborder = 90
boolean bringtotop = true
boolean titlebar = true
string dataobject = "d_tdl_intellicred"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean resizable = true
end type

event ue_retrieve_dddw();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.28.2006 By: Davis
//$<reason> Initialize datawindow.

This.SettransObject( SQLCA )

// Initialize syntax of dw
Is_sql_intellicred = dw_tdl_intellicred.getsqlselect( )

// Set DDDW DATA
datawindowchild dwchild

// Practitional Basic info
This.GetChild( "pd_basic_prac_category", dwchild )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Practitioner Category') = upper(lookup_name)", dwchild)

This.GetChild( "pd_basic_name_suffix", dwchild )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Name Suffix') = upper(lookup_name)", dwchild)

This.GetChild( "pd_basic_prof_suffix", dwchild )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Professional Suffix') = upper(lookup_name)", dwchild)


// Verification Status
This.GetChild( "action_type", dwchild )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Verification Method') = upper(lookup_name)", dwchild)

This.GetChild( "action_status", dwchild )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('credentials verification response') = upper(lookup_name)", dwchild)


//Affiliation Status
This.GetChild( "pd_affil_stat_affiliation_status", dwchild )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Affiliation Status') = upper(lookup_name)", dwchild)

//pd_affil_stat_parent_facility_id facility 3

// Department
This.GetChild( "pd_affil_dept_department", dwchild )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('department') = upper(lookup_name)", dwchild)

This.GetChild( "pd_affil_dept_rank", dwchild )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('division') = upper(lookup_name)", dwchild)

This.GetChild( "pd_affil_dept_section", dwchild )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('section') = upper(lookup_name)", dwchild)

// Staff category
This.GetChild( "pd_affil_staff_cat_staff_category", dwchild )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('staff category') = upper(lookup_name)", dwchild)

//---------------------------- APPEON END ----------------------------


end event

event constructor;call super::constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.28.2006 By: Davis
//$<reason> Implement dashbord.

This.of_setupdateable( False )

//---------------------------- APPEON END ----------------------------


end event

type dw_todoitem from u_dw within w_todolist_bak
boolean visible = false
integer x = 297
integer y = 384
integer width = 1691
integer height = 876
integer taborder = 80
boolean bringtotop = true
boolean titlebar = true
string dataobject = "d_tdl_painter_detail_list"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean resizable = true
end type

event constructor;call super::constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.28.2006 By: Davis
//$<reason> Implement dashbord.

This.of_setupdateable( False )

This.SettransObject( SQLCA )

//---------------------------- APPEON END ----------------------------


end event

type dw_tdl_intellicontract_all from u_dw within w_todolist_bak
boolean visible = false
integer x = 640
integer y = 844
integer width = 1691
integer height = 264
integer taborder = 150
boolean titlebar = true
string dataobject = "d_tdl_intellicontract"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean resizable = true
end type

event constructor;call super::constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.28.2006 By: Davis
//$<reason> Implement dashbord.

This.of_setupdateable( False )

//---------------------------- APPEON END ----------------------------


end event

type tv_results from u_tvs within w_todolist_bak
integer x = 27
integer y = 236
integer width = 2766
integer height = 1184
integer taborder = 20
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Courier New"
boolean haslines = false
boolean linesatroot = true
boolean hideselection = false
string picturename[] = {"Custom039!","Custom050!","Custom039!","Custom050!","ScriptNo!","ScriptYes!"}
boolean ib_rmbmenu = false
end type

event itemexpanding;call super::itemexpanding;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.29.2006 By: Davis
//$<reason> Implement Dashboard.

IF ib_doubleclick THEN RETURN 1

Parent.of_fill_tdl_data( handle )

//---------------------------- APPEON END ----------------------------

end event

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

event selectionchanged;call super::selectionchanged;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.04.2007 By: Davis
//$<reason> Implement Dashboard.

cb_save.enabled = FALSE

Parent.of_item_changed( newhandle )

//---------------------------- APPEON END ----------------------------

end event

type dw_tdl_intellicontract from u_dw within w_todolist_bak
event ue_retrieve_dddw ( )
boolean visible = false
integer x = 457
integer y = 972
integer width = 1691
integer height = 264
integer taborder = 130
boolean bringtotop = true
boolean titlebar = true
string dataobject = "d_tdl_intellicontract"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean resizable = true
end type

event ue_retrieve_dddw();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.28.2006 By: Davis
//$<reason> Initialize datawindow.

This.SettransObject( SQLCA )

// Initialize syntax of dw
Is_sql_intellicontract = dw_tdl_intellicontract.getsqlselect( )

// Set DDDW DATA
datawindowchild dwchild

// Action Item
This.GetChild( "action_type", dwchild )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Contract Action Type') = upper(lookup_name)", dwchild)

This.GetChild( "action_status", dwchild )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Contract Action Status') = upper(lookup_name)", dwchild)

// CTX Basic Info
This.GetChild( "ctx_basic_info_status", dwchild )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Contract Status') = upper(lookup_name)", dwchild)

This.GetChild( "ctx_basic_info_category", dwchild )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Contract Category') = upper(lookup_name)", dwchild)

//ctx_basic_info_app_facility

This.GetChild( "ctx_basic_info_contract_type", dwchild )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Contract Type') = upper(lookup_name)", dwchild)

This.GetChild( "ctx_basic_info_dvision", dwchild )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper('Contract Division') = upper(lookup_name)", dwchild)


//---------------------------- APPEON END ----------------------------


end event

event constructor;call super::constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.28.2006 By: Davis
//$<reason> Implement dashbord.

This.of_setupdateable( False )

//---------------------------- APPEON END ----------------------------


end event

