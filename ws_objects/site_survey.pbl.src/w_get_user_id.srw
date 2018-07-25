$PBExportHeader$w_get_user_id.srw
forward
global type w_get_user_id from w_get_survey_name
end type
type st_2 from statictext within w_get_user_id
end type
type st_3 from statictext within w_get_user_id
end type
end forward

global type w_get_user_id from w_get_survey_name
integer y = 776
integer width = 960
string title = "User ID"
st_2 st_2
st_3 st_3
end type
global w_get_user_id w_get_user_id

on w_get_user_id.create
int iCurrent
call super::create
this.st_2=create st_2
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.st_3
end on

on w_get_user_id.destroy
call super::destroy
destroy(this.st_2)
destroy(this.st_3)
end on

type st_1 from w_get_survey_name`st_1 within w_get_user_id
integer width = 379
string text = "User ID"
end type

type sle_1 from w_get_survey_name`sle_1 within w_get_user_id
integer width = 379
end type

type cb_1 from w_get_survey_name`cb_1 within w_get_user_id
integer x = 521
end type

type gb_1 from w_get_survey_name`gb_1 within w_get_user_id
end type

type rb_a from w_get_survey_name`rb_a within w_get_user_id
end type

type rb_c from w_get_survey_name`rb_c within w_get_user_id
end type

type cb_2 from w_get_survey_name`cb_2 within w_get_user_id
end type

type cb_3 from w_get_survey_name`cb_3 within w_get_user_id
end type

type st_2 from statictext within w_get_user_id
integer x = 110
integer y = 240
integer width = 590
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "10 character maximum."
boolean focusrectangle = false
end type

type st_3 from statictext within w_get_user_id
integer x = 110
integer y = 312
integer width = 640
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Default password will be 123."
boolean focusrectangle = false
end type

