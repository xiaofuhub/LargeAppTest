$PBExportHeader$w_npdb_verif_message.srw
forward
global type w_npdb_verif_message from w_response
end type
type st_3 from statictext within w_npdb_verif_message
end type
type st_2 from statictext within w_npdb_verif_message
end type
type st_1 from statictext within w_npdb_verif_message
end type
type cb_rec from commandbutton within w_npdb_verif_message
end type
type cb_2 from commandbutton within w_npdb_verif_message
end type
type cb_send from commandbutton within w_npdb_verif_message
end type
end forward

global type w_npdb_verif_message from w_response
integer width = 2967
integer height = 876
boolean titlebar = false
boolean controlmenu = false
long backcolor = 33551856
st_3 st_3
st_2 st_2
st_1 st_1
cb_rec cb_rec
cb_2 cb_2
cb_send cb_send
end type
global w_npdb_verif_message w_npdb_verif_message

on w_npdb_verif_message.create
int iCurrent
call super::create
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.cb_rec=create cb_rec
this.cb_2=create cb_2
this.cb_send=create cb_send
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.cb_rec
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.cb_send
end on

on w_npdb_verif_message.destroy
call super::destroy
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_rec)
destroy(this.cb_2)
destroy(this.cb_send)
end on

type st_3 from statictext within w_npdb_verif_message
integer x = 50
integer y = 420
integer width = 2843
integer height = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "If you wish to run a receive for this file, Click RECEIVE."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_npdb_verif_message
integer x = 50
integer y = 264
integer width = 2843
integer height = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "If you previously sent this file and received errors that have not been corrected, you should click NO."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_npdb_verif_message
integer x = 41
integer y = 52
integer width = 2843
integer height = 152
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "The NPDB query has previously been sent, but is set to resend.  Do you wish to resend the file to the NPDB?  If so click SEND."
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_rec from commandbutton within w_npdb_verif_message
integer x = 1701
integer y = 632
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "RECEIVE"
end type

event clicked;closewithreturn(parent,1)
end event

type cb_2 from commandbutton within w_npdb_verif_message
integer x = 1266
integer y = 632
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "NO"
boolean default = true
end type

event clicked;closewithreturn(parent,0)
end event

type cb_send from commandbutton within w_npdb_verif_message
integer x = 823
integer y = 632
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "SEND"
end type

event clicked;closewithreturn(parent, 2)
end event

