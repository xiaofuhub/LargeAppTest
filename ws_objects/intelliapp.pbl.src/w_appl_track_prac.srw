$PBExportHeader$w_appl_track_prac.srw
forward
global type w_appl_track_prac from window
end type
type cb_2 from commandbutton within w_appl_track_prac
end type
type cb_add from commandbutton within w_appl_track_prac
end type
type dw_tv from datawindow within w_appl_track_prac
end type
type cb_1 from commandbutton within w_appl_track_prac
end type
type dw_print from datawindow within w_appl_track_prac
end type
type st_2 from statictext within w_appl_track_prac
end type
type st_1 from statictext within w_appl_track_prac
end type
type dw_actions from u_dw within w_appl_track_prac
end type
type cb_save from commandbutton within w_appl_track_prac
end type
type cb_close from commandbutton within w_appl_track_prac
end type
type dw_track from u_dw within w_appl_track_prac
end type
type cb_print from commandbutton within w_appl_track_prac
end type
end forward

global type w_appl_track_prac from window
integer width = 4425
integer height = 1880
boolean titlebar = true
string title = "Application Process Tracking"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
cb_add cb_add
dw_tv dw_tv
cb_1 cb_1
dw_print dw_print
st_2 st_2
st_1 st_1
dw_actions dw_actions
cb_save cb_save
cb_close cb_close
dw_track dw_track
cb_print cb_print
end type
global w_appl_track_prac w_appl_track_prac

type variables
long il_prac
long il_app
long il_fac
long il_loc
integer il_final_step
end variables

forward prototypes
public function integer of_calculate_days ()
public function integer of_calculate ()
public function integer of_calculate_dates ()
public function integer of_set_par_status ()
end prototypes

public function integer of_calculate_days ();//@@@@ NOT USED @@@@@@@

////Start Code Change ----07.21.2010 #V10 maha - calculating the days between the dates
date ld_d1
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
			ld_d1 = date(dw_track.getitemdatetime(1,"step_1"))
		case 2
			ld_d2 = date(dw_track.getitemdatetime(1,"step_2"))
			if not isnull(ld_d1) and not isnull(ld_d2) then
				li_temp = daysafter(ld_d1,ld_d2)
				dw_track.setitem(1,"days_1_2", li_temp)
			end if
		case 3
			ld_d3 = date(dw_track.getitemdatetime(1,"step_3"))
			if not isnull(ld_d2) and not isnull(ld_d3) then
				li_temp = daysafter(ld_d2,ld_d3)
				dw_track.setitem(1,"days_2_3", li_temp)
			end if
		case 4
			ld_d4 = date(dw_track.getitemdatetime(1,"step_4"))
			if not isnull(ld_d3) and not isnull(ld_d4) then
				li_temp = daysafter(ld_d3,ld_d4)
				dw_track.setitem(1,"days_3_4", li_temp)
			end if
		case 5
			ld_d5 = date(dw_track.getitemdatetime(1,"step_5"))
			if not isnull(ld_d4) and not isnull(ld_d5) then
				li_temp = daysafter(ld_d4,ld_d5)
				dw_track.setitem(1,"days_4_5", li_temp)
			end if
		case 6
			ld_d6 = date(dw_track.getitemdatetime(1,"step_6"))
			if not isnull(ld_d5) and not isnull(ld_d6) then
				li_temp = daysafter(ld_d5,ld_d6)
				dw_track.setitem(1,"days_5_6", li_temp)
			end if
		case 7
			ld_d7 = date(dw_track.getitemdatetime(1,"step_7"))
			if not isnull(ld_d6) and not isnull(ld_d7) then
				li_temp = daysafter(ld_d6,ld_d7)
				dw_track.setitem(1,"days_6_7", li_temp)
			end if
		case 8
			ld_d8 = date(dw_track.getitemdatetime(1,"step_8"))
			if not isnull(ld_d7) and not isnull(ld_d8) then
				li_temp = daysafter(ld_d7,ld_d8)
				dw_track.setitem(1,"days_7_8", li_temp)
			end if
		case 9
			ld_d9 = date(dw_track.getitemdatetime(1,"step_9"))
			if not isnull(ld_d8) and not isnull(ld_d9) then
				li_temp = daysafter(ld_d8,ld_d9)
				dw_track.setitem(1,"days_8_9", li_temp)
			end if
		case 10
			ld_d10 = date(dw_track.getitemdatetime(1,"step_10"))
			if not isnull(ld_d9) and not isnull(ld_d10) then
				li_temp = daysafter(ld_d9,ld_d10)
				dw_track.setitem(1,"days_9_10", li_temp)
			end if
				
	end choose
next


//calc total
choose case li_steps
	case 2
		if not isnull(ld_d1) and not isnull(ld_d2) then
			li_temp = daysafter(ld_d1,ld_d2)
			dw_track.setitem(1,"days_total", li_temp)
		end if
	case 3
		if not isnull(ld_d1) and not isnull(ld_d3) then
			li_temp = daysafter(ld_d1,ld_d3)
			dw_track.setitem(1,"days_total", li_temp)
		end if
	case 4
		if not isnull(ld_d1) and not isnull(ld_d4) then
			li_temp = daysafter(ld_d1,ld_d4)
			dw_track.setitem(1,"days_total", li_temp)
		end if
	case 5
		if not isnull(ld_d1) and not isnull(ld_d5) then
			li_temp = daysafter(ld_d1,ld_d5)
			dw_track.setitem(1,"days_total", li_temp)
		end if
	case 6
		if not isnull(ld_d1) and not isnull(ld_d6) then
			li_temp = daysafter(ld_d1,ld_d6)
			dw_track.setitem(1,"days_total", li_temp)
		end if
	case 7
		if not isnull(ld_d1) and not isnull(ld_d7) then
			li_temp = daysafter(ld_d1,ld_d7)
			dw_track.setitem(1,"days_total", li_temp)
		end if
	case 8
		if not isnull(ld_d1) and not isnull(ld_d8) then
			li_temp = daysafter(ld_d1,ld_d8)
			dw_track.setitem(1,"days_total", li_temp)
		end if
	case 9
		if not isnull(ld_d1) and not isnull(ld_d9) then
			li_temp = daysafter(ld_d1,ld_d9)
			dw_track.setitem(1,"days_total", li_temp)
		end if
	case 10
		if not isnull(ld_d1) and not isnull(ld_d10) then
			li_temp = daysafter(ld_d1,ld_d10)
			dw_track.setitem(1,"days_total", li_temp)
		end if
end choose


return 1


end function

public function integer of_calculate (); //Start Code Change ----08.12.2015 #V15 maha - replaced with external function
of_appl_tracking_update_dw(dw_track , dw_actions, 1)

//of_calculate_dates()
//of_calculate_days( )
//
//dw_track.update()

return 1
end function

public function integer of_calculate_dates ();//@@@@ NOT USED @@@@@@@


//Start Code Change ----07.21.2010 #V10 maha - set the dates from actions
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
			li_find = dw_actions.find( ls_find, 1, dw_actions.rowcount())
			if li_find > 0 then
				dw_track.setitem(1,"step_1",dw_actions.getitemdatetime(li_find,"action_date"))
			else //Start Code Change ----03.30.2011 #V11 maha - for each step, if the action does not exist clear the date
				dw_track.setitem(1,"step_1",ldt_null)
			end if
		case 2
		//	ll_step = dw_track.getitemnumber(1,"step_2_type")
			ll_step = long(gnv_data.of_getitem("app_steps","next step","1"))
			ls_find = "action_type = " + string(ll_step) + " and action_status = 90741"
			li_find = dw_actions.find( ls_find, 1, dw_actions.rowcount())
			if li_find > 0 then 
				dw_track.setitem(1,"step_2",dw_actions.getitemdatetime(li_find,"action_date"))
			else 
				dw_track.setitem(1,"step_2",ldt_null)
			end if
		case 3
			//ll_step = dw_track.getitemnumber(1,"step_3_type")
			ll_step = long(gnv_data.of_getitem("app_steps","next step","2"))
			ls_find = "action_type = " + string(ll_step) + " and action_status = 90741"
			li_find = dw_actions.find( ls_find, 1, dw_actions.rowcount())
			if li_find > 0 then 
				dw_track.setitem(1,"step_3",dw_actions.getitemdatetime(li_find,"action_date"))
			else 
				dw_track.setitem(1,"step_3",ldt_null)
			end if
		case 4
			//ll_step = dw_track.getitemnumber(1,"step_4_type")
			ll_step = long(gnv_data.of_getitem("app_steps","next step","3"))
			ls_find = "action_type = " + string(ll_step) + " and action_status = 90741"
			li_find = dw_actions.find( ls_find, 1, dw_actions.rowcount())
			if li_find > 0 then
				dw_track.setitem(1,"step_4",dw_actions.getitemdatetime(li_find,"action_date"))
			else 
				dw_track.setitem(1,"step_4",ldt_null)
			end if
		case 5
			//ll_step = dw_track.getitemnumber(1,"step_5_type")
			ll_step = long(gnv_data.of_getitem("app_steps","next step","4"))
			ls_find = "action_type = " + string(ll_step) + " and action_status = 90741"
			li_find = dw_actions.find( ls_find, 1, dw_actions.rowcount())
			if li_find > 0 then
				dw_track.setitem(1,"step_5",dw_actions.getitemdatetime(li_find,"action_date"))
			else 
				dw_track.setitem(1,"step_5",ldt_null)
			end if
		case 6
		//	ll_step = dw_track.getitemnumber(1,"step_6_type")
			ll_step = long(gnv_data.of_getitem("app_steps","next step","5"))
			ls_find = "action_type = " + string(ll_step) + " and action_status = 90741"
			li_find = dw_actions.find( ls_find, 1, dw_actions.rowcount())
			if li_find > 0 then
				dw_track.setitem(1,"step_6",dw_actions.getitemdatetime(li_find,"action_date"))
			else 
				dw_track.setitem(1,"step_6",ldt_null)
			end if
		case 7
			//ll_step = dw_track.getitemnumber(1,"step_7_type")
			ll_step = long(gnv_data.of_getitem("app_steps","next step","6"))
			ls_find = "action_type = " + string(ll_step) + " and action_status = 90741"
			li_find = dw_actions.find( ls_find, 1, dw_actions.rowcount())
			if li_find > 0 then
				dw_track.setitem(1,"step_7",dw_actions.getitemdatetime(li_find,"action_date"))
			else 
				dw_track.setitem(1,"step_7",ldt_null)
			end if
		case 8
		//	ll_step = dw_track.getitemnumber(1,"step_8_type")
			ll_step = long(gnv_data.of_getitem("app_steps","next step","7"))
			ls_find = "action_type = " + string(ll_step) + " and action_status = 90741"
			li_find = dw_actions.find( ls_find, 1, dw_actions.rowcount())
			if li_find > 0 then 
				dw_track.setitem(1,"step_8",dw_actions.getitemdatetime(li_find,"action_date"))
			else 
				dw_track.setitem(1,"step_8",ldt_null)
			end if
		case 9
			//ll_step = dw_track.getitemnumber(1,"step_9_type")
			ll_step = long(gnv_data.of_getitem("app_steps","next step","8"))
			ls_find = "action_type = " + string(ll_step) + " and action_status = 90741"
			li_find = dw_actions.find( ls_find, 1, dw_actions.rowcount())
			if li_find > 0 then 
				dw_track.setitem(1,"step_9",dw_actions.getitemdatetime(li_find,"action_date"))
			else 
				dw_track.setitem(1,"step_9",ldt_null)
			end if
		case 10
			//ll_step = dw_track.getitemnumber(1,"step_10_type")
			ll_step = long(gnv_data.of_getitem("app_steps","next step","9"))
			ls_find = "action_type = " + string(ll_step) + " and action_status = 90741"
			li_find = dw_actions.find( ls_find, 1, dw_actions.rowcount())
			if li_find > 0 then 
				dw_track.setitem(1,"step_10",dw_actions.getitemdatetime(li_find,"action_date"))
			else 
				dw_track.setitem(1,"step_10",ldt_null)
			end if
	end choose
	//End Code Change ----03.01.2012
next

return 1
end function

public function integer of_set_par_status ();


//added by long.zhang 10.23.2012 copied and Modified from pfc_ia_cst_nv_net_dev_new.of_set_par_status()
long ll_app
long ll_fac
long ll_prac
long ll_find
long ll_row
integer li_stat
string ls_find

ll_row =dw_track.getrow()
if ll_row < 1 then return 0

dw_track.AcceptText()
ll_prac = dw_track.getitemnumber( ll_row,"prac_id") 
ll_app = dw_track.getitemnumber( ll_row,"app_id") 
ll_fac = dw_track.getitemnumber( ll_row,"facility_id") 
li_stat =  dw_track.getitemnumber( ll_row,"par_status") 

ls_find = "prac_id = " + string(ll_prac) + " and app_id = " + string(ll_app) + " and parent_facility_id = " + string(ll_fac) 
ll_find = dw_tv.find( ls_find, 1, dw_tv.rowcount())
if ll_find > 0 then 
	dw_tv.setitem(ll_find,"pd_appl_tracking_par_status",li_stat)
end if

return 0
end function

event open;//Start Code Change ----07.21.2010 #V10 maha - window created for version 10.2

integer r
integer f
long ll_id
boolean lb_add  //maha 10.15.2012
gs_pass_ids lst_ids
datawindowchild dwchild

lst_ids = message.powerobjectparm
il_prac = lst_ids.prac_id
dw_tv.retrieve(il_prac,gs_user_id )


il_prac = lst_ids.prac_id
il_app = lst_ids.l_app_id
il_fac = lst_ids.facility_id
il_loc = lst_ids.l_loc_ids[1]  //Start Code Change ----05.22.2014 #V14.2 maha

dw_actions.retrieve(il_prac,il_app,il_fac, il_loc) //alfee 10.28.2014 - added argument for BugA102801. 
r = dw_track.retrieve(il_prac,il_app,il_fac, il_loc)  //Start Code Change ----05.22.2014 #V14.2 maha - added argument
//if r < 0 then messagebox("",r)
il_final_step = integer(gnv_data.of_getitem("app_steps","last step",""))

//Start Code Change ----03.29.2012 #V12 maha
if w_mdi.of_security_access(1400) = 1 then //read only
	cb_add.visible = false
	cb_save.visible = false
	cb_1.visible = false
	cb_2.visible = false
	return
end if
//End Code Change ----03.29.2012


//if no tracking record, add, save and re-retrieve
//Start Code Change ----10.15.2012 #V12 maha - modified to allow for historical records. 
if r = 0 then
	lb_add = true
//	dw_track.insertrow(1)
//	dw_track.setitem(1,"prac_id",il_prac)
//	dw_track.setitem(1,"app_id",il_app)
//	dw_track.setitem(1,"facility_id",il_fac)
//	dw_track.setitem(1,"active_status",1)  //Start Code Change ----12.09.2010 #V10 maha
//	select max(track_id) into :ll_id from pd_appl_tracking;
//	if isnull(ll_id) then ll_id = 0
//	ll_id++
//	dw_track.setitem(1,"track_id",ll_id)
//	r = dw_track.update()
//	r = dw_track.retrieve(il_prac,il_app,il_fac)
elseif dw_track.getitemnumber(1,"active_status") = 0 then //if a historical records exists
	lb_add = true
else
	lb_add = false
	f = dw_tv.find( "prac_id = " + string(il_prac)  + " and parent_facility_id = " + string(il_fac) + " and app_id = " + string(il_app)    ,  1, 100000)
	if f > 0 then
		dw_tv.selectrow(0,false)
		dw_tv.selectrow(f,true)
	end if
end if

if lb_add then
	dw_track.insertrow(1)
	dw_track.setitem(1,"prac_id",il_prac)
	dw_track.setitem(1,"app_id",il_app)
	dw_track.setitem(1,"facility_id",il_fac)
	dw_track.setitem(1,"active_status",1)  //Start Code Change ----12.09.2010 #V10 maha
	dw_track.setitem(1,"gp_id",il_loc)  //Add il_loc, by Appeon long.zhang 04.22.2016
	//Modified by (appeon) Harry 10.16.2017
	/*
	select max(track_id) into :ll_id from pd_appl_tracking;
	if isnull(ll_id) then ll_id = 0
	ll_id++
	*/
	ll_id =  gnv_app.of_get_id("track_id")
	dw_track.setitem(1,"track_id",ll_id)
	r = dw_track.update()
	//r = dw_track.retrieve(il_prac,il_app,il_fac)
	r = dw_track.retrieve(il_prac,il_app,il_fac, il_loc) //Add il_loc, by Appeon long.zhang 04.22.2016
end if

dw_track.getchild( "gp_id", dwchild)
dwchild.settransobject(sqlca)
dwchild.retrieve(il_prac)


//of_calculate()



end event

on w_appl_track_prac.create
this.cb_2=create cb_2
this.cb_add=create cb_add
this.dw_tv=create dw_tv
this.cb_1=create cb_1
this.dw_print=create dw_print
this.st_2=create st_2
this.st_1=create st_1
this.dw_actions=create dw_actions
this.cb_save=create cb_save
this.cb_close=create cb_close
this.dw_track=create dw_track
this.cb_print=create cb_print
this.Control[]={this.cb_2,&
this.cb_add,&
this.dw_tv,&
this.cb_1,&
this.dw_print,&
this.st_2,&
this.st_1,&
this.dw_actions,&
this.cb_save,&
this.cb_close,&
this.dw_track,&
this.cb_print}
end on

on w_appl_track_prac.destroy
destroy(this.cb_2)
destroy(this.cb_add)
destroy(this.dw_tv)
destroy(this.cb_1)
destroy(this.dw_print)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_actions)
destroy(this.cb_save)
destroy(this.cb_close)
destroy(this.dw_track)
destroy(this.cb_print)
end on

type cb_2 from commandbutton within w_appl_track_prac
integer x = 1911
integer y = 12
integer width = 443
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Scan for Missing"
end type

event clicked;long r
long rc
long ll_fac
long ll_prac
long ll_app
long ll_id
long ll_loc //maha 04.24.2014
long cr
integer p
integer cnt

cr = dw_tv.getrow()

rc = dw_tv.rowcount()

for r = 1 to rc
	ll_app = dw_tv.getitemnumber(r, "app_id")
	ll_fac = dw_tv.getitemnumber(r, "parent_facility_id")
	ll_prac = dw_tv.getitemnumber(r, "prac_id")
	ll_loc = dw_tv.getitemnumber(r, "gp_id") //Start Code Change ----05.20.2014 #V14.2 maha
	
	if isnull(ll_app) or ll_app = 0 then
		continue
	elseif isnull(ll_fac) or ll_fac = 0 then  //Start Code Change ----05.23.2014 #V14.2 maha - corrected variable name
		continue
	else
		p = dw_track.retrieve(ll_prac,ll_app,ll_fac, ll_loc)  //Start Code Change ----04.24.2014 #V14.2 maha
		dw_actions.retrieve(ll_prac,ll_app,ll_fac, ll_loc)  //Start Code Change ----04.24.2014 #V14.2 maha
		debugbreak()
		if p = 0 then
			dw_track.insertrow(1)
			dw_track.setitem(1,"prac_id",ll_prac)
			dw_track.setitem(1,"app_id",ll_app)
			dw_track.setitem(1,"facility_id",ll_fac) 
			dw_track.setitem(1,"gp_id",ll_loc)   //Start Code Change ----04.24.2014 #V14.2 maha
			dw_track.setitem(1,"active_status",1)  //Start Code Change ----12.09.2010 #V10 maha
			
			//Commented by (appeon) Harry 10.16.2017
			/*
			select max(track_id) into :ll_id from pd_appl_tracking;
			if isnull(ll_id) then ll_id = 0
			ll_id++
			*/
			ll_id =  gnv_app.of_get_id("track_id")

			dw_track.setitem(1,"track_id",ll_id)

			cnt++
		else
			
		end if

		of_calculate()
		dw_track.accepttext()
//		debugbreak()
		dw_track.update()
		
	end if
	
next
messagebox("Tracking Records Added",string(cnt) +  " tracking records were added for this Provider." )
dw_tv.setrow(cr)

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 11.19.2014
//<$>reason:add argument il_loc
//dw_track.retrieve(il_prac,il_app,il_fac)
//dw_actions.retrieve(il_prac,il_app,il_fac)
dw_track.retrieve(il_prac,il_app,il_fac,il_loc)
dw_actions.retrieve(il_prac,il_app,il_fac,il_loc)
//------------------- APPEON END -------------------

end event

type cb_add from commandbutton within w_appl_track_prac
integer x = 2377
integer y = 12
integer width = 343
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
end type

event clicked;//Start Code Change ----06.07.2010 #V11 maha - added
long ll_id
integer r

dw_track.insertrow(1)
dw_track.setitem(1,"prac_id",il_prac)
dw_track.setitem(1,"app_id",il_app)
dw_track.setitem(1,"facility_id",il_fac)
dw_track.setitem(1,"gp_id",il_loc)  //Start Code Change ----04.24.2014 #V14.2 maha
dw_track.setitem(1,"active_status",1)  //Start Code Change ----12.09.2010 #V10 maha
//Modified by (appeon) Harry 10.16.2017
/*
select max(track_id) into :ll_id from pd_appl_tracking;
if isnull(ll_id) then ll_id = 0
ll_id++
*/
ll_id =  gnv_app.of_get_id("track_id")
dw_track.setitem(1,"track_id",ll_id)
r = dw_track.update()
r = dw_track.retrieve(il_prac,il_app,il_fac, il_loc)
this.visible = false

end event

type dw_tv from datawindow within w_appl_track_prac
integer x = 14
integer y = 116
integer width = 905
integer height = 1680
integer taborder = 20
string title = "none"
string dataobject = "d_net_dev_tv_w_loc_w_inactive"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;//Start Code Change ----04.16.2015 #V15.1 maha - changed to case; added two level option
choose case gi_intelliapp_type
	case 1,2 //three level
		this.dataobject = 'd_net_dev_tv_w_loc_w_inactive'  //Start Code Change ----04.08.2014 #V14.2 maha
	case 3  //two level
		this.dataobject = 'd_net_dev_tv_2_level'  //Start Code Change ----04.08.2014 #V14.2 maha
	case 0
		//
end choose

this.settransobject(sqlca)
end event

event clicked;Integer li_retval
Integer li_row

//--------Begin Added by alfee 09.14.2010 -----------
//SK Practitioner Folder
string  ls_dw_band
str_dw_band lstr_band

if gi_intelliapp_type > 0 then //non single group
	ls_dw_band = this.GetBandAtPointer()
	lstr_band = of_parse_bandinfo (ls_dw_band)
	
	if lstr_band.band = 'tree.level.1' then 
		if not this.isexpanded(lstr_band.row, 1)  then this.expand( lstr_band.row, 1)
	end if
	return //
end if
//--------End Added --------------------------------------


IF li_retval < 0 THEN
	Return 1
END IF

li_row = This.GetClickedRow( )

This.SetRow( li_row )
end event

event rowfocuschanged;// //Start Code Change ----06.07.2011 #V11 maha - added

integer r


il_app = this.getitemnumber(currentrow,"app_id")
il_fac = this.getitemnumber(currentrow,"parent_facility_id")
il_prac = this.getitemnumber(currentrow,"prac_id")
il_loc = this.getitemnumber(currentrow,"gp_id") //Start Code Change ----04.24.2014 #V14.2 maha

This.SelectRow( 0, False )
This.SelectRow( currentrow, True )
This.ScrollToRow( currentrow )

if isnull(il_app) or il_app = 0 then
	dw_track.reset()
	dw_actions.reset()
	r = 1
elseif isnull(il_fac) or il_app = 0 then
	dw_track.reset()
	dw_actions.reset()
	r = 1
else
	r = dw_track.retrieve(il_prac,il_app,il_fac, il_loc)  //Start Code Change ----04.24.2014 #V14.2 maha - added loc
	dw_actions.retrieve(il_prac,il_app,il_fac, il_loc)   //Start Code Change ----04.24.2014 #V14.2 maha - added loc
end if

if r = 0 then 
	cb_add.visible = true
else
	cb_add.visible = false
end if

//IF row < 1 OR grouplevel < 1 THEN RETURN
//IF grouplevel = 1 THEN il_app_id = 0 //All applications or no application for the facility
end event

type cb_1 from commandbutton within w_appl_track_prac
integer x = 2747
integer y = 12
integer width = 343
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Recalculate"
end type

event clicked;if dw_track.rowcount( ) < 1 then return	//appeon long.zhang 02.22.2012
of_calculate()



end event

type dw_print from datawindow within w_appl_track_prac
boolean visible = false
integer x = 3383
integer y = 12
integer width = 119
integer height = 60
integer taborder = 40
string title = "none"
string dataobject = "d_pd_appl_tracking_report"
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_appl_track_prac
integer x = 937
integer y = 804
integer width = 471
integer height = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Current Actions"
boolean focusrectangle = false
end type

type st_1 from statictext within w_appl_track_prac
integer x = 928
integer y = 44
integer width = 512
integer height = 56
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Process Steps"
boolean focusrectangle = false
end type

type dw_actions from u_dw within w_appl_track_prac
integer x = 933
integer y = 868
integer width = 3433
integer height = 932
integer taborder = 20
string dataobject = "d_net_dev_action_items_tracking"
boolean hscrollbar = true
end type

event constructor;call super::constructor;this.settransobject(sqlca)
end event

event buttonclicked;call super::buttonclicked;//Start Code Change ----06.07.2011 #V11 maha - added code
IF dwo.name = 'b_notes' THEN
	//Start Code Change ----09.12.2012 #V12 maha - new exp. notes screen
	
	//---------Begin Modified by (Appeon)Harry 07.17.2014  for the Bug 4115
	//OpenWithParm( w_ai_notes_new, This.GetItemString( row, "notes" ))
	string ls_notes
	ls_notes = This.GetItemString( row, "notes" )
	if isnull(ls_notes) then ls_notes = ""
	OpenWithParm( w_ai_notes_new, ls_notes)
	//---------End Modfiied ------------------------------------------------------
//	IF appeongetclienttype() = 'WEB' THEN  
//		//OpenWithParm( w_ai_notes_web, "A" + This.GetItemString( row, "notes" ))
//		OpenWithParm( w_ai_notes_web, This.GetItemString( row, "notes" ))
//	ELSE		
//		//OpenWithParm( w_ai_notes, "A" + This.GetItemString( row, "notes" )) 
//		OpenWithParm( w_ai_notes, This.GetItemString( row, "notes" )) //changed by long.zhang 08.25.2011 - removed A from front
//	END IF	

	IF Message.StringParm = "Cancel" THEN
		Return -1
	ELSE
		This.SetItem( row, "notes", Message.StringParm )
		this.update() 
	END IF
End if
end event

event clicked;call super::clicked;//Start Code Change ----06.07.2011 #V11 maha - added
integer r

r = this.getclickedrow()
end event

type cb_save from commandbutton within w_appl_track_prac
integer x = 3643
integer y = 12
integer width = 343
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;//of_calculate()
//---------Begin Added by (Appeon)Stephen 06.03.2016 for V15.2-Application Tracking full Auditing--------
pfc_cst_nv_data_entry_functions lnv_data_entry
lnv_data_entry = create pfc_cst_nv_data_entry_functions
dw_track.accepttext()
lnv_data_entry.of_field_audit(dw_track)
destroy lnv_data_entry
//---------End Added ------------------------------------------------------

dw_actions.update()
dw_track.update()
end event

type cb_close from commandbutton within w_appl_track_prac
integer x = 4009
integer y = 12
integer width = 343
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;close(parent)
end event

type dw_track from u_dw within w_appl_track_prac
integer x = 933
integer y = 120
integer width = 3447
integer height = 680
integer taborder = 10
string dataobject = "d_pd_appl_tracking_w_loc"
boolean hscrollbar = true
end type

event constructor;call super::constructor;this.settransobject(sqlca)
end event

event updatestart;call super::updatestart;
long ll_id
if isnull(dw_track.getitemnumber(1,"track_id")) then
	//Modified by (appeon) Harry 10.16.2017
	/*
	select max(track_id) into :ll_id from pd_appl_tracking;
	if isnull(ll_id) then ll_id = 0
	ll_id++
	*/
	ll_id =  gnv_app.of_get_id("track_id")
	dw_track.setitem(1,"track_id",ll_id)
end if

return 0
end event

event pfc_preupdate;call super::pfc_preupdate;//Start Code Change ----12.09.2010 #V10 maha
if isnull(this.getitemnumber(1,"active_status")) then
	this.setitem(1,'active_status',1)
end if

return 1

end event

event updateend;call super::updateend;//For BugL100902 - long.zhang 09.23.2012

//return of_set_par_status () 
end event

type cb_print from commandbutton within w_appl_track_prac
integer x = 3109
integer y = 12
integer width = 517
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Print Process Report"
end type

event clicked;gs_report_variables lst_arg
//dw_print.settransobject(sqlca)
//dw_print.retrieve(il_prac,il_app,il_fac)
//dw_print.print()

lst_arg.as_report_object = "d_pd_appl_tracking_report"
lst_arg.ai_num_variables = 4   //Start Code Change ----05.20.2014 #V14.2 maha
lst_arg.as_var_type[1] = "N"
lst_arg.as_var_type[2] = "N"
lst_arg.as_var_type[3] = "N"
lst_arg.as_var_type[4] = "N"  //Start Code Change ----05.19.2014 #V14.2 maha
lst_arg.as_value[1] = string(il_prac)
lst_arg.as_value[2] = string(il_app)
lst_arg.as_value[3] = string(il_fac)
lst_arg.as_value[4] = string(il_loc)  //Start Code Change ----05.19.2014 #V14.2 maha
lst_arg.as_single = 'S'

openwithparm(w_report_view,lst_arg)






end event

