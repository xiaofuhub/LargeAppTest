$PBExportHeader$w_query_create.srw
forward
global type w_query_create from window
end type
type mle_syntax from multilineedit within w_query_create
end type
type cb_link from commandbutton within w_query_create
end type
type st_screen from statictext within w_query_create
end type
type cb_cancel from commandbutton within w_query_create
end type
type cb_syntax from commandbutton within w_query_create
end type
type st_syntax from statictext within w_query_create
end type
type ddlb_3 from dropdownlistbox within w_query_create
end type
type cb_reset from commandbutton within w_query_create
end type
type st_null3 from statictext within w_query_create
end type
type st_null2 from statictext within w_query_create
end type
type st_null1 from statictext within w_query_create
end type
type dw_crit3 from datawindow within w_query_create
end type
type st_rf from statictext within w_query_create
end type
type st_date3 from statictext within w_query_create
end type
type st_date2 from statictext within w_query_create
end type
type st_date1 from statictext within w_query_create
end type
type dw_v3 from datawindow within w_query_create
end type
type dw_v2 from datawindow within w_query_create
end type
type dw_v1 from datawindow within w_query_create
end type
type ddlb_2 from dropdownlistbox within w_query_create
end type
type ddlb_1 from dropdownlistbox within w_query_create
end type
type st_5 from statictext within w_query_create
end type
type st_4 from statictext within w_query_create
end type
type st_3 from statictext within w_query_create
end type
type sle_value3 from singlelineedit within w_query_create
end type
type dw_crit2 from datawindow within w_query_create
end type
type dw_crit1 from datawindow within w_query_create
end type
type sle_value2 from singlelineedit within w_query_create
end type
type sle_value1 from singlelineedit within w_query_create
end type
type cb_return from commandbutton within w_query_create
end type
type cb_setsyntax from commandbutton within w_query_create
end type
type cb_about from commandbutton within w_query_create
end type
type gb_7 from groupbox within w_query_create
end type
type gb_6 from groupbox within w_query_create
end type
type gb_5 from groupbox within w_query_create
end type
type gb_1 from groupbox within w_query_create
end type
type gb_2 from groupbox within w_query_create
end type
type dw_table from datawindow within w_query_create
end type
type dw_field from datawindow within w_query_create
end type
type gb_4 from groupbox within w_query_create
end type
type gb_3 from groupbox within w_query_create
end type
end forward

global type w_query_create from window
integer x = 78
integer y = 160
integer width = 3360
integer height = 1844
boolean titlebar = true
string title = "Query Wizard"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
boolean center = true
event ue_ctx_init ( string as_screen_alias,  string as_dataobject )
event ue_fields_init ( string as_table )
mle_syntax mle_syntax
cb_link cb_link
st_screen st_screen
cb_cancel cb_cancel
cb_syntax cb_syntax
st_syntax st_syntax
ddlb_3 ddlb_3
cb_reset cb_reset
st_null3 st_null3
st_null2 st_null2
st_null1 st_null1
dw_crit3 dw_crit3
st_rf st_rf
st_date3 st_date3
st_date2 st_date2
st_date1 st_date1
dw_v3 dw_v3
dw_v2 dw_v2
dw_v1 dw_v1
ddlb_2 ddlb_2
ddlb_1 ddlb_1
st_5 st_5
st_4 st_4
st_3 st_3
sle_value3 sle_value3
dw_crit2 dw_crit2
dw_crit1 dw_crit1
sle_value2 sle_value2
sle_value1 sle_value1
cb_return cb_return
cb_setsyntax cb_setsyntax
cb_about cb_about
gb_7 gb_7
gb_6 gb_6
gb_5 gb_5
gb_1 gb_1
gb_2 gb_2
dw_table dw_table
dw_field dw_field
gb_4 gb_4
gb_3 gb_3
end type
global w_query_create w_query_create

type variables
integer ii_table_id //alfee 01.27.2010

string is_field1
string is_field2
string is_field3
string is_fieldup
string is_table
string is_table2  //maha 10.02017
string is_field
string is_field_lookup
string is_where
string is_search
long il_v1
long il_v2
long il_v3
long il_vup
long il_resps
long il_upfield_sysid
boolean ib_is_crit = false  //maha 09.29.2017
boolean ib_is_lookup = false //maha 10.02017

string is_lookup_val
string is_lookup_type
string is_lookups[]  //maha 10.02.2017
string is_From
string is_Return = "Cancel"

DataWindowChild sys_fields_child //Added by  Nova 10.30.2009
DataWindowChild sys_fields_child2//Added by  Nova 10.30.2009
DataWindowChild sys_fields_child3//Added by  Nova 10.30.2009
end variables

forward prototypes
public function integer of_checkcriteia (boolean ab_flag)
public function string of_getfieldtype (string as_type)
public function string of_getcriteria (string as_fieldtype, string as_field, string as_operator, string as_value)
public subroutine of_dddw_insert (ref datastore ads, string as_field_name, string as_field_name_allias, string as_field_type, string as_lookup_type, string as_lookup_field, string as_lookup_code)
public subroutine of_reset_syntax (string as_link)
end prototypes

event ue_ctx_init(string as_screen_alias, string as_dataobject);//////////////////////////////////////////////////////////////////////
// $<event> ue_ctx_init
// $<arguments>
//			string	as_screen_alias
//			string	as_dataobject
// $<returns> (None)
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 04.09.2009
//////////////////////////////////////////////////////////////////////

string ls_table, ls_temp
string ls_coltype
string ls_colname, ls_label, ls_dbname
integer li_cols, i
integer li_found, li_inserted, li_getrow
datastore lds_dataobject
datawindowchild ldwc_ctxscrn

st_screen.text = "Screen Name: " + as_screen_alias
lds_dataobject = create datastore
lds_dataobject.dataobject = as_DataObject
//--------Begin Modified by  Nova 10.30.2009------------------------
//dw_crit1.dataobject = "dd_ctx_fields1001"
//dw_crit2.dataobject = "dd_ctx_fields1001"
//dw_crit3.dataobject = "dd_ctx_fields1001"

dw_crit1.dataobject = "dd_ctx_fields1001_dddw"
dw_crit2.dataobject = "dd_ctx_fields1001_dddw"
dw_crit3.dataobject = "dd_ctx_fields1001_dddw"

//--------End Modified --------------------------------------------

dw_crit1.tag = as_DataObject
dw_crit2.tag = as_DataObject
dw_crit3.tag = as_DataObject
//--------Begin Added by Nova 10.30.2009------------------------
dw_crit1.settransobject(sqlca)
dw_crit1.GetChild('field_name', sys_fields_child)
sys_fields_child.settransobject( sqlca)
dw_crit1.insertrow(1)
sys_fields_child.insertrow( 1)

dw_crit2.settransobject(sqlca)
dw_crit2.GetChild('field_name', sys_fields_child2)
sys_fields_child2.settransobject( sqlca)
dw_crit2.insertrow(1)
sys_fields_child2.insertrow( 1)

dw_crit3.settransobject(sqlca)
dw_crit3.GetChild('field_name', sys_fields_child3)
sys_fields_child3.settransobject( sqlca)
dw_crit3.insertrow(1)
sys_fields_child3.insertrow( 1)
//--------End Added --------------------------------------------

li_cols = integer( lds_dataobject.Describe( "DataWindow.Column.Count" ) )
ls_table = lower( lds_dataobject.Describe( "Datawindow.table.updatetable" ) )
is_table = ls_table

for i = 1 to li_cols
	ls_dbname = lower( lds_dataobject.Describe("#"+string( i ) + ".dbname") )
	ls_temp = f_get_token( ls_dbname, '.' )
	ls_colname = ls_dbname
	ls_coltype = lds_dataobject.Describe("#"+string( i ) + ".coltype" )
	
	ls_label = lds_dataobject.Describe( ls_colname + "_t.text")
	if ls_label = "?" or ls_label = "!" then ls_label = ""
	if ls_label = '' then ls_label = ls_dbname
	//---------Begin Modified by (Appeon)Toney 07.12.2013 for V141 ISG-CLX--------
	//$Reason:Condition fields of ctx_export needs table name prefix
	  /*
		if ls_temp = ls_table then		
	  */
	 if ls_temp <> "" and ls_colname <> "" then
		ls_colname = ls_temp+"."+ls_colname
	//---------End Modfiied ------------------------------------------------------------------	
//--------Begin Modified by  Nova 10.30.2009------------------------
//		li_inserted = dw_crit1.insertrow( 0 )
//		dw_crit1.setitem( li_inserted, "field_name", ls_colname )
//		dw_crit1.setitem( li_inserted, "field_name_alias", ls_label )		
//		dw_crit1.setitem( li_inserted, "field_datatype", ls_coltype )
		
		li_inserted=sys_fields_child.insertrow(0)
		sys_fields_child.setitem( li_inserted, "field_name", ls_colname )
		sys_fields_child.setitem( li_inserted, "field_name_alias", ls_label )		
		sys_fields_child.setitem( li_inserted, "field_datatype", ls_coltype )
		
		li_inserted=sys_fields_child2.insertrow(0)
		sys_fields_child2.setitem( li_inserted, "field_name", ls_colname )
		sys_fields_child2.setitem( li_inserted, "field_name_alias", ls_label )		
		sys_fields_child2.setitem( li_inserted, "field_datatype", ls_coltype )
		
		li_inserted=sys_fields_child3.insertrow(0)
		sys_fields_child3.setitem( li_inserted, "field_name", ls_colname )
		sys_fields_child3.setitem( li_inserted, "field_name_alias", ls_label )		
		sys_fields_child3.setitem( li_inserted, "field_datatype", ls_coltype )
//--------End Modified --------------------------------------------
		
	end if
next
//--------Begin Commented by  Nova 10.30.2009------------------------
//if dw_crit1.rowcount() > 0 then
//	dw_crit1.Rowscopy( 1, dw_crit1.rowcount(), Primary!, dw_crit2, 1, Primary! )
//	dw_crit1.Rowscopy( 1, dw_crit1.rowcount(), Primary!, dw_crit3, 1, Primary! )
//	//dw_crit1.Rowscopy( 1, dw_crit1.rowcount(), Primary!, dw_fields, 1, Primary! )
//end if
//--------End Commented --------------------------------------------

end event

event ue_fields_init(string as_table);//////////////////////////////////////////////////////////////////////
// $<event> ue_fields_init
// $<arguments>
//			string	as_table
// $<returns> (None)
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $Added by (Appeon)Harry 03.02.2015 for V151-Additional TDL Filters
//////////////////////////////////////////////////////////////////////


datastore ldw_temp
Int li_inserted

//dw_crit1.reset( )
//dw_crit2.reset( )
//dw_crit3.reset( )

st_date1.visible = false
st_date2.visible = false
st_date3.visible = false
cb_link.visible = false

ldw_temp = Create datastore
ldw_temp.dataobject = "d_dddw_sys_fields"
ldw_temp.settransobject(sqlca)

ldw_temp.reset( )

Choose Case Lower(as_table)
	Case 'verif_info'
		/*
		li_inserted = ldw_temp.insertrow(0)
		ldw_temp.setitem( li_inserted, "field_name", 'verification_method' )
		ldw_temp.setitem( li_inserted, "field_name_allias", 'Verification Method' )	
		ldw_temp.setitem( li_inserted, "field_type", 'N' )
		ldw_temp.setitem( li_inserted, "lookup_type", 'C' )
		ldw_temp.setitem( li_inserted, "lookup_field", 'Y' )
		ldw_temp.setitem( li_inserted, "lookup_code", 'Verification Method' )
		
		li_inserted = ldw_temp.insertrow(0)
		ldw_temp.setitem( li_inserted, "field_name", 'first_sent' )
		ldw_temp.setitem( li_inserted, "field_name_allias", 'First Sent' )		
		ldw_temp.setitem( li_inserted, "field_type", 'D' )
		
		li_inserted = ldw_temp.insertrow(0)
		ldw_temp.setitem( li_inserted, "field_name", 'last_sent' )
		ldw_temp.setitem( li_inserted, "field_name_allias", 'Last Sent' )		
		ldw_temp.setitem( li_inserted, "field_type", 'D' )
		
		li_inserted = ldw_temp.insertrow(0)
		ldw_temp.setitem( li_inserted, "field_name", 'number_sent' )
		ldw_temp.setitem( li_inserted, "field_name_allias", 'Number Sent' )		
		ldw_temp.setitem( li_inserted, "field_type", 'N' )
		
		li_inserted = ldw_temp.insertrow(0)
		ldw_temp.setitem( li_inserted, "field_name", 'response_code' )
		ldw_temp.setitem( li_inserted, "field_name_allias", 'Response Code' )	
		ldw_temp.setitem( li_inserted, "field_type", 'N' )
		ldw_temp.setitem( li_inserted, "lookup_type", 'C' )
		ldw_temp.setitem( li_inserted, "lookup_field", 'Y' )
		ldw_temp.setitem( li_inserted, "lookup_code", 'credentials verification response' )
		
		li_inserted = ldw_temp.insertrow(0)
		ldw_temp.setitem( li_inserted, "field_name", 'date_recieved' )
		ldw_temp.setitem( li_inserted, "field_name_allias", 'Date Recieved' )		
		ldw_temp.setitem( li_inserted, "field_type", 'D' )
		
		li_inserted = ldw_temp.insertrow(0)
		ldw_temp.setitem( li_inserted, "field_name", 'user_name' )
		ldw_temp.setitem( li_inserted, "field_name_allias", 'User Name' )		
		ldw_temp.setitem( li_inserted, "field_type", 'C' )
		
		li_inserted = ldw_temp.insertrow(0)
		ldw_temp.setitem( li_inserted, "field_name", 'due_date' )
		ldw_temp.setitem( li_inserted, "field_name_allias", 'Due Date' )		
		ldw_temp.setitem( li_inserted, "field_type", 'D' )
		
		li_inserted = ldw_temp.insertrow(0)
		ldw_temp.setitem( li_inserted, "field_name", 'expiration_date' )
		ldw_temp.setitem( li_inserted, "field_name_allias", 'Expiration Date' )		
		ldw_temp.setitem( li_inserted, "field_type", 'D' )
		
		li_inserted = ldw_temp.insertrow(0)
		ldw_temp.setitem( li_inserted, "field_name", 'notes' )
		ldw_temp.setitem( li_inserted, "field_name_allias", 'Notes' )		
		ldw_temp.setitem( li_inserted, "field_type", 'C' )
		
		li_inserted = ldw_temp.insertrow(0)
		ldw_temp.setitem( li_inserted, "field_name", 'priority_user' )
		ldw_temp.setitem( li_inserted, "field_name_allias", 'Priority User' )		
		ldw_temp.setitem( li_inserted, "field_type", 'C' )
		
		li_inserted = ldw_temp.insertrow(0)
		ldw_temp.setitem( li_inserted, "field_name", 'priority' )
		ldw_temp.setitem( li_inserted, "field_name_allias", 'Priority' )		
		ldw_temp.setitem( li_inserted, "field_type", 'N' )
		
		li_inserted = ldw_temp.insertrow(0)
		ldw_temp.setitem( li_inserted, "field_name", 'fee' )
		ldw_temp.setitem( li_inserted, "field_name_allias", 'Fee' )		
		ldw_temp.setitem( li_inserted, "field_type", 'N' )
		*/
		of_dddw_insert (ldw_temp, "verification_method", "Verification Method", "N", "C", "Y", "Verification Method")
		of_dddw_insert (ldw_temp, "first_sent", "First Sent", "D", "", "N", "")		
		of_dddw_insert (ldw_temp, "last_sent", "Last Sent", "D", "", "N", "")		
		of_dddw_insert (ldw_temp, "number_sent", "Number Sent", "N", "", "N", "")		
		of_dddw_insert (ldw_temp, "response_code", "Response Code", "N", "C", "Y", "credentials verification response")		
		of_dddw_insert (ldw_temp, "date_recieved", "Date Recieved", "D", "", "N", "")		
		of_dddw_insert (ldw_temp, "user_name", "User Name", "C", "", "N", "")		
		of_dddw_insert (ldw_temp, "due_date", "Due Date", "D", "", "N", "")		
		of_dddw_insert (ldw_temp, "expiration_date", "Expiration Date", "D", "", "N", "")		
		of_dddw_insert (ldw_temp, "notes", "Notes", "C", "", "N", "")		
		of_dddw_insert (ldw_temp, "priority_user", "Priority User", "C", "", "N", "")		
		of_dddw_insert (ldw_temp, "priority", "Priority", "N", "", "N", "")		
		of_dddw_insert (ldw_temp, "fee", "Fee", "N", "", "N", "")
	Case 'pd_app_audit'   //(Appeon)Harry 03.03.2015
		of_dddw_insert (ldw_temp, "date_completed", "Date Completed", "D", "", "N", "")	
		of_dddw_insert (ldw_temp, "data_status", "Data Status", "N", "C", "Y", "required data status")	
		of_dddw_insert (ldw_temp, "notes", "Notes", "C", "", "N", "")	
		of_dddw_insert (ldw_temp, "identifying_number", "Identifying Number", "C", "", "N", "")	
		of_dddw_insert (ldw_temp, "fax_message", "Description", "C", "", "N", "")	  //Start Code Change ----09.01.2016 #V152 maha changed from description
		//of_dddw_insert (ldw_temp, "description", "Description", "C", "", "N", "")
	Case 'alert_records'  //(Appeon)Harry 03.03.2015
		of_dddw_insert (ldw_temp, "alert_id", "Alert ID", "N", "1", "Y", "")
		of_dddw_insert (ldw_temp, "prac_id", "Prac ID", "N", "", "N", "")
		of_dddw_insert (ldw_temp, "facility_id", "Facility", "N", "2", "Y", "")
		of_dddw_insert (ldw_temp, "exp_date", "Exp Date", "D", "", "N", "")
		of_dddw_insert (ldw_temp, "active_status", "Active Status", "N", "", "N", "")
		//of_dddw_insert (ldw_temp, "table_name", "Table Name", "C", "3", "Y", "")
		of_dddw_insert (ldw_temp, "table_name", "Table Name", "C", "", "N", "")
		of_dddw_insert (ldw_temp, "step1", "Step1", "C", "", "N", "")
		of_dddw_insert (ldw_temp, "step2", "Step2", "C", "", "N", "")
		of_dddw_insert (ldw_temp, "step3", "Step3", "C", "", "N", "")
		of_dddw_insert (ldw_temp, "step4", "Step4", "C", "", "N", "")
		of_dddw_insert (ldw_temp, "step5", "Step5", "C", "", "N", "")
		of_dddw_insert (ldw_temp, "step6", "Step6", "C", "", "N", "")
		of_dddw_insert (ldw_temp, "step7", "Step7", "C", "", "N", "")
		of_dddw_insert (ldw_temp, "step8", "Step8", "C", "", "N", "")
		of_dddw_insert (ldw_temp, "step9", "Step9", "C", "", "N", "")
		of_dddw_insert (ldw_temp, "step10", "Step10", "C", "", "N", "")
		of_dddw_insert (ldw_temp, "reset_date", "Reset Date", "D", "", "N", "")
		of_dddw_insert (ldw_temp, "last_result", "Last Result", "C", "", "N", "")
	//---------Begin Added by (Appeon)Harry 03.12.2015 for V151-Additional Notification Filters--------  	
	Case 'pd_oppe_hrd'
		of_dddw_insert (ldw_temp, "facility_id", "Facility", "N", "2", "Y", "")
		of_dddw_insert (ldw_temp, "department", "Department", "N", "C", "Y", "Department")
		of_dddw_insert (ldw_temp, "specialty", "Specialty", "C", "", "N", "")
		of_dddw_insert (ldw_temp, "active_status", "Active Status", "N", "", "N", "")
		of_dddw_insert (ldw_temp, "from_date", "From Date", "D", "", "N", "")
		of_dddw_insert (ldw_temp, "to_date", "To Date", "D", "", "N", "")
		of_dddw_insert (ldw_temp, "req_recieved", "App Recvd", "D", "", "N", "")
		of_dddw_insert (ldw_temp, "current_status", "Process Status", "N", "C", "Y", "Evaluation Status")
		of_dddw_insert (ldw_temp, "outcome", "Outcome", "C", "", "N", "")
		of_dddw_insert (ldw_temp, "oppe_fppe", "Eval. Type", "C", "", "N", "")
		of_dddw_insert (ldw_temp, "fppe_type", "FPPE Type", "C", "", "N", "")
		of_dddw_insert (ldw_temp, "proctor", "Proctor", "C", "", "N", "")
		of_dddw_insert (ldw_temp, "proct_compl", "Proctoring Compl", "D", "", "N", "")
		of_dddw_insert (ldw_temp, "plan_comp", "Plan Comp", "D", "", "N", "")
		of_dddw_insert (ldw_temp, "hdr_comment", "Note", "C", "", "N", "")
		of_dddw_insert (ldw_temp, "process_template", "Process Template", "N", "", "N", "")
	Case 'meetings'
		of_dddw_insert (ldw_temp, "facility", "Facility", "N", "2", "Y", "")
		of_dddw_insert (ldw_temp, "start_date", "Start Date", "D", "", "N", "")
		of_dddw_insert (ldw_temp, "end_date", "End Date", "D", "", "N", "")
		of_dddw_insert (ldw_temp, "subject", "Subject", "C", "", "N", "")
		of_dddw_insert (ldw_temp, "comments", "Comments", "C", "", "N", "")
		of_dddw_insert (ldw_temp, "cme_credits", "CME Credits", "C", "", "N", "")
		of_dddw_insert (ldw_temp, "cme_category", "CME Category", "N", "C", "Y", "CME Category")
		of_dddw_insert (ldw_temp, "cme_presenter", "CME Presenter", "C", "", "N", "")
		of_dddw_insert (ldw_temp, "cme_affiliation", "CME Affiliation", "C", "", "N", "")
		of_dddw_insert (ldw_temp, "meet_profile", "Meet Profile", "N", "", "N", "")
		of_dddw_insert (ldw_temp, "start_time", "Start Time", "N", "C", "Y", "Time")
		of_dddw_insert (ldw_temp, "end_time", "End Time", "N", "C", "Y", "Time")
		of_dddw_insert (ldw_temp, "meeting_type", "Meeting Type", "N", "C", "Y", "Meeting Type")
		//of_dddw_insert (ldw_temp, "support_rcvd", "Support Rcvd", "N", "", "N", "")
		//of_dddw_insert (ldw_temp, "support_amount", "Support Amount", "N", "", "N", "")
		//of_dddw_insert (ldw_temp, "purpose_for", "Purpose For", "N", "", "N", "")
		of_dddw_insert (ldw_temp, "location", "Meeting Location", "N", "C", "Y", "Meeting Location")
		of_dddw_insert (ldw_temp, "section", "Section", "N", "C", "Y", "Section")
		of_dddw_insert (ldw_temp, "department", "Department", "N", "C", "Y", "Department")
		of_dddw_insert (ldw_temp, "committee", "Committee", "N", "", "N", "")
	//---------End Added ------------------------------------------------------
End Choose


dw_crit1.settransobject(sqlca)
dw_crit1.insertrow(1)
dw_crit1.GetChild('field_name', sys_fields_child)
sys_fields_child.settransobject( sqlca)
ldw_temp.rowscopy(1, ldw_temp.rowcount(), Primary!, sys_fields_child,  1, Primary!)
sys_fields_child.insertrow(1)

		  
dw_crit2.settransobject(sqlca)
dw_crit2.insertrow(1)
dw_crit2.GetChild('field_name', sys_fields_child2)
sys_fields_child2.settransobject( sqlca)
ldw_temp.rowscopy(1, ldw_temp.rowcount(), Primary!, sys_fields_child2,  1, Primary!)
sys_fields_child2.insertrow(1)

dw_crit3.settransobject(sqlca)
dw_crit3.insertrow(1)
dw_crit3.GetChild('field_name', sys_fields_child3)
sys_fields_child3.settransobject( sqlca)
ldw_temp.rowscopy(1, ldw_temp.rowcount(), Primary!, sys_fields_child3,  1, Primary!)
sys_fields_child3.insertrow(1)

if isvalid(ldw_temp) then destroy ldw_temp

end event

public function integer of_checkcriteia (boolean ab_flag);//////////////////////////////////////////////////////////////////////
// $<function>  of_checkcriteia
// $<arguments> 
// 		boolean	ab_flag
// $<returns>   integer
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01/06/2009 by Evan
//////////////////////////////////////////////////////////////////////

// Check address_type filed
if Lower(is_field1) = "address_type" or Lower(is_field2) = "address_type" or Lower(is_field3) = "address_type" then
	if ab_Flag then
		MessageBox("Prompt", "The address_type field cannot be used in filter. Click the Link Fields button to select a filter for the Address type.")
	else
		MessageBox("Prompt", "The address_type field cannot be used in filter. Please reset criteria first.")
	end if
	Return -1
end if

Return 1
end function

public function string of_getfieldtype (string as_type);//////////////////////////////////////////////////////////////////////
// $<function> of_getfieldtype
// $<arguments>
//			string	as_type
// $<returns> string
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 04.13.2009
//////////////////////////////////////////////////////////////////////

choose Case LeftA(as_Type, 5)
	Case "char(", "char"
		as_Type = "C"
	Case "date"	,"datet"	,"time", "times"
		as_Type = "D"
	Case "decim","numbe", "doubl", "real","long", "ulong", "int"
		as_Type = "N"
end choose
	
Return as_Type
end function

public function string of_getcriteria (string as_fieldtype, string as_field, string as_operator, string as_value);//////////////////////////////////////////////////////////////////////
// $<function> of_getcriteria
// $<arguments>
//			string	as_fieldtype
//			string	as_field
//			string	as_operator
//			string	as_value
// $<returns> string
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 04.13.2009
//////////////////////////////////////////////////////////////////////

string ls_Criteria

if is_From = "APPLICATION" then
	if is_table = "pd_address" or is_table = "pd_address_2" or is_table = "pd_hosp_affil" then
		//Start Code Change ----12.14.2011 #V12 maha - modified for null syntaxes
		if Upper(as_operator ) = "IS" or Upper(as_operator) = "IS NOT" then
			if Upper(as_operator ) = "IS" then
				ls_Criteria  = "ISNULL(" +  is_table + "_" + as_Field + ") "
			else
				ls_Criteria  = "NOT ISNULL(" +  is_table + "_" + as_Field + ") "
			end if
		else
			choose case as_FieldType
				case "I", "N"
					ls_Criteria  = is_table + "_" + as_Field + " " + as_Operator + " " + as_Value
				case "D"
					as_Value = as_Value + " 00:00:00"
					ls_Criteria  = is_table + "_" + as_Field + " " + as_Operator + " " + "'" + as_Value + "' "
				Case "C"
					ls_Criteria  = is_table + "_" + as_Field + " " + as_Operator + " '" + as_Value + "'"
			end choose
		end if //null
	else
		if Upper(as_operator ) = "IS" or Upper(as_operator) = "IS NOT" then
			if Upper(as_operator ) = "IS" then
			//	ls_Criteria  = "ISNULL(" +  is_table + "_" + as_Field + ") "
				ls_Criteria  = "ISNULL(" + as_Field + ") "  //Start Code Change ----01.27.2012 #V12 maha - removed table name
			else
			//	ls_Criteria  = "NOT ISNULL(" +  is_table + "_" + as_Field + ") "
				ls_Criteria  = "NOT ISNULL(" +  as_Field + ") "  //Start Code Change ----01.27.2012 #V12 maha - removed table name
			end if
		else
			choose case as_FieldType
				case "I", "N"
					ls_Criteria  = as_Field + " " + as_Operator + " " + as_Value
				case "D"
					as_Value = as_Value + " 00:00:00"
					ls_Criteria  = as_Field + " " + as_Operator + " " + "'" + as_Value + "' "
				Case "C"
					ls_Criteria  = as_Field + " " + as_Operator + " '" + as_Value + "'"
			end choose
		end if
		//End Code Change ----12.14.2011
	end if
//---------Begin Modified by (Appeon)Toney 07.12.2013 for V141 ISG-CLX--------
//$Reason:ctx_export doesn't need table name prefix
  /*
	else //PD_EXPORT or CTX_EXPORT
		choose case as_FieldType
			case "I", "N"
				ls_Criteria  = is_Table + "." + as_Field + " " + as_Operator + " " + as_Value
			case "D"
				as_Value = as_Value + " 00:00:00"
				ls_Criteria  = is_Table + "." + as_Field + " " + as_Operator + " " + "'" + as_Value + "' "
			Case "C"
				ls_Criteria  = is_Table + "." + as_Field + " " + as_Operator + " '" + as_Value + "'"
		end choose      
  */
elseif is_from = "CTX_EXPORT" then
	choose case as_FieldType
		case "I", "N"
			ls_Criteria  = as_Field + " " + as_Operator + " " + as_Value
		case "D"
			as_Value = as_Value + " 00:00:00"
			ls_Criteria  = as_Field + " " + as_Operator + " " + "'" + as_Value + "' "
		Case "C"
			ls_Criteria  = as_Field + " " + as_Operator + " '" + as_Value + "'"
	end choose
else //PD_EXPORT
	choose case as_FieldType
		case "I", "N"
			ls_Criteria  = is_Table + "." + as_Field + " " + as_Operator + " " + as_Value
		case "D"
			as_Value = as_Value + " 00:00:00"
			ls_Criteria  = is_Table + "." + as_Field + " " + as_Operator + " " + "'" + as_Value + "' "
		Case "C"
			ls_Criteria  = is_Table + "." + as_Field + " " + as_Operator + " '" + as_Value + "'"
	end choose
//---------End Modfiied ------------------------------------------------------------------
end if

Return ls_Criteria
end function

public subroutine of_dddw_insert (ref datastore ads, string as_field_name, string as_field_name_allias, string as_field_type, string as_lookup_type, string as_lookup_field, string as_lookup_code);
//////////////////////////////////////////////////////////////////////
// $<function> of_dddw_insert
// $<arguments>
//			datastore	ads
//			string	as_field_name
//			string	as_field_name_allias
//			string	as_field_type
//			string	as_lookup_type
//			string	as_lookup_field
//			string	as_lookup_code
// $<returns> (None)
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $Added by (Appeon)Harry 03.02.2015 for V151-Additional TDL Filters
//////////////////////////////////////////////////////////////////////

Int li_inserted
li_inserted = ads.insertrow(0)
ads.setitem( li_inserted, "field_name", as_field_name )
ads.setitem( li_inserted, "field_name_allias", as_field_name_allias )	
ads.setitem( li_inserted, "field_type", as_field_type )
If as_lookup_field = 'Y' Then
	ads.setitem( li_inserted, "lookup_type", as_lookup_type )
	ads.setitem( li_inserted, "lookup_field", as_lookup_field )
	ads.setitem( li_inserted, "lookup_code", as_lookup_code )
End If
end subroutine

public subroutine of_reset_syntax (string as_link);//Start Code Change ----09.29.2017 #V154 maha
string ls_op1, ls_op2, ls_op3
string ls_val1, ls_val2, ls_val3
string ls_ftype1, ls_ftype2, ls_ftype3
string ls_where1, ls_where2, ls_where3
string ls_query  //maha 05.17.2017
string ls_table, ls_linking_field
boolean lb_link = false
string ls_link
n_cst_string lnv_string

if of_CheckCriteia(true) = -1 then Return 

if is_table = "" then 
	messagebox("","Please select a table")
	return 
end if

if is_field = "" then 
	messagebox("","Please select a field")
	return
end if

if pos(as_link, "link", 1) > 0 then lb_link = true 

// get link table
ls_link = mid(as_link, 1, pos(as_link, ".", 1) - 1)
//ls_table =  is_table + ", " + ls_table

//set the select field
if ib_is_lookup then
	ls_query = "SELECT top 1 " + is_table2 + "."  + is_field_lookup  + " from "
else
	ls_query = "SELECT top 1 "  + is_table  + "." + is_field  + " from "
end if

//set tables
if ib_is_lookup then
	ls_query+=  + is_table + ", " + is_table2 + " "
else
	ls_query+=  + is_table + " "
end if

if lb_link then
	ls_query+= ", "+ ls_link + ", pd_affil_stat "
end if

//link tables
if ib_is_lookup then 
	ls_query+= " WHERE " +  is_table + "." + is_field + " = "  + is_table2 + ".lookup_code "
end if

if lb_link then
	choose case ls_link
		case "pd_address_link"
			ls_linking_field = ls_link + ".address_id"
		case "pd_hosp_affil_link"
			ls_linking_field = ls_link + ".hosp_affil_id"
		case "pd_board_specialty_link"
			ls_linking_field = ls_link + ".specialty_id"
	end choose
	
	if pos(ls_query, "WHERE",1) > 0 then
		ls_query+= " AND "	
	else
		ls_query+= " WHERE "
	end if

	ls_query+=  is_table + ".rec_id = " + ls_linking_field + " "
	
	//Start Code Change ----10.10.2017 #V154 maha
	ls_query+= " AND "	+ "pd_affil_stat.parent_facility_id = " + ls_link + ".facility_id AND pd_affil_stat.parent_facility_id = @facil@"
	//End Code Change ----10.10.2017
end if

//Start Code Change ----09.29.2017 #V154 maha - if no criteria skip
if ib_is_crit  = false then 
	mle_syntax.text = ls_query
	return
end if

// Get field name and field type
dw_crit1.accepttext()
dw_crit2.accepttext()
dw_crit3.accepttext()

ls_ftype1 = sys_fields_child.GetItemString(sys_fields_child.getrow(),"field_type")
ls_ftype2 = sys_fields_child2.GetItemString(sys_fields_child2.getrow(),"field_type")
ls_ftype3 = sys_fields_child3.GetItemString(sys_fields_child3.getrow(),"field_type")

// Get first criteria
ls_op1 = ddlb_1.text
if sle_value1.visible = true then
	ls_val1 = sle_value1.text
else
	ls_val1 = String(il_v1)
end if
//---------Begin Added by (Appeon)Toney 06.20.2013 for V141 ISG-CLX--------
ls_val1 = lnv_string.of_globalreplace( ls_val1, "'","~'~'")  // Convert PB String to TSQL String --Jervis 06.15.2009
//ls_val1 = lnv_string.of_globalreplace( ls_val1, '"','~~"')
//---------End Added ------------------------------------------------------------------

if Upper(ls_op1) = "IS" or Upper(ls_op1) = "IS NOT" then ls_val1 = 'Null'
if ls_op1  = "" or ls_val1 = "" then Return
if Upper(ls_val1) = "NULL" then ls_ftype1 = "N"
ls_where1 = of_GetCriteria(ls_ftype1, is_field1, ls_op1, ls_val1)

// Get second criteria
ls_op2 = ddlb_2.text
if sle_value2.visible = true then
	ls_val2 = sle_value2.text
else
	ls_val2 = String(il_v2)
end if
//---------Begin Added by (Appeon)Toney 06.20.2013 for V141 ISG-CLX--------
ls_val2 = lnv_string.of_globalreplace( ls_val2, "'","~'~'")  // Convert PB String to TSQL String --Jervis 06.15.2009
//ls_val2 = lnv_string.of_globalreplace( ls_val2, '"','~~"')
//---------End Added ------------------------------------------------------------------

if Upper(ls_op2) = "IS" or Upper(ls_op2) = "IS NOT" then ls_val2 = 'Null'
if ls_op2  = "" or ls_val2 = "" then
	is_where = ls_where1
else
	if Upper(ls_val2) = "NULL" then ls_ftype2 = "N"
	ls_where2 = of_GetCriteria(ls_ftype2, is_field2, ls_op2, ls_val2)
	is_where  = ls_where1 + " and " + ls_where2
end if

// Get third criteria
ls_op3 = ddlb_3.text
if sle_value3.visible = true then
	ls_val3 = sle_value3.text
else
	ls_val3 = String(il_v3)
end if
//---------Begin Added by (Appeon)Toney 06.20.2013 for V141 ISG-CLX--------
ls_val3 = lnv_string.of_globalreplace( ls_val3, "'","~'~'")  // Convert PB String to TSQL String --Jervis 06.15.2009
//ls_val3 = lnv_string.of_globalreplace( ls_val3, '"','~~"')
//---------End Added ------------------------------------------------------------------
if Upper(ls_op3) = "IS" or Upper(ls_op3) = "IS NOT" then ls_val3 = 'Null'
if ls_op3  = "" or ls_val3 = "" then
	//is_where = is_where
else
	if Upper(ls_val3) = "NULL" then ls_ftype3 = "N"
	ls_where3 = of_GetCriteria(ls_ftype3, is_field3, ls_op3, ls_val3)
	is_where  = is_where + " and " + ls_where3
end if

//set additional filters
if len(is_where) > 0 then
	if pos(ls_query, "WHERE",1) > 0 then
		ls_query+= " AND "	
	else
		ls_query+= " WHERE "
	end if
	ls_query = ls_query + is_where
end if

if lb_link then
	ls_query = ls_query + " AND " + as_link
end if

// Show criteria
mle_syntax.text = ls_query


end subroutine

on w_query_create.create
this.mle_syntax=create mle_syntax
this.cb_link=create cb_link
this.st_screen=create st_screen
this.cb_cancel=create cb_cancel
this.cb_syntax=create cb_syntax
this.st_syntax=create st_syntax
this.ddlb_3=create ddlb_3
this.cb_reset=create cb_reset
this.st_null3=create st_null3
this.st_null2=create st_null2
this.st_null1=create st_null1
this.dw_crit3=create dw_crit3
this.st_rf=create st_rf
this.st_date3=create st_date3
this.st_date2=create st_date2
this.st_date1=create st_date1
this.dw_v3=create dw_v3
this.dw_v2=create dw_v2
this.dw_v1=create dw_v1
this.ddlb_2=create ddlb_2
this.ddlb_1=create ddlb_1
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.sle_value3=create sle_value3
this.dw_crit2=create dw_crit2
this.dw_crit1=create dw_crit1
this.sle_value2=create sle_value2
this.sle_value1=create sle_value1
this.cb_return=create cb_return
this.cb_setsyntax=create cb_setsyntax
this.cb_about=create cb_about
this.gb_7=create gb_7
this.gb_6=create gb_6
this.gb_5=create gb_5
this.gb_1=create gb_1
this.gb_2=create gb_2
this.dw_table=create dw_table
this.dw_field=create dw_field
this.gb_4=create gb_4
this.gb_3=create gb_3
this.Control[]={this.mle_syntax,&
this.cb_link,&
this.st_screen,&
this.cb_cancel,&
this.cb_syntax,&
this.st_syntax,&
this.ddlb_3,&
this.cb_reset,&
this.st_null3,&
this.st_null2,&
this.st_null1,&
this.dw_crit3,&
this.st_rf,&
this.st_date3,&
this.st_date2,&
this.st_date1,&
this.dw_v3,&
this.dw_v2,&
this.dw_v1,&
this.ddlb_2,&
this.ddlb_1,&
this.st_5,&
this.st_4,&
this.st_3,&
this.sle_value3,&
this.dw_crit2,&
this.dw_crit1,&
this.sle_value2,&
this.sle_value1,&
this.cb_return,&
this.cb_setsyntax,&
this.cb_about,&
this.gb_7,&
this.gb_6,&
this.gb_5,&
this.gb_1,&
this.gb_2,&
this.dw_table,&
this.dw_field,&
this.gb_4,&
this.gb_3}
end on

on w_query_create.destroy
destroy(this.mle_syntax)
destroy(this.cb_link)
destroy(this.st_screen)
destroy(this.cb_cancel)
destroy(this.cb_syntax)
destroy(this.st_syntax)
destroy(this.ddlb_3)
destroy(this.cb_reset)
destroy(this.st_null3)
destroy(this.st_null2)
destroy(this.st_null1)
destroy(this.dw_crit3)
destroy(this.st_rf)
destroy(this.st_date3)
destroy(this.st_date2)
destroy(this.st_date1)
destroy(this.dw_v3)
destroy(this.dw_v2)
destroy(this.dw_v1)
destroy(this.ddlb_2)
destroy(this.ddlb_1)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.sle_value3)
destroy(this.dw_crit2)
destroy(this.dw_crit1)
destroy(this.sle_value2)
destroy(this.sle_value1)
destroy(this.cb_return)
destroy(this.cb_setsyntax)
destroy(this.cb_about)
destroy(this.gb_7)
destroy(this.gb_6)
destroy(this.gb_5)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.dw_table)
destroy(this.dw_field)
destroy(this.gb_4)
destroy(this.gb_3)
end on

event open; //Start Code Change ----05.17.2017 #V154 maha - copied from w_filter_wizard
 //for photo profile query settings and ireport subselect

integer li_table_id
integer li_screen_id
string  ls_screen_name
string  ls_Parm
n_cst_string lnv_string

ls_parm = message.stringparm
if len(ls_parm) > 0 then mle_syntax.text = ls_parm

dw_table.settransobject(sqlca)
dw_table.retrieve(1)
dw_table.insertrow(1)

//// Parse parameters to array [Format: FROM|PD_TABLE_ID|CTX_SCREEN_ALIAS|CTX_DATAOBJECT]
//lnv_string.of_ParseToArray(Message.StringParm, "|", ls_Parm[])
//is_From = ls_Parm[1]
//li_table_id = Integer(ls_Parm[2])
//ii_table_id = li_table_id //alfee 01.27.2010

// Initialize objects according to FROM parameter
//if is_From = "CTX_EXPORT" then
//	this.Event ue_ctx_init(ls_Parm[3], ls_Parm[4])
//	dw_v1.visible = false
//	sle_value1.visible = true
//	sle_value1.text = ""
//	st_date1.visible = false
//	st_date2.visible = false
//	st_date3.visible = false
//	cb_link.visible = false
////---------Begin Added by (Appeon)Harry 03.02.2015 for V151-Additional TDL Filters--------
//elseif is_From = "TODOLIST" or is_From = "Notification" then //(Appeon)Harry 03.12.2015 - Additional Notification Filters  (add  is_From = "Notification")
//	is_table = ls_Parm[3]
//	this.Event ue_fields_init(ls_Parm[3])
////---------End Added ------------------------------------------------------
//else //PD_EXPORT or APPLICATION
//	dw_crit1.SetTransObject(SQLCA)
//	dw_crit2.SetTransObject(SQLCA)
//	dw_crit3.SetTransObject(SQLCA)
//	
//	gnv_appeondb.of_startqueue()
//	select screen_name into :ls_screen_name from data_view_screen where table_id = :li_table_id and data_view_id = 1;
//	//select screen_id into :li_screen_id from data_view_screen where table_id = :li_table_id and data_view_id = 1; //commented by alfee 03.31.2010
//	select table_name into :is_table from sys_tables where table_id = :li_table_id;
//	is_table = Lower(is_table)
//	//--------Begin Commented by  Nova 10.30.2009------------------------
//	//	dw_crit1.Retrieve(li_table_id)
//	//	dw_crit2.Retrieve(li_table_id)
//	//	dw_crit3.Retrieve(li_table_id)
//   //--------End Commented --------------------------------------------
//	//--------Begin Added by Nova 10.30.2009------------------------
//	dw_crit1.GetChild('field_name', sys_fields_child)
//   sys_fields_child.SetTransObject(SQLCA)
//	sys_fields_child.Retrieve(li_table_id)
//	
//	dw_crit1.Retrieve(li_table_id)
////	sys_fields_child.insertrow(1)//move out from queue by  Nova 03.23.2010
////	dw_crit1.insertrow(1)
//	
//	dw_crit2.GetChild('field_name', sys_fields_child2)
//   sys_fields_child2.SetTransObject(SQLCA)
//	sys_fields_child2.Retrieve(li_table_id)
//	dw_crit2.Retrieve(li_table_id)
////	sys_fields_child2.insertrow(1)//move out from queue by  Nova 03.23.2010
////	dw_crit2.insertrow(1)
////	
//	dw_crit3.GetChild('field_name', sys_fields_child3)
//   sys_fields_child3.SetTransObject(SQLCA)
//	sys_fields_child3.Retrieve(li_table_id)
//	dw_crit3.Retrieve(li_table_id)
////	sys_fields_child3.insertrow(1)//move out from queue by  Nova 03.23.2010
////	dw_crit3.insertrow(1)
////--------End Added --------------------------------------------//nova
//	gnv_appeondb.of_commitqueue()
//	//--------Begin Added by Nova 03.23.2010------------------------
//	//Fixed BugN031201	(WEB P2 Nova)
//	sys_fields_child.insertrow(1)
//	dw_crit1.insertrow(1)
//	sys_fields_child2.insertrow(1)
//	dw_crit2.insertrow(1)
//	sys_fields_child3.insertrow(1)
//	dw_crit3.insertrow(1)
//	//--------End Added --------------------------------------------
//
////	st_screen.text = "Screen Name: " + ls_screen_name
//	st_date1.visible = false
//	st_date2.visible = false
//	st_date3.visible = false
////end if
cb_reset.Event Clicked()
end event

event close;//////////////////////////////////////////////////////////////////////
// $<event> close
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 04.13.2009
//////////////////////////////////////////////////////////////////////

CloseWithReturn(this, is_Return)
end event

type mle_syntax from multilineedit within w_query_create
integer x = 82
integer y = 1344
integer width = 2551
integer height = 348
integer taborder = 180
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type cb_link from commandbutton within w_query_create
integer x = 2757
integer y = 812
integer width = 494
integer height = 84
integer taborder = 240
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Link Fields"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 04.13.2009
//////////////////////////////////////////////////////////////////////

string ls_Message
string ls_Syntax

if of_CheckCriteia(false) = -1 then Return

cb_setsyntax.Event Clicked()
OpenWithParm(w_export_link_select, is_From)
ls_Message = Message.StringParm

if ls_Message = "cancel" then
	Return
else
	of_reset_syntax(ls_message)  //Start Code Change ----09.29.2017 #V154 maha
//	ls_Syntax = mle_syntax.text
//	if LenA(ls_Syntax) > 0 then //if ls_Syntaxtax already exists add with an and
//		ls_Syntax = ls_Syntax + " and " + ls_Message
//	else
//		ls_Syntax  = ls_Message
//	end if
//	mle_syntax.text = ls_Syntax
end if
end event

type st_screen from statictext within w_query_create
integer x = 2976
integer y = 64
integer width = 224
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_query_create
integer x = 2757
integer y = 276
integer width = 494
integer height = 84
integer taborder = 200
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 04.13.2009
//////////////////////////////////////////////////////////////////////

Closewithreturn(Parent, "Cancel")
end event

type cb_syntax from commandbutton within w_query_create
boolean visible = false
integer x = 2766
integer y = 1520
integer width = 494
integer height = 76
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "&View Syntax"
end type

event clicked;messagebox("Select syntax",is_search)
end event

type st_syntax from statictext within w_query_create
boolean visible = false
integer x = 2935
integer y = 1352
integer width = 87
integer height = 92
integer taborder = 170
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type ddlb_3 from dropdownlistbox within w_query_create
integer x = 1179
integer y = 1092
integer width = 306
integer height = 368
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean sorted = false
boolean vscrollbar = true
string item[] = {"=","<",">","<>","<=",">=","is","is not"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;if this.text = "is" or this.text = "is not" then
	st_null3.visible = true
	dw_v3.enabled = false
	sle_value3.enabled = false
else 
	st_null3.visible = false
	dw_v3.enabled = true
	sle_value3.enabled = true
end if


end event

type cb_reset from commandbutton within w_query_create
integer x = 2757
integer y = 700
integer width = 494
integer height = 84
integer taborder = 230
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "R&eset Criteria"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 04.10.2009
//////////////////////////////////////////////////////////////////////

dw_v1.Reset()
dw_v2.Reset()
dw_v3.Reset()
dw_v1.InsertRow(0)
dw_v2.InsertRow(0)
dw_v3.InsertRow(0)

sle_value1.Text = ""
sle_value2.Text = ""
sle_value3.Text = ""

SetNull(is_field1)
SetNull(is_field2)
SetNull(is_field3)
SetNull(il_v1)
SetNull(il_v2)
SetNull(il_v3)

dw_crit1.SelectRow(0, false)
dw_crit2.SelectRow(0, false)
dw_crit3.SelectRow(0, false)
ddlb_1.SelectItem(0)
ddlb_2.SelectItem(0)
ddlb_3.SelectItem(0)

dw_v1.Hide()
dw_v2.Hide()
dw_v3.Hide()
sle_value1.Show()
sle_value2.Show()
sle_value3.Show()
sle_value1.Enabled = true
sle_value2.Enabled = true
sle_value3.Enabled = true

mle_syntax.Text = ""
cb_setsyntax.Enabled = true
end event

type st_null3 from statictext within w_query_create
boolean visible = false
integer x = 1609
integer y = 1096
integer width = 974
integer height = 84
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean enabled = false
string text = " Null"
boolean border = true
boolean focusrectangle = false
end type

type st_null2 from statictext within w_query_create
boolean visible = false
integer x = 1609
integer y = 752
integer width = 974
integer height = 84
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean enabled = false
string text = " Null"
boolean border = true
boolean focusrectangle = false
end type

type st_null1 from statictext within w_query_create
boolean visible = false
integer x = 1609
integer y = 436
integer width = 974
integer height = 84
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean enabled = false
string text = " Null"
boolean border = true
boolean focusrectangle = false
end type

type dw_crit3 from datawindow within w_query_create
event ue_ctx_row ( integer currentrow )
integer x = 114
integer y = 1092
integer width = 937
integer height = 88
integer taborder = 80
string dataobject = "d_sys_fields_for_table"
boolean border = false
boolean livescroll = true
end type

event ue_ctx_row(integer currentrow);//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-08-22 By: Scofield
//$<Reason> Add the process for dw_crit3

datastore    lds_dataobject
datawindowchild  dwchild, dwcquery

String  ls_dataobject, ls_column, ltable, ls_coltype, ls_dacol, ls_discol
String  ls_data, ls_display, ls_values, ls_temp
Integer  li_rowcount, i
//--------Begin Modified by  Nova 10.30.2009------------------------
//ls_column = This.GetItemString( currentrow, "field_name" )
ls_column = sys_fields_child3.GetItemString(sys_fields_child3.GetRow(),"field_name")
//--------End Modified --------------------------------------------

IF IsNull( ls_column ) THEN RETURN

ls_dataobject = This.Tag
lds_dataobject = Create datastore
lds_dataobject.DataObject = ls_dataobject

ls_temp = lds_dataobject.Describe( ls_column + ".dbname" )
f_get_token( ls_temp, "." )
is_field3 = ls_temp

//--------Begin Modified by  Nova 10.30.2009------------------------
//ls_coltype = lds_dataobject.Describe( ls_column + ".coltype" )
ls_coltype = sys_fields_child3.GetItemString(sys_fields_child3.GetRow(),"field_datatype" )
//--------End Modified --------------------------------------------

CHOOSE CASE LeftA ( ls_coltype , 5 )
	CASE "char(", "char"
		ls_coltype = "C"
	CASE "date" ,"datet" ,"time", "times"
		ls_coltype = "D"
	CASE "decim","numbe", "doubl", "real","long", "ulong", "int"
		ls_coltype = "N"
END CHOOSE

ls_dacol = Lower( lds_dataobject.Describe( ls_column + ".dddw.datacolumn" ) )
//---------Begin Modified by (Appeon)Toney 06.20.2013 for V141 ISG-CLX--------
  /*
    IF ls_dacol = '?' Or ls_dacol = '!' THEN  
  */
//Start code by jervis 05.21.2009
If ls_dataobject = "d_export_contract_profile_wizard" Or ls_dataobject = "d_profile_header" or ls_dataobject = "d_contract_group_linked_locations" or ls_dataobject = "d_contract_multi_group_browse" Then	//Requirement Profile- 05.21.2009 By Jervis
	
	Choose Case ls_column
		Case 'ctx_req_profile_id','requirement','category_name','parent_comp_id'
			dw_v3.Visible = True
			sle_value3.Visible = False
			dw_v3.DataObject = "d_req_profile"
			If ls_column = 'ctx_req_profile_id' Then
				dw_v3.Modify( "description.dddw.name = 'd_dddw_req_profile' description.dddw.datacolumn = 'ctx_req_profile_id' description.dddw.displaycolumn = 'rqmnt_name'")
			ElseIf ls_column = 'requirement' Then
				dw_v3.Modify( "description.dddw.name = 'd_dddw_req_element' description.dddw.datacolumn = 'element_name' description.dddw.displaycolumn = 'element_name'")
			elseif ls_column = 'category_name' then 
				dw_v3.Modify( "description.dddw.name = 'd_dddw_req_category' description.dddw.datacolumn = 'category_name' description.dddw.displaycolumn = 'category_name'")
			elseif ls_column = "parent_comp_id" then
				dw_v3.Modify( "description.dddw.name = 'd_dddw_multi_group' description.dddw.datacolumn = 'rec_id' description.dddw.displaycolumn = 'gp_name'")
			end if
			
			dw_v3.Reset( )
			dw_v3.GetChild( "description", dwchild )
			dwchild.SetTransObject( SQLCA )
			dwchild.Retrieve()
			dwchild.InsertRow( 1 )
			dw_v3.InsertRow(1)
		Case Else
			dw_v3.Visible = False
			sle_value3.Visible = True
			sle_value3.Text = ""
	End Choose
	//End Code by jervis 05.21.2009
ElseIf ls_dacol = '?' Or ls_dacol = '!' Then
//---------End Modfiied ------------------------------------------------------------------

	dw_v3.Visible = False
	
	sle_value3.Text = ""
	sle_value3.Visible = True
ELSEIF ls_dacol = "lookup_code" THEN
	dw_v3.Visible = True
	sle_value3.Visible = False
	
	dw_v3.DataObject = "d_c_look"
	dw_v3.GetChild( "description", dwchild )
	
	dwchild.SetTransObject( SQLCA )
	ltable = lds_dataobject.Describe( ls_column + ".tag" )
	dwchild.Retrieve( ltable )
	dwchild.InsertRow( 1 )
	dw_v3.InsertRow(1)
ELSE
	dw_v3.Visible = True
	sle_value3.Visible = False
	
	lds_dataobject.SetTransObject( SQLCA )
	lds_dataobject.InsertRow( 0 )
	lds_dataobject.GetChild( ls_column, dwcquery )
	
	ls_discol = lds_dataobject.Describe( ls_column+".dddw.DisplayColumn")
	
	li_rowcount = dwcquery.RowCount()
	FOR i = 1 To li_rowcount
		IF ls_coltype = "C" THEN
			ls_data = dwcquery.GetItemString( i, ls_dacol )
		ELSEIF ls_coltype = "D" THEN
			ls_data = String( dwcquery.GetItemDateTime( i, ls_dacol ) )
		ELSE
			ls_data = String( dwcquery.GetItemNumber( i, ls_dacol ) )
		END IF
		IF Not IsNull( ls_data ) THEN
			ls_display = dwcquery.GetItemString( i, ls_discol )
			IF Not IsNull( ls_display ) THEN
				ls_values += ls_display + "~t" +ls_data + "/"
			END IF
		END IF
	NEXT
	
	dw_v3.DataObject = "d_ctx_export_param"
	dw_v3.Modify( "ctx_values.values = '" + ls_values + "'" )
	dwchild.InsertRow( 1 )
	dw_v3.InsertRow(1)
END IF

IF ls_coltype = "D" THEN
	st_date3.Visible = True
ELSE
	st_date3.Visible = False
END IF

Destroy lds_dataobject
//---------------------------- APPEON END ----------------------------

end event

event clicked;////////////////////////////////////////////////////////////////////////
//// $<event> clicked
//// $<arguments>
//// $<returns> long
//// $<description> N/A
////////////////////////////////////////////////////////////////////////
//// $<add> Evan 04.15.2009
////////////////////////////////////////////////////////////////////////
//commented by  Nova 10.30.2009------------------------
//if Row > 0 then
//	if this.GetSelectedRow(0) <= 0 then
//		this.Event RowFocusChanged(Row)
//	end if	
//	this.SetRow(Row)
//	this.SelectRow(0, false)
//	this.SelectRow(Row, true)
//end if
end event

event rowfocuschanged;//commented by  Nova 10.30.2009------------------------
////--------------------------- APPEON BEGIN ---------------------------
////$<add> 2006-11-29 By: Rodger Wu (doc painter)
////$<reason> 
//if this.dataobject = "dd_ctx_fields1001" then
//	This.Trigger Event ue_ctx_row( currentrow )		//Added by Scofield on 2007-08-22
//	return
//end if
////---------------------------- APPEON END ----------------------------
//
//datawindowchild dwchild
//string ltable
//string field
//string d
//
//if this.getitemstring(currentrow,"lookup_field") = "Y" then
//	dw_v3.visible = true
//	sle_value3.visible = false
//	ltable = this.getitemstring(currentrow,"lookup_code")
//	if this.getitemstring(currentrow,"lookup_type") = "C" then
//		dw_v3.dataobject = "d_c_look"
//		field = "description"
//	elseif this.getitemstring(currentrow,"lookup_type") = "A" then
//		dw_v3.dataobject = "d_a_look"
//		field = "entity_name_original"
//	end if
//	dw_v3.settransobject(sqlca)
////	dw_v3.retrieve(ltable)
////	dw_v3.insertrow(1)
//	dw_v3.GetChild( field, dwchild )
//	dwchild.SetTransObject( SQLCA )
//	dwchild.Retrieve(ltable)
//	dwchild.InsertRow( 1 )
//	dw_v3.insertrow(1)
//else
//	dw_v3.visible = false
//	sle_value3.visible = true
//	sle_value3.text = ""
//end if
//
//is_field3 = this.getitemstring(currentrow,"sys_fields_field_name")
//d = this.getitemstring(currentrow,"sys_fields_field_type")
//if d = "D" then 
//	st_date3.visible = true
//else
//	st_date3.visible = false
//end if
end event

event itemchanged;//Privilege Export - Nova 10.30.2009
IF This.DataObject = "dd_ctx_fields1001_dddw" THEN
	This.Trigger Event ue_ctx_row( sys_fields_child3.GetRow()) //Added by Scofield on 2007-08-22
	RETURN
END IF

datawindowchild dwchild
String ltable
String field
String d
String ls_field_type,ls_lookup_field

this.getchild( "field_name", sys_fields_child3)

ls_field_type = sys_fields_child3.GetItemString(sys_fields_child3.GetRow(),"lookup_type")

IF sys_fields_child3.GetItemString(sys_fields_child3.GetRow(),"lookup_field") = "Y" THEN
	dw_v3.Visible = True
	sle_value3.Visible = False
	ltable = sys_fields_child3.GetItemString(sys_fields_child3.GetRow(),"lookup_code")
	IF ls_field_type = "C" THEN
		dw_v3.DataObject = "d_c_look"
		field = "description"
	ELSEIF ls_field_type = "A" THEN
		dw_v3.DataObject = "d_a_look"
		field = "entity_name_original"
	ELSEIF ls_field_type = "D" THEN	//dddw lookup type - alfee 01.27.2010	
		IF ii_table_id = 90 THEN //privilege
			CHOOSE CASE lower(Data)
				CASE "clinical_area_id"
					dw_v3.DataObject = "d_d_look"
				CASE "priv_core_id"	
					dw_v3.DataObject = "d_s_look"
				CASE "procd_id"	
					dw_v3.DataObject = "d_p_look"
			END CHOOSE
		END IF
	//---------Begin Added by (Appeon)Harry 03.02.2015 for V151-Additional TDL Filters--------
	ELSEIF  ls_field_type = "1" THEN
		dw_v3.DataObject = "d_alert_look"
		field = "alert_id"
		dw_v3.modify("facility_id.visible='0' table_name.visible='0'")
	ELSEIF  ls_field_type = "2" THEN
		dw_v3.DataObject = "d_alert_look"
		field = "facility_id"
		dw_v3.modify("alert_id.visible='0' table_name.visible='0'")
	//---------End Added ------------------------------------------------------
	END IF
	dw_v3.SetTransObject(sqlca)
	dw_v3.GetChild( field, dwchild )
	dwchild.SetTransObject( sqlca )
	IF ls_field_type = "C" or  ls_field_type = "A" THEN 
		dwchild.Retrieve(ltable)
	ELSE
		dwchild.Retrieve()
	END IF
	dwchild.InsertRow( 1 )
	dw_v3.InsertRow(1)
ELSE
	dw_v3.Visible = False
	sle_value3.Visible = True
	sle_value3.Text = ""
END IF

is_field3 = Data
d = sys_fields_child3.GetItemString(sys_fields_child3.GetRow(),"field_type")
IF d = "D" THEN
	st_date3.Visible = True
ELSE
	st_date3.Visible = False
END IF

//Start Code Change ----03.01.2010 #V10 maha
if LenA(ddlb_3.text) = 0 then
	ddlb_3.text = '='
end if
//End Code Change---03.01.2010
 ib_is_crit = true //Start Code Change ----09.29.2017 #V154 maha

end event

type st_rf from statictext within w_query_create
integer x = 2706
integer y = 492
integer width = 626
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
boolean focusrectangle = false
end type

type st_date3 from statictext within w_query_create
integer x = 1595
integer y = 1012
integer width = 969
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
boolean enabled = false
string text = "Dates must be entered as yyyy-mm-dd"
boolean focusrectangle = false
end type

type st_date2 from statictext within w_query_create
integer x = 1595
integer y = 656
integer width = 969
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
boolean enabled = false
string text = "Dates must be entered as yyyy-mm-dd"
boolean focusrectangle = false
end type

type st_date1 from statictext within w_query_create
integer x = 1595
integer y = 348
integer width = 969
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
boolean enabled = false
string text = "Dates must be entered as yyyy-mm-dd"
boolean focusrectangle = false
end type

type dw_v3 from datawindow within w_query_create
integer x = 1600
integer y = 1092
integer width = 992
integer height = 100
integer taborder = 160
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;il_v3 = long(data)

end event

type dw_v2 from datawindow within w_query_create
integer x = 1600
integer y = 748
integer width = 992
integer height = 100
integer taborder = 100
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;il_v2 = long(data)


end event

type dw_v1 from datawindow within w_query_create
integer x = 1600
integer y = 432
integer width = 992
integer height = 100
integer taborder = 40
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;il_v1 = long(data)


end event

type ddlb_2 from dropdownlistbox within w_query_create
integer x = 1179
integer y = 752
integer width = 306
integer height = 368
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean sorted = false
boolean vscrollbar = true
string item[] = {"=","<",">","<>","<=",">=","is","is not"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;if this.text = "is" or this.text = "is not" then
	st_null2.visible = true
	dw_v2.enabled = false
	sle_value2.enabled = false
else 
	st_null2.visible = false
	dw_v2.enabled = true
	sle_value2.enabled = true
end if


end event

type ddlb_1 from dropdownlistbox within w_query_create
integer x = 1179
integer y = 432
integer width = 306
integer height = 368
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean sorted = false
boolean vscrollbar = true
string item[] = {"=","<",">","<>","<=",">=","is","is not"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;if this.text = "is" or this.text = "is not" then
	st_null1.visible = true
	dw_v1.enabled = false
	sle_value1.enabled = false
else 
	st_null1.visible = false
	dw_v1.enabled = true
	sle_value1.enabled = true
end if
	

end event

type st_5 from statictext within w_query_create
integer x = 1879
integer y = 300
integer width = 247
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Value"
boolean focusrectangle = false
end type

type st_4 from statictext within w_query_create
integer x = 1207
integer y = 300
integer width = 247
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Operator"
boolean focusrectangle = false
end type

type st_3 from statictext within w_query_create
integer x = 325
integer y = 300
integer width = 247
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Field"
boolean focusrectangle = false
end type

type sle_value3 from singlelineedit within w_query_create
integer x = 1600
integer y = 1100
integer width = 983
integer height = 92
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type dw_crit2 from datawindow within w_query_create
event ue_ctx_row ( integer currentrow )
integer x = 114
integer y = 748
integer width = 937
integer height = 88
integer taborder = 50
string dataobject = "d_sys_fields_for_table"
boolean border = false
boolean livescroll = true
end type

event ue_ctx_row(integer currentrow);//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-08-22 By: Scofield
//$<Reason> Add the process for dw_crit3

datastore    lds_dataobject
datawindowchild  dwchild, dwcquery

String  ls_dataobject, ls_column, ltable, ls_coltype, ls_dacol, ls_discol
String  ls_data, ls_display, ls_values, ls_temp
Integer  li_rowcount, i
//--------Begin Modified by  Nova 10.30.2009------------------------
//ls_column = This.GetItemString( currentrow, "field_name" )
ls_column = sys_fields_child2.GetItemString(sys_fields_child2.GetRow(),"field_name")
//--------End Modified --------------------------------------------

IF IsNull( ls_column ) THEN RETURN

ls_dataobject = This.Tag
lds_dataobject = Create datastore
lds_dataobject.DataObject = ls_dataobject

ls_temp = lds_dataobject.Describe( ls_column + ".dbname" )
f_get_token( ls_temp, "." )
is_field2 = ls_temp

//--------Begin Modified by  Nova 10.30.2009------------------------
//ls_coltype = lds_dataobject.Describe( ls_column + ".coltype" )
ls_coltype = sys_fields_child2.GetItemString(sys_fields_child2.GetRow(),"field_datatype" )
//--------End Modified --------------------------------------------

CHOOSE CASE LeftA ( ls_coltype , 5 )
	CASE "char(", "char"
		ls_coltype = "C"
	CASE "date" ,"datet" ,"time", "times"
		ls_coltype = "D"
	CASE "decim","numbe", "doubl", "real","long", "ulong", "int"
		ls_coltype = "N"
END CHOOSE

ls_dacol = Lower( lds_dataobject.Describe( ls_column + ".dddw.datacolumn" ) )
//---------Begin Modified by (Appeon)Toney 06.20.2013 for V141 ISG-CLX--------
  /*
    IF ls_dacol = '?' Or ls_dacol = '!' THEN  
  */
//Start code by jervis 05.21.2009
If ls_dataobject = "d_export_contract_profile_wizard" Or ls_dataobject = "d_profile_header" or ls_dataobject = "d_contract_group_linked_locations" or ls_dataobject = "d_contract_multi_group_browse" Then	//Requirement Profile- 05.21.2009 By Jervis
	
	Choose Case ls_column
		Case 'ctx_req_profile_id','requirement','category_name','parent_comp_id'
			dw_v2.Visible = True
			sle_value2.Visible = False
			dw_v2.DataObject = "d_req_profile"
			If ls_column = 'ctx_req_profile_id' Then
				dw_v2.Modify( "description.dddw.name = 'd_dddw_req_profile' description.dddw.datacolumn = 'ctx_req_profile_id' description.dddw.displaycolumn = 'rqmnt_name'")
			ElseIf ls_column = 'requirement' Then
				dw_v2.Modify( "description.dddw.name = 'd_dddw_req_element' description.dddw.datacolumn = 'element_name' description.dddw.displaycolumn = 'element_name'")
			elseif ls_column = 'category_name' then 
				dw_v2.Modify( "description.dddw.name = 'd_dddw_req_category' description.dddw.datacolumn = 'category_name' description.dddw.displaycolumn = 'category_name'")
			elseif ls_column = "parent_comp_id" then
				dw_v2.Modify( "description.dddw.name = 'd_dddw_multi_group' description.dddw.datacolumn = 'rec_id' description.dddw.displaycolumn = 'gp_name'")
			end if
			
			dw_v2.Reset( )
			dw_v2.GetChild( "description", dwchild )
			dwchild.SetTransObject( SQLCA )
			dwchild.Retrieve()
			dwchild.InsertRow( 1 )
			dw_v2.InsertRow(1)
		Case Else
			dw_v2.Visible = False
			sle_value2.Visible = True
			sle_value2.Text = ""
	End Choose
	//End Code by jervis 05.21.2009
ElseIf ls_dacol = '?' Or ls_dacol = '!' Then  
//---------End Modfiied ------------------------------------------------------------------
	dw_v2.Visible = False
	
	sle_value2.Text = ""
	sle_value2.Visible = True
ELSEIF ls_dacol = "lookup_code" THEN
	dw_v2.Visible = True
	sle_value2.Visible = False
	
	dw_v2.DataObject = "d_c_look"
	dw_v2.GetChild( "description", dwchild )
	
	dwchild.SetTransObject( SQLCA )
	ltable = lds_dataobject.Describe( ls_column + ".tag" )
	dwchild.Retrieve( ltable )
	dwchild.InsertRow( 1 )
	dw_v2.InsertRow(1)
ELSE
	dw_v2.Visible = True
	sle_value2.Visible = False
	
	lds_dataobject.SetTransObject( SQLCA )
	lds_dataobject.InsertRow( 0 )
	lds_dataobject.GetChild( ls_column, dwcquery )
	
	ls_discol = lds_dataobject.Describe( ls_column+".dddw.DisplayColumn")
	
	li_rowcount = dwcquery.RowCount()
	FOR i = 1 To li_rowcount
		IF ls_coltype = "C" THEN
			ls_data = dwcquery.GetItemString( i, ls_dacol )
		ELSEIF ls_coltype = "D" THEN
			ls_data = String( dwcquery.GetItemDateTime( i, ls_dacol ) )
		ELSE
			ls_data = String( dwcquery.GetItemNumber( i, ls_dacol ) )
		END IF
		IF Not IsNull( ls_data ) THEN
			ls_display = dwcquery.GetItemString( i, ls_discol )
			IF Not IsNull( ls_display ) THEN
				ls_values += ls_display + "~t" +ls_data + "/"
			END IF
		END IF
	NEXT
	
	dw_v2.DataObject = "d_ctx_export_param"
	dw_v2.Modify( "ctx_values.values = '" + ls_values + "'" )
	dwchild.InsertRow( 1 )
	dw_v2.InsertRow(1)
END IF

IF ls_coltype = "D" THEN
	st_date2.Visible = True
ELSE
	st_date2.Visible = False
END IF

Destroy lds_dataobject
//---------------------------- APPEON END ----------------------------


end event

event clicked;////////////////////////////////////////////////////////////////////////
//// $<event> clicked
//// $<arguments>
//// $<returns> long
//// $<description> N/A
////////////////////////////////////////////////////////////////////////
//// $<add> Evan 04.15.2009
////////////////////////////////////////////////////////////////////////
//commented by  Nova 10.30.2009------------------------
//if Row > 0 then
//	if this.GetSelectedRow(0) <= 0 then
//		this.Event RowFocusChanged(Row)
//	end if	
//	this.SetRow(Row)
//	this.SelectRow(0, false)
//	this.SelectRow(Row, true)
//end if
end event

event rowfocuschanged;//commented by  Nova 10.30.2009------------------------
////--------------------------- APPEON BEGIN ---------------------------
////$<add> 2006-11-29 By: Rodger Wu (doc painter)
////$<reason> 
//if this.dataobject = "dd_ctx_fields1001" then
//	This.Trigger Event ue_ctx_row( currentrow )		//Added by Scofield on 2007-08-22
//	return
//end if
////---------------------------- APPEON END ----------------------------
//
//datawindowchild dwchild
//string ltable
//string field
//string d
//
//if this.getitemstring(currentrow,"lookup_field") = "Y" then
//	dw_v2.visible = true
//	sle_value2.visible = false
//	ltable = this.getitemstring(currentrow,"lookup_code")
//	if this.getitemstring(currentrow,"lookup_type") = "C" then
//		dw_v2.dataobject = "d_c_look"
//		field = "description"
//	elseif this.getitemstring(currentrow,"lookup_type") = "A" then
//		dw_v2.dataobject = "d_a_look"
//		field = "entity_name_original"
//	end if
//	dw_v2.settransobject(sqlca)
////	dw_v2.retrieve(ltable)
////	dw_v2.insertrow(1)
//	dw_v2.GetChild( field, dwchild )
//	dwchild.SetTransObject( SQLCA )
//	dwchild.Retrieve(ltable)
//	dwchild.InsertRow( 1 )
//	dw_v2.insertrow(1)
//else
//	dw_v2.visible = false
//	sle_value2.visible = true
//	sle_value2.text = ""
//end if
//
//is_field2 = this.getitemstring(currentrow,"sys_fields_field_name")
//d = this.getitemstring(currentrow,"sys_fields_field_type")
//if d = "D" then 
//	st_date2.visible = true
//else
//	st_date2.visible = false
//end if
end event

event itemchanged;//Privilege Export - Nova 10.30.2009
if this.dataobject = "dd_ctx_fields1001_dddw" then
	This.Trigger Event ue_ctx_row( sys_fields_child2.getrow())		//Added by Scofield on 2007-08-22
	return
end if

datawindowchild dwchild
string ltable
string field
string d
string ls_field_type,ls_lookup_field

this.getchild( "field_name", sys_fields_child2)

ls_field_type=sys_fields_child2.GetItemString(sys_fields_child2.getrow(),"lookup_type")

ls_field_type=sys_fields_child2.GetItemString(sys_fields_child2.getrow(),"lookup_type")
if sys_fields_child2.GetItemString(sys_fields_child2.getrow(),"lookup_field") = "Y" then
	dw_v2.visible = true
	sle_value2.visible = false
	ltable =sys_fields_child2.GetItemString(sys_fields_child2.getrow(),"lookup_code")
	if ls_field_type = "C" then
		dw_v2.dataobject = "d_c_look"
		field = "description"
	elseif ls_field_type = "A" then
		dw_v2.dataobject = "d_a_look"
		field = "entity_name_original"
	ELSEIF ls_field_type = "D" THEN	//dddw lookup type - alfee 01.27.2010	
		IF ii_table_id = 90 THEN //privilege
			CHOOSE CASE lower(Data)
				CASE "clinical_area_id"
					dw_v2.DataObject = "d_d_look"
				CASE "priv_core_id"	
					dw_v2.DataObject = "d_s_look"
				CASE "procd_id"	
					dw_v2.DataObject = "d_p_look"
			END CHOOSE
		END IF
	//---------Begin Added by (Appeon)Harry 03.02.2015 for V151-Additional TDL Filters--------
	ELSEIF  ls_field_type = "1" THEN
		dw_v2.DataObject = "d_alert_look"
		field = "alert_id"
		dw_v2.modify("facility_id.visible='0' table_name.visible='0'")
	ELSEIF  ls_field_type = "2" THEN
		dw_v2.DataObject = "d_alert_look"
		field = "facility_id"
		dw_v2.modify("alert_id.visible='0' table_name.visible='0'")
	//---------End Added ------------------------------------------------------
	END IF
	dw_v2.settransobject(sqlca)
	dw_v2.GetChild( field, dwchild )
	dwchild.SetTransObject( SQLCA )
	IF ls_field_type = "C" or  ls_field_type = "A" THEN 
		dwchild.Retrieve(ltable)
	ELSE
		dwchild.Retrieve()
	END IF
	dwchild.InsertRow( 1 )
	dw_v2.insertrow(1)
else
	dw_v2.visible = false
	sle_value2.visible = true
	sle_value2.text = ""
end if

is_field2 = data
d = sys_fields_child2.GetItemString(sys_fields_child2.getrow(),"field_type")
if d = "D" then 
	st_date2.visible = true
else
	st_date2.visible = false
end if

//Start Code Change ----03.01.2010 #V10 maha
if LenA(ddlb_2.text) = 0 then
	ddlb_2.text = '='
end if
//End Code Change---03.01.2010


 ib_is_crit = true //Start Code Change ----09.29.2017 #V154 maha
end event

type dw_crit1 from datawindow within w_query_create
event ue_ctx_row ( integer currentrow )
integer x = 114
integer y = 428
integer width = 937
integer height = 88
integer taborder = 10
string dataobject = "d_sys_fields_for_table"
boolean border = false
end type

event ue_ctx_row(integer currentrow);//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-08-22 By: Scofield
//$<Reason> Add the process for dw_crit3

datastore    lds_dataobject
datawindowchild  dwchild, dwcquery

String  ls_dataobject, ls_column, ltable, ls_coltype, ls_dacol, ls_discol
String  ls_data, ls_display, ls_values, ls_temp
Integer  li_rowcount, i
//--------Begin Modified by  Nova 10.30.2009------------------------
//ls_column = This.GetItemString( currentrow, "field_name" )
ls_column = sys_fields_child.GetItemString(sys_fields_child.GetRow(),"field_name")
//--------End Modified --------------------------------------------

IF IsNull( ls_column ) THEN RETURN

ls_dataobject = This.Tag
lds_dataobject = Create datastore
lds_dataobject.DataObject = ls_dataobject

ls_temp = lds_dataobject.Describe( ls_column + ".dbname" )
f_get_token( ls_temp, "." )
is_field1 = ls_temp

//$<modify> 07.18.2008
//--------Begin Modified by  Nova 10.30.2009------------------------
//ls_coltype = lds_dataobject.Describe( ls_column + ".coltype" )
ls_coltype = sys_fields_child.GetItemString(sys_fields_child.GetRow(),"field_datatype" )
//--------End Modified --------------------------------------------

CHOOSE CASE LeftA ( ls_coltype , 5 )
	CASE "char(", "char"
		ls_coltype = "C"
	CASE "date" ,"datet" ,"time", "times"
		ls_coltype = "D"
	CASE "decim","numbe", "doubl", "real","long", "ulong", "int"
		ls_coltype = "N"
END CHOOSE

ls_dacol = Lower( lds_dataobject.Describe( ls_column + ".dddw.datacolumn" ) )
//---------Begin Modified by (Appeon)Toney 06.20.2013 for V141 ISG-CLX--------
//$Reason:
  /*
   IF ls_dacol = '?' Or ls_dacol = '!' THEN   
	dw_v1.Visible = False
	
	sle_value1.Text = ""
	sle_value1.Visible = True		
  */
//Start code by jervis 05.21.2009
if ls_dataobject = "d_export_contract_profile_wizard" or ls_dataobject = "d_profile_header" or ls_dataobject = "d_contract_group_linked_locations" or ls_dataobject = "d_contract_multi_group_browse" then	//Requirement Profile- 05.21.2009 By Jervis
	
	choose case ls_column
		case 'ctx_req_profile_id','requirement','category_name','parent_comp_id'
			dw_v1.Visible = True
			sle_value1.Visible = False
			dw_v1.DataObject = "d_req_profile"
			if ls_column = 'ctx_req_profile_id' then
				dw_v1.Modify( "description.dddw.name = 'd_dddw_req_profile' description.dddw.datacolumn = 'ctx_req_profile_id' description.dddw.displaycolumn = 'rqmnt_name'")
			elseif ls_column = 'requirement' then
				dw_v1.Modify( "description.dddw.name = 'd_dddw_req_element' description.dddw.datacolumn = 'element_name' description.dddw.displaycolumn = 'element_name'")
			elseif ls_column = 'category_name' then 
				dw_v1.Modify( "description.dddw.name = 'd_dddw_req_category' description.dddw.datacolumn = 'category_name' description.dddw.displaycolumn = 'category_name'")
			elseif ls_column = "parent_comp_id" then
				dw_v1.Modify( "description.dddw.name = 'd_dddw_multi_group' description.dddw.datacolumn = 'rec_id' description.dddw.displaycolumn = 'gp_name'")
			end if

			dw_v1.reset( )
			dw_v1.GetChild( "description", dwchild )
			dwchild.SetTransObject( SQLCA )
			dwchild.Retrieve()
			dwchild.InsertRow( 1 )
			dw_v1.InsertRow(1)
		case else
			dw_v1.Visible = False
			sle_value1.Visible = True
			sle_value1.Text = ""
			sle_value2.Visible = True
			sle_value2.Text = ""
			sle_value3.Visible = True
			sle_value3.Text = ""
	end choose
//End Code by jervis 05.21.2009
ElseIf ls_dacol = '?' Or ls_dacol = '!' Then  
	dw_v1.Visible = False
	sle_value1.Visible = True
	sle_value1.Text = ""
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 06.05.2007 By: Jack
	//$<reason> Fix a defect.
	sle_value2.Visible = True
	sle_value2.Text = ""
	sle_value3.Visible = True
	sle_value3.Text = ""
	//---------------------------- APPEON END ----------------------------
//---------End Modfiied ------------------------------------------------------------------
ELSEIF ls_dacol = "lookup_code" THEN
	dw_v1.Visible = True
	sle_value1.Visible = False
	
	dw_v1.DataObject = "d_c_look"
	dw_v1.GetChild( "description", dwchild )
	
	dwchild.SetTransObject( SQLCA )
	ltable = lds_dataobject.Describe( ls_column + ".tag" )
	dwchild.Retrieve( ltable )
	dwchild.InsertRow( 1 )
	dw_v1.InsertRow(1)
ELSE
	dw_v1.Visible = True
	sle_value1.Visible = False
	
	lds_dataobject.SetTransObject( SQLCA )
	lds_dataobject.InsertRow( 0 )
	lds_dataobject.GetChild( ls_column, dwcquery )
	
	ls_discol = lds_dataobject.Describe( ls_column+".dddw.DisplayColumn")
	
	li_rowcount = dwcquery.RowCount()
	FOR i = 1 To li_rowcount
		IF ls_coltype = "C" THEN
			ls_data = dwcquery.GetItemString( i, ls_dacol )
		ELSEIF ls_coltype = "D" THEN
			ls_data = String( dwcquery.GetItemDateTime( i, ls_dacol ) )
		ELSE
			ls_data = String( dwcquery.GetItemNumber( i, ls_dacol ) )
		END IF
		IF Not IsNull( ls_data ) THEN
			ls_display = dwcquery.GetItemString( i, ls_discol )
			IF Not IsNull( ls_display ) THEN
				ls_values += ls_display + "~t" +ls_data + "/"
			END IF
		END IF
	NEXT
	
	dw_v1.DataObject = "d_ctx_export_param"
	dw_v1.Modify( "ctx_values.values = '" + ls_values + "'" )
	dwchild.InsertRow( 1 )
	dw_v1.InsertRow(1)
END IF

IF ls_coltype = "D" THEN
	st_date1.Visible = True
ELSE
	st_date1.Visible = False
END IF

Destroy lds_dataobject
//---------------------------- APPEON END ----------------------------

end event

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 04.15.2009
//////////////////////////////////////////////////////////////////////
//
//commented by  Nova 10.30.2009------------------------
//if Row > 0 then
//	if this.GetSelectedRow(0) <= 0 then
//		this.Event RowFocusChanged(Row)
//	end if	
//	this.SetRow(Row)
//	this.SelectRow(0, false)
//	this.SelectRow(Row, true)
//end if
end event

event rowfocuschanged;//commented by  Nova 10.30.2009------------------------
////--------------------------- APPEON BEGIN ---------------------------
////$<add> 2006-11-29 By: Rodger Wu (doc painter)
////$<reason> 
//if this.dataobject = "dd_ctx_fields1001" then
//	This.Trigger Event ue_ctx_row( currentrow )
//	return
//end if
////---------------------------- APPEON END ----------------------------
//
//datawindowchild dwchild
//string ltable
//string field
//string d
//
//if this.getitemstring(currentrow,"lookup_field") = "Y" then
//	dw_v1.visible = true
//	sle_value1.visible = false
//	ltable = this.getitemstring(currentrow,"lookup_code")
//	if this.getitemstring(currentrow,"lookup_type") = "C" then
//		dw_v1.dataobject = "d_c_look"
//		field = "description"
//	elseif this.getitemstring(currentrow,"lookup_type") = "A" then
//		dw_v1.dataobject = "d_a_look"
//		field = "entity_name_original"
//	end if
//	dw_v1.settransobject(sqlca)
//	//dw_v1.retrieve(ltable)
//	dw_v1.GetChild( field, dwchild )
//	
//	dwchild.SetTransObject( SQLCA )
//	dwchild.Retrieve(ltable)
//	dwchild.InsertRow( 1 )
//	dw_v1.insertrow(1)
//else
//	dw_v1.visible = false
//	sle_value1.visible = true
//	sle_value1.text = ""
//end if
//
//is_field1 = this.getitemstring(currentrow,"sys_fields_field_name")
//d = this.getitemstring(currentrow,"sys_fields_field_type")
//if d = "D" then 
//	st_date1.visible = true
//else
//	st_date1.visible = false
//end if
end event

event itemchanged;//Privilege Export - Nova 10.30.2009

//IF This.DataObject = "dd_ctx_fields1001_dddw" THEN
//	This.Trigger Event ue_ctx_row( sys_fields_child.GetRow()) //Added by Scofield on 2007-08-22
//	RETURN
//END IF

datawindowchild dwchild
String ltable
String field
String d
String ls_field_type,ls_lookup_field

this.getchild( "field_name", sys_fields_child)

ls_field_type = sys_fields_child.GetItemString(sys_fields_child.GetRow(),"lookup_type")

IF sys_fields_child.GetItemString(sys_fields_child.GetRow(),"lookup_field") = "Y" THEN
	dw_v1.Visible = True
	sle_value1.Visible = False
	ltable = sys_fields_child.GetItemString(sys_fields_child.GetRow(),"lookup_code")
	IF ls_field_type = "C" THEN
		dw_v1.DataObject = "d_c_look"
		field = "description"
	ELSEIF ls_field_type = "A" THEN
		dw_v1.DataObject = "d_a_look"
		field = "entity_name_original"
	ELSEIF ls_field_type = "D" THEN	//dddw lookup type - alfee 01.27.2010	
		IF ii_table_id = 90 THEN //privilege
			CHOOSE CASE lower(Data)
				CASE "clinical_area_id"
					dw_v1.DataObject = "d_d_look"
				CASE "priv_core_id"	
					dw_v1.DataObject = "d_s_look"
				CASE "procd_id"	
					dw_v1.DataObject = "d_p_look"
			END CHOOSE
		END IF
	ELSEIF  ls_field_type = "P" THEN
		dw_v1.DataObject = "d_app_lookup"
	//---------Begin Added by (Appeon)Harry 03.02.2015 for V151-Additional TDL Filters--------
	ELSEIF  ls_field_type = "1" THEN
		dw_v1.DataObject = "d_alert_look"
		field = "alert_id"
		dw_v1.modify("facility_id.visible='0' table_name.visible='0'")
	ELSEIF  ls_field_type = "2" THEN
		dw_v1.DataObject = "d_alert_look"
		field = "facility_id"
		dw_v1.modify("alert_id.visible='0' table_name.visible='0'")
//	ELSEIF  ls_field_type = "3" THEN
//		dw_v1.DataObject = "d_alert_look"
//		field = "table_name"
//		dw_v1.modify("alert_id.visible='0' facility_id.visible='0'")
	//---------End Added ------------------------------------------------------
	END IF
	dw_v1.SetTransObject(sqlca)
	dw_v1.GetChild( field, dwchild )
	dwchild.SetTransObject( sqlca )
	IF ls_field_type = "C" or  ls_field_type = "A" THEN 
		dwchild.Retrieve(ltable)
	ELSE
		dwchild.Retrieve()
	END IF
	dwchild.InsertRow( 1 )
	dw_v1.InsertRow(1)
ELSE
	dw_v1.Visible = False
	sle_value1.Visible = True
	sle_value1.Text = ""
END IF

is_field1 = Data
d = sys_fields_child.GetItemString(sys_fields_child.GetRow(),"field_type")
IF d = "D" THEN
	st_date1.Visible = True
ELSE
	st_date1.Visible = False
END IF

//Start Code Change ----03.01.2010 #V10 maha
if LenA(ddlb_1.text) = 0 then
	ddlb_1.text = '='
end if
//End Code Change---03.01.2010
 ib_is_crit = true //Start Code Change ----09.29.2017 #V154 maha
end event

type sle_value2 from singlelineedit within w_query_create
integer x = 1600
integer y = 748
integer width = 992
integer height = 92
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_value1 from singlelineedit within w_query_create
integer x = 1605
integer y = 432
integer width = 978
integer height = 92
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type cb_return from commandbutton within w_query_create
integer x = 2757
integer y = 172
integer width = 494
integer height = 84
integer taborder = 190
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Return"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 04.13.2009
//////////////////////////////////////////////////////////////////////

if LenA(mle_syntax.Text) < 1 then
	cb_setsyntax.Event Clicked()
end if

is_Return = mle_syntax.text

Close(Parent)
end event

type cb_setsyntax from commandbutton within w_query_create
integer x = 2757
integer y = 592
integer width = 494
integer height = 84
integer taborder = 220
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Set Syntax"
end type

event clicked;of_reset_syntax("")


//string ls_op1, ls_op2, ls_op3
//string ls_val1, ls_val2, ls_val3
//string ls_ftype1, ls_ftype2, ls_ftype3
//string ls_where1, ls_where2, ls_where3
//string ls_query  //maha 05.17.2017
//n_cst_string lnv_string
//
//if of_CheckCriteia(true) = -1 then Return
//
//if is_table = "" then 
//	messagebox("","Please select a table")
//	return
//end if
//
//if is_field = "" then 
//	messagebox("","Please select a field")
//	return
//end if
//
//
//
//if ib_is_lookup then
//	ls_query = "SELECT top 1 " + is_table2 + "."  + is_field_lookup  + " from "
//else
//	ls_query = "SELECT top 1 " + is_field  + " from "
//end if
//
//if ib_is_lookup then
//	ls_query+=  + is_table + ", " + is_table2 + " "
//else
//	ls_query+=  + is_table + " "
//end if
//
////Start Code Change ----09.29.2017 #V154 maha - if no criteria skip
//if ib_is_crit  = false then 
//	mle_syntax.text = ls_query
//	return
//end if
//
//// Get field name and field type
//dw_crit1.accepttext()
//dw_crit2.accepttext()
//dw_crit3.accepttext()
//
//ls_ftype1 = sys_fields_child.GetItemString(sys_fields_child.getrow(),"field_type")
//ls_ftype2 = sys_fields_child2.GetItemString(sys_fields_child2.getrow(),"field_type")
//ls_ftype3 = sys_fields_child3.GetItemString(sys_fields_child3.getrow(),"field_type")
//
//// Get first criteria
//ls_op1 = ddlb_1.text
//if sle_value1.visible = true then
//	ls_val1 = sle_value1.text
//else
//	ls_val1 = String(il_v1)
//end if
////---------Begin Added by (Appeon)Toney 06.20.2013 for V141 ISG-CLX--------
//ls_val1 = lnv_string.of_globalreplace( ls_val1, "'","~'~'")  // Convert PB String to TSQL String --Jervis 06.15.2009
////ls_val1 = lnv_string.of_globalreplace( ls_val1, '"','~~"')
////---------End Added ------------------------------------------------------------------
//
//if Upper(ls_op1) = "IS" or Upper(ls_op1) = "IS NOT" then ls_val1 = 'Null'
//if ls_op1  = "" or ls_val1 = "" then Return
//if Upper(ls_val1) = "NULL" then ls_ftype1 = "N"
//ls_where1 = of_GetCriteria(ls_ftype1, is_field1, ls_op1, ls_val1)
//
//// Get second criteria
//ls_op2 = ddlb_2.text
//if sle_value2.visible = true then
//	ls_val2 = sle_value2.text
//else
//	ls_val2 = String(il_v2)
//end if
////---------Begin Added by (Appeon)Toney 06.20.2013 for V141 ISG-CLX--------
//ls_val2 = lnv_string.of_globalreplace( ls_val2, "'","~'~'")  // Convert PB String to TSQL String --Jervis 06.15.2009
////ls_val2 = lnv_string.of_globalreplace( ls_val2, '"','~~"')
////---------End Added ------------------------------------------------------------------
//
//if Upper(ls_op2) = "IS" or Upper(ls_op2) = "IS NOT" then ls_val2 = 'Null'
//if ls_op2  = "" or ls_val2 = "" then
//	is_where = ls_where1
//else
//	if Upper(ls_val2) = "NULL" then ls_ftype2 = "N"
//	ls_where2 = of_GetCriteria(ls_ftype2, is_field2, ls_op2, ls_val2)
//	is_where  = ls_where1 + " and " + ls_where2
//end if
//
//// Get third criteria
//ls_op3 = ddlb_3.text
//if sle_value3.visible = true then
//	ls_val3 = sle_value3.text
//else
//	ls_val3 = String(il_v3)
//end if
////---------Begin Added by (Appeon)Toney 06.20.2013 for V141 ISG-CLX--------
//ls_val3 = lnv_string.of_globalreplace( ls_val3, "'","~'~'")  // Convert PB String to TSQL String --Jervis 06.15.2009
////ls_val3 = lnv_string.of_globalreplace( ls_val3, '"','~~"')
////---------End Added ------------------------------------------------------------------
//if Upper(ls_op3) = "IS" or Upper(ls_op3) = "IS NOT" then ls_val3 = 'Null'
//if ls_op3  = "" or ls_val3 = "" then
//	//is_where = is_where
//else
//	if Upper(ls_val3) = "NULL" then ls_ftype3 = "N"
//	ls_where3 = of_GetCriteria(ls_ftype3, is_field3, ls_op3, ls_val3)
//	is_where  = is_where + " and " + ls_where3
//end if
//
//if ib_is_lookup then 
//	ls_query+= " WHERE " +  is_table + "." + is_field + " = "  + is_table2 + ".lookup_code "
//	
//end if
//
//if len(is_where) > 0 then
//	if pos(ls_query, "WHERE",1) > 0 then
//		ls_query+= " AND "	
//	else
//		ls_query+= " WHERE "
//	end if
//	ls_query = ls_query + is_where
//end if
//
//// Show criteria
//mle_syntax.text = ls_query
end event

type cb_about from commandbutton within w_query_create
boolean visible = false
integer x = 2757
integer y = 380
integer width = 494
integer height = 84
integer taborder = 210
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "&About"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 04.13.2009
//////////////////////////////////////////////////////////////////////

MessageBox("To operate this function :"," Select the field name, the operator type, and the criteria value for each portion of the filter you wish to add. You can set 1 - 3  criteria. ~rClick SET SYNTAX to build the filter.~rClick Link Fields to get link filter syntax. ~rClick return when satisfied with the filter.")
end event

type gb_7 from groupbox within w_query_create
integer x = 82
integer y = 932
integer width = 2551
integer height = 316
integer taborder = 140
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Criteria 3"
end type

type gb_6 from groupbox within w_query_create
integer x = 82
integer y = 220
integer width = 2551
integer height = 380
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Criteria 1"
end type

type gb_5 from groupbox within w_query_create
integer x = 82
integer y = 592
integer width = 2551
integer height = 340
integer taborder = 150
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Criteria 2"
end type

type gb_1 from groupbox within w_query_create
integer x = 50
integer y = 164
integer width = 2629
integer height = 1112
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "(3) Set Filter Criteria"
end type

type gb_2 from groupbox within w_query_create
integer x = 50
integer y = 1284
integer width = 2629
integer height = 444
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Query Syntax"
end type

type dw_table from datawindow within w_query_create
integer x = 87
integer y = 56
integer width = 1088
integer height = 92
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_table_list_get_table"
boolean border = false
boolean livescroll = true
end type

event itemchanged;integer ii_screen
integer r
string find
datawindowchild dwchild

ii_screen = integer(data)

dw_field.settransobject(sqlca)
r = dw_field.retrieve(ii_screen)
r = dw_field.GetChild( "field_name", dwchild )
dwchild.SetTransObject( SQLCA )
r = dwchild.Retrieve(ii_screen)

dw_field.InsertRow( 1 )

//messagebox("",ii_screen)

//dw_crit1.retrieve(ii_screen)
dw_crit1.settransobject(sqlca)
r = dw_crit1.GetChild( "field_name", dwchild )
dwchild.SetTransObject( SQLCA )
r = dwchild.Retrieve(ii_screen)
r = dw_crit1.InsertRow( 1 )

dw_crit2.settransobject(sqlca)
r = dw_crit2.retrieve(ii_screen)
r = dw_crit2.GetChild( "field_name", dwchild )
dwchild.SetTransObject( SQLCA )
r = dwchild.Retrieve(ii_screen)
dw_crit2.InsertRow( 1 )

dw_crit3.settransobject(sqlca)
dw_crit3.retrieve(ii_screen)
dw_crit3.GetChild( "field_name", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve(ii_screen)
dw_crit3.InsertRow( 1 )


//
find = "table_id = " + data
//messagebox("",find)
r = dw_table.find(find,1,dw_table.rowcount())
//messagebox("r",r)
is_table = dw_table.getitemstring(r,"sys_tables_table_name")
//messagebox("",is_table)
cb_setsyntax.enabled = false











cb_setsyntax.enabled = true
end event

type dw_field from datawindow within w_query_create
integer x = 1472
integer y = 56
integer width = 937
integer height = 88
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_sys_fields_for_table"
boolean border = false
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
end event

event itemchanged;//Start Code Change ----10.02.2017 #V154 maha - modified for lookup field
datawindowchild dwchild
String ls_table
String field
String d
String ls_field_type, ls_lookup_field
is_field = data

this.getchild( "field_name", sys_fields_child)

IF sys_fields_child.GetItemString(sys_fields_child.GetRow(),"lookup_field") = "Y" THEN
	ib_is_lookup = true
	ls_field_type = sys_fields_child.GetItemString(sys_fields_child.GetRow(),"lookup_type")
//	ltable = sys_fields_child.GetItemString(sys_fields_child.GetRow(),"lookup_code")
	is_field_lookup = sys_fields_child.GetItemString(sys_fields_child.GetRow(),"lookup_field_name")
	IF ls_field_type = "C" THEN
		is_table2 = "code_lookup"
	ELSEIF ls_field_type = "A" THEN
		is_table2 = "address_lookup"
	else
		messagebox(is_field,"Lookup Type not supported for this field")
		return
//	ELSEIF ls_field_type = "D" THEN	//dddw lookup type - alfee 01.27.2010	
//	ELSEIF  ls_field_type = "P" THEN
//	ELSEIF  ls_field_type = "1" THEN
//	ELSEIF  ls_field_type = "2" THEN
	END IF

END IF
end event

type gb_4 from groupbox within w_query_create
integer x = 50
integer width = 1362
integer height = 164
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "(1) Select Table"
end type

type gb_3 from groupbox within w_query_create
integer x = 1440
integer width = 1253
integer height = 164
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "(2) Select Field"
end type

