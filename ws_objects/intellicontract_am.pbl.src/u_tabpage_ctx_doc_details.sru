$PBExportHeader$u_tabpage_ctx_doc_details.sru
$PBExportComments$[intellicontract_tab]  Contract Contact Tab Page
forward
global type u_tabpage_ctx_doc_details from u_tabpg
end type
type dw_details from u_dw_contract within u_tabpage_ctx_doc_details
end type
type dw_1 from u_dw_contract within u_tabpage_ctx_doc_details
end type
type cb_1 from commandbutton within u_tabpage_ctx_doc_details
end type
end forward

global type u_tabpage_ctx_doc_details from u_tabpg
integer width = 3579
integer height = 1812
long backcolor = 33551856
string text = "Action Item Details"
string powertiptext = "Action Item Details"
event ue_constructor ( )
event ue_print_letters ( )
dw_details dw_details
dw_1 dw_1
cb_1 cb_1
end type
global u_tabpage_ctx_doc_details u_tabpage_ctx_doc_details

type variables
STRING IS_ORIGINAL_SQL
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2005-12-02 By: Zhang lingping
//$<reason> this variable has declare in parent object u_tabpg. Do not need 
//$<reason> declare again in here. comment out the declare code.
//tab i_parent_tab
Boolean ib_populatedddws = False
//--------------------------- APPEON END ---------------------------

n_cst_sql inv_cst_sql
n_cst_sqlattrib astr_sql[]
n_cst_string lnv_string
N_DS contract_action_type

n_ds ids_datastore

string is_prior   //01.24.2007 By Jervis
str_action_item istr_action[]
end variables

forward prototypes
public function integer of_reset_details (ref n_cst_sqlattrib astr[])
public function integer of_retrieve_data (string as_series, string as_category)
public function string of_set_filter (string as_data)
end prototypes

event ue_constructor();
////////////////////////////////////////////////////////////////////////////// 
// dw_details
//////////////////////////////////////////////////////////////////////////////
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<comment> 03.30.2006 By: Liang QingShi
//$<reason> Performance tuning
//$<modification> The following script moved to Constructor event of dw_1
//$<modification> to reduce client-server interactions. 
/*
dw_details.dataobject = 'd_cntx_action_items2'
yield()
dw_details.of_settransobject( sqlca)

dw_details.of_setbase( true)
dw_details.inv_base.of_SetColumnDisplayNameStyle ( dw_details.inv_base.HEADER )

IS_ORIGINAL_SQL =  dw_details.Describe("DataWindow.Table.Select")
 
dw_details.of_SetFilter(TRUE)
dw_details.inv_filter.of_SetColumnDisplayNameStyle(2)
dw_details.inv_filter.of_SetStyle(dw_details.inv_filter.EXTENDED)

ids_datastore = create N_DS
contract_action_type = create N_DS 
contract_action_type.DATAOBJECT = 'dddw_contract_action_type'

gnv_app.inv_dwcache.of_GetRegistered ("dddw_contract_action_type", ids_datastore)
ids_datastore.ShareData(contract_action_type)

//contract_action_type.settransobject(sqlca)
//contract_action_type.retrieve()
dw_details.SetRowFocusIndicator( Hand! )
 
 
 
 
////////////////////////////////////////////////////////////////////////////// 
// dw_1 
//////////////////////////////////////////////////////////////////////////////
dw_1.dataobject = 'd_ext_ctx_id'
dw_1.of_settransobject( sqlca)
dw_1.insertrow(0)
datawindowchild ldw_child,ldw_child2

dw_1.getchild( 'user_id', ldw_child)
long ll_row
ll_row = ldw_child.insertrow( 0)

ldw_child.setItem(ll_row,'user_id',"(NONE)")
ldw_child.setsort( "user_id A")
ldw_child.sort()

dw_1.setitem(1,'user_id', "(NONE)")
dw_1.setItem(1,'process_filter',"(NONE)")


dw_1.getchild( 'ctx_id', ldw_child2)
ldw_child2.setsort( "ctx_id A")
ldw_child2.sort()
*/
//---------------------------- APPEON END ----------------------------





end event

event ue_print_letters();/******************************************************************************************************************
**  [PUBLIC]   : ue_print_letters 
**==================================================================================================================
**  Purpose   	: Open the "Print Letters" window
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 15 november 2005  ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

str_pass lstr_pass

long ll_i
// loop though the selected columns , get the ctx_action_item_id action items
for ll_i =  1 to dw_details.rowcount( )
	if dw_details.getitemNumber(ll_i,'selected') = 1 then 
	 	lstr_pass.action_items[upperbound(lstr_pass.action_items) + 1] = dw_details.getitemNumber(ll_i,'ctx_action_item_id')
		//Start Change code by Jervis 01.27.2007 
		/*
		lstr_pass.contact_id[upperbound(lstr_pass.contact_id) + 1] = dw_details.getitemNumber(ll_i,'ctx_id')
		lstr_pass.s_u_dw = dw_details
		*/
		lstr_pass.s_string = "d_ai_letter"
		
	end if
next

// open the action item window if there are any letters selected
//if upperbound(lstr_pass.contact_id) > 0 then
if upperbound(lstr_pass.action_items) > 0 then
   openwithparm(w_ctx_print_letter,lstr_pass)
	dw_details.retrieve()
else
	messagebox(iw_parent.title, 'No letters selected. Please select some before continuing.')
end if 
end event

public function integer of_reset_details (ref n_cst_sqlattrib astr[]);/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner 03 November 2005  ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


//n_cst_string lnv_string
string ls_search_string
string error_create
string ls_criteria
string ls_filter
long ll_null
setnull(ll_null)
string ls_1


ls_search_string = 'arguments=(("doc_id", number))'

///////////////////////////////////////////////////////////////////////////////
//get the current filter
///////////////////////////////////////////////////////////////////////////////

ls_filter = dw_details.Describe("DataWindow.Table.Filter")

///////////////////////////////////////////////////////////////////////////////
//set the original sql
///////////////////////////////////////////////////////////////////////////////
dw_details.Modify("DataWindow.Table.Select='" +is_original_sql +"'")

///////////////////////////////////////////////////////////////////////////////
// remove the where clause
///////////////////////////////////////////////////////////////////////////////

inv_cst_sql.OF_parse( dw_details.Describe("DataWindow.Table.Select"), astr_sql)
astr_sql[1].s_where = "ctx_am_action_item.doc_id = ctx_am_document.doc_id " 
ls_1 = inv_cst_sql.of_Assemble(astr_sql)
dw_details.Modify("DataWindow.Table.Select='" + ls_1 +"'")

///////////////////////////////////////////////////////////////////////////////
// remove the retrival arguments 
///////////////////////////////////////////////////////////////////////////////

dw_details.Create( lnv_string.of_globalreplace( dw_details.Describe("DataWindow.Syntax") , ls_search_string, ''), error_create)
dw_details.settransobject( sqlca)
//dw_details.Object.DataWindow.Table.UpdateTable='ctx_action_items'




inv_cst_sql.OF_parse( dw_details.Describe("DataWindow.Table.Select"), astr_sql)
astr = astr_sql
dw_details.reset( )
return 0
end function

public function integer of_retrieve_data (string as_series, string as_category);/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner 03 November 2005  ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2005-12-02 By: Zhang lingping
//$<reason> The next object has declare in instance. Do not need declare in here.
//$<reason> Comment out the declare code.

//n_cst_sql inv_cst_sql
//n_cst_sqlattrib astr_sql[]
//n_cst_string lnv_string
//--------------------------- APPEON END ---------------------------
string ls_search_string
string error_create
string ls_criteria
string ls_filter
string ls_string
LONG ll_null
LONG ll_found_row
LONG LL_ACTION_TYPE
setnull(ll_null)

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 06.15.2006 By: Rodger Wu
//$<reason> The script of ue_constructor has been moved into constructor of dw_1.
/* event ue_constructor( ) */

dw_1.Trigger Event constructor()
//---------------------------- APPEON END ----------------------------

of_reset_details( astr_sql)

inv_cst_sql.OF_parse( dw_details.Describe("DataWindow.Table.Select"), astr_sql)
astr_sql[1].s_where  = "ctx_am_document.doc_id = ctx_am_action_item.doc_id"

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08.29.2006 By: LeiWei
//$<reason> Fix a defect.
astr_sql[1].s_where += " AND (ctx_am_action_item.action_user = '" + gs_user_id + "' OR (ctx_am_action_item.action_user is null and  ctx_am_action_item.print_flag is null))"
//---------------------------- APPEON END ----------------------------


string ls_sql_smnt 
// only get the records for 
//ls_sql_smnt  = "ctx_am_document.status = ( SELECT code_lookup.lookup_code FROM code_lookup WHERE ( code_lookup.lookup_name = 'Contract Document Status' ) AND ( code = 'active' ) )" 


choose CASE (as_series)
	CASE 'Needs Processing'
		//astr_sql[1].s_where = astr_sql[1].s_where + " AND ctx_action_items.print_flag = 0 AND ctx_action_items.action_status is null AND " + ls_sql_smnt
		astr_sql[1].s_where = astr_sql[1].s_where + " AND (ctx_am_action_item.print_flag >= 0 or ctx_am_action_item.print_flag is null) AND ctx_am_action_item.action_status is null" //AND " + ls_sql_smnt
	CASE 'Awaiting Response'
		//astr_sql[1].s_where = astr_sql[1].s_where + " AND ctx_action_items.print_flag = 1 AND ctx_action_items.action_status is null AND " + ls_sql_smnt
		astr_sql[1].s_where = astr_sql[1].s_where + " AND ctx_am_action_item.print_flag = -1 AND ctx_am_action_item.action_status is null"// AND " + ls_sql_smnt
	CASE ELSE
end choose 

//---------------------------- APPEON END ----------------------------

/*
ll_found_row = contract_action_type.find( "CODE = '" + as_category + "'" ,1,contract_action_type.rowcount())

if ll_found_row > 0 then 
	astr_sql[1].s_where =  astr_sql[1].s_where + ' AND ctx_am_action_item.action_type = '  +STRING(contract_action_type.getItemNumber(ll_found_row,'lookup_code'))
end if
*/
/*
dw_1.setitem(1,'process_filter',as_series)
*/
ls_string = inv_cst_sql.of_Assemble(astr_sql)
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2006-06-27 By: Liu Hongxin
//$<reason> Fix Bug.
/*
dw_details.SetSQLSelect(inv_cst_sql.of_Assemble(astr_sql))
*/
dw_details.Modify('DataWindow.Table.Select ="' +inv_cst_sql.of_Assemble(astr_sql)+ '"')
//---------------------------- APPEON END ----------------------------

dw_details.RETrieve( )

return 0
end function

public function string of_set_filter (string as_data);//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_dm_ai.of_generate_filter()
// $<arguments>
// $<returns> string
// $<description>Generate filter string
//////////////////////////////////////////////////////////////////////
// $<add> 01.13.2007 by Jervis
//////////////////////////////////////////////////////////////////////

long ll_Type,ll_Status,ll_step,ll_rec_status
string ls_user,ls_over_flag
datetime ldt_due_from,ldt_due_to
string ls_filter

dw_1.accepttext()

ll_type = dw_1.getitemNumber(1,"action_type")
ll_status = dw_1.getitemNumber(1,"action_status")

ls_user = dw_1.getitemstring(1,'action_for')

ldt_due_from = dw_1.getitemdatetime(1,"due_from")
ldt_due_to = dw_1.getitemdatetime(1,"due_to")
ll_step = dw_1.GetItemNumber(1,"step_id")
ls_over_flag = dw_1.GetItemString(1,"over_flag")
ll_rec_status = dw_1.GetItemNumber(1,"active_status")


if (not isnull(ll_type) and ll_type <> -999) then 
	ls_filter += "and action_type = " + string(ll_type) +  " "
end if
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.17.2007 By: Machongmin
//$<reason> Fix a defect.
//if (not isnull(ll_status)  and ll_type <> -999) then 
if (not isnull(ll_status)  and ll_status <> -999) then 	
//---------------------------- APPEON END ----------------------------	
	ls_filter += "and action_status = " + string(ll_status) + " "
end if
if len(trim(ls_user)) > 0 then 
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 04.11.2007 By: Machongmin
	//$<reason> Fix a defect.
	//ls_filter += "and action_user ='" + ls_user + "' " 
	ls_filter += "and upper(action_user) ='" + upper(ls_user) + "' " 
	//---------------------------- APPEON END ----------------------------
end if
if not isnull(ll_step) then 
	ls_filter += "and action_order = " + string(ll_step) + " "
end if

IF Not IsNull( ldt_due_from ) THEN
	ls_filter += "AND due_date >= Date('" + String( Date( ldt_due_from ), "yyyy-mm-dd" ) + "') "
END IF
		
IF Not IsNull( ldt_due_to ) THEN
	ls_filter += "AND due_date <= Date('" + String( Date( ldt_due_to ), "yyyy-mm-dd" ) + "') "
END IF
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.11.2007 By: Machongmin
//$<reason> Fix a defect.		
/*
if (Not IsNull(ll_rec_status) and ll_type <> -999) then
*/
if (Not IsNull(ll_rec_status) and (ll_rec_status <> -999)) then
//---------------------------- APPEON END ----------------------------
	if ll_rec_status = -1 then
		ls_filter += "and (active_status < 0) "
	elseif ll_rec_status = 1 then
		ls_filter += "and (active_status >= 0 or isnull(active_status)) "
	end if
end if

//01.30.2007 By Jervis		
if lower(left(ls_filter,4)) = "and " then 
	ls_filter = right(ls_filter, len(ls_filter)-4 )
end if

return ls_filter


end function

on u_tabpage_ctx_doc_details.create
int iCurrent
call super::create
this.dw_details=create dw_details
this.dw_1=create dw_1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_details
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.cb_1
end on

on u_tabpage_ctx_doc_details.destroy
call super::destroy
destroy(this.dw_details)
destroy(this.dw_1)
destroy(this.cb_1)
end on

event dragdrop;call super::dragdrop;// store a referance to the parent tab

i_parent_tab = this.GetParent( )
end event

event constructor;call super::constructor;//event ue_constructor( )
this.inv_resize.of_SetOrigSize(3534,1812)
this.triggerevent("resize")
end event

event resize;call super::resize;////--------------------------- APPEON BEGIN ---------------------------
////$<add> 04.28.2006 By: Rodger Wu
////$<reason> Fix a defect.
//dw_details.width = This.width - 10
////---------------------------- APPEON END ----------------------------
end event

type dw_details from u_dw_contract within u_tabpage_ctx_doc_details
integer y = 228
integer width = 3456
integer height = 1520
integer taborder = 10
string dataobject = "d_dm_doc_ai_detail_1"
end type

event retrieveend;call super::retrieveend;///******************************************************************************************************************
//**  [PUBLIC]   : event retrieveend( /*long rowcount */)
//**================================================================================================================
//**  Purpose   	: Perforem end of retrieve operations
//**==================================================================================================================
//**  Arguments 	: [none] 
//**==================================================================================================================
//**  Returns   	: [none]   
//**==================================================================================================================
//**  Notes     	: 	   
//**==================================================================================================================
//**  Created By	: Michael B. Skinner xx August 2005  ? Intellisoftgroup, Inc
//**==================================================================================================================
//**  Modification Log
//**   Changed By             Change Date                                               Reason
//** ------------------------------------------------------------------------------------------------------------------
//********************************************************************************************************************/

long ll_i 



if w_mdi.menuname = 'm_pfe_cst_action_items' then 

	if rowcount > 0 then
		 //this.object.selected.Visible = true
		 this.object.action_type.protect = 1
		 gnv_app.of_modify_menu_attr( m_pfe_cst_action_items.m_action.m_printallletters,'Enabled', true)
	else
		 gnv_app.of_modify_menu_attr( m_pfe_cst_action_items.m_action.m_printallletters,'Enabled', false)
	end if 

end if 

////////////////////////////////////////////////////////////////
// select all of the rows
////////////////////////////////////////////////////////////////


//this.setredraw( false)
//for ll_i = 1 to rowcount()
//	this.setitem(ll_i,'selected',1)
//	this.SetItemStatus(ll_i, 0,Primary!, NotModified!)
//next
//
//
//this.setredraw(true)
IF RowCount > 0 AND Upper(AppeonGetClientType())="WEB" THEN THIS.ScrollToRow(1)//(Appeon)Toney 10.12.2013 - V141 ISG-CLX Fix Reintegration BugT101002 force refresh UI of datawindow in web

return 0
end event

event clicked;call super::clicked;//if w_mdi.menuname = 'm_pfe_cst_action_items' then 
//
//	if rowcount() > 0 then
//		 this.object.selected.Visible = true
//		 this.object.action_type.protect = 1
//		 m_pfe_cst_action_items.m_action.m_printallletters.Enabled = true
//	else
//		 m_pfe_cst_action_items.m_action.m_printallletters.Enabled = false
//	end if 
//
//end if 
//messagebox("",this.dataobject)
return 0
end event

event getfocus;call super::getfocus;if w_mdi.menuname = 'm_pfe_cst_action_items' then 

	if rowcount() > 0 then
		 //this.object.selected.Visible = true
		 this.object.action_type.protect = 1
		 gnv_app.of_modify_menu_attr( m_pfe_cst_action_items.m_action.m_printallletters,'Enabled', true)
	else
		 gnv_app.of_modify_menu_attr( m_pfe_cst_action_items.m_action.m_printallletters,'Enabled', false)
	end if 

end if 

return 0
end event

event updatestart;call super::updatestart;

//Object.DataWindow.Table.UpdateTable='ctx_action_items'


return 0
end event

event updateend;call super::updateend;

if rowsupdated > 0 then 
	i_parent_tab.function dynamic of_retrieve_graph(true)
end if 
end event

event constructor;
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.24.2007 By: Jervis
//$<reason> 
/*
of_SetMultiTable(TRUE)
        
String ls_TABLE1[ ] = {"action_type","action_date","due_date","action_user","action_status","notes","alarmed","record_id","first_attempt","last_attempt","no_attempts","assigned_to","print_flag","letter_flag"}
String ls_TABLE2[ ] = {"app_facility"}
inv_multitable.of_Register ("ctx_action_items", ls_TABLE1)
inv_multitable.of_Register ("ctx_basic_info", ls_TABLE2)
*/
//---------------------------- APPEON END ----------------------------
this.of_SetDropDownCalendar(TRUE)  //Add by Jack 22.08.2007
 

end event

event retrievestart;call super::retrievestart;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.30.2006 By: Davis
//$<reason> Fix a defect.
ib_retrieve_drop_downs = False
This.event ue_populatedddws( )
//---------------------------- APPEON END ----------------------------

end event

event itemfocuschanged;call super::itemfocuschanged;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 12.04.2006 By: Jervis
//$<reason> Filter Status
datawindowchild ldwc
long ll_wf_id,ll_wf_step_id
string ls_filter

if row > 0 then
	ll_wf_id = this.GetItemNumber(row,"wf_id")
	ll_wf_step_id = this.GetItemNumber(row,"wf_action_type_id")
end if

if dwo.name = "action_status" and ll_wf_id > 0 then
	if this.GetChild(dwo.name,ldwc) = 1 then
		ls_filter = "wf_id =" + string(ll_wf_id) + " and step_id = " + string(ll_wf_step_id) 
		ls_filter = gnv_data.of_get_filter_data("workflow_status_filter",ls_filter,"lookup_code")
		
		/*
		if ls_filter <> "" then
			ls_filter += " or isnull(lookup_code) or lookup_code = -777"
		else
			ls_filter = "isnull(lookup_code) or lookup_code = -777"
		end if
		*/
		ldwc.SetFilter( ls_filter)
		ldwc.Filter()
		//this.SetRedraw( false)
		is_prior = dwo.name
	end if
elseif is_prior = "action_status" then
	if this.GetChild(is_prior,ldwc) = 1 then
		ldwc.SetFilter("")
		ldwc.Filter()
		is_prior = ""
		this.SetRedraw( true )
	end if
end if

//---------------------------- APPEON END ----------------------------

end event

event pfc_preupdate;long ll_i,ll_seq,ll_ori,ll_cur
str_action_item lstr_init[]


ll_seq = 1

//Reset str_action_item value
istr_action = lstr_init

for ll_i = 1 to rowcount()
	//$<add> 01.24.2007 By: Jervis
	//$<reason> trigger work flow when action status has be changed
	If gb_workflow Then
		IF This.GetItemStatus( ll_i, 0, Primary! ) = DataModified! then
			//if this.GetItemNumber(ll_i,"action_status",primary!,true) <> this.GetItemNumber(ll_i,"action_status") Then
			ll_ori = this.GetItemNumber(ll_i,"action_status",primary!,true)
			ll_cur = this.GetItemNumber(ll_i,"action_status")
			if ((ll_ori <> ll_cur) or (isnull(ll_ori) and not isnull(ll_cur)) or (not isnull(ll_ori) and isnull(ll_cur))) Then
				
					istr_action[ll_seq].seq_no = This.getItemnumber( ll_i, "seq_id" )
					istr_action[ll_seq].doc_id = This.getItemnumber( ll_i, "doc_id" )
					istr_action[ll_seq].ctx_id = This.getItemnumber( ll_i, "ctx_id" )	//03.29.2007 By Jervis
					istr_action[ll_seq].wf_id = this.GetItemNumber(ll_i,"wf_id")
					istr_action[ll_seq].wf_action_status_id = this.GetItemNumber(ll_i,"action_status")
					istr_action[ll_seq].wf_action_type_id = this.GetItemNumber(ll_i,"action_type")
					istr_action[ll_seq].status_changed_flag = false
					istr_action[ll_seq].module = "04"	//Contract Logix document
					istr_action[ll_seq].trigger_by = "008"		//Trigger By Action Item Changed
					istr_action[ll_seq].screen_id = -10
				if istr_action[ll_seq].wf_id > 0 and this.GetItemString(ll_i,"wf_complete_flag") = "N" THEN
					istr_action[ll_seq].wf_step_id = this.GetItemNumber(ll_i,"wf_action_type_id")
					istr_action[ll_seq].notes = this.GetItemString(ll_i,"notes")
					istr_action[ll_seq].status_changed_flag = true
				end if
				ll_seq++
			//elseif this.GetItemNumber(ll_i,"action_type",primary!,true) <> this.GetItemNumber(ll_i,"action_type") Then
			else
				ll_ori = this.GetItemNumber(ll_i,"action_type",primary!,true)
				ll_cur = this.GetItemNumber(ll_i,"action_type")
				if ((ll_ori <> ll_cur) or (isnull(ll_ori) and not isnull(ll_cur)) or (not isnull(ll_ori) and isnull(ll_cur))) Then
					istr_action[ll_seq].seq_no = This.getItemnumber( ll_i, "seq_id" )
					istr_action[ll_seq].doc_id = This.getItemnumber( ll_i, "doc_id" )
					istr_action[ll_seq].ctx_id = This.getItemnumber( ll_i, "ctx_id" )	//03.29.2007 By Jervis
					istr_action[ll_seq].wf_action_status_id = this.GetItemNumber(ll_i,"action_status")
					istr_action[ll_seq].wf_action_type_id = this.GetItemNumber(ll_i,"action_type")
					istr_action[ll_seq].status_changed_flag = false
					istr_action[ll_seq].module = "04"	//Contract Logix document
					istr_action[ll_seq].trigger_by = "008"		//Trigger By Action Item Changed
					istr_action[ll_seq].screen_id = -10
					ll_seq++
				end if
			end if
		END IF
	End if
next

return success
end event

event pfc_postupdate;call super::pfc_postupdate;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.17.2006 By: Jervis
//$<reason> modify work flow
long ll_i,ll_count
n_cst_workflow_triggers    lnv_trigger

If not gb_workflow Then return 1

lnv_trigger = create n_cst_workflow_triggers


ll_count = UpperBound(istr_action)

//2006-11-20 by jervis
For ll_i = 1 to ll_count
	if istr_action[ll_i].status_changed_flag then
		lnv_trigger.of_status_changed( istr_action[ll_i])
	end if
Next

//Create Work Flow By Action Item Changed
lnv_trigger.of_workflow_triggers(istr_action)   
//2006-11-20

destroy lnv_trigger

//refresh data
dw_details.retrieve()
return 1
//---------------------------- APPEON END ----------------------------



end event

event itemchanged;call super::itemchanged;str_action_item lstr_action
n_cst_workflow_triggers lnv_workflow
string ls_assigned_to

//01.24.2007 By jervis
if dwo.name = "action_status" then
	//Pop-up prompt when action status change	- jervis 03.10.2009
	if gb_workflow then
		lstr_action.wf_id = this.GetItemNumber(row,"wf_id")
		lstr_action.wf_step_id = this.GetItemNumber(row,"wf_action_type_id")
		ls_assigned_to = this.GetItemString( row,"action_user") //jervis 01.13.2011
		if not isnull(lstr_action.wf_id) then
			lstr_action.wf_action_status_id =  long(data) //this.GetItemNumber(row,"action_status")
			lstr_action.as_assigned_to = ls_assigned_to //jervis 01.13.2011
			lnv_workflow = create n_cst_workflow_triggers
			if lnv_workflow.of_popup_prompt( lstr_action) <> 1 then
				destroy lnv_workflow
				return 2		//Reject the data value but allow the focus to change
			end if
			destroy lnv_workflow	
		end if
	end if
	
	This.SetItem( row, "status_date", Datetime(Today()) )
end if
end event

type dw_1 from u_dw_contract within u_tabpage_ctx_doc_details
integer y = 4
integer width = 3561
integer height = 212
integer taborder = 20
string dataobject = "d_dm_ai_filter"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
boolean ib_isupdateable = false
boolean ib_retrieve_drop_downs = true
end type

event itemchanged;call super::itemchanged;//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 01-26-2007 By: Allen
//$<reason> Filter while Click the Button of filter.
/*
/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner 03 November 2005  ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2005-12-02 By: Zhang lingping
//$<reason> The next objects have declare in instance. Do not need declare in here.
//$<reason> comment out the code.
//n_cst_sql inv_cst_sql
//n_cst_sqlattrib astr_sql[]
//--------------------------- APPEON END ---------------------------
long ll_null
setnull(ll_null)
parent.setredraw( false)

CHOOSE CASE upper(DWO.NAME)

   CASE 'CTX_ID'
		    of_reset_details( astr_sql)
			 //--------------------------- APPEON BEGIN ---------------------------
			 //$<modify> 04.11.2006 By: Liang QingShi
			 //$<reason> Fix a defect.
			 /*
		    astr_sql[1].s_where = "ctx_action_items.ctx_id = " + data
			 dw_details.SetSQLSelect(inv_cst_sql.of_Assemble(astr_sql))
			 setitem(1,'user_id', "(NONE)")
			 */
			 if string(data) = '0' then
			 else
				if Len(astr_sql[1].s_where) > 1 then
		      	astr_sql[1].s_where += " and ctx_action_items.ctx_id = " + data
				else
					astr_sql[1].s_where = " ctx_action_items.ctx_id = " + data
				end if
			 end if

			 //Start Code By Jervis 01.23.2007
			 //astr_sql[1].s_where += " AND ctx_action_items.action_user = '" + gs_user_id + "'"
			 astr_sql[1].s_where += " AND (ctx_action_items.action_user = '" + gs_user_id + "' OR (ctx_action_items.action_user is null and  ctx_action_items.print_flag is null))"
			 //End 
			 
			 dw_details.Modify('DataWindow.Table.Select="' + inv_cst_sql.of_Assemble(astr_sql) + '"')
			 //---------------------------- APPEON END ----------------------------
			
			 
			 //--------------------------- APPEON BEGIN ---------------------------
			 //$<modify> 06.23.2006 By: Rodger Wu
			 //$<reason> Fix a defect.
			 //$<reason> ACTION_TYPE is string data type.
			 
			 /* this.setItem(1,'ACTION_TYPE',ll_null) */
			 
			 This.setitem(1,'action_type', "(NONE)")
			 //---------------------------- APPEON END ----------------------------
			 
			 dw_details.retrieve()
 
	CASE 'USER_ID'
		    of_reset_details( astr_sql)
			 //--------------------------- APPEON BEGIN ---------------------------
			 //$<modify> 04.11.2006 By: Liang QingShi
			 //$<reason> Fix a defect.
			 /*
			 astr_sql[1].s_where = "ctx_action_items.action_user = " + "'"+ data + "'"
			 dw_details.SetSQLSelect(inv_cst_sql.of_Assemble(astr_sql))
			 */
			 
			 //Start Code By Jervis 01.23.2007
			 //astr_sql[1].s_where += " AND ctx_action_items.action_user = '" + gs_user_id + "'"
			 astr_sql[1].s_where += " AND (ctx_action_items.action_user = '" + gs_user_id + "' OR (ctx_action_items.action_user is null and  ctx_action_items.print_flag is null))"
			 //End dw_details.Modify('DataWindow.Table.Select="' + inv_cst_sql.of_Assemble(astr_sql) + '"')
			 
			 //---------------------------- APPEON END ----------------------------
			 this.setItem(1,'ctx_id',ll_null)
			 
			 //--------------------------- APPEON BEGIN ---------------------------
			 //$<modify> 06.23.2006 By: Rodger Wu
			 //$<reason> Fix a defect.
			 //$<reason> ACTION_TYPE is string data type.
			 
			 /* this.setItem(1,'ACTION_TYPE',ll_null) */
			 
			 This.setitem(1,'action_type', "(NONE)")
			 //---------------------------- APPEON END ----------------------------
			 
		    dw_details.retrieve()
	CASE 'ACTION_TYPE'	  
		    of_reset_details( astr_sql)
			 //--------------------------- APPEON BEGIN ---------------------------
			 //$<modify> 04.11.2006 By: Liang QingShi
			 //$<reason> Fix a defect.
			 /*
			 astr_sql[1].s_where = "ctx_action_items.ACTION_TYPE = "  + data
			 dw_details.SetSQLSelect(inv_cst_sql.of_Assemble(astr_sql))
			 setitem(1,'user_id', "(NONE)")
			*/
			 if data = '-999' then
			 else
				astr_sql[1].s_where += " and ctx_action_items.ACTION_TYPE = "  + data
			 end if
			 
			 //Start Code By Jervis 01.23.2007
			 //astr_sql[1].s_where += " AND ctx_action_items.action_user = '" + gs_user_id + "'"
			 astr_sql[1].s_where += " AND (ctx_action_items.action_user = '" + gs_user_id + "' OR (ctx_action_items.action_user is null and  ctx_action_items.print_flag is null))"
			 //End 
			 
			 dw_details.Modify('DataWindow.Table.Select="' + inv_cst_sql.of_Assemble(astr_sql) + '"')
			 //---------------------------- APPEON END ----------------------------

			 /*this.setItem(1,'ctx_id',ll_null)*/
			 dw_details.retrieve()	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 10.30.2006 By: Davis
	//$<reason> Fix a defect.
	CASE "PROCESS_FILTER"
			of_reset_details( astr_sql)
			
			//Start Code By Jervis 01.23.2007
			//astr_sql[1].s_where += " AND ctx_action_items.action_user = '" + gs_user_id + "'"
			astr_sql[1].s_where += " AND (ctx_action_items.action_user = '" + gs_user_id + "' OR (ctx_action_items.action_user is null and  ctx_action_items.print_flag is null))"
			//End
			
			dw_details.Modify('DataWindow.Table.Select="' + inv_cst_sql.of_Assemble(astr_sql) + '"')

			This.setItem(1,'ctx_id',ll_null)
			This.setitem(1,'action_type', "(NONE)")
			This.setitem(1,'user_id', gs_user_id)
			
			dw_details.retrieve()	
	//---------------------------- APPEON END ----------------------------
END CHOOSE 

////////////////////////////////////////////////////////////////////////////////
// now set the PROCESS_FILTER filter
////////////////////////////////////////////////////////////////////////////////
accepttext( )

of_set_filter(getItemString(1,'process_filter'))

parent.setredraw(true)
*/
//---------------------------- APPEON END ----------------------------
end event

event constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02
//$<comment> 03.30.2006 By: Liang QingShi
//$<reason> Performance tuning
//$<modification> The following script moved from ue_constructor event of u_tabpage_ctx_ai_details
//$<modification> to reduce client-server interactions. 
//Add by Allen
this.of_setdropdowncalendar( true)
this.of_setupdateable( false)

this.ib_rmbmenu=false
//End Add by Allen
dw_details.dataobject = 'd_dm_doc_ai_detail_1'
dw_details.of_settransobject( sqlca)

dw_details.of_setbase( true)
dw_details.inv_base.of_SetColumnDisplayNameStyle ( dw_details.inv_base.HEADER )

IS_ORIGINAL_SQL =  dw_details.Describe("DataWindow.Table.Select")
 

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 01-26-2007 By: Allen
//$<reason> Changed the dataobject, New Requirement.
/*
dw_1.dataobject = 'd_ext_ctx_id'
*/
dw_1.dataobject = 'd_dm_ai_filter'
//dw_1.Modify("b_1.Y = 20 b_2.Y = 132 b_1.Height = 76 b_2.Height = 76")
//dw_1.Modify("b_1.Text = 'Clear' b_2.Text = 'Filter' b_1.Width = 200 b_2.Width = 200")
//dw_1.Modify("b_3.Visible = '0'")
//---------------------------- APPEON END ----------------------------

dw_1.of_settransobject( sqlca)
dw_1.insertrow(0)
datawindowchild ldw_child//,ldw_child2

dw_1.getchild( 'action_type', ldw_child)
ldw_child.setitem(1,'code', "(NONE)")
dw_1.setitem(1,'action_type', "(NONE)")

dw_1.AcceptText()

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.30.2006 By: Davis
//$<reason> Fix a defect.
ib_retrieve_drop_downs = False
This.event ue_populatedddws( )
//---------------------------- APPEON END ----------------------------

end event

event buttonclicked;call super::buttonclicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01-26-2007 By: Allen
//$<reason> Filter
if row < 1 then return

String  ls_Filter

IF dwo.name='b_clear' then	//Clear Filter
		This.Reset()
		This.InsertRow( 0 )
		ls_Filter=""
		
		dw_details.SetFilter("")
		dw_details.Filter()
ELSEIF dwo.name='b_filter' THEN	//Apply Filter
	ls_filter = of_Set_filter("")
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.11.2007 By: Machongmin
//$<reason> Fix a defect.	
elseif dwo.name='b_me' then
	this.object.action_for[row] = gs_user_id
	ls_filter = of_Set_filter("")
//---------------------------- APPEON END ----------------------------
ELSE
	RETURN
END IF

iw_parent.setmicrohelp( "Filter: "+ls_Filter)	//Modified by Scofield on 2008-12-31: Change '=' to ':'
dw_details.setfilter(ls_Filter)
dw_details.filter()
//---------------------------- APPEON END ----------------------------
end event

type cb_1 from commandbutton within u_tabpage_ctx_doc_details
boolean visible = false
integer x = 3118
integer y = 76
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Filter"
end type

event clicked;dw_details.inv_filter.Event pfc_FilterDlg()
end event

