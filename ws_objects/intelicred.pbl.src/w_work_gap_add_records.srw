$PBExportHeader$w_work_gap_add_records.srw
forward
global type w_work_gap_add_records from window
end type
type cb_view from commandbutton within w_work_gap_add_records
end type
type cb_calc from commandbutton within w_work_gap_add_records
end type
type sle_days from singlelineedit within w_work_gap_add_records
end type
type st_1 from statictext within w_work_gap_add_records
end type
type cbx_pro from checkbox within w_work_gap_add_records
end type
type cbx_hosp from checkbox within w_work_gap_add_records
end type
type cbx_train from checkbox within w_work_gap_add_records
end type
type cbx_ed from checkbox within w_work_gap_add_records
end type
type dw_records from datawindow within w_work_gap_add_records
end type
type st_recs from statictext within w_work_gap_add_records
end type
type st_name from statictext within w_work_gap_add_records
end type
type dw_1 from datawindow within w_work_gap_add_records
end type
type cb_2 from commandbutton within w_work_gap_add_records
end type
type cb_add from commandbutton within w_work_gap_add_records
end type
type gb_1 from groupbox within w_work_gap_add_records
end type
end forward

global type w_work_gap_add_records from window
integer width = 2661
integer height = 2280
boolean titlebar = true
string title = "Work Gap"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_view cb_view
cb_calc cb_calc
sle_days sle_days
st_1 st_1
cbx_pro cbx_pro
cbx_hosp cbx_hosp
cbx_train cbx_train
cbx_ed cbx_ed
dw_records dw_records
st_recs st_recs
st_name st_name
dw_1 dw_1
cb_2 cb_2
cb_add cb_add
gb_1 gb_1
end type
global w_work_gap_add_records w_work_gap_add_records

type variables
long il_prac
boolean ib_calc_was_run = false
end variables

forward prototypes
public subroutine of_filter ()
public subroutine of_calc ()
end prototypes

public subroutine of_filter ();//Start Code Change ----02.07.2013 #V12 maha
string ls_filter


if cbx_ed.checked then 	ls_filter = "screen_type = 'E' "

if cbx_train.checked then 
	if len(ls_filter) > 0 then ls_filter+= " or "
	ls_filter+= "screen_type = 'T' "
end if

if cbx_hosp.checked then 
	if len(ls_filter) > 0 then ls_filter+= " or "
	ls_filter+= "screen_type = 'H' "
end if

if cbx_pro.checked then 
	if len(ls_filter) > 0 then ls_filter+= " or "
	ls_filter+= "screen_type = 'P' "
end if

//messagebox("",ls_filter)
dw_records.setfilter(ls_filter)
dw_records.filter()



return
end subroutine

public subroutine of_calc ();
//Start Code Change ----02.07.2013 #V12 maha - copied from global function and modified

integer r
integer rc
integer li_return = 1
integer nr
integer cnt = 0
long d
date ld_from
date ld_to
date ld_pfrom
date ld_pto
date ld_blankfrom
date ld_blankto
integer li_days = 30
string ls_type //maha 07.10.2012

if ib_calc_was_run = true then
	dw_records.retrieve(il_prac)
	of_filter()
	dw_1.reset()
end if

if isnumber(sle_days.text) then
	li_days = integer(sle_days.text)
else
	messagebox("Gap days","Not a valid number of days.  calculating based on 30 days.")
end if

rc = dw_records.rowcount()  //sorted in ascending order by end date, start data

//ld_blankfrom = date("2222-12-31")
ld_blankto = today()

if rc < 2 then
	messagebox("Work Gap","There are no Records for the practitioner from which to calculate Gaps")
 	return
else

//Start Code Change ----09.15.2011 #V12 maha - added trap for records that fall completely inside the date range of another record.
	//check for null to dates and filling with todays date then re-sort
	for r = 1 to rc
		ld_to = date( dw_records.getitemdatetime(r,"end_date"))
		if isnull(ld_to) then
			 dw_records.setitem(r,"end_date", datetime(ld_blankto,time("00:00:00")))
		end if
	next
	
	 dw_records.sort()

	//Check or records that fall completely inside the date range of another record.
	for r = 1 to rc
		if r = rc then continue
		
		ld_from = date( dw_records.getitemdatetime(r,"start_date"))
		ld_to = date( dw_records.getitemdatetime(r,"end_date"))
debugbreak()	
		for d = r + 1 to rc
			ld_pfrom = date( dw_records.getitemdatetime(d,"start_date"))
			ld_pto = date( dw_records.getitemdatetime(d,"end_date"))
			
			if ld_from > ld_pfrom and ld_to < ld_pto then
					dw_records.rowsdiscard( r, r, primary!)
					r = r -1
					rc = dw_records.rowcount()
					exit
			end if
		next
	next
	
	rc =  dw_records.rowcount( )
	//messagebox("",rc)
	
//End Code Change ----09.15.2011 

//Create the Gap records
	for r = 1 to rc
		//sorted by end date
		ld_from = date( dw_records.getitemdatetime(r,"start_date"))
		ld_to = date( dw_records.getitemdatetime(r,"end_date"))
		
			
		//debugbreak()
		if r = 1 then
			ld_pfrom = ld_from
			ld_pto = ld_to
			//messagebox("to", string(ld_to))
		else
			d = DaysAfter ( ld_pto, ld_from )
			if d > li_days  then
				ls_type = dw_records.getitemstring(r,"screen_type")
				nr = dw_1.insertrow(0)
				dw_1.setitem(nr,"start_date", datetime(ld_pto,time("00:00:00")))
				dw_1.setitem(nr,"end_date", datetime(ld_from,time("00:00:00")))
				dw_1.setitem(nr,"prac_id", il_prac)
				dw_1.setitem(nr,"selected", 1)
				//Start Code Change ----07.10.2012 #V12 maha - mod for addition of educat and traing to gap calc
				choose case ls_type
					case "E"
						dw_1.setitem(nr,"gap_type", -230)
					Case "T"
						dw_1.setitem(nr,"gap_type", -231)
					Case "P"
						dw_1.setitem(nr,"gap_type", -232)
					Case "H"
						dw_1.setitem(nr,"gap_type", -236)
				end choose
				dw_1.setitem(nr,"w_type", ls_type )
				//End Code Change ----07.10.2012
				cnt++
			end if
		end if
		//set date for next round
		ld_pfrom = ld_from
		if  ld_to > ld_pto then  //Start Code Change ----09.16.2011 #V12 maha
			ld_pto = ld_to
		end if
		
	next
end if
debugbreak()

if cnt > 0 then
	//code to open a window allowing save of created gap records
//	openwithparm(w_work_gap_add_records,dw_1)
//	messagebox("Work Gaps greater than 30 days",cnt)
else
	messagebox("Work Gap","No Work Gaps greater than " + string(li_days) + " days found.")
	
end if
	
ib_calc_was_run = true

//return li_return

return
end subroutine

on w_work_gap_add_records.create
this.cb_view=create cb_view
this.cb_calc=create cb_calc
this.sle_days=create sle_days
this.st_1=create st_1
this.cbx_pro=create cbx_pro
this.cbx_hosp=create cbx_hosp
this.cbx_train=create cbx_train
this.cbx_ed=create cbx_ed
this.dw_records=create dw_records
this.st_recs=create st_recs
this.st_name=create st_name
this.dw_1=create dw_1
this.cb_2=create cb_2
this.cb_add=create cb_add
this.gb_1=create gb_1
this.Control[]={this.cb_view,&
this.cb_calc,&
this.sle_days,&
this.st_1,&
this.cbx_pro,&
this.cbx_hosp,&
this.cbx_train,&
this.cbx_ed,&
this.dw_records,&
this.st_recs,&
this.st_name,&
this.dw_1,&
this.cb_2,&
this.cb_add,&
this.gb_1}
end on

on w_work_gap_add_records.destroy
destroy(this.cb_view)
destroy(this.cb_calc)
destroy(this.sle_days)
destroy(this.st_1)
destroy(this.cbx_pro)
destroy(this.cbx_hosp)
destroy(this.cbx_train)
destroy(this.cbx_ed)
destroy(this.dw_records)
destroy(this.st_recs)
destroy(this.st_name)
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.cb_add)
destroy(this.gb_1)
end on

event open;//Start Code Change ----12.02.2010 #V10 maha - window created

datastore lds_data
integer r
integer c
integer de   //05.23.2017 maha
integer dh   //05.23.2017 maha
integer dt   //05.23.2017 maha
integer dw   //05.23.2017 maha
integer dd   //05.23.2017 maha
long ll_facil   //05.23.2017 maha
string ls_name
gs_pass_ids lst_ids

//Start Code Change ----05.23.2017 #V154 maha
//il_prac = message.stringparm
lst_ids = message.powerobjectparm
il_prac = lst_ids.prac_id
ll_facil = lst_ids.facility_id
//End Code Change ----05.23.2017 


dw_records.settransobject(sqlca)
dw_records.retrieve(il_prac)

//for r = 1 to dw_1.rowcount()
//	dw_1.setitem(r,"selected",1)
//next

//ll_prac = dw_1.getitemnumber(1,"prac_id")

select count(rec_id) into :c from pd_work_gap where prac_id = :il_prac;
select full_name into :ls_name from v_full_name where prac_id = :il_prac;

//Start Code Change ----05.23.2017 #V154 maha
select wg_def_edu, wg_def_hosp, wg_def_train, wg_def_work, wg_def_days into :de, :dh, :dt, :dw, :dd from facility where facility_id = :ll_facil;

if de = 1 then cbx_ed.checked = true
if dh = 1 then cbx_hosp.checked = true
if dt = 1 then cbx_train.checked = true
if dw = 1 then cbx_pro.checked = true

sle_days.text = string(dd)
//End Code Change ----05.23.2017 


st_name.text = ls_name
st_recs.text = "There are " + string(c) + " Gap Records currently in the system for this Provider."
end event

type cb_view from commandbutton within w_work_gap_add_records
integer x = 1609
integer y = 124
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "View"
end type

event clicked;openwithparm(w_existing_work_gap,il_prac )
end event

type cb_calc from commandbutton within w_work_gap_add_records
integer x = 1609
integer y = 36
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Calculate"
end type

event clicked;of_calc( )

cb_add.enabled = true
end event

type sle_days from singlelineedit within w_work_gap_add_records
integer x = 2149
integer y = 300
integer width = 229
integer height = 80
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "30"
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_work_gap_add_records
integer x = 2030
integer y = 244
integer width = 603
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Gap Threshold in Days"
boolean focusrectangle = false
end type

type cbx_pro from checkbox within w_work_gap_add_records
integer x = 1339
integer y = 288
integer width = 654
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Professional Experience"
end type

event clicked;of_filter()
end event

type cbx_hosp from checkbox within w_work_gap_add_records
integer x = 759
integer y = 288
integer width = 576
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Hospital Affiliations"
end type

event clicked;of_filter()
end event

type cbx_train from checkbox within w_work_gap_add_records
integer x = 443
integer y = 288
integer width = 325
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Training"
end type

event clicked;of_filter()
end event

type cbx_ed from checkbox within w_work_gap_add_records
string tag = "Education"
integer x = 82
integer y = 288
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Education"
end type

event clicked;of_filter()
end event

type dw_records from datawindow within w_work_gap_add_records
integer x = 41
integer y = 412
integer width = 2583
integer height = 1116
integer taborder = 30
string title = "none"
string dataobject = "d_gap_checking_records"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_recs from statictext within w_work_gap_add_records
integer x = 37
integer y = 140
integer width = 1614
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 33551856
boolean focusrectangle = false
end type

type st_name from statictext within w_work_gap_add_records
integer x = 37
integer y = 52
integer width = 1577
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_work_gap_add_records
integer x = 46
integer y = 1544
integer width = 2583
integer height = 596
integer taborder = 30
string title = "none"
string dataobject = "d_work_gap_cal_data"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type cb_2 from commandbutton within w_work_gap_add_records
integer x = 2295
integer y = 36
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;close(parent)
end event

type cb_add from commandbutton within w_work_gap_add_records
integer x = 1952
integer y = 36
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Add Records"
end type

event clicked;//Start Code Change ----01.07.2011 #V11 maha - new
integer r
integer cnt
long ll_id


for r = dw_1.rowcount() to 1 step -1
	if dw_1.getitemnumber( r, "selected") = 1 then
		cnt++
	else
		dw_1.rowsdiscard(r,r,primary!)
	end if
next

ll_id = gnv_app.of_get_id( "RECORD_ID", cnt)

for r = 1 to dw_1.rowcount()
	if dw_1.getitemnumber( r, "selected") = 1 then
		dw_1.setitem(r,"rec_id",ll_id)
		ll_id++
	end if
next
		
dw_1.update()

close(parent)
end event

type gb_1 from groupbox within w_work_gap_add_records
integer x = 41
integer y = 228
integer width = 1975
integer height = 152
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Calculate Gaps on:"
end type

