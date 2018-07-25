$PBExportHeader$w_call_log_settings.srw
forward
global type w_call_log_settings from w_popup
end type
type cb_2 from commandbutton within w_call_log_settings
end type
type cb_1 from commandbutton within w_call_log_settings
end type
type dw_1 from u_dw within w_call_log_settings
end type
end forward

global type w_call_log_settings from w_popup
integer width = 1541
integer height = 1020
string title = "Contact Log Settings"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
long backcolor = 33551856
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_call_log_settings w_call_log_settings

on w_call_log_settings.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_1
end on

on w_call_log_settings.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;call super::open;long r

dw_1.settransobject(sqlca)
r = dw_1.retrieve()

if r = 0 then
	dw_1.insertrow(1)
	dw_1.setitem(1, "issue_cat_1" ,"Claim")
	dw_1.setitem(1, "issue_cat_2" ,"Payor")
	dw_1.setitem(1, "issue_cat_3" ,"Provider")
	dw_1.setitem(1, "issue_cat_4" ,"Information")
	dw_1.setitem(1, "issue_cat_5" ,"Other")
end if
end event

type cb_2 from commandbutton within w_call_log_settings
integer x = 334
integer y = 784
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
end type

event clicked;dw_1.update()
close(parent)
end event

type cb_1 from commandbutton within w_call_log_settings
integer x = 750
integer y = 784
integer width = 343
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

event clicked;close(parent)
end event

type dw_1 from u_dw within w_call_log_settings
integer width = 1499
integer height = 760
integer taborder = 10
string dataobject = "d_call_log_settings"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

