$PBExportHeader$w_custom_help.srw
forward
global type w_custom_help from w_response
end type
type p_1 from picture within w_custom_help
end type
type cbx_flag from checkbox within w_custom_help
end type
type cb_2 from commandbutton within w_custom_help
end type
type cb_1 from commandbutton within w_custom_help
end type
type mle_1 from multilineedit within w_custom_help
end type
end forward

global type w_custom_help from w_response
integer width = 2350
integer height = 508
boolean titlebar = false
boolean controlmenu = false
long backcolor = 33551856
p_1 p_1
cbx_flag cbx_flag
cb_2 cb_2
cb_1 cb_1
mle_1 mle_1
end type
global w_custom_help w_custom_help

on w_custom_help.create
int iCurrent
call super::create
this.p_1=create p_1
this.cbx_flag=create cbx_flag
this.cb_2=create cb_2
this.cb_1=create cb_1
this.mle_1=create mle_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
this.Control[iCurrent+2]=this.cbx_flag
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.mle_1
end on

on w_custom_help.destroy
call super::destroy
destroy(this.p_1)
destroy(this.cbx_flag)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.mle_1)
end on

type p_1 from picture within w_custom_help
integer x = 46
integer y = 40
integer width = 174
integer height = 152
boolean originalsize = true
string picturename = "quest.bmp"
boolean focusrectangle = false
end type

type cbx_flag from checkbox within w_custom_help
integer x = 46
integer y = 264
integer width = 777
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Don~'t show this again."
end type

event clicked;
if this.checked then
	SetProfileString(gs_IniFilePathName, "setup", "dispaly-message", "1")
else
	SetProfileString(gs_IniFilePathName, "setup", "dispaly-message", "0")
end if
end event

type cb_2 from commandbutton within w_custom_help
integer x = 1120
integer y = 372
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn(parent,"CANCEL")
end event

type cb_1 from commandbutton within w_custom_help
integer x = 745
integer y = 372
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
boolean default = true
end type

event clicked;CloseWithReturn(parent,"OK")
end event

type mle_1 from multilineedit within w_custom_help
integer x = 311
integer y = 68
integer width = 2011
integer height = 148
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "To email a document AND Check Out the document at the same time please use the Check Out option. "
boolean border = false
end type

