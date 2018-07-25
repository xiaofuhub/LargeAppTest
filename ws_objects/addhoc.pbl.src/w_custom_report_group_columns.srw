$PBExportHeader$w_custom_report_group_columns.srw
forward
global type w_custom_report_group_columns from window
end type
type cb_3 from commandbutton within w_custom_report_group_columns
end type
type cb_4 from commandbutton within w_custom_report_group_columns
end type
type cb_2 from commandbutton within w_custom_report_group_columns
end type
type cb_1 from commandbutton within w_custom_report_group_columns
end type
type lb_columns from listbox within w_custom_report_group_columns
end type
type st_2 from statictext within w_custom_report_group_columns
end type
type st_1 from statictext within w_custom_report_group_columns
end type
type lb_sourcedata from listbox within w_custom_report_group_columns
end type
type cb_cancel from commandbutton within w_custom_report_group_columns
end type
type cb_ok from commandbutton within w_custom_report_group_columns
end type
end forward

global type w_custom_report_group_columns from window
integer width = 1824
integer height = 1376
boolean titlebar = true
string title = "Specify Group Columns"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_3 cb_3
cb_4 cb_4
cb_2 cb_2
cb_1 cb_1
lb_columns lb_columns
st_2 st_2
st_1 st_1
lb_sourcedata lb_sourcedata
cb_cancel cb_cancel
cb_ok cb_ok
end type
global w_custom_report_group_columns w_custom_report_group_columns

type variables
DataWindow idw_Syntax
string is_Return = "Cancel!"
end variables

forward prototypes
public function integer of_getsourcedata ()
public function integer of_getcolumns (integer ai_group)
end prototypes

public function integer of_getsourcedata ();//////////////////////////////////////////////////////////////////////
// $<function> of_getsourcedata
// $<arguments>
// $<returns> integer
// $<description> V10.5-Advanced Report
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 09.21.2010
//////////////////////////////////////////////////////////////////////

string ls_ColName
string ls_Columns
string ls_Column[]
Integer i, li_ColCount

li_ColCount = w_custom_report.of_GetGroupColumns(idw_Syntax, 1, ls_Column)
for i = 1 to li_ColCount
	ls_Columns += ls_Column[i] + ","
next
li_ColCount = w_custom_report.of_GetGroupColumns(idw_Syntax, 2, ls_Column)
for i = 1 to li_ColCount
	ls_Columns += ls_Column[i] + ","
next
li_ColCount = w_custom_report.of_GetGroupColumns(idw_Syntax, 3, ls_Column)
for i = 1 to li_ColCount
	ls_Columns += ls_Column[i] + ","
next

lb_sourcedata.Reset()
li_ColCount = Integer(idw_Syntax.Describe("datawindow.column.count"))
for i = 1 to li_ColCount
	ls_ColName = idw_Syntax.Describe("#" + String(i) + ".name")
	if Pos(ls_Columns, ls_ColName) > 0 then
	else
		lb_sourcedata.AddItem(ls_ColName)
	end if
next

Return 1
end function

public function integer of_getcolumns (integer ai_group);//////////////////////////////////////////////////////////////////////
// $<function> of_getcolumns
// $<arguments>
//			integer	ai_group
// $<returns> integer
// $<description> V10.5-Advanced Report
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 09.21.2010
//////////////////////////////////////////////////////////////////////

string ls_Column[]
Integer i, li_ColCount

lb_columns.Reset()
li_ColCount = w_custom_report.of_GetGroupColumns(idw_Syntax, ai_Group, ls_Column)

for i = 1 to li_ColCount
	lb_columns.AddItem(ls_Column[i])
next

Return li_ColCount
end function

on w_custom_report_group_columns.create
this.cb_3=create cb_3
this.cb_4=create cb_4
this.cb_2=create cb_2
this.cb_1=create cb_1
this.lb_columns=create lb_columns
this.st_2=create st_2
this.st_1=create st_1
this.lb_sourcedata=create lb_sourcedata
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.Control[]={this.cb_3,&
this.cb_4,&
this.cb_2,&
this.cb_1,&
this.lb_columns,&
this.st_2,&
this.st_1,&
this.lb_sourcedata,&
this.cb_cancel,&
this.cb_ok}
end on

on w_custom_report_group_columns.destroy
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.lb_columns)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.lb_sourcedata)
destroy(this.cb_cancel)
destroy(this.cb_ok)
end on

event open;//////////////////////////////////////////////////////////////////////
// $<event> open
// $<arguments>
// $<returns> integer
// $<description> V10.5-Advanced Report
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 09.21.2010
//////////////////////////////////////////////////////////////////////

integer li_Group

idw_Syntax = Message.PowerObjectParm
li_Group = Integer(idw_Syntax.Tag)

of_GetSourceData()
of_GetColumns(li_Group)
end event

event close;CloseWithReturn(this, is_Return)
end event

type cb_3 from commandbutton within w_custom_report_group_columns
integer x = 827
integer y = 640
integer width = 114
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = ">>|"
end type

event clicked;string ls_Item
integer i, li_Count

cb_4.Event Clicked()

li_Count = lb_sourcedata.TotalItems()
for i = 1 to li_Count
	ls_Item = lb_sourcedata.Text(i)
	lb_columns.AddItem(ls_Item)
next

if lb_columns.TotalItems() > 0 then
	cb_ok.Enabled = true
end if
end event

type cb_4 from commandbutton within w_custom_report_group_columns
integer x = 827
integer y = 752
integer width = 114
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "|<<"
end type

event clicked;integer i, li_Count

li_Count = lb_columns.TotalItems()
for i = 1 to li_Count
	lb_columns.DeleteItem(1)
next

cb_ok.Enabled = false
end event

type cb_2 from commandbutton within w_custom_report_group_columns
integer x = 827
integer y = 476
integer width = 114
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "<<"
end type

event clicked;integer li_Index

li_Index = lb_columns.SelectedIndex()
lb_columns.DeleteItem(li_Index)

if lb_columns.TotalItems() < 1 then
	cb_ok.Enabled = false
end if
end event

type cb_1 from commandbutton within w_custom_report_group_columns
integer x = 827
integer y = 364
integer width = 114
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = ">>"
end type

event clicked;string ls_Item

ls_Item = lb_sourcedata.SelectedItem()
if Len(ls_Item) > 0 then
	if lb_columns.FindItem(ls_Item, 0) > 0 then
	else
		lb_columns.AddItem(ls_Item)
	end if
end if

if lb_columns.TotalItems() > 0 then
	cb_ok.Enabled = true
end if
end event

type lb_columns from listbox within w_custom_report_group_columns
integer x = 974
integer y = 124
integer width = 773
integer height = 1000
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
boolean sorted = false
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;cb_2.Event Clicked()
end event

type st_2 from statictext within w_custom_report_group_columns
integer x = 983
integer y = 52
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Columns"
boolean focusrectangle = false
end type

type st_1 from statictext within w_custom_report_group_columns
integer x = 37
integer y = 52
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Source Data"
boolean focusrectangle = false
end type

type lb_sourcedata from listbox within w_custom_report_group_columns
integer x = 32
integer y = 124
integer width = 773
integer height = 1000
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
boolean sorted = false
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;cb_1.Event Clicked()
end event

type cb_cancel from commandbutton within w_custom_report_group_columns
integer x = 1399
integer y = 1152
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
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type cb_ok from commandbutton within w_custom_report_group_columns
integer x = 1038
integer y = 1152
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "&OK"
boolean default = true
end type

event clicked;integer i, li_Count

is_Return = ""
li_Count = lb_columns.TotalItems()

for i = 1 to li_Count
	if Len(is_Return) > 0 then is_Return += ","
	is_Return += lb_columns.Text(i)
next

Close(Parent)
end event

