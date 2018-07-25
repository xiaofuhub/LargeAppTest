$PBExportHeader$w_searchpage_calendar.srw
forward
global type w_searchpage_calendar from w_child
end type
type uo_calendar from u_day_week_month within w_searchpage_calendar
end type
end forward

global type w_searchpage_calendar from w_child
integer width = 3662
integer height = 2668
boolean titlebar = false
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
uo_calendar uo_calendar
end type
global w_searchpage_calendar w_searchpage_calendar

forward prototypes
public subroutine of_regresize ()
public subroutine of_adjustsize ()
public subroutine of_refreshcondition ()
end prototypes

public subroutine of_regresize ();This.of_SetResize(true)

This.inv_Resize.of_SetOrigSize(This.Width,This.Height)
This.inv_Resize.of_SetMinSize(800,600)

This.inv_Resize.of_Register(uo_Calendar,This.inv_Resize.SCALERIGHTBOTTOM)

end subroutine

public subroutine of_adjustsize ();//====================================================================
// Function: of_AdjustSize()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-12-01
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Contract Logix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long	ll_XPos,ll_YPos,ll_Width,ll_Height

DataWindow	ldw_Browse

if IsValid(gw_Contract) then
	this.setredraw(False)	//(Appeon)Harry 01.23.2014 - V142 ISG-CLX
	ldw_Browse = gw_Contract.tab_contract_details.tabpage_search.dw_search_det1
	
	ll_XPos = gw_Contract.tab_contract_details.X + gw_Contract.tab_contract_details.tabpage_search.X + ldw_Browse.X
	ll_YPos = gw_Contract.tab_contract_details.Y + gw_Contract.tab_contract_details.tabpage_search.Y + ldw_Browse.Y
	
	ll_Width  = ldw_Browse.Width
	ll_Height = gw_Contract.Tab_Contract_Details.Tabpage_Search.Cb_1.Y + gw_Contract.Tab_Contract_Details.Tabpage_Search.Cb_1.Height - ldw_Browse.Y + 4
	
	This.Move(ll_XPos,ll_YPos)
	This.Resize(ll_Width,ll_Height)
	this.setredraw(True)					//Added By Mark Lee 12/10/2012 //(Appeon)Harry 01.23.2014 - V142 ISG-CLX
end if

end subroutine

public subroutine of_refreshcondition ();uo_Calendar.uo_Condition_Setting.of_RefreshCondition()

end subroutine

on w_searchpage_calendar.create
int iCurrent
call super::create
this.uo_calendar=create uo_calendar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_calendar
end on

on w_searchpage_calendar.destroy
call super::destroy
destroy(this.uo_calendar)
end on

event open;call super::open;This.BackColor = uo_Calendar.BackColor

uo_Calendar.Move(0,0)

if AppeonGetClientType() = "WEB" then
	uo_Calendar.Resize(This.Width + 22,This.Height + 26)
else
	uo_Calendar.Resize(This.Width,This.Height)
end if

of_RegResize()

if IsValid(gw_Contract) then
	of_AdjustSize()
	
	uo_Calendar.uo_Condition_Setting.rb_CustomCriteria.Checked = true
	uo_Calendar.uo_Condition_Setting.rb_CustomCriteria.TriggerEvent(Clicked!)
end if

end event

type uo_calendar from u_day_week_month within w_searchpage_calendar
integer taborder = 40
end type

on uo_calendar.destroy
call u_day_week_month::destroy
end on

