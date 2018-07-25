$PBExportHeader$w_profile_data_prop.srw
$PBExportComments$maha 091802
forward
global type w_profile_data_prop from window
end type
type cb_5 from commandbutton within w_profile_data_prop
end type
type cb_2 from commandbutton within w_profile_data_prop
end type
type dw_dw from datawindow within w_profile_data_prop
end type
type dw_values from datawindow within w_profile_data_prop
end type
type cb_4 from commandbutton within w_profile_data_prop
end type
type cb_3 from commandbutton within w_profile_data_prop
end type
type cb_1 from commandbutton within w_profile_data_prop
end type
end forward

global type w_profile_data_prop from window
integer x = 5
integer y = 48
integer width = 3657
integer height = 1392
boolean titlebar = true
string title = "Profile Data Utility"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
boolean center = true
cb_5 cb_5
cb_2 cb_2
dw_dw dw_dw
dw_values dw_values
cb_4 cb_4
cb_3 cb_3
cb_1 cb_1
end type
global w_profile_data_prop w_profile_data_prop

type variables
string is_field1
string is_field2
string is_field3
string is_table
string is_where
end variables

on w_profile_data_prop.create
this.cb_5=create cb_5
this.cb_2=create cb_2
this.dw_dw=create dw_dw
this.dw_values=create dw_values
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_1=create cb_1
this.Control[]={this.cb_5,&
this.cb_2,&
this.dw_dw,&
this.dw_values,&
this.cb_4,&
this.cb_3,&
this.cb_1}
end on

on w_profile_data_prop.destroy
destroy(this.cb_5)
destroy(this.cb_2)
destroy(this.dw_dw)
destroy(this.dw_values)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_1)
end on

event open;long r, p
integer li_pos
string s

s = message.stringparm
li_pos = pos(s,"*",1)
r = long(mid(s,1, li_pos -1))
p = long(mid(s, li_pos + 1))

dw_values.settransobject(sqlca)
dw_values.retrieve(r)  //Start Code Change ----03.28.2016 #V15 maha - added argument
dw_dw.settransobject(sqlca)
dw_dw.retrieve(r,p)
end event

type cb_5 from commandbutton within w_profile_data_prop
boolean visible = false
integer x = 2491
integer y = 24
integer width = 247
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

event clicked;string null_str

SetNull(null_str)

dw_dw.Setfilter(null_str)

dw_dw.Filter( )
end event

type cb_2 from commandbutton within w_profile_data_prop
boolean visible = false
integer x = 2226
integer y = 24
integer width = 247
integer height = 84
integer taborder = 30
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

dw_dw.SetSort(null_str)

dw_dw.Sort( )
end event

type dw_dw from datawindow within w_profile_data_prop
integer x = 37
integer y = 164
integer width = 3561
integer height = 656
integer taborder = 30
string title = "none"
string dataobject = "d_profile_dw_prop"
boolean livescroll = true
end type

type dw_values from datawindow within w_profile_data_prop
integer x = 37
integer y = 860
integer width = 3557
integer height = 340
integer taborder = 10
string dataobject = "d_utl_profile_report_prop_arg"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type cb_4 from commandbutton within w_profile_data_prop
boolean visible = false
integer x = 2757
integer y = 24
integer width = 247
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;
dw_values.update()
dw_dw.update()
commit using sqlca;
end event

type cb_3 from commandbutton within w_profile_data_prop
integer x = 3314
integer y = 24
integer width = 274
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Quit"
end type

event clicked;CLOSE(PARENT)
end event

type cb_1 from commandbutton within w_profile_data_prop
boolean visible = false
integer x = 3026
integer y = 24
integer width = 265
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "About"
end type

event clicked;messagebox("To operate this program :","Select a Screen. Adjust field type")
end event

