$PBExportHeader$u_tabpg_contract_action_items_det_detail.sru
forward
global type u_tabpg_contract_action_items_det_detail from u_tabpg_contract_master
end type
type dw_1 from u_dw_contract within u_tabpg_contract_action_items_det_detail
end type
type dw_filter from u_dw_contract within u_tabpg_contract_action_items_det_detail
end type
end forward

global type u_tabpg_contract_action_items_det_detail from u_tabpg_contract_master
integer width = 3863
integer height = 1892
long backcolor = 33551856
string text = "Detail"
string powertiptext = "Action item detail"
event pfc_cst_manual_workflow ( )
event ue_set_screen_properties ( )
dw_1 dw_1
dw_filter dw_filter
end type
global u_tabpg_contract_action_items_det_detail u_tabpg_contract_action_items_det_detail

type variables
Long il_ctxid[] //Added by Alfee 07.27.2007
Long il_ctx_action_item_id  //Add by Jack 06/22/2007
String is_prior //Added By Jervis 04.12.2006
String is_table[], is_column[] //Added by Alfee 07.27.2007
long il_doc_id_arr[],il_level_id1[],il_level_id2[] //add by jevis 06.30.2011

Boolean ib_open_window

str_pass lstr_pass 
str_action_item istr_action[] //<add> 11.17.2006 By: Jervis
n_ds ids_get_default_address
n_ds ids_notification_years //Added by Alfee 07.31.2007









end variables

forward prototypes
public function integer of_retrieve ()
public function integer of_action_type (long row, string data)
public function integer of_action_email (long row, long al_ctx_id)
public function integer of_print_letter (long row, string data)
public function integer of_print_letter ()
public subroutine of_set_flags ()
public subroutine of_showhidesearch (boolean ab_show)
public function integer of_update_ctx_notification (long al_ctxid[], string as_table[], string as_column[], long al_docid[], long al_level_id1[], long al_level_id2[])
end prototypes

event pfc_cst_manual_workflow();//Added for work flow trigger. 17/11/2006 Jervis
string	ls_rtn
if of_check_read_only( ) then return   //Add by Jack 08.30.2007

str_manual_wf lstr_workflow
lstr_workflow.is_module = '03'
lstr_workflow.ctx_id  = inv_contract_details.of_get_ctx_id( )
OpenWithParm(w_manual_workflow_list , lstr_workflow)

ls_rtn = Message.stringparm

If ls_rtn = 'OK' Then of_retrieve()
end event

event ue_set_screen_properties();string ls_Modify

// Set Action Item List screen properties
dw_1.of_set_properties(dw_1.il_ViewID, dw_1.il_ScreenID, "Y")

// Set Action Item Filter screen properties with Action Item List properties
dw_filter.of_set_properties(dw_1.il_ViewID, dw_1.il_ScreenID, "Y")
ls_Modify = "datawindow.color=" + dw_1.Describe("datawindow.color")
dw_filter.Modify(ls_Modify)
dw_filter.Title = "Action Item Filter"
dw_filter.is_title_bar_text = dw_filter.Title
end event

public function integer of_retrieve ();/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner  16 June 2005
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 10.18.2006 By: LeiWei
//$<reason> Fix a defect.
/*
if not ib_retrieved then
	 dw_1.event pfc_retrieve( )
end if

ib_retrieved = true
*/

dw_1.event pfc_retrieve( )

//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.16.2006 By: LeiWei
//$<reason> When a user clicks into Action Items tab if the record count
//$<reason> is zero have an empty Action Item record waiting for entry. 
//$<reason> If no modification is made then just delete when leaving tab.

IF dw_1.Rowcount( ) = 0 THEN
	dw_1.event pfc_addrow( )
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 12.05.2006 By: Jervis
//$<reason> 
else
	//dw_1.SetFilter( "active_status >= 0 or (isnull(active_status))")
	//dw_1.Filter()
//---------------------------- APPEON END ----------------------------
END IF
//---------------------------- APPEON END ----------------------------

of_set_flags() //Set flag button - Alfee 02.26.2008

//---------Begin Added by (Appeon)Harry 03.10.2014 for V142 ISG-CLX--------
//-------------appeon begin----------------------
//<$>added:long.zhang 07.22.2013
//<$>reason:dddw refresh issue Bug 3609
if appeongetclienttype() = "WEB" then
	dw_1.ib_retrieve_drop_downs = false
	dw_1.event ue_populatedddws()
end if
//-------------appeon End------------------------
//---------End Added ------------------------------------------------------

RETURN SUCcess
end function

public function integer of_action_type (long row, string data);/******************************************************************************************************************
**  [PUBLIC]   : of_action_type
**==================================================================================================================
**  Purpose   	: Open 
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

datawindowchild dwchild
Long ll_lookup_code
ll_lookup_code =  Long (Data)
String ls_lookup_disp

dw_1.GetChild('action_type',dwchild)
dw_1.AcceptText( ) // yes i know this is bad - but it has never been an issue before
ls_lookup_disp = dw_1.Describe("Evaluate('LookupDisplay(action_type)', " + String(row) + ")")


String ls_desc
String ls_cus_6
Long ll_wf_id,ll_step_id,ll_action_status,ll_print_flag


//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<add> 01.17.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Write script to retrieve data from a cache instead of from the database.

/*
select description,custom_6
into :lstr_pass.s_string_array[1],:lstr_pass.s_string
from  code_lookup
where lookup_code = :ll_lookup_code;
*/
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 12.05.2006 By: Jervis
//$<reason> 
/*
lstr_pass.s_string_array[1] = gnv_data.of_getitem("code_lookup","description","lookup_code = " + String(ll_lookup_code))
lstr_pass.s_string = gnv_data.of_getitem("code_lookup","custom_6","lookup_code = " + String(ll_lookup_code))
*/
lstr_pass.s_string_array[1] = gnv_data.of_getitem("code_lookup","description","lookup_code = " + String(ll_lookup_code))
ll_wf_id = dw_1.GetItemNumber(row,"wf_id")

If ll_wf_id  > 0 And gb_workflow Then
	ll_print_flag = dw_1.GetItemNumber(row,"print_flag")
	If ll_print_flag < 1 Then
		MessageBox("Print Letter","The current letter can't be printed.")
		Return SUCCESS
	End If
	ll_step_id = dw_1.GetItemNumber(row,"wf_action_type_id")
	ll_action_status = dw_1.GetItemNumber(row,"action_status")
	
	If IsNull(ll_action_status) Then
		Select t2.document_name,t2.use_export,t2.export_id
			Into :lstr_pass.s_string,:lstr_pass.s_long[1],:lstr_pass.s_long[2]
			From wf_action_status t1,sys_letters t2
			Where t1.wf_id = :ll_wf_id And t1.step_id = :ll_step_id And t1.action_status_id is null And
			t1.letter_id = t2.letter_id;
	Else
		Select t2.document_name,t2.use_export,t2.export_id
			Into :lstr_pass.s_string,:lstr_pass.s_long[1],:lstr_pass.s_long[2]
			From wf_action_status t1,sys_letters t2
			Where t1.wf_id = :ll_wf_id And t1.step_id = :ll_step_id And t1.action_status_id = :ll_action_status And
			t1.letter_id = t2.letter_id;
	End If
Else
	lstr_pass.s_string = gnv_data.of_getitem("code_lookup","custom_6","lookup_code = " + String(ll_lookup_code))
End If
//---------------------------- APPEON END ----------------------------
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 10.10.2006 By: LeiWei
//$<reason> Fix a defect.
/*
if Match(upper(ls_lookup_disp), 'LTR') THEN
dw_1.setItem(row,'letter_flag','Y')
*/

String ls_letter_flag
ls_letter_flag = dw_1.GetItemString(row,'letter_flag')
If Upper(ls_letter_flag) <> 'N' Or IsNull(ls_letter_flag) Then
	dw_1.SetItem(row,'letter_flag','Y')
End If

//---------------------------- APPEON END ----------------------------

// check to see if there is a default email address for both to and from
If ids_get_default_address.Retrieve( inv_contract_details.of_get_ctx_id( ) ) < 2 Or ib_open_window Then
	lstr_pass.s_u_dw =   dw_1
	
	
	If Not f_validstr(lstr_pass.s_string ) Then
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 12.05.2006 By: Jervis
		//$<reason> 
		//messagebox('Missing Document Name', 'The custom 6 field needs to have a document name for the Contract Action Type:' + string(lstr_pass.s_string))
		If ll_wf_id > 0 And gb_workflow Then
			MessageBox('Missing Document Name', 'The document name is invalid.')
		Else
			MessageBox('Missing Document Name', 'The Action Item Type you have selected does not have a Word Document associated with it.  To associate a Word document with this Action Item Type go to the System->Painters->Lookup Painter and fill in the Word document field of the lookup record.')
		End If
		//---------------------------- APPEON END ----------------------------
		Return failure
	End If
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 04.28.2006 By: LeiWei
	//$<reason> Fix a defect.
				/*
			     lstr_pass.action_items[upperbound(lstr_pass.action_items) + 1] = dw_1.getitemNumber(row,'ctx_action_item_id')
				  lstr_pass.contact_id[upperbound(lstr_pass.contact_id) + 1] = inv_contract_details.of_get_ctx_id( )
	*/
	lstr_pass.action_items[1] = dw_1.GetItemNumber(row,'ctx_action_item_id')
	lstr_pass.contact_id[1] = inv_contract_details.of_get_ctx_id( )
	//---------------------------- APPEON END ----------------------------
	of_update( True, True)
	
	OpenWithParm(w_select_address,lstr_pass)
	of_update( True, True)
End If

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 10.10.2006 By: LeiWei
//$<reason> Fix a defect.
// end if 
//---------------------------- APPEON END ----------------------------

Return 1



end function

public function integer of_action_email (long row, long al_ctx_id);//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.28.2006 By: LeiWei
//$<reason> To be manually force the system to generate an email.
String ls_sql
String ls_action_type
String ls_alm_column
String ls_user_id
Long ll_lookup_code


ls_user_id = dw_1.GetitemString( row, "action_user" )
ll_lookup_code = dw_1.getitemNumber(row,'action_type')
ls_action_type = gnv_data.of_getitem("code_lookup","code","lookup_code = " + String(ll_lookup_code))
choose case lower(ls_action_type)
	case lower('AlmEffDt')
		ls_alm_column = 'effective_date'
	case lower('AlmCus2DT')
		ls_alm_column = 'other_date_2'
	case lower('AlmTmDt')
		ls_alm_column = 'term_date'
	case lower('AlmRevDt')
		ls_alm_column = 'review_date'
	case lower('AlmExpDt')
		ls_alm_column = 'expriation_date'
	case lower('AlmCusDt')
		ls_alm_column = 'other_date_1'
 	case lower('AlmTermDt')
		ls_alm_column = 'term_date'
	case else
		return 1
end choose

n_cst_notification  lnvo_notification
lnvo_notification =  create n_cst_notification

// Set filter condition
ls_sql = lnvo_notification.ids_alm_status.getsqlselect( )
ls_sql = ls_sql + " and (ctx_basic_info.ctx_id = " + String(al_ctx_id) + ") and (ctx_notification.alm_column = '" + ls_alm_column + "') "
lnvo_notification.ids_alm_status.Modify('datawindow.table.select = "' + ls_sql + '"')

//ls_sql = lnvo_notification.ids_alarm_notification_users.getsqlselect( )
//ls_sql = ls_sql + " and (ctx_notification.ctx_id = " + String(al_ctx_id) + ") and (ctx_notification.alm_column = '" + ls_alm_column + "') and (ctx_notification_users.user_id = '" + ls_user_id + "') "
//lnvo_notification.ids_alarm_notification_users.Modify('datawindow.table.select = "' + ls_sql + '"')
//
lnvo_notification.of_start_notification_process( )

dw_1.event pfc_retrieve( )

destroy lnvo_notification

return 1
//---------------------------- APPEON END ----------------------------

end function

public function integer of_print_letter (long row, string data);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_print_letter
//
//	Arguments:  
//
//	Returns:  integer
//
//	Description:replace of_action_type 
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version By Jervis
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright ?2001-2006 Appeon, Inc. All rights reserved.
//
//////////////////////////////////////////////////////////////////////////////

Long 		ll_wf_id,ll_step_id,ll_action_status,ll_print_flag
string 	ls_doc,ls_action_desc,ls_WorkFlow
long 		ll_use_export,ll_export_id,ll_ret,ll_count
datetime ldt_today

if of_check_read_only( ) then return success  //Add by Jack 08.30.2007

ll_wf_id = dw_1.GetItemNumber(row,"wf_id")

//Get the name of document 
If ll_wf_id  > 0 and gb_workflow Then
	ll_print_flag = dw_1.GetItemNumber(row,"print_flag")
	If ll_print_flag < 1 Then
		MessageBox("Print Letter","In accordance with the work flow step,the maximum amount of times to send this letter has been reached.")
		Return 1
	End If
	ll_step_id = dw_1.GetItemNumber(row,"wf_action_type_id")
	ll_action_status = dw_1.GetItemNumber(row,"action_status")
	if isnull(ll_action_status) then
		Select t2.document_name,t2.use_export,t2.export_id
		Into :ls_doc,:ll_use_export,:ll_export_id
		From wf_action_status t1,sys_letters t2
		Where t1.wf_id = :ll_wf_id And t1.step_id = :ll_step_id And t1.action_status_id is null And
		t1.letter_id = t2.letter_id;
	else
		Select t2.document_name,t2.use_export,t2.export_id
		Into :ls_doc,:ll_use_export,:ll_export_id
		From wf_action_status t1,sys_letters t2
		Where t1.wf_id = :ll_wf_id And t1.step_id = :ll_step_id And t1.action_status_id = :ll_action_status And
		t1.letter_id = t2.letter_id;
	end if
Else
	ls_doc = gnv_data.of_getitem("code_lookup","custom_6","lookup_code = " + data)
	ls_action_desc = gnv_data.of_getitem("code_lookup","description","lookup_code = " + data)
End If


If Not f_validstr(ls_doc) Then
	If ll_wf_id > 0 and gb_workflow Then
		//--------------------------- APPEON BEGIN ---------------------------
		//$<Modify> 2008-03-14 By: Scofield
		//$<Reason> Display more detail information.

		//MessageBox('Missing Document Name', 'The document name is invalid.')
		select wf_name into :ls_WorkFlow from wf_workflow where wf_id = :ll_wf_id;
		MessageBox(gnv_app.iapp_object.DisplayName, "Cannot open document, because no letter is specified for the " + ls_WorkFlow + " WorkFlow.")
		//---------------------------- APPEON END ----------------------------
	Else
		MessageBox('Missing Document Name', 'The Action Item Type you have selected does not have a Word Document associated with it.  To associate a Word document with this Action Item Type go to the System->Painters->Lookup Painter and fill in the Word document field of the lookup record.')
	End If
	Return -1
End If

//Print the Document
n_cst_ctx_letter lnv_ctx_letter

lnv_ctx_letter = create n_cst_ctx_letter

if ll_use_export = 1 then	//From Export Painter Data
	ll_ret = lnv_ctx_letter.of_export_letter(ls_doc,0,inv_contract_details.of_get_ctx_id(),0,ll_export_id)
else								//From Contract Data
	ll_ret = lnv_ctx_letter.of_export_letter(ls_doc,1,inv_contract_details.of_get_ctx_id(),0,dw_1.GetItemNumber(row,'ctx_action_item_id'))
end if
destroy lnv_ctx_letter

//Update number of print
if ll_ret = 1 then
	dw_1.SetItem(row,"letter_flag","Y")
	dw_1.SetItem(row,"print_flag",-1)
	ldt_today = f_get_server_dtm()
	if not f_validstr(string(dw_1.GetItemDatetime(row,"first_attempt"))) then
			dw_1.SetItem(row,"first_attempt",ldt_today)
	end if 		
	dw_1.SetItem(row,"last_attempt",ldt_today)
	ll_count = dw_1.GetItemNumber(row,"no_attempts")
	if isnull(ll_count) or ll_count < 1 then
		dw_1.SetItem(row,"no_attempts",1)
	else
		dw_1.SetItem(row,"no_attempts",ll_count + 1)
	end if

	dw_1.accepttext( )
	gnv_appeondb.of_autocommit( )
	dw_1.UPDATE()
	commit;
else
	MessageBox("Letter error","Failed to print letter.")
end if

return ll_ret



end function

public function integer of_print_letter ();long ll_item_id[]
long ll_i,ll_count,ll_k
long ll_wf_id
str_pass lstr_pass1

//--------------------------- APPEON BEGIN ---------------------------
//$<add>    06.12.2007 By: Andy
//$<reason> multiple print letter
if of_check_read_only( ) then return success  //Add by Jack 08.30.2007

IF dw_1.accepttext( )< 1 THEN return -1
IF dw_1.deletedcount( )+dw_1.modifiedcount( ) > 0 THEN
	messagebox("Print Letter","Data has been changed. Please save your modifications before printing letter(s).",exclamation!)
	return -1
END IF

ll_count = dw_1.RowCount()
for ll_i = 1 to ll_count
	ll_wf_id = dw_1.GetItemNumber(ll_i,"wf_id")
	if ll_wf_id > 0 and  dw_1.GetItemNumber(ll_i,"print_flag") >0 then
		ll_k++		
		ll_item_id[ll_k] = dw_1.GetItemNumber(ll_i,"ctx_action_item_id")
	elseif isnull(ll_wf_id) then
		ll_k++
		ll_item_id[ll_k] = dw_1.GetItemNumber(ll_i,"ctx_action_item_id")
	end if
next

if ll_k > 0 then
	lstr_pass1.s_string = "d_ai_letter"
	lstr_pass1.action_items = ll_item_id
	openwithparm(w_ctx_print_letter,lstr_pass1)
	of_retrieve()
else	
	MessageBox("Print Letter","No letters to print.")
end if

return 1
//---------------------------- APPEON END ----------------------------

end function

public subroutine of_set_flags ();//Set flag button - Added by Alfee 02.26.2008

Long ll_cnt, i, ll_ctx_id, ll_action_item_id

ll_ctx_id = inv_contract_details.of_get_ctx_id( )

ll_cnt = dw_1.RowCount()
FOR i = 1 to ll_cnt
	ll_action_item_id = dw_1.object.ctx_action_item_id[i]
	//add custom multi process - jervis 07.07.2011
	//dw_1.object.due_date_flag[i] = f_set_ai_flag('ctx_action_item', 'due_date', ll_ctx_id, ll_action_item_id )
	dw_1.object.due_date_flag[i] = f_set_ai_flag('ctx_action_item', 'due_date', ll_ctx_id, 0,ll_action_item_id ,0)
	dw_1.SetItemStatus(i, 'due_date_flag', Primary!, NotModified!)
NEXT

dw_1.Post setredraw(true) //for the refresh bug - 03.11.2008 
end subroutine

public subroutine of_showhidesearch (boolean ab_show);//====================================================================
// Function: of_ShowHideSearch()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    boolean    ab_Show
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2010-05-12
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long	ll_BottomSpace

if ab_Show then
	if dw_Filter.Visible then Return
	dw_Filter.Visible = true
	
	ll_BottomSpace = This.Height - dw_1.Y - dw_1.Height
	dw_1.Y = dw_Filter.Y + dw_Filter.Height + 20
	dw_1.Height = This.Height - ll_BottomSpace - dw_1.Y
else
	if Not dw_Filter.Visible then Return
	dw_Filter.Visible = false
	
	ll_BottomSpace = This.Height - dw_1.Y - dw_1.Height
	dw_1.Y = dw_Filter.Y
	dw_1.Height = This.Height - ll_BottomSpace - dw_1.Y
	
	dw_1.SetFocus()
end if

if IsValid(m_pfe_cst_mdi_menu_contract) then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_view.m_filter,'ToolbarItemVisible', true)
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_view.m_filter,'ToolbarItemDown', ab_Show)
end if

end subroutine

public function integer of_update_ctx_notification (long al_ctxid[], string as_table[], string as_column[], long al_docid[], long al_level_id1[], long al_level_id2[]);string ls_table_1[],ls_column_1[]
long ll_docid_1[],ll_level_id1_1[],ll_level_id2_1[],ll_ctxid_1[]
string ls_table_2[],ls_column_2[]
long ll_docid_2[],ll_level_id1_2[],ll_level_id2_2[],ll_ctxid_2[]
long ll_i,ll_j,ll_k,ll_count

n_cst_notification lnv_notification
lnv_notification = Create n_cst_notification

ll_count = Upperbound(as_table)
for ll_i = 1 to ll_count
	choose case lower(as_table[ll_i])
		case 'ctx_basic_info','ctx_custom'
			ll_j++
			ll_ctxid_1[ll_j] = al_ctxid[ll_i]
			ls_table_1[ll_j] = as_table[ll_i]
			ls_column_1[ll_j] = as_column[ll_i]
			//ll_docid_1[ll_j] = al_docid[ll_i]
			//ll_level_id1_1[ll_j] = al_level_id1[ll_i]
			//ll_level_id2_1[ll_j] = al_level_id2[ll_i]
		//case 'ctx_custom_multi_hdr','ctx_custom_multi_detail'
		case else //add fee scheduce - jervis 08.02.2011
			ll_k++
			ll_ctxid_2[ll_k] = al_ctxid[ll_i]
			ls_table_2[ll_k] = as_table[ll_i]
			ls_column_2[ll_k] = as_column[ll_i]
			ll_docid_2[ll_k] = al_docid[ll_i]
			ll_level_id1_2[ll_k] = al_level_id1[ll_i]
			ll_level_id2_2[ll_k] = al_level_id2[ll_i]
	end choose
next

if ll_j > 0 then lnv_notification.of_update_ctx_notification(ll_ctxid_1[], ls_table_1[],ls_column_1[])
if ll_k > 0 then lnv_notification.of_update_ctx_notification(ll_ctxid_2[], ls_table_2[],ls_column_2[],ll_docid_2,ll_level_id1_2,ll_level_id2_2)
Destroy lnv_notification
Return 1

/*//Commented By Ken.Guo 2009-09-11. Moved to n_cst_notification object.
//Update the CTX notification parms while the action items' changed to be complete status
//Added by Alfee 07.27.2007
Long i, j, ll_c, ll_t, ll_cnt, ll_cnt_years, ll_found
Long ll_delay, ll_ctx[] //Repace ll_years with ll_deplay - Alfee 02.22.2008
String ls_table[], ls_sql, ls_tabname, ls_colname, ls_criteria, ls_unit
Boolean lb_ctx_duplicate, lb_tab_duplicate

ll_cnt = UpperBound(as_column) 
IF ll_cnt < 1 THEN RETURN 0
IF Len(Trim(as_column[1])) < 1 THEN RETURN 0

//Get distinct ctx ids & table names
ll_c = 1
ll_t = 1
FOR i = 1 to ll_cnt
	IF i > 1 THEN 
		lb_ctx_duplicate = FALSE
		lb_tab_duplicate = FALSE
		FOR j = 1 to UpperBound(ll_ctx)
			IF ll_ctx[j] = al_ctxid[i] THEN 
				lb_ctx_duplicate = TRUE
				EXIT //Skip duplicated ctx id	
			END IF
		NEXT		
		FOR j = 1 to UpperBound(ls_table)
			IF ls_table[j] = as_table[i] THEN 
				lb_tab_duplicate = TRUE
				EXIT //Skip duplicated table name
			END IF
		NEXT
		IF Not lb_ctx_duplicate THEN 
			ll_ctx[ll_c] = al_ctxid[i]
			ll_c ++
		END IF
		IF Not lb_tab_duplicate THEN 
			ls_table[ll_t] = as_table[i]
			ll_t ++
		END IF			
	ELSE
		ll_ctx[ll_c] = al_ctxid[1]
		ls_table[ll_t] = as_table[1]
		ll_c ++
		ll_t ++		
	END IF	
NEXT

//Get all relative auto increment years
ll_cnt_years = ids_notification_years.Retrieve(ll_ctx, ls_table, as_column)
IF ll_cnt_years < 1 THEN RETURN 0

//Update alarm notification parameters
FOR i = 1 to ll_cnt
	IF IsNull(as_table[i]) or Len(Trim(as_table[i])) < 1 THEN Continue
	IF IsNull(as_column[i]) or Len(Trim(as_column[i])) < 1 THEN Continue

	ls_criteria  = "ctx_id = " + String(al_ctxid[i]) + " And alm_table = '" 
	ls_criteria += as_table[i] + "' And alm_column = '" + as_column[i] + "'"
	ll_found = ids_notification_years.Find(ls_criteria, 1, ll_cnt_years)
	IF ll_found < 1 THEN Continue
	
	ll_delay = ids_notification_years.GetItemNumber(ll_found, 'alm_auto_increment_years')
	//----------------Begin Added by Alfee 02.22.2008-----------------------------------
	IF IsNull(ll_delay) or ll_delay <= 0 THEN Continue

	ls_unit = ids_notification_years.GetItemString(ll_found, 'alm_auto_increment_unit')
	IF Upper(ls_unit) = 'M' THEN 
		ls_unit = 'Month'
	ELSEIF Upper(ls_unit) = 'D' THEN
		ls_unit = 'Day'
	ELSE
		ls_UNIT = 'Year'
	END IF
	//----------------End Added --------------------------------------------------------
	
	ls_sql += "Update " + as_table[i] 
	//ls_sql += "   Set " + as_column[i] + " = DateAdd(year, " + String(ll_delay) + ", " + as_column[i] + ") "  
	ls_sql += "   Set " + as_column[i] + " = DateAdd(" + ls_unit + ", " + String(ll_delay) + ", " + as_column[i] + ") "  //Alfee 02.22.2008	
	ls_sql += " Where " + as_table[i] + ".ctx_id = " + String(al_ctxid[i]) + "; ~r~n"

	ls_sql += "Update ctx_notification" 
	//ls_sql += "   Set alm_total_tries_counter = Null, alm_last_notification_sent = Null" 
	ls_sql += "   Set alm_total_tries_counter = Null, alm_last_notification_sent = Null, alm_last_wf_trigger = Null" 	
	ls_sql += " Where ctx_id = " + String(al_ctxid[i]) 
	ls_sql += "   AND alm_table = '" + as_table[i] + "' AND alm_column = '" + as_column[i] + "' ; ~r~n"
NEXT

IF Len(Trim(ls_sql)) > 0 THEN 
	EXECUTE IMMEDIATE :ls_sql ;	

	//Refresh the detail tabpage
	IF SQLCA.SQLCode = 0 and IsValid(gw_contract) THEN
		gnv_data.ids_ctx_notification.Retrieve() //added by Alfee 08.27.2007				
		gw_contract.tab_contract_details.of_set_select('tabpage_details', FALSE)	
	END IF		
END IF
	
Return 1
*/
end function

on u_tabpg_contract_action_items_det_detail.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_filter=create dw_filter
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_filter
end on

on u_tabpg_contract_action_items_det_detail.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_filter)
end on

event ue_selectionchanged;call super::ue_selectionchanged;

this.dw_1.setfocus( )
end event

event constructor;call super::constructor;ids_get_default_address = create n_ds 
ids_get_default_address.dataobject = 'd_get_default_address'
ids_get_default_address.settransobject(sqlca)

//-------Begin Added by Alfee 07.31.2007------------------------
ids_notification_years = Create n_ds
ids_notification_years.DataObject = 'd_alarm_notification_years'
ids_notification_years.settransobject(sqlca)
//-------End Added ---------------------------------------------

of_ShowHideSearch(false)

end event

event destructor;call super::destructor;IF IsValid(ids_notification_years) THEN Destroy ids_notification_years //Alfee 07.31.2007
end event

event ue_initinstancevar;call super::ue_initinstancevar;long ll_Null[]
string ls_Null[]
str_action_item lstr_Null[]

il_ctxid[] = ll_Null[]
il_ctx_action_item_id = 0
is_prior = ""
is_table[] = ls_Null[]
is_column[] = ls_Null[]
ib_open_window = false
istr_action[] = lstr_Null[]
end event

type st_1 from u_tabpg_contract_master`st_1 within u_tabpg_contract_action_items_det_detail
integer x = 64
integer y = 2004
integer width = 3703
integer height = 60
end type

type dw_1 from u_dw_contract within u_tabpg_contract_action_items_det_detail
string tag = "Action Item List"
integer y = 420
integer width = 3840
integer height = 1436
integer taborder = 10
boolean bringtotop = true
boolean titlebar = true
string title = "Action Item List"
string dataobject = "d_cntx_action_items"
boolean livescroll = false
boolean ib_rmbmenu = false
string dataobject_original = "d_cntx_action_items"
end type

event constructor;call super::constructor;//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2009-01-12 By: Scofield
//$<Reason> Add Sort function

if Not IsValid(iw_Parent) or IsNull(iw_Parent) then
	of_GetParentWindow(iw_Parent)
end if

of_SetSort(TRUE)
inv_Sort.of_SetColumnHeader(TRUE)

//---------------------------- APPEON END ----------------------------

this.of_SetDropDownCalendar(TRUE)
this.of_SetReqColumn(TRUE)					//Added by Scofield on 2009-01-14

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 09.06.2006 By: LeiWei
//$<reason> Performance tuning.
/*
this.iuo_calendar.of_Register("action_date", this.iuo_calendar.DDLB_WITHARROW	)
this.iuo_calendar.of_Register("due_date", this.iuo_calendar.DDLB_WITHARROW	)
*/
//---------------------------- APPEON END ----------------------------

//this.SetRowFocusIndicator(hand!)		//Added by Scofield on 2009-12-11

ib_RMBMenu = true								//Added by Scofield on 2009-09-21

end event

event pfc_preupdate;call super::pfc_preupdate;/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner  
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

long ll_i,ll_seq,ll_ori,ll_cur
Long ll_j, ll_k, ll_count, ll_arrcnt, ll_complete, ll_ctxid, ll_found, ll_null[]
String ls_alm_table, ls_alm_column, ls_action_user, ls_filter_ori, ls_criteria, ls_null[],ls_Notes
boolean lb_completed, lb_duplicated 
long ll_docid,ll_level_id1,ll_level_id2
string 		ls_assigned_to,ls_assigned_by		//Added By Mark Lee 09/10/12
Boolean		lb_flag									//Added By Mark Lee 09/10/12	

//Initilize variables
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.20.2006 By: Jervis
ll_seq = 1
str_action_item lstr_init[]
istr_action = lstr_init //Reset str_action_item value
//---------------------------- APPEON END ----------------------------
If this.getrow() > 0 Then 	il_ctx_action_item_id = this.getitemnumber(this.getrow(),'ctx_action_item_id') //$<add> 06.22.2007 By: Jack
//-------------Begin Modified by Alfee 07.27.2007 -----------------------
ll_j = 1
il_ctxid = ll_null
is_table = ls_null
is_column = ls_null
il_doc_id_arr = ll_null
il_level_id1 = ll_null
il_level_id2 = ll_null
ll_complete = long(gnv_data.of_getitem('code_lookup','lookup_code',"lookup_name = 'Contract Action Status' and code = 'Complete'"))	
//Remove the filter of DataWindow
ls_filter_ori = This.Describe("DataWindow.Table.Filter")
IF Len(Trim(ls_filter_ori)) > 1 THEN
	This.SetRedraw(False)
	This.SetFilter('1=1')
	This.Filter()
	This.SetRedraw(True)	
END IF
ll_count = rowcount()
for ll_i = 1 to ll_count
//for ll_i = 1 to rowcount()
//-------------End Modified ---------------------------------------------
	if isnull(object.ctx_id[ll_i]) then
		object.ctx_id[ll_i] = inv_contract_details.of_get_ctx_id( )
	end if 	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 11.20.2006 By: Jervis
	//trigger work flow when action status has be changed
	If gb_workflow Then
		IF This.GetItemStatus( ll_i, 0, Primary! ) = DataModified! then
			//if this.GetItemNumber(ll_i,"action_status",primary!,true) <> this.GetItemNumber(ll_i,"action_status") Then
			ll_ori = this.GetItemNumber(ll_i,"action_status",primary!,true)
			ll_cur = this.GetItemNumber(ll_i,"action_status")
			if ((ll_ori <> ll_cur) or (isnull(ll_ori) and not isnull(ll_cur)) or (not isnull(ll_ori) and isnull(ll_cur))) Then
				
					istr_action[ll_seq].ctx_action_item_id = This.getItemnumber( ll_i, "ctx_action_item_id" )
					istr_action[ll_seq].ctx_id = This.getItemnumber( ll_i, "ctx_id" )
					istr_action[ll_seq].wf_id = this.GetItemNumber(ll_i,"wf_id")
					istr_action[ll_seq].wf_action_status_id = this.GetItemNumber(ll_i,"action_status")
					istr_action[ll_seq].wf_action_type_id = this.GetItemNumber(ll_i,"action_type")
					istr_action[ll_seq].status_changed_flag = false
					istr_action[ll_seq].module = "03"	//Contract Logix Tracking
					istr_action[ll_seq].trigger_by = "008"		//Trigger By Action Item Changed
					istr_action[ll_seq].screen_id = -10
				if istr_action[ll_seq].wf_id > 0 and this.GetItemString(ll_i,"wf_complete_flag") = "N" THEN
					istr_action[ll_seq].wf_step_id = this.GetItemNumber(ll_i,"wf_action_type_id")
					//BEGIN---Modify by Scofield on 2010-04-13
					ls_Notes = This.GetItemString(ll_i,"notes")
					if Not IsNull(ls_Notes) and ls_Notes <> "" then
						istr_action[ll_seq].notes = ls_Notes
					end if
					//END---Modify by Scofield on 2010-04-13
					istr_action[ll_seq].status_changed_flag = true
				end if
				ll_seq++
			//elseif this.GetItemNumber(ll_i,"action_type",primary!,true) <> this.GetItemNumber(ll_i,"action_type") Then
			else
				ll_ori = this.GetItemNumber(ll_i,"action_type",primary!,true)
				ll_cur = this.GetItemNumber(ll_i,"action_type")
				if ((ll_ori <> ll_cur) or (isnull(ll_ori) and not isnull(ll_cur)) or (not isnull(ll_ori) and isnull(ll_cur))) Then
					istr_action[ll_seq].ctx_action_item_id = This.getItemnumber( ll_i, "ctx_action_item_id" )
					istr_action[ll_seq].ctx_id = This.getItemnumber( ll_i, "ctx_id" )
					istr_action[ll_seq].wf_action_status_id = this.GetItemNumber(ll_i,"action_status")
					istr_action[ll_seq].wf_action_type_id = this.GetItemNumber(ll_i,"action_type")
					istr_action[ll_seq].status_changed_flag = false
					istr_action[ll_seq].module = "03"	//Contract Logix Tracking
					istr_action[ll_seq].trigger_by = "008"		//Trigger By Action Item Changed
					istr_action[ll_seq].screen_id = -10
					ll_seq++
				end if
			end if
		END IF
	End if	
	//-----------Begin Added by Alfee 07.26.2007--------------------------
	//Get the action items changed to completed status
	IF This.GetItemStatus( ll_i, 'action_status', Primary! ) = DataModified! or &
		This.GetItemStatus( ll_i, 'action_status', Primary! ) = NewModified! THEN
		ll_ori = this.GetItemNumber(ll_i,"action_status",primary!,true)
		ll_cur = this.GetItemNumber(ll_i,"action_status")
		IF ll_cur = ll_complete and ll_cur <> ll_ori  THEN
			ll_ctxid = This.getItemNumber( ll_i, "ctx_id" )
			ls_alm_table = This.getItemString( ll_i, "alm_table" )
			ls_alm_column = This.getItemString( ll_i, "alm_column" )
			ls_action_user = This.getItemString( ll_i, "action_user" )
			ll_docid = This.getItemNumber( ll_i, "doc_id" )
			ll_level_id1 = This.getItemNumber( ll_i, "level_id1" )
			ll_level_id2 = This.getItemNumber( ll_i, "level_id2" )
			IF Len(Trim(ls_alm_table)) > 0 AND Len(Trim(ls_alm_column)) > 0 THEN
				ls_criteria = "ctx_id = " + String(ll_ctxid) + " And alm_table = '" + ls_alm_table + "' "
				//add level id - jervis 06.30.2011
				ls_criteria +=" And alm_column = '" + ls_alm_column + "' And action_user <> '" + ls_action_user + "'" + &
									" and doc_id = " + string(ll_docid) + " and level_id1 = " + string(ll_level_id1) + " and level_id2 = " + string(ll_level_id2)
								 
				//Skip the duplicated action items
				ll_arrcnt = UpperBound(is_column)
				lb_duplicated = FALSE
				FOR ll_k = 1 to ll_arrcnt 
					IF il_ctxid[ll_k] = ll_ctxid and is_table[ll_k] = ls_alm_table and & 
						is_column[ll_k] = ls_alm_column THEN 
						lb_duplicated = TRUE
						EXIT												
					END IF
				NEXT
				IF lb_duplicated THEN Continue
				//Determine whether all the relatived action items completed
				ll_found = 1
				lb_completed = TRUE
				Do
					ll_found = This.Find(ls_criteria, ll_found, ll_count)
					IF ll_found > 0 THEN 
						lb_completed = (This.GetItemNumber(ll_found,"action_status") = ll_complete) 
						IF Not lb_completed THEN EXIT
						ll_found ++
					END IF
				Loop While (ll_found > 0 and ll_found <= ll_count)
				IF lb_completed THEN 
					il_ctxid[ll_j] = ll_ctxid
					is_table[ll_j] = ls_alm_table 
					is_column[ll_j] = ls_alm_column
					//add by jervis - 06.30.2011
					il_doc_id_arr[ll_j] = ll_docid
					il_level_id1[ll_j] = ll_level_id1
					il_level_id2[ll_j] = ll_level_id2
					ll_j ++
				END IF
			END IF
		END IF
	END IF
	//---------------End Added -------------------------------------------
	//---------------------------- APPEON END ----------------------------	
	
	//Begin - Added By Mark Lee 09/10/12
	if w_mdi.of_security_access(6982) = 0 then	//Modify Other Users AI
			ls_assigned_to = trim(this.GetItemString(ll_i,"action_user"))
			ls_assigned_by = trim(this.GetItemString(ll_i,"wf_assigned_by"))
			if isnull(ls_assigned_to) or ls_assigned_to = '' Then Continue //Added By Ken.Guo 04/30/2013
			if this.GetItemStatus(ll_i,"action_user",primary!) <> NotModified! Or this.GetItemStatus(ll_i,"wf_assigned_by",primary!) <> NotModified!  then
				if (ls_assigned_to <> gs_user_id or isnull(ls_assigned_to)) and (ls_assigned_by <> gs_user_id or isnull(ls_assigned_by)) then
					lb_flag = true
//					exit
					continue	//Added By Mark Lee 04/30/2013
				end if
			end if
	end if
	//End - Added By Mark Lee 09/10/12
next

//-------Begin Added by Alfee 07.30.2007---------------------------------
//Restore the filter of DataWindow
IF Len(Trim(ls_filter_ori)) > 1 THEN 
	This.SetRedraw(False)
	This.SetFilter(ls_filter_ori)
	This.Filter()
	This.SetRedraw(True)
END IF
//-------End Added ------------------------------------------------------

//Added By Mark Lee 09/10/12
if lb_flag then
	if MessageBox("Message","Once you save this Action Item you will not be able to modify it because you are not set as the Assigned To or Assigned By user.  Continue?",Question!,YesNo!,2) = 2 then
		return FAILURE
	end if
end if

return success
end event

event pfc_retrieve;call super::pfc_retrieve;



retrieve(inv_contract_details.of_get_ctx_id( ) )

return success
end event

event dropdown;/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: Override the ancestor script. PFC calaender does not work with datawindow with title bar
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 28 July 2005  ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


Long  ll_rtn 
Boolean lb_titlebar 


lb_titlebar = TitleBar 
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 03.16.2006 By: LeiWei
//$<reason> Fix a defect.
//If lb_titlebar Then TitleBar = FALSE 
//---------------------------- APPEON END ----------------------------
SetRedraw ( FALSE ) 
ll_rtn = Super::Event dropdown() 
If lb_titlebar Then TitleBar = TRUE 
SetRedraw ( TRUE ) 
Return ll_rtn
end event

event updateend;call super::updateend;//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 06.22.2007 By: Jack
//$<reason> 
/*
setredraw(false)
long ll_current_row

ll_current_row = getrow()
retrieve(inv_contract_details.of_get_ctx_id( ) )
setrow(ll_current_row)

setredraw(true)
*/
//---------------------------- APPEON END ----------------------------

end event

event itemchanged;call super::itemchanged;/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner 23 November 2005  ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

String 	ls_lookup_disp 
long		ll_Duration,ll_Dur_Type
Date		ld_StartDate,ld_EndDate
Time		lt_StartTime
DateTime	ldt_End

n_cst_datetime	lnv_datetime

str_action_item lstr_action
n_cst_workflow_triggers	lnv_workflow

datawindowchild dwchild

choose case dwo.name
	case 'action_type'
		//--------------------------- APPEON BEGIN ---------------------------
		//$<comment> 09.28.2006 By: LeiWei
		//$<reason> This to be changed so that it does not generate the letter
		//$<reason> until the [A] button is clicked.
		/*
		of_action_type(row,DATA)
		*/
		//---------------------------- APPEON END ----------------------------

		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 09.21.2006 By: LeiWei
		//$<reason> Implement new requirement for Contract Logix.
		
		DWItemStatus ldws_status
		String ls_due_days
		Date ld_due_date
		ldws_status = dw_1.GetItemStatus(row, 0, Primary!)
		IF ldws_status = NewModified! OR ldws_status = New! THEN
			ls_due_days = gnv_data.of_getitem( "code_lookup", "custom_2", "lookup_code = " + data)
			ld_due_date = RelativeDate(Today(), long(ls_due_days))
			This.SetItem( row, "due_date", ld_due_date )
		END IF
		
		//---------------------------- APPEON END ----------------------------
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 10.30.2006 By: Davis
		//$<reason> Fix a defect.
		This.Setitem( row, "action_type_code", Long(data))
		//---------------------------- APPEON END ----------------------------

	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 09.20.2006 By: LeiWei
	//$<reason> Set Action Date to Today's date when change the status to "Complete".
	
	case "action_status"
		//Pop-up prompt when action status change	- jervis 03.10.2009
		if gb_workflow then
			lstr_action.wf_id = this.GetItemNumber(row,"wf_id")
			lstr_action.wf_step_id = this.GetItemNumber(row,"wf_action_type_id")
			lstr_action.as_assigned_to = this.GetItemString( row, "action_user")		//jervis 11.17.2010
			if not isnull(lstr_action.wf_id) then
				lstr_action.wf_action_status_id =  long(data) //this.GetItemNumber(row,"action_status")
				lnv_workflow = create n_cst_workflow_triggers
				if lnv_workflow.of_popup_prompt( lstr_action) <> 1 then
					//---------Begin Added by (Appeon)Harry 02.11.2014 for Bug # 3885--------
					Long ll_old_status_id
					ll_old_status_id = this.getitemnumber(row, "action_status", Primary!, true)
					this.setitem( row, "action_status", ll_old_status_id)
					this.event ItemFocuschanged(row,dwo)
					//---------End Added ------------------------------------------------------
					destroy lnv_workflow
					return 2		//Reject the data value but allow the focus to change
				end if
				destroy lnv_workflow	
			end if
		end if
		
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 12.14.2006 By: Jervis
		//$<reason> The Action Date field should be change when a user selects a new Status
		/*
		Long ll_complete_action_status
		IF IsNull( This.GetItemDatetime( row, "action_date" ) ) THEN
			ll_complete_action_status = Long(gnv_data.of_getitem( 'code_lookup', 'lookup_code', "upper(lookup_name) = upper('Contract Action Status') and upper(code) = upper('Complete')"))
			IF ll_complete_action_status = Long(DATA) THEN
				This.SetItem( row, "action_date", Datetime(Today()) )
			END IF
		END IF
		*/
		This.SetItem( row, "action_date", Datetime(Today()) )
		//---------------------------- APPEON END ----------------------------
	//---------------------------- APPEON END ----------------------------
	
	//BEGIN---Modify by Scofield on 2009-12-09
	Case "start_date","start_time","duration","duration_type"
		This.AcceptText()
		
		ld_StartDate = Date(This.GetItemDateTime(Row,"start_date"))
		lt_StartTime = Time(This.GetItemDateTime(Row,"start_time"))
		
		ll_Duration = This.GetItemNumber(Row,"duration")
		ll_Dur_Type = This.GetItemNumber(Row,"duration_type")
		
		if Not IsNull(ld_StartDate) and Not IsNull(lt_StartTime) and Not IsNull(ll_Duration) and Not IsNull(ll_Dur_Type) then
			if ll_Dur_Type = 1 then
				ll_Duration = ll_Duration * 60
			elseif ll_Dur_Type = 2 then
				ll_Duration = ll_Duration * 60 * 60
			elseif ll_Dur_Type = 3 then
				ll_Duration = ll_Duration * 24 * 60 * 60
			end if
		
			ldt_End = lnv_datetime.of_RelativeDatetime(DateTime(ld_StartDate,lt_StartTime),ll_Duration)
				
			This.SetItem(Row,"end_date",ldt_End)
			This.SetItem(Row,"end_time",ldt_End)
		end if
	//END---Modify by Scofield on 2009-12-09
	case else 
end choose 

end event

event retrieveend;call super::retrieveend;long ll_i
setredraw(false)
for ll_i = 1 to rowcount
	setitem(ll_i,'selected',1)
	//<add> 06.12.2007 by Andy reason:fixed a bug
	setitemstatus(ll_i,0,primary!,NotModified!)
	//end of add
next

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 06.22.2007 By: Jack
//$<reason> Fix a defect.
long ll_find,ll_ctx_id
string ls_find

ll_ctx_id = inv_contract_details.of_get_ctx_id( )
if Not IsNull(ll_ctx_id) and Not IsNull(il_ctx_action_item_id) then				//Add by Scofield on 2007-07-23
	ls_find = "ctx_id = " + string(ll_ctx_id) + " and ctx_action_item_id = " + string(il_ctx_action_item_id)
	ll_find = this.find(ls_find,1,this.rowcount())
	If ll_find > 0 Then
		this.scrolltoRow(ll_find)
	End If
end if
SetNull(il_ctx_action_item_id)		//08.24.2007 By Jervis Reset
//---------------------------- APPEON END ----------------------------

/////////////////////////////////////
// needed because the drop down is not retieved
// only the number value will be displayed
///////////////////////////////////// 
if rowcount > 0 then 	
	setcolumn('notes')
	setfocus()
end if

//--------------------------- APPEON BEGIN ---------------------------
//Added By Mark Lee 09/10/12
if w_mdi.of_security_access(6982) = 0 then	//Modify Other Users AI
	string ls_assigned_to,ls_assigned_by
	
	for ll_i = 1 to RowCount
		ls_assigned_to = trim(this.GetItemString(ll_i,"action_user"))
		ls_assigned_by = trim(this.GetItemString(ll_i,"wf_assigned_by"))
		If isnull(ls_assigned_to) or ls_assigned_to = '' Then Continue //Added By Ken.Guo 04/30/2013
		if (ls_assigned_to <> gs_user_id or isnull(ls_assigned_to)) and (ls_assigned_by <> gs_user_id or isnull(ls_assigned_by)) then
			this.SetItem(ll_i,"readonly_flag",1)
		end if
	next
end if
//---------------------------- APPEON END ----------------------------

setredraw(true)
end event

event buttonclicked;call super::buttonclicked;/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner 29 November 2005  ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
str_pass lstr_pass_alm //02.26.2008
Str_ctx_info lstr_ctx

// mskinner 05 april 2006 -- begin
if of_check_read_only( ) then return
// mskinner 05 april 2006 -- end 

//Begin - Added By Mark Lee 04/30/2013
If row > 0 Then
	If this.GetItemNumber( row,"readonly_flag") = 1 Then
		Return 
	End IF
End If 
//End - Added By Mark Lee 04/30/2013


// need to do a set row - when clicking on a button for that row, the current row is not then clicked row for which the 
// is on
setrow(row)


choose case dwo.name
	case 'b_address'
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 01.22.2007 By: Jervis
		//$<reason> 
		/*
		ib_open_window = true
		of_action_type(row,STRING(this.getitemNumber(row,'action_type')))
		ib_open_window = false 
		*/
		of_print_letter(row,STRING(this.getitemNumber(row,'action_type')))
		//---------------------------- APPEON END ----------------------------
		//----Begin Added by Alfee 08.24.2007---------
		This.SetRedraw(False)
		This.ScrolltoRow(row)
		This.SetRedraw(True)		
		//----End Added ------------------------------	
		
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 09.28.2006 By: LeiWei
	//$<reason> To be manually force the system to generate an email.
	case 'b_email'
		of_action_email(row,this.getitemNumber(row,'ctx_id'))
	//---------------------------- APPEON END ----------------------------
	
	case 'b_notes'	
			
		
		//---------Begin Modified by (Appeon)Harry 06.07.2013 for V141 ISG-CLX--------
		//Start Code Change ----09.12.2012 #V12 maha - new exp. notes screen

		//---------Begin Modified by (Appeon)Harry 07.17.2014  for the Bug 4115
		//OpenWithParm( w_ai_notes_new, This.GetItemString( row, "notes" ))
		string ls_notes
		ls_notes =  This.GetItemString( row, "notes" )
		if isnull(ls_notes) then ls_notes = ""
		OpenWithParm( w_ai_notes_new, ls_notes)
		//---------End Modfiied ------------------------------------------------------
		
		//OpenWithParm( w_ai_notes, This.GetItemString( row, "notes" ))
		//---------End Modfiied ------------------------------------------------------
    	IF Message.StringParm = "Cancel" THEN
		  Return failure
	    ELSE
		  This.SetItem( row, "notes", Message.StringParm )
		  OF_ENABLE_SAVE( )
	   END IF	

	case 'b_due_date','b_due_date_g','b_due_date_r' //Alfee 02.26.2008
		IF This.GetItemStatus(row, 0, Primary!) = NewModified! OR  &
			This.GetItemStatus(row, 0, Primary!) = New! THEN
			MessageBox("Alarm Setting","The alarm cannot be set until the record is saved.")
			RETURN
		END IF		
		//IF of_show_missing_msg( 'due_date', this, 'datetime',1) = success THEN			
		IF of_show_missing_msg( 'due_date', this, 'datetime',row) = success THEN //03.13.2008
		   lstr_pass_alm.s_string_array[1] = String(inv_contract_details.of_get_ctx_id( ))
		   lstr_pass_alm.s_string_array[2] = 'ctx_action_item'
		   lstr_pass_alm.s_string_array[3] = 'due_date'
		   lstr_pass_alm.s_string_array[4] = This.object.due_date_t.text 
			lstr_pass_alm.s_string_array[5] = String(GetItemNumber(row, 'ctx_action_item_id'))
			lstr_pass_alm.s_string_array[6] = '0'
			lstr_pass_alm.s_string_array[7] = '0'
			lstr_pass_alm.s_datetime[1] = this.GetItemDatetime( row, 'due_date')  //jervis 07.05.2011
		   OpenwithParm(w_ctx_alarm, lstr_pass_alm)
			This.SetColumn('due_date')				
		END IF		
		//Set flag button
		of_set_flags( )	
	case 'b_action_status'		//Add Action Items Status Track - Jervis 11.05.2010
		lstr_ctx.al_ctx_id = inv_contract_details.of_get_ctx_id( )
		lstr_ctx.al_ai_id = GetItemNumber(row, 'ctx_action_item_id')
		lstr_ctx.as_type = 'ctx_ai'
		Openwithparm(w_actionitem_status_track,lstr_ctx)
end choose

end event

event pfc_deleterow;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 06.28.2006 By: Liang QingShi
//$<reason> 
Integer	li_Rtn
Long ll_wf_id
String 		ls_wf_complete_flag
if of_check_read_only() then return NO_ACTION //Added by Alfee 09.30.2007

if This.RowCount() <= 0 then return success


//Begin - Added By Mark Lee 09/11/12
if w_mdi.of_security_access(6982) = 0 then	//Modify Other Users AI
	If this.GetItemNumber(dw_1.getrow(),"readonly_flag") = 1 Then 
		Messagebox("Delete confirm", "Please make sure you have right to delete the record(s).")
		Return FAILURE	
	End If
End If
//End - Added By Mark Lee 09/11/12

//---------Begin Added by Alfee 02.26.2008--------------
Long ll_action_item_id, ll_ctx_id

//Begin - Added By Ken.Guo 10/10/2011.
Long ll_row
u_tab_action_items_det luo_tab_action_items_det
luo_tab_action_items_det = Parent.Getparent( )
IF Isvalid(luo_tab_action_items_det) THEN
	If luo_tab_action_items_det.selectedtab = 1 Then
		ll_row = luo_tab_action_items_det.tabpage_browse.dw_1.GetSelectedrow(0)
		If ll_row = 0 Then Return success
		li_Rtn = MessageBox('Delete confirm','Are you sure you want to delete the record(s)?',Question!,YesNo!,2)
		if li_Rtn <> 1 then return success
		gnv_appeondb.of_startqueue( )
		Do While ll_row > 0 
			ll_ctx_id =luo_tab_action_items_det.tabpage_browse.dw_1.GetItemNumber(ll_row, 'ctx_id')
			ll_action_item_id = luo_tab_action_items_det.tabpage_browse.dw_1.GetItemNumber(ll_row, 'ctx_action_item_id')
			DELETE FROM ctx_ai_notification_users WHERE ctx_id = :ll_ctx_id and ctx_action_item_id = :ll_action_item_id ;
			DELETE FROM ctx_ai_alarm_attachment WHERE ctx_id = :ll_ctx_id and item_id = :ll_action_item_id ;		
			DELETE FROM ctx_ai_notification WHERE ctx_id = :ll_ctx_id and ctx_action_item_id = :ll_action_item_id ; 	
			DELETE FROM ctx_action_items   WHERE ctx_id = :ll_ctx_id and ctx_action_item_id = :ll_action_item_id ;
			ll_row = luo_tab_action_items_det.tabpage_browse.dw_1.GetSelectedrow(ll_row)
		Loop
		gnv_appeondb.of_commitqueue( )
		This.of_retrieve()
		Return	0	
	End If
End If
//End - Added By Ken.Guo 10/10/2011.

li_Rtn = MessageBox('Delete confirm','Are you sure you want to delete the record?',Question!,YesNo!,2)
if li_Rtn <> 1 then return success

ll_ctx_id =dw_1.GetItemNumber(dw_1.getrow(), 'ctx_id')
ll_action_item_id = dw_1.GetItemNumber(dw_1.getrow(), 'ctx_action_item_id')
//Begin - Added By Mark Lee 05/30/2013
ll_wf_id = dw_1.GetItemNumber(dw_1.getrow(), 'wf_id') 
ls_wf_complete_flag = dw_1.GetItemString(dw_1.getrow(), 'wf_complete_flag') 
IF not isnull(ll_wf_id)  and ll_wf_id > 0  and ( ls_wf_complete_flag <> 'Y' Or isnull(ls_wf_complete_flag) ) Then 
	li_Rtn = MessageBox('Delete confirm','Deleting the current step will stop the current workflow. ~r~nDo you want to continue?',Question!,YesNo!,2)
	if li_Rtn <> 1 then return success
End If 
//End - Added By Mark Lee 05/30/2013
gnv_appeondb.of_startqueue( )
DELETE FROM ctx_ai_notification_users WHERE ctx_id = :ll_ctx_id and ctx_action_item_id = :ll_action_item_id ;
DELETE FROM ctx_ai_alarm_attachment WHERE ctx_id = :ll_ctx_id and item_id = :ll_action_item_id ;		//Added by Scofield on 2009-02-24
DELETE FROM ctx_ai_notification WHERE ctx_id = :ll_ctx_id and ctx_action_item_id = :ll_action_item_id ; 
DELETE FROM ctx_action_items   WHERE ctx_id = :ll_ctx_id and ctx_action_item_id = :ll_action_item_id ; //Added By Ken.Guo 10/10/2011. 
gnv_appeondb.of_commitqueue( )
//----------End Added ----------------------------------

//Super::Event pfc_deleteRow()
//m_pfe_cst_mdi_menu_contract.m_file.m_save.enabled = True

This.of_retrieve() //Modified By Ken.Guo 10/10/2011

return success
//---------------------------- APPEON END ----------------------------

end event

event pfc_filterdlg;call super::pfc_filterdlg;/*
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.22.2006 By: LeiWei
//$<reason> Implement new requirement for Contract Logix.

//OpenWithParm( w_contract_action_item_filter, This)
//Return 1

//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.30.2006 By: Jack 
//$<reason> Make the Action Items filters available at the top of the window instead of in a separate window.
if dw_filter.visible then	return 1

gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_view.m_filter,'Enabled', False)
dw_filter.visible = true
//dw_filter.setfocus()
dw_1.y = dw_filter.y + dw_filter.height + 10
dw_1.height = dw_1.height - dw_filter.y - dw_filter.height
Return 1
//---------------------------- APPEON END ----------------------------
*/

of_ShowHideSearch(Not dw_filter.visible)

Return 1

end event

event pfc_postinsertrow;call super::pfc_postinsertrow;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.12.2006 By: LeiWei
//$<reason> Fix a defect.

This.Setredraw( False)
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 06.08.2007 By: Jack
//$<reason> Fix a defect.
long ll_letter_from,ll_letter_to
ll_letter_from = f_get_contact_id(inv_contract_details.of_get_ctx_id( ),'I')
ll_letter_to = f_get_contact_id(inv_contract_details.of_get_ctx_id( ),'E')

This.SetItem( al_row, "letter_from", ll_letter_from)
This.SetItem( al_row, "letter_to", ll_letter_to)

//---------------------------- APPEON END ----------------------------

This.SetItem( al_row, "action_user", gs_user_id )
This.SetItem( al_row, "action_date", DateTime(Today()) )

//BEGIN---Modify by Scofield on 2010-03-03
This.SetItem(al_Row,"start_time",DateTime(1900-01-01,00:00:00))
This.SetItem(al_Row,"end_time",DateTime(1900-01-01,00:00:00))
//END---Modify by Scofield on 2010-03-03

Long ll_action_status
ll_action_status = Long(gnv_data.of_getitem( 'code_lookup', 'lookup_code', "upper(lookup_name) = upper('Contract Action Status') and upper(code) = upper('InComplete')"))
IF ll_action_status > 0 THEN dw_1.setitem(al_row, 'action_status', ll_action_status)

This.SetItemStatus(al_row, 0, Primary!, NotModified!)

This.scrolltorow( al_row )	
This.setfocus( )

This.Setredraw( True)
//---------------------------- APPEON END ----------------------------

end event

event rowfocuschanged;call super::rowfocuschanged;dwitemstatus ldis_status
string ls_assigned_to,ls_assigned_by

IF currentrow > 0 THEN
	u_tab_action_items_det luo_tab_action_items_det
	luo_tab_action_items_det = Parent.Getparent( )
	IF Isvalid(luo_tab_action_items_det) THEN
		IF luo_tab_action_items_det.tabpage_browse.dw_1.Rowcount( ) >= currentrow AND luo_tab_action_items_det.selectedtab = 2 THEN
			luo_tab_action_items_det.tabpage_browse.dw_1.Setrow( currentrow )
			luo_tab_action_items_det.tabpage_browse.dw_1.Scrolltorow( currentrow )
		END IF
	END IF
	//Begin - Added By Mark Lee 09/10/12
	if not isvalid(m_pfe_cst_mdi_menu_contract_am) then return 
	if w_mdi.of_security_access(6982) = 0   then
	
		ldis_status = this.GetItemStatus(currentrow,0,primary!)
		ls_assigned_to = trim(this.GetItemString(currentrow,"action_user"))
		ls_assigned_by = trim(this.GetItemString(currentrow,"wf_assigned_by"))
			
		if (ldis_status = NotModified! or ldis_status = DataModified!) and (ls_assigned_to <> gs_user_id or isnull(ls_assigned_to)) and (ls_assigned_by <> gs_user_id or isnull(ls_assigned_by)) then
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_deleteactioneitem,'enabled', False)
		else
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_deleteactioneitem,'enabled', True)
		end if
	else
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_deleteactioneitem,'enabled', True)
	end if
	//End - Added By Mark Lee 09/10/12

END IF
end event

event pfc_postupdate;call super::pfc_postupdate;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.17.2006 By: Jervis
//$<reason> modify work flow
Long ll_i,ll_count
n_cst_workflow_triggers    lnv_trigger

//Set contract notification parameters -- Added by Alfee 07.27.2007
IF UpperBound(is_column) > 0 THEN of_update_ctx_notification(il_ctxid, is_table, is_column,il_doc_id_arr,il_level_id1,il_level_id2) 

//If not gb_workflow Then return 1
IF gb_workflow THEN //Alfee 03.11.2008
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
END IF //03.11.2008

//------Begin Modified by Alfee on 03.11.2008 ----------
//Refresh cache, for date alarm enhancement
gnv_data.of_retrieve( "ctx_ai_notification")
//refresh data
Parent.of_retrieve( )
//of_retrieve() 
//------End Modified -----------------------------------

return 1
//---------------------------- APPEON END ----------------------------



end event

event itemfocuschanged;call super::itemfocuschanged;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 12.04.2006 By: Jervis
//$<reason> Filter Status
datawindowchild ldwc
long ll_wf_id,ll_wf_step_id
string ls_filter

ll_wf_id = this.GetItemNumber(row,"wf_id")
ll_wf_step_id = this.GetItemNumber(row,"wf_action_type_id")
	
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

event retrievestart;call super::retrievestart;//08.24.2007 By Jervis
SetRedraw(false)
if isnull(il_ctx_action_item_id) or  il_ctx_action_item_id < 1 then
	If this.getrow() > 0 Then 	il_ctx_action_item_id = this.getitemnumber(this.getrow(),'ctx_action_item_id')
end if

end event

event ue_populatedddws;call super::ue_populatedddws;DataWindowChild	ldwc_Child

Integer	li_Rtn,li_LookCode
long		ll_Count

li_Rtn = This.Getchild('action_type',ldwc_Child)

if li_Rtn = 1 then
	ll_Count = ldwc_Child.RowCount()
	if ll_Count > 0 then
		li_LookCode = ldwc_Child.GetItemNumber(1,'lookup_code')
		if li_LookCode = -999 then
			ldwc_Child.DeleteRow(1)
		end if
	end if
end if

end event

event rbuttonup;long	ll_Right

ll_Right = w_mdi.of_security_access(2160)				//Access Rights
if ll_Right = 0 or ll_Right = 1 then Return 1

Return Super::Event RButtonUp(XPos,YPos,Row,Dwo)

end event

event clicked;//////////////////////////////////////////////////////////////////////////////
//	Event:			clicked
//	Description:		DataWindow clicked
//////////////////////////////////////////////////////////////////////////////
//	Rev. History		Version
//						5.0		Initial version
// 						6.0 	Added Linkage service notification
// 						6.0 	Introduced non zero return value
// 						7.0		Do not bypass processing on linkage failure.  
// 						7.0		Linkage service should not fire events when querymode is enabled
//////////////////////////////////////////////////////////////////////////////
//	Copyright ? 1996-2000 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
integer li_rc
boolean lb_disablelinkage

// Check arguments
if IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) then return

super::of_ClickLink( dwo, row )//added by gavins 20120612

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 02.22.2006 By: Cao YongWang
//$<reason> Performance tuning
string ls_coltype
If isvalid(iuo_Calendar) Then
	ls_coltype = this.Describe(dwo.name+".ColType")	
	If (ls_coltype = 'date' or ls_coltype = 'datetime') and (dwo.name = "action_date" or dwo.name = "start_date" or dwo.name = "due_date" or dwo.name = "end_date") Then
		iuo_Calendar.of_Register(dwo.name, iuo_Calendar.DDLB_WITHARROW)
	End If
End If
//---------------------------- APPEON END ----------------------------

// Is Querymode enabled?
if IsValid(inv_QueryMode) then lb_disablelinkage = inv_QueryMode.of_GetEnabled()

if not lb_disablelinkage then
	if IsValid (inv_Linkage) then
		if inv_Linkage.Event pfc_clicked ( xpos, ypos, row, dwo ) = &
			inv_Linkage.PREVENT_ACTION then
			// The user or a service action prevents from going to the clicked row.
			return 1
		end if
	end if
end if

	
if IsValid (inv_RowSelect) then inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )

if IsValid (inv_Sort) then inv_Sort.Event pfc_clicked ( xpos, ypos, row, dwo )

end event

event rbuttondown;call super::rbuttondown;//inv_contract_details.of_reset_alarm( this,'ctx_action_item',dwo) //jervis 07.04.2011
end event

event ue_post_itemchanged;call super::ue_post_itemchanged;//Added By Ken.Guo 05/08/2012. Check & Reset Date Alarm Status.
Long ll_ctx_id, ll_action_item_id
n_cst_date_alarm lnv_date_alarm
If row <= 0 Then Return 
If dwoname = '' Then Return
ll_ctx_id = inv_contract_details.of_get_ctx_id()
ll_action_item_id = This.GetItemNumber(row,'ctx_action_item_id')
If Describe(dwoname + '.ColType') = 'datetime' Then
	If This.GetItemDateTime(row, dwoname, Primary!, True) = This.GetItemDateTime(row, dwoname, Primary!, False)  Then
		//Do nothing
	Else
		lnv_date_alarm.of_reset_alart_status( 'ctx_action_item', dwoname,ll_ctx_id, 0,ll_action_item_id,0)
	End If
End If

end event

event getfocus;call super::getfocus;this.title = gs_left_title_sign + this.Tag + gs_right_title_sign				//Added By Mark Lee 03/22/2013

end event

type dw_filter from u_dw_contract within u_tabpg_contract_action_items_det_detail
string tag = "Filter Criteria"
integer y = 4
integer width = 3840
integer height = 396
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Filter Criteria"
string dataobject = "d_contract_action_items_filter"
boolean vscrollbar = false
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;//Disable ib_rmbmenu by Alfee 09.30.2007

ib_allow_save = FALSE //for of_enable_save(), added by Alfee 09.30.2007

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.30.2006 By: Jack
//$<reason> Make the Action Items filters available at the top of the window instead of in a separate window.
This.InsertRow( 0 )

dw_filter.of_SetUpdateAble( False )
dw_filter.of_SetDropDownCalendar(TRUE)

dw_filter.of_SetTransObject(SQLCA)

This.event ue_populatedddws( )
//If isvalid(m_pfe_cst_mdi_menu_contract) Then
//	m_pfe_cst_mdi_menu_contract.m_view.m_filter. = False
//End If
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-08-21 By: Scofield
//$<Reason> If there is no black row,then insert a black row

String	ls_UserId

DataWindowChild	ldw_Child

This.GetChild('action_user',ldw_Child)
if ldw_Child.RowCount() > 0 then
	ls_UserId = ldw_Child.GetItemString(1,'user_id')
end if

//---------Begin Modified by (Appeon)Harry 03.10.2014 for V142 ISG-CLX--------
//if Not IsNull(ls_UserId) then
if Not IsNull(ls_UserId) AND LenA(ls_UserID) <> 0 then//(Appeon)Toney 11.29.2013 - V141 ISG-CLX,Fix history BugT082101 Append LenA(ls_UserID) <> 0
//---------End Modfiied ------------------------------------------------------
	ldw_Child.InsertRow(1)
end if

//---------------------------- APPEON END ----------------------------

end event

event buttonclicked;call super::buttonclicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.30.2006 By: Jack 
//$<reason>	Make the Action Items filters available at the top of the window instead of in a separate window.
//---------Begin commented by Alfee 09.30.2007---------------------
//if of_check_read_only( ) then return   //Add by Jack 08.30.2007
//---------End Commented ------------------------------------------
choose case dwo.name
	case 'b_1'
		dw_filter.Reset()
		dw_filter.InsertRow( 0 )
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 12.12.2006 By: Jervis
		//$<reason> 
		dw_1.SetFilter("")
		//dw_1.SetFilter("active_status >= 0 or isnull(active_status)")
		//---------------------------- APPEON END ----------------------------

		
		dw_1.Filter()
	case 'b_2'
		Long ll_act_type 
		Long ll_act_status 
		String ls_act_user
		String ls_new_sql
		Datetime ldt_act_date,ldt_act_date1
		Datetime ldt_due_date,ldt_due_date1
		long ll_rec_status
		
		//Parent.of_retrieve() //Added by Ken.Guo on 2009-01-05.Refresh data.
		
		// Initial
		dw_filter.AcceptText()
		dw_filter.SetColumn( "action_type" )
		ls_new_sql = "1=1"
		
		// Get Filter condition
		ll_act_type = dw_filter.GetitemNumber(1, "action_type")
		ls_act_user = dw_filter.GetitemString(1, "action_user")
		ll_act_status = dw_filter.GetitemNumber(1, "action_status")
		ldt_act_date = dw_filter.GetitemDatetime(1, "action_date")
		ldt_act_date1 = dw_filter.GetitemDatetime(1, "action_date_1")
		ldt_due_date = dw_filter.GetitemDatetime(1, "due_date")
		ldt_due_date1 = dw_filter.GetitemDatetime(1, "due_date_1")
		ll_rec_status = dw_filter.GetItemNumber(1,"active_status")
		
		// Set Filter condition
		IF Not IsNull( ll_act_type ) AND ll_act_type > 0 THEN
			ls_new_sql = ls_new_sql + " AND action_type = " + String( ll_act_type )
		END IF
		
		IF Not IsNull( ls_act_user ) AND LEN(ls_act_user) > 0 THEN
			ls_new_sql = ls_new_sql + " AND action_user = '" + ls_act_user + "'"
		END IF
		
		IF Not IsNull( ll_act_status ) THEN
			ls_new_sql = ls_new_sql + " AND action_status = " + String( ll_act_status )
		END IF
		
		IF Not IsNull( ldt_act_date ) THEN
			ls_new_sql = ls_new_sql + " AND action_date >= Date('" + String( Date( ldt_act_date ), "yyyy-mm-dd" ) + "')"
		END IF
		
		IF Not IsNull( ldt_act_date1 ) THEN
			ls_new_sql = ls_new_sql + " AND action_date <= Date('" + String( Date( ldt_act_date1 ), "yyyy-mm-dd" ) + "')"
		END IF
		
		IF Not IsNull( ldt_due_date ) THEN
			ls_new_sql = ls_new_sql + " AND due_date >= Date('" + String( Date( ldt_due_date ), "yyyy-mm-dd" ) + "')"
		END IF
		
		IF Not IsNull( ldt_due_date1 ) THEN
			ls_new_sql = ls_new_sql + " AND due_date <= Date('" + String( Date( ldt_due_date1 ), "yyyy-mm-dd" ) + "')"
		END IF
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 12.12.2006 By: Jervis
		//$<reason> 
		//ls_new_sql = ls_new_sql + " and (active_status >= 0 or isnull(active_status))"
		if Not IsNull(ll_rec_status) then
			if ll_rec_status = -1 then
				ls_new_sql = ls_new_sql + " and (active_status < 0)"
			elseif ll_rec_status = 1 then
				ls_new_sql = ls_new_sql + " and (active_status >= 0 or isnull(active_status))"
			end if
		end if
		//---------------------------- APPEON END ----------------------------

		// Filter Action item
		dw_1.SetFilter(ls_new_sql)
		dw_1.Filter()		
	case 'b_3'
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 12.12.2006 By: Jervis
		//$<reason> 
		dw_1.SetFilter("")
		//dw_1.SetFilter("active_status >= 0 or isnull(active_status)")
		//---------------------------- APPEON END ----------------------------
		
		dw_1.Filter()
		
		/*
		dw_filter.visible = false
		dw_1.y = 48
		dw_1.height +=dw_filter.height
		dw_1.setfocus()
		*/
		
		of_ShowHideSearch(false)
		
	//BEGIN---Modify by Scofield on 2010-03-30
	case 'b_me'
		This.SetItem(Row,"Action_User",gs_user_id)
		This.SetColumn("Action_User")
	//END---Modify by Scofield on 2010-03-30
	case else
end choose
//---------------------------- APPEON END ----------------------------

end event

event pfc_addrow;//BEGIN---Modify by Scofield on 2010-03-22
dw_1.Event pfc_AddRow()

Return SUCCESS
//END---Modify by Scofield on 2010-03-22

end event

event pfc_filterdlg;call super::pfc_filterdlg;Return dw_1.event pfc_filterdlg( ) //Added By Ken.Guo 2010-07-26.
end event

