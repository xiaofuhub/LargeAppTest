$PBExportHeader$w_forgot_password_test.srw
forward
global type w_forgot_password_test from window
end type
type st_4 from statictext within w_forgot_password_test
end type
type st_3 from statictext within w_forgot_password_test
end type
type st_2 from statictext within w_forgot_password_test
end type
type st_1 from statictext within w_forgot_password_test
end type
type sle_auth from singlelineedit within w_forgot_password_test
end type
type sle_message from singlelineedit within w_forgot_password_test
end type
type sle_subject from singlelineedit within w_forgot_password_test
end type
type sle_email from singlelineedit within w_forgot_password_test
end type
end forward

global type w_forgot_password_test from window
integer width = 2222
integer height = 1076
boolean titlebar = true
string title = "Forgot password test"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
sle_auth sle_auth
sle_message sle_message
sle_subject sle_subject
sle_email sle_email
end type
global w_forgot_password_test w_forgot_password_test

on w_forgot_password_test.create
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.sle_auth=create sle_auth
this.sle_message=create sle_message
this.sle_subject=create sle_subject
this.sle_email=create sle_email
this.Control[]={this.st_4,&
this.st_3,&
this.st_2,&
this.st_1,&
this.sle_auth,&
this.sle_message,&
this.sle_subject,&
this.sle_email}
end on

on w_forgot_password_test.destroy
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_auth)
destroy(this.sle_message)
destroy(this.sle_subject)
destroy(this.sle_email)
end on

event open;string ls_email
string ls_pass
string ls_subject
string ls_message
string s
string ls_test
string ls_auth
integer p
n_cst_encrypt luo_encrypt
gs_pass_ids lst_pass


lst_pass = message.powerobjectparm

//get passed values
ls_subject = lst_pass.s_fax_subject
ls_message = lst_pass.s_fax_message 
ls_email	= lst_pass.s_fax_recipient 
ls_auth = lst_pass.s_fax_company
ls_pass = lst_pass.s_fax_fax_number

//decrypt email and password
ls_pass = luo_encrypt.of_decrypt( ls_pass)
ls_email = luo_encrypt.of_decrypt( ls_email)

ls_test = luo_encrypt.of_encrypt2( ls_pass, ls_email)

if ls_test <> ls_auth then
	messagebox("Authorization Failed", ls_test)
end if

p = pos(ls_message,"PASSWORD", 1)
ls_message = mid(ls_message, 1, p - 1) + ls_pass + mid(ls_message, p + 8)

sle_subject.text = ls_subject
sle_message.text = ls_message
sle_email.text = ls_email
sle_auth.text = ls_auth
end event

type st_4 from statictext within w_forgot_password_test
integer x = 82
integer y = 756
integer width = 430
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Authorization key"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_forgot_password_test
integer x = 110
integer y = 408
integer width = 402
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Message"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_forgot_password_test
integer x = 110
integer y = 236
integer width = 402
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Subject"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_forgot_password_test
integer x = 169
integer y = 96
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Email Address"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_auth from singlelineedit within w_forgot_password_test
integer x = 544
integer y = 728
integer width = 1385
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_message from singlelineedit within w_forgot_password_test
integer x = 544
integer y = 364
integer width = 1390
integer height = 252
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_subject from singlelineedit within w_forgot_password_test
integer x = 544
integer y = 220
integer width = 1385
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_email from singlelineedit within w_forgot_password_test
integer x = 544
integer y = 84
integer width = 1381
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

