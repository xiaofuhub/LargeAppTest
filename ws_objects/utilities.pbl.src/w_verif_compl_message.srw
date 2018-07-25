$PBExportHeader$w_verif_compl_message.srw
forward
global type w_verif_compl_message from window
end type
type st_mess from statictext within w_verif_compl_message
end type
type cb_nall from commandbutton within w_verif_compl_message
end type
type cb_no from commandbutton within w_verif_compl_message
end type
type cb_yall from commandbutton within w_verif_compl_message
end type
type cb_yes from commandbutton within w_verif_compl_message
end type
end forward

global type w_verif_compl_message from window
integer width = 2135
integer height = 784
boolean titlebar = true
string title = "Verifications Completed"
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
st_mess st_mess
cb_nall cb_nall
cb_no cb_no
cb_yall cb_yall
cb_yes cb_yes
end type
global w_verif_compl_message w_verif_compl_message

event open;string ls_mess

ls_mess = message.stringparm

st_mess.text = ls_mess
end event

on w_verif_compl_message.create
this.st_mess=create st_mess
this.cb_nall=create cb_nall
this.cb_no=create cb_no
this.cb_yall=create cb_yall
this.cb_yes=create cb_yes
this.Control[]={this.st_mess,&
this.cb_nall,&
this.cb_no,&
this.cb_yall,&
this.cb_yes}
end on

on w_verif_compl_message.destroy
destroy(this.st_mess)
destroy(this.cb_nall)
destroy(this.cb_no)
destroy(this.cb_yall)
destroy(this.cb_yes)
end on

type st_mess from statictext within w_verif_compl_message
integer x = 123
integer y = 92
integer width = 1851
integer height = 364
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Completed message"
boolean focusrectangle = false
end type

type cb_nall from commandbutton within w_verif_compl_message
integer x = 1591
integer y = 536
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "No for All"
end type

event clicked;closewithreturn(parent,4)
end event

type cb_no from commandbutton within w_verif_compl_message
integer x = 1111
integer y = 536
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "No"
end type

event clicked;closewithreturn(parent,0)
end event

type cb_yall from commandbutton within w_verif_compl_message
integer x = 622
integer y = 536
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Yes for All"
end type

event clicked;closewithreturn(parent,3)
end event

type cb_yes from commandbutton within w_verif_compl_message
integer x = 123
integer y = 536
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Yes"
end type

event clicked;//closewithreturn(parent,0)
closewithreturn(parent,1) //long.zhang 11.02.2012 BugS110101 
end event

