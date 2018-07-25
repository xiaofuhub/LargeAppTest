$PBExportHeader$w_snaptogrid.srw
forward
global type w_snaptogrid from window
end type
type st_help from statictext within w_snaptogrid
end type
type cb_2 from commandbutton within w_snaptogrid
end type
type cb_1 from commandbutton within w_snaptogrid
end type
type sle_y from singlelineedit within w_snaptogrid
end type
type sle_x from singlelineedit within w_snaptogrid
end type
type st_3 from statictext within w_snaptogrid
end type
type st_2 from statictext within w_snaptogrid
end type
type st_1 from statictext within w_snaptogrid
end type
type gb_1 from groupbox within w_snaptogrid
end type
end forward

global type w_snaptogrid from window
integer width = 2245
integer height = 812
boolean titlebar = true
string title = "Option"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
st_help st_help
cb_2 cb_2
cb_1 cb_1
sle_y sle_y
sle_x sle_x
st_3 st_3
st_2 st_2
st_1 st_1
gb_1 gb_1
end type
global w_snaptogrid w_snaptogrid

on w_snaptogrid.create
this.st_help=create st_help
this.cb_2=create cb_2
this.cb_1=create cb_1
this.sle_y=create sle_y
this.sle_x=create sle_x
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.gb_1=create gb_1
this.Control[]={this.st_help,&
this.cb_2,&
this.cb_1,&
this.sle_y,&
this.sle_x,&
this.st_3,&
this.st_2,&
this.st_1,&
this.gb_1}
end on

on w_snaptogrid.destroy
destroy(this.st_help)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.sle_y)
destroy(this.sle_x)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.gb_1)
end on

event open;sle_x.text = string(gi_snaptogrid_x)
sle_y.text = string(gi_snaptogrid_y)

st_help.text = "The Screen painter provides a grid to help you align controls at design time. You can use the grid options to:~r~n" + & 
					"1.Make controls snap to a grid position when you place them or move them in a screen ~r~n" + &
					"2.Specify the height and width of the grid cells "
end event

type st_help from statictext within w_snaptogrid
integer x = 78
integer y = 88
integer width = 2085
integer height = 328
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "test"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_snaptogrid
integer x = 1495
integer y = 608
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
end type

event clicked;gi_snaptogrid_x = integer(sle_x.text)
gi_snaptogrid_y = integer(sle_y.text)

//Get Snap to grid - jervis 06.11.2010
SetProfileString (gs_IniFilePathName, "Setup", "SnapToGridX", sle_x.text )
SetProfileString (gs_IniFilePathName, "Setup", "SnapToGridY", sle_y.text )

close(parent)
end event

type cb_1 from commandbutton within w_snaptogrid
integer x = 1861
integer y = 608
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
end type

event clicked;close(parent)
end event

type sle_y from singlelineedit within w_snaptogrid
integer x = 1271
integer y = 464
integer width = 343
integer height = 76
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "1"
borderstyle borderstyle = stylelowered!
end type

type sle_x from singlelineedit within w_snaptogrid
integer x = 603
integer y = 464
integer width = 343
integer height = 76
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "1"
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_snaptogrid
integer x = 1198
integer y = 472
integer width = 78
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Y:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_snaptogrid
integer x = 530
integer y = 472
integer width = 78
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "X:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_snaptogrid
integer x = 73
integer y = 472
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
string text = "Snap to grid"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_snaptogrid
integer x = 37
integer y = 8
integer width = 2167
integer height = 572
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Alignment Grid"
end type

