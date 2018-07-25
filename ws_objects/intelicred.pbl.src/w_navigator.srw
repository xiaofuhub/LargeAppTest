$PBExportHeader$w_navigator.srw
forward
global type w_navigator from window
end type
type cb_10 from commandbutton within w_navigator
end type
type cb_12 from commandbutton within w_navigator
end type
type cb_11 from commandbutton within w_navigator
end type
type st_1 from statictext within w_navigator
end type
type sle_1 from singlelineedit within w_navigator
end type
type cb_9 from commandbutton within w_navigator
end type
type cb_8 from commandbutton within w_navigator
end type
type cb_7 from commandbutton within w_navigator
end type
type cb_6 from commandbutton within w_navigator
end type
type cb_5 from commandbutton within w_navigator
end type
type cb_4 from commandbutton within w_navigator
end type
type cb_3 from commandbutton within w_navigator
end type
type cb_2 from commandbutton within w_navigator
end type
type cb_1 from commandbutton within w_navigator
end type
type ln_1 from line within w_navigator
end type
type ln_2 from line within w_navigator
end type
type ln_3 from line within w_navigator
end type
type ln_4 from line within w_navigator
end type
type ln_5 from line within w_navigator
end type
type ln_6 from line within w_navigator
end type
type ln_7 from line within w_navigator
end type
type ln_8 from line within w_navigator
end type
type ln_9 from line within w_navigator
end type
type ln_10 from line within w_navigator
end type
type ln_11 from line within w_navigator
end type
end forward

global type w_navigator from window
integer x = 823
integer y = 360
integer width = 3008
integer height = 1808
boolean titlebar = true
string title = "Navigator"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 12639424
cb_10 cb_10
cb_12 cb_12
cb_11 cb_11
st_1 st_1
sle_1 sle_1
cb_9 cb_9
cb_8 cb_8
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
ln_1 ln_1
ln_2 ln_2
ln_3 ln_3
ln_4 ln_4
ln_5 ln_5
ln_6 ln_6
ln_7 ln_7
ln_8 ln_8
ln_9 ln_9
ln_10 ln_10
ln_11 ln_11
end type
global w_navigator w_navigator

on w_navigator.create
this.cb_10=create cb_10
this.cb_12=create cb_12
this.cb_11=create cb_11
this.st_1=create st_1
this.sle_1=create sle_1
this.cb_9=create cb_9
this.cb_8=create cb_8
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.ln_1=create ln_1
this.ln_2=create ln_2
this.ln_3=create ln_3
this.ln_4=create ln_4
this.ln_5=create ln_5
this.ln_6=create ln_6
this.ln_7=create ln_7
this.ln_8=create ln_8
this.ln_9=create ln_9
this.ln_10=create ln_10
this.ln_11=create ln_11
this.Control[]={this.cb_10,&
this.cb_12,&
this.cb_11,&
this.st_1,&
this.sle_1,&
this.cb_9,&
this.cb_8,&
this.cb_7,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.ln_1,&
this.ln_2,&
this.ln_3,&
this.ln_4,&
this.ln_5,&
this.ln_6,&
this.ln_7,&
this.ln_8,&
this.ln_9,&
this.ln_10,&
this.ln_11}
end on

on w_navigator.destroy
destroy(this.cb_10)
destroy(this.cb_12)
destroy(this.cb_11)
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.cb_9)
destroy(this.cb_8)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.ln_1)
destroy(this.ln_2)
destroy(this.ln_3)
destroy(this.ln_4)
destroy(this.ln_5)
destroy(this.ln_6)
destroy(this.ln_7)
destroy(this.ln_8)
destroy(this.ln_9)
destroy(this.ln_10)
destroy(this.ln_11)
end on

type cb_10 from commandbutton within w_navigator
integer x = 1970
integer y = 1252
integer width = 754
integer height = 108
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Scan/Print Images"
end type

type cb_12 from commandbutton within w_navigator
integer x = 1865
integer y = 92
integer width = 379
integer height = 100
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Search"
end type

type cb_11 from commandbutton within w_navigator
integer x = 2263
integer y = 92
integer width = 379
integer height = 100
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Switch Facility"
end type

type st_1 from statictext within w_navigator
integer x = 210
integer y = 28
integer width = 494
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 12639424
boolean enabled = false
string text = "Practitioner/Facility"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_navigator
integer x = 215
integer y = 96
integer width = 1637
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 12632256
string text = "John D~'Amelio      (BlueCross & BlueShield)"
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type cb_9 from commandbutton within w_navigator
integer x = 1984
integer y = 396
integer width = 754
integer height = 108
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Initiate Reappoinment Process"
end type

type cb_8 from commandbutton within w_navigator
integer x = 1093
integer y = 1248
integer width = 754
integer height = 108
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Print Verification Report"
end type

type cb_7 from commandbutton within w_navigator
integer x = 1966
integer y = 700
integer width = 754
integer height = 108
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Recieve From Commitee"
end type

type cb_6 from commandbutton within w_navigator
integer x = 1970
integer y = 976
integer width = 754
integer height = 108
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Send To Committee"
end type

type cb_5 from commandbutton within w_navigator
integer x = 201
integer y = 1248
integer width = 754
integer height = 108
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Print Profile Report"
end type

type cb_4 from commandbutton within w_navigator
integer x = 1093
integer y = 980
integer width = 754
integer height = 108
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Recieve Verifications"
end type

type cb_3 from commandbutton within w_navigator
integer x = 201
integer y = 980
integer width = 754
integer height = 108
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Process Verifications"
end type

type cb_2 from commandbutton within w_navigator
integer x = 183
integer y = 696
integer width = 818
integer height = 108
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Application Completeness Check"
end type

type cb_1 from commandbutton within w_navigator
integer x = 201
integer y = 396
integer width = 754
integer height = 108
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Start Initial Application Process"
end type

type ln_1 from line within w_navigator
long linecolor = 255
integer linethickness = 4
integer beginx = 549
integer beginy = 500
integer endx = 549
integer endy = 712
end type

type ln_2 from line within w_navigator
long linecolor = 255
integer linethickness = 4
integer beginx = 544
integer beginy = 788
integer endx = 544
integer endy = 1000
end type

type ln_3 from line within w_navigator
long linecolor = 255
integer linethickness = 4
integer beginx = 965
integer beginy = 1028
integer endx = 1211
integer endy = 1028
end type

type ln_4 from line within w_navigator
long linecolor = 255
integer linethickness = 4
integer beginx = 1815
integer beginy = 1032
integer endx = 2062
integer endy = 1032
end type

type ln_5 from line within w_navigator
long linecolor = 255
integer linethickness = 4
integer beginx = 2331
integer beginy = 812
integer endx = 2331
integer endy = 1024
end type

type ln_6 from line within w_navigator
long linecolor = 255
integer linethickness = 4
integer beginx = 667
integer beginy = 744
integer endx = 1472
integer endy = 744
end type

type ln_7 from line within w_navigator
long linecolor = 255
integer linethickness = 4
integer beginx = 1467
integer beginy = 456
integer endx = 1467
integer endy = 748
end type

type ln_8 from line within w_navigator
long linecolor = 255
integer linethickness = 4
integer beginx = 1467
integer beginy = 304
integer endx = 1467
integer endy = 456
end type

type ln_9 from line within w_navigator
long linecolor = 255
integer linethickness = 4
integer beginx = 1467
integer beginy = 300
integer endx = 2336
integer endy = 300
end type

type ln_10 from line within w_navigator
long linecolor = 255
integer linethickness = 4
integer beginx = 2039
integer beginy = 188
integer endx = 2039
integer endy = 304
end type

type ln_11 from line within w_navigator
long linecolor = 255
integer linethickness = 4
integer beginx = 2336
integer beginy = 304
integer endx = 2336
integer endy = 456
end type

