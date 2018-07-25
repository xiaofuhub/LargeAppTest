$PBExportHeader$w_setup_access.srw
forward
global type w_setup_access from window
end type
type cb_1 from commandbutton within w_setup_access
end type
type st_15 from statictext within w_setup_access
end type
type st_13 from statictext within w_setup_access
end type
type st_19 from statictext within w_setup_access
end type
type st_16 from statictext within w_setup_access
end type
type st_14 from statictext within w_setup_access
end type
type st_12 from statictext within w_setup_access
end type
type st_11 from statictext within w_setup_access
end type
type st_10 from statictext within w_setup_access
end type
type st_9 from statictext within w_setup_access
end type
type st_8 from statictext within w_setup_access
end type
type st_7 from statictext within w_setup_access
end type
type st_6 from statictext within w_setup_access
end type
type st_5 from statictext within w_setup_access
end type
type st_4 from statictext within w_setup_access
end type
type st_3 from statictext within w_setup_access
end type
type st_2 from statictext within w_setup_access
end type
type st_1 from statictext within w_setup_access
end type
end forward

global type w_setup_access from window
integer width = 1216
integer height = 1872
boolean titlebar = true
string title = "Setup Access"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
st_15 st_15
st_13 st_13
st_19 st_19
st_16 st_16
st_14 st_14
st_12 st_12
st_11 st_11
st_10 st_10
st_9 st_9
st_8 st_8
st_7 st_7
st_6 st_6
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
end type
global w_setup_access w_setup_access

on w_setup_access.create
this.cb_1=create cb_1
this.st_15=create st_15
this.st_13=create st_13
this.st_19=create st_19
this.st_16=create st_16
this.st_14=create st_14
this.st_12=create st_12
this.st_11=create st_11
this.st_10=create st_10
this.st_9=create st_9
this.st_8=create st_8
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.Control[]={this.cb_1,&
this.st_15,&
this.st_13,&
this.st_19,&
this.st_16,&
this.st_14,&
this.st_12,&
this.st_11,&
this.st_10,&
this.st_9,&
this.st_8,&
this.st_7,&
this.st_6,&
this.st_5,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_1}
end on

on w_setup_access.destroy
destroy(this.cb_1)
destroy(this.st_15)
destroy(this.st_13)
destroy(this.st_19)
destroy(this.st_16)
destroy(this.st_14)
destroy(this.st_12)
destroy(this.st_11)
destroy(this.st_10)
destroy(this.st_9)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
end on

type cb_1 from commandbutton within w_setup_access
integer x = 891
integer y = 36
integer width = 293
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;close (parent)
end event

type st_15 from statictext within w_setup_access
integer x = 14
integer y = 48
integer width = 873
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Click link to open Setup Screen"
boolean focusrectangle = false
end type

type st_13 from statictext within w_setup_access
integer x = 142
integer y = 832
integer width = 887
integer height = 72
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
long textcolor = 16711680
long backcolor = 33551856
string text = "Peer Reference List"
boolean focusrectangle = false
end type

type st_19 from statictext within w_setup_access
integer x = 142
integer y = 1016
integer width = 887
integer height = 72
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
long textcolor = 16711680
long backcolor = 33551856
string text = "Profile Screen Design"
boolean focusrectangle = false
end type

type st_16 from statictext within w_setup_access
integer x = 142
integer y = 1108
integer width = 887
integer height = 72
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
long textcolor = 16711680
long backcolor = 33551856
string text = "Question List"
boolean focusrectangle = false
end type

type st_14 from statictext within w_setup_access
integer x = 142
integer y = 188
integer width = 887
integer height = 72
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
long textcolor = 16711680
long backcolor = 33551856
string text = "Checklist Setup"
boolean focusrectangle = false
end type

type st_12 from statictext within w_setup_access
integer x = 142
integer y = 924
integer width = 887
integer height = 72
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
long textcolor = 16711680
long backcolor = 33551856
string text = "Provider Profile Design"
boolean focusrectangle = false
end type

type st_11 from statictext within w_setup_access
integer x = 142
integer y = 464
integer width = 887
integer height = 72
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
long textcolor = 16711680
long backcolor = 33551856
string text = "Expiring Data Settings"
boolean focusrectangle = false
end type

type st_10 from statictext within w_setup_access
integer x = 142
integer y = 1384
integer width = 887
integer height = 72
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
long textcolor = 16711680
long backcolor = 33551856
string text = "To-Do-Lists"
boolean focusrectangle = false
end type

type st_9 from statictext within w_setup_access
integer x = 142
integer y = 648
integer width = 887
integer height = 72
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
long textcolor = 16711680
long backcolor = 33551856
string text = "Letter Storage"
boolean focusrectangle = false
end type

type st_8 from statictext within w_setup_access
integer x = 142
integer y = 1568
integer width = 887
integer height = 72
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
long textcolor = 16711680
long backcolor = 33551856
string text = "View Design"
boolean focusrectangle = false
end type

type st_7 from statictext within w_setup_access
integer x = 142
integer y = 280
integer width = 887
integer height = 72
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
long textcolor = 16711680
long backcolor = 33551856
string text = "Document Types"
boolean focusrectangle = false
end type

type st_6 from statictext within w_setup_access
integer x = 142
integer y = 1476
integer width = 887
integer height = 72
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
long textcolor = 16711680
long backcolor = 33551856
string text = "User Setup"
boolean focusrectangle = false
end type

type st_5 from statictext within w_setup_access
integer x = 142
integer y = 1200
integer width = 887
integer height = 72
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
long textcolor = 16711680
long backcolor = 33551856
string text = "Role Definition"
boolean focusrectangle = false
end type

type st_4 from statictext within w_setup_access
integer x = 142
integer y = 372
integer width = 887
integer height = 72
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
long textcolor = 16711680
long backcolor = 33551856
string text = "Email Templates"
boolean focusrectangle = false
end type

type st_3 from statictext within w_setup_access
integer x = 142
integer y = 556
integer width = 887
integer height = 72
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
long textcolor = 16711680
long backcolor = 33551856
string text = "Fax Templates"
boolean focusrectangle = false
end type

type st_2 from statictext within w_setup_access
integer x = 142
integer y = 1292
integer width = 887
integer height = 72
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
long textcolor = 16711680
long backcolor = 33551856
string text = "Screen Design"
boolean focusrectangle = false
end type

type st_1 from statictext within w_setup_access
integer x = 142
integer y = 740
integer width = 887
integer height = 72
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
long textcolor = 16711680
long backcolor = 33551856
string text = "Lookup Lists"
boolean focusrectangle = false
end type

