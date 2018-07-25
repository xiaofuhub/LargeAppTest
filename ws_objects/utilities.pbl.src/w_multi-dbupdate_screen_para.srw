$PBExportHeader$w_multi-dbupdate_screen_para.srw
forward
global type w_multi-dbupdate_screen_para from window
end type
type cbx_1 from checkbox within w_multi-dbupdate_screen_para
end type
type em_1 from editmask within w_multi-dbupdate_screen_para
end type
type cb_1 from commandbutton within w_multi-dbupdate_screen_para
end type
type st_3 from statictext within w_multi-dbupdate_screen_para
end type
type st_2 from statictext within w_multi-dbupdate_screen_para
end type
type st_1 from statictext within w_multi-dbupdate_screen_para
end type
type sle_3 from singlelineedit within w_multi-dbupdate_screen_para
end type
type sle_2 from singlelineedit within w_multi-dbupdate_screen_para
end type
end forward

global type w_multi-dbupdate_screen_para from window
integer width = 1998
integer height = 668
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cbx_1 cbx_1
em_1 em_1
cb_1 cb_1
st_3 st_3
st_2 st_2
st_1 st_1
sle_3 sle_3
sle_2 sle_2
end type
global w_multi-dbupdate_screen_para w_multi-dbupdate_screen_para

on w_multi-dbupdate_screen_para.create
this.cbx_1=create cbx_1
this.em_1=create em_1
this.cb_1=create cb_1
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.sle_3=create sle_3
this.sle_2=create sle_2
this.Control[]={this.cbx_1,&
this.em_1,&
this.cb_1,&
this.st_3,&
this.st_2,&
this.st_1,&
this.sle_3,&
this.sle_2}
end on

on w_multi-dbupdate_screen_para.destroy
destroy(this.cbx_1)
destroy(this.em_1)
destroy(this.cb_1)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_3)
destroy(this.sle_2)
end on

type cbx_1 from checkbox within w_multi-dbupdate_screen_para
integer x = 1394
integer y = 48
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
string text = "Optimize"
end type

type em_1 from editmask within w_multi-dbupdate_screen_para
integer x = 485
integer y = 32
integer width = 754
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "2013-04-21"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datetimemask!
string mask = "yyyy-mm-dd"
boolean dropdowncalendar = true
end type

type cb_1 from commandbutton within w_multi-dbupdate_screen_para
integer x = 1618
integer y = 472
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
end type

event clicked;str_screen_para  lstr_screen_para


lstr_screen_para.para1 = sle_2.Text
lstr_screen_para.para2 = sle_3.Text
lstr_screen_para.para3 =  em_1.Text
lstr_screen_para.para4 = cbx_1.checked

closewithreturn( parent, lstr_screen_para )
end event

type st_3 from statictext within w_multi-dbupdate_screen_para
integer x = 114
integer y = 340
integer width = 343
integer height = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Backup User"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_multi-dbupdate_screen_para
integer x = 114
integer y = 204
integer width = 343
integer height = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Backup Vision"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_multi-dbupdate_screen_para
integer x = 114
integer y = 48
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
string text = "Backup Date"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_3 from singlelineedit within w_multi-dbupdate_screen_para
integer x = 485
integer y = 344
integer width = 754
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "MASTER"
borderstyle borderstyle = stylelowered!
end type

type sle_2 from singlelineedit within w_multi-dbupdate_screen_para
integer x = 485
integer y = 188
integer width = 754
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "0063"
borderstyle borderstyle = stylelowered!
end type

