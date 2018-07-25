$PBExportHeader$w_get_app_name.srw
forward
global type w_get_app_name from w_popup
end type
type sle_name from singlelineedit within w_get_app_name
end type
type st_1 from statictext within w_get_app_name
end type
type cb_apply from commandbutton within w_get_app_name
end type
type cb_close from commandbutton within w_get_app_name
end type
end forward

global type w_get_app_name from w_popup
integer x = 1120
integer y = 452
integer width = 1787
integer height = 508
string title = "Enter Application name"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 33551856
sle_name sle_name
st_1 st_1
cb_apply cb_apply
cb_close cb_close
end type
global w_get_app_name w_get_app_name

type variables
olecustomcontrol io_image_edit

String is_object_name
end variables

on w_get_app_name.create
int iCurrent
call super::create
this.sle_name=create sle_name
this.st_1=create st_1
this.cb_apply=create cb_apply
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_name
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_apply
this.Control[iCurrent+4]=this.cb_close
end on

on w_get_app_name.destroy
call super::destroy
destroy(this.sle_name)
destroy(this.st_1)
destroy(this.cb_apply)
destroy(this.cb_close)
end on

event open;call super::open;is_object_name = "Label-" + String( today() ) + String( Now())
end event

type sle_name from singlelineedit within w_get_app_name
integer x = 59
integer y = 108
integer width = 1317
integer height = 92
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_get_app_name
integer x = 59
integer y = 40
integer width = 352
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
string text = "App Name"
boolean focusrectangle = false
end type

type cb_apply from commandbutton within w_get_app_name
integer x = 1440
integer y = 104
integer width = 247
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;IF  sle_name.Text = "" or IsNull(  sle_name.Text ) THEN
	MessageBox("Invalid Name", "You must enter a name for multi app.")
	Return
END IF

CloseWithReturn( Parent, sle_name.Text )
end event

type cb_close from commandbutton within w_get_app_name
integer x = 1440
integer y = 232
integer width = 247
integer height = 92
integer taborder = 30
boolean bringtotop = true
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

