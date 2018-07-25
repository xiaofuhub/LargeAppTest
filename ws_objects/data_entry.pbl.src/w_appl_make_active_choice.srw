$PBExportHeader$w_appl_make_active_choice.srw
forward
global type w_appl_make_active_choice from w_response
end type
type st_1 from statictext within w_appl_make_active_choice
end type
type cb_3 from commandbutton within w_appl_make_active_choice
end type
type cb_2 from commandbutton within w_appl_make_active_choice
end type
type cb_1 from commandbutton within w_appl_make_active_choice
end type
end forward

global type w_appl_make_active_choice from w_response
integer x = 214
integer y = 221
integer width = 1403
integer height = 620
boolean titlebar = false
boolean controlmenu = false
long backcolor = 33551856
st_1 st_1
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
end type
global w_appl_make_active_choice w_appl_make_active_choice

event open;call super::open;//Start Code Change ----07.12.2016 #V152 maha - added
string s
string ls_text

s = message.stringparm

if s = "Active" then
	ls_text = "Which Record(s) do you want to make Active?"
else
	ls_text = "Which Record(s) do you want to make Inactive?"
end if

st_1.text = ls_text
end event

on w_appl_make_active_choice.create
int iCurrent
call super::create
this.st_1=create st_1
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.cb_3
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_1
end on

on w_appl_make_active_choice.destroy
call super::destroy
destroy(this.st_1)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
end on

type st_1 from statictext within w_appl_make_active_choice
integer x = 123
integer y = 48
integer width = 1216
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "Which Record(s) do you want to make inactive?"
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_appl_make_active_choice
integer x = 475
integer y = 432
integer width = 402
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;closewithreturn(parent, 0)
end event

type cb_2 from commandbutton within w_appl_make_active_choice
integer x = 73
integer y = 304
integer width = 1262
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "The Tracking record and all connected Actions"
end type

event clicked;closewithreturn(parent, 2)
end event

type cb_1 from commandbutton within w_appl_make_active_choice
integer x = 73
integer y = 176
integer width = 1262
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "The Current Action Record"
end type

event clicked;closewithreturn(parent, 1)
end event

