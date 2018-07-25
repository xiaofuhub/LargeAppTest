$PBExportHeader$w_actionitemfilter.srw
forward
global type w_actionitemfilter from window
end type
type cbx_priority from checkbox within w_actionitemfilter
end type
type cbx_assignedto from checkbox within w_actionitemfilter
end type
type cbx_assignedby from checkbox within w_actionitemfilter
end type
type cbx_actionstatus from checkbox within w_actionitemfilter
end type
type cbx_actiontype from checkbox within w_actionitemfilter
end type
type cb_cancel from commandbutton within w_actionitemfilter
end type
type cb_ok from commandbutton within w_actionitemfilter
end type
type cbx_inccompstep from checkbox within w_actionitemfilter
end type
type cbx_low from checkbox within w_actionitemfilter
end type
type cbx_medium from checkbox within w_actionitemfilter
end type
type cbx_high from checkbox within w_actionitemfilter
end type
type dw_assignedto from datawindow within w_actionitemfilter
end type
type dw_assignedby from datawindow within w_actionitemfilter
end type
type dw_action_item_status from datawindow within w_actionitemfilter
end type
type dw_action_item_type from datawindow within w_actionitemfilter
end type
type gb_1 from groupbox within w_actionitemfilter
end type
type gb_2 from groupbox within w_actionitemfilter
end type
type gb_3 from groupbox within w_actionitemfilter
end type
type gb_4 from groupbox within w_actionitemfilter
end type
type gb_5 from groupbox within w_actionitemfilter
end type
type ln_white from line within w_actionitemfilter
end type
type ln_gray from line within w_actionitemfilter
end type
type dw_action_item_filter from datawindow within w_actionitemfilter
end type
end forward

global type w_actionitemfilter from window
integer width = 3808
integer height = 1248
boolean titlebar = true
string title = "Action Item Filter Options"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
event ue_viewfilter ( long al_number )
event ue_assignfilter ( long al_number )
event ue_renamefilter ( long al_number )
cbx_priority cbx_priority
cbx_assignedto cbx_assignedto
cbx_assignedby cbx_assignedby
cbx_actionstatus cbx_actionstatus
cbx_actiontype cbx_actiontype
cb_cancel cb_cancel
cb_ok cb_ok
cbx_inccompstep cbx_inccompstep
cbx_low cbx_low
cbx_medium cbx_medium
cbx_high cbx_high
dw_assignedto dw_assignedto
dw_assignedby dw_assignedby
dw_action_item_status dw_action_item_status
dw_action_item_type dw_action_item_type
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
gb_4 gb_4
gb_5 gb_5
ln_white ln_white
ln_gray ln_gray
dw_action_item_filter dw_action_item_filter
end type
global w_actionitemfilter w_actionitemfilter

type variables
CONSTANT STRING ACTIONTYPEVALFLAG = "action_type_val in"
CONSTANT STRING ACTIONSTATUSFLAG  = "action_status in"
CONSTANT STRING ASSIGNEDBYFLAG    = "wf_assigned_by in"
CONSTANT STRING ASSIGNEDTOFLAG    = "action_user in"
CONSTANT STRING PRIORITYFLAG      = "priority in"
CONSTANT STRING WFCOMPLETEFLAG    = "wf_complete_flag"

n_cst_string	inv_String

u_condition_setting		iu_ConditionSetting

m_action_item_filter		im_Filter

String	is_FilterName1,is_FilterName2,is_FilterName3

end variables

forward prototypes
public subroutine of_selectall (datawindow adw_1, boolean ab_checked)
public function string of_getactionfilter_exp ()
public function string of_getactionitemtype ()
public function string of_getactionitemstatus ()
public function string of_getactionassignedby ()
public function string of_getactionassignedto ()
public function string of_getactionpriority ()
public function string of_getworkflowcompstep ()
public subroutine of_parsestrtoitem (string as_actionfilter_exp)
end prototypes

event ue_viewfilter(long al_number);of_ParseStrToItem(iu_ConditionSetting.is_QuickFilter[al_Number])

end event

event ue_assignfilter(long al_number);long		ll_RtnVal
String	ls_Filter,ls_CurFilter

Choose Case al_Number
	Case 1
		ls_CurFilter = is_FilterName1
	Case 2
		ls_CurFilter = is_FilterName2
	Case 3
		ls_CurFilter = is_FilterName3
	Case else
		Return
End Choose

ll_RtnVal = MessageBox(gnv_app.iapp_object.DisplayName,"Are you sure you want to assign the current filter to Quick Filter Icon " + ls_CurFilter + "?",Question!,YesNo!,1)

ls_Filter = of_GetActionFilter_Exp()

Choose Case al_Number
	Case 1
		UPDATE icred_settings SET CalActItemFilter_1 = :ls_Filter;
	Case 2
		UPDATE icred_settings SET CalActItemFilter_2 = :ls_Filter;
	Case 3
		UPDATE icred_settings SET CalActItemFilter_3 = :ls_Filter;
End Choose

iu_ConditionSetting.is_QuickFilter[al_Number] = ls_Filter

end event

event ue_renamefilter(long al_number);//====================================================================
// Event: ue_RenameFilter()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    long    al_number
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2010-03-16
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String	ls_OldName,ls_NewName,ls_TransName

Choose Case al_number
	Case 1
		ls_OldName = is_FilterName1
	Case 2
		ls_OldName = is_FilterName2
	Case 3
		ls_OldName = is_FilterName3
	Case else
		Return
End Choose

OpenWithParm(w_Rename,ls_OldName)

ls_NewName = Message.StringParm

ls_TransName = inv_String.of_GlobalReplace(ls_NewName,"~~","~~~~")
ls_TransName = inv_String.of_GlobalReplace(ls_NewName,"~'","~~'")

if ls_NewName <> "" then
	Choose Case al_number
		Case 1
			is_FilterName1 = ls_NewName
			dw_Action_Item_Filter.Modify("t_actionitemfilter_1.Text = '" + ls_TransName + "'")
			UPDATE icred_settings SET CalFilterName_1 = :ls_NewName;
		Case 2
			is_FilterName2 = ls_NewName
			dw_Action_Item_Filter.Modify("t_actionitemfilter_2.Text = '" + ls_TransName + "'")
			UPDATE icred_settings SET CalFilterName_2 = :ls_NewName;
		Case 3
			is_FilterName3 = ls_NewName
			dw_Action_Item_Filter.Modify("t_actionitemfilter_3.Text = '" + ls_TransName + "'")
			UPDATE icred_settings SET CalFilterName_3 = :ls_NewName;
		Case else
			Return
	End Choose
	
	gnv_data.of_Retrieve("icred_settings")
	
	iu_ConditionSetting.GetParent().Dynamic of_RefreshFilterName()
end if

end event

public subroutine of_selectall (datawindow adw_1, boolean ab_checked);long	ll_Cycle,ll_RowCnts,ll_Select,ll_Array[]

ll_RowCnts = adw_1.RowCount()

if ab_Checked then ll_Select = 1 else ll_Select = 0

for ll_Cycle = 1 to ll_RowCnts
	ll_Array[ll_Cycle] = ll_Select
next

adw_1.Object.Selected.Primary = ll_Array

end subroutine

public function string of_getactionfilter_exp ();String	ls_Type,ls_Status,ls_AssignedBy,ls_AssignedTo,ls_Priority,ls_WfCompStep,ls_ActionFilter_Exp

ls_Type       = Trim(of_GetActionItemType())
ls_Status     = Trim(of_GetActionItemStatus())
ls_AssignedBy = Trim(of_GetActionAssignedBy())
ls_AssignedTo = Trim(of_GetActionAssignedTo())
ls_Priority   = Trim(of_GetActionPriority())
ls_WfCompStep = Trim(of_GetWorkFlowCompStep())

ls_ActionFilter_Exp = ls_Type

if ls_Status <> "" then
	if ls_ActionFilter_Exp <> "" then ls_ActionFilter_Exp += " and "
	
	ls_ActionFilter_Exp += ls_Status
end if

if ls_AssignedBy <> "" then
	if ls_ActionFilter_Exp <> "" then ls_ActionFilter_Exp += " and "
	
	ls_ActionFilter_Exp += ls_AssignedBy
end if

if ls_AssignedTo <> "" then
	if ls_ActionFilter_Exp <> "" then ls_ActionFilter_Exp += " and "
	
	ls_ActionFilter_Exp += ls_AssignedTo
end if

if ls_Priority <> "" then
	if ls_ActionFilter_Exp <> "" then ls_ActionFilter_Exp += " and "
	
	ls_ActionFilter_Exp += ls_Priority
end if

if ls_WfCompStep <> "" then
	if ls_ActionFilter_Exp <> "" then ls_ActionFilter_Exp += " and "
	
	ls_ActionFilter_Exp += ls_WfCompStep
end if

Return ls_ActionFilter_Exp

end function

public function string of_getactionitemtype ();long		ll_Cycle,ll_RowCnts,ll_SelCnts,ll_Select,ll_Lookup
String	ls_ActionType

ll_RowCnts = dw_Action_Item_Type.RowCount()

for ll_Cycle = 1 to ll_RowCnts
	ll_Select = dw_Action_Item_Type.GetItemNumber(ll_Cycle,"Selected")
	if ll_Select = 1 then
		ll_SelCnts++
		ll_Lookup = dw_Action_Item_Type.GetItemNumber(ll_Cycle,"lookup_code")
		ls_ActionType += String(ll_Lookup) + ","
	end if
next

if ll_SelCnts = 0 then
	ls_ActionType = ACTIONTYPEVALFLAG + " (-1)"
elseif ll_SelCnts <> ll_RowCnts then
	ls_ActionType = Left(ls_ActionType,Len(ls_ActionType) - 1)
	ls_ActionType = ACTIONTYPEVALFLAG + " (" + ls_ActionType + ")"
else
	ls_ActionType = ""
end if

Return ls_ActionType

end function

public function string of_getactionitemstatus ();long		ll_Cycle,ll_RowCnts,ll_SelCnts,ll_Select,ll_Lookup
String	ls_ActionStatus

ll_RowCnts = dw_Action_Item_Status.RowCount()

for ll_Cycle = 1 to ll_RowCnts
	ll_Select = dw_Action_Item_Status.GetItemNumber(ll_Cycle,"Selected")
	if ll_Select = 1 then
		ll_SelCnts++
		ll_Lookup = dw_Action_Item_Status.GetItemNumber(ll_Cycle,"lookup_code")
		ls_ActionStatus += String(ll_Lookup) + ","
	end if
next

if ll_SelCnts = 0 then
	ls_ActionStatus = ACTIONSTATUSFLAG + " (-1)"
elseif ll_SelCnts <> ll_RowCnts then
	ls_ActionStatus = Left(ls_ActionStatus,Len(ls_ActionStatus) - 1)
	ls_ActionStatus = ACTIONSTATUSFLAG + " (" + ls_ActionStatus + ")"
else
	ls_ActionStatus = ""
end if

Return ls_ActionStatus

end function

public function string of_getactionassignedby ();long		ll_Cycle,ll_RowCnts,ll_SelCnts,ll_Select
String	ls_AssignedBy,ls_UserID

ll_RowCnts = dw_AssignedBy.RowCount()

for ll_Cycle = 1 to ll_RowCnts
	ll_Select = dw_AssignedBy.GetItemNumber(ll_Cycle,"Selected")
	if ll_Select = 1 then
		ll_SelCnts++
		ls_UserID = dw_AssignedBy.GetItemString(ll_Cycle,"user_id")
		ls_AssignedBy += "'" + String(ls_UserID) + "',"
	end if
next

if ll_SelCnts = 0 then
	ls_AssignedBy = ASSIGNEDBYFLAG + " ('')"
elseif ll_SelCnts <> ll_RowCnts then
	ls_AssignedBy = Left(ls_AssignedBy,Len(ls_AssignedBy) - 1)
	ls_AssignedBy = ASSIGNEDBYFLAG + " (" + ls_AssignedBy + ")"
else
	ls_AssignedBy = ""
end if

Return ls_AssignedBy

end function

public function string of_getactionassignedto ();long		ll_Cycle,ll_RowCnts,ll_SelCnts,ll_Select
String	ls_AssignedTo,ls_UserID

ll_RowCnts = dw_AssignedTo.RowCount()

for ll_Cycle = 1 to ll_RowCnts
	ll_Select = dw_AssignedTo.GetItemNumber(ll_Cycle,"Selected")
	if ll_Select = 1 then
		ll_SelCnts++
		ls_UserID = dw_AssignedTo.GetItemString(ll_Cycle,"user_id")
		ls_AssignedTo += "'" + String(ls_UserID) + "',"
	end if
next

if ll_SelCnts = 0 then
	ls_AssignedTo = ASSIGNEDTOFLAG + " ('')"
elseif ll_SelCnts <> ll_RowCnts then
	ls_AssignedTo = Left(ls_AssignedTo,Len(ls_AssignedTo) - 1)
	ls_AssignedTo = ASSIGNEDTOFLAG + " (" + ls_AssignedTo + ")"
else
	ls_AssignedTo = ""
end if

Return ls_AssignedTo

end function

public function string of_getactionpriority ();String	ls_Priority

if cbx_High.Checked and cbx_Medium.Checked and cbx_Low.Checked then Return ""

if cbx_High.Checked   then ls_Priority += "1,"
if cbx_Medium.Checked then ls_Priority += "2,"
if cbx_Low.Checked    then ls_Priority += "3,"

if Not cbx_High.Checked and Not cbx_Medium.Checked and Not cbx_Low.Checked then
	ls_Priority = PRIORITYFLAG + " (4)"
else
	ls_Priority = Left(ls_Priority,Len(ls_Priority) - 1)
	ls_Priority = PRIORITYFLAG + " (" + ls_Priority + ")"
end if

Return ls_Priority

end function

public function string of_getworkflowcompstep ();String	ls_WFCompStep

if Not cbx_IncCompStep.Checked then
	ls_WFCompStep = WFCOMPLETEFLAG + " <> 'Y'"
end if

Return ls_WFCompStep

end function

public subroutine of_parsestrtoitem (string as_actionfilter_exp);//====================================================================
// Function: of_ParseStrToItem()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    string    as_ActionFilter_Exp
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2010-01-09
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_RowCnts,ll_Found,ll_Pos,ll_LBracketPos,ll_RBracketPos,ll_CommaPos
long		ll_ActionType,ll_ActionStatus
String	ls_ActionType,ls_ActionStatus,ls_AssignedBy,ls_AssignedTo,ls_User_Id,ls_Priority

//Parse Action Type
ll_RowCnts = dw_action_item_type.RowCount()

ll_Pos = Pos(as_ActionFilter_Exp,ACTIONTYPEVALFLAG)
if ll_Pos > 0 then
	of_SelectAll(dw_Action_Item_Type,false)
	
	ll_LBracketPos = Pos(as_ActionFilter_Exp,"(",ll_Pos)
	ll_RBracketPos = Pos(as_ActionFilter_Exp,")",ll_Pos)
	ls_ActionType  = Mid(as_ActionFilter_Exp,ll_LBracketPos + 1,ll_RBracketPos - ll_LBracketPos - 1) + ","
	
	ll_CommaPos = Pos(ls_ActionType,",")
	do while ll_CommaPos > 0
		ll_ActionType = long(Left(ls_ActionType,ll_CommaPos - 1))
		ls_ActionType = Mid(ls_ActionType,ll_CommaPos + 1)
		ll_CommaPos   = Pos(ls_ActionType,",")
		
		ll_Found = dw_action_item_type.Find("lookup_code = " + String(ll_ActionType),1,ll_RowCnts)
		if ll_Found > 0 then dw_action_item_type.SetItem(ll_Found,"Selected",1)
	loop
else
	cbx_ActionType.Checked = true
	of_SelectAll(dw_Action_Item_Type,true)
end if

//Parse Action Status
ll_RowCnts = dw_action_item_status.RowCount()

ll_Pos = Pos(as_ActionFilter_Exp,ACTIONSTATUSFLAG)
if ll_Pos > 0 then
	of_SelectAll(dw_action_item_status,false)
	
	ll_LBracketPos = Pos(as_ActionFilter_Exp,"(",ll_Pos)
	ll_RBracketPos = Pos(as_ActionFilter_Exp,")",ll_Pos)
	ls_ActionStatus  = Mid(as_ActionFilter_Exp,ll_LBracketPos + 1,ll_RBracketPos - ll_LBracketPos - 1) + ","
	
	ll_CommaPos = Pos(ls_ActionStatus,",")
	do while ll_CommaPos > 0
		ll_ActionStatus = long(Left(ls_ActionStatus,ll_CommaPos - 1))
		ls_ActionStatus = Mid(ls_ActionStatus,ll_CommaPos + 1)
		ll_CommaPos   = Pos(ls_ActionStatus,",")
		
		ll_Found = dw_action_item_status.Find("lookup_code = " + String(ll_ActionStatus),1,ll_RowCnts)
		if ll_Found > 0 then dw_action_item_status.SetItem(ll_Found,"Selected",1)
	loop
else
	cbx_ActionStatus.Checked = true
	of_SelectAll(dw_action_item_status,true)
end if

//Parse Assigned By
ll_RowCnts = dw_AssignedBy.RowCount()

ll_Pos = Pos(as_ActionFilter_Exp,ASSIGNEDBYFLAG)
if ll_Pos > 0 then
	of_SelectAll(dw_AssignedBy,false)
	
	ll_LBracketPos = Pos(as_ActionFilter_Exp,"(",ll_Pos)
	ll_RBracketPos = Pos(as_ActionFilter_Exp,")",ll_Pos)
	ls_AssignedBy  = Mid(as_ActionFilter_Exp,ll_LBracketPos + 1,ll_RBracketPos - ll_LBracketPos - 1) + ","
	
	ll_CommaPos = Pos(ls_AssignedBy,",")
	do while ll_CommaPos > 0
		ls_User_Id    = Left(ls_AssignedBy,ll_CommaPos - 1)
		ls_AssignedBy = Mid(ls_AssignedBy,ll_CommaPos + 1)
		ll_CommaPos   = Pos(ls_AssignedBy,",")
		
		ll_Found = dw_AssignedBy.Find("user_id = " + ls_User_Id,1,ll_RowCnts)
		if ll_Found > 0 then dw_AssignedBy.SetItem(ll_Found,"Selected",1)
	loop
else
	cbx_AssignedBy.Checked = true
	of_SelectAll(dw_AssignedBy,true)
end if

//Parse Assigned To
ll_RowCnts = dw_AssignedTo.RowCount()

ll_Pos = Pos(as_ActionFilter_Exp,ASSIGNEDTOFLAG)
if ll_Pos > 0 then
	of_SelectAll(dw_AssignedTo,false)
	
	ll_LBracketPos = Pos(as_ActionFilter_Exp,"(",ll_Pos)
	ll_RBracketPos = Pos(as_ActionFilter_Exp,")",ll_Pos)
	ls_AssignedTo  = Mid(as_ActionFilter_Exp,ll_LBracketPos + 1,ll_RBracketPos - ll_LBracketPos - 1) + ","
	
	ll_CommaPos = Pos(ls_AssignedTo,",")
	do while ll_CommaPos > 0
		ls_User_Id    = Left(ls_AssignedTo,ll_CommaPos - 1)
		ls_AssignedTo = Mid(ls_AssignedTo,ll_CommaPos + 1)
		ll_CommaPos   = Pos(ls_AssignedTo,",")
		
		ll_Found = dw_AssignedTo.Find("user_id = " + ls_User_Id,1,ll_RowCnts)
		if ll_Found > 0 then dw_AssignedTo.SetItem(ll_Found,"Selected",1)
	loop
else
	cbx_AssignedTo.Checked = true
	of_SelectAll(dw_AssignedTo,true)
end if

//Parse Priority
ll_Pos = Pos(as_ActionFilter_Exp,PRIORITYFLAG)
if ll_Pos > 0 then
	ll_LBracketPos = Pos(as_ActionFilter_Exp,"(",ll_Pos)
	ll_RBracketPos = Pos(as_ActionFilter_Exp,")",ll_Pos)
	ls_Priority    = Mid(as_ActionFilter_Exp,ll_LBracketPos + 1,ll_RBracketPos - ll_LBracketPos - 1)
	
	if Pos(ls_Priority,"1") > 0 then cbx_High.Checked = true   else cbx_High.Checked = false
	if Pos(ls_Priority,"2") > 0 then cbx_Medium.Checked = true else cbx_Medium.Checked = false
	if Pos(ls_Priority,"3") > 0 then cbx_Low.Checked = true    else cbx_Low.Checked = false
else
	cbx_Priority.Checked = true
	cbx_High.Checked     = true
	cbx_Medium.Checked   = true
	cbx_Low.Checked      = true
end if

//Parse Include completed workflow steps
ll_Pos = Pos(as_ActionFilter_Exp,WFCOMPLETEFLAG)
if ll_Pos > 0 then
	cbx_IncCompStep.Checked = false
else
	cbx_IncCompStep.Checked = true
end if

end subroutine

on w_actionitemfilter.create
this.cbx_priority=create cbx_priority
this.cbx_assignedto=create cbx_assignedto
this.cbx_assignedby=create cbx_assignedby
this.cbx_actionstatus=create cbx_actionstatus
this.cbx_actiontype=create cbx_actiontype
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.cbx_inccompstep=create cbx_inccompstep
this.cbx_low=create cbx_low
this.cbx_medium=create cbx_medium
this.cbx_high=create cbx_high
this.dw_assignedto=create dw_assignedto
this.dw_assignedby=create dw_assignedby
this.dw_action_item_status=create dw_action_item_status
this.dw_action_item_type=create dw_action_item_type
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_4=create gb_4
this.gb_5=create gb_5
this.ln_white=create ln_white
this.ln_gray=create ln_gray
this.dw_action_item_filter=create dw_action_item_filter
this.Control[]={this.cbx_priority,&
this.cbx_assignedto,&
this.cbx_assignedby,&
this.cbx_actionstatus,&
this.cbx_actiontype,&
this.cb_cancel,&
this.cb_ok,&
this.cbx_inccompstep,&
this.cbx_low,&
this.cbx_medium,&
this.cbx_high,&
this.dw_assignedto,&
this.dw_assignedby,&
this.dw_action_item_status,&
this.dw_action_item_type,&
this.gb_1,&
this.gb_2,&
this.gb_3,&
this.gb_4,&
this.gb_5,&
this.ln_white,&
this.ln_gray,&
this.dw_action_item_filter}
end on

on w_actionitemfilter.destroy
destroy(this.cbx_priority)
destroy(this.cbx_assignedto)
destroy(this.cbx_assignedby)
destroy(this.cbx_actionstatus)
destroy(this.cbx_actiontype)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.cbx_inccompstep)
destroy(this.cbx_low)
destroy(this.cbx_medium)
destroy(this.cbx_high)
destroy(this.dw_assignedto)
destroy(this.dw_assignedby)
destroy(this.dw_action_item_status)
destroy(this.dw_action_item_type)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_4)
destroy(this.gb_5)
destroy(this.ln_white)
destroy(this.ln_gray)
destroy(this.dw_action_item_filter)
end on

event open;String	ls_ActionFilter_Exp

iu_ConditionSetting = Message.PowerObjectParm

dw_Action_Item_Type.SetTransObject(SQLCA)
dw_Action_Item_Type.Retrieve()

dw_Action_Item_Status.SetTransObject(SQLCA)
dw_Action_Item_Status.Retrieve()

dw_AssignedBy.SetTransObject(SQLCA)
dw_AssignedBy.Retrieve()

dw_AssignedTo.SetTransObject(SQLCA)
dw_AssignedTo.Retrieve()

ls_ActionFilter_Exp = iu_ConditionSetting.is_ActionFilter_Exp
of_ParseStrToItem(ls_ActionFilter_Exp)

im_Filter = Create m_action_item_filter
im_Filter.iw_Parent = This

if AppeonGetClientType() = "WEB" then This.Resize(3799 + 26,1168 + 106)

end event

event close;Destroy im_Filter

end event

type cbx_priority from checkbox within w_actionitemfilter
integer x = 3086
integer y = 880
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Select All"
end type

event clicked;cbx_High.Checked   = This.Checked
cbx_Medium.Checked = This.Checked
cbx_Low.Checked    = This.Checked

end event

type cbx_assignedto from checkbox within w_actionitemfilter
integer x = 2331
integer y = 880
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Select All"
end type

event clicked;of_SelectAll(dw_AssignedTo,This.Checked)

end event

type cbx_assignedby from checkbox within w_actionitemfilter
integer x = 1577
integer y = 880
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Select All"
end type

event clicked;of_SelectAll(dw_AssignedBy,This.Checked)

end event

type cbx_actionstatus from checkbox within w_actionitemfilter
integer x = 823
integer y = 880
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Select All"
end type

event clicked;of_SelectAll(dw_Action_Item_Status,This.Checked)

end event

type cbx_actiontype from checkbox within w_actionitemfilter
integer x = 69
integer y = 880
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Select All"
end type

event clicked;of_SelectAll(dw_Action_Item_Type,This.Checked)

end event

type cb_cancel from commandbutton within w_actionitemfilter
integer x = 3419
integer y = 1036
integer width = 343
integer height = 92
integer taborder = 50
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

type cb_ok from commandbutton within w_actionitemfilter
integer x = 3045
integer y = 1036
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;String	ls_ActionFilter_Exp

ls_ActionFilter_Exp = of_GetActionFilter_Exp()

CloseWithReturn(Parent,ls_ActionFilter_Exp)

end event

type cbx_inccompstep from checkbox within w_actionitemfilter
integer x = 69
integer y = 1048
integer width = 896
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Include completed workflow steps"
end type

event constructor;//---------Begin Modified by (Appeon)Harry 06.25.2013 for V141 ISG-CLX--------
//This.Visible = m_pfe_cst_master_menu.m_system.m_painters.m_workflowpainter.Visible
This.Visible = m_pfe_cst_master_menu.m_system.m_painters.m_systemsetup.m_workflowpainter.Visible
//---------End Modfiied ------------------------------------------------------

end event

type cbx_low from checkbox within w_actionitemfilter
integer x = 3086
integer y = 216
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Low"
end type

type cbx_medium from checkbox within w_actionitemfilter
integer x = 3086
integer y = 148
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Medium"
end type

type cbx_high from checkbox within w_actionitemfilter
integer x = 3086
integer y = 76
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "High"
end type

type dw_assignedto from datawindow within w_actionitemfilter
integer x = 2304
integer y = 76
integer width = 672
integer height = 728
integer taborder = 40
string dataobject = "d_action_item_users"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event clicked;long	ll_Selected

if Row > 0 and Row <= This.RowCount() then
	This.SetRow(Row)
	if Lower(dwo.Name) <> Lower("Selected") then
		ll_Selected = This.GetItemNumber(Row,"Selected")
		This.SetItem(Row,"Selected",1 - ll_Selected)
	end if
end if

end event

type dw_assignedby from datawindow within w_actionitemfilter
integer x = 1550
integer y = 76
integer width = 672
integer height = 728
integer taborder = 30
string dataobject = "d_action_item_users"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event clicked;long	ll_Selected

if Row > 0 and Row <= This.RowCount() then
	This.SetRow(Row)
	if Lower(dwo.Name) <> Lower("Selected") then
		ll_Selected = This.GetItemNumber(Row,"Selected")
		This.SetItem(Row,"Selected",1 - ll_Selected)
	end if
end if

end event

type dw_action_item_status from datawindow within w_actionitemfilter
integer x = 795
integer y = 76
integer width = 672
integer height = 728
integer taborder = 20
string dataobject = "d_action_item_status"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event clicked;long	ll_Selected

if Row > 0 and Row <= This.RowCount() then
	This.SetRow(Row)
	if Lower(dwo.Name) <> Lower("Selected") then
		ll_Selected = This.GetItemNumber(Row,"Selected")
		This.SetItem(Row,"Selected",1 - ll_Selected)
	end if
end if

end event

type dw_action_item_type from datawindow within w_actionitemfilter
integer x = 41
integer y = 76
integer width = 672
integer height = 728
integer taborder = 10
string dataobject = "d_action_item_type"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event clicked;long	ll_Selected

if Row > 0 and Row <= This.RowCount() then
	This.SetRow(Row)
	if Lower(dwo.Name) <> Lower("Selected") then
		ll_Selected = This.GetItemNumber(Row,"Selected")
		This.SetItem(Row,"Selected",1 - ll_Selected)
	end if
end if

end event

type gb_1 from groupbox within w_actionitemfilter
integer x = 32
integer y = 8
integer width = 718
integer height = 828
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Action Item Type"
borderstyle borderstyle = stylebox!
end type

type gb_2 from groupbox within w_actionitemfilter
integer x = 786
integer y = 8
integer width = 718
integer height = 828
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Action Status"
borderstyle borderstyle = stylebox!
end type

type gb_3 from groupbox within w_actionitemfilter
integer x = 1541
integer y = 8
integer width = 718
integer height = 828
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Assigned By"
borderstyle borderstyle = stylebox!
end type

type gb_4 from groupbox within w_actionitemfilter
integer x = 2295
integer y = 8
integer width = 718
integer height = 828
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Assigned To"
borderstyle borderstyle = stylebox!
end type

type gb_5 from groupbox within w_actionitemfilter
integer x = 3049
integer y = 8
integer width = 718
integer height = 828
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Priority"
borderstyle borderstyle = stylebox!
end type

type ln_white from line within w_actionitemfilter
long linecolor = 16777215
integer linethickness = 4
integer beginx = 41
integer beginy = 980
integer endx = 3758
integer endy = 980
end type

type ln_gray from line within w_actionitemfilter
long linecolor = 8421504
integer linethickness = 4
integer beginx = 41
integer beginy = 976
integer endx = 3758
integer endy = 976
end type

type dw_action_item_filter from datawindow within w_actionitemfilter
integer x = 1051
integer y = 1028
integer width = 1765
integer height = 112
integer taborder = 50
string dataobject = "d_action_item_filter"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;String	ls_ObjName,ls_Serial

ls_ObjName = dwo.Name

if Pos(ls_ObjName,"actionitemfilter_") <= 0 then Return

ls_Serial = Right(ls_ObjName,1)

im_Filter.m_ViewFilter.Tag   = ls_Serial
im_Filter.m_AssignFilter.Tag = ls_Serial
im_Filter.m_RenameFilter.Tag = ls_Serial

im_Filter.PopMenu(Parent.PointerX(),Parent.PointerY())

end event

event constructor;String	ls_Syntax,ls_TransName1,ls_TransName2,ls_TransName3

is_FilterName1 = gnv_data.of_GetItem("icred_settings","CalFilterName_1",false)
is_FilterName2 = gnv_data.of_GetItem("icred_settings","CalFilterName_2",false)
is_FilterName3 = gnv_data.of_GetItem("icred_settings","CalFilterName_3",false)

ls_TransName1 = is_FilterName1
ls_TransName1 = inv_String.of_GlobalReplace(ls_TransName1,"~~","~~~~")
ls_TransName1 = inv_String.of_GlobalReplace(ls_TransName1,"~'","~~'")

ls_TransName2 = is_FilterName2
ls_TransName2 = inv_String.of_GlobalReplace(ls_TransName2,"~~","~~~~")
ls_TransName2 = inv_String.of_GlobalReplace(ls_TransName2,"~'","~~'")

ls_TransName3 = is_FilterName3
ls_TransName3 = inv_String.of_GlobalReplace(ls_TransName3,"~~","~~~~")
ls_TransName3 = inv_String.of_GlobalReplace(ls_TransName3,"~'","~~'")

ls_Syntax += "t_actionitemfilter_1.Text = '" + ls_TransName1 + "' "
ls_Syntax += "t_actionitemfilter_2.Text = '" + ls_TransName2 + "' "
ls_Syntax += "t_actionitemfilter_3.Text = '" + ls_TransName3 + "' "
			 
This.Modify(ls_Syntax)

end event

