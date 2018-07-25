$PBExportHeader$w_iapp_find_row.srw
forward
global type w_iapp_find_row from window
end type
type rb_all from radiobutton within w_iapp_find_row
end type
type rb_null from radiobutton within w_iapp_find_row
end type
type cb_4 from commandbutton within w_iapp_find_row
end type
type cb_3 from commandbutton within w_iapp_find_row
end type
type cb_2 from commandbutton within w_iapp_find_row
end type
type cb_1 from commandbutton within w_iapp_find_row
end type
type dw_1 from datawindow within w_iapp_find_row
end type
type gb_1 from groupbox within w_iapp_find_row
end type
end forward

global type w_iapp_find_row from window
integer x = 110
integer y = 100
integer width = 3474
integer height = 1812
boolean titlebar = true
string title = "Find Damaged Rows"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
rb_all rb_all
rb_null rb_null
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
gb_1 gb_1
end type
global w_iapp_find_row w_iapp_find_row

on w_iapp_find_row.create
this.rb_all=create rb_all
this.rb_null=create rb_null
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={this.rb_all,&
this.rb_null,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1,&
this.gb_1}
end on

on w_iapp_find_row.destroy
destroy(this.rb_all)
destroy(this.rb_null)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.gb_1)
end on

type rb_all from radiobutton within w_iapp_find_row
integer x = 133
integer y = 1532
integer width = 247
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "All"
end type

event clicked;dw_1.dataobject = "d_iapp_fld_prop_all"

dw_1.settransobject(sqlca)
dw_1.retrieve()
end event

type rb_null from radiobutton within w_iapp_find_row
integer x = 421
integer y = 1536
integer width = 247
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Nulls"
boolean checked = true
end type

event clicked;dw_1.dataobject = "d_iapp_nulls"

dw_1.settransobject(sqlca)
dw_1.retrieve()
end event

type cb_4 from commandbutton within w_iapp_find_row
integer x = 3122
integer y = 1508
integer width = 283
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Quit"
end type

event clicked;close(parent)
end event

type cb_3 from commandbutton within w_iapp_find_row
integer x = 2816
integer y = 1508
integer width = 283
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

event clicked;String ls_filter

SetNull( ls_filter )

dw_1.Setsort( ls_filter )
dw_1.sort()
end event

type cb_2 from commandbutton within w_iapp_find_row
integer x = 2505
integer y = 1508
integer width = 283
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Filter"
end type

event clicked;
String ls_filter

SetNull( ls_filter )

dw_1.SetFilter( ls_filter )
dw_1.Filter()
end event

type cb_1 from commandbutton within w_iapp_find_row
integer x = 2162
integer y = 1512
integer width = 315
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete row"
end type

event clicked;integer resp



resp = messagebox("Delete","Are you sure you want to delete the selected row?",question!,yesno!,2)

if resp = 1 then
	dw_1.deleterow(0)
end if

dw_1.update()
commit using sqlca;
end event

type dw_1 from datawindow within w_iapp_find_row
integer x = 55
integer y = 48
integer width = 3337
integer height = 1424
integer taborder = 10
string dataobject = "d_iapp_nulls"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event constructor;this.settransobject( sqlca )
this.retrieve()
end event

type gb_1 from groupbox within w_iapp_find_row
integer x = 87
integer y = 1476
integer width = 649
integer height = 156
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Show"
end type

