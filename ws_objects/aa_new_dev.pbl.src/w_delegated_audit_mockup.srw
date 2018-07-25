$PBExportHeader$w_delegated_audit_mockup.srw
forward
global type w_delegated_audit_mockup from window
end type
type cb_3 from commandbutton within w_delegated_audit_mockup
end type
type cb_2 from commandbutton within w_delegated_audit_mockup
end type
type cb_1 from commandbutton within w_delegated_audit_mockup
end type
type pb_2 from picturebutton within w_delegated_audit_mockup
end type
type dw_1 from datawindow within w_delegated_audit_mockup
end type
type pb_1 from picturebutton within w_delegated_audit_mockup
end type
type dw_2 from datawindow within w_delegated_audit_mockup
end type
type sle_3 from singlelineedit within w_delegated_audit_mockup
end type
type sle_2 from singlelineedit within w_delegated_audit_mockup
end type
type sle_1 from singlelineedit within w_delegated_audit_mockup
end type
type st_3 from statictext within w_delegated_audit_mockup
end type
type st_2 from statictext within w_delegated_audit_mockup
end type
type st_1 from statictext within w_delegated_audit_mockup
end type
end forward

global type w_delegated_audit_mockup from window
integer width = 3525
integer height = 3132
boolean titlebar = true
string title = "Delegated Credentialing Mockup"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 32891346
string icon = "AppIcon!"
boolean center = true
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
pb_2 pb_2
dw_1 dw_1
pb_1 pb_1
dw_2 dw_2
sle_3 sle_3
sle_2 sle_2
sle_1 sle_1
st_3 st_3
st_2 st_2
st_1 st_1
end type
global w_delegated_audit_mockup w_delegated_audit_mockup

on w_delegated_audit_mockup.create
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.pb_2=create pb_2
this.dw_1=create dw_1
this.pb_1=create pb_1
this.dw_2=create dw_2
this.sle_3=create sle_3
this.sle_2=create sle_2
this.sle_1=create sle_1
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.Control[]={this.cb_3,&
this.cb_2,&
this.cb_1,&
this.pb_2,&
this.dw_1,&
this.pb_1,&
this.dw_2,&
this.sle_3,&
this.sle_2,&
this.sle_1,&
this.st_3,&
this.st_2,&
this.st_1}
end on

on w_delegated_audit_mockup.destroy
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.pb_2)
destroy(this.dw_1)
destroy(this.pb_1)
destroy(this.dw_2)
destroy(this.sle_3)
destroy(this.sle_2)
destroy(this.sle_1)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
end on

type cb_3 from commandbutton within w_delegated_audit_mockup
integer x = 2135
integer y = 68
integer width = 402
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

type cb_2 from commandbutton within w_delegated_audit_mockup
integer x = 2546
integer y = 68
integer width = 402
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

type cb_1 from commandbutton within w_delegated_audit_mockup
integer x = 2967
integer y = 68
integer width = 402
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

type pb_2 from picturebutton within w_delegated_audit_mockup
integer x = 2149
integer y = 368
integer width = 1234
integer height = 1428
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean originalsize = true
string picturename = "C:\aatest\del_audit_prac.png"
alignment htextalign = left!
end type

type dw_1 from datawindow within w_delegated_audit_mockup
integer x = 23
integer y = 260
integer width = 2043
integer height = 92
integer taborder = 40
boolean titlebar = true
string title = "Audit Procedures"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type pb_1 from picturebutton within w_delegated_audit_mockup
integer x = 18
integer y = 356
integer width = 2053
integer height = 2620
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string picturename = "C:\aatest\del audit quest.png"
alignment htextalign = left!
end type

type dw_2 from datawindow within w_delegated_audit_mockup
integer x = 2130
integer y = 260
integer width = 1262
integer height = 2716
integer taborder = 20
boolean titlebar = true
string title = "Providers Audited"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type sle_3 from singlelineedit within w_delegated_audit_mockup
integer x = 1097
integer y = 72
integer width = 809
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "IntelliCVO"
borderstyle borderstyle = stylelowered!
end type

type sle_2 from singlelineedit within w_delegated_audit_mockup
integer x = 613
integer y = 72
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "rlablanc"
borderstyle borderstyle = stylelowered!
end type

type sle_1 from singlelineedit within w_delegated_audit_mockup
integer x = 82
integer y = 72
integer width = 439
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "12/12/2013"
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_delegated_audit_mockup
integer x = 1093
integer y = 12
integer width = 471
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "Organization Audited:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_delegated_audit_mockup
integer x = 613
integer y = 12
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "Completed by"
boolean focusrectangle = false
end type

type st_1 from statictext within w_delegated_audit_mockup
integer x = 101
integer y = 12
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "Audit date"
boolean focusrectangle = false
end type

