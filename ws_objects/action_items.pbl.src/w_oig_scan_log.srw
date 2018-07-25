$PBExportHeader$w_oig_scan_log.srw
forward
global type w_oig_scan_log from w_main
end type
type rb_batch from radiobutton within w_oig_scan_log
end type
type cb_2 from commandbutton within w_oig_scan_log
end type
type cb_1 from commandbutton within w_oig_scan_log
end type
type dw_report from u_dw within w_oig_scan_log
end type
type cb_8 from uo_cb_output within w_oig_scan_log
end type
type dw_change from datawindow within w_oig_scan_log
end type
type dw_date_range from u_dw within w_oig_scan_log
end type
type rb_last from radiobutton within w_oig_scan_log
end type
type rb_not from radiobutton within w_oig_scan_log
end type
type cb_run from commandbutton within w_oig_scan_log
end type
type rb_change from radiobutton within w_oig_scan_log
end type
type rb_log from radiobutton within w_oig_scan_log
end type
type cb_close from commandbutton within w_oig_scan_log
end type
type gb_1 from groupbox within w_oig_scan_log
end type
end forward

global type w_oig_scan_log from w_main
integer width = 4032
integer height = 2604
string title = "OIG Scan Log"
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
rb_batch rb_batch
cb_2 cb_2
cb_1 cb_1
dw_report dw_report
cb_8 cb_8
dw_change dw_change
dw_date_range dw_date_range
rb_last rb_last
rb_not rb_not
cb_run cb_run
rb_change rb_change
rb_log rb_log
cb_close cb_close
gb_1 gb_1
end type
global w_oig_scan_log w_oig_scan_log

type variables
datetime idt_from = datetime( date("2000-01-01"), time( "00:00:00"))
datetime idt_to = datetime(today(), time("23:59:59") )
string is_type = "LOG"
end variables

forward prototypes
public subroutine of_set_dw (string as_from)
public function integer of_run_change ()
end prototypes

public subroutine of_set_dw (string as_from);dw_date_range.modify("to_date_t.visible = 1 to_date.visible = 1")//Added by Appeon long.zhang 10.16.2014

choose case as_from
	case "LOG"
		dw_report.dataobject = "d_oig_scan_log_report"
		dw_date_range.visible = true
	case "LAST"
		dw_report.dataobject = "d_oig_scan_log_last_scan"
		dw_date_range.visible = true
	case "NOT"
		dw_report.dataobject = "d_oig_scan_log_not_recent"
		dw_date_range.visible = true
		
		dw_date_range.modify("to_date_t.visible = 0 to_date.visible = 0")//Added by Appeon long.zhang 10.16.2014
	case "CHANGE"
		dw_report.dataobject = "d_oig_scan_log_change_report"
		dw_date_range.visible = false
	case "BATCHES"
		dw_report.dataobject = "d_oig_scan_log_batches"
		dw_date_range.visible = true
end choose

is_type = as_from

dw_report.settransobject(sqlca)
end subroutine

public function integer of_run_change ();//Start Code Change ----10.12.2014 #V14.2 maha - added

long rc
long r
long nr
long ll_prac
//long ll_prac_next = 0
datetime lds_date
integer cnt1
integer cnt2
datastore lds_change

dw_change.settransobject(sqlca)
rc = dw_change.retrieve()
debugbreak()
if rc < 0 then 
	messagebox("Change report","Change data failed" )
	return 1
elseif rc = 0 then
	messagebox("Change report","No change data" )
	return 1
end if

for r = 1 to rc
	if r = rc then exit  //skip last row
	ll_prac = dw_change.getitemnumber(r,"prac_id")
	if ll_prac =  dw_change.getitemnumber(r + 1,"prac_id") then
		if dw_change.getitemnumber(r,"result_count") = dw_change.getitemnumber(r + 1,"result_count") then
			continue
		end if
		nr = dw_report.insertrow(0)
		dw_report.setitem(nr,"prac_id", ll_prac)
		dw_report.setitem(nr,"full_name", dw_change.getitemstring(r,"full_name") )
		dw_report.setitem(nr,"scan_date",  dw_change.getitemdatetime(r,"scan_date")  )
		dw_report.setitem(nr,"result_count", dw_change.getitemnumber(r,"result_count"))
		dw_report.setitem(nr,"run_by", dw_change.getitemstring(r,"run_by"))
		dw_report.setitem(nr,"scan_date_2",  string(date(dw_change.getitemdatetime(r + 1,"scan_date") ) ))
		dw_report.setitem(nr,"count_2", string(dw_change.getitemnumber(r + 1,"result_count")))
		dw_report.setitem(nr,"run_by_2", dw_change.getitemstring(r + 1,"run_by"))
	else
		//continue
	end if
	
next

if dw_report.rowcount() = 0 then
	messagebox("Change report","No Change Results" )
end if




return 1

end function

on w_oig_scan_log.create
int iCurrent
call super::create
this.rb_batch=create rb_batch
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_report=create dw_report
this.cb_8=create cb_8
this.dw_change=create dw_change
this.dw_date_range=create dw_date_range
this.rb_last=create rb_last
this.rb_not=create rb_not
this.cb_run=create cb_run
this.rb_change=create rb_change
this.rb_log=create rb_log
this.cb_close=create cb_close
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_batch
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_report
this.Control[iCurrent+5]=this.cb_8
this.Control[iCurrent+6]=this.dw_change
this.Control[iCurrent+7]=this.dw_date_range
this.Control[iCurrent+8]=this.rb_last
this.Control[iCurrent+9]=this.rb_not
this.Control[iCurrent+10]=this.cb_run
this.Control[iCurrent+11]=this.rb_change
this.Control[iCurrent+12]=this.rb_log
this.Control[iCurrent+13]=this.cb_close
this.Control[iCurrent+14]=this.gb_1
end on

on w_oig_scan_log.destroy
call super::destroy
destroy(this.rb_batch)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_report)
destroy(this.cb_8)
destroy(this.dw_change)
destroy(this.dw_date_range)
destroy(this.rb_last)
destroy(this.rb_not)
destroy(this.cb_run)
destroy(this.rb_change)
destroy(this.rb_log)
destroy(this.cb_close)
destroy(this.gb_1)
end on

event resize;dw_report.width = this.width - 130
dw_report.height = this.height - 430

end event

event closequery;//skip
end event

event open;call super::open;rb_log.PostEvent('clicked') //(Appeon)Harry 11.24.2014 - for BugH101401 




end event

type rb_batch from radiobutton within w_oig_scan_log
integer x = 91
integer y = 196
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Scan Dates"
end type

event clicked;of_set_dw("BATCHES")
end event

type cb_2 from commandbutton within w_oig_scan_log
integer x = 2857
integer y = 92
integer width = 343
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Filter"
end type

event clicked;string null_str

SetNull(null_str)
dw_report.Setfilter(null_str)
dw_report.filter( )
end event

type cb_1 from commandbutton within w_oig_scan_log
integer x = 2510
integer y = 92
integer width = 343
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Sort"
end type

event clicked;string null_str

SetNull(null_str)
dw_report.SetSort(null_str)
dw_report.Sort( )
end event

type dw_report from u_dw within w_oig_scan_log
integer x = 9
integer y = 284
integer width = 3968
integer height = 2192
integer taborder = 50
string dataobject = "d_oig_scan_log_report"
end type

type cb_8 from uo_cb_output within w_oig_scan_log
integer x = 3205
integer y = 92
integer width = 411
integer height = 84
integer taborder = 40
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

event constructor;call super::constructor;idw = dw_report
end event

type dw_change from datawindow within w_oig_scan_log
boolean visible = false
integer x = 133
integer y = 1740
integer width = 777
integer height = 644
integer taborder = 40
string title = "none"
string dataobject = "d_oig_scan_last_2_results"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean border = false
boolean livescroll = true
end type

type dw_date_range from u_dw within w_oig_scan_log
integer x = 1147
integer y = 36
integer width = 960
integer height = 144
integer taborder = 30
string dataobject = "d_select_from_thru_date"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;This.of_SetUpdateAble( False )
This.of_SetTransObject( SQLCA )
This.InsertRow( 0 )

This.of_SetDropDownCalendar( TRUE )
This.iuo_calendar.of_Register(this.iuo_calendar.DDLB)
end event

event itemchanged;call super::itemchanged;
if dwo.name = "from_date" then
	idt_from = datetime(date(data), time("00:00:00"))
elseif dwo.name = "to_date" then
	idt_to = datetime(date(data), time("23:59:59"))
end if
end event

event editchanged;call super::editchanged;//---------Begin Added by (Appeon)Harry 11.24.2014 for BugH101302 --------
DateTime ldt_null
If IsNull(data) or data = "" Then
	SetNull(ldt_null)
	Choose Case dwo.name
		Case 'from_date'
			this.setitem(1, 'from_date', ldt_null)
		Case 'to_date'
			this.setitem(1, 'to_date', ldt_null)
	End Choose
End If
//---------End Added ------------------------------------------------------
end event

type rb_last from radiobutton within w_oig_scan_log
integer x = 91
integer y = 124
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Last Scan"
end type

event clicked;of_set_dw("LAST")
end event

type rb_not from radiobutton within w_oig_scan_log
integer x = 457
integer y = 56
integer width = 631
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Not Recently Scanned"
end type

event clicked;of_set_dw("NOT")
end event

type cb_run from commandbutton within w_oig_scan_log
integer x = 2121
integer y = 92
integer width = 343
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Run"
end type

event clicked;long r

dw_date_range.accepttext()//Added by Appeon long.zhang 10.16.2014

dw_report.settransobject(sqlca)

choose case is_type
	case "LOG"
		r = dw_report.retrieve(idt_from, idt_to  )
	case "LAST"
		r = dw_report.retrieve(idt_from, idt_to  )
	case "NOT"
		r = dw_report.retrieve(idt_from  )
	case "CHANGE"
		of_run_change()
	case "BATCHES"
		r = dw_report.retrieve(idt_from, idt_to  )
end choose


end event

type rb_change from radiobutton within w_oig_scan_log
integer x = 457
integer y = 128
integer width = 631
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Change Report"
end type

event clicked;of_set_dw("CHANGE")
end event

type rb_log from radiobutton within w_oig_scan_log
integer x = 91
integer y = 52
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Scan Log"
boolean checked = true
end type

event clicked;of_set_dw("LOG")
end event

type cb_close from commandbutton within w_oig_scan_log
integer x = 3621
integer y = 92
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

type gb_1 from groupbox within w_oig_scan_log
integer x = 14
integer width = 1102
integer height = 264
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "View Report"
end type

