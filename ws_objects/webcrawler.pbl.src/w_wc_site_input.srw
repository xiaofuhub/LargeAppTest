$PBExportHeader$w_wc_site_input.srw
forward
global type w_wc_site_input from window
end type
type st_1 from statictext within w_wc_site_input
end type
type st_mess from statictext within w_wc_site_input
end type
type cb_cancel from commandbutton within w_wc_site_input
end type
type cb_1 from commandbutton within w_wc_site_input
end type
end forward

global type w_wc_site_input from window
integer width = 2345
integer height = 892
boolean titlebar = true
string title = "Select Crawler"
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
st_1 st_1
st_mess st_mess
cb_cancel cb_cancel
cb_1 cb_1
end type
global w_wc_site_input w_wc_site_input

type variables
long il_wcid = 0
end variables

on w_wc_site_input.create
this.st_1=create st_1
this.st_mess=create st_mess
this.cb_cancel=create cb_cancel
this.cb_1=create cb_1
this.Control[]={this.st_1,&
this.st_mess,&
this.cb_cancel,&
this.cb_1}
end on

on w_wc_site_input.destroy
destroy(this.st_1)
destroy(this.st_mess)
destroy(this.cb_cancel)
destroy(this.cb_1)
end on

event open;string s

s = message.stringparm

st_mess.text = s

this.SetPosition(TopMost!) //Added by Evan 05.04.2012
end event

type st_1 from statictext within w_wc_site_input
integer x = 87
integer y = 424
integer width = 2167
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "Click Continue Crawl when ready, or Cancel to abort."
boolean focusrectangle = false
end type

type st_mess from statictext within w_wc_site_input
integer x = 87
integer y = 80
integer width = 2167
integer height = 240
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "Message will be written when window is opened."
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_wc_site_input
integer x = 1952
integer y = 592
integer width = 343
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;closewithreturn(parent,0)
end event

type cb_1 from commandbutton within w_wc_site_input
integer x = 1495
integer y = 592
integer width = 448
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Continue Crawl"
boolean default = true
end type

event clicked;//messagebox("",il_wcid)

closewithreturn(parent, 1)
end event

