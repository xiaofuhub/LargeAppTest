$PBExportHeader$w_schedule_detail.srw
forward
global type w_schedule_detail from window
end type
type cb_2 from commandbutton within w_schedule_detail
end type
type cb_1 from commandbutton within w_schedule_detail
end type
type tab_1 from tab within w_schedule_detail
end type
type tabpage_1 from userobject within tab_1
end type
type dw_log_detail from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_log_detail dw_log_detail
end type
type tab_1 from tab within w_schedule_detail
tabpage_1 tabpage_1
end type
end forward

global type w_schedule_detail from window
integer width = 2107
integer height = 2128
boolean titlebar = true
string title = "Log detail"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
cb_1 cb_1
tab_1 tab_1
end type
global w_schedule_detail w_schedule_detail

on w_schedule_detail.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.tab_1=create tab_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.tab_1}
end on

on w_schedule_detail.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.tab_1)
end on

event open;IF Message.StringParm = '0' THEN
	tab_1.tabpage_1.dw_log_detail.dataobject='d_sched_log_detail'
	tab_1.tabpage_1.dw_log_detail.settransobject(sqlca)
	w_schedule_logview.dw_viewlog.ShareData(tab_1.tabpage_1.dw_log_detail)
ELSEIF Message.StringParm = '1' THEN
	tab_1.tabpage_1.dw_log_detail.dataobject='d_sched_verify_log_detail'
	tab_1.tabpage_1.dw_log_detail.settransobject(sqlca)
	w_schedule_logview.dw_schedule_veri_log.ShareData(tab_1.tabpage_1.dw_log_detail)
END IF


end event

type cb_2 from commandbutton within w_schedule_detail
integer x = 1728
integer y = 1876
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_schedule_detail
integer x = 1385
integer y = 1876
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Ok"
end type

event clicked;close(parent)
end event

type tab_1 from tab within w_schedule_detail
integer width = 2085
integer height = 1820
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.Control[]={this.tabpage_1}
end on

on tab_1.destroy
destroy(this.tabpage_1)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2048
integer height = 1704
long backcolor = 67108864
string text = "Detail"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_log_detail dw_log_detail
end type

on tabpage_1.create
this.dw_log_detail=create dw_log_detail
this.Control[]={this.dw_log_detail}
end on

on tabpage_1.destroy
destroy(this.dw_log_detail)
end on

type dw_log_detail from datawindow within tabpage_1
integer width = 2062
integer height = 1700
integer taborder = 20
string title = "none"
string dataobject = "d_sched_log_detail"
boolean border = false
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
end event

event rowfocuschanged;IF tab_1.tabpage_1.dw_log_detail.DataObject = 'd_sched_log_detail' THEN
	w_schedule_logview.dw_viewlog.ScrollToRow(currentrow)
ELSE
	w_schedule_logview.dw_schedule_veri_log.ScrollToRow(currentrow)
END IF

end event

