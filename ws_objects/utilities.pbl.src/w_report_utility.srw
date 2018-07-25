$PBExportHeader$w_report_utility.srw
forward
global type w_report_utility from window
end type
type dw_wizall from datawindow within w_report_utility
end type
type cbx_standard from checkbox within w_report_utility
end type
type cb_sort from commandbutton within w_report_utility
end type
type cb_save from commandbutton within w_report_utility
end type
type cb_addwiz from commandbutton within w_report_utility
end type
type cb_add from commandbutton within w_report_utility
end type
type cb_delwiz from commandbutton within w_report_utility
end type
type cb_copy from commandbutton within w_report_utility
end type
type cb_filter from commandbutton within w_report_utility
end type
type cb_export from commandbutton within w_report_utility
end type
type cb_close from commandbutton within w_report_utility
end type
type dw_wiz from datawindow within w_report_utility
end type
type dw_report from datawindow within w_report_utility
end type
end forward

global type w_report_utility from window
integer width = 3666
integer height = 2508
boolean titlebar = true
string title = "Report data utility"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
dw_wizall dw_wizall
cbx_standard cbx_standard
cb_sort cb_sort
cb_save cb_save
cb_addwiz cb_addwiz
cb_add cb_add
cb_delwiz cb_delwiz
cb_copy cb_copy
cb_filter cb_filter
cb_export cb_export
cb_close cb_close
dw_wiz dw_wiz
dw_report dw_report
end type
global w_report_utility w_report_utility

type variables
integer ii_report
end variables

on w_report_utility.create
this.dw_wizall=create dw_wizall
this.cbx_standard=create cbx_standard
this.cb_sort=create cb_sort
this.cb_save=create cb_save
this.cb_addwiz=create cb_addwiz
this.cb_add=create cb_add
this.cb_delwiz=create cb_delwiz
this.cb_copy=create cb_copy
this.cb_filter=create cb_filter
this.cb_export=create cb_export
this.cb_close=create cb_close
this.dw_wiz=create dw_wiz
this.dw_report=create dw_report
this.Control[]={this.dw_wizall,&
this.cbx_standard,&
this.cb_sort,&
this.cb_save,&
this.cb_addwiz,&
this.cb_add,&
this.cb_delwiz,&
this.cb_copy,&
this.cb_filter,&
this.cb_export,&
this.cb_close,&
this.dw_wiz,&
this.dw_report}
end on

on w_report_utility.destroy
destroy(this.dw_wizall)
destroy(this.cbx_standard)
destroy(this.cb_sort)
destroy(this.cb_save)
destroy(this.cb_addwiz)
destroy(this.cb_add)
destroy(this.cb_delwiz)
destroy(this.cb_copy)
destroy(this.cb_filter)
destroy(this.cb_export)
destroy(this.cb_close)
destroy(this.dw_wiz)
destroy(this.dw_report)
end on

event open;dw_report.settransobject(sqlca)
dw_wiz.settransobject(sqlca)

dw_report.retrieve()





end event

type dw_wizall from datawindow within w_report_utility
boolean visible = false
integer x = 14
integer y = 12
integer width = 233
integer height = 128
integer taborder = 30
string title = "none"
string dataobject = "d_report_wiz_import"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type cbx_standard from checkbox within w_report_utility
integer x = 2912
integer y = 56
integer width = 352
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "< 1000 only"
boolean lefttext = true
end type

event clicked;string s

if this.checked then
	s = "report_id < 1000"
else
	s = ''
end if

dw_report.SetFilter(s)
dw_report.Filter()
end event

type cb_sort from commandbutton within w_report_utility
integer x = 2002
integer y = 48
integer width = 274
integer height = 76
integer taborder = 20
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
dw_report.Setsort(null_str)
dw_report.sort()
end event

type cb_save from commandbutton within w_report_utility
integer x = 1687
integer y = 48
integer width = 274
integer height = 76
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save "
end type

event clicked;dw_report.update()
dw_wiz.update()
end event

type cb_addwiz from commandbutton within w_report_utility
integer x = 617
integer y = 48
integer width = 274
integer height = 76
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add Wiz"
end type

event clicked;integer r


r = dw_wiz.insertrow(0)
dw_wiz.setitem(r,"report_id",ii_report)
dw_wiz.setitem(r,"wizard_seq_no",r)
end event

type cb_add from commandbutton within w_report_utility
integer x = 283
integer y = 48
integer width = 293
integer height = 76
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add Report"
end type

event clicked;integer li_rep


select max(report_id) into :li_rep from  sys_reports where report_id < 1000;

li_rep++
ii_report = li_rep
dw_report.insertrow(1)
dw_report.scrolltorow(1)
dw_report.setitem(1,"report_id",ii_report)
end event

type cb_delwiz from commandbutton within w_report_utility
integer x = 901
integer y = 48
integer width = 283
integer height = 76
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete Wiz"
end type

event clicked;integer res

res = messagebox("Delete Wizard","Are you sure",question!,yesno!,2)

if res = 2 then return

dw_wiz.deleterow(0)
end event

type cb_copy from commandbutton within w_report_utility
integer x = 1339
integer y = 48
integer width = 274
integer height = 76
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Copy Wiz"
end type

event clicked;integer li_rep
integer i
integer ic


open (w_report_wiz_copy_select)

if message.stringparm = "Cancel" then return

li_rep = message.doubleparm 
if li_rep = 0 then return

ic = dw_wiz.rowcount()

for i = 1 to ic
	dw_wiz.rowscopy( i, i, primary!, dw_wiz,1000, primary!)
	dw_wiz.setitem( dw_wiz.rowcount(), "report_id", li_rep)
	dw_wiz.setitem( dw_wiz.rowcount(), "wizard_seq_no", i )
next

dw_wiz.update()
dw_wiz.retrieve(ii_report)



end event

type cb_filter from commandbutton within w_report_utility
integer x = 2286
integer y = 48
integer width = 274
integer height = 76
integer taborder = 20
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
dw_report.SetFilter(null_str)
dw_report.Filter()
end event

type cb_export from commandbutton within w_report_utility
integer x = 2619
integer y = 48
integer width = 274
integer height = 76
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Export"
end type

event clicked;gnv_dw.of_SaveAs(dw_report,"",text!,false)//.SaveAs("", text!, FALSE) Modify by Evan 05.11.2010

dw_wizall.retrieve()

if cbx_standard.checked then
	dw_wizall.setfilter("report_id < 1000")
	dw_wizall.filter()
END IF

gnv_dw.of_SaveAs(dw_wizall,"",text!,false)//.SaveAs("", text!, FALSE) Modify by Evan 05.11.2010
end event

type cb_close from commandbutton within w_report_utility
integer x = 3278
integer y = 48
integer width = 274
integer height = 76
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

type dw_wiz from datawindow within w_report_utility
integer x = 18
integer y = 1628
integer width = 3579
integer height = 744
integer taborder = 20
string title = "none"
string dataobject = "d_report_wiz_4_report"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_report from datawindow within w_report_utility
integer x = 14
integer y = 160
integer width = 3575
integer height = 1444
integer taborder = 10
string title = "none"
string dataobject = "d_report_import"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;integer r

r = this.getclickedrow()
end event

event itemfocuschanged;integer li_report

this.setrow(row )
this.selectrow(0,false)
this.selectrow(row, true)

ii_report = this.getitemnumber(row,"report_id")
dw_wiz.retrieve(ii_report)


end event

