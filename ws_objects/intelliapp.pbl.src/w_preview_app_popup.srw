$PBExportHeader$w_preview_app_popup.srw
forward
global type w_preview_app_popup from w_preview_app
end type
type rb_email from radiobutton within w_preview_app_popup
end type
type rb_fax from radiobutton within w_preview_app_popup
end type
type rb_print from radiobutton within w_preview_app_popup
end type
type cb_1 from commandbutton within w_preview_app_popup
end type
type gb_1 from groupbox within w_preview_app_popup
end type
end forward

global type w_preview_app_popup from w_preview_app
integer width = 4992
integer height = 2576
boolean minbox = true
boolean resizable = true
windowtype windowtype = popup!
rb_email rb_email
rb_fax rb_fax
rb_print rb_print
cb_1 cb_1
gb_1 gb_1
end type
global w_preview_app_popup w_preview_app_popup

on w_preview_app_popup.create
int iCurrent
call super::create
this.rb_email=create rb_email
this.rb_fax=create rb_fax
this.rb_print=create rb_print
this.cb_1=create cb_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_email
this.Control[iCurrent+2]=this.rb_fax
this.Control[iCurrent+3]=this.rb_print
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.gb_1
end on

on w_preview_app_popup.destroy
call super::destroy
destroy(this.rb_email)
destroy(this.rb_fax)
destroy(this.rb_print)
destroy(this.cb_1)
destroy(this.gb_1)
end on

type cb_resize from w_preview_app`cb_resize within w_preview_app_popup
integer y = 160
end type

type uo_1 from w_preview_app`uo_1 within w_preview_app_popup
integer y = 144
end type

type uo_prac from w_preview_app`uo_prac within w_preview_app_popup
integer y = 172
end type

type rb_email from radiobutton within w_preview_app_popup
integer x = 91
integer y = 64
integer width = 411
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
string text = "Email Provider"
end type

type rb_fax from radiobutton within w_preview_app_popup
integer x = 558
integer y = 64
integer width = 402
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
string text = "Fax Provider"
end type

type rb_print from radiobutton within w_preview_app_popup
integer x = 987
integer y = 64
integer width = 270
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
string text = "Print"
boolean checked = true
end type

type cb_1 from commandbutton within w_preview_app_popup
integer x = 1317
integer y = 44
integer width = 402
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Process"
end type

event clicked;//Start Code Change ----06.17.2016 #V152 maha - added
if rb_print.checked then
	uo_1.of_print( )
elseif rb_email.checked then
	uo_1.of_email_fax( "E")
elseif	rb_fax.checked then
	uo_1.of_email_fax( "F")
end if



end event

type gb_1 from groupbox within w_preview_app_popup
integer x = 14
integer y = 8
integer width = 1728
integer height = 140
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Action"
end type

