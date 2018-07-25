$PBExportHeader$w_function_password.srw
forward
global type w_function_password from window
end type
type cb_cancel from commandbutton within w_function_password
end type
type sle_1 from singlelineedit within w_function_password
end type
type st_1 from statictext within w_function_password
end type
type cb_1 from commandbutton within w_function_password
end type
end forward

global type w_function_password from window
integer x = 1056
integer y = 484
integer width = 1253
integer height = 384
windowtype windowtype = response!
long backcolor = 33551856
cb_cancel cb_cancel
sle_1 sle_1
st_1 st_1
cb_1 cb_1
end type
global w_function_password w_function_password

on w_function_password.create
this.cb_cancel=create cb_cancel
this.sle_1=create sle_1
this.st_1=create st_1
this.cb_1=create cb_1
this.Control[]={this.cb_cancel,&
this.sle_1,&
this.st_1,&
this.cb_1}
end on

on w_function_password.destroy
destroy(this.cb_cancel)
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.cb_1)
end on

type cb_cancel from commandbutton within w_function_password
integer x = 864
integer y = 240
integer width = 315
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn(Parent,"")

end event

type sle_1 from singlelineedit within w_function_password
integer x = 55
integer y = 116
integer width = 1125
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean password = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_function_password
integer x = 59
integer y = 28
integer width = 366
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Enter Password"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_function_password
integer x = 507
integer y = 240
integer width = 315
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;String ls_retval

ls_retval = sle_1.Text

//---------Begin Modified by (Appeon)Harry 06.11.2013 for V141 ISG-CLX--------
if IsNull(ls_retval) or ls_retval = "" then
	MessageBox(gnv_app.iapp_object.DisplayName,"Please Enter Password.")
	sle_1.SetFocus()
	Return
end if
//---------End Modfiied ------------------------------------------------------

CloseWithReturn(Parent,ls_retval)

end event

