$PBExportHeader$u_meeting_calendar.sru
forward
global type u_meeting_calendar from u_wincalendar
end type
end forward

global type u_meeting_calendar from u_wincalendar
end type
global u_meeting_calendar u_meeting_calendar

type variables
DataStore 	ids_Meeting_day
Boolean		ib_NewAdd

end variables

forward prototypes
public subroutine of_markday (long al_year, long al_month)
public subroutine of_addmeeting (boolean ab_newadd)
end prototypes

public subroutine of_markday (long al_year, long al_month);Date	ldt_FirstDay,ldt_PreMonth,ldt_NextMonth
long	ll_DayNo,ll_StartDay,ll_EndDay,ll_DayCnt,ll_Cycle,ll_Count,ll_Meeting_Day
String ls_modify

//Reset Current Mark
for ll_Cycle = 1 to ROWCOUNT * COLCOUNT
	//dw_cal.Modify(DATEMARKPREFIX + String(ll_Cycle) + ".Visible = 0")
	ls_modify += DATEMARKPREFIX + String(ll_Cycle) + ".Visible = 0" + ' '
next

ldt_FirstDay = Date(al_Year,al_Month,1)
ll_DayNo = DayNumber(ldt_FirstDay)

//Mark Previous Month
ldt_PreMonth = RelativeDate(ldt_FirstDay,-1)
ll_DayCnt = of_Days_In_Month(Year(ldt_PreMonth),Month(ldt_PreMonth))

ll_StartDay = ll_DayCnt - ll_DayNo + 2
ll_EndDay = ll_DayCnt

ll_Count = ids_Meeting_day.Retrieve(Year(ldt_PreMonth),Month(ldt_PreMonth),ll_StartDay,ll_EndDay,gs_user_id)
for ll_Cycle = 1 to ll_Count
	ll_Meeting_Day = ids_Meeting_day.GetItemNumber(ll_Cycle,'Meeting_Day')
	//dw_cal.Modify(DATEMARKPREFIX + String(ll_DayNo - (ll_DayCnt - ll_Meeting_Day) - 1) + ".Visible = 1")
	ls_modify += DATEMARKPREFIX + String(ll_DayNo - (ll_DayCnt - ll_Meeting_Day) - 1) + ".Visible = 1" + ' '
next

//Mark Current Month
ll_StartDay = 1
ll_EndDay = of_Days_In_Month(al_Year,al_Month)
ll_Count = ids_Meeting_day.Retrieve(al_Year,al_Month,ll_StartDay,ll_EndDay,gs_user_id)
for ll_Cycle = 1 to ll_Count
	ll_Meeting_Day = ids_Meeting_day.GetItemNumber(ll_Cycle,'Meeting_Day')
	//dw_cal.Modify(DATEMARKPREFIX + String(ll_DayNo + ll_Meeting_Day - 1) + ".Visible = 1")
	ls_modify += DATEMARKPREFIX + String(ll_DayNo + ll_Meeting_Day - 1) + ".Visible = 1" + ' '
next

//Mark Next Month
ll_DayCnt = of_Days_In_Month(al_Year,al_Month)
ldt_NextMonth = RelativeDate(ldt_FirstDay,ll_DayCnt)
ll_StartDay = 1
ll_EndDay = ROWCOUNT * COLCOUNT - (ll_DayNo + ll_DayCnt) + 1
ll_Count = ids_Meeting_day.Retrieve(Year(ldt_NextMonth),Month(ldt_NextMonth),ll_StartDay,ll_EndDay,gs_user_id)
for ll_Cycle = 1 to ll_Count
	ll_Meeting_Day = ids_Meeting_day.GetItemNumber(ll_Cycle,'Meeting_Day')
	//dw_cal.Modify(DATEMARKPREFIX + String(ll_DayNo + ll_DayCnt + ll_Meeting_Day - 1) + ".Visible = 1")
	ls_modify += DATEMARKPREFIX + String(ll_DayNo + ll_DayCnt + ll_Meeting_Day - 1) + ".Visible = 1" + ' '
next

dw_cal.Modify(ls_modify)
end subroutine

public subroutine of_addmeeting (boolean ab_newadd);ib_NewAdd = ab_NewAdd
end subroutine

on u_meeting_calendar.create
call super::create
end on

on u_meeting_calendar.destroy
call super::destroy
end on

event constructor;call super::constructor;ids_Meeting_day = Create DataStore

ids_Meeting_day.DataObject = "d_meeting_between_days"
ids_Meeting_day.SetTransObject(SQLCA)

end event

event destructor;call super::destructor;if IsValid(ids_Meeting_day) then Destroy ids_Meeting_day
end event

type em_year from u_wincalendar`em_year within u_meeting_calendar
end type

type pb_prev from u_wincalendar`pb_prev within u_meeting_calendar
end type

type pb_next from u_wincalendar`pb_next within u_meeting_calendar
end type

type dw_cal from u_wincalendar`dw_cal within u_meeting_calendar
end type

event dw_cal::doubleclicked;call super::doubleclicked;String	ls_ObjName,ls_Visible
long		ll_Pos,ll_DBClickColNo

if IsNull(dwo) Then Return

ls_ObjName = dwo.Name
ll_Pos = PosA(ls_ObjName,DateCOLMARK)
if ll_Pos <= 0 Then Return

ll_DBClickColNo = long(MidA(ls_ObjName,ll_Pos + LenA(DateCOLMARK)))
if ll_DBClickColNo <= 0  then Return

ls_Visible = dw_Cal.Describe(DATEMARKPREFIX + String(ll_DBClickColNo) + ".Visible")

//Meetings - Main - View Rights, Added by Appeon long.zhang 02.14.2016 (V15.1 Applause Cycle 3 Bug #4988 - Role Admin: Can access meetings via dashboard calendar when user has no access)
IF isvalid(w_mdi) THEN
	IF w_mdi.of_security_access( 340 ) = 0 THEN
		messagebox('Prompt','No access privilege to Meetings.')
		RETURN 0
	END IF
END IF
				
if ls_Visible = '1' then
	OpenWithParm(w_meeting_detail,String(id_SelectedDate))
elseif ib_NewAdd then
	OpenWithParm(w_meeting_detail,"New-" + String(id_SelectedDate))
else
	Return
end if

of_Draw_Month(Year(id_SelectedDate),Month(id_SelectedDate))

end event

