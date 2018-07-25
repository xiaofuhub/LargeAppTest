$PBExportHeader$w_appl_tracking_cleanup.srw
forward
global type w_appl_tracking_cleanup from window
end type
type dw_1 from datawindow within w_appl_tracking_cleanup
end type
type dw_actions from u_dw within w_appl_tracking_cleanup
end type
type dw_tracks from u_dw within w_appl_tracking_cleanup
end type
type rb_dup from radiobutton within w_appl_tracking_cleanup
end type
type dw_dup_fix from datawindow within w_appl_tracking_cleanup
end type
type dw_dupe from datawindow within w_appl_tracking_cleanup
end type
type dw_missing from datawindow within w_appl_tracking_cleanup
end type
type rb_calc from radiobutton within w_appl_tracking_cleanup
end type
type rb_missing from radiobutton within w_appl_tracking_cleanup
end type
type rb_delete from radiobutton within w_appl_tracking_cleanup
end type
type st_count from statictext within w_appl_tracking_cleanup
end type
type dw_apps from datawindow within w_appl_tracking_cleanup
end type
type cb_close from commandbutton within w_appl_tracking_cleanup
end type
type cb_run from commandbutton within w_appl_tracking_cleanup
end type
type gb_1 from groupbox within w_appl_tracking_cleanup
end type
end forward

global type w_appl_tracking_cleanup from window
integer width = 1650
integer height = 728
boolean titlebar = true
string title = "Application Tracking Records"
boolean controlmenu = true
boolean minbox = true
boolean resizable = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
dw_actions dw_actions
dw_tracks dw_tracks
rb_dup rb_dup
dw_dup_fix dw_dup_fix
dw_dupe dw_dupe
dw_missing dw_missing
rb_calc rb_calc
rb_missing rb_missing
rb_delete rb_delete
st_count st_count
dw_apps dw_apps
cb_close cb_close
cb_run cb_run
gb_1 gb_1
end type
global w_appl_tracking_cleanup w_appl_tracking_cleanup

type variables
datastore ids_actions
integer il_final_step
end variables

forward prototypes
public function integer of_check_for_orphan ()
public function integer of_check_missing ()
public function integer of_calc_dates (datawindow adw_data)
public function integer of_dates (datawindow adw_track, long al_row)
public function integer of_days (datawindow adw_track, long ll_row)
public function integer of_delete_dups ()
end prototypes

public function integer of_check_for_orphan ();long r
long rc
long ac
long org
long f
long ll_app
long ll_fac
long ll_prac
long ll_loc  //maha 04.24.2014
long cnt
string ls_find

f = messagebox("Tracking check","This utility will check for orphaned application tracking records.  Do you wish to continue?", question!, Yesno!, 1)
if f = 2 then return 1

dw_apps.settransobject(sqlca)
dw_tracks.settransobject(sqlca)
rc = dw_tracks.retrieve()
ac = dw_apps.retrieve()

org = rc

for r = rc to 1 step -1
	ll_app = dw_tracks.getitemnumber(r,"app_id")
	ll_fac = dw_tracks.getitemnumber(r,"facility_id")
	ll_prac = dw_tracks.getitemnumber(r,"prac_id")
	ll_loc = dw_tracks.getitemnumber(r,"gp_id")  //Start Code Change ----04.24.2014 #V14.2 maha
	If IsNull(ll_loc) Then ll_loc = 0 //Added by Appeon long.zhang 04.01.2017 (BugL040103)
	  
	//ls_find =  "app_id = " + string(ll_app) + " and facility_id = " + string(ll_fac) + " and prac_id = " + string(ll_prac) 
	ls_find =  "app_id = " + string(ll_app) + " and facility_id = " + string(ll_fac) + " and prac_id = " + string(ll_prac)  + " and gp_id = " + string(ll_loc)  
	f = dw_apps.find(ls_find, 1, ac)
	if f = 0 then 
		dw_tracks.deleterow(r)
		cnt++
	end if
	if Mod ( r, 10 ) = 0 then st_count.text = string(r)
next

st_count.text = string(org)

org = org - dw_tracks.rowcount()

if cnt = 0 then
	messagebox("Tracking check","No Unlinked Tracking records found.")
else
	f = messagebox("Tracking check",string(cnt) + " Unlinked Tracking records found.  Do you wish to delete them?", question!, Yesno!, 1)
	if f = 1 then dw_tracks.update()
end if

return 1

end function

public function integer of_check_missing ();long r
long rc
long ac
long org
long f
long ll_app
long ll_fac
long ll_prac
long cnt
long nr
long ll_loc //maha 04.24.2014
long ll_tid = 0
string ls_find
long ll_missing_cnt //Added by (appeon) Harry 10.16.2017

f = messagebox("Tracking check","This utility will check for missing application tracking records and allow you to add them.  Do you wish to continue?", question!, Yesno!, 1)
if f = 2 then return 1

dw_apps.settransobject(sqlca)
dw_tracks.settransobject(sqlca)
dw_missing.settransobject(sqlca)
dw_1.settransobject(sqlca)
ll_missing_cnt = dw_1.retrieve( ) //Added by (appeon) Harry 10.16.2017
rc = dw_tracks.retrieve()
ac = dw_apps.retrieve()
dw_missing.reset()

ll_tid = gnv_app.of_get_id("track_id", ll_missing_cnt) - 1  //Added by (appeon) Harry 10.16.2017

for r = 1 to ac
	ll_app = dw_apps.getitemnumber(r,"app_id")
	ll_fac = dw_apps.getitemnumber(r,"facility_id")
	ll_prac = dw_apps.getitemnumber(r,"prac_id")
	 //Start Code Change ----04.24.2014 #V14.2 maha
	ll_loc = dw_apps.getitemnumber(r,"gp_id") 
	//---------Begin Added by (Appeon)Harry 08.03.2016 for BugH072801--------
	if isnull(ll_app) then ll_app = 0
	if isnull(ll_fac) then ll_fac = 0
	if isnull(ll_prac) then ll_prac = 0
	if isnull(ll_loc) then ll_loc = 0
	//---------End Added ------------------------------------------------------  
	//ls_find =  "app_id = " + string(ll_app) + " and facility_id = " + string(ll_fac) + " and prac_id = " + string(ll_prac) 
	ls_find =  "app_id = " + string(ll_app) + " and facility_id = " + string(ll_fac) + " and prac_id = " + string(ll_prac)  + " and gp_id = " + string(ll_loc) 
	//End Code Change ----04.24.2014

	f = dw_tracks.find(ls_find, 1, rc)
	if f = 0 then 
		//Modified by (appeon) Harry 10.16.2017
		/*
		if ll_tid = 0 then
			select max(track_id) into :ll_tid from pd_appl_tracking;
		end if
		*/
		ll_tid++
		
		ll_tid = gnv_app.of_get_id("track_id")
		nr = dw_missing.insertrow(0)

		dw_missing.setitem(nr,"track_id", ll_tid)
		dw_missing.setitem(nr,"app_id",ll_app )
		dw_missing.setitem(nr,"facility_id", ll_fac)
		dw_missing.setitem(nr,"prac_id", ll_prac)
		dw_missing.setitem(nr,"gp_id", ll_loc)  //Start Code Change ----05.19.2014 #V14.2 maha
		dw_missing.setitem(nr,"active_status", 1)
		cnt++
	end if
	if Mod ( r, 10 ) = 0 then st_count.text = string(r)
next

st_count.text = string(org)

org = org - dw_tracks.rowcount()

if cnt = 0 then
	messagebox("Tracking check","No Missing Tracking records found.")
else
	f = messagebox("Tracking check",string(cnt) + " Missing Tracking records found.  Do you wish to add them?", question!, Yesno!, 1)
	if f = 1 then 
		dw_missing.update()
		of_calc_dates(dw_missing)
		dw_missing.update()
	end if
end if

return 1

end function

public function integer of_calc_dates (datawindow adw_data);long r
long rc
long ac
long org
long f
long ll_app
long ll_fac
long ll_prac
long ll_loc //maha 04.24.2014
long cnt
long nr
long ll_tid = 0
string ls_find
boolean lb_missing



if adw_data = dw_missing then
	//skip the message
	lb_missing = true
else
	f = messagebox("Tracking check","This utility will recalculate step dates on tracking records.  Do you wish to continue?", question!, Yesno!, 1)
	if f = 2 then return 1
	lb_missing = false
end if

il_final_step = integer(gnv_data.of_getitem("app_steps","last step",""))


if not lb_missing then
	adw_data.settransobject(sqlca)
	rc = adw_data.retrieve()
	dw_missing.reset()	
else
	rc = adw_data.rowcount()
end if

 //Start Code Change ----08.12.2015 #V15 maha
//ids_actions = create datastore
//ids_actions.dataobject = "d_net_dev_action_items_tracking"
//ids_actions.settransobject(sqlca)


for r = 1 to rc
	ll_app = adw_data.getitemnumber(r,"app_id")
	ll_fac = adw_data.getitemnumber(r,"facility_id")
	ll_prac = adw_data.getitemnumber(r,"prac_id")
	//Start Code Change ----04.24.2014 #V14.2 maha
	ll_loc = adw_data.getitemnumber(r,"gp_id")	
	//ac = ids_actions.retrieve( ll_prac, ll_app, ll_fac)
	//ac = ids_actions.retrieve( ll_prac, ll_app, ll_fac, ll_loc)
	ac = dw_actions.retrieve( ll_prac, ll_app, ll_fac, ll_loc)//change ids_actions to dw_actions, modified by Appeon long.zhang 04.01.2017 (BugL040103)
	//End Code Change ----04.24.2014

//	of_dates( adw_data, r)
//	of_days( adw_data, r)
	of_appl_tracking_update_dw(dw_tracks,dw_actions, r)

	if Mod ( r, 10 ) = 0 then st_count.text = string(r)
next

st_count.text = string(rc)

//if lb_missing = true then
//	f = 1
//else
//	f = messagebox("Recalculated","Do you wish to save data?", question!, Yesno!, 1)
//end if
//
//if f = 1 then 
//	adw_data.update()
//end if
//
//
//destroy ids_actions
//End Code Change ----08.12.2015

return 1

end function

public function integer of_dates (datawindow adw_track, long al_row);//Start Code Change ----07.21.2010 #V10 maha - set the dates from actions
datetime ldt_null
long ll_step
integer li_final
integer i
integer li_find
string ls_find

//Start Code Change ----03.01.2012 #V12 maha - modified to get the step values from the cache
li_final = il_final_step

setnull(ldt_null)
//for each step
for i = 1 to li_final
	choose case i
		case 1
			//ll_step = dw_track.getitemnumber(1,"step_1_type")
			ll_step = long(gnv_data.of_getitem("app_steps","next step","0"))
			ls_find = "action_type = " + string(ll_step) + " and action_status = 90741"
			li_find = ids_actions.find( ls_find, 1, ids_actions.rowcount())
			if li_find > 0 then
				adw_track.setitem(al_row,"step_1",ids_actions.getitemdatetime(li_find,"action_date"))
			else //Start Code Change ----03.30.2011 #V11 maha - for each step, if the action does not exist clear the date
				adw_track.setitem(al_row,"step_1",ldt_null)
			end if
		case 2
		//	ll_step = dw_track.getitemnumber(1,"step_2_type")
			ll_step = long(gnv_data.of_getitem("app_steps","next step","1"))
			ls_find = "action_type = " + string(ll_step) + " and action_status = 90741"
			li_find = ids_actions.find( ls_find, 1, ids_actions.rowcount())
			if li_find > 0 then 
				adw_track.setitem(al_row,"step_2",ids_actions.getitemdatetime(li_find,"action_date"))
			else 
				adw_track.setitem(al_row,"step_2",ldt_null)
			end if
		case 3
			//ll_step = dw_track.getitemnumber(1,"step_3_type")
			ll_step = long(gnv_data.of_getitem("app_steps","next step","2"))
			ls_find = "action_type = " + string(ll_step) + " and action_status = 90741"
			li_find = ids_actions.find( ls_find, 1, ids_actions.rowcount())
			if li_find > 0 then 
				adw_track.setitem(al_row,"step_3",ids_actions.getitemdatetime(li_find,"action_date"))
			else 
				adw_track.setitem(al_row,"step_3",ldt_null)
			end if
		case 4
			//ll_step = dw_track.getitemnumber(1,"step_4_type")
			ll_step = long(gnv_data.of_getitem("app_steps","next step","3"))
			ls_find = "action_type = " + string(ll_step) + " and action_status = 90741"
			li_find = ids_actions.find( ls_find, 1, ids_actions.rowcount())
			if li_find > 0 then
				adw_track.setitem(al_row,"step_4",ids_actions.getitemdatetime(li_find,"action_date"))
			else 
				adw_track.setitem(al_row,"step_4",ldt_null)
			end if
		case 5
			//ll_step = dw_track.getitemnumber(1,"step_5_type")
			ll_step = long(gnv_data.of_getitem("app_steps","next step","4"))
			ls_find = "action_type = " + string(ll_step) + " and action_status = 90741"
			li_find = ids_actions.find( ls_find, 1, ids_actions.rowcount())
			if li_find > 0 then
				adw_track.setitem(al_row,"step_5",ids_actions.getitemdatetime(li_find,"action_date"))
			else 
				adw_track.setitem(al_row,"step_5",ldt_null)
			end if
		case 6
		//	ll_step = dw_track.getitemnumber(1,"step_6_type")
			ll_step = long(gnv_data.of_getitem("app_steps","next step","5"))
			ls_find = "action_type = " + string(ll_step) + " and action_status = 90741"
			li_find = ids_actions.find( ls_find, 1, ids_actions.rowcount())
			if li_find > 0 then
				adw_track.setitem(al_row,"step_6",ids_actions.getitemdatetime(li_find,"action_date"))
			else 
				adw_track.setitem(al_row,"step_6",ldt_null)
			end if
		case 7
			//ll_step = dw_track.getitemnumber(1,"step_7_type")
			ll_step = long(gnv_data.of_getitem("app_steps","next step","6"))
			ls_find = "action_type = " + string(ll_step) + " and action_status = 90741"
			li_find = ids_actions.find( ls_find, 1, ids_actions.rowcount())
			if li_find > 0 then
				adw_track.setitem(al_row,"step_7",ids_actions.getitemdatetime(li_find,"action_date"))
			else 
				adw_track.setitem(al_row,"step_7",ldt_null)
			end if
		case 8
		//	ll_step = dw_track.getitemnumber(1,"step_8_type")
			ll_step = long(gnv_data.of_getitem("app_steps","next step","7"))
			ls_find = "action_type = " + string(ll_step) + " and action_status = 90741"
			li_find = ids_actions.find( ls_find, 1, ids_actions.rowcount())
			if li_find > 0 then 
				adw_track.setitem(al_row,"step_8",ids_actions.getitemdatetime(li_find,"action_date"))
			else 
				adw_track.setitem(al_row,"step_8",ldt_null)
			end if
		case 9
			//ll_step = dw_track.getitemnumber(1,"step_9_type")
			ll_step = long(gnv_data.of_getitem("app_steps","next step","8"))
			ls_find = "action_type = " + string(ll_step) + " and action_status = 90741"
			li_find = ids_actions.find( ls_find, 1, ids_actions.rowcount())
			if li_find > 0 then 
				adw_track.setitem(al_row,"step_9",ids_actions.getitemdatetime(li_find,"action_date"))
			else 
				adw_track.setitem(al_row,"step_9",ldt_null)
			end if
		case 10
			//ll_step = dw_track.getitemnumber(1,"step_10_type")
			ll_step = long(gnv_data.of_getitem("app_steps","next step","9"))
			ls_find = "action_type = " + string(ll_step) + " and action_status = 90741"
			li_find = ids_actions.find( ls_find, 1, ids_actions.rowcount())
			if li_find > 0 then 
				adw_track.setitem(al_row,"step_10",ids_actions.getitemdatetime(li_find,"action_date"))
			else 
				adw_track.setitem(al_row,"step_10",ldt_null)
			end if
	end choose
	//End Code Change ----03.01.2012
next

return 1
end function

public function integer of_days (datawindow adw_track, long ll_row);date ld_d1
date ld_d2
date ld_d3
date ld_d4
date ld_d5
date ld_d6
date ld_d7
date ld_d8
date ld_d9
date ld_d10
integer li_steps
integer i
integer li_temp

li_steps = il_final_step


for i = 1 to li_steps
	choose case i
		case 1
			ld_d1 = date(adw_track.getitemdatetime(ll_row ,"step_1"))
		case 2
			ld_d2 = date(adw_track.getitemdatetime(ll_row,"step_2"))
			//if not isnull(ld_d2) then debugbreak()
			if not isnull(ld_d1) and not isnull(ld_d2) then
				li_temp = daysafter(ld_d1,ld_d2)
				adw_track.setitem(ll_row ,"days_1_2", li_temp)
			end if
		case 3
			ld_d3 = date(adw_track.getitemdatetime(ll_row ,"step_3"))
			if not isnull(ld_d2) and not isnull(ld_d3) then
				li_temp = daysafter(ld_d2,ld_d3)
				adw_track.setitem(ll_row ,"days_2_3", li_temp)
			end if
		case 4
			ld_d4 = date(adw_track.getitemdatetime(ll_row ,"step_4"))
			if not isnull(ld_d3) and not isnull(ld_d4) then
				li_temp = daysafter(ld_d3,ld_d4)
				adw_track.setitem(ll_row ,"days_3_4", li_temp)
			end if
		case 5
			ld_d5 = date(adw_track.getitemdatetime(ll_row ,"step_5"))
			if not isnull(ld_d4) and not isnull(ld_d5) then
				li_temp = daysafter(ld_d4,ld_d5)
				adw_track.setitem(ll_row ,"days_4_5", li_temp)
			end if
		case 6
			ld_d6 = date(adw_track.getitemdatetime(ll_row ,"step_6"))
			if not isnull(ld_d5) and not isnull(ld_d6) then
				li_temp = daysafter(ld_d5,ld_d6)
				adw_track.setitem(ll_row ,"days_5_6", li_temp)
			end if
		case 7
			ld_d7 = date(adw_track.getitemdatetime(ll_row ,"step_7"))
			if not isnull(ld_d6) and not isnull(ld_d7) then
				li_temp = daysafter(ld_d6,ld_d7)
				adw_track.setitem(ll_row ,"days_6_7", li_temp)
			end if
		case 8
			ld_d8 = date(adw_track.getitemdatetime(ll_row ,"step_8"))
			if not isnull(ld_d7) and not isnull(ld_d8) then
				li_temp = daysafter(ld_d7,ld_d8)
				adw_track.setitem(ll_row ,"days_7_8", li_temp)
			end if
		case 9
			ld_d9 = date(adw_track.getitemdatetime(ll_row ,"step_9"))
			if not isnull(ld_d8) and not isnull(ld_d9) then
				li_temp = daysafter(ld_d8,ld_d9)
				adw_track.setitem(ll_row ,"days_8_9", li_temp)
			end if
		case 10
			ld_d10 = date(adw_track.getitemdatetime(ll_row ,"step_10"))
			if not isnull(ld_d9) and not isnull(ld_d10) then
				li_temp = daysafter(ld_d9,ld_d10)
				adw_track.setitem(ll_row ,"days_9_10", li_temp)
			end if
				
	end choose
next


//calc total
choose case li_steps
	case 2
		if not isnull(ld_d1) and not isnull(ld_d2) then
			li_temp = daysafter(ld_d1,ld_d2)
			adw_track.setitem(ll_row ,"days_total", li_temp)
		end if
	case 3
		if not isnull(ld_d1) and not isnull(ld_d3) then
			li_temp = daysafter(ld_d1,ld_d3)
			adw_track.setitem(ll_row ,"days_total", li_temp)
		end if
	case 4
		if not isnull(ld_d1) and not isnull(ld_d4) then
			li_temp = daysafter(ld_d1,ld_d4)
			adw_track.setitem(ll_row ,"days_total", li_temp)
		end if
	case 5
		if not isnull(ld_d1) and not isnull(ld_d5) then
			li_temp = daysafter(ld_d1,ld_d5)
			adw_track.setitem(ll_row ,"days_total", li_temp)
		end if
	case 6
		if not isnull(ld_d1) and not isnull(ld_d6) then
			li_temp = daysafter(ld_d1,ld_d6)
			adw_track.setitem(ll_row ,"days_total", li_temp)
		end if
	case 7
		if not isnull(ld_d1) and not isnull(ld_d7) then
			li_temp = daysafter(ld_d1,ld_d7)
			adw_track.setitem(ll_row ,"days_total", li_temp)
		end if
	case 8
		if not isnull(ld_d1) and not isnull(ld_d8) then
			li_temp = daysafter(ld_d1,ld_d8)
			adw_track.setitem(ll_row ,"days_total", li_temp)
		end if
	case 9
		if not isnull(ld_d1) and not isnull(ld_d9) then
			li_temp = daysafter(ld_d1,ld_d9)
			adw_track.setitem(ll_row ,"days_total", li_temp)
		end if
	case 10
		if not isnull(ld_d1) and not isnull(ld_d10) then
			li_temp = daysafter(ld_d1,ld_d10)
			adw_track.setitem(ll_row ,"days_total", li_temp)
		end if
end choose


return 1


end function

public function integer of_delete_dups ();long r
long rc
long ac
long org
long f
long ll_app
long ll_fac
long ll_prac
long ll_pracs[]
long cnt
long nr
long ll_loc //maha 04.24.2014
long ll_tid = 0
string ls_find

f = messagebox("Duplicate check","This utility will check for duplicate application tracking records and delete any extra ones.  Do you wish to continue?", question!, Yesno!, 1)
if f = 2 then return 1

dw_dupe.settransobject(sqlca)
dw_dup_fix.settransobject(sqlca)

rc = dw_dupe.retrieve()


for r = 1 to rc
	ll_pracs[r] = dw_dupe.getitemnumber(r,"prac_id")
next

if upperbound(ll_pracs) = 0 then
	messagebox("Duplicate Check", "No duplicates found")
	return 1
end if
	

ac = dw_dup_fix.retrieve(ll_pracs)

for r = 1 to rc
	ll_app = dw_dupe.getitemnumber(r,"app_id")
	ll_fac = dw_dupe.getitemnumber(r,"facility_id")
	ll_prac = dw_dupe.getitemnumber(r,"prac_id")
	ll_loc = dw_dupe.getitemnumber(r,"gp_id") 
	  
	//ls_find =  "app_id = " + string(ll_app) + " and facility_id = " + string(ll_fac) + " and prac_id = " + string(ll_prac) 
	ls_find =  "app_id = " + string(ll_app) + " and facility_id = " + string(ll_fac) + " and prac_id = " + string(ll_prac)  + " and gp_id = " + string(ll_loc) 
	//End Code Change ----04.24.2014

	//filter for specific
	f = dw_dup_fix.setfilter(ls_find)
	dw_dup_fix.filter()
	
	//delete extra records
	cnt = dw_dup_fix.rowcount()
debugbreak()
	for f = 2 to cnt
		dw_dup_fix.deleterow(2)
		org++
	next
	
	if Mod ( r, 10 ) = 0 then st_count.text = string(r)
next

st_count.text = string(rc)

dw_dup_fix.update()

messagebox("Duplicate check", string(org) + " duplicate Tracking records found and deleted. ")

		


return 1

end function

on w_appl_tracking_cleanup.create
this.dw_1=create dw_1
this.dw_actions=create dw_actions
this.dw_tracks=create dw_tracks
this.rb_dup=create rb_dup
this.dw_dup_fix=create dw_dup_fix
this.dw_dupe=create dw_dupe
this.dw_missing=create dw_missing
this.rb_calc=create rb_calc
this.rb_missing=create rb_missing
this.rb_delete=create rb_delete
this.st_count=create st_count
this.dw_apps=create dw_apps
this.cb_close=create cb_close
this.cb_run=create cb_run
this.gb_1=create gb_1
this.Control[]={this.dw_1,&
this.dw_actions,&
this.dw_tracks,&
this.rb_dup,&
this.dw_dup_fix,&
this.dw_dupe,&
this.dw_missing,&
this.rb_calc,&
this.rb_missing,&
this.rb_delete,&
this.st_count,&
this.dw_apps,&
this.cb_close,&
this.cb_run,&
this.gb_1}
end on

on w_appl_tracking_cleanup.destroy
destroy(this.dw_1)
destroy(this.dw_actions)
destroy(this.dw_tracks)
destroy(this.rb_dup)
destroy(this.dw_dup_fix)
destroy(this.dw_dupe)
destroy(this.dw_missing)
destroy(this.rb_calc)
destroy(this.rb_missing)
destroy(this.rb_delete)
destroy(this.st_count)
destroy(this.dw_apps)
destroy(this.cb_close)
destroy(this.cb_run)
destroy(this.gb_1)
end on

type dw_1 from datawindow within w_appl_tracking_cleanup
integer x = 1321
integer y = 836
integer width = 357
integer height = 108
integer taborder = 50
string title = "none"
string dataobject = "d_appl_track_cleanup_notexists"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_actions from u_dw within w_appl_tracking_cleanup
integer x = 261
integer y = 1092
integer width = 210
integer height = 128
integer taborder = 70
string dataobject = "d_net_dev_action_items_tracking"
end type

type dw_tracks from u_dw within w_appl_tracking_cleanup
integer x = 69
integer y = 1108
integer width = 137
integer height = 100
integer taborder = 70
string dataobject = "d_appl_tracking_cleanup_utl"
end type

type rb_dup from radiobutton within w_appl_tracking_cleanup
integer x = 183
integer y = 384
integer width = 1088
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Check for Duplicate tracking records"
end type

type dw_dup_fix from datawindow within w_appl_tracking_cleanup
integer x = 695
integer y = 892
integer width = 608
integer height = 144
integer taborder = 60
string title = "none"
string dataobject = "d_appl_tracking_cleanup_dups"
boolean livescroll = true
end type

type dw_dupe from datawindow within w_appl_tracking_cleanup
integer x = 142
integer y = 892
integer width = 489
integer height = 144
integer taborder = 50
string title = "none"
string dataobject = "d_appl_tracking_dup_records"
boolean resizable = true
boolean livescroll = true
end type

type dw_missing from datawindow within w_appl_tracking_cleanup
integer x = 1074
integer y = 644
integer width = 370
integer height = 104
integer taborder = 40
string title = "none"
string dataobject = "d_appl_tracking_cleanup_utl"
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type rb_calc from radiobutton within w_appl_tracking_cleanup
integer x = 183
integer y = 464
integer width = 1362
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Recalculate all tracking dates (may take awhile to run)"
end type

type rb_missing from radiobutton within w_appl_tracking_cleanup
integer x = 183
integer y = 300
integer width = 1038
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Check for Missing tracking records"
end type

type rb_delete from radiobutton within w_appl_tracking_cleanup
integer x = 183
integer y = 224
integer width = 1047
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Check for Unlinked tracking records"
boolean checked = true
end type

type st_count from statictext within w_appl_tracking_cleanup
integer x = 123
integer y = 56
integer width = 357
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "0"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_apps from datawindow within w_appl_tracking_cleanup
integer x = 553
integer y = 644
integer width = 357
integer height = 108
integer taborder = 40
string title = "none"
string dataobject = "d_appl_track_cleanup_actions"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_close from commandbutton within w_appl_tracking_cleanup
integer x = 1216
integer y = 40
integer width = 343
integer height = 92
integer taborder = 20
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

type cb_run from commandbutton within w_appl_tracking_cleanup
integer x = 823
integer y = 40
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Run"
end type

event clicked;//Start Code Change ----11.14.2012 #V12 maha

if rb_delete.checked then
	of_check_for_orphan()
elseif rb_missing.checked then
	of_check_missing( )
elseif rb_dup.checked then
	of_delete_dups()
else
	of_calc_dates( dw_tracks )
end if


end event

type gb_1 from groupbox within w_appl_tracking_cleanup
integer x = 96
integer y = 152
integer width = 1463
integer height = 412
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Utility"
end type

