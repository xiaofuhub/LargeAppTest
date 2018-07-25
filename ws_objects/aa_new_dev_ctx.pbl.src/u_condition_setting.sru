$PBExportHeader$u_condition_setting.sru
forward
global type u_condition_setting from u_base
end type
type dw_assignedto from datawindow within u_condition_setting
end type
type st_assignedto from statictext within u_condition_setting
end type
type cb_actionitemfilter from commandbutton within u_condition_setting
end type
type rb_alltype from radiobutton within u_condition_setting
end type
type rb_alarms from radiobutton within u_condition_setting
end type
type st_entrytype from statictext within u_condition_setting
end type
type rb_customcriteria from radiobutton within u_condition_setting
end type
type rb_currentrecord from radiobutton within u_condition_setting
end type
type rb_allrecords from radiobutton within u_condition_setting
end type
type st_records from statictext within u_condition_setting
end type
type gb_records from groupbox within u_condition_setting
end type
type gb_entrytype from groupbox within u_condition_setting
end type
type rb_actions from radiobutton within u_condition_setting
end type
end forward

global type u_condition_setting from u_base
integer width = 3351
integer height = 92
long backcolor = 16765357
long picturemaskcolor = 536870912
dw_assignedto dw_assignedto
st_assignedto st_assignedto
cb_actionitemfilter cb_actionitemfilter
rb_alltype rb_alltype
rb_alarms rb_alarms
st_entrytype st_entrytype
rb_customcriteria rb_customcriteria
rb_currentrecord rb_currentrecord
rb_allrecords rb_allrecords
st_records st_records
gb_records gb_records
gb_entrytype gb_entrytype
rb_actions rb_actions
end type
global u_condition_setting u_condition_setting

type variables
String	is_CTXFilter_Exp,is_ActionFilter_Exp
Boolean	ib_DispAlarm,ib_DispAction

RadioButton	irb_Record

CONSTANT STRING ACTIONTYPEVALFLAG = "action_type_val in"
CONSTANT STRING ACTIONSTATUSFLAG  = "action_status in"
CONSTANT STRING ASSIGNEDBYFLAG    = "wf_assigned_by in"
CONSTANT STRING ASSIGNEDTOFLAG    = "action_user in"
CONSTANT STRING PRIORITYFLAG      = "priority in"
CONSTANT STRING WFCOMPLETEFLAG    = "wf_complete_flag"

String	is_Mark[] = {ACTIONTYPEVALFLAG,ACTIONSTATUSFLAG,ASSIGNEDBYFLAG,ASSIGNEDTOFLAG,PRIORITYFLAG,WFCOMPLETEFLAG}
String	is_Condition[]

String	is_QuickFilter[3]

end variables

forward prototypes
public subroutine of_setbkcolor (long al_color)
public subroutine of_refreshcondition ()
public function long of_getcurrentctx ()
public function string of_getcustomctxset ()
public subroutine of_regresize ()
public subroutine of_filtertoarray ()
public subroutine of_arraytofilter ()
public subroutine of_gotoactionitemfilter ()
public subroutine of_setactionitemquickfilter (long al_number)
public subroutine of_setactionitemfiter (string as_actionfilter_exp)
public subroutine of_setassignedto ()
end prototypes

public subroutine of_setbkcolor (long al_color);This.BackColor = al_Color

st_assignedto.BackColor = al_Color //Added by Appeon long.zhang 02.23.2016 (BugL021806)

st_EntryType.BackColor = al_Color
rb_AllType.BackColor = al_Color
rb_Alarms.BackColor = al_Color
rb_Actions.BackColor = al_Color

st_records.BackColor = al_Color
rb_AllRecords.BackColor = al_Color
rb_CurrentRecord.BackColor = al_Color
rb_CustomCriteria.BackColor = al_Color

end subroutine

public subroutine of_refreshcondition ();long		ll_CurCTXID,ll_CurrRow
String	ls_User_id,ls_CTXSet

SetPointer(HourGlass!)

ll_CurrRow = dw_AssignedTo.GetRow()
ls_User_id = dw_AssignedTo.GetItemString(ll_CurrRow,"user_id")
if IsNull(ls_User_id) then ls_User_id = ""

if rb_AllType.Checked then
	ib_DispAlarm = true
	ib_DispAction = true
elseif rb_Alarms.Checked then
	ib_DispAlarm = true
	ib_DispAction = false
elseif rb_Actions.Checked then
	ib_DispAlarm = false
	ib_DispAction = true
end if

cb_ActionItemFilter.Enabled = rb_Actions.Checked

if rb_AllRecords.Checked then
	irb_Record = rb_AllRecords
	is_CTXFilter_Exp = ""	
elseif rb_CurrentRecord.Checked then
	irb_Record = rb_CurrentRecord
	ll_CurCTXID = of_GetCurrentCTX()
	is_CTXFilter_Exp = "ctx_id in (" + String(ll_CurCTXID) + ")"
elseif rb_CustomCriteria.Checked then
	irb_Record = rb_CustomCriteria
	ls_CTXSet = of_GetCustomCTXSet()
	is_CTXFilter_Exp = "ctx_id in (" + ls_CTXSet + ")"
end if

Parent.Dynamic of_RefreshCondition(ls_User_id,ib_DispAlarm,ib_DispAction,is_ActionFilter_Exp,is_CTXFilter_Exp)

SetPointer(Arrow!)

end subroutine

public function long of_getcurrentctx ();//====================================================================
// Function: of_GetCurrentCTX()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-11-25
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Contract Logix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long	ll_CurCTX,ll_CurRow

DataWindow	ldw_Browse

if IsValid(gw_Contract) then
//	if gw_Contract.tab_contract_details.SelectedTab = 1 then
		ldw_Browse = gw_Contract.tab_contract_details.tabpage_search.dw_search_det1
		
		ll_CurRow = ldw_Browse.GetSelectedRow(0)
		if ll_CurRow > 0 and ll_CurRow <= ldw_Browse.RowCount() then
			ll_CurCTX = ldw_Browse.GetItemNumber(ll_CurRow,"ctx_id")
		end if
//	end if
end if

Return ll_CurCTX

end function

public function string of_getcustomctxset ();//====================================================================
// Function: of_GetCustomCTXSet()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-11-25
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Contract Logix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_CTXID,ll_Cycle,ll_RowCnts
String	ls_CurSet

DataWindow	ldw_Browse

if IsValid(gw_Contract) then
	if gw_Contract.tab_contract_details.SelectedTab = 1 then
		ldw_Browse = gw_Contract.tab_contract_details.tabpage_search.dw_search_det1
		
		ll_RowCnts = ldw_Browse.RowCount()
		for ll_Cycle = 1 to ll_RowCnts
			ll_CTXID = ldw_Browse.GetItemNumber(ll_Cycle,"ctx_id")
			ls_CurSet += String(ll_CTXID) + ","
		next
	end if
end if

if Right(ls_CurSet,1) = "," then ls_CurSet = Left(ls_CurSet,Len(ls_CurSet) - 1)
if ls_CurSet = "" then ls_CurSet = "-1"

Return ls_CurSet

end function

public subroutine of_regresize ();//This.of_SetResize(true)

end subroutine

public subroutine of_filtertoarray ();long	ll_Cycle,ll_Cnts,ll_Pos,ll_LBracketPos,ll_RBracketPos

ll_Cnts = UpperBound(is_Mark)
for ll_Cycle = 1 to ll_Cnts
	ll_Pos = Pos(is_ActionFilter_Exp,is_Mark[ll_Cycle])
	if ll_Pos > 0 then
		ll_LBracketPos = Pos(is_ActionFilter_Exp,"(",ll_Pos)
		ll_RBracketPos = Pos(is_ActionFilter_Exp,")",ll_Pos)
		if ll_LBracketPos > 0 and ll_RBracketPos > 0 then
			is_Condition[ll_Cycle] = Mid(is_ActionFilter_Exp,ll_Pos,ll_RBracketPos - ll_Pos + 1)
		else
			if is_Mark[ll_Cycle] = WFCOMPLETEFLAG then
				is_Condition[ll_Cycle] = WFCOMPLETEFLAG + " <> 'Y'"
			else
				is_Condition[ll_Cycle] = ""
			end if
		end if
	else
		is_Condition[ll_Cycle] = ""
	end if
next

end subroutine

public subroutine of_arraytofilter ();long	ll_Cycle,ll_Cnts

is_ActionFilter_Exp = ""

ll_Cnts = UpperBound(is_Condition)
for ll_Cycle = 1 to ll_Cnts
	if Trim(is_Condition[ll_Cycle]) <> "" then
		if is_ActionFilter_Exp <> "" then is_ActionFilter_Exp += " and "
		is_ActionFilter_Exp += is_Condition[ll_Cycle]
	end if
next

end subroutine

public subroutine of_gotoactionitemfilter ();String	ls_ActionFilter_Exp

OpenWithParm(w_ActionItemFilter,This)

ls_ActionFilter_Exp = Message.StringParm

if ls_ActionFilter_Exp <> "Cancel" then
	of_SetActionItemFiter(ls_ActionFilter_Exp)
end if

end subroutine

public subroutine of_setactionitemquickfilter (long al_number);of_SetActionItemFiter(is_QuickFilter[al_Number])

end subroutine

public subroutine of_setactionitemfiter (string as_actionfilter_exp);//====================================================================
// Function: of_SetActionItemFiter()
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

is_ActionFilter_Exp = as_ActionFilter_Exp

UPDATE icred_settings SET CalActItemFilter_0 = :is_ActionFilter_Exp;

of_FilterToArray()

of_SetAssignedTo()

of_RefreshCondition()

end subroutine

public subroutine of_setassignedto ();long		ll_Row,ll_Pos,ll_LBracketPos,ll_RBracketPos
String	ls_ActionFilter_Exp,ls_AssignedTo

n_cst_string	lcst_StrProcess

ls_ActionFilter_Exp = is_ActionFilter_Exp

//Parse Assigned To
ll_Row = dw_AssignedTo.GetRow()
ll_Pos = Pos(ls_ActionFilter_Exp,ASSIGNEDTOFLAG)
if ll_Pos > 0 then
	ll_LBracketPos = Pos(ls_ActionFilter_Exp,"(",ll_Pos)
	ll_RBracketPos = Pos(ls_ActionFilter_Exp,")",ll_Pos)
	ls_AssignedTo  = Mid(ls_ActionFilter_Exp,ll_LBracketPos + 2,ll_RBracketPos - ll_LBracketPos - 3)
	
	ls_AssignedTo = lcst_StrProcess.of_GlobalReplace(ls_AssignedTo,"','",",")
	dw_AssignedTo.SetItem(ll_Row,"user_id",ls_AssignedTo)
else
	dw_AssignedTo.SetItem(ll_Row,"user_id","")
end if

end subroutine

on u_condition_setting.create
int iCurrent
call super::create
this.dw_assignedto=create dw_assignedto
this.st_assignedto=create st_assignedto
this.cb_actionitemfilter=create cb_actionitemfilter
this.rb_alltype=create rb_alltype
this.rb_alarms=create rb_alarms
this.st_entrytype=create st_entrytype
this.rb_customcriteria=create rb_customcriteria
this.rb_currentrecord=create rb_currentrecord
this.rb_allrecords=create rb_allrecords
this.st_records=create st_records
this.gb_records=create gb_records
this.gb_entrytype=create gb_entrytype
this.rb_actions=create rb_actions
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_assignedto
this.Control[iCurrent+2]=this.st_assignedto
this.Control[iCurrent+3]=this.cb_actionitemfilter
this.Control[iCurrent+4]=this.rb_alltype
this.Control[iCurrent+5]=this.rb_alarms
this.Control[iCurrent+6]=this.st_entrytype
this.Control[iCurrent+7]=this.rb_customcriteria
this.Control[iCurrent+8]=this.rb_currentrecord
this.Control[iCurrent+9]=this.rb_allrecords
this.Control[iCurrent+10]=this.st_records
this.Control[iCurrent+11]=this.gb_records
this.Control[iCurrent+12]=this.gb_entrytype
this.Control[iCurrent+13]=this.rb_actions
end on

on u_condition_setting.destroy
call super::destroy
destroy(this.dw_assignedto)
destroy(this.st_assignedto)
destroy(this.cb_actionitemfilter)
destroy(this.rb_alltype)
destroy(this.rb_alarms)
destroy(this.st_entrytype)
destroy(this.rb_customcriteria)
destroy(this.rb_currentrecord)
destroy(this.rb_allrecords)
destroy(this.st_records)
destroy(this.gb_records)
destroy(this.gb_entrytype)
destroy(this.rb_actions)
end on

event constructor;long	ll_Value

of_RegResize()

dw_AssignedTo.SetTransObject(SQLCA)
dw_AssignedTo.InsertRow(0)

SELECT CalActItemFilter_0 INTO :is_ActionFilter_Exp FROM icred_settings;

if IsNull(is_ActionFilter_Exp) then
	ll_Value = long(gnv_data.of_GetItem("code_lookup","lookup_code","lookup_name = 'Contract Action Status' and code = 'Complete'"))
	is_ActionFilter_Exp = ACTIONSTATUSFLAG + " (" + String(ll_Value) + ") and " + ASSIGNEDTOFLAG + " ('" + gs_User_ID + "') and wf_complete_flag <> 'Y'"
end if

of_FilterToArray()

of_SetAssignedTo()

SELECT CalActItemFilter_1 INTO :is_QuickFilter[1] FROM icred_settings;
if IsNull(is_QuickFilter[1]) then is_QuickFilter[1] = ""

SELECT CalActItemFilter_2 INTO :is_QuickFilter[2] FROM icred_settings;
if IsNull(is_QuickFilter[2]) then is_QuickFilter[2] = ""

SELECT CalActItemFilter_3 INTO :is_QuickFilter[3] FROM icred_settings;
if IsNull(is_QuickFilter[3]) then is_QuickFilter[3] = ""

end event

type dw_assignedto from datawindow within u_condition_setting
integer x = 320
integer y = 12
integer width = 407
integer height = 72
integer taborder = 30
string dataobject = "d_AssignedTo_user"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;if AppeonGetClientType() = "WEB" then This.Modify("user_id.Y = 8")

end event

event itemchanged;String	ls_AssignedTo

n_cst_string	lcst_StrProcess

if Row <= 0 or Row > This.RowCount() then Return

if IsNull(data) or Trim(data) = "" then
	is_Condition[4] = ""
else
	is_Condition[4] = ASSIGNEDTOFLAG + " ('" + lcst_StrProcess.of_GlobalReplace(data,",","','") + "')"
end if

of_ArrayToFilter()

Post of_RefreshCondition()

end event

type st_assignedto from statictext within u_condition_setting
integer x = 37
integer y = 20
integer width = 270
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16765357
string text = "Assigned To"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_actionitemfilter from commandbutton within u_condition_setting
boolean visible = false
integer x = 1851
integer y = 8
integer width = 64
integer height = 80
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "..."
end type

event clicked;of_GoToActionItemFilter()

end event

type rb_alltype from radiobutton within u_condition_setting
integer x = 923
integer y = 24
integer width = 151
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16765357
string text = "All"
boolean checked = true
end type

event clicked;of_RefreshCondition()

end event

type rb_alarms from radiobutton within u_condition_setting
integer x = 1088
integer y = 24
integer width = 366
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16765357
string text = "Date Alarms"
end type

event clicked;of_RefreshCondition()

end event

type st_entrytype from statictext within u_condition_setting
integer x = 750
integer y = 20
integer width = 169
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16765357
string text = "Type: "
alignment alignment = right!
boolean focusrectangle = false
end type

type rb_customcriteria from radiobutton within u_condition_setting
integer x = 2807
integer y = 24
integer width = 443
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16765357
string text = "Custom Criteria"
end type

event clicked;String	ls_Msg
long		ll_Rtn
Boolean	lb_NoMsg

PowerObject lpo_NullParm

if This.Checked then
	if IsValid(gw_Contract) then
		if gw_Contract.tab_contract_details.SelectedTab = 1 then
			lb_NoMsg = true
		end if
	end if
	
	if Not lb_NoMsg then
		ls_Msg = "This option is performed by using the Search tab->Criteria screen and requires the Search Tab to display, Do you want to proceed?"
		ll_Rtn = MessageBox(gnv_app.iapp_object.DisplayName,ls_Msg,Question!,YesNo!,1)
		
		if ll_Rtn = 1 then
			if IsValid(gw_Contract) then
				gw_Contract.tab_contract_details.SelectTab(1)
				gw_Contract.BringToTop = true
			else
				gf_OpenContractFolder(lpo_NullParm)
			end if
			
			Post Open(w_SearchPage_Calendar,gw_Contract)
		else
			irb_Record.Checked = true
			irb_Record.SetFocus()
		end if
	end if
end if

Post of_RefreshCondition()

end event

type rb_currentrecord from radiobutton within u_condition_setting
integer x = 2354
integer y = 24
integer width = 448
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16765357
string text = "Current Record"
end type

event clicked;of_RefreshCondition()

end event

type rb_allrecords from radiobutton within u_condition_setting
integer x = 2185
integer y = 24
integer width = 146
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16765357
string text = "All"
boolean checked = true
end type

event clicked;of_RefreshCondition()

end event

type st_records from statictext within u_condition_setting
integer x = 1934
integer y = 20
integer width = 233
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16765357
string text = "Records:"
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_records from groupbox within u_condition_setting
boolean visible = false
integer x = 1920
integer width = 1367
integer height = 112
integer taborder = 20
integer textsize = -2
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16765357
end type

type gb_entrytype from groupbox within u_condition_setting
boolean visible = false
integer x = 741
integer width = 1106
integer height = 112
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16765357
end type

type rb_actions from radiobutton within u_condition_setting
integer x = 1472
integer y = 24
integer width = 366
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16765357
string text = "Action Items"
end type

event clicked;of_RefreshCondition()

end event

