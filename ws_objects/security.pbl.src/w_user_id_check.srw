$PBExportHeader$w_user_id_check.srw
forward
global type w_user_id_check from w_response
end type
type cb_cancel from commandbutton within w_user_id_check
end type
type cb_1 from commandbutton within w_user_id_check
end type
type st_3 from statictext within w_user_id_check
end type
type st_2 from statictext within w_user_id_check
end type
type st_name from statictext within w_user_id_check
end type
type sle_user_id from singlelineedit within w_user_id_check
end type
type st_1 from statictext within w_user_id_check
end type
type r_1 from rectangle within w_user_id_check
end type
end forward

global type w_user_id_check from w_response
integer x = 214
integer y = 221
integer width = 2126
integer height = 544
boolean titlebar = false
boolean controlmenu = false
long backcolor = 33551856
cb_cancel cb_cancel
cb_1 cb_1
st_3 st_3
st_2 st_2
st_name st_name
sle_user_id sle_user_id
st_1 st_1
r_1 r_1
end type
global w_user_id_check w_user_id_check

on w_user_id_check.create
int iCurrent
call super::create
this.cb_cancel=create cb_cancel
this.cb_1=create cb_1
this.st_3=create st_3
this.st_2=create st_2
this.st_name=create st_name
this.sle_user_id=create sle_user_id
this.st_1=create st_1
this.r_1=create r_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancel
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.st_name
this.Control[iCurrent+6]=this.sle_user_id
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.r_1
end on

on w_user_id_check.destroy
call super::destroy
destroy(this.cb_cancel)
destroy(this.cb_1)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_name)
destroy(this.sle_user_id)
destroy(this.st_1)
destroy(this.r_1)
end on

event open;call super::open;gs_variable_array lst_list
string ls_name
string ls_user

lst_list = message.powerobjectparm

ls_user = lst_list.as_string[1]
ls_name = lst_list.as_string[2]
sle_user_id.text = ls_user
st_name.text = ls_name

end event

type cb_cancel from commandbutton within w_user_id_check
integer x = 1033
integer y = 404
integer width = 334
integer height = 88
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;
closewithreturn(parent, "Cancel")
end event

type cb_1 from commandbutton within w_user_id_check
integer x = 686
integer y = 404
integer width = 334
integer height = 88
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
end type

event clicked;string s

s = sle_user_id.text

closewithreturn(parent, s)
end event

type st_3 from statictext within w_user_id_check
integer x = 507
integer y = 292
integer width = 279
integer height = 88
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "User Id:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_user_id_check
integer x = 517
integer y = 176
integer width = 279
integer height = 88
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Provider:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_name from statictext within w_user_id_check
integer x = 827
integer y = 176
integer width = 754
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "name"
boolean focusrectangle = false
end type

type sle_user_id from singlelineedit within w_user_id_check
integer x = 832
integer y = 288
integer width = 402
integer height = 84
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

type st_1 from statictext within w_user_id_check
integer x = 119
integer y = 44
integer width = 1925
integer height = 88
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "The user name below already exists in the system. Please enter a different one."
boolean focusrectangle = false
end type

type r_1 from rectangle within w_user_id_check
integer linethickness = 6
long fillcolor = 33551856
integer width = 2117
integer height = 536
end type

