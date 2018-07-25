$PBExportHeader$w_contract_status_track.srw
forward
global type w_contract_status_track from w_response
end type
type cb_print from commandbutton within w_contract_status_track
end type
type cb_add from commandbutton within w_contract_status_track
end type
type cb_insert from commandbutton within w_contract_status_track
end type
type cb_del from commandbutton within w_contract_status_track
end type
type cb_save from commandbutton within w_contract_status_track
end type
type cb_close from commandbutton within w_contract_status_track
end type
type dw_status_track from u_dw within w_contract_status_track
end type
end forward

global type w_contract_status_track from w_response
string tag = "Contract Status Track"
integer x = 0
integer y = 0
integer width = 2290
integer height = 1728
string title = "Contract Status Track"
long backcolor = 33551856
cb_print cb_print
cb_add cb_add
cb_insert cb_insert
cb_del cb_del
cb_save cb_save
cb_close cb_close
dw_status_track dw_status_track
end type
global w_contract_status_track w_contract_status_track

type variables
long		il_CtxID
string is_fieldname
Str_ctx_info istr_ctx
end variables

forward prototypes
public subroutine wf_inserttrack (long al_row)
public function long wf_savetrack ()
public function integer wf_set_readonly ()
end prototypes

public subroutine wf_inserttrack (long al_row);long		ll_Row,ll_Cycle,ll_RowCnt

ll_Row = dw_Status_Track.InsertRow(al_Row)
dw_Status_Track.SetItem(ll_Row,'ctx_id',il_CtxID)
dw_Status_Track.SetItem(ll_Row,'user_id',gs_user_id)

ll_RowCnt = dw_Status_Track.RowCount()
for ll_Cycle = ll_Row to ll_RowCnt
	dw_Status_Track.SetItem(ll_Cycle,'seq_no',ll_Cycle)
	dw_Status_Track.SetItem(ll_Cycle,'field_name',is_fieldname) //add custom status process - jervis 04.19.2011
next

dw_Status_Track.SetItemStatus(ll_Row,0,Primary!,NotModified!)		//Set to New! status

dw_Status_Track.ScrollToRow(ll_Row)
dw_Status_Track.SetRow(ll_Row)
dw_Status_Track.SetColumn('status')
dw_Status_Track.SetFocus()

end subroutine

public function long wf_savetrack ();long			ll_Rtn,ll_Row,ll_RowCnt,ll_CurrStatus,ll_LastStatus,ll_ProcessDays
DateTime		ldt_StartDate

if dw_Status_Track.AcceptText() <> 1 then Return -1

ll_RowCnt = dw_Status_Track.RowCount()

If ll_RowCnt = 0 Then Return 0

for ll_Row = 1 to ll_RowCnt
	ll_CurrStatus = dw_Status_Track.GetItemNumber(ll_Row,'status')
	if IsNull(ll_CurrStatus) then
		MessageBox(gnv_app.iapp_object.DisplayName,"Status column can not be null.")
		dw_Status_Track.SetRow(ll_Row)
		dw_Status_Track.SetColumn('status')
		dw_Status_Track.SetFocus()
		Return -1
	end if
	
	ldt_StartDate = dw_Status_Track.GetItemDateTime(ll_Row,'start_time')
	if IsNull(ldt_StartDate) then
		MessageBox(gnv_app.iapp_object.DisplayName,"Start Time column can not be null.")
		dw_Status_Track.SetRow(ll_Row)
		dw_Status_Track.SetColumn('start_time')
		dw_Status_Track.SetFocus()
		Return -1
	end if
next

dw_Status_Track.SetSort("start_time A")
dw_Status_Track.Sort()

ll_RowCnt = dw_Status_Track.RowCount()
for ll_Row = 1 to ll_RowCnt
	dw_Status_Track.SetItem(ll_Row,"seq_no",ll_Row)
next


ll_Rtn = This.Event pfc_save()

if ll_Rtn = 1 and IsValid(w_contract) then
	ll_Row = w_contract.tab_contract_details.tabpage_details.uo_1.dw_1.GetRow()
	ll_CurrStatus = w_contract.tab_contract_details.tabpage_details.uo_1.dw_1.GetItemNumber(ll_Row,istr_ctx.as_fieldname )
	ll_LastStatus = dw_Status_Track.GetItemNumber(dw_Status_Track.RowCount(),'status')
	
	if ll_CurrStatus <> ll_LastStatus then
		w_contract.tab_contract_details.tabpage_details.uo_1.dw_1.SetItem(ll_Row,istr_ctx.as_fieldname,ll_LastStatus)
		w_contract.tab_contract_details.tabpage_details.uo_1.dw_1.of_Enable_Save( )
	end if
	
	if istr_ctx.as_fieldname = 'status' then //04.19.2011
		SELECT TOP 1 IsNull((SELECT IsNull(SUM(DATEDIFF(DAY,B.start_time,A.start_time)),0) + IsNull((SELECT DATEDIFF(DAY,C.start_time, getdate()) FROM sys_StatusAudit C WHERE C.ctx_id = :il_CtxID AND C.seq_no = (SELECT Max(D.seq_no) from sys_StatusAudit D where D.ctx_id = :il_CtxID) AND C.status In (SELECT lookup_code FROM code_lookup WHERE code_lookup.lookup_name = 'Contract Status' AND code_lookup.custom_2 = 'On')),0) FROM sys_StatusAudit A,sys_StatusAudit B  WHERE A.ctx_id = B.ctx_id AND A.ctx_id = :il_CtxID AND A.seq_no = B.seq_no + 1 AND B.status In (SELECT lookup_code FROM code_lookup WHERE code_lookup.lookup_name = 'Contract Status' AND code_lookup.custom_2 = 'On')),0) INTO :ll_ProcessDays FROM ids;
		w_contract.tab_contract_details.tabpage_details.uo_1.dw_1.SetItem(ll_Row,'total_processing_time',ll_ProcessDays)
		w_contract.tab_contract_details.tabpage_details.uo_1.dw_1.SetItemStatus(ll_Row,'total_processing_time',Primary!,NotModified!)
	end if
end if

Return ll_Rtn

end function

public function integer wf_set_readonly ();String ls_dwBKColor,ls_Modify
dw_Status_Track.Enabled = false
cb_Add.Enabled = false
cb_Insert.Enabled = false
cb_Del.Enabled = false
cb_Save.Enabled = false

ls_dwBKColor = dw_Status_Track.Describe("DataWindow.Color")
ls_Modify = "status.Background.Color=" + ls_dwBKColor + " start_time.Background.Color=" + ls_dwBKColor
dw_Status_Track.Modify(ls_Modify)
return 1
end function

on w_contract_status_track.create
int iCurrent
call super::create
this.cb_print=create cb_print
this.cb_add=create cb_add
this.cb_insert=create cb_insert
this.cb_del=create cb_del
this.cb_save=create cb_save
this.cb_close=create cb_close
this.dw_status_track=create dw_status_track
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_print
this.Control[iCurrent+2]=this.cb_add
this.Control[iCurrent+3]=this.cb_insert
this.Control[iCurrent+4]=this.cb_del
this.Control[iCurrent+5]=this.cb_save
this.Control[iCurrent+6]=this.cb_close
this.Control[iCurrent+7]=this.dw_status_track
end on

on w_contract_status_track.destroy
call super::destroy
destroy(this.cb_print)
destroy(this.cb_add)
destroy(this.cb_insert)
destroy(this.cb_del)
destroy(this.cb_save)
destroy(this.cb_close)
destroy(this.dw_status_track)
end on

event open;call super::open;String	ls_dwBKColor,ls_Modify
long		ll_TabRight,ll_TrackRight

string 	ls_lookup_name
datawindowchild ldwc

//Modified By Ken.Guo 2010-02-25
//il_CtxID = Message.DoubleParm
istr_ctx = Message.powerobjectparm
il_CtxID = istr_ctx.al_ctx_id
is_fieldname = istr_ctx.as_fieldname
ls_lookup_name = istr_ctx.as_fieldtag

//jervis -- 04.26.2011
if istr_ctx.as_fieldlabel = '' or istr_ctx.as_fieldlabel = '!' or istr_ctx.as_fieldlabel = '?'  then istr_ctx.as_fieldlabel = 'Status'
this.title = 'Contract ' + istr_ctx.as_fieldlabel + " Track"

//PB Bug, Fisrt to Modify background.color before dddw retrieve - jervis 05.10.2011
ll_TabRight = w_mdi.of_security_access(2090)
ll_TrackRight = w_mdi.of_security_access(2094)
if ll_TabRight = 1 or ll_TrackRight = 1 or istr_ctx.ab_readonly then
	wf_set_readonly()
end if


//Added By Ken.Guo 2010-06-11.
If il_CtxID = 0 or isnull(il_CtxID) Then istr_ctx.ab_readonly = True

//Retrieve dddw - jervis 04.19.2011
if dw_status_track.getchild('status', ldwc)  = 1 then
	ldwc.SetTransObject( sqlca)
	if ldwc.Retrieve( ls_lookup_name) < 1 then ldwc.Insertrow( 0)
end if

//Retrieve dddw - jervis 04.26.2011
if dw_status_track.getchild('status_1', ldwc)  = 1 then
	ldwc.SetTransObject( sqlca)
	if ldwc.Retrieve( ls_lookup_name) < 1 then ldwc.Insertrow( 0)
end if

dw_Status_Track.of_SetDropDownCalendar(true)
dw_Status_Track.SetTransObject(SQLCA)
dw_Status_Track.Retrieve(il_CtxID,is_fieldname)

//Set Depent for status field - jervis 04.13.2011
if is_fieldname = 'status' then
	dw_status_track.of_fielddependfilter(istr_ctx.al_view_id , istr_ctx.al_screen_id , 'status',1,true,'')
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
			If wf_SaveTrack() >= 1 Then
				// Successful update, allow the window to be closed
				ib_closestatus = False
				Return ALLOW_CLOSE
			End If
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

type cb_print from commandbutton within w_contract_status_track
integer x = 1486
integer y = 1520
integer width = 288
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Preview"
end type

event clicked;OpenWithParm(w_contract_status_preview,istr_ctx)
end event

type cb_add from commandbutton within w_contract_status_track
integer x = 169
integer y = 1520
integer width = 288
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
end type

event clicked;wf_InsertTrack(0)

end event

type cb_insert from commandbutton within w_contract_status_track
integer x = 498
integer y = 1520
integer width = 288
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Insert"
end type

event clicked;long	ll_Row

ll_Row = dw_Status_Track.GetRow()
wf_InsertTrack(ll_Row)

end event

type cb_del from commandbutton within w_contract_status_track
integer x = 827
integer y = 1520
integer width = 288
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;long	ll_Cycle,ll_RowCnt,ll_Row,ll_Rtn

dwItemStatus	ldwStatus

ll_Row = dw_Status_Track.GetRow()

//Begin - Added By Ken.Guo 2010-06-11.
If dw_Status_Track.RowCount() = 1 Then
	Messagebox('Delete','The last line of data does not allow to be deleted.')
	Return
End If
//End - Added By Ken.Guo 2010-06-11.

if ll_Row <= 0 or ll_Row > dw_Status_Track.RowCount() then Return

ldwStatus = dw_Status_Track.GetItemStatus(ll_Row,0,Primary!)
if ldwStatus <> New! then
	ll_Rtn = MessageBox(gnv_app.iapp_object.DisplayName,"Are you sure you want to delete this row ?",Question!,YesNo!,2)
	if ll_Rtn <> 1 then
		dw_Status_Track.SetFocus()
		Return
	end if
end if

dw_Status_Track.DeleteRow(ll_Row)

ll_RowCnt = dw_Status_Track.RowCount()
for ll_Cycle = ll_Row to ll_RowCnt
	dw_Status_Track.SetItem(ll_Cycle,'seq_no',ll_Cycle)
next

dw_Status_Track.ScrollToRow(ll_Row)
dw_Status_Track.SetRow(ll_Row)
dw_Status_Track.SetFocus()

end event

type cb_save from commandbutton within w_contract_status_track
integer x = 1157
integer y = 1520
integer width = 288
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;wf_SaveTrack()
end event

type cb_close from commandbutton within w_contract_status_track
integer x = 1815
integer y = 1520
integer width = 288
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;CloseWithReturn(Parent,"")
end event

type dw_status_track from u_dw within w_contract_status_track
integer x = 23
integer y = 20
integer width = 2226
integer height = 1456
integer taborder = 10
string dataobject = "d_contract_status_track"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

