$PBExportHeader$w_survey_email.srw
forward
global type w_survey_email from window
end type
type dw_1 from datawindow within w_survey_email
end type
type st_3 from statictext within w_survey_email
end type
type sle_email from singlelineedit within w_survey_email
end type
type cb_2 from commandbutton within w_survey_email
end type
type cb_1 from commandbutton within w_survey_email
end type
type st_2 from statictext within w_survey_email
end type
type mle_mess from multilineedit within w_survey_email
end type
type st_1 from statictext within w_survey_email
end type
type sle_sub from singlelineedit within w_survey_email
end type
end forward

global type w_survey_email from window
integer x = 425
integer y = 368
integer width = 2569
integer height = 2112
boolean titlebar = true
string title = "Email Data"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
dw_1 dw_1
st_3 st_3
sle_email sle_email
cb_2 cb_2
cb_1 cb_1
st_2 st_2
mle_mess mle_mess
st_1 st_1
sle_sub sle_sub
end type
global w_survey_email w_survey_email

on w_survey_email.create
this.dw_1=create dw_1
this.st_3=create st_3
this.sle_email=create sle_email
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_2=create st_2
this.mle_mess=create mle_mess
this.st_1=create st_1
this.sle_sub=create sle_sub
this.Control[]={this.dw_1,&
this.st_3,&
this.sle_email,&
this.cb_2,&
this.cb_1,&
this.st_2,&
this.mle_mess,&
this.st_1,&
this.sle_sub}
end on

on w_survey_email.destroy
destroy(this.dw_1)
destroy(this.st_3)
destroy(this.sle_email)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.mle_mess)
destroy(this.st_1)
destroy(this.sle_sub)
end on

event open;

sle_sub.text = "Survey export"

mle_mess.text = "Attached are survey files to be imported into IntelliSite.~r~rTo import, copy the attached files into the IntelliSite/imports folder on your C drive."
end event

type dw_1 from datawindow within w_survey_email
integer x = 96
integer y = 156
integer width = 471
integer height = 104
integer taborder = 20
string dataobject = "d_select_user_for_audit_trail"
boolean border = false
boolean livescroll = true
end type

event constructor;This.SetTransObject( SQLCA )
This.InsertRow( 1 )
end event

event itemchanged;string ls_user
string ls_email

ls_user = data

SELECT email_id INTO :ls_email FROM security_users WHERE user_id = :ls_user;

sle_email.text = ls_email
end event

type st_3 from statictext within w_survey_email
integer x = 105
integer y = 56
integer width = 1591
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Select User name or enter email address."
boolean focusrectangle = false
end type

type sle_email from singlelineedit within w_survey_email
integer x = 594
integer y = 156
integer width = 1467
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_survey_email
integer x = 2226
integer y = 1900
integer width = 279
integer height = 88
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn( Parent, "Cancel" )
end event

type cb_1 from commandbutton within w_survey_email
integer x = 1879
integer y = 1900
integer width = 279
integer height = 88
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
end type

event clicked;if sle_email.Text = "" then
	MessageBox("Email Address","Please enter a valid email address")
	Return		//Added by Scofield on 2008-04-29
end if

CloseWithReturn( Parent, sle_email.Text + "*" + sle_sub.text + "**" + mle_mess.Text )

end event

type st_2 from statictext within w_survey_email
integer x = 96
integer y = 436
integer width = 238
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Message:"
boolean focusrectangle = false
end type

type mle_mess from multilineedit within w_survey_email
integer x = 59
integer y = 504
integer width = 2446
integer height = 1364
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_survey_email
integer x = 87
integer y = 312
integer width = 210
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Subject:"
boolean focusrectangle = false
end type

type sle_sub from singlelineedit within w_survey_email
integer x = 315
integer y = 300
integer width = 1742
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

