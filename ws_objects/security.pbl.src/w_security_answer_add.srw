$PBExportHeader$w_security_answer_add.srw
forward
global type w_security_answer_add from window
end type
type cb_2 from commandbutton within w_security_answer_add
end type
type st_1 from statictext within w_security_answer_add
end type
type sle_1 from singlelineedit within w_security_answer_add
end type
type cb_1 from commandbutton within w_security_answer_add
end type
end forward

global type w_security_answer_add from window
integer width = 2048
integer height = 432
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
st_1 st_1
sle_1 sle_1
cb_1 cb_1
end type
global w_security_answer_add w_security_answer_add

type variables
n_cst_encrypt invo_encrypt  
end variables

on w_security_answer_add.create
this.cb_2=create cb_2
this.st_1=create st_1
this.sle_1=create sle_1
this.cb_1=create cb_1
this.Control[]={this.cb_2,&
this.st_1,&
this.sle_1,&
this.cb_1}
end on

on w_security_answer_add.destroy
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.cb_1)
end on

type cb_2 from commandbutton within w_security_answer_add
integer x = 1065
integer y = 260
integer width = 334
integer height = 80
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;closewithreturn(parent, "Cancel")
end event

type st_1 from statictext within w_security_answer_add
integer x = 64
integer y = 24
integer width = 402
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Enter Answer"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_security_answer_add
integer x = 59
integer y = 104
integer width = 1915
integer height = 96
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
integer limit = 50
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_security_answer_add
integer x = 690
integer y = 260
integer width = 334
integer height = 80
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
end type

event clicked;string s
integer res

s = sle_1.text

if len(s) < 1 then
	res = messagebox("","You have not entered an answer?  Do you want to cancel?", question!,yesno!, 2)
	if res = 2 then
		closewithreturn(parent, "Cancel")
	else
		return
	end if
end if
	
//s = invo_encrypt.of_encrypt( s )
s = invo_encrypt.of_encrypt( s, true )  //(V15.2 WV Security Questions) alfee 12.30.2016

closewithreturn(parent, s)
		

end event

