$PBExportHeader$w_app_map_address_field_select.srw
forward
global type w_app_map_address_field_select from window
end type
type cb_2 from commandbutton within w_app_map_address_field_select
end type
type cb_1 from commandbutton within w_app_map_address_field_select
end type
type st_1 from statictext within w_app_map_address_field_select
end type
type cbx_11 from checkbox within w_app_map_address_field_select
end type
type cbx_10 from checkbox within w_app_map_address_field_select
end type
type cbx_9 from checkbox within w_app_map_address_field_select
end type
type cbx_8 from checkbox within w_app_map_address_field_select
end type
type cbx_7 from checkbox within w_app_map_address_field_select
end type
type cbx_6 from checkbox within w_app_map_address_field_select
end type
type cbx_5 from checkbox within w_app_map_address_field_select
end type
type cbx_4 from checkbox within w_app_map_address_field_select
end type
type cbx_3 from checkbox within w_app_map_address_field_select
end type
type cbx_2 from checkbox within w_app_map_address_field_select
end type
type cbx_1 from checkbox within w_app_map_address_field_select
end type
end forward

global type w_app_map_address_field_select from window
integer width = 1102
integer height = 1316
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
cb_1 cb_1
st_1 st_1
cbx_11 cbx_11
cbx_10 cbx_10
cbx_9 cbx_9
cbx_8 cbx_8
cbx_7 cbx_7
cbx_6 cbx_6
cbx_5 cbx_5
cbx_4 cbx_4
cbx_3 cbx_3
cbx_2 cbx_2
cbx_1 cbx_1
end type
global w_app_map_address_field_select w_app_map_address_field_select

on w_app_map_address_field_select.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_1=create st_1
this.cbx_11=create cbx_11
this.cbx_10=create cbx_10
this.cbx_9=create cbx_9
this.cbx_8=create cbx_8
this.cbx_7=create cbx_7
this.cbx_6=create cbx_6
this.cbx_5=create cbx_5
this.cbx_4=create cbx_4
this.cbx_3=create cbx_3
this.cbx_2=create cbx_2
this.cbx_1=create cbx_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.st_1,&
this.cbx_11,&
this.cbx_10,&
this.cbx_9,&
this.cbx_8,&
this.cbx_7,&
this.cbx_6,&
this.cbx_5,&
this.cbx_4,&
this.cbx_3,&
this.cbx_2,&
this.cbx_1}
end on

on w_app_map_address_field_select.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.cbx_11)
destroy(this.cbx_10)
destroy(this.cbx_9)
destroy(this.cbx_8)
destroy(this.cbx_7)
destroy(this.cbx_6)
destroy(this.cbx_5)
destroy(this.cbx_4)
destroy(this.cbx_3)
destroy(this.cbx_2)
destroy(this.cbx_1)
end on

type cb_2 from commandbutton within w_app_map_address_field_select
integer x = 544
integer y = 1136
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_app_map_address_field_select
integer x = 187
integer y = 1136
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
end type

type st_1 from statictext within w_app_map_address_field_select
integer x = 9
integer y = 8
integer width = 1065
integer height = 136
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 134217856
long backcolor = 33551856
string text = "Select Each Field that you wish to map and Click OK"
alignment alignment = center!
boolean focusrectangle = false
end type

type cbx_11 from checkbox within w_app_map_address_field_select
integer x = 311
integer y = 352
integer width = 457
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Suite"
end type

type cbx_10 from checkbox within w_app_map_address_field_select
integer x = 311
integer y = 436
integer width = 457
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "City"
end type

type cbx_9 from checkbox within w_app_map_address_field_select
integer x = 311
integer y = 520
integer width = 457
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "State"
end type

type cbx_8 from checkbox within w_app_map_address_field_select
integer x = 311
integer y = 180
integer width = 457
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Entity Name"
end type

type cbx_7 from checkbox within w_app_map_address_field_select
integer x = 311
integer y = 688
integer width = 457
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Country"
end type

type cbx_6 from checkbox within w_app_map_address_field_select
integer x = 311
integer y = 856
integer width = 485
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Email Address"
end type

type cbx_5 from checkbox within w_app_map_address_field_select
integer x = 311
integer y = 940
integer width = 457
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Phone"
end type

type cbx_4 from checkbox within w_app_map_address_field_select
integer x = 311
integer y = 1024
integer width = 457
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Fax"
end type

type cbx_3 from checkbox within w_app_map_address_field_select
integer x = 311
integer y = 772
integer width = 494
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Contact Name"
end type

type cbx_2 from checkbox within w_app_map_address_field_select
integer x = 311
integer y = 604
integer width = 457
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Zip"
end type

type cbx_1 from checkbox within w_app_map_address_field_select
integer x = 311
integer y = 264
integer width = 457
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Address "
end type

