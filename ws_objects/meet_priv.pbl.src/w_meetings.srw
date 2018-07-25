$PBExportHeader$w_meetings.srw
forward
global type w_meetings from w_sheet
end type
type cb_today from commandbutton within w_meetings
end type
type p_pmonth from picture within w_meetings
end type
type p_nmonth from picture within w_meetings
end type
type p_nyear from picture within w_meetings
end type
type p_pyear from picture within w_meetings
end type
type cb_close from commandbutton within w_meetings
end type
type cb_1 from commandbutton within w_meetings
end type
type dw_1 from pfc_cst_u_calendar_dw within w_meetings
end type
type dw_2 from pfc_cst_u_calendar_dw within w_meetings
end type
type dw_3 from pfc_cst_u_calendar_dw within w_meetings
end type
type dw_4 from pfc_cst_u_calendar_dw within w_meetings
end type
type dw_5 from pfc_cst_u_calendar_dw within w_meetings
end type
type dw_6 from pfc_cst_u_calendar_dw within w_meetings
end type
type dw_7 from pfc_cst_u_calendar_dw within w_meetings
end type
type dw_8 from pfc_cst_u_calendar_dw within w_meetings
end type
type dw_9 from pfc_cst_u_calendar_dw within w_meetings
end type
type dw_10 from pfc_cst_u_calendar_dw within w_meetings
end type
type dw_11 from pfc_cst_u_calendar_dw within w_meetings
end type
type dw_12 from pfc_cst_u_calendar_dw within w_meetings
end type
type dw_13 from pfc_cst_u_calendar_dw within w_meetings
end type
type dw_14 from pfc_cst_u_calendar_dw within w_meetings
end type
type dw_15 from pfc_cst_u_calendar_dw within w_meetings
end type
type dw_16 from pfc_cst_u_calendar_dw within w_meetings
end type
type dw_17 from pfc_cst_u_calendar_dw within w_meetings
end type
type dw_18 from pfc_cst_u_calendar_dw within w_meetings
end type
type dw_19 from pfc_cst_u_calendar_dw within w_meetings
end type
type dw_20 from pfc_cst_u_calendar_dw within w_meetings
end type
type dw_21 from pfc_cst_u_calendar_dw within w_meetings
end type
type dw_22 from pfc_cst_u_calendar_dw within w_meetings
end type
type dw_23 from pfc_cst_u_calendar_dw within w_meetings
end type
type dw_24 from pfc_cst_u_calendar_dw within w_meetings
end type
type dw_25 from pfc_cst_u_calendar_dw within w_meetings
end type
type dw_26 from pfc_cst_u_calendar_dw within w_meetings
end type
type dw_27 from pfc_cst_u_calendar_dw within w_meetings
end type
type dw_28 from pfc_cst_u_calendar_dw within w_meetings
end type
type dw_29 from pfc_cst_u_calendar_dw within w_meetings
end type
type dw_30 from pfc_cst_u_calendar_dw within w_meetings
end type
type dw_31 from pfc_cst_u_calendar_dw within w_meetings
end type
type dw_32 from pfc_cst_u_calendar_dw within w_meetings
end type
type dw_33 from pfc_cst_u_calendar_dw within w_meetings
end type
type dw_34 from pfc_cst_u_calendar_dw within w_meetings
end type
type dw_35 from pfc_cst_u_calendar_dw within w_meetings
end type
type dw_month_data from pfc_cst_u_calendar_dw within w_meetings
end type
type dw_36 from pfc_cst_u_calendar_dw within w_meetings
end type
type st_month from statictext within w_meetings
end type
type st_click from statictext within w_meetings
end type
type dw_37 from pfc_cst_u_calendar_dw within w_meetings
end type
type dw_facility_select from pfc_cst_u_org_facility_selector_vertical within w_meetings
end type
type dw_calendar from pfc_cst_u_calendar_dw within w_meetings
end type
end forward

global type w_meetings from w_sheet
integer x = 5
integer y = 312
integer width = 4352
integer height = 2440
string title = "Meetings"
long backcolor = 33551856
event ue_detail pbm_custom01
event ue_prior_year pbm_custom02
event ue_next_year pbm_custom03
event ue_prior_month pbm_custom04
event ue_next_month pbm_custom05
event ue_today pbm_custom06
event ue_select_date pbm_custom07
event pfc_cst_print_report ( )
cb_today cb_today
p_pmonth p_pmonth
p_nmonth p_nmonth
p_nyear p_nyear
p_pyear p_pyear
cb_close cb_close
cb_1 cb_1
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
dw_4 dw_4
dw_5 dw_5
dw_6 dw_6
dw_7 dw_7
dw_8 dw_8
dw_9 dw_9
dw_10 dw_10
dw_11 dw_11
dw_12 dw_12
dw_13 dw_13
dw_14 dw_14
dw_15 dw_15
dw_16 dw_16
dw_17 dw_17
dw_18 dw_18
dw_19 dw_19
dw_20 dw_20
dw_21 dw_21
dw_22 dw_22
dw_23 dw_23
dw_24 dw_24
dw_25 dw_25
dw_26 dw_26
dw_27 dw_27
dw_28 dw_28
dw_29 dw_29
dw_30 dw_30
dw_31 dw_31
dw_32 dw_32
dw_33 dw_33
dw_34 dw_34
dw_35 dw_35
dw_month_data dw_month_data
dw_36 dw_36
st_month st_month
st_click st_click
dw_37 dw_37
dw_facility_select dw_facility_select
dw_calendar dw_calendar
end type
global w_meetings w_meetings

type variables
pfc_cst_u_calendar_dw idw_day[37]


Date il_current_month_date
String Months[12]

Datawindow idw_current , idw_today

long	 il_facility_id

Constant Long SELECTED_COLOR = 16777215
//Constant Long UNSELECTED_COLOR =12639424 - green
Constant Long UNSELECTED_COLOR = 16774640 //maha 12.21.2010
//Constant Long UNSELECTED_COLOR =16773345 //- lt blue
//Constant Long UNSELECTED_COLOR =16766945 //- mauve  maha 04.21.2010

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-10-08 By: Rodger Wu (Inova)
//$<reason> Default search facility id of current user.
Long il_default_facility = 0
//---------------------------- APPEON END ----------------------------

end variables

forward prototypes
public function integer of_get_month_info (date ad_month_date)
public function integer of_print_cal ()
end prototypes

event ue_detail;idw_current.TriggerEvent( DoubleClicked! )//Open(w_meeting_detail)
end event

event ue_prior_year;Date ld_new_year

ld_new_year = RelativeDate( il_current_month_date, -365 )

//if isnull(ld_new_year) then messagebox("ld_new_year","string(ld_new_year)")
of_get_month_info( ld_new_year )
end event

event ue_next_year;Date ld_new_year

ld_new_year = RelativeDate( il_current_month_date, 365 )

of_get_month_info( ld_new_year )
end event

event ue_prior_month;Integer li_current_month
Integer i
Integer li_day
Date ld_new_month

li_current_month = Month ( il_current_month_date )
FOR i = 1 TO 35
	li_day = i * -1
	ld_new_month = RelativeDate( il_current_month_date, li_day ) 
	IF Month( ld_new_month ) <> li_current_month THEN
		EXIT
	END IF
END FOR

ld_new_month = RelativeDate( ld_new_month, -5 )
of_get_month_info( ld_new_month )
end event

event ue_next_month;Integer li_current_month
Integer i
Integer li_day
Date ld_new_month

li_current_month = Month ( il_current_month_date )
FOR i = 1 TO 35
	li_day = i 
	ld_new_month = RelativeDate( il_current_month_date, li_day ) 
	IF Month( ld_new_month ) <> li_current_month THEN
		EXIT
	END IF
END FOR

of_get_month_info( ld_new_month )
end event

event ue_today;of_get_month_info( Today( ) )
IF Not IsNull( idw_today ) THEN
	idw_today.SetFocus( )
END IF
end event

event pfc_cst_print_report();of_print_cal()
end event

public function integer of_get_month_info (date ad_month_date);Integer i
Integer li_count
Integer li_first_day_of_month
String ls_date
DateTime ld_first_date_of_month
DateTime ld_last_date_of_month
DateTime ld_start_date
Integer ll_cal_month
Integer ll_num_days_in_month
Integer ll_cal_year

 
il_current_month_date = ad_month_date

FOR i = 1 TO 37
	idw_day[ i ].Reset( )
	idw_day[ i ].Object.date_num.Text = ""
	//fixed BugN042602	(PB&WEB P3)Added by  Nova 04.26.2010
	idw_day[ i ].id_date=date('1900-01-01')
END FOR

ll_cal_month = Month( ad_month_date )
ll_cal_year = Year( ad_month_date )

st_month.Text = Months[ ll_cal_month ] + "  " + String( ll_cal_year )

//get the first day name of the first day of the month
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04/21/2008 By: Ken.Guo
//$<reason> Fixed BugS041402. User international format to convert to date.
//ls_date = String( ll_cal_month ) + "/" + "01/" + String( ll_cal_year )
ls_date = String( ll_cal_year ) + '-' + String( ll_cal_month ) + "-" + "01"
//---------------------------- APPEON END ----------------------------
ld_first_date_of_month = DateTime( Date( ls_date ) )

//get total number of days in current month
FOR i = 1 TO 32
	ll_num_days_in_month ++
	IF Month ( RelativeDate( Date( ld_first_date_of_month ) , i ) ) <> ll_cal_month THEN
		Exit
	END IF
END FOR

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04/21/2008 By: Ken.Guo
//$<reason> Fixed BugS041402. User international format to convert to date.
//ls_date = String( ll_cal_month ) + "/" + String( ll_num_days_in_month ) + "/"+String( ll_cal_year )
ls_date = String( ll_cal_year ) + '-' + String( ll_cal_month ) + "-" + String( ll_num_days_in_month )
//---------------------------- APPEON END ----------------------------

ld_last_date_of_month = DateTime( Date( ls_date ) )
li_first_day_of_month = DayNumber( Date(ld_first_date_of_month) )

if dw_month_data.dataobject = "d_meetings_day_2_fac" then  //maha 072503
	dw_month_data.settransobject(sqlca)
	dw_month_data.Retrieve( ld_first_date_of_month, ld_last_date_of_month,gs_user_id,il_facility_id )
elseif dw_month_data.dataobject = "d_meetings_day_2" then
	dw_month_data.settransobject(sqlca)
	dw_month_data.Retrieve( ld_first_date_of_month, ld_last_date_of_month,gs_user_id)
end if

IF li_first_day_of_month -1 < 1 THEN
	li_first_day_of_month = 8
END IF

li_count = 0
SetNull(idw_today)
FOR i = li_first_day_of_month -1  To ll_num_days_in_month + (li_first_day_of_month -2)
   ld_start_date = DateTime ( RelativeDate( Date( ld_first_date_of_month ), li_count ) )
	//dw_month_data.SetFilter( "start_date = Date('" + String( ld_start_date, "mm/dd/yyyy" ) + "')" ) //Commented By Ken.Guo 04.21.2008. Use international Format.
	dw_month_data.SetFilter( "start_date = Date('" + String( ld_start_date, "yyyy-mm-dd" ) + "')" ) //Added By Ken.Guo 04.21.2008
   dw_month_data.Filter( )
	
	idw_day[ i ].Visible = True
	dw_month_data.RowsCopy(1, 1000, Primary!, idw_day[ i ], 1, Primary! )
	idw_day[ i ].Object.date_num.Text = String(Day( Date(ld_start_date ) ) )
	idw_day[ i ].id_date = Date(ld_start_date )
	IF Date( ld_start_date ) = Today() THEN
		idw_today = idw_day[ i ]
	END IF
	//------------------- APPEON BEGIN -------------------
	//$<delete> Stephen 08.30.2011
	//$<reason> N/A
	/*
	IF li_count = 0 THEN
		idw_day[ i ].SetFocus( )
	END IF
	*/
	//------------------- APPEON END ---------------------
	
	idw_day[ i ].Sort( )
	li_count ++		
END FOR

IF i = 37 THEN
	//--------Begin Modified by  Nova 01.06.2010------------------------
	//dw_calendar.Object.line_2.Visible = '1'
	//dw_35.Width = 280
	//dw_36.y = 1740
	dw_calendar.Object.line_1.Visible = '1'
	dw_34.Width = 330	//dw_34.Width = 270
	dw_35.Width = 667  //dw_35.Width = 567
//--------End Modified --------------------------------------------

ELSEIF i = 38 THEN
	dw_calendar.Object.line_1.Visible = '1'
	dw_calendar.Object.line_2.Visible = '1'
	dw_34.Width = 330	//  dw_34.Width = 270
	dw_35.Width = 330   //	dw_35.Width = 270
END IF

IF i < 37 THEN
	dw_calendar.Object.line_1.Visible = '0'
	dw_calendar.Object.line_2.Visible = '0'
   dw_36.Visible = False //uncommented by  Nova 01.06.2010
	dw_37.Visible = False //uncommented by  Nova 01.06.2010
	dw_34.Width = 667	//dw_34.Width = 560
	dw_35.Width = 667 	//dw_35.Width = 560
END IF

dw_month_data.SetFilter( "" )
dw_month_data.Filter()


Return 0 


end function

public function integer of_print_cal ();
//Start Code Change ----02.07.2011 #V11 maha 
long Job

Job = PrintOpen() 
PrintScreen(Job, 1,1,10000,8000) //these are positions on the printed page
PrintClose(Job)

return 1
end function

on w_meetings.create
int iCurrent
call super::create
this.cb_today=create cb_today
this.p_pmonth=create p_pmonth
this.p_nmonth=create p_nmonth
this.p_nyear=create p_nyear
this.p_pyear=create p_pyear
this.cb_close=create cb_close
this.cb_1=create cb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.dw_4=create dw_4
this.dw_5=create dw_5
this.dw_6=create dw_6
this.dw_7=create dw_7
this.dw_8=create dw_8
this.dw_9=create dw_9
this.dw_10=create dw_10
this.dw_11=create dw_11
this.dw_12=create dw_12
this.dw_13=create dw_13
this.dw_14=create dw_14
this.dw_15=create dw_15
this.dw_16=create dw_16
this.dw_17=create dw_17
this.dw_18=create dw_18
this.dw_19=create dw_19
this.dw_20=create dw_20
this.dw_21=create dw_21
this.dw_22=create dw_22
this.dw_23=create dw_23
this.dw_24=create dw_24
this.dw_25=create dw_25
this.dw_26=create dw_26
this.dw_27=create dw_27
this.dw_28=create dw_28
this.dw_29=create dw_29
this.dw_30=create dw_30
this.dw_31=create dw_31
this.dw_32=create dw_32
this.dw_33=create dw_33
this.dw_34=create dw_34
this.dw_35=create dw_35
this.dw_month_data=create dw_month_data
this.dw_36=create dw_36
this.st_month=create st_month
this.st_click=create st_click
this.dw_37=create dw_37
this.dw_facility_select=create dw_facility_select
this.dw_calendar=create dw_calendar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_today
this.Control[iCurrent+2]=this.p_pmonth
this.Control[iCurrent+3]=this.p_nmonth
this.Control[iCurrent+4]=this.p_nyear
this.Control[iCurrent+5]=this.p_pyear
this.Control[iCurrent+6]=this.cb_close
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.dw_1
this.Control[iCurrent+9]=this.dw_2
this.Control[iCurrent+10]=this.dw_3
this.Control[iCurrent+11]=this.dw_4
this.Control[iCurrent+12]=this.dw_5
this.Control[iCurrent+13]=this.dw_6
this.Control[iCurrent+14]=this.dw_7
this.Control[iCurrent+15]=this.dw_8
this.Control[iCurrent+16]=this.dw_9
this.Control[iCurrent+17]=this.dw_10
this.Control[iCurrent+18]=this.dw_11
this.Control[iCurrent+19]=this.dw_12
this.Control[iCurrent+20]=this.dw_13
this.Control[iCurrent+21]=this.dw_14
this.Control[iCurrent+22]=this.dw_15
this.Control[iCurrent+23]=this.dw_16
this.Control[iCurrent+24]=this.dw_17
this.Control[iCurrent+25]=this.dw_18
this.Control[iCurrent+26]=this.dw_19
this.Control[iCurrent+27]=this.dw_20
this.Control[iCurrent+28]=this.dw_21
this.Control[iCurrent+29]=this.dw_22
this.Control[iCurrent+30]=this.dw_23
this.Control[iCurrent+31]=this.dw_24
this.Control[iCurrent+32]=this.dw_25
this.Control[iCurrent+33]=this.dw_26
this.Control[iCurrent+34]=this.dw_27
this.Control[iCurrent+35]=this.dw_28
this.Control[iCurrent+36]=this.dw_29
this.Control[iCurrent+37]=this.dw_30
this.Control[iCurrent+38]=this.dw_31
this.Control[iCurrent+39]=this.dw_32
this.Control[iCurrent+40]=this.dw_33
this.Control[iCurrent+41]=this.dw_34
this.Control[iCurrent+42]=this.dw_35
this.Control[iCurrent+43]=this.dw_month_data
this.Control[iCurrent+44]=this.dw_36
this.Control[iCurrent+45]=this.st_month
this.Control[iCurrent+46]=this.st_click
this.Control[iCurrent+47]=this.dw_37
this.Control[iCurrent+48]=this.dw_facility_select
this.Control[iCurrent+49]=this.dw_calendar
end on

on w_meetings.destroy
call super::destroy
destroy(this.cb_today)
destroy(this.p_pmonth)
destroy(this.p_nmonth)
destroy(this.p_nyear)
destroy(this.p_pyear)
destroy(this.cb_close)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.dw_4)
destroy(this.dw_5)
destroy(this.dw_6)
destroy(this.dw_7)
destroy(this.dw_8)
destroy(this.dw_9)
destroy(this.dw_10)
destroy(this.dw_11)
destroy(this.dw_12)
destroy(this.dw_13)
destroy(this.dw_14)
destroy(this.dw_15)
destroy(this.dw_16)
destroy(this.dw_17)
destroy(this.dw_18)
destroy(this.dw_19)
destroy(this.dw_20)
destroy(this.dw_21)
destroy(this.dw_22)
destroy(this.dw_23)
destroy(this.dw_24)
destroy(this.dw_25)
destroy(this.dw_26)
destroy(this.dw_27)
destroy(this.dw_28)
destroy(this.dw_29)
destroy(this.dw_30)
destroy(this.dw_31)
destroy(this.dw_32)
destroy(this.dw_33)
destroy(this.dw_34)
destroy(this.dw_35)
destroy(this.dw_month_data)
destroy(this.dw_36)
destroy(this.st_month)
destroy(this.st_click)
destroy(this.dw_37)
destroy(this.dw_facility_select)
destroy(this.dw_calendar)
end on

event open;call super::open;Integer i, li_count
DateTime ld_first_date_of_month
DateTime ld_start_date
DateTime ld_last_date_of_month
Integer li_first_day_of_month
String ls_date

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-10-08 By: Rodger Wu (Inova)
//$<reason> Have the user's default search facility to calendar.

DataWindowChild ldwc_facility
Long ll_found

//Get default search facility ID into new instance variable.
  SELECT security_users.default_search_facility 
    INTO :il_default_facility  
    FROM security_users
   WHERE security_users.user_id = :gs_user_id;

dw_facility_select.GetChild( "facility_id", ldwc_facility )
ll_found = ldwc_facility.Find( "facility_id = " + string( il_default_facility ), &
										1, ldwc_facility.RowCount() )
									
IF ll_found > 0 THEN
	//Hide non-default search facilities in dddw.
//Start Code Change ----07.22.2009 #V92 maha - removed
//	ldwc_facility.SetFilter( "facility_id in ( 0, " + string( il_default_facility ) + " )" )
//	ldwc_facility.Filter()
//End Code Change---07.22.2009
	
	//Set default search facility to calendar.
	dw_facility_select.SetItem( 1, "facility_id", il_default_facility )
	
//	ldwc_facility.SetRow( ll_found )
//	ldwc_facility.SelectRow( 0, False)
//	ldwc_facility.SelectRow( ll_found, True )
	
	il_facility_id = il_default_facility
	dw_month_data.dataobject = "d_meetings_day_2_fac"
	
END IF
//---------------------------- APPEON END ----------------------------

idw_current = dw_1

//messagebox("", RGB( 31, 252, 215 ))
//messagebox("", RGB( 255, 255, 255 ))

This.x = 1
This.y = 1

//Start Code Change ----02.09.2015 #V14.2 maha
This.Width = 4480   //This.Width = 3660
This.Height = 2500   //This.Height = 2300
//End Code Change ----02.09.2015

months[1] = "January"
months[2] = "February"
months[3] = "March"
months[4] = "April"
months[5] = "May"
months[6] = "June"
months[7] = "July"
months[8] = "August"
months[9] = "September"
months[10] = "October"
months[11] = "November"
months[12] = "December"

idw_day[1] = dw_1
idw_day[2] = dw_2
idw_day[3] = dw_3
idw_day[4] = dw_4
idw_day[5] = dw_5
idw_day[6] = dw_6
idw_day[7] = dw_7
idw_day[8] = dw_8
idw_day[9] = dw_9
idw_day[10] = dw_10
idw_day[11] = dw_11
idw_day[12] = dw_12
idw_day[13] = dw_13
idw_day[14] = dw_14
idw_day[15] = dw_15
idw_day[16] = dw_16
idw_day[17] = dw_17
idw_day[18] = dw_18
idw_day[19] = dw_19
idw_day[20] = dw_20
idw_day[21] = dw_21
idw_day[22] = dw_22
idw_day[23] = dw_23
idw_day[24] = dw_24
idw_day[25] = dw_25
idw_day[26] = dw_26
idw_day[27] = dw_27
idw_day[28] = dw_28
idw_day[29] = dw_29
idw_day[30] = dw_30
idw_day[31] = dw_31
idw_day[32] = dw_32
idw_day[33] = dw_33
idw_day[34] = dw_34
idw_day[35] = dw_35
idw_day[36] = dw_36
idw_day[37] = dw_37


FOR i = 1 TO 37
	idw_day[ i ].DataObject = "d_meetings_day"	
	idw_day[ i ].of_SetUpdateable(False)
   idw_day[ i ].Object.Datawindow.Color = UNSELECTED_COLOR
	idw_day[ i ].Object.info.Background.Color = UNSELECTED_COLOR
   idw_day[ i ].Object.date_num.Background.Color = UNSELECTED_COLOR
END FOR

dw_month_data.of_SetTransObject( SQLCA )

il_current_month_date = Today( )

of_get_month_info( Today() )

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2005-11-11 By: Liang QingShi
//$<reason> Fix a defect. 
/*
idw_today.SetFocus( )
*/
if isvalid(idw_today) then
	idw_today.SetFocus( )
end if
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2006-10-08 By: Rodger Wu (Inova)
//$<reason> Attention!!!

/* 
Customization No. C12-4
d_rpt_meetings_all_inova is modified, need to merge into 6.1 version.
*/

//---------------------------- APPEON END ----------------------------

end event

event activate;call super::activate;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2006-11-15 By: Allen
//$<reason> Fix APB Bug: the Toolbar Icon is invalid.
/*
w_mdi.ChangeMenu(m_pfe_cst_meetings)
*/
If w_mdi.menuname <> 'm_pfe_cst_meetings' Then w_mdi.ChangeMenu( m_pfe_cst_meetings )
//---------------------------- APPEON END ----------------------------

w_mdi.SetToolbarPos ( 2, 1, 200, False )

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-01
//$<add> 01.13.2006 By: Rodger Wu
//$<reason> The SetToolbarPos function is currently unsupported. 
//$<modification> Replace the SetToolBarPos function with the Appeon defined function of_settoolbarpos to provide
//$<modification> the same functionality.

long ll_handle
ll_handle = handle(w_mdi)
gnv_appeondll.of_settoolbarpos(ll_handle)
//---------------------------- APPEON END ----------------------------

w_mdi.of_menu_security( w_mdi.MenuName )


end event

event close;call super::close;w_mdi.ChangeMenu(m_pfe_cst_mdi_menu)

w_mdi.of_menu_security( w_mdi.MenuName )


end event

type cb_today from commandbutton within w_meetings
integer x = 3013
integer y = 36
integer width = 306
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Today"
end type

event clicked;parent.triggerevent( "ue_today")
end event

type p_pmonth from picture within w_meetings
integer x = 1029
integer y = 40
integer width = 91
integer height = 80
string picturename = "VCRPrior!"
boolean focusrectangle = false
string powertiptext = "Prior Month"
end type

event clicked;parent.triggerevent( "ue_prior_month")
end event

type p_nmonth from picture within w_meetings
integer x = 1157
integer y = 40
integer width = 91
integer height = 80
string picturename = "VCRNext!"
boolean focusrectangle = false
string powertiptext = "Next Month"
end type

event clicked;parent.triggerevent( "ue_next_month")
end event

type p_nyear from picture within w_meetings
integer x = 1285
integer y = 40
integer width = 91
integer height = 80
string picturename = "vcrlast!"
boolean focusrectangle = false
string powertiptext = "Next Year"
end type

event clicked;parent.triggerevent( "ue_next_year")
end event

type p_pyear from picture within w_meetings
integer x = 901
integer y = 40
integer width = 91
integer height = 80
string picturename = "vcrfirst!"
boolean focusrectangle = false
string powertiptext = "Prior Year"
end type

event clicked;parent.triggerevent( "ue_prior_year")
end event

type cb_close from commandbutton within w_meetings
integer x = 3890
integer y = 36
integer width = 402
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_meetings
integer x = 3328
integer y = 36
integer width = 553
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Batch Meeting Setup"
end type

event clicked;open(w_meeting_batch)

w_meetings.setredraw(false)
w_meetings.of_get_month_info(today())
w_meetings.setredraw(true)

end event

type dw_1 from pfc_cst_u_calendar_dw within w_meetings
integer x = 27
integer y = 268
integer width = 667
integer height = 368
integer taborder = 400
boolean bringtotop = true
string dataobject = "d_meetings_day"
boolean vscrollbar = false
boolean border = false
end type

event getfocus;call super::getfocus;idw_current.Object.Datawindow.Color = UNSELECTED_COLOR
idw_current.Object.info.Background.Color = UNSELECTED_COLOR
idw_current.Object.date_num.Background.Color = UNSELECTED_COLOR

This.Object.info.Background.Color = SELECTED_COLOR
This.Object.date_num.Background.Color = SELECTED_COLOR
This.Object.Datawindow.Color =  SELECTED_COLOR
idw_current = This
end event

type dw_2 from pfc_cst_u_calendar_dw within w_meetings
integer x = 745
integer y = 268
integer width = 667
integer height = 368
integer taborder = 390
boolean bringtotop = true
boolean vscrollbar = false
boolean border = false
end type

event getfocus;call super::getfocus;idw_current.Object.Datawindow.Color = UNSELECTED_COLOR
idw_current.Object.info.Background.Color = UNSELECTED_COLOR
idw_current.Object.date_num.Background.Color = UNSELECTED_COLOR

This.Object.info.Background.Color = SELECTED_COLOR
This.Object.date_num.Background.Color = SELECTED_COLOR
This.Object.Datawindow.Color =  SELECTED_COLOR
idw_current = This
end event

type dw_3 from pfc_cst_u_calendar_dw within w_meetings
integer x = 1454
integer y = 268
integer width = 667
integer height = 368
integer taborder = 380
boolean bringtotop = true
boolean vscrollbar = false
boolean border = false
end type

event getfocus;call super::getfocus;idw_current.Object.Datawindow.Color = UNSELECTED_COLOR
idw_current.Object.info.Background.Color = UNSELECTED_COLOR
idw_current.Object.date_num.Background.Color = UNSELECTED_COLOR

This.Object.info.Background.Color = SELECTED_COLOR
This.Object.date_num.Background.Color = SELECTED_COLOR
This.Object.Datawindow.Color =  SELECTED_COLOR
idw_current = This
end event

type dw_4 from pfc_cst_u_calendar_dw within w_meetings
integer x = 2167
integer y = 268
integer width = 667
integer height = 368
integer taborder = 370
boolean bringtotop = true
boolean vscrollbar = false
boolean border = false
end type

event getfocus;call super::getfocus;idw_current.Object.Datawindow.Color = UNSELECTED_COLOR
idw_current.Object.info.Background.Color = UNSELECTED_COLOR
idw_current.Object.date_num.Background.Color = UNSELECTED_COLOR

This.Object.info.Background.Color = SELECTED_COLOR
This.Object.date_num.Background.Color = SELECTED_COLOR
This.Object.Datawindow.Color =  SELECTED_COLOR
idw_current = This
end event

type dw_5 from pfc_cst_u_calendar_dw within w_meetings
integer x = 2885
integer y = 268
integer width = 667
integer height = 368
integer taborder = 360
boolean bringtotop = true
boolean vscrollbar = false
boolean border = false
end type

event getfocus;call super::getfocus;idw_current.Object.Datawindow.Color = UNSELECTED_COLOR
idw_current.Object.info.Background.Color = UNSELECTED_COLOR
idw_current.Object.date_num.Background.Color = UNSELECTED_COLOR

This.Object.info.Background.Color = SELECTED_COLOR
This.Object.date_num.Background.Color = SELECTED_COLOR
This.Object.Datawindow.Color =  SELECTED_COLOR
idw_current = This
end event

type dw_6 from pfc_cst_u_calendar_dw within w_meetings
integer x = 3589
integer y = 268
integer width = 667
integer height = 164
integer taborder = 350
boolean bringtotop = true
boolean vscrollbar = false
boolean border = false
end type

event getfocus;call super::getfocus;idw_current.Object.Datawindow.Color = UNSELECTED_COLOR
idw_current.Object.info.Background.Color = UNSELECTED_COLOR
idw_current.Object.date_num.Background.Color = UNSELECTED_COLOR

This.Object.info.Background.Color = SELECTED_COLOR
This.Object.date_num.Background.Color = SELECTED_COLOR
This.Object.Datawindow.Color =  SELECTED_COLOR
idw_current = This
end event

type dw_7 from pfc_cst_u_calendar_dw within w_meetings
integer x = 3584
integer y = 472
integer width = 667
integer height = 164
integer taborder = 340
boolean bringtotop = true
boolean vscrollbar = false
boolean border = false
end type

event getfocus;call super::getfocus;idw_current.Object.Datawindow.Color = UNSELECTED_COLOR
idw_current.Object.info.Background.Color = UNSELECTED_COLOR
idw_current.Object.date_num.Background.Color = UNSELECTED_COLOR

This.Object.info.Background.Color = SELECTED_COLOR
This.Object.date_num.Background.Color = SELECTED_COLOR
This.Object.Datawindow.Color =  SELECTED_COLOR
idw_current = This
end event

type dw_8 from pfc_cst_u_calendar_dw within w_meetings
integer x = 27
integer y = 676
integer width = 667
integer height = 368
integer taborder = 330
boolean bringtotop = true
boolean vscrollbar = false
boolean border = false
end type

event getfocus;call super::getfocus;idw_current.Object.Datawindow.Color = UNSELECTED_COLOR
idw_current.Object.info.Background.Color = UNSELECTED_COLOR
idw_current.Object.date_num.Background.Color = UNSELECTED_COLOR

This.Object.info.Background.Color = SELECTED_COLOR
This.Object.date_num.Background.Color = SELECTED_COLOR
This.Object.Datawindow.Color =  SELECTED_COLOR
idw_current = This
end event

type dw_9 from pfc_cst_u_calendar_dw within w_meetings
integer x = 745
integer y = 676
integer width = 667
integer height = 368
integer taborder = 320
boolean bringtotop = true
boolean vscrollbar = false
boolean border = false
end type

event getfocus;call super::getfocus;idw_current.Object.Datawindow.Color = UNSELECTED_COLOR
idw_current.Object.info.Background.Color = UNSELECTED_COLOR
idw_current.Object.date_num.Background.Color = UNSELECTED_COLOR

This.Object.info.Background.Color = SELECTED_COLOR
This.Object.date_num.Background.Color = SELECTED_COLOR
This.Object.Datawindow.Color =  SELECTED_COLOR
idw_current = This
end event

type dw_10 from pfc_cst_u_calendar_dw within w_meetings
integer x = 1454
integer y = 676
integer width = 667
integer height = 368
integer taborder = 310
boolean bringtotop = true
boolean vscrollbar = false
boolean border = false
end type

event getfocus;call super::getfocus;idw_current.Object.Datawindow.Color = UNSELECTED_COLOR
idw_current.Object.info.Background.Color = UNSELECTED_COLOR
idw_current.Object.date_num.Background.Color = UNSELECTED_COLOR

This.Object.info.Background.Color = SELECTED_COLOR
This.Object.date_num.Background.Color = SELECTED_COLOR
This.Object.Datawindow.Color =  SELECTED_COLOR
idw_current = This
end event

type dw_11 from pfc_cst_u_calendar_dw within w_meetings
integer x = 2167
integer y = 676
integer width = 667
integer height = 368
integer taborder = 300
boolean bringtotop = true
boolean vscrollbar = false
boolean border = false
end type

event getfocus;call super::getfocus;idw_current.Object.Datawindow.Color = UNSELECTED_COLOR
idw_current.Object.info.Background.Color = UNSELECTED_COLOR
idw_current.Object.date_num.Background.Color = UNSELECTED_COLOR

This.Object.info.Background.Color = SELECTED_COLOR
This.Object.date_num.Background.Color = SELECTED_COLOR
This.Object.Datawindow.Color =  SELECTED_COLOR
idw_current = This
end event

type dw_12 from pfc_cst_u_calendar_dw within w_meetings
integer x = 2885
integer y = 676
integer width = 667
integer height = 368
integer taborder = 290
boolean bringtotop = true
boolean vscrollbar = false
boolean border = false
end type

event getfocus;call super::getfocus;idw_current.Object.Datawindow.Color = UNSELECTED_COLOR
idw_current.Object.info.Background.Color = UNSELECTED_COLOR
idw_current.Object.date_num.Background.Color = UNSELECTED_COLOR

This.Object.info.Background.Color = SELECTED_COLOR
This.Object.date_num.Background.Color = SELECTED_COLOR
This.Object.Datawindow.Color =  SELECTED_COLOR
idw_current = This
end event

type dw_13 from pfc_cst_u_calendar_dw within w_meetings
integer x = 3584
integer y = 676
integer width = 667
integer height = 164
integer taborder = 280
boolean bringtotop = true
boolean vscrollbar = false
boolean border = false
end type

event getfocus;call super::getfocus;idw_current.Object.Datawindow.Color = UNSELECTED_COLOR
idw_current.Object.info.Background.Color = UNSELECTED_COLOR
idw_current.Object.date_num.Background.Color = UNSELECTED_COLOR

This.Object.info.Background.Color = SELECTED_COLOR
This.Object.date_num.Background.Color = SELECTED_COLOR
This.Object.Datawindow.Color =  SELECTED_COLOR
idw_current = This
end event

type dw_14 from pfc_cst_u_calendar_dw within w_meetings
integer x = 3584
integer y = 880
integer width = 667
integer height = 164
integer taborder = 270
boolean bringtotop = true
boolean vscrollbar = false
boolean border = false
end type

event getfocus;call super::getfocus;idw_current.Object.Datawindow.Color = UNSELECTED_COLOR
idw_current.Object.info.Background.Color = UNSELECTED_COLOR
idw_current.Object.date_num.Background.Color = UNSELECTED_COLOR

This.Object.info.Background.Color = SELECTED_COLOR
This.Object.date_num.Background.Color = SELECTED_COLOR
This.Object.Datawindow.Color =  SELECTED_COLOR
idw_current = This
end event

type dw_15 from pfc_cst_u_calendar_dw within w_meetings
integer x = 27
integer y = 1084
integer width = 667
integer height = 368
integer taborder = 260
boolean bringtotop = true
boolean vscrollbar = false
boolean border = false
end type

event getfocus;call super::getfocus;idw_current.Object.Datawindow.Color = UNSELECTED_COLOR
idw_current.Object.info.Background.Color = UNSELECTED_COLOR
idw_current.Object.date_num.Background.Color = UNSELECTED_COLOR

This.Object.info.Background.Color = SELECTED_COLOR
This.Object.date_num.Background.Color = SELECTED_COLOR
This.Object.Datawindow.Color =  SELECTED_COLOR
idw_current = This
end event

type dw_16 from pfc_cst_u_calendar_dw within w_meetings
integer x = 745
integer y = 1084
integer width = 667
integer height = 368
integer taborder = 250
boolean bringtotop = true
boolean vscrollbar = false
boolean border = false
end type

event getfocus;call super::getfocus;idw_current.Object.Datawindow.Color = UNSELECTED_COLOR
idw_current.Object.info.Background.Color = UNSELECTED_COLOR
idw_current.Object.date_num.Background.Color = UNSELECTED_COLOR

This.Object.info.Background.Color = SELECTED_COLOR
This.Object.date_num.Background.Color = SELECTED_COLOR
This.Object.Datawindow.Color =  SELECTED_COLOR
idw_current = This
end event

type dw_17 from pfc_cst_u_calendar_dw within w_meetings
integer x = 1454
integer y = 1084
integer width = 667
integer height = 368
integer taborder = 240
boolean bringtotop = true
boolean vscrollbar = false
boolean border = false
end type

event getfocus;call super::getfocus;idw_current.Object.Datawindow.Color = UNSELECTED_COLOR
idw_current.Object.info.Background.Color = UNSELECTED_COLOR
idw_current.Object.date_num.Background.Color = UNSELECTED_COLOR

This.Object.info.Background.Color = SELECTED_COLOR
This.Object.date_num.Background.Color = SELECTED_COLOR
This.Object.Datawindow.Color =  SELECTED_COLOR
idw_current = This
end event

type dw_18 from pfc_cst_u_calendar_dw within w_meetings
integer x = 2167
integer y = 1084
integer width = 667
integer height = 368
integer taborder = 230
boolean bringtotop = true
boolean vscrollbar = false
boolean border = false
end type

event getfocus;call super::getfocus;idw_current.Object.Datawindow.Color = UNSELECTED_COLOR
idw_current.Object.info.Background.Color = UNSELECTED_COLOR
idw_current.Object.date_num.Background.Color = UNSELECTED_COLOR

This.Object.info.Background.Color = SELECTED_COLOR
This.Object.date_num.Background.Color = SELECTED_COLOR
This.Object.Datawindow.Color =  SELECTED_COLOR
idw_current = This
end event

type dw_19 from pfc_cst_u_calendar_dw within w_meetings
integer x = 2885
integer y = 1084
integer width = 667
integer height = 368
integer taborder = 220
boolean bringtotop = true
boolean vscrollbar = false
boolean border = false
end type

event getfocus;call super::getfocus;idw_current.Object.Datawindow.Color = UNSELECTED_COLOR
idw_current.Object.info.Background.Color = UNSELECTED_COLOR
idw_current.Object.date_num.Background.Color = UNSELECTED_COLOR

This.Object.info.Background.Color = SELECTED_COLOR
This.Object.date_num.Background.Color = SELECTED_COLOR
This.Object.Datawindow.Color =  SELECTED_COLOR
idw_current = This
end event

type dw_20 from pfc_cst_u_calendar_dw within w_meetings
integer x = 3589
integer y = 1084
integer width = 667
integer height = 164
integer taborder = 210
boolean bringtotop = true
boolean vscrollbar = false
boolean border = false
end type

event getfocus;call super::getfocus;idw_current.Object.Datawindow.Color = UNSELECTED_COLOR
idw_current.Object.info.Background.Color = UNSELECTED_COLOR
idw_current.Object.date_num.Background.Color = UNSELECTED_COLOR

This.Object.info.Background.Color = SELECTED_COLOR
This.Object.date_num.Background.Color = SELECTED_COLOR
This.Object.Datawindow.Color =  SELECTED_COLOR
idw_current = This
end event

type dw_21 from pfc_cst_u_calendar_dw within w_meetings
integer x = 3589
integer y = 1288
integer width = 667
integer height = 164
integer taborder = 200
boolean bringtotop = true
boolean vscrollbar = false
boolean border = false
end type

event getfocus;call super::getfocus;idw_current.Object.Datawindow.Color = UNSELECTED_COLOR
idw_current.Object.info.Background.Color = UNSELECTED_COLOR
idw_current.Object.date_num.Background.Color = UNSELECTED_COLOR

This.Object.info.Background.Color = SELECTED_COLOR
This.Object.date_num.Background.Color = SELECTED_COLOR
This.Object.Datawindow.Color =  SELECTED_COLOR
idw_current = This
end event

type dw_22 from pfc_cst_u_calendar_dw within w_meetings
integer x = 27
integer y = 1492
integer width = 667
integer height = 368
integer taborder = 190
boolean bringtotop = true
boolean vscrollbar = false
boolean border = false
end type

event getfocus;call super::getfocus;idw_current.Object.Datawindow.Color = UNSELECTED_COLOR
idw_current.Object.info.Background.Color = UNSELECTED_COLOR
idw_current.Object.date_num.Background.Color = UNSELECTED_COLOR

This.Object.info.Background.Color = SELECTED_COLOR
This.Object.date_num.Background.Color = SELECTED_COLOR
This.Object.Datawindow.Color =  SELECTED_COLOR
idw_current = This
end event

type dw_23 from pfc_cst_u_calendar_dw within w_meetings
integer x = 745
integer y = 1492
integer width = 667
integer height = 368
integer taborder = 180
boolean bringtotop = true
boolean vscrollbar = false
boolean border = false
end type

event getfocus;call super::getfocus;idw_current.Object.Datawindow.Color = UNSELECTED_COLOR
idw_current.Object.info.Background.Color = UNSELECTED_COLOR
idw_current.Object.date_num.Background.Color = UNSELECTED_COLOR

This.Object.info.Background.Color = SELECTED_COLOR
This.Object.date_num.Background.Color = SELECTED_COLOR
This.Object.Datawindow.Color =  SELECTED_COLOR
idw_current = This
end event

type dw_24 from pfc_cst_u_calendar_dw within w_meetings
integer x = 1454
integer y = 1492
integer width = 667
integer height = 368
integer taborder = 170
boolean bringtotop = true
boolean vscrollbar = false
boolean border = false
end type

event getfocus;call super::getfocus;idw_current.Object.Datawindow.Color = UNSELECTED_COLOR
idw_current.Object.info.Background.Color = UNSELECTED_COLOR
idw_current.Object.date_num.Background.Color = UNSELECTED_COLOR

This.Object.info.Background.Color = SELECTED_COLOR
This.Object.date_num.Background.Color = SELECTED_COLOR
This.Object.Datawindow.Color =  SELECTED_COLOR
idw_current = This
end event

type dw_25 from pfc_cst_u_calendar_dw within w_meetings
integer x = 2167
integer y = 1492
integer width = 667
integer height = 368
integer taborder = 160
boolean bringtotop = true
boolean vscrollbar = false
boolean border = false
end type

event getfocus;call super::getfocus;idw_current.Object.Datawindow.Color = UNSELECTED_COLOR
idw_current.Object.info.Background.Color = UNSELECTED_COLOR
idw_current.Object.date_num.Background.Color = UNSELECTED_COLOR

This.Object.info.Background.Color = SELECTED_COLOR
This.Object.date_num.Background.Color = SELECTED_COLOR
This.Object.Datawindow.Color =  SELECTED_COLOR
idw_current = This
end event

type dw_26 from pfc_cst_u_calendar_dw within w_meetings
integer x = 2885
integer y = 1492
integer width = 667
integer height = 368
integer taborder = 150
boolean bringtotop = true
boolean vscrollbar = false
boolean border = false
end type

event getfocus;call super::getfocus;idw_current.Object.Datawindow.Color = UNSELECTED_COLOR
idw_current.Object.info.Background.Color = UNSELECTED_COLOR
idw_current.Object.date_num.Background.Color = UNSELECTED_COLOR

This.Object.info.Background.Color = SELECTED_COLOR
This.Object.date_num.Background.Color = SELECTED_COLOR
This.Object.Datawindow.Color =  SELECTED_COLOR
idw_current = This
end event

type dw_27 from pfc_cst_u_calendar_dw within w_meetings
integer x = 3589
integer y = 1492
integer width = 667
integer height = 164
integer taborder = 140
boolean bringtotop = true
boolean vscrollbar = false
boolean border = false
end type

event getfocus;call super::getfocus;idw_current.Object.Datawindow.Color = UNSELECTED_COLOR
idw_current.Object.info.Background.Color = UNSELECTED_COLOR
idw_current.Object.date_num.Background.Color = UNSELECTED_COLOR

This.Object.info.Background.Color = SELECTED_COLOR
This.Object.date_num.Background.Color = SELECTED_COLOR
This.Object.Datawindow.Color =  SELECTED_COLOR
idw_current = This
end event

type dw_28 from pfc_cst_u_calendar_dw within w_meetings
integer x = 3589
integer y = 1696
integer width = 667
integer height = 164
integer taborder = 130
boolean bringtotop = true
boolean vscrollbar = false
boolean border = false
end type

event getfocus;call super::getfocus;idw_current.Object.Datawindow.Color = UNSELECTED_COLOR
idw_current.Object.info.Background.Color = UNSELECTED_COLOR
idw_current.Object.date_num.Background.Color = UNSELECTED_COLOR

This.Object.info.Background.Color = SELECTED_COLOR
This.Object.date_num.Background.Color = SELECTED_COLOR
This.Object.Datawindow.Color =  SELECTED_COLOR
idw_current = This
end event

type dw_29 from pfc_cst_u_calendar_dw within w_meetings
integer x = 27
integer y = 1900
integer width = 667
integer height = 368
integer taborder = 120
boolean bringtotop = true
boolean vscrollbar = false
boolean border = false
end type

event getfocus;call super::getfocus;idw_current.Object.Datawindow.Color = UNSELECTED_COLOR
idw_current.Object.info.Background.Color = UNSELECTED_COLOR
idw_current.Object.date_num.Background.Color = UNSELECTED_COLOR

This.Object.info.Background.Color = SELECTED_COLOR
This.Object.date_num.Background.Color = SELECTED_COLOR
This.Object.Datawindow.Color =  SELECTED_COLOR
idw_current = This
end event

type dw_30 from pfc_cst_u_calendar_dw within w_meetings
integer x = 745
integer y = 1900
integer width = 667
integer height = 368
integer taborder = 110
boolean bringtotop = true
boolean vscrollbar = false
boolean border = false
end type

event getfocus;call super::getfocus;idw_current.Object.Datawindow.Color = UNSELECTED_COLOR
idw_current.Object.info.Background.Color = UNSELECTED_COLOR
idw_current.Object.date_num.Background.Color = UNSELECTED_COLOR

This.Object.info.Background.Color = SELECTED_COLOR
This.Object.date_num.Background.Color = SELECTED_COLOR
This.Object.Datawindow.Color =  SELECTED_COLOR
idw_current = This
end event

type dw_31 from pfc_cst_u_calendar_dw within w_meetings
integer x = 1454
integer y = 1900
integer width = 667
integer height = 368
integer taborder = 100
boolean bringtotop = true
boolean vscrollbar = false
boolean border = false
end type

event getfocus;call super::getfocus;idw_current.Object.Datawindow.Color = UNSELECTED_COLOR
idw_current.Object.info.Background.Color = UNSELECTED_COLOR
idw_current.Object.date_num.Background.Color = UNSELECTED_COLOR

This.Object.info.Background.Color = SELECTED_COLOR
This.Object.date_num.Background.Color = SELECTED_COLOR
This.Object.Datawindow.Color =  SELECTED_COLOR
idw_current = This
end event

type dw_32 from pfc_cst_u_calendar_dw within w_meetings
integer x = 2167
integer y = 1900
integer width = 667
integer height = 368
integer taborder = 90
boolean bringtotop = true
boolean vscrollbar = false
boolean border = false
end type

event getfocus;call super::getfocus;idw_current.Object.Datawindow.Color = UNSELECTED_COLOR
idw_current.Object.info.Background.Color = UNSELECTED_COLOR
idw_current.Object.date_num.Background.Color = UNSELECTED_COLOR

This.Object.info.Background.Color = SELECTED_COLOR
This.Object.date_num.Background.Color = SELECTED_COLOR
This.Object.Datawindow.Color =  SELECTED_COLOR
idw_current = This
end event

type dw_33 from pfc_cst_u_calendar_dw within w_meetings
integer x = 2885
integer y = 1900
integer width = 667
integer height = 368
integer taborder = 80
boolean bringtotop = true
boolean vscrollbar = false
boolean border = false
end type

event getfocus;call super::getfocus;idw_current.Object.Datawindow.Color = UNSELECTED_COLOR
idw_current.Object.info.Background.Color = UNSELECTED_COLOR
idw_current.Object.date_num.Background.Color = UNSELECTED_COLOR

This.Object.info.Background.Color = SELECTED_COLOR
This.Object.date_num.Background.Color = SELECTED_COLOR
This.Object.Datawindow.Color =  SELECTED_COLOR
idw_current = This
end event

type dw_34 from pfc_cst_u_calendar_dw within w_meetings
integer x = 3584
integer y = 1900
integer width = 338
integer height = 164
integer taborder = 70
boolean bringtotop = true
boolean vscrollbar = false
boolean border = false
end type

event getfocus;call super::getfocus;idw_current.Object.Datawindow.Color = UNSELECTED_COLOR
idw_current.Object.info.Background.Color = UNSELECTED_COLOR
idw_current.Object.date_num.Background.Color = UNSELECTED_COLOR

This.Object.info.Background.Color = SELECTED_COLOR
This.Object.date_num.Background.Color = SELECTED_COLOR
This.Object.Datawindow.Color =  SELECTED_COLOR
idw_current = This
end event

type dw_35 from pfc_cst_u_calendar_dw within w_meetings
integer x = 3589
integer y = 2104
integer width = 334
integer height = 164
integer taborder = 60
boolean bringtotop = true
boolean vscrollbar = false
boolean border = false
end type

event getfocus;call super::getfocus;idw_current.Object.Datawindow.Color = UNSELECTED_COLOR
idw_current.Object.info.Background.Color = UNSELECTED_COLOR
idw_current.Object.date_num.Background.Color = UNSELECTED_COLOR

This.Object.info.Background.Color = SELECTED_COLOR
This.Object.date_num.Background.Color = SELECTED_COLOR
This.Object.Datawindow.Color =  SELECTED_COLOR
idw_current = This
end event

type dw_month_data from pfc_cst_u_calendar_dw within w_meetings
boolean visible = false
integer x = 910
integer y = 2336
integer width = 1728
integer height = 724
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_meetings_day_2"
boolean vscrollbar = false
end type

type dw_36 from pfc_cst_u_calendar_dw within w_meetings
boolean visible = false
integer x = 3936
integer y = 1900
integer width = 315
integer height = 164
integer taborder = 40
boolean bringtotop = true
boolean vscrollbar = false
boolean border = false
end type

event getfocus;call super::getfocus;idw_current.Object.Datawindow.Color = UNSELECTED_COLOR
idw_current.Object.info.Background.Color = UNSELECTED_COLOR
idw_current.Object.date_num.Background.Color = UNSELECTED_COLOR

This.Object.info.Background.Color = SELECTED_COLOR
This.Object.date_num.Background.Color = SELECTED_COLOR
This.Object.Datawindow.Color =  SELECTED_COLOR
idw_current = This
end event

type st_month from statictext within w_meetings
integer x = 46
integer y = 28
integer width = 805
integer height = 96
boolean bringtotop = true
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
boolean enabled = false
string text = "Month and Year"
boolean focusrectangle = false
end type

type st_click from statictext within w_meetings
integer x = 2427
integer y = 32
integer width = 571
integer height = 116
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
boolean enabled = false
string text = "(Double click date on calendar to see detail)"
boolean focusrectangle = false
end type

type dw_37 from pfc_cst_u_calendar_dw within w_meetings
boolean visible = false
integer x = 3936
integer y = 2104
integer width = 315
integer height = 164
integer taborder = 30
boolean bringtotop = true
boolean vscrollbar = false
boolean border = false
end type

event getfocus;call super::getfocus;idw_current.Object.Datawindow.Color = UNSELECTED_COLOR
idw_current.Object.info.Background.Color = UNSELECTED_COLOR
idw_current.Object.date_num.Background.Color = UNSELECTED_COLOR

This.Object.info.Background.Color = SELECTED_COLOR
This.Object.date_num.Background.Color = SELECTED_COLOR
This.Object.Datawindow.Color =  SELECTED_COLOR
idw_current = This
end event

type dw_facility_select from pfc_cst_u_org_facility_selector_vertical within w_meetings
integer x = 1413
integer width = 974
integer height = 168
integer taborder = 20
end type

event constructor;call super::constructor;//This.Object.facilities_t.Visible = False
end event

event itemchanged;w_meetings.il_facility_id = Integer(Data)

IF w_meetings.il_facility_id = 0 THEN
	dw_month_data.DataObject = "d_meetings_day_2"
ELSE
	dw_month_data.DataObject = "d_meetings_day_2_fac"
END IF

of_get_month_info( il_current_month_date )

//Added by Nova on 09.27.2008
//fixed BugN092702
IF IsValid(idw_today) THEN
	idw_today.SetFocus( )
END IF

end event

type dw_calendar from pfc_cst_u_calendar_dw within w_meetings
integer x = 5
integer y = 176
integer width = 4288
integer height = 2144
integer taborder = 10
string dataobject = "d_meetings_calander"
boolean vscrollbar = false
end type

event doubleclicked;//Add by Evan 06.01.2009 --- Corrected BugG062001 (Do not extend ancestor script)
end event

