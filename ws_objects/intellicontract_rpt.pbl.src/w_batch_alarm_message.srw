$PBExportHeader$w_batch_alarm_message.srw
forward
global type w_batch_alarm_message from w_response
end type
type st_date_cnt from statictext within w_batch_alarm_message
end type
type st_3 from statictext within w_batch_alarm_message
end type
type st_ctx_cnt from statictext within w_batch_alarm_message
end type
type st_fieldname from statictext within w_batch_alarm_message
end type
type st_warnning from statictext within w_batch_alarm_message
end type
type st_2 from statictext within w_batch_alarm_message
end type
type st_1 from statictext within w_batch_alarm_message
end type
type cb_no from commandbutton within w_batch_alarm_message
end type
type cb_yes from commandbutton within w_batch_alarm_message
end type
end forward

global type w_batch_alarm_message from w_response
integer width = 2053
integer height = 616
boolean titlebar = false
boolean controlmenu = false
long backcolor = 33551856
st_date_cnt st_date_cnt
st_3 st_3
st_ctx_cnt st_ctx_cnt
st_fieldname st_fieldname
st_warnning st_warnning
st_2 st_2
st_1 st_1
cb_no cb_no
cb_yes cb_yes
end type
global w_batch_alarm_message w_batch_alarm_message

on w_batch_alarm_message.create
int iCurrent
call super::create
this.st_date_cnt=create st_date_cnt
this.st_3=create st_3
this.st_ctx_cnt=create st_ctx_cnt
this.st_fieldname=create st_fieldname
this.st_warnning=create st_warnning
this.st_2=create st_2
this.st_1=create st_1
this.cb_no=create cb_no
this.cb_yes=create cb_yes
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_date_cnt
this.Control[iCurrent+2]=this.st_3
this.Control[iCurrent+3]=this.st_ctx_cnt
this.Control[iCurrent+4]=this.st_fieldname
this.Control[iCurrent+5]=this.st_warnning
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.cb_no
this.Control[iCurrent+9]=this.cb_yes
end on

on w_batch_alarm_message.destroy
call super::destroy
destroy(this.st_date_cnt)
destroy(this.st_3)
destroy(this.st_ctx_cnt)
destroy(this.st_fieldname)
destroy(this.st_warnning)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_no)
destroy(this.cb_yes)
end on

event open;call super::open;//====================================================================
// Event: open
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:         Ken.Guo           Date: 01/31/2013
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


str_pass lstr_pass_warnning

lstr_pass_warnning = Message.Powerobjectparm

st_fieldname.text = lstr_pass_warnning.s_string
This.Title = lstr_pass_warnning.s_string
st_date_cnt.text = String(lstr_pass_warnning.s_long[1])
st_ctx_cnt.text = String(lstr_pass_warnning.s_long[2])
st_warnning.text = 'Are you sure you want to continue with batch setting these '+lstr_pass_warnning.s_string+' alarms?'
end event

type st_date_cnt from statictext within w_batch_alarm_message
integer x = 987
integer y = 140
integer width = 928
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 33551856
boolean focusrectangle = false
end type

type st_3 from statictext within w_batch_alarm_message
integer x = 82
integer y = 140
integer width = 933
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "# of Date Alarms to be updated         :"
boolean focusrectangle = false
end type

type st_ctx_cnt from statictext within w_batch_alarm_message
integer x = 1010
integer y = 232
integer width = 928
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 33551856
boolean focusrectangle = false
end type

type st_fieldname from statictext within w_batch_alarm_message
integer x = 951
integer y = 56
integer width = 928
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 33551856
boolean focusrectangle = false
end type

type st_warnning from statictext within w_batch_alarm_message
integer x = 87
integer y = 320
integer width = 1861
integer height = 128
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Are you sure you want to continue with batch setting these Expiration Date alarms?"
boolean focusrectangle = false
end type

type st_2 from statictext within w_batch_alarm_message
integer x = 82
integer y = 232
integer width = 942
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "# of Contract Records to be updated :"
boolean focusrectangle = false
end type

type st_1 from statictext within w_batch_alarm_message
integer x = 82
integer y = 56
integer width = 864
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Date Field Name                                :"
boolean focusrectangle = false
end type

type cb_no from commandbutton within w_batch_alarm_message
integer x = 1641
integer y = 468
integer width = 343
integer height = 100
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&No"
end type

event clicked;CloseWithReturn(Parent, 0)
end event

type cb_yes from commandbutton within w_batch_alarm_message
integer x = 1280
integer y = 468
integer width = 343
integer height = 100
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Yes"
end type

event clicked;CloseWithReturn(Parent, 1)
end event

