$PBExportHeader$w_security_set_user.srw
forward
global type w_security_set_user from window
end type
type sle_user from singlelineedit within w_security_set_user
end type
type rb_manual from radiobutton within w_security_set_user
end type
type cb_2 from commandbutton within w_security_set_user
end type
type cb_1 from commandbutton within w_security_set_user
end type
type rb_npi from radiobutton within w_security_set_user
end type
type rb_ssn from radiobutton within w_security_set_user
end type
type rb_id from radiobutton within w_security_set_user
end type
type rb_first from radiobutton within w_security_set_user
end type
type rb_last from radiobutton within w_security_set_user
end type
type gb_1 from groupbox within w_security_set_user
end type
end forward

global type w_security_set_user from window
integer width = 891
integer height = 900
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
sle_user sle_user
rb_manual rb_manual
cb_2 cb_2
cb_1 cb_1
rb_npi rb_npi
rb_ssn rb_ssn
rb_id rb_id
rb_first rb_first
rb_last rb_last
gb_1 gb_1
end type
global w_security_set_user w_security_set_user

type variables
string is_user
long il_prac
end variables

on w_security_set_user.create
this.sle_user=create sle_user
this.rb_manual=create rb_manual
this.cb_2=create cb_2
this.cb_1=create cb_1
this.rb_npi=create rb_npi
this.rb_ssn=create rb_ssn
this.rb_id=create rb_id
this.rb_first=create rb_first
this.rb_last=create rb_last
this.gb_1=create gb_1
this.Control[]={this.sle_user,&
this.rb_manual,&
this.cb_2,&
this.cb_1,&
this.rb_npi,&
this.rb_ssn,&
this.rb_id,&
this.rb_first,&
this.rb_last,&
this.gb_1}
end on

on w_security_set_user.destroy
destroy(this.sle_user)
destroy(this.rb_manual)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.rb_npi)
destroy(this.rb_ssn)
destroy(this.rb_id)
destroy(this.rb_first)
destroy(this.rb_last)
destroy(this.gb_1)
end on

event open;string ls_mess
integer p

ls_mess = message.stringparm

p = pos(ls_mess,"@",1)

is_user= (mid(ls_mess, 1, p -1))
il_prac = long(mid(ls_mess,  p +1, len(ls_mess) - p)) 

end event

type sle_user from singlelineedit within w_security_set_user
integer x = 411
integer y = 552
integer width = 421
integer height = 80
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

event getfocus;rb_manual.checked = true
end event

type rb_manual from radiobutton within w_security_set_user
integer x = 114
integer y = 556
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Manual"
end type

type cb_2 from commandbutton within w_security_set_user
integer x = 439
integer y = 760
integer width = 343
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;closewithreturn(parent,"CANCEL")
end event

type cb_1 from commandbutton within w_security_set_user
integer x = 91
integer y = 760
integer width = 343
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
end type

event clicked;//Start Code Change ----01.26.2012 #V12 maha - created
string ls_type
string s
integer p //maha 09.23.2014

if rb_last.checked then
	ls_type = "LASTI"
elseif rb_first.checked then
	ls_type = "ILAST"
elseif rb_ssn.checked then
	ls_type = "SSN6"
elseif rb_id.checked then
	ls_type = "PROVID"
elseif rb_npi.checked then
	ls_type = "NPI"
elseif rb_manual.checked then   //maha 09.24.2014 - added
	ls_type = "MAN"	
end if


//Start Code Change ----09.24.2014 #V14.2 maha - added manual option and trap for existing username
if ls_type = "MAN" then
	s = sle_user.text
	if len(s) < 1 then
		messagebox("Manual user name","There is no user name entered.")
		return
	elseif len(s) > 12 then
		messagebox("Manual user name","User name cannot be longer than 12 characters.")
		return
	end if
else
	s = of_create_password( ls_type, il_prac , is_user)
end if

 //Start Code Change ----04.29.2015 #V15 maha = removed forced to upper
//s = upper(s)

select count(upper(user_id)) into :p from security_users where user_id = upper(:s);
if p > 0 then
	messagebox("User exists","The user name (" + s + ") currently exists.  Please manually enter another one or choose a different option.")
	return
end if
 //End Code Change ----04.29.2015
//Start Code Change ----09.24.2014

if s = "-1" then
	messagebox("Format failed","Record Data may not be available for the selected format.")
else
	closewithreturn(parent,s)
end if
end event

type rb_npi from radiobutton within w_security_set_user
integer x = 114
integer y = 464
integer width = 361
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "NPI number"
end type

type rb_ssn from radiobutton within w_security_set_user
integer x = 114
integer y = 368
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "First 6 SSN"
end type

type rb_id from radiobutton within w_security_set_user
integer x = 114
integer y = 272
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Provider Id"
end type

type rb_first from radiobutton within w_security_set_user
integer x = 114
integer y = 92
integer width = 654
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "First initial + Last name"
boolean checked = true
end type

type rb_last from radiobutton within w_security_set_user
integer x = 114
integer y = 176
integer width = 635
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Last name + first initial"
end type

type gb_1 from groupbox within w_security_set_user
integer x = 23
integer y = 16
integer width = 832
integer height = 692
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "Select Format (max 12 characters)"
end type

