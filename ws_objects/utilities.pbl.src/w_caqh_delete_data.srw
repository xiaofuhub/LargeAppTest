$PBExportHeader$w_caqh_delete_data.srw
forward
global type w_caqh_delete_data from window
end type
type st_3 from statictext within w_caqh_delete_data
end type
type st_2 from statictext within w_caqh_delete_data
end type
type st_1 from statictext within w_caqh_delete_data
end type
type cb_3 from commandbutton within w_caqh_delete_data
end type
type cb_table from commandbutton within w_caqh_delete_data
end type
type cb_all from commandbutton within w_caqh_delete_data
end type
end forward

global type w_caqh_delete_data from window
integer width = 2857
integer height = 720
boolean titlebar = true
string title = "Delete CAQH data"
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
st_3 st_3
st_2 st_2
st_1 st_1
cb_3 cb_3
cb_table cb_table
cb_all cb_all
end type
global w_caqh_delete_data w_caqh_delete_data

type variables
string is_type
string is_table
end variables

on w_caqh_delete_data.create
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.cb_3=create cb_3
this.cb_table=create cb_table
this.cb_all=create cb_all
this.Control[]={this.st_3,&
this.st_2,&
this.st_1,&
this.cb_3,&
this.cb_table,&
this.cb_all}
end on

on w_caqh_delete_data.destroy
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_3)
destroy(this.cb_table)
destroy(this.cb_all)
end on

event open;string s

s = message.stringparm

is_type = MidA(s,1,1)
is_table = MidA(s,3)
if LenA(is_table) < 1 then
	cb_table.enabled = false
end if
	

choose case is_type
	case "C"
		is_type = "Code"
	case "A"
		is_type = "Address"
end choose

st_2.text = "You can choose reset data for all " + is_type + " lookups, or just for the " + is_table + " lookup table."
end event

type st_3 from statictext within w_caqh_delete_data
integer x = 69
integer y = 180
integer width = 2734
integer height = 168
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "This will remove CAQH codes from lookups, and will delete the CAQH import data."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_caqh_delete_data
integer x = 69
integer y = 64
integer width = 2734
integer height = 104
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "This will remove CAQH codes from lookups, and will delete the CAQH import data."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_caqh_delete_data
integer x = 69
integer y = 64
integer width = 2734
integer height = 104
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "This will remove CAQH codes from lookups, and will delete the CAQH import data."
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_caqh_delete_data
integer x = 2455
integer y = 508
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;closewithreturn(parent,"C")
end event

type cb_table from commandbutton within w_caqh_delete_data
integer x = 2071
integer y = 508
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Table Only"
end type

event clicked;closewithreturn(parent,"T")
end event

type cb_all from commandbutton within w_caqh_delete_data
integer x = 1691
integer y = 508
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "All"
end type

event clicked;closewithreturn(parent,"A")
end event

