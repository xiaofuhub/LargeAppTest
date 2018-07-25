$PBExportHeader$w_size_test.srw
forward
global type w_size_test from window
end type
type st_1 from statictext within w_size_test
end type
type st_2 from statictext within w_size_test
end type
type st_3 from statictext within w_size_test
end type
end forward

global type w_size_test from window
integer width = 6053
integer height = 4156
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_1 st_1
st_2 st_2
st_3 st_3
end type
global w_size_test w_size_test

on w_size_test.create
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.Control[]={this.st_1,&
this.st_2,&
this.st_3}
end on

on w_size_test.destroy
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
end on

type st_1 from statictext within w_size_test
integer width = 3602
integer height = 2252
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "800x600"
boolean focusrectangle = false
end type

type st_2 from statictext within w_size_test
integer width = 4599
integer height = 2800
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 15780518
string text = "1024x786"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_size_test
integer width = 5751
integer height = 3956
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 12639424
string text = "1280x1026"
alignment alignment = right!
boolean focusrectangle = false
end type

