$PBExportHeader$w_custom_report_summary.srw
forward
global type w_custom_report_summary from window
end type
type rb_avg from radiobutton within w_custom_report_summary
end type
type rb_sum from radiobutton within w_custom_report_summary
end type
type rb_count from radiobutton within w_custom_report_summary
end type
type ddlb_1 from dropdownlistbox within w_custom_report_summary
end type
type st_3 from statictext within w_custom_report_summary
end type
type ddlb_2 from dropdownlistbox within w_custom_report_summary
end type
type st_1 from statictext within w_custom_report_summary
end type
type cb_cancel from commandbutton within w_custom_report_summary
end type
type cb_ok from commandbutton within w_custom_report_summary
end type
type gb_1 from groupbox within w_custom_report_summary
end type
end forward

global type w_custom_report_summary from window
integer width = 1125
integer height = 1008
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
rb_avg rb_avg
rb_sum rb_sum
rb_count rb_count
ddlb_1 ddlb_1
st_3 st_3
ddlb_2 ddlb_2
st_1 st_1
cb_cancel cb_cancel
cb_ok cb_ok
gb_1 gb_1
end type
global w_custom_report_summary w_custom_report_summary

type variables
string is_ObjectName
string is_Return = "Cancel!"
u_cst_dw_band idw_band
end variables

forward prototypes
public function integer of_initaggregatetype ()
public function integer of_initcolumnlist ()
public function string of_buildexpress ()
end prototypes

public function integer of_initaggregatetype ();//////////////////////////////////////////////////////////////////////
// $<function> of_initaggregatetype
// $<arguments>
// $<returns> integer
// $<description> V10.5-Advanced Report
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.08.2010
//////////////////////////////////////////////////////////////////////

string ls_Syntax
integer li_Index

ls_Syntax = idw_band.Describe("datawindow.syntax")

if Pos(ls_Syntax, "group(level=1") > 0 then
	ddlb_2.AddItem("Group 1 Level")
end if
if Pos(ls_Syntax, "group(level=2") > 0 then
	ddlb_2.AddItem("Group 2 Level")
end if
if Pos(ls_Syntax, "group(level=3") > 0 then
	ddlb_2.AddItem("Group 3 Level")
end if
ddlb_2.AddItem("Summary Level")

choose case idw_band.is_BandType
	case "HEADER.1", "TRAILER.1"
		li_Index = 1
	case "HEADER.2", "TRAILER.2"
		li_Index = 2
	case "HEADER.3", "TRAILER.3"
		li_Index = 3
	case else
		li_Index = ddlb_2.TotalItems()
end choose
ddlb_2.SelectItem(li_Index)

Return 1
end function

public function integer of_initcolumnlist ();//////////////////////////////////////////////////////////////////////
// $<function> of_initcolumnlist
// $<arguments>
// $<returns> integer
// $<description> V10.5-Advanced Report
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.08.2010
//////////////////////////////////////////////////////////////////////

string ls_Syntax
string ls_ColName
integer i, li_ColCount

li_ColCount = Integer(idw_band.Describe("datawindow.column.count"))
for i = 1 to li_ColCount
	ls_ColName = idw_band.Describe("#" + String(i) + ".name")
	ddlb_1.AddItem(ls_ColName)
next

Return 1
end function

public function string of_buildexpress ();//////////////////////////////////////////////////////////////////////
// $<function> of_buildexpress
// $<arguments>
// $<returns> string
// $<description> V10.5-Advanced Report
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.08.2010
//////////////////////////////////////////////////////////////////////

string ls_Column
string ls_Express

ls_Column = ddlb_1.Text
choose case ddlb_2.Text
	case "Group 1 Level"
		ls_Express = ls_Column + " for group 1"
	case "Group 2 Level"
		ls_Express = ls_Column + " for group 2"
	case "Group 3 Level"
		ls_Express = ls_Column + " for group 3"
	case "Summary Level"
		ls_Express = ls_Column + " for all"
end choose

if rb_count.Checked then ls_Express = "Count(" + ls_Express + ")"
if rb_sum.Checked then ls_Express = "Sum(" + ls_Express + ")"
if rb_avg.Checked then ls_Express = "Avg(" + ls_Express + ")"

Return ls_Express
end function

on w_custom_report_summary.create
this.rb_avg=create rb_avg
this.rb_sum=create rb_sum
this.rb_count=create rb_count
this.ddlb_1=create ddlb_1
this.st_3=create st_3
this.ddlb_2=create ddlb_2
this.st_1=create st_1
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.gb_1=create gb_1
this.Control[]={this.rb_avg,&
this.rb_sum,&
this.rb_count,&
this.ddlb_1,&
this.st_3,&
this.ddlb_2,&
this.st_1,&
this.cb_cancel,&
this.cb_ok,&
this.gb_1}
end on

on w_custom_report_summary.destroy
destroy(this.rb_avg)
destroy(this.rb_sum)
destroy(this.rb_count)
destroy(this.ddlb_1)
destroy(this.st_3)
destroy(this.ddlb_2)
destroy(this.st_1)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.gb_1)
end on

event open;//////////////////////////////////////////////////////////////////////
// $<event> open
// $<arguments>
// $<returns> long
// $<description> V10.5-Advanced Report
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.08.2010
//////////////////////////////////////////////////////////////////////

str_pass lstr_pass

lstr_pass = Message.PowerObjectParm
is_ObjectName = lstr_pass.s_string_array[1]
idw_band = lstr_pass.s_u_dw

of_InitColumnList()
of_InitAggregateType()
end event

event close;if is_Return = "Cancel!" then
	SetNull(is_Return)
	CloseWithReturn(this, is_Return)
end if
end event

type rb_avg from radiobutton within w_custom_report_summary
integer x = 791
integer y = 656
integer width = 251
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 33551856
string text = "Avg."
end type

type rb_sum from radiobutton within w_custom_report_summary
integer x = 471
integer y = 656
integer width = 251
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 33551856
string text = "Sum"
boolean checked = true
end type

type rb_count from radiobutton within w_custom_report_summary
integer x = 151
integer y = 656
integer width = 251
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 33551856
string text = "Count"
end type

type ddlb_1 from dropdownlistbox within w_custom_report_summary
integer x = 32
integer y = 116
integer width = 1047
integer height = 692
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_custom_report_summary
integer x = 32
integer y = 48
integer width = 379
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 33551856
string text = "Summary Column"
boolean focusrectangle = false
end type

type ddlb_2 from dropdownlistbox within w_custom_report_summary
integer x = 32
integer y = 348
integer width = 1047
integer height = 472
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean sorted = false
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_custom_report_summary
integer x = 32
integer y = 280
integer width = 357
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 33551856
string text = "Aggregate Type"
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_custom_report_summary
integer x = 741
integer y = 868
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type cb_ok from commandbutton within w_custom_report_summary
integer x = 384
integer y = 868
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&OK"
boolean default = true
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description> V10.5-Advanced Report
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 10.09.2010
//////////////////////////////////////////////////////////////////////

string ls_Error
string ls_Modify
str_pass lstr_pass

if ddlb_1.Text = "" then
	MessageBox("Prompt", "Please select summary column.")
	ddlb_1.SetFocus()
	Return
end if

ls_Modify = is_ObjectName + '.Expression="' + of_BuildExpress() + '"'
ls_Error = idw_band.Modify(ls_Modify)
ls_Error = idw_band.iuo_Parent.Event ue_SetModify(ls_Modify)

ls_Modify = is_ObjectName + ".format='[general]' " + is_ObjectName + ".border='5'"
ls_Error = idw_band.Modify(ls_Modify)
ls_Modify = is_ObjectName + ".format='[general]' " + is_ObjectName + ".border='0'"
ls_Error = idw_band.iuo_Parent.Event ue_SetModify(ls_Modify)

is_Return = "OK!"
lstr_pass.s_string_array[1] = "Label"
CloseWithReturn(Parent, lstr_pass)
end event

type gb_1 from groupbox within w_custom_report_summary
integer x = 32
integer y = 520
integer width = 1047
integer height = 300
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 33551856
string text = "Summary Type"
end type

