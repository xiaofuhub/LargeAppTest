$PBExportHeader$w_oig_scan_log_prac.srw
forward
global type w_oig_scan_log_prac from w_main
end type
type cb_2 from commandbutton within w_oig_scan_log_prac
end type
type cb_1 from commandbutton within w_oig_scan_log_prac
end type
type dw_report from u_dw within w_oig_scan_log_prac
end type
type cb_8 from uo_cb_output within w_oig_scan_log_prac
end type
type dw_change from datawindow within w_oig_scan_log_prac
end type
type cb_close from commandbutton within w_oig_scan_log_prac
end type
end forward

global type w_oig_scan_log_prac from w_main
integer width = 3063
integer height = 2464
string title = "OIG Scan Log"
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
cb_1 cb_1
dw_report dw_report
cb_8 cb_8
dw_change dw_change
cb_close cb_close
end type
global w_oig_scan_log_prac w_oig_scan_log_prac

type variables
datetime idt_from = datetime( date("2000-01-01"), time( "00:00:00"))
datetime idt_to = datetime(today(), time("23:59:59") )
string is_type = "LOG"
end variables

on w_oig_scan_log_prac.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_report=create dw_report
this.cb_8=create cb_8
this.dw_change=create dw_change
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_report
this.Control[iCurrent+4]=this.cb_8
this.Control[iCurrent+5]=this.dw_change
this.Control[iCurrent+6]=this.cb_close
end on

on w_oig_scan_log_prac.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_report)
destroy(this.cb_8)
destroy(this.dw_change)
destroy(this.cb_close)
end on

event resize;dw_report.width = this.width - 130
dw_report.height = this.height - 430

end event

event closequery;//skip
end event

event open;call super::open;//Start Code Change ----11.04.2016 #V153 maha - created
long ll_prac

ll_prac = message.doubleparm

dw_report.settransobject(sqlca)
dw_report.retrieve(ll_prac)


end event

type cb_2 from commandbutton within w_oig_scan_log_prac
integer x = 1893
integer y = 16
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

type cb_1 from commandbutton within w_oig_scan_log_prac
integer x = 1536
integer y = 16
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

type dw_report from u_dw within w_oig_scan_log_prac
integer x = 9
integer y = 132
integer width = 3003
integer height = 2220
integer taborder = 50
string dataobject = "d_oig_scan_log_prac"
end type

type cb_8 from uo_cb_output within w_oig_scan_log_prac
integer x = 2240
integer y = 16
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

type dw_change from datawindow within w_oig_scan_log_prac
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

type cb_close from commandbutton within w_oig_scan_log_prac
integer x = 2656
integer y = 16
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

