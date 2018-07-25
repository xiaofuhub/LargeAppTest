$PBExportHeader$u_calendar_week.sru
forward
global type u_calendar_week from u_calendar_ancestor
end type
type dw_disp_list_07 from u_dw_calendar_item within u_calendar_week
end type
type dw_disp_list_06 from u_dw_calendar_item within u_calendar_week
end type
type dw_disp_list_05 from u_dw_calendar_item within u_calendar_week
end type
type dw_disp_list_04 from u_dw_calendar_item within u_calendar_week
end type
type dw_disp_list_03 from u_dw_calendar_item within u_calendar_week
end type
type dw_disp_list_02 from u_dw_calendar_item within u_calendar_week
end type
type dw_disp_list_01 from u_dw_calendar_item within u_calendar_week
end type
type r_frame from rectangle within u_calendar_week
end type
type dw_week_calendar from datawindow within u_calendar_week
end type
end forward

global type u_calendar_week from u_calendar_ancestor
integer width = 3630
integer height = 2532
long backcolor = 67108864
long picturemaskcolor = 536870912
dw_disp_list_07 dw_disp_list_07
dw_disp_list_06 dw_disp_list_06
dw_disp_list_05 dw_disp_list_05
dw_disp_list_04 dw_disp_list_04
dw_disp_list_03 dw_disp_list_03
dw_disp_list_02 dw_disp_list_02
dw_disp_list_01 dw_disp_list_01
r_frame r_frame
dw_week_calendar dw_week_calendar
end type
global u_calendar_week u_calendar_week

type variables
Date		id_WeekFirst,id_WeekEnd,id_WeekCurrent

//From John:please change the date format so that it reads:  November 28, 2010   NOT  November,28 2010 - jervis 12.03.2010
//String	is_WeekHeadDateFormat = "MMMM,dd YYYY"
String	is_WeekHeadDateFormat = "MMMM dd,YYYY" 

CONSTANT LONG WEEKDAYS = 7
CONSTANT LONG DAYSPERWEEK = 7

CONSTANT LONG DEFAULTDATETITLEHEIGHT = 76

CONSTANT STRING WEEKDAYBGYELLOW = "WeekDayTitleBG_Yellow.gif"
CONSTANT STRING WEEKDAYBGBLUE   = "WeekDayTitleBG_Blue.gif"

end variables

forward prototypes
public subroutine of_goto_prev_week ()
public subroutine of_goto_next_week ()
public subroutine of_resetlayout ()
public subroutine of_pitchondate (string as_name)
public subroutine of_draw_week (date ad_weekcurrent)
public subroutine of_regresize ()
public subroutine of_refreshfiltername (string as_filtername1, string as_filtername2, string as_filtername3)
end prototypes

public subroutine of_goto_prev_week ();//====================================================================
// Function: of_GoTo_Prev_Week()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-11-10
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Contract Logix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

of_Draw_Week(RelativeDate(id_WeekCurrent,-DAYSPERWEEK))

end subroutine

public subroutine of_goto_next_week ();//====================================================================
// Function: of_GoTo_Next_Week()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-11-10
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Contract Logix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

of_Draw_Week(RelativeDate(id_WeekCurrent,DAYSPERWEEK))

end subroutine

public subroutine of_resetlayout ();//====================================================================
// Function: of_ResetLayout()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
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

long		ll_ColNo,ll_ColXPos,ll_ColYPos,ll_dwHeaderHeight,ll_dwDetailHeight,ll_AreaWidth,ll_AreaHeight
long		ll_dwInitXPos,ll_dwInitYPos,ll_dwMSDHeight
long		ll_Cycle,ll_XPos,ll_Width
String	ls_LabelName,ls_BKPicName,ls_VerLName
String 	ls_WeekName,ls_AreaBKName,ls_Syntax

ll_dwHeaderHeight = long(dw_Week_Calendar.Describe("DataWindow.Header.Height"))
ll_dwDetailHeight = dw_Week_Calendar.Height - ll_dwHeaderHeight - 4

dw_Week_Calendar.Modify("DataWindow.Detail.Height = '" + String(ll_dwDetailHeight) + "'")

//////////////Adjust the object size and position//////////////
ll_XPos = dw_Week_Calendar.Width

for ll_Cycle = 3 to 0 Step -1
	ll_Width = long(dw_Week_Calendar.Describe("p_" + ACTIONITEMFILTERNAME + String(ll_Cycle) + ".Width"))
	ll_XPos = ll_XPos - ll_Width - ACTIONITEMFILTERSPACE
	
	ls_Syntax += "p_" + ACTIONITEMFILTERNAME + String(ll_Cycle) + ".X = " + String(ll_XPos) + " "
	ls_Syntax += "t_" + ACTIONITEMFILTERNAME + String(ll_Cycle) + ".X = " + String(ll_XPos) + " "
next

ll_Width = long(dw_Week_Calendar.Describe("p_" + ARRANGEMODE + ".Width"))
ll_XPos = ll_XPos - ll_Width - ACTIONITEMFILTERSPACE

ls_Syntax += "p_" + ARRANGEMODE + ".X = " + String(ll_XPos) + " "
ls_Syntax += "t_" + ARRANGEMODE + ".X = " + String(ll_XPos) + " "
///////////////////////////////////////////////////////////////

ll_AreaWidth  = long(dw_Week_Calendar.Width/DAYSPERWEEK + DATEHORISPACE)
ll_AreaHeight = ll_dwDetailHeight - DEFAULTDATEINITY - DEFAULTDATETITLEHEIGHT

ll_dwInitXPos  = dw_Week_Calendar.X + DWINDENTDEPTH
ll_dwInitYPos  = dw_Week_Calendar.Y + ll_dwHeaderHeight + DEFAULTDATETITLEHEIGHT + DWINDENTDEPTH

ll_dwMSDHeight  = long(idw_Disp_List[1].Describe("DataWindow.Detail.Height"))

for ll_ColNo = 1 to WEEKDAYS
	ls_BKPicName  = BACKGDPICMARK + String(ll_ColNo,"00") + "_p"
	ls_LabelName  = DATELABELMARK + String(ll_ColNo,"00") + "_t"
	ls_WeekName   = WEEKDAYMARK   + String(ll_ColNo,"00") + "_t"
	ls_AreaBKName = AREABKMARK    + String(ll_ColNo,"00") + "_t"
	ls_VerLName   = VERLINEMARK   + String(ll_ColNo,"00") + "_l"
	
	ll_ColXPos = DEFAULTDATEINITX + (ll_ColNo - 1) * (ll_AreaWidth + DATEHORISPACE)
	ll_ColYPos = DEFAULTDATEINITY
	
	if idw_Disp_List[ll_ColNo].Visible then
		idw_Disp_List[ll_ColNo].X = ll_dwInitXPos + ll_ColXPos
		idw_Disp_List[ll_ColNo].Y = ll_dwInitYPos + ll_ColYPos
		idw_Disp_List[ll_ColNo].Width  = ll_AreaWidth - TEXTINDENTDEPTH
		idw_Disp_List[ll_ColNo].Height = ll_AreaHeight - 8
		
		if idw_Disp_List[ll_ColNo].Height >= ll_dwMSDHeight * idw_Disp_List[ll_ColNo].RowCount() + 4 then
			idw_Disp_List[ll_ColNo].Modify("disp_value.Width = '" + String(ll_AreaWidth - TEXTINDENTDEPTH * 12) + "'")
			idw_Disp_List[ll_ColNo].Modify("p_small_background.Width = '" + String(ll_AreaWidth - TEXTINDENTDEPTH * 4) + "'")
		else
			idw_Disp_List[ll_ColNo].Modify("disp_value.Width = '" + String(ll_AreaWidth - TEXTINDENTDEPTH * 12 - VERSCROLLBARWIDTH) + "'")
			idw_Disp_List[ll_ColNo].Modify("p_small_background.Width = '" + String(ll_AreaWidth - TEXTINDENTDEPTH * 4 - VERSCROLLBARWIDTH) + "'")
		end if
	end if
	
	ls_Syntax += ls_BKPicName  + ".X = "      + String(ll_ColXPos) + " " + &
					 ls_BKPicName  + ".Y = "      + String(ll_ColYPos) + " " + &
					 ls_BKPicName  + ".Width = "  + String(ll_AreaWidth) + " " + &
					 ls_BKPicName  + ".Height = " + String(DEFAULTDATETITLEHEIGHT) + " " + &
					 ls_LabelName  + ".X = "      + String(ll_ColXPos + TEXTINDENTDEPTH) + " " + &
					 ls_LabelName  + ".Y = "      + String(ll_ColYPos + long(TEXTINDENTDEPTH/2)) + " " + &
					 ls_LabelName  + ".Width = "  + String(ll_AreaWidth - 2 * TEXTINDENTDEPTH) + " " + &
					 ls_LabelName  + ".Height = " + String(DEFAULTDATETITLEHEIGHT - 2 * TEXTINDENTDEPTH) + " " + &
					 ls_WeekName   + ".X = "      + String(ll_ColXPos) + " " + &
					 ls_WeekName   + ".Y = "      + String(ll_ColYPos + long(TEXTINDENTDEPTH/2)) + " " + &
					 ls_WeekName   + ".Width = "  + String(ll_AreaWidth) + " " + &
					 ls_WeekName   + ".Height = " + String(DEFAULTDATETITLEHEIGHT) + " " + &
					 ls_AreaBKName + ".X = "      + String(ll_ColXPos) + " " + &
					 ls_AreaBKName + ".Y = "      + String(ll_ColYPos + DEFAULTDATETITLEHEIGHT) + " " + &
					 ls_AreaBKName + ".Width = "  + String(ll_AreaWidth) + " " + &
					 ls_AreaBKName + ".Height = " + String(ll_AreaHeight) + " " + &
					 ls_VerLName   + ".X1 = "     + String(ll_ColXPos) + " " + &
					 ls_VerLName   + ".X2 = "     + String(ll_ColXPos) + " " + &
					 ls_VerLName   + ".Y1 = "     + String(0) + " " + &
					 ls_VerLName   + ".Y2 = "     + String(ll_dwDetailHeight) + " "
	
	dw_Week_Calendar.SetPosition(ls_LabelName,"",true)
	dw_Week_Calendar.SetPosition(ls_WeekName,"",true)
	dw_Week_Calendar.SetPosition(ls_VerLName,"",true)
	dw_Week_Calendar.SetPosition(ls_AreaBKName,"",false)
next

dw_Week_Calendar.Modify(ls_Syntax)

end subroutine

public subroutine of_pitchondate (string as_name);//====================================================================
// Function: of_PitchOnDate()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    string    as_Name
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

String	ls_Current
long		ll_DateAreaNo

if Pos(Lower(as_Name),Lower(AREABKMARK)) > 0 then
	if is_PreColName <> "" and is_PreColColor <> "" then
		dw_Week_Calendar.Modify(is_PreColName + ".Background.Color = '" + is_PreColColor + "'")
		
		ll_DateAreaNo = long(Mid(is_PreColName,Len(AREABKMARK) + 1,2))
		
		idw_Disp_List[ll_DateAreaNo].Modify("DataWindow.Color = '" + String(is_PreColColor) + "'")
		idw_Disp_List[ll_DateAreaNo].Modify("DataWindow.Detail.Color = '" + String(is_PreColColor) + "'")
	end if
	
	is_PreColName = as_Name
	is_PreColColor = dw_Week_Calendar.Describe(as_Name + ".Background.Color")
	
	dw_Week_Calendar.Modify(as_Name + ".Background.Color = '" + String(SELCOLOR) + "'")
	
	ll_DateAreaNo = long(Mid(as_Name,Len(AREABKMARK) + 1,2))
	
	idw_Disp_List[ll_DateAreaNo].Modify("DataWindow.Color = '" + String(SELCOLOR) + "'")
	idw_Disp_List[ll_DateAreaNo].Modify("DataWindow.Detail.Color = '" + String(SELCOLOR) + "'")
	
	ls_Current = dw_Week_Calendar.Describe(as_Name + ".Tag")
	id_WeekCurrent = Date(ls_Current)
	
	Parent.Dynamic of_SetCurrentDate(id_WeekCurrent)
end if

end subroutine

public subroutine of_draw_week (date ad_weekcurrent);//====================================================================
// Function: of_Draw_Week()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    date    ad_WeekCurrent
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-11-12
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Contract Logix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_WeekDayNum,ll_Cycle,ll_Rtn
String	ls_DayText,ls_Modify
Date		ld_WeekDay

id_WeekCurrent = ad_WeekCurrent

ll_WeekDayNum  = DayNumber(id_WeekCurrent)
id_WeekFirst   = RelativeDate(id_WeekCurrent,1 - ll_WeekDayNum)
id_WeekEnd     = RelativeDate(id_WeekFirst,6)

This.SetRedraw(false)
dw_Week_Calendar.SetRedraw(false)

ls_Modify += "Year_Month_Day_t.Text = '" + String(id_WeekFirst,is_WeekHeadDateFormat) + " - " + String(id_WeekEnd,is_WeekHeadDateFormat) + "' "

ll_Rtn = of_Fill_Data(id_WeekFirst,WEEKDAYS)
if ll_Rtn < 0 then Return

for ll_Cycle = 1 to WEEKDAYS
	ld_WeekDay  = RelativeDate(id_WeekFirst,ll_Cycle - 1)
	
	ls_DayText = String(Day(ld_WeekDay))
	
	ls_Modify += DATELABELMARK + String(ll_Cycle,"00") + "_t.Text = '" + ls_DayText + "' "
	
	if DaysAfter(ld_WeekDay,Today()) = 0 then
		ls_Modify += BACKGDPICMARK + String(ll_Cycle,"00") + "_p.Filename = '" + WEEKDAYBGYELLOW + "' "
	else
		ls_Modify += BACKGDPICMARK + String(ll_Cycle,"00") + "_p.Filename = '" + WEEKDAYBGBLUE + "' "
	end if
	
	ls_Modify += AREABKMARK + String(ll_Cycle,"00") + "_t.Tag = '" + String(ld_WeekDay) + "' "
	
	if idw_Disp_List[ll_Cycle].RowCount() > 0 then
		idw_Disp_List[ll_Cycle].Visible = true
	else
		idw_Disp_List[ll_Cycle].Visible = false
	end if
next

dw_Week_Calendar.Modify(ls_Modify)

of_PitchOnDate(AREABKMARK + String(DaysAfter(id_WeekFirst,id_WeekCurrent) + 1,"00") + "_t")

of_ResetLayout()

dw_Week_Calendar.SetRedraw(true)
This.SetRedraw(true)

end subroutine

public subroutine of_regresize ();This.of_SetResize(true)
This.inv_resize.of_SetDWZoom(false)

This.inv_Resize.of_Register(r_Frame,This.inv_Resize.SCALERIGHTBOTTOM)
This.inv_Resize.of_Register(dw_week_calendar,This.inv_Resize.SCALERIGHTBOTTOM)

end subroutine

public subroutine of_refreshfiltername (string as_filtername1, string as_filtername2, string as_filtername3);//====================================================================
// Function: of_refreshfiltername()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    string    as_filtername1
// 	value    string    as_filtername2
// 	value    string    as_filtername3
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

String	ls_Syntax

ls_Syntax = of_GetFilterNameSyntax(as_FilterName1,as_FilterName2,as_FilterName3)

dw_Week_Calendar.Modify(ls_Syntax)

end subroutine

on u_calendar_week.create
int iCurrent
call super::create
this.dw_disp_list_07=create dw_disp_list_07
this.dw_disp_list_06=create dw_disp_list_06
this.dw_disp_list_05=create dw_disp_list_05
this.dw_disp_list_04=create dw_disp_list_04
this.dw_disp_list_03=create dw_disp_list_03
this.dw_disp_list_02=create dw_disp_list_02
this.dw_disp_list_01=create dw_disp_list_01
this.r_frame=create r_frame
this.dw_week_calendar=create dw_week_calendar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_disp_list_07
this.Control[iCurrent+2]=this.dw_disp_list_06
this.Control[iCurrent+3]=this.dw_disp_list_05
this.Control[iCurrent+4]=this.dw_disp_list_04
this.Control[iCurrent+5]=this.dw_disp_list_03
this.Control[iCurrent+6]=this.dw_disp_list_02
this.Control[iCurrent+7]=this.dw_disp_list_01
this.Control[iCurrent+8]=this.r_frame
this.Control[iCurrent+9]=this.dw_week_calendar
end on

on u_calendar_week.destroy
call super::destroy
destroy(this.dw_disp_list_07)
destroy(this.dw_disp_list_06)
destroy(this.dw_disp_list_05)
destroy(this.dw_disp_list_04)
destroy(this.dw_disp_list_03)
destroy(this.dw_disp_list_02)
destroy(this.dw_disp_list_01)
destroy(this.r_frame)
destroy(this.dw_week_calendar)
end on

event constructor;This.BackColor = LOWERBLUE

of_RegResize()

end event

type dw_disp_list_07 from u_dw_calendar_item within u_calendar_week
boolean visible = false
integer x = 3209
integer y = 876
integer width = 297
integer height = 164
integer taborder = 80
boolean vscrollbar = true
boolean border = false
end type

type dw_disp_list_06 from u_dw_calendar_item within u_calendar_week
boolean visible = false
integer x = 2775
integer y = 876
integer width = 297
integer height = 164
integer taborder = 70
boolean vscrollbar = true
boolean border = false
end type

type dw_disp_list_05 from u_dw_calendar_item within u_calendar_week
boolean visible = false
integer x = 2368
integer y = 876
integer width = 297
integer height = 164
integer taborder = 60
boolean vscrollbar = true
boolean border = false
end type

type dw_disp_list_04 from u_dw_calendar_item within u_calendar_week
boolean visible = false
integer x = 1874
integer y = 876
integer width = 297
integer height = 164
integer taborder = 50
boolean vscrollbar = true
boolean border = false
end type

type dw_disp_list_03 from u_dw_calendar_item within u_calendar_week
boolean visible = false
integer x = 1280
integer y = 876
integer width = 297
integer height = 164
integer taborder = 40
boolean vscrollbar = true
boolean border = false
end type

type dw_disp_list_02 from u_dw_calendar_item within u_calendar_week
boolean visible = false
integer x = 699
integer y = 876
integer width = 297
integer height = 164
integer taborder = 30
boolean vscrollbar = true
boolean border = false
end type

type dw_disp_list_01 from u_dw_calendar_item within u_calendar_week
boolean visible = false
integer x = 101
integer y = 876
integer width = 297
integer height = 164
integer taborder = 20
boolean vscrollbar = true
boolean border = false
end type

type r_frame from rectangle within u_calendar_week
long linecolor = 13603685
integer linethickness = 4
long fillcolor = 16765357
integer width = 3625
integer height = 2528
end type

type dw_week_calendar from datawindow within u_calendar_week
integer x = 5
integer y = 4
integer width = 3616
integer height = 2516
integer taborder = 10
string dataobject = "d_week_calendar"
boolean border = false
end type

event clicked;String	ls_ObjName
long		ll_Number

ls_ObjName = dwo.Name

if ls_ObjName = "p_leftarrow" then
	of_Goto_Prev_Week()
elseif ls_ObjName = "p_rightarrow" then
	of_Goto_Next_Week()
elseif Pos(ls_ObjName,ACTIONITEMFILTERNAME) > 0 then
	ll_Number = long(Right(ls_ObjName,1))
	if ll_Number = 0 then
		Parent.GetParent().Dynamic of_GoToActionItemFilter()
	else
		Parent.GetParent().Dynamic of_SetActionItemQuickFilter(ll_Number)
	end if
elseif Pos(Lower(ls_ObjName),Lower(ARRANGEMODE)) > 0 then
	OpenWithParm(w_ArrangeMode,"")
	if Message.StringParm = "OK" then
		Parent.GetParent().Dynamic of_Refresh_Arrange()
		Parent.GetParent().Dynamic of_RefreshSelectScope(0)
	end if
elseif Pos(Lower(ls_ObjName),Lower(WEEKDAYMARK)) > 0 then
	of_PitchOnDate(AREABKMARK + Mid(ls_ObjName,Len(WEEKDAYMARK) + 1))
	Parent.GetParent().Dynamic of_RefreshSelectScope(1)
elseif Pos(Lower(ls_ObjName),Lower(AREABKMARK)) > 0 then
	of_PitchOnDate(ls_ObjName)
end if

end event

event rbuttondown;of_PitchOnDate(dwo.Name)

end event

event doubleclicked;This.Event Clicked(XPos,YPos,row,dwo)

end event

event resize;of_ResetLayout()

end event

