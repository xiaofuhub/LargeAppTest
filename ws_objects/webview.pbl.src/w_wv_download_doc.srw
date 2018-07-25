$PBExportHeader$w_wv_download_doc.srw
forward
global type w_wv_download_doc from window
end type
type cb_3 from commandbutton within w_wv_download_doc
end type
type cb_2 from commandbutton within w_wv_download_doc
end type
type cb_1 from commandbutton within w_wv_download_doc
end type
type st_6 from statictext within w_wv_download_doc
end type
type st_5 from statictext within w_wv_download_doc
end type
type st_file_name from statictext within w_wv_download_doc
end type
type st_4 from statictext within w_wv_download_doc
end type
type st_3 from statictext within w_wv_download_doc
end type
type st_2 from statictext within w_wv_download_doc
end type
type st_1 from statictext within w_wv_download_doc
end type
end forward

global type w_wv_download_doc from window
integer width = 1527
integer height = 816
boolean titlebar = true
string title = "File Download"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
st_6 st_6
st_5 st_5
st_file_name st_file_name
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
end type
global w_wv_download_doc w_wv_download_doc

type variables

end variables

on w_wv_download_doc.create
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_6=create st_6
this.st_5=create st_5
this.st_file_name=create st_file_name
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.Control[]={this.cb_3,&
this.cb_2,&
this.cb_1,&
this.st_6,&
this.st_5,&
this.st_file_name,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_1}
end on

on w_wv_download_doc.destroy
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_file_name)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
end on

event open;//////////////////////////////////////////////////////////////////////
// $<event> open
// $<arguments>
// $<returns> long
// $<description>  Letter Template Maintenance (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add>02.23.2012 by Stephen
//////////////////////////////////////////////////////////////////////
string ls_file

ls_file = message.stringparm
st_file_name.text = ls_file
end event

type cb_3 from commandbutton within w_wv_download_doc
integer x = 992
integer y = 584
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
boolean default = true
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description>  Letter Template Maintenance (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add>02.23.2012 by Stephen
//////////////////////////////////////////////////////////////////////
closewithreturn(parent, '0')
end event

type cb_2 from commandbutton within w_wv_download_doc
integer x = 590
integer y = 584
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description>  Letter Template Maintenance (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add>02.23.2012 by Stephen
//////////////////////////////////////////////////////////////////////
closewithreturn(parent, '2')
end event

type cb_1 from commandbutton within w_wv_download_doc
integer x = 187
integer y = 584
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Open"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description>  Letter Template Maintenance (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add>02.23.2012 by Stephen
//////////////////////////////////////////////////////////////////////

closewithreturn(parent, '1')

end event

type st_6 from statictext within w_wv_download_doc
integer x = 366
integer y = 456
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
string text = "Localhost"
boolean focusrectangle = false
end type

type st_5 from statictext within w_wv_download_doc
integer x = 123
integer y = 456
integer width = 219
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "From:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_file_name from statictext within w_wv_download_doc
integer x = 366
integer y = 196
integer width = 1015
integer height = 52
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

type st_4 from statictext within w_wv_download_doc
integer x = 366
integer y = 324
integer width = 1015
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Microsoft Office Word 97 - 2003 Document"
boolean focusrectangle = false
end type

type st_3 from statictext within w_wv_download_doc
integer x = 151
integer y = 324
integer width = 192
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Type:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_wv_download_doc
integer x = 151
integer y = 196
integer width = 192
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Name:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_wv_download_doc
integer x = 224
integer y = 60
integer width = 1056
integer height = 72
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Do you want to open or save this file ?"
boolean focusrectangle = false
end type

