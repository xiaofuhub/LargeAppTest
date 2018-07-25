$PBExportHeader$u_wincalendar.sru
forward
global type u_wincalendar from userobject
end type
type em_year from editmask within u_wincalendar
end type
type pb_prev from picturebutton within u_wincalendar
end type
type pb_next from picturebutton within u_wincalendar
end type
type dw_cal from datawindow within u_wincalendar
end type
end forward

global type u_wincalendar from userobject
integer width = 1230
integer height = 688
long backcolor = 32768
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event resize pbm_size
event ue_resize ( )
event ue_ini ( )
em_year em_year
pb_prev pb_prev
pb_next pb_next
dw_cal dw_cal
end type
global u_wincalendar u_wincalendar

type variables
Int 		ii_Year,ii_Month,ii_Day
long		ii_OldColNo
String 	is_MonthFormat = "MMMM YYYY"
String 	is_DateFormat = "YYYY/MM/DD"
Date 		id_SelectedDate
Double	id_HerScale = 1
Double 	id_VerScale = 1

long		il_UOWidth
long		il_UOHeight

String	is_Month[] = {"January","February","March","April","May","June","July","August","September","October","November","December"}
String	is_Week[] = {"Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"}

CONSTANT LONG TRANSPARENTCOLOR = 553648127
CONSTANT LONG ACTIVETITLEBARCOLOR = 134217730
CONSTANT LONG GRAYCOLOR = 8421504
CONSTANT LONG WHITECOLOR = RGB(255,255,255)
CONSTANT LONG BLACKCOLOR = RGB(0,0,0)

CONSTANT LONG YEARINITX = 610//622

CONSTANT LONG DATEINITX = 14
CONSTANT LONG DATEINITY = 200
CONSTANT LONG DATEWIDTH = 160
CONSTANT LONG DATEHEIGHT = 52
CONSTANT LONG DATEHORISPACE = 13
CONSTANT LONG DATEVERTISPACE = 12

CONSTANT LONG LINETHICK = 4

CONSTANT LONG MARKWIDTH = 32
CONSTANT LONG MARKHEIGHT = 48

CONSTANT LONG ROWCOUNT = 6
CONSTANT LONG COLCOUNT = 7

CONSTANT STRING DAYNUMMARK = "WeekDay"
CONSTANT STRING DATECOLMARK = "cell"
CONSTANT STRING DATEMARKPREFIX = "mark"
CONSTANT STRING DATEMARKTEXT = "*"
CONSTANT STRING TODAYTEXTPREFIX = "Today: "

m_month 	im_Month
Window	iw_Parent

end variables

forward prototypes
public function long of_prev_month_days (long al_year, long al_month)
public subroutine of_prev_year ()
public subroutine of_prev_month ()
public subroutine of_next_year ()
public subroutine of_next_month ()
public function long of_setcolor (long al_colno, long al_textcolor, long al_bkmode, long al_bkcolor)
public subroutine of_moverectline (long al_xpos, long al_ypos)
public subroutine of_set_date_format (string as_date_format)
public subroutine of_draw_today ()
public subroutine of_draw_month (integer year, integer month)
public function integer of_days_in_month (integer al_year, integer al_month)
public subroutine of_enter_day_numbers (integer ai_start_day_num, integer ai_days_in_month)
public function integer of_get_month_number (string as_month)
public subroutine of_highlight_column (long al_colno)
public subroutine of_unhighlight_column (long al_colno)
public function long of_getyear ()
public function long of_getmonth ()
public subroutine of_set_month_format (string as_date_format)
public subroutine of_setuobkcolor (long al_bkcolor)
public subroutine of_setdwbkcolor (long al_bkcolor)
public subroutine of_markday (long al_year, long al_month)
public subroutine of_getparentwindow ()
public subroutine of_saveinitpos ()
public subroutine of_getproperties (string as_tag, ref long al_parm1, ref long al_parm2, ref long al_parm3, ref long al_parm4)
public subroutine of_adjustsize ()
end prototypes

event ue_resize();//id_HerScale = Double(This.width)/il_UOWidth
//id_VerScale = Double(This.height)/il_UOHeight
//of_AdjustSize()
end event

event ue_ini();long		ll_RowNo,ll_ColNo,ll_Day
long		ll_ColXPos,ll_ColYPos,ll_MarkXPos,ll_MarkYPos
String	ls_ColName,ls_MarkName
String 	ls_modify

for ll_RowNo = 1 to ROWCOUNT
	for ll_ColNo = 1 to COLCOUNT
		if ll_RowNo = 1 then dw_cal.Modify(DAYNUMMARK + String(ll_ColNo) + ".Text = '" + LeftA(is_Week[ll_ColNo],3) + "'")
		
		ll_Day = (ll_RowNo - 1) * COLCOUNT + ll_ColNo
		ls_ColName = DATECOLMARK + String(ll_Day)
		ls_MarkName = DATEMARKPREFIX + String(ll_Day)
		
		ll_ColXPos = DATEINITX + (ll_ColNo - 1) * (DATEWIDTH + DATEHORISPACE)
		ll_ColYPos = DATEINITY + (ll_RowNo - 1) * (DATEHEIGHT + DATEVERTISPACE)
		/*	
		dw_cal.Modify(ls_ColName + ".X = " + String(ll_ColXPos))
		dw_cal.Modify(ls_ColName + ".Y = " + String(ll_ColYPos))
		*/
		ll_MarkXPos = ll_ColXPos + DATEWIDTH - MARKWIDTH * 3 / 2
		ll_MarkYPos = ll_ColYPos + DATEHEIGHT/2 - MARKHEIGHT
		/*
		dw_cal.Modify(ls_MarkName + ".Visible = 0")
		dw_cal.Modify(ls_MarkName + ".Text = '" + DATEMARKTEXT + "'")
		dw_cal.Modify(ls_MarkName + ".X = " + String(ll_MarkXPos))
		dw_cal.Modify(ls_MarkName + ".Y = " + String(ll_MarkYPos))
		dw_cal.Modify(ls_MarkName + ".Width = " + String(MARKWIDTH))
		dw_cal.Modify(ls_MarkName + ".Height = " + String(MARKHEIGHT))
		*/
		//ls_modify +=	//ls_ColName + ".X = " + String(ll_ColXPos) + ' ' + & 
							//ls_ColName + ".Y = " + String(ll_ColYPos) + ' ' + &
		ls_modify +=					ls_MarkName + ".Visible = 0" + ' ' + &
							ls_MarkName + ".Text = '" + DATEMARKTEXT + "'" + ' ' + & 
							ls_MarkName + ".X = " + String(ll_MarkXPos) + ' ' + & 
							ls_MarkName + ".Y = " + String(ll_MarkYPos) + ' ' + & 
							ls_MarkName + ".Width = " + String(MARKWIDTH) + ' ' + & 
							ls_MarkName + ".Height = " + String(MARKHEIGHT) + ' ' 
	next
next

dw_cal.Modify(ls_modify)

//of_SaveInitPos()

of_Draw_Today()

end event

public function long of_prev_month_days (long al_year, long al_month);long	ll_Days

al_Month --
if al_Month = 0 then
	al_Month = 12
	al_Year --
end if

ll_Days = of_Days_In_Month(al_Year,al_Month)

Return ll_Days

end function

public subroutine of_prev_year ();long li_DaysInMonth

ii_Year --

li_DaysInMonth = of_Days_in_Month(ii_Year,ii_Month)
if ii_day > li_DaysInMonth then ii_day = li_DaysInMonth

id_SelectedDate = Date(ii_Year,ii_Month,ii_Day)

end subroutine

public subroutine of_prev_month ();long li_DaysInMonth

ii_Month --
If ii_Month = 0 then
	ii_Month = 12
	ii_Year --
End If

li_DaysInMonth = of_Days_in_Month(ii_Year,ii_Month)
if ii_day > li_DaysInMonth then ii_day = li_DaysInMonth

id_SelectedDate = Date(ii_Year,ii_Month,ii_Day)

end subroutine

public subroutine of_next_year ();long li_DaysInMonth

ii_Year ++

li_DaysInMonth = of_Days_in_Month(ii_Year,ii_Month)
if ii_day > li_DaysInMonth then ii_day = li_DaysInMonth

id_SelectedDate = Date(ii_Year,ii_Month,ii_Day)

end subroutine

public subroutine of_next_month ();long li_DaysInMonth

ii_Month ++
If ii_Month = 13 then
	ii_Month = 1
	ii_Year ++
End If

li_DaysInMonth = of_Days_in_Month(ii_Year,ii_Month)
if ii_day > li_DaysInMonth then ii_day = li_DaysInMonth

id_SelectedDate = Date(ii_Year,ii_Month,ii_Day)

end subroutine

public function long of_setcolor (long al_colno, long al_textcolor, long al_bkmode, long al_bkcolor);String ls_ModiExp,ls_BkMode,ls_BkColor,ls_TextColor
String ls_ColName,ls_MarkName,ls_Error

if al_ColNo <= 0 or al_ColNo > ROWCOUNT * COLCOUNT then Return -1

ls_ColName = DATECOLMARK + String(al_ColNo)
ls_MarkName = DATEMARKPREFIX + String(al_ColNo)

ls_TextColor = ".Color = " + String(al_TextColor) + "~t"
ls_BkMode = ".Background.Mode = " + String(al_BkMode) + "~t"
ls_BkColor = ".Background.Color = " + String(al_BkColor) + "~t"

ls_ModiExp = ls_ColName + ls_TextColor + ls_ColName + ls_BkMode + ls_ColName + ls_BkColor + ls_MarkName + ls_TextColor
ls_Error = dw_cal.Modify(ls_ModiExp)

if Trim(ls_Error) <> '' then
	MessageBox(ls_Error,ls_ModiExp)
end if

Return 1

end function

public subroutine of_moverectline (long al_xpos, long al_ypos);long	ll_LineWidth,ll_LineHeight
String ls_modify

ll_LineWidth = long(DATEWIDTH * id_HerScale + 2 * LINETHICK)
ll_LineHeight = long(DATEHEIGHT * id_VerScale + 2 * LINETHICK)

al_XPos = al_XPos - LINETHICK
al_YPos = al_YPos - LINETHICK
/*
dw_Cal.Modify("ln_Left.X1 = " + String(al_XPos))
dw_Cal.Modify("ln_Left.X2 = " + String(al_XPos))
dw_Cal.Modify("ln_Left.Y1 = " + String(al_YPos))
dw_Cal.Modify("ln_Left.Y2 = " + String(al_YPos + ll_LineHeight))

dw_Cal.Modify("ln_Up.X1 = " + String(al_XPos))
dw_Cal.Modify("ln_Up.X2 = " + String(al_XPos + ll_LineWidth))
dw_Cal.Modify("ln_Up.Y1 = " + String(al_YPos))
dw_Cal.Modify("ln_Up.Y2 = " + String(al_YPos))

dw_Cal.Modify("ln_Right.X1 = " + String(al_XPos + ll_LineWidth - LINETHICK))
dw_Cal.Modify("ln_Right.X2 = " + String(al_XPos + ll_LineWidth - LINETHICK))
dw_Cal.Modify("ln_Right.Y1 = " + String(al_YPos))
dw_Cal.Modify("ln_Right.Y2 = " + String(al_YPos + ll_LineHeight))

dw_Cal.Modify("ln_Down.X1 = " + String(al_XPos))
dw_Cal.Modify("ln_Down.X2 = " + String(al_XPos + ll_LineWidth))
dw_Cal.Modify("ln_Down.Y1 = " + String(al_YPos + ll_LineHeight - LINETHICK))
dw_Cal.Modify("ln_Down.Y2 = " + String(al_YPos + ll_LineHeight - LINETHICK))
*/
ls_modify = "ln_Left.X1 = " + String(al_XPos) + ' ' + &
				"ln_Left.X2 = " + String(al_XPos) + ' ' + &
				"ln_Left.Y1 = " + String(al_YPos) + ' ' + &
				"ln_Left.Y2 = " + String(al_YPos + ll_LineHeight) + ' ' + &
				"ln_Up.X1 = " + String(al_XPos) + ' ' + &
				"ln_Up.X2 = " + String(al_XPos + ll_LineWidth) + ' ' + &
				"ln_Up.Y1 = " + String(al_YPos) + ' ' + &
				"ln_Up.Y2 = " + String(al_YPos) + ' ' + &
				"ln_Right.X1 = " + String(al_XPos + ll_LineWidth - LINETHICK) + ' ' + &
				"ln_Right.X2 = " + String(al_XPos + ll_LineWidth - LINETHICK) + ' ' + &
				"ln_Right.Y1 = " + String(al_YPos) + ' ' + &
				"ln_Right.Y2 = " + String(al_YPos + ll_LineHeight) + ' ' + &
				"ln_Down.X1 = " + String(al_XPos) + ' ' + &
				"ln_Down.X2 = " + String(al_XPos + ll_LineWidth) + ' ' + &
				"ln_Down.Y1 = " + String(al_YPos + ll_LineHeight - LINETHICK) + ' ' + &
				"ln_Down.Y2 = " + String(al_YPos + ll_LineHeight - LINETHICK) 
				
dw_Cal.Modify(ls_modify)				
end subroutine

public subroutine of_set_date_format (string as_date_format);is_DateFormat = as_Date_Format

If Not IsNull(id_SelectedDate) then
	dw_Cal.Modify("Today_t.text = '" + TODAYTEXTPREFIX + String(Today(),is_DateFormat) + "'")
End If

end subroutine

public subroutine of_draw_today ();id_SelectedDate = today()

ii_Year = Year(id_SelectedDate)
ii_Month = Month(id_SelectedDate)
ii_Day = Day(id_SelectedDate)

of_Draw_Month(ii_Year,ii_Month)

end subroutine

public subroutine of_draw_month (integer year, integer month);long		ll_FirstDayNum,ll_NewColNo,ll_DaysInMonth

SetRedraw(dw_cal,FALSE)

ii_Year = Year
ii_Month = Month

ll_DaysInMonth = of_Days_in_Month(ii_Year,ii_Month)
if ii_day > ll_DaysInMonth then ii_day = ll_DaysInMonth

ll_FirstDayNum = DayNumber(Date(ii_Year,ii_Month,1))

of_Enter_Day_Numbers(ll_FirstDayNum,ll_DaysInMonth)
of_MarkDay(ii_Year,ii_Month)

ll_NewColNo = ll_FirstDayNum + ii_day - 1
of_highlight_column(ll_NewColNo)
ii_OldColNo = ll_NewColNo

dw_cal.SetRedraw(TRUE)

end subroutine

public function integer of_days_in_month (integer al_year, integer al_month);long	ll_Days[12] = {31,28,31,30,31,30,31,31,30,31,30,31}

if Mod(al_Year,4) = 0 and Mod(al_Year,100) <> 0 or Mod(al_Year,400) = 0 then ll_Days[2] = 29

Return ll_Days[al_Month]

end function

public subroutine of_enter_day_numbers (integer ai_start_day_num, integer ai_days_in_month);long		ll_Cycle, ll_DayCount, ll_PreMonthDayCnt,ll_XPos,ll_YPos,ll_Visible
String ls_modify 
em_Year.Text = String(ii_Year)

/*
dw_Cal.Modify("st_Month.text = '" + String(Date(ii_Year,ii_Month,ii_Day),is_MonthFormat) + "'")
dw_Cal.Modify("Today_t.text = '" + TODAYTEXTPREFIX + String(Today(),is_DateFormat) + "'")
*/
ls_modify = "st_Month.text = '" + String(Date(ii_Year,ii_Month,ii_Day),is_MonthFormat) + "'" + ' ' + &
				"Today_t.text = '" + TODAYTEXTPREFIX + String(Today(),is_DateFormat) + "'"	 + ' '
				
ll_PreMonthDayCnt = of_Prev_Month_Days(ii_Year,ii_Month)
For ll_Cycle = ai_Start_Day_Num - 1 to 1 Step -1
	dw_cal.SetItem(1,DATECOLMARK + String(ll_Cycle),String(ll_PreMonthDayCnt + ll_Cycle - ai_Start_Day_Num + 1))
	of_SetColor(ll_Cycle,GRAYCOLOR,2,TRANSPARENTCOLOR)
Next

if ii_Year = Year(Today()) and ii_Month = Month(Today()) then ll_Visible = 1
/*
dw_Cal.Modify("ln_Left.Visible = " + String(ll_Visible))
dw_Cal.Modify("ln_Up.Visible = " + String(ll_Visible))
dw_Cal.Modify("ln_Right.Visible = " + String(ll_Visible))
dw_Cal.Modify("ln_Down.Visible = " + String(ll_Visible))
*/
ls_modify +=	"ln_Left.Visible = " + String(ll_Visible) + ' ' + &
					"ln_Up.Visible = " + String(ll_Visible) + ' ' + &
					"ln_Right.Visible = " + String(ll_Visible) + ' ' + &
					"ln_Down.Visible = " + String(ll_Visible) + ' '
dw_Cal.Modify(ls_modify)		

For ll_Cycle = 1 to ai_Days_In_Month
	dw_cal.SetItem(1,DATECOLMARK + String(ai_Start_Day_Num + ll_Cycle - 1),String(ll_Cycle))
	of_SetColor(ai_Start_Day_Num + ll_Cycle - 1,BLACKCOLOR,2,TRANSPARENTCOLOR)
	
	if Date(ii_Year,ii_Month,ll_Cycle) = Date(Today()) then
		ll_XPos = long(dw_cal.Describe(DATECOLMARK + String(ai_Start_Day_Num + ll_Cycle - 1) + ".X"))
		ll_YPos = long(dw_cal.Describe(DATECOLMARK + String(ai_Start_Day_Num + ll_Cycle - 1) + ".Y"))
		of_MoveRectLine(ll_XPos,ll_YPos)
	end if
Next

For ll_Cycle = ai_Start_Day_Num + ai_Days_In_Month to ROWCOUNT * COLCOUNT
	dw_cal.SetItem(1,DATECOLMARK + String(ll_Cycle),String(ll_Cycle - ai_Start_Day_Num - ai_Days_In_Month + 1))
	of_SetColor(ll_Cycle,GRAYCOLOR,2,TRANSPARENTCOLOR)
Next

dw_cal.AcceptText()

end subroutine

public function integer of_get_month_number (string as_month);long	ll_Cycle

for ll_Cycle = 1 to UpperBound(is_Month)
	if Lower(LeftA(is_Month[ll_Cycle],3)) = Lower(LeftA(as_Month,3)) then Exit
next

Return ll_Cycle

end function

public subroutine of_highlight_column (long al_colno);of_SetColor(al_ColNo,WHITECOLOR,2,ACTIVETITLEBARCOLOR)

end subroutine

public subroutine of_unhighlight_column (long al_colno);of_SetColor(al_ColNo,BLACKCOLOR,2,TRANSPARENTCOLOR)

end subroutine

public function long of_getyear ();Return ii_Year

end function

public function long of_getmonth ();Return ii_Month
end function

public subroutine of_set_month_format (string as_date_format);is_MonthFormat = as_Date_Format

If Not IsNull(id_SelectedDate) then
	dw_Cal.Modify("st_Month.text = '" + String(id_SelectedDate,is_MonthFormat) + "'")
End If

end subroutine

public subroutine of_setuobkcolor (long al_bkcolor);This.BackColor = al_BkColor
end subroutine

public subroutine of_setdwbkcolor (long al_bkcolor);dw_Cal.Modify("DataWindow.Color = " + String(al_BkColor))

end subroutine

public subroutine of_markday (long al_year, long al_month);
end subroutine

public subroutine of_getparentwindow ();PowerObject	lpo_Parent

lpo_Parent = this.GetParent()
do while IsValid(lpo_Parent) and lpo_Parent.TypeOf() <> window!
	lpo_Parent = lpo_Parent.GetParent()
loop

if Not IsValid(lpo_Parent) then
	SetNull(iw_Parent)
else
	iw_Parent = lpo_Parent
end if

end subroutine

public subroutine of_saveinitpos ();String	ls_InitX,ls_InitWidth,ls_InitX1,ls_InitX2
String	ls_InitY,ls_InitHeight,ls_InitY1,ls_InitY2
String	ls_Objects,ls_ObjName,ls_ObjType,ls_ModifyExp,ls_Tag
long		ll_Pos

CONSTANT STRING TABCHAR = "~t"

ls_Objects = dw_Cal.Describe("DataWindow.Objects") + TABCHAR

ll_Pos = PosA(ls_Objects,TABCHAR)
do while ll_Pos > 0
	ls_ObjName = LeftA(ls_Objects,ll_Pos - 1)
	ls_Objects = MidA(ls_Objects,ll_Pos + 1)
	ll_Pos = PosA(ls_Objects,TABCHAR)
	
	ls_ObjType = dw_Cal.Describe(ls_ObjName + ".Type")
	Choose Case ls_ObjType
		Case 'column','text'			//X,Y,Width,Height
			ls_InitX = dw_Cal.Describe(ls_ObjName + ".X")
			ls_InitY = dw_Cal.Describe(ls_ObjName + ".Y")
			ls_InitWidth = dw_Cal.Describe(ls_ObjName + ".Width")
			ls_InitHeight = dw_Cal.Describe(ls_ObjName + ".Height")
			
			ls_Tag = ls_InitX + "," + ls_InitY + "," + ls_InitWidth + "," + ls_InitHeight
			
			ls_ModifyExp += ls_ObjName + ".Tag = '" + ls_Tag + "'" + TABCHAR
		Case 'line'						//X1,Y1,X2,Y2
				ls_InitX1 = dw_Cal.Describe(ls_ObjName + ".X1")
				ls_InitY1 = dw_Cal.Describe(ls_ObjName + ".Y1")
				ls_InitX2 = dw_Cal.Describe(ls_ObjName + ".X2")
				ls_InitY2 = dw_Cal.Describe(ls_ObjName + ".Y2")
				
				ls_Tag = ls_InitX1 + "," + ls_InitY1 + "," + ls_InitX2 + "," + ls_InitY2
				
				ls_ModifyExp += ls_ObjName + ".Tag = '" + ls_Tag + "'" + TABCHAR
		Case else
			
	End Choose
loop

dw_Cal.Modify(ls_ModifyExp)

dw_Cal.Tag = String(dw_Cal.X) + "," + String(dw_Cal.Y) + "," + String(dw_Cal.Width) + "," + String(dw_Cal.Height)
pb_Prev.Tag = String(pb_Prev.X) + "," + String(pb_Prev.Y) + "," + String(pb_Prev.Width) + "," + String(pb_Prev.Height)
pb_Next.Tag = String(pb_Next.X) + "," + String(pb_Next.Y) + "," + String(pb_Next.Width) + "," + String(pb_Next.Height)
Em_year.Tag = String(Em_year.X) + "," + String(Em_year.Y) + "," + String(Em_year.Width) + "," + String(Em_year.Height)

end subroutine

public subroutine of_getproperties (string as_tag, ref long al_parm1, ref long al_parm2, ref long al_parm3, ref long al_parm4);long	ll_Pos

ll_Pos = PosA(as_Tag,",")
al_Parm1 = long(LeftA(as_Tag,ll_Pos - 1))
as_Tag = MidA(as_Tag,ll_Pos + 1)

ll_Pos = PosA(as_Tag,",")
al_Parm2 = long(LeftA(as_Tag,ll_Pos - 1))
as_Tag = MidA(as_Tag,ll_Pos + 1)

ll_Pos = PosA(as_Tag,",")
al_Parm3 = long(LeftA(as_Tag,ll_Pos - 1))
as_Tag = MidA(as_Tag,ll_Pos + 1)

al_Parm4 = long(as_Tag)

end subroutine

public subroutine of_adjustsize ();long		ll_Cycle,ll_Cnts,ll_Pos
long		ll_InitX,ll_NewX,ll_InitWidth,ll_NewWidth,ll_OriX1,ll_OriX2,ll_CurX1,ll_CurX2
long		ll_InitY,ll_NewY,ll_InitHeight,ll_NewHeight,ll_OriY1,ll_OriY2,ll_CurY1,ll_CurY2
String	ls_Objects,ls_ObjName,ls_ObjType,ls_ModifyExp,ls_Tag

CONSTANT STRING TABCHAR = "~t"

SetRedraw(false)

of_GetProperties(dw_Cal.Tag,ll_InitX,ll_InitY,ll_InitWidth,ll_InitHeight)
dw_Cal.X = long(ll_InitX * id_HerScale)
dw_Cal.Y = long(ll_InitY * id_VerScale)
dw_Cal.Width = long(ll_InitWidth * id_HerScale)
dw_Cal.Height = long(ll_InitHeight * id_VerScale)

ls_ModifyExp = "DataWindow.Header.Height = " + String(long(ll_InitHeight * id_VerScale)) + TABCHAR

of_GetProperties(pb_Prev.Tag,ll_InitX,ll_InitY,ll_InitWidth,ll_InitHeight)
pb_Prev.X = long(ll_InitX * id_HerScale)
pb_Prev.Y = long(ll_InitY * id_VerScale)
pb_Prev.Width = long(ll_InitWidth * id_HerScale)
pb_Prev.Height = long(ll_InitHeight * id_VerScale)

of_GetProperties(pb_Next.Tag,ll_InitX,ll_InitY,ll_InitWidth,ll_InitHeight)
pb_Next.X = long(ll_InitX * id_HerScale)
pb_Next.Y = long(ll_InitY * id_VerScale)
pb_Next.Width = long(ll_InitWidth * id_HerScale)
pb_Next.Height = long(ll_InitHeight * id_VerScale)

of_GetProperties(Em_year.Tag,ll_InitX,ll_InitY,ll_InitWidth,ll_InitHeight)
Em_year.X = long(ll_InitX * id_HerScale)
Em_year.Y = long(ll_InitY * id_VerScale)

ls_Objects = dw_Cal.Describe("DataWindow.Objects") + TABCHAR

ll_Pos = PosA(ls_Objects,TABCHAR)
do while ll_Pos > 0
	ls_ObjName = LeftA(ls_Objects,ll_Pos - 1)
	ls_Objects = MidA(ls_Objects,ll_Pos + 1)
	ll_Pos = PosA(ls_Objects,TABCHAR)
	
	ls_ObjType = dw_Cal.Describe(ls_ObjName + ".Type")
	Choose Case ls_ObjType
		Case 'column','text'
			ls_Tag = dw_Cal.Describe(ls_ObjName + ".Tag")
			of_GetProperties(ls_Tag,ll_InitX,ll_InitY,ll_InitWidth,ll_InitHeight)
			
			ll_NewX = long(ll_InitX * id_HerScale)
			ls_ModifyExp += ls_ObjName + ".X = " + String(ll_NewX) + TABCHAR
			
			ll_NewY = long(ll_InitY * id_VerScale)
			ls_ModifyExp += ls_ObjName + ".Y = " + String(ll_NewY) + TABCHAR
			
			ll_NewWidth = long(ll_InitWidth * id_HerScale)
			ls_ModifyExp += ls_ObjName + ".Width = " + String(ll_NewWidth) + TABCHAR
			
			ll_NewHeight = long(ll_InitHeight * id_VerScale)
			ls_ModifyExp += ls_ObjName + ".Height = " + String(ll_NewHeight) + TABCHAR
		Case 'line'
			ls_Tag = dw_Cal.Describe(ls_ObjName + ".Tag")
			of_GetProperties(ls_Tag,ll_OriX1,ll_OriY1,ll_OriX2,ll_OriY2)
			
			ll_CurX1 = long(ll_OriX1 * id_HerScale)
			ls_ModifyExp += ls_ObjName + ".X1 = " + String(ll_CurX1)  + TABCHAR
			
			ll_CurY1 = long(ll_OriY1 * id_VerScale)
			ls_ModifyExp += ls_ObjName + ".Y1 = " + String(ll_CurY1)  + TABCHAR
			
			ll_CurX2 = long(ll_OriX2 * id_HerScale)
			ls_ModifyExp += ls_ObjName + ".X2 = " + String(ll_CurX2) + TABCHAR
			
			ll_CurY2 = long(ll_OriY2 * id_VerScale)
			ls_ModifyExp += ls_ObjName + ".Y2 = " + String(ll_CurY2) + TABCHAR
		Case else
			
	End Choose
loop

dw_Cal.Modify(ls_ModifyExp)

of_Draw_Month(ii_year,ii_month)

SetRedraw(true)

end subroutine

on u_wincalendar.create
this.em_year=create em_year
this.pb_prev=create pb_prev
this.pb_next=create pb_next
this.dw_cal=create dw_cal
this.Control[]={this.em_year,&
this.pb_prev,&
this.pb_next,&
this.dw_cal}
end on

on u_wincalendar.destroy
destroy(this.em_year)
destroy(this.pb_prev)
destroy(this.pb_next)
destroy(this.dw_cal)
end on

event constructor;long	ll_Cycle,ll_ItemCnts

of_GetParentWindow()

im_Month = Create m_Month
im_Month.iu_CusCal = this

ll_ItemCnts = UpperBound(im_Month.Item[])
for ll_Cycle = 1 to ll_ItemCnts
	im_Month.Item[ll_Cycle].Text = is_Month[ll_Cycle]
next

il_UOWidth = This.Width
il_UOHeight = This.Height

end event

event destructor;if IsValid(im_Month) then Destroy im_Month

end event

type em_year from editmask within u_wincalendar
event ue_change pbm_enchange
boolean visible = false
integer x = 622
integer y = 20
integer width = 224
integer height = 76
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
string mask = "0000"
boolean spin = true
double increment = 1
string minmax = "1111~~9999"
end type

event ue_change;long		ll_Year

ll_Year = long(This.Text)
if ll_Year <= 0 then Return

of_Draw_Month(ll_Year,ii_Month)

end event

event losefocus;em_Year.Visible = false

end event

type pb_prev from picturebutton within u_wincalendar
event ue_doubleclick pbm_bndoubleclicked
integer x = 27
integer y = 28
integer width = 96
integer height = 68
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string picturename = "VCRPrior!"
alignment htextalign = left!
boolean map3dcolors = true
end type

event ue_doubleclick;of_Prev_Month()

of_Draw_Month(ii_Year,ii_Month)

end event

event clicked;of_Prev_Month()

of_Draw_Month(ii_Year,ii_Month)

end event

type pb_next from picturebutton within u_wincalendar
event ue_doubleclick pbm_bndoubleclicked
integer x = 1102
integer y = 28
integer width = 96
integer height = 68
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string picturename = "VCRNext!"
alignment htextalign = left!
boolean map3dcolors = true
end type

event ue_doubleclick;of_Next_Month()

of_Draw_Month(ii_year,ii_month)

end event

event clicked;of_Next_Month()

of_Draw_Month(ii_year,ii_month)

end event

type dw_cal from datawindow within u_wincalendar
integer width = 1230
integer height = 688
integer taborder = 10
string title = "none"
string dataobject = "d_wincalendar"
boolean livescroll = true
end type

event clicked;long		ll_Pos,ll_NewColNo,ll_FirstDayNum,ll_DaysInMonth,ll_XPos,ll_YPos,ll_Length
String 	ls_ObjName

If IsNull(dwo) Then Return

ls_ObjName = dwo.Name
if ls_ObjName = Lower("RectangleFrame_t") or ls_ObjName = Lower("Today_t") then
	of_Draw_Today()
elseif ls_ObjName = Lower("st_Month") then
	ll_XPos = PixelsToUnits(XPos,XPixelsToUnits!)
	ll_YPos = PixelsToUnits(YPos,YPixelsToUnits!)
	if ll_XPos <= long(dw_Cal.Describe(ls_ObjName + ".X")) + long(dw_Cal.Describe(ls_ObjName + ".Width"))/2 then
		if IsValid(iw_Parent) then im_Month.PopMenu(iw_Parent.PointerX(),iw_Parent.PointerY())
	else
		ll_Length = LenA(is_Month[ii_Month])
		if ii_Month = 4 then ll_Length --					//April
		em_Year.X = long(YEARINITX * id_HerScale) + (ll_Length - 6) * 15
		
		em_Year.Visible = true
		em_Year.SetFocus()
	end if
end if

ll_Pos = PosA(ls_ObjName,DateCOLMARK)
If ll_Pos <= 0 Then Return

ll_NewColNo = long(MidA(ls_ObjName,ll_Pos + LenA(DateCOLMARK)))
if ll_NewColNo <= 0  then Return

ii_day = long(This.GetItemString(1,ls_ObjName))

ll_FirstDayNum = DayNumber(Date(ii_year,ii_month,1))
ll_DaysInMonth = of_Days_in_Month(ii_Year,ii_Month)

if ll_NewColNo < ll_FirstDayNum then
	of_Prev_Month()
	of_Draw_Month(ii_Year,ii_Month)
elseif ll_NewColNo > ll_FirstDayNum + ll_DaysInMonth - 1 then
	of_Next_Month()
	of_Draw_Month(ii_Year,ii_Month)
else
	of_unhighlight_column(ii_OldColNo)
	of_highlight_column(ll_NewColNo)
	ii_OldColNo = ll_NewColNo
	id_SelectedDate = Date(ii_year,ii_month,ii_Day)
end if

end event

event constructor;//long		ll_RowNo,ll_ColNo,ll_Day
//long		ll_ColXPos,ll_ColYPos,ll_MarkXPos,ll_MarkYPos
//String	ls_ColName,ls_MarkName
//String 	ls_modify
//
//for ll_RowNo = 1 to ROWCOUNT
//	for ll_ColNo = 1 to COLCOUNT
//		if ll_RowNo = 1 then This.Modify(DAYNUMMARK + String(ll_ColNo) + ".Text = '" + Left(is_Week[ll_ColNo],3) + "'")
//		
//		ll_Day = (ll_RowNo - 1) * COLCOUNT + ll_ColNo
//		ls_ColName = DATECOLMARK + String(ll_Day)
//		ls_MarkName = DATEMARKPREFIX + String(ll_Day)
//		
//		ll_ColXPos = DATEINITX + (ll_ColNo - 1) * (DATEWIDTH + DATEHORISPACE)
//		ll_ColYPos = DATEINITY + (ll_RowNo - 1) * (DATEHEIGHT + DATEVERTISPACE)
//		/*	
//		This.Modify(ls_ColName + ".X = " + String(ll_ColXPos))
//		This.Modify(ls_ColName + ".Y = " + String(ll_ColYPos))
//		*/
//		ll_MarkXPos = ll_ColXPos + DATEWIDTH - MARKWIDTH * 3 / 2
//		ll_MarkYPos = ll_ColYPos + DATEHEIGHT/2 - MARKHEIGHT
//		/*
//		This.Modify(ls_MarkName + ".Visible = 0")
//		This.Modify(ls_MarkName + ".Text = '" + DATEMARKTEXT + "'")
//		This.Modify(ls_MarkName + ".X = " + String(ll_MarkXPos))
//		This.Modify(ls_MarkName + ".Y = " + String(ll_MarkYPos))
//		This.Modify(ls_MarkName + ".Width = " + String(MARKWIDTH))
//		This.Modify(ls_MarkName + ".Height = " + String(MARKHEIGHT))
//		*/
//		ls_modify +=	ls_ColName + ".X = " + String(ll_ColXPos) + ' ' + & 
//							ls_ColName + ".Y = " + String(ll_ColYPos) + ' ' + &
//							ls_MarkName + ".Visible = 0" + ' ' + &
//							ls_MarkName + ".Text = '" + DATEMARKTEXT + "'" + ' ' + & 
//							ls_MarkName + ".X = " + String(ll_MarkXPos) + ' ' + & 
//							ls_MarkName + ".Y = " + String(ll_MarkYPos) + ' ' + & 
//							ls_MarkName + ".Width = " + String(MARKWIDTH) + ' ' + & 
//							ls_MarkName + ".Height = " + String(MARKHEIGHT) + ' ' 
//	next
//next
//
//This.Modify(ls_modify)
//
//of_SaveInitPos()
//
//of_Draw_Today()
//
end event

