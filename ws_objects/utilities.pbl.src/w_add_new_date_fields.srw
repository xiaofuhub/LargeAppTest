$PBExportHeader$w_add_new_date_fields.srw
forward
global type w_add_new_date_fields from window
end type
type st_4 from statictext within w_add_new_date_fields
end type
type st_3 from statictext within w_add_new_date_fields
end type
type st_2 from statictext within w_add_new_date_fields
end type
type st_1 from statictext within w_add_new_date_fields
end type
type cb_quit from commandbutton within w_add_new_date_fields
end type
type dw_fields from datawindow within w_add_new_date_fields
end type
type dw_tables from datawindow within w_add_new_date_fields
end type
type cb_run from commandbutton within w_add_new_date_fields
end type
end forward

global type w_add_new_date_fields from window
integer width = 2533
integer height = 2004
boolean titlebar = true
string title = "Add New Date Fields"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
cb_quit cb_quit
dw_fields dw_fields
dw_tables dw_tables
cb_run cb_run
end type
global w_add_new_date_fields w_add_new_date_fields

type variables

end variables

forward prototypes
public function integer of_visible (long al_field)
public function integer of_profile (integer ai_report, string as_dw)
end prototypes

public function integer of_visible (long al_field);string ls_sql

ls_sql = "Update data_view_fields set visible = 'Y' where field_id = " + string(al_field) + ";"
execute immediate :ls_sql;
commit using sqlca;

return 1

end function

public function integer of_profile (integer ai_report, string as_dw);string ls_sql

ls_sql = "Update profile_reports set profile_report_dw = '" + as_dw + "' where profile_report_id = " + string(ai_report) + ";"
execute immediate :ls_sql;
//clipboard(ls_sql)
commit using sqlca;

return 1
end function

on w_add_new_date_fields.create
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.cb_quit=create cb_quit
this.dw_fields=create dw_fields
this.dw_tables=create dw_tables
this.cb_run=create cb_run
this.Control[]={this.st_4,&
this.st_3,&
this.st_2,&
this.st_1,&
this.cb_quit,&
this.dw_fields,&
this.dw_tables,&
this.cb_run}
end on

on w_add_new_date_fields.destroy
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_quit)
destroy(this.dw_fields)
destroy(this.dw_tables)
destroy(this.cb_run)
end on

type st_4 from statictext within w_add_new_date_fields
integer x = 46
integer y = 452
integer width = 2395
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "Profiles will be updated to use full date field versions."
boolean focusrectangle = false
end type

type st_3 from statictext within w_add_new_date_fields
integer x = 41
integer y = 532
integer width = 2359
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "To see the fields added for a screen click the table name ."
boolean focusrectangle = false
end type

type st_2 from statictext within w_add_new_date_fields
integer x = 46
integer y = 304
integer width = 2423
integer height = 144
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "It will also make the date fields visible, and the month/ year fields invisible.   You may need to reposition them via the screen painter.  "
boolean focusrectangle = false
end type

type st_1 from statictext within w_add_new_date_fields
integer x = 46
integer y = 32
integer width = 2423
integer height = 292
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "This utility is for migrating existing month/year field data to the new full Date fields.  Start dates will be set to the beginning of the month, End dates to the end of the month.  If only year data is available,  the date will be set to the beginning or end of the month as is appropriate."
boolean focusrectangle = false
end type

type cb_quit from commandbutton within w_add_new_date_fields
integer x = 2107
integer y = 1640
integer width = 343
integer height = 92
integer taborder = 30
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

type dw_fields from datawindow within w_add_new_date_fields
integer x = 1527
integer y = 624
integer width = 882
integer height = 976
integer taborder = 20
string title = "none"
string dataobject = "d_new_date_fields"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type dw_tables from datawindow within w_add_new_date_fields
integer x = 59
integer y = 628
integer width = 1431
integer height = 976
integer taborder = 10
string title = "none"
string dataobject = "d_new_date_tables"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;integer r
integer tid

r = this.getclickedrow()
this.scrolltorow(r)
this.setrow(r)
this.selectrow(0,false)
this.selectrow(r,true)

tid = this.getitemnumber(r,"table_id")
dw_fields.retrieve(tid)
end event

event constructor;this.settransobject(sqlca)
this.retrieve()
end event

type cb_run from commandbutton within w_add_new_date_fields
integer x = 1737
integer y = 1640
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

event clicked;integer t
integer tc
integer tid
time ttime = time("00:00:00")

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<add> 02.10.2006 By: Wangchao
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_startqueue( )

//---------------------------- APPEON END ----------------------------

for t = 1 to dw_tables.rowcount()
	if dw_tables.getitemnumber(t,"selected") = 1 then
		tid = dw_tables.getitemnumber(t,"table_id") 
		choose case tid   
			case 1  //ach appt
				update pd_acedemic_appointments set start_date = datetime(string(year_from) + '/' + string(month_from ) + '/01 00:00:00') where year_from is not null and month_from is not null and start_date is null;
				update pd_acedemic_appointments set start_date = datetime(string(year_from) + '/01/01 00:00:00') where year_from is not null and month_from is null and start_date is null;
				
				update pd_acedemic_appointments set end_date = datetime(string(year_thru) + '/' + string(month_thru ) + '/30 00:00:00') where year_thru is not null and month_thru is not null and end_date is null and month_thru in (4,6,9,11);
				update pd_acedemic_appointments set end_date = datetime(string(year_thru) + '/' + string(month_thru ) + '/28 00:00:00') where year_thru is not null and month_thru is not null and end_date is null and month_thru = 2;
				update pd_acedemic_appointments set end_date = datetime(string(year_thru) + '/' + string(month_thru ) + '/31 00:00:00') where year_thru is not null and month_thru is not null and end_date is null and month_thru in (1,3,5,7,8,10,12);
				update pd_acedemic_appointments set end_date = datetime(string(year_thru) + '/12/30 00:00:00') where year_thru is not null and month_thru is null and end_date is null;
				of_visible(200500)
				of_visible(0200501)
				of_profile(1,"d_prf_academic_dates")
			case 8	//educat
				update pd_education set start_date = datetime(string(year_from) + '/' + string(month_from ) + '/01 00:00:00') where year_from is not null and month_from is not null and start_date is null;
				update pd_education set start_date = datetime(string(year_from) + '/01/01 00:00:00') where year_from is not null and month_from is null and start_date is null;
				
				update pd_education set end_date = datetime(string(year_thru) + '/' + string(month_thru ) + '/30 00:00:00') where year_thru is not null and month_thru is not null and end_date is null and month_thru in (4,6,9,11);
				update pd_education set end_date = datetime(string(year_thru) + '/' + string(month_thru ) + '/28 00:00:00') where year_thru is not null and month_thru is not null and end_date is null and month_thru = 2;
				update pd_education set end_date = datetime(string(year_thru) + '/' + string(month_thru ) + '/31 00:00:00') where year_thru is not null and month_thru is not null and end_date is null and month_thru in (1,3,5,7,8,10,12);
				update pd_education set end_date = datetime(string(year_thru) + '/12/30 00:00:00') where year_thru is not null and month_thru is null and end_date is null;
				of_visible(200502)
				of_visible(200503)
				of_profile(8,"d_prf_education_dates")
			case 2	//specialty
				update pd_board_specialty set initial_cert_date = datetime(string(initial_certification) + '/01/01 00:00:00') where initial_certification is not null and initial_cert_date is null;
				update pd_board_specialty set last_cert_date = datetime(string(last_recertification) + '/01/01 00:00:00') where last_recertification is not null and last_cert_date is null;
				update pd_board_specialty set eligible_until_date = datetime(string(eligible_until) + '/12/31 00:00:00') where eligible_until is not null and eligible_until_date is null;
				update pd_board_specialty set compl_req_date = datetime(string(required_year_completion) + '/12/31 00:00:00') where required_year_completion is not null and compl_req_date is null;
				of_visible(200514)
				of_visible(200515)
				of_visible(200516)
				of_visible(200518)
				of_profile(2,"d_prf_specialties_dates")
			case 9	//hosp
				update pd_hosp_affil set start_date = datetime(string(year_from) + '/' + string(month_from ) + '/01 00:00:00') where year_from is not null and month_from is not null and start_date is null;
				update pd_hosp_affil set start_date = datetime(string(year_from) + '/01/01 00:00:00') where year_from is not null and month_from is null and start_date is null;
				
				update pd_hosp_affil set end_date = datetime(string(year_thru) + '/' + string(month_thru ) + '/30 00:00:00') where year_thru is not null and month_thru is not null and end_date is null and month_thru in (4,6,9,11);
				update pd_hosp_affil set end_date = datetime(string(year_thru) + '/' + string(month_thru ) + '/28 00:00:00') where year_thru is not null and month_thru is not null and end_date is null and month_thru = 2;
				update pd_hosp_affil set end_date = datetime(string(year_thru) + '/' + string(month_thru ) + '/31 00:00:00') where year_thru is not null and month_thru is not null and end_date is null and month_thru in (1,3,5,7,8,10,12);
				update pd_hosp_affil set end_date = datetime(string(year_thru) + '/12/30 00:00:00') where year_thru is not null and month_thru is null and end_date is null;
				of_visible(200504)
				of_visible(200505)
				of_profile(9,"d_prf_hospital_affil_dates")
			case 12	//other affil
				update pd_other_affil set start_date = datetime(string(year_from) + '/' + string(month_from ) + '/01 00:00:00') where year_from is not null and month_from is not null and start_date is null;
				update pd_other_affil set start_date = datetime(string(year_from) + '/01/01 00:00:00') where year_from is not null and month_from is null and start_date is null;
				
				update pd_other_affil set end_date = datetime(string(year_thru) + '/' + string(month_thru ) + '/30 00:00:00') where year_thru is not null and month_thru is not null and end_date is null and month_thru in (4,6,9,11);
				update pd_other_affil set end_date = datetime(string(year_thru) + '/' + string(month_thru ) + '/28 00:00:00') where year_thru is not null and month_thru is not null and end_date is null and month_thru = 2;
				update pd_other_affil set end_date = datetime(string(year_thru) + '/' + string(month_thru ) + '/31 00:00:00') where year_thru is not null and month_thru is not null and end_date is null and month_thru in (1,3,5,7,8,10,12);
				update pd_other_affil set end_date = datetime(string(year_thru) + '/12/30 00:00:00') where year_thru is not null and month_thru is null and end_date is null;
				of_visible(200506)
				of_visible(200507)
				of_profile(12,"d_prf_other_affil_dates")
			case 18	//spec certs
				update pd_special_certs set start_date = datetime(string(initial_cert_year) + '/' + string(initial_cert_month ) + '/01 00:00:00') where initial_cert_year is not null and initial_cert_month is not null and start_date is null;
				update pd_special_certs set start_date = datetime(string(initial_cert_year) + '/01/01 00:00:00') where initial_cert_year is not null and initial_cert_month is null and start_date is null;
				
				update pd_special_certs set end_date = datetime(string(cert_expiration_year) + '/' + string(cert_expiration_month ) + '/30 00:00:00') where cert_expiration_year is not null and cert_expiration_month is not null and end_date is null and cert_expiration_month in (4,6,9,11);
				update pd_special_certs set end_date = datetime(string(cert_expiration_year) + '/' + string(cert_expiration_month ) + '/28 00:00:00') where cert_expiration_year is not null and cert_expiration_month is not null and end_date is null and cert_expiration_month = 2;
				update pd_special_certs set end_date = datetime(string(cert_expiration_year) + '/' + string(cert_expiration_month ) + '/31 00:00:00') where cert_expiration_year is not null and cert_expiration_month is not null and end_date is null and cert_expiration_month in  (1,3,5,7,8,10,12);
				update pd_special_certs set end_date = datetime(string(cert_expiration_year) + '/12/30 00:00:00') where cert_expiration_year is not null and cert_expiration_month is null and end_date is null;
				of_visible(200508)
				of_visible(200509)
				of_profile(18,"d_prf_special_certs_dates")		
			case 19	// training
				update pd_training set start_date = datetime(string(year_from) + '/' + string(month_from ) + '/01 00:00:00') where year_from is not null and month_from is not null and start_date is null;
				update pd_training set start_date = datetime(string(year_from) + '/01/01 00:00:00') where year_from is not null and month_from is null and start_date is null;
				
				update pd_training set end_date = datetime(string(year_thru) + '/' + string(month_thru ) + '/30 00:00:00') where year_thru is not null and month_thru is not null and end_date is null and month_thru in (4,6,9,11);
				update pd_training set end_date = datetime(string(year_thru) + '/' + string(month_thru ) + '/28 00:00:00') where year_thru is not null and month_thru is not null and end_date is null and month_thru = 2;
				update pd_training set end_date = datetime(string(year_thru) + '/' + string(month_thru ) + '/31 00:00:00') where year_thru is not null and month_thru is not null and end_date is null and month_thru in (1,3,5,7,8,10,12);
				update pd_training set end_date = datetime(string(year_thru) + '/12/30 00:00:00') where year_thru is not null and month_thru is null and end_date is null;
				of_visible(200510)
				of_visible(200511)
				of_profile(19,"d_prf_training_dates")
			case 14	//prof exp
				update pd_prof_experience set start_date = datetime(string(date_from_year) + '/' + string(date_from_month ) + '/01 00:00:00') where date_from_year is not null and date_from_month is not null and start_date is null;
				update pd_prof_experience set start_date = datetime(string(date_from_year) + '/01/01 00:00:00') where date_from_year is not null and date_from_month is null and start_date is null;
				
				update pd_prof_experience set end_date = datetime(string(date_to_year) + '/' + string(date_to_month ) + '/30 00:00:00') where date_to_year is not null and date_to_month is not null and end_date is null and date_to_month in (4,6,9,11);
				update pd_prof_experience set end_date = datetime(string(date_to_year) + '/' + string(date_to_month ) + '/28 00:00:00') where date_to_year is not null and date_to_month is not null and end_date is null and date_to_month = 2;
				update pd_prof_experience set end_date = datetime(string(date_to_year) + '/' + string(date_to_month ) + '/31 00:00:00') where date_to_year is not null and date_to_month is not null and end_date is null and date_to_month in  (1,3,5,7,8,10,12);
				update pd_prof_experience set end_date = datetime(string(date_to_year) + '/12/30 00:00:00') where date_to_year is not null and date_to_month is null and end_date is null;
				of_visible(200512)
				of_visible(200513)
				of_profile(14,"d_prf_prof_experience_dates")
			case 22	//license
				update pd_license set issue_date = datetime(string(year_issued) + '/01/01 00:00:00') where year_issued is not null and issue_date is null;
				of_visible(200517)
				of_profile(22,"d_prf_license_dates")
		end choose
	end if
	
next

commit using sqlca;
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02
//$<add> 02.10.2006 By: Wangchao
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_commitqueue( )

//---------------------------- APPEON END ----------------------------
messagebox("Finished","Completed")
end event

