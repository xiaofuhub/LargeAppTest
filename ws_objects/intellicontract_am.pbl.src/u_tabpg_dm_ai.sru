$PBExportHeader$u_tabpg_dm_ai.sru
$PBExportComments$[intellicontract_tab]
forward
global type u_tabpg_dm_ai from u_tabpg_contract_master
end type
type tab_1 from tab within u_tabpg_dm_ai
end type
type tabpage_browse from userobject within tab_1
end type
type dw_browse from u_dw_contract within tabpage_browse
end type
type tabpage_browse from userobject within tab_1
dw_browse dw_browse
end type
type tabpage_detail from userobject within tab_1
end type
type dw_detail from u_dw_contract within tabpage_detail
end type
type tabpage_detail from userobject within tab_1
dw_detail dw_detail
end type
type tab_1 from tab within u_tabpg_dm_ai
tabpage_browse tabpage_browse
tabpage_detail tabpage_detail
end type
type dw_filter from u_dw_contract within u_tabpg_dm_ai
end type
end forward

global type u_tabpg_dm_ai from u_tabpg_contract_master
integer width = 3845
integer height = 1892
event ue_do ( string as_action )
event ue_workflow_manual ( )
event ue_set_screen_properties ( )
event ue_show_sertifi_status ( )
event ue_show_approve_status ( )
tab_1 tab_1
dw_filter dw_filter
end type
global u_tabpg_dm_ai u_tabpg_dm_ai

type variables
string is_prior
string is_filter
str_action_item istr_action[]
boolean ib_browse

//02.05.2007 By Jervis
boolean ib_update_header_status

long	il_TabBottomSpace

end variables

forward prototypes
public function string of_generate_filter ()
public function integer of_retrieve ()
public function integer of_print_letter (long row, string data)
public function integer of_print_letter ()
public subroutine of_set_update_status_flag (boolean ab_flag)
public function boolean of_get_update_status_flag ()
public subroutine of_set_flags ()
public function long of_getheight ()
public subroutine of_hidesearch ()
public subroutine of_setfocus ()
public subroutine of_goto_row (long al_doc_id, long al_seq_no, string as_column)
public subroutine of_post_goto_row (long al_doc_id, long al_seq_no, string as_column)
end prototypes

event ue_do(string as_action);//////////////////////////////////////////////////////////////////////
// $<event>ue_do()
// $<arguments>
//		value	string	as_action		
// $<returns> 
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2007-01-15 by Jervis
//////////////////////////////////////////////////////////////////////

str_add_doc lstr_add_doc
String  ls_DocType
long  ll_row 
//--------Begin Modified by Alfee 09.30.2007-----------------------
//if of_check_read_only( ) then return   //Add by Jack 08.30.2007
IF of_check_read_only( ) THEN
	IF as_action<>'select' and as_action<>'report' THEN RETURN
END IF
//--------End Modified ---------------------------------------------

gnv_app.of_set_ezmenu_refresh_state( TRUE )//added by gavins 20130325
gnv_app.post of_Refresh_EZMenu( )//added by gavins 20130325

CHOOSE CASE as_action
	CASE 'add_action_item'
		ll_row = tab_1.tabpage_detail.dw_detail.event pfc_addrow()
		//tab_1.tabpage_detail.dw_detail.scrolltorow( ll_Row)
		tab_1.tabpage_detail.dw_detail.setcolumn("action_type")
	CASE 'delete_action_item'
		tab_1.tabpage_detail.dw_detail.event pfc_deleterow()
	CASE 'workflow'
		event ue_workflow_manual()
	case 'save'
		//01.30.2007 by Jervis: Call of_validation
		if tab_1.tabpage_detail.dw_detail.of_accepttext( true) < 0 then return
		if tab_1.tabpage_detail.dw_detail.of_validation( ) < 0 then return
		if tab_1.tabpage_detail.dw_detail.of_update(true,false) = 1 then
			tab_1.tabpage_detail.dw_detail.of_postupdate()
		end if
	case 'select'
		ll_row = tab_1.tabpage_browse.dw_browse.getrow()
		if ll_row > 0 then
			tab_1.selecttab(2)
		end if
	case 'report'
		str_open_report lstr_pass
		
		lstr_pass.s_style = 'action_item'
		lstr_pass.l_ctx_id = inv_contract_details.of_get_ctx_id( )
		lstr_pass.l_doc_id = il_doc_id
		lstr_pass.s_dataobject = "d_dm_ai_report"
		openwithparm(w_dm_document_report,lstr_pass )
	case "print_letter"
		of_print_letter()
	case "ue_show_sertifi_status"
		This.Event ue_show_sertifi_status()
END CHOOSE




end event

event ue_workflow_manual();//Added for work flow trigger. 15/01/2007 Jervis
string	ls_rtn

str_manual_wf lstr_workflow
lstr_workflow.is_module = '04'
lstr_workflow.doc_id  = of_get_doc_id( )
lstr_workflow.ctx_id = inv_contract_details.of_get_ctx_id( )	//17.01.2007 By Jervis
OpenWithParm(w_manual_workflow_list , lstr_workflow)

ls_rtn = Message.stringparm

If ls_rtn = 'OK' Then of_retrieve()

end event

event ue_set_screen_properties();u_dw_contract ldw_screen

// Set screen properties
dw_filter.of_set_properties(dw_filter.il_ViewID, dw_filter.il_ScreenID, "Y")
ldw_screen = tab_1.tabpage_browse.dw_browse
ldw_screen.of_set_properties(ldw_screen.il_ViewID, ldw_screen.il_ScreenID, "Y")
ldw_screen = tab_1.tabpage_detail.dw_detail
ldw_screen.of_set_properties(ldw_screen.il_ViewID, ldw_screen.il_ScreenID, "Y")
end event

event ue_show_sertifi_status();String ls_es_docid
Long ll_row,ll_esign_type
Datawindow ldw_current
String ls_esign_type
String ls_es_fileid

Choose Case Tab_1.selectedtab
	Case 1
		ldw_current = Tab_1.tabpage_browse.dw_browse
	Case 2
		ldw_current =  Tab_1.tabpage_detail.dw_detail
End Choose

ll_row = ldw_current.GetRow()
ls_es_docid = ldw_current.GetItemString(ll_row,'es_docid')		
ll_esign_type = ldw_current.GetItemNumber(ll_row,'action_type')		
ls_es_fileid = ldw_current.GetItemString(ll_row,'es_fileid') // (Appeon)Harry 07.08.2016 - for docusign

 //Added By Jay Chen 10-21-2013
If (isnull(ls_es_docid) or ls_es_docid = '') and (ll_esign_type = gnv_sertifi.il_esign or  ll_esign_type = gnv_echosign.il_esign or ll_esign_type = gnv_docusign.il_esign ) Then
	Select es_docid Into :ls_es_docid From ctx_am_document where doc_id = :il_doc_id;
End If
Select esign_type into :ls_esign_type From ctx_am_document where es_docid = :ls_es_docid; 

choose case ls_esign_type  //Added By Jay Chen 10-21-2013
	case  'sertifi'  
		If gnv_sertifi.of_show_sertifi_status(il_doc_id,ls_es_docid,'dm',true) = 1  Then  
			ll_row = ldw_current.find('es_docid = "' + ls_es_docid + '"',1,ldw_current.rowcount())
			If ll_Row > 0 Then
				ldw_current.SetRow(ll_row)
				ldw_current.ScrolltoRow(ll_row)
				ldw_current.selectrow( 0, False)
				ldw_current.selectrow( ll_row, True)
			End If
		End If
	case 'echosign'
		If gnv_echosign.of_show_sertifi_status(il_doc_id,ls_es_docid,'dm',true) = 1 Then  
			ll_row = ldw_current.find('es_docid = "' + ls_es_docid + '"',1,ldw_current.rowcount())
			If ll_Row > 0 Then
				ldw_current.SetRow(ll_row)
				ldw_current.ScrolltoRow(ll_row)
				ldw_current.selectrow( 0, False)
				ldw_current.selectrow( ll_row, True)
			End If
		End If
	case 'docusign'  // (Appeon)Harry 07.08.2016 - for docusign
//		If gnv_docusign.of_show_sertifi_status(il_doc_id,ls_es_docid,'dm',true) = 1 Then  
		If gnv_docusign.of_show_sertifi_status(il_doc_id,ls_es_docid,'dm',true,ls_es_fileid) = 1 Then  //Modified By Jay Chen 04-30-2014
			ll_row = ldw_current.find('es_docid = "' + ls_es_docid + '"',1,ldw_current.rowcount())
			If ll_Row > 0 Then
				ldw_current.SetRow(ll_row)
				ldw_current.ScrolltoRow(ll_row)
				ldw_current.selectrow( 0, False)
				ldw_current.selectrow( ll_row, True)
			End If
		End If
end choose

Return 


end event

event ue_show_approve_status();str_ctx_email lstr_ctx_email
u_tabpg_dm_data luo_tabpg_dm_data
String ls_es_docid
Long ll_row,ll_esign_type
Datawindow ldw_current

If iw_parent.classname() = 'w_contract' Then
	lstr_ctx_email.ctx_id = inv_contract_details.of_get_ctx_id()
Else
	lstr_ctx_email.ctx_id = tab_1.tabpage_browse.dw_browse.getitemnumber(tab_1.tabpage_browse.dw_browse.getrow(),'ctx_id')
End If
lstr_ctx_email.doc_id = This.tab_1.tabpage_browse.dw_browse.GetItemNumber(ll_row, 'doc_id')
lstr_ctx_email.revision = This.tab_1.tabpage_browse.dw_browse.GetItemDecimal(ll_row, 'revision')
lstr_ctx_email.ab_checkinright = False

Choose Case Tab_1.selectedtab
	Case 1
		ldw_current = Tab_1.tabpage_browse.dw_browse
	Case 2
		ldw_current =  Tab_1.tabpage_detail.dw_detail
End Choose

ll_row = ldw_current.GetRow()
lstr_ctx_email.doc_id = ldw_current.GetItemNumber(ll_row, 'doc_id')
lstr_ctx_email.al_approve_id = ldw_current.GetItemNumber(ll_row, 'approve_id')

If isvalid(gw_contract) Then
	If gw_contract.tab_contract_details.ib_select9 Then
		luo_tabpg_dm_data = gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data
	End If
End If

If lstr_ctx_email.al_approve_id  > 0 Then
	gnv_webapprove.of_show_approve_status( lstr_ctx_email, luo_tabpg_dm_data)
End If

Return 
end event

public function string of_generate_filter ();//////////////////////////////////////////////////////////////////////
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

dw_filter.accepttext()

ll_type = dw_filter.getitemNumber(1,"action_type")
ll_status = dw_filter.getitemNumber(1,"action_status")

ls_user = dw_filter.getitemstring(1,'action_for')

ldt_due_from = dw_filter.getitemdatetime(1,"due_from")
ldt_due_to = dw_filter.getitemdatetime(1,"due_to")
ll_step = dw_Filter.GetItemNumber(1,"step_id")
ls_over_flag = dw_filter.GetItemString(1,"over_flag")
ll_rec_status = dw_filter.GetItemNumber(1,"active_status")


if (not isnull(ll_type)) and ll_type <> -999 then 
	ls_filter += "and action_type = " + string(ll_type) +  " "
end if
//if (not isnull(ll_status))  and ll_type <> -999 then 
if (not isnull(ll_status)) then 	//Alfee 04.30.2008
	ls_filter += "and action_status = " + string(ll_status) + " "
end if
if len(trim(ls_user)) > 0 then 
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 03.30.2007 By: Machongmin
	//$<reason> Fix a defect.	
	/*
	ls_filter += "and action_user ='" + ls_user + "' " 
	*/
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
		
if Not IsNull(ll_rec_status) then
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

is_filter = ls_filter //

return ls_filter


end function

public function integer of_retrieve ();//-------Begin Modified by Alfee 02.26.2008-------------
//<$Reason> to reset flag button
//return tab_1.tabpage_detail.dw_detail.event pfc_retrieve()
integer li_rtn

li_rtn = tab_1.tabpage_detail.dw_detail.event pfc_retrieve()

of_set_flags() 

return li_rtn
//-------End Modified ------------------------------
end function

public function integer of_print_letter (long row, string data);Long 			ll_wf_id,ll_step_id,ll_action_status,ll_print_flag
string 		ls_doc,ls_action_desc,ls_WorkFlow
long 			ll_use_export,ll_export_id,ll_ret,ll_count
datetime 	ldt_today

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.27.2007 By: Frank.Gui
//$<reason> 
IF tab_1.tabpage_detail.dw_detail.accepttext( )< 1 THEN return -1
IF tab_1.tabpage_detail.dw_detail.deletedcount( )+tab_1.tabpage_detail.dw_detail.modifiedcount( ) > 0 THEN
	messagebox("Print Letter","Data has been changed. Please save your modifications before printing letter(s).",exclamation!)
	return -1
END IF
//---------------------------- APPEON END ----------------------------

ll_wf_id = tab_1.tabpage_detail.dw_detail.GetItemNumber(row,"wf_id")

//Get the name of document 
If ll_wf_id  > 0 and gb_workflow Then
	ll_print_flag = tab_1.tabpage_detail.dw_detail.GetItemNumber(row,"print_flag")
	If ll_print_flag < 1 Then
		MessageBox("Print Letter","In accordance with the work flow step, the maximum amount of times to send this letter has been reached.")
		Return 1
	End If
	ll_step_id = tab_1.tabpage_detail.dw_detail.GetItemNumber(row,"wf_action_type_id")
	ll_action_status = tab_1.tabpage_detail.dw_detail.GetItemNumber(row,"action_status")
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
n_cst_ctx_letter  lnv_ctx_letter

lnv_ctx_letter = create n_cst_ctx_letter

if ll_use_export = 1 then	//From Export Painter Data
	ll_ret = lnv_ctx_letter.of_export_letter(ls_doc,0,inv_contract_details.of_get_ctx_id(),of_get_doc_id(),ll_export_id)
else								//From Document Data
	ll_ret = lnv_ctx_letter.of_export_letter(ls_doc,2,inv_contract_details.of_get_ctx_id(),of_get_doc_id(),tab_1.tabpage_detail.dw_detail.GetItemNumber(row,'seq_id'))
end if
destroy lnv_ctx_letter

//Update number of print
if ll_ret = 1 then
	tab_1.tabpage_detail.dw_detail.SetItem(row,"print_flag",-1)
	ldt_today = f_get_server_dtm()
	if not f_validstr(string(tab_1.tabpage_detail.dw_detail.GetItemDatetime(row,"first_attempt"))) then
			tab_1.tabpage_detail.dw_detail.SetItem(row,"first_attempt",ldt_today)
	end if 		
	tab_1.tabpage_detail.dw_detail.SetItem(row,"last_attempt",ldt_today)
	ll_count = tab_1.tabpage_detail.dw_detail.GetItemNumber(row,"attempt_times")
	if isnull(ll_count) or ll_count < 1 then
		tab_1.tabpage_detail.dw_detail.SetItem(row,"attempt_times",1)
	else
		tab_1.tabpage_detail.dw_detail.SetItem(row,"attempt_times",ll_count + 1)
	end if

	tab_1.tabpage_detail.dw_detail.accepttext( )
	gnv_appeondb.of_autocommit( )
	tab_1.tabpage_detail.dw_detail.UPDATE()
	commit;
else
	MessageBox("Letter error","Failed to print letter.")
end if

return ll_ret



end function

public function integer of_print_letter ();long ll_item_id[]
long ll_i,ll_count,ll_k
long ll_wf_id
str_pass lstr_pass

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.27.2007 By: Frank.Gui
//$<reason> 
IF tab_1.tabpage_detail.dw_detail.accepttext( )< 1 THEN return -1
IF tab_1.tabpage_detail.dw_detail.deletedcount( )+tab_1.tabpage_detail.dw_detail.modifiedcount( ) > 0 THEN
	messagebox("Print Letter","Data has been changed. Please save your modifications before printing letter(s).",exclamation!)
	return -1
END IF
//---------------------------- APPEON END ----------------------------


ll_count = tab_1.tabpage_detail.dw_detail.RowCount()
for ll_i = 1 to ll_count
	ll_wf_id = tab_1.tabpage_detail.dw_detail.GetItemNumber(ll_i,"wf_id")
	if ll_wf_id > 0 and  tab_1.tabpage_detail.dw_detail.GetItemNumber(ll_i,"print_flag") >0 then
		ll_k++		
		ll_item_id[ll_k] = tab_1.tabpage_detail.dw_detail.GetItemNumber(ll_i,"seq_id")
	elseif isnull(ll_wf_id) then
		ll_k++
		ll_item_id[ll_k] = tab_1.tabpage_detail.dw_detail.GetItemNumber(ll_i,"seq_id")
	end if
next

if ll_k > 0 then
	lstr_pass.s_string = "d_doc_letter"
	lstr_pass.action_items = ll_item_id
	openwithparm(w_ctx_print_letter,lstr_pass)
	of_retrieve()
else	//06/11/2007 By Jervis Fixed Issues1 in intellicontrct_issues_06_04_2007.doc
	MessageBox("Print Letter","No letters to print.")
end if

return 1

end function

public subroutine of_set_update_status_flag (boolean ab_flag);ib_update_header_status = ab_flag
end subroutine

public function boolean of_get_update_status_flag ();return ib_update_header_status
end function

public subroutine of_set_flags ();//Set flag button - Added by Alfee 02.26.2008

Long ll_cnt, i, ll_seq_id

ll_cnt = tab_1.tabpage_detail.dw_detail.RowCount()
FOR i = 1 to ll_cnt
	ll_seq_id = tab_1.tabpage_detail.dw_detail.object.seq_id[i]
	//add custom multi process - jervis 07.07.2011
	//tab_1.tabpage_detail.dw_detail.object.due_date_flag[i] = f_set_ai_flag('ctx_am_action_item', 'due_date', il_doc_id, ll_seq_id )
	tab_1.tabpage_detail.dw_detail.object.due_date_flag[i] = f_set_ai_flag('ctx_am_action_item', 'due_date',inv_contract_details.of_get_ctx_id( ) , il_doc_id, ll_seq_id ,0)
	tab_1.tabpage_detail.dw_detail.SetItemStatus(i, 'due_date_flag', Primary!, NotModified!)	
NEXT

tab_1.tabpage_detail.dw_detail.Post setredraw(true) //for PB refresh bug - 03.11.2008 
end subroutine

public function long of_getheight ();Return This.Height

end function

public subroutine of_hidesearch ();//====================================================================
// Function: of_HideSearch()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2010-04-28
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long	ll_TabBottomSpace,ll_dwBottomSpace,ll_Right
	
ll_TabBottomSpace = This.Height - Tab_1.Y - Tab_1.Height
ll_dwBottomSpace  = Tab_1.Tabpage_Detail.Height - Tab_1.Tabpage_Detail.dw_Detail.Y - Tab_1.Tabpage_Detail.dw_Detail.Height

dw_filter.Visible = false

Tab_1.Y = dw_filter.Y
Tab_1.Height = This.Height - ll_TabBottomSpace - Tab_1.Y

Tab_1.Tabpage_Detail.dw_Detail.Height = Tab_1.Tabpage_Detail.Height - Tab_1.Tabpage_Detail.dw_Detail.Y - ll_dwBottomSpace
Tab_1.Tabpage_Browse.dw_Browse.Height = Tab_1.Tabpage_Detail.dw_Detail.Height

if Tab_1.SelectedTab = 1 then
	Tab_1.Tabpage_Browse.dw_Browse.SetFocus()
else
	Tab_1.Tabpage_Detail.dw_Detail.SetFocus()
end if

if IsValid(m_pfe_cst_mdi_menu_contract_am) then
	ll_Right = w_mdi.of_security_access(6924)
	if ll_Right <> 0 then
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_view.m_filter,'ToolbarItemVisible', true)
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_view.m_filter,'ToolbarItemDown', False)
	else
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_view.m_filter,'ToolbarItemVisible', false)
	end if
end if

end subroutine

public subroutine of_setfocus ();
//
if Tab_1.SelectedTab = 1 then
	Tab_1.Tabpage_Browse.dw_Browse.SetFocus()
else
	Tab_1.Tabpage_Detail.dw_Detail.SetFocus()
end if
end subroutine

public subroutine of_goto_row (long al_doc_id, long al_seq_no, string as_column);//====================================================================
// Function: of_goto_row
//--------------------------------------------------------------------
// Description: Go to target Row/Column
//--------------------------------------------------------------------
// Arguments:
//                al_doc_id
//                al_seq_no
//                as_column
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:         Ken.Guo           Date: 12/04/2012
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


Long ll_find

Tab_1.Selecttab(2)

ll_find = tab_1.tabpage_detail.dw_detail.Find( 'doc_id = ' + String(al_doc_id) +  ' and seq_id = ' + String(al_seq_no) ,1,tab_1.tabpage_detail.dw_detail.RowCount())

If ll_find > 0 Then
	tab_1.tabpage_detail.dw_detail.ScrollToRow(ll_find)	
	tab_1.tabpage_detail.dw_detail.SetRow(ll_find)	
	tab_1.tabpage_detail.dw_detail.Setcolumn(as_column)
	tab_1.tabpage_detail.dw_detail.SetFocus()
End If

Return
end subroutine

public subroutine of_post_goto_row (long al_doc_id, long al_seq_no, string as_column);Post of_goto_row(al_doc_id,al_seq_no,as_column)
Return 
end subroutine

on u_tabpg_dm_ai.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.dw_filter=create dw_filter
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.dw_filter
end on

on u_tabpg_dm_ai.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.dw_filter)
end on

event constructor;call super::constructor;this.of_setresize( true)

//Start 04.17.2008 By Jervis
/*
this.inv_resize.of_register( tab_1,inv_resize.scalerightbottom)
this.inv_resize.of_register( dw_filter,inv_resize.scalerightbottom)
this.inv_resize.of_register( tab_1.tabpage_browse.dw_browse,inv_resize.scalerightbottom)
//this.inv_resize.of_register( tab_1.tabpage_detail.dw_filter2,inv_resize.scaleright)
this.inv_resize.of_register( tab_1.tabpage_detail.dw_detail,inv_resize.scalerightbottom)
*/
this.inv_resize.of_register( tab_1,inv_resize.scale)
this.inv_resize.of_register( dw_filter,inv_resize.scale)
this.inv_resize.of_register( tab_1.tabpage_browse.dw_browse,inv_resize.scale)
//this.inv_resize.of_register( tab_1.tabpage_detail.dw_filter2,inv_resize.scale)
this.inv_resize.of_register( tab_1.tabpage_detail.dw_detail,inv_resize.scale)
//End 04.17.2008 By Jervis
end event

event ue_set_security;//////////////////////////////////////////////////////////////////////
// $<event>ue_set_security.u_tabpg_dm_ai()
// $<arguments>
//		None		
// $<returns> (None)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.23.2007 by Jack (Document Manager)
//////////////////////////////////////////////////////////////////////
//Override by Alfee 09.30.2007

Long ll_row


gnv_app.of_set_ezmenu_refresh_state( TRUE )//added by gavins 20130325
gnv_app.post of_Refresh_EZMenu( )//added by gavins 20130325

If Not isvalid(m_pfe_cst_mdi_menu_contract_am) Then Return 
w_mdi.setredraw(false)
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add,'toolbaritemvisible', False)					
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addbuy,'toolbaritemvisible', False)			
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_add.m_addsell,'toolbaritemvisible', False)

gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_report,'toolbaritemvisible', False)			
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_select,'toolbaritemvisible', False)			
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_properties0,'toolbaritemvisible', False)			
//m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_email0.toolbaritemvisible = False	//by alfee at 03.29.2007		
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0,'toolbaritemvisible', False)	
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_print0,'toolbaritemvisible', False)			
//m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_email1.toolbaritemvisible = False	//alfee 03.22.2007
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_saveas,'toolbaritemvisible', False)			

gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check,'toolbaritemvisible', False)	
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkin,'toolbaritemvisible', False)			
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_check.m_checkout,'toolbaritemvisible', False)			

gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_save0,'toolbaritemvisible', False)			
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_addclause,'toolbaritemvisible', False)					
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge,'toolbaritemvisible', False)	
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergefield,'toolbaritemvisible', False)			
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_mergedata,'toolbaritemvisible', False)		
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_merge.m_insertreqmnt,'toolbaritemvisible', False)		

gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_workflow0,'toolbaritemvisible', False)			
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_clausemap,'toolbaritemvisible', False)			
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_addactioneitem,'toolbaritemvisible', False)			
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_deleteactioneitem,'toolbaritemvisible', False)			
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_letter,'toolbaritemvisible', False)	
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_fullscreen,'toolbaritemvisible', False)	
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_revision0,'toolbaritemvisible', false)
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_delete0,'toolbaritemvisible', false)
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.29.2007 By: Jack
//$<reason> Fix a defect.
gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_option.m_autonum0,'toolbaritemvisible', False)	
//---------------------------- APPEON END ----------------------------

Choose Case tab_1.selectedtab
	Case 1
		If ib_browse Then
			If w_mdi.of_security_access( 6904 ) = 0 Then
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_report,'toolbaritemvisible', False)			
			Else
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_report,'enabled', True)			
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_report,'toolbaritemvisible', True)			
			End If
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_select,'enabled', True)			
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_select,'toolbaritemvisible', True)			
			If tab_1.tabpage_browse.dw_browse.rowcount() < 1 Then
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_output0.m_report,'enabled', False)			
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_select,'enabled', False)			
			End If	
		End If	
	Case 2		
		If w_mdi.of_security_access( 6918 ) = 0 Then
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_addactioneitem,'toolbaritemvisible', False)
		Else
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_addactioneitem,'enabled', True)	
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_addactioneitem,'toolbaritemvisible', True)	
		End If
		If w_mdi.of_security_access( 6919 ) = 0 Then
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_deleteactioneitem,'toolbaritemvisible', False)		
		Else
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_deleteactioneitem,'enabled', True)		
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_deleteactioneitem,'toolbaritemvisible', True)		
		End If
		If w_mdi.of_security_access( 6912 ) = 0 Then
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_save0,'toolbaritemvisible', False)	
		Else
			//m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_save0.enabled = True	
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_save0,'toolbaritemvisible', True)			
		End If
		
		//Start changed by jervis 04/28/2007
		//If w_mdi.of_security_access( 6916 ) = 0 Then
		If w_mdi.of_security_access( 6916 ) = 0 or (not gb_workflow) Then
		//End changed
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_workflow0,'toolbaritemvisible', False)
		Else
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_workflow0,'enabled', True)	
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_workflow0,'toolbaritemvisible', True)	
		End If
		If w_mdi.of_security_access( 6920 ) = 0 Then
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_letter,'toolbaritemvisible', False)
		Else
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_letter,'enabled', True)	
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_letter,'toolbaritemvisible', True)	
		End If		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 02.07.2007 By: Jervis
		//$<reason> 
		ll_row = tab_1.tabpage_detail.dw_detail.GetRow()
		If ll_row > tab_1.tabpage_detail.dw_detail.RowCount() Then
			ll_row = tab_1.tabpage_detail.dw_detail.RowCount()
		End If
		If ll_row > 0 Then //Alfee 04.01.2008
			if tab_1.tabpage_detail.dw_detail.GetItemNumber(ll_row,"readonly_flag") = 1 then
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_deleteactioneitem,'enabled', False)	
			else
				gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_deleteactioneitem,'enabled', true)
			end if
		else
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_deleteactioneitem,'enabled', False)			
		End If
		//---------------------------- APPEON END ----------------------------

			
End Choose

//--------Begin Modified by Alfee 09.30.2007------------------
//<$Reason>Add read only control to the current contract
integer          li_index, li_count 
boolean 			lb_protect 
windowobject     lwo_temp[]
u_dw_contract    lst_temp

lwo_temp[1] = tab_1.tabpage_browse.dw_browse
lwo_temp[2] = tab_1.tabpage_detail.dw_detail

//Get & set read only flag at tab page level
lb_protect = inv_contract_details.of_get_protect_tabpg()

//Disable toolbars for the read only contract
IF lb_protect THEN
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_addactioneitem,'enabled', False)	
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_deleteactioneitem,'enabled', False)			
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_letter,'enabled', False)
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_save0,'enabled', False)
END IF

//Set Sertifi ICO. Added By Ken.Guo 2011-06-20. 
Long ll_actiontype
Datawindow ldw_ai
Choose Case tab_1.selectedtab 
	Case 1
		ldw_ai = tab_1.tabpage_browse.dw_browse
	Case 2
		ldw_ai = tab_1.tabpage_detail.dw_detail
End Choose
If gnv_data.of_getitem( 'icred_settings', 'esign', False) = '0' or ldw_ai.GetRow() = 0 Then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_sertify,'toolbaritemvisible', False) 
Else
	ll_row = ldw_ai.GetRow()
	If ll_row > ldw_ai.RowCount() Then
		ll_row = ldw_ai.RowCount()
	End If
	If ll_row > 0 Then
		ll_actiontype = ldw_ai.GetItemNumber(ll_row, 'action_type' ) 
		//If ll_actiontype > 0 and (ll_actiontype = gnv_sertifi.il_esign or ll_actiontype = gnv_echosign.il_esign ) Then //Added By Jay Chen 10-18-2013
		If ll_actiontype > 0 and (ll_actiontype = gnv_sertifi.il_esign or ll_actiontype = gnv_echosign.il_esign  or ll_actiontype = gnv_docusign.il_esign) Then // (Appeon)Harry 07.08.2016 - for docusign
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_sertify,'toolbaritemvisible', True) 
		Else
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_sertify,'toolbaritemvisible', False)
		End If
	End If
End If

//Added By Ken.Guo 12/09/2011. 
//If ldw_ai.GetItemNumber(ldw_ai.GetRow(),'approve_id') > 0 Then
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_approval.toolbaritemvisible = True		
//Else
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_approval,'toolbaritemvisible', False)		
//End If

//Set read only flag for each data window in the child tab page
li_count = UpperBound ( lwo_temp[] ) 
FOR li_index = 1 TO li_count 
   lst_temp = lwo_temp[li_index] 
	if lb_protect then
		lst_temp.of_disable_columns( ) 
	 else
		lst_temp.of_enable_columns( )
	end if 
NEXT

//Added By Ken.Guo 2009-06-04.
m_pfe_cst_mdi_menu_contract_am.of_refresh_option()



w_mdi.setredraw(true)
end event

event ue_post_doc_changed;call super::ue_post_doc_changed;IF al_old_doc_id <> al_new_doc_id THEN
	//Refresh data
	//tab_1.selecttab(1)
	//tab_1.tabpage_browse.dw_browse.retrieve(al_new_doc_id )
	of_retrieve()
END IF

return 1
end event

event resize;call super::resize;//comment by Jervis 04.17.2008
/*
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.07.2007 By: Machongmin
//$<reason> Fix a defect.

this.dw_filter.width = this.width - this.dw_filter.x - 20
this.tab_1.width = this.width - this.tab_1.x - 20
this.tab_1.height = this.height - this.tab_1.y + 8 //- 20 Modify by Evan on 2008-03-31

this.tab_1.tabpage_browse.dw_browse.width = this.tab_1.width - this.tab_1.tabpage_browse.dw_browse.x - 50
this.tab_1.tabpage_browse.dw_browse.height = this.tab_1.height - this.tab_1.tabpage_browse.dw_browse.y - 150

this.tab_1.tabpage_detail.dw_detail.width = this.tab_1.width - this.tab_1.tabpage_detail.dw_detail.x - 30 //50 Modify by Evan on 2008-03-20
this.tab_1.tabpage_detail.dw_detail.height = this.tab_1.height - this.tab_1.tabpage_detail.dw_detail.y - 150

//---------------------------- APPEON END ----------------------------
*/
//Start code by Jervis 05.29.2008
//Fixed BugG052902(PB&WEB p2)
this.dw_filter.of_resize( )
this.tab_1.tabpage_browse.dw_browse.of_resize( )
this.tab_1.tabpage_detail.dw_detail.of_resize( )
//End code By Jervis 05.29.2008

end event

event ue_initinstancevar;call super::ue_initinstancevar;str_action_item lstr_Null[]

is_prior = ""
is_filter = ""
istr_action[] = lstr_Null[]
ib_browse = false
ib_update_header_status = false
end event

type st_1 from u_tabpg_contract_master`st_1 within u_tabpg_dm_ai
end type

type tab_1 from tab within u_tabpg_dm_ai
integer y = 400
integer width = 3845
integer height = 1492
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean fixedwidth = true
boolean raggedright = true
boolean focusonbuttondown = true
boolean powertips = true
tabposition tabposition = tabsonbottom!
alignment alignment = center!
integer selectedtab = 2
tabpage_browse tabpage_browse
tabpage_detail tabpage_detail
end type

on tab_1.create
this.tabpage_browse=create tabpage_browse
this.tabpage_detail=create tabpage_detail
this.Control[]={this.tabpage_browse,&
this.tabpage_detail}
end on

on tab_1.destroy
destroy(this.tabpage_browse)
destroy(this.tabpage_detail)
end on

event selectionchanged;//////////////////////////////////////////////////////////////////////
// $<event>selectionchangedtab_1()
// $<arguments>
//		integer	oldindex		
//		integer	newindex		
// $<returns> long
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01.23.2007 by Jack (Document Manager)
//////////////////////////////////////////////////////////////////////

long	ll_Right

gnv_app.of_set_ezmenu_refresh_state( TRUE )//added by gavins 20130325
gnv_app.post of_Refresh_EZMenu( )//added by gavins 20130325

If ib_browse Then
	parent.event ue_set_security( )
End If
ib_browse = True

//BEGIN---Modify by Scofield on 2010-03-26
if IsValid(m_pfe_cst_mdi_menu_contract_am) then
	ll_Right = w_mdi.of_security_access(6924)
	if ll_Right <> 0 then
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_view.m_filter,'ToolbarItemVisible', true)
		if dw_filter.Visible then
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_view.m_filter,'ToolbarItemDown', True)
		else
			gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_view.m_filter,'ToolbarItemDown', False)
		end if
	else
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_view.m_filter,'ToolbarItemVisible', false)
	end if
end if
//END---Modify by Scofield on 2010-03-26


Post of_setfocus( )

end event

type tabpage_browse from userobject within tab_1
event resize pbm_size
integer x = 18
integer y = 16
integer width = 3808
integer height = 1364
long backcolor = 79741120
string text = "Browse"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "custom065!"
long picturemaskcolor = 12632256
string powertiptext = "Browse"
dw_browse dw_browse
end type

on tabpage_browse.create
this.dw_browse=create dw_browse
this.Control[]={this.dw_browse}
end on

on tabpage_browse.destroy
destroy(this.dw_browse)
end on

type dw_browse from u_dw_contract within tabpage_browse
string tag = "Action Item Browse"
integer width = 3822
integer height = 1384
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Action Item Browse"
boolean hscrollbar = true
boolean livescroll = false
string dataobject_original = "d_dm_doc_ai_browse"
end type

event doubleclicked;call super::doubleclicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.12.2007 By: Jervis
//$<reason> 
if row >  0 then
	tab_1.selecttab(2)
end if
//---------------------------- APPEON END ----------------------------

end event

event rowfocuschanged;call super::rowfocuschanged;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.12.2007 By: Jervis
//$<reason> 
//---------Begin Modified by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
//if tab_1.selectedtab = 1 and currentrow > 0 then
if currentrow > 0 and currentrow <> tab_1.tabpage_detail.dw_detail.getrow( )  then //(Appeon)Harry 12.17.2013 - V141 for BugH073101 of Contract History Issues
	tab_1.tabpage_detail.dw_detail.SetRow(currentrow)
	tab_1.tabpage_detail.dw_detail.ScrollToRow(currentrow)
	this.SetRow(currentrow)
	this.ScrollToRow(currentrow)
end if
//---------End Modfiied ------------------------------------------------------
//---------------------------- APPEON END ----------------------------

Event ue_set_security() //Added By Ken.Guo 2011-06-20. 
end event

event constructor;call super::constructor;this.of_setupdateable( false)
this.of_setrowselect(true)
this.ib_rmbmenu=false
event ue_populatedddws()
end event

event rbuttondown;//
end event

event resize;call super::resize;//of_resize()	//04.17.2008 By Jervis:resize dataobject
end event

event pfc_filterdlg;call super::pfc_filterdlg;Return Tab_1.Tabpage_Detail.dw_Detail.Event pfc_FilterDlg()		//Added by Scofield on 2010-03-30

end event

event pfc_deleterow;//Added By Ken.Guo 11/19/2011. 
Return tab_1.tabpage_detail.dw_detail.event pfc_deleterow( )
end event

event rowfocuschanging;call super::rowfocuschanging;If This.ib_zoom_triggered Then Return 1 //Added By Ken.Guo 12/13/2011. 
end event

type tabpage_detail from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 16
integer width = 3808
integer height = 1364
long backcolor = 79741120
string text = "Detail"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "custom100!"
long picturemaskcolor = 12632256
string powertiptext = "Detail"
dw_detail dw_detail
end type

on tabpage_detail.create
this.dw_detail=create dw_detail
this.Control[]={this.dw_detail}
end on

on tabpage_detail.destroy
destroy(this.dw_detail)
end on

type dw_detail from u_dw_contract within tabpage_detail
string tag = "Action Item Detail"
integer width = 3822
integer height = 1384
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Action Item Detail"
boolean livescroll = false
string dataobject_original = "d_dm_doc_ai_detail"
end type

event buttonclicked;call super::buttonclicked;str_pass lstr_pass_alm //02.26.2008
Str_ctx_info lstr_ctx
string 	 ls_notes

// need to do a set row - when clicking on a button for that row, the current row is not then clicked row for which the 
// is on
if of_check_read_only( ) then return success  //Add by Jack 08.30.2007
setrow(row)

choose case dwo.name
	case 'b_print'
		of_print_letter(row,string(this.GetItemNumber(row,"action_type")))
	case 'b_notes'	
		OpenWithParm( w_ai_notes, This.GetItemString( row, "notes" ))
		IF Message.StringParm = "Cancel" THEN
			Return failure
		ELSE
//			This.SetItem( row, "notes", Message.StringParm )
			//Begin - Added By Mark Lee 07/06/12
			ls_notes = String(Message.StringParm)
			This.SetItem( row, "notes", ls_notes  )
			this.event Itemchanged(row,object.notes,ls_notes)
			//End - Added By Mark Lee 07/06/12
		END IF
	case 'b_due_date','b_due_date_g','b_due_date_r' //Alfee 02.26.2008
		IF This.GetItemStatus(row, 0, Primary!) = NewModified! OR &
		   This.GetItemStatus(row, 0, Primary!) = New! THEN
			MessageBox("Alarm Setting","The alarm cannot be set until the record is saved.")
			RETURN
		END IF
		//IF of_show_missing_msg('due_date', this, 'datetime', 1) = success THEN			
		IF of_show_missing_msg('due_date', this, 'datetime', row) = success THEN	//03.13.2008
		   lstr_pass_alm.s_string_array[1] = String(il_doc_id)
		   lstr_pass_alm.s_string_array[2] = 'ctx_am_action_item'
		   lstr_pass_alm.s_string_array[3] = 'due_date'
		   //lstr_pass_alm.s_string_array[4] = This.object.due_date_t.text 
			lstr_pass_alm.s_string_array[4] = This.object.ctx_am_action_item_due_date_t.text //03.11.2008		
			lstr_pass_alm.s_string_array[5] = String(GetItemNumber(row, 'seq_id'))
			lstr_pass_alm.s_string_array[6] = '0'
			lstr_pass_alm.s_string_array[7] ='0'
			lstr_pass_alm.s_datetime[1] = this.GetItemDatetime( row, 'due_date')
		   OpenwithParm(w_ctx_alarm, lstr_pass_alm)
			This.SetColumn('due_date')	
		END IF
		//Set flag button
		of_set_flags( ) 
	case 'b_action_status'		//Add Action Items Status Track - Jervis 11.10.2010
		lstr_ctx.al_ctx_id = il_doc_id
		lstr_ctx.al_ai_id = GetItemNumber(row, 'seq_id')
		lstr_ctx.as_type = 'dm_ai'
		Openwithparm(w_actionitem_status_track,lstr_ctx)
end choose

end event

event constructor;call super::constructor;This.Of_Setdropdowncalendar(True)
Of_Setupdateable(true)

ib_RMBMenu = true								//Modified by Scofield on 2009-09-21

this.Sharedata( tab_1.tabpage_browse.dw_browse)

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.05.2007 By: Machongmin
//$<reason> Fix a defect.	
This.Event ue_populatedddws( )
//---------------------------- APPEON END ----------------------------

//Added By Mark Lee 08/06/12
this.of_set_idle_flag( False)
end event

event itemchanged;call super::itemchanged;String 	ls_lookup_disp
long		ll_Duration,ll_Dur_Type
Date		ld_StartDate,ld_EndDate
Time		lt_StartTime
DateTime	ldt_End

//---------Begin Added by (Appeon)Stephen 12.31.2013 for Bug 3609 - Corrected issue where Codes were being displayed on the action items when going through a workflow--------
long     ll_wf_id, ll_wf_step_id, ll_status[]
integer li_cnt, li_null
string   ls_filter
boolean lb_curr = false
//---------End Added ------------------------------------------------------

n_cst_datetime	lnv_datetime
str_action_item lstr_action
n_cst_workflow_triggers lnv_workflow

datawindowchild dwchild
choose case dwo.name
	case 'action_type'
		/*
		DWItemStatus ldws_status
		String ls_due_days
		Date ld_due_date
		ldws_status = dw_1.GetItemStatus(row, 0, Primary!)
		IF ldws_status = NewModified! OR ldws_status = New! THEN
			ls_due_days = gnv_data.of_getitem( "code_lookup", "custom_2", "lookup_code = " + data)
			ld_due_date = RelativeDate(Today(), Integer(ls_due_days))
			This.SetItem( row, "due_date", ld_due_date )
		END IF
		*/
	case "action_status"
		//--------- (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
		//---------Begin Added by (Appeon)Stephen 12.31.2013 for Bug 3609 - Corrected issue where Codes were being displayed on the action items when going through a workflow--------
		ll_wf_id = this.GetItemNumber(row,"wf_id")
		ll_wf_step_id = this.GetItemNumber(row,"wf_action_type_id")
			
		if ll_wf_id > 0 then
			ls_filter = "wf_id =" + string(ll_wf_id) + " and step_id = " + string(ll_wf_step_id) 
			gnv_data.of_get_wf_status_data("workflow_status_filter",ls_filter,"lookup_code", ll_status[])	
			for li_cnt = 1 to upperbound(ll_status)
				if long(data) = ll_status[li_cnt] then
					lb_curr = true
					exit
				end if
			next
			if lb_curr = false then 
				this.setitem(row, "action_status", this.getitemnumber(row, "action_status",primary!,true))
				return 2
			end if
		end if
		//---------End Added ------------------------------------------------------
		
		//Pop-up prompt when action status change	- jervis 03.10.2009
		if gb_workflow then
			lstr_action.wf_id = this.GetItemNumber(row,"wf_id")
			lstr_action.wf_step_id = this.GetItemNumber(row,"wf_action_type_id")
			lstr_action.as_assigned_to = this.GetItemString(row,"action_user")	//11.17.2010 -- jervis
			if not isnull(lstr_action.wf_id) then
				lstr_action.wf_action_status_id =  long(data) //this.GetItemNumber(row,"action_status")
				lnv_workflow = create n_cst_workflow_triggers
				if lnv_workflow.of_popup_prompt( lstr_action) <> 1 then
					destroy lnv_workflow
					return 2		//Reject the data value but allow the focus to change
				end if
				destroy lnv_workflow
			end if
		end if
		
		This.SetItem( row, "status_date", Datetime(Today()) )
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

//BEGIN---Modify by Scofield on 2010-02-23
if IsValid(m_pfe_cst_mdi_menu_contract_am) then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_save0,'enabled', true)
end if
//END---Modify by Scofield on 2010-02-23

end event

event itemfocuschanged;call super::itemfocuschanged;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 12.04.2006 By: Jervis
//$<reason> Filter Status
datawindowchild ldwc
long ll_wf_id,ll_wf_step_id
string ls_filter
//---------Begin Added by (Appeon)Stephen 12.31.2013 for Bug 3609 - Corrected issue where Codes were being displayed on the action items when going through a workflow--------
long ll_status[]
integer li_row, li_find, li_sort
//---------End Added ------------------------------------------------------

ll_wf_id = this.GetItemNumber(row,"wf_id")
ll_wf_step_id = this.GetItemNumber(row,"wf_action_type_id")
	
if dwo.name = "action_status" and ll_wf_id > 0 then
	if this.GetChild(dwo.name,ldwc) = 1 then
		ls_filter = "wf_id =" + string(ll_wf_id) + " and step_id = " + string(ll_wf_step_id) 
		//---------Begin Modified by (Appeon)Stephen 12.31.2013 for Bug 3609 - Corrected issue where Codes were being displayed on the action items when going through a workflow--------
         /*
		ls_filter = gnv_data.of_get_filter_data("workflow_status_filter",ls_filter,"lookup_code")
		
		/*
		if ls_filter <> "" then
			ls_filter += " or isnull(lookup_code) or lookup_code = -999"
		else
			ls_filter = "isnull(lookup_code) or lookup_code = -999"
		end if
		*/
		ldwc.SetFilter( ls_filter)
		ldwc.Filter()
		*/
		gnv_data.of_get_wf_status_data("workflow_status_filter",ls_filter,"lookup_code", ll_status[])		
		li_sort = 1
         for li_row = 1 to ldwc.rowcount()
			ldwc.setitem(li_row, "integer_6", 0)
		next		
		
		for li_row = 1 to upperbound(ll_status)
			li_find = ldwc.find("lookup_code = " + string(ll_status[li_row]), 1, ldwc.rowcount())
			if li_find > 0 then
				ldwc.setitem(li_find, "integer_6", li_row)
				li_sort +=1
			end if
		next
		
		ldwc.setsort("integer_6 desc")
		ldwc.sort()
		
		li_sort = long(ldwc.describe("DataWindow.Column.Count"))
		for li_row = 1 to li_sort
			ldwc.modify("#" +string(li_row)+ ".visible='0~t(if(integer_6 > 0,1,0))'")
			ldwc.modify("#" +string(li_row)+ ".protect='0~t(if(integer_6 > 0,0,1))'")
		next
		
		ldwc.scrolltorow(1)
		//---------End Modfiied ------------------------------------------------------
		
		//this.SetRedraw( false)
		is_prior = dwo.name
	end if
elseif is_prior = "action_status" then
	if this.GetChild(is_prior,ldwc) = 1 then
		//---------Begin Modified by (Appeon)Stephen 12.31.2013 for Bug 3609 - Corrected issue where Codes were being displayed on the action items when going through a workflow--------
		//ldwc.SetFilter("")
		//ldwc.Filter()
		ldwc.setsort("lookup_code asc")
		ldwc.sort()
		
		li_sort = long(ldwc.describe("DataWindow.Column.Count"))
		for li_row = 1 to li_sort
			ldwc.modify("#"+string(li_row)+".visible='1'")
		next
		//---------End Modfiied ------------------------------------------------------
		is_prior = ""
		this.SetRedraw( true )
	end if
end if

//---------------------------- APPEON END ----------------------------

end event

event pfc_retrieve;call super::pfc_retrieve;datawindowchild ldwc

//Fixed BugJ041007 by jervis 04.10.2009
if is_prior = "action_status" then
	if this.GetChild(is_prior,ldwc) = 1 then
		ldwc.SetFilter("")
		ldwc.Filter()
		is_prior = ""
	end if
end if

return retrieve(of_get_doc_id( ) )

end event

event pfc_postupdate;call super::pfc_postupdate;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.17.2006 By: Jervis
//$<reason> modify work flow
long ll_i,ll_count
n_cst_workflow_triggers    lnv_trigger

//-----------Begin modified by Alfee on 06.02.2008 -----------
//If not gb_workflow Then return 1
If not gb_workflow Then 
	gnv_data.of_retrieve( "ctx_am_ai_notification")
	of_set_flags( ) 	
	Return 1
End If
//-----------End Modified ------------------------------------

lnv_trigger = create n_cst_workflow_triggers


ll_count = UpperBound(istr_action)

//2006-11-20 by jervis
For ll_i = 1 to ll_count
	if istr_action[ll_i].status_changed_flag then
		//Start 02.05.2007 By Jervis
		//Set the flag of update document manager header status
		if lnv_trigger.of_status_changed( istr_action[ll_i]) = 2 then
			of_set_update_status_flag(true)
		end if
		//End 
		
	end if
Next

//Create Work Flow By Action Item Changed
lnv_trigger.of_workflow_triggers(istr_action)   
//2006-11-20

destroy lnv_trigger

//refresh data
this.event pfc_retrieve()

//<add> andy 2007.06.05 issue 11 (retrieve action items TAB)
w_contract lw_Temp
of_GetParentWindow(lw_Temp)
if isValid(lw_Temp) then 
	lw_Temp.tab_contract_details.tabpage_action_items.tab_1.tabpage_detail.dw_1.event pfc_retrieve( )
end if
//end of add

gnv_data.of_retrieve( "ctx_am_ai_notification") //Refresh cache - Alfee 03.11.2008
of_set_flags( ) //Set flag button - Alfee 02.26.2008

return 1
//---------------------------- APPEON END ----------------------------



end event

event pfc_preupdate;long ll_i,ll_seq,ll_ori,ll_cur
boolean lb_flag

str_action_item lstr_init[]
ll_seq = 1

istr_action = lstr_init

for ll_i = 1 to rowcount()
	If gb_workflow Then
		IF This.GetItemStatus( ll_i, 0, Primary! ) = DataModified! then
			ll_ori = this.GetItemNumber(ll_i,"action_status",primary!,true)
			ll_cur = this.GetItemNumber(ll_i,"action_status")
			if ((ll_ori <> ll_cur) or (isnull(ll_ori) and not isnull(ll_cur)) or (not isnull(ll_ori) and isnull(ll_cur))) Then
				istr_action[ll_seq].doc_id = This.getItemnumber( ll_i, "doc_id" )
				istr_action[ll_seq].seq_no = This.getItemnumber( ll_i, "seq_id" )
				istr_action[ll_seq].ctx_id = inv_contract_details.of_get_ctx_id( ) //17.01.2007 By Jervis
				istr_action[ll_seq].wf_id = this.GetItemNumber(ll_i,"wf_id")
				istr_action[ll_seq].wf_action_status_id = this.GetItemNumber(ll_i,"action_status")
				istr_action[ll_seq].wf_action_type_id = this.GetItemNumber(ll_i,"action_type")
				istr_action[ll_seq].status_changed_flag = false
				istr_action[ll_seq].module = "04"	//Contract Logix Agreement
				istr_action[ll_seq].trigger_by = "008"		//Trigger By Action Item Changed
				istr_action[ll_seq].screen_id = -10
				if this.GetItemNumber(ll_i,"wf_id") > 0 THEN
					istr_action[ll_seq].wf_step_id = this.GetItemNumber(ll_i,"wf_action_type_id")
					istr_action[ll_seq].notes = this.GetItemString(ll_i,"notes")
					istr_action[ll_seq].status_changed_flag = true
				end if
				ll_seq++
			else
				ll_ori = this.GetItemNumber(ll_i,"action_type",primary!,true)
				ll_cur = this.GetItemNumber(ll_i,"action_type")
				if ((ll_ori <> ll_cur) or (isnull(ll_ori) and not isnull(ll_cur)) or (not isnull(ll_ori) and isnull(ll_cur))) Then
					istr_action[ll_seq].doc_id = This.getItemnumber( ll_i, "doc_id" )
					istr_action[ll_seq].seq_no = This.getItemnumber( ll_i, "seq_id" )
					istr_action[ll_seq].ctx_id = inv_contract_details.of_get_ctx_id( ) //17.01.2007 By Jervis
					istr_action[ll_seq].wf_action_status_id = this.GetItemNumber(ll_i,"action_status")
					istr_action[ll_seq].wf_action_type_id = this.GetItemNumber(ll_i,"action_type")
					istr_action[ll_seq].status_changed_flag = false
					istr_action[ll_seq].module = "04"	//Contract Logix Agreement
					istr_action[ll_seq].trigger_by = "008"		//Trigger By Action Item Changed
					istr_action[ll_seq].screen_id = -10
					ll_seq++
				end if
			end if
		END IF
	End if
next

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 02.07.2007 By: Jervis
//$<reason> If the logged in user adds an action item and 
//				the Assigned To and From fields are not set to his/her id 
//				AND all the required fields are filled in 
//				AND the new Roles Access is unchecked .then show a message.
if w_mdi.of_security_access(6925) = 0 then	//Modify Other Users AI
	string ls_assigned_to,ls_assigned_by
	
	
	
	for ll_i = 1 to RowCount()
		ls_assigned_to = trim(this.GetItemString(ll_i,"action_user"))
		ls_assigned_by = trim(this.GetItemString(ll_i,"wf_assigned_by"))
		
		if this.GetItemStatus(ll_i,0,primary!) <> NotModified! then
			if (ls_assigned_to <> gs_user_id or isnull(ls_assigned_to)) and (ls_assigned_by <> gs_user_id or isnull(ls_assigned_by)) then
				lb_flag = true
				exit
			end if
		end if
	next
	if lb_flag then
		if MessageBox("Message","Once you save this Action Item you will not be able to modify it because you are not set as the Assigned To or Assigned By user.  Continue?",Question!,YesNo!,2) = 2 then
			return FAILURE
		end if
	end if
end if
//---------------------------- APPEON END ----------------------------
return success
end event

event pfc_postinsertrow;call super::pfc_postinsertrow;This.Setredraw( False)

This.SetItem( al_row, "action_user", gs_user_id )
This.SetItem( al_row, "create_date", DateTime(Today()) )
this.SetItem( al_row, "wf_assigned_by",gs_user_id)
this.SetItem( al_row, "due_date" ,datetime(RelativeDate(today(),7))   )
This.SetItem( al_row, "doc_id",of_get_doc_id())
This.SetItemStatus(al_row, 0, Primary!, NotModified!)
This.Setredraw( True)

IF IsValid(m_pfe_cst_mdi_menu_contract_am) THEN //Add if statment by Alfee 03.21.2008
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_deleteactioneitem,'enabled', true)
END IF

end event

event rowfocuschanged;call super::rowfocuschanged;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.12.2007 By: Jervis
//$<reason> 
if tab_1.selectedtab = 2 and currentrow > 0 then
	tab_1.tabpage_browse.dw_browse.SetRow(currentrow)
	tab_1.tabpage_browse.dw_browse.ScrollToRow(currentrow)
end if
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 02.07.2007 By: Jervis
//$<reason> 
dwitemstatus ldis_status
string ls_assigned_to,ls_assigned_by
boolean		lbn_flag

if not isvalid(m_pfe_cst_mdi_menu_contract_am) then return 
if w_mdi.of_security_access(6925) = 0 and currentrow > 0 then

	ldis_status = this.GetItemStatus(currentrow,0,primary!)
	ls_assigned_to = trim(this.GetItemString(currentrow,"action_user"))
	ls_assigned_by = trim(this.GetItemString(currentrow,"wf_assigned_by"))

	if (ldis_status = NotModified! or ldis_status = DataModified!) and (ls_assigned_to <> gs_user_id or isnull(ls_assigned_to)) and (ls_assigned_by <> gs_user_id or isnull(ls_assigned_by)) then
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_deleteactioneitem,'enabled', False)
	else
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_deleteactioneitem,'enabled', true)
	end if
else
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_deleteactioneitem,'enabled', true)
end if
//---------------------------- APPEON END ----------------------------

Event ue_set_security() //Added By Ken.Guo 2011-06-20. 
end event

event updateend;call super::updateend;//overriding
//Allow Extend Ancestor script, Add Audit feature for document->work flow -- jervis 11.10.2010

//BEGIN---Modify by Scofield on 2010-02-23
if IsValid(m_pfe_cst_mdi_menu_contract_am) then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_save0,'enabled', false)
end if
//END---Modify by Scofield on 2010-02-23

end event

event retrieveend;call super::retrieveend;long ll_i

if isvalid(m_pfe_cst_mdi_menu_contract_am) then
	if rowcount < 1 then
		//this.event pfc_insertrow()
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_deleteactioneitem,'enabled', False)
	else
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_deleteactioneitem,'enabled', true)
	end if
	
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_save0,'enabled', false)	//Added by Scofield on 2010-02-23
end if

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 02.07.2007 By: Jervis
//$<reason> If the logged in user adds an action item and 
//				the Assigned To and From fields are not set to his/her id 
//				AND all the required fields are filled in 
//				AND the new Roles Access is unchecked .then grey out fields.
if w_mdi.of_security_access(6925) = 0 then	//Modify Other Users AI
	string ls_assigned_to,ls_assigned_by
	
	for ll_i = 1 to RowCount
		ls_assigned_to = trim(this.GetItemString(ll_i,"action_user"))
		ls_assigned_by = trim(this.GetItemString(ll_i,"wf_assigned_by"))
	
		if (ls_assigned_to <> gs_user_id or isnull(ls_assigned_to)) and (ls_assigned_by <> gs_user_id or isnull(ls_assigned_by)) then
			this.SetItem(ll_i,"readonly_flag",1)
		elseIf this.GetItemNumber(ll_i,'wf_id') > 0 and This.GetItemString(ll_i, 'wf_complete_flag') = 'N' Then
			//this.SetItem(ll_i,"readonly_flag",0)
		end if
	next
end if
//---------------------------- APPEON END ----------------------------

end event

event pfc_deleterow;//-----Begin Added by Alfee 02.26.2008 ----------
//Override
Integer li_Rtn, 	li_active_status
Long ll_seq_id, ll_doc_id, ll_row, ll_wf_id
String 	ls_wf_complete_flag

if getrow() < 1 then return NO_ACTION
if ib_read_only then return NO_ACTION

//Begin - Added By Mark Lee 09/11/12
If w_mdi.of_security_access(6925) = 0  then
	If this.GetItemNumber(this.getrow(),"readonly_flag") = 1 Then 
		Messagebox("Delete confirm", "Please make sure you have right to delete the record(s).")
		Return FAILURE	
	End If
End If
//End - Added By Mark Lee 09/11/12

li_Rtn = MessageBox('Delete','Are you sure you want to delete this record?',Question!,YesNo!,2)
if li_Rtn = 1 then
	ll_doc_id = GetItemNumber(getrow(), 'doc_id')
	ll_seq_id = GetItemNumber(getrow(), 'seq_id')
	
	//Begin - Added By Mark Lee 05/30/2013
	ll_wf_id = this.GetItemNumber(this.getrow(), 'wf_id') 
	ls_wf_complete_flag = this.GetItemString(this.getrow(), 'wf_complete_flag') 
	IF not isnull(ll_wf_id)  and ll_wf_id > 0  and ( ls_wf_complete_flag <> 'Y' Or isnull(ls_wf_complete_flag) ) Then 
		li_Rtn = MessageBox('Delete confirm','Deleting the current step will stop the current workflow. ~r~nDo you want to continue?',Question!,YesNo!,2)
		if li_Rtn <> 1 then return NO_ACTION
	End If 
	//End - Added By Mark Lee 05/30/2013
	gnv_appeondb.of_startqueue( )
	DELETE FROM  CTX_AM_AI_NOTIFICATION_USERS WHERE doc_id = :ll_doc_id and seq_id = :ll_seq_id ;
	DELETE FROM  ctx_am_ai_alarm_attachment WHERE doc_id = :ll_doc_id and seq_id = :ll_seq_id ;		//Added by WuZhiJun on 2009-02-26
	DELETE FROM  CTX_AM_AI_NOTIFICATION WHERE doc_id = :ll_doc_id and seq_id = :ll_seq_id ;
	//---------Begin Commented by (Appeon)Harry 05.31.2013 for V141 add the Document level workflows to the audit trail --------
	//DELETE FROM ctx_am_action_item WHERE  doc_id = :ll_doc_id and seq_id = :ll_seq_id ; //Added By Ken.Guo 11/19/2011. 
	//---------End Commented ------------------------------------------------------
	gnv_appeondb.of_commitqueue( )
else //Alfee 04.02.2008
	return NO_ACTION
end if

//---------Begin Modified by (Appeon)Harry 12.18.2013 for V141 ISG-CLX--------
/*
//Modified By Ken.Guo 11/19/2011
//Super::Event pfc_deleteRow()
This.rowsdiscard( GetRow(), GetRow(), Primary!)
*/
Super::Event pfc_deleteRow()
if isvalid(m_pfe_cst_mdi_menu_contract_am) then
	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_save0.enabled = true
end if
//---------End Modfiied ------------------------------------------------------

//Commented By Ken.Guo 11/19/2011
////----------------------Begin Modified by Alfee 03.21.2008-------------------
////if this.RowCount() < 1 then
//IF this.RowCount() < 1 and IsValid(m_pfe_cst_mdi_menu_contract_am) THEN
////----------------------End Modified ----------------------------------------	
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_deleteactioneitem.enabled = False
//else
//	m_pfe_cst_mdi_menu_contract_am.m_documentmanager.m_deleteactioneitem.enabled = true
//end if

return SUCCESS
end event

event resize;call super::resize;//of_resize()	//04.17.2008 By Jervis:resize dataobject
end event

event rbuttonup;long	ll_Right

ll_Right = w_mdi.of_security_access(6935)				//Access Rights
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

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 02.22.2006 By: Cao YongWang
//$<reason> Performance tuning
string ls_coltype
If isvalid(iuo_Calendar) Then
	ls_coltype = this.Describe(dwo.name+".ColType")	
	If (ls_coltype = 'date' or ls_coltype = 'datetime') and (dwo.Name = "status_date" or dwo.Name = "start_date" or dwo.Name = "due_date" or dwo.Name = "end_date") Then
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

event pfc_filterdlg;call super::pfc_filterdlg;//BEGIN---Modify by Scofield on 2010-03-29

long	ll_TabBottomSpace,ll_dwBottomSpace
long	ll_Height

if dw_filter.Visible then 
	of_hidesearch()
Else
	dw_filter.Visible = true
	if IsValid(m_pfe_cst_mdi_menu_contract_am) then
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_view.m_filter,'ToolbarItemVisible', true)
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract_am.m_view.m_filter,'ToolbarItemDown', True)
	end if
	
	ll_Height = of_GetHeight()
	
	ll_TabBottomSpace = ll_Height - Tab_1.Y - Tab_1.Height
	ll_dwBottomSpace  = Tab_1.Tabpage_Detail.Height - Tab_1.Tabpage_Detail.dw_Detail.Y - Tab_1.Tabpage_Detail.dw_Detail.Height
	
	Tab_1.Y = dw_filter.Y + dw_filter.height + 20
	Tab_1.Height = ll_Height - ll_TabBottomSpace - Tab_1.Y
	
	Tab_1.Tabpage_Detail.dw_Detail.Height = Tab_1.Tabpage_Detail.Height - Tab_1.Tabpage_Detail.dw_Detail.Y - ll_dwBottomSpace
	Tab_1.Tabpage_Browse.dw_Browse.Height = Tab_1.Tabpage_Detail.dw_Detail.Height
End If

Return 1
//END---Modify by Scofield on 2010-03-29

end event

event rowfocuschanging;call super::rowfocuschanging;If This.ib_zoom_triggered Then Return 1 //Added By Ken.Guo 12/13/2011. 
end event

event ue_post_itemchanged;call super::ue_post_itemchanged;//Added By Ken.Guo 05/08/2012. Check & Reset Date Alarm Status.
Long ll_doc_id, ll_seq_id
n_cst_date_alarm lnv_date_alarm
If row <= 0 Then Return 
If dwoname = '' Then Return
ll_doc_id = This.GetItemNumber(row,'doc_id')
ll_seq_id = This.GetItemNumber(row,'seq_id')
If Describe(dwoname + '.ColType') = 'datetime' Then
	If This.GetItemDateTime(row, dwoname, Primary!, True) = This.GetItemDateTime(row, dwoname, Primary!, False)  Then
		//Do nothing
	Else
		lnv_date_alarm.of_reset_alart_status( 'ctx_am_action_item', dwoname,0, ll_doc_id,ll_seq_id,0)
	End If
End If
end event

type dw_filter from u_dw_contract within u_tabpg_dm_ai
string tag = "Filter Criteria"
integer width = 3845
integer height = 392
integer taborder = 10
boolean bringtotop = true
boolean titlebar = true
string title = "Filter Criteria"
boolean vscrollbar = false
boolean livescroll = false
string dataobject_original = "d_dm_ai_filter"
end type

event constructor;call super::constructor;this.of_setdropdowncalendar( true)
this.of_setupdateable( false)

this.ib_rmbmenu=false

//This.event ue_populatedddws( )
this.insertrow(0)

event ue_populatedddws()

////--------------------------- APPEON BEGIN ---------------------------
////$<add> 04.20.2007 By: Jack
////$<reason> Fix a defect.
//datawindowchild child
//this.getchild('action_for',child)
//child.insertrow(1)
////---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-09-05 By: Scofield
//$<Reason> If there is no black row,then insert a black row
String	ls_ActionFor

DataWindowChild	ldw_Child

This.GetChild('action_for',ldw_Child)
if ldw_Child.RowCount() > 0 then
	ls_ActionFor = ldw_Child.GetItemString(1,'user_id')
end if

if Not IsNull(ls_ActionFor) then
	ldw_Child.InsertRow(1)
end if
//---------------------------- APPEON END ----------------------------

of_HideSearch()			//Added by Scofield on 2010-04-28

end event

event buttonclicked;call super::buttonclicked;//---------Begin commented by Alfee 09.30.2007---------------------
//if of_check_read_only( ) then return success  //Add by Jack 08.30.2007
//---------End Commented ------------------------------------------

String 	ls_Filter

if row < 1 then Return
//if dwo.type <>'button' then return

//Parent.of_retrieve() //Added by Ken.Guo on 2009-01-05.Refresh data.

IF dwo.name='b_filter' then
	ls_filter = of_generate_filter( )
ELSEIF dwo.name='b_clear' THEN
	this.Reset()
	this.insertrow(0)
	ls_Filter=""
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.29.2007 By: Machongmin
//$<reason> Fix a defect.
elseif dwo.name = "b_me" then
	this.object.action_for[row] = gs_user_id
	ls_filter = of_generate_filter()
//---------------------------- APPEON END ----------------------------
//BEGIN---Modify by Scofield on 2010-03-29
elseif dwo.Name = "b_close" then
	of_HideSearch()
//END---Modify by Scofield on 2010-03-29
END IF

Tab_1.tabpage_detail.dw_detail.SetFilter(ls_Filter)
Tab_1.tabpage_detail.dw_detail.Filter()

end event

event rbuttondown;//
end event

event resize;call super::resize;//of_resize()	//04.17.2008 By Jervis:resize dataobject
end event

event pfc_filterdlg;Return Tab_1.Tabpage_Detail.dw_Detail.Event pfc_FilterDlg()	
end event

