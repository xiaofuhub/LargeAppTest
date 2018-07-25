$PBExportHeader$w_wv_appname_modify.srw
forward
global type w_wv_appname_modify from window
end type
type st_3 from statictext within w_wv_appname_modify
end type
type cb_1 from commandbutton within w_wv_appname_modify
end type
type st_2 from statictext within w_wv_appname_modify
end type
type st_1 from statictext within w_wv_appname_modify
end type
type sle_1 from singlelineedit within w_wv_appname_modify
end type
end forward

global type w_wv_appname_modify from window
integer width = 1979
integer height = 488
boolean titlebar = true
string title = "Modify App Name"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
st_3 st_3
cb_1 cb_1
st_2 st_2
st_1 st_1
sle_1 sle_1
end type
global w_wv_appname_modify w_wv_appname_modify

type variables
string is_appname
end variables

on w_wv_appname_modify.create
this.st_3=create st_3
this.cb_1=create cb_1
this.st_2=create st_2
this.st_1=create st_1
this.sle_1=create sle_1
this.Control[]={this.st_3,&
this.cb_1,&
this.st_2,&
this.st_1,&
this.sle_1}
end on

on w_wv_appname_modify.destroy
destroy(this.st_3)
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_1)
end on

event open;//////////////////////////////////////////////////////////////////////
// $<event> open
// $<arguments>
// $<returns> long
// $<description> WebView Settings Maintenance (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add> 03.06.2012 by Stephen
//////////////////////////////////////////////////////////////////////

string ls_appname

ls_appname = message.stringparm
sle_1.text = ls_appname
end event

type st_3 from statictext within w_wv_appname_modify
integer x = 64
integer y = 284
integer width = 919
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "For Example: WebViewintellicredweb"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_wv_appname_modify
integer x = 1623
integer y = 64
integer width = 293
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Ok"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description>  WebView Settings Maintenance (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add>03.06.2012 by Stephen
//////////////////////////////////////////////////////////////////////

is_appname = sle_1.text

if isnull(is_appname) or is_appname = '' then
	messagebox("Prompt", "App Name cannot be empty!")
	return -1
end if
closewithreturn(parent,is_appname)
end event

type st_2 from statictext within w_wv_appname_modify
integer x = 64
integer y = 208
integer width = 1595
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "App Name = WebView+the virtual directory of this webview site"
boolean focusrectangle = false
end type

type st_1 from statictext within w_wv_appname_modify
integer x = 64
integer y = 76
integer width = 274
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "App Name:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_wv_appname_modify
integer x = 347
integer y = 68
integer width = 1257
integer height = 80
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

