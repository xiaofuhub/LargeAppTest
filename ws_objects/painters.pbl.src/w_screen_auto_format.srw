$PBExportHeader$w_screen_auto_format.srw
forward
global type w_screen_auto_format from window
end type
type p_2 from picture within w_screen_auto_format
end type
type p_1 from picture within w_screen_auto_format
end type
type st_6 from statictext within w_screen_auto_format
end type
type st_5 from statictext within w_screen_auto_format
end type
type st_4 from statictext within w_screen_auto_format
end type
type st_3 from statictext within w_screen_auto_format
end type
type st_1 from statictext within w_screen_auto_format
end type
type cb_cancel from commandbutton within w_screen_auto_format
end type
type cb_standard from commandbutton within w_screen_auto_format
end type
type cb_web from commandbutton within w_screen_auto_format
end type
type st_2 from statictext within w_screen_auto_format
end type
end forward

global type w_screen_auto_format from window
integer width = 2994
integer height = 2068
boolean titlebar = true
string title = "Auto Format"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
p_2 p_2
p_1 p_1
st_6 st_6
st_5 st_5
st_4 st_4
st_3 st_3
st_1 st_1
cb_cancel cb_cancel
cb_standard cb_standard
cb_web cb_web
st_2 st_2
end type
global w_screen_auto_format w_screen_auto_format

on w_screen_auto_format.create
this.p_2=create p_2
this.p_1=create p_1
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_1=create st_1
this.cb_cancel=create cb_cancel
this.cb_standard=create cb_standard
this.cb_web=create cb_web
this.st_2=create st_2
this.Control[]={this.p_2,&
this.p_1,&
this.st_6,&
this.st_5,&
this.st_4,&
this.st_3,&
this.st_1,&
this.cb_cancel,&
this.cb_standard,&
this.cb_web,&
this.st_2}
end on

on w_screen_auto_format.destroy
destroy(this.p_2)
destroy(this.p_1)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_1)
destroy(this.cb_cancel)
destroy(this.cb_standard)
destroy(this.cb_web)
destroy(this.st_2)
end on

type p_2 from picture within w_screen_auto_format
integer x = 1486
integer y = 1252
integer width = 1458
integer height = 540
string picturename = "screen format standard.jpg"
boolean border = true
boolean focusrectangle = false
end type

type p_1 from picture within w_screen_auto_format
integer x = 41
integer y = 1256
integer width = 1426
integer height = 536
string picturename = "screen format ordered.jpg"
boolean border = true
boolean focusrectangle = false
end type

type st_6 from statictext within w_screen_auto_format
integer x = 55
integer y = 712
integer width = 2871
integer height = 172
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "The Standard format will quickly reformat a screen if you have changed the order of the fields.  Just change the Tab order, and run the Standard format to rearrange the screen."
boolean focusrectangle = false
end type

type st_5 from statictext within w_screen_auto_format
integer x = 55
integer y = 1048
integer width = 2871
integer height = 168
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Note: The formatting changes will not be saved automatically.  If you like the format, save the changed screen."
boolean focusrectangle = false
end type

type st_4 from statictext within w_screen_auto_format
integer x = 55
integer y = 916
integer width = 2871
integer height = 120
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Cancel will cancel the operation."
boolean focusrectangle = false
end type

type st_3 from statictext within w_screen_auto_format
integer x = 55
integer y = 248
integer width = 2871
integer height = 212
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Ordered list format will center all of your fields in a column with the label in front of the field.  May be particularly useful for Views used in WebView."
boolean focusrectangle = false
end type

type st_1 from statictext within w_screen_auto_format
integer x = 55
integer y = 36
integer width = 2871
integer height = 192
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "The auto-format function will allow you to reset the fields on the screen in one of two formats, based on the order of your fields.  "
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_screen_auto_format
integer x = 2587
integer y = 1828
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;closewithreturn(parent,"C")
end event

type cb_standard from commandbutton within w_screen_auto_format
integer x = 2025
integer y = 1828
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Standard"
end type

event clicked;closewithreturn(parent,"S")
end event

type cb_web from commandbutton within w_screen_auto_format
integer x = 512
integer y = 1828
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Ordered List"
end type

event clicked;closewithreturn(parent,"L")
end event

type st_2 from statictext within w_screen_auto_format
integer x = 55
integer y = 464
integer width = 2871
integer height = 240
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Standard format will line up your fields in rows, the number of rows is dependent on the width and number of fields.  It may not be appropriate for screens with group boxes like the Address Screen. "
boolean focusrectangle = false
end type

