$PBExportHeader$w_report_child_filter_test.srw
forward
global type w_report_child_filter_test from window
end type
type cb_2 from commandbutton within w_report_child_filter_test
end type
type cb_1 from commandbutton within w_report_child_filter_test
end type
type st_1 from statictext within w_report_child_filter_test
end type
type sle_filt from singlelineedit within w_report_child_filter_test
end type
type dw_1 from datawindow within w_report_child_filter_test
end type
end forward

global type w_report_child_filter_test from window
integer width = 3959
integer height = 1924
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
cb_1 cb_1
st_1 st_1
sle_filt sle_filt
dw_1 dw_1
end type
global w_report_child_filter_test w_report_child_filter_test

on w_report_child_filter_test.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_1=create st_1
this.sle_filt=create sle_filt
this.dw_1=create dw_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.st_1,&
this.sle_filt,&
this.dw_1}
end on

on w_report_child_filter_test.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.sle_filt)
destroy(this.dw_1)
end on

type cb_2 from commandbutton within w_report_child_filter_test
integer x = 2679
integer y = 64
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Filter"
end type

event clicked;string f
integer r
datawindowchild dwchild

f = sle_filt.text

r = dw_1.getchild("rpt1",dwchild)
r = dwchild.setfilter(f)
dwchild.filter()

r = dw_1.getchild("rpt2",dwchild)
r = dwchild.setfilter(f)
dwchild.filter()

end event

type cb_1 from commandbutton within w_report_child_filter_test
integer x = 82
integer y = 60
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Get Data"
end type

event clicked;dw_1.settransobject(sqlca)
dw_1.retrieve()
end event

type st_1 from statictext within w_report_child_filter_test
integer x = 1317
integer y = 72
integer width = 178
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Filter:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_filt from singlelineedit within w_report_child_filter_test
integer x = 1509
integer y = 56
integer width = 1106
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type dw_1 from datawindow within w_report_child_filter_test
integer x = 27
integer y = 180
integer width = 3803
integer height = 1596
integer taborder = 10
string title = "none"
string dataobject = "d_prftest_composite"
boolean livescroll = true
end type

