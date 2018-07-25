$PBExportHeader$w_status_change_message.srw
forward
global type w_status_change_message from w_response
end type
type cb_ok from commandbutton within w_status_change_message
end type
type cb_recred from commandbutton within w_status_change_message
end type
type cb_cancel from commandbutton within w_status_change_message
end type
type st_1 from statictext within w_status_change_message
end type
type st_2 from statictext within w_status_change_message
end type
type st_3 from statictext within w_status_change_message
end type
type st_4 from statictext within w_status_change_message
end type
end forward

global type w_status_change_message from w_response
integer width = 2455
integer height = 1012
long backcolor = 16777215
cb_ok cb_ok
cb_recred cb_recred
cb_cancel cb_cancel
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
end type
global w_status_change_message w_status_change_message

on w_status_change_message.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.cb_recred=create cb_recred
this.cb_cancel=create cb_cancel
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.cb_recred
this.Control[iCurrent+3]=this.cb_cancel
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.st_4
end on

on w_status_change_message.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_recred)
destroy(this.cb_cancel)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
end on

type cb_ok from commandbutton within w_status_change_message
integer x = 1979
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
string text = "OK"
end type

event clicked;closewithreturn(parent,"O")
end event

type cb_recred from commandbutton within w_status_change_message
integer x = 1979
integer y = 624
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Recred"
end type

event clicked;closewithreturn(parent,"R")
end event

type cb_cancel from commandbutton within w_status_change_message
integer x = 1979
integer y = 272
integer width = 343
integer height = 92
integer taborder = 10
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

type st_1 from statictext within w_status_change_message
integer x = 110
integer y = 116
integer width = 2277
integer height = 104
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 16777215
string text = "You are setting the Appointment Status to From Inactive to Active or Pending."
boolean focusrectangle = false
end type

type st_2 from statictext within w_status_change_message
integer x = 110
integer y = 276
integer width = 1769
integer height = 104
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 16777215
string text = "Click Cancel to leave the status as Inactive."
boolean focusrectangle = false
end type

type st_3 from statictext within w_status_change_message
integer x = 110
integer y = 460
integer width = 1769
integer height = 104
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 16777215
string text = "Click OK to to Change the status only."
boolean focusrectangle = false
end type

type st_4 from statictext within w_status_change_message
integer x = 110
integer y = 616
integer width = 1769
integer height = 152
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 16777215
string text = "Click Recred for a Provider that is returning to your organization and  which you wish to recredential."
boolean focusrectangle = false
end type

