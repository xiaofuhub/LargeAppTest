$PBExportHeader$w_iapp_fix_login.srw
forward
global type w_iapp_fix_login from w_get_lookup_name
end type
type cb_c from commandbutton within w_iapp_fix_login
end type
type st_2 from statictext within w_iapp_fix_login
end type
type st_3 from statictext within w_iapp_fix_login
end type
end forward

global type w_iapp_fix_login from w_get_lookup_name
integer x = 713
integer y = 664
integer width = 2350
integer height = 564
string title = "Iapp Fix Login"
cb_c cb_c
st_2 st_2
st_3 st_3
end type
global w_iapp_fix_login w_iapp_fix_login

on w_iapp_fix_login.create
int iCurrent
call super::create
this.cb_c=create cb_c
this.st_2=create st_2
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_c
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.st_3
end on

on w_iapp_fix_login.destroy
call super::destroy
destroy(this.cb_c)
destroy(this.st_2)
destroy(this.st_3)
end on

type st_1 from w_get_lookup_name`st_1 within w_iapp_fix_login
integer x = 215
integer y = 40
integer width = 1838
integer height = 104
integer textsize = -10
integer weight = 700
long textcolor = 128
string text = "This function is intended only for specially trained users."
end type

type sle_1 from w_get_lookup_name`sle_1 within w_iapp_fix_login
integer x = 183
integer y = 352
integer width = 1097
integer height = 96
end type

type cb_1 from w_get_lookup_name`cb_1 within w_iapp_fix_login
integer x = 1417
integer y = 368
end type

event cb_1::clicked;String ls_retval


ls_retval = sle_1.Text 


CloseWithReturn(Parent, ls_retval )
end event

type gb_1 from w_get_lookup_name`gb_1 within w_iapp_fix_login
boolean visible = false
integer x = 197
integer y = 592
string facename = "Segoe UI"
end type

type rb_a from w_get_lookup_name`rb_a within w_iapp_fix_login
boolean visible = false
integer x = 279
integer y = 672
string facename = "Segoe UI"
end type

type rb_c from w_get_lookup_name`rb_c within w_iapp_fix_login
boolean visible = false
integer x = 951
integer y = 676
string facename = "Segoe UI"
end type

type cb_2 from w_get_lookup_name`cb_2 within w_iapp_fix_login
integer x = 1815
integer y = 364
integer width = 325
integer height = 88
string text = "Cancel"
end type

type cb_3 from w_get_lookup_name`cb_3 within w_iapp_fix_login
boolean visible = false
integer x = 1504
integer y = 676
end type

type cb_c from commandbutton within w_iapp_fix_login
integer x = 1815
integer y = 368
integer width = 325
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;String ls_retval


ls_retval = "cancel" 


CloseWithReturn(Parent, ls_retval )
end event

type st_2 from statictext within w_iapp_fix_login
integer x = 384
integer y = 160
integer width = 1504
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
boolean enabled = false
string text = "Improper use will damage trained applications."
boolean focusrectangle = false
end type

type st_3 from statictext within w_iapp_fix_login
integer x = 197
integer y = 268
integer width = 512
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Enter password"
boolean focusrectangle = false
end type

