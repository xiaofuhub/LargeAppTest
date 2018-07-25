$PBExportHeader$w_profile_data_utility.srw
$PBExportComments$maha 091802
forward
global type w_profile_data_utility from window
end type
type cb_5 from commandbutton within w_profile_data_utility
end type
type cb_2 from commandbutton within w_profile_data_utility
end type
type rb_2 from radiobutton within w_profile_data_utility
end type
type rb_1 from radiobutton within w_profile_data_utility
end type
type dw_dw from datawindow within w_profile_data_utility
end type
type dw_values from datawindow within w_profile_data_utility
end type
type cb_4 from commandbutton within w_profile_data_utility
end type
type cb_3 from commandbutton within w_profile_data_utility
end type
type cb_1 from commandbutton within w_profile_data_utility
end type
type gb_1 from groupbox within w_profile_data_utility
end type
end forward

global type w_profile_data_utility from window
integer x = 5
integer y = 48
integer width = 3685
integer height = 2300
boolean titlebar = true
string title = "Profile Data Utility"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
cb_5 cb_5
cb_2 cb_2
rb_2 rb_2
rb_1 rb_1
dw_dw dw_dw
dw_values dw_values
cb_4 cb_4
cb_3 cb_3
cb_1 cb_1
gb_1 gb_1
end type
global w_profile_data_utility w_profile_data_utility

type variables
string is_field1
string is_field2
string is_field3
string is_table
string is_where
end variables

on w_profile_data_utility.create
this.cb_5=create cb_5
this.cb_2=create cb_2
this.rb_2=create rb_2
this.rb_1=create rb_1
this.dw_dw=create dw_dw
this.dw_values=create dw_values
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_1=create cb_1
this.gb_1=create gb_1
this.Control[]={this.cb_5,&
this.cb_2,&
this.rb_2,&
this.rb_1,&
this.dw_dw,&
this.dw_values,&
this.cb_4,&
this.cb_3,&
this.cb_1,&
this.gb_1}
end on

on w_profile_data_utility.destroy
destroy(this.cb_5)
destroy(this.cb_2)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.dw_dw)
destroy(this.dw_values)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_1)
destroy(this.gb_1)
end on

event open;//SQLCA.DBMS="ODBC"
//SQLCA.DbParm="ConnectString='DSN=IntelliCred Client;UID=DBA;PWD=SQL;',DelimitIdentifier='No'"
//	
//CONNECT USING SQLCA;
//
//IF SQLCA.SQLCODE = -1 THEN
//	MessageBox("Not Logged In", "Login Failed!")
//ELSE
//	MESSAGEBOX("","LOGIN OK")
//END IF
//

dw_values.settransobject(sqlca)
dw_values.retrieve()
dw_dw.settransobject(sqlca)
dw_dw.retrieve()
end event

event close;//disCONNECT USING SQLCA;
end event

type cb_5 from commandbutton within w_profile_data_utility
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

type cb_2 from commandbutton within w_profile_data_utility
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

type rb_2 from radiobutton within w_profile_data_utility
integer x = 951
integer y = 44
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Standard"
end type

event clicked;dw_values.bringtotop = true
end event

type rb_1 from radiobutton within w_profile_data_utility
integer x = 544
integer y = 44
integer width = 393
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Dynamic"
boolean checked = true
end type

event clicked;dw_dw.bringtotop = true
end event

type dw_dw from datawindow within w_profile_data_utility
integer x = 37
integer y = 128
integer width = 3561
integer height = 1836
integer taborder = 30
string title = "none"
string dataobject = "d_profile_dw_utl"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type dw_values from datawindow within w_profile_data_utility
integer x = 41
integer y = 132
integer width = 3557
integer height = 1832
integer taborder = 10
string dataobject = "d_utl_profile_report_edit"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type cb_4 from commandbutton within w_profile_data_utility
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

type cb_3 from commandbutton within w_profile_data_utility
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

type cb_1 from commandbutton within w_profile_data_utility
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

type gb_1 from groupbox within w_profile_data_utility
integer x = 498
integer width = 882
integer height = 120
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "View"
end type

