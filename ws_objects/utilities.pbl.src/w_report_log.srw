$PBExportHeader$w_report_log.srw
forward
global type w_report_log from w_response
end type
type cb_2 from commandbutton within w_report_log
end type
type st_1 from statictext within w_report_log
end type
type ddlb_type from dropdownlistbox within w_report_log
end type
type cb_output from uo_cb_output within w_report_log
end type
type cb_1 from commandbutton within w_report_log
end type
type dw_dates from u_dw within w_report_log
end type
type cb_close from commandbutton within w_report_log
end type
type dw_1 from u_dw within w_report_log
end type
type gb_1 from groupbox within w_report_log
end type
end forward

global type w_report_log from w_response
integer width = 4201
integer height = 2088
string title = "Reports Log"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = main!
long backcolor = 33551856
cb_2 cb_2
st_1 st_1
ddlb_type ddlb_type
cb_output cb_output
cb_1 cb_1
dw_dates dw_dates
cb_close cb_close
dw_1 dw_1
gb_1 gb_1
end type
global w_report_log w_report_log

forward prototypes
public function string of_get_name (long al_row)
end prototypes

public function string of_get_name (long al_row);string ls_type
string ls_name = ""
long ll_id

ls_type = dw_1.getitemstring(al_row, "rpt_type")
ll_id = dw_1.getitemnumber(al_row, "report_id")

choose case ls_type
	case "S"
		select report_name into :ls_name from sys_reports where report_id = :ll_id;
	case "C"
		select view_name into :ls_name from conv_view where view_id = :ll_id;
	case "E"
		select export_name into :ls_name from export_header where export_id = :ll_id;
	case "1"
		select report_name into :ls_name from sys_one_click where rpt_id = :ll_id;
	case "Q"
		select sched_name into :ls_name from schedule_hrd where sched_id = :ll_id;
	case else //Start Code Change ----06.08.2016 #V152 maha - for older records
		select report_name into :ls_name from sys_reports where report_id = :ll_id;
end choose


return ls_name
end function

on w_report_log.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.st_1=create st_1
this.ddlb_type=create ddlb_type
this.cb_output=create cb_output
this.cb_1=create cb_1
this.dw_dates=create dw_dates
this.cb_close=create cb_close
this.dw_1=create dw_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.ddlb_type
this.Control[iCurrent+4]=this.cb_output
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.dw_dates
this.Control[iCurrent+7]=this.cb_close
this.Control[iCurrent+8]=this.dw_1
this.Control[iCurrent+9]=this.gb_1
end on

on w_report_log.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.ddlb_type)
destroy(this.cb_output)
destroy(this.cb_1)
destroy(this.dw_dates)
destroy(this.cb_close)
destroy(this.dw_1)
destroy(this.gb_1)
end on

type cb_2 from commandbutton within w_report_log
integer x = 2930
integer y = 56
integer width = 553
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Current Report Name"
boolean cancel = true
end type

event clicked;string s

if dw_1.rowcount() < 1 then return  //Start Code Change ----07.18.2016 #V152 maha

s = of_get_name(dw_1.getrow())

messagebox("Report name",s)
end event

type st_1 from statictext within w_report_log
integer x = 1413
integer y = 76
integer width = 160
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Type:"
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_type from dropdownlistbox within w_report_log
integer x = 1586
integer y = 60
integer width = 567
integer height = 580
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string item[] = {"Std. Reports","IntelliReports","Exports","One Click","Scheduler Reports","All"}
end type

type cb_output from uo_cb_output within w_report_log
integer x = 4187
integer y = 96
integer width = 416
integer height = 84
integer taborder = 20
end type

event clicked;

m_npdb_options NewMenu 
NewMenu = CREATE m_npdb_options
NewMenu.of_setparent(idw)
NewMenu.m_options.m_mailall.visible = false
NewMenu.m_options.m_printall.visible = false
NewMenu.m_options.m_printcurrent.text = 'Print'
NewMenu.m_options.m_mailcurrent.text = 'EMail'
//NewMenu.m_options.PopMenu(w_mdi.pointerx(),w_mdi.pointerY())
//NewMenu.m_options.PopMenu(this.x + parent.x, this.y + parent.y + 90) //alfee 11.17.2010//(Appeon)Toney 11.22.2013 - V141 ISG-CLX,Fix history BugT072501
gnv_app.of_popmenu(this,NewMenu.m_options)//(Appeon)Toney 11.22.2013 - V141 ISG-CLX,Fix history BugT072501
//this calls events in u_dw
//the save as pdf calls ...
end event

event constructor;call super::constructor;idw = dw_1
end event

type cb_1 from commandbutton within w_report_log
integer x = 2190
integer y = 56
integer width = 402
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Get Records"
end type

event clicked;string ls_from
string ls_to
string ls_where
integer li_final
string ls_field
string ls_sql
string ls_org
string ls_type
string ls_type_data = "All"


dw_dates.accepttext()
ls_from = string(dw_dates.getitemdate(1,"from_date"),"yyyy-mm-dd")
//messagebox("ls_from", ls_from)
ls_to = string(dw_dates.getitemdate(1,"to_date"),"yyyy-mm-dd")
//messagebox("ls_to", ls_to)

if  len(ls_from) > 0 then
	ls_where = " and ( date_run >= '" + ls_from + " 00:00:00')"
end if

if  len(ls_to) > 0 then
	ls_where+= " and (date_run <= '" + ls_to + " 23:59:59')"
end if

ls_type = ddlb_type.text

choose case ls_type
	case "All"
		ls_type_data = "All"
	case "Exports"
		ls_type_data = "E"
	case "Std. Reports"
		ls_type_data = "S"
	case "IntelliReports"
		ls_type_data = "C"
	case "One Click"
		ls_type_data = "1"
	case "Scheduler Reports"
		ls_type_data = "Q"	
end choose

if ls_type_data <> "All" then
	ls_where+= " and (rpt_type = '" + ls_type_data + "')"
end if
	
if len(ls_where) > 0 then
	ls_sql = dw_1.getsqlselect()
	ls_org = ls_sql
	ls_sql+= ls_where
	//messagebox("",ls_sql)
	dw_1.setsqlselect(ls_sql)
	dw_1.settransobject(sqlca)
	dw_1.retrieve() 
	dw_1.setsqlselect(ls_org)
else
	dw_1.retrieve()
end if
end event

type dw_dates from u_dw within w_report_log
integer x = 73
integer y = 60
integer width = 1271
integer height = 96
integer taborder = 20
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

event constructor;call super::constructor;This.of_SetUpdateAble( False )
This.of_SetTransObject( SQLCA )
This.InsertRow( 0 )

This.of_SetDropDownCalendar( TRUE )
This.iuo_calendar.of_Register(this.iuo_calendar.DDLB)
end event

type cb_close from commandbutton within w_report_log
integer x = 3790
integer y = 56
integer width = 347
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

type dw_1 from u_dw within w_report_log
integer y = 200
integer width = 4155
integer height = 1780
integer taborder = 10
string dataobject = "d_report_log_audit"
boolean hscrollbar = true
end type

event constructor;call super::constructor;this.of_settransobject(sqlca)
this.of_setupdateable( false)
end event

type gb_1 from groupbox within w_report_log
integer width = 2176
integer height = 168
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Filters"
borderstyle borderstyle = stylebox!
end type

