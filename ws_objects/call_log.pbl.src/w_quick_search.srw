$PBExportHeader$w_quick_search.srw
forward
global type w_quick_search from window
end type
type rb_number from radiobutton within w_quick_search
end type
type rb_name from radiobutton within w_quick_search
end type
type dw_1 from datawindow within w_quick_search
end type
type cb_cancel from commandbutton within w_quick_search
end type
type cb_select from commandbutton within w_quick_search
end type
type cb_search from commandbutton within w_quick_search
end type
type sle_1 from singlelineedit within w_quick_search
end type
type gb_option from groupbox within w_quick_search
end type
end forward

global type w_quick_search from window
integer width = 2930
integer height = 1824
boolean titlebar = true
string title = "Quick Search"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
rb_number rb_number
rb_name rb_name
dw_1 dw_1
cb_cancel cb_cancel
cb_select cb_select
cb_search cb_search
sle_1 sle_1
gb_option gb_option
end type
global w_quick_search w_quick_search

type variables
string is_type
end variables

on w_quick_search.create
this.rb_number=create rb_number
this.rb_name=create rb_name
this.dw_1=create dw_1
this.cb_cancel=create cb_cancel
this.cb_select=create cb_select
this.cb_search=create cb_search
this.sle_1=create sle_1
this.gb_option=create gb_option
this.Control[]={this.rb_number,&
this.rb_name,&
this.dw_1,&
this.cb_cancel,&
this.cb_select,&
this.cb_search,&
this.sle_1,&
this.gb_option}
end on

on w_quick_search.destroy
destroy(this.rb_number)
destroy(this.rb_name)
destroy(this.dw_1)
destroy(this.cb_cancel)
destroy(this.cb_select)
destroy(this.cb_search)
destroy(this.sle_1)
destroy(this.gb_option)
end on

event open;
is_type = message.stringparm

choose case is_type
	case "PRAC"
		dw_1.dataobject = "d_call_prac_search"
		this.title = "Provider Quick Search"
		rb_number.text = "NPI Number"
	case 	'FACIL'
		dw_1.dataobject = "d_call_facility_search"
		this.title = "Facility Quick Search"
		rb_number.visible = false
		rb_name.visible = false
		gb_option.visible = false
	case "GROUP"
		dw_1.dataobject = "d_call_group_search"
		this.title = "Group Quick Search"
		rb_number.text = "Tax ID"
	case "LOC"
		dw_1.dataobject = "d_call_loc_search"
		this.title = "Location Quick Search"
		rb_number.text = "Tax ID"
	case 'PAYOR'
		dw_1.dataobject = "d_call_payor_search"
		this.title = "Payor Quick Search"
		rb_number.visible = false
		rb_name.visible = false
		gb_option.visible = false
end choose

dw_1.settransobject(sqlca)


end event

type rb_number from radiobutton within w_quick_search
integer x = 1577
integer y = 76
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Number"
end type

type rb_name from radiobutton within w_quick_search
integer x = 1266
integer y = 76
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Name"
boolean checked = true
end type

type dw_1 from datawindow within w_quick_search
integer y = 172
integer width = 2912
integer height = 1568
integer taborder = 30
string title = "none"
string dataobject = "d_call_prac_search"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;long r

r = this.getclickedrow()

if r > 0 then
	this.setrow(r)
end if
	
end event

event rowfocuschanged;
	this.selectrow(0,false)
	this.selectrow(currentrow,true)
end event

event doubleclicked;if row > 0 then cb_select.triggerevent(clicked!)
end event

type cb_cancel from commandbutton within w_quick_search
integer x = 2551
integer y = 44
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
end type

event clicked;closewithreturn(parent,"0@Cancel")
end event

type cb_select from commandbutton within w_quick_search
integer x = 2203
integer y = 44
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "S&elect"
end type

event clicked;long r
string ls_res

r = dw_1.getrow()

if r < 1 then  //Start Code Change ---11.18.2013 #V14 maha trap added
	messagebox("Select","There is no result to select")
	return
end if

ls_res = string(dw_1.getitemnumber(r,1)) + "@" + dw_1.getitemstring(r,2)

closewithreturn(parent,ls_res)
end event

type cb_search from commandbutton within w_quick_search
integer x = 850
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
string text = "&Search"
boolean default = true
end type

event clicked;string ls_val
string ls_field
string ls_sql
string ls_sql_org
integer rows
string ls_where

ls_val = sle_1.text
debugbreak()
choose case is_type
	case "PRAC"
		if rb_number.checked then
			ls_field = "npi_number"
		else
			ls_field = "last_name"
		end if
		ls_where = " AND "
	case 	'FACIL'
		ls_field = "facility_name"
		ls_where = " Where "
	case "GROUP"
		if rb_number.checked then
			ls_field = "info1"
		else
			ls_field = "gp_name"
		end if
		ls_where = " Where "
	case "LOC"
		if rb_number.checked then
			ls_field = "tax_id"
		else
			ls_field = "street"
		end if
		ls_where = " Where "
	case 'PAYOR'
		ls_field = "application_name"
		ls_where = " AND "
end choose

ls_where+=  ls_field + " like '" + ls_val + "%'"

ls_sql = dw_1.GetSQLSelect()
ls_sql_org = ls_sql

ls_sql+= ls_where

dw_1.SetSQLSelect ( ls_sql )
dw_1.SetTransObject( SQLCA )
rows = dw_1.Retrieve()

if rows < 1 then
		messagebox("Search" ,"No records found")
end if


dw_1.SetSQLSelect ( ls_sql_org )
end event

type sle_1 from singlelineedit within w_quick_search
integer x = 37
integer y = 60
integer width = 800
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

type gb_option from groupbox within w_quick_search
integer x = 1216
integer y = 20
integer width = 869
integer height = 140
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Search Option"
end type

