$PBExportHeader$w_batch_approval_v16.srw
forward
global type w_batch_approval_v16 from window
end type
type dw_dates from u_dw within w_batch_approval_v16
end type
type dw_2 from u_dw within w_batch_approval_v16
end type
type cbx_1 from checkbox within w_batch_approval_v16
end type
type em_prov_from from editmask within w_batch_approval_v16
end type
type em_prov_to from editmask within w_batch_approval_v16
end type
type st_6 from statictext within w_batch_approval_v16
end type
type st_5 from statictext within w_batch_approval_v16
end type
type st_4 from statictext within w_batch_approval_v16
end type
type st_3 from statictext within w_batch_approval_v16
end type
type em_to from editmask within w_batch_approval_v16
end type
type em_from from editmask within w_batch_approval_v16
end type
type st_2 from statictext within w_batch_approval_v16
end type
type st_1 from statictext within w_batch_approval_v16
end type
type cb_2 from commandbutton within w_batch_approval_v16
end type
type cb_1 from commandbutton within w_batch_approval_v16
end type
type dw_1 from datawindow within w_batch_approval_v16
end type
type em_return from editmask within w_batch_approval_v16
end type
type gb_2 from groupbox within w_batch_approval_v16
end type
type gb_1 from groupbox within w_batch_approval_v16
end type
end forward

global type w_batch_approval_v16 from window
integer x = 987
integer y = 676
integer width = 2359
integer height = 1120
boolean titlebar = true
string title = "Return from Committee Batch Update "
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
dw_dates dw_dates
dw_2 dw_2
cbx_1 cbx_1
em_prov_from em_prov_from
em_prov_to em_prov_to
st_6 st_6
st_5 st_5
st_4 st_4
st_3 st_3
em_to em_to
em_from em_from
st_2 st_2
st_1 st_1
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
em_return em_return
gb_2 gb_2
gb_1 gb_1
end type
global w_batch_approval_v16 w_batch_approval_v16

type variables
long il_apprcode
long il_facility
integer ii_years //maha 04.12.2017
integer ii_prov_years //maha 04.12.2014
integer ii_birth_years = 0 //maha 04.12.2014
datawindowchild dw_child
n_cst_datetime inv_datetime
end variables

forward prototypes
public function integer of_set_text ()
end prototypes

public function integer of_set_text (); //Start Code Change ----04.12.2017 #V153 maha - added to set rules used
string s
integer li_use_prior
integer li_prov
string test

if il_facility < 1 then
	s = "Because multiple facilities have been selected for update, default rules are in effect:" 
else
	s = "Based on the settings for the selected Facility:"
end if

li_use_prior = dw_2.getitemnumber(1, "use_prior")  //Start Code Change ----01.03.2017 #V153 maha
li_prov =  dw_2.GetItemNumber(1,'prov_app')

if li_use_prior = 1 then
	s+= "~rFor records with prior dates, the Start date will be set a day after the Prior end date."
	s+= "~rFor records without prior dates the Start date will be set to the Appointment From date."
else
	s+= "~rThe Appointment Start date will be set to the Appointment From date."
end if

if ii_years = 0 then
	s+= "~rThe Appointment End date will be set 2 years from the Start date."
elseif ii_years  > 0 then
	s+= "~rThe Appointment End date will be set based on the Provider birthday within " + string(abs(ii_years)) + " years from the Start date."
else 
	s+= "~rThe Appointment End date will be set " + string(ii_years) + " years from the Start date."
end if

if li_prov = 1 then
	s+= "~rThe Provisional Dates will be set from the values on this screen."
end if

test = dw_2.modify("t_info.text = '" + s + "'")

//messagebox("",test)
	
return 1
end function

on w_batch_approval_v16.create
this.dw_dates=create dw_dates
this.dw_2=create dw_2
this.cbx_1=create cbx_1
this.em_prov_from=create em_prov_from
this.em_prov_to=create em_prov_to
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.em_to=create em_to
this.em_from=create em_from
this.st_2=create st_2
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.em_return=create em_return
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.dw_dates,&
this.dw_2,&
this.cbx_1,&
this.em_prov_from,&
this.em_prov_to,&
this.st_6,&
this.st_5,&
this.st_4,&
this.st_3,&
this.em_to,&
this.em_from,&
this.st_2,&
this.st_1,&
this.cb_2,&
this.cb_1,&
this.dw_1,&
this.em_return,&
this.gb_2,&
this.gb_1}
end on

on w_batch_approval_v16.destroy
destroy(this.dw_dates)
destroy(this.dw_2)
destroy(this.cbx_1)
destroy(this.em_prov_from)
destroy(this.em_prov_to)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.em_to)
destroy(this.em_from)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.em_return)
destroy(this.gb_2)
destroy(this.gb_1)
end on

event open;

il_facility = gi_comm_return_facil_bypass //Start Code Change ----03.03.2010 #V10 maha
//messagebox("facility",il_facility)
dw_1.retrieve()
dw_1.insertrow(1)

 //Start Code Change ----04.12.2017 #V153 maha
dw_2.setitem(1, "use_prior", 1)

if il_facility > 0 then
	select appointment_years, prov_years into :ii_years, :ii_prov_years from facility where facility_id = :il_facility;
	if ii_years > 3 then ii_birth_years = ii_years
else
	ii_years = 2
	ii_prov_years = 1
end if

of_set_text()
 //End Code Change ----04.12.2017 


end event

type dw_dates from u_dw within w_batch_approval_v16
boolean visible = false
integer x = 1673
integer y = 1200
integer width = 1152
integer height = 92
integer taborder = 60
string dataobject = "d_priv_batch_update_dates"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;
this.of_SetDropDownCalendar(TRUE)
this.iuo_calendar.of_Register("app_from", this.iuo_calendar.DDLB_WITHARROW	)
this.iuo_calendar.of_Register("app_to", this.iuo_calendar.DDLB_WITHARROW	)

insertrow(0)

end event

event itemerror;//override - Alfee 11.06.2008
end event

type dw_2 from u_dw within w_batch_approval_v16
integer y = 44
integer width = 2327
integer height = 864
integer taborder = 100
string dataobject = "d_ext_comm_batch_update_v16"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;


this.of_SetDropDownCalendar(TRUE)
this.iuo_calendar.of_Register("app_from", this.iuo_calendar.DDLB_WITHARROW	)
this.iuo_calendar.of_Register("app_to", this.iuo_calendar.DDLB_WITHARROW	)
this.iuo_calendar.of_Register("prov_from", this.iuo_calendar.DDLB_WITHARROW	)
this.iuo_calendar.of_Register("prov_to", this.iuo_calendar.DDLB_WITHARROW	)
this.iuo_calendar.of_Register("returned_from_comm", this.iuo_calendar.DDLB_WITHARROW	)





insertrow(0)


this.getchild('approval_code',dw_child)
dw_child.settransobject(sqlca)
dw_child.retrieve('approval code')
end event

event itemchanged;call super::itemchanged;//datetime ldt
date ldt //Alfee 11.06.2008
datetime ld_apptmnt_start_date  //maha 04.12.2017
date ld_apptmnt_end_date //maha 04.12.2017
//integer li_years //maha 03.3.2010

this.accepttext()

choose case dwo.name
	case 'app_from'		
		//-------Begin Modified by Alfee 11.06.2008 ------------------------	
		//<$Reason>Keep same logic with that on Appointment Status screen
		/* ldt = inv_datetime.of_RelativeDateTime ( datetime(date(data),now()), 63072000 )//1900-01-01
		if pos('1/1/1900' ,string(ldt)) < 1 then
			setitem(1,'app_to',date(ldt))			
		end if  */	
		//Start Code Change ----03.03.2010 #V10 maha - set the end based on the facility setting.
		
//Start Code Change ----04.12.2017 #V153 maha - moved setting to open event and added provisional setting

//		if il_facility = -1 then //if records for multiple facilities are selected use the default 2 years
//			li_years = 2
//		else
//			select appointment_years into :li_years from facility where facility_id = :il_facility;
//		end if
		
		if ii_years > 0 then //if the setting is 0 do not set the end years
			ldt = inv_datetime.of_relativeyear (date(data), ii_years ) //changed from the hard coded 2
			ldt = RelativeDate(ldt, -1 )
			if PosA('1/1/1900' ,string(ldt)) < 1 then
				setitem(1,'app_to',ldt)			
			end if  
		end if
		//End Code Change---03.03.2010
		//--------End Modified ---------------------------------------------				
	case 'approval_code'
			il_apprcode = long(data)

		
	// PROVISIONAL CHECKBOX
	case "prov_app" 
		if this.getitemnumber(row,"prov_app") = 0 then
			ld_apptmnt_start_date = this.getitemdatetime(row,"app_from")
			if isnull(ld_apptmnt_start_date) then return 1
			
			this.setitem(row,"init_prov_period_from",ld_apptmnt_start_date)
			//Start Code Change ----08.17.2011 #V11 maha - mod to allow length of provisional appointment
			
			if ii_prov_years > 0 then
				ld_apptmnt_end_date = inv_datetime.of_relativeyear(date(ld_apptmnt_start_date), ii_prov_years)
				ld_apptmnt_end_date = RelativeDate( ld_apptmnt_end_date, -1 )
				this.setitem(row,"init_prov_period_to",ld_apptmnt_end_date)
			else
				this.setitem(row,"init_prov_period_to",ld_apptmnt_start_date)
			end if
			//End Code Change ----08.17.2011
			
		end if
//End Code Change ----04.12.2017	
end choose 

of_set_text()
end event

event itemerror;//override - Alfee 11.06.2008
end event

type cbx_1 from checkbox within w_batch_approval_v16
boolean visible = false
integer x = 133
integer y = 592
integer width = 690
integer height = 76
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Provisional Appointment"
boolean thirdstate = true
end type

type em_prov_from from editmask within w_batch_approval_v16
boolean visible = false
integer x = 1120
integer y = 356
integer width = 421
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datetimemask!
string mask = "mm/dd/yyyy"
end type

type em_prov_to from editmask within w_batch_approval_v16
boolean visible = false
integer x = 1115
integer y = 480
integer width = 421
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datetimemask!
string mask = "mm/dd/yyyy"
end type

type st_6 from statictext within w_batch_approval_v16
boolean visible = false
integer x = 946
integer y = 356
integer width = 146
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "From:"
boolean focusrectangle = false
end type

type st_5 from statictext within w_batch_approval_v16
boolean visible = false
integer x = 946
integer y = 480
integer width = 110
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "To:"
boolean focusrectangle = false
end type

type st_4 from statictext within w_batch_approval_v16
boolean visible = false
integer x = 133
integer y = 480
integer width = 110
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "To:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_batch_approval_v16
boolean visible = false
integer x = 137
integer y = 356
integer width = 146
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "From:"
boolean focusrectangle = false
end type

type em_to from editmask within w_batch_approval_v16
boolean visible = false
integer x = 293
integer y = 480
integer width = 421
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datetimemask!
string mask = "mm/dd/yyyy"
end type

type em_from from editmask within w_batch_approval_v16
boolean visible = false
integer x = 293
integer y = 356
integer width = 421
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datetimemask!
string mask = "mm/dd/yyyy"
end type

type st_2 from statictext within w_batch_approval_v16
boolean visible = false
integer x = 759
integer y = 76
integer width = 398
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Approval Code"
boolean focusrectangle = false
end type

type st_1 from statictext within w_batch_approval_v16
boolean visible = false
integer x = 101
integer y = 76
integer width = 690
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Returned From Committee"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_batch_approval_v16
integer x = 1198
integer y = 916
integer width = 247
integer height = 84
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;closewithreturn(parent,"C")
end event

type cb_1 from commandbutton within w_batch_approval_v16
integer x = 937
integer y = 916
integer width = 247
integer height = 84
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
boolean default = true
end type

event clicked;
gs_appointment_dates lst_dates

date dt_rdate
date dt_sdate
date dt_edate
date dt_pstart
date dt_pend

string ls_dt_rdate
string ls_dt_sdate
string ls_dt_edate
string ls_dt_pstart
string ls_dt_pend

integer li_prov = 0
integer li_use_prior //maha 01.03.2017
long ll_code
string ls_letter
string ret

ll_code = il_apprcode

dw_2.accepttext() //Start Code Change ---- 10.11.2007 #V7 maha

dt_rdate =  dw_2.getItemDate(1,'returned_from_comm')  //(em_return.text)
dt_sdate = dw_2.getItemDate(1,'app_from')//date(em_from.text)
dt_edate = dw_2.getItemDate(1,'app_to')//date(em_to.text)
dt_pstart = dw_2.getItemDate(1,'prov_from') //date(em_prov_from.text)
dt_pend = dw_2.getItemDate(1,'prov_to')//date(em_prov_to.text)
li_use_prior = dw_2.getitemnumber(1, "use_prior")  //Start Code Change ----01.03.2017 #V153 maha
li_prov =  dw_2.GetItemNumber(1,'prov_app') //if cbx_1.checked then li_prov = 1

if string(dt_rdate) = "1/1/1900" or string(dt_rdate) = "1/1/2000" then
	messagebox("Batch error","You must have a Returned from Committee date")
	return
end if

if ll_code < 0 or isnull(ll_code) then
	messagebox("Batch error","You must have an Approval Code")
	return
end if


lst_dates.d_comm_date =  dt_rdate
lst_dates.d_appt_end = dt_edate
lst_dates.d_appt_start = dt_sdate
lst_dates.d_prov_start = dt_pstart
lst_dates.d_prov_end = dt_pend
lst_dates.i_prior = li_use_prior
lst_dates.i_provisional =  dw_2.GetItemNumber(1,'prov_app')
lst_dates.n_comm_status = ll_code

 //Start Code Change ----04.11.2017 #V153 maha - pass structure rather than string
//ls_dt_rdate  = string(dt_rdate)
//ls_dt_sdate  = string(dt_sdate)
//ls_dt_edate  = string(dt_edate)
//ls_dt_pstart = string(dt_pstart)
//ls_dt_pend   = string(dt_pend)
//
//if isnull(ls_dt_sdate) then  ls_dt_sdate = '1/1/1900'
//if isnull(ls_dt_edate) then  ls_dt_edate = '1/1/1900'
//if isnull(ls_dt_pstart) then ls_dt_pstart = '1/1/1900'
//if isnull(ls_dt_pend) then  ls_dt_pend = '1/1/1900'
//
//ret = string(ll_code) + ";" + string(ls_dt_rdate) + ";" + string(ls_dt_sdate) + ";" + string(ls_dt_edate) + ";" + string(ls_dt_pstart) + ";" + string(ls_dt_pend) + ";" + string(li_prov) + ";" + string(li_use_prior)

closewithreturn(parent, lst_dates)
end event

type dw_1 from datawindow within w_batch_approval_v16
boolean visible = false
integer x = 754
integer y = 140
integer width = 882
integer height = 76
integer taborder = 20
string dataobject = "d_apprvl_code_batch"
boolean border = false
boolean livescroll = true
end type

event itemchanged;il_apprcode = long(data)
end event

event constructor;this.settransobject(sqlca)

DataWindowChild dwchild
this.insertrow(1)
This.GetChild( "description", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("approval code")
dwchild.InsertRow( 1 )
end event

type em_return from editmask within w_batch_approval_v16
boolean visible = false
integer x = 96
integer y = 140
integer width = 411
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datetimemask!
string mask = "mm/dd/yyyy"
end type

type gb_2 from groupbox within w_batch_approval_v16
boolean visible = false
integer x = 891
integer y = 288
integer width = 736
integer height = 404
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 67108864
string text = "Provisional Dates"
end type

type gb_1 from groupbox within w_batch_approval_v16
boolean visible = false
integer x = 73
integer y = 288
integer width = 727
integer height = 404
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 67108864
string text = "Appointment Dates"
end type

