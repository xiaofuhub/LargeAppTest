$PBExportHeader$w_login_audit.srw
forward
global type w_login_audit from window
end type
type cb_2 from commandbutton within w_login_audit
end type
type cb_1 from commandbutton within w_login_audit
end type
type st_to from statictext within w_login_audit
end type
type st_from from statictext within w_login_audit
end type
type em_to from editmask within w_login_audit
end type
type em_from from editmask within w_login_audit
end type
type cb_close from commandbutton within w_login_audit
end type
type cb_filter from commandbutton within w_login_audit
end type
type cb_sort from commandbutton within w_login_audit
end type
type dw_1 from datawindow within w_login_audit
end type
type cb_go from commandbutton within w_login_audit
end type
type gb_1 from groupbox within w_login_audit
end type
end forward

global type w_login_audit from window
integer width = 2793
integer height = 2424
boolean titlebar = true
string title = "Login Audit"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
cb_1 cb_1
st_to st_to
st_from st_from
em_to em_to
em_from em_from
cb_close cb_close
cb_filter cb_filter
cb_sort cb_sort
dw_1 dw_1
cb_go cb_go
gb_1 gb_1
end type
global w_login_audit w_login_audit

on w_login_audit.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_to=create st_to
this.st_from=create st_from
this.em_to=create em_to
this.em_from=create em_from
this.cb_close=create cb_close
this.cb_filter=create cb_filter
this.cb_sort=create cb_sort
this.dw_1=create dw_1
this.cb_go=create cb_go
this.gb_1=create gb_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.st_to,&
this.st_from,&
this.em_to,&
this.em_from,&
this.cb_close,&
this.cb_filter,&
this.cb_sort,&
this.dw_1,&
this.cb_go,&
this.gb_1}
end on

on w_login_audit.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_to)
destroy(this.st_from)
destroy(this.em_to)
destroy(this.em_from)
destroy(this.cb_close)
destroy(this.cb_filter)
destroy(this.cb_sort)
destroy(this.dw_1)
destroy(this.cb_go)
destroy(this.gb_1)
end on

type cb_2 from commandbutton within w_login_audit
integer x = 1842
integer y = 76
integer width = 302
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Export"
end type

event clicked;gnv_dw.of_SaveAs(dw_1)//.saveas() Modify by Evan 05.11.2010
//For restore current directory  Added by Nova 04.29.2008
ChangeDirectory(gs_current_path)

end event

type cb_1 from commandbutton within w_login_audit
integer x = 2149
integer y = 76
integer width = 302
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Print"
end type

event clicked;dw_1.print()

end event

type st_to from statictext within w_login_audit
integer x = 535
integer y = 96
integer width = 87
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "To:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_from from statictext within w_login_audit
integer x = 18
integer y = 104
integer width = 146
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "From:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_to from editmask within w_login_audit
integer x = 626
integer y = 84
integer width = 343
integer height = 80
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
end type

type em_from from editmask within w_login_audit
integer x = 174
integer y = 88
integer width = 343
integer height = 80
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
end type

type cb_close from commandbutton within w_login_audit
integer x = 2455
integer y = 76
integer width = 302
integer height = 92
integer taborder = 80
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

type cb_filter from commandbutton within w_login_audit
integer x = 1230
integer y = 76
integer width = 302
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Filter"
end type

event clicked;string null_str

SetNull(null_str)

dw_1.Setfilter(null_str)

dw_1.filter( )
end event

type cb_sort from commandbutton within w_login_audit
integer x = 1536
integer y = 76
integer width = 302
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Sort"
end type

event clicked;string null_str

SetNull(null_str)

dw_1.SetSort(null_str)

dw_1.Sort( )
end event

type dw_1 from datawindow within w_login_audit
integer x = 14
integer y = 208
integer width = 2747
integer height = 2136
integer taborder = 90
string title = "none"
string dataobject = "d_login_audit"
boolean vscrollbar = true
boolean livescroll = true
end type

type cb_go from commandbutton within w_login_audit
integer x = 1010
integer y = 76
integer width = 178
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Go"
end type

event clicked;datetime ld_from
datetime ld_to
date ld_Date
date ld_Null

//debugbreak()
 //Start Code Change ---- ~04.28.2007 #V7 maha //corrected for sql server lack og date functions
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2007.08.23 By: Jack
//$<reason> Fix a defect.
/*
ld_from = datetime("2000-01-01 00:00:00")
ld_to = datetime("2099-01-01 59.59.59") //Start Code Change ---- 06.28.2007 #V7 maha corrected time
*/
ld_from = datetime(date('2000-01-01'),time('00:00:00'))
ld_to = datetime(date('2099-01-01'),time('59:59:59'))
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2008.03.17 By: Evan
//$<reason> Fix a defect.
/*
if len(em_from.text) > 4 then ld_from = datetime(date(em_from.text), time("00:00:00") )
if len(em_to.text) > 4 then ld_to = datetime(date(em_to.text), time("59:59:59") ) //Start Code Change ---- 06.28.2007 #V7 maha
//End Code Change---04.28.2007
*/
ld_Null = 1900-01-01
em_from.GetData(ld_Date)
if ld_Date <> ld_Null then ld_from = datetime(ld_Date, 00:00:00)
em_to.GetData(ld_Date)
if ld_Date <> ld_Null then ld_to = datetime(ld_Date, 23:59:59)
//---------------------------- APPEON END ----------------------------

dw_1.settransobject(sqlca)
dw_1.retrieve(ld_from,ld_to)

end event

type gb_1 from groupbox within w_login_audit
integer x = 9
integer y = 28
integer width = 1207
integer height = 164
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Date Range (optional)"
end type

