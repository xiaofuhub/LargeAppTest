$PBExportHeader$n_cst_meeting_creation.sru
forward
global type n_cst_meeting_creation from nonvisualobject
end type
end forward

global type n_cst_meeting_creation from nonvisualobject
end type
global n_cst_meeting_creation n_cst_meeting_creation

type variables
n_ds ids_detail
n_ds ids_meetings
n_ds ids_ibatch
n_ds ids_attend
n_ds ids_holidays
end variables

forward prototypes
public function integer of_destroy ()
public function date of_get_month_first_day (date ad_date, integer ai_dow)
public function integer of_create_meetings (integer ai_batch, string as_user, ref datetime adt_last)
public function integer of_add_attendees (long ai_meeting, long ai_batch)
public function datetime of_advance_month (datetime ad_date)
public function datetime of_month_meeting_date (integer ai_dow, datetime ad_date, integer ai_wom, integer ai_multiple, ref date ad_eval)
public function integer of_find_holiday (datetime ad_date)
public function datetime of_find_next_date (n_ds ads_data, datetime ad_after, integer ai_weekday, integer ai_multiple, integer ai_type, integer ai_monthweek, integer ai_holiday, boolean ab_first_loop)
end prototypes

public function integer of_destroy ();destroy ids_detail
destroy ids_meetings
destroy ids_attend
destroy ids_ibatch
destroy ids_holidays

return 1


end function

public function date of_get_month_first_day (date ad_date, integer ai_dow);//getting the date of the first 'tuesday' of the Month

integer li_dayname
integer e
date ld_eval


e = 0 - day(ad_date) + 1 //first of month
ld_eval = RelativeDate (ad_date,e)

li_dayname =  DayNumber(ld_eval) //dayname of first of month

if li_dayname = ai_dow then
	//ld_eval = itself
elseif li_dayname < ai_dow then
	e = ai_dow - li_dayname
	ld_eval = RelativeDate (ld_eval,e)
elseif li_dayname > ai_dow then
	e = 7 - li_dayname + ai_dow
	ld_eval = relativedate(ld_eval,e)
end if


return ld_eval
end function

public function integer of_create_meetings (integer ai_batch, string as_user, ref datetime adt_last);//Start Code Change ----02.16.2011 #V11 maha - created for meeting batch function
//function calls start here
integer d
integer m
integer mc
integer r
integer li_type
integer li_advance
integer li_multiple
integer li_day
integer li_week
integer li_month
integer li_holiday
integer li_setup
integer li_new
integer res
long ll_meet_type
long ll_lookup_val
long ll_meeting_id
long ll_ibatch
Long ll_loop_cnt = 0 //Added by Appeon long.zhang 07.25.2017
datetime ld_start
datetime ld_last
datetime ld_end
datetime ld_now
datetime ld_check
datetime ld_meet_dates[]
datetime ld_meeting
string ls_user

// set user value for meeting
if as_user = "USER" then
	as_user = gs_user_id
elseif as_user = "SYSTEM" then
	as_user = "System"	
end if

ld_now = datetime(today(),now())

ids_detail = create n_ds
ids_meetings = create n_ds
ids_ibatch = create n_ds
ids_attend = create n_ds
ids_holidays = create n_ds

ids_detail.dataobject = "d_meeting_batch_detail"
ids_detail.settransobject(sqlca)
ids_meetings.dataobject = "d_meeting_detail_add"
ids_meetings.settransobject(sqlca)
ids_attend.dataobject = "d_meeting_attendence"
ids_attend.settransobject(sqlca)
ids_ibatch.dataobject = "d_batch_items_list_w_name"
ids_ibatch.settransobject(sqlca)
ids_holidays.dataobject = "d_holiday_de"
ids_holidays.settransobject(sqlca)
ids_holidays.retrieve()

d = ids_detail.retrieve(ai_batch)
li_setup = ai_batch // ids_detail.getitemnumber(1,"batch_id")
//m = ids_meetings.retrieve(today(),li_setup) //get existing meetings greater than today
ld_end = datetime(today())  //Start Code Change ----07.18.2012 #V12 maha - end date should always be relative from today 
m = ids_meetings.retrieve(datetime(today()),li_setup)	//long.zhang 09.23.2011

if d < 1 then
	of_destroy()
	return -1
end if

ld_start = ids_detail.getitemdatetime(1,"start_from")  
ld_last = ids_detail.getitemdatetime(1,"last_created")
li_type = ids_detail.getitemnumber(1,"creation_type")  //weekly monthly
li_advance  = ids_detail.getitemnumber(1,"days_advance")  //how far out to create the meetings
li_multiple = ids_detail.getitemnumber(1,"frequency") //multiple of week/month
li_day = ids_detail.getitemnumber(1,"day_of_week")  //mon/tues etc
li_month = ids_detail.getitemnumber(1,"week_of_month")
li_holiday =  ids_detail.getitemnumber(1,"handle_holiday") //skip or not
ll_lookup_val =  ids_detail.getitemnumber(1,"lookup_code")
ll_ibatch = ids_detail.getitemnumber(1,"ibatch")
 ll_meet_type = ids_detail.getitemnumber(1,"meeting_type")

//debugbreak()
ld_end = datetime(RelativeDate ( date(ld_end), li_advance ), time('00:00:00'))
if isnull(ld_start) then  ld_start = datetime(today(),time('00:00:00'))    //Start Code Change ----07.20.2012 #V12 maha - set today value if null

if m > 0 then //if existing meetings, get the start date
	ld_start = ids_meetings.getitemdatetime( 1,"start_date") //this would be the last meeting created
	if isnull(ld_start) then  ld_start = datetime(today(),time('00:00:00'))  
else  //get last meeting created start date
	if not isnull(ld_last) then //set the start from date
		if ld_last > ld_start then
			ld_start = ld_last
		end if
	end if 
end if


if date(ld_start) < today() then ld_start = datetime(today(),time('00:00:00'))  
//if date(ld_start) < today() then

//ld_end = datetime(RelativeDate ( date(ld_start), li_advance ), time('00:00:00'))  //Start Code Change ----07.18.2012 #V12 maha- moved above

//Start Code Change ----08.15.2011 #V11 maha - trap 
if ld_end < ld_start then   //modify by stephen 09.19.2011 Bug 2649 Batch meetings is not creating meetings
		of_destroy()
	return -1
end if
//Start Code Change ----08.15.2011
	
integer qwe
Do while ld_start < ld_end
	ll_loop_cnt++ //Added by Appeon long.zhang 07.25.2017 (V15.3 Bug # 5728 - Issue with Batch add meetings case 00072063 )
	
	ld_check = ld_start  //check is the org date
	
	If ll_loop_cnt = 1 Then //Added by Appeon long.zhang 07.25.2017 (V15.3 Bug # 5728 - Issue with Batch add meetings case 00072063 )
		ld_start = of_find_next_date( ids_detail, ld_start,li_day,li_multiple, li_type, li_month, li_holiday, True)
	Else
		ld_start = of_find_next_date( ids_detail, ld_start,li_day,li_multiple, li_type, li_month, li_holiday, False)
	End If
	
//	if li_type = 2 then
//		if ld_start < ld_check then
//			of_advance_month( ld_start)
//			//if qwe = 1000 then exit
//			//continue //for month test	
//		end if
//	end if
		
	ld_meet_dates[upperbound(ld_meet_dates) + 1] = ld_start
	if upperbound(ld_meet_dates) > 1 then
		if ld_meet_dates[1] = ld_meet_dates[2] then
			messagebox("Error","Created dates are the same.  Canceling the function")
			of_destroy()
			return -1
		end if
	end if
Loop

//debugbreak()
mc = upperbound( ld_meet_dates)

if mc = 0 then return -1
ll_meeting_id = gnv_app.of_get_id("MEETING",mc)
		
for r = 1 to mc
	ld_meeting =  ld_meet_dates[r]
	if li_holiday = 1 then
		if of_find_holiday(ld_meeting ) = 1 then continue //skip holiday 
	end if
		
	li_new = ids_meetings.insertrow(0)
	
	ids_meetings.setitem(li_new,"facility",  ids_detail.getitemnumber(1,"facility"))
	ids_meetings.setitem(li_new,"meeting_type",  ll_meet_type)
	ids_meetings.setitem(li_new,"start_date",  ld_meet_dates[r])
	ids_meetings.setitem(li_new,"end_date",  ld_meet_dates[r])
	
	choose case ll_meet_type
		case 605 //department
			ids_meetings.setitem(li_new,"department", ll_lookup_val)
		case 606  //section
			ids_meetings.setitem(li_new,"section",  ll_lookup_val)
		case 607 //cred committee
			ids_meetings.setitem(li_new,"committee",  ll_lookup_val)
		case 608 //Cme
			//no value
		case -77   //commitee
			ids_meetings.setitem(li_new,"committe_lookup",  ll_lookup_val)
		case else
			//no value
	end Choose
	ids_meetings.setitem(li_new,"start_at",  ids_detail.getitemstring(1,"start_time"))
	ids_meetings.setitem(li_new,"location",  ids_detail.getitemnumber(1,"location"))
	ids_meetings.setitem(li_new,"subject",  ids_detail.getitemstring(1,"subject"))
	ids_meetings.setitem(li_new,"batch_id",  ai_batch)
	ids_meetings.setitem(li_new,"meeting_id",  ll_meeting_id)
	ids_meetings.setitem(li_new,"create_date",  ld_now)
	ids_meetings.setitem(li_new,"create_user",  ls_user)
	
		//add attendance
	if ll_ibatch > 0 then
		of_add_attendees(ll_meeting_id,ll_ibatch)
	end if
	
	ll_meeting_id++
next

if upperbound(ld_meet_dates) > 0 then
	adt_last =  ld_meet_dates[ upperbound(ld_meet_dates)]
end if

ids_detail.setitem(1,"last_created", adt_last)  //Start Code Change ----07.18.2012 #V12 maha - set the last created date


//update the meetings
ids_detail.update()
res = ids_meetings.update()
//messagebox("res",res)

of_destroy()

return 1
end function

public function integer of_add_attendees (long ai_meeting, long ai_batch);//Start Code Change ----08.02.2011 #V11 maha 
//Note datastores are set up in of_create meetings
integer p
integer pc

pc = ids_ibatch.rowcount() 

if pc = 0 then 
	pc = ids_ibatch.retrieve(ai_batch)
end if

ids_attend.reset()

for p = 1 to pc
	ids_attend.insertrow(p)
	ids_attend.setitem(p,"meeting_id",ai_meeting)
	ids_attend.setitem(p,"prac_id",ids_ibatch.getitemnumber(p,"prac_id"))
next

ids_attend.update()


return 1
end function

public function datetime of_advance_month (datetime ad_date);integer li_month
integer d
datetime ld_return
date ld_date

ld_date = date(ad_date)

li_month = month(ld_date)

choose case li_month
	case 1,3,5,7,8,10,12
		d = 31
	case 2
		d= 29
	case 4,6,9,11
		d = 30
end choose

d = d - day(ld_date) + 1

ld_return = datetime(relativedate(ld_date,d), time("00:00:00"))       //gets first day of next month

return ld_return
end function

public function datetime of_month_meeting_date (integer ai_dow, datetime ad_date, integer ai_wom, integer ai_multiple, ref date ad_eval);//called from of_find_next _date
datetime ldt_return
date ld_date
date ld_eval
date ld_eval2
integer ds
integer month


//get the first 'tuesday' of month
ld_date = date(ad_date)
ld_eval = of_get_month_first_day(ld_date,  ai_dow )

if ai_wom < 10 then //1 to 4  //10 = "last week of month'
	if ai_wom > 1 then
		ds = ai_wom -1
		ds = ds * 7
		ld_eval = relativedate(ld_eval, ds)
	end if
else //last week of month
		ld_eval2 = relativedate(ld_eval, 28)	
		if month(ld_eval2) > month(ld_eval) then //if ran over subtract a week
			ld_eval = relativedate(ld_eval2, -7)
		else
			ld_eval = ld_eval2
		end if		
end if

ldt_return = datetime(ld_eval,time("00:00:00"))

return ldt_return




end function

public function integer of_find_holiday (datetime ad_date);//Start Code Change ----08.03.2011 #V11 maha - added 
//filter does not find holiday as of 08.03.2011

date ld_date
integer li_find
string s
string ls_date

ld_date = date(ad_date)
ls_date = string(year(ld_date)) + "/" + string(month(ld_date)) + "/" + string(day(ld_date)) 

s = "date(hol_date) = date('" + ls_date + "')"
li_find = ids_holidays.find( s,1, ids_holidays.rowcount() )

if li_find < 0 then
	messagebox("Find filter failed in of_find_holiday","Contact Support~r~r" + s)
elseif li_find > 0 then
	li_find = 1
end if

return li_find
end function

public function datetime of_find_next_date (n_ds ads_data, datetime ad_after, integer ai_weekday, integer ai_multiple, integer ai_type, integer ai_monthweek, integer ai_holiday, boolean ab_first_loop);//ads_data  = sending data store
//ad_after = after this date
//ai_weekday = day of the week
//ai_multiple = as in 1 week , 2 months
//ai_type = week or month
//ai_monthweek = as in first week of month
//ai_holiday = skip holiday
//ab_first_loop = The first loop called by of_create_meetings, Added by Appeon long.zhang 07.25.2017 (V15.3 Bug # 5728 - Issue with Batch add meetings case 00072063 )


datetime ld_return
date ld_after
date ld_eval
integer li_type
integer li_day
integer d
integer ds
integer res
long ll_advance

ld_after = date(ad_after)
li_day = DayNumber(ld_after)

choose case ai_type
	case 1 //weekly
		//------------------- APPEON BEGIN -------------------
		//<$>added:long.zhang 07.25.2017
		//<$>reason:Get the latest date, modified by Appeon long.zhang 07.25.2017 (V15.3 Bug # 5728 - Issue with Batch add meetings case 00072063 )		
		If ab_first_loop Then	//Get the fist date.
			if li_day <= ai_weekday  then //if the needed day is later in the week, or the same day
				d = ai_weekday - li_day  //get the day of week in this week
			else
				d = 7 - li_day + ai_weekday //get the day in the next week
			end if
			ld_after = relativedate(ld_after,d)
		Else
//			if li_day <> ai_weekday  then
//				//get next date with that day of week
//				if li_day < ai_weekday  then //if the needed day is later in the week
//					d = ai_weekday - li_day + 7 //get the day of week in the following week
//				else
//					d = 7 - li_day + ai_weekday //get the day in the next week
//				end if
//				ld_after = relativedate(ld_after,d)
//			end if
		
			if ai_multiple > 0 then 
				ll_advance = ai_multiple * 7
				ld_after = relativedate(ld_after,ll_advance)
			end if
		End If
		//------------------- APPEON END -------------------
		
		ld_return = datetime(ld_after,time('00:00:00'))
	case 2 //monthly
	debugbreak()
		ld_return = of_month_meeting_date( ai_weekday, ad_after, ai_monthweek,ai_multiple,ld_eval)
		ld_eval = date(ld_return)
		if ld_eval > ld_after then
			//ok to return ld_return
		else
			//ld_return = datetime(ld_after,time('00:00:00'))
			for d = 1 to ai_multiple
				ld_return = of_advance_month( ld_return)
			next
			ld_return = of_month_meeting_date( ai_weekday, ld_return, ai_monthweek,ai_multiple,ld_eval)
		end if

	case 3 //semi-monthly
	case 4 //quarterly
	case 5 //semi-annual
	case 6 //yearly
		
end choose



return ld_return
end function

on n_cst_meeting_creation.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_meeting_creation.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

