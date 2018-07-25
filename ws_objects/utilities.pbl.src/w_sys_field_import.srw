$PBExportHeader$w_sys_field_import.srw
forward
global type w_sys_field_import from window
end type
type cb_8 from commandbutton within w_sys_field_import
end type
type cb_7 from commandbutton within w_sys_field_import
end type
type cb_6 from commandbutton within w_sys_field_import
end type
type cb_5 from commandbutton within w_sys_field_import
end type
type sle_field from singlelineedit within w_sys_field_import
end type
type st_2 from statictext within w_sys_field_import
end type
type cb_4 from commandbutton within w_sys_field_import
end type
type cb_2 from commandbutton within w_sys_field_import
end type
type st_1 from statictext within w_sys_field_import
end type
type sle_table from singlelineedit within w_sys_field_import
end type
type cb_10 from commandbutton within w_sys_field_import
end type
type dw_1 from datawindow within w_sys_field_import
end type
type cb_3 from commandbutton within w_sys_field_import
end type
type cb_1 from commandbutton within w_sys_field_import
end type
end forward

global type w_sys_field_import from window
integer x = 123
integer y = 112
integer width = 4494
integer height = 2476
boolean titlebar = true
string title = "Reset group ids"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
cb_8 cb_8
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
sle_field sle_field
st_2 st_2
cb_4 cb_4
cb_2 cb_2
st_1 st_1
sle_table sle_table
cb_10 cb_10
dw_1 dw_1
cb_3 cb_3
cb_1 cb_1
end type
global w_sys_field_import w_sys_field_import

type variables
long il_openfor
end variables

on w_sys_field_import.create
this.cb_8=create cb_8
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.sle_field=create sle_field
this.st_2=create st_2
this.cb_4=create cb_4
this.cb_2=create cb_2
this.st_1=create st_1
this.sle_table=create sle_table
this.cb_10=create cb_10
this.dw_1=create dw_1
this.cb_3=create cb_3
this.cb_1=create cb_1
this.Control[]={this.cb_8,&
this.cb_7,&
this.cb_6,&
this.cb_5,&
this.sle_field,&
this.st_2,&
this.cb_4,&
this.cb_2,&
this.st_1,&
this.sle_table,&
this.cb_10,&
this.dw_1,&
this.cb_3,&
this.cb_1}
end on

on w_sys_field_import.destroy
destroy(this.cb_8)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.sle_field)
destroy(this.st_2)
destroy(this.cb_4)
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.sle_table)
destroy(this.cb_10)
destroy(this.dw_1)
destroy(this.cb_3)
destroy(this.cb_1)
end on

type cb_8 from commandbutton within w_sys_field_import
integer x = 3054
integer y = 136
integer width = 466
integer height = 88
integer taborder = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Save"
end type

event clicked;dw_1.settransobject(sqlca)
dw_1.update()
end event

type cb_7 from commandbutton within w_sys_field_import
integer x = 1993
integer y = 188
integer width = 466
integer height = 88
integer taborder = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Sort"
end type

event clicked;string null_str

SetNull(null_str)

dw_1.SetSort(null_str)

dw_1.Sort( )
end event

type cb_6 from commandbutton within w_sys_field_import
integer x = 1993
integer y = 76
integer width = 466
integer height = 88
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Delete row"
end type

event clicked;long r

r = dw_1.getrow()

dw_1.deleterow(r)
end event

type cb_5 from commandbutton within w_sys_field_import
integer x = 2469
integer y = 136
integer width = 558
integer height = 84
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Export data"
end type

event clicked;//sle_1.text = "C:\intellicred\lehigh_addr_new.txt"
//sle_2.text = "dba.addr_new"

dw_1.saveas()
end event

type sle_field from singlelineedit within w_sys_field_import
integer x = 1070
integer y = 176
integer width = 402
integer height = 92
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "190000"
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_sys_field_import
integer x = 626
integer y = 180
integer width = 402
integer height = 88
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 33551856
string text = "Field id"
boolean focusrectangle = false
end type

type cb_4 from commandbutton within w_sys_field_import
integer x = 1513
integer y = 180
integer width = 402
integer height = 92
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Set"
end type

event clicked;long r
long rc
long val

val = long(sle_field.text)

for r = 1 to dw_1.rowcount( )
	dw_1.setitem(r, "field_id", val)
	val++
next	
end event

type cb_2 from commandbutton within w_sys_field_import
integer x = 1513
integer y = 72
integer width = 402
integer height = 92
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Set"
end type

event clicked;long r
long rc
integer val

val = integer(sle_table.text)

for r = 1 to dw_1.rowcount( )
	dw_1.setitem(r, "table_id", val)
next	
end event

type st_1 from statictext within w_sys_field_import
integer x = 626
integer y = 72
integer width = 402
integer height = 88
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 33551856
string text = "Table id"
boolean focusrectangle = false
end type

type sle_table from singlelineedit within w_sys_field_import
integer x = 1070
integer y = 68
integer width = 402
integer height = 92
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "86"
borderstyle borderstyle = stylelowered!
end type

type cb_10 from commandbutton within w_sys_field_import
integer x = 27
integer y = 132
integer width = 558
integer height = 84
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Import file"
end type

event clicked;//sle_1.text = "C:\intellicred\lehigh_addr_new.txt"
//sle_2.text = "dba.addr_new"

string docname, named

integer value

value = GetFileOpenName("Select File",&
+ docname, named, "DOC", &
	+ "text Files (*.txt),*.txt")

IF value = 1 THEN
	dw_1.importfile( docname)
END IF

dw_1.setsort("field_order")
dw_1.sort()
end event

type dw_1 from datawindow within w_sys_field_import
integer x = 18
integer y = 360
integer width = 4379
integer height = 1972
integer taborder = 80
string dataobject = "d_sys_field_import"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type cb_3 from commandbutton within w_sys_field_import
integer x = 4037
integer y = 60
integer width = 274
integer height = 108
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Quit"
end type

event clicked;CLOSE(PARENT)
end event

type cb_1 from commandbutton within w_sys_field_import
integer x = 3721
integer y = 72
integer width = 265
integer height = 72
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "About"
end type

event clicked;messagebox("To operate this program :","Select a record type. Click run.  You will get a list of expiring records from 30 days in the future for active records.")
end event

