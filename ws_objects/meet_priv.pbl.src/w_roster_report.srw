$PBExportHeader$w_roster_report.srw
forward
global type w_roster_report from window
end type
type rb_3 from radiobutton within w_roster_report
end type
type rb_2 from radiobutton within w_roster_report
end type
type rb_r1 from radiobutton within w_roster_report
end type
type gb_1 from groupbox within w_roster_report
end type
type cb_c from commandbutton within w_roster_report
end type
type cb_print from commandbutton within w_roster_report
end type
type dw_roster from datawindow within w_roster_report
end type
end forward

global type w_roster_report from window
integer width = 3561
integer height = 2276
boolean titlebar = true
string title = "Print Report"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
rb_3 rb_3
rb_2 rb_2
rb_r1 rb_r1
gb_1 gb_1
cb_c cb_c
cb_print cb_print
dw_roster dw_roster
end type
global w_roster_report w_roster_report

type variables
long il_meeting
end variables

forward prototypes
public function integer wf_set_ddds (datawindow adw_report, datastore ads_sur)
public function integer wf_set_dddw (datawindow adw_report, datawindow ads_sur)
end prototypes

public function integer wf_set_ddds (datawindow adw_report, datastore ads_sur);//////////////////////////////////////////////////////////////////////
// $<function> wf_set_dddw
// $<arguments>
// $<returns> integer
// $<description> N/A (V11.3 Committee Proc Upd)
//////////////////////////////////////////////////////////////////////
// $<add> 07.07.2011 by Stephen
//////////////////////////////////////////////////////////////////////

datawindowchild ldwc_list , ldwc_report
string ls_colnam
long   ll_col

for ll_col = 1 to integer(ads_sur.object.datawindow.column.count)
	if ads_sur.describe("#"+string(ll_col)+".edit.style")='dddw' then
		ls_colnam = ads_sur.describe("#"+string(ll_col)+".name")
		ads_sur.getchild(ls_colnam, ldwc_list)
		adw_report.getchild(ls_colnam, ldwc_report)
		ldwc_list.rowscopy(1,ldwc_list.rowcount(),primary!, ldwc_report,1,primary!)
	end if
next

return 1
end function

public function integer wf_set_dddw (datawindow adw_report, datawindow ads_sur);//////////////////////////////////////////////////////////////////////
// $<function> wf_set_dddw
// $<arguments>
// $<returns> integer
// $<description> N/A (V11.3 Committee Proc Upd)
//////////////////////////////////////////////////////////////////////
// $<add> 07.07.2011 by Stephen
//////////////////////////////////////////////////////////////////////

datawindowchild ldwc_list , ldwc_report
string ls_colnam
long   ll_col

for ll_col = 1 to integer(ads_sur.object.datawindow.column.count)
	if ads_sur.describe("#"+string(ll_col)+".edit.style")='dddw' then
		ls_colnam = ads_sur.describe("#"+string(ll_col)+".name")
		ads_sur.getchild(ls_colnam, ldwc_list)
		adw_report.getchild(ls_colnam, ldwc_report)
		ldwc_list.rowscopy(1,ldwc_list.rowcount(),primary!, ldwc_report,1,primary!)
	end if
next

return 1
end function

on w_roster_report.create
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_r1=create rb_r1
this.gb_1=create gb_1
this.cb_c=create cb_c
this.cb_print=create cb_print
this.dw_roster=create dw_roster
this.Control[]={this.rb_3,&
this.rb_2,&
this.rb_r1,&
this.gb_1,&
this.cb_c,&
this.cb_print,&
this.dw_roster}
end on

on w_roster_report.destroy
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_r1)
destroy(this.gb_1)
destroy(this.cb_c)
destroy(this.cb_print)
destroy(this.dw_roster)
end on

event open;
il_meeting = message.doubleparm

dw_roster.settransobject(sqlca)
dw_roster.retrieve(il_meeting)



end event

type rb_3 from radiobutton within w_roster_report
integer x = 1006
integer y = 68
integer width = 594
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Attendance Report"
end type

event clicked;dw_roster.dataobject = "d_rpt_meeting_roster_attend"
dw_roster.settransobject(sqlca)
dw_roster.retrieve(il_meeting)
end event

type rb_2 from radiobutton within w_roster_report
integer x = 585
integer y = 68
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Roster 2"
end type

event clicked;dw_roster.dataobject = "d_rpt_meeting_roster_inova"
dw_roster.settransobject(sqlca)
dw_roster.retrieve(il_meeting)
end event

type rb_r1 from radiobutton within w_roster_report
integer x = 146
integer y = 68
integer width = 357
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Roster 1"
end type

event clicked;dw_roster.dataobject = "d_rpt_meeting_roster"
dw_roster.settransobject(sqlca)
dw_roster.retrieve(il_meeting)

end event

type gb_1 from groupbox within w_roster_report
integer x = 32
integer y = 8
integer width = 1618
integer height = 148
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Select"
end type

type cb_c from commandbutton within w_roster_report
integer x = 3131
integer y = 48
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
boolean cancel = true
end type

event clicked;close(parent)
end event

type cb_print from commandbutton within w_roster_report
integer x = 2757
integer y = 52
integer width = 343
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Print"
end type

event clicked;integer res

//Start Code Change ----07.27.2011 #V11 maha - SCAN health
//if of_get_app_setting("set_66","I") = 1 then
if gi_print_dialog = 1 then  //Start Code Change ----12.03.2013 #V14 maha
	res = PrintSetup()
	if res = -1 then return
end if
//End Code Change ----07.27.2011

dw_roster.print()
end event

type dw_roster from datawindow within w_roster_report
integer x = 46
integer y = 176
integer width = 3461
integer height = 1980
integer taborder = 10
string title = "none"
string dataobject = "d_rpt_meeting_roster"
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

