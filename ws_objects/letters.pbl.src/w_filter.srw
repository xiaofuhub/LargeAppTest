$PBExportHeader$w_filter.srw
$PBExportComments$Filter -- Bug23842
forward
global type w_filter from window
end type
type em_1 from editmask within w_filter
end type
type cb_3 from commandbutton within w_filter
end type
type cb_2 from commandbutton within w_filter
end type
type cb_1 from commandbutton within w_filter
end type
type dw_1 from datawindow within w_filter
end type
end forward

global type w_filter from window
integer width = 2533
integer height = 1408
boolean titlebar = true
string title = "Filter -- Bug23842"
boolean controlmenu = true
boolean minbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
em_1 em_1
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_filter w_filter

on w_filter.create
this.em_1=create em_1
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.em_1,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_filter.destroy
destroy(this.em_1)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;dw_1.SetTransObject(Sqlca)
end event

type em_1 from editmask within w_filter
integer x = 649
integer y = 1188
integer width = 238
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "1"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "#"
boolean autoskip = true
boolean spin = true
string minmax = "1~~9"
end type

type cb_3 from commandbutton within w_filter
integer x = 2066
integer y = 1188
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "E&xit"
end type

event clicked;Close(Parent)
end event

type cb_2 from commandbutton within w_filter
integer x = 142
integer y = 1188
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Retrieve"
end type

event clicked;dw_1.Retrieve()
end event

type cb_1 from commandbutton within w_filter
integer x = 896
integer y = 1188
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Filter"
end type

event clicked;string ls_filter

ls_filter = "LETTER_MODULE = "+ em_1.text 
dw_1.setfilter( ls_filter)
dw_1.filter()
end event

type dw_1 from datawindow within w_filter
integer x = 55
integer y = 24
integer width = 2395
integer height = 1136
integer taborder = 10
string title = "none"
string dataobject = "d_letter_painter_browse"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event itemchanged;MessageBox(this.ClassName(), "ItemChanged!")
end event

event rowfocuschanged;//MessageBox(this.ClassName(), "RowFocusChanged!")
end event

event clicked;Long ll_row
ll_row = this.GetClickedRow()
Parent.Title = "Filter -- Bug23842: " + String(ll_row)

cb_1.Event Clicked()

ll_row = this.GetClickedRow()
Parent.Title += "/" + String(ll_row) + "-Row: " + String(Row)

This.SelectRow(0, FALSE)
This.SelectRow(ll_row, TRUE)
end event

