$PBExportHeader$w_wv_link.srw
forward
global type w_wv_link from window
end type
type st_link from statictext within w_wv_link
end type
type cb_1 from commandbutton within w_wv_link
end type
type cb_2 from commandbutton within w_wv_link
end type
end forward

global type w_wv_link from window
integer width = 2222
integer height = 628
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
st_link st_link
cb_1 cb_1
cb_2 cb_2
end type
global w_wv_link w_wv_link

on w_wv_link.create
this.st_link=create st_link
this.cb_1=create cb_1
this.cb_2=create cb_2
this.Control[]={this.st_link,&
this.cb_1,&
this.cb_2}
end on

on w_wv_link.destroy
destroy(this.st_link)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event open;string s

s = message.stringparm

st_link.text = s
end event

type st_link from statictext within w_wv_link
integer x = 91
integer y = 56
integer width = 2062
integer height = 260
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_wv_link
integer x = 741
integer y = 412
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Clipboard"
end type

event clicked;clipboard(st_link.text)
end event

type cb_2 from commandbutton within w_wv_link
integer x = 1115
integer y = 412
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;close(parent)
end event

