$PBExportHeader$w_clause_attribute_filter.srw
forward
global type w_clause_attribute_filter from w_response
end type
type dw_disclaincattr from datawindow within w_clause_attribute_filter
end type
type dw_allclaincattr from datawindow within w_clause_attribute_filter
end type
type cb_cancel from commandbutton within w_clause_attribute_filter
end type
type cb_ok from commandbutton within w_clause_attribute_filter
end type
type cb_clearfilter from commandbutton within w_clause_attribute_filter
end type
type dw_attributes_detail from u_dw within w_clause_attribute_filter
end type
type dw_clause_attributes from u_dw within w_clause_attribute_filter
end type
end forward

global type w_clause_attribute_filter from w_response
integer width = 2318
integer height = 1428
string title = "Clause Attributes Filter"
dw_disclaincattr dw_disclaincattr
dw_allclaincattr dw_allclaincattr
cb_cancel cb_cancel
cb_ok cb_ok
cb_clearfilter cb_clearfilter
dw_attributes_detail dw_attributes_detail
dw_clause_attributes dw_clause_attributes
end type
global w_clause_attribute_filter w_clause_attribute_filter

type variables
String	is_Filter

end variables

forward prototypes
public subroutine of_getfilterexp (ref str_clause_filter astr_filter)
end prototypes

public subroutine of_getfilterexp (ref str_clause_filter astr_filter);//====================================================================
// Function: of_GetFilterExp()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	reference    str_clause_filter    astr_Filter
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2010-01-13
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_Cycle,ll_RowCnts,ll_RowNo
long		ll_clause_id,ll_ValCnts
String	ls_FindExp

dw_clause_attributes.AcceptText()
dw_attributes_detail.AcceptText()

dw_attributes_detail.SetFilter("IsChecked = 1")
dw_attributes_detail.Filter()

ll_RowCnts = dw_attributes_detail.RowCount()
if ll_RowCnts = 0 then Return

for ll_RowNo = 1 to ll_RowCnts
	astr_Filter.Value_id[Upperbound(astr_Filter.Value_id) + 1] = dw_attributes_detail.GetItemNumber(ll_RowNo,"lookup_Value_id")
next

ll_RowCnts = dw_DisClaIncAttr.RowCount()
ll_ValCnts = Upperbound(astr_Filter.Value_id)
for ll_RowNo = 1 to ll_RowCnts
	ll_clause_id = dw_DisClaIncAttr.GetItemNumber(ll_RowNo,"ctx_acp_clause_id")
	for ll_Cycle = 1 to ll_ValCnts
		ls_FindExp = "ctx_acp_clause_id = " + String(ll_clause_id) + " and clause_attribute_Value_id = " + String(astr_Filter.Value_id[ll_Cycle])
		if dw_AllClaIncAttr.Find(ls_FindExp,1,dw_AllClaIncAttr.RowCount()) <= 0 then Exit
	next
	
	if ll_Cycle > ll_ValCnts then
		astr_Filter.Clause_Exp += String(ll_clause_id) + ","
	end if
next

if Right(astr_Filter.Clause_Exp,1) = "," then
	astr_Filter.Clause_Exp = "(" + Left(astr_Filter.Clause_Exp,Len(astr_Filter.Clause_Exp) - 1) + ")"
else
	astr_Filter.Clause_Exp = "(-1)"
end if

end subroutine

on w_clause_attribute_filter.create
int iCurrent
call super::create
this.dw_disclaincattr=create dw_disclaincattr
this.dw_allclaincattr=create dw_allclaincattr
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.cb_clearfilter=create cb_clearfilter
this.dw_attributes_detail=create dw_attributes_detail
this.dw_clause_attributes=create dw_clause_attributes
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_disclaincattr
this.Control[iCurrent+2]=this.dw_allclaincattr
this.Control[iCurrent+3]=this.cb_cancel
this.Control[iCurrent+4]=this.cb_ok
this.Control[iCurrent+5]=this.cb_clearfilter
this.Control[iCurrent+6]=this.dw_attributes_detail
this.Control[iCurrent+7]=this.dw_clause_attributes
end on

on w_clause_attribute_filter.destroy
call super::destroy
destroy(this.dw_disclaincattr)
destroy(this.dw_allclaincattr)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.cb_clearfilter)
destroy(this.dw_attributes_detail)
destroy(this.dw_clause_attributes)
end on

event open;call super::open;long	ll_Cycle,ll_Found,ll_RowCnts

str_clause_filter	lstr_ClauseFilter

lstr_ClauseFilter = Message.PowerObjectParm

dw_Attributes_Detail.SetTransObject(SQLCA)
dw_Attributes_Detail.Retrieve()

ll_RowCnts = dw_Attributes_Detail.RowCount()

for ll_Cycle = 1 to UpperBound(lstr_ClauseFilter.Value_id)
	ll_Found = dw_Attributes_Detail.Find("lookup_value_id = " + String(lstr_ClauseFilter.Value_id[ll_Cycle]),1,ll_RowCnts)
	if ll_Found > 0 then dw_Attributes_Detail.SetItem(ll_Found,"IsChecked",1)
next

dw_clause_attributes.SetTransObject(SQLCA)
dw_clause_attributes.Retrieve()

end event

type dw_disclaincattr from datawindow within w_clause_attribute_filter
boolean visible = false
integer x = 2830
integer y = 292
integer width = 526
integer height = 472
string dataobject = "d_distinct_clause_includeattr"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.SetTransObject(SQLCA)
This.Retrieve()

end event

type dw_allclaincattr from datawindow within w_clause_attribute_filter
boolean visible = false
integer x = 3433
integer y = 292
integer width = 526
integer height = 472
string dataobject = "d_all_clause_includeattr"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.SetTransObject(SQLCA)
This.Retrieve()

end event

type cb_cancel from commandbutton within w_clause_attribute_filter
integer x = 1938
integer y = 1228
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

event clicked;str_clause_filter	lstr_ClauseFilter

lstr_ClauseFilter.Clause_Exp = "Cancel"

CloseWithReturn(Parent,lstr_ClauseFilter)

end event

type cb_ok from commandbutton within w_clause_attribute_filter
integer x = 1568
integer y = 1228
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;str_clause_filter	lstr_ClauseFilter

of_GetFilterExp(lstr_ClauseFilter)

CloseWithReturn(Parent,lstr_ClauseFilter)

end event

type cb_clearfilter from commandbutton within w_clause_attribute_filter
integer x = 18
integer y = 1228
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Clear &Filter"
end type

event clicked;dw_attributes_detail.Retrieve()

end event

type dw_attributes_detail from u_dw within w_clause_attribute_filter
integer x = 1015
integer y = 20
integer width = 1266
integer height = 1176
integer taborder = 20
string dataobject = "d_all_attributes_detail"
end type

event clicked;call super::clicked;long	ll_Selected

if Row > 0 and Row <= This.RowCount() then
	This.SetRow(Row)
	ll_Selected = This.GetItemNumber(Row,"IsChecked")
	This.SetItem(Row,"IsChecked",1 - ll_Selected)
end if

end event

event constructor;call super::constructor;This.of_SetUpdateable(false)

This.SetTransObject(SQLCA)

end event

event doubleclicked;call super::doubleclicked;This.Trigger Event Clicked(XPos,YPos,Row,dwo)

end event

type dw_clause_attributes from u_dw within w_clause_attribute_filter
integer x = 18
integer y = 20
integer width = 974
integer height = 1176
integer taborder = 10
string dataobject = "d_clause_all_attributes"
end type

event constructor;call super::constructor;This.of_SetUpdateable(false)

end event

event rowfocuschanged;call super::rowfocuschanged;String	ls_Alias,ls_LookupName

if CurrentRow <= 0 or CurrentRow > This.RowCount() then Return

ls_Alias = This.GetItemString(CurrentRow,"alias_name")
dw_attributes_detail.Modify("code_t.Text = '" + ls_Alias + " (Check one or more)'")

ls_LookupName = This.GetItemString(CurrentRow,"Alias_Name")
dw_Attributes_Detail.SetFilter("lookup_name = '" + ls_LookupName + "'")
dw_Attributes_Detail.Filter()

end event

