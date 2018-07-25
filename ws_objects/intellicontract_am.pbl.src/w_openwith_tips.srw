$PBExportHeader$w_openwith_tips.srw
forward
global type w_openwith_tips from w_response
end type
type p_1 from picture within w_openwith_tips
end type
type mle_1 from multilineedit within w_openwith_tips
end type
type cbx_tips from checkbox within w_openwith_tips
end type
type cb_ok from commandbutton within w_openwith_tips
end type
end forward

global type w_openwith_tips from w_response
integer width = 1851
integer height = 600
boolean titlebar = false
boolean controlmenu = false
long backcolor = 33551856
p_1 p_1
mle_1 mle_1
cbx_tips cbx_tips
cb_ok cb_ok
end type
global w_openwith_tips w_openwith_tips

on w_openwith_tips.create
int iCurrent
call super::create
this.p_1=create p_1
this.mle_1=create mle_1
this.cbx_tips=create cbx_tips
this.cb_ok=create cb_ok
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
this.Control[iCurrent+2]=this.mle_1
this.Control[iCurrent+3]=this.cbx_tips
this.Control[iCurrent+4]=this.cb_ok
end on

on w_openwith_tips.destroy
call super::destroy
destroy(this.p_1)
destroy(this.mle_1)
destroy(this.cbx_tips)
destroy(this.cb_ok)
end on

event open;call super::open;gb_openwith_showtips = False

mle_1.text = 'When using default program to open a document, any change to the document made by the default program will not be saved in IntelliSoft system. ~r~nIf you want to make change to a document and then save the change in IntelliSoft system, please open it inside IntelliSoft or use the Check Out and Check In functions.'
end event

type p_1 from picture within w_openwith_tips
integer x = 59
integer y = 60
integer width = 174
integer height = 152
boolean originalsize = true
string picturename = "info.bmp"
boolean focusrectangle = false
end type

type mle_1 from multilineedit within w_openwith_tips
integer x = 279
integer y = 56
integer width = 1509
integer height = 360
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "When using default program to pen a document, any change to the document made by the default program will not be saved in IntelContract system. ~~r~~nIf you want to make change to a document and then save the change in IntelliContract system, please use .."
boolean border = false
boolean displayonly = true
end type

type cbx_tips from checkbox within w_openwith_tips
integer x = 50
integer y = 448
integer width = 718
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Don~'t show this again"
boolean checked = true
end type

event clicked;gb_openwith_showtips = Not This.checked
end event

type cb_ok from commandbutton within w_openwith_tips
integer x = 1413
integer y = 448
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean cancel = true
boolean default = true
end type

event clicked;Close(Parent)
end event

