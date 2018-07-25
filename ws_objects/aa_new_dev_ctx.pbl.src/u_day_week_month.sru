$PBExportHeader$u_day_week_month.sru
forward
global type u_day_week_month from u_base
end type
type p_month from picture within u_day_week_month
end type
type p_week from picture within u_day_week_month
end type
type p_day from picture within u_day_week_month
end type
type uo_month from u_calendar_month within u_day_week_month
end type
type uo_day from u_calendar_day within u_day_week_month
end type
type uo_week from u_calendar_week within u_day_week_month
end type
type r_title from rectangle within u_day_week_month
end type
type uo_condition_setting from u_condition_setting within u_day_week_month
end type
end forward

global type u_day_week_month from u_base
integer width = 3630
integer height = 2644
long backcolor = 67108864
long picturemaskcolor = 536870912
p_month p_month
p_week p_week
p_day p_day
uo_month uo_month
uo_day uo_day
uo_week uo_week
r_title r_title
uo_condition_setting uo_condition_setting
end type
global u_day_week_month u_day_week_month

type variables
CONSTANT LONG LOWERBLUE   = 16773091
CONSTANT LONG LOWERYELLOW = 3968251
CONSTANT LONG MAROON      = 128
CONSTANT LONG BLACKCOLOR  = 0

String		is_User_id,is_ActionFilter_Exp,is_CTXFilter_Exp
String		is_FilterName1,is_FilterName2,is_FilterName3
long			il_CurrentPage

Boolean		ib_DispAlarm,ib_DispAction

DataStore	ids_cal_notify_disp_list

Date		id_Current

end variables

forward prototypes
public subroutine of_refreshselectscope (long al_select)
public subroutine of_setcurrentdate (date ad_current)
public function boolean of_getalarmdispstatus ()
public function boolean of_getactiondispstatus ()
public function string of_getActionFilter_Exp ()
public function string of_getctxfilter_exp ()
public subroutine of_regresize ()
public function string of_GetUserID ()
public subroutine of_refreshcondition (string as_user_id, boolean ab_alarms, boolean ab_actions, string as_actionfilter_exp, string as_ctxfilter_exp)
public subroutine of_gotoactionitemfilter ()
public subroutine of_setactionitemquickfilter (long al_number)
public subroutine of_refresh_disp_list ()
public subroutine of_refreshfiltername ()
public subroutine of_refresh_arrange ()
end prototypes

public subroutine of_refreshselectscope (long al_select);//====================================================================
// Function: of_RefreshSelectScope()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    long    al_Select
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-11-11
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Contract Logix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

if al_Select = 0 then al_Select = il_CurrentPage

if al_Select = 1 then
	uo_Day.of_Draw_Day(id_Current)
	
	p_Day.PictureName = "DayPageSelect.gif"
	p_Week.PictureName = "WeekPageUnSelect.gif"
	p_Month.PictureName = "MonthPageUnSelect.gif"

	uo_Day.Visible = true
	uo_Week.Visible = false
	uo_Month.Visible = false
elseif al_Select = 2 then
	uo_Week.of_Draw_Week(id_Current)
	
	p_Day.PictureName = "DayPageUnSelect.gif"
	p_Week.PictureName = "WeekPageSelect.gif"
	p_Month.PictureName = "MonthPageUnSelect.gif"
	uo_Day.Visible = false
	uo_Week.Visible = true
	uo_Month.Visible = false
elseif al_Select = 3 then
	uo_Month.of_Draw_Month(id_Current)
	
	p_Day.PictureName = "DayPageUnSelect.gif"
	p_Week.PictureName = "WeekPageUnSelect.gif"
	p_Month.PictureName = "MonthPageSelect.gif"
	uo_Day.Visible = false
	uo_Week.Visible = false
	uo_Month.Visible = true
end if

il_CurrentPage = al_Select

end subroutine

public subroutine of_setcurrentdate (date ad_current);id_Current = ad_Current

end subroutine

public function boolean of_getalarmdispstatus ();Return ib_DispAlarm

end function

public function boolean of_getactiondispstatus ();Return ib_DispAction

end function

public function string of_getActionFilter_Exp ();Return is_ActionFilter_Exp

end function

public function string of_getctxfilter_exp ();Return is_CTXFilter_Exp

end function

public subroutine of_regresize ();This.of_SetResize(true)

This.inv_Resize.of_SetOrigSize(This.Width,This.Height)

This.inv_Resize.of_Register(r_Title,This.inv_Resize.SCALERIGHT)
This.inv_Resize.of_Register(uo_Condition_Setting,This.inv_Resize.SCALERIGHT)
This.inv_Resize.of_Register(uo_Month,This.inv_Resize.SCALERIGHTBOTTOM)
This.inv_Resize.of_Register(uo_Week,This.inv_Resize.SCALERIGHTBOTTOM)
This.inv_Resize.of_Register(uo_Day,This.inv_Resize.SCALERIGHTBOTTOM)

end subroutine

public function string of_GetUserID ();Return is_User_id

end function

public subroutine of_refreshcondition (string as_user_id, boolean ab_alarms, boolean ab_actions, string as_actionfilter_exp, string as_ctxfilter_exp);String	ls_Modify

is_User_id = as_User_id

ib_DispAlarm  = ab_Alarms
ib_DispAction = ab_Actions

is_ActionFilter_Exp = as_ActionFilter_Exp
if is_ActionFilter_Exp = "" then
	ls_Modify = "t_ActionItemFilter_0.Color = " + String(BLACKCOLOR) //+ " "  + "t_ActionItemFilter_0.Font.Weight = 400 "
else
	ls_Modify = "t_ActionItemFilter_0.Color = " + String(MAROON) //+ " "  + "t_ActionItemFilter_0.Font.Weight = 700 "
end if

uo_Month.dw_Month_Calendar.Modify(ls_Modify)
uo_Week.dw_Week_Calendar.Modify(ls_Modify)
uo_Day.dw_Day_Calendar.Modify(ls_Modify)

is_CTXFilter_Exp    = as_CTXFilter_Exp

of_RefreshSelectScope(il_CurrentPage)

end subroutine

public subroutine of_gotoactionitemfilter ();uo_condition_setting.of_GoToActionItemFilter()

end subroutine

public subroutine of_setactionitemquickfilter (long al_number);uo_condition_setting.of_SetActionItemQuickFilter(al_Number)

String	ls_Modify

Choose Case al_Number
	Case 1
		ls_Modify += "t_ActionItemFilter_1.Color = " + String(MAROON) + " " + "t_ActionItemFilter_1.Font.Weight = 700 "
		ls_Modify += "t_ActionItemFilter_2.Color = " + String(BLACKCOLOR) + " " + "t_ActionItemFilter_2.Font.Weight = 400 "
		ls_Modify += "t_ActionItemFilter_3.Color = " + String(BLACKCOLOR) + " " + "t_ActionItemFilter_3.Font.Weight = 400 "
	Case 2
		ls_Modify += "t_ActionItemFilter_1.Color = " + String(BLACKCOLOR) + " " + "t_ActionItemFilter_1.Font.Weight = 400 "
		ls_Modify += "t_ActionItemFilter_2.Color = " + String(MAROON) + " " + "t_ActionItemFilter_2.Font.Weight = 700 "
		ls_Modify += "t_ActionItemFilter_3.Color = " + String(BLACKCOLOR) + " " + "t_ActionItemFilter_3.Font.Weight = 400 "
	Case 3
		ls_Modify += "t_ActionItemFilter_1.Color = " + String(BLACKCOLOR) + " " + "t_ActionItemFilter_1.Font.Weight = 400 "
		ls_Modify += "t_ActionItemFilter_2.Color = " + String(BLACKCOLOR) + " " + "t_ActionItemFilter_2.Font.Weight = 400 "
		ls_Modify += "t_ActionItemFilter_3.Color = " + String(MAROON) + " " + "t_ActionItemFilter_3.Font.Weight = 700 "
End Choose

uo_Month.dw_Month_Calendar.Modify(ls_Modify)
uo_Week.dw_Week_Calendar.Modify(ls_Modify)
uo_Day.dw_Day_Calendar.Modify(ls_Modify)

end subroutine

public subroutine of_refresh_disp_list ();ids_cal_notify_disp_list.DataObject = "d_cal_notify_disp_list"
ids_cal_notify_disp_list.SetTransObject(SQLCA)
ids_cal_notify_disp_list.Retrieve(gs_user_id)

of_Refresh_Arrange()

end subroutine

public subroutine of_refreshfiltername ();//====================================================================
// Function: of_RefreshFilterName()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2010-03-16
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

is_FilterName1 = gnv_data.of_GetItem("icred_settings","CalFilterName_1",false)
is_FilterName2 = gnv_data.of_GetItem("icred_settings","CalFilterName_2",false)
is_FilterName3 = gnv_data.of_GetItem("icred_settings","CalFilterName_3",false)

uo_Month.of_RefreshFilterName(is_FilterName1,is_FilterName2,is_FilterName3)
uo_Week.of_RefreshFilterName(is_FilterName1,is_FilterName2,is_FilterName3)
uo_Day.of_RefreshFilterName(is_FilterName1,is_FilterName2,is_FilterName3)

end subroutine

public subroutine of_refresh_arrange ();uo_Month.of_Init_Data(ids_cal_notify_disp_list)
uo_Week.of_Init_Data(ids_cal_notify_disp_list)
uo_Day.of_Init_Data(ids_cal_notify_disp_list)

end subroutine

on u_day_week_month.create
int iCurrent
call super::create
this.p_month=create p_month
this.p_week=create p_week
this.p_day=create p_day
this.uo_month=create uo_month
this.uo_day=create uo_day
this.uo_week=create uo_week
this.r_title=create r_title
this.uo_condition_setting=create uo_condition_setting
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_month
this.Control[iCurrent+2]=this.p_week
this.Control[iCurrent+3]=this.p_day
this.Control[iCurrent+4]=this.uo_month
this.Control[iCurrent+5]=this.uo_day
this.Control[iCurrent+6]=this.uo_week
this.Control[iCurrent+7]=this.r_title
this.Control[iCurrent+8]=this.uo_condition_setting
end on

on u_day_week_month.destroy
call super::destroy
destroy(this.p_month)
destroy(this.p_week)
destroy(this.p_day)
destroy(this.uo_month)
destroy(this.uo_day)
destroy(this.uo_week)
destroy(this.r_title)
destroy(this.uo_condition_setting)
end on

event constructor;//====================================================================
// Event: constructor()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-11-18
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Contract Logix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

of_RegResize()

if Not IsValid(ids_cal_notify_disp_list) then ids_cal_notify_disp_list  = Create DataStore

of_Refresh_Disp_List()

This.BackColor = LOWERBLUE

id_Current = Today()

of_RefreshSelectScope(3)

of_RefreshFilterName()

end event

event destructor;if IsValid(ids_cal_notify_disp_list) then Destroy ids_cal_notify_disp_list

end event

type p_month from picture within u_day_week_month
integer x = 800
integer width = 457
integer height = 112
string pointer = "HyperLink!"
string picturename = "MonthPageUnSelect.gif"
boolean focusrectangle = false
end type

event clicked;of_RefreshSelectScope(3)

end event

type p_week from picture within u_day_week_month
integer x = 379
integer width = 421
integer height = 112
string pointer = "HyperLink!"
string picturename = "WeekPageUnSelect.gif"
boolean focusrectangle = false
end type

event clicked;of_RefreshSelectScope(2)

end event

type p_day from picture within u_day_week_month
integer width = 379
integer height = 112
string pointer = "HyperLink!"
string picturename = "DayPageUnSelect.gif"
boolean focusrectangle = false
end type

event clicked;of_RefreshSelectScope(1)

end event

type uo_month from u_calendar_month within u_day_week_month
integer y = 108
integer height = 2540
integer taborder = 10
end type

on uo_month.destroy
call u_calendar_month::destroy
end on

event rbuttondown;call super::rbuttondown;long Job

PrintSetup ( )
Job = PrintOpen( )

Parent.Print(Job, 0,0)

PrintClose(Job)
end event

type uo_day from u_calendar_day within u_day_week_month
boolean visible = false
integer y = 108
integer height = 2540
integer taborder = 50
end type

on uo_day.destroy
call u_calendar_day::destroy
end on

type uo_week from u_calendar_week within u_day_week_month
boolean visible = false
integer y = 108
integer height = 2540
integer taborder = 40
end type

on uo_week.destroy
call u_calendar_week::destroy
end on

type r_title from rectangle within u_day_week_month
long linecolor = 13603685
integer linethickness = 4
long fillcolor = 16765357
integer width = 3625
integer height = 112
end type

type uo_condition_setting from u_condition_setting within u_day_week_month
integer x = 1257
integer y = 8
integer width = 2359
integer height = 96
integer taborder = 30
boolean bringtotop = true
end type

on uo_condition_setting.destroy
call u_condition_setting::destroy
end on

event constructor;call super::constructor;//of_SetBKColor(16765357)
of_SetBKColor(16774640) //Modified by Appeon long.zhang 02.23.2016 (BugL021806)
This.Height = r_Title.Height

end event

