$PBExportHeader$w_print_report_cur.srw
forward
global type w_print_report_cur from window
end type
type cb_c from commandbutton within w_print_report_cur
end type
type dw_1 from datawindow within w_print_report_cur
end type
type cb_print from commandbutton within w_print_report_cur
end type
end forward

global type w_print_report_cur from window
integer width = 3561
integer height = 2088
boolean titlebar = true
string title = "Print Report"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_c cb_c
dw_1 dw_1
cb_print cb_print
end type
global w_print_report_cur w_print_report_cur

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

on w_print_report_cur.create
this.cb_c=create cb_c
this.dw_1=create dw_1
this.cb_print=create cb_print
this.Control[]={this.cb_c,&
this.dw_1,&
this.cb_print}
end on

on w_print_report_cur.destroy
destroy(this.cb_c)
destroy(this.dw_1)
destroy(this.cb_print)
end on

event open;//////////////////////////////////////////////////////////////////////
// $<event> OPEN
// $<arguments>
// $<returns> long
// $<description> N/A (V11.3 Committee Proc Upd)
//////////////////////////////////////////////////////////////////////
// $<add> 07.05.2011 by Stephen
//////////////////////////////////////////////////////////////////////

str_report_cur  lstr_report
datastore lds_print
datawindow ldw_print
blob    lb_dw

lstr_report = message.powerobjectparm
lds_print = create datastore

if lstr_report.s_type = 'datawindow' then
	ldw_print = lstr_report.dw_rep
	if ldw_print.rowcount() < 1 then
		close(this)
		return
	end if
else
	lds_print = lstr_report.ds_rep
	if lds_print.rowcount() < 1 then
		close(this)
		return
	end if
end if

dw_1.dataobject = lstr_report.s_name
dw_1.settransobject(sqlca)

if lstr_report.s_type = 'datawindow' then
	ldw_print.rowscopy(1, ldw_print.rowcount(), primary!, dw_1, 1, primary!)
	wf_set_dddw(dw_1, ldw_print)
else
	lds_print.rowscopy(1, lds_print.rowcount(), primary!, dw_1, 1, primary!)
	wf_set_ddds(dw_1, lds_print)
end if

end event

type cb_c from commandbutton within w_print_report_cur
integer x = 3113
integer y = 1884
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

type dw_1 from datawindow within w_print_report_cur
integer y = 4
integer width = 3543
integer height = 1840
integer taborder = 10
string title = "none"
string dataobject = "d_rpt_red_flag"
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
end type

type cb_print from commandbutton within w_print_report_cur
integer x = 2752
integer y = 1888
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

dw_1.print()
end event

