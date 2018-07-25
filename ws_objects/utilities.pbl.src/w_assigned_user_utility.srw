$PBExportHeader$w_assigned_user_utility.srw
$PBExportComments$not being used
forward
global type w_assigned_user_utility from window
end type
type cb_2 from commandbutton within w_assigned_user_utility
end type
type cbx_v from checkbox within w_assigned_user_utility
end type
type cbx_a from checkbox within w_assigned_user_utility
end type
type st_3 from statictext within w_assigned_user_utility
end type
type dw_3 from datawindow within w_assigned_user_utility
end type
type cb_1 from commandbutton within w_assigned_user_utility
end type
type st_2 from statictext within w_assigned_user_utility
end type
type st_1 from statictext within w_assigned_user_utility
end type
type dw_2 from datawindow within w_assigned_user_utility
end type
type dw_1 from datawindow within w_assigned_user_utility
end type
type gb_2 from groupbox within w_assigned_user_utility
end type
type gb_1 from groupbox within w_assigned_user_utility
end type
end forward

global type w_assigned_user_utility from window
integer x = 1056
integer y = 484
integer width = 1381
integer height = 840
boolean titlebar = true
string title = "Assigned User Update"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
cb_2 cb_2
cbx_v cbx_v
cbx_a cbx_a
st_3 st_3
dw_3 dw_3
cb_1 cb_1
st_2 st_2
st_1 st_1
dw_2 dw_2
dw_1 dw_1
gb_2 gb_2
gb_1 gb_1
end type
global w_assigned_user_utility w_assigned_user_utility

on w_assigned_user_utility.create
this.cb_2=create cb_2
this.cbx_v=create cbx_v
this.cbx_a=create cbx_a
this.st_3=create st_3
this.dw_3=create dw_3
this.cb_1=create cb_1
this.st_2=create st_2
this.st_1=create st_1
this.dw_2=create dw_2
this.dw_1=create dw_1
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.cb_2,&
this.cbx_v,&
this.cbx_a,&
this.st_3,&
this.dw_3,&
this.cb_1,&
this.st_2,&
this.st_1,&
this.dw_2,&
this.dw_1,&
this.gb_2,&
this.gb_1}
end on

on w_assigned_user_utility.destroy
destroy(this.cb_2)
destroy(this.cbx_v)
destroy(this.cbx_a)
destroy(this.st_3)
destroy(this.dw_3)
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.gb_2)
destroy(this.gb_1)
end on

type cb_2 from commandbutton within w_assigned_user_utility
integer x = 1070
integer y = 584
integer width = 247
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

type cbx_v from checkbox within w_assigned_user_utility
integer x = 869
integer y = 160
integer width = 398
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Verifications"
end type

type cbx_a from checkbox within w_assigned_user_utility
integer x = 869
integer y = 84
integer width = 425
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Appointments"
end type

type st_3 from statictext within w_assigned_user_utility
integer x = 105
integer y = 468
integer width = 247
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "User"
boolean focusrectangle = false
end type

type dw_3 from datawindow within w_assigned_user_utility
integer x = 101
integer y = 544
integer width = 475
integer height = 92
integer taborder = 30
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_assigned_user_utility
integer x = 800
integer y = 584
integer width = 247
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Update"
end type

type st_2 from statictext within w_assigned_user_utility
integer x = 101
integer y = 272
integer width = 293
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Department"
boolean focusrectangle = false
end type

type st_1 from statictext within w_assigned_user_utility
integer x = 101
integer y = 68
integer width = 247
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Facility"
boolean focusrectangle = false
end type

type dw_2 from datawindow within w_assigned_user_utility
integer x = 101
integer y = 352
integer width = 631
integer height = 88
integer taborder = 40
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_1 from datawindow within w_assigned_user_utility
integer x = 101
integer y = 152
integer width = 635
integer height = 84
integer taborder = 10
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_assigned_user_utility
integer x = 64
integer y = 20
integer width = 713
integer height = 664
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Select:"
end type

type gb_1 from groupbox within w_assigned_user_utility
integer x = 823
integer y = 20
integer width = 494
integer height = 248
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Update"
end type

