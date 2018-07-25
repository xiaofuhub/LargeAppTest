$PBExportHeader$w_cvo_screen.srw
forward
global type w_cvo_screen from window
end type
type cb_audit from commandbutton within w_cvo_screen
end type
type rb_both from radiobutton within w_cvo_screen
end type
type rb_apps from radiobutton within w_cvo_screen
end type
type rb_verif from radiobutton within w_cvo_screen
end type
type dw_apps from datawindow within w_cvo_screen
end type
type st_2 from statictext within w_cvo_screen
end type
type sle_days from singlelineedit within w_cvo_screen
end type
type cb_save from commandbutton within w_cvo_screen
end type
type st_1 from statictext within w_cvo_screen
end type
type cb_holidays from commandbutton within w_cvo_screen
end type
type dw_verif from datawindow within w_cvo_screen
end type
type dw_affil from datawindow within w_cvo_screen
end type
type dw_grid from datawindow within w_cvo_screen
end type
type cb_calc from commandbutton within w_cvo_screen
end type
type cb_close from commandbutton within w_cvo_screen
end type
type gb_1 from groupbox within w_cvo_screen
end type
end forward

global type w_cvo_screen from window
integer width = 4608
integer height = 2276
boolean titlebar = true
string title = "PSV Tracking"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_audit cb_audit
rb_both rb_both
rb_apps rb_apps
rb_verif rb_verif
dw_apps dw_apps
st_2 st_2
sle_days sle_days
cb_save cb_save
st_1 st_1
cb_holidays cb_holidays
dw_verif dw_verif
dw_affil dw_affil
dw_grid dw_grid
cb_calc cb_calc
cb_close cb_close
gb_1 gb_1
end type
global w_cvo_screen w_cvo_screen

type variables
long il_prac
long il_rec
long il_parent
end variables

on w_cvo_screen.create
this.cb_audit=create cb_audit
this.rb_both=create rb_both
this.rb_apps=create rb_apps
this.rb_verif=create rb_verif
this.dw_apps=create dw_apps
this.st_2=create st_2
this.sle_days=create sle_days
this.cb_save=create cb_save
this.st_1=create st_1
this.cb_holidays=create cb_holidays
this.dw_verif=create dw_verif
this.dw_affil=create dw_affil
this.dw_grid=create dw_grid
this.cb_calc=create cb_calc
this.cb_close=create cb_close
this.gb_1=create gb_1
this.Control[]={this.cb_audit,&
this.rb_both,&
this.rb_apps,&
this.rb_verif,&
this.dw_apps,&
this.st_2,&
this.sle_days,&
this.cb_save,&
this.st_1,&
this.cb_holidays,&
this.dw_verif,&
this.dw_affil,&
this.dw_grid,&
this.cb_calc,&
this.cb_close,&
this.gb_1}
end on

on w_cvo_screen.destroy
destroy(this.cb_audit)
destroy(this.rb_both)
destroy(this.rb_apps)
destroy(this.rb_verif)
destroy(this.dw_apps)
destroy(this.st_2)
destroy(this.sle_days)
destroy(this.cb_save)
destroy(this.st_1)
destroy(this.cb_holidays)
destroy(this.dw_verif)
destroy(this.dw_affil)
destroy(this.dw_grid)
destroy(this.cb_calc)
destroy(this.cb_close)
destroy(this.gb_1)
end on

event open;//Start Code Change ----11.11.2009 #V10 maha - screen created
gs_variable_array la_ids
long li_ver
long li_facs[]
integer r

la_ids = message.powerobjectparm

il_prac = la_ids.as_number[1]
il_rec = la_ids.as_number[2]
il_parent = la_ids.as_number[3]
li_ver = la_ids.as_number[4]
li_facs[1] = il_parent
li_facs[2] = li_ver

dw_affil.retrieve(il_rec,gs_user_id )
dw_verif.retrieve(1,il_prac,li_facs)
dw_apps.retrieve( il_prac,li_facs[1])
r = dw_grid.retrieve(il_rec)

if r = 0 then
	dw_grid.insertrow(1)
	dw_grid.setitem(1,"prac_id",il_prac )
	dw_grid.setitem(1,"facility_id",il_parent )
	dw_grid.setitem(1,"rec_id",il_rec )
end if

datawindowchild dwchild

dw_affil.settransobject(sqlca) 
dw_affil.GetChild( "parent_facility_id", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve(gs_user_id)

dw_affil.GetChild( "verifying_facility", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve(gs_user_id)

//------------------- APPEON BEGIN -------------------
//$<add> Michael 09.02.2011
//$<reason>bug#2601 PSV data response status is displaying numbers not the text
dw_verif.GetChild("response_code", dwchild)
dwchild.SetTransObject( SQLCA )			         
dwchild.Retrieve("Credentials Verification Response")
//------------------- APPEON END ---------------------

IF w_mdi.of_security_access( 7842 ) = 0 THEN   //Start Code Change ----02.09.2017 #V153 maha
	cb_audit.visible = false
end if
end event

type cb_audit from commandbutton within w_cvo_screen
integer x = 3927
integer y = 12
integer width = 352
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Review Audit"
end type

event clicked;
 //Start Code Change ----10.20.2015 #V15 maha
open ( w_affil_stat_review_clist)
 w_affil_stat_review_clist.of_set_vars(il_rec  ,il_prac , il_parent)
end event

type rb_both from radiobutton within w_cvo_screen
integer x = 2199
integer y = 44
integer width = 279
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Both"
end type

type rb_apps from radiobutton within w_cvo_screen
integer x = 1765
integer y = 44
integer width = 411
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Applications"
end type

type rb_verif from radiobutton within w_cvo_screen
integer x = 1335
integer y = 44
integer width = 393
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Verifications"
boolean checked = true
end type

type dw_apps from datawindow within w_cvo_screen
integer x = 3680
integer y = 1164
integer width = 887
integer height = 996
integer taborder = 60
string title = "none"
string dataobject = "d_cvo_pe_fee_for_prac"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;this.settransobject( sqlca)
end event

type st_2 from statictext within w_cvo_screen
integer x = 896
integer y = 36
integer width = 187
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Days"
boolean focusrectangle = false
end type

type sle_days from singlelineedit within w_cvo_screen
integer x = 759
integer y = 24
integer width = 123
integer height = 76
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "45"
borderstyle borderstyle = stylelowered!
end type

type cb_save from commandbutton within w_cvo_screen
integer x = 3081
integer y = 12
integer width = 274
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;long ll_max

if dw_grid.getitemstatus( 	1, 0, primary!)  = Newmodified! then
	select max(grid_id) into :ll_max from cvo_pi_grid;
	if isnull(ll_max) then ll_max = 0
	ll_max++
	dw_grid.setitem(1,"grid_id",ll_max)
end if

dw_grid.update()
dw_affil.update()
dw_verif.update()  //Start Code Change ----12.18.2012 #V12 maha -  for fee field

end event

type st_1 from statictext within w_cvo_screen
integer x = 27
integer y = 36
integer width = 727
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Anticipated Close date default"
boolean focusrectangle = false
end type

type cb_holidays from commandbutton within w_cvo_screen
integer x = 3639
integer y = 12
integer width = 274
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Holidays"
end type

event clicked;
open (w_holiday_de)
end event

type dw_verif from datawindow within w_cvo_screen
integer x = 14
integer y = 1164
integer width = 3643
integer height = 996
integer taborder = 50
string title = "none"
string dataobject = "d_cvo_verifications"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;this.settransobject( sqlca)
end event

type dw_affil from datawindow within w_cvo_screen
integer x = 14
integer y = 500
integer width = 4562
integer height = 652
integer taborder = 40
string title = "none"
string dataobject = "d_cvo_affil_status_record"
boolean livescroll = true
end type

event constructor;this.settransobject( sqlca)
end event

type dw_grid from datawindow within w_cvo_screen
integer x = 14
integer y = 128
integer width = 4562
integer height = 364
integer taborder = 30
string title = "none"
string dataobject = "d_cvo_pi_de"
boolean livescroll = true
end type

event constructor;this.settransobject( sqlca)
end event

type cb_calc from commandbutton within w_cvo_screen
integer x = 3360
integer y = 12
integer width = 274
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Calculate"
end type

event clicked;datetime ld_from
datetime ld_to
integer li_days
integer i
double ld_fee
double ld_total

//set start and end dates
ld_from  = dw_affil.getitemdatetime(1,"date_app_rcvd")
ld_to  = dw_affil.getitemdatetime(1,"date_closed")

if not isnull(ld_from ) then
	dw_grid.setitem(1,"file_recieved",ld_from)
else //Start Code Change ----02.14.2012 #V12 maha -if null check the file recieved value
	if not isnull(dw_grid.getitemdatetime(1,"file_recieved")) then
		ld_from = dw_grid.getitemdatetime(1,"file_recieved")
	end if
end if

if not isnull(ld_to ) then
	dw_grid.setitem(1,"complete_date",ld_to)
else //Start Code Change ----02.14.2012 #V12 maha -if null check the file compl data
	if not isnull(dw_grid.getitemdatetime(1,"complete_date")) then
		ld_to = dw_grid.getitemdatetime(1,"complete_date")
	end if
end if

//set completion days
if not isnull(ld_from) and not isnull(ld_to) then
	i = of_calc_business_days(ld_from,ld_to)  //system function
	dw_grid.setitem(1,"compl_days",i)
end if

li_days  = integer(sle_days.text)
debugbreak()
if li_days > 0 then
//set anticipated date
	ld_to = of_calc_antic_date(li_days,ld_from) //system function
end if

dw_grid.setitem(1,"anticipated_close",ld_to)

//Start Code Change ----02.05.2013 #V12 maha - add calc for apps
if rb_verif.checked  or  rb_both.checked then
	for i = 1 to dw_verif.rowcount()
	//	ld_fee = dw_verif.getitemnumber(i,"address_lookup_fee")
		ld_fee = dw_verif.getitemnumber(i,"verif_info_fee")  //Start Code Change ----12.18.2012 #V12 maha - changed to verif info field
		if not isnull(ld_fee) then
			ld_total = ld_total + ld_fee
		end if
	next
end if

if rb_apps.checked or  rb_both.checked then
	for i = 1 to dw_apps.rowcount()
		ld_fee = dw_apps.getitemnumber(i,"app_hdr_fee")  //Start Code Change ----12.18.2012 #V12 maha - changed to verif info field
		if not isnull(ld_fee) then
			ld_total = ld_total + ld_fee
		end if
	next
end if
//End Code Change ----02.05.2013 
	
dw_grid.setitem(1,"fee_total",ld_total)

//st_1.text = string(i)







end event

type cb_close from commandbutton within w_cvo_screen
integer x = 4288
integer y = 12
integer width = 274
integer height = 92
integer taborder = 10
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

type gb_1 from groupbox within w_cvo_screen
integer x = 1285
integer width = 1202
integer height = 116
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Calculate Fee From:"
borderstyle borderstyle = stylebox!
end type

