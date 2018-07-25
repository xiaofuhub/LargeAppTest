$PBExportHeader$w_import_cme_data.srw
$PBExportComments$V12.1 CME-peer-meeting data migration to QA
forward
global type w_import_cme_data from w_master
end type
type dw_types from u_dw within w_import_cme_data
end type
type dw_date from u_dw within w_import_cme_data
end type
type st_2 from statictext within w_import_cme_data
end type
type cb_1 from commandbutton within w_import_cme_data
end type
type cb_2 from commandbutton within w_import_cme_data
end type
type cbx_cme from checkbox within w_import_cme_data
end type
type cbx_meeting from checkbox within w_import_cme_data
end type
type rb_demographics from radiobutton within w_import_cme_data
end type
type rb_meetings from radiobutton within w_import_cme_data
end type
type rb_both from radiobutton within w_import_cme_data
end type
type st_1 from statictext within w_import_cme_data
end type
type gb_1 from groupbox within w_import_cme_data
end type
end forward

global type w_import_cme_data from w_master
integer width = 1431
integer height = 1756
string title = "Import Metrics Data"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 32891346
dw_types dw_types
dw_date dw_date
st_2 st_2
cb_1 cb_1
cb_2 cb_2
cbx_cme cbx_cme
cbx_meeting cbx_meeting
rb_demographics rb_demographics
rb_meetings rb_meetings
rb_both rb_both
st_1 st_1
gb_1 gb_1
end type
global w_import_cme_data w_import_cme_data

type variables
datetime idt_from
datetime idt_to
long il_prac_id,il_facility
datawindow idw_pd_metrics
end variables

forward prototypes
public function integer of_import_cme (string as_cme_source)
public function integer of_import_meetings (long al_meettype[])
end prototypes

public function integer of_import_cme (string as_cme_source);//////////////////////////////////////////////////////////////////////
// $<function> of_import_cme
// $<arguments>
//              as_cme_source long
// $<returns> 1
// $<description> import CME
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Michael 12.14.2011
//////////////////////////////////////////////////////////////////////
dec{2} ldec_train_hours =0,ldec_CME_hours= 0
long ll_row
long ll_rtn
long ll_msg_rtn
long ll_meas_id,ll_met
gs_pass_ids lst_array
long ll_ids[]
long ll_find = 0
string ls_findstr
openwithparm(w_qa_metric_select,'import CME data')

if message.stringparm = "Cancel" then
	return 0
else	
	lst_array = message.powerobjectparm
	ll_ids = lst_array.l_ids
	ll_met = ll_ids[1]
end if

//total train hours
select sum(hours) into :ldec_train_hours
	from pd_postgrad_train
	where prac_id = :il_prac_id 
			and date_from >= :idt_from 
			and date_thru <= :idt_to;
if isnull(ldec_train_hours) then ldec_train_hours =0
//tatal CME hours
SELECT sum(meetings.cme_credits) into :ldec_cme_hours
	FROM meetings,
		  attendence		
	WHERE attendence.meeting_id = meetings.meeting_id 
			and  attendence.prac_id = :il_prac_id and meetings.facility = :il_facility
			and  meetings.meeting_type = 608 and attendence.attendence_status = 626
			and meetings.start_date >= :idt_from and meetings.end_date <=:idt_to;
if isnull(ldec_cme_hours) then ldec_cme_hours = 0

select max(rec_id)   into :ll_meas_id from pd_qa_data;
if isnull(ll_meas_id) then ll_meas_id = 0
ll_meas_id++

//check duplicate
ls_findstr = "metric_id ="+ string(ll_met) + " and prac_id = " + string(il_prac_id) + " and facility_id =" + string(il_facility) + " and from_date <=datetime('" +string(idt_from) + "') and to_date >=datetime('" +string(date(idt_to))+"')"
ll_find =  idw_pd_metrics.find(ls_findstr, 1, idw_pd_metrics.rowcount()) 
if ll_find > 0 then
	ll_msg_rtn = MessageBox("Import","Metric item already exists, do you want to continue?",Question!,YesNo!,2)
	if ll_msg_rtn = 2 then
		return 0
	end if
end if 

//import data
ll_row = idw_pd_metrics.insertrow(0)
idw_pd_metrics.setitem(ll_row,"rec_id",ll_meas_id)
idw_pd_metrics.setitem(ll_row,"metric_id",ll_met)
idw_pd_metrics.setitem(ll_row,"prac_id",il_prac_id)
idw_pd_metrics.setitem(ll_row,"facility_id",il_facility)
idw_pd_metrics.setitem(ll_row,"from_date",idt_from )
idw_pd_metrics.setitem(ll_row,"to_date",idt_to )
choose case as_cme_source
	case 'Demographics tab'
		idw_pd_metrics.setitem(ll_row,"measurment",string(ldec_train_hours))
	case 'Meetings Tab'
		idw_pd_metrics.setitem(ll_row,"measurment",string(ldec_cme_hours))
	case 'Both'
		idw_pd_metrics.setitem(ll_row,"measurment",string(ldec_train_hours+ldec_cme_hours))
end choose

	
ll_rtn = idw_pd_metrics.update()
if ll_rtn < 1 then 	
	messagebox("Measurements Update failed",sqlca.sqlerrtext)
	return 0
end if

return 1
end function

public function integer of_import_meetings (long al_meettype[]);//////////////////////////////////////////////////////////////////////
// $<function> of_import_meetings
// $<arguments>
//              al_meettype[] long
// $<returns> 1
// $<description> import meetings
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Michael 12.14.2011
//////////////////////////////////////////////////////////////////////

long ll_count_attendence =0,ll_count_meetings= 0
long ll_row
long ll_rtn,ll_msg_rtn
long ll_meas_id,ll_met
gs_pass_ids lst_array
long ll_ids[]
integer ll_data_type,li_ids[] 
long ll_find
string ls_findstr
datastore lds_count_meetings

openwithparm(w_qa_metric_select,'import meetings data')

if message.stringparm = "Cancel" then
	return 0
else	
	lst_array = message.powerobjectparm
	ll_ids = lst_array.l_ids
	ll_met = ll_ids[1]
	li_ids[] = lst_array.i_ids
	ll_data_type = li_ids[1]
end if
//total attended meetings 
lds_count_meetings = create datastore
lds_count_meetings.dataobject = 'd_attendence_meetings'
lds_count_meetings.settransobject( sqlca)
lds_count_meetings.retrieve(il_prac_id, il_facility,al_meettype,idt_from,idt_to)
ll_count_attendence = lds_count_meetings.getitemnumber( 1, 'count_attendence')
//total  meetings 
lds_count_meetings.dataobject = 'd_count_meetings'
lds_count_meetings.settransobject( sqlca)
lds_count_meetings.retrieve(il_prac_id,il_facility,al_meettype,idt_from,idt_to)
ll_count_meetings= lds_count_meetings.getitemnumber( 1, 'count_meetings')


select max(rec_id)   into :ll_meas_id from pd_qa_data;
if isnull(ll_meas_id) then ll_meas_id = 0
ll_meas_id++

//check duplicate
ls_findstr = "metric_id ="+ string(ll_met) + " and prac_id = " + string(il_prac_id) + " and facility_id =" + string(il_facility) + " and from_date <=datetime('" +string(idt_from) + "') and to_date >=datetime('" +string(date(idt_to))+"')"
ll_find =  idw_pd_metrics.find(ls_findstr, 1, idw_pd_metrics.rowcount()) 
if ll_find > 0 then
	ll_msg_rtn = MessageBox("Import","Metric item already exists, do you want to continue?",Question!,YesNo!,2)
	if ll_msg_rtn = 2 then
		return 0
	end if
end if  
 
//import data
ll_row = idw_pd_metrics.insertrow(0)
idw_pd_metrics.setitem(ll_row,"rec_id",ll_meas_id)
idw_pd_metrics.setitem(ll_row,"metric_id",ll_met)
idw_pd_metrics.setitem(ll_row,"prac_id",il_prac_id)
idw_pd_metrics.setitem(ll_row,"facility_id",il_facility)
idw_pd_metrics.setitem(ll_row,"from_date",idt_from )
idw_pd_metrics.setitem(ll_row,"to_date",idt_to )
if ll_data_type = 1 then
	idw_pd_metrics.setitem(ll_row,"measurment",string(ll_count_attendence))
else
	if ll_count_meetings = 0 or ll_count_attendence = 0 then
		idw_pd_metrics.setitem(ll_row,"measurment",'0.00%')
	else
		idw_pd_metrics.setitem(ll_row,"measurment",string((Round((ll_count_attendence /ll_count_meetings),2 ) *100),'0.00')+'%')
	end if
end if

	
ll_rtn = idw_pd_metrics.update()
if ll_rtn < 1 then 	
	messagebox("Measurements Update failed",sqlca.sqlerrtext)
	return 0
end if

if isvalid(lds_count_meetings) then destroy lds_count_meetings
return 1
end function

on w_import_cme_data.create
int iCurrent
call super::create
this.dw_types=create dw_types
this.dw_date=create dw_date
this.st_2=create st_2
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cbx_cme=create cbx_cme
this.cbx_meeting=create cbx_meeting
this.rb_demographics=create rb_demographics
this.rb_meetings=create rb_meetings
this.rb_both=create rb_both
this.st_1=create st_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_types
this.Control[iCurrent+2]=this.dw_date
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.cbx_cme
this.Control[iCurrent+7]=this.cbx_meeting
this.Control[iCurrent+8]=this.rb_demographics
this.Control[iCurrent+9]=this.rb_meetings
this.Control[iCurrent+10]=this.rb_both
this.Control[iCurrent+11]=this.st_1
this.Control[iCurrent+12]=this.gb_1
end on

on w_import_cme_data.destroy
call super::destroy
destroy(this.dw_types)
destroy(this.dw_date)
destroy(this.st_2)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cbx_cme)
destroy(this.cbx_meeting)
destroy(this.rb_demographics)
destroy(this.rb_meetings)
destroy(this.rb_both)
destroy(this.st_1)
destroy(this.gb_1)
end on

type dw_types from u_dw within w_import_cme_data
integer x = 206
integer y = 1000
integer width = 1134
integer height = 604
integer taborder = 30
string dataobject = "d_meeting_type_select"
boolean hscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;this.settransobject(sqlca)
this.retrieve()
this.of_setupdateable( false)
end event

type dw_date from u_dw within w_import_cme_data
integer x = 50
integer y = 244
integer width = 1175
integer height = 108
integer taborder = 20
string dataobject = "d_import_cme_selectdate"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;this.insertrow(0)
this.of_SetDropDownCalendar( TRUE )
this.iuo_calendar.of_Register(this.iuo_calendar.DDLB)
this.of_setupdateable( false)
end event

type st_2 from statictext within w_import_cme_data
integer x = 261
integer y = 932
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "Includes:"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_import_cme_data
integer x = 613
integer y = 52
integer width = 343
integer height = 104
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Import"
end type

event clicked;string ls_cme_source
long ll_meettype[] 
long ll_i
 
dw_date.accepttext( )
idt_from = dw_date.getitemdatetime(1,"start_date")
idt_to = dw_date.getitemdatetime(1,"end_date")

//chenck date and import type
if isnull(idt_from) or isnull(idt_to) then
	messagebox('Validaton Error','Date Range is not valid.')
	return
end if
if idt_from > idt_to then
	messagebox('Validaton Error','Date Range is not valid.')
	return
end if
if cbx_cme.checked =  false and cbx_meeting.checked = false then
	messagebox("Validaton Error","Please select at least one Import Type.")
	return 
end if

if cbx_meeting.checked then
	for ll_i = 1 to dw_types.rowcount()
		if dw_types.getitemnumber( ll_i, "selected") = 1 then
			ll_meettype[UpperBound(ll_meettype) + 1] = dw_types.getitemnumber( ll_i, "lookup_code")
		end if
	next
	if UpperBound(ll_meettype) < 1 then
		messagebox("Validaton Error","Please select at least one Meeting Type.")
		return
	end if
end if

//get prac_id,idw_pd_metrics,il_facility
il_prac_id = w_qa_peer_profile_screen.tab_qa.tabpage_quality_profile.uo_qa.il_prac_id
idw_pd_metrics = w_qa_peer_profile_screen.tab_qa.tabpage_quality_profile.uo_qa.tab_measurments.tabpage_data.dw_pd_metrics
//il_facility = w_qa_peer_profile_screen.tab_qa.tabpage_quality_profile.uo_qa.il_facility modify Michael 04.26.2012 Alpha Test 2998
il_facility = w_qa_peer_profile_screen.tab_qa.tabpage_quality_profile.uo_qa.dw_settings.getitemnumber(w_qa_peer_profile_screen.tab_qa.tabpage_quality_profile.uo_qa.dw_settings.getrow(),"facility_id")


//import CME
if cbx_cme.checked then
	If rb_demographics.checked then
		ls_cme_source= 'Demographics tab'
	End if
	If rb_meetings.checked then
		ls_cme_source= 'Meetings Tab'
	End if
	If rb_both.checked then
		ls_cme_source= 'Both'
	End if	
	of_import_cme(ls_cme_source)
end if
 
//import Meetings
if cbx_meeting.checked then
	of_import_meetings(ll_meettype)
end if
end event

type cb_2 from commandbutton within w_import_cme_data
integer x = 987
integer y = 52
integer width = 343
integer height = 104
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;Close (Parent)
end event

type cbx_cme from checkbox within w_import_cme_data
integer x = 160
integer y = 448
integer width = 393
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "CME hours"
end type

event clicked;if checked then
	if (not rb_demographics.checked) and (not rb_meetings.checked)  and (not rb_both.checked ) then
		rb_demographics.checked =  true
	end if
end if
end event

type cbx_meeting from checkbox within w_import_cme_data
integer x = 160
integer y = 860
integer width = 690
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "Meeting Attendance"
end type

type rb_demographics from radiobutton within w_import_cme_data
integer x = 265
integer y = 540
integer width = 549
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "Demographics tab"
end type

type rb_meetings from radiobutton within w_import_cme_data
integer x = 265
integer y = 624
integer width = 416
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "Meetings Tab"
end type

type rb_both from radiobutton within w_import_cme_data
integer x = 265
integer y = 716
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "Both"
end type

type st_1 from statictext within w_import_cme_data
integer x = 41
integer y = 184
integer width = 306
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 32891346
string text = "Date Range:"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_import_cme_data
integer x = 32
integer y = 356
integer width = 1339
integer height = 1276
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 32891346
string text = "Import Types"
end type

