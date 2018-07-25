$PBExportHeader$w_docwfstepstatus.srw
forward
global type w_docwfstepstatus from w_popup
end type
type dw_workflow_step_status from datawindow within w_docwfstepstatus
end type
type dw_workflow_steps from datawindow within w_docwfstepstatus
end type
type gb_1 from groupbox within w_docwfstepstatus
end type
type gb_2 from groupbox within w_docwfstepstatus
end type
end forward

global type w_docwfstepstatus from w_popup
integer width = 1294
integer height = 1032
boolean maxbox = false
long backcolor = 33551856
dw_workflow_step_status dw_workflow_step_status
dw_workflow_steps dw_workflow_steps
gb_1 gb_1
gb_2 gb_2
end type
global w_docwfstepstatus w_docwfstepstatus

type variables
long	il_doc_id

end variables

forward prototypes
public function long of_refreshworkflowstep ()
end prototypes

public function long of_refreshworkflowstep ();//====================================================================
// Function: of_RefreshWorkFlowStep()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-07-13
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Contractlogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_doc_id,ll_CurRow,ll_step_id,ll_FoundRow
Boolean	lb_NeedRestore

DataWindowChild ldwc_Child

if IsValid(gw_contract) then
	if IsValid(gw_contract.tab_contract_details) then
		if IsValid(gw_contract.tab_contract_details.tabpage_images) then
			if IsValid(gw_contract.tab_contract_details.tabpage_images.tab_1) then
				if IsValid(gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data) then
					ll_doc_id = gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.of_get_doc_id()
				end if
			end if
		end if
	end if
end if

if il_doc_id = ll_doc_id then lb_NeedRestore = true

il_doc_id = ll_doc_id

if IsNull(il_doc_id) or il_doc_id <= 0 then Return -1

////////////////////////////////////////////////////////////////////////////
ll_CurRow = dw_workflow_steps.GetRow()
if lb_NeedRestore and (ll_CurRow > 0 and ll_CurRow <= dw_workflow_steps.RowCount()) then
	ll_step_id = dw_workflow_steps.GetItemNumber(ll_CurRow,"al_step_id")
end if
////////////////////////////////////////////////////////////////////////////

dw_workflow_steps.SetTransObject(SQLCA)
dw_workflow_steps.Reset()

dw_workflow_steps.GetChild("al_step_id",ldwc_Child)
ldwc_Child.SetTransObject(SQLCA)
ldwc_Child.Reset()
ldwc_Child.Retrieve(il_doc_id,gs_user_id)

dw_workflow_step_status.SetTransObject(SQLCA)
dw_workflow_step_status.Reset()

if ldwc_Child.RowCount() <= 0 then Return -1

ll_CurRow = dw_workflow_steps.InsertRow(0)
/////////////////////////////////////////////////////////////
if lb_NeedRestore and ll_step_id > 0 then
	dw_workflow_steps.GetChild("al_step_id",ldwc_Child)
	ll_FoundRow = ldwc_Child.Find("ctx_am_action_item_wf_action_type_id = " + String(ll_step_id),1,ldwc_Child.RowCount())
	if ll_FoundRow > 0 then
		dw_workflow_steps.SetItem(1,"al_step_id",ll_step_id)
		dw_workflow_steps.Trigger Event ItemChanged(1,dw_workflow_steps.Object.al_step_id,String(ll_step_id))
		Return 1
	end if
end if
/////////////////////////////////////////////////////////////
ll_step_id = ldwc_Child.GetItemNumber(1,"ctx_am_action_item_wf_action_type_id")
dw_workflow_steps.SetItem(1,"al_step_id",ll_step_id)
dw_workflow_steps.Trigger Event ItemChanged(1,dw_workflow_steps.Object.al_step_id,String(ll_step_id))

Return 1

end function

on w_docwfstepstatus.create
int iCurrent
call super::create
this.dw_workflow_step_status=create dw_workflow_step_status
this.dw_workflow_steps=create dw_workflow_steps
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_workflow_step_status
this.Control[iCurrent+2]=this.dw_workflow_steps
this.Control[iCurrent+3]=this.gb_1
this.Control[iCurrent+4]=this.gb_2
end on

on w_docwfstepstatus.destroy
call super::destroy
destroy(this.dw_workflow_step_status)
destroy(this.dw_workflow_steps)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;call super::open;long	ll_RtnVal

This.Title = "Workflow Step for " + gs_user_id

if IsValid(gw_Contract) then
	if gb_IsDocMode then
		This.X = w_MDI.X + w_MDI.Width - This.Width - 120
		
		This.Y = w_MDI.Y + w_MDI.Height - This.Height + 20
	else
		If gw_Contract.X + gw_Contract.Width - This.Width - 120 < 0 Then
			This.x = w_MDI.X + w_MDI.Width - This.Width - 120
		Else
			This.X = gw_Contract.X + gw_Contract.Width - This.Width - 120
		End If
		If gw_Contract.Y + gw_Contract.Height - This.Height + 20 < This.Height Then
			This.Y = w_MDI.Y + w_MDI.Height - This.Height + 20
		Else
			This.Y = gw_Contract.Y + gw_Contract.Height - This.Height + 20
		End If
	end if
end if

ll_RtnVal = of_RefreshWorkFlowStep()
if ll_RtnVal < 0 then Close(This)

end event

event show;call super::show;long	ll_RtnVal

ll_RtnVal = of_RefreshWorkFlowStep()
if ll_RtnVal < 0 then Close(This)

end event

type dw_workflow_step_status from datawindow within w_docwfstepstatus
integer x = 187
integer y = 332
integer width = 933
integer height = 496
integer taborder = 20
string dataobject = "d_workflow_step_status"
boolean vscrollbar = true
boolean border = false
end type

event buttonclicked;long		ll_wf_id,ll_step_id,ll_status_id,ll_FoundRow,ll_RtnVal
String	ls_FindExp

u_dw_contract	ldw_Detail

if dwo.Name <> "b_statusname" then Return

if IsValid(gw_contract) then
	if IsValid(gw_contract.tab_contract_details) then
		if IsValid(gw_contract.tab_contract_details.tabpage_images) then
			if IsValid(gw_contract.tab_contract_details.tabpage_images.tab_1) then
				if IsValid(gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_action) then
					if IsValid(gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_action.tab_1) then
						if IsValid(gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_action.tab_1.tabpage_detail) then
							if IsValid(gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_action.tab_1.tabpage_detail.dw_detail) then
								ldw_Detail = gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_action.tab_1.tabpage_detail.dw_detail
							end if
						end if
					end if
				end if
			end if
		end if
	end if
end if

if Not IsValid(ldw_Detail) then Return

if gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.of_get_doc_id() <> gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_action.of_get_doc_id() then
	//Modified By Ken.Guo 09/03/2012. Fixed bug. the action_status data is refreshed before update.
	//gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_action.Event ue_doc_changed(gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_action.of_get_doc_id(),gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.of_get_doc_id(),gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_action.of_get_revision(),gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.of_get_revision())
	gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_action.of_set_docrevision( gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.of_get_doc_id(), gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.of_get_revision())
end if

ldw_Detail.Event pfc_Retrieve()

ll_wf_id = This.GetItemNumber(Row,"wf_id")
ll_step_id = This.GetItemNumber(Row,"step_id")
ll_status_id = This.GetItemNumber(Row,"action_status_id")

ls_FindExp = "wf_id = " + String(ll_wf_id) + " and wf_action_type_id = " + String(ll_step_id) + " and action_user = '" + gs_user_id + "' and wf_complete_flag <> 'Y' and active_status >= 0"

ll_FoundRow = ldw_Detail.Find(ls_FindExp,1,ldw_Detail.RowCount())
if ll_FoundRow > 0 then
	ldw_Detail.SetItem(ll_FoundRow,"action_status",ll_status_id)
	ll_RtnVal = ldw_Detail.Trigger Event ItemChanged(ll_FoundRow,ldw_Detail.Object.action_status,String(ll_status_id))
	
	if ll_RtnVal = 2 then
		ldw_Detail.Event pfc_Retrieve()
	else
		if ldw_Detail.of_AcceptText(true) < 0 then 
			gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_action.of_retrieve() //Added By Ken.Guo 09/03/2012
			Return
		End If
		if ldw_Detail.of_Validation() < 0 then 
			gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_action.of_retrieve() //Added By Ken.Guo 09/03/2012
			Return
		End If
		if ldw_Detail.of_Update(true,false) = 1 then
			ldw_Detail.of_PostUpdate()
		end if
	end if
end if

gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_action.of_retrieve() //Added By Ken.Guo 09/03/2012

ll_RtnVal = of_RefreshWorkFlowStep()
if ll_RtnVal <= 0 then Hide(Parent)

/*

If Not gb_workflow Then 
	gnv_data.of_retrieve( "ctx_am_ai_notification")
	//of_set_flags( ) 	
	Return
End If

lnv_WorkFlow = Create n_cst_WorkFlow_triggers

lstr_action[1].wf_id = This.GetItemNumber(Row,"wf_id")
lstr_action[1].wf_step_id = This.GetItemNumber(Row,"step_id")
if Not IsNull(lstr_action[1].wf_id) then
	lstr_action[1].wf_action_status_id = This.GetItemNumber(Row,"action_status_id")
	ll_RtnVal = lnv_WorkFlow.of_Popup_Prompt(lstr_action[1])
	if ll_RtnVal <> 1 then Return
end if

//This.SetItem(Row,"status_date",Datetime(Today()))

lstr_action[1].doc_id = This.GetItemNumber(Row,"doc_id")
lstr_action[1].seq_no = This.GetItemNumber(Row,"seq_id")
//	lstr_action[1].ctx_id = inv_contract_details.of_Get_ctx_id()
lstr_action[1].wf_action_status_id = This.GetItemNumber(Row,"action_status")
lstr_action[1].wf_action_type_id = This.GetItemNumber(Row,"action_type")
lstr_action[1].status_changed_flag = false
lstr_action[1].module = "04"				//Contract Logix Agreement
lstr_action[1].trigger_by = "008"		//Trigger By Action Item Changed
lstr_action[1].screen_id = -10

lstr_action[1].wf_step_id = This.GetItemNumber(Row,"wf_action_type_id")
lstr_action[1].notes = This.GetItemString(Row,"notes")
lstr_action[1].status_changed_flag = true

if lstr_action[1].status_changed_flag then
	//Set the flag of update document manager header status
	if lnv_WorkFlow.of_status_changed(lstr_action[1]) = 2 then
		//of_set_update_status_flag(true)
	end if
end if

//Create Work Flow By Action Item Changed
lnv_WorkFlow.of_workflow_triggers(lstr_action)   

destroy lnv_WorkFlow

//refresh data
//this.event pfc_retrieve()

//w_contract lw_Temp
//of_GetParentWindow(lw_Temp)
//if isValid(lw_Temp) then 
//	lw_Temp.tab_contract_details.tabpage_action_items.tab_1.tabpage_detail.dw_1.event pfc_retrieve( )
//end if

gnv_data.of_retrieve( "ctx_am_ai_notification") //Refresh cache - Alfee 03.11.2008
//of_set_flags( ) //Set flag button - Alfee 02.26.2008

destroy lnv_WorkFlow
*/

end event

type dw_workflow_steps from datawindow within w_docwfstepstatus
integer x = 187
integer y = 108
integer width = 887
integer height = 84
integer taborder = 10
string title = "none"
string dataobject = "d_workflow_steps"
boolean border = false
end type

event itemchanged;String	ls_ColName
long		ll_wf_id,ll_Step_id,ll_FoundRow,ll_Cycle,ll_RowCnts,ll_Action_Status

DataWindowChild ldwc_Child

ls_ColName = dwo.Name

if ls_ColName = "al_step_id" then
	This.GetChild("al_step_id",ldwc_Child)
	ll_FoundRow = ldwc_Child.Find("ctx_am_action_item_wf_action_type_id = " + data,1,ldwc_Child.RowCount())
	
	if ll_FoundRow > 0 then
		ll_wf_id = ldwc_Child.GetItemNumber(ll_FoundRow,"ctx_am_action_item_wf_id")
		dw_workflow_step_status.Retrieve(ll_wf_id,long(data))
		
		ll_Action_Status = ldwc_Child.GetItemNumber(ll_FoundRow,"ctx_am_action_item_action_status")
		if IsNull(ll_Action_Status) then ll_Action_Status = 0
		
		ll_RowCnts = dw_workflow_step_status.RowCount()
		for ll_Cycle = 1 to ll_RowCnts
			dw_workflow_step_status.SetItem(ll_Cycle,"current_status",ll_Action_Status)
		next
	end if
end if

end event

type gb_1 from groupbox within w_docwfstepstatus
integer x = 73
integer y = 28
integer width = 1106
integer height = 208
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Current Active Workflow Step"
end type

type gb_2 from groupbox within w_docwfstepstatus
integer x = 73
integer y = 252
integer width = 1106
integer height = 620
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Workflow Status"
end type

