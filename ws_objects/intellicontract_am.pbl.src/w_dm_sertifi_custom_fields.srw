$PBExportHeader$w_dm_sertifi_custom_fields.srw
forward
global type w_dm_sertifi_custom_fields from w_response
end type
type sle_1 from singlelineedit within w_dm_sertifi_custom_fields
end type
type st_1 from statictext within w_dm_sertifi_custom_fields
end type
type st_2 from statictext within w_dm_sertifi_custom_fields
end type
type sle_2 from singlelineedit within w_dm_sertifi_custom_fields
end type
type st_3 from statictext within w_dm_sertifi_custom_fields
end type
type sle_3 from singlelineedit within w_dm_sertifi_custom_fields
end type
type cb_ok from commandbutton within w_dm_sertifi_custom_fields
end type
type cb_cancel from commandbutton within w_dm_sertifi_custom_fields
end type
end forward

global type w_dm_sertifi_custom_fields from w_response
integer width = 1573
integer height = 688
string title = "Esign Custom Fields"
long backcolor = 33551856
sle_1 sle_1
st_1 st_1
st_2 st_2
sle_2 sle_2
st_3 st_3
sle_3 sle_3
cb_ok cb_ok
cb_cancel cb_cancel
end type
global w_dm_sertifi_custom_fields w_dm_sertifi_custom_fields

on w_dm_sertifi_custom_fields.create
int iCurrent
call super::create
this.sle_1=create sle_1
this.st_1=create st_1
this.st_2=create st_2
this.sle_2=create sle_2
this.st_3=create st_3
this.sle_3=create sle_3
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.sle_2
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.sle_3
this.Control[iCurrent+7]=this.cb_ok
this.Control[iCurrent+8]=this.cb_cancel
end on

on w_dm_sertifi_custom_fields.destroy
call super::destroy
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.sle_2)
destroy(this.st_3)
destroy(this.sle_3)
destroy(this.cb_ok)
destroy(this.cb_cancel)
end on

event open;call super::open;str_parm lstr_parm

lstr_parm = Message.Powerobjectparm
sle_1.text = lstr_parm.s_array[1]
sle_2.text = lstr_parm.s_array[2]
sle_3.text = lstr_parm.s_array[3]


end event

type sle_1 from singlelineedit within w_dm_sertifi_custom_fields
integer x = 411
integer y = 56
integer width = 1088
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

type st_1 from statictext within w_dm_sertifi_custom_fields
integer x = 32
integer y = 76
integer width = 379
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Custom Field 1: "
boolean focusrectangle = false
end type

type st_2 from statictext within w_dm_sertifi_custom_fields
integer x = 32
integer y = 208
integer width = 379
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Custom Field 2: "
boolean focusrectangle = false
end type

type sle_2 from singlelineedit within w_dm_sertifi_custom_fields
integer x = 411
integer y = 188
integer width = 1088
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

type st_3 from statictext within w_dm_sertifi_custom_fields
integer x = 32
integer y = 340
integer width = 379
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Custom Field 3: "
boolean focusrectangle = false
end type

type sle_3 from singlelineedit within w_dm_sertifi_custom_fields
integer x = 411
integer y = 320
integer width = 1088
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

type cb_ok from commandbutton within w_dm_sertifi_custom_fields
integer x = 782
integer y = 468
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
boolean default = true
end type

event clicked;str_parm lstr_parm

lstr_parm.s_array[1] = sle_1.text 
lstr_parm.s_array[2] = sle_2.text
lstr_parm.s_array[3] = sle_3.text

CloseWithReturn(Parent,lstr_parm)
end event

type cb_cancel from commandbutton within w_dm_sertifi_custom_fields
integer x = 1147
integer y = 468
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn(Parent,0)
end event

