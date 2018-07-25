$PBExportHeader$w_ctx_action_item.srw
forward
global type w_ctx_action_item from w_response
end type
type cb_cancel from commandbutton within w_ctx_action_item
end type
type cb_ok from commandbutton within w_ctx_action_item
end type
type dw_action_item from u_dw_contract within w_ctx_action_item
end type
end forward

global type w_ctx_action_item from w_response
integer width = 2761
integer height = 1176
string title = "Action Item Detail"
cb_cancel cb_cancel
cb_ok cb_ok
dw_action_item dw_action_item
end type
global w_ctx_action_item w_ctx_action_item

type variables
Boolean	ib_IsDoc

end variables

forward prototypes
public subroutine of_save ()
end prototypes

public subroutine of_save ();long		ll_ctx_id,ll_ctx_action_item_id,ll_Action_Status,ll_Row
long		ll_wf_id,ll_wf_step_id,ll_doc_id,ll_seq_id
String	ls_Module
string ls_assigned_to
Boolean	lb_Status_Changed

DWItemStatus	ldwis_Status

str_action_item 				lstr_action[1]
n_cst_WorkFlow_triggers		lnv_Trigger

dw_Action_Item.AcceptText()
ll_Row = dw_Action_Item.GetRow()
if ll_Row <= 0 or ll_Row > dw_Action_Item.RowCount() then Return

ll_wf_id  = dw_Action_Item.GetItemNumber(ll_Row,"wf_id")
ls_Module = dw_Action_Item.GetItemString(ll_Row,"wf_Module")
ll_wf_step_id = dw_Action_Item.GetItemNumber(ll_Row,"wf_action_type_id")
ll_Action_Status = dw_Action_Item.GetItemNumber(ll_Row,"Action_Status")
ls_assigned_to = dw_action_item.GetItemString( ll_row,"action_user")

ldwis_Status = dw_Action_Item.GetItemStatus(ll_Row,"Action_Status",Primary!)
if ldwis_Status = DataModified! or ldwis_Status = NewModified! then lb_Status_Changed = true

if gb_WorkFlow and Not IsNull(ll_wf_id) then
	lnv_Trigger = create n_cst_WorkFlow_triggers
	
	lstr_action[1].wf_id = ll_wf_id
	lstr_action[1].wf_step_id = ll_wf_step_id
	lstr_action[1].wf_Action_Status_id = ll_Action_Status
	lstr_action[1].as_assigned_to = ls_assigned_to		//jervis 01.13.2011
	if Not IsNull(lstr_action[1].wf_id) then
		if lnv_Trigger.of_Popup_Prompt(lstr_action[1]) <> 1 then
			Destroy lnv_Trigger
			Return 
		end if
	end if
end if

This.Event pfc_save()

Choose Case ls_Module
	Case "03" // Contract Logix
		ll_ctx_id = dw_Action_Item.GetItemNumber(ll_Row,"ctx_id")
		ll_ctx_action_item_id = dw_Action_Item.GetItemNumber(ll_Row,"ctx_action_item_id")
		
		// Trigger work flow
		If gb_WorkFlow and Not IsNull(ll_wf_id) Then
			lstr_action[1].ctx_action_item_id = ll_ctx_action_item_id
			lstr_action[1].ctx_id = ll_ctx_id
			lstr_action[1].wf_id = ll_wf_id
			lstr_action[1].wf_Action_Status_id = ll_Action_Status
			lstr_action[1].wf_action_type_id = dw_Action_Item.GetItemNumber(ll_Row,"action_type")
			lstr_action[1].status_changed_flag = False
			lstr_action[1].module = "03"				//Contract Logix Tracking
			lstr_action[1].trigger_by = "008"		//Trigger By Action Item Changed
			lstr_action[1].screen_id = -10
			lstr_action[1].as_assigned_to = ls_assigned_to		//jervis 01.13.2011
			If lstr_action[1].wf_id > 0 And dw_Action_Item.GetItemString(ll_Row,"wf_complete_flag") = "N" Then
				lstr_action[1].wf_step_id = ll_wf_step_id
				lstr_action[1].Notes = dw_Action_Item.GetItemString(ll_Row,"Notes")
				lstr_action[1].status_changed_flag = lb_Status_Changed
			End If
			
			lnv_Trigger.of_status_changed(lstr_action[1])
			
			//Create Work Flow By Action Item Changed
			lnv_Trigger.of_WorkFlow_triggers(lstr_action)
		End If
	Case "04"
		ll_doc_id = dw_Action_Item.GetItemNumber(ll_Row,"doc_id")
		ll_seq_id = dw_Action_Item.GetItemNumber(ll_Row,"seq_id")
		
		// Trigger work flow
		If gb_WorkFlow and Not IsNull(ll_wf_id) Then
			lstr_action[1].ctx_id = dw_Action_Item.GetItemNumber(ll_Row,"ctx_id")
			lstr_action[1].seq_no = ll_seq_id
			lstr_action[1].doc_id = ll_doc_id
			lstr_action[1].wf_id = ll_wf_id
			lstr_action[1].wf_Action_Status_id = ll_Action_Status
			lstr_action[1].wf_action_type_id = dw_Action_Item.GetItemNumber(ll_Row,"action_type")
			lstr_action[1].status_changed_flag = False
			lstr_action[1].module = "04" 				//Contract Logix Document manager
			lstr_action[1].trigger_by = "008"		//Trigger By Action Item Changed
			lstr_action[1].screen_id = -10
			lstr_action[1].as_assigned_to = ls_assigned_to		//jervis 01.13.2011
			If lstr_action[1].wf_id > 0 And dw_Action_Item.GetItemString(ll_Row,"wf_complete_flag") = "N" Then
				lstr_action[1].wf_step_id = ll_wf_step_id
				lstr_action[1].Notes = dw_Action_Item.GetItemString(ll_Row,"Notes")
				lstr_action[1].status_changed_flag = lb_Status_Changed
			End If
			
			lnv_Trigger.of_status_changed(lstr_action[1])
			
			//Create Work Flow By Action Item Changed
			lnv_Trigger.of_WorkFlow_triggers(lstr_action)
		End If
End Choose

if IsValid(lnv_Trigger) Then Destroy lnv_Trigger

end subroutine

on w_ctx_action_item.create
int iCurrent
call super::create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_action_item=create dw_action_item
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancel
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.dw_action_item
end on

on w_ctx_action_item.destroy
call super::destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_action_item)
end on

event open;call super::open;str_pass lstr_Pass

lstr_Pass = Message.PowerObjectParm

if lstr_Pass.s_string_array[3] = "ctx_action_item" then
	ib_IsDoc = false
	dw_action_item.DataObject = "d_cal_ctx_action_items"
else
	ib_IsDoc = true
	dw_action_item.DataObject = "d_cal_doc_action_items"
end if

dw_action_item.SetTransObject(SQLCA)
dw_action_item.Retrieve(long(lstr_pass.s_string_array[1]),long(lstr_pass.s_string_array[2]))

dw_action_item.of_SetDropDownCalendar(true)

if AppeonGetClientType() = "WEB" then
	This.Width  += 20
	This.Height += 15
end if

end event

event closequery;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  closequery
//
//	Description:
//	Search for unsaved datawindows prompting the user if any
//	pending updates are found.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
// 6.0	Enhanced control on what objects are to be updated.
// 6.0.01 Make sure the window is not minimized and behind other windows.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Constant Integer	ALLOW_CLOSE = 0
Constant Integer	PREVENT_CLOSE = 1

Integer	li_msg
Integer	li_rc
String	ls_msgparms[]
Powerobject lpo_updatearray[]

// Check if the CloseQuery process has been disabled
If ib_disableclosequery Then
	Return ALLOW_CLOSE
End If

// Call event to perform any pre-CloseQuery processing
If This.Event pfc_preclose ( ) <> 1 Then
	// Prevent the window from closing
	Return PREVENT_CLOSE 
End If

// Prevent validation error messages from appearing while the window is closing
// and allow others to check if the  CloseQuery process is in progress
ib_closestatus = True

// Determine the objects for which an update will be attempted.
// For the CloseQuery, the order sequence is as follows: 
//		1) Specified permananent sequence (thru of_SetUpdateObjects(...)).
//		2) None was specified, so use default window control array.
If UpperBound(ipo_updateobjects) > 0 Then
	lpo_updatearray = ipo_updateobjects
Else
	lpo_updatearray = This.Control		
End If

// Check for any pending updates
li_rc = of_UpdateChecks(lpo_updatearray)
If li_rc = 0 Then
	// Updates are NOT pending, allow the window to be closed.
	ib_closestatus = False
	Return ALLOW_CLOSE
ElseIf li_rc < 0 Then
	// Make sure the window is not minimized and behind other windows.
	If this.WindowState = Minimized! Then
		this.WindowState = Normal!
	End If
	this.BringToTop = True

	// There are Updates pending, but at least one data entry error was found.
	// Give the user an opportunity to close the window without saving changes
	If IsValid(gnv_app.inv_error) Then
		li_msg = gnv_app.inv_error.of_Message('pfc_closequery_failsvalidation', &
					 ls_msgparms, gnv_app.iapp_object.DisplayName)
	Else
		li_msg = of_MessageBox ("pfc_master_closequery_failsvalidation", &
					gnv_app.iapp_object.DisplayName, &
					"The information entered does not pass validation and "  + &
					"must be corrected before changes can be saved.~r~n~r~n" + &
					"Close without saving changes?", &
					exclamation!, YesNo!, 2)
	End If
	If li_msg = 1 Then
		ib_closestatus = False
		Return ALLOW_CLOSE
	End If
Else
	// Make sure the window is not minimized and behind other windows.
	If this.WindowState = Minimized! Then
		this.WindowState = Normal!
	End If	
	this.BringToTop = True
	
	// Changes are pending, prompt the user to determine if they should be saved
	If IsValid(gnv_app.inv_error) Then
		li_msg = gnv_app.inv_error.of_Message('pfc_closequery_savechanges',  &
					ls_msgparms, gnv_app.iapp_object.DisplayName)		
	Else
		li_msg = of_MessageBox ("pfc_master_closequery_savechanges", &
					gnv_app.iapp_object.DisplayName, &
					"Do you want to save changes?", exclamation!, YesNoCancel!, 1)
	End If
	Choose Case li_msg
		Case 1
			// YES - Update
			// If the update fails, prevent the window from closing
			of_Save()
			// Successful update, allow the window to be closed
			ib_closestatus = False
			Return ALLOW_CLOSE
		Case 2
			// NO - Allow the window to be closed without saving changes
			ib_closestatus = False
			Return ALLOW_CLOSE
		Case 3
			// CANCEL -  Prevent the window from closing
	End Choose
End If

// Prevent the window from closing
ib_closestatus = False
Return PREVENT_CLOSE
end event

type cb_cancel from commandbutton within w_ctx_action_item
integer x = 2386
integer y = 980
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn(Parent,"Cancel")

end event

type cb_ok from commandbutton within w_ctx_action_item
integer x = 2011
integer y = 980
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;of_Save()

CloseWithReturn(Parent,"OK")

end event

type dw_action_item from u_dw_contract within w_ctx_action_item
integer x = 18
integer y = 20
integer width = 2711
integer height = 928
integer taborder = 10
string dataobject = "d_cal_ctx_action_items"
boolean vscrollbar = false
end type

event retrieveend;call super::retrieveend;long		ll_wf_id,ll_wf_step_id,ll_Row
String	ls_filter

DataWindowChild	ldwc_Child

ll_Row = This.GetRow()

if ll_Row > 0 and ll_Row <= This.RowCount() then
	ll_wf_id = This.GetItemNumber(ll_Row, "wf_id")
	if ll_wf_id > 0 then
		ll_wf_step_id = This.GetItemNumber(ll_Row, "wf_action_type_id")
		ls_filter = "wf_id =" + String(ll_wf_id) + " and step_id = " + String(ll_wf_step_id) 
		ls_filter = gnv_data.of_get_filter_data("workflow_status_filter",ls_filter,"lookup_code")
	end if
	
	This.GetChild("action_status",ldwc_Child)
	
	ldwc_Child.SetFilter(ls_filter)
	ldwc_Child.Filter()
end if

end event

event itemchanged;call super::itemchanged;long		ll_Duration,ll_Dur_Type
Date		ld_StartDate
Time		lt_StartTime
DateTime	ldt_End

n_cst_datetime	lnv_datetime

Choose Case Lower(dwo.Name)
	Case "action_status"
		if ib_IsDoc then
			This.SetItem(Row,"Status_Date",Datetime(Today()))
		else
			This.SetItem(Row,"Action_Date",Datetime(Today()))
		end if
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
End Choose

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
//	Copyright © 1996-2000 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
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
	If (ls_coltype = 'date' or ls_coltype = 'datetime') and (dwo.name = "action_date" or dwo.name = "status_date" or dwo.name = "start_date" or dwo.name = "due_date" or dwo.name = "end_date") Then
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

event buttonclicked;call super::buttonclicked;String	ls_Notes

if dwo.Name = "b_notes" then
	ls_Notes = This.GetItemString(Row,"Notes")
	OpenWithParm(w_ai_notes,ls_Notes)
	ls_Notes = Message.StringParm
	if ls_Notes <> "Cancel" then
		This.SetItem(Row,"Notes",ls_Notes)
	end if
end if

end event

