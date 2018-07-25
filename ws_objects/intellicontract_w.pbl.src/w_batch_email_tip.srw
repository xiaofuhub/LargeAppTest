$PBExportHeader$w_batch_email_tip.srw
forward
global type w_batch_email_tip from w_response
end type
type st_1 from statictext within w_batch_email_tip
end type
type st_7 from statictext within w_batch_email_tip
end type
type st_6 from statictext within w_batch_email_tip
end type
type st_5 from statictext within w_batch_email_tip
end type
type st_4 from statictext within w_batch_email_tip
end type
type st_3 from statictext within w_batch_email_tip
end type
type st_2 from statictext within w_batch_email_tip
end type
type cb_1 from commandbutton within w_batch_email_tip
end type
end forward

global type w_batch_email_tip from w_response
integer width = 2011
integer height = 1028
string title = "Batch Email"
long backcolor = 33551856
st_1 st_1
st_7 st_7
st_6 st_6
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
cb_1 cb_1
end type
global w_batch_email_tip w_batch_email_tip

on w_batch_email_tip.create
int iCurrent
call super::create
this.st_1=create st_1
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_7
this.Control[iCurrent+3]=this.st_6
this.Control[iCurrent+4]=this.st_5
this.Control[iCurrent+5]=this.st_4
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.cb_1
end on

on w_batch_email_tip.destroy
call super::destroy
destroy(this.st_1)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.cb_1)
end on

type st_1 from statictext within w_batch_email_tip
integer x = 41
integer y = 40
integer width = 1911
integer height = 124
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "The Batch email feature is used to send an email to the default contact for two or more contract records."
boolean focusrectangle = false
end type

type st_7 from statictext within w_batch_email_tip
integer x = 41
integer y = 628
integer width = 1911
integer height = 164
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Hold the Shift key down and clicking one record and then while still holding the Shift key down select another record and the system will select those records plus any records in between."
boolean focusrectangle = false
end type

type st_6 from statictext within w_batch_email_tip
integer x = 46
integer y = 576
integer width = 1911
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Select a range of records "
boolean focusrectangle = false
end type

type st_5 from statictext within w_batch_email_tip
integer x = 46
integer y = 504
integer width = 1911
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "OR"
boolean focusrectangle = false
end type

type st_4 from statictext within w_batch_email_tip
integer x = 41
integer y = 384
integer width = 1911
integer height = 108
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Hold down the Ctrl Key and clicking on multiple contract records on the browse screen."
boolean focusrectangle = false
end type

type st_3 from statictext within w_batch_email_tip
integer x = 46
integer y = 332
integer width = 1911
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Select multiple records randomly"
boolean focusrectangle = false
end type

type st_2 from statictext within w_batch_email_tip
integer x = 41
integer y = 200
integer width = 1911
integer height = 112
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "To use the Batch Email feature select two or more contract records in the browse screen by doing one of the following:"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_batch_email_tip
integer x = 1595
integer y = 828
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
end type

event clicked;Close(Parent)
end event

