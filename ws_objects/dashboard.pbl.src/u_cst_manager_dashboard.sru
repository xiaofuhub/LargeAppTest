$PBExportHeader$u_cst_manager_dashboard.sru
forward
global type u_cst_manager_dashboard from userobject
end type
type dw_facility from datawindow within u_cst_manager_dashboard
end type
type cb_1 from commandbutton within u_cst_manager_dashboard
end type
type dw_report from datawindow within u_cst_manager_dashboard
end type
type dw_graph from datawindow within u_cst_manager_dashboard
end type
type dw_dates from u_dw within u_cst_manager_dashboard
end type
type rb_both from radiobutton within u_cst_manager_dashboard
end type
type rb_data from radiobutton within u_cst_manager_dashboard
end type
type st_select from statictext within u_cst_manager_dashboard
end type
type ddlb_1 from dropdownlistbox within u_cst_manager_dashboard
end type
type gb_show from groupbox within u_cst_manager_dashboard
end type
type dw_menu from datawindow within u_cst_manager_dashboard
end type
type dw_reports from datawindow within u_cst_manager_dashboard
end type
end forward

global type u_cst_manager_dashboard from userobject
integer width = 4864
integer height = 2336
long backcolor = 33551856
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_facility dw_facility
cb_1 cb_1
dw_report dw_report
dw_graph dw_graph
dw_dates dw_dates
rb_both rb_both
rb_data rb_data
st_select st_select
ddlb_1 ddlb_1
gb_show gb_show
dw_menu dw_menu
dw_reports dw_reports
end type
global u_cst_manager_dashboard u_cst_manager_dashboard

type variables
string is_last_step
string is_type = "G"
integer ii_report_index


u_calendar 	iuo_Calendar
window iparentwindow
end variables

forward prototypes
public function integer of_run_graph (integer ai_index)
public function integer of_setdddwcalendar (boolean ab_switch, datawindow adw)
public function integer of_drill_modify (integer ai_index, integer ai_data, string as_name)
public function string of_get_date_range (string as_field)
public function integer of_drill_down (integer ai_data, long ai_row)
public function integer of_arrange_screen (string as_type)
public function integer of_set_resize ()
public function integer of_set_graph_report (integer ai_index)
end prototypes

public function integer of_run_graph (integer ai_index); //Start Code Change ----11.15.2015 #V15 maha
integer li_final
string ls_field
string ls_sql
string ls_org
string ls_where
string ls_from
string ls_to


select final_step into :li_final from sys_appl_tracker where tracker_id = 1;

ls_field = "step_" + string(li_final)
is_last_step = ls_field


choose case ai_index
	case 1
		dw_graph.dataobject = "d_graph_step_compl"
	case 2
		dw_graph.dataobject = "d_graph_ave_complete"
	case 3
		dw_graph.dataobject = "d_graph_ave_compl_by_payor"
	case 4
		dw_graph.dataobject = "d_graph_ave_compl_by_user"	
	case 5
		dw_graph.dataobject = ""	
	
end choose
debugbreak()

//ls_where = of_get_date_range(ls_field)
//messagebox("", ls_where)

dw_graph.settransobject(sqlca)
of_set_graph_report( ai_index)

if len(ls_where) > 0 then
	ls_sql = dw_graph.getsqlselect()
	ls_org = ls_sql
	ls_sql+= ls_where
	dw_graph.setsqlselect(ls_sql)
	dw_graph.settransobject(sqlca)
	dw_graph.retrieve() 
	dw_graph.setsqlselect(ls_org)
else
	dw_graph.retrieve()
end if


return 1
end function

public function integer of_setdddwcalendar (boolean ab_switch, datawindow adw);window lw_parent
string	ls_classname
n_cst_calendarattrib lnv_calendarattrib


// Check arguments
if IsNull(ab_switch) then return -1


if ab_Switch then
	if not IsValid (iuo_Calendar) then
	
		// Tell the object to behave as a dropdown object.
		lnv_calendarattrib.ib_dropdown = true
		//this.OpenUserObjectWithParm(iuo_Calendar, lnv_calendarattrib)
		iparentwindow.OpenUserObjectWithParm(iuo_Calendar, lnv_calendarattrib)
		iuo_Calendar.of_SetRequestor (adw)
		
		return 1
	end if
else 
	if IsValid (iuo_Calendar) then
		//this.CloseUserObject(iuo_Calendar)
		iparentwindow.CloseUserObject(iuo_Calendar)
		return 1
	end if	
end if 

return 0
end function

public function integer of_drill_modify (integer ai_index, integer ai_data, string as_name);string ls_sql
string ls_sql_org
string ls_where
string ls_dates

ls_sql = dw_report.getsqlselect()
ls_sql_org = ls_sql 

choose case ai_index
	case 1
		ls_where = " and step_" + string(ai_data) + " is not null "
//		choose case ai_data
//			case 1
//				ls_where = " and step_1 is not null "
//			case 2
//				ls_where = " and step_2 is not null "
//			case 3
//				ls_where = " and step_3 is not null "
//			case 4
//				ls_where = " and step_4 is not null "
//			case 5
//				ls_where = " and step_5 is not null "
//		end choose
	case 2 
		choose case ai_data
			case 1
				ls_where = " and days_total >= 120 "
			case 2
				ls_where = " and days_total < 30 "
			case 3
				ls_where = " and days_total < 60 and days_total  >= 30 "
			case 4
				ls_where = " and days_total < 90 and days_total >= 60 "
			case 5
				ls_where = " and days_total < 120 and days_total >= 90 "
		end choose
	case 3
		ls_where = " and pd_appl_tracking.app_id = " + string(ai_data)
		//dw_report.expandall( )
	case 4
		if isnull(as_name) then
			ls_where = " and pd_appl_tracking.assigned_user is null "
		else
			ls_where = " and pd_appl_tracking.assigned_user = '" + as_name + "'"
		end if
end choose

ls_sql+= ls_where

ls_dates = of_get_date_range( is_last_step)

if len(ls_dates) > 0 then
	ls_sql+= ls_dates
end if 

//messagebox("",ls_sql)
dw_report.setsqlselect(ls_sql)
dw_report.settransobject(sqlca)
dw_report.retrieve()

dw_report.expandall()

dw_report.setsqlselect(ls_sql_org)
dw_report.settransobject(sqlca)				






return 1


end function

public function string of_get_date_range (string as_field);
string ls_from
string ls_to
string ls_where

dw_dates.accepttext()
ls_from = string(dw_dates.getitemdate(1,"from_date"),"yyyy-mm-dd")
//messagebox("ls_from", ls_from)
ls_to = string(dw_dates.getitemdate(1,"to_date"),"yyyy-mm-dd")
//messagebox("ls_to", ls_to)

if  len(ls_from) > 0 then
	ls_where = " and (" + as_field + " >= '" + ls_from + " 00:00:00')"
end if

if  len(ls_to) > 0 then
	ls_where+= " and (" + as_field + " <= '" + ls_to + " 23:59:59')"
end if

return ls_where
end function

public function integer of_drill_down (integer ai_data, long ai_row);long ll_value
string ls_name


choose case ii_report_index
	case 1
		of_drill_modify(ii_report_index, ai_data,"")
	case 2
		of_drill_modify(ii_report_index, ai_data,"")
	case 3
		ls_name = dw_graph.categoryname('gr_1', ai_data)
		//messagebox("",ls_name)
		select app_id  into :ll_value from app_hdr where application_name = :ls_name; 
		//ll_value = long(ls_name) //dw_graph.getitemnumber(ai_row, "app_id")
		of_drill_modify(ii_report_index, ll_value, "")
	case 4
		ls_name = dw_graph.categoryname('gr_1', ai_data)
		of_drill_modify(ii_report_index, ll_value, ls_name)
	case 5
		
end choose

return 1
end function

public function integer of_arrange_screen (string as_type);
Choose case as_type
	case "G"
		ddlb_1.visible = true
		st_select.visible = true
		dw_reports.visible = false
		gb_show.visible = true
		rb_both.visible = true
		rb_data.visible = true
		rb_both.checked = true
		dw_report.reset()
		dw_graph.visible = true
		dw_dates.visible = true
		
	case "R"
		ddlb_1.visible = false
		st_select.visible = true
		dw_reports.visible = true
		gb_show.visible = false
		rb_both.visible = false
		rb_data.visible = false
		rb_data.checked = true
		rb_both.checked = false
		dw_report.reset()
		dw_graph.visible = false
		dw_dates.visible = false
		
	case "U"
		ddlb_1.visible = false
		st_select.visible = false
		dw_reports.visible = false
		dw_graph.visible = false
		dw_dates.visible = false
		gb_show.visible = false
		rb_both.visible = false
		rb_data.visible = false
		rb_data.checked = true
		rb_both.checked = false
		dw_report.dataobject = "d_dash_man_utilites"
		
end choose

return 1
end function

public function integer of_set_resize ();long ll_width
long ll_height
long ll_anchorx = 398


ll_width = this.width - ll_anchorx - 60
ll_height =  this.height - 180

ll_width = ll_width/5

if rb_data.checked then
	dw_graph.visible = false
	dw_report.x = ll_anchorx
	dw_report.width = ll_width * 5 - 20
else  //both
	dw_graph.visible = true
	dw_graph.width = ll_width * 3
	dw_report.x = dw_graph.x + dw_graph.width + 20
	dw_report.width = ll_width * 2 - 40
end if

dw_menu.height =  ll_height - 160
dw_graph.height = dw_menu.height
dw_report.height = dw_menu.height


return 1
end function

public function integer of_set_graph_report (integer ai_index);
choose case ai_index
	Case 0 
		dw_report.dataobject = ""
	case 1
		dw_report.dataobject = "d_pd_appl_tracking_w_loc_report" 
	case 2
		dw_report.dataobject = "d_rpt_ave_compl"
	case 3
		dw_report.dataobject = "d_rpt_ave_compl"	
	case 4
		dw_report.dataobject = "d_rpt_ave_compl"		
	case 5
		dw_report.dataobject = ""
end choose

dw_report.settransobject(sqlca)


return 1
end function

on u_cst_manager_dashboard.create
this.dw_facility=create dw_facility
this.cb_1=create cb_1
this.dw_report=create dw_report
this.dw_graph=create dw_graph
this.dw_dates=create dw_dates
this.rb_both=create rb_both
this.rb_data=create rb_data
this.st_select=create st_select
this.ddlb_1=create ddlb_1
this.gb_show=create gb_show
this.dw_menu=create dw_menu
this.dw_reports=create dw_reports
this.Control[]={this.dw_facility,&
this.cb_1,&
this.dw_report,&
this.dw_graph,&
this.dw_dates,&
this.rb_both,&
this.rb_data,&
this.st_select,&
this.ddlb_1,&
this.gb_show,&
this.dw_menu,&
this.dw_reports}
end on

on u_cst_manager_dashboard.destroy
destroy(this.dw_facility)
destroy(this.cb_1)
destroy(this.dw_report)
destroy(this.dw_graph)
destroy(this.dw_dates)
destroy(this.rb_both)
destroy(this.rb_data)
destroy(this.st_select)
destroy(this.ddlb_1)
destroy(this.gb_show)
destroy(this.dw_menu)
destroy(this.dw_reports)
end on

type dw_facility from datawindow within u_cst_manager_dashboard
integer x = 3826
integer y = 40
integer width = 741
integer height = 96
integer taborder = 20
string title = "none"
string dataobject = "d_facility_select"
boolean border = false
boolean livescroll = true
end type

type cb_1 from commandbutton within u_cst_manager_dashboard
boolean visible = false
integer x = 4585
integer y = 44
integer width = 251
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "holder"
end type

type dw_report from datawindow within u_cst_manager_dashboard
integer x = 3351
integer y = 176
integer width = 1504
integer height = 2160
integer taborder = 30
boolean bringtotop = true
string title = "none"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event buttonclicked;choose case dwo.name
	case "b_assign"
		open(w_user_assignment)
	case "b_sessions"
		Open(w_session_info_utl)
	case "b_audit"
		open(w_login_audit)
end choose
end event

type dw_graph from datawindow within u_cst_manager_dashboard
integer x = 398
integer y = 176
integer width = 2939
integer height = 2160
integer taborder = 20
boolean bringtotop = true
string title = "none"
boolean livescroll = true
end type

event clicked;string s
integer li_series
integer li_data


dw_graph.ObjectAtPointer ( "gr_1", li_series, li_data )
debugbreak()
of_drill_down(li_data,row)
//messagebox("s",li_data)
end event

type dw_dates from u_dw within u_cst_manager_dashboard
integer x = 2487
integer y = 48
integer width = 1271
integer height = 96
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_date_range_gets"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event clicked;string ls_coltype
//debugbreak()
//If isvalid(iuo_Calendar) Then
//	ls_coltype = this.Describe(dwo.name+".ColType")	
//	If ls_coltype = 'date' or ls_coltype = 'datetime' Then
//		iuo_Calendar.of_Register(dwo.name, iuo_Calendar.DDLB_WITHARROW)
//	End If
//End If

//iuo_Calendar.of_Register("from_date", iuo_Calendar.DDLB_WITHARROW)
//iuo_Calendar.of_Register("to_date", iuo_Calendar.DDLB_WITHARROW)
end event

event constructor;call super::constructor;this.insertrow(1)
end event

type rb_both from radiobutton within u_cst_manager_dashboard
integer x = 1417
integer y = 60
integer width = 576
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Graph and Data"
boolean checked = true
end type

event clicked;of_arrange_screen( "G")
of_set_resize( )
end event

type rb_data from radiobutton within u_cst_manager_dashboard
integer x = 2053
integer y = 60
integer width = 334
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Data Only"
end type

event clicked;of_set_resize( )
end event

type st_select from statictext within u_cst_manager_dashboard
integer x = 18
integer y = 52
integer width = 398
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select Report:"
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within u_cst_manager_dashboard
integer x = 434
integer y = 44
integer width = 919
integer height = 400
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean sorted = false
string item[] = {"Tracking Steps Completed","Tracking Completion by Days","Ave. Completion by Payor","Ave. Completion by User"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;ii_report_index = index
of_run_graph(index)


//How many files have been assigned to a user 
//How many verifications are outstanding for providers that have been assigned to users
//How many items are missing for providers that have been assigned to users
//Turn Around Time – How long it is taking from time app received until approved (appointments tab)
//Turn Around Time – How long it is taking from time app received until approved (applications tab)
//Number of apps currently in queue – PENDING on Appointments tab
//Credentialing/re-credentialing completed per quarter; Expiring per quarter
//Number of practitioner terms per quarter
end event

type gb_show from groupbox within u_cst_manager_dashboard
integer x = 1371
integer y = 4
integer width = 1088
integer height = 148
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Show"
end type

type dw_menu from datawindow within u_cst_manager_dashboard
integer x = 5
integer y = 176
integer width = 384
integer height = 2160
integer taborder = 30
string title = "none"
string dataobject = "d_dash_man_menu"
boolean livescroll = true
end type

event constructor;this.insertrow(1)
end event

event buttonclicked;if dwo.name = "b_gra" then
	is_type = "G"
	of_set_graph_report( ii_report_index)
elseif dwo.name = "b_rep" then
	is_type = "R"
else
	is_type = "U"
end if

of_arrange_screen(is_type)
of_set_resize( )

end event

type dw_reports from datawindow within u_cst_manager_dashboard
boolean visible = false
integer x = 434
integer y = 4
integer width = 919
integer height = 104
integer taborder = 20
string title = "none"
boolean livescroll = true
end type

event constructor;this.insertrow(1)
end event

